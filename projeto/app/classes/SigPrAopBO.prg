*============================================================================
* SigPrAopBO.prg - Business Object para Altera??o de Quantidade da O.P.
*
* Tabela principal : SigOpPic  (PK: cIdChaves char(20))
* Tabelas relacionadas:
*   - SigCdNec (EmpDNps = _Empr + DoppPads + Str(Nops,10)) -> ChkSubn (O.P. encerrada?)
*   - SigPdMvf (Nops, cIdChaves, CodPds, Qtds) -> produto e saldo total da O.P.
*   - SigCdPam (DoppPads, MascNums) -> parametros do sistema
*
* Form OPERACIONAL: permite dividir a quantidade de itens (Dopes+Numes) de
* uma Ordem de Producao ja liberada em novas sequencias (SeqDivs), gravando
* de volta em SigOpPic e atualizando o saldo total em SigPdMvf.
*
* O legado (Grupo_Conf.Salva.Click) NUNCA insere um novo registro em SigOpPic
* ou SigPdMvf - ele apenas redistribui a quantidade Qtds/SeqDivs entre linhas
* JA existentes (criadas em outro processo, fora deste form). Por isso este BO
* nao sobrescreve Inserir(): o comportamento padrao herdado de BusinessBase
* (recusar a operacao) ja eh o correto para esta entidade neste form.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
* Completado em: Fase 2 - Metodos CRUD (CarregarDoCursor/Atualizar/
*                ObterChavePrimaria/RegistrarAuditoria) + carga de itens
*                da O.P. (BuscarItensPorOP, equivalente ao Get_OP.Valid legado)
*============================================================================

