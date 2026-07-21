# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05c_validarCompilacao
- Tentativa: 1/10
- Mensagem: C:\4c\projeto\app\forms\operacionais\FormSigPrHpr.prg: SEEK(DTOS(loc_dData), "cursor_4c_Historico", "datas") | Error in line 901: Function name is missing ). | 

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrHpr.prg):
*================================================================================
* FormSigPrHpr.prg - Hist" + CHR(243) + "rico de Produtos
* Form: OPERACIONAL (leitura + auditoria de SigMvHst)
* Gerado: 17/07/2026
*================================================================================

DEFINE CLASS FormSigPrHpr AS FormBase

    TitleBar    = 0
    ShowWindow = 1
    WindowType = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    KeyPreview  = .T.
    AutoCenter  = .T.
    Width       = 1000
    Height      = 600
    BorderStyle = 2
    DataSession = 2

    this_oBusinessObject = .NULL.
    this_oParentForm     = .NULL.
    this_dDataIni        = {}
    this_dDataFim        = {}
    this_cCdGrupo        = ""
    this_cCdConta        = ""
    this_cCdProduto      = ""
    this_cDsProduto      = ""
    this_lTemAuditoria   = .F.
    this_lEhPeso         = .F.

    *--------------------------------------------------------------------------
    PROCEDURE Init
    *--------------------------------------------------------------------------
    LPARAMETERS par_oParentForm, par_dDataIni, par_dDataFim, par_cCdGrupo, par_cCdConta, par_cCdProduto, par_cDsProduto
        THIS.Caption = "Hist" + CHR(243) + "rico de Produtos"
        IF PCOUNT() >= 1 AND VARTYPE(par_oParentForm) == "O"
            THIS.this_oParentForm = par_oParentForm
        ENDIF
        IF PCOUNT() >= 2 AND VARTYPE(par_dDataIni) == "D"
            THIS.this_dDataIni = par_dDataIni
        ENDIF
        IF PCOUNT() >= 3 AND VARTYPE(par_dDataFim) == "D"
            THIS.this_dDataFim = par_dDataFim
        ENDIF
        IF PCOUNT() >= 4 AND VARTYPE(par_cCdGrupo) == "C"
            THIS.this_cCdGrupo = par_cCdGrupo
        ENDIF
        IF PCOUNT() >= 5 AND VARTYPE(par_cCdConta) == "C"
            THIS.this_cCdConta = par_cCdConta
        ENDIF
        IF PCOUNT() >= 6 AND VARTYPE(par_cCdProduto) == "C"
            THIS.this_cCdProduto = par_cCdProduto
        ENDIF
        IF PCOUNT() >= 7 AND VARTYPE(par_cDsProduto) == "C"
            THIS.this_cDsProduto = par_cDsProduto
        ENDIF
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrHprBO")
            THIS.this_oBusinessObject.this_dDataIni   = THIS.this_dDataIni
            THIS.this_oBusinessObject.this_dDataFim   = THIS.this_dDataFim
            THIS.this_oBusinessObject.this_cCdGrupo   = THIS.this_cCdGrupo
            THIS.this_oBusinessObject.this_cCdConta   = THIS.this_cCdConta
            THIS.this_oBusinessObject.this_cCdProduto = THIS.this_cCdProduto
            THIS.this_oBusinessObject.this_cDsProduto = THIS.this_cDsProduto

            THIS.ConfigurarPageFrame()
            THIS.ConfigurarCabecalho()
            THIS.ConfigurarContainersVisuais()
            THIS.ConfigurarBotoesTopo()
            THIS.ConfigurarCamposFiltroData()
            THIS.ConfigurarPaginaLista()
            THIS.ConfigurarPaginaDados()
            THIS.TornarControlesVisiveis(THIS)
            THIS.txt_4c_Data.Visible        = .F.
            THIS.lbl_4c_DataLabel.Visible   = .F.
            THIS.chk_4c_ChkAuditado.Visible = .F.
            THIS.ConfigurarEventos()

            IF !(VARTYPE(gb_4c_ValidandoUI) == "L" AND gb_4c_ValidandoUI)
                THIS.CarregarDados()
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inicializar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Layout OPERACIONAL flat: sem PageFrame.
    * Controles sao filhos diretos do form (grd_4c_Historico, grd_4c_Subniveis,
    * containers e textboxes). Metodo mantido para simetria com o pipeline.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame
        THIS.BackColor = RGB(236, 233, 216)
        IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho
    *--------------------------------------------------------------------------
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top       = 0
            .Left      = 0
            .Width     = THIS.Width
            .Height    = 80
            .BackColor = RGB(100, 100, 100)
            .BackStyle = 1
            .Visible   = .T.
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .AutoSize  = .F.
                .Caption   = "Hist" + CHR(243) + "rico de Produtos"
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .WordWrap  = .T.
                .Alignment = 0
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 17
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .AutoSize  = .F.
                .Caption   = "Hist" + CHR(243) + "rico de Produtos"
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .WordWrap  = .T.
                .Alignment = 0
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainersVisuais
    *--------------------------------------------------------------------------
        THIS.AddObject("cnt_4c_Origem", "Container")
        WITH THIS.cnt_4c_Origem
            .Top       = 426
            .Left      = 7
            .Width     = 478
            .Height    = 74
            .BackColor = RGB(255, 255, 255)
            .BackStyle = 1
            .Visible   = .T.
        ENDWITH
        THIS.AddObject("cnt_4c_Destino", "Container")
        WITH THIS.cnt_4c_Destino
            .Top       = 426
            .Left      = 504
            .Width     = 478
            .Height    = 74
            .BackColor = RGB(255, 255, 255)
            .BackStyle = 1
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesTopo
    *--------------------------------------------------------------------------
        THIS.AddObject("chk_4c_ChkAuditado", "CheckBox")
        WITH THIS.chk_4c_ChkAuditado
            .Top             = 3
            .Left            = 700
            .Width           = 75
            .Height          = 75
            .Caption         = "Auditado"
            .Alignment       = 0
            .Style           = 1
            .Picture         = gc_4c_CaminhoIcones + "geral_chaves_60.jpg"
            .PicturePosition = 13
            .WordWrap        = .T.
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .BackStyle       = 0
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH
        THIS.AddObject("cmd_4c_BtnDocumento", "CommandButton")
        WITH THIS.cmd_4c_BtnDocumento
            .Top             = 3
            .Left            = 775
            .Width           = 75
            .Height          = 75
            .Caption         = "Movimento"
            .Picture         = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
            .PicturePosition = 13
            .WordWrap        = .T.
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        THIS.AddObject("cmd_4c_Procurar", "CommandButton")
        WITH THIS.cmd_4c_Procurar
            .Top             = 3
            .Left            = 850
            .Width           = 75
            .Height          = 75
            .Caption         = "Procurar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .WordWrap        = .T.
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        THIS.AddObject("cnt_4c_Saida", "Container")
        WITH THIS.cnt_4c_Saida
            .Top       = 0
            .Left      = 917
            .Width     = 90
            .Height    = 85
            .BackStyle = 0
            .Visible   = .T.
            .AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH .cmd_4c_Encerrar
                .Top     = 5
                .Left    = 917
                .Width   = 90
                .Height  = 75
                .Caption = "Encerrar"
                .Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Visible = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposFiltroData
    *--------------------------------------------------------------------------
        THIS.AddObject("lbl_4c_DataLabel", "Label")
        WITH THIS.lbl_4c_DataLabel
            .Top      = 102
            .Left     = 441
            .AutoSize = .T.
            .Caption  = "Data:"
            .FontBold = .T.
            .Visible  = .F.
        ENDWITH
        THIS.AddObject("txt_4c_Data", "TextBox")
        WITH THIS.txt_4c_Data
            .Top       = 98
            .Left      = 478
            .Width     = 80
            .Height    = 23
            .Alignment = 3
            .MaxLength = 10
            .Visible   = .F.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarLabelProduto
    *--------------------------------------------------------------------------
        THIS.AddObject("lbl_4c_LabelProduto", "Label")
        WITH THIS.lbl_4c_LabelProduto
            .Top       = 130
            .Left      = 15
            .AutoSize  = .T.
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Caption   = ""
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrdHistorico
    *--------------------------------------------------------------------------
        THIS.AddObject("grd_4c_Historico", "GridBase")
        WITH THIS.grd_4c_Historico
            .Top          = 148
            .Left         = 4
            .Width        = 730
            .Height       = 238
            .ColumnCount  = 9
            .RecordSource = "cursor_4c_Historico"
            .ReadOnly     = .T.
            .DeleteMark   = .F.
            .RecordMark   = .F.
            .FontName     = "Courier New"
            .FontSize     = 9
            .Visible      = .T.
            WITH .Column1
                .Width            = 86
                .ControlSource    = "cursor_4c_Historico.datas"
                .DynamicBackColor = "IIF(!EMPTY(cursor_4c_Historico.auditors),RGB(220,255,220),RGB(255,255,255))"
                .Header1.Caption  = "Data"
            ENDWITH
            WITH .Column2
                .Width            = 57
                .ControlSource    = "cursor_4c_Historico.numes"
                .DynamicBackColor = "IIF(!EMPTY(cursor_4c_Historico.auditors),RGB(220,255,220),RGB(255,255,255))"
                .Header1.Caption  = "C" + CHR(243) + "digo"
            ENDWITH
            WITH .Column3
                .Width            = 161
                .ControlSource    = "cursor_4c_Historico.dopes"
                .DynamicBackColor = "IIF(!EMPTY(cursor_4c_Historico.auditors),RGB(220,255,220),RGB(255,255,255))"
                .Header1.Caption  = "Opera" + CHR(231) + CHR(227) + "o"
            ENDWITH
            WITH .Column4
                .Width            = 31
                .ControlSource    = "cursor_4c_Historico.cunis"
                .DynamicBackColor = "IIF(!EMPTY(cursor_4c_Historico.auditors),RGB(220,255,220),RGB(255,255,255))"
                .Header1.Caption  = "Un."
            ENDWITH
            WITH .Column5
                .Width            = 78
                .ControlSource    = "cursor_4c_Historico.qtds"
                .Format           = "999,999.999"
                .InputMask        = "999,999.999"
                .DynamicBackColor = "IIF(!EMPTY(cursor_4c_Historico.auditors),RGB(220,255,220),RGB(255,255,255))"
                .Header1.Caption  = "Quantidade"
            ENDWITH
            WITH .Column6
                .Width            = 24
                .ControlSource    = "cursor_4c_Historico.opers"
                .DynamicBackColor = "IIF(!EMPTY(cursor_4c_Historico.auditors),RGB(220,255,220),RGB(255,255,255))"
                .Header1.Caption  = "O"
            ENDWITH
            WITH .Column7
                .Width            = 93
                .ControlSource    = "cursor_4c_Historico.sqtds"
                .Format           = "9,999,999.999"
                .InputMask        = "9,999,999.999"
                .DynamicBackColor = "IIF(!EMPTY(cursor_4c_Historico.auditors),RGB(220,255,220),RGB(255,255,255))"
                .Header1.Caption  = "Saldo  Q"
            ENDWITH
            WITH .Column8
                .Width            = 80
                .ControlSource    = "cursor_4c_Historico.pesos"
                .DynamicBackColor = "IIF(!EMPTY(cursor_4c_Historico.auditors),RGB(220,255,220),RGB(255,255,255))"
                .Header1.Caption  = "Peso"
                .Visible          = .F.
            ENDWITH
            WITH .Column9
                .Width            = 80
                .ControlSource    = "cursor_4c_Historico.spesos"
                .DynamicBackColor = "IIF(!EMPTY(cursor_4c_Historico.auditors),RGB(220,255,220),RGB(255,255,255))"
                .Header1.Caption  = "Saldo P"
                .Visible          = .F.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrdSubniveis
    *--------------------------------------------------------------------------
        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .Top      = 130
            .Left     = 747
            .AutoSize = .T.
            .Caption  = "Movimenta" + CHR(231) + CHR(245) + "es com subn" + CHR(237) + "vel"
            .FontBold = .T.
            .Visible  = .T.
        ENDWITH
        THIS.AddObject("grd_4c_Subniveis", "GridBase")
        WITH THIS.grd_4c_Subniveis
            .Top          = 148
            .Left         = 738
            .Width        = 261
            .Height       = 238
            .ColumnCount  = 3
            .RecordSource = "cursor_4c_Subniveis"
            .ReadOnly     = .T.
            .DeleteMark   = .F.
            .RecordMark   = .F.
            .FontName     = "Courier New"
            .FontSize     = 9
            .Visible      = .T.
            WITH .Column1
                .Width           = 31
                .ControlSource   = "cursor_4c_Subniveis.emps"
                .Header1.Caption = "Emp"
            ENDWITH
            WITH .Column2
                .Width           = 156
                .ControlSource   = "cursor_4c_Subniveis.dopes"
                .Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
            ENDWITH
            WITH .Column3
                .Width           = 51
                .ControlSource   = "cursor_4c_Subniveis.numes"
                .Header1.Caption = "C" + CHR(243) + "digo"
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarAreaInfo
    *--------------------------------------------------------------------------
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Top      = 396
            .Left     = 27
            .AutoSize = .T.
            .Caption  = "Documento:"
            .FontBold = .T.
            .Visible  = .T.
        ENDWITH
        THIS.AddObject("txt_4c_Nota", "TextBox")
        WITH THIS.txt_4c_Nota
            .Top           = 392
            .Left          = 102
            .Width         = 80
            .Height        = 23
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top      = 396
            .Left     = 197
            .AutoSize = .T.
            .Caption  = "Usu" + CHR(225) + "rio:"
            .FontBold = .T.
            .Visible  = .T.
        ENDWITH
        THIS.AddObject("txt_4c_Usuario", "TextBox")
        WITH THIS.txt_4c_Usuario
            .Top           = 392
            .Left          = 250
            .Width         = 96
            .Height        = 23
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        THIS.AddObject("lbl_4c_Auditoria", "Label")
        WITH THIS.lbl_4c_Auditoria
            .Top      = 396
            .Left     = 403
            .AutoSize = .T.
            .Caption  = "Auditoria:"
            .FontBold = .T.
            .Visible  = .T.
        ENDWITH
        THIS.AddObject("txt_4c_DtAudits", "TextBox")
        WITH THIS.txt_4c_DtAudits
            .Top           = 392
            .Left          = 465
            .Width         = 80
            .Height        = 23
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        THIS.AddObject("lbl_4c_Auditor", "Label")
        WITH THIS.lbl_4c_Auditor
            .Top      = 396
            .Left     = 556
            .AutoSize = .T.
            .Caption  = "Auditor:"
            .FontBold = .T.
            .Visible  = .T.
        ENDWITH
        THIS.AddObject("txt_4c_Auditors", "TextBox")
        WITH THIS.txt_4c_Auditors
            .Top           = 392
            .Left          = 608
            .Width         = 96
            .Height        = 23
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarLabelsAreaContas
    *--------------------------------------------------------------------------
        THIS.AddObject("lbl_4c_Label7", "Label")
        WITH THIS.lbl_4c_Label7
            .Top      = 428
            .Left     = 17
            .AutoSize = .T.
            .Caption  = "Origem"
            .FontBold = .T.
            .Visible  = .T.
        ENDWITH
        THIS.AddObject("lin_4c_Line1", "Line")
        WITH THIS.lin_4c_Line1
            .Top         = 442
            .Left        = 18
            .Width       = 340
            .Height      = 0
            .BorderWidth = 2
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH
        THIS.AddObject("lbl_4c_Label9", "Label")
        WITH THIS.lbl_4c_Label9
            .Top      = 451
            .Left     = 62
            .AutoSize = .T.
            .Caption  = "Grupo:"
            .FontBold = .T.
            .Visible  = .T.
        ENDWITH
        THIS.AddObject("lbl_4c_Label10", "Label")
        WITH THIS.lbl_4c_Label10
            .Top      = 475
            .Left     = 63
            .AutoSize = .T.
            .Caption  = "Conta:"
            .FontBold = .T.
            .Visible  = .T.
        ENDWITH
        THIS.AddObject("lbl_4c_Label8", "Label")
        WITH THIS.lbl_4c_Label8
            .Top      = 428
            .Left     = 513
            .AutoSize = .T.
            .Caption  = "Destino"
            .FontBold = .T.
            .Visible  = .T.
        ENDWITH
        THIS.AddObject("lin_4c_Line2", "Line")
        WITH THIS.lin_4c_Line2
            .Top         = 442
            .Left        = 515
            .Width       = 340
            .Height      = 0
            .BorderWidth = 2
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH
        THIS.AddObject("lbl_4c_Label11", "Label")
        WITH THIS.lbl_4c_Label11
            .Top      = 451
            .Left     = 557
            .AutoSize = .T.
            .Caption  = "Grupo:"
            .FontBold = .T.
            .Visible  = .T.
        ENDWITH
        THIS.AddObject("lbl_4c_Label12", "Label")
        WITH THIS.lbl_4c_Label12
            .Top      = 475
            .Left     = 558
            .AutoSize = .T.
            .Caption  = "Conta:"
            .FontBold = .T.
            .Visible  = .T.
        ENDWITH
        THIS.AddObject("lbl_4c_Label5", "Label")
        WITH THIS.lbl_4c_Label5
            .Top      = 517
            .Left     = 29
            .AutoSize = .T.
            .Caption  = "Observa" + CHR(231) + CHR(227) + "o:"
            .FontBold = .T.
            .Visible  = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposAreaContas
    *--------------------------------------------------------------------------
        THIS.AddObject("txt_4c_GruOri", "TextBox")
        WITH THIS.txt_4c_GruOri
            .Top           = 447
            .Left          = 106
            .Width         = 80
            .Height        = 23
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        THIS.AddObject("txt_4c_DesGruOri", "TextBox")
        WITH THIS.txt_4c_DesGruOri
            .Top           = 447
            .Left          = 187
            .Width         = 290
            .Height        = 23
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        THIS.AddObject("txt_4c_ConOri", "TextBox")
        WITH THIS.txt_4c_ConOri
            .Top           = 471
            .Left          = 106
            .Width         = 80
            .Height        = 23
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        THIS.AddObject("txt_4c_DesConOri", "TextBox")
        WITH THIS.txt_4c_DesConOri
            .Top           = 471
            .Left          = 187
            .Width         = 290
            .Height        = 23
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        THIS.AddObject("txt_4c_GruDes", "TextBox")
        WITH THIS.txt_4c_GruDes
            .Top           = 447
            .Left          = 601
            .Width         = 80
            .Height        = 23
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        THIS.AddObject("txt_4c_DesGruDes", "TextBox")
        WITH THIS.txt_4c_DesGruDes
            .Top           = 447
            .Left          = 682
            .Width         = 290
            .Height        = 23
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        THIS.AddObject("txt_4c_ConDes", "TextBox")
        WITH THIS.txt_4c_ConDes
            .Top           = 471
            .Left          = 601
            .Width         = 80
            .Height        = 23
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        THIS.AddObject("txt_4c_DesConDes", "TextBox")
        WITH THIS.txt_4c_DesConDes
            .Top           = 471
            .Left          = 682
            .Width         = 290
            .Height        = 23
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarAreaObs
    *--------------------------------------------------------------------------
        THIS.AddObject("obj_4c_Obs", "EditBox")
        WITH THIS.obj_4c_Obs
            .Top           = 514
            .Left          = 106
            .Width         = 875
            .Height        = 55
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista
    *-- Configura a area principal: label produto + grid historico + grid subniveis
    *--------------------------------------------------------------------------
        THIS.ConfigurarLabelProduto()
        THIS.ConfigurarGrdHistorico()
        THIS.ConfigurarGrdSubniveis()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados
    *-- Configura secao inferior (equivalente a Page2 em CRUD):
    *-- area de informacoes, labels de contas, campos de contas e observacao
    *--------------------------------------------------------------------------
        THIS.ConfigurarAreaInfo()
        THIS.ConfigurarLabelsAreaContas()
        THIS.ConfigurarCamposAreaContas()
        THIS.ConfigurarAreaObs()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina
    *-- Form OPERACIONAL flat sem PageFrame: metodo mantido por simetria com pipeline
    *--------------------------------------------------------------------------
    LPARAMETERS par_nPagina
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis
    *--------------------------------------------------------------------------
    LPARAMETERS par_oContainer
        LOCAL loc_nI, loc_oControl
        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)
            IF INLIST(loc_oControl.BaseClass, "Container", "PageFrame", "Page")
                THIS.TornarControlesVisiveis(loc_oControl)
            ENDIF
            IF INLIST(loc_oControl.BaseClass, "Grid", "Column", "Header", "Line")
                LOOP
            ENDIF
            loc_oControl.Visible = .T.
        NEXT
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEventos
    *--------------------------------------------------------------------------
        BINDEVENT(THIS.grd_4c_Historico,              "AfterRowColChange", THIS, "GrdHistoricoAfterRowColChange")
        BINDEVENT(THIS.chk_4c_ChkAuditado,            "Click",             THIS, "ChkAuditadoClick")
        BINDEVENT(THIS.cmd_4c_Procurar,               "Click",             THIS, "CmdProcurarClick")
        BINDEVENT(THIS.cmd_4c_BtnDocumento,           "Click",             THIS, "CmdMovimentoClick")
        BINDEVENT(THIS.txt_4c_Data,                   "KeyPress",          THIS, "TxtDataKeyPress")
        BINDEVENT(THIS.txt_4c_Data,                   "KeyPress",         THIS, "TxtDataLostFocus")
        BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar, "Click",             THIS, "CmdEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDados
    *-- CarregarHistorico ja chama CarregarDadosProduto internamente
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_oBusinessObject.CarregarHistorico()
            THIS.this_lEhPeso = THIS.this_oBusinessObject.this_lEhPeso
            THIS.grd_4c_Historico.Column8.Visible = THIS.this_lEhPeso
            THIS.grd_4c_Historico.Column9.Visible = THIS.this_lEhPeso
            THIS.lbl_4c_LabelProduto.Caption = THIS.this_cDsProduto
            IF USED("cursor_4c_Historico") AND RECCOUNT("cursor_4c_Historico") > 0
                SELECT cursor_4c_Historico
                GO BOTTOM
                THIS.AtualizarCamposLinha()
            ENDIF
            THIS.grd_4c_Historico.Refresh()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar dados")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE AtualizarCamposLinha
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF !USED("cursor_4c_Historico") OR RECCOUNT("cursor_4c_Historico") = 0
            RETURN
        ENDIF
        IF BOF("cursor_4c_Historico") OR EOF("cursor_4c_Historico")
            RETURN
        ENDIF
        TRY
            THIS.this_oBusinessObject.CarregarDadosLinhaSelecionada()
            THIS.this_oBusinessObject.CarregarDocumento()
            THIS.this_oBusinessObject.CarregarDescricoesContabil()
            THIS.this_oBusinessObject.CarregarSubniveis()

            THIS.txt_4c_Auditors.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cAuditors)
            IF EMPTY(THIS.this_oBusinessObject.this_dDtAudits)
                THIS.txt_4c_DtAudits.Value = ""
            ELSE
                THIS.txt_4c_DtAudits.Value = DTOC(THIS.this_oBusinessObject.this_dDtAudits)
            ENDIF
            THIS.txt_4c_Usuario.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cUsuars)
            THIS.txt_4c_Nota.Value      = ALLTRIM(THIS.this_oBusinessObject.this_cNotas)
            THIS.txt_4c_GruOri.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cGrupoOri)
            THIS.txt_4c_DesGruOri.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDesGrupoOri)
            THIS.txt_4c_ConOri.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cContaOri)
            THIS.txt_4c_DesConOri.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDesContaOri)
            THIS.txt_4c_GruDes.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cGrupoDes)
            THIS.txt_4c_DesGruDes.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDesGrupoDes)
            THIS.txt_4c_ConDes.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cContaDes)
            THIS.txt_4c_DesConDes.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDesContaDes)
            THIS.obj_4c_Obs.Value       = ALLTRIM(THIS.this_oBusinessObject.this_cObs)

            THIS.this_lTemAuditoria = !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cAuditors))
            THIS.chk_4c_ChkAuditado.Value = IIF(THIS.this_lTemAuditoria, 1, 0)
            IF THIS.this_oBusinessObject.VerificarPermissaoAuditoria()
                THIS.chk_4c_ChkAuditado.Visible = .T.
            ELSE
                THIS.chk_4c_ChkAuditado.Visible = .F.
            ENDIF

            THIS.grd_4c_Subniveis.Refresh()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao atualizar campos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE GrdHistoricoAfterRowColChange
    *--------------------------------------------------------------------------
    LPARAMETERS par_nColIndex
        THIS.AtualizarCamposLinha()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ChkAuditadoClick
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_lBOResult
        loc_lSucesso  = .F.
        loc_lBOResult = .F.
        TRY
            IF THIS.chk_4c_ChkAuditado.Value = 1
                loc_lBOResult = THIS.this_oBusinessObject.AuditarRegistro()
            ELSE
                loc_lBOResult = THIS.this_oBusinessObject.DesauditarRegistro()
            ENDIF
            IF loc_lBOResult
                THIS.txt_4c_Auditors.Value = ALLTRIM(THIS.this_oBusinessObject.this_cAuditors)
                IF EMPTY(THIS.this_oBusinessObject.this_dDtAudits)
                    THIS.txt_4c_DtAudits.Value = ""
                ELSE
                    THIS.txt_4c_DtAudits.Value = DTOC(THIS.this_oBusinessObject.this_dDtAudits)
                ENDIF
                THIS.this_lTemAuditoria = !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cAuditors))
                THIS.chk_4c_ChkAuditado.Value = IIF(THIS.this_lTemAuditoria, 1, 0)
                THIS.grd_4c_Historico.Refresh()
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao auditar registro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CmdProcurarClick
    *--------------------------------------------------------------------------
        THIS.lbl_4c_DataLabel.Visible = .T.
        THIS.txt_4c_Data.Visible      = .T.
        THIS.txt_4c_Data.Value        = DATE()
        THIS.txt_4c_Data.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE TxtDataKeyPress
    *--------------------------------------------------------------------------
    LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_dData
        IF !INLIST(par_nKeyCode, 13, 9)
            RETURN
        ENDIF
        loc_dData = THIS.txt_4c_Data.Value
        THIS.txt_4c_Data.Visible      = .F.
        THIS.lbl_4c_DataLabel.Visible = .F.
        IF EMPTY(loc_dData) OR VARTYPE(loc_dData) != "D"
            RETURN
        ENDIF
        IF USED("cursor_4c_Historico")
            SET NEAR ON
            SEEK(DTOS(loc_dData), "cursor_4c_Historico", "datas")
            SET NEAR OFF
            THIS.grd_4c_Historico.Refresh()
            THIS.AtualizarCamposLinha()
        ENDIF
        THIS.grd_4c_Historico.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE TxtDataLostFocus
    *--------------------------------------------------------------------------
        THIS.txt_4c_Data.Visible      = .F.
        THIS.lbl_4c_DataLabel.Visible = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CmdMovimentoClick
    *--------------------------------------------------------------------------
        LOCAL loc_cTipoDoc, loc_lSucesso, loc_oForm
        loc_lSucesso = .F.
        loc_oForm    = .NULL.
        TRY
            IF !USED("cursor_4c_Historico") OR RECCOUNT("cursor_4c_Historico") = 0
                MsgAviso("Nenhum registro selecionado.")
            ELSE
                THIS.this_oBusinessObject.CarregarDadosLinhaSelecionada()
                loc_cTipoDoc = THIS.this_oBusinessObject.VerificarExistenciaDocumento()
                DO CASE
                CASE loc_cTipoDoc == "MOVCAB"
                    loc_oForm = CREATEOBJECT("FormSigMvExp", THIS)
                    IF VARTYPE(loc_oForm) == "O"
                        THIS.Enabled = .F.
                        loc_oForm.Show()
                    ENDIF
                CASE loc_cTipoDoc == "NEC"
                    loc_oForm = CREATEOBJECT("FormSigMvPdt", THIS)
                    IF VARTYPE(loc_oForm) == "O"
                        THIS.Enabled = .F.
                        loc_oForm.Show()
                    ENDIF
                OTHERWISE
                    MsgAviso("Documento n" + CHR(227) + "o encontrado.")
                ENDCASE
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir documento")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CmdEncerrarClick
    *--------------------------------------------------------------------------
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Alias CRUD para OPERACIONAL de consulta:
    *   "Incluir" nao se aplica ao Historico (readonly). Delega para
    *   CarregarDados() que recarrega o historico com o filtro atual
    *   (data/grupo/conta/produto) e reseleciona o ultimo registro.
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.CarregarDados()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao recarregar hist" + CHR(243) + "rico")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Alias CRUD para OPERACIONAL de consulta:
    *   "Alterar" no contexto de historico = marcar/desmarcar auditoria
    *   do registro selecionado. Valida permissao via VerificarPermissaoAuditoria
    *   e delega para ChkAuditadoClick que executa AuditarRegistro ou
    *   DesauditarRegistro no BO.
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !USED("cursor_4c_Historico") OR RECCOUNT("cursor_4c_Historico") = 0
                MsgAviso("Nenhum registro selecionado no hist" + CHR(243) + "rico.")
            ELSE
                IF THIS.this_oBusinessObject.VerificarPermissaoAuditoria()
                    THIS.chk_4c_ChkAuditado.Value = IIF(THIS.chk_4c_ChkAuditado.Value = 1, 0, 1)
                    THIS.ChkAuditadoClick()
                ELSE
                    MsgAviso("Usu" + CHR(225) + "rio sem permiss" + CHR(227) + "o de auditoria.")
                ENDIF
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao alterar auditoria")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Alias CRUD para OPERACIONAL de consulta:
    *   "Visualizar" abre o documento (SigMvCab ou SigCdNec) associado
    *   a linha selecionada no grid de historico. Delega para
    *   CmdMovimentoClick que faz VerificarExistenciaDocumento no BO
    *   e instancia FormSigMvExp (movimento) ou FormSigMvPdt (necessidade).
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        THIS.CmdMovimentoClick()
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Alias CRUD para OPERACIONAL de consulta:
    *   Historico de movimentacao eh readonly - registros nao podem ser
    *   excluidos individualmente. Interpretacao canonica: "Excluir" =
    *   remover marca de auditoria (unico atributo mutavel do registro).
    *   Solicita MsgConfirma antes e delega para ChkAuditadoClick com
    *   toggle para desmarcar.
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_lSucesso, loc_cTitulo
        loc_lSucesso = .F.
        loc_cTitulo  = "Remover Auditoria"
        TRY
            IF !USED("cursor_4c_Historico") OR RECCOUNT("cursor_4c_Historico") = 0
                MsgAviso("Nenhum registro selecionado no hist" + CHR(243) + "rico.")
            ELSE
                IF !THIS.this_oBusinessObject.VerificarPermissaoAuditoria()
                    MsgAviso("Usu" + CHR(225) + "rio sem permiss" + CHR(227) + "o de auditoria.")
                ELSE
                    IF THIS.chk_4c_ChkAuditado.Value = 1
                        IF MsgConfirma("Confirma remover a marca" + CHR(231) + CHR(227) + "o de auditoria deste registro?", loc_cTitulo)
                            THIS.chk_4c_ChkAuditado.Value = 0
                            THIS.ChkAuditadoClick()
                        ENDIF
                    ELSE
                        MsgAviso("O registro selecionado n" + CHR(227) + "o est" + CHR(225) + " marcado como auditado.")
                    ENDIF
                ENDIF
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao remover auditoria")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Destroy
    *--------------------------------------------------------------------------
        IF VARTYPE(THIS.this_oParentForm) == "O"
            THIS.this_oParentForm.Enabled = .T.
        ENDIF
        THIS.this_oBusinessObject = .NULL.
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Alias FormBase: delega para CarregarDados
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista
        THIS.CarregarDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Exibe campo de filtro por data (igual ao botao Procurar)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick
        THIS.CmdProcurarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Encerra o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick
        THIS.CmdEncerrarClick()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Alias CRUD para OPERACIONAL de auditoria:
    *   "Salvar" = confirmar a marcacao/desmarcacao de auditoria do registro
    *   selecionado. Verifica permissao e delega para ChkAuditadoClick.
    *==========================================================================
    PROCEDURE BtnSalvarClick
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !USED("cursor_4c_Historico") OR RECCOUNT("cursor_4c_Historico") = 0
                MsgAviso("Nenhum registro selecionado no hist" + CHR(243) + "rico.")
            ELSE
                IF THIS.this_oBusinessObject.VerificarPermissaoAuditoria()
                    THIS.ChkAuditadoClick()
                ELSE
                    MsgAviso("Usu" + CHR(225) + "rio sem permiss" + CHR(227) + "o de auditoria.")
                ENDIF
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao salvar auditoria")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Alias CRUD para OPERACIONAL:
    *   Oculta o campo de filtro por data e restaura foco ao grid.
    *==========================================================================
    PROCEDURE BtnCancelarClick
        THIS.txt_4c_Data.Visible      = .F.
        THIS.lbl_4c_DataLabel.Visible = .F.
        THIS.grd_4c_Historico.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Sincroniza estado do form -> BO
    *   OPERACIONAL: propaga parametros de contexto e estado do checkbox
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF
        THIS.this_oBusinessObject.this_lTemAuditoria = (THIS.chk_4c_ChkAuditado.Value = 1)
        THIS.this_oBusinessObject.this_cCdGrupo      = THIS.this_cCdGrupo
        THIS.this_oBusinessObject.this_cCdConta      = THIS.this_cCdConta
        THIS.this_oBusinessObject.this_cCdProduto    = THIS.this_cCdProduto
        THIS.this_oBusinessObject.this_cDsProduto    = THIS.this_cDsProduto
        THIS.this_oBusinessObject.this_dDataIni      = THIS.this_dDataIni
        THIS.this_oBusinessObject.this_dDataFim      = THIS.this_dDataFim
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Sincroniza estado do BO -> form
    *   OPERACIONAL: atualiza campos de exibicao da linha corrente
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm
        THIS.AtualizarCamposLinha()
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - OPERACIONAL: campos sao ReadOnly por natureza.
    *   Gerencia apenas visibilidade do checkbox de auditoria conforme permissao.
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos
    LPARAMETERS par_cModo
        LOCAL loc_lPermite
        loc_lPermite = .F.
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) == "O"
                loc_lPermite = THIS.this_oBusinessObject.VerificarPermissaoAuditoria()
            ENDIF
            THIS.chk_4c_ChkAuditado.Visible = loc_lPermite
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao habilitar campos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa todos os campos de exibicao da linha selecionada
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos
        THIS.txt_4c_Auditors.Value    = ""
        THIS.txt_4c_DtAudits.Value    = ""
        THIS.txt_4c_Usuario.Value     = ""
        THIS.txt_4c_Nota.Value        = ""
        THIS.txt_4c_GruOri.Value      = ""
        THIS.txt_4c_DesGruOri.Value   = ""
        THIS.txt_4c_ConOri.Value      = ""
        THIS.txt_4c_DesConOri.Value   = ""
        THIS.txt_4c_GruDes.Value      = ""
        THIS.txt_4c_DesGruDes.Value   = ""
        THIS.txt_4c_ConDes.Value      = ""
        THIS.txt_4c_DesConDes.Value   = ""
        THIS.obj_4c_Obs.Value         = ""
        THIS.chk_4c_ChkAuditado.Value = 0
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - OPERACIONAL sem modos CRUD: no-op de compatibilidade
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo
    LPARAMETERS par_cModo
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrHprBO.prg):
*================================================================================
* SigPrHprBO.prg - Business Object: Historico de Produtos (SIGPRHPR)
* Form: OPERACIONAL
* Tabela principal: SigMvHst (UPDATE de auditoria)
* Gerado: 17/07/2026
*================================================================================

