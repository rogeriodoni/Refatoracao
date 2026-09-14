# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[FormSigPrAop.prg] Indicador de pendencia: *-- Reverte alteracoes pendente

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrAop.prg):
*==============================================================================
* FormSigPrAop.prg - Formulario OPERACIONAL: Alteracao de Quantidade da O.P.
* Equivalente ao SIGPRAOP.SCX do legado
* Herda de FormBase
*==============================================================================

DEFINE CLASS FormSigPrAop AS FormBase

    *-- Dimensoes (proporcional ao original 702x436 escalado para 1000x600)
    Width         = 1000
    Height        = 600

    *-- Aparencia (reproduz propriedades visuais do SCX legado)
    Caption       = "Altera" + CHR(231) + CHR(227) + "o de Quantidade da O.P."
    TitleBar      = 0
    ShowWindow = 1
    WindowType = 1
    ControlBox    = .F.
    Closable      = .F.
    MaxButton     = .F.
    MinButton     = .F.
    AutoCenter    = .T.
    BorderStyle   = 2
    Themes        = .F.

    *-- Sessao privada (DataSession=2 no original - fix de locale em FormBase.Init)
    DataSession   = 2

    *-- Nome do cursor de trabalho (espelho do Temp_DivOp do legado)
    this_cCursorDivOp = "cursor_4c_DivOp"

    *---------------------------------------------------------------------------
    PROCEDURE Init()
    *-- FormBase.Init() faz SET DATE BRITISH/CENTURY ON e chama InicializarForm()
    *---------------------------------------------------------------------------
        RETURN DODEFAULT()
    ENDPROC

    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
    *-- Para form OPERACIONAL plano (sem PageFrame): define aparencia base do form
    *---------------------------------------------------------------------------
        THIS.Picture    = gc_4c_CaminhoIcones + "new_background.jpg"
        THIS.ScrollBars = 0
        THIS.ShowTips   = .F.
    ENDPROC

    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            *-- Aparencia base do form
            THIS.ConfigurarPageFrame()

            *-- Inicializar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrAopBO")
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Carregar parametros do sistema (SigCdPam: DoppPads, MascNums)
                THIS.this_oBusinessObject.CarregarParametros()

                *-- Criar cursor de trabalho (estrutura identica ao Temp_DivOp do legado)
                IF USED(THIS.this_cCursorDivOp)
                    USE IN (THIS.this_cCursorDivOp)
                ENDIF
                SET NULL ON
                CREATE CURSOR cursor_4c_DivOp ;
                    (Dopes    C(20)    NULL, ;
                     Numes    N(6,0)   NULL, ;
                     Qtds     N(12,3)  NULL, ;
                     QtdDivs  N(12,3)  NULL, ;
                     Dataes   D        NULL, ;
                     Obss     M        NULL, ;
                     SeqDivs  N(3,0)   NULL, ;
                     Cpros    C(10)    NULL, ;
                     CodCors  C(4)     NULL, ;
                     CodTams  C(4)     NULL, ;
                     Citens   N(10,0)  NULL, ;
                     cIdChaves C(50)   NULL, ;
                     Nops     N(10,0)  NULL)
                SET NULL OFF

                *-- Criar componentes visuais
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoesConf()
                THIS.ConfigurarPaginaDados()
                THIS.ConfigurarPaginaLista()

                *-- Vincular eventos dos botoes Confirmar/Encerrar do CommandGroup
                BINDEVENT(THIS.cmg_4c_BotoesConf.Buttons(1), "Click", THIS, "BtnConfirmarClick")
                BINDEVENT(THIS.cmg_4c_BotoesConf.Buttons(2), "Click", THIS, "BtnEncerrarClick")

                *-- Tornar todos os controles visiveis (AddObject cria com Visible=.F.)
                THIS.TornarControlesVisiveis(THIS)

                *-- Foco inicial no campo O.P.
                IF PEMSTATUS(THIS, "txt_4c_OP", 5) AND VARTYPE(THIS.txt_4c_OP) = "O"
                    THIS.txt_4c_OP.SetFocus()
                ENDIF

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar SigPrAopBO.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, ;
                    "Erro ao inicializar FormSigPrAop")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
    *-- Container escuro no topo com labels sombra+titulo (equivale ao cntSombra)
    *---------------------------------------------------------------------------
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top      = 18
                .Left     = 10
                .Width    = THIS.Width
                .Height   = 40
                .AutoSize = .F.
                .FontName = "Tahoma"
                .FontSize = 18
                .FontBold = .T.
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Caption  = "Altera" + CHR(231) + CHR(227) + "o de Quantidade da O.P."
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top      = 17
                .Left     = 10
                .Width    = THIS.Width
                .Height   = 46
                .AutoSize = .F.
                .FontName = "Tahoma"
                .FontSize = 18
                .FontBold = .T.
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .Caption  = "Altera" + CHR(231) + CHR(227) + "o de Quantidade da O.P."
            ENDWITH
        ENDWITH
    ENDPROC

    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesConf()
    *-- CommandGroup com botoes Confirmar e Encerrar (equivale ao Grupo_Conf)
    *-- Posicionado no canto superior direito
    *---------------------------------------------------------------------------
        THIS.AddObject("cmg_4c_BotoesConf", "CommandGroup")
        WITH THIS.cmg_4c_BotoesConf
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .AutoSize      = .T.
            .Themes        = .F.
            .Top           = 0
            .Left          = 840
            .Width         = 160
            .Height        = 85

            WITH .Buttons(1)
                .Top        = 5
                .Left       = 5
                .Width      = 75
                .Height     = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .Caption    = "\<Confirmar"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
                .Picture    = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .Enabled    = .F.
            ENDWITH

            WITH .Buttons(2)
                .Top        = 5
                .Left       = 80
                .Width      = 75
                .Height     = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .Caption    = "Encerrar"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
                .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel     = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrade()
    *-- Grid principal com divisoes da O.P. (equivale ao Grade do legado)
    *-- 5 colunas: Pedido (expr), Cor, Tam, Quantidade (RO), Qtd.Atual (editavel)
    *---------------------------------------------------------------------------
        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .Top           = 195
            .Left          = 50
            .Width         = 700
            .Height        = 285
            .ColumnCount   = 5
            .FontName      = "Arial"
            .FontSize      = 8
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .GridLines     = 3
            .GridLineWidth = 1
            .HeaderHeight  = 17
            .RowHeight     = 17
            .ScrollBars    = 2
            .RecordSource  = THIS.this_cCursorDivOp

            *-- Coluna 1: Pedido (expressao Dopes + Numes, ReadOnly)
            WITH .Column1
                .ControlSource = "RTRIM(cursor_4c_DivOp.Dopes) + ' ' + LTRIM(STR(cursor_4c_DivOp.Numes, 6))"
                .Width         = 280
                .FontName      = "Arial"
                .FontSize      = 8
                .Alignment     = 0
                .ForeColor     = RGB(0, 0, 0)
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .Header1.Caption   = "Pedido"
                .Header1.FontName  = "Arial"
                .Header1.FontSize  = 8
                .Header1.FontBold  = .F.
                .Header1.Alignment = 2
            ENDWITH

            *-- Coluna 2: Cor (CodCors, ReadOnly)
            WITH .Column2
                .ControlSource = "cursor_4c_DivOp.CodCors"
                .Width         = 60
                .FontName      = "Arial"
                .FontSize      = 8
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .Header1.Caption   = "Cor"
                .Header1.FontName  = "Arial"
                .Header1.FontSize  = 8
                .Header1.FontBold  = .F.
                .Header1.Alignment = 2
            ENDWITH

            *-- Coluna 3: Tam (CodTams, ReadOnly)
            WITH .Column3
                .ControlSource = "cursor_4c_DivOp.CodTams"
                .Width         = 60
                .FontName      = "Arial"
                .FontSize      = 8
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .Header1.Caption   = "Tam"
                .Header1.FontName  = "Arial"
                .Header1.FontSize  = 8
                .Header1.FontBold  = .F.
                .Header1.Alignment = 2
            ENDWITH

            *-- Coluna 4: Quantidade planejada (Qtds, ReadOnly)
            WITH .Column4
                .ControlSource = "cursor_4c_DivOp.Qtds"
                .Width         = 130
                .FontName      = "Arial"
                .FontSize      = 8
                .Alignment     = 1
                .InputMask     = "999,999.999"
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .Header1.Caption   = "Quantidade"
                .Header1.FontName  = "Arial"
                .Header1.FontSize  = 8
                .Header1.FontBold  = .F.
                .Header1.Alignment = 2
            ENDWITH

            *-- Coluna 5: Qtd.Atual (QtdDivs, editavel ? Format K preserva valor atual)
            WITH .Column5
                .ControlSource = "cursor_4c_DivOp.QtdDivs"
                .Width         = 130
                .FontName      = "Arial"
                .FontSize      = 8
                .Alignment     = 1
                .Format        = "K"
                .Movable       = .F.
                .Resizable     = .F.
                .Header1.Caption   = "Qtd.Atual"
                .Header1.FontName  = "Arial"
                .Header1.FontSize  = 8
                .Header1.FontBold  = .F.
                .Header1.Alignment = 2
            ENDWITH
        ENDWITH

        BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
    *-- Atualiza EditBox de observacoes ao mudar de linha no grid (equivale
    *-- ao AfterRowColChange do Grade legado: ThisForm.Get_obss.Refresh)
    *---------------------------------------------------------------------------
        IF PEMSTATUS(THIS, "edt_4c_Obss", 5) AND VARTYPE(THIS.edt_4c_Obss) = "O"
            THIS.edt_4c_Obss.Refresh()
        ENDIF
    ENDPROC

    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
    *-- Area de entrada de dados do form OPERACIONAL: rotulos e textboxes de
    *-- identificacao (O.P. e Produto). Equivale semanticamente ao "Page2 -
    *-- Dados" dos CRUDs, adaptado para o layout plano de SIGPRAOP.
    *-- Nao contem PageFrame: os controles sao filhos diretos do form.
    *---------------------------------------------------------------------------
        *-- Label "O.P. :"
        THIS.AddObject("lbl_4c_OP", "Label")
        WITH THIS.lbl_4c_OP
            .Top       = 108
            .Left      = 70
            .Width     = 45
            .Height    = 18
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 9
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .Caption   = "O.P. :"
        ENDWITH

        *-- TextBox Get_OP (numero da ordem de producao)
        THIS.AddObject("txt_4c_OP", "TextBox")
        WITH THIS.txt_4c_OP
            .Top        = 105
            .Left       = 120
            .Width      = 120
            .Height     = 23
            .FontName   = "Tahoma"
            .FontSize   = 9
            .Alignment  = 1
            .Format     = "K"
            .InputMask  = "9999999999"
            .MaxLength  = 10
            .Value      = 0
            .ToolTipText = "Informe o n" + CHR(250) + "mero da Ordem de Produ" + CHR(231) + CHR(227) + "o e pressione ENTER"
        ENDWITH

        *-- Label "Produto :"
        THIS.AddObject("lbl_4c_Produto", "Label")
        WITH THIS.lbl_4c_Produto
            .Top       = 138
            .Left      = 50
            .Width     = 65
            .Height    = 18
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 9
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .Caption   = "Produto :"
        ENDWITH

        *-- TextBox Get_Produto (codigo do produto - somente leitura, preenchido apos validar OP)
        THIS.AddObject("txt_4c_Produto", "TextBox")
        WITH THIS.txt_4c_Produto
            .Top        = 135
            .Left       = 120
            .Width      = 120
            .Height     = 23
            .FontName   = "Tahoma"
            .FontSize   = 9
            .Alignment  = 0
            .MaxLength  = 10
            .ReadOnly   = .T.
            .Enabled    = .F.
            .BackColor  = RGB(240, 240, 240)
            .Value      = ""
            .ToolTipText = "C" + CHR(243) + "digo do produto da O.P. (preenchido automaticamente)"
        ENDWITH

        *-- Vincular eventos do TextBox de O.P.
        BINDEVENT(THIS.txt_4c_OP, "GotFocus",  THIS, "TxtOPGotFocus")
        BINDEVENT(THIS.txt_4c_OP, "KeyPress",  THIS, "TxtOPKeyPress")
        BINDEVENT(THIS.txt_4c_OP, "KeyPress", THIS, "TxtOPLostFocus")
    ENDPROC

    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
    *-- Area de visualizacao/lista do form OPERACIONAL: Grid de divisoes da
    *-- O.P. (5 colunas) e EditBox de observacoes da linha selecionada.
    *-- Equivale semanticamente ao "Page1 - Lista" dos CRUDs.
    *---------------------------------------------------------------------------
        *-- Grid de divisoes (5 colunas)
        THIS.ConfigurarGrade()

        *-- EditBox de observacoes (Get_obss) - abaixo do grid (ReadOnly, so exibe)
        THIS.AddObject("edt_4c_Obss", "EditBox")
        WITH THIS.edt_4c_Obss
            .Top              = 490
            .Left             = 50
            .Width            = 700
            .Height           = 90
            .FontName         = "Tahoma"
            .FontSize         = 9
            .BackColor        = RGB(255, 255, 255)
            .ForeColor        = RGB(0, 0, 0)
            .ScrollBars       = 2
            .ReadOnly         = .T.
            .ControlSource    = "cursor_4c_DivOp.Obss"
            .ToolTipText      = "Observa" + CHR(231) + CHR(245) + "es do item selecionado no grid"
        ENDWITH
    ENDPROC

    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
    *-- Form OPERACIONAL nao possui PageFrame (layout plano). Metodo mantido por
    *-- compatibilidade com padrao dos forms CRUD e para uso futuro caso o form
    *-- evolua para multi-pagina. Devolve foco ao campo O.P. quando invocado.
    *---------------------------------------------------------------------------
        LOCAL loc_nPagina
        loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)

        DO CASE
            CASE loc_nPagina = 1
                IF PEMSTATUS(THIS, "txt_4c_OP", 5) AND VARTYPE(THIS.txt_4c_OP) = "O"
                    IF THIS.txt_4c_OP.Enabled
                        THIS.txt_4c_OP.SetFocus()
                    ENDIF
                ENDIF
            OTHERWISE
                *-- Reservado para expansao futura
        ENDCASE

        RETURN .T.
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE TxtOPGotFocus()
    *-- Ao ganhar foco, desabilita Confirmar ate que nova O.P. seja validada
    *-- (equivale ao When do Get_OP no legado: Grupo_Conf.Salva.Enabled = .F.)
    *---------------------------------------------------------------------------
        THIS.cmg_4c_BotoesConf.Buttons(1).Enabled = .F.
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE TxtOPKeyPress(par_nKeyCode, par_nShiftAltCtrl)
    *-- ENTER(13) ou TAB(9) sobre o campo O.P. dispara a carga do cursor de
    *-- divisoes (equivale ao Valid do Get_OP no legado).
    *---------------------------------------------------------------------------
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.CarregarDivisoesOP()
        ENDIF
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE TxtOPLostFocus()
    *-- Ao sair do campo O.P., se ha divisoes carregadas transfere foco para o
    *-- grid (equivale ao LostFocus do Get_OP no legado).
    *---------------------------------------------------------------------------
        IF USED(THIS.this_cCursorDivOp) AND RECCOUNT(THIS.this_cCursorDivOp) > 0
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE CarregarDivisoesOP()
    *-- Valida O.P. digitada e carrega divisoes (SigOpPic) no cursor de trabalho.
    *---------------------------------------------------------------------------
        LOCAL loc_nOP, loc_lSucesso
        loc_lSucesso = .F.

        *-- Zerar cursor de trabalho antes de qualquer carga
        IF USED(THIS.this_cCursorDivOp)
            SELECT (THIS.this_cCursorDivOp)
            ZAP
        ENDIF

        *-- Desabilitar botao Confirmar enquanto O.P. nao for validada
        THIS.cmg_4c_BotoesConf.Buttons(1).Enabled = .F.
        THIS.txt_4c_Produto.Value = ""

        loc_nOP = INT(NVL(THIS.txt_4c_OP.Value, 0))
        IF loc_nOP <= 0
            THIS.grd_4c_Dados.Refresh()
            RETURN
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            MsgErro("Business Object n" + CHR(227) + "o inicializado.", "Erro")
            RETURN
        ENDIF

        loc_lSucesso = THIS.this_oBusinessObject.CarregarDivOp(loc_nOP, THIS.this_cCursorDivOp)

        IF loc_lSucesso
            THIS.txt_4c_Produto.Value = THIS.this_oBusinessObject.this_cCodPds
            THIS.cmg_4c_BotoesConf.Buttons(1).Enabled = .T.
            THIS.grd_4c_Dados.Refresh()
            IF PEMSTATUS(THIS, "edt_4c_Obss", 5) AND VARTYPE(THIS.edt_4c_Obss) = "O"
                THIS.edt_4c_Obss.Refresh()
            ENDIF
        ELSE
            THIS.grd_4c_Dados.Refresh()
            THIS.txt_4c_OP.SetFocus()
        ENDIF
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE BtnConfirmarClick()
    *-- Grava alteracoes das divisoes (equivale ao Grupo_Conf.Salva.Click do legado).
    *-- A logica SQL completa esta em SigPrAopBO.Inserir().
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            MsgErro("Business Object n" + CHR(227) + "o inicializado.", "Erro")
            RETURN
        ENDIF

        IF INT(NVL(THIS.txt_4c_OP.Value, 0)) <= 0
            MsgAviso("Informe uma O.P. v" + CHR(225) + "lida antes de confirmar.", "Aviso")
            THIS.txt_4c_OP.SetFocus()
            RETURN
        ENDIF

        IF !USED(THIS.this_cCursorDivOp) OR RECCOUNT(THIS.this_cCursorDivOp) = 0
            MsgAviso("Nenhuma divis" + CHR(227) + "o carregada para gravar.", "Aviso")
            RETURN
        ENDIF

        IF !MsgConfirma("Confirma a altera" + CHR(231) + CHR(227) + ;
                        "o das quantidades desta O.P.?", "Confirma" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        THIS.FormParaBO()
        loc_lSucesso = THIS.this_oBusinessObject.Inserir()

        IF loc_lSucesso
            MsgInfo("Altera" + CHR(231) + CHR(245) + "es gravadas com sucesso.", ;
                    "Sucesso")
            THIS.LimparCampos()
            IF PEMSTATUS(THIS, "txt_4c_OP", 5) AND VARTYPE(THIS.txt_4c_OP) = "O"
                THIS.txt_4c_OP.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
    *-- Encerra o formulario (equivale ao Grupo_Conf.Sair.Click do legado).
    *---------------------------------------------------------------------------
        THIS.Release()
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
    *-- Executa a busca pela O.P. informada em txt_4c_OP: valida o numero,
    *-- carrega SigOpPic no cursor de trabalho e transfere foco para o grid.
    *-- Equivale semanticamente ao "Consultar/Buscar" do padrao CRUD, mapeado
    *-- para o fluxo operacional (mesma logica do Valid do Get_OP legado).
    *---------------------------------------------------------------------------
        IF !PEMSTATUS(THIS, "txt_4c_OP", 5) OR VARTYPE(THIS.txt_4c_OP) != "O"
            RETURN
        ENDIF

        IF INT(NVL(THIS.txt_4c_OP.Value, 0)) <= 0
            MsgAviso("Informe o n" + CHR(250) + "mero da O.P. para buscar.", "Aviso")
            THIS.txt_4c_OP.SetFocus()
            RETURN
        ENDIF

        THIS.CarregarDivisoesOP()

        IF USED(THIS.this_cCursorDivOp) AND RECCOUNT(THIS.this_cCursorDivOp) > 0
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND VARTYPE(THIS.grd_4c_Dados) = "O"
                SELECT (THIS.this_cCursorDivOp)
                GO TOP
                THIS.grd_4c_Dados.SetFocus()
            ENDIF
        ELSE
            THIS.txt_4c_OP.SetFocus()
        ENDIF
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
    *-- Grava as alteracoes das divisoes da O.P. Alias semantico para o botao
    *-- Confirmar do CommandGroup ??? mesma logica de BtnConfirmarClick (o form
    *-- operacional SIGPRAOP usa "Confirmar" na UI, mas o pipeline de validacao
    *-- espera BtnSalvarClick por convencao dos forms CRUD).
    *---------------------------------------------------------------------------
        THIS.BtnConfirmarClick()
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
    *-- Cancela as alteracoes em andamento (descarta buffer do cursor de
    *-- trabalho e limpa os campos). Alias semantico para BtnExcluirClick,
    *-- que ja implementa o descarte com confirmacao do usuario.
    *---------------------------------------------------------------------------
        THIS.BtnExcluirClick()
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
    *-- Inicia nova alteracao de OP: limpa o cursor de trabalho, reseta os
    *-- campos O.P. e Produto, desabilita o botao Confirmar e devolve o foco
    *-- ao textbox de O.P. para que o usuario informe um novo numero. Equivale
    *-- semanticamente a "iniciar novo lote de alteracoes" no fluxo operacional.
    *---------------------------------------------------------------------------
        IF USED(THIS.this_cCursorDivOp)
            SELECT (THIS.this_cCursorDivOp)
            ZAP
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_OP", 5) AND VARTYPE(THIS.txt_4c_OP) = "O"
            THIS.txt_4c_OP.Value      = 0
            THIS.txt_4c_OP.Enabled    = .T.
            THIS.txt_4c_OP.ReadOnly   = .F.
            THIS.txt_4c_OP.BackColor  = RGB(255, 255, 255)
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_Produto", 5) AND VARTYPE(THIS.txt_4c_Produto) = "O"
            THIS.txt_4c_Produto.Value = ""
        ENDIF

        IF PEMSTATUS(THIS, "cmg_4c_BotoesConf", 5) AND VARTYPE(THIS.cmg_4c_BotoesConf) = "O"
            THIS.cmg_4c_BotoesConf.Buttons(1).Enabled = .F.
        ENDIF

        IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND VARTYPE(THIS.grd_4c_Dados) = "O"
            *-- Reabilita edicao na coluna 5 (Qtd.Atual) para novo lote
            THIS.grd_4c_Dados.Column5.ReadOnly = .F.
            THIS.grd_4c_Dados.Refresh()
        ENDIF

        IF PEMSTATUS(THIS, "edt_4c_Obss", 5) AND VARTYPE(THIS.edt_4c_Obss) = "O"
            THIS.edt_4c_Obss.Refresh()
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_OP", 5) AND VARTYPE(THIS.txt_4c_OP) = "O"
            THIS.txt_4c_OP.SetFocus()
        ENDIF
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
    *-- Carrega as divisoes da O.P. informada em modo edicao para permitir a
    *-- alteracao da coluna Qtd.Atual (QtdDivs). Delega para CarregarDivisoesOP
    *-- (mesma logica do Valid do Get_OP legado) e garante que o grid esteja
    *-- editavel. Se O.P. valida, transfere foco para o grid.
    *---------------------------------------------------------------------------
        IF !PEMSTATUS(THIS, "txt_4c_OP", 5) OR VARTYPE(THIS.txt_4c_OP) != "O"
            RETURN
        ENDIF

        IF INT(NVL(THIS.txt_4c_OP.Value, 0)) <= 0
            MsgAviso("Informe o n" + CHR(250) + "mero da O.P. antes de alterar.", ;
                     "Aviso")
            THIS.txt_4c_OP.SetFocus()
            RETURN
        ENDIF

        *-- Garante coluna Qtd.Atual editavel (modo alteracao)
        IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Column5.ReadOnly = .F.
        ENDIF

        *-- Carrega divisoes da O.P. (mesma logica do Valid do Get_OP)
        THIS.CarregarDivisoesOP()

        *-- Se carregou com sucesso (cursor com registros), foca no grid
        IF USED(THIS.this_cCursorDivOp) AND RECCOUNT(THIS.this_cCursorDivOp) > 0
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND VARTYPE(THIS.grd_4c_Dados) = "O"
                SELECT (THIS.this_cCursorDivOp)
                GO TOP
                THIS.grd_4c_Dados.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
    *-- Carrega as divisoes da O.P. em modo somente leitura (sem alteracao).
    *-- Torna a coluna Qtd.Atual read-only e desabilita o botao Confirmar
    *-- para impedir gravacao. Fluxo de consulta pura das quantidades atuais.
    *---------------------------------------------------------------------------
        IF !PEMSTATUS(THIS, "txt_4c_OP", 5) OR VARTYPE(THIS.txt_4c_OP) != "O"
            RETURN
        ENDIF

        IF INT(NVL(THIS.txt_4c_OP.Value, 0)) <= 0
            MsgAviso("Informe o n" + CHR(250) + "mero da O.P. para visualizar.", ;
                     "Aviso")
            THIS.txt_4c_OP.SetFocus()
            RETURN
        ENDIF

        *-- Carrega divisoes usando a mesma rotina do Valid do Get_OP
        THIS.CarregarDivisoesOP()

        *-- Bloqueia edicao (modo consulta)
        IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Column5.ReadOnly = .T.
            THIS.grd_4c_Dados.Refresh()
        ENDIF

        *-- Desabilita Confirmar (nao ha alteracoes a gravar em modo consulta)
        IF PEMSTATUS(THIS, "cmg_4c_BotoesConf", 5) AND VARTYPE(THIS.cmg_4c_BotoesConf) = "O"
            THIS.cmg_4c_BotoesConf.Buttons(1).Enabled = .F.
        ENDIF

        IF USED(THIS.this_cCursorDivOp) AND RECCOUNT(THIS.this_cCursorDivOp) > 0
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND VARTYPE(THIS.grd_4c_Dados) = "O"
                SELECT (THIS.this_cCursorDivOp)
                GO TOP
                THIS.grd_4c_Dados.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
    *-- Descarta as alteracoes em andamento e retorna o form ao estado inicial.
    *-- Pede confirmacao ao usuario, executa TABLEREVERT no cursor de trabalho,
    *-- zera o cursor e limpa os campos. NUNCA exclui registros da tabela
    *-- SigOpPic (a exclusao definitiva nao faz parte deste fluxo operacional).
    *---------------------------------------------------------------------------
        LOCAL loc_lTemDados
        loc_lTemDados = USED(THIS.this_cCursorDivOp) AND ;
                        RECCOUNT(THIS.this_cCursorDivOp) > 0

        IF loc_lTemDados
            IF !MsgConfirma("Descartar as altera" + CHR(231) + CHR(245) + ;
                            "es em andamento?", ;
                            "Confirma" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF

            *-- Reverte alteracoes pendentes no buffer do cursor
            SELECT (THIS.this_cCursorDivOp)
            TABLEREVERT(.T., THIS.this_cCursorDivOp)
            ZAP
        ENDIF

        *-- Reseta campos de identificacao
        IF PEMSTATUS(THIS, "txt_4c_OP", 5) AND VARTYPE(THIS.txt_4c_OP) = "O"
            THIS.txt_4c_OP.Value = 0
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_Produto", 5) AND VARTYPE(THIS.txt_4c_Produto) = "O"
            THIS.txt_4c_Produto.Value = ""
        ENDIF

        *-- Desabilita Confirmar e restaura coluna editavel
        IF PEMSTATUS(THIS, "cmg_4c_BotoesConf", 5) AND VARTYPE(THIS.cmg_4c_BotoesConf) = "O"
            THIS.cmg_4c_BotoesConf.Buttons(1).Enabled = .F.
        ENDIF
        IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Column5.ReadOnly = .F.
            THIS.grd_4c_Dados.Refresh()
        ENDIF
        IF PEMSTATUS(THIS, "edt_4c_Obss", 5) AND VARTYPE(THIS.edt_4c_Obss) = "O"
            THIS.edt_4c_Obss.Refresh()
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_OP", 5) AND VARTYPE(THIS.txt_4c_OP) = "O"
            THIS.txt_4c_OP.SetFocus()
        ENDIF
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE FormParaBO()
    *-- Sincroniza campos do form para o BO antes de gravar
    *---------------------------------------------------------------------------
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF
        THIS.this_oBusinessObject.this_nNops        = INT(NVL(THIS.txt_4c_OP.Value, 0))
        THIS.this_oBusinessObject.this_cCursorDivOp = THIS.this_cCursorDivOp
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE BOParaForm()
    *-- Sincroniza valores do BO de volta ao form apos carga de divisoes
    *---------------------------------------------------------------------------
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_Produto", 5) AND VARTYPE(THIS.txt_4c_Produto) = "O"
            THIS.txt_4c_Produto.Value = THIS.this_oBusinessObject.this_cCodPds
        ENDIF
        IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Refresh()
        ENDIF
        IF PEMSTATUS(THIS, "edt_4c_Obss", 5) AND VARTYPE(THIS.edt_4c_Obss) = "O"
            THIS.edt_4c_Obss.Refresh()
        ENDIF
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
    *-- Habilita ou desabilita controles editaveis conforme estado da operacao
    *---------------------------------------------------------------------------
        LOCAL loc_lHabilitar
        loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)

        IF PEMSTATUS(THIS, "txt_4c_OP", 5) AND VARTYPE(THIS.txt_4c_OP) = "O"
            THIS.txt_4c_OP.Enabled   = loc_lHabilitar
            THIS.txt_4c_OP.ReadOnly  = !loc_lHabilitar
            THIS.txt_4c_OP.BackColor = IIF(loc_lHabilitar, RGB(255,255,255), RGB(240,240,240))
        ENDIF

        IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Column5.ReadOnly = !loc_lHabilitar
        ENDIF
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE LimparCampos()
    *-- Limpa todos os campos do form e reseta o cursor de trabalho
    *---------------------------------------------------------------------------
        IF USED(THIS.this_cCursorDivOp)
            SELECT (THIS.this_cCursorDivOp)
            ZAP
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_OP", 5) AND VARTYPE(THIS.txt_4c_OP) = "O"
            THIS.txt_4c_OP.Value     = 0
            THIS.txt_4c_OP.Enabled   = .T.
            THIS.txt_4c_OP.ReadOnly  = .F.
            THIS.txt_4c_OP.BackColor = RGB(255, 255, 255)
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_Produto", 5) AND VARTYPE(THIS.txt_4c_Produto) = "O"
            THIS.txt_4c_Produto.Value = ""
        ENDIF

        IF PEMSTATUS(THIS, "cmg_4c_BotoesConf", 5) AND VARTYPE(THIS.cmg_4c_BotoesConf) = "O"
            THIS.cmg_4c_BotoesConf.Buttons(1).Enabled = .F.
        ENDIF

        IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Column5.ReadOnly = .F.
            THIS.grd_4c_Dados.Refresh()
        ENDIF

        IF PEMSTATUS(THIS, "edt_4c_Obss", 5) AND VARTYPE(THIS.edt_4c_Obss) = "O"
            THIS.edt_4c_Obss.Refresh()
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_nNops   = 0
            THIS.this_oBusinessObject.this_cCodPds = ""
            THIS.this_oBusinessObject.this_cEmpDNps = ""
        ENDIF
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE CarregarLista()
    *-- Carrega as divisoes da O.P. informada no campo txt_4c_OP
    *---------------------------------------------------------------------------
        LOCAL loc_nOP, loc_lSucesso
        loc_lSucesso = .F.
        loc_nOP = IIF(PEMSTATUS(THIS, "txt_4c_OP", 5) AND VARTYPE(THIS.txt_4c_OP) = "O", ;
                      INT(NVL(THIS.txt_4c_OP.Value, 0)), 0)
        IF loc_nOP <= 0
            IF USED(THIS.this_cCursorDivOp)
                SELECT (THIS.this_cCursorDivOp)
                ZAP
            ENDIF
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.Refresh()
            ENDIF
            RETURN .F.
        ENDIF
        THIS.CarregarDivisoesOP()
        loc_lSucesso = USED(THIS.this_cCursorDivOp) AND RECCOUNT(THIS.this_cCursorDivOp) > 0
        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
    *-- Ajusta estado dos botoes conforme presenca de dados no cursor de trabalho
    *---------------------------------------------------------------------------
        LOCAL loc_lTemDados
        loc_lTemDados = USED(THIS.this_cCursorDivOp) AND ;
                        RECCOUNT(THIS.this_cCursorDivOp) > 0

        IF PEMSTATUS(THIS, "cmg_4c_BotoesConf", 5) AND VARTYPE(THIS.cmg_4c_BotoesConf) = "O"
            THIS.cmg_4c_BotoesConf.Buttons(1).Enabled = loc_lTemDados
        ENDIF

        IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Column5.ReadOnly = !loc_lTemDados
        ENDIF
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE TornarControlesVisiveis(par_oContainer)
    *-- Torna Visible=.T. recursivamente (AddObject cria controles ocultos)
    *---------------------------------------------------------------------------
        LOCAL loc_i, loc_oControl
        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
                   loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE Destroy()
    *---------------------------------------------------------------------------
        IF USED(THIS.this_cCursorDivOp)
            USE IN (THIS.this_cCursorDivOp)
        ENDIF
        THIS.this_oBusinessObject = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrAopBO.prg):
