# 🤖 Processamento Automático de Formulários - GUIA COMPLETO

## 🎯 **VISÃO GERAL**

Este sistema permite que o **cliente execute UM ÚNICO COMANDO** e toda a complexidade da migração seja encapsulada automaticamente, **INCLUINDO formulários complexos que requerem múltiplas rodadas**.

---

## 🚀 **USO SIMPLES (Interface do Cliente)**

### **Comando Único**

```powershell
cd C:\4c\automation
.\ProcessarFormulario.ps1 -Arquivo "sigmvcab.scx"
```

**O que acontece automaticamente**:

1. ✅ **Analisa complexidade** (tamanho, campos, lookups, procedures)
2. ✅ **Decide estratégia**:
   - **SIMPLES** → 1 rodada (OrquestradorMigracao.ps1)
   - **COMPLEXO** → N rodadas (OrquestradorComplexo.ps1)
3. ✅ **Executa TODAS as rodadas necessárias**
4. ✅ **Valida incrementalmente**
5. ✅ **Gera resultado final 100% completo**

**O cliente NÃO precisa saber**:
- ❌ Quantas rodadas serão necessárias
- ❌ Quais fases serão executadas
- ❌ Como dividir o trabalho
- ❌ Como invocar Claude CLI

**Tudo é automático!** 🎉

---

## 📊 **COMO FUNCIONA INTERNAMENTE**

### **Fluxo de Decisão Automática**

```
┌──────────────────────────────────────────────────┐
│ ProcessarFormulario.ps1 (INTERFACE DO CLIENTE)  │
└──────────────────────────────────────────────────┘
                      ↓
        ┌─────────────────────────────┐
        │ 1. Analisa Complexidade     │
        │    - Tamanho arquivo        │
        │    - Número de campos       │
        │    - Lookups                │
        │    - Procedures             │
        └─────────────────────────────┘
                      ↓
        ┌─────────────────────────────┐
        │ 2. Classifica               │
        │    SIMPLES / MÉDIO / COMPLEXO│
        └─────────────────────────────┘
                      ↓
        ┌─────────────┴─────────────┐
        ▼                           ▼
┌────────────────┐         ┌─────────────────────┐
│ SIMPLES/MÉDIO  │         │ COMPLEXO            │
│ (80% casos)    │         │ (20% casos)         │
└────────────────┘         └─────────────────────┘
        ↓                           ↓
┌────────────────┐         ┌─────────────────────┐
│ Orquestrador   │         │ OrquestradorComplexo│
│ Migração       │         │ (Multi-Fase)        │
│ (1 RODADA)     │         │ (N RODADAS)         │
└────────────────┘         └─────────────────────┘
        ↓                           ↓
        ├───────────────────────────┤
                      ↓
        ┌─────────────────────────────┐
        │ 3. Resultado Final          │
        │    - Task completa          │
        │    - Código migrado 100%    │
        │    - Validação OK           │
        └─────────────────────────────┘
```

---

## 🔧 **COMPONENTES DO SISTEMA**

### **1. ProcessarFormulario.ps1** (Interface do Cliente)
**Responsabilidade**: Ponto de entrada único, análise e roteamento

**O que faz**:
- Localiza arquivo SCX/SCT
- Analisa complexidade automaticamente
- Decide qual orquestrador usar
- Executa orquestrador apropriado
- Exibe resultado final

**Não faz**:
- Não migra código (delega para orquestradores)

### **2. OrquestradorMigracao.ps1** (Formulários Simples)
**Responsabilidade**: Processamento único para formulários padrão

**Quando usado**: Formulários até 500KB, < 30 campos, < 5 lookups

**Fases** (1 rodada):
1. Mover arquivos
2. Extrair código
3. Gerar meta-prompt
4. Gerar mapeamento
5. **Invocar Claude CLI (1x)** → Gera tudo de uma vez
6. Testar formulário
7. Validar UI
8. Gerar solicitação teste manual

### **3. OrquestradorComplexo.ps1** (Formulários Complexos)
**Responsabilidade**: Processamento multi-fase com N rodadas

**Quando usado**: Formulários > 500KB, > 30 campos, lógica complexa

**Fases** (N rodadas - exemplo 10 rodadas):
1. **Rodada 1**: Inventário
2. **Rodada 2**: Business Object
3. **Rodada 3**: Estrutura Visual
4. **Rodadas 4-6**: Campos (dividido em grupos de 20)
5. **Rodada 7**: Lookups
6. **Rodada 8**: Grids
7. **Rodada 9**: Sincronização (FormParaBO/BOParaForm)
8. **Rodadas 10-13**: Lógica de Negócio (dividido em grupos de 50 procedures)
9. **Rodada 14**: Validação Final

