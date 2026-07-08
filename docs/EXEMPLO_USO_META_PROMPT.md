# Exemplo Prático - Usando o Meta-Prompt para Gerar Prompts de Migração

**Cenário**: Você precisa migrar a **Task2 (FormCargo)** e quer gerar automaticamente um prompt estruturado como fizemos para o FormCor.

---

## 🎯 Passo a Passo Completo

### Passo 1: Abrir o Meta-Prompt

Abra o arquivo: `docs/GERADOR_PROMPT_MIGRACAO.md`

Copie **TODO** o conteúdo da seção "Meta-Prompt" (começa com "Preciso que você ANALISE...").

---

### Passo 2: Colar no Claude Code

Cole o meta-prompt no Claude Code.

---

### Passo 3: Informar os Dados da Task

Claude irá perguntar:

```
Qual task deseja analisar? Forneça:
1. Caminho do arquivo: tasks/task[X]/[ARQUIVO]_form_codigo_fonte.txt
2. Nome legado: [Ex: SIGCDCAR]
3. Nome novo: [Ex: FormCargo]
```

**Você responde**:

```
1. tasks/task2/SIGCDCAR_form_codigo_fonte.txt
2. SIGCDCAR
3. FormCargo
```

---

### Passo 4: Claude Analisa e Gera

Claude irá:

1. ✅ Ler `tasks/task2/SIGCDCAR_form_codigo_fonte.txt` completamente
2. ✅ Procurar por campos (ControlSource)
3. ✅ Procurar por lookups (fwbuscaext, sigacess, etc.)
4. ✅ Procurar por validações (PROCEDURE Valid)
5. ✅ Procurar por grids (ColumnCount, Headers)
6. ✅ Extrair propriedades visuais (Width, Height, Top, Left)
7. ✅ Identificar PageFrames e Pages
8. ✅ Gerar tabelas com todos os dados
9. ✅ Preencher template do prompt
10. ✅ Retornar prompt completo pronto para usar

---

### Passo 5: Receber Análise Completa

Claude retorna algo como:

