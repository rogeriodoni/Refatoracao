# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[FormSigPrMdc.prg] Procedure vazia (sem codigo): ConfigurarPaginaDados

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrMdc.prg):
*==============================================================================
* Classe  : FormSigPrMdc
* Herda de: FormBase
* Descricao: Formulario operacional Muda Conta - altera codigos de conta
*            em multiplas tabelas do banco conforme catalogo ArqDBF.
*            Form OPERACIONAL - layout flat sem PageFrame.
*==============================================================================
DEFINE CLASS FormSigPrMdc AS FormBase

    Caption      = "Muda Conta"
    Width        = 1000
    Height       = 600
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    KeyPreview   = .T.
    DataSession  = 2
    WindowType   = 1

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Flag: nao validar conta contra SigCdCli (parametro pCheckCad do legado)
    this_lCheckCadPro    = .F.

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame
    * Configura aparencia base do form (fundo, fontes, cores).
    * Para forms OPERACIONAIS sem PageFrame, este metodo define o Picture
    * e propriedades globais do form.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.Picture    = gc_4c_CaminhoIcones + "new_background.jpg"
        THIS.ScrollBars = 0
        THIS.ShowTips   = .F.
        THIS.SetAll("FontName", "Tahoma")
        THIS.SetAll("FontSize", 8)
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm
    * Chamado por FormBase.Init() - cria BO, monta layout de containers base.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            *-- Configurar aparencia base do form
            THIS.ConfigurarPageFrame()

            *-- Criar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrMdcBO")
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_lCheckCadPro = THIS.this_lCheckCadPro
                IF THIS.this_oBusinessObject.InicializarCursorContas()
                    THIS.ConfigurarCabecalho()
                    THIS.ConfigurarBotoes()
                    THIS.ConfigurarContainerResultado()
                    THIS.ConfigurarPaginaLista()

                    *-- Tornar controles visiveis (exceto cnt_4c_Resultado que eh flutuante)
                    THIS.TornarControlesVisiveis(THIS)

                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao inicializar cursor de contas.", "Erro")
                ENDIF
            ELSE
                MsgErro("Erro ao criar SigPrMdcBO." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "Erro em InicializarForm")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - cabecalho cinza com titulo (cntSombra do legado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
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
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width - 20
            .Height    = 40
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .BackStyle = 0
            .Caption   = THIS.Caption
            .ForeColor = RGB(0, 0, 0)
        ENDWITH
        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .Top       = 17
            .Left      = 10
            .Width     = THIS.Width - 20
            .Height    = 46
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .BackStyle = 0
            .Caption   = THIS.Caption
            .ForeColor = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes
    * Container para os botoes de acao (Incluir, Excluir, Importar, Processar,
    * Encerrar). Fica logo abaixo do cabecalho, cobrindo toda a largura.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_oCnt
        THIS.AddObject("cnt_4c_Botoes", "Container")
        loc_oCnt = THIS.cnt_4c_Botoes
        WITH loc_oCnt
            .Top         = 80
            .Left        =  542
            .Width       = THIS.Width
            .Height      = 90
            .BackStyle   = 0
            .BorderWidth = 0
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainerResultado
    * Painel de progresso de processamento (cntResult do legado).
    * Inicialmente oculto; exibido durante btnProcessar quando chkReps=.F.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainerResultado()
        LOCAL loc_oCnt
        THIS.AddObject("cnt_4c_Resultado", "Container")
        loc_oCnt = THIS.cnt_4c_Resultado
        WITH loc_oCnt
            .Top         = 170
            .Left        = 490
            .Width       = 297
            .Height      = 183
            .BackStyle   = 1
            .BackColor   = RGB(255, 255, 255)
            .SpecialEffect = 0
            .BorderWidth = 1
            .Visible     = .F.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarProgresso
    * Chamado pelo BO (ProcessarMudancaContas) para atualizar a UI em tempo
    * real durante o processamento.
    * par_cArquivo: nome do arquivo/campo em processamento
    * par_nPct    : percentual concluido 0-100
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarProgresso(par_cArquivo, par_nPct)
        LOCAL loc_nLargura
        loc_nLargura = 0
        TRY
            IF VARTYPE(THIS.cnt_4c_Resultado) = "O" AND THIS.cnt_4c_Resultado.Visible
                THIS.cnt_4c_Resultado.txt_4c_Arquivo.Value = par_cArquivo
                THIS.cnt_4c_Resultado.txt_4c_Arquivo.Refresh
                loc_nLargura = INT((par_nPct * 275) / 100)
                THIS.cnt_4c_Resultado.cnt_4c_Barra.shp_4c_Barra.Width = loc_nLargura
                THIS.cnt_4c_Resultado.cnt_4c_Barra.lbl_4c_Porcento.Caption = ;
                    ALLTRIM(TRANSFORM(par_nPct)) + " %"
                THIS.cnt_4c_Resultado.cnt_4c_Barra.Refresh
            ENDIF
        CATCH TO loc_oErro
            *-- progresso nao e critico, pular silenciosamente
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis
    * Torna controles Visible=.T. apos AddObject (que cria com Visible=.F.).
    * EXCECAO: cnt_4c_Resultado permanece oculto (container flutuante); seus
    * filhos sao visitados recursivamente para render correto ao exibir.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oCtrl
        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oCtrl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oCtrl) = "O"
                IF UPPER(loc_oCtrl.Name) = "CNT_4C_RESULTADO"
                    THIS.TornarControlesVisiveis(loc_oCtrl)
                    LOOP
                ENDIF
                IF PEMSTATUS(loc_oCtrl, "Visible", 5)
                    loc_oCtrl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) .AND. ;
                   loc_oCtrl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oCtrl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Activate - foca o grid quando o form e exibido (padrao legado Init SetFocus)
    *--------------------------------------------------------------------------
    PROCEDURE Activate()
        DODEFAULT()
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        TRY
            IF USED("cursor_4c_Contas")
                USE IN cursor_4c_Contas
            ENDIF
            IF USED("csCampos")
                USE IN csCampos
            ENDIF
            IF USED("csArquivos")
                USE IN csArquivos
            ENDIF
            THIS.this_oBusinessObject = .NULL.
        CATCH TO loc_oErro
            *-- ignorar erros de cleanup
        ENDTRY
        DODEFAULT()
    ENDPROC


    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista
    * Configura o corpo principal do form OPERACIONAL: botoes de acao, grid
    * de pares de contas, checkboxes e internos do painel de progresso.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarBotoesAcao()
        THIS.ConfigurarGrid()
        THIS.ConfigurarCheckboxes()
        THIS.ConfigurarResultadoInternos()
        THIS.VincularEventos()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesAcao
    * Adiciona os botoes de acao ao container cnt_4c_Botoes.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_Botoes

        loc_oCnt.AddObject("cmd_4c_BtnIncluir", "CommandButton")
        WITH loc_oCnt.cmd_4c_BtnIncluir
            .Top             = 7
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Caption         = "\<Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .WordWrap        = .T.
            .MousePointer    = 15
        ENDWITH

        loc_oCnt.AddObject("cmd_4c_BtnExcluir", "CommandButton")
        WITH loc_oCnt.cmd_4c_BtnExcluir
            .Top             = 7
            .Left            = 85
            .Width           = 75
            .Height          = 75
            .Caption         = "\<Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .WordWrap        = .T.
            .MousePointer    = 15
        ENDWITH

        loc_oCnt.AddObject("cmd_4c_Exporta", "CommandButton")
        WITH loc_oCnt.cmd_4c_Exporta
            .Top             = 7
            .Left            = 165
            .Width           = 75
            .Height          = 75
            .Caption         = "I\<mportar"
            .Picture         = gc_4c_CaminhoIcones + "geral_multiplos_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_multiplos_60.jpg"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .WordWrap        = .T.
            .MousePointer    = 15
        ENDWITH

        loc_oCnt.AddObject("cmd_4c_BtnProcessar", "CommandButton")
        WITH loc_oCnt.cmd_4c_BtnProcessar
            .Top             = 7
            .Left            = 245
            .Width           = 75
            .Height          = 75
            .Caption         = "\<Processar"
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .WordWrap        = .T.
            .MousePointer    = 15
        ENDWITH

        loc_oCnt.AddObject("cmd_4c_BtnSair", "CommandButton")
        WITH loc_oCnt.cmd_4c_BtnSair
            .Top             = 7
            .Left            = 915
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Cancel          = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .WordWrap        = .T.
            .MousePointer    = 15
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrid
    * Cria grd_4c_Dados com 2 colunas (Conta Antiga / Conta Nova).
    * RecordSource: cursor_4c_Contas criado pelo BO em InicializarCursorContas.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_oGrid
        THIS.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = THIS.grd_4c_Dados
        WITH loc_oGrid
            .Top               = 170
            .Left              = 12
            .Width             = 460
            .Height            = 400
            .ColumnCount       = 2
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .HeaderHeight      = 18
            .RowHeight         = 18
            .ScrollBars        = 2
            .FontName          = "Verdana"
            .FontSize          = 8
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(255, 255, 255)
            .GridLineColor     = RGB(238, 238, 238)
            .HighlightStyle    = 2
            .RecordSource      = "cursor_4c_Contas"
            .Column1.ControlSource = "cursor_4c_Contas.ContaAnt"
            .Column1.Width         = 220
            .Column1.Sparse        = .F.
            .Column2.ControlSource = "cursor_4c_Contas.ContaNov"
            .Column2.Width         = 220
            .Column2.Sparse        = .F.
        ENDWITH
        *-- Reconfigurar headers apos RecordSource (RecordSource reseta captions)
        loc_oGrid.Column1.Header1.Caption   = "Conta Antiga"
        loc_oGrid.Column1.Header1.Alignment = 2
        loc_oGrid.Column1.Header1.FontName  = "Tahoma"
        loc_oGrid.Column1.Header1.FontSize  = 8
        loc_oGrid.Column1.Header1.ForeColor = RGB(0, 0, 0)
        loc_oGrid.Column2.Header1.Caption   = "Conta Nova"
        loc_oGrid.Column2.Header1.Alignment = 2
        loc_oGrid.Column2.Header1.FontName  = "Tahoma"
        loc_oGrid.Column2.Header1.FontSize  = 8
        loc_oGrid.Column2.Header1.ForeColor = RGB(0, 0, 0)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCheckboxes
    * Adiciona checkboxes de controle ao form.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCheckboxes()
        THIS.AddObject("chk_4c_ChkReps", "CheckBox")
        WITH THIS.chk_4c_ChkReps
            .Top       = 358
            .Left      = 490
            .Height    = 20
            .Width     = 240
            .Caption   = "Trocar Apenas Representantes"
            .Value     = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        THIS.AddObject("chk_4c_Chk_DelCT", "CheckBox")
        WITH THIS.chk_4c_Chk_DelCT
            .Top       = 383
            .Left      = 490
            .Height    = 20
            .Width     = 260
            .Caption   = "Apagar a Conta Antiga do Cadastro"
            .Value     = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarResultadoInternos
    * Adiciona controles internos ao painel de progresso cnt_4c_Resultado.
    * Nomes devem bater exatamente com as referencias em AtualizarProgresso().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarResultadoInternos()
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_Resultado

        loc_oCnt.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oCnt.lbl_4c_Label5
            .Caption   = "Arquivo/Campo :"
            .Left      = 7
            .Top       = 9
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Arquivo", "TextBox")
        WITH loc_oCnt.txt_4c_Arquivo
            .Top               = 26
            .Left              = 7
            .Width             = 278
            .Height            = 24
            .Enabled           = .F.
            .Value             = ""
            .Alignment         = 3
            .SpecialEffect     = 1
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(0, 0, 0)
            .BorderColor       = RGB(100, 100, 100)
            .FontName          = "Tahoma"
            .FontSize          = 8
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oCnt.lbl_4c_Label1
            .Caption   = "Progresso :"
            .Left      = 7
            .Top       = 100
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oCnt.AddObject("cnt_4c_Barra", "Container")
        WITH loc_oCnt.cnt_4c_Barra
            .Top         = 116
            .Left        = 5
            .Width       = 280
            .Height      = 21
            .BorderWidth = 1
            .BackStyle   = 1
            .BackColor   = RGB(200, 200, 200)
            .Visible     = .T.
        ENDWITH

        loc_oCnt.cnt_4c_Barra.AddObject("shp_4c_Barra", "Shape")
        WITH loc_oCnt.cnt_4c_Barra.shp_4c_Barra
            .Top         = 1
            .Left        = 1
            .Height      = 19
            .Width       = 0
            .BackColor   = RGB(0, 128, 255)
            .BorderColor = RGB(100, 100, 100)
        ENDWITH

        loc_oCnt.cnt_4c_Barra.AddObject("lbl_4c_Porcento", "Label")
        WITH loc_oCnt.cnt_4c_Barra.lbl_4c_Porcento
            .Caption   = "0 %"
            .Left      = 120
            .Top       = 4
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados
    * NAO APLICAVEL para este form OPERACIONAL de layout plano (sem PageFrame).
    * Todos os controles de dados foram criados em ConfigurarPaginaLista():
    *   grd_4c_Dados      - grade de pares ContaAnt/ContaNov
    *   chk_4c_ChkReps    - checkbox "Trocar Apenas Representantes"
    *   chk_4c_Chk_DelCT  - checkbox "Apagar a Conta Antiga do Cadastro"
    *   cnt_4c_Resultado  - painel de progresso (flutuante)
    * Metodo mantido para compatibilidade com o template multi-fase.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- Form OPERACIONAL plano: nao ha Page2 separada de edicao de dados.
        *-- Todos os controles foram configurados em ConfigurarPaginaLista().
    ENDPROC

    *--------------------------------------------------------------------------
    * VincularEventos
    * Vincula eventos dos controles aos handlers do form via BINDEVENT.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE VincularEventos()
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_Botoes
        BINDEVENT(loc_oCnt.cmd_4c_BtnIncluir,  "Click", THIS, "CmdIncluirClick")
        BINDEVENT(loc_oCnt.cmd_4c_BtnExcluir,  "Click", THIS, "CmdExcluirClick")
        BINDEVENT(loc_oCnt.cmd_4c_Exporta,     "Click", THIS, "CmdExportaClick")
        BINDEVENT(loc_oCnt.cmd_4c_BtnProcessar,"Click", THIS, "CmdProcessarClick")
        BINDEVENT(loc_oCnt.cmd_4c_BtnSair,     "Click", THIS, "CmdSairClick")
        BINDEVENT(THIS.chk_4c_ChkReps, "Click", THIS, "ChkRepsClick")
        BINDEVENT(THIS.grd_4c_Dados, "KeyPress",          THIS, "GrdDadosKeyPress")
        BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina
    * Exibe ou oculta o painel de progresso (cnt_4c_Resultado).
    * par_lMostrar: .T. para exibir, .F. para ocultar, omitir para alternar.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_lMostrar)
        TRY
            IF VARTYPE(par_lMostrar) = "L"
                THIS.cnt_4c_Resultado.Visible = par_lMostrar
            ELSE
                THIS.cnt_4c_Resultado.Visible = !THIS.cnt_4c_Resultado.Visible
            ENDIF
            THIS.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdIncluirClick - Incluir nova linha em branco no grid
    *--------------------------------------------------------------------------
    PROCEDURE CmdIncluirClick()
        TRY
            THIS.this_oBusinessObject.IncluirParConta()
            THIS.grd_4c_Dados.Refresh()
            THIS.grd_4c_Dados.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Incluir")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdExcluirClick - Excluir linha corrente do grid
    *--------------------------------------------------------------------------
    PROCEDURE CmdExcluirClick()
        TRY
            THIS.this_oBusinessObject.ExcluirParConta()
            THIS.grd_4c_Dados.Refresh()
            THIS.grd_4c_Dados.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Excluir")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdExportaClick - Importar pares de contas de arquivo XLS
    *--------------------------------------------------------------------------
    PROCEDURE CmdExportaClick()
        LOCAL loc_cArquivo
        loc_cArquivo = ""
        TRY
            loc_cArquivo = GETFILE("XLS")
            IF EMPTY(loc_cArquivo)
                MsgAviso("Arquivo para Importa" + CHR(231) + CHR(227) + ;
                    "o n" + CHR(227) + "o informado!!!", "Aviso")
                RETURN
            ENDIF
            IF THIS.this_oBusinessObject.ImportarDeXLS(loc_cArquivo)
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Importar")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdProcessarClick - Processar troca de contas em todas as tabelas
    *--------------------------------------------------------------------------
    PROCEDURE CmdProcessarClick()
        LOCAL loc_lSucesso, loc_cMensagem, loc_lApagarContaAntiga, loc_lTrocarReps
        loc_lSucesso           = .F.
        loc_cMensagem          = ""
        loc_lApagarContaAntiga = .F.
        loc_lTrocarReps        = .F.
        TRY
            *-- Validar pares antes de processar
            IF NOT THIS.this_oBusinessObject.ValidarParesContas(@loc_cMensagem)
                MsgAviso(loc_cMensagem, "Aten" + CHR(231) + CHR(227) + "o")
                THIS.grd_4c_Dados.SetFocus()
                RETURN
            ENDIF

            *-- Confirmar com usuario
            IF NOT MsgConfirma("Confirma a Troca das Contas ?", ;
                "Confirma" + CHR(231) + CHR(227) + "o do Processamento!!!")
                THIS.cnt_4c_Botoes.cmd_4c_BtnSair.SetFocus()
                RETURN
            ENDIF

            loc_lTrocarReps        = (THIS.chk_4c_ChkReps.Value   = 1)
            loc_lApagarContaAntiga = (THIS.chk_4c_Chk_DelCT.Value = 1)

            IF loc_lTrocarReps
                *-- Troca apenas ContaVens em SigCdCli (representantes)
                loc_lSucesso = THIS.this_oBusinessObject.TrocarContaRepresentantes()
            ELSE
                *-- Processamento completo via catalogo ArqDBF
                THIS.cnt_4c_Resultado.Visible = .T.
                THIS.cnt_4c_Resultado.cnt_4c_Barra.shp_4c_Barra.Width   = 0
                THIS.cnt_4c_Resultado.cnt_4c_Barra.lbl_4c_Porcento.Caption = "0 %"
                THIS.cnt_4c_Resultado.Refresh()
                loc_lSucesso = THIS.this_oBusinessObject.ProcessarMudancaContas( ;
                    loc_lApagarContaAntiga, THIS)
                THIS.cnt_4c_Resultado.Visible = .F.
                THIS.Refresh()
            ENDIF

            *-- Informar resultado
            IF loc_lSucesso
                MsgAviso("Todas as Contas Foram Alteradas!!!", ;
                    "Processamento Encerrado!!!")
            ELSE
                MsgAviso("As Contas N" + CHR(227) + "o Foram Alteradas!!!", ;
                    "Processamento Encerrado!!!")
            ENDIF

            *-- Reiniciar cursor para nova rodada
            IF USED("cursor_4c_Contas")
                SELECT cursor_4c_Contas
                SET ORDER TO
                ZAP
                APPEND BLANK
            ENDIF
            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro no Processamento")
            TRY
                THIS.cnt_4c_Resultado.Visible = .F.
                THIS.Refresh()
            CATCH TO loc_oErroVis
                *-- ignorar
            ENDTRY
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdSairClick - Fechar o formulario
    *--------------------------------------------------------------------------
    PROCEDURE CmdSairClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkRepsClick
    * Quando "Trocar Apenas Representantes" e marcado, desabilitar e limpar
    * "Apagar Conta Antiga" (legado: When = chkReps.Value = 0).
    *--------------------------------------------------------------------------
    PROCEDURE ChkRepsClick()
        IF THIS.chk_4c_ChkReps.Value = 1
            THIS.chk_4c_Chk_DelCT.Value   = 0
            THIS.chk_4c_Chk_DelCT.Enabled = .F.
        ELSE
            THIS.chk_4c_Chk_DelCT.Enabled = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdDadosKeyPress - F4 abre lookup para a coluna ativa (Conta Antiga/Nova)
    *--------------------------------------------------------------------------
    PROCEDURE GrdDadosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 115  && Apenas F4
            RETURN
        ENDIF
        LOCAL loc_nColAtiva
        loc_nColAtiva = 0
        TRY
            loc_nColAtiva = THIS.grd_4c_Dados.ActiveColumn
        CATCH TO loc_oErro
            *-- ignorar
        ENDTRY
        IF loc_nColAtiva = 1
            THIS.AbrirLookupContaAnt()
        ELSE
            IF loc_nColAtiva = 2
            THIS.AbrirLookupContaNov()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdDadosAfterRowColChange
    * Ao mover para Coluna 2, valida ContaAnt do registro corrente.
    * Ao mover para Coluna 1 com ContaNov preenchida, valida ContaNov.
    * (Equivale aos Valid de Column1.Text1 e Column2.Text1 do legado.)
    *--------------------------------------------------------------------------
    PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
        IF THIS.this_lCheckCadPro
            RETURN
        ENDIF
        IF par_nColIndex = 2
            THIS.ValidarContaAnt()
        ELSE
            IF par_nColIndex = 1
            *-- Validar ContaNov apenas se tiver valor (usuario saiu da col 2)
            IF USED("cursor_4c_Contas") AND NOT EOF("cursor_4c_Contas")
                IF NOT EMPTY(NVL(cursor_4c_Contas.ContaNov, ""))
                    THIS.ValidarContaNov()
                ENDIF
            ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarContaAnt
    * Valida ContaAnt do registro corrente contra SigCdCli. Se nao encontrado,
    * abre picker para selecao.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarContaAnt()
        LOCAL loc_cValor, loc_cEncontrado
        loc_cValor      = ""
        loc_cEncontrado = ""
        TRY
            IF USED("cursor_4c_Contas") AND NOT EOF("cursor_4c_Contas")
                loc_cValor = ALLTRIM(NVL(cursor_4c_Contas.ContaAnt, ""))
            ENDIF
            IF EMPTY(loc_cValor)
                RETURN
            ENDIF
            loc_cEncontrado = THIS.this_oBusinessObject.ValidarCodigoConta(loc_cValor)
            IF EMPTY(loc_cEncontrado)
                THIS.AbrirLookupContaAnt()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar Conta Antiga")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarContaNov
    * Valida ContaNov do registro corrente contra SigCdCli. Se nao encontrado,
    * abre picker para selecao.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarContaNov()
        LOCAL loc_cValor, loc_cEncontrado
        loc_cValor      = ""
        loc_cEncontrado = ""
        TRY
            IF USED("cursor_4c_Contas") AND NOT EOF("cursor_4c_Contas")
                loc_cValor = ALLTRIM(NVL(cursor_4c_Contas.ContaNov, ""))
            ENDIF
            IF EMPTY(loc_cValor)
                RETURN
            ENDIF
            loc_cEncontrado = THIS.this_oBusinessObject.ValidarCodigoConta(loc_cValor)
            IF EMPTY(loc_cEncontrado)
                THIS.AbrirLookupContaNov()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar Conta Nova")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupContaAnt
    * Abre FormBuscaAuxiliar para selecao de Conta Antiga (SigCdCli.Iclis).
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupContaAnt()
        LOCAL loc_oLista, loc_cValor
        loc_cValor = ""
        TRY
            IF USED("cursor_4c_Contas") AND NOT EOF("cursor_4c_Contas")
                loc_cValor = ALLTRIM(NVL(cursor_4c_Contas.ContaAnt, ""))
            ENDIF
            loc_oLista = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaCli", "Iclis", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o", .T., .T., "")
            loc_oLista.mAddColuna("Iclis",  "", "C" + CHR(243) + "digo")
            loc_oLista.mAddColuna("Rclis",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oLista.mAddColuna("Grupos", "", "Grupo")
            loc_oLista.Show()
            IF loc_oLista.this_lSelecionou .AND. USED("cursor_4c_BuscaCli") .AND. ;
               RECCOUNT("cursor_4c_BuscaCli") > 0
                SELECT cursor_4c_BuscaCli
                IF NOT EOF()
                    SELECT cursor_4c_Contas
                    IF NOT EOF()
                        REPLACE cursor_4c_Contas.ContaAnt WITH ;
                            ALLTRIM(cursor_4c_BuscaCli.Iclis)
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar Conta Antiga")
        ENDTRY
        IF USED("cursor_4c_BuscaCli")
            USE IN cursor_4c_BuscaCli
        ENDIF
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupContaNov
    * Abre FormBuscaAuxiliar para selecao de Conta Nova (SigCdCli.Iclis).
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupContaNov()
        LOCAL loc_oLista, loc_cValor
        loc_cValor = ""
        TRY
            IF USED("cursor_4c_Contas") AND NOT EOF("cursor_4c_Contas")
                loc_cValor = ALLTRIM(NVL(cursor_4c_Contas.ContaNov, ""))
            ENDIF
            loc_oLista = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaCli", "Iclis", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o", .T., .T., "")
            loc_oLista.mAddColuna("Iclis",  "", "C" + CHR(243) + "digo")
            loc_oLista.mAddColuna("Rclis",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oLista.mAddColuna("Grupos", "", "Grupo")
            loc_oLista.Show()
            IF loc_oLista.this_lSelecionou .AND. USED("cursor_4c_BuscaCli") .AND. ;
               RECCOUNT("cursor_4c_BuscaCli") > 0
                SELECT cursor_4c_BuscaCli
                IF NOT EOF()
                    SELECT cursor_4c_Contas
                    IF NOT EOF()
                        REPLACE cursor_4c_Contas.ContaNov WITH ;
                            ALLTRIM(cursor_4c_BuscaCli.Iclis)
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar Conta Nova")
        ENDTRY
        IF USED("cursor_4c_BuscaCli")
            USE IN cursor_4c_BuscaCli
        ENDIF
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick
    * Adiciona novo par de contas em branco no grid (equivalente CRUD Incluir).
    * Roteia para CmdIncluirClick (mesmo handler do botao [Incluir] visivel).
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.CmdIncluirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick
    * Coloca foco na Conta Antiga da linha corrente para edicao inline no grid.
    * Form OPERACIONAL: grid eh sempre editavel, nao ha modo separado ALTERAR.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        TRY
            IF NOT USED("cursor_4c_Contas") OR RECCOUNT("cursor_4c_Contas") = 0
                MsgAviso("N" + CHR(227) + "o existem pares de contas para alterar.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF
            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.SetFocus()
                THIS.grd_4c_Dados.ActiveColumn = 1
                IF VARTYPE(THIS.grd_4c_Dados.Column1.Text1) = "O"
                    THIS.grd_4c_Dados.Column1.Text1.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Alterar")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick
    * Exibe as descricoes das Contas Antiga/Nova da linha corrente do grid.
    * Form OPERACIONAL: nao ha modo VISUALIZAR separado; consulta on-demand.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cContaAnt, loc_cContaNov, loc_cDescAnt, loc_cDescNov, loc_cMsg
        loc_cContaAnt = ""
        loc_cContaNov = ""
        loc_cDescAnt  = ""
        loc_cDescNov  = ""
        TRY
            IF NOT USED("cursor_4c_Contas") OR EOF("cursor_4c_Contas")
                MsgAviso("N" + CHR(227) + "o existem pares de contas para visualizar.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF
            SELECT cursor_4c_Contas
            loc_cContaAnt = ALLTRIM(NVL(cursor_4c_Contas.ContaAnt, ""))
            loc_cContaNov = ALLTRIM(NVL(cursor_4c_Contas.ContaNov, ""))
            IF EMPTY(loc_cContaAnt) AND EMPTY(loc_cContaNov)
                MsgAviso("Linha corrente n" + CHR(227) + "o tem contas preenchidas.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF
            IF NOT EMPTY(loc_cContaAnt)
                loc_cDescAnt = THIS.this_oBusinessObject.BuscarDescricaoConta(loc_cContaAnt)
            ENDIF
            IF NOT EMPTY(loc_cContaNov)
                loc_cDescNov = THIS.this_oBusinessObject.BuscarDescricaoConta(loc_cContaNov)
            ENDIF
            loc_cMsg = "Conta Antiga: " + loc_cContaAnt + CHR(13) + ;
                       "Descri" + CHR(231) + CHR(227) + "o.: " + loc_cDescAnt + CHR(13) + CHR(13) + ;
                       "Conta Nova..: " + loc_cContaNov + CHR(13) + ;
                       "Descri" + CHR(231) + CHR(227) + "o.: " + loc_cDescNov
            MsgInfo(loc_cMsg, "Visualizar Par de Contas")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Visualizar")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick
    * Remove par de contas da linha corrente do grid (equivalente CRUD Excluir).
    * Roteia para CmdExcluirClick (mesmo handler do botao [Excluir] visivel).
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        IF NOT USED("cursor_4c_Contas") OR RECCOUNT("cursor_4c_Contas") = 0
            MsgAviso("N" + CHR(227) + "o existem pares de contas para excluir.", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF
        IF NOT MsgConfirma("Confirma a exclus" + CHR(227) + "o da linha corrente?", ;
            "Confirma" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF
        THIS.CmdExcluirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fechar o formulario (alias canonico para cmd Encerrar)
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.CmdSairClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Focar grid para edicao inline (busca e via F4 no grid)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        TRY
            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.SetFocus()
                THIS.grd_4c_Dados.ActiveColumn = 1
            ENDIF
        CATCH TO loc_oErro
            *-- ignorar
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Aciona o processamento principal (semantica CRUD Salvar)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.CmdProcessarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Limpa a lista de pares (semantica CRUD Cancelar)
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO
    * Transfere estado dos controles do form para propriedades do BO.
    * Para este OPERACIONAL: repassa flags dos checkboxes.
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF
        TRY
            THIS.this_oBusinessObject.this_lCheckCadPro       = THIS.this_lCheckCadPro
            THIS.this_oBusinessObject.this_lTrocarReps        = (THIS.chk_4c_ChkReps.Value = 1)
            THIS.this_oBusinessObject.this_lApagarContaAntiga = (THIS.chk_4c_Chk_DelCT.Value = 1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em FormParaBO")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm
    * Carrega propriedades do BO nos controles do form.
    * Para este OPERACIONAL: reflete flags de configuracao nos checkboxes.
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF
        TRY
            THIS.chk_4c_ChkReps.Value   = IIF(THIS.this_oBusinessObject.this_lTrocarReps, 1, 0)
            THIS.chk_4c_Chk_DelCT.Value = IIF(THIS.this_oBusinessObject.this_lApagarContaAntiga, 1, 0)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos
    * Habilita ou desabilita os botoes de acao do formulario.
    * par_lHabilitar: .T. para habilitar, .F. para desabilitar (default .T.)
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lAtivar
        loc_lAtivar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
        TRY
            WITH THIS.cnt_4c_Botoes
                .cmd_4c_BtnIncluir.Enabled   = loc_lAtivar
                .cmd_4c_BtnExcluir.Enabled   = loc_lAtivar
                .cmd_4c_Exporta.Enabled      = loc_lAtivar
                .cmd_4c_BtnProcessar.Enabled = loc_lAtivar
                .Visible     = .T.
            ENDWITH
        CATCH TO loc_oErro
            *-- ignorar erro de habilitacao
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos
    * Reinicia cursor_4c_Contas com um registro em branco e limpa checkboxes.
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        TRY
            IF USED("cursor_4c_Contas")
                SELECT cursor_4c_Contas
                SET ORDER TO
                ZAP
                APPEND BLANK
            ENDIF
            THIS.chk_4c_ChkReps.Value    = 0
            THIS.chk_4c_Chk_DelCT.Value  = 0
            THIS.chk_4c_Chk_DelCT.Enabled = .T.
            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao limpar")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista
    * Atualiza a exibicao do grid com o estado corrente do cursor_4c_Contas.
    * Returns: .T. em sucesso
    *--------------------------------------------------------------------------
    FUNCTION CarregarLista()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.Refresh()
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar lista")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo
    * Ajusta estado dos botoes conforme conteudo do cursor.
    * Excluir e Processar so ficam ativos se houver pares cadastrados.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo(par_cModo)
        LOCAL loc_lTemRegistros
        loc_lTemRegistros = USED("cursor_4c_Contas") AND ;
                            NOT EOF("cursor_4c_Contas") AND ;
                            NOT EMPTY(NVL(cursor_4c_Contas.ContaAnt, ""))
        TRY
            WITH THIS.cnt_4c_Botoes
                .cmd_4c_BtnExcluir.Enabled   = loc_lTemRegistros
                .cmd_4c_BtnProcessar.Enabled = loc_lTemRegistros
                .Visible     = .T.
            ENDWITH
        CATCH TO loc_oErro
            *-- ignorar erro de ajuste
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista
    * Aplica formatacao visual padrao ao grid de pares de contas.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrMdcBO.prg):
*==============================================================================
* Classe  : SigPrMdcBO
* Herda de: BusinessBase
* Descricao: BO para processamento de mudanca de conta (Muda Conta)
*            Valida pares ContaAnt/ContaNov, importa de XLS e aplica UPDATE
*            em multiplas tabelas do banco conforme catalogo ArqDBF.
*            Form OPERACIONAL - sem CRUD padrao, sem this_cTabela/CampoChave.
*==============================================================================
DEFINE CLASS SigPrMdcBO AS BusinessBase

    *-- Flags de configuracao do processamento
    this_lCheckCadPro       = .F.   && Validar codigo de conta contra SigCdCli
    this_lTrocarReps        = .F.   && Trocar apenas representantes (ContaVens em SigCdCli)
    this_lApagarContaAntiga = .F.   && Apagar conta antiga de SigCdCli apos troca

    *-- Estado do progresso (lido pelo Form para atualizar UI)
    this_cArquivoAtual      = ""    && Arquivo/campo em processamento
    this_nProgresso         = 0     && Progresso 0-100

    *-- Caminho completo do ArqDBF.DBF (sem extensao) - setado por ValidarArqDBF
    this_cArqDBFPath        = ""

    *-- Par corrente de contas (usado por CarregarDoCursor/Inserir/Atualizar)
    this_cContaAnt          = ""
    this_cContaNov          = ""

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - override para auditoria operacional
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN "MUDACONTA"
    ENDFUNC

    *--------------------------------------------------------------------------
    * InicializarCursorContas
    * Cria cursor_4c_Contas com estrutura e registro inicial em branco.
    * Deve ser chamado por FormSigPrMdc.InicializarForm().
    * Returns: .T. em sucesso
    *--------------------------------------------------------------------------
    FUNCTION InicializarCursorContas()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Contas")
                USE IN cursor_4c_Contas
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Contas (ContaAnt C(10) NULL, ContaNov C(10) NULL)
            SET NULL OFF
            INDEX ON ContaAnt + ContaNov TAG Duplica
            INDEX ON ContaAnt            TAG ContaAnt
            INDEX ON ContaNov            TAG ContaNov
            SET ORDER TO
            INSERT INTO cursor_4c_Contas (ContaAnt, ContaNov) VALUES ('', '')
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarArqDBF
    * Verifica se ArqDBF.DBF existe no diretorio corrente do sistema.
    * Seta this_cArqDBFPath com caminho completo (sem extensao).
    * Returns: .T. se existe, .F. se nao encontrado
    *--------------------------------------------------------------------------
    FUNCTION ValidarArqDBF()
        LOCAL loc_lSucesso, loc_cCaminho
        loc_lSucesso = .F.
        loc_cCaminho = ""
        TRY
            loc_cCaminho = SYS(5) + SYS(2003) + "\ArqDBF"
            IF NOT FILE(loc_cCaminho + ".dbf")
                MsgAviso("O ArqDBF n" + CHR(227) + "o est" + CHR(225) + ;
                    " no diret" + CHR(243) + "rio do Sistema!!!", "Aviso")
            ELSE
                THIS.this_cArqDBFPath = loc_cCaminho
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * IncluirParConta
    * Adiciona linha em branco ao cursor_4c_Contas somente se a linha
    * corrente ja estiver preenchida (ContaAnt e ContaNov nao vazios).
    * Returns: .T. em sucesso
    *--------------------------------------------------------------------------
    FUNCTION IncluirParConta()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            SELECT cursor_4c_Contas
            IF !EMPTY(cursor_4c_Contas.ContaAnt) .AND. !EMPTY(cursor_4c_Contas.ContaNov)
                APPEND BLANK
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExcluirParConta
    * Marca o registro corrente de cursor_4c_Contas como excluido.
    * Returns: .T. em sucesso
    *--------------------------------------------------------------------------
    FUNCTION ExcluirParConta()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            SELECT cursor_4c_Contas
            DELETE
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarParesContas
    * Valida todos os pares em cursor_4c_Contas:
    *   - Nao pode estar vazio (ContaAnt ou ContaNov)
    *   - Nao pode ter ContaAnt = ContaNov
    * par_cMensagem: [BYREF] mensagem de erro se houver
    * Returns: .T. se todos validos, .F. se houver erro
    *--------------------------------------------------------------------------
    FUNCTION ValidarParesContas(par_cMensagem)
        LOCAL loc_lValido
        loc_lValido   = .F.
        par_cMensagem = ""
        TRY
            SELECT cursor_4c_Contas
            GO TOP
            IF EOF()
                par_cMensagem = "N" + CHR(227) + "o Existem Contas a Serem Processadas!!!"
            ELSE
                loc_lValido = .T.
                SCAN
                    IF EMPTY(cursor_4c_Contas.ContaAnt)
                        par_cMensagem = "Existe Uma Conta Antiga Inv" + CHR(225) + "lida!!!"
                        loc_lValido   = .F.
                        EXIT
                    ENDIF
                    IF EMPTY(cursor_4c_Contas.ContaNov)
                        par_cMensagem = "Existe Uma Conta Nova Inv" + CHR(225) + "lida!!!"
                        loc_lValido   = .F.
                        EXIT
                    ENDIF
                    IF cursor_4c_Contas.ContaAnt = cursor_4c_Contas.ContaNov
                        par_cMensagem = "Existe Uma Conta Antiga e Uma Conta Nova " + ;
                            "Com o Mesmo C" + CHR(243) + "digo!!!"
                        loc_lValido   = .F.
                        EXIT
                    ENDIF
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lValido = .F.
        ENDTRY
        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarCodigoConta
    * Verifica se um codigo de conta existe em SigCdCli.
    * par_cConta: codigo a validar
    * Returns: ALLTRIM(Iclis) se encontrado, "" se nao encontrado
    *--------------------------------------------------------------------------
    FUNCTION ValidarCodigoConta(par_cConta)
        LOCAL loc_cResultado, loc_cSQL, loc_nRet
        loc_cResultado = ""
        TRY
            IF NOT EMPTY(par_cConta)
                loc_cSQL = "SELECT Iclis FROM SigCdCli WHERE Iclis = " + ;
                    EscaparSQL(ALLTRIM(par_cConta))
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidCli")
                IF loc_nRet >= 1 .AND. RECCOUNT("cursor_4c_ValidCli") > 0
                    SELECT cursor_4c_ValidCli
                    loc_cResultado = ALLTRIM(cursor_4c_ValidCli.Iclis)
                ENDIF
                IF USED("cursor_4c_ValidCli")
                    USE IN cursor_4c_ValidCli
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            IF USED("cursor_4c_ValidCli")
                USE IN cursor_4c_ValidCli
            ENDIF
        ENDTRY
        RETURN loc_cResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarDescricaoConta
    * Retorna a Razao Social (Rclis) da conta em SigCdCli. String vazia se
    * conta nao existir. Usada por BtnVisualizarClick do Form.
    *--------------------------------------------------------------------------
    FUNCTION BuscarDescricaoConta(par_cConta)
        LOCAL loc_cResultado, loc_cSQL, loc_nRet
        loc_cResultado = ""
        TRY
            IF NOT EMPTY(par_cConta)
                loc_cSQL = "SELECT Rclis FROM SigCdCli WHERE Iclis = " + ;
                    EscaparSQL(ALLTRIM(par_cConta))
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescCli")
                IF loc_nRet >= 1 .AND. RECCOUNT("cursor_4c_DescCli") > 0
                    SELECT cursor_4c_DescCli
                    loc_cResultado = ALLTRIM(NVL(cursor_4c_DescCli.Rclis, ""))
                ENDIF
                IF USED("cursor_4c_DescCli")
                    USE IN cursor_4c_DescCli
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            IF USED("cursor_4c_DescCli")
                USE IN cursor_4c_DescCli
            ENDIF
        ENDTRY
        RETURN loc_cResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ImportarDeXLS
    * Importa arquivo XLS e carrega pares em cursor_4c_Contas.
    * Valida ContaAnt contra SigCdCli (se this_lCheckCadPro = .F.).
    * Deduplica via TAG Duplica antes de inserir.
    * par_cArquivo: caminho completo do arquivo XLS (ja validado pela UI)
    * Returns: .T. em sucesso
    *--------------------------------------------------------------------------
    FUNCTION ImportarDeXLS(par_cArquivo)
        LOCAL loc_lSucesso, loc_nTotal, loc_nCont
        LOCAL loc_cContaAnt, loc_cContaNov, loc_cSQL, loc_nRet
        loc_lSucesso  = .F.
        loc_nTotal    = 0
        loc_nCont     = 0
        loc_cContaAnt = ""
        loc_cContaNov = ""
        loc_cSQL      = ""
        loc_nRet      = 0
        TRY
            IF EMPTY(par_cArquivo)
                MsgAviso("Arquivo para Importa" + CHR(231) + CHR(227) + ;
                    "o n" + CHR(227) + "o informado!!!", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            IF NOT FILE(par_cArquivo)
                MsgAviso("O Arquivo [" + ALLTRIM(par_cArquivo) + "]" + CHR(13) + ;
                    "N" + CHR(227) + "o Foi Encontrado ou o Acesso " + ;
                    "Foi Negado!!! Verifique!!!", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            *-- Cursor temporario de importacao
            IF USED("cursor_4c_Importa")
                USE IN cursor_4c_Importa
            ENDIF
            CREATE CURSOR cursor_4c_Importa (ContaAnt C(10), ContaNov C(10))
            INDEX ON ContaAnt TAG Contas
            SET ORDER TO

            *-- Importar registros do XLS
            SELECT cursor_4c_Importa
            APPEND FROM (par_cArquivo) TYPE XLS

            loc_nTotal = RECCOUNT("cursor_4c_Importa")
            loc_nCont  = 0

            SELECT cursor_4c_Importa
            SCAN
                loc_nCont     = loc_nCont + 1
                loc_cContaAnt = cursor_4c_Importa.ContaAnt
                loc_cContaNov = cursor_4c_Importa.ContaNov

                IF EMPTY(loc_cContaAnt) OR EMPTY(loc_cContaNov)
                    LOOP
                ENDIF
                IF loc_cContaAnt = loc_cContaNov
                    LOOP
                ENDIF

                *-- Validar ContaAnt contra SigCdCli se nao em modo CheckCadPro
                IF NOT THIS.this_lCheckCadPro
                    loc_cSQL = "SELECT Iclis FROM SigCdCli WHERE Iclis = " + ;
                        EscaparSQL(ALLTRIM(loc_cContaAnt))
                    loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliImp")
                    IF loc_nRet < 1 OR RECCOUNT("cursor_4c_CliImp") = 0
                        IF USED("cursor_4c_CliImp")
                            USE IN cursor_4c_CliImp
                        ENDIF
                        LOOP
                    ENDIF
                    IF USED("cursor_4c_CliImp")
                        USE IN cursor_4c_CliImp
                    ENDIF
                ENDIF

                *-- Inserir em cursor_4c_Contas somente se nao duplicado
                SELECT cursor_4c_Contas
                SET ORDER TO Duplica
                IF NOT SEEK(m.loc_cContaAnt + m.loc_cContaNov)
                    APPEND BLANK
                    REPLACE cursor_4c_Contas.ContaAnt WITH loc_cContaAnt, ;
                            cursor_4c_Contas.ContaNov WITH loc_cContaNov
                ENDIF

                *-- Restaurar para o cursor de importacao (proxima iteracao SCAN)
                SELECT cursor_4c_Importa
            ENDSCAN

            *-- Posicionar no final e limpar ordem
            SELECT cursor_4c_Contas
            SET ORDER TO
            GO BOTTOM

            IF USED("cursor_4c_Importa")
                USE IN cursor_4c_Importa
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Importa")
                USE IN cursor_4c_Importa
            ENDIF
            IF USED("cursor_4c_CliImp")
                USE IN cursor_4c_CliImp
            ENDIF
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * TrocarContaRepresentantes
    * Troca ContaVens em SigCdCli para todos os pares em cursor_4c_Contas.
    * Executa em transacao SQL Server (COMMIT em sucesso, ROLLBACK em falha).
    * Permite retry interativo em caso de falha (mesma logica do legado).
    * Returns: .T. em sucesso (COMMIT), .F. em falha (ROLLBACK)
    *--------------------------------------------------------------------------
    FUNCTION TrocarContaRepresentantes()
        LOCAL loc_lSucesso, loc_cUpdate, loc_nErro
        loc_lSucesso = .F.
        loc_nErro    = 1
        TRY
            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

            SELECT cursor_4c_Contas
            SCAN
                loc_cUpdate = "UPDATE SigCdCli SET ContaVens = " + ;
                    EscaparSQL(ALLTRIM(cursor_4c_Contas.ContaNov)) + ;
                    " WHERE ContaVens = " + ;
                    EscaparSQL(ALLTRIM(cursor_4c_Contas.ContaAnt))

                loc_nErro = SQLEXEC(gnConnHandle, loc_cUpdate, "cursor_4c_TrocaRet")
                IF USED("cursor_4c_TrocaRet")
                    USE IN cursor_4c_TrocaRet
                ENDIF

                IF loc_nErro < 1
                    IF MsgConfirma("Falha ao Tentar Trocar a Conta '" + ;
                        ALLTRIM(cursor_4c_Contas.ContaAnt) + "'" + CHR(13) + ;
                        "Deseja Tentar Novamente?", "Aten" + CHR(231) + CHR(227) + "o!!!")
                        SELECT cursor_4c_Contas
                        SKIP -1
                        LOOP
                    ELSE
                        EXIT
                    ENDIF
                ENDIF
            ENDSCAN

            IF loc_nErro < 1
                SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION")
            ELSE
                SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 COMMIT TRANSACTION")
                *-- Auditoria
                SELECT cursor_4c_Contas
                SCAN
                    THIS.RegistrarAuditoria("TROCA_REP: " + ;
                        ALLTRIM(cursor_4c_Contas.ContaAnt) + " -> " + ;
                        ALLTRIM(cursor_4c_Contas.ContaNov))
                ENDSCAN
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            TRY
                SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION")
            CATCH TO loc_oErroTran
                *-- ignorar erro de rollback
            ENDTRY
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarMudancaContas
    * Processamento principal: itera sobre o catalogo ArqDBF.DBF e aplica
    * UPDATE (ou DELETE para SIGMVSLC/SIGMVEST) em todos os campos de todas
    * as tabelas que referenciam os codigos de conta em cursor_4c_Contas.
    *
    * Casos especiais:
    *   SIGMVCCR/CONTAS   -> atualiza GruConMoes + chama fRecalculaS
    *   SIGCDCLI/ICLIS    -> verifica se ContaNov existe; deleta ContaAnt se par_lApagarContaAntiga
    *   SIGMVHST/ESTOS    -> atualiza EmpGruEsts + chama fRecalculaP + fRecalculaC
    *   SIGCDCLH/ICLIS    -> atualiza GruContas
    *   SIGMVSLC/SIGMVEST -> DELETE (nao UPDATE)
    *
    * par_lApagarContaAntiga: apagar ContaAnt de SigCdCli apos troca
    * par_oForm: referencia ao Form para atualizacao de progresso (opcional)
    *            O Form deve ter PROCEDURE AtualizarProgresso(par_cArquivo, par_nPct)
    * Returns: .T. em sucesso (COMMIT), .F. em falha (ROLLBACK)
    *--------------------------------------------------------------------------
    FUNCTION ProcessarMudancaContas(par_lApagarContaAntiga, par_oForm)
        LOCAL loc_lSucesso, loc_nErro, loc_nRec, loc_nCnt
        LOCAL loc_cArq, loc_cCpo, loc_cUpdate, loc_cDelete, loc_cWhere
        LOCAL loc_cContaNovSalvo, loc_lContaNovExiste, loc_nChkRet, loc_cChkSQL
        loc_lSucesso        = .F.
        loc_nErro           = 1
        loc_nRec            = 0
        loc_nCnt            = 0
        loc_cArq            = ""
        loc_cCpo            = ""
        loc_cUpdate         = ""
        loc_cDelete         = ""
        loc_cWhere          = ""
        loc_cContaNovSalvo  = ""
        loc_lContaNovExiste = .F.
        loc_nChkRet         = 0
        loc_cChkSQL         = ""
        TRY
            IF NOT THIS.ValidarArqDBF()
                loc_lSucesso = .F.
            ENDIF

            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

            *-- Fechar cursores anteriores se abertos
            IF USED("csCampos")
                USE IN csCampos
            ENDIF
            IF USED("csArquivos")
                USE IN csArquivos
            ENDIF

            *-- Consultar catalogo ArqDBF (SELECT VFP local sobre DBF)
            SELECT Arquivos, Campos ;
            FROM (THIS.this_cArqDBFPath) ;
            WHERE (Tamanhos = 10 OR UPPER(Campos) = 'CLIFORS') AND ;
                  UPPER(Tipos) = 'C' AND ;
                  NOT EMPTY(Dbcs) AND ;
                  Arquivos # 'ArqDBF.DBF' AND ;
                  UPPER(Arquivos) # 'SIGTEMPC.DBF' AND ;
                  UPPER(Arquivos) # 'SIGCDCE.DBF' AND ;
                  UPPER(Arquivos) # 'SIGCDCEE.DBF' AND ;
                  UPPER(Arquivos) # 'SIGALERT.DBF' AND ;
                  INLIST(UPPER(SUBS(Arquivos, 1, 3)), 'SIG') AND ;
                  (AT('CON',    UPPER(Campos)) # 0 OR ;
                   AT('IFOR',   UPPER(Campos)) # 0 OR ;
                   AT('ESTOS',  UPPER(Campos)) # 0 OR ;
                   AT('CLI',    UPPER(Campos)) # 0 OR ;
                   AT('VEN',    UPPER(Campos)) # 0 OR ;
                   AT('RESP',   UPPER(Campos)) # 0) AND ;
                  AT('USU',     UPPER(Campos)) = 0 AND ;
                  AT('GR',      UPPER(Campos)) = 0 AND ;
                  AT('NCONTAS', UPPER(Campos)) = 0 AND ;
                  AT('NRCONS',  UPPER(Campos)) = 0 AND ;
                  AT('CCUSTOS', UPPER(Campos)) = 0 ;
            ORDER BY Arquivos ;
            INTO CURSOR csCampos READWRITE
            INDEX ON Arquivos + Campos TAG ArqCpo

            SELECT DISTINCT Arquivos ;
            FROM csCampos ;
            ORDER BY Arquivos ;
            INTO CURSOR csArquivos READWRITE

            loc_nCnt               = RECCOUNT("csArquivos")
            THIS.this_nProgresso   = 0
            THIS.this_cArquivoAtual = ""

            *-- SCAN externo: cada arquivo do catalogo
            SELECT csArquivos
            SCAN
                loc_cArq = ALLTRIM(STRTRAN(csArquivos.Arquivos, '.DBF', ''))
                THIS.this_cArquivoAtual = loc_cArq
                IF VARTYPE(par_oForm) = "O"
                    par_oForm.AtualizarProgresso(loc_cArq, THIS.this_nProgresso)
                ENDIF

                *-- SCAN medio: cada campo deste arquivo
                SELECT csCampos
                SEEK csArquivos.Arquivos
                SCAN WHILE csArquivos.Arquivos = csCampos.Arquivos .AND. !EOF()
                    loc_cCpo = ALLTRIM(csCampos.Campos)
                    THIS.this_cArquivoAtual = loc_cArq + ' / ' + loc_cCpo
                    IF VARTYPE(par_oForm) = "O"
                        par_oForm.AtualizarProgresso(THIS.this_cArquivoAtual, THIS.this_nProgresso)
                    ENDIF

                    *-- SCAN interno: cada par de contas
                    SELECT cursor_4c_Contas
                    SCAN
                        *-- Caso especial: SIGMVCCR/CONTAS -> recalcular saldo antes de UPDATE
                        IF loc_cArq == 'SIGMVCCR' AND loc_cCpo = 'CONTAS'
                            loc_cWhere = "SELECT DISTINCT Emps, Grupos, Contas, Moedas " + ;
                                "FROM SigMvCcr WHERE " + loc_cCpo + " = '" + ;
                                PADR(cursor_4c_Contas.ContaAnt, 10) + "'"
                            SQLEXEC(gnConnHandle, loc_cWhere, "cursor_4c_Mccr")
                            IF USED("cursor_4c_Mccr") AND RECCOUNT("cursor_4c_Mccr") > 0
                                loc_cContaNovSalvo = cursor_4c_Contas.ContaNov
                                SELECT cursor_4c_Mccr
                                SCAN
                                    TRY
                                        =fRecalculaS(cursor_4c_Mccr.Grupos, ;
                                            m.loc_cContaNovSalvo, ;
                                            CTOD('01/01/1900'), ;
                                            cursor_4c_Mccr.Moedas, ;
                                            gnConnHandle)
                                    CATCH TO loc_oErroF
                                        *-- fRecalculaS nao portada - pular recalculo
                                    ENDTRY
                                ENDSCAN
                                IF USED("cursor_4c_Mccr")
                                    USE IN cursor_4c_Mccr
                                ENDIF
                            ENDIF
                        ENDIF

                        *-- Caso especial: SIGCDCLI/ICLIS
                        *-- Verifica se ContaNov ja existe; se sim, deleta ContaAnt e pula UPDATE
                        IF loc_cArq == 'SIGCDCLI' AND loc_cCpo = 'ICLIS'
                            loc_cChkSQL = "SELECT COUNT(*) AS nExiste FROM SigCdCli " + ;
                                "WHERE Iclis = " + EscaparSQL(ALLTRIM(cursor_4c_Contas.ContaNov))
                            loc_nChkRet = SQLEXEC(gnConnHandle, loc_cChkSQL, "cursor_4c_ChkCli")
                            loc_lContaNovExiste = .F.
                            IF loc_nChkRet >= 1 AND RECCOUNT("cursor_4c_ChkCli") > 0
                                SELECT cursor_4c_ChkCli
                                loc_lContaNovExiste = (NVL(cursor_4c_ChkCli.nExiste, 0) > 0)
                            ENDIF
                            IF USED("cursor_4c_ChkCli")
                                USE IN cursor_4c_ChkCli
                            ENDIF

                            IF loc_lContaNovExiste
                                *-- ContaNov ja existe: deletar ContaAnt se solicitado
                                IF par_lApagarContaAntiga
                                    loc_cDelete = "DELETE FROM SigCdCli WHERE Iclis = " + ;
                                        EscaparSQL(ALLTRIM(cursor_4c_Contas.ContaAnt))
                                    SQLEXEC(gnConnHandle, loc_cDelete, "cursor_4c_DelCli")
                                    IF USED("cursor_4c_DelCli")
                                        USE IN cursor_4c_DelCli
                                    ENDIF
                                ENDIF
                                SELECT cursor_4c_Contas
                                LOOP
                            ENDIF
                            *-- ContaNov nao existe: cai no UPDATE padrao abaixo (UPDATE ICLIS)
                        ENDIF

                        *-- Caso especial: SIGMVSLC ou SIGMVEST -> DELETE em vez de UPDATE
                        IF loc_cArq == 'SIGMVSLC' OR loc_cArq == 'SIGMVEST'
                            loc_cDelete = "DELETE FROM " + loc_cArq + ;
                                " WHERE " + loc_cCpo + " = '" + ;
                                cursor_4c_Contas.ContaAnt + "'"
                            loc_nErro = SQLEXEC(gnConnHandle, loc_cDelete, "cursor_4c_DelRet")
                            IF USED("cursor_4c_DelRet")
                                USE IN cursor_4c_DelRet
                            ENDIF
                            IF loc_nErro < 1
                                IF MsgConfirma("Falha de Conex" + CHR(227) + "o!!! " + ;
                                    "Tentar Novamente?", "Erro de Processamento")
                                    SELECT cursor_4c_Contas
                                    SKIP -1
                                    LOOP
                                ELSE
                                    EXIT
                                ENDIF
                            ENDIF
                        ELSE
                            *-- UPDATE padrao (casos gerais e casos especiais com campos extras)
                            IF loc_cArq == 'SIGMVCCR' AND loc_cCpo = 'CONTAS'
                                loc_cUpdate = "UPDATE " + loc_cArq + ;
                                    " SET " + loc_cCpo + " = '" + ;
                                    cursor_4c_Contas.ContaNov + ;
                                    "', GruConMoes = Grupos + '" + ;
                                    cursor_4c_Contas.ContaNov + ;
                                    "' + Moedas WHERE " + loc_cCpo + " = '" + ;
                                    cursor_4c_Contas.ContaAnt + "'"
                            ELSE
                                IF loc_cArq == 'SIGMVHST' AND loc_cCpo = 'ESTOS'
                                    *-- Recalcular historico antes de UPDATE
                                    loc_cWhere = "SELECT DISTINCT Emps, Grupos, Estos, " + ;
                                        "Cpros, CodCors, CodTams FROM SigMvHst WHERE " + ;
                                        loc_cCpo + " = '" + ;
                                        PADR(cursor_4c_Contas.ContaAnt, 10) + "'"
                                    SQLEXEC(gnConnHandle, loc_cWhere, "cursor_4c_His")
                                    IF USED("cursor_4c_His") AND RECCOUNT("cursor_4c_His") > 0
                                        loc_cContaNovSalvo = cursor_4c_Contas.ContaNov
                                        SELECT cursor_4c_His
                                        SCAN
                                            TRY
                                                =fRecalculaP(cursor_4c_His.Emps, ;
                                                    cursor_4c_His.Grupos, ;
                                                    m.loc_cContaNovSalvo, ;
                                                    cursor_4c_His.Cpros, ;
                                                    CTOD('01/01/1900'), ;
                                                    cursor_4c_His.CodCors, ;
                                                    cursor_4c_His.CodTams, ;
                                                    gnConnHandle)
                                                =fRecalculaC(cursor_4c_His.Emps, ;
                                                    cursor_4c_His.Cpros, ;
                                                    CTOD('01/01/1900'), ;
                                                    gnConnHandle)
                                            CATCH TO loc_oErroF
                                                *-- fRecalculaP/C nao portadas - pular recalculo
                                            ENDTRY
                                        ENDSCAN
                                        IF USED("cursor_4c_His")
                                            USE IN cursor_4c_His
                                        ENDIF
                                    ENDIF
                                    loc_cUpdate = "UPDATE " + loc_cArq + ;
                                        " SET " + loc_cCpo + " = '" + ;
                                        cursor_4c_Contas.ContaNov + ;
                                        "', EmpGruEsts = Emps + Grupos + '" + ;
                                        cursor_4c_Contas.ContaNov + ;
                                        "' WHERE " + loc_cCpo + " = '" + ;
                                        cursor_4c_Contas.ContaAnt + "'"
                                ELSE
                                    IF loc_cArq == 'SIGCDCLH' AND loc_cCpo = 'ICLIS'
                                        loc_cUpdate = "UPDATE " + loc_cArq + ;
                                            " SET " + loc_cCpo + " = '" + ;
                                            cursor_4c_Contas.ContaNov + ;
                                            "', GruContas = Grupos + '" + ;
                                            cursor_4c_Contas.ContaNov + ;
                                            "' WHERE " + loc_cCpo + " = '" + ;
                                            cursor_4c_Contas.ContaAnt + "'"
                                    ELSE
                                        loc_cUpdate = "UPDATE " + loc_cArq + ;
                                            " SET " + loc_cCpo + " = '" + ;
                                            cursor_4c_Contas.ContaNov + ;
                                            "' WHERE " + loc_cCpo + " = '" + ;
                                            cursor_4c_Contas.ContaAnt + "'"
                                    ENDIF
                                ENDIF
                            ENDIF

                            loc_nErro = SQLEXEC(gnConnHandle, loc_cUpdate, "cursor_4c_UpdRet")
                            IF USED("cursor_4c_UpdRet")
                                USE IN cursor_4c_UpdRet
                            ENDIF
                            IF loc_nErro < 1
                                IF MsgConfirma("Falha de Conex" + CHR(227) + "o!!! " + ;
                                    "Tentar Novamente?", "Erro de Processamento")
                                    SELECT cursor_4c_Contas
                                    SKIP -1
                                    LOOP
                                ELSE
                                    EXIT
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDSCAN  && cursor_4c_Contas

                    IF loc_nErro < 1
                        EXIT
                    ENDIF
                ENDSCAN  && csCampos WHILE

                IF loc_nErro < 1
                    EXIT
                ENDIF

                *-- Atualizar progresso
                SELECT csArquivos
                loc_nRec             = loc_nRec + 1
                THIS.this_nProgresso  = INT((loc_nRec * 100) / IIF(loc_nCnt > 0, loc_nCnt, 1))
                IF VARTYPE(par_oForm) = "O"
                    par_oForm.AtualizarProgresso(THIS.this_cArquivoAtual, THIS.this_nProgresso)
                ENDIF
            ENDSCAN  && csArquivos

            *-- Recalculos finais (funcoes legado - pular se nao portadas)
            IF loc_nErro > 0
                TRY
                    IF NOT fRecalculaS(.T., gnConnHandle, .T.)
                        loc_nErro = -1
                    ENDIF
                CATCH
                    *-- fRecalculaS nao portada - ignorar
                ENDTRY
            ENDIF
            IF loc_nErro > 0
                TRY
                    IF NOT fRecalculaP(.T., gnConnHandle)
                        loc_nErro = -1
                    ENDIF
                CATCH
                    *-- fRecalculaP nao portada - ignorar
                ENDTRY
            ENDIF
            IF loc_nErro > 0
                TRY
                    IF NOT fRecalculaC(.T., .F., .F., gnConnHandle)
                        loc_nErro = -1
                    ENDIF
                CATCH
                    *-- fRecalculaC nao portada - ignorar
                ENDTRY
            ENDIF

            *-- Commit ou Rollback
            IF loc_nErro < 1
                MsgAviso("Favor reinicializar o processo.", ;
                    "Falha na Conex" + CHR(227) + "o")
                SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION")
            ELSE
                SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 COMMIT TRANSACTION")
                *-- Auditoria de todas as trocas realizadas
                SELECT cursor_4c_Contas
                SCAN
                    THIS.RegistrarAuditoria("TROCA: " + ;
                        ALLTRIM(cursor_4c_Contas.ContaAnt) + ;
                        IIF(par_lApagarContaAntiga, ;
                            " (Exclu" + CHR(237) + "da)", "") + ;
                        " -> " + ALLTRIM(cursor_4c_Contas.ContaNov))
                ENDSCAN
                loc_lSucesso = .T.
            ENDIF

            IF USED("csCampos")
                USE IN csCampos
            ENDIF
            IF USED("csArquivos")
                USE IN csArquivos
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro no Processamento")
            TRY
                SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION")
            CATCH TO loc_oErroTran
                *-- ignorar erro de rollback
            ENDTRY
            IF USED("csCampos")
                USE IN csCampos
            ENDIF
            IF USED("csArquivos")
                USE IN csArquivos
            ENDIF
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor
    * Carrega o par (ContaAnt, ContaNov) do registro corrente de um cursor
    * (tipicamente cursor_4c_Contas) para as propriedades da instancia.
    * Usado antes de operacoes de auditoria/edicao individual do par.
    * par_cAliasCursor: nome do cursor (default "cursor_4c_Contas")
    * Returns: .T. em sucesso, .F. se cursor nao existe ou EOF
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias
        loc_lSucesso = .F.
        loc_cAlias   = IIF(EMPTY(par_cAliasCursor), "cursor_4c_Contas", par_cAliasCursor)
        TRY
            IF USED(loc_cAlias)
                SELECT (loc_cAlias)
                IF NOT EOF() AND NOT BOF()
                    THIS.this_cContaAnt = NVL(EVALUATE(loc_cAlias + ".ContaAnt"), "")
                    THIS.this_cContaNov = NVL(EVALUATE(loc_cAlias + ".ContaNov"), "")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir
    * Insere o par (this_cContaAnt, this_cContaNov) em cursor_4c_Contas apos
    * validar duplicidade via TAG Duplica e igualdade de codigos.
    * Registra auditoria no LogAuditoria em caso de sucesso.
    * Returns: .T. em sucesso, .F. se invalido ou duplicado
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cContaAnt) OR EMPTY(THIS.this_cContaNov)
                MsgAviso("Informe Conta Antiga e Conta Nova.", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            IF ALLTRIM(THIS.this_cContaAnt) == ALLTRIM(THIS.this_cContaNov)
                MsgAviso("Conta Antiga n" + CHR(227) + "o pode ser igual " + ;
                    "" + CHR(224) + " Conta Nova.", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            IF NOT USED("cursor_4c_Contas")
                THIS.InicializarCursorContas()
            ENDIF

            SELECT cursor_4c_Contas
            SET ORDER TO Duplica
            IF SEEK(THIS.this_cContaAnt + THIS.this_cContaNov)
                SET ORDER TO
                MsgAviso("Par de Contas j" + CHR(225) + " existe na lista.", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            SET ORDER TO

            APPEND BLANK
            REPLACE cursor_4c_Contas.ContaAnt WITH THIS.this_cContaAnt, ;
                    cursor_4c_Contas.ContaNov WITH THIS.this_cContaNov

            THIS.RegistrarAuditoria("INCLUSAO_PAR: " + ;
                ALLTRIM(THIS.this_cContaAnt) + " -> " + ;
                ALLTRIM(THIS.this_cContaNov))

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Incluir")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar
    * Atualiza o registro corrente de cursor_4c_Contas com
    * (this_cContaAnt, this_cContaNov) apos validar duplicidade e igualdade.
    * Registra auditoria no LogAuditoria em caso de sucesso.
    * Returns: .T. em sucesso, .F. se invalido, EOF ou duplicado
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_cAntigoAnt, loc_cAntigoNov
        loc_lSucesso  = .F.
        loc_cAntigoAnt = ""
        loc_cAntigoNov = ""
        TRY
            IF EMPTY(THIS.this_cContaAnt) OR EMPTY(THIS.this_cContaNov)
                MsgAviso("Informe Conta Antiga e Conta Nova.", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            IF ALLTRIM(THIS.this_cContaAnt) == ALLTRIM(THIS.this_cContaNov)
                MsgAviso("Conta Antiga n" + CHR(227) + "o pode ser igual " + ;
                    "" + CHR(224) + " Conta Nova.", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            IF NOT USED("cursor_4c_Contas")
                MsgAviso("Nenhum registro selecionado.", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            SELECT cursor_4c_Contas
            IF EOF() OR BOF()
                MsgAviso("Nenhum registro selecionado.", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            loc_cAntigoAnt = cursor_4c_Contas.ContaAnt
            loc_cAntigoNov = cursor_4c_Contas.ContaNov

            *-- Se par nao mudou, nada a fazer
            IF loc_cAntigoAnt == THIS.this_cContaAnt AND ;
               loc_cAntigoNov == THIS.this_cContaNov
                loc_lSucesso = .T.
            ENDIF

            REPLACE cursor_4c_Contas.ContaAnt WITH THIS.this_cContaAnt, ;
                    cursor_4c_Contas.ContaNov WITH THIS.this_cContaNov

            THIS.RegistrarAuditoria("ALTERACAO_PAR: (" + ;
                ALLTRIM(loc_cAntigoAnt) + " -> " + ALLTRIM(loc_cAntigoNov) + ;
                ") para (" + ALLTRIM(THIS.this_cContaAnt) + " -> " + ;
                ALLTRIM(THIS.this_cContaNov) + ")")

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

