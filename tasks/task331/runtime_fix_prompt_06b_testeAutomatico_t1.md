# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'CarregarDadosReais': Property CARREGARDADOS is not found. | Detalhes: Linha: 799, Proc: testecarregardadosreais

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[18/07/2026 04:45:42 PM] Erro: RETURN/RETRY statement not allowed in TRY/CATCH.
[18/07/2026 04:45:42 PM] Erro: RETURN/RETRY statement not allowed in TRY/CATCH.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-18 16:45:13] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-18 16:45:13] [INFO] Config FPW: (nao fornecido)
[2026-07-18 16:45:13] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-18 16:45:13] [INFO] Timeout: 300 segundos
[2026-07-18 16:45:13] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_itghzns5.prg
[2026-07-18 16:45:13] [INFO] Conteudo do wrapper:
[2026-07-18 16:45:13] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSigPrSer', 'C:\4c\tasks\task331', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigPrSer', 'C:\4c\tasks\task331', 'OPERACIONAL'
QUIT

[2026-07-18 16:45:13] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_itghzns5.prg
[2026-07-18 16:45:13] [INFO] VFP output esperado em: C:\4c\tasks\task331\vfp_output.txt
[2026-07-18 16:45:13] [INFO] Executando Visual FoxPro 9...
[2026-07-18 16:45:13] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_itghzns5.prg
[2026-07-18 16:45:13] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_itghzns5.prg
[2026-07-18 16:45:13] [INFO] Timeout configurado: 300 segundos
[2026-07-18 16:45:42] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-18 16:45:42] [INFO] VFP9 finalizado em 29.4865775 segundos
[2026-07-18 16:45:42] [INFO] Exit Code: 
[2026-07-18 16:45:42] [INFO] 
[2026-07-18 16:45:42] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-18 16:45:42] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_itghzns5.prg
[2026-07-18 16:45:42] [INFO] 
[2026-07-18 16:45:42] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-18 16:45:42] [INFO] * Auto-generated wrapper for parameters
[2026-07-18 16:45:42] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-18 16:45:42] [INFO] * Parameters: 'FormSigPrSer', 'C:\4c\tasks\task331', 'OPERACIONAL'
[2026-07-18 16:45:42] [INFO] 
[2026-07-18 16:45:42] [INFO] * Anti-dialog protections for unattended execution
[2026-07-18 16:45:42] [INFO] SET SAFETY OFF
[2026-07-18 16:45:42] [INFO] SET RESOURCE OFF
[2026-07-18 16:45:42] [INFO] SET TALK OFF
[2026-07-18 16:45:42] [INFO] SET NOTIFY OFF
[2026-07-18 16:45:42] [INFO] SYS(2335, 0)
[2026-07-18 16:45:42] [INFO] 
[2026-07-18 16:45:42] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigPrSer', 'C:\4c\tasks\task331', 'OPERACIONAL'
[2026-07-18 16:45:42] [INFO] QUIT
[2026-07-18 16:45:42] [INFO] 
[2026-07-18 16:45:42] [INFO] === Fim do Wrapper.prg ===
[2026-07-18 16:45:42] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSigPrSer",
  "timestamp": "20260718164542",
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
      "erro": "Property CARREGARDADOS is not found.",
      "detalhes": "Linha: 799, Proc: testecarregardadosreais"
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrSer.prg):
*==============================================================================
* FormSigPrSer.prg - Servicos Lancados
* Tipo: OPERACIONAL (popup filho do form de processamento)
* Abre como popup para exibir servicos lancados em TmpDistrib
* Recebe o form pai via Init(par_oParentForm)
* Tabelas: SigPdMvf, SigCdNei, SigCdNec, SigCdPro, SigCdCli (via BO)
* Fase 7/8: CmdOkClick (evento principal) ja presente desde Fase 6 - popup read-only concluido
*==============================================================================

