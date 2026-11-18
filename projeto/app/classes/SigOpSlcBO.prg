*==============================================================================
* SigOpSlcBO.prg
*
* Business Object para FormSigOpSlc - Dialogo de Selecao de Moeda (e Conta,
* bloco permanentemente oculto - ver NOTA abaixo)
* Legado: SigOpSlc.SCX (task803)
*
* Tabela: SigCdMoe (somente CONSULTA/VALIDACAO, nunca gravacao)
*
*------------------------------------------------------------------------------
* FUNCAO DA TELA
*
* Dialogo FILHO, modal e sem barra de titulo (no SCX: WindowType = 1,
* TitleBar = 0, ControlBox ausente/Closable = .F., 800 x 400, BorderStyle = 2),
* aberto por um form pai que guarda a referencia em ThisForm.ParentForm
* (RESERVED3/ClassInfo do SCX = "parentform"). O legado abre assim:
*
*     Do Form SigOpSlc With _GetConta, _GetMoeda, ThisForm
*
* Os dois primeiros parametros ligam/desligam blocos de controles (Visible),
* e o terceiro eh o form que vai receber o resultado.
*
*------------------------------------------------------------------------------
* O CONTRATO - O QUE VOLTA PARA O FORM PAI
*
* Os dois botoes escrevem DIRETO em ThisForm.ParentForm, sem metodo
* intermediario:
*
*     Cancela.Click  -> ThisForm.ParentForm.CanceladoExterno = .T. / Release
*     Confirma.Click -> ThisForm.ParentForm.MoedaMaior = ThisForm.get_cd_moeda.Value / Release
*
* Ou seja: o UNICO dado que realmente sai desta tela eh o codigo da moeda
* escolhida (ou a confirmacao de que o usuario cancelou). O bloco de
* Grupo/Conta NUNCA alimenta o pai - ver a nota abaixo sobre por que ele
* existe no SCX mas esta morto.
*
*------------------------------------------------------------------------------
* NOTA - O BLOCO DE CONTA/GRUPO ESTA PERMANENTEMENTE OCULTO (regra #17)
*
* O Init legado recebe _GetConta como parametro e, na linha seguinte,
* SOBRESCREVE o valor recebido:
*
*     LParameters _GetConta, _GetMoeda, _Parent
*     _GetConta = .f.                    && <- ignora o que o chamador mandou
*     This.Grade.Visible     = _GetConta
*     This.Get_Grupo.Visible = _GetConta
*     This.Get_Conta.Visible = _GetConta
*     This.Get_dConta.Visible = _GetConta
*     This.SayGrupo.Visible  = _GetConta
*     This.SayConta.Visible  = _GetConta
*
* Isso significa que a Grade (RecordSource = "TmpCliente"), os campos
* Get_Grupo/Get_Conta/Get_DConta (ControlSource = crSigCdPgr.Grupos/Contas) e
* os respectivos Say ficam SEMPRE invisiveis, para QUALQUER chamador - eh
* codigo morto no legado, e se transcreve LITERAL (regra #17: nao se
* "corrige" removendo o hardcode nem se reativa o bloco). As properties deste
* BO que espelham esse bloco (this_cGrupo/this_cConta/this_cDConta) existem
* so para completude estrutural (paridade com os controles do SCX) - nenhum
* fluxo as alimenta de fato.
*
* Os validadores desses campos (Get_Grupo.Valid/Get_Conta.Valid/
* Get_DConta.Valid) chamam fAcessoContab()/fAcessoContas(), que JA EXISTEM
* como helpers globais em utils\functions.prg (linhas 709 e 991) - nao
* precisam de wrapper neste BO, e ficam no Form (camada de UI), que eh quem
* os aciona via BINDEVENT.
*
*------------------------------------------------------------------------------
* A MOEDA - O UNICO DADO QUE DE FATO CIRCULA
*
* get_cd_moeda.Valid e get_ds_moeda.Valid fazem Seek em 'crSigCdMoe' (cursor
* global legado) por CMoes/DMoes e, nao achando, abrem fwBuscaSel. No sistema
* novo o equivalente eh validar/buscar direto em SigCdMoe via SQLEXEC e
* FormBuscaAuxiliar (padrao do projeto - docs/lookup_implementation.md),
* dai this_cTabela = "SigCdMoe" / this_cCampoChave = "CMoes" neste BO.
*
* Quando _GetMoeda = .T., o Init legado tambem busca um valor DEFAULT de
* moeda varrendo um cursor do CHAMADOR (TmpBaixa, Scan For Tipos = 'X',
* pega o campo moedas da primeira linha). TmpBaixa, assim como TmpCliente e
* crSigCdPgr acima, NAO pertence a este dialogo - sao cursores que o form
* pai ja deixa abertos antes do Do Form (mesmo padrao documentado em
* SigOpCtdBO.prg: tabela do chamador nao se declara aqui). A leitura desse
* default fica para a fase do Form (que tem acesso ao cursor do pai), nao
* para este BO.
*
*------------------------------------------------------------------------------
* AJUSTE DE ALTURA (Init legado) - FICA NA FASE DO FORM, NAO AQUI
*
*     If !_GetMoeda
*         This.Height = This.Height - 25
*     Else
*         <busca o default em TmpBaixa>
*     Endif
*     If !_GetConta And _GetMoeda      && _GetConta e sempre .F., entao
*         <reposiciona get_cd_moeda/get_ds_moeda/SayMoeda e This.Height=100>
*     Endif
*
* Esse ajuste eh layout puro (Height/Top de controles) - nao ha property de
* BO que o represente. this_lExibirMoeda eh o que decide qual dos dois
* ramos a fase do Form vai aplicar.
*
*------------------------------------------------------------------------------
* NOTA DE ARQUITETURA - SOMENTE LEITURA/VALIDACAO
*
* Este BO nao sobrescreve Inserir()/Atualizar()/ExecutarExclusao(): o dump do
* legado nao tem INSERT/UPDATE/DELETE/TABLEUPDATE - a tela so VALIDA um
* codigo de moeda e devolve a escolha ao chamador. O comportamento padrao
* herdado de BusinessBase (recusar a gravacao) ja eh o correto.
*==============================================================================

DEFINE CLASS SigOpSlcBO AS BusinessBase

    *--------------------------------------------------------------------------
    * BLOCO MOEDA - o unico dado que de fato sai desta tela
    *--------------------------------------------------------------------------
    this_lExibirMoeda = .T.    && legado: parametro _GetMoeda (Visible de get_cd_moeda/get_ds_moeda/SayMoeda)
    this_cCdMoeda      = ""    && legado: Get_cd_moeda.Value -> crSigCdMoe.CMoes -> ParentForm.MoedaMaior
    this_cDsMoeda      = ""    && legado: Get_ds_moeda.Value -> crSigCdMoe.DMoes (so exibicao)

    *--------------------------------------------------------------------------
    * BLOCO GRUPO/CONTA - SEMPRE OCULTO no legado (_GetConta = .f. hardcoded
    * no Init, independente do que o chamador passar - ver nota no cabecalho).
    * Mantido so por completude estrutural com os controles do SCX.
    *--------------------------------------------------------------------------
    this_lExibirConta = .F.    && legado: _GetConta, FORCADO .F. no Init (regra #17)
    this_cGrupo       = ""     && legado: Get_Grupo.Value  -> crSigCdPgr.Grupos (bloco oculto)
    this_cConta       = ""     && legado: Get_Conta.Value  -> crSigCdPgr.Contas (bloco oculto)
    this_cDConta      = ""     && legado: Get_DConta.Value -> descricao da conta (bloco oculto)

    *--------------------------------------------------------------------------
    * RESULTADO DA INTERACAO - o que os dois botoes decidem
    *--------------------------------------------------------------------------
    this_lCancelado = .F.      && legado: ParentForm.CanceladoExterno (Cancela.Click)
    this_lConfirmou = .F.      && .T. so quando o botao Confirma foi acionado

    *==========================================================================
    * Init - Inicializa o Business Object
    *
    * Parametros, ambos opcionais:
    *     par_lExibirConta - aceito por simetria com a assinatura do form
    *                        legado (_GetConta), mas SEMPRE sobrescrito para
    *                        .F. - o legado forca isso incondicionalmente logo
    *                        apos o LParameters, e isso se transcreve literal
    *                        (regra #17), nao se "corrige".
    *     par_lExibirMoeda - legado: _GetMoeda. Omitido, assume .T. (bloco de
    *                        moeda visivel, que eh o uso real desta tela).
    *==========================================================================
    PROCEDURE Init(par_lExibirConta, par_lExibirMoeda)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdMoe"
            THIS.this_cCampoChave = "CMoes"

            *-- Legado: _GetConta = .f. (hardcode incondicional, regra #17)
            THIS.this_lExibirConta = .F.

            *-- Legado: _GetMoeda (parametro real, sem hardcode)
            IF VARTYPE(par_lExibirMoeda) = "L"
                THIS.this_lExibirMoeda = par_lExibirMoeda
            ELSE
                THIS.this_lExibirMoeda = .T.
            ENDIF

            THIS.this_cCdMoeda  = ""
            THIS.this_cDsMoeda  = ""
            THIS.this_cGrupo    = ""
            THIS.this_cConta    = ""
            THIS.this_cDConta   = ""
            THIS.this_lCancelado = .F.
            THIS.this_lConfirmou = .F.

            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SigOpSlcBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega this_cCdMoeda/this_cDsMoeda a partir de UM
    * registro de cursor com as colunas cmoes/dmoes (SigCdMoe).
    *
    * Usado por ValidarMoedaPorCodigo/ValidarMoedaPorDescricao logo depois do
    * SQLEXEC, e tambem pelo Form apos o usuario escolher um registro no
    * FormBuscaAuxiliar (regra #37 do CLAUDE.md).
    *
    * PUBLIC (sem PROTECTED) porque BusinessBase.CarregarDoCursor() ja eh
    * PUBLIC - PROTECTED aqui so na subclasse nao bloqueia a chamada externa
    * (regra #51), mas manter o MESMO modificador da base evita confusao.
    *
    * SELECT (par_cAliasCursor) ANTES de acessar os campos - a sintaxe
    * campo nao existe em VFP9 (regra #9 da migration_guide).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_oErro
        loc_lSucesso = .F.

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C", ALLTRIM(par_cAliasCursor), "")

        TRY
            IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
                SELECT (loc_cAlias)

                IF !EOF(loc_cAlias)
                    *-- cmoes char(3) - legado: crSigCdMoe.CMoes
                    IF TYPE(loc_cAlias + ".cmoes") == "C"
                        THIS.this_cCdMoeda = TratarNulo(cmoes, "")
                    ENDIF

                    *-- dmoes char(15) - legado: crSigCdMoe.DMoes
                    IF TYPE(loc_cAlias + ".dmoes") == "C"
                        THIS.this_cDsMoeda = TratarNulo(dmoes, "")
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao ler os dados da moeda:" + CHR(13) + loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarMoedaPorCodigo - get_cd_moeda.Valid do legado:
    *
    *     If !IsEmpty(This.Value) And !Seek(This.Value, 'crSigCdMoe', 'CMoes')
    *         <abre fwBuscaSel, atualiza Cd/Ds com a escolha ou com '' se ESC>
    *     Else
    *         If IsEmpty(This.Value)
    *             <Cd e Ds viram ''>
    *         Endif
    *     Endif
    *
    * Equivalente no sistema novo: SQLEXEC em SigCdMoe por cmoes. Achando,
    * carrega this_cCdMoeda/this_cDsMoeda via CarregarDoCursor e devolve .T.
    * Vazio, limpa os dois e devolve .T. (o legado nao trata isso como erro).
    * Nao achando, PRESERVA o codigo digitado em this_cCdMoeda - NUNCA se
    * apaga o que o usuario digitou (regra #37/#50) - e devolve .F. para o
    * Form abrir o FormBuscaAuxiliar (equivalente ao fwBuscaSel do legado).
    *==========================================================================
    PROCEDURE ValidarMoedaPorCodigo(par_cCodigo)
        LOCAL loc_lSucesso, loc_cCodigo, loc_cSQL, loc_nResultado, loc_oErro
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        loc_cCodigo = IIF(VARTYPE(par_cCodigo) = "C", ALLTRIM(par_cCodigo), "")

        *-- Legado: Else / If IsEmpty(This.Value) -> ambos limpos, sem erro
        IF EMPTY(loc_cCodigo)
            THIS.this_cCdMoeda = ""
            THIS.this_cDsMoeda = ""
            RETURN .T.
        ENDIF

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cCdMoeda = loc_cCodigo
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados " + ;
                    "n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            ELSE
                IF USED("cursor_4c_Moeda")
                    IF CURSORGETPROP("Buffering", "cursor_4c_Moeda") > 1
                        TABLEREVERT(.T., "cursor_4c_Moeda")
                    ENDIF
                    USE IN cursor_4c_Moeda
                ENDIF

                loc_cSQL = "SELECT cmoes, dmoes" + ;
                           "  FROM SigCdMoe" + ;
                           " WHERE cmoes = " + EscaparSQL(loc_cCodigo)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Moeda")

                IF loc_nResultado > 0 AND USED("cursor_4c_Moeda") AND RECCOUNT("cursor_4c_Moeda") > 0
                    SELECT cursor_4c_Moeda
                    GO TOP
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Moeda")
                ELSE
                    *-- Nao achou: preserva o digitado, NAO limpa (regra #50)
                    THIS.this_cCdMoeda = loc_cCodigo
                    IF loc_nResultado < 0
                        THIS.this_cMensagemErro = "Erro ao consultar a moeda:" + CHR(13) + CapturarErroSQL()
                    ENDIF
                    loc_lSucesso = .F.
                ENDIF

                IF USED("cursor_4c_Moeda")
                    USE IN cursor_4c_Moeda
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao validar a moeda:" + CHR(13) + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarMoedaPorDescricao - get_ds_moeda.Valid do legado: mesma logica de
    * ValidarMoedaPorCodigo, mas o Seek original casa por DMoes em vez de
    * CMoes:
    *
    *     If !IsEmpty(This.Value) And !Seek(This.Value, 'crSigCdMoe', 'DMoes')
    *         <abre fwBuscaSel>
    *     Else
    *         If IsEmpty(This.Value)
    *             <Cd e Ds viram ''>
    *         Endif
    *     Endif
    *==========================================================================
    PROCEDURE ValidarMoedaPorDescricao(par_cDescricao)
        LOCAL loc_lSucesso, loc_cDescricao, loc_cSQL, loc_nResultado, loc_oErro
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        loc_cDescricao = IIF(VARTYPE(par_cDescricao) = "C", ALLTRIM(par_cDescricao), "")

        IF EMPTY(loc_cDescricao)
            THIS.this_cCdMoeda = ""
            THIS.this_cDsMoeda = ""
            RETURN .T.
        ENDIF

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cDsMoeda = loc_cDescricao
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados " + ;
                    "n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            ELSE
                IF USED("cursor_4c_Moeda")
                    IF CURSORGETPROP("Buffering", "cursor_4c_Moeda") > 1
                        TABLEREVERT(.T., "cursor_4c_Moeda")
                    ENDIF
                    USE IN cursor_4c_Moeda
                ENDIF

                loc_cSQL = "SELECT cmoes, dmoes" + ;
                           "  FROM SigCdMoe" + ;
                           " WHERE dmoes = " + EscaparSQL(loc_cDescricao)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Moeda")

                IF loc_nResultado > 0 AND USED("cursor_4c_Moeda") AND RECCOUNT("cursor_4c_Moeda") > 0
                    SELECT cursor_4c_Moeda
                    GO TOP
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Moeda")
                ELSE
                    *-- Nao achou: preserva o digitado, NAO limpa (regra #50)
                    THIS.this_cDsMoeda = loc_cDescricao
                    IF loc_nResultado < 0
                        THIS.this_cMensagemErro = "Erro ao consultar a moeda:" + CHR(13) + CapturarErroSQL()
                    ENDIF
                    loc_lSucesso = .F.
                ENDIF

                IF USED("cursor_4c_Moeda")
                    USE IN cursor_4c_Moeda
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao validar a moeda:" + CHR(13) + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - contrato padrao do projeto (carga pela chave
    * primaria). Para este BO a chave EH a propria moeda, entao eh sinonimo
    * de ValidarMoedaPorCodigo (mesmo padrao de SigOpCotBO.CarregarPorCodigo).
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        RETURN THIS.ValidarMoedaPorCodigo(par_cCodigo)
    ENDPROC

    *==========================================================================
    * Confirmar - legado: Confirma.Click
    *     ThisForm.ParentForm.MoedaMaior = ThisForm.get_cd_moeda.value
    *     ThisForm.Release
    *
    * O legado NAO valida o valor antes de atribuir - mesmo com
    * get_cd_moeda vazio, o Confirma grava e fecha (regra #17: transcrever
    * literal, sem inventar validacao nova). Copiar this_cCdMoeda para a
    * property do form pai e fechar a tela (Release) ficam no Form, que eh
    * quem tem a referencia ao pai e ao proprio ciclo de vida da janela.
    *==========================================================================
    PROCEDURE Confirmar()
        THIS.this_lConfirmou = .T.
        THIS.this_lCancelado = .F.
        RETURN .T.
    ENDPROC

    *==========================================================================
    * Cancelar - legado: Cancela.Click
    *     ThisForm.ParentForm.CanceladoExterno = .T.
    *     ThisForm.Release
    *==========================================================================
    PROCEDURE Cancelar()
        THIS.this_lCancelado = .T.
        THIS.this_lConfirmou = .F.
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - chave de SigCdMoe (cmoes). PROTECTED porque a
    * BusinessBase declara assim (o modificador da base PREVALECE - regra
    * #51); nunca chamado de fora, e aqui so existe por completude, ja que
    * este BO nunca chega a RegistrarAuditoria (Inserir/Atualizar nao sao
    * sobrescritos - ver NOTA DE ARQUITETURA no cabecalho do arquivo).
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCdMoeda)
    ENDPROC

    *==========================================================================
    * LimparDados - devolve o BO ao estado inicial (mesmo valor do Init,
    * exceto this_lExibirMoeda/this_lExibirConta, que sao parametros de
    * abertura da tela e nao mudam durante o uso do dialogo).
    *==========================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cCdMoeda   = ""
        THIS.this_cDsMoeda   = ""
        THIS.this_cGrupo     = ""
        THIS.this_cConta     = ""
        THIS.this_cDConta    = ""
        THIS.this_lCancelado = .F.
        THIS.this_lConfirmou = .F.

        RETURN .T.
    ENDPROC

ENDDEFINE
