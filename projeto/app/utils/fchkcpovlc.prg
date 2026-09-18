*==============================================================================
* fchkcpovlc.prg - Wrapper de compatibilidade para os VCXs legado Fortyus.
*
* clsconta.mLeDados (classresp.vcx, linha 744) fecha a montagem da tela com:
*
*     =fChkCpoVlc(This, 'SigCdCli.DBF', ThisForm.Name, m.lcGrupo, .t., .t., ;
*                 'cr', ThisForm.pcLstSemChk1)
*     This.mAtuCampo()
*
* No legado fChkCpoVlc era funcao GLOBAL da aplicacao (sig.prg / SIGFUNCS.PRG),
* que nao veio no acervo migrado. Sem ela o VFP procura 'fchkcpovlc.prg' no PATH
* e estoura
*
*     File 'fchkcpovlc.prg' does not exist.
*
* Isso acontecia em TODO clique em Incluir do Cadastro de Cliente - esta no
* FormCliente_DiagIncluir.log de 17/09 e 18/09, sempre em "linha 744, proc
* mledados". Como mLeDados roda dentro do TRY/CATCH do FormCliente, o form
* sobrevivia, mas o restante do metodo (mAtuCampo, pcMudaCpfCgc, This.Visible)
* nunca executava.
*
* POR QUE UM NO-OP, E O QUE SE PERDE
* ----------------------------------
* Pelo nome e pelos argumentos ('SigCdCli.DBF' + nome do form + grupo + lista de
* campos a NAO checar), fChkCpoVlc percorria os controles marcando visualmente
* os campos obrigatorios do grupo - configuracao de UI. O retorno eh DESCARTADO
* pelo chamador (`=fChkCpoVlc(...)`), entao um no-op nao altera fluxo nenhum: a
* tela volta a completar a montagem.
*
* O que se perde eh a MARCACAO dos campos obrigatorios. A checagem de fato
* continua existindo, em mGravaDados, via fChkCntVlc (ver fchkcntvlc.prg).
*
* NAO transformar isto em "marcacao de verdade" sem antes achar o fonte legado:
* inventar quais campos sao obrigatorios por grupo eh pior que nao marcar nada -
* mascara a ausencia em vez de mostra-la. Mesma regra de fconfiggeral.prg.
*
* Origem: Erro163_Aba1 (2026-09-18, Cadastro de Cliente, clique em Incluir).
*==============================================================================
LPARAMETERS par_oObjeto, par_cTabela, par_cForm, par_cGrupo, ;
            par_lFlag1, par_lFlag2, par_cPrefixo, par_cListaSemCheck

RETURN .T.
