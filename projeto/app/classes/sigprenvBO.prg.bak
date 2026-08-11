*==============================================================================
* sigprenvBO.prg - Business Object para Impressao de Etiquetas de Envelopes
* Herda de: BusinessBase
* Form original: SIGPRENV.SCX
* Tipo: OPERACIONAL (sem entidade CRUD - impressao de etiquetas)
*==============================================================================
DEFINE CLASS sigprenvBO AS BusinessBase

    *-- Dados da sessao de impressao
    this_nEtqIni       = 0    && Etiqueta Inicial (Etq_Ini)
    this_nEtqQtd       = 0    && Quantidade de etiquetas (Etq_Qtd)

    *-- Tipo de etiqueta selecionado (Opt_Tipo)
    this_nTipoEtq      = 6    && nTipos do SigCdTpe (6 = Envelope)
    this_cDescTipoEtq  = ""   && cEtiquetas do SigCdTpe

    *-- Impressora selecionada (Opt_Impressora)
    this_cNomeImpressora = ""  && Tag do botao = nome da impressora (UPPER)
    this_nTpImpressora   = 0   && nTpImpres do SigCdMp

    *-- Opcao de protocolo de impressao (Opcao_Imp: 1=Allegro, 2=Zebra ZPL, 3=Zebra EPL)
    this_nOpcaoImp     = 1

    *-- Ajustes de impressao (de SigCdPam e SigCdPac)
    this_nAjVerts      = 0
    this_nAjHorzs      = 0
    this_nAjDenss      = 10
    this_nAjVelos      = 1

    *-- Parametros gerais carregados de SigCdPam
    this_nMaxTpEtis    = 5    && nMaxTpEtis - maximo de tipos de etiqueta exibidos
    this_nMaxImpEti    = 5    && nMaxImpEti - maximo de impressoras exibidas
    this_nImpEtis      = 1    && ImpEtis - impressora padrao
    this_cTpCBars      = ""   && TpCBars - tipo codigo de barras

    *-- Campos da etiqueta individual (cursor_4c_Impressao)
    this_cCpros        = ""   && Codigo da etiqueta (Cpros)
    this_cDPros        = ""   && Descricao do produto (DPros)
    this_nQtds         = 0    && Quantidade (Qtds)
    this_nQtdeEtiq     = 0    && Quantidade de etiquetas (QtdeEtiq)
    this_cPedido       = ""   && Numero do pedido (Pedido)
    this_cObs          = ""   && Observacao (Obs)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        this_cTabela     = ""
        this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametros - Carrega SigCdPam e SigCdPac (ajustes e parametros)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametros()
        LOCAL loc_cSQL, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT nMaxTpEtis, TpEtiPads, nMaxImpEti, ImpEtis, " + ;
                       "AjVerts, AjHorzs, TpCBars FROM SigCdPam"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam") > 0
                IF USED("cursor_4c_Pam") AND !EOF("cursor_4c_Pam")
                    SELECT cursor_4c_Pam
                    GO TOP
                    this_nMaxTpEtis = NVL(nMaxTpEtis, 5)
                    this_nMaxImpEti = NVL(nMaxImpEti, 5)
                    this_nImpEtis   = NVL(ImpEtis, 1)
                    this_nAjVerts   = NVL(AjVerts, 0)
                    this_nAjHorzs   = NVL(AjHorzs, 0)
                    this_cTpCBars   = ALLTRIM(NVL(TpCBars, ""))
                ENDIF
                IF USED("cursor_4c_Pam")
                    USE IN cursor_4c_Pam
                ENDIF
            ENDIF

            loc_cSQL = "SELECT AjDens, AjVelos FROM SigCdPac"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pac") > 0
                IF USED("cursor_4c_Pac") AND !EOF("cursor_4c_Pac")
                    SELECT cursor_4c_Pac
                    GO TOP
                    this_nAjDenss = IIF(NVL(AjDens, 0) < 10, 10, NVL(AjDens, 0))
                    this_nAjVelos = IIF(EMPTY(NVL(AjVelos, 0)), 1, NVL(AjVelos, 0))
                ENDIF
                IF USED("cursor_4c_Pac")
                    USE IN cursor_4c_Pac
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarTiposEtiqueta - Carrega tipos de etiqueta de SigCdTpe (nTipos=6)
    * Retorna: numero de tipos encontrados
    *--------------------------------------------------------------------------
    PROCEDURE CarregarTiposEtiqueta()
        LOCAL loc_cSQL, loc_nTipos, loc_oErro
        loc_nTipos = 0

        TRY
            IF USED("cursor_4c_Tpe")
                USE IN cursor_4c_Tpe
            ENDIF

            loc_cSQL = "SELECT cOrdems, cEtiquetas, nTipos, nSituas " + ;
                       "FROM SigCdTpe " + ;
                       "WHERE nSituas = 1 AND nTipos = 6 " + ;
                       "ORDER BY cOrdems"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Tpe") > 0
                IF USED("cursor_4c_Tpe")
                    SELECT cursor_4c_Tpe
                    GO TOP
                    loc_nTipos = RECCOUNT("cursor_4c_Tpe")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_nTipos
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarImpressoras - Carrega impressoras autorizadas do usuario em SigCdMp
    * par_cUsuario: codigo do usuario logado
    * Retorna: numero de impressoras encontradas
    *--------------------------------------------------------------------------
    PROCEDURE CarregarImpressoras(par_cUsuario)
        LOCAL loc_cSQL, loc_nImpres, loc_oErro
        loc_nImpres = 0

        TRY
            IF USED("cursor_4c_Imp")
                USE IN cursor_4c_Imp
            ENDIF
            IF USED("cursor_4c_ImpTemp")
                USE IN cursor_4c_ImpTemp
            ENDIF

            loc_cSQL = "SELECT mp1.Impres, mp1.nTpImpres FROM SigSyImp sy1 " + ;
                       "INNER JOIN SigCdMp mp1 ON sy1.cimps = mp1.Impres " + ;
                       "WHERE sy1.UsuAcess = " + EscaparSQL(par_cUsuario) + " " + ;
                       "UNION ALL " + ;
                       "SELECT mp2.Impres, mp2.nTpImpres FROM SigCdAcG acg " + ;
                       "INNER JOIN SigSyImp sy2 ON acg.Grupos = sy2.GrAcess " + ;
                       "INNER JOIN SigCdMp mp2 ON sy2.Cimps = mp2.Impres " + ;
                       "WHERE acg.Usuarios = " + EscaparSQL(par_cUsuario)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImpTemp") > 0
                IF USED("cursor_4c_ImpTemp") AND RECCOUNT("cursor_4c_ImpTemp") > 0
                    SELECT DISTINCT Impres, nTpImpres FROM cursor_4c_ImpTemp ;
                        INTO CURSOR cursor_4c_Imp READWRITE
                ELSE
                    loc_cSQL = "SELECT Impres, nTpImpres FROM SigCdMp"
                    SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Imp")
                ENDIF

                IF USED("cursor_4c_ImpTemp")
                    USE IN cursor_4c_ImpTemp
                ENDIF

                IF USED("cursor_4c_Imp")
                    SELECT cursor_4c_Imp
                    GO TOP
                    loc_nImpres = RECCOUNT("cursor_4c_Imp")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_nImpres
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararImpressao - Monta o cursor de itens a imprimir (dbImpressao)
    * par_nEtqIni: numero da etiqueta inicial
    * par_nEtqQtd: quantidade de etiquetas
    *--------------------------------------------------------------------------
    PROCEDURE PrepararImpressao(par_nEtqIni, par_nEtqQtd)
        LOCAL loc_nI, loc_cCpros, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Impressao")
                SELECT cursor_4c_Impressao
                ZAP
            ELSE
                SET NULL ON
                CREATE CURSOR cursor_4c_Impressao ;
                    (Cpros C(10) NULL, DPros C(40) NULL, Qtds N(10,3) NULL, ;
                     QtdeEtiq N(10,3) NULL, Pedido C(30) NULL, Obs C(10) NULL)
                SET NULL OFF
                INDEX ON Cpros TAG Cpros
                SET ORDER TO
            ENDIF

            FOR loc_nI = par_nEtqIni TO par_nEtqIni + (par_nEtqQtd - 1)
                loc_cCpros = PADL(ALLTRIM(STR(loc_nI, 8)), 8, "0")
                INSERT INTO cursor_4c_Impressao ;
                    (Cpros, Qtds, Pedido, QtdeEtiq) ;
                    VALUES (loc_cCpros, 1, "", 1)
            ENDFOR

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparImpressao - Limpa o cursor de impressao apos concluir
    *--------------------------------------------------------------------------
    PROCEDURE LimparImpressao()
        IF USED("cursor_4c_Impressao")
            SELECT cursor_4c_Impressao
            ZAP
            APPEND BLANK
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarCursorImpressao - Cria cursor vazio de impressao no Init do form
    *--------------------------------------------------------------------------
    PROCEDURE InicializarCursorImpressao()
        IF USED("cursor_4c_Impressao")
            USE IN cursor_4c_Impressao
        ENDIF

        SET NULL ON
        CREATE CURSOR cursor_4c_Impressao ;
            (Cpros C(10) NULL, DPros C(40) NULL, Qtds N(10,3) NULL, ;
             QtdeEtiq N(10,3) NULL, Pedido C(30) NULL, Obs C(10) NULL)
        SET NULL OFF
        INDEX ON Cpros TAG Cpros
        SET ORDER TO
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de cursor_4c_Impressao
    * par_cAliasCursor: alias do cursor origem
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            this_cCpros    = ALLTRIM(NVL(Cpros,    ""))
            this_cDPros    = ALLTRIM(NVL(DPros,    ""))
            this_nQtds     = NVL(Qtds,    0)
            this_nQtdeEtiq = NVL(QtdeEtiq, 0)
            this_cPedido   = ALLTRIM(NVL(Pedido,  ""))
            this_cObs      = ALLTRIM(NVL(Obs,     ""))
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave primaria da etiqueta corrente
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN this_cCpros
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Insere etiqueta no cursor_4c_Impressao local
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_Impressao")
                THIS.InicializarCursorImpressao()
            ENDIF

            SELECT cursor_4c_Impressao
            INSERT INTO cursor_4c_Impressao ;
                (Cpros, DPros, Qtds, QtdeEtiq, Pedido, Obs) ;
                VALUES (this_cCpros, this_cDPros, this_nQtds, ;
                        this_nQtdeEtiq, this_cPedido, this_cObs)

            THIS.RegistrarAuditoria("INSERIR")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza etiqueta existente no cursor_4c_Impressao
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Impressao")
                SELECT cursor_4c_Impressao
                SET ORDER TO TAG Cpros
                IF SEEK(this_cCpros, "cursor_4c_Impressao", "Cpros")
                    REPLACE Qtds     WITH this_nQtds, ;
                            QtdeEtiq WITH this_nQtdeEtiq, ;
                            DPros    WITH this_cDPros, ;
                            Pedido   WITH this_cPedido, ;
                            Obs      WITH this_cObs
                    THIS.RegistrarAuditoria("ATUALIZAR")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao de impressao em LogAuditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_oErro

        TRY
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL("SigOpEtq") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(this_cCpros) + ", " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       "GETDATE())"
            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            *-- Falha de auditoria nao interrompe a operacao principal
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores ao encerrar
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Tpe")
            USE IN cursor_4c_Tpe
        ENDIF
        IF USED("cursor_4c_Imp")
            USE IN cursor_4c_Imp
        ENDIF
        IF USED("cursor_4c_ImpTemp")
            USE IN cursor_4c_ImpTemp
        ENDIF
        IF USED("cursor_4c_Impressao")
            USE IN cursor_4c_Impressao
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
