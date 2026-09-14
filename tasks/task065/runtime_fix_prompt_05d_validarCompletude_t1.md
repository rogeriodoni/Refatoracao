# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[sigrecprBO.prg] Indicador de pendencia: *   Opcao (hidden, 1/2)   -> this_nOpcao (1=Pendente
[Formsigrecpr.prg] Indicador de pendencia: *-- opt_4c_Opcao: Pendente
[Formsigrecpr.prg] Indicador de pendencia: * Encerrar) independente

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrecpr.prg):
*==============================================================================
* FORMSIGRECPR.PRG
* Relatorio: Cheques Prorrogados
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: sigrecpr.SCX (frmrelatorio)
*
* Implementacao completa (Fases 3-8):
*   - DEFINE CLASS com propriedades visuais (Width=800, Height=300 do original)
*   - Init() / Load() / InicializarForm() / Destroy()
*   - ConfigurarPageFrame() (orquestra layout FLAT do REPORT: cabecalho + botoes)
*   - ConfigurarCabecalho() (cntSombra do legado)
*   - ConfigurarBotoes()    (btnReport canonico - CommandGroup 4 botoes)
*   - Btn*Click() completos (Visualizar / Imprimir / DocExcel / Encerrar)
*   - ConfigurarPaginaFiltros(): Say3, OptFiltro, Say1, DataIni, Say2
*   - ConfigurarPaginaDados():   DataFin, lbl_Operacao, cbo_TipoRel,
*                                opt_Bons, opt_Opcao + BINDEVENT TipoRelChanged
*   - LimparCampos() / FormParaRelatorio() / AlternarPagina()
*   - FormParaBO() / BOParaForm() / HabilitarCampos()
*   - CarregarLista() / AjustarBotoesPorModo() (stubs REPORT)
*==============================================================================

