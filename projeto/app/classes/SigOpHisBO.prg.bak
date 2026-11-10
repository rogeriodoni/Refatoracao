*==============================================================================
* SigOpHisBO.prg
*
* Business Object para SigOpHis (Historico de Produtos - tela de filtro)
*
* Este form NAO persiste dados em tabela propria - e um dialogo OPERACIONAL
* que recebe Grupo/Conta (contabeis), Produto e um periodo (Data Inicial/
* Data Final), valida os quatro campos e repassa os parametros para o form
* de historico (legado: "Do Form SigPrHpr With ThisForm"; no sistema novo,
* FormSigPrHpr - ja migrado - que le os mesmos nomes de PRIVATE pcCdGrupo/
* pcCdConta/pcCdProduto/pcDsProduto/pdDataIni/pdDataFin no proprio Init).
*
* Tabela: (nenhuma - dialogo parametrizado, sem persistencia propria)
*
* Inserir(), Atualizar() e ExecutarExclusao() permanecem SEM override - o
* comportamento padrao herdado de BusinessBase ja eh o correto para este BO,
* porque nao ha NENHUMA tabela proprietaria para gravar (regra CLAUDE.md
* "BO somente-leitura"). ObterChavePrimaria() tambem nao se aplica.
*
* Fase 2/8 - CarregarDoCursor() + validacoes equivalentes ao ChkRegister()
* legado (regra CLAUDE.md "ChkRegister NAO EXISTE em BusinessBase - usar
* SQLEXEC com SELECT COUNT(*)"). A validacao de Grupo (fAcessoContab) e de
* Conta (fAcessoContas) continua no FORM, igual ao legado - as duas funcoes
* globais ja estao portadas em utils\functions.prg e recebem os proprios
* TextBox do form para auto-preencher a descricao (ver SIGOPHIS.Get_grupo.
* Valid / SIGOPHIS.Get_est.Valid no dump); a BO nao duplica essa logica.
*==============================================================================

DEFINE CLASS SigOpHisBO AS BusinessBase

    *-- Propriedades da entidade (espelham os campos do form legado
    *-- SIGOPHIS: Get_grupo/Get_Dgrupo/Get_est/Get_dest/Get_cod/Get_dcod/
    *-- Get_DataIni/Get_DataFin)
    this_cGrupo   = SPACE(10)   && Get_grupo.Value  - Codigo do Grupo Contabil
    this_cDGrupo  = ""          && Get_Dgrupo.Value - Descricao do Grupo Contabil
    this_cConta   = SPACE(10)   && Get_est.Value    - Codigo da Conta
    this_cDConta  = ""          && Get_dest.Value   - Descricao da Conta
    this_cProduto = SPACE(14)   && Get_cod.Value    - Codigo do Produto (SigCdPro.cpros)
    this_cDProduto = ""         && Get_dcod.Value   - Descricao do Produto (SigCdPro.dpros)
    this_dDataIni = {}          && Get_DataIni.Value - Data Inicial do periodo
    this_dDataFin = {}          && Get_DataFin.Value - Data Final do periodo

    *-- Nome do controle que deve receber o foco quando ValidarFiltro()
    *-- falhar (replica o ThisForm.get_xxx.SetFocus do consulta.Click
    *-- legado). Valores possiveis: "Grupo", "Conta", "Produto",
    *-- "DataIni", "DataFin" ou "" (nenhuma falha / ainda nao validado).
    this_cCampoFoco = ""

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()

        *-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
        *-- Dialogo parametrizado: nao ha tabela nem campo chave proprios
        THIS.this_cTabela = ""
        THIS.this_cCampoChave = ""

        THIS.this_cGrupo = SPACE(10)
        THIS.this_cDGrupo = ""
        THIS.this_cConta = SPACE(10)
        THIS.this_cDConta = ""
        THIS.this_cProduto = SPACE(14)
        THIS.this_cDProduto = ""
        THIS.this_dDataIni = DATE()
        THIS.this_dDataFin = DATE()
        THIS.this_cCampoFoco = ""

        RETURN .T.
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Sobrescreve BusinessBase.CarregarDoCursor()
    *
    * Este dialogo nao tem cursor de lista/detalhe proprio (nao ha tabela
    * SigOpHis), mas o campo Produto usa o padrao FormBuscaAuxiliar (regra
    * CLAUDE.md #36/#37) no lugar do legado "CreateObject('fwBuscaExt',
    * ...,'SigCdPro','CrProds','cpros',...)" (ver SIGOPHIS.Get_cod.Valid /
    * SIGOPHIS.Get_dcod.Valid no dump). Quando o Form (Fase 5/6) abrir o
    * picker e o usuario selecionar um registro, o cursor resultante tera
    * as colunas cpros/dpros (mAddColuna do legado) - este metodo e quem
    * traz esse par para as propriedades this_cProduto/this_cDProduto.
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            IF !EOF()
                THIS.this_cProduto  = TratarNulo(cpros, "C")
                THIS.this_cDProduto = TratarNulo(dpros, "C")
                loc_lSucesso = .T.
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * VerificarContaExistente - Substitui o ChkRegister('SigCdCli','iclis',
    * pcCdConta) do legado (consulta.Click). PROTECTED: uso interno de
    * ValidarFiltro(), nunca chamado de fora (regra CLAUDE.md #51).
    *====================================================================
    PROTECTED PROCEDURE VerificarContaExistente(par_cConta)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste

        loc_lExiste = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_ChkConta")
                USE IN cursor_4c_ChkConta
            ENDIF

            loc_cSQL = "SELECT COUNT(*) AS nExiste" + ;
                       " FROM SigCdCli" + ;
                       " WHERE iclis = " + EscaparSQL(ALLTRIM(par_cConta))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkConta")

            IF loc_nResultado > 0
                loc_lExiste = (NVL(cursor_4c_ChkConta.nExiste, 0) > 0)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao verificar Conta")
        ENDTRY

        IF USED("cursor_4c_ChkConta")
            USE IN cursor_4c_ChkConta
        ENDIF

        RETURN loc_lExiste
    ENDPROC

    *====================================================================
    * VerificarProdutoExistente - Substitui o ChkRegister('SigCdPro',
    * 'cpros', pcCdProduto) do legado (consulta.Click). PROTECTED: uso
    * interno de ValidarFiltro(), nunca chamado de fora (regra #51).
    *====================================================================
    PROTECTED PROCEDURE VerificarProdutoExistente(par_cProduto)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste

        loc_lExiste = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_ChkProduto")
                USE IN cursor_4c_ChkProduto
            ENDIF

            loc_cSQL = "SELECT COUNT(*) AS nExiste" + ;
                       " FROM SigCdPro" + ;
                       " WHERE cpros = " + EscaparSQL(ALLTRIM(par_cProduto))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkProduto")

            IF loc_nResultado > 0
                loc_lExiste = (NVL(cursor_4c_ChkProduto.nExiste, 0) > 0)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao verificar Produto")
        ENDTRY

        IF USED("cursor_4c_ChkProduto")
            USE IN cursor_4c_ChkProduto
        ENDIF

        RETURN loc_lExiste
    ENDPROC

    *====================================================================
    * ValidarFiltro - Transcricao literal (regra CLAUDE.md #17) da
    * sequencia de "Consiste o Campo..." do SIGOPHIS.sair.consulta.Click
    * legado, na MESMA ordem e com as MESMAS mensagens (so com CHR() no
    * lugar do acento literal - regra #4). Quem chama fica responsavel
    * por exibir THIS.this_cMensagemErro (MsgErro) e dar SetFocus no
    * controle indicado por THIS.this_cCampoFoco - igual ao
    * ThisForm.get_xxx.SetFocus de cada bloco do legado.
    *====================================================================
    PROCEDURE ValidarFiltro()
        LOCAL loc_lValido
        loc_lValido = .T.

        THIS.this_cMensagemErro = ""
        THIS.this_cCampoFoco = ""

        IF EMPTY(ALLTRIM(THIS.this_cGrupo))
            THIS.this_cMensagemErro = "Grupo Inv" + CHR(225) + "lido !"
            THIS.this_cCampoFoco = "Grupo"
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND (EMPTY(ALLTRIM(THIS.this_cConta)) OR !THIS.VerificarContaExistente(THIS.this_cConta))
            THIS.this_cMensagemErro = "Conta Inv" + CHR(225) + "lida !"
            THIS.this_cCampoFoco = "Conta"
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND (EMPTY(ALLTRIM(THIS.this_cProduto)) OR !THIS.VerificarProdutoExistente(THIS.this_cProduto))
            THIS.this_cMensagemErro = "Produto Inv" + CHR(225) + "lido !"
            THIS.this_cCampoFoco = "Produto"
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_dDataIni)
            THIS.this_cMensagemErro = "Data Inicial Inv" + CHR(225) + "lida !"
            THIS.this_cCampoFoco = "DataIni"
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_dDataFin)
            THIS.this_cMensagemErro = "Data Final Inv" + CHR(225) + "lida !"
            THIS.this_cCampoFoco = "DataFin"
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_dDataIni > THIS.this_dDataFin
            THIS.this_cMensagemErro = "Data Inicial maior que Data Final !"
            THIS.this_cCampoFoco = "DataIni"
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

ENDDEFINE
