*==============================================================================
* FormSigOpFpg.prg
*
* Dialogo OPERACIONAL de "Forma de Pagamento" (SIGOPFPG do legado). Chamado
* por formularios de movimento (ex.: Fluxo de Caixa / Baixa de Titulos) para
* distribuir o valor de um titulo/cheque em uma ou mais formas de pagamento
* (dinheiro, cartao, carne, cheque, outros).
*
* Form OPERACIONAL - layout CUSTOMIZADO (flat, SEM PageFrame): o SCX legado
* (SIGOPFPG) nao tem Page1/Page2 - e um dialogo unico com grade de parcelas e
* paineis flutuantes, alternados por Visible conforme a forma de pagamento
* escolhida (CLAUDE.md: forms OPERACIONAIS nao seguem o padrao Lista/Dados
* do CRUD).
*
* Legado: o Init do SCX (Lparameters pForm, DatSes, llAltDireta) faz
* `Set DataSession To DatSes` - este dialogo RODA NA MESMA DATASESSION do
* form pai, para acessar os cursores compartilhados (xPar com as linhas da
* grade de formas de pagamento, CrSigOpFp, CrSigChLcq). Alem disso guarda
* ParentForm/Op_Escolha e desabilita o form pai (`pForm.Enabled = .F.`) -
* por isso NAO declara WindowType=1 (nao e modal nativo do VFP: um form
* modal ja desabilita toda a aplicacao sozinho, tornando o Enabled manual
* redundante). O `Return` do legado reabilita o pai e libera o dialogo.
*
* FASE 3/8: estrutura base - DEFINE CLASS, propriedades que espelham o
* contexto recebido do form pai e o estado do painel (Leitor/Digpar/CotUsu),
* Init(par_oFormPai, par_nDataSessionPai, par_lAltDireta) equivalente a
* Lparameters pForm, DatSes, llAltDireta, InicializarForm() (cria o BO,
* espelha Op_Escolha/AltDireta nele, desabilita o form pai) e os elementos
* puramente decorativos do layout (faixa do cabecalho cnt_4c_Sombra e os dois
* elementos graficos soltos do form - shp_4c_Shape1/lin_4c_Line1).
*
* FASE 4/8: Grade de formas de pagamento (grd_4c_Dados, equivalente
* a Grade/xPar do legado - cursor local cursor_4c_Dados com as 5 colunas
* usadas pelo grid: FPags/Valos/Vencs/MoeFpgs/CotFpgs) e os botoes Apaga/Ok/
* Cancela (cmd_4c_Apaga/cmd_4c_Ok/cmd_4c_Cancela), adicionados ao form DEPOIS
* da faixa do cabecalho para desenhar por cima dela (regra #11 - os botoes
* ficam em Top=3, dentro da faixa de Top=0..80). Os demais campos de xPar
* (bancos/agencias/contas/numeros/cartaos/nocreditos/ncarnes/outros/obs), que
* so os paineis flutuantes da Fase 6 usam, entram quando essa fase ampliar a
* mesma CREATE CURSOR (nao criar um segundo cursor_4c_Dados em outro lugar -
* regra de forms OPERACIONAIS: mesmo cursor, mesma ordem de campos sempre).
*
* Junto com a grade vem o FUNIL de carga/repintura - CarregarDados() - que
* transcreve o que o Init legado faz com a grade:
*
*   With ThisForm.Grade                     -> VincularGrade()
*       .RecordSource='xPar'
*       .fpagto.controlsource='xPar.FPags'
*       ... (5 colunas)
*       .refresh
*   EndWith
*   Select xPar / Go Top                    -> SELECT (cursor) + GO TOP
*
* O vinculo fica num metodo PROPRIO (VincularGrade) porque CarregarDados tem
* de poder REFAZE-LO: re-atribuir RecordSource reseta Column.Width,
* Column.Header1.Caption e a fonte das colunas (Problema 48 / regra #41), e
* cada caminho que popula o cursor precisa fechar com GO TOP + Refresh, senao
* a grade fica visualmente vazia com o cursor cheio (regra #21). Os pontos que
* alteram xPar no legado (Apaga.Click com Zap, Valor.Valid, fweditdata_Venc.
* Valid que gera as parcelas) chamam este mesmo funil nas fases de eventos.
*
* AjustarBotoesPorModo() reproduz a ULTIMA linha de botao do Init legado -
* `ThisForm.Apaga.Visible = Inlist(Op_Escolha,'INSERIR','ALTERAR')` - e roda
* DEPOIS de TornarControlesVisiveis, que forca Visible=.T. em tudo e apagaria
* a regra. O bloco que mexia em Ok.Left/Ok.Cancel/Cancela por llAltDireta esta
* COMENTADO (`*!*`) no SCX legado e por isso nao eh transcrito.
*
* FASE 5/8: Campos do cabecalho do dialogo (txt_4c_Fpg/MoeOper/
* Npar/Vpar/Fweditdata_venc/PEncargo/VEncargo/COTACAO/Porc/MoeOcr/
* ValTotChqs/TotForma, obj_4c_GetObs, os avisos de leitora serial
* img_4c_AvisoPorta* e os respectivos labels), em ConfigurarCampos().
* So geometria/aparencia (Visible/Value/InputMask iniciais): lookup de
* Get_fpg, calculo de parcelas/encargo/cotacao e a alternancia Get_npar x
* Get_MoeOcr ficam para as fases de eventos (7 e 8).
* FASE 6/8 (ESTA FASE): Paineis flutuantes por forma de pagamento
* (cnt_4c_CCred/cnt_4c_CCredFP - cartao de credito, cnt_4c_CarneFP - carne,
* cnt_4c_OutrosFP - observacao livre, cnt_4c_ChequeFP - dados do cheque),
* em ConfigurarPaineisFlutuantes(). Todos nascem Visible=.F. (igual ao dump)
* e TornarControlesVisiveis() ganhou a excecao que preserva esse Visible=.F.
* nos 5 containers (lista de nomes CNT_4C_*), descendo a recursao so para os
* filhos. cursor_4c_Dados (GarantirCursorDados) ganhou os campos que esses
* paineis usam de xPar (Bancos/Agencias/Contas/Numeros/Cartaos/Nocreditos/
* Ncarnes/Outros). A alternancia real de Visible (MostraObs/mCartaoCred) e
* o trafego com o cursor saem nas fases de eventos (7 e 8).
*
* Ainda na Fase 6, o LOOKUP do unico campo do dialogo que tem busca -
* Get_fpg ("Cond. Pagto"), que no legado abre o browse fwBuscaSel sobre
* csSigOpFp - fica COMPLETO: ConfigurarEventosLookup() liga "LostFocus"
* (equivalente ao Valid, que roda ao SAIR do campo) e "KeyPress" (ENTER
* confirma, F4/F5 abrem a busca direta), e o lookup se resolve em
* AbrirLookupFpg / ObterFiltroFormasValidas / ExisteFormaPagamentoValida /
* AplicarFormaPagamento / LimparFormaPagamento. Ver o bloco de comentario
* desses metodos para a transcricao linha a linha do Valid legado e para a
* razao de haver DOIS universos (csSigOpFp filtrado para o browse, crSigOpFp
* sem filtro para ler o registro escolhido).
*
* FASE 7/8 (ESTA FASE): Eventos principais - o Click dos CINCO botoes que o
* SCX legado tem, ligados em ConfigurarEventosBotoes (BINDEVENT "Click", que
* exige metodo PUBLIC - regra #3):
*
*   SIGOPFPG.Apaga.Click             -> CmdApagaClick
*   SIGOPFPG.Ok.Click                -> CmdOkClick
*   SIGOPFPG.Cancela.Click           -> CmdCancelaClick
*   SIGOPFPG.alteracotacao.Click     -> CmdAlteraCotacaoClick (+ o When do
*                                       botao, em PodeAlterarCotacao)
*   SIGOPFPG.CntCCred.Confirma.Click -> CmdConfirmaCartaoClick
*
* Esta tela NAO tem botao CRUD (Incluir/Alterar/Visualizar/Excluir): o SCX
* legado herda de `form` puro, nao de `frmcadastro` - nao ha barra CRUD, nem
* `pcEscolha` propria (o modo eh LIDO do form pai: `Thisform.Op_Escolha =
* pForm.pcEscolha`). Logo nao existe aqui o quarteto de handlers Btn<verbo>
* Click da convencao de cadastro: criar esses botoes seria INVENTAR superficie
* que o legado nao tem (viola o PILAR 1), e criar os metodos vazios violaria a
* regra de completude. O dump confirma: zero ocorrencia de `frmcadastro`,
* `Grupo_Op` e `pcEscolha` propria.
*
* Junto com os handlers vem as tres rotinas do legado que eles acionam, cada
* uma transcrita do dump:
*
*   PROCEDURE mostraobs    -> MostrarObservacao (+ CarregarInfoFormaPagamento,
*                             que substitui o `Seek` em CrSigOpFp por SELECT
*                             em SigOpFp - este dialogo tem DataSession = 2 e
*                             nao alcanca os cursores da sessao do pai)
*   PROCEDURE mcartaocred  -> CartaoCredito
*   PROCEDURE return       -> FecharDialogo (fonte unica dos dois caminhos de
*                             saida, com this_lConfirmado dizendo ao form pai
*                             se o usuario confirmou ou cancelou)
*
* FASE 8/8 (ESTA FASE): eventos dos CAMPOS e a transferencia com o form pai -
* calculo de parcelas/encargo e o bloco de cotacao/cambio do Valid de
* Get_vpar/GetPorc/fweditdata_venc (CarregarCambio/MoedaPermiteCotacao/
* CargoTemAltCots substituem crSigCdMoe/crUsuario/crSigCdCrg - cursores
* globais do login legado, inexistentes aqui, por SQLEXEC direto), o leitor
* serial de cheques (InChequeSerial/VerificaCheque/LimpaChe - ReadComm OLE
* nao existe nesta arquitetura, degrada para digitacao manual, mesmo padrao
* de Formsigopcim.PrepararLeitoraParaFoco), DefinirDadosTitulo (API publica
* para o form pai informar data de entrada/valor total/empresa do titulo -
* substitui a leitura direta de crSigChLcq, que este dialogo com DataSession
* propria nao alcanca) e as validacoes de venc < data de entrada, digitos do
* cheque e numero do cartao de credito. As celulas de Valor/Vencimento da
* grade (Column2/Column3) ganharam classes TextBox proprias (regra #46 -
* TextBoxCelulaValorFpg/TextBoxCelulaVencFpg, declaradas antes desta
* DEFINE CLASS) porque a validacao delas mora no Valid da CELULA, nao em
* AfterRowColChange nem em BINDEVENT de Valid.
*
* Herda de: FormBase
*==============================================================================

*==============================================================================
* TextBoxCelulaValorFpg / TextBoxCelulaVencFpg - celulas editaveis das colunas
* Valor/Vencimento da grade de formas de pagamento (SIGOPFPG.Grade.valor.
* Text1 / SIGOPFPG.Grade.venc.Text1 do legado). Regra #46: celula de grade
* valida no PROPRIO Valid do TextBox da coluna, nunca em AfterRowColChange
* (nColIndex ali eh a coluna de DESTINO) - e BINDEVENT em Valid de TextBox de
* Column nao eh confiavel, por isso o Valid eh metodo DA CLASSE.
*
* this_oForm guarda a referencia ao FormSigOpFpg (setada apos o AddObject, em
* VincularGrade) porque o TextBox criado dentro de uma Column nao alcanca
* ThisForm pelo caminho usual em todos os contextos de disparo do Valid.
*==============================================================================
DEFINE CLASS TextBoxCelulaValorFpg AS TextBox
    this_oForm = .NULL.

    PROCEDURE Valid()
        IF VARTYPE(THIS.this_oForm) = "O"
            RETURN THIS.this_oForm.ValidarValorLinhaGrade()
        ENDIF
        RETURN .T.
    ENDPROC
ENDDEFINE

DEFINE CLASS TextBoxCelulaVencFpg AS TextBox
    this_oForm = .NULL.

    PROCEDURE Valid()
        IF VARTYPE(THIS.this_oForm) = "O"
            RETURN THIS.this_oForm.ValidarVencimentoLinhaGrade()
        ENDIF
        RETURN .T.
    ENDPROC
ENDDEFINE

DEFINE CLASS FormSigOpFpg AS FormBase

    *-- Mensagem de erro capturada no InicializarForm (padrao FormBase)
    this_cMensagemErro = ""

    *-- Contexto recebido do formulario pai (Init legado: Lparameters pForm,
    *-- DatSes, llAltDireta)
    this_oFormPai          = .NULL.  && pForm - form de movimento que abriu o dialogo
    this_nDataSessionPai   = 0       && DatSes - DataSessionID do form pai (cursores compartilhados)
    this_cOpEscolha        = ""      && pForm.pcEscolha (INSERIR/ALTERAR/CONSULTAR/EXCLUIR)
    this_lAltDireta        = .F.     && llAltDireta - fluxo de alteracao direta de forma de pagamento

    *-- Estado do painel (flags/variaveis soltas do form legado)
    this_lLeitor           = .F.     && Thisform.Leitor - leitora serial de cheques ativa
    this_cLeituraSerial    = ""      && Thisform.LeituraSerial - buffer da porta serial
    this_cTipoLeitora      = ""      && Thisform.TipoLeitora - "S" = leitora serial configurada
    this_lDigpar           = .F.     && Thisform.Digpar - habilita digitacao manual do numero de parcelas
    this_cCotUsu           = ""      && Thisform.CotUsu - indicador de cotacao alterada via SigOpAlC

    *-- Resultado do dialogo para o formulario pai (FASE 7/8): .T. quando o
    *-- usuario saiu por Confirmar (Ok) e .F. quando saiu por Cancelar. O
    *-- legado nao precisava disso - pai e dialogo compartilhavam a
    *-- datasession e o resultado era o proprio cursor xPar; aqui o dialogo
    *-- tem DataSession = 2 e o pai le esta property depois do Show().
    this_lConfirmado       = .F.

    *-- Valor anterior do campo Cotacao (peantvalue da classe fwget legado,
    *-- usado pelo alteracotacao.Click para desfazer a alteracao quando a
    *-- autorizacao eh cancelada). TextBox do VFP9 nao tem peantvalue.
    this_nCotacaoAnterior  = 0

    *-- Estado da forma de pagamento da LINHA CORRENTE da grade, resolvido em
    *-- CarregarInfoFormaPagamento e consumido por MostrarObservacao
    *-- (equivalente a CrSigOpFp.Infos e CrSigOpFp.Obs do mostraobs legado)
    this_cInfoForma        = ""      && SigOpFp.infos - C=cheque, N=carne, O=outros, T=cartao
    this_lObsForma         = .F.     && SigOpFp.obs = 1 - a forma pede observacao

    *-- Guarda de reentrancia do lookup (regra #37/#47): FormBuscaAuxiliar eh
    *-- MODAL - o Show() tira o foco do campo e faz o proprio LostFocus
    *-- disparar de novo, empilhando um segundo picker. Ligada no FUNIL
    *-- (TxtFpgLostFocus), que cobre as duas entradas (F4 e saida do campo).
    this_lEmLookup         = .F.

    *-- Alias do cursor das linhas da grade (equivalente a xPar do legado).
    *-- FONTE UNICA do nome: GarantirCursorDados/VincularGrade/CarregarDados e
    *-- as fases seguintes leem daqui, para o alias nao divergir entre fases.
    this_cCursorGrade      = "cursor_4c_Dados"

    *-- Cache de feriados (SigCdFer), usado pelo gerador de parcelas
    *-- (fweditdata_venc.Valid, Fase 8) para empurrar o vencimento alem de
    *-- um feriado - mesmo padrao de SigPrCfnBO.CarregarFeriados/
    *-- this_cFeriados.
    this_cFeriadosCache      = "|"
    this_lFeriadosCarregados = .F.

    *-- Configuracoes visuais do form (fieis ao SCX legado - SIGOPFPG)
    DataSession  = 2
    WindowType = 1
    ShowWindow   = 1
    Width        = 800
    Height       = 600
    Caption      = "Forma de Pagamento"
    ControlBox   = .F.
    Closable     = .F.
    Movable      = .F.
    TitleBar     = 0
    WindowState  = 0
    AutoCenter   = .T.
    BorderStyle  = 2
    AlwaysOnTop  = .F.

    *--------------------------------------------------------------------------
    * Init - equivalente a Lparameters pForm, DatSes, llAltDireta. Guarda os
    * parametros ANTES de DODEFAULT() (que aciona FormBase.Init() ->
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oFormPai, par_nDataSessionPai, par_lAltDireta)
        THIS.this_oFormPai        = IIF(VARTYPE(par_oFormPai) = "O", par_oFormPai, .NULL.)
        THIS.this_nDataSessionPai = IIF(VARTYPE(par_nDataSessionPai) = "N", par_nDataSessionPai, 0)
        THIS.this_lAltDireta      = IIF(VARTYPE(par_lAltDireta) = "L", par_lAltDireta, .F.)

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Hook chamado por FormBase.Init(). Cria o Business
    * Object, espelha o contexto do form pai nele (equivalente a
    * Thisform.Op_Escolha = pForm.pcEscolha / pForm.Enabled = .F.) e monta a
    * estrutura visual basica (faixa do cabecalho + decoracao).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpFpgBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Legado: Thisform.Op_Escolha = pForm.pcEscolha + pForm.Enabled = .F.
                IF VARTYPE(THIS.this_oFormPai) = "O"
                    IF PEMSTATUS(THIS.this_oFormPai, "pcEscolha", 5)
                        THIS.this_cOpEscolha = THIS.this_oFormPai.pcEscolha
                    ENDIF

                    IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
                        THIS.this_oFormPai.Enabled = .F.
                    ENDIF
                ENDIF

                THIS.this_oBusinessObject.this_cOpEscolha = THIS.this_cOpEscolha
                THIS.this_oBusinessObject.this_lAltDireta = THIS.this_lAltDireta

                THIS.ConfigurarEstruturaBase()

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro ao inicializar Forma de Pagamento")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarEstruturaBase - Faixa do cabecalho + elementos decorativos.
    * Grade, campos e paineis flutuantes entram nas fases seguintes.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEstruturaBase()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarDecoracao()
        THIS.ConfigurarCampos()
        THIS.ConfigurarGrade()
        THIS.ConfigurarBotoes()
        THIS.ConfigurarPaineisFlutuantes()
        THIS.ConfigurarEventosLookup()

        *-- BINDEVENT dos botoes DEPOIS de todos os AddObject que os criam
        *-- (ConfigurarBotoes, ConfigurarCampos e ConfigurarPaineisFlutuantes):
        *-- BINDEVENT exige o objeto ja existente
        THIS.ConfigurarEventosBotoes()

        THIS.TornarControlesVisiveis(THIS)

        *-- DEPOIS do TornarControlesVisiveis, que forca Visible=.T. em tudo:
        *-- a visibilidade do Apaga depende do modo (Init legado) e seria
        *-- apagada se fosse aplicada antes.
        THIS.AjustarBotoesPorModo()

        *-- Idem para os controles que o dump do SCX ja nasce com
        *-- Visible = .F. (Get_COTACAO/alteracotacao/GetObs/SayObs) - sem
        *-- reaplicar DEPOIS do TornarControlesVisiveis, ele reverte os
        *-- quatro para .T. e o bloco de alterar cotacao / observacao
        *-- aparece sempre, fora do fluxo que os liga (MostrarObservacao e
        *-- CmdAlteraCotacaoClick, Fase 7).
        *-- Medido no VFP9 (probe da Fase 5): sem esta chamada os 4 saiam
        *-- Visible=.T. na instanciacao.
        THIS.OcultarCamposCondicionais()

        *-- FASE 8/8: leitora de cheques (SigSyCom) + campos dependentes do
        *-- estado "sem forma de pagamento escolhida" (comeca assim) +
        *-- Credito espelho (this_lCarAuts comeca .F.) - tudo ANTES do
        *-- `Select xPar / Go Top` final, igual ao Init legado.
        THIS.ResolverTipoLeitora()
        THIS.ResolverMoedaOperacao()
        THIS.AtualizarCamposPorFormaPagamento()
        THIS.AtualizarEnabledCreditoFp()

        *-- `Select xPar / Go Top` do fim do Init legado + o `.refresh` da
        *-- grade. Depois do TornarControlesVisiveis de proposito: Refresh em
        *-- controle ainda invisivel nao pinta (regra #21).
        THIS.CarregarDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Faixa cinza do topo (cntSombra no legado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .WordWrap  = .T.
            .Alignment = 0
            .BackStyle = 0
            .AutoSize  = .F.
            .Top       = 18
            .Left      = 10
            .Width     = 769
            .Height    = 40
            .ForeColor = RGB(0, 0, 0)
            .Caption   = THIS.Caption
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .WordWrap  = .T.
            .Alignment = 0
            .BackStyle = 0
            .AutoSize  = .F.
            .Top       = 17
            .Left      = 10
            .Width     = 769
            .Height    = 46
            .ForeColor = RGB(255, 255, 255)
            .Caption   = THIS.Caption
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarDecoracao - Elementos graficos soltos do form legado, sem
    * dado nem comportamento (Shape1 em torno do bloco de moeda/cotacao,
    * Line1 separando o bloco de totais).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarDecoracao()
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 7
            .Left        = 622
            .Width       = 173
            .Height      = 110
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH

        THIS.AddObject("lin_4c_Line1", "Line")
        WITH THIS.lin_4c_Line1
            .Top         = 173
            .Left        = 429
            .Width       = 108
            .Height      = 0
            .BorderWidth = 2
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCampos - Campos do cabecalho do dialogo (FASE 5/8), filhos
    * DIRETOS do form (layout FLAT, sem PageFrame - nenhuma compensacao de
    * Top eh necessaria, os valores sao os mesmos do dump SIGOPFPG).
    *
    * Cada rotulo eh criado ANTES do seu campo (label tem BackStyle = 0 e nao
    * pinta, mas a caixa continua recebendo clique - criado depois, o label
    * ficaria por cima e bloquearia o campo).
    *
    * LABELS - "Say*" do legado sao classe `say` pura (dump NAO declara Width
    * nem Alignment): Tahoma 8, AutoSize = .F. EXPLICITO (eh no-op em Label
    * criado por AddObject - regra #23), Alignment = 0 (esquerda),
    * ForeColor = RGB(90,90,90) (nunca branco: a Page nao existe aqui, mas o
    * form tambem nao tem fundo escuro nesta area). Width calculada para caber
    * o texto sem invadir o campo vizinho da mesma linha (gap entre o Left do
    * label e o Left do campo).
    *
    * CAMPOS - "Get_*"/"fweditdata_venc" sao classe `fwget`/`fweditdata`
    * (Base: textbox): o que o dump nao declara vem do default Tahoma 8,
    * Alignment = 3 (automatico) exceto onde o dump marca Alignment = 3
    * explicito (os campos monetarios) ou nao marca nada (Get_fpg/Get_npar,
    * que ficam no default 0/esquerda do TextBox). ControlSource fica VAZIO
    * (igual ao dump) - o trafego de valores destes campos com a grade/cursor
    * e com os cursores do form pai (CrSigOpFp/crSigChLcq/crSigCdPam) eh
    * assunto das Fases 7/8 (eventos), nao desta fase de puro layout.
    *
    * Get_MoeOcr e Get_npar OCUPAM O MESMO Left/Top no dump (181,148) - nao eh
    * erro de transcricao: Get_MoeOcr.When sempre retorna .F. (campo nunca
    * recebe foco, soh exibicao) e o legado alterna qual dos dois aparece
    * conforme a forma de pagamento escolhida (Cheque mostra moeda no lugar de
    * parcelas). A alternancia de Visible fica para a Fase 8 - aqui os dois
    * sao criados nas coordenadas exatas do SCX.
    *
    * Get_COTACAO/cmd_4c_Alteracotacao e GetObs/lbl_4c_Obs nascem Visible=.F.
    * (dump) - permanecem assim: TornarControlesVisiveis so forca Visible=.T.
    * em controles que ja estao .T., preservando os .F. explicitos aplicados
    * DEPOIS dele (igual ao padrao de AjustarBotoesPorModo/cmd_4c_Apaga).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCampos()

        *-- Say12 "Cond. Pagto : " + Get_fpg -------------------------------
        THIS.AddObject("lbl_4c_Label12", "Label")
        WITH THIS.lbl_4c_Label12
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .WordWrap  = .F.
            .Caption   = "Cond. Pagto : "
            .Left      = 108
            .Top       = 127
            .Width     = 70
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Fpg", "TextBox")
        WITH THIS.txt_4c_Fpg
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Value       = ""
            .MaxLength   = 12
            .Left        = 181
            .Top         = 123
            .Width       = 94
            .Height      = 23
            .ToolTipText = "Digite a forma de pagamento"
            .TabIndex    = 1
            .Visible     = .T.
        ENDWITH

        *-- Say13 "Qtde. Parcelas : " + Get_npar ----------------------------
        THIS.AddObject("lbl_4c_Label13", "Label")
        WITH THIS.lbl_4c_Label13
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .WordWrap  = .F.
            .Caption   = "Qtde. Parcelas : "
            .Left      = 97
            .Top       = 152
            .Width     = 80
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Npar", "TextBox")
        WITH THIS.txt_4c_Npar
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Value       = 0
            .InputMask   = "99"
            .Left        = 181
            .Top         = 148
            .Width       = 24
            .Height      = 23
            .ToolTipText = "N" + CHR(250) + "mero de Parcelas"
            .TabIndex    = 2
            .Visible     = .T.
        ENDWITH

        *-- GetPorc - percentual de encargo (sem label propria no dump) ----
        THIS.AddObject("txt_4c_Porc", "TextBox")
        WITH THIS.txt_4c_Porc
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 3
            .Value     = 0
            .InputMask = "999.9%"
            .Left      = 235
            .Top       = 148
            .Width     = 54
            .Height    = 23
            .TabIndex  = 3
            .Visible   = .T.
        ENDWITH

        *-- Get_MoeOcr - mesma posicao de Get_npar, alternado por forma de
        *-- pagamento na Fase 8 (ver comentario do metodo) -----------------
        THIS.AddObject("txt_4c_MoeOcr", "TextBox")
        WITH THIS.txt_4c_MoeOcr
            .FontName  = "Courier New"
            .FontSize  = 9
            .Value     = 0
            .InputMask = "999,999,999.99"
            .Left      = 181
            .Top       = 148
            .Width     = 31
            .Height    = 23
            .TabIndex  = 16
            *-- Get_MoeOcr.When legado = Return(.F.) - nunca digitavel
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *-- Say_Cotacao "Cotacao : " + Get_COTACAO + alteracotacao (\<C$) --
        *-- os tres nascem Visible = .F. no dump (bloco de alteracao manual
        *-- de cotacao, habilitado so quando o usuario clica no botao C$) --
        THIS.AddObject("lbl_4c__Cotacao", "Label")
        WITH THIS.lbl_4c__Cotacao
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .WordWrap  = .F.
            .Caption   = "Cota" + CHR(231) + CHR(227) + "o : "
            .Left      = 128
            .Top       = 177
            .Width     = 49
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .F.
        ENDWITH

        THIS.AddObject("txt_4c_COTACAO", "TextBox")
        WITH THIS.txt_4c_COTACAO
            .FontName  = "Courier New"
            .FontSize  = 9
            .Value     = 0
            .InputMask = "999.9999"
            .Left      = 181
            .Top       = 173
            .Width     = 74
            .Height    = 23
            .TabIndex  = 4
            .Visible   = .F.
        ENDWITH

        THIS.AddObject("cmd_4c_Alteracotacao", "CommandButton")
        WITH THIS.cmd_4c_Alteracotacao
            .Top        = 172
            .Left       = 261
            .Width      = 28
            .Height     = 24
            .Caption    = "\<C$"
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .TabStop    = .F.
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes     = .F.
            .TabIndex   = 5
            .Visible    = .F.
        ENDWITH

        *-- Say17 "Valor : " + Get_vpar -------------------------------------
        THIS.AddObject("lbl_4c_Label17", "Label")
        WITH THIS.lbl_4c_Label17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .WordWrap  = .F.
            .Caption   = "Valor : "
            .Left      = 144
            .Top       = 203
            .Width     = 34
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Vpar", "TextBox")
        WITH THIS.txt_4c_Vpar
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Alignment   = 3
            .Value       = 0
            .InputMask   = "999,999,999.99"
            .Left        = 181
            .Top         = 198
            .Width       = 108
            .Height      = 23
            .ToolTipText = "Valor de cada Parcela"
            .TabIndex    = 6
            .Visible     = .T.
        ENDWITH

        *-- Say1 "Enc. Financ. : " + Get_PEncargo ---------------------------
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .WordWrap  = .F.
            .Caption   = "Enc. Financ. : "
            .Left      = 109
            .Top       = 228
            .Width     = 68
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_PEncargo", "TextBox")
        WITH THIS.txt_4c_PEncargo
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 3
            .Value     = 0
            .InputMask = "999,999.99 %"
            .Left      = 181
            .Top       = 223
            .Width     = 96
            .Height    = 23
            .TabIndex  = 7
            .Visible   = .T.
        ENDWITH

        *-- Say19 "Valor Encargo : " + Get_VEncargo -------------------------
        THIS.AddObject("lbl_4c_Label19", "Label")
        WITH THIS.lbl_4c_Label19
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .WordWrap  = .F.
            .Caption   = "Valor Encargo : "
            .Left      = 102
            .Top       = 253
            .Width     = 75
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_VEncargo", "TextBox")
        WITH THIS.txt_4c_VEncargo
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 3
            .Value     = 0
            .InputMask = "999,999,999.99"
            .Left      = 181
            .Top       = 248
            .Width     = 108
            .Height    = 23
            .TabIndex  = 8
            *-- Get_VEncargo.When legado = Return .f. - nunca digitavel
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *-- Say18 "Vencimento : " + fweditdata_venc -------------------------
        THIS.AddObject("lbl_4c_Label18", "Label")
        WITH THIS.lbl_4c_Label18
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .WordWrap  = .F.
            .Caption   = "Vencimento : "
            .Left      = 113
            .Top       = 277
            .Width     = 64
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- fweditdata_venc - classe `fweditdata`: Value = {} (DATE), sem
        *-- Format/InputMask proprios (o dump nao declara nenhum dos dois -
        *-- regra #49: nao inventar mascara que o legado nao tem)
        THIS.AddObject("txt_4c_Fweditdata_venc", "TextBox")
        WITH THIS.txt_4c_Fweditdata_venc
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Themes      = .F.
            .Value       = {}
            .Left        = 181
            .Top         = 273
            .Width       = 80
            .Height      = 23
            .ToolTipText = "Data de Vencimento"
            .TabIndex    = 9
            .Visible     = .T.
        ENDWITH

        *-- Say20 "Moeda dos Cheques : " + Get_MoeOper ----------------------
        THIS.AddObject("lbl_4c_Label20", "Label")
        WITH THIS.lbl_4c_Label20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .WordWrap  = .F.
            .Caption   = "Moeda dos Cheques : "
            .Left      = 318
            .Top       = 128
            .Width     = 105
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_MoeOper", "TextBox")
        WITH THIS.txt_4c_MoeOper
            *-- Get_MoeOper eh a MOEDA DE OPERACAO (SigCdPam.MoedaCheqs,
            *-- char(3)) - NAO um valor numerico. Resolvida em
            *-- ResolverMoedaOperacao(), nunca digitada pelo usuario.
            .FontName  = "Courier New"
            .FontSize  = 9
            .Value     = ""
            .Left      = 429
            .Top       = 122
            .Width     = 31
            .Height    = 23
            .TabIndex  = 17
            *-- Get_MoeOper.When legado = Return(.F.) - nunca digitavel
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *-- Say24 "Total dos Cheques : " + Get_ValTotChqs -------------------
        THIS.AddObject("lbl_4c_Label24", "Label")
        WITH THIS.lbl_4c_Label24
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .WordWrap  = .F.
            .Caption   = "Total dos Cheques : "
            .Left      = 326
            .Top       = 152
            .Width     = 98
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_ValTotChqs", "TextBox")
        WITH THIS.txt_4c_ValTotChqs
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 3
            .Value     = 0
            .InputMask = "999,999,999.99"
            .Margin    = 0
            .Left      = 429
            .Top       = 148
            .Width     = 108
            .Height    = 20
            .TabIndex  = 28
            *-- Get_ValTotChqs.When legado = Return(.f.) - nunca digitavel
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *-- Say23 "Total Forma Pagto : " + Get_TotForma ---------------------
        THIS.AddObject("lbl_4c_Label23", "Label")
        WITH THIS.lbl_4c_Label23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .WordWrap  = .F.
            .Caption   = "Total Forma Pagto : "
            .Left      = 327
            .Top       = 179
            .Width     = 98
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_TotForma", "TextBox")
        WITH THIS.txt_4c_TotForma
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 3
            .Value     = 0
            .Format    = "K"
            .InputMask = "999,999,999.99"
            .Margin    = 0
            .Left      = 429
            .Top       = 177
            .Width     = 108
            .Height    = 20
            .TabIndex  = 30
            *-- Get_TotForma.When legado = Return(.F.) - nunca digitavel
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *-- SayObs "Observacao" + GetObs (EditBox) - nascem Visible = .F.;
        *-- o legado so mostra quando CrSigOpFp.Obs = 1 (MostrarObservacao) -
        THIS.AddObject("lbl_4c_Obs", "Label")
        WITH THIS.lbl_4c_Obs
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .WordWrap  = .F.
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o"
            .Left      = 521
            .Top       = 297
            .Width     = 90
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .F.
        ENDWITH

        THIS.AddObject("obj_4c_GetObs", "EditBox")
        WITH THIS.obj_4c_GetObs
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Left      = 519
            .Top       = 314
            .Width     = 192
            .Height    = 138
            .TabIndex  = 36
            .Visible   = .F.
        ENDWITH

        *-- Avisos da leitora serial de cheques (b_alpham/t/s.bmp) - a
        *-- alternancia de Visible entre os tres fica para a Fase 8, que
        *-- transcreve o Thisform.AvisoPorta*.Visible do Get_bco legado ----
        THIS.AddObject("img_4c_AvisoPortaM", "Image")
        WITH THIS.img_4c_AvisoPortaM
            .Picture     = gc_4c_CaminhoIcones + "B_ALPHAM.BMP"
            .Stretch     = 0
            .BorderStyle = 0
            .Enabled     = .F.
            .Left        = 556
            .Top         = 117
            .Width       = 25
            .Height      = 25
            .Visible     = .T.
        ENDWITH

        THIS.AddObject("img_4c_AvisoPortaT", "Image")
        WITH THIS.img_4c_AvisoPortaT
            .Picture     = gc_4c_CaminhoIcones + "B_ALPHAT.BMP"
            .Stretch     = 0
            .BackStyle   = 1
            .BorderStyle = 0
            .Enabled     = .F.
            .Left        = 580
            .Top         = 117
            .Width       = 25
            .Height      = 25
            .Visible     = .T.
        ENDWITH

        THIS.AddObject("img_4c_AvisoPortaS", "Image")
        WITH THIS.img_4c_AvisoPortaS
            .Picture     = gc_4c_CaminhoIcones + "B_ALPHAS.BMP"
            .Stretch     = 0
            .BackStyle   = 1
            .BorderStyle = 0
            .Enabled     = .F.
            .Left        = 604
            .Top         = 117
            .Width       = 25
            .Height      = 25
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrade - Grade de formas de pagamento (Grade/xPar do legado).
    * cursor_4c_Dados eh o equivalente local a xPar - cursor PRIVADO desta
    * datasession (THIS.DataSession = 2), nunca compartilhado com o form pai.
    * Campos na mesma ordem/tipo usados nos ControlSource do SCX legado
    * (.fpagto.controlsource='xPar.FPags' / .Valor.controlsource='xPar.Valos'
    * / .venc.controlsource='xPar.vencs' / .moeda.controlsource=
    * 'xPar.moefpgs' / .cotfpg.controlsource='xPar.cotfpgs').
    *
    * Aqui ficam apenas as propriedades do GRID que nao dependem de dado
    * (geometria, marcas, scroll, TabIndex). O vinculo ao cursor e tudo o que
    * mora nas Columns sai em VincularGrade(), porque CarregarDados() tem de
    * poder refazer o vinculo e re-atribuir RecordSource reseta Width, fonte e
    * Header1.Caption das colunas (Problema 48 / regra #41).
    *
    * .ReadOnly = .F. do GRID fica ANTES da chamada a VincularGrade: o ReadOnly
    * do grid propaga para as colunas e sobrescreveria o Column1.ReadOnly = .T.
    * do legado se viesse depois (regra #18).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrade()
        THIS.GarantirCursorDados()

        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .Top        = 304
            .Left       = 89
            .Width      = 425
            .Height     = 149
            *-- TabIndex do dump (SIGOPFPG.Grade.TabIndex = 10). O VFP limita o
            *-- valor ao numero de controles ja existentes no container, entao
            *-- enquanto os campos do cabecalho e os paineis flutuantes nao
            *-- estiverem criados ele fica menor; a ordem final de tabulacao se
            *-- estabelece quando todos os controles do form existirem.
            .TabIndex   = 10
            .ReadOnly   = .F.
            .DeleteMark = .F.
            .RecordMark = .F.
            .ScrollBars = 2
        ENDWITH

        THIS.VincularGrade()

        *-- SIGOPFPG.Grade.AfterRowColChange do legado: `Thisform.mostraobs` +
        *-- `ThisForm.GetObs.Refresh` a cada troca de linha/coluna - alterna os
        *-- paineis flutuantes para a forma de pagamento da linha corrente
        *-- (regra #46: AfterRowColChange SEM filtro de coluna, carregando o
        *-- detalhe da linha, eh o uso CORRETO deste evento).
        BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GradeAfterRowColChange")

        THIS.grd_4c_Dados.Visible = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * GarantirCursorDados - Cria o cursor das linhas da grade (equivalente a
    * xPar do legado) se ele ainda nao existir. UNICO ponto do form com a
    * CREATE CURSOR, para que a lista e a ORDEM dos campos sejam sempre as
    * mesmas (regra de forms OPERACIONAIS). Cursor PRIVADO desta datasession
    * (THIS.DataSession = 2), populado pelos proprios eventos do dialogo - nao
    * vem de SQLEXEC, por isso nao precisa de SET NULL ON.
    *
    * Os 5 campos sao exatamente os que o SCX legado liga as colunas
    * (.fpagto='xPar.FPags' / .Valor='xPar.Valos' / .venc='xPar.vencs' /
    * .moeda='xPar.moefpgs' / .cotfpg='xPar.cotfpgs'). Os campos de xPar que
    * so os paineis flutuantes usam (bancos/agencias/contas/numeros/cartaos/
    * nocreditos/ncarnes/outros/obs) sao acrescentados NESTA MESMA CREATE
    * CURSOR quando esses paineis entrarem.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GarantirCursorDados()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_cCursorGrade

        IF !USED(loc_cCursor)
            *-- Os 5 primeiros campos sao os que a grade usa (Fase 4). Os
            *-- demais (Fase 6) sao de xPar usados so pelos paineis
            *-- flutuantes: Bancos/Agencias/Contas/Numeros (CntChequeFP -
            *-- larguras do parse por posicao do Get_bco.Valid legado:
            *-- Substr(Leitura,2,3)/Substr(Leitura,5,4)/Substr(Leitura,23,10)/
            *-- Substr(Leitura,14,6)), Cartaos/Nocreditos (CntCCred/CntCCredFP
            *-- - InputMask do dump "99999999999999999999"=C(20) /
            *-- "XXXXXXXXXX"=C(10)), Ncarnes (CntCarneFP - formatado no legado
            *-- como "@L 999999/N") e Outros (CntOutrosFP - observacao livre,
            *-- TextBox sem InputMask/MaxLength no dump).
            *-- Parcs/Emps/Datas/Dcarts/Cotusus (Fase 8): colunas que o
            *-- `Replace` do gerador de parcelas (fweditdata_venc.Valid)
            *-- grava em CADA linha, alem das 5 que a grade exibe - sao o
            *-- contrato que este dialogo devolve ao form pai (Dcarts
            *-- char(30) espelha SigOpFp.dcarts).
            CREATE CURSOR (loc_cCursor) ;
                (FPags C(12), Valos N(14,2), Vencs D, MoeFpgs C(3), CotFpgs N(11,6), ;
                 Bancos C(3), Agencias C(4), Contas C(10), Numeros C(6), ;
                 Cartaos C(20), Nocreditos C(10), Ncarnes C(12), Outros C(60), ;
                 Parcs N(3,0), Emps C(3), Datas D, Dcarts C(30), Cotusus C(20))
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * VincularGrade - Transcricao do bloco `With ThisForm.Grade ... EndWith` do
    * Init legado: liga a grade ao cursor e configura as 5 colunas.
    *
    * Ordem obrigatoria (regra #41): ColumnCount -> RecordSource ->
    * ControlSource -> fonte/InputMask/Width/ColumnOrder -> Header1.Caption.
    * Largura e caption depois do RecordSource porque ele as reseta para o
    * default; por isso este metodo eh reexecutavel e eh chamado tambem por
    * CarregarDados.
    *
    * ColumnCount so eh reatribuido se estiver diferente de 5: qualquer
    * atribuicao recria os objetos Column e destruiria controles postos por
    * Column.AddObject (o TextBox de celula com lookup entra numa fase
    * seguinte, e o rebind nao pode mata-lo).
    *
    * Larguras/ColumnOrder/InputMask/ReadOnly transcritos do dump do SCX
    * (SIGOPFPG.Grade.Column1..5): a ordem VISUAL (ColumnOrder) difere da ordem
    * interna das Columns - Vencimento (Column3) desenha por ULTIMO, depois de
    * Moe/Cotacao (Column4/5) - por isso .ColumnOrder eh setado explicitamente
    * nas colunas 3/4/5, igual ao legado. Text1 de cada coluna recebe
    * BorderStyle/Margin/ForeColor/BackColor do dump.
    *--------------------------------------------------------------------------
    PROCEDURE VincularGrade()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_cCursorGrade

        THIS.GarantirCursorDados()

        WITH THIS.grd_4c_Dados
            IF .ColumnCount != 5
                .ColumnCount = 5
            ENDIF

            .RecordSource = loc_cCursor

            *-- ControlSource das 5 colunas (bloco With ThisForm.Grade legado)
            .Column1.ControlSource = loc_cCursor + ".FPags"
            .Column2.ControlSource = loc_cCursor + ".Valos"
            .Column3.ControlSource = loc_cCursor + ".Vencs"
            .Column4.ControlSource = loc_cCursor + ".MoeFpgs"
            .Column5.ControlSource = loc_cCursor + ".CotFpgs"

            *-- Fonte das colunas e do Text1 de cada celula
            .Column1.FontName = "Courier New"
            .Column2.FontName = "Courier New"
            .Column3.FontName = "Courier New"
            .Column4.FontName = "Courier New"
            .Column5.FontName = "Courier New"

            *-- Mascaras de digitacao (Column2/Column5 no dump)
            .Column2.InputMask = "999,999,999.99"
            .Column5.InputMask = "999.9999"

            *-- Larguras DEPOIS do RecordSource (ele as reseta para o default)
            .Column1.Width = 94
            .Column2.Width = 108
            .Column3.Width = 80
            .Column4.Width = 33
            .Column5.Width = 74

            *-- Ordem VISUAL das colunas: Cond.Pagto / Valor / Moe / Cotacao /
            *-- Vencimento (Column3 por ultimo), igual ao SCX
            .Column3.ColumnOrder = 5
            .Column4.ColumnOrder = 3
            .Column5.ColumnOrder = 4

            .Column1.Movable   = .F.
            .Column1.Resizable = .F.
            .Column2.Movable   = .F.
            .Column2.Resizable = .F.
            .Column3.Movable   = .F.
            .Column3.Resizable = .F.
            .Column4.Movable   = .F.
            .Column4.Resizable = .F.
            .Column5.Movable   = .F.
            .Column5.Resizable = .F.

            *-- Column1 (Cond. Pagto) eh a unica ReadOnly no legado: o codigo
            *-- da forma de pagamento entra pelo Get_fpg do cabecalho, nunca
            *-- digitado na grade. Column4 (moeda) e Column5 (cotfpg) tambem
            *-- sao ReadOnly: Grade.moeda.Text1.When e Grade.cotfpg.Text1.When
            *-- do legado retornam .F. sempre - moeda/cotacao da parcela vem
            *-- de fweditdata_venc.Valid (Fase 8), nunca digitadas na grade.
            *-- Valor (Column2) e Vencimento (Column3) seguem o modo do
            *-- dialogo (Grade.valor.Text1.When / Grade.venc.Text1.When =
            *-- InList(op_escolha,'INSERIR','ALTERAR')) - como o modo nao
            *-- muda durante a vida do dialogo, resolve-se uma vez aqui.
            *-- ReadOnly das colunas DEPOIS do ReadOnly do grid, que propaga
            *-- (regra #18).
            LOCAL loc_lEditavel
            loc_lEditavel = INLIST(ALLTRIM(UPPER(THIS.this_cOpEscolha)), "INSERIR", "ALTERAR")

            .Column1.ReadOnly = .T.
            .Column2.ReadOnly = !loc_lEditavel
            .Column3.ReadOnly = !loc_lEditavel
            .Column4.ReadOnly = .T.
            .Column5.ReadOnly = .T.

            *-- Text1 de cada celula (SIGOPFPG.Grade.<coluna>.Text1 no dump)
            .Column1.Text1.FontName    = "Courier New"
            .Column1.Text1.BorderStyle = 0
            .Column1.Text1.Margin      = 0
            .Column1.Text1.ReadOnly    = .T.
            .Column1.Text1.ForeColor   = RGB(0, 0, 0)
            .Column1.Text1.BackColor   = RGB(255, 255, 255)

            .Column2.Text1.FontName    = "Courier New"
            .Column2.Text1.BorderStyle = 0
            .Column2.Text1.Margin      = 0
            .Column2.Text1.ReadOnly    = .F.
            .Column2.Text1.ForeColor   = RGB(0, 0, 0)
            .Column2.Text1.BackColor   = RGB(255, 255, 255)

            .Column3.Text1.FontName    = "Courier New"
            .Column3.Text1.BorderStyle = 0
            .Column3.Text1.Margin      = 0
            .Column3.Text1.ReadOnly    = .F.
            .Column3.Text1.ForeColor   = RGB(0, 0, 0)
            .Column3.Text1.BackColor   = RGB(255, 255, 255)

            .Column4.Text1.FontName    = "Courier New"
            .Column4.Text1.BorderStyle = 0
            .Column4.Text1.Margin      = 0
            .Column4.Text1.ForeColor   = RGB(0, 0, 0)
            .Column4.Text1.BackColor   = RGB(255, 255, 255)

            .Column5.Text1.FontName    = "Courier New"
            .Column5.Text1.BorderStyle = 0
            .Column5.Text1.Margin      = 0
            .Column5.Text1.ReadOnly    = .F.
            .Column5.Text1.ForeColor   = RGB(0, 0, 0)
            .Column5.Text1.BackColor   = RGB(255, 255, 255)

            *-- Headers por ULTIMO: RecordSource reseta Header1.Caption
            .Column1.Header1.FontName  = "Tahoma"
            .Column1.Header1.FontSize  = 8
            .Column1.Header1.Alignment = 2
            .Column1.Header1.Caption   = "Cond. Pagto"

            .Column2.Header1.FontName  = "Tahoma"
            .Column2.Header1.FontSize  = 8
            .Column2.Header1.Alignment = 2
            .Column2.Header1.Caption   = "Valor"

            .Column3.Header1.FontName  = "Tahoma"
            .Column3.Header1.FontSize  = 8
            .Column3.Header1.Alignment = 2
            .Column3.Header1.Caption   = "Vencimento"

            .Column4.Header1.FontName  = "Tahoma"
            .Column4.Header1.FontSize  = 8
            .Column4.Header1.Alignment = 2
            .Column4.Header1.Caption   = "Moe"

            .Column5.Header1.FontName  = "Tahoma"
            .Column5.Header1.FontSize  = 8
            .Column5.Header1.Alignment = 2
            .Column5.Header1.Caption   = "Cota" + CHR(231) + CHR(227) + "o"
        ENDWITH

        *-- Celulas de Valor/Vencimento validam no PROPRIO Valid - regra #46:
        *-- NUNCA em AfterRowColChange (nColIndex ali eh a coluna de DESTINO).
        *-- BINDEVENT em Valid de TextBox de Column nao eh confiavel - por
        *-- isso o Valid mora na CLASSE (TextBoxCelulaValorFpg/
        *-- TextBoxCelulaVencFpg, declaradas no topo deste arquivo), nao em
        *-- BINDEVENT. Guard PEMSTATUS: VincularGrade eh reexecutavel
        *-- (CarregarDados chama de novo) e AddObject sobre objeto existente
        *-- estoura "already exists".
        WITH THIS.grd_4c_Dados
            IF !PEMSTATUS(.Column2, "txt_4c_CelulaValor", 5)
                .Column2.AddObject("txt_4c_CelulaValor", "TextBoxCelulaValorFpg")
            ENDIF
            .Column2.txt_4c_CelulaValor.this_oForm = THIS
            .Column2.CurrentControl                = "txt_4c_CelulaValor"
            .Column2.Sparse                        = .F.

            IF !PEMSTATUS(.Column3, "txt_4c_CelulaVenc", 5)
                .Column3.AddObject("txt_4c_CelulaVenc", "TextBoxCelulaVencFpg")
            ENDIF
            .Column3.txt_4c_CelulaVenc.this_oForm = THIS
            .Column3.CurrentControl                = "txt_4c_CelulaVenc"
            .Column3.Sparse                        = .F.

            *-- Column.ReadOnly DEPOIS do CurrentControl, que tambem propaga
            *-- (regra #18) - reaplica o estado de modo calculado acima.
            .Column2.ReadOnly = !loc_lEditavel
            .Column3.ReadOnly = !loc_lEditavel
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - FUNIL de carga/repintura da grade de formas de pagamento.
    * Transcreve o `.refresh` do bloco With ThisForm.Grade e o `Select xPar /
    * Go Top` com que o Init legado termina.
    *
    * Metodo UNICO chamado por TODO caminho que mexe nas linhas da grade: a
    * montagem inicial (ConfigurarEstruturaBase), e nas fases de eventos o
    * Apaga (Select xPar / Zap), o Valor.Valid e o fweditdata_Venc.Valid que
    * gera as parcelas. Sem o GO TOP + Refresh a grade fica visualmente vazia
    * com o cursor cheio e o sintoma parece falha de consulta (regra #21).
    *
    * Metodo PUBLIC: eh chamado de fora da classe pelo harness de teste
    * automatico (regra #3) e pelos handlers das fases seguintes.
    *
    * RETURN unico, FORA do TRY/CATCH, com flag (regra #1).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDados()
        LOCAL loc_lSucesso, loc_cCursor, loc_oErro
        loc_lSucesso = .F.
        loc_cCursor  = THIS.this_cCursorGrade

        TRY
            *-- Garante cursor + vinculo: o rebind reaplica largura, fonte e
            *-- caption, que o RecordSource reseta
            THIS.VincularGrade()

            *-- `Select xPar / Go Top` do fim do Init legado
            SELECT (loc_cCursor)
            GO TOP

            *-- `.refresh` do bloco With ThisForm.Grade legado
            THIS.grd_4c_Dados.Refresh()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao carregar formas de pagamento")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ultima linha de botao do Init legado:
    *   ThisForm.Apaga.Visible = Inlist( ThisForm.Op_Escolha, 'INSERIR', 'ALTERAR' )
    *
    * Em CONSULTAR/EXCLUIR o legado ESCONDE o Apagar - so os modos de edicao
    * podem zerar a distribuicao de formas de pagamento (o Apaga.Click legado
    * repete a mesma guarda `If Inlist(...)`). Ok e Cancela nao tem regra de
    * modo: o unico bloco que mexia neles por llAltDireta esta comentado
    * (`*!*`) no SCX.
    *
    * Roda DEPOIS de TornarControlesVisiveis, que forca Visible=.T. em todos os
    * controles criados por AddObject e apagaria esta regra.
    *
    * Metodo PUBLIC: chamado de fora da classe pelo harness de teste
    * automatico (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        THIS.cmd_4c_Apaga.Visible = INLIST(ALLTRIM(UPPER(THIS.this_cOpEscolha)), ;
                                           "INSERIR", "ALTERAR")
    ENDPROC

    *--------------------------------------------------------------------------
    * OcultarCamposCondicionais - Reaplica o Visible = .F. dos controles que
    * o dump do SCX ja nasce ocultos (Say_Cotacao/Get_COTACAO/alteracotacao -
    * bloco de alteracao manual de cotacao; SayObs/GetObs - observacao livre,
    * so aparece quando CrSigOpFp.Obs = 1). TornarControlesVisiveis forca
    * Visible = .T. em TODO controle criado por AddObject, entao esses quatro
    * tem de ser reescondidos DEPOIS dele - mesmo padrao de
    * AjustarBotoesPorModo()/cmd_4c_Apaga.
    *
    * A alternancia real (mostrar quando o usuario clica "C$" ou quando o
    * registro tem Obs = 1) esta em MostrarObservacao (Fase 7); aqui o estado
    * INICIAL, igual ao SCX, eh preservado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE OcultarCamposCondicionais()
        THIS.lbl_4c__Cotacao.Visible       = .F.
        THIS.txt_4c_COTACAO.Visible        = .F.
        THIS.cmd_4c_Alteracotacao.Visible  = .F.
        THIS.lbl_4c_Obs.Visible            = .F.
        THIS.obj_4c_GetObs.Visible         = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - Botoes Apaga/Ok/Cancela (SIGOPFPG.Apaga/Ok/Cancela
    * no legado). Adicionados DIRETO no form (sem container, igual ao dump),
    * DEPOIS de ConfigurarCabecalho/ConfigurarDecoracao para desenhar por
    * cima de cnt_4c_Sombra - Top=3 cai DENTRO da faixa (Top=0..80, regra
    * #11 do CLAUDE.md). Picture/Caption/ToolTipText/Cancel transcritos do
    * dump; Width/Height=75 com Lefts em incrementos de 75 (575/650/725),
    * igual ao padrao canonico dos botoes CRUD do framework.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmd_4c_Apaga", "CommandButton")
        WITH THIS.cmd_4c_Apaga
            .Top             = 3
            .Left            = 575
            .Width           = 75
            .Height          = 75
            .Caption         = "Apagar"
            .ToolTipText     = "Apagar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .Themes          = .T.
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_Ok", "CommandButton")
        WITH THIS.cmd_4c_Ok
            .Top             = 3
            .Left            = 650
            .Width           = 75
            .Height          = 75
            .Caption         = "\<Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .Themes          = .T.
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_Cancela", "CommandButton")
        WITH THIS.cmd_4c_Cancela
            .Top             = 3
            .Left            = 725
            .Width           = 75
            .Height          = 75
            .Cancel          = .T.
            .Caption         = "Cancelar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .Themes          = .T.
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaineisFlutuantes (FASE 6/8) - Os 5 paineis que o legado
    * alterna por Visible conforme a forma de pagamento escolhida (metodo
    * MostraObs/mCartaoCred do SCX): CntCCred/CntCCredFP (cartao de credito),
    * CntCarneFP (carne), CntOutrosFP (observacao livre) e CntChequeFP
    * (dados do cheque). Todos nascem Visible=.F. - igual ao dump - e a
    * alternancia real esta em MostrarObservacao/CartaoCredito. A que preserva
    * esse Visible=.F. depois de TornarControlesVisiveis esta em
    * TornarControlesVisiveis() (lista de nomes CNT_4C_*).
    *
    * Propriedades e posicoes (Top/Left/Width/Height, fontes, InputMask,
    * ControlSource de xPar) transcritas do dump do SCX (SIGOPFPG.CntCCred /
    * CntCCredFP / CntCarneFP / CntOutrosFP / CntChequeFP). ControlSource
    * fica VAZIO aqui (igual as demais fases de puro layout) - o trafego com
    * cursor_4c_Dados (equivalente a xPar) eh assunto da Fase 8.
    *
    * CntCCred e CntCCredFP tem os MESMOS dois campos (cartao/credito) -
    * CntCCred eh o painel visivel ao usuario (mCartaoCred alterna Visible +
    * desabilita o resto do form) e CntCCredFP eh o espelho que o legado
    * mantem sempre presente para o SQL/replace de xPar (mLeDados/Ok.Click
    * leem de CntCCredFP, nao de CntCCred - ver comportamento.json). Nomes
    * de objeto distintos por painel (nunca reusar o mesmo AddObject em dois
    * containers - regra de colisao de nomes).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaineisFlutuantes()

        *-- CntCCred - cartao de credito (painel que o usuario VE) ----------
        THIS.AddObject("cnt_4c_CCred", "Container")
        WITH THIS.cnt_4c_CCred
            .Top           = 216
            .Left          = 304
            .Width         = 400
            .Height        = 74
            .SpecialEffect = 0
            .BackColor     = RGB(255, 255, 255)
            .BorderColor   = RGB(36, 84, 155)
            .TabIndex      = 12
            .Visible       = .F.
        ENDWITH

        THIS.cnt_4c_CCred.AddObject("lbl_4c_TituloCartao", "Label")
        WITH THIS.cnt_4c_CCred.lbl_4c_TituloCartao
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .Caption   = "Cart" + CHR(227) + "o Cr" + CHR(233) + "dito"
            .Left      = 4
            .Top       = 5
            .Width     = 84
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_CCred.AddObject("lbl_4c_LabelCartao", "Label")
        WITH THIS.cnt_4c_CCred.lbl_4c_LabelCartao
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .Caption   = "Cart" + CHR(227) + "o : "
            .Left      = 9
            .Top       = 39
            .Width     = 40
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_CCred.AddObject("txt_4c_Cartao", "TextBox")
        WITH THIS.cnt_4c_CCred.txt_4c_Cartao
            .FontName  = "Tahoma"
            .Value     = ""
            .Format    = "K"
            .InputMask = "99999999999999999999"
            .Left      = 53
            .Top       = 35
            .Width     = 150
            .Height    = 23
            .ForeColor = RGB(0, 0, 0)
            .TabIndex  = 13
            *-- Get_cartao.When legado: INLIST(op_escolha,'INSERIR','ALTERAR')
            .Enabled   = INLIST(ALLTRIM(UPPER(THIS.this_cOpEscolha)), "INSERIR", "ALTERAR")
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_CCred.AddObject("lbl_4c_LabelCredito", "Label")
        WITH THIS.cnt_4c_CCred.lbl_4c_LabelCredito
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .Caption   = "Cr" + CHR(233) + "dito : "
            .Left      = 218
            .Top       = 39
            .Width     = 40
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_CCred.AddObject("txt_4c_Cred", "TextBox")
        WITH THIS.cnt_4c_CCred.txt_4c_Cred
            .FontName  = "Tahoma"
            .Value     = ""
            .InputMask = "XXXXXXXXXX"
            .Left      = 264
            .Top       = 35
            .Width     = 80
            .Height    = 23
            .ForeColor = RGB(0, 0, 0)
            .TabIndex  = 14
            *-- Get_cred.When legado: vazio se Cartao vazio (comeca .F.)
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_CCred.AddObject("cmd_4c_Confirma", "CommandButton")
        WITH THIS.cnt_4c_CCred.cmd_4c_Confirma
            .Top         = 24
            .Left        = 348
            .Width       = 40
            .Height      = 40
            .FontName    = "Verdana"
            .FontSize    = 8
            .Picture     = gc_4c_CaminhoIcones + "geral_escudo_ok_32.jpg"
            .Caption     = ""
            .ToolTipText = "Confirmar"
            .ForeColor   = RGB(36, 84, 155)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .TabIndex    = 15
            .Visible     = .T.
        ENDWITH

        *-- CntCCredFP - espelho de xPar.cartaos/nocreditos (le/grava direto,
        *-- nunca visivel ao usuario - regra #30: existe sempre, sem Visible
        *-- proprio no dump, so e exibido quando mostraobs seta .Visible na
        *-- Fase 7, em MostrarObservacao) ------------------------------
        THIS.AddObject("cnt_4c_CCredFP", "Container")
        WITH THIS.cnt_4c_CCredFP
            .Top           = 462
            .Left          = 91
            .Width         = 344
            .Height        = 42
            .SpecialEffect = 0
            .BackColor     = RGB(255, 255, 255)
            .TabIndex      = 16
            .Visible       = .F.
        ENDWITH

        THIS.cnt_4c_CCredFP.AddObject("lbl_4c_LabelCartaoFp", "Label")
        WITH THIS.cnt_4c_CCredFP.lbl_4c_LabelCartaoFp
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .Caption   = "Cart" + CHR(227) + "o"
            .Left      = 10
            .Top       = 12
            .Width     = 40
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_CCredFP.AddObject("txt_4c_CartaoFp", "TextBox")
        WITH THIS.cnt_4c_CCredFP.txt_4c_CartaoFp
            *-- Espelho de xPar.cartaos - ControlSource acompanha a linha
            *-- corrente da grade, igual ao .refresh do legado depois de
            *-- `Replace cartaos With ...` (regra: so funciona porque o
            *-- controle esta LIGADO ao cursor, nao ao valor solto)
            .ControlSource = THIS.this_cCursorGrade + ".Cartaos"
            .FontName  = "Tahoma"
            .InputMask = "99999999999999999999"
            .Left      = 47
            .Top       = 8
            .Width     = 150
            .Height    = 23
            .ForeColor = RGB(0, 0, 0)
            .TabIndex  = 17
            *-- Get_cartao.When legado: INLIST(op_escolha,...) AND
            *-- carauts#'S' - refinado por AtualizarEnabledCreditoFp quando a
            *-- forma de pagamento eh escolhida
            .Enabled   = INLIST(ALLTRIM(UPPER(THIS.this_cOpEscolha)), "INSERIR", "ALTERAR")
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_CCredFP.AddObject("lbl_4c_LabelCreditoFp", "Label")
        WITH THIS.cnt_4c_CCredFP.lbl_4c_LabelCreditoFp
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .Caption   = "Credito"
            .Left      = 214
            .Top       = 12
            .Width     = 40
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_CCredFP.AddObject("txt_4c_CredFp", "TextBox")
        WITH THIS.cnt_4c_CCredFP.txt_4c_CredFp
            *-- Espelho de xPar.nocreditos (ver comentario de txt_4c_CartaoFp)
            .ControlSource = THIS.this_cCursorGrade + ".Nocreditos"
            .FontName  = "Tahoma"
            .InputMask = "XXXXXXXXXX"
            .Left      = 253
            .Top       = 8
            .Width     = 80
            .Height    = 23
            .ForeColor = RGB(0, 0, 0)
            .TabIndex  = 18
            *-- Get_cred.When legado: vazio se Cartao vazio, senao igual ao
            *-- Get_cartao.When - comeca .F. (Cartao nasce vazio)
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *-- CntCarneFP - numero do carne ------------------------------------
        THIS.AddObject("cnt_4c_CarneFP", "Container")
        WITH THIS.cnt_4c_CarneFP
            .Top           = 510
            .Left          = 197
            .Width         = 154
            .Height        = 42
            .SpecialEffect = 0
            .BackColor     = RGB(255, 255, 255)
            .TabIndex      = 19
            .Visible       = .F.
        ENDWITH

        THIS.cnt_4c_CarneFP.AddObject("lbl_4c_LabelCarne", "Label")
        WITH THIS.cnt_4c_CarneFP.lbl_4c_LabelCarne
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .Caption   = "Carne"
            .Left      = 13
            .Top       = 9
            .Width     = 30
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_CarneFP.AddObject("txt_4c_Carne", "TextBox")
        WITH THIS.cnt_4c_CarneFP.txt_4c_Carne
            *-- Espelho de xPar.ncarnes, gerado por TxtFweditdataVencLostFocus
            *-- (fGerUniqueKey) - Get_carne.When legado = Return(.F.), nunca
            *-- digitado pelo usuario
            .ControlSource = THIS.this_cCursorGrade + ".Ncarnes"
            .FontName  = "Tahoma"
            .Left      = 46
            .Top       = 6
            .Width     = 100
            .Height    = 23
            .ForeColor = RGB(0, 0, 0)
            .TabIndex  = 20
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *-- CntOutrosFP - observacao livre ----------------------------------
        THIS.AddObject("cnt_4c_OutrosFP", "Container")
        WITH THIS.cnt_4c_OutrosFP
            .Top           = 510
            .Left          = 370
            .Width         = 230
            .Height        = 42
            .SpecialEffect = 0
            .BackColor     = RGB(255, 255, 255)
            .TabIndex      = 21
            .Visible       = .F.
        ENDWITH

        THIS.cnt_4c_OutrosFP.AddObject("lbl_4c_LabelOutros", "Label")
        WITH THIS.cnt_4c_OutrosFP.lbl_4c_LabelOutros
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o"
            .Left      = 11
            .Top       = 11
            .Width     = 60
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_OutrosFP.AddObject("txt_4c_Outros", "TextBox")
        WITH THIS.cnt_4c_OutrosFP.txt_4c_Outros
            *-- Espelho de xPar.outros (observacao livre da forma "Outros")
            .ControlSource = THIS.this_cCursorGrade + ".Outros"
            .FontName  = "Tahoma"
            .Left      = 73
            .Top       = 7
            .Width     = 150
            .Height    = 23
            .ForeColor = RGB(0, 0, 0)
            .TabIndex  = 22
            *-- Get_OBS.When legado: desabilitado so em CONSULTAR/EXCLUIR -
            *-- mode fixo durante a vida do dialogo (resolvido uma vez aqui)
            .Enabled   = !INLIST(ALLTRIM(UPPER(THIS.this_cOpEscolha)), "CONSULTAR", "EXCLUIR")
            .Visible   = .T.
        ENDWITH

        *-- CntChequeFP - dados do cheque (Banco/Agencia/Conta/Numero) ------
        THIS.AddObject("cnt_4c_ChequeFP", "Container")
        WITH THIS.cnt_4c_ChequeFP
            .Top           = 462
            .Left          = 455
            .Width         = 230
            .Height        = 42
            .SpecialEffect = 0
            .BackColor     = RGB(255, 255, 255)
            .TabIndex      = 23
            .Visible       = .F.
        ENDWITH

        THIS.cnt_4c_ChequeFP.AddObject("lbl_4c_LabelBco", "Label")
        WITH THIS.cnt_4c_ChequeFP.lbl_4c_LabelBco
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .Caption   = "Bco"
            .Left      = 8
            .Top       = 1
            .Width     = 36
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_ChequeFP.AddObject("txt_4c_Bco", "TextBox")
        WITH THIS.cnt_4c_ChequeFP.txt_4c_Bco
            *-- Espelho de xPar.bancos - ControlSource acompanha a linha
            *-- corrente da grade (ver comentario de txt_4c_CartaoFp)
            .ControlSource = THIS.this_cCursorGrade + ".Bancos"
            .FontName  = "Tahoma"
            .MaxLength = 3
            .Left      = 8
            .Top       = 13
            .Width     = 36
            .Height    = 23
            .ForeColor = RGB(0, 0, 0)
            .TabIndex  = 24
            *-- Get_bco.When legado: INLIST(op_escolha,'INSERIR','ALTERAR') -
            *-- a ramificacao de leitora serial dentro do When eh so efeito
            *-- colateral (aviso), replicado em TxtBcoGotFocus
            .Enabled   = INLIST(ALLTRIM(UPPER(THIS.this_cOpEscolha)), "INSERIR", "ALTERAR")
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_ChequeFP.AddObject("lbl_4c_LabelAgencia", "Label")
        WITH THIS.cnt_4c_ChequeFP.lbl_4c_LabelAgencia
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .Caption   = "Agencia"
            .Left      = 44
            .Top       = 1
            .Width     = 38
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_ChequeFP.AddObject("txt_4c_Age", "TextBox")
        WITH THIS.cnt_4c_ChequeFP.txt_4c_Age
            *-- Espelho de xPar.agencias (ver comentario de txt_4c_Bco)
            .ControlSource = THIS.this_cCursorGrade + ".Agencias"
            .FontName  = "Tahoma"
            .MaxLength = 4
            .Left      = 45
            .Top       = 13
            .Width     = 38
            .Height    = 23
            .ForeColor = RGB(0, 0, 0)
            .TabIndex  = 25
            .Enabled   = INLIST(ALLTRIM(UPPER(THIS.this_cOpEscolha)), "INSERIR", "ALTERAR")
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_ChequeFP.AddObject("lbl_4c_LabelConta", "Label")
        WITH THIS.cnt_4c_ChequeFP.lbl_4c_LabelConta
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .Caption   = "Conta"
            .Left      = 86
            .Top       = 1
            .Width     = 80
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_ChequeFP.AddObject("txt_4c_Conta", "TextBox")
        WITH THIS.cnt_4c_ChequeFP.txt_4c_Conta
            *-- Espelho de xPar.contas (ver comentario de txt_4c_Bco)
            .ControlSource = THIS.this_cCursorGrade + ".Contas"
            .FontName  = "Tahoma"
            .MaxLength = 10
            .Left      = 85
            .Top       = 13
            .Width     = 80
            .Height    = 23
            .ForeColor = RGB(0, 0, 0)
            .TabIndex  = 26
            .Enabled   = INLIST(ALLTRIM(UPPER(THIS.this_cOpEscolha)), "INSERIR", "ALTERAR")
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_ChequeFP.AddObject("lbl_4c_LabelNumero", "Label")
        WITH THIS.cnt_4c_ChequeFP.lbl_4c_LabelNumero
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .Caption   = "Numero"
            .Left      = 166
            .Top       = 1
            .Width     = 52
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_ChequeFP.AddObject("txt_4c_Num", "TextBox")
        WITH THIS.cnt_4c_ChequeFP.txt_4c_Num
            *-- Espelho de xPar.numeros (ver comentario de txt_4c_Bco)
            .ControlSource = THIS.this_cCursorGrade + ".Numeros"
            .FontName  = "Tahoma"
            .MaxLength = 6
            .Left      = 166
            .Top       = 13
            .Width     = 52
            .Height    = 23
            .ForeColor = RGB(0, 0, 0)
            .TabIndex  = 27
            .Enabled   = INLIST(ALLTRIM(UPPER(THIS.this_cOpEscolha)), "INSERIR", "ALTERAR")
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    *  LOOKUP DA FORMA DE PAGAMENTO (Get_fpg do legado)
    *
    *  O SCX legado tem UM unico campo com lookup - Get_fpg ("Cond. Pagto") -
    *  e ele mora no Valid:
    *
    *      if lastkey()=9
    *          keyboard "{CTRL+TAB}"
    *      else
    *          If !IsEmpty( This.Value )
    *              If !Seek( This.Value, 'csSigOpFp', 'FPagsGru' )
    *                  loBrowse = CreateObject( 'fwBuscaSel', 'csSigOpFp', ...)
    *                  loBrowse.AddColuna( 'FPags',  '',   'Codigo', .t., ... )
    *                  loBrowse.AddColuna( 'FParcs', '99', 'Parc' )
    *                  loBrowse.Show
    *                  This.Value = Iif( Lastkey() == 27, '', csSigOpFp.FPags )
    *              Endif
    *              If !IsEmpty(This.Value)
    *                  =Seek( This.Value, 'crSigOpFp', 'FPags' )
    *                  ThisForm.Get_Fpg.Value      = CrSigOpFp.FPags
    *                  ThisForm.Get_NPar.Value     = CrSigOpFp.FParcs
    *                  ThisForm.Digpar             = IsEmpty( CrSigOpFp.FParcs )
    *                  ThisForm.Get_PEncargo.Value = CrSigOpFp.Encargos
    *                  ... (bloco de cotacao/cambio - Fase 8)
    *              Else
    *                  Thisform.get_npar.Value = 0
    *              EndiF
    *          Else
    *              Thisform.get_npar.Value = 0
    *          Endif
    *      Endif
    *
    *  Dois universos DIFERENTES, transcritos como dois metodos:
    *
    *    csSigOpFp (existencia + browse) - `Select * From crSigOpFp Where
    *      Inlist(crSigOpFp.Situas,"A"," ","R")` + indice FILTRADO
    *      `Index On Fpags Tag FPagsGru For !IsEmpty(grupods) .and.
    *      !IsEmpty(contads)` -> ObterFiltroFormasValidas() /
    *      ExisteFormaPagamentoValida().
    *    crSigOpFp (leitura do registro escolhido) - cursor SEM filtro
    *      nenhum -> AplicarFormaPagamento(), que por isso NAO repete o
    *      filtro do browse.
    *
    *  crSigOpFp eh um cursor GLOBAL do Fortyus que nao existe na arquitetura
    *  nova (o startup legado o pre-carregava no login), por isso os dois
    *  metodos consultam a tabela SigOpFp direto no SQL Server. O filtro
    *  transcrito eh EXATAMENTE o do dump - SigOpFp tem coluna `emps`, mas o
    *  legado NAO filtra por empresa aqui e inventar esse filtro esconderia
    *  formas de pagamento validas.
    *==========================================================================

    *--------------------------------------------------------------------------
    * ConfigurarEventosLookup - Liga os eventos do campo Get_fpg.
    *
    * "LostFocus" (nao "KeyPress" solto) eh o equivalente ao Valid do legado,
    * que roda ao SAIR do campo: um handler ligado a KeyPress que abra o picker
    * so por o campo nao estar vazio dispararia o dialogo a CADA TECLA e o
    * usuario nao conseguiria terminar de digitar o codigo (regra #47).
    * "KeyPress" tambem eh ligado, mas o handler TESTA a tecla - ENTER confirma
    * (equivale a sair do campo) e F4/F5 sao o atalho de busca direta.
    *
    * Os dois handlers sao PUBLIC: BINDEVENT ignora metodo PROTECTED em
    * silencio (regra #3).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEventosLookup()
        BINDEVENT(THIS.txt_4c_Fpg, "LostFocus", THIS, "TxtFpgLostFocus")
        BINDEVENT(THIS.txt_4c_Fpg, "KeyPress",  THIS, "TxtFpgKeyPress")

        *-- FASE 8/8 - demais campos do cabecalho e dos paineis flutuantes.
        *-- Todos em LostFocus (regra #47 - nunca BINDEVENT em Valid de
        *-- TextBox); fweditdata_venc tambem em GotFocus (pre-preenchimento
        *-- do When legado) e Get_bco idem (aviso da leitora serial).
        BINDEVENT(THIS.txt_4c_Npar,             "LostFocus", THIS, "TxtNparLostFocus")
        BINDEVENT(THIS.txt_4c_Vpar,             "LostFocus", THIS, "TxtVparLostFocus")
        BINDEVENT(THIS.txt_4c_PEncargo,         "LostFocus", THIS, "TxtPEncargoLostFocus")
        BINDEVENT(THIS.txt_4c_Porc,             "LostFocus", THIS, "TxtPorcLostFocus")
        BINDEVENT(THIS.txt_4c_Fweditdata_venc,  "GotFocus",  THIS, "TxtFweditdataVencGotFocus")
        BINDEVENT(THIS.txt_4c_Fweditdata_venc,  "LostFocus", THIS, "TxtFweditdataVencLostFocus")

        BINDEVENT(THIS.cnt_4c_CCred.txt_4c_Cartao,     "LostFocus", THIS, "TxtCartaoLostFocus")
        BINDEVENT(THIS.cnt_4c_CCredFP.txt_4c_CartaoFp, "LostFocus", THIS, "TxtCartaoFpLostFocus")
        BINDEVENT(THIS.cnt_4c_CCredFP.txt_4c_CredFp,   "LostFocus", THIS, "TxtCredFpLostFocus")

        BINDEVENT(THIS.cnt_4c_ChequeFP.txt_4c_Bco,   "GotFocus",  THIS, "TxtBcoGotFocus")
        BINDEVENT(THIS.cnt_4c_ChequeFP.txt_4c_Bco,   "LostFocus", THIS, "TxtBcoLostFocus")
        BINDEVENT(THIS.cnt_4c_ChequeFP.txt_4c_Age,   "LostFocus", THIS, "TxtAgeLostFocus")
        BINDEVENT(THIS.cnt_4c_ChequeFP.txt_4c_Conta, "LostFocus", THIS, "TxtContaLostFocus")
        BINDEVENT(THIS.cnt_4c_ChequeFP.txt_4c_Num,   "LostFocus", THIS, "TxtNumLostFocus")
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtFpgKeyPress - Handler de KeyPress de txt_4c_Fpg. SEMPRE testa a tecla
    * antes de agir (regra #47). ENTER delega ao FUNIL (que ja tem a guarda de
    * reentrancia); F4/F5 chamam o picker direto, e por isso ligam/desligam a
    * guarda em volta do proprio corpo no padrao save/restore - o funil pode
    * estar em curso quando o usuario teclar F4 de dentro do dialogo.
    *--------------------------------------------------------------------------
    PROCEDURE TxtFpgKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_lEmLookupAnt

        DO CASE
        CASE par_nKeyCode = 115 OR par_nKeyCode = 116
            *-- F4 / F5: atalho de busca direta do sistema novo
            IF !THIS.this_lEmLookup
                loc_lEmLookupAnt    = THIS.this_lEmLookup
                THIS.this_lEmLookup = .T.
                THIS.AbrirLookupFpg()
                THIS.this_lEmLookup = loc_lEmLookupAnt
            ENDIF

        CASE par_nKeyCode = 13
            *-- ENTER: equivale a sair do campo (Valid do legado)
            THIS.TxtFpgLostFocus()
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtFpgLostFocus - FUNIL do lookup. Wrapper FINO com a guarda de
    * reentrancia: FormBuscaAuxiliar eh MODAL, o Show() tira o foco do campo e
    * faz este mesmo LostFocus disparar de novo, empilhando um segundo picker.
    *
    * O corpo fica em TxtFpgLostFocusExec() justamente porque ele tem RETURN
    * antecipado: liberar a flag "no fim do corpo" a deixaria TRAVADA ligada no
    * primeiro RETURN e o lookup morreria pelo resto da vida do form (regra
    * #47). O RETURN de guarda fica FORA do TRY (regra #1) e a flag eh liberada
    * DEPOIS do ENDTRY, para valer tambem quando o CATCH dispara.
    *--------------------------------------------------------------------------
    PROCEDURE TxtFpgLostFocus()
        LOCAL loc_oErro

        IF THIS.this_lEmLookup
            RETURN
        ENDIF

        THIS.this_lEmLookup = .T.

        TRY
            THIS.TxtFpgLostFocusExec()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro na Forma de Pagamento")
        ENDTRY

        THIS.this_lEmLookup = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtFpgLostFocusExec - Corpo do Valid legado de Get_fpg.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TxtFpgLostFocusExec()
        LOCAL loc_cValor

        *-- Legado: `if lastkey()=9 / keyboard "{CTRL+TAB}" / else ...`. TAB
        *-- NAO dispara o lookup no legado - desvia para a navegacao entre
        *-- containers. O `keyboard "{CTRL+TAB}"` era troca de pagina de
        *-- PageFrame e este dialogo nao tem PageFrame, por isso so o DESVIO
        *-- (nao abrir o lookup) eh transcrito.
        IF LASTKEY() = 9
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(THIS.txt_4c_Fpg.Value)

        IF EMPTY(loc_cValor)
            *-- Legado (ramo Else de `If !IsEmpty(This.Value)`):
            *-- Thisform.get_npar.Value = 0
            THIS.LimparFormaPagamento()
            RETURN
        ENDIF

        *-- Legado: `If !Seek(This.Value,'csSigOpFp','FPagsGru')` -> browse
        THIS.this_cMensagemErro = ""

        IF THIS.ExisteFormaPagamentoValida(loc_cValor)
            THIS.AplicarFormaPagamento(loc_cValor)
        ELSE
            *-- Codigo digitado nao esta no universo do browse. O legado NAO
            *-- avisa e NAO apaga o que foi digitado: ele abre o picker, que
            *-- JA eh o feedback e usa o digitado como prefixo (regra #50).
            *-- Com erro de consulta ja reportado, nao abre o picker para nao
            *-- exibir a mesma falha duas vezes.
            IF EMPTY(THIS.this_cMensagemErro)
                THIS.AbrirLookupFpg()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupFpg - Browse de formas de pagamento (fwBuscaSel do legado
    * sobre csSigOpFp). Metodo PUBLIC: eh o atalho de F4/F5 e o ponto de
    * entrada do funil.
    *
    * Contrato do FormBuscaAuxiliar (regra #37): o Init JA tenta o match exato
    * e, achando 1 registro, marca this_lAchouRegistro - nesse caso o dialogo
    * NAO eh mostrado (abrir por cima do campo ja resolvido obrigaria o
    * usuario a dispensar um picker de uma linha).
    *
    * A selecao eh lida por Mostrar()/cCodigoSelecionado e NAO pelo cursor:
    * este form tem DataSession = 2 (privada) e o FormBuscaAuxiliar roda na
    * datasession DEFAULT, entao o cursor que ele popula nao eh visivel daqui.
    * Mostrar() faz a leitura DENTRO da datasession do picker, por isso
    * this_cCampoCodigo/this_cCampoDescricao sao preenchidos antes do Show.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupFpg()
        LOCAL loc_cValor, loc_oBusca, loc_cCodigo, loc_lPickerMostrado, loc_oErro

        loc_cValor          = ALLTRIM(THIS.txt_4c_Fpg.Value)
        loc_cCodigo         = ""
        loc_lPickerMostrado = .F.

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigOpFp", ;
                "cursor_4c_BuscaFpg", ;
                "fpags", ;
                loc_cValor, ;
                "Cadastro de Forma de Pagamento", ;
                .F., ;
                .T., ;
                THIS.ObterFiltroFormasValidas())

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.this_cCampoCodigo    = "fpags"
                loc_oBusca.this_cCampoDescricao = "descrs"

                IF loc_oBusca.this_lAchouRegistro
                    *-- Match exato resolvido pelo proprio Init (regra #37):
                    *-- nao mostra o dialogo. O codigo real (com o case e o
                    *-- padding gravados na tabela) vem do
                    *-- AplicarFormaPagamento, que releia o registro.
                    loc_cCodigo = loc_cValor
                ELSE
                    *-- Colunas do browse legado: AddColuna('FPags','','Codigo')
                    *-- + AddColuna('FParcs','99','Parc'). A descricao entra
                    *-- porque o Mostrar() do FormBuscaAuxiliar precisa do
                    *-- campo de descricao vinculado a uma coluna do grid.
                    loc_oBusca.this_nColunas = 0
                    loc_oBusca.mAddColuna("fpags",  "",   "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("fparcs", "99", "Parc")
                    loc_oBusca.mAddColuna("descrs", "",   "Descri" + CHR(231) + CHR(227) + "o")

                    loc_lPickerMostrado = .T.

                    IF loc_oBusca.Mostrar()
                        loc_cCodigo = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao abrir a busca de Forma de Pagamento")
        ENDTRY

        *-- Cursor do picker: fica na datasession dele e morre com o Release.
        *-- O fechamento aqui so age se, por configuracao de datasession, o
        *-- alias estiver visivel nesta sessao - e eh inofensivo se nao.
        IF USED("cursor_4c_BuscaFpg")
            IF CURSORGETPROP("Buffering", "cursor_4c_BuscaFpg") > 1
                TABLEREVERT(.T., "cursor_4c_BuscaFpg")
            ENDIF
            USE IN SELECT("cursor_4c_BuscaFpg")
        ENDIF

        IF !EMPTY(loc_cCodigo)
            THIS.AplicarFormaPagamento(loc_cCodigo)
        ELSE
            IF loc_lPickerMostrado
                *-- Legado: This.Value = Iif( Lastkey() == 27, '', ... ) - o
                *-- CANCELAMENTO EXPLICITO do browse limpa o campo (unico caso
                *-- em que o legado apaga o digitado - regra #50). Quando o
                *-- picker nem chegou a ser mostrado (erro de consulta), o que
                *-- o usuario digitou eh PRESERVADO.
                THIS.LimparFormaPagamento()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterFiltroFormasValidas - Fragmento WHERE que reproduz o universo do
    * browse legado (csSigOpFp): `Inlist(crSigOpFp.Situas,"A"," ","R")` do
    * SELECT mais o indice FILTRADO `For !IsEmpty(grupods) .and.
    * !IsEmpty(contads)`, que no legado restringe o que o Seek/browse alcanca.
    *
    * FONTE UNICA do filtro: ExisteFormaPagamentoValida e AbrirLookupFpg leem
    * daqui para o universo do teste de existencia e o do browse nunca
    * divergirem (digitar um codigo que o browse nao lista, ou vice-versa).
    * Sem prefixo de alias - o FormBuscaAuxiliar concatena este fragmento num
    * SELECT sobre SigOpFp sem alias.
    *--------------------------------------------------------------------------
    FUNCTION ObterFiltroFormasValidas()
        RETURN "situas IN ('A', ' ', 'R')" + ;
               " AND RTRIM(grupods) <> ''" + ;
               " AND RTRIM(contads) <> ''"
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExisteFormaPagamentoValida - Equivalente a
    * `Seek( This.Value, 'csSigOpFp', 'FPagsGru' )`: diz se o codigo digitado
    * esta no universo do browse. NAO aplica nada - quem le o registro eh
    * AplicarFormaPagamento, sobre o cursor SEM filtro (crSigOpFp).
    *
    * Falha de consulta deixa a mensagem em this_cMensagemErro para o chamador
    * nao abrir o picker em seguida e repetir o mesmo erro.
    *--------------------------------------------------------------------------
    FUNCTION ExisteFormaPagamentoValida(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste, loc_oErro

        loc_lExiste = .F.

        IF VARTYPE(par_cCodigo) != "C"
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(par_cCodigo))
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_ChkFpg")
                IF CURSORGETPROP("Buffering", "cursor_4c_ChkFpg") > 1
                    TABLEREVERT(.T., "cursor_4c_ChkFpg")
                ENDIF
                USE IN SELECT("cursor_4c_ChkFpg")
            ENDIF

            loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigOpFp" + ;
                       " WHERE RTRIM(fpags) = " + EscaparSQL(ALLTRIM(par_cCodigo)) + ;
                       " AND " + THIS.ObterFiltroFormasValidas()

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkFpg")

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro("Erro ao consultar a forma de pagamento." + CHR(13) + ;
                    THIS.this_cMensagemErro, "Erro SQL")
            ELSE
                IF USED("cursor_4c_ChkFpg")
                    SELECT cursor_4c_ChkFpg
                    IF !EOF("cursor_4c_ChkFpg")
                        loc_lExiste = (NVL(cursor_4c_ChkFpg.nExiste, 0) > 0)
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao consultar Forma de Pagamento")
        ENDTRY

        IF USED("cursor_4c_ChkFpg")
            USE IN SELECT("cursor_4c_ChkFpg")
        ENDIF

        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * AplicarFormaPagamento - Transcricao do bloco que o Valid legado executa
    * depois de resolver o codigo:
    *
    *     =Seek( This.Value, 'crSigOpFp', 'FPags' )
    *     ThisForm.Get_Fpg.Value      = CrSigOpFp.FPags
    *     ThisForm.Get_NPar.Value     = CrSigOpFp.FParcs
    *     ThisForm.Digpar             = IsEmpty( CrSigOpFp.FParcs )
    *     ThisForm.Get_PEncargo.Value = CrSigOpFp.Encargos
    *
    * crSigOpFp eh o cursor SEM filtro, por isso a consulta aqui NAO repete o
    * filtro do browse: uma forma de pagamento alcancada por outro caminho
    * continua sendo lida, igual ao legado.
    *
    * O bloco de cotacao/cambio que vem a seguir no Valid legado
    * (Get_Cotacao/Say_Cotacao/AlteraCotacao + fCarregarCambio) depende de
    * crSigCdMoe/crUsuario/crSigCdCrg e do calculo de cambio, e eh entregue na
    * Fase 8 junto com o calculo de parcelas - esta fase entrega o
    * lookup e os campos que ele resolve diretamente.
    *
    * Retorna .T. quando o registro foi encontrado e aplicado.
    *--------------------------------------------------------------------------
    FUNCTION AplicarFormaPagamento(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nParcelas, loc_oErro, ;
            loc_lMoedaCotas, loc_lCargoAltCots, loc_lCota, loc_nCotOper, loc_nCotacao

        loc_lSucesso = .F.

        IF VARTYPE(par_cCodigo) != "C"
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(par_cCodigo))
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_FpgSel")
                IF CURSORGETPROP("Buffering", "cursor_4c_FpgSel") > 1
                    TABLEREVERT(.T., "cursor_4c_FpgSel")
                ENDIF
                USE IN SELECT("cursor_4c_FpgSel")
            ENDIF

            loc_cSQL = "SELECT fpags, fparcs, encargos, moefpgs," + ;
                       " descrs, infos, obs, carauts, trocos," + ;
                       " entradas, dias, tvens, dcarts" + ;
                       " FROM SigOpFp" + ;
                       " WHERE RTRIM(fpags) = " + EscaparSQL(ALLTRIM(par_cCodigo))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FpgSel")

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro("Erro ao carregar a forma de pagamento." + CHR(13) + ;
                    THIS.this_cMensagemErro, "Erro SQL")
            ELSE
                IF USED("cursor_4c_FpgSel")
                    SELECT cursor_4c_FpgSel
                    IF !EOF("cursor_4c_FpgSel")
                        *-- numeric(2,0): chega SEMPRE numerico. IsEmpty(0) do
                        *-- legado eh .T., logo Digpar = (parcelas = 0) -
                        *-- "nao tem numero fixo de parcelas, o usuario digita".
                        loc_nParcelas = NVL(cursor_4c_FpgSel.fparcs, 0)

                        THIS.txt_4c_Fpg.Value      = ALLTRIM(NVL(cursor_4c_FpgSel.fpags, ""))
                        THIS.txt_4c_Npar.Value     = loc_nParcelas
                        THIS.txt_4c_PEncargo.Value = NVL(cursor_4c_FpgSel.encargos, 0)
                        THIS.this_lDigpar          = (loc_nParcelas = 0)

                        IF VARTYPE(THIS.this_oBusinessObject) = "O"
                            THIS.this_oBusinessObject.this_cFPags    = ALLTRIM(NVL(cursor_4c_FpgSel.fpags, ""))
                            THIS.this_oBusinessObject.this_nNPar     = loc_nParcelas
                            THIS.this_oBusinessObject.this_nPEncargo = NVL(cursor_4c_FpgSel.encargos, 0)
                            THIS.this_oBusinessObject.this_cMoedas   = ALLTRIM(NVL(cursor_4c_FpgSel.moefpgs, ""))
                            THIS.this_oBusinessObject.this_lDigpar   = THIS.this_lDigpar
                            *-- carauts eh char(1) "S"/"N" no schema: cartao de
                            *-- credito com autorizacao automatica (o When do
                            *-- Get_cred legado testa CrSigOpFp.carauts#'S').
                            THIS.this_oBusinessObject.this_lCarAuts  = ;
                                (UPPER(ALLTRIM(NVL(cursor_4c_FpgSel.carauts, ""))) == "S")
                            THIS.this_oBusinessObject.this_nEntradas = NVL(cursor_4c_FpgSel.entradas, 0)
                            THIS.this_oBusinessObject.this_nDias     = NVL(cursor_4c_FpgSel.dias, 0)
                            THIS.this_oBusinessObject.this_cTvens    = ALLTRIM(NVL(cursor_4c_FpgSel.tvens, ""))
                            THIS.this_oBusinessObject.this_cDcarts   = ALLTRIM(NVL(cursor_4c_FpgSel.dcarts, ""))
                        ENDIF

                        THIS.AtualizarEnabledCreditoFp()

                        *-- Bloco de cotacao/cambio do Valid legado (o que vinha
                        *-- depois do `ThisForm.Get_PEncargo.Value = ...`):
                        *--     =Seek( CrSigOpFp.Moefpgs, 'crSigCdMoe', 'CMoes' )
                        *--     =Seek( Padr(Alltrim(Usuar),10), 'crUsuario', 'Usuarios' )
                        *--     llCota = ((!Seek(Ccargs,'crSigCdCrg','Ccargs') Or
                        *--                AltCots#'S') And Inlist(op_escolha,...)
                        *--                And crSigCdMoe.Cotas)
                        *--     ThisForm.Get_Cotacao.Visible   = CrSigCdMoe.Cotas
                        *--     ThisForm.Say_Cotacao.Visible   = CrSigCdMoe.Cotas
                        *--     ThisForm.AlteraCotacao.Visible = llCota
                        *--     ThisForm.Get_Cotacao.Value = fCarregarCambio(...)
                        *-- crSigCdMoe/crUsuario/crSigCdCrg sao cursores globais
                        *-- do Fortyus (pre-carregados no login legado) que nao
                        *-- existem na arquitetura nova - MoedaPermiteCotacao()/
                        *-- CargoTemAltCots() consultam o SQL Server direto.
                        loc_lMoedaCotas   = THIS.MoedaPermiteCotacao(NVL(cursor_4c_FpgSel.moefpgs, ""))
                        loc_lCargoAltCots = THIS.CargoTemAltCots()
                        loc_lCota         = !loc_lCargoAltCots AND ;
                            INLIST(ALLTRIM(UPPER(THIS.this_cOpEscolha)), "INSERIR", "ALTERAR") AND ;
                            loc_lMoedaCotas

                        THIS.lbl_4c__Cotacao.Visible      = loc_lMoedaCotas
                        THIS.txt_4c_COTACAO.Visible       = loc_lMoedaCotas
                        THIS.txt_4c_COTACAO.Enabled       = loc_lCargoAltCots
                        THIS.cmd_4c_Alteracotacao.Visible = loc_lCota

                        loc_nCotOper  = THIS.CarregarCambio(THIS.txt_4c_MoeOper.Value, ;
                            THIS.this_oBusinessObject.this_dDtEnts)
                        loc_nCotacao  = THIS.CarregarCambio(NVL(cursor_4c_FpgSel.moefpgs, ""), ;
                            THIS.this_oBusinessObject.this_dDtEnts)
                        THIS.txt_4c_COTACAO.Value     = loc_nCotacao
                        THIS.this_oBusinessObject.this_nCotacao = loc_nCotacao

                        *-- Campos dependentes de Digpar/modo - When dinamico do
                        *-- legado (Get_npar/Get_vpar/fweditdata_venc/Get_PEncargo/
                        *-- GetPorc/alteracotacao), resolvido aqui porque eh
                        *-- justamente quando essas condicoes mudam de valor.
                        THIS.AtualizarCamposPorFormaPagamento()

                        THIS.Refresh()
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao carregar Forma de Pagamento")
        ENDTRY

        IF USED("cursor_4c_FpgSel")
            USE IN SELECT("cursor_4c_FpgSel")
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * LimparFormaPagamento - Estado "sem forma de pagamento escolhida".
    * Legado: `Thisform.get_npar.Value = 0` nos dois ramos Else do Valid, e
    * `This.Value = ''` quando o browse eh cancelado com ESC. Metodo UNICO
    * para os tres caminhos nao divergirem.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparFormaPagamento()
        THIS.txt_4c_Fpg.Value  = ""
        THIS.txt_4c_Npar.Value = 0
        THIS.this_lDigpar      = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_cFPags  = ""
            THIS.this_oBusinessObject.this_nNPar   = 0
            THIS.this_oBusinessObject.this_lDigpar = .F.
        ENDIF

        THIS.AtualizarCamposPorFormaPagamento()
        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarEventosBotoes (FASE 7/8) - Liga o Click dos cinco botoes do
    * dialogo aos handlers desta fase. Chamado no fim de
    * ConfigurarEstruturaBase, DEPOIS de ConfigurarBotoes (que cria Apaga/Ok/
    * Cancela), de ConfigurarCampos (cmd_4c_Alteracotacao) e de
    * ConfigurarPaineisFlutuantes (cmd_4c_Confirma, filho de cnt_4c_CCred):
    * BINDEVENT exige o objeto JA criado.
    *
    * Equivalencia com o legado, um para um:
    *   SIGOPFPG.Apaga.Click             -> CmdApagaClick
    *   SIGOPFPG.Ok.Click                -> CmdOkClick
    *   SIGOPFPG.Cancela.Click           -> CmdCancelaClick
    *   SIGOPFPG.alteracotacao.Click     -> CmdAlteraCotacaoClick
    *   SIGOPFPG.CntCCred.Confirma.Click -> CmdConfirmaCartaoClick
    *
    * Os cinco handlers sao PUBLIC (sem PROTECTED): BINDEVENT so funciona com
    * metodo PUBLIC - em metodo PROTECTED o bind falha em SILENCIO e o botao
    * nao faz nada (regra #3).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEventosBotoes()
        BINDEVENT(THIS.cmd_4c_Apaga,         "Click", THIS, "CmdApagaClick")
        BINDEVENT(THIS.cmd_4c_Ok,            "Click", THIS, "CmdOkClick")
        BINDEVENT(THIS.cmd_4c_Cancela,       "Click", THIS, "CmdCancelaClick")
        BINDEVENT(THIS.cmd_4c_Alteracotacao, "Click", THIS, "CmdAlteraCotacaoClick")

        BINDEVENT(THIS.cnt_4c_CCred.cmd_4c_Confirma, "Click", THIS, ;
                  "CmdConfirmaCartaoClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdApagaClick - SIGOPFPG.Apaga.Click do legado:
    *
    *     If Inlist( ThisForm.Op_Escolha, 'INSERIR', 'ALTERAR' )
    *         Select xPar
    *         Zap
    *         With Thisform
    *             .Get_TotForma.Value = 0
    *             .Get_Fpg.Value = ''
    *             .Get_NPar.Value = 0
    *             .Get_VPar.Value = 0
    *             .fweditdata_Venc.Value = {}
    *             .Get_PEncargo.Value = 0
    *             .Get_VEncargo.Value = 0
    *             .Get_Cotacao.Value = 0
    *         Endwith
    *         ThisForm.MostraObs
    *         ThisForm.Refresh
    *         ThisForm.Grade.Refresh
    *         ThisForm.Get_Fpg.SetFocus
    *     Endif
    *
    * A guarda de modo eh a MESMA que AjustarBotoesPorModo usa para esconder o
    * botao, e eh repetida aqui de proposito - o legado tambem a repete, porque
    * ela vale para a ACAO e nao so para o visual (o modo do form pai pode ter
    * mudado entre a abertura do dialogo e o clique).
    *
    * ZAP, nao USE IN + CREATE CURSOR: o ZAP apaga as linhas PRESERVANDO a
    * estrutura e, com ela, o RecordSource/ControlSource da grade - fechar e
    * recriar o alias deixaria a grade permanentemente vazia, sem erro e sem
    * log. E SET SAFETY eh ESCOPADO POR DATA SESSION: dentro da sessao privada
    * deste form (DataSession = 2) ele vale ON mesmo com o SET SAFETY OFF do
    * main.prg, e sem desligar aqui o ZAP abre o dialogo "Zap ... Are you
    * sure?" e CONGELA a tela (medido no VFP9).
    *
    * RETURN de guarda FORA do TRY (regra #1) e flag unica para o retorno.
    *--------------------------------------------------------------------------
    PROCEDURE CmdApagaClick()
        LOCAL loc_cCursor, loc_cSafety, loc_lSucesso, loc_oErro

        *-- Guarda de modo do proprio Click legado
        IF !INLIST(ALLTRIM(UPPER(THIS.this_cOpEscolha)), "INSERIR", "ALTERAR")
            RETURN .F.
        ENDIF

        loc_cCursor  = THIS.this_cCursorGrade
        loc_lSucesso = .F.

        TRY
            THIS.GarantirCursorDados()

            *-- `Select xPar / Zap`
            SELECT (loc_cCursor)
            loc_cSafety = SET("SAFETY")
            SET SAFETY OFF
            ZAP
            IF loc_cSafety = "ON"
                SET SAFETY ON
            ENDIF

            *-- Bloco `With Thisform ... EndWith`
            THIS.txt_4c_TotForma.Value        = 0
            THIS.txt_4c_Vpar.Value            = 0
            THIS.txt_4c_Fweditdata_venc.Value = {}
            THIS.txt_4c_PEncargo.Value        = 0
            THIS.txt_4c_VEncargo.Value        = 0
            THIS.txt_4c_COTACAO.Value         = 0

            *-- `.Get_Fpg.Value = '' / .Get_NPar.Value = 0` pelo metodo que ja
            *-- eh fonte unica desse estado (ele tambem zera this_lDigpar, que
            *-- sem forma escolhida nao tem efeito nenhum: o When de Get_npar
            *-- exige !IsEmpty(Get_fpg.Value) antes de olhar o Digpar)
            THIS.LimparFormaPagamento()

            *-- Espelho no BO dos campos que o bloco acima zerou, para Form e
            *-- BO nao divergirem depois do Apagar
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_nTotForma = 0
                THIS.this_oBusinessObject.this_nVPar     = 0
                THIS.this_oBusinessObject.this_nPEncargo = 0
                THIS.this_oBusinessObject.this_nVEncargo = 0
                THIS.this_oBusinessObject.this_nCotacao  = 0
                THIS.this_oBusinessObject.this_dVencs    = {}
                THIS.this_oBusinessObject.this_cCotUsu   = ""
            ENDIF

            THIS.this_nCotacaoAnterior = 0
            THIS.this_cCotUsu          = ""

            *-- `ThisForm.MostraObs`: sem linha na grade o codigo da forma de
            *-- pagamento fica vazio e os paineis flutuantes se recolhem
            THIS.MostrarObservacao()

            *-- `ThisForm.Refresh` + `ThisForm.Grade.Refresh`. A grade passa
            *-- pelo funil CarregarDados (GO TOP + Refresh), unico ponto que
            *-- repinta a grade depois de mexer no cursor (regra #21)
            THIS.Refresh()
            THIS.CarregarDados()

            *-- `ThisForm.Get_Fpg.SetFocus`. SetFocus em controle invisivel ou
            *-- desabilitado dispara erro de runtime, por isso o par de guardas
            IF THIS.txt_4c_Fpg.Visible AND THIS.txt_4c_Fpg.Enabled
                THIS.txt_4c_Fpg.SetFocus()
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao apagar as formas de pagamento")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdOkClick - SIGOPFPG.Ok.Click do legado:
    *
    *     If Inlist( Thisform.op_escolha, 'INSERIR', 'ALTERAR' )
    *         ** verifica se existe valor ou vencs em branco
    *         Select xPar
    *         Scan
    *             If !IsEmpty(xPar.FPags) And IsEmpty(xPar.vencs)
    *                 Messagebox( 'Vencimento Invalido !', 48, '' )
    *                 Thisform.Grade.Venc.Setfocus
    *                 Return 0
    *             Endif
    *         Endscan
    *     Endif
    *     ThisForm.Return
    *
    * A validacao SO roda em INSERIR/ALTERAR - em CONSULTAR/EXCLUIR o legado
    * fecha direto, porque nada foi digitado.
    *
    * O `Return 0` do legado aborta o clique: o dialogo NAO fecha e o foco vai
    * para a coluna Vencimento, que aqui eh a Column3 da grade (ControlSource
    * <cursor>.Vencs - a ordem VISUAL dela eh a 5a, mas o objeto eh Column3).
    * Por isso o registro corrente NAO eh restaurado quando a validacao recusa:
    * o SCAN para na linha ofensora e eh exatamente essa linha que o usuario
    * tem de corrigir. Passando a validacao, o registro de antes eh devolvido
    * (o SCAN termina em EOF).
    *
    * O fechamento (`ThisForm.Return`) fica FORA do TRY: ele esconde o form, e
    * dentro do bloco um erro posterior saltaria para o CATCH com o dialogo ja
    * fechado (regra #29).
    *--------------------------------------------------------------------------
    PROCEDURE CmdOkClick()
        LOCAL loc_cCursor, loc_nRecno, loc_lVencOk, loc_lFechar, loc_oErro

        loc_cCursor = THIS.this_cCursorGrade
        loc_lVencOk = .T.
        loc_lFechar = .F.

        TRY
            IF INLIST(ALLTRIM(UPPER(THIS.this_cOpEscolha)), "INSERIR", "ALTERAR")
                IF USED(loc_cCursor)
                    loc_nRecno = 0
                    IF RECCOUNT(loc_cCursor) > 0
                        loc_nRecno = RECNO(loc_cCursor)
                    ENDIF

                    SELECT (loc_cCursor)
                    SCAN
                        IF !EMPTY(EVALUATE(loc_cCursor + ".FPags")) AND ;
                                EMPTY(EVALUATE(loc_cCursor + ".Vencs"))
                            loc_lVencOk = .F.
                            EXIT
                        ENDIF
                    ENDSCAN

                    IF loc_lVencOk AND loc_nRecno > 0 AND ;
                            loc_nRecno <= RECCOUNT(loc_cCursor)
                        GO (loc_nRecno) IN (loc_cCursor)
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lVencOk
                loc_lFechar = .T.
            ELSE
                *-- `Messagebox( 'Vencimento Invalido !', 48, '' )` - icone 48
                *-- eh aviso de validacao, logo MsgAviso (nao MsgErro)
                MsgAviso("Vencimento Inv" + CHR(225) + "lido !")

                *-- `Thisform.Grade.Venc.Setfocus`
                THIS.grd_4c_Dados.Refresh()

                IF THIS.grd_4c_Dados.Visible AND THIS.grd_4c_Dados.Enabled ;
                        AND USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
                    THIS.grd_4c_Dados.Column3.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao confirmar as formas de pagamento")
            loc_lFechar = .F.
        ENDTRY

        *-- `ThisForm.Return`, fora do TRY
        IF loc_lFechar
            THIS.this_lConfirmado = .T.
            THIS.FecharDialogo()
        ENDIF

        RETURN loc_lFechar
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdCancelaClick - SIGOPFPG.Cancela.Click do legado:
    *
    *     Thisform.parentform.enabled = .T.
    *     Thisform.release
    *
    * Que eh exatamente o corpo do `PROCEDURE return` do legado - os dois
    * caminhos de saida (Confirmar e Cancelar) passam pelo MESMO FecharDialogo,
    * para a decisao de COMO fechar ficar num lugar so. A diferenca entre eles
    * eh this_lConfirmado, que diz ao form pai se o usuario confirmou a
    * distribuicao das formas de pagamento ou desistiu dela.
    *--------------------------------------------------------------------------
    PROCEDURE CmdCancelaClick()
        THIS.this_lConfirmado = .F.
        THIS.FecharDialogo()

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdConfirmaCartaoClick - SIGOPFPG.CntCCred.Confirma.Click do legado:
    *
    *     ThisForm.mCartaoCred( .F. )
    *     ThisForm.Grade.Valor.Text1.SetFocus
    *
    * Fecha o painel de cartao de credito - que roda "modal sobre o form":
    * enquanto esta aberto, todo o resto do dialogo fica Enabled = .F. - e
    * devolve o foco a celula Valor da grade, que aqui eh a Column2
    * (ControlSource <cursor>.Valos).
    *--------------------------------------------------------------------------
    PROCEDURE CmdConfirmaCartaoClick()
        LOCAL loc_cCursor, loc_lSucesso, loc_oErro

        loc_cCursor  = THIS.this_cCursorGrade
        loc_lSucesso = .F.

        TRY
            *-- O painel CntCCredFP (sempre oculto ao usuario) eh o espelho que
            *-- fweditdata_venc.Valid le para gravar Cartaos/Nocreditos na
            *-- parcela (regra: CntCCred eh o que o usuario digita, CntCCredFP
            *-- eh a copia que o gerador de parcelas consome - mesmo padrao do
            *-- par Get_PVenda/Get_PVen do FormProduto, memoria
            *-- "ParCtrlSrccompa"). Copiar ANTES de ocultar o painel - SO com
            *-- linha corrente no cursor, pois os dois campos sao
            *-- ControlSource da linha (sem registro, a atribuicao estoura).
            IF USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0 AND !EOF(loc_cCursor)
                THIS.cnt_4c_CCredFP.txt_4c_CartaoFp.Value = THIS.cnt_4c_CCred.txt_4c_Cartao.Value
                THIS.cnt_4c_CCredFP.txt_4c_CredFp.Value   = THIS.cnt_4c_CCred.txt_4c_Cred.Value
            ENDIF

            *-- `ThisForm.mCartaoCred( .F. )`
            THIS.CartaoCredito(.F.)

            *-- `ThisForm.Grade.Valor.Text1.SetFocus`. Sem linha na grade nao
            *-- ha celula para receber o foco, e SetFocus ali dispara erro
            IF THIS.grd_4c_Dados.Visible AND THIS.grd_4c_Dados.Enabled ;
                    AND USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
                THIS.grd_4c_Dados.Column2.SetFocus()
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao confirmar o cart" + CHR(227) + "o de cr" + CHR(233) + "dito")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdAlteraCotacaoClick - SIGOPFPG.alteracotacao.Click do legado:
    *
    *     With ThisForm
    *         .Get_VPar.Value = 0
    *         .Get_Cotacao.peantvalue = .Get_Cotacao.Value
    *         Do Form SigOpAlC With CrSigOpFp.Moefpgs, .Get_Cotacao.Value, ;
    *             crSigChLcq.DtEnts to lcRetorno
    *         If MLine( lcRetorno, 1 ) = 'OK'
    *             .Get_Cotacao.Value = Val( MLine( lcRetorno, 2 ) )
    *             .CotUsu = MLine( lcRetorno, 3 )
    *         Else
    *             .Get_Cotacao.Value = .Get_Cotacao.peantvalue
    *             .CotUsu = ''
    *         Endif
    *         .Get_VPar.SetFocus
    *     Endwith
    *
    * `peantvalue` eh property da classe fwget do Framework legado (valor
    * anterior do campo); aqui ela vira this_nCotacaoAnterior - TextBox do VFP9
    * nao tem peantvalue, e atribuir estouraria "Property PEANTVALUE is not
    * found" (regra #33).
    *
    * `Do Form ... to lcRetorno` nao abre dialogo no sistema novo: a abertura
    * canonica eh CREATEOBJECT + Show(), e o retorno eh lido da property
    * this_cRetorno do FormSigOpAlC ("OK" + CHR(13) + cotacao + CHR(13) +
    * usuario, ou "CANCELADO"). A referencia ao BO do dialogo eh guardada ANTES
    * do Show porque o FormSigOpAlC fecha com Release(), que destroi o objeto
    * mesmo havendo variavel externa apontando para ele: sem esse segundo
    * canal, o resultado da autorizacao ficaria inalcancavel e a cotacao nao
    * mudaria, sem erro nenhum. Show() FORA do TRY (regra #29) - o dialogo eh
    * modal, entao o uso inteiro dele viveria dentro do bloco.
    *
    * A moeda e a data vem de onde o legado as le: `CrSigOpFp.Moefpgs` eh a
    * moeda da forma de pagamento escolhida (guardada em this_cMoedas por
    * AplicarFormaPagamento) e `crSigChLcq.DtEnts` eh a data de entrada do
    * titulo, informada pelo form pai (this_dDtEnts).
    *
    * O guard eh o When do proprio botao (PodeAlterarCotacao): ele vale para a
    * ACAO, nao so para o visual.
    *--------------------------------------------------------------------------
    PROCEDURE CmdAlteraCotacaoClick()
        LOCAL loc_cMoeda, loc_nCotacao, loc_dData, loc_cRetorno
        LOCAL loc_oDialogo, loc_oDialogoBO, loc_lAbrir, loc_oErro

        *-- When do botao, FORA do TRY (regra #1)
        IF !THIS.PodeAlterarCotacao()
            RETURN .F.
        ENDIF

        loc_cRetorno   = ""
        loc_oDialogo   = .NULL.
        loc_oDialogoBO = .NULL.
        loc_lAbrir     = .F.
        loc_cMoeda     = ""
        loc_dData      = {}

        *-- `.Get_VPar.Value = 0` e
        *-- `.Get_Cotacao.peantvalue = .Get_Cotacao.Value`
        THIS.txt_4c_Vpar.Value     = 0
        THIS.this_nCotacaoAnterior = THIS.txt_4c_COTACAO.Value

        loc_nCotacao = THIS.txt_4c_COTACAO.Value

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_nVPar = 0

            loc_cMoeda = ALLTRIM(THIS.this_oBusinessObject.this_cMoedas)

            *-- ConverterParaData normaliza DATE/DATETIME/CHAR: a data de
            *-- entrada chega do form pai e pode vir datetime (coluna
            *-- SigChLcq.DtEnts); TTOD com DATE dispara erro 11 (regra #16)
            loc_dData  = ConverterParaData(THIS.this_oBusinessObject.this_dDtEnts)
        ENDIF

        *-- TRY cobre SO a CRIACAO do dialogo
        TRY
            loc_oDialogo = CREATEOBJECT("FormSigOpAlC", loc_cMoeda, loc_nCotacao, ;
                                        loc_dData)

            IF VARTYPE(loc_oDialogo) = "O"
                *-- Canal de retorno que sobrevive ao Release do dialogo
                IF PEMSTATUS(loc_oDialogo, "this_oBusinessObject", 5)
                    IF VARTYPE(loc_oDialogo.this_oBusinessObject) = "O"
                        loc_oDialogoBO = loc_oDialogo.this_oBusinessObject
                    ENDIF
                ENDIF

                loc_lAbrir = .T.
            ELSE
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel abrir a " + ;
                    "altera" + CHR(231) + CHR(227) + "o de cota" + CHR(231) + ;
                    CHR(227) + "o (FormSigOpAlC).", ;
                    "Altera" + CHR(231) + CHR(227) + "o de Cota" + CHR(231) + CHR(227) + "o")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Altera" + CHR(231) + CHR(227) + "o de Cota" + CHR(231) + CHR(227) + "o")
            loc_oDialogo   = .NULL.
            loc_oDialogoBO = .NULL.
            loc_lAbrir     = .F.
        ENDTRY

        *-- Show() FORA do TRY: modal, so retorna quando o usuario confirma ou
        *-- cancela a autorizacao
        IF loc_lAbrir
            loc_oDialogo.Show()
        ENDIF

        IF loc_lAbrir
            TRY
                *-- 1) property do form, enquanto ele existir
                IF VARTYPE(loc_oDialogo) = "O"
                    IF PEMSTATUS(loc_oDialogo, "this_cRetorno", 5)
                        loc_cRetorno = NVL(loc_oDialogo.this_cRetorno, "")
                    ENDIF
                ENDIF

                *-- 2) BO do dialogo - canal que sobrevive ao Release dele
                IF EMPTY(loc_cRetorno) AND VARTYPE(loc_oDialogoBO) = "O"
                    loc_cRetorno = NVL(loc_oDialogoBO.this_cRetorno, "")
                ENDIF

                *-- `If MLine( lcRetorno, 1 ) = 'OK'`
                IF UPPER(ALLTRIM(MLINE(loc_cRetorno, 1))) = "OK"
                    THIS.txt_4c_COTACAO.Value = VAL(MLINE(loc_cRetorno, 2))
                    THIS.this_cCotUsu         = ALLTRIM(MLINE(loc_cRetorno, 3))
                ELSE
                    *-- Cancelado: volta o valor anterior (peantvalue) e apaga o
                    *-- indicador de cotacao autorizada
                    THIS.txt_4c_COTACAO.Value = THIS.this_nCotacaoAnterior
                    THIS.this_cCotUsu         = ""
                ENDIF

                IF VARTYPE(THIS.this_oBusinessObject) = "O"
                    THIS.this_oBusinessObject.this_nCotacao = THIS.txt_4c_COTACAO.Value
                    THIS.this_oBusinessObject.this_cCotUsu  = THIS.this_cCotUsu
                ENDIF

                *-- O dialogo fecha com Release e se destroi sozinho; sobrando
                *-- referencia viva, a liberacao eh de quem abriu
                IF VARTYPE(loc_oDialogo) = "O"
                    loc_oDialogo.Release()
                ENDIF

                loc_oDialogo   = .NULL.
                loc_oDialogoBO = .NULL.

                THIS.Refresh()

                *-- `.Get_VPar.SetFocus`
                IF THIS.txt_4c_Vpar.Visible AND THIS.txt_4c_Vpar.Enabled
                    THIS.txt_4c_Vpar.SetFocus()
                ENDIF
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
                MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Altera" + CHR(231) + CHR(227) + "o de Cota" + CHR(231) + CHR(227) + "o")
            ENDTRY
        ENDIF

        RETURN loc_lAbrir
    ENDPROC

    *--------------------------------------------------------------------------
    * PodeAlterarCotacao - When do SIGOPFPG.alteracotacao do legado:
    *
    *     Return Inlist( ThisForm.Op_Escolha, 'INSERIR', 'ALTERAR' ) ;
    *            And !IsEmpty( Thisform.Get_fpg.Value)
    *
    * (o `And Thisform.Digpar` que vem depois esta COMENTADO no dump do SCX e
    * por isso nao entra).
    *
    * Metodo PUBLIC: o Click o consulta e o harness de teste automatico o
    * alcanca de fora (regra #3).
    *--------------------------------------------------------------------------
    FUNCTION PodeAlterarCotacao()
        RETURN INLIST(ALLTRIM(UPPER(THIS.this_cOpEscolha)), "INSERIR", "ALTERAR") ;
               AND !EMPTY(ALLTRIM(THIS.txt_4c_Fpg.Value))
    ENDFUNC

    *--------------------------------------------------------------------------
    * MostrarObservacao - `PROCEDURE mostraobs` do legado, que eh o metodo que
    * ALTERNA os paineis flutuantes conforme a forma de pagamento da LINHA
    * CORRENTE da grade:
    *
    *     lcFPag = xPar.FPags
    *     Select CrSigOpFp / Set Order To FPags / Seek lcFpag
    *     lcInfo = CrSigOpFp.Infos
    *     ThisForm.GetObs.Visible = ( CrSigOpFp.Obs = 1 )
    *     ThisForm.SayObs.Visible = ( CrSigOpFp.Obs = 1 )
    *     With Thisform.CntChequeFP
    *         .Visible = (lcInfo == 'C')
    *         If .Visible / .Get_Bco.Refresh / ... / EndIf
    *     EndWith
    *     Thisform.CntCarneFP.Visible  = (lcInfo == 'N')
    *     Thisform.CntOutrosFP.Visible = (lcInfo == 'O')
    *     With ThisForm.CntCCredFP
    *         .Visible  = (lcInfo == 'T')
    *         If .Visible / .Get_Cartao.Refresh / .Get_Cred.Refresh / EndIf
    *     EndWith
    *
    * O codigo lido eh o da LINHA CORRENTE do cursor da grade (xPar.FPags), NAO
    * o do campo Cond. Pagto do cabecalho: o usuario pode distribuir o titulo
    * em varias formas e cada linha tem a sua, entao o painel que aparece eh o
    * da linha onde ele esta.
    *
    * `Seek lcFpag` em CrSigOpFp vira CarregarInfoFormaPagamento (SELECT em
    * SigOpFp): este dialogo tem DataSession = 2 e nao alcanca os cursores da
    * sessao do form pai.
    *
    * Metodo PUBLIC: chamado pelos handlers de botao desta fase e alcancado de
    * fora pelo harness de teste automatico (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE MostrarObservacao()
        LOCAL loc_cCursor, loc_cFPag, loc_cInfo, loc_lObs

        loc_cCursor = THIS.this_cCursorGrade
        loc_cFPag   = ""

        *-- `lcFPag = xPar.FPags` (linha corrente). Cursor vazio ou em EOF nao
        *-- tem campo para ler - no legado isso equivale ao Seek que nao casa, e
        *-- o efeito eh o mesmo: nenhum painel aparece
        IF USED(loc_cCursor)
            IF RECCOUNT(loc_cCursor) > 0 AND !EOF(loc_cCursor)
                loc_cFPag = ALLTRIM(NVL(EVALUATE(loc_cCursor + ".FPags"), ""))
            ENDIF
        ENDIF

        *-- `Select CrSigOpFp / Seek lcFpag / lcInfo = CrSigOpFp.Infos`
        THIS.CarregarInfoFormaPagamento(loc_cFPag)

        loc_cInfo = ALLTRIM(UPPER(THIS.this_cInfoForma))
        loc_lObs  = THIS.this_lObsForma

        *-- `ThisForm.GetObs.Visible = ( CrSigOpFp.Obs = 1 )` e o SayObs
        THIS.obj_4c_GetObs.Visible = loc_lObs
        THIS.lbl_4c_Obs.Visible    = loc_lObs

        *-- Cheque
        THIS.cnt_4c_ChequeFP.Visible = (loc_cInfo == "C")
        IF THIS.cnt_4c_ChequeFP.Visible
            THIS.cnt_4c_ChequeFP.txt_4c_Bco.Refresh()
            THIS.cnt_4c_ChequeFP.txt_4c_Age.Refresh()
            THIS.cnt_4c_ChequeFP.txt_4c_Conta.Refresh()
            THIS.cnt_4c_ChequeFP.txt_4c_Num.Refresh()
        ENDIF

        *-- Carne e Outros (observacao livre)
        THIS.cnt_4c_CarneFP.Visible  = (loc_cInfo == "N")
        THIS.cnt_4c_OutrosFP.Visible = (loc_cInfo == "O")

        *-- Cartao de credito (o espelho que o legado mantem sempre presente -
        *-- CntCCredFP, nao o painel CntCCred do mCartaoCred)
        THIS.cnt_4c_CCredFP.Visible = (loc_cInfo == "T")
        IF THIS.cnt_4c_CCredFP.Visible
            THIS.cnt_4c_CCredFP.txt_4c_CartaoFp.Refresh()
            THIS.cnt_4c_CCredFP.txt_4c_CredFp.Refresh()
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarInfoFormaPagamento - `Select CrSigOpFp / Set Order To FPags /
    * Seek lcFpag` do mostraobs legado: resolve as duas colunas de SigOpFp que
    * decidem o que aparece na tela - `infos` (char(1): C = cheque, N = carne,
    * O = outros, T = cartao de credito) e `obs` (numeric(1,0): 1 = a forma de
    * pagamento pede observacao).
    *
    * Guarda o resultado em this_cInfoForma/this_lObsForma, as duas UNICAS
    * fontes que MostrarObservacao consulta.
    *
    * Codigo vazio (grade sem linha) limpa as duas properties e devolve .F.,
    * exatamente como o Seek que nao casa no legado.
    *
    * `obs` eh numeric(1,0) no schema, mas o mesmo valor pode chegar Logico ou
    * Caractere conforme o driver ODBC - por isso o VARTYPE antes de comparar
    * (comparar Logico com 1 estoura "Operator/operand type mismatch",
    * regra #13).
    *--------------------------------------------------------------------------
    FUNCTION CarregarInfoFormaPagamento(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_xObs, loc_oErro

        loc_lSucesso         = .F.
        THIS.this_cInfoForma = ""
        THIS.this_lObsForma  = .F.

        IF VARTYPE(par_cCodigo) != "C"
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(par_cCodigo))
            RETURN .F.
        ENDIF

        *-- Sem conexao viva (harness de teste / validacao de UI) nao ha o que
        *-- consultar, e os paineis ficam recolhidos - que eh o estado inicial
        IF TYPE("gnConnHandle") != "N"
            RETURN .F.
        ENDIF

        IF gnConnHandle <= 0
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_InfoFpg")
                IF CURSORGETPROP("Buffering", "cursor_4c_InfoFpg") > 1
                    TABLEREVERT(.T., "cursor_4c_InfoFpg")
                ENDIF
                USE IN SELECT("cursor_4c_InfoFpg")
            ENDIF

            loc_cSQL = "SELECT infos, obs FROM SigOpFp" + ;
                       " WHERE RTRIM(fpags) = " + EscaparSQL(ALLTRIM(par_cCodigo))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InfoFpg")

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro("Erro ao consultar a forma de pagamento." + CHR(13) + ;
                    THIS.this_cMensagemErro, "Erro SQL")
            ELSE
                IF USED("cursor_4c_InfoFpg")
                    SELECT cursor_4c_InfoFpg
                    IF !EOF("cursor_4c_InfoFpg")
                        THIS.this_cInfoForma = ALLTRIM(NVL(cursor_4c_InfoFpg.infos, ""))

                        loc_xObs = NVL(cursor_4c_InfoFpg.obs, 0)

                        DO CASE
                        CASE VARTYPE(loc_xObs) = "N"
                            THIS.this_lObsForma = (loc_xObs = 1)
                        CASE VARTYPE(loc_xObs) = "L"
                            THIS.this_lObsForma = loc_xObs
                        CASE VARTYPE(loc_xObs) = "C"
                            THIS.this_lObsForma = INLIST(UPPER(ALLTRIM(loc_xObs)), "S", "1")
                        OTHERWISE
                            THIS.this_lObsForma = .F.
                        ENDCASE

                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao consultar Forma de Pagamento")
            loc_lSucesso = .F.
        ENDTRY

        IF USED("cursor_4c_InfoFpg")
            USE IN SELECT("cursor_4c_InfoFpg")
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CartaoCredito - `PROCEDURE mcartaocred` do legado:
    *
    *     LParameters plVisible
    *     With ThisForm
    *         For lnI = 1 to .ControlCount
    *             .Controls(lnI).Enabled = Iif(.Controls(lnI).Name=='CntCCred', ;
    *                                          plVisible, Not plVisible)
    *         EndFor
    *         .CntCCred.Visible = plVisible
    *     EndWith
    *
    * O painel de cartao de credito eh "modal sobre o form": enquanto aberto,
    * TODOS os outros controles ficam Enabled = .F. e so ele responde;
    * fechando, a regra se inverte e o resto volta a responder. Transcricao
    * literal, inclusive essa inversao.
    *
    * O nome comparado eh o do objeto no sistema novo (cnt_4c_CCred), em UPPER
    * porque .Name devolve o nome como foi declarado. PEMSTATUS antes de
    * atribuir Enabled porque nem toda classe base tem a propriedade e
    * atribuir onde ela nao existe derruba a tela (regra #33).
    *
    * Metodo PUBLIC: chamado pelo botao Confirmar do painel, pelo evento que
    * abre o painel e pelo harness de teste automatico (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE CartaoCredito(par_lVisivel)
        LOCAL loc_lVisivel, loc_nI, loc_oObjeto

        loc_lVisivel = IIF(VARTYPE(par_lVisivel) = "L", par_lVisivel, .F.)

        FOR loc_nI = 1 TO THIS.ControlCount
            loc_oObjeto = THIS.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Enabled", 5)
                    loc_oObjeto.Enabled = IIF(UPPER(loc_oObjeto.Name) == "CNT_4C_CCRED", ;
                                              loc_lVisivel, !loc_lVisivel)
                ENDIF
            ENDIF
        ENDFOR

        THIS.cnt_4c_CCred.Visible = loc_lVisivel

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * FecharDialogo - `PROCEDURE return` do legado:
    *
    *     Thisform.parentform.enabled = .T.
    *     Thisform.release
    *
    * Fonte UNICA dos dois caminhos de saida (Confirmar e Cancelar), com UMA
    * divergencia deliberada de PILAR 3: fecha com Hide(), nao com Release().
    *
    * Medido no VFP9 e documentado no FormSigOpCot/FormBuscaAuxiliar, que fazem
    * o mesmo: Release() destroi o objeto ainda que exista variavel externa
    * apontando para ele - a referencia do chamador vira VARTYPE "X" e a
    * leitura seguinte estoura "is not an object". No legado o form pai e este
    * dialogo compartilhavam a datasession, entao o resultado era o proprio
    * cursor xPar; aqui o dialogo tem DataSession = 2 e precisa sobreviver ao
    * fechamento para o pai ler this_lConfirmado e as linhas da grade. Para o
    * usuario a tela fecha igual (PILAR 1 preservado); muda so o tempo de vida
    * do objeto, e eh o CHAMADOR quem chama Release() depois de ler.
    *
    * A reabilitacao do pai (`parentform.enabled = .T.`) acontece aqui E no
    * Destroy: aqui porque eh o que o legado faz no caminho normal, e no
    * Destroy como rede de seguranca para o fechamento por outra via.
    *
    * Metodo PUBLIC: o form pai pode fechar o dialogo por codigo e o harness de
    * teste automatico o alcanca de fora.
    *--------------------------------------------------------------------------
    PROCEDURE FecharDialogo()
        IF VARTYPE(THIS.this_oFormPai) = "O"
            IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
                THIS.this_oFormPai.Enabled = .T.
            ENDIF
        ENDIF

        THIS.Hide()

        RETURN .T.
    ENDPROC

    *==========================================================================
    *  FASE 8/8 - EVENTOS DOS CAMPOS E TRANSFERENCIA COM O FORM PAI
    *==========================================================================

    *--------------------------------------------------------------------------
    * DefinirDadosTitulo - API publica para o form PAI informar os dados do
    * titulo/movimento sendo pago, equivalente ao que o Init legado lia
    * DIRETO do cursor compartilhado `crSigChLcq` (DtEnts/ValTots/Emps): o
    * dialogo migrado tem DataSession = 2 (privada) e por isso NAO alcanca o
    * cursor do form pai (comentario de ConfigurarEstruturaBase/MostrarObservacao).
    *
    * Chamar DEPOIS de CREATEOBJECT("FormSigOpFpg", ...) e ANTES de Show():
    *
    *     loc_oDlg = CREATEOBJECT("FormSigOpFpg", THIS, SET("DataSession"), .F.)
    *     loc_oDlg.DefinirDadosTitulo(crSigChLcq.DtEnts, crSigChLcq.ValTots, crSigChLcq.Emps)
    *     loc_oDlg.Show()
    *
    * Sem esta chamada, this_dDtEnts/this_nValTots/this_cEmps ficam nos
    * defaults ({}/0/"") - CarregarCambio trata data vazia como DATE().
    *
    * Metodo PUBLIC: eh a API de integracao com o form pai (regra #3).
    *--------------------------------------------------------------------------
    FUNCTION DefinirDadosTitulo(par_dDtEnts, par_nValTots, par_cEmps)
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        IF INLIST(VARTYPE(par_dDtEnts), "D", "T")
            THIS.this_oBusinessObject.this_dDtEnts = par_dDtEnts
        ENDIF

        IF VARTYPE(par_nValTots) = "N"
            THIS.this_oBusinessObject.this_nValTots = par_nValTots
        ENDIF

        IF VARTYPE(par_cEmps) = "C"
            THIS.this_oBusinessObject.this_cEmps = ALLTRIM(par_cEmps)
        ENDIF

        THIS.AtualizarTotalFormaPagamento()

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * ResolverTipoLeitora - Transcricao do bloco do Init legado que le a
    * configuracao de leitora de cheques:
    *
    *     Select * From crSigSyCom Where Tipos = 'Leitora Cheques' Into Cursor CrCfcom
    *     TpLeChq = TpLeChqs / If IsEmpty(TpLeChq) / TpLeChq='T' / Endif
    *     Thisform.TipoLeitora = TpLeChq
    *     Thisform.AvisoPortaM/S/T.Visible conforme TpLeChq
    *     If TpLeChq='S' / Thisform.ReadComm.Configura(...) / ... / Endif
    *
    * crSigSyCom era pre-carregado pelo fLerSettings legado; a tabela
    * SigSyCom (mesma do form de configuracao FormSIGOPCPE) eh consultada
    * direto. 'T' (teclado) eh o default do legado quando a configuracao
    * esta vazia/ausente.
    *
    * ReadComm (controle OLE de porta serial) NAO existe nesta arquitetura
    * (nenhuma classe o fornece - grep confirmado em todo o projeto). Com
    * TipoLeitora = 'S' os handlers de Get_bco seguem o MESMO padrao
    * defensivo ja usado em Formsigopcim.prg (PrepararLeitoraParaFoco):
    * testam PEMSTATUS + VARTYPE(...)="O" antes de tocar em ReadComm, e caem
    * no caminho manual (digitacao do cheque) quando o objeto nao existe -
    * o que SEMPRE acontece aqui, ate que um form pai concreto injete um
    * leitor serial real.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ResolverTipoLeitora()
        LOCAL loc_cSQL, loc_nResultado, loc_cTipo, loc_oErro

        loc_cTipo = "T"

        TRY
            IF USED("cursor_4c_SyCom")
                USE IN SELECT("cursor_4c_SyCom")
            ENDIF

            loc_cSQL = "SELECT TOP 1 tplechqs FROM SigSyCom WHERE RTRIM(tipos) = " + ;
                EscaparSQL("Leitora Cheques")

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SyCom")

            IF loc_nResultado > 0 AND USED("cursor_4c_SyCom")
                SELECT cursor_4c_SyCom
                IF !EOF("cursor_4c_SyCom")
                    loc_cTipo = ALLTRIM(NVL(cursor_4c_SyCom.tplechqs, ""))
                    IF EMPTY(loc_cTipo)
                        loc_cTipo = "T"
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_cTipo = "T"
        ENDTRY

        IF USED("cursor_4c_SyCom")
            USE IN SELECT("cursor_4c_SyCom")
        ENDIF

        THIS.this_cTipoLeitora   = loc_cTipo
        THIS.this_cLeituraSerial = ""

        THIS.img_4c_AvisoPortaM.Visible = .F.
        THIS.img_4c_AvisoPortaS.Visible = .F.
        THIS.img_4c_AvisoPortaT.Visible = .F.

        IF loc_cTipo == "S"
            *-- `If ReadComm.PortaError` do legado - sem ReadComm nesta
            *-- arquitetura (ver cabecalho do metodo), o aviso correto eh o
            *-- de porta indisponivel.
            THIS.img_4c_AvisoPortaM.Visible = .T.
        ELSE
            THIS.img_4c_AvisoPortaT.Visible = .T.
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_lLeitor        = .F.
            THIS.this_oBusinessObject.this_cLeituraSerial = ""
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ResolverMoedaOperacao - `ThisForm.Get_MoeOper.Value =
    * Evaluate('crSigCdPam.MoedaCheqs')` do Init legado: moeda em que os
    * cheques/formas de pagamento sao operados, usada por CarregarCambio em
    * toda a Fase 8. crSigCdPam era pre-carregado no login (mesmo motivo de
    * CarregarCambio/MoedaPermiteCotacao); aqui vem de SigCdPam direto.
    * Sem registro, fica vazia e CarregarCambio devolve 1 (equivalencia
    * direta) - nao bloqueia o dialogo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ResolverMoedaOperacao()
        LOCAL loc_cSQL, loc_nResultado, loc_cMoeda, loc_oErro

        loc_cMoeda = ""

        TRY
            IF USED("cursor_4c_PamMoe")
                USE IN SELECT("cursor_4c_PamMoe")
            ENDIF

            loc_cSQL = "SELECT TOP 1 moedacheqs FROM SigCdPam"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PamMoe")

            IF loc_nResultado > 0 AND USED("cursor_4c_PamMoe")
                SELECT cursor_4c_PamMoe
                IF !EOF("cursor_4c_PamMoe")
                    loc_cMoeda = ALLTRIM(NVL(cursor_4c_PamMoe.moedacheqs, ""))
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_cMoeda = ""
        ENDTRY

        IF USED("cursor_4c_PamMoe")
            USE IN SELECT("cursor_4c_PamMoe")
        ENDIF

        THIS.txt_4c_MoeOper.Value = loc_cMoeda
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCambio - fCarregarCambio() do legado (SIGFUNCS.PRG, nao
    * portado - regra #27/CLAUDE.md). Devolve a cotacao da moeda na data
    * informada: a mais recente registrada em SigCdCot com data <= a
    * informada. Sem cotacao encontrada, devolve 1 (equivalencia direta) -
    * mesmo default dos BOs que ja implementam este padrao (SigReAtmBO/
    * sigopcgcBO), adaptado para SQLEXEC porque este dialogo nao tem
    * crSigCdMoe/crSigCdCot pre-carregados (DataSession propria).
    *
    * Metodo PUBLIC: usado pelas celulas de grade e pelo harness de teste.
    *--------------------------------------------------------------------------
    FUNCTION CarregarCambio(par_cMoeda, par_dData)
        LOCAL loc_cMoeda, loc_dData, loc_nCotacao, loc_cSQL, loc_nResultado, loc_oErro

        *-- par_cMoeda pode chegar NULL/nao-char vindo de controle ainda sem
        *-- valor resolvido - VARTYPE antes de ALLTRIM (regra #13/#27)
        loc_cMoeda   = IIF(VARTYPE(par_cMoeda) = "C", ALLTRIM(NVL(par_cMoeda, "")), "")
        loc_dData    = ConverterParaData(par_dData)
        loc_nCotacao = 1

        IF EMPTY(loc_cMoeda)
            RETURN 1
        ENDIF

        IF EMPTY(loc_dData)
            loc_dData = DATE()
        ENDIF

        TRY
            IF USED("cursor_4c_Cambio")
                USE IN SELECT("cursor_4c_Cambio")
            ENDIF

            loc_cSQL = "SELECT TOP 1 valos FROM SigCdCot" + ;
                " WHERE RTRIM(cmoes) = " + EscaparSQL(loc_cMoeda) + ;
                " AND datas <= " + FormatarDataSQL(loc_dData) + ;
                " ORDER BY datas DESC, horas DESC"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cambio")

            IF loc_nResultado > 0 AND USED("cursor_4c_Cambio")
                SELECT cursor_4c_Cambio
                IF !EOF("cursor_4c_Cambio") AND NVL(cursor_4c_Cambio.valos, 0) != 0
                    loc_nCotacao = cursor_4c_Cambio.valos
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_nCotacao = 1
        ENDTRY

        IF USED("cursor_4c_Cambio")
            USE IN SELECT("cursor_4c_Cambio")
        ENDIF

        RETURN loc_nCotacao
    ENDFUNC

    *--------------------------------------------------------------------------
    * MoedaPermiteCotacao - `crSigCdMoe.Cotas` do legado (cursor global
    * pre-carregado no login, inexistente nesta arquitetura - mesmo motivo
    * de CarregarCambio). SigCdMoe.cotas eh bit no SQL Server e chega ao
    * VFP ora Logico ora Numerico conforme o driver (regra #13) - testar
    * VARTYPE antes de comparar.
    *--------------------------------------------------------------------------
    FUNCTION MoedaPermiteCotacao(par_cMoeda)
        LOCAL loc_cMoeda, loc_cSQL, loc_nResultado, loc_lCotas, loc_oErro

        loc_cMoeda = ALLTRIM(NVL(par_cMoeda, ""))
        loc_lCotas = .F.

        IF EMPTY(loc_cMoeda)
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_MoeCk")
                USE IN SELECT("cursor_4c_MoeCk")
            ENDIF

            loc_cSQL = "SELECT TOP 1 cotas FROM SigCdMoe WHERE RTRIM(cmoes) = " + ;
                EscaparSQL(loc_cMoeda)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeCk")

            IF loc_nResultado > 0 AND USED("cursor_4c_MoeCk")
                SELECT cursor_4c_MoeCk
                IF !EOF("cursor_4c_MoeCk")
                    IF VARTYPE(cursor_4c_MoeCk.cotas) = "L"
                        loc_lCotas = cursor_4c_MoeCk.cotas
                    ELSE
                        loc_lCotas = (NVL(cursor_4c_MoeCk.cotas, 0) != 0)
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_lCotas = .F.
        ENDTRY

        IF USED("cursor_4c_MoeCk")
            USE IN SELECT("cursor_4c_MoeCk")
        ENDIF

        RETURN loc_lCotas
    ENDFUNC

    *--------------------------------------------------------------------------
    * CargoTemAltCots - `crUsuario`/`crSigCdCrg` do legado (cursores
    * globais pre-carregados no login, mesmo motivo acima):
    *
    *     =Seek( Padr(Alltrim(Usuar),10), 'crUsuario', 'Usuarios' )
    *     Return( Seek(crUsuario.Ccargs,'crSigCdCrg','Ccargs') And
    *             crSigCdCrg.AltCots = 'S' )
    *
    * gc_4c_UsuarioLogado substitui a global legado `Usuar` (memoria
    * "PUBLIC vars legado Fortyus").
    *--------------------------------------------------------------------------
    FUNCTION CargoTemAltCots()
        LOCAL loc_cSQL, loc_nResultado, loc_lAltCots, loc_oErro

        loc_lAltCots = .F.

        IF TYPE("gc_4c_UsuarioLogado") != "C" OR EMPTY(ALLTRIM(gc_4c_UsuarioLogado))
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_CargoCk")
                USE IN SELECT("cursor_4c_CargoCk")
            ENDIF

            loc_cSQL = "SELECT TOP 1 b.altcots" + ;
                " FROM SigCdUsu a INNER JOIN SigCdCrg b ON RTRIM(b.ccargs) = RTRIM(a.ccargs)" + ;
                " WHERE RTRIM(a.usuarios) = " + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CargoCk")

            IF loc_nResultado > 0 AND USED("cursor_4c_CargoCk")
                SELECT cursor_4c_CargoCk
                IF !EOF("cursor_4c_CargoCk")
                    loc_lAltCots = (UPPER(ALLTRIM(NVL(cursor_4c_CargoCk.altcots, ""))) == "S")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_lAltCots = .F.
        ENDTRY

        IF USED("cursor_4c_CargoCk")
            USE IN SELECT("cursor_4c_CargoCk")
        ENDIF

        RETURN loc_lAltCots
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterTrocosDaForma - `CrSigOpFp.Trocos` da forma de pagamento
    * informada (SigOpFp.trocos: numeric(1,0), 1 = desconta do total em vez
    * de somar - usado por AtualizarTotalFormaPagamento/TxtVparLostFocus/
    * TxtPorcLostFocus).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterTrocosDaForma(par_cFPags)
        LOCAL loc_cSQL, loc_nResultado, loc_nTrocos, loc_oErro

        loc_nTrocos = 0

        IF VARTYPE(par_cFPags) != "C" OR EMPTY(ALLTRIM(par_cFPags))
            RETURN 0
        ENDIF

        TRY
            IF USED("cursor_4c_TrocosCk")
                USE IN SELECT("cursor_4c_TrocosCk")
            ENDIF

            loc_cSQL = "SELECT TOP 1 trocos FROM SigOpFp WHERE RTRIM(fpags) = " + ;
                EscaparSQL(ALLTRIM(par_cFPags))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TrocosCk")

            IF loc_nResultado > 0 AND USED("cursor_4c_TrocosCk")
                SELECT cursor_4c_TrocosCk
                IF !EOF("cursor_4c_TrocosCk")
                    loc_nTrocos = NVL(cursor_4c_TrocosCk.trocos, 0)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_nTrocos = 0
        ENDTRY

        IF USED("cursor_4c_TrocosCk")
            USE IN SELECT("cursor_4c_TrocosCk")
        ENDIF

        RETURN loc_nTrocos
    ENDFUNC

    *--------------------------------------------------------------------------
    * AtualizarTotalFormaPagamento - Recalcula Get_TotForma.Value somando
    * (ou subtraindo, se Trocos=1) cada linha da grade convertida para a
    * moeda de operacao (Get_MoeOper), transcricao do bloco final do Init
    * legado E do Valid de Grade.valor.Text1 (sao o MESMO calculo, chamado
    * nos dois pontos - aqui tambem no DefinirDadosTitulo, equivalente ao
    * Init rodar ja com xPar povoado pelo form pai):
    *
    *     ctotal=0 / Select xPar / Scan
    *         =Seek( xPar.FPags, 'CrSigOpFp', 'FPags' )
    *         lnCotOper = fCarregarCambio( Get_MoeOper.Value, crSigChLcq.DtEnts )
    *         ctotal = Round( ctotal +- ( xPar.Valos * xPar.cotfpgs / lnCotOper ), 2 )
    *     Endscan
    *     ThisForm.Get_TotForma.Value = ctotal
    *
    * `CrSigOpFp.Trocos` da linha (nao da forma do cabecalho) - cada linha
    * pode ter uma forma de pagamento diferente, por isso a consulta eh POR
    * LINHA (ObterTrocosDaForma), igual ao Seek do legado.
    *
    * Metodo PUBLIC: chamado pelas celulas de grade e pelo harness de teste.
    *--------------------------------------------------------------------------
    FUNCTION AtualizarTotalFormaPagamento()
        LOCAL loc_cCursor, loc_nCotOper, loc_nCotFpgs, loc_nTotal, loc_cAliasAnt, ;
            loc_nRecnoAnt, loc_nTrocos

        loc_cCursor = THIS.this_cCursorGrade
        loc_nTotal  = 0

        IF !USED(loc_cCursor)
            THIS.txt_4c_TotForma.Value = loc_nTotal
            RETURN loc_nTotal
        ENDIF

        loc_cAliasAnt = ALIAS()
        loc_nCotOper  = THIS.CarregarCambio(THIS.txt_4c_MoeOper.Value, ;
            THIS.this_oBusinessObject.this_dDtEnts)

        SELECT (loc_cCursor)
        loc_nRecnoAnt = IIF(EOF() OR BOF(), 0, RECNO())

        *-- Loop manual (nao SCAN) - ObterTrocosDaForma abre outro cursor via
        *-- SQLEXEC e muda o workarea corrente; SCAN...ENDSCAN presume o
        *-- mesmo workarea do inicio do laco em todo SKIP/EOF() implicito,
        *-- entao o avanco e o teste de fim sao feitos aqui explicitamente,
        *-- sempre reselecionando loc_cCursor antes.
        SELECT (loc_cCursor)
        GO TOP
        DO WHILE !EOF(loc_cCursor)
            loc_nTrocos  = THIS.ObterTrocosDaForma(ALLTRIM(NVL(EVALUATE(loc_cCursor + ".FPags"), "")))
            loc_nCotFpgs = NVL(EVALUATE(loc_cCursor + ".CotFpgs"), 0)

            IF loc_nCotOper != 0
                IF loc_nTrocos = 1
                    loc_nTotal = ROUND(loc_nTotal - (EVALUATE(loc_cCursor + ".Valos") * loc_nCotFpgs / loc_nCotOper), 2)
                ELSE
                    loc_nTotal = ROUND(loc_nTotal + (EVALUATE(loc_cCursor + ".Valos") * loc_nCotFpgs / loc_nCotOper), 2)
                ENDIF
            ENDIF

            SELECT (loc_cCursor)
            SKIP
        ENDDO

        IF loc_nRecnoAnt > 0 AND loc_nRecnoAnt <= RECCOUNT(loc_cCursor)
            SELECT (loc_cCursor)
            GOTO loc_nRecnoAnt
        ENDIF

        IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
            SELECT (loc_cAliasAnt)
        ENDIF

        THIS.txt_4c_TotForma.Value = loc_nTotal
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_nTotForma = loc_nTotal
        ENDIF

        RETURN loc_nTotal
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarValorLinhaGrade - Valid de SIGOPFPG.Grade.valor.Text1:
    *
    *     If lastkey()=9
    *         Thisform.leitor=.f. / keyboard"{CTRL+TAB}"
    *     Else
    *         ctotal=0 / Select xPar / Scan ... Endscan
    *         ThisForm.Get_TotForma.Value = ctotal
    *     Endif
    *
    * O ramo TAB(9) eh o mesmo escape de navegacao do Grid nativo. Chamado
    * pela CLASSE TextBoxCelulaValorFpg (regra #46).
    *
    * Metodo PUBLIC: alcancado de OUTRO objeto (this_oForm.<metodo>), nao
    * pode ser PROTECTED.
    *--------------------------------------------------------------------------
    FUNCTION ValidarValorLinhaGrade()
        IF LASTKEY() = 9
            THIS.this_lLeitor = .F.
            KEYBOARD "{CTRL+TAB}"
        ELSE
            THIS.AtualizarTotalFormaPagamento()
        ENDIF

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarVencimentoLinhaGrade - Valid de SIGOPFPG.Grade.venc.Text1:
    *
    *     If This.Value < CrSigChLcq.DtEnts
    *         Messagebox('Vencimento nao pode ser menor que a Data da
    *                     Movimentacao...', 32, '')
    *         Return 0
    *     Endif
    *
    * This.Value (o valor JA digitado na celula, antes do REPLACE no
    * cursor - regra #46) comparado contra a data de entrada do titulo,
    * informada pelo form pai (DefinirDadosTitulo). MsgAviso no lugar de
    * Messagebox (MESSAGEBOX PROIBIDO). Retornar .F. mantem o foco na
    * celula (padrao VFP9 de Valid).
    *
    * Metodo PUBLIC: alcancado pela celula da grade (regra #46/#3).
    *--------------------------------------------------------------------------
    FUNCTION ValidarVencimentoLinhaGrade()
        LOCAL loc_oCelula, loc_dDtEnts

        loc_oCelula = THIS.grd_4c_Dados.Column3.txt_4c_CelulaVenc
        loc_dDtEnts = ConverterParaData(THIS.this_oBusinessObject.this_dDtEnts)

        IF !EMPTY(loc_dDtEnts) AND !EMPTY(loc_oCelula.Value) AND loc_oCelula.Value < loc_dDtEnts
            MsgAviso("Vencimento n" + CHR(227) + "o pode ser menor que a Data da Movimenta" + ;
                CHR(231) + CHR(227) + "o...")
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * GradeAfterRowColChange - SIGOPFPG.Grade.AfterRowColChange do legado:
    *
    *     LPARAMETERS nColIndex
    *     Thisform.mostraobs
    *     ThisForm.GetObs.Refresh
    *
    * Uso CORRETO de AfterRowColChange por regra #46 - sem filtro de
    * coluna, so recarrega o detalhe (paineis flutuantes) da linha
    * CORRENTE.
    *
    * Metodo PUBLIC: BINDEVENT exige (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE GradeAfterRowColChange(par_nColIndex)
        THIS.MostrarObservacao()
        THIS.obj_4c_GetObs.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarCamposPorFormaPagamento - Resolve dinamicamente o Enabled
    * dos campos cujo When legado depende do ESTADO (nao so do modo fixo
    * do dialogo): Get_npar/Get_vpar/fweditdata_venc/Get_PEncargo/GetPorc,
    * todos condicionados a `!IsEmpty(Thisform.Get_fpg.Value)` - e
    * Get_npar tambem a `Thisform.Digpar`. Chamado sempre que esse estado
    * muda: ao escolher uma forma de pagamento (AplicarFormaPagamento) e ao
    * limpa-la (LimparFormaPagamento).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarCamposPorFormaPagamento()
        LOCAL loc_lModoEditavel, loc_lTemForma

        loc_lModoEditavel = INLIST(ALLTRIM(UPPER(THIS.this_cOpEscolha)), "INSERIR", "ALTERAR")
        loc_lTemForma     = !EMPTY(ALLTRIM(THIS.txt_4c_Fpg.Value))

        THIS.txt_4c_Npar.Enabled            = loc_lModoEditavel AND loc_lTemForma AND THIS.this_lDigpar
        THIS.txt_4c_Vpar.Enabled            = loc_lModoEditavel AND loc_lTemForma
        THIS.txt_4c_Fweditdata_venc.Enabled = loc_lModoEditavel AND loc_lTemForma
        THIS.txt_4c_PEncargo.Enabled        = loc_lModoEditavel AND loc_lTemForma
        THIS.txt_4c_Porc.Enabled            = loc_lModoEditavel AND loc_lTemForma
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtFweditdataVencGotFocus - pre-preenchimento do When legado de
    * fweditdata_venc (a condicao de habilitacao ja esta em
    * AtualizarCamposPorFormaPagamento):
    *
    *     If IsEmpty(This.Value) And Inlist(op_escolha,'INSERIR','ALTERAR')
    *         This.Value = CrSigChLcq.DtEnts + CrSigOpFp.Entradas
    *     Endif
    *--------------------------------------------------------------------------
    PROCEDURE TxtFweditdataVencGotFocus()
        LOCAL loc_dDtEnts

        IF EMPTY(THIS.txt_4c_Fweditdata_venc.Value) AND ;
                INLIST(ALLTRIM(UPPER(THIS.this_cOpEscolha)), "INSERIR", "ALTERAR")
            loc_dDtEnts = ConverterParaData(THIS.this_oBusinessObject.this_dDtEnts)
            IF !EMPTY(loc_dDtEnts)
                THIS.txt_4c_Fweditdata_venc.Value = loc_dDtEnts + THIS.this_oBusinessObject.this_nEntradas
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtNparLostFocus - Valid de SIGOPFPG.Get_npar:
    *
    *     if IsEmpty(this.value) / Return(.F.) / endif
    *
    * Retornar .F. no legado mantem o foco no campo - via LostFocus
    * (regra #47) o equivalente eh devolver o foco explicitamente.
    *--------------------------------------------------------------------------
    PROCEDURE TxtNparLostFocus()
        IF EMPTY(THIS.txt_4c_Npar.Value) AND THIS.txt_4c_Npar.Enabled AND THIS.txt_4c_Npar.Visible
            THIS.txt_4c_Npar.SetFocus()
            RETURN .F.
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_nNPar = THIS.txt_4c_Npar.Value
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtVparLostFocus - Valid de SIGOPFPG.Get_vpar (calculo do troco
    * restante quando o usuario deixa o campo vazio/zero; so valida valor
    * negativo quando ja digitado):
    *
    *     If IsEmpty( This.Value )
    *         lnCotOper = fCarregarCambio( MoeOper, DtEnts )
    *         lnCotacao = Get_Cotacao.value
    *         If CrSigOpFp.Trocos = 1
    *             lnTroco = Round((ValTots-Get_TotForma.Value)*lnCotOper/lnCotacao,2)*(-1)
    *             If lnTroco<0 / Value=0 / Return 0 / Else / Value=lnTroco / Endif
    *         Else
    *             Value = Round( (ValTots-Get_TotForma.Value)*lnCotOper/lnCotacao, 2 )
    *         Endif
    *         If !IsEmpty(PEncargo) And !IsEmpty(Value)
    *             VEncargo = Round( Value*PEncargo/100, 2 )
    *         Else
    *             VEncargo = 0
    *         Endif
    *         VEncargo.Refresh
    *     Else
    *         If Value < 0 / Value=0 / Return 0 / Endif
    *     Endif
    *--------------------------------------------------------------------------
    PROCEDURE TxtVparLostFocus()
        LOCAL loc_nCotOper, loc_nCotacao, loc_nTroco, loc_nTrocos, loc_nValTots

        IF EMPTY(THIS.txt_4c_Vpar.Value)
            loc_nTrocos  = THIS.ObterTrocosDaForma(THIS.txt_4c_Fpg.Value)
            loc_nCotOper = THIS.CarregarCambio(THIS.txt_4c_MoeOper.Value, THIS.this_oBusinessObject.this_dDtEnts)
            loc_nCotacao = THIS.txt_4c_COTACAO.Value
            loc_nValTots = NVL(THIS.this_oBusinessObject.this_nValTots, 0)

            IF loc_nCotacao = 0
                loc_nCotacao = 1
            ENDIF

            IF loc_nTrocos = 1
                loc_nTroco = ROUND((loc_nValTots - THIS.txt_4c_TotForma.Value) * loc_nCotOper / loc_nCotacao, 2) * (-1)
                IF loc_nTroco < 0
                    THIS.txt_4c_Vpar.Value = 0
                    RETURN .F.
                ELSE
                    THIS.txt_4c_Vpar.Value = loc_nTroco
                ENDIF
            ELSE
                THIS.txt_4c_Vpar.Value = ROUND((loc_nValTots - THIS.txt_4c_TotForma.Value) * loc_nCotOper / loc_nCotacao, 2)
            ENDIF

            IF !EMPTY(THIS.txt_4c_PEncargo.Value) AND !EMPTY(THIS.txt_4c_Vpar.Value)
                THIS.txt_4c_VEncargo.Value = ROUND(THIS.txt_4c_Vpar.Value * THIS.txt_4c_PEncargo.Value / 100, 2)
            ELSE
                THIS.txt_4c_VEncargo.Value = 0
            ENDIF
            THIS.txt_4c_VEncargo.Refresh()
        ELSE
            IF THIS.txt_4c_Vpar.Value < 0
                THIS.txt_4c_Vpar.Value = 0
                RETURN .F.
            ENDIF
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_nVPar     = THIS.txt_4c_Vpar.Value
            THIS.this_oBusinessObject.this_nVEncargo = THIS.txt_4c_VEncargo.Value
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtPEncargoLostFocus - Valid de SIGOPFPG.Get_PEncargo:
    *
    *     If !IsEmpty(VPar) And !IsEmpty(This.Value)
    *         VEncargo = Round( VPar*This.Value/100, 2 )
    *     Else
    *         VEncargo = 0
    *     Endif
    *     VEncargo.Refresh
    *--------------------------------------------------------------------------
    PROCEDURE TxtPEncargoLostFocus()
        IF !EMPTY(THIS.txt_4c_Vpar.Value) AND !EMPTY(THIS.txt_4c_PEncargo.Value)
            THIS.txt_4c_VEncargo.Value = ROUND(THIS.txt_4c_Vpar.Value * THIS.txt_4c_PEncargo.Value / 100, 2)
        ELSE
            THIS.txt_4c_VEncargo.Value = 0
        ENDIF
        THIS.txt_4c_VEncargo.Refresh()

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_nPEncargo = THIS.txt_4c_PEncargo.Value
            THIS.this_oBusinessObject.this_nVEncargo = THIS.txt_4c_VEncargo.Value
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtPorcLostFocus - Valid de SIGOPFPG.GetPorc (idem Get_vpar, mas a
    * partir de um PERCENTUAL do valor total do titulo):
    *
    *     If !IsEmpty( This.Value )
    *         ... (mesmo calculo de troco/valor de Get_vpar, usando
    *              ValTots * This.Value / 100 no ramo sem troco) ...
    *         Get_VPar.Value = lnValor / Get_VPar.Refresh / VEncargo.Refresh
    *     Endif
    *--------------------------------------------------------------------------
    PROCEDURE TxtPorcLostFocus()
        LOCAL loc_nCotOper, loc_nCotacao, loc_nTrocos, loc_nValor, loc_nTroco, loc_nValTots

        IF !EMPTY(THIS.txt_4c_Porc.Value)
            loc_nTrocos  = THIS.ObterTrocosDaForma(THIS.txt_4c_Fpg.Value)
            loc_nCotOper = THIS.CarregarCambio(THIS.txt_4c_MoeOper.Value, THIS.this_oBusinessObject.this_dDtEnts)
            loc_nCotacao = THIS.txt_4c_COTACAO.Value
            loc_nValTots = NVL(THIS.this_oBusinessObject.this_nValTots, 0)

            IF loc_nCotacao = 0
                loc_nCotacao = 1
            ENDIF

            IF loc_nTrocos = 1
                loc_nTroco = ROUND((loc_nValTots - THIS.txt_4c_TotForma.Value) * loc_nCotOper / loc_nCotacao, 2) * (-1)
                IF loc_nTroco < 0
                    loc_nValor = 0
                    RETURN .F.
                ELSE
                    loc_nValor = loc_nTroco
                ENDIF
            ELSE
                loc_nValor = ROUND(loc_nValTots * THIS.txt_4c_Porc.Value / 100 * loc_nCotOper / loc_nCotacao, 2)
            ENDIF

            IF !EMPTY(THIS.txt_4c_PEncargo.Value) AND !EMPTY(loc_nValor)
                THIS.txt_4c_VEncargo.Value = ROUND(loc_nValor * THIS.txt_4c_PEncargo.Value / 100, 2)
            ELSE
                THIS.txt_4c_VEncargo.Value = 0
            ENDIF

            THIS.txt_4c_Vpar.Value = loc_nValor
            THIS.txt_4c_Vpar.Refresh()
            THIS.txt_4c_VEncargo.Refresh()

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_nVPar     = loc_nValor
                THIS.this_oBusinessObject.this_nVEncargo = THIS.txt_4c_VEncargo.Value
            ENDIF
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarFeriados - Le SigCdFer uma unica vez para this_cFeriadosCache
    * ("|AAAAMMDD|..."), mesmo padrao de SigPrCfnBO.CarregarFeriados -
    * evita um SELECT por dia dentro do laco do gerador de parcelas.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarFeriados()
        LOCAL loc_cSQL, loc_nResultado, loc_cLista, loc_oErro

        IF THIS.this_lFeriadosCarregados
            RETURN .T.
        ENDIF

        loc_cLista = "|"

        TRY
            IF USED("cursor_4c_FerLoad")
                USE IN SELECT("cursor_4c_FerLoad")
            ENDIF

            loc_cSQL = "SELECT DISTINCT datas FROM SigCdFer WHERE datas IS NOT NULL"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FerLoad")

            IF loc_nResultado > 0 AND USED("cursor_4c_FerLoad")
                SELECT cursor_4c_FerLoad
                SCAN
                    IF !ISNULL(datas) AND !EMPTY(datas)
                        loc_cLista = loc_cLista + DTOS(ConverterParaData(datas)) + "|"
                    ENDIF
                ENDSCAN
                USE IN SELECT("cursor_4c_FerLoad")
            ENDIF

            THIS.this_cFeriadosCache      = loc_cLista
            THIS.this_lFeriadosCarregados = .T.
        CATCH TO loc_oErro
            THIS.this_cFeriadosCache = "|"
        ENDTRY

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AvancarAlemDosFeriados - Transcricao do laco de feriados do
    * fweditdata_venc.Valid legado:
    *
    *     lnFer = 0 / Verd = .t.
    *     Seek Dtos(DVenc) in crSigCdFer order Datas
    *     Do While Verd .and. !Eof()
    *         lnFer = lnFer + 1 / Skip
    *         If DVenc+lnFer # crSigCdFer.Datas .or.
    *            Dow(DVenc+lnFer)=1 .or. Dow(DVenc+lnFer)=7
    *             Verd = .f.
    *         Endif
    *     Enddo
    *     DVenc = DVenc + lnFer
    *
    * O SEEK do dump busca por STRING (Dtos) num indice de coluna DATE/
    * DATETIME - combinacao que nao tem leitura inequivoca fora do VFP9 ao
    * vivo (nao reproduzivel neste pipeline). Reescrita PRESERVANDO A
    * INTENCAO do laco (confirmada pela condicao de parada identica,
    * incluindo o teste de fim de semana DENTRO do laco de feriados): andar
    * dia a dia a partir do vencimento enquanto o PROXIMO dia estiver no
    * cache de feriados (CarregarFeriados) e NAO for sabado/domingo -
    * exatamente a mesma condicao de parada do legado, sem depender da
    * semantica de SEEK string-sobre-data. Documentado por decisao, nao
    * auto-detectavel por regex (regra do CLAUDE.md sobre formula
    * ambigua/fragil do legado).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION AvancarAlemDosFeriados(par_dVencimento)
        LOCAL loc_nFer, loc_dProxima, loc_lContinua

        THIS.CarregarFeriados()

        loc_nFer      = 0
        loc_lContinua = .T.

        DO WHILE loc_lContinua
            loc_dProxima = par_dVencimento + loc_nFer + 1

            IF ("|" + DTOS(loc_dProxima) + "|") $ THIS.this_cFeriadosCache AND ;
                    DOW(loc_dProxima) != 1 AND DOW(loc_dProxima) != 7
                loc_nFer = loc_nFer + 1
            ELSE
                loc_lContinua = .F.
            ENDIF
        ENDDO

        RETURN par_dVencimento + loc_nFer
    ENDFUNC

    *--------------------------------------------------------------------------
    * TxtFweditdataVencLostFocus - Valid + LostFocus de
    * SIGOPFPG.fweditdata_venc (o gerador de parcelas - transcricao linha a
    * linha do bloco de 143 linhas do legado, regra #17):
    *
    *     If This.Value < CrSigChLcq.DtEnts And !IsEmpty(This.Value)
    *         Messagebox(...) / Return 0
    *     Endif
    *     =Seek( Get_fpg.Value, 'CrSigOpFp', 'FPags' )
    *     ndia/tven/moefpg/dcart = CrSigOpFp.dias/tvens/moefpgs/dcarts
    *     nparc = Get_npar.Value / valpar = Round((VPar+VEncargo)/nparc,2)
    *     Do While nparc > 0
    *         DVenc = DVenc + <dias de feriado consecutivos>
    *         Append Blank / Replace Parcs,Emps,Datas,Valos,moefpgs,vencs,
    *             fpags,dcarts,cotfpgs,cotusus
    *         (ultima parcela: ajusta diferenca de arredondamento)
    *         Thisform.mostraobs
    *         If fpags='CARNE' / gera Ncarnes via fGerUniqueKey / Endif
    *         If Infos='T' / mostra/le painel de cartao de credito / Endif
    *         DVenc = GoMonth(DVenci,_Parcelas) [Fixos] ou +NDia [Corridos]
    *         nparc = nparc - 1 / total = total +- (Valos*CotFpgs/CotOper)
    *     Enddo
    *     Get_TotForma.Value = total / zera campos do cabecalho
    *     ThisForm.Refresh / ThisForm.Grade.Refresh
    *
    * LostFocus legado (`wait window 'TAB para alterar valor' nowait` +
    * `Thisform.get_fpg.SetFocus`) roda SEMPRE depois do Valid no legado -
    * concatenado ao final deste MESMO handler (regra do projeto: LostFocus
    * no lugar de Valid, nunca BINDEVENT em Valid de TextBox - regra #47).
    *
    * fGerUniqueKey (CARNE) e CartaoCredito/CmdConfirmaCartaoClick (Fase 7/
    * Fase 8) ja existem. "CARNE" eh o codigo literal da forma de pagamento
    * no legado - transcrito tal qual (regra #17, nao inventar).
    *--------------------------------------------------------------------------
    PROCEDURE TxtFweditdataVencLostFocus()
        LOCAL loc_dDtEnts, loc_dVenc, loc_dVenci, loc_nParcelas, loc_nTotPar, ;
            loc_nValPar, loc_nParcs, loc_nIndiceParcela, loc_nCotOper, loc_nCotacao, ;
            loc_nTotal, loc_nTrocos, loc_nCarne, loc_cCartao, loc_cNoCredito, ;
            loc_lPrimeiroCartao, loc_cCursor, loc_oErro

        loc_cCursor = THIS.this_cCursorGrade
        loc_dDtEnts = ConverterParaData(THIS.this_oBusinessObject.this_dDtEnts)

        *-- `If This.Value < CrSigChLcq.DtEnts And !IsEmpty(This.Value)`
        IF !EMPTY(loc_dDtEnts) AND !EMPTY(THIS.txt_4c_Fweditdata_venc.Value) AND ;
                THIS.txt_4c_Fweditdata_venc.Value < loc_dDtEnts
            MsgAviso("Vencimento n" + CHR(227) + "o pode ser menor que a Data da Movimenta" + ;
                CHR(231) + CHR(227) + "o...")
            THIS.txt_4c_Fweditdata_venc.SetFocus()
            RETURN .F.
        ENDIF

        *-- Sem forma de pagamento escolhida nao ha o que gerar - o campo so
        *-- fica habilitado quando ha (AtualizarCamposPorFormaPagamento),
        *-- mas o guard fica aqui tambem por seguranca (regra de nao confiar
        *-- so no Enabled para decidir execucao de regra de negocio).
        IF EMPTY(ALLTRIM(THIS.txt_4c_Fpg.Value))
            RETURN .T.
        ENDIF

        TRY
            THIS.GarantirCursorDados()

            loc_nCotacao  = THIS.txt_4c_COTACAO.Value
            loc_nCotOper  = THIS.CarregarCambio(THIS.txt_4c_MoeOper.Value, loc_dDtEnts)
            IF loc_nCotacao = 0
                loc_nCotacao = 1
            ENDIF
            IF loc_nCotOper = 0
                loc_nCotOper = 1
            ENDIF

            loc_nParcelas = THIS.txt_4c_Npar.Value
            loc_nTotal    = THIS.txt_4c_TotForma.Value
            loc_nValPar   = ROUND((THIS.txt_4c_Vpar.Value + THIS.txt_4c_VEncargo.Value) / MAX(loc_nParcelas, 1), 2)
            loc_nTotPar   = 0
            loc_nCarne    = 0
            loc_cCartao   = ""
            loc_cNoCredito = ""

            loc_dVenc  = THIS.txt_4c_Fweditdata_venc.Value
            loc_dVenci = THIS.txt_4c_Fweditdata_venc.Value
            loc_nIndiceParcela = 1
            loc_nParcs          = 1
            loc_lPrimeiroCartao = .T.

            DO WHILE loc_nParcelas > 0
                *-- Empurra o vencimento alem de feriados consecutivos
                *-- (AvancarAlemDosFeriados - ver comentario do metodo)
                loc_dVenc = THIS.AvancarAlemDosFeriados(loc_dVenc)

                SELECT (loc_cCursor)
                APPEND BLANK
                REPLACE Parcs    WITH loc_nParcs, ;
                        Emps     WITH THIS.this_oBusinessObject.this_cEmps, ;
                        Datas    WITH loc_dDtEnts, ;
                        Valos    WITH loc_nValPar, ;
                        MoeFpgs  WITH THIS.this_oBusinessObject.this_cMoedas, ;
                        Vencs    WITH loc_dVenc, ;
                        FPags    WITH THIS.txt_4c_Fpg.Value, ;
                        Dcarts   WITH THIS.this_oBusinessObject.this_cDcarts, ;
                        CotFpgs  WITH loc_nCotacao, ;
                        Cotusus  WITH THIS.this_cCotUsu

                loc_nTotPar = loc_nTotPar + loc_nValPar

                *-- Ultima parcela: absorve a diferenca de arredondamento.
                *-- REPLACE exige nome de campo LITERAL (nao aceita
                *-- expressao de alias+campo entre parenteses) - SELECT
                *-- (loc_cCursor) ja deixou este o workarea corrente.
                IF loc_nParcelas = 1
                    IF loc_nTotPar != (THIS.txt_4c_Vpar.Value + THIS.txt_4c_VEncargo.Value)
                        SELECT (loc_cCursor)
                        REPLACE Valos WITH Valos + ;
                            ((THIS.txt_4c_Vpar.Value + THIS.txt_4c_VEncargo.Value) - loc_nTotPar)
                    ENDIF
                ENDIF

                THIS.MostrarObservacao()

                *-- `If fpags='CARNE' / gera Ncarnes via fGerUniqueKey` - codigo
                *-- literal da forma de pagamento, transcrito do legado.
                *-- Re-SELECT: MostrarObservacao/CarregarInfoFormaPagamento
                *-- pode ter mudado o workarea corrente (SQLEXEC em outro
                *-- cursor).
                IF UPPER(ALLTRIM(THIS.txt_4c_Fpg.Value)) == "CARNE"
                    IF loc_nCarne = 0
                        loc_nCarne = fGerUniqueKey("CARNE")
                    ENDIF
                    SELECT (loc_cCursor)
                    REPLACE Ncarnes WITH TRANSFORM(loc_nCarne, "@L 999999") + ;
                        "/" + TRANSFORM(loc_nIndiceParcela, "@L 9")
                    THIS.cnt_4c_CarneFP.txt_4c_Carne.Refresh()
                    loc_nIndiceParcela = loc_nIndiceParcela + 1
                ENDIF

                *-- `If CrSigOpFp.Infos='T'` - cartao de credito: na 1a
                *-- parcela mostra o painel e le o que o usuario confirmou
                *-- nele (CmdConfirmaCartaoClick copia para CntCCredFP);
                *-- nas demais, repete o mesmo cartao/credito
                IF UPPER(ALLTRIM(THIS.this_cInfoForma)) == "T"
                    IF loc_lPrimeiroCartao
                        THIS.CartaoCredito(.T.)
                        THIS.cnt_4c_CCred.Refresh()

                        loc_cCartao    = THIS.cnt_4c_CCredFP.txt_4c_CartaoFp.Value
                        loc_cNoCredito = THIS.cnt_4c_CCredFP.txt_4c_CredFp.Value
                        loc_lPrimeiroCartao = .F.
                    ELSE
                        SELECT (loc_cCursor)
                        REPLACE Cartaos WITH loc_cCartao, Nocreditos WITH loc_cNoCredito
                        THIS.cnt_4c_CCredFP.txt_4c_CartaoFp.Refresh()
                        THIS.cnt_4c_CCredFP.txt_4c_CredFp.Refresh()
                    ENDIF
                ENDIF

                SELECT (loc_cCursor)

                *-- `If TVen='F' / DVenc = GoMonth(DVenci,_Parcelas) / Else /
                *--  DVenc = DVenc + NDia / Endif`
                IF UPPER(ALLTRIM(THIS.this_oBusinessObject.this_cTvens)) == "F"
                    loc_dVenc           = GOMONTH(loc_dVenci, loc_nIndiceParcela)
                ELSE
                    loc_dVenc           = loc_dVenc + THIS.this_oBusinessObject.this_nDias
                ENDIF

                loc_nParcelas = loc_nParcelas - 1
                loc_nParcs    = loc_nParcs + 1

                loc_nTrocos = THIS.ObterTrocosDaForma(THIS.txt_4c_Fpg.Value)
                IF loc_nTrocos = 1
                    loc_nTotal = ROUND(loc_nTotal - ROUND((EVALUATE(loc_cCursor + ".Valos") * loc_nCotacao / loc_nCotOper), 2), 2)
                ELSE
                    loc_nTotal = ROUND(loc_nTotal + ROUND((EVALUATE(loc_cCursor + ".Valos") * loc_nCotacao / loc_nCotOper), 2), 2)
                ENDIF
            ENDDO

            THIS.txt_4c_TotForma.Value        = loc_nTotal
            THIS.txt_4c_Fpg.Value              = ""
            THIS.txt_4c_Npar.Value             = 0
            THIS.txt_4c_Vpar.Value             = 0
            THIS.txt_4c_Fweditdata_venc.Value  = {}
            THIS.txt_4c_PEncargo.Value         = 0
            THIS.txt_4c_VEncargo.Value         = 0
            THIS.txt_4c_COTACAO.Value          = 0
            THIS.txt_4c_COTACAO.Visible        = .F.
            THIS.lbl_4c__Cotacao.Visible       = .F.
            THIS.cmd_4c_Alteracotacao.Visible  = .F.
            THIS.txt_4c_Porc.Value             = 0

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_cFPags    = ""
                THIS.this_oBusinessObject.this_nNPar     = 0
                THIS.this_oBusinessObject.this_nVPar     = 0
                THIS.this_oBusinessObject.this_dVencs    = {}
                THIS.this_oBusinessObject.this_nPEncargo = 0
                THIS.this_oBusinessObject.this_nVEncargo = 0
                THIS.this_oBusinessObject.this_nCotacao  = 0
                THIS.this_oBusinessObject.this_nTotForma = loc_nTotal
                THIS.this_oBusinessObject.this_lDigpar   = .F.
            ENDIF
            THIS.this_lDigpar = .F.
            THIS.AtualizarCamposPorFormaPagamento()

            THIS.CarregarDados()
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao gerar parcelas")
        ENDTRY

        *-- `PROCEDURE LostFocus` do legado (sempre roda depois do Valid)
        WAIT WINDOW "TAB para alterar valor" NOWAIT
        IF THIS.txt_4c_Fpg.Visible AND THIS.txt_4c_Fpg.Enabled
            THIS.txt_4c_Fpg.SetFocus()
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtCartaoLostFocus - Valid de SIGOPFPG.CntCCred.Get_cartao:
    *
    *     If Not IsEmpty(This.Value) And Not fValidaCards(This.Value)
    *         messagebox('Numero Cartao Invalido !!',0+48,'')
    *         Return 0
    *     Endif
    *
    * Depois da validacao, reflete o When de Get_cred (so habilita quando
    * Cartao esta preenchido).
    *--------------------------------------------------------------------------
    PROCEDURE TxtCartaoLostFocus()
        IF !EMPTY(THIS.cnt_4c_CCred.txt_4c_Cartao.Value) AND ;
                !fValidaCards(THIS.cnt_4c_CCred.txt_4c_Cartao.Value)
            MsgAviso("N" + CHR(250) + "mero Cart" + CHR(227) + "o Inv" + CHR(225) + "lido !!")
            THIS.cnt_4c_CCred.txt_4c_Cartao.SetFocus()
            RETURN .F.
        ENDIF

        THIS.cnt_4c_CCred.txt_4c_Cred.Enabled = !EMPTY(THIS.cnt_4c_CCred.txt_4c_Cartao.Value) AND ;
            INLIST(ALLTRIM(UPPER(THIS.this_cOpEscolha)), "INSERIR", "ALTERAR")

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEnabledCreditoFp - When de CntCCredFP.Get_cartao/Get_cred:
    *
    *     Get_cartao.When: InList(op_escolha,...) And CrSigOpFp.CarAuts#'S'
    *     Get_cred.When:   IsEmpty(Get_Cartao.value) ? .F. :
    *                      InList(op_escolha,...) And CarAuts#'S'
    *
    * Chamado quando this_lCarAuts muda (AplicarFormaPagamento) e apos
    * editar o Cartao espelho.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarEnabledCreditoFp()
        LOCAL loc_lModoEditavel, loc_lSemAutorizacao

        loc_lModoEditavel   = INLIST(ALLTRIM(UPPER(THIS.this_cOpEscolha)), "INSERIR", "ALTERAR")
        loc_lSemAutorizacao = .T.
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_lSemAutorizacao = !THIS.this_oBusinessObject.this_lCarAuts
        ENDIF

        THIS.cnt_4c_CCredFP.txt_4c_CartaoFp.Enabled = loc_lModoEditavel AND loc_lSemAutorizacao
        THIS.cnt_4c_CCredFP.txt_4c_CredFp.Enabled   = loc_lModoEditavel AND loc_lSemAutorizacao ;
            AND !EMPTY(THIS.cnt_4c_CCredFP.txt_4c_CartaoFp.Value)
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtCartaoFpLostFocus - Valid de SIGOPFPG.CntCCredFP.Get_cartao (mesma
    * regra de fValidaCards de TxtCartaoLostFocus, aplicada ao espelho).
    *--------------------------------------------------------------------------
    PROCEDURE TxtCartaoFpLostFocus()
        IF !EMPTY(THIS.cnt_4c_CCredFP.txt_4c_CartaoFp.Value) AND ;
                !fValidaCards(THIS.cnt_4c_CCredFP.txt_4c_CartaoFp.Value)
            MsgAviso("N" + CHR(250) + "mero Cart" + CHR(227) + "o Inv" + CHR(225) + "lido !!")
            THIS.cnt_4c_CCredFP.txt_4c_CartaoFp.SetFocus()
            RETURN .F.
        ENDIF

        THIS.AtualizarEnabledCreditoFp()

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtCredFpLostFocus - SIGOPFPG.CntCCredFP.Get_cred nao tem Valid
    * proprio no dump; LostFocus devolve o foco a Valor da grade, mesmo
    * destino do Confirma do painel visivel (CmdConfirmaCartaoClick).
    *--------------------------------------------------------------------------
    PROCEDURE TxtCredFpLostFocus()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_cCursorGrade

        IF THIS.grd_4c_Dados.Visible AND THIS.grd_4c_Dados.Enabled AND ;
                USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
            THIS.grd_4c_Dados.Column2.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtNumLostFocus - Valid de SIGOPFPG.CntChequeFP.Get_num:
    *
    *     if not IsEmpty(this.value)
    *         if not fChkDigitos(xPar.numeros)
    *             messagebox('Numero Invalido !',0+48,'')
    *             Return 0
    *         endif
    *     endif
    *
    * + LostFocus (19 linhas) - dispara VerificaCheque com os 4 campos da
    * LINHA CORRENTE (ControlSource, regra do topo deste arquivo).
    *--------------------------------------------------------------------------
    PROCEDURE TxtNumLostFocus()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_cCursorGrade

        IF !EMPTY(THIS.cnt_4c_ChequeFP.txt_4c_Num.Value)
            IF !fChkDigitos(THIS.cnt_4c_ChequeFP.txt_4c_Num.Value)
                MsgAviso("N" + CHR(250) + "mero Inv" + CHR(225) + "lido !")
                THIS.cnt_4c_ChequeFP.txt_4c_Num.SetFocus()
                RETURN .F.
            ENDIF
        ENDIF

        THIS.ValidarChequeLinhaCorrente()

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtContaLostFocus - Valid de SIGOPFPG.CntChequeFP.Get_conta:
    *
    *     if not IsEmpty(this.value)
    *         if not fChkDigitos(xPar.contas)
    *             messagebox('Conta Invalida !',0+48,'')
    *             Return 0
    *         endif
    *     endif
    *--------------------------------------------------------------------------
    PROCEDURE TxtContaLostFocus()
        IF !EMPTY(THIS.cnt_4c_ChequeFP.txt_4c_Conta.Value)
            IF !fChkDigitos(THIS.cnt_4c_ChequeFP.txt_4c_Conta.Value)
                MsgAviso("Conta Inv" + CHR(225) + "lida !")
                THIS.cnt_4c_ChequeFP.txt_4c_Conta.SetFocus()
                RETURN .F.
            ENDIF
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtAgeLostFocus - Valid de SIGOPFPG.CntChequeFP.Get_age:
    *
    *     if not IsEmpty(this.value)
    *         if not fChkDigitos(xPar.agencias)
    *             messagebox('Agencia Invalida !',0+48,'')
    *             Return 0
    *         endif
    *     endif
    *--------------------------------------------------------------------------
    PROCEDURE TxtAgeLostFocus()
        IF !EMPTY(THIS.cnt_4c_ChequeFP.txt_4c_Age.Value)
            IF !fChkDigitos(THIS.cnt_4c_ChequeFP.txt_4c_Age.Value)
                MsgAviso("Agencia Inv" + CHR(225) + "lida !")
                THIS.cnt_4c_ChequeFP.txt_4c_Age.SetFocus()
                RETURN .F.
            ENDIF
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtBcoGotFocus - efeito colateral do When de SIGOPFPG.CntChequeFP.
    * Get_bco quando a leitora e serial (TipoLeitora='S'):
    *
    *     If Thisform.TipoLeitora = 'S'
    *         IF !ReadComm.Ole_Comm.PortOpen and !ReadComm.PortaError
    *             ReadComm.Ole_Comm.PortOpen = .t.
    *         ENDIF
    *         Wait Window 'Passe o cheque pela leitora !' nowait
    *     Endif
    *
    * ReadComm nao existe nesta arquitetura (ResolverTipoLeitora) - o aviso
    * "passe o cheque" so faz sentido com leitora de fato conectada.
    *--------------------------------------------------------------------------
    PROCEDURE TxtBcoGotFocus()
        IF THIS.this_cTipoLeitora == "S"
            WAIT WINDOW "Passe o cheque pela leitora !" NOWAIT
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtBcoLostFocus - Valid + LostFocus de SIGOPFPG.CntChequeFP.Get_bco.
    *
    * O Valid legado (64 linhas) trata DOIS modos de captura: leitora
    * serial (bloco de leitura caractere-a-caractere do buffer RS232, que
    * exige o ReadComm OLE inexistente nesta arquitetura - regra de
    * ResolverTipoLeitora) e digitacao manual. So o caminho manual se
    * aplica aqui: valida que o banco digitado eh todo-numerico
    * (fChkDigitos) e, no LostFocus, dispara VerificaCheque com os 4
    * campos da linha corrente.
    *--------------------------------------------------------------------------
    PROCEDURE TxtBcoLostFocus()
        IF !EMPTY(THIS.cnt_4c_ChequeFP.txt_4c_Bco.Value)
            IF !fChkDigitos(THIS.cnt_4c_ChequeFP.txt_4c_Bco.Value)
                MsgAviso("Banco Inv" + CHR(225) + "lido !")
                THIS.cnt_4c_ChequeFP.txt_4c_Bco.SetFocus()
                RETURN .F.
            ENDIF
        ENDIF

        THIS.ValidarChequeLinhaCorrente()

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarChequeLinhaCorrente - fonte unica para o LostFocus de
    * Get_bco/Get_num (ambos disparam a MESMA checagem no legado):
    *
    *     if not IsEmpty(bancos+agencias+contas+numeros)
    *         if !Thisform.VerificaCheque( bancos,agencias,contas,numeros )
    *             Replace bancos,agencias,contas,numeros With ''
    *             .get_bco.SetFocus
    *         else
    *             Thisform.Grade.Valor.Text1.SetFocus
    *         endif
    *     else
    *         Thisform.Grade.Valor.Text1.SetFocus
    *     endif
    *
    * Metodo PUBLIC: alcancado pelos dois LostFocus (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarChequeLinhaCorrente()
        LOCAL loc_cCursor, loc_cBanco, loc_cAgencia, loc_cConta, loc_cNumero

        loc_cCursor = THIS.this_cCursorGrade

        IF !USED(loc_cCursor) OR EOF(loc_cCursor)
            RETURN .T.
        ENDIF

        loc_cBanco   = ALLTRIM(NVL(EVALUATE(loc_cCursor + ".Bancos"), ""))
        loc_cAgencia = ALLTRIM(NVL(EVALUATE(loc_cCursor + ".Agencias"), ""))
        loc_cConta   = ALLTRIM(NVL(EVALUATE(loc_cCursor + ".Contas"), ""))
        loc_cNumero  = ALLTRIM(NVL(EVALUATE(loc_cCursor + ".Numeros"), ""))

        IF EMPTY(loc_cBanco + loc_cAgencia + loc_cConta + loc_cNumero)
            THIS.FocarValorDaGrade()
            RETURN .T.
        ENDIF

        IF !THIS.VerificaCheque(loc_cBanco, loc_cAgencia, loc_cConta, loc_cNumero)
            SELECT (loc_cCursor)
            REPLACE Bancos WITH "", Agencias WITH "", Contas WITH "", Numeros WITH ""
            THIS.cnt_4c_ChequeFP.txt_4c_Bco.Refresh()
            THIS.cnt_4c_ChequeFP.txt_4c_Age.Refresh()
            THIS.cnt_4c_ChequeFP.txt_4c_Conta.Refresh()
            THIS.cnt_4c_ChequeFP.txt_4c_Num.Refresh()
            THIS.cnt_4c_ChequeFP.txt_4c_Bco.SetFocus()
        ELSE
            THIS.FocarValorDaGrade()
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * FocarValorDaGrade - `Thisform.Grade.Valor.Text1.SetFocus`, repetido
    * em varios pontos do legado (CntCCred.Confirma, CntCCredFP.Get_cred.
    * LostFocus, ValidarChequeLinhaCorrente).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FocarValorDaGrade()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_cCursorGrade

        IF THIS.grd_4c_Dados.Visible AND THIS.grd_4c_Dados.Enabled AND ;
                USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
            THIS.grd_4c_Dados.Column2.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimpaChe - `PROCEDURE limpa_che` do legado:
    *
    *     With ThisForm.CntChequeFP
    *         .Get_Bco.Value = Space(3)   / .Get_Bco.Refresh
    *         .Get_Age.Value = Space(4)   / .Get_Age.Refresh
    *         .Get_Conta.Value = Space(10) / .Get_Conta.Refresh
    *         .Get_Num.Value = Space(6)   / .Get_Num.Refresh
    *     EndWith
    *
    * Os campos sao ControlSource da linha corrente (regra do topo deste
    * arquivo) - REPLACE no cursor, nao atribuicao direta ao .Value.
    *
    * Metodo PUBLIC: harness de teste automatico e handlers de outras fases
    * podem chamar (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE LimpaChe()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_cCursorGrade

        IF USED(loc_cCursor) AND !EOF(loc_cCursor)
            SELECT (loc_cCursor)
            REPLACE Bancos WITH SPACE(3), Agencias WITH SPACE(4), ;
                    Contas WITH SPACE(10), Numeros WITH SPACE(6)
        ENDIF

        THIS.cnt_4c_ChequeFP.txt_4c_Bco.Refresh()
        THIS.cnt_4c_ChequeFP.txt_4c_Age.Refresh()
        THIS.cnt_4c_ChequeFP.txt_4c_Conta.Refresh()
        THIS.cnt_4c_ChequeFP.txt_4c_Num.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * InChequeSerial - `PROCEDURE inchequeserial` do legado: completa a
    * leitura da leitora serial (ReadComm.leitura/campo) e dispara a mesma
    * cadeia Get_Bco.Valid + VerificaCheque do fluxo manual. Disparado no
    * legado pelo evento OnComm do controle OLE ReadComm.
    *
    * ReadComm NAO existe nesta arquitetura (ResolverTipoLeitora) - sem o
    * objeto, nao ha buffer serial para ler, e o metodo fica inerte por
    * construcao (nunca disparado, porque nao ha evento OnComm). Mantido
    * PUBLIC e com o guard explicito para o dia em que um form pai concreto
    * injete um leitor serial real (mesmo padrao defensivo de
    * Formsigopcim.PrepararLeitoraParaFoco) - regra #27 (wrapper documenta
    * ausencia, nao apaga o ponto de integracao).
    *--------------------------------------------------------------------------
    PROCEDURE InChequeSerial()
        LOCAL loc_cCursor

        THIS.this_lLeitor = .F.

        IF VARTYPE(THIS.this_oFormPai) != "O" OR ;
                !PEMSTATUS(THIS.this_oFormPai, "ReadComm", 5) OR ;
                VARTYPE(THIS.this_oFormPai.ReadComm) != "O"
            RETURN .F.
        ENDIF

        THIS.this_cLeituraSerial = THIS.this_oFormPai.ReadComm.Campo

        THIS.TxtBcoLostFocus()

        IF THIS.this_lLeitor
            loc_cCursor = THIS.this_cCursorGrade
            IF USED(loc_cCursor) AND !EOF(loc_cCursor) AND ;
                    !EMPTY(ALLTRIM(NVL(EVALUATE(loc_cCursor + ".Bancos"), "")))
                IF !THIS.VerificaCheque(EVALUATE(loc_cCursor + ".Bancos"), ;
                        EVALUATE(loc_cCursor + ".Agencias"), ;
                        EVALUATE(loc_cCursor + ".Contas"), ;
                        EVALUATE(loc_cCursor + ".Numeros"))
                    THIS.LimpaChe()
                    THIS.this_cLeituraSerial = ""
                    THIS.cnt_4c_ChequeFP.txt_4c_Bco.SetFocus()
                ELSE
                    THIS.cnt_4c_ChequeFP.txt_4c_Num.SetFocus()
                ENDIF
            ENDIF
        ELSE
            THIS.cnt_4c_ChequeFP.txt_4c_Age.SetFocus()
        ENDIF

        THIS.this_lLeitor = .F.

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificaCheque - `PROCEDURE verificacheque` do legado (134 linhas):
    * confere se o cheque (banco+agencia+conta+numero) digitado eh valido
    * (digitos), nao foi lancado DUAS VEZES nesta MESMA distribuicao (xPar/
    * cursor_4c_Dados) e nao esta cadastrado em outro titulo (SigChe) com
    * valor diferente.
    *
    *     if !fChkDigitos(banco/agencia/numero/conta) / 'Leitura incorreta' / sd=.f.
    *     if sd / Seek banco+agencia+conta+numero em xPar (outra linha) /
    *             se achou -> 'Cheque ja lancado' / sd=.f.
    *     if sd / Select * From SigChe Where Bancos=... And Agencias=...
    *             And nContas=... And Ncheques=... Into Cursor CrCheque /
    *             se achou -> confere TempChq (mesmo titulo) -> se nao
    *             achou la, 'Cheque ja cadastrado'; se achou, confere Valor
    *     Return sd
    *
    * `TempChq` (cursor das PARCELAS JA GRAVADAS do MESMO titulo, que
    * distingue "este cheque e de uma OUTRA nota" de "este cheque e desta
    * MESMA nota, so que ja fechada antes") nao existe nesta arquitetura:
    * nenhum form pai fornece esse cursor (SigOpFpg ainda nao esta
    * encadeado a Fluxo de Caixa/Baixa de Titulos - grep confirmado,
    * 2026-11-04). Sem ele, a distincao "mesmo titulo" x "outro titulo" eh
    * IMPOSSIVEL de fazer; o SEEK sobre alias inexistente estouraria em
    * runtime. Degrada para o lado CONSERVADOR: cheque ja registrado em
    * SigChe (qualquer titulo) bloqueia como "ja cadastrado" - impede
    * duplicar lancamento de cheque, ao preco de poder bloquear o caso
    * raro de reconfirmar o MESMO titulo (que o usuario resolve veio pelo
    * Cancelar/reabrir). `ThisForm.Parentform.PoDataMgr.SqlExecute` (data
    * manager legado) vira SQLEXEC(gnConnHandle,...) direto.
    *
    * Metodo PUBLIC: chamado pelos LostFocus de Get_bco/Get_num e por
    * InChequeSerial.
    *--------------------------------------------------------------------------
    FUNCTION VerificaCheque(par_cBanco, par_cAgencia, par_cConta, par_cNumero)
        LOCAL loc_cCursor, loc_lDigitosOk, loc_lDuplicadoLocal, loc_lOk, ;
            loc_cSQL, loc_nResultado, loc_cAliasAnt, loc_nRecnoAnt, loc_oErro

        loc_cCursor = THIS.this_cCursorGrade
        loc_lOk     = .T.

        *-- `if !fChkDigitos(banco/agencia/numero/conta)`
        loc_lDigitosOk = fChkDigitos(par_cBanco) AND fChkDigitos(par_cAgencia) AND ;
            fChkDigitos(par_cNumero) AND fChkDigitos(par_cConta)

        IF !loc_lDigitosOk
            MsgAviso("Leitura de cheque incorreta!")
            RETURN .F.
        ENDIF

        *-- `Seek banco+agencia+conta+numero em xPar` (outra linha da MESMA
        *-- distribuicao ja usa este cheque)
        IF USED(loc_cCursor)
            loc_cAliasAnt = ALIAS()
            SELECT (loc_cCursor)
            loc_nRecnoAnt = IIF(EOF() OR BOF(), 0, RECNO())

            loc_lDuplicadoLocal = .F.
            SCAN FOR ALLTRIM(NVL(Bancos, "")) == ALLTRIM(par_cBanco) AND ;
                     ALLTRIM(NVL(Agencias, "")) == ALLTRIM(par_cAgencia) AND ;
                     ALLTRIM(NVL(Contas, "")) == ALLTRIM(par_cConta) AND ;
                     ALLTRIM(NVL(Numeros, "")) == ALLTRIM(par_cNumero) AND ;
                     RECNO() != loc_nRecnoAnt
                loc_lDuplicadoLocal = .T.
                EXIT
            ENDSCAN

            IF loc_nRecnoAnt > 0 AND loc_nRecnoAnt <= RECCOUNT(loc_cCursor)
                SELECT (loc_cCursor)
                GOTO loc_nRecnoAnt
            ENDIF
            IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
                SELECT (loc_cAliasAnt)
            ENDIF

            IF loc_lDuplicadoLocal
                MsgAviso("Cheque j" + CHR(225) + " lan" + CHR(231) + "ado!!")
                RETURN .F.
            ENDIF
        ENDIF

        *-- `Select * From SigChe Where Bancos=... And Agencias=... And
        *--  nContas=... And Ncheques=... Into Cursor CrCheque`
        TRY
            IF USED("cursor_4c_CheCk")
                USE IN SELECT("cursor_4c_CheCk")
            ENDIF

            loc_cSQL = "SELECT valors FROM SigChe" + ;
                " WHERE RTRIM(bancos) = " + EscaparSQL(ALLTRIM(par_cBanco)) + ;
                " AND RTRIM(agencias) = " + EscaparSQL(ALLTRIM(par_cAgencia)) + ;
                " AND RTRIM(ncontas) = " + EscaparSQL(ALLTRIM(par_cConta)) + ;
                " AND RTRIM(ncheques) = " + EscaparSQL(ALLTRIM(par_cNumero))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CheCk")

            IF loc_nResultado < 0
                MsgErro("Favor reinicializar o processo." + CHR(13) + CapturarErroSQL(), ;
                    "Falha na Conex" + CHR(227) + "o")
                loc_lOk = .F.
            ELSE
                IF USED("cursor_4c_CheCk") AND RECCOUNT("cursor_4c_CheCk") > 0
                    *-- Sem TempChq (ver cabecalho do metodo), qualquer match
                    *-- em SigChe bloqueia como "ja cadastrado" - lado
                    *-- conservador da degradacao.
                    MsgAviso("Cheque j" + CHR(225) + " cadastrado !!")
                    loc_lOk = .F.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao verificar cheque")
            loc_lOk = .F.
        ENDTRY

        IF USED("cursor_4c_CheCk")
            USE IN SELECT("cursor_4c_CheCk")
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna visiveis recursivamente os controles
    * criados via AddObject (que nascem Visible=.F.).
    *
    * EXCECAO (FASE 6/8): os 5 paineis flutuantes de forma de pagamento
    * (CntCCred/CntCCredFP/CntCarneFP/CntOutrosFP/CntChequeFP) tem de
    * permanecer Visible=.F. - sao alternados pelo equivalente a MostraObs/
    * mCartaoCred do legado (MostrarObservacao/CartaoCredito, Fase 7).
    * A excecao preserva o Visible=.F. do CONTAINER mas ainda desce a
    * recursao para os filhos (labels/textboxes), que precisam estar
    * Visible=.T. assim que o painel for exibido - regra de forms
    * OPERACIONAIS com containers flutuantes.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP, loc_lPainelFlutuante

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                loc_lPainelFlutuante = INLIST(UPPER(loc_oObjeto.Name), ;
                    "CNT_4C_CCRED", "CNT_4C_CCREDFP", "CNT_4C_CARNEFP", ;
                    "CNT_4C_OUTROSFP", "CNT_4C_CHEQUEFP")

                IF !loc_lPainelFlutuante AND PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Legado: `Return` reabilita o form pai antes de liberar o
    * dialogo (Thisform.parentform.enabled = .T. / Thisform.release). O
    * caminho canonico de fechamento (equivalente ao Return) eh FecharDialogo,
    * acionado por CmdOkClick/CmdCancelaClick; aqui, Destroy garante a
    * reabilitacao do pai mesmo se o dialogo for fechado por outra via
    * (ESC/erro).
    * DODEFAULT() por ULTIMO - sem ele FormBase.Destroy nao roda e os popups
    * do menu principal ficam com cache visual obsoleto (regra #29/CLAUDE.md).
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oFormPai) = "O"
            IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
                THIS.this_oFormPai.Enabled = .T.
            ENDIF
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
