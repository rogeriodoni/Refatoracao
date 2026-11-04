*====================================================================
* sigopcksBO.prg
*
* Business Object para SIGOPCKS - Validacao de Acesso
*
* Dialogo MODAL de AUTORIZACAO do legado Fortyus: recebe um TIPO de
* liberacao, pede usuario + senha e devolve ao chamador se a operacao
* foi autorizada. O tipo determina (a) o texto exibido na tela,
* (b) qual permissao de cargo/usuario sera exigida e (c) se a senha
* conferida eh a senha CADASTRADA do usuario ou a SENHA DO DIA
* calculada a partir do documento.
*
* Tabela principal : SigCdUsu (usuario que autoriza) - chave usuarios
* Tabelas de apoio : SigCdCrg (permissoes do cargo)
*                    SigCdPam (liblcreds) / SigCdPac (senhdemps)
*                    SigCdEmp (nemps) / SigOpFp (nfpags)
*
* Herda de: BusinessBase
*
* Somente leitura: o legado nao executa Insert/Update/Delete em tabela
* alguma - o unico registro gravado eh o log de liberacao, feito pela
* funcao global fGravarLog do proprio legado. Por isso Inserir(),
* Atualizar() e ExecutarExclusao() nao sao sobrescritos aqui: o
* comportamento padrao herdado de BusinessBase ja eh o correto.
*
* Resultado: this_lZSen (autorizou) + this_cUsuLibs (quem autorizou).
* ObterResultadoSaida() equivale ao PROCEDURE Unload legado e eh a fonte
* UNICA do contrato de retorno lido pelo form chamador.
*====================================================================

