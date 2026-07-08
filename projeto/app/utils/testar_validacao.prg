*=============================================================================
* testar_validacao.prg
* Script para testar ValidarUIFidelity apos correcao do TextoParaRGB()
*=============================================================================

CLEAR
SET TALK OFF
SET CONSOLE ON

? "========================================================================="
? "Testando ValidarUIFidelity - FormCor"
? "========================================================================="
? ""

*-- Limpa arquivos .fxp compilados
? "1. Limpando arquivos .fxp..."
DELETE FILE C:\4c\projeto\app\utils\*.fxp

? "2. Executando ValidarUIFidelity..."
? ""

*-- Executa validacao
DO ValidarUIFidelity WITH "c:\4c\tasks\task1\SIGCDCOR_form_codigo_fonte.txt", "FormCor"

? ""
? "========================================================================="
? "Validacao concluida!"
? ""
? "Verifique o relatorio HTML gerado em:"
? "C:\4c\projeto\app\utils\relatorios\UIFidelity_FormCor_*.html"
? ""
? "Resultado esperado:"
? "  - 4 erros criticos (Dataenvironment - ACEITAVEL)"
? "  - 33 avisos (controles FormBase - ACEITAVEL)"
? "  - 0 diferencas visuais (ForeColor corrigido!)"
? "  = TOTAL: 37 problemas (todos aceitaveis)"
? "========================================================================="
