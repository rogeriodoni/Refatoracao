# Guia de Teste Manual - FormSigReEtl
## Relatorio: Estoque Por Localizacao

**Data:** 2026-06-04  
**Arquivos:** `FormSigReEtl.prg` + `SigReEtlBO.prg`  
**FRX:** SigReEt1.frx ate SigReEt7.frx (pre-existentes)

---

## 1. ABRIR O FORMULARIO

### Como abrir:
```foxpro
DO main.prg  && no diretorio C:\4c\projeto\app\start
&& Navegar pelo menu -> Relatorios -> Estoque Por Localizacao
```

### Verificar ao abrir:
- [ ] Titulo da janela: "Estoque Por Localizacao" (com acento)
- [ ] Cabecalho escuro no topo com titulo branco
- [ ] 4 botoes no canto superior direito: Visualizar / Imprimir / Excel / Encerrar
- [ ] Empresa pre-preenchida (codigo + descricao da empresa atual)
- [ ] Grupo pre-preenchido (codigo do grupo de estoque da empresa)
- [ ] Conta pre-preenchida (conta de estoque da empresa)
- [ ] Campos de hierarquia (Base, Nivel 2, 3, 4) em branco
- [ ] Nivel 2, 3 e 4 DESABILITADOS (cinza)
- [ ] Radio "Sintetico" selecionado por padrao
- [ ] Checkbox "SubTotais Grupo/Subgrupo" DESABILITADO
- [ ] Radio "Primeiro Nivel" selecionado em Ordenacao

---

## 2. CAMPOS DE FILTRO - EMPRESA

### Teste 2.1 - Validacao por Enter:
1. Clicar no campo Empresa (primeiro campo)
2. Apagar o codigo atual, digitar um codigo invalido (ex: "XXX")
3. Pressionar Enter
4. Resultado esperado: MsgAviso "Empresa nao encontrada" + campo limpo + busca abre automaticamente

### Teste 2.2 - Busca por F4:
1. Clicar no campo Empresa
2. Pressionar F4
3. Resultado esperado: FormBuscaAuxiliar abre com lista de empresas
4. Selecionar uma empresa -> campo codigo e descricao preenchidos

### Teste 2.3 - Limpar empresa:
1. Apagar o codigo de empresa
2. Pressionar Enter ou Tab
3. Resultado esperado: descricao limpa

---

## 3. CAMPOS DE FILTRO - GRUPO E CONTA

### Teste 3.1 - Validacao Grupo:
1. Apagar o Grupo e digitar codigo invalido
2. Pressionar Enter -> MsgAviso + busca abre (SigCdGcr)
3. Pressionar F4 -> FormBuscaAuxiliar com grupos contabilidade

### Teste 3.2 - Validacao Conta:
1. Apagar a Conta e digitar codigo invalido
2. Pressionar Enter -> MsgAviso + busca abre (SigCdCli)
3. Pressionar F4 -> FormBuscaAuxiliar com contas

---

## 4. HIERARQUIA DE LOCALIZACAO (Base -> Nivel 2 -> Nivel 3 -> Nivel 4)

### Teste 4.1 - Cascade enable:
1. Base vazia -> Nivel 2 desabilitado
2. Digitar codigo de Base valido, pressionar Enter/Tab
3. Resultado esperado: Base preenchida, descricao carregada, Nivel 2 HABILITADO
4. Nivel 3 e 4 permanecem desabilitados

### Teste 4.2 - Nivel 2:
1. Com Base valida, digitar Nivel 2 valido
2. Pressionar Enter -> descricao carregada, Nivel 3 HABILITADO
3. Nivel 2 invalido -> MsgAviso + campos limpos, Nivel 3 desabilitado

### Teste 4.3 - Nivel 3 e 4 (mesma logica):
1. Com Base e Nivel 2 validos, preencher Nivel 3
2. Com Base, Nivel 2 e Nivel 3 validos, preencher Nivel 4

### Teste 4.4 - Cascade clear (mudanca de Base):
1. Preencher Base/Nvl2/Nvl3/Nvl4 completos
2. Editar o campo Base (mudar valor)
3. Resultado esperado: Nvl2, Nvl3, Nvl4 e Local LIMPOS; Nvl2 desabilitado

### Teste 4.5 - Busca de Base (F4):
1. Pressionar F4 no campo Base
2. FormBuscaAuxiliar abre com SigLcNv1

---

## 5. LOCALIZACAO DIRETA (pode ser alternativa a hierarquia)

### Teste 5.1 - Local valido:
1. Preencher campo Local com codigo valido (SigPrLcl)
2. Pressionar Enter -> descricao carregada
3. Resultado esperado: Base/Nvl2/Nvl3/Nvl4 sao LIMPOS automaticamente

### Teste 5.2 - Local invalido:
1. Digitar codigo invalido em Local
2. Pressionar Enter -> MsgAviso + busca abre (SigPrLcl)

### Teste 5.3 - F4 em Local:
1. Pressionar F4 -> FormBuscaAuxiliar com SigPrLcl

---

## 6. FILTROS DE PRODUTO (Grande Grupo, Grupo Produto, Subgrupo, Produto, Fornecedor)

### Teste 6.1 - Grande Grupo (GetCSGru - SigCdGpr):
1. Pressionar F4 -> FormBuscaAuxiliar com SigCdGpr
2. Digitar codigo invalido + Enter -> MsgAviso + busca abre

### Teste 6.2 - Grupo Produto (Cgru - SigCdGrp: CGrus/DGrus):
1. F4 abre FormBuscaAuxiliar com SigCdGrp
2. Codigo invalido -> MsgAviso

### Teste 6.3 - Subgrupo (CSubG - SigCdPsg: Codigos/Descricaos):
1. F4 abre FormBuscaAuxiliar com SigCdPsg
2. Codigo invalido -> MsgAviso

### Teste 6.4 - Produto (CdProduto - SigCdPro: CPros/DPros):
1. F4 abre FormBuscaAuxiliar com SigCdPro
2. Codigo invalido -> MsgAviso

### Teste 6.5 - Fornecedor (SigCdCli: iclis/rclis):
1. F4 abre FormBuscaAuxiliar com SigCdCli
2. Codigo invalido -> MsgAviso

---

## 7. TIPO DE RELATORIO E SUBTOTAIS

### Teste 7.1 - Opcoes de tipo:
1. Verificar 6 opcoes: Sintetico / Analitico / Com Descricao / [oculta] / Analitico Com Descricao / Sintetico Com Descricao
2. Botao 4 (Referencia por Local) deve estar INVISIVEL

### Teste 7.2 - SubTotais:
1. Selecionar "Sintetico" -> SubTotais DESABILITADO
2. Selecionar "Analitico" -> SubTotais DESABILITADO
3. Selecionar "Com Descricao" -> SubTotais HABILITADO
4. Marcar SubTotais e mudar para outro tipo -> SubTotais desabilitado E desmarcado

---

## 8. VALIDACAO DE CAMPOS OBRIGATORIOS

### Teste 8.1 - Sem empresa:
1. Apagar empresa, clicar em Visualizar
2. Resultado esperado: MsgErro "Empresa Invalida !!!" + foco no campo Empresa

### Teste 8.2 - Sem grupo:
1. Garantir empresa preenchida, apagar grupo, clicar em Visualizar
2. Resultado esperado: MsgErro "Grupo Invalido !!!" + foco no campo Grupo

---

## 9. GERACAO DO RELATORIO

### Teste 9.1 - Visualizar (Tipo 1 - Sintetico):
1. Empresa + Grupo preenchidos, tipo Sintetico selecionado
2. Clicar Visualizar
3. Resultado esperado: SigReEt1.frx aberto em preview

### Teste 9.2 - Visualizar (Tipo 2 - Analitico):
1. Selecionar Analitico, clicar Visualizar
2. Resultado esperado: SigReEt2.frx aberto em preview

### Teste 9.3 - Visualizar (Tipo 3 - Com Descricao sem subtotais):
1. Selecionar Com Descricao, deixar SubTotais desmarcado, Visualizar
2. Resultado esperado: SigReEt3.frx

### Teste 9.4 - Visualizar (Tipo 3 - Com Descricao com subtotais):
1. Selecionar Com Descricao, MARCAR SubTotais, Visualizar
2. Resultado esperado: SigReEt5.frx

### Teste 9.5 - Imprimir:
1. Clicar Imprimir -> dialogo de impressora aparece

### Teste 9.6 - Excel:
1. Clicar Excel
2. Resultado esperado: dialogo "Salvar como..." abre
3. Escolher local e nome, salvar
4. Resultado esperado: MsgInfo "Arquivo exportado com sucesso: [caminho]"
5. Verificar que arquivo .xls foi criado e pode ser aberto

---

## 10. ORDENACAO

### Teste 10.1 - Mudanca de ordem:
1. Selecionar "Segundo Nivel" em Ordenacao, clicar Visualizar
2. Verificar que relatorio esta ordenado por nivel 2 da localizacao
3. Testar todos os 4 niveis de ordenacao

---

## 11. ENCERRAR

### Teste 11.1:
1. Clicar botao Encerrar (ou pressionar Esc)
2. Formulario fecha sem erros
3. Sem mensagens de erro ou crashes

---

## COMPILACAO E PRE-REQUISITOS

- [x] SigReEtlBO.prg compila sem erros
- [x] FormSigReEtl.prg compila sem erros
- [ ] FRX SigReEt1.frx ate SigReEt7.frx existem em `app\reports\`
- [ ] Tabelas SigOpEtq, SigMvesl, SigCdPro, SigCdEmp, SigCdGcr, SigCdCli existem
- [ ] Tabelas SigLcNv1..4, SigPrLcl, SigCdGpr, SigCdGrp, SigCdPsg, SigCdCol existem
