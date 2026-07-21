*==============================================================================
* SigPrInsBO.prg - Business Object: Informacoes do Servico
* Herda de: BusinessBase
* Tipo: OPERACIONAL (dialog modal - recebe ParentForm, devolve valores)
* Tabela relacionada: SigCdPro (lookup de descricao do servico)
*==============================================================================

DEFINE CLASS SigPrInsBO AS BusinessBase

    *-- Codigo do servico (SigCdPro.cPros)
    this_cCodServs  = ""

    *-- Descricao do servico (SigCdPro.dPros)
    this_cDescServs = ""

    *-- Valor do servico
    this_nVlServs   = 0

    *-- Mensagem de erro para o Form consultar apos Inserir/Atualizar
    this_cMensagemErro = ""

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "cPros"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodServs
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    * par_cAliasCursor: alias do cursor com campos cCodServs, nVlServs
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor AS String) AS Logical
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            TRY
                SELECT (par_cAliasCursor)

                THIS.this_cCodServs  = NVL(cCodServs, "")
                THIS.this_nVlServs   = NVL(nVlServs,  0)

                IF !EMPTY(THIS.this_cCodServs)
                    THIS.this_cDescServs = THIS.BuscarDescricaoServico(THIS.this_cCodServs)
                ELSE
                    THIS.this_cDescServs = ""
                ENDIF

                loc_lSucesso = .T.

            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Erro")
            ENDTRY
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarDescricaoServico - Busca descricao do servico em SigCdPro
    *--------------------------------------------------------------------------
    FUNCTION BuscarDescricaoServico(par_cCodServs AS String) AS String
        LOCAL loc_cDescricao, loc_cSQL, loc_oErro

        loc_cDescricao = ""

        TRY
            loc_cSQL = "SELECT dPros" + ;
                       " FROM SigCdPro" + ;
                       " WHERE cPros = " + EscaparSQL(ALLTRIM(par_cCodServs))

            IF USED("cursor_4c_ProServico")
                USE IN cursor_4c_ProServico
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProServico") > 0
                IF !EOF("cursor_4c_ProServico")
                    loc_cDescricao = NVL(cursor_4c_ProServico.dPros, "")
                ENDIF
                USE IN cursor_4c_ProServico
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_cDescricao
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarDados() AS Logical
        IF EMPTY(THIS.this_cCodServs)
            THIS.this_cMensagemErro = "O c" + CHR(243) + "digo do servi" + CHR(231) + "o deve ser informado!"
            MsgAviso(THIS.this_cMensagemErro, "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF THIS.this_nVlServs <= 0
            THIS.this_cMensagemErro = "O valor do servi" + CHR(231) + "o deve ser informado!"
            MsgAviso(THIS.this_cMensagemErro, "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        THIS.this_cMensagemErro = ""
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Confirmacao da entrada do servico (dialog OPERACIONAL modal)
    * Semantica: NAO ha tabela persistente para INSERT SQL. Esta dialog captura
    * cCodServ + nVlServ para devolver ao ParentForm que fara a persistencia
    * efetiva na tabela de itens (ex: linha de servico de um pedido/OT).
    * Aqui apenas: valida dados, resolve descricao do servico, registra
    * auditoria da operacao e retorna sucesso para o Form fechar o dialog.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir() AS Logical
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF !THIS.ValidarDados()
                loc_lSucesso = .F.
            ENDIF

            IF EMPTY(THIS.this_cDescServs)
                THIS.this_cDescServs = THIS.BuscarDescricaoServico(THIS.this_cCodServs)
            ENDIF

            IF EMPTY(THIS.this_cDescServs)
                THIS.this_cMensagemErro = "Servi" + CHR(231) + "o n" + CHR(227) + "o encontrado no cat" + CHR(225) + "logo!"
                MsgAviso(THIS.this_cMensagemErro, "Valida" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            THIS.RegistrarAuditoria("INSERIR")

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao confirmar servi" + CHR(231) + "o: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Re-confirmacao da entrada do servico (dialog OPERACIONAL modal)
    * Semantica: no fluxo do SIGPRINS original, o dialog eh usado tanto para
    * incluir uma nova linha de servico quanto para alterar uma linha existente
    * do ParentForm (que decide o modo via LocalSacOp). Nesta camada, Atualizar
    * reexecuta a mesma validacao e resolucao de descricao usadas em Inserir
    * e registra auditoria da operacao de alteracao.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar() AS Logical
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF !THIS.ValidarDados()
                loc_lSucesso = .F.
            ENDIF

            THIS.this_cDescServs = THIS.BuscarDescricaoServico(THIS.this_cCodServs)

            IF EMPTY(THIS.this_cDescServs)
                THIS.this_cMensagemErro = "Servi" + CHR(231) + "o n" + CHR(227) + "o encontrado no cat" + CHR(225) + "logo!"
                MsgAviso(THIS.this_cMensagemErro, "Valida" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            THIS.RegistrarAuditoria("ATUALIZAR")

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao atualizar servi" + CHR(231) + "o: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao no log de auditoria (LogAuditoria)
    * Sobrescreve o padrao de BusinessBase para gravar chave descritiva da
    * operacao (codigo do servico + valor) em vez de PK de tabela inexistente.
    * DataHora usa GETDATE() (SQL Server) - regra Erro35.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cQuery, loc_cUsuario, loc_cChave, loc_oErro

        TRY
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")

            loc_cChave = "Servico: " + ALLTRIM(THIS.this_cCodServs) + ;
                         " | Valor: " + TRANSFORM(THIS.this_nVlServs, "@$ 999,999,999.99")

            loc_cQuery = "INSERT INTO LogAuditoria (Tabela, ChaveRegistro, Operacao, Usuario, DataHora) " + ;
                         "VALUES (" + ;
                         EscaparSQL("SigPrIns") + ", " + ;
                         EscaparSQL(LEFT(loc_cChave, 100)) + ", " + ;
                         EscaparSQL(par_cOperacao) + ", " + ;
                         EscaparSQL(loc_cUsuario) + ", " + ;
                         "GETDATE())"

            SQLEXEC(gnConnHandle, loc_cQuery)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro Auditoria")
        ENDTRY
    ENDPROC

ENDDEFINE
