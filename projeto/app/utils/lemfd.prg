*==============================================================================
* lemfd.prg - Wrapper de compatibilidade para funcao global do legado Fortyus
* (SIGFUNCS.PRG), que NAO veio no acervo.
*
* Chamada no CmdInserir.Click do SIGOPVCI ("Vizualizacao de Cupom Impresso"),
* ramo da impressora fiscal NSWEDA:
*   lnRetorno = LeMFD(lcInic, lcFim, ThisForm.poFormulario)
*   If ! File('c:\Retorno.TXT')
*       MessageBox('Problemas na Leitura do Cupom !!!', 16, '')
*       Return
*   Endif
*
* Envia o comando de download da MFD (Memoria de Fita-Detalhe) a impressora
* NSWEDA por protocolo proprietario e grava a resposta em c:\Retorno.TXT. Esse
* protocolo nao esta disponivel no acervo migrado - sem ele nao ha como
* produzir o arquivo.
*
* NO-OP DOCUMENTADO (categoria "caminho seguro obvio" da regra CLAUDE.md #27):
* o retorno nao eh usado para calcular nada - o call site fecha o contrato
* testando File('c:\Retorno.TXT') na linha seguinte. Sem o arquivo, o proprio
* legado exibe "Problemas na Leitura do Cupom !!!" e aborta, ou seja a AUSENCIA
* fica VISIVEL ao usuario em vez de produzir cupom em branco em silencio.
*
* Devolve -1 (numerico), o mesmo codigo que o legado Fortyus usa para "modulo
* nao iniciado" nas tabelas de erro de integracao com equipamento.
*==============================================================================
LPARAMETERS par_cInicio, par_cFim, par_oFormulario

RETURN -1
