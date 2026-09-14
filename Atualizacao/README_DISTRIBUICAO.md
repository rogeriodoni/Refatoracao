# versao210426 — Distribuicao para cliente

**Data:** 2026-04-21
**Fonte:** `C:\4c`
**Requer:** `versao200426` ja aplicada (baseline das Changes 1+2).
**Objetivo:** Corrigir 5 gaps descobertos na analise do log do task016 (SigCdCol) + fixes pontuais no FormCol.prg/ColBO.prg.

---

## 1. O que mudou

### Fixes sistemicos (pipeline)

| Arquivo | Mudanca |
|---|---|
| `automation/CorretorAutomatico.ps1` | **#74 ampliado (4a heuristica)**: detecta handler com nome terminando em `LostFocus` (ex: `UsuarsLostFocus`). Fecha gap descoberto no task016. |
| `automation/CorretorAutomatico.ps1` | **Novo #90 `Corrigir-MostrarAvisoInexistente`**: `MostrarAviso(...)` -> `MsgAviso(...)`. Funcao `MostrarAviso` nao existe — gerador inventou. Substituicao direta e segura. |
| `automation/CorretorAutomatico.ps1` | **Novo #91 `Corrigir-SQLExecCursorGuard`**: injeta `IF USED(cursor)/TABLEREVERT/USE IN/ENDIF` antes de `SQLEXEC(...,"cursor_4c_*")` em BOs. Evita "Table buffer contains uncommitted changes". |
| `automation/OrquestradorMigracao.ps1` | 4 novas regras nos 3 blocos de prompt (OPERACIONAL, Phase A, Phase B): (a) PUBLIC invalido em DEFINE CLASS, (b) Page.Width/Height read-only, (c) MostrarAviso nao existe, (d) SQLEXEC cursor-guard. |
| `CLAUDE.md` | Novas regras **#9.1** (PUBLIC DEFINE CLASS), **#9.2** (Page.Width read-only), **#9.3** (MostrarAviso nao existe). |
| `.claude/skills/vfp9-migration/corretor-patterns.md` | Contador 89 -> 91. Novas entradas #90, #91. Nota ampliada em #74. |
| `.claude/skills/vfp9-migration/migration-patterns.md` | Novas secoes **#99** (VFP9 gotchas) e **#100** (SQLEXEC cursor guard) com exemplos de codigo ERRADO vs CORRETO. |

### Fixes pontuais (codigo do cliente — task016)

| Arquivo | Mudanca |
|---|---|
| `projeto/app/forms/cadastros/FormCol.prg` | 6× `MostrarAviso(...)` -> `MsgAviso(...)` (linhas 1051, 1074, 1098, 1142, 1148, 1191) |
| `projeto/app/classes/ColBO.prg` | Guard `USED/TABLEREVERT/USE IN` adicionado antes do SQLEXEC em `Buscar()` (linha 53) |

---

## 2. Como aplicar na maquina do cliente

```powershell
$repo = "C:\4c"   # ajustar se o repo do cliente estiver em outro path
$origem = "C:\4c\versao210426"
$ts = Get-Date -Format "yyyyMMdd_HHmmss"
$backup = Join-Path $repo "_backup_pre_210426_$ts"

# Backup dos arquivos que serao sobrescritos
New-Item -ItemType Directory -Force -Path (Join-Path $backup "automation") | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $backup ".claude\skills\vfp9-migration") | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $backup "projeto\app\forms\cadastros") | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $backup "projeto\app\classes") | Out-Null

Copy-Item "$repo\CLAUDE.md"                                           "$backup\"
Copy-Item "$repo\automation\CorretorAutomatico.ps1"                   "$backup\automation\"
Copy-Item "$repo\automation\OrquestradorMigracao.ps1"                 "$backup\automation\"
Copy-Item "$repo\.claude\skills\vfp9-migration\corretor-patterns.md"  "$backup\.claude\skills\vfp9-migration\"
Copy-Item "$repo\.claude\skills\vfp9-migration\migration-patterns.md" "$backup\.claude\skills\vfp9-migration\"
if (Test-Path "$repo\projeto\app\forms\cadastros\FormCol.prg") {
    Copy-Item "$repo\projeto\app\forms\cadastros\FormCol.prg"         "$backup\projeto\app\forms\cadastros\"
}
if (Test-Path "$repo\projeto\app\classes\ColBO.prg") {
    Copy-Item "$repo\projeto\app\classes\ColBO.prg"                   "$backup\projeto\app\classes\"
}

Write-Host "Backup criado em: $backup"

# Aplicar as mudancas
Copy-Item "$origem\CLAUDE.md"                                           "$repo\" -Force
Copy-Item "$origem\automation\CorretorAutomatico.ps1"                   "$repo\automation\" -Force
Copy-Item "$origem\automation\OrquestradorMigracao.ps1"                 "$repo\automation\" -Force
Copy-Item "$origem\.claude\skills\vfp9-migration\corretor-patterns.md"  "$repo\.claude\skills\vfp9-migration\" -Force
Copy-Item "$origem\.claude\skills\vfp9-migration\migration-patterns.md" "$repo\.claude\skills\vfp9-migration\" -Force
Copy-Item "$origem\projeto\app\forms\cadastros\FormCol.prg"             "$repo\projeto\app\forms\cadastros\" -Force
Copy-Item "$origem\projeto\app\classes\ColBO.prg"                       "$repo\projeto\app\classes\" -Force

Write-Host "versao210426 aplicada."
```

