*==============================================================================
* sigoppedBO.prg - Business Object para Formsigopped (Informar Pedido)
* Herda de BusinessBase
*
* ATENCAO: Este form eh um dialogo OPERACIONAL (modal) que NAO possui tabela
* propria no SQL Server. Ele le/atualiza o cursor crTpmMvItn, que pertence ao
* FORM PAI (tela de movimentacao que abre este dialogo) - por isso
* this_cTabela fica vazio e this_cCampoChave aponta para a chave do ITEM
* dentro desse cursor (cItens), usada pelo legado em
* "Update crTpmMvItn Set ... Where cItens = lnItem".
*==============================================================================
DEFINE CLASS sigoppedBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades (campos exibidos/manipulados pelo dialogo Informar Pedido)
    *--------------------------------------------------------------------------
    this_cItens        = ""   && cItens - chave do item em crTpmMvItn (form pai)
    this_cProduto      = ""   && crTpmMvItn.cPros - codigo do produto
    this_cDescProduto  = ""   && crTpmMvItn.DPros - descricao do produto
    this_cCor          = ""   && crTpmMvItn.CodCors - codigo da cor
    this_cTamanho      = ""   && crTpmMvItn.CodTams - tamanho atual do item
    this_cTamanhoNovo  = ""   && tamanho escolhido na grade (quando TipoEstos em 3,4)
    this_cPedido       = ""   && CsTmpPed.Abrevs - abreviacao do pedido/vendedor
    this_nQtde         = 0    && quantidade de itens sem abreviacao
    this_nRepetir      = 0    && quantidade de itens a repetir com a mesma abreviacao
    this_nPeso         = 0    && crTpmMvItn.Pesos - peso do item

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
            IF loc_lResultado
                THIS.this_cTabela     = ""
                THIS.this_cCampoChave = "cItens"
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega para as propriedades os dados do item
    * corrente de crTpmMvItn (cursor do form pai) - equivalente as leituras
    * lcCod/lcCor/lcTam/Pesos feitas pelo Init do dialogo legado.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            IF !EOF()
                THIS.this_cItens       = TRANSFORM(TratarNulo(cItens, 0))
                THIS.this_cProduto     = TratarNulo(cPros, "")
                THIS.this_cDescProduto = TratarNulo(DPros, "")
                THIS.this_cCor         = TratarNulo(CodCors, "")
                THIS.this_cTamanho     = TratarNulo(CodTams, "")
                THIS.this_nPeso        = TratarNulo(Pesos, 0)
                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave do item em crTpmMvItn (cursor do form pai)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cItens
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Este dialogo nao grava em tabela do SQL Server (so
    * atualiza o cursor crTpmMvItn do form pai via REPLACE - ver Init, que
    * por isso deixa this_cTabela vazio de proposito). Sobrescrito aqui so
    * para o log de auditoria identificar o cursor afetado em vez de uma
    * tabela vazia.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cChave, loc_cSQL, loc_lResultado
        loc_lResultado = .F.

        loc_cChave = THIS.ObterChavePrimaria()

        IF !EMPTY(loc_cChave) AND !(TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0)
            loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                "VALUES (" + EscaparSQL("crTpmMvItn") + ", " + ;
                EscaparSQL(par_cOperacao) + ", " + ;
                EscaparSQL(loc_cChave) + ", " + ;
                EscaparSQL(IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")) + ", GETDATE())"
            loc_lResultado = (SQLEXEC(gnConnHandle, loc_cSQL) > 0)
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Este dialogo nunca cria item novo em crTpmMvItn (os itens
    * sem abreviacao ja existem, criados pelo form pai antes de
    * abrir "Informar Pedido"); gravar eh sempre a mesma operacao do legado
    * btnGravar.Click, por isso delega para o mesmo metodo que Atualizar().
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        RETURN THIS.GravarAbreviacaoNosItens()
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Grava a abreviacao (pedido), o peso e o tamanho novo nos
    * itens sem abreviacao de crTpmMvItn - equivalente ao btnGravar.Click legado.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN THIS.GravarAbreviacaoNosItens()
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarAbreviacaoNosItens - Transcricao de SIGOPPED.OK.btnGravar.Click:
    * para cada repeticao pedida (this_nRepetir), localiza em crTpmMvItn o
    * proximo item do MESMO produto/cor/tamanho ainda sem abreviacao
    * (Abrevis vazio) e grava a abreviacao do pedido, o peso e o tamanho
    * escolhido; replica tambem para o item-pai (cItem2 = 0) e para o
    * operador do pedido (CsTmpPed.Opers), quando existir.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GravarAbreviacaoNosItens()
        LOCAL loc_lResultado, loc_nContador, loc_nItem, loc_oErro

        loc_lResultado = .F.

        *-- Estado de erro zerado a cada tentativa, como BusinessBase.Salvar()
        *-- faz: sem isto a mensagem de uma falha anterior sobreviveria e o
        *-- chamador (Formsigopped.BtnSalvarClick) a exibiria de novo.
        THIS.this_cMensagemErro = ""
        THIS.this_lErroExibido  = .F.

        TRY
            IF !USED("crTpmMvItn")
                THIS.this_cMensagemErro = "Cursor de itens do pedido (crTpmMvItn) n" + CHR(227) + "o est" + CHR(225) + " aberto."
            ELSE
                FOR loc_nContador = 1 TO THIS.this_nRepetir
                    SELECT cItens FROM crTpmMvItn ;
                        WHERE cPros = THIS.this_cProduto ;
                          AND CodCors = THIS.this_cCor ;
                          AND CodTams = THIS.this_cTamanho ;
                          AND EMPTY(Abrevis) ;
                        INTO CURSOR csItemAbr READWRITE

                    IF RECCOUNT("csItemAbr") > 0
                        loc_nItem = csItemAbr.cItens

                        SELECT crTpmMvItn
                        REPLACE Abrevis WITH THIS.this_cPedido, ;
                                Pesos   WITH THIS.this_nPeso, ;
                                CodTams WITH THIS.this_cTamanhoNovo ;
                            FOR cItens = loc_nItem

                        IF USED("CsTmpPed") AND !EMPTY(CsTmpPed.Opers)
                            SELECT crTpmMvItn
                            REPLACE Opers WITH CsTmpPed.Opers FOR cItem2 = loc_nItem
                        ENDIF

                        *-- Posiciona explicitamente no item gravado (o legado
                        *-- conta com o ponteiro deixado pelo SELECT anterior,
                        *-- o que o VFP9 nao garante) antes de conferir se eh
                        *-- item de topo (cItem2 = 0).
                        SELECT crTpmMvItn
                        LOCATE FOR cItens = loc_nItem

                        IF FOUND() AND crTpmMvItn.cItem2 = 0 AND RECCOUNT("crTpmMvItn") > 0
                            REPLACE Abrevis WITH THIS.this_cPedido FOR cItem2 = loc_nItem
                        ENDIF
                    ENDIF
                ENDFOR

                IF USED("csItemAbr")
                    USE IN csItemAbr
                ENDIF

                loc_lResultado = .T.
            ENDIF

            IF loc_lResultado
                THIS.RegistrarAuditoria(IIF(THIS.this_lNovoRegistro, "INSERT", "UPDATE"))
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao gravar pedido nos itens: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            *-- Marca a falha como JA exibida para o chamador nao repetir a
            *-- mensagem (mesmo contrato de BusinessBase.ExibirFalha()).
            THIS.this_lErroExibido = .T.
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE
