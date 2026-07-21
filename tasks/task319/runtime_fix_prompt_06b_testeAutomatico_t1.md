# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'BtnEncerrarExiste': Nenhum metodo de encerramento encontrado (BtnEncerrarClick/BtnFecharClick/BtnSairClick)

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[18/07/2026 06:02:10] Erro: Connection handle is invalid.
[18/07/2026 06:02:10] Erro: Connection handle is invalid.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-18 06:01:44] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-18 06:01:44] [INFO] Config FPW: (nao fornecido)
[2026-07-18 06:01:44] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-18 06:01:44] [INFO] Timeout: 300 segundos
[2026-07-18 06:01:44] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_t2lcdbra.prg
[2026-07-18 06:01:44] [INFO] Conteudo do wrapper:
[2026-07-18 06:01:44] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigprpdf', 'C:\4c\tasks\task319', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigprpdf', 'C:\4c\tasks\task319', 'OPERACIONAL'
QUIT

[2026-07-18 06:01:44] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_t2lcdbra.prg
[2026-07-18 06:01:44] [INFO] VFP output esperado em: C:\4c\tasks\task319\vfp_output.txt
[2026-07-18 06:01:44] [INFO] Executando Visual FoxPro 9...
[2026-07-18 06:01:44] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_t2lcdbra.prg
[2026-07-18 06:01:44] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_t2lcdbra.prg
[2026-07-18 06:01:44] [INFO] Timeout configurado: 300 segundos
[2026-07-18 06:02:10] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-18 06:02:10] [INFO] VFP9 finalizado em 26.517441 segundos
[2026-07-18 06:02:10] [INFO] Exit Code: 
[2026-07-18 06:02:10] [INFO] 
[2026-07-18 06:02:10] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-18 06:02:10] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_t2lcdbra.prg
[2026-07-18 06:02:10] [INFO] 
[2026-07-18 06:02:10] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-18 06:02:10] [INFO] * Auto-generated wrapper for parameters
[2026-07-18 06:02:10] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-18 06:02:10] [INFO] * Parameters: 'Formsigprpdf', 'C:\4c\tasks\task319', 'OPERACIONAL'
[2026-07-18 06:02:10] [INFO] 
[2026-07-18 06:02:10] [INFO] * Anti-dialog protections for unattended execution
[2026-07-18 06:02:10] [INFO] SET SAFETY OFF
[2026-07-18 06:02:10] [INFO] SET RESOURCE OFF
[2026-07-18 06:02:10] [INFO] SET TALK OFF
[2026-07-18 06:02:10] [INFO] SET NOTIFY OFF
[2026-07-18 06:02:10] [INFO] SYS(2335, 0)
[2026-07-18 06:02:10] [INFO] 
[2026-07-18 06:02:10] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigprpdf', 'C:\4c\tasks\task319', 'OPERACIONAL'
[2026-07-18 06:02:10] [INFO] QUIT
[2026-07-18 06:02:10] [INFO] 
[2026-07-18 06:02:10] [INFO] === Fim do Wrapper.prg ===
[2026-07-18 06:02:10] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formsigprpdf",
  "timestamp": "20260718060210",
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
      "passou": true,
      "erro": "",
      "detalhes": "CarregarLista() executado | (sem registros - tabela pode estar vazia)"
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
      "passou": false,
      "erro": "Nenhum metodo de encerramento encontrado (BtnEncerrarClick/BtnFecharClick/BtnSairClick)",
      "detalhes": ""
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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprpdf.prg):
*==============================================================================
* Formsigprpdf.prg - Dialogo: Geracao de PDF e E-mail
* Equivalente ao SIGPRPDF.SCX do legado
* Tipo: OPERACIONAL (dialogo modal auxiliar - chamado por forms de impressao)
* Uso: loForm = CREATEOBJECT("Formsigprpdf", oFormPai, cAssunto)
*      loForm.Show()
* Resultado: oFormPai.pcArqEmail = caminho do arquivo gerado
*            oFormPai.oEmail     = objeto CUSTOM com dados do email (se email selecionado)
*==============================================================================
DEFINE CLASS Formsigprpdf AS FormBase

    *-- Referencia ao form pai (passada via Init)
    this_oParentForm = .NULL.

    *-- Assunto inicial do email (passado via Init)
    this_cAssunto = ""

    *-- Diretorio fiscal para salvar arquivos (de go_4c_Sistema.DirFiscais)
    this_cDiretorio = ""

    *-- Altura base do form sem a secao de email expandida
    this_nAlturaBase = 175

    *-- Propriedades visuais (PILAR 1: identico ao legado SIGPRPDF.SCX)
    Width       = 800
    Height      = 360
    AutoCenter  = .T.
    BorderStyle = 2
    ShowWindow = 1
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    WindowType  = 1
    Caption     = "Geracao de PDF e E-mail"

    *--------------------------------------------------------------------------
    * Init - Recebe referencia ao form pai e assunto do email
    * Parametros armazenados ANTES de DODEFAULT (que chama InicializarForm)
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oParentForm, par_cAssunto)
        THIS.this_oParentForm = par_oParentForm
        THIS.this_cAssunto    = IIF(TYPE("par_cAssunto") = "C", par_cAssunto, "")
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Conecta datasession, cria todos os controles
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            *-- Compartilhar datasession com form pai (exige acesso aos cursores dele)
            IF VARTYPE(THIS.this_oParentForm) = "O"
                SET DATASESSION TO THIS.this_oParentForm.DataSessionId
            ENDIF

            *-- Instanciar BO
            THIS.this_oBusinessObject = CREATEOBJECT("sigprpdfBO")
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Diretorio fiscal
                IF TYPE("go_4c_Sistema") = "O" AND PEMSTATUS(go_4c_Sistema, "DirFiscais", 5)
                    THIS.this_cDiretorio = ALLTRIM(NVL(go_4c_Sistema.DirFiscais, ""))
                ENDIF
                THIS.this_oBusinessObject.this_cDiretorio = THIS.this_cDiretorio

                *-- Aparencia base do form
                THIS.ConfigurarPageFrame()

                *-- Criar controles do form
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarOpcaoArquivo()
                THIS.ConfigurarAreaArquivo()
                THIS.ConfigurarBotoesAcao()
                THIS.ConfigurarSecaoEmail()

                *-- Carregar dados de email da empresa via BO
                THIS.this_oBusinessObject.CarregarEmailEmpresa()

                *-- Preencher valores iniciais nos controles
                THIS.InicializarValores()

                *-- Tornar controles visiveis (email section permanece oculta)
                THIS.TornarControlesVisiveis(THIS)

                *-- Bindar eventos dos botoes e controles
                BINDEVENT(THIS.cmd_4c_CmdGetFile,    "Click", THIS, "CmdGetFileClick")
                BINDEVENT(THIS.chk_4c_Chk_EMAIL,     "Click", THIS, "ChkEmailClick")
                BINDEVENT(THIS.obj_4c_OptArquivo,    "Click", THIS, "OptArquivoClick")
                BINDEVENT(THIS.cmd_4c_Cmd_GerarPDF,  "Click", THIS, "CmdGerarPDFClick")
                BINDEVENT(THIS.cmd_4c_Cmd_SAIR,      "Click", THIS, "CmdSairClick")
                BINDEVENT(THIS.cmd_4c_BtnPastasA,    "Click", THIS, "BtnPastasAClick")

                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao criar sigprpdfBO.", "Erro")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "Erro ao inicializar")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Aparencia base do form (sem PageFrame - dialogo plano)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.FontName   = "Tahoma"
        THIS.FontSize   = 8
        THIS.ShowTips   = .T.
        THIS.Caption    = "Gera" + CHR(231) + CHR(227) + "o de PDF e E-mail"

        IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro com titulo do dialogo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab, loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Sombra", "Container")
            WITH THIS.cnt_4c_Sombra
                .Top        = 0
                .Left       = 0
                .Width      = 1100
                .Height     = 80
                .BorderWidth = 0
                .BackStyle  = 1
                .BackColor  = RGB(100, 100, 100)
                .Visible    = .T.
            ENDWITH

            loc_oCab = THIS.cnt_4c_Sombra

            loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
            WITH loc_oCab.lbl_4c_LblSombra
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
                .Caption   = THIS.Caption
                .Visible   = .T.
            ENDWITH

            loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
            WITH loc_oCab.lbl_4c_LblTitulo
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
                .Caption   = THIS.Caption
                .Visible   = .T.
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarOpcaoArquivo - OptionGroup PDF / Excel
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarOpcaoArquivo()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("obj_4c_OptArquivo", "OptionGroup")
            WITH THIS.obj_4c_OptArquivo
                .Top         = -2
                .Left        = 420
                .Width       = 161
                .Height      = 85
                .TabIndex    = 1
                .Themes      = .T.
                .ButtonCount = 2
                .Value       = 1
                .Visible     = .T.

                WITH .Buttons(1)
                    .Caption    = "PDF"
                    .Height     = 75
                    .Left       = 5
                    .Top        = 5
                    .Width      = 75
                    .Style      = 1
                    .FontBold   = .T.
                    .FontItalic = .T.
                    .ForeColor  = RGB(90, 90, 90)
                    .BackColor  = RGB(255, 255, 255)
                    .BackStyle  = 0
                    .Picture    = gc_4c_CaminhoIcones + "pdf_60.png"
                ENDWITH

                WITH .Buttons(2)
                    .Caption    = "Excel"
                    .Height     = 75
                    .Left       = 81
                    .Top        = 5
                    .Width      = 75
                    .Style      = 1
                    .FontBold   = .T.
                    .FontItalic = .T.
                    .FontName   = "Tahoma"
                    .FontSize   = 8
                    .ForeColor  = RGB(90, 90, 90)
                    .BackColor  = RGB(255, 255, 255)
                    .BackStyle  = 0
                    .Picture    = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
                ENDWITH
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ConfigurarOpcaoArquivo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarAreaArquivo - Label "Salvar em:", TextBox nome arquivo e botoes
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarAreaArquivo()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("lbl_4c_Lbl_SalvarEm", "Label")
            WITH THIS.lbl_4c_Lbl_SalvarEm
                .Top       = 109
                .Left      = 150
                .Width     = 53
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Salvar em:"
                .TabIndex  = 4
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_TxtNomeArqSaida", "TextBox")
            WITH THIS.txt_4c_TxtNomeArqSaida
                .Top               = 105
                .Left              = 205
                .Width             = 383
                .Height            = 23
                .FontName          = "Tahoma"
                .FontSize          = 8
                .ReadOnly          = .T.
                .SpecialEffect     = 1
                .BorderColor       = RGB(100, 100, 100)
                .DisabledBackColor = RGB(255, 255, 255)
                .Value             = ""
                .TabIndex          = 5
                .Visible           = .T.
            ENDWITH

            THIS.AddObject("cmd_4c_CmdGetFile", "CommandButton")
            WITH THIS.cmd_4c_CmdGetFile
                .Top        = 104
                .Left       = 589
                .Width      = 30
                .Height     = 25
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Tahoma"
                .FontSize   = 8
                .Caption    = ". . ."
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
                .TabIndex   = 6
                .Visible    = .T.
            ENDWITH

            THIS.AddObject("cmd_4c_BtnPastasA", "CommandButton")
            WITH THIS.cmd_4c_BtnPastasA
                .Top             = 100
                .Left            = 619
                .Width           = 40
                .Height          = 32
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Tahoma"
                .FontSize        = 8
                .Caption         = ""
                .Picture         = gc_4c_CaminhoIcones + "geral_pasta_26.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "geral_pasta_26.jpg"
                .PicturePosition = 13
                .ForeColor       = RGB(90, 90, 90)
                .Themes          = .T.
                .ToolTipText     = "Abrir o Diret" + CHR(243) + "rio / Pasta de Arquivos"
                .TabIndex        = 82
                .Visible         = .T.
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ConfigurarAreaArquivo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesAcao - Checkbox Email, botao Gravar/Enviar e Encerrar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("chk_4c_Chk_EMAIL", "CheckBox")
            WITH THIS.chk_4c_Chk_EMAIL
                .Top        = 3
                .Left       = 575
                .Width      = 75
                .Height     = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Tahoma"
                .FontSize   = 8
                .Caption    = "Email"
                .Style      = 1
                .Value      = 0
                .Alignment  = 0
                .Picture    = gc_4c_CaminhoIcones + "geral_enderecos_60.jpg"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
                .TabIndex   = 2
                .Visible    = .T.
            ENDWITH

            THIS.AddObject("cmd_4c_Cmd_GerarPDF", "CommandButton")
            WITH THIS.cmd_4c_Cmd_GerarPDF
                .Top             = 3
                .Left            = 650
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Tahoma"
                .FontSize        = 8
                .Caption         = "   Gravar"
                .Picture         = gc_4c_CaminhoIcones + "geral_disco2_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "geral_disco2_60.jpg"
                .PicturePosition = 13
                .Alignment       = 6
                .WordWrap        = .F.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .T.
                .TabIndex        = 3
                .Visible         = .T.
            ENDWITH

            THIS.AddObject("cmd_4c_Cmd_SAIR", "CommandButton")
            WITH THIS.cmd_4c_Cmd_SAIR
                .Top             = 3
                .Left            = 725
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Tahoma"
                .FontSize        = 8
                .Caption         = "Encerrar"
                .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
                .Cancel          = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .T.
                .TabIndex        = 8
                .ToolTipText     = "[ESC] - Sair"
                .Visible         = .T.
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ConfigurarBotoesAcao")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarSecaoEmail - Container expandivel com campos de email (inicial: oculto)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarSecaoEmail()
        LOCAL loc_oCtn, loc_oErro

        TRY
            THIS.AddObject("cnt_4c_CtnSaida_Email", "Container")
            WITH THIS.cnt_4c_CtnSaida_Email
                .Top        = 148
                .Left       = 155
                .Width      = 480
                .Height     = 185
                .BackStyle  = 0
                .BorderWidth = 0
                .TabIndex   = 7
                .Visible    = .F.
            ENDWITH

            loc_oCtn = THIS.cnt_4c_CtnSaida_Email

            loc_oCtn.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oCtn.lbl_4c_Label1
                .Top       = 8
                .Left      = 47
                .Width     = 19
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "De:"
                .TabIndex  = 1
                .Visible   = .T.
            ENDWITH

            loc_oCtn.AddObject("txt_4c_TxtEmail_EnviarDE", "TextBox")
            WITH loc_oCtn.txt_4c_TxtEmail_EnviarDE
                .Top               = 5
                .Left              = 68
                .Width             = 404
                .Height            = 23
                .FontName          = "Tahoma"
                .FontSize          = 8
                .ReadOnly          = .T.
                .SpecialEffect     = 1
                .BorderColor       = RGB(100, 100, 100)
                .DisabledBackColor = RGB(239, 239, 239)
                .Value             = ""
                .TabIndex          = 2
                .ToolTipText       = "Menu - Cadastro - Empresas ( Campo Email )"
                .Visible           = .T.
            ENDWITH

            loc_oCtn.AddObject("lbl_4c_Lbl_EmailPara", "Label")
            WITH loc_oCtn.lbl_4c_Lbl_EmailPara
                .Top       = 38
                .Left      = 38
                .Width     = 28
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Para:"
                .TabIndex  = 3
                .Visible   = .T.
            ENDWITH

            loc_oCtn.AddObject("obj_4c_TxtEmail_EnviarPara", "EditBox")
            WITH loc_oCtn.obj_4c_TxtEmail_EnviarPara
                .Top           = 35
                .Left          = 68
                .Width         = 404
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ScrollBars    = 0
                .SpecialEffect = 1
                .BorderColor   = RGB(100, 100, 100)
                .Value         = ""
                .TabIndex      = 4
                .Visible       = .T.
            ENDWITH

            loc_oCtn.AddObject("lbl_4c_LblEmail_CC", "Label")
            WITH loc_oCtn.lbl_4c_LblEmail_CC
                .Top       = 68
                .Left      = 46
                .Width     = 20
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "CC:"
                .TabIndex  = 5
                .Visible   = .T.
            ENDWITH

            loc_oCtn.AddObject("obj_4c_TxtEmail_CC", "EditBox")
            WITH loc_oCtn.obj_4c_TxtEmail_CC
                .Top           = 65
                .Left          = 68
                .Width         = 404
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ScrollBars    = 0
                .SpecialEffect = 1
                .BorderColor   = RGB(100, 100, 100)
                .Value         = ""
                .TabIndex      = 6
                .Visible       = .T.
            ENDWITH

            loc_oCtn.AddObject("lbl_4c_LblEmail_Assunto", "Label")
            WITH loc_oCtn.lbl_4c_LblEmail_Assunto
                .Top       = 99
                .Left      = 21
                .Width     = 45
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Assunto:"
                .TabIndex  = 7
                .Visible   = .T.
            ENDWITH

            loc_oCtn.AddObject("txt_4c_TxtEmail_Assunto", "TextBox")
            WITH loc_oCtn.txt_4c_TxtEmail_Assunto
                .Top           = 95
                .Left          = 68
                .Width         = 404
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .BorderColor   = RGB(100, 100, 100)
                .Value         = ""
                .TabIndex      = 8
                .Visible       = .T.
            ENDWITH

            loc_oCtn.AddObject("lbl_4c_LblEmail_Corpo", "Label")
            WITH loc_oCtn.lbl_4c_LblEmail_Corpo
                .Top       = 127
                .Left      = 32
                .Width     = 34
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Texto:"
                .TabIndex  = 9
                .Visible   = .T.
            ENDWITH

            loc_oCtn.AddObject("obj_4c_EdtEmail_Corpo", "EditBox")
            WITH loc_oCtn.obj_4c_EdtEmail_Corpo
                .Top           = 125
                .Left          = 68
                .Width         = 404
                .Height        = 53
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .BorderColor   = RGB(100, 100, 100)
                .Value         = ""
                .TabIndex      = 10
                .Visible       = .T.
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ConfigurarSecaoEmail")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarValores - Define valores iniciais apos criacao dos controles
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarValores()
        LOCAL loc_lPdfDisponivel, loc_cExt, loc_oErro

        TRY
            *-- Verificar disponibilidade do PDFCreator via registry
            loc_lPdfDisponivel = .F.
            TRY
                loc_lPdfDisponivel = !ISNULL(REGREAD("HKEY_CLASSES_ROOT\PDFCreator.clsPDFCreator\")) OR ;
                                     !ISNULL(REGREAD("HKEY_CLASSES_ROOT\PDFCreatorBeta.JobQueue\"))
            CATCH
                loc_lPdfDisponivel = .F.
            ENDTRY

            THIS.obj_4c_OptArquivo.Buttons(1).Enabled = loc_lPdfDisponivel
            THIS.obj_4c_OptArquivo.Value = IIF(loc_lPdfDisponivel, 1, 2)

            *-- Nome do arquivo inicial conforme tipo selecionado (igual ao OptArquivoClick)
            IF THIS.obj_4c_OptArquivo.Value = 1
                THIS.txt_4c_TxtNomeArqSaida.Value = THIS.this_cDiretorio + "FORTYUSPDF.PDF"
            ELSE
                THIS.txt_4c_TxtNomeArqSaida.Value = THIS.this_cDiretorio + "FORTYUSEXCEL.XLS"
            ENDIF

            *-- Preencher "Para:" com contaemail do form pai (se disponivel)
            IF VARTYPE(THIS.this_oParentForm) = "O"
                IF PEMSTATUS(THIS.this_oParentForm, "Contaemail", 5)
                    THIS.cnt_4c_CtnSaida_Email.obj_4c_TxtEmail_EnviarPara.Value = ;
                        ALLTRIM(NVL(THIS.this_oParentForm.Contaemail, ""))
                ENDIF
            ENDIF

            *-- Assunto inicial
            THIS.cnt_4c_CtnSaida_Email.txt_4c_TxtEmail_Assunto.Value = THIS.this_cAssunto

            *-- Email De (da empresa, carregado pelo BO)
            THIS.cnt_4c_CtnSaida_Email.txt_4c_TxtEmail_EnviarDE.Value = ;
                THIS.this_oBusinessObject.this_cEmailEmpresaDe

            *-- Calcular altura base e recolher secao de email
            THIS.this_nAlturaBase = THIS.Height - THIS.cnt_4c_CtnSaida_Email.Height
            THIS.Height = THIS.this_nAlturaBase
            THIS.cnt_4c_CtnSaida_Email.Visible = .F.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro InicializarValores")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna visiveis todos os controles exceto secao email
    * cnt_4c_CtnSaida_Email inicia oculto; seus filhos ficam visiveis internamente
    *--------------------------------------------------------------------------
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oCtrl

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oCtrl = par_oContainer.Controls(loc_i)

            IF VARTYPE(loc_oCtrl) = "O"
                IF INLIST(UPPER(loc_oCtrl.Name), "CNT_4C_CTNSAIDA_EMAIL", "CNT_4C_SOMBRA")
                    *-- Containers intencionalmente ocultos: recursao nos filhos sem forcar Visible=.T.
                    IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oCtrl)
                    ENDIF
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oCtrl, "Visible", 5)
                    loc_oCtrl.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oCtrl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdGetFileClick - Abre dialogo de selecao de arquivo PDF ou XLS
    *--------------------------------------------------------------------------
    PROCEDURE CmdGetFileClick()
        LOCAL loc_cTpArq, loc_cArqSaida, loc_oErro

        TRY
            loc_cTpArq    = IIF(THIS.obj_4c_OptArquivo.Value = 1, "PDF", "XLS")
            loc_cArqSaida = GETFILE(loc_cTpArq, "Arquivo:", "Selecionar", 0, "Selecione o arquivo")

            IF !EMPTY(loc_cArqSaida)
                loc_cArqSaida = THIS.this_oBusinessObject.ResolverExtensao(loc_cArqSaida, THIS.obj_4c_OptArquivo.Value)
                THIS.txt_4c_TxtNomeArqSaida.Value = ALLTRIM(loc_cArqSaida)
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkEmailClick - Expande/contrai form mostrando/ocultando secao de email
    *--------------------------------------------------------------------------
    PROCEDURE ChkEmailClick()
        LOCAL loc_oErro

        TRY
            THIS.LockScreen = .T.

            IF THIS.chk_4c_Chk_EMAIL.Value = 1
                THIS.cmd_4c_Cmd_GerarPDF.Caption = "Enviar Email"
                THIS.Height = THIS.this_nAlturaBase + THIS.cnt_4c_CtnSaida_Email.Height
                THIS.cnt_4c_CtnSaida_Email.Visible = .T.
            ELSE
                THIS.cmd_4c_Cmd_GerarPDF.Caption = "\<Gravar"
                THIS.Height = THIS.this_nAlturaBase
                THIS.cnt_4c_CtnSaida_Email.Visible = .F.
            ENDIF

            THIS.Refresh()
            THIS.LockScreen = .F.

        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * OptArquivoClick - Atualiza nome do arquivo conforme tipo PDF/XLS selecionado
    *--------------------------------------------------------------------------
    PROCEDURE OptArquivoClick()
        LOCAL loc_oErro

        TRY
            IF THIS.obj_4c_OptArquivo.Value = 1
                THIS.txt_4c_TxtNomeArqSaida.Value = THIS.this_cDiretorio + "FORTYUSPDF.PDF"
            ELSE
                THIS.txt_4c_TxtNomeArqSaida.Value = THIS.this_cDiretorio + "FORTYUSEXCEL.XLS"
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdGerarPDFClick - Acao principal: gravar arquivo ou preparar envio de email
    *--------------------------------------------------------------------------
    PROCEDURE CmdGerarPDFClick()
        LOCAL loc_cArquivo, loc_oEmail, loc_lEnviarEmail, loc_lResultado, loc_lContinuar, loc_oErro

        loc_lContinuar = .T.

        TRY
            loc_cArquivo = ALLTRIM(NVL(THIS.txt_4c_TxtNomeArqSaida.Value, ""))

            IF EMPTY(loc_cArquivo)
                MsgAviso("Selecione um nome para o arquivo!", "Aten" + CHR(231) + CHR(227) + "o")
                THIS.cmd_4c_CmdGetFile.SetFocus()
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                loc_lEnviarEmail = (THIS.chk_4c_Chk_EMAIL.Value = 1)

                IF loc_lEnviarEmail
                    *-- Modo email: coletar dados do form para o BO validar
                    THIS.this_oBusinessObject.this_cArquivoSaida = loc_cArquivo
                    THIS.this_oBusinessObject.this_nTipoArquivo  = THIS.obj_4c_OptArquivo.Value
                    THIS.this_oBusinessObject.this_cEmailPara    = ALLTRIM(NVL(THIS.cnt_4c_CtnSaida_Email.obj_4c_TxtEmail_EnviarPara.Value, ""))
                    THIS.this_oBusinessObject.this_cEmailCC      = ALLTRIM(NVL(THIS.cnt_4c_CtnSaida_Email.obj_4c_TxtEmail_CC.Value,         ""))
                    THIS.this_oBusinessObject.this_cEmailAssunto = ALLTRIM(NVL(THIS.cnt_4c_CtnSaida_Email.txt_4c_TxtEmail_Assunto.Value,    ""))
                    THIS.this_oBusinessObject.this_cEmailCorpo   = ALLTRIM(NVL(THIS.cnt_4c_CtnSaida_Email.obj_4c_EdtEmail_Corpo.Value,      ""))

                    loc_lResultado = THIS.this_oBusinessObject.Atualizar()

                    IF loc_lResultado
                        *-- Dados de email da empresa precisam estar carregados (cursor_4c_EmailEmp)
                        IF USED("cursor_4c_EmailEmp") AND RECCOUNT("cursor_4c_EmailEmp") > 0
                            loc_oEmail = THIS.this_oBusinessObject.MontarObjetoEmail( ;
                                THIS.this_oBusinessObject.this_cArquivoSaida)

                            IF VARTYPE(THIS.this_oParentForm) = "O" AND VARTYPE(loc_oEmail) = "O"
                                THIS.this_oParentForm.pcArqEmail = THIS.this_oBusinessObject.this_cArquivoSaida
                                THIS.this_oParentForm.oEmail     = loc_oEmail
                            ENDIF
                        ELSE
                            IF VARTYPE(THIS.this_oParentForm) = "O"
                                THIS.this_oParentForm.lPrintPDFCreator = .F.
                            ENDIF
                            MsgAviso("Problemas na sele" + CHR(231) + CHR(227) + "o de dados do email. " + ;
                                     "Favor enviar novamente.", "Aten" + CHR(231) + CHR(227) + "o")
                        ENDIF

                        THIS.Release()
                    ENDIF
                ELSE
                    *-- Modo gravar: apenas definir arquivo no form pai
                    THIS.this_oBusinessObject.this_cArquivoSaida = loc_cArquivo
                    THIS.this_oBusinessObject.this_nTipoArquivo  = THIS.obj_4c_OptArquivo.Value

                    loc_lResultado = THIS.this_oBusinessObject.Inserir()

                    IF loc_lResultado
                        IF VARTYPE(THIS.this_oParentForm) = "O"
                            THIS.this_oParentForm.pcArqEmail = THIS.this_oBusinessObject.this_cArquivoSaida
                        ENDIF
                        THIS.Release()
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao gravar/enviar")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdSairClick - Cancela: limpa pcArqEmail e oEmail no form pai e fecha
    *--------------------------------------------------------------------------
    PROCEDURE CmdSairClick()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oParentForm) = "O"
                THIS.this_oParentForm.pcArqEmail = ""
                THIS.this_oParentForm.oEmail     = .NULL.
            ENDIF
            THIS.Release()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnPastasAClick - Abre diretorio fiscal no Windows Explorer
    *--------------------------------------------------------------------------
    PROCEDURE BtnPastasAClick()
        LOCAL loc_oErro

        TRY
            THIS.this_oBusinessObject.AbrirPasta(THIS.this_cDiretorio)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - N/A (dialogo plano sem PageFrame/Grid)
    * Formsigprpdf eh um dialogo modal de 1 tela - sem Page1/Grid de lista.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - N/A (dialogo plano sem Page2)
    * Todos os controles sao criados diretamente em InicializarForm.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - N/A (dialogo plano sem paginas para alternar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - N/A para dialogo OPERACIONAL de PDF/Email
    * Este form nao eh um cadastro CRUD (SIGPRPDF.SCX legado nao tem esse botao).
    * A acao equivalente de "gravar arquivo novo" eh feita por CmdGerarPDFClick,
    * que chama this_oBusinessObject.Inserir para persistir os dados de saida.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.CmdGerarPDFClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - N/A para dialogo OPERACIONAL de PDF/Email
    * SIGPRPDF.SCX legado nao possui operacao de alteracao (dialogo one-shot).
    * A acao equivalente de "reenviar/regravar" eh feita por CmdGerarPDFClick,
    * que decide entre Inserir (gravar) e Atualizar (enviar email).
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        THIS.CmdGerarPDFClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - N/A para dialogo OPERACIONAL de PDF/Email
    * SIGPRPDF.SCX legado nao possui operacao de visualizacao (nao ha registros
    * persistidos). A acao equivalente de "ver a pasta destino" eh BtnPastasAClick,
    * que abre o diretorio fiscal onde os PDFs/XLS sao salvos.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        THIS.BtnPastasAClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - N/A para dialogo OPERACIONAL de PDF/Email
    * SIGPRPDF.SCX legado nao possui operacao de exclusao (dialogo modal one-shot).
    * A acao equivalente de "cancelar/descartar" eh CmdSairClick, que limpa
    * pcArqEmail/oEmail no form pai e fecha o dialogo sem gravar.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        THIS.CmdSairClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Delega para a acao principal do dialogo (Gravar/Enviar).
    * SIGPRPDF.SCX legado usa Cmd_GerarPDF (nao ha botao "Salvar" separado).
    * Mantido para compatibilidade com a interface CRUD do pipeline.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.CmdGerarPDFClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Delega para o cancelamento do dialogo (Cmd_SAIR).
    * SIGPRPDF.SCX legado nao tem botao "Cancelar" separado; sair equivale a
    * cancelar (limpa pcArqEmail/oEmail do form pai).
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.CmdSairClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Copia valores dos controles do form para as propriedades do BO.
    * Chamado antes de invocar Inserir/Atualizar no BO (via CmdGerarPDFClick).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oCtn, loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                RETURN
            ENDIF

            THIS.this_oBusinessObject.this_cDiretorio    = THIS.this_cDiretorio
            THIS.this_oBusinessObject.this_cArquivoSaida = ALLTRIM(NVL(THIS.txt_4c_TxtNomeArqSaida.Value, ""))
            THIS.this_oBusinessObject.this_nTipoArquivo  = THIS.obj_4c_OptArquivo.Value
            THIS.this_oBusinessObject.this_lEnviarEmail  = (THIS.chk_4c_Chk_EMAIL.Value = 1)

            loc_oCtn = THIS.cnt_4c_CtnSaida_Email
            THIS.this_oBusinessObject.this_cEmailEmpresaDe = ALLTRIM(NVL(loc_oCtn.txt_4c_TxtEmail_EnviarDE.Value, ""))
            THIS.this_oBusinessObject.this_cEmailPara      = ALLTRIM(NVL(loc_oCtn.obj_4c_TxtEmail_EnviarPara.Value, ""))
            THIS.this_oBusinessObject.this_cEmailCC        = ALLTRIM(NVL(loc_oCtn.obj_4c_TxtEmail_CC.Value, ""))
            THIS.this_oBusinessObject.this_cEmailAssunto   = ALLTRIM(NVL(loc_oCtn.txt_4c_TxtEmail_Assunto.Value, ""))
            THIS.this_oBusinessObject.this_cEmailCorpo     = ALLTRIM(NVL(loc_oCtn.obj_4c_EdtEmail_Corpo.Value, ""))

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro FormParaBO")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Copia propriedades do BO para os controles do form.
    * Chamado apos CarregarEmailEmpresa para propagar dados da empresa.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oCtn, loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                RETURN
            ENDIF

            THIS.this_cDiretorio = THIS.this_oBusinessObject.this_cDiretorio

            IF THIS.obj_4c_OptArquivo.Value = 1
                THIS.txt_4c_TxtNomeArqSaida.Value = THIS.this_cDiretorio + "FORTYUSPDF.PDF"
            ELSE
                THIS.txt_4c_TxtNomeArqSaida.Value = THIS.this_cDiretorio + "FORTYUSEXCEL.XLS"
            ENDIF

            loc_oCtn = THIS.cnt_4c_CtnSaida_Email
            loc_oCtn.txt_4c_TxtEmail_EnviarDE.Value = THIS.this_oBusinessObject.this_cEmailEmpresaDe
            loc_oCtn.txt_4c_TxtEmail_Assunto.Value  = THIS.this_cAssunto

            IF VARTYPE(THIS.this_oParentForm) = "O" AND PEMSTATUS(THIS.this_oParentForm, "Contaemail", 5)
                loc_oCtn.obj_4c_TxtEmail_EnviarPara.Value = ALLTRIM(NVL(THIS.this_oParentForm.Contaemail, ""))
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - N/A para dialogo OPERACIONAL de PDF/Email (sem grid).
    * SIGPRPDF.SCX legado eh um dialogo modal one-shot sem lista de registros.
    * A acao equivalente de "carregar dados iniciais" eh CarregarEmailEmpresa
    * no BO, que popula as configuracoes de email da empresa em SigCdEmp.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.CarregarEmailEmpresa()
            THIS.BOParaForm()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Ajusta enabled dos controles conforme o modo do dialogo.
    * par_lHabilitar: .T. habilita edicao, .F. bloqueia (durante processamento).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lEnabled, loc_oCtn

        loc_lEnabled = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)

        THIS.obj_4c_OptArquivo.Enabled     = loc_lEnabled
        THIS.cmd_4c_CmdGetFile.Enabled     = loc_lEnabled
        THIS.chk_4c_Chk_EMAIL.Enabled      = loc_lEnabled
        THIS.cmd_4c_Cmd_GerarPDF.Enabled   = loc_lEnabled
        THIS.cmd_4c_BtnPastasA.Enabled     = loc_lEnabled

        loc_oCtn = THIS.cnt_4c_CtnSaida_Email
        loc_oCtn.obj_4c_TxtEmail_EnviarPara.Enabled = loc_lEnabled
        loc_oCtn.obj_4c_TxtEmail_CC.Enabled         = loc_lEnabled
        loc_oCtn.txt_4c_TxtEmail_Assunto.Enabled    = loc_lEnabled
        loc_oCtn.obj_4c_EdtEmail_Corpo.Enabled      = loc_lEnabled
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Reseta valores dos controles editaveis do form.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oCtn

        THIS.txt_4c_TxtNomeArqSaida.Value = THIS.this_cDiretorio + "FORTYUSPDF.PDF"
        THIS.obj_4c_OptArquivo.Value      = 1
        THIS.chk_4c_Chk_EMAIL.Value       = 0

        loc_oCtn = THIS.cnt_4c_CtnSaida_Email
        loc_oCtn.obj_4c_TxtEmail_EnviarPara.Value = ""
        loc_oCtn.obj_4c_TxtEmail_CC.Value         = ""
        loc_oCtn.txt_4c_TxtEmail_Assunto.Value    = THIS.this_cAssunto
        loc_oCtn.obj_4c_EdtEmail_Corpo.Value      = ""
        loc_oCtn.Visible = .F.
        THIS.Height = THIS.this_nAlturaBase
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - N/A: dialogo OPERACIONAL nao tem modos CRUD.
    * SIGPRPDF opera em modo unico (dialogo modal de gravar/enviar).
    * Mantido para compatibilidade com a interface do pipeline.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera BINDEVENTS e BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_oErro

        TRY
            UNBINDEVENTS(THIS)
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro Destroy")
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigprpdfBO.prg):
*==============================================================================
* sigprpdfBO.prg - Business Object: Gera????o de PDF/XLS e E-mail
* Herda de: BusinessBase
* Tipo: OPERACIONAL (auxiliar modal - sem CRUD)
* Tabela: SigCdEmp (somente leitura para config. de email)
*==============================================================================
DEFINE CLASS sigprpdfBO AS BusinessBase

    *-- Configuracao da entidade (sem tabela de CRUD)
    this_cTabela     = ""
    this_cCampoChave = ""

    *-- Diretorio e arquivo de saida
    this_cDiretorio     = ""
    this_cArquivoSaida  = ""
    this_nTipoArquivo   = 1

    *-- Disponibilidade do PDFCreator (verificado via registry)
    this_lPdfDisponivel = .F.

    *-- Dados de email da empresa (vindos de SigCdEmp)
    this_cEmailEmpresaDe = ""
    this_cSmtpServidor   = ""
    this_cSmtpSenha      = ""
    this_cSmtpPasta      = ""
    this_nSmtpPorta      = 0

    *-- Dados do email a enviar
    this_lEnviarEmail   = .F.
    this_cEmailPara     = ""
    this_cEmailCC       = ""
    this_cEmailAssunto  = ""
    this_cEmailCorpo    = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        this_cTabela     = ""
        this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarEmailEmpresa()
    *-- Busca configuracoes de email da empresa em SigCdEmp
    *--------------------------------------------------------------------------
        LOCAL loc_cSQL, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT PadEmails, PadServs, PadSenhas, pastas, PadPortas " + ;
                       "FROM SigCdEmp " + ;
                       "WHERE CEmps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

            IF USED("cursor_4c_EmailEmp")
                USE IN cursor_4c_EmailEmp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmailEmp") < 1
                MsgErro("Falha ao carregar dados de email da empresa.", "Erro")
            ELSE
                IF RECCOUNT("cursor_4c_EmailEmp") > 0
                    SELECT cursor_4c_EmailEmp
                    THIS.this_cEmailEmpresaDe = LOWER(ALLTRIM(NVL(PadEmails, "")))
                    THIS.this_cSmtpServidor   = LOWER(ALLTRIM(NVL(PadServs,  "")))
                    THIS.this_cSmtpSenha      = ALLTRIM(NVL(PadSenhas, ""))
                    THIS.this_cSmtpPasta      = ALLTRIM(NVL(pastas,    ""))
                    THIS.this_nSmtpPorta      = NVL(PadPortas, 0)
                ENDIF
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ValidarParaSalvar()
    *-- Valida campos obrigatorios antes de gravar
    *--------------------------------------------------------------------------
        LOCAL loc_lOk

        loc_lOk = .T.

        IF EMPTY(THIS.this_cArquivoSaida)
            MsgAviso("Selecione um nome para o arquivo!", "Aten" + CHR(231) + CHR(227) + "o")
            loc_lOk = .F.
        ENDIF

        RETURN loc_lOk
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ValidarParaEmail()
    *-- Valida campos obrigatorios do email antes de enviar
    *--------------------------------------------------------------------------
        LOCAL loc_lOk

        loc_lOk = .T.

        IF EMPTY(THIS.this_cEmailEmpresaDe)
            MsgAviso("O campo 'DE:' n" + CHR(227) + "o foi preenchido.", "Aten" + CHR(231) + CHR(227) + "o")
            loc_lOk = .F.
        ENDIF

        IF loc_lOk AND EMPTY(THIS.this_cEmailPara)
            MsgAviso("O campo 'PARA:' n" + CHR(227) + "o foi preenchido.", "Aten" + CHR(231) + CHR(227) + "o")
            loc_lOk = .F.
        ENDIF

        RETURN loc_lOk
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE MontarObjetoEmail(par_cArquivoAnexo)
    *-- Monta e retorna objeto CUSTOM com dados do email para o form pai usar
    *-- par_cArquivoAnexo: caminho completo do arquivo a ser anexado
    *-- Retorna objeto CUSTOM ou .NULL. em caso de erro
    *--------------------------------------------------------------------------
        LOCAL loc_oEmail, loc_oErro

        loc_oEmail = .NULL.

        TRY
            IF !THIS.ValidarParaEmail()
                loc_lResultado = .NULL.
            ENDIF

            loc_oEmail = CREATEOBJECT("CUSTOM")

            loc_oEmail.AddProperty("cSmtpServer",    THIS.this_cSmtpServidor)
            loc_oEmail.AddProperty("nSmtpServerPort", THIS.this_nSmtpPorta)
            loc_oEmail.AddProperty("cSendUserName",  THIS.this_cEmailEmpresaDe)
            loc_oEmail.AddProperty("cSendPassWord",  THIS.this_cSmtpSenha)
            loc_oEmail.AddProperty("cFrom",          THIS.this_cEmailEmpresaDe)
            loc_oEmail.AddProperty("cTO",            THIS.this_cEmailPara)
            loc_oEmail.AddProperty("cCC",            THIS.this_cEmailCC)
            loc_oEmail.AddProperty("cAssunto",       THIS.this_cEmailAssunto)
            loc_oEmail.AddProperty("cCorpo",         THIS.this_cEmailCorpo)
            loc_oEmail.AddProperty("cAnexo",         par_cArquivoAnexo)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_oEmail = .NULL.
        ENDTRY

        RETURN loc_oEmail
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ResolverExtensao(par_cCaminho, par_nTipoArquivo)
    *-- Garante que o caminho tem a extensao correta (.pdf ou .xls)
    *-- par_cCaminho: caminho do arquivo (pode estar sem extensao)
    *-- par_nTipoArquivo: 1=PDF, 2=XLS
    *-- Retorna: caminho com extensao correta
    *--------------------------------------------------------------------------
        LOCAL loc_cExt, loc_cCaminho

        loc_cExt    = IIF(par_nTipoArquivo = 1, "PDF", "XLS")
        loc_cCaminho = ALLTRIM(par_cCaminho)

        IF !EMPTY(loc_cCaminho)
            IF !(UPPER(JUSTEXT(loc_cCaminho)) $ loc_cExt)
                loc_cCaminho = FORCEEXT(loc_cCaminho, LEFT(loc_cExt, 3))
            ENDIF
        ENDIF

        RETURN loc_cCaminho
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *-- Carrega config de email da empresa a partir do cursor (TmpEmpMail/cursor_4c_EmailEmp)
    *--------------------------------------------------------------------------
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cEmailEmpresaDe = LOWER(ALLTRIM(NVL(PadEmails, "")))
            THIS.this_cSmtpServidor   = LOWER(ALLTRIM(NVL(PadServs,  "")))
            THIS.this_cSmtpSenha      = ALLTRIM(NVL(PadSenhas, ""))
            THIS.this_cSmtpPasta      = ALLTRIM(NVL(pastas, ""))
            THIS.this_nSmtpPorta      = NVL(PadPortas, 0)
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
    *-- Form auxiliar sem tabela de CRUD - sem chave primaria
    *--------------------------------------------------------------------------
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
    *-- Compatibilidade BusinessBase.Salvar() - delega para ValidarParaSalvar
    *--------------------------------------------------------------------------
        RETURN THIS.ValidarParaSalvar()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE AbrirPasta(par_cDiretorio)
    *-- Abre o diretorio no Windows Explorer
    *--------------------------------------------------------------------------
        LOCAL loc_oApp, loc_oErro

        TRY
            IF !EMPTY(par_cDiretorio)
                IF !DIRECTORY(par_cDiretorio)
                    MsgAviso("Diret" + CHR(243) + "rio n" + CHR(227) + "o Localizado", "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    loc_oApp = CREATEOBJECT("Shell.Application")
                    loc_oApp.Open(par_cDiretorio)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
    *-- Modo GRAVAR: prepara arquivo de saida SEM envio de email.
    *-- Form OPERACIONAL auxiliar (sem tabela de CRUD): "Inserir" representa
    *-- a acao de gerar o arquivo de saida (PDF/XLS) pela primeira vez.
    *-- Valida os dados, resolve extensao do arquivo e marca envio de email
    *-- como .F. para que o form pai use apenas o caminho do arquivo.
    *-- Retorna: .T. sucesso, .F. falha (ver ObterMensagemErro em BusinessBase)
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_oErro

        loc_lResultado = .F.

        TRY
            IF !THIS.ValidarParaSalvar()
                loc_lResultado = .F.
            ELSE
                THIS.this_cArquivoSaida = THIS.ResolverExtensao( ;
                    THIS.this_cArquivoSaida, THIS.this_nTipoArquivo)

                THIS.this_lEnviarEmail = .F.
                THIS.this_cEmailPara    = ""
                THIS.this_cEmailCC      = ""
                THIS.this_cEmailAssunto = ""
                THIS.this_cEmailCorpo   = ""

                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao preparar arquivo")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
    *-- Modo ENVIAR EMAIL: prepara arquivo de saida COM anexo em email.
    *-- Form OPERACIONAL auxiliar (sem tabela de CRUD): "Atualizar" representa
    *-- a acao de re-gerar/atualizar o arquivo com envio por email anexado.
    *-- Valida arquivo E dados de email antes de sinalizar sucesso.
    *-- Retorna: .T. sucesso, .F. falha
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_oErro

        loc_lResultado = .F.

        TRY
            IF !THIS.ValidarParaSalvar()
                loc_lResultado = .F.
            ELSE
                THIS.this_cArquivoSaida = THIS.ResolverExtensao( ;
                    THIS.this_cArquivoSaida, THIS.this_nTipoArquivo)

                IF !THIS.ValidarParaEmail()
                    loc_lResultado = .F.
                ELSE
                    THIS.this_lEnviarEmail = .T.
                    loc_lResultado = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao preparar envio de email")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

