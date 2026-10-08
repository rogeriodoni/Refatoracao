*============================================================================
* SigPrHprBO.prg - Business Object para Historico de Produtos (SIGPRHPR)
*
* Form OPERACIONAL (SIGPRHPR / FormSigPrHpr): tela de CONSULTA aberta por um
* form pai (ThisForm.ParentForm) que ja definiu, antes de "Do Form SigPrHpr",
* as variaveis PRIVATE pcCdGrupo/pcCdConta/pcCdProduto/pcDsProduto/pdDataIni/
* pdDataFin (grupo, conta, produto e periodo cujo historico de movimentos
* sera exibido - ver tasks/task621/SigPrHpr_form_codigo_fonte.txt,
* Procedure Init). A tela mostra:
*   - a grade principal grd_4c_Dados (CrSigMvHst no legado) com o historico
*     de movimentos do produto no periodo;
*   - a grade secundaria grd_4c_Subniveis (crSubniveis no legado) com os
*     subniveis (SigMvPec x SigCdOpe) do documento selecionado;
*   - origem/destino (Grupo/Conta) do documento de movimento corrente,
*     resolvidos contra SigMvCab (ou SigCdNec quando o documento ainda nao
*     foi efetivado) e descritos via SigCdGcr/SigCdCli;
*   - o checkbox de Auditado, que GRAVA (UPDATE SigMvHst) auditors/dtaudits
*     do registro corrente - a UNICA escrita real deste form.
*
* NAO existe uma unica "tabela principal" para efeito de Buscar()/
* CarregarDoCursor() (this_cTabela permanece vazio, mesmo padrao adotado em
* SigPrGstBO/SigPrGlxBO): o historico vem de SigMvHst filtrado por
* Grupo+Conta+Produto+Periodo, e os cursores auxiliares (documento, grupo/
* conta descritivos, subniveis) sao resolvidos a cada linha selecionada na
* grade principal (AfterRowColChange do legado). this_cCampoChave aponta
* para "cidchaves" (SigMvHst.cidchaves, PK), que eh o unico campo usado
* para localizar o registro no UPDATE de auditoria.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
* Completado em: Fase 2 - Metodos CRUD/dominio (CarregarHistorico,
* CarregarDoCursor, BuscarDocumentoMovimento, BuscarDescricoesGrupoConta,
* VerificarPermissaoAuditoria, CarregarSubniveis, AtualizarAuditoria,
* VerificarDocumentoCadastrado, ObterChavePrimaria, ObterTituloProduto)
*============================================================================

