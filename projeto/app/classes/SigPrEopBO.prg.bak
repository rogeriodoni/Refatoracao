*====================================================================
* SigPrEopBO.prg
*
* Business Object para SigPrEop (Selecao de Operacoes)
* Tabela de origem: SigMvCab (movimentacao) | Chave composta: EmpDopNums
*
* Form OPERACIONAL modal (picker) chamado por outras telas do sistema
* para o usuario marcar quais movimentacoes (linhas de SigMvCab, ja
* filtradas pelo chamador num cursor de origem) entram num filtro.
* Nao executa SQL Server proprio: opera sobre cursores em memoria
* recebidos do form chamador (cursor de origem com as movimentacoes
* candidatas) e devolve, ao final, um cursor de saida com a chave
* composta EmpDopNums = Padr(Emps,3) + Padr(Dopes,20) + Padl(Str(Numes,6),6)
* de cada linha marcada - identico ao Scan do cmdSair.Click do legado.
*
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigPrEopBO AS BusinessBase

    *-- ===================================================================
    *-- Propriedades da entidade (linha corrente do cursor de operacoes)
    *-- ===================================================================
    this_nSelecionada  = 0     && Selecionada numeric(1,0) - flag de marcacao da linha no grid
    this_cEmps         = ""    && Emps char(3) - empresa (SigMvCab)
    this_cDopes        = ""    && Dopes char(20) - operacao/documento (SigMvCab / SigCdOpe.Dopes)
    this_nNumes        = 0     && Numes numeric(6,0) - numero da movimentacao (SigMvCab)
    this_dDatas        = {}    && Datas date - data da movimentacao
    this_dPrazoEnts    = {}    && PrazoEnts date - previsao de entrega
    this_cContas       = ""    && Contas char - codigo do cliente/conta (SigCdCli.Iclis)
    this_cRClis        = ""    && RClis char - nome/razao do cliente
    this_cConjuges     = ""    && Conjuges - indicador de operacao conjugada
    this_cEmpDopNums   = ""    && EmpDopNums char(29) - chave composta Emps(3)+Dopes(20)+Numes(6)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela = "SigMvCab"
        THIS.this_cCampoChave = "EmpDopNums"

        RETURN .T.
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas da linha corrente do
    * cursor de operacoes (Selecionada, Emps, Dopes, Numes, Datas,
    * PrazoEnts, Contas, RClis, Conjuges - as mesmas colunas produzidas
    * por "Select 1 as Selecionada, * from crTprMvCab" no Init legado)
    * para as properties this_* da linha corrente, e calcula a chave
    * composta EmpDopNums via ObterChavePrimaria().
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_nSelecionada = NVL(Selecionada, 0)
            THIS.this_cEmps        = TratarNulo(Emps, "")
            THIS.this_cDopes       = TratarNulo(Dopes, "")
            THIS.this_nNumes       = NVL(Numes, 0)
            THIS.this_dDatas       = ConverterParaData(Datas)
            THIS.this_dPrazoEnts   = ConverterParaData(PrazoEnts)
            THIS.this_cContas      = TratarNulo(Contas, "")
            THIS.this_cRClis       = TratarNulo(RClis, "")
            THIS.this_cConjuges    = TratarNulo(Conjuges, "")

            THIS.this_cEmpDopNums = THIS.ObterChavePrimaria()

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Chave composta EmpDopNums, identica ao Scan do
    * cmdSair.Click legado: Padr(Emps,3) + Padr(Dopes,20) +
    * Padl(Str(Numes,6),6) (char(29) = 3+20+6). Chave POSICIONAL - o
    * padding faz parte da chave, por isso PADR/PADL nas partes, NUNCA
    * ALLTRIM (CLAUDE.md regra #22 / Erro177: ALLTRIM nas partes internas
    * descasa a busca em SILENCIO, sem erro, devolvendo zero linhas).
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + ;
            PADL(STR(THIS.this_nNumes, 6), 6)
    ENDPROC

    *====================================================================
    * Inserir()/Atualizar()/ExecutarExclusao() - o legado (SIGPREOP.SCX)
    * NAO grava nada em SQL Server: eh um picker modal que (1) recebe do
    * form chamador um cursor de origem JA FILTRADO (crTprMvCab), (2)
    * deixa o usuario marcar linhas via checkbox e (3) devolve ao
    * chamador um cursor de saida em memoria (crFilOper) com a chave
    * composta das linhas marcadas - tudo dentro do proprio processo VFP,
    * sem SQLEXEC, sem TABLEUPDATE, sem AddCursor remoto (comportamento.json
    * confirma: nenhum metodo do form tem gravacao remota). O
    * comportamento herdado de BusinessBase (recusar Inserir/Atualizar) ja
    * eh o correto para esta entidade neste form; a operacao real de
    * "gravacao" desta tela eh a montagem do cursor de saida, implementada
    * abaixo em MontarCursorSelecionados() (equivalente ao Scan do
    * cmdSair.Click).
    *====================================================================

    *====================================================================
    * CarregarOperacoes - Constroi o cursor de trabalho da grade a partir
    * do cursor de origem recebido do form chamador, replicando o Init
    * legado: "Select 1 as Selecionada, * from crTprMvCab into cursor
    * crOperacoes readwrite". par_cCursorOrigem eh o cursor JA POPULADO
    * pelo chamador (equivalente a crTprMvCab); par_cCursorDestino recebe
    * as mesmas colunas mais a coluna Selecionada, iniciada em 1 - o
    * legado marca TODAS as linhas como selecionadas por padrao (mesmo
    * valor inicial de ck_Marca.Value = 1).
    *====================================================================
    PROCEDURE CarregarOperacoes(par_cCursorOrigem, par_cCursorDestino)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        IF VARTYPE(par_cCursorOrigem) = "C" AND !EMPTY(par_cCursorOrigem) AND USED(par_cCursorOrigem) AND ;
           VARTYPE(par_cCursorDestino) = "C" AND !EMPTY(par_cCursorDestino)

            TRY
                IF USED(par_cCursorDestino)
                    USE IN (par_cCursorDestino)
                ENDIF

                loc_cSQL = "SELECT 1 AS Selecionada, * FROM " + par_cCursorOrigem + ;
                    " INTO CURSOR " + par_cCursorDestino + " READWRITE"

                &loc_cSQL.

                IF USED(par_cCursorDestino)
                    SELECT (par_cCursorDestino)
                    GO TOP
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                        "vel montar o cursor de opera" + CHR(231) + CHR(245) + "es."
                ENDIF
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure
            ENDTRY
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * MarcarTodasOperacoes - Replica ck_Marca.Click do legado: marca ou
    * desmarca TODAS as linhas do cursor de operacoes de uma vez ("Replace
    * All Selecionada with This.Value in crOperacoes").
    *====================================================================
    PROCEDURE MarcarTodasOperacoes(par_cCursorOperacoes, par_nValor)
        LOCAL loc_lSucesso, loc_nRecno
        loc_lSucesso = .F.

        IF VARTYPE(par_cCursorOperacoes) = "C" AND !EMPTY(par_cCursorOperacoes) AND USED(par_cCursorOperacoes)
            loc_nRecno = RECNO(par_cCursorOperacoes)

            SELECT (par_cCursorOperacoes)
            REPLACE ALL Selecionada WITH NVL(par_nValor, 0)

            IF BETWEEN(loc_nRecno, 1, RECCOUNT(par_cCursorOperacoes))
                GOTO loc_nRecno
            ENDIF

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * MontarCursorSelecionados - Replica o Scan do cmdSair.Click legado:
    * percorre o cursor de operacoes e grava, no cursor de saida (ja
    * criado pelo form chamador, equivalente a crFilOper), a chave
    * composta EmpDopNums de cada linha marcada (Selecionada == 1). O
    * cursor de saida eh ZERADO no inicio (Zap in crFilOper do legado) e
    * espera uma unica coluna EmpDopNums char(29).
    *====================================================================
    PROCEDURE MontarCursorSelecionados(par_cCursorOperacoes, par_cCursorDestino)
        LOCAL loc_lSucesso, loc_nRecnoOrigem, loc_cChave, loc_oErro
        loc_lSucesso = .F.

        IF VARTYPE(par_cCursorOperacoes) = "C" AND !EMPTY(par_cCursorOperacoes) AND USED(par_cCursorOperacoes) AND ;
           VARTYPE(par_cCursorDestino) = "C" AND !EMPTY(par_cCursorDestino) AND USED(par_cCursorDestino)

            TRY
                loc_nRecnoOrigem = RECNO(par_cCursorOperacoes)

                SELECT (par_cCursorDestino)
                ZAP

                SELECT (par_cCursorOperacoes)
                SCAN FOR NVL(Selecionada, 0) = 1
                    THIS.CarregarDoCursor(par_cCursorOperacoes)
                    loc_cChave = THIS.ObterChavePrimaria()

                    INSERT INTO (par_cCursorDestino) VALUES (loc_cChave)

                    SELECT (par_cCursorOperacoes)
                ENDSCAN

                IF USED(par_cCursorOperacoes) AND BETWEEN(loc_nRecnoOrigem, 1, RECCOUNT(par_cCursorOperacoes))
                    SELECT (par_cCursorOperacoes)
                    GOTO loc_nRecnoOrigem
                ENDIF

                loc_lSucesso = .T.
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure
            ENDTRY
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
