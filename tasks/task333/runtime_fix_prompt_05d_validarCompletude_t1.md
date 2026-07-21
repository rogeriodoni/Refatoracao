# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[SigPrSndBO.prg] Indicador de pendencia: * BuscarPendente
[FormSigPrSnd.prg] Procedure vazia (sem codigo): FormParaBO
[FormSigPrSnd.prg] Procedure vazia (sem codigo): BOParaForm
[FormSigPrSnd.prg] Procedure vazia (sem codigo): ConfigurarPaginaDados
[FormSigPrSnd.prg] Indicador de pendencia: *-- Container de botoes operacionais (Senhas Pendente
[FormSigPrSnd.prg] Indicador de pendencia: * CmdSenPendClick - Exibe senhas pendente
[FormSigPrSnd.prg] Indicador de pendencia: * BtnVisualizarClick - Exibe senhas pendente

IMPORTANTE: Preencha TODAS as procedures vazias com codigo funcional REAL. NAO use TODO, FIXME, PLACEHOLDER ou comentarios de pendencia. Cada procedure deve ter implementacao completa.

## CONTEXTO DO ERRO


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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrSnd.prg):
*==============================================================================
* FORMSIGPRSND.PRG - Formulario Operacional: Senhas Livres
* Tipo: OPERACIONAL (flat - sem PageFrame CRUD)
* Migrado de SIGPRSND.SCX
*
* Pilares:
*   UX   -> layout fiel ao legado (botoes no topo, grid de senhas, textbox qtd)
*   BD   -> cursor crSigPrSnd (SigPrSnd)
*   CODE -> arquitetura em camadas (FormBase / SigPrSndBO)
*==============================================================================