DEFINE CLASS SigPrAopBO AS BusinessBase

    *==========================================================================
    * Propriedades de cabecalho - digitadas/exibidas nos campos Get_OP/Get_Produto
    *==========================================================================
    this_nNops        = 0     && numeric(10) - Numero da O.P. (Get_OP.Value)
    this_cCodProduto  = ""    && char(10)    - Codigo do produto (SigPdMvf.CodPds, exibido em Get_Produto)

    *==========================================================================
    * Propriedades de estado - resultado da validacao da O.P. digitada
    *==========================================================================
    this_lOPLocalizada = .F.  && .T. quando a O.P. foi encontrada em SigCdNec e esta liberada
    this_lOPEncerrada  = .F.  && .T. quando SigCdNec.ChkSubn indica O.P. ja encerrada

    *==========================================================================
    * Parametros do sistema (SigCdPam), carregados uma unica vez no Init
    *==========================================================================
    this_cDoppPads = ""       && char(20)     - Grupo/departamento padrao (SigCdPam.DoppPads), usado para montar EmpDNps
    this_nMascNums = 0        && numeric(1,0) - Tipo de mascara de numeracao (SigCdPam.MascNums), usado na formatacao do Pedido na grade

    *==========================================================================
    * Cursor de trabalho - grade de divisao de quantidade (equivalente ao
    * Temp_DivOp do legado). Criado/populado por BuscarItensPorOP().
    *==========================================================================
    this_cCursorItens = "cursor_4c_DivOp"

    *==========================================================================
    * Propriedades de item - espelham TODAS as colunas de SigOpPic usadas
    * neste form. Populadas por CarregarDoCursor() a partir de uma linha do
    * cursor (chave primaria = this_cIdChaves, casa com this_cCampoChave).
    *==========================================================================
    this_cIdChaves = ""       && char(20)     - SigOpPic.cIdChaves (PK)
    this_cDopes    = ""       && char(20)     - SigOpPic.Dopes
    this_nNumes    = 0        && numeric(6,0) - SigOpPic.Numes
    this_nQtds     = 0        && numeric(9,3) - SigOpPic.Qtds
    this_nSeqDivs  = 0        && numeric(3,0) - SigOpPic.SeqDivs
    this_dDataEs   = {}       && datetime     - SigOpPic.DataEs
    this_cObs      = ""       && text/memo    - SigOpPic.Obss
    this_cCpros    = ""       && char(14)     - SigOpPic.Cpros
    this_cCodCors  = ""       && char(4)      - SigOpPic.CodCors
    this_cCodTams  = ""       && char(4)      - SigOpPic.CodTams
    this_nCitens   = 0        && numeric(10,0)- SigOpPic.Citens

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela, chave primaria
    * e parametros do sistema (SigCdPam.DoppPads/MascNums), equivalente ao
    * ThisForm.poDataMgr.CursorQuery('SigCdPam', 'crSigCdPam', ...) do legado.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigOpPic"
            THIS.this_cCampoChave = "cIdChaves"

            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED("cursor_4c_SigCdPam")
                    USE IN cursor_4c_SigCdPam
                ENDIF

                SQLEXEC(gnConnHandle, "SELECT DoppPads, MascNums FROM SigCdPam", "cursor_4c_SigCdPam")

                IF USED("cursor_4c_SigCdPam") AND !EOF("cursor_4c_SigCdPam")
                    THIS.this_cDoppPads = PADR(TratarNulo(cursor_4c_SigCdPam.DoppPads, ""), 20)
                    THIS.this_nMascNums = TratarNulo(cursor_4c_SigCdPam.MascNums, 0)
                ENDIF

                IF USED("cursor_4c_SigCdPam")
                    USE IN cursor_4c_SigCdPam
                ENDIF
            ENDIF

            *-- Cria o cursor de trabalho vazio ja no Init, para que o Grid
            *-- do form possa ligar Column.ControlSource/RecordSource nele
            *-- durante InicializarForm (o cursor so recebe linhas de verdade
            *-- quando o usuario digitar uma O.P. valida em BuscarItensPorOP)
            THIS.CriarCursorItens()

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CriarCursorItens - Cria (ou ESVAZIA) o cursor local de divisao de
    * quantidade. Estrutura TRANSCRITA do legado (Create Cursor Temp_DivOp,
    * PROCEDURE Load do SIGPRAOP): mesma ordem, tipos e tamanhos de campo em
    * TODOS os lugares onde o cursor eh criado (unico ponto de criacao).
    *
    * Cursor JA existente eh esvaziado com ZAP, NUNCA fechado e recriado: o
    * legado tambem faz "Zap In Temp_DivOp" no inicio do Get_OP.Valid, e por um
    * motivo que vale igual aqui - fechar o alias DERRUBA o binding de quem
    * aponta para ele (grd_4c_Dados.RecordSource + as 5 Column.ControlSource +
    * edt_4c_Obss.ControlSource, todos ligados em InicializarForm). Recriando,
    * o usuario digitava a O.P. e a grade ficava permanentemente vazia mesmo
    * com o cursor cheio - sem erro e sem log, porque o CREATE CURSOR funciona.
    *==========================================================================
    PROTECTED PROCEDURE CriarCursorItens()
        LOCAL loc_cSafety

        IF USED("cursor_4c_DivOp")
            *-- Legado: Zap In Temp_DivOp (preserva a estrutura e o binding).
            *
            *-- SET SAFETY OFF em volta eh OBRIGATORIO, nao precaucao: com
            *-- SAFETY ON o ZAP abre o dialogo modal "Zap ... Are you sure?" e
            *-- CONGELA a tela. O form eh DataSession = 2, e SET SAFETY eh
            *-- escopado por data session: medido no VFP9 (2026-09-26), dentro
            *-- da datasession privada o SAFETY vale ON mesmo com SET SAFETY OFF
            *-- no main.prg - mesmo mecanismo que reseta SET DATE/CENTURY ali.
            loc_cSafety = SET("SAFETY")
            SET SAFETY OFF
            SELECT cursor_4c_DivOp
            ZAP IN cursor_4c_DivOp
            IF loc_cSafety = "ON"
                SET SAFETY ON
            ENDIF
        ELSE
            SET NULL ON
            CREATE CURSOR cursor_4c_DivOp (Qtds N(12,3), QtdDivs N(12,3), Dopes C(20), Numes N(6), ;
                Dataes D NULL, Obss M NULL, Nops N(10), SeqDivs N(3), Cpros C(10), CodCors C(4), ;
                CodTams C(4), Citens N(10))
            SET NULL OFF
        ENDIF
    ENDPROC

    *==========================================================================
    * BuscarItensPorOP - Valida a O.P. digitada e carrega os itens no cursor
    * de trabalho. Equivalente ao PROCEDURE Valid do Get_OP no legado:
    *   - monta EmpDNps = _Empr + DoppPads + Str(Nops,10) (chave POSICIONAL:
    *     as partes NAO sao ALLTRIM'adas, o padding faz parte da chave)
    *   - consulta SigCdNec por EmpDNps: se nao achar ou estiver encerrada
    *     (ChkSubn), preenche mensagem de erro e retorna sem carregar nada
    *   - achando e nao encerrada, busca o produto em SigPdMvf e os itens
    *     da O.P. em SigOpPic, populando cursor_4c_DivOp com QtdDivs = Qtds
    *     (valor inicial igual ao atual) e SeqDivs sequencial (Citens local)
    *
    * Retorno: .T. quando a consulta foi executada sem erro tecnico (mesmo
    * que a O.P. nao exista ou esteja encerrada - nesses casos this_cMensagemErro
    * e this_lOPEncerrada/this_lOPLocalizada indicam o motivo); .F. em erro
    * tecnico (falha de conexao/SQL).
    *==========================================================================
    PROCEDURE BuscarItensPorOP(par_nNops)
        LOCAL loc_lSucesso, loc_cPEdn, loc_nResultado, loc_nCItem, loc_oErro
        loc_lSucesso = .F.

        THIS.this_cMensagemErro = ""
        THIS.this_lOPLocalizada = .F.
        THIS.this_lOPEncerrada  = .F.
        THIS.this_cCodProduto   = ""
        THIS.this_nNops         = 0

        THIS.CriarCursorItens()

        IF VARTYPE(par_nNops) != "N" OR par_nNops = 0
            RETURN .T.
        ENDIF

        TRY
            loc_cPEdn = PADR(go_4c_Sistema.cCodEmpresa, 3) + PADR(THIS.this_cDoppPads, 20) + STR(par_nNops, 10)

            IF USED("cursor_4c_SigCdNec")
                USE IN cursor_4c_SigCdNec
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT ChkSubn FROM SigCdNec WHERE EmpDNps = " + EscaparSQL(loc_cPEdn), ;
                "cursor_4c_SigCdNec")

            IF loc_nResultado > 0 AND USED("cursor_4c_SigCdNec") AND !EOF("cursor_4c_SigCdNec")

                IF !cursor_4c_SigCdNec.ChkSubn
                    THIS.this_lOPLocalizada = .T.
                    THIS.this_nNops         = par_nNops

                    IF USED("cursor_4c_SigPdMvfOp")
                        USE IN cursor_4c_SigPdMvfOp
                    ENDIF
                    SQLEXEC(gnConnHandle, ;
                        "SELECT CodPds FROM SigPdMvf WHERE EmpDNps = " + EscaparSQL(loc_cPEdn), ;
                        "cursor_4c_SigPdMvfOp")
                    IF USED("cursor_4c_SigPdMvfOp") AND !EOF("cursor_4c_SigPdMvfOp")
                        THIS.this_cCodProduto = TratarNulo(cursor_4c_SigPdMvfOp.CodPds, "")
                    ENDIF
                    IF USED("cursor_4c_SigPdMvfOp")
                        USE IN cursor_4c_SigPdMvfOp
                    ENDIF

                    IF USED("cursor_4c_SigOpPicOp")
                        USE IN cursor_4c_SigOpPicOp
                    ENDIF
                    SQLEXEC(gnConnHandle, ;
                        "SELECT Dopes, Numes, Qtds, DataEs, Obss, Cpros, CodCors, CodTams, Citens " + ;
                        "FROM SigOpPic WHERE Nops = " + FormatarNumeroSQL(par_nNops, 0), ;
                        "cursor_4c_SigOpPicOp")

                    loc_nCItem = 1
                    IF USED("cursor_4c_SigOpPicOp")
                        SELECT cursor_4c_SigOpPicOp
                        SCAN
                            INSERT INTO cursor_4c_DivOp ;
                                (Dopes, Numes, Qtds, QtdDivs, Dataes, Obss, Nops, SeqDivs, Cpros, CodCors, CodTams, Citens) ;
                                VALUES ( ;
                                    cursor_4c_SigOpPicOp.Dopes, cursor_4c_SigOpPicOp.Numes, cursor_4c_SigOpPicOp.Qtds, ;
                                    cursor_4c_SigOpPicOp.Qtds, cursor_4c_SigOpPicOp.DataEs, cursor_4c_SigOpPicOp.Obss, ;
                                    par_nNops, loc_nCItem, cursor_4c_SigOpPicOp.Cpros, cursor_4c_SigOpPicOp.CodCors, ;
                                    cursor_4c_SigOpPicOp.CodTams, cursor_4c_SigOpPicOp.Citens)
                            loc_nCItem = loc_nCItem + 1
                        ENDSCAN
                        USE IN cursor_4c_SigOpPicOp
                    ENDIF

                    SELECT cursor_4c_DivOp
                    GO TOP

                    loc_lSucesso = .T.
                ELSE
                    THIS.this_lOPEncerrada  = .T.
                    THIS.this_cMensagemErro = "O.P. J" + CHR(225) + " Foi Encerrada!!!"
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "O.P. N" + CHR(227) + "o Localizada!!!"
                loc_lSucesso = .T.
            ENDIF

            IF USED("cursor_4c_SigCdNec")
                USE IN cursor_4c_SigCdNec
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas de uma linha de SigOpPic
    * (identificada por cIdChaves) para as propriedades this_ do BO.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF VARTYPE(par_cAliasCursor) != "C" OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        THIS.this_cIdChaves = TratarNulo(cIdChaves, "")
        THIS.this_nNops     = TratarNulo(Nops, 0)
        THIS.this_cDopes    = TratarNulo(Dopes, "")
        THIS.this_nNumes    = TratarNulo(Numes, 0)
        THIS.this_nQtds     = TratarNulo(Qtds, 0)
        THIS.this_nSeqDivs  = TratarNulo(SeqDivs, 0)
        THIS.this_dDataEs   = ConverterParaData(DataEs)
        THIS.this_cObs      = TratarNulo(Obss, "")
        THIS.this_cCpros    = TratarNulo(Cpros, "")
        THIS.this_cCodCors  = TratarNulo(CodCors, "")
        THIS.this_cCodTams  = TratarNulo(CodTams, "")
        THIS.this_nCitens   = TratarNulo(Citens, 0)

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Chave do registro "corrente" para auditoria.
    * Durante Atualizar(), this_cIdChaves eh reposicionado a cada UPDATE bem
    * sucedido (SigOpPic ou SigPdMvf), de forma que RegistrarAuditoria()
    * sempre registre a linha que acabou de ser gravada.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cIdChaves
    ENDPROC

    *==========================================================================
    * Atualizar - Confirma a divisao de quantidade (Grupo_Conf.Salva.Click do
    * legado). Passos, na mesma ordem do legado:
    *   1) Recarrega os itens ATUAIS da O.P. (cursor_4c_SigOpPicAtu)
    *   2) Zera SeqDivs de TODOS os itens da O.P. (banco + cursor local)
    *   3) Para cada linha de cursor_4c_DivOp, localiza o primeiro item com
    *      mesmo Dopes+Numes e SeqDivs=0 e grava Qtds/SeqDivs nele
    *   4) Recalcula o saldo total (Sum Qtds) e grava em SigPdMvf
    *   5) Commit (ou Rollback se qualquer passo falhar) - transacao manual,
    *      equivalente ao ThisForm.poDataMgr.Commit() do legado
    *
    * SET EXACT OFF durante o processamento: os SEEKs usam apenas PARTE da
    * chave composta do indice local (Nops, ou Nops+Citens) - com SET EXACT
    * ON (config.prg) o SEEK exigiria a chave INTEIRA e nunca casaria.
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_lOk, loc_nOP, loc_cSQL, loc_oErro, loc_cSetExactAnt
        LOCAL loc_nQtdDivs, loc_nSeqDivs, loc_nCitens, loc_cDopes, loc_nNumes
        LOCAL loc_nQtdTotal, loc_cChaveAtual

        loc_lSucesso = .F.
        loc_lOk      = .T.
        THIS.this_cMensagemErro = ""

        IF THIS.this_nNops = 0
            THIS.this_cMensagemErro = "O.P. n" + CHR(227) + "o informada."
            RETURN .F.
        ENDIF

        IF !USED("cursor_4c_DivOp") OR RECCOUNT("cursor_4c_DivOp") = 0
            THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + " itens para gravar."
            RETURN .F.
        ENDIF

        loc_nOP = THIS.this_nNops

        TRY
            loc_cSetExactAnt = SET("EXACT")
            SET EXACT OFF

            *-- 1) Recarrega os itens ATUAIS da O.P. direto do banco
            IF USED("cursor_4c_SigOpPicAtu")
                USE IN cursor_4c_SigOpPicAtu
            ENDIF
            SQLEXEC(gnConnHandle, ;
                "SELECT Nops, cIdChaves, Dopes, Numes, SeqDivs, Qtds, Citens FROM SigOpPic " + ;
                "WHERE Nops = " + FormatarNumeroSQL(loc_nOP, 0), "cursor_4c_SigOpPicAtu")

            IF !USED("cursor_4c_SigOpPicAtu")
                THIS.this_cMensagemErro = "Falha ao consultar os itens da O.P."
                loc_lOk = .F.
            ENDIF

            *-- 2) Zera SeqDivs de TODOS os itens da O.P. (banco + cursor local),
            *--    reproduzindo o Scan While Nops=lnOp / Replace SeqDivs With 0
            IF loc_lOk
                SELECT cursor_4c_SigOpPicAtu
                INDEX ON STR(Nops, 10) + STR(Citens, 10) + cIdChaves TAG Nops
                SET ORDER TO Nops
                SEEK STR(loc_nOP, 10)
                SCAN WHILE loc_lOk AND Nops = loc_nOP
                    loc_cChaveAtual = cIdChaves
                    REPLACE SeqDivs WITH 0 IN cursor_4c_SigOpPicAtu

                    loc_cSQL = "UPDATE SigOpPic SET SeqDivs = 0 WHERE cIdChaves = " + EscaparSQL(loc_cChaveAtual)
                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                        MsgErro("Favor Reinicializar o Processo!!!", "Falha na Grava" + CHR(231) + CHR(227) + "o (SigOpPic 1)")
                        loc_lOk = .F.
                    ENDIF
                ENDSCAN
            ENDIF

            *-- 3) Distribui a quantidade de cada linha do grid (cursor_4c_DivOp) no
            *--    primeiro item da O.P. com mesmo Dopes+Numes ainda com SeqDivs=0
            IF loc_lOk
                SELECT cursor_4c_DivOp
                SCAN WHILE loc_lOk
                    loc_nQtdDivs = cursor_4c_DivOp.QtdDivs
                    loc_nSeqDivs = cursor_4c_DivOp.SeqDivs
                    loc_nCitens  = cursor_4c_DivOp.Citens
                    loc_cDopes   = cursor_4c_DivOp.Dopes
                    loc_nNumes   = cursor_4c_DivOp.Numes
                    loc_cChaveAtual = ""

                    SELECT cursor_4c_SigOpPicAtu
                    SET ORDER TO Nops ASCENDING
                    SEEK STR(loc_nOP, 10) + STR(loc_nCitens, 10)
                    SCAN FOR Nops = loc_nOP AND Citens = loc_nCitens
                        IF (Dopes + STR(Numes, 6) = loc_cDopes + STR(loc_nNumes, 6)) AND SeqDivs = 0
                            REPLACE Qtds WITH loc_nQtdDivs, SeqDivs WITH loc_nSeqDivs IN cursor_4c_SigOpPicAtu
                            loc_cChaveAtual = cIdChaves
                            EXIT
                        ENDIF
                    ENDSCAN

                    IF !EMPTY(loc_cChaveAtual)
                        loc_cSQL = "UPDATE SigOpPic SET Qtds = " + FormatarNumeroSQL(loc_nQtdDivs, 3) + ;
                                   ", SeqDivs = " + FormatarNumeroSQL(loc_nSeqDivs, 0) + ;
                                   " WHERE cIdChaves = " + EscaparSQL(loc_cChaveAtual)
                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            MsgErro("Favor Reinicializar o Processo!!!", "Falha na Grava" + CHR(231) + CHR(227) + "o (SigOpPic 2)")
                            loc_lOk = .F.
                        ELSE
                            THIS.this_cIdChaves = loc_cChaveAtual
                            THIS.RegistrarAuditoria("ATUALIZAR")
                        ENDIF
                    ENDIF

                    SELECT cursor_4c_DivOp
                ENDSCAN
            ENDIF

            *-- 4) Recalcula o saldo total da O.P. (Sum Qtds To lnQtd do legado)
            *--    e grava em SigPdMvf
            IF loc_lOk
                SELECT cursor_4c_SigOpPicAtu
                SUM Qtds TO loc_nQtdTotal

                IF USED("cursor_4c_SigPdMvfAtu")
                    USE IN cursor_4c_SigPdMvfAtu
                ENDIF
                SQLEXEC(gnConnHandle, ;
                    "SELECT Nops, cIdChaves FROM SigPdMvf WHERE Nops = " + FormatarNumeroSQL(loc_nOP, 0), ;
                    "cursor_4c_SigPdMvfAtu")

                IF USED("cursor_4c_SigPdMvfAtu")
                    SELECT cursor_4c_SigPdMvfAtu
                    INDEX ON STR(Nops, 10) + cIdChaves TAG Nops
                    SET ORDER TO Nops DESCENDING
                    IF SEEK(STR(loc_nOP, 10))
                        loc_cSQL = "UPDATE SigPdMvf SET Qtds = " + FormatarNumeroSQL(loc_nQtdTotal, 3) + ;
                                   " WHERE cIdChaves = " + EscaparSQL(cursor_4c_SigPdMvfAtu.cIdChaves)
                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            MsgErro("Favor Reinicializar o Processo!!!", "Falha na Grava" + CHR(231) + CHR(227) + "o (SigPdMvf)")
                            loc_lOk = .F.
                        ELSE
                            *-- Auditoria com a tabela correta (SigPdMvf), restaurando
                            *-- this_cTabela = "SigOpPic" logo em seguida
                            THIS.this_cTabela   = "SigPdMvf"
                            THIS.this_cIdChaves = cursor_4c_SigPdMvfAtu.cIdChaves
                            THIS.RegistrarAuditoria("ATUALIZAR")
                            THIS.this_cTabela   = "SigOpPic"
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

            *-- 5) Commit ou rollback da transacao manual
            IF loc_lOk
                SQLCOMMIT(gnConnHandle)
                ZAP IN cursor_4c_DivOp
                loc_lSucesso = .T.
            ELSE
                SQLROLLBACK(gnConnHandle)
                loc_lSucesso = .F.
            ENDIF

            IF USED("cursor_4c_SigOpPicAtu")
                USE IN cursor_4c_SigOpPicAtu
            ENDIF
            IF USED("cursor_4c_SigPdMvfAtu")
                USE IN cursor_4c_SigPdMvfAtu
            ENDIF

            SET EXACT &loc_cSetExactAnt.

        CATCH TO loc_oErro
            IF VARTYPE(loc_cSetExactAnt) = "C" AND !EMPTY(loc_cSetExactAnt)
                SET EXACT &loc_cSetExactAnt.
            ENDIF
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Destroy - Libera os cursores de trabalho abertos por este BO
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_DivOp")
            USE IN cursor_4c_DivOp
        ENDIF
        IF USED("cursor_4c_SigCdPam")
            USE IN cursor_4c_SigCdPam
        ENDIF
        IF USED("cursor_4c_SigCdNec")
            USE IN cursor_4c_SigCdNec
        ENDIF
        IF USED("cursor_4c_SigPdMvfOp")
            USE IN cursor_4c_SigPdMvfOp
        ENDIF
        IF USED("cursor_4c_SigOpPicOp")
            USE IN cursor_4c_SigOpPicOp
        ENDIF
        IF USED("cursor_4c_SigOpPicAtu")
            USE IN cursor_4c_SigOpPicAtu
        ENDIF
        IF USED("cursor_4c_SigPdMvfAtu")
            USE IN cursor_4c_SigPdMvfAtu
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
