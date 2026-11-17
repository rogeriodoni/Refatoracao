*==============================================================================
* SigOpPdtBO.prg - Business Object para FormSigOpPdt (operacoes em aberto)
* Herda de BusinessBase
*
* Origem legado: tasks\task784\SigOpPdt.SCX (form SIGOPPDT, DataSession = 2,
* WindowType = 1 - dialogo MODAL aberto pela tela de movimentacao SigMvCab
* para marcar/desmarcar quais operacoes em aberto ficam vinculadas ao
* documento corrente).
*
* ATENCAO - ESTE DIALOGO NAO TEM TABELA PROPRIA NO SQL SERVER:
* o Init legado cria o cursor de exibicao TmpPends a partir de um SELECT em
* SigMvCab (armazenado em PendEest) e usa TRES cursores que pertencem ao
* FORM PAI (crSigMvCab, crLclMvItn, TmpOperacao - ver Init/Marca/Desmarca do
* dump legado). A gravacao da marcacao/desmarcacao eh um UPDATE direto em
* SigMvCab (coluna ChkSubn), nao um Inserir/Atualizar de registro proprio -
* por isso this_cTabela fica vazio (ver Init) e a persistencia real sera
* feita em metodos dedicados (fase 2), nao em Inserir()/Atualizar().
*
* Estrutura EXATA do cursor de exibicao (transcrita do Create Cursor legado):
*   TmpPends ( Flag l, Emps c(3), Dopes c(20), Numes n(6), MascNum c(6),
*              Datas t Null, TpFats c(3), Origem c(21), Destino c(21),
*              Valos n(12,2) )
*              Index on Emps + Dopes + Str(Numes, 6) Tag EmpDopNum
*              Index on Numes Tag Numes
*
* Chave de cada linha da grade (lcNivel no legado) = Emps + Dopes + Str(Numes,6),
* usada no WHERE EmpDopNums = '<lcNivel>' do UPDATE SigMvCab em Marca/Desmarca.
*
* Cursores do FORM PAI (SigMvCab), CONTRATO - nomes NAO renomeados:
*   crSigMvCab   - cabecalho do movimento corrente (Emps, Dopes, Numes,
*                  ContaOs, ContaDs, GrupoOs, GrupoDs, GrVends, Vends, Obses)
*   crLclMvItn   - cursor local de itens do movimento corrente
*   TmpOperacao  - cursor de controle (Codigos) com os niveis ja vinculados
*
* FASE 1/8: declaracao de TODAS as propriedades + Init.
* FASE 2/8: CarregarPendencias (reproduz o SELECT em SigMvCab + filtros de
* conta do Init legado), CarregarDoCursor (linha corrente -> propriedades),
* MarcarPendencia/DesmarcarPendencia (equivalentes a Marca/Desmarca) e
* ObterChavePrimaria. Inserir/Atualizar/ExecutarExclusao ficam com o default
* herdado - este dialogo nao insere nem exclui registro proprio nenhum.
*==============================================================================
DEFINE CLASS SigOpPdtBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades da LINHA CORRENTE do cursor de exibicao (TmpPends), uma
    * para cada coluna da grade de 8 colunas do legado (seleciona, empresa,
    * operacao, codigo, data, Grupo=Origem, Conta=Destino, Column8=valor)
    *--------------------------------------------------------------------------
    this_lFlag     = .F.   && Flag      l       - pendencia esta marcada (vinculada)
    this_cEmps     = ""    && Emps      c(3)    - empresa do documento pendente
    this_cDopes    = ""    && Dopes     c(20)   - codigo da operacao (SigCdOpe.Dopes)
    this_nNumes    = 0     && Numes     n(6)    - numero do documento pendente
    this_cMascNum  = ""    && MascNum   c(6)    - numero do documento formatado p/ exibicao
    this_dDatas    = {}    && Datas     t       - data/hora do documento pendente
    this_cTpFats   = ""    && TpFats    c(3)    - tipo de fatura (nao exibido na grade,
                           && mas faz parte da estrutura do cursor legado)
    this_cOrigem   = ""    && Origem    c(21)   - "GrupoOs/ContaOs" resolvido no Init
    this_cDestino  = ""    && Destino   c(21)   - "GrupoDs/ContaDs" resolvido no Init
    this_nValos    = 0     && Valos     n(12,2) - valor do documento pendente

    *--------------------------------------------------------------------------
    * Variaveis de sessao do dialogo, calculadas UMA VEZ no Init legado a
    * partir de crSigMvCab.Dopes (consulta a SigCdOpe) e reaproveitadas
    * durante o ciclo de vida da tela - decidem como Origem/Destino sao
    * resolvidos e filtrados (equivalente a lcDopesNivel, lnPuxaOrigem,
    * lnPuxaDestino, lcNumeroNivel do Init; FixGOrigs/FixGDests/ConOSubs/
    * ConDSubs sao relidos em Marca a partir da operacao do documento
    * CORRENTE, mas com a MESMA semantica)
    *--------------------------------------------------------------------------
    this_cDopesNivel    = ""   && TempOpe.Nivels  - codigo de operacao "nivel" do documento
    this_cNumeroNivel   = ""   && Str(TempOpe.NDopes, 4) - numero sequencial da operacao nivel
    this_nPuxaOrigem    = 0    && TempOpe.ConOSubs - 0=nao puxa / 1=usa Origem / 2=usa Destino
    this_nPuxaDestino   = 0    && TempOpe.ConDSubs - 0=nao puxa / 1=usa Origem / 2=usa Destino
    this_lFixGOrigs     = .F.  && TempOpe.FixGOrigs - grupo de origem fixo (nao sobrescrever)
    this_lFixGDests     = .F.  && TempOpe.FixGDests - grupo de destino fixo (nao sobrescrever)

    *--------------------------------------------------------------------------
    * Escolha operacional herdada do form pai (ThisForm.Op_Escolha =
    * ThisForm.Parentform.pcEscolha no legado). Controla se o checkbox de
    * marcacao esta habilitado (When = Op_Escolha = 'INSERIR') e se os
    * botoes SelTudo/Apaga agem (When = Inlist(Op_Escolha,'INSERIR','ALTERAR')).
    *--------------------------------------------------------------------------
    this_cOpEscolha = ""

    *--------------------------------------------------------------------------
    * Descricoes resolvidas (SigCdCli.RClis) apos Marcar/Desmarcar uma
    * pendencia - equivalente ao bloco final de Marca() do legado que
    * preenchia ThisForm.ParentForm.Pagina.Dados.Origem/Destino/Responsavel.
    * get_dconta.Value. Aqui ficam disponiveis como SAIDA de dados para o
    * FORM repassar ao form pai (BO nunca toca em controle de outro form).
    *--------------------------------------------------------------------------
    this_cOrigemDesc      = ""
    this_cDestinoDesc     = ""
    this_cResponsavelDesc = ""

    *--------------------------------------------------------------------------
    * Cursores proprios deste dialogo (nomenclatura nova - PILAR 3)
    *--------------------------------------------------------------------------
    this_cCursorPendentes = "cursor_4c_Pendentes"  && migrado de TmpPends (grade)
    this_cCursorPendEest  = "cursor_4c_PendEest"   && migrado de PendEest (SELECT em SigMvCab)
    this_cCursorTempOpe   = "cursor_4c_TempOpe"    && migrado de TempOpe (lookup SigCdOpe)
    this_cCursorCli       = "cursor_4c_Cli"        && migrado de crCli (lookup SigCdCli)

    *--------------------------------------------------------------------------
    * Cursores do FORM PAI (SigMvCab) - CONTRATO, nomes do legado preservados
    * de proposito (ver cabecalho do arquivo). Este dialogo entra na data
    * session do form pai (par_nDataSession recebido pelo Form) e LE/ESCREVE
    * nesses cursores sem recria-los.
    *--------------------------------------------------------------------------
    this_cCursorSigMvCab    = "crSigMvCab"
    this_cCursorLclMvItn    = "crLclMvItn"
    this_cCursorTmpOperacao = "TmpOperacao"

    *--------------------------------------------------------------------------
    * Tabelas do SQL Server consultadas/atualizadas por este dialogo
    *--------------------------------------------------------------------------
    this_cTabelaSigMvCab = "SigMvCab"
    this_cTabelaSigCdOpe = "SigCdOpe"
    this_cTabelaSigMvItn = "SigMvItn"
    this_cTabelaSigCdCli = "SigCdCli"

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *
    * this_cTabela fica VAZIO de proposito: este dialogo nao persiste um
    * registro proprio (ver cabecalho) - a gravacao eh um UPDATE direto em
    * SigMvCab.ChkSubn, feito por metodo dedicado na fase 2. O campo chave
    * eh Numes, que eh o indice usado pelo legado para localizar a pendencia
    * ao digitar o numero no campo de procura (Get_Procura.Valid faz
    * Set Order To Numes / Seek This.Value em TmpPends).
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()

            IF loc_lResultado
                THIS.this_cTabela     = ""
                THIS.this_cCampoChave = "Numes"

                *-- Estado inicial da linha corrente - zerado aqui (e nao so na
                *-- declaracao) para que reusar a mesma instancia do BO numa
                *-- segunda abertura do dialogo nunca exiba dados da anterior.
                THIS.this_lFlag     = .F.
                THIS.this_cEmps     = ""
                THIS.this_cDopes    = ""
                THIS.this_nNumes    = 0
                THIS.this_cMascNum  = ""
                THIS.this_dDatas    = {}
                THIS.this_cTpFats   = ""
                THIS.this_cOrigem   = ""
                THIS.this_cDestino  = ""
                THIS.this_nValos    = 0

                THIS.this_cDopesNivel  = ""
                THIS.this_cNumeroNivel = ""
                THIS.this_nPuxaOrigem  = 0
                THIS.this_nPuxaDestino = 0
                THIS.this_lFixGOrigs   = .F.
                THIS.this_lFixGDests   = .F.

                THIS.this_cOpEscolha = ""

                THIS.this_cOrigemDesc      = ""
                THIS.this_cDestinoDesc     = ""
                THIS.this_cResponsavelDesc = ""

                THIS.this_cMensagemErro = ""
                THIS.this_lErroExibido  = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega a LINHA CORRENTE de cursor_4c_Pendentes (o
    * cursor de exibicao, equivalente a TmpPends do legado) para as
    * propriedades this_* da linha. Chamado antes de Marcar/Desmarcar e pelo
    * Form sempre que precisar ler os dados da linha selecionada na grade.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                IF !EOF()
                    THIS.this_lFlag    = Flag
                    THIS.this_cEmps    = TratarNulo(Emps, "")
                    THIS.this_cDopes   = TratarNulo(Dopes, "")
                    THIS.this_nNumes   = TratarNulo(Numes, 0)
                    THIS.this_cMascNum = TratarNulo(MascNum, "")
                    THIS.this_dDatas   = TratarNulo(Datas, {})
                    THIS.this_cTpFats  = TratarNulo(TpFats, "")
                    THIS.this_cOrigem  = TratarNulo(Origem, "")
                    THIS.this_cDestino = TratarNulo(Destino, "")
                    THIS.this_nValos   = TratarNulo(Valos, 0)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Monta a chave POSICIONAL EmpDopNums (Emps char(3)
    * + Dopes char(20) + Str(Numes,6) = 29 chars) da LINHA CORRENTE, a partir
    * das propriedades carregadas por CarregarDoCursor. PADR explicito em
    * cada parte (regra #42) - NUNCA ALLTRIM nas partes internas, senao a
    * chave nunca casa com SigMvCab.EmpDopNums.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterDescricaoConta - Resolve a razao social (SigCdCli.RClis) de um
    * codigo de conta (IClis). Equivalente ao
    * "ThisForm.poDataMgr.CursorQuery('SigCdCli','crCli','IClis',<cod>,'RClis')
    * + If Not Eof('crCli') ... Else ''" repetido 3x no final de Marca().
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterDescricaoConta(par_cCodigo)
        LOCAL loc_cDescricao, loc_cSQL, loc_nResultado
        loc_cDescricao = ""

        TRY
            IF !EMPTY(par_cCodigo)
                IF USED("cursor_4c_Cli")
                    USE IN cursor_4c_Cli
                ENDIF

                loc_cSQL = "SELECT RClis FROM " + THIS.this_cTabelaSigCdCli + ;
                           " WHERE IClis = " + EscaparSQL(par_cCodigo)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cli")

                IF loc_nResultado > 0
                    IF !EOF("cursor_4c_Cli")
                        loc_cDescricao = TratarNulo(cursor_4c_Cli.RClis, "")
                    ENDIF
                    USE IN cursor_4c_Cli
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_cDescricao = ""
        ENDTRY

        RETURN loc_cDescricao
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPendencias - Monta cursor_4c_Pendentes (grade de exibicao,
    * equivalente a TmpPends) a partir do movimento corrente (crSigMvCab,
    * cursor do FORM PAI). Transcricao literal do PROCEDURE Init do legado
    * (a parte de montagem de dados - o restante do Init, que cria o
    * FormSigOpPdt e configura a grade, fica na FASE 3/Form).
    *
    * Pre-requisitos (contrato do form pai, ver cabecalho do arquivo):
    *   - crSigMvCab posicionado no documento corrente
    *   - TmpOperacao aberto (cursor de niveis ja vinculados)
    *
    * Retorno: .T. com cursor_4c_Pendentes populado (GO TOP); .F. em falha,
    * com this_cMensagemErro preenchido.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPendencias()
        LOCAL loc_lResultado, loc_lProsseguir, loc_cSQL, loc_nResultado
        LOCAL loc_cDopesNivel, loc_cNumeroNivel, loc_nPuxaOrigem, loc_nPuxaDestino
        LOCAL loc_cEd1, loc_cEd2, loc_cOrigem, loc_cDestino, loc_lFlag, loc_nNivelAtual

        loc_lResultado  = .F.
        loc_lProsseguir = .T.
        THIS.this_cMensagemErro = ""

        TRY
            IF loc_lProsseguir
                IF !USED("crSigMvCab")
                    THIS.this_cMensagemErro = "Cursor do movimento corrente (crSigMvCab) nao esta aberto."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF EOF("crSigMvCab")
                    THIS.this_cMensagemErro = "Cursor do movimento corrente (crSigMvCab) nao esta posicionado."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF !USED("TmpOperacao")
                    THIS.this_cMensagemErro = "Cursor de controle do movimento (TmpOperacao) nao esta aberto."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF USED("cursor_4c_Pendentes")
                    USE IN cursor_4c_Pendentes
                ENDIF

                SET NULL ON
                CREATE CURSOR cursor_4c_Pendentes ;
                    (Flag L, Emps C(3), Dopes C(20), Numes N(6), MascNum C(6), ;
                     Datas T, TpFats C(3), Origem C(21), Destino C(21), Valos N(12,2))
                SET NULL OFF
                INDEX ON Emps + Dopes + STR(Numes, 6) TAG EmpDopNum
                INDEX ON Numes TAG Numes

                SELECT TmpOperacao
                DELETE ALL FOR EMPTY(Codigos)

                IF USED("cursor_4c_TempOpe")
                    USE IN cursor_4c_TempOpe
                ENDIF

                loc_cSQL = "SELECT Nivels, ConOSubs, ConDSubs FROM " + THIS.this_cTabelaSigCdOpe + ;
                           " WHERE Dopes = " + EscaparSQL(crSigMvCab.Dopes)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TempOpe")

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                    loc_lProsseguir = .F.
                ELSE
                    loc_cDopesNivel  = TratarNulo(cursor_4c_TempOpe.Nivels, "")
                    loc_nPuxaOrigem  = TratarNulo(cursor_4c_TempOpe.ConOSubs, 0)
                    loc_nPuxaDestino = TratarNulo(cursor_4c_TempOpe.ConDSubs, 0)
                    USE IN cursor_4c_TempOpe
                ENDIF
            ENDIF

            IF loc_lProsseguir
                loc_cSQL = "SELECT NDopes FROM " + THIS.this_cTabelaSigCdOpe + ;
                           " WHERE Dopes = " + EscaparSQL(loc_cDopesNivel)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TempOpe")

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                    loc_lProsseguir = .F.
                ELSE
                    loc_cNumeroNivel = STR(TratarNulo(cursor_4c_TempOpe.NDopes, 0), 4)
                    USE IN cursor_4c_TempOpe
                ENDIF
            ENDIF

            IF loc_lProsseguir
                loc_cEd1 = PADR(go_4c_Sistema.cCodEmpresa, 3) + PADR(loc_cDopesNivel, 20) + STR(0, 6)
                loc_cEd2 = PADR(go_4c_Sistema.cCodEmpresa, 3) + PADR(loc_cDopesNivel, 20) + STR(999999, 6)

                IF USED("cursor_4c_PendEest")
                    USE IN cursor_4c_PendEest
                ENDIF

                loc_cSQL = "SELECT Emps, Dopes, Numes, MascNum, Datas, Valos, ChkSubn, GrupoOs, GrupoDs, ContaOs, ContaDs" + ;
                           " FROM " + THIS.this_cTabelaSigMvCab + ;
                           " WHERE EmpDopNums BETWEEN " + EscaparSQL(loc_cEd1) + " AND " + EscaparSQL(loc_cEd2)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PendEest")

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                SELECT cursor_4c_PendEest
                SCAN
                    loc_nNivelAtual = VAL(loc_cNumeroNivel + TRANSFORM(cursor_4c_PendEest.Numes, "@L 999999"))

                    IF cursor_4c_PendEest.ChkSubn AND !SEEK(loc_nNivelAtual, "TmpOperacao", "Codigos")
                        LOOP
                    ENDIF

                    loc_cOrigem  = ""
                    loc_cDestino = ""

                    IF INLIST(loc_nPuxaOrigem, 1, 2)
                        IF loc_nPuxaOrigem = 1
                            IF !EMPTY(crSigMvCab.ContaOs) AND crSigMvCab.ContaOs <> cursor_4c_PendEest.ContaOs
                                LOOP
                            ENDIF
                            loc_cOrigem = cursor_4c_PendEest.GrupoOs + "/" + cursor_4c_PendEest.ContaOs
                        ELSE
                            IF !EMPTY(crSigMvCab.ContaOs) AND crSigMvCab.ContaOs <> cursor_4c_PendEest.ContaDs
                                LOOP
                            ENDIF
                            loc_cOrigem = cursor_4c_PendEest.GrupoDs + "/" + cursor_4c_PendEest.ContaDs
                        ENDIF
                    ELSE
                        loc_cOrigem = cursor_4c_PendEest.GrupoOs + "/" + cursor_4c_PendEest.ContaOs
                    ENDIF

                    IF INLIST(loc_nPuxaDestino, 1, 2)
                        IF loc_nPuxaDestino = 1
                            IF !EMPTY(crSigMvCab.ContaDs) AND crSigMvCab.ContaDs <> cursor_4c_PendEest.ContaOs
                                LOOP
                            ENDIF
                            loc_cDestino = cursor_4c_PendEest.GrupoOs + "/" + cursor_4c_PendEest.ContaOs
                        ELSE
                            IF !EMPTY(crSigMvCab.ContaDs) AND crSigMvCab.ContaDs <> cursor_4c_PendEest.ContaDs
                                LOOP
                            ENDIF
                            loc_cDestino = cursor_4c_PendEest.GrupoDs + "/" + cursor_4c_PendEest.ContaDs
                        ENDIF
                    ELSE
                        loc_cDestino = cursor_4c_PendEest.GrupoDs + "/" + cursor_4c_PendEest.ContaDs
                    ENDIF

                    loc_lFlag = SEEK(loc_nNivelAtual, "TmpOperacao", "Codigos")

                    INSERT INTO cursor_4c_Pendentes (Flag, Emps, Dopes, Numes, MascNum, Datas, Origem, Destino, Valos) ;
                        VALUES (loc_lFlag, cursor_4c_PendEest.Emps, cursor_4c_PendEest.Dopes, cursor_4c_PendEest.Numes, ;
                                cursor_4c_PendEest.MascNum, cursor_4c_PendEest.Datas, loc_cOrigem, loc_cDestino, ;
                                cursor_4c_PendEest.Valos)
                ENDSCAN

                IF USED("cursor_4c_PendEest")
                    USE IN cursor_4c_PendEest
                ENDIF

                SELECT cursor_4c_Pendentes
                GO TOP

                THIS.this_cDopesNivel  = loc_cDopesNivel
                THIS.this_cNumeroNivel = loc_cNumeroNivel
                THIS.this_nPuxaOrigem  = loc_nPuxaOrigem
                THIS.this_nPuxaDestino = loc_nPuxaDestino

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarPendencia - vincula a pendencia CORRENTE de cursor_4c_Pendentes
    * ao documento corrente (crSigMvCab), gravando o vinculo em
    * SigMvCab.ChkSubn. Equivalente ao PROCEDURE Marca() do legado - esta EH
    * a persistencia real deste dialogo (ver cabecalho do arquivo: nao ha
    * Inserir()/Atualizar() de registro proprio porque o dado gravado
    * pertence a SigMvCab, nao a uma tabela deste BO).
    *
    * par_lAutomatico (.T./.F.) suprime os MsgAviso de bloqueio - equivalente
    * a "llAutomatico" do legado, usado pelo botao "Selecionar Tudo".
    *
    * Apos marcar com sucesso, this_cOrigemDesc/this_cDestinoDesc/
    * this_cResponsavelDesc ficam com a razao social resolvida (SigCdCli)
    * das contas de Origem/Destino/Responsavel de crSigMvCab, para o FORM
    * repassar aos controles do form pai.
    *
    * Retorno: .T. se marcou com sucesso; .F. se bloqueado ou se falhou a
    * gravacao (mensagem em this_cMensagemErro).
    *--------------------------------------------------------------------------
    PROCEDURE MarcarPendencia(par_lAutomatico)
        LOCAL loc_lResultado, loc_lProsseguir, loc_lAutomatico
        LOCAL loc_cNivel, loc_nNumNivel, loc_cSQL, loc_nResultado
        LOCAL loc_nPuxaOrigem, loc_nPuxaDestino, loc_lFixGOrigs, loc_lFixGDests
        LOCAL loc_nItens

        loc_lResultado  = .F.
        loc_lProsseguir = .T.
        loc_lAutomatico = (par_lAutomatico = .T.)
        THIS.this_cMensagemErro = ""

        TRY
            IF loc_lProsseguir
                IF !USED("cursor_4c_Pendentes")
                    THIS.this_cMensagemErro = "Nenhuma pendencia selecionada."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF EOF("cursor_4c_Pendentes")
                    THIS.this_cMensagemErro = "Nenhuma pendencia selecionada."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF !USED("crSigMvCab")
                    THIS.this_cMensagemErro = "Cursor do movimento corrente (crSigMvCab) nao esta aberto."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF EOF("crSigMvCab")
                    THIS.this_cMensagemErro = "Cursor do movimento corrente (crSigMvCab) nao esta posicionado."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF !USED("crLclMvItn") OR !USED("TmpOperacao")
                    THIS.this_cMensagemErro = "Cursores do movimento corrente (crLclMvItn/TmpOperacao) nao estao abertos."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                THIS.CarregarDoCursor("cursor_4c_Pendentes")
                loc_cNivel = THIS.ObterChavePrimaria()

                IF USED("cursor_4c_TempOpe")
                    USE IN cursor_4c_TempOpe
                ENDIF

                loc_cSQL = "SELECT NDopes FROM " + THIS.this_cTabelaSigCdOpe + ;
                           " WHERE Dopes = " + EscaparSQL(THIS.this_cDopes)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TempOpe")

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                    loc_lProsseguir = .F.
                ELSE
                    loc_nNumNivel = VAL(STR(cursor_4c_TempOpe.NDopes, 4) + TRANSFORM(THIS.this_nNumes, "@L 999999"))
                    USE IN cursor_4c_TempOpe
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF SEEK(loc_nNumNivel, "TmpOperacao", "Codigos")
                    IF !loc_lAutomatico
                        MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o J" + CHR(225) + " Digitada!!!", "Aten" + CHR(231) + CHR(227) + "o")
                    ENDIF
                    THIS.this_cMensagemErro = "Movimentacao ja digitada."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF USED("cursor_4c_TempOpe")
                    USE IN cursor_4c_TempOpe
                ENDIF

                loc_cSQL = "SELECT FixGDests, FixGOrigs, ConOSubs, ConDSubs FROM " + THIS.this_cTabelaSigCdOpe + ;
                           " WHERE Dopes = " + EscaparSQL(crSigMvCab.Dopes)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TempOpe")

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                    loc_lProsseguir = .F.
                ELSE
                    loc_nPuxaOrigem  = TratarNulo(cursor_4c_TempOpe.ConOSubs, 0)
                    loc_nPuxaDestino = TratarNulo(cursor_4c_TempOpe.ConDSubs, 0)
                    loc_lFixGOrigs   = cursor_4c_TempOpe.FixGOrigs
                    loc_lFixGDests   = cursor_4c_TempOpe.FixGDests
                    USE IN cursor_4c_TempOpe
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF USED("cursor_4c_PendEest")
                    USE IN cursor_4c_PendEest
                ENDIF

                loc_cSQL = "SELECT ChkSubn, Obses, GrupoOs, ContaOs, GrupoDs, ContaDs, GrVends, Vends FROM " + ;
                           THIS.this_cTabelaSigMvCab + " WHERE EmpDopNums = " + EscaparSQL(loc_cNivel)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PendEest")

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                DO CASE
                    CASE cursor_4c_PendEest.ChkSubn
                        IF !loc_lAutomatico
                            MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o J" + CHR(225) + " Utilizada Em Outra Opera" + CHR(231) + CHR(227) + "o!!!", "Aten" + CHR(231) + CHR(227) + "o")
                        ENDIF
                        THIS.this_cMensagemErro = "Movimentacao ja utilizada em outra operacao."
                        loc_lProsseguir = .F.

                    CASE !EMPTY(crSigMvCab.ContaDs) AND cursor_4c_PendEest.ContaDs <> crSigMvCab.ContaDs
                        IF !loc_lAutomatico
                            MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o de Outra Conta!!!", "Aten" + CHR(231) + CHR(227) + "o")
                        ENDIF
                        THIS.this_cMensagemErro = "Movimentacao de outra conta."
                        loc_lProsseguir = .F.

                    CASE !EMPTY(crSigMvCab.ContaOs) AND cursor_4c_PendEest.ContaOs <> crSigMvCab.ContaOs
                        IF !loc_lAutomatico
                            MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o de Outra Conta!!!", "Aten" + CHR(231) + CHR(227) + "o")
                        ENDIF
                        THIS.this_cMensagemErro = "Movimentacao de outra conta."
                        loc_lProsseguir = .F.
                ENDCASE
            ENDIF

            IF loc_lProsseguir
                loc_cSQL = "UPDATE " + THIS.this_cTabelaSigMvCab + " SET ChkSubn = 1, DtAlts = GETDATE(), DtBaixas = " + ;
                           FormatarDataSQL(crSigMvCab.Datas) + " WHERE EmpDopNums = " + EscaparSQL(loc_cNivel)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                SELECT crLclMvItn
                DELETE ALL FOR EMPTY(Cpros)
                GO BOTTOM

                SELECT TmpOperacao
                INSERT INTO TmpOperacao (Codigos) VALUES (loc_nNumNivel)

                IF EMPTY(crSigMvCab.Obses)
                    REPLACE Obses WITH cursor_4c_PendEest.Obses IN crSigMvCab
                ENDIF

                IF INLIST(loc_nPuxaOrigem, 1, 2)
                    IF EMPTY(crSigMvCab.GrupoOs) OR (EMPTY(crSigMvCab.ContaOs) AND !loc_lFixGOrigs)
                        REPLACE GrupoOs WITH IIF(loc_nPuxaOrigem = 1, cursor_4c_PendEest.GrupoOs, cursor_4c_PendEest.GrupoDs) IN crSigMvCab
                    ENDIF
                    IF EMPTY(crSigMvCab.ContaOs)
                        REPLACE ContaOs WITH IIF(loc_nPuxaOrigem = 1, cursor_4c_PendEest.ContaOs, cursor_4c_PendEest.ContaDs) IN crSigMvCab
                    ENDIF
                ENDIF

                IF INLIST(loc_nPuxaDestino, 1, 2)
                    IF EMPTY(crSigMvCab.GrupoDs) OR (EMPTY(crSigMvCab.ContaDs) AND !loc_lFixGDests)
                        REPLACE GrupoDs WITH IIF(loc_nPuxaDestino = 1, cursor_4c_PendEest.GrupoOs, cursor_4c_PendEest.GrupoDs) IN crSigMvCab
                    ENDIF
                    IF EMPTY(crSigMvCab.ContaDs)
                        REPLACE ContaDs WITH IIF(loc_nPuxaDestino = 1, cursor_4c_PendEest.ContaOs, cursor_4c_PendEest.ContaDs) IN crSigMvCab
                    ENDIF
                ENDIF

                IF EMPTY(crSigMvCab.GrVends)
                    REPLACE GrVends WITH cursor_4c_PendEest.GrVends IN crSigMvCab
                ENDIF
                IF EMPTY(crSigMvCab.Vends)
                    IF crSigMvCab.GrVends = cursor_4c_PendEest.GrVends
                        REPLACE Vends WITH cursor_4c_PendEest.Vends IN crSigMvCab
                    ENDIF
                ENDIF

                USE IN cursor_4c_PendEest

                IF USED("cursor_4c_Itens")
                    USE IN cursor_4c_Itens
                ENDIF

                loc_cSQL = "SELECT * FROM " + THIS.this_cTabelaSigMvItn + " WHERE EmpDopNums = " + EscaparSQL(loc_cNivel)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Itens")

                IF loc_nResultado >= 0
                    SELECT cursor_4c_Itens
                    SCAN
                        SCATTER MEMVAR MEMO
                        INSERT INTO crLclMvItn FROM MEMVAR
                    ENDSCAN

                    IF USED("cursor_4c_Itens")
                        USE IN cursor_4c_Itens
                    ENDIF
                ENDIF

                loc_nItens = 0
                SELECT crLclMvItn
                SET ORDER TO
                SCAN
                    IF EMPTY(Cpros)
                        LOOP
                    ENDIF
                    loc_nItens = loc_nItens + 1
                    REPLACE cItens WITH loc_nItens
                ENDSCAN

                GO TOP
                IF EOF()
                    INSERT INTO crLclMvItn (Emps, Dopes, Numes, cItens) ;
                        VALUES (crSigMvCab.Emps, crSigMvCab.Dopes, crSigMvCab.Numes, loc_nItens + 1)
                ENDIF
                SET ORDER TO

                THIS.this_cOrigemDesc      = THIS.ObterDescricaoConta(crSigMvCab.ContaOs)
                THIS.this_cDestinoDesc     = THIS.ObterDescricaoConta(crSigMvCab.ContaDs)
                THIS.this_cResponsavelDesc = THIS.ObterDescricaoConta(crSigMvCab.Vends)

                THIS.this_cTabela = THIS.this_cTabelaSigMvCab
                THIS.RegistrarAuditoria("UPDATE")
                THIS.this_cTabela = ""

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarPendencia - desfaz o vinculo da pendencia CORRENTE de
    * cursor_4c_Pendentes com o documento corrente (crSigMvCab), gravando
    * SigMvCab.ChkSubn = 0. Equivalente ao PROCEDURE Desmarca() do legado.
    *
    * Retorno: .T. se desvinculou com sucesso; .F. em falha (mensagem em
    * this_cMensagemErro).
    *--------------------------------------------------------------------------
    PROCEDURE DesmarcarPendencia()
        LOCAL loc_lResultado, loc_lProsseguir, loc_cNivel, loc_nNumNivel
        LOCAL loc_cSQL, loc_nResultado

        loc_lResultado  = .F.
        loc_lProsseguir = .T.
        THIS.this_cMensagemErro = ""

        TRY
            IF loc_lProsseguir
                IF !USED("cursor_4c_Pendentes")
                    THIS.this_cMensagemErro = "Nenhuma pendencia selecionada."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF EOF("cursor_4c_Pendentes")
                    THIS.this_cMensagemErro = "Nenhuma pendencia selecionada."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF !USED("crSigMvCab")
                    THIS.this_cMensagemErro = "Cursor do movimento corrente (crSigMvCab) nao esta aberto."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF EOF("crSigMvCab")
                    THIS.this_cMensagemErro = "Cursor do movimento corrente (crSigMvCab) nao esta posicionado."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                THIS.CarregarDoCursor("cursor_4c_Pendentes")
                loc_cNivel = THIS.ObterChavePrimaria()

                IF USED("cursor_4c_TempOpe")
                    USE IN cursor_4c_TempOpe
                ENDIF

                loc_cSQL = "SELECT NDopes FROM " + THIS.this_cTabelaSigCdOpe + ;
                           " WHERE Dopes = " + EscaparSQL(THIS.this_cDopes)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TempOpe")

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                    loc_lProsseguir = .F.
                ELSE
                    loc_nNumNivel = VAL(STR(cursor_4c_TempOpe.NDopes, 4) + TRANSFORM(THIS.this_nNumes, "@L 999999"))
                    USE IN cursor_4c_TempOpe
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF USED("crLclMvItn")
                    SELECT crLclMvItn
                    DELETE ALL FOR Dopes + STR(Numes, 6) = THIS.this_cDopes + STR(THIS.this_nNumes, 6)
                ENDIF

                IF USED("TmpOperacao")
                    IF SEEK(loc_nNumNivel, "TmpOperacao", "Codigos")
                        SELECT TmpOperacao
                        DELETE
                    ENDIF
                ENDIF

                loc_cSQL = "UPDATE " + THIS.this_cTabelaSigMvCab + " SET ChkSubn = 0, DtAlts = GETDATE(), DtBaixas = " + ;
                           FormatarDataSQL(crSigMvCab.Datas) + " WHERE EmpDopNums = " + EscaparSQL(loc_cNivel)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                    loc_lProsseguir = .F.
                ELSE
                    THIS.this_cTabela = THIS.this_cTabelaSigMvCab
                    THIS.RegistrarAuditoria("UPDATE")
                    THIS.this_cTabela = ""

                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir/Atualizar/ExecutarExclusao - PROPOSITALMENTE nao sobrescritos.
    *
    * Este dialogo nao grava um registro proprio (ver cabecalho do arquivo
    * e comentario do Init): a gravacao real e o UPDATE SigMvCab.ChkSubn,
    * feito por MarcarPendencia()/DesmarcarPendencia() acima - que SAO, na
    * pratica, o Inserir()/Atualizar() desta tela. O comportamento padrao
    * herdado de BusinessBase (recusar a operacao) ja eh o correto para
    * estes tres metodos.
    *--------------------------------------------------------------------------

ENDDEFINE
