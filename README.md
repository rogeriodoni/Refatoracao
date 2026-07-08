# 🚀 Sistema de Refatoração VFP9 - Projeto 4c

**Sistema automatizado de migração de formulários Visual FoxPro 9 do legado para nova arquitetura em camadas**

---

## 📋 Visão Geral

Este projeto refatora um sistema legado Visual FoxPro 9 para uma arquitetura moderna em 3 camadas (Form/BusinessObject/DataAccess), mantendo **100% de fidelidade visual** e funcional com o sistema original.

### Os 3 Pilares Inegociáveis

| Pilar | Regra | Objetivo |
|-------|-------|----------|
| **1. UI/UX** | Manter **pixel-perfect** com original | Usuário não percebe mudança |
| **2. Banco de Dados** | **Idêntico** (exceto LogAuditoria) | Compatibilidade com integrações |
| **3. Código-Fonte** | **Obrigatoriamente diferente** | Código limpo, manutenível, arquitetura SOLID |

---

## 🎯 Quick Start - 3 Minutos para Primeira Migração

### Pré-requisitos

1. **Visual FoxPro 9** instalado: `C:\Program Files (x86)\Microsoft Visual FoxPro 9\VFP9.EXE`
2. **PowerShell 5.1+** (já vem no Windows 10/11)
3. **Arquivos  originais** colocados em: `C:\4c\origem\`

### Executar Primeira Migração (AUTOMATIZADA)

```powershell
# 1. Navegar para pasta de automação
cd C:\4c\automation