```
═══════════════════════════════════════════════════════════════
Análise Completa da Task2 (FormCargo)
═══════════════════════════════════════════════════════════════

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

Observação: FormCargo não possui lookups.

### 3. Validações Identificadas

| Campo | Tipo Validação | Regra | Mensagem Erro |
|-------|----------------|-------|---------------|
| txt_4c_Codigo | PK Único | !Empty() + SEEK() | "Código já existe" |
| txt_4c_Descricao | Obrigatório | !Empty() | "Descrição obrigatória" |
| txt_4c_Salario | Positivo | >= 0 | "Salário deve ser >= 0" |

### 4. Grids Identificados

Grid Principal (Page1 - Lista):

| Coluna | Header | ControlSource | Width | Tipo |
|--------|--------|---------------|-------|------|
| 1 | Código | cursor_4c_Dados.cargos | 100 | C |
| 2 | Descrição | cursor_4c_Dados.dcarsg | 350 | C |
| 3 | Salário | cursor_4c_Dados.salari | 120 | N |

### 5. Propriedades Visuais

| Propriedade | Valor Original | Observação |
|-------------|----------------|------------|
| Width | 950 | EXATO |
| Height | 600 | EXATO |
| Top | 50 | EXATO |
| Left | 50 | EXATO |
| Caption | "Cadastro de Cargos" | Com CHR() |
| BackColor | RGB(255,255,255) | Branco |
| FontName | "Tahoma" | EXATO |
| FontSize | 9 | EXATO |

### 6. Estrutura de PageFrames

PageFrame: Pagina
- Top = -29 ✅ COMPENSAÇÃO OBRIGATÓRIA
- Tabs = .F.
- PageCount = 2

Page1: Lista
- Caption = "Lista"
- Contém: Grid + Botões CRUD

Page2: Dados
- Caption = "Dados"
- Contém: 3 campos + Botões Salvar/Cancelar

Containers que precisam compensação +29px:
- cntSombra.Top = 2 → Novo: cnt_4c_Cabecalho.Top = 31
- Grupo_op.Top = 0 → Novo: cnt_4c_Botoes.Top = 29
- Grupo_Salva.Top = 9 → Novo: cnt_4c_BotoesAcao.Top = 38

═══════════════════════════════════════════════════════════════
Prompt Gerado para Task2 (FormCargo)
═══════════════════════════════════════════════════════════════

Preciso refazer a migração do FormCargo (task2) do zero, aplicando todas as lições aprendidas.

ARQUIVOS DE REFERÊNCIA OBRIGATÓRIOS:
1. docs/FORMCOR_LICOES_APRENDIDAS.md - Ler COMPLETAMENTE antes de começar
2. CLAUDE.md - Seção "Compensação do PageFrame.Top = -29"
3. docs/migration_guide.md - Checklist geral
4. tasks/task2/SIGCDCAR_form_codigo_fonte.txt - Código fonte original
5. Framework/FormCargo.prg - Modelo de referência

REGRAS CRÍTICAS (NÃO DESVIAR):

1. PROBLEMA: Grade perde cabeçalhos após RecordSource
   SOLUÇÃO: SEMPRE reconfigurar Header1.Caption APÓS definir RecordSource

   CORRETO:
   loc_oGrid.RecordSource = "cursor_4c_Dados"
   loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cargos"
   loc_oGrid.Column1.Header1.Caption = "Código"  ← OBRIGATÓRIO

2. PROBLEMA: Botões cortados no topo (PageFrame.Top = -29)
   SOLUÇÃO: Compensar +29 pixels em TODOS os controles de topo

   CONFIRMADO: PageFrame.Top = -29 no original
   OBRIGATÓRIO aplicar compensação:
   - cnt_4c_Cabecalho.Top = 31 (2 + 29)
   - cnt_4c_Botoes.Top = 29 (0 + 29)
   - cnt_4c_BotoesAcao.Top = 38 (9 + 29)

3. PROBLEMA: "Connection handle is invalid" no ValidarUIFidelity
   SOLUÇÃO: Verificar gb_4c_ValidandoUI antes de CarregarLista()

   CORRETO:
   IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
       IF !THIS.CarregarLista()
           * Falha não impede abertura
       ENDIF
   ENDIF

4. PROBLEMA: Mapeamento JSON incorreto causa 104 falsos positivos
   SOLUÇÃO: Criar mapeamento com hierarquia correta

   CORRETO:
   "SIGCDCAR.Pagina": "pgf_4c_Paginas"
   "SIGCDCAR.Pagina.Lista": "Page1"
   "SIGCDCAR.Pagina.Dados": "Page2"

5. PROBLEMA: Duplicação de objetos raiz no ComparadorUI
   SOLUÇÃO: Já corrigido no ComparadorUI.prg (verificar se atualizado)

ESTRUTURA DO FORMULÁRIO:

PageFrame: pgf_4c_Paginas (Top = -29, Tabs = .F.)
├── Page1 (Lista)
│   ├── cnt_4c_Cabecalho (Top = 31) ← COMPENSADO +29
│   │   └── lbl_4c_Titulo ("Cadastro de Cargos")
│   ├── cnt_4c_Botoes (Top = 29) ← COMPENSADO +29
│   │   ├── cmd_4c_Incluir (F2)
│   │   ├── cmd_4c_Alterar (F3)
│   │   ├── cmd_4c_Excluir (F4)
│   │   ├── cmd_4c_Consultar (F5)
│   │   └── cmd_4c_Sair (ESC)
│   └── grd_4c_Dados (3 colunas)
│
└── Page2 (Dados)
    ├── cnt_4c_BotoesAcao (Top = 38) ← COMPENSADO +29
    │   ├── cmd_4c_Salvar (F10)
    │   └── cmd_4c_Cancelar (ESC)
    └── Campos:
        ├── lbl_4c_Codigo + txt_4c_Codigo (PK, obrigatório)
        ├── lbl_4c_Descricao + txt_4c_Descricao (obrigatório)
        └── lbl_4c_Salario + txt_4c_Salario (numérico, >= 0)

BUSINESS OBJECT (CargoBO.prg):

Propriedades obrigatórias:
- this_cCodigo (PK) - CHAR(20)
- this_cDescricao - VARCHAR(100)
- this_nSalario - NUMERIC(14,2)

Métodos:
- CarregarDoCursor()
- Inserir()
- Atualizar()
- Excluir()
- Buscar()
- ObterChavePrimaria() → RETURN THIS.this_cCodigo

LOOKUPS OBRIGATÓRIOS: Nenhum

FormCargo não possui lookups. Todos os campos são de entrada direta.

VALIDAÇÕES:

1. txt_4c_Codigo:
   - Obrigatório: !Empty(valor)
   - Único (PK): Verificar duplicata no banco
   - Mensagem: "Código já cadastrado"

2. txt_4c_Descricao:
   - Obrigatório: !Empty(valor)
   - Mensagem: "Descrição obrigatória"

3. txt_4c_Salario:
   - Positivo: valor >= 0
   - Mensagem: "Salário deve ser >= 0"

GRID (Page1 - Lista):

Colunas (3):
| # | Header | ControlSource | Width | Alignment | InputMask |
|---|--------|---------------|-------|-----------|-----------|
| 1 | Código | cursor_4c_Dados.cargos | 100 | Left | - |
| 2 | Descrição | cursor_4c_Dados.dcarsg | 350 | Left | - |
| 3 | Salário | cursor_4c_Dados.salari | 120 | Right | 999,999.99 |

IMPORTANTE: Reconfigurar Headers APÓS RecordSource:
```foxpro
loc_oGrid.RecordSource = "cursor_4c_Dados"
loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cargos"
loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.dcarsg"
loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.salari"

