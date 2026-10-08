*============================================================================
* SigPrGstBO.prg - Business Object para Geracao de Movimentacoes de Estoque
* (SIGPRGST)
*
* Form OPERACIONAL (SIGPRGST / FormSigPrGst): tela auxiliar aberta por um
* form pai que ja populou os cursores csCabec/csItens/csEstPe (pedidos de
* movimentacao ainda nao gerados) e CrSigCdNec/CrSigCdEmb (parametros de
* embalagem). O usuario confirma, na grade de csCabec, qual pedido deseja
* gerar; o botao Confirmar chama GerarPedido(), que grava os movimentos
* (SigMvCab/SigMvItn/SigMvIts/SigMvPec/SigInBep) e, com sucesso, abre o
* form SigMvCab (Do Form SigMvCab With csCabec.GerDopes, ...) para o
* usuario revisar a movimentacao recem-gerada.
*
* NAO existe uma unica "tabela principal" para este processo (this_cTabela
* permanece vazio) - os cursores csCabec/csItens/csEstPe/CrSigCdNec/
* CrSigCdEmb sao preparados por quem abre esta tela (conforme
* tasks/task620/SigPrGst_form_codigo_fonte.txt, Procedure gerarpedido) e o
* BO so os le/atualiza pelo nome, igual ao legado.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
* Completado em: Fase 2 - GerarPedido() (gravacao real) + ObterChavePrimaria/
*                MontarChaveEmpDopNums + helpers de persistencia SQL Server
*============================================================================

DEFINE CLASS SigPrGstBO AS BusinessBase

    *==========================================================================
    * Estado herdado do form pai (equivalente a ThisForm.PcEscolha e
    * ThisForm.GrupoOper do Init legado - GrupoOper e declarado no SCX mas
    * nao e lido em nenhum metodo com codigo; mantido por paridade)
    *==========================================================================
    this_cPcEscolha      = SPACE(10)  && ThisForm.ParentForm.pcEscolha
    this_cGrupoOper      = SPACE(10)  && ThisForm.GrupoOper (Space(10) no Init legado)

    *==========================================================================
    * Pedido corrente selecionado na grade csCabec (chave usada por
    * GerarPedido/AfterRowColChange para resolver csItens/csEstPe via
    * Set Key To csCabec.EmpdopNums)
    *==========================================================================
    this_cEmps           = SPACE(3)   && csCabec.Emps do registro corrente
    this_cDopes          = SPACE(20)  && csCabec.Dopes do registro corrente
    this_cEmpDopNums     = ""         && csCabec.EmpDopNums do registro corrente

    *==========================================================================
    * Resultado de GerarPedido() - espelha os campos que o legado grava de
    * volta em csCabec apos a geracao (Replace Gerado/GerEmps/GerDopes/
    * GerNumes In csCabec)
    *==========================================================================
    this_lGerado         = .F.        && .T. quando GerarPedido() concluiu com sucesso
    this_cGerEmps        = SPACE(3)   && crSigMvCab.Emps gravado
    this_cGerDopes       = SPACE(20)  && crSigMvCab.Dopes gravado
    this_nGerNumes       = 0          && crSigMvCab.Numes gravado

    *==========================================================================
    * Numeracao/mascara do movimento gerado (lnNum/lcMsk do Gerarpedido
    * legado - fGerUniqueKey/fGerMascara)
    *==========================================================================
    this_nNumeroGerado   = 0          && lnNum
    this_cMascaraNumero  = ""         && lcMsk

    *==========================================================================
    * Init - Inicializa o Business Object. Nao ha tabela/chave primaria
    * unica para este processo (BO opera sobre os cursores csCabec/csItens/
    * csEstPe/CrSigCdNec/CrSigCdEmb preparados pelo form pai antes de abrir
    * esta tela) - mesmo padrao adotado em SigPrGlxBO.Init.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro

        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            THIS.this_cPcEscolha  = SPACE(10)
            THIS.this_cGrupoOper  = SPACE(10)

            THIS.this_cEmps       = SPACE(3)
            THIS.this_cDopes      = SPACE(20)
            THIS.this_cEmpDopNums = ""

            THIS.this_lGerado     = .F.
            THIS.this_cGerEmps    = SPACE(3)
            THIS.this_cGerDopes   = SPACE(20)
            THIS.this_nGerNumes   = 0

            THIS.this_nNumeroGerado  = 0
            THIS.this_cMascaraNumero = ""

            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inicializar: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Inserir() / Atualizar() / ExecutarExclusao() / CarregarDoCursor(): este
    * BO deliberadamente NAO sobrescreve esses metodos do BusinessBase.
    *
    * SIGPRGST nao eh um cadastro: nao existe uma unica tabela/registro que o
    * form carregue, edite e grave via Salvar()/Excluir(). O usuario escolhe,
    * na grade csCabec (preparada por quem abre esta tela - ver cabecalho do
    * arquivo), qual pedido confirmar; a gravacao real ocorre em
    * THIS.GerarPedido() - transcricao de SIGPRGST.gerarpedido (dump do SCX
    * legado, linhas 812-941) - que grava em CINCO tabelas (SigMvCab/
    * SigMvItn/SigMvIts/SigMvPec/SigInBep) dentro de uma unica transacao e
    * chama THIS.RegistrarAuditoria() por conta propria ao concluir com
    * sucesso. Os stubs herdados de BusinessBase (que devolvem .F. com
    * mensagem de erro) permanecem corretos, pois Salvar()/Excluir() nunca
    * sao acionados por este form.
    *==========================================================================

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - chave do movimento efetivado por GerarPedido(),
    * usada por RegistrarAuditoria(). EmpDopNums (Emps+Dopes+Str(Numes,6)) eh
    * a mesma chave composta de SigMvCab.
    *
    * PROTECTED porque o metodo da base tambem eh PROTECTED - subclasse nao
    * alarga escopo de hook herdado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.MontarChaveEmpDopNums(THIS.this_cGerEmps, THIS.this_cGerDopes, THIS.this_nGerNumes)
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarChaveEmpDopNums - monta a chave posicional EmpDopNums char(29) =
    * Emps char(3) + Dopes char(20) + Str(Numes,6) usada por SigMvCab/
    * SigMvItn/SigMvIts/SigMvPec/SigInBep.
    *
    * A chave eh POSICIONAL: o padding faz parte dela. As partes vao com
    * PADR na largura EXATA da coluna do schema, NUNCA com ALLTRIM - com
    * ALLTRIM nas partes a chave encurta e o SELECT que a compara devolve
    * ZERO linhas em silencio (CLAUDE.md regra #42 / Erro177).
    *--------------------------------------------------------------------------
    PROCEDURE MontarChaveEmpDopNums(par_cEmps, par_cDopes, par_nNumes)
        RETURN PADR(NVL(par_cEmps, ""), 3) + ;
               PADR(NVL(par_cDopes, ""), 20) + ;
               STR(NVL(par_nNumes, 0), 6)
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarSQL - SQLEXEC preservando a area de trabalho corrente (o
    * legado chama SqlExecute sem reselecionar depois - SQLEXEC() troca a
    * area selecionada).
    *--------------------------------------------------------------------------
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
            THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + "o!!!" + CHR(13) + ;
                "(" + TRANSFORM(par_cRotulo) + ") " + CapturarErroSQL()
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ConsultarTabela - SELECT * FROM tabela WHERE campo = valor (equivalente
    * a ThisForm.poDataMgr.Cursorquery do legado). Cursor fica ABERTO; com
    * zero linhas, leitura de campo devolve branco (igual ao legado).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ConsultarTabela(par_cTabela, par_cCursor, par_cCampoChave, par_uValorChave)
        LOCAL loc_cValor, loc_nRet, loc_lOk, loc_cAliasAnt

        loc_cAliasAnt = ALIAS()

        DO CASE
            CASE VARTYPE(par_uValorChave) = "N"
                loc_cValor = FormatarNumeroSQL(par_uValorChave, 0)
            CASE VARTYPE(par_uValorChave) = "D" OR VARTYPE(par_uValorChave) = "T"
                loc_cValor = FormatarDataSQL(par_uValorChave)
            OTHERWISE
                loc_cValor = EscaparSQL(ALLTRIM(TratarNulo(par_uValorChave, "")))
        ENDCASE

        IF USED(par_cCursor)
            USE IN (par_cCursor)
        ENDIF

        loc_nRet = SQLEXEC(gnConnHandle, ;
            "SELECT * FROM " + par_cTabela + " WHERE " + par_cCampoChave + " = " + loc_cValor, par_cCursor)

        IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
            SELECT (loc_cAliasAnt)
        ENDIF

        loc_lOk = (loc_nRet >= 0 AND USED(par_cCursor))

        IF !loc_lOk
            THIS.this_cMensagemErro = "Falha ao consultar " + par_cTabela + ":" + CHR(13) + CapturarErroSQL()
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * AbrirCursorTabela - cria (vazio) um cursor READWRITE com a estrutura
    * COMPLETA da tabela informada - garante que PersistirCursor() cubra
    * TODA coluna NOT NULL da tabela destino (CLAUDE.md regra #22), mesmo
    * quando o cursor de origem (csCabec/csItens/csEstPe) nao tem todos os
    * campos da tabela de destino.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION AbrirCursorTabela(par_cCursor, par_cTabela)
        LOCAL loc_nRet, loc_lOk
        loc_lOk = .F.

        IF USED(par_cCursor)
            USE IN (par_cCursor)
        ENDIF
        IF USED("cursor_4c_GstEstrut")
            USE IN cursor_4c_GstEstrut
        ENDIF

        loc_nRet = SQLEXEC(gnConnHandle, "SELECT * FROM " + par_cTabela + " WHERE 1 = 0", "cursor_4c_GstEstrut")

        IF loc_nRet >= 0 AND USED("cursor_4c_GstEstrut")
            SELECT * FROM cursor_4c_GstEstrut WHERE .F. INTO CURSOR (par_cCursor) READWRITE
            USE IN cursor_4c_GstEstrut
            loc_lOk = USED(par_cCursor)
        ENDIF

        IF !loc_lOk
            THIS.this_cMensagemErro = "Falha ao preparar a estrutura de " + par_cTabela + ":" + ;
                CHR(13) + CapturarErroSQL()
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValorSQLDeCampo - formata UM campo do cursor para o VALUES do INSERT,
    * pelo TIPO VFP do campo (nunca por palpite de nome) - helpers canonicos
    * do projeto, que ja devolvem COM aspas.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValorSQLDeCampo(par_cCursor, par_cCampo, par_cTipo, par_nDec)
        LOCAL loc_uValor, loc_cRet

        loc_uValor = EVALUATE(par_cCursor + "." + par_cCampo)

        DO CASE
            CASE par_cTipo $ "CMVQ"
                loc_cRet = EscaparSQL(TratarNulo(loc_uValor, ""))
            CASE par_cTipo $ "NFIBY"
                loc_cRet = FormatarNumeroSQL(TratarNulo(loc_uValor, 0), par_nDec)
            CASE par_cTipo = "L"
                loc_cRet = IIF(TratarNulo(loc_uValor, .F.), "1", "0")
            CASE par_cTipo $ "DT"
                loc_cRet = FormatarDataSQL(TratarNulo(loc_uValor, {}))
            OTHERWISE
                loc_cRet = "NULL"
        ENDCASE

        RETURN loc_cRet
    ENDFUNC

    *--------------------------------------------------------------------------
    * PersistirCursor - grava em par_cTabela, linha a linha, TODAS as colunas
    * do cursor local (que AbrirCursorTabela criou com a estrutura completa
    * da tabela). Cursor vazio/inexistente = sucesso sem efeito (nada a
    * gravar) - equivalente a ThisForm.poDataMgr.UpDate('<cursor>').
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION PersistirCursor(par_cCursor, par_cTabela)
        LOCAL loc_lOk, loc_nI, loc_nCampos, loc_cCols, loc_cVals, loc_cSQL, loc_nRet
        LOCAL ARRAY loc_aCampos[1, 18]

        loc_lOk = .T.

        IF !USED(par_cCursor) OR RECCOUNT(par_cCursor) = 0
            RETURN .T.
        ENDIF

        loc_nCampos = AFIELDS(loc_aCampos, par_cCursor)
        loc_cCols   = ""
        FOR loc_nI = 1 TO loc_nCampos
            loc_cCols = loc_cCols + IIF(loc_nI = 1, "", ", ") + LOWER(ALLTRIM(loc_aCampos[loc_nI, 1]))
        ENDFOR

        SELECT (par_cCursor)
        GO TOP
        SCAN
            loc_cVals = ""
            FOR loc_nI = 1 TO loc_nCampos
                loc_cVals = loc_cVals + IIF(loc_nI = 1, "", ", ") + ;
                    THIS.ValorSQLDeCampo(par_cCursor, ALLTRIM(loc_aCampos[loc_nI, 1]), ;
                        loc_aCampos[loc_nI, 2], loc_aCampos[loc_nI, 4])
            ENDFOR

            loc_cSQL = "INSERT INTO " + par_cTabela + " (" + loc_cCols + ") VALUES (" + loc_cVals + ")"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRet < 0
                THIS.this_cMensagemErro = "Falha ao gravar em " + par_cTabela + ":" + CHR(13) + CapturarErroSQL()
                loc_lOk = .F.
                EXIT
            ENDIF
        ENDSCAN

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarPedido - transcricao de SIGPRGST.gerarpedido (dump do SCX legado,
    * linhas 812-941): efetiva, em SigMvCab/SigMvItn/SigMvIts/SigMvPec/
    * SigInBep, o movimento do pedido CORRENTE de csCabec (linha selecionada
    * na grade do form).
    *
    * csCabec/csItens/csEstPe/CrSigCdNec sao preparados por quem abre esta
    * tela (ver cabecalho do arquivo) - este metodo so os LE pelo nome, como
    * o legado. crSigCdEmb/crSigMvCab/crSigMvItn/crSigMvIts/CrSigMvPec/
    * CrSigInBep/crTmpPro/crTmpGru sao cursores de trabalho LOCAIS, criados
    * e fechados aqui.
    *
    * Se csCabec.Gerado JA estiver preenchido, o legado nao faz nada e
    * devolve sucesso ("If Empty(csCabec.Gerado) ... EndIf / Return llOks") -
    * reproduzido abaixo.
    *--------------------------------------------------------------------------
    FUNCTION GerarPedido()
        LOCAL loc_lOks, loc_oErro, loc_nNum, loc_cMsk, loc_cEmpr, loc_cGerEmps, loc_cGerDopes
        LOCAL loc_cCgrus, loc_cCunis, loc_nTipoEstos, loc_nEmbs, loc_lSub
        LOCAL loc_nMultis, loc_cCodEmbs, loc_cDopps

        loc_lOks = .F.
        THIS.this_cMensagemErro = ""
        THIS.this_lGerado       = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Sem conex" + CHR(227) + "o com o banco de dados."
            RETURN .F.
        ENDIF

        IF !USED("csCabec") OR EOF("csCabec")
            THIS.this_cMensagemErro = "Selecione Um Pedido a Ser Gerado Na Grade e Tente Novamente"
            RETURN .F.
        ENDIF

        *-- "If Empty(csCabec.Gerado) ... EndIf / Return llOks" - ja gerado:
        *-- nada a fazer, sucesso (o legado nunca entra no bloco de geracao)
        IF !EMPTY(TratarNulo(csCabec.Gerado, ""))
            RETURN .T.
        ENDIF

        loc_cEmpr = PADR(go_4c_Sistema.cCodEmpresa, 3)

        TRY
            *-- 1. Carrega SigCdEmb (Cods, Multis) - "Select Cods, Multis From SigCdEmb"
            loc_lOks = THIS.ExecutarSQL("SELECT Cods, Multis FROM SigCdEmb", "crSigCdEmb", "crSigCdEmb")

            IF loc_lOks AND USED("crSigCdEmb")
                SELECT crSigCdEmb
                INDEX ON Cods TAG Cods
                GO TOP
            ENDIF

            *-- 2. Cursores de gravacao, vazios, com a estrutura COMPLETA da
            *-- tabela destino (equivalente ao "Zap In crSigMvCab/..." do
            *-- legado - aqui nascem vazios em vez de serem zerados)
            IF loc_lOks
                loc_lOks = THIS.AbrirCursorTabela("crSigMvCab", "SigMvCab")
            ENDIF
            IF loc_lOks
                loc_lOks = THIS.AbrirCursorTabela("crSigMvItn", "SigMvItn")
            ENDIF
            IF loc_lOks
                loc_lOks = THIS.AbrirCursorTabela("crSigMvIts", "SigMvIts")
            ENDIF
            IF loc_lOks
                loc_lOks = THIS.AbrirCursorTabela("CrSigMvPec", "SigMvPec")
            ENDIF
            IF loc_lOks
                loc_lOks = THIS.AbrirCursorTabela("CrSigInBep", "SigInBep")
            ENDIF

            *-- 3. Numeracao do movimento - "lnNum = fGerUniqueKey(...) / lcMsk = fGerMascara(lnNum)"
            IF loc_lOks
                loc_nNum = fGerUniqueKey(ALLTRIM(csCabec.Dopes) + loc_cEmpr)
                loc_cMsk = ALLTRIM(fGerMascara(loc_nNum))

                IF loc_nNum = 0
                    THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar a numera" + ;
                        CHR(231) + CHR(227) + "o do movimento."
                    loc_lOks = .F.
                ENDIF
            ENDIF

            *-- 4. Cabecalho - "Select csCabec / Scatter Memvar / ... / Insert Into crSigMvCab From Memvar"
            IF loc_lOks
                SELECT csCabec
                SCATTER MEMVAR MEMO
                m.Numes      = loc_nNum
                m.MascNum    = loc_cMsk
                m.Datars     = DATE()
                m.cIdChaves  = fUniqueIds()
                m.EmpDopNums = THIS.MontarChaveEmpDopNums(m.Emps, m.Dopes, loc_nNum)
                IF USED("CrSigCdNec")
                    m.EmpDnPs = TratarNulo(CrSigCdNec.EmpDnPs, "")
                ENDIF

                loc_cGerEmps  = PADR(m.Emps, 3)
                loc_cGerDopes = PADR(m.Dopes, 20)

                INSERT INTO crSigMvCab FROM MEMVAR
                INSERT INTO CrSigInBep FROM MEMVAR

                *-- 5. Itens - "Select csItens / Set Key To csCabec.EmpDopNums / Go Top / Scan ... EndScan"
                IF USED("csItens")
                    SELECT csItens
                    SET KEY TO csCabec.EmpdopNums
                    GO TOP
                    SCAN
                        SELECT csItens
                        SCATTER MEMVAR MEMO
                        m.Numes      = loc_nNum
                        m.cIdChaves  = fUniqueIds()
                        m.EmpDopNums = THIS.MontarChaveEmpDopNums(m.Emps, m.Dopes, loc_nNum)

                        INSERT INTO crSigMvItn FROM MEMVAR

                        loc_cCgrus = ""
                        loc_cCunis = ""
                        IF THIS.ConsultarTabela("SigCdPro", "crTmpPro", "Cpros", ALLTRIM(m.Cpros))
                            IF USED("crTmpPro") AND !EOF("crTmpPro")
                                loc_cCgrus = TratarNulo(crTmpPro.Cgrus, "")
                                loc_cCunis = TratarNulo(crTmpPro.cUnis, "")
                            ENDIF
                        ENDIF

                        loc_nTipoEstos = 0
                        loc_nEmbs      = 0
                        IF !EMPTY(loc_cCgrus) AND ;
                                THIS.ConsultarTabela("SigCdGrp", "crTmpGru", "Cgrus", ALLTRIM(loc_cCgrus))
                            IF USED("crTmpGru") AND !EOF("crTmpGru")
                                loc_nTipoEstos = TratarNulo(crTmpGru.TipoEstos, 0)
                                loc_nEmbs      = TratarNulo(crTmpGru.Embs, 0)
                            ENDIF
                        ENDIF

                        loc_lSub = (INLIST(loc_nTipoEstos, 2, 3, 4) OR loc_nEmbs = 1)

                        IF loc_lSub AND !EMPTY(loc_cCunis)
                            loc_nMultis  = 0
                            loc_cCodEmbs = ""
                            IF USED("crSigCdEmb") AND SEEK(loc_cCunis, "crSigCdEmb", "Cods")
                                loc_nMultis  = TratarNulo(crSigCdEmb.Multis, 0)
                                loc_cCodEmbs = TratarNulo(crSigCdEmb.Cods, "")
                            ENDIF

                            SELECT csItens
                            m.Qtds    = m.Qtds / IIF(loc_nMultis = 0, 1, loc_nMultis)
                            m.CodEmbs = loc_cCodEmbs
                            m.QtdEmbs = loc_nMultis

                            INSERT INTO crSigMvIts FROM MEMVAR
                        ENDIF

                        SELECT csItens
                    ENDSCAN
                    SELECT csItens
                    SET KEY TO
                ENDIF

                *-- 6. Pecas/estoque reservado (CsEstPe) - mesmo padrao do item anterior
                IF USED("csEstPe")
                    SELECT csEstPe
                    SET KEY TO csCabec.EmpdopNums
                    GO TOP
                    SCAN
                        SCATTER MEMVAR MEMO
                        m.Numes      = loc_nNum
                        m.cIdChaves  = fUniqueIds()
                        m.EmpDopNums = THIS.MontarChaveEmpDopNums(m.Emps, m.Dopes, loc_nNum)
                        m.EmpSubNs   = loc_cEmpr

                        INSERT INTO CrSigMvPec FROM MEMVAR

                        SELECT csEstPe
                    ENDSCAN
                    SELECT csEstPe
                    SET KEY TO
                ENDIF

                SELECT csCabec

                *-- "fGravarLog('T', CrSigCdNec.Dopps, 'AUTOMATICO', Emps-Dopes-Numes)" -
                *-- wrapper no-op (ver utils\fgravarlog.prg) - transcrito por fidelidade
                loc_cDopps = IIF(USED("CrSigCdNec"), TratarNulo(CrSigCdNec.Dopps, ""), "")
                = fGravarLog("T", loc_cDopps, "AUTOMATICO", ;
                    ALLTRIM(csCabec.Emps) + "-" + ALLTRIM(csCabec.Dopes) + "-" + ALLTRIM(STR(loc_nNum, 6)))
            ENDIF

            *-- 7. Persiste no SQL Server, dentro da MESMA transacao (equivalente a
            *-- "poDataMgr.UpDate('crSigMvCab') / ... / poDataMgr.Commit()")
            IF loc_lOks
                loc_lOks = THIS.PersistirCursor("crSigMvCab", "SigMvCab")
            ENDIF
            IF loc_lOks
                loc_lOks = THIS.PersistirCursor("crSigMvItn", "SigMvItn")
            ENDIF
            IF loc_lOks
                loc_lOks = THIS.PersistirCursor("crSigMvIts", "SigMvIts")
            ENDIF
            IF loc_lOks
                loc_lOks = THIS.PersistirCursor("CrSigMvPec", "SigMvPec")
            ENDIF
            IF loc_lOks
                loc_lOks = THIS.PersistirCursor("CrSigInBep", "SigInBep")
            ENDIF

            IF loc_lOks
                IF SQLCOMMIT(gnConnHandle) < 1
                    THIS.this_cMensagemErro = "Falha ao confirmar a grava" + CHR(231) + CHR(227) + "o." + ;
                        CHR(13) + CapturarErroSQL()
                    loc_lOks = .F.
                ENDIF
            ENDIF

            IF !loc_lOks
                = SQLROLLBACK(gnConnHandle)
            ELSE
                *-- "Go Top In crSigMvCab / Replace Gerado With 'OK', GerEmps...,
                *-- GerDopes..., GerNumes... In csCabec"
                THIS.this_nNumeroGerado  = loc_nNum
                THIS.this_cMascaraNumero = loc_cMsk
                THIS.this_cGerEmps       = loc_cGerEmps
                THIS.this_cGerDopes      = loc_cGerDopes
                THIS.this_nGerNumes      = loc_nNum
                THIS.this_lGerado        = .T.

                SELECT csCabec
                REPLACE Gerado   WITH "OK", ;
                        GerEmps  WITH loc_cGerEmps, ;
                        GerDopes WITH loc_cGerDopes, ;
                        GerNumes WITH loc_nNum

                THIS.RegistrarAuditoria("GERAR")
            ENDIF

        CATCH TO loc_oErro
            = SQLROLLBACK(gnConnHandle)
            THIS.this_cMensagemErro = loc_oErro.Message + " [Ln:" + TRANSFORM(loc_oErro.LineNo) + ;
                " / " + TRANSFORM(loc_oErro.Procedure) + "]"
            MsgErro(THIS.this_cMensagemErro, "SigPrGstBO.GerarPedido")
            loc_lOks = .F.
        ENDTRY

        *-- Fecha cursores de trabalho locais
        IF USED("crSigCdEmb")
            USE IN crSigCdEmb
        ENDIF
        IF USED("crSigMvCab")
            USE IN crSigMvCab
        ENDIF
        IF USED("crSigMvItn")
            USE IN crSigMvItn
        ENDIF
        IF USED("crSigMvIts")
            USE IN crSigMvIts
        ENDIF
        IF USED("CrSigMvPec")
            USE IN CrSigMvPec
        ENDIF
        IF USED("CrSigInBep")
            USE IN CrSigInBep
        ENDIF
        IF USED("crTmpPro")
            USE IN crTmpPro
        ENDIF
        IF USED("crTmpGru")
            USE IN crTmpGru
        ENDIF

        RETURN loc_lOks
    ENDFUNC

ENDDEFINE