# 2. Executar orquestrador (processa 1 formulário e PARA)
.\OrquestradorMigracao.ps1
```

**O que acontece automaticamente:**
1. ✅ Cria task (ex: `task001`)
2. ✅ Extrai código-fonte do .SCX
3. ✅ Gera meta-prompt de análise
4. ✅ Gera mapeamento JSON (contrato de nomenclatura)
5. ✅ Implementa FormXXX.prg + XXXBO.prg (com lookups, validações, grid)
6. ✅ Testa formulário no VFP9
7. ✅ Valida UI Fidelity (18 propriedades visuais)
8. ✅ Gera solicitação de teste manual

**Resultado:** Formulário migrado pronto para revisão em `C:\4c\projeto\app\forms\cadastros\`

---

## 📂 Estrutura do Projeto

```
C:\4c\
├── README.md                     # Este arquivo - começar aqui
├── CLAUDE.md                     # Instruções críticas para Claude Code (IA)
│
├── origem\                       # ⚠️ COLOQUE ARQUIVOS .SCX/.SCT AQUI
│   ├── SIGCDCOR.scx/sct         # (será movido automaticamente para tasks\)
│   └── SIGCDCAR.scx/sct
│
├── tasks\                        # ✅ Tasks geradas automaticamente
│   ├── task001\                  # Uma task por formulário
│   │   ├── SIGCDCOR.scx/sct     # Arquivos originais
│   │   ├── SIGCDCOR_codigo_fonte.txt  # Código extraído
│   │   ├── meta_prompt.md       # Análise gerada
│   │   ├── mapeamento.json      # Contrato de nomenclatura
│   │   ├── task_state.json      # Estado das 8 etapas
│   │   ├── validacao_ui_report.html  # Relatório de validação
│   │   └── logs\                # Logs de cada etapa
│   └── task002\
│
├── automation\                   # 🤖 Sistema de automação (START HERE)
│   ├── README.md                # Guia de uso da automação
│   ├── QUAL_COMANDO_USAR.md     # Árvore de decisão: qual comando usar
│   ├── OrquestradorMigracao.ps1 # Script principal
│   ├── processar_lote_com_revisao.ps1    # Semi-automático
│   ├── processar_lote_automatico.ps1     # Totalmente automático
│   ├── config.json              # Configurações (limites, timeouts)
│   ├── INDEX.md                 # Índice de toda documentação
│   └── ...
│
├── docs\                        # 📚 Documentação detalhada
│   ├── GUIA_RAPIDO_MIGRACAO.md  # 7 passos de migração (manual)
│   ├── lookup_implementation.md # Como implementar lookups (F4)
│   ├── grid_implementation.md   # Como implementar grids/subtabelas
│   ├── form_patterns.md         # Padrões de formulários
│   ├── sql_guide.md             # SQL Server (SQLEXEC, transações)
│   ├── migration_guide.md       # Guia completo de migração
│   ├── ui_fidelity_validation.md  # ValidarUIFidelity (CRÍTICO)
│   ├── FORMCOR_LICOES_APRENDIDAS.md   # 5 problemas críticos
│   ├── FORMPRODUTO_LICOES_APRENDIDAS.md  # 5 erros básicos MVP
│   └── schema.sql               # Schema completo do banco
│
├── projeto\                     # 💻 Código-fonte do novo sistema
│   └── app\
│       ├── start\
│       │   ├── main.prg         # Ponto de entrada
│       │   └── config.prg       # Configuração (SET PROCEDURE)
│       ├── classes\
│       │   ├── formbase.prg     # Classe base de formulários
│       │   ├── businessbase.prg # Classe base de BOs
│       │   ├── gridbase.prg     # Classe base de grids
│       │   ├── CorBO.prg        # Business Objects (gerados)
│       │   └── CargoBO.prg
│       ├── forms\
│       │   └── cadastros\
│       │       ├── FormCor.prg  # Formulários (gerados)
│       │       └── FormCargo.prg
│       ├── utils\
│       │   ├── functions.prg    # Funções utilitárias
│       │   ├── messages.prg     # MsgErro, MsgAviso, MsgSucesso
│       │   ├── validators.prg   # ValidarCPF, ValidarCNPJ
│       │   ├── ExtractSCXCode.prg        # Extrator de código
│       │   ├── GeradorMapeamento.prg     # Gerador de JSON
│       │   └── ValidarUIFidelity.prg     # Validador UI
│       └── reports\
│           └── Rel*.frx         # Relatórios
│
├── Framework\                   # Sistema legado (NÃO MODIFICAR)
│   ├── FRAMEWORK.VCX            # Classes legado
│   └── sigacess.PRG             # Lookups legado
│
├── vbmp\                        # 🖼️ Ícones e imagens
│   └── *.jpg                    # Ícones dos botões
│
└── SolicitacaoTesteManual\     # 📝 Instruções de teste (geradas)
    ├── task001_teste_manual.md
    └── task002_teste_manual.md
```

---

## 🚀 Primeiros Passos

### Opção 1: Migração Automatizada (RECOMENDADO)

**Use quando:** Você quer o sistema fazer tudo automaticamente.

```powershell
# 1. Copie arquivos .SCX para C:\4c\origem\
Copy-Item "\\servidor\legado\*.scx" C:\4c\origem\
Copy-Item "\\servidor\legado\*.sct" C:\4c\origem\

