# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[FormSigPrGst.prg] Procedure vazia (sem codigo): HabilitarCampos
[FormSigPrGst.prg] Indicador de pendencia: *   sem confirmar movimentacoes pendente
[FormSigPrGst.prg] Indicador de pendencia: *   sao sempre visiveis e habilitados independente

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGst.prg):
*==============================================================================
* FormSigPrGst.prg - Geracao de Movimentacoes de Estoque
*
* Tipo: OPERACIONAL - layout flat customizado (sem PageFrame)
* Migrado de: SIGPRGST.SCX
* Fase 8/8 COMPLETO.
*
* Este formulario e aberto por outro formulario pai que passa seus cursores
* (csCabec, csItens, CsEstPe, CrSigCdNec) no workspace global.
* Recebe referencia ao formulario pai via parametro par_oFormPai.
*==============================================================================

DEFINE CLASS FormSigPrGst AS FormBase

    *-- Propriedades visuais (copiadas exatamente do original SIGPRGST)
    Height       = 600
    Width        = 1000
    AutoCenter   = .T.
    BorderStyle  = 2
    TitleBar     = 0
    ShowWindow = 1
    ControlBox   = .F.
    Movable      = .F.
    KeyPreview   = .T.
    WindowType   = 1
    FontName     = "Tahoma"
    FontSize     = 8

    *-- Referencias do formulario pai
    this_oFormPai   = .NULL.   && Formulario que abriu este sub-form
    this_cPcEscolha = ""       && Escolha de processamento herdada do pai
    this_cGrupoOper = ""       && Grupo de operacao (legado: grupooper)

    *-- Business Object
    this_oBusinessObject = .NULL.
    this_cMensagemErro   = ""

    *==========================================================================
    PROCEDURE Init(par_oFormPai)
    *==========================================================================
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            *-- Armazenar referencia do formulario pai ANTES de DODEFAULT
            IF VARTYPE(par_oFormPai) = "O"
                THIS.this_oFormPai = par_oFormPai
            ENDIF
            THIS.this_cGrupoOper = SPACE(10)

            *-- DODEFAULT chama FormBase.Init -> InicializarForm
            loc_lResultado = DODEFAULT()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "Erro Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Criar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrGstBO")
            IF VARTYPE(THIS.this_oBusinessObject) # "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigPrGst.", "Erro")
            ELSE
                *-- Definir Caption antes de ConfigurarCabecalho (labels usam THIS.Caption)
                THIS.Caption = "Gera" + CHR(231) + CHR(227) + "o de Movimenta" + CHR(231) + ;
                               CHR(245) + "es de Estoque"

                *-- Imagem de fundo e titulo
                THIS.ConfigurarPageFrame()

                *-- Cabecalho cinza escuro com titulo
                THIS.ConfigurarCabecalho()

                *-- Shape decorativo separador
                THIS.ConfigurarSeparador()

                *-- Botoes operacionais: Confirmar + Encerrar
                THIS.ConfigurarBotoes()

                *-- Grades de cabecalho e itens (Fase 4)
                THIS.ConfigurarGrids()

                *-- Propriedades visuais dos Text1 das colunas dos grids (Fase 5)
                THIS.ConfigurarPaginaDados()

                *-- Tornar controles visiveis (exceto os que gerenciam Visible proprios)
                THIS.TornarControlesVisiveis()

                *-- Vincular eventos de botoes e grade
                THIS.ConfigurarBINDEVENTs()

                *-- Navegacao inicial dos cursores e refresh das grades
                THIS.CarregarDados()

                *-- Propagar titulo para labels do cabecalho
                THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "Erro FormSigPrGst.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - OPERACIONAL: sem PageFrame, fundo via Picture
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame
        THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Container escuro com titulo (cntSombra original)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Visible     = .T.
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackColor   = RGB(100,100,100)

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .AutoSize      = .F.
                .BackStyle     = 0
                .Caption       = THIS.Caption
                .Height        = 40
                .Left          = 10
                .Top           = 18
                .Width         = THIS.Width
                .ForeColor     = RGB(0,0,0)
                .Visible       = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 18
                .WordWrap   = .T.
                .Alignment  = 0
                .AutoSize   = .F.
                .BackStyle  = 0
                .Caption    = THIS.Caption
                .Height     = 46
                .Left       = 10
                .Top        = 17
                .Width      = THIS.Width
                .ForeColor  = RGB(255,255,255)
                .Visible    = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarSeparador - Shape decorativo entre grid de cabecalho e botoes
    *   Original: ShpP2 em Top=11, Left=819, Width=21, Height=37
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarSeparador
        THIS.AddObject("shp_4c_ShpP2", "Shape")
        WITH THIS.shp_4c_ShpP2
            .Top           = 11
            .Left          = 819
            .Width         = 21
            .Height        = 37
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136,189,188)
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Botoes operacionais Confirmar (CmdGrava) e Encerrar
    *   CmdGrava  original: Top=3, Left=850, Picture=geral_disco2_60.jpg
    *   CmdCancela original: Top=3, Left=925, Picture=cadastro_sair_60.jpg, Cancel=.T.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes
        THIS.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH THIS.cmd_4c_Confirmar
            .Top             = 3
            .Left            = 850
            .Width           = 75
            .Height          = 75
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "geral_disco2_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_disco2_60.jpg"
            .Themes          = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90,90,90)
            .BackColor       = RGB(255,255,255)
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cmd_4c_Encerrar
            .Top             = 3
            .Left            = 925
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel          = .T.
            .Themes          = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90,90,90)
            .BackColor       = RGB(255,255,255)
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarGrids - Grade de cabecalho (GrdCab) e de itens (GrdIte)
    *   Fase 4: implementacao completa com cursores csCabec/csItens
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrids
        THIS.ConfigurarGrdCab()
        THIS.ConfigurarGrdIte()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Alias operacional para ConfigurarGrids
    *   Este form OPERACIONAL nao tem PageFrame Lista/Dados; a "pagina de
    *   listagem" equivale as duas grades (cabecalho + itens). Delegar aqui
    *   mantem compatibilidade com o pipeline generico de forms CRUD.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista
        THIS.ConfigurarGrids()
    ENDPROC

    *==========================================================================
    * AlternarPagina - Em forms OPERACIONAIS sem PageFrame, "alternar" equivale
    *   a re-sincronizar a navegacao dos cursores csCabec/csItens e refresh
    *   das grades. Compativel com a assinatura do pipeline (par_nPagina).
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        THIS.CarregarDados()
    ENDPROC

    *==========================================================================
    * ConfigurarGrdCab - Grade de cabecalho (Fase 4)
    *   Original: Top=95, Left=11, Width=798, Height=194, ColumnCount=7
    *   Colunas: Emp | Grupo Origem | Conta Origem | Conta Destino | Grupo Destino | Confirmacao | Movimentacao
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrdCab
        LOCAL loc_oGrid

        THIS.AddObject("grd_4c_Cab", "Grid")
        WITH THIS.grd_4c_Cab
            .Top              = 95
            .Left             = 11
            .Width            = 798
            .Height           = 194
            .ColumnCount      = 7
            .FontName         = "Verdana"
            .FontSize         = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing   = .F.
            .DeleteMark       = .F.
            .RecordMark       = .F.
            .HeaderHeight     = 15
            .ReadOnly         = .T.
            .RowHeight        = 16
            .ScrollBars       = 2
            .TabStop          = .F.
            .GridLineColor    = RGB(238,238,238)
            .Visible          = .T.

            *-- Coluna 1: Emp (Width=35, ColumnOrder=1)
            .Column1.Width       = 35
            .Column1.ColumnOrder = 1
            .Column1.Movable     = .F.
            .Column1.Resizable   = .F.
            .Column1.ReadOnly    = .T.
            .Column1.FontSize    = 8
            .Column1.Header1.Caption   = "Emp"
            .Column1.Header1.Alignment = 2
            .Column1.Header1.FontName  = "Tahoma"
            .Column1.Header1.ForeColor = RGB(0,0,0)

            *-- Coluna 2: Grupo Origem (Width=100, ColumnOrder=3)
            .Column2.Width       = 100
            .Column2.ColumnOrder = 3
            .Column2.Movable     = .F.
            .Column2.Resizable   = .F.
            .Column2.ReadOnly    = .T.
            .Column2.FontSize    = 8
            .Column2.Header1.Caption   = "Grupo Origem"
            .Column2.Header1.Alignment = 2
            .Column2.Header1.FontName  = "Tahoma"
            .Column2.Header1.ForeColor = RGB(0,0,0)

            *-- Coluna 3: Conta Origem (Width=100, ColumnOrder=4)
            .Column3.Width       = 100
            .Column3.ColumnOrder = 4
            .Column3.Movable     = .F.
            .Column3.Resizable   = .F.
            .Column3.ReadOnly    = .T.
            .Column3.FontSize    = 8
            .Column3.Header1.Caption   = "Conta Origem"
            .Column3.Header1.Alignment = 2
            .Column3.Header1.FontName  = "Tahoma"
            .Column3.Header1.ForeColor = RGB(0,0,0)

            *-- Coluna 4: Conta Destino (Width=100, ColumnOrder=5)
            .Column4.Width       = 100
            .Column4.ColumnOrder = 5
            .Column4.Movable     = .F.
            .Column4.Resizable   = .F.
            .Column4.ReadOnly    = .T.
            .Column4.FontSize    = 8
            .Column4.Header1.Caption   = "Conta Destino"
            .Column4.Header1.Alignment = 2
            .Column4.Header1.FontName  = "Tahoma"
            .Column4.Header1.ForeColor = RGB(0,0,0)

            *-- Coluna 5: Grupo Destino (Width=100, ColumnOrder=6)
            .Column5.Width       = 100
            .Column5.ColumnOrder = 6
            .Column5.Movable     = .F.
            .Column5.Resizable   = .F.
            .Column5.ReadOnly    = .T.
            .Column5.FontSize    = 8
            .Column5.Header1.Caption   = "Grupo Destino"
            .Column5.Header1.Alignment = 2
            .Column5.Header1.FontName  = "Tahoma"
            .Column5.Header1.ForeColor = RGB(0,0,0)

            *-- Coluna 6: Confirmacao (Width=100, ColumnOrder=7, verde/bold)
            .Column6.Width       = 100
            .Column6.ColumnOrder = 7
            .Column6.Movable     = .F.
            .Column6.Resizable   = .F.
            .Column6.ReadOnly    = .T.
            .Column6.FontSize    = 8
            .Column6.FontBold    = .T.
            .Column6.Alignment   = 2
            .Column6.ForeColor   = RGB(0,128,0)
            .Column6.Header1.Caption   = "Confirma" + CHR(231) + CHR(227) + "o"
            .Column6.Header1.Alignment = 2
            .Column6.Header1.FontName  = "Tahoma"
            .Column6.Header1.ForeColor = RGB(0,0,0)

            *-- Coluna 7: Movimentacao (Width=225, ColumnOrder=2)
            .Column7.Width       = 225
            .Column7.ColumnOrder = 2
            .Column7.Movable     = .F.
            .Column7.Resizable   = .F.
            .Column7.ReadOnly    = .T.
            .Column7.FontSize    = 8
            .Column7.Header1.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
            .Column7.Header1.Alignment = 2
            .Column7.Header1.FontName  = "Tahoma"
            .Column7.Header1.ForeColor = RGB(0,0,0)

            *-- ControlSource e DynamicBackColor (vincula ao cursor csCabec)
            .RecordSourceType = 1
            .RecordSource     = "csCabec"
            .Column1.ControlSource = "csCabec.EmpDs"
            .Column2.ControlSource = "csCabec.GrupoOs"
            .Column3.ControlSource = "csCabec.ContaOs"
            .Column4.ControlSource = "csCabec.ContaDs"
            .Column5.ControlSource = "csCabec.GrupoDs"
            .Column6.ControlSource = "csCabec.Gerado"
            .Column7.ControlSource = "csCabec.Dopes"
            .SetAll("DynamicBackColor", ;
                "IIF(EMPTY(csCabec.Gerado), RGB(255,255,255), RGB(255,255,204))", ;
                "Column")
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarGrdIte - Grade de itens (Fase 4)
    *   Original: Top=295, Left=10, Width=980, Height=289, ColumnCount=7
    *   Colunas: [seq] | Produto | Descricao | M | Pr.Unit. | Quantidade | Total
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrdIte
        THIS.AddObject("grd_4c_Ite", "Grid")
        WITH THIS.grd_4c_Ite
            .Top              = 295
            .Left             = 10
            .Width            = 980
            .Height           = 289
            .ColumnCount      = 7
            .FontName         = "Verdana"
            .FontSize         = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing   = .F.
            .DeleteMark       = .F.
            .RecordMark       = .F.
            .HeaderHeight     = 15
            .ReadOnly         = .T.
            .RowHeight        = 16
            .ScrollBars       = 2
            .TabStop          = .F.
            .GridLineColor    = RGB(238,238,238)
            .Visible          = .T.

            *-- Coluna 1: [sequencial CItens] (Width=36, ColumnOrder=1)
            .Column1.Width       = 36
            .Column1.ColumnOrder = 1
            .Column1.Movable     = .F.
            .Column1.Resizable   = .F.
            .Column1.ReadOnly    = .T.
            .Column1.FontSize    = 8
            .Column1.Header1.Caption   = ""
            .Column1.Header1.Alignment = 2
            .Column1.Header1.FontName  = "Tahoma"
            .Column1.Header1.ForeColor = RGB(0,0,0)

            *-- Coluna 2: Produto - CPros (Width=120, ColumnOrder=2)
            .Column2.Width       = 120
            .Column2.ColumnOrder = 2
            .Column2.Movable     = .F.
            .Column2.Resizable   = .F.
            .Column2.ReadOnly    = .T.
            .Column2.FontSize    = 8
            .Column2.Header1.Caption   = "Produto"
            .Column2.Header1.Alignment = 2
            .Column2.Header1.FontName  = "Tahoma"
            .Column2.Header1.ForeColor = RGB(0,0,0)

            *-- Coluna 3: Descricao do Produto - DPros (Width=403, ColumnOrder=3)
            .Column3.Width       = 403
            .Column3.ColumnOrder = 3
            .Column3.Movable     = .F.
            .Column3.Resizable   = .F.
            .Column3.ReadOnly    = .T.
            .Column3.FontSize    = 8
            .Column3.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o do Produto"
            .Column3.Header1.Alignment = 2
            .Column3.Header1.FontName  = "Tahoma"
            .Column3.Header1.ForeColor = RGB(0,0,0)

            *-- Coluna 4: M - Moedas (Width=23, ColumnOrder=4)
            .Column4.Width       = 23
            .Column4.ColumnOrder = 4
            .Column4.Movable     = .F.
            .Column4.Resizable   = .F.
            .Column4.ReadOnly    = .T.
            .Column4.FontSize    = 8
            .Column4.Header1.Caption   = "M"
            .Column4.Header1.Alignment = 2
            .Column4.Header1.FontName  = "Tahoma"
            .Column4.Header1.ForeColor = RGB(0,0,0)

            *-- Coluna 5: Preco Unitario - Units (Width=130, ColumnOrder=5)
            .Column5.Width       = 130
            .Column5.ColumnOrder = 5
            .Column5.Movable     = .F.
            .Column5.Resizable   = .F.
            .Column5.ReadOnly    = .T.
            .Column5.FontSize    = 8
            .Column5.Header1.Caption   = "Pr. Unit."
            .Column5.Header1.Alignment = 2
            .Column5.Header1.FontName  = "Tahoma"
            .Column5.Header1.ForeColor = RGB(0,0,0)

            *-- Coluna 6: Quantidade - Qtds (Width=100, ColumnOrder=6)
            .Column6.Width       = 100
            .Column6.ColumnOrder = 6
            .Column6.Movable     = .F.
            .Column6.Resizable   = .F.
            .Column6.ReadOnly    = .T.
            .Column6.FontSize    = 8
            .Column6.Header1.Caption   = "Quantidade"
            .Column6.Header1.Alignment = 2
            .Column6.Header1.FontName  = "Tahoma"
            .Column6.Header1.ForeColor = RGB(0,0,0)

            *-- Coluna 7: Total - Totas (Width=130, ColumnOrder=7)
            .Column7.Width       = 130
            .Column7.ColumnOrder = 7
            .Column7.Movable     = .F.
            .Column7.Resizable   = .F.
            .Column7.ReadOnly    = .T.
            .Column7.FontSize    = 8
            .Column7.Header1.Caption   = "Total"
            .Column7.Header1.Alignment = 2
            .Column7.Header1.FontName  = "Tahoma"
            .Column7.Header1.ForeColor = RGB(0,0,0)

            *-- ControlSource (vincula ao cursor csItens)
            .RecordSourceType = 1
            .RecordSource     = "csItens"
            .Column1.ControlSource = "csItens.CItens"
            .Column2.ControlSource = "csItens.CPros"
            .Column3.ControlSource = "csItens.DPros"
            .Column4.ControlSource = "csItens.Moedas"
            .Column5.ControlSource = "csItens.Units"
            .Column6.ControlSource = "csItens.Qtds"
            .Column7.ControlSource = "csItens.Totas"
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Fase 5/8: propriedades visuais Text1 dos grids
    *   Para este form OPERACIONAL flat (sem Page2), esta fase configura as
    *   propriedades dos controles Text1 dentro das colunas dos grids, conforme
    *   as propriedades definidas no SCX original (BorderStyle=0, Margin=0,
    *   ForeColor, BackColor), e aplica HighlightColors canonicos em ambos.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados
        THIS.ConfigurarTextosGrdCab()
        THIS.ConfigurarTextosGrdIte()
    ENDPROC

    *==========================================================================
    * ConfigurarTextosGrdCab - Propriedades Text1 de GrdCab + HighlightColors
    *   Original SCX: Text1.BorderStyle=0, Margin=0, ForeColor=0,0,0
    *   BackColor=255,255,255 em todos; Column6.Text1 FontBold=.T. Alignment=2
    *   ForeColor=0,128,0
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarTextosGrdCab
        WITH THIS.grd_4c_Cab
            *-- Propriedades comuns a todos os Text1 das colunas
            .SetAll("BorderStyle",   0,                  "Text")
            .SetAll("Margin",        0,                  "Text")
            .SetAll("ForeColor",     RGB(0,0,0),         "Text")
            .SetAll("BackColor",     RGB(255,255,255),   "Text")

            *-- HighlightColors canonicos do grid
            .HighlightBackColor = RGB(255,255,255)
            .HighlightForeColor = RGB(15,41,104)
            .HighlightStyle     = 2

            *-- Coluna 6 (Confirmacao): Text1 verde+bold - SetAll sobrescreveu, restaurar aqui
            WITH .Column6
                .FontBold  = .T.
                .Alignment = 2
                .ForeColor = RGB(0,128,0)
            ENDWITH
            WITH .Column6.Text1
                .ForeColor = RGB(0,128,0)
                .FontBold  = .T.
                .Alignment = 2
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarTextosGrdIte - Propriedades Text1 de GrdIte + HighlightColors
    *   Original SCX: Text1.BorderStyle=0, Margin=0, ForeColor=0,0,0
    *   BackColor=255,255,255 em todos
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarTextosGrdIte
        WITH THIS.grd_4c_Ite
            *-- Propriedades comuns a todos os Text1 das colunas
            .SetAll("BorderStyle",   0,                  "Text")
            .SetAll("Margin",        0,                  "Text")
            .SetAll("ForeColor",     RGB(0,0,0),         "Text")
            .SetAll("BackColor",     RGB(255,255,255),   "Text")

            *-- HighlightColors canonicos do grid
            .HighlightBackColor = RGB(255,255,255)
            .HighlightForeColor = RGB(15,41,104)
            .HighlightStyle     = 2
        ENDWITH
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis
    *   Para este form OPERACIONAL nao ha containers que devem comecar ocultos.
    *   LOOP nao e usado para nenhum container (todos devem ficar visiveis).
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl

        IF PCOUNT() = 0
            par_oContainer = THIS
        ENDIF

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) # "O"
                LOOP
            ENDIF

            IF PEMSTATUS(loc_oControl, "Visible", 5)
                loc_oControl.Visible = .T.
            ENDIF

            *-- Recursar em containers e pageframes
            IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
               loc_oControl.ControlCount > 0
                THIS.TornarControlesVisiveis(loc_oControl)
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * CarregarDados - Inicializa posicionamento de cursores e refresh das grades
    *   Equivalente ao bloco de navegacao de cursores do Init() original:
    *   GO TOP em csCabec, SET KEY TO csCabec.EmpDopNums em csItens, GO TOP.
    *==========================================================================
    PROTECTED PROCEDURE CarregarDados
        IF USED("csCabec")
            SELECT csCabec
            GO TOP
        ENDIF

        IF USED("csItens") AND USED("csCabec") AND !EOF("csCabec")
            SELECT csItens
            SET KEY TO csCabec.EmpDopNums
            GO TOP
            SELECT csCabec
        ENDIF

        IF VARTYPE(THIS.grd_4c_Cab) = "O"
            THIS.grd_4c_Cab.Refresh()
        ENDIF

        IF VARTYPE(THIS.grd_4c_Ite) = "O"
            THIS.grd_4c_Ite.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * ProcessaPeriodo - Stub para nao gerar erro em chamadas do SigMvCab
    *   Original SIGPRGST: "Rotina Criada Apenas Para Nao Gerar Erro Nas
    *   Chamadas do SigMvCab." ? SigMvCab pode chamar ThisForm.ParentForm.ProcessaPeriodo
    *==========================================================================
    PROCEDURE ProcessaPeriodo(par_P1, par_P2, par_P3)
        RETURN .T.
    ENDPROC

    *==========================================================================
    * GrdCabAfterRowColChange - Atualiza GrdIte ao mudar linha no GrdCab
    *   Original: seleciona csItens com SET KEY TO csCabec.EmpDopNums + Refresh
    *==========================================================================
    PROCEDURE GrdCabAfterRowColChange(par_nColIndex)
        IF USED("csItens") AND USED("csCabec") AND !EOF("csCabec")
            SELECT csItens
            SET KEY TO csCabec.EmpDopNums
            GO TOP
            THIS.grd_4c_Ite.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnConfirmarClick - Verifica selecao e chama GerarPedido no BO
    *   Original: CmdGrava.Click - valida EOF, chama GerarPedido, abre SigMvCab
    *==========================================================================
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            IF !USED("csCabec") OR EOF("csCabec")
                MsgAviso("Selecione um pedido na grade e tente novamente.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                loc_lResultado = THIS.this_oBusinessObject.GerarPedido()
                IF loc_lResultado AND !EMPTY(ALLTRIM(csCabec.Gerado))
                    DO FORM SigMvCab WITH ;
                        csCabec.GerDopes, csCabec.GerNumes, csCabec.GerEmps, ;
                        .T., 3, THIS, .F., .T.
                ENDIF
                THIS.grd_4c_Cab.Refresh()
                THIS.grd_4c_Ite.Refresh()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "Erro Confirmar")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Verifica pedidos nao confirmados antes de fechar
    *   Original: CmdCancela.Click - conta registros com Gerado vazio, confirma
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        LOCAL loc_lResultado, loc_nFal, loc_oErro
        loc_lResultado = .F.

        TRY
            *-- Verificar pedidos nao gerados
            IF USED("csCabec")
                SELECT Emps, Dopes, Numes ;
                    FROM csCabec ;
                    WHERE EMPTY(Gerado) ;
                    INTO CURSOR cursor_4c_NaoGerados
                loc_nFal = RECCOUNT("cursor_4c_NaoGerados")
                USE IN cursor_4c_NaoGerados
            ELSE
                loc_nFal = 0
            ENDIF

            IF loc_nFal > 0
                IF !MsgConfirma("Existem " + ALLTRIM(STR(loc_nFal, 10)) + ;
                    " Opera" + CHR(231) + CHR(245) + "es N" + CHR(227) + "o Confirmadas!" + ;
                    CHR(13) + "Tem Certeza Que N" + CHR(227) + "o Deseja Gerar Esses Pedidos?", ;
                    "Aten" + CHR(231) + CHR(227) + "o!!!")
                    loc_lResultado = .F.
                ELSE
                    *-- Log de cancelamento
                    IF USED("CrSigCdNec") AND !EOF("CrSigCdNec") AND ;
                       TYPE("CrSigCdNec.Dopps") != "U"
                        =fGravarLog("T", ALLTRIM(CrSigCdNec.Dopps), "AUTOMATICO", ;
                            "A Gera" + CHR(231) + CHR(227) + "o de " + ;
                            ALLTRIM(STR(loc_nFal, 10)) + ;
                            " Opera" + CHR(231) + CHR(227) + "o Foi Cancelada Sem Confirma" + ;
                            CHR(231) + CHR(227) + "o")
                    ENDIF
                    THIS.Release()
                ENDIF
            ELSE
                THIS.Release()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "Erro Encerrar")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarBINDEVENTs - Vincular eventos de botoes (chamado em Fase 7/8)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBINDEVENTs
        BINDEVENT(THIS.cmd_4c_Confirmar,  "Click",              THIS, "BtnConfirmarClick")
        BINDEVENT(THIS.cmd_4c_Encerrar,   "Click",              THIS, "BtnEncerrarClick")
        BINDEVENT(THIS.grd_4c_Cab, "AfterRowColChange", THIS, "GrdCabAfterRowColChange")
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Alias CRUD para OPERACIONAL: incluir = gerar novo
    *   pedido de movimentacao a partir da linha selecionada no GrdCab.
    *   Delega para BtnConfirmarClick (mesma logica do CmdGrava original).
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.BtnConfirmarClick()
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Alias CRUD para OPERACIONAL: alterar = re-confirmar
    *   a geracao do pedido da linha selecionada. Delega para BtnConfirmarClick.
    *   O legado nao tem "alterar" separado; GerarPedido no BO ja checa
    *   csCabec.Gerado e reprocessa somente pedidos ainda nao gerados.
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        THIS.BtnConfirmarClick()
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Alias CRUD para OPERACIONAL: visualizar = re-sincronizar
    *   cursores csCabec/csItens (SET KEY TO csCabec.EmpDopNums + GO TOP) e
    *   forcar refresh das grades. Nao abre nenhum picker adicional; o proprio
    *   layout do form (grid superior + grid inferior) ja e a visualizacao.
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        THIS.CarregarDados()
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Alias CRUD para OPERACIONAL: excluir = descartar/encerrar
    *   sem confirmar movimentacoes pendentes. Delega para BtnEncerrarClick que
    *   ja implementa a checagem de operacoes nao confirmadas (Gerado vazio) e
    *   pede MsgConfirma antes de fechar (comportamento do CmdCancela original).
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        THIS.BtnEncerrarClick()
    ENDPROC

    *==========================================================================
    * CarregarLista - Alias de compatibilidade com pipeline CRUD
    *   Para OPERACIONAL: equivale a sincronizar e atualizar as grades.
    *==========================================================================
    PROCEDURE CarregarLista
        THIS.CarregarDados()
    ENDPROC

    *==========================================================================
    * FormParaBO - Popula BO com dados do registro corrente de csCabec
    *   Para OPERACIONAL sem campos editaveis no form, transfere o contexto
    *   do cursor para o BO (usado por auditoria e geracao de pedido).
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO
        IF USED("csCabec") AND !EOF("csCabec")
            THIS.this_oBusinessObject.CarregarDoCursor("csCabec")
        ENDIF
    ENDPROC

    *==========================================================================
    * BOParaForm - Atualiza grades a partir do estado atual do BO/cursores
    *   Para OPERACIONAL: forca refresh das grades sem reposicionar cursores.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm
        IF VARTYPE(THIS.grd_4c_Cab) = "O"
            THIS.grd_4c_Cab.Refresh()
        ENDIF
        IF VARTYPE(THIS.grd_4c_Ite) = "O"
            THIS.grd_4c_Ite.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Para OPERACIONAL: grades sao sempre ReadOnly
    *   Mantido para compatibilidade com pipeline; nao ha controles editaveis.
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        *-- Nao ha campos editaveis neste form operacional
    ENDPROC

    *==========================================================================
    * LimparCampos - Para OPERACIONAL: forca refresh das grades
    *   Nao ha campos de entrada para limpar; apenas atualiza visualizacao.
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos
        IF VARTYPE(THIS.grd_4c_Cab) = "O"
            THIS.grd_4c_Cab.Refresh()
        ENDIF
        IF VARTYPE(THIS.grd_4c_Ite) = "O"
            THIS.grd_4c_Ite.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Para OPERACIONAL: botoes Confirmar e Encerrar
    *   sao sempre visiveis e habilitados independente de "modo".
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo
        IF VARTYPE(THIS.cmd_4c_Confirmar) = "O"
            THIS.cmd_4c_Confirmar.Enabled = .T.
        ENDIF
        IF VARTYPE(THIS.cmd_4c_Encerrar) = "O"
            THIS.cmd_4c_Encerrar.Enabled = .T.
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Alias CRUD para OPERACIONAL: buscar = sincronizar grades
    *   Reposiciona cursores e forca refresh das duas grades.
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.CarregarDados()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Alias CRUD para OPERACIONAL: salvar = confirmar geracao
    *   Delega para BtnConfirmarClick (mesma logica do CmdGrava original).
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.BtnConfirmarClick()
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Alias CRUD para OPERACIONAL: cancelar = encerrar
    *   Delega para BtnEncerrarClick com checagem de pedidos nao confirmados.
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.BtnEncerrarClick()
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy
    *==========================================================================
        THIS.this_oFormPai = .NULL.
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrGstBO.prg):
*==============================================================================
* SigPrGstBO.prg - Business Object: Geracao de Movimentacoes de Estoque
*
* Tabela principal : SigMvCab (cabecalho de movimentacao gerado)
* Chave primaria   : EmpDopNums (composta: Emps + Dopes + STR(Numes,6))
* Herda de         : BusinessBase
*
* Este BO opera sobre cursores passados pelo formulario pai:
*   Entrada  : csCabec, csItens, CsEstPe, CrSigCdNec
*   Saida    : SigMvCab, SigMvItn, SigMvIts, SigMvPec, SigInBep (via SQLEXEC)
*==============================================================================

