*------------------------------------------------------------------------------
* SigOpCgrBO - Business Object para FormSigOpCgr
* Dialogo operacional de "Pesquisa Global de Rastreabilidade": o usuario
* informa UM dos tres criterios (N. Op, Envelope ou Pedido/Numero), o BO
* monta a lista de produtos envolvidos naquele lote (tabela SigPdMvf,
* cruzada com a picagem de SigOpPic e a lista de operacoes de SigCdOpe) e
* o form exibe o resultado numa grade. A partir de uma linha do resultado,
* o usuario abre o relatorio SigReCgr (rastreabilidade) filtrado por
* Op/Envelope/Pedido, conforme o modo marcado.
* Migrado de: SIGOPCGR (Framework Fortyus)
*
* Este dialogo nao possui tabela propria persistida (nao ha Inserir/
* Atualizar/Excluir no legado - e so consulta). A tabela "principal" para
* efeito de this_cTabela/this_cCampoChave e SigPdMvf, que e a fonte real
* do resultado (equivalente a dbProduto no legado); SigCdOpe e SigOpPic
* sao consultadas apenas como apoio (lista de operacoes e picagem).
*------------------------------------------------------------------------------
DEFINE CLASS SigOpCgrBO AS BusinessBase

    *-- Criterios de pesquisa (equivalentes aos Get_Op/Get_Env/Get_Pedido/
    *-- Get_Numero do dump legado - o usuario preenche APENAS um dos tres
    *-- grupos: Op, OU Envelope, OU Pedido+Numero)
    this_nOps    = 0
    this_nEnvs   = 0
    this_cPedido = ""
    this_nNumero = 0

    *-- Estado de controle (equivalente a ThisForm.ConsultaExecutada) -
    *-- evita reprocessar a mesma consulta enquanto nenhum criterio mudou
    this_lConsultaExecutada = .F.

    *-- Modo de rastreabilidade escolhido na pagina de resultado
    *-- (equivalente aos Chk_op/chk_Env/Chk_Dop do Container1 do legado -
    *-- define qual chave o Bot_Rastro.Click usa para abrir SigReCgr)
    this_lRastroPorOp      = .F.
    this_lRastroPorEnvelop = .F.
    this_lRastroPorPedido  = .F.

    *-- Linha corrente do resultado (equivalente ao registro atual de
    *-- dbProduto - usado pelo Bot_Rastro.Click e pelas colunas da grade)
    this_nSelNenvs   = 0
    this_nSelNops    = 0
    this_cSelDopNums = ""
    this_cSelCpros   = ""
    this_nSelQtds    = 0
    this_cSelGrupods = ""
    this_cSelContads = ""

    *-- Nomes dos cursores que este BO consome/popula (propriedade para o
    *-- Form referenciar sem repetir literais - padrao sigopagrBO/SigMvSbnBO)
    this_cCursorOperacoes = "cursor_4c_Operacoes" && equivalente a TmpOper (SigCdOpe) - lista de operacoes para o lookup do Pedido
    this_cCursorPicagem   = "cursor_4c_Picagem"   && equivalente a crSigOpPic (SigOpPic) - picagem por Op/Envelope/EmpDopNums
    this_cCursorMovimento = "cursor_4c_Movimento" && equivalente a crSigPdMvf (SigPdMvf) - lote/producao por Op ou por EmpDNps
    this_cCursorTopo      = "cursor_4c_Topo"      && equivalente a crTopMfas (SigPdMvf) - top 1 EmpDNps por envelope
    this_cCursorResultado = "cursor_4c_Resultado" && equivalente a dbProduto - grade de resultado exibida na pagina 2

    *-- Mensagem de erro do ultimo ValidarOperacao() (equivalente aos dois
    *-- MessageBox do Get_Op.Valid legado: "Op Nao Cadastrada!!!" / "Op de
    *-- Outra Empresa!!!") - o Form le esta property para exibir o MsgAviso.
    this_cMensagemErroOp = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigPdMvf"
        THIS.this_cCampoChave = "Nops"
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega os dados da linha CORRENTE do cursor de
    * resultado (equivalente ao registro atual de dbProduto no legado) para
    * as properties this_nSel*/this_cSel*. E chamado pelo form ao posicionar
    * o grid de resultado (AfterRowColChange da grade) e antes de
    * Bot_Rastro.Click, que precisa da linha selecionada para montar a
    * chave (Nops/Nenvs/DopNums) usada ao abrir SigReCgr.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        IF USED(par_cAliasCursor) AND !EOF(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_nSelNenvs   = TratarNulo(Nenvs, 0)
            THIS.this_nSelNops    = TratarNulo(Nops, 0)
            THIS.this_cSelDopNums = TratarNulo(DopNums, "")
            THIS.this_cSelCpros   = TratarNulo(Cpros, "")
            THIS.this_nSelQtds    = TratarNulo(Qtds, 0)
            THIS.this_cSelGrupods = TratarNulo(Grupods, "")
            THIS.this_cSelContads = TratarNulo(Contads, "")

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOperacoes - Popula this_cCursorOperacoes (equivalente a TmpOper
    * do PROCEDURE Init legado: Select Dopes, NDopes, Globalizas, Reservas
    * From SigCdOpe Where Globalizas In (1, 2), Index On Dopes Tag Dopes).
    * Usado pelo lookup do campo Pedido (Fase 6): SEEK contra o cursor local
    * + picker FormBuscaAuxiliar.DefinirCursor/Mostrar (Pattern A - regra
    * "FormBuscaAuxiliar Pattern B broken") sobre este MESMO cursor, sem
    * nova consulta SQL - igual ao fwBuscaSel legado, que tambem trabalha
    * em cima do cursor ja carregado.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarOperacoes()
        LOCAL loc_cCursor, loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.
        loc_cCursor  = THIS.this_cCursorOperacoes

        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF

        *-- Modo teste/validacao de UI: sem conexao real de SQL Server -
        *-- SQLEXEC com handle invalido DISPARA excecao (nao devolve -1),
        *-- entao criar o cursor vazio com a MESMA estrutura do TmpOper
        *-- legado, para o SEEK do lookup de Pedido nao estourar "Alias
        *-- CURSOR_4C_OPERACOES is not found".
        IF (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
           (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
            CREATE CURSOR (loc_cCursor) ;
                (Dopes C(20), NDopes N(4, 0), Globalizas N(1, 0), Reservas N(1, 0))
            INDEX ON Dopes TAG Dopes
            RETURN .T.
        ENDIF

        loc_cSQL = "SELECT Dopes, NDopes, Globalizas, Reservas " + ;
                   "FROM SigCdOpe WHERE Globalizas IN (1, 2)"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

        IF loc_nResultado >= 0 AND USED(loc_cCursor)
            SELECT (loc_cCursor)
            INDEX ON Dopes TAG Dopes
            GO TOP
            loc_lSucesso = .T.
        ELSE
            MostrarErro("Favor Reinicializar o Processo!!!", ;
                "Falha na Conex" + CHR(227) + "o (" + loc_cCursor + ")")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarOperacao - Confere se a Op existe em SigOpPic e pertence a
    * empresa corrente (equivalente ao Get_Op.Valid legado: CursorQuery +
    * Eof('crSigOpPic') + crSigOpPic.Emps <> _Empr). Preenche
    * this_cMensagemErroOp quando invalido, para o Form exibir o MsgAviso.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarOperacao(par_nOps)
        LOCAL loc_cCursor, loc_cSQL, loc_nResultado, loc_lValido

        loc_lValido = .F.
        THIS.this_cMensagemErroOp = ""
        loc_cCursor = "cursor_4c_ValOp"

        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF

        loc_cSQL = "SELECT TOP 1 Emps FROM SigOpPic WHERE Nops = " + ;
                   FormatarNumeroSQL(par_nOps, 0)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

        IF loc_nResultado > 0 AND USED(loc_cCursor) AND !EOF(loc_cCursor)
            SELECT (loc_cCursor)
            IF ALLTRIM(Emps) == ALLTRIM(go_4c_Sistema.cCodEmpresa)
                loc_lValido = .T.
            ELSE
                THIS.this_cMensagemErroOp = "Op de Outra Empresa!!!"
            ENDIF
        ELSE
            THIS.this_cMensagemErroOp = "Op N" + CHR(227) + "o Cadastrada!!!"
        ENDIF

        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * Processar - equivalente ao PROCEDURE processa do legado: monta o
    * resultado da pesquisa (this_cCursorResultado) a partir de QUAL dos
    * tres criterios foi preenchido (Op, Envelope ou Pedido+Numero). O
    * guard "If Not Thisform.ConsultaExecutada" do legado fica aqui dentro
    * (nao reprocessa enquanto nenhum criterio mudou - os handlers de
    * LostFocus dos filtros resetam this_lConsultaExecutada no Form).
    *--------------------------------------------------------------------------
    PROCEDURE Processar()
        LOCAL loc_cCursorResultado, loc_lSucesso

        loc_lSucesso          = .T.
        loc_cCursorResultado  = THIS.this_cCursorResultado

        IF !THIS.this_lConsultaExecutada
            *-[ Limpa os Arquivos ]-* (equivalente a "Select DbProduto / Zap")
            IF USED(loc_cCursorResultado)
                SELECT (loc_cCursorResultado)
                ZAP
            ENDIF

            DO CASE
                CASE THIS.this_nOps != 0
                    loc_lSucesso = THIS.ProcessarPorOp()
                CASE THIS.this_nEnvs > 0
                    loc_lSucesso = THIS.ProcessarPorEnvelope()
                OTHERWISE
                    loc_lSucesso = THIS.ProcessarPorPedido()
            ENDCASE

            IF loc_lSucesso
                THIS.this_lConsultaExecutada = .T.
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarPorOp - ramo "If (lnOp <> 0)" do legado: pesquisa a picagem
    * (SigOpPic) da Op informada e, para cada linha, busca o topo de
    * producao (SigPdMvf) correspondente.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ProcessarPorOp()
        LOCAL loc_cCursorPic, loc_cSQL, loc_nResultado, loc_lSucesso
        LOCAL loc_aDopes[1], loc_aNumes[1], loc_aQtds[1], loc_nTotal, loc_nI

        loc_lSucesso   = .T.
        loc_cCursorPic = THIS.this_cCursorPicagem

        IF USED(loc_cCursorPic)
            USE IN (loc_cCursorPic)
        ENDIF

        loc_cSQL = "SELECT Dopes, Numes, Qtds FROM SigOpPic WHERE Nops = " + ;
                   FormatarNumeroSQL(THIS.this_nOps, 0)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorPic)

        IF loc_nResultado < 0
            MostrarErro("Favor Reinicializar o Processo!!!", ;
                "Falha na Conex" + CHR(227) + "o (crSigOpPic)")
            RETURN .F.
        ENDIF

        *-- Snapshot em array ANTES de fechar o cursor: BuscarTopoPorOp faz
        *-- SQLEXEC/SELECT proprios, e um SCAN direto neste cursor perderia
        *-- a posicao corrente quando a funcao chamada troca de workarea.
        loc_nTotal = 0
        IF USED(loc_cCursorPic)
            loc_nTotal = RECCOUNT(loc_cCursorPic)
        ENDIF

        IF loc_nTotal > 0
            DIMENSION loc_aDopes[loc_nTotal]
            DIMENSION loc_aNumes[loc_nTotal]
            DIMENSION loc_aQtds[loc_nTotal]

            SELECT (loc_cCursorPic)
            GO TOP
            FOR loc_nI = 1 TO loc_nTotal
                loc_aDopes[loc_nI] = Dopes
                loc_aNumes[loc_nI] = Numes
                loc_aQtds[loc_nI]  = Qtds
                SKIP
            ENDFOR
        ENDIF

        IF USED(loc_cCursorPic)
            USE IN (loc_cCursorPic)
        ENDIF

        FOR loc_nI = 1 TO loc_nTotal
            IF !THIS.BuscarTopoPorOp(THIS.this_nOps, loc_aDopes[loc_nI], ;
                    loc_aNumes[loc_nI], loc_aQtds[loc_nI], "1")
                loc_lSucesso = .F.
                EXIT
            ENDIF
        ENDFOR

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarPorEnvelope - ramo "If (lnEnv > 0)" do legado: acha o topo
    * de EmpDNps do envelope informado, pesquisa TODAS as linhas de
    * SigPdMvf daquele EmpDNps e, para cada uma, busca a picagem (SigOpPic)
    * da Op correspondente.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ProcessarPorEnvelope()
        LOCAL loc_cCursorTopo, loc_cSQL, loc_nResultado, loc_cChave, loc_lSucesso
        LOCAL loc_cCursorMvf, loc_nTotal, loc_nI
        LOCAL loc_aNops[1], loc_aNenvs[1], loc_aCodPds[1], loc_aGrupods[1], loc_aContads[1]

        loc_lSucesso    = .T.
        loc_cCursorTopo = THIS.this_cCursorTopo

        IF USED(loc_cCursorTopo)
            USE IN (loc_cCursorTopo)
        ENDIF

        loc_cSQL = "SELECT TOP 1 EmpDNps FROM SigPdMvf " + ;
                   "WHERE Nenvs = " + FormatarNumeroSQL(THIS.this_nEnvs, 0) + " " + ;
                   "ORDER BY Nenvs DESC, EmpDNps DESC"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTopo)

        IF loc_nResultado < 0
            MostrarErro("Favor Reinicializar o Processo!!!", ;
                "Falha na Conex" + CHR(227) + "o (crTopMfas)")
            RETURN .F.
        ENDIF

        *-- legado: "If Not Eof()" - sem registro, nao eh erro, simplesmente
        *-- nao ha nada para acrescentar ao resultado.
        IF !USED(loc_cCursorTopo) OR EOF(loc_cCursorTopo)
            IF USED(loc_cCursorTopo)
                USE IN (loc_cCursorTopo)
            ENDIF
            RETURN .T.
        ENDIF

        SELECT (loc_cCursorTopo)
        GO TOP
        loc_cChave = EmpDNps
        USE IN (loc_cCursorTopo)

        loc_cCursorMvf = THIS.this_cCursorMovimento
        IF USED(loc_cCursorMvf)
            USE IN (loc_cCursorMvf)
        ENDIF

        loc_cSQL = "SELECT Nenvs, Nops, CodPds, Grupods, Contads, Emps, Dopps, Numps " + ;
                   "FROM SigPdMvf WHERE EmpDNps = " + EscaparSQL(loc_cChave) + " " + ;
                   "ORDER BY Nenvs, Nops, CodPds, Grupods, Contads, Emps, Dopps, Numps"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorMvf)

        IF loc_nResultado < 0
            MostrarErro("Favor Reinicializar o Processo!!!", ;
                "Falha na Conex" + CHR(227) + "o (crSigPdMvf 2)")
            RETURN .F.
        ENDIF

        loc_nTotal = 0
        IF USED(loc_cCursorMvf)
            loc_nTotal = RECCOUNT(loc_cCursorMvf)
        ENDIF

        IF loc_nTotal > 0
            DIMENSION loc_aNops[loc_nTotal]
            DIMENSION loc_aNenvs[loc_nTotal]
            DIMENSION loc_aCodPds[loc_nTotal]
            DIMENSION loc_aGrupods[loc_nTotal]
            DIMENSION loc_aContads[loc_nTotal]

            SELECT (loc_cCursorMvf)
            GO TOP
            FOR loc_nI = 1 TO loc_nTotal
                loc_aNops[loc_nI]    = Nops
                loc_aNenvs[loc_nI]   = Nenvs
                loc_aCodPds[loc_nI]  = CodPds
                loc_aGrupods[loc_nI] = Grupods
                loc_aContads[loc_nI] = Contads
                SKIP
            ENDFOR
        ENDIF

        IF USED(loc_cCursorMvf)
            USE IN (loc_cCursorMvf)
        ENDIF

        FOR loc_nI = 1 TO loc_nTotal
            IF !THIS.AppendPicagemPorOp(loc_aNops[loc_nI], loc_aNenvs[loc_nI], ;
                    loc_aCodPds[loc_nI], loc_aGrupods[loc_nI], loc_aContads[loc_nI])
                loc_lSucesso = .F.
                EXIT
            ENDIF
        ENDFOR

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarPorPedido - ramo "Else" (nem Op nem Envelope) do legado:
    * monta a chave posicional EmpDopNums (Emps(3)+Dopes(20)+Numero(6) =
    * 29 = SigOpPic.EmpDopNums char(29) - regra CLAUDE.md #42) e pesquisa
    * a picagem direto por ela.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ProcessarPorPedido()
        LOCAL loc_cEDN, loc_cCursorPic, loc_cSQL, loc_nResultado, loc_lSucesso
        LOCAL loc_aNops[1], loc_aDopes[1], loc_aNumes[1], loc_aQtds[1], loc_nTotal, loc_nI

        loc_lSucesso = .T.

        *-- Chave POSICIONAL - PADR explicito nas DUAS partes de largura
        *-- fixa (nunca ALLTRIM, regra CLAUDE.md #42), independente do
        *-- padding que txt_4c_Pedido.Value tenha trazido.
        loc_cEDN = PADR(ALLTRIM(go_4c_Sistema.cCodEmpresa), 3) + ;
                   PADR(THIS.this_cPedido, 20) + ;
                   STR(THIS.this_nNumero, 6)

        loc_cCursorPic = THIS.this_cCursorPicagem
        IF USED(loc_cCursorPic)
            USE IN (loc_cCursorPic)
        ENDIF

        loc_cSQL = "SELECT Nops, Dopes, Numes, Qtds FROM SigOpPic " + ;
                   "WHERE EmpDopNums = " + EscaparSQL(loc_cEDN)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorPic)

        IF loc_nResultado < 0
            MostrarErro("Favor Reinicializar o Processo!!!", ;
                "Falha na Conex" + CHR(227) + "o (crSigOpPic)")
            RETURN .F.
        ENDIF

        loc_nTotal = 0
        IF USED(loc_cCursorPic)
            loc_nTotal = RECCOUNT(loc_cCursorPic)
        ENDIF

        IF loc_nTotal > 0
            DIMENSION loc_aNops[loc_nTotal]
            DIMENSION loc_aDopes[loc_nTotal]
            DIMENSION loc_aNumes[loc_nTotal]
            DIMENSION loc_aQtds[loc_nTotal]

            SELECT (loc_cCursorPic)
            GO TOP
            FOR loc_nI = 1 TO loc_nTotal
                loc_aNops[loc_nI]  = Nops
                loc_aDopes[loc_nI] = Dopes
                loc_aNumes[loc_nI] = Numes
                loc_aQtds[loc_nI]  = Qtds
                SKIP
            ENDFOR
        ENDIF

        IF USED(loc_cCursorPic)
            USE IN (loc_cCursorPic)
        ENDIF

        FOR loc_nI = 1 TO loc_nTotal
            IF !THIS.BuscarTopoPorOp(loc_aNops[loc_nI], loc_aDopes[loc_nI], ;
                    loc_aNumes[loc_nI], loc_aQtds[loc_nI], "3")
                loc_lSucesso = .F.
                EXIT
            ENDIF
        ENDFOR

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarTopoPorOp - equivalente ao "Select Top 1 Nops, Nenvs, CodPds,
    * Grupods, Contads From SigPdMvf Where Nops = ... Order By ... Desc"
    * repetido nos ramos Op e Pedido do legado. par_cContexto reproduz o
    * numero do MessageBox de falha original (crSigPdMvf 1 / 3).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION BuscarTopoPorOp(par_nOps, par_cDopes, par_nNumes, par_nQtds, par_cContexto)
        LOCAL loc_cCursorMvf, loc_cSQL, loc_nResultado
        LOCAL loc_nNenvs, loc_cCodPds, loc_cGrupods, loc_cContads

        loc_cCursorMvf = THIS.this_cCursorMovimento

        IF USED(loc_cCursorMvf)
            USE IN (loc_cCursorMvf)
        ENDIF

        loc_cSQL = "SELECT TOP 1 Nops, Nenvs, CodPds, Grupods, Contads " + ;
                   "FROM SigPdMvf " + ;
                   "WHERE Nops = " + FormatarNumeroSQL(par_nOps, 0) + " " + ;
                   "ORDER BY Nops DESC, Nenvs DESC, CodPds DESC, Grupods DESC, Contads DESC"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorMvf)

        IF loc_nResultado < 0 OR !USED(loc_cCursorMvf) OR EOF(loc_cCursorMvf)
            MostrarErro("Favor Reinicializar o Processo!!!", ;
                "Falha na Conex" + CHR(227) + "o (crSigPdMvf " + par_cContexto + ")")
            IF USED(loc_cCursorMvf)
                USE IN (loc_cCursorMvf)
            ENDIF
            RETURN .F.
        ENDIF

        SELECT (loc_cCursorMvf)
        GO TOP
        loc_nNenvs   = Nenvs
        loc_cCodPds  = CodPds
        loc_cGrupods = Grupods
        loc_cContads = Contads

        USE IN (loc_cCursorMvf)

        THIS.AppendResultado(loc_nNenvs, par_nOps, ;
            par_cDopes + STR(par_nNumes, 6), loc_cCodPds, par_nQtds, loc_cGrupods, loc_cContads)

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * AppendPicagemPorOp - equivalente ao bloco interno do ramo Envelope do
    * legado: "ThisForm.poDataMgr.CursorQuery('SigOpPic', ..., 'Nops', ...)
    * / Scan / Append Blank" - pesquisa a picagem da Op da linha de
    * SigPdMvf corrente e acrescenta UMA linha de resultado por cada linha
    * de picagem encontrada.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION AppendPicagemPorOp(par_nNops, par_nNenvs, par_cCodPds, par_cGrupods, par_cContads)
        LOCAL loc_cCursorPic, loc_cSQL, loc_nResultado
        LOCAL loc_aDopes[1], loc_aNumes[1], loc_aQtds[1], loc_nTotal, loc_nI

        loc_cCursorPic = THIS.this_cCursorPicagem

        IF USED(loc_cCursorPic)
            USE IN (loc_cCursorPic)
        ENDIF

        loc_cSQL = "SELECT Dopes, Numes, Qtds FROM SigOpPic WHERE Nops = " + ;
                   FormatarNumeroSQL(par_nNops, 0)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorPic)

        IF loc_nResultado < 0
            IF USED(loc_cCursorPic)
                USE IN (loc_cCursorPic)
            ENDIF
            RETURN .F.
        ENDIF

        loc_nTotal = 0
        IF USED(loc_cCursorPic)
            loc_nTotal = RECCOUNT(loc_cCursorPic)
        ENDIF

        IF loc_nTotal > 0
            DIMENSION loc_aDopes[loc_nTotal]
            DIMENSION loc_aNumes[loc_nTotal]
            DIMENSION loc_aQtds[loc_nTotal]

            SELECT (loc_cCursorPic)
            GO TOP
            FOR loc_nI = 1 TO loc_nTotal
                loc_aDopes[loc_nI] = Dopes
                loc_aNumes[loc_nI] = Numes
                loc_aQtds[loc_nI]  = Qtds
                SKIP
            ENDFOR
        ENDIF

        IF USED(loc_cCursorPic)
            USE IN (loc_cCursorPic)
        ENDIF

        FOR loc_nI = 1 TO loc_nTotal
            THIS.AppendResultado(par_nNenvs, par_nNops, ;
                loc_aDopes[loc_nI] + STR(loc_aNumes[loc_nI], 6), ;
                par_cCodPds, loc_aQtds[loc_nI], par_cGrupods, par_cContads)
        ENDFOR

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * AppendResultado - equivalente a "Select DbProduto / Append Blank /
    * Replace ..." do legado. Unico ponto de escrita em
    * this_cCursorResultado, usado pelos tres ramos de Processar().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AppendResultado(par_nNenvs, par_nNops, par_cDopNums, par_cCpros, par_nQtds, par_cGrupods, par_cContads)
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_cCursorResultado

        IF !USED(loc_cCursor)
            RETURN
        ENDIF

        SELECT (loc_cCursor)
        APPEND BLANK
        REPLACE Nenvs   WITH TratarNulo(par_nNenvs, 0), ;
                Nops    WITH TratarNulo(par_nNops, 0), ;
                DopNums WITH TratarNulo(par_cDopNums, ""), ;
                Cpros   WITH TratarNulo(par_cCpros, ""), ;
                Qtds    WITH TratarNulo(par_nQtds, 0), ;
                Grupods WITH TratarNulo(par_cGrupods, ""), ;
                Contads WITH TratarNulo(par_cContads, "")
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave que identifica a linha corrente do
    * resultado (nao existe PK de tabela gravavel neste dialogo - ver
    * decisao de projeto abaixo). Usa Nops, o mesmo campo definido como
    * this_cCampoChave no Init, igual ao padrao dos demais BOs.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nSelNops)
    ENDFUNC

    *--------------------------------------------------------------------------
    * Decisao de projeto: BO somente-leitura (sem Inserir/Atualizar/Excluir)
    *--------------------------------------------------------------------------
    * O SIGOPCGR legado e um dialogo de PESQUISA (Pesquisa Global de
    * Rastreabilidade): o unico Create Cursor do Init e dbProduto, que e
    * um cursor LOCAL (nunca gravado no SQL Server), e todo Insert
    * Into/Replace do codigo fonte original tem como alvo esse mesmo
    * cursor local. Nao ha TableUpdate nem AddCursor contra tabela remota
    * em lugar nenhum do dump - as unicas chamadas SqlExecute/CursorQuery
    * do Processa()/Init() sao SELECTs de leitura (SigPdMvf, SigOpPic,
    * SigCdOpe). Por isso este BO nao sobrescreve Inserir(), Atualizar()
    * nem ExecutarExclusao(): o comportamento padrao herdado de
    * BusinessBase (recusar a operacao) ja eh o correto para uma tela que
    * so consulta. CarregarDoCursor() acima e o unico ponto de leitura de
    * linha que este BO precisa, pois alimenta a selecao usada por
    * Bot_Rastro.Click; RegistrarAuditoria() herdado de BusinessBase
    * tambem nao e chamado, porque nao ha Inserir/Atualizar/Excluir que o
    * dispare.
    *--------------------------------------------------------------------------

ENDDEFINE
