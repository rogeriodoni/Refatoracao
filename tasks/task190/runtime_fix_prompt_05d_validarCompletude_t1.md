# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[FormSigPrGlx.prg] Procedure vazia (sem codigo): HabilitarCampos
[FormSigPrGlx.prg] Procedure vazia (sem codigo): AjustarBotoesPorModo
[FormSigPrGlx.prg] Indicador de pendencia: *-- Status atual da selecao (Pendente

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGlx.prg):
*==============================================================================
* FormSigPrGlx.prg - Previa da Globalizacao / Reserva Automatica
* Tipo: OPERACIONAL (layout customizado, form filho recebe ParentForm)
* Herda de: FormBase
* Legado: SigPrGlx.SCX
*
* Fase 3/8: Form - Estrutura Base
*   DEFINE CLASS, Init, InicializarForm, ConfigurarPageFrame,
*   ConfigurarCabecalho, ConfigurarAguarde, TornarControlesVisiveis, Destroy
*==============================================================================

DEFINE CLASS FormSigPrGlx AS FormBase

    *-- Dimensoes e aparencia (PILAR 1: Width=800, Height=600 do legado)
    Width        = 800
    Height       = 600
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    BorderStyle  = 2
    DataSession  = 2
    ClipControls = .F.
    Themes       = .F.
    Caption      = "Previa da Globalizacao"
    FontName     = "Tahoma"
    FontSize     = 8

    *-- Referencias e estado operacional
    this_oBusinessObject = .NULL.
    this_oParentForm     = .NULL.

    *-- Flags de modo de operacao (recebidos via Init do form pai)
    this_lReserva    = .F.
    this_nEmphPdr    = 0
    this_lAutomatico = .F.
    this_nNumeroOp   = 0
    this_lPorDestino = .F.

    *-- Estado de edicao interativa nas grades (equivalentes a Liberado/OldValue/AntValue do legado)
    this_lLiberado   = .F.
    this_nOldValue   = 0
    this_nAntValue   = 0

    *--------------------------------------------------------------------------
    * Init - Recebe parametros do form pai, compartilha datasession e prepara execucao
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oParentForm, par_dData, par_lReservaAuto, par_nGerEmphPdr, par_lAutom, par_nNumeroOp, par_lPorDestino)

        *-- Guardar referencia ao form pai
        THIS.this_oParentForm = par_oParentForm

        *-- Compartilhar datasession com o form pai para acessar TmpFinalg/TmpFinal/etc.
        IF VARTYPE(par_oParentForm) = "O"
            THIS.DataSessionId = par_oParentForm.DataSessionId
        ENDIF

        *-- Salvar parametros operacionais
        THIS.this_lReserva    = IIF(VARTYPE(par_lReservaAuto) = "L", par_lReservaAuto, .F.)
        THIS.this_nEmphPdr    = IIF(VARTYPE(par_nGerEmphPdr)  = "N", par_nGerEmphPdr,  0)
        THIS.this_lAutomatico = IIF(VARTYPE(par_lAutom)       = "L", par_lAutom,       .F.)
        THIS.this_nNumeroOp   = IIF(VARTYPE(par_nNumeroOp)    = "N", par_nNumeroOp,    0)
        THIS.this_lPorDestino = IIF(VARTYPE(par_lPorDestino)  = "L", par_lPorDestino,  .F.)

        *-- Caption dinamico conforme modo de operacao
        THIS.Caption = "Pr" + CHR(233) + "via da Globaliza" + CHR(231) + CHR(227) + "o"
        IF THIS.this_lReserva
            THIS.Caption = "Pr" + CHR(233) + "via da Reserva Autom" + CHR(225) + "tica"
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria BO e monta estrutura visual base do form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            SET DATE TO BRITISH
            SET CENTURY ON

            *-- Criar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrGlxBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar SigPrGlxBO.", "Erro")
            ELSE
                *-- Repassar flags de modo ao BO
                WITH THIS.this_oBusinessObject
                    .this_lReserva    = THIS.this_lReserva
                    .this_nEmphPdr    = THIS.this_nEmphPdr
                    .this_lAutomatico = THIS.this_lAutomatico
                    .this_nNumeroOp   = THIS.this_nNumeroOp
                    .this_lPorDestino = THIS.this_lPorDestino
                ENDWITH

                *-- Montar estrutura visual
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarAguarde()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                *-- Definir caption do cabecalho na Page1 e Page2
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = ;
                    "Opera" + CHR(231) + CHR(245) + "es Detalhadas"
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = ;
                    "Opera" + CHR(231) + CHR(245) + "es Detalhadas"

                *-- Ativar PageFrame
                THIS.pgf_4c_Paginas.Visible   = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1

                THIS.TornarControlesVisiveis(THIS)

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar formul" + CHR(225) + "rio FormSigPrGlx: " + ;
                    loc_oErro.Message + " [Ln:" + TRANSFORM(loc_oErro.LineNo) + ;
                    " Proc:" + loc_oErro.Procedure + "]", "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com 6 paginas operacionais
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        WITH THIS.pgf_4c_Paginas
            .PageCount   = 6
            .Top         = -27
            .Left        = -1
            .Width       = 804
            .Height      = 635
            .Tabs        = .F.
            .BorderWidth = 0
            .Themes      = .F.

            .Page1.Caption   = "Dados"
            .Page1.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
            .Page1.ForeColor = RGB(0,128,192)

            .Page2.Caption   = "Opera" + CHR(231) + CHR(245) + "es Detalhadas"
            .Page2.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
            .Page2.ForeColor = RGB(0,128,192)

            .Page3.Caption   = "Totais por Linha"
            .Page3.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
            .Page3.ForeColor = RGB(0,128,192)
            .Page3.Enabled   = .F.

            .Page4.Caption   = "Selecionar Estoque"
            .Page4.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
            .Page4.ForeColor = RGB(0,128,192)
            .Page4.Enabled   = .F.

            .Page5.Caption   = "Disponivel/Tamanho"
            .Page5.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
            .Page5.ForeColor = RGB(0,128,192)
            .Page5.Enabled   = .F.

            .Page6.Caption   = "Requisi" + CHR(231) + CHR(227) + "o"
            .Page6.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
            .Page6.ForeColor = RGB(0,128,192)
            .Page6.Enabled   = .F.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Header escuro na Page1 com titulo do form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = -1
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100,100,100)
            .BorderWidth = 0

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .AutoSize      = .F.
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .Caption       = ""
                .Height        = 40
                .Left          = 10
                .Top           = 18
                .Width         = THIS.Width
                .ForeColor     = RGB(0,0,0)
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .AutoSize      = .F.
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .Caption       = ""
                .Height        = 46
                .Left          = 10
                .Top           = 17
                .Width         = THIS.Width
                .ForeColor     = RGB(255,255,255)
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarAguarde - Container de espera durante processamento
    * Fica no form raiz (nao dentro de Page) com Visible=.F.
    * Tornado visivel em MostrarAguarde() e oculto em OcultarAguarde()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarAguarde()
        THIS.AddObject("cnt_4c_Aguarde", "Container")
        WITH THIS.cnt_4c_Aguarde
            .Top         = 251
            .Left        = 142
            .Width       = 516
            .Height      = 98
            .Visible     = .F.
            .BackStyle   = 1
            .BackColor   = RGB(255,255,255)
            .BorderWidth = 0

            .AddObject("lbl_4c_AguardeMsg", "Label")
            WITH .lbl_4c_AguardeMsg
                .AutoSize  = .F.
                .Caption   = "Aguarde..."
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 12
                .BackStyle = 0
                .Top       = 18
                .Left      = 208
                .Width     = 105
                .Height    = 29
            ENDWITH

            .AddObject("lbl_4c_Processando", "Label")
            WITH .lbl_4c_Processando
                .AutoSize  = .F.
                .Caption   = "Processando Dados ......"
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Top       = 52
                .Left      = 137
                .Width     = 242
                .Height    = 27
            ENDWITH

            .AddObject("lbl_4c_Mensagem", "Label")
            WITH .lbl_4c_Mensagem
                .AutoSize  = .F.
                .Caption   = ""
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Top       = 93
                .Left      = 131
                .Width     = 233
                .Height    = 25
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * MostrarAguarde - Exibe container de espera com mensagem opcional
    *--------------------------------------------------------------------------
    PROCEDURE MostrarAguarde(par_cMensagem)
        THIS.cnt_4c_Aguarde.lbl_4c_Mensagem.Caption = IIF(VARTYPE(par_cMensagem) = "C", par_cMensagem, "")
        THIS.cnt_4c_Aguarde.Visible = .T.
        THIS.cnt_4c_Aguarde.ZOrder(0)
        THIS.LockScreen = .T.
        THIS.LockScreen = .F.
        DOEVENTS
    ENDPROC

    *--------------------------------------------------------------------------
    * OcultarAguarde - Oculta container de espera
    *--------------------------------------------------------------------------
    PROCEDURE OcultarAguarde()
        THIS.cnt_4c_Aguarde.Visible = .F.
        THIS.LockScreen = .T.
        THIS.LockScreen = .F.
        DOEVENTS
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis pos-AddObject
    * FILTRO: cnt_4c_Aguarde permanece Visible=.F. (toggleado por MostrarAguarde)
    *--------------------------------------------------------------------------
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl, loc_p

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)

            IF VARTYPE(loc_oControl) != "O"
                LOOP
            ENDIF

            *-- Containers flutuantes: recursao nos filhos mas sem alterar Visible do container
            IF UPPER(loc_oControl.Name) = "CNT_4C_AGUARDE"
                THIS.TornarControlesVisiveis(loc_oControl)
                LOOP
            ENDIF

            *-- Controles com visibilidade gerenciada por logica operacional
            IF INLIST(UPPER(loc_oControl.Name), "BTN_4C_PEDRAS", "BTN_4C_SELESTOQUE", ;
                      "BTN_4C_DISPONIVEL", "IMG_4C_FIGJPG", "IMG_4C_FIGOPE")
                *-- Container preserva estado inicial, mas recursar para sub-controles Visible=.T.
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
                LOOP
            ENDIF

            IF PEMSTATUS(loc_oControl, "Visible", 5)
                loc_oControl.Visible = .T.
            ENDIF

            *-- Trata PageFrame: itera Pages
            IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                FOR loc_p = 1 TO loc_oControl.PageCount
                    THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_p))
                ENDFOR
            ENDIF

            *-- Trata containers/pages com filhos
            IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                THIS.TornarControlesVisiveis(loc_oControl)
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos ao fechar
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        THIS.this_oParentForm = .NULL.
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Monta controles de todas as Pages operacionais
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPag1, loc_oPag2, loc_oPag3, loc_oPag4, loc_oPag5, loc_oPag6
        LOCAL loc_oGrade, loc_oErr

        TRY
            *-- ===== PAGE 1: Grade principal e controles operacionais =====
            loc_oPag1 = THIS.pgf_4c_Paginas.Page1

            *-- Shapes decorativos (bordas informativas)
            loc_oPag1.AddObject("shp_4c_BoxInfo", "Shape")
            WITH loc_oPag1.shp_4c_BoxInfo
                .Top = 12
                .Left = 10
                .Width = 342
                .Height = 110
                .BackStyle = 0
            ENDWITH

            loc_oPag1.AddObject("shp_4c_BoxEmpresa", "Shape")
            WITH loc_oPag1.shp_4c_BoxEmpresa
                .Top = 9
                .Left = 605
                .Width = 173
                .Height = 38
                .BackStyle = 0
            ENDWITH

            *-- Container5 legado: barra de informacoes do produto
            loc_oPag1.AddObject("cnt_4c_BarraInfo", "Container")
            WITH loc_oPag1.cnt_4c_BarraInfo
                .Top = 129
                .Left = 36
                .Width = 727
                .Height = 40
                .BackStyle = 1
                .BackColor = RGB(220,220,220)
                .BorderWidth = 0

                .AddObject("lbl_4c_Periodo", "Label")
                WITH .lbl_4c_Periodo
                    .AutoSize = .F.
                    .Caption = "Per"+CHR(237)+"odo: xx meses"
                    .Top = 2
                    .Left = 8
                    .Width = 105
                    .Height = 15
                    .BackStyle = 0
                    .FontName = "Tahoma"
                    .FontSize = 8
                ENDWITH

                .AddObject("lbl_4c_RefAnalisada", "Label")
                WITH .lbl_4c_RefAnalisada
                    .AutoSize = .F.
                    .Caption = "Referencia Analisada :"
                    .Top = 18
                    .Left = 8
                    .Width = 127
                    .Height = 15
                    .BackStyle = 0
                    .FontName = "Tahoma"
                    .FontSize = 8
                ENDWITH

                .AddObject("txt_4c_CodProd", "TextBox")
                WITH .txt_4c_CodProd
                    .Top = 16
                    .Left = 141
                    .Width = 108
                    .Height = 19
                    .ReadOnly = .T.
                    .BackColor = RGB(220,220,220)
                    .FontName = "Tahoma"
                    .FontSize = 8
                ENDWITH

                .AddObject("lbl_4c_QVendida", "Label")
                WITH .lbl_4c_QVendida
                    .AutoSize = .F.
                    .Caption = "Qtde Vendida :"
                    .Top = 18
                    .Left = 269
                    .Width = 83
                    .Height = 15
                    .BackStyle = 0
                    .FontName = "Tahoma"
                    .FontSize = 8
                ENDWITH

                .AddObject("txt_4c_TotVenda", "TextBox")
                WITH .txt_4c_TotVenda
                    .Top = 17
                    .Left = 349
                    .Width = 80
                    .Height = 19
                    .ReadOnly = .T.
                    .Format = "@Z 9999999.999"
                    .BackColor = RGB(220,220,220)
                    .FontName = "Tahoma"
                    .FontSize = 8
                ENDWITH

                .AddObject("lbl_4c_QtdMinima", "Label")
                WITH .lbl_4c_QtdMinima
                    .AutoSize = .F.
                    .Caption = "Qtde M"+CHR(237)+"nima Para Produ"+CHR(231)+CHR(227)+"o :"
                    .Top = 18
                    .Left = 448
                    .Width = 164
                    .Height = 15
                    .BackStyle = 0
                    .FontName = "Tahoma"
                    .FontSize = 8
                ENDWITH

                .AddObject("txt_4c_MinProd", "TextBox")
                WITH .txt_4c_MinProd
                    .Top = 17
                    .Left = 623
                    .Width = 80
                    .Height = 19
                    .ReadOnly = .T.
                    .Format = "@Z 9999999.999"
                    .BackColor = RGB(220,220,220)
                    .FontName = "Tahoma"
                    .FontSize = 8
                ENDWITH
            ENDWITH

            *-- Grade principal: GradeItens com 10 colunas
            loc_oPag1.AddObject("grd_4c_GradeItens", "Grid")
            loc_oGrade = loc_oPag1.grd_4c_GradeItens
            WITH loc_oGrade
                .Top = 173
                .Left = 52
                .Width = 586
                .Height = 173
                .ColumnCount = 10
                .ReadOnly = .F.
                .GridLines = 1
                .Themes = .F.
                .FontName = "Tahoma"
                .FontSize = 8

                WITH .Column1
                    .Header1.Caption = "Produto"
                    .Width = 70
                    .ReadOnly = .T.
                    .ControlSource = "TmpFinalg.Cpros"
                ENDWITH
                WITH .Column2
                    .Header1.Caption = "Cor"
                    .Width = 35
                    .ReadOnly = .T.
                    .ControlSource = "TmpFinalg.CodCors"
                ENDWITH
                WITH .Column3
                    .Header1.Caption = ""
                    .Width = 18
                    .ReadOnly = .T.
                    .ControlSource = "TmpFinalg.Linhas"
                ENDWITH
                WITH .Column4
                    .Header1.Caption = "N"+CHR(250)+"mero"
                    .Width = 55
                    .ReadOnly = .T.
                    .ControlSource = "TmpFinalg.Nopes"
                ENDWITH
                WITH .Column5
                    .Header1.Caption = "Qtde Pedido"
                    .Width = 65
                    .ReadOnly = .T.
                    .ControlSource = "TmpFinalg.Saldo"
                    .Text1.Format = "@Z 9999999.999"
                ENDWITH
                WITH .Column6
                    .Header1.Caption = "Produzir"
                    .Width = 65
                    .ReadOnly = .T.
                    .ControlSource = "TmpFinalg.Fabrs"
                    .Text1.Format = "@Z 9999999.999"
                ENDWITH
                WITH .Column7
                    .Header1.Caption = "Qtd Produ"+CHR(231)+CHR(227)+"o"
                    .Width = 65
                    .ReadOnly = .F.
                    .ControlSource = "TmpFinalg.Produzir"
                    .Text1.Format = "@Z 9999999.999"
                ENDWITH
                WITH .Column8
                    .Header1.Caption = "Produzir Estq"
                    .Width = 65
                    .ReadOnly = .T.
                    .ControlSource = "TmpFinalg.Produzir2"
                    .Text1.Format = "@Z 9999999.999"
                ENDWITH
                WITH .Column9
                    .Header1.Caption = "Tam"
                    .Width = 30
                    .ReadOnly = .T.
                    .ControlSource = "TmpFinalg.CodTams"
                ENDWITH
                WITH .Column10
                    .Header1.Caption = "Qtd Estoque"
                    .Width = 65
                    .ReadOnly = .F.
                    .ControlSource = "TmpFinalg.Estoque"
                    .Text1.Format = "@Z 9999999.999"
                ENDWITH

                .RecordSource = "TmpFinalg"
            ENDWITH

            *-- Totais da grade principal (abaixo do grid)
            loc_oPag1.AddObject("lbl_4c_TotaisGrd", "Label")
            WITH loc_oPag1.lbl_4c_TotaisGrd
                .AutoSize = .F.
                .Caption = "Totais :"
                .Top = 348
                .Left = 224
                .Width = 42
                .Height = 17
                .BackStyle = 0
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag1.AddObject("txt_4c_TotQtd", "TextBox")
            WITH loc_oPag1.txt_4c_TotQtd
                .Top = 346
                .Left = 271
                .Width = 67
                .Height = 19
                .ReadOnly = .T.
                .Format = "@Z 9999999.999"
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag1.AddObject("txt_4c_TotPrdc", "TextBox")
            WITH loc_oPag1.txt_4c_TotPrdc
                .Top = 346
                .Left = 339
                .Width = 67
                .Height = 19
                .ReadOnly = .T.
                .Format = "@Z 9999999.999"
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag1.AddObject("txt_4c_TotEst", "TextBox")
            WITH loc_oPag1.txt_4c_TotEst
                .Top = 346
                .Left = 407
                .Width = 68
                .Height = 19
                .ReadOnly = .T.
                .Format = "@Z 9999999.999"
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag1.AddObject("txt_4c_TotPrz", "TextBox")
            WITH loc_oPag1.txt_4c_TotPrz
                .Top = 346
                .Left = 476
                .Width = 67
                .Height = 19
                .ReadOnly = .T.
                .Format = "@Z 9999999.999"
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag1.AddObject("txt_4c_TotPrze", "TextBox")
            WITH loc_oPag1.txt_4c_TotPrze
                .Top = 346
                .Left = 543
                .Width = 75
                .Height = 19
                .ReadOnly = .T.
                .Format = "@Z 9999999.999"
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            *-- Container3 legado: Estoque Disponivel (grid TmpSaldG filtrado por SET KEY)
            loc_oPag1.AddObject("cnt_4c_GradeDisp", "Container")
            WITH loc_oPag1.cnt_4c_GradeDisp
                .Top = 371
                .Left = 50
                .Width = 363
                .Height = 186
                .BackStyle = 1
                .BackColor = RGB(255,255,255)
                .BorderWidth = 1

                .AddObject("lbl_4c_TituloDisp", "Label")
                WITH .lbl_4c_TituloDisp
                    .AutoSize = .F.
                    .Caption = "Estoque Dispon"+CHR(237)+"vel"
                    .Top = 1
                    .Left = 0
                    .Width = 363
                    .Height = 16
                    .BackStyle = 0
                    .FontName = "Tahoma"
                    .FontSize = 8
                    .FontBold = .T.
                ENDWITH

                .AddObject("grd_4c_GradeDisp", "Grid")
                WITH .grd_4c_GradeDisp
                    .Top = 15
                    .Left = 3
                    .Width = 358
                    .Height = 147
                    .ColumnCount = 6
                    .ReadOnly = .T.
                    .GridLines = 1
                    .Themes = .F.
                    .FontName = "Tahoma"
                    .FontSize = 8

                    WITH .Column1
                        .Header1.Caption = "Grupo"
                        .ControlSource = "TmpSaldG.Grupos"
                        .RecordMark   = .F.
                        .DeleteMark   = .F.
                    ENDWITH
                    WITH .Column2
                        .Header1.Caption = "Conta"
                        .ControlSource = "TmpSaldG.Estos"
                    ENDWITH
                    WITH .Column3
                        .Header1.Caption = "Atual"
                        .ControlSource = "TmpSaldG.Saldo"
                        .Text1.Format = "@Z 9999999.999"
                    ENDWITH
                    WITH .Column4
                        .Header1.Caption = "Utilizado"
                    ENDWITH
                    WITH .Column5
                        .Header1.Caption = "Dispon"+CHR(237)+"vel"
                        .ControlSource = "TmpSaldG.Disps"
                        .Text1.Format = "@Z 9999999.999"
                    ENDWITH
                    WITH .Column6
                        .Header1.Caption = "Prior"
                        .ControlSource = "TmpSaldG.Priors"
                    ENDWITH

                    .RecordSource = "TmpSaldG"
                ENDWITH

                .AddObject("lbl_4c_TotDisp", "Label")
                WITH .lbl_4c_TotDisp
                    .AutoSize = .F.
                    .Caption = "Totais :"
                    .Top = 163
                    .Left = 128
                    .Width = 42
                    .Height = 17
                    .BackStyle = 0
                    .FontName = "Tahoma"
                    .FontSize = 8
                ENDWITH

                .AddObject("txt_4c_DispQtd", "TextBox")
                WITH .txt_4c_DispQtd
                    .Top = 161
                    .Left = 174
                    .Width = 58
                    .Height = 19
                    .ReadOnly = .T.
                    .Format = "@Z 9999999.999"
                    .FontName = "Tahoma"
                    .FontSize = 8
                ENDWITH

                .AddObject("txt_4c_DispEst", "TextBox")
                WITH .txt_4c_DispEst
                    .Top = 161
                    .Left = 234
                    .Width = 58
                    .Height = 19
                    .ReadOnly = .T.
                    .Format = "@Z 9999999.999"
                    .FontName = "Tahoma"
                    .FontSize = 8
                ENDWITH

                .AddObject("txt_4c_DispPrz", "TextBox")
                WITH .txt_4c_DispPrz
                    .Top = 161
                    .Left = 292
                    .Width = 58
                    .Height = 19
                    .ReadOnly = .T.
                    .Format = "@Z 9999999.999"
                    .FontName = "Tahoma"
                    .FontSize = 8
                ENDWITH
            ENDWITH

            *-- Container1 legado: Estoque Em Producao
            loc_oPag1.AddObject("cnt_4c_GradeProd", "Container")
            WITH loc_oPag1.cnt_4c_GradeProd
                .Top = 371
                .Left = 418
                .Width = 308
                .Height = 136
                .BackStyle = 1
                .BackColor = RGB(255,255,255)
                .BorderWidth = 1

                .AddObject("lbl_4c_TituloProd", "Label")
                WITH .lbl_4c_TituloProd
                    .AutoSize = .F.
                    .Caption = "Estoque Em Produ"+CHR(231)+CHR(227)+"o"
                    .Top = 1
                    .Left = 1
                    .Width = 305
                    .Height = 16
                    .BackStyle = 0
                    .FontName = "Tahoma"
                    .FontSize = 8
                    .FontBold = .T.
                ENDWITH

                .AddObject("grd_4c_GradeProd", "Grid")
                WITH .grd_4c_GradeProd
                    .Top = 15
                    .Left = 2
                    .Width = 303
                    .Height = 99
                    .ColumnCount = 5
                    .ReadOnly = .T.
                    .GridLines = 1
                    .Themes = .F.
                    .FontName = "Tahoma"
                    .FontSize = 8

                    WITH .Column1
                        .Header1.Caption = "Fase"
                        .ControlSource = "TmpSaldG.Grupos"
                        .RecordMark   = .F.
                        .DeleteMark   = .F.
                    ENDWITH
                    WITH .Column2
                        .Header1.Caption = "Disponivel"
                        .ControlSource = "TmpSaldG.Disps"
                        .Text1.Format = "@Z 9999999.999"
                    ENDWITH
                    WITH .Column3
                        .Header1.Caption = "Utilizado"
                        .ControlSource = "TmpSaldG.Saldo"
                        .Text1.Format = "@Z 9999999.999"
                    ENDWITH
                    WITH .Column4
                        .Header1.Caption = "Prior"
                        .ControlSource = "TmpSaldG.Priors"
                    ENDWITH
                    WITH .Column5
                        .Header1.Caption = "Nop"
                    ENDWITH

                    .RecordSource = "TmpSaldU"
                ENDWITH

                .AddObject("lbl_4c_TotProd", "Label")
                WITH .lbl_4c_TotProd
                    .AutoSize = .F.
                    .Caption = "Totais :"
                    .Top = 115
                    .Left = 102
                    .Width = 42
                    .Height = 17
                    .BackStyle = 0
                    .FontName = "Tahoma"
                    .FontSize = 8
                ENDWITH

                .AddObject("txt_4c_ProdQtd", "TextBox")
                WITH .txt_4c_ProdQtd
                    .Top = 113
                    .Left = 145
                    .Width = 61
                    .Height = 19
                    .ReadOnly = .T.
                    .Format = "@Z 9999999.999"
                    .FontName = "Tahoma"
                    .FontSize = 8
                ENDWITH

                .AddObject("txt_4c_ProdEst", "TextBox")
                WITH .txt_4c_ProdEst
                    .Top = 113
                    .Left = 207
                    .Width = 61
                    .Height = 19
                    .ReadOnly = .T.
                    .Format = "@Z 9999999.999"
                    .FontName = "Tahoma"
                    .FontSize = 8
                ENDWITH
            ENDWITH

            *-- Imagem do produto (oculta ate click ou AfterRowColChange)
            loc_oPag1.AddObject("img_4c_FigJpg", "Image")
            WITH loc_oPag1.img_4c_FigJpg
                .Top = 255
                .Left = 646
                .Width = 122
                .Height = 89
                .Visible = .F.
                .Stretch = 2
            ENDWITH

            *-- Botoes operacionais (top=2, alinhados a direita)
            loc_oPag1.AddObject("btn_4c_Pedras", "CommandButton")
            WITH loc_oPag1.btn_4c_Pedras
                .Top = 2
                .Left = 348
                .Width = 75
                .Height = 75
                .Caption = "Requisi"+CHR(231)+CHR(245)+"es"
                .Visible = .F.
                .Themes = .F.
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag1.AddObject("btn_4c_SelEstoque", "CommandButton")
            WITH loc_oPag1.btn_4c_SelEstoque
                .Top = 2
                .Left = 423
                .Width = 75
                .Height = 75
                .Caption = "Estoques"
                .Visible = .F.
                .Themes = .F.
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag1.AddObject("btn_4c_Disponivel", "CommandButton")
            WITH loc_oPag1.btn_4c_Disponivel
                .Top = 2
                .Left = 498
                .Width = 75
                .Height = 75
                .Caption = "Dispon"+CHR(237)+"veis"
                .Visible = .F.
                .Themes = .F.
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag1.AddObject("btn_4c_TotLinha", "CommandButton")
            WITH loc_oPag1.btn_4c_TotLinha
                .Top = 2
                .Left = 573
                .Width = 75
                .Height = 75
                .Caption = "Total/Linhas"
                .Themes = .F.
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag1.AddObject("btn_4c_Processar", "CommandButton")
            WITH loc_oPag1.btn_4c_Processar
                .Top = 2
                .Left = 648
                .Width = 75
                .Height = 75
                .Caption = "Processar"
                .Themes = .F.
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag1.AddObject("btn_4c_Cancelar", "CommandButton")
            WITH loc_oPag1.btn_4c_Cancelar
                .Top = 2
                .Left = 723
                .Width = 75
                .Height = 75
                .Caption = "Encerrar"
                .Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Themes = .F.
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            *-- Botao icone-only: autorizar alteracao de quantidade (requer Themes=.T.)
            loc_oPag1.AddObject("btn_4c_Alteraqtd", "CommandButton")
            WITH loc_oPag1.btn_4c_Alteraqtd
                .Top = 189
                .Left = 687
                .Width = 40
                .Height = 40
                .Caption = ""
                .Themes = .T.
                .Picture         = gc_4c_CaminhoIcones + "operacional_liberar_40.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "operacional_liberar_40.jpg"
                .ToolTipText = "Autorizar Altera"+CHR(231)+CHR(227)+"o de Quantidade"
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            *-- BINDEVENTs: grade principal e botoes Page1
            loc_oGrade = loc_oPag1.grd_4c_GradeItens
            BINDEVENT(loc_oGrade,               "AfterRowColChange", THIS, "GradeItensAfterRowColChange")
            BINDEVENT(loc_oGrade.Column3.Text1,  "Click",            THIS, "GradeItensCol3Click")
            BINDEVENT(loc_oGrade.Column7.Text1,  "GotFocus",         THIS, "GradeItensCol7GotFocus")
            BINDEVENT(loc_oGrade.Column7.Text1,  "Valid",            THIS, "GradeItensCol7Valid")
            BINDEVENT(loc_oGrade.Column7.Text1,  "KeyPress",       THIS, "GradeItensCol7LostFocus")
            BINDEVENT(loc_oGrade.Column8.Text1,  "KeyPress",       THIS, "GradeItensCol8LostFocus")
            BINDEVENT(loc_oGrade.Column10.Text1, "GotFocus",         THIS, "GradeItensCol10GotFocus")
            BINDEVENT(loc_oGrade.Column10.Text1, "Valid",            THIS, "GradeItensCol10Valid")
            BINDEVENT(loc_oGrade.Column10.Text1, "KeyPress",       THIS, "GradeItensCol10LostFocus")

            BINDEVENT(loc_oPag1.img_4c_FigJpg,    "Click", THIS, "ImgFigJpgClick")
            BINDEVENT(loc_oPag1.btn_4c_Pedras,     "Click", THIS, "BtnPedrasClick")
            BINDEVENT(loc_oPag1.btn_4c_SelEstoque, "Click", THIS, "BtnSelEstoqueClick")
            BINDEVENT(loc_oPag1.btn_4c_Disponivel, "Click", THIS, "BtnDisponivelClick")
            BINDEVENT(loc_oPag1.btn_4c_TotLinha,   "Click", THIS, "BtnTotLinhaClick")
            BINDEVENT(loc_oPag1.btn_4c_Processar,  "Click", THIS, "BtnProcessarClick")
            BINDEVENT(loc_oPag1.btn_4c_Cancelar,   "Click", THIS, "BtnCancelarClick")
            BINDEVENT(loc_oPag1.btn_4c_Alteraqtd,  "Click", THIS, "BtnAlteraqtdClick")

            *-- ===== PAGE 2: Operacoes Detalhadas =====
            loc_oPag2 = THIS.pgf_4c_Paginas.Page2

            loc_oPag2.AddObject("lbl_4c_QtdSel", "Label")
            WITH loc_oPag2.lbl_4c_QtdSel
                .AutoSize = .F.
                .Caption = "Qtd Selecionada :"
                .Top = 164
                .Left = 383
                .Width = 119
                .Height = 15
                .BackStyle = 0
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag2.AddObject("txt_4c_TotSEst", "TextBox")
            WITH loc_oPag2.txt_4c_TotSEst
                .Top = 162
                .Left = 501
                .Width = 67
                .Height = 19
                .ReadOnly = .T.
                .Format = "@Z 9999999.999"
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag2.AddObject("txt_4c_TotSPrc", "TextBox")
            WITH loc_oPag2.txt_4c_TotSPrc
                .Top = 162
                .Left = 567
                .Width = 67
                .Height = 19
                .ReadOnly = .T.
                .Format = "@Z 9999999.999"
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag2.AddObject("grd_4c_GradeOpe", "Grid")
            WITH loc_oPag2.grd_4c_GradeOpe
                .Top = 181
                .Left = 53
                .Width = 703
                .Height = 189
                .ColumnCount = 10
                .ReadOnly = .F.
                .GridLines = 1
                .Themes = .F.
                .FontName = "Tahoma"
                .FontSize = 8

                WITH .Column1
                    .Header1.Caption = "Produto"
                    .Width = 70
                    .ReadOnly = .T.
                    .ControlSource = "TmpFinal.Cpros"
                    .RecordMark   = .F.
                    .DeleteMark   = .F.
                ENDWITH
                WITH .Column2
                    .Header1.Caption = "Cor"
                    .Width = 35
                    .ReadOnly = .T.
                    .ControlSource = "TmpFinal.CodCors"
                ENDWITH
                WITH .Column3
                    .Header1.Caption = "Opera"+CHR(231)+CHR(227)+"o"
                    .Width = 60
                    .ReadOnly = .T.
                    .ControlSource = "TmpFinal.Dopes"
                ENDWITH
                WITH .Column4
                    .Header1.Caption = "N"+CHR(250)+"mero"
                    .Width = 55
                    .ReadOnly = .T.
                    .ControlSource = "TmpFinal.Nops"
                ENDWITH
                WITH .Column5
                    .Header1.Caption = "Quantidade"
                    .Width = 65
                    .ReadOnly = .T.
                    .ControlSource = "TmpFinal.Saldo"
                    .Text1.Format = "@Z 9999999.999"
                ENDWITH
                WITH .Column6
                    .Header1.Caption = "Produzir"
                    .Width = 65
                    .ReadOnly = .T.
                    .ControlSource = "TmpFinal.Produzir"
                    .Text1.Format = "@Z 9999999.999"
                ENDWITH
                WITH .Column7
                    .Header1.Caption = "Estoque"
                    .Width = 65
                    .ReadOnly = .F.
                    .ControlSource = "TmpFinal.Estoque"
                    .Text1.Format = "@Z 9999999.999"
                ENDWITH
                WITH .Column8
                    .Header1.Caption = "Obs"
                    .Width = 55
                    .ReadOnly = .T.
                    .ControlSource = "TmpFinal.UsuLibs"
                ENDWITH
                WITH .Column9
                    .Header1.Caption = "Tam"
                    .Width = 30
                    .ReadOnly = .T.
                    .ControlSource = "TmpFinal.CodTams"
                ENDWITH
                WITH .Column10
                    .Header1.Caption = "Produ"+CHR(231)+CHR(227)+"o"
                    .Width = 65
                    .ReadOnly = .F.
                    .ControlSource = "TmpFinal.Fabrs"
                    .Text1.Format = "@Z 9999999.999"
                ENDWITH

                .RecordSource = "TmpFinal"
            ENDWITH

            loc_oPag2.AddObject("lbl_4c_TotP2Lbl", "Label")
            WITH loc_oPag2.lbl_4c_TotP2Lbl
                .AutoSize = .F.
                .Caption = "Totais :"
                .Top = 372
                .Left = 403
                .Width = 42
                .Height = 17
                .BackStyle = 0
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag2.AddObject("txt_4c_P2TotQtd", "TextBox")
            WITH loc_oPag2.txt_4c_P2TotQtd
                .Top = 370
                .Left = 449
                .Width = 68
                .Height = 19
                .ReadOnly = .T.
                .Format = "@Z 9999999.999"
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag2.AddObject("txt_4c_P2TotEst", "TextBox")
            WITH loc_oPag2.txt_4c_P2TotEst
                .Top = 370
                .Left = 516
                .Width = 67
                .Height = 19
                .ReadOnly = .T.
                .Format = "@Z 9999999.999"
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag2.AddObject("txt_4c_P2TotPrc", "TextBox")
            WITH loc_oPag2.txt_4c_P2TotPrc
                .Top = 370
                .Left = 581
                .Width = 67
                .Height = 19
                .ReadOnly = .T.
                .Format = "@Z 9999999.999"
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag2.AddObject("txt_4c_P2TotPrz", "TextBox")
            WITH loc_oPag2.txt_4c_P2TotPrz
                .Top = 370
                .Left = 648
                .Width = 67
                .Height = 19
                .ReadOnly = .T.
                .Format = "@Z 9999999.999"
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag2.AddObject("lbl_4c_ObsItem", "Label")
            WITH loc_oPag2.lbl_4c_ObsItem
                .AutoSize = .F.
                .Caption = "Observa"+CHR(231)+CHR(227)+"o do Item :"
                .Top = 400
                .Left = 221
                .Width = 119
                .Height = 17
                .BackStyle = 0
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag2.AddObject("edt_4c_ObsItens", "EditBox")
            WITH loc_oPag2.edt_4c_ObsItens
                .Top = 415
                .Left = 221
                .Width = 396
                .Height = 69
                .ReadOnly = .T.
                .ScrollBars = 2
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag2.AddObject("img_4c_FigOpe", "Image")
            WITH loc_oPag2.img_4c_FigOpe
                .Top = 394
                .Left = 73
                .Width = 135
                .Height = 92
                .Visible = .F.
                .Stretch = 2
            ENDWITH

            loc_oPag2.AddObject("btn_4c_VoltarP2", "CommandButton")
            WITH loc_oPag2.btn_4c_VoltarP2
                .Top = 12
                .Left = 704
                .Width = 75
                .Height = 75
                .Caption = "Voltar"
                .Themes = .F.
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
            BINDEVENT(loc_oPag2.btn_4c_VoltarP2, "Click", THIS, "BtnVoltarPage2Click")

            *-- BINDEVENTs: grade de operacoes detalhadas (Page2) - colunas ReadOnly redirecionam foco p/ Col7
            LOCAL loc_oGradeOpe
            loc_oGradeOpe = loc_oPag2.grd_4c_GradeOpe
            BINDEVENT(loc_oGradeOpe,                "AfterRowColChange", THIS, "GradeOpeAfterRowColChange")
            BINDEVENT(loc_oGradeOpe.Column1.Text1,  "GotFocus", THIS, "GradeOpeColsGotFocus")
            BINDEVENT(loc_oGradeOpe.Column2.Text1,  "GotFocus", THIS, "GradeOpeColsGotFocus")
            BINDEVENT(loc_oGradeOpe.Column3.Text1,  "GotFocus", THIS, "GradeOpeColsGotFocus")
            BINDEVENT(loc_oGradeOpe.Column4.Text1,  "GotFocus", THIS, "GradeOpeColsGotFocus")
            BINDEVENT(loc_oGradeOpe.Column5.Text1,  "GotFocus", THIS, "GradeOpeColsGotFocus")
            BINDEVENT(loc_oGradeOpe.Column6.Text1,  "GotFocus", THIS, "GradeOpeColsGotFocus")
            BINDEVENT(loc_oGradeOpe.Column8.Text1,  "GotFocus", THIS, "GradeOpeColsGotFocus")
            BINDEVENT(loc_oGradeOpe.Column9.Text1,  "GotFocus", THIS, "GradeOpeColsGotFocus")
            BINDEVENT(loc_oGradeOpe.Column7.Text1,  "GotFocus", THIS, "GradeOpeCol7GotFocus")
            BINDEVENT(loc_oGradeOpe.Column7.Text1,  "Valid",    THIS, "GradeOpeCol7Valid")
            BINDEVENT(loc_oGradeOpe.Column7.Text1,  "KeyPress",THIS, "GradeOpeCol7LostFocus")
            BINDEVENT(loc_oGradeOpe.Column10.Text1, "GotFocus", THIS, "GradeOpeCol10GotFocus")
            BINDEVENT(loc_oGradeOpe.Column10.Text1, "Valid",    THIS, "GradeOpeCol10Valid")
            BINDEVENT(loc_oGradeOpe.Column10.Text1, "KeyPress",THIS, "GradeOpeCol10LostFocus")

            *-- ===== PAGE 3: Totais por Linha =====
            loc_oPag3 = THIS.pgf_4c_Paginas.Page3

            loc_oPag3.AddObject("lbl_4c_TitLinha", "Label")
            WITH loc_oPag3.lbl_4c_TitLinha
                .AutoSize = .F.
                .Caption = "Totais por Linha"
                .Top = 147
                .Left = 173
                .Width = 157
                .Height = 25
                .BackStyle = 0
                .FontName = "Tahoma"
                .FontSize = 10
                .FontBold = .T.
            ENDWITH

            loc_oPag3.AddObject("grd_4c_GradeLinhas", "Grid")
            WITH loc_oPag3.grd_4c_GradeLinhas
                .Top = 181
                .Left = 167
                .Width = 438
                .Height = 292
                .ColumnCount = 5
                .ReadOnly = .T.
                .GridLines = 1
                .Themes = .F.
                .FontName = "Tahoma"
                .FontSize = 8

                WITH .Column1
                    .Header1.Caption = "Linha"
                    .ControlSource = "TmpLinha.Linhas"
                    .RecordMark   = .F.
                    .DeleteMark   = .F.
                ENDWITH
                WITH .Column2
                    .Header1.Caption = "Quantidade"
                    .ControlSource = "TmpLinha.Saldo"
                    .Text1.Format = "@Z 9999999.999"
                ENDWITH
                WITH .Column3
                    .Header1.Caption = "Estoque"
                    .ControlSource = "TmpLinha.Estoque"
                    .Text1.Format = "@Z 9999999.999"
                ENDWITH
                WITH .Column4
                    .Header1.Caption = "Produ"+CHR(231)+CHR(227)+"o"
                    .ControlSource = "TmpLinha.Fabrs"
                    .Text1.Format = "@Z 9999999.999"
                ENDWITH
                WITH .Column5
                    .Header1.Caption = "Produzir"
                    .ControlSource = "TmpLinha.Produzir"
                    .Text1.Format = "@Z 9999999.999"
                ENDWITH
            ENDWITH

            loc_oPag3.AddObject("btn_4c_VoltarP3", "CommandButton")
            WITH loc_oPag3.btn_4c_VoltarP3
                .Top = 12
                .Left = 704
                .Width = 75
                .Height = 75
                .Caption = "Voltar"
                .Themes = .F.
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
            BINDEVENT(loc_oPag3.btn_4c_VoltarP3, "Click", THIS, "BtnVoltarPage3Click")

            *-- ===== PAGE 4: Selecionar Estoque =====
            loc_oPag4 = THIS.pgf_4c_Paginas.Page4

            loc_oPag4.AddObject("lbl_4c_TitSelEst", "Label")
            WITH loc_oPag4.lbl_4c_TitSelEst
                .AutoSize = .F.
                .Caption = "Selecionar Estoque"
                .Top = 138
                .Left = 197
                .Width = 184
                .Height = 25
                .BackStyle = 0
                .FontName = "Tahoma"
                .FontSize = 10
                .FontBold = .T.
            ENDWITH

            loc_oPag4.AddObject("txt_4c_P4CodProd", "TextBox")
            WITH loc_oPag4.txt_4c_P4CodProd
                .Top = 138
                .Left = 479
                .Width = 80
                .Height = 19
                .ReadOnly = .T.
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag4.AddObject("grd_4c_GradeSelEst", "Grid")
            WITH loc_oPag4.grd_4c_GradeSelEst
                .Top = 169
                .Left = 191
                .Width = 370
                .Height = 244
                .ColumnCount = 5
                .ReadOnly = .F.
                .GridLines = 1
                .Themes = .F.
                .FontName = "Tahoma"
                .FontSize = 8

                WITH .Column1
                    .Header1.Caption = "Grupo"
                    .ReadOnly = .T.
                    .ControlSource = "TmpDisp.Grupos"
                    .RecordMark   = .F.
                    .DeleteMark   = .F.
                ENDWITH
                WITH .Column2
                    .Header1.Caption = "Conta"
                    .ReadOnly = .T.
                    .ControlSource = "TmpDisp.Estos"
                ENDWITH
                WITH .Column3
                    .Header1.Caption = "Prior"
                    .ReadOnly = .T.
                    .ControlSource = "TmpDisp.Priors"
                ENDWITH
                WITH .Column4
                    .Header1.Caption = "Disponivel"
                    .ReadOnly = .T.
                    .ControlSource = "TmpDisp.Disps"
                    .Text1.Format = "@Z 9999999.999"
                ENDWITH
                WITH .Column5
                    .Header1.Caption = "Utilizar"
                    .ReadOnly = .F.
                    .ControlSource = "TmpDisp.Utilizar"
                    .Text1.Format = "@Z 9999999.999"
                ENDWITH
            ENDWITH

            loc_oPag4.AddObject("lbl_4c_P4QtPed", "Label")
            WITH loc_oPag4.lbl_4c_P4QtPed
                .AutoSize = .F.
                .Caption = "Qtde Pedida :"
                .Top = 418
                .Left = 220
                .Width = 82
                .Height = 16
                .BackStyle = 0
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag4.AddObject("txt_4c_P4QtPedida", "TextBox")
            WITH loc_oPag4.txt_4c_P4QtPedida
                .Top = 413
                .Left = 312
                .Width = 67
                .Height = 23
                .ReadOnly = .T.
                .Format = "@Z 9999999.999"
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag4.AddObject("lbl_4c_P4QtSel", "Label")
            WITH loc_oPag4.lbl_4c_P4QtSel
                .AutoSize = .F.
                .Caption = "Qtde Selecionada :"
                .Top = 437
                .Left = 192
                .Width = 110
                .Height = 16
                .BackStyle = 0
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag4.AddObject("txt_4c_P4QtSelec", "TextBox")
            WITH loc_oPag4.txt_4c_P4QtSelec
                .Top = 436
                .Left = 312
                .Width = 67
                .Height = 23
                .ReadOnly = .T.
                .Format = "@Z 9999999.999"
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag4.AddObject("btn_4c_VoltarP4", "CommandButton")
            WITH loc_oPag4.btn_4c_VoltarP4
                .Top = 12
                .Left = 704
                .Width = 75
                .Height = 75
                .Caption = "Voltar"
                .Themes = .F.
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
            BINDEVENT(loc_oPag4.btn_4c_VoltarP4, "Click", THIS, "BtnVoltarPage4Click")
            *-- BINDEVENTs: Page4 grade editavel (Column5 Utilizar)
            BINDEVENT(loc_oPag4.grd_4c_GradeSelEst.Column5.Text1, "Valid",     THIS, "GradeSelEstCol5Valid")
            BINDEVENT(loc_oPag4.grd_4c_GradeSelEst.Column5.Text1, "KeyPress", THIS, "GradeSelEstCol5LostFocus")

            *-- ===== PAGE 5: Disponivel/Tamanho =====
            loc_oPag5 = THIS.pgf_4c_Paginas.Page5

            loc_oPag5.AddObject("lbl_4c_TitDisp", "Label")
            WITH loc_oPag5.lbl_4c_TitDisp
                .AutoSize = .F.
                .Caption = "Selecionar Tamanhos"
                .Top = 150
                .Left = 246
                .Width = 205
                .Height = 25
                .BackStyle = 0
                .FontName = "Tahoma"
                .FontSize = 10
                .FontBold = .T.
            ENDWITH

            loc_oPag5.AddObject("txt_4c_P5CodProd", "TextBox")
            WITH loc_oPag5.txt_4c_P5CodProd
                .Top = 151
                .Left = 486
                .Width = 80
                .Height = 19
                .ReadOnly = .T.
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag5.AddObject("grd_4c_GradeDisp", "Grid")
            WITH loc_oPag5.grd_4c_GradeDisp
                .Top = 181
                .Left = 239
                .Width = 327
                .Height = 228
                .ColumnCount = 5
                .ReadOnly = .F.
                .GridLines = 1
                .Themes = .F.
                .FontName = "Tahoma"
                .FontSize = 8

                WITH .Column1
                    .Header1.Caption = "Produto"
                    .ReadOnly = .T.
                    .ControlSource = "TmpDisp.Cpros"
                    .RecordMark   = .F.
                    .DeleteMark   = .F.
                ENDWITH
                WITH .Column2
                    .Header1.Caption = "Cor"
                    .ReadOnly = .T.
                    .ControlSource = "TmpDisp.CodCors"
                ENDWITH
                WITH .Column3
                    .Header1.Caption = "Tam"
                    .ReadOnly = .T.
                    .ControlSource = "TmpDisp.CodTams"
                ENDWITH
                WITH .Column4
                    .Header1.Caption = "Disponivel"
                    .ReadOnly = .T.
                    .ControlSource = "TmpDisp.Disps"
                    .Text1.Format = "@Z 9999999.999"
                ENDWITH
                WITH .Column5
                    .Header1.Caption = "Utilizar"
                    .ReadOnly = .F.
                    .ControlSource = "TmpDisp.Utilizar"
                    .Text1.Format = "@Z 9999999.999"
                ENDWITH
            ENDWITH

            loc_oPag5.AddObject("lbl_4c_P5QtPed", "Label")
            WITH loc_oPag5.lbl_4c_P5QtPed
                .AutoSize = .F.
                .Caption = "Qtde Pedida :"
                .Top = 415
                .Left = 289
                .Width = 82
                .Height = 16
                .BackStyle = 0
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag5.AddObject("txt_4c_P5QtPedida", "TextBox")
            WITH loc_oPag5.txt_4c_P5QtPedida
                .Top = 410
                .Left = 379
                .Width = 67
                .Height = 23
                .ReadOnly = .T.
                .Format = "@Z 9999999.999"
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag5.AddObject("lbl_4c_P5QtSel", "Label")
            WITH loc_oPag5.lbl_4c_P5QtSel
                .AutoSize = .F.
                .Caption = "Qtde Selecionada :"
                .Top = 434
                .Left = 261
                .Width = 110
                .Height = 16
                .BackStyle = 0
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag5.AddObject("txt_4c_P5QtSelec", "TextBox")
            WITH loc_oPag5.txt_4c_P5QtSelec
                .Top = 433
                .Left = 379
                .Width = 67
                .Height = 23
                .ReadOnly = .T.
                .Format = "@Z 9999999.999"
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag5.AddObject("btn_4c_VoltarP5", "CommandButton")
            WITH loc_oPag5.btn_4c_VoltarP5
                .Top = 12
                .Left = 704
                .Width = 75
                .Height = 75
                .Caption = "Voltar"
                .Themes = .F.
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
            BINDEVENT(loc_oPag5.btn_4c_VoltarP5, "Click", THIS, "BtnVoltarPage5Click")
            *-- BINDEVENTs: Page5 grade editavel (Cols 1-4 redirecionam foco; Col5 valida)
            BINDEVENT(loc_oPag5.grd_4c_GradeDisp.Column1.Text1, "GotFocus", THIS, "GradeDispColsGotFocus")
            BINDEVENT(loc_oPag5.grd_4c_GradeDisp.Column2.Text1, "GotFocus", THIS, "GradeDispColsGotFocus")
            BINDEVENT(loc_oPag5.grd_4c_GradeDisp.Column3.Text1, "GotFocus", THIS, "GradeDispColsGotFocus")
            BINDEVENT(loc_oPag5.grd_4c_GradeDisp.Column4.Text1, "GotFocus", THIS, "GradeDispColsGotFocus")
            BINDEVENT(loc_oPag5.grd_4c_GradeDisp.Column5.Text1, "Valid",    THIS, "GradeDispCol5Valid")

            *-- ===== PAGE 6: Requisicoes de Material =====
            loc_oPag6 = THIS.pgf_4c_Paginas.Page6

            loc_oPag6.AddObject("lbl_4c_TitReq", "Label")
            WITH loc_oPag6.lbl_4c_TitReq
                .AutoSize = .F.
                .Caption = "Requisi"+CHR(231)+CHR(227)+"o Manual de Material"
                .Top = 168
                .Left = 132
                .Width = 294
                .Height = 25
                .BackStyle = 0
                .FontName = "Tahoma"
                .FontSize = 10
                .FontBold = .T.
            ENDWITH

            loc_oPag6.AddObject("txt_4c_P6CodProd", "TextBox")
            WITH loc_oPag6.txt_4c_P6CodProd
                .Top = 169
                .Left = 487
                .Width = 80
                .Height = 19
                .ReadOnly = .T.
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag6.AddObject("grd_4c_GradePedra", "Grid")
            WITH loc_oPag6.grd_4c_GradePedra
                .Top = 197
                .Left = 119
                .Width = 500
                .Height = 261
                .ColumnCount = 5
                .ReadOnly = .F.
                .GridLines = 1
                .Themes = .F.
                .FontName = "Tahoma"
                .FontSize = 8

                WITH .Column1
                    .Header1.Caption = "Produto"
                    .ReadOnly = .F.
                    .ControlSource = "SelPedra.Cpros"
                    .RecordMark   = .F.
                    .DeleteMark   = .F.
                ENDWITH
                WITH .Column2
                    .Header1.Caption = "Descri"+CHR(231)+CHR(227)+"o"
                    .ReadOnly = .T.
                    .ControlSource = "SelPedra.Dpros"
                ENDWITH
                WITH .Column3
                    .Header1.Caption = "Uni"
                    .ReadOnly = .T.
                    .ControlSource = "SelPedra.Cunis"
                ENDWITH
                WITH .Column4
                    .Header1.Caption = "Qtde"
                    .ReadOnly = .F.
                    .ControlSource = "SelPedra.Qtds"
                    .Text1.Format = "@Z 9999999.999"
                ENDWITH
                WITH .Column5
                    .Header1.Caption = "Produto"
                    .ReadOnly = .F.
                    .ControlSource = "SelPedra.Cpro2s"
                ENDWITH
            ENDWITH

            loc_oPag6.AddObject("btn_4c_VoltarP6", "CommandButton")
            WITH loc_oPag6.btn_4c_VoltarP6
                .Top = 12
                .Left = 704
                .Width = 75
                .Height = 75
                .Caption = "Voltar"
                .Themes = .F.
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
            BINDEVENT(loc_oPag6.btn_4c_VoltarP6, "Click", THIS, "BtnVoltarPage6Click")

            *-- BINDEVENTs: Page6 GradePedra - lookup produto e edicao condicional
            BINDEVENT(loc_oPag6.grd_4c_GradePedra.Column1.Text1, "Valid",     THIS, "GradePedraCol1Valid")
            BINDEVENT(loc_oPag6.grd_4c_GradePedra.Column4.Text1, "When",      THIS, "GradePedraCol4When")
            BINDEVENT(loc_oPag6.grd_4c_GradePedra.Column5.Text1, "When",      THIS, "GradePedraCol5When")
            BINDEVENT(loc_oPag6.grd_4c_GradePedra.Column5.Text1, "Valid",     THIS, "GradePedraCol5Valid")
            BINDEVENT(loc_oPag6.grd_4c_GradePedra.Column5.Text1, "KeyPress", THIS, "GradePedraCol5LostFocus")

        CATCH TO loc_oErr
            MsgErro("Erro em ConfigurarPaginaLista: " + loc_oErr.Message + ;
                    " [Ln:" + TRANSFORM(loc_oErr.LineNo) + ;
                    " Proc:" + loc_oErr.Procedure + "]", "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Page2 (Operacoes Detalhadas): cabecalho + primeiros
    * 50% dos campos auxiliares (info do produto selecionado, painel de selecao).
    * Page2 ja possui grid principal e totais (montados em ConfigurarPaginaLista);
    * este metodo COMPLEMENTA com o header cinza padrao do sistema e o painel de
    * informacoes do produto ativo (codigo/descricao/cor/tamanho + qtde do pedido).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPag2, loc_oErr

        TRY
            loc_oPag2 = THIS.pgf_4c_Paginas.Page2

            *-- ===== Cabecalho cinza padrao (equivalente ao cntSombra do framework) =====
            loc_oPag2.AddObject("cnt_4c_Cabecalho", "Container")
            WITH loc_oPag2.cnt_4c_Cabecalho
                .Top         = -1
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BackStyle   = 1
                .BackColor   = RGB(100,100,100)
                .BorderWidth = 0

                .AddObject("lbl_4c_Sombra", "Label")
                WITH .lbl_4c_Sombra
                    .AutoSize      = .F.
                    .FontBold      = .T.
                    .FontName      = "Tahoma"
                    .FontSize      = 18
                    .FontUnderline = .F.
                    .WordWrap      = .T.
                    .Alignment     = 0
                    .BackStyle     = 0
                    .Caption       = ""
                    .Height        = 40
                    .Left          = 10
                    .Top           = 18
                    .Width         = THIS.Width
                    .ForeColor     = RGB(0,0,0)
                ENDWITH

                .AddObject("lbl_4c_Titulo", "Label")
                WITH .lbl_4c_Titulo
                    .AutoSize      = .F.
                    .FontBold      = .T.
                    .FontName      = "Tahoma"
                    .FontSize      = 18
                    .WordWrap      = .T.
                    .Alignment     = 0
                    .BackStyle     = 0
                    .Caption       = ""
                    .Height        = 46
                    .Left          = 10
                    .Top           = 17
                    .Width         = THIS.Width
                    .ForeColor     = RGB(255,255,255)
                ENDWITH
            ENDWITH

            *-- ===== Painel de informacoes do produto ativo (parte 1: identificacao) =====
            *-- Container branco a esquerda com os dados do produto selecionado na Page1
            *-- (equivalente ao BarraInfo da Page1, mas focado nas Operacoes desta pagina)
            loc_oPag2.AddObject("cnt_4c_InfoProd", "Container")
            WITH loc_oPag2.cnt_4c_InfoProd
                .Top         = 100
                .Left        = 53
                .Width       = 703
                .Height      = 55
                .BackStyle   = 1
                .BackColor   = RGB(240,240,240)
                .BorderWidth = 1

                *-- Rotulo: Produto
                .AddObject("lbl_4c_LblProduto", "Label")
                WITH .lbl_4c_LblProduto
                    .AutoSize  = .F.
                    .Caption   = "Produto :"
                    .Top       = 6
                    .Left      = 8
                    .Width     = 55
                    .Height    = 17
                    .BackStyle = 0
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .FontBold  = .T.
                ENDWITH

                *-- Codigo do produto selecionado (readonly, alimentado por AfterRowColChange)
                .AddObject("txt_4c_DadosCodProd", "TextBox")
                WITH .txt_4c_DadosCodProd
                    .Top         = 4
                    .Left        = 66
                    .Width       = 108
                    .Height      = 19
                    .ReadOnly    = .T.
                    .BackColor   = RGB(255,255,255)
                    .FontName    = "Tahoma"
                    .FontSize    = 8
                    .Value       = ""
                ENDWITH

                *-- Descricao do produto (readonly)
                .AddObject("lbl_4c_LblDescricao", "Label")
                WITH .lbl_4c_LblDescricao
                    .AutoSize  = .F.
                    .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
                    .Top       = 6
                    .Left      = 180
                    .Width     = 65
                    .Height    = 17
                    .BackStyle = 0
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .FontBold  = .T.
                ENDWITH

                .AddObject("txt_4c_DadosDescProd", "TextBox")
                WITH .txt_4c_DadosDescProd
                    .Top         = 4
                    .Left        = 248
                    .Width       = 220
                    .Height      = 19
                    .ReadOnly    = .T.
                    .BackColor   = RGB(255,255,255)
                    .FontName    = "Tahoma"
                    .FontSize    = 8
                    .Value       = ""
                ENDWITH

                *-- Cor selecionada
                .AddObject("lbl_4c_LblCor", "Label")
                WITH .lbl_4c_LblCor
                    .AutoSize  = .F.
                    .Caption   = "Cor :"
                    .Top       = 6
                    .Left      = 476
                    .Width     = 30
                    .Height    = 17
                    .BackStyle = 0
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .FontBold  = .T.
                ENDWITH

                .AddObject("txt_4c_DadosCodCor", "TextBox")
                WITH .txt_4c_DadosCodCor
                    .Top         = 4
                    .Left        = 508
                    .Width       = 50
                    .Height      = 19
                    .ReadOnly    = .T.
                    .BackColor   = RGB(255,255,255)
                    .FontName    = "Tahoma"
                    .FontSize    = 8
                    .Value       = ""
                ENDWITH

                *-- Tamanho selecionado
                .AddObject("lbl_4c_LblTam", "Label")
                WITH .lbl_4c_LblTam
                    .AutoSize  = .F.
                    .Caption   = "Tam :"
                    .Top       = 6
                    .Left      = 566
                    .Width     = 32
                    .Height    = 17
                    .BackStyle = 0
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .FontBold  = .T.
                ENDWITH

                .AddObject("txt_4c_DadosCodTam", "TextBox")
                WITH .txt_4c_DadosCodTam
                    .Top         = 4
                    .Left        = 600
                    .Width       = 50
                    .Height      = 19
                    .ReadOnly    = .T.
                    .BackColor   = RGB(255,255,255)
                    .FontName    = "Tahoma"
                    .FontSize    = 8
                    .Value       = ""
                ENDWITH

                *-- Segunda linha: quantidade solicitada + quantidade selecionada + status
                .AddObject("lbl_4c_LblQtdSol", "Label")
                WITH .lbl_4c_LblQtdSol
                    .AutoSize  = .F.
                    .Caption   = "Qtde Solicitada :"
                    .Top       = 30
                    .Left      = 8
                    .Width     = 100
                    .Height    = 17
                    .BackStyle = 0
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .FontBold  = .T.
                ENDWITH

                .AddObject("txt_4c_DadosQtdSol", "TextBox")
                WITH .txt_4c_DadosQtdSol
                    .Top         = 28
                    .Left        = 112
                    .Width       = 80
                    .Height      = 19
                    .ReadOnly    = .T.
                    .Format      = "@Z 9999999.999"
                    .BackColor   = RGB(255,255,255)
                    .FontName    = "Tahoma"
                    .FontSize    = 8
                    .Value       = 0
                ENDWITH

                *-- Status atual da selecao (Pendente / Em selecao / Concluida)
                .AddObject("lbl_4c_LblStatus", "Label")
                WITH .lbl_4c_LblStatus
                    .AutoSize  = .F.
                    .Caption   = "Status :"
                    .Top       = 30
                    .Left      = 210
                    .Width     = 48
                    .Height    = 17
                    .BackStyle = 0
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .FontBold  = .T.
                ENDWITH

                .AddObject("lbl_4c_DadosStatus", "Label")
                WITH .lbl_4c_DadosStatus
                    .AutoSize  = .F.
                    .Caption   = "Aguardando sele" + CHR(231) + CHR(227) + "o"
                    .Top       = 30
                    .Left      = 260
                    .Width     = 208
                    .Height    = 17
                    .BackStyle = 0
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDWITH

        CATCH TO loc_oErr
            MsgErro("Erro em ConfigurarPaginaDados: " + loc_oErr.Message + ;
                    " [Ln:" + TRANSFORM(loc_oErr.LineNo) + ;
                    " Proc:" + loc_oErr.Procedure + "]", "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Controla navegacao entre as 6 pages operacionais
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        WITH THIS.pgf_4c_Paginas
            .Page1.Enabled = .T.
            .Page2.Enabled = .T.
            .Page3.Enabled = .F.
            .Page4.Enabled = .F.
            .Page5.Enabled = .F.
            .Page6.Enabled = .F.

            DO CASE
                CASE par_nPagina = 1
                    .ActivePage = 1
                    IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_GradeItens", 5)
                        THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.SetFocus
                    ENDIF
                CASE par_nPagina = 2
                    .ActivePage = 2
                CASE par_nPagina = 3
                    .Page1.Enabled = .F.
                    .Page2.Enabled = .F.
                    .Page3.Enabled = .T.
                    .ActivePage = 3
                CASE par_nPagina = 4
                    .Page1.Enabled = .F.
                    .Page2.Enabled = .F.
                    .Page4.Enabled = .T.
                    .ActivePage = 4
                CASE par_nPagina = 5
                    .Page1.Enabled = .F.
                    .Page2.Enabled = .F.
                    .Page5.Enabled = .T.
                    .ActivePage = 5
                CASE par_nPagina = 6
                    .Page1.Enabled = .F.
                    .Page2.Enabled = .F.
                    .Page6.Enabled = .T.
                    .ActivePage = 6
            ENDCASE
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeItensAfterRowColChange - Atualiza paineis ao mudar linha na grade
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensAfterRowColChange
        LPARAMETERS par_nColIndex
        LOCAL loc_lcSql, loc_lcArquivo, loc_lcFoto

        IF NOT USED("TmpFinalg") OR EOF("TmpFinalg")
            RETURN
        ENDIF

        *-- Posicionar TmpSaldo na linha atual
        IF USED("TmpSaldo")
            =SEEK(TmpFinalg.Cpros + TmpFinalg.CodCors + TmpFinalg.CodTams, "TmpSaldo")
        ENDIF

        *-- Filtrar TmpSaldG para linha atual
        IF USED("TmpSaldG")
            SELECT TmpSaldG
            SET ORDER TO Cpros
            SET KEY TO TmpFinalg.Cpros + TmpFinalg.CodCors + TmpFinalg.CodTams
            GO TOP
        ENDIF

        *-- Atualizar Container3 (Estoque Disponivel)
        WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_GradeDisp
            IF USED("TmpSaldo") AND NOT EOF("TmpSaldo")
                .txt_4c_DispQtd.Value = TmpSaldo.Saldo
                .txt_4c_DispEst.Value = TmpSaldo.Saldo - TmpSaldo.Disps
                .txt_4c_DispPrz.Value = TmpSaldo.Disps
            ELSE
                .txt_4c_DispQtd.Value = 0
                .txt_4c_DispEst.Value = 0
                .txt_4c_DispPrz.Value = 0
            ENDIF
            .lbl_4c_TituloDisp.Caption = "Estoque Dispon"+CHR(237)+"vel " + ;
                ALLTRIM(TmpFinalg.Cpros) + ;
                IIF(NOT EMPTY(TmpFinalg.CodCors), " Cor:"+ALLTRIM(TmpFinalg.CodCors), "") + ;
                IIF(NOT EMPTY(TmpFinalg.CodTams), " Tam:"+ALLTRIM(TmpFinalg.CodTams), "")
            .grd_4c_GradeDisp.Refresh
            .Visible     = .T.
        ENDWITH

        *-- Atualizar barra de informacoes (Container5)
        WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_BarraInfo
            .txt_4c_CodProd.Value = ALLTRIM(TmpFinalg.Cpros)
            .txt_4c_MinProd.Value = TmpFinalg.QtdMins
            .Visible     = .T.
        ENDWITH

        *-- Atualizar Container1 (Producao em andamento)
        THIS.pgf_4c_Paginas.Page1.cnt_4c_GradeProd.grd_4c_GradeProd.Refresh

        *-- Carregar imagem do produto
        loc_lcSql = [SELECT cpros, figjpgs FROM SigCdPro WHERE Cpros = ] + ;
                    EscaparSQL(TmpFinalg.Cpros)
        IF SQLEXEC(gnConnHandle, loc_lcSql, "cursor_4c_ProdFig") >= 1
            WITH THIS.pgf_4c_Paginas.Page1.img_4c_FigJpg
                IF NOT EMPTY(cursor_4c_ProdFig.FigJpgs) AND NOT ISNULL(cursor_4c_ProdFig.FigJpgs)
                    loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
                    loc_lcFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_ProdFig.FigJpgs, ;
                        "data:image/png;base64,", ""), ;
                        "data:image/jpeg;base64,", ""), ;
                        "data:image/jpg;base64,", ""), 14)
                    =STRTOFILE(loc_lcFoto, loc_lcArquivo)
                    .Picture = loc_lcArquivo
                    .Visible = .T.
                ELSE
                    .Picture = ""
                    .Visible = .F.
                ENDIF
            ENDWITH
            USE IN cursor_4c_ProdFig
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeItensCol3Click - Click na coluna 3 navega para Page2 (Operacoes)
    * Equivalente ao PageDados.Activate do legado: filtra TmpFinal e inicializa totais
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensCol3Click
        LOCAL loc_oPag2

        *-- Filtrar TmpFinal para o produto/cor/tam corrente (SET KEY dinamico)
        IF USED("TmpFinal") AND USED("TmpFinalg") AND NOT EOF("TmpFinalg")
            SELECT TmpFinal
            SET ORDER TO Cpros
            SET KEY TO TmpFinalg.Cpros + TmpFinalg.CodCors + TmpFinalg.CodTams
            GO TOP
        ENDIF

        *-- Inicializar totais da secao "Qtd Selecionada" em Page2
        IF USED("TmpFinalg") AND NOT EOF("TmpFinalg")
            loc_oPag2 = THIS.pgf_4c_Paginas.Page2
            loc_oPag2.txt_4c_TotSEst.Value = TmpFinalg.Estoque
            loc_oPag2.txt_4c_TotSPrc.Value = TmpFinalg.Fabrs
            THIS.AtualizarTotaisPage2()
        ENDIF

        THIS.pgf_4c_Paginas.Page2.Enabled = .T.
        THIS.pgf_4c_Paginas.ActivePage = 2
        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_GradeOpe", 5)
            THIS.pgf_4c_Paginas.Page2.grd_4c_GradeOpe.SetFocus
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeItensCol7GotFocus - Salva valor anterior de Produzir
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensCol7GotFocus
        THIS.this_nOldValue = THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.Column7.Text1.Value
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeItensCol7Valid - Valida e aplica nova quantidade de Producao
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensCol7Valid
        LOCAL loc_lResultado, loc_nNewVal, loc_nMaxProd, loc_nQtdMin
        loc_lResultado = .T.
        loc_nNewVal    = THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.Column7.Text1.Value

        *-- Garantir registro em TmpSaldU para este produto
        IF USED("TmpSaldU") AND NOT SEEK(TmpFinalg.Cpros, "TmpSaldU", "Cpros")
            INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinalg.Cpros)
        ENDIF

        *-- Checar se produto usa selecao manual de OP
        IF USED("TmpSaldU") AND loc_nNewVal <> THIS.this_nOldValue AND TmpSaldU.KeySelmp
            IF NOT MsgConfirma("Produto com Sele"+CHR(231)+CHR(227)+"o Manual de OP. "+CHR(13)+ ;
                    "O sistema ir"+CHR(225)+" acionar o modo autom"+CHR(225)+"tico. Deseja Continuar?")
                THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.Column7.Text1.Value = THIS.this_nOldValue
                RETURN .F.
            ENDIF
        ENDIF

        loc_nMaxProd = IIF(USED("TmpFinalg") AND NOT EOF("TmpFinalg"), ;
                           TmpFinalg.Saldo - TmpFinalg.Estoque, 0)
        loc_nQtdMin  = IIF(USED("TmpFinalg") AND NOT EOF("TmpFinalg"), TmpFinalg.QtdMins, 0)

        DO CASE
            CASE loc_nNewVal = THIS.this_nOldValue
                *-- Sem alteracao: aceitar
            CASE loc_nNewVal < 0
                MsgAviso("A quantidade n"+CHR(227)+"o pode ser um valor negativo...")
                THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.Column7.Text1.Value = THIS.this_nOldValue
                loc_lResultado = .F.
            CASE loc_nNewVal > loc_nMaxProd
                MsgAviso("A quantidade n"+CHR(227)+"o pode ser maior que a quantidade dispon"+CHR(237)+"vel para produ"+CHR(231)+CHR(227)+"o...")
                THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.Column7.Text1.Value = THIS.this_nOldValue
                loc_lResultado = .F.
            OTHERWISE
                *-- Atualizar TmpFinalg: Produzir, UsuLibs, Produzir2
                REPLACE Produzir  WITH loc_nNewVal, ;
                        UsuLibs   WITH " ", ;
                        Produzir2 WITH IIF(loc_nQtdMin > 0 AND loc_nNewVal < loc_nQtdMin AND loc_nNewVal > 0, ;
                                         loc_nQtdMin - loc_nNewVal, 0) ;
                IN TmpFinalg
                *-- Resetar flag de selecao manual de OP
                IF USED("TmpSaldU") AND NOT EOF("TmpSaldU")
                    REPLACE KeySelmp WITH .F. IN TmpSaldU
                ENDIF
                *-- Atualizar disponibilidade em TmpSaldG
                IF USED("TmpSaldo") AND NOT EOF("TmpSaldo") AND USED("TmpSaldG")
                    LOCAL loc_nDisps
                    loc_nDisps = TmpSaldo.Disps
                    SELECT TmpSaldG
                    SCAN
                        REPLACE Disps WITH loc_nDisps IN TmpSaldG
                    ENDSCAN
                ENDIF
        ENDCASE

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeItensCol7LostFocus - Atualiza totais apos edicao de Producao
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensCol7LostFocus
        THIS.AtualizarTotaisGrade()
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeItensCol8LostFocus - Fecha janela de edicao de Produzir Estq
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensCol8LostFocus
        THIS.this_lLiberado = .F.
        THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.Column8.ReadOnly = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeItensCol10GotFocus - Salva valor anterior de Estoque e trata Disponivel
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensCol10GotFocus
        LOCAL loc_lcSql
        THIS.this_nOldValue = THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.Column10.Text1.Value
        THIS.pgf_4c_Paginas.Page1.btn_4c_Disponivel.Visible = .F.

        *-- Mostrar botao Disponivel apenas para reserva de produtos tipo 3 ou 4
        IF THIS.this_lReserva AND USED("TmpFinalg") AND NOT EOF("TmpFinalg") AND TmpFinalg.Estoque = 0
            loc_lcSql = [SELECT g.TipoEstos FROM SigCdPro p ] + ;
                        [INNER JOIN SigCdGrp g ON g.CGrus = p.CGrus ] + ;
                        [WHERE p.CPros = ] + EscaparSQL(TmpFinalg.Cpros)
            IF SQLEXEC(gnConnHandle, loc_lcSql, "cursor_4c_TipoEsto") >= 1
                IF INLIST(cursor_4c_TipoEsto.TipoEstos, 3, 4)
                    THIS.pgf_4c_Paginas.Page1.btn_4c_Disponivel.Visible = .T.
                ENDIF
                USE IN cursor_4c_TipoEsto
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeItensCol10Valid - Valida e aplica nova quantidade de Estoque
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensCol10Valid
        LOCAL loc_lResultado, loc_nNewVal, loc_nMaxEst, loc_nDelta, loc_nNovoProd, loc_nQtdMin
        loc_lResultado = .T.
        loc_nNewVal    = THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.Column10.Text1.Value

        *-- Garantir registro em TmpSaldU para este produto
        IF USED("TmpSaldU") AND NOT SEEK(TmpFinalg.Cpros, "TmpSaldU", "Cpros")
            INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinalg.Cpros)
        ENDIF

        *-- Checar se produto usa selecao manual de estoque
        IF USED("TmpSaldU") AND loc_nNewVal <> THIS.this_nOldValue AND TmpSaldU.KeySelm
            IF NOT MsgConfirma("Produto com Sele"+CHR(231)+CHR(227)+"o Manual de estoque. "+CHR(13)+ ;
                    "O sistema ir"+CHR(225)+" acionar o modo autom"+CHR(225)+"tico. Deseja Continuar?")
                THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.Column10.Text1.Value = THIS.this_nOldValue
                RETURN .F.
            ENDIF
        ENDIF

        loc_nMaxEst = IIF(USED("TmpSaldo") AND NOT EOF("TmpSaldo"), TmpSaldo.Disps, 0)
        loc_nQtdMin = IIF(USED("TmpFinalg") AND NOT EOF("TmpFinalg"), TmpFinalg.QtdMins, 0)

        DO CASE
            CASE loc_nNewVal = THIS.this_nOldValue
                *-- Sem alteracao: aceitar
            CASE loc_nNewVal < 0
                MsgAviso("A quantidade n"+CHR(227)+"o pode ser um valor negativo...")
                THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.Column10.Text1.Value = THIS.this_nOldValue
                loc_lResultado = .F.
            CASE loc_nNewVal > loc_nMaxEst
                MsgAviso("A quantidade n"+CHR(227)+"o pode ser maior que o estoque dispon"+CHR(237)+"vel...")
                THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.Column10.Text1.Value = THIS.this_nOldValue
                loc_lResultado = .F.
            OTHERWISE
                *-- Calcular delta e balancear Estoque x Producao
                loc_nDelta    = loc_nNewVal - TmpFinalg.Estoque
                loc_nNovoProd = TmpFinalg.Produzir - loc_nDelta
                IF loc_nNovoProd < 0
                    loc_nNovoProd = 0
                ENDIF
                *-- Atualizar TmpFinalg: Estoque, Produzir, Produzir2
                REPLACE Estoque   WITH loc_nNewVal, ;
                        Produzir  WITH loc_nNovoProd, ;
                        Produzir2 WITH IIF(loc_nQtdMin > 0 AND loc_nNovoProd < loc_nQtdMin AND loc_nNovoProd > 0, ;
                                         loc_nQtdMin - loc_nNovoProd, 0) ;
                IN TmpFinalg
                *-- Resetar flag de selecao manual de estoque
                IF USED("TmpSaldU") AND NOT EOF("TmpSaldU")
                    REPLACE KeySelm WITH .F. IN TmpSaldU
                ENDIF
        ENDCASE

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeItensCol10LostFocus - Atualiza totais apos edicao de Estoque
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensCol10LostFocus
        THIS.AtualizarTotaisGrade()
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarTotaisGrade - Recalcula e exibe totais de TmpFinalg
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarTotaisGrade()
        LOCAL loc_nRecno, loc_nSal, loc_nEst, loc_nPrz, loc_nPrc, loc_nPrze

        IF NOT USED("TmpFinalg") OR EOF("TmpFinalg")
            RETURN
        ENDIF

        SELECT TmpFinalg
        loc_nRecno = RECNO()
        SUM Saldo, Estoque, Produzir, Fabrs, Produzir2 ;
            TO loc_nSal, loc_nEst, loc_nPrz, loc_nPrc, loc_nPrze
        GO loc_nRecno

        WITH THIS.pgf_4c_Paginas.Page1
            .txt_4c_TotQtd.Value  = loc_nSal
            .txt_4c_TotEst.Value  = loc_nEst
            .txt_4c_TotPrdc.Value = loc_nPrc
            .txt_4c_TotPrz.Value  = loc_nPrz
            .txt_4c_TotPrze.Value = loc_nPrze
            .txt_4c_TotQtd.Refresh
            .txt_4c_TotEst.Refresh
            .txt_4c_TotPrdc.Refresh
            .txt_4c_TotPrz.Refresh
            .txt_4c_TotPrze.Refresh
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ImgFigJpgClick - Exibe/recarrega foto do produto ao clicar na imagem
    *--------------------------------------------------------------------------
    PROCEDURE ImgFigJpgClick
        LOCAL loc_lcSql, loc_lcArquivo, loc_lcFoto

        IF NOT USED("TmpFinalg") OR EOF("TmpFinalg")
            RETURN
        ENDIF

        loc_lcSql = [SELECT a.cpros, a.dpros, a.figjpgs FROM SigCdPro a WHERE a.cpros = ] + ;
                    EscaparSQL(TmpFinalg.Cpros)

        IF SQLEXEC(gnConnHandle, loc_lcSql, "cursor_4c_LocalPro") >= 1
            WITH THIS.pgf_4c_Paginas.Page1.img_4c_FigJpg
                IF NOT EMPTY(cursor_4c_LocalPro.FigJpgs) AND NOT ISNULL(cursor_4c_LocalPro.FigJpgs)
                    loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
                    loc_lcFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_LocalPro.FigJpgs, ;
                        "data:image/png;base64,", ""), ;
                        "data:image/jpeg;base64,", ""), ;
                        "data:image/jpg;base64,", ""), 14)
                    =STRTOFILE(loc_lcFoto, loc_lcArquivo)
                    .Picture = loc_lcArquivo
                    .Visible = .T.
                ELSE
                    MsgAviso("Nenhuma imagem cadastrada para este produto.")
                ENDIF
            ENDWITH
            USE IN cursor_4c_LocalPro
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnProcessarClick - Delega processamento da globalizacao ao BO
    *--------------------------------------------------------------------------
    PROCEDURE BtnProcessarClick
        LOCAL loc_lSucesso, loc_oErr
        loc_lSucesso = .F.

        IF NOT MsgConfirma("Confirma o processamento da Globaliza"+CHR(231)+CHR(227)+"o?")
            RETURN
        ENDIF

        THIS.MostrarAguarde("Processando...")

        TRY
            loc_lSucesso = THIS.this_oBusinessObject.Processar()
        CATCH TO loc_oErr
            MsgErro("Erro ao processar: " + loc_oErr.Message + ;
                    " [Ln:" + TRANSFORM(loc_oErr.LineNo) + "]", "Erro")
        ENDTRY

        THIS.OcultarAguarde()

        IF loc_lSucesso
            MsgInfo("Processamento conclu"+CHR(237)+"do com sucesso!")
            THIS.BtnCancelarClick()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnTotLinhaClick - Calcula totais por linha e navega para Page3
    *--------------------------------------------------------------------------
    PROCEDURE BtnTotLinhaClick
        IF USED("TmpLinha")
            THIS.pgf_4c_Paginas.Page3.grd_4c_GradeLinhas.RecordSource = ""
            USE IN TmpLinha
        ENDIF

        SELECT Linhas, 0 AS Ordem, SUM(Saldo) AS Saldo, SUM(Estoque) AS Estoque, ;
               SUM(Produzir) AS Produzir, SUM(Fabrs) AS Fabrs ;
        FROM TmpFinalg GROUP BY 1 ;
        UNION ALL ;
        SELECT PADR("TOTAIS", 10) AS Linhas, 1 AS Ordem, SUM(Saldo) AS Saldo, ;
               SUM(Estoque) AS Estoque, SUM(Produzir) AS Produzir, SUM(Fabrs) AS Fabrs ;
        FROM TmpFinalg GROUP BY 1 ;
        INTO CURSOR TmpLinha ORDER BY 2, 1

        WITH THIS.pgf_4c_Paginas.Page3.grd_4c_GradeLinhas
            .RecordSource = "TmpLinha"
            .Refresh
        ENDWITH

        THIS.AlternarPagina(3)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Encerra o form e reativa o form pai
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick
        IF VARTYPE(THIS.this_oParentForm) = "O"
            THIS.this_oParentForm.Enabled = .T.
        ENDIF
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnDisponivelClick - Selecao por disponibilidade de tamanhos (Page5)
    *--------------------------------------------------------------------------
    PROCEDURE BtnDisponivelClick
        LOCAL loc_lcCpro, loc_lcCor

        IF TmpFinalg.Estoque <> 0 OR TmpFinalg.Fabrs <> 0
            MsgAviso("Quantidade de Estoque e Produ"+CHR(231)+CHR(227)+"o tem estar Zero antes deste Processo!!!")
            THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.SetFocus
            RETURN
        ENDIF

        loc_lcCpro = TmpFinalg.Cpros
        loc_lcCor  = TmpFinalg.CodCors

        IF USED("TmpDisp")
            THIS.pgf_4c_Paginas.Page5.grd_4c_GradeDisp.RecordSource = ""
            USE IN TmpDisp
        ENDIF

        SELECT Cpros, CodCors, CodTams, Disps, 000000000.000 AS Utilizar ;
        FROM TmpSaldo ;
        WHERE Cpros = loc_lcCpro AND CodCors = loc_lcCor AND Disps > 0 ;
        INTO CURSOR Resultado ORDER BY 1, 2, 3

        SELECT 0
        USE DBF("Resultado") ALIAS TmpDisp AGAIN
        USE IN Resultado

        IF RECCOUNT("TmpDisp") = 0
            MsgAviso("Nenhum tamanho dispon"+CHR(237)+"vel para esta refer"+CHR(234)+"ncia.")
            IF USED("TmpDisp")
                USE IN TmpDisp
            ENDIF
            RETURN
        ENDIF

        WITH THIS.pgf_4c_Paginas.Page5
            .txt_4c_P5CodProd.Value  = ALLTRIM(loc_lcCpro) + ;
                IIF(NOT EMPTY(loc_lcCor), "/"+ALLTRIM(loc_lcCor), "")
            .txt_4c_P5QtPedida.Value = TmpFinalg.Saldo
            .txt_4c_P5QtSelec.Value  = 0
            .grd_4c_GradeDisp.RecordSource = "TmpDisp"
            .grd_4c_GradeDisp.Refresh
        ENDWITH

        THIS.AlternarPagina(5)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSelEstoqueClick - Selecao de estoque por conta/grupo (Page4)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSelEstoqueClick
        LOCAL loc_lcCpro, loc_lcCor, loc_lcTam

        loc_lcCpro = TmpFinalg.Cpros
        loc_lcCor  = TmpFinalg.CodCors
        loc_lcTam  = TmpFinalg.CodTams

        IF USED("TmpDisp")
            THIS.pgf_4c_Paginas.Page4.grd_4c_GradeSelEst.RecordSource = ""
            USE IN TmpDisp
        ENDIF

        SELECT Priors, Grupos, Estos, Cpros, CodCors, CodTams, Disps, 000000000.000 AS Utilizar ;
        FROM TmpSaldG ;
        WHERE Cpros = loc_lcCpro AND CodCors = loc_lcCor AND CodTams = loc_lcTam AND Disps > 0 ;
        INTO CURSOR Resultado ORDER BY 1, 2, 3, 4

        SELECT 0
        USE DBF("Resultado") ALIAS TmpDisp AGAIN
        USE IN Resultado

        IF RECCOUNT("TmpDisp") = 0
            MsgAviso("Nenhum estoque dispon"+CHR(237)+"vel para esta refer"+CHR(234)+"ncia.")
            IF USED("TmpDisp")
                USE IN TmpDisp
            ENDIF
            RETURN
        ENDIF

        WITH THIS.pgf_4c_Paginas.Page4
            .txt_4c_P4CodProd.Value  = ALLTRIM(loc_lcCpro) + ;
                IIF(NOT EMPTY(loc_lcCor), "/"+ALLTRIM(loc_lcCor), "") + ;
                IIF(NOT EMPTY(loc_lcTam), "/"+ALLTRIM(loc_lcTam), "")
            .txt_4c_P4QtPedida.Value = TmpFinalg.Saldo - TmpFinalg.Estoque
            .txt_4c_P4QtSelec.Value  = 0
            .grd_4c_GradeSelEst.RecordSource = "TmpDisp"
            .grd_4c_GradeSelEst.Refresh
        ENDWITH

        THIS.AlternarPagina(4)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnPedrasClick - Configura grade de requisicoes e navega para Page6
    *--------------------------------------------------------------------------
    PROCEDURE BtnPedrasClick
        WITH THIS.pgf_4c_Paginas.Page6.grd_4c_GradePedra
            IF USED("SelPedra")
                .RecordSource = ""
            ENDIF
            .RecordSource          = "SelPedra"
            .ColumnCount           = 5
            .Column1.ControlSource = "SelPedra.Cpros"
            .Column2.ControlSource = "SelPedra.Dpros"
            .Column3.ControlSource = "SelPedra.Cunis"
            .Column4.ControlSource = "SelPedra.Qtds"
            .Column5.ControlSource = "SelPedra.Cpro2s"
            .Refresh
        ENDWITH

        THIS.pgf_4c_Paginas.Page6.txt_4c_P6CodProd.Value = ALLTRIM(TmpFinalg.Cpros)
        THIS.AlternarPagina(6)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlteraqtdClick - Autoriza alteracao de Produzir2 via SigOpSen
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlteraqtdClick
        LOCAL loc_lcString, loc_lcRetorno

        IF TmpFinalg.Produzir2 = 0
            MsgAviso("Referencia Sem Quantidade a Produzir para Estoque!!!")
            THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.SetFocus
            RETURN
        ENDIF

        loc_lcString = ALLTRIM(TmpFinalg.Cpros) + " Qt.Min:" + ;
            ALLTRIM(TRANSFORM(TmpFinalg.QtdMins,  "@Z 99999.999")) + " " + ;
            "Qt.Est:" + ALLTRIM(TRANSFORM(TmpFinalg.Produzir2, "@Z 99999.999"))

        DO FORM SigOpSen WITH "PRDZRISCO", loc_lcString, "" TO loc_lcRetorno

        CLEAR TYPEAHEAD
        IF LEFT(loc_lcRetorno, 1) = "*"
            THIS.this_lLiberado = .T.
            THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.Column8.ReadOnly = .F.
            THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.SetFocus
            THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.Column8.Text1.SetFocus
        ELSE
            MsgAviso("Altera"+CHR(231)+CHR(227)+"o n"+CHR(227)+"o autorizada!")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVoltarPage2Click - Valida e retorna de Operacoes Detalhadas para Page1
    *--------------------------------------------------------------------------
    PROCEDURE BtnVoltarPage2Click
        LOCAL loc_nSumEst, loc_nSumPrc

        IF USED("TmpFinal") AND USED("TmpFinalg") AND NOT EOF("TmpFinalg")
            SELECT TmpFinal
            SUM TmpFinal.Estoque, TmpFinal.Fabrs TO loc_nSumEst, loc_nSumPrc

            IF loc_nSumEst <> TmpFinalg.Estoque
                MsgAviso("A quantidade de Estoque n"+CHR(227)+"o confere com a Quantidade Selecionada!!!")
                RETURN
            ENDIF
            IF loc_nSumPrc <> TmpFinalg.Fabrs
                MsgAviso("A quantidade de Produ"+CHR(231)+CHR(227)+"o n"+CHR(227)+"o confere com a Quantidade Selecionada!!!")
                RETURN
            ENDIF
        ENDIF

        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVoltarPage3Click - Retorna de Totais por Linha para Page1
    *--------------------------------------------------------------------------
    PROCEDURE BtnVoltarPage3Click
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVoltarPage4Click - Aplica selecoes de estoque (TmpDisp) e retorna para Page1
    * Logica: Page4.CancelaDisp.Click do legado
    *--------------------------------------------------------------------------
    PROCEDURE BtnVoltarPage4Click
        LOCAL loc_nQtdUti, loc_nQtUtil, loc_nXBaixa, loc_oErr
        loc_nQtdUti = 0
        loc_nQtUtil = 0
        loc_nXBaixa = 0

        TRY
            IF USED("TmpDisp")

                SELECT TmpDisp
                SUM Utilizar TO loc_nQtdUti

                IF loc_nQtdUti > 0

                    SELECT TmpDisp
                    SCAN
                        IF TmpDisp.Utilizar = 0
                            LOOP
                        ENDIF
                        loc_nQtUtil = TmpDisp.Utilizar

                        =SEEK(TmpDisp.CPros + TmpDisp.CodCors + TmpDisp.CodTams, 'TmpSaldo')

                        SELECT TmpFinalg
                        REPLACE Produzir  WITH Produzir - loc_nQtUtil, ;
                                Estoque   WITH Estoque + loc_nQtUtil, ;
                                UsuLibs   WITH ' ' IN TmpFinalg
                        REPLACE Produzir2 WITH IIF(QtdMins > 0 AND Produzir < QtdMins AND Produzir > 0, ;
                                                  QtdMins - Produzir, 0) IN TmpFinalg

                        SELECT TmpSaldo
                        REPLACE TmpSaldo.Disps WITH TmpSaldo.Disps - loc_nQtUtil IN TmpSaldo

                        *-- Registrar selecao manual de estoque em TmpSaldU
                        IF NOT SEEK(TmpFinalg.Cpros, 'TmpSaldU', 'Cpros')
                            INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinalg.Cpros)
                        ENDIF
                        REPLACE keySelm WITH .T. IN TmpSaldU

                        *-- Atualizar disponivel no grupo/conta especifico em TmpSaldG
                        SELECT TmpSaldG
                        SET ORDER TO Cpros
                        =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams + ;
                              STR(TmpDisp.Priors, 2) + TmpDisp.Grupos + TmpDisp.Estos)
                        REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - loc_nQtUtil

                    ENDSCAN

                    *-- Redistribuir Estoque acumulado pelas operacoes em TmpFinal
                    =SEEK(TmpFinalg.CPros + TmpFinalg.CodCors + TmpFinalg.CodTams, 'TmpSaldo')
                    loc_nXBaixa = TmpFinalg.Estoque

                    SELECT TmpFinal
                    SET ORDER TO
                    SET ORDER TO Cpros
                    =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
                    REPLACE Estoque WITH 0 ;
                        WHILE Cpros = TmpSaldo.Cpros AND CodCors = TmpSaldo.CodCors AND ;
                              CodTams = TmpSaldo.CodTams
                    =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
                    SCAN WHILE Cpros = TmpSaldo.Cpros AND CodCors = TmpSaldo.CodCors AND ;
                               CodTams = TmpSaldo.CodTams AND loc_nXBaixa > 0
                        IF TmpFinal.Saldo - TmpFinal.Fabrs >= loc_nXBaixa
                            REPLACE TmpFinal.Estoque WITH TmpFinal.Estoque + loc_nXBaixa IN TmpFinal
                            loc_nXBaixa = 0
                        ELSE
                            loc_nXBaixa = loc_nXBaixa - ( TmpFinal.Saldo - TmpFinal.Fabrs )
                            REPLACE TmpFinal.Estoque WITH ( TmpFinal.Saldo - TmpFinal.Fabrs ) IN TmpFinal
                        ENDIF
                        REPLACE Produzir WITH Saldo - Estoque - Fabrs IN TmpFinal
                    ENDSCAN

                ENDIF

                THIS.AtualizarTotaisGrade()

            ENDIF

            THIS.AlternarPagina(1)

        CATCH TO loc_oErr
            MsgErro("Erro em BtnVoltarPage4Click: " + loc_oErr.Message + ;
                    " [Ln:" + TRANSFORM(loc_oErr.LineNo) + ;
                    " Proc:" + loc_oErr.Procedure + "]", "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVoltarPage5Click - Aplica selecoes por tamanho (TmpDisp) e retorna para Page1
    * Logica: Page5.CancelaDisp.Click do legado ? quebra TmpFinal por tamanho
    *--------------------------------------------------------------------------
    PROCEDURE BtnVoltarPage5Click
        LOCAL loc_nRegFinal, loc_nQtdUti, loc_nQtUtil, loc_nXBaixa, loc_oErr
        LOCAL ARRAY loc_aFinal[1], loc_aMemvar[1]
        loc_nRegFinal = 0
        loc_nQtdUti   = 0
        loc_nQtUtil   = 0
        loc_nXBaixa   = 0

        TRY
            IF USED("TmpDisp") AND USED("TmpFinal")

                SELECT TmpFinal
                SET ORDER TO
                loc_nRegFinal = RECNO()

                SELECT TmpDisp
                SUM Utilizar TO loc_nQtdUti

            IF loc_nQtdUti > 0

                *-- Criar cursor Temporario com mesma estrutura de TmpFinal para staging
                SELECT TmpFinal
                =AFIELDS(loc_aFinal)
                CREATE CURSOR Temporario FROM ARRAY loc_aFinal

                SELECT TmpDisp
                SCAN
                    IF TmpDisp.Utilizar = 0
                        LOOP
                    ENDIF
                    loc_nQtUtil = TmpDisp.Utilizar

                    =SEEK(TmpDisp.CPros + TmpDisp.CodCors + TmpDisp.CodTams, 'TmpSaldo')

                    *-- Copiar linha TmpFinal para Temporario, ajustando tamanho e quantidade
                    SELECT TmpFinal
                    SCATTER TO loc_aMemvar
                    SELECT Temporario
                    APPEND FROM ARRAY loc_aMemvar
                    REPLACE Temporario.Saldo    WITH loc_nQtUtil, ;
                            Temporario.CodTams  WITH TmpDisp.CodTams, ;
                            Temporario.Estoque  WITH loc_nQtUtil, ;
                            Temporario.Produzir WITH 0

                    *-- Reduzir TmpFinal e TmpFinalg pelo que foi alocado neste tamanho
                    SELECT TmpFinal
                    REPLACE TmpFinal.Saldo    WITH TmpFinal.Saldo    - loc_nQtUtil, ;
                            TmpFinal.Produzir WITH TmpFinal.Produzir - loc_nQtUtil IN TmpFinal

                    REPLACE Saldo    WITH Saldo    - loc_nQtUtil, ;
                            Produzir WITH Produzir - loc_nQtUtil IN TmpFinalg

                    SELECT TmpFinalg
                    REPLACE Produzir2 WITH IIF(QtdMins > 0 AND Produzir < QtdMins AND Produzir > 0, ;
                                              QtdMins - Produzir, 0) IN TmpFinalg

                    *-- Atualizar TmpSaldo: reduzir Disps
                    SELECT TmpSaldo
                    REPLACE TmpSaldo.Disps WITH TmpSaldo.Disps - loc_nQtUtil

                    *-- Redistribuir Disps em TmpSaldG: reset ao Saldo, depois debitar xBaixa
                    loc_nXBaixa = TmpSaldo.Saldo - TmpSaldo.Disps
                    SELECT TmpSaldG
                    SET ORDER TO Cpros
                    =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
                    REPLACE Disps WITH Saldo ;
                        WHILE Cpros = TmpSaldo.Cpros AND CodCors = TmpSaldo.CodCors AND ;
                              CodTams = TmpSaldo.CodTams
                    =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
                    SCAN WHILE Cpros = TmpSaldo.Cpros AND CodCors = TmpSaldo.CodCors AND ;
                               CodTams = TmpSaldo.CodTams AND loc_nXBaixa > 0
                        IF TmpSaldG.Disps >= loc_nXBaixa
                            REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - loc_nXBaixa
                            loc_nXBaixa = 0
                        ELSE
                            loc_nXBaixa = loc_nXBaixa - TmpSaldG.Disps
                            REPLACE TmpSaldG.Disps WITH 0
                        ENDIF
                    ENDSCAN

                    *-- Quebrar SigMvIts: dividir linha sem tamanho pelo tamanho selecionado
                    IF USED("SigMvIts")
                        SELECT SigMvIts
                        SET ORDER TO EmpDopnPro
                        SEEK(TmpFinal.Emps + TmpFinal.Dopes + STR(TmpFinal.Numes, 6) + TmpFinal.Cpros)
                        SCAN WHILE Emps + Dopes + STR(Numes, 6) + Cpros = ;
                                   TmpFinal.Emps + TmpFinal.Dopes + STR(TmpFinal.Numes, 6) + TmpFinal.Cpros
                            IF Citens <> TmpFinal.Citens
                                LOOP
                            ENDIF
                            IF CodCors = TmpFinal.CodCors AND CodTams = SPACE(4)
                                *-- Captura registro original; ajusta registro atual com novo tamanho
                                SCATTER TO loc_aMemvar
                                REPLACE CodTams WITH TmpDisp.CodTams
                                REPLACE Qtds    WITH loc_nQtUtil
                                REPLACE Aqtds   WITH Qtds
                                *-- Readiciona registro original com quantidade reduzida
                                APPEND FROM ARRAY loc_aMemvar
                                REPLACE Qtds  WITH Qtds - loc_nQtUtil
                                REPLACE Aqtds WITH Qtds
                                IF Qtds = 0
                                    DELETE
                                ENDIF
                                EXIT
                            ENDIF
                        ENDSCAN
                    ENDIF

                ENDSCAN

                *-- Incorporar registros de Temporario em TmpFinal e limpar zerados
                SELECT TmpFinal
                APPEND FROM DBF('Temporario')
                GO loc_nRegFinal
                IF TmpFinal.Saldo = 0
                    DELETE
                ENDIF

                SELECT TmpFinalg
                IF TmpFinalg.Saldo = 0
                    DELETE
                ENDIF

                =SEEK(TmpFinalg.CPros + TmpFinalg.CodCors + TmpFinalg.CodTams, 'TmpSaldo')

            ENDIF

                THIS.AtualizarTotaisGrade()

            ENDIF

            THIS.AlternarPagina(1)

        CATCH TO loc_oErr
            MsgErro("Erro em BtnVoltarPage5Click: " + loc_oErr.Message + ;
                    " [Ln:" + TRANSFORM(loc_oErr.LineNo) + ;
                    " Proc:" + loc_oErr.Procedure + "]", "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeSelEstCol5Valid - Valida quantidade Utilizar na grade de Page4 (Sel.Estoque)
    *--------------------------------------------------------------------------
    PROCEDURE GradeSelEstCol5Valid
        LOCAL loc_nVal, loc_nPedida, loc_nRegDisp, loc_nQtdUti, loc_lResultado
        loc_lResultado = .T.
        loc_nVal       = 0
        loc_nPedida    = 0
        loc_nRegDisp   = 0
        loc_nQtdUti    = 0

        IF NOT USED("TmpDisp") OR NOT USED("TmpFinalg") OR EOF("TmpFinalg")
            RETURN loc_lResultado
        ENDIF

        loc_nVal    = THIS.pgf_4c_Paginas.Page4.grd_4c_GradeSelEst.Column5.Text1.Value
        loc_nPedida = TmpFinalg.Saldo - TmpFinalg.Estoque

        IF loc_nVal > TmpDisp.Disps
            MsgAviso("A quantidade a utilizar n"+CHR(227)+"o pode ser maior que Qtde Dispon"+CHR(237)+"vel...")
            THIS.pgf_4c_Paginas.Page4.grd_4c_GradeSelEst.Column5.Text1.Value = 0
            THIS.pgf_4c_Paginas.Page4.grd_4c_GradeSelEst.Column5.Text1.Refresh
            loc_lResultado = .F.
        ELSE
            IF loc_nVal < 0
                MsgAviso("A quantidade a utilizar n"+CHR(227)+"o pode ser menor que zero...")
                THIS.pgf_4c_Paginas.Page4.grd_4c_GradeSelEst.Column5.Text1.Value = 0
                THIS.pgf_4c_Paginas.Page4.grd_4c_GradeSelEst.Column5.Text1.Refresh
                loc_lResultado = .F.
            ELSE
                loc_nRegDisp = RECNO("TmpDisp")
                SELECT TmpDisp
                SUM TmpDisp.Utilizar TO loc_nQtdUti
                GO loc_nRegDisp IN TmpDisp
                IF loc_nQtdUti > loc_nPedida
                    MsgAviso("Qtde Selecionada n"+CHR(227)+"o pode ser maior que Qtde Solicitada...")
                    THIS.pgf_4c_Paginas.Page4.grd_4c_GradeSelEst.Column5.Text1.Value = 0
                    THIS.pgf_4c_Paginas.Page4.grd_4c_GradeSelEst.Column5.Text1.Refresh
                    loc_lResultado = .F.
                ELSE
                    WITH THIS.pgf_4c_Paginas.Page4
                        .txt_4c_P4QtSelec.Value = loc_nQtdUti
                        .txt_4c_P4QtSelec.Refresh
                    ENDWITH
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeSelEstCol5LostFocus - Avanca linha ao Enter na grade de Page4
    *--------------------------------------------------------------------------
    PROCEDURE GradeSelEstCol5LostFocus
        IF LASTKEY() = 13
            KEYBOARD "{DNARROW}"
        ENDIF
        THIS.pgf_4c_Paginas.Page4.grd_4c_GradeSelEst.Column5.Text1.Refresh
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeDispColsGotFocus - Colunas ReadOnly de Page5 redirecionam foco para Col5
    *--------------------------------------------------------------------------
    PROCEDURE GradeDispColsGotFocus
        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page5, "grd_4c_GradeDisp", 5)
            THIS.pgf_4c_Paginas.Page5.grd_4c_GradeDisp.Column5.Text1.SetFocus
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeDispCol5Valid - Valida quantidade Utilizar na grade de Page5 (Disponivel/Tam)
    *--------------------------------------------------------------------------
    PROCEDURE GradeDispCol5Valid
        LOCAL loc_nVal, loc_nPedida, loc_nRegDisp, loc_nQtdUti, loc_lResultado
        loc_lResultado = .T.
        loc_nVal       = 0
        loc_nPedida    = 0
        loc_nRegDisp   = 0
        loc_nQtdUti    = 0

        IF NOT USED("TmpDisp") OR NOT PEMSTATUS(THIS.pgf_4c_Paginas.Page5, "txt_4c_P5QtPedida", 5)
            RETURN loc_lResultado
        ENDIF

        loc_nVal    = THIS.pgf_4c_Paginas.Page5.grd_4c_GradeDisp.Column5.Text1.Value
        loc_nPedida = THIS.pgf_4c_Paginas.Page5.txt_4c_P5QtPedida.Value

        IF loc_nVal > TmpDisp.Disps
            MsgAviso("A quantidade a utilizar n"+CHR(227)+"o pode ser maior que Qtde Dispon"+CHR(237)+"vel...")
            THIS.pgf_4c_Paginas.Page5.grd_4c_GradeDisp.Column5.Text1.Value = 0
            THIS.pgf_4c_Paginas.Page5.grd_4c_GradeDisp.Column5.Text1.Refresh
            loc_lResultado = .F.
        ELSE
            loc_nRegDisp = RECNO("TmpDisp")
            SELECT TmpDisp
            SUM TmpDisp.Utilizar TO loc_nQtdUti
            GO loc_nRegDisp IN TmpDisp
            IF loc_nQtdUti > loc_nPedida
                MsgAviso("Qtde Selecionada n"+CHR(227)+"o pode ser maior que Qtde Pedida...")
                THIS.pgf_4c_Paginas.Page5.grd_4c_GradeDisp.Column5.Text1.Value = 0
                THIS.pgf_4c_Paginas.Page5.grd_4c_GradeDisp.Column5.Text1.Refresh
                loc_lResultado = .F.
            ELSE
                WITH THIS.pgf_4c_Paginas.Page5
                    .txt_4c_P5QtSelec.Value = loc_nQtdUti
                    .txt_4c_P5QtSelec.Refresh
                ENDWITH
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVoltarPage6Click - Retorna de Requisicoes para Page1
    *--------------------------------------------------------------------------
    PROCEDURE BtnVoltarPage6Click
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeOpeAfterRowColChange - Atualiza label obs e imagem ao mudar linha na Page2
    *--------------------------------------------------------------------------
    PROCEDURE GradeOpeAfterRowColChange
        LPARAMETERS par_nColIndex
        LOCAL loc_lcSql, loc_lcArquivo, loc_lcFoto, loc_oPag2
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2

        IF NOT USED("TmpFinal") OR EOF("TmpFinal")
            RETURN
        ENDIF

        loc_oPag2.lbl_4c_ObsItem.Caption = "Observa"+CHR(231)+CHR(227)+"o do Item " + ALLTRIM(TmpFinal.Cpros)
        loc_oPag2.edt_4c_ObsItens.Refresh

        loc_lcSql = [SELECT cpros, figjpgs FROM SigCdPro WHERE Cpros = ] + ;
                    EscaparSQL(TmpFinal.Cpros)
        IF SQLEXEC(gnConnHandle, loc_lcSql, "cursor_4c_ProdFig2") >= 1
            WITH loc_oPag2.img_4c_FigOpe
                IF NOT EMPTY(cursor_4c_ProdFig2.FigJpgs) AND NOT ISNULL(cursor_4c_ProdFig2.FigJpgs)
                    loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
                    loc_lcFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_ProdFig2.FigJpgs, ;
                        "data:image/png;base64,", ""), ;
                        "data:image/jpeg;base64,", ""), ;
                        "data:image/jpg;base64,", ""), 14)
                    =STRTOFILE(loc_lcFoto, loc_lcArquivo)
                    .Picture = loc_lcArquivo
                    .Visible = .T.
                ELSE
                    .Picture = ""
                    .Visible = .F.
                ENDIF
            ENDWITH
            USE IN cursor_4c_ProdFig2
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeOpeColsGotFocus - Colunas ReadOnly de Page2 redirecionam foco para Col7
    *--------------------------------------------------------------------------
    PROCEDURE GradeOpeColsGotFocus
        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_GradeOpe", 5)
            THIS.pgf_4c_Paginas.Page2.grd_4c_GradeOpe.Column7.Text1.SetFocus
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeOpeCol7GotFocus - Salva valor anterior de Estoque (Col7 Page2)
    *--------------------------------------------------------------------------
    PROCEDURE GradeOpeCol7GotFocus
        THIS.this_nOldValue = THIS.pgf_4c_Paginas.Page2.grd_4c_GradeOpe.Column7.Text1.Value
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeOpeCol7Valid - Valida nova quantidade de Estoque na Page2
    * Limites: nao negativo, nao excede Saldo da operacao, nao excede Tot_sEst selecionado
    *--------------------------------------------------------------------------
    PROCEDURE GradeOpeCol7Valid
        LOCAL loc_lResultado, loc_nNewVal, loc_nPSaldo
        loc_lResultado = .T.
        loc_nNewVal    = THIS.pgf_4c_Paginas.Page2.grd_4c_GradeOpe.Column7.Text1.Value
        loc_nPSaldo    = THIS.pgf_4c_Paginas.Page2.txt_4c_TotSEst.Value

        DO CASE
            CASE loc_nNewVal = THIS.this_nOldValue
                *-- Sem alteracao: aceitar

            CASE loc_nNewVal < 0
                MsgAviso("A quantidade n"+CHR(227)+"o pode ser um valor negativo...")
                THIS.pgf_4c_Paginas.Page2.grd_4c_GradeOpe.Column7.Text1.Value = THIS.this_nOldValue
                loc_lResultado = .F.

            CASE USED("TmpFinal") AND NOT EOF("TmpFinal") AND loc_nNewVal > TmpFinal.Saldo
                MsgAviso("A quantidade n"+CHR(227)+"o pode ser maior que a quantidade da Opera"+CHR(231)+CHR(227)+"o...")
                THIS.pgf_4c_Paginas.Page2.grd_4c_GradeOpe.Column7.Text1.Value = THIS.this_nOldValue
                loc_lResultado = .F.

            CASE loc_nNewVal > loc_nPSaldo
                MsgAviso("A quantidade n"+CHR(227)+"o pode ser maior que a quantidade Selecionada...")
                THIS.pgf_4c_Paginas.Page2.grd_4c_GradeOpe.Column7.Text1.Value = THIS.this_nOldValue
                loc_lResultado = .F.

            OTHERWISE
                IF USED("TmpFinal") AND NOT EOF("TmpFinal")
                    REPLACE TmpFinal.Estoque WITH loc_nNewVal IN TmpFinal
                ENDIF
        ENDCASE

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeOpeCol7LostFocus - Atualiza totais de Page2 apos edicao de Estoque
    *--------------------------------------------------------------------------
    PROCEDURE GradeOpeCol7LostFocus
        THIS.AtualizarTotaisPage2()
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarTotaisPage2 - Recalcula e exibe totais de TmpFinal na Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarTotaisPage2()
        LOCAL loc_nRecno, loc_nSal, loc_nEst, loc_nPrz, loc_nPrc

        IF NOT USED("TmpFinal") OR EOF("TmpFinal")
            RETURN
        ENDIF

        SELECT TmpFinal
        loc_nRecno = RECNO()
        SUM Saldo, Estoque, Produzir, Fabrs TO loc_nSal, loc_nEst, loc_nPrz, loc_nPrc
        GO loc_nRecno

        WITH THIS.pgf_4c_Paginas.Page2
            .txt_4c_P2TotQtd.Value = loc_nSal
            .txt_4c_P2TotEst.Value = loc_nEst
            .txt_4c_P2TotPrc.Value = loc_nPrc
            .txt_4c_P2TotPrz.Value = loc_nPrz
            .txt_4c_P2TotQtd.Refresh
            .txt_4c_P2TotEst.Refresh
            .txt_4c_P2TotPrc.Refresh
            .txt_4c_P2TotPrz.Refresh
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE GradeOpeCol10GotFocus
        THIS.this_nAntValue = THIS.pgf_4c_Paginas.Page2.grd_4c_GradeOpe.Column10.Text1.Value
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE GradeOpeCol10Valid
        LOCAL loc_lResultado, loc_nNewVal, loc_nPSaldo
        loc_lResultado = .T.
        loc_nNewVal    = THIS.pgf_4c_Paginas.Page2.grd_4c_GradeOpe.Column10.Text1.Value
        loc_nPSaldo    = THIS.pgf_4c_Paginas.Page2.txt_4c_TotSPrc.Value

        DO CASE
            CASE loc_nNewVal = THIS.this_nAntValue
                *-- sem alteracao, nada a fazer
            CASE loc_nNewVal < 0
                MsgAviso("A quantidade n"+CHR(227)+"o pode ser um valor negativo...")
                THIS.pgf_4c_Paginas.Page2.grd_4c_GradeOpe.Column10.Text1.Value = THIS.this_nAntValue
                loc_lResultado = .F.
            CASE USED("TmpFinal") AND NOT EOF("TmpFinal") AND loc_nNewVal > TmpFinal.Saldo
                MsgAviso("A quantidade n"+CHR(227)+"o pode ser maior que a quantidade da Opera"+CHR(231)+CHR(227)+"o...")
                THIS.pgf_4c_Paginas.Page2.grd_4c_GradeOpe.Column10.Text1.Value = THIS.this_nAntValue
                loc_lResultado = .F.
            CASE loc_nNewVal > loc_nPSaldo
                MsgAviso("A quantidade n"+CHR(227)+"o pode ser maior que a quantidade Selecionada...")
                THIS.pgf_4c_Paginas.Page2.grd_4c_GradeOpe.Column10.Text1.Value = THIS.this_nAntValue
                loc_lResultado = .F.
            OTHERWISE
                IF USED("TmpFinal") AND NOT EOF("TmpFinal")
                    REPLACE TmpFinal.Fabrs WITH loc_nNewVal IN TmpFinal
                ENDIF
        ENDCASE

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE GradeOpeCol10LostFocus
        THIS.AtualizarTotaisPage2()
    ENDPROC

    *--------------------------------------------------------------------------
    * GradePedraCol1Valid - Lookup de produto principal na grade de Requisicao (Page6)
    * Busca em SigCdPro e preenche Dpros e Cunis no cursor SelPedra
    *--------------------------------------------------------------------------
    PROCEDURE GradePedraCol1Valid
        LOCAL loc_cCodPro, loc_oBusca, loc_oErr, loc_lcSql, loc_lcSql2
        loc_cCodPro = ""

        IF NOT USED("SelPedra") OR EOF("SelPedra")
            RETURN .T.
        ENDIF

        loc_cCodPro = ALLTRIM(THIS.pgf_4c_Paginas.Page6.grd_4c_GradePedra.Column1.Text1.Value)

        IF EMPTY(loc_cCodPro)
            REPLACE SelPedra.Dpros WITH "" IN SelPedra
            REPLACE SelPedra.Cunis WITH "" IN SelPedra
            RETURN .T.
        ENDIF

        TRY
            loc_lcSql = [SELECT a.CPros, a.DPros, a.Cunis FROM SigCdPro a WHERE a.CPros = ] + ;
                        EscaparSQL(loc_cCodPro)
            IF SQLEXEC(gnConnHandle, loc_lcSql, "cursor_4c_BPPedra") >= 1 AND ;
               NOT EOF("cursor_4c_BPPedra")
                REPLACE SelPedra.Cpros  WITH ALLTRIM(cursor_4c_BPPedra.CPros) IN SelPedra
                REPLACE SelPedra.Dpros  WITH ALLTRIM(cursor_4c_BPPedra.DPros) IN SelPedra
                REPLACE SelPedra.Cunis  WITH ALLTRIM(cursor_4c_BPPedra.Cunis) IN SelPedra
                USE IN cursor_4c_BPPedra
            ELSE
                IF USED("cursor_4c_BPPedra")
                    USE IN cursor_4c_BPPedra
                ENDIF
                *-- Produto nao encontrado: abrir picker
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdPro", "cursor_4c_BPPedra2", "CPros", loc_cCodPro, ;
                    "Selecionar Produto", .T., .T., "")
                loc_oBusca.mAddColuna("CPros", "", "C"+CHR(243)+"digo")
                loc_oBusca.mAddColuna("DPros", "", "Descri"+CHR(231)+CHR(227)+"o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BPPedra2")
                    REPLACE SelPedra.Cpros WITH ALLTRIM(cursor_4c_BPPedra2.CPros) IN SelPedra
                    REPLACE SelPedra.Dpros WITH ALLTRIM(cursor_4c_BPPedra2.DPros) IN SelPedra
                    *-- Buscar unidade complementar
                    loc_lcSql2 = [SELECT Cunis FROM SigCdPro WHERE CPros = ] + ;
                                 EscaparSQL(ALLTRIM(cursor_4c_BPPedra2.CPros))
                    IF SQLEXEC(gnConnHandle, loc_lcSql2, "cursor_4c_BPUni") >= 1
                        REPLACE SelPedra.Cunis WITH ALLTRIM(cursor_4c_BPUni.Cunis) IN SelPedra
                        USE IN cursor_4c_BPUni
                    ENDIF
                ELSE
                    REPLACE SelPedra.Cpros WITH "" IN SelPedra
                    REPLACE SelPedra.Dpros WITH "" IN SelPedra
                    REPLACE SelPedra.Cunis WITH "" IN SelPedra
                ENDIF
                IF USED("cursor_4c_BPPedra2")
                    USE IN cursor_4c_BPPedra2
                ENDIF
                loc_oBusca.Release()
            ENDIF

            THIS.pgf_4c_Paginas.Page6.grd_4c_GradePedra.Refresh

        CATCH TO loc_oErr
            MsgErro("Erro no lookup de produto (Grade Pedra): " + loc_oErr.Message, "Erro")
        ENDTRY

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * GradePedraCol4When - Coluna 4 (Qtde) so editavel se Produto preenchido
    *--------------------------------------------------------------------------
    PROCEDURE GradePedraCol4When
        IF NOT USED("SelPedra") OR EOF("SelPedra")
            RETURN .F.
        ENDIF
        RETURN NOT EMPTY(ALLTRIM(SelPedra.Cpros))
    ENDPROC

    *--------------------------------------------------------------------------
    * GradePedraCol5When - Coluna 5 (Produto Ref) so editavel se Produto preenchido
    *--------------------------------------------------------------------------
    PROCEDURE GradePedraCol5When
        IF NOT USED("SelPedra") OR EOF("SelPedra")
            RETURN .F.
        ENDIF
        RETURN NOT EMPTY(ALLTRIM(SelPedra.Cpros))
    ENDPROC

    *--------------------------------------------------------------------------
    * GradePedraCol5Valid - Lookup de produto referencia (Cpro2s) na grade Page6
    *--------------------------------------------------------------------------
    PROCEDURE GradePedraCol5Valid
        LOCAL loc_cCodRef, loc_oBusca, loc_oErr, loc_lcSql
        loc_cCodRef = ""

        IF NOT USED("SelPedra") OR EOF("SelPedra")
            RETURN .T.
        ENDIF

        loc_cCodRef = ALLTRIM(THIS.pgf_4c_Paginas.Page6.grd_4c_GradePedra.Column5.Text1.Value)

        IF EMPTY(loc_cCodRef)
            REPLACE SelPedra.Cpro2s WITH "" IN SelPedra
            THIS.pgf_4c_Paginas.Page6.grd_4c_GradePedra.Refresh
            RETURN .T.
        ENDIF

        TRY
            loc_lcSql = [SELECT CPros FROM SigCdPro WHERE CPros = ] + EscaparSQL(loc_cCodRef)
            IF SQLEXEC(gnConnHandle, loc_lcSql, "cursor_4c_BPro2") >= 1 AND ;
               NOT EOF("cursor_4c_BPro2")
                REPLACE SelPedra.Cpro2s WITH ALLTRIM(cursor_4c_BPro2.CPros) IN SelPedra
                USE IN cursor_4c_BPro2
            ELSE
                IF USED("cursor_4c_BPro2")
                    USE IN cursor_4c_BPro2
                ENDIF
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdPro", "cursor_4c_BPro2b", "CPros", loc_cCodRef, ;
                    "Produto Refer"+CHR(234)+"ncia", .T., .T., "")
                loc_oBusca.mAddColuna("CPros", "", "C"+CHR(243)+"digo")
                loc_oBusca.mAddColuna("DPros", "", "Descri"+CHR(231)+CHR(227)+"o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BPro2b")
                    REPLACE SelPedra.Cpro2s WITH ALLTRIM(cursor_4c_BPro2b.CPros) IN SelPedra
                ELSE
                    REPLACE SelPedra.Cpro2s WITH "" IN SelPedra
                ENDIF
                IF USED("cursor_4c_BPro2b")
                    USE IN cursor_4c_BPro2b
                ENDIF
                loc_oBusca.Release()
            ENDIF

            THIS.pgf_4c_Paginas.Page6.grd_4c_GradePedra.Refresh

        CATCH TO loc_oErr
            MsgErro("Erro no lookup de produto refer"+CHR(234)+"ncia: " + loc_oErr.Message, "Erro")
        ENDTRY

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * GradePedraCol5LostFocus - Adiciona nova linha quando usuario sai da ultima linha preenchida
    *--------------------------------------------------------------------------
    PROCEDURE GradePedraCol5LostFocus
        LOCAL loc_nPosicao
        IF NOT USED("SelPedra") OR EOF("SelPedra")
            RETURN
        ENDIF

        loc_nPosicao = RECNO("SelPedra")
        GO BOTTOM IN SelPedra
        IF NOT EMPTY(ALLTRIM(SelPedra.Cpros)) AND RECNO("SelPedra") = loc_nPosicao
            APPEND BLANK IN SelPedra
        ENDIF
        GO loc_nPosicao IN SelPedra
        KEYBOARD "{DNARROW}"
    ENDPROC

    *==========================================================================
    * ADAPTADORES CRUD PARA FORM OPERACIONAL
    * SIGPRGLX eh operacional (Previa da Globalizacao) e nao possui CRUD.
    * Os handlers abaixo mapeiam a interface CRUD padrao para as operacoes
    * reais do form: Processar (main action), Alterar Qtd (autorizacao),
    * Visualizar Imagem, e Cancelar/Encerrar.
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Executa o processamento da globalizacao (acao principal)
    * Em forms operacionais de preview, "incluir" == confirmar e processar.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick
        IF NOT USED("TmpFinalg") OR EOF("TmpFinalg")
            MsgAviso("N"+CHR(227)+"o h"+CHR(225)+" itens dispon"+CHR(237)+"veis para processar.")
            RETURN
        ENDIF
        THIS.BtnProcessarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Autoriza alteracao da quantidade de producao para estoque
    * Delega para BtnAlteraqtdClick que abre SigOpSen para validar senha.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick
        IF NOT USED("TmpFinalg") OR EOF("TmpFinalg")
            MsgAviso("Selecione um item da grade antes de alterar.")
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_GradeItens", 5)
                THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.SetFocus
            ENDIF
            RETURN
        ENDIF
        THIS.BtnAlteraqtdClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Exibe a imagem do produto da linha corrente
    * Reproduz o mesmo SQL de ImgFigJpg.Click (SigCdPro.FigJpgs) e renderiza
    * em arquivo temporario alimentando o Image control da Page1.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick
        LOCAL loc_lcCodPro, loc_lcSql, loc_lcArquivo, loc_lcFoto, loc_oErr

        IF NOT USED("TmpFinalg") OR EOF("TmpFinalg")
            MsgAviso("Selecione um item da grade para visualizar a imagem.")
            RETURN
        ENDIF

        loc_lcCodPro  = TmpFinalg.Cpros
        loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
        loc_lcSql     = "SELECT a.cpros, a.dpros, a.FigJpgs FROM SigCdPro a " + ;
                        "WHERE a.cpros = " + EscaparSQL(loc_lcCodPro)

        TRY
            IF USED("cursor_4c_LocalPro")
                USE IN cursor_4c_LocalPro
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_lcSql, "cursor_4c_LocalPro") < 1
                MsgAviso("N"+CHR(227)+"o foi poss"+CHR(237)+"vel carregar a imagem do produto.")
                RETURN
            ENDIF

            IF NOT EMPTY(NVL(cursor_4c_LocalPro.FigJpgs, "")) AND ;
               NOT ISNULL(cursor_4c_LocalPro.FigJpgs)

                loc_lcFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN( ;
                    cursor_4c_LocalPro.FigJpgs, ;
                    "data:image/png;base64,",  ""), ;
                    "data:image/jpeg;base64,", ""), ;
                    "data:image/jpg;base64,",  ""), 14)
                =STRTOFILE(loc_lcFoto, loc_lcArquivo)

                WITH THIS.pgf_4c_Paginas.Page1.img_4c_FigJpg
                    .Picture = loc_lcArquivo
                    .Visible = .T.
                ENDWITH
            ELSE
                MsgAviso("Nenhuma imagem cadastrada para este produto.")
            ENDIF

            IF USED("cursor_4c_LocalPro")
                USE IN cursor_4c_LocalPro
            ENDIF
        CATCH TO loc_oErr
            MsgErro("Erro ao visualizar imagem: " + loc_oErr.Message + ;
                    " [Ln:" + TRANSFORM(loc_oErr.LineNo) + "]", "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Encerra o form sem processar (equivale a cancelar)
    * Em preview de globalizacao, "excluir" == abandonar as alteracoes.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick
        IF NOT MsgConfirma("Confirma o cancelamento da Globaliza"+CHR(231)+CHR(227)+"o?" + ;
                           CHR(13) + "Todas as sele"+CHR(231)+CHR(245)+"es ser"+CHR(227)+"o descartadas.")
            RETURN
        ENDIF
        THIS.BtnCancelarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Acao principal do form operacional (delega para Processar)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick
        THIS.BtnProcessarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Atualiza exibicao dos dados das grades operacionais
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick
        IF USED("TmpFinalg") AND RECCOUNT("TmpFinalg") > 0
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_GradeItens", 5)
                THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.Refresh
            ENDIF
            THIS.AtualizarTotaisGrade()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Encerra o form (mesma logica que BtnCancelarClick)
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick
        THIS.BtnCancelarClick()
    ENDPROC

    *==========================================================================
    * METODOS DE SUPORTE (FASE 8)
    *==========================================================================

    *--------------------------------------------------------------------------
    * CarregarLista - Vincula grades aos cursores operacionais (TmpFinalg etc.)
    * Para form operacional, os cursores sao passados via datasession do form pai;
    * este metodo apenas atualiza a exibicao apos os cursores estarem populados.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF NOT USED("TmpFinalg") OR RECCOUNT("TmpFinalg") = 0
            RETURN loc_lSucesso
        ENDIF

        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_GradeItens", 5)
            THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.Refresh
        ENDIF

        THIS.AtualizarTotaisGrade()
        loc_lSucesso = .T.

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Controles habilitados sao gerenciados pelos eventos
    * When/Valid das grades; nao ha controle de modo CRUD neste form.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos()
        *-- Form operacional: controles gerenciados individualmente por When/Valid
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Zera campos de totalizacao da Page1
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPag1

        IF NOT PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
            RETURN
        ENDIF

        loc_oPag1 = THIS.pgf_4c_Paginas.Page1

        IF PEMSTATUS(loc_oPag1, "txt_4c_TotQtd", 5)
            loc_oPag1.txt_4c_TotQtd.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPag1, "txt_4c_TotPrdc", 5)
            loc_oPag1.txt_4c_TotPrdc.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPag1, "txt_4c_TotEst", 5)
            loc_oPag1.txt_4c_TotEst.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPag1, "txt_4c_TotPrz", 5)
            loc_oPag1.txt_4c_TotPrz.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPag1, "txt_4c_TotPrze", 5)
            loc_oPag1.txt_4c_TotPrze.Value = 0
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Form operacional nao usa modo CRUD tradicional;
    * os botoes sao gerenciados pela logica de paginas ativas.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        *-- Form operacional: visibilidade dos botoes gerenciada por AlternarPagina
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere flags operacionais para o BO antes do Processar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF
        WITH THIS.this_oBusinessObject
            .this_lReserva    = THIS.this_lReserva
            .this_nEmphPdr    = THIS.this_nEmphPdr
            .this_lAutomatico = THIS.this_lAutomatico
            .this_nNumeroOp   = THIS.this_nNumeroOp
            .this_lPorDestino = THIS.this_lPorDestino
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Atualiza exibicao apos processamento do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        IF USED("TmpFinalg") AND RECCOUNT("TmpFinalg") > 0
            THIS.AtualizarTotaisGrade()
        ENDIF
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrGlxBO.prg):
*==============================================================================
* SigPrGlxBO.prg - Business Object: Previa da Globalizacao
* Data: 2026-07-03
* Tipo: OPERACIONAL
* Funcao: Gerencia logica de negocio da previa de globalizacao/reserva automatica.
*          Recebe parametros do form pai (SigGlb ou equivalente), opera sobre
*          cursores TmpFinalg/TmpFinal/TmpSaldG/TmpFabr pre-populados pelo pai.
*          Executa processamento de OPs, reservas e requisicoes de material.
*==============================================================================

DEFINE CLASS SigPrGlxBO AS BusinessBase

    *-- Parametros operacionais (recebidos via Form.Init do form pai)
    this_lReserva    = .F.    && .T. = previa de reserva automatica; .F. = previa de globalizacao
    this_nEmphPdr    = 0      && enfase padrao para geracao de OPs (1 = gerar empenhos)
    this_lAutomatico = .F.    && .T. = modo automatico (sem intervencao do usuario)
    this_nNumeroOp   = 0      && numero da OP especifica (0 = sem restricao)
    this_lPorDestino = .F.    && .T. = usar grupo/conta de destino do cabecalho do movimento
    this_cSigKey     = ""     && chave de assinatura digital (SigCdPac.sigKeys)
    this_dDataRef    = {}     && data de referencia para o processamento (geracao)

    *-- Estado de edicao nas grades (equivalentes a ThisForm.Liberado/OldValue/AntValue)
    this_lLiberado   = .F.    && .T. = coluna "Produzir Estq" liberada para edicao
    this_nOldValue   = 0      && valor anterior da celula editavel em GradeItens
    this_nAntValue   = 0      && valor anterior da celula editavel em GradePedra (Page6)

    *-- Campos do cursor TmpFinalg (carregados via CarregarDoCursor)
    this_cCpros      = ""     && codigo do produto
    this_cCodCors    = ""     && codigo da cor
    this_cCodTams    = ""     && codigo do tamanho
    this_nSaldo      = 0      && saldo disponivel
    this_nFabrs      = 0      && quantidade em fabricacao
    this_nEstoque    = 0      && quantidade em estoque
    this_nProduzir   = 0      && quantidade a produzir (editavel pelo usuario)
    this_nProduzir2  = 0      && quantidade a produzir ajustada
    this_nQtds       = 0      && quantidade total
    this_cFlag       = ""     && flag de controle
    this_cUsuLibs    = ""     && usuario autorizador da liberacao
    this_nQtdMins    = 0      && quantidade minima de producao
    this_cLinhas     = ""     && codigo da linha de producao

    *-- Estado de processamento (uso interno de ProcessarGlobalizacao)
    this_nNume       = 0      && numero do movimento gerado (SigMvCab.Numes)
    this_nRnop       = 0      && numero da OP de reserva
    this_dPrevisao   = {}     && data de previsao de entrega (form pai GetPrevisao)

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir do registro atual de TmpFinalg
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED("TmpFinalg") AND !EOF("TmpFinalg")
                THIS.this_cCpros     = TmpFinalg.Cpros
                THIS.this_cCodCors   = TmpFinalg.CodCors
                THIS.this_cCodTams   = TmpFinalg.CodTams
                THIS.this_nSaldo     = TmpFinalg.Saldo
                THIS.this_nFabrs     = TmpFinalg.Fabrs
                THIS.this_nEstoque   = TmpFinalg.Estoque
                THIS.this_nProduzir  = TmpFinalg.Produzir
                THIS.this_nProduzir2 = TmpFinalg.Produzir2
                THIS.this_nQtds      = TmpFinalg.Qtds
                THIS.this_cFlag      = TmpFinalg.Flag
                THIS.this_cUsuLibs   = TmpFinalg.UsuLibs
                THIS.this_nQtdMins   = TmpFinalg.QtdMins
                THIS.this_cLinhas    = TmpFinalg.Linhas
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave composta do produto atual
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCpros) + ALLTRIM(THIS.this_cCodCors) + ALLTRIM(THIS.this_cCodTams)
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida pre-requisitos antes do processamento
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        IF !USED("TmpFinalg")
            THIS.this_cMensagemErro = "Cursor TmpFinalg n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF
        IF !USED("TmpFinal")
            THIS.this_cMensagemErro = "Cursor TmpFinal n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF
        IF !USED("TmpSaldG")
            THIS.this_cMensagemErro = "Cursor TmpSaldG n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF
        IF !USED("TmpFabr")
            THIS.this_cMensagemErro = "Cursor TmpFabr n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Processar - Metodo publico: executa globalizacao/reserva automatica
    * Chamado pelo Form.Processar.Click equivalente
    *--------------------------------------------------------------------------
    PROCEDURE Processar()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF THIS.ValidarDados()
                loc_lResultado = THIS.Inserir()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Delega para ProcessarGlobalizacao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        RETURN THIS.ProcessarGlobalizacao()
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza quantidade Produzir2 no cursor TmpFinalg
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED("TmpFinalg") AND !EOF("TmpFinalg")
                REPLACE TmpFinalg.Produzir2 WITH THIS.this_nProduzir2
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Stub: previa nao suporta exclusao direta
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        THIS.this_cMensagemErro = "Pr" + CHR(233) + "via n" + CHR(227) + "o suporta exclus" + CHR(227) + "o direta"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao no log de auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSql, loc_cChave, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cChave = THIS.ObterChavePrimaria()
            IF !EMPTY(loc_cChave)
                loc_cSql = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, Usuario, DataHora) VALUES (" + ;
                           "'SigPdMvf', " + ;
                           EscaparSQL(par_cOperacao) + ", " + ;
                           EscaparSQL(loc_cChave) + ", " + ;
                           EscaparSQL(gc_4c_UsuarioLogado) + ", GETDATE())"
                SQLEXEC(gnConnHandle, loc_cSql)
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarGlobalizacao - Orquestrador principal
    * Equivalente ao Processar.Click do legado (~1903 linhas)
    * Modos: !this_lReserva = Globalizacao com OPs; this_lReserva = Reserva Automatica
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarGlobalizacao()
        LOCAL loc_cDopp, loc_cDope, loc_cDopEst, loc_nNump, loc_nRnop
        LOCAL loc_nNume, loc_cEmpr, loc_cUsuar, loc_dDtGera, loc_dPrev
        LOCAL loc_lErro, loc_cSql, loc_lResultado
        LOCAL loc_cGrupoOrig, loc_cContaOrig, loc_cGrupoDest, loc_cContaDest
        LOCAL loc_cObsSigMv, loc_cEmpDopNum

        loc_lResultado = .F.
        loc_lErro      = .F.

        TRY
            loc_cEmpr   = go_4c_Sistema.cCodEmpresa
            loc_cUsuar  = gc_4c_UsuarioLogado
            loc_dDtGera = THIS.this_dDataRef
            loc_dPrev   = THIS.this_dPrevisao
            IF EMPTY(loc_dDtGera)
                loc_dDtGera = DATE()
            ENDIF
            IF EMPTY(loc_dPrev)
                loc_dPrev = DATE()
            ENDIF

            *-- Carregar configuracoes do sistema
            IF THIS.SqlExecute("SELECT * FROM SigCdPam", "crSigCdPam_4c") <= 0
                MsgErro("Falha ao carregar SigCdPam", "Erro")
                loc_lResultado = .F.
            ENDIF
            IF THIS.SqlExecute("SELECT * FROM SigCdPac", "crSigCdPac_4c") <= 0
                MsgErro("Falha ao carregar SigCdPac", "Erro")
                loc_lResultado = .F.
            ENDIF
            IF THIS.SqlExecute("SELECT * FROM DbParam", "crDbParam_4c") <= 0
                MsgErro("Falha ao carregar DbParam", "Erro")
                loc_lResultado = .F.
            ENDIF
            IF THIS.SqlExecute("SELECT * FROM SigCdCom", "crSigCdCom_4c") <= 0
                MsgErro("Falha ao carregar SigCdCom", "Erro")
                loc_lResultado = .F.
            ENDIF

            SELECT crSigCdPam_4c
            loc_cDopp = ALLTRIM(crSigCdPam_4c.DoppPads)
            loc_cDope = ALLTRIM(crSigCdPam_4c.TransfRes)
            SELECT crSigCdPac_4c
            loc_cDopEst = ALLTRIM(crSigCdPac_4c.dopEsts)

            IF THIS.CursorQuery("SigCdOpd", "crSigCdOpd_4c", "Dopps", loc_cDopp) <= 0
                MsgErro("Opera" + CHR(231) + CHR(227) + "o de produ" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada: " + loc_cDopp, "Erro")
                loc_lResultado = .F.
            ENDIF

            *-- Gerar numero da OP ou da reserva
            loc_nNump = 0
            loc_nRnop = 0
            IF !THIS.this_lReserva
                SELECT crSigCdPam_4c
                IF crSigCdPam_4c.GlobAutos = 2 AND THIS.this_nNumeroOp > 0
                    loc_nNump = THIS.this_nNumeroOp
                ELSE
                    loc_nNump = fGerUniqueKey(loc_cDopp)
                ENDIF
                loc_cSql = "SELECT Numps FROM SigOpPic WHERE Numps = " + LTRIM(STR(loc_nNump))
                IF THIS.SqlExecute(loc_cSql, "TmpOpiChk_4c") <= 0
                    MsgErro("Favor Reinicializar o Processo!!!", "Erro")
                    loc_lResultado = .F.
                ENDIF
                IF RECCOUNT("TmpOpiChk_4c") > 0
                    MsgAviso("N" + CHR(250) + "mero de Op j" + CHR(225) + " existe. Favor Corrigir!!!")
                    loc_lResultado = .F.
                ENDIF
            ELSE
                loc_nRnop = fGerUniqueKey("RESERVAPCP")
            ENDIF

            *-- Carregar operacao de estoque
            IF THIS.CursorQuery("SigCdOpe", "CrSigCdOpe_4c", "Dopes", loc_cDopEst) <= 0
                MsgErro("Opera" + CHR(231) + CHR(227) + "o de estoque n" + CHR(227) + "o encontrada: " + loc_cDopEst, "Erro")
                loc_lResultado = .F.
            ENDIF

            SELECT CrSigCdOpe_4c
            loc_cGrupoOrig = ALLTRIM(CrSigCdOpe_4c.GruOrigs)
            loc_cContaOrig = ALLTRIM(CrSigCdOpe_4c.ConOrigs)
            loc_cGrupoDest = ALLTRIM(CrSigCdOpe_4c.GruDests)
            loc_cContaDest = ALLTRIM(CrSigCdOpe_4c.ConDests)

            *-- Gerar numero do movimento de baixa
            loc_nNume = fGerUniqueKey(ALLTRIM(loc_cDopEst) + loc_cEmpr)
            THIS.this_nNume  = loc_nNume
            THIS.this_nRnop  = loc_nRnop

            *-- Criar cursores temporarios de trabalho
            SET NULL ON
            CREATE CURSOR TmpEmpH_4c (Grupos c(10), Contas c(10), cGrus c(3), cMats c(14), Qtds n(12,3), QtdReqs n(12,3), ;
                                      QtdEsts n(12,3), QtdMins n(12,3), QtdPedcs n(12,3), QtdComps n(12,3), QtdEmphs n(12,3), ;
                                      QtdGReqs n(12,3), cpro2s c(14))
            INDEX ON cGrus + cMats TAG GruMat
            INDEX ON cMats + cpro2s TAG CMats

            CREATE CURSOR TmpPedra_4c (Grupos c(10), Contas c(10), cGrus c(3), cMats c(14), Qtds n(12,3), QtdReqs n(12,3), ;
                                       QtdEsts n(12,3), QtdMins n(12,3), QtdPedcs n(12,3), QtdComps n(12,3), QtdEmphs n(12,3), ;
                                       QtdGReqs n(12,3))
            INDEX ON cGrus + cMats TAG GruMat
            INDEX ON cMats TAG CMats

            CREATE CURSOR TmpMatPrz_4c (cMats c(14), Qtds n(12,3), Pesos n(12,3), PrazoEnts D, QtBaixas n(12,3))
            INDEX ON DTOC(PrazoEnts) + cMats TAG MatPrazo DESCENDING
            SET NULL OFF

            *-- Atualizar saldos de reserva em TmpSaldG
            SELECT TmpSaldG
            SET ORDER TO
            REPLACE ALL Reservs WITH Saldo - Disps

            *-- Iniciar transacao
            SQLEXEC(gnConnHandle, "BEGIN TRAN")

            *-- INSERT cabecalho do movimento de baixa (SigMvCab)
            loc_cObsSigMv  = IIF(THIS.this_lReserva, ;
                                 "[ Reserva Autom" + CHR(225) + "tica ]", ;
                                 "[ Globaliza" + CHR(231) + CHR(227) + "o ]")
            loc_cEmpDopNum = loc_cEmpr + loc_cDopEst + STR(loc_nNume, 6)

            loc_cSql = "INSERT INTO SigMvCab (Emps, Dopes, Numes, MascNum, Datas, Datars, Usuars, " + ;
                       "Grupoos, Contaos, Grupods, Contads, Obses, CidChaves, Dtalts, EmpDopNums, rNops, PrazoEnts) VALUES (" + ;
                       EscaparSQL(loc_cEmpr) + ", " + ;
                       EscaparSQL(loc_cDopEst) + ", " + ;
                       LTRIM(STR(loc_nNume)) + ", " + ;
                       EscaparSQL(THIS.GerMascara(loc_nNume)) + ", " + ;
                       FormatarDataSQL(loc_dDtGera) + ", " + ;
                       FormatarDataSQL(DATE()) + ", " + ;
                       EscaparSQL(loc_cUsuar) + ", " + ;
                       EscaparSQL(loc_cGrupoOrig) + ", " + ;
                       EscaparSQL(loc_cContaOrig) + ", " + ;
                       EscaparSQL(loc_cGrupoDest) + ", " + ;
                       EscaparSQL(loc_cContaDest) + ", " + ;
                       EscaparSQL(loc_cObsSigMv) + ", " + ;
                       EscaparSQL(fUniqueIds()) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL(loc_cEmpDopNum) + ", " + ;
                       LTRIM(STR(loc_nRnop)) + ", " + ;
                       FormatarDataSQL(loc_dPrev) + ")"
            IF SQLEXEC(gnConnHandle, loc_cSql) <= 0
                SQLEXEC(gnConnHandle, "ROLLBACK TRAN")
                MsgErro("Falha ao inserir cabe" + CHR(231) + "alho do movimento (SigMvCab)", "Erro")
                loc_lResultado = .F.
            ENDIF

            *-- Modo Globalizacao: atualizar Nops e gerar OPs
            IF !THIS.this_lReserva
                loc_cSql = "UPDATE SigMvCab SET Nops = " + LTRIM(STR(loc_nNump)) + ;
                           ", Rnops = " + LTRIM(STR(loc_nNump)) + ;
                           " WHERE EmpDopNums = " + EscaparSQL(loc_cEmpDopNum)
                IF SQLEXEC(gnConnHandle, loc_cSql) <= 0
                    SQLEXEC(gnConnHandle, "ROLLBACK TRAN")
                    MsgErro("Falha ao atualizar Nops em SigMvCab", "Erro")
                    loc_lResultado = .F.
                ENDIF

                IF !THIS.GerarOrdensProducao(loc_cDopp, loc_cDopEst, loc_nNump, ;
                                             loc_dDtGera, loc_dPrev, loc_cEmpr, loc_cUsuar)
                    SQLEXEC(gnConnHandle, "ROLLBACK TRAN")
                    loc_lResultado = .F.
                ENDIF
            ENDIF

            *-- Processar baixa de estoque
            IF !THIS.ProcessarBaixaEstoque(loc_cDopEst, loc_cDope, loc_nNump, loc_nRnop, ;
                                           loc_dDtGera, loc_cEmpr, loc_cUsuar)
                SQLEXEC(gnConnHandle, "ROLLBACK TRAN")
                loc_lResultado = .F.
            ENDIF

            *-- Processar baixa de fabricacao
            IF !THIS.ProcessarBaixaFabricacao(loc_cDopEst, loc_nNume, loc_nNump, ;
                                              loc_dDtGera, loc_cEmpr, loc_cUsuar)
                SQLEXEC(gnConnHandle, "ROLLBACK TRAN")
                loc_lResultado = .F.
            ENDIF

            *-- Processar empenhamentos (se configurado)
            SELECT crSigCdPam_4c
            IF !EMPTY(crSigCdPam_4c.DopEmphs) AND !EMPTY(crSigCdPam_4c.DopReqcs) AND ;
               !EMPTY(crSigCdPam_4c.DopPedcs) AND !THIS.this_lReserva AND THIS.this_nEmphPdr = 1
                IF !THIS.ProcessarEmpenhamentos(loc_cDopp, loc_cDopEst, loc_nNump, loc_nRnop, ;
                                               loc_dDtGera, loc_cEmpr, loc_cUsuar)
                    SQLEXEC(gnConnHandle, "ROLLBACK TRAN")
                    loc_lResultado = .F.
                ENDIF
            ENDIF

            *-- Gravar historico de movimentos
            IF !THIS.GravarHistorico(loc_cEmpr, loc_cUsuar, THIS.this_cSigKey)
                SQLEXEC(gnConnHandle, "ROLLBACK TRAN")
                loc_lResultado = .F.
            ENDIF

            *-- Modo Reserva: atualizar Rnops nos cabecalhos originais
            IF THIS.this_lReserva AND USED("TmpCabec")
                SELECT TmpCabec
                SCAN
                    IF !TmpCabec.Flag
                        LOOP
                    ENDIF
                    loc_cEdnCab = ALLTRIM(TmpCabec.Emps) + ALLTRIM(TmpCabec.Dopes) + STR(TmpCabec.Numes, 6)
                    loc_cSql = "UPDATE SigMvCab SET Rnops = " + LTRIM(STR(loc_nRnop)) + ;
                               " WHERE EmpDopNums = " + EscaparSQL(loc_cEdnCab)
                    SQLEXEC(gnConnHandle, loc_cSql)
                ENDSCAN
            ENDIF

            *-- Commit
            IF SQLEXEC(gnConnHandle, "COMMIT TRAN") <= 0
                SQLEXEC(gnConnHandle, "ROLLBACK TRAN")
                MsgErro("Falha no Commit da transa" + CHR(231) + CHR(227) + "o", "Erro")
                loc_lResultado = .F.
            ENDIF

            THIS.RegistrarAuditoria(IIF(THIS.this_lReserva, "RESERVA", "GLOBALIZACAO"))
            loc_lResultado = .T.

        CATCH TO loc_oErro
            SQLEXEC(gnConnHandle, "ROLLBACK TRAN")
            MsgErro(loc_oErro.Message, "Erro ao processar globaliza" + CHR(231) + CHR(227) + "o")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarOrdensProducao - Gera OPs a partir dos cursores TmpFinalg/TmpFinal
    * Equivalente ao bloco "If Not ThisForm.Reserva" do Processar.Click
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerarOrdensProducao(par_cDopp, par_cDopEst, par_nNump, ;
                                            par_dDtGera, par_dPrev, par_cEmpr, par_cUsuar)
        LOCAL loc_cSql, loc_lResultado
        LOCAL loc_nSeqs, loc_cCpros, loc_cReff, loc_cCor, loc_cTam
        LOCAL loc_cClinha, loc_cNota, loc_cGrupoD, loc_cContaD, loc_nNopComp, loc_cCidC
        LOCAL loc_nLnVezes, loc_QtBaixar, loc_QtBaixado, loc_QtdLim, loc_nTProd, loc_nTPeso
        LOCAL loc_nNume_Dopest, loc_cDopePed, loc_cForn, loc_nTotPed, loc_nNumePed, loc_nCItens

        loc_lResultado = .T.
        loc_nSeqs      = 0
        loc_cCpros     = ""
        loc_cReff      = SPACE(15)
        loc_cCor       = SPACE(4)
        loc_cTam       = SPACE(2)
        loc_cClinha    = SPACE(10)
        loc_cNota      = SPACE(6)
        loc_cGrupoD    = SPACE(10)
        loc_cContaD    = SPACE(10)
        loc_nTProd     = 0
        loc_nTPeso     = 0
        loc_nCItens    = 1

        TRY
            *-- Limpar e popular TmpFinal a partir de TmpFinalg
            SELECT TmpFinal
            DELETE ALL
            PACK

            SELECT TmpFinalg
            SCAN
                IF TmpFinalg.Produzir2 = 0
                    LOOP
                ENDIF

                THIS.CursorQuery("SigCdPro", "crSigCdPro_4c", "CPros", ALLTRIM(TmpFinalg.Cpros))
                SELECT crSigCdOpd_4c
                loc_cGrupoD = IIF(THIS.this_lPorDestino AND !EMPTY(ALLTRIM(crSigCdOpd_4c.GruDests)), ;
                                  ALLTRIM(crSigCdOpd_4c.GruDests), ALLTRIM(crSigCdOpd_4c.GruDests))
                loc_cContaD = IIF(THIS.this_lPorDestino AND !EMPTY(ALLTRIM(crSigCdOpd_4c.ConDests)), ;
                                  ALLTRIM(crSigCdOpd_4c.ConDests), ALLTRIM(crSigCdOpd_4c.ConDests))

                SELECT TmpFinal
                INSERT INTO TmpFinal (Emps, Dopes, Numes, CPros, Qtds, Peso, Saldo, Estoque, Produzir, Obsps, ;
                                      Obs, Entregas, CodCors, CodTams, Linhas, Citens, Reffs, Notas, ;
                                      Dpros, GrupoDs, ContaDs, KeyPdes) ;
                              VALUES (par_cEmpr, par_cDopEst, par_nNump, ;
                                      ALLTRIM(TmpFinalg.Cpros), TmpFinalg.Qtds, NVL(crSigCdPro_4c.PesoMs, 0), ;
                                      0, 0, TmpFinalg.Produzir2, "", "", ;
                                      par_dPrev, ;
                                      ALLTRIM(TmpFinalg.CodCors), ALLTRIM(TmpFinalg.CodTams), ;
                                      ALLTRIM(NVL(crSigCdPro_4c.Linhas, "")), 0, ;
                                      ALLTRIM(NVL(crSigCdPro_4c.Reffs, "")), "", ;
                                      ALLTRIM(NVL(crSigCdPro_4c.Dpros, "")), loc_cGrupoD, loc_cContaD, .T.)
                SELECT TmpFinalg
            ENDSCAN

            *-- Indexar TmpFinal para processamento ordenado
            SELECT TmpFinal
            INDEX ON Linhas + Reffs + Cpros + Notas + CodCors + GrupoDs + ContaDs TAG Cpros FOR Produzir > 0
            SET ORDER TO Cpros
            GO TOP

            SELECT crSigCdPac_4c
            loc_cDopePed = ALLTRIM(crSigCdPac_4c.OpPdCompra)
            IF !EMPTY(loc_cDopePed)
                THIS.CursorQuery("SigCdOpe", "TmpOpePed_4c", "Dopes", loc_cDopePed)
            ENDIF

            SELECT TmpFinal
            DO WHILE !EOF("TmpFinal")
                IF TmpFinal.Produzir = 0
                    SKIP IN TmpFinal
                    LOOP
                ENDIF

                THIS.CursorQuery("SigCdPro", "crSigCdPro_4c", "CPros", ALLTRIM(TmpFinal.Cpros))
                THIS.CursorQuery("SigCdLin", "CrSigCdLin_4c", "Linhas", ALLTRIM(TmpFinal.Linhas))
                THIS.CursorQuery("SigCdGrp", "CrSigCdGrp_4c", "CGrus",  ALLTRIM(crSigCdPro_4c.Cgrus))
                THIS.CursorQuery("SigCdGpr", "CrSigCdGpr_4c", "Codigos", ALLTRIM(CrSigCdGrp_4c.Mercs))

                SELECT TmpFinal

                *-- Caminho 1: gerar OP propria de producao
                IF EMPTY(loc_cDopePed) OR (!EMPTY(loc_cDopePed) AND crSigCdPro_4c.FabrProPrs = 1)
                    SELECT CrSigCdLin_4c
                    loc_QtdLim   = IIF(CrSigCdLin_4c.QtPcs = 0, TmpFinal.Produzir, CrSigCdLin_4c.QtPcs)
                    SELECT TmpFinal
                    loc_QtBaixar = TmpFinal.Produzir
                    loc_nLnVezes = 0

                    DO WHILE loc_QtBaixar > 0
                        loc_nLnVezes = loc_nLnVezes + 1

                        IF loc_QtBaixar < loc_QtdLim
                            loc_QtBaixado = loc_QtBaixar
                            loc_QtBaixar  = 0
                        ELSE
                            loc_QtBaixar  = loc_QtBaixar - loc_QtdLim
                            loc_QtBaixado = loc_QtdLim
                        ENDIF

                        *-- Verificar mudanca de produto/linha para criar nova OP
                        IF (loc_cClinha + loc_cReff + loc_cCpros + loc_cNota + loc_cCor + loc_cGrupoD + loc_cContaD) <> ;
                           (ALLTRIM(TmpFinal.Linhas) + ALLTRIM(TmpFinal.Reffs) + ALLTRIM(TmpFinal.Cpros) + ;
                            ALLTRIM(TmpFinal.Notas) + ALLTRIM(TmpFinal.CodCors) + ALLTRIM(TmpFinal.GrupoDs) + ;
                            ALLTRIM(TmpFinal.ContaDs)) OR loc_nLnVezes > 1

                            loc_cClinha  = ALLTRIM(TmpFinal.Linhas)
                            loc_cCpros   = ALLTRIM(TmpFinal.Cpros)
                            loc_cCor     = ALLTRIM(TmpFinal.CodCors)
                            loc_cTam     = ALLTRIM(TmpFinal.CodTams)
                            loc_cReff    = ALLTRIM(TmpFinal.Reffs)
                            loc_cGrupoD  = ALLTRIM(TmpFinal.GrupoDs)
                            loc_cContaD  = ALLTRIM(TmpFinal.ContaDs)
                            loc_nSeqs    = loc_nSeqs + 1
                            loc_cNota    = ALLTRIM(TmpFinal.Notas)
                            loc_nNopComp = (par_nNump * 10000) + loc_nSeqs
                            loc_cCidC    = DTOS(par_dDtGera) + TRANSFORM(fGerUniqueKey(DTOS(par_dDtGera)), "@L 999999") + THIS.this_cSigKey

                            *-- INSERT SigPdMvf (cabecalho da OP de producao)
                            loc_cEmpDNps = par_cEmpr + par_cDopp + STR(loc_nNopComp, 10)
                            SELECT crSigCdOpd_4c
                            loc_cSql = "INSERT INTO SigPdMvf (Emps, Dopps, Numps, Datars, Datas, Usuars, Grupoos, Contaos, " + ;
                                       "Grupods, Contads, Nops, CodPds, Unids, Pesos, Qtds, Ordems, cIdChaves, EmpDopNums, EmpDNps) VALUES (" + ;
                                       EscaparSQL(par_cEmpr) + ", " + ;
                                       EscaparSQL(par_cDopp) + ", " + ;
                                       LTRIM(STR(loc_nNopComp)) + ", GETDATE(), " + ;
                                       FormatarDataSQL(par_dDtGera) + ", " + ;
                                       EscaparSQL(par_cUsuar) + ", " + ;
                                       EscaparSQL(ALLTRIM(crSigCdOpd_4c.GruOrigs)) + ", " + ;
                                       EscaparSQL(ALLTRIM(crSigCdOpd_4c.ConOrigs)) + ", " + ;
                                       EscaparSQL(loc_cGrupoD) + ", " + ;
                                       EscaparSQL(loc_cContaD) + ", " + ;
                                       LTRIM(STR(loc_nNopComp)) + ", " + ;
                                       EscaparSQL(loc_cCpros) + ", " + ;
                                       EscaparSQL(ALLTRIM(crSigCdPro_4c.CUnis)) + ", " + ;
                                       "0, 0, 1, " + ;
                                       EscaparSQL(loc_cCidC) + ", " + ;
                                       EscaparSQL(par_cEmpr + SPACE(20) + STR(0, 6)) + ", " + ;
                                       EscaparSQL(loc_cEmpDNps) + ")"
                            IF SQLEXEC(gnConnHandle, loc_cSql) <= 0
                                loc_lResultado = .F.
                                MsgErro("Falha ao inserir SigPdMvf", "Erro")
                                EXIT
                            ENDIF

                            *-- INSERT SigCdNec (necessidade de producao)
                            loc_cIdsNec = DTOS(par_dDtGera) + TRANSFORM(fGerUniqueKey(DTOS(par_dDtGera)), "@L 999999") + THIS.this_cSigKey
                            loc_cSql = "INSERT INTO SigCdNec (Emps, Dopps, Numps, Datars, Datas, Usuars, TotPesos, Grupoos, " + ;
                                       "Contaos, Grupods, Contads, cIdChaves, EmpDNps) VALUES (" + ;
                                       EscaparSQL(par_cEmpr) + ", " + ;
                                       EscaparSQL(par_cDopp) + ", " + ;
                                       LTRIM(STR(loc_nNopComp)) + ", GETDATE(), " + ;
                                       FormatarDataSQL(par_dDtGera) + ", " + ;
                                       EscaparSQL(par_cUsuar) + ", 0, " + ;
                                       EscaparSQL(ALLTRIM(crSigCdOpd_4c.GruOrigs)) + ", " + ;
                                       EscaparSQL(ALLTRIM(crSigCdOpd_4c.ConOrigs)) + ", " + ;
                                       EscaparSQL(loc_cGrupoD) + ", " + ;
                                       EscaparSQL(loc_cContaD) + ", " + ;
                                       EscaparSQL(loc_cIdsNec) + ", " + ;
                                       EscaparSQL(loc_cEmpDNps) + ")"
                            IF SQLEXEC(gnConnHandle, loc_cSql) <= 0
                                loc_lResultado = .F.
                                MsgErro("Falha ao inserir SigCdNec", "Erro")
                                EXIT
                            ENDIF

                            *-- INSERT SigCdNei (item de necessidade agrupado)
                            SELECT crSigCdPam_4c
                            loc_cSql = "INSERT INTO SigCdNei (Emps, Dopps, Numps, Nops, Nenvs, Cmats, Cdescs, " + ;
                                       "cUnis, Pesos, Qtds, TpOps, EmpDNps, cIdChaves, nenvs) VALUES (" + ;
                                       EscaparSQL(par_cEmpr) + ", " + ;
                                       EscaparSQL(par_cDopp) + ", " + ;
                                       LTRIM(STR(loc_nNopComp)) + ", " + ;
                                       LTRIM(STR(loc_nNopComp)) + ", " + ;
                                       LTRIM(STR(loc_nNopComp)) + ", " + ;
                                       EscaparSQL(loc_cCpros) + ", " + ;
                                       EscaparSQL(ALLTRIM(crSigCdPro_4c.Dpros)) + ", " + ;
                                       EscaparSQL(ALLTRIM(crSigCdPro_4c.Cunis)) + ", 0, 0, " + ;
                                       FormatarNumeroSQL(crSigCdPam_4c.TpOpEntAus, 0) + ", " + ;
                                       EscaparSQL(loc_cEmpDNps) + ", " + ;
                                       EscaparSQL(fUniqueIds()) + ", " + ;
                                       LTRIM(STR(loc_nNopComp)) + ")"
                            IF SQLEXEC(gnConnHandle, loc_cSql) <= 0
                                loc_lResultado = .F.
                                MsgErro("Falha ao inserir SigCdNei", "Erro")
                                EXIT
                            ENDIF

                            loc_nTProd = 0
                            loc_nTPeso = 0
                        ENDIF

                        IF !loc_lResultado
                            EXIT
                        ENDIF

                        loc_nNopComp = (par_nNump * 10000) + loc_nSeqs

                        *-- Calcular quantidade de componentes (por peca ou por matriz)
                        SELECT CrSigCdGrp_4c
                        IF CrSigCdGrp_4c.GeraTubs <> 2
                            loc_nQtdCpnt = NVL(crSigCdPro_4c.QtdCpnts, 0) * loc_QtBaixado
                        ELSE
                            loc_cSql = "SELECT SUM(qtds) as total FROM SigPrMtz WHERE Cpros = '" + ALLTRIM(TmpFinal.Cpros) + "'"
                            IF THIS.SqlExecute(loc_cSql, "crSigPrMtz_4c") <= 0
                                loc_lResultado = .F.
                                MsgErro("Falha ao buscar SigPrMtz", "Erro")
                                EXIT
                            ENDIF
                            loc_nQtdCpnt = NVL(crSigPrMtz_4c.total, 0) * loc_QtBaixado
                        ENDIF

                        *-- Buscar preco do item de movimento original
                        SELECT TmpFinal
                        loc_nUnit    = 0
                        loc_cMoeda   = SPACE(3)
                        loc_cEdnFin  = ALLTRIM(TmpFinal.Emps) + ALLTRIM(TmpFinal.Dopes) + STR(TmpFinal.Numes, 6)
                        loc_cSql = "SELECT * FROM SigMvItn WHERE EmpDopNums = '" + loc_cEdnFin + "' AND CPros = '" + ALLTRIM(TmpFinal.Cpros) + "'"
                        THIS.SqlExecute(loc_cSql, "TempEestI_4c")
                        SELECT TempEestI_4c
                        SCAN
                            IF TempEestI_4c.Citens = TmpFinal.Citens
                                loc_nUnit  = NVL(TempEestI_4c.Units, 0)
                                loc_cMoeda = ALLTRIM(NVL(TempEestI_4c.Moedas, ""))
                                EXIT
                            ENDIF
                            SELECT TmpFinal
                        ENDSCAN
                        IF TmpFinal.KeyPdes
                            loc_nUnit  = NVL(crSigCdPro_4c.pVens, 0)
                            loc_cMoeda = ALLTRIM(NVL(crSigCdPro_4c.Moevs, ""))
                        ENDIF

                        *-- INSERT SigOpPic (peca da OP)
                        SELECT TmpFinal
                        loc_cSql = "INSERT INTO SigOpPic (Emps, Dopps, Numps, Nops, Dopes, Numes, Dataes, Dataps, Obss, Qtds, " + ;
                                   "Cpros, DtGeras, CodCors, CodTams, Pesos, QtdCpnts, Units, Moedas, cIdChaves, " + ;
                                   "EmpDopNums, EmpDNps, Notas, Empds, EmpDopNops, Dpros, Citens) VALUES (" + ;
                                   EscaparSQL(par_cEmpr) + ", " + ;
                                   EscaparSQL(par_cDopp) + ", " + ;
                                   LTRIM(STR(par_nNump)) + ", " + ;
                                   LTRIM(STR(loc_nNopComp)) + ", " + ;
                                   EscaparSQL(ALLTRIM(TmpFinal.Dopes)) + ", " + ;
                                   LTRIM(STR(TmpFinal.Numes)) + ", " + ;
                                   FormatarDataSQL(par_dPrev) + ", " + ;
                                   FormatarDataSQL(IIF(EMPTY(TmpFinal.Datas), DATE(), TmpFinal.Datas)) + ", " + ;
                                   EscaparSQL(ALLTRIM(TmpFinal.Obsps)) + ", " + ;
                                   FormatarNumeroSQL(loc_QtBaixado, 3) + ", " + ;
                                   EscaparSQL(loc_cCpros) + ", " + ;
                                   FormatarDataSQL(par_dDtGera) + ", " + ;
                                   EscaparSQL(ALLTRIM(TmpFinal.CodCors)) + ", " + ;
                                   EscaparSQL(ALLTRIM(TmpFinal.CodTams)) + ", " + ;
                                   FormatarNumeroSQL(loc_QtBaixado * NVL(TmpFinal.Peso, 0), 3) + ", " + ;
                                   FormatarNumeroSQL(loc_nQtdCpnt, 3) + ", " + ;
                                   FormatarNumeroSQL(loc_nUnit, 3) + ", " + ;
                                   EscaparSQL(loc_cMoeda) + ", " + ;
                                   EscaparSQL(fUniqueIds()) + ", " + ;
                                   EscaparSQL(ALLTRIM(TmpFinal.Emps) + ALLTRIM(TmpFinal.Dopes) + STR(TmpFinal.Numes, 6)) + ", " + ;
                                   EscaparSQL(par_cEmpr + par_cDopp + STR(par_nNump, 10)) + ", " + ;
                                   EscaparSQL(ALLTRIM(TmpFinal.Notas)) + ", " + ;
                                   EscaparSQL(ALLTRIM(TmpFinal.Emps)) + ", " + ;
                                   EscaparSQL(par_cEmpr + par_cDopp + STR(loc_nNopComp, 10)) + ", " + ;
                                   EscaparSQL(ALLTRIM(TmpFinal.Dpros)) + ", " + ;
                                   LTRIM(STR(TmpFinal.Citens)) + ")"
                        IF SQLEXEC(gnConnHandle, loc_cSql) <= 0
                            loc_lResultado = .F.
                            MsgErro("Falha ao inserir SigOpPic", "Erro")
                            EXIT
                        ENDIF

                        *-- Atualizar QtProds em SigMvItn/SigMvIts
                        SELECT TmpFinal
                        loc_nBaixa = loc_QtBaixado
                        SELECT TempEestI_4c
                        GO TOP
                        SCAN WHILE loc_nBaixa > 0
                            loc_pEdn = ALLTRIM(TempEestI_4c.Emps) + ALLTRIM(TempEestI_4c.Dopes) + STR(TempEestI_4c.Numes, 6)
                            loc_pIds = ALLTRIM(TempEestI_4c.cIdChaves)
                            IF (TempEestI_4c.Qtds - TempEestI_4c.QtBaixas - TempEestI_4c.QtProds) <> 0
                                loc_cSql = "SELECT * FROM SigMvIts WHERE EmpDopNums = '" + loc_pEdn + "' AND CItens = " + LTRIM(STR(TempEestI_4c.Citens))
                                THIS.SqlExecute(loc_cSql, "TempEsti2_4c")
                                GO TOP IN TempEsti2_4c
                                IF EOF("TempEsti2_4c")
                                    loc_nPend = TempEestI_4c.Qtds - TempEestI_4c.QtBaixas - TempEestI_4c.QtProds
                                    IF loc_nPend > loc_nBaixa
                                        loc_pQtd   = TempEestI_4c.QtProds + loc_nBaixa
                                        loc_nBaixa = 0
                                    ELSE
                                        loc_pQtd   = TempEestI_4c.QtProds + loc_nPend
                                        loc_nBaixa = loc_nBaixa - loc_nPend
                                    ENDIF
                                    SQLEXEC(gnConnHandle, "UPDATE SigMvItn SET DtAlts=GETDATE(), QtProds=" + LTRIM(STR(loc_pQtd,12,3)) + " WHERE cIdChaves=" + EscaparSQL(loc_pIds))
                                ELSE
                                    SELECT TempEsti2_4c
                                    SCAN WHILE loc_nBaixa > 0
                                        loc_pId2  = ALLTRIM(TempEsti2_4c.cIdChaves)
                                        loc_nPend = TempEsti2_4c.Qtds - TempEsti2_4c.QtBaixas - TempEsti2_4c.QtProds
                                        IF loc_nPend <> 0
                                            IF loc_nPend > loc_nBaixa
                                                loc_pQtd   = TempEestI_4c.QtProds + loc_nBaixa
                                                loc_pQt2   = TempEsti2_4c.QtProds + loc_nBaixa
                                                loc_nBaixa = 0
                                            ELSE
                                                loc_pQtd   = TempEestI_4c.QtProds + loc_nPend
                                                loc_pQt2   = TempEsti2_4c.QtProds + loc_nPend
                                                loc_nBaixa = loc_nBaixa - loc_nPend
                                            ENDIF
                                            SQLEXEC(gnConnHandle, "UPDATE SigMvItn SET DtAlts=GETDATE(), QtProds=" + LTRIM(STR(loc_pQtd,12,3)) + " WHERE cIdChaves=" + EscaparSQL(loc_pIds))
                                            SQLEXEC(gnConnHandle, "UPDATE SigMvIts SET QtProds=" + LTRIM(STR(loc_pQt2,12,3)) + " WHERE cIdChaves=" + EscaparSQL(loc_pId2))
                                        ENDIF
                                    ENDSCAN
                                ENDIF
                            ENDIF
                            SELECT TempEestI_4c
                        ENDSCAN

                        *-- Atualizar Nops no cabecalho de movimento original
                        SELECT TmpFinal
                        loc_cEdnFin = ALLTRIM(TmpFinal.Emps) + ALLTRIM(TmpFinal.Dopes) + STR(TmpFinal.Numes, 6)
                        SQLEXEC(gnConnHandle, "UPDATE SigMvCab SET Nops=" + LTRIM(STR(par_nNump)) + ", DtAlts=GETDATE() WHERE EmpDopNums=" + EscaparSQL(loc_cEdnFin))

                        *-- Buscar composicao substituida e calcular peso
                        loc_cSqlCompo = "SELECT a.*, b.cgrus FROM SigSubMv a INNER JOIN SigCdPro b ON a.mats=b.cpros " + ;
                                        "WHERE a.empdopnums=" + EscaparSQL(loc_cEdnFin) + ;
                                        " AND a.cpros=" + EscaparSQL(ALLTRIM(TmpFinal.Cpros)) + ;
                                        " AND a.citem2=" + LTRIM(STR(TmpFinal.Citens))
                        THIS.SqlExecute(loc_cSqlCompo, "LocalCompo_4c")

                        SELECT crSigCdPam_4c
                        IF crSigCdPam_4c.AutComps <> 1 AND RECCOUNT("LocalCompo_4c") > 0
                            SELECT LocalCompo_4c
                            loc_nPesoCmp = THIS.AtualizarPeso()
                            loc_nTProd   = loc_nTProd + loc_QtBaixado
                            loc_nTPeso   = loc_nTPeso + (loc_QtBaixado * loc_nPesoCmp)
                            SQLEXEC(gnConnHandle, "UPDATE SigOpPic SET Pesos=" + LTRIM(STR(loc_QtBaixado * loc_nPesoCmp, 12, 3)) + ;
                                    " WHERE EmpDopNops=" + EscaparSQL(par_cEmpr + par_cDopp + STR(loc_nNopComp, 10)) + ;
                                    " AND Cpros=" + EscaparSQL(loc_cCpros) + " AND Numes=" + LTRIM(STR(TmpFinal.Numes)))
                        ELSE
                            SELECT TmpFinal
                            loc_nTProd = loc_nTProd + loc_QtBaixado
                            loc_nTPeso = loc_nTPeso + (loc_QtBaixado * NVL(TmpFinal.Peso, 0))
                        ENDIF

                        *-- Atualizar SigPdMvf com pesos/qtds acumulados
                        SELECT crSigCdPam_4c
                        loc_nPesoFinal = IIF(crDbParam_4c.opZers = 1, 0, loc_nTPeso)
                        SQLEXEC(gnConnHandle, "UPDATE SigPdMvf SET Pesos=" + LTRIM(STR(loc_nPesoFinal,12,3)) + ",Qtds=" + LTRIM(STR(loc_nTProd,12,3)) + " WHERE EmpDNps=" + EscaparSQL(par_cEmpr + par_cDopp + STR(loc_nNopComp, 10)))

                        *-- Atualizar TotPesos em SigCdNec
                        IF THIS.this_lAutomatico
                            SQLEXEC(gnConnHandle, "UPDATE SigCdNec SET TotPesos=" + LTRIM(STR(loc_nTPeso,12,3)) + ",Autos=1 WHERE Emps=" + EscaparSQL(par_cEmpr) + " AND Dopps=" + EscaparSQL(par_cDopp) + " AND Numps=" + LTRIM(STR(loc_nNopComp)))
                        ELSE
                            SQLEXEC(gnConnHandle, "UPDATE SigCdNec SET TotPesos=" + LTRIM(STR(loc_nTPeso,12,3)) + " WHERE Emps=" + EscaparSQL(par_cEmpr) + " AND Dopps=" + EscaparSQL(par_cDopp) + " AND Numps=" + LTRIM(STR(loc_nNopComp)))
                        ENDIF

                        SELECT TmpFinal
                    ENDDO

                ELSE
                    *-- Caminho 2: gerar pedido de compra (produto terceirizado)
                    SELECT TmpFinal
                    loc_cForn   = IIF(!EMPTY(ALLTRIM(crSigCdPro_4c.Ifors)), ALLTRIM(crSigCdPro_4c.Ifors), ALLTRIM(TmpOpePed_4c.ConOrigs))
                    loc_nTotPed = TmpFinal.Produzir

                    loc_cSql = "SELECT TOP 1 Numes FROM SigMvCab WHERE Dopes=" + EscaparSQL(loc_cDopePed) + " AND ContaDs=" + EscaparSQL(loc_cForn)
                    THIS.SqlExecute(loc_cSql, "TmpCabPed_4c")
                    IF !EOF("TmpCabPed_4c")
                        loc_nNumePed = TmpCabPed_4c.Numes
                        THIS.SqlExecute("SELECT MAX(Citens) as Citens FROM SigMvItn WHERE Emps=" + EscaparSQL(par_cEmpr) + " AND Dopes=" + EscaparSQL(loc_cDopePed) + " AND Numes=" + LTRIM(STR(loc_nNumePed)), "TmpUltItn_4c")
                        loc_nCItens = NVL(TmpUltItn_4c.Citens, 0) + 1
                    ELSE
                        loc_nCItens = 9999
                    ENDIF

                    IF loc_nCItens >= 9999
                        loc_nCItens  = 1
                        loc_nNumePed = fGerUniqueKey(par_cEmpr + loc_cDopePed)
                        SELECT TmpOpePed_4c
                        loc_cSql = "INSERT INTO SigMvCab (Emps, Dopes, Numes, MascNum, Datas, Datars, Usuars, " + ;
                                   "Grupoos, Contaos, Grupods, Contads, Nops, Obses, Empdopnums, cIdChaves, DtAlts) VALUES (" + ;
                                   EscaparSQL(par_cEmpr) + ", " + ;
                                   EscaparSQL(loc_cDopePed) + ", " + ;
                                   LTRIM(STR(loc_nNumePed)) + ", " + ;
                                   EscaparSQL(THIS.GerMascara(loc_nNumePed)) + ", " + ;
                                   FormatarDataSQL(par_dDtGera) + ", GETDATE(), " + ;
                                   EscaparSQL(par_cUsuar) + ", " + ;
                                   EscaparSQL(ALLTRIM(TmpOpePed_4c.GruOrigs)) + ", " + ;
                                   EscaparSQL(loc_cForn) + ", " + ;
                                   EscaparSQL(ALLTRIM(TmpOpePed_4c.GruDests)) + ", " + ;
                                   EscaparSQL(ALLTRIM(TmpOpePed_4c.ConDests)) + ", " + ;
                                   LTRIM(STR(par_nNump)) + ", " + ;
                                   EscaparSQL("[ OP: " + STR(par_nNump) + "] ") + ", " + ;
                                   EscaparSQL(par_cEmpr + loc_cDopePed + STR(loc_nNumePed, 6)) + ", " + ;
                                   EscaparSQL(fUniqueIds()) + ", GETDATE())"
                        IF SQLEXEC(gnConnHandle, loc_cSql) <= 0
                            loc_lResultado = .F.
                            MsgErro("Falha ao inserir pedido de compra em SigMvCab", "Erro")
                            SELECT TmpFinal
                            SKIP
                            LOOP
                        ENDIF
                    ENDIF

                    SELECT TmpFinal
                    SQLEXEC(gnConnHandle, "INSERT INTO SigMvItn (Emps,Dopes,Numes,CPros,Qtds,Cunis,DPros,Opers,Citens,Pesos,cUniPs,Obs,EmpDopNums,CidChaves,DtAlts) VALUES (" + ;
                           EscaparSQL(par_cEmpr) + "," + EscaparSQL(loc_cDopePed) + "," + LTRIM(STR(loc_nNumePed)) + "," + EscaparSQL(ALLTRIM(TmpFinal.Cpros)) + "," + ;
                           FormatarNumeroSQL(loc_nTotPed, 3) + "," + EscaparSQL(ALLTRIM(crSigCdPro_4c.Cunis)) + "," + EscaparSQL(ALLTRIM(crSigCdPro_4c.Dpros)) + ",'E'," + ;
                           LTRIM(STR(loc_nCItens)) + "," + FormatarNumeroSQL(crSigCdPro_4c.PesoMs, 3) + "," + EscaparSQL(ALLTRIM(crSigCdPro_4c.cUniPs)) + "," + ;
                           EscaparSQL(ALLTRIM(TmpFinal.Obsps)) + "," + EscaparSQL(par_cEmpr + loc_cDopePed + STR(loc_nNumePed, 6)) + "," + EscaparSQL(fUniqueIds()) + ",GETDATE())")

                    IF !EMPTY(ALLTRIM(TmpFinal.CodCors)) OR !EMPTY(ALLTRIM(TmpFinal.CodTams))
                        SQLEXEC(gnConnHandle, "INSERT INTO SigMvIts (cItens,Emps,Dopes,Numes,CPros,Qtds,Pesos,CodCors,CodTams,QtdEmbs) VALUES (" + ;
                               LTRIM(STR(loc_nCItens)) + "," + EscaparSQL(par_cEmpr) + "," + EscaparSQL(loc_cDopePed) + "," + LTRIM(STR(loc_nNumePed)) + "," + ;
                               EscaparSQL(ALLTRIM(TmpFinal.Cpros)) + "," + FormatarNumeroSQL(loc_nTotPed, 3) + "," + FormatarNumeroSQL(crSigCdPro_4c.PesoMs, 3) + "," + ;
                               EscaparSQL(ALLTRIM(TmpFinal.CodCors)) + "," + EscaparSQL(ALLTRIM(TmpFinal.CodTams)) + ",1)")
                    ENDIF

                    loc_cEdnFin = ALLTRIM(TmpFinal.Emps) + ALLTRIM(TmpFinal.Dopes) + STR(TmpFinal.Numes, 6)
                    SQLEXEC(gnConnHandle, "UPDATE SigMvCab SET Nops=" + LTRIM(STR(par_nNump)) + ",DtAlts=GETDATE() WHERE EmpDopNums=" + EscaparSQL(loc_cEdnFin))
                ENDIF

                SELECT TmpFinal
                SKIP
            ENDDO

            *-- INSERT SigInAtz para itens autorizados (UsuLibs preenchido)
            IF loc_lResultado
                loc_cSql = "SELECT TOP 1 Numes FROM SigMvCab WHERE Dopes=" + EscaparSQL(par_cDopEst) + " AND Emps=" + EscaparSQL(par_cEmpr)
                loc_nNume_Dopest = 0
                IF THIS.SqlExecute(loc_cSql, "TmpNuAtz_4c") > 0 AND !EOF("TmpNuAtz_4c")
                    loc_nNume_Dopest = TmpNuAtz_4c.Numes
                ENDIF

                SELECT TmpFinalg
                SCAN
                    IF !EMPTY(ALLTRIM(TmpFinalg.UsuLibs))
                        loc_nQtdF = IIF(TmpFinalg.QtdMins > 0 AND TmpFinalg.Produzir < TmpFinalg.QtdMins AND TmpFinalg.Produzir > 0, ;
                                        TmpFinalg.QtdMins - TmpFinalg.Produzir, 0)
                        IF SQLEXEC(gnConnHandle, "INSERT INTO SigInAtz (Emps,Dopes,Numes,EmpDopNums,Cpros,Qtds,Qtdes,Qtdps,Qtdfs,Qtdms,Qtdfes,Qtdfins,Usulibs,CidChaves) VALUES (" + ;
                               EscaparSQL(par_cEmpr) + "," + EscaparSQL(par_cDopEst) + "," + LTRIM(STR(loc_nNume_Dopest)) + "," + ;
                               EscaparSQL(par_cEmpr + par_cDopEst + STR(loc_nNume_Dopest, 6)) + "," + EscaparSQL(ALLTRIM(TmpFinalg.Cpros)) + "," + ;
                               FormatarNumeroSQL(TmpFinalg.Saldo, 3) + "," + FormatarNumeroSQL(TmpFinalg.Estoque, 3) + "," + ;
                               FormatarNumeroSQL(TmpFinalg.Fabrs, 3) + "," + FormatarNumeroSQL(TmpFinalg.Produzir, 3) + "," + ;
                               FormatarNumeroSQL(TmpFinalg.QtdMins, 3) + "," + FormatarNumeroSQL(loc_nQtdF, 3) + "," + ;
                               FormatarNumeroSQL(TmpFinalg.Produzir2, 3) + "," + EscaparSQL(ALLTRIM(TmpFinalg.UsuLibs)) + "," + EscaparSQL(fUniqueIds()) + ")") <= 0
                            loc_lResultado = .F.
                            MsgErro("Falha ao inserir SigInAtz", "Erro")
                            EXIT
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF

        CATCH TO loc_oErro
            loc_lResultado = .F.
            MsgErro(loc_oErro.Message, "Erro em GerarOrdensProducao")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarBaixaEstoque - Processa baixa do estoque via SigMvItn/SigMvHst/SigBxEst
    * Equivalente ao bloco "Select TmpSaldg / TmpEstoque" do Processar.Click
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarBaixaEstoque(par_cDopEst, par_cDope, par_nNump, par_nRnop, ;
                                              par_dDtGera, par_cEmpr, par_cUsuar)
        LOCAL loc_cSql, loc_lResultado, loc_nNume, loc_xBaixa, loc_cChave, loc_cChave2
        LOCAL loc_lGrvEest, loc_nCItens, loc_cGrupoD, loc_cContaD, loc_cEdnEst, loc_cEdnNovo

        loc_lResultado = .T.
        loc_lGrvEest   = .F.
        loc_cChave     = SPACE(30)
        loc_cChave2    = SPACE(20)
        loc_nCItens    = 1
        loc_nNume      = 0

        TRY
            *-- Criar cursor de alocacao de estoque
            SET NULL ON
            CREATE CURSOR TmpEstoque_4c (EmpDs c(3), Cpros c(14), CodCors c(4), CodTams c(4), ;
                                         Emps c(3), Dopes c(20), Numes n(6), ;
                                         Grupos c(10), Estos c(10), Estoque n(12,3))
            INDEX ON EmpDs + Grupos + Estos + Emps + Dopes + STR(Numes, 6) TAG EmpDopNum
            SET NULL OFF

            *-- Alocar itens de estoque a partir de TmpSaldG
            SELECT TmpFinal
            SET ORDER TO
            SCAN
                IF TmpFinal.Estoque = 0
                    LOOP
                ENDIF
                loc_xBaixa = TmpFinal.Estoque
                SELECT TmpSaldG
                SET ORDER TO Cpros
                IF SEEK(ALLTRIM(TmpFinal.Cpros) + ALLTRIM(TmpFinal.CodCors) + ALLTRIM(TmpFinal.CodTams))
                    SCAN WHILE ALLTRIM(Cpros) = ALLTRIM(TmpFinal.Cpros) AND ;
                               ALLTRIM(CodCors) = ALLTRIM(TmpFinal.CodCors) AND ;
                               ALLTRIM(CodTams) = ALLTRIM(TmpFinal.CodTams) AND loc_xBaixa > 0
                        IF TmpSaldG.Reservs >= loc_xBaixa
                            REPLACE TmpSaldG.Reservs WITH TmpSaldG.Reservs - loc_xBaixa IN TmpSaldG
                            SELECT TmpFinal
                            INSERT INTO TmpEstoque_4c (Cpros, CodCors, CodTams, Emps, Dopes, Numes, Grupos, Estos, Estoque, EmpDs) ;
                                              VALUES (ALLTRIM(TmpFinal.Cpros), ALLTRIM(TmpFinal.CodCors), ALLTRIM(TmpFinal.CodTams), ;
                                                      ALLTRIM(TmpFinal.Emps), ALLTRIM(TmpFinal.Dopes), TmpFinal.Numes, ;
                                                      ALLTRIM(TmpSaldG.Grupos), ALLTRIM(TmpSaldG.Estos), loc_xBaixa, ALLTRIM(TmpSaldG.Emps))
                            loc_xBaixa = 0
                        ELSE
                            IF TmpSaldG.Reservs > 0
                                loc_nParcial = TmpSaldG.Reservs
                                INSERT INTO TmpEstoque_4c (Cpros, CodCors, CodTams, Emps, Dopes, Numes, Grupos, Estos, Estoque, EmpDs) ;
                                                  VALUES (ALLTRIM(TmpFinal.Cpros), ALLTRIM(TmpFinal.CodCors), ALLTRIM(TmpFinal.CodTams), ;
                                                          ALLTRIM(TmpFinal.Emps), ALLTRIM(TmpFinal.Dopes), TmpFinal.Numes, ;
                                                          ALLTRIM(TmpSaldG.Grupos), ALLTRIM(TmpSaldG.Estos), loc_nParcial, ALLTRIM(TmpSaldG.Emps))
                                REPLACE TmpSaldG.Reservs WITH 0 IN TmpSaldG
                                loc_xBaixa = loc_xBaixa - loc_nParcial
                            ENDIF
                        ENDIF
                        SELECT TmpSaldG
                    ENDSCAN
                ENDIF
                SELECT TmpFinal
            ENDSCAN

            *-- Processar TmpEstoque_4c: gerar movimentos de baixa
            SELECT TmpEstoque_4c
            SET ORDER TO EmpDopNum

            SCAN
                THIS.CursorQuery("SigCdPro", "crSigCdPro_4c", "CPros", ALLTRIM(TmpEstoque_4c.Cpros))
                THIS.CursorQuery("SigCdGrp", "crSigCdGrp_4c", "CGrus", ALLTRIM(crSigCdPro_4c.CGrus))
                SELECT TmpEstoque_4c

                loc_cChave2Cur = ALLTRIM(TmpEstoque_4c.EmpDs) + ALLTRIM(TmpEstoque_4c.Grupos) + ALLTRIM(TmpEstoque_4c.Estos)
                loc_cChaveCur  = ALLTRIM(TmpEstoque_4c.Emps) + ALLTRIM(TmpEstoque_4c.Dopes) + STR(TmpEstoque_4c.Numes, 6)

                IF loc_cChave2Cur <> loc_cChave2 OR loc_cChaveCur <> loc_cChave
                    IF loc_cChave2Cur <> loc_cChave2
                        loc_lGrvEest = .F.
                    ENDIF
                    loc_cChave2  = loc_cChave2Cur
                    loc_cChave   = loc_cChaveCur
                    loc_cEdnEst  = loc_cChaveCur

                    SQLEXEC(gnConnHandle, "UPDATE SigMvCab SET Nops=" + LTRIM(STR(par_nNump)) + ",DtAlts=GETDATE() WHERE EmpDopNums=" + EscaparSQL(loc_cEdnEst))

                    THIS.CursorQuery("SigCdOpe", "crSigCdOpe_4c", "Dopes", ALLTRIM(TmpEstoque_4c.Dopes))
                    THIS.CursorQuery("SigMvCab", "TempEest_4c",   "EmpDopNums", loc_cEdnEst)

                    SELECT crSigCdOpe_4c
                    IF crSigCdOpe_4c.Globalizas = 1
                        loc_cGrupoD = ALLTRIM(TempEest_4c.Grupoos)
                        loc_cContaD = ALLTRIM(TempEest_4c.Contaos)
                    ELSE
                        loc_cGrupoD = ALLTRIM(TempEest_4c.Grupods)
                        loc_cContaD = ALLTRIM(TempEest_4c.Contads)
                    ENDIF

                    SELECT crSigCdPam_4c
                    IF !EMPTY(crSigCdPam_4c.GruReservs)
                        loc_cGrupoD = ALLTRIM(crSigCdPam_4c.GruReservs)
                    ENDIF
                    IF !EMPTY(crSigCdPam_4c.ConReservs)
                        loc_cContaD = ALLTRIM(crSigCdPam_4c.ConReservs)
                    ENDIF

                    *-- Criar novo cabecalho de movimento de transferencia
                    IF (crSigCdPam_4c.AgrupEmph = 2 AND !EMPTY(crSigCdPam_4c.GruReservs) AND !loc_lGrvEest) OR (crSigCdPam_4c.AgrupEmph <> 2)
                        loc_nNume    = fGerUniqueKey(ALLTRIM(TmpEstoque_4c.EmpDs) + par_cDope)
                        loc_nCItens  = 1
                        loc_cEdnNovo = ALLTRIM(TmpEstoque_4c.EmpDs) + par_cDope + STR(loc_nNume, 6)
                        loc_cObsEst  = IIF(THIS.this_lReserva, "[ Reserva Autom" + CHR(225) + "tica ]", "[ OP: " + STR(par_nNump) + "] ") + loc_cChave
                        loc_cSql = "INSERT INTO SigMvCab (Emps,Dopes,Numes,MascNum,Datas,Datars,Usuars,Grupoos,Contaos,Grupods,Contads,Nops,Obses,cIdChaves,Dtalts,EmpDopNums,EmpDs,rNops) VALUES (" + ;
                                   EscaparSQL(ALLTRIM(TmpEstoque_4c.EmpDs)) + "," + EscaparSQL(par_cDope) + "," + LTRIM(STR(loc_nNume)) + "," + ;
                                   EscaparSQL(THIS.GerMascara(loc_nNume)) + "," + FormatarDataSQL(par_dDtGera) + ",GETDATE()," + ;
                                   EscaparSQL(par_cUsuar) + "," + EscaparSQL(ALLTRIM(TmpEstoque_4c.Grupos)) + "," + ;
                                   EscaparSQL(ALLTRIM(TmpEstoque_4c.Estos)) + "," + EscaparSQL(loc_cGrupoD) + "," + ;
                                   EscaparSQL(loc_cContaD) + "," + LTRIM(STR(par_nNump)) + "," + ;
                                   EscaparSQL(loc_cObsEst) + "," + EscaparSQL(fUniqueIds()) + ",GETDATE()," + ;
                                   EscaparSQL(loc_cEdnNovo) + "," + EscaparSQL(par_cEmpr) + "," + LTRIM(STR(par_nRnop)) + ")"
                        IF SQLEXEC(gnConnHandle, loc_cSql) <= 0
                            loc_lResultado = .F.
                            MsgErro("Falha ao inserir SigMvCab (baixa estoque)", "Erro")
                            EXIT
                        ENDIF
                        loc_lGrvEest = .T.
                    ELSE
                        loc_cEdnNovo = ALLTRIM(TmpEstoque_4c.Emps) + par_cDope + STR(loc_nNume, 6)
                        THIS.CursorQuery("SigMvCab", "TempEest_4c", "EmpDopNums", loc_cEdnNovo)
                        SELECT TempEest_4c
                        loc_cNewObs = ALLTRIM(NVL(TempEest_4c.Obses, "")) + " / " + loc_cChave
                        SQLEXEC(gnConnHandle, "UPDATE SigMvCab SET Obses=" + EscaparSQL(loc_cNewObs) + ",DtAlts=GETDATE() WHERE EmpDopNums=" + EscaparSQL(loc_cEdnNovo))
                    ENDIF
                ENDIF

                *-- INSERT SigMvItn (item de saida do estoque)
                SELECT TmpEstoque_4c
                SQLEXEC(gnConnHandle, "INSERT INTO SigMvItn (Emps,Dopes,Numes,CPros,Qtds,Cunis,DPros,Opers,cItens,EmpDopNums,CidChaves,DtAlts) VALUES (" + ;
                        EscaparSQL(ALLTRIM(TmpEstoque_4c.EmpDs)) + "," + EscaparSQL(par_cDope) + "," + LTRIM(STR(loc_nNume)) + "," + ;
                        EscaparSQL(ALLTRIM(TmpEstoque_4c.Cpros)) + "," + FormatarNumeroSQL(TmpEstoque_4c.Estoque, 3) + "," + ;
                        EscaparSQL(ALLTRIM(crSigCdPro_4c.Cunis)) + "," + EscaparSQL(ALLTRIM(crSigCdPro_4c.Dpros)) + ",'S'," + ;
                        LTRIM(STR(loc_nCItens)) + "," + EscaparSQL(loc_cEdnNovo) + "," + EscaparSQL(fUniqueIds()) + ",GETDATE())")

                *-- INSERT SigMvIts se grupo controla estoque por grade
                SELECT crSigCdGrp_4c
                IF crSigCdGrp_4c.TipoEstos > 1
                    SELECT TmpEstoque_4c
                    SQLEXEC(gnConnHandle, "INSERT INTO SigMvIts (cItens,Emps,Dopes,Numes,CPros,Qtds,CodCors,CodTams,QtdEmbs) VALUES (" + ;
                            LTRIM(STR(loc_nCItens)) + "," + EscaparSQL(ALLTRIM(TmpEstoque_4c.EmpDs)) + "," + EscaparSQL(par_cDope) + "," + ;
                            LTRIM(STR(loc_nNume)) + "," + EscaparSQL(ALLTRIM(TmpEstoque_4c.Cpros)) + "," + ;
                            FormatarNumeroSQL(TmpEstoque_4c.Estoque, 3) + "," + EscaparSQL(ALLTRIM(TmpEstoque_4c.CodCors)) + "," + ;
                            EscaparSQL(ALLTRIM(TmpEstoque_4c.CodTams)) + ",1)")
                ENDIF

                loc_nCItens = loc_nCItens + 1

                *-- INSERT SigMvHst se operacao controla historico
                THIS.CursorQuery("SigCdOpe", "crSigCdOpe_4c", "Dopes", par_cDope)
                SELECT crSigCdOpe_4c
                IF crSigCdOpe_4c.Estoqs = 1
                    SELECT TmpEstoque_4c
                    SQLEXEC(gnConnHandle, "INSERT INTO SigMvHst (Usuars,Datas,Datars,Emps,Dopes,Numes,Empos,Cpros,Qtds,Opers,Grupos,Estos,CodCors,CodTams,EmpDopNums,EmpGruEsts,OriDopNums,cIdChaves,Seqs) VALUES (" + ;
                            EscaparSQL(par_cUsuar) + "," + FormatarDataSQL(par_dDtGera) + ",GETDATE()," + ;
                            EscaparSQL(ALLTRIM(TmpEstoque_4c.EmpDs)) + "," + EscaparSQL(par_cDope) + "," + LTRIM(STR(loc_nNume)) + "," + ;
                            EscaparSQL(par_cEmpr) + "," + EscaparSQL(ALLTRIM(TmpEstoque_4c.Cpros)) + "," + ;
                            FormatarNumeroSQL(TmpEstoque_4c.Estoque, 3) + ",'S'," + ;
                            EscaparSQL(ALLTRIM(TmpEstoque_4c.Grupos)) + "," + EscaparSQL(ALLTRIM(TmpEstoque_4c.Estos)) + "," + ;
                            EscaparSQL(ALLTRIM(TmpEstoque_4c.CodCors)) + "," + EscaparSQL(ALLTRIM(TmpEstoque_4c.CodTams)) + "," + ;
                            EscaparSQL(ALLTRIM(TmpEstoque_4c.EmpDs) + par_cDope + STR(loc_nNume, 6)) + "," + ;
                            EscaparSQL(ALLTRIM(TmpEstoque_4c.EmpDs) + ALLTRIM(TmpEstoque_4c.Grupos) + ALLTRIM(TmpEstoque_4c.Estos)) + "," + ;
                            EscaparSQL(ALLTRIM(TmpEstoque_4c.EmpDs) + par_cDope + STR(loc_nNume, 6)) + "," + ;
                            EscaparSQL(fUniqueIds()) + ",0)")
                    SQLEXEC(gnConnHandle, "INSERT INTO SigMvHst (Usuars,Datas,Datars,Emps,Dopes,Numes,Empos,Cpros,Qtds,Opers,Grupos,Estos,CodCors,CodTams,EmpDopNums,EmpGruEsts,OriDopNums,cIdChaves,Seqs) VALUES (" + ;
                            EscaparSQL(par_cUsuar) + "," + FormatarDataSQL(par_dDtGera) + ",GETDATE()," + ;
                            EscaparSQL(par_cEmpr) + "," + EscaparSQL(par_cDope) + "," + LTRIM(STR(loc_nNume)) + "," + ;
                            EscaparSQL(par_cEmpr) + "," + EscaparSQL(ALLTRIM(TmpEstoque_4c.Cpros)) + "," + ;
                            FormatarNumeroSQL(TmpEstoque_4c.Estoque, 3) + ",'E'," + ;
                            EscaparSQL(loc_cGrupoD) + "," + EscaparSQL(loc_cContaD) + "," + ;
                            EscaparSQL(ALLTRIM(TmpEstoque_4c.CodCors)) + "," + EscaparSQL(ALLTRIM(TmpEstoque_4c.CodTams)) + "," + ;
                            EscaparSQL(par_cEmpr + par_cDope + STR(loc_nNume, 6)) + "," + ;
                            EscaparSQL(par_cEmpr + loc_cGrupoD + loc_cContaD) + "," + ;
                            EscaparSQL(ALLTRIM(TmpEstoque_4c.EmpDs) + par_cDope + STR(loc_nNume, 6)) + "," + ;
                            EscaparSQL(fUniqueIds()) + ",0)")
                ENDIF

                *-- Baixar QtProds em SigMvItn/SigMvIts
                SELECT TmpEstoque_4c
                loc_nQtBaixar = TmpEstoque_4c.Estoque
                loc_cEdnItn   = ALLTRIM(TmpEstoque_4c.Emps) + ALLTRIM(TmpEstoque_4c.Dopes) + STR(TmpEstoque_4c.Numes, 6)

                THIS.SqlExecute("SELECT * FROM SigMvIts WHERE EmpDopNums=" + EscaparSQL(loc_cEdnItn) + " AND CPros=" + EscaparSQL(ALLTRIM(TmpEstoque_4c.Cpros)), "TempEsti2_4c")
                GO TOP IN TempEsti2_4c
                loc_lTemItem2 = !EOF("TempEsti2_4c")

                THIS.SqlExecute("SELECT * FROM SigMvItn WHERE EmpDopNums=" + EscaparSQL(loc_cEdnItn) + " AND CPros=" + EscaparSQL(ALLTRIM(TmpEstoque_4c.Cpros)), "TempEestI_4c")

                SELECT TempEestI_4c
                SCAN WHILE loc_nQtBaixar > 0
                    loc_pIds = ALLTRIM(TempEestI_4c.cIdChaves)
                    IF TempEestI_4c.QtProds + loc_nQtBaixar <= TempEestI_4c.Qtds
                        loc_pQtd       = TempEestI_4c.QtProds + loc_nQtBaixar
                        loc_nQtBaixado = loc_nQtBaixar
                        loc_nQtBaixar  = 0
                    ELSE
                        loc_nQtBaixar  = loc_nQtBaixar - (TempEestI_4c.Qtds - TempEestI_4c.QtProds)
                        loc_nQtBaixado = TempEestI_4c.Qtds - TempEestI_4c.QtProds
                        loc_pQtd       = TempEestI_4c.Qtds
                    ENDIF
                    IF THIS.this_lReserva
                        SQLEXEC(gnConnHandle, "UPDATE SigMvItn SET QtProds=" + LTRIM(STR(loc_pQtd,12,3)) + ",QtReservas=" + LTRIM(STR(loc_pQtd,12,3)) + ",DtAlts=GETDATE() WHERE cIdChaves=" + EscaparSQL(loc_pIds))
                    ELSE
                        SQLEXEC(gnConnHandle, "UPDATE SigMvItn SET QtProds=" + LTRIM(STR(loc_pQtd,12,3)) + ",QtReservas=" + LTRIM(STR(loc_nQtBaixado,12,3)) + ",DtAlts=GETDATE() WHERE cIdChaves=" + EscaparSQL(loc_pIds))
                    ENDIF
                    IF !loc_lTemItem2
                        SELECT TmpEstoque_4c
                        SQLEXEC(gnConnHandle, "INSERT INTO SigBxEst (Emps,Dopes,Numes,CItens,Cpros,Datas,Empbs,Dopebs,Numebs,Qtdfs,CidChaves,EmpDopNums,EmpDopNumb) VALUES (" + ;
                                EscaparSQL(par_cEmpr) + "," + EscaparSQL(par_cDope) + "," + LTRIM(STR(loc_nNume)) + "," + ;
                                LTRIM(STR(TempEestI_4c.CItens)) + "," + EscaparSQL(ALLTRIM(TempEestI_4c.Cpros)) + "," + ;
                                FormatarDataSQL(par_dDtGera) + "," + EscaparSQL(ALLTRIM(TempEestI_4c.Emps)) + "," + ;
                                EscaparSQL(ALLTRIM(TempEestI_4c.Dopes)) + "," + LTRIM(STR(TempEestI_4c.Numes)) + "," + ;
                                FormatarNumeroSQL(loc_nQtBaixado, 3) + "," + EscaparSQL(fUniqueIds()) + "," + ;
                                EscaparSQL(par_cEmpr + par_cDope + STR(loc_nNume, 6)) + "," + ;
                                EscaparSQL(ALLTRIM(TempEestI_4c.Emps) + ALLTRIM(TempEestI_4c.Dopes) + STR(TempEestI_4c.Numes, 6)) + ")")
                    ENDIF
                    SELECT TempEestI_4c
                ENDSCAN

                *-- Baixar SigMvIts por grade de cor/tamanho
                SELECT TmpEstoque_4c
                loc_nQtBaixar = TmpEstoque_4c.Estoque
                SELECT TempEsti2_4c
                SCAN WHILE loc_nQtBaixar > 0
                    IF ALLTRIM(TempEsti2_4c.CodCors) <> ALLTRIM(TmpEstoque_4c.CodCors) OR ;
                       ALLTRIM(TempEsti2_4c.CodTams) <> ALLTRIM(TmpEstoque_4c.CodTams)
                        LOOP
                    ENDIF
                    loc_pIds = ALLTRIM(TempEsti2_4c.cIdChaves)
                    IF TempEsti2_4c.QtProds + loc_nQtBaixar <= TempEsti2_4c.Qtds
                        loc_pQtd       = TempEsti2_4c.QtProds + loc_nQtBaixar
                        loc_nQtBaixado = loc_nQtBaixar
                        loc_nQtBaixar  = 0
                    ELSE
                        loc_nQtBaixar  = loc_nQtBaixar - (TempEsti2_4c.Qtds - TempEsti2_4c.QtProds)
                        loc_nQtBaixado = TempEsti2_4c.Qtds - TempEsti2_4c.QtProds
                        loc_pQtd       = TempEsti2_4c.Qtds
                    ENDIF
                    IF THIS.this_lReserva
                        SQLEXEC(gnConnHandle, "UPDATE SigMvIts SET QtProds=" + LTRIM(STR(loc_pQtd,12,3)) + ",QtReservas=" + LTRIM(STR(loc_pQtd,12,3)) + ",DtAlts=GETDATE() WHERE cIdChaves=" + EscaparSQL(loc_pIds))
                    ELSE
                        SQLEXEC(gnConnHandle, "UPDATE SigMvIts SET QtProds=" + LTRIM(STR(loc_pQtd,12,3)) + ",QtReservas=" + LTRIM(STR(loc_nQtBaixado,12,3)) + ",DtAlts=GETDATE() WHERE cIdChaves=" + EscaparSQL(loc_pIds))
                    ENDIF
                    SELECT TmpEstoque_4c
                    SQLEXEC(gnConnHandle, "INSERT INTO SigBxEst (Emps,Dopes,Numes,CItens,Cpros,Datas,Empbs,Dopebs,Numebs,Qtdfs,CodCors,CodTams,cIdChaves,EmpDopNums,EmpDopNumb) VALUES (" + ;
                            EscaparSQL(par_cEmpr) + "," + EscaparSQL(par_cDope) + "," + LTRIM(STR(loc_nNume)) + "," + ;
                            LTRIM(STR(TempEsti2_4c.CItens)) + "," + EscaparSQL(ALLTRIM(TempEsti2_4c.Cpros)) + "," + ;
                            FormatarDataSQL(par_dDtGera) + "," + EscaparSQL(ALLTRIM(TempEsti2_4c.Emps)) + "," + ;
                            EscaparSQL(ALLTRIM(TempEsti2_4c.Dopes)) + "," + LTRIM(STR(TempEsti2_4c.Numes)) + "," + ;
                            FormatarNumeroSQL(loc_nQtBaixado, 3) + "," + EscaparSQL(ALLTRIM(TempEsti2_4c.CodCors)) + "," + ;
                            EscaparSQL(ALLTRIM(TempEsti2_4c.CodTams)) + "," + ;
                            EscaparSQL(par_cEmpr + par_cDope + STR(loc_nNume, 6)) + "," + ;
                            EscaparSQL(ALLTRIM(TempEsti2_4c.Emps) + ALLTRIM(TempEsti2_4c.Dopes) + STR(TempEsti2_4c.Numes, 6)) + ")")
                    SELECT TempEsti2_4c
                ENDSCAN

                SELECT TmpEstoque_4c
            ENDSCAN

        CATCH TO loc_oErro
            loc_lResultado = .F.
            MsgErro(loc_oErro.Message, "Erro em ProcessarBaixaEstoque")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarBaixaFabricacao - Processa baixa de producao em fabricacao
    * Equivalente ao bloco "Baixar Producao" do Processar.Click
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarBaixaFabricacao(par_cDopEst, par_nNume, par_nNump, ;
                                                  par_dDtGera, par_cEmpr, par_cUsuar)
        LOCAL loc_cSql, loc_lResultado, loc_nCItens, loc_xBaixa

        loc_lResultado = .T.
        loc_nCItens    = 1

        TRY
            *-- Criar cursor de alocacao de fabricacao
            SET NULL ON
            CREATE CURSOR TmpEstoqueFab_4c (Cpros c(14), CodCors c(4), CodTams c(4), ;
                                             Emps c(3), Dopes c(20), Numes n(6), Nops n(10), Estoque n(12,3))
            INDEX ON Emps + Dopes + STR(Numes, 6) TAG EmpDopNum
            SET NULL OFF

            *-- Preparar saldos de disponibilidade em TmpFabr
            SELECT TmpFabr
            SET ORDER TO
            REPLACE ALL Reservs WITH Disps

            *-- Alocar itens de fabricacao
            SELECT TmpFinal
            SET ORDER TO
            SCAN
                IF TmpFinal.Fabrs = 0
                    LOOP
                ENDIF
                loc_xBaixa = TmpFinal.Fabrs
                SELECT TmpFabr
                SET ORDER TO Cpros
                IF SEEK(ALLTRIM(TmpFinal.Cpros) + ALLTRIM(TmpFinal.CodCors) + ALLTRIM(TmpFinal.CodTams))
                    SCAN WHILE ALLTRIM(Cpros) = ALLTRIM(TmpFinal.Cpros) AND ;
                               ALLTRIM(CodCors) = ALLTRIM(TmpFinal.CodCors) AND ;
                               ALLTRIM(CodTams) = ALLTRIM(TmpFinal.CodTams) AND loc_xBaixa > 0
                        IF TmpFabr.Reservs >= loc_xBaixa
                            REPLACE TmpFabr.Reservs WITH TmpFabr.Reservs - loc_xBaixa IN TmpFabr
                            SELECT TmpFinal
                            INSERT INTO TmpEstoqueFab_4c (Cpros, CodCors, CodTams, Emps, Dopes, Numes, Nops, Estoque) ;
                                                  VALUES (ALLTRIM(TmpFinal.Cpros), ALLTRIM(TmpFinal.CodCors), ;
                                                          ALLTRIM(TmpFinal.CodTams), ALLTRIM(TmpFinal.Emps), ;
                                                          ALLTRIM(TmpFinal.Dopes), TmpFinal.Numes, TmpFabr.Nops, loc_xBaixa)
                            loc_xBaixa = 0
                        ELSE
                            IF TmpFabr.Reservs > 0
                                loc_nParcial = TmpFabr.Reservs
                                INSERT INTO TmpEstoqueFab_4c (Cpros, CodCors, CodTams, Emps, Dopes, Numes, Nops, Estoque) ;
                                                      VALUES (ALLTRIM(TmpFinal.Cpros), ALLTRIM(TmpFinal.CodCors), ;
                                                              ALLTRIM(TmpFinal.CodTams), ALLTRIM(TmpFinal.Emps), ;
                                                              ALLTRIM(TmpFinal.Dopes), TmpFinal.Numes, TmpFabr.Nops, loc_nParcial)
                                REPLACE TmpFabr.Reservs WITH 0 IN TmpFabr
                                loc_xBaixa = loc_xBaixa - loc_nParcial
                            ENDIF
                        ENDIF
                        SELECT TmpFabr
                    ENDSCAN
                ENDIF
                SELECT TmpFinal
            ENDSCAN

            *-- Inserir itens de saida de producao (SigMvItn) a partir de TmpFinalg
            SELECT TmpFinalg
            SET ORDER TO
            SCAN
                IF TmpFinalg.Produzir2 = 0
                    LOOP
                ENDIF

                THIS.CursorQuery("SigCdPro", "crSigCdPro_4c", "CPros", ALLTRIM(TmpFinalg.Cpros))
                THIS.CursorQuery("SigCdGrp", "crSigCdGrp_4c", "CGrus", ALLTRIM(crSigCdPro_4c.CGrus))
                SELECT TmpFinalg

                SQLEXEC(gnConnHandle, "INSERT INTO SigMvItn (Emps,Dopes,Numes,CPros,Qtds,Cunis,DPros,Opers,cItens,Pesos,Units,Moedas,Totas,EmpDopNums,CidChaves,DtAlts) VALUES (" + ;
                        EscaparSQL(par_cEmpr) + "," + EscaparSQL(par_cDopEst) + "," + LTRIM(STR(par_nNume)) + "," + ;
                        EscaparSQL(ALLTRIM(TmpFinalg.Cpros)) + "," + FormatarNumeroSQL(TmpFinalg.Produzir2, 3) + "," + ;
                        EscaparSQL(ALLTRIM(crSigCdPro_4c.Cunis)) + "," + EscaparSQL(ALLTRIM(crSigCdPro_4c.Dpros)) + ",'S'," + ;
                        LTRIM(STR(loc_nCItens)) + "," + FormatarNumeroSQL(crSigCdPro_4c.PesoMs * TmpFinalg.Produzir2, 3) + "," + ;
                        FormatarNumeroSQL(NVL(crSigCdPro_4c.pVens, 0), 3) + "," + EscaparSQL(ALLTRIM(NVL(crSigCdPro_4c.Moevs, ""))) + "," + ;
                        FormatarNumeroSQL(TmpFinalg.Produzir2 * NVL(crSigCdPro_4c.Pvens, 0), 3) + "," + ;
                        EscaparSQL(par_cEmpr + par_cDopEst + STR(par_nNume, 6)) + "," + EscaparSQL(fUniqueIds()) + ",GETDATE())")

                IF !THIS.this_lReserva
                    SQLEXEC(gnConnHandle, "UPDATE SigMvItn SET QtProds=Qtds WHERE EmpDopNums=" + ;
                            EscaparSQL(par_cEmpr + par_cDopEst + STR(par_nNume, 6)) + ;
                            " AND Cpros=" + EscaparSQL(ALLTRIM(TmpFinalg.Cpros)) + " AND cItens=" + LTRIM(STR(loc_nCItens)))
                ENDIF

                SELECT crSigCdGrp_4c
                IF crSigCdGrp_4c.TipoEstos > 1
                    SELECT TmpFinalg
                    SQLEXEC(gnConnHandle, "INSERT INTO SigMvIts (cItens,Emps,Dopes,Numes,CPros,Qtds,CodCors,CodTams,QtdEmbs) VALUES (" + ;
                            LTRIM(STR(loc_nCItens)) + "," + EscaparSQL(par_cEmpr) + "," + EscaparSQL(par_cDopEst) + "," + ;
                            LTRIM(STR(par_nNume)) + "," + EscaparSQL(ALLTRIM(TmpFinalg.Cpros)) + "," + ;
                            FormatarNumeroSQL(TmpFinalg.Produzir2, 3) + "," + EscaparSQL(ALLTRIM(TmpFinalg.CodCors)) + "," + ;
                            EscaparSQL(ALLTRIM(TmpFinalg.CodTams)) + ",1)")
                ENDIF

                loc_nCItens = loc_nCItens + 1
                SELECT TmpFinalg
            ENDSCAN

            *-- Processar OPI de fabricacao: gerar SigOpPii e baixar SigOpPic
            SELECT TmpEstoqueFab_4c
            SCAN
                loc_xBaixa = TmpEstoqueFab_4c.Estoque
                THIS.SqlExecute("SELECT * FROM SigOpPic WHERE Nops=" + LTRIM(STR(TmpEstoqueFab_4c.Nops)), "LocalOpi_4c")
                SELECT LocalOpi_4c
                GO TOP
                SCAN WHILE loc_xBaixa > 0
                    IF ALLTRIM(LocalOpi_4c.Dopes) <> par_cDopEst
                        LOOP
                    ENDIF
                    IF LocalOpi_4c.Qtds >= loc_xBaixa
                        SQLEXEC(gnConnHandle, "UPDATE SigOpPic SET Qtds=" + LTRIM(STR(LocalOpi_4c.Qtds - loc_xBaixa, 12, 3)) + " WHERE CidChaves=" + EscaparSQL(ALLTRIM(LocalOpi_4c.CidChaves)))
                        SELECT TmpEstoqueFab_4c
                        SQLEXEC(gnConnHandle, "INSERT INTO SigOpPii (Emps,Dopes,Numes,EmpDopNums,Empos,DopeOs,NumeOs,EmpDs,DopeDs,Numeds,Qtds,Nops,CidChaves) VALUES (" + ;
                                EscaparSQL(par_cEmpr) + "," + EscaparSQL(par_cDopEst) + "," + LTRIM(STR(par_nNume)) + "," + ;
                                EscaparSQL(par_cEmpr + par_cDopEst + STR(par_nNume, 6)) + "," + EscaparSQL(ALLTRIM(LocalOpi_4c.Empds)) + "," + ;
                                EscaparSQL(ALLTRIM(LocalOpi_4c.Dopes)) + "," + LTRIM(STR(LocalOpi_4c.Numes)) + "," + ;
                                EscaparSQL(ALLTRIM(TmpEstoqueFab_4c.Emps)) + "," + EscaparSQL(ALLTRIM(TmpEstoqueFab_4c.Dopes)) + "," + ;
                                LTRIM(STR(TmpEstoqueFab_4c.Numes)) + "," + FormatarNumeroSQL(loc_xBaixa, 3) + "," + ;
                                LTRIM(STR(LocalOpi_4c.Nops)) + "," + EscaparSQL(fUniqueIds()) + ")")
                        loc_xBaixa = 0
                    ELSE
                        IF LocalOpi_4c.Qtds > 0
                            SELECT TmpEstoqueFab_4c
                            SQLEXEC(gnConnHandle, "INSERT INTO SigOpPii (Emps,Dopes,Numes,EmpDopNums,Empos,DopeOs,NumeOs,EmpDs,DopeDs,Numeds,Qtds,Nops,CidChaves) VALUES (" + ;
                                    EscaparSQL(par_cEmpr) + "," + EscaparSQL(par_cDopEst) + "," + LTRIM(STR(par_nNume)) + "," + ;
                                    EscaparSQL(par_cEmpr + par_cDopEst + STR(par_nNume, 6)) + "," + EscaparSQL(ALLTRIM(LocalOpi_4c.Empds)) + "," + ;
                                    EscaparSQL(ALLTRIM(LocalOpi_4c.Dopes)) + "," + LTRIM(STR(LocalOpi_4c.Numes)) + "," + ;
                                    EscaparSQL(ALLTRIM(TmpEstoqueFab_4c.Emps)) + "," + EscaparSQL(ALLTRIM(TmpEstoqueFab_4c.Dopes)) + "," + ;
                                    LTRIM(STR(TmpEstoqueFab_4c.Numes)) + "," + FormatarNumeroSQL(LocalOpi_4c.Qtds, 3) + "," + ;
                                    LTRIM(STR(LocalOpi_4c.Nops)) + "," + EscaparSQL(fUniqueIds()) + ")")
                            loc_xBaixa = loc_xBaixa - LocalOpi_4c.Qtds
                        ENDIF
                    ENDIF

                    *-- Baixar QtProds em SigMvItn/SigMvIts da OP de fabricacao
                    SELECT TmpEstoqueFab_4c
                    THIS.BaixarQtProdsFab(TmpEstoqueFab_4c.Estoque, ;
                                         ALLTRIM(TmpEstoqueFab_4c.Emps) + ALLTRIM(TmpEstoqueFab_4c.Dopes) + STR(TmpEstoqueFab_4c.Numes, 6), ;
                                         ALLTRIM(TmpEstoqueFab_4c.Cpros), ;
                                         ALLTRIM(TmpEstoqueFab_4c.CodCors), ;
                                         ALLTRIM(TmpEstoqueFab_4c.CodTams))

                    SELECT LocalOpi_4c
                ENDSCAN
                SELECT TmpEstoqueFab_4c
            ENDSCAN

        CATCH TO loc_oErro
            loc_lResultado = .F.
            MsgErro(loc_oErro.Message, "Erro em ProcessarBaixaFabricacao")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BaixarQtProdsFab - Helper: baixa QtProds em SigMvItn/SigMvIts de OP
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BaixarQtProdsFab(par_nQtd, par_cEdn, par_cCpros, par_cCodCors, par_cCodTams)
        LOCAL loc_nQtBaixar, loc_pIds, loc_pQtd

        TRY
            loc_nQtBaixar = par_nQtd
            THIS.SqlExecute("SELECT * FROM SigMvItn WHERE EmpDopNums=" + EscaparSQL(par_cEdn) + " AND CPros=" + EscaparSQL(par_cCpros), "TempEestIFab_4c")
            SELECT TempEestIFab_4c
            SCAN WHILE loc_nQtBaixar > 0
                loc_pIds = ALLTRIM(TempEestIFab_4c.cIdChaves)
                IF TempEestIFab_4c.QtProds + loc_nQtBaixar <= TempEestIFab_4c.Qtds
                    loc_pQtd      = TempEestIFab_4c.QtProds + loc_nQtBaixar
                    loc_nQtBaixar = 0
                ELSE
                    loc_nQtBaixar = loc_nQtBaixar - (TempEestIFab_4c.Qtds - TempEestIFab_4c.QtProds)
                    loc_pQtd      = TempEestIFab_4c.Qtds
                ENDIF
                SQLEXEC(gnConnHandle, "UPDATE SigMvItn SET QtProds=" + LTRIM(STR(loc_pQtd,12,3)) + " WHERE cIdChaves=" + EscaparSQL(loc_pIds))
            ENDSCAN

            loc_nQtBaixar = par_nQtd
            THIS.SqlExecute("SELECT * FROM SigMvIts WHERE EmpDopNums=" + EscaparSQL(par_cEdn) + " AND CPros=" + EscaparSQL(par_cCpros), "TempEsti2Fab_4c")
            SELECT TempEsti2Fab_4c
            SCAN WHILE loc_nQtBaixar > 0
                IF ALLTRIM(CodCors) <> par_cCodCors OR ALLTRIM(CodTams) <> par_cCodTams
                    LOOP
                ENDIF
                loc_pIds = ALLTRIM(TempEsti2Fab_4c.cIdChaves)
                IF TempEsti2Fab_4c.QtProds + loc_nQtBaixar <= TempEsti2Fab_4c.Qtds
                    loc_pQtd      = TempEsti2Fab_4c.QtProds + loc_nQtBaixar
                    loc_nQtBaixar = 0
                ELSE
                    loc_nQtBaixar = loc_nQtBaixar - (TempEsti2Fab_4c.Qtds - TempEsti2Fab_4c.QtProds)
                    loc_pQtd      = TempEsti2Fab_4c.Qtds
                ENDIF
                SQLEXEC(gnConnHandle, "UPDATE SigMvIts SET QtProds=" + LTRIM(STR(loc_pQtd,12,3)) + " WHERE cIdChaves=" + EscaparSQL(loc_pIds))
            ENDSCAN
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BaixarQtProdsFab")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarEmpenhamentos - Gera empenhos e requisicoes de material
    * Equivalente ao bloco "If Not Empty(crSigCdPam.DopEmphs)..." do Processar.Click
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarEmpenhamentos(par_cDopp, par_cDopEst, par_nNump, par_nRnop, ;
                                               par_dDtGera, par_cEmpr, par_cUsuar)
        LOCAL loc_cSql, loc_lResultado, loc_nNume, loc_nCItens
        LOCAL loc_cDopeEmp, loc_cDopeReq, loc_cCgru, loc_cForn

        loc_lResultado = .T.

        TRY
            SELECT crSigCdPam_4c
            loc_cDopeEmp = ALLTRIM(crSigCdPam_4c.DopEmphs)
            loc_cDopeReq = ALLTRIM(crSigCdPam_4c.DopReqcs)

            *-- Processar SelPedra (itens especiais de pedra/gemstone)
            IF USED("SelPedra") AND RECCOUNT("SelPedra") > 0
                SELECT SelPedra
                SCAN
                    IF EMPTY(ALLTRIM(SelPedra.Cpros)) OR SelPedra.Qtds <= 0
                        LOOP
                    ENDIF
                    THIS.CursorQuery("SigCdPro", "crSigCdPro_4c", "CPros", ALLTRIM(SelPedra.Cpros))
                    THIS.CursorQuery("SigCdGrp", "crSigCdGrp_4c", "CGrus", ALLTRIM(crSigCdPro_4c.CGrus))
                    SELECT crSigCdGrp_4c
                    IF crSigCdGrp_4c.CEstoqs = 1 AND !EMPTY(crSigCdGrp_4c.GruEstps) AND !EMPTY(crSigCdGrp_4c.ConEstps)
                        loc_nQtde = SelPedra.Qtds
                        SELECT TmpPedra_4c
                        SET ORDER TO CMats
                        IF !SEEK(ALLTRIM(SelPedra.Cpros))
                            INSERT INTO TmpPedra_4c (Grupos, Contas, cGrus, cMats, QtdMins) ;
                                               VALUES (ALLTRIM(crSigCdGrp_4c.GruEstps), ALLTRIM(crSigCdGrp_4c.ConEstps), ;
                                                       ALLTRIM(crSigCdPro_4c.CGrus), ALLTRIM(SelPedra.Cpros), crSigCdPro_4c.QMins)
                        ENDIF
                        REPLACE Qtds WITH Qtds + loc_nQtde
                        SELECT TmpEmpH_4c
                        SET ORDER TO CMats
                        IF !SEEK(ALLTRIM(SelPedra.Cpros) + ALLTRIM(SelPedra.Cpro2s))
                            INSERT INTO TmpEmpH_4c (Grupos, Contas, cGrus, cMats, QtdMins, Cpro2s) ;
                                               VALUES (ALLTRIM(crSigCdGrp_4c.GruEstps), ALLTRIM(crSigCdGrp_4c.ConEstps), ;
                                                       ALLTRIM(crSigCdPro_4c.CGrus), ALLTRIM(SelPedra.Cpros), crSigCdPro_4c.QMins, ALLTRIM(SelPedra.Cpro2s))
                        ENDIF
                        REPLACE Qtds WITH Qtds + loc_nQtde
                        SELECT SelPedra
                    ENDIF
                ENDSCAN
            ENDIF

            *-- Processar composicoes dos produtos de TmpFinal
            SELECT TmpFinal
            SET ORDER TO Cpros
            SCAN
                IF TmpFinal.Produzir = 0
                    LOOP
                ENDIF
                loc_cSql = "SELECT GerEmphs FROM SigOpCdc WHERE Dopes=" + EscaparSQL(ALLTRIM(TmpFinal.Dopes))
                IF THIS.SqlExecute(loc_cSql, "TmpDcOpe_4c") > 0 AND !EOF("TmpDcOpe_4c")
                    IF TmpDcOpe_4c.GerEmphs <> 1
                        SELECT TmpFinal
                        LOOP
                    ENDIF
                ENDIF

                loc_cEpn     = ALLTRIM(TmpFinal.Emps) + ALLTRIM(TmpFinal.Dopes) + STR(TmpFinal.Numes, 6)
                loc_cSqlCpo  = "SELECT a.*, b.cgrus, b.PesoMs FROM SigSubMv a INNER JOIN SigCdPro b ON a.mats=b.cpros " + ;
                               "WHERE a.empdopnums=" + EscaparSQL(loc_cEpn) + ;
                               " AND a.cpros=" + EscaparSQL(ALLTRIM(TmpFinal.Cpros)) + ;
                               " AND a.citem2=" + LTRIM(STR(TmpFinal.Citens))
                IF THIS.SqlExecute(loc_cSqlCpo, "crSigPrCpo_4c") <= 0 OR RECCOUNT("crSigPrCpo_4c") = 0
                    loc_cSqlCpo = "SELECT a.*, b.cgrus, b.PesoMs FROM SigPrCpo a INNER JOIN SigCdPro b ON a.mats=b.cpros WHERE a.cpros=" + EscaparSQL(ALLTRIM(TmpFinal.Cpros))
                    THIS.SqlExecute(loc_cSqlCpo, "crSigPrCpo_4c")
                ENDIF

                SELECT crSigPrCpo_4c
                SCAN
                    THIS.CursorQuery("SigCdPro", "crSigCdPro_4c", "CPros", ALLTRIM(crSigPrCpo_4c.Mats))
                    THIS.CursorQuery("SigCdGrp", "crSigCdGrp_4c", "CGrus", ALLTRIM(crSigCdPro_4c.CGrus))
                    SELECT crSigCdGrp_4c
                    IF crSigCdGrp_4c.CEstoqs = 1 AND !EMPTY(crSigCdGrp_4c.GruEstps) AND !EMPTY(crSigCdGrp_4c.ConEstps)
                        SELECT TmpFinal
                        loc_nQtde = TmpFinal.Produzir * crSigPrCpo_4c.Qtds
                        SELECT TmpPedra_4c
                        SET ORDER TO CMats
                        IF !SEEK(ALLTRIM(crSigPrCpo_4c.Mats))
                            INSERT INTO TmpPedra_4c (Grupos, Contas, cGrus, cMats, QtdMins) ;
                                               VALUES (ALLTRIM(crSigCdGrp_4c.GruEstps), ALLTRIM(crSigCdGrp_4c.ConEstps), ;
                                                       ALLTRIM(crSigCdPro_4c.CGrus), ALLTRIM(crSigPrCpo_4c.Mats), crSigCdPro_4c.QMins)
                        ENDIF
                        REPLACE Qtds WITH Qtds + loc_nQtde
                        SELECT TmpEmpH_4c
                        SET ORDER TO CMats
                        IF !SEEK(ALLTRIM(crSigPrCpo_4c.Mats) + ALLTRIM(crSigPrCpo_4c.Cpros))
                            INSERT INTO TmpEmpH_4c (Grupos, Contas, cGrus, cMats, QtdMins, Cpro2s) ;
                                               VALUES (ALLTRIM(crSigCdGrp_4c.GruEstps), ALLTRIM(crSigCdGrp_4c.ConEstps), ;
                                                       ALLTRIM(crSigCdPro_4c.CGrus), ALLTRIM(crSigPrCpo_4c.Mats), crSigCdPro_4c.QMins, ALLTRIM(crSigPrCpo_4c.Cpros))
                        ENDIF
                        REPLACE Qtds WITH Qtds + loc_nQtde
                        SELECT crSigPrCpo_4c
                    ENDIF
                ENDSCAN
                SELECT TmpFinal
            ENDSCAN

            *-- Buscar estoque atual e atualizar QtdEsts em TmpPedra_4c
            loc_cSqlEst = "SELECT b.* FROM SigMvEst b WHERE NOT b.Sqtds = 0 AND b.Grupos + b.Estos IN " + ;
                          "(SELECT GruEstps + ConEstPs FROM SigCdGrp WHERE NOT GruEstPs = '" + SPACE(10) + "' AND NOT ConEstPs = '" + SPACE(10) + "' GROUP BY GruEstPs, ConEstPs)"
            IF THIS.SqlExecute(loc_cSqlEst, "pEstoque_4c") > 0
                SELECT pEstoque_4c
                SCAN
                    SELECT TmpPedra_4c
                    SET ORDER TO CMats
                    IF SEEK(ALLTRIM(pEstoque_4c.Cpros))
                        REPLACE QtdEsts WITH QtdEsts + pEstoque_4c.Sqtds
                    ENDIF
                    SELECT pEstoque_4c
                ENDSCAN
            ENDIF

            *-- Gerar empenho (DopEmphs)
            IF !EMPTY(loc_cDopeEmp)
                SELECT TmpEmpH_4c
                SET ORDER TO GruMat
                GO TOP
                IF !EOF("TmpEmpH_4c")
                    loc_cCgru   = ALLTRIM(TmpEmpH_4c.CGrus)
                    loc_nCItens = 999
                    SCAN
                        THIS.CursorQuery("SigCdPro", "crSigCdPro_4c", "CPros", ALLTRIM(TmpEmpH_4c.CMats))
                        SELECT TmpEmpH_4c
                        IF ALLTRIM(TmpEmpH_4c.Cgrus) <> loc_cCgru
                            loc_nCItens = 999
                            loc_cCgru   = ALLTRIM(TmpEmpH_4c.Cgrus)
                        ENDIF
                        IF loc_nCItens >= 999
                            loc_nCItens = 1
                            loc_nNume   = fGerUniqueKey(par_cEmpr + loc_cDopeEmp)
                            IF SQLEXEC(gnConnHandle, "INSERT INTO SigMvCab (Emps,Dopes,Numes,MascNum,Datas,Datars,Usuars,Grupoos,Contaos,Nops,Obses,EmpDopNums,cIdChaves,DtAlts,rNops) VALUES (" + ;
                                       EscaparSQL(par_cEmpr) + "," + EscaparSQL(loc_cDopeEmp) + "," + LTRIM(STR(loc_nNume)) + "," + ;
                                       EscaparSQL(THIS.GerMascara(loc_nNume)) + "," + FormatarDataSQL(par_dDtGera) + ",GETDATE()," + ;
                                       EscaparSQL(par_cUsuar) + "," + EscaparSQL(ALLTRIM(TmpEmpH_4c.Grupos)) + "," + ;
                                       EscaparSQL(ALLTRIM(TmpEmpH_4c.Contas)) + "," + LTRIM(STR(par_nNump)) + "," + ;
                                       EscaparSQL("[ OP: " + STR(par_nNump) + "] ") + "," + ;
                                       EscaparSQL(par_cEmpr + loc_cDopeEmp + STR(loc_nNume, 6)) + "," + ;
                                       EscaparSQL(fUniqueIds()) + ",GETDATE()," + LTRIM(STR(par_nRnop)) + ")") <= 0
                                loc_lResultado = .F.
                                MsgErro("Falha ao inserir empenho em SigMvCab", "Erro")
                                EXIT
                            ENDIF
                        ENDIF
                        SQLEXEC(gnConnHandle, "INSERT INTO SigMvItn (Emps,Dopes,Numes,CPros,Qtds,Cunis,DPros,Opers,Citens,cPro2s,EmpDopNums,CidChaves,DtAlts) VALUES (" + ;
                                EscaparSQL(par_cEmpr) + "," + EscaparSQL(loc_cDopeEmp) + "," + LTRIM(STR(loc_nNume)) + "," + ;
                                EscaparSQL(ALLTRIM(TmpEmpH_4c.cMats)) + "," + FormatarNumeroSQL(TmpEmpH_4c.Qtds, 3) + "," + ;
                                EscaparSQL(ALLTRIM(crSigCdPro_4c.Cunis)) + "," + EscaparSQL(ALLTRIM(crSigCdPro_4c.Dpros)) + ",'S'," + ;
                                LTRIM(STR(loc_nCItens)) + "," + EscaparSQL(ALLTRIM(TmpEmpH_4c.Cpro2s)) + "," + ;
                                EscaparSQL(par_cEmpr + loc_cDopeEmp + STR(loc_nNume, 6)) + "," + EscaparSQL(fUniqueIds()) + ",GETDATE())")
                        loc_nCItens = loc_nCItens + 1
                    ENDSCAN
                ENDIF
            ENDIF

            *-- Calcular necessidades de requisicao e gerar requisicao de compra (DopReqcs)
            IF !EMPTY(loc_cDopeReq)
                SELECT TmpPedra_4c
                SCAN
                    THIS.CursorQuery("SigOpCdc", "crSigOpCdc_4c", "Dopes", loc_cDopeReq)
                    SELECT crSigOpCdc_4c
                    IF RECCOUNT("crSigOpCdc_4c") > 0 AND crSigOpCdc_4c.verests <> 2
                        SELECT TmpPedra_4c
                        loc_nQtd = TmpPedra_4c.Qtds - (TmpPedra_4c.QtdEsts - TmpPedra_4c.QtdMins + TmpPedra_4c.QtdReqs + TmpPedra_4c.QtdPedcs + TmpPedra_4c.QtdComps - TmpPedra_4c.QtdEmphs)
                        IF loc_nQtd > 0
                            REPLACE QtdGReqs WITH loc_nQtd
                        ENDIF
                    ELSE
                        SELECT TmpPedra_4c
                        REPLACE QtdGReqs WITH TmpPedra_4c.Qtds
                    ENDIF
                    SELECT TmpPedra_4c
                ENDSCAN

                SELECT TmpPedra_4c
                SET ORDER TO GruMat
                GO TOP
                IF !EOF("TmpPedra_4c")
                    loc_cCgru   = ALLTRIM(TmpPedra_4c.Cgrus)
                    loc_cForn   = ""
                    loc_nCItens = 999
                    SCAN
                        IF TmpPedra_4c.QtdGReqs <= 0
                            LOOP
                        ENDIF
                        THIS.CursorQuery("SigCdPro", "crSigCdPro_4c", "CPros", ALLTRIM(TmpPedra_4c.CMats))
                        SELECT TmpPedra_4c

                        IF loc_nCItens >= 999
                            loc_nCItens = 1
                            loc_nNume   = fGerUniqueKey(par_cEmpr + loc_cDopeReq)
                            THIS.CursorQuery("SigCdOpe", "crSigCdOpe_4c", "Dopes", loc_cDopeReq)
                            loc_cForn = IIF(!EMPTY(ALLTRIM(crSigCdPro_4c.Ifors)), ALLTRIM(crSigCdPro_4c.Ifors), ALLTRIM(crSigCdOpe_4c.ConOrigs))
                            IF SQLEXEC(gnConnHandle, "INSERT INTO SigMvCab (Emps,Dopes,Numes,MascNum,Datas,Datars,Usuars,Grupoos,Contaos,Grupods,Contads,Nops,Obses,Empdopnums,cIdChaves,DtAlts,rNops) VALUES (" + ;
                                       EscaparSQL(par_cEmpr) + "," + EscaparSQL(loc_cDopeReq) + "," + LTRIM(STR(loc_nNume)) + "," + ;
                                       EscaparSQL(THIS.GerMascara(loc_nNume)) + "," + FormatarDataSQL(par_dDtGera) + ",GETDATE()," + ;
                                       EscaparSQL(par_cUsuar) + "," + EscaparSQL(ALLTRIM(crSigCdOpe_4c.GruOrigs)) + "," + ;
                                       EscaparSQL(loc_cForn) + "," + EscaparSQL(ALLTRIM(crSigCdOpe_4c.GruDests)) + "," + ;
                                       EscaparSQL(ALLTRIM(crSigCdOpe_4c.ConDests)) + "," + LTRIM(STR(par_nNump)) + "," + ;
                                       EscaparSQL("[ OP: " + STR(par_nNump) + "] ") + "," + ;
                                       EscaparSQL(par_cEmpr + loc_cDopeReq + STR(loc_nNume, 6)) + "," + ;
                                       EscaparSQL(fUniqueIds()) + ",GETDATE()," + LTRIM(STR(par_nRnop)) + ")") <= 0
                                loc_lResultado = .F.
                                MsgErro("Falha ao inserir requisi" + CHR(231) + CHR(227) + "o em SigMvCab", "Erro")
                                EXIT
                            ENDIF
                        ENDIF
                        SELECT TmpPedra_4c
                        SQLEXEC(gnConnHandle, "INSERT INTO SigMvItn (Emps,Dopes,Numes,CPros,Qtds,Cunis,DPros,Opers,Citens,EmpDopNums,CidChaves,DtAlts) VALUES (" + ;
                                EscaparSQL(par_cEmpr) + "," + EscaparSQL(loc_cDopeReq) + "," + LTRIM(STR(loc_nNume)) + "," + ;
                                EscaparSQL(ALLTRIM(TmpPedra_4c.cMats)) + "," + FormatarNumeroSQL(TmpPedra_4c.QtdGReqs, 3) + "," + ;
                                EscaparSQL(ALLTRIM(crSigCdPro_4c.Cunis)) + "," + EscaparSQL(ALLTRIM(crSigCdPro_4c.Dpros)) + ",'S'," + ;
                                LTRIM(STR(loc_nCItens)) + "," + EscaparSQL(par_cEmpr + loc_cDopeReq + STR(loc_nNume, 6)) + "," + ;
                                EscaparSQL(fUniqueIds()) + ",GETDATE())")
                        loc_nCItens = loc_nCItens + 1
                        SELECT TmpPedra_4c
                    ENDSCAN
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            loc_lResultado = .F.
            MsgErro(loc_oErro.Message, "Erro em ProcessarEmpenhamentos")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarHistorico - Atualiza cIdChaves/Seqs nos registros de SigMvHst
    * Equivalente ao GravaHis() do legado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GravarHistorico(par_cEmpr, par_cUsuar, par_cSigKey)
        LOCAL loc_cSql, loc_lResultado, loc_nRegistro, loc_nReservado, loc_nInicio
        LOCAL loc_nRerSeq, loc_nIniSeq, loc_cNewCid, loc_cIdOld

        loc_lResultado = .T.

        TRY
            loc_cSql = "SELECT * FROM SigMvHst WHERE Usuars=" + EscaparSQL(par_cUsuar) + " AND Datars >= DATEADD(SECOND,-5,GETDATE())"
            IF THIS.SqlExecute(loc_cSql, "crSigMvHst_4c") <= 0 OR RECCOUNT("crSigMvHst_4c") = 0
                loc_lResultado = .T.
            ENDIF

            loc_nRegistro = RECCOUNT("crSigMvHst_4c")
            loc_nReservado = 0

            DO WHILE loc_nReservado = 0 AND loc_nRegistro > 0
                loc_nReservado = fGerUniqueKey(DTOS(DATE()), .NULL., .NULL., loc_nRegistro + 1)
            ENDDO
            loc_nInicio  = loc_nReservado - loc_nRegistro
            loc_nRerSeq  = 0

            DO WHILE loc_nRerSeq = 0 AND loc_nRegistro > 0
                loc_nRerSeq = fGerUniqueKey("HISTBAR", .NULL., .NULL., loc_nRegistro + 1)
            ENDDO
            loc_nIniSeq = loc_nRerSeq - loc_nRegistro

            SELECT crSigMvHst_4c
            SCAN
                loc_nInicio  = loc_nInicio  + 1
                loc_nIniSeq  = loc_nIniSeq  + 1
                loc_cNewCid  = DTOS(crSigMvHst_4c.Datas) + ALLTRIM(crSigMvHst_4c.Opers) + ;
                               TRANSFORM(loc_nInicio, "@L 999999") + par_cSigKey
                loc_cIdOld   = ALLTRIM(crSigMvHst_4c.cIdChaves)
                SQLEXEC(gnConnHandle, "UPDATE SigMvHst SET cIdChaves=" + EscaparSQL(loc_cNewCid) + ",Seqs=" + LTRIM(STR(loc_nIniSeq)) + " WHERE cIdChaves=" + EscaparSQL(loc_cIdOld))
            ENDSCAN

        CATCH TO loc_oErro
            loc_lResultado = .F.
            MsgErro(loc_oErro.Message, "Erro em GravarHistorico")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarPeso - Calcula peso total a partir da composicao corrente
    * Equivalente ao AtualizaPeso() do legado
    * Assume que o cursor atual (alias corrente) eh LocalCompo_4c ou similar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarPeso()
        LOCAL loc_nTotQtd, loc_cCompo, loc_cSql, loc_nFator

        loc_nTotQtd = 0
        loc_cCompo  = ALIAS()

        TRY
            SELECT crSigCdPam_4c
            IF crSigCdPam_4c.AutComps <> 1
                SELECT &loc_cCompo.
                SCAN
                    IF !USED("crSigCdCom_4c")
                        THIS.SqlExecute("SELECT * FROM SigCdCom", "crSigCdCom_4c")
                    ENDIF
                    GO TOP IN crSigCdCom_4c
                    SELECT crSigCdCom_4c
                    LOCATE FOR ALLTRIM(crSigCdCom_4c.CGrus) = ALLTRIM(&loc_cCompo..CGrus) AND crSigCdCom_4c.Custos = 1
                    IF !EOF("crSigCdCom_4c")
                        loc_cSql = "SELECT a.cUnis, a.cUnips, b.BPesos FROM SigCdPro a, SigCdGrp b WHERE a.CPros=" + ;
                                   EscaparSQL(ALLTRIM(&loc_cCompo..Mats)) + " AND a.CGrus=b.CGrus"
                        IF THIS.SqlExecute(loc_cSql, "crSomaGru_4c") > 0 AND !EOF("crSomaGru_4c")
                            SELECT crSomaGru_4c
                            IF INLIST(crSomaGru_4c.BPesos, 1, 3)
                                loc_cUniKey = IIF(crSomaGru_4c.BPesos = 1, ALLTRIM(crSomaGru_4c.Cunis), ALLTRIM(crSomaGru_4c.CUnips))
                                IF THIS.SqlExecute("SELECT Fators FROM SigCdUni WHERE Cunis=" + EscaparSQL(loc_cUniKey), "LocalUni_4c") > 0 AND !EOF("LocalUni_4c")
                                    loc_nFator = IIF(NVL(LocalUni_4c.Fators, 0) = 0, 1, LocalUni_4c.Fators)
                                    SELECT &loc_cCompo.
                                    loc_nTotQtd = loc_nTotQtd + (IIF(crSomaGru_4c.BPesos = 1, &loc_cCompo..Qtds, &loc_cCompo..Pesos) * loc_nFator)
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                    SELECT &loc_cCompo.
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em AtualizarPeso")
        ENDTRY

        RETURN loc_nTotQtd
    ENDPROC

    *--------------------------------------------------------------------------
    * GerMascara - Formata numero como string de 6 digitos (substituto de fGerMascara)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerMascara(par_nNum)
        RETURN PADL(LTRIM(STR(par_nNum)), 6, "0")
    ENDPROC

    *--------------------------------------------------------------------------
    * CursorQuery - Executa SELECT simples via SQLEXEC
    * Equivalente ao poDataMgr.CursorQuery() do legado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CursorQuery(par_cTabela, par_cCursor, par_cCampo, par_vValor)
        LOCAL loc_cSql, loc_nRet

        IF USED(par_cCursor)
            USE IN (par_cCursor)
        ENDIF

        DO CASE
            CASE VARTYPE(par_vValor) = "C"
                loc_cSql = "SELECT * FROM " + par_cTabela + " WHERE " + par_cCampo + " = " + EscaparSQL(ALLTRIM(par_vValor))
            CASE VARTYPE(par_vValor) = "N"
                loc_cSql = "SELECT * FROM " + par_cTabela + " WHERE " + par_cCampo + " = " + LTRIM(STR(par_vValor))
            OTHERWISE
                loc_cSql = "SELECT * FROM " + par_cTabela + " WHERE 0=1"
        ENDCASE

        loc_nRet = SQLEXEC(gnConnHandle, loc_cSql, par_cCursor)
        IF loc_nRet <= 0 OR !USED(par_cCursor)
            SQLEXEC(gnConnHandle, "SELECT * FROM " + par_cTabela + " WHERE 0=1", par_cCursor)
        ENDIF
        IF USED(par_cCursor) AND RECCOUNT(par_cCursor) > 0
            GO TOP IN (par_cCursor)
        ENDIF
        RETURN NVL(loc_nRet, 0)
    ENDPROC

    *--------------------------------------------------------------------------
    * SqlExecute - Executa SQL via SQLEXEC
    * Equivalente ao poDataMgr.SqlExecute() do legado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE SqlExecute(par_cSql, par_cCursor)
        LOCAL loc_nRet

        IF VARTYPE(par_cCursor) = "C" AND !EMPTY(par_cCursor)
            IF USED(par_cCursor)
                USE IN (par_cCursor)
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, par_cSql, par_cCursor)
        ELSE
            loc_nRet = SQLEXEC(gnConnHandle, par_cSql)
        ENDIF

        RETURN NVL(loc_nRet, 0)
    ENDPROC

ENDDEFINE

