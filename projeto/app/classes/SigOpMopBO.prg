*====================================================================
* SigOpMopBO.prg
*
* Business Object para Geracao de Multiplas Operacoes
* Origem legado: SIGOPMOP.SCX (form OPERACIONAL - dialogo filho de SIGCDOPE)
* Tabela: SigCdMop
* Herda de: BusinessBase
*
* A tela eh um dialogo filho aberto pelo Cadastro de Operacoes (SigCdOpe).
* Cada linha da grade eh um registro de SigCdMop que amarra a operacao PAI
* (cdopes) a uma operacao FILHA (cnivels), com cor, ordem, grande grupo e
* empresa de destino.
*
* Colunas de SigCdMop (TODAS NOT NULL - ver docs\schema.sql):
*   cdopes    char(20)        - operacao PAI  (crSigCdOpe.Dopes no legado)
*   cidchaves char(20)        - PK, gerada por fUniqueIds()
*   cnivels   char(20)        - operacao FILHA ("Movimentacao" na grade)
*   ncors     numeric(10,0)   - cor RGB ("Cores")
*   padraos   numeric(1,0)    - marca de linha padrao ("Padrao")
*   ordems    numeric(3,0)    - ordem de execucao ("Ordem")
*   mercs     char(3)         - grande grupo ("G.Grp")
*   empds     char(3)         - empresa de destino ("Emp.") - DEFAULT ('')
*   opers     char(1)         - sem controle na tela      - DEFAULT ('')
*
* ATENCAO: ndopes NAO existe em SigCdMop. Eh coluna de EXIBICAO da grade,
* lida de SigCdOpe.ndopes pelo legado ("Replace nDopes With CpSigCdOpe.nDopes
* in CrSigCdMop") e por isso NUNCA entra no INSERT/UPDATE desta tabela.
*====================================================================

DEFINE CLASS SigOpMopBO AS BusinessBase

    *----------------------------------------------------------------
    * Propriedades da entidade (mapeamento 1-para-1 com SigCdMop)
    *----------------------------------------------------------------
    this_cCidChaves   = ""    && cidchaves char(20)      - PK (fUniqueIds)
    this_cCdopes      = ""    && cdopes    char(20)      - operacao PAI
    this_cCnivels     = ""    && cnivels   char(20)      - operacao FILHA
    this_nNcors       = 0     && ncors     numeric(10,0) - cor RGB
    this_nPadraos     = 0     && padraos   numeric(1,0)  - linha padrao
    this_nOrdems      = 0     && ordems    numeric(3,0)  - ordem
    this_cMercs       = ""    && mercs     char(3)       - grande grupo
    this_cEmpds       = ""    && empds     char(3)       - empresa destino
    this_cOpers       = ""    && opers     char(1)       - sem UI (NOT NULL)

    *----------------------------------------------------------------
    * Propriedade de EXIBICAO - vem de SigCdOpe.ndopes, NAO de SigCdMop.
    * Fica no cursor da grade (coluna " # ") e nao eh persistida aqui.
    *----------------------------------------------------------------
    this_nNdopes      = 0     && ndopes    numeric(4,0)  - numero da operacao

    *----------------------------------------------------------------
    * Contexto recebido do form PAI (SigCdOpe) ao abrir o dialogo
    *----------------------------------------------------------------
    this_cOperacaoPai = ""    && Dopes da operacao corrente no form pai
    this_cEscolha     = ""    && Modo do pai: INSERIR / ALTERAR / PROCURAR

    *----------------------------------------------------------------
    * Configuracao da operacao (SigOpCdc) - decide o comportamento da grade
    *   geropes   <> 2 trava a coluna "Cores" (legado: Column3.ReadOnly = .T.)
    *   opeinatvs  = 1 recusa a operacao digitada em "Movimentacao"
    *----------------------------------------------------------------
    this_nGerOpes     = 0     && SigOpCdc.geropes   numeric(1,0)
    this_nOpeInatvs   = 0     && SigOpCdc.opeinatvs numeric(1,0)

    *----------------------------------------------------------------
    * Nomes de cursores (centralizados para a grade nao perder o bind)
    *----------------------------------------------------------------
    this_cCursorDados  = "cursor_4c_Dados"       && cursor da grade (crSigCdMop)
    this_cCursorTemp   = "cursor_4c_DadosTmp"    && destino dos SQLEXEC
    this_cCursorConfig = "cursor_4c_ConfigOpe"   && LocalDcOpe do legado
    this_cCursorBusca  = "cursor_4c_Busca"       && reserva (os lookups da grade usam um cursor por tabela)
    this_cCursorChaves = "cursor_4c_ChavesMop"   && cidchaves JA gravadas (reconciliacao da gravacao)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigCdMop"
            THIS.this_cCampoChave = "cidchaves"

            THIS.this_cCursorDados  = "cursor_4c_Dados"
            THIS.this_cCursorTemp   = "cursor_4c_DadosTmp"
            THIS.this_cCursorConfig = "cursor_4c_ConfigOpe"
            THIS.this_cCursorBusca  = "cursor_4c_Busca"
            THIS.this_cCursorChaves = "cursor_4c_ChavesMop"

            THIS.this_lEmEdicao     = .F.
            THIS.this_lNovoRegistro = .F.

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpMopBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna a chave primaria para a auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de uma linha
    * do cursor da grade (cursor_4c_Dados / crSigCdMop no legado).
    *
    * this_nNdopes NAO vem de SigCdMop - eh lido do mesmo cursor porque a
    * grade de SigOpMopBO.Buscar() ja traz essa coluna de exibicao vinda
    * do JOIN com SigCdOpe (ver comentario no cabecalho do arquivo).
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves = TratarNulo(cidchaves, "")
                THIS.this_cCdopes    = TratarNulo(cdopes,    "")
                THIS.this_cCnivels   = TratarNulo(cnivels,   "")
                THIS.this_nNcors     = TratarNulo(ncors,      0)
                THIS.this_nPadraos   = TratarNulo(padraos,    0)
                THIS.this_nOrdems    = TratarNulo(ordems,     0)
                THIS.this_cMercs     = TratarNulo(mercs,     "")
                THIS.this_cEmpds     = TratarNulo(empds,     "")
                THIS.this_cOpers     = TratarNulo(opers,     "")

                IF TYPE(par_cAliasCursor + ".ndopes") != "U"
                    THIS.this_nNdopes = TratarNulo(ndopes,  0)
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message, "SigOpMopBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - Insere nova linha na tabela SigCdMop
    *
    * Transcreve o cmdInserir.Click do legado (ver InicializarValoresPadrao):
    * todas as colunas sao NOT NULL, entao TODAS entram no INSERT - inclusive
    * empds/opers, que nao tem controle visivel na grade (regra #22).
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdMop (cidchaves, cdopes, cnivels, ncors, padraos, ordems, mercs, empds, opers)
                VALUES (
                    <<EscaparSQL(THIS.this_cCidChaves)>>,
                    <<EscaparSQL(THIS.this_cCdopes)>>,
                    <<EscaparSQL(THIS.this_cCnivels)>>,
                    <<FormatarNumeroSQL(THIS.this_nNcors, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nPadraos, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nOrdems, 0)>>,
                    <<EscaparSQL(THIS.this_cMercs)>>,
                    <<EscaparSQL(THIS.this_cEmpds)>>,
                    <<EscaparSQL(THIS.this_cOpers)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message, "SigOpMopBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza linha existente na tabela SigCdMop
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdMop
                SET cdopes  = <<EscaparSQL(THIS.this_cCdopes)>>,
                    cnivels = <<EscaparSQL(THIS.this_cCnivels)>>,
                    ncors   = <<FormatarNumeroSQL(THIS.this_nNcors, 0)>>,
                    padraos = <<FormatarNumeroSQL(THIS.this_nPadraos, 0)>>,
                    ordems  = <<FormatarNumeroSQL(THIS.this_nOrdems, 0)>>,
                    mercs   = <<EscaparSQL(THIS.this_cMercs)>>,
                    empds   = <<EscaparSQL(THIS.this_cEmpds)>>,
                    opers   = <<EscaparSQL(THIS.this_cOpers)>>
                WHERE cidchaves = <<EscaparSQL(THIS.this_cCidChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message, "SigOpMopBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * LimparDados - Zera as propriedades da entidade
    *
    * Mantem o CONTEXTO (operacao pai, modo e configuracao da operacao):
    * ele vem do form pai na abertura do dialogo e vale para todas as
    * linhas, nao para uma linha so.
    *====================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cCidChaves = ""
        THIS.this_cCdopes    = ""
        THIS.this_cCnivels   = ""
        THIS.this_nNcors     = 0
        THIS.this_nPadraos   = 0
        THIS.this_nOrdems    = 0
        THIS.this_cMercs     = ""
        THIS.this_cEmpds     = ""
        THIS.this_cOpers     = ""
        THIS.this_nNdopes    = 0

        RETURN .T.
    ENDPROC

    *====================================================================
    * InicializarValoresPadrao - Defaults da linha NOVA
    *
    * Transcreve o cmdInserir.Click do legado:
    *   Insert Into crSigCdMop (cDopes, CidChaves) ;
    *       Values (crSigCdOpe.Dopes, fUniqueIds())
    * Ou seja: a linha nova nasce amarrada a operacao PAI, com PK propria,
    * e o restante em branco/zero (as colunas sao NOT NULL, por isso
    * precisam de valor explicito - nunca NULL).
    *====================================================================
    PROTECTED PROCEDURE InicializarValoresPadrao()
        THIS.this_cCidChaves = fUniqueIds()
        THIS.this_cCdopes    = ALLTRIM(THIS.this_cOperacaoPai)
        THIS.this_cCnivels   = ""
        THIS.this_nNcors     = 0
        THIS.this_nPadraos   = 0
        THIS.this_nOrdems    = 0
        THIS.this_cMercs     = ""
        THIS.this_cEmpds     = ""
        THIS.this_cOpers     = ""
        THIS.this_nNdopes    = 0

        RETURN .T.
    ENDPROC

    *====================================================================
    * CarregarConfiguracaoOperacao - popula o cursor de configuracao das
    * operacoes (SigOpCdc) e resolve geropes/opeinatvs da operacao PAI.
    *
    * TRANSCRITO do Init legado:
    *   lcSql = [Select Dopes, GerOpes, OpeInatvs From SigOpCdc ]
    *   SigCdOpe.Podatamgr.Sqlexecute(lcSql,'LocalDcOpe')
    *   Select LocalDcOpe
    *   Index On Dopes Tag dopes
    *   =Seek(CrSigCdOpe.Dopes)
    *
    * O cursor carrega TODAS as operacoes de proposito, e NAO so a corrente:
    * o Valid da coluna "Movimentacao" reconsulta este mesmo cursor para
    * recusar a operacao digitada quando ela esta inativa ("=Seek(
    * cpSigCdOpe.Dopes,'LocalDcOpe','Dopes') / If LocalDcOpe.OpeInatvs = 1").
    * Filtrar aqui pela operacao PAI deixaria aquela checagem sem base.
    *
    * geropes decide se a coluna "Cores" aceita digitacao (<> 2 trava), e eh
    * por isso que esta carga roda ANTES da montagem da grade.
    *====================================================================
    PROCEDURE CarregarConfiguracaoOperacao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro
        loc_lSucesso = .F.

        THIS.this_nGerOpes   = 0
        THIS.this_nOpeInatvs = 0

        TRY
            IF USED(THIS.this_cCursorConfig)
                USE IN (THIS.this_cCursorConfig)
            ENDIF

            loc_cSQL = "SELECT dopes, geropes, opeinatvs FROM SigOpCdc"

            loc_nResultado = -1
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED(THIS.this_cCursorTemp)
                    USE IN (THIS.this_cCursorTemp)
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorTemp)
            ENDIF

            IF loc_nResultado > 0 AND USED(THIS.this_cCursorTemp)
                SELECT * FROM (THIS.this_cCursorTemp) ;
                    INTO CURSOR (THIS.this_cCursorConfig) READWRITE
                USE IN (THIS.this_cCursorTemp)
            ELSE
                *-- Sem conexao (harness/validacao de UI) ou consulta recusada:
                *-- cursor VAZIO com a MESMA estrutura, para a grade continuar
                *-- montavel e a checagem de operacao inativa nao estourar.
                CREATE CURSOR (THIS.this_cCursorConfig) ( ;
                    dopes     C(20), ;
                    geropes   N(1, 0), ;
                    opeinatvs N(1, 0) )
            ENDIF

            *-- "Index On Dopes Tag dopes" do legado
            SELECT (THIS.this_cCursorConfig)
            INDEX ON dopes TAG dopes

            *-- Equivalente ao "=Seek(CrSigCdOpe.Dopes)". LOCATE em vez de SEEK
            *-- porque o projeto roda com SET EXACT ON, e nesse modo o SEEK
            *-- exigiria a chave com o padding exato de char(20) - ver a regra
            *-- do indice composto/SEEK parcial no CLAUDE.md.
            IF !EMPTY(ALLTRIM(THIS.this_cOperacaoPai))
                LOCATE FOR ALLTRIM(dopes) == ALLTRIM(THIS.this_cOperacaoPai)
                IF FOUND()
                    THIS.this_nGerOpes   = TratarNulo(geropes,    0)
                    THIS.this_nOpeInatvs = TratarNulo(opeinatvs,  0)
                ENDIF
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CarregarConfiguracaoOperacao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarGrade - popula o cursor da grade com as linhas de SigCdMop
    * da operacao PAI.
    *
    * A consulta eh a MESMA que o form chamador (SIGCDOPE) registra no
    * AddCursor de 'crSigCdMop' - transcrita de
    * tasks\task483\SIGCDOPE_form_codigo_fonte.txt:54214:
    *
    *   Select a.*, b.nDopes
    *     From SigCdMop a
    *     inner join SigCdOpe b on a.cnivels = b.Dopes
    *    Where a.cDopes = ?crSigCdOpe.Dopes
    *    Order by a.cDopes, a.cNivels
    *
    * O JOIN eh quem traz "ndopes" (o numero da operacao FILHA, coluna " # "
    * da grade), que NAO existe em SigCdMop.
    *
    * O JOIN eh LEFT, e NAO inner (corrigido na Fase 8). No legado o cursor da
    * grade nao eh um JOIN: eh o "crSigCdMop" do form PAI (SigCdOpe.poDataMgr),
    * que eh "SigCdMop" inteiro MAIS uma coluna LOCAL nDopes, preenchida a mao
    * pelo Valid da celula Movimentacao ("Replace nDopes With CpSigCdOpe.nDopes
    * in CrSigCdMop"). Ou seja: no legado a linha com cnivels em BRANCO - a que
    * o botao Inserir cria e o usuario pode deixar sem preencher - esta no
    * cursor e eh gravada pelo UpDate/Commit do cmdSair.
    *
    * Com INNER essa linha, uma vez gravada, NAO voltava do banco (nao ha
    * SigCdOpe com Dopes em branco): ela desaparecia da tela sem erro nenhum e,
    * pior, a reconciliacao da Fase 8 (GravarGrade) a leria como "existe no
    * banco e nao esta mais na grade" e a EXCLUIRIA - perda silenciosa de dado.
    * LEFT + ISNULL(b.ndopes, 0) deixa o cursor ser a imagem FIEL de
    * "SigCdMop WHERE cdopes = <operacao pai>", que eh o que a reconciliacao
    * pressupoe, e ISNULL mantem a coluna numeric(4,0) SEM nulo (CheckBox e
    * REPLACE sobre coluna anulavel estouram em runtime).
    *
    * O cursor tem de ser READWRITE: as colunas Movimentacao/Cores/Padrao/
    * Ordem/G.Grp/Emp. sao editaveis na grade, e cursor de SQLEXEC nasce
    * SOMENTE-LEITURA (a celula renderiza e nunca entra em edicao). Por isso
    * o SQLEXEC vai para um cursor TEMPORARIO e o cursor da grade sai de um
    * "SELECT * ... INTO CURSOR ... READWRITE".
    *
    * ATENCAO: este metodo DERRUBA o alias da grade, e fechar o alias de um
    * Grid destroi o controle posto por Column.AddObject (o CheckBox da
    * coluna Padrao) - perda PARCIAL e silenciosa, porque Width/Header
    * sobrevivem e so o CheckBox volta a desenhar o Text1. Quem chama este
    * metodo TEM de remontar a grade pelo funil (FormSigOpMop.MontaGrade).
    *====================================================================
    PROCEDURE CarregarGrade()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            TEXT TO loc_cSQL NOSHOW TEXTMERGE
                SELECT a.cdopes, a.cidchaves, a.cnivels, a.ncors,
                       a.padraos, a.ordems, a.mercs, a.empds, a.opers,
                       ISNULL(b.ndopes, 0) AS ndopes
                  FROM SigCdMop a
                  LEFT JOIN SigCdOpe b ON a.cnivels = b.dopes
                 WHERE a.cdopes = <<EscaparSQL(ALLTRIM(THIS.this_cOperacaoPai))>>
                 ORDER BY a.cdopes, a.cnivels
            ENDTEXT

            loc_nResultado = -1
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED(THIS.this_cCursorTemp)
                    USE IN (THIS.this_cCursorTemp)
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorTemp)
            ENDIF

            IF loc_nResultado > 0 AND USED(THIS.this_cCursorTemp)
                SELECT * FROM (THIS.this_cCursorTemp) ;
                    INTO CURSOR (THIS.this_cCursorDados) READWRITE
                USE IN (THIS.this_cCursorTemp)
                loc_lSucesso = .T.
            ELSE
                *-- Sem conexao ou consulta recusada: cursor vazio com a MESMA
                *-- estrutura da consulta, na MESMA ordem de colunas (o APPEND
                *-- de uma recarga futura casa por NOME, e a grade liga por
                *-- ControlSource - estrutura divergente quebraria os dois).
                THIS.CriarCursorGradeVazio()

                IF loc_nResultado <= 0 AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                    MsgErro("Erro ao carregar as opera" + CHR(231) + CHR(245) + "es m" + ;
                            CHR(250) + "ltiplas." + CHR(13) + CapturarErroSQL(), ;
                            "Erro SQL")
                ELSE
                    *-- Ausencia de conexao nao eh falha de carga: eh o cenario
                    *-- do harness, e a grade abre vazia e montavel.
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

            IF USED(THIS.this_cCursorDados)
                SELECT (THIS.this_cCursorDados)
                GO TOP
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CarregarGrade")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CriarCursorGradeVazio - estrutura do cursor da grade.
    *
    * Os tipos vem de docs\schema.sql (SigCdMop, todas NOT NULL) mais a
    * coluna de exibicao ndopes, que eh SigCdOpe.ndopes numeric(4,0).
    * A ordem eh a MESMA do SELECT de CarregarGrade - placeholder com
    * estrutura divergente do cursor real quebra o bind da grade.
    *
    * SEM "SET NULL ON" de proposito: a grade EDITA estas colunas, e NULL em
    * coluna numerica ligada a CheckBox/REPLACE estoura em runtime. Todas as
    * colunas de origem sao NOT NULL e o JOIN eh INNER, logo o resultado real
    * tambem nunca traz nulo.
    *====================================================================
    PROTECTED PROCEDURE CriarCursorGradeVazio()
        CREATE CURSOR (THIS.this_cCursorDados) ( ;
            cdopes    C(20), ;
            cidchaves C(20), ;
            cnivels   C(20), ;
            ncors     N(10, 0), ;
            padraos   N(1, 0), ;
            ordems    N(3, 0), ;
            mercs     C(3), ;
            empds     C(3), ;
            opers     C(1), ;
            ndopes    N(4, 0) )

        RETURN .T.
    ENDPROC

    *====================================================================
    * ConexaoAtiva - .T. quando gnConnHandle existe E eh um handle valido.
    *
    * Existe para que o teste nao seja escrito como
    *   IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
    * que eh o padrao dominante no projeto e tem um defeito latente: VFP9 NAO
    * faz curto-circuito em OR (nem em AND), entao "gnConnHandle <= 0" eh
    * avaliado AINDA QUE o TYPE tenha dado "U" - e comparar variavel
    * inexistente com 0 estoura "Variable GNCONNHANDLE is not found". Com IF
    * ANINHADO o segundo teste so acontece quando o primeiro garantiu o tipo.
    *
    * PUBLIC (sem PROTECTED) porque o FORM tambem pergunta, antes de comecar a
    * gravar a grade: metodo do BO chamado de fora nao pode ser PROTECTED em
    * nenhum nivel da heranca (regra #51), e BusinessBase nao declara este nome.
    *====================================================================
    FUNCTION ConexaoAtiva()
        IF TYPE("gnConnHandle") != "N"
            RETURN .F.
        ENDIF

        RETURN (gnConnHandle > 0)
    ENDFUNC

    *====================================================================
    * ExecutarExclusao - DELETE de UMA linha de SigCdMop.
    *
    * Chamado SO por BusinessBase.Excluir() (PROTECTED - de fora, sempre
    * Excluir(); regra #51). Sem este override a base devolveria .F. com
    * "Metodo ExecutarExclusao() sem override na subclasse" e a linha que o
    * usuario apagou na grade continuaria no banco.
    *
    * Equivale a parte de DELETE do "poDataMgr.UpDate('crSigCdMop')" do legado:
    * la o TABLEUPDATE da view enviava um DELETE por registro marcado; aqui
    * quem decide QUAIS linhas sumiram eh a reconciliacao do form
    * (FormSigOpMop.GravarGrade), e este metodo executa UMA delas.
    *
    * DUAS guardas, as duas deliberadas:
    *   1) chave VAZIA recusa a exclusao. "DELETE ... WHERE cidchaves = ''"
    *      casaria com TODA linha de chave em branco da tabela (comparacao de
    *      char no SQL Server eh blank-padded ANSI) - apagaria registro de
    *      outra operacao. Recusar deixa a linha no banco, que eh a falha
    *      SEGURA: ela reaparece na proxima abertura.
    *   2) "AND cdopes" junto da PK. cidchaves JA eh a primary key
    *      (sigcdmop_cidchaves), entao o filtro eh redundante no caminho
    *      normal - ele existe para que um defeito futuro na reconciliacao nao
    *      consiga apagar linha de OUTRA operacao pai. Se divergir, o DELETE
    *      nao afeta nenhuma linha e o registro sobrevive (falha segura).
    *
    * RegistrarAuditoria roda ANTES de a base chamar LimparDados(), porque
    * ObterChavePrimaria() le this_cCidChaves - zerada, a auditoria sairia sem
    * chave e BusinessBase.RegistrarAuditoria descartaria o log.
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cChave, loc_oErro

        loc_lSucesso = .F.
        loc_cChave   = ALLTRIM(THIS.this_cCidChaves)

        TRY
            IF EMPTY(loc_cChave)
                THIS.this_cMensagemErro = "Linha sem chave prim" + CHR(225) + ;
                    "ria (cidchaves): exclus" + CHR(227) + "o recusada."
            ELSE
                TEXT TO loc_cSQL TEXTMERGE NOSHOW
                    DELETE FROM SigCdMop
                     WHERE cidchaves = <<EscaparSQL(loc_cChave)>>
                       AND cdopes    = <<EscaparSQL(ALLTRIM(THIS.this_cCdopes))>>
                ENDTEXT

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao excluir a opera" + CHR(231) + CHR(227) + ;
                        "o m" + CHR(250) + "ltipla:" + CHR(13) + CapturarErroSQL(), ;
                        "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message, "SigOpMopBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarChavesGravadas - popula this_cCursorChaves com as cidchaves que
    * JA existem em SigCdMop para a operacao PAI.
    *
    * Eh a base da reconciliacao que substitui o "poDataMgr.UpDate(
    * 'crSigCdMop')" do legado. A view remota do legado sabia, pelo proprio
    * buffer, quais registros eram novos, alterados ou apagados; o cursor local
    * desta arquitetura NAO guarda esse estado (CURSORGETPROP("Buffering") = 1
    * num "SELECT ... INTO CURSOR ... READWRITE" - regra #52), entao o estado
    * eh RECONSTRUIDO comparando a grade com a imagem do banco:
    *
    *   chave na grade E no banco   -> UPDATE
    *   chave na grade e NAO no banco -> INSERT
    *   chave no banco e NAO na grade -> DELETE
    *
    * UMA consulta resolve as tres decisoes para todas as linhas. A alternativa
    * (um "SELECT COUNT(*)" por linha) daria N+1 idas ao servidor para o mesmo
    * resultado.
    *
    * O cursor fica SOMENTE-LEITURA de proposito: ele so eh lido por LOCATE.
    *====================================================================
    PROCEDURE CarregarChavesGravadas()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorChaves)
                USE IN (THIS.this_cCursorChaves)
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT cidchaves
                  FROM SigCdMop
                 WHERE cdopes = <<EscaparSQL(ALLTRIM(THIS.this_cOperacaoPai))>>
            ENDTEXT

            IF !THIS.ConexaoAtiva()
                THIS.this_cMensagemErro = "Sem conex" + CHR(227) + "o com o banco: " + ;
                    "n" + CHR(227) + "o foi poss" + CHR(237) + "vel ler as opera" + ;
                    CHR(231) + CHR(245) + "es j" + CHR(225) + " gravadas."
            ELSE
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorChaves)

                IF loc_nResultado > 0 AND USED(THIS.this_cCursorChaves)
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao ler as opera" + CHR(231) + ;
                        CHR(245) + "es j" + CHR(225) + " gravadas:" + CHR(13) + ;
                        CapturarErroSQL()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro(loc_oErro.Message, "SigOpMopBO.CarregarChavesGravadas")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ConfirmarGravacao / DesfazerGravacao - o par Commit/RollBack que o
    * cmdSair.Click do legado executa sobre a conexao:
    *
    *   If m.lnErro1>0
    *       m.lnErro1 = Iif(.poDataMgr.UpDate('crSigCdMop'),1,-1)
    *   EndIf
    *   If m.lnErro1>0
    *       m.lnErro1 = .poDataMgr.Commit()      && <- passo PROPRIO, com
    *   EndIf                                    &&    caminho de falha proprio
    *   If Not m.lnErro1>0
    *       .poDataMgr.RollBack()
    *   EndIf
    *
    * O Commit NAO eh detalhe de infraestrutura: neste ambiente a conexao nasce
    * com SQLGETPROP(h, "Transactions") = 2 (MANUAL), entao sem SQLCOMMIT o
    * INSERT/UPDATE/DELETE fica preso na transacao aberta e SOME se o processo
    * morrer - defeito mudo que ja aconteceu no projeto por descartar
    * exatamente este passo do legado.
    *
    * O par eh INERTE quando a conexao esta em auto-commit (Transactions = 1):
    * cada statement ja foi efetivado e nao ha transacao para confirmar ou
    * desfazer. O teste vem num IF ANINHADO, nunca "IF loc_lManual AND
    * SQLCOMMIT(...)": VFP9 nao faz curto-circuito em AND e chamaria o
    * SQLCOMMIT de qualquer jeito.
    *
    * ATENCAO (fiel ao legado, e por isso mantido): SQLROLLBACK desfaz a
    * transacao da CONEXAO, nao apenas o que este dialogo escreveu - igual ao
    * ".poDataMgr.RollBack()" do legado, que atua no mesmo DataMgr do form pai.
    * Como esta tela grava em UM lote e fecha, nao ha outra escrita em aberto.
    *====================================================================
    PROCEDURE ConfirmarGravacao()
        LOCAL loc_lSucesso, loc_lManual, loc_nResultado
        loc_lSucesso = .F.

        IF !THIS.ConexaoAtiva()
            THIS.this_cMensagemErro = "Sem conex" + CHR(227) + "o com o banco."
            RETURN .F.
        ENDIF

        loc_lManual = (SQLGETPROP(gnConnHandle, "Transactions") = 2)

        IF loc_lManual
            loc_nResultado = SQLCOMMIT(gnConnHandle)

            IF loc_nResultado = 1
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao confirmar a transa" + CHR(231) + ;
                    CHR(227) + "o:" + CHR(13) + CapturarErroSQL()
            ENDIF
        ELSE
            *-- Auto-commit: cada statement ja esta efetivado, nada a confirmar.
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    PROCEDURE DesfazerGravacao()
        LOCAL loc_lSucesso, loc_lManual
        loc_lSucesso = .F.

        IF !THIS.ConexaoAtiva()
            RETURN .F.
        ENDIF

        loc_lManual = (SQLGETPROP(gnConnHandle, "Transactions") = 2)

        IF loc_lManual
            loc_lSucesso = (SQLROLLBACK(gnConnHandle) = 1)
        ELSE
            *-- Auto-commit: nao ha transacao aberta para desfazer. Devolve .F.
            *-- porque NADA foi desfeito - o chamador precisa saber que o que
            *-- gravou antes do erro ficou gravado.
            loc_lSucesso = .F.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
