# METODOLOGIA: Migração de Formulários Grandes (>1MB)

## 1. CONTEXTO E PROBLEMA

### 1.1 Definição de "Arquivo Grande"
| Tamanho | Categoria | Estratégia |
|---------|-----------|------------|
| < 500KB (~10k linhas) | **Pequeno** | Processar de uma vez (padrão) |
| 500KB - 1MB (~20k linhas) | **Médio** | Processar de uma vez OU dividir em 2 fases |
| 1MB - 3MB (~60k linhas) | **Grande** | **DIVIDIR EM FASES** (esta metodologia) |
| > 3MB (>60k linhas) | **Muito Grande** | Dividir em múltiplas fases + validação incremental |

### 1.2 Limitações Técnicas
- **Context Window**: Claude tem limite de tokens (~200k tokens)
- **Arquivo 3MB**: ~60k linhas = ~150k tokens (75% do contexto)
- **Problema**: Pouco espaço para saída de código + instruções

### 1.3 Regra Fundamental (NÃO NEGOCIÁVEL)
```
┌─────────────────────────────────────────────────────────────┐
│  NUNCA CRIAR VERSÕES REDUZIDAS OU MVPs!                    │
│                                                             │
│  Divisão em FASES ≠ Versão Reduzida                        │
│                                                             │
│  ✅ CORRETO: Dividir processo, entregar TUDO              │
│  ❌ ERRADO: Dividir funcionalidade, entregar PARTE        │
└─────────────────────────────────────────────────────────────┘
```

---

## 2. METODOLOGIA: DIVISÃO POR CAMADAS ARQUITETURAIS

### 2.1 Princípio SOLID de Divisão
Dividir por **responsabilidade**, não por "importância":

```
┌─────────────────────────────────────────────────────────┐
│ CAMADA 1: Modelo de Dados (Business Object)            │
│ → Todas as propriedades do banco                       │
│ → Métodos CRUD completos                               │
│ → Independente da UI                                   │
└─────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│ CAMADA 2: Estrutura Visual (Form Skeleton)             │
│ → Propriedades do Form (Width, Height, Colors)         │
│ → PageFrame e Pages                                    │
│ → Containers e layout                                  │
└─────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│ CAMADA 3: Campos de Entrada (Input Controls)           │
│ → Labels e TextBoxes                                   │
│ → ComboBoxes e CheckBoxes                              │
│ → Botões de ação                                       │
└─────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│ CAMADA 4: Lógica de Interação (Lookups & Validations)  │
│ → Lookups (F4/F5)                                       │
│ → Valid/When customizados                              │
│ → BINDEVENT handlers                                   │
└─────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│ CAMADA 5: Grids e Sub-tabelas (Detail Grids)           │
│ → Grids de detalhes                                    │
│ → Lookups dentro de grids                              │
│ → Totalizadores                                        │
└─────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│ CAMADA 6: Lógica de Negócio (Business Logic)           │
│ → Procedures customizados                              │
│ → Cálculos complexos                                   │
│ → Fluxos específicos                                   │
└─────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│ CAMADA 7: Validação Final (Testing & QA)               │
│ → ValidarUIFidelity.prg                                │
│ → Testes CRUD completos                                │
│ → Comparação lado-a-lado                               │
└─────────────────────────────────────────────────────────┘
```

### 2.2 Tabela de Decisão: Quando Usar Cada Camada

| Camada | Obrigatória? | Quando Pular? |
|--------|--------------|---------------|
| 1. Modelo de Dados | **SIM** | Nunca |
| 2. Estrutura Visual | **SIM** | Nunca |
| 3. Campos de Entrada | **SIM** | Nunca |
| 4. Lookups/Validations | **SIM** | Se form não tem lookups |
| 5. Grids de Detalhe | **Condicional** | Se form não tem sub-tabelas |
| 6. Lógica de Negócio | **Condicional** | Se form não tem procedures customizados |
| 7. Validação Final | **SIM** | Nunca |

---

## 3. PROCESSO PASSO-A-PASSO

### FASE 0: Análise Pré-Migração (INVENTÁRIO)

**Objetivo**: Mapear TUDO que existe no formulário original

**Entrada**:
- Arquivo `.SCX` original
- Schema do banco (`docs/schema.sql`)

**Saída**:
- `[FormName]_inventario.json` (metadados estruturados)
- `[FormName]_codigo_fonte.txt` (código extraído)

**Ações**:

#### 0.1 Extração de Código
```foxpro
*-- No VFP9:
CD C:\4c\projeto\app\utils
SET PROCEDURE TO ExtractSCXCode.prg ADDITIVE
DO ExtractSCXCode WITH "caminho\original.scx", "C:\4c\tasks\taskXXX\"
```

