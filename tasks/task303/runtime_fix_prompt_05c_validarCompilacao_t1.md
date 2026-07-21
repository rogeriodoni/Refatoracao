# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05c_validarCompilacao
- Tentativa: 1/10
- Mensagem: C:\4c\projeto\app\classes\sigprimaBO.prg: IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd", @loc_cImagem) < 1 | Error in line 215: Missing operand. | IF SQLEXEC(gnConnHandle, loc_cSQL,  "cursor_4c_UpdPro", @loc_cImagem2) < 1 | Error in line 332: Missing operand. | 

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprima.prg):
*==============================================================================
* Formsigprima.prg
* Formulario: Importacao de Imagens de Produtos
* Tipo: OPERACIONAL (flat - sem PageFrame)
* Migrado de SIGPRIMA.SCX
*
* Pilares:
*   UX   -> layout PIXEL-PERFECT identico ao legado (Width=800, Height=200)
*   BD   -> SigCdPro / SigCdPrc / sigscjim
*   CODE -> arquitetura em camadas (FormBase / sigprimaBO)
*==============================================================================

DEFINE CLASS Formsigprima AS FormBase

    *-- Propriedades visuais (copiadas do SCX original)
    Height      = 200
    Width       = 800
    BorderStyle = 2
    AutoCenter  = .T.
    ShowTips    = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    DataSession = 2

    *-- Propriedades do form
    this_cMensagemErro = ""
    this_cTipo1        = ""   && modo de execucao: 'A'=automatico, ''=manual
    this_cPath1        = ""   && caminho do diretorio de imagens
    this_lModoAuto     = .F.  && .T. quando lcTipo1 == 'A'

    *==========================================================================
    * Init - Aceita parametros do chamador (lcTipo1, lcPath1)
    * Em modo automatico ('A'): executa processamento e fecha sem exibir form
    *==========================================================================
    PROCEDURE Init(par_cTipo1, par_cPath1)
        LOCAL loc_lSucesso

        *-- Armazenar parametros antes do DODEFAULT
        THIS.this_cTipo1    = UPPER(ALLTRIM(IIF(VARTYPE(par_cTipo1) = "C", par_cTipo1, "")))
        THIS.this_cPath1    = ADDBS(ALLTRIM(IIF(VARTYPE(par_cPath1) = "C", par_cPath1, "")))
        THIS.this_lModoAuto = (THIS.this_cTipo1 == "A")

        *-- Em modo automatico, validar diretorio antes de criar form
        IF THIS.this_lModoAuto AND !EMPTY(THIS.this_cPath1)
            IF !DIRECTORY(THIS.this_cPath1)
                MsgAviso("Diret" + CHR(243) + "rio de Importa" + CHR(231) + CHR(227) + ;
                         "o de Imagens Inv" + CHR(225) + "lido", "Pasta")
                RETURN .F.
            ENDIF
        ENDIF

        *-- Inicializar Business Object
        THIS.this_oBusinessObject = CREATEOBJECT("sigprimaBO")
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            MsgErro("Erro ao criar sigprimaBO.", "Erro")
            RETURN .F.
        ENDIF

        *-- FormBase.Init() -> InicializarForm()
        loc_lSucesso = DODEFAULT()
        IF !loc_lSucesso
            RETURN .F.
        ENDIF

        *-- Definir diretorio inicial no campo (criado em fase posterior)
        IF PEMSTATUS(THIS, "txt_4c_Arquivo", 5)
            IF VARTYPE(THIS.txt_4c_Arquivo) = "O"
                THIS.txt_4c_Arquivo.Value = THIS.this_cPath1
            ENDIF
        ENDIF

        *-- Modo automatico: executar processamento e fechar sem exibir form
        IF THIS.this_lModoAuto
            THIS.this_oBusinessObject.Processamento(THIS.this_cPath1, 1)
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * InicializarForm - Configura controles da interface
    *==========================================================================
    PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        TRY
            *-- Caption com acentos (via CHR - proibido literal acentuado em .PRG)
            THIS.Caption = "Importa" + CHR(231) + CHR(227) + "o de Imagens de Produtos"

            THIS.ConfigurarPageFrame()
            THIS.ConfigurarCabecalho()
            THIS.ConfigurarPaginaLista()
            THIS.ConfigurarPaginaDados()

            THIS.TornarControlesVisiveis()

            *-- Selecionar tipo padrao (Produtos) equivalente ao SCX original
            THIS.AlternarPagina(1)

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao inicializar form: " + loc_oErro.Message + ;
                    " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    " | Proc: " + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Ajusta imagem de fundo do Form
    * OPERACIONAL flat: sem PageFrame; mantido por consistencia com FormBase
    * e demais forms operacionais (Formsigprila/Formsigprico/FormSIGPRIFF)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_cImgFundo
        loc_cImgFundo = gc_4c_CaminhoIcones + "new_background.jpg"
        IF FILE(loc_cImgFundo)
            THIS.Picture = loc_cImgFundo
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Container cinza escuro com labels de titulo
    * Equivalente ao cntSombra do SCX original (Top=0, Height=80)
    *==========================================================================
    PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCnt, loc_cCaption
        loc_cCaption = "Importa" + CHR(231) + CHR(227) + "o de Imagens de Produtos"

        THIS.AddObject("cnt_4c_Sombra", "Container")
        loc_oCnt = THIS.cnt_4c_Sombra
        WITH loc_oCnt
            .Top        = 0
            .Left       = 0
            .Width      = THIS.Width
            .Height     = 80
            .BorderWidth = 0
            .BackColor  = RGB(100,100,100)
            .Visible    = .T.

            .AddObject("lbl_4c_LblSombra", "Label")
            WITH .lbl_4c_LblSombra
                .AutoSize      = .F.
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .Caption       = loc_cCaption
                .Height        = 40
                .Left          = 10
                .Top           = 18
                .Width         = THIS.Width
                .ForeColor     = RGB(0,0,0)
                .Visible       = .T.
            ENDWITH

            .AddObject("lbl_4c_LblTitulo", "Label")
            WITH .lbl_4c_LblTitulo
                .AutoSize      = .F.
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .Caption       = loc_cCaption
                .Height        = 46
                .Left          = 10
                .Top           = 17
                .Width         = THIS.Width
                .ForeColor     = RGB(255,255,255)
                .ToolTipText   = "T" + CHR(237) + "tulo do Formul" + CHR(225) + "rio"
                .Visible       = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles do form visiveis
    * (AddObject cria controles com Visible=.F. por padrao)
    *==========================================================================
    PROCEDURE TornarControlesVisiveis()
        LOCAL loc_nI, loc_oObjeto
        FOR loc_nI = 1 TO THIS.ControlCount
            loc_oObjeto = THIS.Controls(loc_nI)
            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND ;
                   loc_oObjeto.ControlCount > 0
                    THIS.TornarSubControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE TornarSubControlesVisiveis(par_oContainer)
    *==========================================================================
        LOCAL loc_nI, loc_oObjeto
        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND ;
                   loc_oObjeto.ControlCount > 0
                    THIS.TornarSubControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Configura o corpo do form (area operacional)
    *
    * OPERACIONAL flat: nao ha PageFrame; a "pagina lista" corresponde a
    * toda a area do form abaixo do cabecalho, onde ficam:
    *   - Botoes de acao (Processar / Encerrar) - lado direito
    *   - Campos de parametros (Diretorio, Tipo de importacao)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarBotoes()
        THIS.ConfigurarCampos()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Adiciona container decorativo de agrupamento
    * Equivalente ao Commandgroup3 do legado (ButtonCount=0, apenas visual):
    * borda de agrupamento ao redor dos botoes Processar/Encerrar.
    * Left=612, Top=7, Width=173, Height=110 / SpecialEffect=1 / ZOrder=1 (atras).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        THIS.AddObject("obj_4c_Commandgroup3", "Container")
        WITH THIS.obj_4c_Commandgroup3
            .Top          = 7
            .Left         = 612
            .Width        = 173
            .Height       = 110
            .BackStyle    = 0
            .BorderWidth  = 1
            .SpecialEffect = 1
            .BorderColor  = RGB(136,189,188)
            .Visible      = .T.
        ENDWITH
        *-- Enviar para tras dos botoes (cosm?tico - nao interfere em eventos)
        THIS.obj_4c_Commandgroup3.ZOrder(1)
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna o modo/tipo de importacao selecionado
    *
    * OPERACIONAL flat: nao ha paginas para alternar. Neste form, "alternar"
    * corresponde a selecionar um dos 3 tipos de importacao no OptionGroup:
    *   1 = Produtos, 2 = Auxiliar, 3 = Exportar
    * (equivalente semantico ao switch de pagina em forms CRUD)
    *==========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nTipo)
        IF VARTYPE(par_nTipo) = "N" AND BETWEEN(par_nTipo, 1, 3)
            IF PEMSTATUS(THIS, "obj_4c_OptTipo", 5) AND ;
               VARTYPE(THIS.obj_4c_OptTipo) = "O"
                THIS.obj_4c_OptTipo.Value = par_nTipo
                THIS.obj_4c_OptTipo.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Adiciona botoes de acao (Processar e Encerrar)
    * Posicionados na area direita do cabecalho (Top=3), identicos ao legado
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        *-- Botao Processar (equivalente ao btnProcessar fwbtng do legado)
        THIS.AddObject("cmd_4c_BtnProcessar", "CommandButton")
        WITH THIS.cmd_4c_BtnProcessar
            .Top             = 3
            .Left            = 650
            .Width           = 75
            .Height          = 75
            .Caption         = "Processar"
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90,90,90)
            .BackColor       = RGB(255,255,255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botao Encerrar (equivalente ao btnSair fwbtng do legado)
        THIS.AddObject("cmd_4c_BtnSair", "CommandButton")
        WITH THIS.cmd_4c_BtnSair
            .Top             = 3
            .Left            = 725
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90,90,90)
            .BackColor       = RGB(255,255,255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Cancel          = .T.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(THIS.cmd_4c_BtnProcessar, "Click", THIS, "CmdBtnProcessarClick")
        BINDEVENT(THIS.cmd_4c_BtnSair,      "Click", THIS, "CmdBtnSairClick")
    ENDPROC

    *==========================================================================
    * ConfigurarCampos - Adiciona campos operacionais: label, textbox diretorio,
    * botao browse "...", label tipo e OptionGroup de tipo de importacao
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCampos()
        *-- Label "Diretorio :"
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Diret" + CHR(243) + "rio :"
            .Height    = 15
            .Left      = 156
            .Top       = 113
            .Width     = 58
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox para o caminho do diretorio de imagens
        THIS.AddObject("txt_4c_Arquivo", "TextBox")
        WITH THIS.txt_4c_Arquivo
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = ""
            .Height        = 21
            .Left          = 216
            .SpecialEffect = 1
            .TabIndex      = 2
            .Top           = 110
            .Width         = 402
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        *-- Botao "..." para navegar e selecionar diretorio
        THIS.AddObject("cmd_4c_BtnArquivo", "CommandButton")
        WITH THIS.cmd_4c_BtnArquivo
            .Top       = 110
            .Left      = 622
            .Height    = 21
            .Width     = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .WordWrap  = .T.
            .Caption   = "..."
            .TabIndex  = 3
            .BackColor = RGB(255,255,255)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- Label "Tipo :"
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Tipo :"
            .Height    = 15
            .Left      = 182
            .Top       = 135
            .Width     = 32
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup para tipo de importacao (Produtos / Auxiliar / Exportar)
        THIS.AddObject("obj_4c_OptTipo", "OptionGroup")
        WITH THIS.obj_4c_OptTipo
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Height      = 63
            .Left        = 216
            .Top         = 129
            .Width       = 92
            .Visible     = .T.

            WITH .Buttons(1)
                .FontBold      = .T.
                .FontUnderline = .F.
                .BackStyle     = 0
                .Caption       = "Produtos"
                .Height        = 15
                .Left          = 5
                .Top           = 5
                .Width         = 69
                .AutoSize      = .T.
                .ForeColor     = RGB(90,90,90)
            ENDWITH

            WITH .Buttons(2)
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .FontUnderline = .F.
                .BackStyle     = 0
                .Caption       = "Auxiliar"
                .Height        = 15
                .Left          = 5
                .Top           = 24
                .Width         = 61
                .AutoSize      = .T.
                .ForeColor     = RGB(90,90,90)
            ENDWITH

            WITH .Buttons(3)
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Exportar"
                .Height    = 15
                .Left      = 5
                .Top       = 44
                .Width     = 67
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
            ENDWITH
        ENDWITH

        BINDEVENT(THIS.cmd_4c_BtnArquivo, "Click",    THIS, "CmdBtnArquivoClick")
        BINDEVENT(THIS.txt_4c_Arquivo,    "KeyPress", THIS, "TxtArquivoKeyPress")
    ENDPROC

    *==========================================================================
    * CmdBtnArquivoClick - Abre dialogo GetDir para selecionar diretorio
    *==========================================================================
    PROCEDURE CmdBtnArquivoClick()
        LOCAL loc_cDir
        THIS.txt_4c_Arquivo.Value = ""
        loc_cDir = GETDIR("C:\", ;
                          "Selecione o Diret" + CHR(243) + "rio Abaixo :", ;
                          "Sele" + CHR(231) + CHR(227) + "o de Diret" + CHR(243) + "rio de Imagens")
        IF !EMPTY(loc_cDir)
            THIS.txt_4c_Arquivo.Value = loc_cDir
        ENDIF
        THIS.txt_4c_Arquivo.Refresh()
    ENDPROC

    *==========================================================================
    * CmdBtnProcessarClick - Executa Exportar (tipo=3) ou Processamento (tipos 1/2)
    *==========================================================================
    PROCEDURE CmdBtnProcessarClick()
        LOCAL loc_cDir, loc_nTipo
        loc_cDir  = ALLTRIM(THIS.txt_4c_Arquivo.Value)
        loc_nTipo = THIS.obj_4c_OptTipo.Value

        IF EMPTY(loc_cDir)
            MsgAviso("O Diret" + CHR(243) + "rio N" + CHR(227) + "o Foi Informado!!!", ;
                     "Diret" + CHR(243) + "rio Inv" + CHR(225) + "lido")
            RETURN
        ENDIF

        IF loc_nTipo = 3
            THIS.this_oBusinessObject.Exportar(loc_cDir)
        ELSE
            THIS.this_oBusinessObject.Processamento(loc_cDir, loc_nTipo)
        ENDIF
    ENDPROC

    *==========================================================================
    * CmdBtnSairClick - Fecha o formulario
    *==========================================================================
    PROCEDURE CmdBtnSairClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * TxtArquivoKeyPress - Valida/corrige diretorio ao pressionar ENTER ou TAB
    *==========================================================================
    PROCEDURE TxtArquivoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF
        LOCAL loc_cDir
        loc_cDir = ALLTRIM(THIS.txt_4c_Arquivo.Value)
        IF !EMPTY(loc_cDir) AND !DIRECTORY(loc_cDir)
            loc_cDir = GETDIR("C:\", ;
                              "Selecione o Diret" + CHR(243) + "rio Abaixo :", ;
                              "Sele" + CHR(231) + CHR(227) + "o de Diret" + CHR(243) + "rio de Imagens")
        ENDIF
        THIS.txt_4c_Arquivo.Value = loc_cDir
        THIS.txt_4c_Arquivo.Refresh()
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Executa importacao (equivalente a "incluir" imagens)
    * Mapeamento semantico OPERACIONAL: Incluir = importar novas imagens
    * Valida diretorio e tipo, entao dispara Exportar (tipo 3) ou Processamento
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_cDir, loc_nTipo

        loc_cDir  = ALLTRIM(THIS.txt_4c_Arquivo.Value)
        loc_nTipo = THIS.obj_4c_OptTipo.Value

        IF EMPTY(loc_cDir)
            MsgAviso("O Diret" + CHR(243) + "rio N" + CHR(227) + "o Foi Informado!!!", ;
                     "Diret" + CHR(243) + "rio Inv" + CHR(225) + "lido")
            THIS.txt_4c_Arquivo.SetFocus()
            RETURN
        ENDIF

        IF !DIRECTORY(loc_cDir)
            MsgAviso("Diret" + CHR(243) + "rio inexistente: " + loc_cDir, ;
                     "Diret" + CHR(243) + "rio Inv" + CHR(225) + "lido")
            THIS.txt_4c_Arquivo.SetFocus()
            RETURN
        ENDIF

        IF loc_nTipo = 3
            THIS.this_oBusinessObject.Exportar(loc_cDir)
        ELSE
            THIS.this_oBusinessObject.Processamento(loc_cDir, loc_nTipo)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Re-processa importacao (mesmo fluxo do Incluir).
    * Form OPERACIONAL de importacao nao possui distincao entre inserir e
    * alterar - reprocessa as imagens do diretorio informado.
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        THIS.BtnIncluirClick()
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Valida configuracao sem executar importacao
    * Conta arquivos JPG no diretorio informado e exibe resumo para o usuario
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cDir, loc_nTipo, loc_cTipoDesc, loc_nArquivos
        LOCAL ARRAY loc_aArq(1)

        loc_cDir  = ALLTRIM(THIS.txt_4c_Arquivo.Value)
        loc_nTipo = THIS.obj_4c_OptTipo.Value

        IF EMPTY(loc_cDir)
            MsgAviso("O Diret" + CHR(243) + "rio N" + CHR(227) + "o Foi Informado!!!", ;
                     "Diret" + CHR(243) + "rio Inv" + CHR(225) + "lido")
            THIS.txt_4c_Arquivo.SetFocus()
            RETURN
        ENDIF

        IF !DIRECTORY(loc_cDir)
            MsgAviso("Diret" + CHR(243) + "rio inexistente: " + loc_cDir, ;
                     "Diret" + CHR(243) + "rio Inv" + CHR(225) + "lido")
            THIS.txt_4c_Arquivo.SetFocus()
            RETURN
        ENDIF

        loc_nArquivos = ADIR(loc_aArq, ADDBS(loc_cDir) + "*.JPG")
        loc_cTipoDesc = ICASE(loc_nTipo = 1, "Produtos", ;
                              loc_nTipo = 2, "Auxiliar", ;
                              loc_nTipo = 3, "Exportar", ;
                              "Desconhecido")

        MsgInfo("Diret" + CHR(243) + "rio: " + loc_cDir + CHR(13) + ;
                "Tipo: " + loc_cTipoDesc + CHR(13) + ;
                "Arquivos .JPG encontrados: " + TRANSFORM(loc_nArquivos), ;
                "Pr" + CHR(233) + "-visualiza" + CHR(231) + CHR(227) + "o")
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Limpa a configuracao atual (diretorio + tipo padrao)
    * Nao remove nenhum dado do banco - apenas reseta os campos da tela
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        IF MsgConfirma("Deseja limpar as sele" + CHR(231) + CHR(245) + "es atuais?")
            THIS.txt_4c_Arquivo.Value = ""
            THIS.obj_4c_OptTipo.Value = 1
            THIS.txt_4c_Arquivo.Refresh()
            THIS.obj_4c_OptTipo.Refresh()
            THIS.txt_4c_Arquivo.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Valida configuracao antes de disparar (equivalente
    * semantico de "buscar" nesse form OPERACIONAL: pre-visualiza contagem
    * de arquivos .JPG no diretorio informado). Reusa BtnVisualizarClick.
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario (alias semantico de CmdBtnSairClick)
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.CmdBtnSairClick()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Confirma execucao (alias semantico de CmdBtnProcessarClick).
    * Sincroniza dados do form para o BO e dispara Exportar/Processamento.
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_cDir, loc_nTipo

        THIS.FormParaBO()

        loc_cDir  = ALLTRIM(THIS.txt_4c_Arquivo.Value)
        loc_nTipo = THIS.obj_4c_OptTipo.Value

        IF EMPTY(loc_cDir)
            MsgAviso("O Diret" + CHR(243) + "rio N" + CHR(227) + "o Foi Informado!!!", ;
                     "Diret" + CHR(243) + "rio Inv" + CHR(225) + "lido")
            THIS.txt_4c_Arquivo.SetFocus()
            RETURN
        ENDIF

        IF !DIRECTORY(loc_cDir)
            MsgAviso("Diret" + CHR(243) + "rio inexistente: " + loc_cDir, ;
                     "Diret" + CHR(243) + "rio Inv" + CHR(225) + "lido")
            THIS.txt_4c_Arquivo.SetFocus()
            RETURN
        ENDIF

        IF loc_nTipo = 3
            THIS.this_oBusinessObject.Exportar(loc_cDir)
        ELSE
            THIS.this_oBusinessObject.Processamento(loc_cDir, loc_nTipo)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela operacao em andamento e limpa selecao atual
    * (reset dos campos + recarrega estado padrao). Nao fecha o formulario.
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
        THIS.CarregarLista()
        THIS.AjustarBotoesPorModo("LISTA")
    ENDPROC

    *==========================================================================
    * FormParaBO - Sincroniza valores dos controles da tela para o BO
    * Form OPERACIONAL: transfere diretorio e tipo de operacao selecionados
    *==========================================================================
    PROCEDURE FormParaBO()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_Arquivo", 5) AND VARTYPE(THIS.txt_4c_Arquivo) = "O"
            THIS.this_oBusinessObject.this_cDiretorio = ALLTRIM(THIS.txt_4c_Arquivo.Value)
        ENDIF

        IF PEMSTATUS(THIS, "obj_4c_OptTipo", 5) AND VARTYPE(THIS.obj_4c_OptTipo) = "O"
            THIS.this_oBusinessObject.this_nTipoOp = THIS.obj_4c_OptTipo.Value
        ENDIF

        THIS.this_oBusinessObject.this_cTipo1 = THIS.this_cTipo1
        RETURN .T.
    ENDPROC

    *==========================================================================
    * BOParaForm - Sincroniza valores do BO para os controles da tela
    * Form OPERACIONAL: restaura diretorio e tipo do BO nos controles
    *==========================================================================
    PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_Arquivo", 5) AND VARTYPE(THIS.txt_4c_Arquivo) = "O"
            THIS.txt_4c_Arquivo.Value = THIS.this_oBusinessObject.this_cDiretorio
            THIS.txt_4c_Arquivo.Refresh()
        ENDIF

        IF PEMSTATUS(THIS, "obj_4c_OptTipo", 5) AND VARTYPE(THIS.obj_4c_OptTipo) = "O"
            IF BETWEEN(THIS.this_oBusinessObject.this_nTipoOp, 1, 3)
                THIS.obj_4c_OptTipo.Value = THIS.this_oBusinessObject.this_nTipoOp
                THIS.obj_4c_OptTipo.Refresh()
            ENDIF
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita controles editaveis do form
    * conforme o modo atual (LISTA/DADOS/INCLUIR/ALTERAR/VISUALIZAR)
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab
        loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)

        IF PEMSTATUS(THIS, "txt_4c_Arquivo", 5) AND VARTYPE(THIS.txt_4c_Arquivo) = "O"
            THIS.txt_4c_Arquivo.Enabled = loc_lHab
        ENDIF

        IF PEMSTATUS(THIS, "obj_4c_OptTipo", 5) AND VARTYPE(THIS.obj_4c_OptTipo) = "O"
            THIS.obj_4c_OptTipo.Enabled = loc_lHab
        ENDIF

        IF PEMSTATUS(THIS, "cmd_4c_BtnArquivo", 5) AND VARTYPE(THIS.cmd_4c_BtnArquivo) = "O"
            THIS.cmd_4c_BtnArquivo.Enabled = loc_lHab
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Reseta os controles editaveis para valores default
    *==========================================================================
    PROCEDURE LimparCampos()
        IF PEMSTATUS(THIS, "txt_4c_Arquivo", 5) AND VARTYPE(THIS.txt_4c_Arquivo) = "O"
            THIS.txt_4c_Arquivo.Value = ""
            THIS.txt_4c_Arquivo.Refresh()
        ENDIF

        IF PEMSTATUS(THIS, "obj_4c_OptTipo", 5) AND VARTYPE(THIS.obj_4c_OptTipo) = "O"
            THIS.obj_4c_OptTipo.Value = 1
            THIS.obj_4c_OptTipo.Refresh()
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_cDiretorio = ""
            THIS.this_oBusinessObject.this_nTipoOp    = 1
            THIS.this_oBusinessObject.this_lSucesso   = .F.
            THIS.this_oBusinessObject.this_cMsgFinal  = ""
        ENDIF
    ENDPROC

    *==========================================================================
    * CarregarLista - Restaura o estado padrao dos campos operacionais
    * Form OPERACIONAL flat: nao ha grid de listagem; o metodo cumpre
    * o contrato semantico de "carregar estado inicial" pos-BtnCancelar
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF PEMSTATUS(THIS, "txt_4c_Arquivo", 5) AND VARTYPE(THIS.txt_4c_Arquivo) = "O"
            IF !EMPTY(THIS.this_cPath1)
                THIS.txt_4c_Arquivo.Value = THIS.this_cPath1
            ENDIF
            THIS.txt_4c_Arquivo.Refresh()
        ENDIF

        IF PEMSTATUS(THIS, "obj_4c_OptTipo", 5) AND VARTYPE(THIS.obj_4c_OptTipo) = "O"
            THIS.obj_4c_OptTipo.Refresh()
        ENDIF

        loc_lSucesso = .T.
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta Enabled dos botoes conforme o modo atual
    * Form OPERACIONAL: apenas 2 botoes de acao (Processar/Encerrar) sempre
    * habilitados; metodo cumpre o contrato dos forms CRUD para consistencia
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo(par_cModo)
        LOCAL loc_cModo, loc_lEditavel
        loc_cModo = UPPER(ALLTRIM(IIF(VARTYPE(par_cModo) = "C", par_cModo, "LISTA")))
        loc_lEditavel = (loc_cModo != "VISUALIZAR")

        IF PEMSTATUS(THIS, "cmd_4c_BtnProcessar", 5) AND ;
           VARTYPE(THIS.cmd_4c_BtnProcessar) = "O"
            THIS.cmd_4c_BtnProcessar.Enabled = loc_lEditavel
        ENDIF

        IF PEMSTATUS(THIS, "cmd_4c_BtnSair", 5) AND VARTYPE(THIS.cmd_4c_BtnSair) = "O"
            THIS.cmd_4c_BtnSair.Enabled = .T.
        ENDIF

        THIS.HabilitarCampos(loc_lEditavel)
    ENDPROC

    *==========================================================================
    * Unload - Chamado ao encerrar o form
    * Em modo automatico: limpa loop de eventos para scripts batch
    *==========================================================================
    PROCEDURE Unload()
        IF THIS.this_lModoAuto
            CLEAR EVENTS
        ENDIF
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * Destroy - Libera recursos
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigprimaBO.prg):
*====================================================================
* sigprimaBO.prg
* Business Object: Importacao/Exportacao de Imagens de Produtos
* Tabela principal: sigscjim
* Formulario OPERACIONAL
*====================================================================

