*******************************************************************************
* SIGOPCAUBO.prg - Business Object para Consulta de Acessos de Usuario
* (SIGOPCAU)
*
* Tabelas consultadas:
*   SigCdUsu (PK usuarios char(10))        - usuario filtrado (GetcUsu/GetDUsu)
*   SigCdGrA (PK grupos char(10))          - grupo de usuarios filtrado (GetGrupo)
*   SigCdAcU / SigCdAcG / SigCdPrg (Join)  - acessos do usuario/grupo filtrado,
*                                            ou TODOS os programas cadastrados
*                                            em SigCdPrg quando o usuario
*                                            logado eh o super-usuario
*                                            '4CONTROL' (legado: "If
*                                            Upper(Alltrim(Usuar))=[4CONTROL]")
*
* Origem: tasks\task652\SIGOPCAU_form_codigo_fonte.txt - o metodo MakeTree()
* do form legado monta a arvore de Programas/Parametros/Descricaos exibida
* no TreeView (ver comportamento.json: metodosComSQL=1, funcoesExternas=
* ["fLimpaTexto","fwBuscaExt"]).
*
* Natureza: dialogo OPERACIONAL somente-CONSULTA - o legado nao faz nenhum
* Insert/Update/Delete em tabela (so Select/SqlExecute para montar a arvore
* e fwBuscaExt para os 3 lookups de Usuario/Nome/Grupo, ver GetcUsu.Valid/
* GetDUsu.Valid/GetGrupo.Valid). Por isso Inserir()/Atualizar()/
* ExecutarExclusao() permanecerao SEM override nas proximas fases: o
* comportamento padrao herdado de BusinessBase (recusar a operacao) ja eh o
* correto para esta tela.
*
* Herda de: BusinessBase
* Fase 2/8 - MontarArvoreAcessos (consulta real, equivalente ao MakeTree()
* do legado), CarregarDoCursor() e ObterChavePrimaria()
*******************************************************************************

DEFINE CLASS SIGOPCAUBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Criterios de filtro da arvore de acessos (ligados aos campos da tela)
    *--------------------------------------------------------------------------
    this_cUsuarios     = ""   && sigcdusu.usuarios  char(10) - GetcUsu.Value  - codigo do usuario filtrado
    this_cNComps       = ""   && sigcdusu.ncomps    char(30) - GetDUsu.Value  - nome do usuario (preenchido pelo lookup)
    this_cGrupos       = ""   && sigcdgra.grupos    char(10) - GetGrupo.Value - codigo do grupo filtrado

    *--------------------------------------------------------------------------
    * Resultado da consulta (cursor da arvore de Programas/Parametros/
    * Descricaos montado por MontarArvoreAcessos na Fase 2) e espelho da
    * linha corrente, carregado por CarregarDoCursor
    *--------------------------------------------------------------------------
    this_cCursorArvore = "cursor_4c_Arvore"  && nome do cursor populado pela consulta (SigCdAcU/SigCdAcG/SigCdPrg ou SigCdPrg puro p/ super-usuario)
    this_nTotalNodes   = 0                   && RECCOUNT() de this_cCursorArvore apos a consulta

    this_cProgramas    = ""   && programas  char(15)  - coluna corrente de this_cCursorArvore (SigCdPrg.programas)
    this_cParametros   = ""   && parametros char(10)  - coluna corrente de this_cCursorArvore (SigCdPrg.parametros)
    this_cDescricaos   = ""   && descricaos char(150) - coluna corrente de this_cCursorArvore (SigCdPrg.descricaos) - texto hierarquico separado por "-" (cada nivel da arvore)

    *--------------------------------------------------------------------------
    * Init - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "sigcdusu"
        THIS.this_cCampoChave = "usuarios"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarArvoreAcessos - Monta this_cCursorArvore com os Programas/
    * Parametros/Descricaos de acesso do usuario ou grupo filtrado em
    * this_cUsuarios/this_cGrupos. Equivalente ao PROCEDURE maketree() do
    * legado (SIGOPCAU_form_codigo_fonte.txt) - o form chama este metodo
    * apos resolver o lookup de Usuario/Grupo e percorre this_cCursorArvore
    * em SCAN para montar os nodes do TreeView.
    *
    * Regra de negocio transcrita do legado:
    *   - this_cUsuarios preenchido:
    *       - super-usuario "4CONTROL" -> ve TODOS os programas cadastrados
    *         em SigCdPrg (sem filtro de acesso)
    *       - qualquer outro usuario    -> ve so os acessos ligados a ele em
    *         SigCdAcU OU herdados do grupo dele via SigCdAcG
    *   - this_cUsuarios vazio (filtro por Grupo) -> mesma consulta de
    *     acessos, filtrando SigCdAcU.Grupos/SigCdAcG.Grupos
    *
    * DESVIO DOCUMENTADO (nao reproduzido): no ramo "filtro por Grupo" o SCX
    * legado repete por engano ThisForm.GetcUsu.Value (sempre vazio nesse
    * ramo, por causa do guard mutuamente exclusivo em GetcUsu.When/
    * GetGrupo.When - um so campo fica habilitado por vez) no lugar de
    * ThisForm.GetGrupo.Value. Esse typo de copia-e-cola faz a busca por
    * Grupo nunca trazer resultado nenhum no legado. Aqui usa-se
    * this_cGrupos (o campo correto), preservando a INTENCAO da consulta -
    * reproduzir o typo tornaria a busca por Grupo sempre vazia, violando a
    * paridade funcional (REGRA FUNDAMENTAL do projeto).
    *
    * A primeira consulta do legado (Select * From SigCdUsu Where Usuarios=
    * ... em crSigCdUsu) foi omitida: o resultado nunca era usado (a unica
    * leitura de crSigCdUsu.supervis esta comentada com *!* no SCX) - a
    * checagem de super-usuario testa a variavel global do usuario LOGADO,
    * nao o usuario filtrado na tela.
    *--------------------------------------------------------------------------
    PROCEDURE MontarArvoreAcessos()
        LOCAL loc_cSQL, loc_nResultado, loc_cUsuario, loc_cGrupo

        THIS.this_cMensagemErro = ""
        THIS.this_nTotalNodes   = 0

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        loc_cUsuario = ALLTRIM(THIS.this_cUsuarios)
        loc_cGrupo   = ALLTRIM(THIS.this_cGrupos)

        IF !EMPTY(loc_cUsuario)
            IF UPPER(ALLTRIM(gc_4c_UsuarioLogado)) == "4CONTROL"
                loc_cSQL = "SELECT a.programas, a.parametros, a.descricaos " + ;
                           "FROM SigCdPrg a " + ;
                           "WHERE a.programas <> '' " + ;
                           "GROUP BY a.programas, a.parametros, a.descricaos " + ;
                           "ORDER BY a.descricaos, a.programas, a.parametros"
            ELSE
                loc_cSQL = "SELECT a.programas, a.parametros, c.descricaos " + ;
                           "FROM SigCdAcU a " + ;
                           "LEFT JOIN SigCdAcG b ON a.grupos = b.grupos " + ;
                           "LEFT JOIN SigCdPrg c ON a.programas = c.programas " + ;
                           "AND a.parametros = c.parametros " + ;
                           "WHERE a.programas <> '' AND (a.usuarios = " + EscaparSQL(loc_cUsuario) + ;
                           " OR b.usuarios = " + EscaparSQL(loc_cUsuario) + ") " + ;
                           "GROUP BY a.programas, a.parametros, c.descricaos " + ;
                           "ORDER BY c.descricaos, a.programas, a.parametros"
            ENDIF
        ELSE
            loc_cSQL = "SELECT a.programas, a.parametros, c.descricaos " + ;
                       "FROM SigCdAcU a " + ;
                       "LEFT JOIN SigCdAcG b ON a.grupos = b.grupos " + ;
                       "LEFT JOIN SigCdPrg c ON a.programas = c.programas " + ;
                       "AND a.parametros = c.parametros " + ;
                       "WHERE a.programas <> '' AND (a.grupos = " + EscaparSQL(loc_cGrupo) + ;
                       " OR b.grupos = " + EscaparSQL(loc_cGrupo) + ") " + ;
                       "GROUP BY a.programas, a.parametros, c.descricaos " + ;
                       "ORDER BY c.descricaos, a.programas, a.parametros"
        ENDIF

        IF USED(THIS.this_cCursorArvore)
            USE IN (THIS.this_cCursorArvore)
        ENDIF

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorArvore)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = "Erro ao consultar acessos: " + CapturarErroSQL()
            RETURN .F.
        ENDIF

        THIS.this_nTotalNodes = RECCOUNT(THIS.this_cCursorArvore)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Espelha a linha corrente de this_cCursorArvore
    * (populado por MontarArvoreAcessos) nas properties this_cProgramas/
    * this_cParametros/this_cDescricaos. Usado pelo form ao percorrer o
    * cursor em SCAN para montar cada node do TreeView.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF VARTYPE(par_cAliasCursor) != "C" OR EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)
        THIS.this_cProgramas  = TratarNulo(programas, "")
        THIS.this_cParametros = TratarNulo(parametros, "")
        THIS.this_cDescricaos = TratarNulo(descricaos, "")

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave do registro filtrado (usuarios, conforme
    * this_cCampoChave definido no Init). Nunca chamado em runtime porque
    * Inserir()/Atualizar()/ExecutarExclusao() permanecem sem override (ver
    * cabecalho do arquivo) - implementado por completude/consistencia com
    * o restante do projeto (CLAUDE.md: "Override ObterChavePrimaria em
    * cada BO").
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cUsuarios)
    ENDPROC

ENDDEFINE
