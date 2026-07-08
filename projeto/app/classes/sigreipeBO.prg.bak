*==============================================================================
* SIGREIPEBO.PRG
* Business Object para Impressao de Etiquetas
* Tabela principal: SigMlCab (mala direta) / SigMvCab (operacoes)
*
* Herda de RelatorioBase
*==============================================================================

DEFINE CLASS sigreipeBO AS RelatorioBase

    *-- Propriedades padrao
    this_cTabela         = "SigMlCab"
    this_cCampoChave     = "cIdChaves"
    this_cCursorDados    = "Relacao"
    this_cMensagemErro   = ""

    *-- Filtro: selecao por codigo/descricao (tabela SigMlItn)
    this_cCodigos        = ""
    this_cDescs          = ""

    *-- Filtro: selecao por operacao de movimento
    this_cNmOperacao     = ""
    this_dDtInicial      = {}
    this_dDtFinal        = {}
    this_nConta          = 2

    *-- Configuracao do modelo de etiqueta
    *-- 1=3col DN, 2=2col, 3=9lin, 4=9x3, 5=A4355, 6=2ColMarg, 7=Termica, 8=Pimaco6181, 9=TermicaZ
    this_nColunas        = 2
    this_nQtdEtiq        = 1

    *-- Configuracao da ordenacao
    *-- this_nOrdem: 1=Alfabetica, 2=CEP, 3=Data Nasc.
    *-- this_nOrdemDir: 1=Ascendente, 2=Descendente
    this_nOrdem          = 2
    this_nOrdemDir       = 2

    *-- Opcoes de conteudo das etiquetas
    *-- 1=Sim, 2=Nao em todos os grupos abaixo
    this_nImpPais        = 2
    this_nImpCodigo      = 1
    this_nImpMaius       = 2
    this_nImpContatos    = 2

    *-- Impressora selecionada (carregada no Form a partir de SigCdmp/SigSyImp)
    this_nImpressora     = 1
    this_cNomeImpressora = ""

    *--------------------------------------------------------------------------
    * Init - Configura propriedades basicas do BO
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela      = "SigMlCab"
        THIS.this_cCampoChave  = "cIdChaves"
        THIS.this_cCursorDados = "Relacao"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Despacha para modo mala direta ou modo operacao
    * Modo mala direta: this_cCodigos preenchido -> SigMlCab+SigCdCli
    * Modo operacao:    this_cNmOperacao preenchido -> TmpOper via SigMvCab
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !EMPTY(THIS.this_cNmOperacao)
                loc_lSucesso = THIS.PrepararDadosOperacao()
            ELSE
                loc_lSucesso = THIS.PrepararDadosMalaDireta()
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDadosMalaDireta - Busca registros de SigMlCab filtrando por
    * codigo de itinerario (this_cCodigos) ou descricao (this_cDescs)
    * Replica logica do Init original do SIGREIPE
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDadosMalaDireta()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_cOrder, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            loc_cWhere = "a.Iclis = b.Iclis"
            IF !EMPTY(THIS.this_cCodigos)
                loc_cWhere = loc_cWhere + " AND a.Codigos = " + EscaparSQL(THIS.this_cCodigos)
            ENDIF

            loc_cOrder = "a.IClis, a.RClis, a.Endes, a.Nums, a.Compls," + ;
                         " a.Bairs, a.Cidas, a.Ceps, a.Estas," + ;
                         " a.Tel1s, a.Tel2s, a.Faxs, a.Nascs," + ;
                         " a.cIdChaves, a.Codigos, b.Contato"

            loc_cSQL = "SELECT a.IClis, a.RClis, a.Endes, a.Nums, a.Compls," + ;
                       " a.Bairs, a.Cidas, a.Ceps, a.Estas," + ;
                       " a.Tel1s, a.Tel2s, a.Faxs, a.Nascs," + ;
                       " a.cIdChaves, a.Codigos, b.paises, b.Contato" + ;
                       " FROM SigMlCab a, SigCdCli b" + ;
                       " WHERE " + loc_cWhere + ;
                       " ORDER BY " + loc_cOrder

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados da mala direta"
                loc_lSucesso = .F.
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro PrepararDadosMalaDireta")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDadosOperacao - Busca movimentos de SigMvCab filtrados por
    * operacao e periodo, populando cursor TmpOper com campos para etiqueta.
    * Replica logica do get_dt_final.Valid original.
    * this_nConta = 1 -> usa dados do cliente ORIGEM (ContaOs)
    * this_nConta = 2 -> usa dados do cliente DESTINO (ContaDs)
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDadosOperacao()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED("TmpOper")
                USE IN TmpOper
            ENDIF
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            loc_cWhere = "a.Dopes = " + EscaparSQL(THIS.this_cNmOperacao)
            IF !EMPTY(THIS.this_dDtInicial)
                loc_cWhere = loc_cWhere + " AND a.Datas >= " + FormatarDataSQL(THIS.this_dDtInicial)
            ENDIF
            IF !EMPTY(THIS.this_dDtFinal)
                loc_cWhere = loc_cWhere + " AND a.Datas <= " + FormatarDataSQL(THIS.this_dDtFinal)
            ENDIF

            IF THIS.this_nConta = 1
                *-- Origem: usa dados de b (SigCdCli ContaOs)
                loc_cSQL = "SELECT 0 AS Marcas, a.Emps, a.Dopes, a.Numes," + ;
                           " b.Rclis AS DescOrigs, c.Rclis AS DescDests," + ;
                           " a.ContaEs, a.LocalEnts," + ;
                           " b.IClis, b.RClis, b.Endes, b.Nums, b.Compls," + ;
                           " b.Bairs, b.Cidas, b.Ceps, b.Estas," + ;
                           " b.Tel1s, b.Tel2s, b.Faxs, b.Nascs," + ;
                           " '' AS cIdChaves, b.Codigos, b.paises, b.Contato" + ;
                           " FROM SigMvCab a" + ;
                           " INNER JOIN SigCdCli b ON a.ContaOs = b.Iclis" + ;
                           " INNER JOIN SigCdCli c ON a.ContaDs = c.Iclis" + ;
                           " WHERE " + loc_cWhere
            ELSE
                *-- Destino: usa dados de c (SigCdCli ContaDs)
                loc_cSQL = "SELECT 0 AS Marcas, a.Emps, a.Dopes, a.Numes," + ;
                           " b.Rclis AS DescOrigs, c.Rclis AS DescDests," + ;
                           " a.ContaEs, a.LocalEnts," + ;
                           " c.IClis, c.RClis, c.Endes, c.Nums, c.Compls," + ;
                           " c.Bairs, c.Cidas, c.Ceps, c.Estas," + ;
                           " c.Tel1s, c.Tel2s, c.Faxs, c.Nascs," + ;
                           " '' AS cIdChaves, c.Codigos, c.paises, c.Contato" + ;
                           " FROM SigMvCab a" + ;
                           " INNER JOIN SigCdCli b ON a.ContaOs = b.Iclis" + ;
                           " INNER JOIN SigCdCli c ON a.ContaDs = c.Iclis" + ;
                           " WHERE " + loc_cWhere
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpOper")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar operacoes"
                loc_lSucesso = .F.
            ENDIF

            *-- Replica cursor TmpOper para Relacao (formato unificado para impressao)
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF
            SELECT TmpOper
            IF !EOF()
                SELECT IClis, RClis, Endes, Nums, Compls, Bairs, Cidas, Ceps, Estas, ;
                       Tel1s, Tel2s, Faxs, Nascs, cIdChaves, Codigos, paises, Contato ;
                       FROM TmpOper WHERE Marcas = 1 ;
                       INTO CURSOR (THIS.this_cCursorDados) READWRITE
            ELSE
                *-- Cursor vazio com estrutura correta
                CREATE CURSOR (THIS.this_cCursorDados) ;
                    (IClis C(15), RClis C(60), Endes C(60), Nums C(10), Compls C(20), ;
                     Bairs C(40), Cidas C(40), Ceps C(9), Estas C(2), ;
                     Tel1s C(20), Tel2s C(20), Faxs C(20), Nascs D, ;
                     cIdChaves C(36), Codigos C(10), paises C(20), Contato C(40))
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro PrepararDadosOperacao")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDbImpressao - Transforma cursor Relacao em DbImpressao pronto
    * para LABEL FORM, adicionando colunas cpros/qtds/cbars e copiando Obs
    * Replica logica do metodo "processamento" original do SIGREIPE
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDbImpressao()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !USED(THIS.this_cCursorDados) OR RECCOUNT(THIS.this_cCursorDados) = 0
                THIS.this_cMensagemErro = "Nenhum registro para imprimir"
                loc_lSucesso = .F.
            ENDIF

            IF USED("DbImpressao")
                USE IN DbImpressao
            ENDIF

            SELECT *, '1' AS cpros, 1 AS qtds, 0 AS cbars, ;
                   SPACE(60) AS Obs ;
                   FROM (THIS.this_cCursorDados) ;
                   INTO CURSOR DbImpressao READWRITE

            SELECT DbImpressao
            GO TOP
            REPLACE ALL Obs WITH IClis

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro PrepararDbImpressao")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria (cIdChaves) do cursor atual
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ""
        TRY
            IF USED(THIS.this_cCursorDados) AND !EOF(THIS.this_cCursorDados)
                SELECT (THIS.this_cCursorDados)
                loc_cChave = ALLTRIM(NVL(cIdChaves, ""))
            ENDIF
        CATCH TO loc_oErro
            loc_cChave = ""
        ENDTRY
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores ao encerrar
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        IF USED("TmpOper")
            USE IN TmpOper
        ENDIF
        IF USED("DbImpressao")
            USE IN DbImpressao
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