DEFINE CLASS FormSigPrSer AS FormBase

    *-- Propriedades visuais (copiadas do SCX SIGPRSER)
    DataSession  = 2
    ShowWindow = 1
    WindowType = 1
    Width        = 1000
    Height       = 600
    Caption      = "Servi" + CHR(231) + "os lan" + CHR(231) + "ados"
    AutoCenter   = .T.
    BorderStyle  = 2
    TitleBar     = 0
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    ClipControls = .F.

    *-- Estado / Negocio
    this_oBusinessObject = .NULL.
    this_cMensagemErro   = ""
    this_oParentForm     = .NULL.
    this_cModoAtual      = "EXIBICAO"

    *==========================================================================
    * Init - Recebe referencia ao form pai, ativa datasession do pai para
    * que xMfas e xnensi fiquem acessiveis durante toda a vida do popup
    *==========================================================================
    PROCEDURE Init(par_oParentForm)
        SET DATE TO BRITISH
        SET CENTURY ON

        IF VARTYPE(par_oParentForm) = "O" AND !ISNULL(par_oParentForm)
            THIS.this_oParentForm = par_oParentForm
            SET DATASESSION TO par_oParentForm.DataSessionId
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrSerBO")
            IF VARTYPE(THIS.this_oBusinessObject) # "O"
                MsgErro("Erro ao criar objeto SigPrSerBO.", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarOperacao()
                THIS.ConfigurarShape1()
                THIS.ConfigurarBotaoOk()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.TornarControlesVisiveis(THIS)

                THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption  = THIS.Caption

                THIS.CarregarDados()
                THIS.AlternarPagina(1)
                THIS.LockScreen = .F.

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro FormSigPrSer.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Configura layout base do form (popup OPERACIONAL)
    * Form nao usa PageFrame CRUD (Lista/Dados); metodo prepara area principal:
    * imagem de fundo + ClipControls para que sub-containers renderizem no topo
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_cImagem, loc_oErro

        TRY
            loc_cImagem = gc_4c_CaminhoBase + "..\..\..\Framework\imagens\new_background.jpg"
            IF FILE(loc_cImagem)
                THIS.Picture = loc_cImagem
            ENDIF
            THIS.ClipControls = .F.
            THIS.AutoCenter   = .T.
            THIS.LockScreen   = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Container cinza com titulo duplo (sombra + titulo)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Sombra", "Container")
            WITH THIS.cnt_4c_Sombra
                .Visible     = .T.
                .Top         = 0
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BorderWidth = 0
                .BackStyle   = 1
                .BackColor   = RGB(100, 100, 100)
            ENDWITH

            THIS.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
            WITH THIS.cnt_4c_Sombra.lbl_4c_Sombra
                .Visible   = .T.
                .Top       = 18
                .Left      = 10
                .Width     = 769
                .Height    = 40
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .WordWrap  = .T.
                .Alignment = 0
                .Caption   = "Servi" + CHR(231) + "os lan" + CHR(231) + "ados"
            ENDWITH

            THIS.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
            WITH THIS.cnt_4c_Sombra.lbl_4c_Titulo
                .Visible   = .T.
                .Top       = 17
                .Left      = 10
                .Width     = 769
                .Height    = 46
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .WordWrap  = .T.
                .Alignment = 0
                .Caption   = "Servi" + CHR(231) + "os lan" + CHR(231) + "ados"
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarOperacao - Container com informacoes da movimentacao (read-only)
    * Exibe Empresa + Operacao + Numero do processamento do form pai
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarOperacao()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Operacao", "Container")
            WITH THIS.cnt_4c_Operacao
                .Visible       = .T.
                .Top           = 104
                .Left          = 12
                .Width         = 490
                .Height        = 56
                .BackStyle     = 1
                .BackColor     = RGB(255, 255, 255)
                .BorderWidth   = 1
                .SpecialEffect = 0
            ENDWITH

            THIS.cnt_4c_Operacao.AddObject("lbl_4c_Movimentacao", "Label")
            WITH THIS.cnt_4c_Operacao.lbl_4c_Movimentacao
                .Visible   = .T.
                .Top       = 3
                .Left      = 4
                .AutoSize  = .T.
                .FontBold  = .T.
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
            ENDWITH

            *-- Empresa (emps - char 3)
            THIS.cnt_4c_Operacao.AddObject("txt_4c_Empresa", "TextBox")
            WITH THIS.cnt_4c_Operacao.txt_4c_Empresa
                .Visible           = .T.
                .Top               = 26
                .Left              = 5
                .Width             = 36
                .Height            = 23
                .ReadOnly          = .T.
                .Enabled           = .T.
                .ForeColor         = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 255)
                .TabStop           = .F.
                .Value             = ""
                .MaxLength   = 3
            ENDWITH

            *-- Operacao (dopps - char 20)
            THIS.cnt_4c_Operacao.AddObject("txt_4c_Operacao", "TextBox")
            WITH THIS.cnt_4c_Operacao.txt_4c_Operacao
                .Visible           = .T.
                .Top               = 26
                .Left              = 43
                .Width             = 156
                .Height            = 23
                .ReadOnly          = .T.
                .Enabled           = .T.
                .ForeColor         = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 255)
                .TabStop           = .F.
                .Value             = ""
            ENDWITH

            *-- Numero do processamento (numps - numeric 10 digitos)
            THIS.cnt_4c_Operacao.AddObject("txt_4c_Numps", "TextBox")
            WITH THIS.cnt_4c_Operacao.txt_4c_Numps
                .Visible           = .T.
                .Top               = 26
                .Left              = 201
                .Width             = 81
                .Height            = 23
                .ReadOnly          = .T.
                .Enabled           = .T.
                .ForeColor         = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 255)
                .InputMask         = "9999999999"
                .TabStop           = .F.
                .Value             = 0
            ENDWITH

            *-- Linha separadora abaixo do label
            THIS.cnt_4c_Operacao.AddObject("lin_4c_Divisoria", "Line")
            WITH THIS.cnt_4c_Operacao.lin_4c_Divisoria
                .Visible     = .T.
                .Top         = 19
                .Left        = 4
                .Width       = 316
                .Height      = 0
                .BorderWidth = 2
                .BorderColor = RGB(90, 90, 90)
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarBotaoOk - Botao OK standalone (Cancel=.T. = ESC fecha popup)
    * Standalone com Picture: Themes=.T. + DisabledPicture obrigatorios
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotaoOk()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("cmd_4c_Ok", "CommandButton")
            WITH THIS.cmd_4c_Ok
                .Visible         = .T.
                .Top             = 3
                .Left            = 925
                .Width           = 75
                .Height          = 75
                .Caption         = "OK"
                .Cancel          = .T.
                .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .Themes          = .T.
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
            ENDWITH

            BINDEVENT(THIS.cmd_4c_Ok, "Click", THIS, "CmdOkClick")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarShape1 - Shape decorativo atras do botao OK (BackStyle=0)
    * Top=7, Left=898, Width=90, Height=110, BorderColor=RGB(136,189,188)
    * Adicionado antes do botao OK para ficar corretamente atras dele no z-order
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarShape1()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("shp_4c_Shape1", "Shape")
            WITH THIS.shp_4c_Shape1
                .Visible     = .T.
                .Top         = 7
                .Left        = 898
                .Width       = 90
                .Height      = 110
                .BackStyle   = 0
                .BorderStyle = 0
                .BorderColor = RGB(136, 189, 188)
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarGrade - Grid read-only 9 colunas exibindo TmpDistrib
    * Ordem visual das colunas: Operacao|Grupo|Conta|Grupo|Conta|Servico|Qtde|Valor|Total
    * ControlSources definidos em ConfigurarRecordSourceGrade apos popular TmpDistrib
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade()
        LOCAL loc_oErro, loc_oGrd

        TRY
            THIS.AddObject("grd_4c_Dados", "Grid")
            loc_oGrd = THIS.grd_4c_Dados
            WITH loc_oGrd
                .Visible              = .T.
                .Top                  = 197
                .Left                 = 12
                .Width                = 976
                .Height               = 325
                .ColumnCount          = 9
                .FontName             = "Courier New"
                .FontSize             = 8
                .RowHeight            = 17
                .ScrollBars           = 2
                .ReadOnly             = .F.
                .RecordMark           = .F.
                .DeleteMark           = .F.
                .GridLineColor        = RGB(238, 238, 238)
                .HighlightStyle       = 2
                .HighlightBackColor   = RGB(255, 255, 255)
                .HighlightForeColor   = RGB(15, 41, 104)
                .Panel                = 1
                .RecordSourceType     = 1
            ENDWITH

            *-- Column1: Operacao (Empdnps) - ColumnOrder=1, Width=241
            WITH loc_oGrd.Column1
                .ColumnOrder = 1
                .Width       = 241
                .Movable     = .F.
                .Resizable   = .F.
                .ReadOnly    = .T.
                WITH .Header1
                    .Caption   = "Opera" + CHR(231) + CHR(227) + "o"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                ENDWITH
                WITH .Text1
                    .FontName    = "Courier New"
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0, 0, 0)
                    .BackColor   = RGB(255, 255, 255)
                ENDWITH
            ENDWITH

            *-- Column2: Grupo origem (Grupoos) - ColumnOrder=2, Width=80
            WITH loc_oGrd.Column2
                .ColumnOrder = 2
                .Width       = 80
                .Movable     = .F.
                .Resizable   = .F.
                .ReadOnly    = .T.
                WITH .Header1
                    .Caption   = "Grupo"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                ENDWITH
                WITH .Text1
                    .FontName    = "Courier New"
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0, 0, 0)
                    .BackColor   = RGB(255, 255, 255)
                ENDWITH
            ENDWITH

            *-- Column3: Conta origem (Contaos) - ColumnOrder=3, Width=80
            WITH loc_oGrd.Column3
                .ColumnOrder = 3
                .Width       = 80
                .Movable     = .F.
                .Resizable   = .F.
                .ReadOnly    = .T.
                WITH .Header1
                    .Caption   = "Conta"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                ENDWITH
                WITH .Text1
                    .FontName    = "Courier New"
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0, 0, 0)
                    .BackColor   = RGB(255, 255, 255)
                ENDWITH
            ENDWITH

            *-- Column4: Grupo destino (Grupods) - ColumnOrder=4, Width=80
            WITH loc_oGrd.Column4
                .ColumnOrder = 4
                .Width       = 80
                .Movable     = .F.
                .Resizable   = .F.
                .ReadOnly    = .T.
                WITH .Header1
                    .Caption   = "Grupo"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                ENDWITH
                WITH .Text1
                    .FontName    = "Courier New"
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0, 0, 0)
                    .BackColor   = RGB(255, 255, 255)
                ENDWITH
            ENDWITH

            *-- Column5: Conta destino (Contads) - ColumnOrder=5, Width=80
            WITH loc_oGrd.Column5
                .ColumnOrder = 5
                .Width       = 80
                .Movable     = .F.
                .Resizable   = .F.
                .ReadOnly    = .T.
                WITH .Header1
                    .Caption   = "Conta"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                ENDWITH
                WITH .Text1
                    .FontName    = "Courier New"
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0, 0, 0)
                    .BackColor   = RGB(255, 255, 255)
                ENDWITH
            ENDWITH

            *-- Column6: Servico (cMats) - ColumnOrder=6, Width=108
            WITH loc_oGrd.Column6
                .ColumnOrder = 6
                .Width       = 108
                .Movable     = .F.
                .Resizable   = .F.
                .ReadOnly    = .T.
                WITH .Header1
                    .Caption   = "Servi" + CHR(231) + "o"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                ENDWITH
                WITH .Text1
                    .FontName    = "Courier New"
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0, 0, 0)
                    .BackColor   = RGB(255, 255, 255)
                ENDWITH
            ENDWITH

            *-- Column7: Quantidade (Qtds) - ColumnOrder=7, Width=80
            WITH loc_oGrd.Column7
                .ColumnOrder = 7
                .Width       = 80
                .Movable     = .F.
                .Resizable   = .F.
                .ReadOnly    = .T.
                WITH .Header1
                    .Caption   = "Qtde"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                ENDWITH
                WITH .Text1
                    .FontName    = "Courier New"
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0, 0, 0)
                    .BackColor   = RGB(255, 255, 255)
                ENDWITH
            ENDWITH

            *-- Column8: Valor unitario (Fators) - ColumnOrder=8, Width=80
            WITH loc_oGrd.Column8
                .ColumnOrder = 8
                .Width       = 80
                .Movable     = .F.
                .Resizable   = .F.
                .ReadOnly    = .T.
                WITH .Header1
                    .Caption   = "Valor"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                ENDWITH
                WITH .Text1
                    .FontName    = "Courier New"
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0, 0, 0)
                    .BackColor   = RGB(255, 255, 255)
                ENDWITH
            ENDWITH

            *-- Column9: Total calculado (Qtds * Fators) - ColumnOrder=9, Width=108
            WITH loc_oGrd.Column9
                .ColumnOrder = 9
                .Width       = 108
                .Movable     = .F.
                .Resizable   = .F.
                .ReadOnly    = .T.
                WITH .Header1
                    .Caption   = "Total"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                ENDWITH
                WITH .Text1
                    .FontName    = "Courier New"
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0, 0, 0)
                    .BackColor   = RGB(255, 255, 255)
                ENDWITH
            ENDWITH

            BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarLabelsCabecalhoGrade - Labels "Origem" e "Destino" acima do grid
    * Indicam visualmente as colunas de conta origem e destino da movimentacao
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarLabelsCabecalhoGrade()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("lbl_4c_Origem", "Label")
            WITH THIS.lbl_4c_Origem
                .Visible     = .T.
                .Top         = 182
                .Left        = 264
                .Width       = 163
                .Height      = 15
                .AutoSize    = .F.
                .FontBold    = .T.
                .FontSize    = 8
                .Alignment   = 2
                .BackStyle   = 1
                .BackColor   = RGB(255, 255, 255)
                .BorderStyle = 1
                .Caption     = "Origem"
            ENDWITH

            THIS.AddObject("lbl_4c_Destino", "Label")
            WITH THIS.lbl_4c_Destino
                .Visible     = .T.
                .Top         = 182
                .Left        = 426
                .Width       = 163
                .Height      = 15
                .AutoSize    = .F.
                .FontBold    = .T.
                .FontSize    = 8
                .Alignment   = 2
                .BackStyle   = 1
                .BackColor   = RGB(255, 255, 255)
                .BorderStyle = 1
                .Caption     = "Destino"
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarRodape - Campos de descricao e totais abaixo do grid
    * Say2 "Descricao" + txt_4c_Descr + txt_4c_DescOrig/Dest + totais amarelos
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarRodape()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("lbl_4c_Say2", "Label")
            WITH THIS.lbl_4c_Say2
                .Visible   = .T.
                .Top       = 525
                .Left      = 591
                .AutoSize  = .T.
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
            ENDWITH

            *-- Descricao do produto (TmpDistrib.Dpros) - Get_descr do legado
            THIS.AddObject("txt_4c_Descr", "TextBox")
            WITH THIS.txt_4c_Descr
                .Visible           = .T.
                .Top               = 540
                .Left              = 541
                .Width             = 241
                .Height            = 23
                .ReadOnly          = .T.
                .TabStop           = .F.
                .DisabledBackColor = RGB(255, 255, 255)
                .Value             = ""
            ENDWITH

            *-- Descricao conta origem (TmpDistrib.DescOrig) - getDescOrig do legado
            THIS.AddObject("txt_4c_DescOrig", "TextBox")
            WITH THIS.txt_4c_DescOrig
                .Visible           = .T.
                .Top               = 541
                .Left              = 217
                .Width             = 150
                .Height            = 22
                .ReadOnly          = .T.
                .TabStop           = .F.
                .DisabledBackColor = RGB(255, 255, 255)
                .Value             = ""
            ENDWITH

            *-- Descricao conta destino (TmpDistrib.DescDest) - getDescDest do legado
            THIS.AddObject("txt_4c_DescDest", "TextBox")
            WITH THIS.txt_4c_DescDest
                .Visible           = .T.
                .Top               = 541
                .Left              = 379
                .Width             = 150
                .Height            = 22
                .ReadOnly          = .T.
                .TabStop           = .F.
                .DisabledBackColor = RGB(255, 255, 255)
                .Value             = ""
            ENDWITH

            *-- Total de quantidade acumulada (getQtdTot do legado) - fundo amarelo
            THIS.AddObject("txt_4c_QtdTot", "TextBox")
            WITH THIS.txt_4c_QtdTot
                .Visible   = .T.
                .Top       = 521
                .Left      = 696
                .Width     = 83
                .Height    = 18
                .ReadOnly  = .T.
                .TabStop   = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Margin    = 0
                .MaxLength = 12
                .InputMask = "999,999.99"
                .BackColor = RGB(255, 255, 128)
                .Value     = 0
            ENDWITH

            *-- Total de valor acumulado (getValtot do legado) - fundo amarelo
            THIS.AddObject("txt_4c_Valtot", "TextBox")
            WITH THIS.txt_4c_Valtot
                .Visible   = .T.
                .Top       = 521
                .Left      = 860
                .Width     = 108
                .Height    = 18
                .ReadOnly  = .T.
                .TabStop   = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Margin    = 0
                .MaxLength = 12
                .InputMask = "999,999.99"
                .BackColor = RGB(255, 255, 128)
                .Value     = 0
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarRecordSourceGrade - Vincula TmpDistrib ao grid apos carga de dados
    * Chamado em CarregarDados() depois de CarregarServicosDeXMfas popular TmpDistrib
    * Redefine headers apos RecordSource (VFP9 reseta headers ao mudar RecordSource)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarRecordSourceGrade()
        LOCAL loc_oErro, loc_oGrd

        TRY
            IF !USED("TmpDistrib") OR VARTYPE(THIS.grd_4c_Dados) # "O"
                RETURN
            ENDIF

            loc_oGrd = THIS.grd_4c_Dados
            SELECT TmpDistrib
            GO TOP

            loc_oGrd.ColumnCount  = 9
            loc_oGrd.RecordSource = "TmpDistrib"

            WITH loc_oGrd
                .Column1.ControlSource = "TmpDistrib.Empdnps"
                .Column2.ControlSource = "TmpDistrib.Grupoos"
                .Column3.ControlSource = "TmpDistrib.Contaos"
                .Column4.ControlSource = "TmpDistrib.Grupods"
                .Column5.ControlSource = "TmpDistrib.Contads"
                .Column6.ControlSource = "TmpDistrib.Cmats"
                .Column7.ControlSource = "TmpDistrib.Qtds"
                .Column8.ControlSource = "TmpDistrib.Fators"
                .Column9.ControlSource = "TmpDistrib.Qtds * TmpDistrib.Fators"
                .SetAll("DynamicForeColor", "IIF(TmpDistrib.Retrabs, RGB(255,0,0), RGB(0,0,0))", "Column")
                *-- Redefine headers apos RecordSource (VFP9 reseta ao mudar RecordSource)
                .Column1.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
                .Column2.Header1.Caption = "Grupo"
                .Column3.Header1.Caption = "Conta"
                .Column4.Header1.Caption = "Grupo"
                .Column5.Header1.Caption = "Conta"
                .Column6.Header1.Caption = "Servi" + CHR(231) + "o"
                .Column7.Header1.Caption = "Qtde"
                .Column8.Header1.Caption = "Valor"
                .Column9.Header1.Caption = "Total"
                .Refresh()
            ENDWITH

            *-- Vincula campos de descricao ao cursor TmpDistrib
            THIS.txt_4c_Descr.ControlSource   = "TmpDistrib.Dpros"
            THIS.txt_4c_DescOrig.ControlSource = "TmpDistrib.DescOrig"
            THIS.txt_4c_DescDest.ControlSource = "TmpDistrib.DescDest"

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GrdDadosAfterRowColChange - Atualiza campos descricao ao mudar linha
    * BINDEVENT requer LPARAMETERS (AfterRowColChange passa nColIndex como arg)
    *==========================================================================
    PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
        IF VARTYPE(THIS.txt_4c_Descr) = "O"
            THIS.txt_4c_Descr.Refresh()
        ENDIF
        IF VARTYPE(THIS.txt_4c_DescOrig) = "O"
            THIS.txt_4c_DescOrig.Refresh()
        ENDIF
        IF VARTYPE(THIS.txt_4c_DescDest) = "O"
            THIS.txt_4c_DescDest.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Monta a area de listagem do popup (grid + labels
    * de cabecalho Origem/Destino + rodape com descricoes e totais). Como o
    * form OPERACIONAL nao usa PageFrame CRUD (Page1=Lista/Page2=Dados), este
    * metodo agrega a configuracao da unica "pagina" visual do popup: o grid
    * de servicos lancados. Chamado a partir de InicializarForm.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oErro

        TRY
            THIS.ConfigurarGrade()
            THIS.ConfigurarLabelsCabecalhoGrade()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro FormSigPrSer.ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Area de exibicao do registro corrente do grid.
    * Em forms OPERACIONAIS nao ha Page2=Dados; este metodo agrupa controles
    * read-only que refletem a linha selecionada + acumuladores de totais:
    *   - cnt_4c_Cabecalho (area transparente de identificacao)
    *   - lbl_4c_Say2 (label "Descricao")
    *   - txt_4c_Descr (descricao produto, TmpDistrib.Dpros)
    *   - txt_4c_DescOrig (descricao conta origem, TmpDistrib.DescOrig)
    *   - txt_4c_DescDest (descricao conta destino, TmpDistrib.DescDest)
    *   - txt_4c_QtdTot / txt_4c_Valtot (totais amarelos acumulados)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oErro

        TRY
            *-- Container-banner opcional identificando a area de dados
            IF !PEMSTATUS(THIS, "cnt_4c_Cabecalho", 5)
                THIS.AddObject("cnt_4c_Cabecalho", "Container")
                WITH THIS.cnt_4c_Cabecalho
                    .Visible       = .T.
                    .Top           = 505
                    .Left          = 12
                    .Width         = THIS.Width
                    .Height        = 14
                    .BackStyle     = 0
                    .BorderWidth   = 0
                    .SpecialEffect = 0
                ENDWITH
            ENDIF

            *-- Rodape com descricoes e totais (per-record data area)
            THIS.ConfigurarRodape()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro FormSigPrSer.ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna o estado visual do popup entre modos de exibicao.
    * Como o form OPERACIONAL tem uma unica pagina (grid de servicos lancados),
    * o parametro par_nPagina controla o comportamento de refresh/foco:
    *   par_nPagina = 1 -> modo EXIBICAO (default): recarrega vinculacao do grid,
    *                      atualiza totais e coloca foco no grid
    *   par_nPagina = 2 -> modo TOTAIS: apenas re-executa Acumular para atualizar
    *                      os valores agregados (getQtdTot/getValtot) sem alterar
    *                      RecordSource nem foco (usado apos edicao externa em
    *                      TmpDistrib pelo form pai)
    * Retorna .T. se conseguiu alternar; .F. em qualquer excecao.
    *==========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lSucesso, loc_nPagina, loc_oErro
        loc_lSucesso = .F.

        loc_nPagina = IIF(VARTYPE(par_nPagina) = "N" AND par_nPagina > 0, par_nPagina, 1)

        TRY
            DO CASE
                CASE loc_nPagina = 1
                    THIS.this_cModoAtual = "EXIBICAO"
                    THIS.ConfigurarRecordSourceGrade()
                    THIS.Acumular()
                    IF VARTYPE(THIS.grd_4c_Dados) = "O"
                        THIS.grd_4c_Dados.Refresh()
                        IF USED("TmpDistrib") AND RECCOUNT("TmpDistrib") > 0
                            THIS.grd_4c_Dados.SetFocus()
                        ENDIF
                    ENDIF
                    loc_lSucesso = .T.

                CASE loc_nPagina = 2
                    THIS.this_cModoAtual = "TOTAIS"
                    THIS.Acumular()
                    loc_lSucesso = .T.

                OTHERWISE
                    THIS.this_cModoAtual = "EXIBICAO"
                    THIS.ConfigurarRecordSourceGrade()
                    THIS.Acumular()
                    loc_lSucesso = .T.
            ENDCASE

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro FormSigPrSer.AlternarPagina")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Recursivo; form nao tem containers flutuantes
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_p, loc_oControl, loc_oErro

        TRY
            FOR loc_i = 1 TO par_oContainer.ControlCount
                loc_oControl = par_oContainer.Controls(loc_i)
                IF VARTYPE(loc_oControl) = "O"
                    IF PEMSTATUS(loc_oControl, "Visible", 5)
                        loc_oControl.Visible = .T.
                    ENDIF
                    IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                        FOR loc_p = 1 TO loc_oControl.PageCount
                            THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_p))
                        ENDFOR
                    ENDIF
                    IF PEMSTATUS(loc_oControl, "ControlCount", 5)
                        IF loc_oControl.ControlCount > 0
                            THIS.TornarControlesVisiveis(loc_oControl)
                        ENDIF
                    ENDIF
                ENDIF
            ENDFOR

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarDados - Percorre xMfas via BO e popula TmpDistrib com servicos
    *==========================================================================
    PROTECTED PROCEDURE CarregarDados()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                IF USED("xMfas")
                    loc_lSucesso = THIS.this_oBusinessObject.CarregarServicosDeXMfas("xMfas")
                    IF !loc_lSucesso AND !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                        MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
                    ENDIF
                ELSE
                    *-- xMfas nao disponivel; grid fica vazio mas form abre
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
            THIS.ConfigurarRecordSourceGrade()
            THIS.Acumular()
            THIS.PopularCamposOperacao()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * PopularCamposOperacao - Popula Empresa/Operacao/Numps a partir do cursor
    * tmpnens do form pai (acessivel via SET DATASESSION TO pai.DataSessionId
    * executado em Init). Campos sao somente-leitura, exibidos no cnt_4c_Operacao.
    *==========================================================================
    PROTECTED PROCEDURE PopularCamposOperacao()
        LOCAL loc_oErro

        TRY
            IF USED("tmpnens") AND VARTYPE(THIS.cnt_4c_Operacao) = "O"
                SELECT tmpnens
                GO TOP
                IF !EOF()
                    THIS.cnt_4c_Operacao.txt_4c_Empresa.Value  = ALLTRIM(NVL(tmpnens.emps,  ""))
                    THIS.cnt_4c_Operacao.txt_4c_Operacao.Value = ALLTRIM(NVL(tmpnens.dopps, ""))
                    THIS.cnt_4c_Operacao.txt_4c_Numps.Value    = NVL(tmpnens.numps, 0)
                    THIS.cnt_4c_Operacao.txt_4c_Empresa.Refresh()
                    THIS.cnt_4c_Operacao.txt_4c_Operacao.Refresh()
                    THIS.cnt_4c_Operacao.txt_4c_Numps.Refresh()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Acumular - Calcula totais de TmpDistrib e atualiza campos de exibicao
    *==========================================================================
    PROCEDURE Acumular()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.Acumular()

                IF VARTYPE(THIS.txt_4c_QtdTot) = "O"
                    THIS.txt_4c_QtdTot.Value = THIS.this_oBusinessObject.this_nQtdTotal
                    THIS.txt_4c_QtdTot.Refresh()
                ENDIF

                IF VARTYPE(THIS.txt_4c_Valtot) = "O"
                    THIS.txt_4c_Valtot.Value = THIS.this_oBusinessObject.this_nValTotal
                    THIS.txt_4c_Valtot.Refresh()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Recarrega/atualiza visualizacao do grid e totais
    * Popup nao possui botao de visualizar dedicado (unico botao eh OK), mas
    * este handler pode ser chamado por atalho ou pelo form pai para forcar
    * refresh da area de exibicao apos alteracoes externas em TmpDistrib.
    * Reaplica RecordSource + Acumular + Refresh do grid.
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro

        TRY
            THIS.ConfigurarRecordSourceGrade()
            THIS.Acumular()
            THIS.PopularCamposOperacao()

            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.Refresh()
                IF USED("TmpDistrib") AND RECCOUNT("TmpDistrib") > 0
                    SELECT TmpDistrib
                    GO TOP
                    THIS.grd_4c_Dados.SetFocus()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro FormSigPrSer.BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Confirma a inclusao dos servicos exibidos no grid
    * (persiste TmpDistrib no cursor xnensi do form pai, seguindo o padrao
    * original de ok.Click do SIGPRSER). Fluxo equivale a "Incluir/Confirmar
    * lancamento" e delega a CmdOkClick para reaproveitar a logica de
    * fechamento e reativacao do form pai.
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro, loc_lTemDados

        TRY
            loc_lTemDados = USED("TmpDistrib") AND RECCOUNT("TmpDistrib") > 0
            IF !loc_lTemDados
                MsgAviso("Nenhum servi" + CHR(231) + "o dispon" + CHR(237) + "vel para inclus" + CHR(227) + "o.", ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF

            THIS.Acumular()
            THIS.CmdOkClick()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro FormSigPrSer.BtnIncluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Recarrega servicos a partir de xMfas (source original)
    * Reexecuta CarregarServicosDeXMfas via BO regenerando TmpDistrib.
    * Equivalente a "alterar/refazer" a montagem dos lancamentos com base na
    * origem, util quando xMfas foi modificado externamente pelo form pai.
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oErro

        TRY
            IF !USED("xMfas")
                MsgAviso("Cursor xMfas n" + CHR(227) + "o dispon" + CHR(237) + "vel para recarga.", ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF

            THIS.CarregarDados()
            THIS.AlternarPagina(1)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro FormSigPrSer.BtnAlterarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Remove o registro corrente de TmpDistrib apos confirmar
    * Permite retirar um servico especifico do lote antes de confirmar o
    * lancamento no form pai. Nao mexe em xMfas nem em xnensi (edicao apenas
    * na copia local TmpDistrib). Reatualiza totais e refresca grid.
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oErro, loc_lConfirmar

        TRY
            IF !USED("TmpDistrib") OR RECCOUNT("TmpDistrib") = 0
                MsgAviso("Nenhum servi" + CHR(231) + "o selecionado para exclus" + CHR(227) + "o.", ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF

            SELECT TmpDistrib
            IF EOF() OR BOF()
                GO TOP
            ENDIF

            loc_lConfirmar = MsgConfirma("Confirma a exclus" + CHR(227) + "o do servi" + CHR(231) + ;
                                        "o selecionado do lote atual?", ;
                                        "Confirma" + CHR(231) + CHR(227) + "o")
            IF !loc_lConfirmar
                RETURN
            ENDIF

            DELETE
            SET DELETED ON
            IF !EOF()
                SKIP
            ENDIF
            IF EOF()
                GO BOTT
            ENDIF

            THIS.Acumular()
            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.Refresh()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro FormSigPrSer.BtnExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdOkClick - Fecha popup e reativa form pai
    * Ligado via BINDEVENT("Click") na Fase 7
    * Cancel=.T. no botao garante que ESC tambem dispara este handler
    *==========================================================================
    PROCEDURE CmdOkClick()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oParentForm) = "O" AND ;
               !ISNULL(THIS.this_oParentForm)
                THIS.this_oParentForm.Enabled = .T.
                *-- Navega xnensi para o fim (padrao legado apos fechar popup)
                IF USED("xnensi")
                    SELECT xnensi
                    GO BOTT
                ENDIF
                THIS.this_oParentForm.Refresh()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        THIS.Release()
    ENDPROC

    *==========================================================================
    * CarregarLista - Compatibilidade com pipeline; delega a CarregarDados
    *==========================================================================
    PROCEDURE CarregarLista()
        RETURN THIS.CarregarDados()
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere campos do cnt_4c_Operacao para o BO
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
               VARTYPE(THIS.cnt_4c_Operacao) = "O"
                THIS.this_oBusinessObject.this_cEmps  = ALLTRIM(THIS.cnt_4c_Operacao.txt_4c_Empresa.Value)
                THIS.this_oBusinessObject.this_cDopps = ALLTRIM(THIS.cnt_4c_Operacao.txt_4c_Operacao.Value)
                THIS.this_oBusinessObject.this_nNumps = THIS.cnt_4c_Operacao.txt_4c_Numps.Value
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BOParaForm - Popula cnt_4c_Operacao a partir das propriedades do BO
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
               VARTYPE(THIS.cnt_4c_Operacao) = "O"
                THIS.cnt_4c_Operacao.txt_4c_Empresa.Value  = THIS.this_oBusinessObject.this_cEmps
                THIS.cnt_4c_Operacao.txt_4c_Operacao.Value = THIS.this_oBusinessObject.this_cDopps
                THIS.cnt_4c_Operacao.txt_4c_Numps.Value    = THIS.this_oBusinessObject.this_nNumps
                THIS.cnt_4c_Operacao.txt_4c_Empresa.Refresh()
                THIS.cnt_4c_Operacao.txt_4c_Operacao.Refresh()
                THIS.cnt_4c_Operacao.txt_4c_Numps.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Popup somente-leitura; todos os campos ficam ReadOnly
    * par_lHabilitar ignorado (sem modo de edicao)
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.cnt_4c_Operacao) = "O"
                THIS.cnt_4c_Operacao.txt_4c_Empresa.ReadOnly  = .T.
                THIS.cnt_4c_Operacao.txt_4c_Operacao.ReadOnly = .T.
                THIS.cnt_4c_Operacao.txt_4c_Numps.ReadOnly    = .T.
            ENDIF
            IF VARTYPE(THIS.txt_4c_Descr) = "O"
                THIS.txt_4c_Descr.ReadOnly = .T.
            ENDIF
            IF VARTYPE(THIS.txt_4c_DescOrig) = "O"
                THIS.txt_4c_DescOrig.ReadOnly = .T.
            ENDIF
            IF VARTYPE(THIS.txt_4c_DescDest) = "O"
                THIS.txt_4c_DescDest.ReadOnly = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparCampos - Zera rodape de descricoes e totais acumulados
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.txt_4c_Descr) = "O"
                THIS.txt_4c_Descr.Value = ""
                THIS.txt_4c_Descr.Refresh()
            ENDIF
            IF VARTYPE(THIS.txt_4c_DescOrig) = "O"
                THIS.txt_4c_DescOrig.Value = ""
                THIS.txt_4c_DescOrig.Refresh()
            ENDIF
            IF VARTYPE(THIS.txt_4c_DescDest) = "O"
                THIS.txt_4c_DescDest.Value = ""
                THIS.txt_4c_DescDest.Refresh()
            ENDIF
            IF VARTYPE(THIS.txt_4c_QtdTot) = "O"
                THIS.txt_4c_QtdTot.Value = 0
                THIS.txt_4c_QtdTot.Refresh()
            ENDIF
            IF VARTYPE(THIS.txt_4c_Valtot) = "O"
                THIS.txt_4c_Valtot.Value = 0
                THIS.txt_4c_Valtot.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Popup com unico cmd_4c_Ok (sempre habilitado)
    * par_cModo ignorado
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo(par_cModo)
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.cmd_4c_Ok) = "O"
                THIS.cmd_4c_Ok.Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Recarrega grid a partir de xMfas
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.BtnAlterarClick()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha popup e reativa form pai
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.CmdOkClick()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Confirma estado atual e fecha popup (form read-only)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.CmdOkClick()
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela e fecha popup
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.CmdOkClick()
    ENDPROC

    *==========================================================================
    * Destroy - Limpa Business Object antes de fechar
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrSerBO.prg):
*==============================================================================
* SigPrSerBO.prg - Business Object: Servi?os Lan?ados
* Tipo: OPERACIONAL (somente leitura - popup filho de form de processamento)
* Tabelas: SigPdMvf, SigCdNei, SigCdNec, SigCdPro, SigCdCli
*==============================================================================

