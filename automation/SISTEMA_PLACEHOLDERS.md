# Sistema de Placeholders - Substituição Automática

**Versão:** 1.0
**Data:** 2026-01-22

---

## 🎯 Objetivo

Este documento explica como o sistema substitui automaticamente os placeholders do `GERADOR_PROMPT_MIGRACAO.md` com valores específicos de cada task.

---

## 📋 Placeholders Disponíveis

### Formato: `{PLACEHOLDER}`

| Placeholder | Descrição | Exemplo de Valor |
|-------------|-----------|------------------|
| `{TASKID}` | ID da task | `task001` |
| `{BASENAME}` | Nome do arquivo original (sem extensão) | `SIGCDCOR` |
| `{FORMCLASS}` | Nome da classe Form no novo sistema | `FormCor` |
| `{BOCLASS}` | Nome da classe BO no novo sistema | `CorBO` |
| `{TXTFILE}` | Caminho absoluto do código fonte extraído | `C:\4c\tasks\task001\SIGCDCOR_codigo_fonte.txt` |
| `{TXTFILE_RELATIVE}` | Caminho relativo do código fonte | `tasks\task001\SIGCDCOR_codigo_fonte.txt` |
| `{MAPEAMENTO_FILE}` | Caminho absoluto do JSON de mapeamento | `C:\4c\tasks\task001\mapeamento.json` |
| `{MAPEAMENTO_RELATIVE}` | Caminho relativo do mapeamento | `tasks\task001\mapeamento.json` |
| `{TASKPATH}` | Diretório da task | `C:\4c\tasks\task001` |
| `{FORMPRG_PATH}` | Caminho onde FormXXX.prg será gerado | `C:\4c\projeto\app\forms\cadastros\FormCor.prg` |
| `{BOPRG_PATH}` | Caminho onde XXXBO.prg será gerado | `C:\4c\projeto\app\classes\CorBO.prg` |

---

## 🔄 Processo de Substituição

### Etapa 3 do Orquestrador (Gerar Meta-Prompt)

```powershell
function Invoke-Etapa03_GerarMetaPrompt {
    # 1. Le GERADOR_PROMPT_MIGRACAO.md
    $geradorContent = Get-Content -Path $geradorPath -Raw

    # 2. Determina nomes de classes (mapeamento ou inferência)
    $formClass = Get-FormClassName -BaseName $BaseName
    $boClass = Get-BOClassName -BaseName $BaseName

    # 3. Cria mapa de substituições
    $placeholders = @{
        '{TASKID}'           = $TaskId
        '{BASENAME}'         = $BaseName
        '{FORMCLASS}'        = $formClass
        '{BOCLASS}'          = $boClass
        # ... todos os outros
    }

    # 4. Substitui todos os placeholders
    $prompt = $geradorContent
    foreach ($key in $placeholders.Keys) {
        $prompt = $prompt -replace [regex]::Escape($key), $placeholders[$key]
    }

    # 5. Salva meta_prompt.md com valores substituídos
    $prompt | Set-Content -Path $metaPromptFile -Encoding UTF8
}
```

---

## 🏷️ Determinação de Nomes de Classes

### Método 1: Mapeamento Explícito (Recomendado)

**Arquivo:** `C:\4c\automation\class_mapping.json`

```json
{
  "mappings": {
    "SIGCDCOR": {
      "formClass": "FormCor",
      "boClass": "CorBO"
    }
  }
}
```

**Quando usar:**
- ✅ Nomes de classes não seguem padrão
- ✅ Casos especiais (relatórios, frameworks)
- ✅ Garantir consistência

**Vantagens:**
- Controle total
- Sem ambiguidade
- Fácil manutenção

---

### Método 2: Inferência Automática (Fallback)

**Regra para SIGCD*:**
```
SIGCDCOR → Remove "SIGCD" → "COR" → FormCor, CorBO
SIGCDPRO → Remove "SIGCD" → "PRO" → FormPro, ProBO
```

**Regra genérica:**
```
QUALQUER → FormQUALQUER, QUALQUERBO
```

**Quando usar:**
- ✅ Formulários seguem padrão SIGCD*
- ✅ Prototipagem rápida
- ⚠️ Sempre validar resultado

