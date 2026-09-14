# versao200426 — Distribuicao para cliente

**Data:** 2026-04-20
**Fonte:** `C:\4c` (baseline sincronizado com a pasta do cliente `C:\4c\Limpeza\4c` antes da edicao)
**Objetivo:** Aplicar Changes 1 e 2 da analise das tasks 016-022 para reduzir ajustes manuais em botoes de saida/encerrar/fechar/cancelar.

---

## 1. O que mudou

### Change 1 — Regex do CorretorAutomatico ampliado
Corrige automaticamente 3 padroes recorrentes que escapavam do pipeline:

| Arquivo | Mudanca |
|---|---|
| `automation/CorretorAutomatico.ps1` | `Corrigir-LostFocusLookupBusca` (#74) ampliado: agora detecta handler de lookup por 3 heuristicas (body tem `CREATEOBJECT("FormBuscaAuxiliar")`, nome contem "Lookup", ou nome contem "Validar" e arquivo tem FormBuscaAuxiliar). Antes so pegava a primeira. |
| `automation/CorretorAutomatico.ps1` | Nova funcao `Corrigir-PageWidthStripMinus60` (#88): corrige `.Width = THIS.Width - 60/-65/-70` em containers de Page -> `THIS.Width`. Aplica so em forms CRUD. |
| `automation/CorretorAutomatico.ps1` | Nova funcao `Corrigir-BotaoSaidaCanonico` (#89): botoes `cmd_4c_Sair`/`Fechar`/`Cancelar`/`X` com Caption != "Encerrar" em forms CRUD -> Caption="Encerrar", Width=75, Height=75. Preserva nome do objeto. |

### Change 2 — "Padrao Canonico Saida/Encerrar prevalece sobre PILAR 1"
Regra de precedencia explicita em 4 lugares para que o gerador emita correto desde a primeira passada:

| Arquivo | Mudanca |
|---|---|
| `CLAUDE.md` | Nova regra **#10** em "Critical VFP9 Rules" com tabela canonica (`cnt_4c_Saida` L=917 W=90, `cmd_4c_Encerrar` W=75 H=75 Caption="Encerrar"). |
| `automation/OrquestradorMigracao.ps1` | Linha adicional "**PADRAO CANONICO SAIDA/ENCERRAR — PREVALECE SOBRE PILAR 1**" em 3 blocos de prompt (OPERACIONAL, Phase A, Phase B). |
| `.claude/skills/vfp9-migration/corretor-patterns.md` | Contador 87 -> 89. Nota ampliada em #74. Novas entradas #88 e #89. |
| `.claude/skills/vfp9-migration/migration-patterns.md` | Nova secao **#98** com exemplos de codigo ERRADO vs CORRETO. |
| `docs/framework_frmcadastro_layout.md` | Secao `cnt_4c_Saida` corrigida (era Left=935 W=60 Caption="X" btn W=50 — valores do legado). Regra de ouro #8 adicionada. |

---

## 2. Como aplicar na maquina do cliente

Os arquivos deste pacote refletem o **estado final** (cliente ja tinha o baseline `Limpeza\4c` de 2026-04-20; este pacote so adiciona as Changes 1+2 em cima). Basta copiar os arquivos para as mesmas paths no repo de trabalho do cliente.

### Opcao A: Copia direta com backup

```powershell
# PRE-REQUISITO: estar no diretorio-raiz do repo de trabalho (ex: C:\4c ou similar)
$repo = "C:\4c"  # ajustar se o repo do cliente estiver em outro path
$origem = "C:\4c\versao200426"
$ts = Get-Date -Format "yyyyMMdd_HHmmss"
$backup = Join-Path $repo "_backup_pre_200426_$ts"

# Criar backup dos arquivos que serao sobrescritos
New-Item -ItemType Directory -Force -Path (Join-Path $backup "automation") | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $backup ".claude\skills\vfp9-migration") | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $backup "docs") | Out-Null

Copy-Item "$repo\CLAUDE.md"                                                  "$backup\"
Copy-Item "$repo\automation\CorretorAutomatico.ps1"                          "$backup\automation\"
Copy-Item "$repo\automation\OrquestradorMigracao.ps1"                        "$backup\automation\"
Copy-Item "$repo\.claude\skills\vfp9-migration\corretor-patterns.md"         "$backup\.claude\skills\vfp9-migration\"
Copy-Item "$repo\.claude\skills\vfp9-migration\migration-patterns.md"        "$backup\.claude\skills\vfp9-migration\"
Copy-Item "$repo\docs\framework_frmcadastro_layout.md"                       "$backup\docs\"

Write-Host "Backup criado em: $backup"

# Aplicar as mudancas
Copy-Item "$origem\CLAUDE.md"                                                 "$repo\" -Force
Copy-Item "$origem\automation\CorretorAutomatico.ps1"                         "$repo\automation\" -Force
Copy-Item "$origem\automation\OrquestradorMigracao.ps1"                       "$repo\automation\" -Force
Copy-Item "$origem\.claude\skills\vfp9-migration\corretor-patterns.md"        "$repo\.claude\skills\vfp9-migration\" -Force
Copy-Item "$origem\.claude\skills\vfp9-migration\migration-patterns.md"       "$repo\.claude\skills\vfp9-migration\" -Force
Copy-Item "$origem\docs\framework_frmcadastro_layout.md"                      "$repo\docs\" -Force

Write-Host "Changes 1+2 aplicadas."
```

### Opcao B: Aplicar arquivo-a-arquivo (se o cliente quiser revisar cada diff antes)

Para cada arquivo listado na tabela acima, fazer diff contra a versao atual do cliente e revisar. `VSCode`, `meld`, ou `kdiff3` funcionam bem.

---

## 3. Validacao pos-aplicacao

Apos copiar, rodar:

```powershell
# 1) Validar sintaxe dos .ps1
powershell -NoProfile -Command "& { `$tokens=`$null; `$errors=`$null; [System.Management.Automation.Language.Parser]::ParseFile('C:\4c\automation\CorretorAutomatico.ps1', [ref]`$tokens, [ref]`$errors) | Out-Null; if (`$errors.Count -gt 0) { `$errors | ForEach-Object { Write-Host ('[SYNTAX] Line ' + `$_.Extent.StartLineNumber + ': ' + `$_.Message) } } else { Write-Host 'CorretorAutomatico.ps1 SYNTAX OK' } }"

powershell -NoProfile -Command "& { `$tokens=`$null; `$errors=`$null; [System.Management.Automation.Language.Parser]::ParseFile('C:\4c\automation\OrquestradorMigracao.ps1', [ref]`$tokens, [ref]`$errors) | Out-Null; if (`$errors.Count -gt 0) { `$errors | ForEach-Object { Write-Host ('[SYNTAX] Line ' + `$_.Extent.StartLineNumber + ': ' + `$_.Message) } } else { Write-Host 'OrquestradorMigracao.ps1 SYNTAX OK' } }"
```

### Smoke test opcional — rodar o CorretorAutomatico sobre um .prg existente

```powershell
# Escolher um form ja migrado e que atualmente esteja "OK" (sem bugs conhecidos)
# Rodar em modo dry-run para ver o que mudaria
pwsh -File "C:\4c\automation\CorretorAutomatico.ps1" -Arquivo "C:\4c\projeto\app\forms\cadastros\FormDepartamento.prg"
```

Se o CorretorAutomatico modificar um form que atualmente esta OK com mais do que as correcoes esperadas (Encerrar, PageWidth), investigar antes de rodar em producao.

---

## 4. Como reverter (rollback)

O script de backup acima cria uma pasta `_backup_pre_200426_YYYYMMDD_HHMMSS` no repo. Para desfazer:

```powershell
$repo = "C:\4c"
$backup = "C:\4c\_backup_pre_200426_20260420_XXXXXX"   # usar a pasta real criada

Copy-Item "$backup\CLAUDE.md"                                                 "$repo\" -Force
Copy-Item "$backup\automation\CorretorAutomatico.ps1"                         "$repo\automation\" -Force
Copy-Item "$backup\automation\OrquestradorMigracao.ps1"                       "$repo\automation\" -Force
Copy-Item "$backup\.claude\skills\vfp9-migration\corretor-patterns.md"        "$repo\.claude\skills\vfp9-migration\" -Force
Copy-Item "$backup\.claude\skills\vfp9-migration\migration-patterns.md"       "$repo\.claude\skills\vfp9-migration\" -Force
Copy-Item "$backup\docs\framework_frmcadastro_layout.md"                      "$repo\docs\" -Force

Write-Host "Rollback concluido."
```

---

## 5. Riscos conhecidos

- **Falso-positivo #88 (`.Width = THIS.Width - 60`)**: so aplica em forms CRUD (arquivo contem `cnt_4c_Saida` ou `AS FormBase`). Forms OPERACIONAL nao sao afetados.
- **Falso-positivo #89 (botoes de saida genericos)**: so aplica em forms CRUD. Forms OPERACIONAL que tenham `cmd_4c_Sair` proprio com semantica diferente NAO sao afetados pelo gate CRUD.
- **Ampliacao #74 (LostFocus -> KeyPress)**: mais handlers passam a ser afetados. Se o handler NAO deveria mudar (raro), o cliente vai notar no primeiro form OPERACIONAL migrado; rollback trivial editando o BINDEVENT do handler de volta para "LostFocus" (nao vai ser re-corrigido porque o corretor so troca se o handler bate nas 3 heuristicas).

## 6. Projecao de impacto

Tasks 016-022 baseline: 1/7 "OK first try" (~14%), media ~2 edits manuais/task.
Projecao apos aplicacao: **3-4/7 OK first try (~50%)**, media ~0.5-1 edits/task. Detalhes em `feedback_saida_canonico_change_200426.md` na memoria.

---

## 7. Conteudo deste pacote

```
versao200426/
|-- README_DISTRIBUICAO.md      (este arquivo)
|-- CLAUDE.md                   (regra #10 nova)
|-- automation/
|   |-- CorretorAutomatico.ps1  (#74 ampliado, #88 novo, #89 novo)
|   |-- OrquestradorMigracao.ps1 (linha de precedencia canonica nos 3 blocos)
|-- docs/
|   |-- framework_frmcadastro_layout.md (cnt_4c_Saida canonico + regra #8)
|-- .claude/
    |-- skills/
        |-- vfp9-migration/
            |-- corretor-patterns.md (87 -> 89)
            |-- migration-patterns.md (secao #98)
```
