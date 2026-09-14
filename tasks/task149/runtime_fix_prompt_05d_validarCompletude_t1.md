# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[FormSigPdMp8.prg] Procedure vazia (sem codigo): AlternarPagina
[FormSigPdMp8.prg] Indicador de pendencia: * BtnCancelarClick - Reverte edicoes pendente

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPdMp8.prg):
*==============================================================================
* FormSigPdMp8.prg
* OPERACIONAL: Relacao de OPs com Nao-Conformidades
* Sub-dialog para vincular nao-conformidades (SigCdNcf) a OPs de retrabalho.
* Compartilha DataSession com o form pai para acesso direto a xMfas e xNensiN.
*
* Parametros de Init:
*   par_oFormPai : referencia ao form que abriu este sub-dialog (pForm no legado)
*   par_nDtS     : DataSession ID - mantido por compatibilidade, nao usado diretamente
*==============================================================================

DEFINE CLASS FormSigPdMp8 AS FormBase

    *-- Propriedades visuais (original SigPdMp9: 800x600, escalado para 1000x600)
    Width        = 1000
    Height       = 600
    Caption      = ""
    DataSession  = 2
    ShowWindow   = 1
    WindowType   = 1
    BorderStyle  = 2
    TitleBar     = 0
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .F.
    Themes       = .F.
    AutoCenter   = .T.

    *-- Estado do form
    this_oBusinessObject = .NULL.
    this_oFormPai        = .NULL.   && Referencia ao form pai (ParentForm no legado)
    this_cEscolha        = ""       && Modo: INSERIR ou ALTERAR (pcEscolha no legado)
    this_cAntValue       = ""       && Valor anterior da col Cods do grd_4c_Inc (anti-loop Valid)

    *-- Container cabecalho cinza escuro (cntSombra no legado)
    ADD OBJECT cnt_4c_Sombra AS Container WITH ;
        Top = 0, Left = 0, Width = 1000, Height = 80, ;
        BorderWidth = 0, BackColor = RGB(100,100,100)

    *-- Shape decorativo canto superior direito, area do botao OK (Shape2 no legado)
    ADD OBJECT shp_4c_Shape2 AS Shape WITH ;
        Top = 12, Left = 877, Height = 110, Width = 90, ;
        BackStyle = 0, BorderStyle = 0, BorderColor = RGB(136,189,188)

    *-- Shape borda da area da imagem do produto - inicia invisivel (Shape4 no legado)
    ADD OBJECT shp_4c_Shape4 AS Shape WITH ;
        Top = 87, Left = 616, Height = 121, Width = 245, ;
        BackStyle = 0, Visible = .F., BorderColor = RGB(90,90,90)

    *-- Imagem do produto - exibida em AfterRowColChange do grd_4c_Retrab (FigJpg no legado)
    ADD OBJECT img_4c_FigJpg AS Image WITH ;
        Stretch = 1, Top = 89, Left = 622, Width = 232, Height = 116, ;
        Visible = .F.

    *-- Container exibe dados da operacao corrente (Operacao no legado)
    ADD OBJECT cnt_4c_Operacao AS Container WITH ;
        Top = 137, Left = 34, Width = 504, Height = 43, ;
        BackStyle = 0, BorderWidth = 0

    *==========================================================================
    * Init - Compartilha datasession com o form pai; FormBase.Init chama InicializarForm
    *==========================================================================
    PROCEDURE Init(par_oFormPai, par_nDtS)
        IF VARTYPE(par_oFormPai) = "O"
            THIS.this_oFormPai = par_oFormPai
            IF TYPE("par_oFormPai.pcEscolha") = "C"
                THIS.this_cEscolha = ALLTRIM(par_oFormPai.pcEscolha)
            ENDIF
            *-- Compartilha datasession do pai: acesso a xMfas, xNensiN, tmpnens
            THIS.DataSessionId = par_oFormPai.DataSessionId
        ENDIF
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Instancia BO e constroi interface visual
    * Chamado automaticamente por FormBase.Init() via DODEFAULT()
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        THIS.this_oBusinessObject = CREATEOBJECT("SigPdMp8BO")
        IF VARTYPE(THIS.this_oBusinessObject) <> "O"
            MsgErro("Erro ao criar SigPdMp8BO.", "FormSigPdMp8.InicializarForm")
            RETURN .F.
        ENDIF

        TRY
            THIS.LockScreen = .T.

            THIS.Caption = "Rela" + CHR(231) + CHR(227) + "o de OPs com N" + ;
                           CHR(227) + "o-Confirmidades"

            IF TYPE("gc_4c_CaminhoIcones") = "C"
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            ENDIF

            THIS.ConfigurarPageFrame()
            THIS.ConfigurarCabecalho()
            THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
            THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
            THIS.ConfigurarPaginaLista()
            THIS.ConfigurarPaginaDados()
            THIS.CarregarGradeRetrab()
            THIS.ConfigurarEventos()

            THIS.TornarControlesVisiveis(THIS)

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar: " + loc_oErro.Message, "FormSigPdMp8.InicializarForm")
            loc_lSucesso = .F.
        ENDTRY

        THIS.LockScreen = .F.
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - OPERACIONAL: sem PageFrame, aplica imagem de fundo
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        IF TYPE("gc_4c_CaminhoIcones") = "C"
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Labels de titulo dentro de cnt_4c_Sombra
    * (lblSombra sombra preta + lblTitulo branco sobrepostos, igual ao frmcadastro)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_cCaption
        loc_cCaption = THIS.Caption

        WITH THIS.cnt_4c_Sombra
            .AddObject("lbl_4c_LblSombra", "Label")
            WITH .lbl_4c_LblSombra
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
                .Width         = 769
                .ForeColor     = RGB(0, 0, 0)
                .Visible       = .T.
            ENDWITH

            .AddObject("lbl_4c_LblTitulo", "Label")
            WITH .lbl_4c_LblTitulo
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 18
                .WordWrap   = .T.
                .Alignment  = 0
                .BackStyle  = 0
                .Caption    = loc_cCaption
                .Height     = 46
                .Left       = 10
                .Top        = 17
                .Width      = 769
                .ForeColor  = RGB(255, 255, 255)
                .Visible    = .T.
            ENDWITH
        ENDWITH

        THIS.cnt_4c_Sombra.Visible = .T.
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Adiciona labels, grids e botoes de acao ao form
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.AdicionarLabelsGrade()
        THIS.ConfigurarGrdRetrab()
        THIS.ConfigurarGrdInc()
        THIS.ConfigurarCmdgCompo()
        THIS.AdicionarTxtDescricao()
        THIS.AdicionarBtnOk()
    ENDPROC

    *==========================================================================
    * AdicionarLabelsGrade - Labels de secao: Label2 (acima grd_4c_Retrab),
    * Label1 (acima grd_4c_Inc), Label3 (abaixo grd_4c_Inc / campo Descs)
    *==========================================================================
    PROTECTED PROCEDURE AdicionarLabelsGrade()
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .AutoSize   = .F.
            .FontBold   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .Alignment  = 2
            .BackStyle  = 0
            .Caption    = "Rela" + CHR(231) + CHR(227) + "o de Op's"
            .Height     = 17
            .Left       = 35
            .Top        = 215
            .Width      = 403
            .ForeColor  = RGB(90, 90, 90)
            .Visible    = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .AutoSize   = .F.
            .FontBold   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .Alignment  = 2
            .BackStyle  = 0
            .Caption    = "N" + CHR(227) + "o Conformidades"
            .Height     = 17
            .Left       = 470
            .Top        = 216
            .Width      = 436
            .ForeColor  = RGB(90, 90, 90)
            .Visible    = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .AutoSize   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .BackStyle  = 0
            .Caption    = "Descri" + CHR(231) + CHR(227) + "o da N" + CHR(227) + "o Conformidade"
            .Height     = 15
            .Left       = 452
            .Top        = 552
            .Width      = 194
            .ForeColor  = RGB(90, 90, 90)
            .Visible    = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Adiciona campos de display da operacao corrente
    * Container cnt_4c_Operacao exibe empresa/descricao/numero da OP (cursor tmpnens)
    * Campos READ-ONLY: GetEmpresa(emps), GetOperacao(dopps), GetCodigo(numps)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oCnt
        IF !PEMSTATUS(THIS, "cnt_4c_Operacao", 5)
            RETURN
        ENDIF
        loc_oCnt = THIS.cnt_4c_Operacao

        *-- Label "Movimentacao :" (original Say4, left=31->39 escalado)
        loc_oCnt.AddObject("lbl_4c_Say4", "Label")
        WITH loc_oCnt.lbl_4c_Say4
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
            .Left      = 39
            .Top       = 14
            .AutoSize  = .T.
            .BackStyle = 0
            .ForeColor = RGB(0,0,0)
        ENDWITH

        *-- txt_4c_Empresa: empresa da OP (original GetEmpresa, tmpnens.emps)
        *-- left=111->139, width=36->45 escalado
        loc_oCnt.AddObject("txt_4c_Empresa", "TextBox")
        WITH loc_oCnt.txt_4c_Empresa
            .ControlSource     = "tmpnens.emps"
            .Left              = 139
            .Top               = 10
            .Width             = 45
            .Height            = 23
            .ReadOnly          = .T.
            .SpecialEffect     = 2
            .ForeColor         = RGB(0,0,0)
            .DisabledBackColor = RGB(255,255,255)
            .BorderColor       = RGB(100,100,100)
        ENDWITH

        *-- txt_4c_Operacao: descricao da operacao (original GetOperacao, tmpnens.dopps)
        *-- left=149->186, width=156->195 escalado
        loc_oCnt.AddObject("txt_4c_Operacao", "TextBox")
        WITH loc_oCnt.txt_4c_Operacao
            .ControlSource     = "tmpnens.dopps"
            .Left              = 186
            .Top               = 10
            .Width             = 195
            .Height            = 23
            .ReadOnly          = .T.
            .SpecialEffect     = 2
            .ForeColor         = RGB(0,0,0)
            .DisabledBackColor = RGB(255,255,255)
            .BorderColor       = RGB(100,100,100)
        ENDWITH

        *-- txt_4c_NumOp: numero da OP (original GetCodigo, tmpnens.numps)
        *-- left=307->384, width=81->101 escalado
        loc_oCnt.AddObject("txt_4c_NumOp", "TextBox")
        WITH loc_oCnt.txt_4c_NumOp
            .ControlSource     = "tmpnens.numps"
            .Format            = "L"
            .InputMask         = "9999999999"
            .Left              = 384
            .Top               = 10
            .Width             = 101
            .Height            = 23
            .ReadOnly          = .T.
            .SpecialEffect     = 2
            .ForeColor         = RGB(0,0,0)
            .DisabledBackColor = RGB(255,255,255)
            .BorderColor       = RGB(100,100,100)
        ENDWITH

        loc_oCnt.Visible = .T.
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna visiveis controles do container recursivamente
    * EXCETO img_4c_FigJpg e shp_4c_Shape4 (gerenciados por eventos no legado)
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl, loc_cNome

        IF VARTYPE(par_oContainer) <> "O"
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oControl) <> "O"
                LOOP
            ENDIF

            loc_cNome = UPPER(loc_oControl.Name)

            IF INLIST(loc_cNome, "IMG_4C_FIGJPG", "SHP_4C_SHAPE4")
                LOOP
            ENDIF

            IF PEMSTATUS(loc_oControl, "Visible", 5)
                loc_oControl.Visible = .T.
            ENDIF

            IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                LOCAL loc_nP
                FOR loc_nP = 1 TO loc_oControl.PageCount
                    THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
                ENDFOR
            ENDIF

            IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                THIS.TornarControlesVisiveis(loc_oControl)
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * FormatarGridLista - Formata visual do grid apos carregamento
    * Grids usam FontName=Arial conforme original (nao Tahoma)
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        IF VARTYPE(par_oGrid) <> "O"
            RETURN
        ENDIF
        WITH par_oGrid
            .FontName = "Arial"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarGrdRetrab - Cria grd_4c_Retrab: lista de OPs para retrabalho
    * READ-ONLY, 4 colunas. Original GradeRetrab: left=26 top=232 w=331 h=317 (800px)
    * Escalado 800->1000 (x1.25): left=33 w=414
    * Ordem visual: Envelope(col2) | O.P.(col1) | Produto(col4) | Qtde(col3)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrdRetrab()
        THIS.AddObject("grd_4c_Retrab", "Grid")
        WITH THIS.grd_4c_Retrab
            .Top                = 232
            .Left               = 33
            .Width              = 414
            .Height             = 317
            .ColumnCount        = 4
            .ReadOnly           = .T.
            .RecordMark         = .F.
            .DeleteMark         = .F.
            .AllowHeaderSizing  = .F.
            .HeaderHeight       = 14
            .RowHeight          = 15
            .ScrollBars         = 2
            .GridLineColor      = RGB(238,238,238)
            .HighlightStyle     = 2
            .HighlightBackColor = RGB(255,255,255)
            .HighlightForeColor = RGB(15,41,104)

            *-- Column1: O. P. (ColumnOrder=2, nops, original w=75->94)
            .Column1.ColumnOrder = 2
            .Column1.Width       = 94
            .Column1.Movable     = .F.
            .Column1.Resizable   = .F.
            .Column1.ReadOnly    = .T.
            .Column1.Format      = "L"
            .Column1.InputMask   = "9999999999"
            .Column1.FontName    = "Arial"
            .Column1.Header1.Caption   = "O. P."
            .Column1.Header1.FontName  = "Tahoma"
            .Column1.Header1.FontSize  = 8
            .Column1.Header1.Alignment = 2
            .Column1.Text1.FontName    = "Arial"
            .Column1.Text1.BorderStyle = 0
            .Column1.Text1.Margin      = 0
            .Column1.Text1.ReadOnly    = .T.
            .Column1.Text1.ForeColor   = RGB(0,0,0)
            .Column1.Text1.BackColor   = RGB(255,255,255)

            *-- Column2: Envelope (ColumnOrder=1, nenvs, original w=70->88)
            .Column2.ColumnOrder = 1
            .Column2.Width       = 88
            .Column2.Movable     = .F.
            .Column2.Resizable   = .F.
            .Column2.ReadOnly    = .T.
            .Column2.Alignment   = 4
            .Column2.Header1.Caption   = "Envelope"
            .Column2.Header1.FontName  = "Tahoma"
            .Column2.Header1.FontSize  = 8
            .Column2.Header1.Alignment = 2
            .Column2.Text1.Alignment   = 0
            .Column2.Text1.BorderStyle = 0
            .Column2.Text1.Margin      = 0
            .Column2.Text1.MaxLength   = 6
            .Column2.Text1.ReadOnly    = .T.
            .Column2.Text1.ForeColor   = RGB(0,0,0)
            .Column2.Text1.BackColor   = RGB(255,255,255)

            *-- Column3: Qtde (ColumnOrder=4, qtds, original w=55->69)
            .Column3.ColumnOrder = 4
            .Column3.Width       = 69
            .Column3.Movable     = .F.
            .Column3.Resizable   = .F.
            .Column3.ReadOnly    = .T.
            .Column3.InputMask   = "9999.9"
            .Column3.Header1.Caption   = "Qtde"
            .Column3.Header1.FontName  = "Tahoma"
            .Column3.Header1.FontSize  = 8
            .Column3.Header1.Alignment = 2
            .Column3.Text1.BorderStyle = 0
            .Column3.Text1.Margin      = 0
            .Column3.Text1.ReadOnly    = .T.
            .Column3.Text1.ForeColor   = RGB(0,0,0)
            .Column3.Text1.BackColor   = RGB(255,255,255)

            *-- Column4: Produto (ColumnOrder=3, codpds, original w=108->135)
            .Column4.ColumnOrder = 3
            .Column4.Width       = 135
            .Column4.Movable     = .F.
            .Column4.Resizable   = .F.
            .Column4.ReadOnly    = .T.
            .Column4.Header1.Caption   = "Produto"
            .Column4.Header1.FontName  = "Tahoma"
            .Column4.Header1.FontSize  = 8
            .Column4.Header1.Alignment = 2
            .Column4.Text1.BorderStyle = 0
            .Column4.Text1.Margin      = 0
            .Column4.Text1.ReadOnly    = .T.
            .Column4.Text1.ForeColor   = RGB(0,0,0)
            .Column4.Text1.BackColor   = RGB(255,255,255)
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarGrdInc - Cria grd_4c_Inc: grade de nao-conformidades (editavel)
    * Original Gradeinc: left=358 top=232 w=369 h=317 (800px)
    * Escalado 800->1000 (x1.25): left=448 w=461
    * Cursor: xNensiN (compartilhado via datasession do form pai)
    * Ordem visual: Codigo(col1) | Qtde(col2) | Funcionario(col4) | Descricao(col3)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrdInc()
        THIS.AddObject("grd_4c_Inc", "Grid")
        WITH THIS.grd_4c_Inc
            .Top                = 232
            .Left               = 448
            .Width              = 461
            .Height             = 317
            .ColumnCount        = 4
            .ReadOnly           = .F.
            .RecordMark         = .F.
            .DeleteMark         = .F.
            .AllowHeaderSizing  = .F.
            .HeaderHeight       = 14
            .RowHeight          = 15
            .ScrollBars         = 2
            .GridLines          = 3
            .GridLineColor      = RGB(238,238,238)
            .HighlightStyle     = 2
            .HighlightBackColor = RGB(255,255,255)
            .HighlightForeColor = RGB(15,41,104)

            *-- Column1: Codigo NCF (ColumnOrder=1, Cods, original w=80->100)
            .Column1.ColumnOrder = 1
            .Column1.Width       = 100
            .Column1.Movable     = .F.
            .Column1.Resizable   = .F.
            .Column1.ReadOnly    = .F.
            .Column1.FontName    = "Arial"
            .Column1.Header1.Caption   = "C" + CHR(243) + "digo"
            .Column1.Header1.FontName  = "Tahoma"
            .Column1.Header1.FontSize  = 8
            .Column1.Header1.Alignment = 2
            .Column1.Text1.FontName    = "Arial"
            .Column1.Text1.BorderStyle = 0
            .Column1.Text1.Margin      = 0
            .Column1.Text1.MaxLength   = 10
            .Column1.Text1.ReadOnly    = .F.
            .Column1.Text1.ForeColor   = RGB(0,0,0)
            .Column1.Text1.BackColor   = RGB(255,255,255)

            *-- Column2: Qtde (ColumnOrder=2, Qtds, original w=45->56)
            .Column2.ColumnOrder = 2
            .Column2.Width       = 56
            .Column2.Movable     = .F.
            .Column2.Resizable   = .F.
            .Column2.ReadOnly    = .F.
            .Column2.InputMask   = "999.9"
            .Column2.Header1.Caption   = "Qtde"
            .Column2.Header1.FontName  = "Tahoma"
            .Column2.Header1.FontSize  = 8
            .Column2.Header1.Alignment = 2
            .Column2.Text1.BorderStyle = 0
            .Column2.Text1.InputMask   = "999.9"
            .Column2.Text1.Margin      = 0
            .Column2.Text1.ReadOnly    = .F.
            .Column2.Text1.ForeColor   = RGB(0,0,0)
            .Column2.Text1.BackColor   = RGB(255,255,255)

            *-- Column3: Descricao NC (ColumnOrder=4, Descs, original w=145->181)
            *-- Editavel condicionalmente (When: pcEscolha INSERIR/ALTERAR AND xNensiN.Fixos=2)
            .Column3.ColumnOrder = 4
            .Column3.Width       = 181
            .Column3.ReadOnly    = .F.
            .Column3.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
            .Column3.Header1.FontName  = "Tahoma"
            .Column3.Header1.Alignment = 2
            .Column3.Text1.BorderStyle = 0
            .Column3.Text1.Margin      = 0
            .Column3.Text1.ForeColor   = RGB(0,0,0)
            .Column3.Text1.BackColor   = RGB(255,255,255)

            *-- Column4: Funcionario (ColumnOrder=3, Conta2s, original w=99->124)
            .Column4.ColumnOrder = 3
            .Column4.Width       = 124
            .Column4.Movable     = .F.
            .Column4.Resizable   = .F.
            .Column4.ReadOnly    = .F.
            .Column4.Header1.Caption   = "Funcion" + CHR(225) + "rio"
            .Column4.Header1.FontName  = "Tahoma"
            .Column4.Header1.Alignment = 2
            .Column4.Text1.BorderStyle = 0
            .Column4.Text1.Margin      = 0
            .Column4.Text1.ForeColor   = RGB(0,0,0)
            .Column4.Text1.BackColor   = RGB(255,255,255)
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarCmdgCompo - CommandGroup com botoes Inserir/Excluir NC
    * Original cmdgCompo: left=723 top=229 w=50 h=92 (800px) -> left=904 (1000px)
    * Buttons(1)=cmdSInserir (adicionar NC do grid esquerdo)
    * Buttons(2)=cmdSexcluir (remover NC selecionada do grid direito)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCmdgCompo()
        THIS.AddObject("cmdg_4c_Compo", "CommandGroup")
        WITH THIS.cmdg_4c_Compo
            .Top         = 229
            .Left        = 904
            .Width       = 50
            .Height      = 92
            .BackStyle   = 0
            .BorderStyle = 0
            .ButtonCount = 2
            .Value       = 1

            WITH .Buttons(1)
                .AutoSize    = .F.
                .Top         = 5
                .Left        = 5
                .Height      = 40
                .Width       = 40
                .Caption     = ""
                .ForeColor   = RGB(36,84,155)
                .BackColor   = RGB(255,255,255)
                .Themes      = .F.
                .ToolTipText = "Inclui uma N" + CHR(227) + "o-Conformidade"
                IF TYPE("gc_4c_CaminhoIcones") = "C"
                    .Picture = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
                ENDIF
            ENDWITH

            WITH .Buttons(2)
                .AutoSize    = .F.
                .Top         = 47
                .Left        = 5
                .Height      = 40
                .Width       = 40
                .FontName    = "Verdana"
                .FontSize    = 8
                .Caption     = ""
                .ForeColor   = RGB(36,84,155)
                .BackColor   = RGB(255,255,255)
                .Themes      = .F.
                .ToolTipText = "Exclui uma N" + CHR(227) + "o-Conformidade"
                IF TYPE("gc_4c_CaminhoIcones") = "C"
                    .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                ENDIF
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * AdicionarTxtDescricao - Textbox que exibe descricao da NC selecionada
    * Ligado a xNensiN.descs (auto-atualiza ao navegar grd_4c_Inc via ControlSource)
    * Original Get_Descs: left=361 top=568 w=347 h=23 (800px) -> left=451 w=434
    *==========================================================================
    PROTECTED PROCEDURE AdicionarTxtDescricao()
        THIS.AddObject("txt_4c_Descricao", "TextBox")
        WITH THIS.txt_4c_Descricao
            .ControlSource = "xNensiN.descs"
            .Left          = 451
            .Top           = 568
            .Width         = 434
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BorderStyle   = 1
            .BackColor     = RGB(255,255,255)
            .ForeColor     = RGB(0,0,0)
        ENDWITH
    ENDPROC

    *==========================================================================
    * AdicionarBtnOk - Botao OK: habilita form pai e fecha este sub-dialog
    * Original ok: left=725 top=3 picture=cadastro_salvar_60.jpg (800px) -> left=906
    *==========================================================================
    PROTECTED PROCEDURE AdicionarBtnOk()
        THIS.AddObject("cmd_4c_Ok", "CommandButton")
        WITH THIS.cmd_4c_Ok
            .Top             = 3
            .Left            = 906
            .Width           = 60
            .Height          = 72
            .Caption         = "OK"
            .FontBold        = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .ForeColor       = RGB(90,90,90)
            .BackColor       = RGB(255,255,255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            IF TYPE("gc_4c_CaminhoIcones") = "C"
                .Picture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            ENDIF
        ENDWITH
    ENDPROC

    *==========================================================================
    * CarregarGradeRetrab - Vincula grids aos cursores da datasession compartilhada
    * Chamado em InicializarForm apos todos os Configure* (datasession ja ativa)
    * grd_4c_Retrab -> xMfas  (OPs para retrabalho, read-only)
    * grd_4c_Inc    -> xNensiN (NC da OP corrente, editavel)
    * Headers DEVEM ser reconfigurados apos setar RecordSource/ControlSource
    *==========================================================================
    PROCEDURE CarregarGradeRetrab()
        LOCAL loc_oGrdR, loc_oGrdI

        IF !PEMSTATUS(THIS, "grd_4c_Retrab", 5) OR !PEMSTATUS(THIS, "grd_4c_Inc", 5)
            RETURN
        ENDIF

        loc_oGrdR = THIS.grd_4c_Retrab
        loc_oGrdI = THIS.grd_4c_Inc

        *-- Vincular grd_4c_Retrab ao cursor xMfas
        IF USED("xMfas")
            SELECT xMfas
            GO TOP

            loc_oGrdR.ColumnCount           = 4
            loc_oGrdR.RecordSource          = "xMfas"
            loc_oGrdR.Column1.ControlSource = "xmfas.nops"
            loc_oGrdR.Column2.ControlSource = "xmfas.nenvs"
            loc_oGrdR.Column3.ControlSource = "xmfas.qtds"
            loc_oGrdR.Column4.ControlSource = "xmfas.codpds"

            *-- Reconfigurar headers (obrigatorio apos RecordSource/ControlSource)
            loc_oGrdR.Column1.Header1.Caption = "O. P."
            loc_oGrdR.Column2.Header1.Caption = "Envelope"
            loc_oGrdR.Column3.Header1.Caption = "Qtde"
            loc_oGrdR.Column4.Header1.Caption = "Produto"

            loc_oGrdR.Refresh
        ENDIF

        *-- Vincular grd_4c_Inc ao cursor xNensiN (ordenado por Nops)
        IF USED("xNensiN")
            SELECT xNensiN
            SET ORDER TO
            SET ORDER TO Nops
            GO TOP

            loc_oGrdI.ColumnCount           = 4
            loc_oGrdI.RecordSource          = "xNensiN"
            loc_oGrdI.Column1.ControlSource = "xnensiN.Cods"
            loc_oGrdI.Column2.ControlSource = "xnensiN.Qtds"
            loc_oGrdI.Column3.ControlSource = "xnensiN.Descs"
            loc_oGrdI.Column4.ControlSource = "xnensiN.Conta2s"

            *-- Reconfigurar headers (obrigatorio apos RecordSource/ControlSource)
            loc_oGrdI.Column1.Header1.Caption = "C" + CHR(243) + "digo"
            loc_oGrdI.Column2.Header1.Caption = "Qtde"
            loc_oGrdI.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            loc_oGrdI.Column4.Header1.Caption = "Funcion" + CHR(225) + "rio"

            loc_oGrdI.Refresh
        ENDIF

        *-- Foco inicial na coluna Envelope do grd_4c_Retrab (igual ao original)
        IF USED("xMfas")
            THIS.grd_4c_Retrab.Column2.SetFocus
        ENDIF
    ENDPROC

    *==========================================================================
    * AlternarPagina - OPERACIONAL: sem PageFrame, mantido por compatibilidade
    * Este sub-dialog nao possui alternancia de paginas.
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
    ENDPROC

    *==========================================================================
    * Destroy - Libera BO e executa destruicao padrao
    *==========================================================================
    PROCEDURE Destroy()
        THIS.this_oBusinessObject = .NULL.
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * ConfigurarEventos - Registra BINDEVENTs para grids e botoes do form
    * Chamado em InicializarForm apos CarregarGradeRetrab
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarEventos()
        LOCAL loc_lModoEdicao

        *-- grd_4c_Retrab: navegar OP filtra NCs e mostra imagem do produto
        IF PEMSTATUS(THIS, "grd_4c_Retrab", 5)
            BINDEVENT(THIS.grd_4c_Retrab, "AfterRowColChange", THIS, "GrdRetrabAfterRowColChange")
        ENDIF

        *-- grd_4c_Inc: navegar NC atualiza campo de descricao
        IF PEMSTATUS(THIS, "grd_4c_Inc", 5)
            BINDEVENT(THIS.grd_4c_Inc, "AfterRowColChange", THIS, "GrdIncAfterRowColChange")
        ENDIF

        *-- cmdg_4c_Compo: Buttons(1)=Inserir NC, Buttons(2)=Excluir NC
        IF PEMSTATUS(THIS, "cmdg_4c_Compo", 5)
            BINDEVENT(THIS.cmdg_4c_Compo.Buttons(1), "Click", THIS, "BtnIncluirClick")
            BINDEVENT(THIS.cmdg_4c_Compo.Buttons(2), "Click", THIS, "BtnExcluirClick")
        ENDIF

        *-- cmd_4c_Ok: habilitar form pai e fechar sub-dialog
        IF PEMSTATUS(THIS, "cmd_4c_Ok", 5)
            BINDEVENT(THIS.cmd_4c_Ok, "Click", THIS, "BtnOkClick")
        ENDIF

        *-- Ajustar estado inicial dos botoes conforme modo (INSERIR/ALTERAR vs VISUALIZAR)
        loc_lModoEdicao = INLIST(UPPER(THIS.this_cEscolha), "INSERIR", "ALTERAR")
        IF PEMSTATUS(THIS, "cmdg_4c_Compo", 5)
            THIS.cmdg_4c_Compo.Buttons(1).Enabled = loc_lModoEdicao
            THIS.cmdg_4c_Compo.Buttons(2).Enabled = loc_lModoEdicao
        ENDIF

        *-- grd_4c_Inc: celulas editaveis - When (controle de edicao) e KeyPress (validacao/lookup)
        IF PEMSTATUS(THIS, "grd_4c_Inc", 5)
            *-- Column1 (Cods - Codigo NCF): salva AntValue em When; valida NCF em KeyPress
            BINDEVENT(THIS.grd_4c_Inc.Column1.Text1, "When",     THIS, "GrdIncCol1When")
            BINDEVENT(THIS.grd_4c_Inc.Column1.Text1, "KeyPress", THIS, "GrdIncCol1KeyPress")
            *-- Column2 (Qtds - Quantidade): controle de edicao em When; valida em KeyPress
            BINDEVENT(THIS.grd_4c_Inc.Column2.Text1, "When",     THIS, "GrdIncCol2When")
            BINDEVENT(THIS.grd_4c_Inc.Column2.Text1, "KeyPress", THIS, "GrdIncCol2KeyPress")
            *-- Column3 (Descs - Descricao): editavel somente quando Fixos = 2
            BINDEVENT(THIS.grd_4c_Inc.Column3.Text1, "When",     THIS, "GrdIncCol3When")
            *-- Column4 (Conta2s - Funcionario): controle de edicao em When; valida em KeyPress
            BINDEVENT(THIS.grd_4c_Inc.Column4.Text1, "When",     THIS, "GrdIncCol4When")
            BINDEVENT(THIS.grd_4c_Inc.Column4.Text1, "KeyPress", THIS, "GrdIncCol4KeyPress")
        ENDIF
    ENDPROC

    *==========================================================================
    * GrdRetrabAfterRowColChange - Filtro de NCs e imagem do produto por OP
    * Equivalente a GradeRetrab.AfterRowColChange do original (SigPdMp9)
    * Ao navegar no grid esquerdo (OPs), filtra xNensiN pela OP corrente e
    * exibe a imagem do produto associado (FigJpgs de SigCdPro).
    *==========================================================================
    PROCEDURE GrdRetrabAfterRowColChange(par_nColIndex)
        LOCAL loc_cArquivo, loc_cSQL, loc_lcFoto, loc_oErro

        IF !USED("xNensiN") OR !USED("xMfas")
            RETURN
        ENDIF

        *-- Filtrar xNensiN pelo Nops da OP atual (Set Key To filtra cursor local)
        SELECT xNensiN
        SET KEY TO xMfas.Nops
        GO TOP

        IF PEMSTATUS(THIS, "grd_4c_Inc", 5)
            THIS.grd_4c_Inc.Refresh
        ENDIF

        SELECT xMfas

        *-- Limpar imagem anterior
        IF PEMSTATUS(THIS, "img_4c_FigJpg", 5)
            CLEAR RESOURCES
            THIS.img_4c_FigJpg.Picture = ""
            THIS.img_4c_FigJpg.Visible = .F.
            IF PEMSTATUS(THIS, "shp_4c_Shape4", 5)
                THIS.shp_4c_Shape4.Visible = .F.
            ENDIF
        ENDIF

        *-- Carregar imagem do produto via SQLEXEC (substitui poDataMgr.CursorQuery)
        TRY
            IF !EMPTY(xMfas.CodPds) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_cSQL = "SELECT DPros, FigJpgs FROM SigCdPro WHERE CPros = " + ;
                           EscaparSQL(ALLTRIM(xMfas.CodPds))

                IF USED("cursor_4c_ProdImg")
                    USE IN cursor_4c_ProdImg
                ENDIF

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdImg") > 0 AND ;
                   USED("cursor_4c_ProdImg")
                    IF !EMPTY(cursor_4c_ProdImg.FigJpgs) AND !ISNULL(cursor_4c_ProdImg.FigJpgs)
                        loc_cArquivo = SYS(2023) + "\SigPdMp5.Jpg"
                        loc_lcFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN( ;
                            cursor_4c_ProdImg.FigJpgs, ;
                            "data:image/png;base64,",  ""), ;
                            "data:image/jpeg;base64,", ""), ;
                            "data:image/jpg;base64,",  ""), 14)

                        IF STRTOFILE(loc_lcFoto, loc_cArquivo) > 0 AND ;
                           PEMSTATUS(THIS, "img_4c_FigJpg", 5)
                            THIS.img_4c_FigJpg.Picture = loc_cArquivo
                            THIS.img_4c_FigJpg.Visible = .T.
                            IF PEMSTATUS(THIS, "shp_4c_Shape4", 5)
                                THIS.shp_4c_Shape4.Visible = .T.
                            ENDIF
                        ENDIF
                    ENDIF

                    USE IN cursor_4c_ProdImg
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar imagem do produto: " + loc_oErro.Message, ;
                    "FormSigPdMp8.GrdRetrabAfterRowColChange")
        ENDTRY

        THIS.Refresh
    ENDPROC

    *==========================================================================
    * GrdIncAfterRowColChange - Atualiza descricao ao navegar na grade de NCs
    * Equivalente a Gradeinc.AfterRowColChange do original
    * txt_4c_Descricao tem ControlSource=xNensiN.descs; Refresh e suficiente
    *==========================================================================
    PROCEDURE GrdIncAfterRowColChange(par_nColIndex)
        IF PEMSTATUS(THIS, "txt_4c_Descricao", 5)
            THIS.txt_4c_Descricao.Refresh
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Insere nova linha de NC para a OP corrente
    * Equivalente a cmdgCompo.cmdSInserir.Click do original
    * INSERT INTO xNensiN: Nops e Qtds vindos da OP selecionada em xMfas
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro

        IF !INLIST(UPPER(THIS.this_cEscolha), "INSERIR", "ALTERAR")
            RETURN
        ENDIF

        IF !USED("xNensiN") OR !USED("xMfas")
            RETURN
        ENDIF

        TRY
            INSERT INTO xNensiN (Nops, Qtds) VALUES (xMfas.Nops, xMfas.Qtds)

            IF PEMSTATUS(THIS, "grd_4c_Inc", 5)
                THIS.grd_4c_Inc.Refresh
                THIS.grd_4c_Inc.Column1.SetFocus
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao incluir N" + CHR(227) + "o-Conformidade: " + ;
                    loc_oErro.Message, "FormSigPdMp8.BtnIncluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Alterna o sub-dialog para modo ALTERAR
    * Habilita os botoes de Inclusao/Exclusao de NCs e da foco a primeira
    * coluna do grid de NCs para edicao imediata. Em forms operacionais o
    * modo eh controlado por this_cEscolha (equivalente a pcEscolha do legado).
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        THIS.this_cEscolha = "ALTERAR"

        IF PEMSTATUS(THIS, "cmdg_4c_Compo", 5)
            THIS.cmdg_4c_Compo.Buttons(1).Enabled = .T.
            THIS.cmdg_4c_Compo.Buttons(2).Enabled = .T.
        ENDIF

        IF PEMSTATUS(THIS, "grd_4c_Inc", 5)
            THIS.grd_4c_Inc.ReadOnly = .F.
            THIS.grd_4c_Inc.Refresh
            IF USED("xNensiN") AND RECCOUNT("xNensiN") > 0
                THIS.grd_4c_Inc.Column1.SetFocus
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Alterna o sub-dialog para modo VISUALIZAR (read-only)
    * Desabilita botoes de Inclusao/Exclusao de NCs e torna grid de NCs
    * somente leitura. Permite navegar pelos registros sem alterar dados.
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        THIS.this_cEscolha = "VISUALIZAR"

        IF PEMSTATUS(THIS, "cmdg_4c_Compo", 5)
            THIS.cmdg_4c_Compo.Buttons(1).Enabled = .F.
            THIS.cmdg_4c_Compo.Buttons(2).Enabled = .F.
        ENDIF

        IF PEMSTATUS(THIS, "grd_4c_Inc", 5)
            THIS.grd_4c_Inc.ReadOnly = .T.
            THIS.grd_4c_Inc.Refresh
        ENDIF

        IF PEMSTATUS(THIS, "grd_4c_Retrab", 5) AND USED("xMfas") AND RECCOUNT("xMfas") > 0
            THIS.grd_4c_Retrab.SetFocus
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Exclui NC selecionada; se grade ficar vazia insere nova
    * Equivalente a cmdgCompo.cmdSexcluir.Click do original
    * DELETE registro corrente de xNensiN; se COUNT = 0 chama BtnIncluirClick
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_nContagem, loc_oErro

        IF !INLIST(UPPER(THIS.this_cEscolha), "INSERIR", "ALTERAR")
            RETURN
        ENDIF

        IF !USED("xNensiN")
            RETURN
        ENDIF

        TRY
            SELECT xNensiN
            DELETE

            COUNT TO loc_nContagem

            IF loc_nContagem = 0
                THIS.BtnIncluirClick()
            ENDIF

            GO TOP

            IF PEMSTATUS(THIS, "grd_4c_Inc", 5)
                THIS.grd_4c_Inc.Refresh
                THIS.grd_4c_Inc.Column1.SetFocus
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao excluir N" + CHR(227) + "o-Conformidade: " + ;
                    loc_oErro.Message, "FormSigPdMp8.BtnExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnOkClick - Habilita o form pai e fecha este sub-dialog
    * Equivalente a ok.Click do original
    * Reabilita o form pai (Enabled=.T.) e libera este sub-dialog
    *==========================================================================
    PROCEDURE BtnOkClick()
        IF VARTYPE(THIS.this_oFormPai) = "O"
            THIS.this_oFormPai.Enabled = .T.
        ENDIF
        THIS.Release
    ENDPROC

    *==========================================================================
    * GrdIncCol1When - Salva AntValue e controla edicao de Column1 (Cods - NCF)
    * Equivalente a Gradeinc.Column1.Text1.When do original:
    *   ThisForm.Antvalue = This.Value; Return(InList(...,'INSERIR','ALTERAR'))
    *==========================================================================
    PROCEDURE GrdIncCol1When()
        IF USED("xNensiN") AND PEMSTATUS(THIS, "grd_4c_Inc", 5)
            THIS.this_cAntValue = ALLTRIM(THIS.grd_4c_Inc.Column1.Text1.Value)
        ENDIF
        RETURN INLIST(UPPER(THIS.this_cEscolha), "INSERIR", "ALTERAR")
    ENDPROC

    *==========================================================================
    * GrdIncCol1KeyPress - Dispara validacao de NCF ao sair da celula
    * Enter(13), Tab(9) ou F4(115) disparam ValidarNcf()
    *==========================================================================
    PROCEDURE GrdIncCol1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.ValidarNcf()
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarNcf - Valida codigo NCF digitado na Column1 de grd_4c_Inc
    * Equivalente ao Valid original de Gradeinc.Column1.Text1:
    *   - Se valor mudou: busca SigCdNcf WHERE Emps=empresa OR Emps=' '
    *   - Se encontrado por Seek: atualiza Fixos e Descs em xNensiN
    *   - Se nao encontrado: abre FormBuscaAuxiliar para selecao
    *   - Apos selecao: atualiza celula, Fixos e Descs; Refresh do grid
    *==========================================================================
    PROCEDURE ValidarNcf()
        LOCAL loc_cValor, loc_cSQL, loc_oErro, loc_oBusca
        LOCAL loc_cCods, loc_cDescs, loc_nFixos
        loc_oBusca = .NULL.

        IF !PEMSTATUS(THIS, "grd_4c_Inc", 5)
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(THIS.grd_4c_Inc.Column1.Text1.Value)

        IF EMPTY(loc_cValor) OR loc_cValor = ALLTRIM(THIS.this_cAntValue)
            RETURN
        ENDIF

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                MsgErro("Sem conex" + CHR(227) + "o com o servidor. Reinicialize o processo.", ;
                        "FormSigPdMp8.ValidarNcf")
                RETURN
            ENDIF

            loc_cSQL = "SELECT Cods, Descs, Fixos FROM SigCdNcf WHERE (Emps = " + ;
                       EscaparSQL(go_4c_Sistema.cCodEmpresa) + " OR Emps = ' ')"

            IF USED("cursor_4c_NcfTemp")
                TABLEREVERT(.T., "cursor_4c_NcfTemp")
                USE IN cursor_4c_NcfTemp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NcfTemp") > 0 AND USED("cursor_4c_NcfTemp")
                SELECT cursor_4c_NcfTemp
                INDEX ON UPPER(ALLTRIM(Cods)) TAG Cods

                IF SEEK(UPPER(ALLTRIM(loc_cValor)))
                    *-- Encontrado: capturar valores e atualizar xNensiN
                    loc_cCods  = ALLTRIM(cursor_4c_NcfTemp.Cods)
                    loc_cDescs = ALLTRIM(cursor_4c_NcfTemp.Descs)
                    loc_nFixos = NVL(cursor_4c_NcfTemp.Fixos, 0)

                    IF USED("xNensiN")
                        SELECT xNensiN
                        REPLACE Fixos WITH loc_nFixos, Descs WITH loc_cDescs
                    ENDIF

                    USE IN cursor_4c_NcfTemp
                ELSE
                    *-- Nao encontrado: abrir FormBuscaAuxiliar para selecao
                    USE IN cursor_4c_NcfTemp

                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                        "SigCdNcf", ;
                        "cursor_4c_NcfBusca", ;
                        "Cods", ;
                        loc_cValor, ;
                        "N" + CHR(227) + "o Conformidade")
                    loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_NcfBusca")
                        SELECT cursor_4c_NcfBusca
                        loc_cCods  = ALLTRIM(cursor_4c_NcfBusca.Cods)
                        loc_cDescs = ALLTRIM(cursor_4c_NcfBusca.Descs)
                        loc_nFixos = NVL(cursor_4c_NcfBusca.Fixos, 0)

                        THIS.grd_4c_Inc.Column1.Text1.Value = loc_cCods

                        IF USED("xNensiN")
                            SELECT xNensiN
                            REPLACE Fixos WITH loc_nFixos, Descs WITH loc_cDescs
                        ENDIF
                    ELSE
                        THIS.grd_4c_Inc.Column1.Text1.Value = ""
                    ENDIF

                    IF USED("cursor_4c_NcfBusca")
                        USE IN cursor_4c_NcfBusca
                    ENDIF

                    loc_oBusca.Release()
                    loc_oBusca = .NULL.
                ENDIF

            ELSE
                MsgErro("Falha ao acessar SigCdNcf. Reinicialize o processo.", ;
                        "FormSigPdMp8.ValidarNcf")
            ENDIF

            IF PEMSTATUS(THIS, "grd_4c_Inc", 5)
                THIS.grd_4c_Inc.Refresh
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao validar N" + CHR(227) + "o-Conformidade: " + loc_oErro.Message, ;
                    "FormSigPdMp8.ValidarNcf")
            IF USED("cursor_4c_NcfTemp")
                USE IN cursor_4c_NcfTemp
            ENDIF
            IF USED("cursor_4c_NcfBusca")
                USE IN cursor_4c_NcfBusca
            ENDIF
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.Release()
            ENDIF
        ENDTRY
    ENDPROC

    *==========================================================================
    * GrdIncCol2When - Controla edicao da Column2 (Qtds - Quantidade)
    * Equivalente a Gradeinc.Column2.Text1.When do original
    *==========================================================================
    PROCEDURE GrdIncCol2When()
        RETURN INLIST(UPPER(THIS.this_cEscolha), "INSERIR", "ALTERAR")
    ENDPROC

    *==========================================================================
    * GrdIncCol2KeyPress - Valida quantidade ao sair da celula (Enter/Tab)
    * Equivalente ao Valid original: Qtds nao pode ser > xMfas.Qtds nem = 0
    * Se invalida: restaura para xMfas.Qtds (maximo permitido)
    *==========================================================================
    PROCEDURE GrdIncCol2KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_nValor, loc_nQtdMax

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        IF !PEMSTATUS(THIS, "grd_4c_Inc", 5)
            RETURN
        ENDIF

        loc_nValor = THIS.grd_4c_Inc.Column2.Text1.Value

        IF USED("xMfas") AND !EOF("xMfas")
            loc_nQtdMax = NVL(xMfas.Qtds, 0)
        ELSE
            loc_nQtdMax = 999999
        ENDIF

        IF loc_nValor > loc_nQtdMax OR loc_nValor = 0
            MsgAviso("Quantidade Inv" + CHR(225) + "lida!", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            THIS.grd_4c_Inc.Column2.Text1.Value = loc_nQtdMax
            THIS.grd_4c_Inc.Column2.Text1.Refresh
        ENDIF
    ENDPROC

    *==========================================================================
    * GrdIncCol3When - Controla edicao da Column3 (Descs - Descricao NC)
    * Equivalente a Gradeinc.Column3.Text1.When do original:
    *   Return(InList(...,'INSERIR','ALTERAR') And xNensiN.Fixos = 2)
    * Editavel SOMENTE quando modo = INSERIR/ALTERAR E xNensiN.Fixos = 2
    *==========================================================================
    PROCEDURE GrdIncCol3When()
        LOCAL loc_lModoEdicao, loc_lFixos2
        loc_lModoEdicao = INLIST(UPPER(THIS.this_cEscolha), "INSERIR", "ALTERAR")
        IF loc_lModoEdicao AND USED("xNensiN") AND !EOF("xNensiN")
            loc_lFixos2 = (NVL(xNensiN.Fixos, 0) = 2)
        ELSE
            loc_lFixos2 = .F.
        ENDIF
        RETURN (loc_lModoEdicao AND loc_lFixos2)
    ENDPROC

    *==========================================================================
    * GrdIncCol4When - Controla edicao da Column4 (Conta2s - Funcionario)
    * Equivalente a Gradeinc.Column4.Text1.When do original
    *==========================================================================
    PROCEDURE GrdIncCol4When()
        RETURN INLIST(UPPER(THIS.this_cEscolha), "INSERIR", "ALTERAR")
    ENDPROC

    *==========================================================================
    * GrdIncCol4KeyPress - Valida funcionario ao sair da celula (Enter/Tab/F4)
    * Equivalente ao Valid original de Gradeinc.Column4.Text1
    *==========================================================================
    PROCEDURE GrdIncCol4KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.ValidarFuncionario()
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarFuncionario - Valida funcionario digitado na Column4 de grd_4c_Inc
    * Equivalente ao Valid original de Gradeinc.Column4.Text1:
    *   - TmpCli e cursor local compartilhado via DataSession do form pai
    *   - Seek(valor, 'TmpCli', 'BalCodigo')
    *   - Se encontrado: atualiza celula com TmpCli.IClis
    *   - Se nao encontrado: avisa usuario e limpa celula
    *==========================================================================
    PROCEDURE ValidarFuncionario()
        LOCAL loc_cValor, loc_oErro

        IF !PEMSTATUS(THIS, "grd_4c_Inc", 5)
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(THIS.grd_4c_Inc.Column4.Text1.Value)

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        TRY
            IF !USED("TmpCli")
                RETURN
            ENDIF

            IF SEEK(loc_cValor, "TmpCli", "BalCodigo")
                *-- Encontrado: atualiza celula com IClis (codigo da conta no balancete)
                THIS.grd_4c_Inc.Column4.Text1.Value = ALLTRIM(TmpCli.IClis)
            ELSE
                *-- Nao encontrado: limpar celula e informar usuario
                MsgAviso("Funcion" + CHR(225) + "rio n" + CHR(227) + "o encontrado " + ;
                         "no cadastro de contas.", ;
                         "Busca de Funcion" + CHR(225) + "rio")
                THIS.grd_4c_Inc.Column4.Text1.Value = ""
            ENDIF

            IF PEMSTATUS(THIS, "grd_4c_Inc", 5)
                THIS.grd_4c_Inc.Refresh
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao validar Funcion" + CHR(225) + "rio: " + loc_oErro.Message, ;
                    "FormSigPdMp8.ValidarFuncionario")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormParaBO - Popula BO com estado atual dos cursores compartilhados
    * Chamado antes de operacoes que precisam do estado consolidado do BO.
    * Cursores xMfas, xNensiN e tmpnens sao compartilhados via DataSession.
    *==========================================================================
    PROCEDURE FormParaBO()
        IF VARTYPE(THIS.this_oBusinessObject) <> "O"
            RETURN
        ENDIF

        THIS.this_oBusinessObject.this_cPcEscolha = THIS.this_cEscolha

        IF USED("tmpnens") AND !EOF("tmpnens")
            SELECT tmpnens
            THIS.this_oBusinessObject.this_cNumps = ALLTRIM(NVL(numps, ""))
            THIS.this_oBusinessObject.this_cEmps  = ALLTRIM(NVL(emps,  ""))
            THIS.this_oBusinessObject.this_cDopps = ALLTRIM(NVL(dopps, ""))
        ENDIF

        IF USED("xMfas") AND !EOF("xMfas")
            SELECT xMfas
            THIS.this_oBusinessObject.this_nNopsMfa = NVL(Nops,   0)
            THIS.this_oBusinessObject.this_nNenvs   = NVL(Nenvs,  0)
            THIS.this_oBusinessObject.this_nQtdsMfa = NVL(Qtds,   0)
            THIS.this_oBusinessObject.this_cCodpds  = ALLTRIM(NVL(CodPds, ""))
        ENDIF

        IF USED("xNensiN") AND !EOF("xNensiN")
            SELECT xNensiN
            THIS.this_oBusinessObject.this_nNops    = NVL(Nops,    0)
            THIS.this_oBusinessObject.this_cCods    = ALLTRIM(NVL(Cods,    ""))
            THIS.this_oBusinessObject.this_nQtds    = NVL(Qtds,    0)
            THIS.this_oBusinessObject.this_cDescs   = ALLTRIM(NVL(Descs,   ""))
            THIS.this_oBusinessObject.this_cConta2s = ALLTRIM(NVL(Conta2s, ""))
            THIS.this_oBusinessObject.this_nFixos   = NVL(Fixos,   0)
        ENDIF
    ENDPROC

    *==========================================================================
    * BOParaForm - Atualiza controles de display com dados do BO
    * Os campos de operacao (cnt_4c_Operacao) usam ControlSource nos cursores;
    * basta um Refresh para sincronizar. Nenhuma atribuicao manual e necessaria.
    *==========================================================================
    PROCEDURE BOParaForm()
        IF PEMSTATUS(THIS, "cnt_4c_Operacao", 5)
            THIS.cnt_4c_Operacao.Refresh
        ENDIF
        IF PEMSTATUS(THIS, "grd_4c_Retrab", 5)
            THIS.grd_4c_Retrab.Refresh
        ENDIF
        IF PEMSTATUS(THIS, "grd_4c_Inc", 5)
            THIS.grd_4c_Inc.Refresh
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_Descricao", 5)
            THIS.txt_4c_Descricao.Refresh
        ENDIF
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita controles conforme modo de edicao
    * Em INSERIR/ALTERAR: grd_4c_Inc editavel, botoes de NC habilitados
    * Em VISUALIZAR: grd_4c_Inc somente leitura, botoes desabilitados
    *==========================================================================
    PROCEDURE HabilitarCampos()
        LOCAL loc_lModoEdicao
        loc_lModoEdicao = INLIST(UPPER(THIS.this_cEscolha), "INSERIR", "ALTERAR")

        IF PEMSTATUS(THIS, "grd_4c_Inc", 5)
            THIS.grd_4c_Inc.ReadOnly = !loc_lModoEdicao
        ENDIF

        IF PEMSTATUS(THIS, "cmdg_4c_Compo", 5)
            THIS.cmdg_4c_Compo.Buttons(1).Enabled = loc_lModoEdicao
            THIS.cmdg_4c_Compo.Buttons(2).Enabled = loc_lModoEdicao
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa a grade de NCs da OP corrente e reseta o campo de desc
    * Utilizado ao selecionar nova OP ou ao cancelar edicao.
    * NAO limpa xNensiN inteiro (e cursor do form pai); apenas posiciona no topo.
    *==========================================================================
    PROCEDURE LimparCampos()
        IF USED("xNensiN")
            SELECT xNensiN
            GO TOP
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_Descricao", 5)
            THIS.txt_4c_Descricao.Refresh
        ENDIF

        IF PEMSTATUS(THIS, "grd_4c_Inc", 5)
            THIS.grd_4c_Inc.Refresh
        ENDIF
    ENDPROC

    *==========================================================================
    * CarregarLista - Recarrega/atualiza ambos os grids (alias de CarregarGradeRetrab)
    * Chamado quando e necessario recarregar o estado visual dos grids.
    *==========================================================================
    PROCEDURE CarregarLista()
        THIS.CarregarGradeRetrab()
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes de NC conforme this_cEscolha
    * Chamado em mudancas de modo (apos BtnAlterarClick / BtnVisualizarClick).
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lModoEdicao
        loc_lModoEdicao = INLIST(UPPER(THIS.this_cEscolha), "INSERIR", "ALTERAR")

        IF PEMSTATUS(THIS, "cmdg_4c_Compo", 5)
            THIS.cmdg_4c_Compo.Buttons(1).Enabled = loc_lModoEdicao
            THIS.cmdg_4c_Compo.Buttons(2).Enabled = loc_lModoEdicao
        ENDIF

        IF PEMSTATUS(THIS, "grd_4c_Inc", 5)
            THIS.grd_4c_Inc.ReadOnly = !loc_lModoEdicao
            THIS.grd_4c_Inc.Refresh
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Refiltra grd_4c_Inc pela OP corrente em grd_4c_Retrab
    * Equivalente a navegar na GradeRetrab: dispara filtragem de xNensiN por Nops
    * e atualiza o grid de NCs sem precisar alterar a selecao do grid de OPs.
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        IF !USED("xNensiN") OR !USED("xMfas")
            RETURN
        ENDIF

        SELECT xNensiN
        SET KEY TO xMfas.Nops
        GO TOP

        IF PEMSTATUS(THIS, "grd_4c_Inc", 5)
            THIS.grd_4c_Inc.Refresh
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_Descricao", 5)
            THIS.txt_4c_Descricao.Refresh
        ENDIF

        SELECT xMfas
        THIS.Refresh
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Habilita o form pai e encerra este sub-dialog
    * Identico a BtnOkClick - forma padronizada de saida do sub-dialog.
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        IF VARTYPE(THIS.this_oFormPai) = "O"
            THIS.this_oFormPai.Enabled = .T.
        ENDIF
        THIS.Release
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Consolida estado final e encerra sub-dialog
    * Em forms operacionais sem transacao explicita, confirma as edicoes
    * feitas diretamente no cursor xNensiN (datasession compartilhada)
    * e retorna ao form pai com os dados ja aplicados.
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.FormParaBO()

        IF PEMSTATUS(THIS, "grd_4c_Inc", 5)
            THIS.grd_4c_Inc.Refresh
        ENDIF

        IF VARTYPE(THIS.this_oFormPai) = "O"
            THIS.this_oFormPai.Enabled = .T.
        ENDIF

        THIS.Release
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Reverte edicoes pendentes no cursor xNensiN e encerra
    * Se em modo ALTERAR, reverte as alteracoes no buffer do cursor compartilhado
    * antes de retornar ao form pai, preservando o estado anterior.
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        LOCAL loc_oErro

        TRY
            IF INLIST(UPPER(THIS.this_cEscolha), "INSERIR", "ALTERAR") AND USED("xNensiN")
                SELECT xNensiN
                TABLEREVERT(.T., "xNensiN")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao cancelar edi" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message, ;
                    "FormSigPdMp8.BtnCancelarClick")
        ENDTRY

        IF VARTYPE(THIS.this_oFormPai) = "O"
            THIS.this_oFormPai.Enabled = .T.
        ENDIF

        THIS.Release
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPdMp8BO.prg):
*==============================================================================
* SigPdMp8BO.prg - Business Object para Relacao de OPs com Nao-Conformidades
* Subformulario para vincular nao-conformidades (SigCdNcf) a OPs de retrabalho
* Herda de BusinessBase
*==============================================================================
DEFINE CLASS SigPdMp8BO AS BusinessBase

    *-- Dados da Operacao selecionada no pai (cursor tmpnens)
    this_cNumps    = ""   && OP number (tmpnens.numps, mask 9999999999)
    this_cEmps     = ""   && Empresa (tmpnens.emps)
    this_cDopps    = ""   && Descricao da operacao (tmpnens.dopps)

    *-- Dados da OP de Retrabalho selecionada (cursor xMfas)
    this_nNopsMfa  = 0    && Numero da OP (xMfas.Nops)
    this_nNenvs    = 0    && Numero do envelope (xMfas.nenvs)
    this_nQtdsMfa  = 0    && Quantidade da OP (xMfas.Qtds)
    this_cCodpds   = ""   && Codigo do produto (xMfas.CodPds)
    this_cDpros    = ""   && Descricao do produto (SigCdPro.DPros)
    this_cFigJpgs  = ""   && Imagem base64 do produto (SigCdPro.FigJpgs)

    *-- Dados da Nao-Conformidade atual (cursor xNensiN)
    this_nNops     = 0    && Numero da OP vinculada (xNensiN.Nops)
    this_cCods     = ""   && Codigo da nao-conformidade (xNensiN.Cods)
    this_nQtds     = 0    && Quantidade com nao-conformidade (xNensiN.Qtds)
    this_cDescs    = ""   && Descricao da nao-conformidade (xNensiN.Descs)
    this_cConta2s  = ""   && Codigo do funcionario responsavel (xNensiN.Conta2s)
    this_nFixos    = 0    && Flag fixo: 2=editavel descricao (xNensiN.Fixos)

    *-- Estado interno do subformulario
    this_cAntValue  = ""   && Valor anterior do campo Cods (anti-loop Valid)
    this_cPcEscolha = ""   && Modo do form pai: INSERIR ou ALTERAR

    *==========================================================================
    * Init - Configura tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        THIS.this_cTabela     = "xNensiN"
        THIS.this_cCampoChave = "Nops"
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna Nops do registro corrente de xNensiN
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ""
        IF USED("xNensiN")
            SELECT xNensiN
            loc_cChave = TRANSFORM(NVL(Nops, 0))
        ENDIF
        RETURN loc_cChave
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de alias de cursor
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nNops    = NVL(Nops,    0)
            THIS.this_cCods    = ALLTRIM(NVL(Cods,    ""))
            THIS.this_nQtds    = NVL(Qtds,    0)
            THIS.this_cDescs   = ALLTRIM(NVL(Descs,   ""))
            THIS.this_cConta2s = ALLTRIM(NVL(Conta2s, ""))
            THIS.this_nFixos   = NVL(Fixos,   0)
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *==========================================================================
    * ValidarDados - Valida dados minimos antes de inserir/atualizar
    *==========================================================================
    PROTECTED FUNCTION ValidarDados()
        IF THIS.this_nNops <= 0
            MsgAviso("O n" + CHR(250) + "mero da OP deve ser informado.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDFUNC

    *==========================================================================
    * ExecutarInsercao - INSERT no cursor VFP xNensiN (replica cmdSInserir.Click)
    *==========================================================================
    PROTECTED FUNCTION ExecutarInsercao()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("xNensiN")
                INSERT INTO xNensiN (Nops, Qtds) VALUES (THIS.this_nNops, THIS.this_nQtdsMfa)
                loc_lSucesso = .T.
            ELSE
                MsgErro("Cursor xNensiN n" + CHR(227) + "o est" + CHR(225) + " aberto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inserir NC")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ExecutarAtualizacao - REPLACE completo no cursor VFP xNensiN
    *==========================================================================
    PROTECTED FUNCTION ExecutarAtualizacao()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("xNensiN")
                SELECT xNensiN
                REPLACE Cods    WITH THIS.this_cCods,    ;
                        Qtds    WITH THIS.this_nQtds,    ;
                        Fixos   WITH THIS.this_nFixos,   ;
                        Descs   WITH THIS.this_cDescs,   ;
                        Conta2s WITH THIS.this_cConta2s  ;
                        IN xNensiN
                loc_lSucesso = .T.
            ELSE
                MsgErro("Cursor xNensiN n" + CHR(227) + "o est" + CHR(225) + " aberto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao atualizar NC")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ExecutarExclusao - DELETE no cursor VFP xNensiN (replica cmdSexcluir.Click)
    *==========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("xNensiN")
                SELECT xNensiN
                DELETE
                loc_lSucesso = .T.
            ELSE
                MsgErro("Cursor xNensiN n" + CHR(227) + "o est" + CHR(225) + " aberto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao excluir NC")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * BuscarNcf - Busca NCs em SigCdNcf via SQL Server, indexa cursor por Cods
    * Retorna .T. se par_cCods encontrado (carrega this_cDescs e this_nFixos)
    *         .F. se nao encontrado (form deve abrir FormBuscaAuxiliar)
    *==========================================================================
    FUNCTION BuscarNcf(par_cCods, par_cEmps)
        LOCAL loc_lEncontrado, loc_cSQL, loc_nRet, loc_oErro
        loc_lEncontrado = .F.
        TRY
            loc_cSQL = "SELECT Cods, Descs, Fixos FROM SigCdNcf" + ;
                       " WHERE Emps = " + EscaparSQL(par_cEmps) + ;
                       " OR Emps = ' '"

            IF USED("cursor_4c_Ncf")
                TABLEREVERT(.T., "cursor_4c_Ncf")
                USE IN cursor_4c_Ncf
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ncf")
            IF loc_nRet < 1
                MsgErro("Falha ao buscar N" + CHR(227) + "o-Conformidades (SigCdNcf)", "Erro")
            ELSE
                SELECT cursor_4c_Ncf
                INDEX ON Cods TAG Cods
                IF !EMPTY(par_cCods) AND SEEK(par_cCods)
                    THIS.this_cCods  = ALLTRIM(NVL(cursor_4c_Ncf.Cods,  ""))
                    THIS.this_cDescs = ALLTRIM(NVL(cursor_4c_Ncf.Descs, ""))
                    THIS.this_nFixos = NVL(cursor_4c_Ncf.Fixos, 0)
                    loc_lEncontrado  = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar N" + CHR(227) + "o-Conformidade")
        ENDTRY
        RETURN loc_lEncontrado
    ENDFUNC

    *==========================================================================
    * BuscarProduto - Consulta SigCdPro para descricao e imagem do produto
    * Resultado em this_cDpros e this_cFigJpgs
    *==========================================================================
    PROCEDURE BuscarProduto(par_cCodPds)
        LOCAL loc_cSQL, loc_nRet, loc_oErro
        THIS.this_cDpros   = ""
        THIS.this_cFigJpgs = ""
        TRY
            loc_cSQL = "SELECT DPros, FigJpgs FROM SigCdPro WHERE CPros = " + ;
                       EscaparSQL(par_cCodPds)

            IF USED("cursor_4c_Produto")
                TABLEREVERT(.T., "cursor_4c_Produto")
                USE IN cursor_4c_Produto
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Produto")
            IF loc_nRet > 0 AND !EOF("cursor_4c_Produto")
                SELECT cursor_4c_Produto
                THIS.this_cDpros   = ALLTRIM(NVL(DPros,   ""))
                THIS.this_cFigJpgs = NVL(FigJpgs, "")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar produto")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AtualizarNcfNoCursor - REPLACE Fixos e Descs no registro corrente de xNensiN
    * Chamado apos selecao/validacao de NC para sincronizar campos relacionados
    *==========================================================================
    PROCEDURE AtualizarNcfNoCursor(par_cCods, par_nFixos, par_cDescs)
        LOCAL loc_oErro
        TRY
            IF USED("xNensiN")
                SELECT xNensiN
                REPLACE Fixos WITH par_nFixos, ;
                        Descs WITH par_cDescs  ;
                        IN xNensiN
                THIS.this_nFixos = par_nFixos
                THIS.this_cDescs = par_cDescs
                THIS.this_cCods  = par_cCods
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao atualizar NC no cursor")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ContarNcsPorNops - Conta registros NC nao-deletados para a OP par_nNops
    * Retorna 0 se nenhuma NC restante (gatilho para auto-inserir apos Excluir)
    *==========================================================================
    FUNCTION ContarNcsPorNops(par_nNops)
        LOCAL loc_nTotal, loc_oErro
        loc_nTotal = 0
        TRY
            IF USED("xNensiN")
                SELECT xNensiN
                SET ORDER TO Nops
                SET KEY TO par_nNops
                COUNT TO loc_nTotal
                SET KEY TO
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao contar NCs")
        ENDTRY
        RETURN loc_nTotal
    ENDFUNC

ENDDEFINE

