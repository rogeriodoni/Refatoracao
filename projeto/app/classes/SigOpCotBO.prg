*====================================================================
* SigOpCotBO.prg
*
* Business Object para SigOpCot - Alteracao de Cambio
*
* Dialogo MODAL do legado Fortyus (SIGOPCOT.scx), aberto pelo form PAI
* durante Incluir/Alterar de um documento, para o usuario revisar/
* alterar a cotacao de cada moeda usada no documento. O legado NAO
* persiste nada direto: recebe o cursor TmpCot (CMoes/Valos/aValos) ja
* aberto pelo chamador, deixa o usuario editar a celula Cotacao linha a
* linha (sob permissao), e devolve via Replace All no proprio cursor -
* quem grava de fato eh o form pai, depois que este dialogo fecha.
*
* A permissao de editar manualmente a cotacao depende de DOIS fatores,
* verificados pelo When da celula Cotacao do legado:
*   1) Cargo do usuario logado (SigCdUsu.ccargs -> SigCdCrg.altcots='S')
*   2) A moeda da linha admitir cotacao manual (SigCdMoe.cotas = .T.)
*
* Tabela principal  : SigCdMoe (cmoes) - define se a moeda eh cotavel
* Tabelas de apoio   : SigCdUsu (usuarios/ccargs do usuario logado)
*                      SigCdCrg (ccargs/altcots - permissao do cargo)
*
* Herda de: BusinessBase
*
* Somente leitura: este BO nao executa Insert/Update/Delete em tabela
* alguma - apenas consulta SigCdUsu/SigCdCrg/SigCdMoe para resolver a
* permissao de edicao, e devolve o resultado para o Form aplicar no
* cursor de trabalho (TmpCot/equivalente) que o form pai controla. Por
* isso Inserir(), Atualizar() e ExecutarExclusao() nao sao sobrescritos
* aqui: o comportamento padrao herdado de BusinessBase ja eh o correto.
*====================================================================

DEFINE CLASS SigOpCotBO AS BusinessBase

    *----------------------------------------------------------------
    * 1) USUARIO / PERMISSAO
    *    Legado: Init faz CursorQuery(SigCdUsu,...,Usuar) e depois
    *    Seek(crSigCdUsu.Ccargs, crSigCdCrg) para achar o cargo; o When
    *    da celula Cotacao repete o mesmo Seek a cada linha
    *----------------------------------------------------------------

    *-- this_cUsuario -> SigCdUsu.usuarios char(10) - usuario logado
    *-- (equivalente a Usuar no legado, aqui = gc_4c_UsuarioLogado)
    this_cUsuario = ""

    *-- this_cCargo -> SigCdUsu.ccargs char(10) - cargo do usuario,
    *-- usado para localizar a permissao em SigCdCrg
    this_cCargo = ""

    *-- this_lAltCots -> SigCdCrg.altcots char(1) = 'S' - .T. quando o
    *-- cargo do usuario pode alterar cotacao manualmente. Equivale ao
    *-- 2o termo do And no Seek(...) do When legado
    this_lAltCots = .F.

    *----------------------------------------------------------------
    * 2) PARAMETRO DE ENTRADA
    *    Legado: LParameters ParentForm, pdDatas (Init). Sem pdDatas
    *    valido (Type([pdDatas])#[D]), ThisForm.dDatas = Date()
    *----------------------------------------------------------------

    *-- this_dDatas -> data base da cotacao, repassada ao dialogo
    *-- SigOpAlC quando o usuario pede a cotacao via botao Alterar
    this_dDatas = {}

    *----------------------------------------------------------------
    * 3) LINHA CORRENTE DA GRADE DE COTACAO (TmpCot)
    *    Legado: grid Gradeget_cotacao ligado ao cursor TmpCot
    *    (CMoes/Valos/aValos). O When da celula Cotacao testa se a
    *    MOEDA da linha corrente admite cotacao manual
    *----------------------------------------------------------------

    *-- this_cMoeda -> TmpCot.CMoes / SigCdMoe.cmoes char(3) - moeda da
    *-- linha corrente da grade
    this_cMoeda = ""

    *-- this_lMoedaCotada -> SigCdMoe.cotas bit - .T. quando a moeda da
    *-- linha corrente admite digitacao manual de cotacao. Equivale ao
    *-- 3o termo do And no Return do When legado (crSigCdMoe.Cotas)
    this_lMoedaCotada = .F.

    *-- this_nValorAtual -> TmpCot.Valos numeric - valor de cotacao
    *-- exibido/editado na linha corrente
    this_nValorAtual = 0

    *-- this_nValorAnterior -> TmpCot.aValos numeric - copia de
    *-- seguranca do valor original (Load legado: Replace All aValos
    *-- With Valos), usada para desfazer a edicao no botao Cancelar
    *-- (btnSair.Click legado: Replace All Valos With aValos)
    this_nValorAnterior = 0

    *-- this_nAntValue -> ThisForm.AntValue do legado (ClassInfo do SCX):
    *-- valor da celula Cotacao no momento em que o usuario ENTRA nela
    *-- (When da celula: ThisForm.AntValue = This.Value), guardado para
    *-- a comparacao antes/depois da digitacao
    this_nAntValue = 0

    *----------------------------------------------------------------
    * 4) DESCRICAO DA MOEDA E ESTADO VINDO DO FORM PAI
    *----------------------------------------------------------------

    *-- this_cDescricaoMoeda -> SigCdMoe.dmoes char(15) - descricao da
    *-- moeda da linha corrente (lida junto com cotas no mesmo SELECT)
    this_cDescricaoMoeda = ""

    *-- this_cEscolhaPai -> ParentForm.pcEscolha do legado: "INSERIR",
    *-- "ALTERAR" ou "PROCURAR". Entra na visibilidade do botao Alterar
    *-- (Init legado) e no When dele
    this_cEscolhaPai = ""

    *-- this_cCursorCotacao -> alias do cursor de trabalho que o form PAI
    *-- abre e passa para este dialogo (TmpCot no legado), com as colunas
    *-- cmoes / valos / avalos
    this_cCursorCotacao = ""

    *-- this_cCursorCabecalho -> alias do cursor de cabecalho do documento
    *-- do form pai (TprMvCab no legado, sobre SigMvCab), onde o legado
    *-- grava cotusus char(10) quando a cotacao eh alterada sob autorizacao
    this_cCursorCabecalho = ""

    *-- this_cUsuarioAutorizacao -> SigMvCab.cotusus char(10) - usuario que
    *-- autorizou a cotacao manual no dialogo SigOpAlC (3a linha do retorno
    *-- "OK" + CHR(13) + valor + CHR(13) + usuario)
    this_cUsuarioAutorizacao = ""

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()

        *-- CRITICO: Usar nomes CORRETOS das propriedades herdadas.
        *-- SigCdMoe eh a tabela que este BO efetivamente consulta
        *-- (flag Cotas, por moeda) para resolver a permissao de edicao
        THIS.this_cTabela     = "SigCdMoe"
        THIS.this_cCampoChave = "cmoes"

        *-- Normalizacao equivalente ao Init legado: sem data valida
        *-- vinda do chamador, assume a data corrente
        THIS.this_cUsuario = ""
        THIS.this_cCargo   = ""
        THIS.this_lAltCots = .F.
        THIS.this_dDatas   = DATE()

        THIS.this_cMoeda         = ""
        THIS.this_lMoedaCotada   = .F.
        THIS.this_nValorAtual    = 0
        THIS.this_nValorAnterior = 0
        THIS.this_nAntValue      = 0

        THIS.this_cDescricaoMoeda     = ""
        THIS.this_cEscolhaPai         = ""
        THIS.this_cUsuarioAutorizacao = ""

        *-- Alias default dos cursores de trabalho; o form PAI pode trocar
        *-- (equivalem a TmpCot / TprMvCab do legado)
        THIS.this_cCursorCotacao   = "cursor_4c_Cotacoes"
        THIS.this_cCursorCabecalho = "cursor_4c_Cabecalho"

        RETURN .T.
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega as propriedades a partir de UM registro
    * de cursor, cobrindo TODAS as colunas que este BO representa:
    *
    *   cursor de cotacao (TmpCot do legado) : cmoes / valos / avalos
    *   cursor de SigCdMoe                   : cmoes / dmoes / cotas
    *   cursor de SigCdUsu + SigCdCrg        : usuarios / ccargs / altcots
    *   cursor de cabecalho (TprMvCab)       : cotusus
    *
    * Metodo PUBLIC (sem PROTECTED): o Form o chama de fora, e PROTECTED
    * em qualquer nivel da heranca faz a chamada externa estourar
    * "Property not found" em runtime.
    *
    * SELECT (par_cAliasCursor) ANTES de acessar os campos: a sintaxe
    * campo nao existe em VFP9.
    *
    * Existencia de campo conferida com TYPE(alias + ".col") - PEMSTATUS
    * exige OBJETO no 1o argumento e estoura com nome de cursor.
    *
    * cotas eh bit NOT NULL no schema e chega ao VFP ora como Logico ora
    * como Numerico conforme o driver ODBC, por isso o VARTYPE antes de
    * comparar. TratarNulo NAO serve para esta coluna: devolve o valor
    * padrao para QUALQUER logico vazio, e .F. eh valor legitimo de cotas.
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_oErro
        loc_lSucesso = .F.

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C", ALLTRIM(par_cAliasCursor), "")

        TRY
            IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
                SELECT (loc_cAlias)

                IF !EOF(loc_cAlias)
                    *-- cmoes char(3) - moeda da linha / chave de SigCdMoe
                    IF TYPE(loc_cAlias + ".cmoes") == "C"
                        THIS.this_cMoeda = TratarNulo(cmoes, "")
                    ENDIF

                    *-- dmoes char(15) - descricao da moeda
                    IF TYPE(loc_cAlias + ".dmoes") == "C"
                        THIS.this_cDescricaoMoeda = TratarNulo(dmoes, "")
                    ENDIF

                    *-- cotas bit - moeda admite cotacao digitada a mao
                    IF TYPE(loc_cAlias + ".cotas") != "U"
                        THIS.this_lMoedaCotada = IIF(VARTYPE(cotas) = "L", ;
                            cotas, (NVL(cotas, 0) = 1))
                    ENDIF

                    *-- valos numeric(11,6) - cotacao exibida/editada
                    IF TYPE(loc_cAlias + ".valos") == "N"
                        THIS.this_nValorAtual = TratarNulo(valos, 0)
                    ENDIF

                    *-- avalos numeric - copia de seguranca do valor
                    *-- original (Load legado: Replace All aValos With Valos)
                    IF TYPE(loc_cAlias + ".avalos") == "N"
                        THIS.this_nValorAnterior = TratarNulo(avalos, 0)
                    ENDIF

                    *-- usuarios char(10) - usuario logado (SigCdUsu)
                    IF TYPE(loc_cAlias + ".usuarios") == "C"
                        THIS.this_cUsuario = TratarNulo(usuarios, "")
                    ENDIF

                    *-- ccargs char(10) - cargo do usuario (SigCdUsu/SigCdCrg)
                    IF TYPE(loc_cAlias + ".ccargs") == "C"
                        THIS.this_cCargo = TratarNulo(ccargs, "")
                    ENDIF

                    *-- altcots char(1) = "S" - cargo pode alterar cotacao
                    IF TYPE(loc_cAlias + ".altcots") == "C"
                        THIS.this_lAltCots = (UPPER(ALLTRIM(TratarNulo(altcots, ""))) == "S")
                    ENDIF

                    *-- cotusus char(10) - usuario que autorizou a cotacao
                    IF TYPE(loc_cAlias + ".cotusus") == "C"
                        THIS.this_cUsuarioAutorizacao = TratarNulo(cotusus, "")
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao ler os dados da cota" + CHR(231) + CHR(227) + "o:" + ;
                CHR(13) + loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPermissaoCargo - Init legado:
    *   poDataMgr.CursorQuery([SigCdUsu],[crSigCdUsu],[Usuarios],
    *                         Padr(Alltrim(Usuar),10))
    *   Seek(crSigCdUsu.Ccargs, [crSigCdCrg], [Ccargs]) And
    *   (crSigCdCrg.AltCots = [S])
    *
    * O legado resolve em dois passos (cursor do usuario + Seek no cursor
    * global de cargos). Aqui vai num SELECT unico com LEFT JOIN, porque o
    * cursor global crSigCdCrg do Fortyus nao existe na arquitetura nova.
    * LEFT JOIN e nao INNER: usuario cujo cargo nao esteja em SigCdCrg tem
    * de cair em altcots vazio -> this_lAltCots = .F., que eh o resultado
    * do Seek falhando no legado, e NAO "usuario inexistente".
    *
    * Nomes de coluna conferidos em docs/schema.sql: SigCdUsu.usuarios,
    * SigCdUsu.ccargs, SigCdCrg.ccargs, SigCdCrg.altcots.
    *====================================================================
    PROCEDURE CarregarPermissaoCargo(par_cUsuario)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cUsuarioPad, loc_oErro
        loc_lSucesso = .F.

        THIS.this_cMensagemErro = ""
        THIS.this_lAltCots = .F.
        THIS.this_cCargo   = ""

        *-- Usuar do legado = usuario logado do sistema novo
        IF VARTYPE(par_cUsuario) = "C" AND !EMPTY(ALLTRIM(par_cUsuario))
            loc_cUsuarioPad = PADR(ALLTRIM(par_cUsuario), 10)
        ELSE
            loc_cUsuarioPad = PADR(ALLTRIM(IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                gc_4c_UsuarioLogado, "")), 10)
        ENDIF

        THIS.this_cUsuario = loc_cUsuarioPad

        TRY
            IF EMPTY(ALLTRIM(loc_cUsuarioPad))
                THIS.this_cMensagemErro = "Usu" + CHR(225) + "rio n" + CHR(227) + "o informado."
            ELSE
                IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                    THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados " + ;
                        "n" + CHR(227) + "o dispon" + CHR(237) + "vel."
                ELSE
                    IF USED("cursor_4c_Permissao")
                        IF CURSORGETPROP("Buffering", "cursor_4c_Permissao") > 1
                            TABLEREVERT(.T., "cursor_4c_Permissao")
                        ENDIF
                        USE IN cursor_4c_Permissao
                    ENDIF

                    loc_cSQL = "SELECT u.usuarios, u.ccargs, c.altcots" + ;
                               "  FROM SigCdUsu u" + ;
                               "  LEFT JOIN SigCdCrg c ON RTRIM(c.ccargs) = RTRIM(u.ccargs)" + ;
                               " WHERE u.usuarios = " + EscaparSQL(loc_cUsuarioPad)

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Permissao")

                    IF loc_nResultado > 0 AND USED("cursor_4c_Permissao") ;
                            AND RECCOUNT("cursor_4c_Permissao") > 0
                        SELECT cursor_4c_Permissao
                        GO TOP
                        *-- a leitura das colunas fica concentrada em CarregarDoCursor
                        loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Permissao")
                        IF !loc_lSucesso AND EMPTY(THIS.this_cMensagemErro)
                            THIS.this_cMensagemErro = "Falha ao ler a permiss" + CHR(227) + ;
                                "o do cargo."
                        ENDIF
                    ELSE
                        IF loc_nResultado < 0
                            THIS.this_cMensagemErro = "Erro ao consultar a permiss" + CHR(227) + ;
                                "o do usu" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL()
                        ELSE
                            THIS.this_cMensagemErro = "Usu" + CHR(225) + "rio n" + CHR(227) + ;
                                "o cadastrado."
                        ENDIF
                    ENDIF

                    IF USED("cursor_4c_Permissao")
                        USE IN cursor_4c_Permissao
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarMoeda - When da celula Cotacao do legado:
    *   poDataMgr.CursorQuery([SigCdMoe],[crSigCdMoe],[CMoes],TmpCot.CMoes)
    * Carrega this_cMoeda / this_cDescricaoMoeda / this_lMoedaCotada.
    *
    * Moeda inexistente devolve .F. com mensagem e this_lMoedaCotada
    * continua .F. - mesmo efeito do crSigCdMoe.Cotas vazio no legado.
    *====================================================================
    PROCEDURE CarregarMoeda(par_cMoeda)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro
        loc_lSucesso = .F.

        THIS.this_cMensagemErro   = ""
        THIS.this_cMoeda          = PADR(ALLTRIM(IIF(VARTYPE(par_cMoeda) = "C", par_cMoeda, "")), 3)
        THIS.this_cDescricaoMoeda = ""
        THIS.this_lMoedaCotada    = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cMoeda))
                THIS.this_cMensagemErro = "Moeda n" + CHR(227) + "o informada."
            ELSE
                IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                    THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados " + ;
                        "n" + CHR(227) + "o dispon" + CHR(237) + "vel."
                ELSE
                    IF USED("cursor_4c_Moeda")
                        IF CURSORGETPROP("Buffering", "cursor_4c_Moeda") > 1
                            TABLEREVERT(.T., "cursor_4c_Moeda")
                        ENDIF
                        USE IN cursor_4c_Moeda
                    ENDIF

                    loc_cSQL = "SELECT cmoes, dmoes, cotas" + ;
                               "  FROM SigCdMoe" + ;
                               " WHERE cmoes = " + EscaparSQL(THIS.this_cMoeda)

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Moeda")

                    IF loc_nResultado > 0 AND USED("cursor_4c_Moeda") ;
                            AND RECCOUNT("cursor_4c_Moeda") > 0
                        SELECT cursor_4c_Moeda
                        GO TOP
                        loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Moeda")
                        IF !loc_lSucesso AND EMPTY(THIS.this_cMensagemErro)
                            THIS.this_cMensagemErro = "Falha ao ler os dados da moeda."
                        ENDIF
                    ELSE
                        IF loc_nResultado < 0
                            THIS.this_cMensagemErro = "Erro ao consultar a moeda:" + CHR(13) + ;
                                CapturarErroSQL()
                        ELSE
                            THIS.this_cMensagemErro = "Moeda n" + CHR(227) + "o cadastrada."
                        ENDIF
                    ENDIF

                    IF USED("cursor_4c_Moeda")
                        USE IN cursor_4c_Moeda
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - carga pela chave primaria de SigCdMoe (cmoes),
    * no contrato que os Forms do projeto esperam. Aqui eh sinonimo de
    * CarregarMoeda, porque a chave deste BO eh a propria moeda.
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        RETURN THIS.CarregarMoeda(par_cCodigo)
    ENDPROC

    *====================================================================
    * PodeAlterarCotacao - When da celula Cotacao do legado, LITERAL:
    *   Return (Seek(crSigCdUsu.Ccargs, [crSigCdCrg], [Ccargs]) And
    *           (crSigCdCrg.AltCots = [S]) And crSigCdMoe.Cotas)
    *
    * Os TRES termos tem de valer: cargo achado, altcots = "S" e a moeda
    * da linha admitir cotacao manual. Resolve o que ainda nao estiver em
    * memoria (permissao do cargo e/ou moeda) antes de responder.
    *====================================================================
    PROCEDURE PodeAlterarCotacao(par_cMoeda)
        LOCAL loc_lPode, loc_cMoedaPed, loc_oErro
        loc_lPode = .F.

        TRY
            *-- 1o e 2o termos: cargo do usuario logado
            IF EMPTY(ALLTRIM(THIS.this_cUsuario)) OR EMPTY(ALLTRIM(THIS.this_cCargo))
                THIS.CarregarPermissaoCargo(THIS.this_cUsuario)
            ENDIF

            *-- 3o termo: a moeda da linha corrente
            loc_cMoedaPed = PADR(ALLTRIM(IIF(VARTYPE(par_cMoeda) = "C", par_cMoeda, ;
                THIS.this_cMoeda)), 3)

            IF !EMPTY(ALLTRIM(loc_cMoedaPed))
                IF loc_cMoedaPed != PADR(ALLTRIM(THIS.this_cMoeda), 3) ;
                        OR EMPTY(ALLTRIM(THIS.this_cDescricaoMoeda))
                    THIS.CarregarMoeda(loc_cMoedaPed)
                ENDIF
            ENDIF

            loc_lPode = THIS.this_lAltCots AND THIS.this_lMoedaCotada
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lPode = .F.
        ENDTRY

        RETURN loc_lPode
    ENDPROC

    *====================================================================
    * ObterVisibilidadeBotaoCotacao - Init legado, transcrito LITERAL:
    *   btnCotacao.Visible = Not (Seek(...) And (AltCots = [S]) And
    *                             InList(ParentForm.pcEscolha,
    *                                    [INSERIR],[ALTERAR]))
    *
    * O NOT eh do legado e NAO eh descuido: quem JA pode digitar a cotacao
    * direto na grade nao precisa do botao; o botao existe para quem NAO
    * tem o altcots do cargo, e abre o dialogo SigOpAlC, onde outro usuario
    * autoriza a alteracao com usuario e senha.
    *
    * Observar que o legado usa aqui so os DOIS primeiros termos (cargo),
    * sem o crSigCdMoe.Cotas - este ultimo vale apenas para a digitacao na
    * celula. Nao acrescentar o termo da moeda.
    *====================================================================
    PROCEDURE ObterVisibilidadeBotaoCotacao(par_cEscolha)
        LOCAL loc_lVisivel, loc_cEscolha

        IF VARTYPE(par_cEscolha) = "C"
            loc_cEscolha = UPPER(ALLTRIM(par_cEscolha))
        ELSE
            loc_cEscolha = UPPER(ALLTRIM(THIS.this_cEscolhaPai))
        ENDIF

        loc_lVisivel = !(THIS.this_lAltCots AND INLIST(loc_cEscolha, "INSERIR", "ALTERAR"))

        RETURN loc_lVisivel
    ENDPROC

    *====================================================================
    * PodeUsarBotaoCotacao - When do btnCotacao legado:
    *   Return Inlist(ThisForm.ParentForm.pcEscolha,[INSERIR],[ALTERAR])
    * Em modo PROCURAR o botao fica desabilitado.
    *====================================================================
    PROCEDURE PodeUsarBotaoCotacao(par_cEscolha)
        LOCAL loc_cEscolha

        IF VARTYPE(par_cEscolha) = "C"
            loc_cEscolha = UPPER(ALLTRIM(par_cEscolha))
        ELSE
            loc_cEscolha = UPPER(ALLTRIM(THIS.this_cEscolhaPai))
        ENDIF

        RETURN INLIST(loc_cEscolha, "INSERIR", "ALTERAR")
    ENDPROC

    *====================================================================
    * PrepararCursorCotacao - Load do form legado, transcrito LITERAL:
    *   Set Decimals to 5
    *   Select TmpCot
    *   Delete All For Empty(CMoes)
    *   Replace All aValos With Valos
    *   Go Top
    *
    * Set Decimals to 5 porque a cotacao eh numeric(11,6) em SigCdCot.
    * O SET DELETED ON eh necessario: o legado roda em data session
    * compartilhada, onde vale o SET DELETED ON do config.prg; em data
    * session PRIVADA o SET volta ao default do VFP e as linhas apagadas
    * voltariam a aparecer na grade. O SET eh escopado a data session,
    * entao nao vaza para o resto do sistema.
    *====================================================================
    PROCEDURE PrepararCursorCotacao(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_oErro
        loc_lSucesso = .F.

        THIS.this_cMensagemErro = ""

        IF VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(ALLTRIM(par_cAliasCursor))
            loc_cAlias = ALLTRIM(par_cAliasCursor)
        ELSE
            loc_cAlias = ALLTRIM(THIS.this_cCursorCotacao)
        ENDIF

        TRY
            IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
                *-- Legado: Set Decimals to 5
                SET DECIMALS TO 5
                SET DELETED ON

                SELECT (loc_cAlias)

                *-- Legado: Delete All For Empty(CMoes) - descarta as linhas
                *-- em branco que o cursor do form pai tenha trazido
                IF TYPE(loc_cAlias + ".cmoes") == "C"
                    DELETE ALL FOR EMPTY(cmoes)
                ENDIF

                *-- Legado: Replace All aValos With Valos - copia de
                *-- seguranca para o Cancelar poder desfazer a edicao
                IF TYPE(loc_cAlias + ".avalos") == "N" AND TYPE(loc_cAlias + ".valos") == "N"
                    REPLACE ALL avalos WITH valos
                ENDIF

                *-- Legado: Go Top (a grade eh repintada pelo Form)
                GO TOP

                THIS.this_cCursorCotacao = loc_cAlias
                loc_lSucesso = THIS.CarregarDoCursor(loc_cAlias)

                *-- cursor valido e vazio nao eh erro: o documento pode nao
                *-- ter nenhuma moeda a cotar
                IF !loc_lSucesso AND RECCOUNT(loc_cAlias) = 0
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Cursor de cota" + CHR(231) + CHR(245) + "es [" + ;
                    loc_cAlias + "] n" + CHR(227) + "o est" + CHR(225) + " dispon" + ;
                    CHR(237) + "vel."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao preparar o cursor de cota" + CHR(231) + CHR(245) + ;
                "es:" + CHR(13) + loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * DesfazerCotacoes - btnSair.Click do legado, transcrito LITERAL:
    *   Set Decimals To 2
    *   Replace All Valos With aValos
    *
    * Restaura TODAS as linhas ao valor que tinham quando o dialogo abriu.
    * Quem fecha a tela eh o Form (ThisForm.Release do legado).
    *====================================================================
    PROCEDURE DesfazerCotacoes(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_oErro
        loc_lSucesso = .F.

        THIS.this_cMensagemErro = ""

        IF VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(ALLTRIM(par_cAliasCursor))
            loc_cAlias = ALLTRIM(par_cAliasCursor)
        ELSE
            loc_cAlias = ALLTRIM(THIS.this_cCursorCotacao)
        ENDIF

        TRY
            *-- Legado: Set Decimals To 2
            SET DECIMALS TO 2

            IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
                SELECT (loc_cAlias)

                IF TYPE(loc_cAlias + ".valos") == "N" AND TYPE(loc_cAlias + ".avalos") == "N"
                    REPLACE ALL valos WITH avalos
                    GO TOP
                    THIS.this_nValorAtual = THIS.this_nValorAnterior
                ENDIF

                loc_lSucesso = .T.
            ELSE
                *-- sem cursor nao ha o que desfazer, e o Cancelar segue
                *-- fechando a tela, como no legado
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao desfazer as cota" + CHR(231) + CHR(245) + "es:" + ;
                CHR(13) + loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * AplicarCotacaoAutorizada - btnCotacao.Click do legado, LITERAL:
    *   Do Form SigOpAlC With TmpCot.CMoes, TmpCot.Valos, ThisForm.dDatas
    *                    To lcRetorno
    *   If (MLine(lcRetorno, 1) = [OK])
    *       Replace Valos With Val(MLine(lcRetorno, 2)) In TmpCot
    *       If Used([TprMvCab])
    *           Replace CotUsus With MLine(lcRetorno, 3) In TprMvCab
    *       EndIf
    *   EndIf
    *
    * Quem abre o dialogo FormSigOpAlC eh o Form; aqui entra o retorno
    * dele ("OK" + CHR(13) + valor + CHR(13) + usuario, ou "CANCELADO").
    *
    * REPLACE sem ALL de proposito: o legado grava SO a linha corrente do
    * cursor de cotacao (a moeda que o usuario escolheu), e o cotusus vai
    * para a linha corrente do cabecalho do documento.
    *
    * Retorno .F. com this_cMensagemErro VAZIO significa CANCELADO pelo
    * usuario - nao eh falha, e o Form nao exibe erro nesse caso.
    *====================================================================
    PROCEDURE AplicarCotacaoAutorizada(par_cRetorno, par_cAliasCursor, par_cAliasCabecalho)
        LOCAL loc_lSucesso, loc_cAlias, loc_cAliasCab, loc_cRetorno
        LOCAL loc_nCotacao, loc_cUsuarioAut, loc_oErro
        loc_lSucesso = .F.

        THIS.this_cMensagemErro = ""

        loc_cRetorno = IIF(VARTYPE(par_cRetorno) = "C", par_cRetorno, "")

        IF VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(ALLTRIM(par_cAliasCursor))
            loc_cAlias = ALLTRIM(par_cAliasCursor)
        ELSE
            loc_cAlias = ALLTRIM(THIS.this_cCursorCotacao)
        ENDIF

        IF VARTYPE(par_cAliasCabecalho) = "C" AND !EMPTY(ALLTRIM(par_cAliasCabecalho))
            loc_cAliasCab = ALLTRIM(par_cAliasCabecalho)
        ELSE
            loc_cAliasCab = ALLTRIM(THIS.this_cCursorCabecalho)
        ENDIF

        TRY
            *-- Legado: If (MLine(lcRetorno, 1) = [OK])
            IF ALLTRIM(MLINE(loc_cRetorno, 1)) == "OK"
                *-- Legado: Val(MLine(lcRetorno, 2)) / MLine(lcRetorno, 3)
                loc_nCotacao    = VAL(ALLTRIM(MLINE(loc_cRetorno, 2)))
                loc_cUsuarioAut = PADR(ALLTRIM(MLINE(loc_cRetorno, 3)), 10)

                IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
                    SELECT (loc_cAlias)

                    IF !EOF(loc_cAlias) AND TYPE(loc_cAlias + ".valos") == "N"
                        *-- Legado: Replace Valos With ... In TmpCot
                        REPLACE valos WITH loc_nCotacao IN (loc_cAlias)
                        THIS.this_nValorAtual = loc_nCotacao
                        loc_lSucesso = .T.
                    ELSE
                        THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + ;
                            " linha de cota" + CHR(231) + CHR(227) + "o selecionada."
                    ENDIF
                ELSE
                    THIS.this_cMensagemErro = "Cursor de cota" + CHR(231) + CHR(245) + "es [" + ;
                        loc_cAlias + "] n" + CHR(227) + "o est" + CHR(225) + " dispon" + ;
                        CHR(237) + "vel."
                ENDIF

                *-- Legado: If Used([TprMvCab]) / Replace CotUsus With ...
                *-- SigMvCab.cotusus char(10) - usuario que autorizou
                IF loc_lSucesso AND !EMPTY(loc_cAliasCab) AND USED(loc_cAliasCab)
                    IF TYPE(loc_cAliasCab + ".cotusus") == "C"
                        REPLACE cotusus WITH loc_cUsuarioAut IN (loc_cAliasCab)
                    ENDIF
                ENDIF

                IF loc_lSucesso
                    THIS.this_cUsuarioAutorizacao = loc_cUsuarioAut
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao aplicar a cota" + CHR(231) + CHR(227) + ;
                "o autorizada:" + CHR(13) + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * RegistrarCelulaCorrente - When da celula Cotacao do legado:
    *   ThisForm.AntValue = This.Value
    * Guarda o valor que a celula tinha ao receber o foco, para a
    * comparacao antes/depois da digitacao.
    *====================================================================
    PROCEDURE RegistrarCelulaCorrente(par_nValor)
        IF VARTYPE(par_nValor) = "N"
            THIS.this_nAntValue = par_nValor
        ELSE
            THIS.this_nAntValue = THIS.this_nValorAtual
        ENDIF

        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - chave de SigCdMoe (cmoes), usada pelo
    * RegistrarAuditoria herdado de BusinessBase.
    *
    * PROTECTED porque a BusinessBase declara assim: o modificador da
    * classe base PREVALECE, e chamar de fora estouraria "Property not
    * found" em runtime.
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cMoeda)
    ENDPROC

    *====================================================================
    * LimparDados - devolve o BO ao estado inicial, preservando os alias
    * de cursor que o form pai configurou
    *====================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cMoeda              = ""
        THIS.this_cDescricaoMoeda     = ""
        THIS.this_lMoedaCotada        = .F.
        THIS.this_nValorAtual         = 0
        THIS.this_nValorAnterior      = 0
        THIS.this_nAntValue           = 0
        THIS.this_cUsuarioAutorizacao = ""
        THIS.this_cMensagemErro       = ""

        RETURN .T.
    ENDPROC

ENDDEFINE