**Logs de inferência:**
```
[Mapeamento] SIGCDCOR -> FormCor     (usou class_mapping.json)
[Inferencia] SIGCDXYZ -> FormXYZ     (usou padrão SIGCD*)
```

---

## 📝 Exemplo Prático Completo

### Input: SIGCDCOR

#### Antes (GERADOR_PROMPT_MIGRACAO.md com placeholders):
```markdown
INPUT:
- Caminho do código fonte: {TXTFILE_RELATIVE}
- Nome do formulário legado: {BASENAME}
- Nome do novo formulário: {FORMCLASS}
- Nome do Business Object: {BOCLASS}
- JSON de mapeamento: {MAPEAMENTO_RELATIVE}

Você deve migrar o formulário **{BASENAME}** para a nova arquitetura.

Crie os seguintes arquivos:
1. {FORMPRG_PATH}
2. {BOPRG_PATH}

Baseie-se no código extraído em: {TXTFILE}
Use o mapeamento de objetos em: {MAPEAMENTO_FILE}
```

#### Depois (meta_prompt.md com valores substituídos):
```markdown
INPUT:
- Caminho do código fonte: tasks\task001\SIGCDCOR_codigo_fonte.txt
- Nome do formulário legado: SIGCDCOR
- Nome do novo formulário: FormCor
- Nome do Business Object: CorBO
- JSON de mapeamento: tasks\task001\mapeamento.json

Você deve migrar o formulário **SIGCDCOR** para a nova arquitetura.

Crie os seguintes arquivos:
1. C:\4c\projeto\app\forms\cadastros\FormCor.prg
2. C:\4c\projeto\app\classes\CorBO.prg

Baseie-se no código extraído em: C:\4c\tasks\task001\SIGCDCOR_codigo_fonte.txt
Use o mapeamento de objetos em: C:\4c\tasks\task001\mapeamento.json
```

---

## ⚙️ Como Adicionar Novos Placeholders

### 1. Adicionar ao Mapa de Substituições

**Arquivo:** `OrquestradorMigracao.ps1` → Função `Invoke-Etapa03_GerarMetaPrompt`

```powershell
$placeholders = @{
    # ... placeholders existentes ...

    # NOVO placeholder
    '{MEU_PLACEHOLDER}' = $meuValor
}
```

### 2. Usar no GERADOR_PROMPT_MIGRACAO.md

```markdown
Meu placeholder tem o valor: {MEU_PLACEHOLDER}
```

### 3. Documentar Aqui

| Placeholder | Descrição | Exemplo |
|-------------|-----------|---------|
| `{MEU_PLACEHOLDER}` | Descrição do novo placeholder | Exemplo de valor |

---

## 🔍 Debugging de Substituições

### Ver Quais Valores Foram Usados

**Logs da Etapa 3:**
```
[ETAPA 3] Gerar meta-prompt (GERADOR_PROMPT_MIGRACAO.md)

Meta-prompt gerado: C:\4c\tasks\task001\meta_prompt.md
  BaseName: SIGCDCOR
  FormClass: FormCor
  BOClass: CorBO
```

### Ver Meta-Prompt Final

```powershell
# Comparar original vs gerado
cat C:\4c\docs\GERADOR_PROMPT_MIGRACAO.md
cat C:\4c\tasks\task001\meta_prompt.md
```

### Validar Substituições

```powershell
# Procurar placeholders não substituídos
Select-String -Path "C:\4c\tasks\task001\meta_prompt.md" -Pattern '\{[A-Z_]+\}'

# Se encontrar algo, há placeholder faltando!
```

---

## 🚨 Erros Comuns

### Erro 1: Placeholder Não Substituído

**Sintoma:**
```markdown
# No meta_prompt.md você vê:
Nome do formulário: {FORMCLASS}
```

**Causa:** Placeholder não está no mapa de substituições

**Solução:**
1. Adicionar ao mapa em `Invoke-Etapa03_GerarMetaPrompt`
2. Ou corrigir typo no `GERADOR_PROMPT_MIGRACAO.md`

---

### Erro 2: Nome de Classe Incorreto

**Sintoma:**
```
[Inferencia] RELCORES -> FormCORES
# Mas deveria ser: RelatorioCores
```

