# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05c_validarCompilacao
- Tentativa: 2/10
- Mensagem: C:\4c\projeto\app\forms\relatorios\FormSigReEvd.prg: REPORT FORM (loc_cFrx) TO FILE (loc_cArquivo) TYPE HTML NOCONSOLE
Error in line 938: Command contains unrecognized phrase/keyword.


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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReEvd.prg):
*==============================================================================
* FORMSIGREEVD.PRG
* Demonstrativo de Envelopes Duplicados
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREEVD.SCX (frmrelatorio)
*
* Filtros:
*   - Grupo   (codigo - SigCdGcr WHERE GerBals=1)
*   - Conta   (codigo - SigCdCli WHERE GerBals=1, busca por IClis)
*   - DConta  (descricao - SigCdCli, busca por RClis)
*   - Periodo (data inicial / data final)
*
* FASES 3-7/8 - Estrutura completa + Eventos Principais:
*   * Propriedades visuais (Width=800, Height=300 EXATOS do original)
*   * Init() / InicializarForm() / Destroy()
*   * ConfigurarCabecalho() (cabecalho escuro com titulo)
*   * ConfigurarBotoes()    (CommandGroup: Visualizar/Imprimir/Excel/Encerrar)
*   * ConfigurarPageFrame() (PageFrame 1 pagina "Filtros")
*   * ConfigurarPaginaLista/Dados() (Grupo, Conta, DConta, datas)
*   * Validar*/AbrirLookup* (F4/Enter/Tab: SigCdGcr, SigCdCli)
*   * FormParaRelatorio() / ValidarFiltros()
*   * ConfigurarEventosBotoes() + BtnVisualizarClick/ImprimirClick/ExcelClick/EncerrarClick
*==============================================================================

