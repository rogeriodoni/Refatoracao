# 🚀 QUICK START - Processamento Automático

## ✅ **SIM, É POSSÍVEL!**

O cliente executa **1 COMANDO** e toda a complexidade é encapsulada, **INCLUINDO as 10+ rodadas automáticas** para formulários complexos.

---

## 📝 **USO BÁSICO**

### **1. Preparar Arquivo**
```powershell
# Colocar arquivos SCX/SCT em:
C:\4c\origem\sigmvcab.scx
C:\4c\origem\sigmvcab.sct
```

### **2. Executar Script Único**
```powershell
cd C:\4c\automation
.\ProcessarFormulario.ps1 -Arquivo "sigmvcab.scx"
```

### **3. Aguardar (Automático)**
- ✅ Sistema detecta que é COMPLEXO
- ✅ Divide em 14 fases automaticamente
- ✅ Executa 14 rodadas do Claude CLI
- ✅ Valida após cada rodada
- ✅ Gera código 100% completo

### **4. Resultado**
```
============================================================================
 MIGRAÇÃO COMPLEXA CONCLUÍDA COM SUCESSO!
============================================================================

Task: task012
Formulário: sigmvcab
Total de fases: 14
Duração total: 87.4 minutos

Arquivos gerados:
  - BO: C:\4c\projeto\app\classes\sigmvcabBO.prg
  - Form: C:\4c\projeto\app\forms\cadastros\Formsigmvcab.prg
```

---

## 🎯 **COMO FUNCIONA**

```
Cliente executa:
   .\ProcessarFormulario.ps1 -Arquivo "sigmvcab.scx"

Sistema automaticamente:
   ├─ [1] Analisa complexidade → COMPLEXO detectado
   ├─ [2] Calcula fases necessárias → 14 fases
   ├─ [3] Executa OrquestradorComplexo.ps1
   │
   └─── OrquestradorComplexo.ps1 executa:
         ├─ FASE 1: Inventário (1 rodada Claude)
         ├─ FASE 2: Business Object (1 rodada Claude)
         ├─ FASE 3: Estrutura Visual (1 rodada Claude)
         ├─ FASES 4-6: Campos grupos A-C (3 rodadas Claude)
         ├─ FASE 7: Lookups (1 rodada Claude)
         ├─ FASE 8: Grids (1 rodada Claude)
         ├─ FASE 9: Sincronização (1 rodada Claude)
         ├─ FASES 10-13: Lógica grupos A-D (4 rodadas Claude)
         └─ FASE 14: Validação Final (1 rodada Claude)

         TOTAL: 14 invocações automáticas do Claude CLI
```

**Cliente NÃO precisa**:
- ❌ Saber quantas rodadas serão
- ❌ Dividir o trabalho manualmente
- ❌ Invocar Claude CLI manualmente
- ❌ Gerenciar estado entre rodadas

**Tudo automático!** 🎉

---

## 📊 **EXEMPLOS COMPARATIVOS**

### **Formulário SIMPLES (FormCor - 15 campos)**

```powershell
.\ProcessarFormulario.ps1 -Arquivo "SIGCDCOR.scx"
```

**Sistema detecta**: SIMPLES
**Estratégia**: 1 rodada única (OrquestradorMigracao.ps1)
**Tempo**: ~5 minutos

---

### **Formulário COMPLEXO (sigmvcab - 109 campos, 423 procedures)**

```powershell
.\ProcessarFormulario.ps1 -Arquivo "sigmvcab.scx"
```

**Sistema detecta**: COMPLEXO
**Estratégia**: 14 rodadas automáticas (OrquestradorComplexo.ps1)
**Tempo**: ~90 minutos (sem intervenção humana)

---

## ⚙️ **OPÇÕES AVANÇADAS**

### **Forçar Processamento Complexo**
```powershell
# Útil se quer garantir divisão em fases
.\ProcessarFormulario.ps1 -Arquivo "FormProduto.scx" -ForcarComplexo
```

### **Apenas Analisar (Dry-Run)**
```powershell
# Ver classificação sem executar migração
.\ProcessarFormulario.ps1 -Arquivo "FormXXX.scx" -DryRun
```

**Output**:
```
  CLASSIFICAÇÃO: COMPLEXO
  Estratégia: Processamento multi-fase (OrquestradorComplexo.ps1)

Análise completa. Nenhuma migração executada.
```