DEFINE CLASS SigPrHprBO AS BusinessBase

    *==========================================================================
    * Parametros recebidos do form pai (equivalente as PRIVATE pcCdGrupo/
    * pcCdConta/pcCdProduto/pcDsProduto/pdDataIni/pdDataFin do legado -
    * definidas pelo chamador ANTES de abrir esta tela)
    *==========================================================================
    this_cGrupo             = SPACE(10)  && pcCdGrupo  (SigMvHst.grupos char(10))
    this_cConta             = SPACE(10)  && pcCdConta  (SigMvHst.estos  char(10))
    this_cProduto           = SPACE(14)  && pcCdProduto (SigMvHst.cpros char(14))
    this_cDescricaoProduto  = ""         && pcDsProduto (descricao exibida no titulo)
    this_dDataIni           = {}         && pdDataIni  (inicio do periodo)
    this_dDataFin           = {}         && pdDataFin  (fim do periodo)

    *==========================================================================
    * Registro corrente da grade principal (equivalente a CrSigMvHst na
    * linha ativa - usado por AfterRowColChange/chkAuditado.Click/
    * btnDocumento.Click do legado)
    *==========================================================================
    this_cEmpsAtual         = SPACE(3)   && CrSigMvHst.emps
    this_cEmposAtual        = SPACE(3)   && CrSigMvHst.empos
    this_cDopesAtual        = SPACE(20)  && CrSigMvHst.dopes
    this_nNumesAtual        = 0          && CrSigMvHst.numes
    this_cCidChavesAtual    = SPACE(20)  && CrSigMvHst.cidchaves (PK - chave do UPDATE de auditoria)
    this_cAuditorAtual      = SPACE(10)  && CrSigMvHst.auditors
    this_dDtAuditAtual      = {}         && CrSigMvHst.dtaudits
    this_cObsAtual          = ""         && CrSigMvHst.obs
    this_cUsuarioMovAtual   = SPACE(10)  && CrSigMvHst.usuars
    this_cNotaAtual         = SPACE(6)   && SigMvCab.notas do documento corrente

    *==========================================================================
    * Produto / unidade (equivalente a TmpPro/TmpUni do legado - resolvidos
    * uma unica vez no Init para decidir se a grade mostra as colunas de
    * Peso/Saldo Peso)
    *==========================================================================
    this_cUnidade           = SPACE(3)   && SigCdPro.cunis
    this_cUnidadePeso       = SPACE(3)   && SigCdPro.cunips
    this_cTipoEstoque       = SPACE(1)   && SigCdUni.cestos ("3" = controla peso)

    *==========================================================================
    * Documento de origem/destino do movimento corrente (equivalente a
    * CrSigMvCab resolvido no AfterRowColChange do legado - grupoos/
    * contaos/grupods/contads - e suas descricoes via SigCdGcr/SigCdCli)
    *==========================================================================
    this_cGrupoOrigem       = SPACE(10)  && SigMvCab.grupoos
    this_cContaOrigem       = SPACE(10)  && SigMvCab.contaos
    this_cGrupoDestino      = SPACE(10)  && SigMvCab.grupods
    this_cContaDestino      = SPACE(10)  && SigMvCab.contads
    this_cDescGrupoOrigem   = SPACE(40)  && SigCdGcr.descrs (grupoos)
    this_cDescContaOrigem   = SPACE(50)  && SigCdCli.rclis  (contaos)
    this_cDescGrupoDestino  = SPACE(40)  && SigCdGcr.descrs (grupods)
    this_cDescContaDestino  = SPACE(50)  && SigCdCli.rclis  (contads)

    *==========================================================================
    * Permissao de auditoria (equivalente a llSupervis/llVisAudit do Init
    * legado - decide se o chk_4c_Auditado fica visivel para o usuario
    * corrente)
    *==========================================================================
    this_lUsuarioSupervisor = .F.        && Upper(Alltrim(Usuar)) = "4CONTROL"
    this_lPodeAuditar       = .F.        && llVisAudit (resultado final da checagem)

    *==========================================================================
    * Init - Inicializa o Business Object. Nao ha tabela/chave primaria
    * unica para este processo de consulta (o historico vem de SigMvHst
    * filtrado por Grupo+Conta+Produto+Periodo recebidos do form pai) -
    * mesmo padrao adotado em SigPrGstBO.Init/SigPrGlxBO.Init. this_cCam
    * poChave fica com "cidchaves" (SigMvHst.cidchaves), unico campo usado
    * para localizar o registro no UPDATE de auditoria.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro

        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = "cidchaves"

            THIS.this_cGrupo            = SPACE(10)
            THIS.this_cConta            = SPACE(10)
            THIS.this_cProduto          = SPACE(14)
            THIS.this_cDescricaoProduto = ""
            THIS.this_dDataIni          = {}
            THIS.this_dDataFin          = {}

            THIS.this_cEmpsAtual        = SPACE(3)
            THIS.this_cEmposAtual       = SPACE(3)
            THIS.this_cDopesAtual       = SPACE(20)
            THIS.this_nNumesAtual       = 0
            THIS.this_cCidChavesAtual   = SPACE(20)
            THIS.this_cAuditorAtual     = SPACE(10)
            THIS.this_dDtAuditAtual     = {}
            THIS.this_cObsAtual         = ""
            THIS.this_cUsuarioMovAtual  = SPACE(10)
            THIS.this_cNotaAtual        = SPACE(6)

            THIS.this_cUnidade          = SPACE(3)
            THIS.this_cUnidadePeso      = SPACE(3)
            THIS.this_cTipoEstoque      = SPACE(1)

            THIS.this_cGrupoOrigem      = SPACE(10)
            THIS.this_cContaOrigem      = SPACE(10)
            THIS.this_cGrupoDestino     = SPACE(10)
            THIS.this_cContaDestino     = SPACE(10)
            THIS.this_cDescGrupoOrigem  = SPACE(40)
            THIS.this_cDescContaOrigem  = SPACE(50)
            THIS.this_cDescGrupoDestino = SPACE(40)
            THIS.this_cDescContaDestino = SPACE(50)

            THIS.this_lUsuarioSupervisor = .F.
            THIS.this_lPodeAuditar       = .F.

            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inicializar: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - chave usada por RegistrarAuditoria() apos o
    * UPDATE de auditoria (AtualizarAuditoria) - SigMvHst.cidchaves do
    * registro corrente da grade principal.
    *
    * PROTECTED porque o metodo da base tambem eh PROTECTED - subclasse nao
    * alarga escopo de hook herdado.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChavesAtual)
    ENDPROC

    *==========================================================================
    * Inserir()/Atualizar()/ExecutarExclusao() do BusinessBase NAO sao
    * sobrescritos aqui: este form eh de CONSULTA (historico de movimentos
    * de SigMvHst), sem INSERT/UPDATE/DELETE genericos no legado. A UNICA
    * escrita real (toggle de chk_4c_Auditado) tem semantica propria -
    * AtualizarAuditoria(), mais abaixo, grava auditors/dtaudits em
    * SigMvHst e chama RegistrarAuditoria("UPDATE") no sucesso. O
    * comportamento padrao herdado de BusinessBase para Inserir/Atualizar/
    * ExecutarExclusao ja eh o correto para este BO.
    *==========================================================================

    *==========================================================================
    * ExecutarSQL - SQLEXEC preservando a area de trabalho corrente
    * (equivalente a ThisForm.poDataMgr.SqlExecute do legado, que nao
    * reseleciona a area depois - SQLEXEC() troca a area selecionada).
    *==========================================================================
    PROTECTED FUNCTION ExecutarSQL(par_cSQL, par_cCursor, par_cRotulo)
        LOCAL loc_nRet, loc_lOk, loc_cAliasAnt

        loc_cAliasAnt = ALIAS()

        IF USED(par_cCursor)
            USE IN (par_cCursor)
        ENDIF
        loc_nRet = SQLEXEC(gnConnHandle, par_cSQL, par_cCursor)

        IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
            SELECT (loc_cAliasAnt)
        ENDIF

        loc_lOk = (loc_nRet >= 0)

        IF !loc_lOk
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "(" + TRANSFORM(par_cRotulo) + ") " + CapturarErroSQL()
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *==========================================================================
    * BuscarProdutoUnidade - produto/unidade do historico (TmpPro/TmpUni do
    * legado) - decide via this_cTipoEstoque se a grade mostra as colunas
    * de Peso/Saldo Peso (cestos = "3").
    *==========================================================================
    PROTECTED FUNCTION BuscarProdutoUnidade(par_cProduto)
        LOCAL loc_lResultado, loc_cSQL

        loc_lResultado = .F.

        loc_cSQL = "SELECT cpros, cunis, cunips FROM SigCdPro WHERE cpros = " + EscaparSQL(par_cProduto)

        IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_Produto", "Produto")
            IF USED("cursor_4c_Produto") AND RECCOUNT("cursor_4c_Produto") > 0
                SELECT cursor_4c_Produto
                GO TOP
                THIS.this_cUnidade     = PADR(TratarNulo(cunis, ""), 3)
                THIS.this_cUnidadePeso = PADR(TratarNulo(cunips, ""), 3)
                USE IN cursor_4c_Produto

                loc_cSQL = "SELECT cestos FROM SigCdUni WHERE cunis = " + EscaparSQL(THIS.this_cUnidade)
                IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_Unidade", "Unidade")
                    IF USED("cursor_4c_Unidade") AND RECCOUNT("cursor_4c_Unidade") > 0
                        SELECT cursor_4c_Unidade
                        GO TOP
                        THIS.this_cTipoEstoque = TratarNulo(cestos, "")
                        loc_lResultado = .T.
                    ENDIF
                    IF USED("cursor_4c_Unidade")
                        USE IN cursor_4c_Unidade
                    ENDIF
                ENDIF
            ELSE
                IF USED("cursor_4c_Produto")
                    USE IN cursor_4c_Produto
                ENDIF
                THIS.this_cMensagemErro = "Produto " + ALLTRIM(TratarNulo(par_cProduto, "")) + " n" + CHR(227) + "o encontrado."
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CarregarHistorico - equivalente ao bloco principal do Init legado:
    * resolve produto/unidade, popula cursor_4c_Dados (CrSigMvHst) com o
    * historico de movimentos filtrado por Grupo+Conta+Produto+Periodo e
    * deixa o cursor posicionado no ULTIMO registro (Go Bottom legado), que
    * eh quem o Form usa para carregar a linha inicial via
    * CarregarDoCursor(). Chave empgruests eh POSICIONAL (emps(3)+
    * grupos(10)+estos(10) = 23) - PADR explicito, nunca ALLTRIM nas partes
    * (CLAUDE.md regra #42).
    *==========================================================================
    FUNCTION CarregarHistorico(par_cGrupo, par_cConta, par_cProduto, par_cDescricaoProduto, par_dDataIni, par_dDataFin)
        LOCAL loc_lResultado, loc_cSQL, loc_cChave, loc_dFim

        loc_lResultado = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        THIS.this_cGrupo            = PADR(TratarNulo(par_cGrupo, ""), 10)
        THIS.this_cConta            = PADR(TratarNulo(par_cConta, ""), 10)
        THIS.this_cProduto          = PADR(TratarNulo(par_cProduto, ""), 14)
        THIS.this_cDescricaoProduto = ALLTRIM(TratarNulo(par_cDescricaoProduto, ""))
        THIS.this_dDataIni          = TratarNulo(par_dDataIni, {})
        THIS.this_dDataFin          = TratarNulo(par_dDataFin, {})

        IF !THIS.BuscarProdutoUnidade(THIS.this_cProduto)
            RETURN .F.
        ENDIF

        loc_dFim = DATETIME(YEAR(THIS.this_dDataFin), MONTH(THIS.this_dDataFin), DAY(THIS.this_dDataFin), 23, 59, 59)

        loc_cChave = PADR(go_4c_Sistema.cCodEmpresa, 3) + THIS.this_cGrupo + THIS.this_cConta

        loc_cSQL = "SELECT a.emps, a.empos, a.grupos, a.estos, a.cpros, a.dopes, a.numes, " + ;
            "a.datas, a.auditors, a.dtaudits, a.qtds, a.opers, a.sqtds, a.obs, " + ;
            "a.usuars, a.cidchaves, a.pesos, a.spesos, SPACE(3) AS cunis " + ;
            "FROM SigMvHst a " + ;
            "WHERE a.empgruests = " + EscaparSQL(loc_cChave) + " " + ;
            "AND a.cpros = " + EscaparSQL(THIS.this_cProduto) + " " + ;
            "AND a.datas BETWEEN " + FormatarDataSQL(THIS.this_dDataIni) + " AND " + FormatarDataSQL(loc_dFim) + " " + ;
            "ORDER BY a.emps, a.grupos, a.estos, a.cidchaves, a.opers"

        IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_Dados", "Historico")
            IF USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                REPLACE ALL cunis WITH THIS.this_cUnidade
                INDEX ON Pesos TAG Pesos
                INDEX ON DTOS(datas) TAG datas
                GO BOTTOM
            ENDIF
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * ObterTituloProduto - monta o Caption de lbl_4c_Produto (equivalente a
    * ThisForm.lbl_Produto.Caption do Init legado): produto + descricao +
    * periodo e, quando a unidade controla peso (cestos = "3"), tambem a
    * unidade de peso.
    *==========================================================================
    FUNCTION ObterTituloProduto()
        LOCAL loc_cTitulo

        loc_cTitulo = "Produto : " + ALLTRIM(THIS.this_cProduto) + " - " + ALLTRIM(THIS.this_cDescricaoProduto) + ;
            SPACE(10) + "Per" + CHR(237) + "odo: " + DTOC(THIS.this_dDataIni) + " " + CHR(224) + " " + DTOC(THIS.this_dDataFin)

        IF THIS.this_cTipoEstoque == "3"
            loc_cTitulo = loc_cTitulo + " Unid.Peso:" + ALLTRIM(THIS.this_cUnidadePeso)
        ENDIF

        RETURN loc_cTitulo
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - equivalente ao AfterRowColChange do legado: le o
    * registro CORRENTE de cursor_4c_Dados (a grade principal) e resolve
    * tudo o que depende dele - documento de origem/destino, descricoes de
    * grupo/conta, permissao de auditoria e subniveis.
    *==========================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado

        loc_lResultado = .F.

        IF USED(par_cAliasCursor) AND !EOF(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cEmpsAtual       = PADR(TratarNulo(emps, ""), 3)
            THIS.this_cEmposAtual      = PADR(TratarNulo(empos, ""), 3)
            THIS.this_cDopesAtual      = PADR(TratarNulo(dopes, ""), 20)
            THIS.this_nNumesAtual      = TratarNulo(numes, 0)
            THIS.this_cCidChavesAtual  = PADR(TratarNulo(cidchaves, ""), 20)
            THIS.this_cAuditorAtual    = PADR(TratarNulo(auditors, ""), 10)
            THIS.this_dDtAuditAtual    = TratarNulo(dtaudits, {})
            THIS.this_cObsAtual        = TratarNulo(obs, "")
            THIS.this_cUsuarioMovAtual = PADR(TratarNulo(usuars, ""), 10)
            THIS.this_cNotaAtual       = SPACE(6)

            IF THIS.BuscarDocumentoMovimento()
                THIS.BuscarDescricoesGrupoConta()
            ENDIF

            THIS.VerificarPermissaoAuditoria()
            THIS.CarregarSubniveis()

            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * VerificarOperacaoCadastrada - equivalente a
    * ThisForm.poDataMgr.Cursorquery('SigCdOpe','CrOpe','Dopes',...,'Dopes')
    * do legado: confirma se a operacao (Dopes) do movimento corrente esta
    * cadastrada em SigCdOpe. Decide se o documento se resolve por
    * SigMvCab (movimento ja efetivado) ou por SigCdNec (necessidade,
    * ainda nao efetivada).
    *==========================================================================
    PROTECTED FUNCTION VerificarOperacaoCadastrada(par_cDopes)
        LOCAL loc_lResultado, loc_cSQL

        loc_lResultado = .F.

        loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCdOpe WHERE Dopes = " + ;
            EscaparSQL(ALLTRIM(TratarNulo(par_cDopes, "")))

        IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_VerOpe", "VerificarOperacao")
            IF USED("cursor_4c_VerOpe")
                loc_lResultado = (NVL(cursor_4c_VerOpe.Total, 0) > 0)
                USE IN cursor_4c_VerOpe
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * BuscarDocumentoMovimento - resolve o documento de origem/destino do
    * movimento corrente (grupoos/contaos/grupods/contads), igual ao
    * AfterRowColChange do legado: tenta SigMvCab (documento JA efetivado,
    * chave EmpDopNums char(29) = emps(3)+dopes(20)+Str(numes,6)) e cai
    * para SigCdNec (necessidade, ainda nao efetivada, chave EmpDnPs
    * char(33) = emps(3)+dopes(20)+Str(numes,10)) quando a operacao nao
    * esta cadastrada em SigCdOpe. As duas chaves sao POSICIONAIS - PADR
    * explicito, nunca ALLTRIM nas partes (CLAUDE.md regra #42).
    *==========================================================================
    PROTECTED FUNCTION BuscarDocumentoMovimento()
        LOCAL loc_lResultado, loc_cSQL, loc_cEmpDoc

        loc_lResultado = .F.

        loc_cEmpDoc = PADR(IIF(!EMPTY(THIS.this_cEmposAtual), THIS.this_cEmposAtual, THIS.this_cEmpsAtual), 3)

        THIS.this_cGrupoOrigem  = SPACE(10)
        THIS.this_cContaOrigem  = SPACE(10)
        THIS.this_cGrupoDestino = SPACE(10)
        THIS.this_cContaDestino = SPACE(10)
        THIS.this_cNotaAtual    = SPACE(6)

        IF THIS.VerificarOperacaoCadastrada(THIS.this_cDopesAtual)
            loc_cSQL = "SELECT grupoos, contaos, grupods, contads, Notas FROM SigMvCab " + ;
                "WHERE empdopnums = " + EscaparSQL(loc_cEmpDoc + PADR(THIS.this_cDopesAtual, 20) + STR(THIS.this_nNumesAtual, 6))
        ELSE
            loc_cSQL = "SELECT grupoos, contaos, grupods, contads, SPACE(6) AS Notas FROM SigCdNec " + ;
                "WHERE empdnps = " + EscaparSQL(loc_cEmpDoc + PADR(THIS.this_cDopesAtual, 20) + STR(THIS.this_nNumesAtual, 10))
        ENDIF

        IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_Documento", "Documento")
            IF USED("cursor_4c_Documento") AND RECCOUNT("cursor_4c_Documento") > 0
                SELECT cursor_4c_Documento
                GO TOP
                THIS.this_cGrupoOrigem  = PADR(TratarNulo(grupoos, ""), 10)
                THIS.this_cContaOrigem  = PADR(TratarNulo(contaos, ""), 10)
                THIS.this_cGrupoDestino = PADR(TratarNulo(grupods, ""), 10)
                THIS.this_cContaDestino = PADR(TratarNulo(contads, ""), 10)
                THIS.this_cNotaAtual    = PADR(TratarNulo(Notas, ""), 6)
                loc_lResultado = .T.
            ENDIF
            IF USED("cursor_4c_Documento")
                USE IN cursor_4c_Documento
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * BuscarDescricoesGrupoConta - descricoes de Grupo (SigCdGcr.descrs) e
    * Conta (SigCdCli.rclis) de origem/destino do documento corrente.
    *==========================================================================
    PROTECTED FUNCTION BuscarDescricoesGrupoConta()
        LOCAL loc_cSQL, loc_cGO, loc_cGD, loc_cCO, loc_cCD

        loc_cGO = ALLTRIM(THIS.this_cGrupoOrigem)
        loc_cGD = ALLTRIM(THIS.this_cGrupoDestino)
        loc_cCO = ALLTRIM(THIS.this_cContaOrigem)
        loc_cCD = ALLTRIM(THIS.this_cContaDestino)

        THIS.this_cDescGrupoOrigem  = SPACE(40)
        THIS.this_cDescContaOrigem  = SPACE(50)
        THIS.this_cDescGrupoDestino = SPACE(40)
        THIS.this_cDescContaDestino = SPACE(50)

        IF !EMPTY(loc_cGO) OR !EMPTY(loc_cGD)
            loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cGO) + ;
                " OR codigos = " + EscaparSQL(loc_cGD)
            IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_Grupo", "Grupo")
                IF USED("cursor_4c_Grupo")
                    INDEX ON codigos TAG codigos
                    IF !EMPTY(loc_cGO) AND SEEK(loc_cGO, "cursor_4c_Grupo", "codigos")
                        THIS.this_cDescGrupoOrigem = PADR(TratarNulo(cursor_4c_Grupo.descrs, ""), 40)
                    ENDIF
                    IF !EMPTY(loc_cGD) AND SEEK(loc_cGD, "cursor_4c_Grupo", "codigos")
                        THIS.this_cDescGrupoDestino = PADR(TratarNulo(cursor_4c_Grupo.descrs, ""), 40)
                    ENDIF
                    USE IN cursor_4c_Grupo
                ENDIF
            ENDIF
        ENDIF

        IF !EMPTY(loc_cCO) OR !EMPTY(loc_cCD)
            loc_cSQL = "SELECT iclis, rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cCO) + ;
                " OR iclis = " + EscaparSQL(loc_cCD)
            IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_Conta", "Conta")
                IF USED("cursor_4c_Conta")
                    INDEX ON iclis TAG iclis
                    IF !EMPTY(loc_cCO) AND SEEK(loc_cCO, "cursor_4c_Conta", "iclis")
                        THIS.this_cDescContaOrigem = PADR(TratarNulo(cursor_4c_Conta.rclis, ""), 50)
                    ENDIF
                    IF !EMPTY(loc_cCD) AND SEEK(loc_cCD, "cursor_4c_Conta", "iclis")
                        THIS.this_cDescContaDestino = PADR(TratarNulo(cursor_4c_Conta.rclis, ""), 50)
                    ENDIF
                    USE IN cursor_4c_Conta
                ENDIF
            ENDIF
        ENDIF

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * VerificarPermissaoAuditoria - equivalente ao bloco llSupervis/
    * llVisAudit do AfterRowColChange legado. this_lUsuarioSupervisor e
    * this_lPodeAuditar decidem se chk_4c_Auditado fica visivel/habilitado
    * para o usuario corrente.
    *==========================================================================
    PROTECTED FUNCTION VerificarPermissaoAuditoria()
        LOCAL loc_cUsuario

        loc_cUsuario = UPPER(ALLTRIM(TratarNulo(gc_4c_UsuarioLogado, "")))

        * Richard em 29/11/2016 - Eliminando SUPERVIS (a consulta a
        * SigCdUsu.supervis foi comentada no legado - *!* no fonte
        * original - preservado: so o usuario 4CONTROL eh supervisor)
        THIS.this_lUsuarioSupervisor = (loc_cUsuario == "4CONTROL")

        IF THIS.this_lUsuarioSupervisor
            THIS.this_lPodeAuditar = .T.
        ELSE
            IF EMPTY(THIS.this_cAuditorAtual) AND fChecaAcesso("SIGPRHPR", "AUDITORIA")
                THIS.this_lPodeAuditar = .T.
            ELSE
                THIS.this_lPodeAuditar = (loc_cUsuario == UPPER(ALLTRIM(THIS.this_cAuditorAtual)))
            ENDIF
        ENDIF

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * CarregarSubniveis - equivalente ao bloco final do AfterRowColChange
    * legado: Zap In crSubniveis + Scan/Insert Into a partir de SigMvPec x
    * SigCdOpe. Chave EmpDopNums eh POSICIONAL (emps(3)+dopes(20)+
    * Str(numes,6) = 29) - PADR explicito, nunca ALLTRIM nas partes
    * (CLAUDE.md regra #42).
    *==========================================================================
    FUNCTION CarregarSubniveis()
        LOCAL loc_lResultado, loc_cSQL, loc_cEdn

        loc_lResultado = .F.

        IF USED("cursor_4c_Subniveis")
            USE IN cursor_4c_Subniveis
        ENDIF
        SET NULL ON
        CREATE CURSOR cursor_4c_Subniveis (Emps C(3), Dopes C(20), Numes N(6))
        SET NULL OFF
        INDEX ON Emps TAG Emps

        loc_cEdn = PADR(THIS.this_cEmpsAtual, 3) + PADR(THIS.this_cDopesAtual, 20) + STR(THIS.this_nNumesAtual, 6)

        loc_cSQL = "SELECT a.EmpSubns AS Emps, b.Dopes, RIGHT(STR(a.Codigos, 10), 6) AS Numes " + ;
            "FROM SigMvPec a, SigCdOpe b " + ;
            "WHERE a.EmpDopNums = " + EscaparSQL(loc_cEdn) + " " + ;
            "AND LEFT(STR(a.Codigos, 10), 4) = STR(b.NDopes, 4) " + ;
            "ORDER BY 1, 2, 3"

        IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_SubniveisTemp", "Subniveis")
            IF USED("cursor_4c_SubniveisTemp")
                SELECT cursor_4c_SubniveisTemp
                SCAN
                    INSERT INTO cursor_4c_Subniveis (Emps, Dopes, Numes) ;
                        VALUES (cursor_4c_SubniveisTemp.Emps, cursor_4c_SubniveisTemp.Dopes, VAL(cursor_4c_SubniveisTemp.Numes))
                ENDSCAN
                USE IN cursor_4c_SubniveisTemp
            ENDIF
            loc_lResultado = .T.
        ENDIF

        IF USED("cursor_4c_Subniveis")
            GO TOP IN cursor_4c_Subniveis
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * AtualizarAuditoria - equivalente ao chkAuditado.Click do legado: grava
    * (UPDATE SigMvHst) auditors/dtaudits do registro corrente - a UNICA
    * escrita real deste form. BEGIN/COMMIT/ROLLBACK TRANSACTION em LOTE
    * unico (os dois UPDATEs na mesma transacao).
    *==========================================================================
    FUNCTION AtualizarAuditoria(par_lMarcarAuditado)
        LOCAL loc_lResultado, loc_cSQL, loc_nRet1, loc_nRet2

        loc_lResultado = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.this_cCidChavesAtual)
            THIS.this_cMensagemErro = "Nenhum registro selecionado para auditoria."
            RETURN .F.
        ENDIF

        SQLEXEC(gnConnHandle, "BEGIN TRANSACTION", "cursor_4c_Trn")
        IF USED("cursor_4c_Trn")
            USE IN cursor_4c_Trn
        ENDIF

        IF par_lMarcarAuditado
            loc_cSQL = "UPDATE SigMvHst SET auditors = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChavesAtual)
        ELSE
            loc_cSQL = "UPDATE SigMvHst SET auditors = " + EscaparSQL(SPACE(10)) + ;
                " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChavesAtual)
        ENDIF
        loc_nRet1 = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdAud1")
        IF USED("cursor_4c_UpdAud1")
            USE IN cursor_4c_UpdAud1
        ENDIF

        IF par_lMarcarAuditado
            loc_cSQL = "UPDATE SigMvHst SET dtaudits = GETDATE() WHERE cidchaves = " + ;
                EscaparSQL(THIS.this_cCidChavesAtual)
        ELSE
            loc_cSQL = "UPDATE SigMvHst SET dtaudits = NULL WHERE cidchaves = " + ;
                EscaparSQL(THIS.this_cCidChavesAtual)
        ENDIF
        loc_nRet2 = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdAud2")
        IF USED("cursor_4c_UpdAud2")
            USE IN cursor_4c_UpdAud2
        ENDIF

        IF loc_nRet1 < 0 OR loc_nRet2 < 0
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION", "cursor_4c_Rb")
            IF USED("cursor_4c_Rb")
                USE IN cursor_4c_Rb
            ENDIF
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + CapturarErroSQL()
            loc_lResultado = .F.
        ELSE
            SQLEXEC(gnConnHandle, "COMMIT TRANSACTION", "cursor_4c_Cmt")
            IF USED("cursor_4c_Cmt")
                USE IN cursor_4c_Cmt
            ENDIF

            IF par_lMarcarAuditado
                THIS.this_cAuditorAtual = PADR(gc_4c_UsuarioLogado, 10)
                THIS.this_dDtAuditAtual = DATETIME()
            ELSE
                THIS.this_cAuditorAtual = SPACE(10)
                THIS.this_dDtAuditAtual = {}
            ENDIF

            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                REPLACE cursor_4c_Dados.auditors WITH THIS.this_cAuditorAtual, ;
                        cursor_4c_Dados.dtaudits  WITH THIS.this_dDtAuditAtual
            ENDIF

            THIS.RegistrarAuditoria("UPDATE")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * VerificarDocumentoCadastrado - equivalente a
    * ThisForm.poDataMgr.ChkRegister(tabela, campo, valor) do legado:
    * confirma se existe registro com a chave informada. Usado pelo botao
    * Movimento para decidir entre abrir o documento ja efetivado
    * (SigMvCab) ou a necessidade ainda em aberto (SigCdNec).
    *==========================================================================
    FUNCTION VerificarDocumentoCadastrado(par_cTabela, par_cCampoChave, par_cValorChave)
        LOCAL loc_lResultado, loc_cSQL

        loc_lResultado = .F.

        loc_cSQL = "SELECT COUNT(*) AS Total FROM " + par_cTabela + ;
            " WHERE " + par_cCampoChave + " = " + EscaparSQL(par_cValorChave)

        IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_VerDoc", "VerificarDocumento")
            IF USED("cursor_4c_VerDoc")
                loc_lResultado = (NVL(cursor_4c_VerDoc.Total, 0) > 0)
                USE IN cursor_4c_VerDoc
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE
