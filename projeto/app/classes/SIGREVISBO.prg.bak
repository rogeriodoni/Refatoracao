*==============================================================================
* SIGREVISBO.PRG
* Business Object para Relatorio de Visitas (SIGREVIS)
* Herda de RelatorioBase
*
* Tabela principal: SigCdVis
* Relatorio FRX: SigReVis.frx
*
* Filtros:
*   - Periodo (data inicial / data final)
*   - Conta   (codigo + descricao - campo iclis/rclis de SigCdCli)
*   - Representante (codigo + descricao - campo iclis/rclis de SigCdCli,
*                    filtrado por Grupos = this_cGrupo)
*   - Opcao Venda  (1=Sim / 2=Nao / 3=Ambos)
*   - Opcao Pedido (1=Sim / 2=Nao / 3=Ambos)
*==============================================================================

DEFINE CLASS SIGREVISBO AS RelatorioBase

    *-- Filtro: periodo
    this_dDtInicial     = {}
    this_dDtFinal       = {}

    *-- Filtro: conta (iclis / rclis de SigCdCli)
    this_cCdConta       = ""
    this_cDsConta       = ""

    *-- Filtro: representante (iclis / rclis de SigCdCli, filtrado por Grupos)
    this_cCdRepr        = ""
    this_cDsRepr        = ""

    *-- Filtro: opcoes (1=Sim, 2=Nao, 3=Ambos - espelha Value do OptionGroup original)
    this_nOpcaoVenda    = 3
    this_nOpcaoPedido   = 3

    *-- Grupo padrao do usuario logado (GrPadVens de SigCdPam)
    *   Corresponde a propriedade custom 'antgru' do form legado SIGREVIS
    this_cGrupo         = ""

    *-- .T. quando o representante foi bloqueado automaticamente no Init
    *   (usuario sem permissao ALTCONTA em SIGCDVIS via fChecaAcesso)
    this_lReprBloqueado = .F.

    *-- Nome do cursor de saida populado por PrepararDados()
    this_cCursorDados   = "crSigCdVis"

    *--------------------------------------------------------------------------
    * Init - Configura BO do relatorio de visitas
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdVis"
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarFiltros - Carrega parametros iniciais e grupo padrao do usuario.
    * Chamado pelo form em InicializarForm().
    * Equivalente ao bloco de Init() do form legado SIGREVIS que carrega
    * GrPadVens de SigCdPam e verifica permissao ALTCONTA via fChecaAcesso.
    *--------------------------------------------------------------------------
    PROCEDURE InicializarFiltros()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            *-- Buscar grupo padrao do usuario (GrPadVens de SigCdPam)
            loc_cSQL = "SELECT GrPadVens FROM SigCdPam"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar par" + CHR(226) + ;
                    "metros do sistema (SigCdPam)"
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_Pam
            THIS.this_cGrupo = ALLTRIM(GrPadVens)
            USE IN cursor_4c_Pam

            *-- Sistema novo: acesso irrestrito a conta/representante para todos os usuarios
            THIS.this_lReprBloqueado = .F.

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta cursor crSigCdVis com dados de visitas conforme
    * filtros definidos nas propriedades this_*.
    * Equivalente ao metodo 'processamento' do form legado SIGREVIS.
    * Tambem cria cursor CsCabecalho para cabecalho do relatorio FRX.
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_nResult
        LOCAL loc_dDtI, loc_dDtF, loc_cDtFSQL
        LOCAL loc_cEmpresa, loc_cTitulo, loc_cPeriodo
        loc_lSucesso = .F.
        TRY
            *-- Normalizar datas: sem data = faixa maxima historica
            loc_dDtI = IIF(EMPTY(THIS.this_dDtInicial), {^1900-01-01}, THIS.this_dDtInicial)
            loc_dDtF = IIF(EMPTY(THIS.this_dDtFinal),   {^2099-12-31}, THIS.this_dDtFinal)

            *-- Data final com 23:59:59 para cobrir dia inteiro (campo DATETIME)
            loc_cDtFSQL = "'" + ;
                PADL(YEAR(loc_dDtF),  4, "0") + "-" + ;
                PADL(MONTH(loc_dDtF), 2, "0") + "-" + ;
                PADL(DAY(loc_dDtF),   2, "0") + " 23:59:59'"

            *-- Clausula WHERE adicional com filtros opcionais
            loc_cWhere = ""

            *-- Filtro conta (iclis de SigCdCli)
            IF !EMPTY(ALLTRIM(THIS.this_cCdConta))
                loc_cWhere = loc_cWhere + ;
                    " AND a.iclis = " + EscaparSQL(ALLTRIM(THIS.this_cCdConta))
            ENDIF

            *-- Filtro representante (Contas de SigCdVis = iclis de SigCdCli)
            IF !EMPTY(ALLTRIM(THIS.this_cCdRepr))
                loc_cWhere = loc_cWhere + ;
                    " AND a.Contas = " + EscaparSQL(ALLTRIM(THIS.this_cCdRepr))
            ENDIF

            *-- Fechar cursor anterior se existir
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            *-- Query principal: SigCdVis com JOIN duplo em SigCdCli
            *-- b = conta do cliente (a.iclis), c = representante (a.Contas)
            loc_cSQL = "SELECT a.*," + ;
                " b.rclis AS descri," + ;
                " c.rclis AS repr," + ;
                " CASE WHEN a.vendas=1 THEN 'Sim'" + ;
                "      ELSE 'N" + CHR(227) + "o' END AS descvendas," + ;
                " CASE WHEN a.pedidos=1 THEN 'Sim'" + ;
                "      ELSE 'N" + CHR(227) + "o' END AS descpedidos" + ;
                " FROM SigCdVis a" + ;
                " INNER JOIN SigCdCli b ON a.iclis = b.iclis" + ;
                " INNER JOIN SigCdCli c ON a.Contas = c.iclis" + ;
                " WHERE a.Grupos = " + EscaparSQL(THIS.this_cGrupo) + ;
                " AND a.Datas BETWEEN " + FormatarDataSQL(loc_dDtI) + ;
                " AND " + loc_cDtFSQL + ;
                loc_cWhere + ;
                " ORDER BY a.Contas"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao buscar dados de visitas"
                loc_lSucesso = .F.
            ENDIF

            *-- Cursor de cabecalho para o relatorio (CsCabecalho)
            loc_cEmpresa = ""
            loc_cSQL = "SELECT Razas FROM SigCdEmp"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpCab") > 0
                SELECT cursor_4c_EmpCab
                IF !EOF()
                    loc_cEmpresa = ALLTRIM(cursor_4c_EmpCab.Razas)
                ENDIF
                USE IN cursor_4c_EmpCab
            ENDIF

            loc_cTitulo  = "Relat" + CHR(243) + "rio de Visitas"
            loc_cPeriodo = "Per" + CHR(237) + "odo: " + DTOC(loc_dDtI) + ;
                " " + CHR(150) + " " + DTOC(loc_dDtF)

            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF
            CREATE CURSOR CsCabecalho (cb_empresa C(80), cb_titulo C(80), cb_periodo C(80))
            INSERT INTO CsCabecalho (cb_empresa, cb_titulo, cb_periodo) ;
                VALUES (loc_cEmpresa, loc_cTitulo, loc_cPeriodo)

            SELECT (THIS.this_cCursorDados)
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Restaura filtros a partir de um cursor de configuracao
    * salva (filtros usados anteriormente pelo usuario).
    *
    * Espera um cursor com os campos opcionais:
    *   dt_inicial, dt_final  (data)
    *   cd_conta,   ds_conta  (char)
    *   cd_repr,    ds_repr   (char)
    *   opc_venda,  opc_pedido (numerico 1/2/3)
    *
    * Cada campo eh aplicado somente se existir no cursor (uso de TYPE() para
    * verificar presenca). Util para "ultimo filtro usado" sem quebrar quando
    * o esquema do cursor evoluir.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias
        loc_lSucesso = .F.
        TRY
            IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
                THIS.this_cMensagemErro = "Cursor de filtros n" + CHR(227) + ;
                    "o dispon" + CHR(237) + "vel: " + TRANSFORM(par_cAliasCursor)
                loc_lSucesso = .F.
            ENDIF

            loc_cAlias = ALLTRIM(par_cAliasCursor)
            SELECT (loc_cAlias)
            IF EOF()
                THIS.this_cMensagemErro = "Cursor de filtros vazio"
                loc_lSucesso = .F.
            ENDIF

            *-- Periodo
            IF TYPE(loc_cAlias + ".dt_inicial") = "D"
                THIS.this_dDtInicial = EVALUATE(loc_cAlias + ".dt_inicial")
            ENDIF
            IF TYPE(loc_cAlias + ".dt_final") = "D"
                THIS.this_dDtFinal = EVALUATE(loc_cAlias + ".dt_final")
            ENDIF

            *-- Conta
            IF TYPE(loc_cAlias + ".cd_conta") = "C"
                THIS.this_cCdConta = ALLTRIM(EVALUATE(loc_cAlias + ".cd_conta"))
            ENDIF
            IF TYPE(loc_cAlias + ".ds_conta") = "C"
                THIS.this_cDsConta = ALLTRIM(EVALUATE(loc_cAlias + ".ds_conta"))
            ENDIF

            *-- Representante
            IF TYPE(loc_cAlias + ".cd_repr") = "C"
                THIS.this_cCdRepr = ALLTRIM(EVALUATE(loc_cAlias + ".cd_repr"))
            ENDIF
            IF TYPE(loc_cAlias + ".ds_repr") = "C"
                THIS.this_cDsRepr = ALLTRIM(EVALUATE(loc_cAlias + ".ds_repr"))
            ENDIF

            *-- Opcoes Venda/Pedido (manter dentro de 1..3, default 3=Ambos)
            IF TYPE(loc_cAlias + ".opc_venda") = "N"
                THIS.this_nOpcaoVenda = IIF(BETWEEN(EVALUATE(loc_cAlias + ".opc_venda"), 1, 3), ;
                    EVALUATE(loc_cAlias + ".opc_venda"), 3)
            ENDIF
            IF TYPE(loc_cAlias + ".opc_pedido") = "N"
                THIS.this_nOpcaoPedido = IIF(BETWEEN(EVALUATE(loc_cAlias + ".opc_pedido"), 1, 3), ;
                    EVALUATE(loc_cAlias + ".opc_pedido"), 3)
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - BLOQUEADO: relatorios nao persistem dados.
    *
    * Override defensivo: caso o BO seja usado por engano como CRUD, retorna
    * erro explicito ao inves de corromper o banco com INSERT vazio.
    * Equivale a recusa do form legado SIGREVIS, que nao tinha botao "Incluir".
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada: relat" + CHR(243) + ;
            "rios de visitas n" + CHR(227) + "o gravam registros." + CHR(13) + ;
            "Use PrepararDados() seguido de Imprimir()."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - BLOQUEADO: relatorios nao persistem dados.
    *
    * Override defensivo: simetrico a Inserir(). Reports nao modificam SigCdVis;
    * apenas extraem dados via SELECT em PrepararDados().
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada: relat" + CHR(243) + ;
            "rios de visitas n" + CHR(227) + "o alteram registros." + CHR(13) + ;
            "Use PrepararDados() seguido de Imprimir()."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro atual
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha cursores abertos por InicializarFiltros e PrepararDados
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Pam")
            USE IN cursor_4c_Pam
        ENDIF
        IF USED("cursor_4c_EmpCab")
            USE IN cursor_4c_EmpCab
        ENDIF
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        IF USED("CsCabecalho")
            USE IN CsCabecalho
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