#### 0.2 Análise Estrutural (Manual ou Script)
Criar inventário JSON:
```json
{
  "form": {
    "nome": "SIGMVCAB",
    "classe_base": "frmcadastro",
    "herda_de": "..\\framework\\framework.vcx",
    "tamanho_arquivo": "3.0MB",
    "total_linhas": 59809
  },
  "banco": {
    "tabela_principal": "SigMvCab",
    "chave_primaria": "IdMov",
    "total_campos": 45
  },
  "objetos": {
    "pageframes": 2,
    "containers": 12,
    "textboxes": 67,
    "labels": 65,
    "commandbuttons": 18,
    "grids": 3,
    "comboboxes": 8,
    "checkboxes": 5
  },
  "lookups": [
    {"campo": "CodigoCliente", "tecla": "F4", "tabela_lookup": "SigCdCli"},
    {"campo": "CodigoProduto", "tecla": "F4", "tabela_lookup": "SigCdPro"},
    {"campo": "CodigoVendedor", "tecla": "F4", "tabela_lookup": "SigCdVen"}
  ],
  "grids_detalhe": [
    {
      "nome": "grd_Itens",
      "tabela": "SigMvIte",
      "colunas": 8,
      "lookups_internos": 2
    }
  ],
  "procedures_customizados": [
    "CalcularTotal",
    "ValidarEstoque",
    "GerarParcelas"
  ]
}
```

**Critério de Aceite**:
- ✅ Inventário completo de TODOS os objetos
- ✅ Lista de TODOS os campos do banco
- ✅ Lista de TODOS os lookups identificados
- ✅ Lista de TODOS os grids de detalhe

---

### FASE 1: Business Object (Modelo de Dados)

**Objetivo**: Criar BO com TODAS as propriedades do banco

**Entrada**:
- `inventario.json` (campos do banco)
- `docs/schema.sql` (estrutura da tabela)

**Saída**:
- `[Entidade]BO.prg` (Business Object completo)

**Template**:
```foxpro
*==============================================================================
* [Entidade]BO.prg
* Business Object para [Tabela]
* Criado em: [Data]
* Total de campos: [N]
*==============================================================================
DEFINE CLASS [Entidade]BO AS BusinessBase

    *-- Propriedades de dados (TODOS os campos da tabela)
    this_cCampo1 = ""
    this_nCampo2 = 0
    this_dCampo3 = {}
    this_lCampo4 = .F.
    *... (TODOS os N campos)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela = "[NomeTabela]"
        THIS.this_cCampoChave = "[CampoPK]"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        *... (TODOS os campos)
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        *... SQL INSERT com TODOS os campos
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        *... SQL UPDATE com TODOS os campos
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_[CampoPK])
    ENDPROC

ENDDEFINE
```

**Checklist de Validação**:
```
[ ] TODOS os campos do banco têm propriedade correspondente
[ ] CarregarDoCursor() carrega TODOS os campos
[ ] Inserir() insere TODOS os campos
[ ] Atualizar() atualiza TODOS os campos
[ ] ObterChavePrimaria() retorna PK correta
[ ] Testes: Salvar() funciona para novo registro
[ ] Testes: Salvar() funciona para atualização
```

**Divisão Se Necessário** (tabela com >50 campos):
- Criar BO em arquivo único
- Se contexto insuficiente, dividir em 2 prompts:
  - **Prompt 1**: Estrutura + campos 1-30
  - **Prompt 2**: Campos 31-N + métodos CRUD

---

### FASE 2: Estrutura Visual do Form

**Objetivo**: Criar skeleton do form sem lógica

**Entrada**:
- `codigo_fonte.txt` (propriedades visuais)
- `inventario.json` (objetos a criar)

**Saída**:
- `Form[Entidade].prg` (estrutura base)

**Sub-fases**:

#### 2A: Propriedades do Form + PageFrame
```foxpro
DEFINE CLASS Form[Entidade] AS FormBase
    *-- Propriedades visuais (COPIAR EXATAS DO ORIGINAL)
    Width = XXX
    Height = XXX
    Caption = "..."
    BackColor = RGB(X,X,X)
    *...

    PROCEDURE Init()
        DODEFAULT()
        THIS.ConfigurarPageFrame()
        RETURN .T.
    ENDPROC

    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Principal", "PageFrame")
        WITH THIS.pgf_4c_Principal
            .PageCount = 2
            .Top = -29
            .Tabs = .F.
            *...
        ENDWITH
    ENDPROC
ENDDEFINE
```

#### 2B: Page1 - Lista (Grid + Botões CRUD)
```foxpro
PROTECTED PROCEDURE ConfigurarPaginaLista()
    LOCAL loc_oPagina
    loc_oPagina = THIS.pgf_4c_Principal.Page1

    *-- Container de botões CRUD (6 botões padrão)
    *-- Grid de listagem
    *-- (seguir padrão FormBase)
ENDPROC
```

#### 2C: Page2 - Estrutura de Containers
```foxpro
PROTECTED PROCEDURE ConfigurarPaginaDados()
    LOCAL loc_oPagina
    loc_oPagina = THIS.pgf_4c_Principal.Page2

    *-- Containers por grupo lógico
    loc_oPagina.AddObject("cnt_4c_Grupo1", "Container")
    loc_oPagina.AddObject("cnt_4c_Grupo2", "Container")
    *...
ENDPROC
```