DEFINE CLASS SigPrHprBO AS BusinessBase

    *-- Tabela e chave principal (SigMvHst recebe UPDATE de auditoria)
    this_cTabela     = "SigMvHst"
    this_cCampoChave = "cidchaves"

    *-- Parametros de contexto recebidos do form pai ao abrir
    this_cCdGrupo    = ""
    this_cCdConta    = ""
    this_cCdProduto  = ""
    this_cDsProduto  = ""
    this_dDataIni    = {}
    this_dDataFim    = {}
    this_cCodEmpresa = ""

    *-- Dados do registro corrente de SigMvHst (linha selecionada no grid)
    this_cEmps       = ""
    this_cEmpos      = ""
    this_cGrupos     = ""
    this_cEstos      = ""
    this_cCpros      = ""
    this_cDopes      = ""
    this_nNumes      = 0
    this_dDatas      = {}
    this_cAuditors   = ""
    this_dDtAudits   = {}
    this_nQtds       = 0
    this_cOpers      = ""
    this_nSQtds      = 0
    this_cObs        = ""
    this_cUsuars     = ""
    this_cCidChaves  = ""
    this_nPesos      = 0
    this_nSPesos     = 0
    this_cCunis      = ""
    this_cCunips     = ""
    this_cCestos     = ""
    this_cEmpDopNums = ""
    this_cEmpGruEsts = ""

    *-- Dados do documento (SigMvCab ou SigCdNec)
    this_cGrupoOri    = ""
    this_cContaOri    = ""
    this_cGrupoDes    = ""
    this_cContaDes    = ""
    this_cNotas       = ""

    *-- Descricoes do contabil (SigCdGcr e SigCdCli)
    this_cDesGrupoOri = ""
    this_cDesContaOri = ""
    this_cDesGrupoDes = ""
    this_cDesContaDes = ""

    *-- Controle interno de permissao e tipo de produto (Cestos='3' = produto peso)
    this_lTemAuditoria = .F.
    this_lEhPeso       = .F.

    *--------------------------------------------------------------------------
    PROCEDURE Init
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigMvHst"
            THIS.this_cCampoChave = "cidchaves"
            THIS.this_cCodEmpresa = go_4c_Sistema.cCodEmpresa

            *-- Cursor placeholder para grid de historico
            *-- Estrutura espelha campos do SQLEXEC em CarregarHistorico
            SET NULL ON
            CREATE CURSOR cursor_4c_Historico (;
                emps      C(3)    NULL, ;
                empos     C(3)    NULL, ;
                grupos    C(10)   NULL, ;
                estos     C(10)   NULL, ;
                cpros     C(14)   NULL, ;
                dopes     C(20)   NULL, ;
                numes     N(6,0)  NULL, ;
                datas     T       NULL, ;
                auditors  C(10)   NULL, ;
                dtaudits  T       NULL, ;
                qtds      N(9,3)  NULL, ;
                opers     C(1)    NULL, ;
                sqtds     N(11,3) NULL, ;
                obs       M       NULL, ;
                usuars    C(10)   NULL, ;
                cidchaves C(20)   NULL, ;
                pesos     N(15,3) NULL, ;
                spesos    N(15,3) NULL, ;
                cunis     C(3)    NULL  ;
            )
            INDEX ON DTOS(datas) TAG datas
            INDEX ON pesos TAG pesos
            SET NULL OFF

            *-- Cursor placeholder para grid de subniveis
            *-- Estrutura espelha crSubniveis do legado
            SET NULL ON
            CREATE CURSOR cursor_4c_Subniveis (;
                emps  C(3)   NULL, ;
                dopes C(20)  NULL, ;
                numes N(6,0) NULL  ;
            )
            INDEX ON emps TAG emps
            SET NULL OFF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria
    *--------------------------------------------------------------------------
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Copia dados da linha corrente do cursor para as props
    * Assinatura canonica CRUD (par_cAliasCursor). Alias flexivel para
    * cursor_4c_Historico ou qualquer outro cursor com estrutura de SigMvHst.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias
        loc_lSucesso = .F.
        TRY
            loc_cAlias = IIF(EMPTY(par_cAliasCursor), "cursor_4c_Historico", par_cAliasCursor)
            IF USED(loc_cAlias) AND RECCOUNT(loc_cAlias) > 0
                SELECT (loc_cAlias)
                THIS.this_cEmps      = TratarNulo(emps, "C")
                THIS.this_cEmpos     = TratarNulo(empos, "C")
                THIS.this_cGrupos    = TratarNulo(grupos, "C")
                THIS.this_cEstos     = TratarNulo(estos, "C")
                THIS.this_cCpros     = TratarNulo(cpros, "C")
                THIS.this_cDopes     = TratarNulo(dopes, "C")
                IF VARTYPE(numes) = "N"
                    THIS.this_nNumes = NVL(numes, 0)
                ELSE
                    THIS.this_nNumes = 0
                ENDIF
                THIS.this_dDatas     = NVL(datas, {})
                THIS.this_cAuditors  = TratarNulo(auditors, "C")
                THIS.this_dDtAudits  = NVL(dtaudits, {})
                IF VARTYPE(qtds) = "N"
                    THIS.this_nQtds  = NVL(qtds, 0)
                ELSE
                    THIS.this_nQtds  = 0
                ENDIF
                THIS.this_cOpers     = TratarNulo(opers, "C")
                IF VARTYPE(sqtds) = "N"
                    THIS.this_nSQtds = NVL(sqtds, 0)
                ELSE
                    THIS.this_nSQtds = 0
                ENDIF
                THIS.this_cObs       = TratarNulo(obs, "C")
                THIS.this_cUsuars    = TratarNulo(usuars, "C")
                THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
                IF VARTYPE(pesos) = "N"
                    THIS.this_nPesos = NVL(pesos, 0)
                ELSE
                    THIS.this_nPesos = 0
                ENDIF
                IF TYPE(loc_cAlias + ".spesos") != "U"
                    IF VARTYPE(spesos) = "N"
                        THIS.this_nSPesos = NVL(spesos, 0)
                    ELSE
                        THIS.this_nSPesos = 0
                    ENDIF
                ENDIF
                IF TYPE(loc_cAlias + ".cunis") != "U"
                    THIS.this_cCunis = TratarNulo(cunis, "C")
                ENDIF
                THIS.this_lTemAuditoria = (NOT EMPTY(ALLTRIM(THIS.this_cAuditors)))
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [CarregarDoCursor]", "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Este form eh OPERACIONAL de leitura (historico de produtos).
    * Registros em SigMvHst sao gerados por movimentacoes de outros modulos,
    * NUNCA inseridos manualmente por este cadastro. Assim, Inserir() bloqueia
    * a operacao e retorna .F., garantindo que o form Salvar() (chamado pela
    * FormBase por engano) nao corrompa o historico.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        THIS.this_cMensagemErro = "N" + CHR(227) + "o " + CHR(233) + " permitido incluir registros no hist" + CHR(243) + "rico de produtos. Movimenta" + CHR(231) + CHR(245) + "es s" + CHR(227) + "o geradas pelos m" + CHR(243) + "dulos operacionais."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigMvHst dos campos de auditoria (auditors/dtaudits).
    * Aplica ou remove marca de auditor conforme this_lTemAuditoria.
    * Registra evento em LogAuditoria via RegistrarAuditoria("UPDATE").
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nQueryOk, loc_cUsuario, loc_cChave
        loc_lSucesso = .F.
        TRY
            loc_cChave = ALLTRIM(THIS.this_cCidChaves)
            IF EMPTY(loc_cChave)
                THIS.this_cMensagemErro = "Nenhum registro selecionado para atualizar."
            ELSE
                loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")

                IF THIS.this_lTemAuditoria
                    *-- Marcar como auditado pelo usuario logado
                    loc_cSQL = "UPDATE SigMvHst SET auditors = " + EscaparSQL(loc_cUsuario) + ;
                               ", dtaudits = GETDATE() " + ;
                               "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
                ELSE
                    *-- Remover marca de auditoria
                    loc_cSQL = "UPDATE SigMvHst SET auditors = '          ', dtaudits = NULL " + ;
                               "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
                ENDIF

                loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL, "")
                IF loc_nQueryOk < 1
                    THIS.this_cMensagemErro = "Falha ao atualizar auditoria do hist" + CHR(243) + "rico."
                ELSE
                    *-- Sincronizar cursor local + props
                    IF USED("cursor_4c_Historico")
                        SELECT cursor_4c_Historico
                        IF THIS.this_lTemAuditoria
                            REPLACE auditors WITH loc_cUsuario, dtaudits WITH DATETIME()
                            THIS.this_cAuditors = loc_cUsuario
                            THIS.this_dDtAudits = DATETIME()
                        ELSE
                            REPLACE auditors WITH SPACE(10), dtaudits WITH {}
                            THIS.this_cAuditors = ""
                            THIS.this_dDtAudits = {}
                        ENDIF
                    ENDIF
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + " [Atualizar]", "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Override com GETDATE() nativo do SQL Server.
    * Regra: NUNCA usar GETDATE() em campo DataHora
    * (rejeita tipo T, gera INSERT NULL em NOT NULL). Lesson 2026-07-08.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario
        loc_cChave = THIS.ObterChavePrimaria()
        IF EMPTY(loc_cChave)
            RETURN .F.
        ENDIF
        loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")
        loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                   "VALUES (" + EscaparSQL(THIS.this_cTabela) + ", " + ;
                   EscaparSQL(par_cOperacao) + ", " + ;
                   EscaparSQL(loc_cChave) + ", " + ;
                   EscaparSQL(loc_cUsuario) + ", GETDATE())"
        SQLEXEC(gnConnHandle, loc_cSQL)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarHistorico
    *-- Carrega SigMvHst para cursor_4c_Historico conforme parametros do form pai
    *-- Retorna .T. se OK
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_nQueryOk, loc_cSQL, loc_cEmpGruEst, loc_cDtIni, loc_cDtFim
        loc_lSucesso = .F.
        TRY
            loc_cEmpGruEst = THIS.this_cCodEmpresa + THIS.this_cCdGrupo + THIS.this_cCdConta
            loc_cDtIni     = FormatarDataSQL(THIS.this_dDataIni)
            loc_cDtFim     = FormatarDataSQL(THIS.this_dDataFim)

            loc_cSQL = "SELECT a.emps, a.empos, a.grupos, a.estos, a.cpros, " + ;
                       "a.dopes, a.numes, a.datas, a.auditors, a.dtaudits, " + ;
                       "a.qtds, a.opers, a.sqtds, a.obs, a.usuars, " + ;
                       "a.cidchaves, a.pesos, a.spesos, '   ' AS cunis " + ;
                       "FROM SigMvHst a " + ;
                       "WHERE a.empgruests = " + EscaparSQL(loc_cEmpGruEst) + ;
                       " AND a.cpros = " + EscaparSQL(THIS.this_cCdProduto) + ;
                       " AND CAST(a.datas AS DATE) >= " + loc_cDtIni + ;
                       " AND CAST(a.datas AS DATE) <= " + loc_cDtFim + ;
                       " ORDER BY a.emps, a.grupos, a.estos, a.cidchaves, a.opers"

            IF USED("cursor_4c_HistoricoTemp")
                USE IN cursor_4c_HistoricoTemp
            ENDIF

            loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_HistoricoTemp")
            IF loc_nQueryOk < 1
                MsgErro("Falha ao carregar hist" + CHR(243) + "rico de produtos.", "Erro")
            ELSE
                SELECT cursor_4c_Historico
                ZAP
                APPEND FROM DBF("cursor_4c_HistoricoTemp")
                USE IN cursor_4c_HistoricoTemp

                THIS.CarregarDadosProduto()

                IF NOT EMPTY(ALLTRIM(THIS.this_cCunis))
                    SELECT cursor_4c_Historico
                    REPLACE ALL cunis WITH THIS.this_cCunis
                ENDIF

                SELECT cursor_4c_Historico
                INDEX ON DTOS(datas) TAG datas
                INDEX ON pesos TAG pesos
                GO BOTTOM

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [CarregarHistorico]", "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarDadosProduto
    *-- Carrega SigCdPro e SigCdUni para o produto corrente
    *-- Preenche this_cCunis, this_cCunips, this_cCestos, this_lEhPeso
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_nQueryOk
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_TmpPro")
                USE IN cursor_4c_TmpPro
            ENDIF
            loc_nQueryOk = SQLEXEC(gnConnHandle, ;
                "SELECT cpros, cunis, cunips FROM SigCdPro WHERE cpros = " + ;
                EscaparSQL(THIS.this_cCdProduto), "cursor_4c_TmpPro")
            IF loc_nQueryOk >= 1 AND USED("cursor_4c_TmpPro") AND RECCOUNT("cursor_4c_TmpPro") > 0
                SELECT cursor_4c_TmpPro
                GO TOP
                THIS.this_cCunis  = NVL(cursor_4c_TmpPro.cunis, "")
                THIS.this_cCunips = NVL(cursor_4c_TmpPro.cunips, "")
            ELSE
                THIS.this_cCunis  = ""
                THIS.this_cCunips = ""
            ENDIF
            IF USED("cursor_4c_TmpPro")
                USE IN cursor_4c_TmpPro
            ENDIF

            THIS.this_cCestos = ""
            IF NOT EMPTY(ALLTRIM(THIS.this_cCunis))
                IF USED("cursor_4c_TmpUni")
                    USE IN cursor_4c_TmpUni
                ENDIF
                loc_nQueryOk = SQLEXEC(gnConnHandle, ;
                    "SELECT Cestos FROM SigCdUni WHERE cunis = " + ;
                    EscaparSQL(THIS.this_cCunis), "cursor_4c_TmpUni")
                IF loc_nQueryOk >= 1 AND USED("cursor_4c_TmpUni") AND RECCOUNT("cursor_4c_TmpUni") > 0
                    SELECT cursor_4c_TmpUni
                    GO TOP
                    THIS.this_cCestos = NVL(cursor_4c_TmpUni.Cestos, "")
                ENDIF
                IF USED("cursor_4c_TmpUni")
                    USE IN cursor_4c_TmpUni
                ENDIF
            ENDIF

            THIS.this_lEhPeso = (THIS.this_cCestos = "3")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [CarregarDadosProduto]", "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarDadosLinhaSelecionada
    *-- Copia dados do registro corrente de cursor_4c_Historico para props this_*
    *-- Chamado pelo form apos AfterRowColChange
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Historico") AND RECCOUNT("cursor_4c_Historico") > 0
                SELECT cursor_4c_Historico
                THIS.this_cEmps      = NVL(cursor_4c_Historico.emps, "")
                THIS.this_cEmpos     = NVL(cursor_4c_Historico.empos, "")
                THIS.this_cGrupos    = NVL(cursor_4c_Historico.grupos, "")
                THIS.this_cEstos     = NVL(cursor_4c_Historico.estos, "")
                THIS.this_cCpros     = NVL(cursor_4c_Historico.cpros, "")
                THIS.this_cDopes     = NVL(cursor_4c_Historico.dopes, "")
                THIS.this_nNumes     = NVL(cursor_4c_Historico.numes, 0)
                THIS.this_dDatas     = NVL(cursor_4c_Historico.datas, {})
                THIS.this_cAuditors  = NVL(cursor_4c_Historico.auditors, "")
                THIS.this_dDtAudits  = NVL(cursor_4c_Historico.dtaudits, {})
                THIS.this_nQtds      = NVL(cursor_4c_Historico.qtds, 0)
                THIS.this_cOpers     = NVL(cursor_4c_Historico.opers, "")
                THIS.this_nSQtds     = NVL(cursor_4c_Historico.sqtds, 0)
                THIS.this_cObs       = NVL(cursor_4c_Historico.obs, "")
                THIS.this_cUsuars    = NVL(cursor_4c_Historico.usuars, "")
                THIS.this_cCidChaves = NVL(cursor_4c_Historico.cidchaves, "")
                THIS.this_nPesos     = NVL(cursor_4c_Historico.pesos, 0)
                THIS.this_nSPesos    = NVL(cursor_4c_Historico.spesos, 0)
                THIS.this_cCunis     = NVL(cursor_4c_Historico.cunis, "")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [CarregarDadosLinhaSelecionada]", "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarDocumento
    *-- Carrega documento (SigMvCab ou SigCdNec) do registro corrente
    *-- Detecta tipo via SigCdOpe: se existe -> SigMvCab, senao -> SigCdNec
    *-- Preenche this_cGrupoOri, this_cContaOri, this_cGrupoDes, this_cContaDes, this_cNotas
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_nQueryOk, loc_cEmpsEfetivo
        LOCAL loc_cEmpDopNum, loc_cEmpDopNumLong, loc_lTemOpe
        loc_lSucesso = .F.
        TRY
            THIS.this_cGrupoOri = ""
            THIS.this_cContaOri = ""
            THIS.this_cGrupoDes = ""
            THIS.this_cContaDes = ""
            THIS.this_cNotas    = ""

            loc_cEmpsEfetivo   = IIF(NOT EMPTY(ALLTRIM(THIS.this_cEmpos)), THIS.this_cEmpos, THIS.this_cEmps)
            loc_cEmpDopNum     = loc_cEmpsEfetivo + THIS.this_cDopes + STR(THIS.this_nNumes, 6)
            loc_cEmpDopNumLong = loc_cEmpsEfetivo + THIS.this_cDopes + STR(THIS.this_nNumes, 10)

            *-- Verificar se operacao existe em SigCdOpe
            IF USED("cursor_4c_TmpOpe")
                USE IN cursor_4c_TmpOpe
            ENDIF
            loc_nQueryOk = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 Dopes FROM SigCdOpe WHERE Dopes = " + ;
                EscaparSQL(ALLTRIM(THIS.this_cDopes)), "cursor_4c_TmpOpe")
            loc_lTemOpe = (loc_nQueryOk >= 1 AND USED("cursor_4c_TmpOpe") AND RECCOUNT("cursor_4c_TmpOpe") > 0)
            IF USED("cursor_4c_TmpOpe")
                USE IN cursor_4c_TmpOpe
            ENDIF

            IF USED("cursor_4c_DocTemp")
                USE IN cursor_4c_DocTemp
            ENDIF

            IF loc_lTemOpe
                loc_nQueryOk = SQLEXEC(gnConnHandle, ;
                    "SELECT grupoos, contaos, grupods, contads, Notas " + ;
                    "FROM SigMvCab " + ;
                    "WHERE empdopnums = " + EscaparSQL(loc_cEmpDopNum), ;
                    "cursor_4c_DocTemp")
            ELSE
                loc_nQueryOk = SQLEXEC(gnConnHandle, ;
                    "SELECT grupoos, contaos, grupods, contads, '      ' AS Notas " + ;
                    "FROM SigCdNec " + ;
                    "WHERE empdnps = " + EscaparSQL(loc_cEmpDopNumLong), ;
                    "cursor_4c_DocTemp")
            ENDIF

            IF loc_nQueryOk < 1
                MsgErro("Falha ao carregar documento do movimento.", "Erro")
            ELSE
                IF USED("cursor_4c_DocTemp") AND RECCOUNT("cursor_4c_DocTemp") > 0
                    SELECT cursor_4c_DocTemp
                    GO TOP
                    THIS.this_cGrupoOri = NVL(cursor_4c_DocTemp.grupoos, "")
                    THIS.this_cContaOri = NVL(cursor_4c_DocTemp.contaos, "")
                    THIS.this_cGrupoDes = NVL(cursor_4c_DocTemp.grupods, "")
                    THIS.this_cContaDes = NVL(cursor_4c_DocTemp.contads, "")
                    THIS.this_cNotas    = NVL(cursor_4c_DocTemp.Notas, "")
                ENDIF
                IF USED("cursor_4c_DocTemp")
                    USE IN cursor_4c_DocTemp
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [CarregarDocumento]", "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarDescricoesContabil
    *-- Carrega descricoes de grupos (SigCdGcr) e contas (SigCdCli)
    *-- Preenche this_cDesGrupoOri/Des e this_cDesContaOri/Des
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_nQueryOk
        LOCAL loc_cGruOri, loc_cConOri, loc_cGruDes, loc_cConDes
        loc_lSucesso = .F.
        TRY
            loc_cGruOri = THIS.this_cGrupoOri
            loc_cConOri = THIS.this_cContaOri
            loc_cGruDes = THIS.this_cGrupoDes
            loc_cConDes = THIS.this_cContaDes

            THIS.this_cDesGrupoOri = ""
            THIS.this_cDesContaOri = ""
            THIS.this_cDesGrupoDes = ""
            THIS.this_cDesContaDes = ""

            *-- Grupos via SigCdGcr (coluna descrs COM r)
            IF USED("cursor_4c_TmpGcr")
                USE IN cursor_4c_TmpGcr
            ENDIF
            IF NOT EMPTY(ALLTRIM(loc_cGruOri)) OR NOT EMPTY(ALLTRIM(loc_cGruDes))
                loc_nQueryOk = SQLEXEC(gnConnHandle, ;
                    "SELECT codigos, descrs FROM SigCdGcr " + ;
                    "WHERE codigos = " + EscaparSQL(loc_cGruOri) + ;
                    " OR codigos = " + EscaparSQL(loc_cGruDes), ;
                    "cursor_4c_TmpGcr")
                IF loc_nQueryOk >= 1 AND USED("cursor_4c_TmpGcr") AND RECCOUNT("cursor_4c_TmpGcr") > 0
                    SELECT cursor_4c_TmpGcr
                    INDEX ON codigos TAG codigos
                    GO TOP
                    THIS.this_cDesGrupoOri = IIF(SEEK(loc_cGruOri, "cursor_4c_TmpGcr", "codigos"), NVL(cursor_4c_TmpGcr.descrs, ""), "")
                    THIS.this_cDesGrupoDes = IIF(SEEK(loc_cGruDes, "cursor_4c_TmpGcr", "codigos"), NVL(cursor_4c_TmpGcr.descrs, ""), "")
                ENDIF
                IF USED("cursor_4c_TmpGcr")
                    USE IN cursor_4c_TmpGcr
                ENDIF
            ENDIF

            *-- Contas via SigCdCli
            IF USED("cursor_4c_TmpCli")
                USE IN cursor_4c_TmpCli
            ENDIF
            IF NOT EMPTY(ALLTRIM(loc_cConOri)) OR NOT EMPTY(ALLTRIM(loc_cConDes))
                loc_nQueryOk = SQLEXEC(gnConnHandle, ;
                    "SELECT iclis, rclis FROM SigCdCli " + ;
                    "WHERE iclis = " + EscaparSQL(loc_cConOri) + ;
                    " OR iclis = " + EscaparSQL(loc_cConDes), ;
                    "cursor_4c_TmpCli")
                IF loc_nQueryOk >= 1 AND USED("cursor_4c_TmpCli") AND RECCOUNT("cursor_4c_TmpCli") > 0
                    SELECT cursor_4c_TmpCli
                    INDEX ON iclis TAG iclis
                    GO TOP
                    THIS.this_cDesContaOri = IIF(SEEK(loc_cConOri, "cursor_4c_TmpCli", "iclis"), NVL(cursor_4c_TmpCli.rclis, ""), "")
                    THIS.this_cDesContaDes = IIF(SEEK(loc_cConDes, "cursor_4c_TmpCli", "iclis"), NVL(cursor_4c_TmpCli.rclis, ""), "")
                ENDIF
                IF USED("cursor_4c_TmpCli")
                    USE IN cursor_4c_TmpCli
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [CarregarDescricoesContabil]", "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarSubniveis
    *-- Carrega SigMvPec para cursor_4c_Subniveis do registro corrente
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_nQueryOk, loc_cEdn, loc_cSQL
        loc_lSucesso = .F.
        TRY
            SELECT cursor_4c_Subniveis
            ZAP

            loc_cEdn = THIS.this_cEmps + THIS.this_cDopes + STR(THIS.this_nNumes, 6)

            loc_cSQL = "SELECT a.EmpSubns AS Emps, b.Dopes, " + ;
                       "RIGHT(STR(a.Codigos, 10), 6) AS Numes " + ;
                       "FROM SigMvPec a, SigCdOpe b " + ;
                       "WHERE a.EmpDopNums = " + EscaparSQL(loc_cEdn) + ;
                       " AND LEFT(STR(a.Codigos, 10), 4) = STR(b.NDopes, 4) " + ;
                       "ORDER BY 1, 2, 3"

            IF USED("cursor_4c_SubniveisTemp")
                USE IN cursor_4c_SubniveisTemp
            ENDIF

            loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SubniveisTemp")
            IF loc_nQueryOk < 1
                MsgErro("Falha ao carregar subniveis.", "Erro")
            ELSE
                IF USED("cursor_4c_SubniveisTemp") AND RECCOUNT("cursor_4c_SubniveisTemp") > 0
                    SELECT cursor_4c_SubniveisTemp
                    SCAN
                        INSERT INTO cursor_4c_Subniveis (emps, dopes, numes) ;
                            VALUES (cursor_4c_SubniveisTemp.Emps, ;
                                    cursor_4c_SubniveisTemp.Dopes, ;
                                    VAL(cursor_4c_SubniveisTemp.Numes))
                    ENDSCAN
                ENDIF
                IF USED("cursor_4c_SubniveisTemp")
                    USE IN cursor_4c_SubniveisTemp
                ENDIF
                SELECT cursor_4c_Subniveis
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [CarregarSubniveis]", "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE AuditarRegistro
    *-- Marca registro corrente como auditado pelo usuario logado em SigMvHst
    *-- Retorna .T. se OK
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_nQueryOk, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                MsgAviso("Nenhum registro selecionado para auditar.", "Auditoria")
            ELSE
                loc_cSQL = "UPDATE SigMvHst SET auditors = " + ;
                           EscaparSQL(gc_4c_UsuarioLogado) + ;
                           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
                loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL, "")
                IF loc_nQueryOk < 1
                    MsgErro("Falha ao registrar auditor.", "Erro de Auditoria")
                ELSE
                    loc_cSQL = "UPDATE SigMvHst SET dtaudits = GETDATE() " + ;
                               "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
                    loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL, "")
                    IF loc_nQueryOk < 1
                        MsgErro("Falha ao registrar data de auditoria.", "Erro de Auditoria")
                    ELSE
                        IF USED("cursor_4c_Historico")
                            SELECT cursor_4c_Historico
                            REPLACE auditors WITH gc_4c_UsuarioLogado
                            REPLACE dtaudits WITH DATETIME()
                        ENDIF
                        THIS.this_cAuditors = gc_4c_UsuarioLogado
                        THIS.this_dDtAudits = DATETIME()
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [AuditarRegistro]", "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE DesauditarRegistro
    *-- Remove marca de auditoria do registro corrente em SigMvHst
    *-- Retorna .T. se OK
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_nQueryOk, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                MsgAviso("Nenhum registro selecionado.", "Auditoria")
            ELSE
                loc_cSQL = "UPDATE SigMvHst SET auditors = '          ' " + ;
                           "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
                loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL, "")
                IF loc_nQueryOk < 1
                    MsgErro("Falha ao remover auditor.", "Erro de Auditoria")
                ELSE
                    loc_cSQL = "UPDATE SigMvHst SET dtaudits = NULL " + ;
                               "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
                    loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL, "")
                    IF loc_nQueryOk < 1
                        MsgErro("Falha ao remover data de auditoria.", "Erro de Auditoria")
                    ELSE
                        IF USED("cursor_4c_Historico")
                            SELECT cursor_4c_Historico
                            REPLACE auditors WITH SPACE(10)
                            REPLACE dtaudits WITH {}
                        ENDIF
                        THIS.this_cAuditors = ""
                        THIS.this_dDtAudits = {}
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [DesauditarRegistro]", "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE VerificarPermissaoAuditoria
    *-- Retorna .T. se o usuario logado pode auditar o registro corrente
    *-- Supervisor (4CONTROL) sempre pode; outros: apenas registros sem auditor
    *-- ou registros que o proprio usuario auditou
    *--------------------------------------------------------------------------
        LOCAL loc_lPermitido, loc_lSupervisor
        loc_lPermitido  = .F.
        TRY
            loc_lSupervisor = (UPPER(ALLTRIM(gc_4c_UsuarioLogado)) = "4CONTROL")
            IF loc_lSupervisor
                loc_lPermitido = .T.
            ELSE
                IF EMPTY(ALLTRIM(THIS.this_cAuditors))
                    loc_lPermitido = .T.
                ELSE
                    IF UPPER(ALLTRIM(gc_4c_UsuarioLogado)) = UPPER(ALLTRIM(THIS.this_cAuditors))
                        loc_lPermitido = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [VerificarPermissaoAuditoria]", "Erro")
        ENDTRY
        RETURN loc_lPermitido
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE VerificarExistenciaDocumento
    *-- Verifica se existe documento para o registro corrente
    *-- Retorna "MOVCAB" se em SigMvCab, "NEC" se em SigCdNec, "" se nao encontrou
    *--------------------------------------------------------------------------
        LOCAL loc_cTipoDoc, loc_nQueryOk, loc_cEmpsEfetivo
        LOCAL loc_cEmpDopNum, loc_cEmpDopNumLong
        loc_cTipoDoc = ""
        TRY
            IF NOT (EMPTY(ALLTRIM(THIS.this_cEmps)) OR EMPTY(ALLTRIM(THIS.this_cDopes)) OR THIS.this_nNumes = 0)
                loc_cEmpsEfetivo   = IIF(NOT EMPTY(ALLTRIM(THIS.this_cEmpos)), THIS.this_cEmpos, THIS.this_cEmps)
                loc_cEmpDopNum     = loc_cEmpsEfetivo + THIS.this_cDopes + STR(THIS.this_nNumes, 6)
                loc_cEmpDopNumLong = loc_cEmpsEfetivo + THIS.this_cDopes + STR(THIS.this_nNumes, 10)

                IF USED("cursor_4c_TmpChk")
                    USE IN cursor_4c_TmpChk
                ENDIF
                loc_nQueryOk = SQLEXEC(gnConnHandle, ;
                    "SELECT COUNT(*) AS nExiste FROM SigMvCab WHERE EmpDopNums = " + ;
                    EscaparSQL(loc_cEmpDopNum), "cursor_4c_TmpChk")
                IF loc_nQueryOk >= 1 AND USED("cursor_4c_TmpChk") AND RECCOUNT("cursor_4c_TmpChk") > 0
                    SELECT cursor_4c_TmpChk
                    IF NVL(cursor_4c_TmpChk.nExiste, 0) > 0
                        loc_cTipoDoc = "MOVCAB"
                    ENDIF
                ENDIF
                IF USED("cursor_4c_TmpChk")
                    USE IN cursor_4c_TmpChk
                ENDIF

                IF EMPTY(loc_cTipoDoc)
                    loc_nQueryOk = SQLEXEC(gnConnHandle, ;
                        "SELECT COUNT(*) AS nExiste FROM SigCdNec WHERE EmpDnPs = " + ;
                        EscaparSQL(loc_cEmpDopNumLong), "cursor_4c_TmpChk")
                    IF loc_nQueryOk >= 1 AND USED("cursor_4c_TmpChk") AND RECCOUNT("cursor_4c_TmpChk") > 0
                        SELECT cursor_4c_TmpChk
                        IF NVL(cursor_4c_TmpChk.nExiste, 0) > 0
                            loc_cTipoDoc = "NEC"
                        ENDIF
                    ENDIF
                    IF USED("cursor_4c_TmpChk")
                        USE IN cursor_4c_TmpChk
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [VerificarExistenciaDocumento]", "Erro")
        ENDTRY
        RETURN loc_cTipoDoc
    ENDPROC

ENDDEFINE