DEFINE CLASS sigopcksBO AS BusinessBase

    *----------------------------------------------------------------
    * 1) PARAMETROS DE ENTRADA
    *    Init legado: LParameters _Tipo, _Titulo, _Titulo2, _Documento,
    *    _Data, _Empresa, _Fpagto, _Valor
    *----------------------------------------------------------------

    *-- _Tipo / ThisForm.Tipo - chave que seleciona a regra de liberacao.
    *-- Valores do DO CASE legado: DTENTREGA, CHDEVOLVIDO, LIMITE,
    *-- ALTERAIMPOSTO, CANCITEM, LIBFPAG, LIBPRDZ, LIBPRDZ2, LIBPESO,
    *-- SDINSUF, MAXIMO, DTVALIDA, LIBTITULO, LIBERAFPG, LIBOPE,
    *-- LIBQTMIN, LIBLIMITADOR, MOVESTOQUE, VALIDACESSO
    this_cTipo = ""

    *-- _Titulo / _Titulo2 - textos crus vindos do chamador. O DO CASE
    *-- legado combina os dois de forma DIFERENTE em cada tipo, por
    *-- isso os dois sao guardados crus e a combinacao fica derivada
    this_cTitulo  = ""
    this_cTitulo2 = ""

    *-- _Documento / ThisForm.NroDoc - numero do documento; entra no
    *-- calculo da senha do dia
    this_nNroDoc = 0

    *-- _Data / ThisForm.DatDoc - data do documento; entra no calculo
    *-- da senha do dia. Init legado: If Type("_Data")#"D" -> Date()
    this_dDatDoc = {}

    *-- _Empresa / ThisForm.Empresa -> SigCdEmp.cemps char(3)
    this_cEmpresa = ""

    *-- _Fpagto / ThisForm.Fpagto -> SigOpFp.fpags char(12)
    this_cFpagto = ""

    *-- _Valor / ThisForm.ValFpag - valor da condicao de pagamento
    this_nValFpag = 0

    *----------------------------------------------------------------
    * 2) TEXTOS DERIVADOS DO TIPO
    *    No legado o DO CASE do Init escreve direto em This.Caption e
    *    em This.Frase.Caption. Aqui a derivacao mora no BO e o Form
    *    apenas espelha, para o texto ter fonte UNICA
    *----------------------------------------------------------------
    this_cCaption = ""
    this_cFrase   = ""

    *----------------------------------------------------------------
    * 3) FLAGS DE TIPO DE AUTORIZACAO
    *    As 12 flags logicas do legado (ClassInfo do SCX). Cada uma
    *    seleciona um WHERE diferente no Valid do campo usuario, por
    *    isso sao propriedades distintas e nao um unico codigo
    *----------------------------------------------------------------

    *-- ThisForm.Financ - exige SigCdCrg.limites = 'S'
    *-- (CHDEVOLVIDO, LIMITE, ALTERAIMPOSTO, MAXIMO)
    this_lFinanc = .F.

    *-- ThisForm.CancItem - exige SigCdCrg.cancitens = 'S'
    this_lCancItem = .F.

    *-- ThisForm.LibFpag - exige SigCdCrg.libfpags = 'S'
    this_lLibFpag = .F.

    *-- ThisForm.LibFpag2 - LIBERAFPG; exige SigCdCrg.libfpgs = 'S'
    this_lLibFpag2 = .F.

    *-- ThisForm.LibProducao - LIBPRDZ/LIBPRDZ2/LIBPESO; exige
    *-- SigCdUsu.libpess = 'S' quando o tipo eh LIBPESO, senao
    *-- SigCdUsu.libprods = 'S'
    this_lLibProducao = .F.

    *-- ThisForm.Saldoestoque - SDINSUF; exige SigCdCrg.libsdins = 'S'
    this_lSaldoEstoque = .F.

    *-- ThisForm.LibValida - DTVALIDA; exige SigCdUsu.libvopes = 'S'
    this_lLibValida = .F.

    *-- ThisForm.LiberaTitulo - LIBTITULO
    this_lLiberaTitulo = .F.

    *-- ThisForm.LibOpe - exige SigCdCrg.libopes = 'S'
    this_lLibOpe = .F.

    *-- ThisForm.LibQtMin - exige SigCdUsu.libqtmins = 'S'
    this_lLibQtMin = .F.

    *-- ThisForm.LibLimitador - exige SigCdUsu.liblmpss = 'S'
    this_lLibLimitador = .F.

    *-- ThisForm.MovEstoque - MOVESTOQUE e VALIDACESSO; basta usuario
    *-- ativo com senha cadastrada
    this_lMovEstoque = .F.

    *----------------------------------------------------------------
    * 4) CREDENCIAIS DIGITADAS NA TELA
    *----------------------------------------------------------------

    *-- usuario.Value -> SigCdUsu.usuarios char(10)
    this_cUsuario = ""

    *-- senha.Value - valor transitorio, nunca persistido
    this_cSenha = ""

    *----------------------------------------------------------------
    * 5) DADOS DO USUARIO AUTENTICADO (lidos de SigCdUsu / SigCdCrg)
    *----------------------------------------------------------------

    *-- SigCdUsu.senhas char(10) - senha cadastrada, gravada cifrada
    this_cSenhaCadastrada = ""

    *-- SigCdUsu.ccargs char(10) - cargo, que liga em SigCdCrg
    this_cCargoUsuario = ""

    *-- SigCdUsu.cativos char(1) - 'N' marca usuario inativo; todo
    *-- WHERE do legado comeca com Not a.cAtivos = 'N'
    this_cUsuarioAtivo = ""

    *----------------------------------------------------------------
    * 6) PARAMETROS DO SISTEMA
    *    Init legado: CursorQuery('SigCdPam','CrParam',...,[LiblCreds])
    *                 CursorQuery('SigCdPac','CrParac',...,[SenhDEmps])
    *    As duas colunas sao bit NOT NULL no schema e chegam ao VFP ora
    *    como Logico ora como Numerico conforme o driver ODBC, por isso
    *    a leitura delas exige VARTYPE antes de comparar
    *----------------------------------------------------------------

    *-- SigCdPam.liblcreds bit - sistema usa credencial/senha do dia
    this_lLiblCreds = .F.

    *-- SigCdPac.senhdemps bit - senha do dia leva empresa e forma de
    *-- pagamento no numero base
    this_lSenhDEmps = .F.

    *----------------------------------------------------------------
    * 7) MODO SENHA DO DIA
    *    ATENCAO: no legado existem DUAS expressoes parecidas, mas NAO
    *    algebricamente iguais - rule #17 (transcrever, nao reescrever)
    *    exige manter as duas separadas, sem unificar:
    *
    *    (a) Init - so decide o PREENCHIMENTO visual (usuario.Value =
    *        Usuar + troca o Say3 para "Senha Do Dia :"):
    *          ( crParam.LiblCreds And Tipo = 'LIMITE' )
    *            Or Tipo = 'LIBPRDZ2' Or Tipo = 'MAXIMO'
    *        (metodo DevePreencherUsuarioLogado)
    *
    *    (b) When do campo usuario E Valid do campo senha compartilham
    *        a MESMA expressao (texto identico nos dois pontos):
    *          ( !crParam.LiblCreds Or (Tipo # 'LIMITE' And Tipo # 'LIBPRDZ2') )
    *            And Tipo # 'MAXIMO'
    *        Quando essa expressao eh FALSA, o Valid da senha entra no
    *        ramo "senha do dia" (compara com fGerPswDiario em vez da
    *        senha cadastrada). this_lSenhaDoDia guarda a NEGACAO desta
    *        expressao (metodo EstaEmModoSenhaDoDia)
    *
    *    Com Tipo = 'LIBPRDZ2' e LiblCreds = .F., (a) vale (pre-preenche
    *    a tela) mas (b) NAO entra no ramo senha-do-dia - a tela mostra
    *    o rotulo "Senha Do Dia" mas o Valid ainda confere contra a
    *    senha CADASTRADA. Comportamento do fonte legado, nao bug da
    *    migracao - ver SigOpCks_Erro2_findings (fase 1 retry)
    *----------------------------------------------------------------
    this_lSenhaDoDia = .F.

    *-- Senha do dia calculada (fGerPswDiario do legado)
    this_cSenhaDoDia = ""

    *-- lnNum do legado: SigCdEmp.nemps + SigOpFp.nfpags +
    *-- ( ValFpag * 100 ), somado so quando SenhDEmps esta ligado
    this_nNumeroBase = 0

    *-- SigCdEmp.nemps numeric(3,0)
    this_nNumEmpresa = 0

    *-- SigOpFp.nfpags numeric(2,0)
    this_nNumFpagto = 0

    *----------------------------------------------------------------
    * 8) RESULTADO DO DIALOGO
    *----------------------------------------------------------------

    *-- ThisForm.zsen - .T. somente quando a autorizacao foi concedida
    this_lZSen = .F.

    *-- ThisForm.usulibs - usuario que liberou (ou a propria senha do
    *-- dia, no ramo de senha do dia do legado)
    this_cUsuLibs = ""

    *-- Retorno do Unload legado:
    *-- Return Iif(This.ZSen, [*], [ ]) + This.UsuLibs
    this_cRetorno = ""

    *-- Campo que recebe o foco apos recusa: "USUARIO" ou "SENHA"
    this_cCampoFoco = ""

    *====================================================================
    * Init - Inicializa Business Object
    *
    * Define tabela e chave e normaliza o valor inicial de cada
    * propriedade. NAO executa SQL: Init de BO que devolve .F. destroi o
    * objeto, e dai o Form aborta o proprio Init e a tela nunca abre -
    * nem em validacao de UI, onde gnConnHandle vale -1 e todo SQLEXEC
    * estoura. A carga dos parametros do sistema eh feita sob demanda
    * pelos metodos que precisam deles.
    *
    * Sem RETURN dentro de TRY/CATCH: o resultado vai para a flag
    * loc_lSucesso e o unico RETURN fica DEPOIS do ENDTRY.
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigCdUsu"
            THIS.this_cCampoChave = "usuarios"

            *-- Equivalente ao bloco de normalizacao do Init legado
            *-- (If Type("_Data")#"D" -> _Data = Date(), e os demais),
            *-- para o BO nascer com valor valido em todo campo
            THIS.this_dDatDoc = DATE()

            THIS.this_cTipo    = ""
            THIS.this_cTitulo  = ""
            THIS.this_cTitulo2 = ""
            THIS.this_nNroDoc  = 0
            THIS.this_cEmpresa = " "
            THIS.this_cFpagto  = " "
            THIS.this_nValFpag = 0

            THIS.this_cCaption = ""
            THIS.this_cFrase   = ""

            *-- As 12 flags de tipo nascem desligadas, como no Init
            *-- legado, que zera todas antes de entrar no DO CASE
            THIS.this_lFinanc       = .F.
            THIS.this_lCancItem     = .F.
            THIS.this_lLibFpag      = .F.
            THIS.this_lLibFpag2     = .F.
            THIS.this_lLibProducao  = .F.
            THIS.this_lSaldoEstoque = .F.
            THIS.this_lLibValida    = .F.
            THIS.this_lLiberaTitulo = .F.
            THIS.this_lLibOpe       = .F.
            THIS.this_lLibQtMin     = .F.
            THIS.this_lLibLimitador = .F.
            THIS.this_lMovEstoque   = .F.

            THIS.this_cUsuario = ""
            THIS.this_cSenha   = ""

            THIS.this_cSenhaCadastrada = ""
            THIS.this_cCargoUsuario    = ""
            THIS.this_cUsuarioAtivo    = ""

            THIS.this_lLiblCreds = .F.
            THIS.this_lSenhDEmps = .F.

            THIS.this_lSenhaDoDia = .F.
            THIS.this_cSenhaDoDia = ""
            THIS.this_nNumeroBase = 0
            THIS.this_nNumEmpresa = 0
            THIS.this_nNumFpagto  = 0

            *-- FAIL-CLOSED: este dialogo eh gate de AUTORIZACAO, entao
            *-- o estado inicial eh sempre "nao autorizado". Somente a
            *-- conferencia bem sucedida da senha liga this_lZSen
            THIS.this_lZSen    = .F.
            THIS.this_cUsuLibs = ""
            THIS.this_cRetorno = ""

            THIS.this_cCampoFoco = "USUARIO"

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inicializar sigopcksBO:" + CHR(13) + ;
                loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - hook de BusinessBase.RegistrarAuditoria. A
    * "entidade" deste dialogo eh o USUARIO que concede a liberacao, por
    * isso a chave eh this_cUsuario (nunca chamado de fora - regra #51)
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cUsuario)
    ENDPROC

    *====================================================================
    * CarregarDoCursor - mapeia o cursor de usuarios autorizados
    * (cursor_4c_Usuar, equivalente ao TmpUsu do Valid legado) para as
    * propriedades do usuario selecionado.
    *
    * PUBLIC - CarregarDoCursor eh PUBLIC em BusinessBase e pode ser
    * chamado pelo Form de fora (regra #51); PROTECTED em qualquer nivel
    * da heranca faz a chamada externa estourar "Property not found".
    *
    * SELECT (par_cAliasCursor) antes de acessar os campos - a sintaxe
    * campo nao existe em VFP9. Existencia de coluna conferida
    * com TYPE(), porque PEMSTATUS exige OBJETO no 1o argumento.
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias

        loc_lSucesso = .F.
        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C", ALLTRIM(par_cAliasCursor), "")

        TRY
            IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
                SELECT (loc_cAlias)

                IF !EOF(loc_cAlias)
                    *-- usuarios char(10) - PK de SigCdUsu
                    IF TYPE(loc_cAlias + ".usuarios") == "C"
                        THIS.this_cUsuario = TratarNulo(usuarios, "")
                    ENDIF

                    *-- senhas char(10) - senha cadastrada, cifrada
                    IF TYPE(loc_cAlias + ".senhas") == "C"
                        THIS.this_cSenhaCadastrada = TratarNulo(senhas, "")
                    ENDIF

                    *-- ccargs char(10) - cargo do usuario
                    IF TYPE(loc_cAlias + ".ccargs") == "C"
                        THIS.this_cCargoUsuario = TratarNulo(ccargs, "")
                    ENDIF

                    *-- cativos char(1) - 'N' marca usuario inativo
                    IF TYPE(loc_cAlias + ".cativos") == "C"
                        THIS.this_cUsuarioAtivo = TratarNulo(cativos, "")
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao ler os dados do usuario:" + CHR(13) + ;
                loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarParametrosSistema - Init legado:
    *   CursorQuery('SigCdPam','CrParam',.f.,.f.,[LiblCreds])
    *   CursorQuery('SigCdPac','CrParac',.f.,.f.,[SenhDEmps])
    * As duas tabelas de parametro sao de registro UNICO (sem WHERE,
    * igual ao legado - padrao ja usado em SigPrSddBO.BuscarSenhDEmps).
    * liblcreds/senhdemps sao bit NOT NULL e chegam ao VFP ora como
    * Logico ora como Numerico conforme o driver ODBC, por isso o
    * VARTYPE antes de comparar.
    *====================================================================
    PROCEDURE CarregarParametrosSistema()
        LOCAL loc_lSucesso, loc_nResultado

        loc_lSucesso = .F.

        TRY
            THIS.this_lLiblCreds = .F.
            IF USED("cursor_4c_Pam")
                USE IN cursor_4c_Pam
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, "SELECT liblcreds FROM SigCdPam", "cursor_4c_Pam")
            IF loc_nResultado > 0 AND USED("cursor_4c_Pam") AND !EOF("cursor_4c_Pam")
                SELECT cursor_4c_Pam
                THIS.this_lLiblCreds = IIF(VARTYPE(liblcreds) = "L", liblcreds, (NVL(liblcreds, 0) = 1))
            ENDIF
            IF USED("cursor_4c_Pam")
                USE IN cursor_4c_Pam
            ENDIF

            THIS.this_lSenhDEmps = .F.
            IF USED("cursor_4c_Pac")
                USE IN cursor_4c_Pac
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, "SELECT senhdemps FROM SigCdPac", "cursor_4c_Pac")
            IF loc_nResultado > 0 AND USED("cursor_4c_Pac") AND !EOF("cursor_4c_Pac")
                SELECT cursor_4c_Pac
                THIS.this_lSenhDEmps = IIF(VARTYPE(senhdemps) = "L", senhdemps, (NVL(senhdemps, 0) = 1))
            ENDIF
            IF USED("cursor_4c_Pac")
                USE IN cursor_4c_Pac
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar par" + CHR(226) + "metros do sistema:" + ;
                CHR(13) + loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * DefinirTipo - Init legado: normaliza os 8 parametros recebidos
    * (LParameters _Tipo, _Titulo, _Titulo2, _Documento, _Data, _Empresa,
    * _Fpagto, _Valor) e executa o DO CASE que deriva texto (Caption/
    * Frase) e as 12 flags de permissao a partir do _Tipo. Chamado pelo
    * Form na abertura do dialogo, com os mesmos 8 parametros do Init
    * legado.
    *
    * _Titulo/_Titulo2 chegam CRUS (regra da secao 2): a maioria dos
    * tipos usa os dois como texto (Alltrim direto), mas CHDEVOLVIDO usa
    * _Titulo como NUMERO (quantidade de cheques) - comparado e formatado
    * tal como no legado, sem normalizar o tipo de entrada.
    *
    * Carrega tambem os parametros do sistema (CarregarParametrosSistema)
    * na MESMA posicao do Init legado - DevePreencherUsuarioLogado e
    * EstaEmModoSenhaDoDia dependem de this_lLiblCreds ja carregado.
    *====================================================================
    PROCEDURE DefinirTipo(par_cTipo, par_cTitulo, par_cTitulo2, par_nDocumento, ;
            par_dData, par_cEmpresa, par_cFpagto, par_nValor)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            THIS.this_nNroDoc  = IIF(VARTYPE(par_nDocumento) = "N", par_nDocumento, 0)
            THIS.this_dDatDoc  = IIF(VARTYPE(par_dData) = "D" OR VARTYPE(par_dData) = "T", par_dData, DATE())
            THIS.this_cTipo    = IIF(VARTYPE(par_cTipo) = "C", par_cTipo, "")
            THIS.this_cEmpresa = IIF(VARTYPE(par_cEmpresa) = "C", par_cEmpresa, " ")
            THIS.this_cFpagto  = IIF(VARTYPE(par_cFpagto) = "C", par_cFpagto, " ")
            THIS.this_nValFpag = IIF(VARTYPE(par_nValor) = "N", par_nValor, 0)

            THIS.this_cTitulo  = par_cTitulo
            THIS.this_cTitulo2 = par_cTitulo2

            THIS.this_cUsuLibs = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "")

            *-- As 12 flags nascem desligadas, como no Init legado, antes
            *-- do DO CASE
            THIS.this_lFinanc       = .F.
            THIS.this_lCancItem     = .F.
            THIS.this_lLibFpag      = .F.
            THIS.this_lLibFpag2     = .F.
            THIS.this_lLibProducao  = .F.
            THIS.this_lSaldoEstoque = .F.
            THIS.this_lLibValida    = .F.
            THIS.this_lLiberaTitulo = .F.
            THIS.this_lLibOpe       = .F.
            THIS.this_lLibQtMin     = .F.
            THIS.this_lLibLimitador = .F.
            THIS.this_lMovEstoque   = .F.

            THIS.CarregarParametrosSistema()

            DO CASE
                CASE ALLTRIM(THIS.this_cTipo) == "DTENTREGA"
                    THIS.this_cCaption = "Prazo de Entrega"
                    THIS.this_cFrase   = ALLTRIM(THIS.this_cTitulo) + " fora do prazo de entrega!"
                    THIS.this_lFinanc  = .F.

                CASE ALLTRIM(THIS.this_cTipo) == "CHDEVOLVIDO"
                    THIS.this_cCaption = "Cheque Devolvido"
                    THIS.this_cFrase   = "A conta " + ALLTRIM(THIS.this_cTitulo2) + " possui "
                    IF THIS.this_cTitulo = 1
                        THIS.this_cFrase = THIS.this_cFrase + "1 Cheque Devolvido Pendente!"
                    ELSE
                        THIS.this_cFrase = THIS.this_cFrase + ALLTRIM(STR(THIS.this_cTitulo)) + ;
                            " Cheques Devolvidos Pendentes!"
                    ENDIF
                    THIS.this_lFinanc = .T.

                CASE ALLTRIM(THIS.this_cTipo) == "LIMITE"
                    THIS.this_cCaption = "Limite Excedido"
                    THIS.this_cFrase   = "O Limite da conta " + ALLTRIM(THIS.this_cTitulo) + " foi excedido! "
                    THIS.this_lFinanc  = .T.

                CASE ALLTRIM(THIS.this_cTipo) == "ALTERAIMPOSTO"
                    THIS.this_cCaption = ALLTRIM(THIS.this_cTitulo)
                    THIS.this_cFrase   = ALLTRIM(THIS.this_cTitulo2)
                    THIS.this_lFinanc  = .T.

                CASE ALLTRIM(THIS.this_cTipo) == "CANCITEM"
                    THIS.this_cCaption  = ALLTRIM(THIS.this_cTitulo)
                    THIS.this_cFrase    = ALLTRIM(THIS.this_cTitulo2)
                    THIS.this_lCancItem = .T.

                CASE ALLTRIM(THIS.this_cTipo) == "LIBFPAG"
                    THIS.this_cCaption = ALLTRIM(THIS.this_cTitulo)
                    THIS.this_cFrase   = ALLTRIM(THIS.this_cTitulo2)
                    THIS.this_lLibFpag = .T.

                CASE INLIST(ALLTRIM(THIS.this_cTipo), "LIBPRDZ", "LIBPRDZ2", "LIBPESO")
                    THIS.this_cCaption     = ALLTRIM(THIS.this_cTitulo)
                    THIS.this_cFrase       = ALLTRIM(THIS.this_cTitulo2)
                    THIS.this_lLibProducao = .T.

                CASE ALLTRIM(THIS.this_cTipo) == "SDINSUF"
                    THIS.this_cCaption      = ALLTRIM(THIS.this_cTitulo)
                    THIS.this_cFrase        = ALLTRIM(THIS.this_cTitulo2)
                    THIS.this_lSaldoEstoque = .T.

                CASE ALLTRIM(THIS.this_cTipo) == "MAXIMO"
                    THIS.this_cCaption = "Valor M" + CHR(225) + "ximo Excedido :" + THIS.this_cTitulo2
                    THIS.this_cFrase   = "Valor da Condi" + CHR(231) + CHR(227) + "o de Pagamento " + ;
                        ALLTRIM(THIS.this_cTitulo) + " foi excedido! "
                    THIS.this_lFinanc  = .T.

                CASE ALLTRIM(THIS.this_cTipo) == "DTVALIDA"
                    THIS.this_cCaption   = "Validade da Movimenta" + CHR(231) + CHR(227) + "o"
                    THIS.this_cFrase     = ALLTRIM(THIS.this_cTitulo) + " fora da Validade!!!"
                    THIS.this_lLibValida = .T.

                CASE ALLTRIM(THIS.this_cTipo) == "LIBTITULO"
                    THIS.this_cCaption      = "Liberar T" + CHR(237) + "tulo "
                    THIS.this_cFrase        = ALLTRIM(THIS.this_cTitulo)
                    THIS.this_lLiberaTitulo = .T.

                CASE ALLTRIM(THIS.this_cTipo) == "LIBERAFPG"
                    THIS.this_cCaption  = ALLTRIM(THIS.this_cTitulo)
                    THIS.this_cFrase    = ALLTRIM(THIS.this_cTitulo2)
                    THIS.this_lLibFpag2 = .T.

                CASE ALLTRIM(THIS.this_cTipo) == "LIBOPE"
                    THIS.this_cCaption = ALLTRIM(THIS.this_cTitulo)
                    THIS.this_cFrase   = ALLTRIM(THIS.this_cTitulo2)
                    THIS.this_lLibOpe  = .T.

                CASE ALLTRIM(THIS.this_cTipo) == "LIBQTMIN"
                    THIS.this_cCaption   = ALLTRIM(THIS.this_cTitulo)
                    THIS.this_cFrase     = ALLTRIM(THIS.this_cTitulo2)
                    THIS.this_lLibQtMin  = .T.

                CASE ALLTRIM(THIS.this_cTipo) == "LIBLIMITADOR"
                    THIS.this_cCaption       = ALLTRIM(THIS.this_cTitulo)
                    THIS.this_cFrase         = ALLTRIM(THIS.this_cTitulo2)
                    THIS.this_lLibLimitador  = .T.

                CASE INLIST(ALLTRIM(THIS.this_cTipo), "MOVESTOQUE", "VALIDACESSO")
                    *-- Legado usa _Titulo (nao _Titulo2) nos DOIS textos
                    THIS.this_cCaption    = ALLTRIM(THIS.this_cTitulo)
                    THIS.this_cFrase      = ALLTRIM(THIS.this_cTitulo)
                    THIS.this_lMovEstoque = .T.
            ENDCASE

            *-- Cache do modo operacional (secao 7-b); Form le a
            *-- propriedade OU chama EstaEmModoSenhaDoDia() direto
            THIS.this_lSenhaDoDia = THIS.EstaEmModoSenhaDoDia()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao definir tipo de libera" + CHR(231) + CHR(227) + "o:" + ;
                CHR(13) + loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * DevePreencherUsuarioLogado - Init legado (secao 7-a): decide se o
    * campo usuario entra PRE-PREENCHIDO com o usuario logado e o rotulo
    * da senha muda para "Senha Do Dia :". NAO eh a mesma expressao do
    * When/Valid (ver nota da secao 7) - uso exclusivo de UI na abertura.
    *====================================================================
    FUNCTION DevePreencherUsuarioLogado()
        RETURN (THIS.this_lLiblCreds AND ALLTRIM(THIS.this_cTipo) == "LIMITE") ;
            OR ALLTRIM(THIS.this_cTipo) == "LIBPRDZ2" ;
            OR ALLTRIM(THIS.this_cTipo) == "MAXIMO"
    ENDFUNC

    *====================================================================
    * EstaEmModoSenhaDoDia - negacao da expressao COMPARTILHADA por
    * usuario.When e senha.Valid do legado (secao 7-b):
    *   (!LiblCreds Or (Tipo#'LIMITE' And Tipo#'LIBPRDZ2')) And Tipo#'MAXIMO'
    * Quando esta FUNCTION devolve .T., a senha e conferida contra
    * fGerPswDiario em vez da senha cadastrada (ValidarSenha)
    *====================================================================
    FUNCTION EstaEmModoSenhaDoDia()
        LOCAL loc_lCondicaoNormal

        loc_lCondicaoNormal = (!THIS.this_lLiblCreds ;
            OR (ALLTRIM(THIS.this_cTipo) != "LIMITE" AND ALLTRIM(THIS.this_cTipo) != "LIBPRDZ2")) ;
            AND ALLTRIM(THIS.this_cTipo) != "MAXIMO"

        RETURN !loc_lCondicaoNormal
    ENDFUNC

    *====================================================================
    * ObterQuerySqlUsuario - usuario.Valid legado: DO CASE que escolhe,
    * conforme a flag de permissao ligada por DefinirTipo, qual criterio
    * de SigCdCrg/SigCdUsu autoriza o liberador. Traducao para SQL Server
    * do "Not a.cAtivos='N'" (-> a.cativos <> 'N') e do
    * "not a.Senhas = <6 espacos>" (-> comparacao de char fixo com string
    * de espacos eh sempre "em branco" sob ANSI padding, traduzido como
    * LTRIM(RTRIM(a.senhas)) <> '').
    *
    * this_lLibValida (DTVALIDA) e this_lLibLimitador (LIBLIMITADOR)
    * citam a.libvopes/a.liblmpss, colunas AUSENTES no schema canonico -
    * SigCdUsu tem 17 colunas e nenhuma com esse nome (achado da Fase 1,
    * regra #14/#45: dump do legado mais novo que o banco atual).
    * Mantido LITERAL (nao inventar substituto - pilar 2): o SQL Server
    * recusa com "Nome de coluna invalido", o CATCH do chamador devolve
    * .F. e o dialogo fica FAIL-CLOSED (nao autorizado) para esses dois
    * tipos, em vez de arriscar autorizar por um criterio adivinhado.
    *====================================================================
    PROTECTED FUNCTION ObterQuerySqlUsuario()
        LOCAL loc_cSQL, loc_cBase

        loc_cBase = "SELECT a.usuarios, a.senhas, a.ccargs, a.cativos "

        DO CASE
            CASE THIS.this_lCancItem
                loc_cSQL = loc_cBase + ;
                    "FROM SigCdUsu a INNER JOIN SigCdCrg b ON a.ccargs = b.ccargs " + ;
                    "WHERE a.cativos <> 'N' AND b.cancitens = 'S' AND LTRIM(RTRIM(a.senhas)) <> ''"

            CASE THIS.this_lFinanc
                loc_cSQL = loc_cBase + ;
                    "FROM SigCdUsu a INNER JOIN SigCdCrg b ON a.ccargs = b.ccargs " + ;
                    "WHERE a.cativos <> 'N' AND b.limites = 'S' AND LTRIM(RTRIM(a.senhas)) <> ''"

            CASE THIS.this_lLibFpag
                loc_cSQL = loc_cBase + ;
                    "FROM SigCdUsu a INNER JOIN SigCdCrg b ON a.ccargs = b.ccargs " + ;
                    "WHERE a.cativos <> 'N' AND b.libfpags = 'S' AND LTRIM(RTRIM(a.senhas)) <> ''"

            CASE THIS.this_lLibFpag2
                loc_cSQL = loc_cBase + ;
                    "FROM SigCdUsu a INNER JOIN SigCdCrg b ON a.ccargs = b.ccargs " + ;
                    "WHERE a.cativos <> 'N' AND b.libfpgs = 'S' AND LTRIM(RTRIM(a.senhas)) <> ''"

            CASE THIS.this_lLibProducao
                IF ALLTRIM(THIS.this_cTipo) == "LIBPESO"
                    loc_cSQL = loc_cBase + ;
                        "FROM SigCdUsu a " + ;
                        "WHERE a.cativos <> 'N' AND a.libpess = 'S' AND LTRIM(RTRIM(a.senhas)) <> ''"
                ELSE
                    loc_cSQL = loc_cBase + ;
                        "FROM SigCdUsu a " + ;
                        "WHERE a.cativos <> 'N' AND a.libprods = 'S' AND LTRIM(RTRIM(a.senhas)) <> ''"
                ENDIF

            CASE THIS.this_lSaldoEstoque
                loc_cSQL = loc_cBase + ;
                    "FROM SigCdUsu a INNER JOIN SigCdCrg b ON a.ccargs = b.ccargs " + ;
                    "WHERE a.cativos <> 'N' AND b.libsdins = 'S' AND LTRIM(RTRIM(a.senhas)) <> ''"

            CASE THIS.this_lLibValida
                loc_cSQL = loc_cBase + ;
                    "FROM SigCdUsu a " + ;
                    "WHERE a.cativos <> 'N' AND a.libvopes = 'S' AND LTRIM(RTRIM(a.senhas)) <> ''"

            CASE THIS.this_lLibOpe
                loc_cSQL = loc_cBase + ;
                    "FROM SigCdUsu a INNER JOIN SigCdCrg b ON a.ccargs = b.ccargs " + ;
                    "WHERE a.cativos <> 'N' AND b.libopes = 'S' AND LTRIM(RTRIM(a.senhas)) <> ''"

            CASE THIS.this_lLibQtMin
                loc_cSQL = loc_cBase + ;
                    "FROM SigCdUsu a " + ;
                    "WHERE a.cativos <> 'N' AND a.libqtmins = 'S' AND LTRIM(RTRIM(a.senhas)) <> ''"

            CASE THIS.this_lLibLimitador
                loc_cSQL = loc_cBase + ;
                    "FROM SigCdUsu a " + ;
                    "WHERE a.cativos <> 'N' AND a.liblmpss = 'S' AND LTRIM(RTRIM(a.senhas)) <> ''"

            CASE THIS.this_lMovEstoque
                loc_cSQL = loc_cBase + ;
                    "FROM SigCdUsu a " + ;
                    "WHERE a.cativos <> 'N' AND LTRIM(RTRIM(a.senhas)) <> ''"

            OTHERWISE
                loc_cSQL = loc_cBase + ;
                    "FROM SigCdUsu a INNER JOIN SigCdCrg b ON a.ccargs = b.ccargs " + ;
                    "WHERE a.cativos <> 'N' AND b.altcots = 'S' AND LTRIM(RTRIM(a.senhas)) <> ''"
        ENDCASE

        RETURN loc_cSQL
    ENDFUNC

    *====================================================================
    * CarregarUsuariosAutorizados - executa a query de ObterQuerySqlUsuario
    * em cursor_4c_Usuar (equivalente ao TmpUsu do legado). Usado por
    * ValidarUsuario e, quando nenhum usuario digitado casa exato, serve
    * de fonte para o picker (FormBuscaAuxiliar Pattern A, no Form).
    *
    * loc_nResultado < 1 cobre TANTO erro de SQL QUANTO zero linhas - o
    * legado trata as duas coisas como falha ("Favor Reinicializar o
    * Processo!!!"), porque zero linhas significa que NENHUM usuario
    * tem a permissao exigida por este tipo (falha de configuracao, nao
    * so "nao achei o usuario digitado" - isso e tratado depois, em
    * ValidarUsuario)
    *====================================================================
    FUNCTION CarregarUsuariosAutorizados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            loc_cSQL = THIS.ObterQuerySqlUsuario()

            IF USED("cursor_4c_Usuar")
                USE IN cursor_4c_Usuar
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Usuar")

            IF loc_nResultado < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * ValidarUsuario - usuario.Valid legado: localiza par_cUsuario (ja
    * resolvido pelo Form, direto ou via picker) dentro do pool de
    * usuarios autorizados e carrega this_cUsuario/this_cCargoUsuario/
    * this_cSenhaCadastrada/this_cUsuarioAtivo. NAO confere senha (ver
    * ValidarSenha) - so confirma que o CODIGO existe no pool permitido.
    *
    * Repopula cursor_4c_Usuar so se ainda nao estiver aberto (o Form
    * tipicamente ja chamou CarregarUsuariosAutorizados antes, para
    * oferecer o picker quando o usuario digitado nao bate exato).
    *====================================================================
    FUNCTION ValidarUsuario(par_cUsuario)
        LOCAL loc_lSucesso, loc_lProsseguir, loc_cUsuarioPad

        loc_lSucesso     = .F.
        loc_lProsseguir  = .T.
        THIS.this_cMensagemErro = ""
        loc_cUsuarioPad  = ALLTRIM(NVL(par_cUsuario, ""))

        TRY
            IF !USED("cursor_4c_Usuar")
                loc_lProsseguir = THIS.CarregarUsuariosAutorizados()
            ENDIF

            IF loc_lProsseguir AND USED("cursor_4c_Usuar") AND !EMPTY(loc_cUsuarioPad)
                SELECT cursor_4c_Usuar
                LOCATE FOR UPPER(ALLTRIM(usuarios)) == UPPER(loc_cUsuarioPad)

                IF FOUND()
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Usuar")
                    THIS.this_cUsuLibs = loc_cUsuarioPad
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * UsuarioTemSenhaCadastrada - usuario.Valid legado:
    *   If IsEmpty(TmpUsu.senhas) -> autoriza sem pedir senha
    * ObterQuerySqlUsuario ja exclui usuario sem senha do pool (secao do
    * cabecalho do metodo), entao esta FUNCTION normalmente devolve .T.
    * apos ValidarUsuario ter sucesso - mantida por fidelidade ao Valid
    * legado, que faz a MESMA checagem depois do SEEK
    *====================================================================
    FUNCTION UsuarioTemSenhaCadastrada()
        RETURN !EMPTY(ALLTRIM(THIS.this_cSenhaCadastrada))
    ENDFUNC

    *====================================================================
    * ConcluirAutorizacaoSemSenha - usuario.Valid legado, ramo
    * IsEmpty(TmpUsu.senhas): zsen=.t. direto, sem pedir senha. O Form
    * decide a parte visual (ocultar say3/senha) e fechar o dialogo
    *====================================================================
    PROCEDURE ConcluirAutorizacaoSemSenha()
        THIS.this_lZSen = .T.
    ENDPROC

    *====================================================================
    * ValidarSenha - senha.Valid legado: confere a senha digitada contra
    * a senha CADASTRADA (via fCriptografar) quando EstaEmModoSenhaDoDia
    * devolve .F., ou contra a SENHA DO DIA (fGerPswDiario) quando
    * devolve .T.. Fail-closed: this_lZSen comeca .F. e so vira .T. no
    * caminho de sucesso.
    *
    * fCriptografar/fGerPswDiario NAO foram portadas (achado da Fase 1) -
    * sao valor-de-CALCULO (hash/senha do dia), por isso ficam AUSENTES
    * de proposito (regra #27): estourar "File ... does not exist" dentro
    * do TRY e cair no CATCH com this_lZSen OFF eh o comportamento SEGURO;
    * um stub que "simulasse" a senha autenticaria quem nao devia.
    *====================================================================
    FUNCTION ValidarSenha(par_cSenha)
        LOCAL loc_lSucesso, loc_cSenhaCripto, loc_nNum, loc_cSenhaDia

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""
        THIS.this_lZSen = .F.

        TRY
            IF !THIS.EstaEmModoSenhaDoDia()
                loc_cSenhaCripto = fCriptografar(THIS.this_cSenhaCadastrada)

                IF EMPTY(ALLTRIM(NVL(par_cSenha, ""))) ;
                        OR PADR(ALLTRIM(NVL(par_cSenha, "")), 10) != PADR(ALLTRIM(NVL(loc_cSenhaCripto, "")), 10)
                    THIS.this_cMensagemErro = "Senha Conflitante"
                ELSE
                    THIS.this_lZSen = .T.
                    IF !INLIST(ALLTRIM(THIS.this_cTipo), "LIBPRDZ", "LIBPRDZ2", "LIBPESO", "LIBQTMIN")
                        THIS.RegistrarLiberacao()
                    ENDIF
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                *-- lnNum do legado: soma empresa+fpagto+valor so quando
                *-- SigCdPac.senhdemps esta ligado
                loc_nNum = 0
                IF THIS.this_lSenhDEmps
                    THIS.this_nNumEmpresa = THIS.BuscarNumeroEmpresa()
                    THIS.this_nNumFpagto  = THIS.BuscarNumeroFpag()
                    loc_nNum = THIS.this_nNumEmpresa + THIS.this_nNumFpagto + (THIS.this_nValFpag * 100)
                ENDIF
                THIS.this_nNumeroBase = loc_nNum

                loc_cSenhaDia = fGerPswDiario(THIS.this_nNroDoc, THIS.this_dDatDoc, loc_nNum)
                THIS.this_cSenhaDoDia = loc_cSenhaDia

                IF ALLTRIM(NVL(par_cSenha, "")) != ALLTRIM(NVL(loc_cSenhaDia, ""))
                    THIS.this_cMensagemErro = "Senha Conflitante"
                ELSE
                    THIS.this_lZSen    = .T.
                    THIS.this_cUsuLibs = loc_cSenhaDia
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao validar senha:" + CHR(13) + loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * RegistrarLiberacao - senha.Valid legado, caminho de sucesso NAO
    * senha-do-dia, fora de LIBPRDZ/LIBPRDZ2/LIBPESO/LIBQTMIN:
    *   LIBTITULO     -> fGravarLog('T','SigPgTit',Tipo,Frase,Usuar)
    *   demais tipos  -> fGravarLog('T',TprMvCab.Dopes,Tipo,<concat>,UsuLibs)
    *                    SO se TprMvCab estiver aberto (cursor global do
    *                    CHAMADOR, com o cabecalho do movimento - nao eh
    *                    deste BO popular; guard IF USED() replica o
    *                    legado literal)
    * fGravarLog e wrapper no-op documentado (utils\fgravarlog.prg,
    * regra #27) - chamada segura mesmo sem o algoritmo original
    *====================================================================
    PROTECTED PROCEDURE RegistrarLiberacao()
        TRY
            IF ALLTRIM(THIS.this_cTipo) == "LIBTITULO"
                fGravarLog("T", "SigPgTit", THIS.this_cTipo, THIS.this_cFrase, ;
                    IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, ""))
            ELSE
                IF USED("TprMvCab")
                    fGravarLog("T", TprMvCab.Dopes, THIS.this_cTipo, ;
                        TprMvCab.Emps + "-" + ALLTRIM(TprMvCab.Dopes) + "-" + ALLTRIM(STR(TprMvCab.Numes, 6)) + ;
                        IIF(ALLTRIM(THIS.this_cTipo) == "LIBERAFPG", "(" + ALLTRIM(THIS.this_cFrase) + ")", " "), ;
                        THIS.this_cUsuLibs)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao registrar log de libera" + CHR(231) + CHR(227) + "o:" + ;
                CHR(13) + loc_oErro.Message
        ENDTRY
    ENDPROC

    *====================================================================
    * BuscarNumeroEmpresa - senha.Valid legado: SigCdEmp.nemps da
    * this_cEmpresa, usado no calculo da senha do dia
    *====================================================================
    PROTECTED FUNCTION BuscarNumeroEmpresa()
        LOCAL loc_nEmps, loc_nRet, loc_cSQL

        loc_nEmps = 0

        TRY
            IF USED("cursor_4c_Emp")
                USE IN cursor_4c_Emp
            ENDIF

            loc_cSQL = "SELECT nemps FROM SigCdEmp WHERE cemps = " + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cEmpresa), 3))

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emp")
            IF loc_nRet > 0 AND USED("cursor_4c_Emp") AND !EOF("cursor_4c_Emp")
                SELECT cursor_4c_Emp
                loc_nEmps = NVL(nemps, 0)
            ENDIF

            IF USED("cursor_4c_Emp")
                USE IN cursor_4c_Emp
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_nEmps
    ENDFUNC

    *====================================================================
    * BuscarNumeroFpag - senha.Valid legado: SigOpFp.nfpags da
    * this_cFpagto, usado no calculo da senha do dia
    *====================================================================
    PROTECTED FUNCTION BuscarNumeroFpag()
        LOCAL loc_nFpags, loc_nRet, loc_cSQL

        loc_nFpags = 0

        TRY
            IF !EMPTY(ALLTRIM(THIS.this_cFpagto))
                IF USED("cursor_4c_Fpg")
                    USE IN cursor_4c_Fpg
                ENDIF

                loc_cSQL = "SELECT nfpags FROM SigOpFp WHERE fpags = " + ;
                    EscaparSQL(PADR(ALLTRIM(THIS.this_cFpagto), 12))

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Fpg")
                IF loc_nRet > 0 AND USED("cursor_4c_Fpg") AND !EOF("cursor_4c_Fpg")
                    SELECT cursor_4c_Fpg
                    loc_nFpags = NVL(nfpags, 0)
                ENDIF

                IF USED("cursor_4c_Fpg")
                    USE IN cursor_4c_Fpg
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_nFpags
    ENDFUNC

    *====================================================================
    * ObterResultadoSaida - contrato de retorno do dialogo, equivalente
    * ao PROCEDURE Unload legado:
    *
    *   Return Iif(This.ZSen, [*], [ ]) + This.UsuLibs
    *
    * Transcrito LITERAL (regra #17): a primeira posicao eh o asterisco
    * quando a autorizacao foi concedida e UM ESPACO quando nao foi, e o
    * resto eh o codigo de quem liberou - no ramo senha-do-dia o proprio
    * legado grava ali a senha calculada (ver ValidarSenha). Sem ALLTRIM
    * em parte alguma: o legado nao apara, e o chamador testa a posicao
    * 1 com LEFT(<retorno>, 1) == "*".
    *
    * Fonte UNICA do resultado: o Form apenas espelha esta FUNCTION (ver
    * Formsigopcks.ObterResultadoSaida). O valor tambem fica guardado em
    * this_cRetorno, que existe para isso desde a Fase 1 - assim o Form
    * pode CACHEAR a resposta antes de o BO ser liberado, ja que o evento
    * Unload do VFP dispara DEPOIS do Destroy, quando
    * FormBase.Destroy ja zerou this_oBusinessObject.
    *
    * Fail-closed: this_lZSen nasce .F., eh zerado em cada caminho de
    * negativa e so vira .T. nos tres caminhos de autorizacao do legado
    * (senha cadastrada conferida, senha do dia conferida e usuario sem
    * senha cadastrada). Chamar este metodo antes de qualquer validacao
    * devolve " " + "" - nao autorizado -, que eh o lado seguro.
    *====================================================================
    FUNCTION ObterResultadoSaida()
        THIS.this_cRetorno = IIF(THIS.this_lZSen, "*", " ") + THIS.this_cUsuLibs

        RETURN THIS.this_cRetorno
    ENDFUNC

ENDDEFINE