*-- OBRIGATÓRIO: Reconfigurar headers (perdidos ao alterar RecordSource)
loc_oGrid.Column1.Header1.Caption = "Código"
loc_oGrid.Column2.Header1.Caption = "Descrição"
loc_oGrid.Column3.Header1.Caption = "Salário"
```

PROPRIEDADES VISUAIS (UI Fidelity):

Form:
- Width = 950 (EXATO)
- Height = 600 (EXATO)
- Top = 50 (EXATO)
- Left = 50 (EXATO)
- Caption = "Cadastro de Cargos"
- BackColor = RGB(255,255,255)
- ForeColor = RGB(0,0,0)
- FontName = "Tahoma"
- FontSize = 9
- BorderStyle = 3 (Sizable)
- TitleBar = 1

PageFrame:
- Top = -29 (EXATO - para esconder abas)
- Tabs = .F.
- PageCount = 2

COMPENSAÇÃO PAGEFRAME:

OBRIGATÓRIO: Compensar +29 pixels nos seguintes controles:

Page1 (Lista):
- cnt_4c_Cabecalho.Top = 2 + 29 = 31
- cnt_4c_Botoes.Top = 0 + 29 = 29
- grd_4c_Dados.Top = 121 (já alto, não precisa compensar)

Page2 (Dados):
- cnt_4c_BotoesAcao.Top = 9 + 29 = 38
- lbl_4c_Codigo.Top = 131 (verificar se precisa compensar)
- txt_4c_Codigo.Top = 127 (verificar se precisa compensar)

CHECKLIST DE VALIDAÇÃO FINAL:

[ ] PageFrame.Top = -29 e Tabs = .F.
[ ] Containers compensados (+29 pixels)
[ ] Grid com 3 colunas e cabeçalhos reconfigurados
[ ] InicializarForm() verifica gb_4c_ValidandoUI
[ ] Mapeamento JSON com hierarquia correta:
    "SIGCDCAR.Pagina": "pgf_4c_Paginas"
    "SIGCDCAR.Pagina.Lista": "Page1"
    "SIGCDCAR.Pagina.Dados": "Page2"
[ ] ValidarUIFidelity executado: ≤ 37 problemas
[ ] Validações funcionam (PK, obrigatórios, salário >= 0)
[ ] INCLUIR/ALTERAR/EXCLUIR/VISUALIZAR funcionam

ORDEM DE DESENVOLVIMENTO:

1. Criar CargoBO.prg (3 propriedades, Inserir, Atualizar, Excluir, Buscar)
2. Criar FormCargo.prg (estrutura completa com PageFrame)
3. Configurar Page1 (Lista com grid de 3 colunas)
4. Configurar Page2 (Dados com 3 campos)
5. Implementar validações (PK único, obrigatórios, salário >= 0)
6. Criar mapeamento JSON (FormCargo_mapeamento.json)
7. Executar ValidarUIFidelity
8. Corrigir até ≤ 37 problemas
9. Testar todos os modos (INCLUIR, ALTERAR, EXCLUIR, VISUALIZAR)
10. Testar validações

IMPORTANTE:
- Ler docs/FORMCOR_LICOES_APRENDIDAS.md ANTES de começar
- Aplicar TODAS as 5 soluções documentadas
- NÃO repetir os problemas conhecidos
- FormCargo é MAIS SIMPLES que FormCor (sem lookups)
- Validar com ValidarUIFidelity ANTES de considerar completo

Começar agora?

═══════════════════════════════════════════════════════════════
Observações Especiais
═══════════════════════════════════════════════════════════════

1. ✅ PageFrame.Top = -29 CONFIRMADO - compensação obrigatória
2. ✅ Formulário SIMPLES - sem lookups, apenas 3 campos
3. ✅ Grid com 3 colunas - mais simples que FormCor (4 colunas)
4. ⚠️ Validação de salário >= 0 (não estava no FormCor)
5. ⚠️ Validação de PK único (verificar duplicata no banco)
```

