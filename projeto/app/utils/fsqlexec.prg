*==============================================================================
* fsqlexec.prg - Wrapper de compatibilidade para os VCXs legado Fortyus.
*
* fwBuscaExt (framework.vcx) chama a funcao GLOBAL fSQLExec() em 3 pontos
* (Init + mLeituraLista + mProxRegistros), SEMPRE assim:
*
*     lnErro1 = fSQLExec(This.pnIdConn1, lcMcrSql1, lcCursor [, This.plCancel])
*     If Used(lcCursor) ...
*
* No legado fSQLExec era uma funcao GLOBAL da aplicacao (sig.prg / SIGFUNCS.PRG)
* que nao veio no acervo migrado. Como o p-code do VCX ja esta compilado e nao da
* para editar, o VFP procura 'fsqlexec.prg' no PATH e estoura
*
*     File 'fsqlexec.prg' does not exist.
*
* POR QUE ISSO DERRUBAVA A TELA
* -----------------------------
* clsconta.pgframeDados.pgframeDados1.GetEstado.Valid (o campo UF do Cadastro de
* Cliente) faz:
*
*     loLista = CreateObject('fwBuscaExt', ThisForm.poDataMgr.pnIdConn, ;
*                            'SigCdUfs', 'crListaRemota', 'Estados', This.Value, ;
*                            'Selecao', .T.)
*     If Not loLista.plAchouRegistro   && <- SEM guard Type('loLista')=='O'
*
* diferente do GetCEP, que embrulha o CreateObject num If Type(...)=='O'. O erro
* nasce DENTRO do Init do fwBuscaExt, fora de qualquer TRY/CATCH, num Valid:
* excecao nao tratada -> o form fecha. Era o "digita a UF e o form fecha"
* (Erro163_Aba1). Vale para TODO lookup fwBuscaExt do sistema, nao so a UF.
*
* POR QUE O CONTRATO AQUI NAO EH CHUTE
* ------------------------------------
* Os 3 call sites determinam a assinatura e a semantica inteiras: recebe handle
* numerico + comando SQL + nome do cursor, devolve NUMERICO testado com `> 0` e
* deixa o cursor aberto. Isso eh SQLEXEC(). O 4o parametro (plCancel) so existia
* para a caixa "cancelar" da versao legado; ignora-lo nao muda resultado nenhum.
*
* NAO acrescentar tratamento/mensagem de erro aqui: os chamadores JA tratam
* (`If Not Used(lcCursor)` -> refazem a query com `where 0=1`, ou exibem
* 'Falha na Conexao, Favor Reinicializar o Processo!'). Mensagem extra viraria
* dialog duplicado no meio de um Valid.
*
* As queries chegam com parametros `?m.peconteudo0` etc., declarados PRIVATE no
* Init do fwBuscaExt - PRIVATE eh visivel na cadeia de chamada, entao o SQLEXEC
* daqui resolve normalmente. Por isso nenhuma LOCAL abaixo pode usar esses nomes.
*
* Regra #13 do CLAUDE.md: em codigo NOSSO nunca se chama fSQLExec - use SQLEXEC
* direto. Este arquivo existe APENAS para binario legado.
*
* Origem: Erro163_Aba1 (2026-09-18, Cadastro de Cliente, campo UF).
*==============================================================================
LPARAMETERS par_nConexao, par_cComandoSQL, par_cCursor, par_lCancelavel

LOCAL loc_nResultado, loc_cCursor, loc_oErro

loc_nResultado = -1

IF VARTYPE(par_nConexao) <> "N" OR par_nConexao <= 0 OR ;
   VARTYPE(par_cComandoSQL) <> "C" OR EMPTY(par_cComandoSQL)
    RETURN -1
ENDIF

*-- SQLEXEC com cursor vazio grava em "sqlresult"; o legado sempre nomeia.
loc_cCursor = IIF(VARTYPE(par_cCursor) = "C" AND !EMPTY(par_cCursor), ;
                  ALLTRIM(par_cCursor), "sqlresult")

TRY
    loc_nResultado = SQLEXEC(par_nConexao, par_cComandoSQL, loc_cCursor)
CATCH TO loc_oErro
    *-- SEM MsgErro de proposito (excecao consciente a regra #9): isto roda
    *-- dentro de um Valid e quem chama JA exibe o proprio dialog de falha -
    *-- um MsgErro aqui viraria caixa duplicada. Para nao engolir o erro, grava
    *-- em log; o rastro fica em projeto\app\fSQLExec_Erro.log.
    IF TYPE("gc_4c_CaminhoBase") = "C"
        STRTOFILE("[" + TTOC(DATETIME()) + "] " + loc_oErro.Message + CHR(13) + CHR(10) + ;
                  "  SQL: " + LEFT(par_cComandoSQL, 500) + CHR(13) + CHR(10), ;
                  ADDBS(gc_4c_CaminhoBase) + "fSQLExec_Erro.log", 1)
    ENDIF
    loc_nResultado = -1
ENDTRY

RETURN loc_nResultado
