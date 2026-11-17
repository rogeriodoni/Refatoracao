*==============================================================================
* verifteF.prg - Wrapper no-op documentado para a funcao GLOBAL do legado
* Fortyus VerifTef(), chamada por SIGOPPAG.Cancela.Click (dump linha 8469):
*
*     =VerifTef(thisform.parentform)
*
* VerifTef() NAO esta no acervo migrado (zero ocorrencias em
* projeto\app\utils, projeto\app\classes e nos dumps de tasks\*): e uma
* funcao de integracao com TEF (Transferencia Eletronica de Fundos -
* maquininha de cartao) que provavelmente confirma/cancela uma transacao de
* cartao pendente antes de fechar a tela. Regra #27 do CLAUDE.md - funcao
* global do legado chamada pelo p-code/.PRG sem definicao no acervo precisa
* de wrapper em utils\, nunca "deixar faltando".
*
* Categoria do wrapper (regra #27, tabela): NO-OP DOCUMENTADO. O proprio
* legado descarta o retorno com "=" (nunca testa o resultado), e nao ha
* integracao de hardware TEF no projeto novo - nenhuma tela do acervo
* migrado chama DECLARE DLL nem abre porta serial/COM para TEF. Devolver
* .T. sem fazer nada reproduz o UNICO caminho que o legado de fato segue
* quando chamado sem TEF ativo (o retorno e descartado de qualquer forma).
*
* Diferente de fCalcularST/fCalcularIPI (regra #27): aqui NAO ha valor de
* calculo em jogo, so um efeito colateral de hardware que nao existe nesta
* maquina - por isso o no-op e seguro e nao mascara regra de negocio.
*==============================================================================
LPARAMETERS par_oFormPai

RETURN .T.
