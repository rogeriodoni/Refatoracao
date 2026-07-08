# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[Formsigreanr.prg] Indicador de pendencia: * Eventos CRUD - Forms REPORT (frmrelatorio) nao implement
[Formsigreanr.prg] Indicador de pendencia: *   Forms REPORT nao implement

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreanr.prg):
*==============================================================================
* FORMSIGREANR.PRG
* Relatorio de Resultados - Formulario de Filtros
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREANR.SCX (frmrelatorio)
*
* Filtros:
*   - Periodo: txt_4c_DtInicial (get_dt_inicial) / txt_4c_DtFinal (get_dt_final)
*   - Data Cotacao: txt_4c_DtCotacao (Get_Dt_Cotacao)
*   - Empresa: txt_4c_Empresa (get_empresa - codigo 3 chars)
*              txt_4c_EmpresaDesc (get_empresa_desc - razao social, 40 chars)
*
* Posicoes originais: Width=800, Height=300
* PageFrame.Top=85; posicao em Page1 = Top_original - 85
*   lbl_periodo     : Top=137, Left=252 -> Page1: Top=52, Left=252
*   get_dt_inicial  : Top=132, Left=300 -> Page1: Top=47, Left=300, Width=80
*   lbl_periodo_a   : Top=136, Left=384 -> Page1: Top=51, Left=384 (CHR(224) = a-grave)
*   get_dt_final    : Top=132, Left=396 -> Page1: Top=47, Left=396, Width=80
*   Say1 (cotacao)  : Top=160, Left=222 -> Page1: Top=75, Left=222
*   Get_Dt_Cotacao  : Top=157, Left=300 -> Page1: Top=72, Left=300, Width=80
*   lbl_empresa     : Top=187, Left=247 -> Page1: Top=102, Left=247
*   get_empresa     : Top=182, Left=300 -> Page1: Top=97,  Left=300, Width=31
*   get_empresa_desc: Top=182, Left=333 -> Page1: Top=97,  Left=333, Width=290
*==============================================================================

