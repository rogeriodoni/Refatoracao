*==============================================================================
* autentica.prg - Wrapper de compatibilidade para funcao GLOBAL do legado
* Fortyus (SIGFUNCS.PRG), que NAO veio no acervo.
*
* NAO confundir com o METODO FormSigOpAut.Autentica(par_nTipoAutentica) -
* o legado tinha a mesma colisao de nomes (PROCEDURE autentica do SCX +
* funcao global Autentica() chamada sem ThisForm de dentro dela) e
* funcionava porque uma chamada sem prefixo de objeto NUNCA resolve para
* metodo de classe (regra CLAUDE.md #8/#13) - so para arquivo global no
* PATH, que eh este.
*
* Chamada em SIGOPAUT.autentica:
*   RetImpVer = Autentica(ThisForm.oModem)
*
* Executa a 1a autenticacao/impressao na impressora fiscal (verso) via
* protocolo proprietario da ECF. Protocolo nao disponivel no acervo.
*
* Retorna .T. (sucesso assumido) - mesma justificativa de impverso.prg.
*
* Regra CLAUDE.md #13/#27. Origem: Fase 7/8 de FormSigOpAut (task644).
*==============================================================================
LPARAMETERS par_oModem

RETURN .T.
