*====================================================================
* SigOpAutBO.prg
*
* Business Object do dialogo OPERACIONAL "SIGOPAUT" (Autenticacao de
* comprovantes de pagamento/cheque na impressora fiscal ou na
* impressora de cheque via porta serial/OLE).
*
* O legado abre este form como filho MODAL de outro form (Lparameters
* poform, _pEmps, _pDopes, _pNumes, _pTipo, _pnAutentica), monta um
* cursor LOCAL (csPgto: Marca L, Obs C(27), Fpags C(12), Printed L,
* Autenticas N(1)) a partir de SigMvPar (pagamentos) ou SigMvPec
* (parcelas), conforme _pTipo, e deixa o usuario marcar/autenticar
* cada linha antes de liberar o caixa.
*
* Nao existe uma unica tabela "mestre" - a origem dos dados depende do
* tipo de movimento (_pTipo): SigMvPar quando .F., SigMvPec quando .T.
* THIS.this_cTabela acompanha essa escolha (AtualizarTabelaOrigem).
*
* Referencias legado -> BO:
*   Thisform.toSeek       -> this_cToSeek      (EmpDopNums posicional)
*   Thisform.Primeiravez  -> this_lPrimeiraVez
*   Thisform.tpAutentica  -> this_nTipoAutentica (= Lparameters _pnAutentica)
*   csPgto (cursor local) -> this_cCursorPagamentos ("cursor_4c_Pagamentos")
*
* Thisform.oModem e Thisform.ParentForm permanecem no FORM (sao
* referencias a objetos de UI/OLE do form pai, fora da responsabilidade
* do Business Object).
*
* Herda de: BusinessBase
*
* Fase 2/8 - Nao ha INSERT/UPDATE/DELETE no legado deste dialogo: o unico
* codigo-fonte (Init/autentica/Sair.Click/Fwbtnm1.Click, ver
* tasks\task644\comportamento.json) so CONSULTA SigMvPar/SigMvPec/SigOpFp/
* SigCdOpe/SigMvCab (CursorQuery) e grava no CURSOR LOCAL csPgto (Replace
* marca/Printed) ou na porta serial/impressora fiscal (ImpVerso/Autentica/
* ReAutentica, via ThisForm.oModem) - nunca num INSERT/UPDATE em tabela.
* Por isso Inserir()/Atualizar()/ExecutarExclusao() permanecem SEM
* override: o comportamento padrao herdado de BusinessBase (recusar a
* operacao) ja eh o correto - inventar SQL de gravacao aqui violaria a
* regra de que a lista de colunas vem do schema/legado, nunca de
* suposicao, e este dialogo nunca grava em tabela nenhuma.
*
* Completado em: Fase 2 - PopularCursorPagamentos()/CarregarDoCursor()/
* ObterTextoAutenticacao()/ZerarSeNaoRequerAutenticacao()/
* ExisteLinhaNaoAutenticada()/MarcarLinhaAutenticada()/
* ObterChavePrimaria()
*====================================================================