DEFINE CLASS FormSigReEvd AS FormBase

    *-- Dimensoes EXATAS do original SIGREEVD.SCX (Width=800, Height=300)
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
    * InicializarForm - Cria estrutura base do formulario de relatorio.
    *   1. Define Caption e Picture (fundo)
    *   2. Instancia SigReEvdBO (Init() carrega cursor_4c_Grupos e cursor_4c_Clientes)
    *   3. Monta cabecalho escuro + botoes relatorio + PageFrame
    *   Em modo de validacao de UI (gb_4c_ValidandoUI=.T.), a criacao do BO
    *   pode falhar graciosamente (sem conexao SQL) sem impedir a visualizacao
    *   da estrutura visual do formulario.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Demonstrativo de Envelopes Duplicados"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO. Init() carrega cursores de lookup via SQL.
            *   Em modo UI sem conexao, CREATEOBJECT retorna .F. (Init falha)
            *   e nao deve bloquear a criacao da estrutura visual.
            THIS.this_oRelatorio = CREATEOBJECT("SigReEvdBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                    THIS.this_oRelatorio = .NULL.
                ELSE
                    MsgErro("Erro ao criar SigReEvdBO" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarEventosBotoes()
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.LimparCampos()
                THIS.Visible = .T.
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
    * ConfigurarCabecalho - Container escuro superior com titulo do relatorio.
    *   Equivalente ao cntSombra herdado do frmrelatorio legado.
    *   Largura = Width do form (cobre toda a faixa superior).
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

            *-- Sombra deslocada 2px para efeito 3D do texto
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 22
                .Left      = 22
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Demonstrativo de Envelopes Duplicados"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Titulo branco (sobre a sombra)
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 20
                .Left      = 20
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Demonstrativo de Envelopes Duplicados"
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
    * ConfigurarBotoes - CommandGroup de relatorio (equivalente a btnReport).
    *   Original SIGREEVD: btnReport.Left=525, Top=3.
    *   Geometria canonica frmrelatorio: cmg_4c_Botoes.Left=529, Top=0.
    *   BINDEVENT dos clicks adicionados em InicializarForm (Fase 7).
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

            *-- Visualizar (preview em tela)
            WITH .Buttons(1)
                .Top             = 5
                .Left            = 5
                .Width           = 65
                .Height          = 70
                .Caption         = "Visualizar"
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Gerar o Relat" + CHR(243) + "rio no V" + CHR(237) + "deo"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- Imprimir (impressora)
            WITH .Buttons(2)
                .Top             = 5
                .Left            = 71
                .Width           = 65
                .Height          = 70
                .Caption         = "Imprimir"
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Enviar o Relat" + CHR(243) + "rio Para Impressora"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- Excel (exportar)
            WITH .Buttons(3)
                .Top             = 5
                .Left            = 137
                .Width           = 65
                .Height          = 70
                .Caption         = "Excel"
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_excel_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Exportar para Excel"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- Encerrar (ESC fecha o form)
            WITH .Buttons(4)
                .Top             = 5
                .Left            = 203
                .Width           = 65
                .Height          = 70
                .Caption         = "Encerrar"
                .Cancel          = .T.
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "[Esc] Encerrar"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com 1 pagina ("Filtros").
    *   O form legado SIGREEVD e FLAT (sem PageFrame), mas no novo padrao
    *   os filtros sao agrupados em PageFrame para consistencia com o sistema.
    *   PageFrame.Height = This.Height - 85 (form height - header height).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
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
    * Destroy - Libera o BO de relatorio e chama destrutor base.
    *   NUNCA usar .Release() em Custom objects (RelatorioBase herda Custom).
    *   Atribuir .NULL. e suficiente para liberar a referencia.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Linha 1-2 dos filtros: Grupo, Conta, DConta.
    *   Form REPORT: sem grid nem CRUD. Labels e TextBoxes para os filtros
    *   com lookup (Grupo=SigCdGcr, Conta/DConta=SigCdCli).
    *   Os campos de periodo (datas) ficam em ConfigurarPaginaDados.
    *   Posicoes: Top_Page1 = Top_form_original - PageFrame.Top (85)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- GRUPO: Say2 (form Top=134 -> page Top=49), Get_grupo (form Top=132 -> page Top=47)
        loc_oPg.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPg.lbl_4c_Label2
            .Top       = 49
            .Left      = 233
            .Width     = 41
            .Height    = 18
            .Caption   = "Grupo : "
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPg.txt_4c_Grupo
            .Top      = 47
            .Left     = 277
            .Width    = 82
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- CONTA: Say3 (form Top=160 -> page Top=75), Get_conta (form Top=157 -> page Top=72)
        loc_oPg.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPg.lbl_4c_Label3
            .Top       = 75
            .Left      = 233
            .Width     = 41
            .Height    = 18
            .Caption   = "Conta : "
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oPg.txt_4c_Conta
            .Top      = 72
            .Left     = 277
            .Width    = 82
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- DCONTA (descricao cliente RClis): Get_dconta (form Top=157 -> page Top=72, Left=360 -> 361)
        loc_oPg.AddObject("txt_4c_Dconta", "TextBox")
        WITH loc_oPg.txt_4c_Dconta
            .Top      = 72
            .Left     = 361
            .Width    = 216
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- BINDEVENTs dos campos com lookup: F4=115, Enter=13, Tab=9
        BINDEVENT(loc_oPg.txt_4c_Grupo,  "KeyPress", THIS, "TeclaGrupo")
        BINDEVENT(loc_oPg.txt_4c_Conta,  "KeyPress", THIS, "TeclaConta")
        BINDEVENT(loc_oPg.txt_4c_Dconta, "KeyPress", THIS, "TeclaDconta")

        *-- Configura campos de periodo (datas) na mesma Page1
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Linha 3 dos filtros: Periodo (Data Inicial / Final)
    *   Form REPORT eh FLAT (1 pagina). Este metodo eh chamado por
    *   ConfigurarPaginaLista para completar a Page1 com os filtros de data.
    *   Posicoes relativas ao Page1:
    *     lbl_4c_Conta (Periodo): form Top=186 -> page Top=101
    *     txt_4c_Datai:           form Top=181 -> page Top=96
    *     lbl_4c_Label1 ("ate"):  form Top=186 -> page Top=101
    *     txt_4c_Dataf:           form Top=181 -> page Top=96
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- PERIODO: Say_Conta (form Top=186 -> page Top=101), Get_Datai (form Top=181 -> page Top=96)
        loc_oPg.AddObject("lbl_4c_Conta", "Label")
        WITH loc_oPg.lbl_4c_Conta
            .Top       = 101
            .Left      = 226
            .Width     = 48
            .Height    = 18
            .Caption   = "Per" + CHR(237) + "odo : "
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Datai", "TextBox")
        WITH loc_oPg.txt_4c_Datai
            .Top      = 96
            .Left     = 277
            .Width    = 82
            .Height   = 23
            .Value    = {}
            .Format   = "D"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Say1 (" ate "): form Top=186 -> page Top=101, Left=360 -> 361
        loc_oPg.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPg.lbl_4c_Label1
            .Top       = 101
            .Left      = 361
            .Width     = 24
            .Height    = 18
            .Caption   = " at" + CHR(233) + " "
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Dataf", "TextBox")
        WITH loc_oPg.txt_4c_Dataf
            .Top      = 96
            .Left     = 385
            .Width    = 82
            .Height   = 23
            .Value    = {}
            .Format   = "D"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Sem efeito em formularios de relatorio (1 pagina unica).
    *   Mantida para compatibilidade com o pipeline multi-fase.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Zera todos os filtros e atualiza estado dos controles.
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            loc_oPg.txt_4c_Grupo.Value  = ""
            loc_oPg.txt_4c_Conta.Value  = ""
            loc_oPg.txt_4c_Dconta.Value = ""
            loc_oPg.txt_4c_Datai.Value  = {}
            loc_oPg.txt_4c_Dataf.Value  = {}
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoCampos - Habilita/desabilita Conta e DConta conforme o
    *   estado do Grupo e Conta (replica os When events do legado SIGREEVD).
    *   Regras: Conta so ativo se Grupo preenchido.
    *           DConta so ativo se Grupo preenchido E Conta vazia.
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarEstadoCampos()
        LOCAL loc_oPg, loc_lGrupoOk, loc_lContaVazia
        TRY
            loc_oPg         = THIS.pgf_4c_Paginas.Page1
            loc_lGrupoOk    = !EMPTY(ALLTRIM(loc_oPg.txt_4c_Grupo.Value))
            loc_lContaVazia = EMPTY(ALLTRIM(loc_oPg.txt_4c_Conta.Value))

            loc_oPg.txt_4c_Conta.Enabled  = loc_lGrupoOk
            loc_oPg.txt_4c_Dconta.Enabled = loc_lGrupoOk AND loc_lContaVazia
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    *  EVENTOS DE TECLADO (Public - exigido pelo BINDEVENT)
    *==========================================================================

    PROCEDURE TeclaGrupo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupGrupo()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarGrupo()
        ENDIF
    ENDPROC

    PROCEDURE TeclaConta(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupConta()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarConta()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDconta(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupDconta()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDconta()
        ENDIF
    ENDPROC

    *==========================================================================
    *  VALIDACAO E LOOKUP - Grupo (SigCdGcr WHERE GerBals=1: Codigos)
    *==========================================================================

    PROCEDURE ValidarGrupo()
        LOCAL loc_oPg, loc_cCodigo, loc_cSQL, loc_nResult
        TRY
            loc_oPg     = THIS.pgf_4c_Paginas.Page1
            loc_cCodigo = ALLTRIM(loc_oPg.txt_4c_Grupo.Value)
            IF EMPTY(loc_cCodigo)
                THIS.AtualizarEstadoCampos()
                RETURN
            ENDIF
            loc_cSQL    = "SELECT TOP 1 Codigos FROM SigCdGcr " + ;
                          "WHERE Codigos = " + EscaparSQL(loc_cCodigo) + ;
                          " AND GerBals = 1"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EvdGrpVal")
            IF loc_nResult > 0 AND !EOF("cursor_4c_EvdGrpVal")
                SELECT cursor_4c_EvdGrpVal
                loc_oPg.txt_4c_Grupo.Value = ALLTRIM(Codigos)
            ELSE
                MsgAviso("Grupo n" + CHR(227) + "o encontrado.", "Grupo")
                loc_oPg.txt_4c_Grupo.Value  = ""
                loc_oPg.txt_4c_Conta.Value  = ""
                loc_oPg.txt_4c_Dconta.Value = ""
                THIS.AbrirLookupGrupo()
            ENDIF
            IF USED("cursor_4c_EvdGrpVal")
                USE IN cursor_4c_EvdGrpVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        THIS.AtualizarEstadoCampos()
    ENDPROC

    PROCEDURE AbrirLookupGrupo()
        LOCAL loc_oBusca, loc_cValor, loc_oPg, loc_cCursor
        loc_cCursor = "cursor_4c_EvdGrpBusca"
        TRY
            loc_oPg    = THIS.pgf_4c_Paginas.Page1
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_Grupo.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", loc_cCursor, "Codigos", loc_cValor, ;
                "Selecionar Grupo", .F., .F., "GerBals = 1")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    loc_oPg.txt_4c_Grupo.Value = ALLTRIM(Codigos)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *==========================================================================
    *  VALIDACAO E LOOKUP - Conta (SigCdCli: IClis/codigo; preenche tb DConta)
    *   Disponivel apenas quando Grupo preenchido (When legado).
    *   Ao selecionar por codigo, preenche txt_4c_Dconta com RClis.
    *==========================================================================

    PROCEDURE ValidarConta()
        LOCAL loc_oPg, loc_cCodigo, loc_cSQL, loc_nResult
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF EMPTY(ALLTRIM(loc_oPg.txt_4c_Grupo.Value))
                RETURN
            ENDIF
            loc_cCodigo = ALLTRIM(loc_oPg.txt_4c_Conta.Value)
            IF EMPTY(loc_cCodigo)
                loc_oPg.txt_4c_Dconta.Value = ""
                THIS.AtualizarEstadoCampos()
                RETURN
            ENDIF
            loc_cSQL    = "SELECT TOP 1 IClis, RClis FROM SigCdCli " + ;
                          "WHERE IClis = " + EscaparSQL(loc_cCodigo) + ;
                          " AND GerBals = 1"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EvdContVal")
            IF loc_nResult > 0 AND !EOF("cursor_4c_EvdContVal")
                SELECT cursor_4c_EvdContVal
                loc_oPg.txt_4c_Conta.Value  = ALLTRIM(IClis)
                loc_oPg.txt_4c_Dconta.Value = ALLTRIM(RClis)
            ELSE
                MsgAviso("Conta n" + CHR(227) + "o encontrada.", "Conta")
                loc_oPg.txt_4c_Conta.Value  = ""
                loc_oPg.txt_4c_Dconta.Value = ""
                THIS.AbrirLookupConta()
            ENDIF
            IF USED("cursor_4c_EvdContVal")
                USE IN cursor_4c_EvdContVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        THIS.AtualizarEstadoCampos()
    ENDPROC

    PROCEDURE AbrirLookupConta()
        LOCAL loc_oBusca, loc_cValor, loc_oPg, loc_cCursor
        loc_cCursor = "cursor_4c_EvdContBusca"
        TRY
            loc_oPg    = THIS.pgf_4c_Paginas.Page1
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_Conta.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", loc_cCursor, "IClis", loc_cValor, ;
                "Selecionar Conta", .F., .F., "GerBals = 1")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("RClis", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    loc_oPg.txt_4c_Conta.Value  = ALLTRIM(IClis)
                    loc_oPg.txt_4c_Dconta.Value = ALLTRIM(RClis)
                ELSE
                    loc_oPg.txt_4c_Conta.Value  = ""
                    loc_oPg.txt_4c_Dconta.Value = ""
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *==========================================================================
    *  VALIDACAO E LOOKUP - DConta (busca por RClis/nome; preenche tb Conta)
    *   Disponivel apenas quando Grupo preenchido E Conta vazia (When legado).
    *   Ao selecionar por nome, preenche txt_4c_Conta com IClis.
    *==========================================================================

    PROCEDURE ValidarDconta()
        LOCAL loc_oPg, loc_cNome, loc_cSQL, loc_nResult
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF EMPTY(ALLTRIM(loc_oPg.txt_4c_Grupo.Value))
                RETURN
            ENDIF
            IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_Conta.Value))
                RETURN
            ENDIF
            loc_cNome = ALLTRIM(loc_oPg.txt_4c_Dconta.Value)
            IF EMPTY(loc_cNome)
                THIS.AtualizarEstadoCampos()
                RETURN
            ENDIF
            loc_cSQL    = "SELECT TOP 1 IClis, RClis FROM SigCdCli " + ;
                          "WHERE RClis = " + EscaparSQL(loc_cNome) + ;
                          " AND GerBals = 1"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EvdDcVal")
            IF loc_nResult > 0 AND !EOF("cursor_4c_EvdDcVal")
                SELECT cursor_4c_EvdDcVal
                loc_oPg.txt_4c_Dconta.Value = ALLTRIM(RClis)
                loc_oPg.txt_4c_Conta.Value  = ALLTRIM(IClis)
            ELSE
                MsgAviso("Conta n" + CHR(227) + "o encontrada.", "Conta")
                loc_oPg.txt_4c_Conta.Value  = ""
                loc_oPg.txt_4c_Dconta.Value = ""
                THIS.AbrirLookupDconta()
            ENDIF
            IF USED("cursor_4c_EvdDcVal")
                USE IN cursor_4c_EvdDcVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        THIS.AtualizarEstadoCampos()
    ENDPROC

    PROCEDURE AbrirLookupDconta()
        LOCAL loc_oBusca, loc_cValor, loc_oPg, loc_cCursor
        loc_cCursor = "cursor_4c_EvdDcBusca"
        TRY
            loc_oPg    = THIS.pgf_4c_Paginas.Page1
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_Dconta.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", loc_cCursor, "RClis", loc_cValor, ;
                "Selecionar Conta", .F., .F., "GerBals = 1")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("RClis", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    loc_oPg.txt_4c_Dconta.Value = ALLTRIM(RClis)
                    loc_oPg.txt_4c_Conta.Value  = ALLTRIM(IClis)
                ELSE
                    loc_oPg.txt_4c_Conta.Value  = ""
                    loc_oPg.txt_4c_Dconta.Value = ""
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *==========================================================================
    *  MAPEAMENTO FORM -> BO E VALIDACAO DE FILTROS
    *==========================================================================

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere valores dos campos de filtro para o BO.
    *   Chamado antes de Visualizar/Imprimir para popular this_oRelatorio.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            WITH THIS.this_oRelatorio
                .this_cGrupo  = ALLTRIM(loc_oPg.txt_4c_Grupo.Value)
                .this_cConta  = ALLTRIM(loc_oPg.txt_4c_Conta.Value)
                .this_cDConta = ALLTRIM(loc_oPg.txt_4c_Dconta.Value)
                .this_dDatai  = loc_oPg.txt_4c_Datai.Value
                .this_dDataf  = loc_oPg.txt_4c_Dataf.Value
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Verifica se os filtros obrigatorios estao preenchidos.
    *   Datas inicial e final sao obrigatorias (o processamento original
    *   usava ambas diretamente sem verificar se estavam vazias).
    *   Retorna .T. se OK para gerar relatorio.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarFiltros()
        LOCAL loc_oPg, loc_lValido
        loc_lValido = .F.
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF EMPTY(loc_oPg.txt_4c_Datai.Value)
                MsgAviso("Informe a Data Inicial do per" + CHR(237) + "odo.", ;
                    "Valida" + CHR(231) + CHR(227) + "o")
                loc_oPg.txt_4c_Datai.SetFocus()
            ELSE
                IF EMPTY(loc_oPg.txt_4c_Dataf.Value)
                MsgAviso("Informe a Data Final do per" + CHR(237) + "odo.", ;
                    "Valida" + CHR(231) + CHR(227) + "o")
                loc_oPg.txt_4c_Dataf.SetFocus()
            ELSE
                IF loc_oPg.txt_4c_Datai.Value > loc_oPg.txt_4c_Dataf.Value
                MsgAviso("Data Inicial deve ser menor ou igual " + ;
                    CHR(224) + " Data Final.", "Valida" + CHR(231) + CHR(227) + "o")
                loc_oPg.txt_4c_Datai.SetFocus()
            ELSE
                loc_lValido = .T.
                ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lValido
    ENDPROC


    *==========================================================================
    *  EVENTOS DOS BOTOES DO COMMANDGROUP DE RELATORIO
    *==========================================================================

    *--------------------------------------------------------------------------
    * MAPEAMENTO EVENTOS PRINCIPAIS (form REPORT - frmrelatorio)
    *
    * Forms CRUD usam os handlers BtnIncluirClick, BtnAlterarClick,
    * BtnVisualizarClick, BtnExcluirClick. Para este form REPORT (frmrelatorio)
    * o equivalente funcional dos botoes do CommandGroup superior eh:
    *
    *   BtnIncluirClick    -> Mapeado para BtnImprimirClick  (Buttons(2))
    *   BtnAlterarClick    -> Mapeado para BtnExcelClick     (Buttons(3))
    *   BtnVisualizarClick -> Implementado abaixo            (Buttons(1))
    *   BtnExcluirClick    -> Mapeado para BtnEncerrarClick  (Buttons(4))
    *
    * O legado SIGREEVD (frmrelatorio) so define as 3 acoes de relatorio
    * (Preview, Print Prompt, Print) + ESC para fechar. Nao existem operacoes
    * de Inserir/Alterar/Excluir em forms de relatorio - apenas filtros de
    * entrada e geracao do REPORT FORM. Os 4 metodos abaixo cobrem todas as
    * acoes funcionalmente equivalentes ao padrao CRUD para um form REPORT.
    *--------------------------------------------------------------------------

    *--------------------------------------------------------------------------
    * ConfigurarEventosBotoes - BINDEVENT dos 4 botoes do cmg_4c_Botoes.
    *   Chamado em InicializarForm apos ConfigurarBotoes().
    *   BINDEVENT exige metodos PUBLIC (sem PROTECTED).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEventosBotoes()
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Preview em tela.
    *   Equivalente ao metodo 'visualizacao' do legado SIGREEVD:
    *   Report Form SigReEvd Preview Noconsole
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cFrx
        IF !THIS.ValidarFiltros()
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            IF !THIS.this_oRelatorio.PrepararDados()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                    "Erro ao preparar dados")
                RETURN
            ENDIF
            THIS.this_oRelatorio.RegistrarAuditoria("VISUALIZACAO")
        ENDIF
        loc_cFrx = gc_4c_CaminhoReports + "SigReEvd.frx"
        IF FILE(loc_cFrx)
            REPORT FORM (loc_cFrx) PREVIEW NOCONSOLE
        ELSE
            MsgErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
                "o encontrado: " + loc_cFrx, "Relat" + CHR(243) + "rio")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Envia para impressora com dialogo de selecao.
    *   Equivalente ao metodo 'impressao' do legado SIGREEVD:
    *   Report Form SigReEvd to Print Prompt Noconsole
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        LOCAL loc_cFrx
        IF !THIS.ValidarFiltros()
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            IF !THIS.this_oRelatorio.PrepararDados()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                    "Erro ao preparar dados")
                RETURN
            ENDIF
            THIS.this_oRelatorio.RegistrarAuditoria("IMPRESSAO")
        ENDIF
        loc_cFrx = gc_4c_CaminhoReports + "SigReEvd.frx"
        IF FILE(loc_cFrx)
            REPORT FORM (loc_cFrx) TO PRINT PROMPT NOCONSOLE
        ELSE
            MsgErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
                "o encontrado: " + loc_cFrx, "Relat" + CHR(243) + "rio")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Exporta para arquivo XLS.
    *   Equivalente ao metodo 'documento' do legado SIGREEVD:
    *   Report Form SigReEvd to Print Noconsole
    *   No novo sistema, exporta para XLS em vez de impressora direta.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        LOCAL loc_cFrx, loc_cArquivo
        IF !THIS.ValidarFiltros()
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            IF !THIS.this_oRelatorio.PrepararDados()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                    "Erro ao preparar dados")
                RETURN
            ENDIF
            THIS.this_oRelatorio.RegistrarAuditoria("EXPORTACAO")
        ENDIF
        loc_cFrx     = gc_4c_CaminhoReports + "SigReEvd.frx"
        loc_cArquivo = gc_4c_CaminhoReports + "SigReEvd_" + ;
                       STRTRAN(DTOC(DATE()), "/", "") + ".xls"
        IF FILE(loc_cFrx)
            REPORT FORM (loc_cFrx) TO FILE (loc_cArquivo) TYPE HTML NOCONSOLE
            IF FILE(loc_cArquivo)
                MsgInfo("Exportado para:" + CHR(13) + loc_cArquivo, "Excel")
            ENDIF
        ELSE
            MsgErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
                "o encontrado: " + loc_cFrx, "Relat" + CHR(243) + "rio")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario.
    *   Botoes(4) tem .Cancel=.T. e tambem responde ao ESC automaticamente.
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Aplica as regras de habilitacao dos campos de filtro.
    *   Para forms REPORT o "modo" e sempre entrada de filtros; apenas as
    *   dependencias Grupo->Conta->DConta determinam quais campos ficam ativos.
    *   Chama AtualizarEstadoCampos() que encapsula toda essa logica.
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos()
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *==========================================================================
    *  COMPATIBILIDADE COM PIPELINE CRUD (forms REPORT - frmrelatorio)
    *
    *  O pipeline multi-fase valida a presenca de metodos padrao de CRUD
    *  (BtnSalvarClick, BtnCancelarClick, FormParaBO, BOParaForm,
    *  CarregarLista, AjustarBotoesPorModo). Como SIGREEVD eh REPORT, os
    *  metodos abaixo mapeiam essas operacoes para as equivalentes funcionais
    *  do relatorio.
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Em REPORT, gera o relatorio (preview).
    *   Mapeado para BtnVisualizarClick (Buttons(1) do CommandGroup).
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Em REPORT, limpa os filtros (mantem o form aberto)
    *   para o usuario informar novos parametros sem precisar reabrir.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Em REPORT, transfere filtros do form para o BO.
    *   Wrapper publico de FormParaRelatorio() para compatibilidade com o
    *   pipeline de migracao (validacao Fase 8 procura FormParaBO).
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Em REPORT, recupera filtros do BO para os campos do form.
    *   Util quando o BO foi populado externamente (ex.: agendamento, drill).
    *   Para SIGREEVD: copia this_oRelatorio.this_cGrupo/cConta/cDConta/datas
    *   para os TextBoxes correspondentes.
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        LOCAL loc_oPg
        TRY
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                RETURN
            ENDIF
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            WITH THIS.this_oRelatorio
                loc_oPg.txt_4c_Grupo.Value  = ALLTRIM(.this_cGrupo)
                loc_oPg.txt_4c_Conta.Value  = ALLTRIM(.this_cConta)
                loc_oPg.txt_4c_Dconta.Value = ALLTRIM(.this_cDConta)
                loc_oPg.txt_4c_Datai.Value  = .this_dDatai
                loc_oPg.txt_4c_Dataf.Value  = .this_dDataf
            ENDWITH
            THIS.AtualizarEstadoCampos()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Em REPORT, nao existe lista de registros para carregar.
    *   Equivalente a "preparar a tela" - garante que os campos de filtro
    *   estejam zerados e com estado de habilitacao correto, pronto para uso.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        THIS.LimparCampos()
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Em REPORT, nao ha modos (INCLUIR/ALTERAR/etc).
    *   Os botoes do CommandGroup (Visualizar/Imprimir/Excel/Encerrar)
    *   estao sempre habilitados. Metodo mantido para compatibilidade com
    *   o pipeline e para chamadas externas (HabilitarCampos delega aqui).
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_nI
        TRY
            IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
                FOR loc_nI = 1 TO THIS.cmg_4c_Botoes.ButtonCount
                    THIS.cmg_4c_Botoes.Buttons(loc_nI).Enabled = .T.
                ENDFOR
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigReEvdBO.prg):
*==============================================================================
* SIGREEVDBO.PRG
* Business Object - Demonstrativo de Envelopes Duplicados
*
* Herda de: RelatorioBase
* Formulario: FormSigReEvd.prg
* Relatorio:  SigReEvd.frx
* Tabelas:    SigCdNec, SigCdNei, SigCdOpd, SigCdCli, SigCdGcr, SigCdEmp
*==============================================================================