**Causa:** Arquivo não está em `class_mapping.json`

**Solução:**
```json
// Adicionar em class_mapping.json:
"RELCORES": {
  "tipo": "REPORT",
  "reportClass": "RelatorioCores"
}
```

---

### Erro 3: Caminho Absoluto vs Relativo

**Problema:**
- Claude precisa de caminho relativo para ler arquivo
- Mas você quer mostrar caminho completo no log

**Solução:**
- Use `{TXTFILE}` para caminho absoluto (logs)
- Use `{TXTFILE_RELATIVE}` para caminho relativo (Claude)

---

## 📊 Tabela de Referência Rápida

| Situação | Placeholder a Usar |
|----------|-------------------|
| Mostrar nome do formulário legado | `{BASENAME}` |
| Mostrar nome da classe Form | `{FORMCLASS}` |
| Mostrar nome da classe BO | `{BOCLASS}` |
| Claude precisa ler arquivo TXT | `{TXTFILE_RELATIVE}` |
| Log mostrando caminho completo | `{TXTFILE}` |
| Claude precisa ler mapeamento | `{MAPEAMENTO_RELATIVE}` |
| Log mostrando onde salvar Form | `{FORMPRG_PATH}` |

---

## 🔧 Manutenção

### Adicionar Novo Mapeamento

```powershell
# 1. Editar class_mapping.json
notepad C:\4c\automation\class_mapping.json

# 2. Adicionar entrada:
"SIGCDXXX": {
  "formClass": "FormXXX",
  "boClass": "XXXBO"
}

# 3. Testar inferência:
cd C:\4c\automation
. .\OrquestradorMigracao.ps1  # Carrega funções
Get-FormClassName -BaseName "SIGCDXXX"
# Deve retornar: FormXXX
```

### Validar Todos os Mapeamentos

```powershell
# Script de validação (criar se necessário)
$mapping = cat C:\4c\automation\class_mapping.json | ConvertFrom-Json

foreach ($key in $mapping.mappings.PSObject.Properties.Name) {
    $item = $mapping.mappings.$key
    Write-Host "$key -> $($item.formClass), $($item.boClass)"

    # Validar se arquivos existem (opcional)
    $formPath = "C:\4c\projeto\app\forms\cadastros\$($item.formClass).prg"
    $boPath = "C:\4c\projeto\app\classes\$($item.boClass).prg"

    if (Test-Path $formPath) {
        Write-Host "  ✅ Form existe" -ForegroundColor Green
    }
    if (Test-Path $boPath) {
        Write-Host "  ✅ BO existe" -ForegroundColor Green
    }
}
```

---

## 📚 Arquivos Relacionados

| Arquivo | Propósito |
|---------|-----------|
| `OrquestradorMigracao.ps1` | Implementa substituição de placeholders |
| `GERADOR_PROMPT_MIGRACAO.md` | Template com placeholders |
| `class_mapping.json` | Mapeamento explícito de nomes |
| `SISTEMA_PLACEHOLDERS.md` | Este documento (documentação) |

---

## 🎓 Exemplos de Uso Avançado

### Placeholder Condicional

```markdown
# No GERADOR_PROMPT_MIGRACAO.md:

{{#if FORMCLASS == "FormProduto"}}
ATENÇÃO: Este formulário tem 10+ lookups complexos!
{{/if}}
```

⚠️ **Nota:** Condicionais não são suportados atualmente. Se necessário, criar meta-prompts específicos.

### Placeholder com Cálculo

```powershell
# Adicionar placeholder calculado:
$placeholders['{COMPLEXIDADE}'] = if ($numLookups -gt 5) { "ALTA" } else { "BAIXA" }
```

---

## ✅ Checklist de Implementação

Ao adicionar novo formulário para migração:

- [ ] Verificar se nome está em `class_mapping.json`
- [ ] Se não, adicionar mapeamento explícito
- [ ] Validar inferência: `Get-FormClassName -BaseName "XXX"`
- [ ] Executar migração de teste
- [ ] Verificar `meta_prompt.md` gerado (sem placeholders não substituídos)
- [ ] Confirmar que Claude recebeu valores corretos

---

**Última atualização:** 2026-01-22
**Versão:** 1.0
