*==============================================================================
* FORMSIGREDCT.PRG
* Formulario de Impressao de Documento de Corte
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SigReDct.SCX (frmrelatorio)
*
* Recebe parametros via Init():
*   - par_cEmp : codigo da empresa
*   - par_cDop : tipo/operacao do documento
*   - par_nNum : numero do documento
*   - par_nImp : (reservado)
*
* Layout: Cabecalho + PageFrame (1 pagina "Parametros")
*   - cnt_4c_Cabecalho  : container escuro superior com titulo do documento
*   - pgf_4c_Paginas    : PageFrame com Page1 "Parametros" (campos de filtro)
*                         Page2 "Dados" (reservada, sem controles de entrada)
*   - cmg_4c_Botoes     : CommandGroup Visualizar/Imprimir/Excel/Encerrar
*   - chk_4c_ImpTotal   : checkbox Imprimir Totalizacao (form flat, Top=90)
*   - chk_4c_ImpCodBarra: checkbox Imprimir somente Cod. de Barras (form flat, Top=108)
*
* Fases concluidas:
*   FASE 1-2: SigReDctBO.prg (BO completo com PrepararDados)
*   FASE 3  : DEFINE CLASS, propriedades, Init(), InicializarForm(),
*             ConfigurarCabecalho(), ConfigurarPageFrame(), Destroy()
*   FASE 4  : ConfigurarBotoes(), ConfigurarPaginaLista(), BINDEVENTs,
*             todos os handlers de botoes e checkboxes
*   FASE 5  : ConfigurarPaginaDados() - Page2 sem campos (frmrelatorio flat)
*   FASE 6  : Verificacao de campos/lookups (form nao tem - original so tem 2
*             checkboxes). fAltBar2de5() integrada em functions.prg.
*==============================================================================

