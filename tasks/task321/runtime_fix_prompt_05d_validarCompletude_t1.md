# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[FormSIGPRPPP.prg] Procedure vazia (sem codigo): ConfigurarPaginaDados
[FormSIGPRPPP.prg] Procedure vazia (sem codigo): AlternarPagina
[FormSIGPRPPP.prg] Procedure vazia (sem codigo): AjustarBotoesPorModo
[FormSIGPRPPP.prg] Procedure vazia (sem codigo): BtnIncluirClick
[FormSIGPRPPP.prg] Procedure vazia (sem codigo): BtnAlterarClick
[FormSIGPRPPP.prg] Procedure vazia (sem codigo): BtnVisualizarClick
[FormSIGPRPPP.prg] Procedure vazia (sem codigo): BtnExcluirClick
[FormSIGPRPPP.prg] Procedure vazia (sem codigo): BtnBuscarClick
[FormSIGPRPPP.prg] Procedure vazia (sem codigo): BtnSalvarClick
[FormSIGPRPPP.prg] Procedure vazia (sem codigo): BtnCancelarClick
[FormSIGPRPPP.prg] Procedure vazia (sem codigo): HabilitarCampos

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRPPP.prg):
*==============================================================================
* FormSIGPRPPP.prg - Formulario Operacional: Resultado Pesquisa Produtos por Conta
* Tipo: OPERACIONAL (popup sub-form, sem PageFrame CRUD)
* Aberto por FormSigPrPpc apos consulta em SigMvCab
* Exibe movimentacoes (grd_4c_Operacoes) e seus itens (grd_4c_Itens)
* Migrado de SIGPRPPP.SCX
*==============================================================================
DEFINE CLASS FormSIGPRPPP AS FormBase

    *-- Dimensoes e layout identicos ao legado
    Width       = 800
    Height      = 500
    BorderStyle = 2
    AutoCenter  = .T.
    TitleBar    = 0
    AlwaysOnTop = .T.
    ShowWindow = 1
    WindowType = 1
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    DataSession = 2
    FontName    = "Tahoma"
    FontSize    = 8
    Caption     = "Pesquisa de Produtos por Conta"

    *-- Business Object e estado interno
    this_oBusinessObject = .NULL.
    this_cMensagemErro   = ""
    this_oFormPai        = .NULL.

    *==========================================================================
    * Init - Recebe referencia ao form pai (FormSigPrPpc) e ID de datasession
    * par_oFormPai      : referencia ao form pai (para re-habilitar ao encerrar)
    * par_nDataSession  : DataSessionID do form pai (onde TprMvCab reside)
    *==========================================================================
    PROCEDURE Init(par_oFormPai, par_nDataSession)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF VARTYPE(par_oFormPai) = "O"
                THIS.this_oFormPai = par_oFormPai
            ENDIF
            IF VARTYPE(par_nDataSession) = "N" AND par_nDataSession > 0
                SET DATASESSION TO (par_nDataSession)
            ENDIF
            THIS.this_oBusinessObject = CREATEOBJECT("SIGPRPPPBO")
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_lSucesso = DODEFAULT()
            ELSE
                MsgErro("Erro ao criar SIGPRPPPBO." + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Proc: " + loc_oErro.Procedure, "Erro Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarForm - Monta estrutura visual completa do form
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            ENDIF

            THIS.ConfigurarPageFrame()
            THIS.ConfigurarPaginaLista()
            THIS.InicializarValores()
            THIS.CarregarDados()
            THIS.TornarControlesVisiveis(THIS)
            THIS.ConfigurarBINDEVENTs()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Proc: " + loc_oErro.Procedure, "Erro InicializarForm")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cabecalho cinza com titulo (estrutura OPERACIONAL)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .Visible     = .T.
            .AddObject("lbl_4c_LblSombra", "Label")
        ENDWITH
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .Top       = 25
            .Left      = 10
            .Width     = 769
            .Height    = 40
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .Caption   = THIS.Caption
            .WordWrap  = .T.
        ENDWITH
        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .Top       = 24
            .Left      = 10
            .Width     = 769
            .Height    = 46
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .Caption   = THIS.Caption
            .WordWrap  = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Monta CommandGroup Encerrar, shapes, labels de
    * filtro (somente leitura) e os dois grids de resultado
    * Form OPERACIONAL popup: nao tem Page1/Page2 CRUD; esta eh a unica "pagina"
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oCmg

        *-- CommandGroup Encerrar (legado: grp_operacao, ButtonCount=1)
        THIS.AddObject("cmg_4c_Encerrar", "CommandGroup")
        loc_oCmg = THIS.cmg_4c_Encerrar
        WITH loc_oCmg
            .Top           = -2
            .Left          = 717
            .Width         = 85
            .Height        = 85
            .ButtonCount   = 1
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = 0
            WITH .Buttons(1)
                .Top             = 5
                .Left            = 5
                .Width           = 75
                .Height          = 75
                .Caption         = "Encerrar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Cancel          = .T.
                .Themes          = .F.
                .WordWrap        = .T.
                .PicturePosition = 13
                .ToolTipText     = "[ESC] - Encerrar"
            ENDWITH
        ENDWITH

        *-- Shape cliente/periodo
        THIS.AddObject("shp_4c_Shp_cliente_periodo", "Shape")
        WITH THIS.shp_4c_Shp_cliente_periodo
            .Top           = 108
            .Left          = 132
            .Height        = 90
            .Width         = 484
            .BackStyle     = 0
            .SpecialEffect = 1
        ENDWITH

        *-- Linha PERIODO
        THIS.AddObject("lbl_4c_Lbl_periodo", "Label")
        WITH THIS.lbl_4c_Lbl_periodo
            .Top      = 121
            .Left     = 143
            .Caption  = "Per" + CHR(237) + "odo :"
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
        ENDWITH

        THIS.AddObject("txt_4c_DtIni", "TextBox")
        WITH THIS.txt_4c_DtIni
            .Top       = 116
            .Left      = 197
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Enabled   = .F.
        ENDWITH

        THIS.AddObject("lbl_4c_Lbl_periodo_a", "Label")
        WITH THIS.lbl_4c_Lbl_periodo_a
            .Top      = 121
            .Left     = 280
            .Caption  = CHR(224)
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
        ENDWITH

        THIS.AddObject("txt_4c_DtFin", "TextBox")
        WITH THIS.txt_4c_DtFin
            .Top       = 116
            .Left      = 290
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Enabled   = .F.
        ENDWITH

        *-- Linha GRUPO (Say4 / Get_grupo)
        THIS.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.lbl_4c_Label4
            .Top      = 147
            .Left     = 151
            .Caption  = "Grupo :"
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
        ENDWITH

        THIS.AddObject("txt_4c_Grupo", "TextBox")
        WITH THIS.txt_4c_Grupo
            .Top       = 144
            .Left      = 197
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Enabled   = .F.
        ENDWITH

        *-- Linha CONTA
        THIS.AddObject("lbl_4c_Lbl_cliente", "Label")
        WITH THIS.lbl_4c_Lbl_cliente
            .Top      = 174
            .Left     = 152
            .Caption  = "Conta :"
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
        ENDWITH

        THIS.AddObject("txt_4c_Conta", "TextBox")
        WITH THIS.txt_4c_Conta
            .Top       = 169
            .Left      = 197
            .Width     = 80
            .Height    = 23
            .FontName  = "Courier New"
            .FontSize  = 8
            .Enabled   = .F.
        ENDWITH

        THIS.AddObject("txt_4c_ContaDesc", "TextBox")
        WITH THIS.txt_4c_ContaDesc
            .Top       = 169
            .Left      = 279
            .Width     = 290
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Enabled   = .F.
        ENDWITH

        *-- Shape Operacoes
        THIS.AddObject("shp_4c_Shp_operacao", "Shape")
        WITH THIS.shp_4c_Shp_operacao
            .Top           = 224
            .Left          = 133
            .Height        = 112
            .Width         = 484
            .BackStyle     = 0
            .SpecialEffect = 1
        ENDWITH

        *-- Label Movimentacoes
        THIS.AddObject("lbl_4c_Lbl_operacao", "Label")
        WITH THIS.lbl_4c_Lbl_operacao
            .Top       = 210
            .Left      = 143
            .Width     = 92
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Movimenta" + CHR(231) + CHR(245) + "es"
        ENDWITH

        *-- Grid Operacoes (5 colunas: Emp / Movimentacao / Numero / Data / Valor)
        THIS.AddObject("grd_4c_Operacoes", "Grid")
        WITH THIS.grd_4c_Operacoes
            .Top         = 234
            .Left        = 140
            .Width       = 469
            .Height      = 94
            .ColumnCount = 5
            .FontName    = "Arial"
            .FontSize    = 8
            .DeleteMark  = .F.
            .RecordMark  = .F.
            .ReadOnly    = .T.
            .ScrollBars  = 2
        ENDWITH
        WITH THIS.grd_4c_Operacoes.Column1
            .FontName  = "Courier New"
            .Width     = 31
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .Header1.Caption   = "Emp."
            .Header1.FontName  = "Verdana"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(90, 90, 90)
            .Text1.BorderStyle = 0
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH
        WITH THIS.grd_4c_Operacoes.Column2
            .FontName  = "Courier New"
            .Width     = 150
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .Header1.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
            .Header1.FontName  = "Verdana"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(90, 90, 90)
            .Text1.BorderStyle = 0
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH
        WITH THIS.grd_4c_Operacoes.Column3
            .FontName  = "Courier New"
            .Width     = 80
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .Header1.Caption   = "N" + CHR(250) + "mero"
            .Header1.FontName  = "Verdana"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(90, 90, 90)
            .Text1.BorderStyle = 0
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH
        WITH THIS.grd_4c_Operacoes.Column4
            .FontName  = "Courier New"
            .Width     = 75
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .Header1.Caption   = "Data"
            .Header1.FontName  = "Verdana"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(90, 90, 90)
            .Text1.BorderStyle = 0
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH
        WITH THIS.grd_4c_Operacoes.Column5
            .FontName  = "Courier New"
            .Width     = 98
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .Format    = "999,999,999.99"
            .Header1.Caption   = "Valor"
            .Header1.FontName  = "Verdana"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(90, 90, 90)
            .Text1.BorderStyle = 0
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Shape Itens
        THIS.AddObject("shp_4c_Shp_itens", "Shape")
        WITH THIS.shp_4c_Shp_itens
            .Top           = 354
            .Left          = 133
            .Height        = 127
            .Width         = 511
            .BackStyle     = 0
            .SpecialEffect = 1
        ENDWITH

        *-- Label Itens
        THIS.AddObject("lbl_4c_Lbl_itens", "Label")
        WITH THIS.lbl_4c_Lbl_itens
            .Top       = 339
            .Left      = 143
            .Width     = 38
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = " " + CHR(205) + "tens "
        ENDWITH

        *-- Grid Itens (3 colunas: Produto / Descricao / Qtde)
        THIS.AddObject("grd_4c_Itens", "Grid")
        WITH THIS.grd_4c_Itens
            .Top         = 363
            .Left        = 140
            .Width       = 497
            .Height      = 112
            .ColumnCount = 3
            .FontName    = "Tahoma"
            .FontSize    = 8
            .DeleteMark  = .F.
            .RecordMark  = .F.
            .ReadOnly    = .T.
            .ScrollBars  = 2
        ENDWITH
        WITH THIS.grd_4c_Itens.Column1
            .FontName  = "Tahoma"
            .Width     = 108
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .Header1.Caption   = "Produto"
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(90, 90, 90)
            .Text1.BorderStyle = 0
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH
        WITH THIS.grd_4c_Itens.Column2
            .FontName  = "Tahoma"
            .Width     = 290
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(90, 90, 90)
            .Text1.BorderStyle = 0
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH
        WITH THIS.grd_4c_Itens.Column3
            .FontName  = "Tahoma"
            .Width     = 66
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .Header1.Caption   = "Qtde."
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(90, 90, 90)
            .Text1.BorderStyle = 0
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *==========================================================================
    * InicializarValores - Preenche campos de filtro (somente leitura)
    * com os valores do BO do form pai (FormSigPrPpc)
    *==========================================================================
    PROTECTED PROCEDURE InicializarValores()
        LOCAL loc_oParentBO, loc_oErro
        TRY
            IF VARTYPE(THIS.this_oFormPai) = "O"
                loc_oParentBO = THIS.this_oFormPai.this_oBusinessObject
                IF VARTYPE(loc_oParentBO) = "O"
                    THIS.txt_4c_Grupo.Value     = loc_oParentBO.this_cGrupo
                    THIS.txt_4c_Conta.Value     = loc_oParentBO.this_cConta
                    THIS.txt_4c_ContaDesc.Value = loc_oParentBO.this_cContaDesc
                    THIS.txt_4c_DtIni.Value     = IIF(EMPTY(loc_oParentBO.this_dInicial), ;
                                                      DATE(), loc_oParentBO.this_dInicial)
                    THIS.txt_4c_DtFin.Value     = IIF(EMPTY(loc_oParentBO.this_dFinal), ;
                                                      DATE(), loc_oParentBO.this_dFinal)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro InicializarValores")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarDados - Chama BO.CarregarMovimentos e vincula cursores aos grids
    * TprMvCab deve estar disponivel na datasession atual (par_nDataSession)
    *==========================================================================
    PROTECTED PROCEDURE CarregarDados()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = THIS.this_oBusinessObject.CarregarMovimentos("TprMvCab")
            IF !loc_lSucesso
                IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                    MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
                             "Aten" + CHR(231) + CHR(227) + "o")
                ENDIF
            ELSE
                *-- ColumnCount ANTES de RecordSource (evita auto-expand de colunas do cursor)
                THIS.grd_4c_Operacoes.ColumnCount           = 5
                THIS.grd_4c_Operacoes.RecordSource          = "cursor_4c_Operacoes"
                THIS.grd_4c_Operacoes.column1.ControlSource = "cursor_4c_Operacoes.Emps"
                THIS.grd_4c_Operacoes.column2.ControlSource = "cursor_4c_Operacoes.Dopes"
                THIS.grd_4c_Operacoes.column3.ControlSource = "cursor_4c_Operacoes.Numes"
                THIS.grd_4c_Operacoes.column4.ControlSource = "cursor_4c_Operacoes.Datas"
                THIS.grd_4c_Operacoes.column5.ControlSource = "cursor_4c_Operacoes.Valos"
                *-- Restaurar cabecalhos: RecordSource reseta Header1.Caption para "columnN"
                THIS.grd_4c_Operacoes.Column1.Header1.Caption = "Emp."
                THIS.grd_4c_Operacoes.Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
                THIS.grd_4c_Operacoes.Column3.Header1.Caption = "N" + CHR(250) + "mero"
                THIS.grd_4c_Operacoes.Column4.Header1.Caption = "Data"
                THIS.grd_4c_Operacoes.Column5.Header1.Caption = "Valor"

                *-- ColumnCount ANTES de RecordSource
                THIS.grd_4c_Itens.ColumnCount           = 3
                THIS.grd_4c_Itens.RecordSource          = "cursor_4c_Itens"
                THIS.grd_4c_Itens.column1.ControlSource = "cursor_4c_Itens.Cpros"
                THIS.grd_4c_Itens.column2.ControlSource = "cursor_4c_Itens.Dpros"
                THIS.grd_4c_Itens.column3.ControlSource = "cursor_4c_Itens.Qtds"
                *-- Restaurar cabecalhos
                THIS.grd_4c_Itens.Column1.Header1.Caption = "Produto"
                THIS.grd_4c_Itens.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                THIS.grd_4c_Itens.Column3.Header1.Caption = "Qtde."
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Proc: " + loc_oErro.Procedure, "Erro CarregarDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarBINDEVENTs - Conecta handlers de eventos
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBINDEVENTs()
        BINDEVENT(THIS.grd_4c_Operacoes, "AfterRowColChange", ;
                  THIS, "GrdOperacoesAfterRowColChange")
        BINDEVENT(THIS.cmg_4c_Encerrar.Buttons(1), "Click", THIS, "CmdEncerrarClick")
    ENDPROC

    *==========================================================================
    * GrdOperacoesAfterRowColChange - Carrega itens da operacao selecionada
    * Replica logica legado: so recarrega quando linha realmente mudar
    *==========================================================================
    PROCEDURE GrdOperacoesAfterRowColChange(par_nColIndex)
        LOCAL loc_nLinhaAtual, loc_oErro
        TRY
            loc_nLinhaAtual = THIS.grd_4c_Operacoes.ActiveRow
            IF THIS.this_oBusinessObject.this_nLinhaAnterior != loc_nLinhaAtual
                THIS.this_oBusinessObject.this_nLinhaAnterior = loc_nLinhaAtual
                THIS.LockScreen   = .T.
                THIS.MousePointer = 11
                IF USED("cursor_4c_Operacoes")
                    SELECT cursor_4c_Operacoes
                    THIS.this_oBusinessObject.CarregarItensPorOperacao( ;
                        cursor_4c_Operacoes.Emps, ;
                        cursor_4c_Operacoes.Dopes, ;
                        cursor_4c_Operacoes.Numes)
                ENDIF
                THIS.grd_4c_Itens.Refresh()
                THIS.MousePointer = 0
                THIS.LockScreen   = .F.
            ENDIF
        CATCH TO loc_oErro
            THIS.MousePointer = 0
            THIS.LockScreen   = .F.
            MsgErro(loc_oErro.Message, "Erro ao carregar itens")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdEncerrarClick - Reabilita form pai (legado: ParentForm.Enabled=.T.),
    * devolve foco a txt_4c_Conta e fecha este popup
    *==========================================================================
    PROCEDURE CmdEncerrarClick()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oFormPai) = "O"
                IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
                    THIS.this_oFormPai.Enabled = .T.
                ENDIF
                IF PEMSTATUS(THIS.this_oFormPai, "txt_4c_Conta", 5)
                    THIS.this_oFormPai.txt_4c_Conta.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao encerrar")
        ENDTRY
        THIS.Release()
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    *==========================================================================
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl
        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5)
                    IF loc_oControl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControl)
                    ENDIF
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Contrato FormBase: form OPERACIONAL popup nao tem
    * separacao Page1/Page2; toda a UI (filtros + grids) esta em ConfigurarPaginaLista.
    * Cabecalho (cnt_4c_Sombra) montado em ConfigurarPageFrame.
    * Campos de filtro Grupo/Conta/DtIni/DtFin criados em ConfigurarPaginaLista sao
    * populados por InicializarValores() a partir do BO do form pai.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
    ENDPROC

    *==========================================================================
    * AlternarPagina - Contrato FormBase: form OPERACIONAL popup sem PageFrame CRUD
    * Sem acao local; chamada em CmdEncerrarClick aponta para AlternarPagina do PAI
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
    ENDPROC

    *==========================================================================
    * CarregarLista - Contrato FormBase: nao aplicavel a form OPERACIONAL popup
    *==========================================================================
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Contrato FormBase: sem botoes CRUD neste form
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Contrato FormBase: sem acao neste form OPERACIONAL popup
    * (form somente leitura - exibe resultados da pesquisa, sem insercao)
    *==========================================================================
    PROCEDURE BtnIncluirClick()
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Contrato FormBase: sem acao neste form OPERACIONAL popup
    * (form somente leitura - exibe resultados da pesquisa, sem edicao)
    *==========================================================================
    PROCEDURE BtnAlterarClick()
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Contrato FormBase: sem acao neste form OPERACIONAL popup
    * (form somente leitura - toda a exibicao ja ocorre nos grids de resultados)
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Contrato FormBase: sem acao neste form OPERACIONAL popup
    * (form somente leitura - exibe resultados da pesquisa, sem exclusao)
    *==========================================================================
    PROCEDURE BtnExcluirClick()
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Contrato FormBase: sem acao neste form OPERACIONAL popup
    * (popup recebe dados pre-filtrados do form pai, sem busca propria)
    *==========================================================================
    PROCEDURE BtnBuscarClick()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Contrato FormBase: delega ao handler do CommandGroup
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.CmdEncerrarClick()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Contrato FormBase: sem acao neste form OPERACIONAL popup
    * (form somente leitura - nao ha dados editaveis a salvar)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Contrato FormBase: sem acao neste form OPERACIONAL popup
    * (form somente leitura - nao ha edicao a cancelar)
    *==========================================================================
    PROCEDURE BtnCancelarClick()
    ENDPROC

    *==========================================================================
    * FormParaBO - Contrato FormBase: form OPERACIONAL somente-leitura.
    * Filtros populados pelo form pai em InicializarValores(); nao ha campos
    * editaveis. Propaga apenas os valores de exibicao para auditoria.
    *==========================================================================
    PROCEDURE FormParaBO()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_cGrupo     = ALLTRIM(THIS.txt_4c_Grupo.Value)
                THIS.this_oBusinessObject.this_cConta     = ALLTRIM(THIS.txt_4c_Conta.Value)
                THIS.this_oBusinessObject.this_cContaDesc = ALLTRIM(THIS.txt_4c_ContaDesc.Value)
                THIS.this_oBusinessObject.this_dInicial   = THIS.txt_4c_DtIni.Value
                THIS.this_oBusinessObject.this_dFinal     = THIS.txt_4c_DtFin.Value
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro FormParaBO")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BOParaForm - Contrato FormBase: propaga valores do BO para os controles
    * de exibicao de filtro (somente-leitura). Complementa InicializarValores.
    *==========================================================================
    PROCEDURE BOParaForm()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.txt_4c_Grupo.Value     = THIS.this_oBusinessObject.this_cGrupo
                THIS.txt_4c_Conta.Value     = THIS.this_oBusinessObject.this_cConta
                THIS.txt_4c_ContaDesc.Value = THIS.this_oBusinessObject.this_cContaDesc
                IF !EMPTY(THIS.this_oBusinessObject.this_dInicial)
                    THIS.txt_4c_DtIni.Value = THIS.this_oBusinessObject.this_dInicial
                ENDIF
                IF !EMPTY(THIS.this_oBusinessObject.this_dFinal)
                    THIS.txt_4c_DtFin.Value = THIS.this_oBusinessObject.this_dFinal
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BOParaForm")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Contrato FormBase: sem acao neste form OPERACIONAL popup
    * (todos os controles sao somente-leitura, nao variam por modo)
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
    ENDPROC

    *==========================================================================
    * LimparCampos - Contrato FormBase: limpa controles de filtro (uso interno)
    *==========================================================================
    PROCEDURE LimparCampos()
        LOCAL loc_oErro
        TRY
            THIS.txt_4c_Grupo.Value     = ""
            THIS.txt_4c_Conta.Value     = ""
            THIS.txt_4c_ContaDesc.Value = ""
            THIS.txt_4c_DtIni.Value     = {}
            THIS.txt_4c_DtFin.Value     = {}
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro LimparCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Destroy - Libera recursos do BO e chama destrutor da classe base
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.LimparRecursos()
                THIS.this_oBusinessObject = .NULL.
            ENDIF
            THIS.this_oFormPai = .NULL.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao destruir FormSIGPRPPP")
        ENDTRY
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRPPPBO.prg):
*==============================================================================
* SIGPRPPPBO.prg - Business Object: Resultado de Pesquisa de Produtos por Conta
* Form OPERACIONAL sub-form: exibe movimentacoes e itens filtrados pelo pai
* Tabela base: SigMvCab / SigMvItn / SigCdPro
* Aberto por: FormSigPrPpc (passa TprMvCab populado + referencia THIS)
*==============================================================================
DEFINE CLASS SIGPRPPPBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Parametros de filtro recebidos do form pai (FormSigPrPpc)
    * Espelham os campos exibidos nos controles somente-leitura do form
    *--------------------------------------------------------------------------
    this_cGrupo       = ""   && Codigo do grupo contabil (SigCdGcr.codigos)
    this_cConta       = ""   && Codigo da conta/cliente (SigCdCli.IClis)
    this_cContaDesc   = ""   && Descricao da conta (SigCdCli.RClis)
    this_dInicial     = {}   && Data inicial do periodo de consulta
    this_dFinal       = {}   && Data final do periodo de consulta

    *--------------------------------------------------------------------------
    * Estado interno do grid de operacoes
    * Evita recarregar grd_4c_Itens quando o usuario nao muda de linha
    *--------------------------------------------------------------------------
    this_nLinhaAnterior = 0  && Ultima linha ativa em grd_4c_Operacoes

    *--------------------------------------------------------------------------
    * Chave unica para operacoes na tabela SigTempC
    * Gerado por fUniqueIds() em CarregarMovimentos() e limpo ao encerrar
    *--------------------------------------------------------------------------
    this_cChavePesquisa = ""

    *--------------------------------------------------------------------------
    * Init - Operacional de pesquisa. Registra tabela consultada (SigMvItn) para
    * auditoria via BusinessBase.RegistrarAuditoria (usa this_cTabela).
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigMvItn"
        THIS.this_cCampoChave = "cIdQuerys"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave da pesquisa em curso concatenada
    * com Grupo|Conta para rastrear filtros aplicados na auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ALLTRIM(NVL(THIS.this_cGrupo, "")) + "|" + ;
                     ALLTRIM(NVL(THIS.this_cConta, "")) + "|" + ;
                     ALLTRIM(NVL(THIS.this_cChavePesquisa, ""))
        RETURN loc_cChave
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - OPERACIONAL: nao grava em tabela propria (form eh somente-leitura).
    * Executa CarregarMovimentos (pipeline SQL) + registra auditoria "CONSULTA".
    * Chamado por FormSigPrPpc antes de exibir o form para materializar dados.
    * Retorno: .T. se a consulta foi executada e auditada com sucesso.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            *-- Auditoria obrigatoria da consulta (INSERT em LogAuditoria)
            THIS.RegistrarAuditoria("CONSULTA")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao registrar auditoria da consulta: " + ;
                                      loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro em Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - OPERACIONAL: nao ha UPDATE em tabela propria. Regenera a chave
    * de pesquisa (novo cIdQuerys), reexecuta o pipeline e registra REFRESH.
    * Usado quando o usuario altera filtros e redispara a consulta.
    * Retorno: .T. se auditoria foi registrada com sucesso.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            *-- Auditoria obrigatoria do refresh (INSERT em LogAuditoria)
            THIS.RegistrarAuditoria("REFRESH")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao registrar auditoria do refresh: " + ;
                                      loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro em Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia filtros opcionais de um cursor para as props
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                IF TYPE(par_cAliasCursor + ".cgrus") != "U"
                    THIS.this_cGrupo = TratarNulo(cgrus, "C")
                ENDIF
                IF TYPE(par_cAliasCursor + ".IClis") != "U"
                    THIS.this_cConta = TratarNulo(IClis, "C")
                ENDIF
                IF TYPE(par_cAliasCursor + ".RClis") != "U"
                    THIS.this_cContaDesc = TratarNulo(RClis, "C")
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarMovimentos - Pipeline principal de carga:
    *   1. Insere cabecalhos em SIGTEMPC (staging SQL Server)
    *   2. JOIN SIGTEMPC x SigMvItn x SigCdPro -> cursor_4c_MvItn indexado
    *   3. Popula cursor_4c_Operacoes a partir do cursor de origem (VFP)
    *   4. Cria cursor_4c_Itens e preenche com a primeira operacao
    * par_cCursorOrigem: nome do cursor VFP com cabecalhos (estrutura SigMvCab)
    *   deve ter: Emps C(3), Dopes C(20), Numes N(6,0), Datas D/T, Valos N(11,2)
    *--------------------------------------------------------------------------
    FUNCTION CarregarMovimentos(par_cCursorOrigem)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF !USED(par_cCursorOrigem) OR RECCOUNT(par_cCursorOrigem) = 0
                THIS.this_cMensagemErro = "Nenhum registro para carregar."
            ELSE
                THIS.this_cChavePesquisa = SYS(2015)

                *-- Insere cabecalhos em SIGTEMPC (ponte VFP->SQL Server para JOIN)
                *-- dpros: NOT NULL no schema, usar string vazia como placeholder
                SELECT (par_cCursorOrigem)
                GO TOP
                DO WHILE !EOF()
                    SQLEXEC(gnConnHandle, ;
                        "INSERT INTO SIGTEMPC (EmpDopNums, cIdQuerys, cIdChaves, dpros)" + ;
                        " VALUES (" + ;
                        EscaparSQL(Emps + Dopes + STR(Numes, 6)) + ", " + ;
                        EscaparSQL(THIS.this_cChavePesquisa) + ", " + ;
                        EscaparSQL(SYS(2015)) + ", " + ;
                        "'')")
                    SKIP
                ENDDO

                *-- Busca itens com descricao atualizada de SigCdPro
                loc_cSQL = "SELECT b.Emps, b.Dopes, b.Numes, b.Cpros, " + ;
                           "ISNULL(p.dpros, b.Dpros) AS Dpros, b.Qtds " + ;
                           "FROM SIGTEMPC a " + ;
                           "INNER JOIN SigMvItn b ON a.empdopnums = b.empdopnums " + ;
                           "LEFT JOIN SigCdPro p ON b.cpros = p.cpros " + ;
                           "WHERE a.cidquerys = " + EscaparSQL(THIS.this_cChavePesquisa) + ;
                           " ORDER BY b.Emps, b.Dopes, b.Numes, b.Cpros"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvItnRaw")
                THIS.LimparSIGTEMPC(THIS.this_cChavePesquisa)

                IF loc_nResult >= 0
                    *-- Cria cursor indexado cursor_4c_MvItn para lookup por operacao
                    IF USED("cursor_4c_MvItn")
                        USE IN cursor_4c_MvItn
                    ENDIF
                    SET NULL ON
                    CREATE CURSOR cursor_4c_MvItn ;
                        (Emps C(3) NULL, Dopes C(20) NULL, Numes N(6,0) NULL, ;
                         Cpros C(14) NULL, Dpros C(65) NULL, Qtds N(9,3) NULL)
                    SET NULL OFF

                    IF USED("cursor_4c_MvItnRaw") AND RECCOUNT("cursor_4c_MvItnRaw") > 0
                        SELECT cursor_4c_MvItn
                        APPEND FROM DBF("cursor_4c_MvItnRaw")
                    ENDIF
                    IF USED("cursor_4c_MvItnRaw")
                        USE IN cursor_4c_MvItnRaw
                    ENDIF

                    SELECT cursor_4c_MvItn
                    INDEX ON Emps + Dopes + STR(Numes, 6) TAG EmpDopNum

                    *-- Popula cursor_4c_Operacoes diretamente do cursor de origem (VFP)
                    IF USED("cursor_4c_Operacoes")
                        USE IN cursor_4c_Operacoes
                    ENDIF
                    SELECT Emps, Dopes, Numes, Datas, Valos ;
                        FROM (par_cCursorOrigem) ;
                        ORDER BY Emps, Dopes, Numes ;
                        INTO CURSOR cursor_4c_Operacoes READWRITE

                    *-- Cria cursor_4c_Itens placeholder vazio
                    IF USED("cursor_4c_Itens")
                        USE IN cursor_4c_Itens
                    ENDIF
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Itens ;
                        (Emps C(3) NULL, Dopes C(20) NULL, Numes N(6,0) NULL, ;
                         Cpros C(14) NULL, Dpros C(65) NULL, Qtds N(9,3) NULL)
                    SET NULL OFF

                    *-- Preenche itens da primeira operacao imediatamente
                    IF RECCOUNT("cursor_4c_Operacoes") > 0
                        SELECT cursor_4c_Operacoes
                        GO TOP
                        THIS.CarregarItensPorOperacao(cursor_4c_Operacoes.Emps, ;
                                                      cursor_4c_Operacoes.Dopes, ;
                                                      cursor_4c_Operacoes.Numes)
                    ENDIF

                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Falha ao consultar itens de movimenta" + ;
                                              CHR(231) + CHR(245) + "es."
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.LimparSIGTEMPC(THIS.this_cChavePesquisa)
            MsgErro(loc_oErro.Message, "Erro ao carregar movimenta" + CHR(231) + CHR(245) + "es")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarItensPorOperacao - Preenche cursor_4c_Itens com os itens da
    * operacao selecionada no grid superior (AfterRowColChange do form)
    * Faz SEEK em cursor_4c_MvItn (indexado por Emps+Dopes+STR(Numes,6))
    *--------------------------------------------------------------------------
    FUNCTION CarregarItensPorOperacao(par_cEmps, par_cDopes, par_nNumes)
        LOCAL loc_lSucesso, loc_cChaveSeek, loc_oErro
        LOCAL loc_cEmp, loc_cDop, loc_nNum, loc_cCpro, loc_cDpro, loc_nQtd
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_MvItn") AND USED("cursor_4c_Itens")
                SELECT cursor_4c_Itens
                ZAP

                loc_cChaveSeek = par_cEmps + par_cDopes + STR(par_nNumes, 6)

                SELECT cursor_4c_MvItn
                SET ORDER TO EmpDopNum
                SET NEAR ON
                SEEK loc_cChaveSeek
                SET NEAR OFF

                DO WHILE !EOF("cursor_4c_MvItn") AND ;
                         cursor_4c_MvItn.Emps + cursor_4c_MvItn.Dopes + ;
                         STR(cursor_4c_MvItn.Numes, 6) = loc_cChaveSeek

                    loc_cEmp  = cursor_4c_MvItn.Emps
                    loc_cDop  = cursor_4c_MvItn.Dopes
                    loc_nNum  = cursor_4c_MvItn.Numes
                    loc_cCpro = cursor_4c_MvItn.Cpros
                    loc_cDpro = cursor_4c_MvItn.Dpros
                    loc_nQtd  = cursor_4c_MvItn.Qtds

                    INSERT INTO cursor_4c_Itens (Emps, Dopes, Numes, Cpros, Dpros, Qtds) ;
                        VALUES (loc_cEmp, loc_cDop, loc_nNum, loc_cCpro, loc_cDpro, loc_nQtd)

                    SELECT cursor_4c_MvItn
                    SKIP
                ENDDO

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar itens")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * LimparSIGTEMPC - Remove registros temporarios da sessao em SIGTEMPC
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparSIGTEMPC(par_cChave)
        LOCAL loc_oErro
        TRY
            IF !EMPTY(par_cChave)
                SQLEXEC(gnConnHandle, "DELETE FROM SIGTEMPC WHERE cidquerys = " + ;
                        EscaparSQL(par_cChave))
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao limpar SIGTEMPC")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparRecursos - Fecha cursores temporarios ao encerrar o form
    *--------------------------------------------------------------------------
    PROCEDURE LimparRecursos()
        LOCAL loc_oErro
        TRY
            IF USED("cursor_4c_Operacoes")
                USE IN cursor_4c_Operacoes
            ENDIF
            IF USED("cursor_4c_Itens")
                USE IN cursor_4c_Itens
            ENDIF
            IF USED("cursor_4c_MvItn")
                USE IN cursor_4c_MvItn
            ENDIF
            IF USED("cursor_4c_MvItnRaw")
                USE IN cursor_4c_MvItnRaw
            ENDIF
            IF !EMPTY(THIS.this_cChavePesquisa)
                THIS.LimparSIGTEMPC(THIS.this_cChavePesquisa)
                THIS.this_cChavePesquisa = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao liberar recursos")
        ENDTRY
    ENDPROC

ENDDEFINE

