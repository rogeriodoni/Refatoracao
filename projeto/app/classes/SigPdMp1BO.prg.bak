*==============================================================================
* SIGPDMP1BO.PRG
* Business Object para Componentes Agregados (SIGPDMP1)
* Form operacional: exibe e permite edicao de componentes de uma operacao
* de industrializacao. Recebe cursor xNensi do form pai e trabalha
* com cursores locais cursor_4c_Distrib e cursor_4c_Resumo.
*==============================================================================

DEFINE CLASS SigPdMp1BO AS BusinessBase

    *-- Tabela e chave (form operacional sem CRUD direto na tabela principal)
    this_cTabela     = ""
    this_cCampoChave = ""

    *-- Dados da operacao (vindos de tmpnens / xNensi do form pai)
    this_nNumPs  = 0    && Numero da operacao (tmpnens.numps)
    this_cEmps   = ""   && Empresa (tmpnens.emps)
    this_cDOpPs  = ""   && Descricao da operacao (tmpnens.dopps)
    this_cTitulo = ""   && Titulo da col. Industrializacao (ParentForm.ParentForm.Titulo)

    *-- Controle de edicao
    this_lLiberaAlteracao = .F.  && .T. quando usuario clica Alterar
    this_cEscolha         = ""   && "INSERIR" ou outro modo vindo do form pai

    *-- Posicao de navegacao em xNensi antes de abrir o form
    this_nRecnoAnt = 0

    *-- Totalizador de peso (soma de PsFaseAnt dos registros nao-visiveis)
    this_nTotPeso = 0

    *-- Valor anterior de celula em edicao no grid (controle de alteracao)
    this_nAntValue = 0

    *--------------------------------------------------------------------------
    * INIT - Inicializa BO operacional de Componentes Agregados
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna identificador da operacao corrente
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_nNumPs
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor_4c_Distrib
    * Mapeia colunas da linha corrente do grid principal
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nNumPs = TratarNulo(Nops,   "N")
            THIS.this_cEmps  = ALLTRIM(TratarNulo(CMats,  "C"))
            THIS.this_cDOpPs = ALLTRIM(TratarNulo(CDescs, "C"))
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarDistrib - Cria cursor_4c_Distrib a partir de xNensi
    * Equivale ao bloco de criacao do TmpDistrib no Init original.
    * Percorre xNensi na ordem NopCMat, incluindo apenas registros onde
    * Visivel = .F. (os que ainda nao foram distribuidos).
    * par_cTitulo: caption dinamico da coluna Industrializacao
    * Retorna .T. em caso de sucesso
    *--------------------------------------------------------------------------
    FUNCTION InicializarDistrib(par_cTitulo)
        LOCAL loc_lSucesso, loc_nTotPeso, loc_nX, loc_nQtds, loc_nPesos
        loc_lSucesso = .F.
        loc_nTotPeso = 0
        loc_nX       = 1

        TRY
            THIS.this_cTitulo = par_cTitulo

            *-- Recria cursor de distribuicao (sempre, antes de acessar xNensi)
            IF USED("cursor_4c_Distrib")
                USE IN cursor_4c_Distrib
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_Distrib ( ;
                Nops    N(10,0), ;
                Nenvs   N(10,0), ;
                CodPds  C(10),   ;
                CMats   C(14),   ;
                CUnis   C(3),    ;
                Qtds    N(10,3), ;
                Pesos   N(10,3), ;
                Qtds2   N(10,3), ;
                Pesos2  N(10,3), ;
                CDescs  C(40),   ;
                CGrus   C(3),    ;
                TpOps   C(15),   ;
                nLotes  N(10,0), ;
                Qtd2s   N(10,3), ;
                Peso2s  N(10,3), ;
                cUniPs  C(3),    ;
                CodCors C(4),    ;
                CodTams C(4),    ;
                nTrans  N(6,0),  ;
                Locals  C(1)     ;
            )

            IF USED("xNensi")
                *-- Salva posicao corrente de xNensi para restaurar no OK
                SELECT xNensi
                THIS.this_nRecnoAnt = RECNO()

                *-- Percorre xNensi em ordem NopCMat, pula visiveis (ja distribuidos)
                SET ORDER TO NopCMat
                SCAN
                    IF xNensi.Visivel
                        LOOP
                    ENDIF

                    loc_nQtds  = xNensi.QtFaseAnt
                    loc_nPesos = xNensi.PsFaseAnt

                    REPLACE nTrans WITH loc_nX IN xNensi

                    INSERT INTO cursor_4c_Distrib ( ;
                        Nops, Nenvs, Qtds2, Pesos2, CUnis, CMats, CDescs, ;
                        CGrus, Qtds, Pesos, nLotes, Peso2s, cUniPs, ;
                        CodCors, CodTams, nTrans ;
                    ) VALUES ( ;
                        xNensi.Nops, xNensi.Nenvs, loc_nQtds, loc_nPesos, ;
                        xNensi.CUnis, xNensi.CMats, xNensi.CDescs, ;
                        xNensi.CGrus, xNensi.Qtds, xNensi.Pesos, xNensi.nLotes, ;
                        xNensi.Peso2s, xNensi.cUniPs, xNensi.CodCors, ;
                        xNensi.CodTams, xNensi.nTrans ;
                    )

                    loc_nX       = loc_nX + 1
                    loc_nTotPeso = loc_nTotPeso + loc_nPesos
                ENDSCAN

                THIS.this_nTotPeso = loc_nTotPeso
            ENDIF

            SELECT cursor_4c_Distrib
            GO TOP
            SET NULL OFF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * InicializarResumo - Cria cursor_4c_Resumo com totais por componente
    * Replica SELECT...GROUP BY...INTO CURSOR TmpResumo do Init original.
    * Agrupa xNensi onde Visivel = .T. (registros ja distribuidos).
    * Retorna .T. em caso de sucesso
    *--------------------------------------------------------------------------
    FUNCTION InicializarResumo()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Resumo")
                USE IN cursor_4c_Resumo
            ENDIF

            IF USED("xNensi")
                SELECT CMats, CUnis, CUniPs,      ;
                       SUM(Qtds)   AS Qtds,       ;
                       SUM(Pesos)  AS Pesos,      ;
                       SUM(Peso2s) AS Peso2s      ;
                FROM xNensi                       ;
                WHERE xNensi.Visivel              ;
                GROUP BY CMats, CUnis, CUniPs     ;
                INTO CURSOR cursor_4c_Resumo READWRITE
            ELSE
                CREATE CURSOR cursor_4c_Resumo ( ;
                    CMats  C(14),   ;
                    CUnis  C(3),    ;
                    CUniPs C(3),    ;
                    Qtds   N(10,3), ;
                    Pesos  N(10,3), ;
                    Peso2s N(10,3)  ;
                )
            ENDIF

            SELECT cursor_4c_Resumo
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarAlteracoes - Grava linhas modificadas de cursor_4c_Distrib em xNensi
    * Replica logica do botao OK original.
    * So persiste quando this_lLiberaAlteracao = .T. (usuario clicou Alterar).
    * Identifica linhas modificadas pelo campo Locals = 'M'.
    * Atualiza Qtds, Pesos e Peso2s em xNensi via nTrans.
    * Retorna .T. em caso de sucesso
    *--------------------------------------------------------------------------
    FUNCTION SalvarAlteracoes()
        LOCAL loc_lSucesso
        loc_lSucesso = .T.

        TRY
            IF THIS.this_lLiberaAlteracao
                SELECT cursor_4c_Distrib
                SCAN
                    IF cursor_4c_Distrib.Locals = "M"
                        SELECT xNensi
                        LOCATE FOR nTrans = cursor_4c_Distrib.nTrans
                        IF !EOF()
                            REPLACE Qtds   WITH cursor_4c_Distrib.Qtds, ;
                                    Pesos  WITH cursor_4c_Distrib.Pesos, ;
                                    Peso2s WITH cursor_4c_Distrib.Peso2s
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * HabilitarAlteracao - Permite edicao nas colunas Pesos, Qtds e Peso2s
    * Define this_lLiberaAlteracao = .T. para que SalvarAlteracoes persista
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarAlteracao()
        THIS.this_lLiberaAlteracao = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarModificado - Marca registro corrente de cursor_4c_Distrib como 'M'
    * Chamado pelos handlers de Valid/KeyPress do grid ao detectar mudanca
    *--------------------------------------------------------------------------
    PROCEDURE MarcarModificado()
        LOCAL loc_oErro
        TRY
            IF USED("cursor_4c_Distrib")
                REPLACE Locals WITH "M" IN cursor_4c_Distrib
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel: form operacional nao insere registros no banco
    * A criacao inicial dos componentes ocorre via InicializarDistrib (cursor
    * em memoria) e a persistencia eh feita em xNensi pelo form pai (SigPdMov)
    * no momento do salvamento global da operacao.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Persiste alteracoes do cursor_4c_Distrib em xNensi
    * Equivale ao "OK Click" do form original: percorre linhas marcadas como
    * 'M' (modificadas) e replica Qtds/Pesos/Peso2s para o cursor pai xNensi
    * via campo nTrans. Form operacional nao executa UPDATE direto no banco;
    * a gravacao em SigPdNen ocorre pelo form SigPdMov que mantem xNensi.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN THIS.SalvarAlteracoes()
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Nao aplicavel: form operacional usa cursores locais
    * Alteracoes ficam em xNensi (cursor do datasession do form pai)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        IF EMPTY(par_cOperacao)
            RETURN
        ENDIF
        RETURN
    ENDPROC

ENDDEFINE
