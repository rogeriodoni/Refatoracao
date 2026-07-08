# Arquitetura do Sistema de Migração Automatizada

**Versão:** 1.0
**Data:** 2026-01-22

---

## 🏗️ Visão Geral

Sistema automatizado para migração de formulários Visual FoxPro 9 do sistema legado para arquitetura em camadas moderna, com validação multi-nível e rastreabilidade completa.

```
┌─────────────────────────────────────────────────────────────────┐
│                  SISTEMA DE MIGRAÇÃO AUTOMATIZADA                │
│                                                                   │
│  Entrada: Arquivos .SCX/.SCT (legado)                           │
│  Saída: FormXXX.prg + XXXBO.prg (novo sistema)                  │
│  Qualidade: Validação UI + Testes + Métricas                    │
└─────────────────────────────────────────────────────────────────┘
```

---

## 📐 Arquitetura em Camadas

```
┌──────────────────────────────────────────────────────────────────┐
│                    CAMADA DE ORQUESTRAÇÃO                         │
│                  (PowerShell + JSON State)                        │
├──────────────────────────────────────────────────────────────────┤
│  OrquestradorMigracao.ps1                                        │
│  ├─ Controle de fluxo                                            │
│  ├─ Gestão de estado (task_state.json)                           │
│  ├─ Retry logic                                                  │
│  └─ Logging estruturado                                          │
└──────────────────────────────────────────────────────────────────┘
                                ↓
┌──────────────────────────────────────────────────────────────────┐
│                    CAMADA DE EXECUÇÃO                             │
│            (Wrappers PowerShell para VFP/Claude)                  │
├──────────────────────────────────────────────────────────────────┤
│  VFPExecutor.ps1              ClaudeInvoker.ps1                  │
│  ├─ Executa scripts VFP       ├─ Invoca Claude CLI               │
│  ├─ Substitui variáveis       ├─ Gerencia prompts                │
│  └─ Captura exit codes        └─ Captura outputs                 │
└──────────────────────────────────────────────────────────────────┘
                                ↓
┌──────────────────────────────────────────────────────────────────┐
│                   CAMADA DE PROCESSAMENTO                         │
│              (Scripts VFP + IA Generativa)                        │
├──────────────────────────────────────────────────────────────────┤
│  ExtractSCXCode.prg          GeradorMapeamento.prg               │
│  TestFormWrapper.prg         ValidarUIFidelity.prg               │
│  Claude CLI (Anthropic API)                                      │
└──────────────────────────────────────────────────────────────────┘
                                ↓
┌──────────────────────────────────────────────────────────────────┐
│                    CAMADA DE DADOS                                │
│                (Arquivos JSON, TXT, Logs)                         │
├──────────────────────────────────────────────────────────────────┤
│  task_state.json             Logs estruturados                   │
│  mapeamento.json             Relatórios HTML                     │
│  validacao_ui_report.json    Código gerado (.prg)                │
└──────────────────────────────────────────────────────────────────┘
```

---

## 🔄 Fluxo de Execução Completo

