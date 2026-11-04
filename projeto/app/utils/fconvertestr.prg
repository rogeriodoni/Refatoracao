*==============================================================================
* fconvertestr.prg - Wrapper para a funcao global legado Fortyus fConverteStr.
*
* Chamada direta no SCX de SIGOPCTF (Init): "lsEmp=fConverteStr(CrSigCdEmp.
* nEmps)" e "lcIdTerminal=fConverteStr(CrSigCdEmp.nEmps)+...". fConverteStr
* nao faz parte do acervo migrado (SIGFUNCS.PRG/sig.PRG, fora do projeto) -
* regra CLAUDE.md #13/#27: nome desconhecido seguido de "(" nao eh erro de
* compilacao, so estoura em RUNTIME ("File 'fconvertestr.prg' does not
* exist") quando o usuario abre a tela.
*
* CONTRATO: o nome ("converte para string") e o uso nos dois call sites -
* nEmps (numeric puro, sem formato de largura fixa no dump, ao contrario de
* TRANSFORM(..., "@L 999999") que o mesmo trecho usa quando quer padding) -
* indicam conversao GENERICA de valor para string, sem casas decimais nem
* zero-padding. ALLTRIM(TRANSFORM(x)) e a forma mais literal disso: nao
* inventa largura/padding que o dump nao evidencia.
*==============================================================================
LPARAMETERS par_uValor

RETURN ALLTRIM(TRANSFORM(par_uValor))
