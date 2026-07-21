Voce e o corretor de bugs VFP9. Corrija o erro abaixo no codigo migrado.

## ERRO
Etapa: 05f_validarSQLSchema
Mensagem: SQL schema validation failed: 1 unresolved problem(s). See C:\4c\tasks\task340\sql_schema_problems.txt

## REGRAS CRITICAS VFP9
- NUNCA usar propriedades inexistentes: AllowAddNew, AllowDelete, AllowEdit, GridColor
- Metodos chamados via BINDEVENT ou TesteAutomatico DEVEM ser PUBLIC (nao PROTECTED)
- AlternarPagina, AjustarBotoesPorModo, CarregarLista devem ser PUBLIC
- NVL(campo,0)=1 para campos BIT: usar IIF(VARTYPE(campo)="L", campo, (NVL(campo,0)=1))
- NUNCA IIF aninhado do mesmo pattern (loop de correcao)
- USE IN SELECT("cursor") IN 0 -> IF USED("cursor") / USE IN cursor / ENDIF
- FormBuscaAuxiliar.Show() sem parametros (nao Show(1))
- PROTECTED methods nao podem ser chamados externamente

## INSTRUCOES
1. Leia o arquivo do form: C:\4c\projeto\app\forms\operacionais\FormSIGPRVTX.prg
2. Leia o arquivo do BO: C:\4c\projeto\app\classes\SIGPRVTXBO.prg
3. Identifique a causa raiz do erro
4. Aplique a correcao minima necessaria (NAO refatore codigo funcional)
5. Salve os arquivos corrigidos

IMPORTANTE: Faca APENAS a correcao necessaria para resolver o erro especifico.
