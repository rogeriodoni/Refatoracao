*==============================================================================
* FormSigReJob.PRG
* Relatorio de Briefing do Job (SigReJob)
* Tipo: REPORT - sub-form filho de FormJob (recebe pFrm no Init)
*
* Migrado de: SigReJob.SCX (frmrelatorio)
*
* Estrutura:
*   - Form FLAT: Width=800, Height=130 (apenas cabecalho + 4 botoes)
*   - Sem campos de filtro/entrada - dados vem de cursores do ParentForm
*   - Dois relatorios em passagens: crImpressao (pass.1) e crImpressa2 (pass.2)
*   - SigReJobBO gerencia PrepararDados, Visualizar, Imprimir, ImprimirDireto
*
* FASE 7/8 CONCLUIDA - Form - Eventos Principais
*   RESULTADO: Eventos principais de relatorio ja estavam implementados desde
*   a Fase 4 (ConfigurarBotoes). FormSigReJob e um frmrelatorio (sub-form do
*   FormJob), NAO um form CRUD - portanto NAO tem BtnIncluirClick/BtnAlterarClick
*   /BtnExcluirClick. Os equivalentes para forms REPORT sao:
*     CmgBotoesClick     - roteador central do CommandGroup
*     BtnVisualizarClick - REPORT FORM ... PREVIEW (passagens 1 e 2)
*     BtnImprimirClick   - REPORT FORM ... TO PRINTER PROMPT (passagens 1 e 2)
*     BtnArquivosClick   - REPORT FORM ... TO PRINTER NoConsole (passagens 1 e 2)
*     BtnSairClick       - THIS.Release()
*   Todos implementados e funcionais abaixo.
*
* FASE 8/8 CONCLUIDA - Form - Eventos Auxiliares e Consolidacao Final
*   RESULTADO: Adicionados metodos canonicos do pipeline adaptados para form REPORT FLAT:
*     FormParaBO()         - alias para FormParaRelatorio() (sem campos de filtro)
*     BOParaForm()         - atualiza caption dinamico a partir do ParentForm
*     HabilitarCampos()    - controla Enabled do cmg_4c_Botoes
*     LimparCampos()       - reabilita botoes (sem campos de entrada)
*     CarregarLista()      - Refresh() (sem grid de lista)
*     AjustarBotoesPorModo() - garante botoes habilitados (sem alternancia de modo)
*     BtnBuscarClick()     - delega para BtnVisualizarClick()
*     BtnEncerrarClick()   - delega para BtnSairClick()
*     BtnSalvarClick()     - delega para BtnImprimirClick()
*     BtnCancelarClick()   - delega para BtnSairClick()
*
* FASE 6/8 CONCLUIDA - Form - Campos Restantes e Lookups
*   RESULTADO: ConfigurarPaginaDados() corretamente vazio - form FLAT nao tem
*   Page2 de dados nem campos de entrada. O SCX original (Width=800, Height=130)
*   nao tinha TextBox, ComboBox, CheckBox nem lookups F4/F5. Nao ha campos
*   "restantes" a adicionar nem botoes Salvar/Cancelar (inexistentes no legado).
*   Toda a logica de selecao de dados esta em SigReJobBO.PrepararDadosInterno().
*
* IMPLEMENTACAO COMPLETA (Fases 3-7):
*   * DEFINE CLASS com todas as propriedades (this_oRelatorio, this_oParentFormRef)
*   * Init(par_oParentForm) - recebe form pai, compartilha datasession
*   * InicializarForm() - caption dinamico, cria SigReJobBO, chama Inicializar(pai)
*   * ConfigurarPageFrame() / ConfigurarPaginaLista() - layout FLAT
*   * ConfigurarPaginaDados() - no-op (nao ha Page2 nem campos de entrada)
*   * ConfigurarCabecalho() - cnt_4c_Cabecalho com titulo dinamico
*   * ConfigurarBotoes() - cmg_4c_Botoes com 4 botoes (Visualizar/Imprimir/Arquivos/Sair)
*   * CmgBotoesClick, BtnVisualizarClick, BtnImprimirClick, BtnArquivosClick, BtnSairClick
*   * FormParaRelatorio() - no-op (sem campos de filtro)
*   * Destroy() - limpa referencias ao BO e ao ParentForm
*==============================================================================

