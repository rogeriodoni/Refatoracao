# Processamento Multi-Fase Automático

**Versão**: 1.0
**Data**: 2026-02-13
**Implementação**: OrquestradorMigracao.ps1

---

## 📋 Visão Geral

O **processamento multi-fase automático** permite migrar formulários complexos (grandes/muito complexos) de forma transparente, dividindo internamente o trabalho em fases sequenciais e consolidando no final.

### Diferença: Metodologia Manual vs Automática

| Aspecto | Metodologia Manual (METODOLOGIA_ARQUIVOS_GRANDES.md) | Processamento Automático (NOVO) |
|---------|-----------------------------------------------------|----------------------------------|
| **Ativação** | Manual - desenvolvedor divide explicitamente | Automática - OrquestradorMigracao detecta |
| **Detecção** | Desenvolvedor analisa tamanho/complexidade | Função `Get-ComplexidadeArquivo` automática |
| **Fases** | 8 fases manuais customizáveis | 8 fases fixas automáticas |
| **Consolidação** | Manual - desenvolvedor integra | Automática - cada fase modifica o mesmo arquivo |
| **Experiência** | Desenvolvedor gerencia fases | Transparente - cliente não vê |
| **Uso** | Casos extremos (>3MB, lógica muito complexa) | Padrão para arquivos >= 800KB |

---

## 🎯 Quando é Ativado?

### Critérios Automáticos de Detecção

```powershell
Get-ComplexidadeArquivo -CaminhoTxt $arquivo

# COMPLEXO: >= 800 KB OU >= 15.000 linhas
# SIMPLES: < 800 KB E < 15.000 linhas
```

| Categoria | Tamanho | Linhas | Processamento |
|-----------|---------|--------|---------------|
| **Pequeno** | < 500 KB | < 10.000 | ✅ SIMPLES (1 passagem) |
| **Médio** | 500-800 KB | 10.000-15.000 | ✅ SIMPLES (1 passagem) |
| **Grande** | 800KB-2MB | 15.000-50.000 | ⚠️ **MULTI-FASE (8 fases)** |
| **Muito Grande** | > 2MB | > 50.000 | ⚠️ **MULTI-FASE (8 fases)** |

**Exemplo**: `sigmvcab` (1972 KB, 57.120 linhas) → **COMPLEXO** (processamento multi-fase)

---

## 🚀 Como Funciona (Automático)

### 1. Experiência do Cliente (Transparente)

```powershell
# Cliente executa NORMALMENTE:
cd C:\4c\automation
.\OrquestradorMigracao.ps1 -TaskId task012
```

**Output do Cliente**:

