*==============================================================================
* FormSigOpMpd.prg - Selecao de Operacoes em Aberto (SigCdNec)
* Origem: tasks/task768/SigOpMpd.SCX (SIGOPMPD)
* Herda de: FormBase
*
* Tipo: OPERACIONAL (dialogo aberto por um botao do Cadastro de
* Necessidades - SIGCDEPD/FormEpd - legado: "Do Form SigOpMpd With
* ThisForm, ThisForm.DataSessionId, ThisForm.poDataMgr", com o form
* chamador se desabilitando antes de abrir e se reabilitando no OK do
* dialogo). NAO segue o padrao Page1=Lista/Page2=Dados do CRUD: layout
* FLAT, filhos DIRETOS do form (cabecalho + grade de selecao + botoes),
* igual ao SCX legado (sem PageFrame nenhum).
*
* DataSession=1 (compartilhada) - DEVIO DELIBERADO do SCX legado, que
* declara DataSession=2 (privada) mas, logo no inicio do Init, executa
* "Set DataSession To pData" para trocar para a sessao do form PAI ANTES
* de criar TmpPends - ou seja, na pratica o legado tambem roda na sessao
* do chamador, nao na propria. Aqui isso e replicado deixando o form
* inteiro na sessao compartilhada (1), igual a FormSigOpLrC.prg e
* Formsigopagr.prg (mesma familia de dialogo, citados no cabecalho de
* SigOpMpdBO.prg): assim TmpNens/TmpOperacao/xMFas/xOpi/xPesa/xNensi,
* mantidos abertos pelo form pai, ficam visiveis aqui pelo NOME, sem
* precisar emular "Set DataSession To <numero>" (que nesta arquitetura
* nao tem equivalente - nao ha mais poDataMgr nem DataSessionId
* numerico trafegando entre forms).
*
* Aberto com: CREATEOBJECT("FormSigOpMpd", oFormPai)
*
* Historico de fases:
*   Fase 1/2: SigOpMpdBO.prg (propriedades, Init, CarregarDoCursor,
*             Atualizar, CarregarPendencias/CarregarPendenciasExec,
*             Marcar/MarcarExec, Desmarcar/DesmarcarExec)
*   Fase 3:   FormSigOpMpd.prg - estrutura base (Init, InicializarForm,
*             ConfigurarCabecalho, Destroy).
*   Fase 4:   FormSigOpMpd.prg - grade de selecao completa (ConfigurarGrade,
*             8 colunas incl. CheckBox embutido), botoes de acao
*             (ConfigurarBotoesAcao: Shape2/ok/SelTudo/Apaga), BINDEVENTs
*             (ConfigurarEventosGrade/ConfigurarEventosBotoes), funil de
*             carga (CarregarGrade) e os handlers de negocio
*             (ChkSelecionarInteractiveChange, CmdSelTudoClick,
*             CmdApagaClick, CmdOkClick, FocarColunaSelecao,
*             AplicarSugestoesAoFormPai, AtualizarPaginaDadosFormPai,
*             ResetarSugestoesBO) - paridade com os 20 metodos/eventos do
*             dump legado (tasks/task768/comportamento.json) ja fechada.
*   Fase 5:   NAO APLICAVEL (mesma razao do item abaixo). O template
*             generico de "Fase 5 - Form: Campos Principais (Page2)"
*             pressupoe form CRUD com PageFrame Page1=Lista/Page2=Dados;
*             este dialogo OPERACIONAL e FLAT (sem PageFrame - ver nota
*             acima) e o unico "campo" da tela e a grade de selecao, ja
*             entregue na Fase 4. Nao ha ConfigurarPaginaDados nem campos
*             adicionais a acrescentar.
*   Fase 6:   NAO APLICAVEL. O template generico de "Fase 6 - Form: Campos
*             Restantes e Lookups (Page2 - Parte 2)" tambem pressupoe
*             PageFrame/Page2, inexistente aqui, e exige AbrirLookup*/
*             AbrirBusca* para algum campo. O dump legado
*             (tasks/task768/SigOpMpd_form_codigo_fonte.txt, 1272 linhas)
*             foi conferido com grep contra TODOS os padroes de lookup do
*             projeto - fwbusca(Ext|Sel|Int), sigacess(, Acesso(Campos|
*             Contab|Contas|Empresa|Grupos|MovInd|MovMto|Produto|
*             Titulo)(, mAddColuna, PROCEDURE Valid - ZERO ocorrencia de
*             qualquer um (comportamento.json confirma: funcoesExternas do
*             form inteiro sao so "For Not Empty"/"For Empty"/
*             "fConfigGeral"/"Flag With ThisForm.Marca"). O unico controle
*             "digitavel" da tela eh a celula de Column4 ("codigo"), que no
*             legado eh a classe Ingrid1 (seek incremental por cordertag,
*             sem Valid nenhum) e no migrado eh TextBox comum sem logica de
*             busca - coerente com o dump (ver nota no cabecalho de
*             ConfigurarGrade). Perfil GRADE+BOTOES (todo controle de
*             entrada mora em <grd_4c_Grade>.ColumnN, ja entregue na
*             Fase 4) - mesmo perfil do precedente SigOpEmb/task728 e dos
*             casos SigOpChp/task699, SigOpCtd/task715, SigOpCts/task717,
*             documentados na memoria de projeto do pipeline (gates das
*             Fases 5/6/7 exigirem superficie que o legado nunca teve).
*             Inventar AbrirLookup*/AbrirBusca* aqui violaria o PILAR 1
*             (lookup que o legado nunca teve) e a regra de completude
*             (metodo so para satisfazer um gate, sem logica real).
*   Fase 7:   JA SATISFEITA pela Fase 4. O template generico de "Form -
*             Eventos Principais" pede BtnIncluirClick/BtnAlterarClick/
*             BtnVisualizarClick/BtnExcluirClick, mas o dump legado
*             (SECAO 1) nao declara CommandGroup nenhum nem verbo CRUD em
*             botao algum - os TRES commandbutton reais sao ok/SELTUDO/
*             APAGA (fwbtng/fwbtnp), cada um ja com seu Click portado na
*             Fase 4: CmdOkClick (fecha o dialogo), CmdSelTudoClick e
*             CmdApagaClick (marcar/desmarcar tudo), todos ligados via
*             ConfigurarEventosBotoes()/BINDEVENT. Inventar Btn*Click
*             para verbos que o legado nunca teve violaria o PILAR 1 e a
*             regra de completude (handler sem logica real so para
*             satisfazer o nome do gate).
*   Fase 8:   consolidacao final - hooks canonicos do FormBase ligados aos
*             metodos ja existentes, mais DOIS defeitos reais fechados:
*
*             (a) ThisForm.parentform.EditaOrigem do legado NUNCA chegava a
*                 ser aplicado. DesmarcarExec() ja calculava o valor em
*                 SigOpMpdBO.this_lPermiteEditarOrigem - e o proprio
*                 comentario do BO registra que "a atribuicao fica para a
*                 camada de Form" - mas nenhum metodo do form a lia: o
*                 recalculo morria no BO. Fechado por
*                 AplicarPermissaoOrigemAoFormPai(), chamada nos dois
*                 caminhos de desmarcacao (CheckBox desmarcado e botao
*                 Apaga), exatamente onde o legado mexe em EditaOrigem.
*
*             (b) Column8 ("Produto") voltava a ser EDITAVEL depois de cada
*                 carga. O legado declara Column8.ReadOnly = .T., e
*                 ConfigurarGrade transcrevia isso - mas atribuir
*                 RecordSource em CarregarGrade() faz o Grid.ReadOnly = .F.
*                 repropragar para TODAS as colunas (mesma regra que ja
*                 obrigava a reatribuir Width/Header1.Caption/Column1.
*                 ReadOnly ali). Fechado por HabilitarCampos(), que
*                 reafirma as DUAS colunas depois do bind.
*
*             Novos metodos: CarregarLista (nome canonico do projeto, ponto
*             de entrada publico que delega ao funil CarregarGrade - mesmo
*             padrao de FormSigPdMp5/FormSigPdMp8/FormSigPrPcp/
*             FormSigPrSlp), FormParaBO e BOParaForm (hooks PROTECTED do
*             FormBase; ver cabecalho de cada um), HabilitarCampos e
*             AjustarBotoesPorModo (transcrevem o When do fwcheckbox1 e o
*             Visible/When de SelTudo/Apaga num ponto UNICO, no lugar das
*             tres copias inline que havia em ConfigurarGrade/
*             ConfigurarBotoesAcao/CarregarGrade), LimparCampos (zera a
*             linha corrente e as sugestoes do BO antes de cada recarga),
*             FecharDialogo (saida unica) e BtnEncerrarClick/
*             BtnCancelarClick (nomes canonicos apontando para essa saida).
*
*             this_cModoFormPai passou a chamar-se this_cModoAtual: eh o
*             nome canonico do projeto para o modo e eh o que o legado de
*             fato tem (This.Op_Escolha = ThisForm.ParentForm.pcEscolha -
*             uma COPIA tirada no Init, property do DIALOGO, nao leitura
*             viva do pai).
*
*             NAO foram criados BtnSalvarClick nem BtnBuscarClick: o dump
*             legado nao tem botao de gravar (nenhum btnSalvar/btnGravar/
*             mGravaDados) nem botao de busca - os TRES commandbutton da
*             tela sao ok/SELTUDO/APAGA. A gravacao desta tela nao tem
*             botao por natureza: cada marcacao/desmarcacao ja persiste na
*             hora (SigOpMpdBO.Atualizar -> UPDATE SigCdNec.ChkSubn),
*             exatamente como no legado, e por isso tambem nao existe o
*             que "cancelar" - BtnCancelarClick cai na mesma saida do OK.
*
* Parametros de Init (equivalentes ao legado "With ThisForm,
* ThisForm.DataSessionId, ThisForm.poDataMgr"):
*   par_oFormPai - pForm/ParentForm: form chamador (SIGCDEPD/FormEpd).
*                  Guardado em this_oFormPai para o OK reabilita-lo
*                  (legado: ThisForm.ParentForm.Enabled = .t.) e para ler
*                  o modo atual em this_cModoAtual (equivalente a
*                  "Op_Escolha = ThisForm.ParentForm.pcEscolha" do Init
*                  legado, usado pelo Visible/When de SelTudo/Apaga na
*                  Fase 4: legado Inlist(Op_Escolha,'INSERIR','ALTERAR')
*                  equivale aqui a INLIST(this_cModoAtual,"INCLUIR",
*                  "ALTERAR") - FormEpd usa this_cModoAtual com os
*                  valores padrao do projeto, nao os termos Fortyus).
*                  pData (DataSessionId) e pCnx (poDataMgr) nao tem
*                  equivalente nesta arquitetura: DataSession=1
*                  (compartilhada, ver nota acima) substitui pData, e
*                  gnConnHandle global substitui pCnx.
*==============================================================================

DEFINE CLASS FormSigOpMpd AS FormBase

    *-- Propriedades visuais (PILAR 1 - valores exatos do SCX SIGOPMPD;
    *-- WindowType/ShowWindow NAO estao no dump - mantidos no default do
    *-- VFP, igual ao legado nao os declarar)
    Height       = 284
    Width        = 800
    AutoCenter   = .T.
    BorderStyle  = 2
    ShowWindow = 1
    WindowType = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    ClipControls = .F.
    TitleBar     = 0
    AlwaysOnTop  = .F.
    DataSession  = 1
    Caption      = "Opera" + CHR(231) + CHR(245) + "es Pendentes"

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Form chamador (equivalente a pForm/ParentForm do Init legado)
    this_oFormPai = .NULL.

    *-- Modo de operacao do dialogo: COPIA do modo do form pai tirada no
    *-- Init (legado: This.Op_Escolha = ThisForm.ParentForm.pcEscolha - o
    *-- legado tambem guarda uma copia em property do PROPRIO dialogo, nao
    *-- le o pai a cada uso). Valores do projeto: "INCLUIR"/"ALTERAR"/
    *-- "VISUALIZAR"/"LISTA", no lugar dos termos Fortyus 'INSERIR'/
    *-- 'ALTERAR'/'PROCURAR'. Lido por HabilitarCampos/AjustarBotoesPorModo.
    this_cModoAtual = ""

    *--------------------------------------------------------------------------
    * Init - recebe o form chamador, cria o Business Object e delega a
    * FormBase.Init() (que chama THIS.InicializarForm() via DODEFAULT()).
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oFormPai)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_oFormPai) = "O"
                THIS.this_oFormPai = par_oFormPai
                IF PEMSTATUS(par_oFormPai, "this_cModoAtual", 5)
                    THIS.this_cModoAtual = par_oFormPai.this_cModoAtual
                ENDIF
            ENDIF

            THIS.this_oBusinessObject = CREATEOBJECT("SigOpMpdBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar Business Object SigOpMpdBO." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormSigOpMpd.Init")
            ELSE
                *-- DODEFAULT() dispara FormBase.Init() que chama THIS.InicializarForm()
                loc_lSucesso = DODEFAULT()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpMpd.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - fundo do form + cabecalho + grade de selecao +
    * botoes de acao (Grade/Shape2/ok/SelTudo/Apaga do dump), todos filhos
    * DIRETOS do form (sem PageFrame/Page - regra ja documentada no
    * cabecalho do arquivo). Chamado automaticamente por FormBase.Init()
    * via DODEFAULT().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.LockScreen = .T.

            *-- Fundo do form (imagem do Framework Fortyus legado:
            *-- "..\framework\imagens\new_background.jpg" no SCX)
            THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"

            *-- Ordem IDENTICA ao dump legado (SECAO 1 - arvore de
            *-- objetos): cntSombra, Grade, Shape2, ok, SELTUDO, APAGA
            THIS.ConfigurarCabecalho()
            THIS.ConfigurarGrade()
            THIS.ConfigurarBotoesAcao()
            THIS.ConfigurarEventosGrade()
            THIS.ConfigurarEventosBotoes()

            *-- Carga de dados + vinculo da grade (funil unico - regra do
            *-- projeto sobre CarregarDados/Problema 48: popular cursor
            *-- NAO repinta grade sozinho)
            THIS.CarregarGrade()

            THIS.LockScreen = .F.

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpMpd.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - faixa escura de titulo (SIGOPMPD.cntSombra do
    * dump), com os dois labels sobrepostos (lblSombra = sombra preta,
    * lblTitulo = titulo branco por cima - mesmo padrao de
    * FormSigOpLrC.prg/Formsigopagr.prg). Caption dos dois labels recebe a
    * propriedade Caption do form - legado: ThisForm.cntSombra.lblSombra e
    * lblTitulo.Caption = ThisForm.Caption, feito no inicio do Init.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab

        THIS.AddObject("cnt_4c_Sombra", "Container")
        loc_oCab = THIS.cnt_4c_Sombra
        WITH loc_oCab
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
        WITH loc_oCab.lbl_4c_LblSombra
            .AutoSize      = .F.
            .Top           = 18
            .Left          = 10
            .Width         = loc_oCab.Width - 20
            .Height        = 40
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .FontUnderline = .F.
            .Alignment     = 0
            .BackStyle     = 0
            .WordWrap      = .T.
            .ForeColor     = RGB(0, 0, 0)
            .Caption       = THIS.Caption
            .Visible       = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
        WITH loc_oCab.lbl_4c_LblTitulo
            .AutoSize    = .F.
            .Top         = 17
            .Left        = 10
            .Width       = loc_oCab.Width - 20
            .Height      = 46
            .FontName    = "Tahoma"
            .FontSize    = 18
            .FontBold    = .T.
            .Alignment   = 0
            .BackStyle   = 0
            .WordWrap    = .T.
            .ForeColor   = RGB(255, 255, 255)
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Caption     = THIS.Caption
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrade - grade de selecao das pendencias (legado: SIGOPMPD.
    * Grade, classe fwgrade, ColumnCount=8). So a ESTRUTURA (colunas,
    * fontes, CheckBox embutido) - RecordSource/ControlSource ficam em
    * CarregarGrade(), chamado DEPOIS do cursor existir (regra #41).
    *
    * ColumnOrder reproduz o dump: visualmente a ordem eh seleciona,
    * empresa, operacao, codigo, data, Column8 (Produto, ColumnOrder=6),
    * Grupo/Origem (Column6, ColumnOrder=7), Conta/Destino (Column7,
    * ColumnOrder=8) - o Produto aparece ANTES de Origem/Destino apesar
    * de ser fisicamente a Column8.
    *
    * Column4 "codigo" substitui a classe Ingrid1 (framework.vcx, seek
    * incremental por cordertag/cseektag) por TextBox comum: nenhum outro
    * metodo deste dialogo depende do seek incremental, so do foco
    * inicial (THIS.CarregarGrade() faz SetFocus nela, equivalente a
    * "ThisForm.Grade.Codigo.Ingrid1.SetFocus" do fim do Init legado).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrade()
        THIS.AddObject("grd_4c_Grade", "Grid")

        WITH THIS.grd_4c_Grade
            .Top               = 89
            .Left              = 12
            .Width             = 675
            .Height            = 130
            .ColumnCount       = 8
            .FontName          = "Tahoma"
            .FontSize          = 8
            .AllowHeaderSizing = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ScrollBars        = 2
            *-- Grid.ReadOnly propaga para as colunas - por isso vem ANTES
            *-- delas (regra do projeto)
            .ReadOnly          = .F.
            .Visible           = .T.
        ENDWITH

        *-- Column1 "seleciona" - so a ESTRUTURA aqui (regra #41/#18). O
        *-- CheckBox embutido NAO nasce neste metodo: .ColumnCount = 8 (fim
        *-- deste PROCEDURE) auto-liga a Column1 ao alias CORRENTE do work
        *-- area no instante em que eh atribuido, e SigOpMpdBO.Init() termina
        *-- com "SELECT crSigCdPam / GO TOP" - o alias corrente aqui eh
        *-- crSigCdPam, cujo 1o campo (CuniPPads) eh CHARACTER. AddObject de
        *-- um CheckBox (.Value nasce NUMERICO) contra uma coluna ligada a
        *-- texto estoura no PROPRIO AddObject: "Error with
        *-- CHK_4C_SELECIONAR - Value : Data type mismatch" - o InicializarForm
        *-- devolve .F., CREATEOBJECT devolve .F. e a tela nao abre (mesma
        *-- causa raiz medida em FormSigOpLoc/FormSigOpLcZ/FormSigOpLcl).
        *-- A caixa so nasce em GarantirCheckBoxSelecionar(), chamada por
        *-- CarregarGrade() DEPOIS de Column1.ControlSource apontar para
        *-- TmpPends.Flag (Logico). Legado: fwcheckbox1, ControlSource =
        *-- TmpPends.Flag, editavel SO em modo INCLUIR (When do legado:
        *-- Return (Op_Escolha = 'INSERIR')).
        WITH THIS.grd_4c_Grade.Column1
            .Width     = 15
            .FontName  = "Tahoma"
            .FontSize  = 9
            .Movable   = .F.
            .Resizable = .F.
            *-- valor de NASCIMENTO; a autoridade sobre esta propriedade eh
            *-- THIS.HabilitarCampos(), que a reafirma depois de cada bind
            *-- de RecordSource (que a reseta) - ver CarregarGrade()
            .ReadOnly  = (THIS.this_cModoAtual != "INCLUIR")
        ENDWITH
        WITH THIS.grd_4c_Grade.Column1.Header1
            .FontName  = "Tahoma"
            .Alignment = 2
            .Caption   = ""
        ENDWITH

        *-- Column2 "empresa"
        WITH THIS.grd_4c_Grade.Column2
            .Width     = 25
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .F.
        ENDWITH
        WITH THIS.grd_4c_Grade.Column2.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Emp"
        ENDWITH
        WITH THIS.grd_4c_Grade.Column2.Text1
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column3 "operacao"
        WITH THIS.grd_4c_Grade.Column3
            .Width     = 125
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .F.
        ENDWITH
        WITH THIS.grd_4c_Grade.Column3.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o"
        ENDWITH
        WITH THIS.grd_4c_Grade.Column3.Text1
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column4 "codigo" - foco inicial do dialogo
        WITH THIS.grd_4c_Grade.Column4
            .Width     = 70
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .F.
        ENDWITH
        WITH THIS.grd_4c_Grade.Column4.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "C" + CHR(243) + "d"
        ENDWITH
        WITH THIS.grd_4c_Grade.Column4.Text1
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column5 "data"
        WITH THIS.grd_4c_Grade.Column5
            .Width     = 60
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .F.
        ENDWITH
        WITH THIS.grd_4c_Grade.Column5.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Data"
        ENDWITH
        WITH THIS.grd_4c_Grade.Column5.Text1
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Alignment   = 3
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column6 "Grupo" (Origem) - ColumnOrder=7 no dump: aparece
        *-- DEPOIS do Produto (Column8, ColumnOrder=6) na grade visual
        WITH THIS.grd_4c_Grade.Column6
            .Width       = 120
            .ColumnOrder = 7
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .F.
        ENDWITH
        WITH THIS.grd_4c_Grade.Column6.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Origem"
        ENDWITH
        WITH THIS.grd_4c_Grade.Column6.Text1
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column7 "Conta" (Destino) - ColumnOrder=8
        WITH THIS.grd_4c_Grade.Column7
            .Width       = 120
            .ColumnOrder = 8
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .F.
        ENDWITH
        WITH THIS.grd_4c_Grade.Column7.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Destino"
        ENDWITH
        WITH THIS.grd_4c_Grade.Column7.Text1
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column8 "Produto" - ColumnOrder=6 (aparece ANTES de
        *-- Origem/Destino), SEMPRE ReadOnly (legado: Column8.ReadOnly=.T.)
        WITH THIS.grd_4c_Grade.Column8
            .Width       = 103
            .ColumnOrder = 6
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ReadOnly    = .T.
        ENDWITH
        WITH THIS.grd_4c_Grade.Column8.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Produto"
        ENDWITH
        WITH THIS.grd_4c_Grade.Column8.Text1
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesAcao - Shape2 (moldura decorativa) + ok (fecha o
    * dialogo) + SELTUDO/APAGA (marcar/desmarcar tudo). Ordem identica ao
    * dump (SECAO 1): Shape2, ok, SELTUDO, APAGA - todos filhos diretos do
    * form, criados DEPOIS da grade.
    *
    * Visible/Enabled de SelTudo/Apaga NAO sao decididos aqui: moram em
    * AjustarBotoesPorModo(), chamada no FIM deste metodo e reaproveitada
    * por HabilitarCampos(). Eh la que estao transcritos o
    * "ThisForm.SelTudo.Visible = (Op_Escolha = 'INSERIR')" do Init legado
    * e o When dos dois botoes (Inlist('INSERIR','ALTERAR')).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesAcao()

        *-- Shape2 (legado: moldura decorativa atras do botao ok)
        THIS.AddObject("shp_4c_Shape2", "Shape")
        WITH THIS.shp_4c_Shape2
            .Top         = 12
            .Left        = 702
            .Width       = 90
            .Height      = 110
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH

        *-- ok (legado: SIGOPMPD.ok, fwbtng) - fecha o dialogo; a
        *-- reabilitacao do form pai mora em Destroy()
        THIS.AddObject("cmd_4c_Ok", "CommandButton")
        WITH THIS.cmd_4c_Ok
            .Top             = 3
            .Left            = 723
            .Width           = 75
            .Height          = 75
            .Caption         = "OK"
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .ToolTipText     = "OK"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .Visible         = .T.
        ENDWITH

        *-- SELTUDO/APAGA - Visible/Enabled por modo ficam em
        *-- AjustarBotoesPorModo(), no fim deste metodo
        THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
        WITH THIS.cmd_4c_SelTudo
            .Top         = 226
            .Left        = 21
            .Width       = 36
            .Height      = 36
            .Caption     = ""
            .FontName    = "Verdana"
            .FontSize    = 8
            .ForeColor   = RGB(36, 84, 155)
            .BackColor   = RGB(255, 255, 255)
            .Themes           = .T.
            .ToolTipText = "Seleciona tudo"
            .Picture     = gc_4c_CaminhoIcones + "geral_selecionar_26.jpg"
        ENDWITH

        THIS.AddObject("cmd_4c_Apaga", "CommandButton")
        WITH THIS.cmd_4c_Apaga
            .Top         = 226
            .Left        = 63
            .Width       = 36
            .Height      = 36
            .Caption     = ""
            .FontName    = "Verdana"
            .FontSize    = 8
            .ForeColor   = RGB(36, 84, 155)
            .BackColor   = RGB(255, 255, 255)
            .Themes           = .T.
            .ToolTipText = "Apaga tudo"
            .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
        ENDWITH

        *-- legado (fim do Init): ThisForm.SelTudo.Visible / ThisForm.Apaga.
        *-- Visible atribuidos DEPOIS de os botoes existirem
        THIS.AjustarBotoesPorModo()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarEventosGrade - BINDEVENT do CheckBox de selecao e do
    * redirecionamento de foco das colunas de exibicao. Legado: GotFocus de
    * empresa/operacao/data/Grupo/Conta/Column8 (Text1) chama
    * "ThisForm.Grade.Seleciona.fwcheckbox1.SetFocus" incondicionalmente -
    * Column4 "codigo" NAO entra aqui, eh o foco inicial natural do
    * dialogo. Handlers alvo sao PUBLIC de proposito - BINDEVENT falha em
    * silencio com metodo PROTECTED (regra #3).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEventosGrade()
        *-- chk_4c_Selecionar ainda NAO existe aqui (so nasce em
        *-- GarantirCheckBoxSelecionar, chamado por CarregarGrade DEPOIS do
        *-- bind real de Column1.ControlSource - ver nota em ConfigurarGrade
        *-- e no cabecalho de GarantirCheckBoxSelecionar) - o BINDEVENT dela
        *-- mora junto do proprio AddObject, nao aqui.
        BINDEVENT(THIS.grd_4c_Grade.Column2.Text1, "GotFocus", THIS, "FocarColunaSelecao")
        BINDEVENT(THIS.grd_4c_Grade.Column3.Text1, "GotFocus", THIS, "FocarColunaSelecao")
        BINDEVENT(THIS.grd_4c_Grade.Column5.Text1, "GotFocus", THIS, "FocarColunaSelecao")
        BINDEVENT(THIS.grd_4c_Grade.Column6.Text1, "GotFocus", THIS, "FocarColunaSelecao")
        BINDEVENT(THIS.grd_4c_Grade.Column7.Text1, "GotFocus", THIS, "FocarColunaSelecao")
        BINDEVENT(THIS.grd_4c_Grade.Column8.Text1, "GotFocus", THIS, "FocarColunaSelecao")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarEventosBotoes - BINDEVENT dos tres botoes de acao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEventosBotoes()
        BINDEVENT(THIS.cmd_4c_Ok, "Click", THIS, "CmdOkClick")
        BINDEVENT(THIS.cmd_4c_SelTudo, "Click", THIS, "CmdSelTudoClick")
        BINDEVENT(THIS.cmd_4c_Apaga, "Click", THIS, "CmdApagaClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * GarantirCheckBoxSelecionar - cria (uma vez, de forma IDEMPOTENTE) a
    * caixa de marcacao embutida da Column1 ("seleciona"). SO pode ser
    * chamado DEPOIS de Column1.ControlSource apontar para TmpPends.Flag
    * (Logico) - ver nota em ConfigurarGrade: no momento em que
    * .ColumnCount = 8 eh atribuido, a Column1 auto-liga ao alias CORRENTE
    * do work area (SigOpMpdBO.Init() termina em "SELECT crSigCdPam / GO
    * TOP", um cursor com 1o campo CHARACTER), e AddObject de um CheckBox
    * (.Value nasce NUMERICO) contra uma coluna ligada a texto estoura no
    * PROPRIO AddObject - mesma causa raiz ja medida e documentada em
    * FormSigOpLoc/FormSigOpLcZ/FormSigOpLcl.
    *
    * .Value NAO eh atribuido (mesma regra de FormSigOpLoc.
    * GarantirCheckBoxMarcacao): a caixa nasce com .Value LOGICO vindo da
    * linha corrente de TmpPends.Flag; atribuir .Value = 0 a converteria
    * para NUMERICO, divergindo do tipo da coluna.
    *
    * IDEMPOTENTE: fechar o cursor que eh RecordSource do Grid destroi o
    * objeto criado por Column.AddObject (CurrentControl volta a Text1) -
    * o guard PEMSTATUS evita recriar sem necessidade e evita "object
    * already exists" num segundo AddObject. O BINDEVENT mora DENTRO do
    * mesmo IF: objeto recriado eh outro objeto, e um bind duplicado sobre
    * o MESMO objeto empilharia o handler.
    *
    * CurrentControl/Sparse ficam FORA do IF, para serem reaplicados em
    * toda repintura (regra #18).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GarantirCheckBoxSelecionar()
        LOCAL loc_oColuna
        loc_oColuna = THIS.grd_4c_Grade.Column1

        IF !PEMSTATUS(loc_oColuna, "chk_4c_Selecionar", 5)
            loc_oColuna.AddObject("chk_4c_Selecionar", "CheckBox")

            WITH loc_oColuna.chk_4c_Selecionar
                .Caption   = ""
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            BINDEVENT(loc_oColuna.chk_4c_Selecionar, "InteractiveChange", ;
                THIS, "ChkSelecionarInteractiveChange")
        ENDIF

        loc_oColuna.CurrentControl = "chk_4c_Selecionar"
        loc_oColuna.Sparse         = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGrade - funil UNICO de carga + vinculo da grade. Chama
    * SigOpMpdBO.CarregarPendencias() (recria TmpPends do zero - mesma
    * semantica do "Create Cursor TmpPends" do Init legado) e so DEPOIS
    * liga RecordSource/ControlSource (regra #41 - Column.ControlSource de
    * cursor que ainda nao existe derruba o Init).
    *
    * Ordem obrigatoria: RecordSource -> ControlSource -> AddObject do
    * CheckBox (GarantirCheckBoxSelecionar) -> Width -> Header1.Caption
    * (RecordSource reseta largura, titulo e as props da Column1 - mesma
    * regra do CarregarDados de FormSigOpLrC / Problema 48 do FormCor).
    * A caixa tem de nascer DEPOIS do ControlSource e ANTES de mais nada
    * tocar a Column1 de novo - ver nota em ConfigurarGrade e no cabecalho
    * de GarantirCheckBoxSelecionar.
    *
    * Bypass de SQL em modo teste/ValidarUIFidelity (TmpNens/TmpOperacao,
    * cursores do form pai, nao existem em instanciacao headless) - a
    * grade fica com a ESTRUTURA montada (ColumnCount=8) mas sem dado
    * nenhum, o que eh suficiente para validacao de UI.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarGrade()
        LOCAL loc_lSucesso, loc_lBypassTeste, loc_oGrade, loc_cCursor, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_lBypassTeste = (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
                (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)

            loc_cCursor = THIS.this_oBusinessObject.this_cCursorPends

            *-- zera a linha corrente e as sugestoes do BO: o cursor eh
            *-- RECRIADO abaixo, e estado de uma carga anterior aplicado
            *-- sobre linhas novas aplicaria sugestao de outra pendencia
            THIS.LimparCampos()

            IF !loc_lBypassTeste
                THIS.this_oBusinessObject.CarregarPendencias()
            ENDIF

            loc_oGrade = THIS.grd_4c_Grade

            IF USED(loc_cCursor)
                loc_oGrade.RecordSource          = loc_cCursor
                loc_oGrade.Column1.ControlSource = loc_cCursor + ".Flag"
                loc_oGrade.Column2.ControlSource = loc_cCursor + ".Emps"
                loc_oGrade.Column3.ControlSource = loc_cCursor + ".Dopes"
                loc_oGrade.Column4.ControlSource = loc_cCursor + ".Numes"
                loc_oGrade.Column5.ControlSource = loc_cCursor + ".Datas"
                loc_oGrade.Column6.ControlSource = loc_cCursor + ".Origem"
                loc_oGrade.Column7.ControlSource = loc_cCursor + ".Destino"
                loc_oGrade.Column8.ControlSource = loc_cCursor + ".CPros"

                *-- SO AGORA Column1 esta ligada a Flag (Logico) - eh seguro
                *-- criar o CheckBox embutido (ver nota no cabecalho deste
                *-- metodo e em GarantirCheckBoxSelecionar)
                THIS.GarantirCheckBoxSelecionar()

                loc_oGrade.Column1.Width = 15
                loc_oGrade.Column2.Width = 25
                loc_oGrade.Column3.Width = 125
                loc_oGrade.Column4.Width = 70
                loc_oGrade.Column5.Width = 60
                loc_oGrade.Column6.Width = 120
                loc_oGrade.Column7.Width = 120
                loc_oGrade.Column8.Width = 103

                loc_oGrade.Column1.Header1.Caption = ""
                loc_oGrade.Column2.Header1.Caption = "Emp"
                loc_oGrade.Column3.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
                loc_oGrade.Column4.Header1.Caption = "C" + CHR(243) + "d"
                loc_oGrade.Column5.Header1.Caption = "Data"
                loc_oGrade.Column6.Header1.Caption = "Origem"
                loc_oGrade.Column7.Header1.Caption = "Destino"
                loc_oGrade.Column8.Header1.Caption = "Produto"

                *-- RecordSource repropagou Grid.ReadOnly = .F. para TODAS
                *-- as colunas: HabilitarCampos reafirma o When do
                *-- fwcheckbox1 (Column1) E o Column8.ReadOnly = .T. do
                *-- legado, que sem isto ficava editavel depois da carga
                THIS.HabilitarCampos(.T.)

                SELECT (loc_cCursor)
                GO TOP
                loc_oGrade.Refresh()

                *-- Legado: ThisForm.Grade.Codigo.Ingrid1.SetFocus
                IF loc_oGrade.ColumnCount >= 4
                    loc_oGrade.SetFocus()
                    loc_oGrade.ActiveColumn = 4
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpMpd.CarregarGrade")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ResetarSugestoesBO - zera as 6 flags this_lAtualizar* do BO antes de
    * CADA chamada a Marcar(). O BO as seta dentro de
    * ProcessarFaseDaMarcacao() mas nao as reseta sozinho (sao properties
    * de instancia que sobrevivem entre chamadas) - sem este reset, uma
    * fase que NAO precisa atualizar Origem/Destino/Responsavel herdaria o
    * valor deixado por uma fase ANTERIOR, aplicando sugestao estagnada.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ResetarSugestoesBO()
        LOCAL loc_oBO
        loc_oBO = THIS.this_oBusinessObject

        loc_oBO.this_lAtualizarOrigemGrupo  = .F.
        loc_oBO.this_lAtualizarOrigemConta  = .F.
        loc_oBO.this_lAtualizarDestinoGrupo = .F.
        loc_oBO.this_lAtualizarDestinoConta = .F.
        loc_oBO.this_lAtualizarRespGrupo    = .F.
        loc_oBO.this_lAtualizarRespConta    = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarSugestoesAoFormPai - leva as sugestoes calculadas por
    * Marcar() (this_lAtualizar*/this_c*Calculado) e as descricoes de
    * conta (this_cXxxContaDescricao, sempre reatribuidas, como no
    * legado) para os campos de Origem/Destino/Responsavel do form pai.
    *
    * Legado: With ThisForm.ParentForm.Pagina.Dados ... EndWith, seguido
    * de ThisForm.ParentForm.Pagina.Dados.Refresh. Aqui, caminho
    * equivalente (FormEpd): this_oFormPai.pgf_4c_Paginas.Page2.
    * cnt_4c_Origem/cnt_4c_Destino/cnt_4c_Responsavel.
    *
    * Tudo sob PEMSTATUS: este dialogo so tem UM chamador real (FormEpd),
    * mas a guarda evita estourar caso seja aberto, no futuro, por um
    * form pai com estrutura diferente (ou em teste, sem form pai real).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarSugestoesAoFormPai()
        LOCAL loc_oBO, loc_oPg2, loc_oErro

        TRY
            loc_oBO = THIS.this_oBusinessObject

            IF VARTYPE(THIS.this_oFormPai) = "O" AND PEMSTATUS(THIS.this_oFormPai, "pgf_4c_Paginas", 5)
                loc_oPg2 = THIS.this_oFormPai.pgf_4c_Paginas.Page2

                IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
                    IF loc_oBO.this_lAtualizarOrigemGrupo
                        loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOs.Value = ALLTRIM(loc_oBO.this_cOrigemGrupoCalculado)
                    ENDIF
                    IF loc_oBO.this_lAtualizarOrigemConta
                        loc_oPg2.cnt_4c_Origem.txt_4c_ContaOs.Value = ALLTRIM(loc_oBO.this_cOrigemContaCalculada)
                    ENDIF
                    loc_oPg2.cnt_4c_Origem.txt_4c_NomeContaOs.Value = loc_oBO.this_cOrigemContaDescricao
                ENDIF

                IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5)
                    IF loc_oBO.this_lAtualizarDestinoGrupo
                        loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDs.Value = ALLTRIM(loc_oBO.this_cDestinoGrupoCalculado)
                    ENDIF
                    IF loc_oBO.this_lAtualizarDestinoConta
                        loc_oPg2.cnt_4c_Destino.txt_4c_ContaDs.Value = ALLTRIM(loc_oBO.this_cDestinoContaCalculada)
                    ENDIF
                    loc_oPg2.cnt_4c_Destino.txt_4c_NomeContaDs.Value = loc_oBO.this_cDestinoContaDescricao
                ENDIF

                IF PEMSTATUS(loc_oPg2, "cnt_4c_Responsavel", 5)
                    IF loc_oBO.this_lAtualizarRespGrupo
                        loc_oPg2.cnt_4c_Responsavel.txt_4c_GrVends.Value = ALLTRIM(loc_oBO.this_cRespGrupoCalculado)
                    ENDIF
                    IF loc_oBO.this_lAtualizarRespConta
                        loc_oPg2.cnt_4c_Responsavel.txt_4c_Vends.Value = ALLTRIM(loc_oBO.this_cRespContaCalculada)
                    ENDIF
                    loc_oPg2.cnt_4c_Responsavel.txt_4c_NomeVends.Value = loc_oBO.this_cRespContaDescricao
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpMpd.AplicarSugestoesAoFormPai")
        ENDTRY

        *-- fecha o espelho BO -> TELA (Amarra de volta ao pai + Refresh da
        *-- pagina de dados dele), equivalente ao "ThisForm.ParentForm.
        *-- Pagina.Dados.Refresh" da ultima linha de marca() no legado
        THIS.BOParaForm()
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarPaginaDadosFormPai - legado: ThisForm.ParentForm.Pagina.
    * Dados.Refresh, chamado incondicionalmente no fim de marca() e de
    * desmarca().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarPaginaDadosFormPai()
        IF VARTYPE(THIS.this_oFormPai) = "O" AND PEMSTATUS(THIS.this_oFormPai, "pgf_4c_Paginas", 5)
            THIS.this_oFormPai.pgf_4c_Paginas.Page2.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FocarColunaSelecao - legado: GotFocus das colunas de exibicao
    * (empresa/operacao/data/Grupo/Conta/Column8) redireciona SEMPRE para
    * o CheckBox da coluna "seleciona" - nenhuma delas eh digitavel.
    *--------------------------------------------------------------------------
    PROCEDURE FocarColunaSelecao()
        IF PEMSTATUS(THIS, "grd_4c_Grade", 5) AND PEMSTATUS(THIS.grd_4c_Grade.Column1, "chk_4c_Selecionar", 5)
            THIS.grd_4c_Grade.Column1.chk_4c_Selecionar.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkSelecionarInteractiveChange - legado: fwcheckbox1.InteractiveChange
    *     =DoDefault()
    *     If Not This.Value
    *         ThisForm.Desmarca
    *     Else
    *         This.Value = ThisForm.Marca()
    *     EndIf
    *
    * O ControlSource ja gravou o novo valor em TmpPends.Flag ANTES deste
    * handler disparar (mesma premissa do legado). Em .T. (marcando),
    * Marcar() pode recusar (pendencia duplicada/ja usada) - nesse caso
    * desfaz o Flag (equivalente a "This.Value = ThisForm.Marca()", que
    * reatribui .F. quando a marcacao falha). Em .F. (desmarcando), o
    * legado nao usa o retorno de Desmarca().
    *--------------------------------------------------------------------------
    PROCEDURE ChkSelecionarInteractiveChange()
        LOCAL loc_cAlias, loc_lNovoValor, loc_lResultado, loc_oErro

        TRY
            loc_cAlias = THIS.this_oBusinessObject.this_cCursorPends

            IF USED(loc_cAlias)
                SELECT (loc_cAlias)
                loc_lNovoValor = ConverterParaLogico(Flag)

                *-- TELA -> BO: linha corrente da grade (unico "campo" deste
                *-- dialogo) + contador Amarra do form pai
                THIS.FormParaBO()

                IF loc_lNovoValor
                    THIS.ResetarSugestoesBO()
                    loc_lResultado = THIS.this_oBusinessObject.Marcar(.F.)

                    IF loc_lResultado
                        THIS.AplicarSugestoesAoFormPai()
                    ELSE
                        SELECT (loc_cAlias)
                        REPLACE Flag WITH .F.
                    ENDIF
                ELSE
                    THIS.this_oBusinessObject.Desmarcar()
                    *-- legado desmarca: recalcula ThisForm.parentform.
                    *-- EditaOrigem e so entao repinta a pagina do pai
                    THIS.AplicarPermissaoOrigemAoFormPai()
                ENDIF

                SELECT (loc_cAlias)
                THIS.grd_4c_Grade.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpMpd.ChkSelecionarInteractiveChange")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdSelTudoClick - legado: SELTUDO.Click
    *     Select TmpPends
    *     Scan For Not Flag
    *         Replace Flag With ThisForm.Marca(.t.)
    *     EndScan
    *     ThisForm.Grade.Refresh
    *--------------------------------------------------------------------------
    PROCEDURE CmdSelTudoClick()
        LOCAL loc_cAlias, loc_lResultado, loc_oErro

        TRY
            loc_cAlias = THIS.this_oBusinessObject.this_cCursorPends

            IF USED(loc_cAlias)
                SELECT (loc_cAlias)
                SCAN FOR !Flag
                    THIS.FormParaBO()
                    THIS.ResetarSugestoesBO()
                    loc_lResultado = THIS.this_oBusinessObject.Marcar(.T.)

                    IF loc_lResultado
                        THIS.AplicarSugestoesAoFormPai()
                    ENDIF

                    SELECT (loc_cAlias)
                    REPLACE Flag WITH loc_lResultado
                ENDSCAN

                THIS.grd_4c_Grade.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpMpd.CmdSelTudoClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdApagaClick - legado: APAGA.Click
    *     Select TmpPends
    *     Scan For Flag
    *         Replace Flag With .f.
    *         =ThisForm.Desmarca()
    *     EndScan
    *     ThisForm.Grade.Refresh
    *--------------------------------------------------------------------------
    PROCEDURE CmdApagaClick()
        LOCAL loc_cAlias, loc_oErro

        TRY
            loc_cAlias = THIS.this_oBusinessObject.this_cCursorPends

            IF USED(loc_cAlias)
                SELECT (loc_cAlias)
                SCAN FOR Flag
                    SELECT (loc_cAlias)
                    REPLACE Flag WITH .F.
                    THIS.FormParaBO()
                    THIS.this_oBusinessObject.Desmarcar()
                    THIS.AplicarPermissaoOrigemAoFormPai()
                    SELECT (loc_cAlias)
                ENDSCAN

                THIS.grd_4c_Grade.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpMpd.CmdApagaClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdOkClick - legado: SIGOPMPD.ok.Click
    *     ThisForm.ParentForm.Enabled = .t.
    *     ThisForm.Release
    * (a reabilitacao do form pai ja mora em Destroy(), que DODEFAULT()
    * aciona na liberacao do objeto)
    *--------------------------------------------------------------------------
    PROCEDURE CmdOkClick()
        THIS.FecharDialogo()
    ENDPROC

    *--------------------------------------------------------------------------
    * FecharDialogo - saida UNICA da tela. O dialogo tem ControlBox = .F. e
    * Closable = .F. (valores do SCX legado), portanto nao ha X nem ESC:
    * o botao OK eh o unico caminho que o legado oferece, e todos os nomes
    * canonicos de saida do projeto apontam para aqui.
    *--------------------------------------------------------------------------
    PROCEDURE FecharDialogo()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - nome canonico do projeto para o botao de saida.
    * Aqui o botao de saida eh o OK do legado (SIGOPMPD.ok), por isso
    * delega ao mesmo funil.
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.FecharDialogo()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - nome canonico do projeto para "sair sem gravar".
    * Nesta tela nao existe o que cancelar: nao ha botao de gravar porque
    * cada marcacao/desmarcacao JA persistiu na hora (SigOpMpdBO.Atualizar
    * -> UPDATE SigCdNec.ChkSubn, mais as linhas gravadas/apagadas nos
    * cursores do form pai), exatamente como no legado - que tambem nao
    * oferece caminho de descarte. Logo "cancelar" aqui eh fechar, e o
    * handler delega ao mesmo funil de saida em vez de dar ao usuario a
    * impressao falsa de que algo seria desfeito.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.FecharDialogo()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - nome canonico do projeto para o carregador da lista
    * (eh por ele que o harness de teste automatizado entra:
    * utils\TesteAutomatico.prg chama THIS.oForm.CarregarLista() de FORA da
    * classe, por isso PUBLIC - metodo PROTECTED falharia em runtime).
    * Delega ao funil unico desta tela, CarregarGrade(), que eh quem popula
    * TmpPends e religa a grade - mesmo padrao dos irmaos FormSigPdMp5,
    * FormSigPdMp8, FormSigPrPcp e FormSigPrSlp.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN THIS.CarregarGrade()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - transferencia TELA -> BO. Hook canonico do FormBase (lah
    * ele eh PROTECTED e vazio; PROTECTED aqui pelo mesmo motivo - so o
    * proprio form chama).
    *
    * O unico "campo" deste dialogo eh a LINHA CORRENTE da grade de
    * selecao: as oito colunas (Flag/Emps/Dopes/Numes/Datas/Origem/Destino/
    * CPros) estao ligadas por ControlSource direto ao cursor TmpPends, e eh
    * dessa linha que Marcar()/Desmarcar() partem. CarregarDoCursor() copia
    * a linha para as properties de linha corrente do BO
    * (this_lFlag/this_cEmps/.../this_cCPros).
    *
    * Leva tambem o contador Amarra, que no legado vive no form PAI
    * (ThisForm.ParentForm.Amarra, somado 1 a cada item de fase gravado em
    * xOpi/xPesa dentro de marca) e aqui vive em SigOpMpdBO.this_nAmarra -
    * ler o valor do pai ANTES de marcar eh o que mantem a numeracao
    * continua entre o que o pai gravou e o que este dialogo grava. O pai
    * atual (Formepd) ainda nao declara a property, por isso o PEMSTATUS:
    * sem ela o BO segue com o proprio contador, que eh o comportamento
    * documentado no cabecalho de SigOpMpdBO.prg.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oBO, loc_cAlias

        loc_oBO = THIS.this_oBusinessObject

        IF VARTYPE(loc_oBO) = "O"
            loc_cAlias = loc_oBO.this_cCursorPends

            IF VARTYPE(loc_cAlias) = "C" AND !EMPTY(loc_cAlias) AND USED(loc_cAlias)
                loc_oBO.CarregarDoCursor(loc_cAlias)
            ENDIF

            IF VARTYPE(THIS.this_oFormPai) = "O" AND ;
               PEMSTATUS(THIS.this_oFormPai, "this_nAmarra", 5)
                loc_oBO.this_nAmarra = TratarNulo(THIS.this_oFormPai.this_nAmarra, 0)
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - transferencia BO -> TELA. Hook canonico do FormBase
    * (PROTECTED, como lah).
    *
    * Nao repete mapeamento de campo: as oito colunas da grade leem o
    * cursor por ControlSource, entao o que sobra para espelhar eh o estado
    * que o BO calculou e nao esta no cursor. Fica aqui so o que eh seguro
    * nos DOIS caminhos (marcar e desmarcar):
    *   1. Amarra de volta ao form pai (ver nota em FormParaBO);
    *   2. Refresh da pagina de dados do pai - a ultima linha tanto de
    *      marca() quanto de desmarca() no legado.
    *
    * O Refresh da PROPRIA grade NAO entra aqui de proposito: no legado ele
    * eh UM, no fim de cada Click (ThisForm.Grade.Refresh depois do Scan),
    * nunca por linha marcada. Chamado por linha, ele cairia DENTRO do SCAN
    * de SelTudo/Apaga - e repintar a grade com o ponteiro do proprio
    * RecordSource em varredura eh risco gratuito. Os handlers e
    * CarregarGrade() continuam donos desse Refresh.
    *
    * O que eh especifico de UM caminho mora no metodo daquele caminho e
    * chama este no fim, na mesma ordem do legado:
    *   AplicarSugestoesAoFormPai()        - valores de Origem/Destino/
    *                                        Responsavel, so em marca();
    *   AplicarPermissaoOrigemAoFormPai()  - EditaOrigem, so em desmarca().
    * Juntar os dois aqui regrediria a fidelidade: marca() nunca toca
    * EditaOrigem e desmarca() nunca reescreve as descricoes de conta.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oBO

        loc_oBO = THIS.this_oBusinessObject

        IF VARTYPE(loc_oBO) = "O" AND VARTYPE(THIS.this_oFormPai) = "O" AND ;
           PEMSTATUS(THIS.this_oFormPai, "this_nAmarra", 5)
            THIS.this_oFormPai.this_nAmarra = loc_oBO.this_nAmarra
        ENDIF

        THIS.AtualizarPaginaDadosFormPai()
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarPermissaoOrigemAoFormPai - legado, fim de desmarca():
    *     Select TmpOperacao
    *     _RecnoAnt = Recno()
    *     Go Top
    *     ThisForm.parentform.EditaOrigem = .t.
    *     Scan For Not Empty(Codigos)
    *         ThisForm.parentform.EditaOrigem = .f.
    *         Exit
    *     EndScan
    *
    * A varredura em si ja esta em SigOpMpdBO.DesmarcarExec(), que deixa o
    * resultado em this_lPermiteEditarOrigem (o BO nao referencia Form -
    * PILAR 3). Este metodo eh a outra metade: levar esse valor ao form
    * pai. Sem ele o recalculo morria no BO e a trava de edicao da conta de
    * Origem nunca chegava a tela - defeito fechado nesta fase.
    *
    * O pai atual (Formepd) ainda nao declara a property equivalente a
    * EditaOrigem. Enquanto nao declarar, aplica-se o EFEITO que o legado
    * produz: no SCX do pai (SIGCDEPD) EditaOrigem entra no When dos campos
    * de Origem - "Inlist(pcEscolha,'INSERIR','ALTERAR') And ThisForm.
    * EditaOrigem" - logo o equivalente eh desabilitar Grupo/Conta de
    * Origem. Assim a trava funciona hoje e passa a usar a property no dia
    * em que o pai a tiver, sem mexer neste arquivo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarPermissaoOrigemAoFormPai()
        LOCAL loc_oBO, loc_lPermite, loc_lEditavel, loc_oPg2, loc_oErro

        TRY
            loc_oBO = THIS.this_oBusinessObject

            IF VARTYPE(loc_oBO) = "O" AND VARTYPE(THIS.this_oFormPai) = "O"
                loc_lPermite = ConverterParaLogico(loc_oBO.this_lPermiteEditarOrigem)

                IF PEMSTATUS(THIS.this_oFormPai, "this_lEditaOrigem", 5)
                    THIS.this_oFormPai.this_lEditaOrigem = loc_lPermite
                ELSE
                    IF PEMSTATUS(THIS.this_oFormPai, "pgf_4c_Paginas", 5)
                        loc_oPg2 = THIS.this_oFormPai.pgf_4c_Paginas.Page2

                        IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
                            loc_lEditavel = loc_lPermite AND ;
                                INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

                            loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOs.Enabled = loc_lEditavel
                            loc_oPg2.cnt_4c_Origem.txt_4c_ContaOs.Enabled = loc_lEditavel
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "FormSigOpMpd.AplicarPermissaoOrigemAoFormPai")
        ENDTRY

        THIS.BOParaForm()
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - ponto UNICO de decisao sobre o que o usuario pode
    * editar nesta tela. Transcreve o When do CheckBox de selecao
    * (legado: SIGOPMPD.Grade.seleciona.fwcheckbox1.When -> Return
    * (ThisForm.Op_Escolha = 'INSERIR')) e reafirma o
    * Column8.ReadOnly = .T. que o SCX declara para a coluna Produto.
    *
    * Reafirmar eh obrigatorio, nao redundante: atribuir Grid.RecordSource
    * em CarregarGrade() repropaga Grid.ReadOnly = .F. para TODAS as
    * colunas (mesma regra que ali ja obrigava a reatribuir Width e
    * Header1.Caption). Por isso HabilitarCampos eh chamada DEPOIS do bind.
    *
    * par_lHabilitar opcional (default .T.) para respeitar a assinatura
    * canonica do projeto: ele so RESTRINGE - nem ele nem modo nenhum pode
    * liberar o que o legado mantem travado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar, loc_lPodeMarcar

        loc_lHabilitar  = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
        loc_lPodeMarcar = loc_lHabilitar AND (THIS.this_cModoAtual == "INCLUIR")

        IF PEMSTATUS(THIS, "grd_4c_Grade", 5)
            THIS.grd_4c_Grade.Column1.ReadOnly       = !loc_lPodeMarcar
            THIS.grd_4c_Grade.Column8.ReadOnly       = .T.
            THIS.grd_4c_Grade.Column8.Text1.ReadOnly = .T.
        ENDIF

        THIS.AjustarBotoesPorModo()
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Visible/Enabled de SelTudo e Apaga conforme o
    * modo. Transcreve DUAS regras diferentes do legado, que nao coincidem:
    *   Visible - fim do Init: ThisForm.SelTudo.Visible = ThisForm.Apaga.
    *             Visible = (Op_Escolha = 'INSERIR')
    *   Enabled - When dos dois botoes: Inlist(Op_Escolha, 'INSERIR',
    *             'ALTERAR')
    *
    * Nenhum icone fica cinza na tela por causa disso (a regra do projeto
    * sobre CommandButton icone-only, cujo Picture nao desenha com
    * Enabled = .F.): o unico modo em que Enabled vira .F. eh VISUALIZAR,
    * e nele Visible ja eh .F. - em ALTERAR o botao esta oculto mas
    * habilitado, e em INCLUIR esta visivel e habilitado.
    *
    * PUBLIC de proposito: utils\TesteAutomatico.prg chama
    * THIS.oForm.AjustarBotoesPorModo() de FORA da classe, apos escrever em
    * THIS.oForm.this_cModoAtual (regra #3 / #51).
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lVisivel, loc_lHabilitado

        loc_lVisivel    = (THIS.this_cModoAtual == "INCLUIR")
        loc_lHabilitado = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        IF PEMSTATUS(THIS, "cmd_4c_SelTudo", 5)
            THIS.cmd_4c_SelTudo.Visible = loc_lVisivel
            THIS.cmd_4c_SelTudo.Enabled = loc_lHabilitado
        ENDIF

        IF PEMSTATUS(THIS, "cmd_4c_Apaga", 5)
            THIS.cmd_4c_Apaga.Visible = loc_lVisivel
            THIS.cmd_4c_Apaga.Enabled = loc_lHabilitado
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - hook canonico do FormBase (PROTECTED, como lah).
    *
    * Esta tela nao tem TextBox de dados para limpar: o estado "de campo"
    * dela eh a linha corrente que o BO guarda (this_lFlag/this_cEmps/.../
    * this_cCPros), o par (chave, valor) do proximo UPDATE
    * (this_cCidChavesAtual/this_lChkSubn) e as sugestoes calculadas pela
    * ultima marcacao. Chamado por CarregarGrade() ANTES de recarregar:
    * CarregarPendencias() RECRIA TmpPends do zero, e estado de uma carga
    * anterior sobrevivendo a isso aplicaria no form pai sugestao de uma
    * pendencia que ja nao esta na tela, ou faria o proximo Atualizar()
    * gravar sobre o CidChaves antigo.
    *
    * NAO limpa a coluna Flag das linhas: marcacao nao eh rascunho de
    * tela - cada uma ja virou UPDATE em SigCdNec.ChkSubn e linhas nos
    * cursores do form pai. Quem desmarca eh Desmarcar(), nunca uma
    * limpeza de campos.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oBO

        loc_oBO = THIS.this_oBusinessObject

        IF VARTYPE(loc_oBO) = "O"
            loc_oBO.this_lFlag    = .F.
            loc_oBO.this_cEmps    = ""
            loc_oBO.this_cDopes   = ""
            loc_oBO.this_nNumes   = 0
            loc_oBO.this_dDatas   = {}
            loc_oBO.this_cOrigem  = ""
            loc_oBO.this_cDestino = ""
            loc_oBO.this_cCPros   = ""

            loc_oBO.this_cCidChavesAtual = ""
            loc_oBO.this_lChkSubn        = .F.

            THIS.ResetarSugestoesBO()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - reabilita o form pai (seguranca extra: o legado so faz
    * isso no Click do OK - ThisForm.ParentForm.Enabled = .t. - mas
    * reforcar aqui cobre fechamento por qualquer outro caminho) e libera
    * o Business Object. DODEFAULT() por ULTIMO (regra do projeto: sem
    * ela os popups do menu principal encolhem visualmente apos o form
    * fechar).
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oFormPai) = "O"
            THIS.this_oFormPai.Enabled = .T.
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED("TmpPends")
            USE IN TmpPends
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