DEFINE CLASS SigOpAutBO AS BusinessBase

    *-- Parametros recebidos na abertura do dialogo (legado: Lparameters
    *-- poform, _pEmps, _pDopes, _pNumes, _pTipo, _pnAutentica)
    this_cEmps             = ""    && Empresa (SigMvPar.emps / SigMvPec.emps)
    this_cDopes            = ""    && Documento de Operacao (SigCdOpe.dopes)
    this_nNumes            = 0     && Numero do movimento (SigMvPar.numes / SigMvPec.numes)
    this_lTipoPec          = .F.   && .T. = consulta SigMvPec (parcela) / .F. = consulta SigMvPar (pagamento) - legado "_pTipo"
    this_nTipoAutentica    = 0     && Tipo de autenticacao solicitada - legado "_pnAutentica"/"tpAutentica" (1 = impressora fiscal/cheque)

    *-- Estado de controle equivalente ao do form legado
    this_cToSeek           = ""    && Chave posicional EmpDopNums = PADR(Emps,3)+PADR(Dopes,20)+STR(Numes,6) - legado "toSeek"
    this_lPrimeiraVez      = .T.   && Controla a reautenticacao na 1a chamada a impressora fiscal - legado "Primeiravez"
    this_lTemAutentica     = .F.   && Espelha ParentForm.TemAutentica (config exige autenticar antes de liberar)
    this_cObservacao       = ""    && Texto digitado em TxtObs, impresso junto da autenticacao

    *-- Cursor de trabalho (equivalente ao csPgto local do legado:
    *-- Marca L, Obs C(27), Fpags C(12), Printed L, Autenticas N(1))
    this_cCursorPagamentos = "cursor_4c_Pagamentos"
    this_nTotalPagamentos  = 0     && RECCOUNT() do cursor apos PopularCursorPagamentos()

    *-- Espelham a linha ATUAL de this_cCursorPagamentos (carregados por
    *-- CarregarDoCursor) - mesmos nomes/tipos das colunas do csPgto legado
    this_lLinhaMarca       = .F.   && Marca (L) - linha selecionada para autenticar
    this_cLinhaObs         = ""    && Obs (C(27)) - texto exibido na coluna 2 do Grd
    this_cLinhaFpags       = ""    && Fpags (C(12)) - forma de pagamento/codigo da parcela
    this_lLinhaImpressa    = .F.   && Printed (L) - .T. apos autenticar com sucesso
    this_nLinhaAutenticas  = 0     && Autenticas (N(1)) - tipo exigido por SigOpFp/SigCdOpe

    *-- Configuracao da porta serial da impressora de cheque (legado:
    *-- crTmpCfCom.Portas/Settings, lido de SigSyCom - ver
    *-- ObterConfigPortaCheque) - consumidos por FormSigOpAut.Autentica()
    this_nPortaCheque      = 0     && SigSyCom.Portas (WHERE Tipos = 'Impressora de Cheque')
    this_cSettingsCheque   = ""    && SigSyCom.Settings (mesma linha)

    *--------------------------------------------------------------------------
    * INIT - Construtor
    * Parametros equivalentes ao Lparameters poform, _pEmps, _pDopes, _pNumes,
    * _pTipo, _pnAutentica do Init do form legado - o form migrado repassa so
    * os valores escalares; poform/oModem (objetos de UI) ficam no Form.
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cEmps, par_cDopes, par_nNumes, par_lTipoPec, par_nTipoAutentica)
        DODEFAULT("SigMvPar")

        THIS.this_cCampoChave = "cidchaves"

        IF VARTYPE(par_cEmps) = "C"
            THIS.this_cEmps = par_cEmps
        ENDIF

        IF VARTYPE(par_cDopes) = "C"
            THIS.this_cDopes = par_cDopes
        ENDIF

        IF VARTYPE(par_nNumes) = "N"
            THIS.this_nNumes = par_nNumes
        ENDIF

        IF VARTYPE(par_nTipoAutentica) = "N"
            THIS.this_nTipoAutentica = par_nTipoAutentica
        ENDIF

        THIS.this_lPrimeiraVez = .T.

        THIS.AtualizarTabelaOrigem(IIF(VARTYPE(par_lTipoPec) = "L", par_lTipoPec, .F.))
        THIS.AtualizarChaveBusca()

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarChaveBusca - Recalcula this_cToSeek (legado "toSeek") a partir
    * de Emps/Dopes/Numes. Chave POSICIONAL (regra CLAUDE.md #42): PADR
    * explicito em cada parte, NUNCA ALLTRIM - o padding faz parte da chave e
    * eh o que casa com a coluna EmpDopNums char(29) de SigMvPar/SigMvPec/
    * SigMvCab (emps char(3) + dopes char(20) + Str(numes,6) = 29).
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarChaveBusca()
        THIS.this_cToSeek = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)
        RETURN THIS.this_cToSeek
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarTabelaOrigem - Define a tabela de origem conforme o tipo de
    * movimento (legado SIGOPAUT.Init: "If Not _pTipo" consulta SigMvPar/
    * pagamentos; senao consulta SigMvPec/parcelas). A chave de filtro nos
    * dois casos eh EmpDopNums (this_cToSeek), a chave primaria eh cidchaves.
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarTabelaOrigem(par_lTipoPec)
        IF VARTYPE(par_lTipoPec) != "L"
            RETURN .F.
        ENDIF

        THIS.this_lTipoPec = par_lTipoPec

        IF THIS.this_lTipoPec
            THIS.this_cTabela = "SigMvPec"
        ELSE
            THIS.this_cTabela = "SigMvPar"
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Este dialogo nao edita uma unica linha de uma
    * unica tabela (regra PROTECTED/BusinessBase #51): opera sobre VARIAS
    * linhas de SigMvPar/SigMvPec, todas sob o mesmo EmpDopNums. A chave
    * mais proxima de "registro em edicao" eh essa chave posicional - fica
    * disponivel so por completude de contrato (RegistrarAuditoria nunca eh
    * chamado, porque Inserir/Atualizar nao sao sobrescritos).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cToSeek)
    ENDPROC

    *--------------------------------------------------------------------------
    * PopularCursorPagamentos - Equivalente ao bloco de consulta do Init()
    * legado: (re)cria this_cCursorPagamentos (csPgto: Marca L, Obs C(27),
    * Fpags C(12), Printed L, Autenticas N(1)) e popula a partir de
    * SigMvPar (this_lTipoPec = .F.) ou SigMvPec (this_lTipoPec = .T.),
    * filtrando por EmpDopNums = this_cToSeek e por this_nTipoAutentica.
    *
    * Fica de fora (responsabilidade do FORM, que tem ParentForm/oModem):
    * - fLerFiscal()/CrSigFiFis (config de impressora fiscal - funcao
    *   global legado nao portada, ver ZerarSeNaoRequerAutenticacao abaixo)
    * - qualquer comunicacao com hardware (porta serial, impressora)
    *--------------------------------------------------------------------------
    FUNCTION PopularCursorPagamentos()
        LOCAL loc_lResultado, loc_nResultado, loc_nAutenticasFpg, loc_nAutenticasOpe
        LOCAL loc_cObs, loc_cFpags, loc_cCodigos10, loc_nDope, loc_nNume, loc_lPular
        loc_lResultado = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        THIS.AtualizarChaveBusca()

        TRY
            IF USED(THIS.this_cCursorPagamentos)
                USE IN (THIS.this_cCursorPagamentos)
            ENDIF
            CREATE CURSOR (THIS.this_cCursorPagamentos) (Marca L, Obs C(27), Fpags C(12), Printed L, Autenticas N(1))

            IF !THIS.this_lTipoPec

                *-- Legado: CursorQuery('SigMvPar','CrTmpPar','EmpDopNums',lcEDN)
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT Fpags, NCarnes, Outros " + ;
                    "FROM SigMvPar " + ;
                    "WHERE EmpDopNums = " + EscaparSQL(THIS.this_cToSeek), ;
                    "cursor_4c_SigOpAut_Par")

                IF loc_nResultado >= 0 AND USED("cursor_4c_SigOpAut_Par")
                    SELECT cursor_4c_SigOpAut_Par
                    SCAN
                        *-- Legado: CursorQuery('SigOpFp','CrTmpFpag','Fpags',CrTmpPar.Fpags)
                        *-- And InList(CrTmpFpag.Autenticas,1,3)
                        IF USED("cursor_4c_SigOpAut_Fpg")
                            USE IN cursor_4c_SigOpAut_Fpg
                        ENDIF
                        SQLEXEC(gnConnHandle, ;
                            "SELECT Autenticas FROM SigOpFp WHERE Fpags = " + EscaparSQL(ALLTRIM(cursor_4c_SigOpAut_Par.Fpags)), ;
                            "cursor_4c_SigOpAut_Fpg")

                        IF USED("cursor_4c_SigOpAut_Fpg") AND RECCOUNT("cursor_4c_SigOpAut_Fpg") > 0 ;
                                AND INLIST(cursor_4c_SigOpAut_Fpg.Autenticas, 1, 3)

                            loc_nAutenticasFpg = cursor_4c_SigOpAut_Fpg.Autenticas

                            *-- Legado: If _pnAutentica > 0 And _pnAutentica # m.Autenticas / Loop
                            IF THIS.this_nTipoAutentica <= 0 OR THIS.this_nTipoAutentica = loc_nAutenticasFpg
                                *-- Legado: Padr(Iif(!IsEmpty(NCarnes),'# '+Alltrim(NCarnes)+Iif(!IsEmpty(Outros),'; ',''),'')+Outros,40)
                                loc_cObs = PADR(IIF(!EMPTY(cursor_4c_SigOpAut_Par.NCarnes), ;
                                    "# " + ALLTRIM(cursor_4c_SigOpAut_Par.NCarnes) + ;
                                    IIF(!EMPTY(cursor_4c_SigOpAut_Par.Outros), "; ", ""), "") + ;
                                    cursor_4c_SigOpAut_Par.Outros, 40)

                                SELECT (THIS.this_cCursorPagamentos)
                                APPEND BLANK
                                REPLACE Marca WITH .T., ;
                                    Obs WITH loc_cObs, ;
                                    Fpags WITH cursor_4c_SigOpAut_Par.Fpags, ;
                                    Printed WITH .F., ;
                                    Autenticas WITH loc_nAutenticasFpg
                            ENDIF
                        ENDIF

                        SELECT cursor_4c_SigOpAut_Par
                    ENDSCAN
                ENDIF

                IF USED("cursor_4c_SigOpAut_Fpg")
                    USE IN cursor_4c_SigOpAut_Fpg
                ENDIF
                IF USED("cursor_4c_SigOpAut_Par")
                    USE IN cursor_4c_SigOpAut_Par
                ENDIF

            ELSE

                *-- Legado: CursorQuery('SigCdOpe','CrTmpOpe','Dopes',_pDopes,[Autenticas])
                SQLEXEC(gnConnHandle, ;
                    "SELECT Autenticas FROM SigCdOpe WHERE Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cDopes)), ;
                    "cursor_4c_SigOpAut_Ope")
                loc_nAutenticasOpe = IIF(USED("cursor_4c_SigOpAut_Ope") AND RECCOUNT("cursor_4c_SigOpAut_Ope") > 0, ;
                    cursor_4c_SigOpAut_Ope.Autenticas, 0)

                *-- Legado: CursorQuery('SigMvPec','CrTmpEstPe','EmpDopNums',lcEDN)
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT Codigos FROM SigMvPec WHERE EmpDopNums = " + EscaparSQL(THIS.this_cToSeek), ;
                    "cursor_4c_SigOpAut_Pec")

                IF loc_nResultado >= 0 AND USED("cursor_4c_SigOpAut_Pec")
                    SELECT cursor_4c_SigOpAut_Pec
                    SCAN
                        *-- Legado: _nDope = Val(Left(Str(Codigos,10),4)) / _nNume = Val(Right(Str(Codigos,10),6))
                        loc_cCodigos10 = cursor_4c_SigOpAut_Pec.Codigos
                        loc_nDope = VAL(LEFT(loc_cCodigos10, 4))
                        loc_nNume = VAL(RIGHT(loc_cCodigos10, 6))

                        *-- Legado: CursorQuery('SigCdOpe','CrTmpOpe2','ndopes',_ndope,[Dopes,CupFis])
                        IF USED("cursor_4c_SigOpAut_Ope2")
                            USE IN cursor_4c_SigOpAut_Ope2
                        ENDIF
                        SQLEXEC(gnConnHandle, ;
                            "SELECT Dopes, CupFis FROM SigCdOpe WHERE Ndopes = " + FormatarNumeroSQL(loc_nDope, 0), ;
                            "cursor_4c_SigOpAut_Ope2")

                        IF USED("cursor_4c_SigOpAut_Ope2") AND RECCOUNT("cursor_4c_SigOpAut_Ope2") > 0
                            loc_lPular = .F.

                            *-- Legado: If ( _pnAutentica>0 And _pnAutentica#m.Autenticas ) Or InList(CrTmpOpe2.CupFis,1,3) / Loop
                            IF THIS.this_nTipoAutentica > 0 AND THIS.this_nTipoAutentica != loc_nAutenticasOpe
                                loc_lPular = .T.
                            ENDIF
                            IF !loc_lPular AND INLIST(cursor_4c_SigOpAut_Ope2.CupFis, 1, 3)
                                loc_lPular = .T.
                            ENDIF

                            IF !loc_lPular
                                *-- Legado: m.Obs = CrTmpOpe2.dopes+' '+Str(_nNume,6) / m.Fpags = Str(CrTmpEstPe.Codigos)
                                loc_cObs   = ALLTRIM(cursor_4c_SigOpAut_Ope2.Dopes) + " " + STR(loc_nNume, 6)
                                loc_cFpags = STR(cursor_4c_SigOpAut_Pec.Codigos)

                                SELECT (THIS.this_cCursorPagamentos)
                                APPEND BLANK
                                REPLACE Marca WITH .T., ;
                                    Obs WITH loc_cObs, ;
                                    Fpags WITH loc_cFpags, ;
                                    Printed WITH .F., ;
                                    Autenticas WITH loc_nAutenticasOpe
                            ENDIF
                        ENDIF

                        SELECT cursor_4c_SigOpAut_Pec
                    ENDSCAN
                ENDIF

                IF USED("cursor_4c_SigOpAut_Ope2")
                    USE IN cursor_4c_SigOpAut_Ope2
                ENDIF
                IF USED("cursor_4c_SigOpAut_Pec")
                    USE IN cursor_4c_SigOpAut_Pec
                ENDIF
                IF USED("cursor_4c_SigOpAut_Ope")
                    USE IN cursor_4c_SigOpAut_Ope
                ENDIF

            ENDIF

            SELECT (THIS.this_cCursorPagamentos)
            GO TOP
            THIS.this_nTotalPagamentos = RECCOUNT(THIS.this_cCursorPagamentos)
            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao buscar pagamentos/parcelas pendentes de autentica" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ZerarSeNaoRequerAutenticacao - Legado (Init, apos popular csPgto):
    *   If ( Alltrim(CrSigFiFis.Imps)='DARUMA' And _PnAutentica=1 ) Or
    *      (_PnAutentica<>1 And Not ThisForm.ParentForm.TemAutentica )
    *       Zap
    *   EndIf
    * CrSigFiFis.Imps (modelo da impressora fiscal) vem de fLerFiscal(),
    * funcao global do Fortyus NAO portada (config de hardware) - por isso
    * o modelo e o this_lTemAutentica (regra do form pai) sao recebidos
    * como parametro/property, em vez de consultados aqui.
    *--------------------------------------------------------------------------
    PROCEDURE ZerarSeNaoRequerAutenticacao(par_cModeloImpressora)
        LOCAL loc_lZerar
        loc_lZerar = .F.

        IF (UPPER(ALLTRIM(NVL(par_cModeloImpressora, ""))) = "DARUMA" AND THIS.this_nTipoAutentica = 1) ;
                OR (THIS.this_nTipoAutentica != 1 AND !THIS.this_lTemAutentica)
            loc_lZerar = .T.
        ENDIF

        IF loc_lZerar AND USED(THIS.this_cCursorPagamentos)
            SELECT (THIS.this_cCursorPagamentos)
            ZAP
            THIS.this_nTotalPagamentos = 0
        ENDIF

        RETURN loc_lZerar
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega a LINHA ATUAL de this_cCursorPagamentos
    * (ou de outro alias/cursor com a mesma estrutura) para as properties
    * this_lLinha*/this_cLinha*/this_nLinha* (regra CLAUDE.md #9: SELECT
    * antes de acessar campo, nunca campo).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            IF !EOF()
                THIS.this_lLinhaMarca      = TratarNulo(Marca, .F.)
                THIS.this_cLinhaObs        = TratarNulo(Obs, "")
                THIS.this_cLinhaFpags      = TratarNulo(Fpags, "")
                THIS.this_lLinhaImpressa   = TratarNulo(Printed, .F.)
                THIS.this_nLinhaAutenticas = TratarNulo(Autenticas, 0)
                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarLinhaAutenticada - Legado (Fwbtnm1.Click, apos Autentica() = .T.):
    *   Replace csPgto.marca with .f., csPgto.Printed with .t.
    * Opera sobre a linha ATUAL de this_cCursorPagamentos.
    *--------------------------------------------------------------------------
    PROCEDURE MarcarLinhaAutenticada()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(THIS.this_cCursorPagamentos)
            SELECT (THIS.this_cCursorPagamentos)
            IF !EOF()
                REPLACE Marca WITH .F., Printed WITH .T.
                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExisteLinhaNaoAutenticada - Legado (Sair.Click):
    *   Scan / if !(csPgto.Printed) / MessageBox('Autenticacao Obrigatoria') / Return
    * O form chama este metodo antes de liberar o Encerrar/Sair; a mensagem
    * (MsgAviso) e o foco na grade (Grd.Column1.SetFocus) ficam no FORM.
    *--------------------------------------------------------------------------
    FUNCTION ExisteLinhaNaoAutenticada()
        LOCAL loc_lPendente
        loc_lPendente = .F.

        IF USED(THIS.this_cCursorPagamentos)
            SELECT (THIS.this_cCursorPagamentos)
            LOCATE FOR !Printed
            loc_lPendente = FOUND()
        ENDIF

        RETURN loc_lPendente
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterTextoAutenticacao - Parte SQL/texto do metodo "autentica" legado
    * (a comunicacao com a impressora/porta serial fica no FORM, que detem
    * ThisForm.oModem/OleComm):
    *   If CursorQuery('SigMvCab','CrTprMvCab','EmpDopNums',toSeek)
    *       _autVal = Padc(DTOC(Date())+"-"+Time()+" - "+Left(ecfs,3)+" - "+notas,60," ")
    *   Else
    *       _autVal = Padc(DTOC(Date())+"-"+Time(),60," ")
    *   EndIf
    *--------------------------------------------------------------------------
    FUNCTION ObterTextoAutenticacao()
        LOCAL loc_cTexto, loc_nResultado

        loc_cTexto = PADC(DTOC(DATE()) + "-" + TIME(), 60, " ")

        IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0 AND !EMPTY(THIS.this_cToSeek)
            TRY
                IF USED("cursor_4c_SigOpAut_Cab")
                    USE IN cursor_4c_SigOpAut_Cab
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT Ecfs, Notas FROM SigMvCab WHERE EmpDopNums = " + EscaparSQL(THIS.this_cToSeek), ;
                    "cursor_4c_SigOpAut_Cab")

                IF loc_nResultado >= 0 AND USED("cursor_4c_SigOpAut_Cab") AND RECCOUNT("cursor_4c_SigOpAut_Cab") > 0
                    loc_cTexto = PADC(DTOC(DATE()) + "-" + TIME() + " - " + ;
                        LEFT(ALLTRIM(cursor_4c_SigOpAut_Cab.Ecfs), 3) + " - " + ;
                        ALLTRIM(cursor_4c_SigOpAut_Cab.Notas), 60, " ")
                ENDIF

                IF USED("cursor_4c_SigOpAut_Cab")
                    USE IN cursor_4c_SigOpAut_Cab
                ENDIF
            CATCH TO loc_oErro
                loc_cTexto = PADC(DTOC(DATE()) + "-" + TIME(), 60, " ")
            ENDTRY
        ENDIF

        RETURN loc_cTexto
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterTipoImpressaoCheque - Legado (autentica, ramo impressora de
    * cheque):
    *   =ThisForm.parentform.PodataMgr.CursorQuery('SigCdPam','CrTmpParam',.f.,.f.,[ImpCheqs])
    * SigCdPam eh tabela de parametros unica do sistema (1 so registro) -
    * sem filtro, le a unica linha.
    *--------------------------------------------------------------------------
    FUNCTION ObterTipoImpressaoCheque()
        LOCAL loc_nResultado, loc_nValor, loc_oErro
        loc_nValor = 0

        IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
            TRY
                IF USED("cursor_4c_SigOpAut_Pam")
                    USE IN cursor_4c_SigOpAut_Pam
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, "SELECT ImpCheqs FROM SigCdPam", "cursor_4c_SigOpAut_Pam")

                IF loc_nResultado >= 0 AND USED("cursor_4c_SigOpAut_Pam") AND RECCOUNT("cursor_4c_SigOpAut_Pam") > 0
                    loc_nValor = NVL(cursor_4c_SigOpAut_Pam.ImpCheqs, 0)
                ENDIF

                IF USED("cursor_4c_SigOpAut_Pam")
                    USE IN cursor_4c_SigOpAut_Pam
                ENDIF
            CATCH TO loc_oErro
                loc_nValor = 0
            ENDTRY
        ENDIF

        RETURN loc_nValor
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterConfigPortaCheque - Legado:
    *   Select * From crSigSyCom Where Tipos = 'Impressora de Cheque' Into Cursor CrTmpCfCom
    * crSigSyCom vinha pre-carregado por fLerSettings() (funcao global do
    * Fortyus NAO portada - config de hardware); como SigSyCom tambem
    * existe como tabela do banco com as MESMAS colunas (Tipos/Portas/
    * Settings - ver docs/schema.sql), a consulta eh feita direto por
    * SQLEXEC, substituindo fLerSettings() + o filtro local em UM passo.
    *--------------------------------------------------------------------------
    FUNCTION ObterConfigPortaCheque()
        LOCAL loc_nResultado, loc_lResultado, loc_oErro
        loc_lResultado = .F.
        THIS.this_nPortaCheque    = 0
        THIS.this_cSettingsCheque = ""

        IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
            TRY
                IF USED("cursor_4c_SigOpAut_Com")
                    USE IN cursor_4c_SigOpAut_Com
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT Portas, Settings FROM SigSyCom WHERE Tipos = " + EscaparSQL("Impressora de Cheque"), ;
                    "cursor_4c_SigOpAut_Com")

                IF loc_nResultado >= 0 AND USED("cursor_4c_SigOpAut_Com") AND RECCOUNT("cursor_4c_SigOpAut_Com") > 0
                    SELECT cursor_4c_SigOpAut_Com
                    GO TOP
                    THIS.this_nPortaCheque    = NVL(Portas, 0)
                    THIS.this_cSettingsCheque = ALLTRIM(NVL(Settings, ""))
                    loc_lResultado = .T.
                ENDIF

                IF USED("cursor_4c_SigOpAut_Com")
                    USE IN cursor_4c_SigOpAut_Com
                ENDIF
            CATCH TO loc_oErro
                loc_lResultado = .F.
            ENDTRY
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterModeloInternoPorNumeroFabricacao - Legado:
    *   ThisForm.ParentForm.poDataMgr.SqlExecute([Select cModelos From
    *       SigFiMpF Where cImpFabs = '] + fDecriptografar(lcNoSerie) + ['], [crTmpImpF])
    *   lcModelo = crTmpImpF.cModelos
    * Quando o numero de fabricacao nao identifica nenhuma impressora
    * (leitura/decriptacao de hardware indisponivel neste acervo - ver
    * utils\leiturafab.prg/fdecriptografar.prg), o legado cai em
    * Space(10), que nunca casa com 'MP-7000 TH FI' - mesmo default aqui.
    *--------------------------------------------------------------------------
    FUNCTION ObterModeloInternoPorNumeroFabricacao(par_cNoFabReal)
        LOCAL loc_cModelo, loc_nResultado, loc_oErro
        loc_cModelo = SPACE(10)

        IF !EMPTY(par_cNoFabReal) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
            TRY
                IF USED("cursor_4c_SigOpAut_MpF")
                    USE IN cursor_4c_SigOpAut_MpF
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT cModelos FROM SigFiMpF WHERE cImpFabs = " + EscaparSQL(ALLTRIM(par_cNoFabReal)), ;
                    "cursor_4c_SigOpAut_MpF")

                IF loc_nResultado >= 0 AND USED("cursor_4c_SigOpAut_MpF") AND RECCOUNT("cursor_4c_SigOpAut_MpF") > 0
                    loc_cModelo = NVL(cursor_4c_SigOpAut_MpF.cModelos, SPACE(10))
                ENDIF

                IF USED("cursor_4c_SigOpAut_MpF")
                    USE IN cursor_4c_SigOpAut_MpF
                ENDIF
            CATCH TO loc_oErro
                loc_cModelo = SPACE(10)
            ENDTRY
        ENDIF

        RETURN loc_cModelo
    ENDFUNC

ENDDEFINE
