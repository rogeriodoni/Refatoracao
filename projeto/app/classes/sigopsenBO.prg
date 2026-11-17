*====================================================================
* sigopsenBO.prg
*
* Business Object para SIGOPSEN - Dialogo de Senha de Autorizacao
*
* Dialogo MODAL de AUTORIZACAO do legado Fortyus (sigopsen.SCX): recebe
* um TIPO de liberacao, pede usuario + senha e devolve ao chamador se a
* operacao foi autorizada. O tipo determina (a) o texto exibido na tela
* (Caption do form + Frase), (b) qual permissao de cargo/usuario sera
* exigida no WHERE da consulta de usuarios e (c) se a senha conferida
* eh a senha CADASTRADA do usuario ou a SENHA DO DIA calculada a partir
* do documento.
*
* Tabela principal : SigCdUsu  (usuario que autoriza - PK usuarios char(10))
* Tabelas de apoio : SigCdCrg  (permissoes do cargo - PK ccargs)
*                    SigCdPam  (liblcreds bit)
*                    SigCdPac  (senhdemps bit)
*                    SigCdEmp  (cemps char(3) / nemps numeric(3,0))
*                    SigOpFp   (fpags char(12) / nfpags numeric(2,0))
*                    SigPrSnd  (senha livre - PK cidchaves char(20))
*
* Herda de: BusinessBase
*
* GRAVACAO: este BO NAO eh somente-leitura. O Valid do campo senha do
* legado executa um UPDATE REMOTO real:
*     Update SigPrSnd Set EmpDopNums = '<chave>' Where CidChaves = '<id>'
* seguido de poDataMgr.Commit(). Eh a baixa da "senha livre" previamente
* cadastrada, que amarra a senha ao movimento que a consumiu. Por isso a
* Fase 2 sobrescreve Atualizar() com ESSE update (colunas vindas do
* schema: SigPrSnd.empdopnums char(29) e SigPrSnd.cidchaves char(20)) e
* nao existe Insert/Delete em tabela alguma nesta tela - o comportamento
* padrao herdado de BusinessBase para Inserir()/ExecutarExclusao() ja eh
* o correto, porque inventar um INSERT em SigPrSnd aqui violaria a regra
* de que a lista de colunas vem do schema/legado, nunca de suposicao.
*
* ACHADOS DA FASE 1 (conferidos contra docs/schema.sql, 682 tabelas,
* lido com Get-Content -Raw por ser UTF-16 - regra CLAUDE.md #14):
*
*  (1) fCriptografar() e fGerPswDiario() nao foram portadas para o
*      projeto novo. Sendo este um gate de AUTORIZACAO, a ausencia TEM
*      de ficar visivel: a chamada eh transcrita literalmente e deixada
*      estourar DENTRO do TRY/CATCH do BO, virando this_cMensagemErro
*      para o usuario ver. PROIBIDO criar stub - hash de senha devolvido
*      por stub autentica quem nao devia (senha crua) ou recusa todo
*      mundo, nos dois casos EM SILENCIO.
*
*  (2) Cinco colunas citadas pelo dump legado nao existem no schema
*      canonico (zero ocorrencia em todo o docs/schema.sql):
*         SigCdUsu.liberamov   (ramo LIBMOVUSU)
*         SigCdUsu.liblmpss    (ramo LIBLIMITADOR)
*         SigCdUsu.libvopes    (ramo DTVALIDA - ja COMENTADO no legado)
*         SigCdCrg.conssubn    (ramo LIBSUBN)
*         SigCdCrg.libvalmmax  (ramo LIBVlM)
*      O dump do legado eh mais novo que o snapshot do schema. A
*      migracao transcreve o nome do legado (a divergencia eh de
*      BANCO/ambiente, nao de codigo - regra #14, linha 3 da tabela) e
*      cada ramo fica isolado no seu proprio metodo, para que a falta de
*      UMA coluna no banco conectado nao derrube os outros 20 ramos.
*
*  (3) O ramo DTVALIDA (this_lLibValida) tem o WHERE INTEIRO comentado
*      no fonte legado (*!* nas duas linhas). Transcrever fielmente
*      significa que esse ramo nao monta consulta nenhuma - e no legado
*      isso deixava lcQuery indefinida, levando o SqlExecute a falhar.
*      A Fase 2 trata o ramo como FAIL-CLOSED explicito (sem consulta =
*      sem autorizacao, com mensagem), que eh o unico desfecho seguro
*      para gate de autorizacao e o mais proximo do efeito legado.
*
*  (4) EmpDopNums eh chave POSICIONAL char(29): SigPrSnd.emps char(3) +
*      dopes char(20) + Str(numes, 6) = 29. O legado monta sem ALLTRIM
*      (lcEDN = TprMvCab.Emps + TprMvCab.Dopes + Str(TprMvCab.Numes,6))
*      porque o padding FAZ PARTE da chave. A Fase 2 usa PADR explicito
*      (PADR(emps,3) + PADR(dopes,20) + STR(numes,6)) - regra #42.
*
* Resultado do dialogo: this_lZSen (autorizou) + this_cUsuLibs (quem
* autorizou). ObterResultadoSaida() da Fase 2 equivale ao PROCEDURE
* Unload legado (Return Iif(This.ZSen, [*], [ ]) + This.UsuLibs) e eh a
* fonte UNICA do contrato de retorno lido pelo form chamador.
*
* Criado em: Fase 1 - Propriedades e Init
* Completado em: Fase 2 - CarregarDoCursor() + Atualizar() (baixa da
*                senha livre). Inserir()/ExecutarExclusao() permanecem
*                HERDADOS de BusinessBase (achado (1) acima) - o
*                comportamento padrao (recusar a operacao) ja eh o
*                correto, porque esta tela nunca grava um registro
*                novo nem exclui nada.
* Completado em: Fase 8 - fluxo de ACAO (Valid do campo SENHA):
*                SenhaConferidaPelaCadastrada(), CarregarSenhaUsuario(),
*                CarregarSenhaLivre(), CarregarMovimento(),
*                CalcularSenhaDoDia(), GravarLogLiberacao() e
*                ConferirSenha(), que eh o metodo que DECIDE a
*                autorizacao e publica this_lZSen / this_cUsuLibs /
*                this_lRedigitarSenha.
*
* ACHADO DA FASE 8 (incoerencia do SISTEMA DE ORIGEM, transcrita e nao
* corrigida): a condicao que escolhe entre senha CADASTRADA e senha DO
* DIA eh DIFERENTE no Init e no Valid do campo senha. O Init liga o modo
* senha do dia com "(LiblCreds And pTip='LIMITE') Or InList(pTip,
* 'LIBPRDZ2','MAXIMO')", enquanto o Valid da senha (e o When do campo
* usuario) usam "(Not LiblCreds Or (Tipo#'LIMITE' And Tipo#'LIBPRDZ2'))
* And Tipo#'MAXIMO'". Com LiblCreds DESLIGADO e tipo LIBPRDZ2 a tela
* exibe o rotulo "Senha Do Dia :" e ainda assim confere a senha
* CADASTRADA. As duas expressoes ficam em lugares SEPARADOS
* (this_lSenhaDoDia para a aparencia, SenhaConferidaPelaCadastrada() para
* a conferencia) justamente para que uma nao seja derivada da outra.
*====================================================================

