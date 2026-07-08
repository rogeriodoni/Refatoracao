*==============================================================================
* FORMERRO.PRG
* Formulario de exibicao de erros com opcoes avancadas
*
* Botoes:
* - Fechar Aplicacao: Encerra o sistema
* - Copiar Erro: Copia mensagem para area de transferencia
* - Ok, Continuar: Fecha apenas a mensagem
*==============================================================================

DEFINE CLASS FormErro AS Form

    *-- Propriedades do formulario
    Height = 200
    Width = 500
    AutoCenter = .T.
    BorderStyle = 2
    Caption = "Erro"
    MaxButton = .F.
    MinButton = .F.
    ShowWindow = 1
    WindowType = 1
    BackColor = RGB(240, 240, 240)

    *-- Propriedades customizadas
    this_cMensagem = ""
    this_cTitulo = "Erro"

    *--------------------------------------------------------------------------
    * Init - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cMensagem, par_cTitulo)
        LOCAL loc_lResultado
        loc_lResultado = .T.

        IF !EMPTY(par_cMensagem)
            THIS.this_cMensagem = par_cMensagem
        ENDIF

        IF !EMPTY(par_cTitulo)
            THIS.this_cTitulo = par_cTitulo
            THIS.Caption = par_cTitulo
        ENDIF

        THIS.CriarControles()

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarControles - Cria os controles do formulario
    *--------------------------------------------------------------------------
    PROCEDURE CriarControles()
        LOCAL loc_nLarguraBtn, loc_nAlturaBtn, loc_nEspacamento
        LOCAL loc_nTopBotoes, loc_nLeftInicial

        loc_nLarguraBtn = 130
        loc_nAlturaBtn = 32
        loc_nEspacamento = 10
        loc_nTopBotoes = THIS.Height - loc_nAlturaBtn - 15

        *-- Icone de erro (usando shape vermelha como indicador)
        THIS.AddObject("shp_4c_Icone", "Shape")
        WITH THIS.shp_4c_Icone
            .Top = 20
            .Left = 20
            .Width = 40
            .Height = 40
            .Curvature = 99
            .BackColor = RGB(220, 53, 69)
            .BorderStyle = 0
            .Visible = .T.
        ENDWITH

        *-- Label X no icone
        THIS.AddObject("lbl_4c_X", "Label")
        WITH THIS.lbl_4c_X
            .Top = 22
            .Left = 32
            .Width = 20
            .Height = 36
            .Caption = "X"
            .FontName = "Arial"
            .FontSize = 24
            .FontBold = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        *-- Mensagem de erro
        THIS.AddObject("edt_4c_Mensagem", "EditBox")
        WITH THIS.edt_4c_Mensagem
            .Top = 20
            .Left = 80
            .Width = THIS.Width - 100
            .Height = 120
            .FontName = "Consolas"
            .FontSize = 9
            .ReadOnly = .T.
            .ScrollBars = 2
            .BackColor = RGB(255, 255, 255)
            .Value = THIS.this_cMensagem
            .Visible = .T.
        ENDWITH

        *-- Calcular posicao dos botoes (centralizados)
        loc_nLeftInicial = (THIS.Width - (3 * loc_nLarguraBtn) - (2 * loc_nEspacamento)) / 2

        *-- Botao Fechar Aplicacao
        THIS.AddObject("cmd_4c_Fechar", "CommandButton")
        WITH THIS.cmd_4c_Fechar
            .Top = loc_nTopBotoes
            .Left = loc_nLeftInicial
            .Width = loc_nLarguraBtn
            .Height = loc_nAlturaBtn
            .Caption = "Fechar Aplica" + CHR(231) + CHR(227) + "o"
            .FontName = "Tahoma"
            .FontSize = 9
            .BackColor = RGB(220, 53, 69)
            .ForeColor = RGB(255, 255, 255)
            .Visible = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Fechar, "Click", THIS, "FecharAplicacao")

        *-- Botao Copiar Erro
        THIS.AddObject("cmd_4c_Copiar", "CommandButton")
        WITH THIS.cmd_4c_Copiar
            .Top = loc_nTopBotoes
            .Left = loc_nLeftInicial + loc_nLarguraBtn + loc_nEspacamento
            .Width = loc_nLarguraBtn
            .Height = loc_nAlturaBtn
            .Caption = "Copiar Erro"
            .FontName = "Tahoma"
            .FontSize = 9
            .Visible = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Copiar, "Click", THIS, "CopiarErro")

        *-- Botao Ok, Continuar
        THIS.AddObject("cmd_4c_Ok", "CommandButton")
        WITH THIS.cmd_4c_Ok
            .Top = loc_nTopBotoes
            .Left = loc_nLeftInicial + (2 * loc_nLarguraBtn) + (2 * loc_nEspacamento)
            .Width = loc_nLarguraBtn
            .Height = loc_nAlturaBtn
            .Caption = "Ok, Continuar"
            .FontName = "Tahoma"
            .FontSize = 9
            .Default = .T.
            .Visible = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Ok, "Click", THIS, "Continuar")

    ENDPROC

    *--------------------------------------------------------------------------
    * FecharAplicacao - Encerra o sistema completamente
    *--------------------------------------------------------------------------
    PROCEDURE FecharAplicacao()
        *-- Apenas fecha o dialog de erro (NAO encerra a aplicacao inteira)
        *-- CLEAR EVENTS encerraria o READ EVENTS de main.prg → QUIT
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * CopiarErro - Copia mensagem de erro para area de transferencia
    *--------------------------------------------------------------------------
    PROCEDURE CopiarErro()
        _CLIPTEXT = THIS.this_cMensagem

        MESSAGEBOX("Mensagem de erro copiada para a " + CHR(225) + "rea de transfer" + CHR(234) + "ncia!", ;
                   64, "Copiado")
    ENDPROC

    *--------------------------------------------------------------------------
    * Continuar - Fecha apenas a mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE Continuar()
        THIS.Release()
    ENDPROC

