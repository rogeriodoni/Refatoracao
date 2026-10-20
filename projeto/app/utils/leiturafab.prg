*==============================================================================
* leiturafab.prg - Wrapper de compatibilidade para funcao global do legado
* Fortyus (SIGFUNCS.PRG), que NAO veio no acervo.
*
* Chamada em SIGOPAUT.autentica (impressora fiscal BEMA8501) e em
* Formsigprtef.prg, sempre como:
*   loc_cNoFab = LeituraFab(<oModem>)
*
* Le o numero de fabricacao gravado na impressora fiscal atraves de um
* protocolo proprietario da ECF (envia comando via porta serial/OLE e
* interpreta a resposta byte a byte). Esse protocolo nao esta disponivel
* no acervo migrado - sem ele nao ha como produzir o numero real.
*
* Retorna "" (string vazia, mesmo VARTYPE "C" que o legado espera): o
* chamador testa VARTYPE(loc_cNoFab) = "C" antes de usar, e "" encaminhada a
* fDecriptografar()/consulta a SigFiMpF simplesmente nao casa com nenhum
* numero de fabricacao real - o mesmo efeito pratico de "nao identificado"
* que o legado ja trata (cai no modelo Space(10)).
*
* Regra CLAUDE.md #13/#27. Origem: Fase 7/8 de FormSigOpAut (task644).
*==============================================================================
LPARAMETERS par_oModem

RETURN ""
