# 🤔 Qual Comando Usar?

**Guia rápido de decisão para escolher o comando correto**

---

## 🌳 Árvore de Decisão

```
┌─────────────────────────────────────────────────┐
│ Quantos formulários você quer processar AGORA? │
└─────────────────────────────────────────────────┘
                      │
        ┌─────────────┼─────────────┐
        │             │             │
        ▼             ▼             ▼
     APENAS 1      2-20 COM      TODOS SEM
                   REVISÃO        PAUSA
        │             │             │
        ▼             ▼             ▼
```

---

## 1️⃣ Processar APENAS 1 Formulário

### Quando usar:
- ✅ Primeira vez usando o sistema
- ✅ Testando com formulários novos/complexos
- ✅ Precisa revisar resultado ANTES de continuar
- ✅ Debugging (corrigindo problema em task específica)

### Comando:
```powershell
cd C:\4c\automation
.\OrquestradorMigracao.ps1
```

### O que acontece:
1. Pega 1 arquivo de `C:\4c\origem\`
2. Processa todas as 8 etapas
3. **PARA** e aguarda você revisar
4. Você decide: processar próximo manualmente ou não

### Interação:
- ⚠️ **Pode pedir decisão** se etapa falhar: [R]etry, [C]ontinue, [A]bort
- ✅ Se tudo OK, processa sem parar e finaliza

---

## 2️⃣ Processar LOTE com Revisão Entre Cada

### Quando usar:
- ✅ Já testou 5+ formulários simples com sucesso
- ✅ Quer processar vários, mas revisar entre cada
- ✅ Quer parar a qualquer momento (pressionar 'S')
- ✅ **FASE 2 do workflow recomendado**

### Comando:
```powershell
cd C:\4c\automation

# Processar 10 formulários (pausa entre cada)
.\processar_lote_com_revisao.ps1 -Quantidade 10

# OU processar TODOS até acabar origem (pausa entre cada)
.\processar_lote_com_revisao.ps1
```

### O que acontece:
```
Loop:
  1. Processa 1 formulário
  2. Mostra resumo (status, problemas UI, etc)
  3. **PAUSA**: Pressione ENTER para próximo ou 'S' para SAIR
  4. Repete até atingir quantidade OU acabar arquivos
```

### Interação:
- ⚠️ **Pausa obrigatória** entre cada task
- ⚠️ **Pode pedir decisão** se etapa falhar dentro da task
- ✅ Você controla quando continuar ou parar

---

## 3️⃣ Processar LOTE Totalmente Automático (SEM Pausa)

### Quando usar:
- ⚠️ **APENAS APÓS** processar com sucesso 10+ formulários
- ✅ Taxa de sucesso > 70% nas fases anteriores
- ✅ Confia no processo
- ✅ Quer processar 50+ formulários sem intervenção
- ✅ **FASE 3 do workflow recomendado**

### Comando:
```powershell
cd C:\4c\automation

# Processar até 20 (para se encontrar erro)
.\processar_lote_automatico.ps1 -MaxTasks 20

# Processar TODOS (continua mesmo com erros)
.\processar_lote_automatico.ps1 -IgnoreErrors
```

### O que acontece:
```
Loop contínuo:
  1. Processa 1 formulário
  2. Mostra apenas resumo rápido (✅/❌)
  3. **NÃO PAUSA** - continua automaticamente
  4. Repete até atingir limite OU acabar arquivos
  5. Mostra resumo final + lista de tasks com problemas
```

### Interação:
- ✅ **SEM pausa** - totalmente automático
- ⚠️ Se `-IgnoreErrors` NÃO usado: **PARA no primeiro erro**
- ⚠️ Se `-IgnoreErrors` usado: **Continua mesmo com erros** (marca para revisão depois)
- ❌ **NÃO pede decisão** durante execução (assume defaults ou falha)

---

## 📊 Comparação Rápida

| Característica | Opção 1 (Manual) | Opção 2 (Semi-Auto) | Opção 3 (Automático) |
|----------------|------------------|---------------------|----------------------|
| **Quantidade** | 1 formulário | Múltiplos | Múltiplos |
| **Pausa** | Após task | Entre cada task | Nenhuma |
| **Interação** | Se erro | Sempre + se erro | Nenhuma (ignora erros) |
| **Velocidade** | Lenta | Média | Rápida |
| **Controle** | Total | Alto | Baixo |
| **Risco** | Baixo | Médio | Alto |
| **Quando usar** | Testes | Validação | Produção |

---

## 🎯 Exemplo Prático: 50 Formulários para Migrar

### ❌ **ERRADO** (alto risco):
```powershell
# Nunca testou antes, já usa automático total
.\processar_lote_automatico.ps1 -IgnoreErrors
# Resultado: 50 migrações com qualidade desconhecida!
```

### ✅ **CORRETO** (progressão segura):

#### **Semana 1: Validação (5 formulários simples)**
```powershell
# Manual - 1 por vez
.\OrquestradorMigracao.ps1  # Form 1
# Revisar código, UI, testar
.\OrquestradorMigracao.ps1  # Form 2
# Revisar...
# ... repetir 5 vezes

