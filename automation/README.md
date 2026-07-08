# Sistema de Migração Automatizada - Visual FoxPro 9

**Versão:** 1.0
**Status:** ✅ Pronto para testes (Alpha)

---

## 🚀 Quick Start

### Pré-Requisitos

1. **Visual FoxPro 9** instalado em: `C:\Program Files (x86)\Microsoft Visual FoxPro 9\VFP9.EXE`
2. **PowerShell 5.1+** (já vem no Windows)
3. **Claude CLI** instalado:
   ```powershell
   npm install -g @anthropic-ai/claude-code
   ```
4. **Arquivos fonte originais** em: `C:\4c\origem\` (pares SCX/SCT)

### Executar Primeira Migração

```powershell
# 1. Navegar para pasta de automação
cd C:\4c\automation

# 2. Executar orquestrador
.\OrquestradorMigracao.ps1
```

O sistema irá automaticamente:
1. Buscar próximo arquivo em `C:\4c\origem\`
2. Criar task (ex: `task001`)
3. Extrair código fonte
4. Gerar meta-prompt
5. Gerar mapeamento
6. **Invocar Claude CLI para migração**
7. Testar formulário
8. Validar UI Fidelity
9. Gerar solicitação de teste manual

---

## 📂 Estrutura de Diretórios

```
C:\4c\
├── origem\                   # ⚠️ Coloque arquivos SCX/SCT aqui
├── tasks\                    # ✅ Tasks geradas automaticamente
│   ├── task001\
│   │   ├── SIGCDCOR.scx/sct
│   │   ├── SIGCDCOR_codigo_fonte.txt
│   │   ├── meta_prompt.md
│   │   ├── mapeamento.json
│   │   ├── task_state.json
│   │   └── logs\
│   └── task002\
├── automation\               # 🤖 Scripts de automação (este diretório)
└── SolicitacaoTesteManual\  # 📝 Instruções de teste manual
```

---

## ⚙️ Configuração

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

## 🎛️ Comandos Disponíveis

### 1. Criar Nova Task (Processa 1 Arquivo e Para)
```powershell
.\OrquestradorMigracao.ps1
```
**Comportamento:** Processa **1 arquivo** e **PARA** (permite revisão)

### 2. Continuar Task Pendente
```powershell
.\OrquestradorMigracao.ps1 -ContinueFromLastTask
```

### 3. Processar Task Específica
```powershell
.\OrquestradorMigracao.ps1 -TaskId "task005"
```

### 4. Processar Lote com Revisão (Recomendado)
```powershell
# Processar 5 formulários com pausa entre cada
.\processar_lote_com_revisao.ps1 -Quantidade 5

# OU processar TODOS até acabar (pausa entre cada)
.\processar_lote_com_revisao.ps1
```
**Comportamento:** Processa múltiplos, **PAUSA entre cada** para revisão

### 5. Processar Lote Automático (⚠️ Usar Após Validação)
```powershell
# Processar 20 formulários sem pausa
.\processar_lote_automatico.ps1 -MaxTasks 20

