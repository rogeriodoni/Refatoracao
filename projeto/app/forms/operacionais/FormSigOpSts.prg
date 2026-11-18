*==============================================================================
* FORMSIGOPSTS.PRG - Formulario Operacional: Status por Operacoes
* Tipo: OPERACIONAL (dialogo modal FILHO, layout FLAT - sem PageFrame)
* Migrado de SigOpSts.SCX (task808)
*
* Pilares:
*   UX   -> layout identico ao legado (600x350, TitleBar=0, ControlBox=.F.,
*           ClipControls=.F., cabecalho cinza no topo com o Caption
*           "Status das Operacoes <operacao>")
*   BD   -> SIGOPSTS/SigStats (via SigOpStsBO); a gravacao real so acontece
*           no clique de Encerrar (BtnSairClick), igual ao legado
*           (ParentForm.poDataMgr.UpDate('crSIGOPSTS') + Commit() so no
*           cmdSair.Click)
*   CODE -> arquitetura em camadas (FormBase / SigOpStsBO)
*
* O QUE ESTA TELA EH
*   Dialogo FILHO que o form pai SigCdOpe (Cadastro de Operacoes do Caixa)
*   abre para o usuario manter a lista de STATUS permitidos para uma
*   operacao-pai (crSigCdOpe.Dopes no legado). O legado recebe "poForm" (o
*   form pai) e "pnDataSes" (DataSession do pai) no Init, troca para a
*   DataSession do pai (Set DataSession To pnDataSes) e popula um cursor
*   local com:
*
*     Select a.*, b.Descs From SIGOPSTS a, SigStats b
*      Where a.Dopes = '<operacao-pai>' And a.Status = b.cods
*
*   A grade (GradeSubN) tem 2 colunas:
*     Column1 -> status (TextBox EDITAVEL com lookup em SigStats.Cods;
*                When = Empty(LocalStats.status), ou seja so a linha NOVA,
*                ainda sem status, aceita digitacao)
*     Column2 -> Descs  (TextBox com When = .F. - somente leitura, a
*                descricao vem do lookup e nao eh digitada)
*   Botoes: Inserir (acrescenta UMA linha em branco e foca a Column1),
*   Excluir (Delete da linha corrente) e Encerrar (valida duplicidade,
*   grava, reabilita os botoes do pai e fecha).
*
*   No migrado, o form roda com DataSession = 1 (sessao CORRENTE,
*   compartilhada com o pai), reproduzindo o mesmo efeito do "Set
*   DataSession To pnDataSes" sem a troca manual de sessao - mesmo padrao
*   ja adotado em FormSigOpSqn.prg/FormSigOpSlc.prg/FormSigOpSpr.prg.
*
* CHAMADA (equivale ao "Do Form SigOpSts With ThisForm, ThisForm.
* DataSessionId, ThisForm.PcEscolha" do legado, onde o proprio form pai eh
* "poForm"):
*   loForm = CREATEOBJECT("FormSigOpSts", THISFORM, loc_cOperacaoAtual, ;
*       THISFORM.this_cModoAtual, THISFORM.DataSessionId)
*   IF VARTYPE(loForm) = "O"
*       loForm.Show()          && modal: so volta quando o dialogo fecha
*   ENDIF
*
*   Como no legado, o Release eh do PROPRIO dialogo (botao Encerrar, fase
*   futura), nao do chamador.
*
* PARAMETROS DO INIT (legado: LParameters poForm, pnDataSes, pcEscolha)
*   par_oFormPai         - legado: poForm/ThisForm.ParentForm. O form pai
*                          SigCdOpe (CRUD), que precisa expor:
*                            .Enabled              - desabilitado enquanto
*                                                     este dialogo esta aberto
*                            .Top / .Left           - para o posicionamento
*                            .pgf_4c_Paginas.Page1.grd_4c_Dados
*                                                   - para o posicionamento
*                                                     (legado: Pagina.Lista.Grade)
*   par_cOperacaoPai     - legado: crSigCdOpe.Dopes, lido direto do cursor
*                          do pai (ja na DataSession dele). Como o migrado
*                          nao troca de DataSession, o codigo da operacao eh
*                          passado explicitamente pelo chamador.
*   par_cEscolha         - legado: Thisform.PcEscolha do pai (INSERIR/
*                          ALTERAR/PROCURAR) - decide a visibilidade de
*                          cmd_4c_Inserir/cmd_4c_Excluir (ver
*                          AplicarVisibilidadeBotoes).
*   par_nDataSessionPai  - legado: pnDataSes. Informativo - DataSession = 1
*                          ja unifica a sessao com o pai; mantido so para
*                          auditoria/paridade com o legado.
*
* METODOS DE DADOS (ja implementados no BO - fases 1-2)
*   CarregarDoCursor/Inserir/Atualizar/ObterChavePrimaria - ver cabecalho
*   de SigOpStsBO.prg para o detalhamento completo (inclusive a regra de
*   gravacao REPLACE-ALL do legado, transcrita em futuras fases para
*   ExisteStatusDuplicado/GravarStatus).
*
*   IMPORTANTE (decisao ja registrada no cabecalho de SigOpStsBO.prg): o
*   estado da sessao do dialogo (lhouveins/lhouveexcl do legado) mora
*   EXCLUSIVAMENTE no BO (this_oBusinessObject.this_lHouveInclusao/
*   this_lHouveExclusao) - este form NAO declara copias proprias dessas
*   duas flags. O form apenas ESCREVE nelas (via this_oBusinessObject) nos
*   mesmos pontos do legado (CmdInserirClick/CmdExcluirClick).
*
* FASE 3: estrutura base do form -
*   - Propriedades que espelham o contexto recebido do form pai
*     (this_oFormPai/this_cOperacaoPai/this_cEscolha/this_nDataSessionPai).
*   - Init (LParameters do legado) + ValidarParametros (precondicao: sem
*     form pai e sem operacao nao ha o que gerenciar).
*   - InicializarForm (cria o BO, migra o contexto do pai para ele,
*     posiciona o dialogo ao lado da grade do pai, aplica o fundo e cria o
*     cabecalho cinza).
*   - CarregarContextoFormPai (legado: .ParentForm.Enabled = .f. + repasse
*     de Dopes/PcEscolha/DataSession para o BO).
*   - ConfigurarPosicionamento (legado: .Top/.Left calculados a partir do
*     Top/Left/Grade do pai).
*   - ConfigurarDecoracao (Picture do form - new_background.jpg).
*   - ConfigurarPageFrame (cntSombra do legado -> cnt_4c_Cabecalho; mantido
*     esse nome de metodo por paridade com os demais dialogos filhos desta
*     familia - FormSigOpSqn/FormSigOpSlc/FormSigOpSpr - mesmo sem
*     PageFrame real: este form eh FLAT, igual ao legado).
*   - TornarControlesVisiveis / Destroy (reabilita o form pai ao fechar -
*     rede de seguranca, igual ao cmdSair.Click do legado).
*
* FASE 4 (esta fase): a GRADE e os BOTOES da tela -
*   - ConfigurarGrade (GradeSubN do legado -> grd_4c_Dados): 2 colunas
*     transcritas do dump (Column1 "Status" W=40, Column2 "Descricao"
*     W=235). Column2 fica ReadOnly = .T. (legado: When = .F., somente
*     leitura permanente); Column1 fica ReadOnly = .F. no nivel do Grid -
*     a condicao por linha (When = Empty(status)) e o lookup vem da classe
*     da celula instalada na Fase 6 (regra #18/#46).
*   - ConfigurarBotoes (shp_4c_Separador + cmd_4c_Inserir/cmd_4c_Excluir/
*     cmd_4c_Sair, todos da classe legado fwbtng - transcritos do dump:
*     Top=3, Left=375/450/525). O Shape eh criado ANTES dos botoes porque
*     a area dele fica EM CIMA deles (ver comentario do metodo).
*   - AplicarVisibilidadeBotoes (as 4 linhas de .cmdInserir/.cmdExcluir
*     .Visible/.Enabled do Init legado + o recalculo de shape1.Left/Width).
*     Roda DEPOIS do TornarControlesVisiveis, que forca Visible = .T. em
*     tudo e apagaria justamente o Visible = .F. do controle de acesso.
*   - PossuiAcessoOperacao (fChecaAcesso('SIGOPSTS', <acao>) do legado, com
*     bypass em modo teste/validacao de UI, onde ele consulta SQL e nao ha
*     conexao).
*   - CarregarDados (funil UNICO de carga, PUBLIC) + VincularGrade: chamam
*     SigOpStsBO.ListarStatusOperacao (equivalente ao Sqlexecute('...',
*     'LocalStats') do legado), religam a grade ao cursor e repintam com
*     GO TOP + Refresh (regra #21 - popular cursor NAO repinta a grade).
*
* FASE 6 (esta fase): o LOOKUP da celula de status -
*   A tela nao tem campo nenhum fora da grade (o dump tem apenas os dois
*   labels do cabecalho, a GradeSubN, o Shape e os 3 botoes), entao esta
*   fase eh inteiramente a celula editavel da Column1 e o lookup dela.
*
*   - ConfigurarGrade passa a instalar TextBoxStatusSts_4c na Column1 com
*     Column.AddObject + CurrentControl + Sparse = .F. (regra #18 - sem o
*     CurrentControl a coluna continua desenhando o Text1 dela e o
*     controle novo nunca aparece; sem Sparse = .F. ele apareceria so na
*     linha ativa). A classe mora em classes\textboxgridlookup.PRG porque
*     BINDEVENT em When/Valid de celula de Grid NAO eh confiavel
*     (regra #46), e delega para os metodos PUBLIC abaixo.
*   - VincularGrade REAPLICA CurrentControl/Sparse: atribuir RecordSource/
*     ControlSource reseta as duas propriedades junto com Width/Caption
*     (Problema 48 / regra #41).
*   - CelulaStatusEditavel  - When  do Column1.Text1 legado
*                             (Return( Empty( LocalStats.status ) ): so a
*                             linha ainda sem status aceita digitacao).
*   - ValidarStatusGradeExec - Valid do Column1.Text1 legado (com valor
*                             digitado, resolve contra SigStats e grava a
*                             descricao na linha corrente).
*   - AbrirLookupStatusSts / AbrirLookupStatusStsExec - o
*                             CreateObject('fwbuscaext', ..., 'SigStats',
*                             'CrListaRemota', 'Cods', ...) do legado,
*                             migrado para FormBuscaAuxiliar seguindo o
*                             contrato this_lAchouRegistro/
*                             this_lSelecionou (regra #37). Funil UNICO
*                             das tres entradas (Valid, F4/F5 e duplo
*                             clique), com guarda de reentrancia.
*   - StatusGradeLostFocus  - LostFocus do Column1.Text1 legado
*                             (campo vazio -> foco para o Encerrar).
*
* FASE 7 (esta fase): os EVENTOS dos tres botoes do legado -
*   O legado desta tela NAO tem barra CRUD: o form herda de "form" puro (nao
*   de frmcadastro) e os botoes do SCX sao cmdInserir, cmdExcluir e cmdSair.
*   O unico "Grupo_Op" citado no dump eh o do form PAI, desabilitado por
*   mCtrlBotoes enquanto este dialogo esta aberto. Por isso esta fase entrega
*   os eventos dos botoes que EXISTEM - nao ha Incluir/Alterar/Visualizar/
*   Excluir de registro a portar, e inventa-los violaria o PILAR 1.
*
*   - ConfigurarBINDEVENTs - liga o Click dos tres botoes aos handlers
*                            abaixo (AddObject cria botao SEM codigo de
*                            evento: sem BINDEVENT o Click nao dispara).
*   - CmdInserirClick      - cmdInserir.Click legado: acrescenta UMA linha
*                            em branco ao cursor da grade (reaproveitando a
*                            que ja estiver vazia) e foca a Column1.
*   - CmdExcluirClick      - cmdExcluir.Click legado: DELETE da linha
*                            corrente do cursor + reposicionamento.
*   - BtnSairClick         - cmdSair.Click legado ("Encerrar"): valida
*                            duplicidade, grava (REPLACE-ALL) e fecha. Eh o
*                            UNICO ponto de gravacao da tela, igual ao
*                            legado. A validacao e o REPLACE-ALL moram no
*                            BO (SigOpStsBO.ExisteStatusDuplicado /
*                            GravarStatus) - sao regra de negocio e acesso
*                            a dados, nao UI.
*
*   Os tres handlers sao PUBLIC (regra #3/#51): BINDEVENT falha em SILENCIO
*   com metodo PROTECTED, e o harness de teste os chama de fora da classe.
*
* FASE 8 (esta fase): o TRANSPORTE da linha da grade e a CONSOLIDACAO -
*   Esta tela nao tem campo nenhum fora da grade, entao a FICHA dela eh UMA
*   LINHA de cursor_4c_Status. Os dois hooks de transferencia transportam
*   essa linha, e nao um bloco de TextBox de Page2 (que esta tela nao tem).
*
*   - ModoEdicaoAtivo    - a condicao que abre o cmdSair.Click legado
*                          (cmdInserir.Visible Or cmdExcluir.Visible), em UM
*                          lugar so em vez de repetida em cada leitor.
*   - FormParaBO         - linha corrente -> properties do BO. Dentro do
*                          Valid da celula o valor digitado esta em
*                          par_oTxt.Value e o cursor so o recebe depois
*                          (regra #46), por isso a CELULA vence o cursor no
*                          campo status.
*   - BOParaForm         - properties do BO -> linha corrente + celula +
*                          Refresh. Eh a transcricao do "This.Value = ... /
*                          Replace Descs With ... / This.Refresh / Select
*                          LocalStats" do Valid legado. O metodo
*                          AbrirLookupStatusStsExec passou a usar estes dois
*                          hooks em vez de repetir o REPLACE.
*   - LimparCampos       - zera a ficha da linha no funil de carga, para a
*                          linha de uma sessao nunca vazar para a seguinte.
*
*   - HabilitarCampos    - ponto UNICO que aplica a editabilidade aos
*                          controles. Existe porque o rebind da grade reseta
*                          Column.ReadOnly (Problema 48 / regra #41) e quem
*                          desabilita tem de reabilitar no FUNIL (regra #40):
*                          VincularGrade e AplicarVisibilidadeBotoes o chamam.
*   - AjustarBotoesPorModo / CarregarLista - os nomes canonicos do projeto
*                          apontando para a logica real desta tela
*                          (AplicarVisibilidadeBotoes / CarregarDados), para
*                          o caminho canonico alcancar UM unico fluxo em vez
*                          de uma segunda copia que pode divergir.
*
*   FormParaBO/BOParaForm/LimparCampos sao PROTECTED EXPLICITOS: FormBase
*   declara os mesmos nomes como PROTECTED (formbase.prg:276/280/285) e em
*   VFP9 a subclasse nao ALARGA escopo herdado - omitir o modificador nao os
*   tornaria publicos, so esconderia o fato. Sao chamados por THIS. de dentro
*   da classe (regra #8). Os outros quatro NAO existem em FormBase, logo sao
*   publicos de verdade - medido com PEMSTATUS(oForm, <metodo>, 2), atributo
*   2 = Protected, em 2026-11-18.
*
* O QUE NAO SE APLICA A ESTA TELA (e por que inventar violaria o PILAR 1)
*   - BtnSalvarClick / BtnConfirmarClick: o SCX nao tem botao de gravar. A
*     gravacao desta tela mora no cmdSair.Click ("Encerrar"), ja migrado em
*     BtnSairClick, que valida a duplicidade e chama
*     SigOpStsBO.GravarStatus. O handler leva o nome do OBJETO do legado, nao
*     o da acao - renomea-lo faria o nome mentir sobre o botao que o usuario
*     ve, e criar um segundo botao de gravar inventaria controle que o legado
*     nao tem.
*   - BtnCancelarClick: o SCX nao tem Cancelar nem modo de edicao cancelavel
*     (nao ha Page2 de Dados). O unico caminho de saida eh o Encerrar, e ele
*     NAO cancela - grava. O ESC cai nele porque o botao tem Cancel = .T.
*     no dump.
*   - BtnBuscarClick: o SCX nao tem botao de busca. A busca desta tela eh o
*     lookup da CELULA (fwbuscaext no Valid da Column1), migrado na Fase 6
*     em AbrirLookupStatusSts.
*   - AlternarPagina: o form eh FLAT (herda de "form" puro, nao de
*     frmcadastro) e nao tem PageFrame - nao ha pagina para alternar.
*==============================================================================

DEFINE CLASS FormSigOpSts AS FormBase

    *--------------------------------------------------------------------------
    * CONTEXTO RECEBIDO DO FORM PAI (LParameters do Init legado)
    *--------------------------------------------------------------------------

    this_cMensagemErro = ""

    *-- poForm / ThisForm.ParentForm do legado - o form SigCdOpe (Cadastro
    *-- de Operacoes do Caixa) que abriu este dialogo
    this_oFormPai = .NULL.

    *-- crSigCdOpe.Dopes do legado - codigo da operacao-pai desta lista de
    *-- status. Repassado ao BO em CarregarContextoFormPai (este form NAO
    *-- eh o dono: a leitura/gravacao em SQL fica no this_oBusinessObject)
    this_cOperacaoPai = ""

    *-- Thisform.PcEscolha do pai (INSERIR/ALTERAR/PROCURAR) - decide a
    *-- visibilidade de cmd_4c_Inserir/cmd_4c_Excluir (ver
    *-- AplicarVisibilidadeBotoes)
    this_cEscolha = ""

    *-- pnDataSes do legado - informativo (DataSession = 1 ja unifica a
    *-- sessao com o pai, ver comentario de DataSession abaixo)
    this_nDataSessionPai = 0

    *--------------------------------------------------------------------------
    * ESTADO DO LOOKUP DA CELULA DE STATUS (Fase 6)
    *--------------------------------------------------------------------------

    *-- Guarda de reentrancia do picker da Column1 (regra #37/#47): o
    *-- FormBuscaAuxiliar eh MODAL, entao o Show() tira o foco da celula e
    *-- pode redisparar o proprio Valid/LostFocus que o abriu - sem esta
    *-- flag subiriam DOIS dialogos empilhados. Nao existe no legado, que
    *-- nao sofre disso porque o fwbuscaext roda dentro do Valid do
    *-- TextBox do Grid do proprio form modal.
    this_lEmLookupStatus = .F.

    *--------------------------------------------------------------------------
    * PROPRIEDADES VISUAIS - transcritas do SCX legado (PILAR 1)
    *--------------------------------------------------------------------------

    *-- SIGOPSTS: BorderStyle = 2 / Top = 0 / Left = 0 / Height = 350 /
    *-- Width = 600 / DoCreate = .T. (default do Form, nao precisa declarar)
    BorderStyle = 2
    Top         = 0
    Left        = 0
    Height      = 350
    Width       = 600

    *-- Caption do SCX ("Status por Operacoes") - sobrescrito em
    *-- InicializarForm com o codigo da operacao-pai, igual ao legado
    *-- (.Caption = 'Status das Operacoes ' + AllTrim(Proper(crSigCdOpe.Dopes)))
    Caption = "Status por Opera" + CHR(231) + CHR(245) + "es"

    *-- ControlBox = .F. (legado) -> Closable/MaxButton/MinButton = .F.
    *-- (padrao do projeto para dialogo sem chrome, mesmo padrao dos
    *-- dialogos irmaos). Movable = .T. (literal do dump - diferente do
    *-- irmao FormSigOpSqn, que declara .F.: transcrever o que o SCX desta
    *-- tela realmente tem, nao copiar do irmao). ClipControls = .F. /
    *-- TitleBar = 0 - literais do SCX. Sem barra de titulo e sem
    *-- ControlBox, a unica saida eh pelo botao Encerrar
    *-- (cmd_4c_Sair -> BtnSairClick)
    TitleBar     = 0
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .T.
    ClipControls = .F.

    *-- O legado posiciona o form manualmente a partir do form pai
    *-- (ConfigurarPosicionamento, abaixo) - AutoCenter desligado para nao
    *-- competir com esse calculo
    AutoCenter = .F.

    *-- WindowType = 1 (modal): o pai abre este dialogo e precisa que o
    *-- Show() bloqueie ate o usuario Encerrar (legado: .ParentForm.Enabled
    *-- = .f. enquanto este form esta aberto, emulando modalidade)
    WindowType  = 1
    WindowState = 0

    *-- ShowWindow = 1 ("In Top-Level Form"): canonico do projeto
    ShowWindow = 1

    *-- Fonte base do Framework legado (os controles do corpo declaram a
    *-- propria fonte - Tahoma 18 no cabecalho - transcrita em
    *-- ConfigurarPageFrame)
    FontName = "Tahoma"
    FontSize = 8

    *-- DataSession = 1 (sessao CORRENTE, NAO privada). O legado declara
    *-- DataSession = 2 no SCX mas o proprio Init sobrescreve com "Set
    *-- DataSession To pnDataSes", ou seja: na pratica este dialogo roda
    *-- SEMPRE na sessao do form pai. DataSession = 1 eh a reproducao
    *-- direta desse resultado, sem a troca manual de sessao - mesmo
    *-- padrao adotado em FormSigOpSqn.prg/FormSigOpSlc.prg/FormSigOpSpr.prg
    DataSession = 1

    *==========================================================================
    * Init - LParameters poForm, pnDataSes, pcEscolha do legado (com 1
    * parametro extra - par_cOperacaoPai - necessario porque o migrado nao
    * troca de DataSession para ler crSigCdOpe.Dopes direto do cursor do
    * pai; mesma convencao dos dialogos irmaos desta familia).
    *==========================================================================
    PROCEDURE Init
        LPARAMETERS par_oFormPai, par_cOperacaoPai, par_cEscolha, par_nDataSessionPai

        IF VARTYPE(par_oFormPai) = "O"
            THIS.this_oFormPai = par_oFormPai
        ENDIF

        THIS.this_cOperacaoPai    = IIF(VARTYPE(par_cOperacaoPai) = "C", par_cOperacaoPai, "")
        THIS.this_cEscolha        = IIF(VARTYPE(par_cEscolha) = "C", par_cEscolha, "")
        THIS.this_nDataSessionPai = IIF(VARTYPE(par_nDataSessionPai) = "N", par_nDataSessionPai, 0)

        *-- DODEFAULT chama FormBase.Init (fix SET DATE/CENTURY) e em
        *-- seguida THIS.InicializarForm()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * ValidarParametros - precondicao deste dialogo: sem form pai nao ha
    * quem reabilitar/posicionar em relacao, e sem operacao-pai nao ha
    * lista de status nenhuma para gerenciar (o legado tambem depende
    * dessas referencias em praticamente todo metodo - crSigCdOpe.Dopes/
    * ThisForm.ParentForm.*).
    *
    * Metodo PUBLIC (regra #3): o harness de teste e o form pai o alcancam
    * de fora, e PROTECTED faria a chamada externa estourar em runtime.
    *
    * Bypass em modo teste/validacao de UI no TOPO: o ValidarUIFidelity e o
    * TesteAutomatico instanciam o form SEM ARGUMENTO NENHUM, e sem o
    * bypass a instanciacao reprovaria sempre.
    *
    * Os RETURN ficam FORA de TRY/CATCH (regra #1) - este metodo nao abre
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
                    "Cadastro de Opera" + CHR(231) + CHR(245) + "es do Caixa.", ;
                    "Status das Opera" + CHR(231) + CHR(245) + "es")
            loc_lValido = .F.
        ENDIF

        IF EMPTY(THIS.this_cOperacaoPai)
            MsgErro("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informada.", ;
                    "Status das Opera" + CHR(231) + CHR(245) + "es")
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
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpStsBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar SigOpStsBO.", "Status das Opera" + CHR(231) + CHR(245) + "es")
            ELSE
                *-- Legado: .ParentForm.Enabled = .f. + repasse de
                *-- Dopes/PcEscolha/DataSession para o BO
                THIS.CarregarContextoFormPai()

                *-- Legado: .Caption = 'Status das Operacoes ' +
                *-- AllTrim(Proper(crSigCdOpe.Dopes))
                THIS.Caption = "Status das Opera" + CHR(231) + CHR(245) + "es " + ;
                    ALLTRIM(PROPER(THIS.this_cOperacaoPai))

                *-- Fundo do form (Picture do SCX)
                THIS.ConfigurarDecoracao()

                *-- Legado: .Top/.Left calculados a partir da grade do pai
                THIS.ConfigurarPosicionamento()

                *-- Cabecalho cinza (cntSombra do legado). PRIMEIRO
                *-- AddObject do form: os botoes ficam dentro da faixa do
                *-- topo (Top = 3..103 cai dentro de Top = 0..80 do
                *-- cabecalho) e precisam ser criados depois para desenhar
                *-- por cima (regra #11)
                THIS.ConfigurarPageFrame()

                *-- Fase 4: grade (GradeSubN) e os botoes Inserir/Excluir/
                *-- Encerrar + o Shape separador
                THIS.ConfigurarGrade()
                THIS.ConfigurarBotoes()

                *-- AddObject cria controle com Visible = .F.
                THIS.TornarControlesVisiveis(THIS)

                *-- Legado (Init): .cmdInserir/.cmdExcluir .Visible/.Enabled
                *-- por fChecaAcesso + pcEscolha, e o shape1 redimensionado
                *-- em volta dos botoes que sobraram visiveis.
                *-- OBRIGATORIAMENTE depois do TornarControlesVisiveis, que
                *-- forca Visible = .T. em TODO controle e apagaria o
                *-- Visible = .F. decidido aqui
                THIS.AplicarVisibilidadeBotoes()

                *-- Fase 7: Click dos tres botoes do legado (AddObject cria
                *-- botao SEM codigo de evento - sem BINDEVENT o Click nunca
                *-- dispara e o usuario clica sem nada acontecer)
                THIS.ConfigurarBINDEVENTs()

                *-- Legado (fim do Init): Sqlexecute(...,'LocalStats') +
                *-- Goto Top + bind da GradeSubN + .Refresh. Pulado em
                *-- validacao de UI (sem gnConnHandle nao ha o que
                *-- consultar) - a ausencia de dados nao impede a tela de
                *-- abrir
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    IF !THIS.CarregarDados()
                        *-- Falha ja reportada por CarregarDados/BO
                    ENDIF
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao inicializar FormSigOpSts: " + loc_oErro.Message + ;
                    " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    " | Procedure: " + loc_oErro.Procedure, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarContextoFormPai - migra para o BO o que o Init legado le/grava
    * no form pai:
    *
    *     ThisForm.ParentForm = poForm
    *     ThisForm.ParentForm.Enabled = .f.
    *     <crSigCdOpe.Dopes, Thisform.PcEscolha>   (ja recebidos via
    *                                                parametro no Init
    *                                                deste form - ver
    *                                                cabecalho do arquivo)
    *
    * Cada leitura/escrita eh protegida por PEMSTATUS/VARTYPE: em modo
    * teste (gb_4c_ModoTeste/gb_4c_ValidandoUI) o form pai pode ser .NULL.
    * ou um stub sem essas properties, e a ausencia aqui NAO eh falha de
    * inicializacao (ValidarParametros ja fez o bypass acima).
    *==========================================================================
    PROTECTED PROCEDURE CarregarContextoFormPai
        IF VARTYPE(THIS.this_oFormPai) = "O"
            *-- Legado: .ParentForm.Enabled = .f. (reabilitado no Destroy -
            *-- rede de seguranca; no legado isso esta no cmdSair.Click)
            IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
                THIS.this_oFormPai.Enabled = .F.
            ENDIF
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            WITH THIS.this_oBusinessObject
                .this_cOperacaoPai    = THIS.this_cOperacaoPai
                .this_cEscolha        = THIS.this_cEscolha
                .this_nDataSessionPai = THIS.this_nDataSessionPai
            ENDWITH
        ENDIF
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
    * ConfigurarPosicionamento - reproduz o calculo de .Top/.Left do Init
    * legado, que ancora este dialogo ao lado da grade do form pai:
    *
    *   .Top  = ParentForm.Top + ParentForm.Pagina.Lista.Grade.Top + 50
    *   .Left = ParentForm.Left + ParentForm.Pagina.Lista.Grade.Left +
    *           ParentForm.Pagina.Lista.Grade.Columns(1).Width +
    *           ParentForm.Pagina.Lista.Grade.Columns(3).Width + 16
    *
    * No migrado, o form pai (FormSigCdOpe, CRUD) usa pgf_4c_Paginas.Page1.
    * grd_4c_Dados no lugar de Pagina.Lista.Grade. Guardas PEMSTATUS/
    * VARTYPE cobrem gb_4c_ModoTeste/gb_4c_ValidandoUI e o fato do form pai
    * ainda nao existir/nao ter essa estrutura - sem elas, nao haveria como
    * instanciar este dialogo isoladamente para teste.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPosicionamento
        LOCAL loc_oGrade

        IF VARTYPE(THIS.this_oFormPai) != "O"
            RETURN
        ENDIF

        IF !PEMSTATUS(THIS.this_oFormPai, "pgf_4c_Paginas", 5)
            RETURN
        ENDIF

        IF VARTYPE(THIS.this_oFormPai.pgf_4c_Paginas) != "O" OR ;
           !PEMSTATUS(THIS.this_oFormPai.pgf_4c_Paginas, "Page1", 5)
            RETURN
        ENDIF

        IF VARTYPE(THIS.this_oFormPai.pgf_4c_Paginas.Page1) != "O" OR ;
           !PEMSTATUS(THIS.this_oFormPai.pgf_4c_Paginas.Page1, "grd_4c_Dados", 5)
            RETURN
        ENDIF

        loc_oGrade = THIS.this_oFormPai.pgf_4c_Paginas.Page1.grd_4c_Dados

        IF VARTYPE(loc_oGrade) != "O"
            RETURN
        ENDIF

        THIS.Top = THIS.this_oFormPai.Top + loc_oGrade.Top + 50

        IF loc_oGrade.ColumnCount >= 3
            THIS.Left = THIS.this_oFormPai.Left + loc_oGrade.Left + ;
                        loc_oGrade.Columns(1).Width + loc_oGrade.Columns(3).Width + 16
        ELSE
            *-- Grade com menos de 3 colunas (layout divergente do esperado)
            *-- - aproximacao segura, so para o dialogo nao abrir fora da
            *-- area visivel
            THIS.Left = THIS.this_oFormPai.Left + loc_oGrade.Left + 50
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - cntSombra do legado -> cnt_4c_Cabecalho. Nome do
    * metodo mantido por paridade com os demais dialogos filhos desta
    * familia (FormSigOpSqn.prg/FormSigOpSlc.prg/FormSigOpSpr.prg usam o
    * mesmo nome), mesmo sem PageFrame real - este form eh FLAT, igual ao
    * legado (SIGOPSTS nao tem PageFrame no SCX).
    *
    * Transcricao do dump (SigOpSts_form_codigo_fonte.txt):
    *   cntSombra  Top=0  Left=0  Width=800  Height=80  BorderWidth=0
    *              BackColor=100,100,100
    *   lblSombra  Top=18 Left=10 Width=769 Height=40 ForeColor=0,0,0
    *              Tahoma 18 bold, FontUnderline=.F., WordWrap=.T.,
    *              Alignment=0, BackStyle=0
    *   lblTitulo  Top=17 Left=10 Width=769 Height=46 ForeColor=255,255,255
    *              Tahoma 18 bold, WordWrap=.T., Alignment=0, BackStyle=0
    *
    * O Init legado sobrescreve os dois Caption com ThisForm.Caption
    * ("Status das Operacoes <operacao>"), por isso .Caption = THIS.Caption
    * (dinamico) - o literal do dump ("Cadastro de Testes") eh so o default
    * do Form Designer, nunca chega a ser exibido.
    *
    * Width do container usa THIS.Width - padrao canonico da faixa, regra #11 - em
    * vez do literal 800: o SCX declara o CONTAINER mais largo que o
    * proprio form (600), artefato do Form Designer ja catalogado
    * (cabecalho_label_width_dump_maior_que_form) - copiar o literal 769
    * nos labels extrapolaria os 600px visiveis e cortaria o titulo. Os
    * labels usam THIS.Width - 20, mesma margem de 10px dos dois lados
    * aplicada pelos dialogos irmaos (FormSigOpSqn.prg).
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
    * ConfigurarGrade - GradeSubN do legado -> grd_4c_Dados
    *
    * Transcricao do dump (SigOpSts_form_codigo_fonte.txt):
    *   GradeSubN  Top=94 Left=146 Width=307 Height=238 ColumnCount=2
    *              FontName="Tahoma" FontSize=8 DeleteMark=.F. RowHeight=16
    *              ScrollBars=2 TabIndex=1 GridLineColor=238,238,238
    *   Column1    FontName="Tahoma" FontSize=8 Width=40 Movable=.F.
    *              Resizable=.F.  (ControlSource="" - override VAZIO do
    *              Form Designer, o bind real eh feito em VincularGrade:
    *              'cursor_4c_Status.status')
    *   Column1.Header1  Alignment=2 Caption="Status"
    *   Column1.Text1    BorderStyle=0 Margin=0 ForeColor=0,0,0
    *                    BackColor=255,255,255
    *   Column2    FontName="Tahoma" FontSize=8 Width=235 Movable=.F.
    *              Resizable=.F.
    *   Column2.Header1  Alignment=2 Caption="Descricao"
    *   Column2.Text1    BorderStyle=0 Margin=0 ForeColor=0,0,0
    *                    BackColor=255,255,255
    *
    * RecordMark = .F. (o dump so declara DeleteMark): canonico do projeto
    * para grade criada por AddObject em form OPERACIONAL - a barra lateral
    * de marcacao de registro nao faz parte do padrao visual do sistema
    * novo e a linha corrente continua identificada pelo realce do proprio
    * Grid. Mesmo padrao adotado em FormSigOpSqn.prg.
    *
    * Column1 (status) eh editavel SO quando a linha ainda nao tem status
    * (legado: When = Empty(LocalStats.status), textbox da Column1) - essa
    * condicao por LINHA e o lookup contra SigStats entram na Fase 6, via
    * TextBox subclasse instalada com Column.AddObject + CurrentControl +
    * Sparse = .F. (regra #18), porque BINDEVENT em evento de celula de
    * Grid nao eh confiavel (regra #46). Por ora, no nivel do Grid, a
    * coluna fica destravada (ReadOnly = .F.) - a restricao por linha vem
    * depois, da classe da Fase 6.
    *
    * Column2 (descs) eh SEMPRE somente leitura (legado: When = .F. no
    * Text1 da Column2 - a descricao vem do lookup da Column1 e nunca eh
    * digitada direto) - ReadOnly = .T. permanente, sem excecao por linha.
    *
    * MaxLength pela largura da COLUNA no schema (SIGOPSTS.status char(1) /
    * SigStats.descs char(20)), NUNCA pelo Width em pixels (regra #19).
    *
    * ReadOnly das colunas sempre DEPOIS do Grid, porque o ReadOnly do Grid
    * propaga para elas e sobrescreveria o valor daqui (regra #46).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade
        THIS.AddObject("grd_4c_Dados", "Grid")

        WITH THIS.grd_4c_Dados
            .Top           = 94
            .Left          = 146
            .Width         = 307
            .Height        = 238
            .FontName      = "Tahoma"
            .FontSize      = 8
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .RowHeight     = 16
            .ScrollBars    = 2
            .TabIndex      = 1
            .GridLineColor = RGB(238, 238, 238)
            .ColumnCount   = 2
            .Visible       = .T.
        ENDWITH

        *-- Column1 - status (codigo, FK SigStats.cods). Celula com When/
        *-- Valid/LostFocus do legado e lookup contra SigStats: os eventos
        *-- moram na classe TextBoxStatusSts_4c (classes\
        *-- textboxgridlookup.PRG) porque BINDEVENT em evento de celula de
        *-- Grid nao eh confiavel (regra #18/#46)
        WITH THIS.grd_4c_Dados.Column1
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Width             = 40
            .Movable           = .F.
            .Resizable         = .F.
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.Caption   = "Status"
        ENDWITH

        *-- A celula (AddObject + CurrentControl + Sparse) eh instalada num
        *-- LUGAR SO - GarantirCelulaStatus - porque ela precisa ser
        *-- REINSTALADA toda vez que as Columns sao recriadas (ver o
        *-- comentario do metodo, com a medicao)
        THIS.GarantirCelulaStatus()

        *-- Column2 - descs (descricao do status, somente leitura)
        WITH THIS.grd_4c_Dados.Column2
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Width             = 235
            .Movable           = .F.
            .Resizable         = .F.
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
            .Text1.FontName    = "Tahoma"
            .Text1.FontSize    = 8
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.MaxLength   = 20
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- ReadOnly das colunas DEPOIS do Grid (regra #46)
        THIS.grd_4c_Dados.Column1.ReadOnly = .F.
        THIS.grd_4c_Dados.Column2.ReadOnly = .T.
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - shp_4c_Separador (Shape1) + os 3 botoes do legado
    *
    * Transcricao do dump. Os tres botoes sao da classe legado fwbtng
    * (framework.vcx) - mesma classe/propriedades comuns do dialogo irmao
    * FormSigOpSqn.prg (Height=100/Width=80, FontBold=.T./FontItalic=.T./
    * FontName="Comic Sans MS"/FontSize=8, WordWrap=.T., MousePointer=15,
    * ForeColor=90,90,90, BackColor=255,255,255); o SCX desta tela sobrepoe
    * apenas Top/Left/Picture/Caption/TabIndex (e Cancel no Sair):
    *   cmdExcluir  Top=3 Left=450 Caption="Excluir"  TabIndex=2
    *               Picture=cadastro_excluir_60.jpg
    *   cmdSair     Top=3 Left=525 Caption="Encerrar" TabIndex=3 Cancel=.T.
    *               Picture=cadastro_sair_60.jpg
    *   cmdInserir  Top=3 Left=375 Caption="Inserir"  TabIndex=4
    *               Picture=cadastro_inserir_60.jpg
    *   Shape1      Top=12 Left=92 Height=110 Width=257 BackStyle=0
    *               BorderStyle=0 BorderColor=136,189,188
    *
    * Left/Width do Shape sao RECALCULADOS pelo Init legado em funcao de
    * quais botoes ficaram visiveis - ver AplicarVisibilidadeBotoes. Os
    * valores do dump ficam aqui so por fidelidade visual inicial.
    *
    * O Shape eh criado ANTES dos botoes de proposito: a area dele
    * (Left 92..349, Top 12..122) cobre os tres botoes (Left 375..625), e
    * um controle criado DEPOIS desenha por cima - mesmo transparente
    * (BackStyle=0), ele passaria a interceptar o clique dos botoes.
    *
    * cmd_4c_Sair usa Width=75/Height=75 (nao 80/100): mesmo padrao adotado
    * no dialogo irmao FormSigOpSqn.prg para o botao "Encerrar" desta
    * familia de dialogos.
    *
    * Themes = .T. + DisabledPicture: canonico do projeto para CommandButton
    * standalone COM Picture - com Themes = .F. (o default do fwbtng) o icone
    * nao renderiza quando o botao esta Enabled = .F., e aqui Inserir/Excluir
    * sao justamente desabilitados pelo controle de acesso.
    *
    * .Picture atribuida SEM guard IF FILE(): guard nao resolve nada (icone
    * ausente ja falha em silencio) e so esconde o erro (regra #25). Os tres
    * arquivos estao conferidos em vbmp\.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes
        LOCAL loc_cIcones

        *-- gc_4c_CaminhoIcones pode nao existir em probe/harness sem
        *-- config.prg - referenciar a variavel ausente mataria o Init
        loc_cIcones = IIF(TYPE("gc_4c_CaminhoIcones") = "C", gc_4c_CaminhoIcones, "")

        *-- Shape1 do legado - moldura em volta do bloco de botoes
        THIS.AddObject("shp_4c_Separador", "Shape")
        WITH THIS.shp_4c_Separador
            .Top         = 12
            .Left        = 92
            .Height      = 110
            .Width       = 257
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH

        *-- cmdInserir
        THIS.AddObject("cmd_4c_Inserir", "CommandButton")
        WITH THIS.cmd_4c_Inserir
            .Top             = 3
            .Left            = 375
            .Width           = 80
            .Height          = 100
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .WordWrap        = .T.
            .MousePointer    = 15
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .TabIndex        = 4
            .Caption         = "Inserir"
            .Picture         = loc_cIcones + "cadastro_inserir_60.jpg"
            .DisabledPicture = loc_cIcones + "cadastro_inserir_60.jpg"
            .Visible         = .T.
        ENDWITH

        *-- cmdExcluir
        THIS.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH THIS.cmd_4c_Excluir
            .Top             = 3
            .Left            = 450
            .Width           = 80
            .Height          = 100
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .WordWrap        = .T.
            .MousePointer    = 15
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .TabIndex        = 2
            .Caption         = "Excluir"
            .Picture         = loc_cIcones + "cadastro_excluir_60.jpg"
            .DisabledPicture = loc_cIcones + "cadastro_excluir_60.jpg"
            .Visible         = .T.
        ENDWITH

        *-- cmdSair ("Encerrar"). Cancel = .T. do dump: com TitleBar = 0 e
        *-- ControlBox = .F., o ESC acionar este botao eh a unica saida do
        *-- dialogo por teclado
        THIS.AddObject("cmd_4c_Sair", "CommandButton")
        WITH THIS.cmd_4c_Sair
            .Top             = 3
            .Left            = 525
            .Width           = 75
            .Height          = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .WordWrap        = .T.
            .MousePointer    = 15
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .Cancel          = .T.
            .TabIndex        = 3
            .Caption         = "Encerrar"
            .Picture         = loc_cIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = loc_cIcones + "cadastro_sair_60.jpg"
            .Visible         = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * AplicarVisibilidadeBotoes - transcreve as 6 ultimas linhas do WITH
    * Thisform do Init legado:
    *
    *   .cmdInserir.Visible = fChecaAcesso('SIGOPSTS','INSERIR') And
    *                         Iif( Type('Thisform.PcEscolha') # 'C', .T.,
    *                         InList( Thisform.PcEscolha,'INSERIR','ALTERAR'))
    *   .cmdInserir.Enabled = <a mesma expressao>
    *   .cmdExcluir.Visible = fChecaAcesso('SIGOPSTS','EXCLUIR') And <idem>
    *   .cmdExcluir.Enabled = <a mesma expressao>
    *   .shape1.Left  = IIF(.cmdInserir.visible, .cmdInserir.Left - 5,
    *                   IIF(.cmdExcluir.visible, .cmdExcluir.left - 5,
    *                       .cmdSair.Left - 5))
    *   .shape1.width = IIF(.cmdInserir.visible, 3,
    *                   IIF(.cmdExcluir.visible, 2, 1)) * .cmdsair.width + 16
    *
    * O "Type('Thisform.PcEscolha') # 'C'" do legado eh o caso "o chamador
    * nao informou o modo" - aqui corresponde a this_cEscolha vazia (o Init
    * guarda "" quando par_cEscolha nao vem), e tambem libera os botoes,
    * igual ao legado. Mesma leitura adotada no dialogo irmao FormSigOpSqn.
    *
    * cmd_4c_Sair NUNCA eh escondido: ele eh a unica saida da tela.
    *==========================================================================
    PROTECTED PROCEDURE AplicarVisibilidadeBotoes
        LOCAL loc_lModoEdicao, loc_lInserir, loc_lExcluir

        loc_lModoEdicao = EMPTY(THIS.this_cEscolha) OR ;
            INLIST(UPPER(ALLTRIM(THIS.this_cEscolha)), "INSERIR", "ALTERAR")

        loc_lInserir = THIS.PossuiAcessoOperacao("INSERIR") AND loc_lModoEdicao
        loc_lExcluir = THIS.PossuiAcessoOperacao("EXCLUIR") AND loc_lModoEdicao

        THIS.cmd_4c_Inserir.Visible = loc_lInserir
        THIS.cmd_4c_Inserir.Enabled = loc_lInserir
        THIS.cmd_4c_Excluir.Visible = loc_lExcluir
        THIS.cmd_4c_Excluir.Enabled = loc_lExcluir

        DO CASE
        CASE THIS.cmd_4c_Inserir.Visible
            THIS.shp_4c_Separador.Left  = THIS.cmd_4c_Inserir.Left - 5
            THIS.shp_4c_Separador.Width = 3 * THIS.cmd_4c_Sair.Width + 16
        CASE THIS.cmd_4c_Excluir.Visible
            THIS.shp_4c_Separador.Left  = THIS.cmd_4c_Excluir.Left - 5
            THIS.shp_4c_Separador.Width = 2 * THIS.cmd_4c_Sair.Width + 16
        OTHERWISE
            THIS.shp_4c_Separador.Left  = THIS.cmd_4c_Sair.Left - 5
            THIS.shp_4c_Separador.Width = 1 * THIS.cmd_4c_Sair.Width + 16
        ENDCASE

        *-- A trava da celula de status acompanha os botoes: sem isto, o modo
        *-- so-leitura do pai (PROCURAR, ou usuario sem acesso) esconderia os
        *-- botoes de linha e deixaria a Column1 editavel. Deriva de
        *-- ModoEdicaoAtivo(), que le o Visible que acabou de ser definido
        *-- aqui - e nao de loc_lModoEdicao, que ignora o controle de acesso
        THIS.HabilitarCampos()
    ENDPROC

    *==========================================================================
    * PossuiAcessoOperacao - fChecaAcesso('SIGOPSTS', <acao>) do legado
    *
    * fChecaAcesso eh a funcao ORIGINAL do Framework Fortyus (Framework\
    * sigacess.PRG, carregada pelo config.prg) - NAO reimplementar a consulta
    * aqui: o modelo de acesso (SigCdAcu/SigCdAcg) concede permissao por
    * usuario E por grupo, e trata o usuario interno com acesso total. A
    * chamada com 2 argumentos eh FIEL ao legado: os parametros restantes
    * (pMsg/pUsu/pTot) tem fallback proprio dentro da funcao.
    *
    * Bypass em modo teste / validacao de UI no TOPO: fChecaAcesso abre
    * conexao e consulta o banco, e sem SQL Server ela trava o harness
    * DENTRO do CREATEOBJECT do form.
    *
    * Os RETURN ficam fora de TRY/CATCH (regra #1).
    *==========================================================================
    PROTECTED PROCEDURE PossuiAcessoOperacao(par_cOperacao)
        LOCAL loc_lAcesso, loc_oErro
        loc_lAcesso = .F.

        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            RETURN .T.
        ENDIF

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        TRY
            loc_lAcesso = fChecaAcesso("SIGOPSTS", par_cOperacao)
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar o acesso " + CHR(224) + " opera" + ;
                CHR(231) + CHR(227) + "o " + ALLTRIM(par_cOperacao) + ":" + CHR(13) + ;
                loc_oErro.Message, "Status das Opera" + CHR(231) + CHR(245) + "es")
        ENDTRY

        RETURN loc_lAcesso
    ENDPROC

    *==========================================================================
    * VincularGrade - liga grd_4c_Dados ao cursor de status, transcrevendo o
    * bloco final do Init legado (Thisform.GradeSubN): RecordSource recebe
    * 'LocalStats', o ControlSource da Column1 vira 'LocalStats.status' e o
    * da Column2 vira 'LocalStats.Descs', e por fim um Refresh da grade.
    *
    * O alias eh o literal cursor_4c_Status (valor de SigOpStsBO.
    * this_cCursorStatus) - INTO CURSOR do BO e RecordSource daqui precisam
    * casar, e um nome fixo nos dois lados nao tem como divergir.
    *
    * Width / Header1.Caption / Header1.Alignment / ReadOnly sao
    * REAPLICADOS depois do bind: atribuir RecordSource/ControlSource
    * reseta a largura das colunas para o default 90 e o cabecalho para
    * "Column1"/"Column2" (Problema 48 / regra #41). Por isso este bloco
    * repete os valores de ConfigurarGrade em vez de so configura-los la.
    *==========================================================================
    PROTECTED PROCEDURE VincularGrade
        IF !USED("cursor_4c_Status")
            RETURN .F.
        ENDIF

        IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
            RETURN .F.
        ENDIF

        *-- RecordSource FORA do WITH: colunas nao sao recriadas de
        *-- imediato dentro de um WITH, e acessar .Column1/.Column2 no
        *-- mesmo bloco pode estourar "Unknown member COLUMN1"
        THIS.grd_4c_Dados.RecordSource = ""
        THIS.grd_4c_Dados.ColumnCount = 2
        THIS.grd_4c_Dados.RecordSource = "cursor_4c_Status"

        WITH THIS.grd_4c_Dados
            .Column1.ControlSource = "cursor_4c_Status.status"
            .Column2.ControlSource = "cursor_4c_Status.descs"

            *-- Reaplicar o que o rebind acabou de resetar
            .Column1.Width = 40
            .Column2.Width = 235

            .Column1.Header1.Alignment = 2
            .Column2.Header1.Alignment = 2
            .Column1.Header1.Caption   = "Status"
            .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"

        ENDWITH

        *-- O rebind reseta CurrentControl/Sparse e, quando o ColumnCount
        *-- acima RECRIOU as Columns, o proprio controle da celula deixou de
        *-- existir: reinstalar num lugar so (regra #18/#41) - ver a medicao
        *-- no comentario de GarantirCelulaStatus
        THIS.GarantirCelulaStatus()

        *-- ReadOnly das colunas DEPOIS do Grid (regra #46). A Column2 eh
        *-- somente leitura em qualquer modo (legado: When = .f.); quem decide
        *-- a Column1 eh HabilitarCampos, porque o rebind acima acabou de
        *-- RESETAR o ReadOnly dela junto com Width/Caption/CurrentControl
        *-- (Problema 48 / regra #41) e reatribuir .F. aqui destravaria a
        *-- celula tambem no modo so-leitura do pai - reabilitacao mora no
        *-- FUNIL, nunca no caminho de ida (regra #40)
        THIS.grd_4c_Dados.Column2.ReadOnly = .T.
        THIS.HabilitarCampos()

        RETURN .T.
    ENDPROC

    *==========================================================================
    * GarantirCelulaStatus - instala (ou REINSTALA) na Column1 a celula
    * editavel de status: o TextBox da classe TextBoxStatusSts_4c
    * (classes\textboxgridlookup.PRG), que carrega o When/Valid/LostFocus do
    * Column1.Text1 legado e o lookup contra SigStats. Os eventos moram naquela
    * classe porque BINDEVENT em evento de celula de Grid nao eh confiavel
    * (regra #46).
    *
    * Sem CurrentControl a coluna continua desenhando o Text1 dela e o controle
    * novo NUNCA aparece; sem Sparse = .F. ele apareceria so na linha ativa
    * (regra #18).
    *
    * POR QUE ISTO EH UM METODO, chamado de DOIS lugares (ConfigurarGrade e
    * VincularGrade), em vez de um AddObject inline na criacao - medido no
    * VFP9 em 2026-11-18:
    *
    *   1 form c/cursor aberto  ColumnCount=2 Column1=.T. txt_4c_Status=.T.
    *   2 apos USE IN (carga)   ColumnCount=0 Column1=.F.
    *   3 cursor recriado       ColumnCount=0 Column1=.F.
    *   4 apos ColumnCount=2    ColumnCount=2 Column1=.T. txt_4c_Status=.F.
    *                                              CurrentControl=[Text1]
    *   5 CurrentModeControl    ERRO "Error with Column1 - CurrentControl :
    *                                 Expression evaluated to an illegal value."
    *
    * A cadeia: Grid com RecordSource VAZIO auto-binda na area de trabalho
    * CORRENTE (medido: o RecordSource passa de [] para [Cursor_4c_status] sem
    * ninguem atribuir), e basta o cursor estar selecionado quando o form
    * nasce - o que acontece ao REABRIR este dialogo, porque o cursor da vez
    * anterior ficou aberto. Dai o "USE IN cursor_4c_Status" que
    * SigOpStsBO.ListarStatusOperacao faz a CADA carga zera o ColumnCount, e o
    * "ColumnCount = 2" do rebind recria as Columns - com isso o controle
    * instalado por AddObject DESAPARECE e atribuir CurrentControl estoura.
    *
    * Esse erro cai no CATCH de CarregarDados: a tela ABRE, e a celula de
    * lookup simplesmente nao esta mais la - a Column1 volta a desenhar o Text1
    * cru, sem o When que trava a linha ja resolvida e sem o lookup contra
    * SigStats, de modo que o usuario digita qualquer caractere no status. Por
    * isso a instalacao tem de ser idempotente e refeita no funil de rebind, e
    * nao uma vez na criacao.
    *
    * Os RETURN de guarda ficam FORA de TRY/CATCH (regra #1).
    *==========================================================================
    PROTECTED PROCEDURE GarantirCelulaStatus
        LOCAL loc_oColuna

        IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
            RETURN .F.
        ENDIF

        *-- ColumnCount = 0 (grade desvinculada) nao tem Column1 nenhuma
        IF !PEMSTATUS(THIS.grd_4c_Dados, "Column1", 5)
            RETURN .F.
        ENDIF

        loc_oColuna = THIS.grd_4c_Dados.Column1

        IF !PEMSTATUS(loc_oColuna, "txt_4c_Status", 5)
            loc_oColuna.AddObject("txt_4c_Status", "TextBoxStatusSts_4c")
        ENDIF

        *-- Decoracao transcrita do Column1.Text1 do dump; MaxLength pela
        *-- largura da COLUNA no schema (SIGOPSTS.status / SigStats.cods
        *-- char(1)), NUNCA pelo Width em pixels (regra #19)
        WITH loc_oColuna.txt_4c_Status
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .MaxLength   = 1
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            .Visible     = .T.
        ENDWITH

        loc_oColuna.CurrentControl = "txt_4c_Status"
        loc_oColuna.Sparse         = .F.

        RETURN .T.
    ENDPROC

    *==========================================================================
    * CarregarDados - funil UNICO de carga da grade
    *
    * Equivale ao bloco do Init legado que consulta e religa a grade:
    *
    *   lcSql = [Select a.*,b.Descs From SIGOPSTS a, SigStats b Where
    *            a.Dopes = '<operacao-pai>' And a.Status = b.cods]
    *   ThisForm.ParentForm.PodataMgr.Sqlexecute(lcsql,'LocalStats')
    *   Select LocalStats / Goto Top
    *   With Thisform.GradeSubN ... .Refresh
    *
    * No migrado, quem produz o cursor eh SigOpStsBO.ListarStatusOperacao
    * (mesma consulta, filtrada pela operacao-pai), e o Go Top + Refresh vem
    * DEPOIS do bind - popular o cursor NAO repinta a grade sozinho (regra
    * #21).
    *
    * Metodo PUBLIC: eh o funil de carga que o harness de teste automatizado
    * e os Click dos botoes alcancam de fora - PROTECTED
    * faria a chamada externa estourar em runtime (regra #3/#51).
    *
    * Devolve .F. sem estourar quando o BO ainda nao existe ou a consulta
    * falha; a tela continua abrindo (grade vazia), e a falha de SQL ja foi
    * reportada por ListarStatusOperacao.
    *==========================================================================
    PROCEDURE CarregarDados
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        *-- Carga eh o ponto de partida da sessao de edicao: o estado de
        *-- inclusao/exclusao (lhouveins/lhouveexcl do legado, dono UNICO
        *-- no BO - ver cabecalho de SigOpStsBO.prg) volta ao zero junto
        *-- com os dados
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_lHouveInclusao = .F.
            THIS.this_oBusinessObject.this_lHouveExclusao = .F.
        ENDIF

        *-- A ficha da linha (as properties de entidade do BO) tambem volta ao
        *-- zero aqui: a linha lida na sessao anterior nao pode vazar para esta
        THIS.LimparCampos()

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                IF THIS.this_oBusinessObject.ListarStatusOperacao(THIS.this_cOperacaoPai)
                    THIS.VincularGrade()

                    *-- Legado: Select LocalStats / Goto Top
                    IF USED("cursor_4c_Status")
                        SELECT cursor_4c_Status
                        GO TOP
                    ENDIF

                    *-- Legado: Thisform.GradeSubN.Refresh
                    IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                        THIS.grd_4c_Dados.Refresh()
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar os status da opera" + CHR(231) + CHR(227) + ;
                "o:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CelulaStatusEditavel - When do Column1.Text1 legado:
    *
    *   Return( Empty( LocalStats.status ) )
    *
    * So a linha AINDA SEM status aceita digitacao: a linha ja resolvida
    * fica travada, e para trocar o status o usuario exclui a linha
    * (cmd_4c_Excluir) e insere outra (cmd_4c_Inserir) - esse eh o desenho
    * do legado, nao uma limitacao da migracao.
    *
    * Chamado pela celula (TextBoxStatusSts_4c.When, em
    * classes\textboxgridlookup.PRG) ANTES de o usuario entrar na celula.
    *
    * Sem cursor ou em EOF nao ha linha nenhuma para editar - devolve .F.
    * (ler .status com o ponteiro em EOF estouraria).
    *
    * Metodo PUBLIC (regra #3/#46): a celula o alcanca via THISFORM a
    * partir de outra classe - PROTECTED faria a chamada estourar em
    * runtime.
    *==========================================================================
    PROCEDURE CelulaStatusEditavel(par_oTxt)
        IF !USED("cursor_4c_Status")
            RETURN .F.
        ENDIF

        IF EOF("cursor_4c_Status")
            RETURN .F.
        ENDIF

        RETURN EMPTY(NVL(cursor_4c_Status.status, ""))
    ENDPROC

    *==========================================================================
    * ValidarStatusGradeExec - Valid do Column1.Text1 legado:
    *
    *   Local lcOperacao, lnRecNo, loBrowse
    *   lcDopes = crSigCdOpe.Dopes
    *   If Not IsEmpty(This.Value)
    *       xBrox = CreateObject('fwbuscaext', <conn>, 'SigStats',
    *           'CrListaRemota', 'Cods', This.Value, 'Selecao', .t., 'Cods')
    *       If Not xBrox.plAchouRegistro
    *           xBrox: mAddColuna de 4 argumentos para Cods (mascara vazia,
    *           titulo Codigo, flag .t.) e outro igual para Descs/Descricao
    *           xBrox.Show()
    *       EndIf
    *       This.Value = CrListaRemota.Cods
    *       Replace Descs With CrListaRemota.Descs in LocalStats
    *       This.Refresh
    *   EndIf
    *   Select LocalStats
    *   Return .t.
    *
    * O "lcDopes = crSigCdOpe.Dopes" do legado eh leitura morta (a variavel
    * nunca eh usada depois) - nao ha o que transcrever dela.
    *
    * Celula VAZIA nao dispara nada, igual ao legado: o usuario pode
    * atravessar a linha em branco com Tab sem levar dialogo nenhum.
    *
    * Dentro do Valid o valor digitado esta em par_oTxt.Value - o cursor da
    * grade so o recebe DEPOIS que este metodo devolve .T. (regra #46), e
    * por isso ler cursor_4c_Status.status aqui validaria o valor ANTIGO.
    *
    * RETURN .T. sempre, igual ao legado (o "Return .t." final) - o codigo
    * invalido nao prende o foco na celula; quem resolve/limpa eh o picker.
    *
    * Metodo PUBLIC (regra #3/#46).
    *==========================================================================
    PROCEDURE ValidarStatusGradeExec(par_oTxt)
        IF !EMPTY(NVL(par_oTxt.Value, ""))
            THIS.AbrirLookupStatusSts(par_oTxt)
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * AbrirLookupStatusSts - funil UNICO do lookup de status, com guarda de
    * reentrancia (regra #37/#47).
    *
    * Tres entradas chegam aqui: o Valid da celula
    * (ValidarStatusGradeExec), o F4/F5 e o duplo clique (os dois ultimos
    * sao afordancia do sistema novo, como os demais lookups de grade). O
    * picker eh MODAL: o Show() tira o foco da celula e pode redisparar o
    * proprio evento que o abriu, empilhando um segundo dialogo - a flag
    * this_lEmLookupStatus corta isso.
    *
    * Wrapper fino + <Nome>Exec (regra #47): a flag eh liberada AQUI, depois
    * do ENDTRY, para nao travar ligada quando o corpo aborta - flag presa
    * mataria o lookup pelo resto da vida do form.
    *
    * Metodo PUBLIC (regra #3/#46).
    *==========================================================================
    PROCEDURE AbrirLookupStatusSts(par_oTxt)
        LOCAL loc_oErro

        *-- Guarda ANTES do TRY, para o RETURN nao ficar dentro de
        *-- TRY/CATCH (regra #1)
        IF THIS.this_lEmLookupStatus
            RETURN
        ENDIF

        THIS.this_lEmLookupStatus = .T.

        TRY
            THIS.AbrirLookupStatusStsExec(par_oTxt)
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar o status:" + CHR(13) + loc_oErro.Message + ;
                CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em AbrirLookupStatusSts")
        ENDTRY

        THIS.this_lEmLookupStatus = .F.
    ENDPROC

    *==========================================================================
    * AbrirLookupStatusStsExec - corpo do lookup (ver o funil acima).
    *
    * fwbuscaext legado -> FormBuscaAuxiliar canonico do projeto, mesma
    * tabela (SigStats), mesmo campo de busca (cods) e as MESMAS duas
    * colunas no picker, na mesma ordem do legado (Cods/Descs). O 9o
    * argumento do fwbuscaext ('Cods') eh o campo de ORDENACAO, nao filtro:
    * o FormBuscaAuxiliar ja ordena pelo campo de busca, entao nao ha
    * par_cFiltro a passar. par_lBuscaExata = .T. transcreve o .t. do
    * legado.
    *
    * O alias do picker eh o literal cursor_4c_Busca (valor de
    * SigOpStsBO.this_cCursorBusca, documentado la como o CrListaRemota do
    * legado) - nome fixo nos dois lados nao tem como divergir.
    *
    * Contrato this_lAchouRegistro/this_lSelecionou (regra #37): o Init do
    * FormBuscaAuxiliar ja tenta o match EXATO e, achando 1 registro,
    * resolve o valor sozinho sem abrir o Show() - exatamente o
    * "If Not xBrox.plAchouRegistro" do legado. O valor eh atribuido SO
    * dentro da guarda this_lSelecionou.
    *
    * Nada selecionado -> a celula E a descricao da linha voltam a vazio.
    * O legado atribui This.Value = CrListaRemota.Cods sem guarda nenhuma
    * (lendo o registro em que o browse por acaso parou); aqui, deixar o
    * codigo invalido na celula seria pior do que limpar, porque o When
    * passaria a .F. (status nao-vazio) e a linha ficaria TRAVADA com um
    * status que nao existe em SigStats - e o funil de gravacao (Fase 7)
    * tentaria inserir esse codigo. Limpando, a linha continua editavel e o
    * usuario digita de novo. Nao eh o caso da regra #50 (la o defeito eh
    * apagar o digitado SEM abrir picker, o que impede preencher): aqui o
    * picker JA foi exibido com o prefixo digitado.
    *
    * Legado: "Replace Descs With CrListaRemota.Descs in LocalStats" - o
    * REPLACE age no registro CORRENTE do alias, que eh a linha ativa da
    * grade. Aqui ele mora em BOParaForm (Fase 8), que grava descs E status
    * na mesma linha: no legado o status chega ao cursor pelo bind da Column1
    * quando o Valid devolve .T., e gravar os dois juntos impede a janela em
    * que a linha fica com a descricao de um status e o codigo de outro.
    *
    * Fecha repintando (regra #21): o legado faz "This.Refresh" e a grade
    * precisa redesenhar para a Column2 mostrar a descricao nova - tambem
    * dentro de BOParaForm, que eh o ponto UNICO do write-back.
    *
    * Metodo PUBLIC (regra #3/#46).
    *==========================================================================
    PROCEDURE AbrirLookupStatusStsExec(par_oTxt)
        LOCAL loc_cValor, loc_oBusca, loc_cCodigo, loc_cDescricao, loc_lResolveu

        loc_cValor     = ALLTRIM(NVL(par_oTxt.Value, ""))
        loc_cCodigo    = ""
        loc_cDescricao = ""
        loc_lResolveu  = .F.

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigStats", "cursor_4c_Busca", "cods", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o", .T., .T.)

        IF VARTYPE(loc_oBusca) = "O"
            *-- Legado: If Not xBrox.plAchouRegistro -> mAddColuna + Show
            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
            ENDIF

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                SELECT cursor_4c_Busca
                loc_cCodigo    = ALLTRIM(NVL(cursor_4c_Busca.cods,  ""))
                loc_cDescricao = ALLTRIM(NVL(cursor_4c_Busca.descs, ""))
                loc_lResolveu  = !EMPTY(loc_cCodigo)
            ENDIF

            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_Busca")
            USE IN cursor_4c_Busca
        ENDIF

        *-- O resultado do picker volta para a linha PELA FICHA (o BO), que eh
        *-- o transporte desta tela (Fase 8): FormParaBO carrega a identidade
        *-- da linha corrente, o resultado do lookup sobrescreve status/descs e
        *-- BOParaForm devolve os dois ao cursor, a celula e a grade. Assim o
        *-- REPLACE existe em UM lugar so - duas copias do mesmo write-back
        *-- poderiam divergir (uma gravando o status, a outra nao)
        THIS.FormParaBO(par_oTxt)

        *-- Legado: This.Value = CrListaRemota.Cods
        *--         Replace Descs With CrListaRemota.Descs in LocalStats
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_cStatus = IIF(loc_lResolveu, loc_cCodigo, "")
            THIS.this_oBusinessObject.this_cDescs  = IIF(loc_lResolveu, loc_cDescricao, "")
        ENDIF

        *-- Legado: Select LocalStats / This.Refresh (+ a grade, para a Column2
        *-- exibir a descricao que acabou de ser gravada no cursor - regra #21)
        THIS.BOParaForm(par_oTxt)
    ENDPROC

    *==========================================================================
    * StatusGradeLostFocus - LostFocus do Column1.Text1 legado:
    *
    *   If IsEmpty(This.Value)
    *       Thisform.cmdSair.SetFocus
    *   EndIf
    *
    * Celula abandonada em branco devolve o foco ao botao Encerrar: com
    * TitleBar = 0 e ControlBox = .F. ele eh a unica saida da tela, e o
    * legado nao deixa o foco preso numa linha que nao vai ser gravada.
    *
    * IsEmpty do Fortyus (que trata NULL como vazio) -> EMPTY(NVL(...)) -
    * o wrapper utils\isempty.prg existe justamente por essa diferenca.
    *
    * NAO chama o lookup: lookup em LostFocus abriria o picker a cada saida
    * de celula vazia. Quem dispara o picker eh o Valid (com valor
    * digitado), o F4/F5 e o duplo clique.
    *
    * Metodo PUBLIC (regra #3/#46).
    *==========================================================================
    PROCEDURE StatusGradeLostFocus(par_oTxt)
        IF EMPTY(NVL(par_oTxt.Value, "")) AND PEMSTATUS(THIS, "cmd_4c_Sair", 5)
            IF THIS.cmd_4c_Sair.Visible AND THIS.cmd_4c_Sair.Enabled
                THIS.cmd_4c_Sair.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarBINDEVENTs - Fase 7: liga o Click dos tres botoes do legado
    * (cmdInserir/cmdExcluir/cmdSair) aos handlers desta fase.
    *
    * Botao criado por AddObject nasce SEM codigo de evento: sem BINDEVENT o
    * Click nunca dispara e o usuario clica sem nada acontecer.
    *
    * Os handlers destino sao PUBLIC (sem PROTECTED) - BINDEVENT falha em
    * SILENCIO com metodo PROTECTED (regra #3).
    *
    * A celula da Column1 NAO entra aqui: os eventos When/Valid/LostFocus dela
    * moram na classe do TextBox instalado em ConfigurarGrade
    * (TextBoxStatusSts_4c), porque BINDEVENT em evento de celula de Grid nao
    * eh confiavel (regra #46).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBINDEVENTs
        BINDEVENT(THIS.cmd_4c_Inserir, "Click", THIS, "CmdInserirClick")
        BINDEVENT(THIS.cmd_4c_Excluir, "Click", THIS, "CmdExcluirClick")
        BINDEVENT(THIS.cmd_4c_Sair,    "Click", THIS, "BtnSairClick")
    ENDPROC

    *==========================================================================
    * CmdInserirClick - cmdInserir.Click do legado, transcrito:
    *
    *   Thisform.lHouveIns = .T.
    *   Select LocalStats
    *   Locate for Dopes = crSigCdOpe.Dopes And status = ' '
    *   If Eof()
    *       Insert Into LocalStats (Dopes, CidChaves) ;
    *           Values (crSigCdOpe.Dopes, fUniqueIds())
    *   EndIf
    *   Select LocalStats
    *   Thisform.GradeSubN.Column1.SetFocus
    *
    * O LOCATE eh um GUARD contra linha em branco repetida: se a linha vazia
    * criada na vez anterior ainda nao foi preenchida, o legado REAPROVEITA ela
    * em vez de criar outra (e o LOCATE deixa o ponteiro nela, que eh onde o
    * foco vai parar). Sem esse guard o usuario acumularia linhas em branco e
    * seria barrado na gravacao pela validacao de duplicidade, que conta o
    * status vazio junto com os demais (ver SigOpStsBO.ExisteStatusDuplicado).
    *
    * Grava SO no cursor LOCAL - igual ao legado, que trabalha sobre o cursor
    * do pai e so persiste no Encerrar (Zap + Insert + UpDate + Commit ->
    * BtnSairClick / SigOpStsBO.GravarStatus). A PK vai ja preenchida com
    * fUniqueIds() (regra #22: cidchaves NUNCA em branco).
    *
    * O status fica vazio de proposito: eh justamente isso que faz o When da
    * celula (CelulaStatusEditavel) liberar a digitacao NESTA linha e manter as
    * demais travadas.
    *
    * O "Select LocalStats" final do legado nao precisa ser reproduzido como
    * efeito colateral: a grade exibe pelo RecordSource, e este form roda na
    * DataSession do PAI (DataSession = 1), onde deixar outro alias selecionado
    * atrapalharia quem chamou - por isso o alias anterior eh restaurado.
    *
    * Column1.SetFocus() eh o que o legado chama, e Column TEM esse metodo
    * (medido no VFP9 em 2026-11-17: PEMSTATUS(Column1, "SetFocus", 5) = .T.).
    * NAO usar Grid.ActiveColumn = 1 no lugar: medido na mesma sessao,
    * ActiveColumn eh READ-ONLY em runtime ("Property ACTIVECOLUMN is
    * read-only") e derrubaria o handler.
    *
    * Repinta a grade antes de focar: inserir no cursor NAO repinta sozinho
    * (regra #21a) e a linha nova so aparece depois do Refresh.
    *
    * Metodo PUBLIC (regra #3): alcancado por BINDEVENT e pelo harness.
    *==========================================================================
    PROCEDURE CmdInserirClick
        LOCAL loc_cAliasAnterior, loc_cCidChaves, loc_oErro

        TRY
            IF USED("cursor_4c_Status")
                *-- Legado: Thisform.lHouveIns = .T. (dono unico da flag eh o
                *-- BO - ver cabecalho de SigOpStsBO.prg)
                IF VARTYPE(THIS.this_oBusinessObject) = "O"
                    THIS.this_oBusinessObject.this_lHouveInclusao = .T.
                ENDIF

                loc_cAliasAnterior = ALIAS()
                SELECT cursor_4c_Status

                LOCATE FOR ALLTRIM(NVL(dopes, "")) == ALLTRIM(THIS.this_cOperacaoPai) ;
                    AND EMPTY(NVL(status, ""))

                IF !FOUND()
                    loc_cCidChaves = LEFT(ALLTRIM(fUniqueIds()), 20)

                    INSERT INTO cursor_4c_Status (dopes, cidchaves) ;
                        VALUES (THIS.this_cOperacaoPai, loc_cCidChaves)
                ENDIF

                IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
                    SELECT (loc_cAliasAnterior)
                ENDIF

                IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                    THIS.grd_4c_Dados.Refresh()

                    *-- Column1 so existe com a grade VINCULADA: medido no
                    *-- VFP9 (ver GarantirCelulaStatus), grade que perdeu o
                    *-- alias fica com ColumnCount = 0 e o SetFocus estoura
                    *-- "Unknown member COLUMN1" - erro cru na cara do
                    *-- usuario DEPOIS de a linha ja ter sido inserida
                    IF PEMSTATUS(THIS.grd_4c_Dados, "Column1", 5)
                        THIS.grd_4c_Dados.Column1.SetFocus()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CmdInserirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdExcluirClick - cmdExcluir.Click do legado, transcrito:
    *
    *   Select LocalStats
    *   If Not Eof()
    *       Thisform.lHouveExcl = .T.
    *       Delete
    *       Skip
    *       Skip - 1
    *   Endif
    *   Thisform.GradeSubN.Refresh
    *
    * O legado NAO confere a operacao-pai da linha aqui (diferente do dialogo
    * irmao SIGOPSQN, que testa cDopes antes de apagar) - e nao precisa: o
    * cursor desta tela ja vem filtrado pela operacao-pai
    * (SigOpStsBO.ListarStatusOperacao) e as linhas novas nascem com a mesma
    * operacao (CmdInserirClick). Transcrito como esta: acrescentar a condicao
    * aqui seria inventar regra que o legado nao tem (regra #21b).
    *
    * O par "Skip / Skip -1" do legado eh o que reposiciona o ponteiro numa
    * linha VIVA depois da marcacao (com SET DELETED ON - fixado pelo
    * config.prg - a linha marcada desaparece da grade de imediato).
    *
    * So MARCA a linha no cursor LOCAL: o DELETE no SQL Server acontece no
    * Encerrar, e la ele eh um DELETE do conjunto INTEIRO da operacao seguido
    * da reinsercao do que sobrou na grade (REPLACE-ALL - ver
    * SigOpStsBO.GravarStatus), e nao um DELETE por linha.
    *
    * O Refresh fica FORA do IF, como no dump.
    *
    * Metodo PUBLIC (regra #3): alcancado por BINDEVENT e pelo harness.
    *==========================================================================
    PROCEDURE CmdExcluirClick
        LOCAL loc_cAliasAnterior, loc_oErro

        TRY
            IF USED("cursor_4c_Status")
                loc_cAliasAnterior = ALIAS()
                SELECT cursor_4c_Status

                IF !EOF()
                    *-- Legado: Thisform.lHouveExcl = .T. (dono unico da flag
                    *-- eh o BO - ver cabecalho de SigOpStsBO.prg)
                    IF VARTYPE(THIS.this_oBusinessObject) = "O"
                        THIS.this_oBusinessObject.this_lHouveExclusao = .T.
                    ENDIF

                    DELETE
                    SKIP
                    SKIP -1
                ENDIF

                IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
                    SELECT (loc_cAliasAnterior)
                ENDIF
            ENDIF

            *-- Legado: Thisform.GradeSubN.Refresh (fora do IF, como no dump)
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CmdExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSairClick - cmdSair.Click do legado ("Encerrar", Cancel = .T., logo
    * tambem dispara no ESC). Transcrito:
    *
    *   If Thisform.cmdInserir.Visible Or Thisform.cmdExcluir.Visible
    *       If ( Thisform.lHouveExcl Or Thisform.lHouveIns )
    *           Select LocalStats / Go Bottom / Go Top
    *           <validacao: status duplicado> -> MessageBox + Return .f.
    *           <Zap + Insert + Delete + UpDate + Commit, com RollBack e
    *            MessageBox 'Erro na Gravacao dos Dados do Cadastro de
    *            Status.'>
    *       EndIf
    *   ENDIF
    *   Thisform.ParentForm.Enabled = .T.
    *   Thisform.mCtrlBotoes(.T.)
    *   ThisForm.Release
    *
    * FLUXO DE SAIDA - transcrito, nao "melhorado": SO a validacao de
    * duplicidade aborta o fechamento (o "Return .f." do legado, que esta
    * dentro do Scan dos totais); a FALHA DE GRAVACAO exibe a mensagem e FECHA
    * do mesmo jeito, porque no legado o RollBack ja desfez tudo. Manter o
    * dialogo aberto nesse caso convidaria a um segundo Encerrar, que repetiria
    * o Delete + Insert do conjunto inteiro.
    *
    * Modo so-leitura (Inserir e Excluir ambos invisiveis - pai em PROCURAR ou
    * usuario sem acesso): o legado NAO valida e NAO grava nada, so fecha.
    * Sessao sem inclusao nem exclusao: idem - este eh o guard que faz a tela
    * nao reescrever o conjunto so por ter sido aberta.
    *
    * "Go Bottom / Go Top" do legado forcava o cursor remoto bufferizado a
    * buscar TODAS as linhas antes do TableUpdate; no cursor local nao muda
    * nada, mas fica transcrito (so reposiciona o ponteiro).
    *
    * MsgAviso (nao MsgErro) na duplicidade: eh validacao de entrada do
    * usuario, nao falha tecnica - o dialogo vermelho com "Fechar Aplicacao" do
    * MsgErro/MostrarErro eh reservado a exception. A mensagem eh a do legado,
    * ao pe da letra, inclusive os quatro pontos de exclamacao e o codigo do
    * PRIMEIRO status repetido (this_cStatusDuplicado).
    *
    * A falha de gravacao NAO eh reanunciada aqui quando o BO ja a exibiu
    * (this_lErroExibido - regra #20): o GravarStatus mostra o texto do legado
    * junto com a mensagem real do SQL Server, que eh mais util.
    *
    * "ParentForm.Enabled = .T." roda no Destroy() deste form (chamado pelo
    * Release()). "mCtrlBotoes(.T.)" do legado reabilita BOTOES especificos do
    * pai porque la o pai ficava com os controles desabilitados um a um - aqui
    * o CarregarContextoFormPai desabilita o FORM PAI INTEIRO, entao reabilitar
    * o form basta e nao ha metodo equivalente a chamar (mesma decisao dos
    * dialogos irmaos FormSigOpSqn/FormSigOpSlc/FormSigOpSpr).
    *
    * Metodo PUBLIC (regra #3): alcancado por BINDEVENT e pelo harness.
    *==========================================================================
    PROCEDURE BtnSairClick
        LOCAL loc_lPodeFechar, loc_oErro

        loc_lPodeFechar = .T.

        TRY
            *-- Legado: If Thisform.cmdInserir.Visible Or
            *--            Thisform.cmdExcluir.Visible
            *-- (a mesma leitura usada por HabilitarCampos - ver ModoEdicaoAtivo)
            IF THIS.ModoEdicaoAtivo()
                IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
                   (THIS.this_oBusinessObject.this_lHouveExclusao OR ;
                    THIS.this_oBusinessObject.this_lHouveInclusao)

                    *-- Legado: Select LocalStats / Go Bottom / Go Top
                    IF USED("cursor_4c_Status")
                        SELECT cursor_4c_Status
                        GO BOTTOM
                        GO TOP
                    ENDIF

                    IF THIS.this_oBusinessObject.ExisteStatusDuplicado()
                        *-- Legado: 'Status '+Alltrim(Totais.status)+
                        *-- ' Digitado em Duplicidade!!!!'
                        MsgAviso("Status " + ;
                            ALLTRIM(THIS.this_oBusinessObject.this_cStatusDuplicado) + ;
                            " Digitado em Duplicidade!!!!", ;
                            "Aten" + CHR(231) + CHR(227) + "o")
                        loc_lPodeFechar = .F.
                    ELSE
                        IF !THIS.this_oBusinessObject.GravarStatus(THIS.this_cOperacaoPai)
                            *-- A base/o BO ja exibiram a falha com o texto do
                            *-- SQL Server (regra #20) - so reanuncia se nao
                            IF !THIS.this_oBusinessObject.this_lErroExibido
                                MsgErro("Erro na Grava" + CHR(231) + CHR(227) + ;
                                    "o dos Dados do Cadastro de Status.", ;
                                    "Status das Opera" + CHR(231) + CHR(245) + "es")
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_lPodeFechar = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em BtnSairClick")
        ENDTRY

        IF loc_lPodeFechar
            THIS.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    * FASE 8 - TRANSPORTE DA LINHA DA GRADE <-> BO E CONSOLIDACAO
    *
    * Esta tela nao tem campo nenhum fora da grade: a FICHA dela eh UMA LINHA
    * de cursor_4c_Status (cidchaves/dopes/status + descs do join com
    * SigStats). Por isso FormParaBO/BOParaForm transportam a LINHA CORRENTE,
    * e nao um bloco de TextBox de Page2 - que esta tela nao possui.
    *==========================================================================

    *==========================================================================
    * ModoEdicaoAtivo - a condicao que abre o cmdSair.Click legado:
    *
    *   If Thisform.cmdInserir.Visible Or Thisform.cmdExcluir.Visible
    *
    * Eh o teste de "esta tela esta editavel nesta sessao": o Init legado
    * esconde os dois botoes de linha quando o usuario nao tem acesso
    * (fChecaAcesso) ou quando o pai esta em PROCURAR, e nesse caso o
    * cmdSair.Click nao valida nem grava NADA - so fecha.
    *
    * Fonte UNICA dessa leitura (BtnSairClick e HabilitarCampos): a condicao
    * do legado fica escrita em UM lugar so, em vez de repetida nos dois.
    *
    * Nao reconsulta fChecaAcesso: o acesso ja foi resolvido uma vez em
    * AplicarVisibilidadeBotoes e esta refletido no Visible dos botoes -
    * chamar a funcao do Framework de novo custaria uma ida ao banco a cada
    * recarga da grade.
    *
    * Metodo PUBLIC (regra #3/#51): o harness de teste o alcanca de fora.
    *
    * Os RETURN de guarda ficam FORA de TRY/CATCH (regra #1).
    *==========================================================================
    PROCEDURE ModoEdicaoAtivo
        IF !PEMSTATUS(THIS, "cmd_4c_Inserir", 5) OR !PEMSTATUS(THIS, "cmd_4c_Excluir", 5)
            RETURN .F.
        ENDIF

        RETURN (THIS.cmd_4c_Inserir.Visible OR THIS.cmd_4c_Excluir.Visible)
    ENDPROC

    *==========================================================================
    * FormParaBO - leva a LINHA CORRENTE da grade para as properties do BO
    *
    * Equivale, nesta tela, ao que num form CRUD seria "ler os TextBox da
    * Page2": a linha da grade EH a ficha. Preenche, na ordem do schema de
    * SIGOPSTS (cidchaves char(20) / dopes char(20) / status char(1)) mais a
    * descricao vinda do join (SigStats.descs char(20)):
    *
    *   this_cCidChaves  <- cursor_4c_Status.cidchaves   (PK gerada no Inserir)
    *   this_cDopes      <- cursor_4c_Status.dopes       (operacao-pai)
    *   this_cStatus     <- a CELULA, quando ela esta em edicao; senao o cursor
    *   this_cDescs      <- cursor_4c_Status.descs       (exibicao, Column2)
    *
    * POR QUE A CELULA VENCE O CURSOR no status: dentro do Valid da celula o
    * valor digitado esta em par_oTxt.Value e o cursor da grade so o recebe
    * DEPOIS que o Valid devolve .T. (regra #46) - ler o cursor ali carregaria
    * o valor ANTIGO. Chamado sem par_oTxt (fora de edicao), le o cursor.
    *
    * this_lNovoRegistro espelha a regra do When legado
    * (Return( Empty( LocalStats.status ) )): linha ainda sem status eh a
    * linha NOVA, criada pelo botao Inserir e nunca resolvida no lookup.
    *
    * Nao muda a area de trabalho corrente: le tudo qualificado pelo alias
    * (cursor_4c_Status.<campo>), sem SELECT. Este form roda na DataSession do
    * PAI (DataSession = 1), onde trocar o alias corrente sem necessidade
    * atrapalha quem chamou.
    *
    * PROTECTED EXPLICITO, e nao por escolha de estilo: FormBase declara
    * PROTECTED PROCEDURE FormParaBO (formbase.prg:285), e em VFP9 a subclasse
    * NAO pode ALARGAR o escopo herdado - escrever o metodo sem o modificador
    * nao o torna publico, so MENTE para quem le. Medido neste form em
    * 2026-11-18: PEMSTATUS(oForm, "FormParaBO", 2) devolve .T. (Protected) e a
    * chamada de FORA estoura "Property FORMPARABO is not found." - por isso
    * so eh chamado por THIS. de dentro da classe (regra #8), a partir de
    * AbrirLookupStatusStsExec.
    *
    * Os RETURN de guarda ficam FORA de TRY/CATCH (regra #1).
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO(par_oTxt)
        LOCAL loc_cStatus

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        IF !USED("cursor_4c_Status")
            RETURN .F.
        ENDIF

        IF EOF("cursor_4c_Status")
            RETURN .F.
        ENDIF

        *-- Identidade e vinculo da linha: SEMPRE do cursor (a celula editavel
        *-- desta grade eh so a do status)
        THIS.this_oBusinessObject.this_cCidChaves = ALLTRIM(NVL(cursor_4c_Status.cidchaves, ""))
        THIS.this_oBusinessObject.this_cDopes     = ALLTRIM(NVL(cursor_4c_Status.dopes, ""))

        *-- descs so existe quando o cursor veio do join com SigStats; um
        *-- cursor so com as colunas de SIGOPSTS nao tem esse campo (mesma
        *-- guarda de SigOpStsBO.CarregarDoCursor)
        IF TYPE("cursor_4c_Status.descs") != "U"
            THIS.this_oBusinessObject.this_cDescs = ALLTRIM(NVL(cursor_4c_Status.descs, ""))
        ELSE
            THIS.this_oBusinessObject.this_cDescs = ""
        ENDIF

        loc_cStatus = ALLTRIM(NVL(cursor_4c_Status.status, ""))

        IF VARTYPE(par_oTxt) = "O"
            IF PEMSTATUS(par_oTxt, "Value", 5)
                loc_cStatus = ALLTRIM(NVL(par_oTxt.Value, ""))
            ENDIF
        ENDIF

        THIS.this_oBusinessObject.this_cStatus       = loc_cStatus
        THIS.this_oBusinessObject.this_lNovoRegistro = EMPTY(loc_cStatus)

        RETURN .T.
    ENDPROC

    *==========================================================================
    * BOParaForm - devolve as properties do BO para a LINHA CORRENTE da grade
    *
    * Sentido inverso do FormParaBO e transcricao do trecho do Valid legado
    * que escreve de volta:
    *
    *   This.Value = CrListaRemota.Cods
    *   Replace Descs With CrListaRemota.Descs in LocalStats
    *   This.Refresh
    *   Select LocalStats
    *
    * Grava SO no cursor LOCAL - igual ao legado, que persiste em SIGOPSTS
    * apenas no Encerrar (BtnSairClick -> SigOpStsBO.GravarStatus).
    *
    * LEFT() pela largura da COLUNA no schema (status char(1), descs
    * char(20)), nunca pelo Width em pixels do controle (regra #19): assim o
    * que o cursor recebe eh exatamente o que cabe na coluna do SQL Server no
    * INSERT do Encerrar.
    *
    * par_oTxt eh OPCIONAL: durante o lookup a celula precisa exibir o codigo
    * escolhido (o "This.Value =" do legado); chamado sem ela, so o cursor e a
    * grade sao atualizados.
    *
    * Repinta ao fim (regra #21): gravar no cursor NAO repinta a grade, e sem
    * o Refresh a Column2 continuaria mostrando a descricao anterior.
    *
    * Deixa cursor_4c_Status como alias corrente, igual ao "Select LocalStats"
    * com que o Valid legado termina.
    *
    * PROTECTED EXPLICITO pela MESMA razao do FormParaBO acima (FormBase
    * declara PROTECTED PROCEDURE BOParaForm em formbase.prg:280): a subclasse
    * nao alarga o escopo herdado, entao o metodo eh chamado por THIS. de
    * dentro da classe - aqui, por AbrirLookupStatusStsExec.
    *
    * Os RETURN de guarda ficam FORA de TRY/CATCH (regra #1).
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm(par_oTxt)
        LOCAL loc_lSucesso, loc_cStatus, loc_cDescs

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        loc_lSucesso = .F.
        loc_cStatus  = LEFT(ALLTRIM(NVL(THIS.this_oBusinessObject.this_cStatus, "")), 1)
        loc_cDescs   = LEFT(ALLTRIM(NVL(THIS.this_oBusinessObject.this_cDescs, "")), 20)

        IF USED("cursor_4c_Status")
            *-- Legado: Select LocalStats (fica corrente no fim, como no dump)
            SELECT cursor_4c_Status

            IF !EOF()
                *-- Legado: Replace Descs With CrListaRemota.Descs in LocalStats
                *-- (o status tambem entra aqui: no legado quem o grava eh o
                *-- bind da Column1 quando o Valid devolve .T., e gravar os
                *-- dois juntos impede que a linha fique com codigo de um
                *-- status e descricao de outro)
                REPLACE status WITH loc_cStatus, ;
                        descs  WITH loc_cDescs
                loc_lSucesso = .T.
            ENDIF
        ENDIF

        *-- Legado: This.Value = CrListaRemota.Cods / This.Refresh
        IF VARTYPE(par_oTxt) = "O"
            IF PEMSTATUS(par_oTxt, "Value", 5)
                par_oTxt.Value = loc_cStatus
                par_oTxt.Refresh()
            ENDIF
        ENDIF

        *-- Regra #21: gravar no cursor nao repinta a grade
        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.Refresh()
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * LimparCampos - zera a ficha da linha (as properties de entidade do BO)
    *
    * Esta tela nao tem campo fora da grade para limpar: o que se limpa eh a
    * ficha que FormParaBO/BOParaForm carregam, de modo que a linha lida numa
    * sessao nunca vaze para a seguinte. Sem esse reset no FUNIL de carga, a
    * primeira linha tocada deixaria cidchaves/dopes/status/descs presos no BO
    * e um BOParaForm disparado antes de qualquer FormParaBO regravaria a linha
    * corrente com os valores da ANTERIOR - o mesmo tipo de vazamento de estado
    * que as flags lhouveins/lhouveexcl sofrem quando nao sao repostas.
    *
    * NAO mexe no contexto recebido do pai (this_cOperacaoPai/this_cEscolha/
    * this_nDataSessionPai) nem nas flags de sessao: aquilo eh o escopo do
    * dialogo, vive do Init ao Release e eh reposto por CarregarDados.
    *
    * LimparDados() do BO entra para zerar this_cMensagemErro (eh o que a
    * implementacao de BusinessBase faz) - as properties de entidade sao
    * zeradas aqui, uma a uma, com o valor-tipo de cada coluna.
    *
    * PROTECTED EXPLICITO pela MESMA razao do FormParaBO/BOParaForm (FormBase
    * declara PROTECTED PROCEDURE LimparCampos em formbase.prg:276): a
    * subclasse nao alarga o escopo herdado, entao eh chamado por THIS. de
    * dentro da classe - aqui, por CarregarDados.
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.LimparDados()

            THIS.this_oBusinessObject.this_cCidChaves    = ""
            THIS.this_oBusinessObject.this_cDopes        = ""
            THIS.this_oBusinessObject.this_cStatus       = ""
            THIS.this_oBusinessObject.this_cDescs        = ""
            THIS.this_oBusinessObject.this_lNovoRegistro = .F.

            *-- Resultado da ultima checagem de duplicidade: sem isto, o
            *-- codigo repetido de uma tentativa de Encerrar reapareceria na
            *-- mensagem da tentativa seguinte
            THIS.this_oBusinessObject.this_cStatusDuplicado = ""
        ENDIF
    ENDPROC

    *==========================================================================
    * HabilitarCampos - abre ou fecha a edicao da tela
    *
    * O legado nao tem um metodo com este nome: ele decide a editabilidade em
    * dois lugares - a visibilidade de cmdInserir/cmdExcluir no Init
    * (fChecaAcesso + pcEscolha, ver AplicarVisibilidadeBotoes) e o
    * When = Empty(LocalStats.status) da celula. Este metodo eh o ponto UNICO
    * onde esse resultado eh aplicado aos controles, e existe por um motivo
    * concreto: o rebind da grade (VincularGrade) RESETA Column.ReadOnly junto
    * com Width/Caption/CurrentControl (Problema 48 / regra #41), entao a cada
    * recarga a trava da Column1 tem de ser reaplicada. Reatribuir .F. ali
    * destravaria a celula tambem no modo so-leitura do pai - e quem desabilita
    * tem de reabilitar no FUNIL, nunca so no caminho de ida (regra #40).
    *
    * Sem argumento, deriva o estado de ModoEdicaoAtivo() - a mesma condicao
    * que abre o cmdSair.Click legado.
    *
    * Botao INVISIVEL nao eh reabilitado: Inserir/Excluir escondidos por
    * fChecaAcesso continuam Enabled = .F., senao esta reabilitacao
    * atropelaria o controle de acesso que o Init do legado aplicou.
    *
    * cmd_4c_Sair fica SEMPRE habilitado: com TitleBar = 0 e ControlBox = .F.
    * ele eh a unica saida da tela, e desabilita-lo prenderia o usuario.
    *
    * A Column2 nao aparece aqui: ela eh somente leitura em qualquer modo
    * (legado: When = .f.) e quem a trava eh VincularGrade.
    *
    * Metodo PUBLIC (regra #3/#51): o harness de teste o alcanca de fora.
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar

        *-- PCOUNT() eh OBRIGATORIO aqui: em VFP9 parametro declarado e NAO
        *-- passado chega como .F. LOGICO, entao VARTYPE(par_lHabilitar) = "L"
        *-- eh verdade tanto para "nao passou" quanto para "passou .F." - o
        *-- guard so por VARTYPE fazia HabilitarCampos() SEM argumento travar a
        *-- celula em vez de derivar o modo. Medido neste form em 2026-11-18:
        *-- com o guard por VARTYPE, Column1.ReadOnly ficava .T. ao abrir a
        *-- tela em modo editavel (compila limpo, nao estoura, nao entra em log)
        loc_lHabilitar = THIS.ModoEdicaoAtivo()

        IF PCOUNT() >= 1 AND VARTYPE(par_lHabilitar) = "L"
            loc_lHabilitar = par_lHabilitar
        ENDIF

        *-- Column1 (status): ReadOnly da COLUNA depois do Grid (regra #46).
        *-- Column1 so existe com a grade VINCULADA - grade que perdeu o alias
        *-- fica com ColumnCount = 0 (ver a medicao em GarantirCelulaStatus) e
        *-- tocar .Column1 ali estouraria "Unknown member COLUMN1"
        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            IF PEMSTATUS(THIS.grd_4c_Dados, "Column1", 5)
                THIS.grd_4c_Dados.Column1.ReadOnly = !loc_lHabilitar
            ENDIF
        ENDIF

        *-- Botoes de linha: so o que o controle de acesso deixou VISIVEL
        IF PEMSTATUS(THIS, "cmd_4c_Inserir", 5)
            THIS.cmd_4c_Inserir.Enabled = loc_lHabilitar AND THIS.cmd_4c_Inserir.Visible
        ENDIF

        IF PEMSTATUS(THIS, "cmd_4c_Excluir", 5)
            THIS.cmd_4c_Excluir.Enabled = loc_lHabilitar AND THIS.cmd_4c_Excluir.Visible
        ENDIF

        *-- Unica saida da tela - nunca desabilitada
        IF PEMSTATUS(THIS, "cmd_4c_Sair", 5)
            THIS.cmd_4c_Sair.Enabled = .T.
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - nome canonico do projeto para "reaplicar o estado
    * dos botoes conforme o modo", apontando para o metodo que faz esse
    * trabalho nesta tela: AplicarVisibilidadeBotoes, que transcreve as quatro
    * linhas de .cmdInserir/.cmdExcluir .Visible/.Enabled do Init legado mais o
    * recalculo de shape1.Left/Width.
    *
    * Existe para que o caminho canonico (harness de teste automatizado e
    * qualquer chamada externa que siga a convencao do projeto) alcance a
    * logica real em vez de nao encontrar metodo algum - PEMSTATUS devolve .T.
    * para metodo PROTECTED e a chamada externa estouraria em runtime
    * (regra #3), por isso este eh PUBLIC e AplicarVisibilidadeBotoes
    * permanece PROTECTED.
    *
    * HabilitarCampos nao eh chamado aqui de novo: AplicarVisibilidadeBotoes
    * ja o chama no fim, para que a trava da celula acompanhe os botoes.
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo
        THIS.AplicarVisibilidadeBotoes()
    ENDPROC

    *==========================================================================
    * CarregarLista - nome canonico do projeto para a carga da grade de lista,
    * apontando para o funil real desta tela: CarregarDados, que transcreve o
    * bloco de consulta/bind/Refresh do Init legado.
    *
    * A grade desta tela (GradeSubN -> grd_4c_Dados) eh a unica lista que
    * existe aqui, e carrega-la eh exatamente o que CarregarDados faz - um
    * segundo caminho de carga duplicaria a consulta e as duas poderiam
    * divergir. Mesma razao do AjustarBotoesPorModo acima: o caminho canonico
    * precisa alcancar a logica real, e ela eh unica.
    *
    * Devolve o mesmo .T./.F. de CarregarDados (.F. quando o BO ainda nao
    * existe ou a consulta falha - a tela continua aberta com a grade vazia).
    *
    * Metodo PUBLIC (regra #3/#51): o harness de teste o alcanca de fora.
    *==========================================================================
    PROCEDURE CarregarLista
        RETURN THIS.CarregarDados()
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - AddObject cria controle com Visible = .F.;
    * percorre recursivamente o container e torna tudo visivel. Cada form
    * tem a propria copia deste metodo (nao esta no FormBase).
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
    * cmdSair.Click faz .ParentForm.Enabled = .t. + mCtrlBotoes(.T.) antes
    * do ThisForm.Release; aqui tambem fica como rede de seguranca para
    * qualquer caminho de fechamento que nao passe pelo botao Encerrar -
    * ESC/fechamento externo).
    *
    * mCtrlBotoes nao eh reproduzido: esta tela desabilita o FORM PAI
    * INTEIRO (CarregarContextoFormPai), o que ja produz o efeito
    * pretendido e eh MAIS correto - o legado forcava Enabled = .T. em
    * todos os botoes no retorno, atropelando o estado que o modo do pai
    * tinha definido (mesma decisao dos dialogos irmaos FormSigOpSqn/
    * FormSigOpSlc/FormSigOpSpr).
    *==========================================================================
    PROCEDURE Destroy
        IF VARTYPE(THIS.this_oFormPai) = "O"
            THIS.this_oFormPai.Enabled = .T.
            THIS.this_oFormPai         = .NULL.
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
