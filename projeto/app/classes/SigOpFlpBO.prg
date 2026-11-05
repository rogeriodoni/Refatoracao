*==============================================================================
* SigOpFlpBO.prg
*
* Business Object para SigOpFlp (Consulta de FollowUp)
* Tabela: SigCdClh
* Chave primaria: cidchaves (gerada via fUniqueIds(), nao e sequencial)
*
* FASE 2/8: Metodos CRUD (CarregarDoCursor, Inserir, Atualizar,
* ExecutarExclusao, ObterChavePrimaria, RegistrarAuditoria)
*==============================================================================

DEFINE CLASS SigOpFlpBO AS BusinessBase

    *-- Propriedades da entidade (mapeiam 1:1 as colunas de SigCdClh)
    this_cCidchaves = ""        && char(20) NOT NULL - PK, gerada via fUniqueIds()
    this_cGrupos    = ""        && char(10) NOT NULL - grupo do cliente/conta
    this_cIclis     = ""        && char(10) NOT NULL - codigo do cliente/conta
    this_cGrucontas = ""        && char(20) NOT NULL - Grupos + IClis concatenados
    this_dDatas     = {}        && datetime NULL     - data/hora do registro de historico
    this_cUsuars    = ""        && char(10) NOT NULL - usuario que gravou/alterou
    this_dDatagens  = {}        && datetime NULL     - data/hora do agendamento
    this_cHists     = ""        && char(250) NOT NULL - historico (tipo/ocorrencia)
    this_cObs       = ""        && text NULL          - observacao (memo)
    this_lAutos     = .F.       && bit NOT NULL        - .T. = historico automatico (nao exclui livremente)
    this_cEmps      = ""        && char(3) NOT NULL   - empresa
    this_nNopers    = 0         && numeric(10,0) NOT NULL - numero da operacao (filtro do FollowUp)
    this_cCcargs    = ""        && char(10) NOT NULL  - cargo/area responsavel
    this_cTplancs   = ""        && char(2) NOT NULL   - tipo de lancamento
    this_cCodsits   = ""        && char(2) NOT NULL   - codigo de situacao

    *-- Dados de SigCdCli resolvidos por CarregarDadosCliente (somente
    *-- exibicao/edicao do painel de Contato - nao sao colunas de SigCdClh)
    this_cRClis     = ""        && char(50) - razao social da conta
    this_cDDDs      = ""        && char(4)  - DDD de contato
    this_cTel1s     = ""        && char(20) - telefone 1
    this_cTel2s     = ""        && char(20) - telefone 2
    this_cEmails    = ""        && char(50) - e-mail de contato

    *--------------------------------------------------------------------------
    * Init - Inicializa Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela      = "SigCdClh"
        THIS.this_cCampoChave  = "cidchaves"

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave primaria do registro atual
    * (usada por RegistrarAuditoria)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega as propriedades do BO a partir de um cursor
    * posicionado no registro desejado (SELECT * FROM SigCdClh ou subconjunto
    * equivalente). Mapeia TODAS as colunas da tabela.
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar os campos -
    * sintaxe campo nao existe em VFP9.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                IF !EOF()
                    THIS.this_cCidchaves = TratarNulo(cidchaves, "")
                    THIS.this_cGrupos    = TratarNulo(grupos,    "")
                    THIS.this_cIclis     = TratarNulo(iclis,     "")
                    THIS.this_cGrucontas = TratarNulo(grucontas, "")
                    THIS.this_dDatas     = TratarNulo(datas,     {})
                    THIS.this_cUsuars    = TratarNulo(usuars,    "")
                    THIS.this_dDatagens  = TratarNulo(datagens,  {})
                    THIS.this_cHists     = TratarNulo(hists,     "")
                    THIS.this_cObs       = TratarNulo(obs,       "")
                    THIS.this_lAutos     = ConverterParaLogico(autos)
                    THIS.this_cEmps      = TratarNulo(emps,      "")
                    THIS.this_nNopers    = TratarNulo(nopers,    0)

                    *-- Colunas que o legado nem sempre seleciona no cursor de
                    *-- historico (ccargs/tplancs/codsits): guarda defensiva
                    *-- para nao estourar "Variable X is not found" quando o
                    *-- cursor de origem for um subconjunto das colunas.
                    IF TYPE("ccargs") != "U"
                        THIS.this_cCcargs = TratarNulo(ccargs, "")
                    ENDIF
                    IF TYPE("tplancs") != "U"
                        THIS.this_cTplancs = TratarNulo(tplancs, "")
                    ENDIF
                    IF TYPE("codsits") != "U"
                        THIS.this_cCodsits = TratarNulo(codsits, "")
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar hist" + CHR(243) + "rico de FollowUp do cursor:" + ;
                CHR(13) + loException.Message, "SigOpFlpBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparDados - Zera as propriedades de historico antes de um novo
    * registro (chamado por NovoRegistro(), dentro de BtnSalvarClick). Sem
    * este override, campos sem controle na tela (Ccargs/Tplancs/Codsits)
    * ficariam com o valor do ULTIMO registro carregado por CarregarDoCursor
    * (ex.: um Alterar anterior na mesma vida do form - regra #32) e um
    * Incluir subsequente gravaria essa sobra. Grupos/IClis/Nopers NAO entram
    * aqui porque THIS.PainelParaBO() os repoe explicitamente no ramo
    * INSERIR, a partir do contexto (conta/grupo/operacao) do form.
    *--------------------------------------------------------------------------
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cCidchaves = ""
        THIS.this_dDatas     = {}
        THIS.this_dDatagens  = {}
        THIS.this_cHists     = ""
        THIS.this_cObs       = ""
        THIS.this_lAutos     = .F.
        THIS.this_cCcargs    = ""
        THIS.this_cTplancs   = ""
        THIS.this_cCodsits   = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de gravar (transcrito do legado:
    * BtnOk.Click do SIGOPFLP nao valida nada alem dos campos ja exigidos
    * pela tela; Historico e Observacao sao de preenchimento livre)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cGrupos)) OR EMPTY(ALLTRIM(THIS.this_cIclis))
            THIS.this_cMensagemErro = "Grupo/Conta n" + CHR(227) + "o informados para o Hist" + CHR(243) + "rico de FollowUp!"
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cHists))
            THIS.this_cMensagemErro = "Hist" + CHR(243) + "rico n" + CHR(227) + "o pode ficar em branco!"
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro de historico de FollowUp em SigCdClh
    * Transcrito de SIGOPFLP.Cnt_Inserir.BtnOk.Click (Case Tipo = 'INSERIR')
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cGruContas
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidchaves))
                THIS.this_cCidchaves = fUniqueIds()
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cEmps))
                THIS.this_cEmps = go_4c_Sistema.cCodEmpresa
            ENDIF

            *-- Legado: "Usuars With Usuar" - sempre o usuario logado no momento
            THIS.this_cUsuars = gc_4c_UsuarioLogado

            *-- Legado: "GruContas With lcGrupo + lcConta" (char(10) + char(10))
            loc_cGruContas       = PADR(THIS.this_cGrupos, 10) + PADR(THIS.this_cIclis, 10)
            THIS.this_cGrucontas = loc_cGruContas

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdClh (grupos, iclis, grucontas, datas, usuars, datagens, hists, obs, autos, emps, nopers, ccargs, tplancs, cidchaves, codsits)
                VALUES (
                    <<EscaparSQL(LEFT(THIS.this_cGrupos, 10))>>,
                    <<EscaparSQL(LEFT(THIS.this_cIclis, 10))>>,
                    <<EscaparSQL(LEFT(loc_cGruContas, 20))>>,
                    <<FormatarDataSQL(THIS.this_dDatas)>>,
                    <<EscaparSQL(LEFT(THIS.this_cUsuars, 10))>>,
                    <<FormatarDataSQL(THIS.this_dDatagens)>>,
                    <<EscaparSQL(LEFT(THIS.this_cHists, 250))>>,
                    <<EscaparSQL(THIS.this_cObs)>>,
                    <<FormatarNumeroSQL(IIF(THIS.this_lAutos, 1, 0), 0)>>,
                    <<EscaparSQL(LEFT(THIS.this_cEmps, 3))>>,
                    <<FormatarNumeroSQL(THIS.this_nNopers, 0)>>,
                    <<EscaparSQL(LEFT(THIS.this_cCcargs, 10))>>,
                    <<EscaparSQL(LEFT(THIS.this_cTplancs, 2))>>,
                    <<EscaparSQL(LEFT(THIS.this_cCidchaves, 20))>>,
                    <<EscaparSQL(LEFT(THIS.this_cCodsits, 2))>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir Hist" + CHR(243) + "rico de FollowUp:" + ;
                    CHR(13) + CapturarErroSQL()
                MostrarErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao inserir:" + CHR(13) + loException.Message
            MostrarErro(THIS.this_cMensagemErro, "SigOpFlpBO.Inserir")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente de historico de FollowUp
    * Transcrito de SIGOPFLP.Cnt_Inserir.BtnOk.Click (Case Tipo = 'ALTERAR'):
    * o legado so altera Datas/Usuars/DatAgens/Hists/Obs - Grupos, IClis,
    * GruContas, Autos, Emps, Nopers, Ccargs, Tplancs e Codsits permanecem
    * como gravados na inclusao (nao fazem parte do Replace original).
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Legado: "Usuars With Usuar" (tambem no ramo ALTERAR)
            THIS.this_cUsuars = gc_4c_UsuarioLogado

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdClh
                SET datas    = <<FormatarDataSQL(THIS.this_dDatas)>>,
                    usuars   = <<EscaparSQL(LEFT(THIS.this_cUsuars, 10))>>,
                    datagens = <<FormatarDataSQL(THIS.this_dDatagens)>>,
                    hists    = <<EscaparSQL(LEFT(THIS.this_cHists, 250))>>,
                    obs      = <<EscaparSQL(THIS.this_cObs)>>
                WHERE cidchaves = <<EscaparSQL(LEFT(THIS.this_cCidchaves, 20))>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar Hist" + CHR(243) + "rico de FollowUp:" + ;
                    CHR(13) + CapturarErroSQL()
                MostrarErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao atualizar:" + CHR(13) + loException.Message
            MostrarErro(THIS.this_cMensagemErro, "SigOpFlpBO.Atualizar")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AntesDeExcluir - Guardas transcritas de SIGOPFLP.cmdApagaitem.cmdApagar.
    * Click: (1) so quem gravou/alterou o registro pode excluir; (2) historico
    * AUTOMATICO (Autos=.T.) com Obs e Datas preenchidos nao pode ser excluido.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AntesDeExcluir()
        LOCAL loc_lPermitido
        loc_lPermitido = .T.

        IF ALLTRIM(UPPER(THIS.this_cUsuars)) != ALLTRIM(UPPER(NVL(gc_4c_UsuarioLogado, "")))
            THIS.this_cMensagemErro = "Registro Inserido/Alterado por outro usu" + CHR(225) + "rio !!!"
            loc_lPermitido = .F.
        ENDIF

        IF loc_lPermitido AND THIS.this_lAutos AND !EMPTY(THIS.this_cObs) AND !EMPTY(THIS.this_dDatas)
            THIS.this_cMensagemErro = "Hist" + CHR(243) + "rico Autom" + CHR(225) + "tico !!!"
            loc_lPermitido = .F.
        ENDIF

        RETURN loc_lPermitido
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui o registro de historico de FollowUp
    * Transcrito de SIGOPFLP.cmdApagaitem.cmdApagar.Click
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdClh WHERE cidchaves = " + ;
                EscaparSQL(LEFT(THIS.this_cCidchaves, 20))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao excluir Hist" + CHR(243) + "rico de FollowUp:" + ;
                    CHR(13) + CapturarErroSQL()
                MostrarErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao excluir:" + CHR(13) + loException.Message
            MostrarErro(THIS.this_cMensagemErro, "SigOpFlpBO.ExecutarExclusao")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDadosCliente - Resolve Grupo / Razao Social / Contato a partir do
    * codigo da conta recebido pelo form.
    * Transcrito de SIGOPFLP.Init (lcQryCli):
    *   Select a.Grupos,a.IClis,a.RClis,a.DDDs,a.Tel1s,a.Tel2s,a.EMails
    *     From SigCdCli a Where a.IClis = ?lcCliente
    * Popula cursor_4c_Cliente (consumido pelos campos de CntGruCon/CntContato)
    * e as properties this_cGrupos / this_cIclis, que sao o filtro do historico.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDadosCliente(par_cConta)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cConta
        loc_lSucesso = .F.
        loc_cConta   = IIF(VARTYPE(par_cConta) = "C", par_cConta, "")

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                    CHR(227) + "o dispon" + CHR(237) + "vel."
            ELSE
                *-- USE IN (nao ZAP+APPEND): o SQLEXEC recria o alias com a
                *-- estrutura correta e o form refaz o vinculo da grade logo
                *-- depois, em VincularGrade().
                IF USED("cursor_4c_Cliente")
                    IF CURSORGETPROP("Buffering", "cursor_4c_Cliente") > 1
                        TABLEREVERT(.T., "cursor_4c_Cliente")
                    ENDIF
                    USE IN cursor_4c_Cliente
                ENDIF

                loc_cSQL = "SELECT grupos, iclis, rclis, ddds, tel1s, tel2s, emails" + ;
                    " FROM SigCdCli" + ;
                    " WHERE iclis = " + EscaparSQL(PADR(loc_cConta, 10))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cliente")

                IF loc_nResultado >= 0
                    IF USED("cursor_4c_Cliente") AND RECCOUNT("cursor_4c_Cliente") > 0
                        SELECT cursor_4c_Cliente
                        GO TOP
                        THIS.this_cGrupos = TratarNulo(cursor_4c_Cliente.grupos, "")
                        THIS.this_cIclis  = TratarNulo(cursor_4c_Cliente.iclis, "")
                        THIS.this_cRClis  = TratarNulo(cursor_4c_Cliente.rclis, "")
                        THIS.this_cDDDs   = TratarNulo(cursor_4c_Cliente.ddds, "")
                        THIS.this_cTel1s  = TratarNulo(cursor_4c_Cliente.tel1s, "")
                        THIS.this_cTel2s  = TratarNulo(cursor_4c_Cliente.tel2s, "")
                        THIS.this_cEmails = TratarNulo(cursor_4c_Cliente.emails, "")
                        loc_lSucesso = .T.
                    ELSE
                        THIS.this_cMensagemErro = "Conta [" + ALLTRIM(loc_cConta) + "] n" + ;
                            CHR(227) + "o cadastrada!"
                    ENDIF
                ELSE
                    THIS.this_cMensagemErro = "Erro ao carregar dados da conta:" + ;
                        CHR(13) + CapturarErroSQL()
                    MostrarErro(THIS.this_cMensagemErro, "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao carregar dados da conta:" + CHR(13) + loException.Message
            MostrarErro(THIS.this_cMensagemErro, "SigOpFlpBO.CarregarDadosCliente")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarContato - Atualiza telefones/e-mail da conta em SigCdCli.
    * Transcrito de SIGOPFLP.CommandGroup1.Command1.Valid (botao Encerrar):
    *   Update SigCdCli Set Tel1s = ?,Tel2s = ?,DDDs = ?,EMails = ?
    *     Where IClis = '<THIS.this_cIclis>'
    * THIS.this_cIclis precisa ja estar resolvido (CarregarDadosCliente).
    *--------------------------------------------------------------------------
    PROCEDURE SalvarContato(par_cTel1, par_cTel2, par_cDDDs, par_cEmail)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cIclis))
                THIS.this_cMensagemErro = "Conta n" + CHR(227) + "o resolvida - " + ;
                    "contato n" + CHR(227) + "o pode ser gravado."
            ELSE
                TEXT TO loc_cSQL TEXTMERGE NOSHOW
                    UPDATE SigCdCli
                    SET tel1s  = <<EscaparSQL(LEFT(IIF(VARTYPE(par_cTel1) = "C", par_cTel1, ""), 20))>>,
                        tel2s  = <<EscaparSQL(LEFT(IIF(VARTYPE(par_cTel2) = "C", par_cTel2, ""), 20))>>,
                        ddds   = <<EscaparSQL(LEFT(IIF(VARTYPE(par_cDDDs) = "C", par_cDDDs, ""), 4))>>,
                        emails = <<EscaparSQL(LEFT(IIF(VARTYPE(par_cEmail) = "C", par_cEmail, ""), 50))>>
                    WHERE iclis = <<EscaparSQL(PADR(THIS.this_cIclis, 10))>>
                ENDTEXT

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao gravar contato da conta:" + ;
                        CHR(13) + CapturarErroSQL()
                    MostrarErro(THIS.this_cMensagemErro, "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao gravar contato:" + CHR(13) + loException.Message
            MostrarErro(THIS.this_cMensagemErro, "SigOpFlpBO.SalvarContato")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarHistorico - Popula cursor_4c_Dados com o historico de FollowUp da
    * conta/grupo informados, que e a fonte da grade GridFollowUp.
    *
    * Transcrito de SIGOPFLP.Init (duas etapas, iguais ao legado):
    *   1) lStrQuery = Select Emps,IClis,Grupos,GruContas,Autos,Usuars,Datas,
    *                  DatAgens,Hists,Obs,CIdChaves,Nopers From SigCdClh
    *                  Where IClis = ?_Conta And Grupos = ?_Grupo   -> TmpCliH
    *   2) Select ...,Nvl(Datas,CrBranco.Datas) As Datas,
    *                Nvl(DatAgens,CrBranco.Datas) As DatAgens,
    *                Nvl(Obs,CrBranco.Obs) As Obs ...
    *        From TmpCliH
    *        Where Iif(ThisForm.Noper = 0,0=0,Nopers = ThisForm.Noper)
    *        Order By Datas Into Cursor CrSigCdClh ReadWrite
    *
    * O cursor CrBranco do legado (Obs memo vazio + Datas datetime vazio) e
    * reproduzido em cursor_4c_Branco: ele garante que o NVL devolva MEMO para
    * Obs (e nao caractere truncado) e data vazia em vez de .NULL. na grade.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarHistorico(par_cGrupo, par_cConta, par_nNoper)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        LOCAL loc_cGrupo, loc_cConta, loc_nNoper
        loc_lSucesso = .F.
        loc_cGrupo   = IIF(VARTYPE(par_cGrupo) = "C", par_cGrupo, "")
        loc_cConta   = IIF(VARTYPE(par_cConta) = "C", par_cConta, "")
        loc_nNoper   = IIF(VARTYPE(par_nNoper) = "N", par_nNoper, 0)

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                    CHR(227) + "o dispon" + CHR(237) + "vel."
            ELSE
                *-- Legado: Create Cursor CrBranco (Obs m,Datas t)
                *--         Insert Into CrBranco (Obs,Datas) Values ('',{})
                IF !USED("cursor_4c_Branco")
                    CREATE CURSOR cursor_4c_Branco (obs M, datas T)
                    INSERT INTO cursor_4c_Branco (obs, datas) VALUES ("", {})
                ENDIF
                SELECT cursor_4c_Branco
                GO TOP

                *-- Etapa 1: equivalente ao TmpCliH do legado. O SQLEXEC nunca
                *-- vai direto para o alias da grade - isso zeraria o
                *-- ColumnCount dela e a grade viraria um retangulo branco.
                IF USED("cursor_4c_DadosTmp")
                    IF CURSORGETPROP("Buffering", "cursor_4c_DadosTmp") > 1
                        TABLEREVERT(.T., "cursor_4c_DadosTmp")
                    ENDIF
                    USE IN cursor_4c_DadosTmp
                ENDIF

                loc_cSQL = "SELECT emps, iclis, grupos, grucontas, autos, usuars," + ;
                    " datas, datagens, hists, obs, cidchaves, nopers" + ;
                    " FROM SigCdClh" + ;
                    " WHERE iclis = " + EscaparSQL(PADR(loc_cConta, 10)) + ;
                    " AND grupos = " + EscaparSQL(PADR(loc_cGrupo, 10))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")

                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Favor reinicializar o processo !!!" + CHR(13) + ;
                        CapturarErroSQL()
                    MostrarErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o (SigCdClh)")
                ELSE
                    *-- Etapa 2: cursor da grade. USE IN antes de recriar - o
                    *-- vinculo do Grid e refeito em VincularGrade().
                    IF USED("cursor_4c_Dados")
                        IF CURSORGETPROP("Buffering", "cursor_4c_Dados") > 1
                            TABLEREVERT(.T., "cursor_4c_Dados")
                        ENDIF
                        USE IN cursor_4c_Dados
                    ENDIF

                    SELECT emps, iclis, grupos, grucontas, usuars, ;
                           NVL(datas, cursor_4c_Branco.datas)    AS datas, ;
                           NVL(datagens, cursor_4c_Branco.datas) AS datagens, ;
                           hists, ;
                           NVL(obs, cursor_4c_Branco.obs)        AS obs, ;
                           autos, cidchaves, nopers ;
                        FROM cursor_4c_DadosTmp ;
                        WHERE IIF(m.loc_nNoper = 0, 0 = 0, nopers = m.loc_nNoper) ;
                        ORDER BY datas ;
                        INTO CURSOR cursor_4c_Dados READWRITE

                    IF USED("cursor_4c_DadosTmp")
                        USE IN cursor_4c_DadosTmp
                    ENDIF

                    IF USED("cursor_4c_Dados")
                        SELECT cursor_4c_Dados
                        GO TOP
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao carregar hist" + CHR(243) + "rico de FollowUp:" + ;
                CHR(13) + loException.Message
            MostrarErro(THIS.this_cMensagemErro, "SigOpFlpBO.CarregarHistorico")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FecharCursores - Libera os cursores criados por este BO. Chamado pelo
    * Destroy do form (o legado faz ThisForm.poDataMgr.Release no Release).
    *--------------------------------------------------------------------------
    PROCEDURE FecharCursores()
        LOCAL ARRAY loc_aCursores[4]
        LOCAL loc_nI

        loc_aCursores[1] = "cursor_4c_Dados"
        loc_aCursores[2] = "cursor_4c_DadosTmp"
        loc_aCursores[3] = "cursor_4c_Cliente"
        loc_aCursores[4] = "cursor_4c_Branco"

        FOR loc_nI = 1 TO ALEN(loc_aCursores)
            IF USED(loc_aCursores[loc_nI])
                IF CURSORGETPROP("Buffering", loc_aCursores[loc_nI]) > 1
                    TABLEREVERT(.T., loc_aCursores[loc_nI])
                ENDIF
                USE IN (loc_aCursores[loc_nI])
            ENDIF
        ENDFOR

        RETURN .T.
    ENDPROC

ENDDEFINE
