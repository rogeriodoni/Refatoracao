*====================================================================
* SigOpAlCBO.prg
*
* Business Object para Alteracao de Cotacao (SigOpAlC)
* Dialogo de autorizacao: usuario+senha com permissao de cargo
* (AltCots = 'S') autoriza a mudanca da cotacao de uma moeda,
* respeitando a variacao maxima percentual do cargo (VarCots).
* Tabela de referencia: SigCdMoe (Cmoes/Cotas)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigOpAlCBO AS BusinessBase

    *-- Dados de entrada (parametros recebidos pelo form na abertura)
    this_cMoeda = ""    && SigCdMoe.Cmoes char(3) - moeda cuja cotacao sera alterada
    this_cDescricaoMoeda = ""    && SigCdMoe.dmoes char(15) - descricao da moeda
    this_dData  = {}    && Data de referencia para a cotacao (par_ldData do legado)

    *-- Cotacao digitada pelo usuario e cotacao oficial para comparacao
    this_nCotacao       = 0     && Get_Cotacao.Value - valor digitado pelo usuario
    this_nCotacaoAtual  = 0     && ThisForm.Cotacao - cotacao oficial (fBuscarCotacao)

    *-- Autorizacao (usuario + senha + cargo)
    this_cUsuario           = ""    && SigCdUsu.Usuarios - usuario que autoriza
    this_cSenha             = ""    && Senha digitada (nao persistida - uso transitorio na validacao)
    this_cCargoUsuario      = ""    && SigCdUsu.CCargs - cargo do usuario autenticado
    this_nVariacaoMaxima    = 0     && SigCdCrg.VarCots - variacao percentual maxima permitida ao cargo
    this_cAutorizaCotacao   = ""    && SigCdCrg.AltCots ('S'/'N') - cargo pode alterar cotacao

    *-- Estado da moeda e resultado final do dialogo
    this_lMoedaPermiteAlteracao = .F.    && SigCdMoe.Cotas - moeda permite alteracao de cotacao
    this_cRetorno               = ""     && "OK" + Chr(13) + valor + Chr(13) + usuario, ou "CANCELADO"
    this_cCampoFoco             = ""     && "USUARIO"/"SENHA"/"COTACAO" - campo a focar apos falha

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdMoe"
            THIS.this_cCampoChave = "Cmoes"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SigOpAlCBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - sobrescreve o hook de BusinessBase mapeando as
    * colunas de SigCdMoe (tabela/chave deste BO) do cursor aberto para
    * as propriedades. Fonte UNICA da leitura: nenhum outro metodo le as
    * colunas da moeda direto do cursor.
    *
    * NAO leva PROTECTED - CarregarDoCursor eh PUBLIC na BusinessBase e o
    * Form pode chama-lo de fora; PROTECTED em qualquer nivel da heranca
    * faz a chamada externa estourar "Property not found" em runtime.
    *
    * SELECT (par_cAliasCursor) ANTES de acessar os campos: a sintaxe
    * campo nao existe em VFP9.
    *
    * Existencia de campo conferida com TYPE(alias + ".col") - PEMSTATUS
    * exige OBJETO no 1o argumento e estoura com nome de cursor.
    *
    * cotas eh bit NOT NULL no schema e chega ao VFP ora como Logico ora
    * como Numerico conforme o driver ODBC, por isso o VARTYPE antes de
    * comparar. TratarNulo NAO serve para esta coluna: ele devolve o valor
    * padrao para QUALQUER logico vazio, e .F. eh valor legitimo de cotas.
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias
        loc_lSucesso = .F.

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C", ALLTRIM(par_cAliasCursor), "")

        TRY
            IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
                SELECT (loc_cAlias)

                IF !EOF(loc_cAlias)
                    *-- cmoes char(3) - chave da moeda
                    IF TYPE(loc_cAlias + ".cmoes") == "C"
                        THIS.this_cMoeda = TratarNulo(cmoes, "")
                    ENDIF

                    *-- dmoes char(15) - descricao da moeda
                    IF TYPE(loc_cAlias + ".dmoes") == "C"
                        THIS.this_cDescricaoMoeda = TratarNulo(dmoes, "")
                    ENDIF

                    *-- cotas bit - moeda permite alteracao de cotacao
                    IF TYPE(loc_cAlias + ".cotas") != "U"
                        THIS.this_lMoedaPermiteAlteracao = IIF(VARTYPE(cotas) = "L", ;
                            cotas, (NVL(cotas, 0) = 1))
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao ler os dados da moeda:" + CHR(13) + ;
                loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarMoeda - Init legado: CursorQuery('SigCdMoe','CrMoe','Cmoes',
    * Padr(lcMoeda,3)) + checagem de crMoe.Cotas. Carrega this_cMoeda e
    * this_lMoedaPermiteAlteracao; quem decide fechar o dialogo quando a
    * moeda nao permite (Activate.Else do legado: ThisForm.Release) eh o
    * Form, apos chamar este metodo.
    *====================================================================
    PROCEDURE CarregarMoeda(par_cMoeda)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        THIS.this_cMensagemErro = ""
        THIS.this_cMoeda = PADR(ALLTRIM(NVL(par_cMoeda, "")), 3)
        THIS.this_lMoedaPermiteAlteracao = .F.

        TRY
            IF USED("cursor_4c_Moe")
                USE IN cursor_4c_Moe
            ENDIF

            loc_cSQL = "SELECT cmoes, dmoes, cotas FROM SigCdMoe " + ;
                       "WHERE cmoes = " + EscaparSQL(THIS.this_cMoeda)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Moe")

            IF loc_nResultado > 0 AND USED("cursor_4c_Moe") AND !EOF("cursor_4c_Moe")
                *-- a leitura das colunas fica concentrada em CarregarDoCursor
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Moe")
                IF !loc_lSucesso AND EMPTY(THIS.this_cMensagemErro)
                    THIS.this_cMensagemErro = "Falha ao ler os dados da moeda."
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Moeda n" + CHR(227) + "o cadastrada."
            ENDIF

            IF USED("cursor_4c_Moe")
                USE IN cursor_4c_Moe
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarUsuario - Get_Usuario.Valid / 1a parte do btnConfirmar.Click:
    * localiza o usuario ATIVO em SigCdUsu e confere se o cargo dele
    * (SigCdCrg.AltCots = 'S') autoriza alteracao de cotacao. Preenche
    * this_cUsuario/this_cCargoUsuario/this_nVariacaoMaxima/
    * this_cAutorizaCotacao. NAO valida a senha (ver ValidarSenha).
    *====================================================================
    PROCEDURE ValidarUsuario(par_cUsuario)
        LOCAL loc_lSucesso, loc_cUsuarioPad, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        loc_cUsuarioPad = PADR(ALLTRIM(NVL(par_cUsuario, "")), 10)

        IF EMPTY(ALLTRIM(loc_cUsuarioPad))
            THIS.this_cMensagemErro = "Usu" + CHR(225) + "rio Inv" + CHR(225) + "lido !!"
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_Usuar")
                USE IN cursor_4c_Usuar
            ENDIF

            loc_cSQL = "SELECT usuarios, senhas, ccargs FROM SigCdUsu " + ;
                       "WHERE cativos <> 'N' AND usuarios = " + EscaparSQL(loc_cUsuarioPad) + ;
                       " ORDER BY usuarios"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Usuar")

            IF loc_nResultado <= 0 OR !USED("cursor_4c_Usuar") OR RECCOUNT("cursor_4c_Usuar") = 0
                THIS.this_cMensagemErro = "Usu" + CHR(225) + "rio Inv" + CHR(225) + "lido !!"
            ELSE
                SELECT cursor_4c_Usuar
                GO TOP
                THIS.this_cUsuario      = TratarNulo(usuarios, "")
                THIS.this_cCargoUsuario = TratarNulo(ccargs, "")

                IF THIS.ValidarCargoAutorizacao(THIS.this_cCargoUsuario)
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Usu" + CHR(225) + "rio sem acesso para alterar cota" + ;
                        CHR(231) + CHR(227) + "o !!"
                ENDIF
            ENDIF

            IF USED("cursor_4c_Usuar")
                USE IN cursor_4c_Usuar
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarCargoAutorizacao - confere SigCdCrg.AltCots = 'S' para o cargo
    * informado e carrega this_nVariacaoMaxima (VarCots), usado depois por
    * ValidarVariacaoCotacao.
    *====================================================================
    PROCEDURE ValidarCargoAutorizacao(par_cCargo)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cCargoPad
        loc_lSucesso = .F.

        loc_cCargoPad = PADR(ALLTRIM(NVL(par_cCargo, "")), 10)
        THIS.this_cAutorizaCotacao = ""
        THIS.this_nVariacaoMaxima  = 0

        TRY
            IF USED("cursor_4c_Carg")
                USE IN cursor_4c_Carg
            ENDIF

            loc_cSQL = "SELECT ccargs, altcots, varcots FROM SigCdCrg " + ;
                       "WHERE ccargs = " + EscaparSQL(loc_cCargoPad)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carg")

            IF loc_nResultado > 0 AND USED("cursor_4c_Carg") AND !EOF("cursor_4c_Carg")
                SELECT cursor_4c_Carg
                THIS.this_cAutorizaCotacao = TratarNulo(altcots, "")
                THIS.this_nVariacaoMaxima  = TratarNulo(varcots, 0)
                loc_lSucesso = (THIS.this_cAutorizaCotacao == "S")
            ENDIF

            IF USED("cursor_4c_Carg")
                USE IN cursor_4c_Carg
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarSenha - Get_Senha.Valid / 2a parte do btnConfirmar.Click:
    * confere a senha digitada contra SigCdUsu.Senhas (via fCriptografar)
    * para o usuario informado. Mesma comparacao do legado: Padr(Alltrim(
    * senha_digitada),10) == fCriptografar(crUsuar.Senhas).
    *====================================================================
    PROCEDURE ValidarSenha(par_cUsuario, par_cSenha)
        LOCAL loc_lSucesso, loc_cUsuarioPad, loc_cSenhaPad, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        loc_cUsuarioPad = PADR(ALLTRIM(NVL(par_cUsuario, "")), 10)
        loc_cSenhaPad   = PADR(ALLTRIM(NVL(par_cSenha, "")), 10)

        TRY
            IF USED("cursor_4c_Usuar")
                USE IN cursor_4c_Usuar
            ENDIF

            loc_cSQL = "SELECT usuarios, senhas FROM SigCdUsu " + ;
                       "WHERE cativos <> 'N' AND usuarios = " + EscaparSQL(loc_cUsuarioPad) + ;
                       " ORDER BY usuarios"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Usuar")

            IF loc_nResultado <= 0 OR !USED("cursor_4c_Usuar") OR RECCOUNT("cursor_4c_Usuar") = 0
                THIS.this_cMensagemErro = "Usu" + CHR(225) + "rio Inv" + CHR(225) + "lido !!"
            ELSE
                SELECT cursor_4c_Usuar
                GO TOP
                IF loc_cSenhaPad == fCriptografar(senhas)
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Senha incorreta !!"
                ENDIF
            ENDIF

            IF USED("cursor_4c_Usuar")
                USE IN cursor_4c_Usuar
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterCotacaoOficial - fBuscarCotacao(moeda, data, poDataMgr) do
    * legado. Guarda o resultado em this_nCotacaoAtual.
    *====================================================================
    PROCEDURE ObterCotacaoOficial(par_cMoeda, par_dData)
        THIS.this_nCotacaoAtual = fBuscarCotacao(par_cMoeda, par_dData, gnConnHandle)
        RETURN THIS.this_nCotacaoAtual
    ENDPROC

    *====================================================================
    * ValidarVariacaoCotacao - Get_Cotacao.Valid / btnConfirmar.Click:
    *   VarCot = (Round(cotacaoDigitada / cotacaoOficial, 2) - 1) * 100
    * Autorizado somente se Abs(VarCot) <= VarCots (variacao maxima do
    * cargo, carregada por ValidarCargoAutorizacao). Formula transcrita
    * literalmente do legado - NAO reescrever (regra do calculo legado).
    *====================================================================
    PROCEDURE ValidarVariacaoCotacao(par_nCotacaoDigitada, par_nCotacaoOficial)
        LOCAL loc_nVariacao
        loc_nVariacao = (ROUND(par_nCotacaoDigitada / par_nCotacaoOficial, 2) - 1) * 100
        RETURN (ABS(loc_nVariacao) <= THIS.this_nVariacaoMaxima)
    ENDPROC

    *====================================================================
    * ProcessarAutorizacao - btnConfirmar.Click do legado: encadeia
    * ValidarUsuario -> ValidarSenha -> cotacao preenchida -> variacao
    * percentual maxima, na MESMA ordem e com as MESMAS mensagens do
    * legado. Quando autoriza, monta this_cRetorno = "OK" + Chr(13) +
    * cotacao + Chr(13) + usuario (igual a ThisForm.Retorna original).
    * Em caso de falha, this_cMensagemErro e this_cCampoFoco ("USUARIO"/
    * "SENHA"/"COTACAO") indicam o que exibir e onde dar SetFocus - quem
    * exibe a mensagem (MsgAviso) e da o SetFocus eh o Form.
    *====================================================================
    PROCEDURE ProcessarAutorizacao(par_cUsuario, par_cSenha, par_nCotacao)
        THIS.this_cMensagemErro = ""
        THIS.this_cCampoFoco    = ""
        THIS.this_cRetorno      = ""
        THIS.this_cSenha        = PADR(ALLTRIM(NVL(par_cSenha, "")), 10)

        IF !THIS.ValidarUsuario(par_cUsuario)
            THIS.this_cCampoFoco = "USUARIO"
            RETURN .F.
        ENDIF

        IF !THIS.ValidarSenha(par_cUsuario, par_cSenha)
            THIS.this_cCampoFoco = "SENHA"
            RETURN .F.
        ENDIF

        IF NVL(par_nCotacao, 0) = 0
            THIS.this_cMensagemErro = "Cota" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida !!"
            THIS.this_cCampoFoco = "COTACAO"
            RETURN .F.
        ENDIF

        THIS.this_nCotacao = par_nCotacao
        THIS.ObterCotacaoOficial(THIS.this_cMoeda, THIS.this_dData)

        IF !THIS.ValidarVariacaoCotacao(THIS.this_nCotacao, THIS.this_nCotacaoAtual)
            THIS.this_cMensagemErro = "Cota" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida !!"
            THIS.this_cCampoFoco = "COTACAO"
            RETURN .F.
        ENDIF

        THIS.this_cRetorno = "OK" + CHR(13) + ;
            STR(THIS.this_nCotacao, 15, 4) + CHR(13) + ;
            ALLTRIM(THIS.this_cUsuario)

        RETURN .T.
    ENDPROC

    *====================================================================
    * CancelarAutorizacao - btnSair.Click do legado: ThisForm.Retorna =
    * "CANCELADO". Quem fecha o form (Release) eh quem chama este metodo.
    *====================================================================
    PROCEDURE CancelarAutorizacao()
        THIS.this_cRetorno = "CANCELADO"
        RETURN .T.
    ENDPROC

    *====================================================================
    * Este dialogo NAO persiste nenhuma tabela propria (SigOpAlC nao
    * existe no banco - e um dialogo modal de autorizacao que apenas LE
    * SigCdMoe/SigCdUsu/SigCdCrg e devolve this_cRetorno para quem abriu).
    * Inserir()/Atualizar()/ExecutarExclusao()/ObterChavePrimaria() e
    * RegistrarAuditoria() NAO sao sobrescritos aqui - o comportamento
    * padrao herdado de BusinessBase ja eh o correto para este caso.
    *====================================================================

ENDDEFINE