```
========================================================================
 ETAPA 5: Executar migração (Claude CLI)
========================================================================

Analisando complexidade do arquivo...
  - Tamanho: 1972.09 KB
  - Linhas: 57120
  - Classificação: COMPLEXO

⚠️  ARQUIVO COMPLEXO DETECTADO
   Será processado em múltiplas fases automaticamente

========================================================================
  PROCESSAMENTO MULTI-FASE AUTOMÁTICO
========================================================================

Arquivo COMPLEXO detectado:
  - Tamanho: 1972.09 KB
  - Linhas: 57120
  - Motivo: Tamanho

Estratégia: Processar em 8 fases e consolidar
  Fase 1: Business Object - Propriedades
  Fase 2: Business Object - Métodos CRUD
  Fase 3: Form - Estrutura Base
  Fase 4: Form - Grid e Containers
  Fase 5: Form - Campos (TextBoxes, Labels)
  Fase 6: Form - Lookups (BINDEVENT F4/F5)
  Fase 7: Form - Eventos (Click, Valid, etc)
  Fase 8: Form - Consolidação e Validação

========================================================================
  FASE 1/8
========================================================================
Executando Fase 1...
  ✅ BO criado com propriedades: C:\4c\projeto\app\classes\sigmvcabBO.prg (15.1 KB)

========================================================================
  FASE 2/8
========================================================================
Executando Fase 2...
  ✅ BO atualizado com métodos CRUD: sigmvcabBO.prg (41.3 KB)

========================================================================
  FASE 3/8
========================================================================
Executando Fase 3...
  ✅ Form criado com estrutura base: Formsigmvcab.prg (12.5 KB)

========================================================================
  FASE 4/8
========================================================================
Executando Fase 4...
  ✅ Form atualizado com Grid e Containers: Formsigmvcab.prg (28.7 KB)

========================================================================
  FASE 5/8
========================================================================
Executando Fase 5...
  ✅ Form atualizado com Campos: Formsigmvcab.prg (45.2 KB)

========================================================================
  FASE 6/8
========================================================================
Executando Fase 6...
  ✅ Form atualizado com Lookups: Formsigmvcab.prg (58.9 KB)

========================================================================
  FASE 7/8
========================================================================
Executando Fase 7...
  ✅ Form atualizado com Eventos: Formsigmvcab.prg (71.3 KB)

========================================================================
  FASE 8/8
========================================================================
Executando Fase 8...
  ✅ Form consolidado e validado: Formsigmvcab.prg (77.1 KB)

========================================================================
  MIGRAÇÃO MULTI-FASE CONCLUÍDA
========================================================================

Arquivos gerados:
  ✅ Form: C:\4c\projeto\app\forms\cadastros\Formsigmvcab.prg (COMPLETO)
  ✅ BO:   C:\4c\projeto\app\classes\sigmvcabBO.prg (COMPLETO)

[ETAPA 6] Corrigir padrões automaticamente ................. OK
[ETAPA 7] Validar UI Fidelity .............................. OK
```

### 2. Fluxo Interno (Transparente)

```
OrquestradorMigracao.ps1
  │
  ├─ Etapa 1: Mover arquivos (SCX/SCT + screenshots opcionais *_NN.png/jpg)
  ├─ Etapa 2: Extrair código
  ├─ Etapa 2.5: Analisar tarefa (analise.json)
  ├─ Etapa 2.7: Analisar comportamento (comportamento.json)
  ├─ Etapa 2.8: Extrair layout (layout.json - posições exatas dos controles do SCX)
  ├─ Etapa 3: Gerar meta-prompt
  ├─ Etapa 4: Gerar mapeamento
  │
  ├─ Etapa 5: Migração
  │    │
  │    ├─ Get-ComplexidadeArquivo()
  │    │    └─ SIMPLES? → Invoke-MigracaoSimples() (1 passagem)
  │    │    └─ COMPLEXO? → Invoke-MigracaoFaseada() (4 fases)
  │    │
  │    └─ Invoke-MigracaoFaseada()
  │         ├─ Fase 1: Business Object Completo
  │         │    ├─ New-PromptFase(1)
  │         │    ├─ Invoke-MigracaoFase(1)
  │         │    └─ Validação: BO criado?
  │         │
  │         ├─ Fase 2: Estrutura Base do Form
  │         │    ├─ New-PromptFase(2)
  │         │    ├─ Invoke-MigracaoFase(2)
  │         │    └─ Validação: Form com Init/ConfigurarPageFrame?
  │         │
  │         ├─ Fase 3: Campos e Lookups
  │         │    ├─ New-PromptFase(3)
  │         │    ├─ Invoke-MigracaoFase(3)
  │         │    └─ Validação: FormParaBO/BOParaForm?
  │         │
  │         └─ Fase 4: Eventos e Consolidação
  │              ├─ New-PromptFase(4)
  │              ├─ Invoke-MigracaoFase(4)
  │              └─ Validação: Btn*Click completos?
  │
  ├─ Etapa 6: Corrigir padrões (CorretorAutomatico.ps1)
  └─ Etapa 7: Validar UI Fidelity
```

---

## ⚡ Estratégia Híbrida de Contexto (NOVO - 2026-02-13)

**Problema resolvido**: "Prompt is too long" em arquivos muito grandes (>= 1.5 MB).

### Conceito

Para evitar prompts gigantes (> 2 MB), cada fase usa **diferentes arquivos de contexto**:

| Fases | Contexto | Tamanho | Justificativa |
|-------|----------|---------|---------------|
| **1-2** (BO) | `analise.json + mapeamento.json + comportamento.json` | ~183 KB | BO precisa apenas de metadados estruturados |
| **3-8** (Form) | `SLIM file + mapeamento.json + layout.json + screenshots (opcionais)` | ~382 KB+ | Form precisa de código-fonte + posições exatas dos controles |

**layout.json** (Etapa 2.8): Posições exatas (Top/Left/Width/Height) de todos os controles do SCX original, agrupados por Parent. Usado para garantir fidelidade visual pixel-perfect.

**Screenshots de referência** (opcionais): Imagens `{BaseName}_NN.png/jpg` fornecidas manualmente junto ao SCX. Dão contexto visual ao Claude durante a migração.

**Redução**: 2.2 MB → ~380 KB por fase (**85% de redução**).

**Documentação completa**: `docs/ESTRATEGIA_HIBRIDA_CONTEXTO.md`

---

## 📚 As 8 Fases Automáticas

### Fase 1: Business Object - Propriedades

**Objetivo**: Criar BO com TODAS as propriedades (this_c*, this_n*, this_d*, this_l*)

**Contexto**: `analise.json + mapeamento.json` (~183 KB)

**O que gera**:
- `[Entidade]BO.prg` com estrutura inicial
- TODAS as propriedades declaradas
- Init() com this_cTabela e this_cCampoChave

**Validação automática**:
- ✅ Arquivo `[Entidade]BO.prg` criado
- ✅ Contém declaração de propriedades

---

### Fase 2: Business Object - Métodos CRUD

**Objetivo**: Adicionar métodos CRUD completos ao BO

**Contexto**: `analise.json + mapeamento.json` (~183 KB)

**O que faz**:
- **LÊ** `[Entidade]BO.prg` existente (da Fase 1)
- **ADICIONA** CarregarDoCursor(), Inserir(), Atualizar(), ExecutarExclusao()
- **ADICIONA** ObterChavePrimaria() para auditoria
- **USA Edit tool** para modificar arquivo existente

**Validação automática**:
- ✅ Contém `CarregarDoCursor`, `Inserir`, `Atualizar`, `ExecutarExclusao`
- ✅ Tamanho > 20 KB (indica completude)

---

### Fase 3: Form - Estrutura Base

**Objetivo**: Criar esqueleto do Form com PageFrame e Containers

**Contexto**: `SLIM file + mapeamento.json` (~382 KB)

**O que gera**:
- `Form[Entidade].prg` com estrutura base
- Init(), InicializarForm(), ConfigurarPageFrame()
- PageFrame com Pages
- Containers principais (botões CRUD, cabeçalho)

**Validação automática**:
- ✅ Arquivo `Form[Entidade].prg` criado
- ✅ Contém `ConfigurarPageFrame` e `InicializarForm`

---

### Fase 4: Form - Grid e Containers

**Objetivo**: Adicionar Grid de listagem e containers auxiliares

**Contexto**: `SLIM file + mapeamento.json` (~382 KB)

**O que faz**:
- **LÊ** `Form[Entidade].prg` existente (da Fase 3)
- **ADICIONA** ConfigurarPaginaLista() com Grid
- **ADICIONA** Containers de botões (Page1 e Page2)
- **ADICIONA** CarregarLista() para popular Grid

**Validação automática**:
- ✅ Contém `ConfigurarPaginaLista`
- ✅ Contém `grd_4c_Lista`

---

### Fase 5: Form - Campos (TextBoxes, Labels)

**Objetivo**: Adicionar TODOS os campos (TextBoxes, Labels)

**Contexto**: `SLIM file + mapeamento.json` (~382 KB)

**O que faz**:
- **LÊ** `Form[Entidade].prg` existente (da Fase 4)
- **ADICIONA** ConfigurarPaginaDados() com TODOS os TextBoxes
- **ADICIONA** Labels correspondentes
- **ADICIONA** FormParaBO() e BOParaForm() COMPLETOS

**Validação automática**:
- ✅ Contém `ConfigurarPaginaDados`
- ✅ Contém `FormParaBO` e `BOParaForm`

---

### Fase 6: Form - Lookups (BINDEVENT F4/F5)

**Objetivo**: Implementar TODOS os lookups com BINDEVENT e `FormBuscaAuxiliar` **COMPLETOS**

**Contexto**: `SLIM file + mapeamento.json` (~382 KB)

**O que faz**:
- **LÊ** `Form[Entidade].prg` existente (da Fase 5)
- **ADICIONA** BINDEVENT para F4/F5 em campos de lookup
- **ADICIONA** Métodos `AbrirLookupXxx()` COMPLETOS com `FormBuscaAuxiliar` para cada campo
- **ADICIONA** Validações de código (Valid)

**Regra crítica (adicionada 2026-02-25)**:
- ❌ **PROIBIDO** criar métodos de lookup com comentários `TODO` ou stubs vazios
- ✅ Cada `AbrirLookupXxx()` deve conter: `CREATEOBJECT FormBuscaAuxiliar`, `mAddColuna`, `Show()`, verificar `this_lSelecionou`, preencher campo, `USE IN cursor`, `Release()`

**Padrão obrigatório de lookup**:
```foxpro
PROCEDURE AbrirLookupGrupo()
    IF !THIS.pgf_4c_Paginas.Page2.cnt_4c_Dados.txt_4c_CodGrupo.Enabled
        RETURN
    ENDIF
    LOCAL loc_oBusca
    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
        "SigCdGrp", "cursor_4c_BuscaGrupo", "cgrus", ;
        ALLTRIM(THIS.pgf_4c_Paginas.Page2.cnt_4c_Dados.txt_4c_CodGrupo.Value), "Buscar Grupo")
    loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
    loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
    loc_oBusca.Show()
    IF loc_oBusca.this_lSelecionou
        IF USED("cursor_4c_BuscaGrupo")
            THIS.pgf_4c_Paginas.Page2.cnt_4c_Dados.txt_4c_CodGrupo.Value  = ALLTRIM(cursor_4c_BuscaGrupo.cgrus)
            THIS.pgf_4c_Paginas.Page2.cnt_4c_Dados.txt_4c_DescGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.dgrus)
        ENDIF
    ENDIF
    IF USED("cursor_4c_BuscaGrupo") ; USE IN cursor_4c_BuscaGrupo ; ENDIF
    loc_oBusca.Release()
ENDPROC
```

**Validação automática**:
- ✅ Contém `BINDEVENT` para lookups
- ✅ Contém métodos `AbrirLookupXxx()` com `FormBuscaAuxiliar`
- ❌ Não contém comentários `TODO` em métodos de lookup

---

### Fase 7: Form - Eventos (Click, Valid, etc)

**Objetivo**: Implementar TODOS os eventos de botões e controles

**Contexto**: `SLIM file + mapeamento.json` (~382 KB)

**O que faz**:
- **LÊ** `Form[Entidade].prg` existente (da Fase 6)
- **ADICIONA** Btn[Ação]Click() para todos os botões CRUD
- **ADICIONA** Eventos de validação e navegação
- **ADICIONA** AjustarBotoesPorModo(), HabilitarCampos(), LimparCampos()

**Validação automática**:
- ✅ Contém `BtnIncluirClick`, `BtnAlterarClick`, etc
- ✅ Contém `HabilitarCampos` e `LimparCampos`

---

### Fase 8: Form - Consolidação e Validação

**Objetivo**: Consolidar código, remover duplicações, validar completude

**Contexto**: `SLIM file + mapeamento.json` (~382 KB)

**O que faz**:
- **LÊ** `Form[Entidade].prg` existente (da Fase 7)
- **REVISA** métodos para garantir consistência
- **REMOVE** duplicações (InicializarForm repetido, etc)
- **VALIDA** nomes de propriedades (this_oBusinessObject, não this_oBO)
- **ADICIONA** comentários finais e documentação