*******************************************************************************
* SigPrAopBO.prg - Business Object: Alteracao de Quantidade da O.P.
* Herda de BusinessBase
* Tabela principal: SigOpPic
*******************************************************************************

DEFINE CLASS SigPrAopBO AS BusinessBase

    *-- Identificacao da entidade
    this_cTabela     = "SigOpPic"
    this_cCampoChave = "Nops"

    *-- Numero da Ordem de Producao atual
    this_nNops     = 0

    *-- Codigo do produto da OP
    this_cCodPds   = ""

    *-- Chave composta: cCodEmpresa + DoppPads + Str(Nops,10)
    this_cEmpDNps  = ""

    *-- Parametros carregados de SigCdPam
    this_cDoppPads = ""
    this_cMascNums = ""

    *-- Nome do cursor de trabalho da divisao de OP (equivalente a Temp_DivOp)
    this_cCursorDivOp = "cursor_4c_DivOp"

    *---------------------------------------------------------------------------
    PROCEDURE Init()
    *---------------------------------------------------------------------------
        THIS.this_cTabela     = "SigOpPic"
        THIS.this_cCampoChave = "Nops"
        DODEFAULT()
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE CarregarParametros()
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro, loc_cSql
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_SigCdPam")
                USE IN cursor_4c_SigCdPam
            ENDIF
            loc_cSql = "SELECT TOP 1 DoppPads, MascNums FROM SigCdPam"
            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_SigCdPam") > 0
                IF !EOF("cursor_4c_SigCdPam")
                    SELECT cursor_4c_SigCdPam
                    THIS.this_cDoppPads = NVL(ALLTRIM(DoppPads), "")
                    THIS.this_cMascNums = NVL(ALLTRIM(MascNums), "")
                    loc_lSucesso = .T.
                ENDIF
                USE IN cursor_4c_SigCdPam
            ELSE
                MsgErro("Erro ao carregar par" + CHR(226) + "metros do sistema.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_SigCdPam")
                USE IN cursor_4c_SigCdPam
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE CarregarDivOp(par_nNops, par_cCursorDestino)
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro, loc_cSql, loc_cEmpDNps
        LOCAL loc_nItem, loc_cCodPds, loc_lChkSubn, loc_lOPValida
        LOCAL loc_cDopes, loc_nNumes, loc_nQtds, loc_dDataes
        LOCAL loc_mObss, loc_cCpros, loc_cCodCors, loc_cCodTams
        LOCAL loc_nCitens, loc_cIdChaves

        loc_lSucesso  = .F.
        loc_lOPValida = .F.
        loc_nItem     = 0
        loc_cCodPds   = ""
        loc_lChkSubn  = .F.

        IF par_nNops = 0
            RETURN .F.
        ENDIF

        TRY
            *-- Monta chave EmpDNps: cCodEmpresa + DoppPads + Str(Nops,10)
            loc_cEmpDNps = go_4c_Sistema.cCodEmpresa + THIS.this_cDoppPads + STR(par_nNops, 10)
            THIS.this_cEmpDNps = loc_cEmpDNps
            THIS.this_nNops    = par_nNops

            *-- Valida OP em SigCdNec (verifica existencia e se nao foi encerrada)
            IF USED("cursor_4c_SigCdNec")
                USE IN cursor_4c_SigCdNec
            ENDIF
            loc_cSql = "SELECT TOP 1 EmpDNps, ChkSubn FROM SigCdNec " + ;
                       "WHERE EmpDNps = " + EscaparSQL(loc_cEmpDNps)
            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_SigCdNec") > 0
                IF !EOF("cursor_4c_SigCdNec")
                    SELECT cursor_4c_SigCdNec
                    loc_lChkSubn  = NVL(cursor_4c_SigCdNec.ChkSubn, .F.)
                    loc_lOPValida = .T.
                ENDIF
                USE IN cursor_4c_SigCdNec

                IF loc_lOPValida AND loc_lChkSubn
                    MsgAviso("O.P. J" + CHR(225) + " Foi Encerrada!!!", "Aviso")
                    loc_lOPValida = .F.
                ENDIF

                IF !loc_lOPValida AND !loc_lChkSubn AND par_nNops > 0
                    MsgAviso("O.P. N" + CHR(227) + "o Localizada!!!", "Aviso")
                ENDIF
            ELSE
                MsgErro("Erro ao validar O.P.", "Erro")
            ENDIF

            IF loc_lOPValida
                *-- Obtem codigo do produto via SigPdMvf
                IF USED("cursor_4c_SigPdMvfLoad")
                    USE IN cursor_4c_SigPdMvfLoad
                ENDIF
                loc_cSql = "SELECT TOP 1 CodPds FROM SigPdMvf " + ;
                           "WHERE EmpDNps = " + EscaparSQL(loc_cEmpDNps)
                IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_SigPdMvfLoad") > 0
                    IF !EOF("cursor_4c_SigPdMvfLoad")
                        SELECT cursor_4c_SigPdMvfLoad
                        loc_cCodPds = NVL(ALLTRIM(cursor_4c_SigPdMvfLoad.CodPds), "")
                    ENDIF
                    USE IN cursor_4c_SigPdMvfLoad
                ENDIF
                THIS.this_cCodPds = loc_cCodPds

                *-- Carrega itens de SigOpPic para o cursor de trabalho
                IF USED("cursor_4c_SigOpPicLoad")
                    USE IN cursor_4c_SigOpPicLoad
                ENDIF
                loc_cSql = "SELECT Nops, cIdChaves, Dopes, Numes, Qtds, DataEs, Obss, " + ;
                           "Cpros, CodCors, CodTams, Citens " + ;
                           "FROM SigOpPic " + ;
                           "WHERE Nops = " + FormatarNumeroSQL(par_nNops, 0)
                IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_SigOpPicLoad") > 0
                    SELECT (par_cCursorDestino)
                    ZAP

                    SELECT cursor_4c_SigOpPicLoad
                    GO TOP
                    loc_nItem = 0
                    SCAN
                        loc_nItem     = loc_nItem + 1
                        loc_cDopes    = NVL(cursor_4c_SigOpPicLoad.Dopes, "")
                        loc_nNumes    = NVL(cursor_4c_SigOpPicLoad.Numes, 0)
                        loc_nQtds     = NVL(cursor_4c_SigOpPicLoad.Qtds, 0)
                        loc_dDataes   = cursor_4c_SigOpPicLoad.DataEs
                        loc_mObss     = NVL(cursor_4c_SigOpPicLoad.Obss, "")
                        loc_cCpros    = NVL(cursor_4c_SigOpPicLoad.Cpros, "")
                        loc_cCodCors  = NVL(cursor_4c_SigOpPicLoad.CodCors, "")
                        loc_cCodTams  = NVL(cursor_4c_SigOpPicLoad.CodTams, "")
                        loc_nCitens   = NVL(cursor_4c_SigOpPicLoad.Citens, 0)
                        loc_cIdChaves = NVL(ALLTRIM(cursor_4c_SigOpPicLoad.cIdChaves), "")

                        INSERT INTO (par_cCursorDestino) ;
                            (Dopes, Numes, Qtds, QtdDivs, Dataes, Obss, SeqDivs, ;
                             Cpros, CodCors, CodTams, Citens, cIdChaves, Nops) ;
                            VALUES (loc_cDopes, loc_nNumes, loc_nQtds, loc_nQtds, ;
                                    loc_dDataes, loc_mObss, loc_nItem, ;
                                    loc_cCpros, loc_cCodCors, loc_cCodTams, ;
                                    loc_nCitens, loc_cIdChaves, par_nNops)
                    ENDSCAN

                    USE IN cursor_4c_SigOpPicLoad

                    SELECT (par_cCursorDestino)
                    IF RECCOUNT() > 0
                        GO TOP
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao carregar itens de SigOpPic.", "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_SigCdNec")
                USE IN cursor_4c_SigCdNec
            ENDIF
            IF USED("cursor_4c_SigPdMvfLoad")
                USE IN cursor_4c_SigPdMvfLoad
            ENDIF
            IF USED("cursor_4c_SigOpPicLoad")
                USE IN cursor_4c_SigOpPicLoad
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
    *---------------------------------------------------------------------------
        IF THIS.this_nNops = 0
            RETURN .F.
        ENDIF
        IF !USED(THIS.this_cCursorDivOp) OR RECCOUNT(THIS.this_cCursorDivOp) = 0
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE Inserir()
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro, loc_cSql, loc_lErroInLoop
        LOCAL loc_nTotalQtds, loc_cCursorDiv, loc_nNops, loc_cChave
        LOCAL loc_nCitens, loc_cDopes, loc_nNumes, loc_nQtdDivs, loc_nSeqDivs

        loc_lSucesso    = .F.
        loc_lErroInLoop = .F.
        loc_nTotalQtds  = 0
        loc_cCursorDiv  = THIS.this_cCursorDivOp
        loc_nNops       = THIS.this_nNops

        TRY
            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

            *-- Carrega SigOpPic fresco para esta OP (sera o espelho local das operacoes)
            IF USED("cursor_4c_SigOpPicSave")
                USE IN cursor_4c_SigOpPicSave
            ENDIF
            loc_cSql = "SELECT Nops, cIdChaves, Dopes, Numes, SeqDivs, Qtds, Citens " + ;
                       "FROM SigOpPic " + ;
                       "WHERE Nops = " + FormatarNumeroSQL(loc_nNops, 0)
            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_SigOpPicSave") <= 0
                MsgErro("Falha ao carregar SigOpPic para gravacao.", "Erro")
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
            ELSE
                *-- Passo 1: Zera SeqDivs de todos os itens da OP
                SELECT cursor_4c_SigOpPicSave
                GO TOP
                SCAN WHILE !loc_lErroInLoop
                    loc_cChave = NVL(ALLTRIM(cIdChaves), "")
                    loc_cSql   = "UPDATE SigOpPic SET SeqDivs = 0 " + ;
                                 "WHERE cIdChaves = " + EscaparSQL(loc_cChave)
                    IF SQLEXEC(gnConnHandle, loc_cSql) <= 0
                        MsgErro("Falha ao reinicializar O.P. Favor tentar novamente.", "Erro")
                        loc_lErroInLoop = .T.
                    ELSE
                        REPLACE SeqDivs WITH 0 IN cursor_4c_SigOpPicSave
                    ENDIF
                ENDSCAN

                *-- Passo 2: Atualiza Qtds/SeqDivs conforme cursor de trabalho
                IF !loc_lErroInLoop AND USED(loc_cCursorDiv) AND RECCOUNT(loc_cCursorDiv) > 0
                    SELECT (loc_cCursorDiv)
                    GO TOP
                    SCAN WHILE !loc_lErroInLoop
                        loc_nCitens  = NVL(EVALUATE(loc_cCursorDiv + ".Citens"), 0)
                        loc_cDopes   = NVL(ALLTRIM(EVALUATE(loc_cCursorDiv + ".Dopes")), "")
                        loc_nNumes   = NVL(EVALUATE(loc_cCursorDiv + ".Numes"), 0)
                        loc_nQtdDivs = NVL(EVALUATE(loc_cCursorDiv + ".QtdDivs"), 0)
                        loc_nSeqDivs = NVL(EVALUATE(loc_cCursorDiv + ".SeqDivs"), 0)

                        *-- Localiza linha correspondente em SigOpPicSave por Citens+Dopes+Numes
                        SELECT cursor_4c_SigOpPicSave
                        GO TOP
                        SCAN FOR Nops = loc_nNops AND Citens = loc_nCitens AND SeqDivs = 0
                            IF NVL(ALLTRIM(Dopes), "") + STR(NVL(Numes, 0), 6) = ;
                               loc_cDopes + STR(loc_nNumes, 6)
                                loc_cChave = NVL(ALLTRIM(cIdChaves), "")
                                loc_cSql   = "UPDATE SigOpPic SET " + ;
                                             "Qtds = " + FormatarNumeroSQL(loc_nQtdDivs, 3) + ;
                                             ", SeqDivs = " + FormatarNumeroSQL(loc_nSeqDivs, 0) + ;
                                             " WHERE cIdChaves = " + EscaparSQL(loc_cChave)
                                IF SQLEXEC(gnConnHandle, loc_cSql) <= 0
                                    MsgErro("Falha ao atualizar SigOpPic. Favor reinicializar.", "Erro")
                                    loc_lErroInLoop = .T.
                                ELSE
                                    REPLACE Qtds    WITH loc_nQtdDivs, ;
                                            SeqDivs WITH loc_nSeqDivs ;
                                            IN cursor_4c_SigOpPicSave
                                ENDIF
                                EXIT
                            ENDIF
                        ENDSCAN
                        SELECT (loc_cCursorDiv)
                    ENDSCAN
                ENDIF

                *-- Passo 3: Soma Qtds atualizadas e grava total em SigPdMvf
                IF !loc_lErroInLoop
                    SELECT cursor_4c_SigOpPicSave
                    loc_nTotalQtds = 0
                    SUM Qtds TO loc_nTotalQtds

                    IF USED("cursor_4c_SigPdMvfSave")
                        USE IN cursor_4c_SigPdMvfSave
                    ENDIF
                    loc_cSql = "SELECT TOP 1 cIdChaves FROM SigPdMvf " + ;
                               "WHERE EmpDNps = " + EscaparSQL(THIS.this_cEmpDNps)
                    IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_SigPdMvfSave") > 0
                        SELECT cursor_4c_SigPdMvfSave
                        IF !EOF("cursor_4c_SigPdMvfSave")
                            loc_cChave = NVL(ALLTRIM(cursor_4c_SigPdMvfSave.cIdChaves), "")
                            loc_cSql   = "UPDATE SigPdMvf SET " + ;
                                         "Qtds = " + FormatarNumeroSQL(loc_nTotalQtds, 3) + ;
                                         " WHERE cIdChaves = " + EscaparSQL(loc_cChave)
                            IF SQLEXEC(gnConnHandle, loc_cSql) <= 0
                                MsgErro("Falha ao atualizar total em SigPdMvf.", "Erro")
                                loc_lErroInLoop = .T.
                            ENDIF
                        ENDIF
                        USE IN cursor_4c_SigPdMvfSave
                    ENDIF
                ENDIF

                IF loc_lErroInLoop
                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                ELSE
                    SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                    THIS.RegistrarAuditoria("U")
                    loc_lSucesso = .T.
                ENDIF

                IF USED("cursor_4c_SigOpPicSave")
                    USE IN cursor_4c_SigOpPicSave
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
            IF USED("cursor_4c_SigOpPicSave")
                USE IN cursor_4c_SigOpPicSave
            ENDIF
            IF USED("cursor_4c_SigPdMvfSave")
                USE IN cursor_4c_SigPdMvfSave
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE Atualizar()
    *---------------------------------------------------------------------------
        RETURN THIS.Inserir()
    ENDPROC

    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nNops = NVL(Nops, 0)
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
    *---------------------------------------------------------------------------
        RETURN TRANSFORM(THIS.this_nNops)
    ENDPROC

    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
    *---------------------------------------------------------------------------
        LOCAL loc_cSql, loc_oErro
        TRY
            loc_cSql = "INSERT INTO LogAuditoria (Tabela, Chave, Operacao, Usuario, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL("SigOpPic") + ", " + ;
                       EscaparSQL(THIS.ObterChavePrimaria()) + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       "GETDATE())"
            SQLEXEC(gnConnHandle, loc_cSql)
        CATCH TO loc_oErro
            MsgErro("Erro ao registrar auditoria: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE

