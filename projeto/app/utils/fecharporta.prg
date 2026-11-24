*==============================================================================
* fecharporta.prg - Wrapper de compatibilidade para funcao global do legado
* Fortyus (SIGFUNCS.PRG), que NAO veio no acervo.
*
* Chamada no CmdInserir.Click do SIGOPVCI ("Vizualizacao de Cupom Impresso"),
* ramo da impressora fiscal EPSON, sempre com o retorno DESCARTADO:
*   FecharPorta(.t.)
*
* Fecha a porta de comunicacao (serial/USB) aberta por VerifPorta() antes de
* devolver o controle ao usuario. Depende do protocolo proprietario do
* equipamento, que nao esta disponivel no acervo migrado.
*
* NO-OP DOCUMENTADO (categoria "retorno descartado" da regra CLAUDE.md #27):
* os call sites ignoram o valor devolvido. Como o par VerifPorta() deste acervo
* nunca ABRE porta alguma (ver verifporta.prg), nao ha recurso pendente para
* este wrapper liberar - fechar nada eh o comportamento correto aqui.
*==============================================================================
LPARAMETERS par_lFechar

RETURN .T.
