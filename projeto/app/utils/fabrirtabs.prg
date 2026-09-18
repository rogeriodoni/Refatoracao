*==============================================================================
* fabrirtabs.prg - Wrapper de compatibilidade para os VCXs legado Fortyus.
*
* fwBuscaProd (framework.vcx), no Init da busca de produtos, aplica a restricao
* por movimentacao assim:
*
*     If (Type([pRst])=[C]) And Not Empty(pRst)
*         If Not fAbrirTabs(.poDataMgr, [SigCdRpo], [LocalRopt], ;
*                           [Dopps = '] + pRst + ['])
*             Return .f.
*         EndIf
*         This.Restrito = Iif(Reccount([LocalRopt]) > 0, pRst, [])
*         Use In LocalRopt
*
* Sem o arquivo o VFP procura 'fabrirtabs.prg' no PATH e estoura
*
*     File 'fabrirtabs.prg' does not exist.
*
* dentro de um Init de form, fora de TRY/CATCH - mesmo modo de falha do campo UF
* (ver fsqlexec.prg). Familia de isempty.prg / fconfiggeral.prg.
*
* CONTRATO, LIDO DO CALL SITE
* ---------------------------
* Recebe o proprio fSqlConector do form (NAO o gnConnHandle global - eh a
* conexao do form que tem de ser usada), o nome da tabela, o nome do cursor
* destino e a condicao do WHERE. Devolve LOGICO; e tem de deixar o cursor
* ABERTO, porque o chamador faz `Reccount('LocalRopt')` e `Use In LocalRopt`
* logo em seguida.
*
* Do cursor so se usa o RECCOUNT (as colunas vem do Inner Join montado depois),
* entao `Select *` - a leitura literal de "abrir a tabela" - basta e nao inventa
* lista de colunas.
*
* Regra #13 do CLAUDE.md: em codigo NOSSO use SQLEXEC/DataAccess direto.
*
* Origem: Erro163_Aba1 (2026-09-18).
*==============================================================================
LPARAMETERS par_oDataMgr, par_cTabela, par_cCursor, par_cCondicao

LOCAL loc_cQuery, loc_cCursor, loc_nResultado, loc_oErro

loc_nResultado = -1

IF VARTYPE(par_oDataMgr) <> "O" OR ;
   VARTYPE(par_cTabela) <> "C" OR EMPTY(par_cTabela) OR ;
   VARTYPE(par_cCursor) <> "C" OR EMPTY(par_cCursor)
    RETURN .F.
ENDIF

loc_cCursor = ALLTRIM(par_cCursor)

loc_cQuery = "Select * From " + ALLTRIM(par_cTabela)
IF VARTYPE(par_cCondicao) = "C" AND !EMPTY(par_cCondicao)
    loc_cQuery = loc_cQuery + " Where " + ALLTRIM(par_cCondicao)
ENDIF

TRY
    IF USED(loc_cCursor)
        USE IN (loc_cCursor)
    ENDIF
    loc_nResultado = par_oDataMgr.SqlExecute(loc_cQuery, loc_cCursor)
CATCH TO loc_oErro
    *-- SEM MsgErro (excecao consciente a regra #9, como em fsqlexec.prg): roda
    *-- dentro de um Init de form e o chamador ja aborta com Return .f. Rastro
    *-- em projeto\app\fAbrirTabs_Erro.log para nao engolir o erro.
    IF TYPE("gc_4c_CaminhoBase") = "C"
        STRTOFILE("[" + TTOC(DATETIME()) + "] " + loc_oErro.Message + CHR(13) + CHR(10) + ;
                  "  SQL: " + LEFT(loc_cQuery, 500) + CHR(13) + CHR(10), ;
                  ADDBS(gc_4c_CaminhoBase) + "fAbrirTabs_Erro.log", 1)
    ENDIF
    loc_nResultado = -1
ENDTRY

RETURN (loc_nResultado > 0 AND USED(loc_cCursor))
