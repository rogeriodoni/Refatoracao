---
name: propagate-lesson
description: Propaga lições aprendidas de bugs VFP9 para todos os artefatos do pipeline de migração (prompts, skill, CorretorAutomatico, memória). Use sempre que corrigir um bug em um form migrado e precisar garantir que a mesma correção será aplicada automaticamente nas próximas migrações. Triggers: "propagar lição", "propagar regra", "atualizar pipeline", "adicionar regra ao pipeline", "lesson learned", "lição aprendida", "garantir que isso não aconteça de novo", "atualizar prompts com esta correção", "adicionar ao CorretorAutomatico", ou quando o usuário confirma que um bug foi corrigido e pergunta se os artefatos foram atualizados.
---

# Propagate Lesson - VFP9 Migration Pipeline

Quando um bug é encontrado e corrigido em um form VFP9 migrado, a correção precisa ser propagada para **todos** os artefatos do pipeline para que as próximas migrações não repitam o mesmo erro.

## Artefatos a Atualizar (Checklist)

Cada lição deve ser propagada para estes 6 locais:

| # | Artefato | Caminho | O que atualizar |
|---|----------|---------|-----------------|
| 1 | **Prompts de migração** | `C:\4c\automation\OrquestradorMigracao.ps1` | Seções "Regras VFP Criticas" nos 4 blocos de prompt |
| 2 | **Skill migration-patterns** | `C:\4c\.claude\skills\vfp9-migration\migration-patterns.md` | Nova seção numerada |
| 3 | **CorretorAutomatico** | `C:\4c\automation\CorretorAutomatico.ps1` | Novo pattern (se fix é automável via regex) |
| 4 | **Corretor docs** | `C:\4c\.claude\skills\vfp9-migration\corretor-patterns.md` | Linha na tabela de patterns |
| 5 | **Memória** | `C:\Users\rafae\.claude\projects\C--4c\memory\MEMORY.md` | Registro da lição |
| 6 | **Sweep retroativo** | `C:\4c\automation\CorrigirTodosFormularios.ps1` | **OBRIGATÓRIO se #3 mudou** - reaplica corretor em todos os forms já migrados |

## Workflow

### Passo 1: Entender a Lição

Extrair do contexto da conversa:
- **O que deu errado**: Qual erro o usuário encontrou (mensagem de erro, comportamento incorreto)
- **Causa raiz**: Por que o código migrado tinha esse problema
- **A correção**: O que foi feito para resolver
- **A regra**: Como formular para prevenir nas próximas migrações

### Passo 2: Classificar a Lição

Determinar:
- **Escopo dos prompts**: A regra se aplica a quais prompts?
  - Phase A (UI) → regras visuais, AddObject, propriedades
  - Phase B (Funcionalidade) → regras SQL, cursors, lógica
  - OPERACIONAL → regras específicas de forms operacionais
  - REPORT → regras específicas de relatórios
  - TODOS → regras universais VFP9
- **É automável?**: O fix pode ser detectado/corrigido via regex no CorretorAutomatico?
  - SIM → criar novo pattern (ex: substituir texto X por Y)
  - NÃO → apenas documentar nos prompts/skill

### Passo 3: Localizar os Pontos de Inserção

Buscar no OrquestradorMigracao.ps1 os blocos de "Regras VFP Criticas":

```
Grep pattern: "Regras VFP Criticas" ou "MESSAGEBOX PROIBIDO" (última regra conhecida)
```

Os 4 blocos ficam em diferentes seções do arquivo:
1. **REPORT prompt** (~linha 2970) - `## Regras VFP Criticas` antes de `## Integracao`
2. **OPERACIONAL prompt** (~linha 3140) - `## Regras VFP Criticas` antes de `## REGRA CRITICA: NUNCA Criar Stubs`
3. **Phase A prompt** (~linha 3250) - lista de regras antes de `Comecar agora. Foco TOTAL`
4. **Phase B prompt** (~linha 3320) - `## Regras VFP Criticas` antes de `Comecar agora. Ler os arquivos`

