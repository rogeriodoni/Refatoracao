*==============================================================================
* FormSigOpTot.prg
* Form OPERACIONAL: Total Itens (SigOpTot.SCX migrado) - dialogo MODAL de
* totalizacao, aberto por OUTRO form (movimento/operacao, ex.: TprMvCab) para
* mostrar os totais de quantidade/peso/valor dos itens lancados, agrupamentos
* por produto e, quando a operacao exige, explosao de componentes.
*
* Legado (Init): Lparameters pform, datses
*   pform  - formulario de origem (ThisForm.ParentForm)
*   datses - DataSessionId do formulario de origem (Set Datasession To DatSes),
*            necessario porque os cursores que este dialogo le/soma
*            (crSigCdOpe/TprMvCab/crTpmMvItn/crTpmMvIts/crTpmMvItn3/
*            crSigOpCdc/crSigOpCdd) ja estao abertos LA, na DataSession
*            PRIVADA do formulario pai, e SIGOPTOT.SCX tambem tem
*            DataSession=2 (privada) - sem o Set Datasession To, este
*            dialogo nao veria nenhum deles.
*
* Uso canonico (a ser fixado nas Fases seguintes, no form de movimento que
* abrir este dialogo):
*   loForm = CREATEOBJECT("FormSigOpTot", THISFORM, SET("Datasession"))
*   IF VARTYPE(loForm) = "O"
*       loForm.Show()
*   ENDIF
*
* Layout: form PLANO, SEM PageFrame - o SCX legado nao tem PageFrame algum
* (cntSombra + grades de totais direto na form + bloco de campos de total +
* CommandGroup OK). NAO segue o padrao Page1(Lista)/Page2(Dados) de CRUD, e
* nao ha sequer o padrao generico Lista/Dados de outros forms OPERACIONAL
* com grid editavel (ex.: FormFpm) - este e um dialogo de CONSULTA/
* totalizacao, mesma familia de FormSigOpCcj/FormSigOpAut (dialogos OPERACIONAL
* planos da familia SigOp). Form 1127x600, DataSession=2 (igual ao legado).
*
* Fase 3/8 - Estrutura base: propriedades visuais (PILAR 1, transcritas de
* tasks\task813\SigOpTot_form_codigo_fonte.txt, SECAO 2), Init() recebendo
* par_oParentForm/par_nDataSessionId (equivalentes a pform/datses do legado,
* com o mesmo Set Datasession To antes de qualquer outra coisa),
* InicializarForm() (cria SigOpTotBO + DefinirContexto + cabecalho) e o
* cabecalho (cntSombra -> cnt_4c_Cabecalho, com os valores EXATOS do dump:
* FontSize=18, lblSombra Top=18/ForeColor preto, lblTitulo Top=17/ForeColor
* branco).
*
* Fase 4/8 - Grades: SIGOPTOT NAO tem PageFrame nem botoes CRUD - o template
* generico de fase 4 ["Grid e Botoes CRUD (Page1)"] nao se aplica a este
* dialogo (nao ha Incluir/Alterar/Excluir/Buscar no SCX legado, so as 6
* grades de totalizacao e o botao OK/Retornar - ver cabecalho acima e
* meta_prompt.md). Adicionados ConfigurarGrades() (estrutura visual das 6
* grades + cursores placeholder, EXATOS do dump: Grade_ProdutoTam ->
* grd_4c_ProdutoTam, grade_total -> grd_4c_TotalProdutos, GrdTCompo ->
* grd_4c_Componentes, Grade_Serv -> grd_4c_Servicos, Grade_Produto ->
* grd_4c_Produto, Container1+GradeCol -> cnt_4c_CalculoCol+grd_4c_Col - os
* nomes _4c_ sao DIFERENTES do placeholder generico "grd_4c_Dados" do
* mapeamento.json, que colapsa as 6 grades em 1 nome so e nao serve aqui -
* regra PILAR 3) e CarregarLista() (chama SigOpTotBO.ProcessarTotais e
* rebinda cada grade ao cursor real do BO, com a mesma exclusao mutua
* Grade_Serv/Grade_ProdutoTam e o toggle de GrdTCompo do Init legado,
* linhas 1580-1591). cnt_4c_CalculoCol (Container1/GradeCol) e reproduzido
* so por fidelidade estrutural (PILAR 1): no legado ele e Visible=.F. e
* NUNCA tem RecordSource atribuido em lugar nenhum do form (nem Init nem
* calctotais) - fica permanentemente oculto, igual ao original.
* Adicionados tambem ConfigurarBotoes() (SIGOPTOT.OK -> cmg_4c_OK: o
* CommandGroup de um unico botao "Retornar", no canto superior direito, com
* os valores EXATOS do dump) e BtnSairClick(), que transcreve as duas
* acoes do btnSair.Click legado (reabilitar o form pai + Release). O metodo
* de carga chama-se CarregarLista() e e PUBLIC, porque o harness de teste
* automatizado o aciona de FORA da classe (regra CLAUDE.md #3). O bloco de
* campos de total (Label1-5/Get_TotQtde/Get_TotPeso/Get_TotPesoC/
* Get_Compensacao/Get_mtcub/lblTotPes/getTotPes) e os eventos de recalculo
* entram nas fases seguintes.
*
* Fase 5/8 - Campos principais (parte 1/2): adicionado ConfigurarCamposTotais()
* com a PRIMEIRA metade do bloco de campos de total do dump (SECAO 2 -
* Label1/Get_TotQtde "Total Quantidade", Label2/Get_TotPeso "Total do Peso" e
* os indicadores de sinal Get_QOper/Get_POper, que ficam na MESMA linha dos
* dois primeiros, direto na form - no legado nenhum tem ControlSource: o
* proprio CalcTotais() escreve o valor via .Value (fase de eventos, ainda
* nao migrada). Valores (Top/Left/Width/Height/Format/ToolTipText) EXATOS do
* dump (PILAR 1). A segunda metade (Label3/Get_TotPesoC, Label4/
* Get_Compensacao, Label5/Get_mtcub e lblTotPes/getTotPes) entra na Fase 6.
*
* Fase 6/8 - Campos restantes (parte 2/2) e evento do unico campo editavel:
* completado ConfigurarCamposTotais() com a SEGUNDA metade do bloco de
* campos de total (Label3/txt_4c_TotPesoC "Total do Peso C", Label4/
* txt_4c_Compensacao "Peso Unitario C" - o UNICO campo editavel deste
* dialogo, Label5/txt_4c_Mtcub "TT Metro Cubico" - nasce Visible=.F. igual
* ao dump, so aparece quando SigOpTotBO.this_lMostrarMtCub fica .T. - e
* lblTotPes/txt_4c_TotPes, com o rotulo dinamico "Total <DocQtd2s> :"/
* "Total Peso :" que o BO calcula em PrepararRotuloTotalPeso). Nao ha
* lookup nenhum neste form (dialogo de totalizacao, sem FormBuscaAuxiliar -
* ver analise.json/mapeamento.json, secao "lookups" vazia): o unico campo
* nao somente-leitura e txt_4c_Compensacao, ligado via BINDEVENT "LostFocus"
* (regra CLAUDE.md - Valid nao dispara de forma confiavel em TextBox) ao
* metodo PUBLIC ValidarCompensacao(), que reproduz literalmente o
* PROCEDURE Valid de Get_Compensacao (linhas 1767-1779 do dump): grava o
* valor digitado no cursor COMPARTILHADO TprMvCab.VCompensas ANTES de
* chamar SigOpTotBO.ValidarCompensacao() - CalcularTotais() (chamado por
* ValidarCompensacao) le TprMvCab.VCompensas direto do cursor, igual ao
* legado (onde o ControlSource 'TprMvCab.VCompensas' escreve no cursor
* antes do Valid rodar) - se o valor for invalido (negativo), desfaz a
* gravacao no cursor e repoe o TextBox com o valor anterior, com
* MsgAviso("Valor de Compensacao Invalido") no lugar do MessageBox cru do
* legado. RebindCamposTotais() (chamado ao fim de CarregarLista() e de
* ValidarCompensacao(), sempre depois que o BO recalculou) espelha nos
* controles os totais do BO (this_nTotQtde/this_cQOper/this_nTotPeso/
* this_cPOper/this_nTotPesoC/this_nTotPes/this_cRotuloTotalPeso/
* this_lMostrarMtCub/this_nMtCub) e o valor corrente de
* TprMvCab.VCompensas, e decide o ReadOnly de txt_4c_Compensacao pelo MESMO
* criterio do When legado (InList(ParentForm.Op_Escolha,'INSERIR',
* 'ALTERAR')) - unica forma praticavel de reproduzir When via BINDEVENT
* em TextBox (regra CLAUDE.md #3), e suficiente porque este dialogo e
* modal e Op_Escolha do form pai nao muda durante a vida dele.
*
* Fase 7/8 - Eventos principais: SIGOPTOT NAO tem Incluir/Alterar/Visualizar/
* Excluir no legado - comportamento.json confirma um UNICO evento de botao
* (SIGOPTOT.OK.Click) entre os 24 metodos do dump; os demais 22 (Text1.When
* das 6 grades + Get_Compensacao.When) so retornam .F./InList(...) e nao
* abrem Click/DblClick nenhum. O "evento principal" deste dialogo e o botao
* de retorno ao form pai, cujo handler (BtnSairClick, transcrito do
* btnSair.Click legado) e o BINDEVENT que o liga ja foram escritos na
* Fase 4/8, junto com ConfigurarBotoes() - nao ha codigo novo para esta fase
* alem desta nota. O unico outro evento interativo do dialogo, o Valid do
* campo editavel (Get_Compensacao), tambem ja foi migrado (ValidarCompensacao,
* Fase 6/8).
*
* Metodos CRUD-canonicos (BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/
* BtnExcluirClick) NAO se aplicam: o legado nao tem Page1(Lista)/Page2(Dados)
* nem modos INCLUIR/ALTERAR/VISUALIZAR/EXCLUIR (analise.json: campos/lookups
* vazios; layout.json sem BaseClass PageFrame/Grid fora das 6 grades de
* totalizacao), e inventa-los criaria estrutura que o legado nao tem (viola
* PILAR 1) ou stub vazio sem logica real (reprovado pela regra de
* completude) - mesma analise de FormSigOpCcj.prg/FormSigOpAlC.prg, familia
* SigOp. Este e um dialogo de CONSULTA/totalizacao (ver nota no topo do
* arquivo); nao ha FormParaBO/BOParaForm no sentido CRUD porque nao ha uma
* unica entidade editavel - o campo editavel grava direto no cursor
* compartilhado do form pai (ValidarCompensacaoExec) e os totais sao so
* exibidos (RebindCamposTotais), nunca gravados pelo usuario.
*
* Fase 8/8 - Consolidacao final: pela mesma analise das Fases 7-8 acima,
* nenhum dos metodos genericos de fechamento do template CRUD se aplica a
* este dialogo - cada um foi conferido individualmente contra o dump e
* contra comportamento.json (24 metodos, nenhum deles Buscar/Salvar/
* Cancelar/Encerrar):
*   - BtnBuscarClick/BtnSalvarClick/BtnCancelarClick: nao existem no
*     legado (sem Page1/Page2, sem modo INCLUIR/ALTERAR com commit
*     proprio) e inventa-los duplicaria Inserir()/ExecutarExclusao(), que
*     sao passos INTERNOS de ProcessarComponentes() (area de troca
*     SigTempD), nunca acoes que o usuario aciona por um botao.
*   - BtnEncerrarClick: e o BtnSairClick ja existente (Fase 4/8) - o
*     unico botao do dialogo (SIGOPTOT.OK/"Retornar") e a saida.
*   - HabilitarCampos/LimparCampos: nao ha alternancia de modo
*     INCLUIR/ALTERAR/VISUALIZAR dentro deste dialogo (ele e aberto pelo
*     form pai ja no modo que interessa) - o unico campo editavel
*     (txt_4c_Compensacao) tem o ReadOnly dele recalculado a cada carga
*     por RebindCamposTotais(), que e o equivalente funcional e ja
*     existe desde a Fase 6/8; LimparCampos nao se aplica porque nao ha
*     o que "limpar" para o proximo registro - o dialogo e encerrado
*     (Release) e reaberto do zero pelo form pai a cada totalizacao.
*   - AjustarBotoesPorModo: nao ha botoes CRUD cuja Enabled dependa do
*     modo - o unico CommandGroup (cmg_4c_OK) fica sempre habilitado.
*   - CarregarLista: implementado desde a Fase 4/8 (nome PUBLIC, regra
*     CLAUDE.md #3 - acionado pelo harness de teste automatizado) e e
*     quem orquestra SigOpTotBO.ProcessarTotais() + o rebind das 6
*     grades + RebindCamposTotais(); nada a acrescentar aqui.
*   - Integracao em menu.prg/config.prg: NAO se aplica. Este dialogo
*     nunca e aberto pelo usuario a partir de um popup do menu - no
*     legado e sempre CREATEOBJECT("SIGOPTOT", pform, datses) + Show(1)
*     disparado por um form de MOVIMENTO (TprMvCab), nunca por item de
*     menu (ver "Uso canonico" no topo deste arquivo). Adicionar um
*     DEFINE BAR/ON SELECTION BAR para abrir este dialogo isolado, sem
*     o form pai que fornece os cursores crSigCdOpe/TprMvCab/crTpmMvItn,
*     inventaria uma funcionalidade que o sistema legado nao tem (viola
*     PILAR 1) e abriria uma tela sem dados para somar. A integracao
*     real (o form de movimento chamando CREATEOBJECT("FormSigOpTot",
*     THISFORM, SET("Datasession")) + Show()) e responsabilidade da
*     migracao DAQUELE form de movimento, nao desta task. Pela mesma
*     razao, config.prg nao precisa de nenhum SET PROCEDURE novo: a
*     carga sob demanda (CLAUDE.md, secao "config.prg - Carga SOB
*     DEMANDA") ja resolve SigOpTotBO.prg/FormSigOpTot.prg pelo indice
*     de classes no momento em que o form pai fizer
*     CREATEOBJECT("FormSigOpTot", ...) - CREATEOBJECT literal dentro de
*     outro Form/BO nao exige edicao em config.prg.
*
* CONFERENCIA DE COMPLETUDE (comportamento.json, 24 metodos do dump):
* Init -> InicializarForm/ProcessarTotais; Procedure(calctotais) ->
* CalcularTotais+RebindCamposTotais; Destroy -> Destroy(); as 6
* Text1.When das grades -> colunas ReadOnly=.T. desde ConfigurarGrades
* (Fase 4/8), nenhuma celula e editavel, When=.F. e portanto implicito;
* Get_Compensacao.When -> RebindCamposTotais (ReadOnly por modo,
* Fase 6/8); Get_Compensacao.Valid -> ValidarCompensacao (Fase 6/8);
* OK.Click -> BtnSairClick (Fase 4/8). Nenhum metodo do dump ficou
* sem equivalente, e nenhum metodo deste form e estrutura vazia/stub -
* FormSigOpTot.prg e SigOpTotBO.prg estao completos.
*==============================================================================

DEFINE CLASS FormSigOpTot AS FormBase

    *-- Propriedades visuais (PILAR 1: identico ao legado SIGOPTOT.SCX)
    Width        = 1127
    Height       = 600
    AutoCenter   = .T.
    Caption      = "Total Itens"
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    MaxButton    = .F.
    Movable      = .T.
    TitleBar     = 0
    BorderStyle  = 2
    ShowTips     = .T.
    DataSession  = 2
    AlwaysOnTop  = .T.

    *-- Referencia ao form que abriu este dialogo (legado "ThisForm.ParentForm").
    *-- Usado por BtnSairClick() para reabilitar o form de origem
    *-- antes de encerrar este dialogo.
    this_oParentForm = .NULL.

    *-- DataSessionId do formulario de origem (legado "datses"), guardado so
    *-- para repassar ao Business Object via DefinirContexto - a troca de
    *-- sessao em si acontece uma unica vez, no Init.
    this_nDataSessionId = 0

    *-- Guarda de reentrancia de ValidarCompensacao(): o handler esta ligado
    *-- a "LostFocus" e exibe MsgAviso, que e modal - ao devolver o foco o
    *-- proprio LostFocus redispara e empilharia uma segunda validacao
    *-- (regra CLAUDE.md #47). Liberada pelo WRAPPER, nunca pelo corpo, para
    *-- que os RETURN antecipados do corpo nao deixem a flag travada em .T.
    this_lEmValidacaoCompensacao = .F.

    *--------------------------------------------------------------------------
    * Init - Recebe os mesmos parametros do Init legado (pform, datses).
    * Reproduz a MESMA ordem do legado: guarda a referencia ao form pai,
    * troca para a DataSession do form pai (Set Datasession To DatSes) ANTES
    * de qualquer outra coisa, e so entao aciona DODEFAULT() (que dispara
    *
    * Em modo de teste automatizado (TestFormWrapper/ValidarUIFidelity) este
    * form e instanciado sem form pai nem DataSessionId validos, so para
    * validar a estrutura visual - sem a troca de sessao, THIS.InicializarForm
    * ainda monta o cabecalho normalmente (as fases seguintes, que leem
    * cursores do pai, precisarao continuar respeitando gb_4c_ModoTeste).
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oParentForm, par_nDataSessionId)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        THIS.this_oParentForm    = IIF(VARTYPE(par_oParentForm) = "O", par_oParentForm, .NULL.)
        THIS.this_nDataSessionId = IIF(VARTYPE(par_nDataSessionId) = "N", par_nDataSessionId, 0)

        IF THIS.this_nDataSessionId > 0
            SET DATASESSION TO (THIS.this_nDataSessionId)
        ENDIF

        loc_lSucesso = DODEFAULT()

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria o Business Object, repassa o contexto do form
    * pai (DefinirContexto) e monta a tela: cabecalho, as 6 grades de
    * totalizacao, o CommandGroup de retorno e a carga dos totais
    * (CarregarLista -> SigOpTotBO.ProcessarTotais), o bloco COMPLETO de
    * campos de total (ConfigurarCamposTotais) e o evento de recalculo do
    * unico campo editavel (ValidarCompensacao, ligado por BINDEVENT).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpTotBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.DefinirContexto(THIS.this_oParentForm, THIS.this_nDataSessionId)

                THIS.ConfigurarPageFrame()
                THIS.ConfigurarCabecalho()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.ConfigurarGrades()

                *-- ConfigurarBotoes() vem DEPOIS de ConfigurarCabecalho(): o
                *-- CommandGroup fica em Top=-2, dentro da area da faixa do
                *-- cabecalho (Top=0..80), e so desenha POR CIMA dela se for
                *-- adicionado depois (regra CLAUDE.md #11).
                THIS.ConfigurarBotoes()

                *-- Bloco COMPLETO de campos de total (as duas metades do
                *-- bloco do dump), mais o BINDEVENT de txt_4c_Compensacao.
                THIS.ConfigurarCamposTotais()

                THIS.TornarControlesVisiveis(THIS)

                *-- CarregarLista() roda DEPOIS do TornarControlesVisiveis -
                *-- ele mesmo decide a visibilidade final de
                *-- grd_4c_Servicos/grd_4c_ProdutoTam/grd_4c_Componentes
                *-- (exclusao mutua do Init legado), e nao pode ser
                *-- sobrescrito pelo pass genereico de visibilidade.
                THIS.CarregarLista()

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar Business Object de Total de Itens." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro ao inicializar FormSigOpTot")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - SIGOPTOT legado NAO TEM PageFrame: layout PLANO
    * com fundo new_background.jpg (Picture do dump), igual ao padrao de
    * dialogos OPERACIONAL planos da familia SigOp (ver FormSigOpCcj.prg).
    * Mantido so para configurar a aparencia base do form - nao cria pagina
    * alguma. FontName/FontSize aqui sao o DEFAULT do form (Tahoma 8); as
    * grades usam Verdana 8, conforme o dump de cada Grid.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
        THIS.SetAll("FontName", "Tahoma")
        THIS.SetAll("FontSize", 8)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container header cinza (cntSombra do legado).
    * Valores EXATOS do dump (PILAR 1): Top=0, Left=0, Height=80,
    * BackColor=100,100,100, BorderWidth=0 (Width = THIS.Width, nao o 1136
    * literal do SCX - regra CLAUDE.md #11: a largura segue o form, nunca um
    * literal maior/menor). lblSombra (Top=18, Height=40, ForeColor preto) e
    * lblTitulo (Top=17, Height=46, ForeColor branco) com FontSize=18 (o
    * legado declara 18 para este form, nao o generico 16 de outros
    * cabecalhos) - efeito de sombra: o titulo branco fica 1px acima e 6px
    * mais alto que a sombra preta por baixo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oErro
        TRY
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
            ENDWITH

            THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
            WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .AutoSize      = .F.
                .Caption       = THIS.Caption
                .Height        = 40
                .Left          = 10
                .Top           = 18
                .Width         = THIS.Width - 21
                .ForeColor     = RGB(0, 0, 0)
                .Visible       = .T.
            ENDWITH

            THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
            WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .AutoSize      = .F.
                .Caption       = THIS.Caption
                .Height        = 46
                .Left          = 10
                .Top           = 17
                .Width         = THIS.Width - 21
                .ForeColor     = RGB(255, 255, 255)
                .Visible       = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro ao configurar cabecalho")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrades - Monta as 6 grades de totalizacao do SIGOPTOT legado,
    * na mesma posicao/tamanho/fonte/colunas do dump (PILAR 1). Cada grade
    * nasce ligada a um cursor PLACEHOLDER com a MESMA estrutura (e, para
    * xValIte/xValServ, o MESMO indice) que SigOpTotBO cria nos seus
    * metodos de carga - CarregarLista() (neste mesmo arquivo)
    * reconfigura ControlSource/Header/Width depois que o BO
    * processa os totais de verdade (regra "Grid RecordSource reseta
    * Header/Width" - FORMCOR_LICOES_APRENDIDAS Problema 2/48).
    *
    * Visibilidade inicial (igual ao legado antes de qualquer calculo):
    * grd_4c_TotalProdutos/grd_4c_Produto/grd_4c_ProdutoTam = .T.;
    * grd_4c_Servicos/grd_4c_Componentes/cnt_4c_CalculoCol = .F. (ligados
    * depois, so quando this_lTemServicos/this_lTemComponentes forem .T. -
    * cnt_4c_CalculoCol fica SEMPRE .F., ver cabecalho do arquivo).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrades()
        LOCAL loc_oBO, loc_oErro
        loc_oBO = THIS.this_oBusinessObject

        TRY
            *-- Cursores placeholder - mesma estrutura dos cursores reais
            *-- que o BO cria (xValIte/xValServ com INDEX ON Moeda, igual a
            *-- CalcularTotais/MontarGradeServicos; ProEesti/ProTam/csCompo
            *-- sem indice, igual a MontarGradeProdutos/MontarGradeProdutoTam/
            *-- ProcessarComponentes).
            IF !USED(loc_oBO.this_cCursorValIte)
                SET NULL ON
                CREATE CURSOR (loc_oBO.this_cCursorValIte) (Moeda C(3), Total N(15,2))
                SET NULL OFF
                INDEX ON Moeda TAG Moeda
            ENDIF
            IF !USED(loc_oBO.this_cCursorValServ)
                SET NULL ON
                CREATE CURSOR (loc_oBO.this_cCursorValServ) (Moeda C(3), Total N(15,2))
                SET NULL OFF
                INDEX ON Moeda TAG Moeda
            ENDIF
            IF !USED(loc_oBO.this_cCursorProEesti)
                SET NULL ON
                CREATE CURSOR (loc_oBO.this_cCursorProEesti) (Cpros C(14), Qtds N(11,3))
                SET NULL OFF
            ENDIF
            IF !USED(loc_oBO.this_cCursorProTam)
                SET NULL ON
                CREATE CURSOR (loc_oBO.this_cCursorProTam) (Cpros C(20), Qtds N(11,3))
                SET NULL OFF
            ENDIF
            IF !USED(loc_oBO.this_cCursorCompo)
                SET NULL ON
                CREATE CURSOR (loc_oBO.this_cCursorCompo) (Codigos C(14), Qtds N(11,3), UniCompos C(3), QtsCons N(11,3))
                SET NULL OFF
            ENDIF

            *-- grd_4c_TotalProdutos (legado: grade_total) - Total por moeda
            *-- dos PRODUTOS. Sempre visivel.
            THIS.AddObject("grd_4c_TotalProdutos", "Grid")
            WITH THIS.grd_4c_TotalProdutos
                .Top          = 84
                .Left         = 5
                .Height       = 322
                .FontName     = "Verdana"
                .FontSize     = 8
                .DeleteMark   = .F.
                .RecordMark   = .F.
                .ReadOnly     = .T.
                .RowHeight    = 16
                .ScrollBars   = 2
                .GridLineColor = RGB(238, 238, 238)
                .ColumnCount  = 2
                .RecordSource = loc_oBO.this_cCursorValIte
                .Column1.ControlSource = loc_oBO.this_cCursorValIte + ".Moeda"
                .Column1.Movable  = .F.
                .Column1.Resizable = .F.
                .Column1.ReadOnly  = .T.
                .Column1.Header1.FontName  = "Verdana"
                .Column1.Header1.FontSize  = 8
                .Column1.Header1.Alignment = 2
                .Column1.Header1.Caption   = "Moeda"
                .Column1.Text1.BorderStyle = 0
                .Column1.Text1.Margin      = 0
                .Column1.Text1.ForeColor   = RGB(0, 0, 0)
                .Column1.Text1.BackColor   = RGB(255, 255, 255)
                .Column2.ControlSource = loc_oBO.this_cCursorValIte + ".Total"
                .Column2.Movable  = .F.
                .Column2.Resizable = .F.
                .Column2.ReadOnly  = .T.
                .Column2.InputMask = "999,999,999.99"
                .Column2.Header1.FontName  = "Verdana"
                .Column2.Header1.FontSize  = 8
                .Column2.Header1.Alignment = 2
                .Column2.Header1.Caption   = "Total dos Produtos"
                .Column2.Text1.BorderStyle = 0
                .Column2.Text1.Margin      = 0
                .Column2.Text1.ForeColor   = RGB(0, 0, 0)
                .Column2.Text1.BackColor   = RGB(255, 255, 255)
                .Column1.Width = 40
                .Column2.Width = 135
                .Width    = 208
                .Visible  = .T.
            ENDWITH

            *-- grd_4c_Produto (legado: Grade_Produto) - Total por PRODUTO
            *-- (Cpros), sem agrupar por tamanho. Sempre visivel.
            THIS.AddObject("grd_4c_Produto", "Grid")
            WITH THIS.grd_4c_Produto
                .Top          = 84
                .Left         = 446
                .Height       = 322
                .FontName     = "Verdana"
                .FontSize     = 8
                .DeleteMark   = .F.
                .RecordMark   = .F.
                .ReadOnly     = .T.
                .RowHeight    = 16
                .ScrollBars   = 2
                .GridLineColor = RGB(238, 238, 238)
                .ColumnCount  = 2
                .RecordSource = loc_oBO.this_cCursorProEesti
                .Column1.ControlSource = loc_oBO.this_cCursorProEesti + ".Cpros"
                .Column1.Movable  = .F.
                .Column1.Resizable = .F.
                .Column1.ReadOnly  = .T.
                .Column1.Header1.FontName  = "Verdana"
                .Column1.Header1.FontSize  = 8
                .Column1.Header1.Alignment = 2
                .Column1.Header1.Caption   = "Produto"
                .Column1.Text1.BorderStyle = 0
                .Column1.Text1.Margin      = 0
                .Column1.Text1.ForeColor   = RGB(0, 0, 0)
                .Column1.Text1.BackColor   = RGB(255, 255, 255)
                .Column2.ControlSource = loc_oBO.this_cCursorProEesti + ".Qtds"
                .Column2.Movable  = .F.
                .Column2.Resizable = .F.
                .Column2.ReadOnly  = .T.
                .Column2.InputMask = "999,999,999.99"
                .Column2.Header1.FontName  = "Verdana"
                .Column2.Header1.FontSize  = 8
                .Column2.Header1.Alignment = 2
                .Column2.Header1.Caption   = "Total"
                .Column2.Text1.BorderStyle = 0
                .Column2.Text1.Margin      = 0
                .Column2.Text1.ForeColor   = RGB(0, 0, 0)
                .Column2.Text1.BackColor   = RGB(255, 255, 255)
                .Column1.Width = 125
                .Column2.Width = 80
                .Width    = 237
                .Visible  = .T.
            ENDWITH

            *-- grd_4c_ProdutoTam (legado: Grade_ProdutoTam) - Total por
            *-- PRODUTO+TAMANHO (comentario original "Mena - 20/10/2017").
            *-- Ocupa a MESMA posicao de grd_4c_Servicos - as duas sao
            *-- mutuamente exclusivas (CarregarLista decide qual aparece,
            *-- igual ao Init legado linhas 1580-1587). Visivel por
            *-- DEFAULT (so fica oculta se houver servicos).
            THIS.AddObject("grd_4c_ProdutoTam", "Grid")
            WITH THIS.grd_4c_ProdutoTam
                .Top          = 84
                .Left         = 216
                .Height       = 322
                .FontName     = "Verdana"
                .FontSize     = 8
                .DeleteMark   = .F.
                .RecordMark   = .F.
                .ReadOnly     = .T.
                .RowHeight    = 16
                .ScrollBars   = 2
                .GridLineColor = RGB(238, 238, 238)
                .ColumnCount  = 2
                .RecordSource = loc_oBO.this_cCursorProTam
                .Column1.ControlSource = loc_oBO.this_cCursorProTam + ".Cpros"
                .Column1.Movable  = .F.
                .Column1.Resizable = .F.
                .Column1.ReadOnly  = .T.
                .Column1.Header1.FontName  = "Verdana"
                .Column1.Header1.FontSize  = 8
                .Column1.Header1.Alignment = 2
                .Column1.Header1.Caption   = "Produto + Tam"
                .Column1.Text1.BorderStyle = 0
                .Column1.Text1.Margin      = 0
                .Column1.Text1.ForeColor   = RGB(0, 0, 0)
                .Column1.Text1.BackColor   = RGB(255, 255, 255)
                .Column2.ControlSource = loc_oBO.this_cCursorProTam + ".Qtds"
                .Column2.Movable  = .F.
                .Column2.Resizable = .F.
                .Column2.ReadOnly  = .T.
                .Column2.InputMask = "999,999,999.99"
                .Column2.Header1.FontName  = "Verdana"
                .Column2.Header1.FontSize  = 8
                .Column2.Header1.Alignment = 2
                .Column2.Header1.Caption   = "Total"
                .Column2.Text1.BorderStyle = 0
                .Column2.Text1.Margin      = 0
                .Column2.Text1.ForeColor   = RGB(0, 0, 0)
                .Column2.Text1.BackColor   = RGB(255, 255, 255)
                .Column1.Width = 150
                .Column2.Width = 45
                .Width    = 227
                .Visible  = .T.
            ENDWITH

            *-- grd_4c_Servicos (legado: Grade_Serv) - Total por moeda dos
            *-- SERVICOS. So aparece quando crSigCdOpe.HabServs = 1 - nasce
            *-- oculta (CarregarLista decide, exclusao mutua com
            *-- grd_4c_ProdutoTam, que fica na MESMA posicao).
            THIS.AddObject("grd_4c_Servicos", "Grid")
            WITH THIS.grd_4c_Servicos
                .Top          = 84
                .Left         = 226
                .Height       = 322
                .FontName     = "Verdana"
                .FontSize     = 8
                .DeleteMark   = .F.
                .RecordMark   = .F.
                .ReadOnly     = .T.
                .RowHeight    = 16
                .ScrollBars   = 2
                .GridLineColor = RGB(238, 238, 238)
                .ColumnCount  = 2
                .RecordSource = loc_oBO.this_cCursorValServ
                .Column1.ControlSource = loc_oBO.this_cCursorValServ + ".Moeda"
                .Column1.Movable  = .F.
                .Column1.Resizable = .F.
                .Column1.ReadOnly  = .T.
                .Column1.Header1.FontName  = "Verdana"
                .Column1.Header1.FontSize  = 8
                .Column1.Header1.Alignment = 2
                .Column1.Header1.Caption   = "Moeda"
                .Column1.Text1.BorderStyle = 0
                .Column1.Text1.Margin      = 0
                .Column1.Text1.ForeColor   = RGB(0, 0, 0)
                .Column1.Text1.BackColor   = RGB(255, 255, 255)
                .Column2.ControlSource = loc_oBO.this_cCursorValServ + ".Total"
                .Column2.Movable  = .F.
                .Column2.Resizable = .F.
                .Column2.ReadOnly  = .T.
                .Column2.InputMask = "999,999,999.99"
                .Column2.Header1.FontName  = "Verdana"
                .Column2.Header1.FontSize  = 8
                .Column2.Header1.Alignment = 2
                .Column2.Header1.Caption   = "Total dos Servi" + CHR(231) + "os"
                .Column2.Text1.BorderStyle = 0
                .Column2.Text1.Margin      = 0
                .Column2.Text1.ForeColor   = RGB(0, 0, 0)
                .Column2.Text1.BackColor   = RGB(255, 255, 255)
                .Column1.Width = 40
                .Column2.Width = 135
                .Width    = 208
                .Visible  = .F.
            ENDWITH

            *-- grd_4c_Componentes (legado: GrdTCompo) - materia-prima
            *-- consumida, so quando crSigCdOpe.TotCompos = 1 E ha linhas em
            *-- csCompo. Nasce oculta (CarregarLista decide).
            THIS.AddObject("grd_4c_Componentes", "Grid")
            WITH THIS.grd_4c_Componentes
                .Top          = 84
                .Left         = 686
                .Height       = 322
                .FontName     = "Verdana"
                .FontSize     = 8
                .DeleteMark   = .F.
                .RecordMark   = .F.
                .ReadOnly     = .T.
                .RowHeight    = 16
                .ScrollBars   = 2
                .GridLineColor = RGB(238, 238, 238)
                .ColumnCount  = 4
                .RecordSource = loc_oBO.this_cCursorCompo
                .Column1.ControlSource = loc_oBO.this_cCursorCompo + ".Codigos"
                .Column1.Movable  = .F.
                .Column1.Resizable = .F.
                .Column1.ReadOnly  = .T.
                .Column1.Header1.FontName  = "Verdana"
                .Column1.Header1.FontSize  = 8
                .Column1.Header1.Alignment = 2
                .Column1.Header1.Caption   = "Componente"
                .Column1.Text1.BorderStyle = 0
                .Column1.Text1.Margin      = 0
                .Column1.Text1.ForeColor   = RGB(0, 0, 0)
                .Column1.Text1.BackColor   = RGB(255, 255, 255)
                .Column2.ControlSource = loc_oBO.this_cCursorCompo + ".Qtds"
                .Column2.Movable  = .F.
                .Column2.Resizable = .F.
                .Column2.ReadOnly  = .T.
                .Column2.InputMask = "99,999,999.999"
                .Column2.Header1.FontName  = "Verdana"
                .Column2.Header1.FontSize  = 8
                .Column2.Header1.Alignment = 2
                .Column2.Header1.Caption   = "Quantidade"
                .Column2.Text1.BorderStyle = 0
                .Column2.Text1.Margin      = 0
                .Column2.Text1.ForeColor   = RGB(0, 0, 0)
                .Column2.Text1.BackColor   = RGB(255, 255, 255)
                .Column3.ControlSource = loc_oBO.this_cCursorCompo + ".UniCompos"
                .Column3.ReadOnly  = .T.
                .Column3.Header1.FontName  = "Verdana"
                .Column3.Header1.FontSize  = 8
                .Column3.Header1.Alignment = 2
                .Column3.Header1.Caption   = "Unid."
                .Column3.Text1.BorderStyle = 0
                .Column3.Text1.Margin      = 0
                .Column3.Text1.ForeColor   = RGB(0, 0, 0)
                .Column3.Text1.BackColor   = RGB(255, 255, 255)
                .Column4.ControlSource = loc_oBO.this_cCursorCompo + ".QtsCons"
                .Column4.Movable  = .F.
                .Column4.Resizable = .F.
                .Column4.ReadOnly  = .T.
                .Column4.InputMask = "999999"
                .Column4.Header1.FontName  = "Verdana"
                .Column4.Header1.FontSize  = 8
                .Column4.Header1.Alignment = 2
                .Column4.Header1.Caption   = "Consumo"
                .Column4.Text1.BorderStyle = 0
                .Column4.Text1.Margin      = 0
                .Column4.Text1.MaxLength   = 6
                .Column4.Text1.ReadOnly    = .T.
                .Column4.Text1.ForeColor   = RGB(0, 0, 0)
                .Column4.Text1.BackColor   = RGB(255, 255, 255)
                .Column1.Width = 80
                .Column2.Width = 80
                .Column3.Width = 30
                .Column4.Width = 60
                .Width    = 330
                .Visible  = .F.
            ENDWITH

            *-- cnt_4c_CalculoCol (legado: Container1 + GradeCol) - bloco
            *-- "Calculo COL" (Tipo / Col (%)). Reproduzido so por
            *-- fidelidade estrutural (PILAR 1): no SCX legado nasce
            *-- Visible=.F. e NUNCA e mostrado nem recebe RecordSource em
            *-- lugar nenhum do Init/calctotais - fica permanentemente
            *-- oculto, inclusive no legado. NAO entra na exclusao mutua
            *-- das grades de totalizacao.
            THIS.AddObject("cnt_4c_CalculoCol", "Container")
            WITH THIS.cnt_4c_CalculoCol
                .Top          = 408
                .Left         = 500
                .Width        = 206
                .Height       = 189
                .BackStyle    = 0
                .BorderWidth  = 0
                .SpecialEffect = 0
                .BackColor    = RGB(188, 201, 254)
                .Visible      = .F.
            ENDWITH

            THIS.cnt_4c_CalculoCol.AddObject("lbl_4c_CalculoCol", "Label")
            WITH THIS.cnt_4c_CalculoCol.lbl_4c_CalculoCol
                .Top       = 3
                .Left      = 4
                .Width     = 191
                .Height    = 19
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 9
                .Alignment = 2
                .BackStyle = 0
                .Caption   = "C" + CHR(225) + "lculo COL"
                .ForeColor = RGB(90, 90, 90)
                .BackColor = RGB(188, 201, 254)
                .Visible   = .T.
            ENDWITH

            THIS.cnt_4c_CalculoCol.AddObject("grd_4c_Col", "Grid")
            WITH THIS.cnt_4c_CalculoCol.grd_4c_Col
                .Top          = 21
                .Left         = 4
                .Width        = 191
                .Height       = 164
                .FontBold     = .T.
                .FontName     = "Tahoma"
                .HeaderHeight = 17
                .ReadOnly     = .T.
                .ScrollBars   = 2
                .DeleteMark   = .F.
                .RecordMark   = .F.
                .GridLineColor = RGB(238, 238, 238)
                .ColumnCount  = 2
                .Column1.Movable  = .F.
                .Column1.Resizable = .F.
                .Column1.ReadOnly  = .T.
                .Column1.FontBold = .T.
                .Column1.FontName = "Tahoma"
                .Column1.Header1.FontBold  = .T.
                .Column1.Header1.FontName  = "Tahoma"
                .Column1.Header1.FontSize  = 8
                .Column1.Header1.Alignment = 2
                .Column1.Header1.Caption   = "Tipo"
                .Column1.Text1.FontBold    = .T.
                .Column1.Text1.FontName    = "Tahoma"
                .Column1.Text1.BorderStyle = 0
                .Column1.Text1.Margin      = 0
                .Column1.Text1.ForeColor   = RGB(0, 0, 0)
                .Column1.Text1.BackColor   = RGB(255, 255, 255)
                .Column2.Movable  = .F.
                .Column2.Resizable = .F.
                .Column2.ReadOnly  = .T.
                .Column2.FontBold = .T.
                .Column2.FontName = "Tahoma"
                .Column2.InputMask = "999,999,999.99"
                .Column2.Header1.FontBold  = .T.
                .Column2.Header1.FontName  = "Tahoma"
                .Column2.Header1.FontSize  = 8
                .Column2.Header1.Alignment = 2
                .Column2.Header1.Caption   = "Col  (%)"
                .Column2.Text1.FontBold    = .T.
                .Column2.Text1.FontName    = "Tahoma"
                .Column2.Text1.BorderStyle = 0
                .Column2.Text1.Margin      = 0
                .Column2.Text1.ForeColor   = RGB(0, 0, 0)
                .Column2.Text1.BackColor   = RGB(255, 255, 255)
                .Column1.Width = 45
                .Column2.Width = 112
                .Visible = .T.
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro ao configurar grades")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - CommandGroup de saida do dialogo (legado SIGOPTOT.OK,
    * ButtonCount=1, com o botao interno batizado btnSair e Caption
    * "Retornar"). Valores EXATOS do dump (PILAR 1, secao "PROPRIEDADES DE:
    * SIGOPTOT.OK"): grupo AutoSize=.T., ButtonCount=1, BackStyle=0,
    * BorderStyle=0, Value=0, Height=85, Left=1045, SpecialEffect=1, Top=-2,
    * Width=85, TabIndex=1, Themes=.F.; botao interno Top=5, Left=5,
    * Height=75, Width=75, Comic Sans MS 8 bold+italic, WordWrap=.T.,
    * Cancel=.T. (e dai que o [Esc] anunciado no ToolTipText legado funciona),
    * Caption="Retornar", MousePointer=15, SpecialEffect=0,
    * ForeColor=90,90,90, BackColor=255,255,255, Themes=.F. e
    * Picture=cadastro_salvar_60.jpg - o icone do PROPRIO dump: nesta tela
    * "retornar" usa mesmo o icone de salvar, e trocar por outro mais
    * parecido com a acao seria inventar (regra CLAUDE.md #25).
    *
    * Themes=.F. no botao interno e o canonico de Buttons(N) DENTRO de
    * CommandGroup; por isso NAO se aplica aqui o par Themes=.T. +
    * DisabledPicture, que vale para CommandButton AVULSO com Picture.
    *
    * A geometria do botao INTERNO e aplicada ANTES da do grupo porque o grupo
    * e AutoSize=.T. e e o botao que define o tamanho dele: 5+75+5 = 85, o
    * mesmo Width/Height que o dump declara no grupo (regra CLAUDE.md #31).
    *
    * O Command1.TabIndex=4 do dump NAO e transcrito: dentro de um grupo o
    * TabIndex e relativo ao grupo, e este grupo tem um unico botao - 4 esta
    * fora de faixa. O TabIndex do GRUPO (=1), que e o que posiciona o
    * conjunto na ordem de tabulacao do form, esta transcrito.
    *
    * Nome _4c_: cmg_4c_OK, prefixo canonico de CommandGroup no projeto, e NAO
    * o obj_4c_OK do mapeamento.json (o gerador de mapeamento nao reconhece a
    * classe commandgroup e cai no prefixo generico obj_4c_) - mapeamento.json
    * corrigido junto, no mesmo passo desta fase.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("cmg_4c_OK", "CommandGroup")
            WITH THIS.cmg_4c_OK
                .ButtonCount = 1

                WITH .Buttons(1)
                    .Top           = 5
                    .Left          = 5
                    .Width         = 75
                    .Height        = 75
                    .Caption       = "Retornar"
                    .FontName      = "Comic Sans MS"
                    .FontSize      = 8
                    .FontBold      = .T.
                    .FontItalic    = .T.
                    .WordWrap      = .T.
                    .Picture       = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                    .Cancel        = .T.
                    .MousePointer  = 15
                    .SpecialEffect = 0
                    .ForeColor     = RGB(90, 90, 90)
                    .BackColor     = RGB(255, 255, 255)
                    .Themes        = .F.
                    .ToolTipText   = "[Esc] Voltar Para a Tela Principal da Opera" + ;
                        CHR(231) + CHR(227) + "o"
                ENDWITH

                .AutoSize      = .T.
                .Top           = -2
                .Left          = 1045
                .Width         = 85
                .Height        = 85
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 1
                .Themes        = .F.
                .Value         = 0
                .TabIndex      = 1
                .Visible       = .T.
            ENDWITH

            BINDEVENT(THIS.cmg_4c_OK.Buttons(1), "Click", THIS, "BtnSairClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro ao configurar bot" + ;
                CHR(245) + "es")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposTotais - Bloco de campos de total, direto na form
    * (sem container - igual ao legado). Bloco COMPLETO, na ordem do dump:
    * os dois totais principais (Label1/Get_TotQtde, Label2/Get_TotPeso) com
    * os indicadores de sinal na mesma linha de cada um (Get_QOper ao lado de
    * Get_TotQtde, Get_POper ao lado de Get_TotPeso), mais Label3/Get_TotPesoC
    * (Peso C), Label4/Get_Compensacao (o UNICO campo editavel),
    * Label5/Get_mtcub (Metro Cubico, nasce Visible=.F. igual ao dump) e
    * lblTotPes/getTotPes (Total do Peso, com a legenda dinamica que o BO
    * monta em PrepararRotuloTotalPeso).
    *
    * Nenhum destes campos tem ControlSource no legado - CalcTotais()
    * escreve o valor calculado direto em .Value (.get_TotQtde.Value =
    * Abs(lnTotQtde), .Get_QOper.Value = Iif(...,'E','S')); por isso aqui so
    * se cria a estrutura visual com valor inicial neutro (0 para os
    * numericos, "" para os indicadores de sinal) - a logica de calculo
    * (CalcTotais) e os eventos que a disparam entram nas fases de eventos,
    * ainda nao migradas (ver cabecalho do arquivo).
    *
    * Formato de exibicao (regra CLAUDE.md #49): o dump declara estes campos
    * com ".Format = "999,999.999""/".Format = "999,999.99"" (nao
    * ".InputMask"), mas .Format em TextBox VFP9 so aceita codigos de letra
    * (K/!/T) - padrao de digito so tem efeito como .InputMask (e e assim
    * que o proprio dump trata o campo gemeo Get_mtcub, que usa
    * ".InputMask = "999,999.999""). Transcrito como .InputMask para
    * preservar o EFEITO visual (separador de milhar + decimais), que e o
    * que a fidelidade de UX (PILAR 1) exige.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposTotais()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("lbl_4c_Label1", "Label")
            WITH THIS.lbl_4c_Label1
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .Caption   = "Total Quantidade :"
                .Height    = 15
                .Left      = 163
                .Top       = 463
                .Width     = 105
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_TotQtde", "TextBox")
            WITH THIS.txt_4c_TotQtde
                .FontName          = "Courier New"
                .FontSize          = 8
                .Format            = "999,999.999"
                .Height            = 23
                .Left              = 275
                .Top               = 459
                .Width             = 88
                .ReadOnly          = .T.
                .DisabledBackColor = RGB(255, 255, 255)
                .ToolTipText       = "Total em Quantidade"
                .Value             = 0
                .Visible           = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_Label2", "Label")
            WITH THIS.lbl_4c_Label2
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .Caption   = "Total do Peso :"
                .Height    = 15
                .Left      = 184
                .Top       = 488
                .Width     = 84
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_TotPeso", "TextBox")
            WITH THIS.txt_4c_TotPeso
                .FontName          = "Courier New"
                .FontSize          = 8
                .Format            = "999,999.99"
                .Height            = 23
                .Left              = 275
                .Top               = 484
                .Width             = 88
                .ReadOnly          = .T.
                .DisabledBackColor = RGB(255, 255, 255)
                .ToolTipText       = "Total em Peso"
                .Value             = 0
                .Visible           = .T.
            ENDWITH

            *-- Get_QOper/Get_POper: indicador de sinal (' ', 'E' ou 'S')
            *-- da mesma linha de Get_TotQtde/Get_TotPeso - sem Format nem
            *-- ToolTipText no dump.
            THIS.AddObject("txt_4c_QOper", "TextBox")
            WITH THIS.txt_4c_QOper
                .FontName          = "Courier New"
                .FontSize          = 8
                .Height            = 23
                .Left              = 366
                .Top               = 459
                .Width             = 17
                .ReadOnly          = .T.
                .DisabledBackColor = RGB(255, 255, 255)
                .Value             = ""
                .Visible           = .T.
            ENDWITH

            THIS.AddObject("txt_4c_POper", "TextBox")
            WITH THIS.txt_4c_POper
                .FontName          = "Courier New"
                .FontSize          = 8
                .Height            = 23
                .Left              = 366
                .Top               = 484
                .Width             = 17
                .ReadOnly          = .T.
                .DisabledBackColor = RGB(255, 255, 255)
                .Value             = ""
                .Visible           = .T.
            ENDWITH

            *-- Label4/txt_4c_Compensacao ("Peso Unitario C :") - UNICO campo
            *-- editavel do dialogo (dump: SEM .ReadOnly). Legado liga
            *-- ControlSource = 'TprMvCab.VCompensas'; aqui o valor inicial e
            *-- o ReadOnly definitivo (por modo) sao aplicados por
            *-- RebindCamposTotais(), chamado ao fim de CarregarLista() - a
            *-- escrita no cursor compartilhado so acontece de verdade no
            *-- LostFocus (ValidarCompensacao).
            THIS.AddObject("lbl_4c_Label4", "Label")
            WITH THIS.lbl_4c_Label4
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Alignment = 0
                .Caption   = "Peso Unit" + CHR(225) + "rio C :"
                .Height    = 15
                .Left      = 175
                .Top       = 513
                .Width     = 93
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Compensacao", "TextBox")
            WITH THIS.txt_4c_Compensacao
                .FontName          = "Courier New"
                .FontSize          = 8
                .Format            = "999,999.99"
                .Height            = 23
                .Left              = 275
                .Top               = 509
                .Width             = 88
                .ReadOnly          = .F.
                .DisabledBackColor = RGB(255, 255, 255)
                .ToolTipText       = "Peso Unit" + CHR(225) + "rio em Compensa" + CHR(231) + CHR(227) + "o"
                .Value             = 0
                .Visible           = .T.
            ENDWITH
            BINDEVENT(THIS.txt_4c_Compensacao, "LostFocus", THIS, "ValidarCompensacao")

            *-- Label3/txt_4c_TotPesoC ("Total do Peso C :") - resultado de
            *-- CalcularTotais (this_nTotPesoC), somente leitura.
            THIS.AddObject("lbl_4c_Label3", "Label")
            WITH THIS.lbl_4c_Label3
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Alignment = 0
                .Caption   = "Total do Peso C :"
                .Height    = 15
                .Left      = 174
                .Top       = 538
                .Width     = 94
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_TotPesoC", "TextBox")
            WITH THIS.txt_4c_TotPesoC
                .FontName          = "Courier New"
                .FontSize          = 8
                .Format            = "999,999.99"
                .Height            = 23
                .Left              = 275
                .Top               = 534
                .Width             = 88
                .ReadOnly          = .T.
                .DisabledBackColor = RGB(255, 255, 255)
                .ToolTipText       = "Total do Peso em Compensa" + CHR(231) + CHR(227) + "o"
                .Value             = 0
                .Visible           = .T.
            ENDWITH

            *-- lblTotPes/txt_4c_TotPes ("Total do Peso :", bottom - rotulo
            *-- dinamico via SigOpTotBO.this_cRotuloTotalPeso). Dump declara
            *-- AutoSize=.F. + Alignment=1 (right-align LEGITIMO - regra
            *-- CLAUDE.md #23, os dois estao presentes no dump).
            THIS.AddObject("lbl_4c_LblTotPes", "Label")
            WITH THIS.lbl_4c_LblTotPes
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Alignment = 1
                .Caption   = THIS.this_oBusinessObject.this_cRotuloTotalPeso
                .Height    = 15
                .Left      = 87
                .Top       = 563
                .Width     = 181
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_TotPes", "TextBox")
            WITH THIS.txt_4c_TotPes
                .FontName          = "Courier New"
                .FontSize          = 8
                .Format            = "999,999.99"
                .Height            = 23
                .Left              = 275
                .Top               = 559
                .Width             = 88
                .ReadOnly          = .T.
                .DisabledBackColor = RGB(255, 255, 255)
                .ToolTipText       = "Total do Peso em Compensa" + CHR(231) + CHR(227) + "o"
                .Value             = 0
                .Visible           = .T.
            ENDWITH

            *-- Label5/txt_4c_Mtcub ("TT Metro Cubico :") - dump: AMBOS
            *-- Visible=.F. - so aparecem quando SigOpTotBO.this_lMostrarMtCub
            *-- fica .T. (CrSigOpCdd.MtCubs <> 0), decidido por
            *-- RebindCamposTotais() ao fim de CarregarLista(). Por isso NAO
            *-- entram na lista de exclusao do TornarControlesVisiveis (regra
            *-- "containers flutuantes") - aqui o .F. inicial e o estado
            *-- normal, igual ao legado, e quem liga e este mesmo metodo.
            THIS.AddObject("lbl_4c_Label5", "Label")
            WITH THIS.lbl_4c_Label5
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Alignment = 0
                .Caption   = "TT Metro C" + CHR(250) + "bico :"
                .Height    = 15
                .Left      = 169
                .Top       = 438
                .Width     = 99
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .F.
            ENDWITH

            THIS.AddObject("txt_4c_Mtcub", "TextBox")
            WITH THIS.txt_4c_Mtcub
                .FontBold          = .T.
                .FontName          = "Courier New"
                .FontSize          = 8
                .InputMask         = "999,999.999"
                .Height            = 23
                .Left              = 275
                .Top               = 434
                .Width             = 88
                .ReadOnly          = .T.
                .DisabledBackColor = RGB(255, 255, 255)
                .ToolTipText       = "Total em Metros C" + CHR(250) + "bicos"
                .Value             = 0
                .Visible           = .F.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro ao configurar campos de totais")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCompensacao - Transcricao do PROCEDURE Valid de Get_Compensacao
    * (dump, linhas 1767-1779):
    *   If (This.Value < 0)
    *       =MessageBox('Valor de Compensacao Invalido', 48, 'Atencao!!!')
    *       This.Value = This.AntValue
    *       Return 0
    *   Else
    *       This.Refresh
    *       Thisform.CalcTotais()
    *   EndIf
    *
    * Validar<Campo> e o nome canonico do projeto para o handler que
    * reproduz o Valid de um campo digitavel. Get_Compensacao e o UNICO
    * campo digitavel do dump (o When dele devolve
    * InList(ThisForm.ParentForm.Op_Escolha,'INSERIR','ALTERAR'), enquanto os
    * outros 21 devolvem .F.) e o UNICO com PROCEDURE Valid.
    *
    * O ControlSource do legado ('TprMvCab.VCompensas') escreve o valor
    * digitado no cursor ANTES do Valid rodar - e por isso que CalcTotais()
    * (que le TprMvCab.VCompensas direto do cursor, nunca de uma copia)
    * ja calcula com o valor novo. Aqui a mesma ordem e reproduzida
    * explicitamente: grava no cursor PRIMEIRO, so depois chama
    * SigOpTotBO.ValidarCompensacao() (que valida e aciona CalcularTotais).
    * Falhando (valor negativo), desfaz a gravacao no cursor e repoe o
    * TextBox - o rollback "This.Value = This.AntValue" do legado.
    *
    * Wrapper fino + ValidarCompensacaoExec(): o corpo tem RETURN antecipado
    * (guardas de modo de teste e de cursor) e exibe MsgAviso, que e modal e
    * devolve o foco ao sair, redisparando o proprio LostFocus. Com set no
    * topo e clear no fim do CORPO, o primeiro RETURN antecipado deixaria a
    * flag travada em .T. e MATARIA a validacao pelo resto da vida do form
    * (regra CLAUDE.md #47).
    *
    * Metodo PUBLIC (sem PROTECTED): acionado por BINDEVENT, que falha em
    * silencio quando o handler e protegido (regra CLAUDE.md #3).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCompensacao()
        IF THIS.this_lEmValidacaoCompensacao
            RETURN
        ENDIF

        THIS.this_lEmValidacaoCompensacao = .T.
        THIS.ValidarCompensacaoExec()
        THIS.this_lEmValidacaoCompensacao = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCompensacaoExec - Corpo de ValidarCompensacao(). Esta separado
    * so para que o wrapper libere this_lEmValidacaoCompensacao em TODOS os
    * caminhos de saida, inclusive nos dois RETURN antecipados.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarCompensacaoExec()
        LOCAL loc_oBO, loc_nValorNovo, loc_nValorAnterior, loc_lSucesso

        IF (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
            RETURN
        ENDIF

        loc_oBO = THIS.this_oBusinessObject

        IF VARTYPE(loc_oBO) != "O" OR !USED("TprMvCab")
            RETURN
        ENDIF

        loc_nValorNovo     = THIS.txt_4c_Compensacao.Value
        loc_nValorAnterior = TprMvCab.VCompensas

        REPLACE TprMvCab.VCompensas WITH loc_nValorNovo IN TprMvCab

        loc_lSucesso = loc_oBO.ValidarCompensacao(loc_nValorNovo)

        IF loc_lSucesso
            THIS.txt_4c_Compensacao.Refresh()
            THIS.RebindCamposTotais()
        ELSE
            REPLACE TprMvCab.VCompensas WITH loc_nValorAnterior IN TprMvCab
            THIS.txt_4c_Compensacao.Value = loc_nValorAnterior
            MsgAviso(loc_oBO.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * RebindCamposTotais - Espelha nos controles os totais que
    * SigOpTotBO.CalcularTotais() (via ProcessarTotais, em CarregarLista(),
    * ou via SigOpTotBO.ValidarCompensacao(), chamado pelo
    * ValidarCompensacao() deste form) acabou de recalcular:
    * Get_QOper/get_TotQtde/Get_POper/Get_TotPeso/
    * Get_TotPesoC/getTotPes.Value e ThisForm.lblTotPes.Caption do bloco
    * "With ThisForm" do calctotais legado (linhas 1358-1365), mais a
    * secao de metro cubico (If CrSigOpCdd.MtCubs <> 0, linhas 1374-1378).
    *
    * Tambem reaplica o valor corrente de TprMvCab.VCompensas em
    * txt_4c_Compensacao (equivalente ao ControlSource do legado) e decide
    * o ReadOnly pelo MESMO criterio do When original (InList(ParentForm.
    * Op_Escolha,'INSERIR','ALTERAR')) - unica forma praticavel de
    * reproduzir When sem BINDEVENT confiavel em TextBox (regra CLAUDE.md
    * #3), suficiente porque este dialogo e modal e Op_Escolha nao muda
    * durante a vida dele.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RebindCamposTotais()
        LOCAL loc_oBO, loc_cModoOperacao
        loc_oBO = THIS.this_oBusinessObject

        THIS.txt_4c_TotQtde.Value    = loc_oBO.this_nTotQtde
        THIS.txt_4c_QOper.Value      = loc_oBO.this_cQOper
        THIS.txt_4c_TotPeso.Value    = loc_oBO.this_nTotPeso
        THIS.txt_4c_POper.Value      = loc_oBO.this_cPOper
        THIS.txt_4c_TotPesoC.Value   = loc_oBO.this_nTotPesoC
        THIS.txt_4c_TotPes.Value     = loc_oBO.this_nTotPes
        THIS.lbl_4c_LblTotPes.Caption = loc_oBO.this_cRotuloTotalPeso

        THIS.lbl_4c_Label5.Visible = loc_oBO.this_lMostrarMtCub
        THIS.txt_4c_Mtcub.Visible  = loc_oBO.this_lMostrarMtCub
        IF loc_oBO.this_lMostrarMtCub
            THIS.txt_4c_Mtcub.Value = loc_oBO.this_nMtCub
        ENDIF

        IF USED("TprMvCab")
            THIS.txt_4c_Compensacao.Value = TprMvCab.VCompensas
        ENDIF

        loc_cModoOperacao = ""
        IF VARTYPE(THIS.this_oParentForm) = "O" AND PEMSTATUS(THIS.this_oParentForm, "Op_Escolha", 5)
            loc_cModoOperacao = THIS.this_oParentForm.Op_Escolha
        ENDIF
        THIS.txt_4c_Compensacao.ReadOnly = !INLIST(loc_cModoOperacao, "INSERIR", "ALTERAR")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Transcricao do btnSair.Click legado, que tem duas
    * acoes: reabilitar o form que abriu este dialogo
    * (ThisForm.ParentForm.Enabled = .t.) e encerrar a propria tela
    * (ThisForm.Release). Nome do metodo canonico (BtnSairClick) para que o
    * TesteAutomatico (teste "BtnEncerrarExiste", que procura
    * BtnEncerrarClick/BtnFecharClick/BtnSairClick) reconheca este como o
    * metodo de encerramento do dialogo - mesmo nome do botao legado
    * (btnSair).
    *
    * Release() e nao Hide() porque este dialogo NAO devolve valor ao
    * chamador - ele so EXIBE os totais, e nao existe property nem metodo de
    * resultado para alguem ler depois que a tela fecha. A guarda de VARTYPE
    * existe porque o form pai e opcional no Init (o harness de teste
    * instancia o dialogo sem pai nenhum).
    *
    * Metodo PUBLIC (sem PROTECTED): e acionado por BINDEVENT, que falha em
    * silencio quando o handler e protegido (regra CLAUDE.md #3).
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        IF VARTYPE(THIS.this_oParentForm) = "O"
            THIS.this_oParentForm.Enabled = .T.
        ENDIF

        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Chama SigOpTotBO.ProcessarTotais() com os cursores que
    * o form pai ja deixou abertos na DataSession compartilhada (regra do
    * cabecalho do arquivo) e rebinda as 6 grades ao resultado. Fora do modo
    * de teste automatizado (TestFormWrapper/ValidarUIFidelity - mesma flag
    * de FORMCOR_LICOES_APRENDIDAS Problema 4) e so quando os cursores do
    * form pai (crSigCdOpe/TprMvCab/crTpmMvItn) realmente existem - sem
    * eles nao ha nada para somar, e ConfigurarGrades() ja deixou a
    * estrutura visual completa com os cursores placeholder vazios.
    *--------------------------------------------------------------------------
    FUNCTION CarregarLista()
        LOCAL loc_lSucesso, loc_cDopes, loc_oErro
        loc_lSucesso = .F.

        IF (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
            RETURN .T.
        ENDIF

        IF !USED("crSigCdOpe") OR !USED("TprMvCab") OR !USED("crTpmMvItn")
            RETURN .T.
        ENDIF

        TRY
            loc_cDopes = IIF(TYPE("TprMvCab.Dopes") != "U", ALLTRIM(TprMvCab.Dopes), "")

            IF THIS.this_oBusinessObject.ProcessarTotais(loc_cDopes)
                THIS.RebindGradeTotalProdutos()
                THIS.RebindGradeProduto()
                THIS.RebindGradesServicoOuTamanho()
                THIS.RebindGradeComponentes()
                THIS.RebindCamposTotais()
                loc_lSucesso = .T.
            ELSE
                MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro ao Totalizar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro ao carregar grades")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * RebindGradeTotalProdutos - Reaplica RecordSource/ControlSource/
    * Header/Width de grd_4c_TotalProdutos depois que SigOpTotBO.
    * CalcularTotais() processou this_cCursorValIte (xValIte) de verdade.
    * Sempre visivel (igual ao legado - Grade_Total.Visible = .t. no Init,
    * sem nenhuma condicao).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RebindGradeTotalProdutos()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorValIte

        WITH THIS.grd_4c_TotalProdutos
            .RecordSource = loc_cCursor
            .Column1.ControlSource = loc_cCursor + ".Moeda"
            .Column2.ControlSource = loc_cCursor + ".Total"
            .Column1.Header1.Caption = "Moeda"
            .Column2.Header1.Caption = "Total dos Produtos"
            .Column1.Width = 40
            .Column2.Width = 135
            .Visible = .T.
            .Refresh()
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * RebindGradeProduto - Reaplica RecordSource/ControlSource/Header/Width
    * de grd_4c_Produto depois que SigOpTotBO.MontarGradeProdutos() recriou
    * this_cCursorProEesti (ProEesti) de verdade. Sempre visivel.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RebindGradeProduto()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorProEesti

        WITH THIS.grd_4c_Produto
            .RecordSource = loc_cCursor
            .Column1.ControlSource = loc_cCursor + ".Cpros"
            .Column2.ControlSource = loc_cCursor + ".Qtds"
            .Column1.Header1.Caption = "Produto"
            .Column2.Header1.Caption = "Total"
            .Column1.Width = 125
            .Column2.Width = 80
            .Visible = .T.
            .Refresh()
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * RebindGradesServicoOuTamanho - Reproduz a exclusao mutua do Init
    * legado (linhas 1580-1587): grd_4c_Servicos e grd_4c_ProdutoTam ocupam
    * a MESMA posicao na tela - com servicos (this_lTemServicos),
    * grd_4c_Servicos aparece ligado a xValServ e grd_4c_ProdutoTam fica
    * oculta; sem servicos, o inverso (grd_4c_ProdutoTam ligado a ProTam).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RebindGradesServicoOuTamanho()
        LOCAL loc_cCursor

        IF THIS.this_oBusinessObject.this_lTemServicos
            loc_cCursor = THIS.this_oBusinessObject.this_cCursorValServ

            WITH THIS.grd_4c_Servicos
                .RecordSource = loc_cCursor
                .Column1.ControlSource = loc_cCursor + ".Moeda"
                .Column2.ControlSource = loc_cCursor + ".Total"
                .Column1.Header1.Caption = "Moeda"
                .Column2.Header1.Caption = "Total dos Servi" + CHR(231) + "os"
                .Column1.Width = 40
                .Column2.Width = 135
                .Visible = .T.
                .Refresh()
            ENDWITH

            THIS.grd_4c_ProdutoTam.Visible = .F.
        ELSE
            loc_cCursor = THIS.this_oBusinessObject.this_cCursorProTam

            WITH THIS.grd_4c_ProdutoTam
                .RecordSource = loc_cCursor
                .Column1.ControlSource = loc_cCursor + ".Cpros"
                .Column2.ControlSource = loc_cCursor + ".Qtds"
                .Column1.Header1.Caption = "Produto + Tam"
                .Column2.Header1.Caption = "Total"
                .Column1.Width = 150
                .Column2.Width = 45
                .Visible = .T.
                .Refresh()
            ENDWITH

            THIS.grd_4c_Servicos.Visible = .F.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * RebindGradeComponentes - Reproduz "If Not llTemCompo / GrdTCompo.
    * Visible = .f. / EndIf" do Init legado (linha 1589-1591): so aparece
    * quando SigOpTotBO.ProcessarComponentes() achou linhas em csCompo
    * (this_lTemComponentes).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RebindGradeComponentes()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorCompo

        IF THIS.this_oBusinessObject.this_lTemComponentes
            WITH THIS.grd_4c_Componentes
                .RecordSource = loc_cCursor
                .Column1.ControlSource = loc_cCursor + ".Codigos"
                .Column2.ControlSource = loc_cCursor + ".Qtds"
                .Column3.ControlSource = loc_cCursor + ".UniCompos"
                .Column4.ControlSource = loc_cCursor + ".QtsCons"
                .Column1.Header1.Caption = "Componente"
                .Column2.Header1.Caption = "Quantidade"
                .Column3.Header1.Caption = "Unid."
                .Column4.Header1.Caption = "Consumo"
                .Column1.Width = 80
                .Column2.Width = 80
                .Column3.Width = 30
                .Column4.Width = 60
                .Visible = .T.
                .Refresh()
            ENDWITH
        ELSE
            THIS.grd_4c_Componentes.Visible = .F.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - AddObject cria controles com Visible=.F. por
    * padrao; percorre recursivamente Controls (containers) e Pages (quando
    * algum container interno vier a ter PageFrame) para garantir que tudo
    * fique visivel apos a montagem.
    *
    * EXCECAO (regra do meta_prompt.md - "containers flutuantes"):
    * grd_4c_Servicos, grd_4c_Componentes e cnt_4c_CalculoCol nascem
    * Visible=.F. de proposito (exclusao mutua / bloco morto - ver
    * ConfigurarGrades()) e NAO podem ser forcados a .T. por este
    * passo generico; CarregarLista() decide a visibilidade final das
    * duas primeiras, e cnt_4c_CalculoCol fica oculto para sempre.
    * lbl_4c_Label5/txt_4c_Mtcub (bloco de metro cubico) sao a MESMA
    * excecao - nascem Visible=.F. em ConfigurarCamposTotais() (fieis ao
    * dump) e so RebindCamposTotais() (via CarregarLista) decide se
    * aparecem, quando SigOpTotBO.this_lMostrarMtCub fica .T.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl, loc_nP

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)

            IF INLIST(UPPER(loc_oControl.Name), "GRD_4C_SERVICOS", "GRD_4C_COMPONENTES", ;
                    "CNT_4C_CALCULOCOL", "LBL_4C_LABEL5", "TXT_4C_MTCUB")
                LOOP
            ENDIF

            IF PEMSTATUS(loc_oControl, "Visible", 5)
                loc_oControl.Visible = .T.
            ENDIF

            IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                FOR loc_nP = 1 TO loc_oControl.PageCount
                    THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
                ENDFOR
            ENDIF

            IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                THIS.TornarControlesVisiveis(loc_oControl)
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera a referencia ao Business Object. A reabilitacao do
    * form pai (legado: ThisForm.ParentForm.Enabled = .t.) fica no handler do
    * botao Retornar (BtnSairClick), nao aqui - o legado tambem faz isso
    * no Click, e
    * no Destroy/QueryUnload.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