DEFINE CLASS SigPrGstBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Contexto do formulario (recebido do pai via Init)
    *--------------------------------------------------------------------------
    this_cGrupoOper     = ""    && Grupo de operacao (C10)
    this_cPcEscolha     = ""    && Escolha de processamento passada pelo pai

    *--------------------------------------------------------------------------
    * Campos de csCabec - Cabecalho da necessidade/pedido de origem
    *--------------------------------------------------------------------------
    this_cEmps          = ""    && Empresa (C3)
    this_cEmpDs         = ""    && Descricao da empresa (display)
    this_cDopes         = ""    && Codigo da operacao (C20)
    this_nNumes         = 0     && Numero do pedido (N6,0)
    this_cMascNum       = ""    && Mascara formatada do numero
    this_dDatars        = {}    && Data de referencia do pedido
    this_cIdChaves      = ""    && ID unico (via fUniqueIds)
    this_cEmpDopNums    = ""    && Chave composta: Emps + Dopes + STR(Numes,6) (C29)
    this_cEmpDnPs       = ""    && Chave composta da NEC origem (EmpDnPs)
    this_cGrupoOs       = ""    && Grupo de Conta Origem (C10)
    this_cContaOs       = ""    && Conta de Origem (C10)
    this_cGrupoDs       = ""    && Grupo de Conta Destino (C10)
    this_cContaDs       = ""    && Conta de Destino (C10)
    this_cGerado        = ""    && Flag: "OK" se pedido ja gerou movimento
    this_cGerEmps       = ""    && Empresa do movimento gerado (SigMvCab.Emps)
    this_cGerDopes      = ""    && Operacao do movimento gerado (SigMvCab.Dopes)
    this_nGerNumes      = 0     && Numero do movimento gerado (SigMvCab.Numes, N6,0)

    *--------------------------------------------------------------------------
    * Campos de csItens - Item corrente do pedido
    *--------------------------------------------------------------------------
    this_nCItens        = 0     && Numero sequencial do item
    this_cCPros         = ""    && Codigo do produto
    this_cDPros         = ""    && Descricao do produto
    this_cMoedas        = ""    && Moeda de cotacao
    this_nUnits         = 0     && Preco unitario
    this_nQtds          = 0     && Quantidade solicitada
    this_nTotas         = 0     && Total do item

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = "EmpDopNums"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor csCabec para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cEmps       = TratarNulo(Emps, "C")
                THIS.this_cDopes      = TratarNulo(Dopes, "C")
                THIS.this_nNumes      = TratarNulo(Numes, "N")
                THIS.this_cMascNum    = TratarNulo(MascNum, "C")
                THIS.this_cGrupoOs    = TratarNulo(GrupoOs, "C")
                THIS.this_cContaOs    = TratarNulo(ContaOs, "C")
                THIS.this_cGrupoDs    = TratarNulo(GrupoDs, "C")
                THIS.this_cContaDs    = TratarNulo(ContaDs, "C")
                THIS.this_cGerado     = TratarNulo(Gerado, "C")
                THIS.this_cGerEmps    = TratarNulo(GerEmps, "C")
                THIS.this_cGerDopes   = TratarNulo(GerDopes, "C")
                THIS.this_nGerNumes   = TratarNulo(GerNumes, "N")
                THIS.this_cEmpDopNums = TratarNulo(EmpDopNums, "C")
                IF TYPE("EmpDnPs") != "U"
                    THIS.this_cEmpDnPs = TratarNulo(EmpDnPs, "C")
                ENDIF
                IF TYPE("Datars") != "U"
                    THIS.this_dDatars = TratarNulo(Datars, "D")
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria do registro corrente
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cEmpDopNums)
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Verifica pre-condicoes para gerar pedido
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        IF !USED("csCabec") OR EOF("csCabec")
            THIS.this_cMensagemErro = "Selecione um pedido na grade e tente novamente."
            RETURN .F.
        ENDIF
        IF !EMPTY(ALLTRIM(csCabec.Gerado))
            THIS.this_cMensagemErro = "Este pedido j" + CHR(225) + " foi gerado anteriormente."
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarPedido - Opera principal: gera movimentacoes de estoque a partir
    *   dos cursores csCabec, csItens e CsEstPe para as tabelas SQL Server.
    *   Equivalente ao PROCEDURE gerarpedido do formulario legado.
    *--------------------------------------------------------------------------
    PROCEDURE GerarPedido()
        LOCAL loc_lResultado, loc_lOks, loc_lTransacaoAberta
        LOCAL loc_nNum, loc_cMascNum, loc_cEmpDopNums, loc_cSQL
        LOCAL loc_cEmps, loc_cDopes, loc_cGrupoOs, loc_cContaOs
        LOCAL loc_cGrupoDs, loc_cContaDs, loc_cEmpDnPsNec
        LOCAL loc_loBarra

        loc_lResultado       = .F.
        loc_lOks             = .T.
        loc_lTransacaoAberta = .F.

        TRY
            *-- Verificar pre-condicoes
            IF !THIS.ValidarDados()
                MsgAviso(THIS.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ELSE

                *-- Se ja gerado, retornar .T. diretamente (sem nova geracao)
                IF !EMPTY(ALLTRIM(csCabec.Gerado))
                    loc_lResultado = .T.
                ELSE

                    *-- Capturar campos do csCabec ANTES de qualquer SQLEXEC
                    loc_cEmps    = ALLTRIM(csCabec.Emps)
                    loc_cDopes   = PADR(ALLTRIM(csCabec.Dopes), 20)
                    loc_cGrupoOs = ALLTRIM(csCabec.GrupoOs)
                    loc_cContaOs = ALLTRIM(csCabec.ContaOs)
                    loc_cGrupoDs = ALLTRIM(csCabec.GrupoDs)
                    loc_cContaDs = ALLTRIM(csCabec.ContaDs)

                    *-- Capturar EmpDnPs de CrSigCdNec
                    loc_cEmpDnPsNec = ""
                    IF USED("CrSigCdNec") AND !EOF("CrSigCdNec")
                        loc_cEmpDnPsNec = ALLTRIM(CrSigCdNec.EmpDnPs)
                    ENDIF

                    *-- Carregar SigCdEmb para divisao de embalagem
                    loc_cSQL = "SELECT Cods, Multis FROM SigCdEmb"
                    IF USED("crSigCdEmb")
                        USE IN crSigCdEmb
                    ENDIF
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdEmb") < 1
                        loc_lOks = .F.
                        MsgErro("Falha ao carregar tabela de embalagem (SigCdEmb)", "Erro")
                    ENDIF

                    IF loc_lOks
                        SELECT crSigCdEmb
                        INDEX ON UPPER(ALLTRIM(Cods)) TAG Cods
                        GO TOP IN crSigCdEmb

                        *-- Gerar numero unico e mascara para o novo movimento
                        loc_nNum        = fGerUniqueKey(ALLTRIM(loc_cDopes) + go_4c_Sistema.cCodEmpresa)
                        loc_cMascNum    = ALLTRIM(fGerMascara(loc_nNum))
                        loc_cEmpDopNums = loc_cEmps + PADR(ALLTRIM(loc_cDopes), 20) + STR(loc_nNum, 6)

                        *-- Barra de progresso
                        loc_loBarra = CREATEOBJECT("fwprogressbar", ;
                            "Gravando " + ALLTRIM(loc_cDopes) + "...", 3)
                        loc_loBarra.Show()
                        loc_loBarra.Update(.T., "Gerando Informa" + CHR(231) + CHR(245) + ;
                            "es Para Lan" + CHR(231) + "amento")

                        *-- Iniciar transacao SQL Server
                        SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
                        loc_lTransacaoAberta = .T.

                        *-- INSERT INTO SigMvCab
                        loc_cSQL = "INSERT INTO SigMvCab " + ;
                                   "(emps, dopes, numes, datars, mascnum, " + ;
                                   " grupoos, contaos, grupods, contads, " + ;
                                   " usuars, empdopnums, cidchaves, empdnps, dtalts) " + ;
                                   "VALUES (" + ;
                                   EscaparSQL(loc_cEmps) + ", " + ;
                                   EscaparSQL(PADR(ALLTRIM(loc_cDopes), 20)) + ", " + ;
                                   FormatarNumeroSQL(loc_nNum, 0) + ", " + ;
                                   FormatarDataSQL(DATE()) + ", " + ;
                                   EscaparSQL(LEFT(loc_cMascNum, 10)) + ", " + ;
                                   EscaparSQL(LEFT(loc_cGrupoOs, 10)) + ", " + ;
                                   EscaparSQL(LEFT(loc_cContaOs, 10)) + ", " + ;
                                   EscaparSQL(LEFT(loc_cGrupoDs, 10)) + ", " + ;
                                   EscaparSQL(LEFT(loc_cContaDs, 10)) + ", " + ;
                                   EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10)) + ", " + ;
                                   EscaparSQL(loc_cEmpDopNums) + ", " + ;
                                   EscaparSQL(fUniqueIds()) + ", " + ;
                                   EscaparSQL(LEFT(loc_cEmpDnPsNec, 29)) + ", " + ;
                                   "GETDATE())"
                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            loc_lOks = .F.
                            MsgErro("Falha ao inserir cabe" + CHR(231) + "alho de " + ;
                                "movimenta" + CHR(231) + CHR(227) + "o (SigMvCab)", "Erro")
                        ENDIF
                    ENDIF

                    IF loc_lOks
                        *-- INSERT INTO SigInBep (rastreio - mesmo conteudo que SigMvCab)
                        loc_cSQL = "INSERT INTO SigInBep " + ;
                                   "(emps, dopes, numes, datars, mascnum, " + ;
                                   " grupoos, contaos, grupods, contads, " + ;
                                   " usuars, empdopnums, cidchaves, empdnps, dtalts) " + ;
                                   "VALUES (" + ;
                                   EscaparSQL(loc_cEmps) + ", " + ;
                                   EscaparSQL(PADR(ALLTRIM(loc_cDopes), 20)) + ", " + ;
                                   FormatarNumeroSQL(loc_nNum, 0) + ", " + ;
                                   FormatarDataSQL(DATE()) + ", " + ;
                                   EscaparSQL(LEFT(loc_cMascNum, 10)) + ", " + ;
                                   EscaparSQL(LEFT(loc_cGrupoOs, 10)) + ", " + ;
                                   EscaparSQL(LEFT(loc_cContaOs, 10)) + ", " + ;
                                   EscaparSQL(LEFT(loc_cGrupoDs, 10)) + ", " + ;
                                   EscaparSQL(LEFT(loc_cContaDs, 10)) + ", " + ;
                                   EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10)) + ", " + ;
                                   EscaparSQL(loc_cEmpDopNums) + ", " + ;
                                   EscaparSQL(fUniqueIds()) + ", " + ;
                                   EscaparSQL(LEFT(loc_cEmpDnPsNec, 29)) + ", " + ;
                                   "GETDATE())"
                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            loc_lOks = .F.
                            MsgErro("Falha ao inserir registro de rastreio (SigInBep)", "Erro")
                        ENDIF
                    ENDIF

                    IF loc_lOks
                        loc_loBarra.Update(.T., "Gerando Informa" + CHR(231) + CHR(245) + ;
                            "es Dos Itens")

                        *-- Processar itens de csItens -> SigMvItn e SigMvIts
                        LOCAL loc_nCItens, loc_cCPros, loc_cDPros, loc_cMoedas
                        LOCAL loc_nUnits, loc_nQtds, loc_nTotas
                        LOCAL loc_cCGrus, loc_cCUnisPro, loc_nTipoEstos, loc_nEmbs
                        LOCAL loc_cSQLItem, loc_nMultis, loc_cCodEmbs, loc_nQtdEmb
                        LOCAL loc_lSub

                        IF USED("csItens")
                            SELECT csItens
                            SET KEY TO csCabec.EmpDopNums
                            GO TOP

                            SCAN
                                IF !loc_lOks
                                    LOOP
                                ENDIF

                                *-- Capturar campos do item ANTES de SQLEXEC
                                loc_nCItens = csItens.CItens
                                loc_cCPros  = ALLTRIM(csItens.CPros)
                                loc_cDPros  = LEFT(ALLTRIM(csItens.DPros), 65)
                                loc_cMoedas = LEFT(ALLTRIM(csItens.Moedas), 3)
                                loc_nUnits  = NVL(csItens.Units, 0)
                                loc_nQtds   = NVL(csItens.Qtds, 0)
                                loc_nTotas  = NVL(csItens.Totas, 0)

                                *-- Buscar dados do produto (grupo e unidade)
                                loc_cCGrus   = ""
                                loc_cCUnisPro = ""
                                loc_cSQLItem = "SELECT TOP 1 cgrus, cunis FROM SigCdPro " + ;
                                               "WHERE cpros = " + EscaparSQL(loc_cCPros)
                                IF USED("crTmpPro")
                                    USE IN crTmpPro
                                ENDIF
                                IF SQLEXEC(gnConnHandle, loc_cSQLItem, "crTmpPro") > 0
                                    SELECT crTmpPro
                                    IF !EOF()
                                        loc_cCGrus    = ALLTRIM(cgrus)
                                        loc_cCUnisPro = ALLTRIM(cunis)
                                    ENDIF
                                ENDIF

                                *-- Buscar tipo do grupo (para verificar embalagem)
                                loc_nTipoEstos = 0
                                loc_nEmbs      = 0
                                IF !EMPTY(loc_cCGrus)
                                    loc_cSQLItem = "SELECT TOP 1 tipoestos, embs FROM SigCdGrp " + ;
                                                   "WHERE cgrus = " + EscaparSQL(loc_cCGrus)
                                    IF USED("crTmpGru")
                                        USE IN crTmpGru
                                    ENDIF
                                    IF SQLEXEC(gnConnHandle, loc_cSQLItem, "crTmpGru") > 0
                                        SELECT crTmpGru
                                        IF !EOF()
                                            loc_nTipoEstos = NVL(tipoestos, 0)
                                            loc_nEmbs      = NVL(embs, 0)
                                        ENDIF
                                    ENDIF
                                ENDIF

                                *-- INSERT INTO SigMvItn
                                loc_cSQLItem = "INSERT INTO SigMvItn " + ;
                                    "(emps, dopes, numes, citens, cpros, dpros, " + ;
                                    " moedas, units, qtds, totas, empdopnums, cidchaves, dtalts) " + ;
                                    "VALUES (" + ;
                                    EscaparSQL(loc_cEmps) + ", " + ;
                                    EscaparSQL(PADR(ALLTRIM(loc_cDopes), 20)) + ", " + ;
                                    FormatarNumeroSQL(loc_nNum, 0) + ", " + ;
                                    FormatarNumeroSQL(loc_nCItens, 0) + ", " + ;
                                    EscaparSQL(loc_cCPros) + ", " + ;
                                    EscaparSQL(loc_cDPros) + ", " + ;
                                    EscaparSQL(loc_cMoedas) + ", " + ;
                                    FormatarNumeroSQL(loc_nUnits, 5) + ", " + ;
                                    FormatarNumeroSQL(loc_nQtds, 3) + ", " + ;
                                    FormatarNumeroSQL(loc_nTotas, 2) + ", " + ;
                                    EscaparSQL(loc_cEmpDopNums) + ", " + ;
                                    EscaparSQL(fUniqueIds()) + ", " + ;
                                    "GETDATE())"
                                IF SQLEXEC(gnConnHandle, loc_cSQLItem) < 1
                                    loc_lOks = .F.
                                    MsgErro("Falha ao inserir item de movimenta" + ;
                                        CHR(231) + CHR(227) + "o (SigMvItn)", "Erro")
                                ENDIF

                                *-- Verificar embalagem e inserir SigMvIts se aplicavel
                                IF loc_lOks
                                    loc_lSub = (INLIST(loc_nTipoEstos, 2, 3, 4) OR loc_nEmbs = 1)
                                    IF loc_lSub AND !EMPTY(loc_cCUnisPro)
                                        loc_nMultis  = 0
                                        loc_cCodEmbs = ""
                                        SELECT crSigCdEmb
                                        IF SEEK(UPPER(ALLTRIM(loc_cCUnisPro)), "crSigCdEmb", "Cods")
                                            loc_nMultis  = NVL(crSigCdEmb.Multis, 0)
                                            loc_cCodEmbs = ALLTRIM(crSigCdEmb.Cods)
                                        ENDIF

                                        IF loc_nMultis > 0 AND !EMPTY(loc_cCodEmbs)
                                            loc_nQtdEmb = loc_nQtds / loc_nMultis
                                            loc_cSQLItem = "INSERT INTO SigMvIts " + ;
                                                "(emps, dopes, numes, cpros, citens, qtds, " + ;
                                                " codembs, qtdembs, empdopnums, cidchaves, dtalts) " + ;
                                                "VALUES (" + ;
                                                EscaparSQL(loc_cEmps) + ", " + ;
                                                EscaparSQL(PADR(ALLTRIM(loc_cDopes), 20)) + ", " + ;
                                                FormatarNumeroSQL(loc_nNum, 0) + ", " + ;
                                                EscaparSQL(loc_cCPros) + ", " + ;
                                                FormatarNumeroSQL(loc_nCItens, 0) + ", " + ;
                                                FormatarNumeroSQL(loc_nQtdEmb, 3) + ", " + ;
                                                EscaparSQL(loc_cCodEmbs) + ", " + ;
                                                FormatarNumeroSQL(loc_nMultis, 3) + ", " + ;
                                                EscaparSQL(loc_cEmpDopNums) + ", " + ;
                                                EscaparSQL(fUniqueIds()) + ", " + ;
                                                "GETDATE())"
                                            IF SQLEXEC(gnConnHandle, loc_cSQLItem) < 1
                                                loc_lOks = .F.
                                                MsgErro("Falha ao inserir subitem de embalagem (SigMvIts)", "Erro")
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF

                                SELECT csItens
                            ENDSCAN

                            SELECT csItens
                            SET KEY TO
                        ENDIF
                    ENDIF

                    IF loc_lOks
                        *-- Processar CsEstPe -> SigMvPec
                        IF USED("CsEstPe")
                            LOCAL loc_nCodigos, loc_dDatatrans, loc_nNtrans
                            LOCAL loc_cLocals, loc_nValobxs, loc_cEmpSubsLocal
                            LOCAL loc_dDatas, loc_lChksubn, loc_dDtagends
                            LOCAL loc_lChkpagos, loc_nNparcs, loc_nValps
                            LOCAL loc_nValvars, loc_dVencps, loc_cPstatus
                            LOCAL loc_cEmpDopNumsPec, loc_cSQLPec

                            SELECT CsEstPe
                            SET KEY TO csCabec.EmpDopNums
                            GO TOP

                            SCAN
                                IF !loc_lOks
                                    LOOP
                                ENDIF

                                *-- Capturar campos ANTES de SQLEXEC
                                loc_nCodigos     = NVL(CsEstPe.Codigos, 0)
                                loc_dDatatrans   = CsEstPe.Datatrans
                                loc_nNtrans      = NVL(CsEstPe.Ntrans, 0)
                                loc_cLocals      = ALLTRIM(CsEstPe.Locals)
                                loc_nValobxs     = NVL(CsEstPe.Valobxs, 0)
                                loc_cEmpSubsLocal = ALLTRIM(go_4c_Sistema.cCodEmpresa)
                                loc_dDatas       = CsEstPe.Datas
                                loc_lChksubn     = IIF(VARTYPE(CsEstPe.Chksubn) = "L", ;
                                                       CsEstPe.Chksubn, ;
                                                       NVL(CsEstPe.Chksubn, 0) = 1)
                                loc_dDtagends    = CsEstPe.Dtagends
                                loc_lChkpagos    = IIF(VARTYPE(CsEstPe.Chkpagos) = "L", ;
                                                       CsEstPe.Chkpagos, ;
                                                       NVL(CsEstPe.Chkpagos, 0) = 1)
                                loc_nNparcs      = NVL(CsEstPe.Nparcs, 0)
                                loc_nValps       = NVL(CsEstPe.Valps, 0)
                                loc_nValvars     = NVL(CsEstPe.Valvars, 0)
                                loc_dVencps      = CsEstPe.Vencps
                                loc_cPstatus     = LEFT(ALLTRIM(CsEstPe.Pstatus), 1)
                                loc_cEmpDopNumsPec = loc_cEmps + PADR(ALLTRIM(loc_cDopes), 20) + ;
                                                     STR(loc_nNum, 6)

                                loc_cSQLPec = "INSERT INTO SigMvPec " + ;
                                    "(emps, dopes, numes, codigos, datatrans, ntrans, " + ;
                                    " locals, valobxs, cidchaves, empdopnums, empsubns, " + ;
                                    " datas, chksubn, dtagends, chkpagos, nparcs, " + ;
                                    " valps, valvars, vencps, pstatus) " + ;
                                    "VALUES (" + ;
                                    EscaparSQL(loc_cEmps) + ", " + ;
                                    EscaparSQL(PADR(ALLTRIM(loc_cDopes), 20)) + ", " + ;
                                    FormatarNumeroSQL(loc_nNum, 0) + ", " + ;
                                    FormatarNumeroSQL(loc_nCodigos, 0) + ", " + ;
                                    FormatarDataSQL(loc_dDatatrans) + ", " + ;
                                    FormatarNumeroSQL(loc_nNtrans, 0) + ", " + ;
                                    EscaparSQL(LEFT(loc_cLocals, 10)) + ", " + ;
                                    FormatarNumeroSQL(loc_nValobxs, 2) + ", " + ;
                                    EscaparSQL(fUniqueIds()) + ", " + ;
                                    EscaparSQL(loc_cEmpDopNumsPec) + ", " + ;
                                    EscaparSQL(LEFT(loc_cEmpSubsLocal, 3)) + ", " + ;
                                    FormatarDataSQL(loc_dDatas) + ", " + ;
                                    IIF(loc_lChksubn, "1", "0") + ", " + ;
                                    FormatarDataSQL(loc_dDtagends) + ", " + ;
                                    IIF(loc_lChkpagos, "1", "0") + ", " + ;
                                    FormatarNumeroSQL(loc_nNparcs, 0) + ", " + ;
                                    FormatarNumeroSQL(loc_nValps, 2) + ", " + ;
                                    FormatarNumeroSQL(loc_nValvars, 2) + ", " + ;
                                    FormatarDataSQL(loc_dVencps) + ", " + ;
                                    EscaparSQL(loc_cPstatus) + ")"
                                IF SQLEXEC(gnConnHandle, loc_cSQLPec) < 1
                                    loc_lOks = .F.
                                    MsgErro("Falha ao inserir parcela de pedido (SigMvPec)", "Erro")
                                ENDIF

                                SELECT CsEstPe
                            ENDSCAN

                            SELECT CsEstPe
                            SET KEY TO
                        ENDIF
                    ENDIF

                    IF loc_lOks
                        loc_loBarra.Update(.T., "Preparando Grava" + CHR(231) + CHR(227) + "o")

                        *-- Auditoria
                        THIS.this_cDopes    = ALLTRIM(loc_cDopes)
                        THIS.this_cGerEmps  = loc_cEmps
                        THIS.this_cGerDopes = ALLTRIM(loc_cDopes)
                        THIS.this_nGerNumes = loc_nNum
                        THIS.RegistrarAuditoria("GERAR")

                        *-- Commit da transacao
                        IF SQLEXEC(gnConnHandle, "COMMIT TRANSACTION") < 1
                            loc_lOks = .F.
                            MsgErro("Falha ao confirmar a transa" + CHR(231) + CHR(227) + "o", "Erro")
                        ELSE
                            loc_lTransacaoAberta = .F.
                        ENDIF
                    ENDIF

                    IF !loc_lOks AND loc_lTransacaoAberta
                        SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                        loc_lTransacaoAberta = .F.
                    ENDIF

                    IF loc_lOks
                        *-- Atualizar csCabec local com marcacao de gerado
                        SELECT csCabec
                        REPLACE Gerado   WITH "OK", ;
                                GerEmps  WITH loc_cEmps, ;
                                GerDopes WITH ALLTRIM(loc_cDopes), ;
                                GerNumes WITH loc_nNum

                        THIS.this_cEmpDopNums = loc_cEmpDopNums
                        loc_lResultado = .T.
                    ENDIF

                    *-- Fechar cursores temporarios
                    IF USED("crSigCdEmb")
                        USE IN crSigCdEmb
                    ENDIF
                    IF USED("crTmpPro")
                        USE IN crTmpPro
                    ENDIF
                    IF USED("crTmpGru")
                        USE IN crTmpGru
                    ENDIF

                    loc_loBarra.Complete(.T.)

                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "Erro GerarPedido")
            IF loc_lTransacaoAberta
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
            ENDIF
        ENDTRY

        *-- Restaurar SET KEY dos cursores de iteracao
        IF USED("csItens")
            SELECT csItens
            SET KEY TO
        ENDIF
        IF USED("CsEstPe")
            SELECT CsEstPe
            SET KEY TO
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarPeriodo - Stub de compatibilidade com chamadas de SigMvCab
    * O formulario legado definia este metodo para nao gerar erro nas chamadas
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarPeriodo(par_P1, par_P2, par_P3)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Log da operacao de geracao de movimento
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cMsg, loc_cDopps
        loc_cDopps = ""
        IF USED("CrSigCdNec") AND !EOF("CrSigCdNec")
            IF TYPE("CrSigCdNec.Dopps") != "U"
                loc_cDopps = ALLTRIM(CrSigCdNec.Dopps)
            ENDIF
        ENDIF
        loc_cMsg = "Ger.Movim.: " + ALLTRIM(THIS.this_cGerDopes) + ;
                   " Num." + ALLTRIM(STR(THIS.this_nGerNumes, 6)) + ;
                   " Emp." + ALLTRIM(THIS.this_cGerEmps)
        IF !EMPTY(loc_cDopps)
            =fGravarLog("T", loc_cDopps, gc_4c_UsuarioLogado, loc_cMsg)
        ENDIF
    ENDPROC

ENDDEFINE

