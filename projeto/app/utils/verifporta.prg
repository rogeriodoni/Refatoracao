*==============================================================================
* verifporta.prg - Wrapper de compatibilidade para funcao global do legado
* Fortyus (SIGFUNCS.PRG), que NAO veio no acervo.
*
* Chamada no CmdInserir.Click do SIGOPVCI ("Vizualizacao de Cupom Impresso"),
* ramo da impressora fiscal EPSON:
*   lnReTorno =  VerifPorta()
*   If ! lnRetorno
*       RotStatus(.T.)
*       Return(.F.)
*   Endif
*
* Abre/verifica a porta de comunicacao (serial/USB) com a impressora fiscal
* antes de acionar a InterfaceEpson.dll. Depende do protocolo proprietario do
* equipamento, que nao esta disponivel no acervo migrado.
*
* NO-OP DOCUMENTADO (regra CLAUDE.md #27). Devolve .F. - "porta NAO
* disponivel" - que eh a direcao SEGURA: faz o chamador recusar a leitura em
* vez de acionar a DLL sobre uma porta cujo estado nao se conhece. NUNCA
* devolver .T. aqui: isso seguiria para o EPSON_Obter_Dados_MF_MFD e exibiria
* cupom vazio como se fosse resultado valido.
*
* O chamador migrado (Formsigopvci.ExtrairCupomEpson) reporta a recusa com a
* mensagem que o PROPRIO legado usa para "nao consegui conversar com o
* equipamento" ("Problemas na Leitura do Cupom !!!", dos ramos DARUMA/NSWEDA),
* para a ausencia ficar VISIVEL em vez de o botao nao fazer nada.
*==============================================================================
RETURN .F.