**Cada rodada**:
- Gera prompt específico (usando templates)
- Invoca Claude CLI
- Valida resultado
- Acumula no arquivo final
- Salva estado (permite continuar se falhar)

---

## 📋 **CRITÉRIOS DE CLASSIFICAÇÃO AUTOMÁTICA**

| Métrica | SIMPLES | MÉDIO | COMPLEXO |
|---------|---------|-------|----------|
| **Tamanho** | < 500KB | 500KB-1MB | > 1MB |
| **Campos** | < 30 | 30-60 | > 60 |
| **Lookups** | < 5 | 5-10 | > 10 |
| **Procedures** | < 50 | 50-150 | > 150 |
| **Grids** | 0-1 | 1-2 | > 2 |

**Pontuação** (acumula pontos):
- +2 pontos: Tamanho > limite
- +2 pontos: Campos > limite
- +1 ponto: Lookups > limite
- +2 pontos: Procedures > limite
- +1 ponto: Grids > limite

**Classificação**:
- 0-1 pontos: **SIMPLES** → OrquestradorMigracao.ps1
- 2-3 pontos: **MÉDIO** → OrquestradorMigracao.ps1 (com atenção)
- 4+ pontos: **COMPLEXO** → OrquestradorComplexo.ps1

---

## 🎬 **EXEMPLOS DE USO**

### **Exemplo 1: Formulário Simples (FormCor)**

```powershell
.\ProcessarFormulario.ps1 -Arquivo "SIGCDCOR.scx"
```

**Output**:
```
============================================================================
 ANÁLISE DE COMPLEXIDADE
============================================================================

[INFO] Analisando complexidade do formulário...
  - Tamanho: 180.5 KB
  - Campos (TextBoxes): 15
  - Lookups estimados: 2
  - Grids: 0
  - Procedures: 25
  - CommandButtons: 8

  CLASSIFICAÇÃO: SIMPLES
  Estratégia: Processamento único (OrquestradorMigracao.ps1)

============================================================================
 INICIANDO MIGRAÇÃO - ESTRATÉGIA: SIMPLES
============================================================================

[INFO] Executando OrquestradorMigracao.ps1 (1 rodada)...

[Etapas 1-8 executam automaticamente...]

============================================================================
 MIGRAÇÃO CONCLUÍDA COM SUCESSO!
============================================================================
```

**Tempo**: ~5-10 minutos

---

### **Exemplo 2: Formulário Complexo (sigmvcab)**

```powershell
.\ProcessarFormulario.ps1 -Arquivo "sigmvcab.scx"
```

**Output**:
```
============================================================================
 ANÁLISE DE COMPLEXIDADE
============================================================================

[INFO] Analisando complexidade do formulário...
  - Tamanho: 2034.7 KB
  - Campos (TextBoxes): 109
  - Lookups estimados: 14
  - Grids: 2
  - Procedures: 423
  - CommandButtons: 35

  CLASSIFICAÇÃO: COMPLEXO
  Estratégia: Processamento multi-fase (OrquestradorComplexo.ps1)

============================================================================
 INICIANDO MIGRAÇÃO - ESTRATÉGIA: COMPLEXO
============================================================================

[INFO] Executando OrquestradorComplexo.ps1 (múltiplas rodadas)...

Migração complexa planejada: 14 fases

============================================================================
 FASE 1 de 14: 00_Inventario
============================================================================

[INFO] Extraindo código fonte...
[INFO] Gerando inventário JSON...
[FASE 1] Concluída com sucesso em 2.3 min

============================================================================
 FASE 2 de 14: 01_BusinessObject
============================================================================

[INFO] Gerando prompt para criação do BO...
[INFO] Invocando Claude CLI para gerar BO...
[FASE 2] Concluída com sucesso em 5.1 min

============================================================================
 FASE 3 de 14: 02_EstruturaVisual
============================================================================

[INFO] Gerando prompt para estrutura visual...
[FASE 3] Concluída com sucesso em 4.2 min

... [Fases 4-13 executam automaticamente] ...

============================================================================
 FASE 14 de 14: 08_ValidacaoFinal
============================================================================

[INFO] Executando ValidarUIFidelity...
[INFO] Executando testes funcionais...
[FASE 14] Concluída com sucesso em 3.5 min

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

Próximos passos:
  1. Revisar código gerado
  2. Testar manualmente (INCLUIR, ALTERAR, VISUALIZAR, EXCLUIR)
  3. Validar cálculos e lógica de negócio
  4. Commit se tudo OK
```

**Tempo**: ~1.5 horas (automático, sem intervenção)

---

## 🛠️ **CONFIGURAÇÃO AVANÇADA**

