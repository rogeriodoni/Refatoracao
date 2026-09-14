# Gerador de Prompts de Migração - Meta-Prompt

**Objetivo**: Analisar qualquer task e gerar automaticamente um prompt estruturado para migração, aplicando todas as lições aprendidas.

---

## 🎯 Meta-Prompt (Copiar e Colar no Claude Code)

```
Preciso que você ANALISE uma task de migração e GERE um prompt estruturado para refazê-la.

═══════════════════════════════════════════════════════════════
FASE 1: ANÁLISE DA TASK
═══════════════════════════════════════════════════════════════

INPUT:
- Caminho do código fonte: {TXTFILE_RELATIVE}
- Nome do formulário legado: {BASENAME}
- Nome do novo formulário: {FORMCLASS}
- Nome do Business Object: {BOCLASS}
- JSON de mapeamento: {MAPEAMENTO_RELATIVE}
- Caminho completo do TXT: {TXTFILE}
- Caminho da task: {TASKPATH}

ANÁLISE OBRIGATÓRIA:

1. CAMPOS (ControlSource):
   Procurar por padrão: ControlSource = "cursor.campo"
   Identificar:
   - Nome do campo
   - Tipo (C=char, N=numeric, D=date, L=logical)
   - Tamanho (InputMask, Width)
   - Obrigatório? (verificar validações)

   Extrair para TABELA:
   | Campo Form | Campo BD | Tipo | Tamanho | Obrigatório | Propriedade BO |
   |------------|----------|------|---------|-------------|----------------|
   | txt_4c_Codigo | cods | C | 20 | Sim | this_cCodigo |
   | ... | ... | ... | ... | ... | ... |

2. LOOKUPS (CRÍTICO):
   Procurar por:
   - CreateObject('fwbuscaext'
   - CreateObject('fwBuscaSel'
   - sigacess(
   - PROCEDURE Valid (dentro de TextBox)
   - PROCEDURE KeyPress (F4 = 286, F5 = 287)

   Extrair para TABELA:
   | Campo | Tabela Lookup | Campo Código | Campo Descrição | Tecla | Padrão |
   |-------|---------------|--------------|-----------------|-------|--------|
   | txt_4c_Grupo | SigCdGrp | cgrus | dgrus | F4 | fwbuscaext |
   | ... | ... | ... | ... | ... | ... |

3. VALIDAÇÕES:
   Procurar por:
   - PROCEDURE Valid (validações inline)
   - INLIST(valor, "S", "N")
   - RETURN .F. (bloqueio)
   - Empty(), Len(), Between()

   Extrair para TABELA:
   | Campo | Tipo Validação | Regra | Mensagem Erro |
   |-------|----------------|-------|---------------|
   | txt_4c_TipoCor | Enum | S/N apenas | "Tipo deve ser S ou N" |
   | ... | ... | ... | ... |

4. GRIDS:
   Procurar por:
   - ColumnCount = N
   - Column1.Header1.Caption = "..."
   - Column1.ControlSource = "..."
   - Column1.Width = XXX

   Extrair para TABELA:
   | Coluna | Header | ControlSource | Width | Tipo |
   |--------|--------|---------------|-------|------|
   | 1 | Código | cursor.cods | 80 | C |
   | ... | ... | ... | ... | ... |

5. PROPRIEDADES VISUAIS (UI Fidelity):
   Procurar por (no objeto principal do form):
   - Width = XXX
   - Height = XXX
   - Top = XXX
   - Left = XXX
   - BackColor = RGB(...)
   - ForeColor = RGB(...)
   - FontName = "..."
   - FontSize = XXX
   - Caption = "..."

   Extrair para TABELA:
   | Propriedade | Valor Original | Observação |
   |-------------|----------------|------------|
   | Width | 1003 | EXATO |
   | Height | 633 | EXATO |
   | ... | ... | ... |

6. ESTRUTURA DE PAGEFRAMES:
   Procurar por:
   - PageCount = N
   - PageFrame.Top = XXX (verificar se = -29)
   - Page1.Caption = "..."
   - Page2.Caption = "..."

   Identificar:
   - Qual Page é Lista (geralmente tem Grid)
   - Qual Page é Dados (geralmente tem campos)
   - Containers e seus Top (para compensação +29px)

═══════════════════════════════════════════════════════════════
FASE 2: GERAÇÃO DO PROMPT ESTRUTURADO
═══════════════════════════════════════════════════════════════

Com base na análise, GERAR um prompt seguindo este TEMPLATE:

---BEGIN TEMPLATE---

Preciso refazer a migração do [NomeForm] (task[X]) do zero, aplicando todas as lições aprendidas.

ARQUIVOS DE REFERÊNCIA OBRIGATÓRIOS:
1. docs/FORMCOR_LICOES_APRENDIDAS.md - Ler COMPLETAMENTE antes de começar
2. CLAUDE.md - Seção "Compensação do PageFrame.Top = -29"
3. docs/migration_guide.md - Checklist geral
4. tasks/task[X]/[ARQUIVO]_form_codigo_fonte.txt - Código fonte original
5. Framework/FormCargo.prg - Modelo de referência

REGRAS CRÍTICAS (NÃO DESVIAR):

[INSERIR AS 10 SOLUÇÕES - MEMORIZADAS]

⚠️ REGRA #1 ABSOLUTA - RETURN DENTRO DE TRY/CATCH:
   NUNCA usar RETURN dentro de TRY/CATCH - causa "RETURN/RETRY statement not allowed"
   SOLUÇÃO: Usar variável loc_lContinuar e verificar após ENDTRY
   Exemplo ERRADO:
   ```foxpro
   TRY
       IF !condicao
           RETURN .F.  && ERRO!
       ENDIF
   CATCH
   ENDTRY
   ```
   Exemplo CORRETO:
   ```foxpro
   LOCAL loc_lContinuar
   loc_lContinuar = .T.
   TRY
       IF !condicao
           loc_lContinuar = .F.  && OK!
       ENDIF
   CATCH
       loc_lContinuar = .F.
   ENDTRY
   IF !loc_lContinuar
       RETURN .F.  && RETURN fora do TRY/CATCH
   ENDIF
   ```

2. PROBLEMA: Grade perde cabeçalhos após RecordSource
   SOLUÇÃO: SEMPRE reconfigurar Header1.Caption APÓS definir RecordSource

3. PROBLEMA: Botões cortados no topo (PageFrame.Top = -29)
   SOLUÇÃO: Compensar +29 pixels em TODOS os controles de topo
   [SE PageFrame.Top = -29 no original]

4. PROBLEMA: "Connection handle is invalid" no ValidarUIFidelity
   SOLUÇÃO: Verificar gb_4c_ValidandoUI antes de CarregarLista() e gnConnHandle

5. PROBLEMA: Mapeamento JSON incorreto causa 104 falsos positivos
   SOLUÇÃO: Criar mapeamento com hierarquia correta

6. PROBLEMA: Duplicação de objetos raiz no ComparadorUI
   SOLUÇÃO: Já corrigido no ComparadorUI.prg (verificar se atualizado)

7. PROBLEMA: Métodos BINDEVENT + PROTECTED = falha silenciosa
   SOLUÇÃO: Métodos chamados via BINDEVENT DEVEM ser PUBLIC (não PROTECTED)

8. PROBLEMA: Salvar() retorna .F. em modo Incluir
   SOLUÇÃO: Chamar NovoRegistro() ANTES de LimparCampos() no BtnIncluirClick

9. PROBLEMA: Violação de PK ao Alterar registro existente
   SOLUÇÃO: Adicionar THIS.this_lNovoRegistro = .F. no CarregarPorCodigo()

10. PROBLEMA: Funções com parâmetros incorretos (ex: FormatarDataSQL com 2 args)
    SOLUÇÃO: Verificar assinatura das funções em utils/ antes de usar

11. PROBLEMA: String SQL numa unica linha excede limite VFP9 (~8000 chars)
    SOLUÇÃO: SEMPRE quebrar strings SQL longas com `+;` (continuation) a cada 3-4 campos
    Exemplo CORRETO:
    ```foxpro
    loc_cSQL = "SELECT a.Campo1, a.Campo2, a.Campo3," + ;
        " a.Campo4, a.Campo5, a.Campo6," + ;
        " a.Campo7 FROM Tabela a" + ;
        " WHERE a.Chave = " + EscaparSQL(loc_cChave)
    ```

ESTRUTURA DO FORMULÁRIO:

[INSERIR ÁRVORE BASEADA NA ANÁLISE]

PageFrame: pgf_4c_[Nome]
├── Page1 ([Caption Page1])
│   ├── [Containers e controles da Page1]
│   └── [Grid com N colunas]
│
└── Page2 ([Caption Page2])
    ├── [Containers e controles da Page2]
    └── Campos:
        [LISTAR TODOS OS CAMPOS IDENTIFICADOS]

BUSINESS OBJECT ([Entidade]BO.prg):

Propriedades obrigatórias:
[LISTAR TODAS AS PROPRIEDADES this_* BASEADAS NA TABELA DE CAMPOS]

Exemplo:
- this_cCodigo (PK) - CHAR(20)
- this_cDescricao - VARCHAR(100)
- this_nValor - NUMERIC(14,2)
- ...

LOOKUPS OBRIGATÓRIOS ([N]):

[LISTAR TODOS OS LOOKUPS IDENTIFICADOS]

Exemplo:
1. txt_4c_Grupo → SigCdGrp (cgrus, dgrus) - F4/DblClick
2. txt_4c_Tanque → SigCdTqe (codigos, descrs) - F4/DblClick
...

VALIDAÇÕES:

[LISTAR TODAS AS VALIDAÇÕES IDENTIFICADAS]

Exemplo:
1. txt_4c_TipoCor: INLIST(valor, "S", "N", "")
2. txt_4c_Codigo: Obrigatório, único (PK)
...

GRID (Page[X] - [Nome]):

[INSERIR CONFIGURAÇÃO DO GRID SE HOUVER]

Colunas ([N]):
| # | Header | ControlSource | Width | Tipo |
|---|--------|---------------|-------|------|
[COPIAR DADOS DA TABELA DE GRIDS]

PROPRIEDADES VISUAIS (UI Fidelity):

Form:
- Width = [XXX] (EXATO)
- Height = [XXX] (EXATO)
- Caption = "[...]"
- BackColor = RGB([X],[Y],[Z])
- FontName = "[...]"
- FontSize = [X]

[LISTAR TODAS AS PROPRIEDADES VISUAIS CRÍTICAS]

COMPENSAÇÃO PAGEFRAME (SE APLICÁVEL):

[SE PageFrame.Top = -29]
OBRIGATÓRIO: Compensar +29 pixels nos seguintes controles:
- [Container1].Top = [ValorOriginal] + 29 = [ValorNovo]
- [Container2].Top = [ValorOriginal] + 29 = [ValorNovo]
...

CHECKLIST DE VALIDAÇÃO FINAL:

[ ] PageFrame.Top = [XXX] e Tabs = .F.
[ ] Containers compensados (+29 pixels se PageFrame.Top=-29)
[ ] Grid com [N] colunas e cabeçalhos reconfigurados
[ ] InicializarForm() verifica gb_4c_ValidandoUI
[ ] Mapeamento JSON com hierarquia correta
[ ] ValidarUIFidelity executado: ≤ 37 problemas
[ ] [N] Lookups funcionam (F4/DblClick)
[ ] [N] Validações funcionam
[ ] INCLUIR/ALTERAR/EXCLUIR/VISUALIZAR funcionam

ORDEM DE DESENVOLVIMENTO:

1. Criar [Entidade]BO.prg ([N] propriedades, Inserir, Atualizar, Excluir, Buscar)
2. Criar Form[Entidade].prg (estrutura completa)
3. Configurar Page1 ([Nome] com [grid/controles])
4. Configurar Page2 ([Nome] com campos)
5. Implementar lookups ([N] campos)
6. Implementar validações ([N] regras)
7. Criar mapeamento JSON
8. Executar ValidarUIFidelity
9. Corrigir até ≤ 37 problemas
10. Testar todos os modos

IMPORTANTE:
- Ler docs/FORMCOR_LICOES_APRENDIDAS.md ANTES de começar
- Aplicar TODAS as soluções documentadas
- NÃO repetir os 5 problemas conhecidos
- Validar com ValidarUIFidelity ANTES de considerar completo

Começar agora?

---END TEMPLATE---

═══════════════════════════════════════════════════════════════
INSTRUÇÕES FINAIS
═══════════════════════════════════════════════════════════════

1. Execute a ANÁLISE completa do arquivo .txt fornecido
2. Preencha TODAS as tabelas com dados extraídos
3. Gere o prompt estruturado substituindo [PLACEHOLDERS] pelos dados reais
4. Retorne o prompt formatado e pronto para uso
5. Adicione observações sobre particularidades encontradas

FORMATO DA RESPOSTA:

## Análise Completa da Task[X]

### 1. Campos Identificados
[TABELA PREENCHIDA]

### 2. Lookups Identificados
[TABELA PREENCHIDA]

### 3. Validações Identificadas
[TABELA PREENCHIDA]

### 4. Grids Identificados
[TABELA PREENCHIDA]

### 5. Propriedades Visuais
[TABELA PREENCHIDA]

### 6. Estrutura de PageFrames
[DESCRIÇÃO]

---

## Prompt Gerado para Task[X]

[PROMPT COMPLETO PRONTO PARA COPIAR E COLAR]

---

## Observações Especiais

[PARTICULARIDADES ENCONTRADAS]
- Ex: "Este formulário tem 2 grids (Lista + Composição)"
- Ex: "PageFrame.Top = -29 CONFIRMADO - compensação obrigatória"
- Ex: "Lookup customizado no campo X - atenção especial"

═══════════════════════════════════════════════════════════════

Qual task deseja analisar? Forneça:
1. Caminho do arquivo: tasks/task[X]/[ARQUIVO]_form_codigo_fonte.txt
2. Nome legado: [Ex: SIGCDCAR]
3. Nome novo: [Ex: FormCargo]
```

