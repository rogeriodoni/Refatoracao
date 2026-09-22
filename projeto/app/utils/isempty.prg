*==============================================================================
* isempty.prg - Wrapper de compatibilidade para VCXs legado Fortyus.
*
* VFP9 puro NAO tem funcao IsEmpty() nativa. Os wrappers VCX compilados
* (framework.vcx/classresp.vcx) do Fortyus contem chamadas IsEmpty() no
* p-code. Quando VFP nao acha a funcao, procura por 'isempty.prg' no PATH.
* Este arquivo satisfaz essa busca redirecionando para EMPTY() nativa.
*
* Regra #2 do CLAUDE.md: em codigo NOSSO, sempre usar EMPTY() diretamente.
* Este wrapper existe APENAS para binarios legado que nao podemos re-editar.
*
*------------------------------------------------------------------------------
* NULL conta como vazio (Erro166).
*
* EMPTY() nativa NAO trata NULL - medido no VFP9: EMPTY(.NULL.) devolve .F.,
* ou seja, "nao esta vazio". O IsEmpty() do Fortyus trata: o nome e todos os
* call sites do p-code dizem "nulo ou vazio".
*
* Sintoma que levou ate aqui: o campo Obs. do Cadastro de Cliente exibia
* .NULL. na tela. O mRetiraNull do clsconta limpa os nulos assim -
*
*     Update crSigCdCli Set Obs = "" Where IsEmpty(Obs)
*
* - e com o wrapper devolvendo .F. para NULL o WHERE nao casava, a linha
* nunca era limpa e o .NULL. ficava visivel no EditBox. Medido:
*
*     UPDATE ... WHERE EMPTY(nome)                 -> linha NULL NAO eh limpa
*     UPDATE ... WHERE ISNULL(nome) OR EMPTY(nome) -> limpa
*
* O IF eh separado de proposito: VFP9 NAO faz short-circuit em OR, entao
* `ISNULL(x) OR EMPTY(x)` avaliaria EMPTY(x) mesmo com x nulo. Aqui isso
* seria inofensivo (EMPTY(.NULL.) nao da erro), mas a forma com IF nao
* depende disso e deixa a intencao explicita.
*
* ALCANCE: 142 call sites no p-code dos VCX que o projeto carrega
* (classresp.vcx 140, framework.vcx 2). Para todo valor NAO nulo o retorno
* eh identico ao de antes - a unica mudanca eh NULL passar a valer .T.
* Nos dois sentidos isso eh mais seguro que o comportamento anterior:
* `If IsEmpty(x)` passa a aplicar o default, e `If Not IsEmpty(x)` deixa de
* usar um valor nulo como se fosse dado.
*==============================================================================
LPARAMETERS par_uValor

IF ISNULL(par_uValor)
    RETURN .T.
ENDIF

RETURN EMPTY(par_uValor)