# Processar TODOS, continuar mesmo com erros
.\processar_lote_automatico.ps1 -IgnoreErrors
```
**Comportamento:** Processa múltiplos, **SEM PAUSA** (totalmente automático)

⚠️ **IMPORTANTE:** Use apenas após validar processo com 10+ formulários!

### 6. Ver Dashboard de Progresso
```powershell
.\Dashboard.ps1  # (criar este script - ver ANALISE_CRITICA_PROCESSO.md)
```

---

## 🔍 Monitoramento

### Verificar Status de Uma Task

```powershell
cd C:\4c\tasks\task001
cat task_state.json
```

**Campos importantes:**
- `status`: PENDING | IN_PROGRESS | COMPLETED | FAILED
- `etapas.*.status`: Status de cada etapa
- `etapas.*.tentativas`: Quantas vezes tentou
- `etapas.*.erro`: Mensagem de erro (se falhou)

### Ver Logs de Uma Etapa

```powershell
# Exemplo: Ver log da etapa de teste de formulário
cat C:\4c\tasks\task001\logs\06_testForm.log
```

### Ver Relatório de Validação UI

```powershell
# Abrir no navegador
start C:\4c\tasks\task001\validacao_ui_report.html
```

---

## ❓ Troubleshooting

### Problema: "Claude CLI nao encontrado"

**Solução:**
```powershell
npm install -g @anthropic-ai/claude-code
claude --version  # Deve mostrar versão
```

### Problema: "VFP9.EXE nao encontrado"

**Solução:**
1. Verificar se VFP está instalado
2. Editar `config.json`:
   ```json
   "paths": {
     "vfp9": "C:\\Caminho\\Correto\\VFP9.EXE"
   }
   ```

### Problema: Task falhou na etapa de migração (05)

**Causas comuns:**
- Claude CLI timeout (aumentar `config.json` → `claude.timeout`)
- API rate limit (aguardar alguns minutos)
- Prompt muito grande (simplificar meta-prompt)

**Solução:**
1. Verificar log: `C:\4c\tasks\taskXXX\logs\05_migracao.log`
2. Corrigir problema
3. Executar: `.\OrquestradorMigracao.ps1 -TaskId "taskXXX"`
4. Escolher opção `[R] Retry`

### Problema: Formulário não abriu no teste (06)

**Causas comuns:**
- Erro de sintaxe no código gerado
- Falta dependência (SET PROCEDURE)
- Nome de classe incorreto

**Solução:**
1. Ver log: `C:\4c\tasks\taskXXX\logs\06_testForm.log`
2. Corrigir código em `C:\4c\projeto\app\forms\cadastros\FormXXX.prg`
3. **IMPORTANTE:** Deletar .fxp: `del /s /q C:\4c\projeto\app\*.fxp`
4. Retry: Escolher `[R] Retry`

### Problema: Validação UI reprovou (07)

**Causas comuns:**
- Propriedades visuais diferentes (Width, Height, Top, Left)
- Cores diferentes (BackColor, ForeColor)
- Controles faltando

**Solução:**
1. Abrir relatório HTML: `C:\4c\tasks\taskXXX\validacao_ui_report.html`
2. Identificar diferenças
3. Corrigir código do formulário
4. Deletar .fxp: `del /s /q C:\4c\projeto\app\*.fxp`
5. Retry: Escolher `[R] Retry`

---

## 📊 Interpretando Resultados

### task_state.json - Status das Etapas

```json
{
  "etapas": {
    "01_moverArquivos": {
      "status": "COMPLETED"  // ✅ OK
    },
    "05_migracao": {
      "status": "FAILED",    // ❌ Falhou
      "tentativas": 2,       // Tentou 2 vezes
      "erro": "Claude CLI timeout"
    },
    "07_validarUI": {
      "status": "COMPLETED",
      "problemas": {
        "erros": 0,          // ✅ 0 erros = BOM
        "avisos": 33,        // ⚠️ Avisos aceitáveis (FormBase)
        "diferencas": 0,
        "total": 33          // Total <= maxProblemas = APROVADO
      }
    }
  }
}
```

### validacao_ui_report.html - Tipos de Problemas

| Tipo | Descrição | Ação |
|------|-----------|------|
| **ERRO** (vermelho) | Objeto não encontrado | ❌ Corrigir (exceto Dataenvironment) |
| **AVISO** (amarelo) | Propriedade não existe (FormBase) | ✅ Aceitar (esperado) |
| **DIFERENÇA** (azul) | Valor diferente | ⚠️ Analisar caso a caso |

**Diferenças aceitáveis:**
- ✅ Dataenvironment (4 erros) - Não afeta UI
- ✅ Controles do FormBase (~33 avisos) - Herdados, não no original
- ✅ ForeColor normalizado - "90,90,90" vs "RGB(90,90,90)" (mesmo valor)

**Diferenças CRÍTICAS (corrigir):**
- ❌ Width/Height/Top/Left diferentes
- ❌ BackColor/ForeColor valores RGB diferentes
- ❌ Caption/InputMask diferentes

---

## 🎯 Workflow Recomendado

### ⚠️ IMPORTANTE: Progressão Gradual

**NÃO comece com automação total!** Siga esta progressão:

#### **Fase 1: Manual (5 formulários simples)**
```powershell
# Processar 1 por vez, revisar cada resultado
.\OrquestradorMigracao.ps1  # Task 1
# Revisar, depois:
.\OrquestradorMigracao.ps1  # Task 2
# ... repetir 5 vezes
```
**Objetivo:** Validar processo, identificar problemas, ajustar config.json

#### **Fase 2: Semi-Automática (10-20 formulários médios)**
```powershell
# Processa com pausa entre cada
.\processar_lote_com_revisao.ps1 -Quantidade 20
```
**Objetivo:** Confirmar estabilidade, medir taxa de sucesso

**Critério para Fase 3:** Taxa de sucesso > 70%

#### **Fase 3: Automática (restante)**
```powershell
# Processa todos automaticamente
.\processar_lote_automatico.ps1 -IgnoreErrors
```
**Objetivo:** Processar em escala, revisão por amostragem (10%)

---

### Comparação das Opções

| Modo | Comando | Automação | Quando Usar |
|------|---------|-----------|-------------|
| **Manual** | `.\OrquestradorMigracao.ps1` | ❌ Nenhuma | Fase 1 (testes) |
| **Semi-Auto** | `.\processar_lote_com_revisao.ps1` | 🟡 Pausa entre cada | Fase 2 (validação) |
| **Automático** | `.\processar_lote_automatico.ps1` | ✅ Total | Fase 3 (produção) |

### Revisão Manual Após Cada Task

1. ✅ Verificar `task_state.json` → `status = COMPLETED`
2. ✅ Abrir `validacao_ui_report.html` → revisar problemas
3. ✅ Testar formulário manualmente:
   ```powershell
   cd C:\4c\projeto\app\forms\cadastros
   # Abrir VFP e executar:
   # DO FormXXX
   ```
4. ✅ Revisar código gerado (FormXXX.prg, XXXBO.prg)
5. ✅ Commit se tudo OK

---

## 📚 Documentação Adicional

- **Análise Crítica Completa:** `ANALISE_CRITICA_PROCESSO.md`
- **Documentação do Projeto:** `C:\4c\docs\`
- **CLAUDE.md:** `C:\4c\CLAUDE.md` (instruções gerais)

---

## 🐛 Reportar Problemas

1. Salvar logs: `C:\4c\tasks\taskXXX\logs\`
2. Salvar `task_state.json`
3. Descrever problema + passos para reproduzir
4. Enviar para equipe de desenvolvimento

---

## 🔐 Segurança

### ⚠️ IMPORTANTE: Claude CLI e Credenciais

- Claude CLI pode acessar arquivos locais
- Certifique-se de que `.env` com credenciais **NÃO** estão em `C:\4c\origem\` ou `C:\4c\tasks\`
- Revisar código gerado antes de commit (buscar por senhas hardcoded)

---

## 📈 Próximos Passos (Roadmap)

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

**Happy Migrating! 🚀**

_Sistema desenvolvido para migração do projeto 4c_
_Última atualização: 2026-01-22_
