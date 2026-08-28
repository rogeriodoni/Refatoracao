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
*==============================================================================
LPARAMETERS par_uValor
RETURN EMPTY(par_uValor)