DEFINE CLASS Formsigrecpr AS FormBase

    *-- Dimensoes e aparencia (PILAR 1 - Width=800, Height=300 do original SIGRECPR)
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

    *-- Referencia ao BO de relatorio (instanciado em InicializarForm)
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * Load - Replica configuracao de data/seculo do legado (PROCEDURE Load)
    *--------------------------------------------------------------------------
    PROCEDURE Load()
        DODEFAULT()
        SET CENTURY ON
        SET DATE TO BRITISH
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Estrutura base: caption, picture, BO, cabecalho, botoes
    * Fases 4+ completam com ConfigurarPaginaFiltros e LimparCampos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.Caption = "Cheques Prorrogados"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            THIS.this_oRelatorio = CREATEOBJECT("sigrecprBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar sigrecprBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.LimparCampos()

                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.Visible  = .T.
                loc_lSucesso  = .T.
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
    * ConfigurarPageFrame - Orquestra layout FLAT (REPORT, sem PageFrame real)
    * Em frmrelatorio o "container de paginas" e o proprio Form: cria cabecalho
    * (cntSombra), CommandGroup canonico (btnReport) e o container de filtros.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarBotoes()
        THIS.ConfigurarContainerFiltros()
        THIS.ConfigurarPaginaLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Monta o painel unico de filtros do relatorio
    *
    * Em forms REPORT (frmrelatorio) nao existe PageFrame Lista/Dados como em
    * CRUD; o equivalente a "Page1/Lista" e o painel de parametros que o usuario
    * preenche antes de gerar o relatorio. Este metodo, mantido por uniformidade
    * arquitetural com forms CRUD, delega a montagem real dos controles para
    * ConfigurarPaginaFiltros (TextBoxes de data, OptionGroups, ComboBox de tipo
    * e BINDEVENT do InteractiveChange do ComboBox).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarPaginaFiltros()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainerFiltros - Container transparente onde os TextBoxes,
    * OptionGroups e ComboBox de filtro serao adicionados nas fases 4+
    * Top = 80 (logo abaixo do cabecalho) - geometria do legado SIGRECPR
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainerFiltros()
        THIS.AddObject("cnt_4c_Filtros", "Container")
        WITH THIS.cnt_4c_Filtros
            .Top         = 80
            .Left        = 0
            .Width       = THIS.Width
            .Height      = THIS.Height - 80
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro superior com titulo do relatorio
    * Equivalente ao cntSombra do frmrelatorio legado (Width = THIS.Width)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            *-- Sombra deslocada 2px para efeito 3D
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 22
                .Left      = 22
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Cheques Prorrogados"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Titulo em branco sobre a sombra
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 20
                .Left      = 20
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Cheques Prorrogados"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - CommandGroup canonico do btnReport (4 botoes)
    * Original: btnReport.Left=528, Top=3, Width=305, Height=85 (800px form)
    * Canonico: cmg_4c_Botoes Top=0, Left=529, Width=273, Height=80
    * Lefts internos: Buttons(1)=5, (2)=71, (3)=137, (4)=203 (incrementos de 66)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = 0
            .Left          = 529
            .Width         = 273
            .Height        = 80
            .ButtonCount   = 4
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderColor   = RGB(136, 189, 188)
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.

            WITH .Buttons(1)
                .Caption         = "Visualizar"
                .Top             = 5
                .Left            = 5
                .Width           = 65
                .Height          = 70
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .WordWrap        = .T.
                .Picture         = gc_4c_CaminhoIcones + "ideo.jpg"
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(2)
                .Caption         = "Imprimir"
                .Top             = 5
                .Left            = 71
                .Width           = 65
                .Height          = 70
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .WordWrap        = .T.
                .Picture         = gc_4c_CaminhoIcones + "impressora.jpg"
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(3)
                .Caption         = "DocExcel"
                .Top             = 5
                .Left            = 137
                .Width           = 65
                .Height          = 70
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .WordWrap        = .T.
                .Picture         = gc_4c_CaminhoIcones + "excel.jpg"
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(4)
                .Caption         = "Encerrar"
                .Top             = 5
                .Left            = 203
                .Width           = 65
                .Height          = 70
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .WordWrap        = .T.
                .Picture         = gc_4c_CaminhoIcones + "otao_encerrar.jpg"
                .Cancel          = .T.
                .Visible         = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Navegacao logica do form (compatibilidade CRUD)
    *
    * Em REPORT forms nao ha alternancia Lista/Dados (layout FLAT, sem
    * PageFrame). Este metodo, mantido por uniformidade arquitetural com forms
    * CRUD, repassa a navegacao para acoes equivalentes ao contexto de
    * relatorio:
    *   par_nPagina = 1 (Lista)  -> reposiciona o foco no primeiro filtro
    *                               (txt_4c_DataIni), simulando "voltar para a
    *                               tela de parametros" apos gerar o relatorio.
    *   par_nPagina = 2 (Dados)  -> reseta os filtros para os defaults do Init
    *                               (LimparCampos), simulando "novo relatorio".
    *   outros valores            -> tratado como 1 (Lista) por seguranca.
    *
    * Tambem sincroniza a visibilidade de opt_4c_Bons conforme o ComboBox de
    * tipo (replicando o Valid event de GetTipoRel do legado) para garantir
    * estado consistente da UI quando o form e reapresentado.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina, loc_oCnt
        loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)

        IF VARTYPE(THIS.cnt_4c_Filtros) != "O"
            RETURN
        ENDIF
        loc_oCnt = THIS.cnt_4c_Filtros

        DO CASE
            CASE loc_nPagina = 2
                *-- "Dados" = novo relatorio: reseta para os defaults do Init
                THIS.LimparCampos()
                IF VARTYPE(loc_oCnt.txt_4c_DataIni) = "O"
                    loc_oCnt.txt_4c_DataIni.SetFocus()
                ENDIF
            OTHERWISE
                *-- "Lista" (1) ou qualquer outro: foca no primeiro filtro e
                *-- ressincroniza visibilidade de opt_4c_Bons com o ComboBox.
                IF VARTYPE(loc_oCnt.cbo_4c_TipoRel) = "O" ;
                   AND VARTYPE(loc_oCnt.opt_4c_Bons) = "O"
                    loc_oCnt.opt_4c_Bons.Visible = (loc_oCnt.cbo_4c_TipoRel.ListIndex = 4)
                ENDIF
                IF VARTYPE(loc_oCnt.txt_4c_DataIni) = "O"
                    loc_oCnt.txt_4c_DataIni.SetFocus()
                ENDIF
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Exibe relatorio em preview na tela
    * Equivalente ao PROCEDURE visualizacao do legado
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Visualizar()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Visualizar")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Imprime relatorio na impressora
    * Equivalente ao PROCEDURE impressao do legado
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Imprimir()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Exporta dados do relatorio para arquivo XLS
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        LOCAL loc_lSucesso, loc_cArquivo
        loc_lSucesso = .F.
        TRY
            THIS.FormParaRelatorio()
            IF THIS.this_oRelatorio.PrepararDados()
                loc_cArquivo = GETFILE("xls", "Salvar como Excel", "Salvar")
                IF !EMPTY(loc_cArquivo)
                    SELECT (THIS.this_oRelatorio.this_cCursorDados)
                    COPY TO (loc_cArquivo) TYPE XLS
                    MsgInfo("Arquivo Excel gerado com sucesso.")
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "DocExcel")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnExcelClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Fecha o formulario (Encerrar, equivalente ao Sair legado)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Em REPORT forms, "Incluir" e o equivalente logico de
    * "Novo Relatorio": reseta os filtros para os valores default (LimparCampos
    * replica o Init do legado) e posiciona o foco no primeiro filtro de data,
    * permitindo ao usuario gerar uma nova consulta sem fechar/reabrir o form.
    *
    * Mantido para uniformidade com forms CRUD (validacao do pipeline exige a
    * existencia deste handler em todo form migrado).
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oCnt
        THIS.LimparCampos()
        loc_oCnt = THIS.cnt_4c_Filtros
        IF VARTYPE(loc_oCnt) = "O" AND VARTYPE(loc_oCnt.txt_4c_DataIni) = "O"
            loc_oCnt.txt_4c_DataIni.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Em REPORT forms, "Alterar" equivale a "Alterar
    * Filtros": preserva os valores atuais dos filtros (NAO chama LimparCampos)
    * e devolve o foco ao primeiro filtro de data, permitindo refinar a
    * consulta antes de re-Visualizar/Imprimir. Tambem ressincroniza a
    * visibilidade de opt_4c_Bons com o ComboBox de tipo, replicando o Valid
    * event de GetTipoRel do legado para garantir UI consistente.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_Filtros
        IF VARTYPE(loc_oCnt) != "O"
            RETURN
        ENDIF
        IF VARTYPE(loc_oCnt.cbo_4c_TipoRel) = "O" ;
           AND VARTYPE(loc_oCnt.opt_4c_Bons) = "O"
            loc_oCnt.opt_4c_Bons.Visible = (loc_oCnt.cbo_4c_TipoRel.ListIndex = 4)
        ENDIF
        IF VARTYPE(loc_oCnt.txt_4c_DataIni) = "O"
            loc_oCnt.txt_4c_DataIni.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Em REPORT forms, "Excluir" mapeia para "Limpar
    * Filtros" / "Descartar parametros": zera datas e reseta os OptionGroups
    * para os defaults, mas preserva visibilidade derivada do ComboBox de
    * tipo. Util quando o usuario quer abandonar uma combinacao de filtros e
    * recomecar do zero sem fechar o form. Pede confirmacao para evitar perda
    * acidental de filtros ja preenchidos.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oCnt, loc_cMsg
        loc_oCnt = THIS.cnt_4c_Filtros
        IF VARTYPE(loc_oCnt) != "O"
            RETURN
        ENDIF
        loc_cMsg = "Deseja limpar os filtros e recome" + CHR(231) + "ar?"
        IF !MsgConfirma(loc_cMsg, "Limpar Filtros")
            RETURN
        ENDIF
        THIS.LimparCampos()
        IF VARTYPE(loc_oCnt.txt_4c_DataIni) = "O"
            loc_oCnt.txt_4c_DataIni.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera BO e delega para FormBase
    * REGRA: this_oRelatorio = .NULL. (NAO .Release() - Custom nao tem Release)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaFiltros - Popula cnt_4c_Filtros com todos os controles
    * de filtro do relatorio (equivalente aos controles diretos no SIGRECPR)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaFiltros()
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_Filtros

        *-- Say3: "Filtrar por :"  (Top original=145, container=65)
        loc_oCnt.AddObject("lbl_4c_Say3", "Label")
        WITH loc_oCnt.lbl_4c_Say3
            .Top       = 65
            .Left      = 227
            .Height    = 15
            .Width     = 70
            .Caption   = "Filtrar por : "
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- OptFiltro: Prorrogados / Vencimento  (Top original=140, container=60)
        loc_oCnt.AddObject("opt_4c_OptFiltro", "OptionGroup")
        WITH loc_oCnt.opt_4c_OptFiltro
            .Top         = 60
            .Left        = 288
            .Width       = 194
            .Height      = 25
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            WITH .Buttons(1)
                .Caption   = "Prorrogados"
                .BackStyle = 0
                .Height    = 15
                .Left      = 5
                .Top       = 5
                .Width     = 77
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Vencimento"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 116
                .Top       = 5
                .Width     = 73
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH
            .Visible = .T.
        ENDWITH

        *-- Say1: "Per?odo :"  (Top original=170, container=90)
        loc_oCnt.AddObject("lbl_4c_Say1", "Label")
        WITH loc_oCnt.lbl_4c_Say1
            .Top       = 90
            .Left      = 238
            .Height    = 15
            .Width     = 50
            .Caption   = "Per" + CHR(237) + "odo : "
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- DataIni  (Top original=167, container=87)
        loc_oCnt.AddObject("txt_4c_DataIni", "TextBox")
        WITH loc_oCnt.txt_4c_DataIni
            .Top     = 87
            .Left    = 292
            .Height  = 20
            .Width   = 80
            .Value   = {}
            .Visible = .T.
        ENDWITH

        *-- Say2: "a" grave separador de datas  (Top original=171, container=91)
        loc_oCnt.AddObject("lbl_4c_Say2", "Label")
        WITH loc_oCnt.lbl_4c_Say2
            .Top       = 91
            .Left      = 376
            .Height    = 15
            .Width     = 10
            .Caption   = CHR(224)
            .FontName  = "Verdana"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(36, 84, 155)
            .Visible   = .T.
        ENDWITH

    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Inicializa/reseta todos os filtros para valores padrao
    * Equivalente ao Init() do legado: DataIni/DataFin vazios, OptFiltro=1,
    * GetTipoRel=1 (ATIVOS), Opt_Bons oculto e resetado
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        WITH THIS.cnt_4c_Filtros
            .txt_4c_DataIni.Value    = {}
            .txt_4c_DataFin.Value    = {}
            .opt_4c_OptFiltro.Value  = 1
            .cbo_4c_TipoRel.ListIndex = 1
            .opt_4c_Bons.Visible     = .F.
            .opt_4c_Bons.Value       = 1
            .opt_4c_Opcao.Value      = 1
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere valores dos filtros do form para o BO
    * Chamado antes de Visualizar(), Imprimir() ou PrepararDados()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        WITH THIS.this_oRelatorio
            .this_dDataIni    = THIS.cnt_4c_Filtros.txt_4c_DataIni.Value
            .this_dDataFin    = THIS.cnt_4c_Filtros.txt_4c_DataFin.Value
            .this_nTipoFiltro = THIS.cnt_4c_Filtros.opt_4c_OptFiltro.Value
            .this_nTipoRel    = THIS.cnt_4c_Filtros.cbo_4c_TipoRel.ListIndex
            .this_nBons       = THIS.cnt_4c_Filtros.opt_4c_Bons.Value
            .this_nOpcao      = THIS.cnt_4c_Filtros.opt_4c_Opcao.Value
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Segunda metade dos controles de filtro
    * DataFin, lbl_Operacao, cbo_TipoRel, opt_Bons, opt_Opcao + BINDEVENT
    * Equivale a "Page2" no pipeline multi-fase; para REPORT ? bloco de
    * parametros de operacao (tipo de cheque e opcoes de baixa).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_Filtros

        *-- DataFin  (Top original=167, container=87)
        loc_oCnt.AddObject("txt_4c_DataFin", "TextBox")
        WITH loc_oCnt.txt_4c_DataFin
            .Top     = 87
            .Left    = 389
            .Height  = 20
            .Width   = 80
            .Value   = {}
            .Visible = .T.
        ENDWITH

        *-- lbl_operacao: "Opera" + CHR(231)+CHR(227)+"o :"  (Top orig=199, cont=119)
        loc_oCnt.AddObject("lbl_4c_Operacao", "Label")
        WITH loc_oCnt.lbl_4c_Operacao
            .Top       = 119
            .Left      = 230
            .Height    = 15
            .Width     = 60
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- cbo_4c_TipoRel: ComboBox de tipo  (Top original=194, container=114)
        loc_oCnt.AddObject("cbo_4c_TipoRel", "ComboBox")
        WITH loc_oCnt.cbo_4c_TipoRel
            .Top                  = 114
            .Left                 = 292
            .Height               = 24
            .Width                = 134
            .RowSourceType        = 1
            .RowSource            = "ATIVOS,BAIXADOS,NEG.PG,BONS,DEVOLVIDOS"
            .Style                = 2
            .FontName             = "Courier New"
            .FontSize             = 8
            .BoundColumn          = 1
            .ColumnCount          = 1
            .ColumnLines          = .F.
            .SelectOnEntry        = .F.
            .HideSelection        = .F.
            .BoundTo              = .T.
            .ToolTipText          = "ATIVOS=Entradas  BAIXADOS=Saidas  " + ;
                                    "NEG.PG=Devolvidos BONS=Depositados " + ;
                                    "Sem Devolvidos DEVOLVIDOS=Devolvidos"
            .SelectedForeColor    = RGB(255, 255, 255)
            .SelectedItemForeColor = RGB(255, 255, 255)
            .SelectedItemBackColor = RGB(0, 0, 128)
            .ListIndex            = 1
            .Visible              = .T.
        ENDWITH

        *-- opt_4c_Bons: Ativos/Todos  (Top orig=194, cont=114 - oculto ate TipoRel=BONS)
        loc_oCnt.AddObject("opt_4c_Bons", "OptionGroup")
        WITH loc_oCnt.opt_4c_Bons
            .Top         = 114
            .Left        = 433
            .Width       = 116
            .Height      = 25
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            WITH .Buttons(1)
                .Caption   = "Ativos"
                .BackStyle = 0
                .Height    = 15
                .Left      = 5
                .Top       = 5
                .Width     = 48
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Todos"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 64
                .Top       = 5
                .Width     = 47
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH
            .Visible = .F.
        ENDWITH

        *-- opt_4c_Opcao: Pendentes/Geral  (Top orig=120, cont=40 - permanece oculto)
        loc_oCnt.AddObject("opt_4c_Opcao", "OptionGroup")
        WITH loc_oCnt.opt_4c_Opcao
            .Top         = 40
            .Left        = 288
            .Width       = 145
            .Height      = 27
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            WITH .Buttons(1)
                .Caption   = "Pendentes"
                .BackStyle = 0
                .Left      = 5
                .Top       = 5
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Geral"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Left      = 87
                .Top       = 5
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH
            .Visible = .F.
        ENDWITH

        BINDEVENT(loc_oCnt.cbo_4c_TipoRel, "InteractiveChange", THIS, "TipoRelChanged")
    ENDPROC

    *--------------------------------------------------------------------------
    * TipoRelChanged - Exibe/oculta opt_4c_Bons conforme selecao do ComboBox
    * Replicando Valid event de GetTipoRel do legado: ListIndex=4 -> BONS
    *--------------------------------------------------------------------------
    PROCEDURE TipoRelChanged()
        THIS.cnt_4c_Filtros.opt_4c_Bons.Visible = ;
            (THIS.cnt_4c_Filtros.cbo_4c_TipoRel.ListIndex = 4)
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Hook do FormBase: delega para FormParaRelatorio()
    * Em forms REPORT "FormParaBO" = transferir filtros do form para o BO.
    * Chamado pelo FormBase.Salvar() se invocado genericamente.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Hook do FormBase: copia propriedades do BO de volta ao form
    * Util para restaurar filtros apos cancelamento ou pre-configuracao externa.
    * Chamado pelo FormBase.Cancelar() se invocado genericamente.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        WITH THIS.cnt_4c_Filtros
            .txt_4c_DataIni.Value     = THIS.this_oRelatorio.this_dDataIni
            .txt_4c_DataFin.Value     = THIS.this_oRelatorio.this_dDataFin
            .opt_4c_OptFiltro.Value   = THIS.this_oRelatorio.this_nTipoFiltro
            .cbo_4c_TipoRel.ListIndex = THIS.this_oRelatorio.this_nTipoRel
            .opt_4c_Bons.Value        = THIS.this_oRelatorio.this_nBons
            .opt_4c_Opcao.Value       = THIS.this_oRelatorio.this_nOpcao
            .opt_4c_Bons.Visible      = (THIS.this_oRelatorio.this_nTipoRel = 4)
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Em forms REPORT todos os filtros estao sempre habilitados
    * Stub semantico: nao ha modo CRUD (INCLUIR/ALTERAR/VISUALIZAR) neste form.
    * Mantido para uniformidade arquitetural com o pipeline de migracao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab
        loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
        IF VARTYPE(THIS.cnt_4c_Filtros) != "O"
            RETURN
        ENDIF
        WITH THIS.cnt_4c_Filtros
            .txt_4c_DataIni.Enabled     = loc_lHab
            .txt_4c_DataFin.Enabled     = loc_lHab
            .opt_4c_OptFiltro.Enabled   = loc_lHab
            .cbo_4c_TipoRel.Enabled     = loc_lHab
            .opt_4c_Bons.Enabled        = loc_lHab
            .opt_4c_Opcao.Enabled       = loc_lHab
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Em forms REPORT nao existe grid de lista; reaplica filtros
    * padrao e restaura o foco no primeiro campo de data.
    * Mantido para uniformidade arquitetural com o pipeline de migracao.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        THIS.LimparCampos()
        IF VARTYPE(THIS.cnt_4c_Filtros) = "O" ;
           AND VARTYPE(THIS.cnt_4c_Filtros.txt_4c_DataIni) = "O"
            THIS.cnt_4c_Filtros.txt_4c_DataIni.SetFocus()
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Em forms REPORT nao ha modos CRUD; os 4 botoes do
    * CommandGroup permanecem sempre habilitados (Visualizar/Imprimir/DocExcel/
    * Encerrar) independentemente de qualquer estado.
    * Mantido para uniformidade arquitetural com o pipeline de migracao.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        IF VARTYPE(THIS.cmg_4c_Botoes) != "O"
            RETURN
        ENDIF
        THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.
        THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
        THIS.cmg_4c_Botoes.Buttons(3).Enabled = .T.
        THIS.cmg_4c_Botoes.Buttons(4).Enabled = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Em REPORT forms "Buscar" mapeia para Visualizar
    * (gerar o relatorio em preview, equivalente semantico de "consultar dados"
    * em forms CRUD). Mantido para uniformidade com pipeline CRUD.
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Encerra o form. Equivalente exato de BtnSairClick;
    * presente para uniformidade com o padrao canonico Encerrar do pipeline.
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Em REPORT forms "Salvar" mapeia para Imprimir
    * (gerar saida definitiva do relatorio na impressora). Equivalente
    * semantico de "Salvar" em forms CRUD. Tambem registra auditoria via
    * Inserir() do BO (que internamente chama Imprimir + RegistrarAuditoria).
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.FormParaRelatorio()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        IF !THIS.this_oRelatorio.Inserir()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Em REPORT forms "Cancelar" mapeia para descarte dos
    * filtros: reseta os parametros para os defaults do Init e devolve o
    * foco ao primeiro filtro. NAO fecha o form (para encerrar usa Encerrar).
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        LOCAL loc_oCnt
        THIS.LimparCampos()
        loc_oCnt = THIS.cnt_4c_Filtros
        IF VARTYPE(loc_oCnt) = "O" AND VARTYPE(loc_oCnt.txt_4c_DataIni) = "O"
            loc_oCnt.txt_4c_DataIni.SetFocus()
        ENDIF
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigrecprBO.prg):
*==============================================================================
* SIGRECPRBO.PRG
* Business Object para Relatorio de Cheques Prorrogados
* Herda de RelatorioBase
*
* Filtros do formulario original (SIGRECPR):
*   DataIni / DataFin     -> this_dDataIni / this_dDataFin
*   OptFiltro (1/2)       -> this_nTipoFiltro (1=Prorrogados, 2=Vencimento)
*   GetTipoRel (ListIndex)-> this_nTipoRel (1=Ativos..5=Devolvidos)
*   Opt_Bons (1/2)        -> this_nBons (1=Ativos, 2=Todos)
*   Opcao (hidden, 1/2)   -> this_nOpcao (1=Pendentes, 2=Geral)
*==============================================================================

