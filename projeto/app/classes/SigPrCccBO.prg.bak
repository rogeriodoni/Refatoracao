*============================================================================
* SigPrCccBO.prg - Business Object para Recalculo de Saldos (SIGPRCCC)
*
* Form OPERACIONAL (SIGPRCCC / FormSigPrCcc): processo em lote que recalcula
* saldos/valores de referencia em quatro frentes autonomas, habilitadas
* pelos checkboxes Conta/Estoque/btnCusto/btnCompra do form e filtradas pelos
* campos do respectivo container (OpConta/OpEstoque/OpCusto/OpCompra):
*   - Conta Corrente (SigMvCcr)      -> recalcula saldo de conta corrente
*   - Estoque (SigMvItn/SigCdPro)    -> recalcula saldo de estoque
*   - Custo de Produto (SigCdPro)    -> recalcula custo do produto
*   - Ultima Compra (SigMvItn/SigCdPro/SigCdCli) -> recalcula ultima compra
*
* SigOpClU (PK: cidchaves char(20)) e a tabela de apoio onde o legado grava
* os valores recem-calculados antes de aplica-los (Insert Into CrSigOpClU +
* poDataMgr.Update - AddCursor('SigOpClU','CidChaves','CrSigOpClU') no Init).
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
* Completado em: Fase 2 - Metodos CRUD (CarregarDoCursor/Inserir/Atualizar/
*                ObterChavePrimaria/RegistrarAuditoria) para a entidade
*                SigOpClU (this_cTabela)
*============================================================================

