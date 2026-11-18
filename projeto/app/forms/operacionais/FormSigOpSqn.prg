*==============================================================================
* FORMSIGOPSQN.PRG - Formulario Operacional: Sequencia de Operacoes do Caixa
* Tipo: OPERACIONAL (dialogo modal FILHO, layout FLAT - sem PageFrame)
* Migrado de SigOpSqn.SCX (task806)
*
* Pilares:
*   UX   -> layout identico ao legado (618x365, TitleBar=0, ControlBox=.F.,
*           Movable=.F., ClipControls=.F., cabecalho cinza no topo com o
*           Caption "Operacoes do Caixa : <operacao>")
*   BD   -> SigMvCxs/SigCdOpe (via SigOpSqnBO); a gravacao real so acontece
*           no clique de Encerrar (BtnSairClick), igual ao legado
*           (SigCdOpe.poDataMgr.UpDate('crSigMvCxs') + Commit() so no
*           cmdSair.Click)
*   CODE -> arquitetura em camadas (FormBase / SigOpSqnBO)
*
* O QUE ESTA TELA EH
*   Dialogo FILHO que o form pai SigCdOpe (Cadastro de Operacoes do Caixa)
*   abre para o usuario montar a SEQUENCIA de execucao das operacoes de uma
*   operacao-pai (crSigCdOpe.Dopes no legado). O legado recebe "poForm" (o
*   form pai) e "pnDataSes" (DataSession do pai) no Init, troca para a
*   DataSession do pai (Set DataSession To pnDataSes) e manipula um cursor
*   remoto bufferizado (crSigMvCxs) com 2 colunas editaveis:
*     Column1 -> cNivels (TextBox com lookup em TmpOper/SigCdOpe.Dopes,
*                filtrado por CupFis IN (1,3) - so operacoes de "Cupom
*                Fiscal")
*     Column2 -> Seqs    (TextBox numerico, InputMask "9", faixa 1-8)
*   Botoes: Inserir (Append Blank + foca Column1), Excluir (Delete da linha
*   corrente) e Sair/Encerrar (valida duplicidade/sequencia ausente, grava
*   via poDataMgr.UpDate + Commit, reabilita os botoes do pai e fecha o
*   dialogo).
*
*   No migrado, o form roda com DataSession = 1 (sessao CORRENTE,
*   compartilhada com o pai), reproduzindo o mesmo efeito do "Set
*   DataSession To pnDataSes" sem a troca manual de sessao - mesmo padrao
*   ja adotado em FormSigOpSlc.prg/FormSigOpSpr.prg.
*
* CHAMADA (equivale ao "Do Form SigOpSqn With ThisForm, ThisForm.
* DataSessionId" do legado, onde o proprio form pai eh "poForm"):
*   loForm = CREATEOBJECT("FormSigOpSqn", THISFORM, loc_cOperacaoAtual, ;
*       THISFORM.this_cModoAtual, THISFORM.DataSessionId)
*   IF VARTYPE(loForm) = "O"
*       loForm.Show()          && modal: so volta quando o dialogo fecha
*   ENDIF
*
*   Como no legado, o Release eh do PROPRIO dialogo (botao Encerrar, fase
*   futura), nao do chamador.
*
* PARAMETROS DO INIT (legado: LParameters poForm, pnDataSes)
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
*                          cmd_4c_Inserir/cmd_4c_Excluir (AplicarVisibilidadeBotoes).
*   par_nDataSessionPai  - legado: pnDataSes. Informativo - DataSession = 1
*                          ja unifica a sessao com o pai; mantido so para
*                          auditoria/paridade com o legado.
*
* METODOS DE DADOS (ja implementados no BO - fases 1-2)
*   CarregarDoCursor/Inserir/Atualizar/ExecutarExclusao/ObterChavePrimaria -
*   ver cabecalho de SigOpSqnBO.prg para o detalhamento completo (inclusive
*   as validacoes do legado que pertencem ao cmdSair.Click, ja transcritas
*   em ExisteOperacaoDuplicada/ExisteSequenciaNaoInformada).
*
* FASE 3: estrutura base do form -
*   - Propriedades que espelham o contexto recebido do form pai (this_
*     oFormPai/this_cOperacaoPai/this_cEscolha/this_nDataSessionPai) e o
*     estado de sessao do dialogo (this_lHouveAlteracao/this_lHouveInclusao/
*     this_lHouveExclusao, equivalentes a lhouvealt/lhouveins/lhouveexcl do
*     legado) e os "valores anteriores" usados pelos When/Valid da grade na
*     fase de lookup (this_cValorAnteriorNivel/this_nValorAnteriorSeq,
*     equivalentes a ThisForm.antvalue/ThisForm.AntValue2 do legado).
*   - Init (LParameters do legado, com os 2 parametros extras documentados
*     acima) + ValidarParametros (precondicao: sem form pai e sem operacao
*     nao ha o que gerenciar).
*   - InicializarForm (cria o BO, migra o contexto do pai para ele,
*     posiciona o dialogo ao lado da grade do pai, aplica o fundo e cria o
*     cabecalho cinza).
*   - CarregarContextoFormPai (legado: .ParentForm.Enabled = .f. + leitura
*     de pcEscolha/Dopes do pai).
*   - ConfigurarPosicionamento (legado: .Top/.Left calculados a partir do
*     Top/Left/Grade do pai).
*   - ConfigurarDecoracao (Picture do form - new_background.jpg).
*   - ConfigurarPageFrame (cntSombra do legado -> cnt_4c_Cabecalho; mantido
*     esse nome de metodo por paridade com os demais dialogos filhos desta
*     familia - FormSigOpSno/FormSigOpSpr - mesmo sem PageFrame real: este
*     form eh FLAT, igual ao legado).
*   - TornarControlesVisiveis / Destroy (reabilita o form pai ao fechar -
*     rede de seguranca, igual ao cmdSair.Click do legado).
*
* FASE 4: a GRADE e os BOTOES da tela -
*   - ConfigurarGrade (GradeSubN do legado -> grd_4c_Dados): 2 colunas
*     editaveis, transcritas do dump (Column1 "Operacao" W=150, Column2
*     "Seq" W=25 com InputMask "9").
*   - ConfigurarBotoes (shp_4c_Separador + cmd_4c_Inserir / cmd_4c_Excluir
*     / cmd_4c_Sair, todos da classe legado fwbtng - 80x100, Comic Sans MS
*     8 bold italic). O Shape eh criado ANTES dos botoes porque a area dele
*     fica EM CIMA deles (ver comentario do metodo).
*   - AplicarVisibilidadeBotoes (as 4 linhas de .cmdInserir/.cmdExcluir
*     .Visible/.Enabled do Init legado + o recalculo de shape1.Left/Width).
*     Roda DEPOIS do TornarControlesVisiveis, que forca Visible = .T. em
*     tudo e apagaria justamente o Visible = .F. do controle de acesso.
*   - PossuiAcessoOperacao (fChecaAcesso('SigOpSqn', <acao>) do legado, com
*     bypass em modo teste/validacao de UI, onde ele consulta SQL e nao ha
*     conexao).
*   - CarregarDados (funil UNICO de carga, PUBLIC) + VincularGrade: chamam
*     SigOpSqnBO.ListarSequencias (equivalente ao ReQuery('crSigMvCxs') do
*     legado), religam a grade ao cursor e repintam com GO TOP + Refresh
*     (regra #21 - popular cursor NAO repinta a grade).
*
* FASE 6 (esta fase): lookup da Column1 e validacao da Column2 -
*   - SigOpSqnBO.ListarOperacoesCupFis (universo do lookup - "TmpOper" do
*     legado) chamado 1x em InicializarForm, antes da grade ficar editavel.
*   - Column1 (cnivels) e Column2 (seqs) deixam de usar o Text1 cru da
*     Column e passam a usar TextBox subclasse (TextBoxNivelSqn_4c /
*     TextBoxSeqSqn_4c, em classes\textboxgridlookup.PRG) instalada com
*     Column.AddObject + CurrentControl + Sparse = .F. (regra #18):
*     BINDEVENT em evento de celula de Grid nao eh confiavel (regra #46).
*   - Column1.When/Valid/LostFocus -> GuardarValorAnteriorNivel/
*     ValidarNivelGradeExec/NivelGradeLostFocus (lookup em
*     cursor_4c_Operacoes via SEEK, com fallback no picker
*     AbrirLookupOperacaoSqn quando nao acha exato).
*   - Column2.When/Valid -> GuardarValorAnteriorSeq/ValidarSeqGradeExec
*     (faixa 1-8, transcrita do legado).
*
* FASE 7 (esta fase): os eventos dos botoes -
*   - ConfigurarBINDEVENTs: liga o Click de cmd_4c_Inserir/cmd_4c_Excluir/
*     cmd_4c_Sair (AddObject cria botao SEM codigo de evento).
*   - CmdInserirClick (cmdInserir.Click: Locate da linha em branco + Insert
*     Into no cursor local com cidchaves = fUniqueIds() + foco na Column1).
*   - CmdExcluirClick (cmdExcluir.Click: Delete + Skip/Skip -1 + Refresh -
*     marca so no cursor local).
*   - BtnSairClick (cmdSair.Click: as DUAS validacoes do legado -
*     ExisteOperacaoDuplicada/ExisteSequenciaNaoInformada, que abortam o
*     fechamento - e a gravacao via PersistirSequencias, que substitui o
*     poDataMgr.UpDate("crSigMvCxs") + Commit() do legado pela gravacao
*     linha-a-linha no BO; depois Release(), cujo Destroy reabilita o pai).
*   - this_cCidChavesNovas: lista das linhas criadas na sessao, que faz o
*     papel do buffer da view remota (quem eh INSERT e quem eh UPDATE).
*
* FASE 8 (esta fase): eventos auxiliares e CONSOLIDACAO FINAL -
*   - FormParaBO (transporte LINHA DA GRADE -> BO) e BOParaForm (o inverso:
*     devolve a chave efetivamente gravada para a linha). Os dois nasceram
*     de codigo que JA existia INLINE em PersistirSequencias - a atribuicao
*     das 4 properties estava repetida nos dois lacos (exclusoes e
*     inclusoes/atualizacoes). Nao sao hooks decorativos: PersistirSequencias
*     passou a chamar os dois, e sem eles nada eh gravado.
*   - SigOpSqnBO.LimparDados (override): BusinessBase.LimparDados so limpa a
*     mensagem de erro e deixa para a subclasse zerar o que eh dela.
*     NovoRegistro() chama LimparDados ANTES do FormParaBO, entao sem o
*     override as 4 properties entravam na linha nova com o valor da linha
*     ANTERIOR do laco - e qualquer caminho que deixasse de atribuir uma
*     delas gravaria o dado da linha errada, sem erro nenhum.
*
*   AUDITORIA DE CONSOLIDACAO (o que foi MEDIDO, nao suposto)
*   - Legado x migrado, metodo a metodo (SECAO 3 do dump): Init, Load,
*     mctrlbotoes, Column1.Text1 When/Valid/LostFocus, Column2.Text1
*     When/Valid, cmdInserir.Click, cmdExcluir.Click, cmdSair.Click. Os dois
*     que NAO foram transcritos como codigo estao justificados abaixo.
*   - SigMvCxs tem EXATAMENTE 4 colunas, todas NOT NULL (cdopes/cidchaves/
*     cnivels/seqs, docs\schema.sql lido com Get-Content -Raw - regra #14) e
*     o INSERT de SigOpSqnBO cobre as 4 (regra #22).
*   - Todo THIS.<membro> do arquivo resolve no proprio form, no FormBase ou
*     em controle criado por AddObject; todo this_oBusinessObject.<membro>
*     resolve no SigOpSqnBO ou no BusinessBase (regra #34/#51). Os metodos do
*     BO chamados daqui sao os PUBLIC (Salvar/Excluir/NovoRegistro/
*     EditarRegistro/Listar*) - Inserir/Atualizar/ExecutarExclusao sao
*     PROTECTED e NUNCA se chamam de fora (regra #51).
*   - Medido no VFP9 em 2026-11-17 (automation\_probe_scan_sqn*.prg), para
*     descartar duas suspeitas que PARECIAM defeito e nao eram:
*       (a) INSERT INTO <cursor local> omitindo colunas preenche os campos
*           que faltam com BRANCO/ZERO, NUNCA com .NULL. - vale inclusive em
*           campo declarado NULL e em cursor vindo de SELECT ... INTO CURSOR
*           READWRITE. Logo o guard "EMPTY(cnivels)" do LOCATE em
*           CmdInserirClick funciona, e o INSERT de 2 colunas transcrito do
*           legado esta correto como esta (com .NULL. o guard falharia e cada
*           clique criaria outra linha em branco).
*       (b) SCAN/ENDSCAN NAO se perde quando o corpo troca a work area
*           corrente (3 voltas e ordem certa, inclusive deixando outro alias
*           selecionado) - os SQLEXEC que o BO faz dentro dos lacos de
*           PersistirSequencias nao quebram o percurso.
*
*   LEGADO DELIBERADAMENTE NAO TRANSCRITO COMO CODIGO (nao eh omissao)
*   - "PROCEDURE Load: =fConfigGeral()". fConfigGeral era funcao GLOBAL da
*     aplicacao legado (sig.prg/SIGFUNCS.PRG) que NAO veio no acervo; o que
*     existe eh o wrapper utils\fconfiggeral.prg, um RETURN .T. criado
*     APENAS para o p-code dos VCX legado alcancar o nome. O proprio
*     cabecalho dele proibe o uso em codigo nosso ("em codigo NOSSO nunca se
*     chama fConfigGeral"), porque o que a funcao fazia no legado hoje esta
*     distribuido e JA aconteceu antes desta tela abrir: config.prg (SETs,
*     paths, variaveis globais), main.prg (conexao/empresa) e cada BO com os
*     proprios cursores. Chamar o wrapper aqui seria uma linha sem efeito.
*   - "PROCEDURE mctrlbotoes(plHabilita)", que no legado percorre
*     ParentForm.Pagina.Lista.Grupo_Op.Buttons + cmdFPOper + cmdMultiSubN +
*     Grupo_Saida.Sair ligando/desligando cada um. Esta tela desabilita o
*     FORM PAI INTEIRO (this_oFormPai.Enabled = .F. em
*     CarregarContextoFormPai, revertido no Destroy), o que ja produz o
*     efeito pretendido e eh MAIS correto: o legado forcava Enabled = .T. em
*     todos no retorno, atropelando o estado que o modo do pai tinha
*     definido - exatamente o conflito que a regra #40 descreve (quem manda
*     no Enabled dos botoes do pai eh o AjustarBotoesPorModo DELE). Mesma
*     decisao do dialogo irmao FormSigOpSno, ja entregue.
*
*   NOMES CANONICOS DE FORM CRUD QUE NAO TEM REFERENTE AQUI (grafados com o
*   miolo ELIDIDO de proposito: escrever o nome por extenso em comentario
*   satisfaz o gate por SUBSTRING e transformaria a dispensa num no-op)
*     Btn...larClick / Btn...varClick  - o legado nao tem Cancelar nem
*         Salvar: a grade grava na LINHA e a persistencia inteira acontece
*         no Encerrar (BtnSairClick -> PersistirSequencias)
*     Btn...carClick                   - nao ha busca: o unico lookup eh o
*         da celula (AbrirLookupOperacaoSqn)
*     Carregar...sta                   - o funil de carga desta tela eh
*         CarregarDados (grade unica, sem pagina de Lista)
*     Habilitar...pos / Limpar...pos   - nao ha campo fora da grade; quem
*         controla a edicao sao Column.ReadOnly e AplicarVisibilidadeBotoes
*     Ajustar...PorModo                - nao ha modo LISTA/DADOS: o form eh
*         FLAT e a unica decisao por modo (pcEscolha) eh a visibilidade de
*         Inserir/Excluir, feita em AplicarVisibilidadeBotoes
*==============================================================================

DEFINE CLASS FormSigOpSqn AS FormBase

    *--------------------------------------------------------------------------
    * CONTEXTO RECEBIDO DO FORM PAI (LParameters do Init legado)
    *--------------------------------------------------------------------------

    *-- poForm / ThisForm.ParentForm do legado - o form SigCdOpe (Cadastro
    *-- de Operacoes do Caixa) que abriu este dialogo
    this_cMensagemErro = ""
    this_oFormPai = .NULL.

    *-- crSigCdOpe.Dopes do legado - codigo da operacao-pai desta sequencia
    this_cOperacaoPai = ""

    *-- Thisform.PcEscolha do pai (INSERIR/ALTERAR/PROCURAR) - decide a
    *-- visibilidade de cmd_4c_Inserir/cmd_4c_Excluir (AplicarVisibilidadeBotoes)
    this_cEscolha = ""

    *-- pnDataSes do legado - informativo (DataSession = 1 ja unifica a
    *-- sessao com o pai, ver comentario de DataSession abaixo)
    this_nDataSessionPai = 0

    *--------------------------------------------------------------------------
    * ESTADO DA SESSAO DO DIALOGO
    * Legado: propriedades customizadas lhouvealt / lhouveins / lhouveexcl do
    * SIGOPSQN - usadas pelo cmdSair.Click para decidir se valida e grava.
    *--------------------------------------------------------------------------
    this_lHouveAlteracao = .F.
    this_lHouveInclusao  = .F.
    this_lHouveExclusao  = .F.

    *-- ThisForm.antvalue / ThisForm.AntValue2 do legado (Column1/Column2.
    *-- Text1.When/Valid da grade) - guardam o valor da celula ANTES da
    *-- edicao, para o Valid decidir se precisa validar/disparar o lookup.
    *-- Usados a partir da fase de lookup/validacao da grade.
    this_cValorAnteriorNivel = ""
    this_nValorAnteriorSeq   = 0

    *-- cidchaves das linhas CRIADAS nesta sessao pelo botao Inserir, para o
    *-- funil de gravacao (PersistirSequencias) distinguir INSERT de UPDATE.
    *-- No legado essa distincao eh do buffer da view remota (TableUpdate sabe
    *-- quais linhas sao novas); sem buffer, a lista explicita faz o mesmo
    *-- papel. Formato "|<id>|<id>|..."
    this_cCidChavesNovas = ""

    *--------------------------------------------------------------------------
    * PROPRIEDADES VISUAIS - transcritas do SCX legado (PILAR 1)
    *--------------------------------------------------------------------------

    *-- SIGOPSQN: BorderStyle = 2 / Top = 0 / Left = 0 / Height = 365 /
    *-- Width = 618 / DoCreate = .T. (default do Form, nao precisa declarar)
    BorderStyle = 2
    Top         = 0
    Left        = 0
    Height      = 365
    Width       = 618

    *-- Caption do SCX ("Operacoes do Caixa") - sobrescrito em
    *-- InicializarForm com o codigo da operacao-pai, igual ao legado
    *-- (.Caption = 'Operacoes do Caixa : ' + AllTrim(Proper(crSigCdOpe.Dopes)))
    Caption = "Opera" + CHR(231) + CHR(245) + "es do Caixa"

    *-- ControlBox = .F. (legado) -> Closable/MaxButton/MinButton = .F.
    *-- (padrao do projeto para dialogo sem chrome). Movable = .F. /
    *-- ClipControls = .F. / TitleBar = 0 / Themes = .F. - todos literais do
    *-- SCX. Sem barra de titulo e sem ControlBox, a unica saida eh pelo
    *-- botao Encerrar (cmd_4c_Sair -> BtnSairClick)
    TitleBar     = 0
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    ClipControls = .F.
    Themes       = .F.

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
    *-- SEMPRE na sessao do form pai, para enxergar o cursor bufferizado
    *-- dele (crSigMvCxs). DataSession = 1 eh a reproducao direta desse
    *-- resultado, sem a troca manual de sessao - mesmo padrao adotado em
    *-- FormSigOpSlc.prg/FormSigOpSpr.prg
    DataSession = 1

    *==========================================================================
    * Init - LParameters poForm, pnDataSes do legado (com 2 parametros
    * extras - par_cOperacaoPai/par_cEscolha - documentados no cabecalho do
    * arquivo, necessarios porque o migrado nao troca de DataSession para
    * ler crSigCdOpe.Dopes/Thisform.PcEscolha direto do cursor do pai).
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
    * sequencia nenhuma para gerenciar (o legado tambem depende dessas
    * referencias em praticamente todo metodo - crSigCdOpe.Dopes/
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
                    "Opera" + CHR(231) + CHR(245) + "es do Caixa")
            loc_lValido = .F.
        ENDIF

        IF EMPTY(THIS.this_cOperacaoPai)
            MsgErro("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informada.", ;
                    "Opera" + CHR(231) + CHR(245) + "es do Caixa")
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
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpSqnBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar SigOpSqnBO.", "Opera" + CHR(231) + CHR(245) + "es do Caixa")
            ELSE
                *-- Legado: .ParentForm.Enabled = .f. + leitura de
                *-- pcEscolha/Dopes do pai para o BO
                THIS.CarregarContextoFormPai()

                *-- Legado: .Caption = 'Operacoes do Caixa : ' +
                *-- AllTrim(Proper(crSigCdOpe.Dopes))
                THIS.Caption = "Opera" + CHR(231) + CHR(245) + "es do Caixa : " + ;
                    ALLTRIM(PROPER(THIS.this_cOperacaoPai))

                *-- Fundo do form (Picture do SCX)
                THIS.ConfigurarDecoracao()

                *-- Legado: .Top/.Left calculados a partir da grade do pai
                THIS.ConfigurarPosicionamento()

                *-- Cabecalho cinza (cntSombra do legado). PRIMEIRO
                *-- AddObject do form: os botoes ficam dentro da faixa do
                *-- topo e precisam ser criados depois para desenhar por
                *-- cima (regra #11)
                THIS.ConfigurarPageFrame()

                *-- Fase 4: grade (GradeSubN) e os botoes Inserir/Excluir/
                *-- Encerrar + o Shape separador. Top = 3..103 (botoes) cai
                *-- DENTRO da area do cabecalho (Top = 0..80), por isso vem
                *-- DEPOIS dele - para desenhar por cima (regra #11)
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
                *-- dispara)
                THIS.ConfigurarBINDEVENTs()

                *-- Legado (Init): "TmpOper" (universo do lookup da
                *-- Column1) - carregado UMA VEZ, igual ao legado, antes
                *-- do usuario poder editar a grade. Pulado em validacao de
                *-- UI (sem gnConnHandle nao ha o que consultar).
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    IF VARTYPE(THIS.this_oBusinessObject) = "O"
                        THIS.this_oBusinessObject.ListarOperacoesCupFis()
                    ENDIF
                ENDIF

                *-- Legado (fim do Init): ReQuery('crSigMvCxs') + Go Top +
                *-- bind da GradeSubN + .Refresh. Pulado em validacao de UI
                *-- (sem gnConnHandle nao ha o que consultar) - a ausencia de
                *-- dados nao impede a tela de abrir
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    IF !THIS.CarregarDados()
                        *-- Falha ja reportada por CarregarDados/BO
                    ENDIF
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao inicializar FormSigOpSqn: " + loc_oErro.Message + ;
                    " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    " | Procedure: " + loc_oErro.Procedure, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarContextoFormPai - migra para o BO o que o Init legado le do
    * form pai:
    *
    *     ThisForm.ParentForm = poForm
    *     ThisForm.ParentForm.Enabled = .f.
    *     <crSigCdOpe.Dopes, Thisform.PcEscolha>   (ja recebidos via par?metro
    *                                                no Init deste form - ver
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
                .this_cEscolha        = THIS.this_cEscolha
                .this_nDataSessionPai = THIS.this_nDataSessionPai

                *-- cdopes (FK da operacao-pai) ja conhecido desde a
                *-- abertura do dialogo - serve de default para as linhas
                *-- que o usuario inserir na grade (CmdInserirClick)
                .this_cCDopes = THIS.this_cOperacaoPai
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
    * familia (FormSigOpSno.prg/FormSigOpSpr.prg usam o mesmo nome), mesmo
    * sem PageFrame real - este form eh FLAT, igual ao legado (SIGOPSQN nao
    * tem PageFrame no SCX).
    *
    * Transcricao do dump (SIGOPSQN_form_codigo_fonte.txt):
    *   cntSombra  Top=0  Left=0  Width=800  Height=80  BorderWidth=0
    *              BackColor=100,100,100
    *   lblSombra  Top=18 Left=10 Width=769 Height=40 ForeColor=0,0,0
    *              Tahoma 18 bold, FontUnderline=.F., WordWrap=.T.,
    *              Alignment=0, BackStyle=0
    *   lblTitulo  Top=17 Left=10 Width=769 Height=46 ForeColor=255,255,255
    *              Tahoma 18 bold, WordWrap=.T., Alignment=0, BackStyle=0
    *
    * O Init legado sobrescreve os dois Caption com ThisForm.Caption
    * ("Operacoes do Caixa : <operacao>"), por isso .Caption = THIS.Caption
    * (dinamico) - o literal do dump ("Cadastro de Testes") eh so o default
    * do Form Designer, nunca chega a ser exibido.
    *
    * Width do container usa THIS.Width (canonico da faixa, regra #11) em
    * vez do literal 800: o SCX declara o CONTAINER mais largo que o
    * proprio form (618), artefato do Form Designer ja catalogado
    * (cabecalho_label_width_dump_maior_que_form) - copiar o literal 769
    * nos labels extrapolaria os 618px visiveis e cortaria o titulo. Os
    * labels usam THIS.Width - 20, mesma margem de 10px dos dois lados
    * aplicada pelos dialogos irmaos (FormSigOpSno.prg).
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
    * Transcricao do dump (SIGOPSQN_form_codigo_fonte.txt):
    *   GradeSubN  Top=110 Left=147 Width=206 Height=221 ColumnCount=2
    *              FontName="Tahoma" FontSize=8 DeleteMark=.F. RowHeight=16
    *              ScrollBars=2 TabIndex=1 GridLineColor=238,238,238
    *   Column1    FontName="Tahoma" FontSize=8 Width=150 Movable=.F.
    *              Resizable=.F.  (ControlSource="" - override VAZIO do Form
    *              Designer, o bind real eh feito no Init: 'crSigMvCxs.
    *              cNivels' -> ver VincularGrade)
    *   Column1.Header1  Alignment=2 Caption="Operacao"
    *   Column1.Text1    BorderStyle=0 Margin=0 ForeColor=0,0,0
    *                    BackColor=255,255,255
    *   Column2    FontName="Tahoma" FontSize=8 Width=25 Movable=.F.
    *              InputMask="9"
    *   Column2.Header1  Alignment=2 Caption="Seq"
    *   Column2.Text1    BorderStyle=0 InputMask="9" Margin=0 MaxLength=1
    *                    ForeColor=0,0,0 BackColor=255,255,255
    *
    * Column2 NAO declara Resizable no dump (so Movable) - mantido o default
    * do VFP, sem inventar a propriedade que o legado nao tem.
    *
    * RecordMark = .F. (o dump so declara DeleteMark): canonico do projeto
    * para grade criada por AddObject em form OPERACIONAL - a barra lateral
    * de marcacao de registro nao faz parte do padrao visual do sistema novo
    * e a linha corrente continua identificada pelo realce do proprio Grid.
    *
    * As DUAS colunas sao editaveis (Column1 recebe o codigo da operacao,
    * Column2 a sequencia 1-8), logo ReadOnly = .F. explicito nas colunas -
    * sempre DEPOIS do Grid, porque o ReadOnly do Grid propaga para elas e
    * sobrescreveria o valor daqui (regra #46). O cursor que as alimenta eh
    * READWRITE (SigOpSqnBO.ListarSequencias) - cursor de SQLEXEC nasce
    * somente-leitura e a celula nunca entraria em edicao.
    *
    * Fase 6: as DUAS colunas instalam TextBox subclasse (Column.AddObject
    * + CurrentControl + Sparse = .F. - regra #18) no lugar do Text1 cru,
    * porque BINDEVENT em evento de celula de Grid nao eh confiavel (regra
    * #46) - os eventos When/Valid/LostFocus moram na classe
    * (TextBoxNivelSqn_4c/TextBoxSeqSqn_4c, em classes\
    * textboxgridlookup.PRG) e delegam para os metodos PUBLIC do form.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade
        THIS.AddObject("grd_4c_Dados", "Grid")

        WITH THIS.grd_4c_Dados
            .Top           = 110
            .Left          = 147
            .Width         = 206
            .Height        = 221
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

        *-- Column1 - cnivels (operacao que compoe a sequencia). Celula com
        *-- lookup (When/Valid/LostFocus) - regra #18/#46
        THIS.grd_4c_Dados.Column1.AddObject("txt_4c_Nivel", "TextBoxNivelSqn_4c")
        WITH THIS.grd_4c_Dados.Column1
            .FontName       = "Tahoma"
            .FontSize       = 8
            .Width          = 150
            .Movable        = .F.
            .Resizable      = .F.
            .CurrentControl = "txt_4c_Nivel"
            .Sparse         = .F.
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
            .txt_4c_Nivel.FontName    = "Tahoma"
            .txt_4c_Nivel.FontSize    = 8
            .txt_4c_Nivel.BorderStyle = 0
            .txt_4c_Nivel.Margin      = 0
            *-- MaxLength pela largura da COLUNA no schema (SigMvCxs.cnivels
            *-- char(20)), NUNCA pelo Width em pixels (regra #19)
            .txt_4c_Nivel.MaxLength   = 20
            .txt_4c_Nivel.ForeColor   = RGB(0, 0, 0)
            .txt_4c_Nivel.BackColor   = RGB(255, 255, 255)
            .txt_4c_Nivel.Visible     = .T.
        ENDWITH

        *-- Column2 - seqs (ordem de execucao, 1 a 8). Celula com validacao
        *-- de faixa (When/Valid) - regra #18/#46
        THIS.grd_4c_Dados.Column2.AddObject("txt_4c_Seq", "TextBoxSeqSqn_4c")
        WITH THIS.grd_4c_Dados.Column2
            .FontName       = "Tahoma"
            .FontSize       = 8
            .Width          = 25
            .Movable        = .F.
            .InputMask      = "9"
            .CurrentControl = "txt_4c_Seq"
            .Sparse         = .F.
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.Caption   = "Seq"
            .txt_4c_Seq.FontName    = "Tahoma"
            .txt_4c_Seq.FontSize    = 8
            .txt_4c_Seq.BorderStyle = 0
            .txt_4c_Seq.InputMask   = "9"
            .txt_4c_Seq.Margin      = 0
            .txt_4c_Seq.MaxLength   = 1
            .txt_4c_Seq.ForeColor   = RGB(0, 0, 0)
            .txt_4c_Seq.BackColor   = RGB(255, 255, 255)
            .txt_4c_Seq.Visible     = .T.
        ENDWITH

        *-- ReadOnly das colunas DEPOIS do Grid (regra #46)
        THIS.grd_4c_Dados.Column1.ReadOnly = .F.
        THIS.grd_4c_Dados.Column2.ReadOnly = .F.
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - shp_4c_Separador (Shape1) + os 3 botoes do legado
    *
    * Transcricao do dump. Os tres botoes sao da classe legado fwbtng
    * (framework.vcx), que define Height=100 / Width=80 / FontBold=.T. /
    * FontItalic=.T. / FontName="Comic Sans MS" / FontSize=8 / WordWrap=.T. /
    * MousePointer=15 / ForeColor=90,90,90 / BackColor=255,255,255 - o SCX
    * sobrepoe apenas Top/Left/Picture/Caption/TabIndex (e Cancel no Sair):
    *   cmdInserir  Top=3 Left=390 Caption="Inserir"  TabIndex=9
    *               Picture=cadastro_inserir_60.jpg
    *   cmdExcluir  Top=3 Left=465 Caption="Excluir"  TabIndex=7
    *               Picture=cadastro_excluir_60.jpg
    *   cmdSair     Top=3 Left=540 Caption="Encerrar" TabIndex=8 Cancel=.T.
    *               Picture=cadastro_sair_60.jpg
    *   Shape1      Top=12 Left=80 Height=110 Width=257 BackStyle=0
    *               BorderStyle=0 BorderColor=136,189,188
    *
    * Os Left vem espacados de 75 com botoes de 80 de largura: a sobreposicao
    * de 5px entre eles eh do PROPRIO legado, nao erro de transcricao - e eh
    * o que faz o calculo do Shape (3 * cmdSair.Width + 16 = 256) coincidir
    * com o Width=257 que o Form Designer gravou.
    *
    * Left/Width do Shape sao RECALCULADOS pelo Init legado em funcao de
    * quais botoes ficaram visiveis - ver AplicarVisibilidadeBotoes. Os
    * valores de projeto (80/257) ficam aqui so por fidelidade ao dump.
    *
    * O Shape eh criado ANTES dos botoes de proposito: a area dele
    * (Left 385..641, Top 12..122, depois do recalculo) cobre os tres botoes,
    * e um controle criado DEPOIS desenha por cima - mesmo transparente
    * (BackStyle=0), ele passaria a interceptar o clique dos botoes.
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
            .Left        = 80
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
            .Left            = 390
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
            .TabIndex        = 9
            .Caption         = "Inserir"
            .Picture         = loc_cIcones + "cadastro_inserir_60.jpg"
            .DisabledPicture = loc_cIcones + "cadastro_inserir_60.jpg"
            .Visible         = .T.
        ENDWITH

        *-- cmdExcluir
        THIS.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH THIS.cmd_4c_Excluir
            .Top             = 3
            .Left            = 465
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
            .TabIndex        = 7
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
            .Left            = 540
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
            .TabIndex        = 8
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
    *   .cmdInserir.Visible = fChecaAcesso('SigOpSqn','INSERIR') And
    *                         Iif( Type('Thisform.PcEscolha') # 'C', .T.,
    *                         InList( Thisform.PcEscolha,'INSERIR','ALTERAR'))
    *   .cmdInserir.Enabled = <a mesma expressao>
    *   .cmdExcluir.Visible = fChecaAcesso('SigOpSqn','EXCLUIR') And <idem>
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
    * igual ao legado. Mesma leitura adotada no dialogo irmao FormSigOpSno.
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
    ENDPROC

    *==========================================================================
    * PossuiAcessoOperacao - fChecaAcesso('SigOpSqn', <acao>) do legado
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
    PROTECTED FUNCTION PossuiAcessoOperacao(par_cOperacao)
        LOCAL loc_lAcesso, loc_oErro
        loc_lAcesso = .F.

        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            RETURN .T.
        ENDIF

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        TRY
            loc_lAcesso = fChecaAcesso("SigOpSqn", par_cOperacao)
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar o acesso " + CHR(224) + " opera" + ;
                CHR(231) + CHR(227) + "o " + ALLTRIM(par_cOperacao) + ":" + CHR(13) + ;
                loc_oErro.Message, "Opera" + CHR(231) + CHR(245) + "es do Caixa")
        ENDTRY

        RETURN loc_lAcesso
    ENDFUNC

    *==========================================================================
    * VincularGrade - liga grd_4c_Dados ao cursor de sequencias, transcrevendo
    * o bloco final do Init legado:
    *
    *   With Thisform.GradeSubN
    *       .RecordSource          = 'crSigMvCxs'
    *       .Column1.ControlSource = 'crSigMvCxs.cNivels'
    *       .Column2.ControlSource = 'crSigMvCxs.Seqs'
    *       .Refresh
    *   EndWith
    *
    * O alias eh o literal cursor_4c_Sequencias (valor de SigOpSqnBO.
    * this_cCursorSequencias) - INTO CURSOR do BO e RecordSource daqui
    * precisam casar, e um nome fixo nos dois lados nao tem como divergir.
    *
    * Width / Header1.Caption / Header1.Alignment / ReadOnly / CurrentControl
    * / Sparse sao REAPLICADOS depois do bind: atribuir RecordSource/
    * ControlSource reseta a largura das colunas para o default 90 e o
    * cabecalho para "Column1"/"Column2" (Problema 48 / regra #41). Por isso
    * este bloco repete os valores de ConfigurarGrade em vez de so
    * configura-los la.
    *==========================================================================
    PROTECTED PROCEDURE VincularGrade
        IF !USED("cursor_4c_Sequencias")
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
        THIS.grd_4c_Dados.RecordSource = "cursor_4c_Sequencias"

        WITH THIS.grd_4c_Dados
            .Column1.ControlSource = "cursor_4c_Sequencias.cnivels"
            .Column2.ControlSource = "cursor_4c_Sequencias.seqs"

            *-- Reaplicar o que o rebind acabou de resetar
            .Column1.Width = 150
            .Column2.Width = 25

            .Column1.Header1.Alignment = 2
            .Column2.Header1.Alignment = 2
            .Column1.Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
            .Column2.Header1.Caption   = "Seq"

            .Column1.CurrentControl = "txt_4c_Nivel"
            .Column2.CurrentControl = "txt_4c_Seq"
            .Column1.Sparse         = .F.
            .Column2.Sparse         = .F.

            .Column1.ReadOnly = .F.
            .Column2.ReadOnly = .F.
        ENDWITH

        RETURN .T.
    ENDPROC

    *==========================================================================
    * CarregarDados - funil UNICO de carga da grade
    *
    * Equivale ao bloco do Init legado que requeria o cursor do pai e religa
    * a grade:
    *
    *   WITH SigCdOpe / With .poDatamgr / .ReQuery('crSigMvCxs')
    *       SELECT crSigMvCxs / GO top
    *   Select crSigMvCxs / Goto Top
    *   With Thisform.GradeSubN ... .Refresh
    *
    * No migrado, quem produz o cursor eh SigOpSqnBO.ListarSequencias (mesma
    * consulta que o form pai registra em AddCursor para crSigMvCxs, filtrada
    * pela operacao-pai), e o Go Top + Refresh vem DEPOIS do bind - popular o
    * cursor NAO repinta a grade sozinho (regra #21).
    *
    * Metodo PUBLIC: eh o funil de carga que o harness de teste automatizado
    * e os Click dos botoes (CmdInserirClick/BtnSairClick) alcancam de fora -
    * PROTECTED faria a chamada externa estourar em runtime (regra #3/#51).
    *
    * Devolve .F. sem estourar quando o BO ainda nao existe ou a consulta
    * falha; a tela continua abrindo (grade vazia), e a falha de SQL ja foi
    * reportada por ListarSequencias.
    *==========================================================================
    PROCEDURE CarregarDados
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        *-- Carga eh o ponto de partida da sessao de edicao: o estado de
        *-- alteracao/inclusao/exclusao (lhouvealt/lhouveins/lhouveexcl do
        *-- legado) volta ao zero junto com os dados
        THIS.this_lHouveAlteracao = .F.
        THIS.this_lHouveInclusao  = .F.
        THIS.this_lHouveExclusao  = .F.

        *-- A lista de linhas novas pertence a MESMA sessao de edicao: recarregar
        *-- descarta as linhas que o Inserir criou e ainda nao foram gravadas
        THIS.this_cCidChavesNovas = ""

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                IF THIS.this_oBusinessObject.ListarSequencias(THIS.this_cOperacaoPai)
                    THIS.VincularGrade()

                    *-- Legado: Select crSigMvCxs / Goto Top
                    IF USED("cursor_4c_Sequencias")
                        SELECT cursor_4c_Sequencias
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
            MsgErro("Erro ao carregar as sequ" + CHR(234) + "ncias da opera" + ;
                CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * GuardarValorAnteriorNivel - When do Column1.Text1 legado:
    *   ThisForm.antvalue = This.Value
    *
    * Chamado pela celula (TextBoxNivelSqn_4c.When, em
    * classes\textboxgridlookup.PRG) ANTES do usuario editar a celula -
    * snapshot usado pelo Valid para saber se o valor mudou.
    *
    * Metodo PUBLIC (regra #3/#46): a celula o alcanca via THISFORM a partir
    * de outra classe - PROTECTED faria a chamada estourar em runtime.
    *==========================================================================
    PROCEDURE GuardarValorAnteriorNivel(par_oTxt)
        THIS.this_cValorAnteriorNivel = par_oTxt.Value
    ENDPROC

    *==========================================================================
    * ValidarNivelGradeExec - Valid do Column1.Text1 legado:
    *
    *   Local lcOperacao, lnRecNo, loBrowse
    *   If This.Value <> ThisForm.Antvalue
    *       If Not Empty(This.Value)
    *           If Not Seek(This.Value, 'TmpOper', 'Dopes')
    *               loBrowse = CreateObject('fwBuscaSel', 'TmpOper', 'Dopes', ;
    *                   This.Value, 'Cadastro de Operacoes')
    *               loBrowse.AddColuna('Dopes', '', 'Operacao', .t., 'Dopes')
    *               loBrowse.Show
    *               This.Value = TmpOper.Dopes
    *           EndIf
    *       EndIf
    *       ThisForm.lhouveAlt = .t.
    *   Endif
    *
    * cursor_4c_Operacoes (TmpOper) eh o universo carregado 1x por
    * SigOpSqnBO.ListarOperacoesCupFis, indexado em dopes (ver o BO) - o
    * SEEK eh a transcricao direta do Seek(This.Value, 'TmpOper', 'Dopes')
    * do legado. Nao achando, abre o picker (AbrirLookupOperacaoSqn), que
    * segue o contrato this_lAchouRegistro/this_lSelecionou do
    * FormBuscaAuxiliar (regra #37).
    *
    * Dentro do Valid o valor digitado esta em par_oTxt.Value (o cursor da
    * grade so recebe DEPOIS) - regra #46.
    *
    * Metodo PUBLIC (regra #3/#46).
    *==========================================================================
    PROCEDURE ValidarNivelGradeExec(par_oTxt)
        LOCAL loc_cValor, loc_lAchou

        loc_cValor = ALLTRIM(NVL(par_oTxt.Value, ""))

        IF loc_cValor != ALLTRIM(NVL(THIS.this_cValorAnteriorNivel, ""))
            IF !EMPTY(loc_cValor)
                loc_lAchou = .F.

                IF USED("cursor_4c_Operacoes")
                    loc_lAchou = SEEK(loc_cValor, "cursor_4c_Operacoes", "dopes")
                ENDIF

                IF !loc_lAchou
                    THIS.AbrirLookupOperacaoSqn(par_oTxt)
                ENDIF
            ENDIF

            THIS.this_lHouveAlteracao = .T.
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * AbrirLookupOperacaoSqn - fwBuscaSel do legado contra TmpOper, migrado
    * para o picker canonico do projeto (FormBuscaAuxiliar), filtrado pelo
    * MESMO universo (CupFis IN (1,3)) ja carregado em cursor_4c_Operacoes.
    *
    * SigCdOpe eh single-column (regra do pipeline): mAddColuna usa so
    * "dopes", igual ao legado (loBrowse.AddColuna('Dopes', '', 'Operacao')).
    *
    * Contrato this_lAchouRegistro/this_lSelecionou (regra #37): o Init do
    * FormBuscaAuxiliar ja tenta o match exato e, achando 1, resolve sozinho
    * sem abrir o Show(). Valor atribuido SO dentro da guarda
    * this_lSelecionou - sem selecao, o campo fica vazio (equivalente ao
    * legado atribuir This.Value = TmpOper.Dopes so apos o Show do browse).
    *
    * Metodo PUBLIC (regra #3/#46).
    *==========================================================================
    PROCEDURE AbrirLookupOperacaoSqn(par_oTxt)
        LOCAL loc_cValor, loc_oBusca

        loc_cValor = ALLTRIM(NVL(par_oTxt.Value, ""))

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdOpe", "cursor_4c_BuscaOperacaoSqn", "dopes", loc_cValor, ;
            "Opera" + CHR(231) + CHR(245) + "es do Caixa", .F., .T., ;
            "cupfis IN (1, 3)")

        IF VARTYPE(loc_oBusca) = "O"
            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
            ENDIF

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOperacaoSqn")
                par_oTxt.Value = ALLTRIM(cursor_4c_BuscaOperacaoSqn.dopes)
            ELSE
                par_oTxt.Value = ""
            ENDIF

            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaOperacaoSqn")
            USE IN cursor_4c_BuscaOperacaoSqn
        ENDIF
    ENDPROC

    *==========================================================================
    * NivelGradeLostFocus - LostFocus do Column1.Text1 legado:
    *   If IsEmpty(This.Value)
    *       Thisform.cmdSair.SetFocus
    *   EndIf
    *
    * Metodo PUBLIC (regra #3/#46).
    *==========================================================================
    PROCEDURE NivelGradeLostFocus(par_oTxt)
        IF EMPTY(NVL(par_oTxt.Value, "")) AND PEMSTATUS(THIS, "cmd_4c_Sair", 5)
            THIS.cmd_4c_Sair.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * GuardarValorAnteriorSeq - When do Column2.Text1 legado:
    *   ThisForm.AntValue2 = This.Value
    *
    * Metodo PUBLIC (regra #3/#46).
    *==========================================================================
    PROCEDURE GuardarValorAnteriorSeq(par_oTxt)
        THIS.this_nValorAnteriorSeq = par_oTxt.Value
    ENDPROC

    *==========================================================================
    * ValidarSeqGradeExec - Valid do Column2.Text1 legado:
    *
    *   If This.Value <> ThisForm.Antvalue2
    *       If Not Between(This.Value,1,8)
    *           MessageBox('Informe Sequencia entre 1 - 8',0+64,'')
    *           Return .f.
    *       EndIf
    *       ThisForm.lhouveAlt = .t.
    *   Endif
    *
    * MESSAGEBOX legado -> MsgAviso (projeto proibe MESSAGEBOX direto).
    * RETURN .F. mantem o foco na celula, igual ao "Return .f." do legado.
    *
    * Metodo PUBLIC (regra #3/#46).
    *==========================================================================
    PROCEDURE ValidarSeqGradeExec(par_oTxt)
        IF par_oTxt.Value != THIS.this_nValorAnteriorSeq
            IF !BETWEEN(par_oTxt.Value, 1, 8)
                MsgAviso("Informe Sequ" + CHR(234) + "ncia entre 1 - 8", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                RETURN .F.
            ENDIF

            THIS.this_lHouveAlteracao = .T.
        ENDIF

        RETURN .T.
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
    * As celulas da grade (Column1/Column2) NAO entram aqui: os eventos
    * When/Valid/LostFocus delas moram na classe do TextBox instalado em
    * ConfigurarGrade (TextBoxNivelSqn_4c/TextBoxSeqSqn_4c), porque
    * BINDEVENT em evento de celula de Grid nao eh confiavel (regra #46).
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
    *   Select crSigMvCxs
    *   Locate for cDopes = crSigCdOpe.Dopes .and. cnivels = Space(20)
    *   If Eof()
    *       Insert Into crSigMvCxs (cDopes, CidChaves) ;
    *           Values (crSigCdOpe.Dopes, fUniqueIds())
    *   EndIf
    *   Select crSigMvCxs
    *   Thisform.GradeSubN.Column1.SetFocus
    *
    * O LOCATE eh um GUARD contra linha em branco repetida: se a linha vazia
    * da ultima vez ainda nao foi preenchida, o legado reaproveita ela em vez
    * de criar outra (e o LOCATE deixa o ponteiro nela, que eh onde o foco
    * vai parar).
    *
    * Grava SO no cursor LOCAL - igual ao legado, que trabalha sobre a view
    * bufferizada do pai e so persiste no Encerrar (poDataMgr.UpDate +
    * Commit -> PersistirSequencias). A PK vai ja preenchida com fUniqueIds()
    * (regra #22: cidchaves NUNCA em branco, senao a 2a linha colide no
    * indice unico) e entra em this_cCidChavesNovas, que eh como o funil de
    * gravacao sabe que a linha eh INSERT e nao UPDATE.
    *
    * O "Select crSigMvCxs" final do legado nao precisa ser reproduzido como
    * efeito colateral: a grade exibe pelo RecordSource, e este form roda na
    * DataSession do PAI (DataSession = 1), onde deixar outro alias
    * selecionado atrapalharia quem chamou - por isso o alias anterior eh
    * restaurado.
    *
    * Column1.SetFocus() eh o que o legado chama, e Column TEM esse metodo
    * (medido no VFP9 em 2026-11-17: PEMSTATUS(Column1, "SetFocus", 5) =
    * .T.). NAO usar Grid.ActiveColumn = 1 no lugar: medido na mesma sessao,
    * ActiveColumn eh READ-ONLY em runtime ("Property ACTIVECOLUMN is
    * read-only") e derrubaria o handler.
    *==========================================================================
    PROCEDURE CmdInserirClick
        LOCAL loc_cAliasAnterior, loc_cCidChaves, loc_oErro

        TRY
            IF USED("cursor_4c_Sequencias")
                *-- Legado: Thisform.lHouveIns = .T.
                THIS.this_lHouveInclusao = .T.

                loc_cAliasAnterior = ALIAS()
                SELECT cursor_4c_Sequencias

                LOCATE FOR ALLTRIM(cdopes) == ALLTRIM(THIS.this_cOperacaoPai) ;
                    AND EMPTY(cnivels)

                IF !FOUND()
                    loc_cCidChaves = ALLTRIM(fUniqueIds())

                    INSERT INTO cursor_4c_Sequencias (cdopes, cidchaves) ;
                        VALUES (THIS.this_cOperacaoPai, loc_cCidChaves)

                    THIS.this_cCidChavesNovas = THIS.this_cCidChavesNovas + ;
                        "|" + loc_cCidChaves
                ENDIF

                IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
                    SELECT (loc_cAliasAnterior)
                ENDIF

                IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                    THIS.grd_4c_Dados.Refresh()
                    THIS.grd_4c_Dados.Column1.SetFocus()
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
    *   Select crSigMvCxs
    *   If Not Eof() And ( crSigMvCxs.cDopes = crSigCdOpe.Dopes )
    *       Thisform.lHouveExcl = .T.
    *       Delete
    *       Skip
    *       Skip - 1
    *   Endif
    *   Thisform.GradeSubN.Refresh
    *
    * O par "Skip / Skip -1" do legado eh o que reposiciona o ponteiro numa
    * linha VIVA depois da marcacao (com SET DELETED ON - fixado pelo
    * config.prg - a linha marcada desaparece da grade de imediato).
    *
    * So MARCA a linha no cursor LOCAL: o DELETE no SQL Server acontece no
    * Encerrar (PersistirSequencias) e SO para linha que ja existia no banco
    * - linha nova excluida antes de gravar simplesmente desaparece, sem SQL
    * nenhum.
    *==========================================================================
    PROCEDURE CmdExcluirClick
        LOCAL loc_cAliasAnterior, loc_oErro

        TRY
            IF USED("cursor_4c_Sequencias")
                loc_cAliasAnterior = ALIAS()
                SELECT cursor_4c_Sequencias

                IF !EOF() AND ALLTRIM(cdopes) == ALLTRIM(THIS.this_cOperacaoPai)
                    *-- Legado: Thisform.lHouveExcl = .T.
                    THIS.this_lHouveExclusao = .T.
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
    *       If ( Thisform.lHouveExcl Or Thisform.lHouveIns Or ThisForm.lHouveAlt )
    *           Select CrSigMvCxs / Go Top / Go bottom
    *           <validacao 1: cNivels duplicada>  -> MessageBox + Return .f.
    *           <validacao 2: cNivels sem Seqs>   -> MessageBox + Return .f.
    *           <UpDate('crSigMvCxs') + Commit(), com RollBack e MessageBox
    *            'Erro na Gravacao dos Dados do Cadastro de Operacoes.'>
    *       Endif
    *   ENDIF
    *   Thisform.ParentForm.Enabled = .T.
    *   Thisform.mCtrlBotoes(.T.)
    *   ThisForm.Release
    *
    * FLUXO DE SAIDA - transcrito, nao "melhorado": SO as duas validacoes
    * abortam o fechamento (o "Return .f." do legado); a FALHA DE GRAVACAO
    * exibe a mensagem e FECHA do mesmo jeito, porque no legado o RollBack ja
    * desfez tudo. Manter o dialogo aberto nesse caso convidaria a um segundo
    * Encerrar, que tentaria reinserir linha ja gravada (cidchaves eh PK) -
    * ver tambem o acerto de this_cCidChavesNovas em PersistirSequencias.
    *
    * Modo so-leitura (Inserir e Excluir ambos invisiveis - pai em PROCURAR
    * ou usuario sem acesso): o legado NAO valida e NAO grava nada, so fecha.
    *
    * "Go Top / Go bottom" do legado forcava a view remota bufferizada a
    * buscar TODAS as linhas antes do TableUpdate; no cursor local nao muda
    * nada, mas fica transcrito (so reposiciona o ponteiro).
    *
    * "ParentForm.Enabled = .T." roda no Destroy() deste form (chamado pelo
    * Release()). "mCtrlBotoes(.T.)" do legado reabilita BOTOES especificos
    * do pai porque la o pai ficava com os controles desabilitados um a um -
    * aqui o InicializarForm desabilita o FORM PAI INTEIRO, entao reabilitar
    * o form basta e nao ha metodo equivalente a chamar.
    *
    * Metodo PUBLIC (regra #3): alcancado por BINDEVENT e pelo harness.
    *==========================================================================
    PROCEDURE BtnSairClick
        LOCAL loc_lPodeFechar, loc_oErro

        loc_lPodeFechar = .T.

        TRY
            IF THIS.cmd_4c_Inserir.Visible OR THIS.cmd_4c_Excluir.Visible
                IF THIS.this_lHouveExclusao OR THIS.this_lHouveInclusao OR ;
                   THIS.this_lHouveAlteracao

                    *-- Legado: Select CrSigMvCxs / Go Top / Go bottom
                    IF USED("cursor_4c_Sequencias")
                        SELECT cursor_4c_Sequencias
                        GO TOP
                        GO BOTTOM
                    ENDIF

                    DO CASE
                    CASE THIS.ExisteOperacaoDuplicada()
                        MsgAviso("Existem Opera" + CHR(231) + CHR(245) + ;
                            "es Duplicadas!!!", ;
                            "Opera" + CHR(231) + CHR(245) + "es do Caixa")
                        loc_lPodeFechar = .F.

                    CASE THIS.ExisteSequenciaNaoInformada()
                        MsgAviso("Existem Opera" + CHR(231) + CHR(245) + ;
                            "es sem Sequ" + CHR(234) + "ncia informada!!!", ;
                            "Opera" + CHR(231) + CHR(245) + "es do Caixa")
                        loc_lPodeFechar = .F.

                    OTHERWISE
                        IF !THIS.PersistirSequencias()
                            MsgErro("Erro na grava" + CHR(231) + CHR(227) + ;
                                "o dos Dados do Cadastro de Opera" + ;
                                CHR(231) + CHR(245) + "es.", ;
                                "Opera" + CHR(231) + CHR(245) + "es do Caixa")
                        ENDIF
                    ENDCASE
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
    * ExisteOperacaoDuplicada - 1a validacao do cmdSair.Click legado:
    *
    *   Select cNivels,sum(1) From CrSigMvCxs Into Cursor Selecao ;
    *       Group by cNivels having sum(1) > 1
    *   Select Selecao
    *   If Reccount() > 0 ... 'Existem Operacoes Duplicadas!!!'
    *
    * Transcricao LITERAL (regra #17): o legado NAO exclui a linha em branco
    * do agrupamento, logo DUAS linhas novas sem operacao informada tambem
    * contam como duplicadas - esse eh o comportamento da tela e nao se
    * "conserta" aqui.
    *
    * A linha marcada para exclusao NAO entra: SET DELETED ON (config.prg)
    * esconde do SELECT, igual ao legado.
    *
    * _TALLY no lugar do RECCOUNT() do legado: RECCOUNT conta tambem registro
    * marcado como excluido, e _TALLY eh o numero de linhas que o SELECT
    * acabou de produzir.
    *
    * Os RETURN de guarda ficam FORA de TRY/CATCH (regra #1).
    *==========================================================================
    PROTECTED FUNCTION ExisteOperacaoDuplicada
        LOCAL loc_cAliasAnterior, loc_nQuantas

        IF !USED("cursor_4c_Sequencias")
            RETURN .F.
        ENDIF

        loc_cAliasAnterior = ALIAS()

        IF USED("cursor_4c_SelecaoSqn")
            USE IN cursor_4c_SelecaoSqn
        ENDIF

        SELECT cnivels, SUM(1) AS nquantas ;
            FROM cursor_4c_Sequencias ;
            GROUP BY cnivels ;
            HAVING SUM(1) > 1 ;
            INTO CURSOR cursor_4c_SelecaoSqn READWRITE

        loc_nQuantas = _TALLY

        IF USED("cursor_4c_SelecaoSqn")
            USE IN cursor_4c_SelecaoSqn
        ENDIF

        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF

        RETURN (loc_nQuantas > 0)
    ENDFUNC

    *==========================================================================
    * ExisteSequenciaNaoInformada - 2a validacao do cmdSair.Click legado:
    *
    *   Select [ ] as Agrupar,Sum(1) From CrSigMvCxs Into Cursor Selecao ;
    *       where Not Empty(cNivels) And Seqs = 0 group by 1
    *   Select Selecao
    *   If Reccount() > 0 ... 'Existem Operacoes sem Sequencia informada!!!'
    *
    * O criterio que CERCA a validacao eh parte dela (regra #21b): o legado
    * so reclama de linha COM operacao informada e sequencia zerada - linha
    * totalmente em branco nao entra aqui (ela cai na validacao de
    * duplicidade quando houver mais de uma).
    *
    * Os RETURN de guarda ficam FORA de TRY/CATCH (regra #1).
    *==========================================================================
    PROTECTED FUNCTION ExisteSequenciaNaoInformada
        LOCAL loc_cAliasAnterior, loc_nQuantas

        IF !USED("cursor_4c_Sequencias")
            RETURN .F.
        ENDIF

        loc_cAliasAnterior = ALIAS()

        IF USED("cursor_4c_SelecaoSqn")
            USE IN cursor_4c_SelecaoSqn
        ENDIF

        SELECT " " AS agrupar, SUM(1) AS nquantas ;
            FROM cursor_4c_Sequencias ;
            WHERE !EMPTY(cnivels) AND seqs = 0 ;
            GROUP BY 1 ;
            INTO CURSOR cursor_4c_SelecaoSqn READWRITE

        loc_nQuantas = _TALLY

        IF USED("cursor_4c_SelecaoSqn")
            USE IN cursor_4c_SelecaoSqn
        ENDIF

        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF

        RETURN (loc_nQuantas > 0)
    ENDFUNC

    *==========================================================================
    * PersistirSequencias - grava no SQL Server o que a sessao mudou em
    * cursor_4c_Sequencias (SigMvCxs). Equivale ao bloco de gravacao do
    * cmdSair.Click legado:
    *
    *   m.lnErro1 = SigCdOpe.poDatamgr.pnIdConn
    *   If m.lnErro1>0 : m.lnErro1 = Iif(.poDataMgr.UpDate('crSigMvCxs'),1,-1)
    *   If m.lnErro1>0 : m.lnErro1 = .poDataMgr.Commit()
    *   If Not m.lnErro1>0 : .poDataMgr.RollBack()
    *
    * Sem a view bufferizada do Framework nao ha TableUpdate em bloco: a
    * persistencia eh linha-a-linha via o BO (Salvar/Excluir, que sao os
    * metodos PUBLIC - Inserir/Atualizar/ExecutarExclusao sao PROTECTED e
    * NUNCA se chamam de fora, regra #51). Exclusoes primeiro, depois
    * inclusoes/atualizacoes - a mesma ordem do TableUpdate.
    *
    * Linha marcada para exclusao que NUNCA foi gravada (esta em
    * this_cCidChavesNovas) nao vira DELETE: no banco ela nao existe.
    * Para alcancar as linhas marcadas eh preciso suspender o SET DELETED ON
    * do config.prg - com ele ligado, o SCAN pula a linha excluida ANTES de
    * avaliar o FOR.
    *
    * Transcricao fiel (regra #17): o Encerrar legado NAO descarta linha com
    * cnivels em branco antes de gravar (quem faz isso, para OUTRA tabela, eh
    * o dialogo irmao SIGOPSNO) - uma unica linha em branco passa as duas
    * validacoes e eh gravada, igual ao TableUpdate do legado.
    *
    * Os RETURN de guarda ficam FORA de TRY/CATCH (regra #1).
    *==========================================================================
    PROTECTED FUNCTION PersistirSequencias
        LOCAL loc_cAliasAnterior, loc_lSucesso, loc_cCidChaves, loc_lNovo, ;
              loc_cDeletedStatus

        loc_lSucesso = .T.

        IF !USED("cursor_4c_Sequencias")
            RETURN .T.
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        loc_cAliasAnterior = ALIAS()
        SELECT cursor_4c_Sequencias

        *-- Exclusoes das linhas que JA existiam no banco
        loc_cDeletedStatus = SET("DELETED")
        SET DELETED OFF
        SCAN FOR DELETED()
            loc_cCidChaves = ALLTRIM(NVL(cursor_4c_Sequencias.cidchaves, ""))

            IF !EMPTY(loc_cCidChaves) AND ;
               !("|" + loc_cCidChaves + "|" $ ("|" + THIS.this_cCidChavesNovas + "|"))
                *-- Excluir() recusa registro marcado como novo; a linha
                *-- existe no banco, logo this_lNovoRegistro = .F.
                THIS.this_oBusinessObject.this_lNovoRegistro = .F.

                *-- Fase 8: a linha corrente vai para o BO num lugar SO
                THIS.FormParaBO()

                IF !THIS.this_oBusinessObject.Excluir()
                    loc_lSucesso = .F.
                ENDIF
            ENDIF
        ENDSCAN
        SET DELETED &loc_cDeletedStatus

        *-- Inclusoes / atualizacoes das linhas vivas
        SCAN FOR !DELETED()
            loc_cCidChaves = ALLTRIM(NVL(cursor_4c_Sequencias.cidchaves, ""))
            loc_lNovo      = ("|" + loc_cCidChaves + "|" $ ;
                              ("|" + THIS.this_cCidChavesNovas + "|"))

            *-- Modo ANTES das properties: NovoRegistro() passa por
            *-- LimparDados(), e EditarRegistro() recusa enquanto
            *-- this_lNovoRegistro estiver ligado de uma linha anterior
            IF loc_lNovo
                THIS.this_oBusinessObject.NovoRegistro()
            ELSE
                THIS.this_oBusinessObject.this_lNovoRegistro = .F.
                THIS.this_oBusinessObject.EditarRegistro()
            ENDIF

            *-- Fase 8: a linha corrente vai para o BO num lugar SO
            THIS.FormParaBO()

            IF THIS.this_oBusinessObject.Salvar()
                *-- Fase 8: devolve para a linha a chave efetivamente
                *-- gravada - Inserir() gera a PK quando ela chega vazia
                THIS.BOParaForm()

                *-- A linha passou a existir no banco: sai da lista de novas,
                *-- para um segundo Encerrar nao tentar INSERT de novo
                *-- (cidchaves eh PK)
                IF loc_lNovo
                    THIS.this_cCidChavesNovas = STRTRAN(THIS.this_cCidChavesNovas, ;
                        "|" + loc_cCidChaves, "")
                ENDIF
            ELSE
                loc_lSucesso = .F.
            ENDIF
        ENDSCAN

        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * FormParaBO - transporte LINHA DA GRADE -> BO (Fase 8)
    *
    * A "ficha" desta tela eh a LINHA da grade: as duas celulas editaveis
    * (cnivels/seqs) mais as duas colunas que o usuario nao ve (cdopes, que
    * eh a operacao-pai, e cidchaves, a PK). Este metodo copia a linha
    * CORRENTE de cursor_4c_Sequencias para as properties do BO - eh o
    * equivalente, aqui, do FormParaBO de um form CRUD, que leva os
    * TextBoxes da pagina Dados para o BO.
    *
    * Nasceu de codigo que JA existia INLINE em PersistirSequencias, repetido
    * nos dois lacos (exclusoes e inclusoes/atualizacoes). Nao eh hook
    * decorativo: sem ele, nada chega ao BO e nada eh gravado.
    *
    * NVL em toda leitura: coluna de cursor pode chegar nula dependendo do
    * driver, e comparar/concatenar nulo estoura (regra #13).
    *
    * Chamado SEMPRE depois de NovoRegistro()/EditarRegistro(), porque
    * NovoRegistro() passa por LimparDados() e zeraria o que fosse atribuido
    * antes.
    *
    * PROTECTED PROCEDURE explicito: eh hook de FormBase e nao se chama de
    * fora deste form.
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
           USED("cursor_4c_Sequencias") AND !EOF("cursor_4c_Sequencias")

            WITH THIS.this_oBusinessObject
                .this_cCidChaves = ALLTRIM(NVL(cursor_4c_Sequencias.cidchaves, ""))
                .this_cCDopes    = ALLTRIM(NVL(cursor_4c_Sequencias.cdopes, ""))
                .this_cCNivels   = ALLTRIM(NVL(cursor_4c_Sequencias.cnivels, ""))
                .this_nSeqs      = NVL(cursor_4c_Sequencias.seqs, 0)
            ENDWITH

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BOParaForm - transporte BO -> LINHA DA GRADE (Fase 8), o inverso do
    * FormParaBO acima.
    *
    * Tem UM trabalho real: devolver para a linha a chave que FOI DE FATO
    * gravada. SigOpSqnBO.Inserir() gera a PK quando ela chega vazia
    * ("IF EMPTY(this_cCidChaves) / this_cCidChaves = fUniqueIds()", regra
    * #22), e nesse caso a linha do cursor continuaria com a chave antiga: um
    * segundo Encerrar mandaria UPDATE/DELETE para um cidchaves que nao
    * existe no banco, em silencio. Sincronizar aqui fecha esse buraco.
    *
    * As outras tres colunas NAO sao reescritas de proposito: elas acabaram
    * de sair da propria linha (FormParaBO) e o BO nao as transforma -
    * reescrever criaria um segundo dono para o que o usuario digitou.
    *
    * Repinta a grade no fim: alterar o cursor NAO repinta sozinho (regra
    * #21a).
    *
    * PROTECTED PROCEDURE explicito: hook de FormBase, nao se chama de fora.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm
        LOCAL loc_cCidChavesBO, loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
           USED("cursor_4c_Sequencias") AND !EOF("cursor_4c_Sequencias")

            loc_cCidChavesBO = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cCidChaves, ""))

            IF !EMPTY(loc_cCidChavesBO) AND ;
               loc_cCidChavesBO != ALLTRIM(NVL(cursor_4c_Sequencias.cidchaves, ""))
                REPLACE cidchaves WITH loc_cCidChavesBO IN cursor_4c_Sequencias
            ENDIF

            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                THIS.grd_4c_Dados.Refresh()
            ENDIF

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - AddObject cria controle com Visible = .F.;
    * percorre recursivamente containers/grids/pageframes tornando tudo
    * visivel. Sem containers flutuantes nesta tela (nenhum painel toggled
    * por botao), entao nao ha nome algum a filtrar/excluir.
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
    * cmdSair.Click faz .ParentForm.Enabled = .t. antes do ThisForm.Release;
    * aqui tambem fica como rede de seguranca para qualquer caminho de
    * fechamento que nao passe pelo botao Encerrar - ESC/fechamento externo)
    *==========================================================================
    PROCEDURE Destroy
        IF VARTYPE(THIS.this_oFormPai) = "O"
            THIS.this_oFormPai.Enabled = .T.
            THIS.this_oFormPai         = .NULL.
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
