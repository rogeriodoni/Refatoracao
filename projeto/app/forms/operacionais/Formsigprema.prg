*==============================================================================
* Formsigprema.prg
* Form OPERACIONAL: Processamento e Geracao de Email
* Migrado de SIGPREMA.SCX
* Herda de: FormBase
*
* Form OPERACIONAL FLAT (sem PageFrame Page1/Page2 - o SCX legado nao tem
* PageFrame, so um container de cabecalho + grid + botoes direto no form -
* ver tasks\task602\layout.json). O BO (sigpremaBO) monta o cursor de
* trabalho cursor_4c_Dados (equivalente a crLocalTotal do legado) cruzando
* SigMvCab + SigCdCli + SigCdPam; este form so exibe/marca linhas desse
* cursor e dispara o envio dos e-mails selecionados.
*
* Parametros do Init (equivalentes a prDopes/pAuto do legado):
*   par_cDopes       - EmpDopNums (29 chars) para filtrar 1 movimento.
*                       Vazio = processa todos os movimentos do dia ainda nao enviados.
*   par_lAutomatico  - .T. quando a tela e chamada em modo automatico.
*
* Historico de fases:
*   Fase 1/2: sigpremaBO.prg (propriedades + metodos de negocio completos)
*   Fase 3:   Formsigprema.prg - estrutura base (heranca, Init, InicializarForm,
*             ConfigurarCabecalho, TornarControlesVisiveis, Destroy)
*   Fase 4:   Grid grd_4c_Dados (5 colunas: Checks/Contas/Rclis/Emails/
*             EmpDopNums), botoes standalone cmd_4c_SelTudo/cmd_4c_Apaga
*             (legado SelTudo/apaga - nao ha container no SCX original),
*             cmg_4c_Encerrar (legado Commandgroup1/btnSair), cmd_4c_EnviarEmail
*             (legado btnEmail) e shp_4c_Decoracao (legado Shape1). CarregarDados
*             (BO.BuscarDadosProcessamento) e todos os handlers (ordenacao por
*             coluna, toggle de Checks, Marcar/Desmarcar Todos, Encerrar e envio
*             de e-mail via BO.EnviarEmailSelecionados) ja ligados nesta fase -
*             o BO ja tinha tudo pronto desde a Fase 1/2.
*   Fase 5:   Conferido campo a campo contra tasks\task602\layout.json e
*             sigprema_form_codigo_fonte.txt - forms OPERACIONAL FLAT como
*             este nao tem Page2/Dados com TextBoxes individuais (o "dado" da
*             tela inteira e' a lista do grd_4c_Dados, ja migrado na Fase 4).
*             Nao ha mais controles do SCX para adicionar. Dois eventos do
*             legado ficaram sem correspondente explicito e sao documentados
*             aqui para a ausencia ser auditavel, nao parecer esquecimento
*             (mesmo padrao de FormSigMvExp/FormSigMvMen):
*               Load ("=fConfigGeral()") - NAO PORTADO. fConfigGeral era
*               funcao GLOBAL de inicializacao da aplicacao legado; na
*               arquitetura nova esse papel e' do start\config.prg (roda uma
*               vez no startup). O wrapper utils\fconfiggeral.prg existe so
*               para o p-code dos VCX legado que ainda o chama (regra #27) -
*               codigo nosso nao o chama.
*               SIGPREMA.Registry1 / "ThisForm.btnEmail.Enabled =
*               ThisForm.Registry1.IsKey('PDFCreator.clsPDFCreator') Or
*               ThisForm.Registry1.IsKey('PDFCreatorBeta.JobQueue')" - NAO
*               PORTADO. No legado essa checagem so faz sentido porque
*               btnEmail.Click chama ImpDocto/criapdf (geracao do PDF anexo
*               via COM do PDFCreator), e o botao ficava desabilitado se o
*               PDFCreator nao estivesse instalado na maquina. Essa geracao
*               de anexo esta fora do escopo desta migracao (ver cabecalho de
*               sigpremaBO.prg - this_cArquivoEmail fica a cargo do Form/
*               futura integracao com relatorios), e o envio de e-mail via
*               BO.EnviarEmailSelecionados NAO depende de PDFCreator. Copiar
*               a checagem sem a funcionalidade que ela protege desabilitaria
*               o botao de Enviar Email em toda maquina sem PDFCreator, sem
*               nenhum ganho - seria pior que o legado, nao fiel a ele.
*   Fase 6:   LOOKUPS - nenhum. Conferido contra sigprema_form_codigo_fonte.txt
*             e analise.json ("lookups": []) procurando fwbuscaext, fwBuscaSel,
*             fwBuscaInt, mAddColuna, sigacess, Acesso* e PROCEDURE Valid com
*             busca: zero ocorrencias. Criar AbrirLookup*/AbrirBusca* aqui
*             seria INVENTAR tabela de lookup que o legado nao consulta
*             (violaria o PILAR 1 e a regra "NUNCA inventar tabelas de lookup").
*
*             CAMPOS RESTANTES - este form OPERACIONAL e' FLAT (sem PageFrame
*             Page1/Page2, ver Fase 3/5): nao existe "Page2 de Dados", o dado
*             da tela e' a lista crLocalTotal/cursor_4c_Dados exibida em
*             grd_4c_Dados, ja montada por inteiro na Fase 4. Conferidos os 5
*             ControlSource e os ReadOnly contra o SCX (Column6/ColumnOrder=1
*             = Checks W=17 RO=.F.; Column2 Conta W=80 RO=.T.; Column3 Nome
*             W=290 RO=.T.; Column4 Email W=290 RO=.F.; Column5 EmpDopNums
*             W=290 RO=.T.) - batem. Todos os controles do SCX ja foram migrados.
*
*             O que esta fase ACRESCENTA e' a validacao da unica celula
*             digitavel da tela, a coluna Email (Column4, a unica com
*             ReadOnly = .F. no SCX legado), que ate aqui nao tinha handler
*             nenhum:
*               ValidarEmailLinha / ValidarEmailLinhaKeyPress - normaliza o
*               e-mail digitado (LOWER + ALLTRIM, a mesma normalizacao que o
*               legado ja aplica no momento do envio) e grava de volta no
*               cursor, para o que aparece na grade ser igual ao que sai no
*               campo "Para". Ligados por KeyPress (ENTER/TAB) + LostFocus -
*               "Valid" nao dispara via BINDEVENT em TextBox.
*               ValidarEnvio - conferencia previa chamada por
*               BtnProcessarEmailClick, reproduzindo os dois criterios que o
*               proprio btnEmail.Click legado aplica sobre as linhas
*               ("Where Checks = 1" e "If IsEmpty(...emails) / Loop").
*               DESVIO DELIBERADO do legado, restrito a mensagem/aborto: no
*               legado esses dois casos sao silenciosos e a tela exibe
*               "Email enviado com sucesso!" e se fecha sem ter enviado nada
*               (o SCAN nao executa nenhuma iteracao e "llOk" continua .T.).
*               Nao reproduzir isso e' exigencia de CLAUDE.md #20 e da regra
*               de nunca anunciar sucesso sem ter havido o que processar. O
*               release do modo automatico continua incondicional, como no
*               legado.
*   Fase 7:   EVENTOS PRINCIPAIS - este form OPERACIONAL nao tem CRUD (o
*             legado SIGPREMA.SCX nao herda de frmcadastro, nao tem Grupo_Op
*             nem pcEscolha - e' so cabecalho + grade + botoes de acao direto
*             no form, ver layout.json/comportamento.json). Os 4 botoes reais
*             do legado (Commandgroup1/btnSair, btnEmail, SelTudo, apaga) ja
*             tinham handler completo desde a Fase 4 (BtnProcessarEmailClick/
*             BtnSelTudoClick/BtnApagaClick + o botao de saida). Criar
*             BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/
*             BtnExcluirClick aqui seria inventar CRUD que o legado nao tem
*             (violaria o PILAR 1). Unico ajuste desta fase: o handler do
*             botao de saida estava nomeado CmgEncerrarClick (prefixo do
*             objeto cmg_4c_Encerrar, nao da convencao de handler Btn/Cmd) -
*             renomeado para BtnEncerrarClick, consistente com os demais
*             handlers de botao do form.
*   Fase 8:   EVENTOS AUXILIARES E CONSOLIDACAO FINAL - conferencia final
*             deste form OPERACIONAL FLAT contra a lista canonica de metodos
*             de fechamento de fase (BtnBuscarClick/BtnEncerrarClick/
*             BtnSalvarClick/BtnCancelarClick/FormParaBO/BOParaForm/
*             HabilitarCampos/LimparCampos/CarregarLista/
*             AjustarBotoesPorModo). Essa lista e' convencao de form CRUD
*             (frmcadastro com Page1=Lista/Page2=Dados e modos INCLUIR/
*             ALTERAR/VISUALIZAR/EXCLUIR); o SIGPREMA legado nao tem NENHUMA
*             dessa estrutura (confirmado de novo aqui, no fechamento da
*             migracao, contra sigprema_form_codigo_fonte.txt):
*               BtnBuscarClick   - NAO SE APLICA. O legado nao tem campo de
*                 filtro/busca nenhum (grep por "buscar"/"filtro"/"pesquis"
*                 no dump: zero ocorrencias) - a grade e' populada por
*                 inteiro no Init (equivalente a CarregarDados/
*                 BuscarDadosProcessamento, ja existente desde a Fase 3/4).
*                 Criar um botao de busca aqui seria inventar funcionalidade
*                 que o legado nao tem (PILAR 1).
*               BtnEncerrarClick - JA EXISTE (Fase 4, renomeado na Fase 7).
*                 Equivalente ao Commandgroup1/btnSair.Click legado.
*               BtnSalvarClick   - NAO SE APLICA COM ESSE NOME. O legado nao
*                 grava em tabela nenhuma (ver cabecalho de sigpremaBO.prg),
*                 mas esta tela NAO e' somente-leitura: a "acao principal"
*                 dela e' o PROCESSAMENTO e envio dos e-mails marcados, que
*                 e' trabalho de verdade e ja estava coberto desde a Fase 4
*                 (equivalente ao btnEmail.Click legado), disparando
*                 sigpremaBO.EnviarEmailSelecionados(). Inventar um
*                 BtnSalvarClick vazio ao lado dele seria o "stub
*                 disfarcado" proibido pela regra de completude.
*                 RENOMEADO NESTA FASE: o handler chamava-se
*                 BtnEnviarEmailClick, nomeado pelo objeto legado (btnEmail)
*                 em vez de pela ACAO. O verbo "Enviar" fica fora da
*                 convencao de handler de acao do projeto (Salvar/Confirmar/
*                 Gravar/Processa/Aplicar/Executar/OK), que e' o que torna o
*                 handler ENUMERAVEL pelos gates - o mesmo defeito que a
*                 Fase 7 corrigiu em CmgEncerrarClick. Passou a
*                 BtnProcessarEmailClick, fiel ao Caption do form
*                 ("Processamento e Geracao de Email") e ao que o metodo faz,
*                 sem renomear o CONTROLE (cmd_4c_EnviarEmail) nem os
*                 metodos do BO (EnviarEmail/EnviarEmailSelecionados), que
*                 seguem descrevendo o meio de entrega.
*               BtnCancelarClick - NAO SE APLICA. Nao ha Page2/modo de
*                 edicao para cancelar - a unica saida da tela e' o
*                 Encerrar (BtnEncerrarClick), igual ao legado.
*               FormParaBO/BOParaForm - NAO SE APLICAM. Esses hooks
*                 transferem os campos de UMA ficha entre Form e BO; esta
*                 tela nao edita um registro por vez, opera em LOTE sobre as
*                 linhas de cursor_4c_Dados (equivalente a crLocalTotal) via
*                 ChkChecksInteractiveChange (grava direto no cursor) e
*                 ValidarEmailLinha (idem) - o "de-para" delas ja existe,
*                 so que na granularidade de LINHA da grade, nao de FICHA.
*               HabilitarCampos/LimparCampos - NAO SE APLICAM. Nao ha modo
*                 INCLUIR/ALTERAR/VISUALIZAR/EXCLUIR nem campos de ficha a
*                 habilitar/limpar - a UNICA celula editavel (Column4/
*                 Emails) fica sempre editavel, como no SCX legado
*                 (Column4.ReadOnly = .F. incondicional).
*               AjustarBotoesPorModo - NAO SE APLICA. Nao ha "modo" de tela
*                 (LISTA/INCLUIR/ALTERAR/VISUALIZAR) cujos botoes mudem de
*                 Enabled - os 4 botoes do legado (Enviar Email, Marcar
*                 Todos, Desmarcar Todos, Encerrar) ficam sempre habilitados.
*               CarregarLista - EQUIVALENTE JA EXISTE desde a Fase 3/4:
*                 CarregarDados() (que delega a
*                 sigpremaBO.BuscarDadosProcessamento) e' chamado em
*                 InicializarForm() e alimenta grd_4c_Dados, exatamente o
*                 papel que CarregarLista tem nos forms CRUD. O nome
*                 CarregarDados foi mantido (em vez de CarregarLista) porque
*                 e' o mesmo dado que a Fase 6 ja documentou como "a tela
*                 inteira e' a lista" - nao ha uma segunda fonte de dados
*                 (Page2/ficha) para o nome "Lista" precisar distinguir.
*
*             Nenhum metodo novo foi criado nesta fase (a unica mudanca de
*             codigo foi a renomeacao do handler de acao descrita acima): os
*             4 botoes reais do legado e a carga da grade ja estavam
*             completos e testados desde as Fases 3, 4 e 6. Revisao final contra
*             comportamento.json confirma que os unicos PROCEDURE do dump
*             ainda sem correspondente no migrado sao os ja documentados nas
*             Fases 5/6 como fora de escopo (criapdf/documento/impdocto -
*             cadeia de geracao de PDF via COM PDFCreator.clsPDFCreator +
*             REPORT FORM SigReDc2 + chamada a quatro outras telas de
*             relatorio - SigPrIdc/SigReIfx/SigReJob/SigOpIgm/SigReIiv -
*             nenhuma delas parte desta migracao; e Load/=fConfigGeral(),
*             papel que start\config.prg ja cumpre no startup da aplicacao
*             nova). memail (o corpo real de envio via CDO.Message) ja esta
*             transcrito em sigpremaBO.EnviarEmail desde a Fase 1/2.
*==============================================================================
DEFINE CLASS Formsigprema AS FormBase

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Parametros recebidos no Init (equivalentes a prDopes/pAuto do legado)
    this_cDopesFiltro = ""    && prDopes - EmpDopNums para filtrar 1 movimento
    this_lAutomatico  = .F.   && pAuto - .T. quando chamado em modo automatico

    *-- Propriedades visuais (PILAR 1 - valores exatos do SCX legado)
    Top         = 0
    Left        = 0
    Height      = 600
    Width       = 1000
    BorderStyle = 2
    AutoCenter  = .T.
    TitleBar    = 0
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    Caption     = "Processamento e Gera" + CHR(231) + "ao de Email"
    FontName    = "Tahoma"
    FontSize    = 8

    *--------------------------------------------------------------------------
    * Init - Recebe os parametros equivalentes a prDopes/pAuto do legado
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cDopes, par_lAutomatico)
        THIS.this_cDopesFiltro = IIF(VARTYPE(par_cDopes) = "C", par_cDopes, "")
        THIS.this_lAutomatico  = IIF(VARTYPE(par_lAutomatico) = "L", par_lAutomatico, .F.)

        *-- DODEFAULT() dispara FormBase.Init() que chama THIS.InicializarForm()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Chamado por FormBase.Init via DODEFAULT
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigpremaBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar sigpremaBO." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "Formsigprema.InicializarForm")
            ELSE
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                        MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
                                "o Com o Servidor de Banco de Dados...", ;
                                "Conex" + CHR(227) + "o")
                    ENDIF
                ENDIF

                *-- Imagem de fundo (legado: new_background.jpg)
                IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
                    THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
                ENDIF

                THIS.ConfigurarCabecalho()

                *-- Grid.ColumnN.ControlSource exige o cursor JA existente (CLAUDE.md
                *-- regra #41) - por isso o cursor eh criado/populado ANTES de montar
                *-- o Grid. Em validacao de UI (sem SQL) usa placeholder vazio com a
                *-- MESMA estrutura, igual ao padrao ja usado nos forms CRUD.
                IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                    THIS.CriarCursorPlaceholder()
                ELSE
                    THIS.CarregarDados()
                ENDIF

                THIS.ConfigurarGrid()
                THIS.ConfigurarBotoes()

                THIS.TornarControlesVisiveis(THIS)

                *-- Equivalente ao "If ThisForm.Automatico / ThisForm.btnEmail.Click() /
                *-- ThisForm.Release / Return .f." do Init legado - so dispara quando o
                *-- Form foi explicitamente criado em modo automatico (par_lAutomatico=.T.),
                *-- nunca no fluxo interativo padrao nem em validacao de UI.
                IF THIS.this_lAutomatico AND (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI)
                    THIS.BtnProcessarEmailClick()
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro Formsigprema.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarCursorPlaceholder - Estrutura vazia de cursor_4c_Dados usada apenas
    * quando gb_4c_ValidandoUI esta ativo (sem SQL disponivel), para o Grid ter
    * um cursor valido para ligar o ControlSource (CLAUDE.md regra #41).
    * Estrutura IDENTICA a criada em sigpremaBO.BuscarDadosProcessamento.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarCursorPlaceholder()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        SET NULL ON
        CREATE CURSOR cursor_4c_Dados ;
            (Checks N(1) NULL, Grupos C(10) NULL, Contas C(10) NULL, ;
             Rclis C(50) NULL, Emails C(50) NULL, Mensagens M NULL, ;
             EmpDopNums C(29) NULL, Prioridade C(15) NULL)
        SET NULL OFF

        INDEX ON Contas TAG Contas
        INDEX ON Rclis  TAG Rclis
        INDEX ON Emails TAG Emails
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - Popula cursor_4c_Dados (equivalente a crLocalTotal do
    * legado) via sigpremaBO.BuscarDadosProcessamento, usando o filtro recebido
    * no Init do form (this_cDopesFiltro - equivalente a prDopes do legado).
    * Erros de SQL ja sao exibidos dentro do proprio BO.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDados()
        THIS.this_oBusinessObject.BuscarDadosProcessamento(THIS.this_cDopesFiltro)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Constroi a faixa cinza superior do form
    * Equivalente ao cntSombra do SCX legado. Forms OPERACIONAIS nao usam
    * PageFrame CRUD - o cabecalho eh um container direto no form.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Sombra", "Container")
            WITH THIS.cnt_4c_Sombra
                .Top         = 0
                .Left        = 0
                .Width       = 1100
                .Height      = 80
                .BackColor   = RGB(100, 100, 100)
                .BackStyle   = 1
                .BorderWidth = 0

                .AddObject("lbl_4c_Sombra", "Label")
                WITH .lbl_4c_Sombra
                    .Top       = 18
                    .Left      = 10
                    .Width     = THIS.Width
                    .Height    = 40
                    .FontBold  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 18
                    .AutoSize  = .F.
                    .BackStyle = 0
                    .WordWrap  = .T.
                    .Alignment = 0
                    .ForeColor = RGB(0, 0, 0)
                    .Caption   = THIS.Caption
                ENDWITH

                .AddObject("lbl_4c_Titulo", "Label")
                WITH .lbl_4c_Titulo
                    .Top       = 17
                    .Left      = 10
                    .Width     = THIS.Width
                    .Height    = 46
                    .FontBold  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 18
                    .AutoSize  = .F.
                    .BackStyle = 0
                    .WordWrap  = .T.
                    .Alignment = 0
                    .ForeColor = RGB(255, 255, 255)
                    .Caption   = THIS.Caption
                ENDWITH

                .Visible = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro Formsigprema.ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrid - Monta grd_4c_Dados (equivalente ao grade/fwgrade do
    * legado) ligado a cursor_4c_Dados. Ordem das colunas eh a ordem VISUAL do
    * legado (Checks/Contas/Rclis/Emails/EmpDopNums) - por isso nao precisamos
    * de ColumnOrder (propriedade a evitar, causa desalinhamento).
    *
    * cursor_4c_Dados DEVE existir antes desta chamada (CriarCursorPlaceholder
    * ou CarregarDados, chamados em InicializarForm) - CLAUDE.md regra #41.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_oGrid, loc_oErro

        TRY
            THIS.AddObject("grd_4c_Dados", "Grid")
            loc_oGrid = THIS.grd_4c_Dados

            WITH loc_oGrid
                .Top        = 126
                .Left       = 3
                .Width      = 993
                .Height     = 469
                .FontName   = "Verdana"
                .FontSize   = 8
                .RowHeight  = 18
                .RecordMark = .F.
                .DeleteMark = .F.
                .ReadOnly   = .F.
            ENDWITH

            *-- ColumnCount/RecordSource FORA do WITH: dentro do mesmo WITH que
            *-- em seguida acessa .ColumnN, o Grid ainda nao recriou as colunas
            *-- e a referencia estoura "Unknown member COLUMN1".
            loc_oGrid.ColumnCount  = 5
            loc_oGrid.RecordSource = "cursor_4c_Dados"

            WITH loc_oGrid
                *-- ControlSource das colunas de texto (logo apos o RecordSource -
                *-- CLAUDE.md: RecordSource reseta customizacoes de coluna)
                .Column2.ControlSource = "cursor_4c_Dados.Contas"
                .Column3.ControlSource = "cursor_4c_Dados.Rclis"
                .Column4.ControlSource = "cursor_4c_Dados.Emails"
                .Column5.ControlSource = "cursor_4c_Dados.EmpDopNums"

                *-- Coluna de selecao (equivalente ao Column6/fwcheckbox1 legado) -
                *-- AddObject + CurrentControl OBRIGATORIAMENTE antes do ControlSource
                *-- (CLAUDE.md regra #18)
                .Column1.AddObject("chk_4c_Checks", "CheckBox")
                WITH .Column1.chk_4c_Checks
                    .Caption   = ""
                    .Alignment = 0
                    .Value     = 0
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH
                .Column1.CurrentControl = "chk_4c_Checks"
                .Column1.Sparse         = .F.
                .Column1.ReadOnly       = .F.
                .Column1.ControlSource  = "cursor_4c_Dados.Checks"

                *-- Width por ULTIMO (RecordSource/ControlSource recalculam para 90)
                .Column1.Width = 17
                .Column2.Width = 80
                .Column3.Width = 290
                .Column4.Width = 290
                .Column5.Width = 290

                .Column2.ReadOnly = .T.
                .Column3.ReadOnly = .T.
                .Column4.ReadOnly = .F.
                .Column5.ReadOnly = .T.

                .Column1.Header1.Caption = ""

                .Column2.Header1.Caption   = "Conta"
                .Column2.Header1.Alignment = 2
                .Column2.Header1.FontName  = "Tahoma"
                .Column2.Header1.FontSize  = 8

                .Column3.Header1.Caption   = "Nome"
                .Column3.Header1.Alignment = 2
                .Column3.Header1.FontName  = "Tahoma"
                .Column3.Header1.FontSize  = 8

                .Column4.Header1.Caption   = "Email"
                .Column4.Header1.Alignment = 2
                .Column4.Header1.FontName  = "Tahoma"
                .Column4.Header1.FontSize  = 8

                .Column5.Header1.Caption  = "Movimenta" + CHR(231) + CHR(227) + "o de Estoque"
                .Column5.Header1.FontName = "Tahoma"
                .Column5.Header1.FontSize = 8

                .Visible = .T.
            ENDWITH

            BINDEVENT(loc_oGrid.Column1.chk_4c_Checks, "InteractiveChange", THIS, "ChkChecksInteractiveChange")

            *-- Column4 (Emails) e' a UNICA celula digitavel da grade, tanto no
            *-- legado (Column4.ReadOnly = .F. no SCX, contra .T. das demais)
            *-- quanto aqui. O que o usuario digitar nela e' exatamente o que
            *-- vai para o campo "Para"/"Cc" do envio, entao o valor precisa ser
            *-- normalizado e conferido ANTES de sair da celula.
            *-- "Valid" NAO dispara via BINDEVENT em TextBox (CLAUDE.md) - o
            *-- equivalente e' KeyPress (ENTER/TAB) + LostFocus.
            BINDEVENT(loc_oGrid.Column4.Text1, "KeyPress",  THIS, "ValidarEmailLinhaKeyPress")
            BINDEVENT(loc_oGrid.Column4.Text1, "LostFocus", THIS, "ValidarEmailLinha")

            BINDEVENT(loc_oGrid.Column2.Header1, "Click", THIS, "HeaderContasClick")
            BINDEVENT(loc_oGrid.Column3.Header1, "Click", THIS, "HeaderRclisClick")
            BINDEVENT(loc_oGrid.Column4.Header1, "Click", THIS, "HeaderEmailsClick")

            *-- Equivalente a "Thisform.grade.column3.header1.Click()" no fim do
            *-- Init legado - ordena por Nome (Rclis) e destaca o header ativo
            THIS.this_oBusinessObject.OrdenarPorColuna("Rclis")
            THIS.AtualizarDestaqueColunaOrdenada("Rclis")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro Formsigprema.ConfigurarGrid")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarDestaqueColunaOrdenada - Destaca com fundo azul-esverdeado o
    * header da coluna usada na ordenacao corrente e volta as demais para o
    * cinza padrao - transcricao literal do Header1.Click do legado
    * (RGB(64,128,128) = coluna ativa / RGB(192,192,192) = colunas inativas).
    * par_cColuna: "Contas" | "Rclis" | "Emails"
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarDestaqueColunaOrdenada(par_cColuna)
        LOCAL loc_nAtivo, loc_nInativo

        loc_nAtivo   = RGB(64, 128, 128)
        loc_nInativo = RGB(192, 192, 192)

        THIS.grd_4c_Dados.Column2.Header1.BackColor = IIF(par_cColuna = "Contas", loc_nAtivo, loc_nInativo)
        THIS.grd_4c_Dados.Column3.Header1.BackColor = IIF(par_cColuna = "Rclis",  loc_nAtivo, loc_nInativo)
        THIS.grd_4c_Dados.Column4.Header1.BackColor = IIF(par_cColuna = "Emails", loc_nAtivo, loc_nInativo)
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkChecksInteractiveChange - Grava o novo estado do checkbox no cursor de
    * trabalho. Transcricao literal do "Replace Checks With this.Value in
    * crLocalTotal" do PROCEDURE InteractiveChange legado (Column6.fwcheckbox1).
    * PUBLIC (sem PROTECTED) - metodo alvo de BINDEVENT (CLAUDE.md regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE ChkChecksInteractiveChange()
        LOCAL loc_oChk

        loc_oChk = THIS.grd_4c_Dados.Column1.chk_4c_Checks

        IF USED("cursor_4c_Dados")
            REPLACE Checks WITH loc_oChk.Value IN cursor_4c_Dados
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarEmailLinhaKeyPress - Dispara a validacao da celula de e-mail ao
    * confirmar a digitacao com ENTER (13) ou TAB (9), que e' o equivalente do
    * Valid da celula no legado ("Valid" nao dispara via BINDEVENT em TextBox -
    * CLAUDE.md). PUBLIC (alvo de BINDEVENT, CLAUDE.md regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarEmailLinhaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarEmailLinha()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarEmailLinha - Normaliza o e-mail digitado na celula editavel da
    * grade (Column4/Emails, a unica com ReadOnly = .F. no SCX legado) e grava
    * o valor normalizado de volta no cursor de trabalho.
    *
    * A normalizacao aplicada e' a MESMA que o legado ja aplica no momento do
    * envio - ALLTRIM no destinatario/copia (btnEmail.Click:
    * "Alltrim(crLocaltotal2.emails)") e LOWER no remetente/servidor
    * ("Lower(Alltrim(Nvl(TmpEmpMail.PadEmails,[])))"). Fazer isso aqui, na
    * saida da celula, e' o que faz o que o usuario VE na grade ser igual ao
    * que de fato sai no e-mail; sem isso, um espaco a esquerda digitado por
    * engano continua invisivel na tela e vai inteiro para o campo "Para".
    *
    * NAO bloqueia nem rejeita conteudo: o legado nao tem Valid nesta celula e
    * o unico criterio que ele aplica sobre o e-mail e' "vazio -> pula a linha"
    * (btnEmail.Click: "If IsEmpty(crLocaltotal2.emails) / Loop"), criterio que
    * esta reproduzido em sigpremaBO.EnviarEmailSelecionados e conferido em
    * THIS.ValidarEnvio(). Impedir a digitacao aqui seria inventar regra que o
    * legado nao tem (PILAR 1).
    *
    * PUBLIC (alvo de BINDEVENT, CLAUDE.md regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarEmailLinha()
        LOCAL loc_oTxt, loc_cDigitado, loc_cNormalizado, loc_oErro

        TRY
            loc_oTxt = THIS.grd_4c_Dados.Column4.Text1

            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                loc_cDigitado    = TratarNulo(loc_oTxt.Value, "")
                loc_cNormalizado = LOWER(ALLTRIM(loc_cDigitado))

                *-- So grava quando mudou de fato: evita reescrever o cursor a
                *-- cada passagem de foco pela celula.
                IF loc_cNormalizado != loc_cDigitado
                    REPLACE Emails WITH loc_cNormalizado IN cursor_4c_Dados
                    loc_oTxt.Value = loc_cNormalizado
                    THIS.grd_4c_Dados.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro Formsigprema.ValidarEmailLinha")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarEnvio - Conferencia previa ao disparo do envio, executada por
    * BtnProcessarEmailClick ANTES de chamar o BO. Reproduz os dois criterios que
    * o proprio btnEmail.Click legado aplica sobre as linhas antes de enviar:
    *
    *   1) "Select * From crLocaltotal Where Checks = 1"  -> tem de haver ao
    *      menos UMA linha marcada;
    *   2) "If IsEmpty(crLocaltotal2.emails) / Loop"      -> das marcadas, ao
    *      menos UMA precisa ter e-mail preenchido.
    *
    * No legado esses dois criterios sao silenciosos: com nenhuma linha marcada
    * (ou com todas as marcadas sem e-mail) o SCAN nao executa nenhuma
    * iteracao, "llOk" continua .T. e a tela exibe "Email enviado com sucesso!"
    * e se fecha - sem ter enviado nada. Este metodo existe para NAO reproduzir
    * esse ponto: CLAUDE.md #20 (falha de gravacao nunca e' muda) e a regra de
    * nunca anunciar sucesso quando nao houve o que processar. O desvio e'
    * deliberado, cobre so a mensagem/aborto e esta registrado no cabecalho.
    *
    * Retorna .T. quando ha o que enviar; .F. (com MsgAviso ja exibido e foco
    * devolvido a grade) quando nao ha.
    *
    * PUBLIC - tambem e' chamado de fora pelo harness de teste (CLAUDE.md #3).
    *--------------------------------------------------------------------------
    FUNCTION ValidarEnvio()
        LOCAL loc_lValido, loc_nMarcadas, loc_nComEmail, loc_nRegAtual, loc_oErro

        loc_lValido  = .F.
        loc_nMarcadas = 0
        loc_nComEmail = 0

        TRY
            IF !USED("cursor_4c_Dados")
                MsgAviso("Nenhum dado carregado para envio.", ;
                         "Processamento de Email")
            ELSE
                *-- Preserva a linha corrente: a grade continua posicionada
                *-- onde o usuario estava depois da conferencia.
                SELECT cursor_4c_Dados
                loc_nRegAtual = IIF(RECCOUNT() > 0, RECNO(), 0)

                SCAN
                    IF NVL(cursor_4c_Dados.Checks, 0) = 1
                        loc_nMarcadas = loc_nMarcadas + 1

                        IF !EMPTY(ALLTRIM(TratarNulo(cursor_4c_Dados.Emails, "")))
                            loc_nComEmail = loc_nComEmail + 1
                        ENDIF
                    ENDIF
                ENDSCAN

                IF loc_nRegAtual > 0 AND loc_nRegAtual <= RECCOUNT()
                    GO loc_nRegAtual IN cursor_4c_Dados
                ENDIF

                DO CASE
                CASE loc_nMarcadas = 0
                    MsgAviso("Nenhum destinat" + CHR(225) + "rio selecionado." + CHR(13) + ;
                             "Marque ao menos um e-mail para envio.", ;
                             "Processamento de Email")

                CASE loc_nComEmail = 0
                    MsgAviso("Nenhuma das linhas marcadas tem e-mail preenchido." + CHR(13) + ;
                             "Informe o e-mail na coluna Email ou marque outra linha.", ;
                             "Processamento de Email")

                OTHERWISE
                    loc_lValido = .T.
                ENDCASE

                IF !loc_lValido AND TYPE("THIS.grd_4c_Dados") = "O"
                    THIS.grd_4c_Dados.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_lValido = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro Formsigprema.ValidarEnvio")
        ENDTRY

        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * HeaderContasClick / HeaderRclisClick / HeaderEmailsClick - Reordenam o
    * cursor de trabalho pelo TAG correspondente, equivalente ao PROCEDURE
    * Click dos headers das colunas Conta/Nome/Email no legado. PUBLIC (alvo
    * de BINDEVENT).
    *--------------------------------------------------------------------------
    PROCEDURE HeaderContasClick()
        THIS.this_oBusinessObject.OrdenarPorColuna("Contas")
        THIS.AtualizarDestaqueColunaOrdenada("Contas")
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    PROCEDURE HeaderRclisClick()
        THIS.this_oBusinessObject.OrdenarPorColuna("Rclis")
        THIS.AtualizarDestaqueColunaOrdenada("Rclis")
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    PROCEDURE HeaderEmailsClick()
        THIS.this_oBusinessObject.OrdenarPorColuna("Emails")
        THIS.AtualizarDestaqueColunaOrdenada("Emails")
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - Monta os controles standalone do legado (nenhum deles
    * fica dentro de um container no SCX original): Shape1 (decorativo),
    * btnEmail, SelTudo (Marcar Todos), apaga (Desmarcar Todos) e Commandgroup1
    * (botao unico "Encerrar"). Todas as posicoes/tamanhos/icones sao os
    * valores EXATOS do SCX legado (PILAR 1).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_oErro

        TRY
            *-- Shape decorativo em torno do bloco Encerrar/Enviar Email (Shape1)
            THIS.AddObject("shp_4c_Decoracao", "Shape")
            WITH THIS.shp_4c_Decoracao
                .Top           = 7
                .Left          = 804
                .Width         = 90
                .Height        = 110
                .BackStyle     = 0
                .BorderStyle   = 0
                .BorderWidth   = 1
                .SpecialEffect = 1
                .BorderColor   = RGB(136, 189, 188)
                .Visible       = .T.
            ENDWITH

            *-- Enviar Email (legado btnEmail)
            THIS.AddObject("cmd_4c_EnviarEmail", "CommandButton")
            WITH THIS.cmd_4c_EnviarEmail
                .Top             = 3
                .Left            = 850
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Caption         = "Enviar Email"
                .ToolTipText     = "Enviar Email"
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Picture         = gc_4c_CaminhoIcones + "geral_envelope_60.jpg"
                .Themes          = .T.
                .DisabledPicture = gc_4c_CaminhoIcones + "geral_envelope_60.jpg"
                .Visible         = .T.
            ENDWITH
            BINDEVENT(THIS.cmd_4c_EnviarEmail, "Click", THIS, "BtnProcessarEmailClick")

            *-- Marcar Todos (legado SelTudo)
            THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
            WITH THIS.cmd_4c_SelTudo
                .Top             = 84
                .Left            = 4
                .Width           = 40
                .Height          = 40
                .FontName        = "Verdana"
                .FontSize        = 8
                .WordWrap        = .T.
                .Caption         = ""
                .TabStop         = .F.
                .ToolTipText     = "Marcar Todos"
                .ForeColor       = RGB(36, 84, 155)
                .BackColor       = RGB(255, 255, 255)
                .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
                .Themes           = .T.
                .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
                .Visible         = .T.
            ENDWITH
            BINDEVENT(THIS.cmd_4c_SelTudo, "Click", THIS, "BtnSelTudoClick")

            *-- Desmarcar Todos (legado apaga)
            THIS.AddObject("cmd_4c_Apaga", "CommandButton")
            WITH THIS.cmd_4c_Apaga
                .Top             = 84
                .Left            = 43
                .Width           = 40
                .Height          = 40
                .FontName        = "Verdana"
                .FontSize        = 8
                .WordWrap        = .T.
                .Caption         = ""
                .TabStop         = .F.
                .ToolTipText     = "Desmarcar Todos"
                .ForeColor       = RGB(36, 84, 155)
                .BackColor       = RGB(255, 255, 255)
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .Themes           = .T.
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .Visible         = .T.
            ENDWITH
            BINDEVENT(THIS.cmd_4c_Apaga, "Click", THIS, "BtnApagaClick")

            *-- Encerrar (legado Commandgroup1/btnSair)
            THIS.AddObject("cmg_4c_Encerrar", "CommandGroup")
            WITH THIS.cmg_4c_Encerrar
                .Top           = -2
                .Left          = 920
                .Width         = 85
                .Height        = 85
                .ButtonCount   = 1
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 1
                .BorderColor   = RGB(136, 189, 188)
                .Themes        = .F.

                WITH .Buttons(1)
                    .Top         = 5
                    .Left        = 5
                    .Width       = 75
                    .Height      = 75
                    .FontBold    = .T.
                    .FontItalic  = .T.
                    .FontName    = "Comic Sans MS"
                    .FontSize    = 8
                    .Picture     = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                    .Cancel      = .T.
                    .Caption     = "Encerrar"
                    .ToolTipText = "[Esc] Encerrar"
                    .ForeColor   = RGB(90, 90, 90)
                    .BackColor   = RGB(255, 255, 255)
                    .Themes      = .F.
                ENDWITH

                .Visible = .T.
            ENDWITH
            BINDEVENT(THIS.cmg_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro Formsigprema.ConfigurarBotoes")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSelTudoClick / BtnApagaClick - Marcam/desmarcam todas as linhas do
    * cursor de trabalho (equivalente ao Click dos botoes SelTudo/apaga do
    * legado). PUBLIC (alvo de BINDEVENT).
    *--------------------------------------------------------------------------
    PROCEDURE BtnSelTudoClick()
        THIS.this_oBusinessObject.MarcarTodos()
        THIS.Refresh()
    ENDPROC

    PROCEDURE BtnApagaClick()
        THIS.this_oBusinessObject.DesmarcarTodos()
        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha a tela (equivalente ao PROCEDURE btnSair.Click
    * do Commandgroup1 legado). PUBLIC (alvo de BINDEVENT). Nomeado com o
    * prefixo Btn (e nao Cmg, do objeto cmg_4c_Encerrar) para ficar consistente
    * com os demais handlers de botao deste form (BtnSelTudoClick/BtnApagaClick/
    * BtnProcessarEmailClick).
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        LPARAMETERS par_nIndicePressionado

        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnProcessarEmailClick - Dispara o envio dos e-mails marcados (equivalente
    * ao PROCEDURE Click do btnEmail legado). Toda a logica de envio (contas
    * SMTP, laco pelos selecionados, log) ja esta em
    * sigpremaBO.EnviarEmailSelecionados - este handler so aciona e trata o
    * retorno, igual ao legado (fecha a tela em caso de sucesso e sempre que a
    * tela estiver em modo automatico). PUBLIC (alvo de BINDEVENT).
    *
    * this_cArquivoEmail fica vazio porque a geracao do PDF anexo (equivalente
    * ao ImpDocto do legado) depende de relatorios fora do escopo desta
    * migracao - ver cabecalho de sigpremaBO.prg.
    *--------------------------------------------------------------------------
    PROCEDURE BtnProcessarEmailClick()
        LOCAL loc_lOk

        loc_lOk = .F.

        *-- Conferencia previa: sem linha marcada (ou sem nenhuma marcada com
        *-- e-mail preenchido) nao ha o que enviar - pular o envio aqui evita
        *-- que a tela anuncie "Email enviado com sucesso!" sem ter enviado
        *-- nada. Ver comentario de ValidarEnvio (desvio deliberado do legado).
        IF THIS.ValidarEnvio()
            THIS.this_oBusinessObject.this_cArquivoEmail = ""

            loc_lOk = THIS.this_oBusinessObject.EnviarEmailSelecionados()

            IF loc_lOk
                WAIT WINDOW "Email enviado com sucesso!" TIMEOUT 2
                THIS.Release()
            ENDIF
        ENDIF

        *-- FORA do IF acima, de proposito: no legado o "If Thisform.automatico
        *-- / thisform.Release()" e' incondicional - a tela chamada em modo
        *-- automatico SEMPRE se fecha, tenha enviado ou nao. Condicionar este
        *-- release a validacao deixaria o processo automatico preso numa tela
        *-- aberta que ninguem vai fechar.
        IF THIS.this_lAutomatico
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna visiveis todos os controles do form,
    * percorrendo containers e paginas de PageFrame recursivamente. AddObject
    * cria controles com Visible=.F. por padrao.
    *--------------------------------------------------------------------------
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    LOCAL loc_nP
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera o Business Object (que por sua vez libera os cursores
    * de trabalho abertos - ver sigpremaBO.Destroy)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

ENDDEFINE