**Critério de Aceite**:
```
[ ] Form abre sem erros
[ ] PageFrame visível com 2 Pages
[ ] Botões CRUD presentes e visíveis
[ ] Grid de lista existe (vazio ok)
[ ] Containers de grupos criados
[ ] ValidarUIFidelity: estrutura básica OK
```

---

### FASE 3: Campos de Entrada (Dividir por Grupos)

**Objetivo**: Adicionar TODOS os campos do formulário

**Estratégia de Divisão**:
- **Grupo A**: Campos principais (1-20)
- **Grupo B**: Campos secundários (21-40)
- **Grupo C**: Campos terciários (41-N)

**Prompt Template** (repetir para cada grupo):
```
CONTEXTO:
- Form[Entidade] já existe com estrutura base
- BO já existe com todas as propriedades
- Inventário mostra [N] campos totais

TAREFA:
Adicionar campos do GRUPO [A/B/C] ao Form[Entidade].prg:

CAMPOS DESTE GRUPO:
1. CodigoCliente (CHAR(20), lookup F4)
2. NomeCliente (CHAR(100), readonly após lookup)
3. DataEmissao (DATE, obrigatório)
...
[Listar TODOS os campos do grupo]

REGRAS:
1. Adicionar em ConfigurarPaginaDados() no container correto
2. Copiar propriedades visuais EXATAS do original (Top, Left, Width, Height, etc.)
3. NÃO implementar lookups ainda (próxima fase)
4. NÃO implementar FormParaBO/BOParaForm ainda

ENTREGA:
- Código completo de ConfigurarPaginaDados() atualizado
- TODOS os campos deste grupo implementados
```

**Checklist por Grupo**:
```
[ ] TODOS os campos do grupo têm Label + TextBox/ComboBox/CheckBox
[ ] Propriedades visuais EXATAS (Top, Left, Width, Height)
[ ] InputMask correto (se aplicável)
[ ] Value inicializado corretamente ("", 0, {}, .F.)
[ ] ValidarUIFidelity: 0 diferenças nos campos deste grupo
```

---

### FASE 4: Lookups e Validações

**Objetivo**: Implementar TODOS os lookups identificados

**Entrada**:
- `inventario.json` → lista de lookups
- `docs/lookup_implementation.md` → padrões

**Estratégia de Divisão**:
- **1 prompt por lookup** (se >10 lookups)
- OU **todos de uma vez** (se ≤10 lookups)

**Prompt Template**:
```
CONTEXTO:
- Form[Entidade] já tem TODOS os campos criados
- Inventário identifica [N] lookups

TAREFA:
Implementar lookups para os seguintes campos:
1. CodigoCliente → SigCdCli (F4)
2. CodigoProduto → SigCdPro (F4)
...

REGRAS:
1. Usar FormBuscaAuxiliar (padrão do projeto)
2. BINDEVENT nos TextBoxes
3. Atualizar campos dependentes após seleção
4. Seguir docs/lookup_implementation.md

ENTREGA:
- Métodos Lookup[Campo]() para TODOS os campos
- BINDEVENT configurados
- Teste: F4 abre busca e preenche campo
```

**Critério de Aceite**:
```
[ ] TODOS os lookups funcionam (F4 abre busca)
[ ] Seleção preenche campo principal + dependentes
[ ] ESC cancela sem preencher
[ ] Validação de código inválido funciona
```

---

### FASE 5: Grids de Detalhe (Se Aplicável)

**Objetivo**: Implementar grids de sub-tabelas

**Entrada**:
- `inventario.json` → grids identificados
- `docs/grid_implementation.md` → padrões

**Prompt Template**:
```
CONTEXTO:
- Form[Entidade] está funcional para cabeçalho
- Formulário tem grid de itens (sub-tabela)

TAREFA:
Implementar Grid de Detalhes:
- Tabela: [Tabela]Ite
- Colunas: [listar]
- Lookups internos: [listar]
- Totalizadores: [listar]

ENTREGA:
- Grid configurado com TODAS as colunas
- Lookups dentro do grid funcionais
- Métodos AdicionarItem(), RemoverItem(), EditarItem()
- Totalizadores atualizando automaticamente
```

---

### FASE 6: FormParaBO e BOParaForm

**Objetivo**: Sincronizar Form ↔ BO para TODOS os campos

**Estratégia**:
- **1 prompt único** (se ≤30 campos)
- **2 prompts** (se >30 campos): Grupo A + Grupo B

