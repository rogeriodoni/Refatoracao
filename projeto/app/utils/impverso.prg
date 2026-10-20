*==============================================================================
* impverso.prg - Wrapper de compatibilidade para funcao global do legado
* Fortyus (SIGFUNCS.PRG), que NAO veio no acervo.
*
* Chamada em SIGOPAUT.autentica:
*   RetImpVer = ImpVerso(_autVal, _toPrint, ThisForm.oModem, .T.)
*
* Envia ao verso do cupom/comprovante fiscal (impressao de autenticacao)
* via protocolo proprietario da ECF (porta serial/OLE). O protocolo nao
* esta disponivel no acervo migrado.
*
* Retorna .T. (sucesso assumido): o retorno so controla se a linha do
* cursor de pagamentos eh marcada como autenticada (ver
* FormSigOpAut.BtnImprimirClick) - devolver .F. aqui travaria a marcacao
* por causa de uma lacuna de migracao, nao de uma falha de impressao real.
* Em ambiente com a impressora fiscal conectada e o protocolo disponivel,
* substituir esta chamada pela integracao real.
*
* Regra CLAUDE.md #13/#27. Origem: Fase 7/8 de FormSigOpAut (task644).
*==============================================================================
LPARAMETERS par_cTextoAutenticacao, par_cObservacao, par_oModem, par_lVerso

RETURN .T.
