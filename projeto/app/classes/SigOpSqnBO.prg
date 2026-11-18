*==============================================================================
* SigOpSqnBO.prg - Business Object para "Sequencia de Operacoes do Caixa" (SIGOPSQN)
*
* Origem legado : SigOpSqn.SCX  (tasks\task806)
* Tipo de form  : OPERACIONAL (dialogo FILHO, chamado pela Lista do form pai
*                 SigCdOpe - Cadastro de Operacoes do Caixa)
* Tabela base   : SigMvCxs | PK: cidchaves
* Herda de      : BusinessBase
*
* O QUE A TELA FAZ (legado)
* -------------------------
* Dialogo filho que grava a SEQUENCIA de execucao das operacoes de caixa de
* uma operacao-pai (crSigCdOpe.Dopes). O legado recebe "poForm" (o form pai)
* e "pnDataSes" (DataSession do pai) no Init, troca para a DataSession do pai
* e manipula um cursor REMOTO bufferizado ("crSigMvCxs", requeried via
* SigCdOpe.poDataMgr) que lista as linhas de SigMvCxs filtradas pela operacao
* corrente. A grade (GradeSubN) tem 2 colunas editaveis:
*   Column1 -> cNivels (TextBox com lookup em TmpOper/SigCdOpe.Dopes, filtrado
*              por CupFis IN (1,3) - so operacoes de "Cupom Fiscal")
*   Column2 -> Seqs    (TextBox numerico, InputMask "9", faixa 1-8)
* Botoes: Inserir (Append Blank + foca Column1), Excluir (Delete da linha
* corrente) e Sair/Encerrar (valida duplicidade/sequencia ausente, grava via
* poDataMgr.UpDate + Commit, reabilita os botoes do pai e fecha o dialogo).
*
* GRAVACAO
* --------
* O legado grava via TableUpdate do cursor bufferizado inteiro (poDataMgr.
* UpDate('crSigMvCxs') + Commit()) so no clique de Sair/Encerrar - nao ha
* Inserir/Atualizar/Excluir linha-a-linha contra o SQL Server durante a
* edicao da grade (isso fica so no cursor local, igual ao padrao de
* SigOpSnoBO.ListarSubNiveis/ListarSubSubNiveis: cursor READWRITE editado
* pela grade, e o BO grava quando o Form decide persistir).
*
* METODOS DE DADOS (todos entregues)
* ------------------------------------------------------------------
*   CarregarDoCursor(par_cAliasCursor) - mapeia cidchaves/cdopes/cnivels/seqs
*       de uma linha de SigMvCxs para as properties deste BO (Fase 2).
*   ListarSequencias(par_cOperacaoPai)  - popula THIS.this_cCursorSequencias
*       com as linhas de SigMvCxs da operacao-pai, equivalente ao legado
*       ReQuery('crSigMvCxs') (cursor READWRITE - a grade insere/remove linha
*       por Append Blank/Delete direto no cursor local). Eh o que alimenta a
*       grade do form (FormSigOpSqn.CarregarDados).
*   ListarOperacoesCupFis()             - popula THIS.this_cCursorOperacoes
*       com "Select Dopes From SigCdOpe Where CupFis in (1,3)", equivalente
*       ao legado TmpOper (universo do lookup da coluna cNivels). Fase 6 -
*       carregado UMA VEZ no InicializarForm, igual ao legado (nao eh
*       re-executado a cada CarregarDados).
*   LimparDados()                       - override da Fase 8: zera as 4
*       properties da entidade. Quem chama eh NovoRegistro(), antes do
*       FormSigOpSqn.FormParaBO atribuir a linha nova.
*   Inserir / Atualizar / ExecutarExclusao - PROTECTED, uma LINHA por
*       chamada. De fora usa-se Salvar()/Excluir() (regra #51).
*
*   A persistencia do cursor INTEIRO (equivalente ao poDataMgr.UpDate
*   ('crSigMvCxs') + Commit() do legado) NAO ficou aqui: ela eh
*   FormSigOpSqn.PersistirSequencias, que percorre o cursor local e chama
*   Salvar()/Excluir() linha a linha. O motivo eh que quem sabe o que a
*   SESSAO do dialogo mudou eh o form - ele guarda as linhas criadas
*   (this_cCidChavesNovas) e as marcas de exclusao do cursor, que sao o que
*   distingue INSERT de UPDATE e de DELETE; o legado tirava isso do buffer
*   da view remota, que nao existe aqui. Um metodo neste BO recebendo o
*   alias do cursor duplicaria esse estado em dois donos.
*
* VALIDACOES DO LEGADO QUE PERTENCEM AO cmdSair.Click (regra de negocio
* transcrita LITERALMENTE em FormSigOpSqn.ExisteOperacaoDuplicada e
* ExisteSequenciaNaoInformada, NUNCA reescrita):
*   1) Nenhuma cNivels duplicada em crSigMvCxs (Group By cNivels Having
*      Sum(1) > 1 -> "Existem Operacoes Duplicadas!!!").
*   2) Nenhuma linha com cNivels preenchida e Seqs = 0 (Where Not Empty
*      (cNivels) And Seqs = 0 -> "Existem Operacoes sem Sequencia
*      informada!!!").
*   As duas SO valem quando cmdInserir.Visible Or cmdExcluir.Visible (ou
*   seja, quando o pai esta em INSERIR/ALTERAR) E quando houve alguma
*   alteracao na sessao (lHouveExcl/lHouveIns/lHouveAlt).
*
* LARGURAS DO SCHEMA (docs\schema.sql) - usadas no MaxLength dos
* controles e no dimensionamento das colunas do cursor
* -------------------------------------------------------------------
*   SigMvCxs.cdopes     char(20) NOT NULL  SigMvCxs.cidchaves char(20) NOT NULL (PK)
*   SigMvCxs.cnivels    char(20) NOT NULL  SigMvCxs.seqs      numeric(2,0) NOT NULL
*   SigCdOpe.dopes      char(20) NOT NULL  - PK/descricao (coluna unica, ver
*                        regra do pipeline "SigCdOpe eh single-column: NUNCA
*                        usar descrs/Descrs")
*==============================================================================

DEFINE CLASS SigOpSqnBO AS BusinessBase

    *--------------------------------------------------------------------------
    * ENTIDADE - linha de sequencia de operacao (SigMvCxs)
    *--------------------------------------------------------------------------
    this_cCidChaves          = ""   && cidchaves char(20) NOT NULL - PK (gerada com fUniqueIds())
    this_cCDopes             = ""   && cdopes    char(20) NOT NULL - FK SigCdOpe.dopes (operacao-pai, a do cadastro)
    this_cCNivels            = ""   && cnivels   char(20) NOT NULL - FK SigCdOpe.dopes (operacao usada na sequencia)
    this_nSeqs               = 0    && seqs      numeric(2,0) NOT NULL - sequencia de execucao (1 a 8)

    *--------------------------------------------------------------------------
    * CONTEXTO HERDADO DO FORM PAI
    * Legado: ThisForm.ParentForm / Set DataSession To pnDataSes / pcEscolha
    *--------------------------------------------------------------------------
    this_cEscolha            = ""   && pcEscolha do pai: INSERIR / ALTERAR / PROCURAR (habilita Inserir/Excluir)
    this_nDataSessionPai     = 0    && DataSessionId do pai (poForm.DataSessionId / pnDataSes do legado)

    *--------------------------------------------------------------------------
    * ESTADO DA SESSAO DO DIALOGO
    * Legado: propriedades customizadas lhouvealt / lhouveexcl / lhouveins do
    * SIGOPSQN - usadas pelo cmdSair.Click para decidir se valida e grava.
    *
    * DONO UNICO (Fase 8): no legado essas tres flags sao do FORM, e no
    * migrado continuam sendo - quem escreve e quem le eh FormSigOpSqn
    * (this_lHouveAlteracao/this_lHouveInclusao/this_lHouveExclusao), nos
    * mesmos pontos do legado (Valid das celulas, Click de Inserir/Excluir,
    * BtnSairClick). As copias aqui ficam ZERADAS e servem so de espelho
    * documental do legado: NAO ligar codigo novo nelas sem antes remover as
    * do form, senao a tela passa a ter dois donos do mesmo estado e eles
    * divergem em silencio (a gravacao do Encerrar le o dono errado e nao
    * grava nada, ou grava sem alteracao nenhuma).
    *--------------------------------------------------------------------------
    this_lHouveAlteracao     = .F.  && lhouvealt  - houve alteracao de cNivels/Seqs numa linha existente
    this_lHouveExclusao      = .F.  && lhouveexcl - houve exclusao de linha
    this_lHouveInclusao      = .F.  && lhouveins  - houve inclusao de linha

    *--------------------------------------------------------------------------
    * ALIASES DE CURSOR
    * (nomes do legado entre parenteses - PILAR 3 manda renomear)
    *--------------------------------------------------------------------------
    this_cCursorSequencias   = "cursor_4c_Sequencias"  && crSigMvCxs - linhas de SigMvCxs da operacao-pai (grade)
    this_cCursorOperacoes    = "cursor_4c_Operacoes"   && TmpOper    - universo do lookup (SigCdOpe.Dopes, CupFis IN (1,3))

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *
    * Define a tabela/chave de persistencia (SigMvCxs.cidchaves) e repoe os
    * valores iniciais que o legado tem na propria sessao do dialogo
    * (nenhuma alteracao/inclusao/exclusao ainda ocorrida).
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigMvCxs"
        THIS.this_cCampoChave = "cidchaves"

        THIS.this_nSeqs           = 0
        THIS.this_nDataSessionPai = 0
        THIS.this_lHouveAlteracao = .F.
        THIS.this_lHouveExclusao  = .F.
        THIS.this_lHouveInclusao  = .F.

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparDados - zera as properties da ENTIDADE (Fase 8)
    *
    * BusinessBase.LimparDados so limpa this_cMensagemErro e deixa dito que
    * "subclasses devem limpar suas propriedades especificas". Quem chama eh
    * NovoRegistro() (e CancelarEdicao()/Excluir()), ou seja: toda vez que o
    * form prepara uma linha NOVA para gravar.
    *
    * Sem este override, as 4 properties entravam na linha nova com o valor
    * da linha ANTERIOR do laco de FormSigOpSqn.PersistirSequencias - hoje
    * isso fica mascarado porque o FormParaBO logo em seguida atribui as
    * quatro, mas qualquer caminho que deixasse de atribuir uma delas
    * gravaria o dado da linha errada, sem erro nenhum na tela.
    *
    * NAO limpa this_cCursorSequencias/this_cCursorOperacoes (nomes de alias,
    * nao dado) nem this_cEscolha/this_nDataSessionPai (contexto do form pai,
    * valido por toda a sessao do dialogo) - zerar esses derrubaria a carga
    * da grade e o controle de acesso aos botoes.
    *
    * DODEFAULT() primeiro, para nao perder a limpeza da mensagem de erro
    * feita pela base.
    *--------------------------------------------------------------------------
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cCidChaves = ""
        THIS.this_cCDopes    = ""
        THIS.this_cCNivels   = ""
        THIS.this_nSeqs      = 0

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna o valor da chave para a auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega as propriedades de uma linha de sequencia
    * (SigMvCxs) a partir de um cursor posicionado nessa linha (cursor
    * cursor_4c_Sequencias, populado por ListarSequencias,
    * ou qualquer outro cursor/SELECT que inclua as mesmas 4 colunas).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            IF !EOF()
                THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
                THIS.this_cCDopes    = TratarNulo(cdopes,    "C")
                THIS.this_cCNivels   = TratarNulo(cnivels,   "C")
                THIS.this_nSeqs      = TratarNulo(seqs,      "N")

                THIS.this_lNovoRegistro = .F.
                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ListarSequencias - Popula cursor_4c_Sequencias com as linhas de SigMvCxs
    * da operacao-pai, equivalente ao legado "ReQuery('crSigMvCxs')".
    *
    * A consulta eh a MESMA que o form pai (SIGCDOPE) registra para esse
    * cursor no seu AddCursor:
    *
    *   Select a.* From SigMvCxs a inner join SigCdOpe b on a.cdopes = b.Dopes
    *   Where a.cDopes = ?crSigCdOpe.Dopes Order by a.cDopes, a.cnivels
    *
    * As 4 colunas sao listadas explicitamente no lugar de "a.*": SigMvCxs
    * tem exatamente cdopes/cidchaves/cnivels/seqs (docs\schema.sql), e a
    * lista explicita eh o que garante que o CREATE/SELECT INTO e os
    * ControlSource da grade casem por nome.
    *
    * Cursor READWRITE (NAO o cursor cru do SQLEXEC, que nasce somente-
    * leitura): as duas colunas da grade sao editaveis e os botoes Inserir/
    * Excluir inserem e apagam linha direto no cursor local, igual ao legado
    * (Insert Into crSigMvCxs / Delete). Sem READWRITE a celula nem entra em
    * edicao e o REPLACE/INSERT estoura.
    *
    * Os RETURN de guarda ficam FORA do TRY/CATCH (regra #1).
    *--------------------------------------------------------------------------
    FUNCTION ListarSequencias(par_cOperacaoPai)
        LOCAL loc_cOperacaoPai, loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        loc_cOperacaoPai = IIF(VARTYPE(par_cOperacaoPai) = "C", par_cOperacaoPai, "")

        *-- Sem conexao nao ha o que consultar (probe/harness sem config.prg):
        *-- SQLEXEC com handle invalido dispara excecao em vez de devolver -1
        IF TYPE("gnConnHandle") != "N"
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco indispon" + ;
                CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco indispon" + ;
                CHR(237) + "vel."
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT a.cdopes, a.cidchaves, a.cnivels, a.seqs" + ;
                       " FROM SigMvCxs a" + ;
                       " INNER JOIN SigCdOpe b ON a.cdopes = b.dopes" + ;
                       " WHERE a.cdopes = " + EscaparSQL(loc_cOperacaoPai) + ;
                       " ORDER BY a.cdopes, a.cnivels"

            IF USED("cursor_4c_SeqTmp")
                USE IN cursor_4c_SeqTmp
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SeqTmp")

            IF loc_nResultado >= 0
                *-- USE IN fecha o alias mesmo com buffer sujo - sem
                *-- TABLEREVERT, que exige buffering e ERRA no cursor de
                *-- Buffering = 1 (regra #52)
                IF USED("cursor_4c_Sequencias")
                    USE IN cursor_4c_Sequencias
                ENDIF

                SELECT * FROM cursor_4c_SeqTmp INTO CURSOR cursor_4c_Sequencias READWRITE
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar as sequ" + CHR(234) + "ncias da opera" + ;
                    CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_SeqTmp")
                USE IN cursor_4c_SeqTmp
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpSqnBO.ListarSequencias:" + CHR(13) + ;
                loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ListarOperacoesCupFis - Popula cursor_4c_Operacoes com o universo do
    * lookup da Column1 (cnivels), equivalente ao legado TmpOper:
    *
    *   lcSql = [Select Dopes From SigCdOpe Where CupFis in (1,3)]
    *   SigCdOpe.PodataMgr.Sqlexecute(lcsql,'TmpOper')
    *   Select TmpOper
    *   Index On Dopes Tag dopes
    *
    * Carregado UMA VEZ (igual ao legado, no Init) - diferente de
    * ListarSequencias, que eh re-executado a cada CarregarDados deste
    * dialogo. Chamado por FormSigOpSqn.InicializarForm, antes do usuario
    * poder editar a grade.
    *
    * SigCdOpe eh single-column (regra do pipeline "SigCdOpe eh
    * single-column: NUNCA usar descrs/Descrs"): a mesma coluna dopes serve
    * de PK E de descricao - nao ha coluna de descricao separada.
    *
    * INDEX ON dopes TAG dopes - para o Valid da celula localizar com SEEK,
    * igual ao legado (Seek(This.Value, 'TmpOper', 'Dopes')).
    *
    * Os RETURN de guarda ficam FORA do TRY/CATCH (regra #1).
    *--------------------------------------------------------------------------
    FUNCTION ListarOperacoesCupFis()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        *-- Sem conexao nao ha o que consultar (probe/harness sem config.prg)
        IF TYPE("gnConnHandle") != "N"
            RETURN .F.
        ENDIF

        IF gnConnHandle <= 0
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT dopes FROM SigCdOpe WHERE cupfis IN (1, 3)"

            IF USED("cursor_4c_Operacoes")
                USE IN cursor_4c_Operacoes
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacoes")

            IF loc_nResultado >= 0
                SELECT cursor_4c_Operacoes
                INDEX ON dopes TAG dopes
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar o universo de opera" + CHR(231) + CHR(245) + ;
                    "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpSqnBO.ListarOperacoesCupFis:" + CHR(13) + ;
                loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Inclui uma nova linha de sequencia (SigMvCxs) no banco.
    * Equivalente ao legado cmdInserir.Click (Insert Into crSigMvCxs) seguido
    * da persistencia feita no Sair/Encerrar (poDataMgr.UpDate + Commit) -
    * aqui a gravacao do INSERT ja eh direta contra o SQL Server, por linha.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            *-- cidchaves eh a PK Fortyus (regra #22): gerar com fUniqueIds(),
            *-- NUNCA deixar vazia - senao o proximo registro colide no indice unico
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cCidChaves = fUniqueIds()
            ENDIF

            loc_cSQL = "INSERT INTO SigMvCxs (cdopes, cidchaves, cnivels, seqs)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCDopes) + ", " + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cCNivels) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nSeqs, 0) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsSqn")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao incluir sequ" + CHR(234) + "ncia da opera" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_InsSqn")
                USE IN cursor_4c_InsSqn
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpSqnBO.Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza uma linha de sequencia (SigMvCxs) ja existente.
    * Equivalente a legado editando cNivels/Seqs direto na grade (Column1/
    * Column2.Valid) e persistindo no Sair/Encerrar.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigMvCxs SET" + ;
                       " cdopes  = " + EscaparSQL(THIS.this_cCDopes) + "," + ;
                       " cnivels = " + EscaparSQL(THIS.this_cCNivels) + "," + ;
                       " seqs    = " + FormatarNumeroSQL(THIS.this_nSeqs, 0) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdSqn")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar sequ" + CHR(234) + "ncia da opera" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_UpdSqn")
                USE IN cursor_4c_UpdSqn
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpSqnBO.Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Remove uma linha de sequencia (SigMvCxs) do banco.
    * Equivalente ao legado cmdExcluir.Click (Delete da linha corrente de
    * crSigMvCxs), com a persistencia feita diretamente contra o SQL Server.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigMvCxs" + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelSqn")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir sequ" + CHR(234) + "ncia da opera" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_DelSqn")
                USE IN cursor_4c_DelSqn
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpSqnBO.ExecutarExclusao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE
