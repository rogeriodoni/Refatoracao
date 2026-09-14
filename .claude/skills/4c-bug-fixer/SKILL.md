---
name: 4c-bug-fixer
description: Skill global para correção de bugs com ciclo completo: leitura de documentação, análise de logs, planejamento, criação de branch, commit, push, PR e loop de code-review até resolução de issues críticas/bloqueantes. Use sempre que o usuário fornecer logs de erro, descrever um cenário de bug, mencionar "corrigir bug", "fix", "erro em produção", "exception", "crash", "falha", "comportamento inesperado", ou pedir para resolver um problema em código com base em evidências (logs, stack traces, prints). Também deve ser usado quando houver pontos de atenção técnicos que precisem de investigação antes da correção.
---

# Bug Fixer - VFP9 Migration Manual Test Feedback

Skill para processar feedback de teste manual de forms VFP9 migrados. O testador cola um screenshot e descreve os problemas que percebe. A skill localiza os arquivos, diagnostica as causas e aplica as correções.

## Workflow

### Passo 1: Identificar o Form e os Arquivos

A partir do screenshot ou da descrição do testador, identificar:

1. **Nome do form** - visível no Caption da janela ou informado pelo testador
2. **Task ID** - se informado, ou buscar pela task mais recente do form
3. **Localizar arquivos**:
   - Form: `C:\4c\projeto\app\forms\{cadastros|operacionais|relatorios}\Form*.prg`
   - BO: `C:\4c\projeto\app\classes\*BO.prg`
   - Código original: `C:\4c\tasks\task{NNN}\*_form_codigo_fonte.txt`
   - Layout original: `C:\4c\tasks\task{NNN}\layout.json`
   - Screenshots referência: `C:\4c\tasks\task{NNN}\*_01.png`, `*_02.png`
   - Análise: `C:\4c\tasks\task{NNN}\analise.json`

**Como encontrar a task**:
```powershell
# Buscar pela task mais recente do form
Get-ChildItem C:\4c\tasks -Directory | Sort-Object Name -Descending | ForEach-Object {
    $analise = Join-Path $_.FullName "analise.json"
    if (Test-Path $analise) {
        $json = Get-Content $analise -Raw | ConvertFrom-Json
        if ($json.form.baseName -eq "sigopind") { $_.Name }
    }
} | Select-Object -First 1
```

### Passo 2: Classificar os Problemas

Cada problema reportado pelo testador deve ser classificado em uma categoria:

| Categoria | Exemplos | Causa Provável |
|-----------|----------|----------------|
| **RUNTIME_ERROR** | "Variable X not found", "Property X not found" | Campo omitido no SELECT, propriedade VFP inexistente, cursor com nome errado |
| **LAYOUT_VISUAL** | "Botões desalinhados", "controles fora de lugar" | Top/Left/Width/Height incorretos, compensação +29 errada |
| **GRID_VISUAL** | "Sem barras verticais", "colunas desalinhadas" | GridLines, ColumnWidths, HeaderHeight incorretos |
| **ICON_MISSING** | "Botões sem ícones", "quadrados vazios" | Picture path incorreto, ícone inexistente |
| **CAPTION_WRONG** | "Texto errado", "label vazio" | Caption não definido ou com encoding errado |
| **BEHAVIOR** | "Botão não funciona", "lookup não abre" | BINDEVENT faltando, método não implementado |
| **DATA** | "Grid vazio", "dados não carregam" | Query SQL errada, cursor com nome diferente |

### Passo 3: Diagnosticar Cada Problema

Para cada problema, seguir este checklist:

#### RUNTIME_ERROR
1. Ler a mensagem de erro EXATA (Variable/Property X not found)
2. Grep pelo nome da variável/propriedade no .prg e no BO
3. Grep no código original para entender de onde vem
4. Comparar: cursor do BO vs cursor esperado pelo form (nome e colunas)
5. Fix: adicionar campo ao SELECT, corrigir nome do cursor, ou remover propriedade inexistente

#### LAYOUT_VISUAL
1. Ler layout.json para posições originais
2. Comparar com as posições no .prg gerado
3. Verificar compensação PageFrame.Top=-29 (adicionar +29 a controles dentro de Page)
4. Verificar se controles estão no container correto
5. Fix: ajustar Top/Left/Width/Height para valores do layout.json