---

## 3. Validacao pos-aplicacao

```powershell
# 1) Parser dos .ps1
powershell -NoProfile -Command "& { `$tokens=`$null; `$errors=`$null; [System.Management.Automation.Language.Parser]::ParseFile('C:\4c\automation\CorretorAutomatico.ps1', [ref]`$tokens, [ref]`$errors) | Out-Null; if (`$errors.Count -gt 0) { `$errors | ForEach-Object { Write-Host ('[SYNTAX] Line ' + `$_.Extent.StartLineNumber + ': ' + `$_.Message) } } else { Write-Host 'CorretorAutomatico OK' } }"

# 2) Deletar .fxp antes de re-testar FormCol
Get-ChildItem -Path "C:\4c\projeto\app" -Filter "*.fxp" -Recurse | Remove-Item -Force

# 3) Testar FormCol no VFP9
# abrir main.prg, menu Cadastros -> Grupo de Venda, clicar Buscar, Incluir, salvar
```

Esperado depois do fix:
- Buscar deve retornar grid sem "Table buffer contains uncommitted changes"
- BtnSalvarClick com campo vazio deve mostrar dialog amarelo "Grupo invalido" (MsgAviso), nao erro "mostraraviso.prg not exist"

---

## 4. Rollback

```powershell
$repo = "C:\4c"
$backup = "C:\4c\_backup_pre_210426_YYYYMMDD_HHMMSS"   # usar pasta real

Copy-Item "$backup\CLAUDE.md"                                           "$repo\" -Force
Copy-Item "$backup\automation\CorretorAutomatico.ps1"                   "$repo\automation\" -Force
Copy-Item "$backup\automation\OrquestradorMigracao.ps1"                 "$repo\automation\" -Force
Copy-Item "$backup\.claude\skills\vfp9-migration\corretor-patterns.md"  "$repo\.claude\skills\vfp9-migration\" -Force
Copy-Item "$backup\.claude\skills\vfp9-migration\migration-patterns.md" "$repo\.claude\skills\vfp9-migration\" -Force
if (Test-Path "$backup\projeto\app\forms\cadastros\FormCol.prg") {
    Copy-Item "$backup\projeto\app\forms\cadastros\FormCol.prg"         "$repo\projeto\app\forms\cadastros\" -Force
}
if (Test-Path "$backup\projeto\app\classes\ColBO.prg") {
    Copy-Item "$backup\projeto\app\classes\ColBO.prg"                   "$repo\projeto\app\classes\" -Force
}
Write-Host "Rollback concluido."
```

---

## 5. Riscos conhecidos

- **#90 `MostrarAviso` -> `MsgAviso`**: substituicao direta, risco zero (funcao nunca existe).
- **#91 `SQLExecCursorGuard`**: so injeta se nao houver guard nas 10 linhas anteriores. Aplica apenas em BOs (`FUNCTION Buscar` ou `FUNCTION CarregarPorCodigo`). Se por algum motivo o cursor for proposital para receber buffer, desativar manualmente.
- **#74 4a heuristica**: mais handlers sao afetados. Se for um handler que NAO deve mudar (raro), BINDEVENT fica KeyPress; basta reverter manualmente.

## 6. Conteudo

```
versao210426/
|-- README_DISTRIBUICAO.md      (este arquivo)
|-- CLAUDE.md                   (regras #9.1, #9.2, #9.3 novas)
|-- automation/
|   |-- CorretorAutomatico.ps1  (#74 4a heuristica, #90 e #91 novos)
|   |-- OrquestradorMigracao.ps1 (4 novas regras nos prompts)
|-- .claude/
|   |-- skills/vfp9-migration/
|       |-- corretor-patterns.md (89 -> 91)
|       |-- migration-patterns.md (secoes #99 e #100)
|-- projeto/app/
    |-- forms/cadastros/FormCol.prg  (6× MostrarAviso -> MsgAviso)
    |-- classes/ColBO.prg            (guard SQLEXEC)
```

---

## 7. Projecao de impacto agregada (v200426 + v210426)

Baseline original (tasks 016-022): 1/7 "OK first try" (~14%), media ~2 edits/task.

Com ambas aplicadas:
- **~60-70% OK first try**
- Elimina os **2 retries caros do task016** (~12 min/form)
- 7 patterns de auto-fix a mais para casos recorrentes
- Tres regras novas no prompt evitam bugs de syntax VFP9 (PUBLIC, Page.Width, MostrarAviso)