### **Forçar Processamento Complexo**

```powershell
# Forçar multi-fase mesmo se formulário for classificado como simples
.\ProcessarFormulario.ps1 -Arquivo "FormProduto.scx" -ForcarComplexo
```

### **Dry-Run (Apenas Análise)**

```powershell
# Apenas analisa, não processa
.\ProcessarFormulario.ps1 -Arquivo "FormXXX.scx" -DryRun
```

**Output**:
```
============================================================================
 MODO DRY-RUN - APENAS ANÁLISE
============================================================================

Análise completa. Nenhuma migração executada.

Para executar migração, remova o parâmetro -DryRun:
  .\ProcessarFormulario.ps1 -Arquivo "FormXXX.scx"
```

---

## ⚙️ **PERSONALIZAÇÃO**

### **Ajustar Limites de Classificação**

Editar `ProcessarFormulario.ps1`:

```powershell
$config = @{
    Limites = @{
        TamanhoMax_KB = 500      # Padrão: 500KB
        CamposMax = 30           # Padrão: 30
        LookupsMax = 5           # Padrão: 5
        ProceduresMax = 50       # Padrão: 50
        GridsMax = 1             # Padrão: 1
    }
}
```

### **Criar Templates de Prompt Customizados**

Pasta: `C:\4c\automation\templates_prompts\`

Criar arquivo: `XX_NomeFase.md` com placeholders `{{VariavelSubstituir}}`

---

## 📊 **MONITORAMENTO DE PROGRESSO**

### **Verificar Estado de Migração Complexa**

```powershell
cd C:\4c\tasks\task012
cat estado_migracao_complexa.json
```

**Output**:
```json
{
  "TaskId": "task012",
  "FaseAtual": 7,
  "TotalFases": 14,
  "Fases": [
    { "Nome": "00_Inventario", "Status": "COMPLETED", "Duracao": 138 },
    { "Nome": "01_BusinessObject", "Status": "COMPLETED", "Duracao": 306 },
    ...
    { "Nome": "04_Lookups", "Status": "FAILED", "Erro": "Claude CLI timeout" }
  ]
}
```

### **Continuar Migração Após Falha**

```powershell
# O OrquestradorComplexo.ps1 detecta automaticamente estado salvo
# e continua da última fase que falhou

cd C:\4c\automation
.\ProcessarFormulario.ps1 -Arquivo "sigmvcab.scx"

# Output: "Estado anterior encontrado. Continuando da FASE 8..."
```

---

## ✅ **VANTAGENS DO SISTEMA**

| Vantagem | Descrição |
|----------|-----------|
| **1 Comando** | Cliente executa apenas `.\ProcessarFormulario.ps1` |
| **Automático** | Detecta complexidade e escolhe estratégia |
| **Resiliente** | Salva estado, permite continuar após falha |
| **Transparente** | Cliente não precisa saber quantas rodadas |
| **Completo** | Garante paridade funcional 100% |
| **Validado** | Validação incremental em cada fase |
| **Escalável** | Suporta de 15 campos a 500+ campos |

---

## 🎯 **GARANTIAS**

✅ **Paridade Funcional 100%** - TODOS os campos, lookups, grids, procedures

✅ **Automação Total** - Cliente NÃO precisa dividir manualmente

✅ **Validação Incremental** - Cada fase validada antes de prosseguir

✅ **Recuperação de Falhas** - Continua de onde parou

✅ **Transparência** - Logs detalhados de cada etapa

---

## 📞 **SUPORTE**

### **Problema: Fase falhou**
Verificar log: `C:\4c\tasks\taskXXX\logs\XX_nomeFase.log`

Opções:
- `[R]etry`: Tentar novamente
- `[C]ontinue`: Pular fase (não recomendado)
- `[A]bort`: Abortar migração

### **Problema: Claude CLI timeout**
Aumentar timeout em `config.json`:
```json
{
  "claude": {
    "timeout": 600000  // 10 minutos
  }
}
```

---

## 🚀 **RESUMO EXECUTIVO**

> **"Quero que o cliente execute 1 script e tudo aconteça automaticamente, mesmo com 10 rodadas"**

✅ **IMPLEMENTADO!**

```powershell
# Cliente executa APENAS ISTO:
.\ProcessarFormulario.ps1 -Arquivo "qualquerForm.scx"

# Sistema automaticamente:
# - Analisa complexidade
# - Decide estratégia (1 rodada vs N rodadas)
# - Executa TODAS as rodadas necessárias
# - Valida incrementalmente
# - Gera resultado 100% completo
```

**Complexidade totalmente encapsulada!** 🎉

---

**Última atualização**: 2026-02-12
**Versão**: 1.0