DEFINE CLASS sigopsenBO AS BusinessBase

    *----------------------------------------------------------------
    * 1) PARAMETROS DE ENTRADA
    *    Init legado: LParameters pTip, pTi1, pTi2, pDoc, pDat, pEmp,
    *                             pFpg, pVal
    *----------------------------------------------------------------

    *-- pTip / ThisForm.Tipo - chave que seleciona a regra de liberacao.
    *-- Os valores do DO CASE legado: CUSTOPROD, DTENTREGA, CHDEVOLVIDO,
    *-- LIMITE, ALTERAIMPOSTO, CANCITEM, LIBFPAG, LIBPRDZ, LIBPRDZ2,
    *-- LIBPESO, SDINSUF, MAXIMO, DTVALIDA, LIBTITULO, LIBERAFPG,
    *-- LIBOPE, LIBMOVUSU, LIBQTMIN, LIBLIMITADOR, MOVESTOQUE,
    *-- LIBLEILAO, LIBDUPEND, LIBPRZENT, LIBVMOVDUP, LIBVlM, LIBSENEXC,
    *-- LIBSUBN
    this_cTipo = ""

    *-- pTi1 / pTi2 - textos crus vindos do chamador. O DO CASE legado
    *-- combina os dois de forma DIFERENTE em cada tipo, por isso os
    *-- dois ficam guardados CRUS e a combinacao eh derivada.
    *-- ATENCAO: no ramo CHDEVOLVIDO o chamador passa um NUMERO em pTi1
    *-- (contagem de cheques: o legado compara pTi1 com 1 para escolher
    *-- entre o texto no singular e Alltrim(Str(pTi1)) + o texto no
    *-- plural). Quem derivar o
    *-- texto TEM de testar VARTYPE antes de comparar com 1, senao
    *-- comparar Caractere com Numerico estoura
    *-- "Operator/operand type mismatch"
    this_cTitulo  = ""
    this_cTitulo2 = ""

    *-- pDoc / ThisForm.NroDoc - numero do documento; entra no calculo
    *-- da senha do dia. Init legado: If Type([pDoc]) <> [N] -> pDoc = 0
    this_nNroDoc = 0

    *-- pDat / ThisForm.DatDoc - data do documento; entra no calculo da
    *-- senha do dia. Init legado: If Type([pDat]) <> [D] -> Date()
    this_dDatDoc = {}

    *-- pEmp / ThisForm.Empresa -> SigCdEmp.cemps char(3)
    this_cEmpresa = ""

    *-- pFpg / ThisForm.Fpagto -> SigOpFp.fpags char(12)
    this_cFpagto = ""

    *-- pVal / ThisForm.ValFpag - valor da condicao de pagamento
    this_nValFpag = 0

    *----------------------------------------------------------------
    * 2) TEXTOS DERIVADOS DO TIPO
    *    No legado o DO CASE do Init escreve direto em This.Caption e
    *    em This.Frase.Caption, e depois copia o Caption para os dois
    *    labels da faixa (cntSombra.lblSombra e cntSombra.lblTitulo).
    *    Aqui a derivacao mora no BO e o Form apenas espelha, para o
    *    texto ter fonte UNICA
    *----------------------------------------------------------------
    this_cCaption = ""
    this_cFrase   = ""

    *----------------------------------------------------------------
    * 3) FLAGS DE TIPO DE AUTORIZACAO
    *    As 21 flags logicas do legado (ClassInfo do SCX). Cada uma
    *    seleciona um WHERE diferente no Valid do campo usuario, por
    *    isso sao propriedades distintas e nao um unico codigo.
    *    A ordem do DO CASE do Valid legado eh significativa: a
    *    PRIMEIRA flag ligada ganha, e o Otherwise exige
    *    SigCdCrg.altcots = 'S'
    *----------------------------------------------------------------

    *-- ThisForm.CancItem - CANCITEM; exige SigCdCrg.cancitens = 'S'
    this_lCancItem = .F.

    *-- ThisForm.Financ - exige SigCdCrg.limites = 'S'
    *-- (CHDEVOLVIDO, LIMITE, ALTERAIMPOSTO, MAXIMO; DTENTREGA desliga)
    this_lFinanc = .F.

    *-- ThisForm.LibFpag - LIBFPAG; exige SigCdCrg.libfpags = 'S'
    this_lLibFpag = .F.

    *-- ThisForm.LibFpag2 - LIBERAFPG; exige SigCdCrg.libfpgs = 'S'
    this_lLibFpag2 = .F.

    *-- ThisForm.LibProducao - LIBPRDZ/LIBPRDZ2/LIBPESO; exige
    *-- SigCdUsu.libpess = 'S' quando o tipo eh LIBPESO, senao
    *-- SigCdUsu.libprods = 'S'
    this_lLibProducao = .F.

    *-- ThisForm.Saldoestoque - SDINSUF; exige SigCdCrg.libsdins = 'S'
    this_lSaldoEstoque = .F.

    *-- ThisForm.LibValida - DTVALIDA; o WHERE legado esta COMENTADO
    *-- (SigCdUsu.libvopes, coluna que nao existe no schema canonico).
    *-- Ver achado (3) do cabecalho: ramo tratado como FAIL-CLOSED
    this_lLibValida = .F.

    *-- ThisForm.LibOpe - LIBOPE; exige SigCdCrg.libopes = 'S'
    this_lLibOpe = .F.

    *-- ThisForm.LibMovUsu - LIBMOVUSU; exige SigCdUsu.liberamov = 1
    *-- (coluna ausente do schema canonico - achado (2))
    this_lLibMovUsu = .F.

    *-- ThisForm.LibQtMin - LIBQTMIN; exige SigCdUsu.libqtmins = 'S'
    this_lLibQtMin = .F.

    *-- ThisForm.LibLimitador - LIBLIMITADOR; exige SigCdUsu.liblmpss
    *-- = 'S' (coluna ausente do schema canonico - achado (2))
    this_lLibLimitador = .F.

    *-- ThisForm.MovEstoque - MOVESTOQUE; basta usuario ativo com senha
    *-- cadastrada (o WHERE nao exige permissao nenhuma)
    this_lMovEstoque = .F.

    *-- ThisForm.libvmovdup - LIBVMOVDUP; exige
    *-- SigCdCrg.libvmovdup = 'S'
    this_lLibVMovDup = .F.

    *-- ThisForm.LibLeilao - LIBLEILAO; exige SigCdCrg.libleilaos
    *-- comparada com .T. (coluna numeric(1,0) no schema - o legado
    *-- passa o parametro logico ?llTrue e deixa o driver converter)
    this_lLibLeilao = .F.

    *-- ThisForm.LibDupEnd - LIBDUPEND; exige SigCdCrg.libdupends
    this_lLibDupEnd = .F.

    *-- ThisForm.LiberaTitulo - LIBTITULO; exige SigCdCrg.libduptits
    this_lLiberaTitulo = .F.

    *-- ThisForm.LibPrzEnt - LIBPRZENT; exige SigCdCrg.libprzes
    this_lLibPrzEnt = .F.

    *-- ThisForm.CustoProd - CUSTOPROD; exige SigCdCrg.custoprod
    this_lCustoProd = .F.

    *-- ThisForm.libValMaxMal - LIBVlM; exige SigCdCrg.libvalmmax = 1
    *-- (coluna ausente do schema canonico - achado (2))
    this_lLibValMaxMal = .F.

    *-- ThisForm.LibExcPrd - LIBSENEXC; exige SigCdCrg.libexprd = 'S'
    *-- (o legado escreve b.LibExPrd; a coluna real do schema eh
    *--  libexprd char(1) - mesma grafia, apenas outra caixa)
    this_lLibExcPrd = .F.

    *-- ThisForm.LibSubn - LIBSUBN; exige SigCdCrg.conssubn = 'S'
    *-- (coluna ausente do schema canonico - achado (2))
    this_lLibSubn = .F.

    *----------------------------------------------------------------
    * 4) CREDENCIAIS DIGITADAS NA TELA
    *----------------------------------------------------------------

    *-- usuario.Value -> SigCdUsu.usuarios char(10). O legado forca
    *-- maiuscula (usual = upper(usual)) antes do Seek
    this_cUsuario = ""

    *-- senha.Value - valor transitorio, NUNCA persistido
    this_cSenha = ""

    *----------------------------------------------------------------
    * 5) DADOS DO USUARIO AUTENTICADO (lidos de SigCdUsu / SigCdCrg)
    *----------------------------------------------------------------

    *-- SigCdUsu.senhas char(10) - senha cadastrada, gravada cifrada.
    *-- Senha cadastrada VAZIA eh caso de negocio, nao erro: o legado
    *-- autoriza direto, esconde os controles de senha e fecha a tela
    this_cSenhaCadastrada = ""

    *-- SigCdUsu.ccargs char(10) - cargo, que liga em SigCdCrg.ccargs
    this_cCargoUsuario = ""

    *-- SigCdUsu.cativos char(1) - 'N' marca usuario inativo; todo
    *-- WHERE do legado comeca com Not a.cAtivos = 'N'
    this_cUsuarioAtivo = ""

    *-- .F. quando o usuario selecionado nao tem senha cadastrada: a
    *-- tela nem pede senha (thisform.say3.visible = .f. /
    *-- thisform.senha.visible = .f. / zsen = .t. / release)
    this_lExigeSenha = .T.

    *----------------------------------------------------------------
    * 6) PARAMETROS DO SISTEMA
    *    Init legado: CursorQuery([SigCdPam],[crParam],.f.,.f.,[LibLCreds])
    *                 CursorQuery([SigCdPac],[crParac],.f.,.f.,[SenhDEmps])
    *    As duas colunas sao bit NOT NULL no schema e chegam ao VFP ora
    *    como Logico ora como Numerico conforme o driver ODBC, por isso
    *    a leitura delas exige VARTYPE antes de comparar (regra #13)
    *----------------------------------------------------------------

    *-- SigCdPam.liblcreds bit - sistema usa credencial/senha do dia
    this_lLiblCreds = .F.

    *-- SigCdPac.senhdemps bit - a senha do dia leva empresa e forma de
    *-- pagamento no numero base
    this_lSenhDEmps = .F.

    *----------------------------------------------------------------
    * 7) MODO SENHA DO DIA
    *    ATENCAO: no legado existem DUAS expressoes parecidas, mas nao
    *    algebricamente iguais - transcrever e manter as duas
    *    separadas, sem unificar (regra #17):
    *
    *    (a) Init - so decide o PREENCHIMENTO visual (usuario.Value =
    *        Usuar + troca o Say3 para "Senha Do Dia :" + Say3.Left =
    *        142):
    *          ( crParam.LiblCreds And pTip = [LIMITE] )
    *            Or InList(pTip, [LIBPRDZ2], [MAXIMO])
    *
    *    (b) When do campo usuario E Valid do campo senha compartilham
    *        a MESMA expressao (texto identico nos dois pontos):
    *          ( Not crParam.LiblCreds Or (Tipo <> [LIMITE] And
    *            Tipo <> [LIBPRDZ2]) ) And Tipo <> [MAXIMO]
    *        Quando essa expressao eh FALSA, o Valid da senha entra no
    *        ramo "senha do dia" (compara com fGerPswDiario em vez da
    *        senha cadastrada). this_lSenhaDoDia guarda a NEGACAO desta
    *        expressao.
    *
    *    Com Tipo = LIBPRDZ2 e LiblCreds = .F., (a) vale (pre-preenche
    *    a tela e troca o rotulo) mas (b) NAO entra no ramo
    *    senha-do-dia - a tela mostra "Senha Do Dia :" e o Valid ainda
    *    confere contra a senha CADASTRADA. Comportamento do fonte
    *    legado, nao desvio da migracao
    *----------------------------------------------------------------
    this_lSenhaDoDia = .F.

    *-- Senha do dia calculada (fGerPswDiario do legado - ausente, ver
    *-- achado (1) do cabecalho)
    this_cSenhaDoDia = ""

    *-- lnNum do legado: SigCdEmp.nemps + SigOpFp.nfpags +
    *-- ( ValFpag * 100 ), somado so quando SenhDEmps esta ligado
    this_nNumeroBase = 0

    *-- SigCdEmp.nemps numeric(3,0)
    this_nNumEmpresa = 0

    *-- SigOpFp.nfpags numeric(2,0)
    this_nNumFpagto = 0

    *----------------------------------------------------------------
    * 8) SENHA LIVRE (SigPrSnd) - bloco exclusivo do SIGOPSEN
    *    Valid da senha legado:
    *      select * from SigPrSnd a where a.empdopnums = '' and
    *             a.usuars = '<usuario>' and a.senhads = '<senha>'
    *    Achando registro, a senha digitada eh uma senha livre ja
    *    autorizada e a conferencia contra a senha cadastrada eh
    *    DISPENSADA (as duas recusas do legado exigem
    *    RECCOUNT('TmpSLivre') = 0)
    *----------------------------------------------------------------

    *-- .T. quando ha senha livre ainda em aberto (empdopnums vazio,
    *-- isto eh, nunca consumida) casando usuario + senha
    this_lSenhaLivre = .F.

    *-- SigPrSnd.cidchaves char(20) - PK do registro de senha livre,
    *-- usada no WHERE do UPDATE que faz a baixa
    this_cChaveSenhaLivre = ""

    *-- SigPrSnd.empdopnums char(29) - chave POSICIONAL do movimento
    *-- que consumiu a senha: PADR(emps,3) + PADR(dopes,20) +
    *-- STR(numes,6) = 29 caracteres (regra #42 - sem ALLTRIM nas
    *-- partes, porque o padding FAZ PARTE da chave)
    this_cEmpDopNums = ""

    *----------------------------------------------------------------
    * 9) MOVIMENTO CORRENTE (cursor TprMvCab do form chamador)
    *    O dialogo nao cria esse cursor: ele eh aberto pelo form que
    *    pede a autorizacao, e o legado so age se Used([TprMvCab]).
    *    As tres colunas alimentam a chave EmpDopNums do bloco (8) e o
    *    log de liberacao (fGravarLog)
    *----------------------------------------------------------------

    *-- TprMvCab.Emps char(3)
    this_cEmpsMov = ""

    *-- TprMvCab.Dopes char(20)
    this_cDopesMov = ""

    *-- TprMvCab.Numes numeric(6,0)
    this_nNumesMov = 0

    *-- .T. quando o cursor do movimento estava aberto e foi lido
    this_lMovimentoCarregado = .F.

    *----------------------------------------------------------------
    * 10) RESULTADO DO DIALOGO
    *----------------------------------------------------------------

    *-- ThisForm.zsen - .T. somente quando a autorizacao foi concedida
    this_lZSen = .F.

    *-- ThisForm.usulibs - usuario que liberou (ou a propria senha do
    *-- dia, no ramo de senha do dia do legado:
    *--  Thisform.usulibs = lcSenha)
    this_cUsuLibs = ""

    *-- Retorno do PROCEDURE Unload legado:
    *--  Return Iif(This.ZSen, [*], [ ]) + This.UsuLibs
    this_cRetorno = ""

    *-- Campo que recebe o foco apos recusa: "USUARIO" ou "SENHA"
    this_cCampoFoco = ""

    *-- .T. quando o usuario pediu para digitar a senha de novo
    *-- (messagebox 'Deseja digitar novamente ? (S/N)' respondido Sim,
    *-- que no legado faz Return 0 e devolve o foco ao campo)
    this_lRedigitarSenha = .F.

    *----------------------------------------------------------------
    * 11) NOMES DOS CURSORES DE TRABALHO
    *     cursor_4c_* conforme a convencao do projeto; o UNICO nome
    *     legado preservado eh TprMvCab, porque esse cursor eh criado
    *     pelo form CHAMADOR e nao por este dialogo
    *----------------------------------------------------------------

    *-- TmpUsu do legado - usuarios habilitados para o tipo pedido
    this_cCursorUsuarios = "cursor_4c_Usuarios"

    *-- Releitura de SigCdUsu feita pelo Valid do campo SENHA (primeira
    *-- consulta daquele metodo). No legado ela REUSA o alias TmpUsu,
    *-- sobrescrevendo a lista de usuarios autorizados por uma linha so e
    *-- com DUAS colunas (usuarios/senhas). Aqui ela vai para um cursor
    *-- PROPRIO (divergencia de PILAR 3, sem efeito observavel): o unico
    *-- uso do alias depois daquela consulta eh o fCriptografar(senhas), e
    *-- clobberar o cursor da lista deixaria o picker do campo usuario
    *-- apontando para um cursor sem a coluna ccargs - a segunda coluna
    *-- que ele exibe - fazendo o lookup estourar se o usuario voltasse ao
    *-- campo depois de errar a senha.
    this_cCursorSenhaUsuario = "cursor_4c_SenhaUsuario"

    *-- crParam do legado - SigCdPam (liblcreds)
    this_cCursorParam = "cursor_4c_Param"

    *-- crParac do legado - SigCdPac (senhdemps)
    this_cCursorParac = "cursor_4c_Parac"

    *-- TmpSLivre do legado - SigPrSnd (senha livre em aberto)
    this_cCursorSenhaLivre = "cursor_4c_SenhaLivre"

    *-- CrEmp do legado - SigCdEmp (nemps)
    this_cCursorEmpresa = "cursor_4c_Empresa"

    *-- CrfPagto do legado - SigOpFp (nfpags)
    this_cCursorFpagto = "cursor_4c_Fpagto"

    *-- Cursor do movimento corrente, aberto pelo form chamador
    this_cCursorMovimento = "TprMvCab"

    *====================================================================
    * Init - Inicializa o Business Object
    *
    * Define tabela e chave primaria e normaliza o valor inicial de
    * TODA propriedade. NAO executa SQL: Init de BO que devolve .F.
    * destroi o objeto, e dai o Form aborta o proprio Init e a tela
    * nunca abre - nem em validacao de UI, onde gnConnHandle vale -1 e
    * qualquer SQLEXEC estoura. A carga dos parametros do sistema
    * (SigCdPam/SigCdPac) fica sob demanda, nos metodos que precisam
    * deles.
    *
    * A tabela VAI no DODEFAULT: BusinessBase.Init() so cria
    * this_oDataAccess quando recebe pcTabela; com DODEFAULT() vazio o
    * objeto de acesso a dados fica .NULL. e todo metodo herdado que
    * depende dele devolve .F. com "Objeto de acesso a dados nao
    * inicializado".
    *
    * Sem RETURN dentro de TRY/CATCH (regra #1): o resultado vai para a
    * flag loc_lSucesso e o unico RETURN fica DEPOIS do ENDTRY.
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT("SigCdUsu")

            THIS.this_cTabela     = "SigCdUsu"
            THIS.this_cCampoChave = "usuarios"

            *-- Equivalente ao bloco de normalizacao do Init legado
            *-- (If Type([pDoc]) <> [N] -> pDoc = 0, If Type([pDat]) <>
            *-- [D] -> pDat = Date(), e os demais), para o BO nascer
            *-- com valor valido em todo campo
            THIS.this_cTipo    = ""
            THIS.this_cTitulo  = ""
            THIS.this_cTitulo2 = ""
            THIS.this_nNroDoc  = 0
            THIS.this_dDatDoc  = DATE()
            THIS.this_cEmpresa = ""
            THIS.this_cFpagto  = ""
            THIS.this_nValFpag = 0

            THIS.this_cCaption = ""
            THIS.this_cFrase   = ""

            *-- As 21 flags de tipo nascem desligadas, como no Init
            *-- legado, que zera todas antes de entrar no DO CASE
            THIS.this_lCancItem     = .F.
            THIS.this_lFinanc       = .F.
            THIS.this_lLibFpag      = .F.
            THIS.this_lLibFpag2     = .F.
            THIS.this_lLibProducao  = .F.
            THIS.this_lSaldoEstoque = .F.
            THIS.this_lLibValida    = .F.
            THIS.this_lLibOpe       = .F.
            THIS.this_lLibMovUsu    = .F.
            THIS.this_lLibQtMin     = .F.
            THIS.this_lLibLimitador = .F.
            THIS.this_lMovEstoque   = .F.
            THIS.this_lLibVMovDup   = .F.
            THIS.this_lLibLeilao    = .F.
            THIS.this_lLibDupEnd    = .F.
            THIS.this_lLiberaTitulo = .F.
            THIS.this_lLibPrzEnt    = .F.
            THIS.this_lCustoProd    = .F.
            THIS.this_lLibValMaxMal = .F.
            THIS.this_lLibExcPrd    = .F.
            THIS.this_lLibSubn      = .F.

            THIS.this_cUsuario = ""
            THIS.this_cSenha   = ""

            THIS.this_cSenhaCadastrada = ""
            THIS.this_cCargoUsuario    = ""
            THIS.this_cUsuarioAtivo    = ""
            THIS.this_lExigeSenha      = .T.

            THIS.this_lLiblCreds = .F.
            THIS.this_lSenhDEmps = .F.

            THIS.this_lSenhaDoDia = .F.
            THIS.this_cSenhaDoDia = ""
            THIS.this_nNumeroBase = 0
            THIS.this_nNumEmpresa = 0
            THIS.this_nNumFpagto  = 0

            THIS.this_lSenhaLivre      = .F.
            THIS.this_cChaveSenhaLivre = ""
            THIS.this_cEmpDopNums      = ""

            THIS.this_cEmpsMov            = ""
            THIS.this_cDopesMov           = ""
            THIS.this_nNumesMov           = 0
            THIS.this_lMovimentoCarregado = .F.

            *-- FAIL-CLOSED: este dialogo eh gate de AUTORIZACAO, entao
            *-- o estado inicial eh sempre "nao autorizado". Somente a
            *-- conferencia bem sucedida da senha liga this_lZSen
            THIS.this_lZSen           = .F.
            THIS.this_cUsuLibs        = ""
            THIS.this_cRetorno        = ""
            THIS.this_cCampoFoco      = "USUARIO"
            THIS.this_lRedigitarSenha = .F.

            *-- Nomes dos cursores de trabalho (o do movimento mantem o
            *-- nome legado, por ser criado pelo form chamador)
            THIS.this_cCursorUsuarios     = "cursor_4c_Usuarios"
            THIS.this_cCursorSenhaUsuario = "cursor_4c_SenhaUsuario"
            THIS.this_cCursorParam      = "cursor_4c_Param"
            THIS.this_cCursorParac      = "cursor_4c_Parac"
            THIS.this_cCursorSenhaLivre = "cursor_4c_SenhaLivre"
            THIS.this_cCursorEmpresa    = "cursor_4c_Empresa"
            THIS.this_cCursorFpagto     = "cursor_4c_Fpagto"
            THIS.this_cCursorMovimento  = "TprMvCab"

            THIS.this_cMensagemErro = ""
            THIS.this_lErroExibido  = .F.

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inicializar sigopsenBO:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
            MsgErro(THIS.this_cMensagemErro, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - hook de BusinessBase.RegistrarAuditoria. A
    * "entidade" deste dialogo eh o USUARIO que concede a liberacao, por
    * isso a chave eh this_cUsuario.
    *
    * PROTECTED porque eh hook interno da base e nunca eh chamado de
    * fora do BO (regra #51)
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cUsuario)
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega para as propriedades do USUARIO
    * autenticado o registro corrente do cursor populado pela consulta
    * do DO CASE do Valid legado (equivalente ao TmpUsu do legado:
    * Select a.* From SigCdUsu a [, SigCdCrg b] Where ...).
    *
    * Mapeia so as QUATRO colunas de SigCdUsu que o Valid dos dois
    * campos da tela realmente le (usuarios/senhas/ccargs/cativos) - o
    * "a.*" do legado traz a linha inteira para o cursor, mas nenhuma
    * outra coluna eh referenciada em lugar nenhum do fonte original.
    *
    * SELECT (par_cAliasCursor) antes de acessar os campos (nao
    * "campo" - sintaxe invalida em VFP9)
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        THIS.this_cUsuario         = TratarNulo(usuarios, "C")
        THIS.this_cSenhaCadastrada = TratarNulo(senhas, "C")
        THIS.this_cCargoUsuario    = TratarNulo(ccargs, "C")
        THIS.this_cUsuarioAtivo    = TratarNulo(cativos, "C")

        loc_lResultado = .T.
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * MontarEmpDopNums - Chave POSICIONAL char(29) de SigPrSnd.EmpDopNums
    * (regra #42): emps char(3) + dopes char(20) + Str(numes,6) = 29.
    *
    * O legado NAO faz ALLTRIM nas partes:
    *   lcEDN = TprMvCab.Emps + TprMvCab.Dopes + Str(TprMvCab.Numes,6)
    * porque o padding FAZ PARTE da chave - usar PADR explicito contra a
    * largura real da coluna, nunca confiar no padding que o cursor do
    * form chamador por acaso traz em this_cEmpsMov/this_cDopesMov.
    *
    * PROTECTED - helper interno de Atualizar(), nunca chamado de fora.
    *====================================================================
    PROTECTED FUNCTION MontarEmpDopNums()
        RETURN PADR(THIS.this_cEmpsMov, 3) + PADR(THIS.this_cDopesMov, 20) + STR(THIS.this_nNumesMov, 6)
    ENDFUNC

    *====================================================================
    * Atualizar - Baixa da SENHA LIVRE (SigPrSnd), transcrita do Valid
    * do campo senha do legado:
    *     Update SigPrSnd Set EmpDopNums = '<chave>' Where CidChaves = '<id>'
    *     ThisForm.poDataMgr.Commit()
    *
    * Unico UPDATE desta tela (ver achado (1) do cabecalho) - amarra a
    * senha livre previamente cadastrada (this_lSenhaLivre) ao
    * movimento que a consumiu, usando a chave posicional montada por
    * MontarEmpDopNums().
    *
    * PUBLIC (sem PROTECTED): este dialogo nao tem this_lEmEdicao nem
    * this_lNovoRegistro no sentido do CRUD classico (nao eh um
    * cadastro, eh um gate de autorizacao), entao BusinessBase.Salvar()
    * nao se aplica aqui - o Form chama THIS.this_oBusinessObject.
    * Atualizar() DIRETO a partir do fluxo de validacao da senha.
    * Metodo chamado de fora nunca pode ficar PROTECTED em nenhum nivel
    * da heranca (regra #51), e BusinessBase.Atualizar() ja eh PUBLIC.
    *
    * Guard "If Used([TprMvCab])" do legado: sem senha livre em aberto
    * (this_lSenhaLivre) ou sem o cursor do movimento carregado
    * (this_lMovimentoCarregado), nao ha nada para gravar - devolve .T.
    * (sucesso vazio), exatamente como o legado segue adiante sem
    * montar UPDATE nenhum quando TprMvCab nao esta aberto.
    *
    * Conexao nasce em transacao MANUAL neste ambiente (SQLGETPROP = 2)
    * - o Commit()/RollBack() do legado NAO eh detalhe de infra, eh um
    * passo com caminho de falha proprio. Guard por IF ANINHADO (VFP9
    * nao faz curto-circuito em AND).
    *
    * Sem RETURN dentro de TRY/CATCH (regra #1): o resultado vai para a
    * flag loc_lResultado, e o RETURN final fica fora do ENDTRY. O
    * RETURN antecipado do guard tambem fica FORA do TRY (ele nem chega
    * a abrir o bloco).
    *====================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_lManual

        loc_lResultado = .T.

        IF !THIS.this_lSenhaLivre OR !THIS.this_lMovimentoCarregado OR ;
                EMPTY(ALLTRIM(NVL(THIS.this_cChaveSenhaLivre, "")))
            RETURN loc_lResultado
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o inicializada"
            RETURN .F.
        ENDIF

        loc_lManual = (SQLGETPROP(gnConnHandle, "Transactions") = 2)

        TRY
            THIS.this_cEmpDopNums = THIS.MontarEmpDopNums()

            loc_cSQL = "UPDATE SigPrSnd SET EmpDopNums = " + EscaparSQL(THIS.this_cEmpDopNums) + ;
                " WHERE CidChaves = " + EscaparSQL(THIS.this_cChaveSenhaLivre)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                IF loc_lManual
                    IF SQLCOMMIT(gnConnHandle) < 1
                        = SQLROLLBACK(gnConnHandle)
                        THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (Commit)"
                        loc_lResultado = .F.
                    ENDIF
                ENDIF

                IF loc_lResultado
                    THIS.RegistrarAuditoria("UPDATE")
                ENDIF
            ELSE
                IF loc_lManual
                    = SQLROLLBACK(gnConnHandle)
                ENDIF
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (Baixa Senha Livre)"
                loc_lResultado = .F.
            ENDIF

        CATCH TO loc_oErro
            IF loc_lManual
                = SQLROLLBACK(gnConnHandle)
            ENDIF
            THIS.this_cMensagemErro = "Erro ao atualizar sigopsenBO:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * MontarQueryUsuarios - Transcricao do "Do Case" do Valid do campo
    * usuario legado: devolve a consulta que lista os usuarios
    * AUTORIZADOS a liberar ESTE tipo de operacao.
    *
    * Esta eh a regra de negocio central do dialogo: o TIPO da liberacao
    * (ja traduzido em flag por ConfigurarPorTipo do Form) escolhe QUAL
    * permissao de cargo (SigCdCrg) ou de usuario (SigCdUsu) sera
    * exigida. A ORDEM dos ramos eh a do legado e NAO pode mudar - o Do
    * Case para no PRIMEIRO que casa, e tipos como LIBPESO ligam duas
    * flags (LibProducao pelo ramo do InList e, por consequencia, cairiam
    * tambem em ramos posteriores se a ordem fosse trocada).
    *
    * Molde comum a todos os ramos (transcrito literalmente):
    *   Select a.* From SigCdUsu a [, SigCdCrg b]
    *   Where Not a.cAtivos='N' [And a.Ccargs = b.ccargs]
    *         And <condicao do ramo> and not a.Senhas = '      '
    *
    * Quatro fidelidades que o ramo-a-ramo exige:
    *   - LibProducao, LibQtMin, LibLimitador e MovEstoque NAO fazem o
    *     join com SigCdCrg: a permissao esta em SigCdUsu.
    *   - MovEstoque nao acrescenta condicao alguma - qualquer usuario
    *     ativo com senha cadastrada serve.
    *   - LibProducao se divide em DUAS consultas conforme o tipo
    *     (LIBPESO -> a.libpess, os demais -> a.libprods).
    *   - o "not a.Senhas = '      '" (SEIS espacos, nao dez) exclui quem
    *     nao tem senha cadastrada; o literal eh transcrito com a mesma
    *     largura, via EscaparSQL(SPACE(6)).
    *
    * As colunas que o legado cita e o schema canonico NAO tem
    * (a.liberamov, a.liblmpss, b.libvalmmax, b.conssubn - achado (2) do
    * cabecalho) sao transcritas com o nome do LEGADO: a divergencia eh de
    * BANCO/ambiente, nao de codigo (regra #14). Cada uma aparece em UM
    * unico ramo, entao a falta de uma coluna no banco conectado derruba
    * so a sua liberacao - os outros 20 ramos seguem funcionando.
    *
    * O ramo DTVALIDA (this_lLibValida) tem o WHERE INTEIRO comentado no
    * fonte legado (*!* nas duas linhas) e por isso NAO monta consulta: no
    * legado isso deixava lcQuery indefinida e o SqlExecute falhava. Aqui
    * eh FAIL-CLOSED explicito - devolve string vazia com mensagem, e sem
    * consulta nao ha autorizacao, que eh o unico desfecho seguro para um
    * gate de autorizacao.
    *
    * PUBLIC (regra #51): chamado pelo Form a partir do fluxo de
    * validacao do campo usuario.
    *====================================================================
    FUNCTION MontarQueryUsuarios()
        LOCAL loc_cTipo, loc_cCond, loc_lJoinCargo, loc_lMontou, loc_cSQL

        loc_cTipo      = UPPER(ALLTRIM(THIS.this_cTipo))
        loc_cCond      = ""
        loc_lJoinCargo = .T.
        loc_lMontou    = .T.
        loc_cSQL       = ""

        DO CASE
            CASE THIS.this_lCancItem
                loc_cCond = "b.cancitens = " + EscaparSQL("S")

            CASE THIS.this_lFinanc
                loc_cCond = "b.limites = " + EscaparSQL("S")

            CASE THIS.this_lLibFpag
                loc_cCond = "b.libfpags = " + EscaparSQL("S")

            CASE THIS.this_lLibFpag2
                loc_cCond = "b.libfpgs = " + EscaparSQL("S")

            CASE THIS.this_lLibProducao
                *-- Legado: If Thisform.Tipo = 'LIBPESO' -> a.LibPess,
                *-- senao a.LibProds. Nos dois casos SEM join com SigCdCrg.
                loc_lJoinCargo = .F.

                IF loc_cTipo == "LIBPESO"
                    loc_cCond = "a.libpess = " + EscaparSQL("S")
                ELSE
                    loc_cCond = "a.libprods = " + EscaparSQL("S")
                ENDIF

            CASE THIS.this_lSaldoEstoque
                loc_cCond = "b.libsdins = " + EscaparSQL("S")

            CASE THIS.this_lLibValida
                *-- Ramo DTVALIDA: WHERE comentado no legado - FAIL-CLOSED
                loc_lMontou = .F.
                THIS.this_cMensagemErro = "Libera" + CHR(231) + CHR(227) + ;
                    "o por validade da opera" + CHR(231) + CHR(227) + ;
                    "o sem consulta de usu" + CHR(225) + "rios definida no sistema de origem"

            CASE THIS.this_lLibOpe
                loc_cCond = "b.libopes = " + EscaparSQL("S")

            CASE THIS.this_lLibMovUsu
                *-- Legado: a.liberamov = 1 (coluna de SigCdUsu, mas o
                *-- legado MANTEM o join com SigCdCrg neste ramo)
                loc_cCond = "a.liberamov = " + FormatarNumeroSQL(1, 0)

            CASE THIS.this_lLibQtMin
                loc_lJoinCargo = .F.
                loc_cCond      = "a.libqtmins = " + EscaparSQL("S")

            CASE THIS.this_lLibLimitador
                loc_lJoinCargo = .F.
                loc_cCond      = "a.liblmpss = " + EscaparSQL("S")

            CASE THIS.this_lMovEstoque
                *-- Legado: Select a.* From SigCdUsu a Where Not
                *-- a.cAtivos='N' and not a.Senhas = '      ' - nenhuma
                *-- permissao especifica, nenhum join
                loc_lJoinCargo = .F.

            CASE THIS.this_lLibVMovDup
                loc_cCond = "b.libvmovdup = " + EscaparSQL("S")

            CASE THIS.this_lLibLeilao
                *-- Legado: b.LibLeilaos = ?llTrue, com llTrue = .t. A
                *-- coluna eh numeric(1,0) no schema, logo o parametro
                *-- logico chega ao servidor como 1.
                loc_cCond = "b.libleilaos = " + FormatarNumeroSQL(1, 0)

            CASE THIS.this_lLibDupEnd
                loc_cCond = "b.libdupends = " + FormatarNumeroSQL(1, 0)

            CASE THIS.this_lLiberaTitulo
                loc_cCond = "b.libduptits = " + FormatarNumeroSQL(1, 0)

            CASE THIS.this_lLibPrzEnt
                loc_cCond = "b.libprzes = " + FormatarNumeroSQL(1, 0)

            CASE THIS.this_lCustoProd
                loc_cCond = "b.custoprod = " + FormatarNumeroSQL(1, 0)

            CASE THIS.this_lLibValMaxMal
                loc_cCond = "b.libvalmmax = " + FormatarNumeroSQL(1, 0)

            CASE THIS.this_lLibExcPrd
                loc_cCond = "b.libexprd = " + EscaparSQL("S")

            CASE THIS.this_lLibSubn
                loc_cCond = "b.conssubn = " + EscaparSQL("S")

            OTHERWISE
                *-- Otherwise do legado: permissao de alterar cotacao
                loc_cCond = "b.altcots = " + EscaparSQL("S")
        ENDCASE

        IF loc_lMontou
            *-- "Select a.*" do legado reduzido as QUATRO colunas que o
            *-- fluxo le de fato (as mesmas que CarregarDoCursor mapeia):
            *-- usuarios para a chave e o picker, ccargs para a 2a coluna
            *-- do picker, senhas para decidir se a tela pede senha e
            *-- cativos por fidelidade ao filtro.
            *-- ORDER BY substitui o "index on usuarios tag usuarios" do
            *-- legado: a lista chega ao picker na mesma ordem, sem
            *-- precisar indexar um cursor de SQL pass-through (que eh
            *-- somente-leitura).
            loc_cSQL = "SELECT a.usuarios, a.senhas, a.ccargs, a.cativos" + ;
                " FROM SigCdUsu a" + IIF(loc_lJoinCargo, ", SigCdCrg b", "") + ;
                " WHERE NOT a.cativos = " + EscaparSQL("N") + ;
                IIF(loc_lJoinCargo, " AND a.ccargs = b.ccargs", "") + ;
                IIF(EMPTY(loc_cCond), "", " AND " + loc_cCond) + ;
                " AND NOT a.senhas = " + EscaparSQL(SPACE(6)) + ;
                " ORDER BY a.usuarios"
        ENDIF

        RETURN loc_cSQL
    ENDFUNC

    *====================================================================
    * CarregarUsuariosAutorizados - Executa a consulta de
    * MontarQueryUsuarios() no cursor this_cCursorUsuarios (o TmpUsu do
    * legado), que eh ao mesmo tempo a fonte do picker de selecao e a
    * fonte de CarregarDoCursor().
    *
    * Legado:
    *   If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpUsu') < 1)
    *       =MessageBox('Favor Reinicializar o Processo!!!', 16,
    *                   'Falha na Conexao (TmpUsu)')
    *       Return .f.
    *   EndIf
    *
    * O cursor eh FECHADO antes de ser repopulado: a consulta muda com o
    * tipo de liberacao, e SQLEXEC sobre alias ainda aberto falha com
    * "uncommitted changes". USE IN fecha o alias mesmo com buffer sujo,
    * entao nao ha TABLEREVERT aqui - sem buffering ligado ele nao seria
    * inofensivo, dispararia o erro 1586 (regra #52).
    *
    * Handle invalido eh tratado ANTES do SQLEXEC: SQLEXEC com handle
    * invalido nao devolve erro, PENDURA o processo - e em modo de teste
    * o harness define gnConnHandle = 0 de proposito.
    *
    * Sem RETURN dentro de TRY/CATCH (regra #1): o resultado vai para
    * loc_lResultado e o unico RETURN do bloco fica depois do ENDTRY. Os
    * RETURN dos guards ficam FORA do TRY (nem chegam a abri-lo).
    *
    * PUBLIC (regra #51): chamado pelo Form.
    *====================================================================
    FUNCTION CarregarUsuariosAutorizados()
        LOCAL loc_lResultado, loc_cSQL, loc_cCursor, loc_nResultado, loc_oErro

        loc_cSQL = THIS.MontarQueryUsuarios()

        IF EMPTY(loc_cSQL)
            *-- Ramo sem consulta (DTVALIDA): a mensagem ja foi posta por
            *-- MontarQueryUsuarios
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
            RETURN .F.
        ENDIF

        loc_lResultado = .F.
        loc_cCursor    = THIS.this_cCursorUsuarios

        TRY
            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

            IF loc_nResultado < 1 OR !USED(loc_cCursor)
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
            ELSE
                SELECT (loc_cCursor)
                GO TOP
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * FASE 8 - Fluxo de ACAO do dialogo: conferencia da senha
    *
    * Tudo o que segue eh a transcricao do PROCEDURE Valid do campo senha
    * do SCX legado, o unico metodo da tela que DECIDE a autorizacao. A
    * Fase 7 migrou o Valid do campo USUARIO (que resolve QUEM libera);
    * aqui entra o que confere a senha e publica o resultado.
    *====================================================================

    *====================================================================
    * SenhaConferidaPelaCadastrada - Qual das DUAS senhas esta tela vai
    * conferir: a senha CADASTRADA do usuario (.T.) ou a SENHA DO DIA
    * calculada a partir do documento (.F.).
    *
    * Transcricao LITERAL do If que divide o Valid do campo senha legado:
    *
    *   If ( Not crparam.LiblCreds Or (ThisForm.Tipo # 'LIMITE' And
    *        ThisForm.tipo # 'LIBPRDZ2' ) ) And ThisForm.tipo # 'MAXIMO'
    *
    * ATENCAO - esta condicao NAO eh a negacao de this_lSenhaDoDia, e a
    * diferenca eh do LEGADO, nao da migracao. O Init legado liga o modo
    * "Senha Do Dia" com
    *
    *   If (crParam.LiblCreds And pTip = [LIMITE]) Or InList(pTip, [LIBPRDZ2], [MAXIMO])
    *
    * ou seja, LIBPRDZ2 entra no modo senha do dia SEM depender de
    * LiblCreds; mas o Valid do campo senha so sai do caminho da senha
    * cadastrada para LIBPRDZ2 QUANDO LiblCreds esta ligado. Logo, com
    * LiblCreds desligado e tipo LIBPRDZ2, a tela EXIBE o rotulo "Senha
    * Do Dia :" e ainda assim confere a senha CADASTRADA do usuario (o
    * When do campo usuario usa exatamente esta mesma expressao, e por
    * isso tambem deixa o campo editavel nesse caso). Eh uma incoerencia
    * do sistema de ORIGEM, e a regra do projeto eh TRANSCREVER a
    * condicao que cerca a validacao, nunca "consertar" nem derivar uma
    * da outra (regras #17 e #21b). Por isso este metodo recalcula a
    * expressao do Valid em vez de ler this_lSenhaDoDia, que carrega a
    * expressao do Init e governa apenas a APARENCIA da tela.
    *
    * "==" sobre o valor passado por UPPER+ALLTRIM: a comparacao nao
    * depende de SET EXACT nem do tamanho do literal.
    *
    * PUBLIC (regra #51): o Form consulta para decidir em qual campo
    * devolver o foco quando a senha conflita.
    *====================================================================
    FUNCTION SenhaConferidaPelaCadastrada()
        LOCAL loc_cTipo, loc_lCadastrada

        loc_cTipo = UPPER(ALLTRIM(THIS.this_cTipo))

        loc_lCadastrada = (!THIS.this_lLiblCreds OR ;
                (!(loc_cTipo == "LIMITE") AND !(loc_cTipo == "LIBPRDZ2"))) ;
            AND !(loc_cTipo == "MAXIMO")

        RETURN loc_lCadastrada
    ENDFUNC

    *====================================================================
    * CarregarSenhaUsuario - PRIMEIRA consulta do Valid do campo senha
    * legado: releitura de SigCdUsu so para o usuario informado, de onde
    * sai a senha que sera conferida.
    *
    * Legado:
    *   lcQuery = [select a.usuarios, a.senhas from SigCdUsu a where
    *              Not a.cAtivos='N' and a.usuarios='<usuario>' order by 1]
    *   ThisForm.poDataMgr.SQLExecute(lcQuery, 'TmpUsu')
    *
    * NAO leva o filtro de permissao da consulta do campo usuario: esta
    * consulta nao decide QUEM pode liberar (isso ja foi decidido em
    * CarregarUsuariosAutorizados), ela so busca a senha gravada. E nao
    * basta reaproveitar o this_cSenhaCadastrada que CarregarDoCursor
    * deixou: nos tipos em que o campo usuario nasce TRAVADO (o When do
    * legado), o fluxo de validacao do usuario nunca roda e a property
    * fica vazia - esta releitura eh o que faz o caminho da senha
    * cadastrada funcionar nesses tipos.
    *
    * Divergencia de FIDELIDADE deliberada: o legado NAO testa o retorno
    * do SQLExecute aqui. Falhando a consulta, o alias continuaria com o
    * conteudo ANTERIOR e a senha seria conferida contra a linha de outro
    * usuario. Sendo esta tela um gate de AUTORIZACAO, a falha eh
    * reportada e tratada como FAIL-CLOSED (devolve .F., e quem chama
    * nega a liberacao) - nunca comparada contra dado velho.
    *
    * Handle invalido eh tratado ANTES do SQLEXEC: com handle invalido o
    * SQLEXEC nao devolve erro, PENDURA o processo.
    *
    * Sem RETURN dentro de TRY/CATCH (regra #1) - os RETURN dos guards
    * ficam FORA do bloco, que nem chega a abrir.
    *
    * PUBLIC (regra #51): chamado por ConferirSenha e pelo harness.
    *====================================================================
    FUNCTION CarregarSenhaUsuario()
        LOCAL loc_lResultado, loc_cSQL, loc_cCursor, loc_nResultado, loc_cUsuario, loc_oErro

        THIS.this_cSenhaCadastrada = ""

        loc_cUsuario = ALLTRIM(NVL(THIS.this_cUsuario, ""))

        IF EMPTY(loc_cUsuario)
            THIS.this_cMensagemErro = "Usu" + CHR(225) + "rio n" + CHR(227) + "o informado"
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
            RETURN .F.
        ENDIF

        loc_lResultado = .F.
        loc_cCursor    = THIS.this_cCursorSenhaUsuario

        loc_cSQL = "SELECT a.usuarios, a.senhas FROM SigCdUsu a" + ;
            " WHERE NOT a.cativos = " + EscaparSQL("N") + ;
            " AND a.usuarios = " + EscaparSQL(loc_cUsuario) + ;
            " ORDER BY 1"

        TRY
            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

            IF loc_nResultado < 1 OR !USED(loc_cCursor)
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (TmpUsu)"
            ELSE
                SELECT (loc_cCursor)
                GO TOP

                *-- Usuario inexistente ou inativo deixa a senha vazia: eh
                *-- o sentinela CHR(254) de ConferirSenha que garante o
                *-- nao-casamento, exatamente como no legado
                IF !EOF(loc_cCursor)
                    THIS.this_cSenhaCadastrada = TratarNulo(senhas, "C")
                ENDIF

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (TmpUsu)" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * CarregarSenhaLivre - SEGUNDA consulta do Valid do campo senha
    * legado: procura uma "senha livre" ainda EM ABERTO cadastrada para
    * este par usuario + senha.
    *
    * Legado (bloco datado "Mena - 21/06/2017"):
    *   lcQuery = [select * from SigPrSnd a where a.empdopnums = '' and
    *              a.usuars='<usuario>' and a.senhads='<senha>' ]
    *   ThisForm.poDataMgr.SQLExecute(lcQuery, 'TmpSLivre')
    *
    * A senha livre eh uma AUTORIZACAO PRE-CONCEDIDA: achando linha aqui,
    * os DOIS caminhos de conferencia liberam a operacao mesmo que a
    * senha digitada nao bata com a cadastrada nem com a do dia - eh o
    * "and RECCOUNT('TmpSLivre') = 0" que acompanha as duas comparacoes.
    * Por ser a chave de um bypass, o resultado eh guardado numa property
    * (this_lSenhaLivre) em vez de reconsultado por RECCOUNT, que conta
    * tambem registro marcado para exclusao.
    *
    * empdopnums = '' eh o filtro de "em aberto": a coluna recebe a chave
    * do movimento quando a senha eh consumida (ver Atualizar). A
    * comparacao vai como o legado a escreve, com literal vazio - char no
    * SQL Server compara com blank-padding ANSI, entao isso casa a coluna
    * char(29) inteira em branco.
    *
    * ALLTRIM em usuars/senhads eh equivalente ao legado (que alltrima so
    * a senha): as duas sao colunas char comuns, nao partes de chave
    * posicional, e o blank-padding ANSI faz "= 'ABC'" casar "'ABC   '".
    *
    * Divergencia de FIDELIDADE deliberada, mesma de CarregarSenhaUsuario:
    * o legado nao testa o retorno desta consulta e em seguida chama
    * RECCOUNT('TmpSLivre') - que, com a consulta falhando e o alias
    * inexistente, estouraria. Aqui a falha devolve .F. e quem chama nega
    * a liberacao (FAIL-CLOSED); nunca assume bypass concedido.
    *
    * PUBLIC (regra #51): chamado por ConferirSenha e pelo harness.
    *====================================================================
    FUNCTION CarregarSenhaLivre()
        LOCAL loc_lResultado, loc_cSQL, loc_cCursor, loc_nResultado, loc_oErro
        LOCAL loc_cUsuario, loc_cSenha

        THIS.this_lSenhaLivre      = .F.
        THIS.this_cChaveSenhaLivre = ""

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
            RETURN .F.
        ENDIF

        loc_lResultado = .F.
        loc_cCursor    = THIS.this_cCursorSenhaLivre
        loc_cUsuario   = ALLTRIM(NVL(THIS.this_cUsuario, ""))
        loc_cSenha     = ALLTRIM(NVL(THIS.this_cSenha, ""))

        loc_cSQL = "SELECT a.cidchaves, a.usuars, a.senhads, a.empdopnums" + ;
            " FROM SigPrSnd a" + ;
            " WHERE a.empdopnums = " + EscaparSQL("") + ;
            " AND a.usuars = " + EscaparSQL(loc_cUsuario) + ;
            " AND a.senhads = " + EscaparSQL(loc_cSenha)

        TRY
            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

            IF loc_nResultado < 1 OR !USED(loc_cCursor)
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (TmpSLivre)"
            ELSE
                SELECT (loc_cCursor)
                GO TOP

                IF !EOF(loc_cCursor)
                    THIS.this_lSenhaLivre      = .T.
                    THIS.this_cChaveSenhaLivre = ALLTRIM(TratarNulo(cidchaves, "C"))
                ENDIF

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (TmpSLivre)" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * CarregarMovimento - Le o cursor do MOVIMENTO corrente, que pertence
    * ao form CHAMADOR (o "If Used([TprMvCab])" do legado).
    *
    * Legado, nos dois pontos em que usa o movimento:
    *   lcEDN = TprMvCab.Emps + TprMvCab.Dopes + Str(TprMvCab.Numes,6)
    *   fGravarLog('T', TprMvCab.Dopes, ..., TprMvCab.Emps + '-' + ...)
    *
    * O cursor NAO eh aberto nem fechado aqui: ele eh do chamador, e o
    * legado apenas testa se esta aberto. Ausente (a tela pode ser
    * chamada de contexto sem movimento - LIBTITULO eh o caso explicito
    * no proprio legado), devolve .F. e o fluxo segue sem baixa de senha
    * livre e sem log de movimento, que eh o que o legado faz quando o
    * alias nao existe.
    *
    * As colunas sao testadas com TYPE() antes de lidas: o cursor eh
    * montado por OUTRO form e nada garante que ele traga as tres colunas
    * que o legado le. Coluna ausente derrubaria o gate inteiro em
    * runtime ("Variable not found") em vez de so dispensar o log.
    *
    * NAO aplica ALLTRIM nos valores: eles alimentam EmpDopNums, que eh
    * chave POSICIONAL char(29) (regra #42) - o padding FAZ parte da
    * chave, e quem a monta eh MontarEmpDopNums, com PADR explicito.
    *
    * PUBLIC (regra #51): chamado por ConferirSenha e pelo harness.
    *====================================================================
    FUNCTION CarregarMovimento()
        LOCAL loc_cCursor, loc_lResultado

        THIS.this_lMovimentoCarregado = .F.
        THIS.this_cEmpsMov            = ""
        THIS.this_cDopesMov           = ""
        THIS.this_nNumesMov           = 0

        loc_cCursor = ALLTRIM(NVL(THIS.this_cCursorMovimento, ""))

        IF EMPTY(loc_cCursor) OR !USED(loc_cCursor)
            RETURN .F.
        ENDIF

        IF TYPE(loc_cCursor + ".emps") == "U" OR ;
                TYPE(loc_cCursor + ".dopes") == "U" OR ;
                TYPE(loc_cCursor + ".numes") == "U"
            RETURN .F.
        ENDIF

        SELECT (loc_cCursor)

        IF EOF(loc_cCursor)
            RETURN .F.
        ENDIF

        THIS.this_cEmpsMov  = TratarNulo(emps, "C")
        THIS.this_cDopesMov = TratarNulo(dopes, "C")
        THIS.this_nNumesMov = TratarNulo(numes, 0)

        THIS.this_lMovimentoCarregado = .T.
        loc_lResultado                = .T.

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * CalcularSenhaDoDia - Caminho ELSE do Valid do campo senha legado: a
    * senha conferida nao eh a cadastrada do usuario, eh uma senha
    * CALCULADA a partir do documento.
    *
    * Legado:
    *   lnNum = 0
    *   If CrParac.SenhDEmps
    *       lcSql = [Select nemps From SigCdEmp Where CEmps = '<Empresa>']
    *       lnNum = CrEmp.nEmps
    *       lcSql = [Select nfpags From SigOpFp Where Fpags = '<Fpagto>']
    *       lnNum = lnNum + CrFPagto.NfPags + ( ThisForm.Valfpag * 100 )
    *   Endif
    *   lcSenha = fGerPswDiario( ThisForm.NroDoc, ThisForm.DatDoc, lnNum )
    *
    * A formula de lnNum eh REGRA DE NEGOCIO e esta transcrita como no
    * dump, na mesma ordem e com o mesmo fator 100 (regra #17): ela eh a
    * SEMENTE da senha, e qualquer reescrita produz senha diferente - sem
    * erro na tela, apenas recusando todo mundo.
    *
    * SigCdPac.senhdemps desligado deixa lnNum = 0 e a senha passa a
    * depender so de documento e data. Eh o legado, nao atalho.
    *
    * fGerPswDiario() NAO foi portada para o projeto novo e a chamada eh
    * transcrita LITERALMENTE, deixando estourar no TRY de ConferirSenha.
    * PROIBIDO criar stub: senha do dia devolvida por stub autoriza quem
    * nao devia (ou recusa todo mundo), nos dois casos EM SILENCIO -
    * funcao ausente que devolve VALOR DE CALCULO fica AUSENTE, para o
    * erro aparecer alto (regra #27).
    *
    * O legado le CrEmp.nEmps / CrFPagto.NfPags sem conferir se a
    * consulta trouxe linha; aqui a linha ausente contribui com ZERO (o
    * EOF eh testado), o que nao muda o valor quando a linha existe e
    * evita derrubar o gate com "Variable not found" quando nao existe.
    *
    * ConverterParaData na data: this_dDatDoc pode chegar como DATE (o
    * default do BO) ou como DATETIME (parametro do chamador), e TTOD so
    * aceita DATETIME (regra #16) - a normalizacao vale tambem para o
    * argumento entregue a funcao legado.
    *
    * Sem RETURN dentro de TRY/CATCH (regra #1): os RETURN de falha ficam
    * fora de qualquer bloco TRY - quem abre o TRY eh ConferirSenha.
    *
    * PUBLIC (regra #51): chamado por ConferirSenha e pelo harness.
    *====================================================================
    FUNCTION CalcularSenhaDoDia()
        LOCAL loc_nNum, loc_cSQL, loc_cCursor, loc_nResultado

        THIS.this_cSenhaDoDia = ""
        THIS.this_nNumEmpresa = 0
        THIS.this_nNumFpagto  = 0
        THIS.this_nNumeroBase = 0

        loc_nNum = 0

        IF THIS.this_lSenhDEmps
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                RETURN ""
            ENDIF

            *-- SigCdEmp.nemps numeric(3,0) pela empresa informada.
            *-- A coluna de empresa de SigCdEmp eh "cemps" COM o C -
            *-- conferido no schema canonico, nunca deduzido do prefixo
            *-- da tabela (regra #48). O legado escreve CEmps.
            loc_cCursor = THIS.this_cCursorEmpresa

            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF

            loc_cSQL = "SELECT nemps FROM SigCdEmp WHERE CEmps = " + ;
                EscaparSQL(ALLTRIM(NVL(THIS.this_cEmpresa, "")))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

            IF loc_nResultado < 1 OR !USED(loc_cCursor)
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (CrEmp)"
                RETURN ""
            ENDIF

            SELECT (loc_cCursor)
            GO TOP

            IF !EOF(loc_cCursor)
                THIS.this_nNumEmpresa = TratarNulo(nemps, 0)
            ENDIF

            loc_nNum = THIS.this_nNumEmpresa

            *-- SigOpFp.nfpags numeric(2,0) pela forma de pagamento
            loc_cCursor = THIS.this_cCursorFpagto

            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF

            loc_cSQL = "SELECT nfpags FROM SigOpFp WHERE Fpags = " + ;
                EscaparSQL(ALLTRIM(NVL(THIS.this_cFpagto, "")))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

            IF loc_nResultado < 1 OR !USED(loc_cCursor)
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (CrfPagto)"
                RETURN ""
            ENDIF

            SELECT (loc_cCursor)
            GO TOP

            IF !EOF(loc_cCursor)
                THIS.this_nNumFpagto = TratarNulo(nfpags, 0)
            ENDIF

            *-- Legado: lnNum = lnNum + CrFPagto.NfPags + (ThisForm.Valfpag * 100)
            loc_nNum = loc_nNum + THIS.this_nNumFpagto + (THIS.this_nValFpag * 100)
        ENDIF

        THIS.this_nNumeroBase = loc_nNum

        *-- fGerPswDiario AUSENTE: chamada literal. Estoura no TRY de
        *-- ConferirSenha e vira mensagem visivel (sem stub - regra #27)
        THIS.this_cSenhaDoDia = fGerPswDiario(THIS.this_nNroDoc, ;
            ConverterParaData(THIS.this_dDatDoc), loc_nNum)

        IF VARTYPE(THIS.this_cSenhaDoDia) != "C"
            THIS.this_cSenhaDoDia = ""
        ENDIF

        RETURN THIS.this_cSenhaDoDia
    ENDFUNC

    *====================================================================
    * GravarLogLiberacao - Registro da liberacao concedida, do ramo de
    * SUCESSO do Valid do campo senha legado:
    *
    *   If Tipo = 'LIBPRDZ' Or 'LIBPRDZ2' Or 'LIBPESO' Or 'LIBQTMIN'
    *       (nada)
    *   Else
    *       If Tipo = 'LIBTITULO'
    *           =fGravarLog('T', 'SigPgTit', Tipo, Frase.Caption, Usuar)
    *       Else
    *           If Used('TprMvCab')
    *               =fGravarLog('T', TprMvCab.Dopes, Tipo,
    *                   TprMvCab.Emps + '-' + AllTrim(TprMvCab.Dopes) + '-' +
    *                   AllTrim(Str(TprMvCab.Numes,6)) +
    *                   Iif(Tipo='LIBERAFPG','('+Alltrim(Frase.Caption)+')',' '),
    *                   Thisform.UsuLibs)
    *           Endif
    *       Endif
    *   Endif
    *
    * Tres fidelidades que o ramo-a-ramo exige:
    *   - os QUATRO tipos de producao NAO geram log nenhum (o ramo THEN do
    *     legado eh vazio - o trabalho todo esta no ELSE);
    *   - LIBTITULO loga com programa FIXO 'SigPgTit' e com o usuario
    *     LOGADO (Usuar), nao com o liberador;
    *   - os demais tipos logam SO quando existe movimento aberto, com o
    *     usuario LIBERADOR (UsuLibs), e so LIBERAFPG acrescenta a frase
    *     entre parenteses - os outros acrescentam UM ESPACO.
    *
    * fGravarLog() EXISTE no projeto como wrapper no-op documentado
    * (utils\fgravarlog.prg): o de-para dos 5 argumentos para dbo.SigOpLog
    * nao veio no acervo, e gravar auditoria de producao com mapeamento
    * adivinhado eh o que a regra #17 proibe. O retorno eh descartado no
    * legado tambem ("=fGravarLog(...)"), entao a chamada nao altera o
    * fluxo.
    *
    * O log NAO eh condicao da autorizacao: falha aqui nao pode derrubar
    * uma liberacao ja conferida, por isso o TRY/CATCH proprio e a
    * mensagem que diz que a liberacao VALEU e so o log faltou.
    *
    * Sem RETURN dentro de TRY/CATCH (regra #1).
    *
    * PUBLIC (regra #51): chamado por ConferirSenha e pelo harness.
    *====================================================================
    FUNCTION GravarLogLiberacao()
        LOCAL loc_cTipo, loc_cFrase, loc_cUsuarioLogado, loc_cTransacao
        LOCAL loc_lResultado, loc_oErro

        loc_lResultado = .F.
        loc_cTipo      = UPPER(ALLTRIM(THIS.this_cTipo))
        loc_cFrase     = NVL(THIS.this_cFrase, "")

        IF VARTYPE(loc_cFrase) != "C"
            loc_cFrase = ""
        ENDIF

        *-- "Usuar" do legado (usuario logado no sistema)
        loc_cUsuarioLogado = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "")

        *-- Ramo THEN vazio do legado: producao nao gera log
        IF INLIST(loc_cTipo, "LIBPRDZ", "LIBPRDZ2", "LIBPESO", "LIBQTMIN")
            RETURN .F.
        ENDIF

        TRY
            IF loc_cTipo == "LIBTITULO"
                = fGravarLog("T", "SigPgTit", THIS.this_cTipo, loc_cFrase, loc_cUsuarioLogado)
                loc_lResultado = .T.
            ELSE
                IF THIS.this_lMovimentoCarregado
                    loc_cTransacao = PADR(THIS.this_cEmpsMov, 3) + "-" + ;
                        ALLTRIM(THIS.this_cDopesMov) + "-" + ;
                        ALLTRIM(STR(THIS.this_nNumesMov, 6)) + ;
                        IIF(loc_cTipo == "LIBERAFPG", "(" + ALLTRIM(loc_cFrase) + ")", " ")

                    = fGravarLog("T", ALLTRIM(THIS.this_cDopesMov), THIS.this_cTipo, ;
                        loc_cTransacao, THIS.this_cUsuLibs)

                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            *-- Log eh efeito COLATERAL da liberacao, nunca condicao dela:
            *-- a falha fica registrada na mensagem do BO e o gate segue
            *-- com o resultado que a conferencia da senha ja produziu
            THIS.this_cMensagemErro = "Libera" + CHR(231) + CHR(227) + ;
                "o concedida, mas o log n" + CHR(227) + "o pode ser gravado:" + CHR(13) + ;
                loc_oErro.Message
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * ConferirSenha - Metodo de ACAO desta tela: transcricao completa do
    * Valid do campo senha legado. Eh ele que DECIDE se a operacao foi
    * autorizada.
    *
    * Ordem do legado, preservada:
    *   senha = Chr(254)                            <- sentinela
    *   1. releitura de SigCdUsu     -> CarregarSenhaUsuario()
    *   2. consulta da senha livre   -> CarregarSenhaLivre()
    *   3. If Used([TprMvCab]) -> Update SigPrSnd + Commit
    *                                -> CarregarMovimento() + Atualizar()
    *   4. If Used('TmpUsu') -> senha = fCriptografar(TmpUsu.senhas)
    *   5. Thisform.zsen = .F.                      <- FAIL-CLOSED
    *   6. caminho da senha CADASTRADA ou da senha DO DIA
    *
    * O sentinela CHR(254) do legado eh o que garante o nao-casamento
    * quando a releitura nao trouxe linha (usuario inexistente/inativo):
    * nenhum valor digitavel no campo, cujo InputMask eh "!!!!!!!!!!",
    * produz esse caractere. Ele eh TRANSCRITO, nao substituido por
    * string vazia - string vazia casaria com senha cadastrada vazia e
    * autorizaria quem nao devia.
    *
    * A COMPARACAO de cada caminho eh transcrita LITERALMENTE, inclusive
    * a FORMA de comparar, porque elas sao DIFERENTES entre si (regra
    * #17):
    *   cadastrada: (IsEmpty(This.Value) Or Padr(this.value,10) # Padr(senha,10))
    *               -> exige valor NAO vazio e compara padded a 10
    *   senha dia : (alltrim(This.Value) # lcSenha)
    *               -> compara sem padding e NAO testa valor vazio
    *
    * E as duas terminam com "and RECCOUNT('TmpSLivre') = 0": a senha
    * livre em aberto (this_lSenhaLivre) LIBERA mesmo com a senha
    * digitada divergindo. Esse "ou" eh parte da regra, nao atalho.
    *
    * Passo 3 CONTINUA mesmo falhando, por fidelidade: no legado a falha
    * do Commit exibe a mensagem e grava num "llOks" que NUNCA eh lido
    * depois, entao o fluxo segue para a conferencia da senha. Quem chama
    * recebe a mensagem em this_cMensagemErro e decide se a exibe.
    *
    * fCriptografar() e fGerPswDiario() NAO foram portadas (achado (1) do
    * cabecalho). As chamadas sao LITERAIS e ficam DENTRO do TRY: a
    * ausencia estoura, vira this_cMensagemErro e a liberacao eh NEGADA -
    * o gate falha FECHADO, e a falta da funcao fica visivel em vez de
    * virar "senha errada".
    *
    * Resultado publicado em tres propriedades:
    *   this_lZSen           - autorizou
    *   this_lRedigitarSenha - a senha conflitou; quem chama pergunta ao
    *                          usuario se ele quer digitar de novo (eh o
    *                          "Deseja digitar novamente ? (S/N)" do
    *                          legado, que eh decisao de TELA e por isso
    *                          nao mora aqui)
    *   this_cUsuLibs        - quem liberou (ou, no caminho da senha do
    *                          dia, a senha gerada - "Thisform.usulibs =
    *                          lcSenha" do legado)
    *
    * Sem RETURN dentro de TRY/CATCH (regra #1): o desfecho vai para as
    * flags e o unico RETURN fica depois do ENDTRY.
    *
    * PUBLIC (regra #51): eh o metodo de acao chamado pelo Form.
    *====================================================================
    FUNCTION ConferirSenha(par_cSenhaDigitada)
        LOCAL loc_cDigitada, loc_cSenha, loc_cSenhaDia, loc_lCadastrada
        LOCAL loc_lProsseguir, loc_lConfere, loc_cErroBaixa, loc_oErro

        *-- Passo 5 do legado, antecipado: o estado nasce NEGADO e so a
        *-- conferencia bem sucedida o inverte
        THIS.this_lZSen           = .F.
        THIS.this_lRedigitarSenha = .F.
        THIS.this_cMensagemErro   = ""

        loc_cDigitada = NVL(par_cSenhaDigitada, "")

        IF VARTYPE(loc_cDigitada) != "C"
            loc_cDigitada = ""
        ENDIF

        THIS.this_cSenha = loc_cDigitada

        *-- "senha = Chr(254)" do legado
        loc_cSenha      = CHR(254)
        loc_cSenhaDia   = ""
        loc_cErroBaixa  = ""
        loc_lConfere    = .F.
        loc_lProsseguir = .T.

        *-- Passo 1: releitura da senha gravada para o usuario informado
        IF !THIS.CarregarSenhaUsuario()
            loc_lProsseguir = .F.
        ENDIF

        *-- Passo 2: senha livre em aberto para este usuario + senha
        IF loc_lProsseguir
            IF !THIS.CarregarSenhaLivre()
                loc_lProsseguir = .F.
            ENDIF
        ENDIF

        IF loc_lProsseguir
            *-- Passo 3: baixa da senha livre no movimento corrente.
            *-- Atualizar() ja devolve .T. quando nao ha o que gravar
            *-- (sem senha livre ou sem movimento aberto), reproduzindo o
            *-- "If Used([TprMvCab])" do legado. A falha NAO interrompe o
            *-- fluxo (ver nota acima): a mensagem eh guardada e
            *-- republicada depois, para nao ser sobrescrita pelos
            *-- metodos seguintes.
            THIS.CarregarMovimento()

            IF !THIS.Atualizar()
                loc_cErroBaixa = NVL(THIS.this_cMensagemErro, "")
            ENDIF

            loc_lCadastrada = THIS.SenhaConferidaPelaCadastrada()

            TRY
                IF loc_lCadastrada
                    *-- Passo 4: senha = fCriptografar(TmpUsu.senhas)
                    IF USED(THIS.this_cCursorSenhaUsuario)
                        loc_cSenha = fCriptografar(THIS.this_cSenhaCadastrada)

                        IF VARTYPE(loc_cSenha) != "C"
                            loc_cSenha = CHR(254)
                        ENDIF
                    ENDIF

                    *-- Legado: If (IsEmpty(This.Value) Or
                    *--             Padr(this.value,10) # Padr(senha,10))
                    *--            and RECCOUNT('TmpSLivre') = 0 -> conflito
                    loc_lConfere = THIS.this_lSenhaLivre OR ;
                        (!EMPTY(loc_cDigitada) AND ;
                        PADR(loc_cDigitada, 10) == PADR(loc_cSenha, 10))
                ELSE
                    *-- Caminho ELSE do legado: senha DO DIA
                    loc_cSenhaDia = THIS.CalcularSenhaDoDia()

                    *-- Legado: If alltrim(This.Value) # lcSenha
                    *--            and RECCOUNT('TmpSLivre') = 0 -> conflito
                    loc_lConfere = THIS.this_lSenhaLivre OR ;
                        (ALLTRIM(loc_cDigitada) == ALLTRIM(loc_cSenhaDia))
                ENDIF

                IF loc_lConfere
                    THIS.this_lZSen = .T.

                    IF loc_lCadastrada
                        *-- Ramo de sucesso da senha cadastrada: o legado
                        *-- grava o log ANTES de liberar a tela
                        THIS.GravarLogLiberacao()
                    ELSE
                        *-- Legado: Thisform.usulibs = lcSenha
                        THIS.this_cUsuLibs = loc_cSenhaDia
                    ENDIF
                ELSE
                    *-- Conflito: quem chama pergunta ao usuario se ele
                    *-- quer digitar de novo (o messagebox eh decisao de
                    *-- tela e por isso fica no Form)
                    THIS.this_lRedigitarSenha = .T.
                ENDIF
            CATCH TO loc_oErro
                *-- fCriptografar / fGerPswDiario ausentes caem aqui: o
                *-- gate falha FECHADO e a causa real fica visivel, em vez
                *-- de o usuario ver "senha conflitante"
                THIS.this_lZSen           = .F.
                THIS.this_lRedigitarSenha = .F.
                THIS.this_cMensagemErro   = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                    "vel conferir a senha:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure
            ENDTRY

            *-- Falha da baixa da senha livre eh reportada DEPOIS, para
            *-- nao perder a mensagem nem mascarar erro mais grave
            IF !EMPTY(loc_cErroBaixa) AND EMPTY(ALLTRIM(NVL(THIS.this_cMensagemErro, "")))
                THIS.this_cMensagemErro = loc_cErroBaixa
            ENDIF
        ENDIF

        RETURN THIS.this_lZSen
    ENDFUNC

ENDDEFINE
