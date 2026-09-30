# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 9/10
- Mensagem: Teste de formulario falhou com exit code 1.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-09-27 16:28:35] [INFO] === VFP EXECUTOR v2.0 ===
[2026-09-27 16:28:35] [INFO] Config FPW: (nao fornecido)
[2026-09-27 16:28:35] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-27 16:28:35] [INFO] Timeout: 300 segundos
[2026-09-27 16:28:35] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_nenutxo0.prg
[2026-09-27 16:28:35] [INFO] Conteudo do wrapper:
[2026-09-27 16:28:35] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigPrCtr', 'C:\4c\tasks\task598\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigPrCtr', 'C:\4c\tasks\task598\logs\06_testForm.log'
QUIT

[2026-09-27 16:28:35] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_nenutxo0.prg
[2026-09-27 16:28:35] [INFO] VFP output esperado em: C:\4c\tasks\task598\vfp_output.txt
[2026-09-27 16:28:35] [INFO] Executando Visual FoxPro 9...
[2026-09-27 16:28:35] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_nenutxo0.prg
[2026-09-27 16:28:35] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_nenutxo0.prg
[2026-09-27 16:28:35] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigPrCtr
Inicio: 27/09/2026 16:28:36

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 27/09/2026 16:31:54
Duracao: 198 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-09-27 16:31:54] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-09-27 16:31:54] [INFO] VFP9 finalizado em 198.5501427 segundos
[2026-09-27 16:31:54] [INFO] Exit Code: 
[2026-09-27 16:31:54] [INFO] 
[2026-09-27 16:31:54] [INFO] Arquivos temporarios preservados para inspecao:
[2026-09-27 16:31:54] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_nenutxo0.prg
[2026-09-27 16:31:54] [INFO] 
[2026-09-27 16:31:54] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-09-27 16:31:54] [INFO] * Auto-generated wrapper for parameters
[2026-09-27 16:31:54] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-27 16:31:54] [INFO] * Parameters: 'FormSigPrCtr', 'C:\4c\tasks\task598\logs\06_testForm.log'
[2026-09-27 16:31:54] [INFO] 
[2026-09-27 16:31:54] [INFO] * Anti-dialog protections for unattended execution
[2026-09-27 16:31:54] [INFO] SET SAFETY OFF
[2026-09-27 16:31:54] [INFO] SET RESOURCE OFF
[2026-09-27 16:31:54] [INFO] SET TALK OFF
[2026-09-27 16:31:54] [INFO] SET NOTIFY OFF
[2026-09-27 16:31:54] [INFO] SYS(2335, 0)
[2026-09-27 16:31:54] [INFO] 
[2026-09-27 16:31:54] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigPrCtr', 'C:\4c\tasks\task598\logs\06_testForm.log'
[2026-09-27 16:31:54] [INFO] QUIT
[2026-09-27 16:31:54] [INFO] 
[2026-09-27 16:31:54] [INFO] === Fim do Wrapper.prg ===
[2026-09-27 16:31:54] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\cadastros\FormSigPrCtr.prg):
*==============================================================================
* FormSigPrCtr.prg - Formulario de Controle de Movimentacoes por XML
* Migrado de: SIGPRCTR.SCX (frmcadastro)
*
* FASE 6/8 - Campos restantes da aba Movimentacoes, lookups completos
* (Grupo/Conta/Dconta/Cpf/Moeda) e container cnt_4c_BotoesAcao (Confirmar/
* Cancelar). Botoes de acao da aba Precificacao e grids da aba
* Movimentacoes entram nas fases seguintes.
*==============================================================================

