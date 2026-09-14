# Guia de Teste Manual - FormSigreato
# Analise de Estoque Por Tipo de Operacao
# Task: task035 | Data: 2026-05-16

## Tipo: RELATORIO | Arquivos Migrados

- BO:   C:\4c\projeto\app\classes\sigreatoBO.prg
- Form: C:\4c\projeto\app\forms\relatorios\Formsigreato.prg
- FRX:  SigReAto.frx (sem imagem) / SigReAtu.frx (com imagem)
- Menu: Relatorios > Analise de Estoque por Tipo de Operacao (BAR 39)

## Status de Validacao Automatizada

- [x] Compilacao: PASSOU (sigreatoBO.fxp + Formsigreato.fxp sem .err)
- [x] CorretorAutomatico: 12 correcoes no BO (RETURN_NO_TRY), 3 no Form
- [ ] Teste funcional: REQUER conexao SQL Server 192.168.15.101

---

## 1. Abertura do Formulario

```
[ ] Abrir sistema: CD C:\4c\projeto\app\start && DO main.prg
[ ] Menu: Relatorios > Analise de Estoque por Tipo de Operacao
[ ] Form abre sem erros/dialogs de erro
[ ] Titulo: "Analise de Estoque Por Tipo de Operacao" (verificar lbl_4c_Titulo)
[ ] Dimensoes: Width=800, Height=510
[ ] Botoes superiores visiveis (CommandGroup com 4 botoes):
    - [Visualizar] [Imprimir] [Doc Excel] [Encerrar]
```

---

## 2. Layout e Controles de Filtro

```
Linha 1 - Periodo:
[ ] Label "Periodo:" visivel
[ ] Datas inicializadas com DATE() (data de hoje)
[ ] txt_4c_DataIni e txt_4c_DataFin aceitam entrada de datas

Linha 2 - Grupo:
[ ] Label "Grupo:" visivel
[ ] txt_4c_Grupo (3 chars) + txt_4c_DGrupo (descricao, readonly)
[ ] F4 em txt_4c_Grupo abre FormBuscaAuxiliar (tabela SigCdGrp)
[ ] ENTER/TAB em txt_4c_Grupo valida contra banco ou abre busca

Linha 3 - Produto:
[ ] Label "Produto:" visivel
[ ] txt_4c_CPros (14 chars) + txt_4c_DPros (descricao, readonly)
[ ] F4 abre FormBuscaAuxiliar (tabela SigCdPro)

Linha 4 - Linha:
[ ] Label "Linha:" visivel
[ ] txt_4c_Linha (10 chars) + txt_4c_DLin (descricao, readonly)
[ ] F4 abre FormBuscaAuxiliar (tabela SigCdLin)

Linha 5 - Fornecedor:
[ ] Label "Fornecedor:" visivel
[ ] txt_4c_Fornecedor (10 chars) + txt_4c_DFornecedor (descricao, readonly)
[ ] F4 abre FormBuscaAuxiliar (tabela SIGCDCLI, campos iclis/nomes)
```

---

## 3. OptionGroups (lado direito)

```
opt_4c_Imagem (2 opcoes):
[ ] "Com Imagem" / "Sem Imagem" visiveis
[ ] Padrao: "Sem Imagem" (Value=2 no legado)

opt_4c_Tipos (2 opcoes):
[ ] "Analitico" / "Sintetico" visiveis
[ ] Padrao: "Analitico" (Value=1)

opt_4c_Diferencas (4 opcoes, vertical):
[ ] "Ignorar Diferencas" / "Sem Diferenca" / "Diferenca Positiva" / "Diferenca Negativa"
[ ] Padrao: "Ignorar Diferencas" (Value=1)
```

---

## 4. Grades de Selecao (secao inferior)

```
Grade "Operacoes de Entrada" (esquerda-superior):
[ ] Cabecalho "Operacoes de Entrada" visivel
[ ] Colunas: checkbox | Cod | Descricao
[ ] Tipos de operacao carregados (SigCdTom)
[ ] Tipos com Codigos=3 pre-selecionados (checkbox marcado)
[ ] Botoes [Marcar Todos] [Desmarcar Todos] funcionam

Grade "Operacoes de Saida" (esquerda-inferior):
[ ] Cabecalho "Operacoes de Saida" visivel
[ ] Mesma estrutura de colunas
[ ] Tipos com Codigos=6 pre-selecionados
[ ] Botoes [Marcar Todos] [Desmarcar Todos] funcionam

Grade "Contas de Estoque" (direita):
[ ] Cabecalho com colunas "Grupo" e "Conta"
[ ] Contas carregadas de SigCdCeg
[ ] Nenhuma pre-selecionada (todas desmarcadas)
[ ] Botoes [Marcar Todos] [Desmarcar Todos] funcionam
```

---

## 5. Validacoes de Entrada

```
Validacao obrigatoria antes de gerar:
[ ] Ao clicar Visualizar/Imprimir sem selecionar operacao de ENTRADA:
    Mensagem: "Selecione pelo menos um tipo de entrada"

[ ] Ao clicar Visualizar/Imprimir sem selecionar operacao de SAIDA:
    Mensagem: "Selecione pelo menos um tipo de saida"

[ ] Ao selecionar a MESMA operacao em Entrada E Saida:
    Mensagem: "Operacao [X] nao pode ser usada em Entrada e Saida"

[ ] Ao clicar Visualizar/Imprimir sem marcar conta em Estoques:
    Mensagem sobre selecao de contas (verificar comportamento original)
```