DEFINE CLASS FormSigPrSnd AS FormBase

    *-- Propriedades visuais (escalado de 500x324 para 1000x600)
    Height       = 600
    Width        = 1000
    BorderStyle  = 2
    AutoCenter   = .T.
    ShowTips     = .T.
    TitleBar     = 0
    ShowWindow = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .F.
    DataSession  = 2
    WindowType   = 1
    FontName     = "Tahoma"
    FontSize     = 8

    *-- Business Object
    this_oBusinessObject = .NULL.

    *==========================================================================
    PROCEDURE Init
    *==========================================================================
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm
    *==========================================================================
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.Caption = "Senhas livres"

            *-- Criar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrSndBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar SigPrSndBO", "Erro")
            ELSE
                *-- Configurar picture de fundo do form
                THIS.ConfigurarPageFrame()

                *-- Cabecalho cinza escuro com titulo
                THIS.ConfigurarCabecalho()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Botao Encerrar (padrao canonico Left=917)
                THIS.ConfigurarSaida()

                *-- Controles principais (grid + campos + botoes operacionais)
                THIS.ConfigurarPaginaLista()

                *-- Tornar controles visiveis (AddObject cria com Visible=.F.)
                THIS.TornarControlesVisiveis()

                *-- Vincular eventos
                THIS.VincularEventos()

                *-- Carregar dados iniciais do cursor SigPrSnd
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.this_oBusinessObject.Buscar("")
                    THIS.AtualizarGrid()
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar FormSigPrSnd: " + loc_oErro.Message + ;
                    " Ln=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " Proc=" + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame
    *==========================================================================
        *-- Form OPERACIONAL flat (sem PageFrame CRUD) - configura picture de fundo
        LOCAL loc_cImgFundo
        loc_cImgFundo = gc_4c_CaminhoBase + "Framework\imagens\new_background.jpg"
        IF FILE(loc_cImgFundo)
            THIS.Picture = loc_cImgFundo
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho
    *==========================================================================
        LOCAL loc_nW
        loc_nW = THIS.Width

        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = loc_nW
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
            .AutoSize  = .F.
            .Width     = loc_nW
            .Height    = 40
            .Top       = 18
            .Left      = 10
            .Caption   = ""
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .WordWrap  = .T.
            .Alignment = 0
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .AutoSize  = .F.
            .Width     = loc_nW
            .Height    = 46
            .Top       = 17
            .Left      = 10
            .Caption   = ""
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(255, 255, 255)
            .WordWrap  = .T.
            .Alignment = 0
        ENDWITH

        THIS.cnt_4c_Cabecalho.Visible = .T.
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarSaida
    *==========================================================================
        *-- Padrao canonico OPERACIONAL: Top=4, Left=917, Width=90, Height=85
        *-- Botoes de acao (btnExcel/btnGerSen) ficam a esquerda do Encerrar
        THIS.AddObject("cnt_4c_Saida", "Container")
        WITH THIS.cnt_4c_Saida
            .Top         = 4
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cnt_4c_Saida.cmd_4c_Encerrar
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Themes          = .F.
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .SpecialEffect   = 0
            .PicturePosition = 13
            .WordWrap        = .T.
            .MousePointer    = 15
            .Cancel          = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista
    *==========================================================================
        *-- Container de botoes operacionais (Senhas Pendentes, Excel, Gerar Senha)
        *-- Posicionados no topo, a esquerda do Encerrar
        *-- Proporcional ao legado: legado tinha 3 botoes em 500px (Left~275-425)
        *-- Em 1000px: botoes ficam na faixa Left=100..900
        THIS.AddObject("cnt_4c_Botoes", "Container")
        WITH THIS.cnt_4c_Botoes
            .Top         = 4
            .Left        =  542
            .Width       = 560
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Botoes.AddObject("cmd_4c_SenPend", "CommandButton")
        WITH THIS.cnt_4c_Botoes.cmd_4c_SenPend
            .Top             = 5
            .Left            = 5
            .Width           = 170
            .Height          = 75
            .Caption         = "Senhas pendentes"
            .Picture         = gc_4c_CaminhoIcones + "geral_lupa_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_lupa_60.jpg"
            .Themes          = .F.
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .SpecialEffect   = 0
            .PicturePosition = 13
            .WordWrap        = .T.
            .MousePointer    = 15
        ENDWITH

        THIS.cnt_4c_Botoes.AddObject("cmd_4c_Excel", "CommandButton")
        WITH THIS.cnt_4c_Botoes.cmd_4c_Excel
            .Top             = 5
            .Left            = 185
            .Width           = 170
            .Height          = 75
            .Caption         = "Excel"
            .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
            .Themes          = .F.
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .SpecialEffect   = 0
            .PicturePosition = 13
            .WordWrap        = .T.
            .MousePointer    = 15
        ENDWITH

        THIS.cnt_4c_Botoes.AddObject("cmd_4c_GerSen", "CommandButton")
        WITH THIS.cnt_4c_Botoes.cmd_4c_GerSen
            .Top             = 5
            .Left            = 365
            .Width           = 170
            .Height          = 75
            .Caption         = "Gerar Senha"
            .Picture         = gc_4c_CaminhoIcones + "geral_chaves_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_chaves_60.jpg"
            .Themes          = .F.
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .SpecialEffect   = 0
            .PicturePosition = 13
            .WordWrap        = .T.
            .MousePointer    = 15
        ENDWITH

        *-- Label e TextBox para quantidade de senhas
        *-- Original: Label3 Top=87 Left=54 / getqtdsen Top=84 Left=152 (forma 500px)
        *-- Escalado para 1000px: mesmas proporcoes
        THIS.AddObject("lbl_4c_QtdSen", "Label")
        WITH THIS.lbl_4c_QtdSen
            .Caption   = "Qtde de Senhas :"
            .AutoSize  = .F.
            .Width     = 100
            .Height    = 23
            .Top       = 100
            .Left      = 100
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_Qtdsen", "TextBox")
        WITH THIS.txt_4c_Qtdsen
            .Value         = 0
            .Format        = "K"
            .InputMask     = ""
            .MaxLength     = 3
            .Width         = 60
            .Height        = 23
            .Top           = 97
            .Left          = 210
            .Alignment     = 3
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .SpecialEffect = 1
            .Themes        = .F.
        ENDWITH

        *-- Grid de senhas geradas
        *-- Original: grdSenha Top=110 Left=48 Width=140 Height=162 (500px)
        *-- Em 1000px: proporcional mas com mais espaco
        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .Top               = 140
            .Left              = 100
            .Width             = 280
            .Height            = 420
            .ColumnCount       = 1
            .FontSize          = 8
            .FontName          = "Verdana"
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .HeaderHeight      = 16
            .RowHeight         = 16
            .ScrollBars        = 2
            .GridLineColor     = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle    = 2
        ENDWITH

        THIS.grd_4c_Dados.Column1.Width       = 260
        THIS.grd_4c_Dados.Column1.ColumnOrder = 1
        THIS.grd_4c_Dados.Column1.ReadOnly    = .T.
        THIS.grd_4c_Dados.Column1.FontSize    = 8
        THIS.grd_4c_Dados.Column1.Header1.Caption   = "Senhas geradas"
        THIS.grd_4c_Dados.Column1.Header1.FontName  = "Verdana"
        THIS.grd_4c_Dados.Column1.Header1.FontSize  = 8
        THIS.grd_4c_Dados.Column1.Header1.Alignment = 2
        THIS.grd_4c_Dados.Column1.Header1.ForeColor = RGB(36, 84, 155)
        *-- Text1.When retorna .F. (somente leitura na UI)
        THIS.grd_4c_Dados.Column1.Sparse = .F.
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE VincularEventos
    *==========================================================================
        BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "CmdEncerrarClick")
        BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_SenPend, "Click", THIS, "CmdSenPendClick")
        BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Excel,   "Click", THIS, "CmdExcelClick")
        BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_GerSen,  "Click", THIS, "CmdGerSenClick")
    ENDPROC

    *==========================================================================
    * AtualizarGrid - Vincula cursor ao grid e reconfigura ControlSource
    *==========================================================================
    PROCEDURE AtualizarGrid()
        LOCAL loc_oGrid
        loc_oGrid = THIS.grd_4c_Dados
        IF VARTYPE(loc_oGrid) != "O"
            RETURN
        ENDIF
        loc_oGrid.RecordSource = ""
        IF USED("crSigPrSnd")
            loc_oGrid.ColumnCount              = 1
            loc_oGrid.RecordSource             = "crSigPrSnd"
            loc_oGrid.Column1.ControlSource    = "crSigPrSnd.Senhads"
            loc_oGrid.Column1.Header1.Caption  = "Senhas geradas"
            loc_oGrid.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * CmdEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE CmdEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * CmdSenPendClick - Exibe senhas pendentes (EmpDopNums vazio)
    *==========================================================================
    PROCEDURE CmdSenPendClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.this_oBusinessObject.BuscarPendentes()
                THIS.AtualizarGrid()
                loc_lSucesso = .T.
            ELSE
                MsgAviso("Nenhuma senha pendente encontrada.", "Senhas Pendentes")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar senhas pendentes: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CmdExcelClick - Exporta senhas geradas para planilha Excel ou TXT
    *==========================================================================
    PROCEDURE CmdExcelClick()
        LOCAL loc_cArquivo, loc_lErro
        loc_cArquivo = ""
        loc_lErro    = .F.

        TRY
            IF !USED("crSigPrSnd") OR RECCOUNT("crSigPrSnd") = 0
                MsgAviso("Nenhuma senha para exportar.", "Excel")
            ELSE
                *-- Cria cursor temporario somente com a coluna Senhads
                SELECT Senhads AS Senhas FROM crSigPrSnd INTO CURSOR TmpPrSnd READWRITE
                SELECT TmpPrSnd

                loc_cArquivo = PUTFILE("Nome da Planilha", "", "XLS;TXT")

                IF !EMPTY(loc_cArquivo)
                    IF LOWER(ALLTRIM(JUSTEXT(loc_cArquivo))) = "xls"
                        COPY TO (loc_cArquivo) TYPE XL5
                    ELSE
                        COPY TO (loc_cArquivo) DELIMITED WITH "" WITH CHARACTER ";"
                    ENDIF

                    IF FILE(loc_cArquivo)
                        MsgInfo("Arquivo gerado com sucesso.", "Gera" + CHR(231) + CHR(227) + "o de Planilha")
                    ELSE
                        loc_lErro = .T.
                    ENDIF
                ENDIF

                IF USED("TmpPrSnd")
                    USE IN TmpPrSnd
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_lErro = .T.
            IF USED("TmpPrSnd")
                USE IN TmpPrSnd
            ENDIF
            MsgErro("Erro ao gerar planilha: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF loc_lErro
            MsgAviso("Falha na Gera" + CHR(231) + CHR(227) + "o da Planilha." + ;
                     " Verifique o diret" + CHR(243) + "rio ou planilha em uso.", ;
                     "Gera" + CHR(231) + CHR(227) + "o de Planilha")
        ENDIF
    ENDPROC

    *==========================================================================
    * CmdGerSenClick - Gera N senhas livres e insere em SigPrSnd
    *==========================================================================
    PROCEDURE CmdGerSenClick()
        LOCAL loc_nQtd, loc_lSucesso, loc_lEntradaOk
        loc_lSucesso   = .F.
        loc_lEntradaOk = .T.

        TRY
            loc_nQtd = THIS.txt_4c_Qtdsen.Value

            IF VARTYPE(loc_nQtd) != "N" OR loc_nQtd <= 0
                MsgAviso("Qtde de senhas obrigat" + CHR(243) + "rio.", "Aviso")
                THIS.txt_4c_Qtdsen.SetFocus()
                loc_lEntradaOk = .F.
            ENDIF

            IF loc_lEntradaOk
                loc_lSucesso = THIS.this_oBusinessObject.GerarSenhas(loc_nQtd)

                IF loc_lSucesso
                    THIS.AtualizarGrid()
                    THIS.txt_4c_Qtdsen.Value = 0
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao gerar senhas: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Novo registro: gera novas senhas livres.
    * Neste form OPERACIONAL, "Incluir" = gerar senhas (equivalente ao Gerar Senha).
    * Se a Qtde ainda nao foi informada, foca o TextBox para o usuario digitar.
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_nQtd
        loc_nQtd = 0
        IF PEMSTATUS(THIS, "txt_4c_Qtdsen", 5)
            loc_nQtd = THIS.txt_4c_Qtdsen.Value
        ENDIF
        IF VARTYPE(loc_nQtd) != "N" OR loc_nQtd <= 0
            MsgAviso("Informe a Qtde de senhas antes de incluir.", "Aviso")
            IF PEMSTATUS(THIS, "txt_4c_Qtdsen", 5)
                THIS.txt_4c_Qtdsen.SetFocus()
            ENDIF
        ELSE
            THIS.CmdGerSenClick()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Atualiza a lista exibida no grid.
    * Neste form OPERACIONAL nao ha edicao de senhas geradas (auto-geradas
    * pelo sistema), entao "Alterar" recarrega o cursor a partir do banco
    * para refletir eventuais mudancas concorrentes.
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.this_oBusinessObject.Buscar("")
                THIS.AtualizarGrid()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar lista: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Exibe senhas pendentes (equivalente ao SenPend).
    * Delega para CmdSenPendClick que carrega registros com EmpDopNums vazio.
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        THIS.CmdSenPendClick()
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Exclui a senha atualmente selecionada no grid.
    * Le cidchaves do cursor, confirma com o usuario e chama BO.Excluir().
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_lSucesso, loc_cId, loc_cSenha
        loc_lSucesso = .F.
        TRY
            IF !USED("crSigPrSnd") OR RECCOUNT("crSigPrSnd") = 0
                MsgAviso("Nenhuma senha selecionada.", "Excluir")
            ELSE
                SELECT crSigPrSnd
                loc_cId    = TratarNulo(crSigPrSnd.cidchaves, "C")
                loc_cSenha = TratarNulo(crSigPrSnd.senhads,   "C")

                IF EMPTY(loc_cId)
                    MsgAviso("Registro sem identificador. Sele" + CHR(231) + ;
                             CHR(227) + "o inv" + CHR(225) + "lida.", "Excluir")
                ELSE
                    IF MsgConfirma("Confirma exclus" + CHR(227) + "o da senha " + ;
                                   ALLTRIM(loc_cSenha) + "?", "Excluir Senha")
                        *-- Cursor crSigPrSnd ja tem o registro selecionado
                        IF THIS.this_oBusinessObject.CarregarDoCursor("crSigPrSnd")
                            IF THIS.this_oBusinessObject.Excluir()
                                THIS.this_oBusinessObject.Buscar("")
                                THIS.AtualizarGrid()
                                MsgInfo("Senha exclu" + CHR(237) + "da com sucesso.", "Excluir")
                                loc_lSucesso = .T.
                            ENDIF
                        ELSE
                            MsgErro("Falha ao carregar registro para exclus" + CHR(227) + "o.", "Excluir")
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir senha: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario (alias canonico para CmdEncerrarClick)
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.CmdEncerrarClick()
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Recarrega todas as senhas do cursor
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.this_oBusinessObject.Buscar("")
                THIS.AtualizarGrid()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar senhas: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Equivale a acionar Gerar Senha neste form OPERACIONAL
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.CmdGerSenClick()
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Limpa campos e volta ao estado inicial
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega/recarrega o cursor e atualiza o grid
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.this_oBusinessObject.Buscar("")
                THIS.AtualizarGrid()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar lista: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * FormParaBO - Popula BO com dados do formulario
    * Neste OPERACIONAL o unico dado editavel pelo usuario eh a quantidade
    *==========================================================================
    PROCEDURE FormParaBO()
        *-- Nao ha campos CRUD editaveis neste OPERACIONAL.
        *-- GerarSenhas() le txt_4c_Qtdsen.Value diretamente antes de chamar o BO.
        *-- Usuario e empresa sao populados pelo BO via variaveis globais.
    ENDPROC

    *==========================================================================
    * BOParaForm - Popula campos do formulario a partir do BO
    * Neste OPERACIONAL nao ha campos de edicao mapeados ao BO
    *==========================================================================
    PROCEDURE BOParaForm()
        *-- Nenhum campo editavel mapeado para CRUD.
        *-- Grid eh atualizado via AtualizarGrid() que le crSigPrSnd diretamente.
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita controles conforme modo
    * OPERACIONAL: controles sempre habilitados
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab
        loc_lHab = .T.
        IF VARTYPE(par_lHabilitar) = "L"
            loc_lHab = par_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_Qtdsen", 5)
            THIS.txt_4c_Qtdsen.Enabled = loc_lHab
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_Botoes", 5)
            THIS.cnt_4c_Botoes.cmd_4c_SenPend.Enabled = loc_lHab
            THIS.cnt_4c_Botoes.cmd_4c_Excel.Enabled   = loc_lHab
            THIS.cnt_4c_Botoes.cmd_4c_GerSen.Enabled  = loc_lHab
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Reseta campos para estado inicial
    *==========================================================================
    PROCEDURE LimparCampos()
        IF PEMSTATUS(THIS, "txt_4c_Qtdsen", 5)
            THIS.txt_4c_Qtdsen.Value = 0
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - OPERACIONAL: todos os botoes permanecem habilitados
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        THIS.HabilitarCampos(.T.)
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis
    *==========================================================================
        LPARAMETERS par_oContainer
        LOCAL loc_oContainer, loc_i, loc_oControl

        IF VARTYPE(par_oContainer) = "O"
            loc_oContainer = par_oContainer
        ELSE
            loc_oContainer = THIS
        ENDIF

        FOR loc_i = 1 TO loc_oContainer.ControlCount
            loc_oControl = loc_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * AlternarPagina - Form OPERACIONAL flat: nao ha PageFrame CRUD
    * Atualiza o grid com os dados mais recentes do cursor
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        THIS.AtualizarGrid()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Form OPERACIONAL flat: nao ha Page2
    * Legado SIGPRSND tem tela unica com botoes no topo + textbox qtde + grid.
    * Todos os campos (lbl_4c_QtdSen, txt_4c_Qtdsen, grd_4c_Dados) estao em
    * ConfigurarPaginaLista(). Metodo mantido por compatibilidade com pipeline.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados
        *-- Sem Page2 neste form OPERACIONAL. Delegado ao layout flat.
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy
    *==========================================================================
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        IF USED("crSigPrSnd")
            USE IN crSigPrSnd
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrSndBO.prg):
*==============================================================================
* SigPrSndBO.prg - Business Object: Senhas Livres
* Tabela: SigPrSnd
* Chave: cidchaves char(20)
*==============================================================================
DEFINE CLASS SigPrSndBO AS BusinessBase

    *-- Configuracao da tabela
    this_cTabela      = "SigPrSnd"
    this_cCampoChave  = "cidchaves"

    *-- Propriedades mapeadas para colunas de SigPrSnd
    this_cCidChaves   = ""   && cidchaves char(20) PK NOT NULL
    this_dDatas       = {}   && datas     datetime NULL
    this_nDocs        = 0    && docs      numeric(10,0) NOT NULL
    this_cHoras       = ""   && horas     char(8) NOT NULL
    this_cMotivos     = ""   && motivos   char(40) NOT NULL
    this_cOperas      = ""   && operas    char(20) NOT NULL
    this_cSenhads     = ""   && senhads   char(6) NOT NULL
    this_cSolicits    = ""   && solicits  char(10) NOT NULL
    this_cUsuars      = ""   && usuars    char(10) NOT NULL
    this_nValors      = 0    && valors    numeric(11,2) NOT NULL
    this_nTipos       = 0    && tipos     numeric(1,0) NOT NULL
    this_cEmps        = ""   && emps      char(3) NOT NULL
    this_cFpags       = ""   && fpags     char(12) NOT NULL
    this_cEmpDopNums  = ""   && empdopnums char(29) NOT NULL
    this_nPerlimite   = 0    && perlimite numeric(5,2) NOT NULL

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigPrSnd"
        THIS.this_cCampoChave = "cidchaves"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Inicializa cursor vazio com estrutura de SigPrSnd
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.
        TRY
            *-- Query que retorna 0 registros para criar cursor estruturado vazio
            loc_cSQL = "SELECT * FROM SigPrSnd WHERE cidchaves = " + ;
                EscaparSQL(REPLICATE(CHR(254), 20))
            IF USED("crSigPrSnd")
                USE IN crSigPrSnd
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigPrSnd") > 0
                SELECT crSigPrSnd
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves  = TratarNulo(cidchaves,  "C")
                THIS.this_dDatas      = TratarNulo(datas,      "D")
                THIS.this_nDocs       = TratarNulo(docs,       "N")
                THIS.this_cHoras      = TratarNulo(horas,      "C")
                THIS.this_cMotivos    = TratarNulo(motivos,    "C")
                THIS.this_cOperas     = TratarNulo(operas,     "C")
                THIS.this_cSenhads    = TratarNulo(senhads,    "C")
                THIS.this_cSolicits   = TratarNulo(solicits,   "C")
                THIS.this_cUsuars     = TratarNulo(usuars,     "C")
                THIS.this_nValors     = TratarNulo(valors,     "N")
                THIS.this_nTipos      = TratarNulo(tipos,      "N")
                THIS.this_cEmps       = TratarNulo(emps,       "C")
                THIS.this_cFpags      = TratarNulo(fpags,      "C")
                THIS.this_cEmpDopNums = TratarNulo(empdopnums, "C")
                THIS.this_nPerlimite  = TratarNulo(perlimite,  "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO SigPrSnd (todas as colunas NOT NULL)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cCidChaves = THIS.GerarIdUnico()
            ENDIF
            loc_cSQL = "INSERT INTO SigPrSnd " + ;
                "(cidchaves, usuars, datas, tipos, senhads, horas, " + ;
                " emps, docs, motivos, operas, solicits, valors, fpags, empdopnums, perlimite) " + ;
                "VALUES (" + ;
                EscaparSQL(THIS.this_cCidChaves)              + ", " + ;
                EscaparSQL(LEFT(THIS.this_cUsuars, 10))       + ", " + ;
                "GETDATE(), "                                          + ;
                FormatarNumeroSQL(THIS.this_nTipos, 0)        + ", " + ;
                EscaparSQL(LEFT(THIS.this_cSenhads, 6))       + ", " + ;
                EscaparSQL(LEFT(THIS.this_cHoras, 8))         + ", " + ;
                EscaparSQL(LEFT(THIS.this_cEmps, 3))          + ", " + ;
                FormatarNumeroSQL(THIS.this_nDocs, 0)         + ", " + ;
                EscaparSQL(LEFT(THIS.this_cMotivos, 40))      + ", " + ;
                EscaparSQL(LEFT(THIS.this_cOperas, 20))       + ", " + ;
                EscaparSQL(LEFT(THIS.this_cSolicits, 10))     + ", " + ;
                FormatarNumeroSQL(THIS.this_nValors, 2)       + ", " + ;
                EscaparSQL(LEFT(THIS.this_cFpags, 12))        + ", " + ;
                EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29))   + ", " + ;
                FormatarNumeroSQL(THIS.this_nPerlimite, 2)    + ;
                ")"
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("I")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir senha em SigPrSnd.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigPrSnd
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigPrSnd SET " + ;
                "usuars     = " + EscaparSQL(LEFT(THIS.this_cUsuars, 10))     + ", " + ;
                "datas      = " + FormatarDataSQL(THIS.this_dDatas)           + ", " + ;
                "tipos      = " + FormatarNumeroSQL(THIS.this_nTipos, 0)      + ", " + ;
                "senhads    = " + EscaparSQL(LEFT(THIS.this_cSenhads, 6))     + ", " + ;
                "horas      = " + EscaparSQL(LEFT(THIS.this_cHoras, 8))       + ", " + ;
                "emps       = " + EscaparSQL(LEFT(THIS.this_cEmps, 3))        + ", " + ;
                "docs       = " + FormatarNumeroSQL(THIS.this_nDocs, 0)       + ", " + ;
                "motivos    = " + EscaparSQL(LEFT(THIS.this_cMotivos, 40))    + ", " + ;
                "operas     = " + EscaparSQL(LEFT(THIS.this_cOperas, 20))     + ", " + ;
                "solicits   = " + EscaparSQL(LEFT(THIS.this_cSolicits, 10))   + ", " + ;
                "valors     = " + FormatarNumeroSQL(THIS.this_nValors, 2)     + ", " + ;
                "fpags      = " + EscaparSQL(LEFT(THIS.this_cFpags, 12))      + ", " + ;
                "empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29)) + ", " + ;
                "perlimite  = " + FormatarNumeroSQL(THIS.this_nPerlimite, 2)  + " "  + ;
                "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("A")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar senha em SigPrSnd.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE FROM SigPrSnd
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "DELETE FROM SigPrSnd " + ;
                "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("E")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir senha de SigPrSnd.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarPendentes - Carrega senhas pendentes (EmpDopNums vazio)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarPendentes()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT * FROM SigPrSnd WHERE EmpDopNums = ''"
            IF USED("crSigPrSnd")
                USE IN crSigPrSnd
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigPrSnd") > 0
                SELECT crSigPrSnd
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarSenhas - Gera N senhas livres e insere em SigPrSnd
    *--------------------------------------------------------------------------
    PROCEDURE GerarSenhas(par_nQtd)
        LOCAL loc_lSucesso, loc_n, loc_nSenha, loc_cSenha, loc_cId
        LOCAL loc_cSQL, loc_cChaves, loc_lTransacao, loc_lErroSQL
        loc_lSucesso   = .F.
        loc_cChaves    = ""
        loc_lTransacao = .F.
        loc_lErroSQL   = .F.
        TRY
            IF VARTYPE(par_nQtd) != "N" OR par_nQtd <= 0
                MsgAviso("Quantidade de senhas inv" + CHR(225) + "lida.", "Aviso")
            ELSE
                IF MsgConfirma("Deseja realmente gerar " + ;
                    ALLTRIM(STR(par_nQtd)) + " senhas livres?", "Gerar Senha")
                    SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
                    loc_lTransacao = .T.
                    FOR loc_n = 1 TO par_nQtd
                        IF !loc_lErroSQL
                            *-- Gera senha unica nao existente em SigPrSnd
                            loc_nSenha = 0
                            DO WHILE loc_nSenha = 0
                                loc_nSenha = THIS.GerarSenhaAleatoria()
                                loc_cSenha = STR(loc_nSenha, 6)
                                IF THIS.SenhaExisteSQL(loc_cSenha)
                                    loc_nSenha = 0
                                ENDIF
                            ENDDO
                            loc_cId  = THIS.GerarIdUnico()
                            loc_cSQL = "INSERT INTO SigPrSnd " + ;
                                "(cidchaves, usuars, datas, tipos, senhads, horas, " + ;
                                " emps, docs, motivos, operas, solicits, valors, fpags, empdopnums, perlimite) " + ;
                                "VALUES (" + ;
                                EscaparSQL(loc_cId) + ", " + ;
                                EscaparSQL(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)) + ", " + ;
                                "GETDATE(), " + ;
                                "0, " + ;
                                EscaparSQL(loc_cSenha) + ", " + ;
                                EscaparSQL(LEFT(TIME(), 8)) + ", " + ;
                                EscaparSQL(LEFT(ALLTRIM(go_4c_Sistema.cCodEmpresa), 3)) + ", " + ;
                                "0, '', '', '', 0, '', '', 0" + ;
                                ")"
                            IF SQLEXEC(gnConnHandle, loc_cSQL) <= 0
                                MsgErro("Erro ao gravar senha " + ALLTRIM(loc_cSenha) + ".", "Erro")
                                loc_lErroSQL = .T.
                            ELSE
                                IF EMPTY(loc_cChaves)
                                    loc_cChaves = "'" + loc_cId + "'"
                                ELSE
                                    loc_cChaves = loc_cChaves + ",'" + loc_cId + "'"
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDFOR
                    IF loc_lErroSQL
                        SQLEXEC(gnConnHandle, "ROLLBACK")
                        loc_lTransacao = .F.
                    ELSE
                        SQLEXEC(gnConnHandle, "COMMIT")
                        loc_lTransacao = .F.
                        *-- Recarrega cursor com as senhas recem geradas
                        IF USED("crSigPrSnd")
                            USE IN crSigPrSnd
                        ENDIF
                        loc_cSQL = "SELECT * FROM SigPrSnd WHERE cidchaves IN (" + loc_cChaves + ")"
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigPrSnd") > 0
                            SELECT crSigPrSnd
                            GO TOP
                        ENDIF
                        MsgInfo("Favor anotar as senhas geradas.", "Senhas Livres")
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF loc_lTransacao
                SQLEXEC(gnConnHandle, "ROLLBACK")
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SenhaExisteSQL - Verifica se senha ja existe em SigPrSnd
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION SenhaExisteSQL(par_cSenha)
        LOCAL loc_lExiste, loc_cSQL, loc_nCount
        loc_lExiste = .F.
        TRY
            loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigPrSnd WHERE SenhaDs = " + ;
                EscaparSQL(par_cSenha)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SenhaCheck") > 0
                IF USED("cursor_4c_SenhaCheck")
                    loc_nCount  = cursor_4c_SenhaCheck.nExiste
                    loc_lExiste = NVL(loc_nCount, 0) > 0
                    USE IN cursor_4c_SenhaCheck
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarSenhaAleatoria - Gera numero aleatorio de 6 digitos (100000-999999)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarSenhaAleatoria()
        RETURN INT(RAND() * 900000) + 100000
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarIdUnico - Gera identificador unico de 20 caracteres para cidchaves
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarIdUnico()
        LOCAL loc_cId
        loc_cId = SYS(2015) + SYS(2015)
        RETURN LEFT(loc_cId, 20)
    ENDFUNC

ENDDEFINE

