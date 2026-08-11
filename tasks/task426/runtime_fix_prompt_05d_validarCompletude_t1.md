# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[FormFpm.prg] Indicador de pendencia: * que qualquer edicao pendente
[FormFpm.prg] Indicador de pendencia: *-- Commit da linha corrente (usuario pode estar com edicao pendente

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormFpm.prg):
*==============================================================================
* FormFpm.prg - Valores Minimo/Maximo de Condicao de Pagamento (sub-form modal)
* Form OPERACIONAL - abre sobre o form pai (SigCdFpm / FormFpp)
* Chamada: CREATEOBJECT("FormFpm", oParentForm, cFpags)
* Herda de: FormBase
*
* Form OPERACIONAL (sub-form modal de edicao de grid inline). Botoes do SCX
* original: Inserir, Excluir, Encerrar. Edicao de parcelas (nparcs/valmins/
* valmaxs/emps) diretamente no grid. Salva no Encerrar via FpmBO.SalvarAlteracoes.
*
* Historico de fases:
*   Fase 1/2: FpmBO.prg (propriedades + CRUD + BuscarPorCondicao + SalvarAlteracoes)
*   Fase 3:   FormFpm.prg - estrutura base (heranca, Init, InicializarForm,
*             PageFrame, containers vazios, labels cabecalho, TornarControlesVisiveis,
*             CarregarDados stub, Destroy)
*   Fase 4:   FormFpm.prg - grid grd_4c_Dados (4 colunas) + botoes Inserir/Excluir/Encerrar
*             + BINDEVENTs + VincularGrid
*   Fase 5:   FormFpm.prg - BtnInserirClick, BtnExcluirClick, BtnEncerrarClick,
*             ValidarParcelas, GrdDadosAfterRowColChange, ValidarEmps, AlternarPagina
*   Fase 6:   FormFpm.prg - Botoes Confirmar/Cancelar em cnt_4c_BotoesAcao (Page2)
*             + BtnConfirmarClick + BtnCancelarClick
*   Fase 7:   FormFpm.prg - BtnAlterarClick, BtnVisualizarClick, BtnIncluirClick
*             (aliases CRUD + refresh/lock inline)
*   Fase 8:   FormFpm.prg - eventos auxiliares e consolidacao:
*             CarregarLista, FormParaBO, BOParaForm, HabilitarCampos,
*             LimparCampos, AjustarBotoesPorModo, BtnBuscarClick, BtnSalvarClick
*==============================================================================
DEFINE CLASS FormFpm AS FormBase

    *-- Propriedades do SCX original (RESERVED3: gravadados / parentform / peantvalue)
    GravaDados       = .F.      && .T. quando usuario alterou dados no grid
    peantvalue       = 0        && valor anterior capturado em Column.When
    this_oParentForm = .NULL.   && referencia ao form pai para reabilitar no Destroy
    this_cFpags      = ""       && codigo da condicao de pagamento (fpags char 12)

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Controle de modo
    this_cModoAtual = "LISTA"

    *-- Guard anti-recursao no AfterRowColChange / When-Valid inline
    this_lRedirigindo = .F.

    *-- Propriedades visuais (PILAR 1 - valores exatos do SCX original SIGCDFPM)
    Width        = 683
    Height       = 363
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    MaxButton    = .F.
    Movable      = .F.
    BorderStyle  = 2
    ClipControls = .F.
    DataSession  = 2
    Caption      = "Valor Minimo/Maximo Cond.Pagto"
    FontName     = "Tahoma"
    FontSize     = 8

    *--------------------------------------------------------------------------
    * Init - Recebe ref ao pai e codigo da condicao de pagamento
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oParentForm, par_cFpags)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            THIS.this_oParentForm = par_oParentForm
            THIS.this_cFpags      = IIF(VARTYPE(par_cFpags) = "C", ALLTRIM(par_cFpags), "")

            THIS.Caption = "Valor M" + CHR(237) + "nimo/M" + CHR(225) + "ximo Cond.Pagto " + ;
                           ALLTRIM(THIS.this_cFpags)

            THIS.this_oBusinessObject = CREATEOBJECT("FpmBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar FpmBO." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormFpm.Init")
            ELSE
                IF VARTYPE(THIS.this_oParentForm) = "O"
                    THIS.this_oParentForm.Enabled = .F.
                ENDIF
                *-- DODEFAULT() dispara FormBase.Init() -> THIS.InicializarForm()
                *-- Tambem aciona SET DATE TO BRITISH + SET CENTURY ON (DataSession=2)
                loc_lSucesso = DODEFAULT()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Monta estrutura visual base do form
    * (chamado por FormBase.Init via DODEFAULT)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            *-- 1. Fundo do form (SCX original: new_background.jpg)
            IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            ENDIF

            *-- 2. PageFrame com Page1 (Lista) e Page2 (Dados)
            THIS.ConfigurarPageFrame()

            *-- 3. Containers vazios em cada Page
            THIS.ConfigurarContainersBase()

            *-- 4. Popula Page1: labels cabecalho (Fase 3) + grid+botoes (Fase 4)
            THIS.ConfigurarPaginaLista()

            *-- 5. Popula Page2: cabecalho espelhado (Fase 3) + botoes acao (Fase 4)
            THIS.ConfigurarPaginaDados()

            *-- 6. Propaga Caption para cabecalhos de ambas as paginas
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
            THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

            *-- 7. Carrega dados via BO e vincula grid ao cursor
            THIS.CarregarDados()

            *-- 8. Ativa Page1 (Lista) como padrao
            THIS.pgf_4c_Paginas.Visible    = .T.
            THIS.pgf_4c_Paginas.ActivePage = 1
            THIS.this_cModoAtual           = "LISTA"

            *-- 9. Torna toda a arvore visivel
            THIS.TornarControlesVisiveis(THIS)

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.InicializarForm")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * Tabs ocultas (Top=-29, Tabs=.F.)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("pgf_4c_Paginas", "PageFrame")
            WITH THIS.pgf_4c_Paginas
                .Top         = -29
                .Left        = 0
                .Width       = THIS.Width
                .Height      = THIS.Height + 29
                .PageCount   = 2
                .Tabs        = .F.
                .BorderWidth = 0

                .Page1.Caption = "Lista"
                .Page2.Caption = "Dados"
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.ConfigurarPageFrame")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainersBase - Cria containers vazios em cada Page
    * cnt_4c_Cabecalho + cnt_4c_Botoes em Page1
    * cnt_4c_Cabecalho + cnt_4c_BotoesAcao em Page2
    * Controles internos sao adicionados em ConfigurarPaginaLista/Dados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainersBase()
        LOCAL loc_oPag1, loc_oPag2, loc_oErro
        TRY
            loc_oPag1 = THIS.pgf_4c_Paginas.Page1
            loc_oPag2 = THIS.pgf_4c_Paginas.Page2

            *-- Page1: cabecalho escuro (topo) - compensacao PageFrame.Top=-29
            loc_oPag1.AddObject("cnt_4c_Cabecalho", "Container")
            WITH loc_oPag1.cnt_4c_Cabecalho
                .Top         = 0 + 29
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BorderWidth = 0
                .BackStyle   = 1
                .BackColor   = RGB(100, 100, 100)
                .Visible     = .T.
            ENDWITH

            *-- Page1: container de botoes
            *-- Alinhado com botoes originais: cmdInserir.Left=457, cmdSair.Right=682
            loc_oPag1.AddObject("cnt_4c_Botoes", "Container")
            WITH loc_oPag1.cnt_4c_Botoes
                .Top         = 0 + 29
                .Left        =  542
                .Width       = 226
                .Height      = 85
                .BorderWidth = 0
                .BackStyle   = 0
                .Visible     = .T.
            ENDWITH

            *-- Page2: cabecalho espelhado
            loc_oPag2.AddObject("cnt_4c_Cabecalho", "Container")
            WITH loc_oPag2.cnt_4c_Cabecalho
                .Top         = 0 + 29
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BorderWidth = 0
                .BackStyle   = 1
                .BackColor   = RGB(100, 100, 100)
                .Visible     = .T.
            ENDWITH

            *-- Page2: container de acoes (Fase 4 populara com Confirmar/Cancelar)
            loc_oPag2.AddObject("cnt_4c_BotoesAcao", "Container")
            WITH loc_oPag2.cnt_4c_BotoesAcao
                .Top         = 4 + 29
                .Left        = 457
                .Width       = 226
                .Height      = 85
                .BorderWidth = 0
                .BackStyle   = 0
                .Visible     = .T.
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.ConfigurarContainersBase")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Popula Page1 com cabecalho, grid e botoes
    * Grid: grd_4c_Dados (GradeFPagto do original), 4 colunas inline
    * Botoes: Inserir, Excluir, Encerrar em cnt_4c_Botoes
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oCab, loc_oPag, loc_oCnt, loc_oErro
        TRY
            loc_oPag = THIS.pgf_4c_Paginas.Page1
            loc_oCab = loc_oPag.cnt_4c_Cabecalho

            *-- Label sombra (preto sobre cinza escuro = efeito de sombra)
            loc_oCab.AddObject("lbl_4c_Sombra", "Label")
            WITH loc_oCab.lbl_4c_Sombra
                .AutoSize   = .F.
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 18
                .BackStyle  = 0
                .Caption    = THIS.Caption
                .Height     = 40
                .Left       = 10
                .Top        = 18
                .Width      = THIS.Width - 20
                .ForeColor  = RGB(0, 0, 0)
            ENDWITH

            *-- Label titulo (branco sobre cinza = visivel)
            loc_oCab.AddObject("lbl_4c_Titulo", "Label")
            WITH loc_oCab.lbl_4c_Titulo
                .AutoSize   = .F.
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 18
                .BackStyle  = 0
                .Caption    = THIS.Caption
                .Height     = 46
                .Left       = 10
                .Top        = 17
                .Width      = THIS.Width - 20
                .ForeColor  = RGB(255, 255, 255)
            ENDWITH

            *-- Grid grd_4c_Dados (GradeFPagto do original)
            *-- Original: Top=92, Left=114, Width=334, Height=260
            *-- Com compensacao PageFrame.Top=-29: Top = 92+29 = 121
            loc_oPag.AddObject("grd_4c_Dados", "Grid")
            WITH loc_oPag.grd_4c_Dados
                .Top           = 92 + 29
                .Left          = 114
                .Width         = 334
                .Height        = 260
                .ColumnCount   = 4
                .FontName      = "Tahoma"
                .FontSize      = 8
                .DeleteMark    = .F.
                .RecordMark    = .F.
                .RowHeight     = 16
                .ScrollBars    = 2
                .GridLineColor = RGB(238, 238, 238)

                *-- Column1: Parcelas (nParcs), Width=60
                WITH .Column1
                    .Width     = 60
                    .Movable   = .F.
                    .Resizable = .F.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    WITH .Header1
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .Caption   = "Parcelas"
                    ENDWITH
                    WITH .Text1
                        .BorderStyle = 0
                        .Margin      = 0
                        .ForeColor   = RGB(0, 0, 0)
                        .BackColor   = RGB(255, 255, 255)
                    ENDWITH
                ENDWITH

                *-- Column2: Valor Minimo (ValMins), Width=100
                WITH .Column2
                    .Width     = 100
                    .Movable   = .F.
                    .Resizable = .F.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .InputMask = "999,999,999.99"
                    WITH .Header1
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .Caption   = "Valor M" + CHR(237) + "nimo"
                    ENDWITH
                    WITH .Text1
                        .BorderStyle = 0
                        .InputMask   = "999,999,999.99"
                        .Margin      = 0
                        .ForeColor   = RGB(0, 0, 0)
                        .BackColor   = RGB(255, 255, 255)
                    ENDWITH
                ENDWITH

                *-- Column3: Valor Maximo (ValMaxs), Width=100
                WITH .Column3
                    .Width     = 100
                    .Movable   = .F.
                    .Resizable = .F.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .InputMask = "999,999,999.99"
                    WITH .Header1
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .Caption   = "Valor M" + CHR(225) + "ximo"
                    ENDWITH
                    WITH .Text1
                        .BorderStyle = 0
                        .InputMask   = "999,999,999.99"
                        .Margin      = 0
                        .ForeColor   = RGB(0, 0, 0)
                        .BackColor   = RGB(255, 255, 255)
                    ENDWITH
                ENDWITH

                *-- Column4: Empresa (Emps), Width=40
                WITH .Column4
                    .Width     = 40
                    .Movable   = .F.
                    .Resizable = .F.
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    WITH .Header1
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .Caption   = "Emp"
                    ENDWITH
                    WITH .Text1
                        .BorderStyle = 0
                        .MaxLength   = 3
                        .Margin      = 0
                        .ForeColor   = RGB(0, 0, 0)
                        .BackColor   = RGB(255, 255, 255)
                    ENDWITH
                ENDWITH
            ENDWITH

            *-- Botoes no cnt_4c_Botoes
            *-- Original: Inserir(Left=457), Excluir(Left=532), Sair(Left=607)
            *-- cnt_4c_Botoes.Left=457 => posicoes relativas: 0, 75, 150
            loc_oCnt = loc_oPag.cnt_4c_Botoes

            loc_oCnt.AddObject("cmd_4c_Inserir", "CommandButton")
            WITH loc_oCnt.cmd_4c_Inserir
                .Left            = 0
                .Top             = 3
                .Width           = 75
                .Height          = 75
                .Caption         = "Inserir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
            ENDWITH

            loc_oCnt.AddObject("cmd_4c_Excluir", "CommandButton")
            WITH loc_oCnt.cmd_4c_Excluir
                .Left            = 75
                .Top             = 3
                .Width           = 75
                .Height          = 75
                .Caption         = "Excluir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
            ENDWITH

            loc_oCnt.AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH loc_oCnt.cmd_4c_Encerrar
                .Left            = 150
                .Top             = 3
                .Width           = 75
                .Height          = 75
                .Caption         = "Encerrar"
                .Cancel          = .T.
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
            ENDWITH

            *-- BINDEVENTs para botoes
            BINDEVENT(loc_oCnt.cmd_4c_Inserir,  "Click", THIS, "BtnInserirClick")
            BINDEVENT(loc_oCnt.cmd_4c_Excluir,  "Click", THIS, "BtnExcluirClick")
            BINDEVENT(loc_oCnt.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

            *-- BINDEVENT para grid: When/Valid via AfterRowColChange
            BINDEVENT(loc_oPag.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Popula Page2 com cabecalho espelhado e
    * botoes Confirmar/Cancelar em cnt_4c_BotoesAcao
    * (Fase 3: labels cabecalho; Fase 6: botoes de acao)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oCab, loc_oCnt, loc_oPag2, loc_oErro
        TRY
            loc_oPag2 = THIS.pgf_4c_Paginas.Page2
            loc_oCab  = loc_oPag2.cnt_4c_Cabecalho

            *-- Label sombra
            loc_oCab.AddObject("lbl_4c_Sombra", "Label")
            WITH loc_oCab.lbl_4c_Sombra
                .AutoSize   = .F.
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 18
                .BackStyle  = 0
                .Caption    = THIS.Caption
                .Height     = 40
                .Left       = 10
                .Top        = 18
                .Width      = THIS.Width - 20
                .ForeColor  = RGB(0, 0, 0)
            ENDWITH

            *-- Label titulo
            loc_oCab.AddObject("lbl_4c_Titulo", "Label")
            WITH loc_oCab.lbl_4c_Titulo
                .AutoSize   = .F.
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 18
                .BackStyle  = 0
                .Caption    = THIS.Caption
                .Height     = 46
                .Left       = 10
                .Top        = 17
                .Width      = THIS.Width - 20
                .ForeColor  = RGB(255, 255, 255)
            ENDWITH

            *-- Botoes Confirmar / Cancelar em cnt_4c_BotoesAcao
            *-- Mesmo padrao visual dos botoes de Page1
            loc_oCnt = loc_oPag2.cnt_4c_BotoesAcao

            loc_oCnt.AddObject("cmd_4c_Confirmar", "CommandButton")
            WITH loc_oCnt.cmd_4c_Confirmar
                .Left            = 0
                .Top             = 3
                .Width           = 75
                .Height          = 75
                .Caption         = "Confirmar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
            ENDWITH

            loc_oCnt.AddObject("cmd_4c_Cancelar", "CommandButton")
            WITH loc_oCnt.cmd_4c_Cancelar
                .Left            = 75
                .Top             = 3
                .Width           = 75
                .Height          = 75
                .Caption         = "Encerrar"
                .Cancel          = .T.
                .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
            ENDWITH

            *-- BINDEVENTs para botoes de Page2
            BINDEVENT(loc_oCnt.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
            BINDEVENT(loc_oCnt.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - Carrega parcelas via BO e vincula grid ao cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDados()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !EMPTY(THIS.this_cFpags)
                loc_lSucesso = THIS.this_oBusinessObject.BuscarPorCondicao(THIS.this_cFpags)
            ENDIF
            IF loc_lSucesso
                THIS.VincularGrid()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.CarregarDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * (percorre Pages de PageFrames alem de Controls de Containers)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_nP, loc_oControl, loc_oErro
        TRY
            FOR loc_i = 1 TO par_oContainer.ControlCount
                loc_oControl = par_oContainer.Controls(loc_i)
                IF VARTYPE(loc_oControl) = "O"
                    IF PEMSTATUS(loc_oControl, "Visible", 5)
                        loc_oControl.Visible = .T.
                    ENDIF
                    IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                        FOR loc_nP = 1 TO loc_oControl.PageCount
                            THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
                        ENDFOR
                    ENDIF
                    IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
                       loc_oControl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControl)
                    ENDIF
                ENDIF
            ENDFOR
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.TornarControlesVisiveis")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * VincularGrid - Vincula grd_4c_Dados ao cursor_4c_FpagI
    * Define ControlSource de cada coluna apos CarregarDados
    *--------------------------------------------------------------------------
    PROCEDURE VincularGrid()
        LOCAL loc_oGrid, loc_oErro
        TRY
            IF !USED("cursor_4c_FpagI")
                RETURN
            ENDIF
            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
            WITH loc_oGrid
                .ColumnCount           = 4
                .RecordSource          = "cursor_4c_FpagI"
                .Column1.ControlSource = "cursor_4c_FpagI.nParcs"
                .Column2.ControlSource = "cursor_4c_FpagI.ValMins"
                .Column3.ControlSource = "cursor_4c_FpagI.ValMaxs"
                .Column4.ControlSource = "cursor_4c_FpagI.Emps"
            ENDWITH
            loc_oGrid.Column1.Header1.Caption = "Parcelas"
            loc_oGrid.Column2.Header1.Caption = "Valor M" + CHR(237) + "nimo"
            loc_oGrid.Column3.Header1.Caption = "Valor M" + CHR(225) + "ximo"
            loc_oGrid.Column4.Header1.Caption = "Emp"
            loc_oGrid.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.VincularGrid")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_oErro
        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
            DO CASE
                CASE par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                CASE par_nPagina = 2
                    THIS.this_cModoAtual = "DADOS"
            ENDCASE
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.AlternarPagina")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnInserirClick - Insere nova linha em branco com o fpags corrente
    * Original: Insert Into xFPagI (fPags) Values (crTSigfPag.fpags)
    *--------------------------------------------------------------------------
    PROCEDURE BtnInserirClick()
        LOCAL loc_oErro
        TRY
            IF !USED("cursor_4c_FpagI")
                RETURN
            ENDIF
            SELECT cursor_4c_FpagI
            INSERT INTO cursor_4c_FpagI (Fpags) VALUES (THIS.this_cFpags)
            THIS.GravaDados = .T.
            THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Column1.SetFocus
            THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.BtnInserirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Marca linha corrente como excluida
    * Original: Delete (marca exclusao no cursor local)
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oErro
        TRY
            IF !USED("cursor_4c_FpagI") OR EOF("cursor_4c_FpagI")
                RETURN
            ENDIF
            SELECT cursor_4c_FpagI
            IF !EOF()
                DELETE
            ENDIF
            THIS.GravaDados = .T.
            THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.BtnExcluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Valida, salva alteracoes e fecha o form
    * Original: Valida duplicatas, atualiza crSigOpFpi, commit, Release
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        LOCAL loc_lPodeFechar, loc_lSucesso, loc_oErro
        loc_lPodeFechar = .T.
        TRY
            IF THIS.GravaDados
                loc_lPodeFechar = THIS.ValidarParcelas()
                IF loc_lPodeFechar
                    loc_lSucesso = THIS.this_oBusinessObject.SalvarAlteracoes(THIS.this_cFpags)
                    IF !loc_lSucesso
                        MsgAviso("Falha ao salvar as altera" + CHR(231) + CHR(245) + "es.", ;
                            "Encerrar")
                        loc_lPodeFechar = .F.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.BtnEncerrarClick")
            loc_lPodeFechar = .F.
        ENDTRY
        IF loc_lPodeFechar
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarParcelas - Verifica se ha nParcs duplicados no cursor
    * Original: SELECT nParcs, sum(1) FROM xFPagi GROUP BY nparcs HAVING sum(1)>1
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarParcelas()
        LOCAL loc_lValido, loc_oErro
        loc_lValido = .T.
        TRY
            IF USED("cursor_4c_ValidTT")
                USE IN cursor_4c_ValidTT
            ENDIF
            IF USED("cursor_4c_FpagI")
                SELECT nParcs, COUNT(*) AS nQtd ;
                    FROM cursor_4c_FpagI ;
                    WHERE !DELETED() AND (nParcs > 0 OR ValMaxs > 0) ;
                    GROUP BY nParcs ;
                    HAVING COUNT(*) > 1 ;
                    INTO CURSOR cursor_4c_ValidTT READWRITE
                SELECT cursor_4c_ValidTT
                IF RECCOUNT("cursor_4c_ValidTT") > 0
                    MsgAviso("Dados Inconsistentes!!!", "Validar")
                    loc_lValido = .F.
                ENDIF
                IF USED("cursor_4c_ValidTT")
                    USE IN cursor_4c_ValidTT
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.ValidarParcelas")
            loc_lValido = .F.
        ENDTRY
        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdDadosAfterRowColChange - Handler AfterRowColChange do grd_4c_Dados
    * par_nColIndex: coluna que foi DEIXADA (coluna anterior)
    * Implementa:
    *   - Validacao de nParcs duplicado (ao sair da col1)
    *   - ReadOnly dinamico por coluna (equivalente ao When original)
    *   - Marcacao de GravaDados
    *--------------------------------------------------------------------------
    PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
        IF THIS.this_lRedirigindo
            RETURN
        ENDIF
        IF !USED("cursor_4c_FpagI") OR EOF("cursor_4c_FpagI")
            RETURN
        ENDIF

        LOCAL loc_oGrid, loc_nParcs, loc_nValMaxs, loc_nCurRec, loc_lDuplicado, loc_cEmps, loc_oErro
        TRY
            SELECT cursor_4c_FpagI
            loc_nParcs   = NVL(cursor_4c_FpagI.nParcs, 0)
            loc_nValMaxs = NVL(cursor_4c_FpagI.ValMaxs, 0)
            loc_oGrid    = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados

            *-- Ao sair da coluna 1 (nParcs): validar duplicatas
            IF par_nColIndex = 1 AND loc_nParcs > 0
                loc_nCurRec  = RECNO("cursor_4c_FpagI")
                loc_lDuplicado = .F.
                SCAN FOR !DELETED() AND nParcs = loc_nParcs AND RECNO() != loc_nCurRec
                    loc_lDuplicado = .T.
                    EXIT
                ENDSCAN
                IF loc_lDuplicado
                    SELECT cursor_4c_FpagI
                    GOTO loc_nCurRec
                    MsgAviso("N" + CHR(250) + "mero de Parcelas j" + CHR(225) + ;
                        " Digitada para esta Condi" + CHR(231) + CHR(227) + ;
                        "o de Pagamento.", "Validar")
                    THIS.this_lRedirigindo = .T.
                    REPLACE nParcs WITH 0 IN cursor_4c_FpagI
                    THIS.this_lRedirigindo = .F.
                    loc_nParcs = 0
                    loc_oGrid.Refresh()
                ENDIF
            ENDIF

            *-- Atualizar ReadOnly por coluna (logica do When original):
            *-- Col1 (nParcs):  editavel quando ValMaxs = 0
            *-- Col2 (ValMins): editavel quando nParcs > 0
            *-- Col3 (ValMaxs): editavel quando nParcs = 0
            *-- Col4 (Emps):    editavel quando nParcs = 0
            THIS.this_lRedirigindo = .T.
            loc_oGrid.Column1.ReadOnly = (loc_nValMaxs <> 0)
            loc_oGrid.Column2.ReadOnly = (loc_nParcs = 0)
            loc_oGrid.Column3.ReadOnly = (loc_nParcs <> 0)
            loc_oGrid.Column4.ReadOnly = (loc_nParcs <> 0)
            THIS.this_lRedirigindo = .F.

            THIS.GravaDados = .T.

            *-- Ao sair da coluna 4 (Emps): validar empresa (fAcessoEmpresa original)
            IF par_nColIndex = 4
                loc_cEmps = ALLTRIM(NVL(cursor_4c_FpagI.emps, ""))
                IF !EMPTY(loc_cEmps) AND !THIS.ValidarEmps(loc_cEmps)
                    SELECT cursor_4c_FpagI
                    REPLACE emps WITH "" IN cursor_4c_FpagI
                    loc_oGrid.Refresh()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_lRedirigindo = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.GrdDadosAfterRowColChange")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarEmps - Verifica se codigo de empresa existe em SigCdEmp
    * Substitui fAcessoEmpresa(Usuar,'C',This.Value,This) do original
    * Retorna .T. se empresa valida ou campo vazio; .F. se nao encontrada
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarEmps(par_cEmps)
        LOCAL loc_lValido, loc_cSQL, loc_oErro
        loc_lValido = .T.
        IF EMPTY(ALLTRIM(par_cEmps))
            RETURN loc_lValido
        ENDIF
        TRY
            IF USED("cursor_4c_EmpValida")
                USE IN cursor_4c_EmpValida
            ENDIF
            loc_cSQL = "SELECT Cemps FROM SigCdEmp " + ;
                       "WHERE Cemps = " + EscaparSQL(ALLTRIM(par_cEmps))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpValida") > 0
                IF RECCOUNT("cursor_4c_EmpValida") = 0
                    MsgAviso("Empresa " + ALLTRIM(par_cEmps) + ;
                        " n" + CHR(227) + "o encontrada em SigCdEmp.", ;
                        "Empresa")
                    loc_lValido = .F.
                ENDIF
                IF USED("cursor_4c_EmpValida")
                    USE IN cursor_4c_EmpValida
                ENDIF
            ELSE
                MsgErro("Falha ao verificar empresa " + ALLTRIM(par_cEmps) + ".", ;
                    "FormFpm.ValidarEmps")
                loc_lValido = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.ValidarEmps")
            IF USED("cursor_4c_EmpValida")
                USE IN cursor_4c_EmpValida
            ENDIF
            loc_lValido = .F.
        ENDTRY
        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConfirmarClick - Valida, salva e fecha (equivalente ao Encerrar)
    * Usado quando o form esta em Page2 (modo DADOS)
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarClick()
        THIS.BtnEncerrarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela edicao e volta para Page1 (ou fecha sem salvar)
    * Se GravaDados=.F. (sem alteracoes), libera direto.
    * Se GravaDados=.T., confirma antes de descartar.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        LOCAL loc_lFechar, loc_oErro
        loc_lFechar = .T.
        TRY
            IF THIS.GravaDados
                loc_lFechar = MsgConfirma("Existem altera" + CHR(231) + CHR(245) + ;
                    "es n" + CHR(227) + "o salvas." + CHR(13) + ;
                    "Deseja cancelar sem salvar?", "Cancelar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.BtnCancelarClick")
            loc_lFechar = .F.
        ENDTRY
        IF loc_lFechar
            THIS.GravaDados = .F.
            IF THIS.pgf_4c_Paginas.ActivePage = 2
                THIS.AlternarPagina(1)
            ELSE
                THIS.Release()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Alias CRUD para BtnInserirClick
    * Este eh um form OPERACIONAL de edicao inline (grid). Incluir = adicionar
    * nova linha em branco com o fpags corrente no cursor de parcelas.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.BtnInserirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Coloca o grid em modo de edicao inline
    * Este eh um form OPERACIONAL: o grid ja permite edicao direta a qualquer
    * momento. Este handler garante que Page1 esta ativa e coloca foco na
    * primeira coluna editavel da linha corrente. Segue a mesma politica de
    * ReadOnly por coluna aplicada em GrdDadosAfterRowColChange.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oGrid, loc_nParcs, loc_nValMaxs, loc_oErro
        TRY
            IF THIS.pgf_4c_Paginas.ActivePage != 1
                THIS.AlternarPagina(1)
            ENDIF
            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
            IF !USED("cursor_4c_FpagI") OR EOF("cursor_4c_FpagI")
                loc_oGrid.SetFocus
                RETURN
            ENDIF
            SELECT cursor_4c_FpagI
            loc_nParcs   = NVL(cursor_4c_FpagI.nParcs, 0)
            loc_nValMaxs = NVL(cursor_4c_FpagI.ValMaxs, 0)
            THIS.this_lRedirigindo = .T.
            loc_oGrid.Column1.ReadOnly = (loc_nValMaxs <> 0)
            loc_oGrid.Column2.ReadOnly = (loc_nParcs = 0)
            loc_oGrid.Column3.ReadOnly = (loc_nParcs <> 0)
            loc_oGrid.Column4.ReadOnly = (loc_nParcs <> 0)
            THIS.this_lRedirigindo = .F.
            loc_oGrid.SetFocus
            IF !loc_oGrid.Column1.ReadOnly
                loc_oGrid.ActivateCell(RECNO("cursor_4c_FpagI"), 1)
            ELSE
                IF !loc_oGrid.Column2.ReadOnly
                    loc_oGrid.ActivateCell(RECNO("cursor_4c_FpagI"), 2)
                ELSE
                    IF !loc_oGrid.Column3.ReadOnly
                        loc_oGrid.ActivateCell(RECNO("cursor_4c_FpagI"), 3)
                    ENDIF
                ENDIF
            ENDIF
            loc_oGrid.Refresh()
        CATCH TO loc_oErro
            THIS.this_lRedirigindo = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.BtnAlterarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Recarrega dados do BO e coloca grid em modo consulta
    * Este eh um form OPERACIONAL: "Visualizar" significa refazer o BuscarPor-
    * Condicao (descarta alteracoes em memoria nao salvas) e travar as colunas
    * como ReadOnly para inspecao dos valores atuais.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oGrid, loc_lRecarregar, loc_oErro
        loc_lRecarregar = .T.
        TRY
            IF THIS.GravaDados
                loc_lRecarregar = MsgConfirma("Existem altera" + CHR(231) + CHR(245) + ;
                    "es n" + CHR(227) + "o salvas." + CHR(13) + ;
                    "Recarregar os dados originais e descartar as altera" + ;
                    CHR(231) + CHR(245) + "es?", "Visualizar")
            ENDIF
            IF loc_lRecarregar
                IF THIS.pgf_4c_Paginas.ActivePage != 1
                    THIS.AlternarPagina(1)
                ENDIF
                IF USED("cursor_4c_FpagI")
                    TABLEREVERT(.T., "cursor_4c_FpagI")
                    USE IN cursor_4c_FpagI
                ENDIF
                THIS.CarregarDados()
                THIS.GravaDados = .F.
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
                THIS.this_lRedirigindo = .T.
                loc_oGrid.Column1.ReadOnly = .T.
                loc_oGrid.Column2.ReadOnly = .T.
                loc_oGrid.Column3.ReadOnly = .T.
                loc_oGrid.Column4.ReadOnly = .T.
                THIS.this_lRedirigindo = .F.
                loc_oGrid.Refresh()
            ENDIF
        CATCH TO loc_oErro
            THIS.this_lRedirigindo = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Alias canonico para CarregarDados
    * Este form OPERACIONAL usa um unico cursor (cursor_4c_FpagI) ligado ao
    * grid inline. CarregarLista recarrega o cursor a partir do BO usando o
    * fpags corrente e revincula o grid.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_FpagI")
                TABLEREVERT(.T., "cursor_4c_FpagI")
                USE IN cursor_4c_FpagI
            ENDIF
            loc_lSucesso = THIS.CarregarDados()
            IF loc_lSucesso
                THIS.GravaDados = .F.
                THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.CarregarLista")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Sincroniza estado do form para o BO
    * Neste form OPERACIONAL a edicao acontece INLINE no grd_4c_Dados sobre
    * cursor_4c_FpagI (o BO consulta o cursor diretamente em SalvarAlteracoes).
    * Aqui apenas garantimos que o fpags corrente esta propagado para o BO e
    * que qualquer edicao pendente na linha do grid foi commitada no cursor.
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_cFpagsAtual = THIS.this_cFpags
            ENDIF
            IF USED("cursor_4c_FpagI")
                SELECT cursor_4c_FpagI
                *-- Commit da linha corrente (usuario pode estar com edicao pendente)
                IF GETFLDSTATE(-1, "cursor_4c_FpagI") > 1
                    TABLEUPDATE(.F., .T., "cursor_4c_FpagI")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.FormParaBO")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Sincroniza estado do BO para o form
    * Atualiza a Caption (que inclui o fpags corrente) e revincula o grid.
    * Chamado apos operacoes que trocam o fpags no BO (ex: reload de contexto).
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        LOCAL loc_cFpags, loc_oErro
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_cFpags = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cFpagsAtual, ""))
                IF !EMPTY(loc_cFpags)
                    THIS.this_cFpags = loc_cFpags
                    THIS.Caption = "Valor M" + CHR(237) + "nimo/M" + CHR(225) + ;
                        "ximo Cond.Pagto " + loc_cFpags
                    THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                    THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                ENDIF
            ENDIF
            IF USED("cursor_4c_FpagI")
                THIS.VincularGrid()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita colunas editaveis do grid conforme
    * o modo corrente (LISTA=edicao inline liberada, VISUALIZAR=ReadOnly total).
    * Neste form OPERACIONAL nao ha TextBoxes soltos: os "campos" sao as
    * colunas do grd_4c_Dados. A politica granular por linha (baseada em
    * nParcs/ValMaxs) continua sendo aplicada pelo GrdDadosAfterRowColChange.
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab, loc_oGrid, loc_oCnt, loc_oErro
        loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
            THIS.this_lRedirigindo = .T.
            loc_oGrid.Column1.ReadOnly = !loc_lHab
            loc_oGrid.Column2.ReadOnly = !loc_lHab
            loc_oGrid.Column3.ReadOnly = !loc_lHab
            loc_oGrid.Column4.ReadOnly = !loc_lHab
            THIS.this_lRedirigindo = .F.

            *-- Botoes Inserir/Excluir seguem o modo (Encerrar sempre disponivel)
            loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
            loc_oCnt.cmd_4c_Inserir.Enabled = loc_lHab
            loc_oCnt.cmd_4c_Excluir.Enabled = loc_lHab

            *-- Se voltamos a habilitar edicao inline: reaplica politica por linha
            IF loc_lHab AND USED("cursor_4c_FpagI") AND !EOF("cursor_4c_FpagI")
                THIS.GrdDadosAfterRowColChange(0)
            ENDIF
            loc_oGrid.Refresh()
        CATCH TO loc_oErro
            THIS.this_lRedirigindo = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Descarta todas as linhas em memoria do cursor de parcelas
    * (usado por Cancelar/Buscar quando queremos zerar o grid antes de recarregar)
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oErro
        TRY
            IF USED("cursor_4c_FpagI")
                SELECT cursor_4c_FpagI
                TABLEREVERT(.T., "cursor_4c_FpagI")
                DELETE ALL
                *-- Compacta remocoes marcadas (evita SET DELETED clutter no scan)
                SET DELETED ON
                PACK
                SET DELETED OFF
            ENDIF
            THIS.GravaDados = .F.
            THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta Enabled dos botoes conforme this_cModoAtual
    * LISTA:      Inserir=ON, Excluir=ON, Encerrar=ON, Confirmar/Cancelar=OFF
    * VISUALIZAR: Inserir=OFF, Excluir=OFF, Encerrar=ON, Confirmar/Cancelar=OFF
    * DADOS:      Confirmar=ON, Cancelar=ON, botoes Page1 inativos por contexto
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oCntL, loc_oCntD, loc_cModo, loc_oErro
        loc_cModo = UPPER(ALLTRIM(THIS.this_cModoAtual))
        TRY
            loc_oCntL = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
            loc_oCntD = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
            DO CASE
                CASE loc_cModo == "VISUALIZAR"
                    loc_oCntL.cmd_4c_Inserir.Enabled  = .F.
                    loc_oCntL.cmd_4c_Excluir.Enabled  = .F.
                    loc_oCntL.cmd_4c_Encerrar.Enabled = .T.
                    loc_oCntD.cmd_4c_Confirmar.Enabled = .F.
                    loc_oCntD.cmd_4c_Cancelar.Enabled  = .T.
                CASE loc_cModo == "DADOS"
                    loc_oCntL.cmd_4c_Inserir.Enabled  = .F.
                    loc_oCntL.cmd_4c_Excluir.Enabled  = .F.
                    loc_oCntL.cmd_4c_Encerrar.Enabled = .T.
                    loc_oCntD.cmd_4c_Confirmar.Enabled = .T.
                    loc_oCntD.cmd_4c_Cancelar.Enabled  = .T.
                OTHERWISE   && LISTA (default)
                    loc_oCntL.cmd_4c_Inserir.Enabled  = .T.
                    loc_oCntL.cmd_4c_Excluir.Enabled  = .T.
                    loc_oCntL.cmd_4c_Encerrar.Enabled = .T.
                    loc_oCntD.cmd_4c_Confirmar.Enabled = .T.
                    loc_oCntD.cmd_4c_Cancelar.Enabled  = .T.
            ENDCASE
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Recarrega parcelas do BO (refresh do grid)
    * Se ha alteracoes nao salvas, confirma antes de descartar.
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_lRecarregar, loc_oErro
        loc_lRecarregar = .T.
        TRY
            IF THIS.GravaDados
                loc_lRecarregar = MsgConfirma("Existem altera" + CHR(231) + CHR(245) + ;
                    "es n" + CHR(227) + "o salvas." + CHR(13) + ;
                    "Recarregar descartando as altera" + CHR(231) + CHR(245) + "es?", ;
                    "Buscar")
            ENDIF
            IF loc_lRecarregar
                THIS.LimparCampos()
                THIS.CarregarLista()
                THIS.AlternarPagina(1)
                THIS.AjustarBotoesPorModo()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.BtnBuscarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Persiste alteracoes sem fechar o form
    * Diferente do BtnEncerrarClick (que salva e fecha), este apenas commita
    * as edicoes correntes no banco (SigOpFpi) e mantem o form aberto.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lValido, loc_lSucesso, loc_oErro
        TRY
            IF !THIS.GravaDados
                RETURN
            ENDIF
            THIS.FormParaBO()
            loc_lValido = THIS.ValidarParcelas()
            IF loc_lValido
                loc_lSucesso = THIS.this_oBusinessObject.SalvarAlteracoes(THIS.this_cFpags)
                IF loc_lSucesso
                    THIS.GravaDados = .F.
                    MsgInfo("Altera" + CHR(231) + CHR(245) + "es salvas com sucesso.", "Salvar")
                ELSE
                    MsgAviso("Falha ao salvar as altera" + CHR(231) + CHR(245) + "es.", ;
                        "Salvar")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormFpm.BtnSalvarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores e reabilita o form pai
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_FpagI")
            TABLEREVERT(.T., "cursor_4c_FpagI")
            USE IN cursor_4c_FpagI
        ENDIF
        IF USED("cursor_4c_FpagITemp")
            USE IN cursor_4c_FpagITemp
        ENDIF
        IF USED("cursor_4c_ValidTT")
            USE IN cursor_4c_ValidTT
        ENDIF
        IF USED("cursor_4c_EmpValida")
            USE IN cursor_4c_EmpValida
        ENDIF
        IF VARTYPE(THIS.this_oParentForm) = "O"
            THIS.this_oParentForm.Enabled = .T.
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\FpmBO.prg):
*------------------------------------------------------------------------------
* FpmBO.prg - Business Object para Valores Min/Max de Condicao de Pagamento
* Tabela: SigOpFpi
* Origem: SIGCDFPM.SCX (sub-form de SigCdFpm)
*------------------------------------------------------------------------------

DEFINE CLASS FpmBO AS BusinessBase

    *-- Configuracao da tabela
    this_cTabela     = "SigOpFpi"
    this_cCampoChave = "cidchaves"

    *-- Campos de SigOpFpi
    this_cFpags      = ""  && char(12) - codigo da condicao de pagamento (FK)
    this_nNparcs     = 0   && numeric(2,0) - numero de parcelas
    this_nValmins    = 0   && numeric(11,2) - valor minimo
    this_nValmaxs    = 0   && numeric(11,2) - valor maximo
    this_cEmps       = ""  && char(3) - codigo da empresa
    this_cCidchaves  = ""  && char(20) - chave primaria unica

    *-- Contexto de edicao (recebido do form pai via parametro)
    this_cFpagsAtual = ""  && fpags da condicao em edicao (filtro do SQLEXEC)

    PROCEDURE Init()
        THIS.this_cTabela     = "SigOpFpi"
        THIS.this_cCampoChave = "cidchaves"
        RETURN DODEFAULT()
    ENDPROC

    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidchaves
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarPorCondicao - Carrega registros de SigOpFpi para cursor do grid
    *--------------------------------------------------------------------------
    PROCEDURE BuscarPorCondicao(par_cFpags)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_FpagI")
                TABLEREVERT(.T., "cursor_4c_FpagI")
                USE IN cursor_4c_FpagI
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_FpagI ;
                (fpags    C(12) NULL, ;
                 nparcs   N(2,0) NULL, ;
                 valmins  N(11,2) NULL, ;
                 valmaxs  N(11,2) NULL, ;
                 emps     C(3) NULL, ;
                 cidchaves C(20) NULL)
            SET NULL OFF

            INDEX ON fpags + STR(nparcs, 2) TAG fpags
            INDEX ON nparcs TAG nparcs
            SET ORDER TO

            loc_cSQL = "SELECT fpags, nparcs, valmins, valmaxs, emps, cidchaves " + ;
                       "FROM SigOpFpi " + ;
                       "WHERE fpags = " + EscaparSQL(par_cFpags) + ;
                       " ORDER BY nparcs"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FpagITemp") > 0
                SELECT cursor_4c_FpagI
                APPEND FROM DBF("cursor_4c_FpagITemp")
                IF USED("cursor_4c_FpagITemp")
                    USE IN cursor_4c_FpagITemp
                ENDIF
                SELECT cursor_4c_FpagI
                SET ORDER TO
                GO TOP
                THIS.this_cFpagsAtual = par_cFpags
                loc_lSucesso = .T.
            ELSE
                IF USED("cursor_4c_FpagITemp")
                    USE IN cursor_4c_FpagITemp
                ENDIF
                MsgErro("Falha ao carregar parcelas da condi" + CHR(231) + CHR(227) + "o de pagamento.", "Erro")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em BuscarPorCondicao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InserirLinha - Insere nova linha em branco no cursor local do grid
    *--------------------------------------------------------------------------
    PROCEDURE InserirLinha(par_cFpags)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF !USED("cursor_4c_FpagI")
            MsgAviso("Cursor de parcelas n" + CHR(227) + "o inicializado.", "Aviso")
            RETURN loc_lSucesso
        ENDIF

        TRY
            SELECT cursor_4c_FpagI
            INSERT INTO cursor_4c_FpagI (fpags, nparcs, valmins, valmaxs, emps) ;
                VALUES (par_cFpags, 0, 0, 0, "")
            GO BOTTOM
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em InserirLinha")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExcluirLinha - Marca linha corrente para exclusao no cursor local
    *--------------------------------------------------------------------------
    PROCEDURE ExcluirLinha()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF !USED("cursor_4c_FpagI")
            RETURN loc_lSucesso
        ENDIF

        TRY
            SELECT cursor_4c_FpagI
            IF !EOF()
                DELETE
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ExcluirLinha")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExisteNparcs - Verifica se numero de parcelas ja existe no cursor local
    * Usado pelo form para validacao inline na grade
    *--------------------------------------------------------------------------
    PROCEDURE ExisteNparcs(par_nNparcs)
        LOCAL loc_lExiste, loc_nRecNoAtual
        loc_lExiste = .F.

        IF !USED("cursor_4c_FpagI") OR par_nNparcs <= 0
            RETURN loc_lExiste
        ENDIF

        SELECT cursor_4c_FpagI
        loc_nRecNoAtual = RECNO("cursor_4c_FpagI")

        SET ORDER TO fpags
        IF SEEK(cursor_4c_FpagI.fpags + STR(par_nNparcs, 2), "cursor_4c_FpagI", "fpags")
            SKIP
            IF !EOF("cursor_4c_FpagI")
                IF cursor_4c_FpagI.fpags + STR(cursor_4c_FpagI.nparcs, 2) = ;
                   cursor_4c_FpagI.fpags + STR(par_nNparcs, 2)
                    loc_lExiste = .T.
                ENDIF
            ENDIF
        ENDIF

        SET ORDER TO
        IF loc_nRecNoAtual > 0
            GO (loc_nRecNoAtual) IN cursor_4c_FpagI
        ELSE
            GO BOTTOM IN cursor_4c_FpagI
        ENDIF

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarConsistencia - Valida duplicidade de nparcs antes de salvar
    *--------------------------------------------------------------------------
    PROCEDURE ValidarConsistencia()
        LOCAL loc_lValido, loc_oErro
        loc_lValido = .T.

        IF !USED("cursor_4c_FpagI")
            RETURN loc_lValido
        ENDIF

        TRY
            SELECT nparcs, SUM(1) AS nTotal ;
                FROM cursor_4c_FpagI ;
                WHERE (nparcs > 0 OR valmaxs > 0) AND !DELETED() ;
                GROUP BY nparcs ;
                HAVING SUM(1) > 1 ;
                INTO CURSOR cursor_4c_ValidTT READWRITE

            IF RECCOUNT("cursor_4c_ValidTT") > 0
                MsgAviso("Dados Inconsistentes!!! N" + CHR(250) + "mero de parcelas duplicado.", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                loc_lValido = .F.
            ENDIF

            IF USED("cursor_4c_ValidTT")
                USE IN cursor_4c_ValidTT
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ValidarConsistencia")
            loc_lValido = .F.
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarAlteracoes - Persiste cursor local no SQL Server
    * Delete todos registros existentes e reinsere do cursor
    *--------------------------------------------------------------------------
    PROCEDURE SalvarAlteracoes(par_cFpags)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        LOCAL loc_cFpags, loc_nNparcs, loc_nValmins, loc_nValmaxs, loc_cEmps
        loc_lSucesso = .F.

        IF !USED("cursor_4c_FpagI")
            MsgAviso("Cursor de parcelas n" + CHR(227) + "o inicializado.", "Aviso")
            RETURN loc_lSucesso
        ENDIF

        TRY
            *-- Deletar registros existentes para esta condicao de pagamento
            loc_cSQL = "DELETE FROM SigOpFpi WHERE fpags = " + EscaparSQL(par_cFpags)
            IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                MsgErro("Falha ao remover parcelas anteriores.", "Erro")
            ELSE
                loc_lSucesso = .T.
            ENDIF

            *-- Reinserir do cursor local (apenas linhas validas: nparcs != 0 OU valmaxs != 0)
            IF loc_lSucesso
                SELECT cursor_4c_FpagI
                GO TOP
                DO WHILE !EOF() AND loc_lSucesso
                    IF !DELETED() AND (!EMPTY(cursor_4c_FpagI.nparcs) OR !EMPTY(cursor_4c_FpagI.valmaxs))
                        loc_cFpags   = cursor_4c_FpagI.fpags
                        loc_nNparcs  = cursor_4c_FpagI.nparcs
                        loc_nValmins = cursor_4c_FpagI.valmins
                        loc_nValmaxs = cursor_4c_FpagI.valmaxs
                        loc_cEmps    = cursor_4c_FpagI.emps

                        loc_cSQL = "INSERT INTO SigOpFpi " + ;
                                   "(fpags, nparcs, valmins, valmaxs, emps, cidchaves) " + ;
                                   "VALUES (" + ;
                                   EscaparSQL(loc_cFpags) + ", " + ;
                                   FormatarNumeroSQL(loc_nNparcs, 0) + ", " + ;
                                   FormatarNumeroSQL(loc_nValmins, 2) + ", " + ;
                                   FormatarNumeroSQL(loc_nValmaxs, 2) + ", " + ;
                                   EscaparSQL(loc_cEmps) + ", " + ;
                                   "LEFT(REPLACE(CAST(NEWID() AS varchar(36)), '-', ''), 20))"

                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                            MsgErro("Falha ao inserir parcela nParcs=" + ;
                                    TRANSFORM(loc_nNparcs) + ".", "Erro")
                            loc_lSucesso = .F.
                        ENDIF
                    ENDIF
                    SKIP
                ENDDO
            ENDIF

            IF loc_lSucesso
                THIS.RegistrarAuditoria("SALVAR")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SalvarAlteracoes")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cFpags     = TratarNulo(fpags, "C")
            THIS.this_nNparcs    = TratarNulo(nparcs, "N")
            THIS.this_nValmins   = TratarNulo(valmins, "N")
            THIS.this_nValmaxs   = TratarNulo(valmaxs, "N")
            THIS.this_cEmps      = TratarNulo(emps, "C")
            THIS.this_cCidchaves = TratarNulo(cidchaves, "C")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *-- ValidarDados: validacao inline feita no grid; satisfaz cadeia BusinessBase
    PROTECTED PROCEDURE ValidarDados()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Persiste uma linha de SigOpFpi (chave surrogate cidchaves gerada
    * via NEWID SQL Server). Usa propriedades this_c*/this_n* populadas
    * previamente por CarregarDoCursor ou FormParaBO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigOpFpi " + ;
                       "(fpags, nparcs, valmins, valmaxs, emps, cidchaves) " + ;
                       "VALUES (" + ;
                       EscaparSQL(THIS.this_cFpags) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNparcs, 0) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nValmins, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nValmaxs, 2) + ", " + ;
                       EscaparSQL(THIS.this_cEmps) + ", " + ;
                       "LEFT(REPLACE(CAST(NEWID() AS varchar(36)), '-', ''), 20))"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
                THIS.RegistrarAuditoria("INSERIR")
            ELSE
                THIS.this_cMensagemErro = "Falha ao inserir parcela nParcs=" + ;
                                          TRANSFORM(THIS.this_nNparcs)
                MsgErro(THIS.this_cMensagemErro, "Erro em Inserir")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza uma linha de SigOpFpi identificada por this_cCidchaves.
    * Usa propriedades this_n* populadas previamente por CarregarDoCursor ou
    * FormParaBO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidchaves)
                THIS.this_cMensagemErro = "Chave prim" + CHR(225) + "ria (cidchaves) vazia."
                MsgErro(THIS.this_cMensagemErro, "Erro em Atualizar")
            ELSE
                loc_cSQL = "UPDATE SigOpFpi SET " + ;
                           "nparcs = " + FormatarNumeroSQL(THIS.this_nNparcs, 0) + ", " + ;
                           "valmins = " + FormatarNumeroSQL(THIS.this_nValmins, 2) + ", " + ;
                           "valmaxs = " + FormatarNumeroSQL(THIS.this_nValmaxs, 2) + ", " + ;
                           "emps = " + EscaparSQL(THIS.this_cEmps) + " " + ;
                           "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

                IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                    loc_lSucesso = .T.
                    THIS.RegistrarAuditoria("ATUALIZAR")
                ELSE
                    THIS.this_cMensagemErro = "Falha ao atualizar parcela cidchaves=" + ;
                                              ALLTRIM(THIS.this_cCidchaves)
                    MsgErro(THIS.this_cMensagemErro, "Erro em Atualizar")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Remove linha de SigOpFpi identificada por this_cCidchaves.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidchaves)
                THIS.this_cMensagemErro = "Chave prim" + CHR(225) + "ria (cidchaves) vazia."
                MsgErro(THIS.this_cMensagemErro, "Erro em ExecutarExclusao")
            ELSE
                loc_cSQL = "DELETE FROM SigOpFpi WHERE cidchaves = " + ;
                           EscaparSQL(THIS.this_cCidchaves)

                IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                    loc_lSucesso = .T.
                    THIS.RegistrarAuditoria("EXCLUIR")
                ELSE
                    THIS.this_cMensagemErro = "Falha ao excluir parcela cidchaves=" + ;
                                              ALLTRIM(THIS.this_cCidchaves)
                    MsgErro(THIS.this_cMensagemErro, "Erro em ExecutarExclusao")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