---

## 📋 Como Usar o Meta-Prompt

### Passo 1: Copiar Meta-Prompt
Copie todo o conteúdo da seção "Meta-Prompt" acima.

### Passo 2: Informar a Task
Cole no Claude Code e forneça os dados da task:

```
Exemplo para Task2 (Cargo):

Caminho: tasks/task2/SIGCDCAR_form_codigo_fonte.txt
Nome legado: SIGCDCAR
Nome novo: FormCargo
```

### Passo 3: Claude Analisa e Gera
Claude Code irá:
1. ✅ Ler o arquivo .txt completo
2. ✅ Extrair campos, lookups, validações, grids
3. ✅ Identificar propriedades visuais
4. ✅ Gerar prompt estruturado estilo Prompt1
5. ✅ Aplicar automaticamente as 5 soluções do FORMCOR_LICOES_APRENDIDAS.md

### Passo 4: Usar Prompt Gerado
Copie o prompt gerado e use-o para refazer/migrar a task.

---

## 🎯 Exemplo de Uso Completo

### Input (Você fornece):
```
Qual task deseja analisar?

1. tasks/task2/SIGCDCAR_form_codigo_fonte.txt
2. SIGCDCAR
3. FormCargo
```

### Output (Claude gera):
```
## Análise Completa da Task2 (FormCargo)

### 1. Campos Identificados
| Campo Form | Campo BD | Tipo | Tamanho | Obrigatório | Propriedade BO |
|------------|----------|------|---------|-------------|----------------|
| txt_4c_Codigo | cargos | C | 20 | Sim | this_cCodigo |
| txt_4c_Descricao | dcarsg | C | 100 | Sim | this_cDescricao |
| txt_4c_Salario | salari | N | 14,2 | Não | this_nSalario |

### 2. Lookups Identificados
| Campo | Tabela Lookup | Campo Código | Campo Descrição | Tecla | Padrão |
|-------|---------------|--------------|-----------------|-------|--------|
| NENHUM | - | - | - | - | - |

### 3. Validações Identificadas
| Campo | Tipo Validação | Regra | Mensagem Erro |
|-------|----------------|-------|---------------|
| txt_4c_Codigo | PK | Único, obrigatório | "Código já existe" |
| txt_4c_Descricao | Obrigatório | !Empty() | "Descrição obrigatória" |

### 4. Grids Identificados
| Coluna | Header | ControlSource | Width | Tipo |
|--------|--------|---------------|-------|------|
| 1 | Código | cursor.cargos | 80 | C |
| 2 | Descrição | cursor.dcarsg | 300 | C |
| 3 | Salário | cursor.salari | 100 | N |

### 5. Propriedades Visuais
| Propriedade | Valor Original |
|-------------|----------------|
| Width | 950 |
| Height | 600 |
| PageFrame.Top | -29 |
| Caption | "Cadastro de Cargos" |

---

## Prompt Gerado para Task2 (FormCargo)

Preciso refazer a migração do FormCargo (task2) do zero, aplicando todas as lições aprendidas.

ARQUIVOS DE REFERÊNCIA OBRIGATÓRIOS:
1. docs/FORMCOR_LICOES_APRENDIDAS.md
2. CLAUDE.md - Compensação PageFrame.Top = -29
3. docs/migration_guide.md
4. tasks/task2/SIGCDCAR_form_codigo_fonte.txt
5. Framework/FormCargo.prg

REGRAS CRÍTICAS:
[... continua igual ao Prompt1, mas com dados do FormCargo ...]

BUSINESS OBJECT (CargoBO.prg):
- this_cCodigo (PK) - CHAR(20)
- this_cDescricao - VARCHAR(100)
- this_nSalario - NUMERIC(14,2)

LOOKUPS: Nenhum

VALIDAÇÕES:
1. txt_4c_Codigo: PK único
2. txt_4c_Descricao: Obrigatório

GRID (Page1 - Lista):
3 colunas: Código, Descrição, Salário

COMPENSAÇÃO PAGEFRAME:
OBRIGATÓRIO: Compensar +29 pixels
- cnt_4c_Cabecalho.Top = 2 + 29 = 31
- cnt_4c_Botoes.Top = 0 + 29 = 29

[... resto do prompt ...]
```

---

## 🔄 Workflow Completo para Qualquer Task

```
┌─────────────────────────────────────┐
│ 1. Extrair código fonte (.txt)     │
│    tasks/taskX/ARQUIVO.txt          │
└──────────────┬──────────────────────┘
               │
               ▼
┌─────────────────────────────────────┐
│ 2. Rodar META-PROMPT no Claude     │
│    - Input: caminho, nomes          │
│    - Output: Prompt estruturado     │
└──────────────┬──────────────────────┘
               │
               ▼
┌─────────────────────────────────────┐
│ 3. Usar Prompt Gerado               │
│    - Copiar prompt completo         │
│    - Colar no Claude Code           │
│    - Claude migra formulário        │
└──────────────┬──────────────────────┘
               │
               ▼
┌─────────────────────────────────────┐
│ 4. Validar com ValidarUIFidelity    │
│    - Executar script                │
│    - Corrigir até ≤37 problemas     │
└──────────────┬──────────────────────┘
               │
               ▼
┌─────────────────────────────────────┐
│ 5. Testar manualmente               │
│    - INCLUIR/ALTERAR/EXCLUIR        │
│    - Lookups, Validações            │
└──────────────┬──────────────────────┘
               │
               ▼
┌─────────────────────────────────────┐
│ 6. Commit e próxima task            │
└─────────────────────────────────────┘
```

