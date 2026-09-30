*------------------------------------------------------------------------------
* SigPrEs1BO.prg - Business Object para Posicao Por Movimentacao
* Form legado: SIGPRES1 (form OPERACIONAL - filtro de relatorio, sem tabela CRUD)
* Herdado de: BusinessBase
*
* O legado nao grava em tabela alguma: monta filtros e consulta SigMvCab +
* SigCdOpe para alimentar a tela filha (sigpres2). Conferido no dump
* tasks\task606\SigPrEs1_form_codigo_fonte.txt: nenhum TABLEUPDATE(), nenhum
* .AddCursor(), e o unico comando de escrita eh
*   Update csTemporario Set PrazoEnts = Iif(IsNull(PrazoEnts), Ctod(''), ...)
* cujo alvo csTemporario eh o CURSOR LOCAL criado por
* poDataMgr.SqlExecute(lcQuery, 'csTemporario') - ou seja, ajuste em memoria
* que nunca volta para o banco.
*
* Por isso este BO deixa Inserir(), Atualizar() e ExecutarExclusao() HERDADOS
* de BusinessBase: a base ja recusa a operacao e reporta pelo ExibirFalha() do
* Salvar(), que eh o comportamento correto aqui. Sobrescrever esses metodos
* exigiria INVENTAR um INSERT/UPDATE, o que a regra #22 do CLAUDE.md proibe
* (a lista de colunas vem do schema, nunca de adivinhacao).
*
* O metodo de negocio real eh BuscarMovimentacao(), equivalente ao
* consulta.Click do SCX original. CarregarDoCursor() le a linha corrente do
* cursor de resultado e ObterChavePrimaria() devolve a chave EmpDopNums dessa
* linha (usada pela auditoria de BusinessBase e pelo handoff para a tela
* filha).
*------------------------------------------------------------------------------
DEFINE CLASS SigPrEs1BO AS BusinessBase

    *-- Configuracao da entidade (form OPERACIONAL - nao ha tabela unica/CRUD)
    this_cTabela     = "SigMvCab"
    this_cCampoChave = ""

    *-- Filtro: Movimentacao / Periodo
    this_cNomeOperacao = ""
    this_dDataInicial  = {}
    this_dDataFinal    = {}
    this_nNumero       = 0
    this_nOperacao     = 0
    this_cStatus       = ""

    *-- Filtro: Grupo / Conta
    this_cGrupo            = ""
    this_cDescricaoGrupo   = ""
    this_cConta            = ""
    this_cDescricaoConta   = ""
    this_cCpfCnpj          = ""

    *-- Filtro: Moeda
    this_cCodigoMoeda    = ""
    this_cDescricaoMoeda = ""

    *-- Filtro: Responsavel
    this_cResponsavel          = ""
    this_cDescricaoResponsavel = ""

    *-- Filtro: Empresa
    this_cCodigoEmpresa    = ""
    this_cDescricaoEmpresa = ""
    this_lEmpresaDestino   = .F.

    *-- Opcoes (OptionGroups do filtro) - valores DEFAULT identicos ao SCX legado
    this_nOpcaoPeriodo    = 1
    this_nOpcaoPendente   = 3
    this_nOpcaoImpressao  = 1
    this_nOpcaoCotacao    = 1

    *-- Parametros do sistema (equivalente ao cursor LocalParam do legado)
    this_cGrupoPadraoResponsavel = ""

    *-- Resultado da consulta (equivalente ao cursor csTemporario do legado)
    this_cCursorResultado = "cursor_4c_Movimentacao"
    this_nTotalRegistros  = 0

    *-- Linha corrente do cursor de resultado, lida por CarregarDoCursor().
    *-- Sao EXATAMENTE as colunas de SigMvCab que o legado nomeia no lcWhere /
    *-- lcQuery do consulta.Click, mais a chave empdopnums usada no Index On -
    *-- nenhuma coluna a mais. Conferidas uma a uma em docs\schema.sql:
    *--   emps char(3)        empds char(3)       dopes char(20)
    *--   datas datetime      prazoents datetime  grupoos char(10)
    *--   grupods char(10)    contaos char(10)    contads char(10)
    *--   nops numeric(10,0)  numes numeric(6,0)  vends char(10)
    *--   chksubn bit         pstatus char(1)     empdopnums char(29)
    this_cRegEmpresa       = ""
    this_cRegEmpresaDest   = ""
    this_cRegOperacao      = ""
    *-- {/:} eh DATETIME vazio (VARTYPE "T"): as colunas datas/prazoents sao
    *-- datetime, e manter o tipo estavel antes e depois da carga evita o erro
    *-- 11 de TTOD() com DATE (regra #16 do CLAUDE.md).
    this_dRegData          = {/:}
    this_dRegPrazoEntrega  = {/:}
    this_cRegGrupoOrigem   = ""
    this_cRegGrupoDestino  = ""
    this_cRegContaOrigem   = ""
    this_cRegContaDestino  = ""
    this_nRegNumeroOp      = 0
    this_nRegNumero        = 0
    this_cRegVendedor      = ""
    this_lRegBaixada       = .F.
    this_cRegStatus        = ""
    this_cRegChave         = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro

        TRY
            loc_lSucesso = DODEFAULT()

            THIS.this_cTabela     = "SigMvCab"
            THIS.this_cCampoChave = ""

            THIS.this_cNomeOperacao = ""
            THIS.this_dDataInicial  = DATE()
            THIS.this_dDataFinal    = DATE()
            THIS.this_nNumero       = 0
            THIS.this_nOperacao     = 0
            THIS.this_cStatus       = ""

            THIS.this_cGrupo          = ""
            THIS.this_cDescricaoGrupo = ""
            THIS.this_cConta          = ""
            THIS.this_cDescricaoConta = ""
            THIS.this_cCpfCnpj        = ""

            THIS.this_cCodigoMoeda    = ""
            THIS.this_cDescricaoMoeda = ""

            THIS.this_cResponsavel          = ""
            THIS.this_cDescricaoResponsavel = ""

            *-- Legado: .get_cd_empresa.Value = _empr
            *-- _EMPR eh variavel do Framework antigo; a fonte canonica no
            *-- sistema novo eh go_4c_Sistema.cCodEmpresa (config.prg).
            THIS.this_cCodigoEmpresa = ""
            IF TYPE("go_4c_Sistema") = "O"
                THIS.this_cCodigoEmpresa = ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))
            ENDIF
            THIS.this_cDescricaoEmpresa = ""
            THIS.this_lEmpresaDestino   = .F.

            THIS.this_nOpcaoPeriodo   = 1
            THIS.this_nOpcaoPendente  = 3
            THIS.this_nOpcaoImpressao = 1
            THIS.this_nOpcaoCotacao   = 1

            THIS.this_cGrupoPadraoResponsavel = ""
            THIS.this_cCursorResultado        = "cursor_4c_Movimentacao"
            THIS.this_nTotalRegistros         = 0

            THIS.LimparLinhaCorrente()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        IF loc_lSucesso
            *-- Equivalente ao SqlExecute("Select GrPadVens From SigCdPam...", "LocalParam")
            *-- do Init legado - usado pela validacao de acesso do Responsavel.
            THIS.CarregarParametrosSistema()
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametrosSistema - Carrega parametros globais de SigCdPam
    * Equivalente ao cursor LocalParam populado no Init do form legado:
    *   Select GrPadVens From SigCdPam Where Not cIdChaves = fUniqueIds()
    * (a comparacao com um id recem-gerado nunca casa, entao devolve a linha
    * unica de parametros da empresa - transcrito literalmente do legado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarParametrosSistema()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_cSQL = "SELECT GrPadVens FROM SigCdPam WHERE NOT cidchaves = " + ;
                    EscaparSQL(fUniqueIds())

                IF USED("cursor_4c_SigPrEs1Pam")
                    USE IN cursor_4c_SigPrEs1Pam
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigPrEs1Pam")

                IF loc_nResultado > 0 AND USED("cursor_4c_SigPrEs1Pam")
                    SELECT cursor_4c_SigPrEs1Pam
                    GO TOP
                    IF !EOF()
                        THIS.this_cGrupoPadraoResponsavel = ALLTRIM(TratarNulo(GrPadVens, ""))
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL()
                ENDIF

                IF USED("cursor_4c_SigPrEs1Pam")
                    USE IN cursor_4c_SigPrEs1Pam
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Reproduz as validacoes do consulta.Click do legado antes
    * de disparar a consulta: Empresa, Operacao (Movimentacao) e Periodo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarFiltros()
        LOCAL loc_lValido

        loc_lValido = .T.
        THIS.this_cMensagemErro = ""

        IF EMPTY(ALLTRIM(THIS.this_cCodigoEmpresa))
            THIS.this_cMensagemErro = "Empresa Inv" + CHR(225) + "lida!!!"
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cNomeOperacao))
            THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!"
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_dDataFinal < THIS.this_dDataInicial
            THIS.this_cMensagemErro = "Per" + CHR(237) + "odo Inv" + CHR(225) + "lido!!! Data Final Menor do Que a Inicial!!!"
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarWhereConsulta - Monta o trecho de filtros da consulta, transcrito
    * literalmente da variavel lcWhere do metodo consulta.Click do legado.
    * Cada filtro so entra na clausula quando o campo correspondente esta
    * preenchido, exatamente como no SCX original.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarWhereConsulta()
        LOCAL loc_cWhere

        loc_cWhere = ""

        IF !EMPTY(ALLTRIM(THIS.this_cNomeOperacao))
            loc_cWhere = loc_cWhere + "a.Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cNomeOperacao)) + " And "
        ENDIF

        IF THIS.this_nOpcaoPeriodo = 1
            loc_cWhere = loc_cWhere + "a.Datas BetWeen " + ;
                FormatarDataSQL(fDtoSQL(THIS.this_dDataInicial)) + " And " + ;
                FormatarDataSQL(fDtoSQL(THIS.this_dDataFinal, "23:59:59")) + " And "
        ELSE
            loc_cWhere = loc_cWhere + "a.PrazoEnts BetWeen " + ;
                FormatarDataSQL(fDtoSQL(THIS.this_dDataInicial)) + " And " + ;
                FormatarDataSQL(fDtoSQL(THIS.this_dDataFinal, "23:59:59")) + " And "
        ENDIF

        IF !EMPTY(ALLTRIM(THIS.this_cGrupo))
            loc_cWhere = loc_cWhere + "(a.GrupoOs = " + EscaparSQL(ALLTRIM(THIS.this_cGrupo)) + ;
                " Or a.GrupoDs = " + EscaparSQL(ALLTRIM(THIS.this_cGrupo)) + ") And "
        ENDIF

        IF !EMPTY(ALLTRIM(THIS.this_cConta))
            loc_cWhere = loc_cWhere + "(a.ContaOs = " + EscaparSQL(ALLTRIM(THIS.this_cConta)) + ;
                " Or a.ContaDs = " + EscaparSQL(ALLTRIM(THIS.this_cConta)) + ") And "
        ENDIF

        IF THIS.this_nOperacao != 0
            loc_cWhere = loc_cWhere + "a.Nops = " + FormatarNumeroSQL(THIS.this_nOperacao, 0) + " And "
        ENDIF

        IF THIS.this_nNumero != 0
            loc_cWhere = loc_cWhere + "a.Numes = " + FormatarNumeroSQL(THIS.this_nNumero, 0) + " And "
        ENDIF

        IF !EMPTY(ALLTRIM(THIS.this_cResponsavel))
            loc_cWhere = loc_cWhere + "a.Vends = " + EscaparSQL(ALLTRIM(THIS.this_cResponsavel)) + " And "
        ENDIF

        DO CASE
            CASE THIS.this_nOpcaoPendente = 1
                loc_cWhere = loc_cWhere + "a.ChkSubn = 0 And "
            CASE THIS.this_nOpcaoPendente = 2
                loc_cWhere = loc_cWhere + "a.ChkSubn = 1 And "
        ENDCASE

        IF !EMPTY(ALLTRIM(THIS.this_cStatus))
            loc_cWhere = loc_cWhere + "a.pStatus = " + EscaparSQL(ALLTRIM(THIS.this_cStatus)) + " And "
        ENDIF

        RETURN loc_cWhere
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarSQLConsulta - Monta a consulta completa, transcrita da variavel
    * lcQuery do metodo consulta.Click do legado (join SigMvCab + SigCdOpe).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarSQLConsulta()
        LOCAL loc_cWhereEmpresa

        loc_cWhereEmpresa = "(a.Emps = " + EscaparSQL(ALLTRIM(THIS.this_cCodigoEmpresa))
        IF THIS.this_lEmpresaDestino
            loc_cWhereEmpresa = loc_cWhereEmpresa + " Or a.Empds = " + EscaparSQL(ALLTRIM(THIS.this_cCodigoEmpresa))
        ENDIF
        loc_cWhereEmpresa = loc_cWhereEmpresa + ") And "

        RETURN "SELECT a.* FROM SigMvCab a, SigCdOpe b WHERE " + ;
            loc_cWhereEmpresa + THIS.MontarWhereConsulta() + "a.Dopes = b.Dopes"
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarMovimentacao - Executa a consulta de posicao por movimentacao.
    * Equivalente ao metodo consulta.Click do legado (sem a parte de UI:
    * SetFocus/MessageBox/Do Form sigpres2 ficam por conta do Form).
    * Popula THIS.this_cCursorResultado (cursor_4c_Movimentacao) e
    * THIS.this_nTotalRegistros. Retorna .F. so quando a consulta falha -
    * zero registros encontrados NAO eh erro, eh resultado valido.
    *--------------------------------------------------------------------------
    FUNCTION BuscarMovimentacao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        THIS.this_cMensagemErro  = ""
        THIS.this_nTotalRegistros = 0
        loc_lSucesso = .F.

        IF !THIS.ValidarFiltros()
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = THIS.MontarSQLConsulta()

            IF USED("cursor_4c_SigPrEs1Tmp")
                USE IN cursor_4c_SigPrEs1Tmp
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigPrEs1Tmp")

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL()
            ELSE
                IF USED("cursor_4c_Movimentacao")
                    USE IN cursor_4c_Movimentacao
                ENDIF

                SELECT * FROM cursor_4c_SigPrEs1Tmp INTO CURSOR cursor_4c_Movimentacao READWRITE

                IF USED("cursor_4c_SigPrEs1Tmp")
                    USE IN cursor_4c_SigPrEs1Tmp
                ENDIF

                SELECT cursor_4c_Movimentacao
                INDEX ON EmpDopNums TAG EmpDopNums

                REPLACE ALL PrazoEnts WITH CTOD("") FOR ISNULL(PrazoEnts)

                *-- Legado: Go Top In csTemporario, e so depois If (Reccount() > 0)
                GO TOP

                THIS.this_nTotalRegistros = RECCOUNT("cursor_4c_Movimentacao")

                *-- Deixa a 1a linha ja carregada nas propriedades this_*Reg*
                *-- (e limpa quando a consulta nao trouxe nada, para nao herdar
                *-- a linha da consulta anterior).
                IF THIS.this_nTotalRegistros > 0
                    THIS.CarregarDoCursor("cursor_4c_Movimentacao")
                ELSE
                    THIS.LimparLinhaCorrente()
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * LimparLinhaCorrente - zera as propriedades da linha corrente do cursor
    * de resultado. Chamado no Init e sempre que a consulta devolve zero linhas,
    * para que uma consulta nova nunca herde a linha da consulta anterior.
    *--------------------------------------------------------------------------
    PROCEDURE LimparLinhaCorrente()
        THIS.this_cRegEmpresa      = ""
        THIS.this_cRegEmpresaDest  = ""
        THIS.this_cRegOperacao     = ""
        THIS.this_dRegData         = {/:}
        THIS.this_dRegPrazoEntrega = {/:}
        THIS.this_cRegGrupoOrigem  = ""
        THIS.this_cRegGrupoDestino = ""
        THIS.this_cRegContaOrigem  = ""
        THIS.this_cRegContaDestino = ""
        THIS.this_nRegNumeroOp     = 0
        THIS.this_nRegNumero       = 0
        THIS.this_cRegVendedor     = ""
        THIS.this_lRegBaixada      = .F.
        THIS.this_cRegStatus       = ""
        THIS.this_cRegChave        = ""

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * LerCampoCursor - le um campo do cursor corrente pelo NOME, devolvendo o
    * valor padrao quando o campo nao existe ou vem NULL.
    *
    * EVALUATE eh o caminho CERTO para LEITURA por nome (regra #15); e a
    * existencia do campo se testa com TYPE(alias + "." + campo), NUNCA com
    * PEMSTATUS - PEMSTATUS exige objeto no 1o argumento e dispara erro 11 com
    * alias de cursor.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LerCampoCursor(par_cAlias, par_cCampo, par_uPadrao)
        LOCAL loc_uValor

        loc_uValor = par_uPadrao

        IF TYPE(par_cAlias + "." + par_cCampo) != "U"
            loc_uValor = TratarNulo(EVALUATE(par_cAlias + "." + par_cCampo), par_uPadrao)
        ENDIF

        RETURN loc_uValor
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarChaveEmpDopNums - monta a chave composta EmpDopNums de SigMvCab.
    *
    * Legado (mesma montagem usada em todo o sistema Fortyus):
    *   lcEmpDopNums = <cursor>.Emps + <cursor>.Dopes + Str(<cursor>.Numes, 6)
    *
    * A chave eh POSICIONAL: o padding faz parte dela. Por isso as partes vao
    * com PADR na largura EXATA da coluna do schema, NUNCA com ALLTRIM - a
    * conferencia eh a largura do destino:
    *   emps char(3) + dopes char(20) + Str(numes, 6) = 29 = empdopnums char(29)
    * Com ALLTRIM nas partes a chave encurta, o WHERE nunca casa e o SELECT
    * devolve ZERO linhas em silencio (regra #42 do CLAUDE.md).
    *--------------------------------------------------------------------------
    PROCEDURE MontarChaveEmpDopNums(par_cEmps, par_cDopes, par_nNumes)
        RETURN PADR(NVL(par_cEmps, ""), 3) + ;
               PADR(NVL(par_cDopes, ""), 20) + ;
               STR(NVL(par_nNumes, 0), 6)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - carrega a linha CORRENTE do cursor de resultado nas
    * propriedades this_cReg* / this_nReg* / this_dReg* / this_lReg*.
    *
    * Sao as colunas de SigMvCab que o legado nomeia no consulta.Click; o
    * cursor vem de "Select a.* From SigMvCab a, SigCdOpe b", logo todas estao
    * presentes. NAO move o ponteiro do cursor: quem posiciona eh o chamador
    * (BuscarMovimentacao faz GO TOP, como o "Go Top In csTemporario" legado).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_cAlias, loc_lSucesso, loc_uChave, loc_oErro

        loc_lSucesso = .F.
        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
                         ALLTRIM(par_cAliasCursor), THIS.this_cCursorResultado)

        IF !USED(loc_cAlias)
            THIS.this_cMensagemErro = "Cursor [" + loc_cAlias + "] n" + CHR(227) + "o est" + CHR(225) + " aberto."
            THIS.LimparLinhaCorrente()
            RETURN .F.
        ENDIF

        IF EOF(loc_cAlias)
            THIS.LimparLinhaCorrente()
            RETURN .F.
        ENDIF

        TRY
            *-- Padrao obrigatorio: SELECT (alias) ANTES de acessar campos
            SELECT (loc_cAlias)

            THIS.this_cRegEmpresa      = ALLTRIM(THIS.LerCampoCursor(loc_cAlias, "emps", ""))
            THIS.this_cRegEmpresaDest  = ALLTRIM(THIS.LerCampoCursor(loc_cAlias, "empds", ""))
            THIS.this_cRegOperacao     = ALLTRIM(THIS.LerCampoCursor(loc_cAlias, "dopes", ""))
            THIS.this_dRegData         = THIS.LerCampoCursor(loc_cAlias, "datas", {/:})
            THIS.this_dRegPrazoEntrega = THIS.LerCampoCursor(loc_cAlias, "prazoents", {/:})
            THIS.this_cRegGrupoOrigem  = ALLTRIM(THIS.LerCampoCursor(loc_cAlias, "grupoos", ""))
            THIS.this_cRegGrupoDestino = ALLTRIM(THIS.LerCampoCursor(loc_cAlias, "grupods", ""))
            THIS.this_cRegContaOrigem  = ALLTRIM(THIS.LerCampoCursor(loc_cAlias, "contaos", ""))
            THIS.this_cRegContaDestino = ALLTRIM(THIS.LerCampoCursor(loc_cAlias, "contads", ""))
            THIS.this_nRegNumeroOp     = THIS.LerCampoCursor(loc_cAlias, "nops", 0)
            THIS.this_nRegNumero       = THIS.LerCampoCursor(loc_cAlias, "numes", 0)
            THIS.this_cRegVendedor     = ALLTRIM(THIS.LerCampoCursor(loc_cAlias, "vends", ""))
            THIS.this_cRegStatus       = ALLTRIM(THIS.LerCampoCursor(loc_cAlias, "pstatus", ""))

            *-- chksubn eh bit: chega como Logico (.T./.F.) ou Numerico (0/1)
            *-- conforme o driver ODBC - ConverterParaLogico trata os dois.
            THIS.this_lRegBaixada = ConverterParaLogico(THIS.LerCampoCursor(loc_cAlias, "chksubn", .F.))

            *-- empdopnums vem gravada na tabela; so remontamos quando vier em
            *-- branco, para nunca divergir do valor real do banco.
            loc_uChave = THIS.LerCampoCursor(loc_cAlias, "empdopnums", "")
            IF EMPTY(loc_uChave)
                loc_uChave = THIS.MontarChaveEmpDopNums(THIS.this_cRegEmpresa, ;
                                                        THIS.this_cRegOperacao, ;
                                                        THIS.this_nRegNumero)
            ENDIF
            THIS.this_cRegChave = loc_uChave

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - chave do registro corrente para a auditoria de
    * BusinessBase e para o handoff da linha selecionada. A chave de SigMvCab
    * eh a composta EmpDopNums (char(29)).
    *
    * PROTECTED porque o metodo da base tambem eh PROTECTED - subclasse nao
    * alarga escopo de hook herdado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave

        loc_cChave = THIS.this_cRegChave

        IF EMPTY(loc_cChave)
            loc_cChave = THIS.MontarChaveEmpDopNums(THIS.this_cRegEmpresa, ;
                                                    THIS.this_cRegOperacao, ;
                                                    THIS.this_nRegNumero)
        ENDIF

        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * DESTROY - libera o cursor de resultado da consulta
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Movimentacao")
            USE IN cursor_4c_Movimentacao
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
