*==============================================================================
* SigOpOcaBO.prg - Business Object para SigOpOca (Auditoria de Lancamentos)
*
* Legado  : SIGOPOCA.SCX (task773) - dialogo MODAL "Auditoria de Lancamentos"
* Tabelas : SigMvCcr (UPDATE DtAudits/Auditors - lancamento sendo auditado)
*           SigCqOch (UPDATE ObsAudts - log da acao de auditoria, PK cidchaves)
*
* CONTEXTO (legado)
* ------------------
* SIGOPOCA eh aberto de dentro do Click do Chk_Auditoria de SIGOPIND (ja
* migrado como Formsigopind.prg), e SOMENTE quando CrSigCdPac.ObsAudts = 1
* (parametro do sistema exigindo observacao ao auditar/desauditar). ANTES de
* abrir o dialogo, o form pai ja:
*   1) decidiu lcTipo ('Auditado'/'DesAuditado') e llData (Datetime() ou NULL)
*      a partir do estado do CheckBox;
*   2) inseriu uma linha em CrSigCqOch (Nopers, Datars, TpLancs, Datas,
*      Usuars, CidChaves=fUniqueIds(), DtLancs=CrSigMvCcr.Datas) - AINDA SO
*      NO BUFFER, nao commitada;
*   3) chama DO Form SigOpOca With ThisForm.datasessionid, ThisForm, llTval,
*      ThisForm.page.hist.Chk_Auditoria.Top.
*
* O dialogo (Set DataSession To Arquivos) passa a compartilhar a SESSAO do
* form pai e portanto ve as MESMAS CrSigCqOch (a linha recem-inserida, ainda
* em buffer) e CrSigMvCcr (o lancamento sendo auditado, ja posicionado). O
* Confirmar grava a observacao digitada na linha de log, commita essa linha,
* executa o UPDATE em SigMvCcr e fecha o dialogo.
*
* ADAPTACAO DE ARQUITETURA (PILAR 3)
* -----------------------------------
* A nova arquitetura NAO compartilha data session entre forms (cada form eh
* independente) - por isso os valores que o legado le via cursor
* compartilhado (CrSigMvCcr.Grupos/Contas/Moedas/Nopers/Valors e
* CrSigCqOch.Datas/Cidchaves) chegam aqui como PROPRIEDADES explicitas,
* preenchidas pelo Form a partir do que o chamador fornecer (equivalente
* funcional ao que o legado buscava no cursor). O SQL executado (Fase 2)
* transcreve LITERALMENTE o UPDATE do dump do legado (filtro por
* Grupos+Contas+Moedas+Nopers, NAO por Cidchaves - essa variante com
* Cidchaves pertence ao Click do form pai, nao a este dialogo).
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*==============================================================================

