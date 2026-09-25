*==============================================================================
* FormSigMvExp.prg
* Form: Despachante de Movimentacao (Entrada / Conferencia-Caixa / Alteracao)
* Origem: SIGMVEXP.SCX
* Herda de: FormBase
* Tipo: OPERACIONAL - form puramente despachante. O SIGMVEXP.SCX original
* e' um form de 337x147, TitleBar=0, ControlBox=.F., Movable=.F.,
* AlwaysOnBottom=.T., com um UNICO CommandButton (Processo, caption
* "Aguarde Processando Dados"). Nao ha PageFrame Lista/Dados, Grid nem
* campos de dados - por isso este form nao segue o padrao CRUD.
*
* Chamado com parametros (Init do SCX original):
*   Lparameters pDopes, pTipos, pNumes, pEmps, pConsulta, pCaixa, pMacro
* Traduzido para:
*   CREATEOBJECT("FormSigMvExp", par_cDopes, par_cTipos, par_nNumes, ;
*       par_cEmps, par_lConsulta, par_nCaixa, par_lMacro)
*
* FASE 3/8 - Estrutura base completa. Este form nao tem grid, campos de
* dados nem PageFrame Lista/Dados para distribuir nas fases seguintes (4 a
* 6): toda a "tela" e' o botao Processo, e toda a "logica de negocio" e' o
* despacho por Tipo, que no legado mora no PROCEDURE Init/Activate/Click do
* PROPRIO form (nao em metodos de grade ou campo). A Fase 2 (BO) ja
* documentou essa decisao em fase_2_output.txt: "A logica real de despacho
* (DO CASE por Tipo + DO FORM SigMvCab) fica para a Fase 3 (Form), que e'
* onde ela vive no legado." Por isso a estrutura entregue aqui ja inclui o
* botao e o despacho completo - as Fases 4 a 8 nao terao grid, campos ou
* eventos adicionais para acrescentar.
*
* DEPENDENCIA FUTURA: FormSigMvCab (equivalente migrado de SIGMVCAB.SCX)
* ainda NAO existe neste acervo (fora do escopo desta task). O despacho
* abaixo documenta o CONTRATO posicional que FormSigMvCab.Init() precisa
* implementar quando for migrado - EXATAMENTE os argumentos que o legado
* passava em "Do Form SigMvCab With ...", traduzidos de DO FORM (SCX) para
* CREATEOBJECT+Show() (arquitetura nova, PILAR 3 - sem SCX/DO FORM).
*
* CONSOLIDACAO (Fase 8) - DISPOSICAO DOS 5 METODOS DO SCX LEGADO
* --------------------------------------------------------------
* O dump (SigMvExp_form_codigo_fonte.txt, "Total de metodos/eventos com
* codigo: 5") tem Release, Load, Init, Activate e Processo.Click. Tres viraram
* codigo aqui; os outros DOIS sao nao-ports deliberados, registrados abaixo
* para que a ausencia seja auditavel em vez de parecer esquecimento:
*
*   Legado                   Migrado
*   -----------------------  -------------------------------------------------
*   Init                     PROCEDURE Init (mesmos 7 parametros posicionais)
*   Activate                 PROCEDURE Activate
*   Processo.Click           PROCEDURE BtnProcessoClick (via BINDEVENT)
*   Load  (=fConfigGeral())  NAO PORTADO - ver (a)
*   Release (poDataMgr6)     NAO PORTADO - ver (b)
*
* (a) Load: "=fConfigGeral()". fConfigGeral era funcao GLOBAL da aplicacao
*     legado (sig.prg / SIGFUNCS.PRG) que NAO veio no acervo. O que existe em
*     projeto\app\utils\fconfiggeral.prg e' um wrapper NO-OP (RETURN .T.) cujo
*     proprio cabecalho diz: "em codigo NOSSO nunca se chama fConfigGeral -
*     este arquivo existe APENAS para binario legado", porque o p-code dos VCX
*     o invoca e nao da para editar. Chama-lo daqui seria escrever uma chamada
*     que comprovadamente nao faz nada e ainda sugerir que falta alguma
*     inicializacao global. O que fConfigGeral fazia esta distribuido e ocorre
*     ANTES deste form abrir: config.prg (SETs, paths, aliases globais),
*     main.prg (conexao, CarregarEmpresa) e cada BO (seus proprios cursores).
*     Este form nao le cursor nenhum - so despacha - entao nao depende de nada
*     que fConfigGeral pudesse ter criado.
*
* (b) Release: "ThisForm.poDataMgr6.Release". poDataMgr6 era o fSqlConector
*     PRIVADO deste form, criado no Init legado ("CreateObject('fSqlConector',
*     'SigMvExp')"); o Release existia so para devolver essa conexao. A
*     arquitetura nova nao tem conexao por form: usa o handle GLOBAL
*     gnConnHandle, que NAO pode ser liberado ao fechar uma tela (derrubaria a
*     conexao do sistema inteiro). Sobra o "=DoDefault()" do legado, que aqui
*     ja acontece por HERANCA - sem override, FormBase.Destroy roda inteiro e
*     faz a limpeza canonica (this_oBusinessObject = .NULL. + rebuild do menu).
*     Declarar "PROCEDURE Destroy / DODEFAULT() / ENDPROC" so para constar
*     seria metodo sem logica propria (proibido pela regra de completude) e
*     ainda abriria caminho para a regressao do Pattern #145 se alguem depois
*     editasse esse override e esquecesse o DODEFAULT() dentro dele.
*==============================================================================

DEFINE CLASS FormSigMvExp AS FormBase

    *-- Dimensoes e comportamento EXATOS do original (SIGMVEXP.SCX)
    Caption        = ""
    Width          = 337
    Height         = 147
    AutoCenter     = .T.
    BorderStyle    = 2
    ShowWindow = 1
    WindowType = 1
    ControlBox     = .F.
    Movable        = .F.
    TitleBar       = 0
    AlwaysOnBottom = .T.
    Themes         = .F.

    *-- Marca que o despacho AUTOMATICO (o disparado pelo Activate) ja
    *-- aconteceu. Ver a nota de re-entrancia no PROCEDURE Activate: sem esta
    *-- trava o Activate redispara em loop infinito quando a tela de destino
    *-- fecha. Nao trava o clique MANUAL no botao, que segue igual ao legado.
    this_lDespachouAuto = .F.

    *==========================================================================
    * Init - Recebe os parametros de despacho (equivalente ao Lparameters
    * pDopes, pTipos, pNumes, pEmps, pConsulta, pCaixa, pMacro do legado) e
    * grava-os diretamente no Business Object (fonte unica - o Form nao
    * duplica propriedades que ja moram no BO, igual ao padrao de
    * FormSIGMVCMV/FormSigReEch). par_lConsulta espelha o pConsulta legado,
    * que tambem nao e' referenciado em nenhum metodo do SIGMVEXP original -
    * mantido apenas para compatibilidade posicional de quem chamar este form.
    *==========================================================================
    PROCEDURE Init(par_cDopes, par_cTipos, par_nNumes, par_cEmps, ;
                    par_lConsulta, par_nCaixa, par_lMacro)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigMvExpBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar SigMvExpBO." + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
            ELSE
                WITH THIS.this_oBusinessObject
                    .this_lErro      = .F.
                    .this_nCaixa     = IIF(VARTYPE(par_nCaixa) = "N", par_nCaixa, 0)
                    .this_cGrupoOper = ""
                    .this_lMacro     = IIF(VARTYPE(par_lMacro) = "L", par_lMacro, .F.)

                    *-- fRetDopMenu (funcao global Fortyus, NAO portada - nao
                    *-- consta em Framework\ nem em nenhum .prg do acervo)
                    *-- redirecionava o Dope conforme configuracao de menu no
                    *-- legado: "lcMnu = fRetDopMenu([], pDopes, poDataMgr6) /
                    *-- If Not Empty(lcMnu) / pDope = Alltrim(lcMnu) / Else /
                    *-- pDope = pDopes / EndIf". E' logica de ROTEAMENTO, nao
                    *-- calculo trivial - regra #27 CLAUDE.md manda NAO
                    *-- inventar sem o fonte (um palpite errado desviaria o
                    *-- usuario para a operacao errada). Decisao da Fase 2
                    *-- (fase_2_output.txt): mantido o ramo ELSE do legado -
                    *-- usa o Dope recebido sem redirecionamento.
                    .this_cDope = IIF(VARTYPE(par_cDopes) = "C", ALLTRIM(par_cDopes), "")

                    *-- Espelha "If (InList(pTipos,'C','A')) / pNume = pNumes /
                    *-- pEmp = pEmps / EndIf" - em Tipo 'E' esses dois campos
                    *-- permanecem no default (0/"").
                    *--
                    *-- O VARTYPE antes do INLIST nao e' decoracao: medido no
                    *-- VFP9 (2026-09-24), INLIST(<arg ausente>, "C", "A")
                    *-- estoura "Operator/operand type mismatch" (parametro nao
                    *-- passado chega como LOGICO .F.), e com objeto tambem.
                    *-- O erro cai no CATCH deste Init -> Init devolve .F. ->
                    *-- CREATEOBJECT devolve .F. -> a TELA NAO ABRE. E' caminho
                    *-- alcancavel de verdade: FormSigPrHpr.prg:936 chama
                    *-- CREATEOBJECT("FormSigMvExp", THIS) com UM argumento so
                    *-- (e objeto), deixando par_cTipos ausente.
                    *-- Medido tambem que o VFP9 FAZ short-circuit no AND, ou
                    *-- seja o INLIST nao e' avaliado quando o VARTYPE falha
                    *-- (ao contrario do OR, que nao faz - regra #27).
                    IF VARTYPE(par_cTipos) = "C" AND INLIST(par_cTipos, "C", "A")
                        .this_nNume = IIF(VARTYPE(par_nNumes) = "N", par_nNumes, 0)
                        .this_cEmp  = IIF(VARTYPE(par_cEmps) = "C", par_cEmps, "")
                    ENDIF

                    .this_cTipo = IIF(VARTYPE(par_cTipos) = "C", par_cTipos, "")
                ENDWITH

                loc_lSucesso = DODEFAULT()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar FormSigMvExp:" + CHR(13) + ;
                    "Erro: " + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarForm - monta o unico controle visual do form (cmd_4c_Processo)
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            THIS.ConfigurarPageFrame()
            THIS.TornarControlesVisiveis()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - orquestrador de layout base.
    * O SIGMVEXP.SCX legado eh FLAT (nao possui PageFrame nativo): a arvore de
    * objetos do fonte extraido tem exatamente Dataenvironment + SIGMVEXP +
    * SIGMVEXP.Processo. Criar um PageFrame Lista/Dados aqui inventaria um
    * controle que o legado nao tem (viola o PILAR 1) e ainda cobriria o unico
    * botao da tela. Seguindo a convencao ja adotada nos forms OPERACIONAIS
    * flat do projeto (ver FormVca.prg, migrado de SIGALTDT), o metodo mantem
    * o nome canonico de orquestrador de layout base e delega para os metodos
    * que montam os controles que o legado REALMENTE tem.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarBotaoProcesso()
    ENDPROC

    *==========================================================================
    * ConfigurarBotaoProcesso - unico controle do original (Processo),
    * mostrando "Aguarde Processando Dados" enquanto a tela despacha para
    * SigMvCab (acionado automaticamente em Activate, igual ao legado).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotaoProcesso()
        THIS.AddObject("cmd_4c_Processo", "CommandButton")
        WITH THIS.cmd_4c_Processo
            .Top       = 34
            .Left      = 48
            .Height    = 73
            .Width     = 241
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 10
            .Caption   = "Aguarde Processando Dados"
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Processo, "Click", THIS, "BtnProcessoClick")
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - torna visivel o controle criado via AddObject
    * (nasce Visible=.F. por padrao)
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis()
        IF PEMSTATUS(THIS, "cmd_4c_Processo", 5)
            THIS.cmd_4c_Processo.Visible = .T.
        ENDIF
    ENDPROC

    *==========================================================================
    * Activate - dispara o despacho automaticamente, espelhando o legado
    * ("If Not ThisForm.Erro / ThisForm.Processo.Click / EndIf"). O guard de
    * modo teste/validacao evita que a instanciacao automatizada deste form
    * (ValidarUIFidelity/TesteAutomatico) acione CREATEOBJECT("FormSigMvCab",
    * ...) antes desse form existir no acervo (ver nota de dependencia no
    * cabecalho do arquivo).
    *
    * RE-ENTRANCIA - por que existe this_lDespachouAuto
    * -------------------------------------------------
    * Activate NAO e' evento de "abriu a tela": ele dispara a CADA vez que o
    * form ganha foco. Como o despacho abre a tela de destino e o Activate
    * volta a disparar quando ela FECHA, o par Activate->despacho se realimenta.
    * Medido no VFP9 em 2026-09-24 (harness com pai + filho modal que se fecha,
    * _f7_medir_activate.prg): o Activate do pai disparou de novo a cada
    * fechamento do filho e redespachou sem parar - o teste teve de CORTAR
    * artificialmente no 3o para terminar. Sem a trava, o usuario fecha a
    * movimentacao e ela reabre, para sempre, sem saida (este form tem
    * ControlBox = .F. e TitleBar = 0 - nao tem como fechar).
    *
    * No legado isso nao acontece porque quem encerra este splash e' o proprio
    * SigMvCab, que recebe ThisForm como parametro exatamente para isso (padrao
    * Fortyus de "aguarde" liberado pela tela pesada quando ela termina de
    * carregar). O migrado continua passando THIS nas tres chamadas, mantendo
    * esse contrato - mas a trava nao depende dele para evitar o loop.
    *
    * A trava cobre so o caminho AUTOMATICO. O clique MANUAL no botao segue
    * despachando quantas vezes o usuario clicar, como no legado. A flag e'
    * marcada ANTES de despachar porque o Show() da tela de destino BLOQUEIA:
    * marcar depois deixaria a janela aberta para o Activate reentrar durante
    * o bloqueio, que e' justamente o caso medido.
    *==========================================================================
    PROCEDURE Activate()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            IF !THIS.this_oBusinessObject.this_lErro AND !THIS.this_lDespachouAuto
                THIS.this_lDespachouAuto = .T.
                THIS.BtnProcessoClick()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnProcessoClick - PUBLIC (BINDEVENT - regra #3 CLAUDE.md). Espelha
    * SIGMVEXP.Processo.Click: despacha para SigMvCab conforme o Tipo
    * (E=Entrada, C=Conferencia/Caixa, A=Alteracao), so quando SigMvCab ainda
    * nao estiver aberto.
    *
    * DO FORM SigMvCab (SCX legado) -> CREATEOBJECT("FormSigMvCab", ...) +
    * Show() (arquitetura nova nao usa SCX/DO FORM - PILAR 3). Os argumentos
    * posicionais abaixo sao EXATAMENTE os do "Do Form SigMvCab With ..."
    * original (Procedure Click, linhas 167-180 do fonte extraido) e formam
    * o contrato que FormSigMvCab.Init() precisara' implementar quando for
    * migrado.
    *
    * WEXIST("SigMvCab") so bloqueia de fato se o futuro FormSigMvCab
    * registrar Name="SigMvCab" ao ser mostrado - documentado aqui para quem
    * migrar aquele form; ate' la' o guard fica inerte (nunca impede a
    * primeira abertura, que e' o caso normal de uso).
    *==========================================================================
    PROCEDURE BtnProcessoClick()
        LOCAL loc_oBO, loc_oFormCab, loc_oErro

        *-- Modo teste/validacao: FormSigMvCab ainda nao existe no acervo -
        *-- nao despachar durante instanciacao automatizada.
        IF (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
           (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
            RETURN
        ENDIF

        loc_oBO = THIS.this_oBusinessObject

        loc_oFormCab = .NULL.

        *-- TRY/CATCH obrigatorio: sem ele, uma falha na criacao (tipicamente
        *-- FormSigMvCab ainda ausente do acervo) exibe o "Program Error" CRU
        *-- do VFP9 em vez do dialogo do sistema.
        *--
        *-- O TRY cobre so a CRIACAO (regra #29 CLAUDE.md). FormSigMvCab sera'
        *-- MODAL (equivalente ao "Do Form SigMvCab" legado, que bloqueia), e
        *-- com o Show() DENTRO do TRY todo o uso daquela tela - cada Valid,
        *-- cada Click - viveria dentro deste bloco; como em VFP9 o TRY/CATCH
        *-- tem precedencia sobre ON ERROR em qualquer ponto da pilha, um erro
        *-- de runtime la dentro saltaria para o CATCH abaixo, abandonaria o
        *-- TRY, derrubaria a referencia LOCAL loc_oFormCab e DESTRUIRIA a tela
        *-- no meio do uso (sintoma: "a tela fecha sozinha e o menu continua").
        TRY
            DO CASE
                CASE loc_oBO.this_cTipo = "E" AND !WEXIST("SigMvCab")
                    loc_oFormCab = CREATEOBJECT("FormSigMvCab", ;
                        PADR(loc_oBO.this_cDope, 20), THIS, .F., .F., .F., .F., ;
                        .F., .F., .F., .F., .F., ;
                        IIF(loc_oBO.this_lMacro, .F., PADR(loc_oBO.this_cDope, 20)))

                CASE loc_oBO.this_cTipo = "C" AND !WEXIST("SigMvCab")
                    loc_oFormCab = CREATEOBJECT("FormSigMvCab", ;
                        PADR(loc_oBO.this_cDope, 20), loc_oBO.this_nNume, ;
                        loc_oBO.this_cEmp, .T., loc_oBO.this_nCaixa, THIS)

                CASE loc_oBO.this_cTipo = "A" AND !WEXIST("SigMvCab")
                    loc_oFormCab = CREATEOBJECT("FormSigMvCab", ;
                        PADR(loc_oBO.this_cDope, 20), loc_oBO.this_nNume, ;
                        loc_oBO.this_cEmp, .F., loc_oBO.this_nCaixa, THIS, ;
                        .F., .F., .F., .F., .T.)
            ENDCASE
        CATCH TO loc_oErro
            MsgErro("Erro ao despachar a movimenta" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                    "Erro: " + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
            loc_oFormCab = .NULL.
        ENDTRY

        *-- Show() FORA do TRY (regra #29)
        IF VARTYPE(loc_oFormCab) = "O"
            loc_oFormCab.Show()
        ENDIF
    ENDPROC

ENDDEFINE