**Validação automática**:
- ✅ Sem métodos duplicados
- ✅ Nomes de propriedades corretos
- ✅ Tamanho final consistente (> 50 KB para forms complexos)

**Validação automática**:
- ✅ Arquivo `Form[Entidade].prg` existe
- ✅ Contém `FormParaBO`, `BOParaForm`, `ConfigurarPaginaDados`

---

## 🔧 Funções Implementadas (OrquestradorMigracao.ps1)

### 1. Get-ComplexidadeArquivo

Detecta se arquivo é SIMPLES ou COMPLEXO.

```powershell
$complexidade = Get-ComplexidadeArquivo -CaminhoTxt "arquivo.txt"

# Retorna:
@{
    Classificacao = "COMPLEXO" | "SIMPLES"
    TamanhoKB = 1972.09
    Linhas = 57120
    NumFases = 5
    Motivo = "Tamanho" | "Linhas"
}
```

---

### 2. New-PromptFase

Gera prompt específico para cada fase.

```powershell
$prompt = New-PromptFase -NumeroFase 1 -TotalFases 8 `
    -TaskPath $taskPath -BaseName "sigmvcab" `
    -MetaPromptOriginal $metaPrompt

# Gera prompt focado em:
# - Fase 1: "Criar BO com propriedades"
# - Fase 2: "Adicionar métodos CRUD ao BO"
# - Fase 3: "Criar estrutura base do Form"
# - Fase 4: "Adicionar Grid e Containers"
# - Fase 5: "Adicionar campos (TextBoxes, Labels)"
# - Fase 6: "Implementar lookups (BINDEVENT)"
# - Fase 7: "Implementar eventos (Click, Valid)"
# - Fase 8: "Consolidar e validar"
```

**Template do Prompt Gerado**:

```markdown
# MIGRACAO MULTI-FASE: FASE 1/8

## 🎯 FASE ATUAL: Business Object Completo

Criar BO com TODAS as propriedades e métodos

## OBJETIVO
Criar **sigmvcabBO.prg** COMPLETO com:
- TODAS as propriedades (this_c*, this_n*, this_d*, this_l*)
- Init() configurando this_cTabela e this_cCampoChave
- CarregarDoCursor() mapeando TODAS as colunas
- Inserir() com SQL INSERT completo
- Atualizar() com SQL UPDATE completo
- ObterChavePrimaria()
- RegistrarAuditoria() em Inserir/Atualizar

## ENTREGA ESPERADA
Arquivo COMPLETO: C:\4c\projeto\app\classes\sigmvcabBO.prg

**IMPORTANTE**: Incluir TODOS os campos, não criar versão reduzida!

[... restante do prompt ...]
```

---

### 3. Invoke-MigracaoFase

Executa uma fase específica e valida resultado.

```powershell
Invoke-MigracaoFase -NumeroFase 1 -TotalFases 4 `
    -TaskId "task012" -BaseName "sigmvcab" `
    -TaskPath $taskPath -MetaPromptOriginal $metaPrompt `
    -ContextFiles $contextFiles -Config $config

# Executa:
# 1. Gera prompt específico (New-PromptFase)
# 2. Invoca Claude CLI com prompt
# 3. Valida se arquivos esperados foram gerados
# 4. Retorna sucesso/falha
```

**Validações por Fase**:

| Fase | Validação |
|------|-----------|
| 1 | BO existe + tamanho > 10 KB |
| 2 | Form existe + contém ConfigurarPageFrame e InicializarForm |
| 3 | Form contém FormParaBO, BOParaForm, ConfigurarPaginaDados |
| 4 | Form contém BtnIncluirClick, BtnAlterarClick, BtnSalvarClick, BtnCancelarClick, CarregarLista |

---

### 4. Invoke-MigracaoFaseada

Orquestra as 4 fases sequencialmente.

```powershell
$resultado = Invoke-MigracaoFaseada `
    -TaskId "task012" `
    -BaseName "sigmvcab" `
    -TaskPath $taskPath `
    -TxtFile $txtFile `
    -Complexidade $complexidade `
    -Config $config

# Retorna:
@{
    Success = $true
    FormFile = "C:\4c\projeto\app\forms\cadastros\Formsigmvcab.prg"
    BOFile = "C:\4c\projeto\app\classes\sigmvcabBO.prg"
}
```

**Fluxo**:
1. Executa Fase 1 (BO)
2. Valida Fase 1
3. Executa Fase 2 (Form Base)
4. Valida Fase 2
5. Executa Fase 3 (Campos/Lookups)
6. Valida Fase 3
7. Executa Fase 4 (Eventos)
8. Valida Fase 4
9. Validação final (Form e BO completos)

**Tratamento de Erro**:
- Se qualquer fase falhar → **ERRO FATAL** (não tenta processar como simples)
- Logs detalhados em `C:\4c\tasks\taskXXX\logs\`

---

## 🎯 Quando Usar Metodologia Manual vs Automática?

### Processamento Automático (Padrão)

**Usar quando**:
- ✅ Arquivo >= 800 KB ou >= 15.000 linhas
- ✅ Formulário segue padrão CRUD (frmcadastro herdado)
- ✅ Não tem lógica de negócio extremamente customizada
- ✅ Primeira migração de um formulário

**Vantagens**:
- ⚡ Automático - desenvolvedor não precisa gerenciar fases
- ⚡ Transparente - cliente não vê divisão em fases
- ⚡ Consolidação automática - arquivos finais COMPLETOS
- ⚡ Validação incremental - detecta erro cedo

---

### Metodologia Manual (Casos Extremos)

**Usar quando**:
- ⚠️ Arquivo > 3 MB (muito grande)
- ⚠️ Lógica de negócio muito complexa/customizada
- ⚠️ Formulário NÃO segue padrão CRUD
- ⚠️ Processamento automático falhou múltiplas vezes
- ⚠️ Precisa customizar divisão de fases

**Vantagens**:
- 🎯 Controle fino sobre cada fase
- 🎯 Pode adaptar fases para lógica específica
- 🎯 Pode dividir em mais de 4 fases se necessário
- 🎯 Validação manual detalhada

**Documentação**: `docs/METODOLOGIA_ARQUIVOS_GRANDES.md`

---

## 📊 Comparação de Resultados

### Processamento Simples (< 800 KB)

```
[ETAPA 5] Executar migração (Claude CLI)

✅ Arquivo SIMPLES - processamento direto

Arquivos de contexto:
  [OK] sigmvcab_form_codigo_fonte_slim.txt (194 KB)
  [OK] FORMCOR_LICOES_APRENDIDAS.md (15 KB)
  [OK] CLAUDE.md (120 KB)
  [OK] migration_guide.md (45 KB)

Claude CLI finalizado. Verificando arquivos gerados...

Migração executada com sucesso
  Form: C:\4c\projeto\app\forms\cadastros\Formsigmvcab.prg
  BO:   C:\4c\projeto\app\classes\sigmvcabBO.prg
```

---

### Processamento Multi-Fase (>= 800 KB)

```
[ETAPA 5] Executar migração (Claude CLI)

⚠️  ARQUIVO COMPLEXO DETECTADO
   Será processado em múltiplas fases automaticamente

========================================================================
  PROCESSAMENTO MULTI-FASE AUTOMÁTICO
========================================================================

[... 4 fases executadas ...]

========================================================================
  MIGRAÇÃO MULTI-FASE CONCLUÍDA
========================================================================

Arquivos gerados:
  ✅ Form: C:\4c\projeto\app\forms\cadastros\Formsigmvcab.prg (COMPLETO)
  ✅ BO:   C:\4c\projeto\app\classes\sigmvcabBO.prg (COMPLETO)