# Resultado: Identificou problemas? Ajusta config.json
```

#### **Semana 2: Expansão (15 formulários médios)**
```powershell
# Semi-automático com revisão
.\processar_lote_com_revisao.ps1 -Quantidade 15

# Resultado: Taxa de sucesso = 80%? Prossegue!
```

#### **Semana 3: Produção (30 formulários restantes)**
```powershell
# Automático (confia no processo)
.\processar_lote_automatico.ps1 -MaxTasks 30

# Resultado:
#   - 27 sucessos (90%)
#   - 3 falhas (revisar manualmente)
```

---

## 🚦 Semáforo de Decisão

### 🔴 **PARE!** Use Opção 1 (Manual) se:
- É sua primeira vez
- Formulário muito complexo (10+ lookups, grids)
- Taxa de sucesso < 50% nas tentativas anteriores
- Debugging de problema específico

### 🟡 **CUIDADO!** Use Opção 2 (Semi-Auto) se:
- Já testou 5+ com sucesso
- Taxa de sucesso 50-80%
- Quer processar 10-50 formulários
- Não tem certeza se processo está estável

### 🟢 **PROSSIGA!** Use Opção 3 (Automático) se:
- Já processou 10+ com sucesso
- Taxa de sucesso > 80%
- Processo estável (poucas intervenções manuais)
- Quer processar 50+ formulários

---

## 🆘 Comandos de Emergência

### Parar Processamento em Andamento
```powershell
# No semi-automático: Pressione 'S' na pausa
# No automático: Ctrl+C (força parada)
```

### Ver Status de Todas as Tasks
```powershell
Get-ChildItem C:\4c\tasks | ForEach-Object {
    $state = cat "$($_.FullName)\task_state.json" | ConvertFrom-Json
    Write-Host "$($_.Name): $($state.status) - $($state.arquivoOriginal)"
}
```

### Reprocessar Task que Falhou
```powershell
# Corrigir código manualmente, depois:
.\OrquestradorMigracao.ps1 -TaskId "task023"
```

### Limpar Task Quebrada (Recomeçar)
```powershell
# ⚠️ CUIDADO: Apaga task e volta arquivo para origem
Remove-Item C:\4c\tasks\task023 -Recurse -Force
Move-Item C:\4c\tasks\task023\*.scx C:\4c\origem\
Move-Item C:\4c\tasks\task023\*.sct C:\4c\origem\
```

---

## 💡 Dicas Finais

### ✅ Faça:
1. **Comece pequeno** - 1 formulário por vez no início
2. **Valide qualidade** - Revisar primeiras 5-10 migrações manualmente
3. **Ajuste config.json** - Baseado nos problemas encontrados
4. **Progrida gradualmente** - Manual → Semi-Auto → Automático

### ❌ Não Faça:
1. **Processar 100 de uma vez** sem validar antes
2. **Usar `-IgnoreErrors`** sem entender os riscos
3. **Confiar 100% na validação automática** (teste manual é essencial)
4. **Pular fases** - A progressão gradual existe por um motivo

---

## 📞 Ainda em Dúvida?

### Consulte:
- **README.md** → Seção "Workflow Recomendado"
- **INDEX.md** → Índice de toda documentação
- **RESUMO_EXECUTIVO.md** → Visão geral do sistema

### Perguntas Frequentes:

**P: Posso deixar rodando durante a noite?**
R: Sim, se usar `processar_lote_automatico.ps1 -IgnoreErrors`. Revise resultados pela manhã.

**P: E se der erro no meio do lote?**
R: Semi-auto para e pede decisão. Automático continua (se `-IgnoreErrors`) ou para.

**P: Como sei se estou pronto para automação total?**
R: Taxa de sucesso > 70% em lote de 10+ formulários semi-automático.

---

**Última atualização:** 2026-01-22
**Versão:** 1.0
