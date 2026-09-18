*==============================================================================
* finibirbtn.prg - Wrapper de compatibilidade para os VCXs legado Fortyus.
*
* btnReport.Click (framework.vcx), no ramo "Video" da barra de relatorio:
*
*     Case (This.Value = 1) && Video
*         =fInibirBtn(ThisForm.btnReport.Imprime.Enabled)
*         Set Sysmenu Off
*         Define Window Visualizar From 0, 0 To 37, 80 Title ...
*         ThisForm.Visualizacao()
*         Release Window Visualizar
*         Set Sysmenu On
*
* Sem o arquivo o VFP procura 'finibirbtn.prg' no PATH e estoura
*
*     File 'finibirbtn.prg' does not exist.
*
* no clique de Visualizar de QUALQUER relatorio - antes do preview abrir.
* Familia de isempty.prg / fconfiggeral.prg.
*
* POR QUE NO-OP, E POR QUE NAO DA PARA FAZER MELHOR
* -------------------------------------------------
* O retorno eh DESCARTADO (`=fInibirBtn(...)`), entao o no-op restabelece o
* fluxo inteiro: Visualizar volta a abrir o preview.
*
* E repare no argumento: `ThisForm.btnReport.Imprime.Enabled` eh um VALOR
* logico, nao o objeto. Passado POR VALOR, nao ha como esta funcao ter
* desabilitado aquele botao atraves dele - ela usava o valor como FLAG para
* configurar outra coisa (pelo nome e pelo contexto, o botao de impressao da
* janela de preview 'Visualizar', que eh do VFP e nao do form). Sem o fonte
* legado nao da para saber QUAL botao nem em que janela.
*
* O que se perde: o botao de imprimir do preview deixa de ser inibido/liberado
* conforme o direito de acesso. O controle de acesso em si NAO depende disto -
* ThisForm.lAcImprimir ja bloqueia o ramo de impressao (This.Value = 2) antes,
* no proprio Click.
*
* NAO inventar qual botao inibir: mexer no Enabled do objeto errado esconde ou
* libera acao sem ninguem perceber. Mesma regra de fconfiggeral.prg.
*
* Origem: Erro163_Aba1 (2026-09-18).
*==============================================================================
LPARAMETERS par_lEstadoBotao

RETURN .T.