DEFINE CLASS FormSigPrCtr AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: Height/Width/Caption EXATOS do original)
    Height      = 620
    Width       = 1200
    Caption     = "Controle de Movimenta" + CHR(231) + CHR(245) + "es por XML"
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
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrCtrBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar SigPrCtrBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormSigPrCtr.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarCursoresGlobais()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormSigPrCtr:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormSigPrCtr.InicializarForm")
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
    * CarregarCursoresGlobais - Cursores de sessao carregados uma vez no Init
    * legado: crSigCdPam (parametros gerais - moedetqs/GrPadFors, usados pelo
    * botao Processar e por LimparCampos), crSigCdMoe/crSigCdCot (cotacao de
    * moedas, consumidos por SigPrCtrBO.CarregarCambio - fCarregarCambio nao
    * foi portada, memoria fCarregarCambio_nao_portada). Mantidos com o nome
    * ORIGINAL do legado (sem prefixo cursor_4c_) - mesma convencao ja usada
    * neste form para os cursores de trabalho da aba XML (crMovimentos etc).
    *===========================================================================
    PROTECTED PROCEDURE CarregarCursoresGlobais()
        TRY
            IF USED("crSigCdPam")
                USE IN crSigCdPam
            ENDIF
            SQLEXEC(gnConnHandle, "SELECT * FROM SigCdPam", "crSigCdPam")

            IF USED("crSigCdMoe")
                USE IN crSigCdMoe
            ENDIF
            SQLEXEC(gnConnHandle, "SELECT CMoes, Cotas FROM SigCdMoe", "crSigCdMoe")
            IF USED("crSigCdMoe")
                SELECT crSigCdMoe
                INDEX ON CMoes TAG CMoes
            ENDIF

            IF USED("crSigCdCot")
                USE IN crSigCdCot
            ENDIF
            SQLEXEC(gnConnHandle, "SELECT * FROM SigCdCot", "crSigCdCot")
            IF USED("crSigCdCot")
                SELECT crSigCdCot
                INDEX ON CMoes + DTOS(Datas) TAG CMoeData DESCENDING
                SET ORDER TO CMoeData DESCENDING
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormSigPrCtr.CarregarCursoresGlobais")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaLista - Page1 completa (FASE 4)
    * Cabecalho (faixa cinza, regra #11) + filtro de periodo (legado:
    * Pagina.Lista.Dt_inicial/Dt_final) + Grid (legado: Pagina.Lista.Grade,
    * alimentada pela query lcQueryLista do Init) + container de botoes CRUD
    * (Incluir/Visualizar/Alterar/Excluir/Buscar) + container de saida
    * (Encerrar - padrao canonico, regra #10).
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oCnt, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (cntSombra no legado) - PRIMEIRO AddObject da pagina (regra #11)
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
            .Width     = THIS.Width - 20
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
            .Width     = THIS.Width - 20
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container Botoes CRUD (Grupo_Op no legado) - canonico: BackColor RGB(53,53,53)
        *-- Posicionado relativo a THIS.Width (canonico: Left=542 quando Width=1000)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = THIS.Width - 458
            .Width       = 390
            .Height      = 85
            .BackColor   = RGB(53, 53, 53)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
        loc_oCnt = loc_oPagina.cnt_4c_Botoes

        loc_oCnt.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oCnt.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        loc_oCnt.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        loc_oCnt.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        loc_oCnt.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oCnt.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        loc_oCnt.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container Saida (padrao canonico - regra #10: Width=90, Encerrar 75x75)
        *-- Posicionado relativo a THIS.Width (canonico: Left=917 quando Width=1000)
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
        loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Filtro de Periodo (legado: Pagina.Lista.Label1/Dt_inicial/Dt_final/Say2)
        *-- Top compensado: 106+29=135 (Label1/Say2), 102+29=131 (Dt_inicial/Dt_final)
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "Per" + CHR(237) + "odo :"
            .Top       = 135
            .Left      = 440
            .Width     = 45
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Dt_inicial", "TextBox")
        WITH loc_oPagina.txt_4c_Dt_inicial
            .Top      = 131
            .Left      = 495
            .Width    = 80
            .Height   = 21
            .Format   = "D"
            .Value    = DATE()
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Dt_inicial, "KeyPress", THIS, "ValidarDataInicial")

        loc_oPagina.AddObject("txt_4c_Dt_final", "TextBox")
        WITH loc_oPagina.txt_4c_Dt_final
            .Top      = 131
            .Left     = 598
            .Width    = 80
            .Height   = 21
            .Format   = "D"
            .Value    = DATE()
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Dt_final, "KeyPress", THIS, "ValidarDataFinal")

        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "?"
            .Top       = 135
            .Left      = 582
            .Width     = 15
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH

        *-- Grid de Lista (Grade no legado) - Top compensado: 130+29=159
        *-- Alimentada por CarregarLista() com a query lcQueryLista do Init legado
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_Lista
        loc_oGrid.Top                = 159
        loc_oGrid.Left               = 12
        loc_oGrid.Width              = 1138
        loc_oGrid.Height             = 470
        loc_oGrid.ColumnCount        = 6
        loc_oGrid.FontName           = "Tahoma"
        loc_oGrid.FontSize           = 8
        loc_oGrid.ForeColor          = RGB(90, 90, 90)
        loc_oGrid.BackColor          = RGB(255, 255, 255)
        loc_oGrid.GridLineColor      = RGB(238, 238, 238)
        loc_oGrid.HighlightBackColor = RGB(255, 255, 255)
        loc_oGrid.HighlightForeColor = RGB(15, 41, 104)
        loc_oGrid.HighlightStyle     = 2
        loc_oGrid.DeleteMark         = .F.
        loc_oGrid.RecordMark         = .F.
        loc_oGrid.RowHeight          = 16
        loc_oGrid.ScrollBars         = 2
        loc_oGrid.GridLines          = 3
        loc_oGrid.ReadOnly           = .T.
        WITH loc_oGrid
            .Column1.Width = 80
            .Column2.Width = 75
            .Column3.Width = 280
            .Column4.Width = 80
            .Column5.Width = 80
            .Column6.Width = 180
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * CarregarLista - Carrega o Grid da Lista com a query agregada do Init
    * legado (lcQueryLista): distinct por Codigos/OriDopNums/Usuars/Contas,
    * filtrado pelo periodo de txt_4c_Dt_inicial/txt_4c_Dt_final (default:
    * dia atual, igual ao legado ldDatai=fDtoSQL(Date())).
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oPagina, loc_oGrid, loc_dDataIni, loc_dDataFimBase, ;
            loc_tDataFim, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            IF USED("cursor_4c_Lista")
                USE IN cursor_4c_Lista
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Lista ;
                (Codigos C(10), Datas T, OriDopNums C(29), Usuars C(10), Contas C(10), Rclis C(50))
            SET NULL OFF
            RETURN .T.
        ENDIF

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_oGrid   = loc_oPagina.grd_4c_Lista

            *-- Desvincula o Grid ANTES de requerer no mesmo nome de cursor
            *-- (mesmo padrao ja usado em MontaGrade) - evita que o Grid
            *-- fique preso ao cursor durante o SQLEXEC que o recria.
            loc_oGrid.RecordSource = ""

            loc_dDataIni     = ConverterParaData(loc_oPagina.txt_4c_Dt_inicial.Value)
            loc_dDataFimBase = ConverterParaData(loc_oPagina.txt_4c_Dt_final.Value)
            loc_tDataFim = DATETIME(YEAR(loc_dDataFimBase), MONTH(loc_dDataFimBase), ;
                DAY(loc_dDataFimBase), 23, 59, 59)

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT DISTINCT a.Codigos, MAX(a.Datas) AS Datas, a.OriDopNums,
                    a.Usuars, a.Contas, b.Rclis
                FROM SigPrCtr a
                JOIN SigCdCli b ON a.Contas = b.Iclis
                WHERE a.Datas BETWEEN <<FormatarDataSQL(loc_dDataIni)>> AND <<FormatarDataSQL(loc_tDataFim)>>
                GROUP BY a.Codigos, a.OriDopNums, a.Usuars, a.Contas, b.Rclis
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Lista")

            IF loc_nResultado >= 0
                loc_oGrid.ColumnCount           = 6
                loc_oGrid.RecordSource          = "cursor_4c_Lista"
                loc_oGrid.Column1.ControlSource = "cursor_4c_Lista.Codigos"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Lista.Datas"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Lista.OriDopNums"
                loc_oGrid.Column4.ControlSource = "cursor_4c_Lista.Usuars"
                loc_oGrid.Column5.ControlSource = "cursor_4c_Lista.Contas"
                loc_oGrid.Column6.ControlSource = "cursor_4c_Lista.Rclis"

                *-- Reconfigurar cabecalhos e largura APOS RecordSource (obrigatorio - regra #48)
                loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                loc_oGrid.Column2.Header1.Caption = "Data"
                loc_oGrid.Column3.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
                loc_oGrid.Column4.Header1.Caption = "Usu" + CHR(225) + "rio"
                loc_oGrid.Column5.Header1.Caption = "Fornecedor"
                loc_oGrid.Column6.Header1.Caption = "Nome"

                THIS.FormatarGridLista(loc_oGrid)

                *-- Column.Width por ULTIMO (regra #35c: RecordSource/ControlSource
                *-- recalculam a largura para o default 90 - so fica se atribuido
                *-- DEPOIS do FormatarGridLista)
                loc_oGrid.Column1.Width = 80
                loc_oGrid.Column2.Width = 75
                loc_oGrid.Column3.Width = 280
                loc_oGrid.Column4.Width = 80
                loc_oGrid.Column5.Width = 80
                loc_oGrid.Column6.Width = 180

                IF USED("cursor_4c_Lista")
                    GO TOP IN cursor_4c_Lista
                ENDIF
                loc_oGrid.Refresh()
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar lista:" + CHR(13) + CapturarErroSQL(), "CarregarLista")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormSigPrCtr.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    *===========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                MsgErro("Parametro invalido em AlternarPagina: " + TRANSFORM(par_nPagina), "Erro")
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina
                IF par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                    THIS.CarregarLista()
                    THIS.AjustarBotoesPorModo()
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormSigPrCtr.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * FormatarGridLista - Formata visual do grid da lista
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *===========================================================================
    * ValidarDataInicial - LostFocus de txt_4c_Dt_inicial (legado: Dt_inicial.Valid)
    * Se a data inicial ultrapassar a final, empurra a final junto.
    *===========================================================================
    PROCEDURE ValidarDataInicial(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            IF loc_oPagina.txt_4c_Dt_inicial.Value > loc_oPagina.txt_4c_Dt_final.Value
                loc_oPagina.txt_4c_Dt_final.Value = loc_oPagina.txt_4c_Dt_inicial.Value
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormSigPrCtr.ValidarDataInicial")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ValidarDataFinal - LostFocus de txt_4c_Dt_final (legado: Dt_final.Valid +
    * Dt_final.LostFocus: reconstroi a data final, recarrega a Grade e devolve
    * o foco para ela).
    *===========================================================================
    PROCEDURE ValidarDataFinal(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            IF loc_oPagina.txt_4c_Dt_final.Value < loc_oPagina.txt_4c_Dt_inicial.Value
                loc_oPagina.txt_4c_Dt_inicial.Value = loc_oPagina.txt_4c_Dt_final.Value
            ENDIF
            THIS.CarregarLista()
            loc_oPagina.grd_4c_Lista.SetFocus()
        CATCH TO loException
            MostrarErro(loException, "FormSigPrCtr.ValidarDataFinal")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Estrutura base de Page2 (FASE 3)
    * Cabecalho (faixa cinza, regra #11) + container vazio de botoes de acao.
    * Campos e lookups entram nas Fases 5-6.
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina, loc_oAba1, loc_oAba2, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho cinza (identico ao da pagina Lista - regra #11)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top           = 29
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 80
            .BackColor     = RGB(100, 100, 100)
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Visible       = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
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
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
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
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- Container BotoesAcao - VAZIO nesta fase (Confirmar/Cancelar entram em fase posterior)
        *-- Posicionado relativo a THIS.Width (canonico: Left=842 quando Width=1000)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = THIS.Width - 158
            .Width       = 160
            .Height      = 85
            .BackStyle = 0
            .BackColor   = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Enabled         = .F.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- ===================================================================
        *-- PageFrame interno (legado: Pagina.Dados.Pageframe1) - Precificacao
        *-- (Page1) e Movimentacoes/Produtos (Page2). Tabs=.T. (abas reais e
        *-- visiveis, ao contrario do PageFrame externo pgf_4c_Paginas) - por
        *-- isso os filhos usam as coordenadas ORIGINAIS do SCX (relativas a
        *-- Pageframe1.PageN), SEM a compensacao +29 do truque Top=-29.
        *-- Aba Precificacao (Page1): labels, textboxes, os 2 OptionGroups de
        *-- filtro/precificacao e a grd_4c_Estoque. Botoes (processar/
        *-- btnCadastros/Bot_Consulta/Command12/cmdOperacao) e os grids da
        *-- aba Page2 (grd_4c_Disponivel/grd_4c_ItemXml) entram em fase
        *-- posterior.
        *-- ===================================================================
        loc_oPagina.AddObject("pgf_4c_Detalhes", "PageFrame")
        WITH loc_oPagina.pgf_4c_Detalhes
            .PageCount = 2
            .Top       = 115
            .Left      = 5
            .Width     = THIS.Width - 10
            .Height    = 485
            .Tabs      = .T.
            .Visible   = .T.

            .Page1.Caption   = "Precifica" + CHR(231) + CHR(227) + "o"
            .Page1.BackColor = RGB(255, 255, 255)

            .Page2.Caption   = "Movimenta" + CHR(231) + CHR(245) + "es"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH

        loc_oAba1 = loc_oPagina.pgf_4c_Detalhes.Page1

        *-- Say4 "Fornecedores :"
        loc_oAba1.AddObject("lbl_4c_Fornecedores", "Label")
        WITH loc_oAba1.lbl_4c_Fornecedores
            .Caption   = "Fornecedores :"
            .Top       = 69
            .Left      = 228
            .Width     = 75
            .Height    = 15
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Get_Grupo (filtro de grupo de acesso do fornecedor - usado em
        *-- fAcessoContab/fAcessoContas; nao existe coluna equivalente em
        *-- SigPrCtr, portanto NAO e mapeado para propriedade do BO)
        loc_oAba1.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oAba1.txt_4c_Grupo
            .Top           = 66
            .Left          = 307
            .Width         = 85
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .Alignment     = 0
            .MaxLength     = 10
            .BorderStyle   = 1
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Value         = ""
        ENDWITH
        BINDEVENT(loc_oAba1.txt_4c_Grupo, "KeyPress", THIS, "ValidarGrupoAcesso")

        *-- Get_Conta -> this_cContas (schema: contas char(10))
        loc_oAba1.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oAba1.txt_4c_Conta
            .Top           = 66
            .Left          = 394
            .Width         = 85
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .Alignment     = 0
            .MaxLength     = 10
            .BorderStyle   = 1
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Value         = ""
        ENDWITH
        BINDEVENT(loc_oAba1.txt_4c_Conta, "KeyPress", THIS, "ValidarContaFornecedor")

        *-- Get_cpf (CPF/CNPJ do fornecedor - validacao fValidarCPF/fValidarCNPJ;
        *-- SigPrCtr nao tem coluna de CPF, campo nao e persistido diretamente)
        loc_oAba1.AddObject("txt_4c_Cpf", "TextBox")
        WITH loc_oAba1.txt_4c_Cpf
            .Top           = 66
            .Left          = 481
            .Width         = 146
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "XXXXXXXXXXXXXXXXXXXX"
            .MaxLength     = 20
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Value         = ""
        ENDWITH
        BINDEVENT(loc_oAba1.txt_4c_Cpf, "KeyPress", THIS, "ValidarCpfCnpjFornecedor")

        *-- Get_Dconta (nome/razao social do fornecedor, preenchido apos
        *-- validar a Conta - CursorQuery em SigCdCli.Rclis no legado)
        loc_oAba1.AddObject("txt_4c_Dconta", "TextBox")
        WITH loc_oAba1.txt_4c_Dconta
            .Top           = 89
            .Left          = 307
            .Width         = 357
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .MaxLength     = 40
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Value         = ""
        ENDWITH
        BINDEVENT(loc_oAba1.txt_4c_Dconta, "KeyPress", THIS, "ValidarDescricaoConta")

        *-- Say1 "Precificacao :"
        loc_oAba1.AddObject("lbl_4c_Precificacao", "Label")
        WITH loc_oAba1.lbl_4c_Precificacao
            .Caption   = "Precifica" + CHR(231) + CHR(227) + "o :"
            .Top       = 114
            .Left      = 237
            .Width     = 66
            .Height    = 15
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Opt_Custo -> lnOpc do Grupo_Salva.Salva.Click legado (Custo Total
        *-- x Custo pela Composicao). OptionGroup NAO tem ForeColor proprio
        *-- (regra #33) - cor fica em cada Buttons(N).
        loc_oAba1.AddObject("opt_4c_Custo", "OptionGroup")
        WITH loc_oAba1.opt_4c_Custo
            .ButtonCount = 2
            .Top         = 113
            .Left        = 303
            .Width       = 255
            .Height      = 17
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
        ENDWITH
        WITH loc_oAba1.opt_4c_Custo.Buttons(1)
            .Caption   = "Custo Total"
            .Top       = 1
            .Left      = 5
            .Width     = 73
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oAba1.opt_4c_Custo.Buttons(2)
            .Caption   = "Custo pela Composi" + CHR(231) + CHR(227) + "o"
            .Top       = 1
            .Left      = 98
            .Width     = 129
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Say3 "Moeda :"
        loc_oAba1.AddObject("lbl_4c_Moeda", "Label")
        WITH loc_oAba1.lbl_4c_Moeda
            .Caption   = "Moeda :"
            .Top       = 137
            .Left      = 262
            .Width     = 41
            .Height    = 15
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Get_Moeda -> this_cMoedas (schema: moedas char(3) - MaxLength
        *-- conforme SCHEMA, nao os 10 do dump legado - regra #19)
        loc_oAba1.AddObject("txt_4c_Moeda", "TextBox")
        WITH loc_oAba1.txt_4c_Moeda
            .Top           = 134
            .Left          = 307
            .Width         = 85
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .Alignment     = 0
            .MaxLength     = 3
            .BorderStyle   = 1
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Value         = ""
        ENDWITH
        BINDEVENT(loc_oAba1.txt_4c_Moeda, "KeyPress", THIS, "ValidarMoedaFornecedor")

        *-- Say2 "Diretorio :"
        loc_oAba1.AddObject("lbl_4c_Diretorio", "Label")
        WITH loc_oAba1.lbl_4c_Diretorio
            .Caption   = "Diret" + CHR(243) + "rio :"
            .Top       = 160
            .Left      = 253
            .Width     = 50
            .Height    = 15
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Get_Arquivo -> this_cArquivo (schema: arquivo char(200))
        loc_oAba1.AddObject("txt_4c_Arquivo", "TextBox")
        WITH loc_oAba1.txt_4c_Arquivo
            .Top           = 157
            .Left          = 307
            .Width         = 357
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 200
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Value         = ""
        ENDWITH

        *-- Opt_Fil -> lnTipo do CarregaArquivos legado (Somente / Nao / Ambos)
        loc_oAba1.AddObject("opt_4c_Filtro", "OptionGroup")
        WITH loc_oAba1.opt_4c_Filtro
            .ButtonCount = 3
            .Top         = 179
            .Left        = 303
            .Width       = 192
            .Height      = 24
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
        ENDWITH
        WITH loc_oAba1.opt_4c_Filtro.Buttons(1)
            .Caption   = "Somente"
            .Top       = 5
            .Left      = 5
            .Width     = 60
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oAba1.opt_4c_Filtro.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Top       = 5
            .Left      = 84
            .Width     = 37
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oAba1.opt_4c_Filtro.Buttons(3)
            .Caption   = "Ambos"
            .Top       = 5
            .Left      = 132
            .Width     = 50
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Label1 "Carregar produtos que constam nos XML's :" (legado declara
        *-- AutoSize=.T. - transcrever Width/Height fixos: regra #23, AutoSize
        *-- e no-op quando o Label e criado via AddObject)
        loc_oAba1.AddObject("lbl_4c_CarregarXml", "Label")
        WITH loc_oAba1.lbl_4c_CarregarXml
            .Caption   = "Carregar produtos que constam nos XML's :"
            .Top       = 184
            .Left      = 55
            .Width     = 246
            .Height    = 15
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Say5 "Movimentacoes :" (titulo de secao acima da grdEstoque)
        loc_oAba1.AddObject("lbl_4c_Movimentacoes", "Label")
        WITH loc_oAba1.lbl_4c_Movimentacoes
            .Caption   = "Movimenta" + CHR(231) + CHR(245) + "es :"
            .Top       = 204
            .Left      = 203
            .Width     = 100
            .Height    = 15
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- grdEstoque -> grd_4c_Estoque (legado: MontaGrade popula via
        *-- SigMvCab/SigCdOpe/SigOpCdd - usado pelos lookups de Conta/Grupo/
        *-- Cpf ao final da validacao, regra "ThisForm.Montagrade(.T.)")
        loc_oAba1.AddObject("grd_4c_Estoque", "Grid")
        loc_oGrid = loc_oAba1.grd_4c_Estoque
        loc_oGrid.Top                = 206
        loc_oGrid.Left               = 307
        loc_oGrid.Width              = 545
        loc_oGrid.Height             = 340
        loc_oGrid.ColumnCount        = 5
        loc_oGrid.FontName           = "Tahoma"
        loc_oGrid.FontSize           = 8
        loc_oGrid.ForeColor          = RGB(0, 0, 0)
        loc_oGrid.BackColor          = RGB(255, 255, 255)
        loc_oGrid.GridLineColor      = RGB(238, 238, 238)
        loc_oGrid.AllowHeaderSizing  = .F.
        loc_oGrid.AllowRowSizing     = .F.
        loc_oGrid.DeleteMark         = .F.
        loc_oGrid.RecordMark         = .T.
        loc_oGrid.RowHeight          = 16
        loc_oGrid.ScrollBars         = 2
        loc_oGrid.GridLines          = 3
        loc_oGrid.ReadOnly           = .T.
        WITH loc_oGrid
            .Column1.Width               = 70
            .Column1.Header1.Alignment   = 2
            .Column1.Header1.Caption     = "Empresa"
            .Column1.Header1.ForeColor   = RGB(90, 90, 90)
            .Column1.Header1.BackColor   = RGB(192, 192, 192)

            .Column2.Width               = 200
            .Column2.Header1.Alignment   = 2
            .Column2.Header1.Caption     = "Movimenta" + CHR(231) + CHR(227) + "o"
            .Column2.Header1.ForeColor   = RGB(90, 90, 90)
            .Column2.Header1.BackColor   = RGB(192, 192, 192)

            .Column3.Width               = 80
            .Column3.Header1.Alignment   = 2
            .Column3.Header1.Caption     = "Numero"
            .Column3.Header1.ForeColor   = RGB(90, 90, 90)
            .Column3.Header1.BackColor   = RGB(192, 192, 192)

            .Column4.Width               = 80
            .Column4.Movable             = .F.
            .Column4.Resizable           = .F.
            .Column4.Header1.Alignment   = 2
            .Column4.Header1.Caption     = "Grupo"
            .Column4.Header1.ForeColor   = RGB(90, 90, 90)
            .Column4.Header1.BackColor   = RGB(192, 192, 192)

            .Column5.Width               = 80
            .Column5.Movable             = .F.
            .Column5.Resizable           = .F.
            .Column5.Header1.Alignment   = 2
            .Column5.Header1.Caption     = "Conta"
            .Column5.Header1.ForeColor   = RGB(90, 90, 90)
            .Column5.Header1.BackColor   = RGB(192, 192, 192)
        ENDWITH
        BINDEVENT(loc_oGrid.Column1.Header1, "Click", THIS, "OrdenarEstoquePorEmpresa")
        BINDEVENT(loc_oGrid.Column2.Header1, "Click", THIS, "OrdenarEstoquePorMovimentacao")
        BINDEVENT(loc_oGrid.Column3.Header1, "Click", THIS, "OrdenarEstoquePorNumero")
        BINDEVENT(loc_oGrid.Column4.Header1, "Click", THIS, "OrdenarEstoquePorGrupo")
        BINDEVENT(loc_oGrid.Column5.Header1, "Click", THIS, "OrdenarEstoquePorConta")

        *-- Shape1 (legado) - decorativo, BackStyle=0/BorderStyle=0 no dump
        *-- original = invisivel (nao desenha preenchimento nem borda);
        *-- transcrito fielmente mesmo assim (regra: nao inventar, so copiar).
        loc_oAba1.AddObject("shp_4c_Shape1", "Shape")
        WITH loc_oAba1.shp_4c_Shape1
            .Top         = 2
            .Left        = 912
            .Width       = 90
            .Height      = 110
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
        ENDWITH

        *-- processar -> cmd_4c_Processar (legado nao declara Width/Height/
        *-- FontName - herdados de Pageframe1.Page1: FontName="Tahoma",
        *-- FontBold=.T., FontSize=8, ForeColor=RGB(90,90,90),
        *-- BackColor=RGB(255,255,255); 75x75 pelo padrao dos demais botoes
        *-- com icone "_60" deste form (Confirmar/Cancelar/Movimento).
        loc_oAba1.AddObject("cmd_4c_Processar", "CommandButton")
        WITH loc_oAba1.cmd_4c_Processar
            .Caption         = "Processar"
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 962
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH
        BINDEVENT(loc_oAba1.cmd_4c_Processar, "Click", THIS, "ProcessarArquivoXmlClick")

        *-- btnCadastros -> cmd_4c_BtnCadastros (legado: FontName/ForeColor
        *-- herdados de Pageframe1.Page1 - Tahoma, ForeColor RGB(90,90,90))
        loc_oAba1.AddObject("cmd_4c_BtnCadastros", "CommandButton")
        WITH loc_oAba1.cmd_4c_BtnCadastros
            .Caption       = ""
            .Picture       = gc_4c_CaminhoIcones + "geral_pastas_28.jpg"
            .Top           = 70
            .Left          = 708
            .Width         = 40
            .Height        = 40
            .FontName      = "Tahoma"
            .FontSize      = 7
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .SpecialEffect = 0
            .ToolTipText   = "<F3> Acessa o Cadastro Desta Conta"
        ENDWITH
        BINDEVENT(loc_oAba1.cmd_4c_BtnCadastros, "Click", THIS, "BtnCadastrosContaClick")

        *-- Bot_Consulta -> cmd_4c_Bot_Consulta (todas as props explicitas no dump)
        loc_oAba1.AddObject("cmd_4c_Bot_Consulta", "CommandButton")
        WITH loc_oAba1.cmd_4c_Bot_Consulta
            .Caption       = ""
            .Picture       = gc_4c_CaminhoIcones + "geral_calendario_26.jpg"
            .Top           = 70
            .Left          = 667
            .Width         = 40
            .Height        = 40
            .FontName      = "Small Fonts"
            .FontSize      = 4
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .SpecialEffect = 0
            .ToolTipText   = "<F5> Faz a Consulta Gen" + CHR(233) + "rica de Vendas desta Conta..."
        ENDWITH
        BINDEVENT(loc_oAba1.cmd_4c_Bot_Consulta, "Click", THIS, "BtnConsultaVendasClick")

        *-- Command12 -> cmd_4c_Command12 (botao "..." - abre o seletor de
        *-- arquivo XML; sem Picture no legado, so texto)
        loc_oAba1.AddObject("cmd_4c_Command12", "CommandButton")
        WITH loc_oAba1.cmd_4c_Command12
            .Caption   = "..."
            .Top       = 157
            .Left      = 667
            .Width     = 20
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Themes    = .F.
        ENDWITH
        BINDEVENT(loc_oAba1.cmd_4c_Command12, "Click", THIS, "SelecionarArquivoXmlClick")

        *-- cmdOperacao -> obj_4c_CmdOperacao (CommandGroup com 1 botao -
        *-- "Movimento"; legado usa PROCEDURE btnOperacao.Valid, mas o unico
        *-- disparo real e o clique - migrado para Click do proprio botao)
        loc_oAba1.AddObject("obj_4c_CmdOperacao", "CommandGroup")
        WITH loc_oAba1.obj_4c_CmdOperacao
            .ButtonCount = 1
            .AutoSize    = .T.
            .Top         = 334
            .Left        = 857
            .Width       = 85
            .Height      = 85
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
        ENDWITH
        WITH loc_oAba1.obj_4c_CmdOperacao.Buttons(1)
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
            .PicturePosition = 13
            .Caption         = "Movimento"
            .ToolTipText     = "Movimenta" + CHR(231) + CHR(227) + "o"
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
        ENDWITH
        BINDEVENT(loc_oAba1.obj_4c_CmdOperacao.Buttons(1), "Click", THIS, "AbrirMovimentoSelecionado")

        *-- ===================================================================
        *-- Aba Movimentacoes (legado: Pagina.Dados.Pageframe1.Page2) - campos
        *-- de exibicao do produto selecionado na grade de distribuicao
        *-- (grdDisponivel/grdItemXml - grids entram em fase posterior).
        *-- Coordenadas ORIGINAIS do SCX (Pageframe1 tem Tabs=.T., sem a
        *-- compensacao +29 do pgf_4c_Paginas externo).
        *-- ===================================================================
        loc_oAba2 = loc_oPagina.pgf_4c_Detalhes.Page2

        *-- lbl_produto "Procurar Produto :"
        loc_oAba2.AddObject("lbl_4c_ProcurarProduto", "Label")
        WITH loc_oAba2.lbl_4c_ProcurarProduto
            .Caption   = "Procurar Produto :"
            .Top       = 74
            .Left      = 8
            .Width     = 91
            .Height    = 15
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- get_produto_inicial -> txt_4c_ProdutoInicial (busca na grade
        *-- crMovimentos/grd_4c_Disponivel - entra em fase posterior)
        loc_oAba2.AddObject("txt_4c_ProdutoInicial", "TextBox")
        WITH loc_oAba2.txt_4c_ProdutoInicial
            .Top           = 90
            .Left          = 8
            .Width         = 108
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K!"
            .MaxLength     = 14
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Value         = ""
        ENDWITH
        BINDEVENT(loc_oAba2.txt_4c_ProdutoInicial, "LostFocus", THIS, "ProcurarProdutoNaGrade")

        *-- Sistema - barra de titulo acima da grd_4c_Disponivel (fase posterior)
        loc_oAba2.AddObject("txt_4c_Sistema", "TextBox")
        WITH loc_oAba2.txt_4c_Sistema
            .Top       = 113
            .Left      = 8
            .Width     = 684
            .Height    = 20
            .Alignment = 2
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackColor = RGB(128, 255, 255)
            .ForeColor = RGB(0, 0, 0)
            .ReadOnly  = .T.
            .Value     = "Sistema"
        ENDWITH

        *-- Arquivo - barra de titulo acima da grd_4c_ItemXml (fase posterior)
        loc_oAba2.AddObject("txt_4c_ArquivoHeader", "TextBox")
        WITH loc_oAba2.txt_4c_ArquivoHeader
            .Top       = 113
            .Left      = 691
            .Width     = 495
            .Height    = 20
            .Alignment = 2
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackColor = RGB(255, 255, 128)
            .ForeColor = RGB(0, 0, 0)
            .ReadOnly  = .T.
            .Value     = "Arquivo"
        ENDWITH

        *-- Say3 "Movimentacao :"
        loc_oAba2.AddObject("lbl_4c_MovimentacaoDetalhe", "Label")
        WITH loc_oAba2.lbl_4c_MovimentacaoDetalhe
            .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
            .Top       = 483
            .Left      = 40
            .Width     = 78
            .Height    = 15
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- getEmps -> txt_4c_MovEmps (exibicao - "When: Return .F." no legado)
        loc_oAba2.AddObject("txt_4c_MovEmps", "TextBox")
        WITH loc_oAba2.txt_4c_MovEmps
            .Top           = 480
            .Left          = 122
            .Width         = 65
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K!"
            .Alignment     = 3
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .ReadOnly      = .T.
            .Value         = ""
        ENDWITH

        *-- getDopes -> txt_4c_MovDopes (exibicao)
        loc_oAba2.AddObject("txt_4c_MovDopes", "TextBox")
        WITH loc_oAba2.txt_4c_MovDopes
            .Top           = 480
            .Left          = 188
            .Width         = 205
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K!"
            .Alignment     = 3
            .MaxLength     = 20
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .ReadOnly      = .T.
            .Value         = ""
        ENDWITH

        *-- getNumes -> txt_4c_MovNumes (exibicao)
        loc_oAba2.AddObject("txt_4c_MovNumes", "TextBox")
        WITH loc_oAba2.txt_4c_MovNumes
            .Top           = 480
            .Left          = 393
            .Width         = 65
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K!"
            .Alignment     = 3
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .ReadOnly      = .T.
            .Value         = ""
        ENDWITH

        *-- getcIdChaves -> txt_4c_MovCidChaves (exibicao)
        loc_oAba2.AddObject("txt_4c_MovCidChaves", "TextBox")
        WITH loc_oAba2.txt_4c_MovCidChaves
            .Top           = 480
            .Left          = 459
            .Width         = 173
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K!"
            .Alignment     = 3
            .MaxLength     = 20
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .ReadOnly      = .T.
            .Value         = ""
        ENDWITH

        *-- lbl_ref_fornecedor "Ref. Fornecedor :"
        loc_oAba2.AddObject("lbl_4c_RefFornecedor", "Label")
        WITH loc_oAba2.lbl_4c_RefFornecedor
            .Caption   = "Ref. Fornecedor :"
            .Top       = 505
            .Left      = 30
            .Width     = 88
            .Height    = 15
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- get_ref_fornecedor -> txt_4c_RefFornecedor (exibicao)
        loc_oAba2.AddObject("txt_4c_RefFornecedor", "TextBox")
        WITH loc_oAba2.txt_4c_RefFornecedor
            .Top           = 502
            .Left          = 122
            .Width         = 190
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K!"
            .MaxLength     = 20
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .ReadOnly      = .T.
            .Value         = ""
        ENDWITH

        *-- get_precoMov -> txt_4c_PrecoMov (exibicao)
        loc_oAba2.AddObject("txt_4c_PrecoMov", "TextBox")
        WITH loc_oAba2.txt_4c_PrecoMov
            .Top           = 524
            .Left          = 122
            .Width         = 108
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "99,999.99999"
            .Alignment     = 3
            .MaxLength     = 10
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .ReadOnly      = .T.
            .Value         = 0
        ENDWITH

        *-- Say5 "Custo :"
        loc_oAba2.AddObject("lbl_4c_Custo", "Label")
        WITH loc_oAba2.lbl_4c_Custo
            .Caption   = "Custo :"
            .Top       = 527
            .Left      = 81
            .Width     = 37
            .Height    = 15
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- get_custofs -> txt_4c_CustoFs (exibicao)
        loc_oAba2.AddObject("txt_4c_CustoFs", "TextBox")
        WITH loc_oAba2.txt_4c_CustoFs
            .Top           = 568
            .Left          = 122
            .Width         = 108
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "99,999.99999"
            .Alignment     = 3
            .MaxLength     = 10
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .ReadOnly      = .T.
            .Value         = 0
        ENDWITH

        *-- Say2 "Preco Custo :"
        loc_oAba2.AddObject("lbl_4c_PrecoCusto", "Label")
        WITH loc_oAba2.lbl_4c_PrecoCusto
            .Caption   = "Pre" + CHR(231) + "o Custo :"
            .Top       = 571
            .Left      = 51
            .Width     = 67
            .Height    = 15
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- get_moecusfs -> txt_4c_MoeCusFs (exibicao)
        loc_oAba2.AddObject("txt_4c_MoeCusFs", "TextBox")
        WITH loc_oAba2.txt_4c_MoeCusFs
            .Top           = 568
            .Left          = 231
            .Width         = 31
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K!"
            .Alignment     = 3
            .MaxLength     = 3
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .ReadOnly      = .T.
            .Value         = ""
        ENDWITH

        *-- get_pr_venda -> txt_4c_PrVenda (exibicao)
        loc_oAba2.AddObject("txt_4c_PrVenda", "TextBox")
        WITH loc_oAba2.txt_4c_PrVenda
            .Top           = 546
            .Left          = 122
            .Width         = 108
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "99,999.99999"
            .Alignment     = 3
            .MaxLength     = 10
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .ReadOnly      = .T.
            .Value         = 0
        ENDWITH

        *-- lbl_pr_venda "Preco Venda :"
        loc_oAba2.AddObject("lbl_4c_PrecoVenda", "Label")
        WITH loc_oAba2.lbl_4c_PrecoVenda
            .Caption   = "Pre" + CHR(231) + "o Venda :"
            .Top       = 549
            .Left      = 49
            .Width     = 69
            .Height    = 15
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- get_pr_venda_moeda -> txt_4c_PrVendaMoeda (exibicao)
        loc_oAba2.AddObject("txt_4c_PrVendaMoeda", "TextBox")
        WITH loc_oAba2.txt_4c_PrVendaMoeda
            .Top           = 546
            .Left          = 231
            .Width         = 31
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K!"
            .Alignment     = 3
            .MaxLength     = 3
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .ReadOnly      = .T.
            .Value         = ""
        ENDWITH

        *-- Say1 "Peso :"
        loc_oAba2.AddObject("lbl_4c_Peso", "Label")
        WITH loc_oAba2.lbl_4c_Peso
            .Caption   = "Peso :"
            .Top       = 550
            .Left      = 348
            .Width     = 32
            .Height    = 15
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- get_peso_medio -> txt_4c_PesoMedio (exibicao)
        loc_oAba2.AddObject("txt_4c_PesoMedio", "TextBox")
        WITH loc_oAba2.txt_4c_PesoMedio
            .Top           = 547
            .Left          = 383
            .Width         = 75
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "99,999.999"
            .Alignment     = 3
            .MaxLength     = 10
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .ReadOnly      = .T.
            .Value         = 0
        ENDWITH

        THIS.ConfigurarPgPage2()

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPgPage2 - Restante da aba Movimentacoes (legado: Pagina.Dados.
    * Pageframe1.Page2) - Shape5 (moldura decorativa da foto), os grids
    * grd_4c_Disponivel/grd_4c_ItemXml (legado: grdDisponivel/grdItemXml),
    * img_4c_FigJpg (foto do produto) e os botoes de exclusao de linha
    * (btnExcluirSis/btnExcluirArq). Os demais controles desta aba (labels e
    * TextBox de exibicao) ja foram criados em ConfigurarPaginaDados.
    * ControlSource dos grids NAO e atribuido aqui - crMovimentos/crDistribui
    * ainda nao existem neste ponto do Init (regra #41); e feito em
    * ExecutarProcessamentoXml, quando os cursores ja foram criados.
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPgPage2()
        LOCAL loc_oAba2, loc_oGrid
        loc_oAba2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page2

        *-- Shape5 - moldura ao redor da foto do produto (FigJpg)
        loc_oAba2.AddObject("shp_4c_Shape5", "Shape")
        WITH loc_oAba2.shp_4c_Shape5
            .Top         = 1
            .Left        = 424
            .Width       = 282
            .Height      = 113
            .BackStyle   = 0
            .BorderStyle = 1
            .BorderWidth = 2
            .SpecialEffect = 0
        ENDWITH

        *-- grdDisponivel -> grd_4c_Disponivel (movimentos disponiveis para
        *-- distribuicao - crMovimentos, populado em ExecutarProcessamentoXml)
        loc_oAba2.AddObject("grd_4c_Disponivel", "Grid")
        loc_oGrid = loc_oAba2.grd_4c_Disponivel
        loc_oGrid.Top                = 134
        loc_oGrid.Left               = 8
        loc_oGrid.Width              = 684
        loc_oGrid.Height             = 344
        loc_oGrid.ColumnCount        = 7
        loc_oGrid.FontName           = "Tahoma"
        loc_oGrid.FontSize           = 8
        loc_oGrid.ReadOnly           = .T.
        loc_oGrid.RecordMark         = .F.
        loc_oGrid.RowHeight          = 17
        loc_oGrid.BackColor          = RGB(237, 242, 243)
        loc_oGrid.GridLineColor      = RGB(238, 238, 238)
        loc_oGrid.HighlightForeColor = RGB(15, 41, 104)
        loc_oGrid.HighlightStyle     = 2
        WITH loc_oGrid
            .Column1.Width             = 100
            .Column1.Movable           = .F.
            .Column1.Resizable         = .F.
            .Column1.ReadOnly          = .T.
            .Column1.ForeColor         = RGB(0, 0, 255)
            .Column1.BackColor         = RGB(237, 242, 243)
            .Column1.MousePointer      = 99
            .Column1.MouseIcon         = gc_4c_CaminhoIcones + "H_POINT.CUR"
            .Column1.Header1.Alignment = 2
            .Column1.Header1.Caption   = "C" + CHR(243) + "digo"
            .Column1.Header1.ForeColor = RGB(90, 90, 90)

            .Column2.Width             = 235
            .Column2.Movable           = .F.
            .Column2.Resizable         = .F.
            .Column2.ReadOnly          = .T.
            .Column2.BackColor         = RGB(237, 242, 243)
            .Column2.Header1.Alignment = 2
            .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
            .Column2.Header1.ForeColor = RGB(90, 90, 90)

            .Column3.Width             = 70
            .Column3.Movable           = .F.
            .Column3.Resizable         = .F.
            .Column3.ReadOnly          = .T.
            .Column3.ForeColor         = RGB(0, 0, 0)
            .Column3.BackColor         = RGB(237, 242, 243)
            .Column3.Header1.Alignment = 2
            .Column3.Header1.Caption   = "Valor"
            .Column3.Header1.ForeColor = RGB(90, 90, 90)

            .Column4.FontBold          = .T.
            .Column4.Width             = 63
            .Column4.Movable           = .F.
            .Column4.Resizable         = .F.
            .Column4.ReadOnly          = .T.
            .Column4.Format            = "9"
            .Column4.ForeColor         = RGB(0, 0, 0)
            .Column4.BackColor         = RGB(237, 242, 243)
            .Column4.Header1.Alignment = 2
            .Column4.Header1.Caption   = "Quantidade"
            .Column4.Header1.ForeColor = RGB(90, 90, 90)

            .Column5.FontBold          = .T.
            .Column5.Width             = 63
            .Column5.Movable           = .F.
            .Column5.Resizable         = .F.
            .Column5.ReadOnly          = .T.
            .Column5.Format            = "9"
            .Column5.ForeColor         = RGB(0, 0, 0)
            .Column5.BackColor         = RGB(237, 242, 243)
            .Column5.Header1.Alignment = 2
            .Column5.Header1.Caption   = "Baixado"
            .Column5.Header1.ForeColor = RGB(90, 90, 90)

            .Column6.FontBold          = .T.
            .Column6.Width             = 63
            .Column6.Movable           = .F.
            .Column6.Resizable         = .F.
            .Column6.ReadOnly          = .T.
            .Column6.Format            = "9"
            .Column6.ForeColor         = RGB(0, 0, 0)
            .Column6.BackColor         = RGB(237, 242, 243)
            .Column6.Header1.Alignment = 2
            .Column6.Header1.Caption   = "Reservado"
            .Column6.Header1.ForeColor = RGB(90, 90, 90)

            .Column7.FontBold          = .T.
            .Column7.Width             = 63
            .Column7.Movable           = .F.
            .Column7.Resizable         = .F.
            .Column7.ReadOnly          = .T.
            .Column7.BackColor         = RGB(237, 242, 243)
            .Column7.Header1.Alignment = 2
            .Column7.Header1.Caption   = "Saldo"
            .Column7.Header1.ForeColor = RGB(90, 90, 90)
        ENDWITH
        BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "AtualizarDetalhesProdutoSelecionado")
        BINDEVENT(loc_oGrid.Column1.Text1, "DblClick", THIS, "AbrirPesquisaGlobalProduto")

        *-- grdItemXml -> grd_4c_ItemXml (produtos distribuidos - crDistribui,
        *-- populado em ExecutarProcessamentoXml). Column3 (Quantidade) e a
        *-- UNICA editavel - o legado nao marca ReadOnly/Enabled nela.
        loc_oAba2.AddObject("grd_4c_ItemXml", "Grid")
        loc_oGrid = loc_oAba2.grd_4c_ItemXml
        loc_oGrid.Top           = 134
        loc_oGrid.Left          = 693
        loc_oGrid.Width         = 493
        loc_oGrid.Height        = 344
        loc_oGrid.ColumnCount   = 4
        loc_oGrid.FontName      = "Tahoma"
        loc_oGrid.FontSize      = 8
        loc_oGrid.RecordMark    = .F.
        loc_oGrid.RowHeight     = 17
        loc_oGrid.BackColor     = RGB(237, 242, 243)
        loc_oGrid.GridLineColor = RGB(238, 238, 238)
        WITH loc_oGrid
            .Column1.Enabled           = .F.
            .Column1.Width             = 100
            .Column1.Movable           = .F.
            .Column1.Resizable         = .F.
            .Column1.ReadOnly          = .T.
            .Column1.ForeColor         = RGB(0, 0, 0)
            .Column1.BackColor         = RGB(237, 242, 243)
            .Column1.Header1.Alignment = 2
            .Column1.Header1.Caption   = "C" + CHR(243) + "digo"
            .Column1.Header1.ForeColor = RGB(90, 90, 90)

            .Column2.Enabled           = .F.
            .Column2.Width             = 235
            .Column2.Movable           = .F.
            .Column2.Resizable         = .F.
            .Column2.ReadOnly          = .T.
            .Column2.ForeColor         = RGB(0, 0, 0)
            .Column2.BackColor         = RGB(237, 242, 243)
            .Column2.Header1.Alignment = 2
            .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
            .Column2.Header1.ForeColor = RGB(90, 90, 90)

            .Column3.Width             = 63
            .Column3.Movable           = .F.
            .Column3.Resizable         = .F.
            .Column3.InputMask         = "999999"
            .Column3.ForeColor         = RGB(0, 0, 0)
            .Column3.BackColor         = RGB(237, 242, 243)
            .Column3.Header1.Alignment = 2
            .Column3.Header1.Caption   = "Quantidade"
            .Column3.Header1.ForeColor = RGB(90, 90, 90)

            .Column4.Enabled           = .F.
            .Column4.Width             = 70
            .Column4.Movable           = .F.
            .Column4.Resizable         = .F.
            .Column4.ReadOnly          = .T.
            .Column4.BackColor         = RGB(237, 242, 243)
            .Column4.Header1.Alignment = 2
            .Column4.Header1.Caption   = "Valor"
            .Column4.Header1.ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- FigJpg -> img_4c_FigJpg (foto do produto - atualizada em
        *-- AtualizarDetalhesProdutoSelecionado)
        loc_oAba2.AddObject("img_4c_FigJpg", "Image")
        WITH loc_oAba2.img_4c_FigJpg
            .Top      = 3
            .Left      = 426
            .Width     = 278
            .Height    = 109
            .Stretch   = 1
            .Visible   = .F.
        ENDWITH
        BINDEVENT(loc_oAba2.img_4c_FigJpg, "DblClick", THIS, "FigJpgDblClick")

        *-- btnExcluirSis -> cmd_4c_BtnExcluirSis (exclui linha de crMovimentos)
        loc_oAba2.AddObject("cmd_4c_BtnExcluirSis", "CommandButton")
        WITH loc_oAba2.cmd_4c_BtnExcluirSis
            .Caption     = ""
            .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .Top         = 479
            .Left        = 663
            .Width       = 40
            .Height      = 37
            .FontName    = "Arial"
            .FontSize    = 7
            .ForeColor   = RGB(255, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .TabStop     = .F.
            .ToolTipText = "Excluir Linha da Grade Sistema"
        ENDWITH
        BINDEVENT(loc_oAba2.cmd_4c_BtnExcluirSis, "Click", THIS, "BtnExcluirSisClick")

        *-- btnExcluirArq -> cmd_4c_BtnExcluirArq (exclui linha de crDistribui)
        loc_oAba2.AddObject("cmd_4c_BtnExcluirArq", "CommandButton")
        WITH loc_oAba2.cmd_4c_BtnExcluirArq
            .Caption     = ""
            .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .Top         = 479
            .Left        = 1146
            .Width       = 40
            .Height      = 37
            .FontName    = "Arial"
            .FontSize    = 7
            .ForeColor   = RGB(255, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .TabStop     = .F.
            .ToolTipText = "Excluir Linha da Grade Arquivo"
        ENDWITH
        BINDEVENT(loc_oAba2.cmd_4c_BtnExcluirArq, "Click", THIS, "BtnExcluirArqClick")
    ENDPROC

    *===========================================================================
    * MontaGrade - Popula grd_4c_Estoque com os movimentos distribuiveis
    * (legado: PROCEDURE montagrade). Chamada ao final das validacoes de
    * Conta/Grupo/Cpf (ThisForm.Montagrade(.T.)) para filtrar pela conta do
    * fornecedor digitado.
    *===========================================================================
    PROCEDURE MontaGrade(par_lFiltra)
        LOCAL loc_oGrid, loc_cConta, loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_oGrid  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1.grd_4c_Estoque
            loc_cConta = ALLTRIM(THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1.txt_4c_Conta.Value)

            loc_oGrid.RecordSource = ""

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT 0 AS nMarca, a.Emps, a.Dopes, a.Numes,
                    a.EmpDopNums AS OriDopNums, a.grupoOs AS Grupos, a.contaOs AS Contas
                FROM SigMvCab a
                JOIN SigCdOpe b ON a.dopes = b.dopes
                JOIN SigOpCdd c ON b.dopes = c.dopes
                WHERE c.Distribui = 3
                    AND a.chksubn = 0
                    AND a.GrupoOs <> SPACE(10) AND a.ContaOs <> SPACE(10)
                    <<IIF(par_lFiltra AND !EMPTY(loc_cConta), " AND a.ContaOs = " + EscaparSQL(loc_cConta), "")>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Estoque")

            IF loc_nResultado >= 0
                loc_oGrid.ColumnCount            = 5
                loc_oGrid.RecordSource           = "cursor_4c_Estoque"
                loc_oGrid.Column1.ControlSource  = "cursor_4c_Estoque.Emps"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Estoque.Dopes"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Estoque.Numes"
                loc_oGrid.Column4.ControlSource = "cursor_4c_Estoque.Grupos"
                loc_oGrid.Column5.ControlSource = "cursor_4c_Estoque.Contas"

                loc_oGrid.Column1.Header1.Caption = "Empresa"
                loc_oGrid.Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
                loc_oGrid.Column3.Header1.Caption = "Numero"
                loc_oGrid.Column4.Header1.Caption = "Grupo"
                loc_oGrid.Column5.Header1.Caption = "Conta"

                loc_oGrid.Column1.Width = 70
                loc_oGrid.Column2.Width = 200
                loc_oGrid.Column3.Width = 80
                loc_oGrid.Column4.Width = 80
                loc_oGrid.Column5.Width = 80

                IF USED("cursor_4c_Estoque")
                    GO TOP IN cursor_4c_Estoque
                ENDIF
                loc_oGrid.Refresh()
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao montar grade de estoque:" + CHR(13) + CapturarErroSQL(), "MontaGrade")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormSigPrCtr.MontaGrade")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * OrdenarEstoquePorEmpresa/Movimentacao/Numero/Grupo/Conta - Header1.Click
    * das colunas do grd_4c_Estoque (legado: grdEstoque.ColumnN.Header1.Click)
    *===========================================================================
    PROCEDURE OrdenarEstoquePorCampo(par_cCampo, par_nColuna)
        LOCAL loc_oGrid, loc_nI
        TRY
            IF USED("cursor_4c_Estoque")
                SELECT cursor_4c_Estoque
                INDEX ON &par_cCampo TAG (par_cCampo)
            ENDIF

            loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1.grd_4c_Estoque
            FOR loc_nI = 1 TO loc_oGrid.ColumnCount
                loc_oGrid.Columns(loc_nI).Header1.BackColor = IIF(loc_nI = par_nColuna, ;
                    RGB(251, 253, 176), RGB(192, 192, 192))
            ENDFOR
            loc_oGrid.Refresh()
        CATCH TO loException
            MostrarErro(loException, "FormSigPrCtr.OrdenarEstoquePorCampo")
        ENDTRY
    ENDPROC

    PROCEDURE OrdenarEstoquePorEmpresa()
        THIS.OrdenarEstoquePorCampo("Emps", 1)
    ENDPROC

    PROCEDURE OrdenarEstoquePorMovimentacao()
        THIS.OrdenarEstoquePorCampo("Dopes", 2)
    ENDPROC

    PROCEDURE OrdenarEstoquePorNumero()
        THIS.OrdenarEstoquePorCampo("Numes", 3)
    ENDPROC

    PROCEDURE OrdenarEstoquePorGrupo()
        THIS.OrdenarEstoquePorCampo("Grupos", 4)
    ENDPROC

    PROCEDURE OrdenarEstoquePorConta()
        THIS.OrdenarEstoquePorCampo("Contas", 5)
    ENDPROC

    *===========================================================================
    * SelecionarArquivoXmlClick - Click de cmd_4c_Command12 (legado: Command12.
    * Click) - abre o seletor de arquivo nativo do Windows e grava o caminho
    * escolhido em txt_4c_Arquivo.
    *===========================================================================
    PROCEDURE SelecionarArquivoXmlClick()
        LOCAL loc_oPagina, loc_cArquivo
        TRY
            loc_oPagina  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1
            loc_cArquivo = GETFILE("XML")

            IF !EMPTY(loc_cArquivo)
                loc_oPagina.txt_4c_Arquivo.Value = loc_cArquivo
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormSigPrCtr.SelecionarArquivoXmlClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnCadastrosContaClick - Click de cmd_4c_BtnCadastros (legado:
    * btnCadastros.Click) - abre o Cadastro de Contas (SIGCDCTA -> FormCTA) da
    * conta digitada. Show() FORA do TRY (CLAUDE.md #29 - FormCTA e modal).
    *===========================================================================
    PROCEDURE BtnCadastrosContaClick()
        LOCAL loc_oPagina, loc_oForm, loc_oErro
        loc_oForm = .NULL.

        loc_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1

        IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Conta.Value))
            MsgAviso(CHR(201) + " Necess" + CHR(225) + "rio o Preenchimento Da Conta!!!", "Dados Incompletos")
            loc_oPagina.txt_4c_Conta.SetFocus()
        ELSE
            IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "VISUALIZAR")
                TRY
                    loc_oForm = CREATEOBJECT("FormCTA")
                CATCH TO loc_oErro
                    MsgErro("Erro ao abrir o Cadastro de Contas:" + CHR(13) + loc_oErro.Message, "Cadastro de Contas")
                    loc_oForm = .NULL.
                ENDTRY

                IF VARTYPE(loc_oForm) = "O"
                    loc_oForm.Show()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnConsultaVendasClick - Click de cmd_4c_Bot_Consulta (legado:
    * Bot_Consulta.Click) - abriria a Consulta Generica de Vendas (SigOpCgv)
    * da conta digitada. SigOpCgv NAO foi migrada (nao existe FormSigOpCgv no
    * acervo) - degrada graciosamente com aviso, mesmo padrao ja usado em
    * FormSigMvSbn para SigOpZom/SigRePhi. Show() FORA do TRY (CLAUDE.md #29).
    *===========================================================================
    PROCEDURE BtnConsultaVendasClick()
        LOCAL loc_oPagina, loc_oForm, loc_oErro

        loc_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1

        IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Conta.Value))
            MsgAviso(CHR(201) + " necess" + CHR(225) + "rio o preenchimento da Conta...", "Aviso")
            loc_oPagina.txt_4c_Conta.SetFocus()
            RETURN
        ENDIF

        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF

        loc_oForm = .NULL.
        TRY
            loc_oForm = CREATEOBJECT("FormSigOpCgv", THIS, ALLTRIM(loc_oPagina.txt_4c_Conta.Value))
        CATCH TO loc_oErro
            loc_oForm = .NULL.
        ENDTRY

        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ELSE
            MsgAviso("M" + CHR(243) + "dulo de Consulta Gen" + CHR(233) + "rica de Vendas (SigOpCgv) ainda n" + CHR(227) + ;
                "o est" + CHR(225) + " dispon" + CHR(237) + "vel nesta vers" + CHR(227) + "o.", "Aviso")
        ENDIF
    ENDPROC

    *===========================================================================
    * AbrirMovimentoSelecionado - Click do botao "Movimento" de
    * obj_4c_CmdOperacao (legado: cmdOperacao.btnOperacao.Valid - o unico
    * disparo real e o clique) - abre a movimentacao da linha atual de
    * grd_4c_Estoque (Expedicao/SigCdOpe ou Producao/SigCdOpd). Show() FORA
    * do TRY (CLAUDE.md #29 - FormSigMvExp/FormSigMvPdt sao modais).
    *===========================================================================
    PROCEDURE AbrirMovimentoSelecionado()
        LOCAL loc_cEmps, loc_cDopes, loc_nNumes, loc_nResultado, loc_cClasseForm, ;
            loc_oForm, loc_oErro
        loc_cClasseForm = ""

        TRY
            IF !USED("cursor_4c_Estoque") OR EOF("cursor_4c_Estoque") ;
                    OR EMPTY(ALLTRIM(NVL(cursor_4c_Estoque.Emps, ""))) ;
                    OR EMPTY(ALLTRIM(NVL(cursor_4c_Estoque.Dopes, "")))
                MsgAviso("Selecione Um Registro Na Grade!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
            ELSE
                loc_cEmps  = ALLTRIM(cursor_4c_Estoque.Emps)
                loc_cDopes = ALLTRIM(cursor_4c_Estoque.Dopes)
                loc_nNumes = cursor_4c_Estoque.Numes

                IF USED("cursor_4c_TmpOpe")
                    USE IN cursor_4c_TmpOpe
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cDopes), "cursor_4c_TmpOpe")

                IF loc_nResultado > 0 AND USED("cursor_4c_TmpOpe") AND RECCOUNT("cursor_4c_TmpOpe") > 0
                    loc_cClasseForm = "FormSigMvExp"
                ELSE
                    IF USED("cursor_4c_TmpOpd")
                        USE IN cursor_4c_TmpOpd
                    ENDIF
                    loc_nResultado = SQLEXEC(gnConnHandle, ;
                        "SELECT Dopps FROM SigCdOpd WHERE Dopps = " + EscaparSQL(loc_cDopes), "cursor_4c_TmpOpd")

                    IF loc_nResultado > 0 AND USED("cursor_4c_TmpOpd") AND RECCOUNT("cursor_4c_TmpOpd") > 0
                        loc_cClasseForm = "FormSigMvPdt"
                    ENDIF
                ENDIF

                IF USED("cursor_4c_TmpOpe")
                    USE IN cursor_4c_TmpOpe
                ENDIF
                IF USED("cursor_4c_TmpOpd")
                    USE IN cursor_4c_TmpOpd
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormSigPrCtr.AbrirMovimentoSelecionado")
        ENDTRY

        IF !EMPTY(loc_cClasseForm)
            loc_oForm = .NULL.
            TRY
                loc_oForm = CREATEOBJECT(loc_cClasseForm, loc_cDopes, "C", loc_nNumes, loc_cEmps, .T.)
            CATCH TO loc_oErro
                MsgErro("Erro ao abrir movimenta" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, ;
                    "Movimenta" + CHR(231) + CHR(227) + "o")
                loc_oForm = .NULL.
            ENDTRY

            IF VARTYPE(loc_oForm) = "O"
                loc_oForm.Show()
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * CriarCursoresXml - Cursores de trabalho do import de XML (legado: Load
    * do SCX - csPrNAOCad/crItens/crResultado). Mantidos com os nomes
    * ORIGINAIS do legado (sem prefixo cursor_4c_) - mesma convencao ja usada
    * neste form para crMovimentos/crDistribui (ProcurarProdutoNaGrade).
    *===========================================================================
    PROTECTED PROCEDURE CriarCursoresXml()
        IF !USED("csPrNAOCad")
            CREATE CURSOR csPrNAOCad (Referencia C(25), Unidade C(3), Qtds N(12,2), Pesos N(12,2), Valor N(12,2))
        ENDIF

        IF !USED("crItens")
            CREATE CURSOR crItens (codigo C(15), Descr C(30), quant C(15), valor_uni C(15), valor_tot C(15), ;
                base_icm C(15), valor_icm C(15), aliq_icm C(15), base_ipi C(15), valor_ipi C(15), aliq_ipi C(15), ;
                unid C(5), cfop C(4), ncm C(8), desconto C(15), frete C(15))
        ENDIF

        IF !USED("crResultado")
            CREATE CURSOR crResultado (xTp C(1), cpros C(14), dpros C(60), Qtds N(12,2), Units N(12,2), Total N(12,2))
        ENDIF
    ENDPROC

    *===========================================================================
    * CarregarArquivosXml - Confere o CPF/CNPJ do fornecedor contra a chave de
    * acesso do XML e decide se prossegue com a leitura (legado: PROCEDURE
    * carregaarquivos - o parametro pTipo legado so controla se Lerxml roda).
    *===========================================================================
    PROTECTED PROCEDURE CarregarArquivosXml(par_lProcessar)
        LOCAL loc_oPagina, loc_cArquivo, loc_cCgc, loc_cConteudo, loc_cChave, ;
            loc_cCgcXml, loc_lOk, loc_cMsg

        loc_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1

        IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Conta.Value))
            MsgAviso("Favor Informar uma Conta.", "Aviso")
            RETURN .F.
        ENDIF

        loc_cArquivo = loc_oPagina.txt_4c_Arquivo.Value
        loc_cCgc     = ALLTRIM(STRTRAN(STRTRAN(STRTRAN(loc_oPagina.txt_4c_Cpf.Value, ".", ""), "/", ""), "-", ""))

        IF ALLTRIM(UPPER(RIGHT(JUSTFNAME(loc_cArquivo), 3))) != "XML"
            MsgAviso("Arquivo est" + CHR(225) + " em formato diferente de XML.", "Aviso")
            RETURN .F.
        ENDIF

        IF !EMPTY(loc_cArquivo) AND !EMPTY(loc_cCgc)
            loc_cArquivo  = ALLTRIM(loc_cArquivo)
            loc_cConteudo = ALLTRIM(UPPER(FILETOSTR(loc_cArquivo)))

            IF !EMPTY(loc_cConteudo)
                loc_cChave  = ALLTRIM(STREXTRACT(loc_cConteudo, "<CHNFE>", "</CHNFE>"))
                loc_cCgcXml = SUBSTR(loc_cChave, 7, 14)
                loc_lOk     = .T.

                IF loc_cCgcXml != loc_cCgc
                    loc_lOk  = .F.
                    loc_cMsg = "Fornecedor com CPF/CNPJ Diferente do XML," + CHR(13) + ;
                        "Arquivo XML: " + loc_cCgcXml + CHR(13) + ;
                        "Fornecedor: " + loc_cCgc + CHR(13) + ;
                        "Deseja Continuar?"
                    IF MsgConfirma(loc_cMsg, "Aten" + CHR(231) + CHR(227) + "o")
                        loc_lOk = .T.
                    ENDIF
                ENDIF

                IF loc_lOk AND par_lProcessar
                    THIS.LerArquivoXml(loc_cArquivo)
                ENDIF
            ENDIF
        ENDIF

        RETURN .T.
    ENDPROC

    *===========================================================================
    * LerArquivoXml - Le o XML de NF-e e popula crItens com os itens do
    * documento (legado: PROCEDURE lerxml). Os demais campos do cabecalho
    * (emitente/destinatario/impostos totais) sao extraidos no legado mas
    * NUNCA referenciados em nenhum outro metodo do dump - leitura morta,
    * omitida aqui (nao ha regra de negocio ativa a preservar).
    *===========================================================================
    PROTECTED PROCEDURE LerArquivoXml(par_cArquivo)
        LOCAL loc_oXml, loc_oItem, loc_nQtdItens, loc_nI, loc_nContaDesconto, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(par_cArquivo) OR !FILE(par_cArquivo)
            RETURN .F.
        ENDIF

        THIS.CriarCursoresXml()

        TRY
            loc_oXml = CREATEOBJECT("MSXML.DOMDOCUMENT")

            IF !loc_oXml.Load(par_cArquivo)
                MsgErro(par_cArquivo + " est" + CHR(225) + " corrompido.", "Aviso")
            ELSE
                IF UPPER(loc_oXml.DocumentElement.BaseName) = "NFEPROC"
                    loc_nQtdItens      = loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det").Length
                    loc_nContaDesconto = 0

                    SELECT crItens
                    FOR loc_nI = 0 TO loc_nQtdItens - 1
                        loc_oItem = loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det").Item(loc_nI)

                        APPEND BLANK IN crItens
                        REPLACE codigo    WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/cProd").ItemText, ;
                                Descr     WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/xProd").ItemText, ;
                                quant     WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/qCom").ItemText, ;
                                valor_uni WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/vUnCom").ItemText, ;
                                valor_tot WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/vProd").ItemText, ;
                                unid      WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/uCom").ItemText, ;
                                cfop      WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/CFOP").ItemText, ;
                                ncm       WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/NCM").ItemText ;
                                IN crItens

                        IF loc_oItem.SelectNodes("prod/vDesc").Length > 0
                            REPLACE desconto WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/vDesc").ItemText IN crItens
                            loc_nContaDesconto = loc_nContaDesconto + 1
                        ENDIF

                        IF loc_oItem.SelectNodes("prod/vFrete").Length > 0
                            REPLACE frete WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/vFrete").ItemText IN crItens
                        ENDIF
                    ENDFOR

                    loc_lSucesso = .T.
                ELSE
                    MsgAviso(par_cArquivo + " n" + CHR(227) + "o " + CHR(233) + " uma nota fiscal com autoriza" + CHR(231) + CHR(227) + "o!", "Aviso")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormSigPrCtr.LerArquivoXml")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * CarregarItensXmlNaGrade - Localiza cada item de crItens em SigCdPro
    * (Reffs -> Cpros -> Dpros -> Dpro2s) e acumula o resultado em
    * crResultado/csPrNAOCad (legado: PROCEDURE carregaritemxml). Os blocos
    * de SigCdTam/SigCdCor do legado sao INALCANCAVEIS (lcTam/lcCor sao
    * zerados incondicionalmente antes do IF que os testaria) - omitidos
    * aqui, nao sao regra de negocio viva.
    *===========================================================================
    PROTECTED PROCEDURE CarregarItensXmlNaGrade()
        LOCAL loc_cProd, loc_nQtds, loc_cCunis, loc_nVal, loc_nTot, loc_nBaseIcm, ;
            loc_nValorIpi, loc_cTp, loc_nVariaProd, loc_nResultado, loc_cArquivoSaida

        IF !USED("crItens")
            RETURN .F.
        ENDIF

        TRY
            SELECT crItens
            GO TOP IN crItens
            SCAN
                loc_cProd  = NVL(crItens.codigo, "")
                loc_nQtds  = IIF(TYPE("crItens.quant") = "N", NVL(crItens.quant, 0), VAL(NVL(crItens.quant, "")))
                loc_cCunis = IIF(INLIST(TYPE("crItens.unid"), "C", "M"), NVL(crItens.unid, ""), "")
                loc_nVal   = IIF(INLIST(TYPE("crItens.valor_uni"), "C", "M"), VAL(NVL(crItens.valor_uni, "")), ;
                    IIF(TYPE("crItens.valor_uni") = "N", NVL(crItens.valor_uni, 0), 0))
                loc_nTot   = IIF(INLIST(TYPE("crItens.valor_tot"), "C", "M"), VAL(NVL(crItens.valor_tot, "")), ;
                    IIF(TYPE("crItens.valor_tot") = "N", NVL(crItens.valor_tot, 0), 0))
                loc_nBaseIcm  = IIF(INLIST(TYPE("crItens.base_icm"), "C", "M"), VAL(NVL(crItens.base_icm, "")), ;
                    IIF(TYPE("crItens.base_icm") = "N", NVL(crItens.base_icm, 0), 0))
                loc_nValorIpi = IIF(INLIST(TYPE("crItens.valor_ipi"), "C", "M"), VAL(NVL(crItens.valor_ipi, "")), ;
                    IIF(TYPE("crItens.valor_ipi") = "N", NVL(crItens.valor_ipi, 0), 0))

                IF !EMPTY(loc_cProd)
                    IF USED("ProdImport")
                        USE IN ProdImport
                    ENDIF
                    loc_nResultado = SQLEXEC(gnConnHandle, ;
                        "SELECT * FROM SigCdPro WHERE Reffs = " + EscaparSQL(loc_cProd), "ProdImport")
                    IF loc_nResultado < 1
                        MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (ProdImport)")
                        LOOP
                    ENDIF

                    IF RECCOUNT("ProdImport") = 0
                        USE IN ProdImport
                        loc_nResultado = SQLEXEC(gnConnHandle, ;
                            "SELECT * FROM SigCdPro WHERE Cpros = " + EscaparSQL(loc_cProd), "ProdImport")
                        IF loc_nResultado < 1
                            MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (ProdImport)")
                            LOOP
                        ENDIF
                    ENDIF

                    IF RECCOUNT("ProdImport") = 0
                        USE IN ProdImport
                        loc_nResultado = SQLEXEC(gnConnHandle, ;
                            "SELECT * FROM SigCdPro WHERE Dpros = " + EscaparSQL(loc_cProd), "ProdImport")
                        IF loc_nResultado < 1
                            MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (ProdImport)")
                            LOOP
                        ENDIF
                    ENDIF

                    IF RECCOUNT("ProdImport") = 0
                        USE IN ProdImport
                        loc_nResultado = SQLEXEC(gnConnHandle, ;
                            "SELECT * FROM SigCdPro WHERE Dpro2s = " + EscaparSQL(loc_cProd), "ProdImport")
                        IF loc_nResultado < 1
                            MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (ProdImport)")
                            LOOP
                        ENDIF
                    ENDIF

                    IF USED("ProdImport") AND !EMPTY(NVL(ProdImport.Cpros, ""))
                        loc_cCunis = IIF(EMPTY(ProdImport.Cunis), loc_cCunis, ProdImport.Cunis)

                        IF USED("crTmpUni")
                            USE IN crTmpUni
                        ENDIF
                        SQLEXEC(gnConnHandle, ;
                            "SELECT * FROM SigCdUni WHERE CUnis = " + EscaparSQL(loc_cCunis) + " ORDER BY Etiqs", "crTmpUni")

                        IF USED("crTmpGru")
                            USE IN crTmpGru
                        ENDIF
                        SQLEXEC(gnConnHandle, ;
                            "SELECT TipoEstos, Mercs, Cores, Tams, Embs, Cgrus, Dgrus, Pesos, Entregas, mtPrimas, LocalPdr " + ;
                            "FROM SigCdGrp WHERE CGrus = " + EscaparSQL(ProdImport.CGrus) + ;
                            " ORDER BY TipoEstos, Mercs, Cores, Tams, Embs, Cgrus, Dgrus, Pesos, Entregas", "crTmpGru")

                        loc_cTp = " "
                        IF (loc_nBaseIcm + loc_nValorIpi) != 0 AND ProdImport.CustoFs != (loc_nBaseIcm + loc_nValorIpi)
                            loc_nVariaProd = ROUND(ProdImport.CustoFs * 0.05, 2) + ProdImport.CustoFs
                            IF loc_nVariaProd < (loc_nBaseIcm + loc_nValorIpi)
                                loc_cTp = "X"
                            ENDIF
                        ENDIF

                        SELECT crResultado
                        APPEND BLANK
                        REPLACE Cpros WITH ProdImport.Cpros, ;
                                dpros WITH ProdImport.Dpros, ;
                                xTp   WITH loc_cTp, ;
                                Qtds  WITH loc_nQtds, ;
                                Units WITH loc_nVal, ;
                                Total WITH loc_nTot IN crResultado
                    ELSE
                        SELECT csPrNAOCad
                        APPEND BLANK
                        REPLACE Referencia WITH NVL(loc_cProd, ""), ;
                                Qtds       WITH NVL(loc_nQtds, 0), ;
                                Pesos      WITH 0, ;
                                Unidade    WITH NVL(loc_cCunis, ""), ;
                                Valor      WITH NVL(loc_nVal, 0) IN csPrNAOCad
                    ENDIF

                    IF USED("ProdImport")
                        USE IN ProdImport
                    ENDIF
                ENDIF

                SELECT crItens
            ENDSCAN
        CATCH TO loException
            MostrarErro(loException, "FormSigPrCtr.CarregarItensXmlNaGrade")
        ENDTRY

        IF USED("csPrNAOCad")
            SELECT csPrNAOCad
            GO TOP
            IF RECCOUNT("csPrNAOCad") > 0
                loc_cArquivoSaida = ADDBS(SYS(5) + SYS(2003)) + "Produtos_Nao_Localizados"
                MsgAviso("Houve produtos n" + CHR(227) + "o Localizados" + CHR(13) + CHR(13) + ;
                    "Arquivo : " + loc_cArquivoSaida + ".XLS", "Aten" + CHR(231) + CHR(227) + "o")
                SELECT csPrNAOCad
                COPY TO (loc_cArquivoSaida) XL5
            ENDIF
        ENDIF

        IF USED("crItens")
            SELECT crItens
            GO TOP
        ENDIF

        RETURN .T.
    ENDPROC

    *===========================================================================
    * ProcessarArquivoXmlClick - Click de cmd_4c_Processar (legado: processar.
    * Click) - valida Arquivo/Conta/Cpf preenchidos e delega o processamento.
    *===========================================================================
    PROCEDURE ProcessarArquivoXmlClick()
        LOCAL loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1

            IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Arquivo.Value))
                MsgAviso("Nenhum Diret" + CHR(243) + "rio Foi Informado.", "Aviso")
            ELSE
                IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Conta.Value))
                    MsgAviso("Nenhum Fornecedor Foi Informado.", "Aviso")
                ELSE
                    IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Cpf.Value))
                        MsgAviso("CNPJ/CPF do Fornecedor N" + CHR(227) + "o Informado", "Aviso")
                    ELSE
                        THIS.ExecutarProcessamentoXml(loc_oPagina)
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormSigPrCtr.ProcessarArquivoXmlClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ExecutarProcessamentoXml - Orquestra o import do XML (legado: processar.
    * Click, corpo principal): busca os movimentos distribuiveis da linha
    * ATUAL de grd_4c_Estoque (legado nao faz SCAN - o bloco que somaria
    * todas as linhas marcadas esta comentado no dump original, morto), le o
    * XML/monta crResultado, agrupa em crDistribui, filtra crMovimentos por
    * Opt_Filtro e converte a moeda de cada linha para a moeda base
    * (SigCdPam.moedetqs) antes de exibir nos grids da aba Movimentacoes
    * (grd_4c_Disponivel/grd_4c_ItemXml - concluidos na fase que fecha
    * aquela aba).
    *===========================================================================
    PROTECTED PROCEDURE ExecutarProcessamentoXml(par_oPagina)
        LOCAL loc_oAba2, loc_oGridDisp, loc_oGridItem, loc_nTipo, loc_cOriDopNums, ;
            loc_cMoedaBase, loc_nCotaMoe, loc_cSQL, loc_nResultado, loc_nCotacao, loc_nUnits

        TRY
            loc_oAba2     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page2
            loc_oGridDisp = loc_oAba2.grd_4c_Disponivel
            loc_oGridItem = loc_oAba2.grd_4c_ItemXml

            loc_nTipo = par_oPagina.opt_4c_Filtro.Value

            loc_oGridDisp.RecordSource = ""
            loc_oGridItem.RecordSource = ""

            IF !USED("cursor_4c_Estoque") OR EOF("cursor_4c_Estoque")
                loc_cOriDopNums = ""
            ELSE
                loc_cOriDopNums = cursor_4c_Estoque.OriDopNums
            ENDIF

            loc_cMoedaBase = IIF(USED("crSigCdPam"), ALLTRIM(NVL(crSigCdPam.moedetqs, "")), "")
            loc_nCotaMoe   = THIS.this_oBusinessObject.CarregarCambio(loc_cMoedaBase, DATE())

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT a.Cpros, f.Dpros, a.units,
                    SUM(a.qtds) AS qtds, SUM(a.qtbaixas) AS qtbaixas, SUM(a.qtreservas) AS qtreservas,
                    (SUM(a.qtds) - SUM(a.qtbaixas) - SUM(a.qtreservas)) AS Saldo,
                    a.EmpDopNums AS OriDopNums, f.Cgrus, f.Sgrus, a.cidchaves, a.Moedas
                FROM SigMvItn a
                JOIN SigMvCab c ON a.EmpDopNums = c.EmpDopNums
                JOIN SigCdOpe d ON c.dopes = d.dopes
                JOIN SigOpCdd e ON d.dopes = e.dopes
                JOIN SigCdPro f ON a.Cpros = f.Cpros
                WHERE e.Distribui = 3
                    AND c.GrupoOs <> SPACE(10)
                    AND c.ContaOs <> SPACE(10)
                    AND a.citem2 = 0
                    AND a.qtds <> a.qtbaixas
                    AND a.EmpDopNums IN (<<EscaparSQL(loc_cOriDopNums)>>)
                GROUP BY a.CPros, f.Dpros, f.Cgrus, f.Sgrus, a.EmpDopNums, a.units, a.cidchaves, a.Moedas
            ENDTEXT

            IF USED("crMovimentos")
                USE IN crMovimentos
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crMovimentos")

            IF loc_nResultado < 1
                MsgAviso("Problemas no Select dos Produtos da Movimenta" + CHR(231) + CHR(227) + "o", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                SELECT crMovimentos
                INDEX ON Cgrus TAG Cgrus
                INDEX ON Cpros TAG Cpros
                SET ORDER TO Cpros
                GO TOP

                THIS.CriarCursoresXml()
                SELECT crItens
                ZAP
                SELECT csPrNAOCad
                ZAP
                SELECT crResultado
                ZAP

                THIS.CarregarArquivosXml(.T.)
                THIS.CarregarItensXmlNaGrade()

                IF USED("crDistribui")
                    USE IN crDistribui
                ENDIF
                SELECT Cpros, Dpros, SUM(Qtds) AS Qtds, MAX(Units) AS Units, SUM(Total) AS Total ;
                    FROM crResultado ;
                    GROUP BY Cpros, Dpros ;
                    INTO CURSOR crDistribui READWRITE

                SELECT crDistribui
                INDEX ON cPros TAG Tag1
                SET ORDER TO Tag1

                loc_oGridItem.RecordSource          = "crDistribui"
                loc_oGridItem.Column1.ControlSource = "crDistribui.Cpros"
                loc_oGridItem.Column2.ControlSource = "crDistribui.Dpros"
                loc_oGridItem.Column3.ControlSource = "crDistribui.Qtds"
                loc_oGridItem.Column4.ControlSource = "crDistribui.Units"

                *-- RecordSource reseta Header/Width para o default (regra #41c) -
                *-- reaplicar OS DOIS depois do ControlSource
                loc_oGridItem.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                loc_oGridItem.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                loc_oGridItem.Column3.Header1.Caption = "Quantidade"
                loc_oGridItem.Column4.Header1.Caption = "Valor"
                loc_oGridItem.Column1.Width = 100
                loc_oGridItem.Column2.Width = 235
                loc_oGridItem.Column3.Width = 63
                loc_oGridItem.Column4.Width = 70

                SELECT crMovimentos
                DO CASE
                    CASE loc_nTipo = 1
                        DELETE FROM crMovimentos WHERE Cpros NOT IN (SELECT Cpros FROM crDistribui)
                    CASE loc_nTipo = 2
                        DELETE FROM crMovimentos WHERE Cpros IN (SELECT Cpros FROM crDistribui)
                ENDCASE
                GO TOP IN crMovimentos

                SELECT crMovimentos
                SCAN FOR !DELETED()
                    loc_nCotacao = THIS.this_oBusinessObject.CarregarCambio(crMovimentos.Moedas, DATE())
                    loc_nUnits   = ROUND(crMovimentos.Units * loc_nCotacao / loc_nCotaMoe, 2)
                    REPLACE Units WITH loc_nUnits IN crMovimentos
                ENDSCAN

                loc_oGridDisp.RecordSource          = "crMovimentos"
                loc_oGridDisp.Column1.ControlSource = "crMovimentos.Cpros"
                loc_oGridDisp.Column2.ControlSource = "crMovimentos.Dpros"
                loc_oGridDisp.Column3.ControlSource = "crMovimentos.units"
                loc_oGridDisp.Column4.ControlSource = "crMovimentos.qtds"
                loc_oGridDisp.Column5.ControlSource = "crMovimentos.qtbaixas"
                loc_oGridDisp.Column6.ControlSource = "crMovimentos.qtreservas"
                loc_oGridDisp.Column7.ControlSource = "crMovimentos.Saldo"

                *-- RecordSource reseta Header/Width para o default (regra #41c) -
                *-- reaplicar OS DOIS depois do ControlSource
                loc_oGridDisp.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                loc_oGridDisp.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                loc_oGridDisp.Column3.Header1.Caption = "Valor"
                loc_oGridDisp.Column4.Header1.Caption = "Quantidade"
                loc_oGridDisp.Column5.Header1.Caption = "Baixado"
                loc_oGridDisp.Column6.Header1.Caption = "Reservado"
                loc_oGridDisp.Column7.Header1.Caption = "Saldo"
                loc_oGridDisp.Column1.Width = 100
                loc_oGridDisp.Column2.Width = 235
                loc_oGridDisp.Column3.Width = 70
                loc_oGridDisp.Column4.Width = 63
                loc_oGridDisp.Column5.Width = 63
                loc_oGridDisp.Column6.Width = 63
                loc_oGridDisp.Column7.Width = 63

                loc_oAba2.txt_4c_Sistema.Value       = "Sistema"
                loc_oAba2.txt_4c_ArquivoHeader.Value = "Arquivo"

                THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1.Enabled = .F.
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page2.Enabled = .T.
                THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.ActivePage = 2
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormSigPrCtr.ExecutarProcessamentoXml")
        ENDTRY
    ENDPROC

    *===========================================================================
    * AtualizarCpfEGrupoPorConta - Bloco comum ao final de Get_Conta.Valid e
    * Get_Dconta.Valid legados: busca Cpfs/Grupos em SigCdCli pela conta ja
    * validada, preenche o Cpf e (se vazio) o Grupo, e recarrega a grade de
    * estoque filtrada pela conta (ThisForm.Montagrade(.T.)).
    *===========================================================================
    PROTECTED PROCEDURE AtualizarCpfEGrupoPorConta(par_oPagina)
        LOCAL loc_cConta, loc_nResultado
        TRY
            IF !EMPTY(ALLTRIM(par_oPagina.txt_4c_Conta.Value))
                loc_cConta = ALLTRIM(par_oPagina.txt_4c_Conta.Value)

                IF USED("cursor_4c_TmpCli")
                    USE IN cursor_4c_TmpCli
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT Cpfs, Grupos FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cConta), ;
                    "cursor_4c_TmpCli")

                IF loc_nResultado >= 0 AND USED("cursor_4c_TmpCli") AND !EOF("cursor_4c_TmpCli")
                    par_oPagina.txt_4c_Cpf.Value = ALLTRIM(TratarNulo(cursor_4c_TmpCli.Cpfs, ""))
                    IF EMPTY(ALLTRIM(par_oPagina.txt_4c_Grupo.Value))
                        par_oPagina.txt_4c_Grupo.Value = ALLTRIM(TratarNulo(cursor_4c_TmpCli.Grupos, ""))
                    ENDIF
                ENDIF

                IF USED("cursor_4c_TmpCli")
                    USE IN cursor_4c_TmpCli
                ENDIF

                THIS.MontaGrade(.T.)
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormSigPrCtr.AtualizarCpfEGrupoPorConta")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ValidarGrupoAcesso - LostFocus de txt_4c_Grupo (legado: Get_Grupo.Valid)
    * fAcessoContab ja resolve o lookup (FormBuscaSimples) e preenche o
    * proprio campo quando nao ha match exato.
    *===========================================================================
    PROCEDURE ValidarGrupoAcesso(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1
            fAcessoContab(gc_4c_UsuarioLogado, "C", loc_oPagina.txt_4c_Grupo.Value, ;
                loc_oPagina.txt_4c_Grupo, "", loc_oPagina.txt_4c_Conta.Value)
        CATCH TO loException
            MostrarErro(loException, "FormSigPrCtr.ValidarGrupoAcesso")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ValidarContaFornecedor - LostFocus de txt_4c_Conta (legado: Get_Conta.Valid)
    *===========================================================================
    PROCEDURE ValidarContaFornecedor(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cGrupo
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1
            loc_cGrupo  = loc_oPagina.txt_4c_Grupo.Value

            IF !EMPTY(ALLTRIM(loc_oPagina.txt_4c_Conta.Value))
                IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "C", loc_oPagina.txt_4c_Conta.Value, ;
                        loc_oPagina.txt_4c_Conta, loc_oPagina.txt_4c_Dconta)
                    MsgErro("Acesso Negado!!!", "Aviso")
                    loc_oPagina.txt_4c_Conta.Value  = ""
                    loc_oPagina.txt_4c_Dconta.Value = ""
                    loc_oPagina.txt_4c_Cpf.Value    = ""
                ENDIF
            ELSE
                loc_oPagina.txt_4c_Dconta.Value = ""
                loc_oPagina.txt_4c_Cpf.Value    = ""
            ENDIF

            THIS.AtualizarCpfEGrupoPorConta(loc_oPagina)
        CATCH TO loException
            MostrarErro(loException, "FormSigPrCtr.ValidarContaFornecedor")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ValidarDescricaoConta - LostFocus de txt_4c_Dconta (legado: Get_Dconta.Valid)
    *===========================================================================
    PROCEDURE ValidarDescricaoConta(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cGrupo
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1
            loc_cGrupo  = loc_oPagina.txt_4c_Grupo.Value

            IF !EMPTY(ALLTRIM(loc_oPagina.txt_4c_Dconta.Value))
                IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "D", loc_oPagina.txt_4c_Dconta.Value, ;
                        loc_oPagina.txt_4c_Conta, loc_oPagina.txt_4c_Dconta, .T., loc_cGrupo)
                    MsgErro("Acesso Negado!!!", "Aviso")
                    loc_oPagina.txt_4c_Dconta.Value = ""
                    loc_oPagina.txt_4c_Conta.Value  = ""
                    loc_oPagina.txt_4c_Cpf.Value    = ""
                ENDIF
            ELSE
                loc_oPagina.txt_4c_Conta.Value = ""
                loc_oPagina.txt_4c_Cpf.Value   = ""
            ENDIF

            THIS.AtualizarCpfEGrupoPorConta(loc_oPagina)
        CATCH TO loException
            MostrarErro(loException, "FormSigPrCtr.ValidarDescricaoConta")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ValidarCpfCnpjFornecedor - LostFocus de txt_4c_Cpf (legado: Get_cpf.Valid)
    * Valida o digito verificador (fValidarCPF/fValidarCNPJ), localiza o
    * fornecedor por Cpfs e confere acesso via fAcessoContas antes de
    * preencher Conta/Dconta.
    *===========================================================================
    PROCEDURE ValidarCpfCnpjFornecedor(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cGrupo, loc_cCgc, loc_cCgcFmt, loc_nVerCpfCgc, loc_nResultado
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1

            IF !EMPTY(ALLTRIM(loc_oPagina.txt_4c_Cpf.Value))
                loc_cCgc = STRTRAN(STRTRAN(STRTRAN(loc_oPagina.txt_4c_Cpf.Value, ".", ""), "-", ""), "/", "")
                loc_nVerCpfCgc = 0

                IF LEN(ALLTRIM(loc_cCgc)) != 14
                    loc_cCgcFmt = TRANSFORM(loc_cCgc, "@R 999.999.999-99")
                    IF LEN(ALLTRIM(loc_cCgc)) = 11
                        loc_nVerCpfCgc = IIF(fValidarCPF(loc_cCgcFmt), 1, 2)
                    ENDIF
                ELSE
                    loc_cCgcFmt = TRANSFORM(loc_cCgc, "@R 99.999.999/9999-99")
                    loc_nVerCpfCgc = IIF(fValidarCNPJ(loc_cCgcFmt), 1, 2)
                ENDIF

                IF loc_nVerCpfCgc = 2
                    MsgErro("CPF / CGC Incorreto !!!", "Aviso")
                    loc_oPagina.txt_4c_Cpf.Value = ""
                ELSE
                    IF USED("cursor_4c_BuscaCli")
                        USE IN cursor_4c_BuscaCli
                    ENDIF
                    loc_nResultado = SQLEXEC(gnConnHandle, ;
                        "SELECT IClis, RClis, Cpfs, Grupos FROM SigCdCli WHERE Cpfs = " + ;
                        EscaparSQL(PADR(ALLTRIM(loc_cCgcFmt), 20)), "cursor_4c_BuscaCli")

                    IF loc_nResultado >= 0 AND USED("cursor_4c_BuscaCli") AND !EOF("cursor_4c_BuscaCli")
                        loc_cGrupo = loc_oPagina.txt_4c_Grupo.Value
                        IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "C", ;
                                ALLTRIM(cursor_4c_BuscaCli.IClis), loc_oPagina.txt_4c_Conta.Value, loc_oPagina.txt_4c_Dconta.Value)
                            MsgErro("Acesso Negado !!", "Aviso")
                            loc_oPagina.txt_4c_Conta.Value  = ""
                            loc_oPagina.txt_4c_Dconta.Value = ""
                            loc_oPagina.txt_4c_Cpf.Value    = ""
                        ELSE
                            loc_oPagina.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaCli.IClis)
                            loc_oPagina.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.RClis)
                            loc_oPagina.txt_4c_Cpf.Value    = ALLTRIM(cursor_4c_BuscaCli.Cpfs)

                            IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Grupo.Value))
                                loc_oPagina.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaCli.Grupos)
                            ENDIF
                        ENDIF
                    ELSE
                        IF loc_nVerCpfCgc = 1
                            MsgErro("CPF / CGC n" + CHR(227) + "o encontrado !!!", "Aviso")
                        ENDIF
                    ENDIF

                    IF USED("cursor_4c_BuscaCli")
                        USE IN cursor_4c_BuscaCli
                    ENDIF
                ENDIF
            ELSE
                loc_oPagina.txt_4c_Dconta.Value = ""
            ENDIF

            *-- Ressincroniza Cpf/Grupo/grade de estoque com a Conta atual em
            *-- TODOS os desfechos (mesmo padrao incondicional ja usado em
            *-- ValidarContaFornecedor/ValidarDescricaoConta) - AtualizarCpfEGrupoPorConta
            *-- so age se txt_4c_Conta nao estiver vazio, entao eh seguro chamar
            *-- mesmo quando a Conta foi limpa por acesso negado.
            THIS.AtualizarCpfEGrupoPorConta(loc_oPagina)
        CATCH TO loException
            MostrarErro(loException, "FormSigPrCtr.ValidarCpfCnpjFornecedor")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ValidarMoedaFornecedor - LostFocus de txt_4c_Moeda (legado: Get_Moeda.Valid,
    * fwbuscaext -> SigCdMoe). Padrao canonico FormBuscaAuxiliar: this_lAchouRegistro
    * ANTES do Show(), this_lSelecionou antes de atribuir o valor (regra #37).
    *===========================================================================
    PROCEDURE ValidarMoedaFornecedor(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_oBusca
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1

            IF !EMPTY(ALLTRIM(loc_oPagina.txt_4c_Moeda.Value))
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdMoe", "cursor_4c_BuscaMoeda", "CMoes", ;
                    ALLTRIM(loc_oPagina.txt_4c_Moeda.Value), "Sele" + CHR(231) + CHR(227) + "o")

                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                    ENDIF

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
                        loc_oPagina.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.CMoes)
                    ELSE
                        loc_oPagina.txt_4c_Moeda.Value = ""
                    ENDIF

                    loc_oBusca.Release()
                ENDIF

                IF USED("cursor_4c_BuscaMoeda")
                    USE IN cursor_4c_BuscaMoeda
                ENDIF
            ELSE
                loc_oPagina.txt_4c_Moeda.Value = ""
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormSigPrCtr.ValidarMoedaFornecedor")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ProcurarProdutoNaGrade - LostFocus de txt_4c_ProdutoInicial (legado:
    * get_produto_inicial.Valid) - localiza o produto digitado na grade de
    * movimentos disponiveis (crMovimentos/grd_4c_Disponivel - populada na
    * fase que adiciona os grids da aba Movimentacoes).
    *===========================================================================
    PROCEDURE ProcurarProdutoNaGrade()
        LOCAL loc_oAba2, loc_cProduto
        TRY
            loc_oAba2   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page2
            loc_cProduto = ALLTRIM(loc_oAba2.txt_4c_ProdutoInicial.Value)

            IF !EMPTY(loc_cProduto) AND USED("crMovimentos")
                LOCATE FOR ALLTRIM(crMovimentos.Cpros) = loc_cProduto
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormSigPrCtr.ProcurarProdutoNaGrade")
        ENDTRY
    ENDPROC

    *===========================================================================
    * AtualizarDetalhesProdutoSelecionado - AfterRowColChange de
    * grd_4c_Disponivel (legado: grdDisponivel.AfterRowColChange) - busca os
    * dados do produto da linha corrente em SigCdPro/SigCdGrp e atualiza os
    * campos de exibicao da aba Movimentacoes + a imagem do produto. PUBLIC
    * (alvo de BINDEVENT - regra #3); AfterRowColChange exige par_nColIndex.
    *
    * Colunas de SigCdPro lidas no legado mas NUNCA consumidas depois
    * (cgrus/sgrus/CodCors - so alimentavam a consulta morta a SigCdPsg/
    * Tmp_Sgru) e os LEFT JOINs com SigCdUni/SigCdCol/SigCdLin/SigPrFti/
    * SigCdCli/SigCdGpr/SigCdFip (cujas colunas tambem nunca sao lidas) sao
    * leitura morta - omitidas aqui, mesmo criterio ja aplicado em
    * LerArquivoXml para os campos de cabecalho da NF-e nao referenciados.
    *===========================================================================
    PROCEDURE AtualizarDetalhesProdutoSelecionado(par_nColIndex)
        LOCAL loc_oAba2, loc_cSQL, loc_nResultado, loc_cArquivoImg, loc_cFoto, ;
            loc_nCotacao, loc_nCotVen, loc_nPrVenda, loc_cPrVendaMoeda, ;
            loc_nFatArred, loc_nSoma

        IF !USED("crMovimentos") OR EOF("crMovimentos")
            RETURN
        ENDIF

        TRY
            loc_oAba2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page2

            IF USED("CrTSigPro")
                USE IN CrTSigPro
            ENDIF

            loc_cSQL = "SELECT a.Cpros, a.Reffs, a.Pesoms, a.Moecusfs, a.Custofs, a.Pcuss, " + ;
                "a.Pvens, a.Moevs, a.FigJpgs, g.Arreds " + ;
                "FROM SigCdPro a LEFT JOIN SigCdGrp g ON a.Cgrus = g.Cgrus " + ;
                "WHERE a.Cpros = " + EscaparSQL(ALLTRIM(crMovimentos.Cpros))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "CrTSigPro")

            IF loc_nResultado < 1 OR !USED("CrTSigPro") OR EOF("CrTSigPro")
                MsgErro("Favor reinicializar o processo.", "Falha na Conex" + CHR(227) + "o")
            ELSE
                loc_oAba2.txt_4c_RefFornecedor.Value = TratarNulo(CrTSigPro.Reffs, "")
                loc_oAba2.txt_4c_PesoMedio.Value      = TratarNulo(CrTSigPro.Pesoms, 0)
                loc_oAba2.txt_4c_MoeCusFs.Value        = TratarNulo(CrTSigPro.Moecusfs, "")
                loc_oAba2.txt_4c_CustoFs.Value          = TratarNulo(CrTSigPro.Custofs, 0)
                loc_oAba2.txt_4c_PrecoMov.Value         = TratarNulo(CrTSigPro.Pcuss, 0)

                loc_oAba2.txt_4c_MovCidChaves.Value = TratarNulo(crMovimentos.cidchaves, "")
                loc_oAba2.txt_4c_MovEmps.Value       = SUBSTR(crMovimentos.OriDopNums, 1, 3)
                loc_oAba2.txt_4c_MovDopes.Value      = SUBSTR(crMovimentos.OriDopNums, 4, 20)
                loc_oAba2.txt_4c_MovNumes.Value      = ALLTRIM(RIGHT(crMovimentos.OriDopNums, 6))

                IF !ISNULL(CrTSigPro.FigJpgs) AND !EMPTY(CrTSigPro.FigJpgs)
                    loc_cFoto = STRTRAN(CrTSigPro.FigJpgs, "data:image/png;base64,", "")
                    loc_cFoto = STRTRAN(loc_cFoto, "data:image/jpeg;base64,", "")
                    loc_cFoto = STRTRAN(loc_cFoto, "data:image/jpg;base64,", "")
                    loc_cFoto = STRCONV(loc_cFoto, 14)

                    loc_cArquivoImg = SYS(2023) + "\" + SYS(2015) + ".jpg"
                    loc_oAba2.img_4c_FigJpg.Visible = .F.
                    loc_oAba2.img_4c_FigJpg.Picture = ""
                    IF STRTOFILE(loc_cFoto, loc_cArquivoImg) > 0
                        loc_oAba2.img_4c_FigJpg.Picture = loc_cArquivoImg
                        loc_oAba2.img_4c_FigJpg.Visible = .T.
                    ENDIF
                ELSE
                    loc_oAba2.img_4c_FigJpg.Visible = .F.
                    loc_oAba2.img_4c_FigJpg.Picture = ""
                ENDIF

                IF EMPTY(ALLTRIM(NVL(crSigCdPam.moedetqs, "")))
                    loc_nPrVenda      = TratarNulo(CrTSigPro.Pvens, 0)
                    loc_cPrVendaMoeda = TratarNulo(CrTSigPro.Moevs, "")
                ELSE
                    SELECT crSigCdCot
                    GO TOP
                    LOCATE FOR ALLTRIM(cmoes) == ALLTRIM(crSigCdPam.moedetqs)
                    loc_nCotacao = IIF(FOUND(), crSigCdCot.valos, 1)

                    SELECT crSigCdCot
                    GO TOP
                    LOCATE FOR ALLTRIM(cmoes) == ALLTRIM(CrTSigPro.Moevs)
                    loc_nCotVen  = IIF(FOUND(), crSigCdCot.valos, 1)

                    loc_nPrVenda      = ROUND(CrTSigPro.Pvens * loc_nCotVen / loc_nCotacao, 2)
                    loc_cPrVendaMoeda = ALLTRIM(crSigCdPam.moedetqs)
                ENDIF

                IF CrTSigPro.Arreds != 0
                    loc_nFatArred = CrTSigPro.Arreds
                    loc_nSoma     = loc_nFatArred
                    DO WHILE loc_nSoma < loc_nPrVenda
                        loc_nSoma = loc_nSoma + loc_nFatArred
                    ENDDO
                    loc_nPrVenda = loc_nSoma
                ENDIF

                loc_oAba2.txt_4c_PrVenda.Value      = loc_nPrVenda
                loc_oAba2.txt_4c_PrVendaMoeda.Value = loc_cPrVendaMoeda
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormSigPrCtr.AtualizarDetalhesProdutoSelecionado")
        ENDTRY
    ENDPROC

    *===========================================================================
    * AbrirPesquisaGlobalProduto - DblClick de grd_4c_Disponivel.Column1.Text1
    * (legado: grdDisponivel.Col01_Codigo.Text1.DblClick) - abriria a
    * Pesquisa Global de Produtos (SigOpCgp), form auxiliar fora do escopo
    * desta migracao (mesmo padrao de degradacao graciosa ja usado em
    * BtnConsultaVendasClick/AbrirFormZoomImagem para SigOpCgv/SigOpZom).
    *===========================================================================
    PROCEDURE AbrirPesquisaGlobalProduto()
        LOCAL loc_cProduto, loc_oForm, loc_oErro

        IF !USED("crMovimentos") OR EOF("crMovimentos")
            RETURN
        ENDIF

        loc_cProduto = ALLTRIM(crMovimentos.Cpros)
        IF EMPTY(loc_cProduto)
            RETURN
        ENDIF

        loc_oForm = .NULL.
        TRY
            loc_oForm = CREATEOBJECT("FormSigOpCgp", loc_cProduto)
        CATCH TO loc_oErro
            loc_oForm = .NULL.
        ENDTRY

        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ELSE
            MsgAviso("M" + CHR(243) + "dulo de Pesquisa Global de Produtos (SigOpCgp) ainda n" + CHR(227) + ;
                "o est" + CHR(225) + " dispon" + CHR(237) + "vel nesta vers" + CHR(227) + "o.", "Aviso")
        ENDIF
    ENDPROC

    *===========================================================================
    * FigJpgDblClick - DblClick de img_4c_FigJpg (legado: FigJpg.DblClick) -
    * grava a foto do produto corrente (memo cru, SEM decodificar base64 -
    * diferente de AtualizarDetalhesProdutoSelecionado; assim mesmo no
    * legado) num JPG temporario e abriria o Zoom de Imagem (SigOpZom), form
    * auxiliar fora do escopo desta migracao (mesmo padrao de degradacao
    * graciosa ja usado em FormSigMvSbn.AbrirFormZoomImagem).
    *===========================================================================
    PROCEDURE FigJpgDblClick()
        LOCAL loc_cArquivo, loc_cSQL, loc_nResultado, loc_oForm, loc_oErro, loc_cTitulo

        IF !USED("crMovimentos") OR EOF("crMovimentos")
            RETURN
        ENDIF

        loc_cArquivo = ""
        TRY
            loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".Jpg"

            IF USED("cursor_4c_FotoZoom")
                USE IN cursor_4c_FotoZoom
            ENDIF
            loc_cSQL = "SELECT a.Cpros, a.FigJpgs FROM SigCdPro a WHERE a.Cpros = " + ;
                EscaparSQL(ALLTRIM(crMovimentos.Cpros))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FotoZoom")

            IF loc_nResultado >= 0 AND USED("cursor_4c_FotoZoom") AND !EOF("cursor_4c_FotoZoom") ;
                    AND !ISNULL(cursor_4c_FotoZoom.FigJpgs) AND !EMPTY(cursor_4c_FotoZoom.FigJpgs)
                STRTOFILE(cursor_4c_FotoZoom.FigJpgs, loc_cArquivo)
            ELSE
                loc_cArquivo = ""
            ENDIF

            IF USED("cursor_4c_FotoZoom")
                USE IN cursor_4c_FotoZoom
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormSigPrCtr.FigJpgDblClick")
            loc_cArquivo = ""
        ENDTRY

        IF !EMPTY(loc_cArquivo) AND FILE(loc_cArquivo)
            loc_cTitulo = "Produto : " + ALLTRIM(crMovimentos.Cpros) + " - " + ALLTRIM(crMovimentos.Dpros)

            loc_oForm = .NULL.
            TRY
                loc_oForm = CREATEOBJECT("FormSigOpZom", loc_cArquivo, loc_cTitulo, " ")
            CATCH TO loc_oErro
                loc_oForm = .NULL.
            ENDTRY

            IF VARTYPE(loc_oForm) = "O"
                loc_oForm.Show()
            ELSE
                MsgAviso("M" + CHR(243) + "dulo de Zoom de Imagem (SigOpZom) ainda n" + CHR(227) + ;
                    "o est" + CHR(225) + " dispon" + CHR(237) + "vel nesta vers" + CHR(227) + "o.", "Aviso")
            ENDIF

            ERASE (loc_cArquivo)
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnExcluirSisClick - Click de cmd_4c_BtnExcluirSis (legado:
    * btnExcluirSis.Click) - exclui a linha atual de crMovimentos
    * (grd_4c_Disponivel).
    *===========================================================================
    PROCEDURE BtnExcluirSisClick()
        LOCAL loc_oAba2
        TRY
            IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND USED("crMovimentos")
                loc_oAba2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page2

                SELECT crMovimentos
                IF !EOF()
                    DELETE
                ENDIF
                IF !EOF()
                    SKIP
                    SKIP -1
                ENDIF
                GO TOP
                loc_oAba2.grd_4c_Disponivel.SetFocus()
                loc_oAba2.grd_4c_Disponivel.Refresh()
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormSigPrCtr.BtnExcluirSisClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnExcluirArqClick - Click de cmd_4c_BtnExcluirArq (legado:
    * btnExcluirArq.Click) - exclui a linha atual de crDistribui
    * (grd_4c_ItemXml).
    *===========================================================================
    PROCEDURE BtnExcluirArqClick()
        LOCAL loc_oAba2
        TRY
            IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND USED("crDistribui")
                loc_oAba2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page2

                SELECT crDistribui
                IF !EOF()
                    DELETE
                ENDIF
                IF !EOF()
                    SKIP
                    SKIP -1
                ENDIF
                GO TOP
                loc_oAba2.grd_4c_ItemXml.SetFocus()
                loc_oAba2.grd_4c_ItemXml.Refresh()
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormSigPrCtr.BtnExcluirArqClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere os campos editaveis de Page2 (aba Precificacao)
    * para o Business Object. Grupo/Dconta/Cpf NAO tem coluna em SigPrCtr
    * (regra ja documentada nos comentarios de ConfigurarPaginaDados) e por
    * isso nao sao mapeados aqui.
    *===========================================================================
    PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1

            THIS.this_oBusinessObject.this_cContas   = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)
            THIS.this_oBusinessObject.this_cMoedas   = ALLTRIM(loc_oPagina.txt_4c_Moeda.Value)
            THIS.this_oBusinessObject.this_cArquivo  = ALLTRIM(loc_oPagina.txt_4c_Arquivo.Value)
            THIS.this_oBusinessObject.this_nPrecific = loc_oPagina.opt_4c_Custo.Value
        CATCH TO loException
            MostrarErro(loException, "FormSigPrCtr.FormParaBO")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere o Business Object para os campos de Page2 e
    * reconstitui Dconta/Cpf/Grupo + grd_4c_Estoque via o mesmo bloco usado
    * apos validar a Conta digitada (AtualizarCpfEGrupoPorConta/MontaGrade).
    *===========================================================================
    PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1

            loc_oPagina.txt_4c_Conta.Value   = THIS.this_oBusinessObject.this_cContas
            loc_oPagina.txt_4c_Moeda.Value   = THIS.this_oBusinessObject.this_cMoedas
            loc_oPagina.txt_4c_Arquivo.Value = THIS.this_oBusinessObject.this_cArquivo
            loc_oPagina.opt_4c_Custo.Value   = IIF(THIS.this_oBusinessObject.this_nPrecific = 2, 2, 1)
            loc_oPagina.txt_4c_Grupo.Value   = ""
            loc_oPagina.txt_4c_Cpf.Value     = ""
            loc_oPagina.txt_4c_Dconta.Value  = ""

            THIS.AtualizarCpfEGrupoPorConta(loc_oPagina)
        CATCH TO loException
            MostrarErro(loException, "FormSigPrCtr.BOParaForm")
        ENDTRY
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa os campos de Page2 (aba Precificacao) e a grade
    * de estoque disponivel, preparando o formulario para modo INCLUIR.
    *===========================================================================
    PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1

            *-- Grupo de acesso padrao de fornecedores (legado: Init faz
            *-- "Get_Grupo.Value = crSigCdPam.GrPadFors" uma unica vez; aqui
            *-- reaplicado a cada Incluir, equivalente para "novo registro")
            loc_oPagina.txt_4c_Grupo.Value   = IIF(USED("crSigCdPam"), ;
                ALLTRIM(NVL(crSigCdPam.GrPadFors, "")), "")
            loc_oPagina.txt_4c_Conta.Value   = ""
            loc_oPagina.txt_4c_Dconta.Value  = ""
            loc_oPagina.txt_4c_Cpf.Value     = ""
            loc_oPagina.txt_4c_Moeda.Value   = ""
            loc_oPagina.txt_4c_Arquivo.Value = ""
            loc_oPagina.opt_4c_Custo.Value   = 1

            loc_oPagina.grd_4c_Estoque.RecordSource = ""
            IF USED("cursor_4c_Estoque")
                USE IN cursor_4c_Estoque
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormSigPrCtr.LimparCampos")
        ENDTRY
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita/desabilita os campos editaveis da aba
    * Precificacao. txt_4c_Dconta e sempre somente-leitura (preenchido por
    * lookup em AtualizarCpfEGrupoPorConta, nunca digitado pelo usuario).
    *===========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1

            loc_oPagina.txt_4c_Grupo.Enabled   = par_lHabilitar
            loc_oPagina.txt_4c_Conta.Enabled   = par_lHabilitar
            loc_oPagina.txt_4c_Cpf.Enabled     = par_lHabilitar
            loc_oPagina.txt_4c_Moeda.Enabled   = par_lHabilitar
            loc_oPagina.txt_4c_Arquivo.Enabled = par_lHabilitar
            loc_oPagina.opt_4c_Custo.Enabled   = par_lHabilitar
            loc_oPagina.txt_4c_Dconta.Enabled  = .F.
        CATCH TO loException
            MostrarErro(loException, "FormSigPrCtr.HabilitarCampos")
        ENDTRY
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Alterna habilitacao dos botoes CRUD (Page1) e
    * Confirmar/Cancelar (Page2) conforme this_cModoAtual. Chamada tanto ao
    * ENTRAR em edicao quanto ao VOLTAR para a lista via AlternarPagina(1)
    * (regra #40 - quem desabilita no funil de ida tem que reabilitar no
    * funil de volta).
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oCntBotoes, loc_lEmEdicao
        TRY
            loc_oCntBotoes = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
            loc_lEmEdicao  = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "VISUALIZAR")

            loc_oCntBotoes.cmd_4c_Incluir.Enabled    = !loc_lEmEdicao
            loc_oCntBotoes.cmd_4c_Visualizar.Enabled = !loc_lEmEdicao
            loc_oCntBotoes.cmd_4c_Alterar.Enabled    = !loc_lEmEdicao
            loc_oCntBotoes.cmd_4c_Excluir.Enabled    = !loc_lEmEdicao
            loc_oCntBotoes.cmd_4c_Buscar.Enabled     = !loc_lEmEdicao

            THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = ;
                INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = loc_lEmEdicao
        CATCH TO loException
            MostrarErro(loException, "FormSigPrCtr.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Inicia inclusao de novo lote de controle
    * (legado: Grupo_Op.Click(1) -> DoDefault(1) navega para Pagina.Dados).
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.LimparCampos()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1.txt_4c_Conta.SetFocus()
        CATCH TO loException
            MostrarErro(loException, "FormSigPrCtr.BtnIncluirClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Carrega o lote selecionado na Lista (agrupado por
    * Codigos - regra #42) para alteracao.
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo, loc_lTemSelecao
        loc_lTemSelecao = .F.

        TRY
            IF USED("cursor_4c_Lista")
                IF RECCOUNT("cursor_4c_Lista") > 0 AND !EOF("cursor_4c_Lista")
                    loc_lTemSelecao = .T.
                ENDIF
            ENDIF

            IF !loc_lTemSelecao
                MsgAviso("Selecione um registro na lista para alterar.", "Aviso")
            ELSE
                SELECT cursor_4c_Lista
                loc_cCodigo = ALLTRIM(cursor_4c_Lista.Codigos)

                IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel localizar o registro selecionado.", "Erro")
                ELSE
                    THIS.this_oBusinessObject.EditarRegistro()
                    THIS.BOParaForm()
                    THIS.this_cModoAtual = "ALTERAR"
                    THIS.HabilitarCampos(.T.)
                    THIS.AjustarBotoesPorModo()
                    THIS.AlternarPagina(2)
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormSigPrCtr.BtnAlterarClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Carrega o lote selecionado somente para consulta
    * (campos desabilitados, Confirmar desabilitado - padrao canonico).
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo, loc_lTemSelecao
        loc_lTemSelecao = .F.

        TRY
            IF USED("cursor_4c_Lista")
                IF RECCOUNT("cursor_4c_Lista") > 0 AND !EOF("cursor_4c_Lista")
                    loc_lTemSelecao = .T.
                ENDIF
            ENDIF

            IF !loc_lTemSelecao
                MsgAviso("Selecione um registro na lista para visualizar.", "Aviso")
            ELSE
                SELECT cursor_4c_Lista
                loc_cCodigo = ALLTRIM(cursor_4c_Lista.Codigos)

                IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel localizar o registro selecionado.", "Erro")
                ELSE
                    THIS.BOParaForm()
                    THIS.this_cModoAtual = "VISUALIZAR"
                    THIS.HabilitarCampos(.F.)
                    THIS.AjustarBotoesPorModo()
                    THIS.AlternarPagina(2)
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormSigPrCtr.BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Exclui o lote selecionado (todas as linhas do mesmo
    * Codigos - legado: "Delete From SigPrCtr Where Codigos = ?_Codigo").
    * Falha de gravacao nunca eh muda (regra #20) - BusinessBase.Excluir()
    * ja chama MsgErro internamente quando necessario.
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_lTemSelecao
        loc_lTemSelecao = .F.

        TRY
            IF USED("cursor_4c_Lista")
                IF RECCOUNT("cursor_4c_Lista") > 0 AND !EOF("cursor_4c_Lista")
                    loc_lTemSelecao = .T.
                ENDIF
            ENDIF

            IF !loc_lTemSelecao
                MsgAviso("Selecione um registro na lista para excluir.", "Aviso")
            ELSE
                SELECT cursor_4c_Lista
                loc_cCodigo = ALLTRIM(cursor_4c_Lista.Codigos)

                IF MsgConfirma("Deseja realmente excluir o registro " + loc_cCodigo + "?", ;
                        "Confirmar Exclus" + CHR(227) + "o")

                    IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                        MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel localizar o registro selecionado.", "Erro")
                    ELSE
                        IF THIS.this_oBusinessObject.Excluir()
                            MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Confirmar")
                            THIS.CarregarLista()
                        ELSE
                            IF !THIS.this_oBusinessObject.this_lErroExibido
                                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel excluir o registro.", "Confirmar")
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormSigPrCtr.BtnExcluirClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Recarrega a lista com o periodo atual dos filtros
    * (legado: msv_procurar/GetCodigos nao foi migrado - nao ha campo de
    * busca por exemplo na Lista, apenas o filtro de periodo, ja aplicado
    * automaticamente pelo LostFocus de txt_4c_Dt_final/txt_4c_Dt_inicial;
    * padrao identico ao de FormMoe/FormROM/FormPAT).
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *===========================================================================
    * BtnConfirmarClick - Salva o lote (Grupo_Salva.Salva.Click legado).
    * SigPrCtrBO.ValidarDados() cobre a validacao "Favor Informar uma Conta.";
    * falha de gravacao nunca eh muda (regra #20) - o form so complementa a
    * mensagem quando o BO ainda nao exibiu nenhuma.
    *===========================================================================
    PROCEDURE BtnConfirmarClick()
        TRY
            THIS.FormParaBO()

            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Registro salvo com sucesso!", "Confirmar")
                THIS.AlternarPagina(1)
            ELSE
                IF !THIS.this_oBusinessObject.this_lErroExibido
                    MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o registro.", "Confirmar")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormSigPrCtr.BtnConfirmarClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancela a edicao e volta para a Lista (legado:
    * Grupo_Salva.Cancelar.Click -> ThisForm.mAtivaPagina1 + ActivePage=1).
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        TRY
            THIS.this_oBusinessObject.CancelarEdicao()
            THIS.AlternarPagina(1)
        CATCH TO loException
            MostrarErro(loException, "FormSigPrCtr.BtnCancelarClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * REGRA: Deve iterar Pages E Controls para PageFrames (problema 6)
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
    * Destroy - Libera o Business Object
    *===========================================================================
    PROCEDURE Destroy()
        THIS.this_oBusinessObject = .NULL.
        RETURN DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrCtrBO.prg):
*====================================================================
* SigPrCtrBO.prg
*
* Business Object para Controle de Movimentacoes por XML
* Tabela: SigPrCtr
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigPrCtrBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigPrCtr)
    this_cPkChave     = ""    && pkchave    char(20)  - PK
    this_cCodCors     = ""    && codcors    char(4)
    this_cCodigos     = ""    && codigos    char(10)
    this_cCodTams     = ""    && codtams    char(4)
    this_cCpros       = ""    && cpros      char(14)
    this_dDatas       = {}    && datas      datetime  NULL
    this_dDtAlts      = {}    && dtalts     datetime  NULL
    this_nQtdos       = 0     && qtdos      numeric(10,2)
    this_nQtds        = 0     && qtds       numeric(10,2)
    this_cUsuAlts     = ""    && usualts    char(10)
    this_cUsuars      = ""    && usuars     char(10)
    this_cOriDopNums  = ""    && oridopnums char(29)
    this_cContas      = ""    && contas     char(10)
    this_nPrecific    = 0     && precific   numeric(1,0)
    this_cMoedas      = ""    && moedas     char(3)
    this_cArquivo     = ""    && arquivo    char(200)
    this_cFkChaves    = ""    && fkchaves   char(20)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrCtr"
            THIS.this_cCampoChave = "pkchave"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SigPrCtrBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Chave primaria do registro atual (RegistrarAuditoria)
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cPkChave)
    ENDFUNC

    *====================================================================
    * CarregarCambio - fCarregarCambio (SIGFUNCS.PRG) do legado NAO foi
    * portada para utils/functions.prg (memoria: fCarregarCambio_nao_portada).
    * Usa os cursores crSigCdCot/crSigCdMoe (carregados pelo Form no Init,
    * mesma sessao - FormSigPrCtr nao declara DataSession proprio). PUBLIC
    * (nao PROTECTED) - chamada pelo Form em ExecutarProcessamentoXml.
    *====================================================================
    FUNCTION CarregarCambio(par_cMoeda, par_xData)
        LOCAL loc_nCotacao, loc_cMoeda, loc_dData, loc_oErro
        loc_nCotacao = 0
        loc_cMoeda   = ALLTRIM(par_cMoeda)

        DO CASE
            CASE VARTYPE(par_xData) == "T"
                loc_dData = ConverterParaData(par_xData)
            CASE VARTYPE(par_xData) == "D"
                loc_dData = par_xData
            OTHERWISE
                loc_dData = DATE()
        ENDCASE

        IF EMPTY(loc_cMoeda)
            RETURN 1
        ENDIF

        TRY
            IF USED("crSigCdMoe")
                SELECT crSigCdMoe
                SET ORDER TO CMoes
                IF SEEK(loc_cMoeda) AND crSigCdMoe.Cotas <> 0
                    IF USED("crSigCdCot")
                        SELECT crSigCdCot
                        SET ORDER TO CMoeData DESCENDING
                        SET NEAR ON
                        SEEK loc_cMoeda + DTOS(loc_dData)
                        SET NEAR OFF
                        IF !EOF() AND ALLTRIM(crSigCdCot.CMoes) = loc_cMoeda
                            loc_nCotacao = crSigCdCot.Valos
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            SET NEAR OFF
        ENDTRY

        RETURN IIF(loc_nCotacao = 0, 1, loc_nCotacao)
    ENDFUNC

    *====================================================================
    * ValidarDados - Validacao chamada pelo BusinessBase.Salvar() antes de
    * Inserir/Atualizar (legado: "Favor Informar uma Conta." - guard no
    * inicio do Lerxml/processar do Pageframe1.Page1 - comportamento.json).
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cContas))
            THIS.this_cMensagemErro = "Favor Informar uma Conta."
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades a partir de uma linha do
    * cursor (estrutura de dbo.SigPrCtr - docs/schema.sql).
    * REGRA: OriDopNums eh chave POSICIONAL (Emps char(3)+Dopes char(20)+
    * Str(Numes,6) = 29) - NUNCA aplicar ALLTRIM nela, o padding faz parte
    * da chave usada para casar com SigMvCab.EmpDopNums.
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cPkChave    = ALLTRIM(TratarNulo(pkchave, ""))
            THIS.this_cCodCors    = ALLTRIM(TratarNulo(codcors, ""))
            THIS.this_cCodigos    = ALLTRIM(TratarNulo(codigos, ""))
            THIS.this_cCodTams    = ALLTRIM(TratarNulo(codtams, ""))
            THIS.this_cCpros      = ALLTRIM(TratarNulo(cpros, ""))
            THIS.this_dDatas      = ConverterParaData(TratarNulo(datas, {}))
            THIS.this_dDtAlts     = ConverterParaData(TratarNulo(dtalts, {}))
            THIS.this_nQtdos      = TratarNulo(qtdos, 0)
            THIS.this_nQtds       = TratarNulo(qtds, 0)
            THIS.this_cUsuAlts    = ALLTRIM(TratarNulo(usualts, ""))
            THIS.this_cUsuars     = ALLTRIM(TratarNulo(usuars, ""))
            THIS.this_cOriDopNums = TratarNulo(oridopnums, "")
            THIS.this_cContas     = ALLTRIM(TratarNulo(contas, ""))
            THIS.this_nPrecific   = TratarNulo(precific, 0)
            THIS.this_cMoedas     = ALLTRIM(TratarNulo(moedas, ""))
            THIS.this_cArquivo    = ALLTRIM(TratarNulo(arquivo, ""))
            THIS.this_cFkChaves   = ALLTRIM(TratarNulo(fkchaves, ""))

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro em SigPrCtr
    * Espelha o "Insert Into crSigPrCtr (...)" + "Replace PkChave With
    * fUniqueIds()" do Grupo_Salva.Salva.Click legado (modo INSERIR):
    * a chave primaria (pkchave) e o codigo de agrupamento (codigos) sao
    * gerados aqui quando ainda nao foram atribuidos pelo chamador.
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cPkChave))
                THIS.this_cPkChave = LEFT(fUniqueIds(), 20)
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cCodigos))
                THIS.this_cCodigos = fGerMascara(fGerUniqueKey("SigPrCtr"))
            ENDIF

            IF EMPTY(THIS.this_dDatas)
                THIS.this_dDatas = DATETIME()
            ENDIF

            THIS.this_cUsuars = IIF(!EMPTY(ALLTRIM(THIS.this_cUsuars)), THIS.this_cUsuars, ;
                IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, ""))

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigPrCtr (pkchave, codcors, codigos, codtams, cpros,
                    datas, dtalts, qtdos, qtds, usualts, usuars, oridopnums,
                    contas, precific, moedas, arquivo, fkchaves)
                VALUES (
                    <<EscaparSQL(THIS.this_cPkChave)>>,
                    <<EscaparSQL(THIS.this_cCodCors)>>,
                    <<EscaparSQL(THIS.this_cCodigos)>>,
                    <<EscaparSQL(THIS.this_cCodTams)>>,
                    <<EscaparSQL(THIS.this_cCpros)>>,
                    <<FormatarDataSQL(THIS.this_dDatas)>>,
                    <<FormatarDataSQL(THIS.this_dDtAlts)>>,
                    <<FormatarNumeroSQL(THIS.this_nQtdos, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nQtds, 2)>>,
                    <<EscaparSQL(THIS.this_cUsuAlts)>>,
                    <<EscaparSQL(THIS.this_cUsuars)>>,
                    <<EscaparSQL(THIS.this_cOriDopNums)>>,
                    <<EscaparSQL(THIS.this_cContas)>>,
                    <<FormatarNumeroSQL(THIS.this_nPrecific, 0)>>,
                    <<EscaparSQL(THIS.this_cMoedas)>>,
                    <<EscaparSQL(THIS.this_cArquivo)>>,
                    <<EscaparSQL(THIS.this_cFkChaves)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir controle:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "SigPrCtrBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente em SigPrCtr (WHERE pkchave)
    * Espelha "Replace DtAlts With Datetime() / UsuAlts With m.usuar" do
    * Grupo_Salva.Salva.Click legado (modo ALTERAR).
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_dDtAlts  = DATETIME()
            THIS.this_cUsuAlts = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, THIS.this_cUsuAlts)

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigPrCtr
                SET codcors    = <<EscaparSQL(THIS.this_cCodCors)>>,
                    codigos    = <<EscaparSQL(THIS.this_cCodigos)>>,
                    codtams    = <<EscaparSQL(THIS.this_cCodTams)>>,
                    cpros      = <<EscaparSQL(THIS.this_cCpros)>>,
                    datas      = <<FormatarDataSQL(THIS.this_dDatas)>>,
                    dtalts     = <<FormatarDataSQL(THIS.this_dDtAlts)>>,
                    qtdos      = <<FormatarNumeroSQL(THIS.this_nQtdos, 2)>>,
                    qtds       = <<FormatarNumeroSQL(THIS.this_nQtds, 2)>>,
                    usualts    = <<EscaparSQL(THIS.this_cUsuAlts)>>,
                    usuars     = <<EscaparSQL(THIS.this_cUsuars)>>,
                    oridopnums = <<EscaparSQL(THIS.this_cOriDopNums)>>,
                    contas     = <<EscaparSQL(THIS.this_cContas)>>,
                    precific   = <<FormatarNumeroSQL(THIS.this_nPrecific, 0)>>,
                    moedas     = <<EscaparSQL(THIS.this_cMoedas)>>,
                    arquivo    = <<EscaparSQL(THIS.this_cArquivo)>>,
                    fkchaves   = <<EscaparSQL(THIS.this_cFkChaves)>>
                WHERE pkchave = <<EscaparSQL(THIS.this_cPkChave)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar controle:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "SigPrCtrBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega a linha mais representativa do agrupamento
    * "Codigos" (legado: crSigPrCtr requerido pela Grade da Lista, que
    * agrupa por Codigos - regra #42/comportamento.json). Usada por
    * Alterar/Visualizar/Excluir para trazer Conta/Moeda/Arquivo/Precific
    * do "cabecalho" do lote antes de reconstruir as linhas em Confirmar.
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_CarregaCtr")
                USE IN cursor_4c_CarregaCtr
            ENDIF

            loc_cSQL = "SELECT TOP 1 * FROM SigPrCtr WHERE codigos = " + ;
                EscaparSQL(par_cCodigo) + " ORDER BY pkchave"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CarregaCtr")

            IF loc_nResultado >= 0 AND USED("cursor_4c_CarregaCtr") AND RECCOUNT("cursor_4c_CarregaCtr") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_CarregaCtr")
                THIS.this_lNovoRegistro = .F.
            ELSE
                THIS.this_cMensagemErro = "Registro n" + CHR(227) + "o encontrado"
            ENDIF

            IF USED("cursor_4c_CarregaCtr")
                USE IN cursor_4c_CarregaCtr
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "SigPrCtrBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui TODAS as linhas do lote "Codigos" (transcrito
    * literalmente do legado: "Delete From SigPrCtr Where Codigos = ?_Codigo",
    * msv_Alterar - comportamento.json). A Lista agrupa por Codigos (regra
    * #42), entao excluir eh excluir o lote inteiro, nao so a linha this_cPkChave.
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrCtr WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir controle:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "SigPrCtrBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

