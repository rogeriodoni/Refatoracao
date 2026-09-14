# Solicitacao de Teste Manual

**Task ID:** task085
**Formulario:** FormSIGREEGG (origem: SIGREEGG)
**Data:** 2026-06-04 14:34:43

---

## 1. Objetivo do Teste

Validar se o formulario migrado (**FormSIGREEGG**) esta funcionando corretamente e com UI identica ao original.

## 2. Pre-Requisitos

- [ ] Codigo migrado esta em: \C:\4c\projeto\app\forms\relatorios\FormSIGREEGG.prg\
- [ ] Business Object em: \C:\4c\projeto\app\classes\SIGREEGGBO.prg\
- [ ] Banco de dados acessivel: 192.168.15.101 (DB_MBAHIA)
- [ ] Usuario com permissao de teste

## 3. Casos de Teste

### 3.1. Teste de UI Fidelity

- [ ] Comparar visualmente com screenshot original (se disponivel)
- [ ] Verificar Width/Height do formulario
- [ ] Verificar cores (BackColor, ForeColor)
- [ ] Verificar fontes (FontName, FontSize)
- [ ] Verificar posicionamento de controles (Top, Left)
- [ ] Verificar se todos os botoes estao visiveis (nenhum "comido")

**Criterio de Aceitacao:** UI deve ser **pixel-perfect** identica ao original.

### 3.2. Teste Funcional - Modo INCLUIR

- [ ] Clicar no botao "Incluir"
- [ ] Preencher todos os campos obrigatorios
- [ ] Testar lookups (F4/F5) - se aplicavel
- [ ] Clicar em "Confirmar"
- [ ] Verificar se registro foi inserido no banco

**Criterio de Aceitacao:** Registro deve ser salvo com sucesso e auditoria registrada em LogAuditoria.

### 3.3. Teste Funcional - Modo ALTERAR

- [ ] Pesquisar um registro existente
- [ ] Clicar no botao "Alterar"
- [ ] Modificar campos
- [ ] Clicar em "Confirmar"
- [ ] Verificar se registro foi atualizado no banco

**Criterio de Aceitacao:** Registro deve ser atualizado e auditoria registrada.

### 3.4. Teste Funcional - Modo VISUALIZAR

- [ ] Pesquisar um registro existente
- [ ] Clicar no botao "Visualizar"
- [ ] Verificar se campos estao desabilitados (ReadOnly)
- [ ] Clicar em "Cancelar"

**Criterio de Aceitacao:** Campos nao editaveis, botao Confirmar desabilitado.

### 3.5. Teste Funcional - Modo EXCLUIR

- [ ] Pesquisar um registro existente
- [ ] Clicar no botao "Excluir"
- [ ] Confirmar exclusao
- [ ] Verificar se registro foi excluido do banco

**Criterio de Aceitacao:** Registro excluido logicamente (status) ou fisicamente, com auditoria.

### 3.6. Teste de Validacoes

- [ ] Testar campos obrigatorios (deixar vazio e tentar salvar)
- [ ] Testar InputMask (formato de campos)
- [ ] Testar duplicidade de chave primaria

**Criterio de Aceitacao:** Mensagens de erro claras e consistentes com sistema legado.

### 3.7. Teste de Performance

- [ ] Medir tempo de abertura do formulario
- [ ] Medir tempo de busca/pesquisa
- [ ] Medir tempo de salvamento

**Criterio de Aceitacao:** Performance similar ou melhor que sistema legado.

## 4. Metricas de Qualidade

### Validacao UI (Automatica)

- **Erros:** 0
- **Avisos:** 0
- **Diferencas:** 0
- **Total:** 0
- **Limite:** 10
- **Status:** âœ… APROVADO

[Ver relatorio detalhado](C:\4c\tasks\task085\validacao_ui_report.html)

## 5. Resultado do Teste

### Resumo

- [ ] UI Fidelity: **APROVADO / REPROVADO**
- [ ] Funcionalidade INCLUIR: **APROVADO / REPROVADO**
- [ ] Funcionalidade ALTERAR: **APROVADO / REPROVADO**
- [ ] Funcionalidade VISUALIZAR: **APROVADO / REPROVADO**
- [ ] Funcionalidade EXCLUIR: **APROVADO / REPROVADO**
- [ ] Validacoes: **APROVADO / REPROVADO**
- [ ] Performance: **APROVADO / REPROVADO**

### Evidencias

- Screenshots: *(anexar aqui)*
- Videos: *(anexar aqui)*
- Logs de erro: *(anexar aqui)*

### Problemas Encontrados

*(Listar problemas encontrados durante o teste manual)*

1.
2.
3.

### Aprovacao

- [ ] **APROVADO** - Formulario pronto para producao
- [ ] **REPROVADO** - Necessita correcoes

**Testador:** ___________________________
**Data:** ___________________________
**Assinatura:** ___________________________

---

**Proximos Passos:**

- Se APROVADO: Commit do codigo e deploy
- Se REPROVADO: Abrir issues para correcoes necessarias