DEFINE CLASS FormSigReDct AS FormBase

    *-- Dimensoes e aparencia (EXATAS do original: Width=800, Height=150)
    Height      = 150
    Width       = 800
    DataSession = 2
    ShowWindow  = 1
    WindowType  = 1
    AutoCenter  = .T.
    BorderStyle = 2
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    Themes      = .F.
    ShowTips    = .T.

    *-- Referencia ao BO de relatorio (instanciado em InicializarForm)
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *-- Parametros do documento (recebidos via Init e sincronizados ao BO)
    this_cEmps  = ""    && Codigo da empresa
    this_cDopes = ""    && Tipo/operacao do documento
    this_nNumes = 0     && Numero do documento

    *--------------------------------------------------------------------------
    * Init - Armazena parametros do documento e delega ao FormBase.Init()
    *   FormBase.Init() aplica SET DATE BRITISH/CENTURY ON e chama
    *   THIS.InicializarForm() onde os parametros armazenados sao usados.
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cEmp, par_cDop, par_nNum, par_nImp)
        THIS.this_cEmps  = IIF(VARTYPE(par_cEmp) = "C", par_cEmp, "")
        THIS.this_cDopes = IIF(VARTYPE(par_cDop) = "C", par_cDop, "")
        THIS.this_nNumes = IIF(VARTYPE(par_nNum) = "N", par_nNum, 0)
        THIS.Caption = "Impress" + CHR(227) + "o de Documento"
        IF !EMPTY(ALLTRIM(THIS.this_cDopes)) OR THIS.this_nNumes > 0
            THIS.Caption = THIS.Caption + " (" + ;
                ALLTRIM(THIS.this_cDopes) + "/" + ALLTRIM(STR(THIS.this_nNumes)) + ")"
        ENDIF
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Monta estrutura base do formulario flat de impressao
    *   1. Fundo (Picture) do layout padrao
    *   2. Instancia SigReDctBO e sincroniza parametros do documento
    *   3. Cabecalho escuro com titulo dinamico do documento
    *   (Fases 4+: botoes CommandGroup, checkboxes, BINDEVENTs)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            THIS.this_oRelatorio = CREATEOBJECT("SigReDctBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SigReDctBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                THIS.this_oRelatorio.this_cEmps  = THIS.this_cEmps
                THIS.this_oRelatorio.this_cDopes = THIS.this_cDopes
                THIS.this_oRelatorio.this_nNumes = THIS.this_nNumes

                THIS.ConfigurarCabecalho()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Botoes do relatorio (Visualizar / Imprimir / Excel / Encerrar)
                THIS.ConfigurarBotoes()

                *-- PageFrame com pagina de parametros
                THIS.ConfigurarPageFrame()

                *-- Opcoes de impressao no form flat (checkboxes ImpTotal/ImpCodBarra)
                THIS.ConfigurarPaginaLista()

                *-- Page2: sem campos de entrada (frmrelatorio flat)
                THIS.ConfigurarPaginaDados()

                *-- Vincular Click dos botoes de relatorio
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")

                *-- Vincular click dos checkboxes (opcoes mutuamente exclusivas)
                BINDEVENT(THIS.chk_4c_ImpTotal,    "Click", THIS, "ChkImpTotalClick")
                BINDEVENT(THIS.chk_4c_ImpCodBarra, "Click", THIS, "ChkImpCodBarraClick")

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
    * ConfigurarCabecalho - Container escuro superior com titulo do documento
    *   Equivalente ao cntSombra do frmrelatorio legado.
    *   Original: cntSombra.Top=0, Left=0 (cobrindo largura total do form).
    *   Caption dinamico atualizado apos AddObject em InicializarForm().
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

            *-- Sombra (deslocada 2px para efeito de profundidade no texto)
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 22
                .Left      = 22
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = THIS.Caption
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Titulo em branco (sobreposto a sombra preta)
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 20
                .Left      = 20
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = THIS.Caption
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
    * ConfigurarPageFrame - PageFrame com 1 pagina "Parametros"
    *   O form legado SigReDct e FLAT (sem PageFrame), mas no novo padrao
    *   os campos de parametro/filtro sao agrupados em PageFrame de 2 paginas
    *   (Tabs ocultas, ActivePage=1) para consistencia com o restante do sistema.
    *
    *   Posicionamento: logo abaixo do cabecalho (80px) ate o fim do form.
    *   Os checkboxes ImpTotal/ImpCodBarra ficam diretamente no form (flat),
    *   nao em Page1, preservando as posicoes originais Top=90/108.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        *-- PageCount OBRIGATORIAMENTE antes de acessar Page1/Page2
        loc_oPgf.PageCount = 2

        *-- Posicionamento: logo abaixo do cabecalho (80px) ate o fim do form
        loc_oPgf.Top    = 85
        loc_oPgf.Left   = -1
        loc_oPgf.Width  = THIS.Width + 2
        loc_oPgf.Height = THIS.Height - 85
        loc_oPgf.Tabs   = .F.

        *-- Page1: parametros de impressao (checkboxes nas fases seguintes)
        loc_oPgf.Page1.Caption   = "Par" + CHR(226) + "metros"
        loc_oPgf.Page1.FontName  = "Tahoma"
        loc_oPgf.Page1.FontSize  = 8
        IF TYPE("gc_4c_CaminhoIcones") = "C" AND !EMPTY(gc_4c_CaminhoIcones)
            loc_oPgf.Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDIF
        loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

        *-- Page2: reservada (mantida para consistencia com o padrao do sistema)
        loc_oPgf.Page2.Caption   = "Dados"
        loc_oPgf.Page2.FontName  = "Tahoma"
        loc_oPgf.Page2.FontSize  = 8
        IF TYPE("gc_4c_CaminhoIcones") = "C" AND !EMPTY(gc_4c_CaminhoIcones)
            loc_oPgf.Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDIF
        loc_oPgf.Page2.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page2.ForeColor = RGB(90, 90, 90)

        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - CommandGroup de botoes de relatorio
    *   Padrao frmrelatorio framework.vcx: cmg_4c_Botoes.ButtonCount = 4
    *   Geometria: Top=0, Left=529, Width=273, Height=80 (sobre cabecalho)
    *   Botoes: Visualizar(1), Imprimir(2), Excel(3), Encerrar(4/Cancel)
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
                .Top             = 5
                .Left            = 5
                .Width           = 65
                .Height          = 70
                .Caption         = "Visualizar"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
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

            WITH .Buttons(3)
                .Top             = 5
                .Left            = 137
                .Width           = 65
                .Height          = 70
                .Caption         = "\<Arquivos Email"
                .WordWrap        = .T.
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Arquivos Email"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(4)
                .Top             = 5
                .Left            = 203
                .Width           = 65
                .Height          = 70
                .Caption         = "Encerrar"
                .WordWrap        = .T.
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
    * ConfigurarPaginaLista - Adiciona opcoes de impressao ao form flat
    *   Original SIGREDCT: 2 checkboxes (ImpTotal, ImpCodBarra) no form flat.
    *   Posicoes EXATAS do original: ImpTotal.Top=90, ImpCodBarra.Top=108.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        TRY
            *-- Checkbox: Imprimir com Totalizacao (padrao: marcado)
            THIS.AddObject("chk_4c_ImpTotal", "CheckBox")
            WITH THIS.chk_4c_ImpTotal
                .Top       = 90
                .Left      = 24
                .Width     = 200
                .Height    = 17
                .Caption   = "ImprimirTotaliza" + CHR(231) + CHR(227) + "o"
                .Value     = 1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Themes    = .F.
                .Visible   = .T.
            ENDWITH

            *-- Checkbox: Imprimir somente Codigo de Barras (padrao: desmarcado)
            THIS.AddObject("chk_4c_ImpCodBarra", "CheckBox")
            WITH THIS.chk_4c_ImpCodBarra
                .Top       = 108
                .Left      = 24
                .Width     = 220
                .Height    = 17
                .Caption   = "Imprimir somente Cod. de Barras"
                .Value     = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Themes    = .F.
                .Visible   = .T.
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2 do PageFrame
    *   Formulario frmrelatorio SigReDct e FLAT: checkboxes ficam no form.
    *   Page2 e reservada para consistencia arquitetural do pipeline multi-fase.
    *   Configura as propriedades visuais de Page2 (background, fonte, cores)
    *   para garantir que a pagina nao exiba visual discrepante caso seja ativada.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page2

            loc_oPg.BackColor = RGB(255, 255, 255)
            loc_oPg.ForeColor = RGB(90, 90, 90)
            loc_oPg.FontName  = "Tahoma"
            loc_oPg.FontSize  = 8
            IF TYPE("gc_4c_CaminhoIcones") = "C" AND !EMPTY(gc_4c_CaminhoIcones)
                loc_oPg.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            ENDIF

            *-- Label informativo: relatorio plano, dados gerados em PrepararDados
            loc_oPg.AddObject("lbl_4c_InfoDados", "Label")
            WITH loc_oPg.lbl_4c_InfoDados
                .Top       = 10
                .Left      = 20
                .Width     = 600
                .Height    = 18
                .Caption   = "Dados gerados automaticamente pelo BO ao Visualizar/Imprimir."
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Ativa a pagina solicitada no PageFrame
    *   Form de relatorio: possui apenas Page1 (parametros de impressao).
    *   Aceita o numero da pagina, valida range e reposiciona foco no
    *   primeiro controle disponivel.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nDestino, loc_oPgf
        TRY
            loc_oPgf = THIS.pgf_4c_Paginas
            IF VARTYPE(loc_oPgf) != "O"
                RETURN
            ENDIF
            IF PCOUNT() = 0 OR VARTYPE(par_nPagina) != "N"
                loc_nDestino = 1
            ELSE
                loc_nDestino = par_nPagina
            ENDIF
            IF loc_nDestino < 1
                loc_nDestino = 1
            ENDIF
            IF loc_nDestino > loc_oPgf.PageCount
                loc_nDestino = loc_oPgf.PageCount
            ENDIF
            loc_oPgf.ActivePage = loc_nDestino
            IF PEMSTATUS(THIS, "chk_4c_ImpTotal", 5)
                THIS.chk_4c_ImpTotal.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AlternarPagina")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Copia valores dos controles para propriedades do BO
    *   Sincroniza opcoes de impressao selecionadas no form com o BO antes
    *   de cada chamada a Visualizar() ou Imprimir().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        TRY
            WITH THIS.this_oRelatorio
                .this_nImpTotal    = THIS.chk_4c_ImpTotal.Value
                .this_nImpCodBarra = THIS.chk_4c_ImpCodBarra.Value
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro FormParaRelatorio")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Restaura opcoes de impressao para valores padrao
    *   Padrao: ImpTotal=1 (com totalizacao), ImpCodBarra=0
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        TRY
            THIS.chk_4c_ImpTotal.Value    = 1
            THIS.chk_4c_ImpCodBarra.Value = 0
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualiza relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        TRY
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.Visualizar()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Imprime relatorio na impressora com dialogo de selecao
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        TRY
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.Imprimir()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Exporta dados do cursor de relatorio para arquivo XLS
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        LOCAL loc_cArquivo, loc_cCursor
        TRY
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.PrepararDados()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                RETURN
            ENDIF
            loc_cCursor = THIS.this_oRelatorio.this_cCursorDados
            IF !USED(loc_cCursor) OR RECCOUNT(loc_cCursor) = 0
                MsgAviso("Nenhum dado encontrado para exportar.", "Excel")
                RETURN
            ENDIF
            loc_cArquivo = PUTFILE("Salvar como...", "SigReDct", "XLS")
            IF !EMPTY(loc_cArquivo)
                SELECT (loc_cCursor)
                COPY TO (loc_cArquivo) TYPE XLS
                MsgInfo("Arquivo exportado com sucesso:" + CHR(13) + loc_cArquivo, "Excel")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkImpTotalClick - Mantem checkboxes mutuamente exclusivos
    *   Original ImpTotal.Click: If Value=1 Then impCodBarra.Value=0
    *--------------------------------------------------------------------------
    PROCEDURE ChkImpTotalClick()
        TRY
            IF THIS.chk_4c_ImpTotal.Value = 1
                THIS.chk_4c_ImpCodBarra.Value = 0
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkImpCodBarraClick - Mantem checkboxes mutuamente exclusivos
    *   Original ImpCodBarra.Valid: If Value=1 Then ImpTotal.Value=0
    *--------------------------------------------------------------------------
    PROCEDURE ChkImpCodBarraClick()
        TRY
            IF THIS.chk_4c_ImpCodBarra.Value = 1
                THIS.chk_4c_ImpTotal.Value = 0
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * MAPEAMENTO CRUD -> REPORT
    * Forms de relatorio nao tem operacoes CRUD. Os metodos abaixo traduzem
    * os conceitos CRUD para a semantica deste formulario de impressao.
    *==========================================================================

    PROCEDURE BtnIncluirClick()
        TRY
            THIS.LimparCampos()
            THIS.chk_4c_ImpTotal.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE BtnAlterarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnExcluirClick()
        MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + ;
            "vel em relat" + CHR(243) + "rios." + CHR(13) + ;
            "Use Visualizar ou Imprimir para gerar o relat" + CHR(243) + "rio.", ;
            "Aten" + CHR(231) + CHR(227) + "o")
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.BtnSairClick()
    ENDPROC

    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    PROCEDURE BtnCancelarClick()
        TRY
            THIS.LimparCampos()
            THIS.chk_4c_ImpTotal.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    PROTECTED PROCEDURE BOParaForm()
        THIS.LimparCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Em relatorios, Buscar equivale a Visualizar
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita controles conforme estado
    *   Em formularios de relatorio flat os controles estao sempre habilitados.
    *   Metodo existe para compatibilidade com o padrao FormBase.
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar
        TRY
            loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
            IF PEMSTATUS(THIS, "chk_4c_ImpTotal", 5)
                THIS.chk_4c_ImpTotal.Enabled = loc_lHabilitar
            ENDIF
            IF PEMSTATUS(THIS, "chk_4c_ImpCodBarra", 5)
                THIS.chk_4c_ImpCodBarra.Enabled = loc_lHabilitar
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Em relatorios nao ha lista de registros (grid)
    *   Metodo existe para compatibilidade com o padrao FormBase.
    *   Para este relatorio: garante que as opcoes de impressao estao no estado
    *   padrao (ImpTotal marcado, ImpCodBarra desmarcado).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        THIS.LimparCampos()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Em relatorios nao ha modos CRUD
    *   Metodo existe para compatibilidade com o padrao FormBase.
    *   O CommandGroup cmg_4c_Botoes permanece inalterado (sempre habilitado).
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
            THIS.cmg_4c_Botoes.Visible = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera BO e delega ao FormBase
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