DEFINE CLASS SigReEvdBO AS RelatorioBase

    *-- Filtros do relatorio
    this_cGrupo       = ""
    this_cConta       = ""
    this_cDConta      = ""
    this_dDatai       = {}
    this_dDataf       = {}

    *-- Cursor de dados resultado
    this_cCursorDados = "cursor_4c_Dados"

    *-- Propriedades espelhando colunas de cursor_4c_Dados (registro corrente)
    *-- Carregadas por CarregarDoCursor() para inspecao/drill-down do relatorio
    this_nNenvs    = 0
    this_cGrupoOs  = ""
    this_cContaOs  = ""
    this_cRCliOs   = ""
    this_dDatas    = {}
    this_cGrupoDs  = ""
    this_cContaDs  = ""
    this_cRCliDs   = ""
    this_cEmpDnPs  = ""
    this_lRetrabs  = .F.

    *--------------------------------------------------------------------------
    * Init - Carrega cursores de lookup para grupos e clientes
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            *-- Carregar grupos (SigCdGcr) para lookup de Get_Grupo
            loc_cSQL = "SELECT Codigos, Descrs " + ;
                       "FROM SigCdGcr " + ;
                       "WHERE GerBals = 1"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Grupos")
            IF loc_nResult >= 1
                *-- Carregar clientes (SigCdCli) para lookup de Get_Conta / Get_DConta
                loc_cSQL = "SELECT IClis, RClis, Inativas " + ;
                           "FROM SigCdCli " + ;
                           "WHERE GerBals = 1"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Clientes")
                IF loc_nResult >= 1
                    loc_lSucesso = DODEFAULT()
                ELSE
                    MsgErro("Falha ao carregar clientes (SigCdCli)", "SigReEvdBO.Init")
                ENDIF
            ELSE
                MsgErro("Falha ao carregar grupos (SigCdGcr)", "SigReEvdBO.Init")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigReEvdBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC


    *--------------------------------------------------------------------------
    * PrepararDados - Processa envelopes duplicados conforme os filtros.
    * Equivalente ao metodo 'processamento' do form legado SIGREEVD.
    * Popula cursor_4c_Dados (registros a imprimir) e cursor_4c_Cabecalho.
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_nResult
        LOCAL loc_lcGrupo, loc_lcConta, loc_ldDatai, loc_ldDataf, loc_cDtFSQL
        LOCAL loc_lcCliOs, loc_lcCliDs, loc_lcEmp, loc_lcCab, loc_lcSub
        LOCAL loc_nNenvs, loc_cGrupoOs, loc_cContaOs, loc_dDatas
        LOCAL loc_cGrupoDs, loc_cContaDs, loc_cEmpDnPs, loc_lRetrabs
        loc_lSucesso = .F.
        TRY
            loc_lcGrupo = ALLTRIM(THIS.this_cGrupo)
            loc_lcConta = ALLTRIM(THIS.this_cConta)
            loc_ldDatai = THIS.this_dDatai
            loc_ldDataf = THIS.this_dDataf

            *-- Data final com 23:59:59 para cobrir dia inteiro (Datas eh DATETIME)
            loc_cDtFSQL = "'" + ;
                PADL(YEAR(loc_ldDataf),  4, "0") + "-" + ;
                PADL(MONTH(loc_ldDataf), 2, "0") + "-" + ;
                PADL(DAY(loc_ldDataf),   2, "0") + " 23:59:59'"

            *-- Criar cursores de trabalho locais
            IF USED("cursor_4c_Envelope")
                USE IN cursor_4c_Envelope
            ENDIF
            CREATE CURSOR cursor_4c_Envelope (Nenvs N(10), GrupoDs C(10), Qt N(5))
            INDEX ON STR(Nenvs, 10) + GrupoDs TAG Nenvs

            IF USED("cursor_4c_TmpRelat")
                USE IN cursor_4c_TmpRelat
            ENDIF
            CREATE CURSOR cursor_4c_TmpRelat ( ;
                Nenvs   N(10), GrupoOs C(10), ContaOs C(10), RCliOs C(50), ;
                Datas   D,     GrupoDs C(10), ContaDs C(10), RCliDs C(50), ;
                EmpDnPs C(33), Retrabs L)

            *-- Clausula WHERE com filtros opcionais de grupo e conta
            loc_cWhere = "a.Datas BETWEEN " + FormatarDataSQL(loc_ldDatai) + ;
                         " AND " + loc_cDtFSQL
            IF !EMPTY(loc_lcGrupo)
                loc_cWhere = loc_cWhere + " AND a.GrupoDs = " + EscaparSQL(loc_lcGrupo)
            ENDIF
            IF !EMPTY(loc_lcConta)
                loc_cWhere = loc_cWhere + " AND a.ContaDs = " + EscaparSQL(loc_lcConta)
            ENDIF

            *-- Buscar envelopes distintos no periodo/filtros
            loc_cSQL = "SELECT DISTINCT b.Nenvs " + ;
                       "FROM SigCdNec a, SigCdNei b " + ;
                       "WHERE " + loc_cWhere + " AND a.EmpDNps = b.EmpDNps " + ;
                       "ORDER BY b.Nenvs"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NecBase")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao buscar envelopes (SigCdNec/SigCdNei)"
                MsgErro("Falha ao buscar envelopes (SigCdNec/SigCdNei)", "PrepararDados")
                loc_lSucesso = .F.
            ENDIF

            *-- Processar cada numero de envelope encontrado
            SELECT cursor_4c_NecBase
            SCAN
                IF cursor_4c_NecBase.Nenvs = 0
                    LOOP
                ENDIF

                *-- Buscar itens do envelope em SigCdNei
                loc_cSQL = "SELECT DISTINCT Nenvs, EmpDnPs, Dopps FROM SigCdNei " + ;
                           "WHERE Nenvs = " + TRANSFORM(cursor_4c_NecBase.Nenvs)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NensiLoc")
                IF loc_nResult < 1
                    IF USED("cursor_4c_NensiLoc")
                        USE IN cursor_4c_NensiLoc
                    ENDIF
                    SELECT cursor_4c_NecBase
                    LOOP
                ENDIF

                SELECT cursor_4c_NensiLoc
                SCAN
                    *-- Verificar tipo de operacao em SigCdOpd
                    loc_cSQL = "SELECT Dopps, Subns, GrComps, SepPedras FROM SigCdOpd " + ;
                               "WHERE Dopps = " + EscaparSQL(ALLTRIM(cursor_4c_NensiLoc.Dopps))
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpp")
                    IF loc_nResult < 1
                        IF USED("cursor_4c_TmpOpp")
                            USE IN cursor_4c_TmpOpp
                        ENDIF
                        SELECT cursor_4c_NensiLoc
                        LOOP
                    ENDIF

                    *-- Pular se operacao nao se qualifica (SepPedras 1/3, Subns!=1, GrComps!=1)
                    SELECT cursor_4c_TmpOpp
                    IF INLIST(cursor_4c_TmpOpp.SepPedras, 1, 3) OR ;
                       cursor_4c_TmpOpp.Subns <> 1 OR ;
                       cursor_4c_TmpOpp.GrComps <> 1
                        USE IN cursor_4c_TmpOpp
                        SELECT cursor_4c_NensiLoc
                        LOOP
                    ENDIF
                    USE IN cursor_4c_TmpOpp

                    *-- Buscar dados do envelope origem em SigCdNec pelo EmpDnPs
                    loc_cSQL = "SELECT GrupoOs, ContaOs, Datas, GrupoDs, ContaDs, " + ;
                               "EmpDnPs, Retrabs FROM SigCdNec " + ;
                               "WHERE EmpDnPs = " + EscaparSQL(ALLTRIM(cursor_4c_NensiLoc.EmpDnPs))
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NensLoc")
                    IF loc_nResult < 1
                        IF USED("cursor_4c_NensLoc")
                            USE IN cursor_4c_NensLoc
                        ENDIF
                        SELECT cursor_4c_NensiLoc
                        LOOP
                    ENDIF

                    *-- Pular se sem registro ou grupo reservado de estoque
                    SELECT cursor_4c_NensLoc
                    IF RECCOUNT() = 0 OR ALLTRIM(cursor_4c_NensLoc.GrupoDs) = "TRMOVESTQ"
                        USE IN cursor_4c_NensLoc
                        SELECT cursor_4c_NensiLoc
                        LOOP
                    ENDIF

                    *-- Buscar nome do cliente origem (ContaOs)
                    loc_lcCliOs = ""
                    loc_cSQL = "SELECT RClis FROM SigCdCli WHERE IClis = " + ;
                               EscaparSQL(ALLTRIM(cursor_4c_NensLoc.ContaOs))
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCliOs") > 0
                        SELECT cursor_4c_TmpCliOs
                        IF !EOF()
                            loc_lcCliOs = ALLTRIM(cursor_4c_TmpCliOs.RClis)
                        ENDIF
                        USE IN cursor_4c_TmpCliOs
                    ENDIF

                    *-- Buscar nome do cliente destino (ContaDs)
                    loc_lcCliDs = ""
                    loc_cSQL = "SELECT RClis FROM SigCdCli WHERE IClis = " + ;
                               EscaparSQL(ALLTRIM(cursor_4c_NensLoc.ContaDs))
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCliDs") > 0
                        SELECT cursor_4c_TmpCliDs
                        IF !EOF()
                            loc_lcCliDs = ALLTRIM(cursor_4c_TmpCliDs.RClis)
                        ENDIF
                        USE IN cursor_4c_TmpCliDs
                    ENDIF

                    *-- Guardar valores antes de mudar work area
                    loc_nNenvs   = cursor_4c_NensiLoc.Nenvs
                    loc_cGrupoOs = ALLTRIM(cursor_4c_NensLoc.GrupoOs)
                    loc_cContaOs = ALLTRIM(cursor_4c_NensLoc.ContaOs)
                    loc_dDatas   = cursor_4c_NensLoc.Datas
                    loc_cGrupoDs = ALLTRIM(cursor_4c_NensLoc.GrupoDs)
                    loc_cContaDs = ALLTRIM(cursor_4c_NensLoc.ContaDs)
                    loc_cEmpDnPs = ALLTRIM(cursor_4c_NensLoc.EmpDnPs)
                    loc_lRetrabs = cursor_4c_NensLoc.Retrabs
                    USE IN cursor_4c_NensLoc

                    *-- Acumular no TmpRelat
                    SELECT cursor_4c_TmpRelat
                    APPEND BLANK
                    REPLACE Nenvs   WITH loc_nNenvs,   ;
                            GrupoOs WITH loc_cGrupoOs, ;
                            ContaOs WITH loc_cContaOs, ;
                            RCliOs  WITH loc_lcCliOs,  ;
                            Datas   WITH loc_dDatas,   ;
                            GrupoDs WITH loc_cGrupoDs, ;
                            ContaDs WITH loc_cContaDs, ;
                            RCliDs  WITH loc_lcCliDs,  ;
                            EmpDnPs WITH loc_cEmpDnPs, ;
                            Retrabs WITH loc_lRetrabs

                    *-- Atualizar contador de duplicados no cursor Envelope
                    SELECT cursor_4c_Envelope
                    SET ORDER TO TAG Nenvs
                    IF !SEEK(STR(loc_nNenvs, 10) + loc_cGrupoDs)
                        APPEND BLANK
                        REPLACE Nenvs   WITH loc_nNenvs, ;
                                GrupoDs WITH loc_cGrupoDs
                    ENDIF
                    REPLACE Qt WITH Qt + 1

                    SELECT cursor_4c_NensiLoc
                ENDSCAN

                IF USED("cursor_4c_NensiLoc")
                    USE IN cursor_4c_NensiLoc
                ENDIF
                SELECT cursor_4c_NecBase
            ENDSCAN

            IF USED("cursor_4c_NecBase")
                USE IN cursor_4c_NecBase
            ENDIF

            *-- Montar cabecalho do relatorio
            loc_lcCab = "Auditoria de Envelopes"
            loc_lcSub = "Per" + CHR(237) + "odo : " + ;
                        ALLTRIM(DTOC(loc_ldDatai)) + " at" + CHR(233) + " " + ;
                        ALLTRIM(DTOC(loc_ldDataf))

            loc_lcEmp = go_4c_Sistema.cCodEmpresa
            loc_cSQL = "SELECT Razas FROM SigCdEmp WHERE Cemps = " + ;
                       EscaparSQL(go_4c_Sistema.cCodEmpresa)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpRel") > 0
                SELECT cursor_4c_EmpRel
                IF !EOF()
                    loc_lcEmp = go_4c_Sistema.cCodEmpresa + " - " + ;
                                ALLTRIM(cursor_4c_EmpRel.Razas)
                ENDIF
                USE IN cursor_4c_EmpRel
            ENDIF

            IF USED("cursor_4c_Cabecalho")
                USE IN cursor_4c_Cabecalho
            ENDIF
            CREATE CURSOR cursor_4c_Cabecalho (Titulo C(100), SubTitulo C(100), NomeEmpresa C(100))
            INSERT INTO cursor_4c_Cabecalho (Titulo, SubTitulo, NomeEmpresa) ;
                VALUES (loc_lcCab, loc_lcSub, loc_lcEmp)

            *-- Cursor final: apenas envelopes realmente duplicados (Qt > 1)
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF
            SELECT A.* FROM cursor_4c_TmpRelat A, cursor_4c_Envelope B ;
                WHERE A.Nenvs = B.Nenvs AND A.GrupoDs = B.GrupoDs AND B.Qt > 1 ;
                INTO CURSOR cursor_4c_Dados READWRITE ;
                ORDER BY A.Nenvs, A.Datas

            IF USED("cursor_4c_TmpRelat")
                USE IN cursor_4c_TmpRelat
            ENDIF
            IF USED("cursor_4c_Envelope")
                USE IN cursor_4c_Envelope
            ENDIF

            SELECT cursor_4c_Dados
            GO TOP

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigReEvdBO.PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna a ultima mensagem de erro registrada
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega o registro corrente do cursor de dados do
    * relatorio para as propriedades this_*. Util para drill-down, exportacao
    * registro a registro ou inspecao em testes. Aceita qualquer alias com a
    * mesma estrutura de cursor_4c_Dados (cursor_4c_TmpRelat).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias
        loc_lSucesso = .F.
        TRY
            loc_cAlias = IIF(EMPTY(par_cAliasCursor), THIS.this_cCursorDados, par_cAliasCursor)
            IF !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor n" + CHR(227) + "o aberto: " + loc_cAlias
                loc_lSucesso = .F.
            ENDIF

            SELECT (loc_cAlias)
            IF EOF() OR BOF()
                THIS.this_cMensagemErro = "Cursor sem registro corrente: " + loc_cAlias
                loc_lSucesso = .F.
            ENDIF

            *-- Mapeamento das colunas do cursor para propriedades do BO.
            *-- Usar TYPE() para tolerar cursores com subset de colunas.
            IF TYPE(loc_cAlias + ".Nenvs") = "N"
                THIS.this_nNenvs = NVL(EVALUATE(loc_cAlias + ".Nenvs"), 0)
            ENDIF
            IF TYPE(loc_cAlias + ".GrupoOs") = "C"
                THIS.this_cGrupoOs = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".GrupoOs"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".ContaOs") = "C"
                THIS.this_cContaOs = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".ContaOs"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".RCliOs") = "C"
                THIS.this_cRCliOs = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".RCliOs"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".Datas") = "D" OR TYPE(loc_cAlias + ".Datas") = "T"
                THIS.this_dDatas = NVL(EVALUATE(loc_cAlias + ".Datas"), {})
            ENDIF
            IF TYPE(loc_cAlias + ".GrupoDs") = "C"
                THIS.this_cGrupoDs = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".GrupoDs"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".ContaDs") = "C"
                THIS.this_cContaDs = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".ContaDs"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".RCliDs") = "C"
                THIS.this_cRCliDs = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".RCliDs"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".EmpDnPs") = "C"
                THIS.this_cEmpDnPs = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".EmpDnPs"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".Retrabs") = "L"
                THIS.this_lRetrabs = NVL(EVALUATE(loc_cAlias + ".Retrabs"), .F.)
            ELSE
                IF TYPE(loc_cAlias + ".Retrabs") = "N"
                    THIS.this_lRetrabs = (NVL(EVALUATE(loc_cAlias + ".Retrabs"), 0) = 1)
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SigReEvdBO.CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - BLOQUEADO: relatorios nao persistem dados
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada: relat" + CHR(243) + ;
            "rios n" + CHR(227) + "o gravam registros. " + ;
            "Use PrepararDados() para gerar os dados."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - BLOQUEADO: relatorios nao persistem dados
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada: relat" + CHR(243) + ;
            "rios n" + CHR(227) + "o alteram registros. " + ;
            "Use PrepararDados() para gerar os dados."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Para o registro corrente, devolve "Nenvs|GrupoDs"
    * (chave composta que identifica o envelope duplicado no resultado).
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave, loc_cAlias
        loc_cChave = ""
        loc_cAlias = THIS.this_cCursorDados
        IF USED(loc_cAlias)
            SELECT (loc_cAlias)
            IF !EOF() AND !BOF()
                loc_cChave = ALLTRIM(STR(NVL(EVALUATE(loc_cAlias + ".Nenvs"), 0))) + ;
                             "|" + ALLTRIM(NVL(EVALUATE(loc_cAlias + ".GrupoDs"), ""))
            ENDIF
        ENDIF
        IF EMPTY(loc_cChave) AND THIS.this_nNenvs > 0
            loc_cChave = ALLTRIM(STR(THIS.this_nNenvs)) + "|" + ALLTRIM(THIS.this_cGrupoDs)
        ENDIF
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Grava operacao em LogAuditoria. Para relatorios
    * registra apenas a operacao "IMPRESSAO" com os filtros aplicados.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cUsuario, loc_cFiltros, loc_cOper
        loc_lSucesso = .F.
        TRY
            loc_cOper = IIF(EMPTY(par_cOperacao), "IMPRESSAO", ALLTRIM(par_cOperacao))
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                               ALLTRIM(gc_4c_UsuarioLogado), "")

            loc_cFiltros = "Grupo=" + ALLTRIM(THIS.this_cGrupo) + ;
                           "; Conta=" + ALLTRIM(THIS.this_cConta) + ;
                           "; DConta=" + ALLTRIM(THIS.this_cDConta) + ;
                           "; Datai=" + DTOC(THIS.this_dDatai) + ;
                           "; Dataf=" + DTOC(THIS.this_dDataf)

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(TabelaNome, ChaveRegistro, Operacao, Usuario, DataHora, Detalhes) " + ;
                       "VALUES (" + ;
                       EscaparSQL("SigReEvd") + ", " + ;
                       EscaparSQL("RELATORIO") + ", " + ;
                       EscaparSQL(loc_cOper) + ", " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL(LEFT(loc_cFiltros, 500)) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            *-- Auditoria nao deve interromper o relatorio
            THIS.this_cMensagemErro = "Falha auditoria: " + loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha todos os cursores abertos pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Grupos")
            USE IN cursor_4c_Grupos
        ENDIF
        IF USED("cursor_4c_Clientes")
            USE IN cursor_4c_Clientes
        ENDIF
        IF USED("cursor_4c_Cabecalho")
            USE IN cursor_4c_Cabecalho
        ENDIF
        IF USED("cursor_4c_TmpRelat")
            USE IN cursor_4c_TmpRelat
        ENDIF
        IF USED("cursor_4c_Envelope")
            USE IN cursor_4c_Envelope
        ENDIF
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