DEFINE CLASS SigOpOcaBO AS BusinessBase

    *==========================================================================
    * LANCAMENTO SENDO AUDITADO (SigMvCcr) - chave composta usada no WHERE
    * do UPDATE (transcrita literal do cmd_ok.Click do legado) + valor
    * exibido em Get_valor (somente leitura, When do legado devolve .F.)
    *==========================================================================
    this_cGrupos = ""   && char(10) SigMvCcr.grupos
    this_cContas = ""   && char(10) SigMvCcr.contas
    this_cMoedas = ""   && char(3)  SigMvCcr.moedas
    this_nNopers = 0    && numeric(7,0) SigMvCcr.nopers
    this_nValors = 0    && numeric(11,2) SigMvCcr.valors - exibido em Get_valor

    *==========================================================================
    * TIPO DA OPERACAO (pTipo do legado) e novos valores a gravar em
    * SigMvCcr.DtAudits/Auditors (Fase 2 monta exatamente como o cmd_ok.Click:
    * Tipo=.T. -> DtAudits=Datetime(),Auditors=Usuar; Tipo=.F. -> DtAudits=
    * NULL,Auditors=espacos)
    *==========================================================================
    this_lTipo     = .F.   && .T. = Auditado / .F. = DesAuditado
    this_dDtAudits = {}    && datetime NULL - novo valor de SigMvCcr.dtaudits
    this_cAuditors = ""    && char(10) - novo valor de SigMvCcr.auditors

    *==========================================================================
    * LOG DA AUDITORIA (SigCqOch) - linha ja inserida pelo form pai (em
    * buffer, ainda nao commitada), identificada pela cidchaves que o pai
    * gerou com fUniqueIds(). This_dDataAuditoria espelha CrSigCqOch.Datas,
    * exibido em Get_DtAudits (somente leitura, When do legado devolve .F.)
    *==========================================================================
    this_cCidchavesLog  = ""  && char(20) SigCqOch.cidchaves (PK da linha de log)
    this_dDataAuditoria = {}  && datetime NULL SigCqOch.datas - exibido em Get_DtAudits
    this_cObsAudts      = ""  && text NULL SigCqOch.obsaudts - digitado em Memo_Obs

    *==========================================================================
    * CONTEXTO DA SESSAO - no legado era a PUBLIC Usuar
    *==========================================================================
    this_cUsuario = ""   && char(10) usuario logado (gc_4c_UsuarioLogado)

    *==========================================================================
    * Init - Configura tabela principal e chave primaria
    *
    * A tabela VAI no DODEFAULT: BusinessBase.Init() so instancia
    * this_oDataAccess quando recebe o parametro pcTabela. Com DODEFAULT()
    * sem argumento o objeto de acesso a dados fica .NULL. e todo metodo
    * herdado que depende dele devolve .F. reclamando que o acesso a dados
    * nao foi inicializado.
    *
    * this_cTabela = "SigMvCcr" espelha o padrao do SigOpEncBO (mesma familia
    * de dialogos de conta corrente que tocam mais de uma tabela) - o UPDATE
    * real desta tela filtra por Grupos+Contas+Moedas+Nopers (regra #17:
    * transcrever literal), nao por cidchaves; this_cCampoChave fica com o
    * nome convencional da PK de SigMvCcr so para a nomenclatura herdada de
    * BusinessBase (ObterChavePrimaria/RegistrarAuditoria) ter um valor
    * coerente com o schema.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT("SigMvCcr")

            THIS.this_cTabela     = "SigMvCcr"
            THIS.this_cCampoChave = "cidchaves"

            *-- Contexto da sessao (equivalente a PUBLIC Usuar)
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                THIS.this_cUsuario = ALLTRIM(gc_4c_UsuarioLogado)
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "SigOpOcaBO.Init")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Chave usada por RegistrarAuditoria()
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cGrupos) + ALLTRIM(THIS.this_cContas) + ;
               ALLTRIM(THIS.this_cMoedas) + TRANSFORM(THIS.this_nNopers)
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia as colunas de SigMvCcr (lancamento sendo
    * auditado) e de SigCqOch (linha de log, ja inserida pelo form pai) a
    * partir de UM cursor combinado montado pelo Form - equivalente ao que o
    * legado lia direto de CrSigMvCcr/CrSigCqOch na sessao compartilhada
    * (regra #8 CLAUDE.md: SELECT (par_cAliasCursor) antes de acessar campo).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                *-- SigMvCcr - chave composta usada no WHERE do UPDATE + valor
                *-- exibido em Get_valor
                THIS.this_cGrupos = TratarNulo(grupos, "")
                THIS.this_cContas = TratarNulo(contas, "")
                THIS.this_cMoedas = TratarNulo(moedas, "")
                THIS.this_nNopers = TratarNulo(nopers, 0)
                THIS.this_nValors = TratarNulo(valors, 0)

                *-- SigCqOch - linha de log (PK cidchaves) + data exibida em
                *-- Get_DtAudits (somente leitura)
                THIS.this_cCidchavesLog  = TratarNulo(cidchaves, "")
                THIS.this_dDataAuditoria = TratarNulo(datas, {})
                THIS.this_cObsAudts      = TratarNulo(obsaudts, "")

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em SigOpOcaBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Executa a confirmacao da auditoria (cmd_ok.Click do legado):
    *
    *   1) decide DtAudits/Auditors conforme this_lTipo (Tipo=.T. -> Auditado:
    *      DtAudits=Datetime(), Auditors=Usuar | Tipo=.F. -> DesAuditado:
    *      DtAudits=NULL, Auditors=espacos)
    *   2) UPDATE SigMvCcr SET DtAudits, Auditors WHERE Grupos+Contas+Moedas+
    *      Nopers (filtro TRANSCRITO literal do dump - regra #17 CLAUDE.md,
    *      NAO eh por cidchaves)
    *   3) UPDATE SigCqOch SET ObsAudts WHERE Cidchaves = this_cCidchavesLog
    *      (equivalente ao "Replace ObsAudts With ThisForm.Memo_Obs.Value in
    *      CrSigCqOch" do legado - a linha em si ja foi inserida e persistida
    *      pelo form pai antes de abrir este dialogo, por isso aqui eh UPDATE
    *      e nao INSERT)
    *
    * Este dialogo NUNCA cria um SigMvCcr novo (sempre atua sobre um
    * lancamento ja existente), por isso Inserir()/ExecutarExclusao() nao sao
    * sobrescritos - o comportamento padrao herdado de BusinessBase (recusar
    * a operacao) ja eh o correto para esses dois casos.
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_cSQLCcr, loc_cSQLOch, loc_nResult, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF THIS.this_lTipo
                THIS.this_dDtAudits = DATETIME()
                THIS.this_cAuditors = THIS.this_cUsuario
            ELSE
                THIS.this_dDtAudits = {}
                THIS.this_cAuditors = SPACE(10)
            ENDIF

            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                    CHR(227) + "o dispon" + CHR(237) + "vel."
                MsgErro(THIS.this_cMensagemErro, "SigOpOcaBO.Atualizar")
                THIS.this_lErroExibido = .T.
            ELSE
                *-- 2) UPDATE SigMvCcr - filtro EXATO do legado
                loc_cSQLCcr = "UPDATE SigMvCcr SET"
                loc_cSQLCcr = loc_cSQLCcr + " dtaudits = " + FormatarDataSQL(THIS.this_dDtAudits) + ","
                loc_cSQLCcr = loc_cSQLCcr + " auditors = " + EscaparSQL(LEFT(THIS.this_cAuditors, 10))
                loc_cSQLCcr = loc_cSQLCcr + " WHERE grupos = " + EscaparSQL(LEFT(THIS.this_cGrupos, 10))
                loc_cSQLCcr = loc_cSQLCcr + " AND contas = " + EscaparSQL(LEFT(THIS.this_cContas, 10))
                loc_cSQLCcr = loc_cSQLCcr + " AND moedas = " + EscaparSQL(LEFT(THIS.this_cMoedas, 3))
                loc_cSQLCcr = loc_cSQLCcr + " AND nopers = " + FormatarNumeroSQL(THIS.this_nNopers, 0)

                IF USED("cursor_4c_UpdateCcr")
                    USE IN cursor_4c_UpdateCcr
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQLCcr, "cursor_4c_UpdateCcr")

                IF loc_nResult < 0
                    MsgErro("Erro ao atualizar o lan" + CHR(231) + "amento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    IF USED("cursor_4c_UpdateCcr")
                        USE IN cursor_4c_UpdateCcr
                    ENDIF

                    *-- 3) UPDATE SigCqOch - observacao digitada em Memo_Obs
                    loc_cSQLOch = "UPDATE SigCqOch SET obsaudts = " + EscaparSQL(THIS.this_cObsAudts) + ;
                        " WHERE cidchaves = " + EscaparSQL(LEFT(THIS.this_cCidchavesLog, 20))

                    IF USED("cursor_4c_UpdateOch")
                        USE IN cursor_4c_UpdateOch
                    ENDIF

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQLOch, "cursor_4c_UpdateOch")

                    IF loc_nResult < 0
                        MsgErro("Erro ao gravar a observa" + CHR(231) + CHR(227) + "o da auditoria:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ELSE
                        IF USED("cursor_4c_UpdateOch")
                            USE IN cursor_4c_UpdateOch
                        ENDIF

                        THIS.RegistrarAuditoria("UPDATE")
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em SigOpOcaBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
