# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 5/10
- Mensagem: Teste de formulario falhou com exit code 1.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-10-15 00:14:48] [INFO] === VFP EXECUTOR v2.0 ===
[2026-10-15 00:14:48] [INFO] Config FPW: (nao fornecido)
[2026-10-15 00:14:48] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-15 00:14:48] [INFO] Timeout: 300 segundos
[2026-10-15 00:14:48] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3sovszza.prg
[2026-10-15 00:14:48] [INFO] Conteudo do wrapper:
[2026-10-15 00:14:48] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSIGPRINT', 'C:\4c\tasks\task631\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSIGPRINT', 'C:\4c\tasks\task631\logs\06_testForm.log'
QUIT

[2026-10-15 00:14:48] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3sovszza.prg
[2026-10-15 00:14:48] [INFO] VFP output esperado em: C:\4c\tasks\task631\vfp_output.txt
[2026-10-15 00:14:48] [INFO] Executando Visual FoxPro 9...
[2026-10-15 00:14:48] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3sovszza.prg
[2026-10-15 00:14:48] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3sovszza.prg
[2026-10-15 00:14:48] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSIGPRINT
Inicio: 15/10/2026 00:14:49

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 15/10/2026 09:02:41
Duracao: 31672 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-10-15 09:02:41] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-10-15 09:02:41] [INFO] VFP9 finalizado em 31672.9380171 segundos
[2026-10-15 09:02:41] [INFO] Exit Code: 
[2026-10-15 09:02:41] [INFO] 
[2026-10-15 09:02:41] [INFO] Arquivos temporarios preservados para inspecao:
[2026-10-15 09:02:41] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3sovszza.prg
[2026-10-15 09:02:41] [INFO] 
[2026-10-15 09:02:41] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-10-15 09:02:41] [INFO] * Auto-generated wrapper for parameters
[2026-10-15 09:02:41] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-15 09:02:41] [INFO] * Parameters: 'FormSIGPRINT', 'C:\4c\tasks\task631\logs\06_testForm.log'
[2026-10-15 09:02:41] [INFO] 
[2026-10-15 09:02:41] [INFO] * Anti-dialog protections for unattended execution
[2026-10-15 09:02:41] [INFO] SET SAFETY OFF
[2026-10-15 09:02:41] [INFO] SET RESOURCE OFF
[2026-10-15 09:02:41] [INFO] SET TALK OFF
[2026-10-15 09:02:41] [INFO] SET NOTIFY OFF
[2026-10-15 09:02:41] [INFO] SYS(2335, 0)
[2026-10-15 09:02:41] [INFO] 
[2026-10-15 09:02:41] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSIGPRINT', 'C:\4c\tasks\task631\logs\06_testForm.log'
[2026-10-15 09:02:41] [INFO] QUIT
[2026-10-15 09:02:41] [INFO] 
[2026-10-15 09:02:41] [INFO] === Fim do Wrapper.prg ===
[2026-10-15 09:02:41] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\cadastros\FormSIGPRINT.prg):
*==============================================================================
* FormSIGPRINT.prg - Formulario de Cadastro de Instrucoes
* Migrado de: SIGPRINT.SCX (frmcadastro)
*==============================================================================