# 2. Execute o orquestrador (processa 1 e PARA)
cd C:\4c\automation
.\OrquestradorMigracao.ps1
```

**Próximos passos:** Veja seção "Sistema de Automação" abaixo.

---

### Opção 2: Migração Manual (7 Passos)

**Use quando:** Você quer entender cada etapa ou debugar problema específico.

**Documentação completa:** `docs/GUIA_RAPIDO_MIGRACAO.md`

#### Resumo dos 7 Passos:

1. **Extrair Código-Fonte** (`ExtractSCXCode.prg`)
   ```foxpro
   DO C:\4c\ExtractSCXCode WITH "C:\4c\tasks\task1\SIGCDCOR.SCX"
   ```

2. **Gerar Mapeamento JSON** (`GeradorMapeamento.prg`)
   ```foxpro
   DO C:\4c\projeto\app\utils\GeradorMapeamento WITH "tasks\task1\SIGCDCOR_codigo_fonte.txt", "FormCor"
   ```

3. **Gerar Prompt com Meta-Prompt** (Claude.ai)
   - Abrir `docs/GERADOR_PROMPT_MIGRACAO.md`
   - Copiar meta-prompt
   - Colar no Claude.ai com .txt + JSON
   - Copiar prompt GERADO

4. **Implementar com Claude Code**
   - Colar prompt gerado no Claude Code CLI
   - Claude cria FormCor.prg + CorBO.prg

5. **Validar UI Fidelity** (`ValidarUIFidelity.prg`)
   ```foxpro
   CD C:\4c\projeto\app\utils
   DO ValidarUIFidelity WITH "task1\SIGCDCOR_codigo_fonte.txt", "FormCor"
   ```
   - **Meta:** ≤37 problemas (4 Dataenvironment + 33 FormBase)

6. **Testes Manuais**
   - Testar INCLUIR, ALTERAR, VISUALIZAR, EXCLUIR
   - Testar lookups (F4)
   - Verificar visual (botões não cortados, cores corretas)

7. **Solicitar Correções** (se necessário)
   - Listar problemas encontrados
   - Pedir ao Claude Code para corrigir
   - Repetir Passo 5 e 6

---

## 🤖 Sistema de Automação - Guia Completo

### 🌳 Qual Comando Usar? (Árvore de Decisão)

**Consulte:** `automation/QUAL_COMANDO_USAR.md` (guia interativo completo)

#### Decisão Rápida:

| Você Quer | Comando | Comportamento |
|-----------|---------|---------------|
| **Processar 1 formulário** (teste) | `.\OrquestradorMigracao.ps1` | Processa 1, PARA |
| **Processar 2-20 COM revisão** | `.\processar_lote_com_revisao.ps1 -Quantidade 20` | Pausa entre cada |
| **Processar TODOS sem pausa** | `.\processar_lote_automatico.ps1 -IgnoreErrors` | Totalmente automático |

### Workflow Recomendado (Progressão Gradual)

#### ⚠️ IMPORTANTE: Não comece com automação total!

| Fase | Quantidade | Comando | Objetivo |
|------|-----------|---------|----------|
| **Fase 1: Manual (5 simples)** | 5 | `.\OrquestradorMigracao.ps1` (5x) | Validar processo, ajustar config.json |
| **Fase 2: Semi-Auto (10-20)** | 10-20 | `.\processar_lote_com_revisao.ps1 -Quantidade 20` | Confirmar estabilidade, medir taxa de sucesso |
| **Fase 3: Automático (resto)** | Todos | `.\processar_lote_automatico.ps1 -IgnoreErrors` | Escala, revisão por amostragem (10%) |

**Critério para Fase 3:** Taxa de sucesso > 70% na Fase 2.

---

### Comandos Detalhados

#### 1. Processar Nova Task (1 formulário)

```powershell
cd C:\4c\automation
.\OrquestradorMigracao.ps1
```

**Comportamento:**
- Pega 1 arquivo de `C:\4c\origem\`
- Processa 8 etapas
- **PARA** ao final (permite revisão)
- Se etapa falhar: pede decisão [R]etry, [C]ontinue, [A]bort

#### 2. Processar Lote com Revisão (recomendado)

```powershell
cd C:\4c\automation

# Processar 10 com pausa entre cada
.\processar_lote_com_revisao.ps1 -Quantidade 10

# OU processar TODOS até acabar origem (pausa entre cada)
.\processar_lote_com_revisao.ps1
```

**Comportamento:**
- Loop: processa 1 → mostra resumo → **PAUSA** (ENTER ou 'S' para sair)
- Você controla quando continuar ou parar

#### 3. Processar Lote Automático (após validação)

```powershell
cd C:\4c\automation

# Processar até 20 (para se encontrar erro)
.\processar_lote_automatico.ps1 -MaxTasks 20