#### GRID_VISUAL
1. Verificar `GridLines` property (0=ambas, 1=horizontal, 2=vertical, 3=nenhuma)
2. Verificar `DeleteMark`, `RecordMark`
3. Verificar `ColumnCount` e `ColumnWidths`
4. Comparar com o original (grep no codigo_fonte.txt)
5. Fix: ajustar propriedades do grid

#### ICON_MISSING
1. Verificar se `.Picture = gc_4c_CaminhoIcones + "nome.jpg"` está correto
2. Verificar se o arquivo de ícone existe em `C:\4c\vbmp\`
3. Comparar com o original para nome correto do ícone
4. Fix: corrigir path ou nome do ícone

#### DATA (cursor nome diferente)
1. Comparar nome do cursor no BO vs nome usado no form (RecordSource, ControlSource)
2. No original, grep pelo nome do cursor (ex: CrSigMvCcr, CrSigMvSlc)
3. **REGRA**: O nome do cursor no BO deve ser IDÊNTICO ao esperado pelo form
4. Fix: renomear cursor no BO, ou ajustar RecordSource no form

### Passo 4: Aplicar Correções

1. **Ler** o arquivo antes de editar (OBRIGATÓRIO)
2. **Editar** usando Edit tool com contexto suficiente para match único
3. **Limpar .fxp**: `Get-ChildItem -Path "C:\4c\projeto\app" -Filter "*.fxp" -Recurse | Remove-Item -Force`
4. **Validar compilação**: executar VFP9 para compilar se possível

### Passo 5: Verificar com o Original

Para CADA correção, verificar no código original (`*_form_codigo_fonte.txt`) que:
- Nomes de tabelas/colunas são EXATOS (NUNCA inventar)
- Valores de propriedades visuais são EXATOS
- Lógica de negócio preserva o comportamento original

### Passo 6: Perguntar se Deve Propagar

Após corrigir, perguntar ao testador:
> "Correções aplicadas. Quer que eu propague as lições aprendidas para o pipeline (CorretorAutomatico, prompts, skill)?"

Se sim, invocar a skill `propagate-lesson` para cada lição nova.

## Padrões Comuns de Bugs

### Cursor com nome diferente entre BO e Form
```
CAUSA: BO cria cursor_4c_Dados, form espera CrSigMvCcr
FIX: Alinhar nomes - usar o nome que o original usava
```

### SELECT omitindo colunas
```
CAUSA: LLM não incluiu todas as colunas no SELECT do BO
FIX: Comparar colunas usadas no form (grep ControlSource + referências diretas) com o SELECT do BO
VERIFICAR: Código original para lista completa de colunas
```

### Propriedade VFP inexistente
```
CAUSA: LLM inventou propriedade (BackStyle em CommandButton, TabStyle em PageFrame)
FIX: Remover a linha. Verificar em hackfox.github.io se a propriedade existe para o tipo de controle
```

### Ícones sem caminho correto
```
CAUSA: Nome do ícone diferente do original, ou path sem gc_4c_CaminhoIcones
FIX: Copiar nome EXATO do original. Path: gc_4c_CaminhoIcones + "nome_exato.jpg"
```

### GridLines incorreto
```
CAUSA: VFP9 GridLines: 0=ambas, 1=horizontal, 2=vertical, 3=nenhuma
FIX: Copiar valor EXATO do original, ou usar 0 (padrão com ambas)
NOTA: Se original não define GridLines, o default do Framework pode ser diferente
```

## Exemplo de Interação

**Testador**:
> "Erro ao consultar histórico: Variable USUARS not found. Botões desalinhados no canto."
> [cola screenshot]

**Skill**:
1. Identifica form: Formsigopind (task173)
2. Classifica: RUNTIME_ERROR (USUARS) + LAYOUT_VISUAL (botões)
3. Diagnóstico USUARS: BO.BuscarHistorico SELECT não inclui coluna Usuars
4. Diagnóstico layout: Compara layout.json com .prg, encontra Top divergente
5. Aplica fixes
6. Pergunta sobre propagação