```
                        ┌─────────────────────┐
                        │   OrquestradorMain  │
                        │   (PowerShell)      │
                        └──────────┬──────────┘
                                   │
                                   ▼
  ┌────────────────────────────────────────────────────────────────┐
  │ ETAPA 1: Mover Arquivos                                        │
  ├────────────────────────────────────────────────────────────────┤
  │ • Busca próximo arquivo em C:\4c\origem\                       │
  │ • Cria diretório C:\4c\tasks\taskXXX\                          │
  │ • Move par SCX/SCT para task                                   │
  │ • Atualiza task_state.json                                     │
  └────────────────────┬───────────────────────────────────────────┘
                       │
                       ▼
  ┌────────────────────────────────────────────────────────────────┐
  │ ETAPA 2: Extrair Código Fonte                                  │
  ├────────────────────────────────────────────────────────────────┤
  │ • VFPExecutor.ps1 invoca ExtractSCXCode.prg                    │
  │ • Gera BASENAME_codigo_fonte.txt                               │
  │ • Salva em C:\4c\tasks\taskXXX\                                │
  │ • Log: 02_extractCode.log                                      │
  └────────────────────┬───────────────────────────────────────────┘
                       │
                       ▼
  ┌────────────────────────────────────────────────────────────────┐
  │ ETAPA 3: Gerar Meta-Prompt                                     │
  ├────────────────────────────────────────────────────────────────┤
  │ • Carrega GERADOR_PROMPT_MIGRACAO.md                           │
  │ • Substitui {BASENAME}, {TXTFILE}                              │
  │ • Salva meta_prompt.md                                         │
  │ • Log: 03_gerarMetaPrompt.log                                  │
  └────────────────────┬───────────────────────────────────────────┘
                       │
                       ▼
  ┌────────────────────────────────────────────────────────────────┐
  │ ETAPA 4: Gerar Mapeamento                                      │
  ├────────────────────────────────────────────────────────────────┤
  │ • VFPExecutor.ps1 invoca GeradorMapeamento.prg                │
  │ • Analisa objetos originais vs novos                           │
  │ • Gera mapeamento.json                                         │
  │ • Log: 04_gerarMapeamento.log                                  │
  └────────────────────┬───────────────────────────────────────────┘
                       │
                       ▼
  ┌────────────────────────────────────────────────────────────────┐
  │ ETAPA 5: Executar Migração (IA)                                │
  ├────────────────────────────────────────────────────────────────┤
  │ • ClaudeInvoker.ps1 chama Claude CLI                           │
  │ • Claude lê meta_prompt.md                                     │
  │ • Claude gera FormXXX.prg + XXXBO.prg                          │
  │ • Salva em C:\4c\projeto\app\                                  │
  │ • Log: 05_migracao.log                                         │
  │                                                                 │
  │ [DECISÃO: Se erro, retry até maxTentativas]                    │
  │   ↳ Usuario escolhe: [R]etry, [C]ontinue, [A]bort             │
  └────────────────────┬───────────────────────────────────────────┘
                       │
                       ▼
  ┌────────────────────────────────────────────────────────────────┐
  │ ETAPA 6: Testar Formulário                                     │
  ├────────────────────────────────────────────────────────────────┤
  │ • VFPExecutor.ps1 invoca TestFormWrapper.prg                   │
  │ • Testa:                                                        │
  │   ✓ CREATEOBJECT(FormXXX)                                      │
  │   ✓ .Show()                                                    │
  │   ✓ Cliques em botões CRUD                                     │
  │ • Exit Code: 0=OK, 1=ErroCreate, 2=ErroShow, 3=ErroBotoes     │
  │ • Log: 06_testForm.log                                         │
  │                                                                 │
  │ [DECISÃO: Se erro, retry até maxTentativas]                    │
  │   ↳ Usuario escolhe: [R]etry, [C]ontinue, [A]bort             │
  └────────────────────┬───────────────────────────────────────────┘
                       │
                       ▼
  ┌────────────────────────────────────────────────────────────────┐
  │ ETAPA 7: Validar UI Fidelity                                   │
  ├────────────────────────────────────────────────────────────────┤
  │ • VFPExecutor.ps1 invoca ValidarUIFidelity.prg                │
  │ • Compara 18 propriedades visuais:                             │
  │   - Width, Height, Top, Left                                   │
  │   - BackColor, ForeColor                                       │
  │   - FontName, FontSize                                         │
  │   - Caption, InputMask, etc                                    │
  │ • Usa mapeamento.json para renomeados                          │
  │ • Gera:                                                         │
  │   - validacao_ui_report.html (visual)                          │
  │   - validacao_ui_report.json (estruturado)                     │
  │ • Log: 07_validarUI.log                                        │
  │                                                                 │
  │ [DECISÃO: Se total > maxProblemas, retry]                      │
  │   ↳ Usuario escolhe: [R]etry, [C]ontinue, [A]bort             │
  └────────────────────┬───────────────────────────────────────────┘
                       │
                       ▼
  ┌────────────────────────────────────────────────────────────────┐
  │ ETAPA 8: Gerar Solicitação de Teste Manual                     │
  ├────────────────────────────────────────────────────────────────┤
  │ • Gera markdown em C:\4c\SolicitacaoTesteManual\               │
  │ • Inclui:                                                       │
  │   - Checklist de testes funcionais                             │
  │   - Métricas de validação UI                                   │
  │   - Links para relatórios                                      │
  │   - Campos para aprovação/reprovação                           │
  │ • Log: 08_gerarTestManual.log                                  │
  └────────────────────┬───────────────────────────────────────────┘
                       │
                       ▼
  ┌────────────────────────────────────────────────────────────────┐
  │ TASK COMPLETA                                                   │
  ├────────────────────────────────────────────────────────────────┤
  │ • task_state.json → status = COMPLETED                         │
  │ • Métricas registradas (tempo, tentativas)                     │
  │ • Código gerado em C:\4c\projeto\app\                          │
  │ • Teste manual aguardando aprovação humana                     │
  └────────────────────────────────────────────────────────────────┘
```

---

## 🔌 Componentes e Responsabilidades

### Orquestrador Principal

