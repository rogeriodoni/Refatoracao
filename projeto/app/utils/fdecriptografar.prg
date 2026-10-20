*==============================================================================
* fdecriptografar.prg - Wrapper de compatibilidade para funcao global do
* legado Fortyus (SIGFUNCS.PRG), que NAO veio no acervo.
*
* Chamada em SIGOPAUT.autentica e em Formsigprtef.prg para decifrar o
* numero de fabricacao lido da impressora fiscal (LeituraFab) antes de
* consultar SigFiMpF.cImpFabs:
*   lcModelo = fDecriptografar(lcNoSerie)
*
* O algoritmo de cifragem/decifragem original nao esta no acervo. Sem ele,
* o unico comportamento seguro eh devolver o valor recebido sem alteracao
* (pass-through) - como LeituraFab() ja devolve "" (ver leiturafab.prg), a
* consulta subsequente a SigFiMpF.cImpFabs tambem nao casa com nada, que eh
* o mesmo efeito de "numero de fabricacao nao identificado" do legado.
*
* NAO confundir com fCriptografar() (hash de senha, outro algoritmo, outro
* proposito - ver memoria de projeto): decifrar um numero de serie de
* impressora nao tem relacao com validar senha de usuario.
*
* Regra CLAUDE.md #13/#27. Origem: Fase 7/8 de FormSigOpAut (task644).
*==============================================================================
LPARAMETERS par_cValor

RETURN IIF(VARTYPE(par_cValor) = "C", par_cValor, "")
