# 🎓 Treinamento Técnico - Sistema de Migração Automatizada

**Objetivo:** Capacitar equipe técnica para operar o sistema de migração automatizada

**Público:** Desenvolvedores, QA, DevOps
**Duração:** 2-3 horas (hands-on)
**Pré-requisitos:** Conhecimento básico de VFP, PowerShell e linha de comando

---

## 📋 Agenda do Treinamento

| Módulo | Duração | Conteúdo |
|--------|---------|----------|
| **1. Overview e Setup** | 30 min | Arquitetura, instalação, pré-requisitos |
| **2. Primeira Migração** | 45 min | Executar task001 passo a passo (hands-on) |
| **3. Monitoramento e Debug** | 30 min | Logs, task_state.json, troubleshooting |
| **4. Operação em Lote** | 30 min | 3 modos, quando usar cada um |
| **5. Validação e QA** | 30 min | UI Fidelity, teste manual, aprovação |
| **6. Q&A e Prática** | 30 min | Exercícios práticos, dúvidas |

---

## 📚 Módulo 1: Overview e Setup (30 min)

### 1.1 Arquitetura do Sistema (10 min)

```
┌──────────────────────────────────────────────────────────────┐
│                  ORQUESTRADOR (PowerShell)                    │
│                                                               │
│  OrquestradorMigracao.ps1                                    │
│  ├─ TaskManager.ps1      (Estado JSON)                       │
│  ├─ VFPExecutor.ps1      (Wrapper VFP)                       │
│  └─ ClaudeInvoker.ps1    (Wrapper Claude CLI)                │
└──────────────────────────────────────────────────────────────┘
                            ↓
┌────────────────┬─────────────────────┬──────────────────────┐
│  VFP Scripts   │   Claude AI         │   Validação          │
├────────────────┼─────────────────────┼──────────────────────┤
│ ExtractSCXCode │ Meta-prompt         │ TestFormWrapper      │
│ GeradorMap     │ Geração código      │ ValidarUIFidelity    │
└────────────────┴─────────────────────┴──────────────────────┘
                            ↓
┌──────────────────────────────────────────────────────────────┐
│                    OUTPUTS                                    │
│                                                               │
│  FormXXX.prg  |  XXXBO.prg  |  Logs  |  Relatórios HTML     │
└──────────────────────────────────────────────────────────────┘
```

**Conceitos-Chave:**
- **Task:** Unidade de migração (1 formulário = 1 task)
- **Etapa:** Uma das 8 etapas do processo
- **Estado:** Persistido em `task_state.json`
- **Rastreabilidade:** Logs detalhados de cada etapa

---

### 1.2 Estrutura de Diretórios (10 min)

```
C:\4c\
├── origem\                   # ⚠️ Colocar arquivos SCX/SCT aqui
│
├── tasks\                    # ✅ Tasks geradas automaticamente
│   └── task001\
│       ├── SIGCDCOR.scx/sct          # Arquivos originais
│       ├── SIGCDCOR_codigo_fonte.txt # Código extraído
│       ├── meta_prompt.md            # Prompt para Claude
│       ├── mapeamento.json           # Mapeamento de objetos
│       ├── validacao_ui_report.html  # Relatório UI
│       ├── task_state.json           # Estado da execução
│       └── logs\                     # Logs por etapa
│           ├── 01_moverArquivos.log
│           ├── 02_extractCode.log
│           ├── ...
│           └── 08_gerarTestManual.log
│
├── automation\               # 🤖 Scripts de automação
│   ├── OrquestradorMigracao.ps1
│   ├── TaskManager.ps1
│   ├── config.json                   # ⚙️ Configuração global
│   ├── class_mapping.json            # Mapeamento de classes
│   └── ...
│
├── projeto\app\              # 📦 Código do novo sistema
│   ├── forms\cadastros\      # FormXXX.prg (gerados aqui)
│   ├── classes\              # XXXBO.prg (gerados aqui)
│   └── utils\                # Scripts VFP utilitários
│
└── SolicitacaoTesteManual\   # 📝 Testes manuais (gerados)
```

---

### 1.3 Verificação de Pré-Requisitos (10 min)

#### ✅ Checklist de Instalação

```powershell
# 1. Visual FoxPro 9
Test-Path "C:\Program Files (x86)\Microsoft Visual FoxPro 9\VFP9.EXE"
# Deve retornar: True

# 2. PowerShell 5.1+
$PSVersionTable.PSVersion
# Deve retornar: 5.1 ou superior

# 3. Claude CLI
claude --version
# Deve retornar: versão do Claude CLI

# 4. Estrutura de diretórios
Test-Path "C:\4c\origem"
Test-Path "C:\4c\tasks"
Test-Path "C:\4c\automation\config.json"
# Todos devem retornar: True

# 5. Conexão SQL Server
ping 192.168.15.101
# Deve responder
```

#### ⚙️ Ajustar config.json

```json
{
  "paths": {
    "origem": "C:\\4c\\origem",
    "tasks": "C:\\4c\\tasks",
    "vfp9": "C:\\Program Files (x86)\\Microsoft Visual FoxPro 9"
  },
  "validacao": {
    "maxProblemas": 10
  },
  "retry": {
    "maxTentativasMigracao": 3
  }
}
```

---

## 🎯 Módulo 2: Primeira Migração (45 min)

### 2.1 Preparar Arquivo de Teste (5 min)

```powershell
# Verificar se há arquivo em origem
Get-ChildItem C:\4c\origem -Filter "*.scx"

# Se não houver, copiar um exemplo (ex: FormCor já migrado)
# IMPORTANTE: Usar formulário SIMPLES para primeira vez
```

### 2.2 Executar Migração Passo a Passo (30 min)

#### **Passo 1: Iniciar Orquestrador**

```powershell
cd C:\4c\automation
.\OrquestradorMigracao.ps1
```

**Saída esperada:**
```
=== ORQUESTRADOR DE MIGRACAO ===

Configuracao carregada:
  Origem: C:\4c\origem
  Tasks: C:\4c\tasks

Task ID: task001

============================================================================
 [ETAPA 1] Criar task e mover arquivos
============================================================================

Arquivo encontrado: SIGCDCOR.SCX
Arquivos movidos para: C:\4c\tasks\task001
```

---

#### **Passo 2: Observar Cada Etapa**

<table>
<tr>
<th>Etapa</th>
<th>O Que Acontece</th>
<th>Tempo</th>
</tr>
<tr>
<td><strong>1. Mover Arquivos</strong></td>
<td>Move SCX/SCT de origem → task001</td>
<td>5s</td>
</tr>
<tr>
<td><strong>2. Extrair Código</strong></td>
<td>VFP lê .SCX e gera .TXT</td>
<td>15-30s</td>
</tr>
<tr>
<td><strong>3. Gerar Meta-Prompt</strong></td>
<td>Substitui placeholders, gera .MD</td>
<td>5s</td>
</tr>
<tr>
<td><strong>4. Gerar Mapeamento</strong></td>
<td>VFP compara objetos, gera JSON</td>
<td>10-20s</td>
</tr>
<tr>
<td><strong>5. Migração (Claude)</strong></td>
<td>⏳ Claude gera FormXXX.prg + BO</td>
<td>5-10 min</td>
</tr>
<tr>
<td><strong>6. Testar Formulário</strong></td>
<td>VFP abre form, clica botões</td>
<td>30s</td>
</tr>
<tr>
<td><strong>7. Validar UI</strong></td>
<td>Compara 18 propriedades visuais</td>
<td>30s</td>
</tr>
<tr>
<td><strong>8. Teste Manual</strong></td>
<td>Gera markdown com checklist</td>
<td>5s</td>
</tr>
</table>

**Tempo Total:** ~30-60 minutos (depende de Claude API)

---

### 2.3 Monitorar Execução em Tempo Real (10 min)

#### **Abrir Segunda Janela PowerShell:**

```powershell
# Terminal 1: Execução rodando
.\OrquestradorMigracao.ps1

# Terminal 2: Monitoramento
cd C:\4c\tasks\task001

# Verificar estado em tempo real (atualiza a cada 5s)
while ($true) {
    cls
    $state = cat task_state.json | ConvertFrom-Json
    Write-Host "Task: $($state.taskId)"
    Write-Host "Status: $($state.status)"
    Write-Host ""
    Write-Host "Etapas:"
    foreach ($etapa in $state.etapas.PSObject.Properties) {
        Write-Host "  $($etapa.Name): $($etapa.Value.status)"
    }
    Start-Sleep 5
}
```

#### **Ver Logs em Tempo Real:**

```powershell
# Ver último log modificado
Get-ChildItem C:\4c\tasks\task001\logs\ |
    Sort-Object LastWriteTime -Descending |
    Select-Object -First 1 |
    Get-Content -Wait -Tail 20
```

---

## 🔍 Módulo 3: Monitoramento e Debug (30 min)

### 3.1 Anatomia do task_state.json (10 min)

```json
{
  "taskId": "task001",
  "arquivoOriginal": "SIGCDCOR",
  "status": "IN_PROGRESS",  // ← Status geral da task
  "criadoEm": "2026-01-22T10:30:00",
  "atualizadoEm": "2026-01-22T10:45:00",

  "etapas": {
    "02_extractCode": {
      "status": "COMPLETED",      // ← Status da etapa
      "inicio": "2026-01-22T10:30:05",
      "fim": "2026-01-22T10:30:20",
      "tentativas": 1,            // ← Quantas vezes tentou
      "erro": null                // ← Mensagem de erro (se falhou)
    },
    "05_migracao": {
      "status": "IN_PROGRESS",    // ← Etapa atual
      "inicio": "2026-01-22T10:35:00",
      "tentativas": 2,            // ← Já tentou 2 vezes
      "maxTentativas": 3,
      "erro": "Claude CLI timeout" // ← Erro da tentativa anterior
    }
  },

  "metricas": {
    "tempoTotalSegundos": 900,   // 15 minutos até agora
    "tempoExtracao": 15,
    "tempoMigracao": 600         // 10 min (Claude)
  }
}
```

---

### 3.2 Interpretando Logs (10 min)

#### **Estrutura de Log Padrão:**

```
[2026-01-22 10:30:05] [INFO] === ETAPA 2: EXTRAIR CODIGO ===
[2026-01-22 10:30:05] [INFO] Config.fpw temporario criado: C:\Temp\extract.fpw
[2026-01-22 10:30:05] [INFO] Executando Visual FoxPro 9...
[2026-01-22 10:30:20] [INFO] VFP9 finalizado em 15 segundos
[2026-01-22 10:30:20] [INFO] Exit Code: 0
[2026-01-22 10:30:20] [INFO] SUCESSO: Script VFP executado com sucesso
```

#### **Identificar Problemas:**

```
[2026-01-22 10:35:00] [ERROR] ERRO: Claude CLI retornou codigo de erro: 124
[2026-01-22 10:35:00] [ERROR] Output: Request timeout after 600 seconds
```

**Ação:** Aumentar timeout em `config.json`:
```json
"claude": {
  "timeout": 900  // ← Aumentar de 600 para 900
}
```

---

### 3.3 Troubleshooting Comum (10 min)

| Problema | Sintoma | Solução |
|----------|---------|---------|
| **Claude timeout** | Exit code 124, "timeout" no log | Aumentar `config.json` → `claude.timeout` |
| **Form não abre** | Exit code 1 ou 2, "CREATEOBJECT" falhou | Verificar se SET PROCEDURE em config.prg |
| **Validação UI reprova** | Total > maxProblemas | Revisar propriedades visuais, ajustar código |
| **Arquivo .fxp antigo** | Mudanças não aparecem | `del /s /q C:\4c\projeto\app\*.fxp` |
| **Placeholders não substituídos** | `{XXX}` no meta_prompt.md | Verificar `class_mapping.json` ou inferência |

#### **Comandos de Debug:**

```powershell
# Ver todas as tasks e status
Get-ChildItem C:\4c\tasks | ForEach-Object {
    $state = cat "$($_.FullName)\task_state.json" | ConvertFrom-Json
    Write-Host "$($_.Name): $($state.status) - $($state.arquivoOriginal)"
}

# Ver qual etapa está em execução
$state = cat C:\4c\tasks\task001\task_state.json | ConvertFrom-Json
$state.etapas.PSObject.Properties | Where-Object { $_.Value.status -eq "IN_PROGRESS" }

# Ver erros de uma task
$state.etapas.PSObject.Properties | Where-Object { $_.Value.erro }
```

---

## ⚙️ Módulo 4: Operação em Lote (30 min)

### 4.1 Três Modos de Operação (10 min)

#### **Tabela Comparativa:**