| Componente | Arquivo | Responsabilidade |
|------------|---------|------------------|
| **Orquestrador** | `OrquestradorMigracao.ps1` | Coordena todas etapas, gerencia estado, retry logic |
| **Task Manager** | `TaskManager.ps1` | CRUD de tasks, persistência de estado JSON |
| **Config** | `config.json` | Configurações globais (paths, limites, timeouts) |

### Wrappers de Execução

| Componente | Arquivo | Responsabilidade |
|------------|---------|------------------|
| **VFP Executor** | `VFPExecutor.ps1` | Executa scripts VFP com config.fpw customizado |
| **Claude Invoker** | `ClaudeInvoker.ps1` | Invoca Claude CLI, gerencia prompts/outputs |

### Scripts VFP

| Componente | Arquivo | Responsabilidade |
|------------|---------|------------------|
| **Extrator de Código** | `ExtractSCXCode.prg` | Extrai código fonte de SCX para TXT |
| **Gerador de Mapeamento** | `GeradorMapeamento.prg` | Mapeia objetos originais → novos (JSON) |
| **Test Wrapper** | `TestFormWrapper.prg` | Testa formulário (criar, mostrar, botões) |
| **Validador UI** | `ValidarUIFidelity.prg` | Compara propriedades visuais original vs migrado |

### Arquivos de Configuração

| Tipo | Arquivo | Propósito |
|------|---------|-----------|
| **Config Global** | `config.json` | Paths, limites, timeouts, retry logic |
| **Config VFP** | `configs/*.fpw` | Templates de config.fpw para cada etapa |
| **Mapeamento Classes** | `class_mapping.json` | Mapeia BASENAME → FormClass, BOClass |
| **State** | `task_state.json` | Estado de execução de cada task |

---

## 📊 Modelo de Dados

### task_state.json (Estrutura)

```json
{
  "taskId": "task001",
  "arquivoOriginal": "SIGCDCOR",
  "tipoArquivo": "SCX",
  "status": "PENDING | IN_PROGRESS | COMPLETED | FAILED",
  "criadoEm": "2026-01-22T10:30:00",
  "atualizadoEm": "2026-01-22T11:45:00",

  "etapas": {
    "01_moverArquivos": {
      "status": "COMPLETED",
      "inicio": "2026-01-22T10:30:00",
      "fim": "2026-01-22T10:30:05",
      "tentativas": 1,
      "erro": null
    },
    "02_extractCode": { ... },
    "05_migracao": {
      "status": "IN_PROGRESS",
      "tentativas": 2,
      "maxTentativas": 3,
      "erro": "Claude CLI timeout"
    },
    "07_validarUI": {
      "problemas": {
        "erros": 0,
        "avisos": 33,
        "diferencas": 0,
        "total": 33
      },
      "limiteProblemas": 10
    }
  },

  "metricas": {
    "tempoTotalSegundos": 1800,
    "tempoExtracao": 15,
    "tempoMigracao": 600,
    "tempoValidacao": 30
  }
}
```

### mapeamento.json (Estrutura)

```json
{
  "versao": "1.0",
  "formularioOriginal": "SIGCDCOR",
  "formularioNovo": "FormCor",
  "mapeamentos": {
    "Pageframe1": "pgf_4c_Principal",
    "Page1": "Page1",
    "Text1": "txt_4c_Codigo",
    "Text2": "txt_4c_Descricao",
    "Command1": "cmd_4c_Incluir",
    "Grid1": "grd_4c_Dados"
  }
}
```

### validacao_ui_report.json (Estrutura)

```json
{
  "versao": "1.0",
  "dataExecucao": "2026-01-22T11:30:00",
  "formularioOriginal": "SIGCDCOR",
  "formularioNovo": "FormCor",
  "resumo": {
    "erros": 0,
    "avisos": 33,
    "diferencas": 0,
    "total": 33
  },
  "problemas": [
    {
      "tipo": "AVISO",
      "objeto": "cmd_4c_Incluir",
      "propriedade": "Picture",
      "esperado": "..\\vbmp\\incluir.jpg",
      "encontrado": "Propriedade nao existe"
    }
  ]
}
```

---

## 🛠️ Tecnologias Utilizadas

| Tecnologia | Versão | Uso |
|------------|--------|-----|
| **PowerShell** | 5.1+ | Orquestração, automação |
| **Visual FoxPro** | 9.0 | Processamento de SCX, validação |
| **Claude CLI** | Latest | Geração de código via IA |
| **JSON** | - | Persistência de estado |
| **Markdown** | - | Documentação, prompts |

---

## 🔒 Segurança e Resiliência

### Tratamento de Erros