DEFINE CLASS FormSigReJob AS FormBase

    *-- Dimensoes EXATAS do original: Width=800, Height=130
    Height       = 130
    Width        = 800
    DataSession  = 2
    ShowWindow   = 1
    WindowType   = 1
    AutoCenter   = .T.
    BorderStyle  = 2
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Themes       = .F.
    ShowTips     = .T.
    FontName     = "Tahoma"
    FontSize     = 8

    *-- BO do relatorio (SigReJobBO herda RelatorioBase)
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *-- Referencia ao form pai (FormJob ou equivalente) armazenada em Init
    *   antes de DODEFAULT para que InicializarForm() possa usa-la
    this_oParentFormRef = .NULL.

    *--------------------------------------------------------------------------
    * Init - Recebe form pai, compartilha datasession e delega para FormBase
    * par_oParentForm: form que abriu este relatorio (ex: FormJob)
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oParentForm)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            *-- Guardar referencia ao pai antes do DODEFAULT
            *   (InicializarForm usa this_oParentFormRef para configurar o BO)
            THIS.this_oParentFormRef = par_oParentForm

            *-- Usar datasession do pai para acessar TprMvCab, crSigOpCdI etc.
            IF VARTYPE(par_oParentForm) = "O"
                SET DATASESSION TO par_oParentForm.DataSessionId
            ENDIF

            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Monta estrutura do form de relatorio
    *   1. Caption dinamico a partir do form pai (CfgTitJob)
    *   2. Cria SigReJobBO e chama Inicializar(par_oParentForm)
    *   3. Monta cabecalho escuro + CommandGroup de botoes
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            *-- Caption dinamico: "Impressao de <titulo do job>"
            IF VARTYPE(THIS.this_oParentFormRef) = "O"
                THIS.Caption = "Impress" + CHR(227) + "o de " + ;
                               ALLTRIM(THIS.this_oParentFormRef.CfgTitJob)
            ELSE
                THIS.Caption = "Impress" + CHR(227) + "o de Documento"
            ENDIF

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO do relatorio
            THIS.this_oRelatorio = CREATEOBJECT("SigReJobBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SigReJobBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Inicializar BO com referencia ao form pai (carrega CompTits do DB)
            *   Pulado em modo de validacao de UI (sem conexao SQL)
            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                IF !THIS.this_oRelatorio.Inicializar(THIS.this_oParentFormRef)
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            *-- Form REPORT FLAT: nao usa PageFrame de duas paginas.
            *   ConfigurarPageFrame() agrega o layout do form (cabecalho + botoes)
            *   para manter contrato com a arquitetura multi-fase.
            THIS.ConfigurarPageFrame()

            *-- Aplicar caption nos labels do cabecalho
            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

            THIS.Visible    = .T.
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Monta layout principal do form de relatorio
    *   Forms REPORT (frmrelatorio) tem layout FLAT - SEM PageFrame de Lista/Dados.
    *   Delega para ConfigurarPaginaLista() que monta o conteudo equivalente
    *   (cabecalho + CommandGroup de botoes de relatorio) no proprio form.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        *-- Em REPORT FLAT, "PaginaLista" hospeda o conteudo unico do form
        *   (cabecalho + botoes de relatorio). Nao ha PaginaDados nem Grid.
        THIS.ConfigurarPaginaLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Monta o conteudo principal do form REPORT
    *   Em forms CRUD: Page1 tem Grid + Botoes CRUD (Incluir/Alterar/Excluir).
    *   Em forms REPORT (este caso): layout FLAT - sem PageFrame de Lista/Dados,
    *     sem Grid e sem botoes CRUD. O equivalente arquitetural sao:
    *       - cnt_4c_Cabecalho (titulo do relatorio sobre fundo escuro)
    *       - cmg_4c_Botoes    (CommandGroup com Visualizar/Imprimir/Arquivos/Sair)
    *   Este metodo aplica esse layout no proprio form (sem Page intermediaria),
    *   replicando a estrutura do frmrelatorio legado (que tambem nao tinha grid).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        *-- Montar cabecalho escuro com titulo
        THIS.ConfigurarCabecalho()

        *-- Montar CommandGroup com 4 botoes de relatorio
        THIS.ConfigurarBotoes()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2 (campos de edicao) do form CRUD
    *   Em forms CRUD: Page2 tem TextBoxes de edicao, labels, lookups.
    *   Em forms REPORT FLAT (este caso): nao ha Page2 nem campos de parametro
    *     visiveis ao usuario. O SigReJob.SCX original (Width=800, Height=130)
    *     e apenas um painel de botoes sem campos de entrada ? os dados de
    *     impressao vem de cursores do ParentForm (TprMvCab, crSigOpCdI,
    *     crSigMvJbC) via SigReJobBO.Inicializar(par_oParentForm).
    *   Mantido para honrar o contrato arquitetural do pipeline multi-fase.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- REPORT FLAT: sem Page2, sem campos de entrada.
        *   Dados vem de cursores do ParentForm via SigReJobBO.PrepararDados().
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre paginas Lista/Dados (PaginaLista=1, Dados=2)
    *   Em forms CRUD: alterna pgf_4c_Paginas.ActivePage e ajusta botoes via
    *     AjustarBotoesPorModo() ao voltar para Page1.
    *   Em forms REPORT (este caso): layout FLAT - nao ha PageFrame de duas
    *     paginas para alternar. O form exibe apenas o painel de botoes de
    *     relatorio (Visualizar/Imprimir/Arquivos/Sair); nao ha modo INCLUIR
    *     ou ALTERAR. Toda interacao roteia para handlers do cmg_4c_Botoes.
    *   par_nPagina: ignorado em REPORT (mantido para contrato do pipeline)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        *-- REPORT FLAT: nao ha alternancia de pagina. Garantir que o form esta
        *   visivel e focado, equivalente a "estar na pagina principal".
        IF !THIS.Visible
            THIS.Visible = .T.
        ENDIF
        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro superior com titulo do relatorio
    *   Equivalente ao cntSombra do frmrelatorio legado.
    *   Ocupa toda a largura do form (Width = THIS.Width).
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

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 15
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Caption   = ""
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Caption   = ""
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - CommandGroup com 4 botoes de relatorio
    *   Equivalente ao btnReport do frmrelatorio legado.
    *   Buttons(1)=Visualizar, Buttons(2)=Imprimir, Buttons(3)=Arquivos, Buttons(4)=Sair
    *   Left=533 (exato do original: btnReport.Left=533)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = 0
            .Left          = 533
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
                .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(2)
                .Top             = 5
                .Left            = 71
                .Width           = 65
                .Height          = 70
                .Caption         = "Imprimir"
                .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
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
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(3)
                .Top             = 5
                .Left            = 137
                .Width           = 65
                .Height          = 70
                .Caption         = "Arquivos"
                .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
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
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(4)
                .Top             = 5
                .Left            = 203
                .Width           = 65
                .Height          = 70
                .Caption         = "Sair"
                .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
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
                .AutoSize        = .F.
                .Cancel          = .T.
                .Visible         = .T.
            ENDWITH
        ENDWITH

        *-- Vincular clique do CommandGroup ao handler unificado
        BINDEVENT(THIS.cmg_4c_Botoes, "Click", THIS, "CmgBotoesClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * CmgBotoesClick - Roteia clique do CommandGroup para o handler correto
    *   Value=1: Visualizar | Value=2: Imprimir | Value=3: Arquivos | Value=4: Sair
    *--------------------------------------------------------------------------
    PROCEDURE CmgBotoesClick()
        LOCAL loc_nBotao
        loc_nBotao = THIS.cmg_4c_Botoes.Value
        DO CASE
            CASE loc_nBotao = 1
                THIS.BtnVisualizarClick()
            CASE loc_nBotao = 2
                THIS.BtnImprimirClick()
            CASE loc_nBotao = 3
                THIS.BtnArquivosClick()
            CASE loc_nBotao = 4
                THIS.BtnSairClick()
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Exibe os dois relatorios em PREVIEW na tela
    *   Passagem 1 = crImpressao (Jb_003-016), Passagem 2 = crImpressa2 (Jb_017+)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.Visualizar()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro ao Visualizar")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Imprime os dois relatorios com dialogo de impressora
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.Imprimir()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro ao Imprimir")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnArquivosClick - Imprime os dois relatorios direto (sem dialogo)
    *   Equivale ao DocExcel/Arquivos do original: ThisForm.Passagem loop para
    *   Passagem 1 e 2 usando Report Form To Printer NoConsole.
    *   BO.ImprimirDireto() ja executa ambas as passagens em sequencia.
    *--------------------------------------------------------------------------
    PROCEDURE BtnArquivosClick()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.ImprimirDireto()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro ao Imprimir Documento")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Fecha o formulario de relatorio
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere dados do form para o BO antes de imprimir
    *   Este form nao tem campos de filtro; dados vem do ParentForm via BO.
    *   Metodo mantem o contrato arquitetural do pipeline multi-fase.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        *-- Sem campos de parametro neste form.
        *   O BO ja tem referencia ao ParentForm (setada em Inicializar).
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Alias para FormParaRelatorio (contrato arquitetural do pipeline)
    *   Em forms CRUD: transfere campos do form para o BO antes de salvar.
    *   Em forms REPORT FLAT: delega para FormParaRelatorio() (sem campos de filtro;
    *   dados vem de cursores do ParentForm via SigReJobBO.Inicializar).
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Atualiza caption do form refletindo estado atual do ParentForm
    *   Em forms CRUD: popula TextBoxes/ComboBoxes com valores do BO.
    *   Em forms REPORT FLAT: sem campos de entrada. Sincroniza caption com
    *   CfgTitJob do ParentForm caso tenha mudado desde a abertura do form.
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        LOCAL loc_cCaption
        loc_cCaption = ""
        IF VARTYPE(THIS.this_oParentFormRef) = "O"
            loc_cCaption = "Impress" + CHR(227) + "o de " + ;
                           ALLTRIM(THIS.this_oParentFormRef.CfgTitJob)
            IF THIS.Caption != loc_cCaption
                THIS.Caption = loc_cCaption
                IF PEMSTATUS(THIS, "cnt_4c_Cabecalho", 5)
                    THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cCaption
                    THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cCaption
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Controla o estado interativo dos botoes do form
    *   Em forms CRUD: habilita/desabilita TextBoxes, ComboBoxes por modo.
    *   Em forms REPORT FLAT: habilita/desabilita o CommandGroup de botoes.
    *   par_lHabilitar: .T. = habilitar cmg_4c_Botoes, .F. = desabilitar
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        IF PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
            THIS.cmg_4c_Botoes.Enabled = par_lHabilitar
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Reabilita botoes garantindo estado inicial consistente
    *   Em forms CRUD: zera TextBoxes, reseta ComboBoxes para valor default.
    *   Em forms REPORT FLAT: sem campos de entrada. Reabilita cmg_4c_Botoes
    *   para garantir estado funcional apos uma operacao de impressao/preview.
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        THIS.HabilitarCampos(.T.)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Atualiza o form apos alteracao de estado
    *   Em forms CRUD: executa BO.Buscar() e recarrega grd_4c_Lista.
    *   Em forms REPORT FLAT: sem grid. Chama Refresh() para redesenhar o form
    *   e garante que cmg_4c_Botoes esta visivel e habilitado.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        THIS.AjustarBotoesPorModo()
        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Configura botoes conforme o modo operacional
    *   Em forms CRUD: LISTA=CRUD habilitado, DADOS=Salvar/Cancelar habilitados.
    *   Em forms REPORT FLAT: sem alternancia de modo. Os 4 botoes do CommandGroup
    *   (Visualizar/Imprimir/Arquivos/Sair) ficam sempre habilitados - equivalente
    *   ao modo LISTA de um form CRUD onde o usuario pode acionar qualquer operacao.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        IF PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
            THIS.cmg_4c_Botoes.Enabled  = .T.
            THIS.cmg_4c_Botoes.Visible  = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Handler do botao Buscar (CRUD: filtra e recarrega lista)
    *   Em forms REPORT FLAT: sem grid de busca. Aciona Visualizar como operacao
    *   principal de consulta de dados equivalente ao "Buscar" de forms CRUD.
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o form (alias canonico para o botao Encerrar)
    *   Mantem consistencia de nomenclatura com cnt_4c_Saida/cmd_4c_Encerrar
    *   dos forms CRUD. Delega para BtnSairClick().
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.BtnSairClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Handler do botao Salvar/Confirmar (CRUD: persiste dados)
    *   Em forms REPORT FLAT: sem campos de entrada nem persistencia em banco.
    *   Aciona impressao com dialogo (Imprimir) como operacao de "confirmar/gerar"
    *   equivalente ao Salvar de forms CRUD.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Descarta edicao e fecha/retorna ao estado anterior
    *   Em forms CRUD: descarta alteracoes em andamento e volta para lista.
    *   Em forms REPORT FLAT: sem edicao em curso. Fecha o form (ESC),
    *   comportamento identico ao botao Sair.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.BtnSairClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera referencias
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.this_oParentFormRef = .NULL.
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
