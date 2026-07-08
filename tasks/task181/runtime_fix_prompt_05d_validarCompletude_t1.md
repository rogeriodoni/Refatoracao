# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[FormSigPrEtq.prg] Procedure vazia (sem codigo): BOParaForm
[FormSigPrEtq.prg] Procedure vazia (sem codigo): AjustarBotoesPorModo

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrEtq.prg):
*==============================================================================
* FormSigPrEtq.prg - Impressao de Etiquetas Selecionadas
*==============================================================================
* Herda de: FormBase
* Tipo: OPERACIONAL - Layout customizado, cursor local dbImpressao
* BO: SigPrEtqBO (sem tabela principal - cursor local)
* Original: tasks/task181/SigPrEtq_form_codigo_fonte.txt
*==============================================================================

DEFINE CLASS FormSigPrEtq AS FormBase

    *-- Dimensoes e aparencia exatas do original SIGPRETQ (Width=833, Height=700)
    Width       = 833
    Height      = 700
    AutoCenter  = .T.
    BorderStyle = 2
    TitleBar    = 0
    ShowWindow = 1
    WindowType = 1
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    Movable     = .T.
    DataSession = 2
    ShowTips    = .T.
    FontName    = "Tahoma"
    FontSize    = 8

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Rastreia coluna anterior no grid (AfterRowColChange)
    this_nColAnt = 0

    *--------------------------------------------------------------------------
    * Init - Cria BO e inicializa form via DODEFAULT()
    * DODEFAULT() chama FormBase.Init() que chama InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_oBusinessObject = CREATEOBJECT("SigPrEtqBO")
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Chamado por FormBase.Init()
    * Cria cursor local dbImpressao e configura estrutura visual base
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            *-- Fundo do form (new_background.jpg como no original)
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            *-- Criar cursor local dbImpressao (estrutura identica ao legado)
            IF USED("dbImpressao")
                USE IN dbImpressao
            ENDIF

            SET NULL ON
            CREATE CURSOR dbImpressao ;
                (Cpros       C(14)   NULL, ;
                 DPros       C(40)   NULL, ;
                 Reffs       C(40)   NULL, ;
                 Qtds        N(10,3) NULL, ;
                 QtdeEtiq    N(10,3) NULL, ;
                 Pedido      C(30)   NULL, ;
                 Obs         C(10)   NULL, ;
                 PVens       N(12,2) NULL, ;
                 PrecoDe     N(12,2) NULL, ;
                 Parcelas    N(2,0)  NULL, ;
                 Cpros2      C(14)   NULL, ;
                 Cpros3      C(14)   NULL, ;
                 Cpros4      C(14)   NULL, ;
                 empos       C(3)    NULL, ;
                 empdopnums  C(29)   NULL, ;
                 citens      N(10,0) NULL, ;
                 Pesos       N(12,2) NULL, ;
                 CodTams     C(4)    NULL, ;
                 DPro2s      C(45)   NULL)
            SET NULL OFF
            SET DELETED ON

            INDEX ON Cpros   TAG Cpros
            INDEX ON RECNO() TAG Registros
            SET ORDER TO
            APPEND BLANK

            *-- Estrutura visual: cabecalho cinza + todos os controles do form plano
            THIS.ConfigurarPageFrame()
            THIS.ConfigurarPaginaLista()
            THIS.ConfigurarPaginaDados()
            THIS.CarregarTiposEtiqueta()
            THIS.CarregarImpressoras()

            *-- BINDEVENT grid: AfterRowColChange para lookup de colunas
            BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")

            *-- BINDEVENT Opt_Preco: ao mudar opcao de preco, toggle Parcelas
            BINDEVENT(THIS.obj_4c_Opt_Preco, "InteractiveChange", THIS, "OptPrecoInteractiveChange")

            *-- Torna controles visiveis (compensar AddObject Visible=.F. default)
            THIS.TornarControlesVisiveis(THIS)

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, ;
                    "Erro FormSigPrEtq.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Constroi o "frame" visual do form operacional:
    * cntSombra (cabecalho cinza) com labels de titulo.
    * Forms OPERACIONAIS nao usam PageFrame CRUD; este metodo agrupa a
    * estrutura fixa do topo (equivalente ao "frame" da tela), mantendo o
    * contrato do pipeline multi-fase (validacao busca "ConfigurarPageFrame").
    * Original: cntSombra Top=0, Left=0, Width=840, Height=80, BackColor=100,100,100
    * lblSombra: ForeColor=RGB(0,0,0) (sombra preta)
    * lblTitulo: ForeColor=RGB(255,255,255) (texto branco)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top       = 0
            .Left      = 0
            .Width     = THIS.Width
            .Height    = 80
            .BackStyle = 1
            .BackColor = RGB(100,100,100)
            .BorderWidth = 0

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "Impress" + CHR(227) + "o de Etiquetas Selecionadas"
                .Height    = 40
                .Left      = 10
                .Top       = 18
                .Width     = .Parent.Width
                .ForeColor = RGB(0,0,0)
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "Impress" + CHR(227) + "o de Etiquetas Selecionadas"
                .Height    = 46
                .Left      = 10
                .Top       = 17
                .Width     = .Parent.Width
                .ForeColor = RGB(255,255,255)
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * Percorre Controls E Pages (PageFrame) para garantir visibilidade
    * EXCECAO: obj_4c_Opt_Impressora permanece oculto (sobreposicao com Opt_Tipo)
    *--------------------------------------------------------------------------
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oControl) = "O"
                *-- Manter Opt_Impressora oculto (vestigial, sobrepoe Opt_Tipo)
                IF UPPER(loc_oControl.Name) = "OBJ_4C_OPT_IMPRESSORA"
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
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera BO e fecha cursor local dbImpressao
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED("dbImpressao")
            USE IN dbImpressao
        ENDIF

        IF USED("cursor_4c_ImpreV")
            USE IN cursor_4c_ImpreV
        ENDIF

        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Cria controles principais do form OPERACIONAL:
    * label titulo, grid grd_4c_Dados (7 colunas), botoes de acao e BTNREPORT
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oErro

        TRY
            *-- Label titulo da grade
            THIS.AddObject("lbl_4c_Lbl_titulo", "Label")
            WITH THIS.lbl_4c_Lbl_titulo
                .AutoSize  = .T.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = " \<Etiquetas Selecionadas "
                .Height    = 15
                .Left      = 10
                .Top       = 203
                .Width     = 138
                .ForeColor = RGB(90,90,90)
            ENDWITH

            *-- Grid principal
            THIS.AddObject("grd_4c_Dados", "Grid")
            WITH THIS.grd_4c_Dados
                .Top          = 216
                .Left         = 12
                .Width        = 818
                .Height       = 157
                .RecordMark   = .F.
                .DeleteMark   = .F.
                .FontName     = "Tahoma"
                .FontSize     = 8
                .HeaderHeight = 17
                .RowHeight    = 17
                .ScrollBars   = 2
                .ColumnCount  = 7
                .RecordSource = "dbImpressao"

                *-- Column1: Produto (cpros)
                WITH .Column1
                    .ControlSource = "dbImpressao.cpros"
                    .Width         = 110
                    .Movable       = .F.
                    .Resizable     = .F.
                    .FontName      = "Tahoma"
                    .FontSize      = 8
                    WITH .Header1
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .Caption   = "Produto"
                        .ForeColor = RGB(90,90,90)
                    ENDWITH
                    WITH .Text1
                        .FontName      = "Tahoma"
                        .FontSize      = 8
                        .BorderStyle   = 0
                        .ControlSource = "dbImpressao.cpros"
                        .Format        = "!"
                        .InputMask     = ""
                        .Margin        = 0
                        .MaxLength     = 14
                        .ForeColor     = RGB(0,0,0)
                        .BackColor     = RGB(255,255,255)
                        .Name          = "txt_4c_cpros"
                    ENDWITH
                ENDWITH

                *-- Column2: Descricao (dpros) - ColumnOrder=3
                WITH .Column2
                    .ColumnOrder   = 3
                    .ControlSource = "dbImpressao.dpros"
                    .Width         = 270
                    .Movable       = .F.
                    .Resizable     = .F.
                    .FontName      = "Tahoma"
                    .FontSize      = 8
                    WITH .Header1
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
                        .ForeColor = RGB(90,90,90)
                    ENDWITH
                    WITH .Text1
                        .FontName      = "Tahoma"
                        .FontSize      = 8
                        .BorderStyle   = 0
                        .ControlSource = "dbImpressao.dpros"
                        .Margin        = 0
                        .ForeColor     = RGB(0,0,0)
                        .BackColor     = RGB(255,255,255)
                        .Name          = "txt_4c_dpros"
                    ENDWITH
                ENDWITH

                *-- Column3: Quantidade (qtds) - ColumnOrder=4
                WITH .Column3
                    .ColumnOrder   = 4
                    .ControlSource = "dbImpressao.qtds"
                    .Width         = 65
                    .Movable       = .F.
                    .Resizable     = .F.
                    .FontName      = "Tahoma"
                    .FontSize      = 8
                    WITH .Header1
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .Caption   = "Quantidade"
                        .ForeColor = RGB(90,90,90)
                    ENDWITH
                    WITH .Text1
                        .FontName      = "Tahoma"
                        .FontSize      = 8
                        .BorderStyle   = 0
                        .ControlSource = "dbImpressao.qtds"
                        .Format        = "999,999.99"
                        .InputMask     = "999,999.99"
                        .Margin        = 0
                        .MaxLength     = 10
                        .ForeColor     = RGB(0,0,0)
                        .BackColor     = RGB(255,255,255)
                        .Name          = "txt_4c_qtds"
                    ENDWITH
                ENDWITH

                *-- Column4: Ref.Fornecedor display=DPro2s, edicao=reffs - ColumnOrder=2
                WITH .Column4
                    .ColumnOrder   = 2
                    .ControlSource = "dbImpressao.Dpro2s"
                    .Width         = 135
                    .FontName      = "Tahoma"
                    .FontSize      = 8
                    WITH .Header1
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .Caption   = "Refer" + CHR(234) + "ncia Fornecedor"
                        .ForeColor = RGB(90,90,90)
                    ENDWITH
                    WITH .Text1
                        .FontName      = "Tahoma"
                        .FontSize      = 8
                        .BorderStyle   = 0
                        .ControlSource = "dbImpressao.reffs"
                        .Format        = "!"
                        .Margin        = 0
                        .ForeColor     = RGB(0,0,0)
                        .BackColor     = RGB(255,255,255)
                        .Name          = "txt_4c_reffs"
                    ENDWITH
                ENDWITH

                *-- Column5: Parcelas (par)
                WITH .Column5
                    .ControlSource = "dbImpressao.parcelas"
                    .Width         = 60
                    .Movable       = .F.
                    .Resizable     = .F.
                    .FontName      = "Tahoma"
                    .FontSize      = 8
                    WITH .Header1
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .Caption   = "Parcelas"
                        .ForeColor = RGB(90,90,90)
                    ENDWITH
                    WITH .Text1
                        .FontName    = "Tahoma"
                        .FontSize    = 8
                        .BorderStyle = 0
                        .Margin      = 0
                        .ForeColor   = RGB(0,0,0)
                        .BackColor   = RGB(255,255,255)
                        .Name        = "txt_4c_par"
                    ENDWITH
                ENDWITH

                *-- Column6: Preco (PVens) - somente leitura
                WITH .Column6
                    .ControlSource = "dbImpressao.PVens"
                    .Enabled       = .F.
                    .Width         = 70
                    .Movable       = .F.
                    .Resizable     = .F.
                    .ReadOnly      = .T.
                    .FontName      = "Tahoma"
                    .FontSize      = 8
                    WITH .Header1
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .Caption   = "Pre" + CHR(231) + "o"
                        .ForeColor = RGB(90,90,90)
                    ENDWITH
                    WITH .Text1
                        .FontName    = "Tahoma"
                        .FontSize    = 8
                        .BorderStyle = 0
                        .Enabled     = .F.
                        .Margin      = 0
                        .ReadOnly    = .T.
                        .ForeColor   = RGB(0,0,0)
                        .BackColor   = RGB(255,255,255)
                        .Name        = "txt_4c_Pvens"
                    ENDWITH
                ENDWITH

                *-- Column7: Preco De (PrecoDe) - somente leitura
                WITH .Column7
                    .ControlSource = "dbImpressao.PrecoDe"
                    .Enabled       = .F.
                    .Width         = 70
                    .Movable       = .F.
                    .Resizable     = .F.
                    .ReadOnly      = .T.
                    .FontName      = "Tahoma"
                    .FontSize      = 8
                    WITH .Header1
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .Caption   = "Pre" + CHR(231) + "o De"
                        .ForeColor = RGB(90,90,90)
                    ENDWITH
                    WITH .Text1
                        .FontName    = "Tahoma"
                        .FontSize    = 8
                        .BorderStyle = 0
                        .Enabled     = .F.
                        .Margin      = 0
                        .ReadOnly    = .T.
                        .ForeColor   = RGB(0,0,0)
                        .BackColor   = RGB(255,255,255)
                        .Name        = "txt_4c_precode"
                    ENDWITH
                ENDWITH
            ENDWITH

            *-- Botao Excluir item da grade
            THIS.AddObject("cmd_4c_Btnexcluir", "CommandButton")
            WITH THIS.cmd_4c_Btnexcluir
                .Top             = 374
                .Left            = 21
                .Height          = 26
                .Width           = 26
                .Caption         = ""
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .Themes          = .T.
                .ToolTipText     = "Excluir item"
                .FontName        = "Tahoma"
                .FontSize        = 8
            ENDWITH
            BINDEVENT(THIS.cmd_4c_Btnexcluir, "Click", THIS, "BtnExcluirClick")

            *-- Botao Carregar itens da movimentacao
            THIS.AddObject("cmd_4c_BtnCarregar", "CommandButton")
            WITH THIS.cmd_4c_BtnCarregar
                .Top             = 159
                .Left            = 373
                .Height          = 26
                .Width           = 26
                .Caption         = ""
                .Picture         = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
                .Themes          = .T.
                .FontName        = "Tahoma"
                .FontSize        = 8
            ENDWITH
            BINDEVENT(THIS.cmd_4c_BtnCarregar, "Click", THIS, "BtnCarregarClick")

            *-- CommandGroup BTNREPORT: Imprimir + Encerrar
            THIS.AddObject("obj_4c_BTNREPORT", "CommandGroup")
            WITH THIS.obj_4c_BTNREPORT
                .ButtonCount = 2
                .BackStyle   = 0
                .BorderStyle = 0
                .Height      = 85
                .Left        = 676
                .Top         = -2
                .Width       = 161
                .AutoSize    = .T.

                WITH .Buttons(1)
                    .Top        = 5
                    .Left       = 5
                    .Height     = 75
                    .Width      = 75
                    .FontBold   = .T.
                    .FontItalic = .T.
                    .WordWrap   = .T.
                    .Picture    = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
                    .Caption    = "\<Imprimir"
                    .ForeColor  = RGB(90,90,90)
                    .BackColor  = RGB(255,255,255)
                    .Themes     = .F.
                    .Name       = "Imprime"
                ENDWITH

                WITH .Buttons(2)
                    .Top        = 5
                    .Left       = 81
                    .Height     = 75
                    .Width      = 75
                    .FontBold   = .T.
                    .FontItalic = .T.
                    .FontName   = "Comic Sans MS"
                    .FontSize   = 8
                    .WordWrap   = .T.
                    .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                    .Cancel     = .T.
                    .Caption    = "Encerrar"
                    .ForeColor  = RGB(90,90,90)
                    .BackColor  = RGB(255,255,255)
                    .Themes     = .F.
                    .Name       = "Sair"
                ENDWITH
            ENDWITH
            BINDEVENT(THIS.obj_4c_BTNREPORT.Buttons(1), "Click", THIS, "BtnImprimeClick")
            BINDEVENT(THIS.obj_4c_BTNREPORT.Buttons(2), "Click", THIS, "BtnSairClick")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, ;
                    "Erro FormSigPrEtq.ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Form OPERACIONAL sem PageFrame; sempre retorna .T.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimeClick - Imprime etiquetas selecionadas via BO.ImprimirEtiquetas
    * Reordena dbImpressao conforme OptOrdem antes de chamar SigOpEtq
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimeClick()
        LOCAL loc_lSucesso, loc_oErro, loc_lContinuar

        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            IF !MsgConfirma("Confirma a Impress" + CHR(227) + "o de Etiquetas ?")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                *-- Reordenar dbImpressao: remove Qtds<=0 e ordena conforme opcao
                SELECT * FROM dbImpressao WHERE 0=1 INTO CURSOR cursor_4c_Ordenado READWRITE

                SELECT dbImpressao
                DELETE FROM dbImpressao WHERE Qtds <= 0

                IF THIS.obj_4c_OptOrdem.Value = 1
                    SET ORDER TO Cpros
                ELSE
                    SET ORDER TO Registros
                ENDIF

                SELECT dbImpressao
                SCAN
                    SCATTER MEMVAR MEMO
                    INSERT INTO cursor_4c_Ordenado FROM MEMVAR
                ENDSCAN

                ZAP IN dbImpressao
                SET ORDER TO

                SELECT cursor_4c_Ordenado
                SCAN
                    SCATTER MEMVAR MEMO
                    INSERT INTO dbImpressao FROM MEMVAR
                ENDSCAN

                IF USED("cursor_4c_Ordenado")
                    USE IN cursor_4c_Ordenado
                ENDIF

                *-- Transfere parametros dos controles para o BO
                THIS.FormParaBO()

                IF THIS.this_oBusinessObject.ImprimirEtiquetas()
                    MsgInfo("Impress" + CHR(227) + "o Conclu" + CHR(237) + "da!!!")

                    THIS.txt_4c_Lpreco.Value  = ""
                    THIS.txt_4c_LPreco2.Value = ""

                    SELECT dbImpressao
                    ZAP
                    APPEND BLANK
                    THIS.grd_4c_Dados.SetFocus
                    THIS.grd_4c_Dados.col_4c_cpros.SetFocus
                ENDIF
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, ;
                    "Erro FormSigPrEtq.BtnImprimeClick")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Encerra o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Exclui o item corrente da grade dbImpressao
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oErro

        TRY
            SELECT dbImpressao
            DELETE
            LOCATE FOR .F.

            SELECT dbImpressao
            GO TOP IN dbImpressao
            IF EOF("dbImpressao")
                APPEND BLANK IN dbImpressao
            ENDIF
            GO TOP IN dbImpressao

            THIS.grd_4c_Dados.Refresh()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, ;
                    "Erro FormSigPrEtq.BtnExcluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCarregarClick - Carrega itens da movimentacao na grade dbImpressao
    *--------------------------------------------------------------------------
    PROCEDURE BtnCarregarClick()
        LOCAL loc_lSucesso, loc_oErro, loc_nItens, loc_lContinuar

        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            *-- Validar campos obrigatorios (controles criados na Fase 5)
            IF EMPTY(THIS.txt_4c_Emps.Value)
                MsgAviso("A Empresa N" + CHR(227) + "o Foi Informada!!!")
                THIS.txt_4c_Emps.SetFocus
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar AND EMPTY(THIS.txt_4c_Dopes.Value)
                MsgAviso("A Opera" + CHR(231) + CHR(227) + "o N" + CHR(227) + "o Foi Informada!!!")
                THIS.txt_4c_Dopes.SetFocus
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar AND EMPTY(THIS.txt_4c_Numes.Value)
                MsgAviso("O C" + CHR(243) + "digo N" + CHR(227) + "o Foi Informado!!!")
                THIS.txt_4c_Numes.SetFocus
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                *-- Verificar se ja existem etiquetas na grade e confirmar substituicao
                SELECT Cpros FROM dbImpressao WHERE !EMPTY(Cpros) INTO CURSOR cursor_4c_TmpDig
                IF _TALLY > 0
                    loc_lContinuar = MsgConfirma("Existem Etiquetas na Grade! " + ;
                        "Deseja Refazer a Sele" + CHR(231) + CHR(227) + "o?")
                ENDIF
                IF USED("cursor_4c_TmpDig")
                    USE IN cursor_4c_TmpDig
                ENDIF
            ENDIF

            IF loc_lContinuar
                ZAP IN dbImpressao

                loc_nItens = THIS.this_oBusinessObject.CarregarPorMovimentacao( ;
                    THIS.txt_4c_Emps.Value, ;
                    THIS.txt_4c_Dopes.Value, ;
                    THIS.txt_4c_Numes.Value, ;
                    (THIS.chk_4c_ChkOperacoes.Value = 1))

                IF loc_nItens <= 0
                    MsgAviso("A Opera" + CHR(231) + CHR(227) + "o Informada N" + CHR(227) + ;
                             "o Possui It" + CHR(234) + "ns a Serem Carregados!!!")
                    THIS.txt_4c_Emps.SetFocus
                ELSE
                    *-- Aplicar lista de precos por item se preenchida e nao em modo chkLista
                    IF THIS.chk_4c_ChkLista.Value <> 1 AND !EMPTY(THIS.txt_4c_Lpreco.Value)
                        SELECT dbImpressao
                        SCAN
                            IF !EMPTY(dbImpressao.Cpros)
                                THIS.this_oBusinessObject.AplicarListaPrecoNoItem( ;
                                    THIS.txt_4c_Lpreco.Value, ;
                                    ALLTRIM(dbImpressao.Cpros))
                            ENDIF
                        ENDSCAN
                    ENDIF
                ENDIF

                SELECT dbImpressao
                IF RECCOUNT("dbImpressao") = 0
                    APPEND BLANK IN dbImpressao
                ENDIF
                GO TOP IN dbImpressao

                THIS.grd_4c_Dados.Refresh()
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, ;
                    "Erro FormSigPrEtq.BtnCarregarClick")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Cria controles de filtros/parametros (Parte 1):
    * Secao Lista de Precos, Movimentacoes e Tipo de Etiqueta
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oErro

        TRY
            *-- Secao Lista de Precos (Top 86-130)
            THIS.AddObject("lbl_4c_Label2", "Label")
            WITH THIS.lbl_4c_Label2
                .AutoSize  = .T.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = " \<Lista de Pre" + CHR(231) + "os "
                .Height    = 15
                .Left      = 20
                .Top       = 86
                .Width     = 93
                .ForeColor = RGB(90,90,90)
            ENDWITH

            THIS.AddObject("chk_4c_ChkLista", "CheckBox")
            WITH THIS.chk_4c_ChkLista
                .AutoSize  = .T.
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "Carrega " + CHR(205) + "tens"
                .Height    = 15
                .Left      = 24
                .Top       = 102
                .Width     = 85
                .Value     = 1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90,90,90)
            ENDWITH

            THIS.AddObject("txt_4c_Lpreco", "TextBox")
            WITH THIS.txt_4c_Lpreco
                .Format    = "K!"
                .Height    = 22
                .Left      = 132
                .Top       = 105
                .Width     = 294
                .Value     = ""
                .MaxLength = 30
                .FontName  = "Tahoma"
                .FontSize  = 8
            ENDWITH
            BINDEVENT(THIS.txt_4c_Lpreco, "KeyPress", THIS, "TxtLprecoKeyPress")

            THIS.AddObject("txt_4c_LPreco2", "TextBox")
            WITH THIS.txt_4c_LPreco2
                .Format    = "K!"
                .Height    = 22
                .Left      = 132
                .Top       = 128
                .Width     = 294
                .Value     = ""
                .MaxLength = 30
                .FontName  = "Tahoma"
                .FontSize  = 8
            ENDWITH
            BINDEVENT(THIS.txt_4c_LPreco2, "KeyPress", THIS, "TxtLPreco2KeyPress")

            *-- Secao Movimentacoes (Top 154-195)
            THIS.AddObject("lbl_4c_Label4", "Label")
            WITH THIS.lbl_4c_Label4
                .AutoSize  = .T.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Movimenta" + CHR(231) + CHR(245) + "es"
                .Height    = 15
                .Left      = 20
                .Top       = 154
                .Width     = 92
                .ForeColor = RGB(90,90,90)
            ENDWITH

            THIS.AddObject("chk_4c_ChkOperacoes", "CheckBox")
            WITH THIS.chk_4c_ChkOperacoes
                .AutoSize  = .T.
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "Carrega " + CHR(205) + "tens"
                .Height    = 15
                .Left      = 24
                .Top       = 169
                .Width     = 85
                .Value     = 1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90,90,90)
            ENDWITH

            THIS.AddObject("lbl_4c_Label5", "Label")
            WITH THIS.lbl_4c_Label5
                .AutoSize  = .T.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Emp"
                .Height    = 15
                .Left      = 132
                .Top       = 161
                .Width     = 26
                .ForeColor = RGB(90,90,90)
            ENDWITH

            THIS.AddObject("lbl_4c_Label6", "Label")
            WITH THIS.lbl_4c_Label6
                .AutoSize  = .T.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
                .Height    = 15
                .Left      = 165
                .Top       = 161
                .Width     = 86
                .ForeColor = RGB(90,90,90)
            ENDWITH

            THIS.AddObject("lbl_4c_Label7", "Label")
            WITH THIS.lbl_4c_Label7
                .AutoSize  = .T.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "C" + CHR(243) + "digo"
                .Height    = 15
                .Left      = 317
                .Top       = 161
                .Width     = 40
                .ForeColor = RGB(90,90,90)
            ENDWITH

            THIS.AddObject("txt_4c_Emps", "TextBox")
            WITH THIS.txt_4c_Emps
                .Format    = "K!"
                .Height    = 23
                .Left      = 132
                .Top       = 174
                .Width     = 31
                .Value     = ""
                .MaxLength = 3
                .FontName  = "Tahoma"
                .FontSize  = 8
            ENDWITH
            BINDEVENT(THIS.txt_4c_Emps, "KeyPress", THIS, "TxtEmpsKeyPress")

            THIS.AddObject("txt_4c_Dopes", "TextBox")
            WITH THIS.txt_4c_Dopes
                .Format    = "K!"
                .Height    = 23
                .Left      = 165
                .Top       = 174
                .Width     = 150
                .Value     = ""
                .MaxLength = 20
                .FontName  = "Tahoma"
                .FontSize  = 8
            ENDWITH
            BINDEVENT(THIS.txt_4c_Dopes, "KeyPress", THIS, "TxtDopesKeyPress")

            THIS.AddObject("txt_4c_Numes", "TextBox")
            WITH THIS.txt_4c_Numes
                .Alignment = 3
                .Value     = 0
                .Format    = "K"
                .Height    = 23
                .InputMask = "999999"
                .Left      = 317
                .MaxLength = 6
                .Top       = 174
                .Width     = 52
                .FontName  = "Tahoma"
                .FontSize  = 8
            ENDWITH

            *-- Secao Tipo de Etiqueta (Top 415-615)
            THIS.AddObject("shp_4c_Shape3", "Shape")
            WITH THIS.shp_4c_Shape3
                .Top           = 431
                .Left          = 260
                .Width         = 254
                .Height        = 106
                .BackStyle     = 0
                .BorderWidth   = 1
                .SpecialEffect = 1
            ENDWITH

            THIS.AddObject("lbl_4c_Label1", "Label")
            WITH THIS.lbl_4c_Label1
                .AutoSize  = .T.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = " Tipo de Etiqueta "
                .Height    = 15
                .Left      = 23
                .Top       = 415
                .Width     = 99
                .ForeColor = RGB(90,90,90)
            ENDWITH

            *-- Opt_Tipo: ButtonCount=1 provisorio; CarregarTiposEtiqueta() re-popula
            THIS.AddObject("obj_4c_Opt_Tipo", "OptionGroup")
            WITH THIS.obj_4c_Opt_Tipo
                .ButtonCount   = 1
                .BackStyle     = 0
                .Value         = 1
                .Height        = 182
                .Left          = 13
                .SpecialEffect = 1
                .Top           = 431
                .Width         = 240
                .Themes        = .F.
                WITH .Buttons(1)
                    .AutoSize  = .F.
                    .Width     = 197
                    .Caption   = " \<a. Rabicho"
                    .ForeColor = RGB(90,90,90)
                    .Top       = 10
                    .BackStyle = 0
                    .Height    = 16
                    .Left      = 9
                ENDWITH
            ENDWITH

            *-- Container Impressora (Cnt_Impressora: Top=539, Left=260, 254x74)
            THIS.AddObject("cnt_4c__Impressora", "Container")
            WITH THIS.cnt_4c__Impressora
                .Top         = 539
                .Left        = 260
                .Width       = 254
                .Height      = 74
                .BackStyle   = 0
                .BorderWidth = 0

                *-- Opcao impressora: Allegro / Zebra ZPL / Zebra EPL
                .AddObject("obj_4c_Opcao_imp", "OptionGroup")
                WITH .obj_4c_Opcao_imp
                    .AutoSize    = .F.
                    .ButtonCount = 3
                    .Height      = 24
                    .Left        = 5
                    .Top         = 3
                    .Width       = 241
                    WITH .Buttons(1)
                        .AutoSize  = .T.
                        .BackStyle = 0
                        .Caption   = "Allegro"
                        .ForeColor = RGB(90,90,90)
                        .Left      = 2
                        .Top       = 4
                        .Width     = 51
                    ENDWITH
                    WITH .Buttons(2)
                        .AutoSize  = .T.
                        .BackStyle = 0
                        .Caption   = "Zebra ZPL"
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .ForeColor = RGB(90,90,90)
                        .Left      = 75
                        .Top       = 4
                        .Width     = 66
                    ENDWITH
                    WITH .Buttons(3)
                        .AutoSize  = .T.
                        .BackStyle = 0
                        .Caption   = "Zebra EPL"
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .ForeColor = RGB(90,90,90)
                        .Height    = 15
                        .Left      = 164
                        .Top       = 4
                        .Width     = 66
                    ENDWITH
                ENDWITH

                *-- Labels de ajuste
                .AddObject("lbl_4c_LblSay2", "Label")
                WITH .lbl_4c_LblSay2
                    .AutoSize  = .F.
                    .FontName  = "Tahoma"
                    .FontSize  = 7
                    .BackStyle = 0
                    .Caption   = "Vertical"
                    .Height    = 13
                    .Left      = 10
                    .Top       = 29
                    .Width     = 33
                    .ForeColor = RGB(90,90,90)
                ENDWITH

                .AddObject("lbl_4c_LblSay3", "Label")
                WITH .lbl_4c_LblSay3
                    .AutoSize  = .F.
                    .FontName  = "Tahoma"
                    .FontSize  = 7
                    .BackStyle = 0
                    .Caption   = "Horizontal"
                    .Height    = 13
                    .Left      = 69
                    .Top       = 29
                    .Width     = 43
                    .ForeColor = RGB(90,90,90)
                ENDWITH

                .AddObject("lbl_4c_LblSay1", "Label")
                WITH .lbl_4c_LblSay1
                    .AutoSize  = .F.
                    .FontName  = "Tahoma"
                    .FontSize  = 7
                    .BackStyle = 0
                    .Caption   = "Densidade"
                    .Height    = 13
                    .Left      = 128
                    .Top       = 29
                    .Width     = 55
                    .ForeColor = RGB(90,90,90)
                ENDWITH

                .AddObject("lbl_4c_LblSay20", "Label")
                WITH .lbl_4c_LblSay20
                    .AutoSize  = .F.
                    .FontName  = "Tahoma"
                    .FontSize  = 7
                    .BackStyle = 0
                    .Caption   = "Velocidade"
                    .Height    = 13
                    .Left      = 188
                    .Top       = 30
                    .Width     = 55
                    .ForeColor = RGB(90,90,90)
                ENDWITH

                *-- Spinners de ajuste
                .AddObject("obj_4c_Spn_AjVerts", "Spinner")
                WITH .obj_4c_Spn_AjVerts
                    .FontName          = "Tahoma"
                    .Height            = 26
                    .KeyboardHighValue = 999
                    .KeyboardLowValue  = 0
                    .Left              = 10
                    .SpinnerHighValue  = 999
                    .SpinnerLowValue   = 0
                    .Top               = 42
                    .Width             = 56
                    .Value             = 0
                ENDWITH

                .AddObject("obj_4c_Spn_AjHorzs", "Spinner")
                WITH .obj_4c_Spn_AjHorzs
                    .FontName          = "Tahoma"
                    .Height            = 26
                    .KeyboardHighValue = 999
                    .KeyboardLowValue  = -999
                    .Left              = 69
                    .SpinnerHighValue  = 999
                    .SpinnerLowValue   = -999
                    .Top               = 42
                    .Width             = 56
                    .Value             = 0
                ENDWITH

                .AddObject("obj_4c_Spn_AjDenss", "Spinner")
                WITH .obj_4c_Spn_AjDenss
                    .FontName          = "Tahoma"
                    .Height            = 26
                    .KeyboardHighValue = 20
                    .KeyboardLowValue  = 1
                    .Left              = 128
                    .SpinnerHighValue  = 20
                    .SpinnerLowValue   = 1
                    .Top               = 42
                    .Width             = 56
                    .Value             = 20
                ENDWITH

                .AddObject("obj_4c_Spn_AjVelos", "Spinner")
                WITH .obj_4c_Spn_AjVelos
                    .FontName          = "Tahoma"
                    .Height            = 26
                    .KeyboardHighValue = 3
                    .KeyboardLowValue  = 1
                    .Left              = 188
                    .SpinnerHighValue  = 3
                    .SpinnerLowValue   = 1
                    .Top               = 42
                    .Width             = 54
                    .Value             = 3
                ENDWITH
            ENDWITH

            *-- Label "Impressora" (acima do container)
            THIS.AddObject("lbl_4c_LblLabel3", "Label")
            WITH THIS.lbl_4c_LblLabel3
                .AutoSize  = .T.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = " Impressora "
                .Height    = 15
                .Left      = 271
                .Top       = 415
                .Width     = 74
                .ForeColor = RGB(90,90,90)
            ENDWITH

            *-- Opt_Impressora (Visible=.F. - vestigial, sobrepoe Opt_Tipo)
            THIS.AddObject("obj_4c_Opt_Impressora", "OptionGroup")
            WITH THIS.obj_4c_Opt_Impressora
                .AutoSize      = .F.
                .ButtonCount   = 1
                .BackStyle     = 0
                .Value         = 1
                .Height        = 47
                .Left          = 260
                .SpecialEffect = 1
                .Top           = 431
                .Width         = 254
                .Themes        = .F.
                .Visible       = .F.
                WITH .Buttons(1)
                    .AutoSize  = .F.
                    .BackStyle = 0
                    .Caption   = "Gen" + CHR(233) + "rico/Somente Texto"
                    .ForeColor = RGB(36,84,155)
                    .Height    = 16
                    .Left      = 9
                    .Style     = 0
                    .Top       = 52
                    .Width     = 210
                ENDWITH
            ENDWITH

            *-- Labels "Sistema" e "Windows" (acima do Get_Printer)
            THIS.AddObject("lbl_4c_Label12", "Label")
            WITH THIS.lbl_4c_Label12
                .AutoSize  = .T.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Sistema"
                .Height    = 15
                .Left      = 270
                .Top       = 437
                .Width     = 48
                .ForeColor = RGB(90,90,90)
            ENDWITH

            THIS.AddObject("lbl_4c_Label13", "Label")
            WITH THIS.lbl_4c_Label13
                .AutoSize  = .T.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Windows"
                .Height    = 15
                .Left      = 383
                .Top       = 437
                .Width     = 52
                .ForeColor = RGB(90,90,90)
            ENDWITH

            *-- ComboBox Get_Printer (populado em CarregarImpressoras)
            THIS.AddObject("cbo_4c_Get_Printer", "ComboBox")
            WITH THIS.cbo_4c_Get_Printer
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Height        = 23
                .Left          = 268
                .SpecialEffect = 1
                .Style         = 2
                .Top           = 453
                .Width         = 239
                .BoundColumn   = 1
                .BoundTo       = .F.
                .RowSourceType = 0
                .RowSource     = ""
                .ColumnCount   = 1
                .ColumnWidths  = "239"
            ENDWITH
            BINDEVENT(THIS.cbo_4c_Get_Printer, "InteractiveChange", THIS, "CboGetPrinterInteractiveChange")

            *-- Separadora (label + OptionGroup)
            THIS.AddObject("lbl_4c_Lbl_Separador", "Label")
            WITH THIS.lbl_4c_Lbl_Separador
                .AutoSize  = .T.
                .FontBold  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Separadora :"
                .Height    = 15
                .Left      = 532
                .Top       = 417
                .Width     = 65
                .ForeColor = RGB(90,90,90)
            ENDWITH

            THIS.AddObject("obj_4c_Opt_separador", "OptionGroup")
            WITH THIS.obj_4c_Opt_separador
                .AutoSize      = .F.
                .ButtonCount   = 2
                .BackStyle     = 0
                .Value         = 1
                .Height        = 25
                .Left          = 601
                .SpecialEffect = 1
                .Top           = 412
                .Width         = 198
                .Themes        = .F.
                WITH .Buttons(1)
                    .AutoSize  = .T.
                    .BackStyle = 0
                    .Caption   = "Sim"
                    .ForeColor = RGB(90,90,90)
                    .Height    = 15
                    .Left      = 5
                    .Top       = 5
                    .Width     = 34
                ENDWITH
                WITH .Buttons(2)
                    .AutoSize  = .T.
                    .BackStyle = 0
                    .Caption   = "N" + CHR(227) + "o"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(90,90,90)
                    .Height    = 15
                    .Left      = 70
                    .Top       = 5
                    .Width     = 37
                ENDWITH
            ENDWITH

            *-- Preco (label + OptionGroup 6 botoes)
            THIS.AddObject("lbl_4c_Label8", "Label")
            WITH THIS.lbl_4c_Label8
                .AutoSize  = .T.
                .FontBold  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Pre" + CHR(231) + "o :"
                .Height    = 15
                .Left      = 561
                .Top       = 440
                .Width     = 36
                .ForeColor = RGB(90,90,90)
            ENDWITH

            THIS.AddObject("obj_4c_Opt_Preco", "OptionGroup")
            WITH THIS.obj_4c_Opt_Preco
                .AutoSize      = .F.
                .ButtonCount   = 6
                .BackStyle     = 0
                .Value         = 1
                .Height        = 95
                .Left          = 601
                .SpecialEffect = 1
                .Top           = 439
                .Width         = 198
                .Themes        = .F.
                WITH .Buttons(1)
                    .AutoSize  = .T.
                    .BackStyle = 0
                    .Caption   = "Sim"
                    .ForeColor = RGB(90,90,90)
                    .Height    = 15
                    .Left      = 8
                    .Top       = 7
                    .Width     = 34
                ENDWITH
                WITH .Buttons(2)
                    .AutoSize  = .T.
                    .BackStyle = 0
                    .Caption   = "N" + CHR(227) + "o"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(90,90,90)
                    .Height    = 15
                    .Left      = 61
                    .Top       = 7
                    .Width     = 37
                ENDWITH
                WITH .Buttons(3)
                    .AutoSize  = .T.
                    .BackStyle = 0
                    .Caption   = "Ideal"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(90,90,90)
                    .Height    = 15
                    .Left      = 8
                    .Top       = 28
                    .Width     = 42
                ENDWITH
                WITH .Buttons(4)
                    .AutoSize  = .T.
                    .BackStyle = 0
                    .Caption   = "Atual"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(90,90,90)
                    .Height    = 15
                    .Left      = 61
                    .Top       = 28
                    .Width     = 43
                ENDWITH
                WITH .Buttons(5)
                    .AutoSize  = .T.
                    .BackStyle = 0
                    .Caption   = "Pre" + CHR(231) + "o DE \ Por"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(90,90,90)
                    .Height    = 15
                    .Left      = 8
                    .Top       = 51
                    .Width     = 87
                ENDWITH
                WITH .Buttons(6)
                    .AutoSize  = .T.
                    .BackStyle = 0
                    .Caption   = "Parcelamento"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(90,90,90)
                    .Height    = 15
                    .Left      = 8
                    .Top       = 73
                    .Width     = 83
                ENDWITH
            ENDWITH

            *-- Peso (label + OptionGroup)
            THIS.AddObject("lbl_4c_Label9", "Label")
            WITH THIS.lbl_4c_Label9
                .AutoSize  = .T.
                .FontBold  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Peso :"
                .Height    = 15
                .Left      = 565
                .Top       = 540
                .Width     = 32
                .ForeColor = RGB(90,90,90)
            ENDWITH

            THIS.AddObject("obj_4c_Opt_peso", "OptionGroup")
            WITH THIS.obj_4c_Opt_peso
                .AutoSize      = .F.
                .ButtonCount   = 2
                .BackStyle     = 0
                .Value         = 1
                .Height        = 25
                .Left          = 601
                .SpecialEffect = 1
                .Top           = 535
                .Width         = 198
                .Themes        = .F.
                WITH .Buttons(1)
                    .AutoSize  = .F.
                    .BackStyle = 0
                    .Caption   = "Sim"
                    .ForeColor = RGB(90,90,90)
                    .Height    = 15
                    .Left      = 5
                    .Top       = 5
                    .Width     = 41
                ENDWITH
                WITH .Buttons(2)
                    .AutoSize  = .F.
                    .BackStyle = 0
                    .Caption   = "N" + CHR(227) + "o"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(90,90,90)
                    .Height    = 15
                    .Left      = 70
                    .Top       = 5
                    .Width     = 41
                ENDWITH
            ENDWITH

            *-- Composicao (label + OptionGroup)
            THIS.AddObject("lbl_4c_Label10", "Label")
            WITH THIS.lbl_4c_Label10
                .AutoSize  = .T.
                .FontBold  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Composi" + CHR(231) + CHR(227) + "o :"
                .Height    = 15
                .Left      = 531
                .Top       = 567
                .Width     = 66
                .ForeColor = RGB(90,90,90)
            ENDWITH

            THIS.AddObject("obj_4c_OptCompos", "OptionGroup")
            WITH THIS.obj_4c_OptCompos
                .AutoSize      = .F.
                .ButtonCount   = 2
                .BackStyle     = 0
                .Value         = 1
                .Height        = 25
                .Left          = 601
                .SpecialEffect = 1
                .Top           = 562
                .Width         = 198
                .Themes        = .F.
                WITH .Buttons(1)
                    .AutoSize  = .F.
                    .BackStyle = 0
                    .Caption   = "Sim"
                    .ForeColor = RGB(90,90,90)
                    .Height    = 15
                    .Left      = 5
                    .Top       = 5
                    .Width     = 41
                ENDWITH
                WITH .Buttons(2)
                    .AutoSize  = .F.
                    .BackStyle = 0
                    .Caption   = "N" + CHR(227) + "o"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(90,90,90)
                    .Height    = 15
                    .Left      = 70
                    .Top       = 5
                    .Width     = 41
                ENDWITH
            ENDWITH

            *-- Ordem (label + OptionGroup)
            THIS.AddObject("lbl_4c_Label11", "Label")
            WITH THIS.lbl_4c_Label11
                .AutoSize  = .T.
                .FontBold  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Ordem :"
                .Height    = 15
                .Left      = 556
                .Top       = 594
                .Width     = 41
                .ForeColor = RGB(90,90,90)
            ENDWITH

            THIS.AddObject("obj_4c_OptOrdem", "OptionGroup")
            WITH THIS.obj_4c_OptOrdem
                .AutoSize      = .F.
                .ButtonCount   = 2
                .BackStyle     = 0
                .Value         = 1
                .Height        = 25
                .Left          = 601
                .SpecialEffect = 1
                .Top           = 589
                .Width         = 198
                .Themes        = .F.
                WITH .Buttons(1)
                    .AutoSize  = .T.
                    .BackStyle = 0
                    .Caption   = "Produto"
                    .ForeColor = RGB(90,90,90)
                    .Height    = 15
                    .Left      = 5
                    .Top       = 4
                    .Width     = 56
                ENDWITH
                WITH .Buttons(2)
                    .AutoSize  = .T.
                    .BackStyle = 0
                    .Caption   = "Nenhuma"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(90,90,90)
                    .Height    = 15
                    .Left      = 70
                    .Top       = 4
                    .Width     = 63
                ENDWITH
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, ;
                    "Erro FormSigPrEtq.ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarTiposEtiqueta - Popula obj_4c_Opt_Tipo dinamicamente via SigCdTpe
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarTiposEtiqueta()
        LOCAL loc_oErro, loc_lSucesso, loc_nTipos, loc_nI, loc_nTop, loc_nHeight

        loc_lSucesso = .F.
        loc_nI      = 1
        loc_nTop    = 10
        loc_nHeight = 15

        TRY
            IF SQLEXEC(gnConnHandle, ;
                "SELECT nTipos, RTRIM(cEtiquetas) AS cEtiquetas " + ;
                "FROM SigCdTpe WHERE nSituas = 1 ORDER BY cOrdems, cEtiquetas", ;
                "cursor_4c_TiposEti") > 0

                SELECT cursor_4c_TiposEti
                loc_nTipos = RECCOUNT("cursor_4c_TiposEti")

                IF loc_nTipos > 0
                    WITH THIS.obj_4c_Opt_Tipo
                        .ButtonCount = loc_nTipos
                        SELECT cursor_4c_TiposEti
                        GO TOP IN cursor_4c_TiposEti
                        DO WHILE !EOF("cursor_4c_TiposEti")
                            WITH .Buttons(loc_nI)
                                .AutoSize  = .F.
                                .Width     = 197
                                .Caption   = " \<" + CHR(96 + loc_nI) + ". " + ;
                                             ALLTRIM(cursor_4c_TiposEti.cEtiquetas)
                                .ForeColor = RGB(90,90,90)
                                .Tag       = ALLTRIM(STR(cursor_4c_TiposEti.nTipos))
                                .Top       = loc_nTop
                                .BackStyle = 0
                                .Height    = 16
                                .Left      = 9
                            ENDWITH
                            loc_nI      = loc_nI + 1
                            loc_nTop    = loc_nTop + 20
                            loc_nHeight = loc_nHeight + 20
                            SKIP IN cursor_4c_TiposEti
                        ENDDO
                        .Height = loc_nHeight
                        .Value  = 1
                    ENDWITH
                ENDIF

                IF USED("cursor_4c_TiposEti")
                    USE IN cursor_4c_TiposEti
                ENDIF
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, ;
                    "Erro FormSigPrEtq.CarregarTiposEtiqueta")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtLprecoKeyPress - KeyPress do campo Lista de Precos principal
    *--------------------------------------------------------------------------
    PROCEDURE TxtLprecoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.AbrirBuscaLPreco(THIS.txt_4c_Lpreco)
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtLPreco2KeyPress - KeyPress do campo Lista de Precos adicional
    *--------------------------------------------------------------------------
    PROCEDURE TxtLPreco2KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.AbrirBuscaLPreco(THIS.txt_4c_LPreco2)
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaLPreco - Lookup SigCdLpc; se txt_4c_Lpreco + chkLista=1 carrega itens
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaLPreco(par_oTxt)
        LOCAL loc_oLookup, loc_oErro, loc_cValor, loc_lSucesso, loc_lEncontrado, loc_nRet

        loc_lSucesso  = .F.
        loc_lEncontrado = .F.

        TRY
            loc_cValor = ALLTRIM(par_oTxt.Value)

            *-- Tenta match exato
            IF !EMPTY(loc_cValor)
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 RTRIM(LPrecos) AS LPrecos FROM SigCdLpc " + ;
                    "WHERE RTRIM(LPrecos) = " + EscaparSQL(loc_cValor), ;
                    "cursor_4c_ChkLpc")
                IF loc_nRet > 0 AND !EOF("cursor_4c_ChkLpc")
                    par_oTxt.Value = ALLTRIM(cursor_4c_ChkLpc.LPrecos)
                    loc_lEncontrado = .T.
                    IF UPPER(par_oTxt.Name) = "TXT_4C_LPRECO" AND ;
                       THIS.chk_4c_ChkLista.Value = 1
                        THIS.CarregarItensListaPreco(par_oTxt.Value)
                    ENDIF
                ENDIF
                IF USED("cursor_4c_ChkLpc")
                    USE IN cursor_4c_ChkLpc
                ENDIF
            ENDIF

            *-- Match nao encontrado: abre picker
            IF !loc_lEncontrado
                loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdLpc", ;
                    "cursor_4c_BuscaLpc", "LPrecos", loc_cValor, ;
                    "Sele" + CHR(231) + CHR(227) + "o", .T., .T., "")
                IF VARTYPE(loc_oLookup) = "O"
                    loc_oLookup.mAddColuna("LPrecos", "", "Lista de Pre" + CHR(231) + "os")
                    loc_oLookup.Show()
                    IF loc_oLookup.this_lSelecionou
                        par_oTxt.Value = ALLTRIM(cursor_4c_BuscaLpc.LPrecos)
                        IF UPPER(par_oTxt.Name) = "TXT_4C_LPRECO" AND ;
                           THIS.chk_4c_ChkLista.Value = 1
                            THIS.CarregarItensListaPreco(par_oTxt.Value)
                        ENDIF
                    ENDIF
                    IF USED("cursor_4c_BuscaLpc")
                        USE IN cursor_4c_BuscaLpc
                    ENDIF
                ENDIF
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, ;
                    "Erro FormSigPrEtq.AbrirBuscaLPreco")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarItensListaPreco - Popula dbImpressao com itens de SigCdLpi
    * Verifica validade do preco; se expirado, busca preco atual em SigCdPro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarItensListaPreco(par_cLPreco)
        LOCAL loc_oErro, loc_lSucesso, loc_cSQL, loc_nPVens, loc_nPrecoDe, loc_nRetPro

        loc_lSucesso = .F.

        TRY
            ZAP IN dbImpressao

            loc_cSQL = "SELECT RTRIM(a.LPrecos) AS LPrecos, RTRIM(a.CPros) AS Cpros, " + ;
                       "RTRIM(a.DPros) AS DPros, a.PVens, a.Precode AS PrecoDe, " + ;
                       "a.VencIs, a.VencFs " + ;
                       "FROM SigCdLpi a " + ;
                       "WHERE RTRIM(a.LPrecos) = " + EscaparSQL(par_cLPreco)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LpreI") > 0
                SELECT cursor_4c_LpreI
                SCAN
                    loc_nPVens   = cursor_4c_LpreI.PVens
                    loc_nPrecoDe = cursor_4c_LpreI.PrecoDe

                    *-- Se preco da lista expirou, usa preco atual do produto
                    IF !BETWEEN(DATETIME(), cursor_4c_LpreI.VencIs, cursor_4c_LpreI.VencFs)
                        loc_nRetPro = SQLEXEC(gnConnHandle, ;
                            "SELECT TOP 1 PVens, PrecoDe FROM SigCdPro " + ;
                            "WHERE RTRIM(CPros) = " + ;
                            EscaparSQL(ALLTRIM(cursor_4c_LpreI.Cpros)), ;
                            "cursor_4c_LproPro")
                        IF loc_nRetPro > 0 AND !EOF("cursor_4c_LproPro")
                            loc_nPVens   = cursor_4c_LproPro.PVens
                            loc_nPrecoDe = cursor_4c_LproPro.PrecoDe
                        ENDIF
                        IF USED("cursor_4c_LproPro")
                            USE IN cursor_4c_LproPro
                        ENDIF
                    ENDIF

                    INSERT INTO dbImpressao ;
                        (Cpros, DPros, Qtds, QtdeEtiq, Obs, PVens, empos, PrecoDe) ;
                    VALUES ;
                        (cursor_4c_LpreI.Cpros, cursor_4c_LpreI.DPros, 1, 1, ;
                         PADR(par_cLPreco, 10), loc_nPVens, ;
                         go_4c_Sistema.cCodEmpresa, loc_nPrecoDe)
                ENDSCAN

                IF USED("cursor_4c_LpreI")
                    USE IN cursor_4c_LpreI
                ENDIF
            ENDIF

            SELECT dbImpressao
            IF RECCOUNT("dbImpressao") = 0
                APPEND BLANK IN dbImpressao
            ENDIF
            GO TOP IN dbImpressao
            THIS.grd_4c_Dados.Refresh()

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, ;
                    "Erro FormSigPrEtq.CarregarItensListaPreco")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtEmpsKeyPress - KeyPress do campo Empresa
    *--------------------------------------------------------------------------
    PROCEDURE TxtEmpsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.AbrirBuscaEmps()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaEmps - Lookup Empresa (SigCdEmp -> Cemps + Razas)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaEmps()
        LOCAL loc_oLookup, loc_oErro, loc_cValor, loc_lSucesso, loc_lEncontrado, loc_nRet

        loc_lSucesso  = .F.
        loc_lEncontrado = .F.

        TRY
            loc_cValor = ALLTRIM(THIS.txt_4c_Emps.Value)

            *-- Tenta match exato
            IF !EMPTY(loc_cValor)
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 RTRIM(Cemps) AS Cemps FROM SigCdEmp " + ;
                    "WHERE RTRIM(Cemps) = " + EscaparSQL(loc_cValor), ;
                    "cursor_4c_ChkEmp")
                IF loc_nRet > 0 AND !EOF("cursor_4c_ChkEmp")
                    THIS.txt_4c_Emps.Value = ALLTRIM(cursor_4c_ChkEmp.Cemps)
                    loc_lEncontrado = .T.
                ENDIF
                IF USED("cursor_4c_ChkEmp")
                    USE IN cursor_4c_ChkEmp
                ENDIF
            ENDIF

            *-- Abre picker se nao encontrou match exato
            IF !loc_lEncontrado
                loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdEmp", ;
                    "cursor_4c_BuscaEmp", "Cemps", loc_cValor, ;
                    "Sele" + CHR(231) + CHR(227) + "o de Empresa", .T., .T., "")
                IF VARTYPE(loc_oLookup) = "O"
                    loc_oLookup.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                    loc_oLookup.mAddColuna("Razas", "", "Empresa")
                    loc_oLookup.Show()
                    IF loc_oLookup.this_lSelecionou
                        THIS.txt_4c_Emps.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                    ENDIF
                    IF USED("cursor_4c_BuscaEmp")
                        USE IN cursor_4c_BuscaEmp
                    ENDIF
                ENDIF
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, ;
                    "Erro FormSigPrEtq.AbrirBuscaEmps")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtDopesKeyPress - KeyPress do campo Operacao
    *--------------------------------------------------------------------------
    PROCEDURE TxtDopesKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.AbrirBuscaDopes()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaDopes - Lookup Operacao (SigCdOpe - single-column: Dopes = PK+descricao)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaDopes()
        LOCAL loc_oLookup, loc_oErro, loc_cValor, loc_lSucesso, loc_lEncontrado, loc_nRet

        loc_lSucesso  = .F.
        loc_lEncontrado = .F.

        TRY
            loc_cValor = ALLTRIM(THIS.txt_4c_Dopes.Value)

            *-- Tenta match exato
            IF !EMPTY(loc_cValor)
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 RTRIM(Dopes) AS Dopes FROM SigCdOpe " + ;
                    "WHERE RTRIM(Dopes) = " + EscaparSQL(loc_cValor), ;
                    "cursor_4c_ChkOpe")
                IF loc_nRet > 0 AND !EOF("cursor_4c_ChkOpe")
                    THIS.txt_4c_Dopes.Value = ALLTRIM(cursor_4c_ChkOpe.Dopes)
                    loc_lEncontrado = .T.
                ENDIF
                IF USED("cursor_4c_ChkOpe")
                    USE IN cursor_4c_ChkOpe
                ENDIF
            ENDIF

            *-- Abre picker (SigCdOpe: Dopes eh PK e descricao - coluna unica)
            IF !loc_lEncontrado
                loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdOpe", ;
                    "cursor_4c_BuscaOpe", "Dopes", loc_cValor, ;
                    "Opera" + CHR(231) + CHR(227) + "o", .T., .T., "")
                IF VARTYPE(loc_oLookup) = "O"
                    loc_oLookup.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
                    loc_oLookup.Show()
                    IF loc_oLookup.this_lSelecionou
                        THIS.txt_4c_Dopes.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
                    ENDIF
                    IF USED("cursor_4c_BuscaOpe")
                        USE IN cursor_4c_BuscaOpe
                    ENDIF
                ENDIF
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, ;
                    "Erro FormSigPrEtq.AbrirBuscaDopes")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarImpressoras - Popula cursor_4c_ImpreV com impressoras do sistema
    * e configura cbo_4c_Get_Printer
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarImpressoras()
        LOCAL loc_oErro, loc_nTotal, loc_nI, la_4c_Printers

        TRY
            IF USED("cursor_4c_ImpreV")
                USE IN cursor_4c_ImpreV
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_ImpreV (impresS C(100) NULL)
            SET NULL OFF

            DIMENSION la_4c_Printers(1, 3)
            loc_nTotal = APRINTERS(la_4c_Printers)

            IF loc_nTotal > 0
                FOR loc_nI = 1 TO loc_nTotal
                    INSERT INTO cursor_4c_ImpreV VALUES (la_4c_Printers[loc_nI, 1])
                ENDFOR
            ENDIF

            IF RECCOUNT("cursor_4c_ImpreV") = 0
                INSERT INTO cursor_4c_ImpreV VALUES ("Impressora Padr" + CHR(227) + "o")
            ENDIF

            GO TOP IN cursor_4c_ImpreV

            THIS.cbo_4c_Get_Printer.RowSourceType = 2
            THIS.cbo_4c_Get_Printer.RowSource     = "cursor_4c_ImpreV"
            THIS.cbo_4c_Get_Printer.BoundColumn   = 1
            THIS.cbo_4c_Get_Printer.BoundTo       = .F.
            THIS.cbo_4c_Get_Printer.Refresh()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, ;
                    "Erro FormSigPrEtq.CarregarImpressoras")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CboGetPrinterInteractiveChange - Ao mudar impressora, resetar ajustes
    *--------------------------------------------------------------------------
    PROCEDURE CboGetPrinterInteractiveChange()
        WITH THIS.cnt_4c__Impressora
            .obj_4c_Spn_AjVerts.Value = 0
            .obj_4c_Spn_AjHorzs.Value = 0
            .obj_4c_Spn_AjDenss.Value = 20
            .obj_4c_Spn_AjVelos.Value = 3
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdDadosAfterRowColChange - Valida coluna anterior ao mudar coluna no grid
    * par_nColIndex = nova coluna; this_nColAnt = coluna anterior
    *--------------------------------------------------------------------------
    PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)

        DO CASE
        CASE THIS.this_nColAnt = 1
            THIS.ValidarCpros()
        CASE THIS.this_nColAnt = 4
            THIS.ValidarReffs()
        CASE THIS.this_nColAnt = 2
            THIS.ValidarDpros()
        CASE THIS.this_nColAnt = 3
            THIS.ValidarQtds()
        ENDCASE

        THIS.this_nColAnt = par_nColIndex
        THIS.AtualizarEstadoColunas()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCpros - Valida/lookup do campo Produto (Column1) no grid
    * Tenta EAN13, depois CPros exato, senao abre FormBuscaAuxiliar
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCpros()
        LOCAL loc_oErro, loc_cProd, loc_nCod, loc_nRet, loc_lSucesso, loc_oBusca

        loc_lSucesso = .F.

        TRY
            IF !USED("dbImpressao") OR EOF("dbImpressao")
                RETURN
            ENDIF

            loc_cProd = ALLTRIM(NVL(dbImpressao.Cpros, ""))

            *-- Campo vazio: limpar descricao
            IF EMPTY(loc_cProd)
                THIS.grd_4c_Dados.Column2.Text1.Value = ""
                THIS.grd_4c_Dados.Refresh()
                RETURN
            ENDIF

            *-- 1. Tentar match por EAN13 (numerico inteiro)
            loc_nCod = INT(VAL(loc_cProd))
            IF loc_nCod > 0
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 RTRIM(CPros) AS Cpros, RTRIM(DPros) AS DPros, " + ;
                    "PVens, PrecoDe FROM SigCdPro " + ;
                    "WHERE Ean13 = " + FormatarNumeroSQL(loc_nCod), ;
                    "cursor_4c_PrEan")
                IF loc_nRet > 0 AND !EOF("cursor_4c_PrEan")
                    dbImpressao.Cpros = PADR(ALLTRIM(cursor_4c_PrEan.Cpros), 14)
                    dbImpressao.DPros = PADR(ALLTRIM(cursor_4c_PrEan.DPros), 40)
                    dbImpressao.PVens   = cursor_4c_PrEan.PVens
                    dbImpressao.PrecoDe = cursor_4c_PrEan.PrecoDe
                    THIS.grd_4c_Dados.Refresh()
                    IF USED("cursor_4c_PrEan")
                        USE IN cursor_4c_PrEan
                    ENDIF
                    RETURN
                ENDIF
                IF USED("cursor_4c_PrEan")
                    USE IN cursor_4c_PrEan
                ENDIF
            ENDIF

            *-- 2. Tentar match direto por CPros
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 RTRIM(CPros) AS Cpros, RTRIM(DPros) AS DPros, " + ;
                "PVens, PrecoDe FROM SigCdPro " + ;
                "WHERE RTRIM(CPros) = " + EscaparSQL(loc_cProd), ;
                "cursor_4c_PrCd")
            IF loc_nRet > 0 AND !EOF("cursor_4c_PrCd")
                dbImpressao.DPros   = PADR(ALLTRIM(cursor_4c_PrCd.DPros), 40)
                dbImpressao.PVens   = cursor_4c_PrCd.PVens
                dbImpressao.PrecoDe = cursor_4c_PrCd.PrecoDe
                THIS.grd_4c_Dados.Refresh()
                IF USED("cursor_4c_PrCd")
                    USE IN cursor_4c_PrCd
                ENDIF
                RETURN
            ENDIF
            IF USED("cursor_4c_PrCd")
                USE IN cursor_4c_PrCd
            ENDIF

            *-- 3. Nao encontrado: abrir picker de produto
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", ;
                "cursor_4c_BuscaPro", "CPros", loc_cProd, ;
                "Sele" + CHR(231) + CHR(227) + "o de Produto", .T., .T., "")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou
                    dbImpressao.Cpros = PADR(ALLTRIM(cursor_4c_BuscaPro.CPros), 14)
                    dbImpressao.DPros = PADR(ALLTRIM(cursor_4c_BuscaPro.DPros), 40)
                ENDIF
                IF USED("cursor_4c_BuscaPro")
                    USE IN cursor_4c_BuscaPro
                ENDIF
                loc_oBusca.Release()
            ENDIF

            THIS.grd_4c_Dados.Refresh()
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, ;
                    "Erro FormSigPrEtq.ValidarCpros")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDpros - Valida/lookup do campo Descricao (Column2) no grid
    * Tenta match exato por DPros; senao abre FormBuscaAuxiliar
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDpros()
        LOCAL loc_oErro, loc_cDesc, loc_nRet, loc_lSucesso, loc_oBusca

        loc_lSucesso = .F.

        TRY
            IF !USED("dbImpressao") OR EOF("dbImpressao")
                RETURN
            ENDIF

            loc_cDesc = ALLTRIM(NVL(dbImpressao.DPros, ""))

            *-- Campo vazio: limpar cpros
            IF EMPTY(loc_cDesc)
                dbImpressao.Cpros = SPACE(14)
                THIS.grd_4c_Dados.Refresh()
                RETURN
            ENDIF

            *-- Tentar match por DPros
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 RTRIM(CPros) AS Cpros, RTRIM(DPros) AS DPros " + ;
                "FROM SigCdPro WHERE RTRIM(DPros) = " + EscaparSQL(loc_cDesc), ;
                "cursor_4c_PrDp")
            IF loc_nRet > 0 AND !EOF("cursor_4c_PrDp")
                dbImpressao.Cpros = PADR(ALLTRIM(cursor_4c_PrDp.Cpros), 14)
                THIS.grd_4c_Dados.Refresh()
                IF USED("cursor_4c_PrDp")
                    USE IN cursor_4c_PrDp
                ENDIF
                RETURN
            ENDIF
            IF USED("cursor_4c_PrDp")
                USE IN cursor_4c_PrDp
            ENDIF

            *-- Nao encontrado: abrir picker por descricao
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", ;
                "cursor_4c_BuscaProD", "DPros", loc_cDesc, ;
                "Sele" + CHR(231) + CHR(227) + "o de Produto", .T., .T., "")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou
                    dbImpressao.Cpros = PADR(ALLTRIM(cursor_4c_BuscaProD.CPros), 14)
                    dbImpressao.DPros = PADR(ALLTRIM(cursor_4c_BuscaProD.DPros), 40)
                ENDIF
                IF USED("cursor_4c_BuscaProD")
                    USE IN cursor_4c_BuscaProD
                ENDIF
                loc_oBusca.Release()
            ENDIF

            THIS.grd_4c_Dados.Refresh()
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, ;
                    "Erro FormSigPrEtq.ValidarDpros")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarReffs - Valida/lookup do campo Ref.Fornecedor (Column4) no grid
    * Busca em SigCdPro por Dpro2s; preenche cpros+dpros+precos se achar
    *--------------------------------------------------------------------------
    PROCEDURE ValidarReffs()
        LOCAL loc_oErro, loc_cReff, loc_nRet, loc_lSucesso, loc_oBusca

        loc_lSucesso = .F.

        TRY
            IF !USED("dbImpressao") OR EOF("dbImpressao")
                RETURN
            ENDIF

            loc_cReff = ALLTRIM(NVL(dbImpressao.Reffs, ""))

            IF EMPTY(loc_cReff)
                RETURN
            ENDIF

            *-- Tentar match por Dpro2s (referencia do fornecedor)
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 RTRIM(CPros) AS Cpros, RTRIM(DPros) AS DPros, " + ;
                "RTRIM(DPro2s) AS DPro2s, PVens, PrecoDe " + ;
                "FROM SigCdPro WHERE RTRIM(DPro2s) = " + EscaparSQL(loc_cReff), ;
                "cursor_4c_PrRff")
            IF loc_nRet > 0 AND !EOF("cursor_4c_PrRff")
                dbImpressao.Cpros   = PADR(ALLTRIM(cursor_4c_PrRff.Cpros), 14)
                dbImpressao.DPros   = PADR(ALLTRIM(cursor_4c_PrRff.DPros), 40)
                dbImpressao.PVens   = cursor_4c_PrRff.PVens
                dbImpressao.PrecoDe = cursor_4c_PrRff.PrecoDe
                THIS.grd_4c_Dados.Refresh()
                IF USED("cursor_4c_PrRff")
                    USE IN cursor_4c_PrRff
                ENDIF
                RETURN
            ENDIF
            IF USED("cursor_4c_PrRff")
                USE IN cursor_4c_PrRff
            ENDIF

            *-- Nao encontrado: abrir picker por Dpro2s
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", ;
                "cursor_4c_BuscaRff", "DPro2s", loc_cReff, ;
                "Sele" + CHR(231) + CHR(227) + "o por Refer" + CHR(234) + "ncia", .T., .T., "")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("DPro2s", "", "Refer" + CHR(234) + "ncia")
                loc_oBusca.mAddColuna("CPros",  "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("DPros",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou
                    dbImpressao.Cpros = PADR(ALLTRIM(cursor_4c_BuscaRff.CPros),  14)
                    dbImpressao.DPros = PADR(ALLTRIM(cursor_4c_BuscaRff.DPros),  40)
                    dbImpressao.Reffs = PADR(ALLTRIM(cursor_4c_BuscaRff.DPro2s), 40)
                ENDIF
                IF USED("cursor_4c_BuscaRff")
                    USE IN cursor_4c_BuscaRff
                ENDIF
                loc_oBusca.Release()
            ENDIF

            THIS.grd_4c_Dados.Refresh()
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, ;
                    "Erro FormSigPrEtq.ValidarReffs")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarQtds - Valida campo Quantidade (Column3) no grid
    * Confirma produto valido, define QtdeEtiq e move para proxima linha
    *--------------------------------------------------------------------------
    PROCEDURE ValidarQtds()
        LOCAL loc_oErro, loc_nQtd, loc_cProd, loc_nRet, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF !USED("dbImpressao") OR EOF("dbImpressao")
                RETURN
            ENDIF

            loc_nQtd  = NVL(dbImpressao.Qtds, 0)
            loc_cProd = ALLTRIM(PADR(NVL(dbImpressao.Cpros, ""), 14))

            IF EMPTY(loc_cProd)
                RETURN
            ENDIF

            *-- Validar produto existe em SigCdPro
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 RTRIM(CPros) AS Cpros FROM SigCdPro " + ;
                "WHERE RTRIM(CPros) = " + EscaparSQL(loc_cProd), ;
                "cursor_4c_PrQt")
            IF loc_nRet <= 0 OR EOF("cursor_4c_PrQt")
                MsgAviso("Produto Inv" + CHR(225) + "lido!!!")
                IF USED("cursor_4c_PrQt")
                    USE IN cursor_4c_PrQt
                ENDIF
                RETURN
            ENDIF
            IF USED("cursor_4c_PrQt")
                USE IN cursor_4c_PrQt
            ENDIF

            *-- Definir quantidade de etiquetas igual a qtds (se maior que 0)
            IF loc_nQtd > 0
                dbImpressao.QtdeEtiq = loc_nQtd
            ENDIF

            THIS.grd_4c_Dados.Refresh()

            *-- Avancar para proxima linha (ENTER = nova linha no grid)
            SELECT dbImpressao
            IF !EOF()
                SKIP
                IF EOF()
                    APPEND BLANK
                ENDIF
            ENDIF

            THIS.grd_4c_Dados.Refresh()
            THIS.grd_4c_Dados.SetFocus

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, ;
                    "Erro FormSigPrEtq.ValidarQtds")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * OptPrecoInteractiveChange - Ao mudar opcao de Preco, atualiza Parcelas
    * Original: col_par.Text1.When = (ThisForm.opt_Preco.Value = 6)
    *--------------------------------------------------------------------------
    PROCEDURE OptPrecoInteractiveChange()
        THIS.AtualizarEstadoColunas()
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoColunas - Controla editabilidade das colunas do grid
    * Replica comportamento dos When events do original SIGPRETQ:
    *   col_cpros/dpros/DPro2s: editavel somente em linha nova (Cpros vazio)
    *   col_par (Parcelas): editavel somente com Preco = Parcelamento (Value=6)
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarEstadoColunas()
        LOCAL loc_lNovaLinha, loc_lParcelamento

        IF !USED("dbImpressao") OR EOF("dbImpressao")
            RETURN
        ENDIF

        IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
            RETURN
        ENDIF

        loc_lNovaLinha    = EMPTY(ALLTRIM(NVL(dbImpressao.Cpros, "")))
        loc_lParcelamento = (THIS.obj_4c_Opt_Preco.Value = 6)

        THIS.grd_4c_Dados.col_4c_cpros.ReadOnly  = !loc_lNovaLinha
        THIS.grd_4c_Dados.col_4c_dpros.ReadOnly  = !loc_lNovaLinha
        THIS.grd_4c_Dados.col_4c_DPro2s.ReadOnly = !loc_lNovaLinha
        THIS.grd_4c_Dados.col_4c_par.ReadOnly    = !loc_lParcelamento
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Inclui linha em branco na grade dbImpressao para
    * entrada manual de um novo produto (equivalente operacional a "novo item").
    * Reposiciona o cursor na nova linha e devolve o foco ao grid.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro

        TRY
            IF !USED("dbImpressao")
                MsgAviso("A grade de impress" + CHR(227) + "o n" + CHR(227) + ;
                         "o est" + CHR(225) + " dispon" + CHR(237) + "vel!!!")
                RETURN
            ENDIF

            SELECT dbImpressao
            SET ORDER TO

            *-- Se a grade tem apenas uma linha em branco padrao, reusa-a
            IF RECCOUNT("dbImpressao") = 1 AND EMPTY(ALLTRIM(NVL(dbImpressao.Cpros, "")))
                GO TOP IN dbImpressao
            ELSE
                APPEND BLANK IN dbImpressao
                *-- Posiciona na ultima linha (a que acabou de ser criada)
                SELECT dbImpressao
                GO BOTTOM IN dbImpressao
            ENDIF

            THIS.grd_4c_Dados.Refresh()
            THIS.AtualizarEstadoColunas()

            *-- Foca a coluna de produto para digitacao imediata
            IF PEMSTATUS(THIS.grd_4c_Dados, "col_4c_cpros", 5)
                THIS.grd_4c_Dados.SetFocus()
                THIS.grd_4c_Dados.ActivateCell( ;
                    RECNO("dbImpressao"), 1)
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, ;
                    "Erro FormSigPrEtq.BtnIncluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Ativa edicao da linha corrente do grid, permitindo
    * ajustar quantidade/etiquetas do item selecionado.
    * Foca a coluna Qtds e destrava colunas quando aplicavel.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oErro, loc_nRecno

        TRY
            IF !USED("dbImpressao") OR RECCOUNT("dbImpressao") = 0
                MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " itens na grade para alterar!!!")
                RETURN
            ENDIF

            SELECT dbImpressao
            loc_nRecno = RECNO("dbImpressao")

            IF EOF("dbImpressao") OR EMPTY(ALLTRIM(NVL(dbImpressao.Cpros, "")))
                MsgAviso("Selecione um item na grade antes de alterar!!!")
                THIS.grd_4c_Dados.SetFocus()
                RETURN
            ENDIF

            *-- Permite editar Parcelas se a modalidade Preco = Parcelamento (6)
            IF THIS.obj_4c_Opt_Preco.Value = 6
                THIS.grd_4c_Dados.col_4c_par.ReadOnly = .F.
            ENDIF

            THIS.grd_4c_Dados.Refresh()

            *-- Foca coluna de quantidade (indice 3: Cpros=1, DPros=2, Qtds=3)
            THIS.grd_4c_Dados.SetFocus()
            THIS.grd_4c_Dados.ActivateCell(loc_nRecno, 3)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, ;
                    "Erro FormSigPrEtq.BtnAlterarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Exibe resumo dos itens carregados na grade antes
    * da impressao (contagem total, distintos e quantidade agregada).
    * Equivalente operacional a "visualizar antes de imprimir".
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro, loc_nTotal, loc_nDistintos, loc_nQtdTotal, loc_cMsg

        TRY
            IF !USED("dbImpressao") OR RECCOUNT("dbImpressao") = 0
                MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " itens carregados na grade!!!")
                RETURN
            ENDIF

            loc_nTotal    = 0
            loc_nDistintos = 0
            loc_nQtdTotal = 0

            *-- Conta itens validos (Cpros preenchido)
            SELECT COUNT(*) AS nTot, ;
                   COUNT(DISTINCT Cpros) AS nDist, ;
                   SUM(NVL(QtdeEtiq, 0)) AS nQtd ;
                FROM dbImpressao ;
                WHERE !EMPTY(NVL(Cpros, "")) ;
                INTO CURSOR cursor_4c_TmpResumo

            IF USED("cursor_4c_TmpResumo") AND !EOF("cursor_4c_TmpResumo")
                loc_nTotal     = NVL(cursor_4c_TmpResumo.nTot,  0)
                loc_nDistintos = NVL(cursor_4c_TmpResumo.nDist, 0)
                loc_nQtdTotal  = NVL(cursor_4c_TmpResumo.nQtd,  0)
            ENDIF

            IF USED("cursor_4c_TmpResumo")
                USE IN cursor_4c_TmpResumo
            ENDIF

            IF loc_nTotal = 0
                MsgAviso("N" + CHR(227) + "o h" + CHR(225) + ;
                         " itens v" + CHR(225) + "lidos para impress" + CHR(227) + "o!!!")
                RETURN
            ENDIF

            loc_cMsg = "Resumo da Impress" + CHR(227) + "o de Etiquetas:" + CHR(13) + CHR(13) + ;
                       "Itens na grade....: " + TRANSFORM(loc_nTotal)     + CHR(13) + ;
                       "Produtos distintos: " + TRANSFORM(loc_nDistintos) + CHR(13) + ;
                       "Etiquetas a imprimir: " + TRANSFORM(loc_nQtdTotal, "@R 999,999,999")

            MsgInfo(loc_cMsg, "Visualizar Impress" + CHR(227) + "o")

            SELECT dbImpressao
            GO TOP IN dbImpressao
            THIS.grd_4c_Dados.Refresh()

        CATCH TO loc_oErro
            IF USED("cursor_4c_TmpResumo")
                USE IN cursor_4c_TmpResumo
            ENDIF
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, ;
                    "Erro FormSigPrEtq.BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere parametros dos controles do form para o BO
    * Chamado por BtnImprimeClick antes de ImprimirEtiquetas
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        LOCAL loc_nTipo, loc_oBO

        loc_oBO = THIS.this_oBusinessObject

        loc_oBO.this_nImpPreco     = THIS.obj_4c_Opt_Preco.Value
        loc_oBO.this_lImpSepar     = (THIS.obj_4c_Opt_separador.Value = 1)
        loc_oBO.this_lImpPeso      = (THIS.obj_4c_Opt_peso.Value = 1)
        loc_oBO.this_lCompo        = (THIS.obj_4c_OptCompos.Value = 1)

        loc_nTipo = THIS.obj_4c_Opt_Tipo.Value
        IF loc_nTipo >= 1 AND loc_nTipo <= THIS.obj_4c_Opt_Tipo.ButtonCount
            loc_oBO.this_nTipo  = loc_nTipo
            loc_oBO.this_nTpEti = INT(VAL(THIS.obj_4c_Opt_Tipo.Buttons(loc_nTipo).Tag))
        ENDIF

        loc_oBO.this_nTpImp        = THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.Value
        loc_oBO.this_nAjVertsPrint = THIS.cnt_4c__Impressora.obj_4c_Spn_AjVerts.Value
        loc_oBO.this_nAjHorzsPrint = THIS.cnt_4c__Impressora.obj_4c_Spn_AjHorzs.Value
        loc_oBO.this_nAjDensPrint  = THIS.cnt_4c__Impressora.obj_4c_Spn_AjDenss.Value
        loc_oBO.this_nAjVelosPrint = THIS.cnt_4c__Impressora.obj_4c_Spn_AjVelos.Value

        IF USED("cursor_4c_ImpreV") AND !EOF("cursor_4c_ImpreV")
            loc_oBO.this_cNomeImp = ALLTRIM(NVL(cursor_4c_ImpreV.impresS, ""))
        ELSE
            loc_oBO.this_cNomeImp = ""
        ENDIF

        loc_oBO.this_cLp1   = ALLTRIM(THIS.txt_4c_Lpreco.Value)
        loc_oBO.this_cLp2   = ALLTRIM(THIS.txt_4c_LPreco2.Value)
        loc_oBO.this_nOrdem = THIS.obj_4c_OptOrdem.Value
        loc_oBO.this_cDopes = ALLTRIM(THIS.txt_4c_Dopes.Value)
        loc_oBO.this_nNumes = THIS.txt_4c_Numes.Value
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - OPERACIONAL: BO nao carrega registros para edicao.
    * Presente para padrao do pipeline; sem acao real neste form.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        *-- OPERACIONAL: dados vem de SQL via BtnCarregarClick/CarregarItensListaPreco
        *-- Nao ha "registro corrente" do BO para carregar nos controles
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Refresca a exibicao da grade dbImpressao
    * OPERACIONAL: sem lista de cadastro; reposiciona e refresca o grid
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        IF USED("dbImpressao")
            SELECT dbImpressao
            IF RECCOUNT("dbImpressao") = 0
                APPEND BLANK IN dbImpressao
            ENDIF
            GO TOP IN dbImpressao
        ENDIF

        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa filtros de entrada e reseta grade dbImpressao
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        IF PEMSTATUS(THIS, "txt_4c_Lpreco", 5)
            THIS.txt_4c_Lpreco.Value  = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_LPreco2", 5)
            THIS.txt_4c_LPreco2.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_Emps", 5)
            THIS.txt_4c_Emps.Value    = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_Dopes", 5)
            THIS.txt_4c_Dopes.Value   = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_Numes", 5)
            THIS.txt_4c_Numes.Value   = 0
        ENDIF

        IF USED("dbImpressao")
            ZAP IN dbImpressao
            APPEND BLANK IN dbImpressao
            GO TOP IN dbImpressao
        ENDIF

        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita controles de entrada
    * OPERACIONAL: campos sempre habilitados (sem modos INCLUIR/ALTERAR)
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos()
        IF PEMSTATUS(THIS, "txt_4c_Lpreco", 5)
            THIS.txt_4c_Lpreco.Enabled = .T.
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_LPreco2", 5)
            THIS.txt_4c_LPreco2.Enabled = .T.
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_Emps", 5)
            THIS.txt_4c_Emps.Enabled = .T.
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_Dopes", 5)
            THIS.txt_4c_Dopes.Enabled = .T.
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_Numes", 5)
            THIS.txt_4c_Numes.Enabled = .T.
        ENDIF
        IF PEMSTATUS(THIS, "chk_4c_ChkLista", 5)
            THIS.chk_4c_ChkLista.Enabled = .T.
        ENDIF
        IF PEMSTATUS(THIS, "chk_4c_ChkOperacoes", 5)
            THIS.chk_4c_ChkOperacoes.Enabled = .T.
        ENDIF
        IF PEMSTATUS(THIS, "cmd_4c_BtnCarregar", 5)
        ENDIF
        IF PEMSTATUS(THIS, "cmd_4c_Btnexcluir", 5)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - OPERACIONAL: sem modos CRUD; no-op
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        *-- OPERACIONAL nao tem modos INCLUIR/ALTERAR/VISUALIZAR
        *-- Botoes sao fixos: Carregar, Excluir, Imprimir, Sair
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario (alias canonico para BtnSairClick)
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Equivalente operacional de "Buscar": carrega itens
    * da movimentacao para a grade (delega a BtnCarregarClick)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnCarregarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Equivalente operacional de "Salvar": confirma impressao
    * (delega a BtnImprimeClick para compatibilidade com pipeline)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimeClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Equivalente operacional de "Cancelar": limpa campos
    * e reseta a grade sem fechar o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        IF MsgConfirma("Limpar campos e reiniciar a grade?")
            THIS.LimparCampos()
        ENDIF
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrEtqBO.prg):
*==============================================================================
* SIGPRETQBO.PRG
* Business Object - Impressao de Etiquetas Selecionadas
* Form OPERACIONAL - cursor local dbImpressao, sem tabela principal
*==============================================================================