---

### Passo 6: Copiar Prompt Gerado

Copie TODO o conteúdo da seção "Prompt Gerado para Task2 (FormCargo)".

---

### Passo 7: Usar Prompt para Migrar

Cole o prompt gerado em uma nova conversa com Claude Code e inicie a migração!

Claude irá:
1. ✅ Ler docs/FORMCOR_LICOES_APRENDIDAS.md
2. ✅ Criar CargoBO.prg com 3 propriedades
3. ✅ Criar FormCargo.prg com estrutura completa
4. ✅ Aplicar compensação +29px automaticamente
5. ✅ Reconfigurar headers do grid
6. ✅ Verificar gb_4c_ValidandoUI no Init
7. ✅ Criar mapeamento JSON correto
8. ✅ Executar ValidarUIFidelity
9. ✅ Corrigir até ≤37 problemas
10. ✅ Pronto para testar!

---

## 📊 Comparação: Antes vs Depois

### Antes (Sem Meta-Prompt)

```
❌ Passo 1: Ler código .txt manualmente (1-2 horas)
❌ Passo 2: Listar campos em planilha (30 min)
❌ Passo 3: Procurar lookups um por um (30 min)
❌ Passo 4: Procurar validações (30 min)
❌ Passo 5: Extrair propriedades visuais (30 min)
❌ Passo 6: Escrever prompt do zero (1 hora)
❌ Passo 7: Revisar para não esquecer lições (30 min)

Total: ~5 horas de preparação
```

### Depois (Com Meta-Prompt)

```
✅ Passo 1: Copiar meta-prompt (10 segundos)
✅ Passo 2: Informar caminho da task (10 segundos)
✅ Passo 3: Claude analisa automaticamente (3-5 minutos)
✅ Passo 4: Copiar prompt gerado (10 segundos)
✅ Passo 5: Usar prompt para migrar (automático)

Total: ~5 minutos de preparação
```

**Redução de tempo**: 98% (de 5 horas para 5 minutos)

---

## ✅ Checklist de Validação

Após receber o prompt gerado, verificar:

```
[ ] Análise completa com todas as 6 tabelas preenchidas
[ ] Campos identificados corretamente (tipos, tamanhos)
[ ] Lookups identificados (ou "NENHUM" se não houver)
[ ] Validações identificadas corretamente
[ ] Grid identificado com colunas corretas
[ ] Propriedades visuais extraídas (Width, Height, etc.)
[ ] Estrutura de PageFrames identificada
[ ] Compensação +29px identificada (se PageFrame.Top = -29)
[ ] Prompt gerado está completo e pronto para usar
[ ] 5 soluções do FORMCOR aplicadas automaticamente
```

---

## 🔄 Workflow Completo

```
1. Abrir GERADOR_PROMPT_MIGRACAO.md
   ↓
2. Copiar meta-prompt
   ↓
3. Colar no Claude Code
   ↓
4. Informar: caminho, nome legado, nome novo
   ↓
5. Claude analisa código .txt automaticamente
   ↓
6. Receber análise completa + prompt gerado
   ↓
7. Copiar prompt gerado
   ↓
8. Usar prompt para migrar formulário
   ↓
9. ValidarUIFidelity
   ↓
10. Testar e commit
```

---

## 🎯 Próximas Tasks

Use o meta-prompt para gerar prompts para:

- ✅ Task2 (FormCargo) - Exemplo acima
- ✅ Task3 (FormDepartamento)
- ✅ Task4 (FormProduto)
- ✅ Task5+ (Qualquer formulário)

**Processo idêntico para todas as tasks!**

---

## 📝 Dicas

1. **Sempre revise a análise** - Verifique se Claude identificou tudo corretamente
2. **Adicione observações** - Se encontrar algo especial, anote nas "Observações Especiais"
3. **Atualize o meta-prompt** - Se encontrar novos padrões, adicione à análise
4. **Documente problemas novos** - Se encontrar novos problemas, adicione ao FORMCOR_LICOES_APRENDIDAS.md

---

**Última atualização**: 2026-01-16
**Autor**: Sistema de Refatoração VFP9