Para cada bloco, inserir a nova regra **antes da linha final** (antes de "Comecar agora" ou da próxima seção ##).

### Passo 4: Formular a Regra

A regra nos prompts deve ser uma **linha única** no formato:
```
- **NOME_CURTO**: Descrição concisa da regra. Exemplo do que fazer/não fazer.
```

Exemplo real:
```
- **BINDEVENT "Valid" NAO FUNCIONA em TextBox**: Usar "LostFocus" ao inves de "Valid". O evento Valid via BINDEVENT nao dispara de forma confiavel em TextBox/ComboBox
```

### Passo 5: Aplicar as Alterações

Executar na ordem:

#### 5.1 OrquestradorMigracao.ps1 (4 blocos)
- Usar `Grep` para localizar as posições exatas
- Usar `Edit` para adicionar a regra em cada bloco relevante
- Verificar com `Grep` que todas as ocorrências foram adicionadas

#### 5.2 migration-patterns.md
- Ler o arquivo para encontrar o último número de seção
- Adicionar nova seção `## N+1. Título da Regra` com:
  - Descrição do problema
  - Exemplo de código ERRADO vs CORRETO (```foxpro blocks)
  - Motivo/explicação

#### 5.3 CorretorAutomatico.ps1 (se automável)
- Encontrar o último pattern (buscar última `function Corrigir-` ou `function Fix-`)
- Criar nova função seguindo o padrão existente:
  ```powershell
  function Corrigir-NomeDaCorrecao {
      param([string[]]$Linhas)
      # ... lógica de detecção e substituição
      return $Linhas
  }
  ```
- Registrar a chamada na função `Invoke-CorrecaoAutomatica` (antes do `# Salva arquivo corrigido`)
- Usar `Add-Correcao` para registrar cada correção aplicada

#### 5.4 corretor-patterns.md
- Atualizar contador no título (`## Auto-Fix Patterns (N total)`)
- Atualizar texto descritivo (`all N auto-fix patterns`)
- Adicionar linha na tabela de patterns:
  ```
  | N | Descrição curta | `código errado` | `código correto` + explicação |
  ```

#### 5.5 MEMORY.md
- Adicionar registro conciso na seção de lições (junto com data)

#### 5.6 Sweep retroativo (CorrigirTodosFormularios.ps1) — **OBRIGATÓRIO se mudou CorretorAutomatico**

Quando o passo 5.3 adicionou um novo pattern OU corrigiu um pattern existente no `CorretorAutomatico.ps1`, é OBRIGATÓRIO rodar o sweep retroativo. Sem isso, forms migrados **antes** da adição do pattern continuarão com o anti-pattern.

Comando:
```powershell
powershell.exe -ExecutionPolicy Bypass -File C:\4c\automation\CorrigirTodosFormularios.ps1
```

O script:
- Processa todos os `*.prg` em `app/forms/**/*.prg` e `app/classes/*BO.prg` (~54 arquivos)
- Cria `.bak` antes de modificar (reversível)
- Reporta total de arquivos modificados + correções

**Causa raiz documentada (task001 / 2026-05-13)**: o pattern `Corrigir-ElseIf` foi adicionado ao CorretorAutomatico DEPOIS de FormDepartamento.prg ter sido gerado. Como o sweep retroativo não rodou, o `ELSEIF` ficou no arquivo até ser pego em teste manual semanas depois. Mesma história para `Corrigir-PublicProcedureEmDefineClass` que só tratava `PROCEDURE` (não `FUNCTION`) - bug observado em task018/UfsBO.prg.

### Passo 6: Verificar

Após todas as alterações:
1. `Grep` por um trecho único da nova regra para confirmar presença em todos os arquivos
2. Contar ocorrências no OrquestradorMigracao.ps1 (deve ter N ocorrências, conforme escopo)
3. Confirmar para o usuário com tabela de resumo:

```
| Artefato | Status | Detalhes |
|----------|--------|----------|
| Prompt REPORT | OK | Linha XXXX |
| Prompt OPERACIONAL | OK | Linha XXXX |
| Prompt Phase A | OK/SKIP | ... |
| Prompt Phase B | OK | Linha XXXX |
| migration-patterns.md | OK | Seção ## N |
| CorretorAutomatico.ps1 | OK/N/A | Pattern #N |
| corretor-patterns.md | OK/N/A | Total: N patterns |
| MEMORY.md | OK | Registrado |
```

## Dicas

- Regras de **UI/visual** vão em Phase A + skill, mas geralmente NÃO no CorretorAutomatico (difícil de automatizar via regex)
- Regras de **SQL/cursors/lógica** vão em Phase B + OPERACIONAL + skill + possivelmente CorretorAutomatico
- Regras **universais VFP9** (como BINDEVENT, MESSAGEBOX) vão em TODOS os 4 prompts
- O CorretorAutomatico só deve ter patterns que são **seguros de aplicar automaticamente** (sem falsos positivos)
- Manter regras nos prompts **concisas** (1 linha) - detalhes vão na skill migration-patterns.md