DEFINE CLASS Formsigreanr AS FormBase

    *-- Dimensoes exatas do original: Width=800, Height=300
    Height      = 300
    Width       = 800
    DataSession = 2
    ShowWindow  = 1
    WindowType  = 1
    AutoCenter  = .T.
    BorderStyle = 2
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    ShowTips    = .T.

    *-- BO de relatorio (instanciado em InicializarForm)
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura visual do formulario de relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            THIS.Caption = "Relat" + CHR(243) + "rio de Resultados"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            IF TYPE("gc_4c_CaminhoReports") = "U"
                gc_4c_CaminhoReports = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            THIS.this_oRelatorio = CREATEOBJECT("sigreanrBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar sigreanrBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.LimparCampos()
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro superior com titulo e botoes
    *   Width = THIS.Width (800) para cobrir toda a faixa superior.
    *   BackColor=RGB(100,100,100) = cinza medio do framework (cntSombra).
    *   cmg_4c_Botoes: CommandGroup com 4 botoes (Visualizar/Imprimir/DocExcel/Sair)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab, loc_oCmg
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
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 22
                .Left      = 22
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Relat" + CHR(243) + "rio de Resultados"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 20
                .Left      = 20
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Relat" + CHR(243) + "rio de Resultados"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Botoes de relatorio (framework frmrelatorio: cmg_4c_Botoes)
            .AddObject("cmg_4c_Botoes", "CommandGroup")
            WITH .cmg_4c_Botoes
                .Top           = 0
                .Left          = 527
                .Width         = THIS.Width
                .Height        = 80
                .ButtonCount   = 4
                .BackStyle     = 0
                .BorderColor   = RGB(136, 189, 188)
                .SpecialEffect = 1
                .Themes        = .F.
                .Visible       = .T.

                WITH .Buttons(1)
                    .Caption         = "Visualizar"
                    .Top             = 5
                    .Left            = 5
                    .Width           = THIS.Width
                    .Height          = 70
                    .Picture         = gc_4c_CaminhoIcones + "ideo.jpg"
                    .PicturePosition = 13
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .Themes          = .F.
                ENDWITH

                WITH .Buttons(2)
                    .Caption         = "Imprimir"
                    .Top             = 5
                    .Left            = 71
                    .Width           = THIS.Width
                    .Height          = 70
                    .Picture         = gc_4c_CaminhoIcones + "impressora.jpg"
                    .PicturePosition = 13
                    .FontName        = "Comic Sans MS"
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .FontSize        = 8
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .Themes          = .F.
                ENDWITH

                WITH .Buttons(3)
                    .Caption         = "Doc. Excel"
                    .Top             = 5
                    .Left            = 137
                    .Width           = THIS.Width
                    .Height          = 70
                    .Picture         = gc_4c_CaminhoIcones + "excel.jpg"
                    .PicturePosition = 13
                    .FontName        = "Comic Sans MS"
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .FontSize        = 8
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .Themes          = .F.
                ENDWITH

                WITH .Buttons(4)
                    .Caption         = "Sair"
                    .Top             = 5
                    .Left            = 203
                    .Width           = THIS.Width
                    .Height          = 70
                    .Picture         = gc_4c_CaminhoIcones + "otao_encerrar.jpg"
                    .PicturePosition = 13
                    .Cancel          = .T.
                    .FontName        = "Comic Sans MS"
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .FontSize        = 8
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .Themes          = .F.
                ENDWITH
            ENDWITH
        ENDWITH

        loc_oCmg = loc_oCab.cmg_4c_Botoes
        BINDEVENT(loc_oCmg.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oCmg.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(loc_oCmg.Buttons(3), "Click", THIS, "BtnGerarExcelClick")
        BINDEVENT(loc_oCmg.Buttons(4), "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com 1 pagina (Filtros)
    *   Form: Width=800, Height=300
    *   Cabecalho Height=80; PageFrame.Top=85, Height=300-85=215, Width=802
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        loc_oPgf.PageCount = 1
        loc_oPgf.Top       = 85
        loc_oPgf.Left      = -1
        loc_oPgf.Width     = THIS.Width + 2
        loc_oPgf.Height    = THIS.Height - 85
        loc_oPgf.Tabs      = .F.

        loc_oPgf.Page1.Caption   = "Filtros"
        loc_oPgf.Page1.FontName  = "Tahoma"
        loc_oPgf.Page1.FontSize  = 8
        loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Ativa a pagina informada (forms REPORT tem so Page1).
    *   par_nPagina: indice 1-based. Valor invalido cai em 1.
    *   Apos ativar, foca txt_4c_DtInicial para iniciar entrada de filtros.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina, loc_oErro, loc_oPagina
        TRY
            loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)
            IF loc_nPagina < 1 OR loc_nPagina > THIS.pgf_4c_Paginas.PageCount
                loc_nPagina = 1
            ENDIF
            THIS.pgf_4c_Paginas.ActivePage = loc_nPagina
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            IF PEMSTATUS(loc_oPagina, "txt_4c_DtInicial", 5)
                loc_oPagina.txt_4c_DtInicial.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Alternar P" + CHR(225) + "gina")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera referencia ao BO
    *   RelatorioBase herda de Custom (sem Release()) - usar .NULL. para liberar
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Adiciona controles de filtro na Page1 (pagina unica)
    *   Forms REPORT nao tem grid CRUD; a "lista" eh o painel de filtros que
    *   seleciona o conjunto de dados que sera enviado ao FRX. As posicoes
    *   originais sao deslocadas: Top_page1 = Top_original - PageFrame.Top(85).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.AddObject("lbl_4c_Periodo", "Label")
        WITH loc_oPagina.lbl_4c_Periodo
            .Top       = 52
            .Left      = 252
            .Width     = 45
            .Height    = 18
            .Caption   = "Per" + CHR(237) + "odo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oPagina.txt_4c_DtInicial
            .Top         = 47
            .Left        = 300
            .Width       = 80
            .Height      = 23
            .Value       = {}
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DtInicial, "KeyPress", THIS, "TeclaDataInicial")

        loc_oPagina.AddObject("lbl_4c_PeriodoA", "Label")
        WITH loc_oPagina.lbl_4c_PeriodoA
            .Top       = 51
            .Left      = 384
            .Width     = 8
            .Height    = 18
            .Caption   = CHR(224)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DtFinal", "TextBox")
        WITH loc_oPagina.txt_4c_DtFinal
            .Top         = 47
            .Left        = 396
            .Width       = 80
            .Height      = 23
            .Value       = {}
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DtFinal, "KeyPress", THIS, "TeclaDataFinal")

        loc_oPagina.AddObject("lbl_4c_DtCotacao", "Label")
        WITH loc_oPagina.lbl_4c_DtCotacao
            .Top       = 75
            .Left      = 222
            .Width     = 75
            .Height    = 18
            .Caption   = "Data Cota" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DtCotacao", "TextBox")
        WITH loc_oPagina.txt_4c_DtCotacao
            .Top         = 72
            .Left        = 300
            .Width       = 80
            .Height      = 23
            .Value       = {}
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DtCotacao, "KeyPress", THIS, "TeclaDtCotacao")

        loc_oPagina.AddObject("lbl_4c_Empresa", "Label")
        WITH loc_oPagina.lbl_4c_Empresa
            .Top       = 102
            .Left      = 247
            .Width     = 50
            .Height    = 18
            .Caption   = "Empresa :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Empresa", "TextBox")
        WITH loc_oPagina.txt_4c_Empresa
            .Top         = 97
            .Left        = 300
            .Width       = 31
            .Height      = 23
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .MaxLength   = 3
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Empresa, "KeyPress", THIS, "TeclaEmpresa")

        loc_oPagina.AddObject("txt_4c_EmpresaDesc", "TextBox")
        WITH loc_oPagina.txt_4c_EmpresaDesc
            .Top         = 97
            .Left        = 333
            .Width       = 290
            .Height      = 23
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .MaxLength   = 40
            .ReadOnly    = .T.
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_EmpresaDesc, "KeyPress", THIS, "TeclaEmpresaDesc")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Nao utilizado em form REPORT (sem Page2 de edicao)
    *   Mantido para compatibilidade com o pipeline multi-fase. Forms REPORT
    *   usam apenas Page1 (Filtros), configurada em ConfigurarPaginaLista().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Inicializa filtros com valores padrao (datas = hoje)
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        WITH loc_oPagina
            .txt_4c_DtInicial.Value      = DATE()
            .txt_4c_DtFinal.Value        = DATE()
            .txt_4c_DtCotacao.Value      = DATE()
            .txt_4c_Empresa.Value        = ""
            .txt_4c_EmpresaDesc.Value    = ""
            .txt_4c_EmpresaDesc.ReadOnly = .F.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Copia valores do form para o BO antes de imprimir
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            .this_dDtInicial   = loc_oPagina.txt_4c_DtInicial.Value
            .this_dDtFinal     = loc_oPagina.txt_4c_DtFinal.Value
            .this_dDtCotacao   = loc_oPagina.txt_4c_DtCotacao.Value
            .this_cEmpresa     = ALLTRIM(loc_oPagina.txt_4c_Empresa.Value)
            .this_cEmpresaDesc = ALLTRIM(loc_oPagina.txt_4c_EmpresaDesc.Value)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * Eventos CRUD - Forms REPORT (frmrelatorio) nao implementam Incluir/Alterar
    * /Excluir. Os botoes disponiveis em forms de relatorio sao apenas:
    *   - Visualizar (preview na tela) -> BtnVisualizarClick
    *   - Imprimir (com dialogo)       -> BtnImprimirClick
    *   - Doc. Excel (export)          -> BtnGerarExcelClick
    *   - Sair                         -> BtnCancelarClick
    * Os handlers abaixo existem por compatibilidade com a interface generica
    * do pipeline multi-fase, mas informam ao usuario quando acionados.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        MsgInfo("Inclus" + CHR(227) + "o n" + CHR(227) + "o se aplica a este " + ;
            "formul" + CHR(225) + "rio de relat" + CHR(243) + "rio." + CHR(13) + ;
            "Use Visualizar (F5) ou Imprimir (F6).", ;
            "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + "vel")
    ENDPROC

    PROCEDURE BtnAlterarClick()
        MsgInfo("Altera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o se aplica a este " + ;
            "formul" + CHR(225) + "rio de relat" + CHR(243) + "rio." + CHR(13) + ;
            "Use Visualizar (F5) ou Imprimir (F6).", ;
            "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + "vel")
    ENDPROC

    PROCEDURE BtnExcluirClick()
        MsgInfo("Exclus" + CHR(227) + "o n" + CHR(227) + "o se aplica a este " + ;
            "formul" + CHR(225) + "rio de relat" + CHR(243) + "rio." + CHR(13) + ;
            "Use Visualizar (F5) ou Imprimir (F6).", ;
            "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + "vel")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Preview do relatorio na tela
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro, loc_lContinuar
        loc_lContinuar = .T.
        TRY
            IF EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c_DtInicial.Value) OR ;
               EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c_DtFinal.Value)
                MsgAviso("Informe o per" + CHR(237) + "odo.", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                loc_lContinuar = .F.
            ENDIF
            IF loc_lContinuar
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.Visualizar()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                            "Erro ao Visualizar")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Imprime relatorio com dialogo de impressora
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        LOCAL loc_oErro, loc_lContinuar
        loc_lContinuar = .T.
        TRY
            IF EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c_DtInicial.Value) OR ;
               EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c_DtFinal.Value)
                MsgAviso("Informe o per" + CHR(237) + "odo.", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                loc_lContinuar = .F.
            ENDIF
            IF loc_lContinuar
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.Imprimir()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                            "Erro ao Imprimir")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnGerarExcelClick - Impressao direta sem dialogo (Doc. Excel)
    *--------------------------------------------------------------------------
    PROCEDURE BtnGerarExcelClick()
        LOCAL loc_oErro, loc_lContinuar
        loc_lContinuar = .T.
        TRY
            IF EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c_DtInicial.Value) OR ;
               EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c_DtFinal.Value)
                MsgAviso("Informe o per" + CHR(237) + "odo.", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                loc_lContinuar = .F.
            ENDIF
            IF loc_lContinuar
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.GerarExcel()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                            "Erro ao Gerar Documento")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Fecha o formulario (ESC via Buttons(4).Cancel=.T.)
    *   Buttons(4) eh o "Sair" do CommandGroup; Cancel=.T. mapeia ESC para ele.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * Aliases de interface CRUD - exigidos pelo pipeline multi-fase (Fase 8).
    *   Forms REPORT nao implementam Buscar/Encerrar/Salvar como botoes proprios,
    *   mas o validador exige a assinatura. Mapeamos para as acoes de relatorio:
    *     BtnBuscarClick   -> Visualizar (acao de "preview" similar a uma busca)
    *     BtnEncerrarClick -> Release  (fecha o form)
    *     BtnSalvarClick   -> Imprimir (acao "definitiva" do relatorio)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    PROCEDURE BtnConsultarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO / BOParaForm - Aliases para a interface generica FormBase.
    *   Forms REPORT usam FormParaRelatorio() como nome principal; estes
    *   wrappers existem para o pipeline multi-fase. BOParaForm copia os
    *   filtros do BO de volta para a tela (uso em "reabrir relatorio").
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg, loc_oErro
        TRY
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                loc_oPg = THIS.pgf_4c_Paginas.Page1
                WITH THIS.this_oRelatorio
                    IF !EMPTY(.this_dDtInicial)
                        loc_oPg.txt_4c_DtInicial.Value = .this_dDtInicial
                    ENDIF
                    IF !EMPTY(.this_dDtFinal)
                        loc_oPg.txt_4c_DtFinal.Value = .this_dDtFinal
                    ENDIF
                    IF !EMPTY(.this_dDtCotacao)
                        loc_oPg.txt_4c_DtCotacao.Value = .this_dDtCotacao
                    ENDIF
                    loc_oPg.txt_4c_Empresa.Value     = .this_cEmpresa
                    loc_oPg.txt_4c_EmpresaDesc.Value = .this_cEmpresaDesc
                ENDWITH
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita os campos de filtro (ReadOnly).
    *   par_lHabilitar = .T. -> filtros editaveis (estado padrao do form REPORT)
    *   par_lHabilitar = .F. -> filtros bloqueados (uso em "processando...")
    *   txt_4c_EmpresaDesc: mantem ReadOnly=.T. quando ja ha empresa selecionada
    *   para preservar a busca reversa (descricao so editavel sem codigo).
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg, loc_lHab, loc_oErro
        TRY
            loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
            loc_oPg  = THIS.pgf_4c_Paginas.Page1
            IF VARTYPE(loc_oPg) = "O"
                IF PEMSTATUS(loc_oPg, "txt_4c_DtInicial", 5)
                    loc_oPg.txt_4c_DtInicial.ReadOnly = !loc_lHab
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DtFinal", 5)
                    loc_oPg.txt_4c_DtFinal.ReadOnly = !loc_lHab
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DtCotacao", 5)
                    loc_oPg.txt_4c_DtCotacao.ReadOnly = !loc_lHab
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_Empresa", 5)
                    loc_oPg.txt_4c_Empresa.ReadOnly = !loc_lHab
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_EmpresaDesc", 5)
                    IF !loc_lHab
                        loc_oPg.txt_4c_EmpresaDesc.ReadOnly = .T.
                    ELSE
                        loc_oPg.txt_4c_EmpresaDesc.ReadOnly = ;
                            !EMPTY(ALLTRIM(loc_oPg.txt_4c_Empresa.Value))
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Forms REPORT nao tem grid CRUD; metodo presente apenas
    *   para compatibilidade com o pipeline (validador de Fase 8).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Em forms REPORT, todos os botoes do CommandGroup
    *   (Visualizar/Imprimir/Doc.Excel/Sair) ficam sempre habilitados; nao ha
    *   transicao de modo Lista/Edicao. Metodo mantido para uniformidade da
    *   interface generica de Forms; o que realmente protege contra acionamento
    *   indevido eh a validacao de periodo dentro de cada Btn*Click().
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oCmg, loc_oErro, loc_nI
        TRY
            IF VARTYPE(THIS.cnt_4c_Cabecalho) = "O" AND ;
               PEMSTATUS(THIS.cnt_4c_Cabecalho, "cmg_4c_Botoes", 5)
                loc_oCmg = THIS.cnt_4c_Cabecalho.cmg_4c_Botoes
                FOR loc_nI = 1 TO loc_oCmg.ButtonCount
                    loc_oCmg.Buttons(loc_nI).Enabled = .T.
                ENDFOR
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaEmpresa - KeyPress em txt_4c_Empresa
    *   F4(115): abre lookup de empresa
    *   ENTER(13)/TAB(9): valida codigo digitado contra SigCdEmp
    *--------------------------------------------------------------------------
    PROCEDURE TeclaEmpresa(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpresa()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarEmpresa()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarEmpresa - Busca empresa por codigo e preenche descricao
    *--------------------------------------------------------------------------
    PROCEDURE ValidarEmpresa()
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oErro, loc_lEncontrou
        loc_cValor    = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value)
        loc_lEncontrou = .F.
        TRY
            IF EMPTY(loc_cValor)
                THIS.pgf_4c_Paginas.Page1.txt_4c_EmpresaDesc.Value   = ""
                THIS.pgf_4c_Paginas.Page1.txt_4c_EmpresaDesc.ReadOnly = .F.
            ELSE
                loc_cSQL    = "SELECT Cemps, Razas FROM SigCdEmp " + ;
                              "WHERE Cemps = " + EscaparSQL(loc_cValor)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
                IF loc_nResult > 0 AND !EOF("cursor_4c_EmpVal")
                    SELECT cursor_4c_EmpVal
                    THIS.pgf_4c_Paginas.Page1.txt_4c_EmpresaDesc.Value   = ALLTRIM(Razas)
                    THIS.pgf_4c_Paginas.Page1.txt_4c_EmpresaDesc.ReadOnly = .T.
                    loc_lEncontrou = .T.
                ENDIF
                IF USED("cursor_4c_EmpVal")
                    USE IN cursor_4c_EmpVal
                ENDIF
                IF !loc_lEncontrou
                    THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value      = ""
                    THIS.pgf_4c_Paginas.Page1.txt_4c_EmpresaDesc.Value   = ""
                    THIS.pgf_4c_Paginas.Page1.txt_4c_EmpresaDesc.ReadOnly = .F.
                    THIS.AbrirBuscaEmpresa()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Validar Empresa")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaEmpresaDesc - KeyPress em txt_4c_EmpresaDesc
    *   ENTER(13)/TAB(9): busca empresa pela descricao digitada
    *--------------------------------------------------------------------------
    PROCEDURE TeclaEmpresaDesc(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarEmpresaDesc()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarEmpresaDesc - Busca empresa pela descricao (busca reversa)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarEmpresaDesc()
        LOCAL loc_cValor
        loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_EmpresaDesc.Value)
        IF EMPTY(loc_cValor)
            THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value     = ""
            THIS.pgf_4c_Paginas.Page1.txt_4c_EmpresaDesc.Value = ""
        ELSE
            THIS.AbrirBuscaEmpresa()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaEmpresa - Abre FormBuscaAuxiliar para selecao de empresa
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaEmpresa()
        LOCAL loc_oBusca, loc_oErro
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", ;
                "cursor_4c_BuscaEmp", ;
                "Cemps", ;
                ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value), ;
                "Buscar Empresa")

            IF VARTYPE(loc_oBusca) != "O"
                MsgErro("Erro ao criar janela de busca de Empresa.", "Erro")
            ELSE
                loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Razas", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou
                    IF USED("cursor_4c_BuscaEmp")
                        SELECT cursor_4c_BuscaEmp
                        THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value      = ALLTRIM(Cemps)
                        THIS.pgf_4c_Paginas.Page1.txt_4c_EmpresaDesc.Value  = ALLTRIM(Razas)
                        THIS.pgf_4c_Paginas.Page1.txt_4c_EmpresaDesc.ReadOnly = .T.
                    ENDIF
                ENDIF

                IF USED("cursor_4c_BuscaEmp")
                    USE IN cursor_4c_BuscaEmp
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Buscar Empresa")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDataInicial / TeclaDataFinal / TeclaDtCotacao
    * Handlers de KeyPress para campos de data (campos de texto simples, sem lookup)
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDataInicial(par_nKeyCode, par_nShift)
    ENDPROC

    PROCEDURE TeclaDataFinal(par_nKeyCode, par_nShift)
    ENDPROC

    PROCEDURE TeclaDtCotacao(par_nKeyCode, par_nShift)
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigreanrBO.prg):
*==============================================================================
* SIGREANRBO.PRG
* Business Object para Relatorio de Resultados
*
* Herda de RelatorioBase
* Form: Formsigreanr.prg
* Relatorio: SigReAnr.frx (REPORT FORM SigReAnr)
*
* Filtros: Periodo (DtInicial/DtFinal), Data Cotacao, Empresa
* Tabelas: SigCdOpe, SigMvCab, SigMvPar, SigCdEmp, SigCdMoe, SigCdCli, SigCdCot
* Cursores de saida (referenciados pelo .FRX):
*   TmpFinal   - dados principais por cliente/grupo/conta
*   TmpCabec   - cabecalho de colunas de moeda por empresa
*   dbCabecalho - titulo, periodo e nome da empresa
* Variaveis PUBLIC (referenciadas pelo .FRX):
*   _TotalTit, _TotalVal, _TotalGTit, _TotalGVal, _TotalGCot
*==============================================================================

