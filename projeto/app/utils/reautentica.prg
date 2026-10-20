*==============================================================================
* reautentica.prg - Wrapper de compatibilidade para funcao global do
* legado Fortyus (SIGFUNCS.PRG), que NAO veio no acervo.
*
* Chamada em SIGOPAUT.autentica:
*   RetImpVer = ReAutentica(ThisForm.oModem)
*
* Repete a ultima impressao de autenticacao na impressora fiscal (verso)
* via protocolo proprietario da ECF. Protocolo nao disponivel no acervo.
*
* Retorna .T. (sucesso assumido) - mesma justificativa de impverso.prg.
*
* Regra CLAUDE.md #13/#27. Origem: Fase 7/8 de FormSigOpAut (task644).
*==============================================================================
LPARAMETERS par_oModem

RETURN .T.
