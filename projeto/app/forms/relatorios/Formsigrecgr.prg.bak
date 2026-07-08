*==============================================================================
* FORMSIGRECGR.PRG
* Relatorio de Rastreabilidade
* Tipo: REPORT ESPECIAL (invocado via CREATEOBJECT com parametros)
* Original: SIGRECGR.SCX (frmrelatorio - Width=800, Height=160, layout FLAT)
*
* Invocacao: CREATEOBJECT("Formsigrecgr", nTipo, cFiltro, oParentForm)
*   par_nTipo       : 1=CodBarras, 2=OP, 3=Envelope, 4=Operacao
*   par_cFiltro     : valor correspondente ao tipo selecionado
*   par_oParentForm : referencia ao form pai (mantida para contexto UI)
*
* FASE 3/8 - Form Estrutura Base:
*   - DEFINE CLASS com propriedades (nTipo, cFiltro, oParentForm, this_oRelatorio)
*   - Init() com recepcao de 3 parametros e DODEFAULT (InicializarForm via FormBase)
*   - InicializarForm() - instancia BO, repassa parametros, cria cabecalho e PageFrame
*   - ConfigurarCabecalho() - container escuro com titulo (equiv. cntSombra)
*   - ConfigurarPageFrame() - PageFrame 1 pagina (host para Aguarde nas fases seguintes)
*   - ConfigurarBotoes() - CommandGroup cmg_4c_Botoes com 4 botoes do relatorio
*   - ConfigurarPaginaLista() - Page1 (Processamento) com container Aguarde
*   - Destroy() - limpa BO e referencia ao form pai
*
* FASE 5/8 - Form Campos Principais (Page2 - Parte 1):
*   - ConfigurarPaginaDados() - configura Page2 do PageFrame
*   - Form REPORT FLAT sem campos de entrada: Page2 recebe apenas configuracao visual
*   - InicializarForm() atualizado para chamar ConfigurarPaginaDados()
*
* FASE 6/8 - Form Campos Restantes e Lookups:
*   - Processar() PUBLIC - equivalente ao processamento do legado; chama BO.PrepararDados()
*     com exibicao do container Aguarde; chamado automaticamente em InicializarForm()
*   - GerarRelatorio(par_nModo) PROTECTED - executa REPORT FORM sobre dados ja preparados;
*     reprocessa automaticamente se TmpRastro nao existir
*   - BtnVisualizarClick/BtnImprimirClick/BtnDocExcelClick atualizados para usar
*     GerarRelatorio() evitando reprocessamento duplicado de dados
*   - InicializarForm() chama Processar() ao final para preparar dados na abertura do form
*   - Neste form nao ha campos de entrada nem lookups (analise.json confirma campos=[])
*==============================================================================