# Processar TODOS (continua mesmo com erros)
.\processar_lote_automatico.ps1 -IgnoreErrors
```

**Comportamento:**
- Loop contínuo, **SEM pausa**
- Mostra apenas resumo rápido (✅/❌)
- Se `-IgnoreErrors`: continua mesmo com erros (marca para revisão)

#### 4. Continuar Task Pendente

```powershell
.\OrquestradorMigracao.ps1 -ContinueFromLastTask
```

**Quando usar:** Task falhou, você corrigiu manualmente, quer continuar de onde parou.

#### 5. Processar Task Específica

```powershell
.\OrquestradorMigracao.ps1 -TaskId "task005"
```

**Quando usar:** Reprocessar task específica (ex: task003 falhou na validação UI).

---

### Monitoramento e Troubleshooting

#### Ver Status de Uma Task

```powershell
cat C:\4c\tasks\task001\task_state.json | ConvertFrom-Json | Format-List
```

**Campos importantes:**
- `status`: PENDING | IN_PROGRESS | COMPLETED | FAILED
- `etapas.*.status`: Status de cada uma das 8 etapas
- `etapas.*.tentativas`: Quantas vezes tentou
- `etapas.*.erro`: Mensagem de erro (se falhou)

#### Ver Logs de Uma Etapa

```powershell
# Ver log da etapa 5 (migração via Claude CLI)
cat C:\4c\tasks\task001\logs\05_migracao.log

# Listar todos os logs
Get-ChildItem C:\4c\tasks\task001\logs\*.log
```

**Logs disponíveis:**
- `01_moverArquivos.log`
- `02_extractCode.log`
- `03_gerarMetaPrompt.log`
- `04_gerarMapeamento.log`
- `05_migracao.log` (Claude CLI - CRÍTICO)
- `06_testForm.log` (teste VFP9)
- `07_validarUI.log` (ValidarUIFidelity)
- `08_gerarTestManual.log`

#### Ver Relatório de Validação UI

```powershell
# Abrir HTML no navegador
start C:\4c\tasks\task001\validacao_ui_report.html

