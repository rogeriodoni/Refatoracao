*====================================================================
* sigmvpenBO.prg
*
* Business Object do dialogo OPERACIONAL "SIGMVPEN" (saldo em aberto de
* movimentacao): consulta itens em aberto de recebimento/transferencia,
* agrupados por Empresa/Operacao/Numero.
*
* Nao existe tabela unica: o detalhe (cursor_4c_Grade) vem de um JOIN
* entre SigMvEstPd (saldo em aberto), SigMvCab (dados da movimentacao) e
* SigCdCli (razao social do cliente/fornecedor). SigMvEstPd e a tabela
* de origem do filtro, por isso THIS.this_cTabela aponta para ela.
*
* Chave de filtro: Fk_chave (equivalente a ThisForm.lpKey / LParameters
* pKey do Init do form legado sigmvpen)
*
* Herda de: BusinessBase
*
* Metodos principais: os metodos de criacao/carga dos cursores de
* trabalho (equivalentes a Load/selecionadados do legado) e
* CarregarDoCursor (linha selecionada da grade, equivalente ao
* AfterRowColChange do legado).
*====================================================================

DEFINE CLASS sigmvpenBO AS BusinessBase

    *-- Propriedade de filtro (equivalente a ThisForm.lpKey do form legado)
    this_cLpKey        = ""    && Fk_chave - chave usada para filtrar SigMvEstPd

    *-- Nomes dos cursores de trabalho (grade principal e rodape/legenda)
    this_cCursorGrade  = "cursor_4c_Grade"    && detalhe: Emps/Dopes/Numes/GrupoDs/ContaDs/Usuars/Datas/PrazoEnts/Pendentes/EmpDs/RClis
    this_cCursorRodape = "cursor_4c_Rodape"   && totais/legenda da linha selecionada: Descrs/Usuars/Pendentes

    *-- Propriedades da LINHA SELECIONADA na grade (equivalente ao que o
    *-- AfterRowColChange do legado le direto de crGrade.<campo>). Preenchidas
    *-- por CarregarDoCursor(THIS.this_cCursorGrade) a cada troca de linha.
    this_cEmps         = ""    && crGrade.Emps
    this_cDopes        = ""    && crGrade.Dopes
    this_nNumes        = 0     && crGrade.Numes
    this_cGrupoDs      = ""    && crGrade.GrupoDs
    this_cContaDs      = ""    && crGrade.ContaDs
    this_cRClis        = ""    && crGrade.RClis
    this_cUsuars       = ""    && crGrade.Usuars
    this_dDatas        = {}    && crGrade.Datas
    this_dPrazoEnts    = {}    && crGrade.PrazoEnts
    this_cEmpDs        = ""    && crGrade.EmpDs
    this_nPendentes    = 0     && crGrade.Pendentes

    *--------------------------------------------------------------------------
    * INIT - Construtor
    * par_cLpKey: chave (Fk_chave) usada para filtrar o saldo em aberto.
    * Equivale ao LParameters pKey do Init do form legado sigmvpen, que o
    * form repassava para ThisForm.lpKey antes de montar as grades.
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cLpKey)
        DODEFAULT("SigMvEstPd")

        THIS.this_cCampoChave = "Fk_chave"

        IF VARTYPE(par_cLpKey) = "C"
            THIS.this_cLpKey = par_cLpKey
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Cria (ou recria) os cursores de trabalho com a MESMA estrutura e ORDEM
    * DE CAMPOS em todos os pontos que os usam (Form e BO) - equivalente ao
    * "Create Cursor crGrade"/"Create Cursor crRodape" do PROCEDURE Load do
    * form legado. Chamado pelo Form (InicializarForm) e internamente pelo
    * metodo de carga abaixo, para garantir a estrutura antes de popular.
    *--------------------------------------------------------------------------
    PROCEDURE CriarCursoresPendentes()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorGrade)
                USE IN (THIS.this_cCursorGrade)
            ENDIF

            CREATE CURSOR (THIS.this_cCursorGrade) (Emps C(3), Dopes C(20), Numes N(6), ;
                GrupoDs C(10), ContaDs C(10), Usuars C(10), Datas D, PrazoEnts D, ;
                Pendentes N(10,3), EmpDs C(3), RClis C(50))

            SELECT (THIS.this_cCursorGrade)
            INDEX ON DTOS(PrazoEnts) + DTOS(Datas) + Emps + Dopes + STR(Numes, 6) TAG Ordem

            IF USED(THIS.this_cCursorRodape)
                USE IN (THIS.this_cCursorRodape)
            ENDIF

            CREATE CURSOR (THIS.this_cCursorRodape) (Descrs C(100), Usuars C(10), Pendentes N(10,3))

            loc_lSucesso = .T.
        CATCH TO loException
            THIS.this_cMensagemErro = loException.Message
            MsgErro(loException.Message, "Erro em sigmvpenBO.CriarCursoresPendentes")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Busca os dados da grade - equivalente ao PROCEDURE selecionadados do
    * legado.
    *
    * par_cCursorEstPd: alias do cursor LOCAL, ja aberto na sessao, com os
    * itens em aberto (Fk_chave/EmpDopNums/Qtds) - equivalente a crSigMvEstPd
    * do form legado. Esse cursor NAO vem de uma tabela chamada "SigMvEstPd"
    * (ela nao existe no schema - a tabela real e SigMvEst, com colunas
    * totalmente diferentes de Fk_chave/EmpDopNums/Qtds); no sistema legado ele
    * e montado pelo processo CHAMADOR (a tela de movimentacao que abre este
    * dialogo) e permanece visivel aqui porque sigmvpen usa DataSession=1
    * (sessao compartilhada, nao privada). Por isso o parametro: quem chama
    * este BO e responsavel por ja ter esse cursor populado.
    *
    * Para cada grupo (EmpDopNums, Sum(Qtds)) dentro do Fk_chave filtrado,
    * busca no SQL Server o cabecalho da movimentacao (SigMvCab) e a razao
    * social do cliente/fornecedor (SigCdCli), e grava uma linha no cursor de
    * grade (this_cCursorGrade). Ao final, grava o total geral no cursor de
    * rodape (this_cCursorRodape).
    *--------------------------------------------------------------------------
    PROCEDURE BuscarPendentes(par_cCursorEstPd)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_nTotalPendentes, ;
              loc_dDatas, loc_dPrazoEnts
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_cCursorEstPd) != "C" OR !USED(par_cCursorEstPd)
                THIS.this_cMensagemErro = "Cursor de itens pendentes n" + CHR(227) + "o localizado."
            ELSE
                THIS.CriarCursoresPendentes()

                SELECT (THIS.this_cCursorGrade)
                ZAP
                SELECT (THIS.this_cCursorRodape)
                ZAP

                *-- Equivalente a:
                *-- Select Distinct EmpDopNums, Sum(Qtds) as Qtds From crSigMvEstPd
                *--  Where Fk_chave = ThisForm.lpKey
                *--  Order By EmpDopNums Group By EmpDopNums Into Cursor LocalEstPd
                IF USED("cursor_4c_LocalEstPd")
                    USE IN cursor_4c_LocalEstPd
                ENDIF

                SELECT DISTINCT EmpDopNums, SUM(Qtds) AS Qtds ;
                    FROM (par_cCursorEstPd) ;
                    WHERE Fk_chave = THIS.this_cLpKey ;
                    GROUP BY EmpDopNums ;
                    ORDER BY EmpDopNums ;
                    INTO CURSOR cursor_4c_LocalEstPd READWRITE

                SELECT cursor_4c_LocalEstPd
                SCAN
                    *-- Equivalente a:
                    *-- Select a.Emps, a.EmpDs, a.Dopes, a.Numes, a.GrupoDs, a.ContaDs,
                    *--        b.RClis, a.Usuars, a.Datas, a.PrazoEnts
                    *--   From SigMvCab a, SigCdCli b
                    *--  Where a.EmpDopNums = '<EmpDopNums>' And a.ContaDs = b.IClis
                    loc_cSQL = "SELECT a.Emps, a.EmpDs, a.Dopes, a.Numes, a.grupods AS GrupoDs,"
                    loc_cSQL = loc_cSQL + " a.contads AS ContaDs, b.rclis AS RClis, a.Usuars,"
                    loc_cSQL = loc_cSQL + " a.Datas, a.prazoents AS PrazoEnts"
                    loc_cSQL = loc_cSQL + " FROM SigMvCab a, SigCdCli b"
                    loc_cSQL = loc_cSQL + " WHERE a.empdopnums = " + EscaparSQL(cursor_4c_LocalEstPd.EmpDopNums)
                    loc_cSQL = loc_cSQL + " AND a.contads = b.iclis"

                    IF USED("cursor_4c_EstDet")
                        USE IN cursor_4c_EstDet
                    ENDIF

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EstDet")

                    IF loc_nResultado < 1
                        MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (EstDet)")
                        SELECT cursor_4c_LocalEstPd
                        LOOP
                    ENDIF

                    SELECT cursor_4c_EstDet
                    SCAN
                        IF ISNULL(cursor_4c_EstDet.Datas)
                            loc_dDatas = {}
                        ELSE
                            loc_dDatas = TTOD(cursor_4c_EstDet.Datas)
                        ENDIF

                        IF ISNULL(cursor_4c_EstDet.PrazoEnts)
                            loc_dPrazoEnts = {}
                        ELSE
                            loc_dPrazoEnts = TTOD(cursor_4c_EstDet.PrazoEnts)
                        ENDIF

                        INSERT INTO (THIS.this_cCursorGrade) ;
                            (Emps, Dopes, Numes, GrupoDs, ContaDs, RClis, Usuars, Datas, PrazoEnts, EmpDs, Pendentes) ;
                            VALUES ;
                            (cursor_4c_EstDet.Emps, cursor_4c_EstDet.Dopes, cursor_4c_EstDet.Numes, ;
                             cursor_4c_EstDet.GrupoDs, cursor_4c_EstDet.ContaDs, cursor_4c_EstDet.RClis, ;
                             cursor_4c_EstDet.Usuars, loc_dDatas, loc_dPrazoEnts, cursor_4c_EstDet.EmpDs, ;
                             cursor_4c_LocalEstPd.Qtds)

                        SELECT cursor_4c_EstDet
                    ENDSCAN

                    IF USED("cursor_4c_EstDet")
                        USE IN cursor_4c_EstDet
                    ENDIF

                    SELECT cursor_4c_LocalEstPd
                ENDSCAN

                IF USED("cursor_4c_LocalEstPd")
                    USE IN cursor_4c_LocalEstPd
                ENDIF

                *-- Equivalente ao trecho do legado que soma o saldo em aberto da
                *-- grade e grava o total no cursor de rodape.
                loc_nTotalPendentes = 0
                SELECT (THIS.this_cCursorGrade)
                SUM Pendentes TO loc_nTotalPendentes

                INSERT INTO (THIS.this_cCursorRodape) (Pendentes) VALUES (loc_nTotalPendentes)

                SELECT (THIS.this_cCursorGrade)
                GO TOP
                SELECT (THIS.this_cCursorRodape)
                GO TOP

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = loException.Message
            MsgErro(loException.Message, "Erro em sigmvpenBO.BuscarPendentes")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia a linha CORRENTE de this_cCursorGrade para as
    * propriedades this_*. Equivalente ao que o AfterRowColChange do grid
    * legado fazia lendo crGrade.<campo> diretamente - aqui o Form chama este
    * metodo do BO a cada troca de linha (PILAR 3: leitura de dados no BO,
    * nao no Form) e depois espelha this_cEmpDs/this_cUsuars/this_cRClis no
    * rodape e no getRClis.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_cAliasCursor) = "C" AND USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                IF !EOF()
                    THIS.this_cEmps      = TratarNulo(Emps, "")
                    THIS.this_cDopes     = TratarNulo(Dopes, "")
                    THIS.this_nNumes     = TratarNulo(Numes, 0)
                    THIS.this_cGrupoDs   = TratarNulo(GrupoDs, "")
                    THIS.this_cContaDs   = TratarNulo(ContaDs, "")
                    THIS.this_cRClis     = TratarNulo(RClis, "")
                    THIS.this_cUsuars    = TratarNulo(Usuars, "")
                    THIS.this_dDatas     = ConverterParaData(Datas)
                    THIS.this_dPrazoEnts = ConverterParaData(PrazoEnts)
                    THIS.this_cEmpDs     = TratarNulo(EmpDs, "")
                    THIS.this_nPendentes = TratarNulo(Pendentes, 0)
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvpenBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Nao ha PK de registro unico nesta tela (a "chave"
    * do dialogo eh o proprio filtro Fk_chave, compartilhado por todas as
    * linhas da grade). Sobrescrito apenas para o contrato de BusinessBase;
    * este BO nunca chama RegistrarAuditoria/Salvar/Excluir - ver nota abaixo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(NVL(THIS.this_cLpKey, ""))
    ENDPROC

    *--------------------------------------------------------------------------
    * NOTA: Inserir()/Atualizar()/ExecutarExclusao() NAO sao sobrescritos.
    * O form legado sigmvpen e um dialogo de CONSULTA (o unico botao, "ok",
    * apenas fecha a tela com ThisForm.Release - nao ha INSERT/UPDATE/DELETE
    * em lugar nenhum do codigo original). Sobrescrever esses metodos aqui
    * inventaria gravacao que o legado nunca teve (violaria a paridade
    * funcional). Os defaults herdados de BusinessBase permanecem validos,
    * pois Salvar()/Excluir() jamais sao chamados por este BO/Form.
    *--------------------------------------------------------------------------

ENDDEFINE