DEFINE CLASS FormSIGPRINT AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: Height/Width/Caption EXATOS do original)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Instru" + CHR(231) + CHR(245) + "es"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *===========================================================================
    * Init - Inicializa o formulario
    * REGRA CRITICA: Apenas RETURN DODEFAULT()
    * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
    *===========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *===========================================================================
    * InicializarForm - Configura estrutura completa
    * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
    *===========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SIGPRINTBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar SIGPRINTBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormSIGPRINT.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Visible    = .T.

                *-- Popula a grade da Lista. No legado isso esta no proprio
                *-- Init (SCAN em crSigOpIns alimentando csSigOpIns + bind das
                *-- 3 colunas da Grade), e os botoes Alterar/Visualizar/Excluir
                *-- leem a linha corrente de cursor_4c_Dados - sem esta carga a
                *-- Lista abre vazia e nenhum deles acha registro.
                *-- Falha de carga NAO impede a tela de abrir (padrao FormCor):
                *-- CarregarLista ja reporta o erro por conta propria.
                THIS.CarregarLista()

                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormSIGPRINT:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormSIGPRINT.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * Top=-29 para esconder abas; controles compensam +29 no Top
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .PageCount = 2
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .Tabs      = .F.
            .Visible   = .T.

            .Page1.Caption   = "Lista"
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)

            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaLista - Page1: faixa de cabecalho + 5 botoes CRUD
    * (Grupo_op) + Encerrar (Grupo_Saida) + grd_4c_Lista (Grade)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (cntSombra no legado) - CLAUDE.md regra #11
        *-- Original: Top=1. Com compensacao +29: Top=31
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = THIS.Caption
            .Top       = 15
            .Left      = 10
            .Width     = 769
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = THIS.Caption
            .Top       = 18
            .Left      = 10
            .Width     = 769
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container Botoes CRUD (Grupo_op no legado) - canonico: Left=542, Top=29
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("cmd_4c_Incluir", "CommandButton")
            WITH .cmd_4c_Incluir
                .Caption         = "Incluir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            = 5
                .Width           = 75
                .Height          = 75
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Comic Sans MS"
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

            .AddObject("cmd_4c_Visualizar", "CommandButton")
            WITH .cmd_4c_Visualizar
                .Caption         = "Visualizar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            = 80
                .Width           = 75
                .Height          = 75
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Comic Sans MS"
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

            .AddObject("cmd_4c_Alterar", "CommandButton")
            WITH .cmd_4c_Alterar
                .Caption         = "Alterar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            = 155
                .Width           = 75
                .Height          = 75
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Comic Sans MS"
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

            .AddObject("cmd_4c_Excluir", "CommandButton")
            WITH .cmd_4c_Excluir
                .Caption         = "Excluir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            = 230
                .Width           = 75
                .Height          = 75
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Comic Sans MS"
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

            .AddObject("cmd_4c_Buscar", "CommandButton")
            WITH .cmd_4c_Buscar
                .Caption         = "Buscar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            = 305
                .Width           = 75
                .Height          = 75
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Comic Sans MS"
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
        ENDWITH

        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container Saida (Grupo_Saida no legado) - padrao canonico do
        *-- sistema novo, prevalece sobre o PILAR 1 (regra #10 CLAUDE.md)
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
                .Caption         = "Encerrar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            = 5
                .Width           = 75
                .Height          = 75
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Comic Sans MS"
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
        ENDWITH

        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid da Lista (Grade no legado: Top=96,Left=32,Width=736,Height=490;
        *-- com compensacao PageFrame.Top=-29: 96+29=125. Width/Left seguem o
        *-- canonico do Framework para nao sobrepor cnt_4c_Saida (Left=917).
        *-- ControlSource/Header sao (re)definidos em CarregarLista(), apos o
        *-- RecordSource - regra "Grade perde cabecalhos apos RecordSource".
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oPagina.grd_4c_Lista.RecordSource = ""
        loc_oPagina.grd_4c_Lista.ColumnCount  = 3
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 125
            .Left               = 26
            .Width              = 880
            .Height             = 490
            .ReadOnly           = .T.
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .FontName           = "Verdana"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .GridLines          = 3
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .RowHeight          = 16
            .ScrollBars         = 2
            .Visible            = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Page2: faixa de cabecalho + campos da ficha
    * (Codigo, Descricao, Mensagem, Tipo) + container Confirmar/Cancelar
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho identico ao da Page1 - CLAUDE.md regra #11
        *-- (faixa vai nas DUAS paginas; Page2 nao compensa +2 do original)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 29
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = THIS.Caption
            .Top       = 15
            .Left      = 10
            .Width     = 769
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = THIS.Caption
            .Top       = 18
            .Left      = 10
            .Width     = 769
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Campos principais (Say8/getCods, Say1/getDescrs) - 1a metade dos
        *-- campos da Page2. Compensacao PageFrame +29 no Top (regra #11).
        *-- Nomes conforme mapeamento.json (lbl_4c_Label8/1, txt_4c_Codigo/Descrs).

        loc_oPagina.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPagina.lbl_4c_Label8
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 191
            .Left      = 118
            .Width     = 42
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Top       = 188
            .Left      = 162
            .Width     = 80
            .Height    = 23
            .MaxLength = 10
            .Format    = "!"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 216
            .Left      = 105
            .Width     = 55
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Descrs", "TextBox")
        WITH loc_oPagina.txt_4c_Descrs
            .Top       = 213
            .Left      = 162
            .Width     = 537
            .Height    = 23
            .MaxLength = 76
            .Format    = "!"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Campos restantes (Say3/getMensas, Say2/optTipo) - 2a metade dos
        *-- campos da Page2. Compensacao PageFrame +29 no Top (regra #11).
        *-- Nomes conforme mapeamento.json (lbl_4c_Label3/2, obj_4c_GetMensas/OptTipo).
        *-- NAO ha lookups neste form: codigo fonte original nao usa
        *-- fwbuscaext/fwBuscaSel/sigacess em nenhum campo (confirmado em
        *-- comportamento.json - funcoesExternas: fConfigGeral, fUniqueIds).

        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "Mensagem :"
            .Top       = 239
            .Left      = 100
            .Width     = 60
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_GetMensas", "EditBox")
        WITH loc_oPagina.obj_4c_GetMensas
            .Top       = 238
            .Left      = 162
            .Width     = 537
            .Height    = 103
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Tipo :"
            .Top       = 349
            .Left      = 131
            .Width     = 29
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- optTipo (legado): ButtonCount=3, Value=1 (default), ControlSource
        *-- crSigOpIns.Tipos (1=Cheque, 2=Titulo, 3=Follow Up). O migrado nao
        *-- vincula a um cursor vivo - FormParaBO/BOParaForm leem/escrevem
        *-- THIS.this_oBusinessObject.this_nTipos (regra ControlSource numerico).
        loc_oPagina.AddObject("obj_4c_OptTipo", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptTipo
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Top         = 343
            .Left        = 156
            .Width       = 292
            .Height      = 27
            .Visible     = .T.

            WITH .Buttons(1)
                .Caption   = "Cheque"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Left      = 7
                .Top       = 5
                .Width     = 62
                .Height    = 17
                .AutoSize  = .F.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "T" + CHR(237) + "tulo"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Left      = 84
                .Top       = 5
                .Width     = 62
                .Height    = 17
                .AutoSize  = .F.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(3)
                .Caption   = "Follow Up"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Left      = 148
                .Top       = 5
                .Width     = 64
                .Height    = 15
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Container Botoes de Acao (Grupo_Salva no legado) - canonico
        *-- (cnt_4c_Salva): Left=842, Top=33; Confirmar/Cancelar Left=5/80
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
                .Caption         = "Confirmar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            = 5
                .Width           = 75
                .Height          = 75
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Comic Sans MS"
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

            .AddObject("cmd_4c_Cancelar", "CommandButton")
            WITH .cmd_4c_Cancelar
                .Caption         = "Encerrar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            = 80
                .Width           = 75
                .Height          = 75
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Comic Sans MS"
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
        ENDWITH

        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- Validacao de codigo duplicado (transcricao do Valid legado de
        *-- getCods: ChkRegister + MessageBox + limpa o campo). LostFocus
        *-- (NAO KeyPress) - regra #47 CLAUDE.md.
        BINDEVENT(loc_oPagina.txt_4c_Codigo, "LostFocus", THIS, "ValidarCodigoDuplicado")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ValidarCodigoDuplicado - Transcricao do getCods.Valid legado: em modo
    * INCLUIR, se o codigo ja existe em SigOpIns, avisa e limpa o campo
    * (ChkRegister('SigOpIns','Cods',This.Value) + This.Value = '').
    * PUBLIC (chamado via BINDEVENT - regra #3 CLAUDE.md).
    *===========================================================================
    PROCEDURE ValidarCodigoDuplicado()
        LOCAL loc_oPagina, loc_cCodigo, loc_cSQL, loc_nResultado

        IF THIS.this_cModoAtual != "INCLUIR"
            RETURN
        ENDIF

        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)

        IF EMPTY(loc_cCodigo)
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT cidchaves FROM SigOpIns WHERE cods = " + EscaparSQL(loc_cCodigo)

            IF USED("cursor_4c_ChkCodigo")
                USE IN cursor_4c_ChkCodigo
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCodigo")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ChkCodigo") > 0
                MsgAviso("C" + CHR(243) + "digo J" + CHR(225) + " Cadastrado!!!")
                loc_oPagina.txt_4c_Codigo.Value = ""
            ENDIF

            IF USED("cursor_4c_ChkCodigo")
                USE IN cursor_4c_ChkCodigo
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "FormSIGPRINT.ValidarCodigoDuplicado")
        ENDTRY
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere campos da Page2 para o Business Object
    * (chamado por BtnSalvarClick - a ser implementado na Fase 7)
    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.this_cCods   = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
        THIS.this_oBusinessObject.this_cDescrs = ALLTRIM(loc_oPagina.txt_4c_Descrs.Value)
        THIS.this_oBusinessObject.this_cMensas = ALLTRIM(loc_oPagina.obj_4c_GetMensas.Value)
        THIS.this_oBusinessObject.this_nTipos  = loc_oPagina.obj_4c_OptTipo.Value
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere dados do Business Object para os campos da Page2
    * (chamado apos CarregarPorCodigo, antes de exibir modo Alterar/Visualizar)
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.txt_4c_Codigo.Value    = THIS.this_oBusinessObject.this_cCods
        loc_oPagina.txt_4c_Descrs.Value    = THIS.this_oBusinessObject.this_cDescrs
        loc_oPagina.obj_4c_GetMensas.Value = THIS.this_oBusinessObject.this_cMensas
        loc_oPagina.obj_4c_OptTipo.Value   = IIF(THIS.this_oBusinessObject.this_nTipos = 0, 1, THIS.this_oBusinessObject.this_nTipos)
    ENDPROC

    *===========================================================================
    * ObterChaveSelecionada - Devolve o cidchaves da linha selecionada na grade
    * da Lista (string vazia se nao houver linha). O legado abre o Grupo_op.Click
    * com "SELECT crSigOpIns / LOCATE FOR Cods = csSigOpIns.Cods" para sincronizar
    * o cursor remoto com a grade; aqui a grade esta ligada direto a
    * cursor_4c_Dados, que ja traz cidchaves - a PK REAL de SigOpIns (cods tem
    * indice NAO-unico, por isso o BO chaveia por cidchaves).
    *===========================================================================
    PROTECTED PROCEDURE ObterChaveSelecionada()
        LOCAL loc_cChave
        loc_cChave = ""

        IF USED("cursor_4c_Dados")
            IF RECCOUNT("cursor_4c_Dados") > 0 AND !EOF("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
            ENDIF
        ENDIF

        RETURN loc_cChave
    ENDPROC

    *===========================================================================
    * FocarControle - SetFocus protegido (transcricao dos SetFocus do
    * Grupo_op.Click legado). SetFocus em controle oculto/desabilitado ou em
    * form que ainda nao foi exibido dispara erro de runtime - por isso as
    * guardas. VFP9 NAO faz short-circuit: o teste do objeto fica no IF externo.
    *===========================================================================
    PROTECTED PROCEDURE FocarControle(par_oControle)
        IF VARTYPE(par_oControle) = "O" AND THIS.Visible
            IF par_oControle.Visible AND par_oControle.Enabled
                par_oControle.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Abre a Page2 para incluir nova instrucao
    * Legado (Grupo_op.Click, Case INSERIR): optTipo.Value = 1 + getCods.SetFocus
    * PUBLIC: BINDEVENT exige metodo publico (regra #3 CLAUDE.md)
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oPagina

        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)

        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_oPagina.obj_4c_OptTipo.Value = 1
        THIS.FocarControle(loc_oPagina.txt_4c_Codigo)
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Abre a Page2 em modo somente leitura (CONSULTAR)
    * PUBLIC: BINDEVENT exige metodo publico (regra #3 CLAUDE.md)
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cChave, loc_oPagina
        loc_cChave = THIS.ObterChaveSelecionada()

        IF EMPTY(loc_cChave)
            MsgAviso("Selecione um registro para visualizar.", "Aviso")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.F.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)

                *-- Legado: Case Inlist(pcEscolha,'EXCLUIR','CONSULTAR') manda o
                *-- foco para Grupo_Salva.Salva. No padrao do sistema novo o
                *-- Confirmar fica DESABILITADO no modo VISUALIZAR, entao o foco
                *-- vai para o Cancelar, que eh o botao ativo da ficha.
                loc_oPagina = THIS.pgf_4c_Paginas.Page2
                THIS.FocarControle(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar)
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Abre a Page2 para alterar a instrucao selecionada
    * Legado (Grupo_op.Click, Case ALTERAR): getDescrs.SetFocus - o Codigo nao
    * eh digitavel em ALTERAR (getCods.When), por isso o foco cai na Descricao.
    * PUBLIC: BINDEVENT exige metodo publico (regra #3 CLAUDE.md)
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cChave, loc_oPagina
        loc_cChave = THIS.ObterChaveSelecionada()

        IF EMPTY(loc_cChave)
            MsgAviso("Selecione um registro para alterar.", "Aviso")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.this_cModoAtual = "ALTERAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.T.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)

                loc_oPagina = THIS.pgf_4c_Paginas.Page2
                THIS.FocarControle(loc_oPagina.txt_4c_Descrs)
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Exclui a instrucao selecionada, com confirmacao
    * No legado o EXCLUIR abre a ficha somente-leitura e eh o Salva.Click que
    * executa o DELETE; aqui vale o padrao canonico do sistema novo (confirmacao
    * + exclusao no proprio botao), usado em 144 dos 199 forms CRUD migrados.
    * O BusinessBase ja reporta a falha de gravacao (regra #20) - sem ELSE.
    * PUBLIC: BINDEVENT exige metodo publico (regra #3 CLAUDE.md)
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cChave, loc_cCodigo
        loc_cChave  = THIS.ObterChaveSelecionada()
        loc_cCodigo = ""

        IF EMPTY(loc_cChave)
            MsgAviso("Selecione um registro para excluir.", "Aviso")
        ELSE
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)

            IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da instru" + CHR(231) + ;
                    CHR(227) + "o [" + loc_cCodigo + "]?", ;
                    "Confirmar Exclus" + CHR(227) + "o")
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                    IF THIS.this_oBusinessObject.Excluir()
                        MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Excluir")
                        THIS.CarregarLista()
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Busca POR EXEMPLO (msv_procurar do legado)
    * O SCX tem "PROCEDURE msv_procurar" (SET NEAR ON + SEEK pelo getCods) e
    * getCods.When libera o campo em 'INSERIR' e 'PROCURAR': o Buscar NAO abre
    * picker - ele limpa a ficha, deixa SO o Codigo digitavel e vai para a
    * pagina de Dados; quem executa a procura eh o Confirmar (BtnSalvarClick).
    * PUBLIC: BINDEVENT exige metodo publico (regra #3 CLAUDE.md)
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oPagina

        THIS.this_oBusinessObject.CancelarEdicao()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "BUSCAR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)

        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        THIS.FocarControle(loc_oPagina.txt_4c_Codigo)
    ENDPROC

    *===========================================================================
    * PosicionarListaPorCodigo - Transcricao do msv_procurar legado:
    *     SELECT csSigOpIns / SET NEAR ON / SEEK getCods.Value / SET NEAR OFF
    * cursor_4c_Dados vem do SQLEXEC com ORDER BY cods (sem indice), entao o
    * equivalente do SEEK com NEAR ON eh parar na PRIMEIRA linha cujo cods seja
    * >= o procurado; se todas forem menores, fica na ultima (o NEAR ON do
    * legado tambem nao volta para o topo). Comparacao com PADR porque o
    * config.prg liga SET EXACT ON.
    *===========================================================================
    PROTECTED PROCEDURE PosicionarListaPorCodigo(par_cCodigo)
        LOCAL loc_cProcura, loc_oGrid

        IF USED("cursor_4c_Dados")
            IF RECCOUNT("cursor_4c_Dados") > 0
                loc_cProcura = PADR(ALLTRIM(par_cCodigo), 10)

                SELECT cursor_4c_Dados
                GO TOP
                LOCATE FOR PADR(ALLTRIM(cursor_4c_Dados.cods), 10) >= loc_cProcura

                IF !FOUND()
                    GO BOTTOM IN cursor_4c_Dados
                ENDIF

                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                loc_oGrid.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Confirmar da ficha (Grupo_Salva.Salva.Click do legado)
    * Em INCLUIR/ALTERAR grava; em BUSCAR executa o msv_procurar e volta para a
    * Lista. As 3 validacoes sao transcricao literal do legado, na mesma ordem,
    * com as mesmas mensagens e os mesmos campos recebendo o foco.
    * O CidChaves (fUniqueIds) eh gerado pelo proprio SIGPRINTBO.Inserir().
    * O ramo EXCLUIR do Salva.Click legado nao existe aqui: a exclusao eh
    * confirmada e executada no proprio BtnExcluirClick (padrao canonico).
    * O BusinessBase ja reporta falha de gravacao (regra #20) - sem ELSE.
    * PUBLIC: BINDEVENT exige metodo publico (regra #3 CLAUDE.md)
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPagina, loc_cCodigo, loc_cDescrs, loc_cMensas
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Modo BUSCAR: Confirmar nao grava, procura (msv_procurar legado)
        IF THIS.this_cModoAtual = "BUSCAR"
            loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)

            *-- Volta para a Lista SEM passar por AlternarPagina(1): o funil
            *-- chama CarregarLista, que re-consulta e jogaria o ponteiro para
            *-- a primeira linha - exatamente a posicao que a busca definiu.
            *-- O Refresh vem DEPOIS da troca de pagina (regras #21 e #46).
            THIS.this_cModoAtual = "LISTA"
            THIS.pgf_4c_Paginas.ActivePage = 1
            THIS.AjustarBotoesPorModo()
            THIS.PosicionarListaPorCodigo(loc_cCodigo)
            RETURN
        ENDIF

        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF

        loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
        loc_cDescrs = ALLTRIM(loc_oPagina.txt_4c_Descrs.Value)
        loc_cMensas = ALLTRIM(loc_oPagina.obj_4c_GetMensas.Value)

        IF EMPTY(loc_cCodigo)
            MsgAviso("Codigo Inv" + CHR(225) + "lido!!!")
            THIS.FocarControle(loc_oPagina.txt_4c_Codigo)
            RETURN
        ENDIF

        IF EMPTY(loc_cDescrs)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!")
            THIS.FocarControle(loc_oPagina.txt_4c_Descrs)
            RETURN
        ENDIF

        IF EMPTY(loc_cMensas)
            MsgAviso("Mensagem Inv" + CHR(225) + "lida!!! Aten" + CHR(231) + CHR(227) + ;
                "o Esta Mensagem Ser" + CHR(225) + " Utilizada na Impress" + CHR(227) + "o " + ;
                CHR(13) + "da Solicita" + CHR(231) + CHR(227) + "o!!! Portanto " + CHR(201) + ;
                " Necess" + CHR(225) + "rio Que a Mesma Seja Preenchida!!!")
            *-- O legado manda o foco para getDescrs (nao para getMensas) nesta
            *-- validacao - transcrito como esta no SCX.
            THIS.FocarControle(loc_oPagina.txt_4c_Descrs)
            RETURN
        ENDIF

        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Registro salvo com sucesso!", "Confirmar")
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancelar da ficha (Grupo_Salva.Cancelar.Click legado:
    * DoDefault + If plCancelar -> mAtivapagina1). Descarta a edicao no BO e
    * volta para a Lista pelo funil, que normaliza o modo, recarrega a grade e
    * reajusta os botoes (regra #40 CLAUDE.md).
    * PUBLIC: BINDEVENT exige metodo publico (regra #3 CLAUDE.md)
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.this_oBusinessObject.CancelarEdicao()
        THIS.LimparCampos()
        THIS.HabilitarCampos(.F.)
        THIS.AlternarPagina(1)
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario (Grupo_Saida.Sair do legado)
    * PUBLIC: BINDEVENT exige metodo publico (regra #3 CLAUDE.md)
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * CarregarLista - Popula grd_4c_Lista com cods/descrs/tipo (transcricao do
    * Init legado: SCAN em crSigOpIns + csSigOpIns.Tipo = IIF(Tipos=1,"CHEQUE",
    * IIF(Tipos=2,"TITULOS","FOLLOW UP"))). Column3 usa expressao derivada em
    * vez de recriar o cursor local do legado (padrao ja usado em FormFte).
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                *-- DataSession=2: criar cursor em session 1 para o TesteAutomatico enxergar
                LOCAL loc_nDsAtual
                loc_nDsAtual = THIS.DataSessionID
                SET DATASESSION TO 1
                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                SET NULL ON
                CREATE CURSOR cursor_4c_Dados (cidchaves C(20), cods C(10), descrs C(76), tipos N(1,0))
                SET NULL OFF
                INSERT INTO cursor_4c_Dados VALUES ("TESTE00000000000001", "0000000001", "Instru" + CHR(231) + CHR(227) + "o Teste", 1)
                SET DATASESSION TO (loc_nDsAtual)
                loc_lResultado = .T.
            ELSE
                IF THIS.this_oBusinessObject.Buscar("")
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cods"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
                    loc_oGrid.Column3.ControlSource = "IIF(cursor_4c_Dados.tipos=1,'CHEQUE',IIF(cursor_4c_Dados.tipos=2,'TITULOS','FOLLOW UP'))"

                    loc_oGrid.Column1.Width    = 90
                    loc_oGrid.Column2.Width    = 560
                    loc_oGrid.Column3.Width    = 220

                    loc_oGrid.Column1.ReadOnly = .T.
                    loc_oGrid.Column2.ReadOnly = .T.
                    loc_oGrid.Column3.ReadOnly = .T.

                    loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                    loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                    loc_oGrid.Column3.Header1.Caption = "Tipo"

                    THIS.FormatarGridLista(loc_oGrid)

                    *-- Legado fecha a carga da Grade com "Go Top In <cursor>"
                    *-- + "grade.Refresh" (regra #21: popular cursor NAO
                    *-- repinta a grade sozinho). O GO TOP tambem garante que
                    *-- ObterChaveSelecionada/BtnExcluirClick leiam a 1a linha
                    *-- quando nenhuma foi clicada ainda.
                    GO TOP IN cursor_4c_Dados
                    loc_oGrid.Refresh()

                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "FormSIGPRINT.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista, 1) e Page2 (Dados, 2).
    * Ao voltar para a Lista, normaliza o modo e recarrega a grade (regra
    * "Popular cursor NAO repinta a grade" + "Reabilitar botoes no funil
    * de volta" - CLAUDE.md regra #40).
    *===========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina

                IF par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                    THIS.CarregarLista()
                ENDIF

                THIS.AjustarBotoesPorModo()

                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "FormSIGPRINT.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita/desabilita os campos da Page2 conforme o modo
    * Transcricao do gate de edicao do framework legado (fwget.When):
    *     INSERIR/ALTERAR  -> editavel
    *     PROCURAR         -> editavel SO se o controle tem plProcurar = .T.
    * Nenhum controle do SIGPRINT.SCX declara plProcurar (default .F.) e o
    * getCods tem When PROPRIO - "Return(Inlist(pcEscolha,'INSERIR','PROCURAR'))":
    *     Codigo  -> digitavel em INCLUIR e BUSCAR (eh o campo da busca)
    *     os demais -> digitaveis SO em INCLUIR e ALTERAR
    * Por isso o modo BUSCAR nao libera Descricao/Mensagem/Tipo: o msv_procurar
    * legado procura apenas pelo Codigo, e campo editavel que a busca ignora
    * engana o usuario.
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina, loc_lCodigo, loc_lDemais
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_lCodigo = par_lHabilitar AND INLIST(THIS.this_cModoAtual, "INCLUIR", "BUSCAR")
        loc_lDemais = par_lHabilitar AND INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
            loc_oPagina.txt_4c_Codigo.Enabled    = loc_lCodigo
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Descrs", 5)
            loc_oPagina.txt_4c_Descrs.Enabled    = loc_lDemais
        ENDIF
        IF PEMSTATUS(loc_oPagina, "obj_4c_GetMensas", 5)
            loc_oPagina.obj_4c_GetMensas.Enabled = loc_lDemais
        ENDIF
        IF PEMSTATUS(loc_oPagina, "obj_4c_OptTipo", 5)
            loc_oPagina.obj_4c_OptTipo.Enabled   = loc_lDemais
        ENDIF
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa a ficha da Page2 para um novo registro
    * optTipo volta a 1 (Cheque) - e o default do legado (optTipo.Value = 1 no
    * Case INSERIR do Grupo_op.Click e na propria classe fwoption do SCX).
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
            loc_oPagina.txt_4c_Codigo.Value    = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Descrs", 5)
            loc_oPagina.txt_4c_Descrs.Value    = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina, "obj_4c_GetMensas", 5)
            loc_oPagina.obj_4c_GetMensas.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina, "obj_4c_OptTipo", 5)
            loc_oPagina.obj_4c_OptTipo.Value   = 1
        ENDIF
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Estado dos botoes da ficha conforme o modo atual
    * INCLUIR/ALTERAR/BUSCAR: Confirmar habilitado | VISUALIZAR/LISTA: desabilitado
    * Cancelar fica SEMPRE habilitado (padrao frmcadastro: no modo consulta o
    * Confirmar eh desabilitado e o Cancelar continua ativo).
    * PUBLIC: chamado de fora da classe pelo TesteAutomatico (regra #3 CLAUDE.md)
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPagina, loc_lEditando
        loc_oPagina   = THIS.pgf_4c_Paginas.Page2
        loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "BUSCAR")

        IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
            IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando OR (THIS.this_cModoAtual = "EXCLUIR")
            ENDIF
            IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * FormatarGridLista - Formata visual do grid da lista
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        *-- Grid.FontName NAO retroage sobre as Columns/Headers criadas por
        *-- AddObject (cada uma tem a propria fonte). Sem o SetAll a Verdana 8
        *-- da classe Grade legada fica so na moldura e as celulas saem no
        *-- default do VFP. "Verdana" vem do Framework (fwgrade), NAO Tahoma.
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
            .FontName = "Verdana"
            .FontSize = 8
            .SetAll("FontName", "Verdana", "Header")
            .SetAll("FontSize", 8, "Header")
        ENDWITH
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna visiveis recursivamente os controles de
    * um container (AddObject cria com Visible=.F. por padrao)
    *===========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *===========================================================================
    * Destroy - Libera recursos ao fechar o formulario
    *===========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        *-- FormBase nao usa DataSession privada: os cursores ficam na sessao
        *-- DEFAULT e sobrevivem ao form. cursor_4c_Dados eh nome COMPARTILHADO
        *-- por mais de 100 forms - deixar aberto entrega cursor velho para a
        *-- proxima tela. Fechar aqui eh o padrao canonico (FormCor.Destroy).
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        IF USED("cursor_4c_ChkCodigo")
            USE IN cursor_4c_ChkCodigo
        ENDIF

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRINTBO.prg):
*====================================================================
* SIGPRINTBO.prg
*
* Business Object para SIGPRINT (Cadastro de Instrucoes)
* Tabela principal: SigOpIns (cidchaves PK, cods codigo de negocio)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SIGPRINTBO AS BusinessBase

	*-- Propriedades da entidade (SigOpIns)
	this_cCidChaves = ""   && cidchaves char(20) - PK (ID unico gerado por fUniqueIds)
	this_cCods      = ""   && cods char(10)      - codigo da instrucao (indice nao-unico)
	this_cDescrs    = ""   && descrs char(76)    - descricao da instrucao
	this_cMensas    = ""   && mensas text        - mensagem impressa na solicitacao
	this_nTipos     = 0    && tipos numeric(1,0) - tipo (1=Cheque, 2=Titulo, 3=Follow Up)

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()

		THIS.this_cTabela     = "SigOpIns"
		THIS.this_cCampoChave = "cidchaves"

		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCidChaves)
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Carrega propriedades do BO a partir de cursor
	* REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)
				THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
				THIS.this_cCods      = TratarNulo(cods,      "C")
				THIS.this_cDescrs    = TratarNulo(descrs,    "C")
				THIS.this_cMensas    = TratarNulo(mensas,    "C")
				THIS.this_nTipos     = TratarNulo(tipos,     "N")
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "SIGPRINTBO.CarregarDoCursor")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - Insere novo registro na tabela SigOpIns
	* cidchaves eh a PK tecnica (Fortyus), gerada via fUniqueIds()
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(THIS.this_cCidChaves)
				THIS.this_cCidChaves = fUniqueIds()
			ENDIF

			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				INSERT INTO SigOpIns (cods, descrs, mensas, tipos, cidchaves)
				VALUES (
					<<EscaparSQL(THIS.this_cCods)>>,
					<<EscaparSQL(THIS.this_cDescrs)>>,
					<<EscaparSQL(THIS.this_cMensas)>>,
					<<FormatarNumeroSQL(THIS.this_nTipos, 0)>>,
					<<EscaparSQL(THIS.this_cCidChaves)>>
				)
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao inserir instru" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "SIGPRINTBO.Inserir")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - Atualiza registro existente na tabela SigOpIns
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				UPDATE SigOpIns
				SET cods   = <<EscaparSQL(THIS.this_cCods)>>,
					descrs = <<EscaparSQL(THIS.this_cDescrs)>>,
					mensas = <<EscaparSQL(THIS.this_cMensas)>>,
					tipos  = <<FormatarNumeroSQL(THIS.this_nTipos, 0)>>
				WHERE cidchaves = <<EscaparSQL(THIS.this_cCidChaves)>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao atualizar instru" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "SIGPRINTBO.Atualizar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - Exclui registro pela chave primaria (cidchaves)
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				DELETE FROM SigOpIns WHERE cidchaves = <<EscaparSQL(THIS.this_cCidChaves)>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao excluir instru" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "SIGPRINTBO.ExecutarExclusao")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Buscar - Busca registros com filtro opcional
	* Retorna cursor_4c_Dados com cidchaves, cods, descrs, tipos
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
				IF !USED("cursor_4c_Dados")
					SET NULL ON
					CREATE CURSOR cursor_4c_Dados (cidchaves C(20), cods C(10), descrs C(76), tipos N(1,0))
					SET NULL OFF
				ENDIF
				loc_lSucesso = .T.
			ELSE
				loc_cSQL = "SELECT cidchaves, cods, descrs, tipos FROM SigOpIns"

				IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
					loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
				ENDIF

				loc_cSQL = loc_cSQL + " ORDER BY cods"

				IF USED("cursor_4c_Dados")
					USE IN cursor_4c_Dados
				ENDIF
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
				IF loc_nResultado >= 0
					loc_lSucesso = .T.
				ELSE
					MostrarErro("Erro ao buscar instru" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
				ENDIF
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "SIGPRINTBO.Buscar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega registro pela chave primaria (cidchaves)
	* par_cCodigo recebe cidchaves (cods NAO e unico - indice nao-unico)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCodigo)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT cidchaves, cods, descrs, mensas, tipos" + ;
				" FROM SigOpIns WHERE cidchaves = " + EscaparSQL(par_cCodigo)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

			IF loc_nResultado >= 0
				IF RECCOUNT("cursor_4c_Carrega") > 0
					loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
					THIS.this_lNovoRegistro = .F.
				ELSE
					MsgAviso("Instru" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada!")
				ENDIF

				IF USED("cursor_4c_Carrega")
					USE IN cursor_4c_Carrega
				ENDIF
			ELSE
				MostrarErro("Erro ao carregar instru" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "SIGPRINTBO.CarregarPorCodigo")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

