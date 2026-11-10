*==============================================================================
* SigOpNchBO.prg - Business Object para SigOpNch (Numeracao de Cheques)
*
* Form OPERACIONAL (SIGOPNCH.SCX, Caption "Numeracao de Cheques"). Nao eh
* cadastro CRUD: lista, numa unica grade editavel, todas as formas de
* pagamento (SigOpFp) do tipo cheque com conta bancaria configurada, mostra
* o PROXIMO numero de cheque de cada conta e grava apenas as linhas que o
* usuario alterou.
*
* Fluxo do legado (reproduzir em fases seguintes):
*   Init do form -> para cada linha de SigOpFp com Infos = 'C' And
*     EmiChqs = 1 And Bancos/Agencias/NContas preenchidos:
*       lcChave = PADR(Bancos + Agencias + NContas, 25)
*       Locate em crAutoriza (SigSySeq) For valor = lcChave
*         achou  -> csCheques.Cheques = crAutoriza.Conteudo + 1
*         nao achou -> csCheques.Cheques = 1
*   btnAlterar.Click (Confirmar) -> Scan csCheques For Marcas (linhas
*     tocadas pelo usuario no Valid da coluna 5):
*       lcChave = PADR(Bancos + Agencias + NContas, 25)
*       Locate em crAutoriza For valor = lcChave
*         achou     -> Replace Conteudo With Cheques - 1
*         nao achou -> Insert Into crAutoriza (Valor, Conteudo) Values
*                      (lcChave, Cheques - 1)
*     Grava tudo numa UNICA transacao (UpDate/Commit/RollBack do poDataMgr).
*
* Tabelas (nomes/colunas conferidos em docs/schema.sql - UTF-16, Get-Content
* -Raw, regra #14 do CLAUDE.md):
*   SigSySeq  valor char(25) PK, conteudo numeric(13,0), digchecks
*             numeric(1,0) NOT NULL. Guarda o ULTIMO numero de cheque
*             emitido (gravado = proximo numero - 1), chave por conta
*             bancaria. digchecks nao aparece em nenhum lugar do codigo
*             legado (nem Init, nem Click) - o Insert do legado so grava
*             Valor/Conteudo porque o cursor crAutoriza (AddCursor) ja tem
*             0 como valor de buffer para a coluna; a Fase 2 precisa gravar
*             esse 0 explicitamente no INSERT para nao violar o NOT NULL.
*   SigOpFp   fpags char(12) PK, bancos char(3), agencias char(4),
*             ncontas char(10), infos char(1), emichqs numeric(1,0).
*             infos = 'C' identifica forma de pagamento tipo Cheque.
*
* Nao sobrescreve Inserir()/Atualizar()/ExecutarExclusao() no sentido CRUD
* classico: a gravacao real (Fase 2) sera um metodo proprio que resolve,
* por chave, update-ou-insert em SigSySeq para cada linha alterada da
* grade - por isso this_cTabela/this_cCampoChave apontam para SigSySeq.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*==============================================================================

DEFINE CLASS SigOpNchBO AS BusinessBase

    *==========================================================================
    * Linha corrente de SigSySeq (crAutoriza no legado) - sequencia generica
    * de "proximo numero". Aqui guarda o ULTIMO cheque emitido por conta
    * bancaria (proximo numero exibido na grade = this_nConteudo + 1).
    *==========================================================================
    this_cValor     = ""   && SigSySeq.valor     char(25) PK - PADR(Bancos+Agencias+NContas,25)
    this_nConteudo  = 0    && SigSySeq.conteudo  numeric(13,0) - ultimo cheque emitido
    this_nDigChecks = 0    && SigSySeq.digchecks numeric(1,0) - nao exibido na tela; grava 0 (default do cursor legado)

    *==========================================================================
    * Linha corrente de SigOpFp (forma de pagamento associada a conta
    * bancaria) - usada para montar a chave acima e exibir Bco./Agencia/Conta
    *==========================================================================
    this_cFPags    = ""    && SigOpFp.fpags    char(12) - codigo da forma de pagamento
    this_cBancos   = ""    && SigOpFp.bancos   char(3)
    this_cAgencias = ""    && SigOpFp.agencias char(4)
    this_cNContas  = ""    && SigOpFp.ncontas  char(10)

    *==========================================================================
    * Proximo numero de cheque editado na grade (csCheques.Cheques no
    * legado) - valor exibido/editado pelo usuario antes de Confirmar.
    * Gravado em SigSySeq.conteudo como this_nProxCheque - 1.
    *==========================================================================
    this_nProxCheque = 0

    *==========================================================================
    * Nomes de cursor usados pelo form (mantidos como property para o Form
    * nao repetir literais - mesmo padrao de SigOpLimBO)
    *==========================================================================
    this_cCursorFormasPagto = "cursor_4c_FormasPagto"  && SigOpFp filtradas (Infos='C' And EmiChqs=1, com conta bancaria)
    this_cCursorAutoriza    = "cursor_4c_Autoriza"     && SigSySeq (crAutoriza no legado)
    this_cCursorCheques     = "cursor_4c_Cheques"      && csCheques no legado - grade editavel (FPags/Bancos/Agencias/NContas/Cheques/Marcas)

    *==========================================================================
    * Init - Configura tabela/chave principal (SigSySeq / crAutoriza)
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            *-- Tabela principal gravada por este BO: sequencia de proximo
            *-- numero de cheque por conta bancaria (crAutoriza no legado)
            THIS.this_cTabela     = "SigSySeq"
            THIS.this_cCampoChave = "valor"

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao inicializar SigOpNchBO")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * MontarChaveConta - Monta a chave POSICIONAL de SigSySeq.valor char(25)
    *
    * Legado (Init e btnAlterar.Click, as DUAS montagens identicas):
    *   lcChave = PADR(Bancos + Agencias + NContas, 25)
    *
    * A chave eh POSICIONAL (regra #42 do CLAUDE.md): o padding de cada coluna
    * char FAZ PARTE da chave. No legado o padding vem de graca porque os
    * valores sao lidos CRUS do cursor (bancos char(3), agencias char(4),
    * ncontas char(10) - todos NOT NULL no schema, logo sempre na largura
    * cheia). Aqui as partes podem chegar de property/parametro JA com ALLTRIM,
    * entao o PADR de cada parte eh OBRIGATORIO - sem ele a chave encurta, o
    * WHERE nao casa e o UPDATE roda SEM ERRO afetando ZERO linha.
    *
    * CONFERENCIA de largura: 3 + 4 + 10 = 17, completado com PADR ate 25 =
    * exatamente a largura de SigSySeq.valor char(25).
    *==========================================================================
    PROCEDURE MontarChaveConta(par_cBancos, par_cAgencias, par_cNContas)
        LOCAL loc_cChave

        loc_cChave = PADR(IIF(VARTYPE(par_cBancos)   = "C", par_cBancos,   ""),  3) + ;
                     PADR(IIF(VARTYPE(par_cAgencias) = "C", par_cAgencias, ""),  4) + ;
                     PADR(IIF(VARTYPE(par_cNContas)  = "C", par_cNContas,  ""), 10)

        RETURN PADR(loc_cChave, 25)
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega a linha corrente de SigSySeq (crAutoriza no
    * legado) nas properties deste BO. Mapeia TODAS as colunas da tabela:
    * valor char(25), conteudo numeric(13,0), digchecks numeric(1,0).
    *
    * this_nProxCheque eh derivado aqui pela MESMA conta do Init legado
    * ("crAutoriza.Conteudo + 1"): SigSySeq guarda o ULTIMO cheque emitido e
    * a grade exibe o PROXIMO.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_cAliasCursor) = "C" AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            IF !EOF()
                THIS.this_cValor     = TratarNulo(valor, "")
                THIS.this_nConteudo  = TratarNulo(conteudo, 0)
                THIS.this_nDigChecks = TratarNulo(digchecks, 0)

                *-- Legado: Insert ... Values (..., crAutoriza.Conteudo + 1)
                THIS.this_nProxCheque = THIS.this_nConteudo + 1

                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarChequeDoCursor - Carrega a linha corrente da GRADE
    * (cursor_4c_Cheques / csCheques no legado) nas properties, resolvendo a
    * chave de SigSySeq e o conteudo a gravar.
    *
    * Legado (btnAlterar.Click):
    *   lcChave  = PADR(csCheques.Bancos + csCheques.Agencias + csCheques.NContas, 25)
    *   Conteudo = csCheques.Cheques - 1
    *
    * As colunas sao lidas CRUAS (sem ALLTRIM) justamente porque alimentam a
    * chave posicional - ver MontarChaveConta.
    *==========================================================================
    PROCEDURE CarregarChequeDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_cAliasCursor) = "C" AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            IF !EOF()
                THIS.this_cFPags    = TratarNulo(FPags, "")
                THIS.this_cBancos   = TratarNulo(Bancos, "")
                THIS.this_cAgencias = TratarNulo(Agencias, "")
                THIS.this_cNContas  = TratarNulo(NContas, "")

                THIS.this_nProxCheque = TratarNulo(Cheques, 0)

                THIS.this_cValor = THIS.MontarChaveConta(THIS.this_cBancos, ;
                                                         THIS.this_cAgencias, ;
                                                         THIS.this_cNContas)

                *-- SigSySeq.conteudo = ULTIMO cheque emitido = proximo - 1
                THIS.this_nConteudo = THIS.this_nProxCheque - 1

                *-- digchecks nao aparece em NENHUM ponto do codigo legado (nem
                *-- no Init, nem no Click). O "Insert Into crAutoriza (Valor,
                *-- Conteudo)" grava 0 ali porque esse eh o valor de buffer do
                *-- cursor criado pelo AddCursor; como a coluna eh NOT NULL sem
                *-- DEFAULT, este BO grava o mesmo 0 EXPLICITAMENTE (regra #22).
                THIS.this_nDigChecks = 0

                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Chave de SigSySeq usada na auditoria
    *
    * ALLTRIM aqui eh INOFENSIVO e proposital: a chave JA esta montada (o
    * padding INTERIOR esta preservado) e este retorno so alimenta
    * LogAuditoria.ChaveRegistro - nunca volta a ser usado em WHERE.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cValor)
    ENDPROC

    *==========================================================================
    * ValidarNumeroCheque - Legado: SIGOPNCH.Grade.Column5.Text1.Valid
    *
    *   If This.Value < 0
    *       MessageBox('Numero do Cheque Invalido.', 48, '')
    *       This.Value = Thisform.nAntChqVal
    *       Return 0
    *   EndIf
    *
    * So devolve o veredito; quem exibe a mensagem e restaura o valor anterior
    * eh o Form (que eh quem guarda o nAntChqVal). NAO ha limite SUPERIOR no
    * legado - a largura N(6) do cursor da grade eh que limita, e inventar um
    * teto aqui violaria o PILAR 1.
    *==========================================================================
    PROCEDURE ValidarNumeroCheque(par_nValor)
        LOCAL loc_lValido

        loc_lValido = .T.

        IF VARTYPE(par_nValor) != "N"
            loc_lValido = .F.
        ELSE
            IF par_nValor < 0
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF !loc_lValido
            THIS.this_cMensagemErro = "N" + CHR(250) + "mero do Cheque Inv" + ;
                                      CHR(225) + "lido."
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * ValidarDados - Chamado por BusinessBase.Salvar() e por GravarNumeracao
    * antes de incluir cada linha no lote.
    *==========================================================================
    PROCEDURE ValidarDados()
        LOCAL loc_lValido

        loc_lValido = .F.
        THIS.this_cMensagemErro = ""

        DO CASE
            CASE EMPTY(THIS.this_cValor)
                THIS.this_cMensagemErro = "Conta banc" + CHR(225) + "ria n" + ;
                    CHR(227) + "o identificada (Banco / Ag" + CHR(234) + ;
                    "ncia / Conta)."

            CASE !THIS.ValidarNumeroCheque(THIS.this_nProxCheque)
                *-- ValidarNumeroCheque ja preencheu this_cMensagemErro

            CASE THIS.this_nConteudo < 0
                THIS.this_cMensagemErro = "N" + CHR(250) + "mero do Cheque Inv" + ;
                                          CHR(225) + "lido."

            OTHERWISE
                loc_lValido = .T.
        ENDCASE

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * MontarInsertSequencia / MontarUpdateSequencia
    *
    * FONTE UNICA do SQL de gravacao de SigSySeq: Inserir()/Atualizar() usam
    * esses textos para o caminho de UMA linha, e GravarNumeracao() usa os
    * MESMOS textos para montar o lote atomico de varias linhas. Sem a fonte
    * unica os dois caminhos divergiriam em silencio.
    *
    * SigSySeq tem TRES colunas e TODAS sao NOT NULL sem DEFAULT (conferido em
    * docs/schema.sql, lido com Get-Content -Raw por ser UTF-16 - regra #14):
    * valor, conteudo, digchecks. O INSERT cobre as tres - omitir digchecks
    * faria o SQL Server recusar a inclusao inteira (regra #22).
    *==========================================================================
    PROTECTED PROCEDURE MontarInsertSequencia()
        LOCAL loc_cSQL

        loc_cSQL = "INSERT INTO SigSySeq (valor, conteudo, digchecks) VALUES (" + ;
                   EscaparSQL(LEFT(THIS.this_cValor, 25)) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nConteudo, 0) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nDigChecks, 0) + ")"

        RETURN loc_cSQL
    ENDPROC

    PROTECTED PROCEDURE MontarUpdateSequencia()
        LOCAL loc_cSQL

        *-- Legado (btnAlterar.Click): "Replace Conteudo With csCheques.Cheques - 1"
        *-- - so o conteudo muda; digchecks eh preservado no registro existente.
        loc_cSQL = "UPDATE SigSySeq SET conteudo = " + ;
                   FormatarNumeroSQL(THIS.this_nConteudo, 0) + ;
                   " WHERE valor = " + EscaparSQL(LEFT(THIS.this_cValor, 25))

        RETURN loc_cSQL
    ENDPROC

    *==========================================================================
    * Inserir - INSERT de UMA sequencia em SigSySeq (caminho BusinessBase.Salvar)
    *==========================================================================
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cErro, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de " + ;
                                          "dados indispon" + CHR(237) + "vel."
            ELSE
                loc_cSQL = THIS.MontarInsertSequencia()
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado < 0
                    loc_cErro = CapturarErroSQL()
                    THIS.this_cMensagemErro = "Erro na Grava" + CHR(231) + CHR(227) + ;
                        "o dos Dados do Cadastro de Opera" + CHR(231) + CHR(245) + ;
                        "es." + CHR(13) + loc_cErro
                    MsgErro(THIS.this_cMensagemErro, "Erro")
                    THIS.this_lErroExibido = .T.
                ELSE
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpNchBO.Inserir")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE de UMA sequencia em SigSySeq
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cErro, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de " + ;
                                          "dados indispon" + CHR(237) + "vel."
            ELSE
                loc_cSQL = THIS.MontarUpdateSequencia()
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado < 0
                    loc_cErro = CapturarErroSQL()
                    THIS.this_cMensagemErro = "Erro na Grava" + CHR(231) + CHR(227) + ;
                        "o dos Dados do Cadastro de Opera" + CHR(231) + CHR(245) + ;
                        "es." + CHR(13) + loc_cErro
                    MsgErro(THIS.this_cMensagemErro, "Erro")
                    THIS.this_lErroExibido = .T.
                ELSE
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpNchBO.Atualizar")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarFormasPagtoCheque - Popula this_cCursorFormasPagto (crSigOpFp)
    *
    * Legado: .AddCursor('SigOpFp','FPags','crSigOpFp','FPags',.f.) + Requery
    * (traz SigOpFp inteira, ordenada por FPags) e o Scan do Init descarta
    * tudo que nao casa com:
    *   Infos = 'C' And EmiChqs = 1 And Not IsEmpty(Bancos) And
    *   Not IsEmpty(Agencias) And Not IsEmpty(NContas)
    *
    * O filtro vai para o WHERE (resultado identico, sem trafegar a tabela
    * inteira). Nomes de coluna conferidos em docs/schema.sql: fpags char(12),
    * bancos char(3), agencias char(4), ncontas char(10), infos char(1),
    * emichqs numeric(1,0).
    *
    * NAO ha filtro por empresa: o legado nao filtra (AddCursor sem query) e
    * inventar um WHERE emps mudaria o conteudo da grade (PILAR 1).
    *==========================================================================
    PROCEDURE CarregarFormasPagtoCheque()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de " + ;
                                          "dados indispon" + CHR(237) + "vel."
            ELSE
                IF USED(THIS.this_cCursorFormasPagto)
                    USE IN (THIS.this_cCursorFormasPagto)
                ENDIF

                loc_cSQL = "SELECT fpags, bancos, agencias, ncontas" + ;
                           " FROM SigOpFp" + ;
                           " WHERE infos = 'C'" + ;
                           "   AND emichqs = 1" + ;
                           "   AND RTRIM(bancos) <> ''" + ;
                           "   AND RTRIM(agencias) <> ''" + ;
                           "   AND RTRIM(ncontas) <> ''" + ;
                           " ORDER BY fpags"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorFormasPagto)

                IF loc_nResultado < 0 OR !USED(THIS.this_cCursorFormasPagto)
                    THIS.this_cMensagemErro = "Erro ao carregar as Formas de " + ;
                        "Pagamento." + CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Erro")
                    THIS.this_lErroExibido = .T.
                ELSE
                    SELECT (THIS.this_cCursorFormasPagto)
                    GO TOP
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpNchBO.CarregarFormasPagtoCheque")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarAutoriza - Popula this_cCursorAutoriza (crAutoriza no legado)
    * com SigSySeq. Legado:
    *   .AddCursor('SigSySeq','Valor','crAutoriza','Valor',.f.) + Requery
    *
    * Traz as TRES colunas da tabela (valor/conteudo/digchecks) para que o
    * LOCATE do Init legado e a conferencia de existencia funcionem sem ida
    * extra ao banco.
    *==========================================================================
    PROCEDURE CarregarAutoriza()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de " + ;
                                          "dados indispon" + CHR(237) + "vel."
            ELSE
                IF USED(THIS.this_cCursorAutoriza)
                    USE IN (THIS.this_cCursorAutoriza)
                ENDIF

                loc_cSQL = "SELECT valor, conteudo, digchecks" + ;
                           " FROM SigSySeq" + ;
                           " ORDER BY valor"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorAutoriza)

                IF loc_nResultado < 0 OR !USED(THIS.this_cCursorAutoriza)
                    THIS.this_cMensagemErro = "Erro ao carregar a numera" + CHR(231) + ;
                        CHR(227) + "o de cheques." + CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Erro")
                    THIS.this_lErroExibido = .T.
                ELSE
                    SELECT (THIS.this_cCursorAutoriza)
                    GO TOP
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpNchBO.CarregarAutoriza")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * LocalizarSequencia - Legado (Init e Click, as duas vezes igual):
    *   Select crAutoriza
    *   LOCATE FOR valor = lcChave
    *   IF ! EOF() ...
    *
    * Deixa o cursor POSICIONADO na linha achada (o legado le
    * crAutoriza.Conteudo logo depois) e devolve .T./.F.
    *
    * Compara com "==" sobre as DUAS pontas padronizadas em 25 chars, nunca
    * com "=": o "=" depende de SET EXACT, e a datasession privada do form
    * (DataSession = 2) reseta os SETs para o default do VFP - o LOCATE do
    * legado casava por um comportamento de SET que aqui nao esta garantido.
    *==========================================================================
    PROCEDURE LocalizarSequencia(par_cChave)
        LOCAL loc_lAchou, loc_cChave

        loc_lAchou = .F.

        IF VARTYPE(par_cChave) = "C" AND USED(THIS.this_cCursorAutoriza)
            loc_cChave = PADR(par_cChave, 25)

            SELECT (THIS.this_cCursorAutoriza)
            LOCATE FOR PADR(valor, 25) == loc_cChave

            loc_lAchou = !EOF()
        ENDIF

        RETURN loc_lAchou
    ENDPROC

    *==========================================================================
    * CriarCursorCheques - Cria o cursor da GRADE (csCheques no legado)
    *
    * Legado (PROCEDURE Load):
    *   Create Cursor csCheques ( FPags C(12), Bancos C(3), Agencias C(4),
    *                             NContas C(10), Cheques N(6), Marcas L(1) )
    *   Index On Fpags Tag FPags
    *
    * Esta eh a UNICA criacao do cursor no projeto (a recarga em MontarCheques
    * usa ZAP, nao CREATE) - assim a ordem/largura das colunas nao tem como
    * divergir entre dois pontos, e o RecordSource/ControlSource do Grid nao eh
    * destruido a cada carga.
    *
    * Idempotente: se o cursor ja existe, nao recria.
    *==========================================================================
    PROCEDURE CriarCursorCheques()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorCheques)
                loc_lSucesso = .T.
            ELSE
                CREATE CURSOR (THIS.this_cCursorCheques) ( ;
                    FPags    C(12), ;
                    Bancos   C(3),  ;
                    Agencias C(4),  ;
                    NContas  C(10), ;
                    Cheques  N(6),  ;
                    Marcas   L(1))

                SELECT (THIS.this_cCursorCheques)
                INDEX ON FPags TAG FPags

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpNchBO.CriarCursorCheques")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * MontarCheques - Reproduz o Scan do Init legado: para cada forma de
    * pagamento tipo cheque com conta bancaria, insere na grade o PROXIMO
    * numero de cheque.
    *
    *   lcChave = PADR(Bancos + Agencias + NContas, 25)
    *   Locate em crAutoriza For valor = lcChave
    *     achou     -> Cheques = crAutoriza.Conteudo + 1
    *     nao achou -> Cheques = 1
    *
    * Marcas nasce .F.: so o Valid da coluna 5 marca a linha, e o Confirmar
    * grava APENAS as marcadas.
    *
    * O ZAP vai GUARDADO por SET SAFETY: SAFETY eh escopado por data session e
    * o form eh DataSession = 2, onde ele volta a valer ON mesmo com o
    * SET SAFETY OFF do main.prg - com SAFETY ON o ZAP abre um dialogo modal
    * que ninguem ve e CONGELA a tela.
    *==========================================================================
    PROCEDURE MontarCheques()
        LOCAL loc_lSucesso, loc_cSafety, loc_nProx, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF !THIS.CriarCursorCheques()
                THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                    "vel preparar a grade de cheques."
            ELSE
                loc_cSafety = SET("SAFETY")
                SET SAFETY OFF
                SELECT (THIS.this_cCursorCheques)
                ZAP
                IF loc_cSafety = "ON"
                    SET SAFETY ON
                ENDIF

                IF USED(THIS.this_cCursorFormasPagto)
                    SELECT (THIS.this_cCursorFormasPagto)
                    SCAN
                        *-- Valores lidos CRUS - alimentam a chave posicional
                        THIS.this_cFPags    = TratarNulo(fpags, "")
                        THIS.this_cBancos   = TratarNulo(bancos, "")
                        THIS.this_cAgencias = TratarNulo(agencias, "")
                        THIS.this_cNContas  = TratarNulo(ncontas, "")

                        THIS.this_cValor = THIS.MontarChaveConta(THIS.this_cBancos, ;
                                                                 THIS.this_cAgencias, ;
                                                                 THIS.this_cNContas)

                        IF THIS.LocalizarSequencia(THIS.this_cValor)
                            SELECT (THIS.this_cCursorAutoriza)
                            loc_nProx = TratarNulo(conteudo, 0) + 1
                        ELSE
                            loc_nProx = 1
                        ENDIF

                        INSERT INTO (THIS.this_cCursorCheques) ;
                            (FPags, Bancos, Agencias, NContas, Cheques, Marcas) ;
                            VALUES (THIS.this_cFPags, THIS.this_cBancos, ;
                                    THIS.this_cAgencias, THIS.this_cNContas, ;
                                    loc_nProx, .F.)

                        SELECT (THIS.this_cCursorFormasPagto)
                    ENDSCAN
                ENDIF

                *-- Legado: "Select csCheques / Go Top" antes do Grade.Refresh
                SELECT (THIS.this_cCursorCheques)
                GO TOP

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpNchBO.MontarCheques")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDados - Funil UNICO de carga: formas de pagamento + sequencias +
    * montagem da grade. Equivale ao bloco de Requery/Scan do Init legado.
    *==========================================================================
    PROCEDURE CarregarDados()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        IF THIS.CarregarFormasPagtoCheque()
            IF THIS.CarregarAutoriza()
                loc_lSucesso = THIS.MontarCheques()
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * MarcarChequeAlterado - Legado: SIGOPNCH.Grade.Column5.Text1.Valid
    *
    *   If This.Value # Thisform.nAntChqVal
    *       Select csCheques
    *       Replace csCheques.Marcas With .T.
    *   EndIf
    *
    * Marca a linha CORRENTE da grade. O Replace do legado roda sobre o
    * registro corrente de csCheques, nao sobre todos.
    *==========================================================================
    PROCEDURE MarcarChequeAlterado(par_cCursorCheques)
        LOCAL loc_lSucesso, loc_cCursor

        loc_lSucesso = .F.
        loc_cCursor = IIF(VARTYPE(par_cCursorCheques) = "C" AND !EMPTY(par_cCursorCheques), ;
                          par_cCursorCheques, THIS.this_cCursorCheques)

        IF USED(loc_cCursor)
            SELECT (loc_cCursor)

            IF !EOF()
                REPLACE Marcas WITH .T. IN (loc_cCursor)
                loc_lSucesso = .T.
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ContarChequesAlterados - Quantas linhas da grade o usuario tocou
    * (o "Scan For Marcas" do legado com o "If !IsEmpty(csCheques.Cheques)"
    * que descarta numero zerado; Cheques eh N(6), logo IsEmpty equivale a = 0).
    *
    * Repoe o RECNO no fim: SCAN move o ponteiro e quem chama costuma estar no
    * meio da propria navegacao da grade.
    *==========================================================================
    PROCEDURE ContarChequesAlterados(par_cCursorCheques)
        LOCAL loc_cCursor, loc_nTotal, loc_nRecno

        loc_nTotal = 0
        loc_cCursor = IIF(VARTYPE(par_cCursorCheques) = "C" AND !EMPTY(par_cCursorCheques), ;
                          par_cCursorCheques, THIS.this_cCursorCheques)

        IF USED(loc_cCursor)
            SELECT (loc_cCursor)
            loc_nRecno = IIF(EOF(), 0, RECNO())

            SCAN FOR Marcas AND Cheques <> 0
                loc_nTotal = loc_nTotal + 1
            ENDSCAN

            IF loc_nRecno > 0 AND loc_nRecno <= RECCOUNT(loc_cCursor)
                GO (loc_nRecno) IN (loc_cCursor)
            ELSE
                GO TOP IN (loc_cCursor)
            ENDIF
        ENDIF

        RETURN loc_nTotal
    ENDPROC

    *==========================================================================
    * GravarNumeracao - Legado: SIGOPNCH.btnAlterar.Click
    *
    *   Scan For Marcas
    *       If !IsEmpty(csCheques.Cheques)
    *           lcChave = PADR(Bancos + Agencias + NContas, 25)
    *           Locate em crAutoriza For valor = lcChave
    *             achou     -> Replace Conteudo With csCheques.Cheques - 1
    *             nao achou -> Insert Into crAutoriza (Valor, Conteudo)
    *                          Values (lcChave, csCheques.Cheques - 1)
    *       Endif
    *   EndScan
    *   .poDataMgr.UpDate('crAutoriza') -> .Commit()   (erro -> .RollBack())
    *
    * ATOMICIDADE: o legado grava as N linhas numa UNICA transacao. Mandar
    * BEGIN/COMMIT TRANSACTION em SQLEXEC separados NAO protege nada - a
    * conexao nasce com Transactions = 2 e @@TRANCOUNT ja vale 1, entao o par
    * so ANINHA e o COMMIT nao efetiva. Por isso o lote INTEIRO vai num SQLEXEC
    * unico, com o controle de transacao em T-SQL e SAVE TRANSACTION para o
    * caso (normal) de ja haver transacao aberta. O THROW faz o erro chegar ao
    * SQLEXEC, que devolve -1 e deixa CapturarErroSQL() com a mensagem real.
    *
    * O "UPDATE ... IF @@ROWCOUNT = 0 INSERT ..." resolve no servidor o mesmo
    * update-ou-insert que o legado decidia pelo LOCATE no cursor - sem
    * depender de um cursor que pode estar desatualizado.
    *
    * O Commit() do legado eh um PASSO COM CAMINHO DE FALHA PROPRIO, nao
    * detalhe de infra (o legado o testa separadamente do UpDate): reproduzido
    * com SQLCOMMIT/SQLROLLBACK, inertes quando a conexao esta em auto-commit.
    * IF ANINHADO, nunca "IF loc_lManual AND SQLCOMMIT(...)" - VFP9 nao faz
    * curto-circuito e chamaria o commit do mesmo jeito.
    *==========================================================================
    PROCEDURE GravarNumeracao(par_cCursorCheques)
        LOCAL loc_lSucesso, loc_cCursor, loc_cLote, loc_cStmts, loc_nLinhas, ;
              loc_nResultado, loc_lManual, loc_cErro, loc_oErro
        LOCAL ARRAY loc_aChaves[1]

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""
        THIS.this_lErroExibido  = .F.
        loc_lManual = .F.

        loc_cCursor = IIF(VARTYPE(par_cCursorCheques) = "C" AND !EMPTY(par_cCursorCheques), ;
                          par_cCursorCheques, THIS.this_cCursorCheques)

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de " + ;
                                          "dados indispon" + CHR(237) + "vel."
                MsgErro(THIS.this_cMensagemErro, "Erro")
                THIS.this_lErroExibido = .T.

            ELSE
                IF !USED(loc_cCursor)
                    THIS.this_cMensagemErro = "Grade de cheques n" + CHR(227) + ;
                        "o dispon" + CHR(237) + "vel."
                    MsgErro(THIS.this_cMensagemErro, "Erro")
                    THIS.this_lErroExibido = .T.
                ELSE
                    loc_lManual = (SQLGETPROP(gnConnHandle, "Transactions") = 2)
                    loc_cStmts  = ""
                    loc_nLinhas = 0

                    SELECT (loc_cCursor)
                    SCAN FOR Marcas AND Cheques <> 0
                        *-- Le a linha corrente da grade: monta a chave
                        *-- posicional e resolve conteudo = Cheques - 1
                        IF THIS.CarregarChequeDoCursor(loc_cCursor)
                            IF THIS.ValidarDados()
                                loc_nLinhas = loc_nLinhas + 1
                                DIMENSION loc_aChaves[loc_nLinhas]
                                loc_aChaves[loc_nLinhas] = THIS.this_cValor

                                loc_cStmts = loc_cStmts + ;
                                    THIS.MontarUpdateSequencia() + "; " + ;
                                    "IF @@ROWCOUNT = 0 " + ;
                                    THIS.MontarInsertSequencia() + "; "
                            ELSE
                                *-- ValidarDados preencheu this_cMensagemErro.
                                *-- Aborta o lote INTEIRO, como o RollBack do
                                *-- legado - gravar parte das linhas deixaria a
                                *-- numeracao de algumas contas certa e de
                                *-- outras nao, sem o usuario saber quais.
                                loc_nLinhas = 0
                                loc_cStmts  = ""
                                EXIT
                            ENDIF
                        ENDIF

                        SELECT (loc_cCursor)
                    ENDSCAN

                    DO CASE
                        CASE !EMPTY(THIS.this_cMensagemErro)
                            MsgAviso(THIS.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
                            THIS.this_lErroExibido = .T.

                        CASE loc_nLinhas = 0
                            *-- Nada marcado: o legado tambem segue em frente
                            *-- (UpDate/Commit sem alteracao nenhuma) e encerra
                            *-- a tela sem reclamar. NAO inventar aviso aqui.
                            loc_lSucesso = .T.

                        OTHERWISE
                            loc_cLote = "SET NOCOUNT ON; " + ;
                                "DECLARE @nivel int = @@TRANCOUNT; " + ;
                                "IF @nivel = 0 BEGIN TRANSACTION " + ;
                                "ELSE SAVE TRANSACTION Nch4c; " + ;
                                "BEGIN TRY " + ;
                                loc_cStmts + ;
                                "IF @nivel = 0 COMMIT TRANSACTION; " + ;
                                "END TRY " + ;
                                "BEGIN CATCH " + ;
                                "IF @nivel = 0 BEGIN IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION; END " + ;
                                "ELSE BEGIN IF XACT_STATE() = 1 ROLLBACK TRANSACTION Nch4c; END; " + ;
                                "THROW; " + ;
                                "END CATCH"

                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cLote)

                            IF loc_nResultado < 0
                                loc_cErro = CapturarErroSQL()

                                IF loc_lManual
                                    = SQLROLLBACK(gnConnHandle)
                                ENDIF

                                THIS.this_cMensagemErro = "Erro na Grava" + CHR(231) + ;
                                    CHR(227) + "o dos Dados do Cadastro de Opera" + ;
                                    CHR(231) + CHR(245) + "es." + CHR(13) + loc_cErro
                                MsgErro(THIS.this_cMensagemErro, "Erro")
                                THIS.this_lErroExibido = .T.
                            ELSE
                                *-- Commit do legado (.poDataMgr.Commit())
                                loc_lSucesso = .T.

                                IF loc_lManual
                                    IF SQLCOMMIT(gnConnHandle) < 1
                                        = SQLROLLBACK(gnConnHandle)
                                        THIS.this_cMensagemErro = "Erro na Grava" + ;
                                            CHR(231) + CHR(227) + "o dos Dados do " + ;
                                            "Cadastro de Opera" + CHR(231) + CHR(245) + ;
                                            "es." + CHR(13) + CapturarErroSQL()
                                        MsgErro(THIS.this_cMensagemErro, "Erro")
                                        THIS.this_lErroExibido = .T.
                                        loc_lSucesso = .F.
                                    ENDIF
                                ENDIF

                                IF loc_lSucesso
                                    THIS.RegistrarAuditoriaLote(@loc_aChaves, loc_nLinhas)

                                    *-- O cursor de sequencias passa a divergir
                                    *-- do banco depois de gravar: recarregar
                                    *-- para um segundo Confirmar nao tentar
                                    *-- inserir chave que agora existe.
                                    THIS.CarregarAutoriza()
                                ENDIF
                            ENDIF
                    ENDCASE

                    IF USED(loc_cCursor)
                        SELECT (loc_cCursor)
                        GO TOP
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            IF loc_lManual
                = SQLROLLBACK(gnConnHandle)
            ENDIF

            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpNchBO.GravarNumeracao")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * RegistrarAuditoriaLote - Grava em LogAuditoria uma linha por conta
    * bancaria afetada pelo lote de GravarNumeracao.
    *
    * Roda DEPOIS do commit, nunca dentro do lote: o lote eh montado para ser
    * atomico sobre SigSySeq e a auditoria nao pode poder derruba-lo.
    *==========================================================================
    PROTECTED PROCEDURE RegistrarAuditoriaLote(par_aChaves, par_nLinhas)
        LOCAL loc_nI, loc_cValorAnterior, loc_lResultado

        loc_lResultado = .F.

        IF VARTYPE(par_nLinhas) = "N" AND par_nLinhas > 0
            loc_cValorAnterior = THIS.this_cValor

            FOR loc_nI = 1 TO par_nLinhas
                THIS.this_cValor = par_aChaves[loc_nI]
                THIS.RegistrarAuditoria("UPDATE")
            ENDFOR

            THIS.this_cValor = loc_cValorAnterior
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * LimparDados - Zera as properties (usado por BusinessBase.NovoRegistro)
    *==========================================================================
    PROCEDURE LimparDados()
        THIS.this_cValor      = ""
        THIS.this_nConteudo   = 0
        THIS.this_nDigChecks  = 0

        THIS.this_cFPags      = ""
        THIS.this_cBancos     = ""
        THIS.this_cAgencias   = ""
        THIS.this_cNContas    = ""

        THIS.this_nProxCheque = 0

        RETURN .T.
    ENDPROC

    *==========================================================================
    * Destroy - Fecha os cursores que este BO abriu
    *==========================================================================
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorFormasPagto)
            USE IN (THIS.this_cCursorFormasPagto)
        ENDIF

        IF USED(THIS.this_cCursorAutoriza)
            USE IN (THIS.this_cCursorAutoriza)
        ENDIF

        IF USED(THIS.this_cCursorCheques)
            USE IN (THIS.this_cCursorCheques)
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