DEFINE CLASS SigPrEtqBO AS BusinessBase

    *-- Sem tabela principal (form operacional)
    this_cTabela       = ""
    this_cCampoChave   = ""

    *--------------------------------------------------------------------------
    * Parametros de filtro / entrada do usuario
    *--------------------------------------------------------------------------
    this_cEmps         = ""    && Empresa (3 chars)
    this_cDopes        = ""    && Operacao (20 chars)
    this_nNumes        = 0     && Numero do documento
    this_cLPrecos      = ""    && Lista de precos 1 (30 chars)
    this_cLPrecos2     = ""    && Lista de precos 2 (30 chars)

    *--------------------------------------------------------------------------
    * Configuracao da etiqueta (SigCdPam)
    *--------------------------------------------------------------------------
    this_nMaxTpEtis    = 0     && Numero maximo de tipos de etiqueta
    this_nTpEtiPads    = 0     && Tipo de etiqueta padrao
    this_nMaxImpEti    = 0     && Numero maximo de impressoras
    this_nImpEtis      = 0     && Impressora padrao
    this_cTpInstalas   = ""    && Tipo de instalacao
    this_nAjVerts      = 0     && Ajuste vertical padrao (SigCdPam)
    this_nAjHorzs      = 0     && Ajuste horizontal padrao (SigCdPam)
    this_cTpCBars      = ""    && Tipo de codigo de barras

    *--------------------------------------------------------------------------
    * Configuracao adicional (SigCdPac)
    *--------------------------------------------------------------------------
    this_nAjDens       = 20   && Ajuste de densidade padrao
    this_nAjVelos      = 1    && Ajuste de velocidade padrao
    this_nEtqSeps      = 1    && Etiqueta separadora (1=Sim, 2=Nao)

    *--------------------------------------------------------------------------
    * Opcoes de impressao (espelham controles do form)
    *--------------------------------------------------------------------------
    this_nImpPreco     = 1    && Tipo de preco a imprimir (1-6, opt_Preco.Value)
    this_lImpSepar     = .T.  && Imprimir separadora (opt_separador=1)
    this_lImpPeso      = .T.  && Imprimir peso (opt_peso=1)
    this_lCompo        = .T.  && Imprimir composicao (optCompos=1)
    this_nTipo         = 1    && Indice do tipo de etiqueta (Opt_Tipo.Value)
    this_nTpEti        = 0    && ID do tipo de etiqueta (SigCdTpe.nTipos via Tag)
    this_nTpImp        = 1    && Tipo impressora (1=Allegro, 2=Zebra ZPL, 3=Zebra EPL)
    this_nAjVertsPrint = 0    && Ajuste vertical para impressao (Spn_AjVerts.Value)
    this_nAjHorzsPrint = 0    && Ajuste horizontal para impressao (Spn_AjHorzs.Value)
    this_nAjDensPrint  = 20   && Densidade para impressao (Spn_AjDenss.Value)
    this_nAjVelosPrint = 1    && Velocidade para impressao (spn_AjVelos.Value)
    this_cNomeImp      = ""   && Nome da impressora selecionada (crImpreV.impres)
    this_nImpres       = 0    && Numero de registro da impressora (RECNO crImpreV)
    this_cLp1          = ""   && Lista de precos 1 (passada ao SigOpEtq)
    this_cLp2          = ""   && Lista de precos 2 (passada ao SigOpEtq)
    this_nOrdem        = 1    && Ordem de impressao (1=Produto, 2=Nenhuma)

    *--------------------------------------------------------------------------
    * Campos do cursor dbImpressao (linha corrente)
    *--------------------------------------------------------------------------
    this_cReffs        = ""    && Referencia do fornecedor (dbImpressao.Reffs)
    this_nQtds         = 0     && Quantidade (dbImpressao.Qtds)
    this_nQtdeEtiq     = 0     && Quantidade de etiquetas (dbImpressao.QtdeEtiq)
    this_cPedido       = ""    && Numero do pedido (dbImpressao.Pedido)
    this_cObs          = ""    && Obs / lista de precos usada (dbImpressao.Obs)
    this_nParcelas     = 0     && Numero de parcelas (dbImpressao.Parcelas)
    this_cCpros2       = ""    && Codigo produto 2 (dbImpressao.Cpros2)
    this_cCpros3       = ""    && Codigo produto 3 (dbImpressao.Cpros3)
    this_cCpros4       = ""    && Codigo produto 4 (dbImpressao.Cpros4)
    this_cEmpos        = ""    && Empresa (dbImpressao.empos)
    this_cEmpdopnums   = ""    && Chave emp+ope+num (dbImpressao.empdopnums)
    this_nCitens       = 0     && Numero do item (dbImpressao.citens)
    this_nPesos        = 0     && Peso do item (dbImpressao.Pesos)
    this_cCodTams      = ""    && Codigo do tamanho (dbImpressao.CodTams)

    *--------------------------------------------------------------------------
    * Produto corrente (validado no grid)
    *--------------------------------------------------------------------------
    this_cCpros        = ""   && Codigo do produto (SigCdPro.CPros)
    this_cDpros        = ""   && Descricao do produto (SigCdPro.DPros)
    this_cDpro2s       = ""   && Referencia do fornecedor (SigCdPro.Dpro2s)
    this_cCunis        = ""   && Unidade do produto (SigCdPro.CUnis)
    this_nPVens        = 0    && Preco de venda (SigCdPro.PVens)
    this_nPrecoDe      = 0    && Preco De (SigCdPro.PrecoDe)
    this_nPesoMs       = 0    && Peso do produto (SigCdPro.PesoMs)

    *--------------------------------------------------------------------------
    * INIT - Configura BO sem tabela principal (form operacional)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            DODEFAULT()

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrEtqBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarConfiguracao - Carrega SigCdPam e SigCdPac
    * Retorna: .T. se carregado com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE CarregarConfiguracao()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT nMaxTpEtis, TpEtiPads, nMaxImpEti, ImpEtis, " + ;
                       "TpInstalas, AjVerts, AjHorzs, TpCBars " + ;
                       "FROM SigCdPam"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPam") > 0
                IF !EOF("cursor_4c_SigCdPam")
                    SELECT cursor_4c_SigCdPam
                    THIS.this_nMaxTpEtis  = NVL(nMaxTpEtis, 7)
                    THIS.this_nTpEtiPads  = NVL(TpEtiPads,  1)
                    THIS.this_nMaxImpEti  = NVL(nMaxImpEti, 5)
                    THIS.this_nImpEtis    = NVL(ImpEtis,    1)
                    THIS.this_cTpInstalas = NVL(TpInstalas, "")
                    THIS.this_nAjVerts    = NVL(AjVerts,    0)
                    THIS.this_nAjHorzs    = NVL(AjHorzs,    0)
                    THIS.this_cTpCBars    = NVL(TpCBars,    "")

                    THIS.this_nAjVertsPrint = THIS.this_nAjVerts
                    THIS.this_nAjHorzsPrint = THIS.this_nAjHorzs
                ENDIF
                USE IN cursor_4c_SigCdPam
            ENDIF

            loc_cSQL = "SELECT AjDens, AjVelos, EtqSeps FROM SigCdPac"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPac") > 0
                IF !EOF("cursor_4c_SigCdPac")
                    SELECT cursor_4c_SigCdPac
                    THIS.this_nAjDens   = IIF(EMPTY(NVL(AjDens,  0)), 20, NVL(AjDens,  0))
                    THIS.this_nAjVelos  = IIF(EMPTY(NVL(AjVelos, 0)), 1,  NVL(AjVelos, 0))
                    THIS.this_nEtqSeps  = NVL(EtqSeps, 1)

                    THIS.this_nAjDensPrint  = THIS.this_nAjDens
                    THIS.this_nAjVelosPrint = THIS.this_nAjVelos
                ENDIF
                USE IN cursor_4c_SigCdPac
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro CarregarConfiguracao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarTiposEtiqueta - Carrega SigCdTpe em cursor cursor_4c_TiposEti
    * Retorna: numero de tipos encontrados (0 se nenhum)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarTiposEtiqueta()
        LOCAL loc_nTipos, loc_oErro, loc_cSQL

        loc_nTipos = 0

        TRY
            loc_cSQL = "SELECT nTipos, cEtiquetas, cOrdems, nSituas " + ;
                       "FROM SigCdTpe WHERE nSituas = 1 ORDER BY cOrdems"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TiposEti") > 0
                loc_nTipos = _TALLY
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro CarregarTiposEtiqueta")
            loc_nTipos = 0
        ENDTRY

        RETURN loc_nTipos
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarImpressoras - Carrega impressoras disponiveis para o usuario
    * Popula cursor_4c_ImpTemp com campo Impres C(50)
    * Retorna: .T. se carregado com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE CarregarImpressoras()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cUsuario

        loc_lSucesso = .F.

        TRY
            loc_cUsuario = EscaparSQL(gc_4c_UsuarioLogado)

            loc_cSQL = "SELECT b.Impres FROM SigSyImp a " + ;
                       "INNER JOIN SigCdmp b ON a.CImps = b.Impres " + ;
                       "WHERE a.UsuAcess = " + loc_cUsuario + ;
                       " AND b.nTpImpres = 2 " + ;
                       "UNION ALL " + ;
                       "SELECT c.Impres FROM SigCdAcG a " + ;
                       "INNER JOIN SigSyImp b ON a.Grupos = b.GrAcess " + ;
                       "INNER JOIN SigCdmp c ON b.CImps = c.Impres " + ;
                       "WHERE a.Usuarios = " + loc_cUsuario + ;
                       " AND c.nTpImpres = 2"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImpTemp") <= 0
                loc_cSQL = "SELECT DISTINCT Impres FROM SigCdmp " + ;
                           "WHERE nTpImpres = 2 ORDER BY Impres"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImpTemp") > 0
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro CarregarImpressoras")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorListaPrecos - Popula dbImpressao via SigCdLpi
    * par_cLPrecos:      codigo da lista de precos
    * par_lCarregarItens: se .T. insere itens no cursor dbImpressao
    * Retorna: .T. se carregado com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorListaPrecos(par_cLPrecos, par_lCarregarItens)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nVal, loc_nValDe
        LOCAL loc_cCPros, loc_cDPros, loc_cLPrecosItem, loc_cSQLPro

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT LPrecos, CPros, DPros, PVens, PrecoDe, VencIs, VencFs " + ;
                       "FROM SigCdLpi " + ;
                       "WHERE LPrecos = " + EscaparSQL(PADR(ALLTRIM(par_cLPrecos), 30))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ListaIten") <= 0
                MsgErro("Falha ao carregar itens da lista de pre" + CHR(231) + "os.", ;
                        "Erro CarregarPorListaPrecos")
            ELSE
                IF par_lCarregarItens
                    SELECT cursor_4c_ListaIten
                    SCAN
                        loc_nVal        = NVL(PVens,   0)
                        loc_nValDe      = NVL(PrecoDe, 0)
                        loc_cCPros      = ALLTRIM(NVL(CPros,   ""))
                        loc_cDPros      = ALLTRIM(NVL(DPros,   ""))
                        loc_cLPrecosItem = ALLTRIM(NVL(LPrecos, ""))

                        IF !BETWEEN(DATETIME(), VencIs, VencFs)
                            loc_cSQLPro = "SELECT PVens, PrecoDe FROM SigCdPro " + ;
                                          "WHERE CPros = " + EscaparSQL(PADR(loc_cCPros, 14))

                            IF SQLEXEC(gnConnHandle, loc_cSQLPro, "cursor_4c_ProTemp") > 0
                                IF !EOF("cursor_4c_ProTemp")
                                    SELECT cursor_4c_ProTemp
                                    loc_nVal   = NVL(PVens,   0)
                                    loc_nValDe = NVL(PrecoDe, 0)
                                ENDIF
                                USE IN cursor_4c_ProTemp
                                SELECT cursor_4c_ListaIten
                            ENDIF
                        ENDIF

                        INSERT INTO dbImpressao ;
                            (Cpros, DPros, Qtds, QtdeEtiq, Obs, PVens, empos, PrecoDe) ;
                            VALUES ;
                            (loc_cCPros, loc_cDPros, 1, 1, ;
                             loc_cLPrecosItem, loc_nVal, ;
                             go_4c_Sistema.cCodEmpresa, loc_nValDe)
                    ENDSCAN
                ENDIF

                IF USED("cursor_4c_ListaIten")
                    USE IN cursor_4c_ListaIten
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro CarregarPorListaPrecos")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorMovimentacao - Popula dbImpressao via SigMvItn
    * par_cEmps:          empresa (3 chars)
    * par_cDopes:         operacao (20 chars)
    * par_nNumes:         numero do documento
    * par_lCarregarItens: se .T. insere itens no cursor dbImpressao
    * Retorna: numero de itens carregados (-1 em erro, 0 se nenhum)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorMovimentacao(par_cEmps, par_cDopes, par_nNumes, par_lCarregarItens)
        LOCAL loc_nItens, loc_oErro, loc_cEdn, loc_cSQL
        LOCAL loc_nVen, loc_nValDe, loc_nPes, loc_cSQLPro
        LOCAL loc_cCPros, loc_cDPros, loc_nQtds, loc_nCitens

        loc_nItens = -1

        TRY
            loc_cEdn = PADR(ALLTRIM(par_cEmps), 3) + ;
                       PADR(ALLTRIM(par_cDopes), 20) + ;
                       STR(par_nNumes, 6)

            loc_cSQL = "SELECT CPros, DPros, Units, Qtds, Citens " + ;
                       "FROM SigMvItn " + ;
                       "WHERE EmpDopNums = " + EscaparSQL(loc_cEdn)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvIten") <= 0
                MsgErro("Falha ao carregar itens da movimenta" + CHR(231) + CHR(227) + "o.", ;
                        "Erro CarregarPorMovimentacao")
                loc_nItens = -1
            ELSE
                loc_nItens = _TALLY

                IF loc_nItens >= 1 AND par_lCarregarItens
                    SELECT cursor_4c_MvIten
                    SCAN
                        loc_nVen     = 0
                        loc_nValDe   = 0
                        loc_nPes     = 0
                        loc_cCPros   = ALLTRIM(NVL(CPros, ""))
                        loc_cDPros   = ALLTRIM(NVL(DPros, ""))
                        loc_nQtds    = NVL(Qtds,   0)
                        loc_nCitens  = NVL(Citens, 0)

                        loc_cSQLPro = "SELECT PVens, PesoMs, PrecoDe FROM SigCdPro " + ;
                                      "WHERE CPros = " + EscaparSQL(PADR(loc_cCPros, 14))

                        IF SQLEXEC(gnConnHandle, loc_cSQLPro, "cursor_4c_ProLocal") > 0
                            IF !EOF("cursor_4c_ProLocal")
                                SELECT cursor_4c_ProLocal
                                IF NVL(PVens,   0) > 0
                                    loc_nVen   = PVens
                                ENDIF
                                IF NVL(PrecoDe, 0) > 0
                                    loc_nValDe = PrecoDe
                                ENDIF
                                IF NVL(PesoMs,  0) > 0
                                    loc_nPes   = PesoMs
                                ENDIF
                            ENDIF
                            USE IN cursor_4c_ProLocal
                            SELECT cursor_4c_MvIten
                        ENDIF

                        INSERT INTO dbImpressao ;
                            (Cpros, DPros, Qtds, QtdeEtiq, Obs, PVens, empos, ;
                             empdopnums, citens, Pesos, PrecoDe) ;
                            VALUES ;
                            (loc_cCPros, loc_cDPros, ;
                             loc_nQtds, loc_nQtds, ;
                             loc_cEdn, loc_nVen, ;
                             go_4c_Sistema.cCodEmpresa, ;
                             loc_cEdn, loc_nCitens, loc_nPes, loc_nValDe)
                    ENDSCAN
                ENDIF

                IF USED("cursor_4c_MvIten")
                    USE IN cursor_4c_MvIten
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro CarregarPorMovimentacao")
            loc_nItens = -1
        ENDTRY

        RETURN loc_nItens
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarListaPrecoNoItem - Aplica preco da lista ao registro corrente
    * de dbImpressao (deve ser chamado com cursor dbImpressao posicionado)
    * par_cLPrecos: codigo da lista de precos
    * par_cCpros:   codigo do produto
    * Retorna: .T. se preco foi aplicado
    *--------------------------------------------------------------------------
    PROCEDURE AplicarListaPrecoNoItem(par_cLPrecos, par_cCpros)
        LOCAL loc_lAplicado, loc_oErro, loc_cSQL, loc_nVal, loc_nValDe
        LOCAL loc_cLPrecosAplic, loc_cSQLPro

        loc_lAplicado = .F.

        TRY
            loc_cSQL = "SELECT LPrecos, CPros, DPros, PVens, PrecoDe, VencIs, VencFs " + ;
                       "FROM SigCdLpi " + ;
                       "WHERE LPrecos = " + EscaparSQL(PADR(par_cLPrecos, 30)) + ;
                       " AND CPros = "   + EscaparSQL(PADR(par_cCpros,   14))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LpiItem") > 0
                SELECT cursor_4c_LpiItem
                GO TOP

                IF !EOF()
                    loc_nVal          = NVL(PVens,   0)
                    loc_nValDe        = NVL(PrecoDe, 0)
                    loc_cLPrecosAplic = ALLTRIM(NVL(LPrecos, ""))

                    IF !BETWEEN(DATETIME(), VencIs, VencFs)
                        loc_cSQLPro = "SELECT PVens, PrecoDe FROM SigCdPro " + ;
                                      "WHERE CPros = " + EscaparSQL(PADR(par_cCpros, 14))

                        IF SQLEXEC(gnConnHandle, loc_cSQLPro, "cursor_4c_ProPreco") > 0
                            IF !EOF("cursor_4c_ProPreco")
                                SELECT cursor_4c_ProPreco
                                loc_nVal   = NVL(PVens,   0)
                                loc_nValDe = NVL(PrecoDe, 0)
                            ENDIF
                            USE IN cursor_4c_ProPreco
                            SELECT cursor_4c_LpiItem
                        ENDIF
                    ENDIF

                    USE IN cursor_4c_LpiItem

                    REPLACE Obs     WITH loc_cLPrecosAplic, ;
                            PVens   WITH loc_nVal, ;
                            PrecoDe WITH loc_nValDe ;
                            IN dbImpressao

                    loc_lAplicado = .T.
                ELSE
                    USE IN cursor_4c_LpiItem
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro AplicarListaPrecoNoItem")
        ENDTRY

        RETURN loc_lAplicado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarProdutoPorCodigo - Valida / resolve CPros no SigCdPro
    * Suporta EAN13 (numerico) e pesquisa por CBars e CPros direto
    * Preenche props this_cCpros, this_cDpros, this_nPVens, etc.
    * Retorna: .T. se produto encontrado
    *--------------------------------------------------------------------------
    PROCEDURE BuscarProdutoPorCodigo(par_cValor)
        LOCAL loc_lEncontrou, loc_oErro, loc_cSQL, loc_nCod, loc_cValorResolvido

        loc_lEncontrou = .F.

        TRY
            THIS.this_cCpros   = ""
            THIS.this_cDpros   = ""
            THIS.this_cDpro2s  = ""
            THIS.this_cCunis   = ""
            THIS.this_nPVens   = 0
            THIS.this_nPrecoDe = 0
            THIS.this_nPesoMs  = 0

            IF !EMPTY(par_cValor)
                loc_cValorResolvido = par_cValor

                *-- Tentativa 1: resolver como EAN13
                loc_nCod = INT(VAL(par_cValor))
                IF loc_nCod > 0
                    loc_cSQL = "SELECT TOP 1 CPros FROM SigCdPro " + ;
                               "WHERE Ean13 = " + FormatarNumeroSQL(loc_nCod)

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrEan") > 0
                        IF !EOF("cursor_4c_PrEan")
                            SELECT cursor_4c_PrEan
                            loc_cValorResolvido = ALLTRIM(CPros)
                        ENDIF
                        USE IN cursor_4c_PrEan
                    ENDIF
                ENDIF

                *-- Tentativa 2: resolver como codigo de barras (CBars)
                IF LEN(ALLTRIM(par_cValor)) <= 14
                    loc_cSQL = "SELECT TOP 1 CPros FROM SigCdPro " + ;
                               "WHERE CBars = " + FormatarNumeroSQL(INT(VAL(par_cValor)))

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrBars") > 0
                        IF !EOF("cursor_4c_PrBars")
                            SELECT cursor_4c_PrBars
                            loc_cValorResolvido = ALLTRIM(CPros)
                        ENDIF
                        USE IN cursor_4c_PrBars
                    ENDIF
                ENDIF

                *-- Buscar dados completos por CPros resolvido
                loc_cSQL = "SELECT TOP 1 CPros, DPros, Dpro2s, CUnis, " + ;
                           "PVens, PrecoDe, PesoMs " + ;
                           "FROM SigCdPro " + ;
                           "WHERE CPros = " + EscaparSQL(PADR(loc_cValorResolvido, 14))

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrDados") > 0
                    IF !EOF("cursor_4c_PrDados")
                        SELECT cursor_4c_PrDados
                        THIS.this_cCpros   = ALLTRIM(NVL(CPros,   ""))
                        THIS.this_cDpros   = ALLTRIM(NVL(DPros,   ""))
                        THIS.this_cDpro2s  = ALLTRIM(NVL(Dpro2s,  ""))
                        THIS.this_cCunis   = ALLTRIM(NVL(CUnis,   ""))
                        THIS.this_nPVens   = NVL(PVens,   0)
                        THIS.this_nPrecoDe = NVL(PrecoDe, 0)
                        THIS.this_nPesoMs  = NVL(PesoMs,  0)
                        loc_lEncontrou     = .T.
                    ENDIF
                    USE IN cursor_4c_PrDados
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro BuscarProdutoPorCodigo")
        ENDTRY

        RETURN loc_lEncontrou
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarProdutoPorDescricao - Resolve DPros direto (busca exata)
    * Preenche props this_cCpros, this_cDpros, etc.
    * Retorna: .T. se produto encontrado
    *--------------------------------------------------------------------------
    PROCEDURE BuscarProdutoPorDescricao(par_cDpros)
        LOCAL loc_lEncontrou, loc_oErro, loc_cSQL

        loc_lEncontrou = .F.

        TRY
            THIS.this_cCpros   = ""
            THIS.this_cDpros   = ""
            THIS.this_cDpro2s  = ""
            THIS.this_cCunis   = ""
            THIS.this_nPVens   = 0
            THIS.this_nPrecoDe = 0
            THIS.this_nPesoMs  = 0

            IF !EMPTY(par_cDpros)
                loc_cSQL = "SELECT TOP 1 CPros, DPros, Dpro2s, CUnis, " + ;
                           "PVens, PrecoDe, PesoMs " + ;
                           "FROM SigCdPro " + ;
                           "WHERE DPros = " + EscaparSQL(par_cDpros)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrDescr") > 0
                    IF !EOF("cursor_4c_PrDescr")
                        SELECT cursor_4c_PrDescr
                        THIS.this_cCpros   = ALLTRIM(NVL(CPros,   ""))
                        THIS.this_cDpros   = ALLTRIM(NVL(DPros,   ""))
                        THIS.this_cDpro2s  = ALLTRIM(NVL(Dpro2s,  ""))
                        THIS.this_cCunis   = ALLTRIM(NVL(CUnis,   ""))
                        THIS.this_nPVens   = NVL(PVens,   0)
                        THIS.this_nPrecoDe = NVL(PrecoDe, 0)
                        THIS.this_nPesoMs  = NVL(PesoMs,  0)
                        loc_lEncontrou     = .T.
                    ENDIF
                    USE IN cursor_4c_PrDescr
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro BuscarProdutoPorDescricao")
        ENDTRY

        RETURN loc_lEncontrou
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarProdutoPorReferencia - Resolve Dpro2s direto (busca exata)
    * Preenche props this_cCpros, this_cDpros, etc.
    * Retorna: .T. se produto encontrado
    *--------------------------------------------------------------------------
    PROCEDURE BuscarProdutoPorReferencia(par_cDpro2s)
        LOCAL loc_lEncontrou, loc_oErro, loc_cSQL

        loc_lEncontrou = .F.

        TRY
            THIS.this_cCpros   = ""
            THIS.this_cDpros   = ""
            THIS.this_cDpro2s  = ""
            THIS.this_cCunis   = ""
            THIS.this_nPVens   = 0
            THIS.this_nPrecoDe = 0
            THIS.this_nPesoMs  = 0

            IF !EMPTY(par_cDpro2s)
                loc_cSQL = "SELECT TOP 1 CPros, DPros, Dpro2s, CUnis, " + ;
                           "PVens, PrecoDe, PesoMs " + ;
                           "FROM SigCdPro " + ;
                           "WHERE Dpro2s = " + EscaparSQL(par_cDpro2s)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrRef") > 0
                    IF !EOF("cursor_4c_PrRef")
                        SELECT cursor_4c_PrRef
                        THIS.this_cCpros   = ALLTRIM(NVL(CPros,   ""))
                        THIS.this_cDpros   = ALLTRIM(NVL(DPros,   ""))
                        THIS.this_cDpro2s  = ALLTRIM(NVL(Dpro2s,  ""))
                        THIS.this_cCunis   = ALLTRIM(NVL(CUnis,   ""))
                        THIS.this_nPVens   = NVL(PVens,   0)
                        THIS.this_nPrecoDe = NVL(PrecoDe, 0)
                        THIS.this_nPesoMs  = NVL(PesoMs,  0)
                        loc_lEncontrou     = .T.
                    ENDIF
                    USE IN cursor_4c_PrRef
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro BuscarProdutoPorReferencia")
        ENDTRY

        RETURN loc_lEncontrou
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarEtiquetaIndividual - Verifica se produto usa etiqueta individual
    * Retorna: .T. se produto usa etiqueta individual E nao permite duplicata
    * (o form bloqueia a impressao desse produto nesse caso)
    *--------------------------------------------------------------------------
    PROCEDURE VerificarEtiquetaIndividual(par_cCpros)
        LOCAL loc_lEtqIndividual, loc_oErro, loc_cSQL

        loc_lEtqIndividual = .F.

        TRY
            IF !EMPTY(par_cCpros)
                loc_cSQL = "SELECT u.Etiqs, u.EtiqDups " + ;
                           "FROM SigCdPro p " + ;
                           "INNER JOIN SigCdUni u ON p.CUnis = u.CUnis " + ;
                           "WHERE p.CPros = " + EscaparSQL(PADR(par_cCpros, 14))

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UniEtq") > 0
                    IF !EOF("cursor_4c_UniEtq")
                        SELECT cursor_4c_UniEtq
                        IF ALLTRIM(NVL(Etiqs, "")) = "S" AND NVL(EtiqDups, 0) <> 1
                            loc_lEtqIndividual = .T.
                        ENDIF
                    ENDIF
                    USE IN cursor_4c_UniEtq
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro VerificarEtiquetaIndividual")
        ENDTRY

        RETURN loc_lEtqIndividual
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterNDopesParaBOP - Busca NDopes de SigCdOpe para montar codigo BOP
    * Retorna: string NDopes (4 chars padded) ou "" se nao encontrado
    *--------------------------------------------------------------------------
    PROCEDURE ObterNDopesParaBOP(par_cDopes)
        LOCAL loc_cNDopes, loc_oErro, loc_cSQL

        loc_cNDopes = ""

        TRY
            IF !EMPTY(par_cDopes)
                loc_cSQL = "SELECT TOP 1 NDopes FROM SigCdOpe " + ;
                           "WHERE Dopes = " + EscaparSQL(par_cDopes)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeNDop") > 0
                    IF !EOF("cursor_4c_OpeNDop")
                        SELECT cursor_4c_OpeNDop
                        IF !EMPTY(NVL(NDopes, 0))
                            loc_cNDopes = PADL(TRANSFORM(NVL(NDopes, 0)), 4, "0")
                        ENDIF
                    ENDIF
                    USE IN cursor_4c_OpeNDop
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ObterNDopesParaBOP")
        ENDTRY

        RETURN loc_cNDopes
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirEtiquetas - Chama SigOpEtq com os parametros de impressao
    * Retorna: .T. se impressao concluida com sucesso (incluindo Commit)
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirEtiquetas()
        LOCAL loc_lSucesso, loc_oErro, loc_cBop, loc_cNDopes

        loc_lSucesso = .F.

        TRY
            loc_cBop = ""
            IF !EMPTY(THIS.this_cDopes) AND THIS.this_nNumes > 0
                loc_cNDopes = THIS.ObterNDopesParaBOP(THIS.this_cDopes)
                IF !EMPTY(loc_cNDopes)
                    loc_cBop = loc_cNDopes + PADL(TRANSFORM(THIS.this_nNumes), 6, "0")
                ENDIF
            ENDIF

            =SigOpEtq(gnConnHandle, ;
                      THIS.this_nImpPreco, ;
                      THIS.this_lImpSepar, ;
                      THIS.this_nTpEti, ;
                      THIS.this_nTpImp, ;
                      THIS.this_nAjVertsPrint, ;
                      THIS.this_nAjHorzsPrint, ;
                      THIS.this_nAjDensPrint, ;
                      .NULL., .NULL., .NULL., ;
                      THIS.this_cNomeImp, ;
                      .NULL., .NULL., ;
                      THIS.this_nAjVelosPrint, ;
                      THIS.this_lImpPeso, ;
                      loc_cBop, ;
                      THIS.this_cLp1, ;
                      THIS.this_cLp2, ;
                      .F., .F., ;
                      THIS.this_lCompo)

            IF SQLEXEC(gnConnHandle, "COMMIT", "cursor_4c_Commit") >= 0
                IF USED("cursor_4c_Commit")
                    USE IN cursor_4c_Commit
                ENDIF
                loc_lSucesso = .T.
            ELSE
                IF USED("cursor_4c_Commit")
                    USE IN cursor_4c_Commit
                ENDIF
                SQLEXEC(gnConnHandle, "ROLLBACK", "cursor_4c_Rollback")
                IF USED("cursor_4c_Rollback")
                    USE IN cursor_4c_Rollback
                ENDIF
                MsgErro("Falha ao confirmar transa" + CHR(231) + CHR(227) + "o (Commit).", ;
                        "Erro ImprimirEtiquetas")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ImprimirEtiquetas")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades BO a partir de um alias de cursor
    * par_cAliasCursor: alias do cursor (normalmente "dbImpressao")
    * Retorna: .T. se carregado com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor) AND !EOF(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cCpros       = ALLTRIM(NVL(Cpros,       ""))
                THIS.this_cDpros       = ALLTRIM(NVL(DPros,       ""))
                THIS.this_cReffs       = ALLTRIM(NVL(Reffs,       ""))
                THIS.this_nQtds        = NVL(Qtds,      0)
                THIS.this_nQtdeEtiq    = NVL(QtdeEtiq,  0)
                THIS.this_cPedido      = ALLTRIM(NVL(Pedido,      ""))
                THIS.this_cObs         = ALLTRIM(NVL(Obs,         ""))
                THIS.this_nPVens       = NVL(PVens,     0)
                THIS.this_nPrecoDe     = NVL(PrecoDe,   0)
                THIS.this_nParcelas    = NVL(Parcelas,  0)
                THIS.this_cCpros2      = ALLTRIM(NVL(Cpros2,      ""))
                THIS.this_cCpros3      = ALLTRIM(NVL(Cpros3,      ""))
                THIS.this_cCpros4      = ALLTRIM(NVL(Cpros4,      ""))
                THIS.this_cEmpos       = ALLTRIM(NVL(empos,       ""))
                THIS.this_cEmpdopnums  = ALLTRIM(NVL(empdopnums,  ""))
                THIS.this_nCitens      = NVL(citens,    0)
                THIS.this_nPesos       = NVL(Pesos,     0)
                THIS.this_cCodTams     = ALLTRIM(NVL(CodTams,     ""))
                THIS.this_cDpro2s      = ALLTRIM(NVL(DPro2s,      ""))

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrEtqBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Adiciona nova linha ao cursor local dbImpressao
    * Retorna: .T. se inserido com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED("dbImpressao")
                INSERT INTO dbImpressao ;
                    (Cpros, DPros, Reffs, Qtds, QtdeEtiq, ;
                     Pedido, Obs, PVens, PrecoDe, Parcelas, ;
                     Cpros2, Cpros3, Cpros4, empos, empdopnums, ;
                     citens, Pesos, CodTams, DPro2s) ;
                    VALUES ;
                    (THIS.this_cCpros, THIS.this_cDpros, THIS.this_cReffs, ;
                     THIS.this_nQtds, THIS.this_nQtdeEtiq, ;
                     THIS.this_cPedido, THIS.this_cObs, THIS.this_nPVens, ;
                     THIS.this_nPrecoDe, THIS.this_nParcelas, ;
                     THIS.this_cCpros2, THIS.this_cCpros3, THIS.this_cCpros4, ;
                     THIS.this_cEmpos, THIS.this_cEmpdopnums, ;
                     THIS.this_nCitens, THIS.this_nPesos, ;
                     THIS.this_cCodTams, THIS.this_cDpro2s)

                THIS.RegistrarAuditoria("I")

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrEtqBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza linha corrente do cursor local dbImpressao
    * Retorna: .T. se atualizado com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED("dbImpressao") AND !EOF("dbImpressao")
                SELECT dbImpressao

                REPLACE Cpros       WITH THIS.this_cCpros, ;
                        DPros       WITH THIS.this_cDpros, ;
                        Reffs       WITH THIS.this_cReffs, ;
                        Qtds        WITH THIS.this_nQtds, ;
                        QtdeEtiq    WITH THIS.this_nQtdeEtiq, ;
                        Pedido      WITH THIS.this_cPedido, ;
                        Obs         WITH THIS.this_cObs, ;
                        PVens       WITH THIS.this_nPVens, ;
                        PrecoDe     WITH THIS.this_nPrecoDe, ;
                        Parcelas    WITH THIS.this_nParcelas, ;
                        Cpros2      WITH THIS.this_cCpros2, ;
                        Cpros3      WITH THIS.this_cCpros3, ;
                        Cpros4      WITH THIS.this_cCpros4, ;
                        empos       WITH THIS.this_cEmpos, ;
                        empdopnums  WITH THIS.this_cEmpdopnums, ;
                        citens      WITH THIS.this_nCitens, ;
                        Pesos       WITH THIS.this_nPesos, ;
                        CodTams     WITH THIS.this_cCodTams, ;
                        DPro2s      WITH THIS.this_cDpro2s

                THIS.RegistrarAuditoria("A")

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrEtqBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna o codigo do produto corrente em dbImpressao
    * Form OPERACIONAL: usa CPros como identificador do item corrente
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        LOCAL loc_cChave

        loc_cChave = ""

        IF USED("dbImpressao") AND !EOF("dbImpressao")
            SELECT dbImpressao
            loc_cChave = ALLTRIM(NVL(Cpros, ""))
        ENDIF

        RETURN loc_cChave
    ENDFUNC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Form OPERACIONAL sem tabela principal
    * Sem persistencia em LogAuditoria (cursor local nao eh auditavel)
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        RETURN .T.
    ENDPROC

ENDDEFINE

