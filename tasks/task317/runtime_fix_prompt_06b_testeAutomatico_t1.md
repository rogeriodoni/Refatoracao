# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 0% < 100%. Falhas: Teste 'Instanciacao': Cannot load 32-bit DLL CliSiTef32I.DLL. | Detalhes: Linha: 120, Proc: carregardlls

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-18 03:52:01] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-18 03:52:01] [INFO] Config FPW: (nao fornecido)
[2026-07-18 03:52:01] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-18 03:52:01] [INFO] Timeout: 300 segundos
[2026-07-18 03:52:01] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_jd5lkjpi.prg
[2026-07-18 03:52:01] [INFO] Conteudo do wrapper:
[2026-07-18 03:52:01] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigproer', 'C:\4c\tasks\task317', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigproer', 'C:\4c\tasks\task317', 'OPERACIONAL'
QUIT

[2026-07-18 03:52:01] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_jd5lkjpi.prg
[2026-07-18 03:52:01] [INFO] VFP output esperado em: C:\4c\tasks\task317\vfp_output.txt
[2026-07-18 03:52:01] [INFO] Executando Visual FoxPro 9...
[2026-07-18 03:52:01] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_jd5lkjpi.prg
[2026-07-18 03:52:01] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_jd5lkjpi.prg
[2026-07-18 03:52:01] [INFO] Timeout configurado: 300 segundos
[2026-07-18 03:52:27] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-18 03:52:27] [INFO] VFP9 finalizado em 26.0694418 segundos
[2026-07-18 03:52:27] [INFO] Exit Code: 
[2026-07-18 03:52:27] [INFO] 
[2026-07-18 03:52:27] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-18 03:52:27] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_jd5lkjpi.prg
[2026-07-18 03:52:27] [INFO] 
[2026-07-18 03:52:27] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-18 03:52:27] [INFO] * Auto-generated wrapper for parameters
[2026-07-18 03:52:27] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-18 03:52:27] [INFO] * Parameters: 'Formsigproer', 'C:\4c\tasks\task317', 'OPERACIONAL'
[2026-07-18 03:52:27] [INFO] 
[2026-07-18 03:52:27] [INFO] * Anti-dialog protections for unattended execution
[2026-07-18 03:52:27] [INFO] SET SAFETY OFF
[2026-07-18 03:52:28] [INFO] SET RESOURCE OFF
[2026-07-18 03:52:28] [INFO] SET TALK OFF
[2026-07-18 03:52:28] [INFO] SET NOTIFY OFF
[2026-07-18 03:52:28] [INFO] SYS(2335, 0)
[2026-07-18 03:52:28] [INFO] 
[2026-07-18 03:52:28] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigproer', 'C:\4c\tasks\task317', 'OPERACIONAL'
[2026-07-18 03:52:28] [INFO] QUIT
[2026-07-18 03:52:28] [INFO] 
[2026-07-18 03:52:28] [INFO] === Fim do Wrapper.prg ===
[2026-07-18 03:52:28] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formsigproer",
  "timestamp": "20260718035227",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": false,
      "erro": "Cannot load 32-bit DLL CliSiTef32I.DLL.",
      "detalhes": "Linha: 120, Proc: carregardlls"
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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigproer.prg):
*==============================================================================
* Formsigproer.prg - Form Reimpressao SiTef
* Form original: SIGPROER.SCX
* Tipo: OPERACIONAL (dialogo especializado de terminal de pagamento SiTef)
* Herda de: FormBase
*==============================================================================