| Modo | Comando | Automação | Pausa | Quando Usar |
|------|---------|-----------|-------|-------------|
| **Manual** | `.\OrquestradorMigracao.ps1` | ❌ | Após cada | Primeiras 5-10 |
| **Semi-Auto** | `.\processar_lote_com_revisao.ps1` | 🟡 | Entre cada | Validação (10-50) |
| **Automático** | `.\processar_lote_automatico.ps1` | ✅ | Nenhuma | Produção (50+) |

---

### 4.2 Modo Semi-Automático (Hands-On) (10 min)

```powershell
# Processar 3 formulários com pausa entre cada
.\processar_lote_com_revisao.ps1 -Quantidade 3
```

**Saída:**
```
═══════════════════════════════════════════════════════════
 Processando formulario 1 de 3
 Arquivos restantes: 10
═══════════════════════════════════════════════════════════

[... execução da task001 ...]

✅ Formulario 1 COMPLETO!

Task criada: task001
  Arquivo: SIGCDCOR
  Status: COMPLETED
  Validacao UI:
    Erros: 0
    Avisos: 33
    Total: 33

REVISAR AGORA:
  1. Estado: cat C:\4c\tasks\task001\task_state.json
  2. Validacao UI: start C:\4c\tasks\task001\validacao_ui_report.html
  3. Teste manual: Abrir formulario no VFP

═══════════════════════════════════════════════════════════
Pressione ENTER para proximo, ou 'S' para SAIR: _
```

---

### 4.3 Modo Automático (Demonstração) (10 min)

⚠️ **IMPORTANTE:** Use apenas após validar 10+ formulários com sucesso!

```powershell
# Processar até 20 formulários automaticamente
.\processar_lote_automatico.ps1 -MaxTasks 20
```

**Saída:**
```
⚠️  AVISO: Este script processa TODOS os arquivos automaticamente,
    SEM PAUSA para revisao entre cada um.

Deseja continuar? (digite 'SIM' para confirmar): SIM

Iniciando processamento automatico...

[1/20] Processando... (restantes: 19)
  ✅ SUCESSO - task001 (32.5 min)

[2/20] Processando... (restantes: 18)
  ✅ SUCESSO - task002 (28.3 min)

[3/20] Processando... (restantes: 17)
  ❌ FALHA - task003 (exit: 2)

ERRO ENCONTRADO. Parando processamento.
Use -IgnoreErrors para continuar mesmo com erros.

═══════════════════════════════════════════════════════════
 RESUMO DO LOTE AUTOMATICO
═══════════════════════════════════════════════════════════

Total processados: 3
  Sucessos: 2
  Falhas: 1

Taxa de sucesso: 66.7%
Tempo total: 65.8 minutos

Tasks com problemas (revisar):
  - task003
```

---

## ✅ Módulo 5: Validação e QA (30 min)

### 5.1 Relatório de Validação UI (10 min)

**Abrir relatório HTML:**
```powershell
start C:\4c\tasks\task001\validacao_ui_report.html
```

#### **Interpretação de Resultados:**

| Tipo | Cor | Descrição | Ação |
|------|-----|-----------|------|
| **ERRO** | 🔴 Vermelho | Objeto não encontrado | ❌ Corrigir (exceto Dataenvironment) |
| **AVISO** | 🟡 Amarelo | Propriedade não existe | ✅ Aceitar se FormBase |
| **DIFERENÇA** | 🔵 Azul | Valor diferente | ⚠️ Analisar caso a caso |

#### **Meta de Qualidade:**

```
Total: 37 problemas
- 4 erros (Dataenvironment - OK)
- 33 avisos (FormBase - OK)
- 0 diferenças

Status: ✅ APROVADO
```

---

### 5.2 Teste Manual (10 min)

**Abrir solicitação de teste:**
```powershell
notepad C:\4c\SolicitacaoTesteManual\task001_SIGCDCOR.md
```

#### **Checklist Mínimo:**