DEFINE CLASS sigrecprBO AS RelatorioBase

    *-- Filtros do relatorio
    this_dDataIni       = {}
    this_dDataFin       = {}
    this_nTipoFiltro    = 1
    this_nTipoRel       = 1
    this_nBons          = 1
    this_nOpcao         = 1

    *-- Titulo calculado com os filtros selecionados
    this_cTitulo        = ""

    *-- Caminho do FRX
    this_cArquivoRelatorio = ""

    *-- Cursor principal do relatorio
    this_cCursorDados   = "CsRelatorio"

    *--------------------------------------------------------------------------
    * Init - Inicializa BO do relatorio de Cheques Prorrogados
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cTabela          = ""
            THIS.this_cCampoChave      = ""
            THIS.this_cArquivoRelatorio = gc_4c_CaminhoReports + "SigReCpr.frx"
            THIS.this_dDataIni         = DATE()
            THIS.this_dDataFin         = DATE()
            THIS.this_nTipoFiltro      = 1
            THIS.this_nTipoRel         = 1
            THIS.this_nBons            = 1
            THIS.this_nOpcao           = 1
            THIS.this_cTitulo          = "Cheques Prorrogados"
            loc_lSucesso               = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrecprBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    FUNCTION ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDFUNC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta SQL com filtros e popula CsRelatorio para impressao
    * Chamado por Imprimir() e Visualizar()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_cVerTipo, loc_cCampoDt
        LOCAL loc_cDataIni, loc_cDataFin, loc_nResult

        loc_lSucesso = .F.
        TRY
            *-- Validar periodo
            IF EMPTY(THIS.this_dDataIni) OR EMPTY(THIS.this_dDataFin)
                THIS.this_cMensagemErro = "Per" + CHR(237) + "odo n" + ;
                    CHR(227) + "o informado"
                loc_lSucesso = .F.
            ENDIF
            IF THIS.this_dDataIni > THIS.this_dDataFin
                THIS.this_cMensagemErro = "Data inicial maior que data final"
                loc_lSucesso = .F.
            ENDIF

            *-- Formatar datas para SQL
            loc_cDataIni = FormatarDataSQL(THIS.this_dDataIni)
            loc_cDataFin = "'" + ;
                PADL(YEAR(THIS.this_dDataFin),  4, "0") + "-" + ;
                PADL(MONTH(THIS.this_dDataFin), 2, "0") + "-" + ;
                PADL(DAY(THIS.this_dDataFin),   2, "0") + " 23:59:59'"

            *-- Campo de data do filtro (Prorrogados=e.vencs, Vencimento=a.vencs)
            loc_cCampoDt = IIF(THIS.this_nTipoFiltro = 1, "e.vencs", "a.vencs")

            *-- Montar clausula adicional de filtro por tipo de relatorio
            DO CASE
                CASE THIS.this_nTipoRel = 2  && Baixados
                    loc_cVerTipo = " AND a.umovs IN (" + ;
                        "SELECT operacaos FROM SigCdOpt " + ;
                        "WHERE tipos='CR' AND devolvidos='N' " + ;
                        "AND opants NOT IN (" + ;
                        "SELECT operacaos FROM SigCdOpt " + ;
                        "WHERE tipos='DB' AND devolvidos='S'))"

                CASE THIS.this_nTipoRel = 3  && NEG.PG (Devolvidos)
                    loc_cVerTipo = " AND a.umovs IN (" + ;
                        "SELECT operacaos FROM SigCdOpt " + ;
                        "WHERE tipos='DB' AND devolvidos='S')"

                CASE THIS.this_nTipoRel = 4  && Bons
                    IF THIS.this_nBons = 1  && Ativos
                        loc_cVerTipo = " AND a.umovs IN (" + ;
                            "SELECT operacaos FROM SigCdOpt " + ;
                            "WHERE devolvidos<>'S' AND tipos='DB' AND Ordens=1)"
                    ELSE  && Todos
                        loc_cVerTipo = " AND a.umovs IN (" + ;
                            "SELECT operacaos FROM SigCdOpt " + ;
                            "WHERE devolvidos<>'S')"
                    ENDIF
                    loc_cVerTipo = loc_cVerTipo + ;
                        " AND a.contat NOT IN (" + ;
                        "SELECT DISTINCT contat FROM sigche " + ;
                        "WHERE umovs IN (" + ;
                        "SELECT operacaos FROM SigCdOpt " + ;
                        "WHERE devolvidos='S'))"

                CASE THIS.this_nTipoRel = 5  && Devolvidos
                    loc_cVerTipo = " AND a.umovs IN (" + ;
                        "SELECT operacaos FROM SigCdOpt " + ;
                        "WHERE devolvidos='S')"

                OTHERWISE  && Ativos (lnTipoRel=1 ou vazio)
                    loc_cVerTipo = " AND a.umovs IN (" + ;
                        "SELECT operacaos FROM SigCdOpt " + ;
                        "WHERE tipos='DB' AND devolvidos='N')"
            ENDCASE

            *-- Calcular titulo com filtros aplicados
            THIS.this_cTitulo = "Filtros: " + ;
                IIF(THIS.this_nTipoFiltro = 1, "Prorrogados", "Vencimento") + ;
                " - " + ;
                IIF(THIS.this_nTipoRel = 1 OR THIS.this_nTipoRel = 0, "Ativos", ;
                IIF(THIS.this_nTipoRel = 2, "Baixados", ;
                IIF(THIS.this_nTipoRel = 3, "NEG.PG", ;
                IIF(THIS.this_nTipoRel = 4, ;
                    "Bons - " + IIF(THIS.this_nBons = 1, "Ativos", "Todos"), ;
                    "Devolvidos"))))

            *-- Fechar cursor anterior se existir
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            *-- Montar SQL principal (todas as tabelas em SQL Server)
            loc_cSQL = "SELECT e.iclis, e.vencs AS ultvenc, e.umovs, " + ;
                       "e.agencias, e.bancos, e.ncontas, e.ncheques, " + ;
                       "c.rclis, c.grupos, e.valors, a.*, " + ;
                       TRANSFORM(THIS.this_nOpcao) + " AS opcao, " + ;
                       "m.razas AS empresa, " + ;
                       "CAST(" + loc_cDataIni + " AS datetime) AS dataini, " + ;
                       "CAST(" + loc_cDataFin + " AS datetime) AS datafin, " + ;
                       "e.contat, e.grupot, t.rclis AS dContat "
            loc_cSQL = loc_cSQL + ;
                       "FROM SigChe e, SigCdOpt r, SigCdCli c, " + ;
                       "SigChea a, SigCdEmp m, SigCdCli t "
            loc_cSQL = loc_cSQL + ;
                       "WHERE " + loc_cCampoDt + ;
                       " BETWEEN " + loc_cDataIni + " AND " + loc_cDataFin + ;
                       " AND e.umovs = r.operacaos" + ;
                       " AND e.iclis = c.iclis" + ;
                       " AND e.nums = a.nums" + ;
                       " AND e.contat = t.iclis" + ;
                       " AND m.cemps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
            loc_cSQL = loc_cSQL + loc_cVerTipo + ;
                       " ORDER BY c.rclis, e.agencias, e.bancos, e.ncontas, e.ncheques"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados de cheques prorrogados"
                loc_lSucesso = .F.
            ENDIF

            SELECT (THIS.this_cCursorDados)
            GO TOP
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrecprBO.PrepararDados")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarCabecalho - Cria CsCabecalho para uso no relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarCabecalho()
        LOCAL loc_lSucesso, loc_nResult, loc_cSqlEmp, loc_cNomeEmpresa, loc_cPeriodo
        loc_lSucesso = .F.
        TRY
            loc_cNomeEmpresa = ""
            loc_cSqlEmp = "SELECT TOP 1 Razas FROM SigCdEmp WHERE cemps = " + ;
                          EscaparSQL(go_4c_Sistema.cCodEmpresa)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSqlEmp, "cursor_4c_Emp")
            IF loc_nResult > 0
                SELECT cursor_4c_Emp
                IF !EOF()
                    loc_cNomeEmpresa = ALLTRIM(cursor_4c_Emp.Razas)
                ENDIF
                USE IN cursor_4c_Emp
            ENDIF

            loc_cPeriodo = "Per" + CHR(237) + "odo: " + DTOC(THIS.this_dDataIni) + ;
                           " " + CHR(224) + " " + DTOC(THIS.this_dDataFin) + ;
                           " - Filtro: " + ;
                           IIF(THIS.this_nTipoFiltro = 1, "Prorrogados", "Vencimento")

            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF
            CREATE CURSOR CsCabecalho ;
                (NomeEmpresa C(80), Titulo C(100), Periodo C(100))
            INSERT INTO CsCabecalho (NomeEmpresa, Titulo, Periodo) ;
                VALUES (loc_cNomeEmpresa, THIS.this_cTitulo, loc_cPeriodo)

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrecprBO.MontarCabecalho")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursores - Fecha cursores de trabalho apos impressao/visualizacao
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursores()
        TRY
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF
            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrecprBO.LimparCursores")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime relatorio na impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cMensagemErro = ""
            IF !THIS.PrepararDados()
                IF EMPTY(THIS.this_cMensagemErro)
                    THIS.this_cMensagemErro = "Erro ao preparar dados do relat" + ;
                        CHR(243) + "rio"
                ENDIF
                loc_lSucesso = .F.
            ENDIF
            IF !THIS.MontarCabecalho()
                loc_lSucesso = .F.
            ENDIF
            SELECT (THIS.this_cCursorDados)
            REPORT FORM (THIS.this_cArquivoRelatorio) TO PRINTER PROMPT NOCONSOLE
            THIS.LimparCursores()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrecprBO.Imprimir")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cMensagemErro = ""
            IF !THIS.PrepararDados()
                IF EMPTY(THIS.this_cMensagemErro)
                    THIS.this_cMensagemErro = "Erro ao preparar dados do relat" + ;
                        CHR(243) + "rio"
                ENDIF
                loc_lSucesso = .F.
            ENDIF
            IF !THIS.MontarCabecalho()
                loc_lSucesso = .F.
            ENDIF
            SELECT (THIS.this_cCursorDados)
            REPORT FORM (THIS.this_cArquivoRelatorio) PREVIEW NOCONSOLE
            THIS.LimparCursores()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrecprBO.Visualizar")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega os filtros do BO a partir de um cursor
    * Util para restaurar filtros salvos / pre-configurados antes da impressao.
    * Aceita cursores com qualquer subconjunto das colunas abaixo:
    *   dDataIni, dDataFin (data)
    *   nTipoFiltro, nTipoRel, nBons, nOpcao (numerico)
    *   cTitulo (texto)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias
        loc_lSucesso = .F.
        TRY
            loc_cAlias = ALLTRIM(par_cAliasCursor)
            IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor de filtros n" + CHR(227) + ;
                    "o dispon" + CHR(237) + "vel: " + loc_cAlias
                loc_lSucesso = .F.
            ENDIF

            SELECT (loc_cAlias)

            IF TYPE(loc_cAlias + ".dDataIni") = "D"
                THIS.this_dDataIni = NVL(EVALUATE(loc_cAlias + ".dDataIni"), DATE())
            ENDIF
            IF TYPE(loc_cAlias + ".dDataFin") = "D"
                THIS.this_dDataFin = NVL(EVALUATE(loc_cAlias + ".dDataFin"), DATE())
            ENDIF
            IF TYPE(loc_cAlias + ".nTipoFiltro") = "N"
                THIS.this_nTipoFiltro = NVL(EVALUATE(loc_cAlias + ".nTipoFiltro"), 1)
            ENDIF
            IF TYPE(loc_cAlias + ".nTipoRel") = "N"
                THIS.this_nTipoRel = NVL(EVALUATE(loc_cAlias + ".nTipoRel"), 1)
            ENDIF
            IF TYPE(loc_cAlias + ".nBons") = "N"
                THIS.this_nBons = NVL(EVALUATE(loc_cAlias + ".nBons"), 1)
            ENDIF
            IF TYPE(loc_cAlias + ".nOpcao") = "N"
                THIS.this_nOpcao = NVL(EVALUATE(loc_cAlias + ".nOpcao"), 1)
            ENDIF
            IF TYPE(loc_cAlias + ".cTitulo") = "C"
                THIS.this_cTitulo = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".cTitulo"), ""))
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrecprBO.CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave composta dos filtros para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = "TIPO="   + ALLTRIM(STR(THIS.this_nTipoFiltro, 1)) + ;
                     ";REL="   + ALLTRIM(STR(THIS.this_nTipoRel, 1)) + ;
                     ";BONS="  + ALLTRIM(STR(THIS.this_nBons, 1)) + ;
                     ";OPC="   + ALLTRIM(STR(THIS.this_nOpcao, 1)) + ;
                     ";DT="    + DTOC(THIS.this_dDataIni) + ;
                     "-"       + DTOC(THIS.this_dDataFin)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra geracao do relatorio em LogAuditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResult, loc_cUsuario
        loc_lSucesso = .F.
        TRY
            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
            ENDIF

            loc_cChave = THIS.ObterChavePrimaria()

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(DataHora, Usuario, Tabela, Operacao, ChaveRegistro) " + ;
                       "VALUES (GETDATE(), " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       EscaparSQL("SigReCpr") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Semantica para BO de relatorio: delega para Imprimir
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = THIS.Imprimir()
            IF loc_lSucesso
                THIS.RegistrarAuditoria("IMPRESSAO")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrecprBO.Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Semantica para BO de relatorio: delega para Visualizar
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = THIS.Visualizar()
            IF loc_lSucesso
                THIS.RegistrarAuditoria("VISUALIZACAO")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrecprBO.Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpa cursores e chama base
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.LimparCursores()
        DODEFAULT()
    ENDPROC

ENDDEFINE