ENDDEFINE

*------------------------------------------------------------------------------
* MostrarErro - Funcao helper para exibir erro
* Parametros:
*   par_Mensagem - Mensagem de erro (string) OU objeto Exception
*   par_cTitulo  - Titulo da janela (opcional, ou contexto se par_Mensagem for Exception)
*
* Uso com string:
*   MostrarErro("Erro ao salvar", "Erro")
*
* Uso com Exception (extrai Message e LineNo automaticamente):
*   CATCH TO loEx
*       MostrarErro(loEx, "NomeMetodo")
*------------------------------------------------------------------------------
PROCEDURE MostrarErro(par_Mensagem, par_cTitulo)
    LOCAL loc_oForm, loc_cMensagemFinal, loc_cTituloFinal

    loc_cTituloFinal = "Erro"
    loc_cMensagemFinal = ""

    *-- Verifica se par_Mensagem eh um objeto Exception
    IF VARTYPE(par_Mensagem) = "O" AND !ISNULL(par_Mensagem)
        *-- Eh um objeto - extrair propriedades
        TRY
            *-- Montar mensagem com contexto, linha e message
            IF VARTYPE(par_cTitulo) = "C" AND !EMPTY(par_cTitulo)
                loc_cMensagemFinal = "Erro em: " + par_cTitulo + CHR(13)
            ENDIF

            *-- Adicionar LineNo se existir
            IF PEMSTATUS(par_Mensagem, "LineNo", 5)
                loc_cMensagemFinal = loc_cMensagemFinal + "Linha: " + TRANSFORM(par_Mensagem.LineNo) + CHR(13)
            ENDIF

            *-- Adicionar Message
            IF PEMSTATUS(par_Mensagem, "Message", 5)
                loc_cMensagemFinal = loc_cMensagemFinal + par_Mensagem.Message
            ELSE
                loc_cMensagemFinal = loc_cMensagemFinal + "Erro desconhecido"
            ENDIF

            *-- Adicionar Details se existir
            IF PEMSTATUS(par_Mensagem, "Details", 5) AND !EMPTY(par_Mensagem.Details)
                loc_cMensagemFinal = loc_cMensagemFinal + CHR(13) + "Detalhes: " + par_Mensagem.Details
            ENDIF

            *-- Adicionar Procedure se existir
            IF PEMSTATUS(par_Mensagem, "Procedure", 5) AND !EMPTY(par_Mensagem.Procedure)
                loc_cMensagemFinal = loc_cMensagemFinal + CHR(13) + "Procedure: " + par_Mensagem.Procedure
            ENDIF
        CATCH
            loc_cMensagemFinal = "Erro ao processar exce" + CHR(231) + CHR(227) + "o"
        ENDTRY
    ELSE
        *-- Eh uma string - usar diretamente
        loc_cMensagemFinal = par_Mensagem

        IF VARTYPE(par_cTitulo) = "C" AND !EMPTY(par_cTitulo)
            loc_cTituloFinal = par_cTitulo
        ENDIF
    ENDIF

    IF EMPTY(loc_cMensagemFinal)
        loc_cMensagemFinal = "Erro desconhecido"
    ENDIF

    *-- Em modo teste, gravar no arquivo e NAO mostrar dialog (evita TIMEOUT)
    IF TYPE("gb_4c_ModoTeste") = "L"
        IF gb_4c_ModoTeste
            *-- Converter CHR(13) para " | " para gravar em uma linha
            LOCAL loc_cMensagemLog
            loc_cMensagemLog = STRTRAN(loc_cMensagemFinal, CHR(13), " | ")
            EscreverErroParaArquivo(loc_cMensagemLog, loc_cTituloFinal)
            RETURN
        ENDIF
    ENDIF

    loc_oForm = CREATEOBJECT("FormErro", loc_cMensagemFinal, loc_cTituloFinal)
    loc_oForm.Show()
ENDPROC
