*==============================================================================
* rotstatus.prg - Wrapper de compatibilidade para funcao global do legado
* Fortyus (SIGFUNCS.PRG), que NAO veio no acervo.
*
* Chamada no CmdInserir.Click do SIGOPVCI ("Vizualizacao de Cupom Impresso"),
* ramo da impressora fiscal EPSON, sempre com o retorno DESCARTADO:
*   RotStatus(.T.)
*
* Restaura/atualiza a rotina de status da impressora fiscal (le os flags do
* equipamento e atualiza o indicador na tela do PDV legado). Depende do
* protocolo proprietario do equipamento e do PDV Fortyus, nenhum dos dois
* disponivel no acervo migrado.
*
* NO-OP DOCUMENTADO (categoria "retorno descartado" da regra CLAUDE.md #27):
* os dois call sites ignoram o valor devolvido, entao nao ha contrato de valor
* a cumprir. O que se perde eh so a atualizacao do indicador de status do
* equipamento - nenhum dado do cupom depende disso.
*==============================================================================
LPARAMETERS par_lStatus

RETURN .T.