**Prompt Template**:
```
CONTEXTO:
- Form[Entidade] tem TODOS os campos criados
- BO tem TODAS as propriedades

TAREFA:
Implementar sincronização COMPLETA:

1. FormParaBO(): Form → BO (TODOS os campos)
2. BOParaForm(): BO → Form (TODOS os campos)
3. HabilitarCampos(): Controlar ReadOnly por modo

REGRAS CRÍTICAS:
- VAL() apenas em campos string inicializados com ""
- Campos numéricos inicializados com 0 → NÃO usar VAL()
- ALLTRIM() apenas em strings
- Verificar tipo antes de conversão

ENTREGA:
- FormParaBO() completo
- BOParaForm() completo
- HabilitarCampos() completo
- Teste: INCLUIR/ALTERAR/VISUALIZAR funcionam
```

**Checklist**:
```
[ ] FormParaBO(): TODOS os campos Form → BO
[ ] BOParaForm(): TODOS os campos BO → Form
[ ] HabilitarCampos(): ReadOnly correto por modo
[ ] Teste INCLUIR: salva todos os campos
[ ] Teste ALTERAR: carrega e atualiza todos os campos
[ ] Teste VISUALIZAR: exibe todos os campos (readonly)
```

---

### FASE 7: Lógica de Negócio Customizada

**Objetivo**: Implementar procedures específicos do formulário

**Entrada**:
- `inventario.json` → procedures identificados
- `codigo_fonte.txt` → código original

**Prompt Template**:
```
CONTEXTO:
- Form[Entidade] funcional para CRUD básico
- Formulário original tem procedures customizados:
  1. CalcularTotal()
  2. ValidarEstoque()
  3. GerarParcelas()

TAREFA:
Implementar procedure [NomeProcedure]:

[Copiar código original do procedure]

REGRAS:
- Adaptar para nova arquitetura (Form/BO separation)
- Usar FormatarNumeroSQL/FormatarDataSQL
- Manter lógica idêntica ao original

ENTREGA:
- Procedure implementado e funcional
- Teste: comportamento idêntico ao original
```

---

### FASE 8: Validação Final (QA)

**Objetivo**: Garantir paridade 100% com original

**Checklist Completo**:
```
┌─────────────────────────────────────────────────────────┐
│ VALIDAÇÃO UI FIDELITY                                   │
├─────────────────────────────────────────────────────────┤
│ [ ] ValidarUIFidelity.prg: ≤37 problemas aceitáveis     │
│ [ ] Screenshot lado-a-lado: 0 diferenças visuais        │
│ [ ] TODOS os campos visíveis e posicionados             │
│ [ ] TODAS as cores/fontes idênticas                     │
│ [ ] TODOS os botões funcionais                          │
└─────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────┐
│ VALIDAÇÃO FUNCIONAL                                     │
├─────────────────────────────────────────────────────────┤
│ [ ] INCLUIR: TODOS os campos salvam                     │
│ [ ] ALTERAR: TODOS os campos carregam e atualizam       │
│ [ ] VISUALIZAR: TODOS os campos exibem (readonly)       │
│ [ ] EXCLUIR: Auditoria registrada                       │
│ [ ] BUSCAR: Grid lista corretamente                     │
│ [ ] TODOS os lookups (F4) funcionam                     │
│ [ ] TODOS os cálculos automáticos corretos              │
│ [ ] TODAS as validações ativas                          │
└─────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────┐
│ VALIDAÇÃO DE DADOS                                      │
├─────────────────────────────────────────────────────────┤
│ [ ] SELECT * FROM [Tabela]: TODOS os campos preenchidos│
│ [ ] Comparar com registro do sistema antigo: idêntico  │
│ [ ] LogAuditoria: operações registradas                │
└─────────────────────────────────────────────────────────┘
```

---

## 4. TEMPLATES DE PROMPTS

### 4.1 Template: Criar Business Object

```markdown
# PROMPT: Criar [Entidade]BO (Business Object)

## CONTEXTO
- Projeto: Migração VFP9 - Sistema 4C
- Arquitetura: 3 camadas (Form/BO/DataAccess)
- Tabela banco: [NomeTabela]
- Total campos: [N]

## TAREFA
Criar arquivo [Entidade]BO.prg com TODAS as propriedades da tabela [NomeTabela].

## CAMPOS DA TABELA (TODOS)
[Colar lista do schema.sql]

## REGRAS OBRIGATÓRIAS
1. Herdar de BusinessBase (app/classes/businessbase.prg)
2. Declarar TODAS as [N] propriedades (this_c*, this_n*, this_d*, this_l*)
3. Init(): Definir this_cTabela e this_cCampoChave
4. CarregarDoCursor(): Carregar TODOS os campos
5. Inserir(): SQL INSERT com TODOS os campos
6. Atualizar(): SQL UPDATE com TODOS os campos
7. ObterChavePrimaria(): Retornar PK

## REFERÊNCIAS
- Consultar: C:\4c\CLAUDE.md (seção Business Objects)
- Exemplo: C:\4c\projeto\app\classes\CorBO.prg
- Schema: C:\4c\docs\schema.sql

## ENTREGA ESPERADA
- Arquivo [Entidade]BO.prg completo
- TODOS os [N] campos implementados
- Métodos CRUD funcionais
- Sem erros de sintaxe VFP

## VALIDAÇÃO
✅ Código compila sem erros
✅ TODOS os campos têm propriedade correspondente
✅ CarregarDoCursor() completo
✅ Inserir()/Atualizar() completos
```

