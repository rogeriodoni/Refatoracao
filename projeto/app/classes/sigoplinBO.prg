*====================================================================
* sigoplinBO.prg
*
* Business Object para Lote de Instrucoes (Cheques/Titulos)
* Tabela principal : SigPrLit  (PK: cidchaves char(20))
* Tabela detalhe   : SigPrLii  (PK: cidchaves char(20), FK logica: tipos+numlotes)
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*====================================================================

DEFINE CLASS sigoplinBO AS BusinessBase

    *-- Propriedades da entidade (SigPrLit)
    *-- PK
    this_cCidchaves = ""    && cidchaves char(20) - PK (chave unica)
    *-- Identificacao do lote
    this_nTipos     = 0     && tipos numeric(1,0)    - 1=Cheques, 2=Titulos
    this_nNumlotes  = 0     && numlotes numeric(8,0) - numero do lote
    this_cCods      = ""    && cods char(10)         - codigo da instrucao (FK SigOpIns.Cods)
    this_dDatas     = {}    && datas datetime NULL   - data da instrucao
    this_cEmps      = ""    && emps char(3)          - empresa
    this_cGrupos    = ""    && grupos char(10)       - grupo de estoque/contabil (SigCdGcr)
    this_cContas    = ""    && contas char(10)       - conta de estoque/contabil (SigCdCli)
    this_nValors    = 0     && valors numeric(11,2)  - valor total do lote
    this_cMoedas    = ""    && moedas char(3)        - moeda (SigCdMoe.CMoes)
    this_cObs       = ""    && obs text NULL         - observacao
    this_cUsuarios  = ""    && usuarios char(10)     - usuario que gerou o lote

    *-- Propriedades de exibicao - nao armazenadas no banco
    this_cDGrupos   = ""    && descricao do grupo de estoque (exibicao)
    this_cDContas   = ""    && descricao da conta de estoque (exibicao)
    this_cDMoedas   = ""    && descricao da moeda (exibicao)
    this_nQtdeItens = 0     && quantidade de itens do detalhe (calculada)

    *-- Alias do cursor de detalhe (SigPrLii)
    this_cCursorDetalhe = "cursor_4c_Detalhe"

    *====================================================================
    * Init - Inicializa Business Object configurando tabela e chave primaria
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrLit"
            THIS.this_cCampoChave = "cidchaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidchaves
    ENDPROC

    *====================================================================
    * LimparDados - Reseta as propriedades para um novo registro.
    * Chamado por NovoRegistro() (BusinessBase) antes de
    * InicializarValoresPadrao() - sem este override, um registro
    * carregado anteriormente (Alterar/Visualizar) deixaria lixo nas
    * properties ao clicar Incluir em seguida.
    *====================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cCidchaves = ""
        THIS.this_nTipos     = 0
        THIS.this_nNumlotes  = 0
        THIS.this_cCods      = ""
        THIS.this_dDatas     = {}
        THIS.this_cEmps      = ""
        THIS.this_cGrupos    = ""
        THIS.this_cContas    = ""
        THIS.this_nValors    = 0
        THIS.this_cMoedas    = ""
        THIS.this_cObs       = ""
        THIS.this_cUsuarios  = ""

        THIS.this_cDGrupos   = ""
        THIS.this_cDContas   = ""
        THIS.this_cDMoedas   = ""
        THIS.this_nQtdeItens = 0
    ENDPROC

    *====================================================================
    * ValidarDados - Transcricao da unica validacao do mestre feita no
    * Salva.Click legado (SIGOPLIN.Pagina.Dados.Grupo_Salva.Salva.Click):
    * "If Empty(ThisForm.Pagina.Dados.getInstrucao.Value) -> 'Instrucao
    * Invalida!!!'". As validacoes de linha do detalhe (cheque/titulo com
    * dados incompletos) pertencem ao Grid/Form (Fase 4+), nao ao mestre.
    *====================================================================
    PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cCods))
            MsgAviso("Instru" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * Mapeia TODAS as colunas de SigPrLit. REGRA CRITICA: SELECT
    * (par_cAliasCursor) ANTES de acessar campos (sem alias).
    * TratarNulo recebe o VALOR PADRAO real do tipo da coluna - NUNCA o
    * codigo de tipo "C"/"N"/"D" (regra CLAUDE.md / feedback
    * tratarnulo_2o_arg_eh_valor_padrao).
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_nTipos    = TratarNulo(tipos,     0)
                THIS.this_nNumlotes = TratarNulo(numlotes,  0)
                THIS.this_cCods     = TratarNulo(cods,      "")
                THIS.this_dDatas    = TratarNulo(datas,     {})
                THIS.this_cEmps     = TratarNulo(emps,      "")
                THIS.this_cGrupos   = TratarNulo(grupos,    "")
                THIS.this_cContas   = TratarNulo(contas,    "")
                THIS.this_nValors   = TratarNulo(valors,    0)
                THIS.this_cMoedas   = TratarNulo(moedas,    "")
                THIS.this_cObs      = TratarNulo(obs,       "")
                THIS.this_cUsuarios = TratarNulo(usuarios,  "")
                THIS.this_cCidchaves = TratarNulo(cidchaves, "")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "sigoplinBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - Insere novo lote de instrucoes na tabela SigPrLit.
    *
    * Transcricao do Case 'INSERIR' do PROCEDURE ChamarMLeDados legado
    * (Replace Tipos, NumLotes, Emps, Usuarios, Datas, Valors, Moedas,
    * cIdChaves In crSigPrLit): cidchaves (PK Fortyus) e numlotes
    * (sequencia por tipo: 'LOTEINSTCHQ'/'LOTEINSTTIT') sao gerados aqui
    * quando ainda nao foram atribuidos, igual ao legado
    * (fUniqueIds()/fGerUniqueKey('LOTEINST' + Iif(Tipos=1,'CHQ','TIT'))).
    * Emps usa go_4c_Sistema.cCodEmpresa - NUNCA a global legado _Empr
    * (CLAUDE.md: _EMPR NUNCA usar). Usuarios usa gc_4c_UsuarioLogado no
    * lugar da memvar Usuar do legado.
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidchaves))
                THIS.this_cCidchaves = fUniqueIds()
            ENDIF

            IF THIS.this_nNumlotes = 0
                THIS.this_nNumlotes = fGerUniqueKey("LOTEINST" + IIF(THIS.this_nTipos = 1, "CHQ", "TIT"))
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cEmps))
                THIS.this_cEmps = IIF(TYPE("go_4c_Sistema.cCodEmpresa") = "C", go_4c_Sistema.cCodEmpresa, "")
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cUsuarios))
                THIS.this_cUsuarios = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "")
            ENDIF

            IF EMPTY(THIS.this_dDatas)
                THIS.this_dDatas = DATETIME()
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigPrLit (tipos, numlotes, cods, datas, emps, grupos, contas, valors, moedas, obs, usuarios, cidchaves)
                VALUES (
                    <<FormatarNumeroSQL(THIS.this_nTipos, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nNumlotes, 0)>>,
                    <<EscaparSQL(THIS.this_cCods)>>,
                    <<FormatarDataSQL(THIS.this_dDatas)>>,
                    <<EscaparSQL(THIS.this_cEmps)>>,
                    <<EscaparSQL(THIS.this_cGrupos)>>,
                    <<EscaparSQL(THIS.this_cContas)>>,
                    <<FormatarNumeroSQL(THIS.this_nValors, 2)>>,
                    <<EscaparSQL(THIS.this_cMoedas)>>,
                    <<EscaparSQL(THIS.this_cObs)>>,
                    <<EscaparSQL(THIS.this_cUsuarios)>>,
                    <<EscaparSQL(THIS.this_cCidchaves)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir lote de instru" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro(loException, "sigoplinBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza lote de instrucoes existente na tabela
    * SigPrLit. Tipos/Numlotes/Emps/Usuarios/Cidchaves sao identidade do
    * registro e NAO sao regravados no Alterar (o legado tambem so os
    * atribui no Case 'INSERIR').
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigPrLit
                SET cods   = <<EscaparSQL(THIS.this_cCods)>>,
                    datas  = <<FormatarDataSQL(THIS.this_dDatas)>>,
                    grupos = <<EscaparSQL(THIS.this_cGrupos)>>,
                    contas = <<EscaparSQL(THIS.this_cContas)>>,
                    valors = <<FormatarNumeroSQL(THIS.this_nValors, 2)>>,
                    moedas = <<EscaparSQL(THIS.this_cMoedas)>>,
                    obs    = <<EscaparSQL(THIS.this_cObs)>>
                WHERE cidchaves = <<EscaparSQL(THIS.this_cCidchaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar lote de instru" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro(loException, "sigoplinBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui o lote de instrucoes e seus itens.
    * O legado exclui por NumLotes+Tipos (Delete From SigPrLit Where
    * NumLotes = ?pLot And Tipos = ?pTip) depois de limpar crSigPrLii do
    * mesmo lote; aqui o mestre e excluido pela PK real (cidchaves) e o
    * detalhe (SigPrLii) e excluido primeiro, pela chave de negocio
    * Tipos+NumLotes que os dois compartilham (SigPrLii nao tem FK para
    * SigPrLit.cidchaves no schema).
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrLii" + ;
                " WHERE tipos = " + FormatarNumeroSQL(THIS.this_nTipos, 0) + ;
                " AND numlotes = " + FormatarNumeroSQL(THIS.this_nNumlotes, 0)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                loc_cSQL = "DELETE FROM SigPrLit WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao excluir lote de instru" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MostrarErro("Erro ao excluir itens do lote:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro(loException, "sigoplinBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca lotes de instrucoes com filtro opcional (ex.:
    * "tipos = 1" para a aba Cheques, ou faixa de datas da Pagina.Lista
    * legada). Retorna cursor_4c_Dados com as colunas usadas na grade.
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (tipos N(1,0), numlotes N(8,0), cods C(10), ;
                        datas T, grupos C(10), contas C(10), valors N(11,2), moedas C(3), cidchaves C(20))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT tipos, numlotes, cods, datas, grupos, contas, valors, moedas, cidchaves" + ;
                    " FROM SigPrLit"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY numlotes DESC"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar lotes de instru" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro(loException, "sigoplinBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega o lote pela chave primaria (cidchaves)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCidchaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT tipos, numlotes, cods, datas, emps, grupos, contas, valors, moedas, obs, usuarios, cidchaves" + ;
                " FROM SigPrLit WHERE cidchaves = " + EscaparSQL(par_cCidchaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Lote de instru" + CHR(231) + CHR(245) + "es n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar lote de instru" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro(loException, "sigoplinBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * DECISAO DE PROJETO (Fase 2 - CRUD):
    * O detalhe (SigPrLii: itens de cheque/titulo do lote, ligados por
    * Tipos+NumLotes) nao tem CRUD proprio nesta fase - carga/gravacao do
    * grid (cntGradeCheques/cntGradeTitulos) e responsabilidade das fases
    * de Form/Grid (3-8), que populam this_cCursorDetalhe diretamente via
    * SQLEXEC, igual ao padrao de outras telas mestre-detalhe do projeto.
    * ExecutarExclusao() acima ja remove os itens do detalhe ao excluir o
    * lote inteiro.
    *====================================================================

ENDDEFINE