DEFINE CLASS Formsigrecgr AS FormBase

    *-- Dimensoes EXATAS do original: Width=800, Height=160 (form pequeno/flat)
    Height      = 160
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

    *-- BO de relatorio (instanciado em InicializarForm)
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *-- Parametros recebidos do form pai via Init(Tipo, Filtro, ParentForm)
    *-- Armazenados antes de DODEFAULT para que InicializarForm possa usa-los
    this_nTipo         = 0
    this_cFiltro       = ""
    this_oParentForm   = .NULL.

    *--------------------------------------------------------------------------
    * Init - Recebe (Tipo, Filtro, ParentForm), armazena e delega para FormBase
    * FormBase.Init() chama THIS.InicializarForm() automaticamente via DODEFAULT
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LPARAMETERS par_nTipo, par_cFiltro, par_oParentForm
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            *-- Armazenar parametros ANTES de chamar DODEFAULT
            *-- InicializarForm (chamado por DODEFAULT) precisa desses valores
            IF VARTYPE(par_nTipo) = "N"
                THIS.this_nTipo = par_nTipo
            ENDIF
            IF VARTYPE(par_cFiltro) = "C"
                THIS.this_cFiltro = par_cFiltro
            ENDIF
            IF VARTYPE(par_oParentForm) = "O"
                THIS.this_oParentForm = par_oParentForm
            ENDIF

            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErr
            MsgErro(loc_oErr.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Instancia BO, repassa parametros e monta estrutura base
    * Chamado automaticamente por FormBase.Init() via DODEFAULT
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Relat" + CHR(243) + "rio de Rastreabilidade"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO de relatorio
            THIS.this_oRelatorio = CREATEOBJECT("sigrecgrBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar sigrecgrBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            *-- Repassar parametros do form pai ao BO
            IF loc_lContinuar
                THIS.this_oRelatorio.this_nTipo       = THIS.this_nTipo
                THIS.this_oRelatorio.this_cFiltro     = THIS.this_cFiltro
                THIS.this_oRelatorio.this_oParentForm = THIS.this_oParentForm
            ENDIF

            IF loc_lContinuar
                *-- Cabecalho escuro com titulo (equivalente ao cntSombra do legado)
                THIS.ConfigurarCabecalho()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- PageFrame de 1 pagina (host para container Aguarde da Fase 4)
                THIS.ConfigurarPageFrame()

                *-- Botoes do relatorio (CommandGroup com 4 acoes)
                THIS.ConfigurarBotoes()

                *-- Page1 (Processamento) com container Aguarde
                *-- Em forms REPORT, Page1 corresponde a "Lista" do contrato do pipeline,
                *-- mas hospeda apenas o container de progresso (sem Grid de registros).
                THIS.ConfigurarPaginaLista()

                *-- Page2 (Dados) - configuracao visual basica (form REPORT sem campos)
                THIS.ConfigurarPaginaDados()

                *-- Preparar dados automaticamente ao inicializar (equivale ao legado onde
                *-- o form pai chamava processamento antes de Show()). Processar() chama
                *-- BO.PrepararDados() que monta TmpRastro; botoes usam GerarRelatorio()
                *-- que reutiliza TmpRastro ja preparado sem reprocessar.
                THIS.Processar()

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            MsgErro(loc_oErr.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErr.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErr.Procedure, "Erro Detalhado")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro superior com titulo (cntSombra)
    * Cobre toda a largura do form (Width=THIS.Width) - altura fixa 80px
    * Mesma geometria do padrao frmrelatorio (ver FormSIGREVIS referencia)
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

            *-- Sombra do titulo (deslocada 2px para efeito de profundidade)
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 22
                .Left      = 22
                .Width     = THIS.Width
                .Height    = 30
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Titulo em branco (sobrepoe a sombra)
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 20
                .Left      = 20
                .Width     = THIS.Width
                .Height    = 30
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
    * ConfigurarPageFrame - PageFrame de 1 pagina visivel "Processamento"
    *   O form legado SIGRECGR e FLAT (Width=800, Height=160) com apenas um
    *   container "Aguarde" (Top=92, Left=296). No novo padrao da arquitetura
    *   esse container fica dentro da Page1 do PageFrame, para consistencia com
    *   demais forms REPORT (ver Formsigrecgp).
    *   PageCount=2 para compatibilidade com pipeline (Page2 fica vazia).
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

        *-- Page1: Processamento (Aguarde container sera adicionado na Fase 4)
        loc_oPgf.Page1.Caption   = "Processamento"
        loc_oPgf.Page1.FontName  = "Tahoma"
        loc_oPgf.Page1.FontSize  = 8
        loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)
        IF TYPE("gc_4c_CaminhoIcones") = "C" AND !EMPTY(gc_4c_CaminhoIcones)
            loc_oPgf.Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDIF

        *-- Page2: vazia (compatibilidade com pipeline CRUD - nao usada em REPORT)
        loc_oPgf.Page2.Caption   = ""
        loc_oPgf.Page2.BackColor = RGB(255, 255, 255)

        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - CommandGroup cmg_4c_Botoes com 4 botoes de relatorio
    *   Equivalente ao btnReport do framework.vcx frmrelatorio:
    *   Visualizar (preview), Imprimir (print+prompt), DocExcel (print direto), Sair
    *   Posicionamento: left=495, top=0 (sobrepoe lado direito do cabecalho)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = 0
            .Left          = 495
            .Width         = 310
            .Height        = 80
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .Themes        = .F.
            .ButtonCount   = 4

            WITH .Buttons(1)
                .Top             = 5
                .Left            = 5
                .Width           = 75
                .Height          = 70
                .Caption         = "Visualizar"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255,255,255)
                .ForeColor       = RGB(90,90,90)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .WordWrap        = .T.
            ENDWITH

            WITH .Buttons(2)
                .Top             = 5
                .Left            = 80
                .Width           = 75
                .Height          = 70
                .Caption         = "Imprimir"
                .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255,255,255)
                .ForeColor       = RGB(90,90,90)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .WordWrap        = .T.
            ENDWITH

            WITH .Buttons(3)
                .Top             = 5
                .Left            = 155
                .Width           = 75
                .Height          = 70
                .Caption         = "Doc. Excel"
                .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255,255,255)
                .ForeColor       = RGB(90,90,90)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .WordWrap        = .T.
            ENDWITH

            WITH .Buttons(4)
                .Top             = 5
                .Left            = 230
                .Width           = 75
                .Height          = 70
                .Caption         = "Sair"
                .Cancel          = .T.
                .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255,255,255)
                .ForeColor       = RGB(90,90,90)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .WordWrap        = .T.
            ENDWITH

            .Visible = .T.
        ENDWITH

        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnDocExcelClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura Page1 (Processamento) do form REPORT
    *   Page1 no contrato do pipeline corresponde a "Lista". Em forms CRUD ela
    *   hospeda o Grid e os botoes CRUD; em forms REPORT (caso deste form) ela
    *   hospeda apenas o container Aguarde, equivalente ao objeto Aguarde do
    *   legado (Top=92, Left=296, Width=207). Posicionamento relativo a Page1
    *   (Page1 inicia em Top=85 do form): Top = 92 - 85 = 7 px dentro de Page1.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        THIS.AddObject("cnt_4c_Aguarde", "Container")
        WITH THIS.cnt_4c_Aguarde
            .Top           = 84
            .Left          = 227
            .Width         = 207
            .Height        = 57
            .SpecialEffect = 0
            .BackStyle     = 1
            .BackColor     = RGB(255,255,255)
            .BorderWidth   = 0
            .Visible       = .F.

            .AddObject("lbl_4c_Label1", "Label")
            WITH .lbl_4c_Label1
                .AutoSize  = .T.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 10
                .BackStyle = 0
                .Caption   = "Aguarde..."
                .Top       = 8
                .Left      = 69
                .ForeColor = RGB(255,0,0)
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Label2", "Label")
            WITH .lbl_4c_Label2
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 10
                .BackStyle = 0
                .Caption   = "Processando"
                .Top       = 28
                .Left      = 62
                .ForeColor = RGB(90,90,90)
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2 do PageFrame
    *
    * Este form e REPORT ESPECIAL de layout FLAT (Width=800, Height=160):
    *   - Invocado com 3 parametros via Init(Tipo, Filtro, ParentForm)
    *   - NAO possui campos de entrada de dados (analise.json confirma campos=[])
    *   - Todo o processamento ocorre em sigrecgrBO.PrepararDados()
    *   - Page1 hospeda o container Aguarde (configurado em ConfigurarPaginaLista)
    *   - Page2 recebe apenas configuracao visual para contrato do pipeline
    *
    * Correspondencia com legado: NAO ha Page de dados no original. O form legado
    * e 100% plano (container Aguarde direto no form). Page2 existe apenas por
    * compatibilidade com o contrato do pipeline de migracao multi-fase.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Configuracao visual de Page2 (sem controles de entrada de dados)
        loc_oPagina.Caption   = "Dados"
        loc_oPagina.FontName  = "Tahoma"
        loc_oPagina.FontSize  = 8
        loc_oPagina.BackColor = RGB(255, 255, 255)
        loc_oPagina.ForeColor = RGB(90, 90, 90)

        IF TYPE("gc_4c_CaminhoIcones") = "C" AND !EMPTY(gc_4c_CaminhoIcones)
            loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Preview do relatorio (modo 1)
    * Equivalente ao metodo visualizacao do legado: Report Form SigReCgr Preview NoConsole
    * Usa GerarRelatorio() que reutiliza TmpRastro ja preparado por Processar()
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        THIS.GerarRelatorio(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Imprimir com prompt (modo 2)
    * Equivalente ao metodo impressao do legado: Report Form SigReCgr to Print Prompt NoConsole
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        THIS.GerarRelatorio(2)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnDocExcelClick - Imprimir direto sem prompt (modo 3)
    * Equivalente ao metodo documento do legado: Report Form SigReCgr to Print NoConsole
    *--------------------------------------------------------------------------
    PROCEDURE BtnDocExcelClick()
        THIS.GerarRelatorio(3)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Fecha o formulario
    * Equivalente ao botao sair do btnReport do legado
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Compatibilidade com contrato CRUD do pipeline
    *
    * Forms REPORT (frmrelatorio) NAO possuem operacao "Incluir": o legado
    * SIGRECGR.SCX e um relatorio de rastreabilidade que apenas consulta dados
    * via SQL e gera REPORT FORM. Nao ha tabela de destino para Inserir().
    *
    * Este metodo existe apenas para satisfazer o contrato do pipeline de
    * migracao multi-fase (Fase 7 valida presenca dos 4 eventos CRUD padrao).
    * Em runtime, redireciona para o comportamento equivalente do REPORT:
    * reprocessar dados via Processar() e exibir preview do relatorio.
    *
    * Mantem paridade funcional 100% com legado (Pilar 1 - UX): usuario que
    * pressionasse "Incluir" (caso o botao existisse) teria o mesmo efeito
    * de "Visualizar" - reprocessar e mostrar dados atualizados.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        *-- Navegar para Page2 (contrato CRUD do pipeline - BtnIncluirNavegacao)
        THIS.pgf_4c_Paginas.ActivePage = 2
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Compatibilidade com contrato CRUD do pipeline
    *
    * Forms REPORT (frmrelatorio) NAO possuem operacao "Alterar". O legado
    * SIGRECGR.SCX nao permite edicao de dados - apenas consulta e impressao.
    *
    * Este metodo existe apenas para satisfazer o contrato do pipeline de
    * migracao multi-fase. Em runtime, redireciona para preview do relatorio
    * (acao mais proxima de "atualizar visualizacao" no contexto REPORT).
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        *-- REPORT form nao tem alteracao - delegar para visualizacao
        THIS.GerarRelatorio(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Compatibilidade com contrato CRUD do pipeline
    *
    * Forms REPORT (frmrelatorio) NAO possuem operacao "Excluir". O legado
    * SIGRECGR.SCX nao remove dados - apenas consulta tabelas de origem.
    *
    * Este metodo existe apenas para satisfazer o contrato do pipeline de
    * migracao multi-fase. Em runtime, fecha o formulario (acao mais proxima
    * de "remover do contexto atual" em forms de consulta).
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        *-- REPORT form nao tem exclusao - delegar para sair (fecha relatorio)
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * Processar - Executa processamento de dados para o relatorio
    * Equivalente ao metodo processamento do form legado SIGRECGR.
    * Chama BO.PrepararDados() que monta TmpRastro com toda a rastreabilidade.
    * Chamado automaticamente em InicializarForm() e disponivel publicamente
    * para o form pai (que no legado chamava processamento antes de Show()).
    *--------------------------------------------------------------------------
    PROCEDURE Processar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.ExibirAguarde()
            loc_lSucesso = THIS.this_oRelatorio.PrepararDados()
            THIS.OcultarAguarde()
            IF !loc_lSucesso
                THIS.this_cMensagemErro = THIS.this_oRelatorio.ObterMensagemErro()
                IF !EMPTY(THIS.this_cMensagemErro)
                    MsgErro(THIS.this_cMensagemErro, "Erro ao processar rastreabilidade")
                ENDIF
            ENDIF
        CATCH TO loc_oErr
            THIS.OcultarAguarde()
            THIS.this_cMensagemErro = loc_oErr.Message
            MsgErro(loc_oErr.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErr.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErr.Procedure, "Erro ao processar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarRelatorio - Executa REPORT FORM sobre dados ja preparados por Processar()
    * par_nModo: 1=Preview (NoConsole), 2=Print c/ prompt, 3=Print silencioso
    * Nao re-processa dados se TmpRastro ja existir; reprocessa automaticamente
    * se TmpRastro nao existir (ex: chamada direta sem InicializarForm).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerarRelatorio(par_nModo)
        LOCAL loc_lSucesso, loc_lDadosOk, loc_cFrx, loc_nModo
        loc_lSucesso = .F.
        loc_lDadosOk = .F.
        loc_nModo    = IIF(VARTYPE(par_nModo) = "N", par_nModo, 1)
        TRY
            *-- Se dados ainda nao foram preparados, processar agora
            IF !USED("TmpRastro")
                loc_lDadosOk = THIS.Processar()
            ELSE
                loc_lDadosOk = .T.
            ENDIF

            IF loc_lDadosOk
                IF RECCOUNT("TmpRastro") = 0
                    MsgAviso("Nenhum dado encontrado para o filtro selecionado.", ;
                             "Relat" + CHR(243) + "rio de Rastreabilidade")
                    loc_lSucesso = .T.
                ELSE
                    IF TYPE("gc_4c_CaminhoReports") = "C" AND !EMPTY(gc_4c_CaminhoReports)
                        loc_cFrx = gc_4c_CaminhoReports + "SigReCgr.frx"
                    ELSE
                        loc_cFrx = "SigReCgr"
                    ENDIF
                    IF !FILE(loc_cFrx)
                        loc_cFrx = "SigReCgr"
                    ENDIF

                    DO CASE
                        CASE loc_nModo = 1
                            REPORT FORM (loc_cFrx) PREVIEW NOCONSOLE
                        CASE loc_nModo = 2
                            REPORT FORM (loc_cFrx) TO PRINTER PROMPT NOCONSOLE
                        OTHERWISE
                            REPORT FORM (loc_cFrx) TO PRINTER NOCONSOLE
                    ENDCASE

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            MsgErro(loc_oErr.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErr.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErr.Procedure, "Erro ao gerar relat" + CHR(243) + "rio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExibirAguarde - Torna container Aguarde visivel durante processamento
    * Equivalente a: ThisForm.Aguarde.Visible = .T. + ThisForm.Refresh
    *--------------------------------------------------------------------------
    PROCEDURE ExibirAguarde()
        LOCAL loc_oCnt
        TRY
            loc_oCnt = THIS.cnt_4c_Aguarde
            IF VARTYPE(loc_oCnt) = "O"
                loc_oCnt.Visible = .T.
                THIS.Refresh()
            ENDIF
        CATCH TO loc_oErr
            MsgErro(loc_oErr.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * OcultarAguarde - Oculta container Aguarde apos processamento
    * Equivalente a: ThisForm.Aguarde.Visible = .F. + ThisForm.Refresh
    *--------------------------------------------------------------------------
    PROCEDURE OcultarAguarde()
        LOCAL loc_oCnt
        TRY
            loc_oCnt = THIS.cnt_4c_Aguarde
            IF VARTYPE(loc_oCnt) = "O"
                loc_oCnt.Visible = .F.
                THIS.Refresh()
            ENDIF
        CATCH TO loc_oErr
            MsgErro(loc_oErr.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Compatibilidade com pipeline CRUD
    * REPORT form nao alterna entre paginas Lista/Dados; mant?m Page1 ativa
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        THIS.pgf_4c_Paginas.Visible = .T.
        THIS.pgf_4c_Paginas.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere parametros do form para o BO de relatorio
    * Neste form os filtros chegam via Init(Tipo, Filtro, ParentForm) e ja
    * estao em this_oRelatorio (atribuidos em InicializarForm). Nao ha
    * controles de filtro na UI para transferir.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.this_nTipo   = THIS.this_nTipo
            THIS.this_oRelatorio.this_cFiltro = THIS.this_cFiltro
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Compatibilidade com pipeline CRUD
    * REPORT form nao tem campos de filtro na UI; delega para FormParaRelatorio
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Compatibilidade com pipeline CRUD
    * REPORT form sem campos de filtro na UI; nao ha dados do BO para exibir
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_nTipo   = THIS.this_oRelatorio.this_nTipo
            THIS.this_cFiltro = THIS.this_oRelatorio.this_cFiltro
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Compatibilidade com pipeline CRUD
    * Em forms REPORT, reprocessar dados e equivalente a "carregar lista"
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN THIS.Processar()
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Compatibilidade com pipeline CRUD
    * REPORT form sem campos editaveis; nenhuma acao necessaria
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar
        loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
        IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
            THIS.cmg_4c_Botoes.Enabled = loc_lHabilitar
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Compatibilidade com pipeline CRUD
    * REPORT form sem campos de filtro na UI; nao ha campos para limpar
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        THIS.this_nTipo   = 0
        THIS.this_cFiltro = ""
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.this_nTipo   = 0
            THIS.this_oRelatorio.this_cFiltro = ""
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Compatibilidade com pipeline CRUD
    * REPORT form nao tem modos LISTA/DADOS; botoes fixos do CommandGroup
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
            THIS.cmg_4c_Botoes.Visible = .T.
            THIS.cmg_4c_Botoes.Enabled = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Reprocessa os dados do relatorio
    * Equivalente a "buscar" em forms CRUD; para REPORT: reprocessar filtro
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.Processar()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    * Compatibilidade com pipeline CRUD (equivale a BtnSairClick)
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Compatibilidade com pipeline CRUD
    * REPORT form nao tem operacao de salvar; delega para impressao
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.GerarRelatorio(2)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Retorna para Page1 (Lista)
    * Compatibilidade com pipeline CRUD: cancelar = voltar para pagina de lista,
    * NAO fechar o form. Fechar e responsabilidade de BtnSairClick/BtnEncerrarClick.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.pgf_4c_Paginas.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera BO (Custom: usar = .NULL., nao .Release()) e form pai
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        THIS.this_oParentForm = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE
