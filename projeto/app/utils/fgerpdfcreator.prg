*==============================================================================
* fgerpdfcreator.prg - Wrapper de compatibilidade para os VCXs legado Fortyus.
*
* btnReport.Click (framework.vcx), no ramo "Excel/Arquivo" da barra de
* relatorio, escolhe o gerador pela EXTENSAO pedida pelo usuario:
*
*     If Inlist(Lower(Alltrim(JustExt(Thisform.pcArqEmail))), [xls], [txt])
*         ThisForm.DocumentoExcel()
*         lPrintPDFCreator = .t.
*     Else
*         lPrintPDFCreator = fGerPDFCreator(ThisForm)
*     Endif
*     ...
*     If lPrintPDFCreator = .T.
*         If Type([Thisform.oEMAIL]) = [O]   && anexa o arquivo e envia o e-mail
*
* Sem o arquivo o VFP procura 'fgerpdfcreator.prg' no PATH e estoura
*
*     File 'fgerpdfcreator.prg' does not exist.
*
* ao pedir saida em PDF. Familia de isempty.prg / fconfiggeral.prg.
*
* POR QUE NO-OP RETORNANDO .F.
* -----------------------------
* Contrato: recebe o form e devolve LOGICO - .T. gerou o arquivo, .F. nao gerou
* (e o bloco de e-mail seguinte eh pulado).
*
* A implementacao legado esta logo abaixo do call site, COMENTADA (`*!*`): era
* automacao COM do PDFCreator (CreateObject('PDFCreator.clsPDFCreator'),
* WaitForJob, SetProfileSetting, ConvertTo...). Ou seja, o fonte foi movido para
* dentro de fGerPDFCreator e depende de um componente de TERCEIRO instalado na
* maquina, que nao faz parte deste projeto. Reimplementar isso por engenharia
* reversa de codigo comentado nao eh migracao, eh reescrita - e uma versao
* aproximada geraria PDF truncado/vazio sem erro nenhum na tela.
*
* DIFERENCA DELIBERADA EM RELACAO AO LEGADO
* -----------------------------------------
* Com .F. puro o chamador simplesmente pula tudo e o usuario clica "gerar PDF" e
* NAO ACONTECE NADA - falha muda, que eh justamente o que este projeto passa o
* tempo todo cacando. Por isso o aviso abaixo: o usuario fica sabendo que a
* saida em PDF nao esta disponivel nesta instalacao (Excel e TXT continuam
* funcionando normalmente, por outro caminho). Nao eh regra de negocio, eh
* tornar visivel uma ausencia.
*
* Origem: Erro163_Aba1 (2026-09-18).
*==============================================================================
LPARAMETERS par_oForm

MsgAviso("A gera" + CHR(231) + CHR(227) + "o de PDF n" + CHR(227) + "o est" + CHR(225) + ;
         " dispon" + CHR(237) + "vel nesta instala" + CHR(231) + CHR(227) + "o." + CHR(13) + ;
         "Gere o arquivo em .xls ou .txt.")

RETURN .F.