---

## 🚀 Escalabilidade

Este meta-prompt permite migrar **qualquer formulário** de forma padronizada:

| Task | Form | Comando |
|------|------|---------|
| Task1 | FormCor | Meta-prompt + `tasks/task1/SIGCDCOR...txt` |
| Task2 | FormCargo | Meta-prompt + `tasks/task2/SIGCDCAR...txt` |
| Task3 | FormDepartamento | Meta-prompt + `tasks/task3/SIGCDDPT...txt` |
| Task4 | FormProduto | Meta-prompt + `tasks/task4/SIGCDPRO...txt` |
| Task5+ | ... | Meta-prompt + `tasks/taskX/...txt` |

---

## ✅ Benefícios

1. ✅ **Consistência**: Todos os prompts seguem o mesmo padrão
2. ✅ **Escalabilidade**: Funciona para qualquer formulário
3. ✅ **Lições Automáticas**: Aplica automaticamente os 5 fixes do FORMCOR
4. ✅ **Análise Completa**: Extrai TODOS os dados necessários
5. ✅ **Documentação**: Gera documentação automática da análise
6. ✅ **Velocidade**: Reduz tempo de preparação de horas para minutos

---

## 📊 Comparação

### Antes (Manual)
```
❌ Analisar código .txt manualmente (2-3 horas)
❌ Listar campos um por um
❌ Procurar lookups manualmente
❌ Escrever prompt do zero
❌ Risco de esquecer lições aprendidas
```