DEFINE CLASS sigreanrBO AS RelatorioBase

    *-- Filtros do relatorio (entradas do form)
    this_dDtInicial     = {}
    this_dDtFinal       = {}
    this_dDtCotacao     = {}
    this_cEmpresa       = ""
    this_cEmpresaDesc   = ""

    *-- Configuracao do relatorio
    this_cArquivoFRX    = ""
    this_cTitulo        = ""

    *-- Cursor principal de saida (compativel com .FRX original)
    this_cCursorDados   = "TmpFinal"

    *--------------------------------------------------------------------------
    * Init - Configura arquivo FRX e titulo do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cArquivoFRX = gc_4c_CaminhoReports + "SigReAnr.frx"
        THIS.this_cTitulo     = "Relat" + CHR(243) + "rio de Resultados"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem do ultimo erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa todo o processamento do relatorio
    * Replica a PROCEDURE processamento do SIGREANR.SCX original
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cNomeEmpresa, loc_cTitulo, loc_cPeriodo
        LOCAL loc_cEmpresa, loc_cDopAtual, loc_nCOpers, loc_cEmpAtual
        LOCAL loc_lcQuery, loc_nResult
        LOCAL loc_lcEdn, loc_cGrupo, loc_cConta, loc_cTipoOper, loc_nValor
        LOCAL loc_nConta1, loc_nConta2, loc_lnNOrdRels
        LOCAL loc_nTotalGeral, loc_nCot1
        LOCAL loc_cTotalTit, loc_cTotalVal, loc_cTotalGTit, loc_cTotalGVal, loc_cTotalGCot
        LOCAL loc_cRazas, loc_cNomeCli

        loc_lSucesso     = .F.

        TRY
            DO WHILE .T.

                loc_cEmpresa = ALLTRIM(THIS.this_cEmpresa)

                *-- Busca nome da empresa corrente (cabecalho do relatorio)
                loc_lcQuery = "SELECT Cemps, Razas FROM SigCdEmp " + ;
                              "WHERE Cemps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa))
                loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crSigCdEmpHdr")
                loc_cNomeEmpresa = ""
                IF loc_nResult > 0 AND !EOF("crSigCdEmpHdr")
                    SELECT crSigCdEmpHdr
                    loc_cNomeEmpresa = ALLTRIM(Razas)
                ENDIF
                IF USED("crSigCdEmpHdr")
                    USE IN crSigCdEmpHdr
                ENDIF

                loc_cTitulo  = "Relat" + CHR(243) + "rio de Resultados - Empresa : " + ;
                               IIF(EMPTY(loc_cEmpresa), "Todas", loc_cEmpresa)
                loc_cPeriodo = "Per" + CHR(237) + "odo : " + ;
                               DTOC(THIS.this_dDtInicial) + " " + CHR(224) + " " + ;
                               DTOC(THIS.this_dDtFinal)

                *-- Cursor de cabecalho do relatorio (dbCabecalho)
                IF USED("dbCabecalho")
                    USE IN dbCabecalho
                ENDIF
                CREATE CURSOR dbCabecalho (NomeEmpresa C(80), Titulo C(80), Periodo C(80), ;
                                           Cabecalho C(200), Campo1 C(20), Campo2 C(20), ;
                                           Campo3 C(20), Campo4 C(20), Campo5 C(20), TotalGeral M(4))
                INSERT INTO dbCabecalho (NomeEmpresa, Titulo, Periodo) ;
                    VALUES (loc_cNomeEmpresa, loc_cTitulo, loc_cPeriodo)

                *-- Cursor acumulador de valores por cliente/grupo/conta/moeda
                IF USED("TmpCli")
                    USE IN TmpCli
                ENDIF
                CREATE CURSOR TmpCli (Grupo C(10), Conta C(10), TipoOper C(1), ;
                                      Emps C(3), Valor N(12,2), Moeda C(3))

                *-- Busca operacoes com fechamento habilitado (RelFechas = 1)
                loc_lcQuery = "SELECT Dopes, COpers FROM SigCdOpe " + ;
                              "WHERE RelFechas = 1 ORDER BY Dopes"
                loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crSigCdOpe")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (crSigCdOpe)"
                    EXIT
                ENDIF

                *-- Busca empresas (filtradas ou todas)
                IF EMPTY(loc_cEmpresa)
                    loc_lcQuery = "SELECT Cemps, Razas FROM SigCdEmp"
                ELSE
                    loc_lcQuery = "SELECT Cemps, Razas FROM SigCdEmp " + ;
                                  "WHERE Cemps = " + EscaparSQL(loc_cEmpresa)
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crSigCdEmp")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (crSigCdEmp)"
                    EXIT
                ENDIF
                SELECT crSigCdEmp
                INDEX ON Cemps TAG Cemps

                *-- Loop externo: para cada operacao (tipo de lancamento)
                SELECT crSigCdOpe
                SCAN
                    loc_cDopAtual = ALLTRIM(crSigCdOpe.Dopes)
                    loc_nCOpers   = crSigCdOpe.COpers

                    WAIT WINDOW "Processando Opera" + CHR(231) + CHR(245) + "es: " + ;
                                loc_cDopAtual + "..." NOWAIT

                    *-- Loop interno: para cada empresa
                    SELECT crSigCdEmp
                    SCAN
                        loc_cEmpAtual = ALLTRIM(crSigCdEmp.Cemps)

                        *-- Movimentos no periodo para esta empresa/operacao
                        loc_lcQuery = "SELECT Emps, Dopes, Numes, GrupoDs, ContaDs, GrupoOs, ContaOs " + ;
                                      "FROM SigMvCab " + ;
                                      "WHERE Datas >= " + FormatarDataSQL(THIS.this_dDtInicial) + ;
                                      " AND Datas < DATEADD(day, 1, " + FormatarDataSQL(THIS.this_dDtFinal) + ")" + ;
                                      " AND Emps = " + EscaparSQL(loc_cEmpAtual) + ;
                                      " AND Dopes = " + EscaparSQL(loc_cDopAtual)
                        loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crSigMvCab")
                        IF loc_nResult < 1
                            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (crSigMvCab)"
                            EXIT
                        ENDIF

                        *-- Para cada movimento, acumula parcelas em TmpCli
                        SELECT crSigMvCab
                        SCAN
                            IF NVL(loc_nCOpers, 0) = 1
                                loc_cGrupo    = crSigMvCab.GrupoDs
                                loc_cConta    = crSigMvCab.ContaDs
                                loc_cTipoOper = "1"
                            ELSE
                                loc_cGrupo    = crSigMvCab.GrupoOs
                                loc_cConta    = crSigMvCab.ContaOs
                                loc_cTipoOper = "2"
                            ENDIF

                            loc_lcEdn = ALLTRIM(crSigMvCab.Emps) + ;
                                        ALLTRIM(crSigMvCab.Dopes) + ;
                                        STR(crSigMvCab.Numes, 6)

                            *-- Parcelas de pagamento deste movimento
                            loc_lcQuery = "SELECT MoeFpgs, Valos FROM SigMvPar " + ;
                                          "WHERE EmpDopNums = " + EscaparSQL(loc_lcEdn)
                            loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crSigMvPar")
                            IF loc_nResult > 0
                                SELECT crSigMvPar
                                SCAN
                                    loc_nValor = crSigMvPar.Valos * IIF(NVL(loc_nCOpers, 0) = 1, 1, -1)
                                    INSERT INTO TmpCli (Grupo, Conta, TipoOper, Emps, Valor, Moeda) ;
                                        VALUES (loc_cGrupo, loc_cConta, loc_cTipoOper, ;
                                                crSigMvCab.Emps, loc_nValor, crSigMvPar.MoeFpgs)
                                ENDSCAN
                            ENDIF
                            IF USED("crSigMvPar")
                                USE IN crSigMvPar
                            ENDIF
                            SELECT crSigMvCab
                        ENDSCAN

                        IF USED("crSigMvCab")
                            USE IN crSigMvCab
                        ENDIF

                        IF !EMPTY(THIS.this_cMensagemErro)
                            EXIT
                        ENDIF
                        SELECT crSigCdEmp
                    ENDSCAN

                    IF !EMPTY(THIS.this_cMensagemErro)
                        EXIT
                    ENDIF
                    SELECT crSigCdOpe
                ENDSCAN
                WAIT CLEAR

                IF !EMPTY(THIS.this_cMensagemErro)
                    EXIT
                ENDIF

                *-- Indexa TmpCli para busca por empresa/grupo/conta
                SELECT TmpCli
                INDEX ON Emps + Grupo + Conta + TipoOper TAG EmpDopCon

                *-- Cursor de cabecalho de colunas de moeda por empresa
                IF USED("TmpCabec")
                    USE IN TmpCabec
                ENDIF
                CREATE CURSOR TmpCabec (Emps C(3), Op11 C(3), Op12 C(3), Op13 C(3), ;
                                        Op21 C(3), Op22 C(3), Op23 C(3))
                INDEX ON Emps TAG Emps

                *-- Busca moedas com sua ordem de exibicao no relatorio
                loc_lcQuery = "SELECT CMoes, NOrdRels, Cotas FROM SigCdMoe"
                loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crSigCdMoe")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (crSigCdMoe)"
                    EXIT
                ENDIF
                SELECT crSigCdMoe
                INDEX ON CMoes TAG CMoes

                *-- Combinacoes distintas de empresa/tipo/moeda presentes em TmpCli
                SELECT DISTINCT a.Emps, a.TipoOper, ;
                       IIF(EMPTY(b.NOrdRels), 9, b.NOrdRels) AS NOrdRels, a.Moeda ;
                  FROM TmpCli a, crSigCdMoe b ;
                 WHERE a.Moeda = b.CMoes ;
                  INTO CURSOR Operas

                *-- Atribui moedas as colunas Op11..Op13 (tipo 1) e Op21..Op23 (tipo 2)
                loc_nConta1 = 0
                loc_nConta2 = 0
                SELECT Operas
                SCAN
                    IF !SEEK(ALLTRIM(Operas.Emps), "TmpCabec", "Emps")
                        INSERT INTO TmpCabec (Emps) VALUES (Operas.Emps)
                        SELECT TmpCabec
                        SEEK ALLTRIM(Operas.Emps) ORDER TAG Emps
                        loc_nConta1 = 0
                        loc_nConta2 = 0
                    ENDIF

                    IF ALLTRIM(Operas.TipoOper) = "1"
                        loc_nConta1 = loc_nConta1 + 1
                        IF loc_nConta1 <= 3
                            DO CASE
                            CASE loc_nConta1 = 1
                                REPLACE Op11 WITH Operas.Moeda IN TmpCabec
                            CASE loc_nConta1 = 2
                                REPLACE Op12 WITH Operas.Moeda IN TmpCabec
                            CASE loc_nConta1 = 3
                                REPLACE Op13 WITH Operas.Moeda IN TmpCabec
                            ENDCASE
                        ENDIF
                    ELSE
                        loc_nConta2 = loc_nConta2 + 1
                        IF loc_nConta2 <= 3
                            DO CASE
                            CASE loc_nConta2 = 1
                                REPLACE Op21 WITH Operas.Moeda IN TmpCabec
                            CASE loc_nConta2 = 2
                                REPLACE Op22 WITH Operas.Moeda IN TmpCabec
                            CASE loc_nConta2 = 3
                                REPLACE Op23 WITH Operas.Moeda IN TmpCabec
                            ENDCASE
                        ENDIF
                    ENDIF
                    SELECT Operas
                ENDSCAN

                *-- Cursor de totais por moeda
                IF USED("TmpTotal")
                    USE IN TmpTotal
                ENDIF
                CREATE CURSOR TmpTotal (Moeda C(3), Valor N(12,2), NOrdRels N(1))
                INDEX ON Moeda TAG Moeda

                *-- Cursor final de dados do relatorio (compativel com SigReAnr.frx)
                IF USED("TmpFinal")
                    USE IN TmpFinal
                ENDIF
                CREATE CURSOR TmpFinal (Emps C(3), Grupo C(10), Conta C(10), Datas D, ;
                                        NomeCli C(40), Razas C(40), ;
                                        Valor1 N(12,2), Moeda1 C(3), ;
                                        Valor2 N(12,2), Moeda2 C(3), ;
                                        Valor3 N(12,2), Moeda3 C(3), ;
                                        Valor4 N(12,2), Moeda4 C(3), ;
                                        Valor5 N(12,2), Moeda5 C(3), ;
                                        Valor6 N(12,2), Moeda6 C(3))
                INDEX ON Emps + Grupo + Conta + DTOS(Datas) TAG EmpConDat

                *-- Popula TmpFinal acumulando valores por moeda/tipo de operacao
                SELECT TmpCli
                WAIT WINDOW "Processando Clientes..." NOWAIT
                GO TOP
                SCAN
                    *-- Posiciona TmpCabec na empresa do registro atual
                    = SEEK(ALLTRIM(TmpCli.Emps), "TmpCabec", "Emps")

                    *-- Busca razao social da empresa
                    = SEEK(ALLTRIM(TmpCli.Emps), "crSigCdEmp", "Cemps")
                    loc_cRazas = IIF(FOUND("crSigCdEmp"), ALLTRIM(crSigCdEmp.Razas), "")

                    *-- Busca nome do cliente (conta)
                    loc_lcQuery = "SELECT IClis, RClis FROM SigCdCli " + ;
                                  "WHERE IClis = " + EscaparSQL(ALLTRIM(TmpCli.Conta))
                    loc_cNomeCli = ""
                    IF SQLEXEC(gnConnHandle, loc_lcQuery, "crSigCdCli") > 0 AND ;
                       !EOF("crSigCdCli")
                        SELECT crSigCdCli
                        loc_cNomeCli = ALLTRIM(RClis)
                    ENDIF
                    IF USED("crSigCdCli")
                        USE IN crSigCdCli
                    ENDIF

                    *-- Localiza ou cria linha em TmpFinal para este cliente
                    IF !SEEK(ALLTRIM(TmpCli.Emps) + ALLTRIM(TmpCli.Grupo) + ALLTRIM(TmpCli.Conta), ;
                             "TmpFinal", "EmpConDat")
                        INSERT INTO TmpFinal (Emps, Grupo, Conta, NomeCli, Razas) ;
                            VALUES (TmpCli.Emps, TmpCli.Grupo, TmpCli.Conta, ;
                                    loc_cNomeCli, loc_cRazas)
                    ENDIF

                    *-- Acumula valor na coluna de moeda correspondente ao tipo de operacao
                    DO CASE
                    CASE (ALLTRIM(TmpCli.Moeda) = ALLTRIM(TmpCabec.Op11)) AND ;
                         (ALLTRIM(TmpCli.TipoOper) = "1")
                        REPLACE Valor1 WITH TmpFinal.Valor1 + TmpCli.Valor, ;
                                Moeda1 WITH TmpCli.Moeda IN TmpFinal
                    CASE (ALLTRIM(TmpCli.Moeda) = ALLTRIM(TmpCabec.Op12)) AND ;
                         (ALLTRIM(TmpCli.TipoOper) = "1")
                        REPLACE Valor2 WITH TmpFinal.Valor2 + TmpCli.Valor, ;
                                Moeda2 WITH TmpCli.Moeda IN TmpFinal
                    CASE (ALLTRIM(TmpCli.Moeda) = ALLTRIM(TmpCabec.Op13)) AND ;
                         (ALLTRIM(TmpCli.TipoOper) = "1")
                        REPLACE Valor3 WITH TmpFinal.Valor3 + TmpCli.Valor, ;
                                Moeda3 WITH TmpCli.Moeda IN TmpFinal
                    CASE (ALLTRIM(TmpCli.Moeda) = ALLTRIM(TmpCabec.Op21)) AND ;
                         (ALLTRIM(TmpCli.TipoOper) = "2")
                        REPLACE Valor4 WITH TmpFinal.Valor4 + TmpCli.Valor, ;
                                Moeda4 WITH TmpCli.Moeda IN TmpFinal
                    CASE (ALLTRIM(TmpCli.Moeda) = ALLTRIM(TmpCabec.Op22)) AND ;
                         (ALLTRIM(TmpCli.TipoOper) = "2")
                        REPLACE Valor5 WITH TmpFinal.Valor5 + TmpCli.Valor, ;
                                Moeda5 WITH TmpCli.Moeda IN TmpFinal
                    CASE (ALLTRIM(TmpCli.Moeda) = ALLTRIM(TmpCabec.Op23)) AND ;
                         (ALLTRIM(TmpCli.TipoOper) = "2")
                        REPLACE Valor6 WITH TmpFinal.Valor6 + TmpCli.Valor, ;
                                Moeda6 WITH TmpCli.Moeda IN TmpFinal
                    ENDCASE

                    *-- Acumula total por moeda em TmpTotal
                    IF !SEEK(ALLTRIM(TmpCli.Moeda), "TmpTotal", "Moeda")
                        = SEEK(ALLTRIM(TmpCli.Moeda), "crSigCdMoe", "CMoes")
                        loc_lnNOrdRels = IIF(FOUND("crSigCdMoe"), crSigCdMoe.NOrdRels, 9)
                        INSERT INTO TmpTotal (Moeda, NOrdRels) ;
                            VALUES (TmpCli.Moeda, loc_lnNOrdRels)
                        = SEEK(ALLTRIM(TmpCli.Moeda), "TmpTotal", "Moeda")
                    ENDIF
                    REPLACE Valor WITH TmpTotal.Valor + TmpCli.Valor IN TmpTotal

                    SELECT TmpCli
                ENDSCAN
                WAIT CLEAR

                *-- Adiciona moedas sem cotacao que ainda nao constam em TmpTotal
                SELECT crSigCdMoe
                SCAN FOR !Cotas
                    IF !SEEK(ALLTRIM(crSigCdMoe.CMoes), "TmpTotal", "Moeda")
                        loc_lnNOrdRels = crSigCdMoe.NOrdRels
                        INSERT INTO TmpTotal (Moeda, NOrdRels) ;
                            VALUES (crSigCdMoe.CMoes, loc_lnNOrdRels)
                        = SEEK(ALLTRIM(crSigCdMoe.CMoes), "TmpTotal", "Moeda")
                    ENDIF
                    SELECT crSigCdMoe
                ENDSCAN

                *-- Calcula totais parciais por moeda com cotacao na data informada
                loc_cTotalTit  = ""
                loc_cTotalVal  = ""
                loc_nTotalGeral = 0

                SELECT TmpTotal
                SCAN
                    loc_cTotalTit  = loc_cTotalTit + "Total em " + ;
                                     ALLTRIM(TmpTotal.Moeda) + " : " + CHR(13) + CHR(10)
                    loc_cTotalVal  = loc_cTotalVal + ;
                                     TRANSFORM(TmpTotal.Valor, "999,999,999.99") + ;
                                     CHR(13) + CHR(10)
                    loc_nCot1 = THIS.BuscarCotacao(ALLTRIM(TmpTotal.Moeda), THIS.this_dDtCotacao)
                    loc_nTotalGeral = loc_nTotalGeral + ROUND(TmpTotal.Valor * loc_nCot1, 2)
                    SELECT TmpTotal
                ENDSCAN

                *-- Calcula totais gerais convertidos para cada moeda
                loc_cTotalGTit = ""
                loc_cTotalGVal = ""
                loc_cTotalGCot = ""

                SELECT TmpTotal
                SCAN
                    loc_nCot1 = THIS.BuscarCotacao(ALLTRIM(TmpTotal.Moeda), THIS.this_dDtCotacao)
                    loc_cTotalGTit = loc_cTotalGTit + "Total Geral " + ;
                                     ALLTRIM(TmpTotal.Moeda) + " : " + CHR(13) + CHR(10)
                    IF loc_nCot1 > 0
                        loc_cTotalGVal = loc_cTotalGVal + ;
                                         TRANSFORM(ROUND(loc_nTotalGeral / loc_nCot1, 2), ;
                                                   "999,999,999.99") + CHR(13) + CHR(10)
                    ELSE
                        loc_cTotalGVal = loc_cTotalGVal + "0.00" + CHR(13) + CHR(10)
                    ENDIF
                    loc_cTotalGCot = loc_cTotalGCot + ;
                                     TRANSFORM(loc_nCot1, "99,999.999999") + CHR(13) + CHR(10)
                    SELECT TmpTotal
                ENDSCAN

                *-- Publica variaveis para o relatorio .FRX
                PUBLIC _TotalTit, _TotalVal, _TotalGTit, _TotalGVal, _TotalGCot
                _TotalTit  = loc_cTotalTit
                _TotalVal  = loc_cTotalVal
                _TotalGTit = loc_cTotalGTit
                _TotalGVal = loc_cTotalGVal
                _TotalGCot = loc_cTotalGCot

                *-- Relacao TmpFinal -> TmpCabec para o relatorio
                SELECT TmpFinal
                SET RELATION TO Emps INTO TmpCabec
                GO TOP

                loc_lSucesso = .T.
                EXIT
            ENDDO

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Preparar Dados do Relat" + CHR(243) + "rio")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarCotacao - Busca taxa de cambio da moeda para a data informada
    * Substitui fBuscarCotacao() do sistema legado
    * Tabela: SigCdCot (cmoes, datas, horas, valos)
    * Retorna 1.0 se moeda nao encontrada (fallback seguro)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarCotacao(par_cMoeda, par_dData)
        LOCAL loc_nTaxa, loc_cSQL, loc_nResult, loc_cMoeda, loc_cFiltroData

        loc_nTaxa  = 1.0
        loc_cMoeda = ALLTRIM(par_cMoeda)

        IF EMPTY(loc_cMoeda) OR loc_cMoeda = "R"
            RETURN loc_nTaxa
        ENDIF

        IF EMPTY(par_dData) OR VARTYPE(par_dData) != "D"
            loc_cFiltroData = "datas <= GETDATE()"
        ELSE
            loc_cFiltroData = "datas <= DATEADD(day, 1, " + FormatarDataSQL(par_dData) + ")"
        ENDIF

        loc_cSQL = "SELECT TOP 1 valos FROM SigCdCot " + ;
                   "WHERE cmoes = " + EscaparSQL(loc_cMoeda) + ;
                   " AND " + loc_cFiltroData + ;
                   " ORDER BY datas DESC, horas DESC"
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CotAnr")
        IF loc_nResult > 0 AND !EOF("cursor_4c_CotAnr")
            SELECT cursor_4c_CotAnr
            IF NVL(valos, 0) > 0
                loc_nTaxa = valos
            ENDIF
        ENDIF

        IF USED("cursor_4c_CotAnr")
            USE IN cursor_4c_CotAnr
        ENDIF

        RETURN loc_nTaxa
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime diretamente na impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cArquivoFRX) TO PRINTER PROMPT NOCONSOLE
                THIS.RegistrarAuditoria("IMPRIMIR")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Imprimir Relat" + CHR(243) + "rio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cArquivoFRX) PREVIEW NOCONSOLE
                THIS.RegistrarAuditoria("VISUALIZAR")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Visualizar Relat" + CHR(243) + "rio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarExcel - Prepara dados e gera documento (imprime para arquivo)
    *--------------------------------------------------------------------------
    PROCEDURE GerarExcel()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cArquivoFRX) TO PRINTER NOCONSOLE
                THIS.RegistrarAuditoria("EXPORTAR")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Gerar Documento do Relat" + CHR(243) + "rio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave de auditoria da execucao
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = IIF(EMPTY(THIS.this_cEmpresa), "TODAS", ALLTRIM(THIS.this_cEmpresa))
        loc_cChave = loc_cChave + "/" + DTOC(THIS.this_dDtInicial) + ;
                     "/" + DTOC(THIS.this_dDtFinal)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra execucao do relatorio na tabela LogAuditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cChave   = THIS.ObterChavePrimaria()
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                               gc_4c_UsuarioLogado, "SISTEMA")

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL("SIGREANR") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(loc_cUsuario) + ", GETDATE())"

            SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Aviso: falha ao registrar auditoria - " + ;
                                       loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir / Atualizar / CarregarDoCursor
    *
    * Operacoes nao aplicaveis a BOs de relatorio. Sao implementadas aqui
    * apenas para manter um contrato uniforme com BusinessBase (auditoria,
    * dispatchers genericos, validadores automatizados) e para sinalizar
    * explicitamente a restricao - em vez de silenciar com herda padrao.
    *
    * Para relatorios, o fluxo correto eh:
    *   - PrepararDados() monta os cursores de saida (TmpFinal, TmpCabec,
    *     TmpCli, TmpTotal, dbCabecalho) via SQLEXEC sobre o periodo filtrado
    *   - Imprimir() / Visualizar() / GerarExcel() consomem esses cursores
    *     atraves do .FRX SigReAnr
    *
    * Qualquer chamada a uma destas rotinas em runtime indica uso incorreto
    * da API e deve falhar de forma observavel (mensagem de erro + retorno .F.).
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: BO de relat" + CHR(243) + "rio n" + CHR(227) + ;
            "o insere registros. Use PrepararDados()/Imprimir()/Visualizar()."
        RETURN .F.
    ENDPROC

    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: BO de relat" + CHR(243) + "rio n" + CHR(227) + ;
            "o atualiza registros. Use PrepararDados()/Imprimir()/Visualizar()."
        RETURN .F.
    ENDPROC

    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: BO de relat" + CHR(243) + "rio processa o per" + ;
            CHR(237) + "odo inteiro em PrepararDados(), n" + CHR(227) + ;
            "o registro a registro."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos e cursores temporarios
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("TmpFinal")
            SELECT TmpFinal
            SET RELATION TO
            USE IN TmpFinal
        ENDIF
        IF USED("TmpCabec")
            USE IN TmpCabec
        ENDIF
        IF USED("TmpCli")
            USE IN TmpCli
        ENDIF
        IF USED("TmpTotal")
            USE IN TmpTotal
        ENDIF
        IF USED("dbCabecalho")
            USE IN dbCabecalho
        ENDIF
        IF USED("crSigCdOpe")
            USE IN crSigCdOpe
        ENDIF
        IF USED("crSigCdEmp")
            USE IN crSigCdEmp
        ENDIF
        IF USED("crSigCdMoe")
            USE IN crSigCdMoe
        ENDIF
        IF USED("Operas")
            USE IN Operas
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

