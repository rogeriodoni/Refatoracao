*==============================================================================
* SigOpChcBO.prg
*
* Business Object para SigOpChc (Historico da Carteira)
* Dialogo OPERACIONAL chamado pelo Cadastro de Cheques (FormCheque/SigCdChe)
* para exibir o historico de movimentos de carteira (SigCcChm + SigCqLcm) de
* um cheque especifico, e permitir gerar a baixa automatica de um cheque
* devolvido (via SigCdOpt).
*
* Tabelas: SigCcChm (historico), SigCqLcm (lote - origem do codigo da
*          operacao), SigCdOpt (parametros da operacao, usado na baixa)
*==============================================================================

DEFINE CLASS SigOpChcBO AS BusinessBase

    *-- Chave do cheque cujo historico de carteira esta sendo exibido
    *-- (equivalente a CrSigChe.Nums no legado, recebido do form pai)
    this_cNums = ""

    *-- Taxa de juros a.m. (%) usada na baixa automatica do cheque devolvido
    *-- (equivalente a lnTaxa/Get_taxa no legado)
    this_nTaxa = 0

    *-- Nome do cursor populado com o historico (SigCcChm JOIN SigCqLcm)
    *-- que alimenta o grid de historico da tela
    this_cCursorHistorico = "cursor_4c_Historico"

    *-- Codigo da operacao do registro de historico corrente
    *-- (equivalente a crSigccchm.codigos no legado)
    this_cOperacaoCodigo = ""

    *-- Flag "Devolvido" (S/N) da operacao corrente (SigCdOpt.devolvidos)
    this_cDevolvidoFlag = ""

    *-- Codigo da operacao que EXECUTA a baixa automatica do cheque devolvido.
    *-- CUIDADO com o nome da coluna: o valor eh SigCdOpt.Operacaos da linha
    *-- cujo SigCdOpt.Opants aponta para a operacao CORRENTE - ou seja, a
    *-- operacao SUCESSORA (a que desfaz), nao a anterior. Eh o que o legado
    *-- passa ao SigCdChe (crSigcdOpt.operacaos, apos "Locate for opants =
    *-- crSigccchm.codigos"). Chamar isto de "operacao anterior" - como a
    *-- migracao fazia - inverte o sentido e sai errado na tela.
    this_cOperacaoBaixa = ""

    *==========================================================================
    * Init - Inicializa Business Object
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela = "SigCcChm"
        THIS.this_cCampoChave = "nums"

        THIS.this_cNums = ""
        THIS.this_nTaxa = 0
        THIS.this_cCursorHistorico = "cursor_4c_Historico"
        THIS.this_cOperacaoCodigo = ""
        THIS.this_cDevolvidoFlag = ""
        THIS.this_cOperacaoBaixa = ""

        RETURN .T.
    ENDPROC

    *==========================================================================
    * Buscar - Carrega o historico de carteira (SigCcChm JOIN SigCqLcm) do
    * cheque identificado por par_cNums, populando THIS.this_cCursorHistorico
    *
    * Equivalente literal ao legado (SIGOPCHC.Init):
    *   Select b.codigos, a.* From SigCcChm a, sigcqlcm b
    *   Where Nums = ']+CrSigChe.Nums+[' and a.numlotes = b.numlotes Order By DtSis
    *==========================================================================
    PROCEDURE Buscar(par_cNums)
        LOCAL loc_cSQL, loc_nResultado, loc_cCursorTmp

        IF EMPTY(par_cNums)
            par_cNums = THIS.this_cNums
        ENDIF

        IF EMPTY(par_cNums)
            THIS.this_cMensagemErro = "N" + CHR(250) + "mero do cheque n" + CHR(227) + "o informado"
            RETURN .F.
        ENDIF

        THIS.this_cNums = par_cNums

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        loc_cCursorTmp = THIS.this_cCursorHistorico + "Tmp"

        IF USED(loc_cCursorTmp)
            USE IN (loc_cCursorTmp)
        ENDIF

        loc_cSQL = "SELECT b.Codigos, a.* " + ;
                   "FROM SigCcChm a, SigCqLcm b " + ;
                   "WHERE a.Nums = " + EscaparSQL(par_cNums) + " " + ;
                   "AND a.NumLotes = b.NumLotes " + ;
                   "ORDER BY a.DtSis"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTmp)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = "Erro ao buscar hist" + CHR(243) + "rico da carteira" + CHR(13) + CapturarErroSQL()
            RETURN .F.
        ENDIF

        *-- Cursor temporario (somente-leitura) -> cursor final READWRITE,
        *-- preservando o binding do Grid quando ja existir (regra Erro179/#21a)
        IF USED(THIS.this_cCursorHistorico)
            SELECT (THIS.this_cCursorHistorico)
            ZAP
            APPEND FROM DBF(loc_cCursorTmp)
        ELSE
            SELECT * FROM (loc_cCursorTmp) INTO CURSOR (THIS.this_cCursorHistorico) READWRITE
        ENDIF

        IF USED(loc_cCursorTmp)
            USE IN (loc_cCursorTmp)
        ENDIF

        IF USED(THIS.this_cCursorHistorico)
            SELECT (THIS.this_cCursorHistorico)
            GO TOP
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega THIS.this_cOperacaoCodigo/this_cNums a partir
    * da linha corrente do cursor de historico (par_cAliasCursor), usado antes
    * de VerificarBaixaAutomatica() para saber qual linha o usuario selecionou
    * no grid (equivalente ao legado referenciar crSigccchm.codigos direto)
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)
        IF EOF()
            RETURN .F.
        ENDIF

        *-- SO a operacao (equivalente a crSigccchm.codigos do legado). O
        *-- numero do cheque NAO se le daqui: o cursor da grade eh o
        *-- cursor-molde de 7 campos criado em ConfigurarGrid (Dtsis/Grucarts/
        *-- Concarts/Grupos/Contas/Numlotes/Codigos), e Buscar() o repopula
        *-- com ZAP + APPEND FROM DBF(), que casa por NOME - logo a coluna
        *-- Nums do SELECT (a.* de SigCcChm) nunca entra nele e ler Nums aqui
        *-- estourava "Variable NUMS is not found" em CADA clique de "Baixa
        *-- Cheque". O legado tambem nao le o numero do historico: ele usa
        *-- CrSigChe.Nums, o cursor do form PAI - aqui o equivalente eh
        *-- THIS.this_cNums, que o Form passa no Init e Buscar() preserva.
        THIS.this_cOperacaoCodigo = TratarNulo(Codigos, "C")

        RETURN .T.
    ENDPROC

    *==========================================================================
    * VerificarBaixaAutomatica - Verifica se a operacao informada (tipicamente
    * THIS.this_cOperacaoCodigo, carregada por CarregarDoCursor) representa um
    * cheque devolvido e, em caso positivo, localiza a operacao que EXECUTA a
    * baixa automatica - a linha de SigCdOpt cujo Opants aponta para a operacao
    * corrente -, guardando o Operacaos DELA em THIS.this_cOperacaoBaixa.
    *
    * Equivalente literal ao legado (SIGOPCHC.Fwbtng1.Click):
    *   Select crSigcdOpt
    *   Locate for operacaos = crSigccchm.codigos
    *   If Found()
    *       If crSigcdOpt.devolvidos = 'S'
    *           Select crSigcdOpt
    *           Locate for opants = crSigccchm.codigos
    *           If Found() ... (abre SigCdChe com crSigcdOpt.operacaos)
    *
    * NAO leva PROTECTED: o Form chama este metodo de fora ao clicar no botao
    * "Baixa Cheque" (regra #51 - metodo chamado de fora do BO nunca eh
    * PROTECTED em nenhum nivel da heranca).
    *==========================================================================
    FUNCTION VerificarBaixaAutomatica(par_cCodigoOperacao)
        LOCAL loc_cSQL, loc_nResultado, loc_lPodeBaixar

        loc_lPodeBaixar = .F.
        THIS.this_cDevolvidoFlag = ""
        THIS.this_cOperacaoBaixa = ""

        IF EMPTY(par_cCodigoOperacao)
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        *-- Equivalente a: Locate for operacaos = crSigccchm.codigos
        loc_cSQL = "SELECT Devolvidos FROM SigCdOpt WHERE Operacaos = " + EscaparSQL(par_cCodigoOperacao)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_HistOpt")

        IF loc_nResultado > 0 AND USED("cursor_4c_HistOpt")
            SELECT cursor_4c_HistOpt
            IF !EOF()
                THIS.this_cDevolvidoFlag = TratarNulo(Devolvidos, "C")
            ENDIF
        ENDIF

        IF USED("cursor_4c_HistOpt")
            USE IN cursor_4c_HistOpt
        ENDIF

        *-- Equivalente a: If crSigcdOpt.devolvidos = 'S'
        IF UPPER(ALLTRIM(THIS.this_cDevolvidoFlag)) == "S"
            *-- Equivalente a: Locate for opants = crSigccchm.codigos
            loc_cSQL = "SELECT Operacaos FROM SigCdOpt WHERE Opants = " + EscaparSQL(par_cCodigoOperacao)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_HistOptAnt")

            IF loc_nResultado > 0 AND USED("cursor_4c_HistOptAnt")
                SELECT cursor_4c_HistOptAnt
                IF !EOF()
                    THIS.this_cOperacaoBaixa = TratarNulo(Operacaos, "C")
                    loc_lPodeBaixar = !EMPTY(THIS.this_cOperacaoBaixa)
                ENDIF
            ENDIF

            IF USED("cursor_4c_HistOptAnt")
                USE IN cursor_4c_HistOptAnt
            ENDIF
        ENDIF

        RETURN loc_lPodeBaixar
    ENDFUNC

    *==========================================================================
    * ObterChavePrimaria - Chave do dialogo eh o numero do cheque (this_cNums),
    * usado por RegistrarAuditoria caso venha a ser chamado
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cNums
    ENDPROC

    *-- Este BO atende um dialogo OPERACIONAL de CONSULTA (Historico da
    *-- Carteira): o legado apenas EXIBE o historico de SigCcChm/SigCqLcm e,
    *-- quando a operacao corrente eh um cheque devolvido, aciona a baixa
    *-- automatica abrindo outro formulario (SigCdChe) - nao ha INSERT/UPDATE/
    *-- DELETE proprios deste dialogo sobre SigCcChm. O comportamento padrao
    *-- herdado de BusinessBase para Inserir/Atualizar/ExecutarExclusao
    *-- (recusar a operacao) ja eh o correto aqui, por isso nao sao
    *-- sobrescritos.

ENDDEFINE