### 4.2 Template: Adicionar Campos ao Form

```markdown
# PROMPT: Adicionar Campos GRUPO [A/B/C] ao Form[Entidade]

## CONTEXTO
- Form[Entidade].prg já existe com estrutura base (PageFrame, Containers)
- [Entidade]BO.prg já existe com todas as propriedades
- Esta é a FASE 3[A/B/C] de [X] fases totais

## TAREFA
Adicionar campos do GRUPO [A/B/C] ao método ConfigurarPaginaDados().

## CAMPOS DESTE GRUPO (TODOS - [N] campos)
[Tabela com: Nome, Tipo, Top, Left, Width, Height, InputMask, Lookup?]

## REGRAS OBRIGATÓRIAS
1. Copiar propriedades visuais EXATAS do original (Top, Left, Width, Height, BackColor, etc.)
2. Usar prefixo _4c_ em nomes (txt_4c_Codigo, lbl_4c_Codigo)
3. Inicializar .Value corretamente ("" para string, 0 para numérico, {} para data)
4. NÃO implementar lookups (será próxima fase)
5. NÃO implementar FormParaBO/BOParaForm (será próxima fase)

## CÓDIGO ORIGINAL (Referência)
[Colar seção do codigo_fonte.txt com estes campos]

## ENTREGA ESPERADA
- Método ConfigurarPaginaDados() atualizado
- TODOS os [N] campos deste grupo implementados
- Labels + TextBoxes/ComboBoxes/CheckBoxes
- Sem erros de sintaxe VFP

## VALIDAÇÃO
✅ Código compila sem erros
✅ Form abre e exibe TODOS os campos deste grupo
✅ Propriedades visuais EXATAS (usar ValidarUIFidelity.prg)
```

### 4.3 Template: Implementar Lookups

```markdown
# PROMPT: Implementar Lookups no Form[Entidade]

## CONTEXTO
- Form[Entidade].prg já tem TODOS os campos criados
- Inventário identifica [N] lookups

## TAREFA
Implementar TODOS os [N] lookups identificados.

## LOOKUPS A IMPLEMENTAR
| Campo | Tecla | Tabela Lookup | Campos Retorno |
|-------|-------|---------------|----------------|
| txt_4c_CodigoCliente | F4 | SigCdCli | Iclis, Rclis |
| txt_4c_CodigoProduto | F4 | SigCdPro | cpros, dpros |
| ... | ... | ... | ... |

## REGRAS OBRIGATÓRIAS
1. Usar FormBuscaAuxiliar (padrão do projeto)
2. BINDEVENT nos TextBoxes (KeyPress para F4)
3. Atualizar campos dependentes após seleção
4. Validar código digitado manualmente
5. Seguir padrão docs/lookup_implementation.md

## CÓDIGO ORIGINAL (Referência)
[Colar procedures de lookup do codigo_fonte.txt]

## ENTREGA ESPERADA
- Métodos Lookup[Campo]() para TODOS os lookups
- BINDEVENT configurados
- Validação de código manual
- Sem erros de sintaxe VFP

## VALIDAÇÃO
✅ F4 abre FormBuscaAuxiliar
✅ Seleção preenche campo + dependentes
✅ ESC cancela sem preencher
✅ Código inválido exibe erro
```

### 4.4 Template: Implementar FormParaBO/BOParaForm

```markdown
# PROMPT: Sincronizar Form ↔ BO (FormParaBO/BOParaForm)

## CONTEXTO
- Form[Entidade].prg tem TODOS os campos criados
- [Entidade]BO.prg tem TODAS as propriedades
- Total de campos: [N]

## TAREFA
Implementar sincronização COMPLETA entre Form e BO.

## CAMPOS A SINCRONIZAR (TODOS - [N] campos)
| Campo Form | Propriedade BO | Tipo | Conversão |
|------------|----------------|------|-----------|
| txt_4c_Codigo.Value | this_cCodigo | String | ALLTRIM() |
| txt_4c_Preco.Value | this_nPreco | Numeric | Direto (já numérico) |
| txt_4c_Data.Value | this_dData | Date | Direto |
| ... | ... | ... | ... |

## REGRAS OBRIGATÓRIAS
1. FormParaBO(): TODOS os campos Form → BO
   - VAL() apenas em strings inicializadas com ""
   - Campos numéricos (Value=0) → NÃO usar VAL()
2. BOParaForm(): TODOS os campos BO → Form
   - Atribuição direta
3. HabilitarCampos(): ReadOnly por modo
   - INCLUIR/ALTERAR: .ReadOnly = .F.
   - VISUALIZAR: .ReadOnly = .T.

## ENTREGA ESPERADA
- FormParaBO() completo ([N] campos)
- BOParaForm() completo ([N] campos)
- HabilitarCampos() completo
- Sem erros de sintaxe VFP

## VALIDAÇÃO
✅ INCLUIR: Salva TODOS os campos
✅ ALTERAR: Carrega e atualiza TODOS os campos
✅ VISUALIZAR: Exibe TODOS os campos (readonly)
```

---

## 5. ORGANIZAÇÃO DE ARQUIVOS POR FASE

### 5.1 Estrutura de Workspace

```
tasks/taskXXX_[FormName]/
│
├── 00_INVENTARIO/
│   ├── [FormName]_inventario.json         # Metadados estruturados
│   ├── [FormName]_codigo_fonte.txt        # Código extraído completo
│   └── [FormName]_schema.sql              # Schema da(s) tabela(s)
│
├── 01_BUSINESS_OBJECT/
│   ├── [Entidade]BO.prg                   # BO completo
│   └── teste_BO.prg                       # Script de teste
│
├── 02_FORM_ESTRUTURA/
│   ├── Form[Entidade]_v1_estrutura.prg    # Fase 2A-2C
│   └── screenshots/                       # Capturas de tela
│
├── 03_CAMPOS_ENTRADA/
│   ├── Form[Entidade]_v2_grupoA.prg       # Campos 1-20
│   ├── Form[Entidade]_v3_grupoB.prg       # Campos 21-40
│   └── Form[Entidade]_v4_grupoC.prg       # Campos 41-N
│
├── 04_LOOKUPS/
│   ├── Form[Entidade]_v5_lookups.prg      # Todos lookups
│   └── teste_lookups.prg                  # Script de teste
│
├── 05_GRIDS/
│   ├── Form[Entidade]_v6_grids.prg        # Grids de detalhe
│   └── teste_grids.prg
│
├── 06_SINCRONIZACAO/
│   ├── Form[Entidade]_v7_sync.prg         # FormParaBO/BOParaForm
│   └── teste_crud.prg
│
├── 07_LOGICA_NEGOCIO/
│   ├── Form[Entidade]_v8_procedures.prg   # Procedures customizados
│   └── teste_calculos.prg
│
├── 08_VALIDACAO_FINAL/
│   ├── Form[Entidade]_FINAL.prg           # Versão final
│   ├── relatorio_uifidelity.html          # Resultado ValidarUIFidelity
│   ├── checklist_qa.md                    # Checklist preenchido
│   └── screenshots_comparacao/            # Original vs Novo
│
└── README.md                              # Índice das fases
```

### 5.2 README.md do Workspace (Template)

```markdown
# Migração: [FormName]

## Informações Gerais
- **Formulário Original**: [caminho].scx
- **Tamanho**: [X]MB / [Y]k linhas
- **Classe Base**: frmcadastro
- **Tabela Principal**: [NomeTabela]
- **Total Campos**: [N]
- **Início**: [Data]
- **Status**: [Em Andamento/Concluído]

## Fases Concluídas
- [x] FASE 0: Inventário
- [x] FASE 1: Business Object ([N] campos)
- [x] FASE 2: Estrutura Visual
- [ ] FASE 3: Campos (20/67 implementados)
- [ ] FASE 4: Lookups (0/8 implementados)
- [ ] FASE 5: Grids (0/3 implementados)
- [ ] FASE 6: Sincronização
- [ ] FASE 7: Lógica Negócio
- [ ] FASE 8: Validação Final

## Versões do Form
| Versão | Fase | Descrição | Arquivo |
|--------|------|-----------|---------|
| v1 | 2A-2C | Estrutura base (PageFrame, Containers) | Form[Entidade]_v1_estrutura.prg |
| v2 | 3A | Campos Grupo A (1-20) | Form[Entidade]_v2_grupoA.prg |
| v3 | 3B | Campos Grupo B (21-40) | Form[Entidade]_v3_grupoB.prg |
| v4 | 3C | Campos Grupo C (41-67) | Form[Entidade]_v4_grupoC.prg |
| v5 | 4 | Lookups (8/8) | Form[Entidade]_v5_lookups.prg |
| ... | ... | ... | ... |
| vFINAL | 8 | Versão final (paridade 100%) | Form[Entidade]_FINAL.prg |

## Próximos Passos
1. Completar FASE 3C (campos 41-67)
2. Implementar lookups (FASE 4)
3. ...
```

---

## 6. CRITÉRIOS DE ACEITE POR FASE

### 6.1 Checklist de Validação

#### FASE 1: Business Object
```
[ ] BO compila sem erros VFP
[ ] TODAS as [N] propriedades declaradas
[ ] Init() define this_cTabela e this_cCampoChave corretos
[ ] CarregarDoCursor() carrega TODOS os campos
[ ] Inserir() insere TODOS os campos (SQL válido)
[ ] Atualizar() atualiza TODOS os campos (SQL válido)
[ ] ObterChavePrimaria() retorna PK correta
[ ] Teste manual: Salvar() funciona (novo registro)
[ ] Teste manual: Salvar() funciona (atualização)
[ ] LogAuditoria registra operações
```

#### FASE 2: Estrutura Visual
```
[ ] Form compila sem erros VFP
[ ] Form abre sem erros em runtime
[ ] Width/Height/Caption/BackColor idênticos ao original
[ ] PageFrame criado (Top=-29, Tabs=.F.)
[ ] Page1 criada (para lista)
[ ] Page2 criada (para dados)
[ ] Container de botões CRUD criado (6 botões)
[ ] Botões CRUD visíveis e com ícones corretos
[ ] Grid de lista criado (vazio ok)
[ ] Containers de grupos criados em Page2
[ ] ValidarUIFidelity: estrutura básica 0 erros críticos
```

#### FASE 3: Campos de Entrada
```
[ ] TODOS os [N] campos têm Label + Control
[ ] Propriedades visuais EXATAS (Top, Left, Width, Height)
[ ] BackColor/ForeColor idênticos ao original
[ ] FontName/FontSize idênticos ao original
[ ] InputMask correto (para campos numéricos/data)
[ ] Value inicializado corretamente ("", 0, {}, .F.)
[ ] Campos visíveis e posicionados corretamente
[ ] ValidarUIFidelity: campos deste grupo 0 erros críticos
```

#### FASE 4: Lookups
```
[ ] TODOS os lookups têm método Lookup[Campo]()
[ ] BINDEVENT configurado (KeyPress, tecla F4)
[ ] F4 abre FormBuscaAuxiliar
[ ] Seleção preenche campo principal
[ ] Seleção preenche campos dependentes
[ ] ESC cancela sem preencher
[ ] Código manual validado (campo perde foco)
[ ] Código inválido exibe mensagem de erro
[ ] Teste manual: TODOS os lookups funcionam
```

#### FASE 5: Grids de Detalhe
```
[ ] Grid criado com TODAS as colunas
[ ] RecordSource configurado
[ ] ControlSource de TODAS as colunas
[ ] Larguras de colunas idênticas ao original
[ ] Headers com Caption correto
[ ] Lookups internos funcionam (TextBoxGridLookup)
[ ] AdicionarItem() funcional
[ ] RemoverItem() funcional
[ ] EditarItem() funcional
[ ] Totalizadores atualizam automaticamente
```

#### FASE 6: Sincronização
```
[ ] FormParaBO(): TODOS os [N] campos sincronizam
[ ] BOParaForm(): TODOS os [N] campos sincronizam
[ ] HabilitarCampos(): TODOS os campos ReadOnly correto
[ ] Teste INCLUIR: TODOS os campos salvam no banco
[ ] Teste ALTERAR: TODOS os campos carregam do banco
[ ] Teste ALTERAR: TODOS os campos atualizam no banco
[ ] Teste VISUALIZAR: TODOS os campos exibem (readonly)
[ ] SQL Server: SELECT * mostra TODOS os campos preenchidos
```

#### FASE 7: Lógica de Negócio
```
[ ] TODOS os procedures customizados implementados
[ ] Cálculos automáticos corretos
[ ] Validações complexas funcionais
[ ] Comportamento idêntico ao original
[ ] Teste comparativo: novo vs antigo (mesmos dados)
```

#### FASE 8: Validação Final
```
[ ] ValidarUIFidelity.prg: ≤37 problemas (Dataenvironment + FormBase)
[ ] Screenshot lado-a-lado: 0 diferenças visuais
[ ] Teste INCLUIR: completo e funcional
[ ] Teste ALTERAR: completo e funcional
[ ] Teste VISUALIZAR: completo e funcional
[ ] Teste EXCLUIR: completo e funcional
[ ] TODOS os lookups funcionais
[ ] TODOS os grids funcionais
[ ] TODAS as validações ativas
[ ] TODOS os cálculos corretos
[ ] Comparação com sistema legado: comportamento idêntico
[ ] Documentação atualizada (CLAUDE.md, config.prg)
[ ] Arquivos .fxp deletados
[ ] Commit realizado
```

---

## 7. GESTÃO DE CONTEXTO (IMPORTANTE)

### 7.1 Princípio: Stateless Entre Fases

Cada fase DEVE ser **autocontida** para evitar dependência de contexto anterior:

```
❌ ERRADO - Prompt dependente:
"Continue implementando os campos do Form[Entidade]"
(Assume que Claude lembra da fase anterior)

✅ CORRETO - Prompt autocontido:
"CONTEXTO: Form[Entidade] já existe com estrutura base (arquivo anexo).
 TAREFA: Adicionar campos do GRUPO B (campos 21-40).
 CAMPOS: [listar todos].
 ENTREGA: Código completo atualizado."
```

### 7.2 Checklist de Prompt Autocontido

```
[ ] CONTEXTO: Explica estado atual do projeto
[ ] ENTRADA: Lista TODOS os arquivos/dados necessários
[ ] TAREFA: Descreve EXATAMENTE o que fazer
[ ] REGRAS: Lista restrições obrigatórias
[ ] ENTREGA: Define critério de aceite
[ ] VALIDAÇÃO: Checklist de testes
```

### 7.3 Uso de Arquivos de Referência

Cada prompt DEVE referenciar arquivos:

```markdown
## ARQUIVOS DE REFERÊNCIA
1. C:\4c\CLAUDE.md (regras do projeto)
2. C:\4c\docs\[topico].md (padrões específicos)
3. C:\4c\projeto\app\classes\FormBase.prg (classe base)
4. C:\4c\tasks\taskXXX\[arquivo]_v[N].prg (versão anterior)
5. C:\4c\tasks\taskXXX\inventario.json (metadados)
```

---

## 8. MÉTRICAS DE SUCESSO

### 8.1 KPIs por Fase

| Fase | Métrica | Meta |
|------|---------|------|
| 0. Inventário | Campos mapeados vs Total | 100% |
| 1. BO | Propriedades declaradas vs Total | 100% |
| 2. Estrutura | Form abre sem erros | SIM |
| 3. Campos | Campos implementados vs Total | 100% |
| 4. Lookups | Lookups funcionais vs Total | 100% |
| 5. Grids | Grids funcionais vs Total | 100% |
| 6. Sincronização | Campos sincronizando vs Total | 100% |
| 7. Lógica | Procedures implementados vs Total | 100% |
| 8. Validação | ValidarUIFidelity erros críticos | 0 |

### 8.2 Definição de "Concluído"

Uma fase está **concluída** quando:
1. ✅ Checklist de validação 100% preenchido
2. ✅ Código compila sem erros VFP
3. ✅ Testes manuais passam
4. ✅ Próxima fase pode iniciar sem blockers

Um formulário está **concluído** quando:
1. ✅ TODAS as 8 fases concluídas
2. ✅ ValidarUIFidelity ≤37 problemas aceitáveis
3. ✅ Testes CRUD completos passam
4. ✅ Comparação com legado: comportamento idêntico

---

## 9. TROUBLESHOOTING

### 9.1 Problemas Comuns

| Problema | Causa | Solução |
|----------|-------|---------|
| "Contexto insuficiente" | Arquivo muito grande | Dividir em mais sub-fases |
| "Campos faltando" | Inventário incompleto | Refazer FASE 0 |
| "Propriedades erradas" | Cópia manual com erro | Usar ValidarUIFidelity para identificar |
| "Lookup não funciona" | BINDEVENT incorreto ou método PROTECTED | Verificar BINDEVENT + tornar método PUBLIC |
| "Grid perde formatação" | RecordSource reseta colunas | Reconfigurar APÓS RecordSource |
| "FormParaBO erro tipo" | VAL() em campo numérico | Verificar tipo do TextBox.Value |

### 9.2 Quando Re-dividir uma Fase

Se uma sub-fase ainda está grande demais:

**Sintomas**:
- Timeout na geração de código
- Código incompleto (termina no meio)
- Erros de "contexto insuficiente"

**Solução**:
1. Dividir sub-fase em 2 partes menores
2. Exemplo: FASE 3A (campos 1-20) → 3A1 (1-10) + 3A2 (11-20)
3. Manter mesmo padrão de prompt autocontido

---

## 10. CONCLUSÃO

### 10.1 Resumo da Metodologia

```
┌─────────────────────────────────────────────────────────────┐
│  METODOLOGIA DE ARQUIVOS GRANDES - RESUMO                   │
├─────────────────────────────────────────────────────────────┤
│  1. DIVIDIR por CAMADAS (não por importância)               │
│  2. PROCESSAR em FASES sequenciais                          │
│  3. VALIDAR incrementalmente (cada fase)                    │
│  4. INTEGRAR ao final (paridade 100%)                       │
│                                                             │
│  ✅ SEMPRE: Funcionalidade completa                         │
│  ❌ NUNCA: Versões reduzidas ou MVPs                        │
└─────────────────────────────────────────────────────────────┘
```

### 10.2 Garantias de Qualidade

Seguindo esta metodologia, você garante:
- ✅ **Paridade funcional 100%** com sistema legado
- ✅ **Rastreabilidade** total (cada campo mapeado)
- ✅ **Validação incremental** (erros detectados cedo)
- ✅ **Reutilização** (mesma metodologia para qualquer form grande)
- ✅ **Documentação** (inventário + histórico de versões)

### 10.3 Aplicabilidade

Esta metodologia é aplicável a:
- ✅ Formulários VFP9 grandes (>1MB)
- ✅ Formulários complexos (muitos lookups/grids)
- ✅ Formulários com lógica customizada
- ✅ Qualquer migração que exceda limite de contexto

---

**Última atualização**: 2026-02-12
**Versão**: 1.0