# Ou ver JSON
cat C:\4c\tasks\task001\validacao_ui_report.json | ConvertFrom-Json
```

#### Ver Todas as Tasks e Status

```powershell
Get-ChildItem C:\4c\tasks -Directory | ForEach-Object {
    $state = cat "$($_.FullName)\task_state.json" | ConvertFrom-Json
    Write-Host "$($_.Name): $($state.status) - $($state.arquivoOriginal)"
}
```

---

### Problemas Comuns e Soluções

| Problema | Causa | Solução |
|----------|-------|---------|
| "Claude CLI nao encontrado" | Claude não instalado | `npm install -g @anthropic-ai/claude-code` |
| "VFP9.EXE nao encontrado" | Caminho incorreto | Editar `config.json` → `paths.vfp9` |
| Task falhou na etapa 05 (migração) | Timeout Claude CLI, API rate limit | Ver log, aguardar, retry |
| Formulário não abriu na etapa 06 | Erro de sintaxe, falta SET PROCEDURE | Corrigir código, deletar .fxp, retry |
| Validação UI reprovou (>37 problemas) | Propriedades visuais diferentes | Abrir HTML, corrigir FormXXX.prg, retry |

**Troubleshooting completo:** `automation/README.md` (seção Troubleshooting)

---

## 📚 Documentação Completa

### Documentação de Automação (automation\)

| Arquivo | Propósito | Quando Ler |
|---------|-----------|------------|
| **automation/README.md** | Guia completo de uso da automação | Primeiro acesso |
| **automation/QUAL_COMANDO_USAR.md** | Árvore de decisão: qual comando usar | Toda vez antes de executar |
| **automation/INDEX.md** | Índice de toda documentação | Navegar documentos |
| **automation/RESUMO_EXECUTIVO.md** | Resumo executivo, ROI, decisão Go/No-Go | Apresentar para gestão |
| **automation/ARQUITETURA_SISTEMA.md** | Arquitetura, diagramas, fluxos | Entender internamente |
| **automation/ANALISE_CRITICA_PROCESSO.md** | Riscos, limitações, melhorias | Avaliar qualidade |

### Documentação de Migração (docs\)

| Arquivo | Propósito | Quando Consultar |
|---------|-----------|------------------|
| **docs/GUIA_RAPIDO_MIGRACAO.md** | 7 passos de migração (manual) | Entender processo completo |
| **docs/lookup_implementation.md** | Como implementar lookups (F4) | Formulário tem campos com busca |
| **docs/grid_implementation.md** | Como implementar grids/subtabelas | Formulário tem grid |
| **docs/form_patterns.md** | Padrões de formulários (PageFrame, botões) | Problemas com UI |
| **docs/sql_guide.md** | SQL Server (SQLEXEC, transações, NOT NULL) | Problemas com banco |
| **docs/ui_fidelity_validation.md** | ValidarUIFidelity (CRÍTICO) | Entender validação automática |
| **docs/FORMCOR_LICOES_APRENDIDAS.md** | 5 problemas críticos (botões cortados, etc) | Problemas visuais |
| **docs/FORMPRODUTO_LICOES_APRENDIDAS.md** | 5 erros básicos MVP | Erros de iniciante |
| **docs/schema.sql** | Schema completo do banco | Consultar estrutura de tabelas |

### Arquivo Crítico (CLAUDE.md)

**C:\4c\CLAUDE.md**: Instruções críticas para Claude Code (IA). Contém:
- Os 3 pilares inegociáveis
- Regras de nomenclatura obrigatórias
- Padrões de código
- Regras de SQL
- Acentuação em português (CHR())
- Limitações do VFP9 (BINDEVENT, TRY/CATCH)

**Quando usar:** Ao pedir ao Claude Code para fazer alterações manuais no código.

---

## 🔍 Validação de Qualidade

### UI Fidelity Validation (CRÍTICO)

**O que valida:** 18 propriedades visuais (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize, etc.)

**Como executar:**
```foxpro
CD C:\4c\projeto\app\utils
DO ValidarUIFidelity WITH "task1\SIGCDCOR_codigo_fonte.txt", "FormCor"
```

**Critérios de Aceitação:**
- ✅ **≤ 37 problemas** (4 Dataenvironment + 33 FormBase + 0 diferenças)
- ❌ **> 100 problemas** = FormXXX.prg NÃO seguiu o JSON de nomenclatura

**Diferenças Aceitáveis:**
- ✅ Dataenvironment (4 erros) - Não visível na UI
- ✅ Controles do FormBase (~33 avisos) - Herdados, não estavam no original
- ✅ ForeColor normalizado - "90,90,90" vs "RGB(90,90,90)" (mesmo valor)

**Diferenças CRÍTICAS (corrigir):**
- ❌ Width/Height/Top/Left diferentes (±2px tolerância)
- ❌ BackColor/ForeColor valores RGB diferentes
- ❌ Caption/InputMask diferentes
- ❌ Objetos não encontrados (Labels, TextBoxes, etc.)

**Documentação:** `docs/ui_fidelity_validation.md`

---

## 🛠️ Configuração

### Editar Limites de Validação

**Arquivo:** `C:\4c\automation\config.json`

```json
{
  "validacao": {
    "maxProblemas": 10,
    "comentario": "Ajuste conforme necessário"
  },
  "retry": {
    "maxTentativasMigracao": 3,
    "maxTentativasTestForm": 5,
    "maxTentativasValidacao": 5
  },
  "claude": {
    "timeout": 600000,
    "comentario": "10 minutos - aumentar se Claude CLI der timeout"
  }
}
```

### Adicionar Novos Formulários ao Mapeamento

**Arquivo:** `C:\4c\automation\class_mapping.json` (criar se não existir)

```json
{
  "mappings": {
    "SIGCDCOR": {
      "formClass": "FormCor",
      "boClass": "CorBO"
    },
    "NOVOFORM": {
      "formClass": "FormNovo",
      "boClass": "NovoBO"
    }
  }
}
```

---

## 🎯 Checklist de Conclusão da Migração

Uma migração está **COMPLETA** quando:

```
[ ] ValidarUIFidelity: ≤37 problemas
[ ] Testes manuais: TODOS os itens passaram
    [ ] MODO LISTA: Grid, botões INCLUIR/ALTERAR/EXCLUIR/CONSULTAR/SAIR
    [ ] MODO INCLUIR: Campos vazios, habilitados, lookups (F4), validações
    [ ] MODO ALTERAR: Dados carregados, campos habilitados, alterações salvas
    [ ] MODO CONSULTAR: Campos desabilitados, botão SALVAR desabilitado
    [ ] VISUAL: Botões NÃO cortados, cores/fontes corretas