DEFINE CLASS SigPrCccBO AS BusinessBase

    *==========================================================================
    * Flags de processamento - checkboxes Conta/Estoque/btnCusto/btnCompra do
    * form (SIGPRCCC.Conta/Estoque/btnCusto/btnCompra), que habilitam cada
    * frente do recalculo em Processa.Click
    *==========================================================================
    this_lConta    = .F.   && SIGPRCCC.Conta.Value    - habilita frente Conta Corrente
    this_lEstoque  = .F.   && SIGPRCCC.Estoque.Value  - habilita frente Estoque
    this_lCusto    = .F.   && SIGPRCCC.btnCusto.Value - habilita frente Custo de Produto
    this_lCompra   = .F.   && SIGPRCCC.btnCompra.Value - habilita frente Ultima Compra

    *==========================================================================
    * Filtros - Conta Corrente (container OpConta)
    *==========================================================================
    this_cContaEmpresa = SPACE(3)    && OpConta.Get_Empresa - SigCdEmp.Cemps
    this_cContaGrupo   = SPACE(10)   && OpConta.txtGrupos   - SigMvCcr.Grupos
    this_cContaConta   = SPACE(10)   && OpConta.txtContas   - SigMvCcr.Contas
    this_cContaMoeda   = SPACE(3)    && OpConta.txtMoedas   - SigMvCcr.Moedas
    this_dContaData    = {}          && OpConta.txtData     - "A partir de"

    *==========================================================================
    * Filtros - Estoque (container OpEstoque)
    *==========================================================================
    this_cEstoqueEmpresa   = SPACE(3)    && OpEstoque.Get_Empresa - SigCdEmp.Cemps
    this_cEstoqueGrupo     = SPACE(10)   && OpEstoque.txtGrupos   - Grupo do estoque
    this_cEstoqueEstoque   = SPACE(10)   && OpEstoque.Get_Estoque - codigo do estoque
    this_cEstoqueProduto   = SPACE(14)   && OpEstoque.Get_Produto - SigCdPro.CPros
    this_cEstoqueDescricao = SPACE(65)   && OpEstoque.Get_Descs   - SigCdPro.DPros (lookup)
    this_dEstoqueData      = {}          && OpEstoque.txtData     - "A partir de"

    *==========================================================================
    * Filtros - Custo de Produto (container OpCusto)
    *==========================================================================
    this_cCustoEmpresa   = SPACE(3)    && OpCusto.Get_Empresa - SigCdEmp.Cemps
    this_cCustoProduto   = SPACE(14)   && OpCusto.Get_Produto - SigCdPro.CPros
    this_cCustoDescricao = SPACE(65)   && OpCusto.Get_Descs   - SigCdPro.DPros (lookup)
    this_dCustoData      = {}          && OpCusto.txtData     - "A partir de"

    *==========================================================================
    * Filtros - Ultima Compra do Produto/Cliente (container OpCompra)
    *==========================================================================
    this_cCompraEmpresa   = SPACE(3)    && OpCompra.Get_Empresa - SigCdEmp.Cemps
    this_cCompraProduto   = SPACE(14)   && OpCompra.Get_Produto - SigCdPro.CPros
    this_cCompraDescricao = SPACE(65)   && OpCompra.Get_Descs   - SigCdPro.DPros (lookup)
    this_dCompraData      = {}          && OpCompra.txtData     - "A partir de"

    *==========================================================================
    * Contador de registros restantes durante o processamento (Get_Registro)
    *==========================================================================
    this_nRegistros = 0

    *==========================================================================
    * Referencia ao form para o feedback de progresso - equivale ao
    * "ThisForm.Get_Registro.Value = lnReg / Refresh" que o legado repete
    * dentro de cada Scan de Processa.Click. Fica .NULL. quando o BO eh usado
    * sem interface (o processamento nao depende dela).
    *==========================================================================
    this_oFormUI = .NULL.

    *==========================================================================
    * Propriedades de registro - espelham TODAS as colunas de SigOpClU
    * (docs/schema.sql), tabela de apoio (this_cTabela) onde o legado grava,
    * via Insert Into CrSigOpClU, os valores recalculados na frente Ultima
    * Compra (btnCompra) antes de aplica-los em SigCdCli/SigCdPro. Usadas por
    * CarregarDoCursor()/Inserir()/Atualizar()/ObterChavePrimaria().
    *==========================================================================
    this_cIdChaves   = SPACE(20)  && SigOpClU.cidchaves (PK)
    this_cEmps       = SPACE(3)   && SigOpClU.emps       - char(3)  NOT NULL
    this_cDopes      = SPACE(20)  && SigOpClU.dopes      - char(20) NOT NULL
    this_nNumes      = 0          && SigOpClU.numes      - numeric(6,0) NOT NULL
    this_cEmpDopNums = SPACE(29)  && SigOpClU.empdopnums - char(29) NOT NULL (chave POSICIONAL Emps+Dopes+Str(Numes,6))
    this_cIclis      = SPACE(10)  && SigOpClU.iclis      - char(10) NOT NULL (conta contabil, ramo Conta Corrente)
    this_cCpros      = SPACE(14)  && SigOpClU.cpros      - char(14) NOT NULL (produto, ramo Estoque)
    this_nValors     = 0          && SigOpClU.valors     - numeric(13,2) NOT NULL
    this_dDatas      = {}         && SigOpClU.datas      - datetime NULL
    this_cMoedas     = SPACE(3)   && SigOpClU.moedas     - char(3)  NOT NULL
    this_nQtds       = 0          && SigOpClU.qtds       - numeric(12,0) NOT NULL (nao referenciado no legado - sempre 0)

    *==========================================================================
    * Parametros do sistema (SigCdPam), carregados uma unica vez no Init -
    * equivalente ao CursorQuery('SigCdPam','CrSigCdPam',...,[GrupoRecs,
    * GrupoPags,ContaRecs,ContaPags,MoeCentral]) do Init() legado
    *==========================================================================
    this_cGrupoRecs  = SPACE(10)   && SigCdPam.gruporecs - grupo padrao de Contas a Receber
    this_cGrupoPags  = SPACE(10)   && SigCdPam.grupopags - grupo padrao de Contas a Pagar
    this_cContaRecs  = SPACE(10)   && SigCdPam.contarecs - conta padrao de Contas a Receber
    this_cContaPags  = SPACE(10)   && SigCdPam.contapags - conta padrao de Contas a Pagar
    this_cMoeCentral = SPACE(3)    && SigCdPam.moecentral - moeda central (conversao de cambio)

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela/chave primaria
    * de referencia (SigOpClU/cidchaves - AddCursor do Init legado) e carrega
    * os parametros do sistema usados no recalculo (SigCdPam.gruporecs/
    * grupopags/contarecs/contapags/moecentral)
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigOpClU"
            THIS.this_cCampoChave = "cidchaves"

            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0

                IF USED("cursor_4c_SigCdPam")
                    USE IN cursor_4c_SigCdPam
                ENDIF
                SQLEXEC(gnConnHandle, ;
                    "SELECT gruporecs, grupopags, contarecs, contapags, moecentral FROM SigCdPam", ;
                    "cursor_4c_SigCdPam")
                IF USED("cursor_4c_SigCdPam") AND !EOF("cursor_4c_SigCdPam")
                    THIS.this_cGrupoRecs  = PADR(TratarNulo(cursor_4c_SigCdPam.gruporecs, ""), 10)
                    THIS.this_cGrupoPags  = PADR(TratarNulo(cursor_4c_SigCdPam.grupopags, ""), 10)
                    THIS.this_cContaRecs  = PADR(TratarNulo(cursor_4c_SigCdPam.contarecs, ""), 10)
                    THIS.this_cContaPags  = PADR(TratarNulo(cursor_4c_SigCdPam.contapags, ""), 10)
                    THIS.this_cMoeCentral = PADR(TratarNulo(cursor_4c_SigCdPam.moecentral, ""), 3)
                ENDIF
                IF USED("cursor_4c_SigCdPam")
                    USE IN cursor_4c_SigCdPam
                ENDIF

            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * LimparDados - Reseta as propriedades de registro de SigOpClU (chamado
    * por NovoRegistro()/CancelarEdicao() do BusinessBase)
    *==========================================================================
    PROTECTED PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cIdChaves   = SPACE(20)
        THIS.this_cEmps       = SPACE(3)
        THIS.this_cDopes      = SPACE(20)
        THIS.this_nNumes      = 0
        THIS.this_cEmpDopNums = SPACE(29)
        THIS.this_cIclis      = SPACE(10)
        THIS.this_cCpros      = SPACE(14)
        THIS.this_nValors     = 0
        THIS.this_dDatas      = {}
        THIS.this_cMoedas     = SPACE(3)
        THIS.this_nQtds       = 0
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas de uma linha de SigOpClU
    * (identificada por cidchaves) para as propriedades this_ do BO.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF VARTYPE(par_cAliasCursor) != "C" OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        THIS.this_cIdChaves   = TratarNulo(cidchaves, "")
        THIS.this_cEmps       = TratarNulo(emps, "")
        THIS.this_cDopes      = TratarNulo(dopes, "")
        THIS.this_nNumes      = TratarNulo(numes, 0)
        THIS.this_cEmpDopNums = TratarNulo(empdopnums, "")
        THIS.this_cIclis      = TratarNulo(iclis, "")
        THIS.this_cCpros      = TratarNulo(cpros, "")
        THIS.this_nValors     = TratarNulo(valors, 0)
        THIS.this_dDatas      = ConverterParaData(datas)
        THIS.this_cMoedas     = TratarNulo(moedas, "")
        THIS.this_nQtds       = TratarNulo(qtds, 0)

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Chave do registro corrente de SigOpClU, usada por
    * RegistrarAuditoria()
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cIdChaves)
    ENDPROC

    *==========================================================================
    * Inserir - Grava uma linha em SigOpClU cobrindo TODAS as colunas NOT
    * NULL da tabela (docs/schema.sql), equivalente a cada "Insert Into
    * CrSigOpClU (...)" do legado (Processa.Click, ramo BtnCompra.Value).
    * cidchaves eh gerado aqui via fUniqueIds() quando ainda nao preenchido,
    * igual ao "Sys(2015)+Sys(2015)"/"fUniqueIds()" do legado - NUNCA string
    * vazia, senao a 2a linha colide no indice unico (PK).
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(THIS.this_cIdChaves))
            THIS.this_cIdChaves = fUniqueIds()
        ENDIF

        TRY
            loc_cSQL = "INSERT INTO SigOpClU " + ;
                "(cidchaves, emps, dopes, numes, empdopnums, iclis, cpros, valors, datas, moedas, qtds) " + ;
                "VALUES (" + ;
                EscaparSQL(ALLTRIM(THIS.this_cIdChaves)) + ", " + ;
                EscaparSQL(THIS.this_cEmps) + ", " + ;
                EscaparSQL(THIS.this_cDopes) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNumes, 0) + ", " + ;
                EscaparSQL(THIS.this_cEmpDopNums) + ", " + ;
                EscaparSQL(THIS.this_cIclis) + ", " + ;
                EscaparSQL(THIS.this_cCpros) + ", " + ;
                FormatarNumeroSQL(THIS.this_nValors, 2) + ", " + ;
                FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                EscaparSQL(THIS.this_cMoedas) + ", " + ;
                FormatarNumeroSQL(THIS.this_nQtds, 0) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                THIS.this_cMensagemErro = "Erro ao inserir em SigOpClU: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Regrava (por completo) uma linha existente de SigOpClU,
    * localizada por cidchaves. O legado NUNCA faz Update de uma linha desta
    * tabela em si (SigOpClU eh ZAP'd e repopulada a cada recalculo via
    * Insert - THIS.Inserir()); este metodo cobre o contrato padrao de
    * BusinessBase.Salvar() para o caso de uma linha precisar ser corrigida
    * apos carregada via CarregarDoCursor().
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(THIS.this_cIdChaves))
            THIS.this_cMensagemErro = "Registro de SigOpClU sem chave (cidchaves) para atualizar."
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "UPDATE SigOpClU SET " + ;
                "emps = " + EscaparSQL(THIS.this_cEmps) + ", " + ;
                "dopes = " + EscaparSQL(THIS.this_cDopes) + ", " + ;
                "numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0) + ", " + ;
                "empdopnums = " + EscaparSQL(THIS.this_cEmpDopNums) + ", " + ;
                "iclis = " + EscaparSQL(THIS.this_cIclis) + ", " + ;
                "cpros = " + EscaparSQL(THIS.this_cCpros) + ", " + ;
                "valors = " + FormatarNumeroSQL(THIS.this_nValors, 2) + ", " + ;
                "datas = " + FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                "moedas = " + EscaparSQL(THIS.this_cMoedas) + ", " + ;
                "qtds = " + FormatarNumeroSQL(THIS.this_nQtds, 0) + ;
                " WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cIdChaves))

            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                THIS.this_cMensagemErro = "Erro ao atualizar SigOpClU: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro")
            ELSE
                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC


    *==========================================================================
    * RecalcularContaCorrente - ramo "If ThisForm.Conta.Value" de
    * Processa.Click. Monta a lista de combinacoes Emps/Grupos/Contas/Moedas a
    * recalcular e chama fRecalculaS() para cada uma, com COMMIT por linha
    * (o legado faz poDataMgr.Commit()/Rollback() dentro do Scan).
    *
    * Duas origens para a lista, exatamente como o legado:
    *   - Grupo+Conta+Moeda TODOS preenchidos (_Gcm nao vazio): a combinacao
    *     eh montada em memoria (uma linha por empresa de SigCdEmp quando a
    *     empresa nao foi informada);
    *   - caso contrario: UNION ALL de SigMvCcr pelo filtro de Datas e pelo
    *     filtro de DataConcs+Concs (as DUAS metades do legado).
    *==========================================================================
    PROCEDURE RecalcularContaCorrente()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cWhere, loc_cWherC
        LOCAL loc_cEmps, loc_cGrupo, loc_cConta, loc_cMoeda, loc_cGcm
        LOCAL loc_dPData, loc_nRestantes, loc_oProg, loc_lOk
        loc_lSucesso = .F.

        TRY
            *-- Padr() dos valores, igual ao legado (_Emps/_Grupo/_Conta/_Moeda)
            loc_cEmps  = PADR(THIS.this_cContaEmpresa, 3)
            loc_cGrupo = PADR(THIS.this_cContaGrupo, 10)
            loc_cConta = PADR(THIS.this_cContaConta, 10)
            loc_cMoeda = PADR(THIS.this_cContaMoeda, 3)

            *-- _Gcm: so vale quando os TRES estao preenchidos
            IF !EMPTY(loc_cGrupo) AND !EMPTY(loc_cConta) AND !EMPTY(loc_cMoeda)
                loc_cGcm = loc_cGrupo + loc_cConta + loc_cMoeda
            ELSE
                loc_cGcm = SPACE(23)
            ENDIF

            *-- _pData: data-base do recalculo (1900-01-01 quando nao informada)
            loc_dPData = fDtoSQL(THIS.this_dContaData)

            *-- Os dois WHERE do legado (o 2o troca Datas por DataConcs e
            *-- acrescenta Concs = .T.)
            loc_cWhere = "WHERE 0 = 0 " + ;
                IIF(EMPTY(loc_cGrupo), "", "AND Grupos = " + EscaparSQL(loc_cGrupo) + " ") + ;
                IIF(EMPTY(loc_cConta), "", "AND Contas = " + EscaparSQL(loc_cConta) + " ") + ;
                IIF(EMPTY(loc_cMoeda), "", "AND Moedas = " + EscaparSQL(loc_cMoeda) + " ") + ;
                IIF(EMPTY(loc_cEmps),  "", "AND Emps = "   + EscaparSQL(loc_cEmps)  + " ") + ;
                IIF(EMPTY(THIS.this_dContaData), "", ;
                    "AND Datas >= " + FormatarDataSQL(loc_dPData) + " ")

            loc_cWherC = "WHERE 0 = 0 " + ;
                IIF(EMPTY(loc_cGrupo), "", "AND Grupos = " + EscaparSQL(loc_cGrupo) + " ") + ;
                IIF(EMPTY(loc_cConta), "", "AND Contas = " + EscaparSQL(loc_cConta) + " ") + ;
                IIF(EMPTY(loc_cMoeda), "", "AND Moedas = " + EscaparSQL(loc_cMoeda) + " ") + ;
                IIF(EMPTY(loc_cEmps),  "", "AND Emps = "   + EscaparSQL(loc_cEmps)  + " ") + ;
                IIF(EMPTY(THIS.this_dContaData), "", ;
                    "AND DataConcs >= " + FormatarDataSQL(loc_dPData) + " ") + ;
                "AND Concs = 1 "

            THIS.FecharCursorProcesso("cursor_4c_TmpConta")

            IF !EMPTY(ALLTRIM(loc_cGcm))

                *-- Combinacao fixa: uma linha por empresa (ou so a informada)
                CREATE CURSOR cursor_4c_TmpConta ;
                    (Emps C(3), Grupos C(10), Contas C(10), Moedas C(3), CidChaves C(20))

                IF EMPTY(loc_cEmps)
                    THIS.FecharCursorProcesso("cursor_4c_TmpEmps")
                    IF SQLEXEC(gnConnHandle, "SELECT Cemps FROM SigCdEmp", "cursor_4c_TmpEmps") < 1
                        THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! " + ;
                            "(cursor_4c_TmpEmps) " + CapturarErroSQL()
                        MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
                    ELSE
                        SELECT cursor_4c_TmpEmps
                        GO TOP
                        SCAN
                            INSERT INTO cursor_4c_TmpConta ;
                                (Emps, Grupos, Contas, Moedas, CidChaves) VALUES ;
                                (cursor_4c_TmpEmps.Cemps, loc_cGrupo, loc_cConta, ;
                                 loc_cMoeda, fUniqueIds())
                            SELECT cursor_4c_TmpEmps
                        ENDSCAN
                        THIS.FecharCursorProcesso("cursor_4c_TmpEmps")
                        loc_lSucesso = .T.
                    ENDIF
                ELSE
                    INSERT INTO cursor_4c_TmpConta ;
                        (Emps, Grupos, Contas, Moedas, CidChaves) VALUES ;
                        (loc_cEmps, loc_cGrupo, loc_cConta, loc_cMoeda, fUniqueIds())
                    loc_lSucesso = .T.
                ENDIF

                IF USED("cursor_4c_TmpConta")
                    SELECT cursor_4c_TmpConta
                    INDEX ON CidChaves TAG CidChaves
                ENDIF

            ELSE

                *-- UNION ALL das duas metades de SigMvCcr
                loc_cSQL = "SELECT DISTINCT Emps, Grupos, Contas, Moedas, " + ;
                    "SPACE(20) AS CidChaves FROM SigMvCcr " + loc_cWhere + ;
                    " UNION ALL " + ;
                    "SELECT DISTINCT Emps, Grupos, Contas, Moedas, " + ;
                    "SPACE(20) AS CidChaves FROM SigMvCcr " + loc_cWherC

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpContaTmp") < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! " + ;
                        "(cursor_4c_TmpConta) " + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
                ELSE
                    *-- Cursor do SQLEXEC nasce READ-ONLY: converter para
                    *-- READWRITE, senao o REPLACE/DELETE do Scan estoura
                    SELECT * FROM cursor_4c_TmpContaTmp ;
                        INTO CURSOR cursor_4c_TmpConta READWRITE
                    THIS.FecharCursorProcesso("cursor_4c_TmpContaTmp")

                    SELECT cursor_4c_TmpConta
                    SCAN
                        REPLACE CidChaves WITH fUniqueIds()
                    ENDSCAN
                    INDEX ON CidChaves TAG CidChaves
                    loc_lSucesso = .T.
                ENDIF

            ENDIF

            IF loc_lSucesso AND USED("cursor_4c_TmpConta")

                *-- Laco externo do legado: reprocessa o que sobrou em
                *-- TmpConta ate a lista esvaziar (linha recalculada eh
                *-- apagada; linha que falhou permanece e eh retentada)
                DO WHILE .T.
                    THIS.FecharCursorProcesso("cursor_4c_Selecao")
                    SELECT * FROM cursor_4c_TmpConta ;
                        INTO CURSOR cursor_4c_Selecao READWRITE ;
                        ORDER BY Emps, Grupos, Contas, Moedas

                    IF !USED("cursor_4c_Selecao") OR RECCOUNT("cursor_4c_Selecao") = 0
                        EXIT
                    ENDIF

                    loc_nRestantes = RECCOUNT("cursor_4c_Selecao")
                    loc_oProg = CREATEOBJECT("fwprogressbar", ;
                        "Recalculando Saldo de Conta Corrente", loc_nRestantes)
                    loc_oProg.Titulo.FontBold = .T.
                    loc_oProg.Show()

                    SELECT cursor_4c_Selecao
                    SCAN
                        loc_nRestantes = loc_nRestantes - 1
                        THIS.AtualizarProgresso(loc_nRestantes, loc_oProg, ;
                            ALLTRIM(cursor_4c_Selecao.Grupos) + " : " + ;
                            ALLTRIM(cursor_4c_Selecao.Contas) + "-" + ;
                            ALLTRIM(cursor_4c_Selecao.Moedas))

                        *-- 1a chamada acumula, 2a (.T.) grava - contrato do
                        *-- fRecalculaS portado (utils\functions.prg)
                        =fRecalculaS(cursor_4c_Selecao.Grupos, cursor_4c_Selecao.Contas, ;
                            loc_dPData, cursor_4c_Selecao.Moedas, gnConnHandle)

                        loc_lOk = fRecalculaS(.T., gnConnHandle, .T.)
                        IF !loc_lOk
                            =SQLROLLBACK(gnConnHandle)
                            LOOP
                        ENDIF

                        loc_lOk = (SQLCOMMIT(gnConnHandle) > 0)
                        IF !loc_lOk
                            =SQLROLLBACK(gnConnHandle)
                            LOOP
                        ENDIF

                        SELECT cursor_4c_TmpConta
                        IF SEEK(cursor_4c_Selecao.CidChaves, "cursor_4c_TmpConta", "CidChaves")
                            DELETE
                        ENDIF
                        SELECT cursor_4c_Selecao
                    ENDSCAN

                    loc_oProg.Complete(.T.)
                    loc_oProg = .NULL.
                    THIS.FecharCursorProcesso("cursor_4c_Selecao")
                ENDDO

            ENDIF

            THIS.FecharCursorProcesso("cursor_4c_TmpConta")
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                CHR(13) + "Procedure: " + loc_oErro.Procedure, ;
                "Erro em RecalcularContaCorrente")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * RecalcularEstoque - ramo "If ThisForm.Estoque.Value" de Processa.Click.
    * Seleciona as combinacoes distintas de SigMvHst e chama fRecalculaP()
    * para cada uma, com COMMIT por linha.
    *
    * O filtro sobre EmpGruEsts (char concatenado Emps+Grupos+Estos) tem os
    * TRES casos do Do Case legado: igualdade quando os 3 estao preenchidos,
    * sem filtro quando nenhum, e BETWEEN com CHR(254) como limite superior
    * nos casos intermediarios. EmpGruEsts eh chave POSICIONAL: as partes vao
    * com PADR na largura da coluna (3/10/10), NUNCA com ALLTRIM (regra #42).
    *==========================================================================
    PROCEDURE RecalcularEstoque()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cWhere
        LOCAL loc_cEmpresa, loc_cGrupo, loc_cEstoque, loc_cCPros
        LOCAL loc_cEmpIni, loc_cGruIni, loc_cEstIni
        LOCAL loc_cEmpFin, loc_cGruFin, loc_cEstFin
        LOCAL loc_dPData, loc_nRestantes, loc_oProg, loc_lOk
        loc_lSucesso = .F.

        TRY
            loc_cEstoque = PADR(THIS.this_cEstoqueEstoque, 10)
            loc_cEmpresa = PADR(THIS.this_cEstoqueEmpresa, 3)
            loc_cGrupo   = PADR(THIS.this_cEstoqueGrupo, 10)
            loc_cCPros   = PADR(THIS.this_cEstoqueProduto, 14)
            loc_dPData   = fDtoSQL(THIS.this_dEstoqueData)

            DO CASE
                CASE !EMPTY(loc_cEmpresa) AND !EMPTY(loc_cGrupo) AND !EMPTY(loc_cEstoque)
                    loc_cWhere = "EmpGruEsts = " + ;
                        EscaparSQL(loc_cEmpresa + loc_cGrupo + loc_cEstoque) + " "
                CASE EMPTY(loc_cEmpresa) AND EMPTY(loc_cGrupo) AND EMPTY(loc_cEstoque)
                    loc_cWhere = ""
                OTHERWISE
                    loc_cEmpIni = IIF(EMPTY(loc_cEmpresa), SPACE(3),  loc_cEmpresa)
                    loc_cGruIni = IIF(EMPTY(loc_cGrupo),   SPACE(10), loc_cGrupo)
                    loc_cEstIni = IIF(EMPTY(loc_cEstoque), SPACE(10), loc_cEstoque)
                    loc_cEmpFin = IIF(EMPTY(loc_cEmpresa), REPLICATE(CHR(254), 3),  loc_cEmpresa)
                    loc_cGruFin = IIF(EMPTY(loc_cGrupo),   REPLICATE(CHR(254), 10), loc_cGrupo)
                    loc_cEstFin = IIF(EMPTY(loc_cEstoque), REPLICATE(CHR(254), 10), loc_cEstoque)
                    loc_cWhere = "EmpGruEsts BETWEEN " + ;
                        EscaparSQL(loc_cEmpIni + loc_cGruIni + loc_cEstIni) + " AND " + ;
                        EscaparSQL(loc_cEmpFin + loc_cGruFin + loc_cEstFin) + " "
            ENDCASE

            IF !EMPTY(loc_cCPros)
                loc_cWhere = IIF(EMPTY(loc_cWhere), "", loc_cWhere + " AND ") + ;
                    "CPros = " + EscaparSQL(loc_cCPros) + " "
            ENDIF
            IF !EMPTY(THIS.this_dEstoqueData)
                loc_cWhere = IIF(EMPTY(loc_cWhere), "", loc_cWhere + " AND ") + ;
                    "Datas >= " + FormatarDataSQL(loc_dPData) + " "
            ENDIF
            loc_cWhere = IIF(EMPTY(loc_cWhere), "", "WHERE " + loc_cWhere)

            loc_cSQL = "SELECT DISTINCT Emps, Grupos, Estos, Cpros, CodCors, CodTams, " + ;
                "SPACE(20) AS CidChaves FROM SigMvHst " + loc_cWhere

            THIS.FecharCursorProcesso("cursor_4c_TmpEst")
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpEstTmp") < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! " + ;
                    "(cursor_4c_TmpEst) " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
            ELSE
                SELECT * FROM cursor_4c_TmpEstTmp INTO CURSOR cursor_4c_TmpEst READWRITE
                THIS.FecharCursorProcesso("cursor_4c_TmpEstTmp")

                SELECT cursor_4c_TmpEst
                SCAN
                    REPLACE CidChaves WITH fUniqueIds()
                ENDSCAN
                INDEX ON CidChaves TAG CidChaves

                DO WHILE .T.
                    THIS.FecharCursorProcesso("cursor_4c_Selecao")
                    SELECT * FROM cursor_4c_TmpEst ;
                        INTO CURSOR cursor_4c_Selecao READWRITE

                    IF !USED("cursor_4c_Selecao") OR RECCOUNT("cursor_4c_Selecao") = 0
                        EXIT
                    ENDIF

                    loc_nRestantes = RECCOUNT("cursor_4c_Selecao")
                    loc_oProg = CREATEOBJECT("fwprogressbar", ;
                        "Recalculando Saldo do Estoque", loc_nRestantes)
                    loc_oProg.Titulo.FontBold = .T.
                    loc_oProg.Show()

                    SELECT cursor_4c_Selecao
                    SCAN
                        loc_nRestantes = loc_nRestantes - 1
                        THIS.AtualizarProgresso(loc_nRestantes, loc_oProg, ;
                            ALLTRIM(cursor_4c_Selecao.Estos) + " : " + ;
                            ALLTRIM(cursor_4c_Selecao.CPros))

                        =fRecalculaP(cursor_4c_Selecao.Emps, cursor_4c_Selecao.Grupos, ;
                            cursor_4c_Selecao.Estos, cursor_4c_Selecao.CPros, loc_dPData, ;
                            cursor_4c_Selecao.CodCors, cursor_4c_Selecao.CodTams, gnConnHandle)

                        loc_lOk = fRecalculaP(.T., gnConnHandle, .T.)
                        IF !loc_lOk
                            =SQLROLLBACK(gnConnHandle)
                            LOOP
                        ENDIF

                        loc_lOk = (SQLCOMMIT(gnConnHandle) > 0)
                        IF !loc_lOk
                            =SQLROLLBACK(gnConnHandle)
                            LOOP
                        ENDIF

                        SELECT cursor_4c_TmpEst
                        IF SEEK(cursor_4c_Selecao.CidChaves, "cursor_4c_TmpEst", "CidChaves")
                            DELETE
                        ENDIF
                        SELECT cursor_4c_Selecao
                    ENDSCAN

                    loc_oProg.Complete(.T.)
                    loc_oProg = .NULL.
                    THIS.FecharCursorProcesso("cursor_4c_Selecao")
                ENDDO

                loc_lSucesso = .T.
            ENDIF

            THIS.FecharCursorProcesso("cursor_4c_TmpEst")
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em RecalcularEstoque")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * RecalcularCustoProduto - ramo "If ThisForm.btnCusto.Value" de
    * Processa.Click. Para cada Empresa x Produto chama fRecalculaC(), com
    * COMMIT por produto.
    *
    * SigCdPac.CalcCustos decide a origem da lista de produtos (llEmp do
    * legado): quando CalcCustos <> 1 o custo eh POR EMPRESA e os produtos
    * saem de SigMvEst daquela empresa; quando = 1 o custo eh global e a
    * lista eh a de SigCdPro, processada UMA vez so (o "If Not llEmp / Exit"
    * do legado sai do Scan de empresas apos a primeira).
    *==========================================================================
    PROCEDURE RecalcularCustoProduto()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cEmp, loc_cPro
        LOCAL loc_dData, loc_lPorEmpresa, loc_nRestantes, loc_oProg, loc_lOk
        LOCAL loc_lFalhou
        loc_lSucesso    = .F.
        loc_lFalhou     = .F.
        loc_lPorEmpresa = .T.

        TRY
            loc_cEmp  = PADR(THIS.this_cCustoEmpresa, 3)
            loc_cPro  = PADR(THIS.this_cCustoProduto, 14)
            loc_dData = fDtoSQL(THIS.this_dCustoData)

            *-- Empresas a processar
            THIS.FecharCursorProcesso("cursor_4c_LocalEmp")
            loc_cSQL = "SELECT Cemps FROM SigCdEmp WHERE NOT Cemps = SPACE(3)" + ;
                IIF(EMPTY(loc_cEmp), "", " AND Cemps = " + EscaparSQL(loc_cEmp))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalEmp") < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! " + ;
                    "(cursor_4c_LocalEmp) " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
                loc_lFalhou = .T.
            ENDIF

            *-- SigCdPac.CalcCustos: custo por empresa ou global
            IF !loc_lFalhou
                THIS.FecharCursorProcesso("cursor_4c_LocalParac")
                IF SQLEXEC(gnConnHandle, "SELECT Calccustos FROM SigCdPac", ;
                        "cursor_4c_LocalParac") < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! " + ;
                        "(cursor_4c_LocalParac) " + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
                    loc_lFalhou = .T.
                ELSE
                    *-- Coluna bit/numeric conforme o driver: testar VARTYPE
                    *-- antes de comparar (regra #13)
                    IF USED("cursor_4c_LocalParac") AND !EOF("cursor_4c_LocalParac")
                        IF VARTYPE(cursor_4c_LocalParac.Calccustos) = "L"
                            loc_lPorEmpresa = !cursor_4c_LocalParac.Calccustos
                        ELSE
                            loc_lPorEmpresa = (NVL(cursor_4c_LocalParac.Calccustos, 0) <> 1)
                        ENDIF
                    ENDIF
                    THIS.FecharCursorProcesso("cursor_4c_LocalParac")
                ENDIF
            ENDIF

            *-- Lista global de produtos (usada quando o custo NAO eh por empresa)
            IF !loc_lFalhou
                THIS.FecharCursorProcesso("cursor_4c_LocalPro2")
                loc_cSQL = "SELECT Cpros FROM SigCdPro WHERE NOT Cpros = SPACE(14)" + ;
                    IIF(EMPTY(loc_cPro), "", " AND Cpros = " + EscaparSQL(loc_cPro))
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro2") < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! " + ;
                        "(cursor_4c_LocalPro2) " + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
                    loc_lFalhou = .T.
                ENDIF
            ENDIF

            IF !loc_lFalhou AND USED("cursor_4c_LocalEmp")

                SELECT cursor_4c_LocalEmp
                GO TOP
                SCAN

                    THIS.FecharCursorProcesso("cursor_4c_LocalPro")
                    IF loc_lPorEmpresa
                        loc_cSQL = "SELECT DISTINCT Cpros FROM SigMvEst WHERE Emps = " + ;
                            EscaparSQL(cursor_4c_LocalEmp.Cemps) + ;
                            " AND NOT Cpros = SPACE(14)" + ;
                            IIF(EMPTY(loc_cPro), "", " AND Cpros = " + EscaparSQL(loc_cPro))
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro") < 1
                            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! " + ;
                                "(cursor_4c_LocalPro) " + CapturarErroSQL()
                            MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
                            loc_lFalhou = .T.
                            EXIT
                        ENDIF
                    ELSE
                        SELECT * FROM cursor_4c_LocalPro2 ;
                            INTO CURSOR cursor_4c_LocalPro READWRITE
                    ENDIF

                    loc_nRestantes = IIF(USED("cursor_4c_LocalPro"), ;
                        RECCOUNT("cursor_4c_LocalPro"), 0)

                    loc_oProg = CREATEOBJECT("fwprogressbar", ;
                        "Preparando Arquivo de Rec" + CHR(225) + "lculo do Custo de Produtos", ;
                        loc_nRestantes)
                    loc_oProg.Titulo.FontBold = .T.
                    loc_oProg.Show()

                    SELECT cursor_4c_LocalPro
                    SCAN
                        loc_nRestantes = loc_nRestantes - 1
                        THIS.AtualizarProgresso(loc_nRestantes, loc_oProg, ;
                            "Empresa : " + cursor_4c_LocalEmp.Cemps + ;
                            " - Produto : " + cursor_4c_LocalPro.CPros)

                        =fRecalculaC(cursor_4c_LocalEmp.Cemps, cursor_4c_LocalPro.CPros, ;
                            loc_dData, gnConnHandle)

                        loc_lOk = fRecalculaC(.T., .T., .F., gnConnHandle, .T.)
                        IF !loc_lOk
                            =SQLROLLBACK(gnConnHandle)
                            LOOP
                        ENDIF

                        loc_lOk = (SQLCOMMIT(gnConnHandle) > 0)
                        IF !loc_lOk
                            =SQLROLLBACK(gnConnHandle)
                            LOOP
                        ENDIF

                        SELECT cursor_4c_LocalPro
                    ENDSCAN

                    loc_oProg.Complete(.T., .T.)
                    loc_oProg = .NULL.

                    *-- Custo global: a lista de SigCdPro nao depende da
                    *-- empresa, entao processa UMA vez so
                    IF !loc_lPorEmpresa
                        EXIT
                    ENDIF
                    SELECT cursor_4c_LocalEmp
                ENDSCAN

                loc_lSucesso = !loc_lFalhou
            ENDIF

            THIS.FecharCursorProcesso("cursor_4c_LocalPro")
            THIS.FecharCursorProcesso("cursor_4c_LocalPro2")
            THIS.FecharCursorProcesso("cursor_4c_LocalEmp")
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em RecalcularCustoProduto")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AtualizarUltimaCompra - ramo "If ThisForm.BtnCompra.Value" de
    * Processa.Click, em quatro etapas:
    *   1. limpa SigOpClU e remonta a partir de SigMvCab/SigMvItn as
    *      movimentacoes cuja operacao gera "Gdmi" (SigCdTom.GerGdmis);
    *   2. grava as linhas em SigOpClU (uma por titulo ou por item);
    *   3. atualiza SigCdCli.UltComps/vUltComps (ultima data) e
    *      dtfats/mfats (maior valor) por cliente;
    *   4. atualiza SigCdPro.UltComps/vUltComps/mUltComps por produto.
    *
    * GerGdmis = 1 + TpGdmis = 1  -> valor do TITULO, na conta contabil
    *   (Contads quando cOpers = 1, senao ContaOs), convertido para a moeda
    *   central (SigCdPam.moecentral) via fBuscarCotacao.
    * GerGdmis = 2 + AtuCompras = 1 -> valor UNITARIO de cada item de SigMvItn.
    *==========================================================================
    PROCEDURE AtualizarUltimaCompra()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cEmp, loc_cPro, loc_dData
        LOCAL loc_nRestantes, loc_oProg, loc_cConta, loc_nValorCentral
        LOCAL loc_nCotaCentral, loc_nCotaOperac, loc_dDataMov, loc_lFalhou
        LOCAL loc_nGerGdmis, loc_nTpGdmis, loc_nAtuCompras, loc_nCopers
        LOCAL loc_cChave, loc_nValor, loc_cMoeda
        loc_lSucesso = .F.
        loc_lFalhou  = .F.

        TRY
            loc_cEmp  = PADR(THIS.this_cCompraEmpresa, 3)
            loc_cPro  = PADR(THIS.this_cCompraProduto, 14)
            loc_dData = fDtoSQL(THIS.this_dCompraData)

            *-- Etapa 1: "Select CrSigOpClU / Zap" do legado - a tabela de
            *-- apoio eh reconstruida a cada processamento
            IF SQLEXEC(gnConnHandle, "DELETE FROM SigOpClU") < 0
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! " + ;
                    "(Limpar SigOpClU) " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
                loc_lFalhou = .T.
            ELSE
                =SQLCOMMIT(gnConnHandle)
            ENDIF

            *-- Cabecalhos de movimento cuja operacao gera Gdmi
            IF !loc_lFalhou
                THIS.FecharCursorProcesso("cursor_4c_TprMvCab")
                loc_cSQL = "SELECT a.datas, a.Emps, a.Dopes, a.Numes, a.EmpDopNums, " + ;
                    "a.Valos, a.Contads, a.ContaOs, " + ;
                    "c.GerGdmis, c.atuCompras, c.TpGdmis, b.cOpers, b.cmoes " + ;
                    "FROM SigMvCab a, SigCdOpe b, SigCdTom c " + ;
                    "WHERE a.Dopes = b.Dopes AND b.TipoOps = c.Codigos AND " + ;
                    "((c.GerGdmis = 1 AND c.TpGdmis = 1) OR " + ;
                    "(c.GerGdmis = 2 AND c.AtuCompras = 1)) AND " + ;
                    "a.Datas >= " + FormatarDataSQL(loc_dData) + " " + ;
                    IIF(EMPTY(loc_cEmp), "", "AND a.Emps = " + EscaparSQL(loc_cEmp) + " ")
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TprMvCab") < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! " + ;
                        "(cursor_4c_TprMvCab) " + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
                    loc_lFalhou = .T.
                ENDIF
            ENDIF

            *-- Itens dos movimentos que atualizam compra por ITEM
            IF !loc_lFalhou
                THIS.FecharCursorProcesso("cursor_4c_TpmMvItn")
                loc_cSQL = "SELECT Emps, Dopes, Numes, EmpDopNums, Cpros, Units, Moedas " + ;
                    "FROM SigMvItn WHERE EmpDopNums IN " + ;
                    "(SELECT EmpDopNums FROM SigMvCab a, SigCdOpe b, SigCdTom c " + ;
                    "WHERE a.Dopes = b.Dopes AND b.TipoOps = c.Codigos AND " + ;
                    "c.GerGdmis = 2 AND c.AtuCompras = 1 AND " + ;
                    "a.Datas >= " + FormatarDataSQL(loc_dData) + " " + ;
                    IIF(EMPTY(loc_cEmp), "", "AND a.Emps = " + EscaparSQL(loc_cEmp) + " ") + ")"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TpmMvItnTmp") < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! " + ;
                        "(cursor_4c_TpmMvItn) " + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
                    loc_lFalhou = .T.
                ELSE
                    *-- INDEX ON exige cursor READWRITE
                    SELECT * FROM cursor_4c_TpmMvItnTmp ;
                        INTO CURSOR cursor_4c_TpmMvItn READWRITE
                    THIS.FecharCursorProcesso("cursor_4c_TpmMvItnTmp")
                    SELECT cursor_4c_TpmMvItn
                    INDEX ON EmpDopNums TAG EmpDopNums
                ENDIF
            ENDIF

            *-- Etapa 2: percorrer os cabecalhos e montar SigOpClU
            IF !loc_lFalhou
                loc_nRestantes = RECCOUNT("cursor_4c_TprMvCab")
                loc_oProg = CREATEOBJECT("fwprogressbar", ;
                    "Preparando Arquivo de Atualiza" + CHR(231) + CHR(227) + ;
                    "o da Ultima Compra", loc_nRestantes)
                loc_oProg.Titulo.FontBold = .T.
                loc_oProg.Show()

                SELECT cursor_4c_TprMvCab
                GO TOP
                SCAN
                    loc_nRestantes = loc_nRestantes - 1
                    THIS.AtualizarProgresso(loc_nRestantes, loc_oProg, ;
                        cursor_4c_TprMvCab.Emps + " " + cursor_4c_TprMvCab.Dopes + ;
                        " " + STR(cursor_4c_TprMvCab.Numes, 6))

                    loc_cChave      = cursor_4c_TprMvCab.EmpDopNums
                    loc_dDataMov    = ConverterParaData(cursor_4c_TprMvCab.Datas)
                    loc_nGerGdmis   = NVL(cursor_4c_TprMvCab.GerGdmis, 0)
                    loc_nTpGdmis    = NVL(cursor_4c_TprMvCab.TpGdmis, 0)
                    loc_nAtuCompras = NVL(cursor_4c_TprMvCab.atuCompras, 0)
                    loc_nCopers     = NVL(cursor_4c_TprMvCab.cOpers, 0)

                    *-- Valor do TITULO na conta contabil, em moeda central
                    IF loc_nGerGdmis = 1 AND loc_nTpGdmis = 1
                        loc_cConta = IIF(loc_nCopers = 1, ;
                            cursor_4c_TprMvCab.Contads, cursor_4c_TprMvCab.ContaOs)

                        IF ALLTRIM(NVL(cursor_4c_TprMvCab.cmoes, "")) != ;
                                ALLTRIM(THIS.this_cMoeCentral)
                            loc_nCotaCentral = fBuscarCotacao(THIS.this_cMoeCentral, ;
                                loc_dDataMov, gnConnHandle)
                            loc_nCotaOperac  = fBuscarCotacao(cursor_4c_TprMvCab.cmoes, ;
                                loc_dDataMov, gnConnHandle)
                            IF loc_nCotaCentral = 0
                                loc_nValorCentral = NVL(cursor_4c_TprMvCab.Valos, 0)
                            ELSE
                                loc_nValorCentral = ROUND(NVL(cursor_4c_TprMvCab.Valos, 0) * ;
                                    loc_nCotaOperac / loc_nCotaCentral, 2)
                            ENDIF
                        ELSE
                            loc_nValorCentral = NVL(cursor_4c_TprMvCab.Valos, 0)
                        ENDIF

                        THIS.GravarApoioUltimaCompra(cursor_4c_TprMvCab.Emps, ;
                            cursor_4c_TprMvCab.Dopes, cursor_4c_TprMvCab.Numes, ;
                            loc_cChave, loc_cConta, "", loc_nValorCentral, ;
                            loc_dDataMov, "")
                    ENDIF

                    *-- Valor UNITARIO de cada item do movimento
                    IF loc_nGerGdmis = 2 AND loc_nAtuCompras = 1 AND USED("cursor_4c_TpmMvItn")
                        SELECT cursor_4c_TpmMvItn
                        IF SEEK(loc_cChave, "cursor_4c_TpmMvItn", "EmpDopNums")
                            SCAN WHILE ALLTRIM(cursor_4c_TpmMvItn.EmpDopNums) == ;
                                    ALLTRIM(loc_cChave)
                                IF EMPTY(cursor_4c_TpmMvItn.Cpros)
                                    LOOP
                                ENDIF
                                loc_nValor = NVL(cursor_4c_TpmMvItn.Units, 0)
                                loc_cMoeda = NVL(cursor_4c_TpmMvItn.Moedas, "")

                                THIS.GravarApoioUltimaCompra(cursor_4c_TprMvCab.Emps, ;
                                    cursor_4c_TprMvCab.Dopes, cursor_4c_TprMvCab.Numes, ;
                                    loc_cChave, "", cursor_4c_TpmMvItn.Cpros, ;
                                    loc_nValor, loc_dDataMov, loc_cMoeda)
                            ENDSCAN
                        ENDIF
                        SELECT cursor_4c_TprMvCab
                    ENDIF
                ENDSCAN

                loc_oProg.Complete(.T., .T.)
                loc_oProg = .NULL.
                =SQLCOMMIT(gnConnHandle)

                *-- Etapas 3 e 4: aplicar o apoio em SigCdCli e SigCdPro
                THIS.FecharCursorProcesso("cursor_4c_CsSelecao")
                IF SQLEXEC(gnConnHandle, "SELECT * FROM SigOpClU", "cursor_4c_CsSelecao") < 0
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! " + ;
                        "(cursor_4c_CsSelecao) " + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
                    loc_lFalhou = .T.
                ELSE
                    loc_lFalhou = !THIS.AtualizarUltimaCompraClientes()
                    IF !loc_lFalhou
                        loc_lFalhou = !THIS.AtualizarUltimaCompraProdutos()
                    ENDIF
                ENDIF

                loc_lSucesso = !loc_lFalhou
            ENDIF

            THIS.FecharCursorProcesso("cursor_4c_CsSelecao")
            THIS.FecharCursorProcesso("cursor_4c_TpmMvItn")
            THIS.FecharCursorProcesso("cursor_4c_TprMvCab")
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em AtualizarUltimaCompra")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * GravarApoioUltimaCompra - uma linha de SigOpClU (equivale a cada
    * "Insert Into CrSigOpClU (...)" do legado). Preenche TODAS as colunas
    * NOT NULL da tabela (regra #22): as que o legado nao informa recebem o
    * default do tipo, e cidchaves vem de fUniqueIds() (NUNCA vazio, senao a
    * 2a linha colide na PK).
    *==========================================================================
    PROTECTED PROCEDURE GravarApoioUltimaCompra(par_cEmps, par_cDopes, par_nNumes, ;
            par_cEmpDopNums, par_cIclis, par_cCpros, par_nValors, par_dDatas, par_cMoedas)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigOpClU " + ;
                "(cidchaves, emps, dopes, numes, empdopnums, " + ;
                "iclis, cpros, valors, datas, moedas, qtds) VALUES (" + ;
                EscaparSQL(fUniqueIds()) + ", " + ;
                EscaparSQL(LEFT(par_cEmps, 3)) + ", " + ;
                EscaparSQL(LEFT(par_cDopes, 20)) + ", " + ;
                FormatarNumeroSQL(par_nNumes, 0) + ", " + ;
                EscaparSQL(LEFT(par_cEmpDopNums, 29)) + ", " + ;
                EscaparSQL(LEFT(par_cIclis, 10)) + ", " + ;
                EscaparSQL(LEFT(par_cCpros, 14)) + ", " + ;
                FormatarNumeroSQL(par_nValors, 2) + ", " + ;
                FormatarDataSQL(par_dDatas) + ", " + ;
                EscaparSQL(LEFT(par_cMoedas, 3)) + ", " + ;
                FormatarNumeroSQL(0, 0) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                THIS.this_cMensagemErro = "Erro ao gravar SigOpClU: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro em GravarApoioUltimaCompra")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AtualizarUltimaCompraClientes - etapa 3 do ramo BtnCompra: para cada
    * cliente presente em SigOpClU grava em SigCdCli a ultima compra por
    * DATA (UltComps/vUltComps) e o maior faturamento por VALOR
    * (dtfats/mfats), igual aos dois "Select Top 1 ... Order by" do legado.
    *==========================================================================
    PROTECTED PROCEDURE AtualizarUltimaCompraClientes()
        LOCAL loc_lSucesso, loc_oErro, loc_nRestantes, loc_oProg, loc_cConta
        loc_lSucesso = .F.

        TRY
            THIS.FecharCursorProcesso("cursor_4c_SelecaoCli")
            SELECT DISTINCT Iclis FROM cursor_4c_CsSelecao ;
                WHERE !EMPTY(Iclis) INTO CURSOR cursor_4c_SelecaoCli READWRITE

            loc_nRestantes = IIF(USED("cursor_4c_SelecaoCli"), ;
                RECCOUNT("cursor_4c_SelecaoCli"), 0)

            loc_oProg = CREATEOBJECT("fwprogressbar", ;
                "Atualizando Valor da Ultima Compra Clientes", loc_nRestantes)
            loc_oProg.Titulo.FontBold = .T.
            loc_oProg.Show()

            SELECT cursor_4c_SelecaoCli
            SCAN
                loc_nRestantes = loc_nRestantes - 1
                loc_cConta = ALLTRIM(cursor_4c_SelecaoCli.Iclis)
                THIS.AtualizarProgresso(loc_nRestantes, loc_oProg, "Cliente " + loc_cConta)

                *-- Ultima compra (maior Datas) -> UltComps / vUltComps
                THIS.AplicarTopoSigOpClU("SigCdCli", "Iclis", loc_cConta, ;
                    "Datas DESC", "UltComps", "vUltComps", "")

                *-- Maior valor (maior Valors) -> dtfats / mfats
                THIS.AplicarTopoSigOpClU("SigCdCli", "Iclis", loc_cConta, ;
                    "Valors DESC", "dtfats", "mfats", "")

                =SQLCOMMIT(gnConnHandle)
                SELECT cursor_4c_SelecaoCli
            ENDSCAN

            loc_oProg.Complete(.T., .T.)
            loc_oProg = .NULL.
            THIS.FecharCursorProcesso("cursor_4c_SelecaoCli")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em AtualizarUltimaCompraClientes")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AtualizarUltimaCompraProdutos - etapa 4 do ramo BtnCompra: para cada
    * produto presente em SigOpClU grava em SigCdPro a ultima compra
    * (UltComps/vUltComps) e a moeda dela (mUltComps).
    *==========================================================================
    PROTECTED PROCEDURE AtualizarUltimaCompraProdutos()
        LOCAL loc_lSucesso, loc_oErro, loc_nRestantes, loc_oProg, loc_cProduto
        loc_lSucesso = .F.

        TRY
            THIS.FecharCursorProcesso("cursor_4c_SelecaoPro")
            SELECT DISTINCT Cpros FROM cursor_4c_CsSelecao ;
                WHERE !EMPTY(Cpros) INTO CURSOR cursor_4c_SelecaoPro READWRITE

            loc_nRestantes = IIF(USED("cursor_4c_SelecaoPro"), ;
                RECCOUNT("cursor_4c_SelecaoPro"), 0)

            loc_oProg = CREATEOBJECT("fwprogressbar", ;
                "Atualizando Valor da Ultima Compra Produtos", loc_nRestantes)
            loc_oProg.Titulo.FontBold = .T.
            loc_oProg.Show()

            SELECT cursor_4c_SelecaoPro
            SCAN
                loc_nRestantes = loc_nRestantes - 1
                loc_cProduto = ALLTRIM(cursor_4c_SelecaoPro.Cpros)
                THIS.AtualizarProgresso(loc_nRestantes, loc_oProg, "Produto " + loc_cProduto)

                THIS.AplicarTopoSigOpClU("SigCdPro", "Cpros", loc_cProduto, ;
                    "Datas DESC", "UltComps", "vUltComps", "mUltComps")

                =SQLCOMMIT(gnConnHandle)
                SELECT cursor_4c_SelecaoPro
            ENDSCAN

            loc_oProg.Complete(.T., .T.)
            loc_oProg = .NULL.
            THIS.FecharCursorProcesso("cursor_4c_SelecaoPro")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em AtualizarUltimaCompraProdutos")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AplicarTopoSigOpClU - le a linha TOPO de SigOpClU para uma chave
    * (ordenada por par_cOrdem) e grava data/valor/moeda na tabela destino.
    * Equivale ao par "Select Top 1 ... Order by ..." + "UpDate <tabela> Set
    * ..." do legado. Sem linha na origem, a data vai NULL (o
    * Iif(Reccount()=0, Null, ...) do legado) e valor/moeda ficam zerados.
    *==========================================================================
    PROTECTED PROCEDURE AplicarTopoSigOpClU(par_cTabela, par_cCampoChave, par_cValorChave, ;
            par_cOrdem, par_cCampoData, par_cCampoValor, par_cCampoMoeda)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cCursor
        LOCAL loc_cDataSQL, loc_nValor, loc_cMoeda
        loc_lSucesso = .F.
        loc_cCursor  = "cursor_4c_LocalCalcU"

        TRY
            THIS.FecharCursorProcesso(loc_cCursor)
            loc_cSQL = "SELECT TOP 1 Datas, Valors, Moedas FROM SigOpClU WHERE " + ;
                par_cCampoChave + " = " + EscaparSQL(par_cValorChave) + ;
                " ORDER BY " + par_cOrdem

            IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor) < 0
                THIS.this_cMensagemErro = "Favor reinicializar o processo. " + ;
                    "(cursor_4c_LocalCalcU) " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
            ELSE
                loc_cDataSQL = "NULL"
                loc_nValor   = 0
                loc_cMoeda   = ""

                IF USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
                    SELECT (loc_cCursor)
                    GO TOP
                    loc_cDataSQL = FormatarDataSQL(ConverterParaData(Datas))
                    loc_nValor   = NVL(Valors, 0)
                    loc_cMoeda   = NVL(Moedas, "")
                ENDIF
                THIS.FecharCursorProcesso(loc_cCursor)

                loc_cSQL = "UPDATE " + par_cTabela + " SET " + ;
                    par_cCampoData + " = " + loc_cDataSQL + ", " + ;
                    par_cCampoValor + " = " + FormatarNumeroSQL(loc_nValor, 2) + ;
                    IIF(EMPTY(par_cCampoMoeda), "", ", " + par_cCampoMoeda + " = " + ;
                        EscaparSQL(LEFT(loc_cMoeda, 3))) + ;
                    " WHERE " + par_cCampoChave + " = " + EscaparSQL(par_cValorChave)

                IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                    THIS.this_cMensagemErro = "Favor reinicializar o processo. " + ;
                        "(Update " + par_cTabela + ") " + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro em AplicarTopoSigOpClU")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AtualizarProgresso - centraliza o par "ThisForm.Get_Registro.Value =
    * lnReg / Refresh" + "Prog.SubTitulo.Caption = ... / Prog.Update(.t.)"
    * repetido em todos os Scan do legado. O contador tambem fica em
    * this_nRegistros, para quem nao tem referencia de form.
    *==========================================================================
    PROTECTED PROCEDURE AtualizarProgresso(par_nRestantes, par_oProgresso, par_cSubTitulo)
        THIS.this_nRegistros = par_nRestantes

        IF VARTYPE(THIS.this_oFormUI) = "O"
            THIS.this_oFormUI.AtualizarContadorRegistros(par_nRestantes)
        ENDIF

        IF VARTYPE(par_oProgresso) = "O"
            IF VARTYPE(par_cSubTitulo) = "C"
                par_oProgresso.SubTitulo.Caption = par_cSubTitulo
            ENDIF
            par_oProgresso.Update(.T.)
        ENDIF
    ENDPROC

    *==========================================================================
    * FecharCursorProcesso - fecha um cursor de trabalho se estiver aberto,
    * descartando alteracoes ainda nao gravadas do buffer (evita "Table buffer contains uncommitted
    * changes" na proxima passada do processamento)
    *==========================================================================
    PROTECTED PROCEDURE FecharCursorProcesso(par_cCursor)
        IF VARTYPE(par_cCursor) = "C" AND USED(par_cCursor)
            TABLEREVERT(.T., par_cCursor)
            USE IN SELECT(par_cCursor)
        ENDIF
    ENDPROC

ENDDEFINE
