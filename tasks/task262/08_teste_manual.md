# Roteiro de Teste Manual - Formsigprccp (Recálculo de Preços)
**Task**: 262 | **Data**: 2026-07-14 | **Tipo**: OPERACIONAL

---

## Pré-requisitos

- Sistema rodando (`DO main.prg`)
- Conexão com DB_MBAHIA ativa
- Produtos cadastrados em SigCdPro com composição em SigPrCpo
- Pelo menos uma moeda em SigCdMoe, um feitio em SigPrFti

---

## Abertura e Layout

| # | Ação | Resultado esperado |
|---|------|--------------------|
| 01 | Abrir via menu | Form abre, Caption="Recálculo de Preços", sem TitleBar |
| 02 | Verificar header cinza | Área cinza (RGB 100,100,100) no topo com título branco |
| 03 | Verificar botões | Processar / Atualizar / Encerrar alinhados à direita |
| 04 | Verificar botão Imprimir | Visível, **desabilitado** (ícone impressora) |
| 05 | Verificar SelTudo/Desmarcar | Botões de seleção à direita do grid |
| 06 | Verificar grid vazio | 9 colunas, sem dados |
| 07 | Verificar situação inicial | Compra = "Todos" (opção 3), Pven = "Não" (opção 2) |

---

## Filtros - Lookups por F4/Tab

| Campo | Tecla | Lookup abre em |
|-------|-------|----------------|
| Fornecedor | F4 / Tab | SigCdCli (IClis/RClis) |
| Unidade Ini | F4 / Tab | SigCdUni (CUnis/DUnis) |
| Unidade Fim | F4 / Tab | SigCdUni (CUnis/DUnis) |
| Linha Ini | F4 / Tab | SigCdLin (Linhas/Descs) |
| Linha Fim | F4 / Tab | SigCdLin (Linhas/Descs) |
| Coleção Ini | F4 / Tab | SigCdCol (Colecoes/Descs) |
| Coleção Fim | F4 / Tab | SigCdCol (Colecoes/Descs) |
| Grupo Ini | F4 / Tab | SigCdGrp (CGrus/DGrus) |
| Grupo Fim | F4 / Tab | SigCdGrp (CGrus/DGrus) |
| Subgrupo Ini | F4 / Tab | SigCdPsg (Codigos/Descricaos) |
| Subgrupo Fim | F4 / Tab | SigCdPsg (Codigos/Descricaos) |
| G.Grupo Ini | F4 / Tab | SigCdGpr (Codigos/Descs) |
| G.Grupo Fim | F4 / Tab | SigCdGpr (Codigos/Descs) |
| Moeda Ini | F4 / Tab | SigCdMoe (CMoes/DMoes) |
| Moeda Fim | F4 / Tab | SigCdMoe (CMoes/DMoes) |
| Feitio | F4 / Tab | SigPrFti (Cods/Descs) |
| Novo MKP | F4 / Tab | SigPrFti WHERE Tipos=1 |

**Para cada campo acima:**

| # | Ação | Resultado esperado |
|---|------|--------------------|
| F01 | Digitar código válido + Tab | Campo aceita, sem picker |
| F02 | Digitar código inválido + Tab | Picker abre filtrado pelo valor digitado |
| F03 | F4 com campo vazio | Picker abre com todos os registros |
| F04 | Selecionar no picker | Campo preenchido com o selecionado |
| F05 | Limpar campo + Tab | Campo fica vazio, sem erro |

---

## Opções de Situação e Compra

| # | Ação | Resultado esperado |
|---|------|--------------------|
| S01 | Clicar "Ativos" | Somente produtos com Situas='A' |
| S02 | Clicar "Inativos" | Somente produtos com Situas='I' |
| S03 | Clicar "Todos" (default) | Sem filtro por situação |
| C01 | Clicar "Comprar" | ForaLinha=0 somente |
| C02 | Clicar "Não Comprar" | ForaLinha=1 somente |
| C03 | Clicar "Todos" (default) | Sem filtro por compra |

---

## Opções de Recálculo

| # | Opção | Campos habilitados |
|---|-------|--------------------|
| R01 | 1 = Composição | Reajuste habilitado |
| R02 | 2 = Custo Venda | Reajuste **desabilitado** |
| R03 | 3 = Ambos | Reajuste habilitado |
| R04 | 4 = Peso Componentes | Reajuste habilitado |
| R05 | 5 = Câmbio | Reajuste habilitado |
| R06 | 6 = Câmbio (Inteiros) | Reajuste habilitado |
| R07 | 7 = Markup Custo | Novo MKP habilitado |
| R08 | 8 = Markup Venda | Novo MKP habilitado |

---

## Exclusão mútua Reajuste / Novo Markup

| # | Ação | Resultado esperado |
|---|------|--------------------|
| M01 | Digitar valor em Reajuste | Novo Markup fica zerado |
| M02 | Digitar valor em Novo Markup | Reajuste fica zerado |
| M03 | Zerar Reajuste | Novo Markup permanece |

---

## Fluxo Principal - Processar

| # | Ação | Resultado esperado |
|---|------|--------------------|
| P01 | Clicar Processar sem filtros | Grid preenche com produtos (variação aplicada) |
| P02 | Verificar colunas do grid | Cód, Descrição, Vlr Ant, Vlr Atu, Custo AFS, Custo FS, PVar%, CVar% |
| P03 | Processar com filtro Fornecedor | Grid mostra apenas produtos do fornecedor |
| P04 | Processar com Variação=5 | Grid exclui produtos com var% < 5 |
| P05 | Processar com Variação=-5 | Grid exclui produtos com var% > -5 |
| P06 | Após Processar | Botão Atualizar **fica habilitado** |
| P07 | Após Processar | Botão Imprimir **fica habilitado** |

---

## Grid - Seleção de Produtos

| # | Ação | Resultado esperado |
|---|------|--------------------|
| G01 | Clicar checkbox de um produto | CheckBox marca o produto (lMarca=1) |
| G02 | Clicar SelTudo | Todos os checkboxes marcados |
| G03 | Clicar Desmarcar | Todos os checkboxes desmarcados |
| G04 | Selecionar linha com produto com foto | Foto carrega no painel direito |
| G05 | Selecionar linha sem foto | Painel de foto fica oculto |

---

## Atualizar Preços

| # | Ação | Resultado esperado |
|---|------|--------------------|
| A01 | Clicar Atualizar sem nenhum produto marcado | Mensagem "Nenhum produto selecionado" |
| A02 | Marcar produtos e clicar Atualizar | Confirmação "Atualiza???" aparece |
| A03 | Responder NÃO na confirmação | Nenhuma alteração, form permanece |
| A04 | Responder SIM | Pergunta sobre etiquetas |
| A05 | Confirmar SIM para etiquetas | Preços atualizados + etiquetas impressas |
| A06 | Confirmar NÃO para etiquetas | Preços atualizados sem etiquetas |
| A07 | Após atualizar | Botão Atualizar desabilitado |

---

## Imprimir

| # | Ação | Resultado esperado |
|---|------|--------------------|
| I01 | Clicar Imprimir (habilitado após Processar) | Form SigPrCcr abre |

---

## Modo Automático

| # | Ação | Resultado esperado |
|---|------|--------------------|
| MA01 | Chamar form com this_lAutomatico=.T. | Form processa automaticamente e fecha |
| MA02 | Parâmetros lidos de SigCdCcp.Inativas<>1 | Processa com configurações salvas |

---

## Encerrar

| # | Ação | Resultado esperado |
|---|------|--------------------|
| E01 | Clicar Encerrar a qualquer momento | Form fecha sem erro |
| E02 | Cursores liberados | Nenhum cursor residual após fechar |

---

## Verificações de Banco (pós-Atualizar)

Após confirmar atualização, verificar em SigCdPro e SigPrCpo:

```sql
SELECT CPros, Margems, Moevs FROM SigCdPro WHERE CPros IN (<produtos_marcados>)
```

Os valores de `Moevs` (valor de venda) devem refletir o recálculo.

---

## Regressão

| # | Verificar | Resultado esperado |
|---|-----------|-------------------|
| REG01 | Outros forms não afetados | Nenhum impacto em outros forms |
| REG02 | Menu principal funciona após fechar | Menu responde normalmente |
| REG03 | Abrir form duas vezes seguidas | Segunda abertura funciona igual |
