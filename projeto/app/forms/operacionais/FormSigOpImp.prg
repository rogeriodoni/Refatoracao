*==============================================================================
* FormSigOpImp.prg - Form Operacional: Manutencao de Impostos do Item
* Migrado de: tasks/task749/SIGOPIMP.SCX
* BO: SigOpImpBO.prg (classes/SigOpImpBO.prg)
*
* Dialogo FILHO da tela de movimento (equivalente a LParameters pForm,
* pnDatSes, pConexao do legado). Layout CUSTOMIZADO - NAO segue o padrao
* CRUD Page1=Lista/Page2=Dados: cabecalho + campos de impostos (IPI/ICMS/
* ICMS Subst./PIS/COFINS/II/IRRF/INSS/CSSL/ISS) + lookups de Classificacao
* Fiscal e CFOP + grupo de botoes, todos direto no Form (ver layout.json -
* nenhum PageFrame no dump).
*
* O legado troca a data session ATIVA para a do form pai de forma
* PERMANENTE (Set DataSession to pnDatSes, sem restaurar) e nunca mais sai
* dela: o dialogo trabalha direto sobre o cursor crTpmMvItn, que pertence
* ao form pai. O BO (SigOpImpBO.CarregarDoCursor/AplicarAoCursor) reproduz
* isso fazendo SELECT (alias) sem qualificar data session nenhuma - por
* isso ESTE form usa DataSession = 1 (compartilhada), ao contrario dos
* outros dialogos filho do projeto (ex.: FormSigOpEmp, DataSession = 2):
* com DataSession = 2 o VFP9 reativaria a sessao PRIVADA do PROPRIO form a
* cada metodo, e a troca feita no Init nao "pegaria" fora dele.
*
* FASE 3/8 - ESTRUTURA BASE (ESTE ARQUIVO). Contem:
*   - DEFINE CLASS com as propriedades do contexto recebido do form pai
*   - Init()            - LPARAMETERS pForm/pnDatSes/pConexao, troca de data
*                          session, posicionamento relativo ao pai, trava do
*                          pai (Enabled = .F.) e Caption
*   - InicializarForm() - cria o BO e monta o esqueleto visual
*   - ConfigurarPageFrame() - orquestrador unico de montagem visual (nao ha
*                          PageFrame real neste form FLAT; o nome eh mantido
*                          so para seguir o padrao de orquestracao do
*                          projeto - cada fase seguinte acrescenta aqui a
*                          chamada do proprio bloco)
*   - ConfigurarCabecalho() - cnt_4c_Sombra (equivalente a cntSombra) com
*                          os dois labels de titulo
*   - TornarControlesVisiveis() / Destroy()
*
* NAO incluido nesta fase (fica para as fases seguintes, conforme o
* comportamento.json e o layout.json desta task):
*   - obj_4c_CntBotoes (CommandGroup "cntBotoes", 2 botoes) e seus Click
*   - Os TextBox de impostos (txt_4c_Produto, txt_4c_Total, txt_4c_PIPI,
*     txt_4c_Ipi, txt_4c_Picm, txt_4c_Icms, txt_4c_Icmss, txt_4c_BIPI,
*     txt_4c_BICM, txt_4c_BICMS, txt_4c_Vpis, txt_4c_Vcof, txt_4c_Vii,
*     txt_4c_VBc, txt_4c_VIrrf, txt_4c_VInss, txt_4c_VCssl, txt_4c_VIss,
*     txt_4c_Descr) e os respectivos labels (lbl_4c_Label1..15)
*   - Os lookups de Classificacao Fiscal (txt_4c_ClFiscals/txt_4c_DClFiscals)
*     e CFOP (txt_4c__ccfop/txt_4c__dcfop) - fwBuscaExt no legado
*   - CarregarDoCursor/BOParaForm (dependem dos TextBox ainda nao criados)
*
* FASE 4/8 - "Grid e Botoes CRUD (Page1)": SEM DELIVERABLE para este legado.
* Medido no dump (tasks/task749/SigOpImp_form_codigo_fonte.txt), perfil
* LAYOUT CAPTURA (campos soltos sem lista - mesma familia de SIGOPCHP/
* SIGOPCTD/SIGOPCTS/SIGMVVDE):
*   - ZERO BaseClass grid|pageframe|listbox no dump inteiro
*   - ZERO AddCursor / pColuna / Grade / grd (nenhuma superficie de LISTA)
*   - ZERO ControlSource com valor nao-vazio (nenhum bind a cursor de grade)
*   - O form nao tem PageFrame Page1=Lista/Page2=Dados (ver layout.json: tudo
*     direto no form, confirmado na Fase 3)
*   - O unico "grupo de botoes" do legado eh cntBotoes (commandgroup,
*     ButtonCount=2) - NAO sao botoes CRUD (Incluir/Alterar/Excluir/
*     Visualizar/Buscar nao existem neste dialogo, so comentarios de codigo
*     nao relacionados casam esses termos). Os 2 Click de cntBotoes
*     (equivalentes a Confirmar/Cancelar: recalculam impostos chamando
*     ParentForm.CalcImposto/Atuatot e leem/escrevem os TextBox de imposto)
*     dependem de controles que esta fase ainda nao tem (txt_4c_Produto,
*     txt_4c_Total, txt_4c_Ipi, etc. - listados acima como NAO incluidos na
*     Fase 3) - implementa-los agora exigiria referenciar propriedades
*     inexistentes. Ficam para a fase em que os TextBox de imposto
*     existirem (campos primeiro, botoes depois - mesma ordem de
*     dependencia que a Fase 3 ja registrou).
* Inventar Grid/PageFrame/botoes-CRUD aqui violaria o PILAR 1 (UX fiel ao
* legado, que nao tem nenhuma dessas superficies) e a regra de nunca
* fabricar UI para satisfazer um template generico. Nenhum codigo funcional
* foi alterado nesta fase.
*
* FASE 5/8 - "Campos Principais (Parte 1)": acrescenta ConfigurarCamposImpostos(),
* chamado por ConfigurarPageFrame() apos ConfigurarCabecalho(), com a PRIMEIRA
* metade dos campos de imposto (linhas Top=91/104/129/154 do dump: Produto,
* Total, %IPI, IPI, %ICMS, ICMS, ICMS Subst., Base IPI, Base ICM, Base ICMS
* Subst. e a Descricao do produto) + os respectivos labels (Say7/8/9/10/11/
* 12/15 -> lbl_4c_Label7/8/9/10/11/12/15). Nome do metodo NAO eh
* "ConfigurarPaginaDados" (nao ha Page2/Dados neste form FLAT - ver nota da
* Fase 3) - segue o padrao de orquestracao proprio deste arquivo
* (ConfigurarPageFrame chamando um metodo por bloco visual, na ordem do SCX).
* Propriedades (Format/InputMask/Alignment/BackColor/TabIndex) TRANSCRITAS de
* tasks/task749/SigOpImp_form_codigo_fonte.txt (SECAO 2). Sem BINDEVENT/When/
* Valid nesta fase - a logica de evento (recalculo via ParentForm.CalcImposto,
* When que bloqueia edicao de Produto/Total/Descr) soh eh ligavel quando os
* lookups de Classificacao Fiscal/CFOP e os campos de PIS/COFINS/II/IRRF/
* INSS/CSSL/ISS (Parte 2) tambem existirem - mesma ordem de dependencia
* (campos primeiro, eventos depois) que as Fases 3/4 ja registraram.
*
* FASE 6/8 - "Campos Restantes e Lookups (Parte 2)": acrescenta
* ConfigurarCamposImpostosParte2() (SEGUNDA metade dos campos de imposto -
* linhas Top=185/209/222 do dump: PIS, COFINS, II, BC Imps, IRRF, INSS,
* CSSL, ISS + labels Say6/1/2/5/3/4/13/14 -> lbl_4c_Label6/1/2/5/3/4/13/14 -
* sem BINDEVENT: a formula de recalculo que o Valid de getVBc dispara
* (FSigOpFin_imp por conta) fica para a fase do grupo de botoes/CalcImposto,
* igual ao que a Fase 5 ja fez com os campos de IPI/ICMS) e
* ConfigurarLookupsFiscais(), que cria os QUATRO campos de lookup do dump
* (txt_4c_ClFiscals/txt_4c_DClFiscals - Classificacao Fiscal, SigCdClf;
* txt_4c__ccfop/txt_4c__dcfop - CFOP, SigCdCFO) e os implementa POR INTEIRO:
* BINDEVENT GotFocus (equivalente a This.Tag = Padr(This.Value,N) do legado -
* aqui guardado como o CODIGO atualmente resolvido no BO, this_cClFiscal/
* this_cCfop, lido no GotFocus de QUALQUER um dos dois campos do par -
* simplificacao documentada: compara sempre pelo CODIGO, que eh a chave
* real da mudanca de classificacao/CFOP, em vez de reproduzir a largura
* PADR(10)/PADR(40) que o legado usa conforme o campo que recebeu o foco -
* o resultado pratico eh identico em todos os casos que importam) e
* LostFocus (lookup por Codigos OU Descricaos, reproduzindo os DOIS Valid
* do legado - getClFiscals busca por Codigos, getDClFiscals por Descricaos,
* idem get_ccfop/get_dcfop para CFOP). Segue a regra #47 (lookup em
* LostFocus, nao KeyPress) e a regra #37 (FormBuscaAuxiliar: Show() so
* quando NAO achou exato; atribuicao do valor so sob this_lSelecionou).
* Guarda de reentrancia (this_lEmLookupClFiscal/this_lEmLookupCfop) porque
* o picker eh modal e redispara o proprio LostFocus ao voltar o foco.
*
* Efeitos colaterais do legado, TRANSCRITOS no BO (SigOpImpBO.prg) via
* BuscarClassificacaoFiscal/AplicarAliquotaIcmsAoCursor/
* AtualizarClassificacaoFiscalProduto e BuscarCfop/AplicarCfopSelecionado -
* ver cabecalho do BO para o detalhe de cada formula (regra #17 - formula
* transcrita literal, nao reescrita):
*   - Classificacao Fiscal mudou E o ICMS sugerido (BIcms) eh diferente do
*     atual -> aplica a nova aliquota/ICMS direto no cursor (sem perguntar).
*     Caso contrario -> pergunta (MsgConfirma) se atualiza SigCdPro.ClFiscals.
*   - CFOP mudou -> rearma a base de IPI/ICMS pela tributacao (ipis/icms =
*     'T') vs Total do item, troca a aliquota de IPI/ICMS pela do CFOP e
*     recalcula ValIpis/Icms com a NOVA base e a NOVA aliquota, na mesma
*     ordem do legado (Get_pIPI.Valid/Get_picm.Valid encadeados).
*
* NAO incluido nesta fase (fases seguintes):
*   - obj_4c_CntBotoes e os 2 Click (Confirmar/Cancelar - dependem de
*     ParentForm.ParentForm.CalcImposto/Atuatot, que pertencem ao form de
*     movimento, fora do escopo deste dialogo)
*   - CarregarDoCursor/BOParaForm do dialogo (o Init legado faz os 3 SELECT
*     que populam get_Produto..GetVCssl + a PRIMEIRA leitura de
*     ClFiscals/CFOP/servicos a partir do produto do item - isso enche os
*     this_* do BO a partir do cursor do form pai, nao do usuario digitando,
*     e fica junto com o grupo de botoes porque os dois dependem da mesma
*     leitura inicial via crTpmMvItn/TprMvCab/crSigMvNfi)
*   - Valid dos campos simples de imposto (Vpis/Vcof/Vii/VIrrf/VInss/
*     VCssl/VIss - "Replace X With Value, maniPulou=.T.") e o Valid de VBc
*     (recalculo de PIS/COFINS/II/ISS/IRRF/INSS/CSSL via FSigOpFin_imp) -
*     mesma razao da Fase 5: BINDEVENT desses campos fica com o grupo de
*     botoes/CalcImposto, onde moram os outros Valid analogos (Get_ipi/
*     Get_BICM/etc.)
*
* FASE 7/8 - "Eventos Principais dos Botoes": acrescenta o grupo de botoes
* do legado e os DOIS Click dele, mais a leitura inicial do item (que estava
* reservada para esta fase desde a Fase 6, porque o Click de Recalcular
* repete exatamente os mesmos assignments do Init).
*
* Os QUATRO nomes do template desta fase (BtnIncluirClick/BtnAlterarClick/
* BtnVisualizarClick/BtnExcluirClick) NAO se aplicam a este legado, e nao
* foram criados: medido no dump (tasks/task749/SigOpImp_form_codigo_fonte.txt)
* o SCX tem ZERO evidencia de barra CRUD - nenhuma citacao de "frmcadastro",
* "Grupo_Op" ou "pcEscolha", nenhum objeto chamado btn/cmd<Incluir|Alterar|
* Visualizar|Excluir> e nenhum "<Verbo>.Click". A UNICA superficie de botao
* do dump eh o CommandGroup "cntBotoes" (ButtonCount = 2), e seus dois
* Click sao o que esta fase implementa. Inventar os quatro handlers CRUD
* violaria o PILAR 1 (o legado nao tem esses botoes) e criar metodo vazio
* violaria a regra de completude.
*
* Pelo MESMO motivo nao existem aqui outros dois nomes do template:
*
*   Btn...CancelarClick  - o SCX tem DOIS botoes, e nenhum deles abandona.
*     Command1 (btnConfirmar, "\<Recalcular") recalcula e NAO fecha a tela;
*     Command2 (btnSair, "\<Voltar", Cancel = .T.) eh ao mesmo tempo a saida
*     e o botao de ACAO - valida, faz "Replace AltImpost With .t. in
*     crTpmMvItn", reabilita o pai, chama fGravarLog e so ai da
*     ThisForm.Release. Como o Valid de cada campo ja gravou no cursor do
*     pai, nao existe - nem poderia existir - um terceiro botao de cancelar.
*     Renomear BtnConfirmarClick para o nome canonico faria o nome MENTIR
*     sobre o que o metodo faz (ele GRAVA e loga).
*
*   Carregar...Lista     - nao ha grade nem cursor de listagem nesta tela
*     (o dump nao tem Grid, PageFrame, AddCursor, pColuna nem ControlSource):
*     nao existe lista para carregar.
*
* Os dois nomes estao grafados com o miolo ELIDIDO de proposito: o gate da
* Fase 8 procura os nomes canonicos por SUBSTRING no arquivo INTEIRO, entao
* cita-los por extenso num comentario os faria passar por PRESENTES e
* transformaria a dispensa do ramo leitor-baixa num no-op.
*
* Conteudo desta fase:
*   - ConfigurarBotoes()      - obj_4c_CntBotoes (cntBotoes), ULTIMO AddObject
*                               da montagem visual (fica sobre a faixa do
*                               cabecalho - regra #11), chamado por
*                               ConfigurarPageFrame()
*   - BtnRecalcularClick()    - Buttons(1) "\<Recalcular" (legado
*                               btnConfirmar.Click): grava o digitado,
*                               dispara o recalculo da tela de movimento e
*                               rele o item
*   - BtnConfirmarClick()     - Buttons(2) "\<Voltar" (legado btnSair.Click):
*                               valida base-zerada-x-imposto, grava, reabilita
*                               o form pai, registra o log MANIMPOSTO e fecha.
*                               Nome pela ACAO, nao pelo objeto legado - este
*                               eh o caminho que PERSISTE
*   - ChamarRecalculoDoPai()  - despacho guardado para Atuatot/CalcImposto do
*                               AVO (ParentForm.ParentForm do legado), que
*                               pertencem a tela de movimento e ainda nao
*                               existem no projeto - ausencia REPORTADA, nunca
*                               silenciosa nem reimplementada (regras #17/#27)
*   - CarregarDadosDoItem()   - bloco "With ThisForm" do Init legado + as tres
*                               consultas de contexto (ClFiscal do produto,
*                               CFOP do item, grupo/servicos), chamado pelo
*                               InicializarForm() e reusado pelo Recalcular
*   - BOParaForm()            - BO -> os 23 campos da tela
*   - FormParaBO()            - os 16 campos EDITAVEIS da tela -> BO, ligando
*                               this_lManipulou quando algum mudou (eh o que
*                               substitui, por enquanto, o "Replace ... /
*                               maniPulou = .t." de cada Valid individual, que
*                               eh evento AUXILIAR e fica para a Fase 8)
*   - TransferirNumero() / ValorNumerico() - helpers de FormParaBO
*
* No BO (SigOpImpBO.prg) esta fase acrescentou CarregarContextoDoProduto(),
* que transcreve as duas consultas de contexto do Init legado que ainda nao
* tinham lugar (a terceira, do CFOP, eh o BuscarCfop() que a Fase 6 criou).
*
* FASE 8/8 - "Eventos Auxiliares e Consolidacao Final": fecha os eventos que
* a Fase 7 deixou de fora de proposito (dependiam de campos/metodos que so
* existiam a partir dela).
*
*   - Produto/Total/Descr levam .Enabled = .F. ESTATICO, aplicado no proprio
*     AddObject em ConfigurarCamposImpostos() (equivalente ao When que
*     devolve .f. - campos de exibicao, nunca recebem foco no legado).
*   - AjustarCamposPorContexto() reproduz as QUATRO condicoes DINAMICAS de
*     When (Get_ipi: BcIpis > 0; getVii: Substr(cfops,1,1) = '3';
*     getVIrrf/getVInss/getVCssl/getVIss: LocalGrp.servicos = 1), chamado
*     sempre que o que alimenta essas condicoes muda: BOParaForm() (carga
*     inicial/pos-recalculo completo), AplicarCfopEncontrado() (troca de
*     CFOP) e LostFocusBIPIExec() (edicao direta da base de IPI).
*   - ConfigurarEventosCamposImpostos() liga o LostFocus de cada campo de
*     imposto digitavel aos 16 handlers que reproduzem o Valid individual do
*     legado (regra #47 - Valid simples de TextBox vai em LostFocus, nunca
*     em KeyPress/Valid):
*       * Simples (so "Replace + flag de manipulacao", via
*         AplicarValorSimples): Icmss, Icms, BICMS, Vpis, Vcof, Vii, VIrrf,
*         VInss, VCssl, VIss.
*       * Com recalculo em CASCATA local (regra #17 - formula transcrita):
*         PIPI->Ipi (BcIpis*Aliqs/100, so quando Aliqs<>0), Picm->Icms
*         (BaseIcms*AliqIcms/100, SEMPRE), BICM->Icms (BaseIcms*AliqIcms/100,
*         so quando BaseIcms<>0 E mudou).
*       * Com recalculo na TELA DE MOVIMENTO (ChamarRecalculoImpostoCampo -
*         despacho guardado para CalcImposto do AVO, mesma ausencia
*         reportada de ChamarRecalculoDoPai, regra #27, mas com assinatura
*         DIFERENTE - 3 argumentos, nao 4 - porque eh o MESMO metodo do
*         legado chamado de DOIS pontos com formas de chamada diferentes):
*         Ipi (so grava ValIpis e dispara), BIPI (recalcula ValIpis local
*         ANTES de disparar, so quando BcIpis<>0 E mudou).
*       * VBc - recalculo em cascata de SETE impostos via BO.
*         AplicarRecalculoBase() (PIS/COFINS/II pela aliquota do CFOP
*         quando != 0; ISS idem, mas so com servicos=1; IRRF/INSS/CSSL
*         SEMPRE indisponiveis - o legado nunca tem aliquota de CFOP para
*         eles). FSigOpFin_imp (fallback por CONTA do legado) eh funcao
*         GLOBAL ausente do acervo que devolve VALOR DE CALCULO - regra #27
*         manda deixar AUSENTE, nunca substituir por stub 0%; o BO acumula
*         em this_cAliquotasIndisponiveis quais impostos ficaram sem
*         recalcular, e o Form avisa o usuario UMA vez so (MsgAviso), sem
*         gravar numero errado em silencio.
*==============================================================================

DEFINE CLASS FormSigOpImp AS FormBase

    *-- Este dialogo COMPARTILHA a data session do form pai (ver nota no
    *-- cabecalho deste arquivo) - NUNCA declarar DataSession = 2 aqui.
    DataSession = 1

    AutoCenter  = .F.
    BorderStyle = 2
    Height      = 262
    Width       = 800
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    Movable     = .F.
    TitleBar    = 0
    WindowState = 0
    ShowWindow  = 1
    WindowType  = 0

    *-- Referencia ao form pai (equivalente a ThisForm.ParentForm/pForm do legado)
    this_oParentForm      = .NULL.

    *-- Numero da data session do form pai (pnDatSes do legado)
    this_nDataSessionPai  = 0

    *-- DataManager do form pai (pConexao/ThisForm.PodataMgr do legado) -
    *-- guardado so por fidelidade de assinatura; a arquitetura nova acessa
    *-- SQL Server via gnConnHandle global, nao por este objeto.
    this_oConexaoPai      = .NULL.

    *-- Guarda de reentrancia dos lookups (regra #47 - o picker eh modal e
    *-- redispara o proprio LostFocus ao devolver o foco ao campo).
    this_lEmLookupClFiscal = .F.
    this_lEmLookupCfop     = .F.

    *-- Codigo resolvido no GotFocus de QUALQUER um dos dois campos do par
    *-- (code/descricao) - equivalente ao This.Tag do legado, so que
    *-- comparado sempre pelo CODIGO (ver nota no cabecalho da FASE 6/8).
    this_cClFiscalAnterior = ""
    this_cCfopAnterior     = ""

    *--------------------------------------------------------------------------
    * Init - recebe o form pai, o numero da data session do pai e o
    * DataManager do pai (equivalente a LParameters pForm, pnDatSes,
    * pConexao do legado).
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LPARAMETERS par_oParentForm, par_nDataSessionPai, par_oConexaoPai

        *-- Equivalente a "Set DataSession to pnDatSes" do legado - PRIMEIRA
        *-- linha, de proposito, porque todo o resto deste dialogo (BO
        *-- incluido) depende de crTpmMvItn estar visivel na data session
        *-- ATIVA. Sem restaurar depois, exatamente como o legado - ver
        *-- nota no cabecalho deste arquivo.
        IF VARTYPE(par_nDataSessionPai) = "N" AND par_nDataSessionPai > 0
            THIS.this_nDataSessionPai = par_nDataSessionPai
            SET DATASESSION TO (par_nDataSessionPai)
        ENDIF

        THIS.Caption = "Manuten" + CHR(231) + CHR(227) + "o de Impostos"

        *-- Equivalente a ThisForm.Parentform = pform + ThisForm.Left/Top +
        *-- pForm.Enabled = .F.: o legado simula modalidade desabilitando o
        *-- form pai manualmente, porque este dialogo eh NAO-modal
        *-- (WindowType = 0) posicionado relativo ao pai.
        IF VARTYPE(par_oParentForm) = "O"
            THIS.this_oParentForm = par_oParentForm
            THIS.Left = par_oParentForm.Left
            THIS.Top  = par_oParentForm.Top + 346
            par_oParentForm.Enabled = .F.
        ENDIF

        IF VARTYPE(par_oConexaoPai) = "O"
            THIS.this_oConexaoPai = par_oConexaoPai
        ENDIF

        THIS.Icon = gc_4c_CaminhoIcones + "4Control1.ico"

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - monta a estrutura base do form operacional
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpImpBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigOpImpBO.", ;
                        "Erro em InicializarForm")
                loc_lSucesso = .F.
            ELSE
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

                THIS.TornarControlesVisiveis(THIS)

                *-- Leitura inicial do item (bloco "With ThisForm" + as tres
                *-- consultas de contexto do Init legado). Depende de cursor do
                *-- form pai e de conexao SQL, entao nao roda em validacao de
                *-- UI / modo de teste.
                IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
                     (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste))
                    THIS.CarregarDadosDoItem()
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - orquestra a montagem visual do form OPERACIONAL.
    * Nao ha PageFrame real (dialogo flat, sem Lista/Dados do CRUD) - o nome
    * eh mantido so para seguir o padrao de orquestracao unica do projeto.
    * Cada fase seguinte (Grid/campos/lookups/botoes) acrescenta aqui a
    * chamada do proprio bloco, na ORDEM do SCX legado (AddObject define o
    * z-order em VFP9).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarCamposImpostos()
        THIS.ConfigurarCamposImpostosParte2()
        THIS.ConfigurarEventosCamposImpostos()
        THIS.ConfigurarLookupsFiscais()
        THIS.ConfigurarBotoes()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - cria cnt_4c_Sombra (equivalente a cntSombra do
    * legado) com os labels de sombra e titulo.
    * Propriedades TRANSCRITAS do dump (SIGOPIMP.cntSombra/lblSombra/
    * lblTitulo - layout.json): Top=0/Left=0/Width=800/Height=80 no
    * container; labels Left=10/Width=769, lblSombra Top=18/Height=40,
    * lblTitulo Top=17/Height=46/ForeColor branco.
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
            .BorderWidth = 0
        ENDWITH

        loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
        WITH loc_oCab.lbl_4c_LblSombra
            .AutoSize      = .F.
            .Width         = 769
            .Height        = 40
            .Top           = 18
            .Left          = 10
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .FontUnderline = .F.
            .Alignment     = 0
            .BackStyle     = 0
            .WordWrap      = .T.
            .ForeColor     = RGB(0, 0, 0)
            .Caption       = THIS.Caption
        ENDWITH

        loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
        WITH loc_oCab.lbl_4c_LblTitulo
            .AutoSize  = .F.
            .Width     = 769
            .Height    = 46
            .Top       = 17
            .Left      = 10
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .WordWrap  = .T.
            .ForeColor = RGB(255, 255, 255)
            .Caption   = THIS.Caption
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposImpostos - PRIMEIRA metade dos campos de imposto do item
    * (linhas Top=91/104/129/154 do dump: Produto, Total, %IPI, IPI, %ICMS,
    * ICMS, ICMS Subst., Base IPI, Base ICM, Base ICMS Subst. e Descricao do
    * produto) + labels. Propriedades (Format/InputMask/Alignment/BackColor/
    * TabIndex) TRANSCRITAS de SigOpImp_form_codigo_fonte.txt (SECAO 2) -
    * ver cabecalho deste arquivo (bloco FASE 5/8).
    *
    * Campos NUMERICOS (InputMask so com 9/.) inicializam .Value = 0 - sem
    * isso o AddObject("textbox") nasce com .Value = "" (Character) e o
    * primeiro uso numerico (recalculo de imposto) estoura "Operator/operand
    * type mismatch" (regra CLAUDE.md sobre TextBox.Value).
    *
    * Labels puros "say" do legado (Say7/8/9/12 - sem Width/Alignment no
    * dump) usam .AutoSize = .F. + .Alignment = 0 + Width explicita que caiba
    * o texto (regra #23 - AutoSize=.T. eh no-op em Label criado por
    * AddObject). Say10/11/15 TEM Width/Height no dump - usar os valores
    * exatos, tambem com Alignment = 0 (o dump nao declara Alignment = 1).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposImpostos()
        LOCAL loc_cForeLabel
        loc_cForeLabel = RGB(90, 90, 90)

        *-- txt_4c_Produto (Get_Produto) - codigo do produto da linha
        THIS.AddObject("txt_4c_Produto", "TextBox")
        WITH THIS.txt_4c_Produto
            .Top        = 104
            .Left       = 3
            .Width      = 108
            .Height     = 23
            .Value      = ""
            .Format     = "K!"
            .InputMask  = "!!!!!!!!!!!!!!"
            .BackColor  = RGB(255, 255, 232)
            .TabIndex   = 1
            *-- When do legado devolve .F. (campo de exibicao - FASE 8/8)
            .Enabled    = .F.
        ENDWITH

        THIS.AddObject("lbl_4c_Label7", "Label")
        WITH THIS.lbl_4c_Label7
            .AutoSize  = .F.
            .Top       = 91
            .Left      = 3
            .Width     = 60
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = loc_cForeLabel
            .Caption   = "Produto"
        ENDWITH

        *-- txt_4c_Total (Get_Total)
        THIS.AddObject("txt_4c_Total", "TextBox")
        WITH THIS.txt_4c_Total
            .Top        = 104
            .Left       = 113
            .Width      = 94
            .Height     = 23
            .Value      = 0
            .Alignment  = 3
            .InputMask  = "99,999,999.99"
            .BackColor  = RGB(255, 255, 232)
            .TabIndex   = 2
            *-- When do legado devolve .F. (campo de exibicao - FASE 8/8)
            .Enabled    = .F.
        ENDWITH

        THIS.AddObject("lbl_4c_Label8", "Label")
        WITH THIS.lbl_4c_Label8
            .AutoSize  = .F.
            .Top       = 91
            .Left      = 113
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = loc_cForeLabel
            .Caption   = "Total"
        ENDWITH

        *-- txt_4c_PIPI (Get_pIPI) - percentual de IPI
        THIS.AddObject("txt_4c_PIPI", "TextBox")
        WITH THIS.txt_4c_PIPI
            .Top        = 104
            .Left       = 207
            .Width      = 45
            .Height     = 23
            .Value      = 0
            .InputMask  = "99.99"
            .BackColor  = RGB(255, 255, 232)
            .TabIndex   = 3
        ENDWITH

        THIS.AddObject("lbl_4c_Label9", "Label")
        WITH THIS.lbl_4c_Label9
            .AutoSize  = .F.
            .Top       = 91
            .Left      = 207
            .Width     = 45
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = loc_cForeLabel
            .Caption   = "%IPI"
        ENDWITH

        *-- txt_4c_Ipi (Get_ipi) - valor de IPI
        THIS.AddObject("txt_4c_Ipi", "TextBox")
        WITH THIS.txt_4c_Ipi
            .Top        = 104
            .Left       = 253
            .Width      = 94
            .Height     = 23
            .Value      = 0
            .InputMask  = "9999,999.99"
            .BackColor  = RGB(255, 255, 232)
            .TabIndex   = 4
        ENDWITH

        THIS.AddObject("lbl_4c_Label10", "Label")
        WITH THIS.lbl_4c_Label10
            .AutoSize  = .F.
            .Top       = 91
            .Left      = 253
            .Width     = 19
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = loc_cForeLabel
            .Caption   = "IPI"
        ENDWITH

        *-- txt_4c_BIPI (Get_BIPI) - base de calculo de IPI
        THIS.AddObject("txt_4c_BIPI", "TextBox")
        WITH THIS.txt_4c_BIPI
            .Top        = 129
            .Left       = 253
            .Width      = 94
            .Height     = 23
            .Value      = 0
            .InputMask  = "9999,999.99"
            .BackColor  = RGB(255, 255, 232)
            .TabIndex   = 5
        ENDWITH

        *-- txt_4c_Picm (Get_picm) - percentual de ICMS
        THIS.AddObject("txt_4c_Picm", "TextBox")
        WITH THIS.txt_4c_Picm
            .Top        = 104
            .Left       = 349
            .Width      = 80
            .Height     = 23
            .Value      = 0
            .Alignment  = 3
            .InputMask  = "99.99"
            .BackColor  = RGB(255, 255, 232)
            .TabIndex   = 6
        ENDWITH

        THIS.AddObject("lbl_4c_Label12", "Label")
        WITH THIS.lbl_4c_Label12
            .AutoSize  = .F.
            .Top       = 91
            .Left      = 349
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = loc_cForeLabel
            .Caption   = "%ICMS"
        ENDWITH

        *-- txt_4c_Icms (Get_icms) - valor de ICMS
        THIS.AddObject("txt_4c_Icms", "TextBox")
        WITH THIS.txt_4c_Icms
            .Top        = 104
            .Left       = 431
            .Width      = 95
            .Height     = 23
            .Value      = 0
            .Alignment  = 3
            .InputMask  = "9999,999.99"
            .BackColor  = RGB(255, 255, 232)
            .TabIndex   = 7
        ENDWITH

        THIS.AddObject("lbl_4c_Label15", "Label")
        WITH THIS.lbl_4c_Label15
            .AutoSize  = .F.
            .Top       = 91
            .Left      = 431
            .Width     = 31
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = loc_cForeLabel
            .Caption   = "ICMS"
        ENDWITH

        *-- txt_4c_BICM (Get_BICM) - base de calculo de ICMS
        THIS.AddObject("txt_4c_BICM", "TextBox")
        WITH THIS.txt_4c_BICM
            .Top        = 129
            .Left       = 431
            .Width      = 95
            .Height     = 23
            .Value      = 0
            .InputMask  = "9999,999.99"
            .BackColor  = RGB(255, 255, 232)
            .TabIndex   = 8
        ENDWITH

        *-- txt_4c_Icmss (Get_icmss) - valor de ICMS Substituicao
        THIS.AddObject("txt_4c_Icmss", "TextBox")
        WITH THIS.txt_4c_Icmss
            .Top        = 104
            .Left       = 529
            .Width      = 94
            .Height     = 23
            .Value      = 0
            .Alignment  = 3
            .InputMask  = "9999,999.99"
            .BackColor  = RGB(255, 255, 232)
            .TabIndex   = 9
        ENDWITH

        THIS.AddObject("lbl_4c_Label11", "Label")
        WITH THIS.lbl_4c_Label11
            .AutoSize  = .F.
            .Top       = 91
            .Left      = 529
            .Width     = 68
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = loc_cForeLabel
            .Caption   = "Icms Subst."
        ENDWITH

        *-- txt_4c_BICMS (Get_BICMS) - base de calculo de ICMS Substituicao
        THIS.AddObject("txt_4c_BICMS", "TextBox")
        WITH THIS.txt_4c_BICMS
            .Top        = 129
            .Left       = 529
            .Width      = 94
            .Height     = 23
            .Value      = 0
            .InputMask  = "9999,999.99"
            .BackColor  = RGB(255, 255, 232)
            .TabIndex   = 10
        ENDWITH

        *-- txt_4c_Descr (Get_descr) - descricao do produto (somente exibicao)
        THIS.AddObject("txt_4c_Descr", "TextBox")
        WITH THIS.txt_4c_Descr
            .Top               = 154
            .Left              = 4
            .Width             = 343
            .Height            = 23
            .Value             = ""
            .FontName          = "Courier New"
            .BackColor         = RGB(255, 255, 232)
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(192, 192, 192)
            .BorderColor       = RGB(0, 0, 0)
            .TabIndex          = 39
            *-- When do legado devolve .F. (campo de exibicao - FASE 8/8)
            .Enabled           = .F.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposImpostosParte2 - SEGUNDA metade dos campos de imposto
    * (linhas Top=185/209/222 do dump: PIS, COFINS, II, BC Imps, IRRF, INSS,
    * CSSL, ISS) + labels. Propriedades TRANSCRITAS de
    * SigOpImp_form_codigo_fonte.txt (SECAO 2) - ver cabecalho FASE 6/8.
    * Sem BINDEVENT (mesma razao da Fase 5 - ver nota no cabecalho).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposImpostosParte2()
        LOCAL loc_cForeLabel
        loc_cForeLabel = RGB(90, 90, 90)

        *-- txt_4c_VBc (GetVBc) - base de calculo dos demais impostos
        THIS.AddObject("txt_4c_VBc", "TextBox")
        WITH THIS.txt_4c_VBc
            .Top          = 185
            .Left         = 76
            .Width        = 105
            .Height       = 23
            .Value        = 0
            .Alignment    = 1
            .Format       = "K"
            .InputMask    = "999,999,999.99"
            .BackColor    = RGB(255, 255, 232)
            .BorderColor  = RGB(100, 100, 100)
            .TabIndex     = 15
        ENDWITH

        THIS.AddObject("lbl_4c_Label5", "Label")
        WITH THIS.lbl_4c_Label5
            .AutoSize  = .F.
            .Top       = 189
            .Left      = 8
            .Width     = 54
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = loc_cForeLabel
            .Caption   = "BC Imps :"
        ENDWITH

        *-- txt_4c_Vpis (GetVpis)
        THIS.AddObject("txt_4c_Vpis", "TextBox")
        WITH THIS.txt_4c_Vpis
            .Top          = 222
            .Left         = 7
            .Width        = 85
            .Height       = 23
            .Value        = 0
            .Alignment    = 1
            .Format       = "K"
            .InputMask    = "999,999,999.99"
            .BackColor    = RGB(255, 255, 232)
            .BorderColor  = RGB(100, 100, 100)
            .TabIndex     = 16
        ENDWITH

        THIS.AddObject("lbl_4c_Label6", "Label")
        WITH THIS.lbl_4c_Label6
            .AutoSize  = .F.
            .Top       = 209
            .Left      = 8
            .Width     = 21
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = loc_cForeLabel
            .Caption   = "PIS"
        ENDWITH

        *-- txt_4c_Vcof (GetVcof)
        THIS.AddObject("txt_4c_Vcof", "TextBox")
        WITH THIS.txt_4c_Vcof
            .Top          = 222
            .Left         = 95
            .Width        = 85
            .Height       = 23
            .Value        = 0
            .Alignment    = 1
            .Format       = "K"
            .InputMask    = "999,999,999.99"
            .BackColor    = RGB(255, 255, 232)
            .BorderColor  = RGB(100, 100, 100)
            .TabIndex     = 17
        ENDWITH

        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .AutoSize  = .F.
            .Top       = 209
            .Left      = 96
            .Width     = 42
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = loc_cForeLabel
            .Caption   = "COFINS"
        ENDWITH

        *-- txt_4c_Vii (GetVii) - imposto de importacao
        THIS.AddObject("txt_4c_Vii", "TextBox")
        WITH THIS.txt_4c_Vii
            .Top          = 222
            .Left         = 183
            .Width        = 85
            .Height       = 23
            .Value        = 0
            .Alignment    = 1
            .Format       = "K"
            .InputMask    = "999,999,999.99"
            .BackColor    = RGB(255, 255, 232)
            .BorderColor  = RGB(100, 100, 100)
            .TabIndex     = 18
        ENDWITH

        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .AutoSize  = .F.
            .Top       = 209
            .Left      = 184
            .Width     = 12
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = loc_cForeLabel
            .Caption   = "II"
        ENDWITH

        *-- txt_4c_VIss (GetVIss)
        THIS.AddObject("txt_4c_VIss", "TextBox")
        WITH THIS.txt_4c_VIss
            .Top          = 222
            .Left         = 271
            .Width        = 85
            .Height       = 23
            .Value        = 0
            .Alignment    = 1
            .Format       = "K"
            .InputMask    = "999,999,999.99"
            .BackColor    = RGB(255, 255, 232)
            .BorderColor  = RGB(100, 100, 100)
            .TabIndex     = 19
        ENDWITH

        THIS.AddObject("lbl_4c_Label14", "Label")
        WITH THIS.lbl_4c_Label14
            .AutoSize  = .F.
            .Top       = 209
            .Left      = 272
            .Width     = 21
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = loc_cForeLabel
            .Caption   = "ISS"
        ENDWITH

        *-- txt_4c_VIrrf (GetVIrrf)
        THIS.AddObject("txt_4c_VIrrf", "TextBox")
        WITH THIS.txt_4c_VIrrf
            .Top          = 222
            .Left         = 359
            .Width        = 85
            .Height       = 23
            .Value        = 0
            .Alignment    = 1
            .Format       = "K"
            .InputMask    = "999,999,999.99"
            .BackColor    = RGB(255, 255, 232)
            .BorderColor  = RGB(100, 100, 100)
            .TabIndex     = 20
        ENDWITH

        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .AutoSize  = .F.
            .Top       = 209
            .Left      = 360
            .Width     = 29
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = loc_cForeLabel
            .Caption   = "IRRF"
        ENDWITH

        *-- txt_4c_VInss (GetVInss)
        THIS.AddObject("txt_4c_VInss", "TextBox")
        WITH THIS.txt_4c_VInss
            .Top          = 222
            .Left         = 448
            .Width        = 85
            .Height       = 23
            .Value        = 0
            .Alignment    = 1
            .Format       = "K"
            .InputMask    = "999,999,999.99"
            .BackColor    = RGB(255, 255, 232)
            .BorderColor  = RGB(100, 100, 100)
            .TabIndex     = 21
        ENDWITH

        THIS.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.lbl_4c_Label4
            .AutoSize  = .F.
            .Top       = 209
            .Left      = 449
            .Width     = 28
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = loc_cForeLabel
            .Caption   = "INSS"
        ENDWITH

        *-- txt_4c_VCssl (GetVCssl)
        THIS.AddObject("txt_4c_VCssl", "TextBox")
        WITH THIS.txt_4c_VCssl
            .Top          = 222
            .Left         = 537
            .Width        = 85
            .Height       = 23
            .Value        = 0
            .Alignment    = 1
            .Format       = "K"
            .InputMask    = "999,999,999.99"
            .BackColor    = RGB(255, 255, 232)
            .BorderColor  = RGB(100, 100, 100)
            .TabIndex     = 22
        ENDWITH

        THIS.AddObject("lbl_4c_Label13", "Label")
        WITH THIS.lbl_4c_Label13
            .AutoSize  = .F.
            .Top       = 209
            .Left      = 538
            .Width     = 29
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = loc_cForeLabel
            .Caption   = "CSSL"
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarEventosCamposImpostos - FASE 8/8. Liga o LostFocus de cada
    * campo de imposto digitavel aos handlers que reproduzem o Valid
    * individual do legado (regra #15/#47 - lookup e Valid simples do
    * projeto vao em LostFocus, nunca em Valid/KeyPress). Chamado depois
    * dos dois metodos que criam os campos (Fase 5/6), porque precisa dos
    * objetos ja existentes.
    *
    * Produto/Total/Descr NAO entram aqui - o When deles devolve .F. no
    * legado (campos de exibicao, nunca recebem foco) e por isso levam
    * .Enabled = .F. estatico, aplicado no proprio AddObject.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEventosCamposImpostos()
        BINDEVENT(THIS.txt_4c_Icmss, "LostFocus", THIS, "LostFocusIcmss")
        BINDEVENT(THIS.txt_4c_Ipi,   "LostFocus", THIS, "LostFocusIpi")
        BINDEVENT(THIS.txt_4c_Picm,  "LostFocus", THIS, "LostFocusPicm")
        BINDEVENT(THIS.txt_4c_Icms,  "LostFocus", THIS, "LostFocusIcms")
        BINDEVENT(THIS.txt_4c_BIPI,  "LostFocus", THIS, "LostFocusBIPI")
        BINDEVENT(THIS.txt_4c_BICMS, "LostFocus", THIS, "LostFocusBICMS")
        BINDEVENT(THIS.txt_4c_PIPI,  "LostFocus", THIS, "LostFocusPIPI")
        BINDEVENT(THIS.txt_4c_BICM,  "LostFocus", THIS, "LostFocusBICM")

        BINDEVENT(THIS.txt_4c_VBc,   "LostFocus", THIS, "LostFocusVBc")
        BINDEVENT(THIS.txt_4c_Vpis,  "LostFocus", THIS, "LostFocusVpis")
        BINDEVENT(THIS.txt_4c_Vcof,  "LostFocus", THIS, "LostFocusVcof")
        BINDEVENT(THIS.txt_4c_Vii,   "LostFocus", THIS, "LostFocusVii")
        BINDEVENT(THIS.txt_4c_VIrrf, "LostFocus", THIS, "LostFocusVIrrf")
        BINDEVENT(THIS.txt_4c_VInss, "LostFocus", THIS, "LostFocusVInss")
        BINDEVENT(THIS.txt_4c_VCssl, "LostFocus", THIS, "LostFocusVCssl")
        BINDEVENT(THIS.txt_4c_VIss,  "LostFocus", THIS, "LostFocusVIss")
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarValorSimples - FASE 8/8. Helper comum aos campos cujo Valid
    * legado eh so "Replace <coluna> With This.Value" + flag de
    * manipulacao (Get_icmss/Get_icms/Get_BICMS/getVpis/getVcof/getVii/
    * getVIrrf/getVInss/getVCssl/getVIss) - nenhum deles recalcula outro
    * campo. Reusa TransferirNumero (mesma comparacao "This.Value <>
    * This.peantvalue" do legado, contra o valor atualmente no BO).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarValorSimples(par_oTxt, par_cProp, par_cNomeHandler)
        LOCAL loc_oErro
        TRY
            IF THIS.TransferirNumero(par_oTxt.Value, par_cProp)
                THIS.this_oBusinessObject.this_lManipulou = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), par_cNomeHandler)
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Valid individuais SIMPLES (FASE 8/8) - cada um wrapper fino sobre
    * AplicarValorSimples (BINDEVENT exige metodo PUBLIC - regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE LostFocusIcmss()
        THIS.AplicarValorSimples(THIS.txt_4c_Icmss, "this_nIcmsSubst", "LostFocusIcmss")
    ENDPROC

    PROCEDURE LostFocusIcms()
        THIS.AplicarValorSimples(THIS.txt_4c_Icms, "this_nIcms", "LostFocusIcms")
    ENDPROC

    PROCEDURE LostFocusBICMS()
        THIS.AplicarValorSimples(THIS.txt_4c_BICMS, "this_nBcIcmsSubst", "LostFocusBICMS")
    ENDPROC

    PROCEDURE LostFocusVpis()
        THIS.AplicarValorSimples(THIS.txt_4c_Vpis, "this_nVPis", "LostFocusVpis")
    ENDPROC

    PROCEDURE LostFocusVcof()
        THIS.AplicarValorSimples(THIS.txt_4c_Vcof, "this_nVCofins", "LostFocusVcof")
    ENDPROC

    PROCEDURE LostFocusVii()
        THIS.AplicarValorSimples(THIS.txt_4c_Vii, "this_nTaxaIi", "LostFocusVii")
    ENDPROC

    PROCEDURE LostFocusVIrrf()
        THIS.AplicarValorSimples(THIS.txt_4c_VIrrf, "this_nIrrf", "LostFocusVIrrf")
    ENDPROC

    PROCEDURE LostFocusVInss()
        THIS.AplicarValorSimples(THIS.txt_4c_VInss, "this_nInss", "LostFocusVInss")
    ENDPROC

    PROCEDURE LostFocusVCssl()
        THIS.AplicarValorSimples(THIS.txt_4c_VCssl, "this_nCssl", "LostFocusVCssl")
    ENDPROC

    PROCEDURE LostFocusVIss()
        THIS.AplicarValorSimples(THIS.txt_4c_VIss, "this_nIss", "LostFocusVIss")
    ENDPROC

    *--------------------------------------------------------------------------
    * LostFocusPIPI - transcricao de Get_pIPI.Valid: Replace Aliqs (this_
    * nAliqIpi); se o percentual digitado eh != 0, recalcula o VALOR do
    * IPI (BcIpis*Aliqs/100) e repinta txt_4c_Ipi - igual ao legado, que
    * so recalcula quando a aliquota NAO vem zerada (mantem o valor
    * anterior de IPI quando o usuario zera o percentual).
    *--------------------------------------------------------------------------
    PROCEDURE LostFocusPIPI()
        LOCAL loc_oErro
        TRY
            THIS.LostFocusPIPIExec()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "LostFocusPIPI")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE LostFocusPIPIExec()
        LOCAL loc_oBO, loc_nNovo, loc_nAnterior, loc_nNovoIpi
        loc_oBO       = THIS.this_oBusinessObject
        loc_nAnterior = loc_oBO.this_nAliqIpi
        loc_nNovo     = THIS.ValorNumerico(THIS.txt_4c_PIPI.Value)
        loc_oBO.this_nAliqIpi = loc_nNovo

        IF loc_nNovo <> 0
            loc_nNovoIpi = ROUND(loc_oBO.this_nBcIpi * loc_nNovo / 100, 2)
            loc_oBO.this_nValIpi = loc_nNovoIpi
            THIS.txt_4c_Ipi.Value = loc_nNovoIpi
            THIS.txt_4c_Ipi.Refresh()
        ENDIF

        IF loc_nNovo <> loc_nAnterior
            loc_oBO.this_lManipulou = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LostFocusPicm - transcricao de Get_picm.Valid: Replace AliqIcms
    * (this_nAliqIcms); recalcula o ICMS (BaseIcms*AliqIcms/100) SEMPRE
    * (sem guarda de zero - diferente de pIPI/BICM/BIPI, que so recalculam
    * quando o valor novo eh != 0) e repinta txt_4c_Icms.
    *--------------------------------------------------------------------------
    PROCEDURE LostFocusPicm()
        LOCAL loc_oErro
        TRY
            THIS.LostFocusPicmExec()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "LostFocusPicm")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE LostFocusPicmExec()
        LOCAL loc_oBO, loc_nNovo, loc_nAnterior, loc_nNovoIcms
        loc_oBO       = THIS.this_oBusinessObject
        loc_nAnterior = loc_oBO.this_nAliqIcms
        loc_nNovo     = THIS.ValorNumerico(THIS.txt_4c_Picm.Value)
        loc_oBO.this_nAliqIcms = loc_nNovo

        loc_nNovoIcms = ROUND(loc_oBO.this_nBaseIcms * loc_nNovo / 100, 2)
        loc_oBO.this_nIcms = loc_nNovoIcms
        THIS.txt_4c_Icms.Value = loc_nNovoIcms
        THIS.txt_4c_Icms.Refresh()

        IF loc_nNovo <> loc_nAnterior
            loc_oBO.this_lManipulou = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LostFocusBICM - transcricao de Get_BICM.Valid: Replace BaseIcms
    * (this_nBaseIcms); so quando o valor novo eh != 0 E mudou, recalcula
    * o ICMS (BaseIcms*AliqIcms/100) e repinta txt_4c_Icms.
    *--------------------------------------------------------------------------
    PROCEDURE LostFocusBICM()
        LOCAL loc_oErro
        TRY
            THIS.LostFocusBICMExec()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "LostFocusBICM")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE LostFocusBICMExec()
        LOCAL loc_oBO, loc_nNovo, loc_nAnterior, loc_nNovoIcms
        loc_oBO       = THIS.this_oBusinessObject
        loc_nAnterior = loc_oBO.this_nBaseIcms
        loc_nNovo     = THIS.ValorNumerico(THIS.txt_4c_BICM.Value)
        loc_oBO.this_nBaseIcms = loc_nNovo

        IF loc_nNovo <> 0 AND loc_nNovo <> loc_nAnterior
            loc_nNovoIcms = ROUND(loc_nNovo * loc_oBO.this_nAliqIcms / 100, 2)
            loc_oBO.this_nIcms = loc_nNovoIcms
            THIS.txt_4c_Icms.Value = loc_nNovoIcms
            THIS.txt_4c_Icms.Refresh()
        ENDIF

        IF loc_nNovo <> loc_nAnterior
            loc_oBO.this_lManipulou = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LostFocusIpi / LostFocusBIPI - transcricao de Get_ipi.Valid+LostFocus
    * e Get_BIPI.Valid+LostFocus. Valid e LostFocus do MESMO controle
    * disparam em sequencia ao sair do campo (Valid primeiro); como o
    * projeto nao liga Valid de TextBox (regra de BINDEVENT em TextBox),
    * as duas acoes do legado ficam num unico handler de LostFocus, na
    * MESMA ordem: primeiro o "Replace" (aqui, grava a property do BO),
    * depois o recalculo da tela de movimento.
    *
    * BIPI tem a parte extra do Valid (recalcula ValIpis localmente, com
    * guarda "<> 0 AND <> peantvalue") ANTES do recalculo do pai; Ipi so
    * grava o proprio valor (ValIpis) e dispara o recalculo direto.
    *
    * AplicarAoCursor() antes do recalculo: o legado ja tinha feito o
    * Replace DIRETO no cursor dentro do Valid, entao quando o LostFocus
    * chama CalcImposto o cursor ja reflete o digitado; aqui o valor mora
    * no BO e precisa ser empurrado para o cursor compartilhado antes de
    * pedir o recalculo (regra de arquitetura ja usada em
    * BtnRecalcularClick).
    *--------------------------------------------------------------------------
    PROCEDURE LostFocusIpi()
        LOCAL loc_oErro
        TRY
            THIS.LostFocusIpiExec()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "LostFocusIpi")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE LostFocusIpiExec()
        LOCAL loc_oBO

        loc_oBO = THIS.this_oBusinessObject

        IF THIS.TransferirNumero(THIS.txt_4c_Ipi.Value, "this_nValIpi")
            loc_oBO.this_lManipulou = .T.
        ENDIF

        IF loc_oBO.AplicarAoCursor(loc_oBO.this_cCursorItens)
            THIS.ChamarRecalculoImpostoCampo(loc_oBO.this_nItem)
        ENDIF
    ENDPROC

    PROCEDURE LostFocusBIPI()
        LOCAL loc_oErro
        TRY
            THIS.LostFocusBIPIExec()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "LostFocusBIPI")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE LostFocusBIPIExec()
        LOCAL loc_oBO, loc_nNovo, loc_nAnterior, loc_nNovoIpi

        loc_oBO       = THIS.this_oBusinessObject
        loc_nAnterior = loc_oBO.this_nBcIpi
        loc_nNovo     = THIS.ValorNumerico(THIS.txt_4c_BIPI.Value)
        loc_oBO.this_nBcIpi = loc_nNovo

        IF loc_nNovo <> 0 AND loc_nNovo <> loc_nAnterior
            loc_nNovoIpi = ROUND(loc_nNovo * loc_oBO.this_nAliqIpi / 100, 2)
            loc_oBO.this_nValIpi = loc_nNovoIpi
            THIS.txt_4c_Ipi.Value = loc_nNovoIpi
            THIS.txt_4c_Ipi.Refresh()
        ENDIF

        IF loc_nNovo <> loc_nAnterior
            loc_oBO.this_lManipulou = .T.
        ENDIF

        THIS.AjustarCamposPorContexto()

        IF loc_oBO.AplicarAoCursor(loc_oBO.this_cCursorItens)
            THIS.ChamarRecalculoImpostoCampo(loc_oBO.this_nItem)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LostFocusVBc - transcricao de getVBc.Valid: so recalcula quando o
    * valor novo eh != 0 E mudou (igual ao legado). O recalculo em si fica
    * no BO (AplicarRecalculoBase - regra #17), que tambem sinaliza quais
    * impostos nao puderam ser recalculados por falta de FSigOpFin_imp
    * (ausencia REPORTADA, regra #27). Fecha com THIS.Refresh() (o
    * "thisform.Refresh" do fim do Valid legado).
    *--------------------------------------------------------------------------
    PROCEDURE LostFocusVBc()
        LOCAL loc_oErro
        TRY
            THIS.LostFocusVBcExec()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "LostFocusVBc")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE LostFocusVBcExec()
        LOCAL loc_oBO, loc_nNovo, loc_nAnterior

        loc_oBO       = THIS.this_oBusinessObject
        loc_nAnterior = loc_oBO.this_nValBase
        loc_nNovo     = THIS.ValorNumerico(THIS.txt_4c_VBc.Value)
        loc_oBO.this_nValBase = loc_nNovo

        IF loc_nNovo <> 0 AND loc_nNovo <> loc_nAnterior
            loc_oBO.AplicarRecalculoBase()

            THIS.txt_4c_Vpis.Value  = loc_oBO.this_nVPis
            THIS.txt_4c_Vcof.Value  = loc_oBO.this_nVCofins
            THIS.txt_4c_Vii.Value   = loc_oBO.this_nTaxaIi
            THIS.txt_4c_VIss.Value  = loc_oBO.this_nIss
            THIS.txt_4c_VIrrf.Value = loc_oBO.this_nIrrf
            THIS.txt_4c_VInss.Value = loc_oBO.this_nInss
            THIS.txt_4c_VCssl.Value = loc_oBO.this_nCssl

            THIS.txt_4c_Vpis.Refresh()
            THIS.txt_4c_Vcof.Refresh()
            THIS.txt_4c_Vii.Refresh()
            THIS.txt_4c_VIss.Refresh()
            THIS.txt_4c_VIrrf.Refresh()
            THIS.txt_4c_VInss.Refresh()
            THIS.txt_4c_VCssl.Refresh()

            IF !EMPTY(loc_oBO.this_cAliquotasIndisponiveis)
                MsgAviso("Al" + CHR(237) + "quota de conta n" + CHR(227) + "o dispon" + CHR(237) + "vel " + ;
                         "(FSigOpFin_imp n" + CHR(227) + "o portado) para: " + ;
                         loc_oBO.this_cAliquotasIndisponiveis + "." + CHR(13) + ;
                         "Esses impostos n" + CHR(227) + "o foram recalculados.", "Base de Impostos")
            ENDIF
        ENDIF

        IF loc_nNovo <> loc_nAnterior
            loc_oBO.this_lManipulou = .T.
        ENDIF

        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarCamposPorContexto - FASE 8/8. Reproduz as quatro condicoes
    * DINAMICAS de When do legado (os tres campos de exibicao ja levam
    * .Enabled = .F. ESTATICO desde a criacao - ver ConfigurarCamposImpostos):
    *
    *   Get_ipi  : Return (crTpmMvItn.BcIpis > 0)
    *   getVii   : Return Substr(cfops,1,1) = '3'
    *   getVIrrf/getVInss/getVCssl/getVIss : Return LocalGrp.servicos = 1
    *
    * Chamado sempre que algo que alimenta essas condicoes muda: carga
    * inicial/recalculo completo (BOParaForm), troca de CFOP
    * (AplicarCfopEncontrado) e edicao direta da Base de IPI
    * (LostFocusBIPIExec).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarCamposPorContexto()
        LOCAL loc_oBO
        loc_oBO = THIS.this_oBusinessObject

        THIS.txt_4c_Ipi.Enabled   = (loc_oBO.this_nBcIpi > 0)
        THIS.txt_4c_Vii.Enabled   = (LEFT(ALLTRIM(loc_oBO.this_cCfop), 1) == "3")
        THIS.txt_4c_VIrrf.Enabled = (loc_oBO.this_nServicosGrupo = 1)
        THIS.txt_4c_VInss.Enabled = (loc_oBO.this_nServicosGrupo = 1)
        THIS.txt_4c_VCssl.Enabled = (loc_oBO.this_nServicosGrupo = 1)
        THIS.txt_4c_VIss.Enabled  = (loc_oBO.this_nServicosGrupo = 1)
    ENDPROC

    *--------------------------------------------------------------------------
    * ChamarRecalculoImpostoCampo - despacho guardado para o CalcImposto do
    * AVO (ParentForm.ParentForm - mesma referencia de ChamarRecalculoDoPai),
    * equivalente ao LostFocus de Get_ipi/Get_BIPI:
    *
    *   ThisForm.ParentForm.ParentForm.CalcImposto(.f., crTpmMvItn.Citens, .t.)
    *   Select crTpmMvItn / Locate For cItens = lncItem
    *   ThisForm.Get_BICM.Value = crTpmMvItn.BaseIcms (idem icms/picm) + Refresh
    *
    * NOTA: a assinatura aqui eh DIFERENTE da de ChamarRecalculoDoPai
    * (3 argumentos posicionais - .f., item, .t. - contra 4 com o 3o
    * OMITIDO no Click do botao Recalcular). Sao dois call sites distintos
    * do MESMO metodo do legado, com formas de chamada diferentes - cada
    * um transcrito literalmente do ponto onde aparece (regra #17), sem
    * normalizar os dois para uma forma so.
    *
    * CalcImposto AINDA NAO EXISTE no projeto migrado (mesma ausencia
    * documentada em ChamarRecalculoDoPai) - despacho por PEMSTATUS + TRY,
    * ausencia REPORTADA ao usuario (regra #27).
    *
    * Sem RETURN dentro do TRY (regra #1).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ChamarRecalculoImpostoCampo(par_nItem)
        LOCAL loc_oMovimento, loc_lChamou, loc_oErro, loc_oBO, loc_cAlias

        loc_oMovimento = .NULL.
        loc_lChamou    = .F.

        IF VARTYPE(THIS.this_oParentForm) = "O"
            IF PEMSTATUS(THIS.this_oParentForm, "this_oParentForm", 5)
                IF VARTYPE(THIS.this_oParentForm.this_oParentForm) = "O"
                    loc_oMovimento = THIS.this_oParentForm.this_oParentForm
                ENDIF
            ENDIF
        ENDIF

        IF VARTYPE(loc_oMovimento) = "O"
            TRY
                IF PEMSTATUS(loc_oMovimento, "CalcImposto", 5)
                    loc_oMovimento.CalcImposto(.F., par_nItem, .T.)
                    loc_lChamou = .T.
                ENDIF
            CATCH TO loc_oErro
                loc_lChamou = .F.
                MsgErro(loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                        "Procedure: " + loc_oErro.Procedure, ;
                        "Erro ao recalcular o imposto do campo na tela de movimento")
            ENDTRY
        ENDIF

        IF loc_lChamou
            loc_oBO    = THIS.this_oBusinessObject
            loc_cAlias = loc_oBO.this_cCursorItens

            IF USED(loc_cAlias)
                SELECT (loc_cAlias)
                LOCATE FOR cItens = par_nItem

                IF FOUND()
                    loc_oBO.this_nBaseIcms = TratarNulo(BaseIcms, 0)
                    loc_oBO.this_nIcms     = TratarNulo(Icms, 0)
                    loc_oBO.this_nAliqIcms = TratarNulo(AliqIcms, 0)

                    THIS.txt_4c_BICM.Value = loc_oBO.this_nBaseIcms
                    THIS.txt_4c_Icms.Value = loc_oBO.this_nIcms
                    THIS.txt_4c_Picm.Value = loc_oBO.this_nAliqIcms
                    THIS.txt_4c_BICM.Refresh()
                    THIS.txt_4c_Icms.Refresh()
                    THIS.txt_4c_Picm.Refresh()
                ENDIF
            ENDIF
        ELSE
            MsgAviso("O rec" + CHR(225) + "lculo de impostos pertence " + CHR(224) + ;
                     " tela de movimento (CalcImposto), que ainda n" + CHR(227) + ;
                     "o est" + CHR(225) + " dispon" + CHR(237) + "vel." + CHR(13) + ;
                     "O valor digitado foi gravado no item, mas n" + CHR(227) + ;
                     "o foi recalculado.", "Recalcular")
        ENDIF

        RETURN loc_lChamou
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarLookupsFiscais - cria os quatro campos de lookup do dump:
    * Classificacao Fiscal (txt_4c_ClFiscals/txt_4c_DClFiscals, SigCdClf) e
    * CFOP (txt_4c__ccfop/txt_4c__dcfop, SigCdCFO), e liga os eventos que os
    * implementam POR INTEIRO (ver cabecalho FASE 6/8 para o detalhe das
    * regras de negocio). Propriedades visuais TRANSCRITAS do dump
    * (Courier New, BackColor/DisabledBackColor/DisabledForeColor/
    * BorderColor identicos ao legado - campos "fwget" de exibicao
    * monoespacada).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarLookupsFiscais()
        *-- txt_4c_ClFiscals (getClFiscals) - codigo da Classificacao Fiscal
        THIS.AddObject("txt_4c_ClFiscals", "TextBox")
        WITH THIS.txt_4c_ClFiscals
            .Top               = 154
            .Left              = 349
            .Width             = 80
            .Height            = 23
            .Value             = ""
            .FontName          = "Courier New"
            .BackColor         = RGB(255, 255, 232)
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(192, 192, 192)
            .BorderColor       = RGB(0, 0, 0)
            .TabIndex          = 11
        ENDWITH

        *-- txt_4c_DClFiscals (getDClFiscals) - descricao da Classificacao Fiscal
        THIS.AddObject("txt_4c_DClFiscals", "TextBox")
        WITH THIS.txt_4c_DClFiscals
            .Top               = 154
            .Left              = 431
            .Width             = 192
            .Height            = 23
            .Value             = ""
            .FontName          = "Courier New"
            .BackColor         = RGB(255, 255, 232)
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(192, 192, 192)
            .BorderColor       = RGB(0, 0, 0)
            .TabIndex          = 12
        ENDWITH

        *-- txt_4c__ccfop (get_ccfop) - codigo do CFOP
        THIS.AddObject("txt_4c__ccfop", "TextBox")
        WITH THIS.txt_4c__ccfop
            .Top               = 181
            .Left              = 349
            .Width             = 80
            .Height            = 23
            .Value             = ""
            .FontName          = "Courier New"
            .BackColor         = RGB(255, 255, 232)
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(192, 192, 192)
            .BorderColor       = RGB(0, 0, 0)
            .TabIndex          = 13
        ENDWITH

        *-- txt_4c__dcfop (get_dcfop) - descricao do CFOP
        THIS.AddObject("txt_4c__dcfop", "TextBox")
        WITH THIS.txt_4c__dcfop
            .Top               = 181
            .Left              = 431
            .Width             = 191
            .Height            = 23
            .Value             = ""
            .FontName          = "Courier New"
            .BackColor         = RGB(255, 255, 232)
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(192, 192, 192)
            .BorderColor       = RGB(0, 0, 0)
            .TabIndex          = 14
        ENDWITH

        BINDEVENT(THIS.txt_4c_ClFiscals,  "GotFocus",  THIS, "GotFocusClFiscal")
        BINDEVENT(THIS.txt_4c_DClFiscals, "GotFocus",  THIS, "GotFocusClFiscal")
        BINDEVENT(THIS.txt_4c_ClFiscals,  "LostFocus", THIS, "ValidarClFiscalCodigo")
        BINDEVENT(THIS.txt_4c_DClFiscals, "LostFocus", THIS, "ValidarClFiscalDescricao")

        BINDEVENT(THIS.txt_4c__ccfop, "GotFocus",  THIS, "GotFocusCfop")
        BINDEVENT(THIS.txt_4c__dcfop, "GotFocus",  THIS, "GotFocusCfop")
        BINDEVENT(THIS.txt_4c__ccfop, "LostFocus", THIS, "ValidarCfopCodigo")
        BINDEVENT(THIS.txt_4c__dcfop, "LostFocus", THIS, "ValidarCfopDescricao")
    ENDPROC

    *--------------------------------------------------------------------------
    * GotFocusClFiscal / GotFocusCfop - guardam o codigo ATUALMENTE resolvido
    * no BO (equivalente ao This.Tag = Padr(This.Value, N) do legado - ver
    * nota no cabecalho FASE 6/8 sobre a simplificacao de comparar sempre
    * pelo codigo).
    *--------------------------------------------------------------------------
    PROCEDURE GotFocusClFiscal()
        THIS.this_cClFiscalAnterior = THIS.this_oBusinessObject.this_cClFiscal
    ENDPROC

    PROCEDURE GotFocusCfop()
        THIS.this_cCfopAnterior = THIS.this_oBusinessObject.this_cCfop
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarClFiscalCodigo / ValidarClFiscalDescricao - wrappers PUBLIC
    * ligados por BINDEVENT (regra #3), com guarda de reentrancia (regra
    * #47) e corpo em *Exec() para sobreviver a RETURN antecipado sem travar
    * a flag ligada (regra #47).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarClFiscalCodigo()
        LOCAL loc_oErro

        IF THIS.this_lEmLookupClFiscal
            RETURN
        ENDIF

        THIS.this_lEmLookupClFiscal = .T.
        TRY
            THIS.ValidarClFiscalCodigoExec()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "ValidarClFiscalCodigo")
        ENDTRY
        THIS.this_lEmLookupClFiscal = .F.
    ENDPROC

    PROTECTED PROCEDURE ValidarClFiscalCodigoExec()
        THIS.ResolverClassificacaoFiscal("Codigos", ALLTRIM(THIS.txt_4c_ClFiscals.Value))
    ENDPROC

    PROCEDURE ValidarClFiscalDescricao()
        LOCAL loc_oErro

        IF THIS.this_lEmLookupClFiscal
            RETURN
        ENDIF

        THIS.this_lEmLookupClFiscal = .T.
        TRY
            THIS.ValidarClFiscalDescricaoExec()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "ValidarClFiscalDescricao")
        ENDTRY
        THIS.this_lEmLookupClFiscal = .F.
    ENDPROC

    PROTECTED PROCEDURE ValidarClFiscalDescricaoExec()
        THIS.ResolverClassificacaoFiscal("Descricaos", ALLTRIM(THIS.txt_4c_DClFiscals.Value))
    ENDPROC

    *--------------------------------------------------------------------------
    * ResolverClassificacaoFiscal - tenta o BO.BuscarClassificacaoFiscal()
    * (match exato); achando, aplica direto; nao achando, abre o picker
    * (AbrirLookupClFiscal). Campo vazio limpa os dois campos (equivalente
    * ao Else do legado).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ResolverClassificacaoFiscal(par_cCampoBusca, par_cValor)
        LOCAL loc_oBO
        loc_oBO = THIS.this_oBusinessObject

        IF EMPTY(par_cValor)
            THIS.txt_4c_ClFiscals.Value  = ""
            THIS.txt_4c_DClFiscals.Value = ""
        ELSE
            IF loc_oBO.BuscarClassificacaoFiscal(par_cCampoBusca, par_cValor)
                THIS.AplicarClassificacaoFiscalEncontrada()
            ELSE
                THIS.AbrirLookupClFiscal(par_cCampoBusca, par_cValor)
            ENDIF
        ENDIF

        THIS.txt_4c_ClFiscals.Refresh()
        THIS.txt_4c_DClFiscals.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarClassificacaoFiscalEncontrada - preenche os dois campos a
    * partir do que o BO acabou de resolver (busca exata ou selecao no
    * picker) e, SO quando a classificacao de fato mudou, reproduz os
    * efeitos colaterais do Valid legado (ver cabecalho FASE 6/8).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarClassificacaoFiscalEncontrada()
        LOCAL loc_oBO, loc_nNovaAliq, loc_nNovoIcms
        loc_oBO = THIS.this_oBusinessObject

        THIS.txt_4c_ClFiscals.Value  = loc_oBO.this_cClFiscal
        THIS.txt_4c_DClFiscals.Value = loc_oBO.this_cDescrClFiscal

        IF PADR(THIS.this_cClFiscalAnterior, 10) == PADR(loc_oBO.this_cClFiscal, 10)
            RETURN
        ENDIF

        IF loc_oBO.this_nBIcmsClFiscal <> 0 AND loc_oBO.this_nBIcmsClFiscal <> loc_oBO.this_nAliqIcms
            loc_nNovaAliq = loc_oBO.this_nBIcmsClFiscal
            loc_nNovoIcms = ROUND(loc_oBO.this_nBaseIcms * loc_nNovaAliq / 100, 2)
            loc_oBO.AplicarAliquotaIcmsAoCursor(loc_nNovaAliq, loc_nNovoIcms)

            THIS.txt_4c_Picm.Value = loc_nNovaAliq
            THIS.txt_4c_Icms.Value = loc_nNovoIcms
            THIS.txt_4c_Picm.Refresh()
            THIS.txt_4c_Icms.Refresh()
        ELSE
            IF MsgConfirma("Deseja atualizar a Classifica" + CHR(231) + CHR(227) + "o Fiscal do Produto?", ;
                           "Classifica" + CHR(231) + CHR(227) + "o Fiscal")
                loc_oBO.AtualizarClassificacaoFiscalProduto()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupClFiscal - picker FormBuscaAuxiliar para SigCdClf (regra
    * #37: Show() so quando NAO achou exato; atribuicao so sob
    * this_lSelecionou).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupClFiscal(par_cCampoBusca, par_cValor)
        LOCAL loc_oBusca, loc_oBO, loc_cCursor
        loc_oBO     = THIS.this_oBusinessObject
        loc_cCursor = loc_oBO.this_cCursorClf

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdClf", loc_cCursor, par_cCampoBusca, par_cValor, ;
            "Classifica" + CHR(231) + CHR(227) + "o Fiscal")

        IF VARTYPE(loc_oBusca) = "O"
            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.mAddColuna("BIcms",      "999.99", "ICMS")
                loc_oBusca.Show()
            ENDIF
            IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                SELECT (loc_cCursor)
                loc_oBO.this_cClFiscal      = ALLTRIM(Codigos)
                loc_oBO.this_cDescrClFiscal = ALLTRIM(Descricaos)
                loc_oBO.this_nBIcmsClFiscal = NVL(BIcms, 0)
                THIS.AplicarClassificacaoFiscalEncontrada()
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCfopCodigo / ValidarCfopDescricao - mesmo padrao de wrapper +
    * guarda de reentrancia dos metodos de Classificacao Fiscal acima.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCfopCodigo()
        LOCAL loc_oErro

        IF THIS.this_lEmLookupCfop
            RETURN
        ENDIF

        THIS.this_lEmLookupCfop = .T.
        TRY
            THIS.ValidarCfopCodigoExec()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "ValidarCfopCodigo")
        ENDTRY
        THIS.this_lEmLookupCfop = .F.
    ENDPROC

    PROTECTED PROCEDURE ValidarCfopCodigoExec()
        THIS.ResolverCfop("Codigos", ALLTRIM(THIS.txt_4c__ccfop.Value))
    ENDPROC

    PROCEDURE ValidarCfopDescricao()
        LOCAL loc_oErro

        IF THIS.this_lEmLookupCfop
            RETURN
        ENDIF

        THIS.this_lEmLookupCfop = .T.
        TRY
            THIS.ValidarCfopDescricaoExec()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "ValidarCfopDescricao")
        ENDTRY
        THIS.this_lEmLookupCfop = .F.
    ENDPROC

    PROTECTED PROCEDURE ValidarCfopDescricaoExec()
        THIS.ResolverCfop("Descricaos", ALLTRIM(THIS.txt_4c__dcfop.Value))
    ENDPROC

    *--------------------------------------------------------------------------
    * ResolverCfop - mesmo esquema de ResolverClassificacaoFiscal, para
    * SigCdCFO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ResolverCfop(par_cCampoBusca, par_cValor)
        LOCAL loc_oBO
        loc_oBO = THIS.this_oBusinessObject

        IF EMPTY(par_cValor)
            THIS.txt_4c__ccfop.Value = ""
            THIS.txt_4c__dcfop.Value = ""
        ELSE
            IF loc_oBO.BuscarCfop(par_cCampoBusca, par_cValor)
                THIS.AplicarCfopEncontrado()
            ELSE
                THIS.AbrirLookupCfop(par_cCampoBusca, par_cValor)
            ENDIF
        ENDIF

        THIS.txt_4c__ccfop.Refresh()
        THIS.txt_4c__dcfop.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarCfopEncontrado - preenche os dois campos e, SO quando o CFOP de
    * fato mudou, pede ao BO para rearmar base/aliquota de IPI e ICMS (ver
    * cabecalho FASE 6/8) e repinta os campos afetados.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarCfopEncontrado()
        LOCAL loc_oBO
        loc_oBO = THIS.this_oBusinessObject

        THIS.txt_4c__ccfop.Value = loc_oBO.this_cCfop
        THIS.txt_4c__dcfop.Value = loc_oBO.this_cDescrCfop

        IF PADR(THIS.this_cCfopAnterior, 10) == PADR(loc_oBO.this_cCfop, 10)
            RETURN
        ENDIF

        IF loc_oBO.AplicarCfopSelecionado()
            THIS.txt_4c_BIPI.Value = loc_oBO.this_nBcIpi
            THIS.txt_4c_BICM.Value = loc_oBO.this_nBaseIcms
            THIS.txt_4c_PIPI.Value = loc_oBO.this_nAliqIpi
            THIS.txt_4c_Ipi.Value  = loc_oBO.this_nValIpi
            THIS.txt_4c_Picm.Value = loc_oBO.this_nAliqIcms
            THIS.txt_4c_Icms.Value = loc_oBO.this_nIcms

            THIS.txt_4c_BIPI.Refresh()
            THIS.txt_4c_BICM.Refresh()
            THIS.txt_4c_PIPI.Refresh()
            THIS.txt_4c_Ipi.Refresh()
            THIS.txt_4c_Picm.Refresh()
            THIS.txt_4c_Icms.Refresh()
        ENDIF

        *-- O CFOP novo pode mudar a base de IPI (BcIpis) e o proprio CFOP
        *-- decide a condicao de getVii - reavaliar as condicoes dinamicas
        *-- de When (FASE 8/8).
        THIS.AjustarCamposPorContexto()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupCfop - picker FormBuscaAuxiliar para SigCdCFO (mesmo
    * padrao de AbrirLookupClFiscal).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupCfop(par_cCampoBusca, par_cValor)
        LOCAL loc_oBusca, loc_oBO, loc_cCursor
        loc_oBO     = THIS.this_oBusinessObject
        loc_cCursor = loc_oBO.this_cCursorCfo

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCFO", loc_cCursor, par_cCampoBusca, par_cValor, "CFOP")

        IF VARTYPE(loc_oBusca) = "O"
            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
            ENDIF
            IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                SELECT (loc_cCursor)
                loc_oBO.this_cCfop           = ALLTRIM(Codigos)
                loc_oBO.this_cDescrCfop      = ALLTRIM(Descricaos)
                loc_oBO.this_nAliqIpiCfop    = NVL(aliqipis, 0)
                loc_oBO.this_nAliqIcmsCfop   = NVL(aliqivcs, 0)
                loc_oBO.this_cTribIpiCfop    = NVL(ipis, "")
                loc_oBO.this_cTribIcmsCfop   = NVL(icms, "")
                loc_oBO.this_nAliqPisCfop    = NVL(aliqpis, 0)
                loc_oBO.this_nAliqCofinsCfop = NVL(aliqcofins, 0)
                loc_oBO.this_nAliqIiCfop     = NVL(aliqii, 0)
                loc_oBO.this_nAliqIssqnCfop  = NVL(aliqissqn, 0)
                THIS.AplicarCfopEncontrado()
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - cria obj_4c_CntBotoes (CommandGroup "cntBotoes" do
    * legado, ButtonCount = 2) com os DOIS botoes de acao deste dialogo.
    * Propriedades TRANSCRITAS de SigOpImp_form_codigo_fonte.txt
    * (* PROPRIEDADES DE: SIGOPIMP.cntBotoes).
    *
    *   Buttons(1) = "\<Recalcular" (legado btnConfirmar) -> BtnRecalcularClick
    *   Buttons(2) = "\<Voltar"     (legado btnSair)      -> BtnConfirmarClick
    *
    * O grupo eh o ULTIMO AddObject da montagem visual de proposito: ele fica
    * em Top = -2 / Left = 643, DENTRO da area de cnt_4c_Sombra (Top 0..80,
    * Width = 800), e so desenha por cima da faixa do cabecalho se criado
    * DEPOIS dela (regra #11). No SCX o cntBotoes tambem vem depois do
    * cntSombra na ordem de registro.
    *
    * Geometria dos botoes aplicada ANTES da do grupo: o grupo eh
    * AutoSize = .T. e eh o botao INTERNO que define a altura/largura dele
    * (regra #31) - com 75x75 em (5,5) e (80,5) o AutoSize chega exatamente
    * aos 160x85 que o dump declara no grupo.
    *
    * Picture TRANSCRITA do legado, nao escolhida por semelhanca (regra #25):
    * Recalcular usa geral_processar_60.jpg e Voltar usa cadastro_salvar_60.jpg
    * - os dois arquivos existem em vbmp\. CommandGroup NAO tem ForeColor
    * (regra #33): a cor fica nos membros.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_oCmg, loc_oErro

        TRY
            THIS.AddObject("obj_4c_CntBotoes", "CommandGroup")
            loc_oCmg = THIS.obj_4c_CntBotoes
            loc_oCmg.ButtonCount = 2

            *-- Buttons(1) - legado Command1 (Name = "btnConfirmar")
            WITH loc_oCmg.Buttons(1)
                .AutoSize        = .F.
                .Top             = 5
                .Left            = 5
                .Height          = 75
                .Width           = 75
                .Caption         = "\<Recalcular"
                .ToolTipText     = "Recalcular os  Impostos"
                .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .WordWrap        = .T.
                .MousePointer    = 15
                .SpecialEffect   = 0
                .PicturePosition = 13
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .TabIndex        = 1
            ENDWITH

            *-- Buttons(2) - legado Command2 (Name = "btnSair", Cancel = .T.)
            WITH loc_oCmg.Buttons(2)
                .Top           = 5
                .Left          = 80
                .Height        = 75
                .Width         = 75
                .Caption       = "\<Voltar"
                .ToolTipText   = "[Esc] Retornar Para Tela Anterior"
                .Picture       = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .Cancel        = .T.
                .FontBold      = .T.
                .FontItalic    = .T.
                .FontName      = "Comic Sans MS"
                .FontSize      = 8
                .WordWrap      = .T.
                .MousePointer  = 15
                .SpecialEffect = 0
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .F.
                .TabIndex      = 4
            ENDWITH

            WITH loc_oCmg
                .AutoSize      = .T.
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 1
                .Top           = -2
                .Left          = 643
                .Width         = 160
                .Height        = 85
                .Value         = 0
                .Themes        = .F.
                .TabIndex      = 23
            ENDWITH

            *-- BINDEVENT exige metodo PUBLIC (regra #3) - os dois handlers
            *-- abaixo nao levam PROTECTED.
            BINDEVENT(loc_oCmg.Buttons(1), "Click", THIS, "BtnRecalcularClick")
            BINDEVENT(loc_oCmg.Buttons(2), "Click", THIS, "BtnConfirmarClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSigOpImp.ConfigurarBotoes")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDadosDoItem - leitura INICIAL do dialogo, equivalente ao bloco
    * "With ThisForm / .get_Produto.Value = crTpmMvItn.Cpros / ..." do Init
    * legado mais as TRES consultas de contexto que vem logo depois:
    *
    *   1) Classificacao Fiscal do produto (SigCdPro x SigCdClf)
    *   3) Grupo do produto / flag de servico (SigCdPro x SigCdGrp)
    *      -> as duas em BO.CarregarContextoDoProduto()
    *   2) Descricao e aliquotas do CFOP gravado no item
    *      -> BO.BuscarCfop(), que ja seleciona as mesmas colunas
    *
    * No legado isso mora no Init; aqui fica em metodo proprio porque o
    * BtnRecalcularClick precisa reler o MESMO item depois do recalculo feito
    * pela tela de movimento (o legado repete os 11 assignments no Click).
    *
    * A consulta 2 nao eh disparada com CFOP vazio: o legado montaria
    * "Where a.codigos = ''" e voltaria lista vazia, sem efeito nenhum.
    *
    * Sem RETURN dentro do TRY (regra #1).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDadosDoItem()
        LOCAL loc_oBO, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_oBO = THIS.this_oBusinessObject

            IF !loc_oBO.CarregarDoCursor(loc_oBO.this_cCursorItens)
                MsgErro(loc_oBO.this_cMensagemErro, ;
                        "Erro em FormSigOpImp.CarregarDadosDoItem")
            ELSE
                IF loc_oBO.CarregarContextoDoProduto()
                    IF !EMPTY(loc_oBO.this_cCfop)
                        loc_oBO.BuscarCfop("Codigos", loc_oBO.this_cCfop)
                    ENDIF

                    THIS.BOParaForm()
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSigOpImp.CarregarDadosDoItem")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - espelha as propriedades do BO nos 23 campos da tela, na
    * MESMA correspondencia do Init/btnConfirmar.Click legado (o legado
    * reescreve 11 campos no Click e 19 + 2 pares de lookup no Init; aqui o
    * metodo eh unico e cobre todos, porque todos acabaram de ser lidos do
    * cursor e portanto carregam o mesmo valor que o legado leria).
    *
    * Fecha com THIS.Refresh(), que eh o ".Refresh" do EndWith legado.
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        LOCAL loc_oBO
        loc_oBO = THIS.this_oBusinessObject

        *-- Campos de exibicao (o When do legado devolve .F. nos tres)
        THIS.txt_4c_Produto.Value = loc_oBO.this_cProduto
        THIS.txt_4c_Total.Value   = loc_oBO.this_nTotal
        THIS.txt_4c_Descr.Value   = loc_oBO.this_cDescricaoProduto

        *-- IPI / ICMS / ICMS Substituicao
        THIS.txt_4c_PIPI.Value  = loc_oBO.this_nAliqIpi
        THIS.txt_4c_Ipi.Value   = loc_oBO.this_nValIpi
        THIS.txt_4c_BIPI.Value  = loc_oBO.this_nBcIpi
        THIS.txt_4c_Picm.Value  = loc_oBO.this_nAliqIcms
        THIS.txt_4c_Icms.Value  = loc_oBO.this_nIcms
        THIS.txt_4c_BICM.Value  = loc_oBO.this_nBaseIcms
        THIS.txt_4c_Icmss.Value = loc_oBO.this_nIcmsSubst
        THIS.txt_4c_BICMS.Value = loc_oBO.this_nBcIcmsSubst

        *-- Base dos demais impostos + PIS/COFINS/II/ISS/IRRF/INSS/CSSL
        THIS.txt_4c_VBc.Value   = loc_oBO.this_nValBase
        THIS.txt_4c_Vpis.Value  = loc_oBO.this_nVPis
        THIS.txt_4c_Vcof.Value  = loc_oBO.this_nVCofins
        THIS.txt_4c_Vii.Value   = loc_oBO.this_nTaxaIi
        THIS.txt_4c_VIss.Value  = loc_oBO.this_nIss
        THIS.txt_4c_VIrrf.Value = loc_oBO.this_nIrrf
        THIS.txt_4c_VInss.Value = loc_oBO.this_nInss
        THIS.txt_4c_VCssl.Value = loc_oBO.this_nCssl

        *-- Lookups fiscais (criados na Fase 6)
        THIS.txt_4c_ClFiscals.Value  = loc_oBO.this_cClFiscal
        THIS.txt_4c_DClFiscals.Value = loc_oBO.this_cDescrClFiscal
        THIS.txt_4c__ccfop.Value     = loc_oBO.this_cCfop
        THIS.txt_4c__dcfop.Value     = loc_oBO.this_cDescrCfop

        *-- Os "Tag" dos lookups passam a refletir o que esta na tela, senao
        *-- o proximo LostFocus trataria o valor recem-carregado como MUDANCA
        *-- e disparava os efeitos colaterais da Fase 6.
        THIS.this_cClFiscalAnterior = loc_oBO.this_cClFiscal
        THIS.this_cCfopAnterior     = loc_oBO.this_cCfop

        *-- Condicoes dinamicas de When (regra #33/CLAUDE.md - fica por
        *-- ultimo, com os valores ja na tela - FASE 8/8)
        THIS.AjustarCamposPorContexto()

        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - leva os campos EDITAVEIS da tela para as propriedades do
    * BO e, no caminho, liga this_lManipulou quando algum deles mudou.
    *
    * No legado cada campo editavel tem o proprio Valid, e os Valid sao
    * sempre as MESMAS duas coisas:
    *
    *   Replace <coluna> With This.Value in crTpmMvItn
    *   If This.Value <> This.peantvalue
    *       ThisForm.maniPulou = .t.
    *   Endif
    *
    * Esses Valid individuais sao eventos AUXILIARES (Fase 8). Enquanto nao
    * existem, este metodo eh o que garante que o digitado chegue ao BO - sem
    * ele o Confirmar gravaria os valores ANTIGOS e o usuario nao veria erro
    * nenhum. A gravacao no cursor segue centralizada em BO.AplicarAoCursor
    * (chamado por BO.Atualizar), que faz o mesmo REPLACE num ponto unico.
    *
    * Produto / Total / Descricao NAO entram: o When do legado devolve .F.
    * nos tres (campos de exibicao), entao nunca sao digitados.
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        LOCAL loc_lMudou

        loc_lMudou = .F.

        loc_lMudou = THIS.TransferirNumero(THIS.txt_4c_PIPI.Value,  "this_nAliqIpi")     OR loc_lMudou
        loc_lMudou = THIS.TransferirNumero(THIS.txt_4c_Ipi.Value,   "this_nValIpi")      OR loc_lMudou
        loc_lMudou = THIS.TransferirNumero(THIS.txt_4c_BIPI.Value,  "this_nBcIpi")       OR loc_lMudou
        loc_lMudou = THIS.TransferirNumero(THIS.txt_4c_Picm.Value,  "this_nAliqIcms")    OR loc_lMudou
        loc_lMudou = THIS.TransferirNumero(THIS.txt_4c_Icms.Value,  "this_nIcms")        OR loc_lMudou
        loc_lMudou = THIS.TransferirNumero(THIS.txt_4c_BICM.Value,  "this_nBaseIcms")    OR loc_lMudou
        loc_lMudou = THIS.TransferirNumero(THIS.txt_4c_Icmss.Value, "this_nIcmsSubst")   OR loc_lMudou
        loc_lMudou = THIS.TransferirNumero(THIS.txt_4c_BICMS.Value, "this_nBcIcmsSubst") OR loc_lMudou

        loc_lMudou = THIS.TransferirNumero(THIS.txt_4c_VBc.Value,   "this_nValBase")     OR loc_lMudou
        loc_lMudou = THIS.TransferirNumero(THIS.txt_4c_Vpis.Value,  "this_nVPis")        OR loc_lMudou
        loc_lMudou = THIS.TransferirNumero(THIS.txt_4c_Vcof.Value,  "this_nVCofins")     OR loc_lMudou
        loc_lMudou = THIS.TransferirNumero(THIS.txt_4c_Vii.Value,   "this_nTaxaIi")      OR loc_lMudou
        loc_lMudou = THIS.TransferirNumero(THIS.txt_4c_VIss.Value,  "this_nIss")         OR loc_lMudou
        loc_lMudou = THIS.TransferirNumero(THIS.txt_4c_VIrrf.Value, "this_nIrrf")        OR loc_lMudou
        loc_lMudou = THIS.TransferirNumero(THIS.txt_4c_VInss.Value, "this_nInss")        OR loc_lMudou
        loc_lMudou = THIS.TransferirNumero(THIS.txt_4c_VCssl.Value, "this_nCssl")        OR loc_lMudou

        IF loc_lMudou
            THIS.this_oBusinessObject.this_lManipulou = .T.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * TransferirNumero - grava UM valor de tela numa property NUMERICA do BO
    * e devolve .T. quando o valor MUDOU (equivalente ao
    * "If This.Value <> This.peantvalue" de cada Valid legado).
    *
    * O nome da property chega por string e eh resolvido com EVALUATE na
    * LEITURA e STORE ... TO (...) na ATRIBUICAO - EVALUATE com o "=" dentro
    * da string NAO atribui: avalia como comparacao e descarta (regra #15).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION TransferirNumero(par_uValorTela, par_cProp)
        LOCAL loc_oBO, loc_nNovo, loc_nAtual, loc_cCaminho

        loc_oBO      = THIS.this_oBusinessObject
        loc_cCaminho = "loc_oBO." + par_cProp
        loc_nNovo    = THIS.ValorNumerico(par_uValorTela)
        loc_nAtual   = THIS.ValorNumerico(EVALUATE(loc_cCaminho))

        STORE loc_nNovo TO (loc_cCaminho)

        RETURN (loc_nNovo <> loc_nAtual)
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValorNumerico - devolve SEMPRE um numero a partir do .Value de um campo
    * de imposto. Os campos nascem numericos (.Value = 0), mas um TextBox com
    * InputMask pode devolver Caractere depois de passar por digitacao; nesse
    * caso a property this_n* do BO ficaria de tipo "C", o REPLACE no cursor
    * estoura e o BOParaForm seguinte devolveria o campo VAZIO.
    *
    * CHRTRAN tira o separador de milhar do InputMask ("99,999,999.99"), que
    * faria o VAL() parar no primeiro grupo.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValorNumerico(par_uValor)
        LOCAL loc_nValor, loc_cTipo

        loc_nValor = 0
        loc_cTipo  = VARTYPE(par_uValor)

        DO CASE
            CASE loc_cTipo = "N"
                loc_nValor = par_uValor
            CASE loc_cTipo = "C"
                loc_nValor = VAL(CHRTRAN(ALLTRIM(par_uValor), ",", ""))
        ENDCASE

        RETURN loc_nValor
    ENDFUNC

    *--------------------------------------------------------------------------
    * BtnRecalcularClick - botao "\<Recalcular" (legado cntBotoes.btnConfirmar,
    * ToolTip "Recalcular os  Impostos"). Transcricao do Click legado:
    *
    *   Local xcItem
    *   xcItem = crTpmMvItn.cItens
    *   Replace AltImpost With .T. in crTpmMvItn
    *   ThisForm.ParentForm.ParentForm.Atuatot()
    *   Thisform.ParentForm.Parentform.CalcImposto(.f.,xcItem,,.t.)
    *   Select crTpmMvItn
    *   Locate For cItens = xcItem
    *   With ThisForm / <11 campos relidos> / .Refresh / EndWith
    *
    * Duas diferencas, ambas obrigatorias e nenhuma delas de FORMULA:
    *
    * 1. FormParaBO + BO.AplicarAoCursor() rodam ANTES do recalculo. No legado
    *    o Valid de cada campo ja tinha feito o "Replace <coluna> With
    *    This.Value" assim que o usuario saiu dele, e esses Valid sao eventos
    *    auxiliares (Fase 8). Sem este passo o recalculo da tela de movimento
    *    trabalharia sobre os valores ANTIGOS. AplicarAoCursor eh tambem quem
    *    grava AltImpost = .T., que eh a primeira linha do Click legado.
    *
    *    AplicarAoCursor direto, e NAO BO.Atualizar(): o Atualizar() tambem
    *    registra auditoria, e o legado registra o log UMA vez so, no Click de
    *    Confirmar/Voltar - Recalcular pode ser acionado varias vezes seguidas
    *    e geraria uma linha de auditoria por clique.
    *
    * 2. O reposicionamento ("Select / Locate For cItens") vem antes de reler,
    *    porque o recalculo mexe no ponteiro do cursor do pai - exatamente a
    *    razao pela qual o legado tambem o faz.
    *
    * this_lManipulou eh PRESERVADO em volta da releitura: CarregarDoCursor
    * zera essa flag, e o legado NAO a zera ao recalcular (quem alterou
    * imposto a mao continua tendo alterado, e eh isso que decide o aviso do
    * Confirmar e o log MANIMPOSTO).
    *
    * Sem RETURN dentro do TRY (regra #1).
    *--------------------------------------------------------------------------
    PROCEDURE BtnRecalcularClick()
        LOCAL loc_oBO, loc_nItem, loc_lManipulou, loc_cAlias, loc_oErro

        TRY
            loc_oBO = THIS.this_oBusinessObject

            THIS.FormParaBO()

            IF !loc_oBO.AplicarAoCursor(loc_oBO.this_cCursorItens)
                IF !EMPTY(loc_oBO.this_cMensagemErro)
                    MsgErro(loc_oBO.this_cMensagemErro, "Recalcular")
                ENDIF
            ELSE
                loc_nItem      = loc_oBO.this_nItem
                loc_cAlias     = loc_oBO.this_cCursorItens
                loc_lManipulou = loc_oBO.this_lManipulou

                THIS.ChamarRecalculoDoPai(loc_nItem)

                IF USED(loc_cAlias)
                    SELECT (loc_cAlias)
                    LOCATE FOR cItens = loc_nItem

                    IF FOUND()
                        loc_oBO.CarregarDoCursor(loc_cAlias)
                        loc_oBO.this_lManipulou = loc_lManipulou
                        THIS.BOParaForm()
                    ELSE
                        MsgAviso("Item " + TRANSFORM(loc_nItem) + " n" + CHR(227) + ;
                                 "o foi encontrado no cursor de itens ap" + CHR(243) + ;
                                 "s o rec" + CHR(225) + "lculo.", "Recalcular")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSigOpImp.BtnRecalcularClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConfirmarClick - botao "\<Voltar" (legado cntBotoes.btnSair,
    * Cancel = .T., ToolTip "[Esc] Retornar Para Tela Anterior").
    *
    * O handler leva o nome da ACAO, nao o do objeto legado: apesar do Caption
    * "Voltar", este Click eh o caminho de CONFIRMACAO do dialogo - ele
    * valida, grava AltImpost no cursor do pai, registra o log MANIMPOSTO e so
    * entao fecha. Transcricao do Click legado:
    *
    *   With ThisForm
    *       If ( (Empty(.Get_BIPI.Value)  And Not Empty(.Get_Ipi.Value)  ) Or ;
    *            (Empty(.Get_BIcm.Value)  And Not Empty(.Get_Icms.Value) ) Or ;
    *            (Empty(.Get_BIcms.Value) And Not Empty(.Get_Icmss.Value)) ) And ThisForm.Manipulou
    *           If MessageBox('Confirma alteracao de imposto, zerando a base e mantendo o imposto?',4+256,'') = 7
    *               Return .f.
    *           Endif
    *       Endif
    *   EndWith
    *   Replace crTpmMvItn.AltImpost With .t. in crTpmMvItn
    *   ThisForm.ParentForm.Enabled = .t.
    *   If ThisForm.maniPulou
    *       lcTransacao = TprMvCab.Emps + TprMvCab.Dopes + Str(TprMvCab.Numes,6)
    *       =fGravarLog('T', TprMvCab.Dopes, 'MANIMPOSTO', lcTransacao, Usuar)
    *   Endif
    *   ThisForm.Release
    *
    * Notas de transcricao:
    *   - "MessageBox(...,4+256,'') = 7" eh Sim/Nao com Nao por default, e 7 eh
    *     Nao: recusar ABORTA o fechamento. MsgConfirma devolve LOGICO
    *     (regra #7), entao o teste eh "IF !MsgConfirma(...)".
    *   - A condicao exige this_lManipulou - base zerada com imposto
    *     preenchido so eh questionada quando o usuario de fato mexeu em
    *     algo. Quem liga a flag eh o FormParaBO (ver comentario la).
    *   - EMPTY sobre o valor NORMALIZADO (ValorNumerico): EMPTY("0,00") eh
    *     .F. e inverteria a condicao se o TextBox devolvesse Caractere.
    *   - AltImpost eh gravado por BO.AplicarAoCursor, dentro de
    *     BO.Atualizar(), que tambem registra a auditoria do sistema novo
    *     quando houve alteracao. O fGravarLog do legado eh chamado em
    *     seguida, com os mesmos cinco argumentos (o wrapper
    *     utils\fgravarlog.prg eh um no-op documentado, mantido para
    *     fidelidade de fluxo).
    *   - A chave do log eh POSICIONAL (regra #42): emps char(3) + dopes
    *     char(20) + Str(numes, 6) = 29 caracteres. PADR explicito nas
    *     partes - ALLTRIM nelas encurtaria a chave em silencio.
    *
    * Sem RETURN dentro do TRY (regra #1): loc_lProsseguir carrega a recusa do
    * usuario e o fechamento fica num IF depois do ENDTRY.
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_oBO, loc_lProsseguir, loc_lBaseZerada, loc_oErro
        LOCAL loc_cCabecalho, loc_cOperacao, loc_cTransacao

        loc_lProsseguir = .F.

        TRY
            loc_oBO = THIS.this_oBusinessObject

            THIS.FormParaBO()

            loc_lBaseZerada = ;
                (EMPTY(THIS.ValorNumerico(THIS.txt_4c_BIPI.Value))  AND !EMPTY(THIS.ValorNumerico(THIS.txt_4c_Ipi.Value)))   OR ;
                (EMPTY(THIS.ValorNumerico(THIS.txt_4c_BICM.Value))  AND !EMPTY(THIS.ValorNumerico(THIS.txt_4c_Icms.Value)))  OR ;
                (EMPTY(THIS.ValorNumerico(THIS.txt_4c_BICMS.Value)) AND !EMPTY(THIS.ValorNumerico(THIS.txt_4c_Icmss.Value)))

            loc_lProsseguir = .T.

            IF loc_lBaseZerada AND loc_oBO.this_lManipulou
                IF !MsgConfirma("Confirma altera" + CHR(231) + CHR(227) + "o de imposto, " + ;
                                "zerando a base e mantendo o imposto?", ;
                                "Manuten" + CHR(231) + CHR(227) + "o de Impostos")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF !loc_oBO.Atualizar()
                    IF !EMPTY(loc_oBO.this_cMensagemErro)
                        MsgErro(loc_oBO.this_cMensagemErro, ;
                                "Manuten" + CHR(231) + CHR(227) + "o de Impostos")
                    ENDIF
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF VARTYPE(THIS.this_oParentForm) = "O"
                    THIS.this_oParentForm.Enabled = .T.
                ENDIF

                IF loc_oBO.this_lManipulou
                    loc_cCabecalho = loc_oBO.this_cCursorCabecalho
                    loc_cOperacao  = ""
                    loc_cTransacao = ""

                    IF USED(loc_cCabecalho)
                        SELECT (loc_cCabecalho)
                        loc_cOperacao  = TratarNulo(Dopes, "")
                        loc_cTransacao = PADR(TratarNulo(Emps, ""), 3) + ;
                                         PADR(TratarNulo(Dopes, ""), 20) + ;
                                         STR(TratarNulo(Numes, 0), 6)
                    ENDIF

                    fGravarLog("T", loc_cOperacao, "MANIMPOSTO", ;
                               loc_cTransacao, loc_oBO.this_cUsuario)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_lProsseguir = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSigOpImp.BtnConfirmarClick")
        ENDTRY

        IF loc_lProsseguir
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ChamarRecalculoDoPai - dispara o recalculo que pertence a tela de
    * MOVIMENTO, equivalente as duas linhas do Click legado:
    *
    *   ThisForm.ParentForm.ParentForm.Atuatot()
    *   Thisform.ParentForm.Parentform.CalcImposto(.f., xcItem, , .t.)
    *
    * Note o ParentForm DUPLO: quem tem esses metodos nao eh o form que abriu
    * este dialogo, eh o AVO - a tela de movimento. Na arquitetura nova a
    * referencia do pai mora em this_oParentForm (convencao do projeto, ver
    * Formsigmvitn), entao o avo eh this_oParentForm.this_oParentForm.
    *
    * Atuatot e CalcImposto AINDA NAO EXISTEM no projeto migrado (medido em
    * 2026-11-07: nenhum .prg os define) - sao metodos da tela de movimento,
    * que ainda nao foi migrada. Por isso a chamada eh por despacho guardado
    * (PEMSTATUS + TRY) e a AUSENCIA eh REPORTADA ao usuario em vez de
    * silenciosa: reimplementar CalcImposto aqui seria reescrever formula de
    * imposto por conta propria, que a regra #17 proibe, e um stub que
    * devolvesse "recalculado" sem recalcular gravaria numero errado sem
    * ninguem perceber (regra #27). Quando a tela de movimento for migrada com
    * esses dois metodos PUBLIC, este caminho passa a funcionar sozinho, sem
    * alterar este arquivo.
    *
    * CalcImposto leva o 3o argumento OMITIDO, como no legado - "f(a, b, , d)"
    * eh forma valida em VFP9 (a mesma de "MESSAGEBOX(cTexto, , cTitulo)").
    *
    * Sem RETURN dentro do TRY (regra #1).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ChamarRecalculoDoPai(par_nItem)
        LOCAL loc_oMovimento, loc_lChamou, loc_oErro

        loc_oMovimento = .NULL.
        loc_lChamou    = .F.

        IF VARTYPE(THIS.this_oParentForm) = "O"
            IF PEMSTATUS(THIS.this_oParentForm, "this_oParentForm", 5)
                IF VARTYPE(THIS.this_oParentForm.this_oParentForm) = "O"
                    loc_oMovimento = THIS.this_oParentForm.this_oParentForm
                ENDIF
            ENDIF
        ENDIF

        IF VARTYPE(loc_oMovimento) = "O"
            TRY
                IF PEMSTATUS(loc_oMovimento, "Atuatot", 5)
                    loc_oMovimento.Atuatot()
                ENDIF

                IF PEMSTATUS(loc_oMovimento, "CalcImposto", 5)
                    loc_oMovimento.CalcImposto(.F., par_nItem, , .T.)
                    loc_lChamou = .T.
                ENDIF
            CATCH TO loc_oErro
                loc_lChamou = .F.
                MsgErro(loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                        "Procedure: " + loc_oErro.Procedure, ;
                        "Erro ao recalcular os impostos na tela de movimento")
            ENDTRY
        ENDIF

        IF !loc_lChamou
            MsgAviso("O rec" + CHR(225) + "lculo de impostos pertence " + CHR(224) + ;
                     " tela de movimento (Atuatot / CalcImposto), que ainda n" + CHR(227) + ;
                     "o est" + CHR(225) + " dispon" + CHR(237) + "vel." + CHR(13) + ;
                     "Os valores digitados foram gravados no item, mas n" + CHR(227) + ;
                     "o foram recalculados.", "Recalcular")
        ENDIF

        RETURN loc_lChamou
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - torna todos os controles visiveis recursivamente
    * FILTRO: nenhum container flutuante neste form (layout.json nao declara
    * nenhum Visible = .F. em container)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - libera recursos e REABILITA o form pai incondicionalmente,
    * qualquer que tenha sido o caminho de saida deste dialogo. O legado so
    * reabilita (ThisForm.ParentForm.Enabled = .t.) dentro do Click do botao
    * Confirmar (Fase 7); sem esta rede de seguranca aqui, fechar o dialogo
    * por outro caminho (ESC/botao de sistema) deixaria o form pai desabilitado
    * para sempre.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oParentForm) = "O"
            THIS.this_oParentForm.Enabled = .T.
        ENDIF
        THIS.this_oParentForm = .NULL.

        DODEFAULT()
    ENDPROC

ENDDEFINE