[ ] FormXXX.prg usa nomes EXATOS do mapeamento JSON
[ ] Grid: Mostra dados e cabeçalhos corretos
[ ] Lookups: F4 funciona em TODOS os campos
[ ] Validações: Campos obrigatórios validam, máscaras funcionam
[ ] Code review: Arquitetura em camadas (Form/BO/DataAccess)
[ ] Documentação: Problemas novos documentados em lições aprendidas
[ ] Commit: Código versionado com mensagem descritiva
```

---

## 🚦 Workflow Visual

```
                    ┌─────────────────────────────────────┐
                    │   Arquivos .SCX em C:\4c\origem\   │
                    └─────────────────────────────────────┘
                                     │
                    ┌────────────────┴─────────────────┐
                    │                                  │
                    ▼                                  ▼
        ╔════════════════════════╗      ╔════════════════════════╗
        ║  OPÇÃO 1: AUTOMAÇÃO    ║      ║  OPÇÃO 2: MANUAL       ║
        ║  (RECOMENDADO)         ║      ║  (7 PASSOS)            ║
        ╚════════════════════════╝      ╚════════════════════════╝
                    │                                  │
                    ▼                                  ▼
        OrquestradorMigracao.ps1         docs/GUIA_RAPIDO_MIGRACAO.md
                    │
                    ├─► 1. Mover arquivos
                    ├─► 2. ExtractSCXCode
                    ├─► 3. Gerar Meta-Prompt
                    ├─► 4. Gerar Mapeamento JSON
                    ├─► 5. Migração (Claude CLI)
                    ├─► 6. Testar Formulário (VFP9)
                    ├─► 7. Validar UI Fidelity
                    └─► 8. Gerar Teste Manual
                    │
                    ▼
        ┌───────────────────────────────────────┐
        │  Task Completa                        │
        │  - FormXXX.prg criado                 │
        │  - XXXBO.prg criado                   │
        │  - Validação UI: ≤37 problemas        │
        │  - Solicitação teste manual gerada    │
        └───────────────────────────────────────┘
                    │
                    ▼
        ┌───────────────────────────────────────┐
        │  REVISÃO MANUAL (OBRIGATÓRIA)         │
        │  1. Abrir validacao_ui_report.html    │
        │  2. Testar formulário manualmente     │
        │  3. Se OK: Commit                     │
        │  4. Se NOK: Corrigir e retry          │
        └───────────────────────────────────────┘