DEFINE CLASS Formsigproer AS FormBase

    *-- Propriedades visuais do dialogo compacto SiTef
    Width       = 400
    Height      = 200
    AutoCenter  = .T.
    Caption     = "Reimpressao do SiTef"
    ShowWindow = 1
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    WindowType  = 1
    BorderStyle = 2

    *-- Parametros recebidos na abertura (populados no Init antes do DODEFAULT)
    this_cEndSitef   = ""
    this_cCaixa      = ""
    this_cNSU        = ""
    this_cData       = ""
    this_cValor      = ""
    this_cHora       = ""
    this_cCodEstabs  = ""

    *-- Estado do protocolo SiTef (equivalem as PUBLIC vars do legado)
    this_nProximoComando  = 0
    this_nTipoCampo       = 0
    this_nTamanhoMinimo   = 0
    this_nTamanhoMaximo   = 0
    this_cBuffer          = ""
    this_nContinua        = 0
    this_lIdent           = .F.
    this_cNSULocal        = ""
    this_cDataLocal       = ""
    this_cMensagem        = ""

    *--------------------------------------------------------------------------
    * Init - Captura parametros e inicia o form
    * Equivale ao Init + Load do legado (Load declara DLLs, Init armazena params)
    * LPARAMETERS: EndSitef, pcCaixa, pcNSU, pcData, pcValor,
    *              pcdata (duplicata legado), pcHora, pcCodEstabs
    *--------------------------------------------------------------------------
    PROCEDURE Init
    LPARAMETERS par_cEndSitef, par_cCaixa, par_cNSU, par_cData, par_cValor, ;
                par_cData2, par_cHora, par_cCodEstabs

        THIS.CarregarDlls()

        THIS.this_cEndSitef  = IIF(VARTYPE(par_cEndSitef)  = "C", ALLTRIM(par_cEndSitef),  "")
        THIS.this_cCaixa     = IIF(VARTYPE(par_cCaixa)     = "C", ALLTRIM(par_cCaixa),     "")
        THIS.this_cNSU       = IIF(VARTYPE(par_cNSU)       = "C", ALLTRIM(par_cNSU),       "")
        THIS.this_cData      = IIF(VARTYPE(par_cData)      = "C", ALLTRIM(par_cData),      "")
        THIS.this_cValor     = IIF(VARTYPE(par_cValor)     = "C", ALLTRIM(par_cValor),     "")
        THIS.this_cHora      = IIF(VARTYPE(par_cHora)      = "C", ALLTRIM(par_cHora),      "")
        THIS.this_cCodEstabs = IIF(VARTYPE(par_cCodEstabs) = "C", ALLTRIM(par_cCodEstabs), "")

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria BO, conecta ao SiTef e monta layout
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigproerBO")
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                WITH THIS.this_oBusinessObject
                    .this_cEndSitef  = THIS.this_cEndSitef
                    .this_cCaixa     = THIS.this_cCaixa
                    .this_cNSU       = THIS.this_cNSU
                    .this_cData      = THIS.this_cData
                    .this_cValor     = THIS.this_cValor
                    .this_cHora      = THIS.this_cHora
                    .this_cCodEstabs = THIS.this_cCodEstabs
                ENDWITH

                *-- Inicializa vars do protocolo SiTef com params recebidos no Init
                THIS.this_cNSULocal  = THIS.this_cNSU
                THIS.this_cDataLocal = THIS.this_cData

                IF !EMPTY(THIS.this_cEndSitef)
                    IF THIS.this_oBusinessObject.CarregarDadosEmpresa()
                        IF THIS.this_oBusinessObject.IniciarProtocolo()
                            THIS.ConfigurarPageFrame()
                            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                            loc_lSucesso = .T.
                        ENDIF
                    ENDIF
                ELSE
                    MsgAviso("Endere" + CHR(231) + "o do servidor SiTef n" + CHR(227) + "o informado.", ;
                             "Valida" + CHR(231) + CHR(227) + "o")
                ENDIF
            ELSE
                MsgErro("Erro ao criar sigproerBO." + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDlls - Declara funcoes externas da DLL CliSiTef32I.DLL
    * Equivale ao PROCEDURE Load do legado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDlls()
        DECLARE INTEGER ConfiguraIntSiTefInterativo IN "CliSiTef32I.DLL" ;
            STRING lsEndereco, STRING lsLoja, STRING lsTerminal, INTEGER lnReservado
        DECLARE INTEGER IniciaFuncaoSiTefInterativo IN "CliSiTef32I.DLL" ;
            INTEGER lnModalidade, STRING lsValor, STRING lsCupom, STRING lsData, ;
            STRING lsHorario, STRING lsOperador, STRING lsRestricao
        DECLARE INTEGER ContinuaFuncaoSiTefInterativo IN "CliSiTef32I.DLL" ;
            INTEGER @lnComando, INTEGER @lnTipo, INTEGER @lnMinimo, INTEGER @lnMaximo, ;
            STRING @lsBuffer, INTEGER lnTamanho, INTEGER lnResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Orquestra construcao visual do form dialogo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarAreaPrincipal()
        THIS.ConfigurarSaida()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Header cinza escuro (equivale ao cntSombra do legado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = THIS.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top         = 1
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .AutoSize  = .F.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .WordWrap  = .T.
            .BackStyle = 0
            .Caption   = "Reimpress" + CHR(227) + "o do SiTef"
            .Height    = 40
            .Left      = 10
            .Top       = 18
            .Width     = loc_oCab.Width
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH
        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .AutoSize  = .F.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .WordWrap  = .T.
            .BackStyle = 0
            .Caption   = "Reimpress" + CHR(227) + "o do SiTef"
            .Height    = 46
            .Left      = 10
            .Top       = 17
            .Width     = loc_oCab.Width
            .ForeColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarAreaPrincipal - Area de interacao SiTef com Shape, Labels, TextBoxes
    * Posicoes originais: Shape1(Top=94,L=76,W=247,H=42) + Label3 + GetSenha +
    * SENHA + Container1 - todos relativos a Top=82 (pos apos header)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarAreaPrincipal()
        LOCAL loc_oArea
        THIS.AddObject("cnt_4c_Area", "Container")
        loc_oArea = THIS.cnt_4c_Area
        WITH loc_oArea
            .Top         = 82
            .Left        = 0
            .Width       = THIS.Width - 90
            .Height      = THIS.Height - 82
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Shape visual ao redor da area de entrada (Shape1: Top=94 -> rel=12)
        loc_oArea.AddObject("shp_4c_Borda", "Shape")
        WITH loc_oArea.shp_4c_Borda
            .Top         = 12
            .Left        = 76
            .Width       = 247
            .Height      = 42
            .BackStyle   = 0
            .BorderColor = RGB(100, 100, 100)
            .Visible     = .T.
        ENDWITH

        *-- Label "Senha do Supervisor :" (Label3: Top=108 -> rel=26)
        loc_oArea.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oArea.lbl_4c_Label3
            .AutoSize  = .F.
            .Top       = 26
            .Left      = 90
            .Width     = 108
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Senha do Supervisor :"
            .Visible   = .T.
        ENDWITH

        *-- TextBox GetSenha para leitura de cartao (Top=103 -> rel=21)
        *-- PasswordChar="*" oculta dados sensiveis do cartao
        loc_oArea.AddObject("txt_4c_GetSenha", "TextBox")
        WITH loc_oArea.txt_4c_GetSenha
            .Top          = 21
            .Left         = 214
            .Width        = 100
            .Height       = 23
            .FontName     = "Tahoma"
            .FontSize     = 8
            .Value        = ""
            .PasswordChar = "*"
            .Visible      = .T.
        ENDWITH
        BINDEVENT(loc_oArea.txt_4c_GetSenha, "GotFocus",  THIS, "TxtGetSenhaGotFocus")
        BINDEVENT(loc_oArea.txt_4c_GetSenha, "KeyPress", THIS, "TxtGetSenhaLostFocus")
        BINDEVENT(loc_oArea.txt_4c_GetSenha, "When",      THIS, "TxtGetSenhaWhen")

        *-- TextBox SENHA do supervisor - mesma posicao que GetSenha
        *-- Protocolo SiTef alterna foco via When (so foca quando o outro ja esta preenchido)
        loc_oArea.AddObject("txt_4c_Senha", "TextBox")
        WITH loc_oArea.txt_4c_Senha
            .Top          = 21
            .Left         = 214
            .Width        = 100
            .Height       = 23
            .FontName     = "Tahoma"
            .FontSize     = 8
            .Value        = ""
            .PasswordChar = "*"
            .Visible      = .T.
        ENDWITH
        BINDEVENT(loc_oArea.txt_4c_Senha, "GotFocus",  THIS, "TxtSenhaGotFocus")
        BINDEVENT(loc_oArea.txt_4c_Senha, "KeyPress", THIS, "TxtSenhaLostFocus")
        BINDEVENT(loc_oArea.txt_4c_Senha, "When",      THIS, "TxtSenhaWhen")

        *-- Container instrucao equivale ao Container1 (Top=141 -> rel=59, W=171, H=56)
        loc_oArea.AddObject("cnt_4c_Instrucao", "Container")
        WITH loc_oArea.cnt_4c_Instrucao
            .Top         = 59
            .Left        = 114
            .Width       = 171
            .Height      = 56
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
        loc_oArea.cnt_4c_Instrucao.AddObject("lbl_4c_Instrucao", "Label")
        WITH loc_oArea.cnt_4c_Instrucao.lbl_4c_Instrucao
            .AutoSize  = .F.
            .Top       = 17
            .Left      = 9
            .Width     = 157
            .Height    = 25
            .FontName  = "Tahoma"
            .FontSize  = 10
            .FontBold  = .T.
            .Alignment = 2
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .WordWrap  = .T.
            .Caption   = "Insira ou Passe o Cart" + CHR(227) + "o"
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarSaida - Botao Cancelar (equivale ao SAIDA CommandGroup do legado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarSaida()
        LOCAL loc_oSaida
        THIS.AddObject("cnt_4c_Saida", "Container")
        loc_oSaida = THIS.cnt_4c_Saida
        WITH loc_oSaida
            .Top         = 82
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
        loc_oSaida.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oSaida.cmd_4c_Cancelar
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oSaida.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtGetSenhaWhen - Permite foco em GetSenha apenas quando vazio
    * Equivale ao GetSenha.When: Return(EMPTY(This.Value)) do legado
    *--------------------------------------------------------------------------
    PROCEDURE TxtGetSenhaWhen()
        RETURN EMPTY(THIS.cnt_4c_Area.txt_4c_GetSenha.Value)
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtGetSenhaGotFocus - Loop protocolo SiTef ate TipoCampo=500 (aguarda cartao)
    * Equivale ao GetSenha.GotFocus do legado (41 linhas)
    *--------------------------------------------------------------------------
    PROCEDURE TxtGetSenhaGotFocus()
        THIS.this_nProximoComando  = 0
        THIS.this_nTipoCampo       = 0
        THIS.this_nTamanhoMinimo   = 0
        THIS.this_nTamanhoMaximo   = 0
        THIS.this_cBuffer          = REPLICATE(CHR(0), 2000)
        THIS.this_nContinua        = 0
        THIS.this_cMensagem        = ""
        THIS.ExecutarLoopContinua(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtGetSenhaLostFocus - Envia dado do cartao ao protocolo SiTef
    * Equivale ao GetSenha.LostFocus do legado (43 linhas)
    * Acumula TipoCampo 121/122 e finaliza com MontaRetorno se retorno=0
    *--------------------------------------------------------------------------
    PROCEDURE TxtGetSenhaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_nRetorno, loc_cBuf, loc_cCupom, loc_lFalhou
        LOCAL loc_nCmd, loc_nTipo, loc_nMin, loc_nMax

        IF EMPTY(THIS.cnt_4c_Area.txt_4c_GetSenha.Value)
            RETURN
        ENDIF

        loc_cBuf = ALLTRIM(THIS.cnt_4c_Area.txt_4c_GetSenha.Value)
        loc_cBuf = loc_cBuf + REPLICATE(CHR(0), 2000 - LEN(loc_cBuf))
        THIS.this_cBuffer   = loc_cBuf
        THIS.this_nContinua = 1000
        THIS.this_cMensagem = ""
        loc_cCupom          = ""
        loc_lFalhou         = .F.

        loc_nCmd  = THIS.this_nProximoComando
        loc_nTipo = THIS.this_nTipoCampo
        loc_nMin  = THIS.this_nTamanhoMinimo
        loc_nMax  = THIS.this_nTamanhoMaximo
        loc_cBuf  = THIS.this_cBuffer

        loc_nRetorno = ContinuaFuncaoSiTefInterativo(@loc_nCmd, @loc_nTipo, @loc_nMin, ;
            @loc_nMax, @loc_cBuf, LEN(loc_cBuf), THIS.this_nContinua)

        THIS.this_nProximoComando = loc_nCmd
        THIS.this_nTipoCampo      = loc_nTipo
        THIS.this_nTamanhoMinimo  = loc_nMin
        THIS.this_nTamanhoMaximo  = loc_nMax
        THIS.this_cBuffer         = loc_cBuf
        THIS.this_nContinua       = 0

        DO WHILE loc_nRetorno = 10000
            loc_nCmd  = THIS.this_nProximoComando
            loc_nTipo = THIS.this_nTipoCampo
            loc_nMin  = THIS.this_nTamanhoMinimo
            loc_nMax  = THIS.this_nTamanhoMaximo
            loc_cBuf  = THIS.this_cBuffer

            loc_nRetorno = ContinuaFuncaoSiTefInterativo(@loc_nCmd, @loc_nTipo, @loc_nMin, ;
                @loc_nMax, @loc_cBuf, LEN(loc_cBuf), THIS.this_nContinua)

            THIS.this_nProximoComando = loc_nCmd
            THIS.this_nTipoCampo      = loc_nTipo
            THIS.this_nTamanhoMinimo  = loc_nMin
            THIS.this_nTamanhoMaximo  = loc_nMax
            THIS.this_cBuffer         = loc_cBuf

            IF loc_nRetorno < 0
                THIS.RetornoFalha(THIS.this_cMensagem)
                loc_lFalhou = .T.
                EXIT
            ENDIF

            IF UPPER(ALLTRIM(THIS.this_cBuffer)) = "DOC INEXISTENTE"
                THIS.RetornoFalha("DOC INEXISTENTE")
                loc_lFalhou = .T.
                EXIT
            ENDIF

            IF THIS.this_nTipoCampo = 121 AND EMPTY(loc_cCupom)
                loc_cCupom = THIS.this_cBuffer + THIS.this_cBuffer
            ENDIF
            IF THIS.this_nTipoCampo = 122
                loc_cCupom = loc_cCupom + THIS.this_cBuffer
            ENDIF

            IF THIS.this_nProximoComando = 20
                loc_cBuf = "0" + REPLICATE(CHR(0), 1999)
                THIS.this_cBuffer   = loc_cBuf
                THIS.this_nContinua = 1000
                LOOP
            ELSE
                THIS.this_cMensagem = THIS.this_cBuffer
                loc_cBuf            = REPLICATE(CHR(0), 2000)
                THIS.this_cBuffer   = loc_cBuf
                THIS.this_nContinua = 0
            ENDIF
        ENDDO

        IF !loc_lFalhou AND loc_nRetorno = 0
            THIS.MontaRetorno(loc_cCupom)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtSenhaWhen - Permite foco em SENHA apenas quando vazio
    * Equivale ao SENHA.When: Return(EMPTY(This.Value)) do legado
    *--------------------------------------------------------------------------
    PROCEDURE TxtSenhaWhen()
        RETURN EMPTY(THIS.cnt_4c_Area.txt_4c_Senha.Value)
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtSenhaGotFocus - Prepara loop SiTef para entrada de senha supervisor
    * Equivale ao SENHA.GotFocus do legado (42 linhas)
    *--------------------------------------------------------------------------
    PROCEDURE TxtSenhaGotFocus()
        THIS.cnt_4c_Area.cnt_4c_Instrucao.lbl_4c_Instrucao.Caption = ;
            "Digite a Senha" + CHR(13) + "do Supervisor"

        THIS.this_nProximoComando  = 0
        THIS.this_nTipoCampo       = 0
        THIS.this_nTamanhoMinimo   = 0
        THIS.this_nTamanhoMaximo   = 0
        THIS.this_cBuffer          = REPLICATE(CHR(0), 2000)
        THIS.this_nContinua        = 0
        THIS.this_cMensagem        = ""
        THIS.ExecutarLoopContinua(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtSenhaLostFocus - Envia senha do supervisor, monta cupom em caso de sucesso
    * Equivale ao SENHA.LostFocus do legado (65 linhas)
    * Trata TipoCampo 515(data)/516(NSU), 121/122(cupom), VIA A SER REIMPRESSA
    *--------------------------------------------------------------------------
    PROCEDURE TxtSenhaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_nRetorno, loc_cBuf, loc_cCupom, loc_llVias, loc_lFalhou
        LOCAL loc_nCmd, loc_nTipo, loc_nMin, loc_nMax

        IF EMPTY(THIS.cnt_4c_Area.txt_4c_Senha.Value)
            RETURN
        ENDIF

        loc_cBuf = ALLTRIM(THIS.cnt_4c_Area.txt_4c_Senha.Value)
        loc_cBuf = loc_cBuf + REPLICATE(CHR(0), 2000 - LEN(loc_cBuf))
        THIS.this_cBuffer   = loc_cBuf
        THIS.this_nContinua = 1000
        THIS.this_cMensagem = ""
        loc_cCupom          = ""
        loc_llVias          = .F.
        loc_lFalhou         = .F.

        loc_nCmd  = THIS.this_nProximoComando
        loc_nTipo = THIS.this_nTipoCampo
        loc_nMin  = THIS.this_nTamanhoMinimo
        loc_nMax  = THIS.this_nTamanhoMaximo
        loc_cBuf  = THIS.this_cBuffer

        loc_nRetorno = ContinuaFuncaoSiTefInterativo(@loc_nCmd, @loc_nTipo, @loc_nMin, ;
            @loc_nMax, @loc_cBuf, LEN(loc_cBuf), THIS.this_nContinua)

        THIS.this_nProximoComando = loc_nCmd
        THIS.this_nTipoCampo      = loc_nTipo
        THIS.this_nTamanhoMinimo  = loc_nMin
        THIS.this_nTamanhoMaximo  = loc_nMax
        THIS.this_cBuffer         = loc_cBuf
        THIS.this_nContinua       = 0

        DO WHILE loc_nRetorno = 10000
            loc_nCmd  = THIS.this_nProximoComando
            loc_nTipo = THIS.this_nTipoCampo
            loc_nMin  = THIS.this_nTamanhoMinimo
            loc_nMax  = THIS.this_nTamanhoMaximo
            loc_cBuf  = THIS.this_cBuffer

            loc_nRetorno = ContinuaFuncaoSiTefInterativo(@loc_nCmd, @loc_nTipo, @loc_nMin, ;
                @loc_nMax, @loc_cBuf, LEN(loc_cBuf), THIS.this_nContinua)

            THIS.this_nProximoComando = loc_nCmd
            THIS.this_nTipoCampo      = loc_nTipo
            THIS.this_nTamanhoMinimo  = loc_nMin
            THIS.this_nTamanhoMaximo  = loc_nMax
            THIS.this_cBuffer         = loc_cBuf

            IF loc_nRetorno < 0
                THIS.RetornoFalha(THIS.this_cMensagem)
                loc_lFalhou = .T.
                EXIT
            ENDIF

            IF UPPER(ALLTRIM(THIS.this_cBuffer)) = "DOC INEXISTENTE"
                THIS.RetornoFalha("DOC INEXISTENTE")
                loc_lFalhou = .T.
                EXIT
            ENDIF

            *-- TipoCampo 515: protocolo pede data da transacao original
            IF THIS.this_nProximoComando = 30 AND THIS.this_nTipoCampo = 515
                loc_cBuf = THIS.this_cDataLocal + REPLICATE(CHR(0), 2000 - LEN(THIS.this_cDataLocal))
                THIS.this_cBuffer = loc_cBuf
                LOOP
            ENDIF

            *-- TipoCampo 516: protocolo pede NSU da transacao original
            IF THIS.this_nProximoComando = 30 AND THIS.this_nTipoCampo = 516
                IF !EMPTY(THIS.this_cValor)
                    loc_cBuf = TRANSFORM(VAL(THIS.this_cNSULocal), "@L 999999")
                ELSE
                    loc_cBuf = TRANSFORM(VAL(THIS.this_cNSULocal), "@L 999999999")
                ENDIF
                loc_cBuf = loc_cBuf + REPLICATE(CHR(0), 2000 - LEN(loc_cBuf))
                THIS.this_cBuffer = loc_cBuf
                LOOP
            ENDIF

            IF THIS.this_nTipoCampo = 121 AND EMPTY(loc_cCupom)
                loc_cCupom = THIS.this_cBuffer + THIS.this_cBuffer
            ENDIF
            IF THIS.this_nTipoCampo = 122
                loc_cCupom = loc_cCupom + THIS.this_cBuffer
            ENDIF

            *-- Protocolo indica reimpressao de via: responder com "3"
            IF loc_llVias
                loc_cBuf = "3" + REPLICATE(CHR(0), 1999)
                THIS.this_cBuffer = loc_cBuf
                loc_llVias        = .F.
                LOOP
            ENDIF

            IF UPPER(THIS.this_cBuffer) = "VIA A SER REIMPRESSA"
                loc_llVias = .T.
            ENDIF

            IF THIS.this_nProximoComando = 20
                loc_cBuf = "0" + REPLICATE(CHR(0), 1999)
                THIS.this_cBuffer   = loc_cBuf
                THIS.this_nContinua = 1000
                LOOP
            ELSE
                THIS.this_cMensagem = THIS.this_cBuffer
                loc_cBuf            = REPLICATE(CHR(0), 2000)
                THIS.this_cBuffer   = loc_cBuf
                THIS.this_nContinua = 0
            ENDIF
        ENDDO

        IF !loc_lFalhou AND loc_nRetorno = 0
            THIS.MontaRetorno(loc_cCupom)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarLoopContinua - Loop ContinuaFuncaoSiTefInterativo ate TipoCampo=500
    * Compartilhado por TxtGetSenhaGotFocus e TxtSenhaGotFocus
    * par_nTipo: 1=NSU formatado numerico, 2=NSU raw string
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarLoopContinua(par_nTipo)
        LOCAL loc_nRetorno, loc_nCmd, loc_nTipoLocal, loc_nMin, loc_nMax, loc_cBuf

        DO WHILE THIS.this_nTipoCampo <> 500
            loc_nCmd       = THIS.this_nProximoComando
            loc_nTipoLocal = THIS.this_nTipoCampo
            loc_nMin       = THIS.this_nTamanhoMinimo
            loc_nMax       = THIS.this_nTamanhoMaximo
            loc_cBuf       = THIS.this_cBuffer

            loc_nRetorno = ContinuaFuncaoSiTefInterativo(@loc_nCmd, @loc_nTipoLocal, @loc_nMin, ;
                @loc_nMax, @loc_cBuf, LEN(loc_cBuf), THIS.this_nContinua)

            THIS.this_nProximoComando = loc_nCmd
            THIS.this_nTipoCampo      = loc_nTipoLocal
            THIS.this_nTamanhoMinimo  = loc_nMin
            THIS.this_nTamanhoMaximo  = loc_nMax
            THIS.this_cBuffer         = loc_cBuf

            IF loc_nRetorno < 0
                THIS.RetornoFalha(THIS.this_cMensagem)
                EXIT
            ENDIF

            IF THIS.this_nProximoComando = 30 AND !EMPTY(THIS.this_cNSULocal)
                IF par_nTipo = 1
                    loc_cBuf = TRANSFORM(VAL(THIS.this_cNSULocal), "@L 999999999")
                    loc_cBuf = loc_cBuf + REPLICATE(CHR(0), 2000 - LEN(loc_cBuf))
                ELSE
                    loc_cBuf = THIS.this_cNSULocal + REPLICATE(CHR(0), 2000 - LEN(THIS.this_cNSULocal))
                ENDIF
                THIS.this_cBuffer   = loc_cBuf
                THIS.this_nContinua = 0
            ENDIF

            IF THIS.this_nProximoComando = 28 AND !EMPTY(THIS.this_cDataLocal)
                loc_cBuf = THIS.this_cDataLocal + REPLICATE(CHR(0), 2000 - LEN(THIS.this_cDataLocal))
                THIS.this_cBuffer   = loc_cBuf
                THIS.this_nContinua = 0
            ENDIF

            IF THIS.this_nProximoComando = 39
                loc_cBuf = "0" + REPLICATE(CHR(0), 1999)
                THIS.this_cBuffer   = loc_cBuf
                THIS.this_nContinua = 0
            ENDIF
        ENDDO
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela operacao SiTef e fecha o form
    * Equivale ao SAIDA.Command1.Click do legado
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.RetornoFalha("Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usu" + CHR(225) + "rio")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Inicia novo ciclo de reimpressao (equivalente F2/Novo)
    * Zera estado do protocolo SiTef, limpa campos e reinicia sessao com o
    * servidor. Usado para consultar um novo cupom sem fechar o dialogo.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro
        TRY
            THIS.this_nProximoComando = 0
            THIS.this_nTipoCampo      = 0
            THIS.this_nTamanhoMinimo  = 0
            THIS.this_nTamanhoMaximo  = 0
            THIS.this_cBuffer         = REPLICATE(CHR(0), 2000)
            THIS.this_nContinua       = 0
            THIS.this_cMensagem       = ""
            THIS.this_lIdent          = .F.

            THIS.cnt_4c_Area.txt_4c_GetSenha.Value = ""
            THIS.cnt_4c_Area.txt_4c_Senha.Value    = ""

            THIS.AlternarPagina(1)

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.IniciarProtocolo()
            ENDIF

            THIS.cnt_4c_Area.txt_4c_GetSenha.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Reenvia senha do supervisor (equivalente F3/Editar)
    * Limpa apenas o campo de senha e retorna o foco para nova digitacao,
    * mantendo o estado do protocolo SiTef ate o comando 30/senha.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oErro
        TRY
            IF EMPTY(THIS.cnt_4c_Area.txt_4c_GetSenha.Value)
                MsgAviso("Passe o cart" + CHR(227) + "o antes de reenviar a senha.", ;
                        "Reimpress" + CHR(227) + "o SiTef")
                THIS.cnt_4c_Area.txt_4c_GetSenha.SetFocus()
            ELSE
                THIS.cnt_4c_Area.txt_4c_Senha.Value = ""
                THIS.AlternarPagina(2)
                THIS.cnt_4c_Area.txt_4c_Senha.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Direciona o usuario para o inicio do fluxo de
    * reimpressao (equivalente F5/Visualizar). Foca o campo de leitura do
    * cartao e apresenta a instrucao "Insira ou Passe o Cartao".
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro
        TRY
            THIS.AlternarPagina(1)
            THIS.cnt_4c_Area.txt_4c_GetSenha.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Cancela a operacao SiTef em andamento (equivalente
    * F4/Excluir). Delega ao mesmo fluxo do botao Cancelar apos confirmacao.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_lConfirma, loc_oErro
        TRY
            loc_lConfirma = MsgConfirma("Cancelar a opera" + CHR(231) + CHR(227) + "o SiTef em andamento?", ;
                                       "Confirma" + CHR(231) + CHR(227) + "o")
            IF loc_lConfirma
                THIS.RetornoFalha("Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usu" + CHR(225) + "rio")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * MontaRetorno - Finaliza com sucesso: popula crSiTef via BO e fecha form
    * Equivale ao PROCEDURE MontaRetorno() do legado
    *--------------------------------------------------------------------------
    PROCEDURE MontaRetorno(par_cCupom)
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.MontaRetorno(par_cCupom)
        ENDIF
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna instrucoes entre modo cartao e modo senha supervisor
    * par_nModo: 1=Insira cartao, 2=Senha supervisor
    * (Equivale a alternancia de instrucoes no Container1 original)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nModo)
        LOCAL loc_oLabel
        loc_oLabel = THIS.cnt_4c_Area.cnt_4c_Instrucao.lbl_4c_Instrucao
        IF par_nModo = 2
            loc_oLabel.Caption = "Digite a Senha" + CHR(13) + "do Supervisor"
        ELSE
            loc_oLabel.Caption = "Insira ou Passe o Cart" + CHR(227) + "o"
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Compatibilidade com pipeline (dialogo sem lista/grid)
    *--------------------------------------------------------------------------
    PROCEDURE ConfigurarPaginaLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Compatibilidade com pipeline (dialogo sem Page2 CRUD)
    * Toda a area interativa ja foi criada em ConfigurarAreaPrincipal (Fase 3/4)
    *--------------------------------------------------------------------------
    PROCEDURE ConfigurarPaginaDados()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * RetornoFalha - Registra falha no protocolo e fecha o form
    * Equivale ao PROCEDURE RetornoFalha() do legado
    *--------------------------------------------------------------------------
    PROCEDURE RetornoFalha(par_cMensagem)
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.RetornoFalha(par_cMensagem)
        ENDIF
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Compatibilidade com pipeline (dialogo sem lista de registros)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        *-- Dialogo SiTef nao tem lista de registros para carregar
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos controles pelo modo corrente
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.cnt_4c_Saida) = "O"
                IF PEMSTATUS(THIS.cnt_4c_Saida, "cmd_4c_Cancelar", 5)
                    THIS.cnt_4c_Saida.cmd_4c_Cancelar.Enabled = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos de entrada do protocolo SiTef
    * par_lHabilitar: .T. = habilitar, .F. = desabilitar
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar, loc_oErro
        loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
        TRY
            IF VARTYPE(THIS.cnt_4c_Area) = "O"
                IF PEMSTATUS(THIS.cnt_4c_Area, "txt_4c_GetSenha", 5)
                    THIS.cnt_4c_Area.txt_4c_GetSenha.Enabled = loc_lHabilitar
                ENDIF
                IF PEMSTATUS(THIS.cnt_4c_Area, "txt_4c_Senha", 5)
                    THIS.cnt_4c_Area.txt_4c_Senha.Enabled = loc_lHabilitar
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa os campos de entrada do dialogo SiTef
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.cnt_4c_Area) = "O"
                IF PEMSTATUS(THIS.cnt_4c_Area, "txt_4c_GetSenha", 5)
                    THIS.cnt_4c_Area.txt_4c_GetSenha.Value = ""
                ENDIF
                IF PEMSTATUS(THIS.cnt_4c_Area, "txt_4c_Senha", 5)
                    THIS.cnt_4c_Area.txt_4c_Senha.Value = ""
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Atualiza BO com estado corrente do form
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                RETURN
            ENDIF
            WITH THIS.this_oBusinessObject
                .this_cEndSitef       = THIS.this_cEndSitef
                .this_cCaixa          = THIS.this_cCaixa
                .this_cNSU            = THIS.this_cNSU
                .this_cData           = THIS.this_cData
                .this_cValor          = THIS.this_cValor
                .this_cHora           = THIS.this_cHora
                .this_cCodEstabs      = THIS.this_cCodEstabs
                .this_nProximoComando = THIS.this_nProximoComando
                .this_nTipoCampo      = THIS.this_nTipoCampo
                .this_nTamanhoMinimo  = THIS.this_nTamanhoMinimo
                .this_nTamanhoMaximo  = THIS.this_nTamanhoMaximo
                .this_cBuffer         = THIS.this_cBuffer
                .this_nContinua       = THIS.this_nContinua
                .this_cMensagem       = THIS.this_cMensagem
                .this_lIdentificado   = THIS.this_lIdent
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Atualiza estado do form com dados do BO
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                RETURN
            ENDIF
            THIS.this_nProximoComando = THIS.this_oBusinessObject.this_nProximoComando
            THIS.this_nTipoCampo      = THIS.this_oBusinessObject.this_nTipoCampo
            THIS.this_nTamanhoMinimo  = THIS.this_oBusinessObject.this_nTamanhoMinimo
            THIS.this_nTamanhoMaximo  = THIS.this_oBusinessObject.this_nTamanhoMaximo
            THIS.this_cBuffer         = THIS.this_oBusinessObject.this_cBuffer
            THIS.this_nContinua       = THIS.this_oBusinessObject.this_nContinua
            THIS.this_cMensagem       = THIS.this_oBusinessObject.this_cMensagem
            THIS.this_lIdent          = THIS.this_oBusinessObject.this_lIdentificado
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Reinicia o foco no campo de leitura do cartao
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oErro
        TRY
            THIS.AlternarPagina(1)
            THIS.cnt_4c_Area.txt_4c_GetSenha.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Cancela operacao e encerra o dialogo SiTef com confirmacao
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        LOCAL loc_lConfirma, loc_oErro
        TRY
            loc_lConfirma = MsgConfirma("Encerrar a reimpress" + CHR(227) + "o SiTef?", ;
                                       "Confirma" + CHR(231) + CHR(227) + "o")
            IF loc_lConfirma
                THIS.RetornoFalha("Opera" + CHR(231) + CHR(227) + "o encerrada pelo usu" + CHR(225) + "rio")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Processa o campo de entrada corrente e avanca o protocolo SiTef
    * Se SENHA preenchido: envia senha do supervisor para finalizacao
    * Se GetSenha preenchido: processa dado do cartao
    * Se vazio: foca no campo de leitura do cartao
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oErro
        TRY
            IF !EMPTY(THIS.cnt_4c_Area.txt_4c_Senha.Value)
                THIS.TxtSenhaLostFocus()
            ELSE
                IF !EMPTY(THIS.cnt_4c_Area.txt_4c_GetSenha.Value)
                THIS.TxtGetSenhaLostFocus()
            ELSE
                THIS.cnt_4c_Area.txt_4c_GetSenha.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigproerBO.prg):
*==============================================================================
* sigproerBO.prg - Business Object para Reimpressao SiTef
* Form original: SIGPROER.SCX
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS sigproerBO AS BusinessBase

    *-- Parametros recebidos na abertura do form
    this_cEndSitef   = ""   && Endereco servidor SiTef
    this_cCaixa      = ""   && Identificador do caixa
    this_cNSU        = ""   && Numero Sequencial Unico
    this_cData       = ""   && Data da transacao original
    this_cHora       = ""   && Hora da transacao original
    this_cValor      = ""   && Valor da transacao (string formatada para DLL)
    this_cCodEstabs  = ""   && Codigo do estabelecimento

    *-- Dados da empresa carregados de SigCdEmp
    this_cEmpresa    = ""   && Cemps char(3)
    this_cIdTerminal = ""   && Identificador do terminal composto (Empresa+Caixa)

    *-- Estado do protocolo SiTef (equivalente as PUBLICs do legado)
    this_nProximoComando = 0    && ProximoComando
    this_nTipoCampo      = 0    && TipoCampo
    this_nTamanhoMinimo  = 0    && TamanhoMinimo
    this_nTamanhoMaximo  = 0    && TamanhoMaximo
    this_cBuffer         = ""   && Buffer 2000 bytes (preenchido com Chr(0))
    this_nContinua       = 0    && lnContinua (flag de continuacao da DLL)
    this_lIdentificado   = .F.  && ltIdent

    *-- Acumula linhas do cupom durante protocolo (tipos 121/122)
    this_cCupom      = ""

    *-- Ultima mensagem recebida do SiTef (tipo <> 30)
    this_cMensagem   = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave composta: NSU + Caixa + Data
    * (SIGPROER nao persiste entidade CRUD; chave usada apenas para auditoria)
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ALLTRIM(THIS.this_cNSU) + "|" + ;
                     ALLTRIM(THIS.this_cCaixa) + "|" + ;
                     ALLTRIM(THIS.this_cData)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida parametros recebidos antes do protocolo SiTef
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.
        IF EMPTY(THIS.this_cEndSitef)
            MsgAviso("Endere" + CHR(231) + "o do servidor SiTef n" + CHR(227) + "o informado.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF
        IF loc_lValido AND EMPTY(THIS.this_cCaixa)
            MsgAviso("Identificador do caixa n" + CHR(227) + "o informado.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF
        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Restaura estado do BO a partir de cursor de parametros
    * (SIGPROER nao tem tabela persistente; este metodo hidrata os parametros
    *  quando recebidos via cursor em vez de parametros diretos do Init)
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
                loc_lSucesso = .F.
            ENDIF
            SELECT (par_cAliasCursor)
            IF RECCOUNT(par_cAliasCursor) = 0
                loc_lSucesso = .F.
            ENDIF
            *-- Mapeia colunas do cursor para propriedades
            IF TYPE(par_cAliasCursor + ".EndSitef") != "U"
                THIS.this_cEndSitef = ALLTRIM(NVL(EndSitef, ""))
            ENDIF
            IF TYPE(par_cAliasCursor + ".Caixa") != "U"
                THIS.this_cCaixa = ALLTRIM(NVL(Caixa, ""))
            ENDIF
            IF TYPE(par_cAliasCursor + ".NSU") != "U"
                THIS.this_cNSU = ALLTRIM(NVL(NSU, ""))
            ENDIF
            IF TYPE(par_cAliasCursor + ".Data") != "U"
                THIS.this_cData = ALLTRIM(NVL(Data, ""))
            ENDIF
            IF TYPE(par_cAliasCursor + ".Hora") != "U"
                THIS.this_cHora = ALLTRIM(NVL(Hora, ""))
            ENDIF
            IF TYPE(par_cAliasCursor + ".Valor") != "U"
                THIS.this_cValor = ALLTRIM(NVL(Valor, ""))
            ENDIF
            IF TYPE(par_cAliasCursor + ".CodEstabs") != "U"
                THIS.this_cCodEstabs = ALLTRIM(NVL(CodEstabs, ""))
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Executa reimpressao via protocolo SiTef
    * Em SIGPROER, "inserir" significa executar o ciclo completo de reimpressao
    * (SIGPROER nao grava em tabela do banco; a "persistencia" sao os arquivos
    *  IntPos.001 e IntPos.STS gravados por MontaRetorno/RetornoFalha)
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF !THIS.ValidarDados()
                loc_lSucesso = .F.
            ENDIF
            IF !THIS.CarregarDadosEmpresa()
                loc_lSucesso = .F.
            ENDIF
            IF !THIS.IniciarProtocolo()
                loc_lSucesso = .F.
            ENDIF
            *-- Auditoria da operacao de reimpressao
            THIS.RegistrarAuditoria("REIMPRESSAO")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Reprocessa reimpressao (executa nova tentativa do ciclo SiTef)
    * (SIGPROER nao possui entidade persistente para atualizar; reaproveita
    *  o ciclo de Inserir com registro de auditoria diferente)
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF !THIS.ValidarDados()
                loc_lSucesso = .F.
            ENDIF
            IF !THIS.CarregarDadosEmpresa()
                loc_lSucesso = .F.
            ENDIF
            IF !THIS.IniciarProtocolo()
                loc_lSucesso = .F.
            ENDIF
            THIS.RegistrarAuditoria("REPROCESSAMENTO")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Grava operacao de reimpressao SiTef em LogAuditoria
    *--------------------------------------------------------------------------
    FUNCTION RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario, loc_cEmpresa, loc_oErro
        TRY
            loc_cChave   = THIS.ObterChavePrimaria()
            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(gc_4c_UsuarioLogado)
            ENDIF
            loc_cEmpresa = ALLTRIM(THIS.this_cEmpresa)
            IF EMPTY(loc_cEmpresa) AND TYPE("go_4c_Sistema") = "O"
                loc_cEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            ENDIF

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(DataHora, Usuario, Tabela, ChaveRegistro, Operacao, DadosNovos) " + ;
                       "VALUES (GETDATE(), " + ;
                       EscaparSQL(LEFT(loc_cUsuario, 50)) + ", " + ;
                       EscaparSQL("SIGPROER") + ", " + ;
                       EscaparSQL(LEFT(loc_cChave, 100)) + ", " + ;
                       EscaparSQL(LEFT(par_cOperacao, 10)) + ", " + ;
                       EscaparSQL(LEFT("NSU=" + ALLTRIM(THIS.this_cNSU) + ;
                                       " Caixa=" + ALLTRIM(THIS.this_cCaixa) + ;
                                       " Data=" + ALLTRIM(THIS.this_cData), 200)) + ")"
            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            *-- Auditoria nao pode bloquear operacao principal; apenas registra erro
            IF TYPE("loc_oErro") = "O"
                MsgErro("Falha ao registrar auditoria: " + loc_oErro.Message, "Auditoria")
            ENDIF
        ENDTRY
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION CarregarDadosEmpresa()
        *-- Carrega codigo empresa de SigCdEmp e monta IdTerminal
        LOCAL loc_cSQL, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT Cemps FROM SigCdEmp WHERE Cemps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emp") > 0 AND ;
               USED("cursor_4c_Emp") AND RECCOUNT("cursor_4c_Emp") > 0
                SELECT cursor_4c_Emp
                THIS.this_cEmpresa = ALLTRIM(NVL(Cemps, ""))
            ELSE
                THIS.this_cEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            ENDIF
            IF USED("cursor_4c_Emp")
                USE IN cursor_4c_Emp
            ENDIF
            *-- ID loja: pcCodEstabs se informado, senao "00000" + empresa
            IF EMPTY(THIS.this_cCodEstabs)
                THIS.this_cIdTerminal = "00000" + THIS.this_cEmpresa
            ELSE
                THIS.this_cIdTerminal = THIS.this_cCodEstabs
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION IniciarProtocolo()
        *-- Chama ConfiguraIntSiTefInterativo e IniciaFuncaoSiTefInterativo
        LOCAL loc_lSucesso, loc_cValores, loc_oErro
        loc_lSucesso = .F.
        TRY
            *-- ID terminal = empresa + caixa (6 digitos)
            LOCAL loc_cIdTerminal
            loc_cIdTerminal = ALLTRIM(THIS.this_cEmpresa) + ;
                              TRANSFORM(VAL(THIS.this_cCaixa), "@L 999999")

            IF ConfiguraIntSiTefInterativo(THIS.this_cEndSitef, THIS.this_cIdTerminal, loc_cIdTerminal, 0) <> 0
                THIS.RetornoFalha("Sem comunicacao com SiTef")
                loc_lSucesso = .F.
            ENDIF
            IF !EMPTY(THIS.this_cValor)
                loc_cValores = STRTRAN(ALLTRIM(TRANSFORM(VAL(THIS.this_cValor), "999999999999.99")), ".", ",")
            ELSE
                loc_cValores = ""
            ENDIF
            IF IniciaFuncaoSiTefInterativo(IIF(EMPTY(THIS.this_cData), 114, 113), loc_cValores, "1", "", "", "", "") <> 10000
                THIS.RetornoFalha("Sem comunicacao com SiTef")
                loc_lSucesso = .F.
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ExecutarCicloSiTef()
        *-- Loop ContinuaFuncaoSiTefInterativo ate TipoCampo=500 (aguarda cartao/senha)
        *-- Retorna o ultimo lnRetorno da DLL (0=ok, <0=falha, 10000=continua)
        LOCAL loc_nProxCmd, loc_nTipoCampo, loc_nTamMin, loc_nTamMax
        LOCAL loc_cBuffer, loc_nContinua, loc_nRetorno, loc_nTipo

        loc_nTipo      = 1
        loc_nProxCmd   = 0
        loc_nTipoCampo = 0
        loc_nTamMin    = 0
        loc_nTamMax    = 0
        loc_cBuffer    = REPLICATE(CHR(0), 2000)
        loc_nContinua  = 0
        loc_nRetorno   = 0
        THIS.this_cMensagem = ""

        DO WHILE loc_nTipoCampo <> 500
            loc_nRetorno = ContinuaFuncaoSiTefInterativo( ;
                @loc_nProxCmd, @loc_nTipoCampo, @loc_nTamMin, @loc_nTamMax, ;
                @loc_cBuffer, LEN(loc_cBuffer), loc_nContinua)

            THIS.this_nProximoComando = loc_nProxCmd
            THIS.this_nTipoCampo      = loc_nTipoCampo
            THIS.this_nTamanhoMinimo  = loc_nTamMin
            THIS.this_nTamanhoMaximo  = loc_nTamMax
            THIS.this_cBuffer         = loc_cBuffer

            IF loc_nRetorno < 0
                THIS.this_cMensagem = loc_cBuffer
                RETURN loc_nRetorno
            ENDIF

            IF loc_nProxCmd = 30 AND !EMPTY(THIS.this_cNSU)
                IF loc_nTipo = 1
                    loc_cBuffer = TRANSFORM(VAL(THIS.this_cNSU), "@L 999999999")
                    loc_cBuffer = loc_cBuffer + REPLICATE(CHR(0), 2000 - LEN(loc_cBuffer))
                    loc_nContinua = 1000
                    loc_nTipo = 2
                    LOOP
                ENDIF
                IF loc_nTipo = 2
                    loc_cBuffer = THIS.this_cData + REPLICATE(CHR(0), 2000 - LEN(THIS.this_cData))
                    loc_nContinua = 1000
                    loc_nTipo = 3
                    LOOP
                ENDIF
            ENDIF

            IF loc_nProxCmd <> 30
                THIS.this_cMensagem = loc_cBuffer
                loc_cBuffer   = REPLICATE(CHR(0), 2000)
                loc_nContinua = 0
            ENDIF
        ENDDO

        RETURN loc_nRetorno
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ProcessarRespostaGetSenha(par_cValor)
        *-- Processa resposta apos leitura do cartao (equivale a GetSenha.LostFocus)
        LOCAL loc_nProxCmd, loc_nTipoCampo, loc_nTamMin, loc_nTamMax
        LOCAL loc_cBuffer, loc_nContinua, loc_nRetorno, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            THIS.this_cCupom    = ""
            THIS.this_cMensagem = ""
            loc_cBuffer   = ALLTRIM(par_cValor) + REPLICATE(CHR(0), 2000 - LEN(ALLTRIM(par_cValor)))
            loc_nContinua = 1000
            loc_nProxCmd  = THIS.this_nProximoComando
            loc_nTipoCampo = THIS.this_nTipoCampo
            loc_nTamMin   = THIS.this_nTamanhoMinimo
            loc_nTamMax   = THIS.this_nTamanhoMaximo

            loc_nRetorno = ContinuaFuncaoSiTefInterativo( ;
                @loc_nProxCmd, @loc_nTipoCampo, @loc_nTamMin, @loc_nTamMax, ;
                @loc_cBuffer, LEN(loc_cBuffer), loc_nContinua)
            loc_nContinua = 0

            DO WHILE loc_nRetorno = 10000
                loc_nRetorno = ContinuaFuncaoSiTefInterativo( ;
                    @loc_nProxCmd, @loc_nTipoCampo, @loc_nTamMin, @loc_nTamMax, ;
                    @loc_cBuffer, LEN(loc_cBuffer), loc_nContinua)

                IF loc_nRetorno < 0
                    THIS.RetornoFalha(THIS.this_cMensagem)
                    loc_lSucesso = .F.
                ENDIF
                IF UPPER(ALLTRIM(loc_cBuffer)) = "DOC INEXISTENTE"
                    THIS.RetornoFalha("DOC INEXISTENTE")
                    loc_lSucesso = .F.
                ENDIF
                IF loc_nTipoCampo = 121 AND EMPTY(THIS.this_cCupom)
                    THIS.this_cCupom = loc_cBuffer + loc_cBuffer
                ENDIF
                IF loc_nTipoCampo = 122
                    THIS.this_cCupom = THIS.this_cCupom + loc_cBuffer
                ENDIF
                IF loc_nProxCmd = 20
                    loc_cBuffer   = "0" + REPLICATE(CHR(0), 1999)
                    loc_nContinua = 1000
                    LOOP
                ELSE
                    THIS.this_cMensagem = loc_cBuffer
                    loc_cBuffer   = REPLICATE(CHR(0), 2000)
                    loc_nContinua = 0
                ENDIF
            ENDDO

            IF loc_nRetorno = 0
                THIS.MontaRetorno(THIS.this_cCupom)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ProcessarRespostaSenha(par_cValor)
        *-- Processa resposta apos digitacao da senha (equivale a SENHA.LostFocus)
        LOCAL loc_nProxCmd, loc_nTipoCampo, loc_nTamMin, loc_nTamMax
        LOCAL loc_cBuffer, loc_nContinua, loc_nRetorno, loc_lSucesso, loc_lVias, loc_oErro
        loc_lSucesso = .F.
        loc_lVias    = .F.
        TRY
            THIS.this_cCupom    = ""
            THIS.this_cMensagem = ""
            loc_cBuffer   = ALLTRIM(par_cValor) + REPLICATE(CHR(0), 2000 - LEN(ALLTRIM(par_cValor)))
            loc_nContinua = 1000
            loc_nProxCmd  = THIS.this_nProximoComando
            loc_nTipoCampo = THIS.this_nTipoCampo
            loc_nTamMin   = THIS.this_nTamanhoMinimo
            loc_nTamMax   = THIS.this_nTamanhoMaximo

            loc_nRetorno = ContinuaFuncaoSiTefInterativo( ;
                @loc_nProxCmd, @loc_nTipoCampo, @loc_nTamMin, @loc_nTamMax, ;
                @loc_cBuffer, LEN(loc_cBuffer), loc_nContinua)
            loc_nContinua = 0

            DO WHILE loc_nRetorno = 10000
                loc_nRetorno = ContinuaFuncaoSiTefInterativo( ;
                    @loc_nProxCmd, @loc_nTipoCampo, @loc_nTamMin, @loc_nTamMax, ;
                    @loc_cBuffer, LEN(loc_cBuffer), loc_nContinua)

                IF loc_nRetorno < 0
                    THIS.RetornoFalha(THIS.this_cMensagem)
                    loc_lSucesso = .F.
                ENDIF
                IF UPPER(ALLTRIM(loc_cBuffer)) = "DOC INEXISTENTE"
                    THIS.RetornoFalha("DOC INEXISTENTE")
                    loc_lSucesso = .F.
                ENDIF
                IF loc_nProxCmd = 30 AND loc_nTipoCampo = 515
                    loc_cBuffer = THIS.this_cData + REPLICATE(CHR(0), 2000 - LEN(THIS.this_cData))
                    LOOP
                ENDIF
                IF loc_nProxCmd = 30 AND loc_nTipoCampo = 516
                    IF !EMPTY(THIS.this_cValor)
                        loc_cBuffer = TRANSFORM(VAL(THIS.this_cNSU), "@L 999999")
                    ELSE
                        loc_cBuffer = TRANSFORM(VAL(THIS.this_cNSU), "@L 999999999")
                    ENDIF
                    loc_cBuffer = loc_cBuffer + REPLICATE(CHR(0), 2000 - LEN(loc_cBuffer))
                    LOOP
                ENDIF
                IF loc_nTipoCampo = 121 AND EMPTY(THIS.this_cCupom)
                    THIS.this_cCupom = loc_cBuffer + loc_cBuffer
                ENDIF
                IF loc_nTipoCampo = 122
                    THIS.this_cCupom = THIS.this_cCupom + loc_cBuffer
                ENDIF
                IF loc_lVias
                    loc_cBuffer   = "3" + REPLICATE(CHR(0), 1999)
                    loc_lVias     = .F.
                    LOOP
                ENDIF
                IF UPPER(ALLTRIM(loc_cBuffer)) = "VIA A SER REIMPRESSA"
                    loc_lVias = .T.
                ENDIF
                IF loc_nProxCmd = 20
                    loc_cBuffer   = "0" + REPLICATE(CHR(0), 1999)
                    loc_nContinua = 1000
                    LOOP
                ELSE
                    THIS.this_cMensagem = loc_cBuffer
                    loc_cBuffer   = REPLICATE(CHR(0), 2000)
                    loc_nContinua = 0
                ENDIF
            ENDDO

            IF loc_nRetorno = 0
                THIS.MontaRetorno(THIS.this_cCupom)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION MontaRetorno(par_cCupom)
        *-- Grava arquivos IntPos.001 e IntPos.STS com resposta de sucesso
        LOCAL loc_cCupom, loc_lPos, loc_nLinha, loc_oErro
        TRY
            IF USED("crSiTef")
                USE IN crSiTef
            ENDIF
            CREATE CURSOR crSiTef (tef c(100))

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("003-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("009-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("010-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("011-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("012-000 = " + ALLTRIM(THIS.this_cNSU))
            INSERT INTO crSiTef (Tef) VALUES ("013-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("015-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("017-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("018-000 = 1")
            INSERT INTO crSiTef (Tef) VALUES ("017-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("019-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("020-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("021-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("022-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("023-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("023-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("027-000 = ")

            loc_cCupom  = par_cCupom
            loc_lPos    = 1
            loc_nLinha  = 1
            DO WHILE loc_lPos <> 0
                loc_lPos = AT(CHR(10), loc_cCupom)
                INSERT INTO crSiTef (Tef) VALUES ("029-" + TRANSFORM(loc_nLinha, "@L 999") + ;
                    " = " + IIF(loc_lPos <> 0, SUBSTR(loc_cCupom, 1, loc_lPos - 1), loc_cCupom))
                loc_cCupom = SUBSTR(loc_cCupom, loc_lPos + 1)
                loc_nLinha = loc_nLinha + 1
            ENDDO

            INSERT INTO crSiTef (Tef) VALUES ("028-000 = " + ALLTRIM(STR(loc_nLinha - 2)))
            INSERT INTO crSiTef (Tef) VALUES ("030-000 = Transacao OK")
            INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            SELECT crSiTef
            COPY TO C:\client\Resp\IntPos.001 SDF
            ZAP

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            COPY TO C:\client\Resp\IntPos.STS SDF
            USE IN crSiTef
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION RetornoFalha(par_cMensagem)
        *-- Grava arquivos IntPos.001 e IntPos.STS com resposta de falha
        LOCAL loc_oErro
        TRY
            IF USED("crSiTef")
                USE IN crSiTef
            ENDIF
            CREATE CURSOR crSiTef (tef c(100))

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("003-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("009-000 = FF")
            INSERT INTO crSiTef (Tef) VALUES ("010-000 = 05")
            INSERT INTO crSiTef (Tef) VALUES ("028-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("030-000 = " + par_cMensagem)
            INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            SELECT crSiTef
            COPY TO C:\client\Resp\IntPos.001 SDF
            ZAP

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            COPY TO C:\client\Resp\IntPos.STS SDF
            USE IN crSiTef
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE

