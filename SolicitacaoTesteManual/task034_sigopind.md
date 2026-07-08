# Solicitação de Teste Manual — SIGOPIND
**Task:** task034 | **Formulário:** Formsigopind | **Data:** 2026-03-05

---

## 1. Contexto

O formulário **SIGOPIND** (Conta Corrente Individual) é um formulário operacional (não CRUD padrão) com **2 abas**:

- **Aba SALDO**: Consulta saldos por grupo de conta corrente
- **Aba HIST**: Consulta histórico de lançamentos por conta individual

Arquivo migrado: `C:\4c\projeto\app\forms\cadastros\Formsigopind.prg`  
Business Object: `C:\4c\projeto\app\classes\sigopindBO.prg`

---

## 2. Pré-Requisitos

- [ ] Banco de dados acessível: `192.168.15.101` (DB_MBAHIA)
- [ ] Usuário com permissão de acesso ao módulo
- [ ] Aplicação iniciada via `C:\4c\projeto\app\start\main.prg`
- [ ] Arquivos `.fxp` deletados (para forçar recompilação limpa)

---

## 3. Casos de Teste — Aba SALDO (Page 1)

### TC-001: Abertura do Formulário
**Ação:** Abrir Formsigopind pelo menu  
**Esperado:**
- [ ] Formulário abre SEM barra de título (sem X/minimizar/maximizar)
- [ ] Tamanho: Width=1000, Height=600
- [ ] Aba SALDO é exibida por padrão (Page1 ativa)
- [ ] 4 botões no topo: Procurar, Imprimir, Consultar, Encerrar (ícones corretos)
- [ ] Grid de saldos vazio (sem dados iniciais)

### TC-002: Campos de Filtro — Aba SALDO
**Ação:** Verificar campos de filtro na aba SALDO  
**Esperado:**
- [ ] Campo **Grupo** (txt_4c_Grupo): TextBox editável, 80px
- [ ] Campo **Período De** (txt_4c_DtInicial): data, com InputMask de data
- [ ] Campo **Período Até** (txt_4c_DtFinal): data
- [ ] **OptionGroup** de filtro (Todos/Com Saldo/Sem Saldo)

### TC-003: Lookup Grupo (F4/F5 e duplo-clique)
**Ação:** No campo Grupo, pressionar F4 ou F5 (ou dar duplo-clique)  
**Esperado:**
- [ ] Abre formulário de busca (FormBuscaAuxiliar) com tabela SigCdGcr
- [ ] Colunas: Código e Descrição
- [ ] Ao selecionar um grupo, campo Grupo é preenchido com o código
- [ ] Campo de descrição (txt_4c_DGrupo) é preenchido automaticamente
- [ ] Campo Grupo da aba HIST (txt_4c_GrupoHist) também é sincronizado

### TC-004: Validação do Grupo (LostFocus)
**Ação:** Digitar código de grupo inválido no campo Grupo e sair do campo  
**Esperado:**
- [ ] Mensagem de aviso "Grupo não encontrado: XXX"
- [ ] Campo Grupo limpo
- [ ] Foco retorna ao campo Grupo

**Ação:** Digitar código de grupo válido e sair do campo  
**Esperado:**
- [ ] Campo de descrição preenchido automaticamente

### TC-005: Botão Procurar (Consultar Saldos)
**Ação:** Preencher filtros e clicar em Procurar  
**Esperado:**
- [ ] Grid principal (grd_4c_Saldo) carregado com dados
- [ ] Colunas: Grupo, Conta, Moeda, Saldo, CPF, Situação
- [ ] Dados correspondem ao banco para os filtros informados

### TC-006: Container de Opções de Saldo (cntSaldo)
**Ação:** Após consultar saldos, verificar painel de opções  
**Esperado:**
- [ ] Painel de opções exibido com campos:
  - Campo **Moeda** (txt_4c_CodMoeda): F4/F5 abre lookup SigCdMoe
  - Campo **Situação** (txt_4c_Situacao): F4/F5 abre lookup SigCdCst
  - OptionGroup de Ordem
  - Data Limite (txt_4c_DataLim)
- [ ] Lookup Moeda: preenche código + descrição (txt_4c_DesMoeda)
- [ ] Lookup Situação: preenche código da situação

### TC-007: Container de Resultado (cntConsulta)
**Ação:** Após filtrar, verificar painel de resultado  
**Esperado:**
- [ ] Painel exibido com dados do saldo consultado
- [ ] Botões: Imprimir Impressora, Vídeo, Excel, Fechar
- [ ] Botão Fechar fecha o painel cntConsulta

### TC-008: Botão Imprimir Saldo
**Ação:** Clicar em Imprimir na aba SALDO  
**Esperado:**
- [ ] Opções de impressão apresentadas (impressora/vídeo/Excel)
- [ ] Relatório gerado ou pré-visualizado

---

## 4. Casos de Teste — Aba HIST (Page 2)

### TC-009: Navegação para Aba HIST
**Ação:** Clicar no botão Consultar na aba SALDO  
**Esperado:**
- [ ] Formulário muda para Page 2 (aba HIST)
- [ ] Campo Grupo HIST (txt_4c_GrupoHist) pré-preenchido com grupo da aba SALDO
- [ ] Campos de filtro HIST visíveis: Moeda, Conta, ComboBox Conciliação

### TC-010: Lookup Moeda HIST (F4/F5)
**Ação:** No campo txt_4c_MoedaHist, pressionar F4/F5 ou duplo-clique  
**Esperado:**
- [ ] Abre FormBuscaAuxiliar com tabela SigCdMoe (Cmoes/Dmoes)
- [ ] Seleção preenche o campo de moeda

**Ação:** Digitar código de moeda inválido e sair do campo  
**Esperado:**
- [ ] Mensagem "Moeda não encontrada"
- [ ] Campo limpo

### TC-011: Lookup Conta HIST (F4/F5)
**Ação:** No campo txt_4c_ContaHist, pressionar F4/F5 ou duplo-clique  
**Esperado:**
- [ ] Abre FormBuscaAuxiliar com tabela SigCdCli (Iclis/Rclis)
- [ ] Seleção preenche código da conta + descrição (txt_4c_HdContaHist)

**Ação:** Digitar conta inválida e sair do campo  
**Esperado:**
- [ ] Mensagem "Conta não encontrada"
- [ ] Campos limpos

### TC-012: Busca de Histórico (Botão Procurar)
**Ação:** Preencher filtros da aba HIST e clicar Procurar  
**Esperado:**
- [ ] Grid de histórico (grd_4c_Historico) carregado
- [ ] Colunas: Chave, Data, Histórico, Valor, Operação, Empresa, Saldo, etc.
- [ ] Dados correspondem ao banco para conta/moeda/período informados

### TC-013: Botões de Ação do Histórico
**Ação:** Selecionar um lançamento no grid e testar botões  
**Esperado:**
- [ ] **Visualizar**: abre detalhe do lançamento (somente leitura)
- [ ] **Alterar**: abre detalhe do lançamento para edição
- [ ] **Excluir**: confirma e exclui o lançamento
- [ ] **Receber**: processa recebimento do lançamento
- [ ] **Conciliar**: concilia o lançamento
- [ ] **Auditar**: exibe histórico de auditoria
- [ ] **Follow Concilia/Conta/Lanc**: navegação por follow-up
- [ ] **Imprimir**: mostra painel de impressão do histórico
- [ ] **Movimento**: abre formulário de movimento

### TC-014: Container de Impressão HIST (cntImprime)
**Ação:** Clicar no botão Imprimir na aba HIST  
**Esperado:**
- [ ] Painel cntImprime aparece com campos de filtro de impressão:
  - Campo **Moeda** (txt_4c_CodMoedaImp): F4/F5 abre lookup SigCdMoe
  - Campo **Empresa** (txt_4c_EmpImp): F4/F5 abre lookup SigCdEmp
- [ ] Lookup Moeda preenche código + descrição (txt_4c_DesMoedaImp)
- [ ] Lookup Empresa preenche código + razão social (txt_4c_DesEmpImp)
- [ ] Validação LostFocus funciona para moeda inválida
- [ ] Validação LostFocus funciona para empresa inválida
- [ ] Botões: Vídeo, Impressora, Excel, Fechar

### TC-015: Container de Quitações (cntQuitas)
**Ação:** Verificar painel de quitações ao processar quitação  
**Esperado:**
- [ ] Painel cntQuitas exibido com dados corretos
- [ ] Botão Fechar fecha o painel

### TC-016: Encerrar da Aba HIST
**Ação:** Clicar em Encerrar na aba HIST  
**Esperado:**
- [ ] Retorna para aba SALDO (Page 1)
- [ ] Ou fecha o formulário completamente (verificar comportamento original)

---

## 5. Casos de Teste — Gerais

### TC-017: Botão Encerrar (Aba SALDO)
**Ação:** Clicar em Encerrar na aba SALDO  
**Esperado:**
- [ ] Formulário fechado corretamente
- [ ] Sem mensagens de erro
- [ ] Cursores liberados (sem "Alias already in use" em próxima abertura)

### TC-018: Reabertura do Formulário
**Ação:** Abrir o formulário, fechar, abrir novamente  
**Esperado:**
- [ ] Segunda abertura funciona sem erros
- [ ] Sem conflito de cursores (cursor_4c_Saldo, cursor_4c_Historico, xTmpBaixa)

### TC-019: Verificação Visual (UI Fidelity)
**Ação:** Comparar lado a lado com screenshot do sistema legado  
**Verificar:**
- [ ] Width=1000, Height=600
- [ ] Botões de topo: ícones corretos (procurar/imprimir/consultar/sair)
- [ ] Cor de fundo branca RGB(255,255,255)
- [ ] Fonte padrão "Tahoma" nos labels
- [ ] Fonte "Comic Sans MS" nos botões de topo
- [ ] Imagem de fundo (fundo_cad_1003.jpg) nas pages
- [ ] Cabeçalho escurecido RGB(100,100,100) com título branco
- [ ] Grid de saldos no posicionamento correto

### TC-020: Tratamento de Erros
**Ação:** Abrir o formulário sem conexão de banco de dados  
**Esperado:**
- [ ] Mensagem de erro clara (não crash silencioso)
- [ ] Formulário fecha de forma limpa

---

## 6. Resultado do Teste

| Caso | Descrição | Status |
|------|-----------|--------|
| TC-001 | Abertura do formulário | ☐ AP / ☐ RE |
| TC-002 | Campos de filtro SALDO | ☐ AP / ☐ RE |
| TC-003 | Lookup Grupo (F4/F5) | ☐ AP / ☐ RE |
| TC-004 | Validação Grupo (LostFocus) | ☐ AP / ☐ RE |
| TC-005 | Botão Procurar (saldos) | ☐ AP / ☐ RE |
| TC-006 | Container cntSaldo (lookups) | ☐ AP / ☐ RE |
| TC-007 | Container cntConsulta | ☐ AP / ☐ RE |
| TC-008 | Botão Imprimir Saldo | ☐ AP / ☐ RE |
| TC-009 | Navegação para aba HIST | ☐ AP / ☐ RE |
| TC-010 | Lookup Moeda HIST | ☐ AP / ☐ RE |
| TC-011 | Lookup Conta HIST | ☐ AP / ☐ RE |
| TC-012 | Busca de Histórico | ☐ AP / ☐ RE |
| TC-013 | Botões de ação do histórico | ☐ AP / ☐ RE |
| TC-014 | Container cntImprime (HIST) | ☐ AP / ☐ RE |
| TC-015 | Container cntQuitas | ☐ AP / ☐ RE |
| TC-016 | Encerrar aba HIST | ☐ AP / ☐ RE |
| TC-017 | Botão Encerrar (SALDO) | ☐ AP / ☐ RE |
| TC-018 | Reabertura do formulário | ☐ AP / ☐ RE |
| TC-019 | Verificação visual | ☐ AP / ☐ RE |
| TC-020 | Tratamento de erros | ☐ AP / ☐ RE |

**Aprovação geral:** ☐ APROVADO — Pronto para produção  
**Reprovação geral:** ☐ REPROVADO — Necessita correções

**Testador:** ___________________________  
**Data:** ___________________________

---

## 7. Problemas Encontrados

| # | Caso | Descrição do Problema | Severidade |
|---|------|-----------------------|------------|
| 1 | | | |
| 2 | | | |
| 3 | | | |

---

*Gerado por migração task034 | Sistema 4C | 2026-03-05*
