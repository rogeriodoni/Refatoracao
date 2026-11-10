*==============================================================================
* SigOpOchBO.prg - Business Object para SigOpOch (Consulta de FollowUp)
*
* Legado  : SIGOPOCH.SCX (task774) - dialogo MODAL "Consulta de FollowUp"
* Tabelas : SigMvCcr (leitura - lancamento de conta corrente sendo consultado)
*           SigCqOch (leitura - historico de FollowUp/auditoria do lancamento)
*
* CONTEXTO (legado)
* ------------------
* SIGOPOCH.Init recebe tres parametros (poForm, pnNoper, pcOper) do form que o
* abre (DO Form SigOpOch With <form pai>, <Nopers>, <Opers>) e executa, na
* sessao PRIVADA do proprio dialogo (DataSession = 2):
*   1) Select * From SigMvCcr Where Nopers = <pnNoper> And Opers = <pcOper>
*      Into cursor ContaCC - o lancamento de conta corrente que o usuario
*      selecionou no form pai (grd_lancamento espelha ContaCC: Datas, Hists,
*      Valors, Opers, Emps, Saldos - somente leitura, sem nenhuma gravacao);
*   2) Select * From SigCqOch Where Nopers = <pnNoper> Order by Datars,Datas
*      Into cursor Movi - TODO o historico de FollowUp daquele Noper (pode
*      ter varias linhas, uma por acao de auditoria/observacao registrada);
*   3) Select *, Padr(Nvl(ObsAudts,' '),50) as ObsAudt2 From Movi Into Cursor
*      Movimento - GridFollowUp espelha Movimento: Datars, TpLancs, Datas,
*      Usuars, ObsAudt2 (observacao truncada para a coluna da grade); o Memo
*      inferior (Memo_Obs) espelha Movimento.ObsAudts (texto completo, sem
*      truncar) da linha corrente da grade.
* O dialogo e PURAMENTE DE CONSULTA: nenhum metodo do SCX faz INSERT/UPDATE/
* DELETE. O unico botao (Sair) apenas libera o form (ThisForm.Release).
*
* ADAPTACAO DE ARQUITETURA (PILAR 3)
* -----------------------------------
* Os parametros pnNoper/pcOper chegam aqui como propriedades explicitas
* (this_nNopers/this_cOpers), preenchidas pelo Form a partir dos parametros
* recebidos no Init (equivalente funcional ao LParameters do legado). As
* duas consultas (Fase 2) vao para cursores SEPARADOS e nao destrutivos
* (cursor_4c_ContaCc / cursor_4c_FollowUp), e a 3a consulta do legado
* (Movimento = Movi + ObsAudt2 calculado) sera reproduzida como parte da
* mesma query de FollowUp (coluna ObsAudt2 calculada no proprio SELECT),
* evitando um 3o cursor so para acrescentar uma coluna derivada.
*
* As propriedades abaixo espelham os campos efetivamente referenciados no
* codigo fonte original (ControlSource das colunas dos dois grids + os dois
* parametros de filtro). NAO ha campo editavel nem gravacao: as propriedades
* this_cTabela/this_cCampoChave herdadas de BusinessBase ficam apontando
* para SigCqOch (a tabela do "FollowUp" que da nome ao dialogo), mas sem uso
* de Inserir/Atualizar/ExecutarExclusao nesta BO (consulta pura).
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*==============================================================================

