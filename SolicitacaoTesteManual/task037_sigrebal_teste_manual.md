# Guia de Teste Manual - Relatorio de Balanco (SIGREBAL)
## task037 - Formsigrebal.prg + sigrebalBO.prg

---

## Como Abrir

1. Inicie o sistema: `CD C:\4c\projeto\app\start` / `DO main.prg`
2. No menu: **Relatorios** > **Balanco**

---

## Filtros Disponiveis

| Campo | Tipo | Valor Padrao | Obrigatorio |
|-------|------|--------------|-------------|
| Ate (data final) | Data | DATE() (hoje) | SIM |
| Moeda | Codigo (3 chars) + descricao | Vazio | SIM (deve existir em SigCdMoe) |
| Empresa | Codigo + razao social | Vazio = todas as empresas | NAO |
| Conta Zerada | Sim/Nao | Sim | - |
| Tipo | Analitico/Sintetico | Analitico | - |
| Cotacao | Fechamento/Movimentacao | Fechamento | - |
| Cliente | Analitico/Sintetico | Analitico | - |
| Anal. Consistencia | Sim/Nao | Nao | - |
| Saldo conciliado | Sim/Nao | Nao | - |

---

## Testes de Interface

### T01 - Abertura do formulario
- [ ] Form abre sem erros
- [ ] Dimensoes: 800 x 400 pixels
- [ ] Cabecalho cinza escuro com titulo "Relatorio de Balanco"
- [ ] 4 botoes: Visualizar, Imprimir, Excel, Encerrar
- [ ] Data final preenchida com data de hoje

### T02 - Lookup de Moeda (campo obrigatorio)
- [ ] Pressionar F4 no campo Codigo abre FormBuscaAuxiliar (SigCdMoe)
- [ ] Duplo-clique no campo Codigo abre a busca
- [ ] Digitar codigo existente + ENTER/TAB preenche a descricao automaticamente
- [ ] Digitar codigo inexistente + ENTER abre a busca
- [ ] Limpar codigo limpa tambem a descricao

### T03 - Lookup de Empresa (campo opcional)
- [ ] Pressionar F4 no campo Codigo abre FormBuscaAuxiliar (SigCdEmp)
- [ ] Duplo-clique no campo Codigo abre a busca
- [ ] Digitar codigo valido + ENTER preenche razao social
- [ ] Campo vazio = relatorio para todas as empresas

### T04 - Validacao antes de gerar
- [ ] Clicar Visualizar com data vazia exibe aviso e foca no campo
- [ ] Sem moeda preenchida: comportamento esperado (checar se moeda e obrigatoria na query)

### T05 - Botao Visualizar
- [ ] Preencher filtros validos e clicar Visualizar
- [ ] Deve chamar PrepararDados() e exibir SigReBal.frx em preview
- [ ] Se Anal.Consistencia = Sim e houver inconsistencias: exibe tambem SigReAcs.frx
- [ ] Relatorio apresenta contas/saldos corretamente

### T06 - Botao Imprimir
- [ ] Clicar Imprimir com filtros validos
- [ ] Envia para impressora padrao sem dialogo de selecao
- [ ] Verifica impressao correta

### T07 - Botao Excel
- [ ] Clicar Excel com filtros validos
- [ ] Gera arquivo .XLS em %TEMP% com nome "Balanco_YYYYMMDD_HHMMSS.xls"
- [ ] Arquivo abre automaticamente no Excel/LibreOffice
- [ ] Conteudo contem as colunas: cEmpresas, cTitulo1s, cTitulo2s, cContas, cDContas, nSaldos, cOrds, cPs, cIps

### T08 - Botao Encerrar
- [ ] Clicar Encerrar fecha o formulario sem erros

---

## Testes de Comportamento dos Filtros

### T09 - Opcao "Conta Zerada = Nao"
- [ ] Contas com saldo zero NAO aparecem no relatorio

### T10 - Opcao "Tipo = Sintetico"
- [ ] Relatorio exibe apenas grupos/classes, sem clientes individuais

### T11 - Opcao "Cotacao = Movimentacao"
- [ ] Saldos calculados pela cotacao da data do movimento (nao fechamento)

### T12 - Opcao "Anal. Consistencia = Sim"
- [ ] Apos o balanco principal, exibe relatorio de analise de consistencia (SigReAcs.frx)
- [ ] Relatorio de consistencia mostra lancamentos com saldo divergente (ABS(Saldos) > 1)

### T13 - Filtro por Empresa
- [ ] Com empresa especifica: apenas movimentos de Emps ou EmpCcs = empresa escolhida
- [ ] Sem empresa: todas as empresas consolidadas

---

## Verificacao de Paridade com Sistema Legado

Comparar resultado com o sistema legado (SIGREBAL.SCX):
- [ ] Mesmo conjunto de contas apresentadas
- [ ] Mesmos saldos calculados para a mesma data/moeda
- [ ] Mesmos totalizadores por classe e grupo

---

## Arquivos Envolvidos

| Arquivo | Caminho |
|---------|---------|
| Form | `C:\4c\projeto\app\forms\relatorios\Formsigrebal.prg` |
| BO | `C:\4c\projeto\app\classes\sigrebalBO.prg` |
| Relatorio principal | `C:\4c\projeto\app\reports\SigReBal.frx` |
| Relatorio consistencia | `C:\4c\projeto\app\reports\SigReAcs.frx` |

---

## Observacoes Tecnicas

- Form FLAT (sem PageFrame): controles direto no form
- CommandGroup `cmg_4c_Botoes` com 4 botoes (ButtonCount=4)
- sigrebalBO herda de RelatorioBase
- PrepararDados() cria cursores `cPlConta` e `Consulta` esperados pelos FRX
- CarregarReferencias() carrega 6 cursores auxiliares: BalPam, BalCot, BalMoe, BalGcr, BalCss, BalCli
