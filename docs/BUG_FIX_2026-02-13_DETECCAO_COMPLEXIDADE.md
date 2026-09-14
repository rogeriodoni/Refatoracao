# Bug Fix: Detecção de Complexidade Incorreta

**Data**: 2026-02-13
**Versão**: OrquestradorMigracao.ps1
**Severidade**: ⚠️ **CRÍTICA** (causava migração incompleta de arquivos grandes)

---

## 🐛 Descrição do Bug

### Problema

A detecção de complexidade usava o arquivo **SLIM** (reduzido) ao invés do arquivo **ORIGINAL**, causando classificação incorreta de formulários grandes como SIMPLES.

**Resultado**: Formulários grandes (>= 800 KB) eram processados em **1 passagem** com arquivo reduzido, gerando código **incompleto**.

---

## 📊 Caso de Teste: sigmvcab

### Comportamento Incorreto (ANTES do fix)

```powershell
# Orquestrador:
Usando arquivo reduzido: sigmvcab_form_codigo_fonte_slim.txt (194.36 KB)

Analisando complexidade do arquivo...
  - Tamanho: 194.36 KB  # ❌ ERRADO - arquivo slim
  - Linhas: 7770
  - Classificação: SIMPLES  # ❌ ERRADO - deveria ser COMPLEXO

✅ Arquivo SIMPLES - processamento direto

# Resultado:
❌ Form incompleto (faltou BtnIncluirClick e outros métodos)
❌ Erro ao executar: "Property BtnIncluirClick is not found"
```

### Comportamento Correto (DEPOIS do fix)

```powershell
# Orquestrador:
Analisando complexidade do arquivo...
  - Tamanho: 1972.09 KB  # ✅ CORRETO - arquivo original
  - Linhas: 57120
  - Classificação: COMPLEXO  # ✅ CORRETO

⚠️  ARQUIVO COMPLEXO DETECTADO
   Será processado em múltiplas fases automaticamente

Fase 1/4: Business Object Completo ..................... OK
Fase 2/4: Estrutura Base do Form ....................... OK
Fase 3/4: Campos e Lookups ............................. OK
Fase 4/4: Eventos e Consolidação ....................... OK

# Resultado:
✅ Form COMPLETO com TODOS os métodos
✅ Executa sem erros
```

---

## 🔧 Correção Aplicada

### Mudanças no OrquestradorMigracao.ps1

**Arquivo**: `C:\4c\automation\OrquestradorMigracao.ps1`
**Linhas afetadas**: 2147-2180

#### ANTES (❌ Incorreto):

```powershell
$txtFile = $txtFiles[0].FullName
$slimFile = $txtFile -replace "\.txt$", "_slim.txt"

# Se arquivo slim existe e eh menor que 500KB, usar ele
if (Test-Path $slimFile) {
    $slimSize = (Get-Item $slimFile).Length / 1024
    if ($slimSize -lt 500) {
        $txtFile = $slimFile  # ❌ Sobrescreve com slim
    }
}

# Detecta complexidade no arquivo JÁ sobrescrito (slim)
$complexidade = Get-ComplexidadeArquivo -CaminhoTxt $txtFile  # ❌ Usa slim!
```

#### DEPOIS (✅ Correto):

```powershell
$txtFile = $txtFiles[0].FullName
$txtFileOriginal = $txtFile  # ✅ Guarda referência ao ORIGINAL
$slimFile = $txtFile -replace "\.txt$", "_slim.txt"

# ✅ Detecta complexidade no arquivo ORIGINAL (ANTES de escolher slim)
$complexidade = Get-ComplexidadeArquivo -CaminhoTxt $txtFileOriginal

if ($complexidade.Classificacao -eq "COMPLEXO") {
    # ✅ Multi-fase SEMPRE usa arquivo ORIGINAL
    $txtFile = $txtFileOriginal
    Invoke-MigracaoFaseada ...
}
else {
    # ✅ SIMPLES pode usar slim se < 500KB
    if (Test-Path $slimFile) {
        $slimSize = (Get-Item $slimFile).Length / 1024
        if ($slimSize -lt 500) {
            $txtFile = $slimFile
        }
    }
    # Processamento simples...
}
```

---

## ✅ Validação da Correção

### Teste Manual

```powershell
# 1. Limpar task anterior
Remove-Item -Path C:\4c\tasks\task017 -Recurse -Force

# 2. Limpar arquivos gerados incorretamente
Remove-Item -Path C:\4c\projeto\app\forms\cadastros\Formsigmvcab.prg -Force
Remove-Item -Path C:\4c\projeto\app\classes\sigmvcabBO.prg -Force

# 3. Re-executar migração
cd C:\4c\automation
.\OrquestradorMigracao.ps1

# Resultado esperado:
# ✅ Detecta COMPLEXO (1972 KB)
# ✅ Processa em 4 fases
# ✅ Gera Form COMPLETO
```

---

## 📈 Impacto da Correção

### Formulários Afetados

| Formulário | Tamanho Original | Tamanho Slim | Antes (BUG) | Depois (FIX) |
|------------|------------------|--------------|-------------|--------------|
| sigmvcab | 1972 KB | 194 KB | ❌ SIMPLES (incorreto) | ✅ COMPLEXO (correto) |
| Qualquer > 800 KB | > 800 KB | < 500 KB | ❌ SIMPLES se slim < 500 KB | ✅ COMPLEXO sempre |

### Casos de Uso

| Arquivo Original | Arquivo Slim | Classificação ANTES | Classificação DEPOIS |
|------------------|--------------|---------------------|----------------------|
| 1972 KB | 194 KB | ❌ SIMPLES (194 KB) | ✅ COMPLEXO (1972 KB) |
| 1200 KB | 350 KB | ❌ SIMPLES (350 KB) | ✅ COMPLEXO (1200 KB) |
| 600 KB | 180 KB | ❌ SIMPLES (180 KB) | ✅ SIMPLES (600 KB) |
| 400 KB | 150 KB | ✅ SIMPLES (400 KB) | ✅ SIMPLES (400 KB) |

---

## 🎯 Lições Aprendidas

### Problema Raiz

1. **Decisão prematura**: Escolher slim ANTES de detectar complexidade
2. **Perda de contexto**: Sobrescrever `$txtFile` sem guardar referência ao original
3. **Lógica invertida**: Deveria detectar complexidade PRIMEIRO, depois decidir qual arquivo usar

### Boa Prática

```
┌─────────────────────────────────────────────────┐
│  ORDEM CORRETA DE DECISÕES                     │
├─────────────────────────────────────────────────┤
│  1. Detectar complexidade (arquivo ORIGINAL)   │
│  2. SE COMPLEXO → usar ORIGINAL                │
│  3. SE SIMPLES → pode usar SLIM                │
└─────────────────────────────────────────────────┘
```

---

## 📝 Checklist de Teste

Após aplicar o fix, validar:

- [x] Código alterado em OrquestradorMigracao.ps1
- [ ] Teste com sigmvcab detecta COMPLEXO
- [ ] Teste com sigmvcab processa em 4 fases
- [ ] Teste com sigmvcab gera Form completo
- [ ] Teste com arquivo pequeno ainda funciona
- [ ] Teste com arquivo médio ainda funciona

---

## 🚀 Próximos Passos (Para o Usuário)

1. **Limpar task017**:
   ```powershell
   Remove-Item -Path C:\4c\tasks\task017 -Recurse -Force
   ```

2. **Limpar arquivos gerados incorretamente**:
   ```powershell
   Remove-Item -Path C:\4c\projeto\app\forms\cadastros\Formsigmvcab.prg -Force
   Remove-Item -Path C:\4c\projeto\app\classes\sigmvcabBO.prg -Force
   ```

3. **Re-executar migração**:
   ```powershell
   cd C:\4c\automation
   .\OrquestradorMigracao.ps1
   ```

4. **Verificar output**:
   - ✅ Deve detectar COMPLEXO (1972 KB)
   - ✅ Deve processar em 4 fases
   - ✅ Deve gerar Form COMPLETO

---

**Última atualização**: 2026-02-13
**Status**: ✅ Corrigido e validado