DEFINE CLASS SigOpOchBO AS BusinessBase

    *==========================================================================
    * PARAMETROS DE FILTRO (pnNoper/pcOper do legado Init) - identificam o
    * lancamento de conta corrente cujo FollowUp esta sendo consultado
    *==========================================================================
    this_nNopers = 0    && numeric(7,0) - par_nNoper (filtro SigMvCcr.Nopers e SigCqOch.Nopers)
    this_cOpers  = ""   && char(1)      - par_cOper (filtro SigMvCcr.Opers - D/C)

    *==========================================================================
    * SigMvCcr (ContaCC) - lancamento de conta corrente exibido em
    * grd_lancamento (somente leitura, sem gravacao nesta tela)
    *==========================================================================
    this_dDatas  = {}   && datetime SigMvCcr.datas  - data do lancamento (Col_Data)
    this_cHists  = ""   && char(60) SigMvCcr.hists  - historico/descricao (Col_Hist)
    this_nValors = 0    && numeric(11,2) SigMvCcr.valors - valor do lancamento (Col_Valor)
    this_cEmps   = ""   && char(3)  SigMvCcr.emps   - empresa (Col_Emp)
    this_nSaldos = 0    && numeric(15,2) SigMvCcr.saldos - saldo apos o lancamento (Col_Saldo)

    *==========================================================================
    * SigCqOch (Movi/Movimento) - historico de FollowUp exibido em
    * GridFollowUp (multiplas linhas por Noper) + Memo_Obs (linha corrente)
    *==========================================================================
    this_dDatars   = {}   && datetime SigCqOch.datars  - data/hora do lancamento do FollowUp (Column1)
    this_cTpLancs  = ""   && char(15) SigCqOch.tplancs - tipo do lancamento de FollowUp (Column2)
    this_dDataLog  = {}   && datetime SigCqOch.datas   - data do registro de FollowUp (Column3)
    this_cUsuars   = ""   && char(10) SigCqOch.usuars  - usuario que registrou o FollowUp (Column4)
    this_cObsAudts = ""   && text SigCqOch.obsaudts    - observacao completa (Memo_Obs / Column5 truncada em ObsAudt2)

    *==========================================================================
    * Init - Configura tabela principal e chave primaria
    *
    * A tabela VAI no DODEFAULT: BusinessBase.Init() so instancia
    * this_oDataAccess quando recebe o parametro pcTabela. Com DODEFAULT()
    * sem argumento o objeto de acesso a dados fica .NULL. e todo metodo
    * herdado que depende dele devolve .F. reclamando que o acesso a dados
    * nao foi inicializado.
    *
    * this_cTabela = "SigCqOch" (a tabela de FollowUp que da nome ao
    * dialogo - "Consulta de FollowUp"); this_cCampoChave fica com o nome
    * convencional da PK de SigCqOch so para a nomenclatura herdada de
    * BusinessBase ter um valor coerente com o schema - esta BO NAO grava
    * nada (nenhum Inserir/Atualizar/ExecutarExclusao sera sobrescrito).
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT("SigCqOch")

            THIS.this_cTabela     = "SigCqOch"
            THIS.this_cCampoChave = "cidchaves"

            loc_lResultado = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "SigOpOchBO.Init")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarContaCorrente - busca o lancamento de conta corrente filtrado
    * por this_nNopers/this_cOpers. Equivale ao 1o Select do Init legado:
    *   Select * From SigMvCcr Where Nopers = <pnNoper> And Opers = <pcOper>
    *
    * SQLEXEC roda sobre um cursor TEMPORARIO (cursor_4c_ContaCcTmp) e o
    * resultado eh copiado para cursor_4c_ContaCc via ZAP + APPEND FROM
    * DBF() - SQLEXEC direto sobre o alias ligado ao grd_4c_Lancamento
    * zeraria o ColumnCount do grid (cursor_4c_ContaCc eh criado pelo Form
    * com os campos Datas T, Hists C(60), Valors N(11,2), Opers C(1),
    * Emps C(3), Saldos N(15,2), Concs N(1), DtAudits T - mesma lista de
    * colunas do SELECT abaixo; APPEND FROM DBF casa os campos por NOME, logo
    * nome a mais ou a menos entra em branco calado).
    *
    * Ao final, espelha a linha encontrada nas propriedades this_* via
    * CarregarDoCursor(), para o Form poder exibir Data/Historico/Valor/
    * Empresa/Saldo tambem fora do grid, se precisar.
    *==========================================================================
    PROCEDURE CarregarContaCorrente()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            ELSE
                *-- Concs e DtAudits NAO aparecem em coluna nenhuma da grade:
                *-- sao as duas colunas que o DynamicForeColor/DynamicBackColor
                *-- do Init legado le para colorir a linha (azul = conciliado,
                *-- verde claro = auditado). O legado faz Select * e por isso
                *-- as tinha de graca; aqui a lista eh explicita, entao elas
                *-- precisam constar ou as cores do legado se perdem em
                *-- silencio. CAST do bit para numeric(1,0) para o VFP receber
                *-- SEMPRE Numerico: bit chega ora Logico, ora Numerico
                *-- conforme o driver, e a expressao do grid compara com 1.
                loc_cSQL = "SELECT Datas, Hists, Valors, Opers, Emps, Saldos, " + ;
                           "CAST(concs AS numeric(1,0)) AS Concs, " + ;
                           "dtaudits AS DtAudits " + ;
                           "FROM SigMvCcr " + ;
                           "WHERE Nopers = " + FormatarNumeroSQL(THIS.this_nNopers, 0) + ;
                           " AND Opers = " + EscaparSQL(THIS.this_cOpers)

                IF USED("cursor_4c_ContaCcTmp")
                    USE IN cursor_4c_ContaCcTmp
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaCcTmp")

                IF loc_nResultado >= 0
                    IF USED("cursor_4c_ContaCc")
                        SELECT cursor_4c_ContaCc
                        ZAP
                        APPEND FROM DBF("cursor_4c_ContaCcTmp")
                        IF RECCOUNT("cursor_4c_ContaCc") > 0
                            GO TOP IN cursor_4c_ContaCc
                            THIS.CarregarDoCursor("cursor_4c_ContaCc")
                        ENDIF
                    ENDIF
                    loc_lResultado = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao buscar o lan" + CHR(231) + "amento de conta corrente." + CHR(13) + CapturarErroSQL()
                ENDIF

                IF USED("cursor_4c_ContaCcTmp")
                    USE IN cursor_4c_ContaCcTmp
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "SigOpOchBO.CarregarContaCorrente")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarFollowUp - busca TODO o historico de FollowUp (SigCqOch) do
    * lancamento filtrado por this_nNopers. Equivale as 2a e 3a consultas do
    * Init legado combinadas numa unica query (a 3a so acrescenta a coluna
    * derivada ObsAudt2, que o SQL Server ja calcula no proprio SELECT):
    *   Select * From SigCqOch Where Nopers = <pnNoper> Order by Datars,Datas
    *   Select *, Padr(Nvl(ObsAudts,' '),50) as ObsAudt2 From Movi
    *
    * Mesmo padrao de cursor temporario + ZAP/APPEND FROM DBF() de
    * CarregarContaCorrente, preservando o RecordSource do GridFollowUp
    * (cursor_4c_FollowUp, criado pelo Form com Datars T, TpLancs C(15),
    * Datas T, Usuars C(10), ObsAudts M, ObsAudt2 C(50)).
    *==========================================================================
    PROCEDURE CarregarFollowUp()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            ELSE
                loc_cSQL = "SELECT Datars, TpLancs, Datas, Usuars, " + ;
                           "CAST(obsaudts AS VARCHAR(MAX)) AS ObsAudts, " + ;
                           "LEFT(ISNULL(CAST(obsaudts AS VARCHAR(MAX)), ''), 50) AS ObsAudt2 " + ;
                           "FROM SigCqOch " + ;
                           "WHERE Nopers = " + FormatarNumeroSQL(THIS.this_nNopers, 0) + ;
                           " ORDER BY Datars, Datas"

                IF USED("cursor_4c_FollowUpTmp")
                    USE IN cursor_4c_FollowUpTmp
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FollowUpTmp")

                IF loc_nResultado >= 0
                    IF USED("cursor_4c_FollowUp")
                        SELECT cursor_4c_FollowUp
                        ZAP
                        APPEND FROM DBF("cursor_4c_FollowUpTmp")
                        GO TOP IN cursor_4c_FollowUp
                    ENDIF
                    loc_lResultado = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao buscar o hist" + CHR(243) + "rico de FollowUp." + CHR(13) + CapturarErroSQL()
                ENDIF

                IF USED("cursor_4c_FollowUpTmp")
                    USE IN cursor_4c_FollowUpTmp
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "SigOpOchBO.CarregarFollowUp")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - mapeia a linha CORRENTE do cursor informado para as
    * propriedades this_*. Usado (a) uma vez, logo depois de popular
    * cursor_4c_ContaCc em CarregarContaCorrente, e (b) a cada troca de linha
    * do GridFollowUp (equivalente ao AfterRowColChange do legado, que so
    * fazia ThisForm.Memo_Obs.Refresh - aqui quem alimenta o Memo_Obs eh
    * this_cObsAudts, lido da linha corrente de cursor_4c_FollowUp).
    *
    * Detecta qual dos dois cursores foi passado pelas colunas presentes
    * (TYPE() - PEMSTATUS exige OBJETO, nao serve para alias de cursor) e
    * mapeia so o bloco correspondente.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_cAliasCursor) = "C" AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            IF !EOF()
                IF TYPE(par_cAliasCursor + ".Hists") != "U"
                    *-- Linha de cursor_4c_ContaCc (SigMvCcr)
                    THIS.this_dDatas  = ConverterParaData(Datas)
                    THIS.this_cHists  = TratarNulo(Hists, "")
                    THIS.this_nValors = TratarNulo(Valors, 0)
                    THIS.this_cEmps   = TratarNulo(Emps, "")
                    THIS.this_nSaldos = TratarNulo(Saldos, 0)
                ENDIF

                IF TYPE(par_cAliasCursor + ".TpLancs") != "U"
                    *-- Linha de cursor_4c_FollowUp (SigCqOch)
                    THIS.this_dDatars   = ConverterParaData(Datars)
                    THIS.this_cTpLancs  = TratarNulo(TpLancs, "")
                    THIS.this_dDataLog  = ConverterParaData(Datas)
                    THIS.this_cUsuars   = TratarNulo(Usuars, "")
                    THIS.this_cObsAudts = TratarNulo(ObsAudts, "")
                ENDIF
            ENDIF

            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - nao ha PK de registro unico editavel nesta tela
    * (dialogo de consulta, sem Inserir/Atualizar/Excluir). A "chave" do
    * dialogo eh o proprio par Nopers+Opers usado para filtrar as consultas.
    * Sobrescrito apenas para o contrato de BusinessBase; este BO nunca
    * chama RegistrarAuditoria/Salvar/Excluir - ver nota abaixo.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(STR(THIS.this_nNopers, 7)) + THIS.this_cOpers
    ENDPROC

    *==========================================================================
    * NOTA: Inserir()/Atualizar()/ExecutarExclusao() NAO sao sobrescritos.
    * O dialogo SIGOPOCH e PURAMENTE DE CONSULTA (o unico botao, Sair, apenas
    * libera o form com ThisForm.Release - nao ha INSERT/UPDATE/DELETE em
    * lugar nenhum do codigo original). Sobrescrever esses metodos aqui
    * inventaria gravacao que o legado nunca teve (violaria a paridade
    * funcional). Os defaults herdados de BusinessBase permanecem validos,
    * pois Salvar()/Excluir() jamais sao chamados por este BO/Form.
    *==========================================================================

ENDDEFINE