```

---

## 📈 Métricas e ROI

### Tempo de Migração

| Tipo de Formulário | Manual (sem meta-prompt) | Semi-Automático | Totalmente Automático |
|-------------------|-------------------------|-----------------|----------------------|
| **Simples** (3-5 campos) | ~5 horas | ~1-2 horas | ~15 minutos |
| **Médio** (10-15 campos, 1 grid) | ~8 horas | ~2-3 horas | ~30 minutos |
| **Complexo** (20+ campos, múltiplos grids) | ~15 horas | ~4-6 horas | ~1 hora |

**Ganho médio:** 90-98% de redução no tempo.

### Taxa de Sucesso Esperada

| Fase | Taxa de Sucesso | Intervenção Manual |
|------|----------------|-------------------|
| **Fase 1 (5 simples)** | 60-80% | Alta (validação) |
| **Fase 2 (10-20 médios)** | 70-85% | Média (ajustes) |
| **Fase 3 (resto)** | 80-90% | Baixa (revisão por amostragem) |

---

## 🔒 Segurança

### ⚠️ IMPORTANTE: Claude CLI e Credenciais

- Claude CLI pode acessar arquivos locais
- Certifique-se de que `.env` com credenciais **NÃO** estão em `C:\4c\origem\` ou `C:\4c\tasks\`
- Revisar código gerado antes de commit (buscar por senhas hardcoded)

---

## 🐛 Reportar Problemas

1. Salvar logs: `C:\4c\tasks\taskXXX\logs\`
2. Salvar `task_state.json`
3. Descrever problema + passos para reproduzir
4. Enviar para equipe de desenvolvimento

---

## 📞 Suporte

### Dúvidas Frequentes

**P: Posso deixar rodando durante a noite?**
R: Sim, se usar `processar_lote_automatico.ps1 -IgnoreErrors`. Revise resultados pela manhã.

**P: E se der erro no meio do lote?**
R: Semi-auto para e pede decisão. Automático continua (se `-IgnoreErrors`) ou para.

**P: Como sei se estou pronto para automação total?**
R: Taxa de sucesso > 70% em lote de 10+ formulários semi-automático.

**P: Preciso saber VFP9 ou PowerShell?**
R: **NÃO** para uso básico (executar comandos). **SIM** para troubleshooting avançado.

### Contatos

- **Documentação Técnica:** `automation/ARQUITETURA_SISTEMA.md`
- **Análise Crítica:** `automation/ANALISE_CRITICA_PROCESSO.md`
- **Índice Completo:** `automation/INDEX.md`

---

## 🎓 Treinamento

### Para Usuários (30 minutos)

1. Ler `automation/README.md` (10 min)
2. Ler `automation/QUAL_COMANDO_USAR.md` (5 min)
3. Executar `OrquestradorMigracao.ps1` com 1 formulário simples (15 min)

### Para Desenvolvedores (3 horas)

1. Ler `docs/GUIA_RAPIDO_MIGRACAO.md` (30 min)
2. Ler `CLAUDE.md` (30 min)
3. Executar migração manual (7 passos) com FormCor (1 hora)
4. Ler `automation/ARQUITETURA_SISTEMA.md` (30 min)
5. Executar migração automática (30 min)

**Material completo:** `automation/TREINAMENTO_TECNICO.md` (6 módulos hands-on)

---

## 📅 Roadmap

### v1.1 (Em Desenvolvimento)
- [ ] Dashboard de progresso
- [ ] Classificação de severidade no ValidarUIFidelity
- [ ] Testes funcionais no TestFormWrapper

### v1.2 (Planejado)
- [ ] Meta-prompt adaptativo (simples/médio/complexo)
- [ ] Cache de respostas do Claude CLI
- [ ] Integração com Git (auto-commit)

### v2.0 (Futuro)
- [ ] Paralelização de tasks
- [ ] Notificações por email/Slack
- [ ] Métricas e analytics

---

## 📜 Licença

**Projeto interno - Uso restrito**

---

## 🙏 Créditos

**Sistema desenvolvido para migração do projeto 4c**

- **Visual FoxPro 9**: Microsoft
- **Claude Code**: Anthropic
- **Sistema de Automação**: Equipe 4c

---

**Happy Migrating! 🚀**

_Última atualização: 2026-01-27_
_Versão: 1.0_

# Refatoracao
Refatoração projeto Modular