### Depois (Meta-Prompt)
```
✅ Copiar meta-prompt (10 segundos)
✅ Informar caminho da task (10 segundos)
✅ Claude analisa tudo automaticamente (2-3 minutos)
✅ Prompt completo gerado (pronto para usar)
✅ 5 soluções aplicadas automaticamente
```

**Redução de tempo**: ~95% (de 3 horas para 5 minutos)

---

## 🔧 Customizações Possíveis

### Adicionar Novos Checks
Edite a seção "ANÁLISE OBRIGATÓRIA" do meta-prompt para adicionar novos tipos de análise:

```
6. ANÁLISE DE SUBTABELAS:
   Procurar por:
   - Grids dentro de Page2 (dados)
   - Botões "Adicionar Linha", "Remover Linha"
   - RecordSource com cursors secundários
```

### Adicionar Novas Lições
Se encontrar novos problemas, adicione à seção "REGRAS CRÍTICAS":

```
6. PROBLEMA: [Novo problema]
   SOLUÇÃO: [Nova solução]
```

---

## 📝 Próximos Passos

1. ✅ Testar meta-prompt com Task2 (FormCargo)
2. ✅ Refinar análise baseada em resultados
3. ✅ Adicionar mais padrões de detecção (subtabelas, etc.)
4. ✅ Criar versão VFP9 do meta-prompt (opcional, para automação total)

---

**Última atualização**: 2026-01-16
**Autor**: Sistema de Refatoração VFP9