```markdown
### 3.2. Teste Funcional - Modo INCLUIR
- [ ] Clicar no botão "Incluir"
- [ ] Preencher todos os campos obrigatórios
- [ ] Testar lookups (F4/F5)
- [ ] Clicar em "Confirmar"
- [ ] ✅ Verificar se registro foi inserido no banco
- [ ] ✅ Verificar auditoria em LogAuditoria

### 3.3. Teste Funcional - Modo ALTERAR
- [ ] Pesquisar registro existente
- [ ] Clicar no botão "Alterar"
- [ ] Modificar campos
- [ ] Clicar em "Confirmar"
- [ ] ✅ Verificar se registro foi atualizado

### 3.5. Teste Funcional - Modo EXCLUIR
- [ ] Pesquisar registro existente
- [ ] Clicar no botão "Excluir"
- [ ] Confirmar exclusão
- [ ] ✅ Verificar se registro foi excluído
```

---

### 5.3 Critérios de Aprovação (10 min)

#### **Checklist de Aprovação de Task:**

```
[ ] 1. Estado: task_state.json → status = COMPLETED
[ ] 2. Validação UI: total <= maxProblemas (ex: 37)
[ ] 3. Código compilado: Sem erros ao abrir no VFP
[ ] 4. Teste INCLUIR: Registro salvo + auditoria
[ ] 5. Teste ALTERAR: Registro atualizado + auditoria
[ ] 6. Teste VISUALIZAR: Campos read-only
[ ] 7. Teste EXCLUIR: Registro excluído + auditoria
[ ] 8. Lookups: F4/F5 funcionam corretamente
[ ] 9. Validações: Campos obrigatórios bloqueiam
[ ] 10. Performance: Similar ou melhor que original
```

#### **Se REPROVAR:**

```powershell
# 1. Identificar problema (logs, task_state.json)
# 2. Corrigir código manualmente (FormXXX.prg, XXXBO.prg)
# 3. Deletar .fxp
del /s /q C:\4c\projeto\app\*.fxp

# 4. Reprocessar apenas validação e teste
.\OrquestradorMigracao.ps1 -TaskId "task001"
# Escolher [C]ontinue nas etapas já aprovadas
```

---

## 🎯 Módulo 6: Q&A e Prática (30 min)

### 6.1 Exercício Prático 1 (15 min)

**Objetivo:** Migrar um formulário do início ao fim

```powershell
# 1. Colocar arquivo em origem
Copy-Item "C:\backup\SIGCDXXX.scx/sct" -Destination "C:\4c\origem\"

# 2. Executar migração
cd C:\4c\automation
.\OrquestradorMigracao.ps1

# 3. Durante execução:
#    - Monitorar task_state.json
#    - Ver logs em tempo real
#    - Se falhar, decidir [R]etry/[C]ontinue/[A]bort

# 4. Após conclusão:
#    - Revisar validacao_ui_report.html
#    - Testar formulário no VFP
#    - Preencher checklist de teste manual

# 5. Aprovar ou reprovar task
```

---

### 6.2 Exercício Prático 2 (15 min)

**Objetivo:** Processar lote com pausa

```powershell
# 1. Colocar 5 arquivos em origem
Copy-Item "C:\backup\SIGCD*.scx/sct" -Destination "C:\4c\origem\"

# 2. Processar em lote
.\processar_lote_com_revisao.ps1 -Quantidade 5

# 3. Para cada task:
#    - Revisar status (COMPLETED/FAILED)
#    - Abrir validacao_ui_report.html
#    - Decidir: ENTER (próximo) ou S (parar)

# 4. Ao final:
#    - Ver resumo (sucessos, falhas)
#    - Anotar taxa de sucesso
#    - Identificar tarefas para correção
```

---

### 6.3 Perguntas Frequentes (Discussão)

**P1: O que fazer se Claude demorar mais de 10 minutos?**
```
R: Aumentar timeout em config.json:
   "claude": { "timeout": 900 }
   Ou usar modelo Haiku (mais rápido, mas menos preciso)
```

**P2: Como saber se o mapeamento de classes está correto?**
```
R: Ver logs da Etapa 3:
   [Mapeamento] SIGCDCOR -> FormCor  ✅ (usou class_mapping.json)
   [Inferencia] SIGCDXYZ -> FormXYZ  ⚠️ (usou padrão SIGCD*)
```

**P3: Validação UI reprovou com 50 problemas. É normal?**
```
R: Depende dos TIPOS de problemas:
   - 4 erros Dataenvironment = OK
   - 33 avisos FormBase = OK
   - 13 diferenças críticas = ❌ NÃO OK (corrigir)
```