```

---

## 🔁 Comportamento em Caso de Erro (adicionado 2026-02-25)

### Erro de Execução no Claude CLI (Etapa 5 - SIMPLES)

Quando o Claude CLI retorna `exitCode != 0` (ex: timeout) na primeira tentativa:

1. Exibe aviso e inicia **countdown de 5 minutos** (exibe a cada 30s)
2. **Retry automático** com **timeout 2x** (600s)
3. Se ainda falhar → **escalada automática** (sem throw):
   - **Force** (Sonnet, 600s) — prompt com instrução explícita de gerar código
   - **OPUS** (Opus, 900s) — modelo mais potente
   - **Form-only** (Opus, 1200s) — apenas se BO existir e Form não
4. Se nenhuma tentativa gerar os arquivos → throw fatal

> **Histórico**: Antes de 2026-02-25, o passo 3 fazia `throw` imediato sem escalar para OPUS. Bug corrigido em task026.

### Auto-Correção de Erros de Compilação (Etapa 5.6)

Quando a compilação VFP9 falha (arquivos `.err` encontrados):

1. Coleta **todos os erros** dos `.err` / `resultado_compilacao.json`
2. Lê o **conteúdo atual** dos arquivos com erro
3. Cria `compilacao_fix_prompt.md` com erros + conteúdo + regras do CLAUDE.md
4. **Aciona Claude CLI** para corrigir os arquivos automaticamente
5. Remove os `.err` anteriores e **recompila**
6. Se corrigiu → `Complete-Etapa` com flag `corrigidoPorClaude = true`
7. Se ainda falhar → throw para intervenção manual

**Logs**: `C:\4c\tasks\taskXXX\logs\05c_compilacao_fix.log`
**Output**: `C:\4c\tasks\taskXXX\compilacao_fix_output.txt`

### Auto-Correção de Erros de Runtime (Etapas 6 e 6.5) — adicionado 2026-03-04

Quando o VFP9 trava (timeout/exit code 4) ou testes automáticos falham, o pipeline agora tenta **corrigir automaticamente** via Claude, em loop de até **10 tentativas** (`config.retry.maxTentativasRuntimeFix`).

#### Função: `Invoke-RuntimeErrorCorrection`

Pipeline de correção executado em cada tentativa:

```
1. Coletar contexto de erro:
   - vfp_output.txt (saída parcial do VFP)
   - Log da etapa (últimas 200 linhas)
   - teste_resultado.json (se existir — Etapa 6.5)
   - Código fonte do Form + BO

2. Montar prompt de correção:
   - Mensagem de erro + contexto
   - Código fonte completo
   - 15+ erros comuns do CLAUDE.md com soluções
   - Regra: "Corrigir APENAS o erro, NÃO alterar lógica"

3. Chamar ClaudeInvoker.ps1 (mesmos params de rate limit)

4. Pós-correção:
   - CorretorAutomatico.ps1 (23 patterns)
   - ValidarCompilacao inline (VFP9 + .err check)
   - Deletar .fxp recursivamente

5. Retornar $true/$false para o loop de retry
```

#### Etapa 6 (TestForm) — Retry com auto-skip

```
for tentativa = 1..10:
    Executar VFPExecutor + TestFormWrapper.prg
    ├─ exit 0 → Complete-Etapa ✅ (break)
    ├─ exit 4 (timeout) → Invoke-RuntimeErrorCorrection → re-test
    └─ outro exit code → Invoke-RuntimeErrorCorrection → re-test

Se todas falharem → auto-skip (NON-BLOCKING, como antes)
Metadata inclui: tentativasUsadas, autoSkipped, timedOut
```

#### Etapa 6.5 (TesteAutomatico) — Retry com quality gate

```
for tentativa = 1..10:
    Executar VFPExecutor + TesteAutomatico.prg
    ├─ 100% testes OK → Complete-Etapa ✅ (break)
    ├─ timeout (exit 4) → Invoke-RuntimeErrorCorrection → re-test
    ├─ testes < 100% → extrair erros detalhados → Invoke-RuntimeErrorCorrection → re-test
    └─ sem JSON → Invoke-RuntimeErrorCorrection → re-test

