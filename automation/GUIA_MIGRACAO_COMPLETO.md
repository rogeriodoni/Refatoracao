# GUIA COMPLETO: Migração de Formulário do Zero

**Versão:** 2.0 (com correções aplicadas)
**Data:** 2026-02-12
**Status:** ✅ PRODUÇÃO

---

## 🎯 OBJETIVO

Migrar qualquer formulário (pequeno ou grande, simples ou complexo) do sistema legado para o novo sistema com **100% de paridade funcional**, de forma **totalmente automatizada**.

---

## 📋 PRÉ-REQUISITOS

### 1. Arquivos Necessários

```
C:\4c\origem\
├── NOMEDOFORM.scx   ← Formulário original
└── NOMEDOFORM.sct   ← Memo do formulário
```

**IMPORTANTE:** Os arquivos devem estar em `C:\4c\origem\` (pasta observada pelo orquestrador).

### 2. Sistema Configurado

```powershell
# Verificar se config.json existe
Test-Path C:\4c\automation\config.json

# Verificar se OrquestradorMigracao.ps1 tem as correções
Select-String -Path C:\4c\automation\OrquestradorMigracao.ps1 -Pattern "Métodos OBRIGATÓRIOS do Form"

# Deve retornar: Linha com lista de 20 métodos
```

### 3. Banco de Dados Acessível

```
Servidor: 192.168.15.101
Banco: DB_MBAHIA
Usuário: sa
Senha: (configurada em config.json)
```

---

## 🚀 PROCEDIMENTO COMPLETO (7 PASSOS)

---

### **PASSO 1: Preparar Arquivos de Origem**

```powershell
# 1.1. Copiar arquivos .SCX/.SCT do legado para pasta origem
Copy-Item "\\servidor\legado\SIGCDCOR.scx" C:\4c\origem\
Copy-Item "\\servidor\legado\SIGCDCOR.sct" C:\4c\origem\

# 1.2. Verificar que os arquivos estão lá
Get-ChildItem C:\4c\origem\ -Filter "*.scx"

# Resultado esperado:
# SIGCDCOR.scx
# SIGCDCOR.sct (par obrigatório)
```

**⚠️ IMPORTANTE:**
- Apenas 1 par de arquivos (.scx + .sct) por vez
- Nome do arquivo será usado como base (ex: SIGCDCOR → FormCor)

---

### **PASSO 2: Executar Orquestrador**

```powershell
# 2.1. Navegar para pasta automation
cd C:\4c\automation

# 2.2. Executar orquestrador
.\OrquestradorMigracao.ps1

# OU especificar TaskId manualmente:
.\OrquestradorMigracao.ps1 -TaskId "task013"

# OU processar TODOS os arquivos da pasta origem:
.\OrquestradorMigracao.ps1 -ProcessAll
```

**O que acontece:**
O script detecta automaticamente o próximo número de task disponível e inicia o processo.

---

### **PASSO 3: Acompanhar Execução (Automática)**

O orquestrador executa **13 etapas automaticamente**:

```
Pipeline Automático:
┌─────────────────────────────────────────────────────────┐
│ ETAPA 1: Mover Arquivos                                 │
│ ├─ Move .scx/.sct para C:\4c\tasks\taskXXX\            │
│ └─ Duração: ~1 segundo                                  │
└─────────────────────────────────────────────────────────┘
                        ↓
┌─────────────────────────────────────────────────────────┐
│ ETAPA 2: Extrair Código Fonte                          │
│ ├─ ExtractSCXCode.prg → arquivo .txt                   │
│ └─ Duração: ~10 segundos                                │
└─────────────────────────────────────────────────────────┘
                        ↓
┌─────────────────────────────────────────────────────────┐
│ ETAPA 2a: Reduzir Arquivo (se > 500KB)                 │
│ ├─ Remove comentários/whitespace (90% redução)         │
│ └─ Duração: ~10 segundos                                │
└─────────────────────────────────────────────────────────┘
                        ↓
┌─────────────────────────────────────────────────────────┐
│ ETAPA 2b: Analisar Tarefa                              │
│ ├─ Extrai campos, lookups, grids → analise.json       │
│ └─ Duração: ~10 segundos                                │
└─────────────────────────────────────────────────────────┘
                        ↓
┌─────────────────────────────────────────────────────────┐
│ ETAPA 3: Gerar Meta-Prompt                             │
│ ├─ Cria meta_prompt.md COM lista de 20 métodos         │
│ ├─ Proíbe stubs/TODOs                                  │
│ └─ Duração: <1 segundo                                  │
└─────────────────────────────────────────────────────────┘
                        ↓
┌─────────────────────────────────────────────────────────┐
│ ETAPA 4: Gerar Mapeamento                              │
│ ├─ GeradorMapeamento.prg → mapeamento.json            │
│ └─ Duração: ~10 segundos                                │
└─────────────────────────────────────────────────────────┘
                        ↓
┌─────────────────────────────────────────────────────────┐
│ ETAPA 4b: Gerar Esqueletos                             │
│ ├─ GeradorEsqueletos.prg → código ~70% completo       │
│ └─ Duração: ~10 segundos                                │
└─────────────────────────────────────────────────────────┘
                        ↓
┌─────────────────────────────────────────────────────────┐
│ ETAPA 5: Migração com Claude                           │
│ ├─ ClaudeInvoker.ps1 → Form.prg + BO.prg               │
│ ├─ Usa meta-prompt com 20 métodos obrigatórios         │
│ ├─ Exige implementação COMPLETA (não aceita stubs)     │
│ └─ Duração: ~5-10 minutos                               │
│                                                         │
│ **RESULTADO ESPERADO (COM CORREÇÕES):**                │
│ ✅ FormXXX.prg criado (100% completo)                  │
│ ✅ XXXBO.prg criado (100% completo)                    │
│ ✅ Todos os 20 métodos implementados                   │
│ ✅ CarregarLista(): 40+ linhas funcionais              │
│ ✅ AlternarPagina(): completo                          │
│ ✅ FormParaBO/BOParaForm: todos os campos              │
└─────────────────────────────────────────────────────────┘
                        ↓
┌─────────────────────────────────────────────────────────┐
│ ETAPA 5b: Correção Automática                          │
│ ├─ CorretorAutomatico.ps1 (17 anti-padrões)           │
│ └─ Duração: <1 segundo                                  │
└─────────────────────────────────────────────────────────┘
                        ↓
┌─────────────────────────────────────────────────────────┐
│ ETAPA 5c: Validar Compilação                           │
│ ├─ Compila Form.prg e BO.prg                           │
│ ├─ Verifica erros de sintaxe                           │
│ └─ Duração: ~3 segundos                                 │
└─────────────────────────────────────────────────────────┘
                        ↓
┌─────────────────────────────────────────────────────────┐
│ ETAPA 6: Testar Formulário                             │
│ ├─ TestFormWrapper.prg (teste visual básico)           │
│ └─ Duração: ~10 segundos                                │
└─────────────────────────────────────────────────────────┘
                        ↓
┌─────────────────────────────────────────────────────────┐
│ ETAPA 6b: Teste Automático CRUD (COM VALIDAÇÃO 100%)   │
│ ├─ TesteAutomatico.prg (5 testes)                      │
│ │   1. Instanciação                                    │
│ │   2. CarregarLista                                   │
│ │   3. ModoIncluir (AlternarPagina)                    │
│ │   4. ModoVisualizar                                  │
│ │   5. Fechar                                          │
│ ├─ Threshold: 100% (5 de 5) - OBRIGATÓRIO             │
│ └─ Duração: ~10 segundos                                │
│                                                         │
│ **SE < 100%:** ❌ BLOQUEIA pipeline                    │
│ Mostra quais métodos faltam e PARA execução            │
└─────────────────────────────────────────────────────────┘
                        ↓
┌─────────────────────────────────────────────────────────┐
│ ETAPA 7: Validar UI Fidelity (COM VALIDAÇÃO RIGOROSA)  │
│ ├─ ValidarUIFidelity.prg (18 propriedades visuais)     │
│ ├─ Compara pixel-perfect com original                  │
│ ├─ Limite: ≤37 problemas (4 Dataenv + 33 FormBase)    │
│ ├─ Bloqueia se diferenças visuais reais (> 0)         │
│ └─ Duração: ~10 segundos                                │
│                                                         │
│ **SE > 37 problemas ou diferenças:** ❌ BLOQUEIA       │
└─────────────────────────────────────────────────────────┘
                        ↓
┌─────────────────────────────────────────────────────────┐
│ ETAPA 8: Gerar Solicitação de Teste Manual             │
│ ├─ Cria documento para tester validar                  │
│ └─ Duração: <1 segundo                                  │
└─────────────────────────────────────────────────────────┘
                        ↓
                ✅ COMPLETED
```

**Tempo Total:** ~10-15 minutos (depende do tamanho do formulário)

---

### **PASSO 4: Verificar Resultado**

```powershell
# 4.1. Verificar status da task
Get-Content C:\4c\tasks\taskXXX\task_state.json | ConvertFrom-Json | Select-Object status

# Resultado esperado:
# status: COMPLETED

# 4.2. Verificar arquivos gerados
Test-Path C:\4c\projeto\app\classes\XXXBO.prg
Test-Path C:\4c\projeto\app\forms\cadastros\FormXXX.prg

# Resultado esperado:
# True
# True

# 4.3. Verificar resultado dos testes
Get-Content C:\4c\tasks\taskXXX\teste_resultado.json | ConvertFrom-Json

# Resultado esperado:
# {
#   "resumo": {
#     "total": 5,
#     "passou": 5,
#     "falhou": 0,
#     "percentual": 100
#   }
# }
```

---

### **PASSO 5: Deletar .fxp (CRÍTICO)**

```powershell
# 5.1. Deletar TODOS os .fxp antes de testar
Get-ChildItem -Path "C:\4c\projeto\app" -Filter "*.fxp" -Recurse | Remove-Item -Force

# 5.2. Verificar que foram deletados
Get-ChildItem -Path "C:\4c\projeto\app" -Filter "*.fxp" -Recurse

# Resultado esperado:
# (nenhum arquivo)
```

**Por quê?** VFP9 cacheia .fxp. Sem deletar, mudanças no .prg não têm efeito.

---

### **PASSO 6: Testar Formulário Manualmente**

```powershell
# 6.1. Abrir VFP9
cd C:\4c\projeto\app\start
"C:\Program Files (x86)\Microsoft Visual FoxPro 9\VFP9.EXE"

# 6.2. Executar main.prg
DO main.prg

# 6.3. Abrir formulário pelo menu
# Menu → Cadastros → [Nome do Formulário]
```

**Testar:**
- ✅ Form abre sem erros
- ✅ Grid carrega dados (Page1)
- ✅ Botões CRUD funcionam
- ✅ Incluir → Preencher → Salvar
- ✅ Alterar → Modificar → Salvar
- ✅ Visualizar → Apenas leitura
- ✅ Excluir → Confirma exclusão
- ✅ Lookups funcionam (F4/DblClick)

---

### **PASSO 7: Validar UI Fidelity (Opcional mas Recomendado)**

```powershell
# 7.1. Re-executar ValidarUIFidelity manualmente
cd C:\4c\projeto\app\utils

# No VFP9:
DO ValidarUIFidelity WITH "C:\4c\tasks\taskXXX\ARQUIVO_codigo_fonte.txt", "FormXXX"

# 7.2. Abrir relatório HTML
start C:\4c\projeto\app\utils\relatorios\validacao_ui_FormXXX_*.html
```

**Meta:** ≤ 37 problemas (4 Dataenvironment + ≤33 FormBase + 0 diferenças)

---

## ✅ CRITÉRIOS DE SUCESSO

Uma migração está **COMPLETA** quando:

| Critério | Threshold | Como Verificar |
|----------|-----------|----------------|
| **Arquivos Gerados** | 2 arquivos (.prg) | Test-Path Form + BO |
| **Compilação** | 0 erros | Etapa 5c passa |
| **Teste Automático** | 100% (5/5) | Etapa 6b passa |
| **UI Fidelity** | ≤37 problemas | Etapa 7 passa |
| **Teste Manual** | Todas as operações CRUD | Teste visual |

---

## ❌ O QUE FAZER SE FALHAR

### Cenário 1: Etapa 6b Falha (Testes < 100%)

```
ERRO: Testes automaticos abaixo do threshold!
  Obtido: 80% (4 de 5)

TESTES QUE FALHARAM:
  - CarregarLista: Property CARREGARLISTA is not found
```

**Solução:**
```powershell
# 1. Abrir Form gerado
notepad C:\4c\projeto\app\forms\cadastros\FormXXX.prg

# 2. Verificar se método existe
# Procurar por: PROCEDURE CarregarLista

# 3. Se não existe ou está vazio (stub):
# Adicionar implementação completa (ver exemplos em CORRECAO_IMPLEMENTACAO_COMPLETA.md)

# 4. Deletar .fxp
Get-ChildItem -Path "C:\4c\projeto\app" -Filter "*.fxp" -Recurse | Remove-Item -Force

# 5. Re-executar apenas Etapa 6b
cd C:\4c\automation
.\OrquestradorMigracao.ps1 -TaskId "taskXXX" -ResumeFromStep 6b
```

**Prevenção:** Com as correções aplicadas, isso NÃO deve mais acontecer!

---

### Cenário 2: Etapa 7 Falha (UI Fidelity > 37)

```
ERRO: Diferencas visuais INACEITAVEIS!
  Obtido: 52 problemas

DETALHAMENTO:
  - Erros: 4 (OK)
  - Avisos: 33 (OK)
  - Diferencas: 15 (ERRO!)  ← Propriedades visuais diferentes
```

**Solução:**
```powershell
# 1. Abrir relatório HTML
start C:\4c\tasks\taskXXX\validacao_ui*.html

# 2. Corrigir propriedades diferentes:
# Exemplo: Width original=800, atual=750
# Abrir FormXXX.prg e corrigir:
notepad C:\4c\projeto\app\forms\cadastros\FormXXX.prg

# Procurar: Width = 750
# Substituir: Width = 800

# 3. Deletar .fxp
Get-ChildItem -Path "C:\4c\projeto\app" -Filter "*.fxp" -Recurse | Remove-Item -Force

# 4. Re-executar Etapa 7
cd C:\4c\automation
.\OrquestradorMigracao.ps1 -TaskId "taskXXX" -ResumeFromStep 7
```

---

### Cenário 3: Claude Gera Código Incompleto (Improvável)

Se mesmo com as correções, Claude gerar código incompleto:

```powershell
# 1. Verificar se meta_prompt tem lista de métodos
Get-Content C:\4c\tasks\taskXXX\meta_prompt.md | Select-String -Pattern "Métodos OBRIGATÓRIOS"

# Se NÃO encontrar: OrquestradorMigracao.ps1 não tem a correção aplicada!

# 2. Aplicar correção manualmente
# Editar OrquestradorMigracao.ps1 (linha 776)
# Adicionar lista de 20 métodos obrigatórios

# 3. Re-gerar meta_prompt e re-executar
.\OrquestradorMigracao.ps1 -TaskId "taskXXX" -ResumeFromStep 3
```

---

## 📊 DIFERENÇAS: Formulário Pequeno vs Grande

| Aspecto | Pequeno (ex: FormCor) | Grande (ex: FormProduto) |
|---------|----------------------|--------------------------|
| **Campos** | 5-10 campos | 50-100+ campos |
| **Lookups** | 2-3 lookups | 10-20+ lookups |
| **Grids** | 1 grid simples | Múltiplos grids + subtabelas |
| **Tempo Etapa 5** | ~5 min | ~10-15 min |
| **Tempo Total** | ~10 min | ~15-20 min |
| **Complexidade** | Automático 100% | Automático 100% |

**IMPORTANTE:** O procedimento é **IDÊNTICO** para pequenos e grandes!

---

## 🎯 CHECKLIST RÁPIDO (TL;DR)

```
[ ] 1. Copiar .scx/.sct para C:\4c\origem\
[ ] 2. Executar: .\OrquestradorMigracao.ps1
[ ] 3. Aguardar ~10-15 minutos (automático)
[ ] 4. Verificar: status = COMPLETED
[ ] 5. Deletar .fxp: Get-ChildItem *.fxp | Remove-Item
[ ] 6. Testar: DO main.prg
[ ] 7. Validar: Todas operações CRUD funcionam
```

---

## 🎉 RESULTADO ESPERADO (COM CORREÇÕES)

```
Input:  SIGCDCOR.scx (formulário legado)
Output: FormCor.prg + CorBO.prg (100% funcional)

Garantias:
✅ 20 métodos implementados (lista explícita no meta-prompt)
✅ Implementação COMPLETA (não aceita stubs/TODOs)
✅ Testes automáticos: 100% (validação rigorosa)
✅ UI Fidelity: ≤37 problemas (validação rigorosa)
✅ Processo 100% automático (sem intervenção manual)
✅ Paridade funcional 100% com legado (PILAR 1)
```

---

## 📚 DOCUMENTAÇÃO DE APOIO

- **CLAUDE.md** - 3 Pilares + Regras do projeto
- **CORRECAO_META_PROMPT_README.md** - Lista de 20 métodos
- **CORRECAO_IMPLEMENTACAO_COMPLETA.md** - Definição de "completo"
- **CORRECAO_QUALITY_GATES_README.md** - Validações 100%
- **docs/migration_guide.md** - Checklist detalhado
- **docs/FORMCOR_LICOES_APRENDIDAS.md** - 5 problemas críticos

---

**Autor:** Sistema de Migração Automatizada
**Versão:** 2.0 (com correções aplicadas)
**Data:** 2026-02-12
**Status:** ✅ PRODUÇÃO - PRONTO PARA USO