DEFINE CLASS sigprimaBO AS BusinessBase

    *-- Tabela e chave (sigscjim)
    this_cTabela      = "sigscjim"
    this_cCampoChave  = "cidchaves"

    *-- Campos da tabela sigscjim
    this_cCidchaves = ""    && char(20) - chave primaria
    this_cCpros     = ""    && char(14) - codigo do produto (FK SigCdPro)
    this_nIdimagem  = 0     && numeric(38,0) - id imagem
    this_cRefforref = ""    && char(50) - referencia do fornecedor

    *-- Parametros de operacao (passados via Init do form)
    this_cDiretorio = ""    && caminho do diretorio de imagens
    this_nTipoOp    = 1     && 1=Produtos, 2=Auxiliar(sigscjim), 3=Exportar
    this_cTipo1     = ""    && modo de execucao: 'A'=automatico, ''=manual

    *-- Resultado do processamento
    this_lSucesso   = .F.   && resultado do ultimo processamento
    this_cMsgFinal  = ""    && mensagem resultado a exibir

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "sigscjim"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria
    *====================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidchaves
    ENDFUNC

    *====================================================================
    * ValidarDados - Valida dados antes de inserir/atualizar
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        IF EMPTY(THIS.this_cCpros)
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo do produto obrigat" + CHR(243) + "rio."
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades a partir do cursor sigscjim
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidchaves = TratarNulo(cidchaves, "C")
            THIS.this_cCpros     = TratarNulo(cpros,     "C")
            THIS.this_nIdimagem  = TratarNulo(idimagem,  "N")
            THIS.this_cRefforref = TratarNulo(refforref, "C")
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - Insere registro na tabela sigscjim
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            THIS.this_cCidchaves = fUniqueIds()
            loc_cSQL = "INSERT INTO sigscjim " + ;
                       "(cidchaves, cpros, idimagem, refforref) VALUES (" + ;
                       EscaparSQL(THIS.this_cCidchaves) + ", " + ;
                       EscaparSQL(THIS.this_cCpros)     + ", " + ;
                       FormatarNumeroSQL(THIS.this_nIdimagem, 0) + ", " + ;
                       EscaparSQL(THIS.this_cRefforref) + ;
                       ")"
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("I")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir registro em sigscjim."
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro na tabela sigscjim
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE sigscjim SET " + ;
                       "cpros     = " + EscaparSQL(THIS.this_cCpros)               + ", " + ;
                       "idimagem  = " + FormatarNumeroSQL(THIS.this_nIdimagem, 0)  + ", " + ;
                       "refforref = " + EscaparSQL(THIS.this_cRefforref)           + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("A")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar registro em sigscjim."
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Processamento - Importa imagens JPG para produtos (SigCdPro) ou
    *                 registros auxiliares (sigscjim)
    * par_cDiretorio - diretorio com as imagens JPG
    * par_nTipo      - 1=Produtos, 2=Auxiliar(sigscjim)
    *====================================================================
    PROCEDURE Processamento(par_cDiretorio, par_nTipo)
        LOCAL loc_lSucesso, loc_cDir, loc_nTip, loc_nArq, loc_oErro
        LOCAL loc_oProgress, loc_nImg, loc_cImg, loc_cPro
        LOCAL loc_cDpro2, loc_cDpro3, loc_cReff, loc_cFig
        LOCAL loc_cSQL, loc_cQuery, loc_cMsg, loc_cDok, loc_cNom
        LOCAL loc_cArq, loc_cAok, loc_nCnt, loc_lVer, loc_lArq
        LOCAL loc_cImagem, loc_cImagem2, loc_cChave, loc_cOrigem
        LOCAL loc_nExiste
        LOCAL ARRAY loc_aArq(1)

        loc_lSucesso = .F.
        loc_cDir     = ADDBS(ALLTRIM(par_cDiretorio))
        loc_nTip     = IIF(VARTYPE(par_nTipo) = "N", par_nTipo, 1)

        TRY
            IF EMPTY(loc_cDir)
                MsgAviso("O Diret" + CHR(243) + "rio N" + CHR(227) + "o Foi Informado!!!", ;
                         "Diret" + CHR(243) + "rio Inv" + CHR(225) + "lido")
                THIS.this_lSucesso  = .F.
                THIS.this_cMsgFinal = "Diret" + CHR(243) + "rio n" + CHR(227) + "o informado."
                loc_lSucesso = .F.
            ENDIF

            loc_nArq = ADIR(loc_aArq, loc_cDir + "*.JPG")

            IF loc_nArq < 1
                MsgAviso("O Diret" + CHR(243) + "rio N" + CHR(227) + "o Cont" + CHR(233) + "m Nenhuma Imagem do Tipo .JPG!!!", ;
                         "Arquivos Inv" + CHR(225) + "lidos")
                THIS.this_lSucesso  = .F.
                THIS.this_cMsgFinal = "Nenhuma imagem .JPG encontrada."
                loc_lSucesso = .F.
            ENDIF

            loc_oProgress = CREATEOBJECT("fwprogressbar", "Processando Imagens...", loc_nArq)
            loc_oProgress.Show()

            loc_lSucesso = .T.

            FOR loc_nImg = 1 TO loc_nArq
                IF !loc_lSucesso
                    EXIT
                ENDIF

                loc_cImg  = ALLTRIM(loc_aArq(loc_nImg, 1))
                loc_lArq  = !(LEFT(loc_aArq(loc_nImg, 5), 1) = "R")

                loc_cPro   = PADR(SUBSTR(loc_cImg, 1, AT(".JPG", UPPER(loc_cImg)) - 1), 14)
                loc_cDpro2 = SUBSTR(loc_cImg, 1, AT(".JPG", UPPER(loc_cImg)) - 1)
                loc_cDpro3 = SUBSTR(loc_cImg, 1, AT(".JPG", UPPER(loc_cImg)) - 1)
                loc_cReff  = SUBSTR(loc_cImg, 1, AT(".JPG", UPPER(loc_cImg)) - 1)

                loc_oProgress.SubTitulo.Caption = "Arquivo : " + ALLTRIM(loc_cImg)
                loc_oProgress.Update(.T.)

                IF loc_lArq
                    loc_cFig = loc_cDir + loc_cImg

                    IF FILE(loc_cFig)

                        IF loc_nTip = 2
                            *-- Modo auxiliar: busca em sigscjim por idimagem
                            loc_cQuery = "SELECT * FROM sigscjim WHERE idimagem = " + ;
                                         ALLTRIM(loc_cPro) + " ORDER BY CPros"

                            IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_LocalPro") < 1
                                MsgErro("Favor Reinicializar o Processo!!!", ;
                                        "Falha na Conex" + CHR(227) + "o (LocalPro)")
                                loc_lSucesso = .F.
                            ENDIF

                            IF loc_lSucesso AND USED("cursor_4c_LocalPro") AND RECCOUNT("cursor_4c_LocalPro") > 0
                                SELECT cursor_4c_LocalPro
                                GO TOP IN cursor_4c_LocalPro
                                SCAN
                                    IF loc_lSucesso
                                        SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

                                        loc_cImagem = FILETOSTR(loc_cFig)
                                        loc_cSQL    = "UPDATE sigscjim SET Imagem = ? " + ;
                                                      "WHERE idimagem = " + ALLTRIM(loc_cPro) + ;
                                                      " AND CPros = " + EscaparSQL(cursor_4c_LocalPro.CPros)

                                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd", @loc_cImagem) < 1
                                            MsgErro("N" + CHR(227) + "o Foi Poss" + CHR(237) + ;
                                                    "vel Atualizar o Arquivo SigScjIm!!!", ;
                                                    "Processamento Cancelado!!!")
                                            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                            loc_lSucesso = .F.
                                        ELSE
                                            SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                                        ENDIF

                                        IF USED("cursor_4c_Upd")
                                            USE IN cursor_4c_Upd
                                        ENDIF
                                    ENDIF
                                ENDSCAN
                            ENDIF

                            IF USED("cursor_4c_LocalPro")
                                USE IN cursor_4c_LocalPro
                            ENDIF

                        ELSE
                            *-- Modo produtos: busca em SigCdPro por CPros/descricao/referencia

                            *-- Tentativa 1: busca por CPros
                            loc_cQuery = "SELECT * FROM SigCdPro WHERE CPros = " + ;
                                         EscaparSQL(loc_cPro) + " ORDER BY CPros"
                            IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_LocalPro") < 1
                                MsgErro("Favor Reinicializar o Processo!!!", ;
                                        "Falha na Conex" + CHR(227) + "o (LocalPro)")
                                loc_lSucesso = .F.
                            ENDIF

                            *-- Tentativa 2: busca por dPro2s
                            IF loc_lSucesso AND USED("cursor_4c_LocalPro") AND ;
                               RECCOUNT("cursor_4c_LocalPro") = 0
                                IF USED("cursor_4c_LocalPro")
                                    USE IN cursor_4c_LocalPro
                                ENDIF
                                loc_cQuery = "SELECT * FROM SigCdPro WHERE dPro2s = " + ;
                                             EscaparSQL(ALLTRIM(loc_cDpro2)) + " ORDER BY CPros"
                                IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_LocalPro") < 1
                                    MsgErro("Favor Reinicializar o Processo!!!", ;
                                            "Falha na Conex" + CHR(227) + "o (LocalPro)")
                                    loc_lSucesso = .F.
                                ENDIF
                            ENDIF

                            *-- Tentativa 3: busca por dPro2s sem pontos
                            IF loc_lSucesso AND USED("cursor_4c_LocalPro") AND ;
                               RECCOUNT("cursor_4c_LocalPro") = 0
                                IF USED("cursor_4c_LocalPro")
                                    USE IN cursor_4c_LocalPro
                                ENDIF
                                loc_cQuery = "SELECT * FROM SigCdPro WHERE dPro2s = " + ;
                                             EscaparSQL(ALLTRIM(STRTRAN(loc_cDpro2, ".", ""))) + ;
                                             " ORDER BY CPros"
                                IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_LocalPro") < 1
                                    MsgErro("Favor Reinicializar o Processo!!!", ;
                                            "Falha na Conex" + CHR(227) + "o (LocalPro)")
                                    loc_lSucesso = .F.
                                ENDIF
                            ENDIF

                            *-- Tentativa 4: busca por reffs (referencia fornecedor)
                            IF loc_lSucesso AND USED("cursor_4c_LocalPro") AND ;
                               RECCOUNT("cursor_4c_LocalPro") = 0
                                IF USED("cursor_4c_LocalPro")
                                    USE IN cursor_4c_LocalPro
                                ENDIF
                                loc_cQuery = "SELECT * FROM SigCdPro WHERE reffs = " + ;
                                             EscaparSQL(ALLTRIM(loc_cReff)) + " ORDER BY CPros"
                                IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_LocalPro") < 1
                                    MsgErro("Favor Reinicializar o Processo!!!", ;
                                            "Falha na Conex" + CHR(227) + "o (LocalPro)")
                                    loc_lSucesso = .F.
                                ENDIF
                            ENDIF

                            *-- Tentativa 5: busca por dPro3s (descricao completa)
                            IF loc_lSucesso AND USED("cursor_4c_LocalPro") AND ;
                               RECCOUNT("cursor_4c_LocalPro") = 0
                                IF USED("cursor_4c_LocalPro")
                                    USE IN cursor_4c_LocalPro
                                ENDIF
                                loc_cQuery = "SELECT * FROM SigCdPro " + ;
                                             "WHERE CONVERT(VARCHAR(50),dPro3s) = " + ;
                                             EscaparSQL(ALLTRIM(STRTRAN(loc_cDpro3, ".", ""))) + ;
                                             " ORDER BY CPros"
                                IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_LocalPro") < 1
                                    MsgErro("Favor Reinicializar o Processo!!!", ;
                                            "Falha na Conex" + CHR(227) + "o (LocalPro)")
                                    loc_lSucesso = .F.
                                ENDIF
                            ENDIF

                            IF loc_lSucesso AND USED("cursor_4c_LocalPro") AND ;
                               RECCOUNT("cursor_4c_LocalPro") > 0
                                SELECT cursor_4c_LocalPro
                                GO TOP IN cursor_4c_LocalPro
                                SCAN
                                    IF loc_lSucesso
                                        loc_cPro = cursor_4c_LocalPro.CPros

                                        SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

                                        *-- UPDATE SigCdPro com imagem
                                        loc_cImagem2 = FILETOSTR(loc_cFig)
                                        loc_cSQL = "UPDATE SigCdPro SET " + ;
                                                   "FigJpgs = ?, " + ;
                                                   "DtFilms = GETDATE(), " + ;
                                                   "Datas = GETDATE(), " + ;
                                                   "Flagctabs = 1, " + ;
                                                   "Transps = 0 " + ;
                                                   "WHERE CPros = " + EscaparSQL(loc_cPro)

                                        IF SQLEXEC(gnConnHandle, loc_cSQL, ;
                                                   "cursor_4c_UpdPro", @loc_cImagem2) < 1
                                            MsgErro("N" + CHR(227) + "o Foi Poss" + CHR(237) + ;
                                                    "vel Atualizar o Arquivo SigCdPro!!!", ;
                                                    "Processamento Cancelado!!!")
                                            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                            loc_lSucesso = .F.
                                        ENDIF

                                        IF USED("cursor_4c_UpdPro")
                                            USE IN cursor_4c_UpdPro
                                        ENDIF

                                        *-- UPDATE/INSERT SigCdPrc com dados de auditoria
                                        IF loc_lSucesso
                                            loc_cChave  = fUniqueIds()
                                            loc_cOrigem = LEFT(TTOC(DATETIME()) + " SIGPRIMA", 50)

                                            IF SQLEXEC(gnConnHandle, ;
                                                "SELECT COUNT(1) AS nExiste FROM SigCdPrc " + ;
                                                "WHERE CPros = " + EscaparSQL(loc_cPro), ;
                                                "cursor_4c_ExistePrc") > 0 AND ;
                                               USED("cursor_4c_ExistePrc")
                                                SELECT cursor_4c_ExistePrc
                                                loc_nExiste = NVL(nExiste, 0)
                                                USE IN cursor_4c_ExistePrc
                                            ELSE
                                                loc_nExiste = 0
                                            ENDIF

                                            IF loc_nExiste > 0
                                                loc_cSQL = "UPDATE SigCdPrc SET " + ;
                                                           "DataAlts = GETDATE(), " + ;
                                                           "HoraAlts = " + EscaparSQL(TIME()) + ", " + ;
                                                           "UsuaAlts = " + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ", " + ;
                                                           "Origem   = " + EscaparSQL(loc_cOrigem) + ;
                                                           " WHERE CPros = " + EscaparSQL(loc_cPro)
                                            ELSE
                                                loc_cSQL = "INSERT INTO SigCdPrc " + ;
                                                           "(cIdChaves, CPros, DataAlts, " + ;
                                                           "HoraAlts, UsuaAlts, Origem) VALUES (" + ;
                                                           EscaparSQL(loc_cChave)                      + ", " + ;
                                                           EscaparSQL(loc_cPro)                        + ", " + ;
                                                           "GETDATE(), "                               + ;
                                                           EscaparSQL(TIME())                          + ", " + ;
                                                           EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado))    + ", " + ;
                                                           EscaparSQL(loc_cOrigem)                     + ;
                                                           ")"
                                            ENDIF

                                            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                                                MsgErro("N" + CHR(227) + "o Foi Poss" + CHR(237) + ;
                                                        "vel Atualizar o Arquivo SigCdPrc!!!", ;
                                                        "Processamento Cancelado!!!")
                                                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                                loc_lSucesso = .F.
                                            ENDIF
                                        ENDIF

                                        *-- DELETE FROM SigPrPrt
                                        IF loc_lSucesso
                                            loc_cSQL = "DELETE FROM SigPrPrt WHERE CPros = " + ;
                                                       EscaparSQL(loc_cPro)
                                            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                                                MsgErro("Favor Reinicializar o Processo!!!", ;
                                                        "Falha na Conex" + CHR(227) + "o (SigPrPrt)")
                                                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                                loc_lSucesso = .F.
                                            ENDIF
                                        ENDIF

                                        IF loc_lSucesso
                                            SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                                        ELSE
                                            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                        ENDIF
                                    ENDIF
                                ENDSCAN

                                *-- Move arquivo para subpasta OK apos processamento
                                IF loc_lSucesso
                                    loc_cDok = loc_cDir + "OK\"
                                    IF !DIRECTORY(loc_cDok)
                                        MD (loc_cDok)
                                    ENDIF

                                    IF !DIRECTORY(loc_cDok)
                                        MsgAviso("O Diret" + CHR(243) + "rio [" + loc_cDok + ;
                                                 "] N" + CHR(227) + "o Pode Ser Criado!!!", ;
                                                 "Diret" + CHR(243) + "rio Inv" + CHR(225) + "lido")
                                        loc_lSucesso = .F.
                                    ELSE
                                        loc_cNom = ALLTRIM(loc_aArq(loc_nImg, 1))
                                        loc_lArq = !(LEFT(loc_aArq(loc_nImg, 5), 1) = "R")
                                        IF loc_lArq
                                            loc_cArq = loc_cDir + loc_cNom
                                            loc_cAok = ALLTRIM(loc_cDok) + "\" + ALLTRIM(loc_cNom)
                                            loc_nCnt = 0
                                            loc_lVer = .T.
                                            DO WHILE loc_lVer
                                                IF !FILE(loc_cAok)
                                                    loc_lVer = .F.
                                                    COPY FILE (loc_cArq) TO (loc_cAok)
                                                    IF FILE(loc_cAok)
                                                        DELETE FILE (loc_cArq)
                                                    ENDIF
                                                ELSE
                                                    loc_nCnt = loc_nCnt + 1
                                                    loc_cAok = loc_cDok + "\" + loc_cNom + "." + ;
                                                               PADL(loc_nCnt, 4, "0")
                                                ENDIF
                                            ENDDO
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF

                            IF USED("cursor_4c_LocalPro")
                                USE IN cursor_4c_LocalPro
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            NEXT

            loc_oProgress.Complete()

            IF !loc_lSucesso
                loc_cMsg = "Os Arquivos N" + CHR(227) + "o Foram Importados!!!"
            ELSE
                loc_cMsg = "Os Arquivos Foram Importados!!!"
            ENDIF

            MsgInfo(loc_cMsg, "Processamento Conclu" + CHR(237) + "do!!!")

            THIS.this_lSucesso  = loc_lSucesso
            THIS.this_cMsgFinal = loc_cMsg

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_lSucesso  = .F.
            THIS.this_cMsgFinal = loc_oErro.Message
        ENDTRY

        RETURN THIS.this_lSucesso
    ENDPROC

    *====================================================================
    * Exportar - Exporta imagens de produtos para arquivos JPG e
    *            converte para base64 (campo FigJpgs64)
    * par_cDiretorio - diretorio destino para os arquivos exportados
    *====================================================================
    PROCEDURE Exportar(par_cDiretorio)
        LOCAL loc_lSucesso, loc_cDir, loc_cMsg, loc_cQuery, loc_oErro
        LOCAL loc_cPro, loc_cFiltro, loc_cImag, loc_cSQL

        loc_lSucesso = .F.
        loc_cDir     = ADDBS(ALLTRIM(par_cDiretorio))
        loc_cFiltro  = ""

        TRY
            IF EMPTY(loc_cDir)
                MsgAviso("O Diret" + CHR(243) + "rio N" + CHR(227) + "o Foi Informado!!!", ;
                         "Diret" + CHR(243) + "rio Inv" + CHR(225) + "lido")
                THIS.this_lSucesso  = .F.
                THIS.this_cMsgFinal = "Diret" + CHR(243) + "rio n" + CHR(227) + "o informado."
                loc_lSucesso = .F.
            ENDIF

            *-- Busca grupos de produtos com imagem
            loc_cQuery = "SELECT cgrus, COUNT(1) AS qtd FROM sigcdpro " + ;
                         "WHERE 0=0 " + loc_cFiltro + ;
                         " GROUP BY cgrus ORDER BY 2"

            IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_Grupos") < 1
                MsgErro("Favor Reinicializar o Processo!!!", ;
                        "Falha na Conex" + CHR(227) + "o (Grupos)")
                THIS.this_lSucesso  = .F.
                THIS.this_cMsgFinal = "Falha ao buscar grupos."
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = .T.

            SELECT cursor_4c_Grupos
            GO TOP IN cursor_4c_Grupos
            SCAN
                WAIT WINDOW "Atualizando o Grupo " + cursor_4c_Grupos.cgrus NOWAIT

                *-- Busca produtos do grupo
                loc_cQuery = "SELECT * FROM sigcdpro WHERE cgrus = " + ;
                             EscaparSQL(cursor_4c_Grupos.cgrus) + " " + loc_cFiltro
                IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_LocalPro") < 1
                    MsgErro("Favor Reinicializar o Processo!!!", ;
                            "Falha na Conex" + CHR(227) + "o (Produtos)")
                    loc_lSucesso = .F.
                ENDIF

                IF loc_lSucesso AND USED("cursor_4c_LocalPro")
                    SELECT cursor_4c_LocalPro
                    GO TOP IN cursor_4c_LocalPro

                    SCAN
                        *-- Pula produtos sem imagem
                        IF EMPTY(cursor_4c_LocalPro.FigJpgs)
                            SELECT cursor_4c_LocalPro
                            LOOP
                        ENDIF

                        *-- Pula produtos que ja tem base64
                        IF !EMPTY(cursor_4c_LocalPro.FigJpgs64)
                            SELECT cursor_4c_LocalPro
                            LOOP
                        ENDIF

                        *-- Exporta imagem para arquivo
                        loc_cPro = ALLTRIM(STRTRAN(STRTRAN(STRTRAN( ;
                                   cursor_4c_LocalPro.cpros, "*", "_"), "/", "-"), "\", "-"))
                        STRTOFILE(cursor_4c_LocalPro.FigJpgs, ;
                                  loc_cDir + loc_cPro + ".jpg", .T.)

                        *-- Converte para base64 e atualiza FigJpgs64
                        loc_cImag = STRCONV(cursor_4c_LocalPro.FigJpgs, 13, 1046)

                        loc_cSQL = "UPDATE SigCdPro SET " + ;
                                   "FigJpgs64 = " + EscaparSQL("data:image/jpeg;base64," + loc_cImag) + ", " + ;
                                   "DtFilms   = GETDATE(), " + ;
                                   "Datas     = GETDATE(), " + ;
                                   "Flagctabs = 1, " + ;
                                   "Transps   = 0 " + ;
                                   "WHERE CPros = " + EscaparSQL(cursor_4c_LocalPro.cpros)

                        SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
                        IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                            SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                        ELSE
                            MsgErro("N" + CHR(227) + "o Foi Poss" + CHR(237) + ;
                                    "vel Atualizar o Arquivo SigCdPro!!!", ;
                                    "Processamento Cancelado!!!")
                            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                            loc_lSucesso = .F.
                        ENDIF

                        SELECT cursor_4c_LocalPro
                    ENDSCAN

                    IF USED("cursor_4c_LocalPro")
                        USE IN cursor_4c_LocalPro
                    ENDIF
                ENDIF

                SELECT cursor_4c_Grupos
            ENDSCAN

            IF USED("cursor_4c_Grupos")
                USE IN cursor_4c_Grupos
            ENDIF

            IF !loc_lSucesso
                loc_cMsg = "N" + CHR(227) + "o houve exporta" + CHR(231) + CHR(227) + "o!!!"
            ELSE
                loc_cMsg = "Exporta" + CHR(231) + CHR(227) + "o executada com sucesso!!!"
            ENDIF

            MsgInfo(loc_cMsg, "Processamento Conclu" + CHR(237) + "do!!!")

            THIS.this_lSucesso  = loc_lSucesso
            THIS.this_cMsgFinal = loc_cMsg

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_lSucesso  = .F.
            THIS.this_cMsgFinal = loc_oErro.Message
        ENDTRY

        RETURN THIS.this_lSucesso
    ENDPROC

ENDDEFINE