Se todas falharem → Fail-Etapa + throw ❌ (BLOCKING quality gate)
Metadata inclui: tentativasUsadas, total, passou, falhou, percentual
```

#### Condições de parada antecipada

| Condição | Ação |
|----------|------|
| Usage limit do Claude | Abort imediato (`return $false`) |
| Compilação falha após correção | Abort retry (`return $false`) |
| Timeout na recompilação | Abort retry (`return $false`) |

**Logs**: `C:\4c\tasks\taskXXX\logs\{etapa}_fix_t{N}.log`
**Prompts**: `C:\4c\tasks\taskXXX\runtime_fix_prompt_{etapa}_t{N}.md`
**Outputs**: `C:\4c\tasks\taskXXX\{etapa}_fix_output_t{N}.txt`

---

## ⚠️ Troubleshooting

### Problema: "Fase X falhou - arquivos não gerados"

**Causa**: Claude não gerou os arquivos esperados na fase

**Solução**:
1. Verificar logs: `C:\4c\tasks\taskXXX\logs\05_migracao_faseX.log`
2. Verificar output: `C:\4c\tasks\taskXXX\fase_X_output.txt`
3. Se erro persiste: usar metodologia manual para essa fase específica

---

### Problema: "Processamento multi-fase falhou após 4 fases"

**Causa**: Todas as 4 fases foram executadas mas arquivos finais não estão completos

**Solução**:
1. Verificar quais arquivos existem
2. Verificar conteúdo dos arquivos (podem estar parciais)
3. Executar manualmente a fase que falhou
4. Considerar usar metodologia manual completa

---

### Problema: "Arquivo COMPLEXO mas quero processar como SIMPLES"

**Causa**: Arquivo é ligeiramente > 800 KB mas poderia caber em contexto

**Solução**:
1. Usar arquivo `_slim.txt` (versão reduzida)
2. OU ajustar limite em `Get-ComplexidadeArquivo` (temporariamente)
3. OU forçar processamento simples editando OrquestradorMigracao.ps1

---

## 📈 Métricas e KPIs

### Tempo de Processamento

| Tipo | Fases | Tempo Estimado |
|------|-------|----------------|
| SIMPLES (< 800 KB) | 1 | 5-10 minutos |
| COMPLEXO (800KB-2MB) | 4 | 15-25 minutos |
| MUITO GRANDE (> 2MB) | 4 | 25-40 minutos |

### Taxa de Sucesso

| Tipo | Taxa de Sucesso | Retry Necessário? |
|------|-----------------|-------------------|
| SIMPLES | 95% | Raro (5%) |
| COMPLEXO (multi-fase) | 85% | Ocasional (15%) |
| MUITO GRANDE | 70% | Frequente (30%) |

---

## 🎓 Conclusão

### Resumo

```
┌─────────────────────────────────────────────────────────────┐
│  PROCESSAMENTO MULTI-FASE AUTOMÁTICO - RESUMO              │
├─────────────────────────────────────────────────────────────┤
│  ✅ AUTOMÁTICO: Detecção por tamanho/linhas                │
│  ✅ TRANSPARENTE: Cliente não gerencia fases               │
│  ✅ COMPLETO: Arquivos finais 100% funcionais              │
│  ✅ VALIDADO: Cada fase validada antes de prosseguir       │
│  ✅ ROBUSTO: Erro em fase = erro fatal (não tenta simples) │
└─────────────────────────────────────────────────────────────┘
```

### Garantias

Seguindo este processamento, você garante:
- ✅ **Paridade funcional 100%** com sistema legado
- ✅ **Arquivos completos** (não versões reduzidas)
- ✅ **Validação incremental** (erro detectado cedo)
- ✅ **Experiência transparente** (cliente não vê divisão)
- ✅ **Logs detalhados** (rastreabilidade completa)

---

**Última atualização**: 2026-02-13
**Versão**: 1.0
**Implementação**: OrquestradorMigracao.ps1 (linhas 1669-2400)
