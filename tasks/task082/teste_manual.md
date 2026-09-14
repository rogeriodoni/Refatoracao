# Teste Manual - FormSigReDpD (SIGREDPD.SCX)

**Tarefa**: task082  
**Formulario**: Analise de Producao por Movimentacao  
**Arquivos**: `projeto/app/forms/relatorios/FormSigReDpD.prg`, `projeto/app/classes/SigReDpDBO.prg`  
**Data**: 2026-06-04

---

## Pre-requisitos

- Sistema VFP9 rodando com conexao SQL Server ativa
- Banco DB_MBAHIA acessivel em 192.168.15.101
- Tabelas presentes: SigCdNec, SigCdNei, SigCdGcr, SigCdCli, SigCdOpd, SigInTgo, SigOpOpt, SigCdGrp, SigCdGpr, SigCdPam
- FRX reports em `gc_4c_CaminhoReports`: SigReDp1.frx a SigReDp8.frx (prerequisito para geracao de relatorio)

---

## 1. Abertura do Formulario

- [ ] Menu > Relatorios > "Analise de Producao"
- [ ] Form abre centralizado, sem barra de titulo
- [ ] Dimensoes: Width=800, Height=492
- [ ] Cabecalho cinza com titulo "Analise de Producao"
- [ ] 4 botoes superiores visiveis: Visualizar / Imprimir / Excel / Encerrar
- [ ] Page1 com campos de filtro
- [ ] Container de operacoes (grid) visivel a direita

---

## 2. Container de Operacoes (Grid CsSigCdOpd)

- [ ] Grid exibe operacoes/movimentacoes do usuario (carregadas no Init do BO)
- [ ] Coluna 1: checkbox (Marca) - pode marcar/desmarcar
- [ ] Coluna 2: descricao (Dopps) - somente leitura
- [ ] Botao "Marcar Todos" (seta para baixo): marca todos os checkboxes
- [ ] Botao "Desmarcar Todos" (X): desmarca todos os checkboxes

---

## 3. Campos de Filtro

### 3.1 Periodo
- [ ] Data Inicial obrigatorio (formato dd/mm/aaaa)
- [ ] Data Final obrigatorio (formato dd/mm/aaaa)

### 3.2 Tipo de OP (TpGOp)
- [ ] Campo habilitado/desabilitado conforme numero de opcoes no banco
- [ ] F4 abre busca em SigInTgo
- [ ] Se apenas 1 tipo no banco: pre-preenchido e desabilitado
- [ ] Se multiplos tipos: campo livre + F4 para busca

### 3.3 Movimentacao (GetDopes)
- [ ] F4 abre busca em SigCdOpd
- [ ] Ao preencher: container de operacoes (grid) DESAPARECE
- [ ] Ao limpar: container de operacoes REAPARECE
- [ ] Numero de movimentacao (Numes): campo numerico ao lado

### 3.4 Grupo (GetGrupo / GetDGrupo)
- [ ] Codigo Grupo: F4 abre busca em SigCdGcr com filtro GerBals=1
- [ ] Descricao Grupo: editavel quando codigo esta vazio; F4 busca por descricao
- [ ] Ao preencher codigo: descricao fica desabilitada para edicao
- [ ] Ao limpar codigo: campos Conta ficam desabilitados e limpos

### 3.5 Conta (GetConta / GetDConta)
- [ ] Conta desabilitada enquanto Grupo esta vazio
- [ ] Ao preencher Grupo: Conta torna-se habilitada
- [ ] Codigo Conta: F4 abre busca em SigCdCli com filtro GerBals=1
- [ ] Descricao Conta: editavel quando codigo conta esta vazio

### 3.6 Grande Grupo (GetGgrp)
- [ ] F4 abre busca em SigCdGpr
- [ ] Campo descricao (GetDGgrp): sempre desabilitado para edicao direta

### 3.7 Grupo Mat. Prima (GetCGru / GetDGru)
- [ ] Codigo CGru: F4 abre busca em SigCdGrp
- [ ] Descricao DGru: editavel quando CGru esta vazio
- [ ] Enter/Tab em CGru: valida contra SigCdGrp via SQLEXEC, preenche DGru
- [ ] Ao preencher CGru: DGru desabilitada para edicao

### 3.8 Tipo de Material (GetTpOps)
- [ ] F4 abre busca em SigOpOpt (filtrada por Situas<2 e Emps)

### 3.9 Envelope / OP
- [ ] Envelope: campo numerico (10 digitos)
- [ ] OP: campo numerico (6 digitos)

### 3.10 Cliente (GetCodCli / GetDescCli)
- [ ] Codigo cliente: F4 abre busca em SigCdCli com filtro GerBals=1
- [ ] Descricao: F4 busca por nome
- [ ] Ao preencher cliente: desabilita chk_Detalhe e chk_Produtos

---

## 4. Checkboxes

### 4.1 Imprimir Tipo de Material (chk_TpoOp)
- [ ] Marcar: desmarca automaticamente "Imprimir Valor" e "Imprimir Qtd/Peso"
- [ ] Estes tres checkboxes sao mutuamente exclusivos entre si

### 4.2 Imprimir Valor (chk_Valor)
- [ ] Marcar: desmarca "Imprimir Tipo de Material" e "Imprimir Qtd/Peso"

### 4.3 Imprimir Quantidade e Peso (chk_QtdPes)
- [ ] Marcar: desmarca "Imprimir Tipo de Material" e "Imprimir Valor"

### 4.4 Analisar pelo Destino (chk_Destino)
- [ ] Comportamento independente

### 4.5 Imprimir Movimentacoes (chk_Dopes)
- [ ] Comportamento independente

### 4.6 Imprimir Movimentacoes Detalhadas (chk_Detalhe)
- [ ] Marcar: habilita "Imprimir Produtos"
- [ ] Desmarcar: desabilita e limpa "Imprimir Produtos", "Imprimir Funcionario", "Modelo Relatorio"
- [ ] Desabilita quando cliente preenchido

### 4.7 Imprimir Produtos (chk_Produtos - inicia desabilitado)
- [ ] Habilitado apenas quando chk_Detalhe estiver marcado
- [ ] Marcar: habilita "Imprimir Funcionario / Assinatura"
- [ ] Desmarcar: desabilita e limpa "Imprimir Funcionario" e "Modelo Relatorio"
- [ ] Desabilita quando cliente preenchido

### 4.8 Imprimir Funcionario / Assinatura (chk_Funcs - inicia desabilitado)
- [ ] Habilitado apenas quando chk_Produtos estiver marcado E conta preenchida
- [ ] Marcar: habilita "Modelo Relatorio de Producao"
- [ ] Desmarcar: desabilita e limpa "Modelo Relatorio de Producao"

### 4.9 Modelo Relatorio de Producao (chk_Relatorio - inicia desabilitado)
- [ ] Habilitado apenas quando chk_Funcs estiver marcado

---

## 5. Selecao de FRX conforme opcoes

| Configuracao | FRX esperado |
|---|---|
| Detalhe=N, Dopes=N, Valor=N, QtdPes=N | SigReDp3 |
| Detalhe=N, Dopes=S | SigReDp2 |
| Detalhe=N, Valor=S | SigReDp4 |
| Detalhe=N, QtdPes=S | SigReDp8 |
| Detalhe=S, Valor=N, Produtos=N | SigReDp1 |
| Detalhe=S, Valor=N, Produtos=S | SigReDp5 |
| Detalhe=S, Valor=S, Relatorio=N | SigReDp6 |
| Detalhe=S, Valor=S, Relatorio=S | SigReDp7 |

---

## 6. Validacoes ao Imprimir/Visualizar

- [ ] Data inicial vazia -> aviso + foco em Data Inicial
- [ ] Data final vazia -> aviso + foco em Data Final
- [ ] Data final < Data inicial -> aviso + foco em Data Final
- [ ] Com filtros validos -> gera relatorio no FRX correto
- [ ] Apos relatorio: campo GetDopes limpo, container de operacoes reapare

---

## 7. Botoes

- [ ] **Visualizar**: preview na tela (REPORT FORM ... PREVIEW)
- [ ] **Imprimir**: abre dialogo de impressao
- [ ] **Excel**: comportamento identico ao Visualizar (BtnExcelClick -> BtnVisualizarClick)
- [ ] **Encerrar** (ou ESC): fecha o formulario

---

## 8. Fechar Formulario

- [ ] ESC fecha sem erros
- [ ] Botao Encerrar fecha sem erros
- [ ] Cursores liberados (SigReDpDBO.Destroy limpa CrSigCdGcr, CrSigOpOpt, CrSigCdCli, CrSigCdPam, CrTmpTpGop, CsSigCdOpd)

---

## 9. Status dos FRX

- **SigReDp1-7**: Copiados de `C:/4install/FortyusMC/Fortyus/` para `gc_4c_CaminhoReports`. Prontos para uso.
- **SigReDp8** (opcao "Imprimir Qtd/Peso"): Nao existia no legado. Criado como copia temporaria de SigReDp3 para evitar erro em runtime. Precisa de layout especifico com colunas de Qtd/Peso quando essa funcionalidade for implementada.