DEFINE CLASS SigPrSerBO AS BusinessBase

    *-- Identifica??o da entidade
    this_cTabela        = "SigCdNei"
    this_cCampoChave    = "cidchaves"

    *-- Chave prim?ria composta (char(20)) do registro corrente em SigCdNei
    this_cCidchaves     = ""

    *-- Dados da opera??o pai (exibidos no container Opera??o)
    this_cEmpdnps       = ""  && char(33) - chave composta emp+op+num
    this_cEmps          = ""  && char(3)  - empresa
    this_nNumps         = 0   && numeric(10,0) - n?mero do processamento
    this_cDopps         = ""  && char(20) - descri??o da opera??o

    *-- Campos do registro corrente do grid (TmpDistrib)
    this_cGrupoos       = ""  && char(10) - grupo de origem (SigCdNec)
    this_cContaos       = ""  && char(10) - conta de origem (SigCdNec)
    this_cGrupods       = ""  && char(10) - grupo de destino (SigCdNec)
    this_cContads       = ""  && char(10) - conta de destino (SigCdNec)
    this_nNops          = 0   && numeric(10,0) - n?mero da opera??o (SigCdNei)
    this_cCmats         = ""  && char(14) - c?digo do material/servi?o (SigCdNei)
    this_nFators        = 0   && numeric(7,4) - fator unit?rio (SigCdNei)
    this_nQtds          = 0   && numeric(9,3) - quantidade (SigCdNei)
    this_cCretrabs      = ""  && char(6) - c?digo retrabalho (SigCdNei)
    this_lRetrabs       = .F. && bit - flag retrabalho (SigCdNec)
    this_cCdescs        = ""  && char(40) - descri??o complementar (SigCdNei)
    this_cDpros         = ""  && char(?) - descri??o do produto/servi?o (SigCdPro)
    this_cDescOrig      = ""  && char(60) - descri??o conta origem (SigCdCli.Rclis)
    this_cDescDest      = ""  && char(60) - descri??o conta destino (SigCdCli.Rclis)

    *-- Totais acumulados do grid
    this_nQtdTotal      = 0   && SUM(qtds)
    this_nValTotal      = 0   && SUM(qtds * fators)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        DODEFAULT()

        THIS.this_cTabela     = "SigCdNei"
        THIS.this_cCampoChave = "cidchaves"
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarServicos(par_nNops)
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cSQL, loc_nNops, loc_oErro
        loc_lSucesso = .F.
        loc_nNops    = IIF(VARTYPE(par_nNops) = "N", par_nNops, 0)

        TRY
            *-- Cursor placeholder (estrutura identica ao SQLEXEC)
            IF USED("TmpDistrib")
                TABLEREVERT(.T., "TmpDistrib")
                USE IN TmpDistrib
            ENDIF

            SET NULL ON
            CREATE CURSOR TmpDistrib ( ;
                Empdnps  C(33)  NULL, ;
                Grupoos  C(10)  NULL, ;
                Contaos  C(10)  NULL, ;
                Grupods  C(10)  NULL, ;
                Contads  C(10)  NULL, ;
                Nops     N(10,0) NULL, ;
                cMats    C(14)  NULL, ;
                Fators   N(7,4)  NULL, ;
                Qtds     N(9,3)  NULL, ;
                Cretrabs C(6)   NULL, ;
                Retrabs  I      NULL, ;
                CDescs   C(40)  NULL, ;
                Dpros    C(40)  NULL, ;
                DescOrig C(60)  NULL, ;
                DescDest C(60)  NULL  ;
            )
            SET NULL OFF

            *-- SELECT base com where 0=1 para criar estrutura
            loc_cSQL = "SELECT a.Empdnps, c.grupoos, c.contaos, c.grupods, c.contads, " + ;
                       "b.nOps, b.cmats, b.fators, b.qtds, b.cretrabs, c.retrabs, " + ;
                       "b.CDescs, d.Dpros, " + ;
                       "e.Rclis as DescOrig, f.Rclis as DescDest " + ;
                       "FROM SigPdMvf a " + ;
                       "INNER JOIN SigCdNei b ON a.Empdnps = b.Empdnps " + ;
                       "INNER JOIN SigCdNec c ON a.Empdnps = c.Empdnps " + ;
                       "INNER JOIN SigCdPro d ON b.Cmats = d.Cpros " + ;
                       "INNER JOIN SigCdCli e ON c.Contaos = e.Iclis " + ;
                       "INNER JOIN SigCdCli f ON c.Contads = f.Iclis " + ;
                       "WHERE a.Nops = " + FormatarNumeroSQL(loc_nNops, 0) + ;
                       " AND b.servicos = 1 AND b.Cats <> ''"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ServicosTmp") < 1
                THIS.this_cMensagemErro = "Falha ao carregar servi" + CHR(231) + CHR(245) + "os lan" + CHR(231) + "ados."
            ELSE
                SELECT TmpDistrib
                ZAP
                APPEND FROM DBF("cursor_4c_ServicosTmp")
                IF USED("cursor_4c_ServicosTmp")
                    USE IN cursor_4c_ServicosTmp
                ENDIF
                SELECT TmpDistrib
                GO TOP
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarServicosDeXMfas(par_cCursorXMfas)
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cSQL, loc_nNops, loc_oErro, loc_cAlias
        loc_lSucesso = .F.
        loc_cAlias   = IIF(VARTYPE(par_cCursorXMfas) = "C" AND !EMPTY(par_cCursorXMfas), par_cCursorXMfas, "xMfas")

        IF !USED(loc_cAlias)
            THIS.this_cMensagemErro = "Cursor " + loc_cAlias + " n" + CHR(227) + "o est" + CHR(225) + " aberto."
            RETURN .F.
        ENDIF

        TRY
            *-- Criar/recriar cursor TmpDistrib
            IF USED("TmpDistrib")
                TABLEREVERT(.T., "TmpDistrib")
                USE IN TmpDistrib
            ENDIF

            SET NULL ON
            CREATE CURSOR TmpDistrib ( ;
                Empdnps  C(33)  NULL, ;
                Grupoos  C(10)  NULL, ;
                Contaos  C(10)  NULL, ;
                Grupods  C(10)  NULL, ;
                Contads  C(10)  NULL, ;
                Nops     N(10,0) NULL, ;
                cMats    C(14)  NULL, ;
                Fators   N(7,4)  NULL, ;
                Qtds     N(9,3)  NULL, ;
                Cretrabs C(6)   NULL, ;
                Retrabs  I      NULL, ;
                CDescs   C(40)  NULL, ;
                Dpros    C(40)  NULL, ;
                DescOrig C(60)  NULL, ;
                DescDest C(60)  NULL  ;
            )
            SET NULL OFF

            *-- Percorre fases do cursor xMfas (mesmo padr?o do legado)
            SELECT (loc_cAlias)
            SCAN
                loc_nNops = Nops

                loc_cSQL = "SELECT b.Empdnps, c.grupoos, c.contaos, c.grupods, c.contads, " + ;
                           "b.cmats, b.fators, b.qtds, b.cretrabs, c.retrabs, " + ;
                           "b.CDescs, d.dpros, " + ;
                           "e.Rclis as DescOrig, f.Rclis as DescDest " + ;
                           "FROM SigPdMvf a " + ;
                           "INNER JOIN SigCdNei b ON a.Empdnps = b.Empdnps " + ;
                           "INNER JOIN SigCdNec c ON a.Empdnps = c.Empdnps " + ;
                           "INNER JOIN SigCdPro d ON b.Cmats = d.Cpros " + ;
                           "INNER JOIN SigCdCli e ON c.Contaos = e.Iclis " + ;
                           "INNER JOIN SigCdCli f ON c.Contads = f.Iclis " + ;
                           "WHERE a.Nops = " + FormatarNumeroSQL(loc_nNops, 0) + ;
                           " AND b.servicos = 1 AND b.Cats <> ''"

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalMFas4") >= 1
                    SELECT cursor_4c_LocalMFas4
                    SCAN
                        SCATTER MEMO MEMVAR
                        SELECT TmpDistrib
                        INSERT INTO TmpDistrib FROM MEMVAR
                    ENDSCAN
                    IF USED("cursor_4c_LocalMFas4")
                        USE IN cursor_4c_LocalMFas4
                    ENDIF
                ENDIF
            ENDSCAN

            SELECT TmpDistrib
            GO TOP
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Acumular()
    *--------------------------------------------------------------------------
        LOCAL loc_nQtdTotal, loc_nValTotal, loc_oErro
        loc_nQtdTotal = 0
        loc_nValTotal = 0

        TRY
            IF USED("TmpDistrib") AND RECCOUNT("TmpDistrib") > 0
                SELECT SUM(Qtds) AS loc_nQtd, SUM(Qtds * Fators) AS loc_nVal ;
                    FROM TmpDistrib ;
                    INTO CURSOR cursor_4c_Acumulado READWRITE
                IF USED("cursor_4c_Acumulado")
                    SELECT cursor_4c_Acumulado
                    loc_nQtdTotal = NVL(loc_nQtd, 0)
                    loc_nValTotal = NVL(loc_nVal, 0)
                    USE IN cursor_4c_Acumulado
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        THIS.this_nQtdTotal = loc_nQtdTotal
        THIS.this_nValTotal = loc_nValTotal
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cCursorAlias)
    *--------------------------------------------------------------------------
        LOCAL loc_cAlias
        loc_cAlias = IIF(VARTYPE(par_cCursorAlias) = "C" AND !EMPTY(par_cCursorAlias), par_cCursorAlias, "TmpDistrib")

        IF !USED(loc_cAlias)
            RETURN .F.
        ENDIF

        SELECT (loc_cAlias)
        THIS.this_cEmpdnps  = TratarNulo(Empdnps,  "C")
        THIS.this_cGrupoos  = TratarNulo(Grupoos,  "C")
        THIS.this_cContaos  = TratarNulo(Contaos,  "C")
        THIS.this_cGrupods  = TratarNulo(Grupods,  "C")
        THIS.this_cContads  = TratarNulo(Contads,  "C")
        THIS.this_nNops     = TratarNulo(Nops,     "N")
        THIS.this_cCmats    = TratarNulo(cMats,    "C")
        THIS.this_nFators   = TratarNulo(Fators,   "N")
        THIS.this_nQtds     = TratarNulo(Qtds,     "N")
        THIS.this_cCretrabs = TratarNulo(Cretrabs, "C")
        IF VARTYPE(Retrabs) = "L"
            THIS.this_lRetrabs = Retrabs
        ELSE
            IF VARTYPE(Retrabs) = "L"
                THIS.this_lRetrabs = Retrabs
            ELSE
                IF VARTYPE(Retrabs) = "L"
                    THIS.this_lRetrabs = Retrabs
                ELSE
                    IF VARTYPE(Retrabs) = "L"
                        THIS.this_lRetrabs = Retrabs
                    ELSE
                        THIS.this_lRetrabs = (NVL(Retrabs, 0) = 1)
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
        THIS.this_cCdescs   = TratarNulo(CDescs,   "C")
        THIS.this_cDpros    = TratarNulo(Dpros,    "C")
        THIS.this_cDescOrig = TratarNulo(DescOrig, "C")
        THIS.this_cDescDest = TratarNulo(DescDest, "C")

        *-- Chave prim?ria opcional (SigCdNei.cidchaves) quando presente no cursor
        IF TYPE(loc_cAlias + ".Cidchaves") != "U"
            THIS.this_cCidchaves = TratarNulo(Cidchaves, "C")
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna cidchaves (char(20)) do registro em SigCdNei
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdNei do servi?o corrente
    *   Persiste os campos do registro carregado (Empdnps, Nops, Cmats, Qtds,
    *   Fators, Cretrabs, CDescs). Marca Servicos=1 e gera chave prim?ria
    *   cidchaves quando ausente.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_cCats, loc_oErro, loc_nResultado
        loc_lSucesso = .F.

        TRY
            *-- Cats = primeiros 6 chars do c?digo do material (padr?o legado)
            loc_cCats = LEFT(THIS.this_cCmats, 6)

            *-- Gera chave prim?ria composta se ainda n?o houver
            IF EMPTY(THIS.this_cCidchaves)
                loc_cChave = LEFT(ALLTRIM(THIS.this_cEmpdnps) + ;
                                  PADL(ALLTRIM(TRANSFORM(THIS.this_nNops)), 10, "0") + ;
                                  ALLTRIM(loc_cCats), 20)
                THIS.this_cCidchaves = loc_cChave
            ENDIF

            loc_cSQL = "INSERT INTO SigCdNei (" + ;
                       "cidchaves, Empdnps, Nops, Cmats, Cats, " + ;
                       "Qtds, Fators, Cretrabs, Cdescs, Servicos, " + ;
                       "Emps, Numps, Dopps" + ;
                       ") VALUES (" + ;
                       EscaparSQL(LEFT(THIS.this_cCidchaves, 20)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cEmpdnps, 33)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNops, 0) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cCmats, 14)) + ", " + ;
                       EscaparSQL(LEFT(loc_cCats, 6)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtds, 3) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nFators, 4) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cCretrabs, 6)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cCdescs, 40)) + ", " + ;
                       "1, " + ;
                       EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumps, 0) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cDopps, 20)) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 1
                THIS.this_cMensagemErro = "Falha ao inserir servi" + CHR(231) + "o em SigCdNei."
            ELSE
                THIS.RegistrarAuditoria("INCLUSAO")
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigCdNei do servi?o corrente por Empdnps+Cmats
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro, loc_nResultado
        loc_lSucesso = .F.

        IF EMPTY(THIS.this_cEmpdnps) OR EMPTY(THIS.this_cCmats)
            THIS.this_cMensagemErro = "Empdnps ou Cmats n" + CHR(227) + "o informado."
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "UPDATE SigCdNei SET " + ;
                       "Nops     = " + FormatarNumeroSQL(THIS.this_nNops, 0) + ", " + ;
                       "Cats     = " + EscaparSQL(LEFT(THIS.this_cCmats, 6)) + ", " + ;
                       "Qtds     = " + FormatarNumeroSQL(THIS.this_nQtds, 3) + ", " + ;
                       "Fators   = " + FormatarNumeroSQL(THIS.this_nFators, 4) + ", " + ;
                       "Cretrabs = " + EscaparSQL(LEFT(THIS.this_cCretrabs, 6)) + ", " + ;
                       "Cdescs   = " + EscaparSQL(LEFT(THIS.this_cCdescs, 40)) + ", " + ;
                       "Servicos = 1 " + ;
                       "WHERE Empdnps = " + EscaparSQL(LEFT(THIS.this_cEmpdnps, 33)) + ;
                       " AND Cmats = " + EscaparSQL(LEFT(THIS.this_cCmats, 14))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 1
                THIS.this_cMensagemErro = "Falha ao atualizar servi" + CHR(231) + "o em SigCdNei."
            ELSE
                THIS.RegistrarAuditoria("ALTERACAO")
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

