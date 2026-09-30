*==============================================================================
* SIGPRES2BO.PRG
* Business Object para o dialogo de Origem/Destino/Representante de Movimento
* (SIGPRES2 - dialogo filho aberto por um form OPERACIONAL pai via
*  "Do Form SigPrEs2 With ThisForm, ...", NAO acessivel direto pelo menu)
*
* Tabela Principal : SigMvCab (cabecalho de movimentacao)
* Chave Real (PK)  : CidChaves    CHAR(20)
* Chave Posicional : EmpDopNums   CHAR(29) = Emps CHAR(3) + Dopes CHAR(20) + Str(Numes, 6)
*                     (NUNCA usar ALLTRIM nas partes - ver CLAUDE.md regra #42)
*
* Logica do legado: o form pai ja populou um cursor local (csTemporario) com o
* registro (ou lote de registros) de SigMvCab a editar; o SIGPRES2 apenas edita
* os campos de cabecalho abaixo (Origem/Destino/Representante/Status/Prazo) e
* delega o commit ao TableUpdate do buffer do framework (Grupo_Salva.Salva.Click
* so chama DoDefault() + mAtivapagina1 - nao ha INSERT/UPDATE/DELETE proprios no
* codigo fonte do SIGPRES2). Os campos de item (grid fwgrade1/xEestI, vindos de
* SigMvItn/SigMvIts) e a grade de operacoes (TmpOperacao/SigMvPec) sao
* somente-leitura e pertencem a um cursor de detalhe, nao a properties escalares
* deste BO.
*==============================================================================

DEFINE CLASS sigpres2BO AS BusinessBase

    *-- Chave composta do movimento (SigMvCab)
    this_cEmpresa            = ""   && Emps        CHAR(3)  - Empresa (parte da chave posicional)
    this_cTipoDocumento      = ""   && Dopes        CHAR(20) - Tipo de documento (parte da chave posicional)
    this_nNumero             = 0    && Numes        NUMERIC(6,0) - Numero do documento (parte da chave posicional)
    this_cEmpresaDestino     = ""   && Empds        CHAR(3)  - Empresa de destino (grid Lista, coluna "EmpD")
    this_cChaveMovimento     = ""   && EmpDopNums   CHAR(29) - Chave posicional (Emps+Dopes+Str(Numes,6))
    this_cCidChave           = ""   && CidChaves    CHAR(20) - Chave primaria real da tabela

    *-- Origem / Destino / Representante (container "Origem" da Pagina Dados)
    this_cGrupoOrigem        = ""   && Grupoos      CHAR(10)
    this_cContaOrigem        = ""   && Contaos      CHAR(10)
    this_cGrupoDestino       = ""   && Grupods      CHAR(10)
    this_cContaDestino       = ""   && Contads      CHAR(10)
    this_cRepresentante      = ""   && Vends        CHAR(10)
    this_cGrupoRepresentante = ""   && Grvends      CHAR(10)

    *-- Demais campos de cabecalho editaveis na Pagina Dados
    this_cTabelaDesconto     = ""   && Tabds        CHAR(10)
    this_cStatus             = ""   && PStatus      CHAR(1)
    this_cUsuario            = ""   && Usuars       CHAR(10) - usuario do movimento (grid Lista, coluna "Usuario")
    this_nNumeroOP           = 0    && Nops         NUMERIC(10,0)
    this_dPrazoEntrega       = {}   && PrazoEnts    DATETIME
    this_cCodigoMascarado    = ""   && MascNum      CHAR(10) - exibicao formatada (Get_codigo), somente leitura
    this_cDocumento          = ""   && Notas        CHAR(6)  - numero do documento/nota (Get_nota)
    this_dData               = {}   && Datas        DATETIME
    this_cObservacao         = ""   && Obses        TEXT (memo)

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = "CidChaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave real da tabela (CidChaves), usada por
    * RegistrarAuditoria() e pela clausula WHERE de Atualizar()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChave)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia as colunas de SigMvCab que este dialogo edita
    * (Origem/Destino/Representante/cabecalho) para as properties do BO.
    * SELECT (par_cAliasCursor) ANTES de acessar os campos (regra #8 CLAUDE.md).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cEmpresa            = TratarNulo(emps, "")
                THIS.this_cTipoDocumento      = TratarNulo(dopes, "")
                THIS.this_nNumero             = TratarNulo(numes, 0)
                THIS.this_cEmpresaDestino     = TratarNulo(empds, "")
                THIS.this_cChaveMovimento     = TratarNulo(empdopnums, "")
                THIS.this_cCidChave           = TratarNulo(cidchaves, "")

                THIS.this_cGrupoOrigem        = TratarNulo(grupoos, "")
                THIS.this_cContaOrigem        = TratarNulo(contaos, "")
                THIS.this_cGrupoDestino       = TratarNulo(grupods, "")
                THIS.this_cContaDestino       = TratarNulo(contads, "")
                THIS.this_cRepresentante      = TratarNulo(vends, "")
                THIS.this_cGrupoRepresentante = TratarNulo(grvends, "")

                THIS.this_cTabelaDesconto     = TratarNulo(tabds, "")
                THIS.this_cStatus             = TratarNulo(pstatus, "")
                THIS.this_cUsuario            = TratarNulo(usuars, "")
                THIS.this_nNumeroOP           = TratarNulo(nops, 0)
                THIS.this_dPrazoEntrega       = TratarNulo(prazoents, {})
                THIS.this_cCodigoMascarado    = TratarNulo(mascnum, "")
                THIS.this_cDocumento          = TratarNulo(notas, "")
                THIS.this_dData               = TratarNulo(datas, {})
                THIS.this_cObservacao         = TratarNulo(obses, "")

                THIS.this_lNovoRegistro = .F.
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigpres2BO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega o movimento pela chave real (CidChaves).
    * SELECT * (como no legado, que abre o registro inteiro via csTemporario)
    * para que CarregarDoCursor sempre encontre as colunas que le.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT * FROM SigMvCab WHERE cidchaves = " + EscaparSQL(par_cCodigo)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                ELSE
                    MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar movimenta" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "sigpres2BO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE parcial em SigMvCab, restrito aos campos que este
    * dialogo de fato edita (Origem/Destino/Representante/Status/Prazo/
    * Documento/Data/Observacao). Equivalente ao TableUpdate() do buffer
    * otimista do framework legado: Grupo_Salva.Salva.Click do SIGPRES2 nao
    * tem SQL proprio (so DoDefault() + mAtivapagina1 - ver cabecalho do
    * arquivo), mas o buffer so envia ao SQL Server as colunas realmente
    * alteradas na tela - por isso o UPDATE aqui cobre so essas colunas,
    * nunca a linha inteira (colunas de identificacao como Emps/Dopes/Numes/
    * EmpDopNums/MascNum sao somente leitura nesta tela e ficam de fora).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigMvCab SET"
            loc_cSQL = loc_cSQL + " grupoos = "   + EscaparSQL(LEFT(THIS.this_cGrupoOrigem, 10)) + ","
            loc_cSQL = loc_cSQL + " contaos = "   + EscaparSQL(LEFT(THIS.this_cContaOrigem, 10)) + ","
            loc_cSQL = loc_cSQL + " grupods = "   + EscaparSQL(LEFT(THIS.this_cGrupoDestino, 10)) + ","
            loc_cSQL = loc_cSQL + " contads = "   + EscaparSQL(LEFT(THIS.this_cContaDestino, 10)) + ","
            loc_cSQL = loc_cSQL + " vends = "     + EscaparSQL(LEFT(THIS.this_cRepresentante, 10)) + ","
            loc_cSQL = loc_cSQL + " grvends = "   + EscaparSQL(LEFT(THIS.this_cGrupoRepresentante, 10)) + ","
            loc_cSQL = loc_cSQL + " tabds = "     + EscaparSQL(LEFT(THIS.this_cTabelaDesconto, 10)) + ","
            loc_cSQL = loc_cSQL + " pstatus = "   + EscaparSQL(LEFT(THIS.this_cStatus, 1)) + ","
            loc_cSQL = loc_cSQL + " nops = "      + FormatarNumeroSQL(THIS.this_nNumeroOP, 0) + ","
            loc_cSQL = loc_cSQL + " prazoents = " + FormatarDataSQL(THIS.this_dPrazoEntrega) + ","
            loc_cSQL = loc_cSQL + " notas = "     + EscaparSQL(LEFT(THIS.this_cDocumento, 6)) + ","
            loc_cSQL = loc_cSQL + " datas = "     + FormatarDataSQL(THIS.this_dData) + ","
            loc_cSQL = loc_cSQL + " obses = "     + EscaparSQL(THIS.this_cObservacao)
            loc_cSQL = loc_cSQL + " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChave)

            IF USED("cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

            IF loc_nResultado < 0
                MsgErro("Erro ao atualizar movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ENDIF

            IF USED("cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigpres2BO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir() e ExecutarExclusao() permanecem com o comportamento herdado
    * de BusinessBase (recusar a operacao): no fonte legado do SIGPRES2 nao
    * ha Append/Delete contra SigMvCab - o dialogo so edita um registro que
    * o form pai ja havia populado em csTemporario antes de abri-lo (ver
    * cabecalho do arquivo). Este BO nunca cria nem exclui movimentos.
    *--------------------------------------------------------------------------

    *--------------------------------------------------------------------------
    * CarregarItens - Carrega os itens do movimento (grid fwgrade1/xEestI do
    * legado) em cursor_4c_Itens. Fonte: SigMvItn (a) LEFT JOIN SigMvIts (b)
    * por EmpDopNums+Cpros+CItens (mesma juncao do PROCEDURE Init legado -
    * regra #42 CLAUDE.md, nunca ALLTRIM na chave posicional). Saldo =
    * Qtds - QtBaixas ja calculado no SELECT (equivalente ao
    * Column4.ControlSource legado 'xEestI.Qtds - xEestI.QtBaixas', ramo
    * Else de montagrades - o ramo If(gcTpInstalas='V') nao foi portado:
    * essa global de configuracao nao existe na nova arquitetura, e o ramo
    * Else e o que bate com os headers estaticos do SCX/layout.json).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarItens()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Itens")
                USE IN cursor_4c_Itens
            ENDIF

            loc_cSQL = "SELECT a.cpros, a.dpros, a.qtds, a.qtprods," + ;
                " a.qtbaixas, a.qtbxprods, a.citens, a.tpesos," + ;
                " a.descvals, ISNULL(b.codtams, '') AS codtams," + ;
                " a.obs, (a.qtds - a.qtbaixas) AS saldo" + ;
                " FROM sigmvitn a" + ;
                " LEFT JOIN sigmvits b ON b.empdopnums = a.empdopnums" + ;
                " AND b.cpros = a.cpros AND b.citens = a.citens" + ;
                " WHERE a.empdopnums = " + EscaparSQL(THIS.this_cChaveMovimento) + ;
                " ORDER BY a.citens"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Itens")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar itens do movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar itens:" + CHR(13) + loException.Message, "sigpres2BO.CarregarItens")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOperacoes - Carrega os codigos de operacao vinculados ao
    * movimento (grid GradeOperacao/TmpOperacao do legado). Fonte: SigMvPec
    * filtrado por EmpDopNums (mesmo filtro do legado
    * CursorQuery('SigMvPec', 'TmpOperacao', 'EmpDopNums', pEdn)).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarOperacoes()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Operacoes")
                USE IN cursor_4c_Operacoes
            ENDIF

            loc_cSQL = "SELECT DISTINCT codigos FROM sigmvpec" + ;
                " WHERE empdopnums = " + EscaparSQL(THIS.this_cChaveMovimento) + ;
                " ORDER BY codigos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacoes")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar opera" + CHR(231) + CHR(245) + "es do movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + loException.Message, "sigpres2BO.CarregarOperacoes")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
