*====================================================================
* SigOpChbBO.prg
*
* Business Object para o dialogo "Procurar Cheque" (SIGOPCHB)
* Tabela pesquisada: SigChe (busca por Vencimento/Banco/Agencia/
* Conta/Cheque/Controle/Protocolo/Arquivo - PK: nums)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigOpChbBO AS BusinessBase

    *-- Propriedades de criterio de busca (mapeamento para tabela SigChe)
    this_cBanco       = ""    && bancos    char(3)  - criterio Banco
    this_cAgencia     = ""    && agencias  char(4)  - criterio Agencia
    this_cConta       = ""    && ncontas   char(10) - criterio Conta (legado usa nContas no WHERE, nao contas)
    this_cCheque      = ""    && ncheques  char(6)  - criterio N. Cheque
    this_dVencimento  = {}    && vencs     datetime - criterio Vencimento
    this_nValor       = 0     && valors    numeric(11,2) - criterio Valor
    this_cControle    = ""    && nums      char(8)  - criterio Controle (chave unica)
    this_cProtocolo   = ""    && protocolos char(8) - criterio Protocolo (via SigCqChm)
    this_cArquivo     = ""    && numeros   char(6)  - criterio Arquivo (numero sequencial de leitura)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigChe"
            THIS.this_cCampoChave = "nums"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SigOpChbBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega os criterios de busca a partir de um
    * registro de SigChe (usado ao reabrir o dialogo com um cheque ja
    * localizado, para repopular os campos de pesquisa)
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        THIS.this_cBanco      = TratarNulo(bancos, "")
        THIS.this_cAgencia    = TratarNulo(agencias, "")
        THIS.this_cConta      = TratarNulo(ncontas, "")
        THIS.this_cCheque     = TratarNulo(ncheques, "")
        THIS.this_dVencimento = ConverterParaData(vencs)
        THIS.this_nValor      = TratarNulo(valors, 0)
        THIS.this_cControle   = TratarNulo(nums, "")
        THIS.this_cProtocolo  = TratarNulo(protocolos, "")
        THIS.this_cArquivo    = TratarNulo(numeros, "")

        loc_lResultado = .T.
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna o valor da chave primaria (nums)
    * para uso em RegistrarAuditoria
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cControle
    ENDPROC

    *====================================================================
    * Inserir/Atualizar/ExecutarExclusao - NAO sobrescritos de proposito.
    *
    * O dialogo legado SIGOPCHB (Procura.Click) so executa SEEK no cursor
    * local crSigChe e, na falha, um SELECT via SqlExecute cujo resultado
    * eh copiado (Insert Into CrSigChe From Array Memvar) para o CURSOR
    * local do form pai - nunca ha INSERT/UPDATE/DELETE contra a tabela
    * SigChe no legado. O comportamento padrao herdado de BusinessBase
    * (recusar a operacao) ja eh o correto para este BO somente-leitura.
    *====================================================================

    *====================================================================
    * BuscarCheque - Transcricao da logica de busca do Procura.Click do
    * legado (SIGOPCHB.Procura.Click): monta o WHERE pela PRIMEIRA
    * condicao preenchida, na MESMA ordem de prioridade do Do Case legado
    * (Vencimento > Valor > Banco > Agencia > Conta > Cheque > Controle >
    * Protocolo > Arquivo), e devolve em par_cCursorDestino as linhas de
    * SigChe que casam (equivalente ao "Select * From SigChe Where
    * <lcWher>" seguido do Scan/Insert Into CrSigChe do legado - aqui o
    * Scatter/Insert fica a cargo do form, que mescla o resultado em
    * cursor_4c_SigChe).
    *
    * O legado faz Seek LOCAL em crSigChe antes de ir ao banco (evita
    * reconsultar o que ja estava no cursor do form pai). Esta migracao
    * nao reproduz esse Seek: o form nao tem como compartilhar o cursor
    * do chamador por nome (THIS dialogo fecha com Hide(), nao Release() -
    * ver FormSigOpChb.FecharDialogo - e devolve o resultado so pelo
    * cursor_4c_SigChe que ele mesmo mantem). O form, ao mesclar o
    * resultado desta busca em cursor_4c_SigChe, descarta duplicata pela
    * PK (Nums) - o estado final (quais cheques entram na lista) eh o
    * mesmo; muda so que uma nova busca pode reconsultar o banco por um
    * cheque ja encontrado antes, dentro do MESMO dialogo aberto.
    *
    * Retorna o numero de linhas encontradas (>=0) ou -1 em erro SQL. Se
    * TODOS os criterios estiverem vazios, retorna 0 sem consultar o
    * banco (fiel ao Do Case sem Case casado do legado, que nao executa
    * SqlExecute nenhum).
    *====================================================================
    PROCEDURE BuscarCheque(par_cBanco, par_cAgencia, par_cConta, par_cCheque, ;
            par_dVencimento, par_nValor, par_cControle, par_cProtocolo, ;
            par_cArquivo, par_cCursorDestino)
        LOCAL loc_cWhere, loc_nResultado, loc_cNumsProtocolo

        loc_cWhere     = ""
        loc_nResultado = 0

        DO CASE
        CASE !EMPTY(par_dVencimento)
            loc_cWhere = "Vencs = " + FormatarDataSQL(par_dVencimento)
            IF !EMPTY(par_cBanco)
                loc_cWhere = loc_cWhere + " AND Bancos = " + EscaparSQL(par_cBanco)
            ENDIF
            IF !EMPTY(par_cAgencia)
                loc_cWhere = loc_cWhere + " AND Agencias = " + EscaparSQL(par_cAgencia)
            ENDIF
            IF !EMPTY(par_cConta)
                loc_cWhere = loc_cWhere + " AND nContas = " + EscaparSQL(par_cConta)
            ENDIF
            IF !EMPTY(par_cCheque)
                loc_cWhere = loc_cWhere + " AND nCheques = " + EscaparSQL(par_cCheque)
            ENDIF

        CASE !EMPTY(par_nValor)
            loc_cWhere = "Valors = " + FormatarNumeroSQL(par_nValor, 2)
            IF !EMPTY(par_cBanco)
                loc_cWhere = loc_cWhere + " AND Bancos = " + EscaparSQL(par_cBanco)
            ENDIF
            IF !EMPTY(par_cAgencia)
                loc_cWhere = loc_cWhere + " AND Agencias = " + EscaparSQL(par_cAgencia)
            ENDIF
            IF !EMPTY(par_cConta)
                loc_cWhere = loc_cWhere + " AND nContas = " + EscaparSQL(par_cConta)
            ENDIF
            IF !EMPTY(par_cCheque)
                loc_cWhere = loc_cWhere + " AND nCheques = " + EscaparSQL(par_cCheque)
            ENDIF

        CASE !EMPTY(par_cBanco)
            loc_cWhere = "Bancos = " + EscaparSQL(par_cBanco)
            IF !EMPTY(par_cAgencia)
                loc_cWhere = loc_cWhere + " AND Agencias = " + EscaparSQL(par_cAgencia)
            ENDIF
            IF !EMPTY(par_cConta)
                loc_cWhere = loc_cWhere + " AND nContas = " + EscaparSQL(par_cConta)
            ENDIF
            IF !EMPTY(par_cCheque)
                loc_cWhere = loc_cWhere + " AND nCheques = " + EscaparSQL(par_cCheque)
            ENDIF

        CASE !EMPTY(par_cAgencia)
            loc_cWhere = "Agencias = " + EscaparSQL(par_cAgencia)
            IF !EMPTY(par_cConta)
                loc_cWhere = loc_cWhere + " AND nContas = " + EscaparSQL(par_cConta)
            ENDIF
            IF !EMPTY(par_cCheque)
                loc_cWhere = loc_cWhere + " AND nCheques = " + EscaparSQL(par_cCheque)
            ENDIF

        CASE !EMPTY(par_cConta)
            loc_cWhere = "nContas = " + EscaparSQL(par_cConta)
            IF !EMPTY(par_cCheque)
                loc_cWhere = loc_cWhere + " AND nCheques = " + EscaparSQL(par_cCheque)
            ENDIF

        CASE !EMPTY(par_cCheque)
            loc_cWhere = "nCheques = " + EscaparSQL(par_cCheque)

        CASE !EMPTY(par_cControle)
            loc_cWhere = "Nums = " + EscaparSQL(par_cControle)

        CASE !EMPTY(par_cProtocolo)
            loc_cNumsProtocolo = THIS.BuscarNumsPorProtocolo(par_cProtocolo)
            IF !EMPTY(loc_cNumsProtocolo)
                loc_cWhere = "Nums = " + EscaparSQL(loc_cNumsProtocolo)
            ENDIF

        CASE !EMPTY(par_cArquivo)
            loc_cWhere = "Numeros = " + EscaparSQL(TRANSFORM(VAL(par_cArquivo), "@L 999999"))
        ENDCASE

        IF !EMPTY(loc_cWhere)
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT * FROM SigChe WHERE " + loc_cWhere, par_cCursorDestino)
            IF loc_nResultado < 0
                MsgErro(CapturarErroSQL(), "SigOpChbBO.BuscarCheque")
                RETURN -1
            ENDIF
        ENDIF

        RETURN loc_nResultado
    ENDPROC

    *====================================================================
    * BuscarNumsPorProtocolo - Transcricao do trecho do criterio Protocolo
    * no Procura.Click legado: ThisForm.Parentform.Podatamgr.CursorQuery(
    * 'SigCqChm','CrChm','Protocolos', Trans(Val(_ProcProtocolo),
    * '@L 99999999')) - localiza, em SigCqChm, o Nums do cheque associado
    * aquele protocolo formatado.
    *====================================================================
    PROTECTED PROCEDURE BuscarNumsPorProtocolo(par_cProtocolo)
        LOCAL loc_cProtocoloFmt, loc_nResultado, loc_cNums

        loc_cProtocoloFmt = TRANSFORM(VAL(par_cProtocolo), "@L 99999999")
        loc_cNums         = ""

        loc_nResultado = SQLEXEC(gnConnHandle, ;
            "SELECT Nums FROM SigCqChm WHERE Protocolos = " + EscaparSQL(loc_cProtocoloFmt), ;
            "cursor_4c_SigCqChmTmp")

        IF loc_nResultado > 0
            SELECT cursor_4c_SigCqChmTmp
            GO TOP
            loc_cNums = TratarNulo(Nums, "")
        ENDIF

        IF USED("cursor_4c_SigCqChmTmp")
            USE IN cursor_4c_SigCqChmTmp
        ENDIF

        RETURN loc_cNums
    ENDPROC

ENDDEFINE