---

## 🔍 **MONITORAMENTO**

### **Ver Progresso em Tempo Real**
```powershell
# Abrir outro terminal enquanto executa:
cd C:\4c\tasks\task012
Get-Content estado_migracao_complexa.json -Wait
```

### **Continuar Após Falha**
```powershell
# Se alguma fase falhou, simplesmente re-executar:
.\ProcessarFormulario.ps1 -Arquivo "sigmvcab.scx"

# Sistema detecta estado salvo e continua de onde parou
```

---

## ✅ **GARANTIAS**

| Garantia | Descrição |
|----------|-----------|
| **1 Comando** | Cliente executa apenas 1 script |
| **Detecção Automática** | Sistema decide estratégia automaticamente |
| **Multi-Fase Transparente** | 10-30 rodadas executam sem intervenção |
| **Paridade 100%** | TODOS os campos/lookups/procedures migrados |
| **Validação Incremental** | Cada fase validada antes de prosseguir |
| **Recuperação Automática** | Continua de onde parou se falhar |

---

## 📂 **ARQUIVOS CRIADOS**

```
C:\4c\automation\
├── ProcessarFormulario.ps1          ← SCRIPT PRINCIPAL (executar este)
├── OrquestradorComplexo.ps1         ← Multi-fase (automático)
├── OrquestradorMigracao.ps1         ← Simples (já existia)
├── templates_prompts\               ← Templates de prompt por fase
│   ├── 01_BusinessObject.md
│   ├── 02_EstruturaVisual.md
│   └── ... (outros templates)
├── PROCESSAMENTO_AUTOMATICO.md      ← Documentação completa
└── QUICK_START_AUTOMATICO.md        ← Este arquivo
```

---

## 🎓 **CONCEITOS-CHAVE**

### **Formulário SIMPLES** (80% dos casos)
- < 500KB, < 30 campos, < 5 lookups
- **1 rodada** do Claude CLI
- Tempo: 5-10 minutos

### **Formulário COMPLEXO** (20% dos casos)
- > 1MB, > 60 campos, > 10 lookups, lógica fiscal/financeira
- **10-30 rodadas** do Claude CLI (automáticas)
- Tempo: 1-3 horas (sem intervenção)

### **Detecção Automática**
Sistema pontua formulário baseado em:
- Tamanho arquivo
- Número de campos
- Número de lookups
- Número de procedures
- Número de grids

**Pontuação ≥ 4**: Classificado como COMPLEXO → Multi-fase automático

---

## 🚀 **COMEÇAR AGORA**

```powershell
# 1. Navegar para pasta de automação
cd C:\4c\automation

# 2. Executar script com seu formulário
.\ProcessarFormulario.ps1 -Arquivo "meuFormulario.scx"

# 3. Aguardar conclusão (automático)
# 4. Revisar resultado em C:\4c\tasks\taskXXX\
```

**É isso! Sistema faz o resto automaticamente.** 🎉

---

## ❓ **FAQ**

### **P: Quanto tempo demora?**
R: Simples = 5-10 min, Complexo = 1-3 horas (automático)

### **P: Preciso ficar monitorando?**
R: Não! Pode deixar executando. Sistema salva estado e continua se falhar.

### **P: E se der erro no meio?**
R: Re-execute o mesmo comando. Sistema continua de onde parou.

### **P: Como saber se foi classificado corretamente?**
R: Use `-DryRun` para ver classificação sem executar.

### **P: Posso forçar multi-fase mesmo se simples?**
R: Sim! Use `-ForcarComplexo`.

---

## 📞 **SUPORTE**

### **Documentação Completa**
`C:\4c\automation\PROCESSAMENTO_AUTOMATICO.md`

### **Metodologia Original**
`C:\4c\docs\METODOLOGIA_ARQUIVOS_GRANDES.md`

### **Logs**
`C:\4c\tasks\taskXXX\logs\`

---

**RESUMO**: Execute `.\ProcessarFormulario.ps1 -Arquivo "xxx.scx"` e aguarde. Sistema faz **TUDO automaticamente**, incluindo as 10+ rodadas para formulários complexos! ✨

---

**Última atualização**: 2026-02-12
**Versão**: 1.0