```
┌─────────────────────────────────────────────────┐
│ CADA ETAPA TEM:                                 │
├─────────────────────────────────────────────────┤
│ • TRY/CATCH com logging estruturado             │
│ • Retry logic com limite (maxTentativas)        │
│ • Persistência de estado antes/depois           │
│ • Exit codes significativos (0=OK, N=Erro)      │
│ • Logs detalhados em arquivos separados         │
└─────────────────────────────────────────────────┘
```

### Pontos de Decisão

Quando uma etapa falha, o usuário escolhe:
- **[R]etry**: Corrigir manualmente e tentar novamente
- **[C]ontinue**: Marcar como sucesso e continuar (se corrigiu externamente)
- **[A]bort**: Abortar task completamente

### Rollback

Cada task é isolada em seu diretório. Se falhar:
- ❌ Não afeta outras tasks
- ❌ Não polui código do projeto
- ✅ Pode ser descartada e reprocessada

---

## 📈 Métricas e KPIs

### Métricas por Task

- **Tempo total**: Início até conclusão
- **Tempo por etapa**: Identificar gargalos
- **Tentativas por etapa**: Medir qualidade do processo
- **Problemas UI**: Erros, avisos, diferenças
- **Linhas de código**: Original vs gerado

### Métricas Agregadas

- **Taxa de sucesso**: % tasks completadas sem intervenção
- **Tempo médio**: Tempo médio por formulário
- **Custo médio**: Custo de API por formulário
- **Gargalos**: Etapas que mais falham

---

## 🎯 Garantias de Qualidade

### Validação Automática

1. **Sintaxe**: TestFormWrapper detecta erros ao criar objeto
2. **Runtime**: TestFormWrapper detecta erros ao mostrar/clicar
3. **Visual**: ValidarUIFidelity compara 18 propriedades
4. **Funcional**: (Futuro) Testes de fluxo INCLUIR/ALTERAR/EXCLUIR

### Validação Manual

1. **Teste humano**: Solicitação de teste manual gerada
2. **Code review**: Revisar FormXXX.prg e XXXBO.prg
3. **Teste integração**: Verificar com banco real

### Rastreabilidade

- Todos os logs persistidos
- Estado de cada task registrado
- Métricas de tempo/tentativas
- Código gerado versionável (Git)

---

## 🚀 Escalabilidade

### Capacidade Atual (v1.0)

- **Throughput**: 1 task por vez (sequencial)
- **Tempo por task**: 30-60 minutos (estimado)
- **100 formulários**: ~50-100 horas (2-4 dias corridos)

### Plano de Escalabilidade (v2.0)

```
┌──────────────────────────────────────────────────┐
│ PARALELIZAÇÃO                                    │
├──────────────────────────────────────────────────┤
│ • Job Queue (fila de trabalho)                   │
│ • Múltiplas instâncias VFP (3-5 simultâneas)     │
│ • Rate limiting de Claude API                    │
│ • Distribuição por máquina (opcional)            │
│                                                   │
│ Ganho: 2-3x mais rápido                          │
│ 100 formulários: ~1-2 dias                       │
└──────────────────────────────────────────────────┘
```

---

## 📚 Referências

### Documentação Relacionada

- **README.md**: Guia rápido de uso
- **ANALISE_CRITICA_PROCESSO.md**: Análise detalhada, riscos, melhorias
- **C:\4c\CLAUDE.md**: Instruções gerais do projeto
- **C:\4c\docs\***: Documentação técnica completa

### Código-Fonte

- **OrquestradorMigracao.ps1**: Script principal (~700 linhas)
- **TaskManager.ps1**: Gerenciamento de estado (~150 linhas)
- **VFPExecutor.ps1**: Wrapper VFP (~150 linhas)
- **ClaudeInvoker.ps1**: Wrapper Claude (~100 linhas)
- **TestFormWrapper.prg**: Teste de formulários (~300 linhas)

---

## 🏁 Conclusão

Sistema robusto, modular e rastreável para automação de migração de formulários VFP.

**Pontos Fortes:**
- ✅ Validação multi-nível
- ✅ Retry logic inteligente
- ✅ Estado persistido
- ✅ Logs estruturados
- ✅ Rastreabilidade completa

**Limitações Atuais:**
- ⚠️ Sequencial (1 task por vez)
- ⚠️ Teste de formulário limitado
- ⚠️ Critério de UI pode ser mais assertivo

**Recomendação:**
✅ **PRONTO para testes em ambiente controlado (Alpha)**
⚠️ **Implementar melhorias de PRIORIDADE ALTA antes de produção**

---

**Arquitetura projetada por:** Sistema de Automação de Migração
**Última atualização:** 2026-01-22
**Versão do documento:** 1.0