**P4: Posso rodar múltiplas tasks em paralelo?**
```
R: Não na v1.0 (sequencial). Planejado para v2.0.
   Workaround: Executar múltiplas instâncias do PowerShell
   (não recomendado - pode causar conflitos)
```

---

## 📚 Material de Referência

### Documentação Essencial

| Documento | Quando Consultar |
|-----------|------------------|
| **README.md** | Comando não funciona, erro básico |
| **ARQUITETURA_SISTEMA.md** | Entender como funciona internamente |
| **ANALISE_CRITICA_PROCESSO.md** | Troubleshooting avançado, melhorias |
| **SISTEMA_PLACEHOLDERS.md** | Problemas com meta-prompt |
| **QUAL_COMANDO_USAR.md** | Decisão: qual script executar |
| **INDEX.md** | Encontrar documento específico |

### Comandos Úteis (Cola)

```powershell
# Ver status de todas as tasks
Get-ChildItem C:\4c\tasks | % { cat "$($_.FullName)\task_state.json" | ConvertFrom-Json } | Format-Table taskId, status, arquivoOriginal

# Reprocessar task que falhou
.\OrquestradorMigracao.ps1 -TaskId "task005"

# Ver log mais recente de uma task
Get-ChildItem C:\4c\tasks\task001\logs\ | Sort LastWriteTime -Desc | Select -First 1 | Get-Content

# Deletar .fxp antes de testar
del /s /q C:\4c\projeto\app\*.fxp

# Verificar placeholders não substituídos
Select-String -Path "C:\4c\tasks\task001\meta_prompt.md" -Pattern '\{[A-Z_]+\}'
```

---

## ✅ Checklist de Conclusão do Treinamento

Você está pronto quando consegue:

- [ ] **Setup:** Verificar pré-requisitos (VFP, Claude, PowerShell)
- [ ] **Execução:** Rodar migração manual de 1 formulário
- [ ] **Monitoramento:** Ler task_state.json e interpretar logs
- [ ] **Decisão:** Saber quando [R]etry, [C]ontinue ou [A]bort
- [ ] **Validação:** Interpretar relatório UI Fidelity
- [ ] **QA:** Executar teste manual com checklist
- [ ] **Aprovação:** Decidir se task está pronta para produção
- [ ] **Lote:** Processar múltiplos forms (semi-automático)
- [ ] **Debug:** Identificar e corrigir problemas comuns
- [ ] **Documentação:** Saber onde buscar ajuda

---

## 🎓 Certificação (Opcional)

### Teste Prático (1 hora)

**Cenário:** Você recebe 3 formulários para migrar

**Tarefas:**
1. Configurar ambiente (verificar pré-requisitos)
2. Processar os 3 formulários em lote (semi-automático)
3. Monitorar execução, anotar problemas
4. Validar UI Fidelity dos 3 formulários
5. Executar teste manual de 1 formulário (sampling)
6. Aprovar/reprovar cada task com justificativa
7. Gerar relatório final com:
   - Taxa de sucesso
   - Tempo médio por task
   - Problemas encontrados
   - Ações corretivas necessárias

**Critério de Aprovação:**
- 100% das tasks processadas (mesmo que com retry)
- Validação UI correta (identificou problemas críticos)
- Teste manual executado corretamente
- Relatório completo e preciso

---

## 📞 Suporte Pós-Treinamento

### Onde Buscar Ajuda

1. **Documentação** (primeiro recurso)
   - INDEX.md → Encontrar documento
   - README.md → Comandos básicos
   - ANALISE_CRITICA → Troubleshooting

2. **Logs e Estado**
   - task_state.json → Ver status
   - logs/*.log → Ver detalhes
   - validacao_ui_report.html → Ver problemas visuais

3. **Equipe Técnica**
   - Dúvidas sobre código gerado
   - Problemas de infraestrutura
   - Melhorias no processo

---

## 🎯 Próximos Passos

Após treinamento, você deve:

1. **Semana 1:** Processar 5 formulários manualmente (prática)
2. **Semana 2:** Processar 10 formulários semi-automático
3. **Semana 3:** Avaliar taxa de sucesso, propor melhorias
4. **Semana 4+:** Operação em escala (automático)

---

**Boa sorte e bom trabalho! 🚀**

---

_Última atualização: 2026-01-22_
_Versão: 1.0_
