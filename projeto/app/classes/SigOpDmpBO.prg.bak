*====================================================================
* SigOpDmpBO.prg
*
* Business Object para Cadastro de Demonstrativos de Balanco (SigOpDmp)
* Tabela: SigPrDmo (cabecalho) - detalhe em SigCdDpr (fases 2+)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigOpDmpBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigPrDmo)
    this_cNome      = ""    && nome char(20) - chave (nome do demonstrativo)
    this_cContas    = ""    && contas char(10)
    this_cGrupos    = ""    && grupos char(10)
    this_cCidChaves = ""    && cidchaves char(20) - PK Fortyus (gerada em fUniqueIds())

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrDmo"
            THIS.this_cCampoChave = "nome"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SigOpDmpBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave (nome) do demonstrativo para auditoria
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cNome)
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                *-- O 2o argumento do TratarNulo e o valor PADRAO, nao o tipo:
                *-- TratarNulo(x, "C") devolveria a letra "C" se a coluna
                *-- viesse NULL. Nenhuma coluna de SigPrDmo aceita nulo
                *-- no schema, logo o caminho era inerte - mas o
                *-- padrao certo de coluna char e a string vazia.
                THIS.this_cNome      = TratarNulo(nome,      "")
                THIS.this_cContas    = TratarNulo(contas,    "")
                THIS.this_cGrupos    = TratarNulo(grupos,    "")
                THIS.this_cCidChaves = TratarNulo(cidchaves, "")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "SigOpDmpBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigPrDmo
    * cidchaves = PK Fortyus (fUniqueIds) - NUNCA string vazia (regra #22)
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cCidChaves = fUniqueIds()
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigPrDmo (contas, grupos, nome, cidchaves)
                VALUES (
                    <<EscaparSQL(THIS.this_cContas)>>,
                    <<EscaparSQL(THIS.this_cGrupos)>>,
                    <<EscaparSQL(THIS.this_cNome)>>,
                    <<EscaparSQL(THIS.this_cCidChaves)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir demonstrativo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "SigOpDmpBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigPrDmo
    * nome eh a chave de negocio (nao editavel em modo ALTERAR) - WHERE por nome
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigPrDmo
                SET contas = <<EscaparSQL(THIS.this_cContas)>>,
                    grupos = <<EscaparSQL(THIS.this_cGrupos)>>
                WHERE nome = <<EscaparSQL(THIS.this_cNome)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar demonstrativo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "SigOpDmpBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC


    *====================================================================
    * Buscar - Alimenta cursor_4c_Dados, o cursor da grade da pagina Lista
    *
    * Legado (Init do SCX):
    *   lcQryDmPro = [Select * From SigPrDmo ]
    *   .AddCursor('SigPrDmo','cIdChaves','crSigPrDmo','',
    *              ThisForm.Pagina.Lista.Grade, lcQryDmPro)
    *   Select crSigPrDmo / Index On nome tag ix_nome
    * Ou seja: consulta SEM filtro (tabela inteira) e ordenada por nome
    * (regra #35 - a pagina Lista segue o Init do legado).
    *
    * O BusinessBase.Buscar herdado NAO serve aqui: ele delega para
    * this_oDataAccess (nunca instanciado, porque o Init chama DODEFAULT()
    * sem o nome da tabela) e grava no cursor "cur" + tabela, nao no
    * cursor_4c_Dados a que a grade se liga.
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                *-- Sem conexao (ValidarUIFidelity / teste headless): cria um
                *-- cursor vazio com a MESMA estrutura de SigPrDmo, para a
                *-- grade ter a que se ligar sem consultar o banco.
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados ;
                        (contas C(10), grupos C(10), nome C(20), cidchaves C(20))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT contas, grupos, nome, cidchaves FROM SigPrDmo"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY nome"

                *-- USE IN fecha o alias mesmo com buffer sujo; NUNCA
                *-- TABLEREVERT sem antes conferir o Buffering (regra #52).
                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar demonstrativos:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, ;
                "SigOpDmpBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Le do BANCO o demonstrativo de um nome
    *
    * Equivale ao ReQuery(1, pcChavePrimaria, <cursor>.<chave>) que o
    * Grupo_op.Click do frmcadastro dispara nos verbos CONSULTAR, ALTERAR e
    * EXCLUIR: o registro vem da tabela, nao do cursor que esta na grade da
    * Lista - que pode estar na tela desde antes de outro usuario altera-lo.
    *
    * A chave de NEGOCIO e o nome (this_cCampoChave = "nome"), e nao a
    * cidchaves: o nome e o que a grade da Lista exibe e o que amarra as
    * linhas de SigCdDpr ao demonstrativo (Where nome=?sNome do AddCursor
    * legado).
    *
    * this_lNovoRegistro volta a .F. aqui: sem isso, um Incluir seguido de
    * Alterar faria o Salvar escolher INSERT e violar a chave primaria.
    *
    * PUBLIC: o form chama este metodo de fora (regra #51).
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cNome)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cMensagemErro = ""

            DO CASE
                CASE VARTYPE(par_cNome) != "C" OR EMPTY(ALLTRIM(par_cNome))
                    THIS.this_cMensagemErro = "Nome do demonstrativo n" + ;
                        CHR(227) + "o informado."

                CASE TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                    THIS.this_cMensagemErro = "Sem conex" + CHR(227) + ;
                        "o com o banco de dados."

                OTHERWISE
                    IF USED("cursor_4c_Carrega")
                        USE IN cursor_4c_Carrega
                    ENDIF

                    loc_cSQL = "SELECT contas, grupos, nome, cidchaves" + ;
                        " FROM SigPrDmo" + ;
                        " WHERE RTRIM(nome) = " + EscaparSQL(ALLTRIM(par_cNome))

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

                    IF loc_nResultado < 0
                        MostrarErro("Erro ao carregar o demonstrativo:" + ;
                            CHR(13) + CapturarErroSQL(), "Erro SQL")
                        THIS.this_lErroExibido = .T.
                    ELSE
                        IF USED("cursor_4c_Carrega") AND ;
                           RECCOUNT("cursor_4c_Carrega") > 0
                            GO TOP IN cursor_4c_Carrega
                            loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                            THIS.this_lNovoRegistro = .F.
                        ELSE
                            THIS.this_cMensagemErro = "Demonstrativo n" + ;
                                CHR(227) + "o encontrado: " + ALLTRIM(par_cNome)
                        ENDIF
                    ENDIF

                    IF USED("cursor_4c_Carrega")
                        USE IN cursor_4c_Carrega
                    ENDIF
            ENDCASE

        CATCH TO loException
            MostrarErro("Erro ao carregar por c" + CHR(243) + "digo:" + CHR(13) + ;
                loException.Message, "SigOpDmpBO.CarregarPorCodigo")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * LimparDados - Zera as properties da entidade
    *
    * O LimparDados do BusinessBase limpa so a mensagem de erro: as
    * properties de CADA entidade sao responsabilidade da subclasse. Sem este
    * override, NovoRegistro() (chamado pelo Incluir) deixaria nome, grupos,
    * contas e - o mais grave - a cidchaves do registro ANTERIOR nas
    * properties, e o INSERT seguinte reaproveitaria aquela PK: colisao na
    * chave primaria de SigPrDmo (regra #22).
    *====================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cNome      = ""
        THIS.this_cContas    = ""
        THIS.this_cGrupos    = ""
        THIS.this_cCidChaves = ""

        RETURN .T.
    ENDPROC

    *====================================================================
    * ExecutarExclusao - DELETE do registro mestre em SigPrDmo
    *
    * Legado: frmcadastro.mSv_Excluir -> poDataMgr.Delete(1) + Commit(). O
    * AddCursor do Init legado passa 'cIdChaves' como chave do cursor
    * mestre, logo o Delete(1) do Fortyus apaga PELA cidchaves - que e a
    * PRIMARY KEY de SigPrDmo (docs\schema.sql, lido com Get-Content -Raw
    * por ser UTF-16 - regra #14). O nome e a chave de NEGOCIO e NAO tem
    * indice unico: apagar por nome mataria tambem um homonimo gravado por
    * outro caminho. Por isso o WHERE prefere a cidchaves e so cai no nome
    * quando ela nao veio.
    *
    * O COMMIT NAO ACONTECE AQUI. No legado ele e um passo com caminho de
    * falha PROPRIO logo depois do Delete/Update ("If (poDataMgr.Commit()
    * < 1) -> Favor Reinicializar o Processo!!!"), e nesta tela UMA
    * gravacao mexe em DUAS tabelas (SigPrDmo e SigCdDpr): commitar aqui
    * efetivaria o mestre antes de saber se as fases foram gravadas. O
    * commit unico vive no Confirmar do form.
    *
    * PROTECTED: quem chama e o Excluir() do BusinessBase, que ja faz o
    * AntesDeExcluir e o ExibirFalha (regra #51). O form chama Excluir().
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                loc_cSQL = "DELETE FROM SigPrDmo WHERE RTRIM(nome) = " + ;
                    EscaparSQL(ALLTRIM(THIS.this_cNome))
            ELSE
                loc_cSQL = "DELETE FROM SigPrDmo WHERE RTRIM(cidchaves) = " + ;
                    EscaparSQL(ALLTRIM(THIS.this_cCidChaves))
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir demonstrativo:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, ;
                "SigOpDmpBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExcluirFases - PROCEDURE excluiitens do legado
    *
    *   lcQuery = [Delete From SigCdDpr Where nome=] + getnome.Value
    *   If (poDataMgr.SqlExecute(lcQuery, 'crDelSigCdDpr') < 1)
    *       =MessageBox('Favor Reinicializar o Processo!!!', 16, ...)
    *   If (poDataMgr.Commit() < 1)
    *       =MessageBox('Favor Reinicializar o Processo!!!', 16, ...)
    *
    * Apaga TODAS as fases de um demonstrativo. Serve a dois caminhos do
    * Confirmar: a exclusao do demonstrativo inteiro (o ExcluiItens do
    * legado) e o "apaga e regrava" do GravarFases.
    *
    * O Commit fica de fora pelo mesmo motivo do ExecutarExclusao: e UM so,
    * no form, cobrindo mestre e fases.
    *
    * PUBLIC: o form chama este metodo de fora (regra #51).
    *====================================================================
    PROCEDURE ExcluirFases(par_cNome)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DO CASE
                CASE VARTYPE(par_cNome) != "C" OR EMPTY(ALLTRIM(par_cNome))
                    THIS.this_cMensagemErro = "Nome do demonstrativo n" + ;
                        CHR(227) + "o informado."

                CASE TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                    THIS.this_cMensagemErro = "Sem conex" + CHR(227) + ;
                        "o com o banco de dados."

                OTHERWISE
                    loc_cSQL = "DELETE FROM SigCdDpr WHERE RTRIM(nome) = " + ;
                        EscaparSQL(ALLTRIM(par_cNome))

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao excluir as fases do " + ;
                            "demonstrativo:" + CHR(13) + CapturarErroSQL(), ;
                            "Erro SQL")
                        THIS.this_lErroExibido = .T.
                    ENDIF
            ENDCASE

        CATCH TO loException
            MostrarErro("Erro ao excluir as fases:" + CHR(13) + ;
                loException.Message, "SigOpDmpBO.ExcluirFases")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * GravarFases - o poDataMgr.Update('crSigCdDpr') do Salva.Click legado
    *
    * No legado o cursor de detalhe e um cursor REMOTO BUFFERIZADO: o
    * Update do fSqlConector e um TABLEUPDATE, que manda ao SQL Server o
    * INSERT das linhas novas, o UPDATE das alteradas e o DELETE das
    * marcadas. Aqui o cursor_4c_Fases e um cursor LOCAL sem buffering
    * (TABLEUPDATE/TABLEREVERT em cursor com Buffering = 1 dispara o erro
    * 1586 - regra #52), logo nao existe lista de alteracoes em aberto a
    * mandar: a gravacao e "apaga as fases deste nome e regrava as linhas
    * vivas da grade".
    *
    * O efeito no banco e o MESMO do TABLEUPDATE: o conjunto de linhas de
    * SigCdDpr daquele nome passa a ser exatamente o conjunto exibido na
    * grade, cada uma com a sua cidchaves PRESERVADA (a PK de SigCdDpr).
    *
    * SCAN FOR !DELETED(): o botao Excluir de LINHA do form faz DELETE no
    * cursor (delecao LOGICA, como o legado), e linha apagada nao pode ser
    * regravada. O FOR explicito e necessario porque SET DELETED e escopado
    * por data session - confiar no SET DELETED ON do config.prg deixaria a
    * exclusao de linha sem efeito em form de sessao privada.
    *
    * O nome gravado em cada linha e o da FICHA, nao o que estava na linha:
    * ele e a chave que amarra a fase ao demonstrativo (o Where nome=?sNome
    * do AddCursor legado). O legado o estampa no momento do Append Blank
    * (InsiraRegGrade) e a ficha nunca deixa trocar o Nome depois que as
    * fases estao preenchidas (o "When" de GetNome), logo em todo caminho
    * normal e o MESMO valor - mas gravar o da ficha fecha a janela em que
    * o usuario troca o Nome com a grade ainda em branco e as linhas ficam
    * ORFAS, invisiveis para o CarregarFasesDoBanco.
    *
    * PUBLIC: o form chama este metodo de fora (regra #51).
    *====================================================================
    PROCEDURE GravarFases(par_cCursor, par_cNome)
        LOCAL loc_lSucesso, loc_lProsseguir, loc_cNome, loc_cSQL
        LOCAL loc_nResultado, loc_nAliasAnt, loc_nRegAnt, loc_cCidChaves

        loc_lSucesso    = .F.
        loc_lProsseguir = .T.

        TRY
            DO CASE
                CASE VARTYPE(par_cCursor) != "C" OR !USED(par_cCursor)
                    THIS.this_cMensagemErro = "Cursor de fases indispon" + ;
                        CHR(237) + "vel."
                    loc_lProsseguir = .F.

                CASE VARTYPE(par_cNome) != "C" OR EMPTY(ALLTRIM(par_cNome))
                    THIS.this_cMensagemErro = "Nome do demonstrativo n" + ;
                        CHR(227) + "o informado."
                    loc_lProsseguir = .F.

                CASE TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                    THIS.this_cMensagemErro = "Sem conex" + CHR(227) + ;
                        "o com o banco de dados."
                    loc_lProsseguir = .F.
            ENDCASE

            IF loc_lProsseguir
                loc_cNome = ALLTRIM(par_cNome)

                *-- Apaga as fases atuais do nome. A falha ja foi exibida
                *-- pelo proprio ExcluirFases.
                IF !THIS.ExcluirFases(loc_cNome)
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                loc_nAliasAnt = SELECT(0)
                SELECT (par_cCursor)
                loc_nRegAnt = RECNO(par_cCursor)

                loc_lSucesso = .T.

                SCAN FOR !DELETED()
                    *-- cidchaves NUNCA em branco: com ela vazia a segunda
                    *-- linha colidiria na PK de SigCdDpr (regra #22).
                    loc_cCidChaves = ALLTRIM(TratarNulo(cidchaves, ""))
                    IF EMPTY(loc_cCidChaves)
                        loc_cCidChaves = fUniqueIds()
                    ENDIF

                    *-- As OITO colunas de SigCdDpr sao NOT NULL e todas
                    *-- entram no INSERT - inclusive dopes, que nao aparece
                    *-- em lugar nenhum do codigo legado (ele a ganhava de
                    *-- graca do "Select *" + "Append Blank") e cuja
                    *-- ausencia faria o SQL Server recusar o INSERT
                    *-- inteiro (regra #22).
                    loc_cSQL = "INSERT INTO SigCdDpr" + ;
                        " (contas, grupos, nome, operas, ordems," + ;
                        " tpops, cidchaves, dopes) VALUES (" + ;
                        EscaparSQL(ALLTRIM(TratarNulo(contas, ""))) + "," + ;
                        EscaparSQL(ALLTRIM(TratarNulo(grupos, ""))) + "," + ;
                        EscaparSQL(loc_cNome) + "," + ;
                        EscaparSQL(TratarNulo(operas, " ")) + "," + ;
                        FormatarNumeroSQL(TratarNulo(ordems, 0), 0) + "," + ;
                        EscaparSQL(ALLTRIM(TratarNulo(tpops, ""))) + "," + ;
                        EscaparSQL(loc_cCidChaves) + "," + ;
                        EscaparSQL(ALLTRIM(TratarNulo(dopes, ""))) + ")"

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResultado < 0
                        MostrarErro("Erro ao gravar a fase de ordem " + ;
                            TRANSFORM(TratarNulo(ordems, 0)) + ":" + ;
                            CHR(13) + CapturarErroSQL(), "Erro SQL")
                        THIS.this_lErroExibido = .T.
                        loc_lSucesso = .F.
                        EXIT
                    ENDIF
                ENDSCAN

                IF loc_nRegAnt > 0 AND loc_nRegAnt <= RECCOUNT(par_cCursor)
                    GO loc_nRegAnt IN (par_cCursor)
                ENDIF
                SELECT (loc_nAliasAnt)
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao gravar as fases:" + CHR(13) + ;
                loException.Message, "SigOpDmpBO.GravarFases")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC
ENDDEFINE
