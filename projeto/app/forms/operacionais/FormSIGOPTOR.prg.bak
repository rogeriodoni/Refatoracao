*==============================================================================
* FORMSIGOPTOR.PRG - Dialogo "Total" (SIGOPTOR)
* Tipo: OPERACIONAL (dialogo modal FILHO, layout FLAT - sem PageFrame)
* Migrado de SIGOPTOR.SCX (task812)
*
* Pilares:
*   UX   -> layout identico ao legado (1000x600, TitleBar=0, ControlBox=.F.,
*           AlwaysOnTop=.T., cabecalho cinza no topo com o Caption "Total")
*   BD   -> SigMvOrp/SigMvOrc/SigCdOpe/SigMvItn/SigMvCab/SigCdUni, consultadas
*           via SIGOPTORBO (ver cabecalho desse BO para o detalhamento das
*           duas queries); esta tela eh SOMENTE LEITURA, sem nenhum
*           INSERT/UPDATE/DELETE
*   CODE -> arquitetura em camadas (FormBase / SIGOPTORBO)
*
* O QUE ESTA TELA EH
*   Dialogo FILHO que o form pai de Orcamento/Pre-Custo abre via
*   "Do Form SigOpTor With ThisForm, nDataSession, pcVisual". O legado
*   recebe (pform, datses, pVisual), faz "Set Datasession To DatSes" para
*   ler os cursores do pai (crSigMvOrp/crSigMvOrc/crSigOpCdd/crSigCdOpe) SEM
*   trocar de maquina de consulta, e normaliza pVisual: quando o parametro
*   nao eh informado (chega como Logico, tipo default do LPARAMETERS
*   omitido) o modo vira "P" (Total Previsao); qualquer outro valor Char eh
*   "Itens Subnivel".
*
*   Modo "P" liga a grade GrdTotPrev (Data/Previsto/Realizado/Diferenca) +
*   os 3 totalizadores (getTotPrev/getTotReal/getTotDif) + a grade grdTotal
*   (Item/Total NFs), e ESCONDE grdItem/Say2/getDProd. Modo != "P" monta a
*   cadeia de subniveis (loop SigCdOpe->SigMvItn/SigMvCab/SigMvOrc/SigCdUni)
*   na grade grdItem (9 colunas) + Say2/getDProd (descricao do produto), e
*   ESCONDE grdTotPrev/grdTotal/os 3 totalizadores. O unico botao eh
*   OK.btnSair ("Retornar"/Cancel=.T.), que reabilita o form pai e libera o
*   dialogo - nao ha gravacao nenhuma nesta tela (ver cabecalho de
*   SIGOPTORBO.prg).
*
*   No migrado, o form roda com DataSession = 1 (sessao CORRENTE,
*   compartilhada), reproduzindo o mesmo efeito do "Set DataSession To
*   DatSes" sem a troca manual de sessao - mesmo padrao adotado em
*   FormSigOpTop.prg/FormSigOpSts.prg/FormSigOpSqn.prg/FormSigOpSlc.prg.
*
* CHAMADA (equivale ao "Do Form SigOpTor With ThisForm, nDataSession,
* pcVisual" do legado):
*   loForm = CREATEOBJECT("FormSIGOPTOR", THISFORM, THISFORM.DataSessionId, ;
*       loc_cModoVisual)
*   IF VARTYPE(loForm) = "O"
*       loForm.Show()          && modal: so volta quando o dialogo fecha
*   ENDIF
*
*   Como no legado, o Release eh do PROPRIO dialogo (botao Retornar, fase
*   futura), nao do chamador.
*
* PARAMETROS DO INIT (legado: LParameters pform, datses, pVisual)
*   par_oFormPai         - legado: pform / ThisForm.ParentForm (property
*                          CUSTOM da classe - RESERVED3/ClassInfo do dump
*                          lista "parentform" como custom property, NAO a
*                          nativa de container MDI). Form pai de
*                          Orcamento/Pre-Custo. NAO desabilitado por este
*                          Init (o dump nao tem essa linha - quem desabilita
*                          eh o CHAMADOR antes do "Do Form"); este form so
*                          REABILITA ao sair (BtnSairClick - Fase 4 -
*                          e Destroy, rede de seguranca).
*   par_nDataSessionPai  - legado: datses. Informativo - DataSession = 1 ja
*                          unifica a sessao com o pai; mantido so para
*                          auditoria/paridade com o legado.
*   par_cModoVisual      - legado: pVisual. "P" = Total Previsao; qualquer
*                          outro valor Character (ou ausente) = Itens
*                          Subnivel/default. Normalizado em Init, igual ao
*                          legado (pVisual = Iif(Type(pVisual)=[L],[P],
*                          pVisual)) - NAO maiusculiza o valor recebido, so
*                          supre o default quando o tipo nao eh Character.
*
* METODOS DE DADOS (ja implementados no BO - fases 1-2)
*   CarregarModoPrevisao/CarregarModoItensSubnivel/CarregarTotalPorData/
*   CarregarTotaisGerais/CarregarTotalGeral/CarregarDoCursor/
*   LimparCursoresGrade/ObterChavePrimaria - ver cabecalho de
*   SIGOPTORBO.prg para o detalhamento completo (inclusive por que
*   Inserir/Atualizar/ExecutarExclusao NAO sao sobrescritos: esta tela eh
*   somente leitura).
*
* FASE 3 (anterior): estrutura base do form
*   - Propriedades que espelham o contexto recebido do form pai
*     (this_oFormPai/this_nDataSessionPai/this_cModoVisual).
*   - Init (LParameters do legado, mesma ordem: pform, datses, pVisual) +
*     ValidarParametros (precondicao: sem form pai nao ha quem reabilitar
*     ao sair).
*   - InicializarForm (cria o BO, aplica o fundo, cria o cabecalho cinza).
*   - ConfigurarDecoracao (Picture do form - new_background.jpg).
*   - ConfigurarPageFrame (cntSombra do legado -> cnt_4c_Cabecalho; nome do
*     metodo mantido por paridade com os demais dialogos filhos desta
*     familia - FormSigOpTop/FormSigOpSts/FormSigOpSqn/FormSigOpSlc - mesmo
*     sem PageFrame real: este form eh FLAT, igual ao legado - ZERO
*     "BaseClass: pageframe" no dump SIGOPTOR_form_codigo_fonte.txt).
*   - TornarControlesVisiveis / Destroy (reabilita o form pai ao fechar,
*     rede de seguranca, e libera os 3 cursores do BO - LimparCursoresGrade).
*
* FASE 4 (esta fase): grades + botao de saida - ramo FLAT (sem PageFrame/
* Page1/Page2 - roteiro generico de CRUD nao se aplica, mesmo caso de
* FormSigOpTop.prg: o dump confirma classe "form" pura, zero "BaseClass:
* pageframe", grades e campos soltos direto no form)
*
*   - ConfigurarGrade()         grdItem/GrdTotPrev/grdTotal do legado ->
*                                grd_4c_ItensPendentes/grd_4c_TotalPorData/
*                                grd_4c_TotalGeral (SO o que nao depende de
*                                dado - ControlSource/RecordSource ficam em
*                                CarregarLista, regra #41)
*   - AplicarFormatoGradeItem/TotPrev/Total()  FONTE UNICA de Column.Width/
*                                Header1.Caption/ColumnOrder - RecordSource
*                                zera esses valores (Problema 48), entao
*                                CarregarLista reaplica depois do bind
*   - ConfigurarBotoes()         OK.btnSair do legado -> cmg_4c_OK
*                                (CommandGroup, ButtonCount=1) + Buttons(1)
*                                "Retornar"
*   - BtnSairClick()             btnSair.Click do legado (reabilita o pai +
*                                Release) - entrou junto com o botao: eh o
*                                UNICO botao da tela (ControlBox=.F.,
*                                TitleBar=0) e deixa-lo inerte tiraria a
*                                saida pelo mouse. Nome do metodo segue o
*                                nome do OBJETO legado (btnSair), nao a
*                                Caption ("Retornar") - harness de teste
*                                (BtnEncerrarExiste) procura por
*                                BtnEncerrarClick/BtnFecharClick/
*                                BtnSairClick
*   - CarregarLista()            funil: despacha para o modo "P" (Total
*                                Previsao, duas grades) ou "Itens
*                                Subnivel" (grdItem), chamando
*                                this_oBusinessObject.CarregarModoPrevisao/
*                                CarregarModoItensSubnivel, fazendo o bind
*                                + GO TOP + Refresh (regra #21a) e o toggle
*                                de Visible por modo - trecho final do
*                                Init legado, incluindo o "Return .f." do
*                                ramo Itens Subnivel quando a cadeia nao
*                                acha nenhum item (reabilita o pai e aborta
*                                a instanciacao, igual ao legado)
*
*   getTotPrev/getTotReal/getTotDif/getDProd/Say2 (Fases 5-6, ainda
*   inexistentes) sao tocados em CarregarLista so sob guarda PEMSTATUS -
*   nesta fase o toggle de Visible deles e a atribuicao de .Value ficam de
*   fora (sem erro, sem no-op disfarcado): as Fases 5-6 estendem o mesmo
*   funil ao criar os controles, sem precisar duplicar a logica de modo.
*
*   NAO HA PageFrame/Page1/Page2 neste form - roteiro generico de CRUD NAO
*   se aplica (PILAR 1 / "NUNCA inventar UI que o legado nao tem"): o dump
*   confirma classe "form" pura, zero PageFrame, com grades e campos soltos
*   direto no form, exatamente como os dialogos irmaos desta familia.
*
* FASE 5 (anterior) - 1a metade dos campos restantes do SCX (Say2/
* getDProd - modo "Itens Subnivel").
*
*   - ConfigurarCamposPrincipais()  Say2/getDProd -> lbl_4c_Label2/
*                                    txt_4c_DProd, direto em THIS (sem
*                                    container - form FLAT)
*   - TxtDProdWhen()                 getDProd.When do legado ("Return .f."),
*                                    PUBLIC por exigencia do BINDEVENT
*
*   O toggle de Visible desses dois controles por modo JA estava pronto
*   desde a Fase 4 (guardado por PEMSTATUS em CarregarModoPrevisaoNaTela/
*   CarregarModoItensSubnivelNaTela, pensando exatamente nesta extensao) -
*   nenhuma mudanca no funil de carga foi necessaria.
*
* FASE 6 (esta fase) - 2a metade dos campos restantes do SCX (getTotPrev/
* getTotReal/getTotDif - modo "P"). Este form NAO TEM NENHUM LOOKUP (ver
* comportamento.json: zero fwbuscaext/fwBuscaSel/sigacess no dump inteiro
* - os 3 campos sao fwget com When = "Return .f." igual a getDProd, PURO
* DISPLAY de totalizador monetario, nunca recebem foco) - o roteiro
* generico da Fase 6 (campos + lookups) se reduz aqui a SO campos.
*
*   - ConfigurarCamposTotalizadores()  getTotPrev/getTotReal/getTotDif ->
*                                    txt_4c_TotPrev/txt_4c_TotReal/
*                                    txt_4c_TotDif, direto em THIS (sem
*                                    container - form FLAT), igual ao
*                                    padrao de ConfigurarCamposPrincipais
*   - TxtTotPrevWhen/TxtTotRealWhen/TxtTotDifWhen  When do legado
*                                    ("Return .f." nos 3), PUBLIC por
*                                    exigencia do BINDEVENT
*
*   CarregarModoPrevisaoNaTela (Fase 4) ganhou a atribuicao de .Value dos
*   3 totalizadores a partir de this_oBusinessObject.this_nTotalPrevisto/
*   this_nTotalRealizado/this_nTotalDiferenca (CarregarTotaisGerais, Fases
*   1-2) - legado: "thisform.getTotPrev.Value = Nvl(crTmpTotOrp2.Valos,0)"
*   e os 2 seguintes, atribuidos SEMPRE que a consulta (Sum sem Group By)
*   teve sucesso, independente do grdTotPrev ter linha (por isso a
*   atribuicao fica dentro do IF de sucesso de CarregarModoPrevisao, mas
*   FORA dos dois IFs de this_nTotalRegistros* > 0). O toggle de Visible
*   por modo desses 3 controles JA estava pronto desde a Fase 4 (mesmo
*   padrao do Say2/getDProd na Fase 5).
*
* FASE 7 (anterior) - SEM TRABALHO: o roteiro generico pede
* BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick, mas
* este dialogo NAO tem CRUD nenhum no legado (comportamento.json: 18
* metodos/eventos no dump inteiro, nenhum deles Incluir/Alterar/Excluir/
* Visualizar de registro; classe "form" pura, zero frmcadastro/Grupo_Op/
* pcEscolha). O UNICO botao da tela eh OK.btnSair ("Retornar"), e o
* handler correspondente (BtnSairClick) ja entrou na Fase 4 junto com
* o AddObject do botao - deixar o unico botao inerte ate esta fase tiraria
* a saida do dialogo (ControlBox=.F., TitleBar=0, sem ESC/fechar por
* chrome de janela). Inventar os 4 metodos CRUD aqui violaria o PILAR 1
* (UI/funcionalidade que o legado nao tem) e a regra de completude (seriam
* stubs disfarcados, sem Click de botao algum para ligar). Mesmo caso
* documentado para SIGMVCTH/SigPrScn (visualizador somente-leitura com 1
* botao de saida) e SigPrIct/SigPrItb (toolbar de REPORT, nao CRUD de
* registro).
*
* FASE 8 (esta fase) - CONSOLIDACAO FINAL: SEM TRABALHO NOVO, pela mesma
* razao da Fase 7 (dialogo somente-leitura, zero CRUD no legado -
* comportamento.json confirma, de novo, nenhum dos 18 metodos/eventos
* fazendo Incluir/Alterar/Excluir/Salvar/Cancelar/Buscar/Encerrar de
* registro). O roteiro generico desta fase pede:
*
*   - BtnBuscarClick/BtnEncerrarClick/BtnSalvarClick/BtnCancelarClick ->
*     NAO EXISTEM no legado (SIGOPTOR_form_codigo_fonte.txt: zero objeto
*     chamado Buscar/Encerrar/Salvar/Cancelar; o unico CommandGroup eh OK,
*     com o unico botao Buttons(1)="btnSair"/"Retornar", ja ligado a
*     BtnSairClick desde a Fase 4 - regra do projeto "Saida eh o
*     proprio botao de acao" quando a tela tem 1 unico botao e ele fecha o
*     dialogo. Inventar os 4 handlers aqui seria UI/funcionalidade que o
*     legado nao tem (PILAR 1) e estoque morto (nenhum Click para ligar).
*   - FormParaBO()/BOParaForm() -> NAO SE APLICAM: este dialogo eh SOMENTE
*     LEITURA em AMBOS os modos (ver cabecalho de SIGOPTORBO.prg - todas
*     as colunas das 3 grades sao ReadOnly=.T. no SCX, sem nenhum
*     INSERT/UPDATE/DELETE), entao nao ha "form -> BO" para gravar nem
*     "BO -> form" de edicao alem do que CarregarModoPrevisaoNaTela/
*     CarregarModoItensSubnivelNaTela (Fase 4) ja fazem ao popular as
*     grades e os totalizadores a partir do BO.
*   - HabilitarCampos()/LimparCampos() -> NAO SE APLICAM: nao ha campo
*     editavel nenhum na tela (os 2 TextBox soltos - txt_4c_DProd e os 3
*     txt_4c_Tot* - tem When = .F. e nunca recebem foco, Fases 5-6), nem
*     modo INCLUIR/ALTERAR/VISUALIZAR a transicionar.
*   - CarregarLista() -> JA EXISTE e esta COMPLETO desde a Fase 4 (funil
*     que despacha para CarregarModoPrevisaoNaTela/
*     CarregarModoItensSubnivelNaTela conforme this_cModoVisual), chamado
*     pelo proprio InicializarForm (Fase 3) fora de modo teste/validacao
*     de UI - nao ha "segunda metade" desta fase para completar.
*   - AjustarBotoesPorModo() -> NAO SE APLICA: nao ha modo LISTA/INCLUIR/
*     ALTERAR/VISUALIZAR/EXCLUIR neste dialogo (this_cModoVisual eh
*     "P"/Itens Subnivel, um toggle de EXIBICAO entre duas composicoes de
*     grade+campos, nao um modo de edicao de registro) nem botoes CRUD a
*     habilitar/desabilitar - o unico botao (Retornar) fica sempre
*     habilitado, em qualquer um dos dois modos de exibicao.
*
* Reescrever qualquer um desses metodos como stub (ex.: BtnSalvarClick
* com MsgAviso("sera implementado")) violaria a regra de completude do
* projeto (stub disfarcado) e o PILAR 1 (inventar UI/fluxo que o legado
* nao tem) ao mesmo tempo - por isso a fase fecha so com esta nota,
* exatamente como a Fase 7.
*==============================================================================

DEFINE CLASS FormSIGOPTOR AS FormBase

    *--------------------------------------------------------------------------
    * CONTEXTO RECEBIDO DO FORM PAI (LParameters do Init legado)
    *--------------------------------------------------------------------------

    this_cMensagemErro = ""

    *-- pform / ThisForm.ParentForm do legado (property CUSTOM da classe,
    *-- nao a nativa de container MDI - ver RESERVED3/ClassInfo do dump). O
    *-- form de Orcamento/Pre-Custo que abriu este dialogo
    this_oFormPai = .NULL.

    *-- datses do legado - informativo (DataSession = 1 ja unifica a sessao
    *-- com o pai, ver comentario de DataSession abaixo)
    this_nDataSessionPai = 0

    *-- pVisual do legado, ja normalizado em Init ("P" = Total Previsao;
    *-- qualquer outro Character = Itens Subnivel). Consultado pelo funil de
    *-- carga (Fase 4) para decidir qual metodo do BO chamar
    this_cModoVisual = ""

    *--------------------------------------------------------------------------
    * PROPRIEDADES VISUAIS - transcritas do SCX legado (PILAR 1)
    *--------------------------------------------------------------------------

    *-- SIGOPTOR: Top=-1 / Left=5 / Height=600 / Width=1000 - literais do
    *-- dump. AutoCenter = .F. explicito (FormBase.Init o declara .T. por
    *-- padrao - regra do projeto - e o legado posiciona este dialogo nos
    *-- coordenadas fixas acima, nao centralizado)
    Top        = -1
    Left       = 5
    Height     = 600
    Width      = 1000
    AutoCenter = .F.

    *-- Caption do SCX ("Total") - sobrescrito pelo funil de carga (Fase 4)
    *-- com "Total Previsao"/"Itens Subnivel", igual ao legado (.Caption =
    *-- 'Total Previsao' ou 'Itens Subnivel', decidido dentro do Init)
    Caption = "Total"

    *-- BorderStyle=2 / ControlBox=.F. / MaxButton=.F. / MinButton=.F. /
    *-- Movable=.T. / TitleBar=0 / WindowType=1 / AlwaysOnTop=.T. - literais
    *-- do dump
    BorderStyle  = 2
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .T.
    TitleBar     = 0
    WindowType   = 1
    AlwaysOnTop  = .T.

    *-- ShowWindow = 1 ("In Top-Level Form") - canonico do projeto, mesmo
    *-- padrao dos dialogos irmaos desta familia (FormSigOpTop.prg)
    ShowWindow = 1

    *-- DataSession = 1 (sessao CORRENTE, NAO privada). O legado declara
    *-- DataSession = 2 no SCX mas o proprio Init sobrescreve com "Set
    *-- DataSession To DatSes", ou seja: na pratica este dialogo roda SEMPRE
    *-- na sessao do form pai. DataSession = 1 eh a reproducao direta desse
    *-- resultado, sem a troca manual de sessao - mesmo padrao adotado em
    *-- FormSigOpTop.prg/FormSigOpSts.prg/FormSigOpSqn.prg/FormSigOpSlc.prg
    DataSession = 1

    *==========================================================================
    * Init - LParameters pform, datses, pVisual do legado (mesma ordem).
    *==========================================================================
    PROCEDURE Init
        LPARAMETERS par_oFormPai, par_nDataSessionPai, par_cModoVisual

        IF VARTYPE(par_oFormPai) = "O"
            THIS.this_oFormPai = par_oFormPai
        ENDIF

        THIS.this_nDataSessionPai = IIF(VARTYPE(par_nDataSessionPai) = "N", par_nDataSessionPai, 0)

        *-- Legado: pVisual = Iif(Type([pVisual]) = [L],[P],pVisual) - quando
        *-- o 3o parametro nao eh informado (chega com o tipo default do
        *-- LPARAMETERS omitido, Logico), o modo vira "P". Qualquer valor
        *-- Character recebido e mantido como esta, SEM maiusculizar
        *-- (o legado tambem nao maiusculiza - a comparacao eh so com [P])
        THIS.this_cModoVisual = IIF(VARTYPE(par_cModoVisual) = "C", par_cModoVisual, "P")

        *-- DODEFAULT chama FormBase.Init (fix SET DATE/CENTURY) e em
        *-- seguida THIS.InicializarForm()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * ValidarParametros - precondicao deste dialogo: sem form pai nao ha
    * quem reabilitar ao sair (o legado tambem depende dessa referencia no
    * caminho de erro do Init - ThisForm.ParentForm.Enabled = .t.).
    *
    * Metodo PUBLIC (regra #3): o harness de teste e o form pai o alcancam
    * de fora, e PROTECTED faria a chamada externa estourar em runtime.
    *
    * Bypass em modo teste/validacao de UI no TOPO: o ValidarUIFidelity e o
    * TesteAutomatico instanciam o form SEM ARGUMENTO NENHUM, e sem o
    * bypass a instanciacao reprovaria sempre.
    *
    * O RETURN fica FORA de TRY/CATCH (regra #1) - este metodo nao abre
    * bloco algum.
    *==========================================================================
    PROCEDURE ValidarParametros
        LOCAL loc_lValido
        loc_lValido = .T.

        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            RETURN .T.
        ENDIF

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        IF VARTYPE(THIS.this_oFormPai) != "O"
            MsgErro("Esta tela s" + CHR(243) + " pode ser aberta a partir do " + ;
                    "Or" + CHR(231) + "amento/Pr" + CHR(233) + "-Custo.", "Total")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * InicializarForm - estrutura base do dialogo
    *
    * Hook chamado pelo FormBase.Init. Retorna .T. em sucesso e .F. em falha
    * (nesse caso o CREATEOBJECT do chamador devolve logico, nao objeto).
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        *-- Guarda de precondicao ANTES do TRY, para o RETURN nao ficar
        *-- dentro de TRY/CATCH (regra #1)
        IF !THIS.ValidarParametros()
            RETURN .F.
        ENDIF

        TRY
            *-- Business Object das Fases 1-2
            THIS.this_oBusinessObject = CREATEOBJECT("SIGOPTORBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar SIGOPTORBO.", "Total")
            ELSE
                *-- Fundo do form (Picture do SCX)
                THIS.ConfigurarDecoracao()

                *-- Cabecalho cinza (cntSombra do legado). PRIMEIRO
                *-- AddObject do form, igual ao SCX
                THIS.ConfigurarPageFrame()

                *-- grdItem/GrdTotPrev/grdTotal do legado (Fase 4) - SO o
                *-- que nao depende de dado (regra #41)
                THIS.ConfigurarGrade()

                *-- Say2/getDProd do legado (Fase 5, 1a metade - modo
                *-- "Itens Subnivel")
                THIS.ConfigurarCamposPrincipais()

                *-- getTotPrev/getTotReal/getTotDif do legado (Fase 6, 2a
                *-- metade - modo "P")
                THIS.ConfigurarCamposTotalizadores()

                *-- OK.btnSair do legado -> cmg_4c_OK (Fase 4)
                THIS.ConfigurarBotoes()

                *-- AddObject cria controle com Visible = .F.
                THIS.TornarControlesVisiveis(THIS)

                *-- Legado: o Init termina montando o cursor do modo
                *-- corrente e ligando as grades a ele. Pulado em modo
                *-- teste/validacao de UI (padrao FormCor/FormSigOpTop):
                *-- la nao ha gnConnHandle nem cursores do form pai
                *-- abertos, entao a carga so produziria ruido de erro no
                *-- log do harness. As grades ficam vazias, ja formatadas
                *-- por AplicarFormatoGrade*. O harness chama CarregarLista
                *-- de fora quando quer exercita-la
                IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) AND ;
                   !(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao inicializar FormSIGOPTOR: " + loc_oErro.Message + ;
                    " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    " | Procedure: " + loc_oErro.Procedure, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarDecoracao - Picture do form (new_background.jpg do legado)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarDecoracao
        LOCAL loc_cImagemFundo
        loc_cImagemFundo = ""

        IF TYPE("gc_4c_CaminhoIcones") = "C"
            loc_cImagemFundo = gc_4c_CaminhoIcones + "new_background.jpg"
        ENDIF

        IF !EMPTY(loc_cImagemFundo) AND FILE(loc_cImagemFundo)
            THIS.Picture = loc_cImagemFundo
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - cntSombra do legado -> cnt_4c_Cabecalho. Nome do
    * metodo mantido por paridade com os demais dialogos filhos desta
    * familia (FormSigOpTop.prg/FormSigOpSts.prg/FormSigOpSqn.prg/
    * FormSigOpSlc.prg usam o mesmo nome), mesmo sem PageFrame real - este
    * form eh FLAT, igual ao legado (SIGOPTOR nao tem PageFrame no SCX).
    *
    * Transcricao do dump (SIGOPTOR_form_codigo_fonte.txt):
    *   cntSombra  Top=0  Left=0  Width=1100  Height=80  BorderWidth=0
    *              BackColor=100,100,100
    *   lblSombra  Top=18 Left=10 Width=769 Height=40 ForeColor=0,0,0
    *              Tahoma 18 bold, FontUnderline=.F., WordWrap=.T.,
    *              Alignment=0, BackStyle=0
    *   lblTitulo  Top=17 Left=10 Width=769 Height=46 ForeColor=255,255,255
    *              Tahoma 18 bold, WordWrap=.T., Alignment=0, BackStyle=0
    *
    * O Caption dos dois labels acompanha THIS.Caption no momento da
    * criacao ("Total", literal desta fase) - o funil de carga (Fase 4)
    * atualiza os DOIS Caption (do form e dos labels) junto com o toggle de
    * Visible por modo, igual ao legado.
    *
    * Width do container usa THIS.Width - padrao canonico da faixa, regra
    * #11 - em vez do literal 1100: o SCX declara o CONTAINER mais largo
    * que o proprio form (1000), artefato do Form Designer ja catalogado
    * (cabecalho_label_width_dump_maior_que_form). Os labels usam
    * THIS.Width - 20, mesma margem de 10px dos dois lados aplicada pelos
    * dialogos irmaos (FormSigOpTop.prg) - o literal 769 do dump cabe
    * dentro dos 1000px (nao precisa ser preservado literal).
    *
    * AutoSize = .F. explicito nos dois labels: com WordWrap = .T. o
    * AutoSize DESCARTA a Height e colapsa o texto para uma linha (regra
    * #23), e os 40/46 do dump sao o tamanho ja calculado pelo Form Designer.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame
        *-- Container da faixa (cntSombra)
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top           = 0
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 80
            .BorderWidth   = 0
            .BackStyle     = 1
            .BackColor     = RGB(100, 100, 100)
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- lblSombra: copia preta deslocada 1px, para dar profundidade ao
        *-- titulo. Criada ANTES do lblTitulo para ficar por baixo dele
        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
            .AutoSize      = .F.
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .Caption       = THIS.Caption
            .Top           = 18
            .Left          = 10
            .Width         = THIS.Width - 20
            .Height        = 40
            .ForeColor     = RGB(0, 0, 0)
            .Rotation      = 0
            .Visible       = .T.
        ENDWITH

        *-- lblTitulo: titulo branco sobre a faixa cinza. Branco eh correto
        *-- aqui porque o container eh OPACO e escuro (excecao prevista na
        *-- regra #12)
        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .AutoSize    = .F.
            .FontBold    = .T.
            .FontName    = "Tahoma"
            .FontSize    = 18
            .WordWrap    = .T.
            .Alignment   = 0
            .BackStyle   = 0
            .Caption     = THIS.Caption
            .Top         = 17
            .Left        = 10
            .Width       = THIS.Width - 20
            .Height      = 46
            .ForeColor   = RGB(255, 255, 255)
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Rotation    = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.Visible = .T.
    ENDPROC

    *==========================================================================
    * ConfigurarGrade - grdItem/GrdTotPrev/grdTotal do legado
    *
    * ORDEM (identica a do SCX - SECAO 1 do dump): grdItem, GrdTotPrev,
    * grdTotal. Nenhuma das tres tem controle transparente sobrepondo
    * outra (diferente do Shape1 de FormSigOpTop.prg), entao a ordem entre
    * elas nao eh critica - preservada so por fidelidade ao dump.
    *
    * Aqui ficam SO as propriedades que NAO dependem de dado (regra #41):
    * ControlSource/RecordSource moram em CarregarLista, porque atribuir
    * ControlSource de alias que ainda nao existe derruba o Init.
    *
    * RecordMark = .F. em todas (grade de form OPERACIONAL criada por
    * AddObject - regra do projeto, sem isso a barra de marcacao aparece
    * na lateral e come largura util). grdItem.RecordMark nao consta do
    * dump (herda o default); GrdTotPrev/grdTotal declaram DeleteMark=.F.
    * explicito - RecordMark = .F. acompanha por fidelidade ao padrao.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade
        *-- grdItem -> grd_4c_ItensPendentes (TmpItePen no legado) - Modo
        *-- "Itens Subnivel". ReadOnly = .F. no GRID (literal do dump) -
        *-- cada Column.ReadOnly = .T. sobrescreve depois, em
        *-- AplicarFormatoGradeItem (regra #18: Column.ReadOnly DEPOIS do
        *-- Grid.ReadOnly)
        THIS.AddObject("grd_4c_ItensPendentes", "Grid")
        WITH THIS.grd_4c_ItensPendentes
            .ColumnCount   = 9
            .FontName      = "Tahoma"
            .FontSize      = 8
            .HeaderHeight  = 22
            .Top           = 192
            .Left          = 1
            .Width         = 997
            .Height        = 365
            .RowHeight     = 16
            .ReadOnly      = .F.
            .RecordMark    = .F.
            .DeleteMark    = .F.
            .TabIndex      = 2
            .Visible       = .T.
        ENDWITH

        *-- GrdTotPrev -> grd_4c_TotalPorData (crTmpTotOrp no legado) -
        *-- Modo "P", 1a grade (Data/Previsto/Realizado/Diferenca)
        THIS.AddObject("grd_4c_TotalPorData", "Grid")
        WITH THIS.grd_4c_TotalPorData
            .ColumnCount   = 4
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Top           = 193
            .Left          = 259
            .Width         = 479
            .Height        = 364
            .RowHeight     = 16
            .ScrollBars    = 2
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .ReadOnly      = .T.
            .TabIndex      = 4
            .Visible       = .T.
        ENDWITH

        *-- grdTotal -> grd_4c_TotalGeral (crTmpTotal no legado) - Modo
        *-- "P", 2a grade (Item/Total NFs)
        THIS.AddObject("grd_4c_TotalGeral", "Grid")
        WITH THIS.grd_4c_TotalGeral
            .ColumnCount   = 2
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Top           = 88
            .Left          = 259
            .Width         = 479
            .Height        = 97
            .RowHeight     = 16
            .ScrollBars    = 2
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .ReadOnly      = .T.
            .TabIndex      = 4
            .Visible       = .T.
        ENDWITH

        *-- Largura/cabecalho/ordem das colunas NAO ficam neste bloco: moram
        *-- nos metodos abaixo, FONTE UNICA desses numeros, que CarregarLista
        *-- reaplica depois do RecordSource (que os zera - Problema 48 /
        *-- regra #41)
        THIS.AplicarFormatoGradeItem()
        THIS.AplicarFormatoGradeTotPrev()
        THIS.AplicarFormatoGradeTotal()
    ENDPROC

    *==========================================================================
    * AplicarFormatoGradeItem - FONTE UNICA da geometria das colunas de
    * grd_4c_ItensPendentes (SIGOPTOR.grdItem)
    *
    * Transcricao do dump: as 9 colunas do SCX foram RENOMEADAS pelo Form
    * Designer legado (Column5->"Column6", Column6->"Column7",
    * Column7->"Column8", Column8->"Column9", Column9->"Column10" -
    * Column1..Column4 mantiveram o nome), e o Init legado referencia as
    * colunas por esse NOME, nao pela posicao. Aqui NAO se renomeia nada
    * (regra do projeto - rename de Column quebra referencia default); a
    * tabela abaixo ja traduz nome-do-dump -> posicao real na grade:
    *
    *   pos | nome no dump | campo (TmpItePen) | Header          | Width | ColumnOrder
    *    1  | Column1      | DopeNums          | "Movimentacao"  | 180   | 1
    *    2  | Column2      | Qtds              | "Quantidade"    | 80    | 3
    *    3  | Column3      | Pesos             | "Periodo"       | 45    | 5
    *    4  | Column4      | Units             | "Unitario"      | 122   | 8
    *    5  | Column6      | Datas             | "Data"          | 75    | 2
    *    6  | Column7      | Fators            | "Turno"         | 45    | 7
    *    7  | Column8      | Dcunis            | "Unidade"       | 150   | 4
    *    8  | Column9      | DcuniPs           | "Unidade"       | 150   | 6
    *    9  | Column10     | Totas             | "Total"         | 122   | 9
    *
    * ColumnOrder reproduz a ORDEM VISUAL esquerda->direita do SCX (que
    * difere da ordem posicional/de criacao) - propriedade nativa de
    * Column, nao precisa de rename.
    *
    * InputMask das colunas Qtds/Pesos/Fators (posicoes 2, 3, 6): o legado
    * monta a mascara em RUNTIME a partir de crSigOpCdd.CasQtds/
    * crSigCdOpe.NCPesos - cursores do form pai FORA do escopo deste
    * acervo isolado (ver cabecalho de SIGOPTORBO.CarregarModoItensSubnivel,
    * que NAO os consulta). Usa-se o CASO BASE da formula legada
    * ('999999' + Iif(<decimais> > 0, ...)), que eh exatamente o literal
    * quando o cursor de referencia nao esta disponivel - nao eh invencao,
    * eh o primeiro termo da propria expressao do legado.
    *
    * ForeColor dos Header1: RGB(90, 90, 90) - canonico do projeto (regra
    * #12). O dump nao declara ForeColor nos Header1 (classe header do Form
    * Designer), entao vale o canonico.
    *
    * Metodo PUBLIC: chamado pela montagem (ConfigurarGrade) E pela recarga
    * (CarregarLista).
    *==========================================================================
    PROCEDURE AplicarFormatoGradeItem
        LOCAL loc_lAplicou
        loc_lAplicou = .F.

        IF PEMSTATUS(THIS, "grd_4c_ItensPendentes", 5)
            WITH THIS.grd_4c_ItensPendentes
                *-- pos1 - DopeNums / "Movimentacao"
                .Column1.Width             = 180
                .Column1.ColumnOrder       = 1
                .Column1.Movable           = .F.
                .Column1.Resizable         = .F.
                .Column1.FontName          = "Tahoma"
                .Column1.FontSize          = 8
                .Column1.ReadOnly          = .T.
                .Column1.Header1.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
                .Column1.Header1.FontName  = "Tahoma"
                .Column1.Header1.FontSize  = 8
                .Column1.Header1.Alignment = 2
                .Column1.Header1.ForeColor = RGB(90, 90, 90)
                .Column1.Text1.BorderStyle = 0
                .Column1.Text1.Margin      = 0
                .Column1.Text1.ReadOnly    = .T.
                .Column1.Text1.FontName    = "Tahoma"
                .Column1.Text1.FontSize    = 8
                .Column1.Text1.ForeColor   = RGB(0, 0, 0)
                .Column1.Text1.BackColor   = RGB(255, 255, 255)

                *-- pos2 - Qtds / "Quantidade" (InputMask: caso base, ver
                *-- comentario do metodo)
                .Column2.Width             = 80
                .Column2.ColumnOrder       = 3
                .Column2.Movable           = .F.
                .Column2.Resizable         = .F.
                .Column2.FontName          = "Tahoma"
                .Column2.FontSize          = 8
                .Column2.ReadOnly          = .T.
                .Column2.InputMask         = "999999"
                .Column2.Header1.Caption   = "Quantidade"
                .Column2.Header1.FontName  = "Tahoma"
                .Column2.Header1.FontSize  = 8
                .Column2.Header1.Alignment = 2
                .Column2.Header1.ForeColor = RGB(90, 90, 90)
                .Column2.Text1.BorderStyle = 0
                .Column2.Text1.Margin      = 0
                .Column2.Text1.ReadOnly    = .T.
                .Column2.Text1.InputMask   = "999999"
                .Column2.Text1.FontName    = "Tahoma"
                .Column2.Text1.ForeColor   = RGB(0, 0, 0)
                .Column2.Text1.BackColor   = RGB(255, 255, 255)

                *-- pos3 - Pesos / "Periodo" (header do dump, transcrito
                *-- literal - regra #17: transcrever, nao reescrever)
                .Column3.Width             = 45
                .Column3.ColumnOrder       = 5
                .Column3.Movable           = .F.
                .Column3.Resizable         = .F.
                .Column3.FontName          = "Tahoma"
                .Column3.FontSize          = 8
                .Column3.ReadOnly          = .T.
                .Column3.InputMask         = "999999"
                .Column3.Header1.Caption   = "Per" + CHR(237) + "odo"
                .Column3.Header1.FontName  = "Tahoma"
                .Column3.Header1.FontSize  = 8
                .Column3.Header1.Alignment = 2
                .Column3.Header1.ForeColor = RGB(90, 90, 90)
                .Column3.Text1.BorderStyle = 0
                .Column3.Text1.Margin      = 0
                .Column3.Text1.ReadOnly    = .T.
                .Column3.Text1.InputMask   = "999999"
                .Column3.Text1.FontName    = "Tahoma"
                .Column3.Text1.ForeColor   = RGB(0, 0, 0)
                .Column3.Text1.BackColor   = RGB(255, 255, 255)

                *-- pos4 - Units / "Unitario"
                .Column4.Width             = 122
                .Column4.ColumnOrder       = 8
                .Column4.Movable           = .F.
                .Column4.Resizable         = .F.
                .Column4.FontName          = "Tahoma"
                .Column4.FontSize          = 8
                .Column4.ReadOnly          = .T.
                .Column4.Header1.Caption   = "Unit" + CHR(225) + "rio"
                .Column4.Header1.FontName  = "Tahoma"
                .Column4.Header1.FontSize  = 8
                .Column4.Header1.Alignment = 2
                .Column4.Header1.ForeColor = RGB(90, 90, 90)
                .Column4.Text1.BorderStyle = 0
                .Column4.Text1.Margin      = 0
                .Column4.Text1.ReadOnly    = .T.
                .Column4.Text1.FontName    = "Tahoma"
                .Column4.Text1.ForeColor   = RGB(0, 0, 0)
                .Column4.Text1.BackColor   = RGB(255, 255, 255)

                *-- pos5 (nome no dump: Column6) - Datas / "Data"
                .Column5.Width             = 75
                .Column5.ColumnOrder       = 2
                .Column5.Movable           = .F.
                .Column5.Resizable         = .F.
                .Column5.FontName          = "Tahoma"
                .Column5.FontSize          = 8
                .Column5.ReadOnly          = .T.
                .Column5.Header1.Caption   = "Data"
                .Column5.Header1.FontName  = "Tahoma"
                .Column5.Header1.FontSize  = 8
                .Column5.Header1.Alignment = 2
                .Column5.Header1.ForeColor = RGB(90, 90, 90)
                .Column5.Text1.BorderStyle = 0
                .Column5.Text1.Margin      = 0
                .Column5.Text1.ReadOnly    = .T.
                .Column5.Text1.FontName    = "Tahoma"
                .Column5.Text1.ForeColor   = RGB(0, 0, 0)
                .Column5.Text1.BackColor   = RGB(255, 255, 255)

                *-- pos6 (nome no dump: Column7) - Fators / "Turno" (header
                *-- do dump, transcrito literal - mesma ressalva da pos3)
                .Column6.Width             = 45
                .Column6.ColumnOrder       = 7
                .Column6.Movable           = .F.
                .Column6.Resizable         = .F.
                .Column6.FontName          = "Tahoma"
                .Column6.FontSize          = 8
                .Column6.ReadOnly          = .T.
                .Column6.InputMask         = "999999"
                .Column6.Header1.Caption   = "Turno"
                .Column6.Header1.FontName  = "Tahoma"
                .Column6.Header1.FontSize  = 8
                .Column6.Header1.Alignment = 2
                .Column6.Header1.ForeColor = RGB(90, 90, 90)
                .Column6.Text1.BorderStyle = 0
                .Column6.Text1.Margin      = 0
                .Column6.Text1.ReadOnly    = .T.
                .Column6.Text1.InputMask   = "999999"
                .Column6.Text1.FontName    = "Tahoma"
                .Column6.Text1.ForeColor   = RGB(0, 0, 0)
                .Column6.Text1.BackColor   = RGB(255, 255, 255)

                *-- pos7 (nome no dump: Column8) - Dcunis / "Unidade"
                .Column7.Width             = 150
                .Column7.ColumnOrder       = 4
                .Column7.Movable           = .F.
                .Column7.Resizable         = .F.
                .Column7.FontName          = "Tahoma"
                .Column7.FontSize          = 8
                .Column7.ReadOnly          = .T.
                .Column7.Header1.Caption   = "Unidade"
                .Column7.Header1.FontName  = "Tahoma"
                .Column7.Header1.FontSize  = 8
                .Column7.Header1.Alignment = 2
                .Column7.Header1.ForeColor = RGB(90, 90, 90)
                .Column7.Text1.BorderStyle = 0
                .Column7.Text1.Margin      = 0
                .Column7.Text1.ReadOnly    = .T.
                .Column7.Text1.FontName    = "Tahoma"
                .Column7.Text1.ForeColor   = RGB(0, 0, 0)
                .Column7.Text1.BackColor   = RGB(255, 255, 255)

                *-- pos8 (nome no dump: Column9) - DcuniPs / "Unidade"
                .Column8.Width             = 150
                .Column8.ColumnOrder       = 6
                .Column8.Movable           = .F.
                .Column8.Resizable         = .F.
                .Column8.FontName          = "Tahoma"
                .Column8.FontSize          = 8
                .Column8.ReadOnly          = .T.
                .Column8.Header1.Caption   = "Unidade"
                .Column8.Header1.FontName  = "Tahoma"
                .Column8.Header1.FontSize  = 8
                .Column8.Header1.Alignment = 2
                .Column8.Header1.ForeColor = RGB(90, 90, 90)
                .Column8.Text1.BorderStyle = 0
                .Column8.Text1.Margin      = 0
                .Column8.Text1.ReadOnly    = .T.
                .Column8.Text1.FontName    = "Tahoma"
                .Column8.Text1.ForeColor   = RGB(0, 0, 0)
                .Column8.Text1.BackColor   = RGB(255, 255, 255)

                *-- pos9 (nome no dump: Column10) - Totas / "Total"
                .Column9.Width             = 122
                .Column9.ColumnOrder       = 9
                .Column9.Movable           = .F.
                .Column9.Resizable         = .F.
                .Column9.FontName          = "Tahoma"
                .Column9.FontSize          = 8
                .Column9.ReadOnly          = .T.
                .Column9.Header1.Caption   = "Total"
                .Column9.Header1.FontName  = "Tahoma"
                .Column9.Header1.FontSize  = 8
                .Column9.Header1.Alignment = 2
                .Column9.Header1.ForeColor = RGB(90, 90, 90)
                .Column9.Text1.BorderStyle = 0
                .Column9.Text1.Margin      = 0
                .Column9.Text1.ReadOnly    = .T.
                .Column9.Text1.FontName    = "Tahoma"
                .Column9.Text1.ForeColor   = RGB(0, 0, 0)
                .Column9.Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH

            loc_lAplicou = .T.
        ENDIF

        RETURN loc_lAplicou
    ENDPROC

    *==========================================================================
    * AplicarFormatoGradeTotPrev - FONTE UNICA da geometria das colunas de
    * grd_4c_TotalPorData (SIGOPTOR.GrdTotPrev)
    *
    * Transcricao do dump (SIGOPTOR.GrdTotPrev):
    *   Column1  Width=80  "Data"       (ControlSource: crTmpTotOrp.Datas)
    *   Column2  Width=122 "Previsto"   InputMask="99,999,999.99" (Valos)
    *   Column3  Width=122 "Realizado"  InputMask="99,999,999.99" (VlBaixas)
    *   Column4  Width=122 "Diferenca"  InputMask="99,999,999.99" na Column
    *            E "999999"/MaxLength=6/ReadOnly=.T. no Text1 (dois niveis
    *            distintos no dump - transcritos os dois, regra #17)
    *==========================================================================
    PROCEDURE AplicarFormatoGradeTotPrev
        LOCAL loc_lAplicou
        loc_lAplicou = .F.

        IF PEMSTATUS(THIS, "grd_4c_TotalPorData", 5)
            WITH THIS.grd_4c_TotalPorData
                .Column1.Width             = 80
                .Column1.Movable           = .F.
                .Column1.Resizable         = .F.
                .Column1.FontName          = "Tahoma"
                .Column1.FontSize          = 8
                .Column1.ReadOnly          = .T.
                .Column1.Header1.Caption   = "Data"
                .Column1.Header1.FontName  = "Tahoma"
                .Column1.Header1.FontSize  = 8
                .Column1.Header1.Alignment = 2
                .Column1.Header1.ForeColor = RGB(90, 90, 90)
                .Column1.Text1.BorderStyle = 0
                .Column1.Text1.Margin      = 0
                .Column1.Text1.FontName    = "Tahoma"
                .Column1.Text1.BackColor   = RGB(255, 255, 255)

                .Column2.Width             = 122
                .Column2.Movable           = .F.
                .Column2.Resizable         = .F.
                .Column2.FontName          = "Tahoma"
                .Column2.FontSize          = 8
                .Column2.ReadOnly          = .T.
                .Column2.InputMask         = "99,999,999.99"
                .Column2.Header1.Caption   = "Previsto"
                .Column2.Header1.FontName  = "Tahoma"
                .Column2.Header1.FontSize  = 8
                .Column2.Header1.Alignment = 2
                .Column2.Header1.ForeColor = RGB(90, 90, 90)
                .Column2.Text1.BorderStyle = 0
                .Column2.Text1.Margin      = 0
                .Column2.Text1.FontName    = "Tahoma"
                .Column2.Text1.BackColor   = RGB(255, 255, 255)

                .Column3.Width             = 122
                .Column3.FontName          = "Tahoma"
                .Column3.FontSize          = 8
                .Column3.ReadOnly          = .T.
                .Column3.InputMask         = "99,999,999.99"
                .Column3.Header1.Caption   = "Realizado"
                .Column3.Header1.FontName  = "Tahoma"
                .Column3.Header1.FontSize  = 8
                .Column3.Header1.Alignment = 2
                .Column3.Header1.ForeColor = RGB(90, 90, 90)
                .Column3.Text1.BorderStyle = 0
                .Column3.Text1.Margin      = 0
                .Column3.Text1.FontName    = "Tahoma"
                .Column3.Text1.BackColor   = RGB(255, 255, 255)

                .Column4.Width             = 122
                .Column4.Movable           = .F.
                .Column4.Resizable         = .F.
                .Column4.FontName          = "Tahoma"
                .Column4.FontSize          = 8
                .Column4.ReadOnly          = .T.
                .Column4.InputMask         = "99,999,999.99"
                .Column4.Header1.Caption   = "Diferen" + CHR(231) + "a"
                .Column4.Header1.FontName  = "Tahoma"
                .Column4.Header1.FontSize  = 8
                .Column4.Header1.Alignment = 2
                .Column4.Header1.ForeColor = RGB(90, 90, 90)
                .Column4.Text1.BorderStyle = 0
                .Column4.Text1.InputMask   = "999999"
                .Column4.Text1.Margin      = 0
                .Column4.Text1.MaxLength   = 6
                .Column4.Text1.ReadOnly    = .T.
                .Column4.Text1.FontName    = "Tahoma"
                .Column4.Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH

            loc_lAplicou = .T.
        ENDIF

        RETURN loc_lAplicou
    ENDPROC

    *==========================================================================
    * AplicarFormatoGradeTotal - FONTE UNICA da geometria das colunas de
    * grd_4c_TotalGeral (SIGOPTOR.grdTotal)
    *
    * Transcricao do dump (SIGOPTOR.grdTotal):
    *   Column1  Width=200 "Item"      (ControlSource: crTmpTotal.Dpros)
    *   Column2  Width=122 "Total NFs" InputMask="99,999,999.99" (Tota1s)
    *==========================================================================
    PROCEDURE AplicarFormatoGradeTotal
        LOCAL loc_lAplicou
        loc_lAplicou = .F.

        IF PEMSTATUS(THIS, "grd_4c_TotalGeral", 5)
            WITH THIS.grd_4c_TotalGeral
                .Column1.Width             = 200
                .Column1.Movable           = .F.
                .Column1.Resizable         = .F.
                .Column1.FontName          = "Tahoma"
                .Column1.FontSize          = 8
                .Column1.ReadOnly          = .T.
                .Column1.Header1.Caption   = "Item"
                .Column1.Header1.FontName  = "Tahoma"
                .Column1.Header1.FontSize  = 8
                .Column1.Header1.Alignment = 2
                .Column1.Header1.ForeColor = RGB(90, 90, 90)
                .Column1.Text1.BorderStyle = 0
                .Column1.Text1.Margin      = 0
                .Column1.Text1.FontName    = "Tahoma"
                .Column1.Text1.BackColor   = RGB(255, 255, 255)

                .Column2.Width             = 122
                .Column2.Movable           = .F.
                .Column2.Resizable         = .F.
                .Column2.FontName          = "Tahoma"
                .Column2.FontSize          = 8
                .Column2.ReadOnly          = .T.
                .Column2.InputMask         = "99,999,999.99"
                .Column2.Header1.Caption   = "Total NFs"
                .Column2.Header1.FontName  = "Tahoma"
                .Column2.Header1.FontSize  = 8
                .Column2.Header1.Alignment = 2
                .Column2.Header1.ForeColor = RGB(90, 90, 90)
                .Column2.Text1.BorderStyle = 0
                .Column2.Text1.Margin      = 0
                .Column2.Text1.FontName    = "Tahoma"
                .Column2.Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH

            loc_lAplicou = .T.
        ENDIF

        RETURN loc_lAplicou
    ENDPROC

    *==========================================================================
    * ConfigurarCamposPrincipais - FASE 5 (1a metade dos campos): Say2/
    * getDProd do legado -> lbl_4c_Label2/txt_4c_DProd. Sao os campos do
    * modo "Itens Subnivel" (legado: ramo ELSE do Init - ver cabecalho de
    * CarregarModoItensSubnivelNaTela). A 2a metade (getTotPrev/getTotReal/
    * getTotDif - modo "P", com a atribuicao de .Value que o Init legado
    * faz a partir de crTmpTotOrp2) fica para a Fase 6.
    *
    * Direto em THIS (sem container), igual aos demais controles deste
    * form FLAT (grades, cmg_4c_OK) - SIGOPTOR nao tem PageFrame no SCX.
    *
    * lbl_4c_Label2 (Say2): dump nao declara Width nem Alignment - classe
    * 'say' pura do Framework legado (regra #23). AutoSize=.T. eh no-op em
    * Label criado por AddObject, por isso Width/Height explicitos abaixo
    * (texto curto, uma linha), com Alignment=0 (esquerda, como o legado).
    *
    * txt_4c_DProd (getDProd): ControlSource = "crSigMvOrc.DPros" no dump -
    * cursor do FORM PAI, visivel aqui porque este dialogo roda na mesma
    * DataSession (DataSession=1, Fase 3). Guardado por USED(): em modo
    * teste/validacao de UI o cursor do pai nao existe, e sem a guarda a
    * atribuicao de ControlSource estouraria "Alias nao encontrado" dentro
    * do TRY de InicializarForm.
    *
    * When = .F. (dump: "PROCEDURE When / Return .f.") - o campo nunca
    * recebe foco via Tab/clique, so exibe. O LostFocus do dump ("If
    * ThisForm.fwGrade.Visible / ThisForm.fwGrade.SetFocus / EndIf")
    * referencia um objeto "fwGrade" que NAO existe neste SCX (nenhum grid
    * do form se chama assim) - boilerplate de classe-base nunca
    * customizado para esta instancia; como When=.F. ja bloqueia o foco,
    * esse LostFocus eh inalcancavel por construcao e NAO foi reproduzido
    * (regra #13 - nunca referenciar objeto que nao existe).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposPrincipais
        *-- Say2 -> lbl_4c_Label2 ("Descricao")
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
            .Top       = 122
            .Left      = 19
            .Width     = 70
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- getDProd -> txt_4c_DProd (descricao do produto, espelhando o
        *-- cursor do form pai)
        THIS.AddObject("txt_4c_DProd", "TextBox")
        WITH THIS.txt_4c_DProd
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Format            = "K!"
            .Top               = 135
            .Left              = 19
            .Width             = 288
            .Height            = 23
            .SpecialEffect     = 1
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(255, 255, 255)
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(192, 192, 192)
            .BorderColor       = RGB(100, 100, 100)
            .ToolTipText       = "Descri" + CHR(231) + CHR(227) + "o do Produto"
            .Value             = ""

            IF USED("crSigMvOrc")
                .ControlSource = "crSigMvOrc.DPros"
            ENDIF

            .Visible = .T.
        ENDWITH

        *-- getDProd.When do legado - metodo PUBLIC (regra #3: BINDEVENT
        *-- exige metodo PUBLIC, PROTECTED falha em silencio)
        BINDEVENT(THIS.txt_4c_DProd, "When", THIS, "TxtDProdWhen")
    ENDPROC

    *==========================================================================
    * TxtDProdWhen - getDProd.When do legado ("PROCEDURE When / Return
    * .f."): o campo nunca recebe foco, eh so exibicao.
    *==========================================================================
    PROCEDURE TxtDProdWhen
        RETURN .F.
    ENDPROC

    *==========================================================================
    * ConfigurarCamposTotalizadores - FASE 6 (2a metade dos campos):
    * getTotPrev/getTotReal/getTotDif do legado -> txt_4c_TotPrev/
    * txt_4c_TotReal/txt_4c_TotDif. Sao os totalizadores do modo "P" (Total
    * Previsao - legado: ramo "If pVisual = [P]" do Init, ver cabecalho de
    * CarregarModoPrevisaoNaTela), que exibem Sum(Valos)/Sum(VlBaixas)/
    * Sum(Valos-VlBaixas) de crSigMvOrp SEM Group By (uma unica linha,
    * diferente da grade grd_4c_TotalPorData, que agrupa por Datas).
    *
    * Direto em THIS (sem container), igual aos demais controles deste
    * form FLAT (grades, txt_4c_DProd, cmg_4c_OK).
    *
    * Transcricao do dump (os 3 controles tem as MESMAS propriedades, so
    * variando Left=315/438/561): Format="K!" Height=23 Width=122
    * SpecialEffect=1 Top=568 ForeColor=0,0,0 DisabledBackColor=255,255,255
    * DisabledForeColor=0,0,255 BorderColor=100,100,100.
    *
    * ZOrderSet=5/plprocurar=.T. do dump NAO sao transcritos: ZOrderSet eh
    * bookkeeping do Form Designer, sem efeito em runtime (regra #33,
    * mesma familia do ZOrderSet ja descartado nos dialogos irmaos desta
    * familia); plprocurar eh flag do fwget legado que habilitaria um
    * botao de lookup, mas este form NAO TEM NENHUM LOOKUP (comportamento.
    * json: zero fwbuscaext/fwBuscaSel/sigacess) - os 3 campos tem
    * When=.F. (nunca recebem foco) e sao alimentados so por .Value
    * atribuido em CarregarModoPrevisaoNaTela, nunca digitados.
    *
    * FontName/FontSize NAO constam no dump destes 3 controles (ao
    * contrario de getDProd, que os declara explicitamente) - usa-se
    * Tahoma 8, o default do form (unico par presente na tabela de fontes
    * do dump e usado em TODOS os demais controles deste SCX).
    *
    * .Value inicializado como 0 (NUMERICO - os 3 campos exibem soma
    * monetaria via Nvl(...,0) no legado, nunca texto), e SEM
    * ControlSource (o legado tambem nao liga por ControlSource: atribui
    * .Value direto no Init a partir de crTmpTotOrp2).
    *
    * When = .F. nos 3 (dump: "PROCEDURE When / Return .f." repetido em
    * getTotPrev/getTotReal/getTotDif) - mesmo padrao de getDProd (Fase 5).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposTotalizadores
        *-- getTotPrev -> txt_4c_TotPrev
        THIS.AddObject("txt_4c_TotPrev", "TextBox")
        WITH THIS.txt_4c_TotPrev
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Format            = "K!"
            .Top               = 568
            .Left              = 315
            .Width             = 122
            .Height            = 23
            .SpecialEffect     = 1
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(0, 0, 255)
            .BorderColor       = RGB(100, 100, 100)
            .ToolTipText       = "Nome do Relat" + CHR(243) + "rio"
            .Value             = 0
            .Visible           = .T.
        ENDWITH
        BINDEVENT(THIS.txt_4c_TotPrev, "When", THIS, "TxtTotPrevWhen")

        *-- getTotReal -> txt_4c_TotReal
        THIS.AddObject("txt_4c_TotReal", "TextBox")
        WITH THIS.txt_4c_TotReal
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Format            = "K!"
            .Top               = 568
            .Left              = 438
            .Width             = 122
            .Height            = 23
            .SpecialEffect     = 1
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(0, 0, 255)
            .BorderColor       = RGB(100, 100, 100)
            .ToolTipText       = "Nome do Relat" + CHR(243) + "rio"
            .Value             = 0
            .Visible           = .T.
        ENDWITH
        BINDEVENT(THIS.txt_4c_TotReal, "When", THIS, "TxtTotRealWhen")

        *-- getTotDif -> txt_4c_TotDif
        THIS.AddObject("txt_4c_TotDif", "TextBox")
        WITH THIS.txt_4c_TotDif
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Format            = "K!"
            .Top               = 568
            .Left              = 561
            .Width             = 122
            .Height            = 23
            .SpecialEffect     = 1
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(0, 0, 255)
            .BorderColor       = RGB(100, 100, 100)
            .ToolTipText       = "Nome do Relat" + CHR(243) + "rio"
            .Value             = 0
            .Visible           = .T.
        ENDWITH
        BINDEVENT(THIS.txt_4c_TotDif, "When", THIS, "TxtTotDifWhen")
    ENDPROC

    *==========================================================================
    * TxtTotPrevWhen/TxtTotRealWhen/TxtTotDifWhen - getTotPrev.When/
    * getTotReal.When/getTotDif.When do legado ("PROCEDURE When / Return
    * .f."): os 3 campos nunca recebem foco, sao so exibicao.
    *==========================================================================
    PROCEDURE TxtTotPrevWhen
        RETURN .F.
    ENDPROC

    PROCEDURE TxtTotRealWhen
        RETURN .F.
    ENDPROC

    PROCEDURE TxtTotDifWhen
        RETURN .F.
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - OK.btnSair do legado -> cmg_4c_OK (CommandGroup,
    * ButtonCount=1) + Buttons(1) "Retornar"
    *
    * Transcricao do dump: OK AutoSize=.T. BackStyle=0 BorderStyle=0
    * SpecialEffect=1 BorderColor=136,189,188 Themes=.F. Top=-2 Left=920
    * Width=85 Height=85; Command1 (nome legado "btnSair") Top=5 Left=5
    * Width=75 Height=75 Caption="Retornar" Cancel=.T.
    * Picture=cadastro_salvar_60.jpg (regra #25 - transcrever o Picture do
    * legado LITERAL, mesmo parecendo semanticamente estranho para um
    * botao de saida - "Retornar" usa o icone de salvar no SCX original).
    *
    * Buttons(1) configurado em WITH ANINHADO dentro do WITH do grupo - UM
    * nivel de nesting em CommandGroup eh seguro (ao contrario de Container/
    * Label, onde AddObject+WITH aninhado falha em silencio).
    *
    * Themes = .F. no Buttons(1): canonico para botao DENTRO de
    * CommandGroup (diferente do standalone, que precisa Themes=.T. +
    * DisabledPicture para o icone aparecer - regra do projeto).
    *
    * O Click vai no BOTAO (Buttons(1)), nao no Click do GRUPO: o dump
    * mostra "PROCEDURE btnSair.Click" (evento do MEMBRO, nao do
    * CommandGroup) - comportamento.json confirma em "SIGOPTOR.OK"
    * evento "Click" com o codigo do btnSair.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes
        LOCAL loc_cIconeRetornar
        loc_cIconeRetornar = ""

        IF TYPE("gc_4c_CaminhoIcones") = "C"
            loc_cIconeRetornar = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
        ENDIF

        THIS.AddObject("cmg_4c_OK", "CommandGroup")
        WITH THIS.cmg_4c_OK
            .ButtonCount   = 1
            .AutoSize      = .T.
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Themes        = .F.
            .Top           = -2
            .Left          = 920
            .Width         = 85
            .Height        = 85
            .TabIndex      = 1

            WITH .Buttons(1)
                .Top          = 5
                .Left         = 5
                .Height       = 75
                .Width        = 75
                .FontBold     = .T.
                .FontItalic   = .T.
                .FontName     = "Comic Sans MS"
                .FontSize     = 8
                .WordWrap     = .T.
                .Cancel       = .T.
                .Caption      = "Retornar"
                .MousePointer = 15
                .SpecialEffect = 0
                .ForeColor    = RGB(90, 90, 90)
                .BackColor    = RGB(255, 255, 255)
                .Themes       = .F.
                .ToolTipText  = "[Esc] Voltar Para a Tela Principal da Opera" + CHR(231) + CHR(227) + "o"

                IF !EMPTY(loc_cIconeRetornar) AND FILE(loc_cIconeRetornar)
                    .Picture = loc_cIconeRetornar
                ENDIF
            ENDWITH

            .Visible = .T.
        ENDWITH

        *-- btnSair.Click do legado. BINDEVENT ligado aqui, junto com o
        *-- AddObject, em vez de deixar o unico botao da tela inerte ate a
        *-- fase de eventos: sem TitleBar/ControlBox esta tela nao teria
        *-- saida pelo mouse nesse intervalo
        BINDEVENT(THIS.cmg_4c_OK.Buttons(1), "Click", THIS, "BtnSairClick")
    ENDPROC

    *==========================================================================
    * BtnSairClick - btnSair.Click do legado, transcrito:
    *
    *     ThisForm.ParentForm.Enabled = .t.
    *     ThisForm.Release()
    *
    * Nome do metodo segue o nome do OBJETO legado (btnSair), nao a Caption
    * exibida ("Retornar") - regra do projeto: handler nomeado pelo objeto
    * do legado, nao pela acao/caption (harness BtnEncerrarExiste procura
    * por BtnEncerrarClick/BtnFecharClick/BtnSairClick).
    *
    * Metodo PUBLIC (regra #3): BINDEVENT falha em SILENCIO com PROTECTED.
    *
    * O Destroy deste form repete o Enabled = .T. como rede de seguranca
    * (ESC/Alt+F4/erro nao passam por aqui); reabilitar duas vezes eh
    * inofensivo, e o Destroy ainda zera this_oFormPai.
    *
    * THIS.Release() direto reproduz o "ThisForm.Release" do legado: este
    * dialogo eh so consulta e nao devolve resultado nenhum ao chamador.
    *==========================================================================
    PROCEDURE BtnSairClick
        IF VARTYPE(THIS.this_oFormPai) = "O"
            IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
                THIS.this_oFormPai.Enabled = .T.
            ENDIF
        ENDIF

        THIS.Release()
    ENDPROC

    *==========================================================================
    * CarregarLista - funil de carga. Reproduz o trecho final do Init
    * legado: despacha para o modo "P" (Total Previsao) ou o modo "Itens
    * Subnivel", conforme this_cModoVisual (normalizado no Init - Fase 3).
    *
    * Os cursores do form pai (crSigMvOrp/crSigMvOrc) sao lidos pelo NOME
    * LITERAL do legado: como este dialogo roda na MESMA DataSession do
    * pai (DataSession = 1 - ver comentario da property, Fase 3), esses
    * aliases - quando o form pai de Orcamento/Pre-Custo estiver migrado e
    * os tiver aberto - ja estao diretamente visiveis aqui, sem precisar
    * de parametro extra no Init (equivalente ao "Set Datasession To
    * DatSes" do legado). Guardas USED() cobrem o caso de nao estarem
    * abertos (modo teste/validacao de UI, ou form pai ainda nao migrado -
    * FormOPE, task483, ainda em Fase A): a grade fica vazia, so formatada.
    *
    * Metodo PUBLIC (regra #3): o harness de teste o alcanca de fora, sem
    * argumento algum - a operacao a consultar vem de
    * THIS.this_oBusinessObject.this_nCodigoAtual/this_cProdutoAtual (modo
    * item) ou dos cursores do pai (modo previsao), nao de parametro.
    *
    * RETURN unico, FORA do TRY/CATCH (regra #1).
    *==========================================================================
    PROCEDURE CarregarLista
        LOCAL loc_lCarregou, loc_oErro
        loc_lCarregou = .F.

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        IF !PEMSTATUS(THIS, "grd_4c_TotalPorData", 5) OR ;
           !PEMSTATUS(THIS, "grd_4c_TotalGeral", 5) OR ;
           !PEMSTATUS(THIS, "grd_4c_ItensPendentes", 5)
            RETURN .F.
        ENDIF

        TRY
            IF THIS.this_cModoVisual == "P"
                loc_lCarregou = THIS.CarregarModoPrevisaoNaTela()
            ELSE
                loc_lCarregou = THIS.CarregarModoItensSubnivelNaTela()
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao carregar os dados do dialogo: " + loc_oErro.Message + ;
                    " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    " | Procedure: " + loc_oErro.Procedure, THIS.Caption)
            loc_lCarregou = .F.
        ENDTRY

        RETURN loc_lCarregou
    ENDPROC

    *==========================================================================
    * CarregarModoPrevisaoNaTela - Modo "P" (legado: ramo "If pVisual = [P]"
    * do Init). Chama SIGOPTORBO.CarregarModoPrevisao (Fases 1-2) com os
    * cursores do form pai (crSigMvOrp/crSigMvOrc), faz o bind das duas
    * grades e o toggle de Visible por modo.
    *
    * PUBLIC (regra #3 - o harness tambem pode querer exercitar so este
    * ramo). Chamado so por CarregarLista, mas protected esbarraria na
    * mesma regra do metodo chamador.
    *==========================================================================
    PROCEDURE CarregarModoPrevisaoNaTela
        LOCAL loc_lCarregou, loc_cAliasOrp, loc_cAliasOrc
        loc_lCarregou = .T.
        loc_cAliasOrp = "crSigMvOrp"
        loc_cAliasOrc = "crSigMvOrc"

        THIS.Caption = "Total Previs" + CHR(227) + "o"
        THIS.AtualizarCaptionCabecalho()

        *-- Legado: Thisform.grdTotPrev.RecordSource = [] (reset) antes de
        *-- montar o cursor - aqui o reset so importa se havia bind de uma
        *-- carga anterior (troca de modo em tempo de execucao nao ocorre
        *-- neste dialogo, mas o IF USED cobre o caso de reentrada)
        IF USED(loc_cAliasOrp) AND USED(loc_cAliasOrc)
            IF THIS.this_oBusinessObject.CarregarModoPrevisao(loc_cAliasOrp, loc_cAliasOrc)
                *-- Legado: "If !Eof('crTmpTotOrp') / With ... EndWith" - so
                *-- liga a grade quando ha pelo menos 1 linha
                IF THIS.this_oBusinessObject.this_nTotalRegistrosTotPrev > 0
                    THIS.VincularGradeTotPrev()
                ENDIF

                *-- Legado: "If !Eof('crTmpTotal') / With ... EndWith"
                IF THIS.this_oBusinessObject.this_nTotalRegistrosTotal > 0
                    THIS.VincularGradeTotal()
                ENDIF

                *-- Legado: "thisform.getTotPrev.Value = Nvl(crTmpTotOrp2.
                *-- Valos,0)" e os 2 seguintes - atribuidos SEMPRE que a
                *-- consulta (Sum sem Group By, CarregarTotaisGerais nas
                *-- Fases 1-2) teve sucesso, FORA dos dois IFs acima (o
                *-- legado nao condiciona isso a nenhuma das grades terem
                *-- linha)
                IF PEMSTATUS(THIS, "txt_4c_TotPrev", 5)
                    THIS.txt_4c_TotPrev.Value = THIS.this_oBusinessObject.this_nTotalPrevisto
                ENDIF
                IF PEMSTATUS(THIS, "txt_4c_TotReal", 5)
                    THIS.txt_4c_TotReal.Value = THIS.this_oBusinessObject.this_nTotalRealizado
                ENDIF
                IF PEMSTATUS(THIS, "txt_4c_TotDif", 5)
                    THIS.txt_4c_TotDif.Value = THIS.this_oBusinessObject.this_nTotalDiferenca
                ENDIF
            ELSE
                IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                    THIS.this_cMensagemErro = THIS.this_oBusinessObject.this_cMensagemErro
                    MsgErro(THIS.this_cMensagemErro, THIS.Caption)
                ENDIF
            ENDIF
        ENDIF

        *-- Legado: thisform.grdItem/say2/getDProd.Visible = .f. e
        *-- grdTotPrev/getTotPrev/getTotReal/getTotDif.Visible = .t.
        THIS.grd_4c_ItensPendentes.Visible = .F.
        THIS.grd_4c_TotalPorData.Visible   = .T.
        THIS.grd_4c_TotalGeral.Visible     = .T.

        *-- getDProd/Say2/getTotPrev/getTotReal/getTotDif ainda nao existem
        *-- (Fases 5-6) - guardados por PEMSTATUS para a extensao futura
        *-- nao precisar duplicar este funil
        IF PEMSTATUS(THIS, "txt_4c_DProd", 5)
            THIS.txt_4c_DProd.Visible = .F.
        ENDIF
        IF PEMSTATUS(THIS, "lbl_4c_Label2", 5)
            THIS.lbl_4c_Label2.Visible = .F.
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_TotPrev", 5)
            THIS.txt_4c_TotPrev.Visible = .T.
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_TotReal", 5)
            THIS.txt_4c_TotReal.Visible = .T.
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_TotDif", 5)
            THIS.txt_4c_TotDif.Visible = .T.
        ENDIF

        RETURN loc_lCarregou
    ENDPROC

    *==========================================================================
    * VincularGradeTotPrev - bind de grd_4c_TotalPorData ao cursor que o BO
    * acabou de montar (ColumnCount FORA do WITH que atribui RecordSource -
    * regra GRIDWITHFP: acessar .Column dentro do mesmo WITH que atribui
    * RecordSource estoura "Unknown member COLUMNN").
    *==========================================================================
    PROTECTED PROCEDURE VincularGradeTotPrev
        LOCAL loc_cAlias
        loc_cAlias = THIS.this_oBusinessObject.this_cCursorTotalPorData

        THIS.grd_4c_TotalPorData.ColumnCount  = 4
        THIS.grd_4c_TotalPorData.RecordSource = loc_cAlias

        WITH THIS.grd_4c_TotalPorData
            .Column1.ControlSource = loc_cAlias + ".Datas"
            .Column2.ControlSource = loc_cAlias + ".Valos"
            .Column3.ControlSource = loc_cAlias + ".VlBaixas"
            .Column4.ControlSource = loc_cAlias + ".VlPends"
        ENDWITH

        *-- Reaplica largura/cabecalho, que o RecordSource zerou
        THIS.AplicarFormatoGradeTotPrev()

        *-- Legado: Select crTmpTotOrp / Go Top (a grade ja refresca sozinha
        *-- ao religar RecordSource, mas o GO TOP + Refresh explicito segue
        *-- a regra #21a do projeto)
        SELECT (loc_cAlias)
        GO TOP
        THIS.grd_4c_TotalPorData.Refresh()
    ENDPROC

    *==========================================================================
    * VincularGradeTotal - bind de grd_4c_TotalGeral ao cursor que o BO
    * acabou de montar. Mesma ressalva do GRIDWITHFP acima.
    *==========================================================================
    PROTECTED PROCEDURE VincularGradeTotal
        LOCAL loc_cAlias
        loc_cAlias = THIS.this_oBusinessObject.this_cCursorTotalGeral

        THIS.grd_4c_TotalGeral.ColumnCount  = 2
        THIS.grd_4c_TotalGeral.RecordSource = loc_cAlias

        WITH THIS.grd_4c_TotalGeral
            .Column1.ControlSource = loc_cAlias + ".Dpros"
            .Column2.ControlSource = loc_cAlias + ".Tota1s"
        ENDWITH

        THIS.AplicarFormatoGradeTotal()

        SELECT (loc_cAlias)
        GO TOP
        THIS.grd_4c_TotalGeral.Refresh()
    ENDPROC

    *==========================================================================
    * CarregarModoItensSubnivelNaTela - Modo "Itens Subnivel" (legado: ramo
    * ELSE do Init, comentario "Tiago - 14/04/2014 - SRCOM"). Le o contexto
    * (nCodigos/Cpros/Emps) de crSigMvOrc - cursor do form pai, ja na
    * DataSession compartilhada - chama SIGOPTORBO.CarregarModoItensSubnivel
    * (Fases 1-2) e faz o bind de grdItem.
    *
    * Legado: "If Eof([TmpItePen]) / ThisForm.ParentForm.Enabled = .t. /
    * Return .f. / Endif" - quando a cadeia de subniveis nao acha NENHUM
    * item, o Init aborta (devolve .F., e CREATEOBJECT no chamador nunca
    * chega a existir). Reproduzido aqui: RETURN .F. propaga para
    * CarregarLista -> InicializarForm -> FormBase.Init -> CREATEOBJECT.
    *
    * PUBLIC pela mesma razao de CarregarModoPrevisaoNaTela.
    *==========================================================================
    PROCEDURE CarregarModoItensSubnivelNaTela
        LOCAL loc_lCarregou, loc_nCodigo, loc_cCpros, loc_cEmps
        loc_lCarregou = .F.

        THIS.Caption = "Itens Subn" + CHR(237) + "vel"
        THIS.AtualizarCaptionCabecalho()

        IF !USED("crSigMvOrc") OR EOF("crSigMvOrc")
            *-- Sem o contexto do form pai (modo teste/validacao de UI, ou
            *-- FormOPE - task483 - ainda nao migrado) nao ha o que buscar.
            *-- Nao eh o "Return .f." do legado (aquele pressupoe contexto
            *-- valido e cadeia vazia) - aqui simplesmente nao ha contexto
            THIS.grd_4c_ItensPendentes.Visible = .T.
            THIS.grd_4c_TotalPorData.Visible   = .F.
            THIS.grd_4c_TotalGeral.Visible     = .F.
            RETURN .T.
        ENDIF

        loc_nCodigo = TratarNulo(crSigMvOrc.nCodigos, 0)
        loc_cCpros  = TratarNulo(crSigMvOrc.Cpros, "")

        *-- par_cEmps substitui TprMvCab.Emps do legado (cursor fora do
        *-- escopo deste acervo isolado - ver cabecalho de SIGOPTORBO):
        *-- usa Emps do proprio crSigMvOrc quando existir, senao a empresa
        *-- corrente do sistema (fallback documentado no BO)
        IF TYPE("crSigMvOrc.Emps") = "C"
            loc_cEmps = TratarNulo(crSigMvOrc.Emps, "")
        ELSE
            loc_cEmps = go_4c_Sistema.cCodEmpresa
        ENDIF

        IF THIS.this_oBusinessObject.CarregarModoItensSubnivel(loc_nCodigo, loc_cCpros, loc_cEmps)

            IF THIS.this_oBusinessObject.this_nTotalRegistrosItens > 0
                THIS.VincularGradeItem()

                THIS.grd_4c_ItensPendentes.Visible = .T.
                THIS.grd_4c_TotalPorData.Visible   = .F.
                THIS.grd_4c_TotalGeral.Visible     = .F.

                IF PEMSTATUS(THIS, "txt_4c_DProd", 5)
                    THIS.txt_4c_DProd.Visible = .T.
                ENDIF
                IF PEMSTATUS(THIS, "lbl_4c_Label2", 5)
                    THIS.lbl_4c_Label2.Visible = .T.
                ENDIF
                IF PEMSTATUS(THIS, "txt_4c_TotPrev", 5)
                    THIS.txt_4c_TotPrev.Visible = .F.
                ENDIF
                IF PEMSTATUS(THIS, "txt_4c_TotReal", 5)
                    THIS.txt_4c_TotReal.Visible = .F.
                ENDIF
                IF PEMSTATUS(THIS, "txt_4c_TotDif", 5)
                    THIS.txt_4c_TotDif.Visible = .F.
                ENDIF

                loc_lCarregou = .T.
            ELSE
                *-- Legado: cadeia nao achou nenhum item - aborta e
                *-- reabilita o pai (Return .f. do Init)
                IF VARTYPE(THIS.this_oFormPai) = "O"
                    IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
                        THIS.this_oFormPai.Enabled = .T.
                    ENDIF
                ENDIF
                loc_lCarregou = .F.
            ENDIF
        ELSE
            *-- Falha de conexao/SQL dentro da cadeia (loc_lErroFatal no BO)
            IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                THIS.this_cMensagemErro = THIS.this_oBusinessObject.this_cMensagemErro
                MsgErro(THIS.this_cMensagemErro, THIS.Caption)
            ENDIF

            IF VARTYPE(THIS.this_oFormPai) = "O"
                IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
                    THIS.this_oFormPai.Enabled = .T.
                ENDIF
            ENDIF
            loc_lCarregou = .F.
        ENDIF

        RETURN loc_lCarregou
    ENDPROC

    *==========================================================================
    * VincularGradeItem - bind de grd_4c_ItensPendentes ao cursor que o BO
    * acabou de montar. Mesma ressalva do GRIDWITHFP (ColumnCount/
    * RecordSource FORA do WITH que acessa .Column).
    *==========================================================================
    PROTECTED PROCEDURE VincularGradeItem
        LOCAL loc_cAlias
        loc_cAlias = THIS.this_oBusinessObject.this_cCursorItensPendentes

        THIS.grd_4c_ItensPendentes.ColumnCount  = 9
        THIS.grd_4c_ItensPendentes.RecordSource = loc_cAlias

        WITH THIS.grd_4c_ItensPendentes
            .Column1.ControlSource = loc_cAlias + ".DopeNums"
            .Column2.ControlSource = loc_cAlias + ".Qtds"
            .Column3.ControlSource = loc_cAlias + ".Pesos"
            .Column4.ControlSource = loc_cAlias + ".Units"
            .Column5.ControlSource = loc_cAlias + ".Datas"
            .Column6.ControlSource = loc_cAlias + ".Fators"
            .Column7.ControlSource = loc_cAlias + ".Dcunis"
            .Column8.ControlSource = loc_cAlias + ".Dcunips"
            .Column9.ControlSource = loc_cAlias + ".Totas"
        ENDWITH

        THIS.AplicarFormatoGradeItem()

        SELECT (loc_cAlias)
        GO TOP
        THIS.grd_4c_ItensPendentes.Refresh()
    ENDPROC

    *==========================================================================
    * AtualizarCaptionCabecalho - propaga THIS.Caption (ja atualizado por
    * CarregarModoPrevisaoNaTela/CarregarModoItensSubnivelNaTela) para os
    * dois labels do cabecalho (legado: os dois Caption de cntSombra
    * seguem ThisForm.Caption, que o Init tambem reatribui dentro de cada
    * ramo do IF).
    *==========================================================================
    PROTECTED PROCEDURE AtualizarCaptionCabecalho
        IF PEMSTATUS(THIS, "cnt_4c_Cabecalho", 5)
            IF PEMSTATUS(THIS.cnt_4c_Cabecalho, "lbl_4c_Sombra", 5)
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            ENDIF
            IF PEMSTATUS(THIS.cnt_4c_Cabecalho, "lbl_4c_Titulo", 5)
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - AddObject cria controle com Visible = .F.
    * por padrao; percorre recursivamente o container repondo Visible = .T.
    * Este form nao tem container flutuante (Visible = .F. proposital) a
    * filtrar nesta fase - os toggles por modo (grdItem/Say2/getDProd x
    * grdTotPrev/grdTotal/totalizadores) sao aplicados pelo funil de carga
    * (Fase 4), DEPOIS desta chamada.
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
                   loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy - Reabilita o form pai ao fechar este dialogo (legado:
    * so o caminho de ERRO do Init faz .ParentForm.Enabled = .t. antes do
    * Return .f.; o BtnSairClick - Fase 4 - repete no caminho normal
    * - ThisForm.ParentForm.Enabled = .t. + ThisForm.Release). Aqui fica
    * como rede de seguranca para qualquer caminho de fechamento que nao
    * passe pelo botao (ESC/Alt+F4/erro).
    *
    * Fecha tambem os 3 cursores das grades (LimparCursoresGrade do BO -
    * legado: PROCEDURE Release fazia Use In crTmpTotOrp/crTmpTotOrp2/
    * TmpItePen antes do Dodefault()). Como o form roda na DataSession do
    * pai (DataSession = 1), deixar os aliases abertos poluiria a sessao
    * compartilhada.
    *==========================================================================
    PROCEDURE Destroy
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.LimparCursoresGrade()
        ENDIF

        IF VARTYPE(THIS.this_oFormPai) = "O"
            *-- PEMSTATUS: em modo teste o "form pai" pode ser um objeto
            *-- simples, sem a property Enabled. Sem a guarda, o teardown
            *-- estoura "Property ENABLED is not found" depois de o
            *-- dialogo ja ter fechado
            IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
                THIS.this_oFormPai.Enabled = .T.
            ENDIF

            THIS.this_oFormPai = .NULL.
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