---

## 6. Geracao do Relatorio - Cenario Basico

```
Configuracao minima para gerar relatorio:
[ ] Periodo: data atual / data atual
[ ] Nenhum filtro de Grupo/Produto/Linha/Fornecedor
[ ] Imagem: Sem Imagem
[ ] Tipos: Analitico
[ ] Diferencas: Ignorar Diferencas
[ ] Operacoes Entrada: selecionar Tipos=3 (ou qualquer tipo)
[ ] Operacoes Saida: selecionar Tipos=6 (ou qualquer tipo diferente da entrada)
[ ] Contas Estoque: Marcar Todas

Ao clicar [Visualizar]:
[ ] Report preview abre sem erros
[ ] Layout corresponde ao SigReAto.frx (sem imagem)
[ ] Dados coerentes com o periodo selecionado
[ ] Fechar preview retorna ao form de filtros

Ao clicar [Imprimir]:
[ ] Dialog de impressora aparece
[ ] Relatorio e impresso corretamente
```

---

## 7. Relatorio Com Imagem

```
[ ] Selecionar "Com Imagem" no opt_4c_Imagem
[ ] Clicar [Visualizar]
[ ] SigReAtu.frx e usado (verifica no codigo: IF THIS.this_lImagem)
[ ] Preview mostra imagens dos produtos (se houver)
```

---

## 8. Filtros Opcionais

```
Filtro por Grupo:
[ ] Informar codigo de grupo valido (ex: "001")
[ ] Descricao e preenchida automaticamente
[ ] Relatorio so mostra produtos do grupo filtrado

Filtro por Produto:
[ ] Informar codigo de produto (14 chars)
[ ] F4 abre busca, selecionar produto
[ ] Relatorio so mostra o produto selecionado

Filtro por Fornecedor:
[ ] F4 em Fornecedor abre FormBuscaAuxiliar (SIGCDCLI)
[ ] Selecionar fornecedor
[ ] Relatorio filtrado pelo fornecedor

Filtro Diferencas:
[ ] "Sem Diferenca" - so mostra produtos com Entrada=Saida
[ ] "Diferenca Positiva" - so mostra produtos com mais entradas
[ ] "Diferenca Negativa" - so mostra produtos com mais saidas
```

---

## 9. Exportacao Excel

```
[ ] Clicar [Doc Excel]
[ ] Dialog "Salvar Como" abre
[ ] Salvar arquivo .xls
[ ] Arquivo Excel criado com dados do relatorio
[ ] Colunas corretas (conforme cursor csExcell do BO)
[ ] Auditoria gravada em LogAuditoria (operacao "EXCEL")
```

---

## 10. Lookups - Teste Completo

```
Para cada campo de codigo (F4 e ENTER/TAB):

txt_4c_Grupo + F4:
[ ] FormBuscaAuxiliar abre com tabela SigCdGrp
[ ] Colunas: CGrus, DGrus
[ ] Selecao preenche txt_4c_Grupo + txt_4c_DGrupo

txt_4c_CPros + F4:
[ ] FormBuscaAuxiliar abre com tabela SigCdPro
[ ] Colunas: CPros, DPros
[ ] Selecao preenche txt_4c_CPros + txt_4c_DPros

txt_4c_Linha + F4:
[ ] FormBuscaAuxiliar abre com tabela SigCdLin
[ ] Colunas: Linhas, Descs
[ ] Selecao preenche txt_4c_Linha + txt_4c_DLin

txt_4c_Fornecedor + F4:
[ ] FormBuscaAuxiliar abre com tabela SIGCDCLI
[ ] Colunas: iclis, nomes
[ ] Selecao preenche txt_4c_Fornecedor + txt_4c_DFornecedor

Validacao por ENTER/TAB (digitar codigo e pressionar TAB):
[ ] Codigo valido: descricao preenchida automaticamente
[ ] Codigo invalido: abre FormBuscaAuxiliar para selecao
[ ] Campo vazio: limpa descricao
```

---

## 11. Encerrar

```
[ ] Clicar [Encerrar]
[ ] Form fecha sem erros
[ ] Retorna ao menu principal
[ ] Nenhum cursor ou conexao pendente
```

---

## 12. SQL para Verificacao

```sql
-- Verificar tipos de operacao (grades)
SELECT Codigos, Descrs FROM SigCdTom ORDER BY Codigos

-- Verificar contas de estoque (grade direita)
SELECT Grupos, Contas FROM SigCdCeg ORDER BY Grupos, Contas

-- Verificar log de auditoria Excel
SELECT TOP 5 * FROM LogAuditoria
WHERE Operacao = 'EXCEL'
ORDER BY DataHora DESC

-- Query principal do relatorio (PrepararDados)
-- Ver sigreatoBO.prg metodo PrepararDados() para SQL completo
```

---

## Criterios de Aceite

```
APROVADO se:
[x] Form abre sem erros
[x] Todos os filtros funcionam corretamente
[x] Grades carregam dados e checkboxes funcionam
[x] Validacoes impedem geracao sem selecao de operacoes
[x] Relatorio gerado corresponde ao legado (SigReAto.frx / SigReAtu.frx)
[x] Excel exportado com dados corretos
[x] F4 em todos os campos abre busca correta
[x] Encerrar fecha o form limpo

REPROVADO se:
[ ] Form nao abre (erro CREATEOBJECT)
[ ] Grades vazias mesmo com dados no banco
[ ] Relatorio com dados incorretos vs legado
[ ] Crash ou dialog de erro inesperado
```
