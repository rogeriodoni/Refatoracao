# ExtractSCXCode.prg - Guia Completo

**Versão**: 1.0
**Data**: 2026-01-16
**Localização**: `C:\4c\ExtractSCXCode.prg`

---

## 📋 Visão Geral

**ExtractSCXCode.prg** é uma ferramenta que extrai código-fonte de arquivos binários do Visual FoxPro 9 e converte para texto legível (.txt).

**Propósito**: Permitir análise, documentação e migração de formulários, classes visuais e relatórios sem precisar abrir os arquivos no VFP IDE.

---

## 🎯 Quando Usar

### Use ExtractSCXCode quando:

1. **Iniciar migração de formulário** - Primeira etapa de TODA migração
2. **Analisar estrutura de formulário legado** - Entender objetos, propriedades, eventos
3. **Documentar sistema existente** - Gerar documentação técnica
4. **Investigar problemas** - Analisar código sem IDE
5. **Extrair múltiplos formulários** - Processar pasta inteira com wildcard

### Não use quando:

- Precisar **editar** o formulário (use o VFP IDE)
- Arquivo já foi extraído e não mudou desde então

---

## ⚙️ Como Funciona

O script:
1. Abre o arquivo binário (.SCX/.VCX/.FRX) como tabela DBF
2. Lê os campos MEMO (METHODS, PROPERTIES, etc.)
3. Organiza em 4 seções estruturadas
4. Salva em arquivo .txt com encoding Windows-1252 (preserva acentuação pt-BR)

**Importante**: Não modifica o arquivo original - apenas lê e extrai.

---

## 📦 Tipos de Arquivos Suportados

| Tipo | Extensão | Saída | Conteúdo Extraído |
|------|----------|-------|-------------------|
| **Formulários** | `.SCX` | `*_form_codigo_fonte.txt` | Estrutura, propriedades, métodos, eventos |
| **Classes Visuais** | `.VCX` | `*_class_codigo_fonte.txt` | Definições de classes, hierarquia, código |
| **Relatórios** | `.FRX` | `*_report_codigo_fonte.txt` | Bandas, campos, expressões, labels |

---

## 🚀 Como Usar

### Sintaxe Básica

```foxpro
DO ExtractSCXCode WITH "C:\Caminho\Arquivo.scx"
```

### Exemplos Práticos

#### 1. Extrair Formulário Único (Task1)

```foxpro
CD C:\4c
DO ExtractSCXCode WITH "tasks\task1\SIGCDCOR.SCX"

*-- Gera: C:\4c\tasks\task1\SIGCDCOR_form_codigo_fonte.txt
```

#### 2. Extrair Classe Visual (Framework)

```foxpro
CD C:\4c
DO ExtractSCXCode WITH "Framework\FRAMEWORK.VCX"

*-- Gera: C:\4c\Framework\FRAMEWORK_class_codigo_fonte.txt
```

#### 3. Extrair Relatório

```foxpro
CD C:\4c
DO ExtractSCXCode WITH "tasks\relatorios\RelCores.FRX"

*-- Gera: C:\4c\tasks\relatorios\RelCores_report_codigo_fonte.txt
```

#### 4. Extrair TODOS os Formulários de uma Pasta (Wildcard)

```foxpro
CD C:\4c
DO ExtractSCXCode WITH "tasks\task*\*.SCX"

*-- Processa TODOS os .SCX encontrados em task1, task2, task3, etc.
*-- Gera múltiplos *_form_codigo_fonte.txt
```

#### 5. Modo Interativo (Sem Parâmetro)

```foxpro
DO ExtractSCXCode
*-- Abre janela de seleção de arquivo
```

---

## 📄 Formato de Saída

Todos os arquivos .txt gerados seguem a estrutura:

### Para Formulários/Classes (.SCX/.VCX)

```
===============================================================================
* EXTRACAO DE CODIGO - VISUAL FOXPRO
* Arquivo Origem: SIGCDCOR.SCX
* Data/Hora: 16/01/2026 10:30:00
* Total de registros: 156
===============================================================================

===============================================================================
* SECAO 1: ESTRUTURA DO FORMULARIO (ARVORE DE OBJETOS)
===============================================================================

Objeto: SIGCDCOR
  Parent: (raiz)
  Class: form
  BaseClass: form

Objeto: Pagina
  Parent: SIGCDCOR
  Class: pageframe
  BaseClass: pageframe

Objeto: Lista
  Parent: Pagina
  Class: page
  BaseClass: page

...

===============================================================================
* SECAO 2: PROPRIEDADES CUSTOMIZADAS
===============================================================================

------------------------------------------------------------
* PROPRIEDADES DE: SIGCDCOR
------------------------------------------------------------
  Top = 0
  Left = 0
  Height = 580
  Width = 800
  Caption = "Cadastro de Cores"
  BackColor = RGB(255,255,255)
  ...

===============================================================================
* SECAO 3: METODOS E EVENTOS (CODIGO FONTE)
===============================================================================

===============================================================================
* OBJETO: SIGCDCOR
* Classe: form (Base: form)
* Registro: 1
===============================================================================

------------------------------------------------------------
* PROCEDURE Init
------------------------------------------------------------
PROCEDURE Init
    LOCAL loc_lSucesso
    loc_lSucesso = .T.

    THIS.ConfigurarFormulario()

    RETURN loc_lSucesso
ENDPROC

...

===============================================================================
* SECAO 4: INFORMACOES ADICIONAIS
===============================================================================

* Objeto: SIGCDCOR
USER: Custom user data
RESERVED1 (Include): sigcdcor.h
PICTURE: C:\4c\vbmp\fundo.jpg

...

===============================================================================
* FIM DA EXTRACAO
* Total de metodos/eventos com codigo: 47
===============================================================================
```

### Para Relatórios (.FRX)

```
===============================================================================
* EXTRACAO DE RELATORIO - VISUAL FOXPRO
* Arquivo Origem: RelCores.FRX
* Data/Hora: 16/01/2026 10:30:00
* Total de registros: 89
===============================================================================

===============================================================================
* SECAO 1: CONFIGURACAO DO RELATORIO
===============================================================================

Fonte de Dados (EXPR): cursor_4c_Relatorio
Tag: cods
Tag2:

===============================================================================
* SECAO 2: BANDAS DO RELATORIO
===============================================================================

Banda: Cabecalho da Pagina
  Altura: 1800
  Expressao:

Banda: Detalhe
  Altura: 500

Banda: Rodape da Pagina
  Altura: 600

...

===============================================================================
* SECAO 3: CAMPOS E EXPRESSOES
===============================================================================

------------------------------------------------------------
Campo: codigo
Expressao: cursor_4c_Relatorio.cods
Mascara: @!
Posicao: 100, 200
Tamanho: 2000 x 400

...

===============================================================================
* SECAO 4: LABELS (TEXTOS FIXOS)
===============================================================================

Label: Código
  Posicao: 100, 150

Label: Descrição
  Posicao: 2500, 150

...

===============================================================================
* SECAO 5: IMAGENS
===============================================================================

Imagem: logo
  Arquivo: C:\4c\vbmp\logo.jpg
  Posicao: 500, 100
  Tamanho: 2000 x 1500

...

===============================================================================
* SECAO 6: LINHAS E FORMAS
===============================================================================

Linha
  Posicao: 0, 1750
  Tamanho: 10000 x 50

Retangulo
  Posicao: 500, 500
  Tamanho: 5000 x 800

...

===============================================================================
* FIM DA EXTRACAO
* Total de elementos extraidos: 42
===============================================================================
```

---

## 📊 Integração no Workflow de Migração

### Fase 1: Preparação (OBRIGATÓRIO)

```
┌─────────────────────────────────────────────────────────────┐
│ PASSO 1: Identificar task (ex: task1 = SIGCDCOR.SCX)       │
└─────────────────────────────────────────────────────────────┘
                           ↓
┌─────────────────────────────────────────────────────────────┐
│ PASSO 2: Extrair código-fonte com ExtractSCXCode           │
│                                                             │
│   DO ExtractSCXCode WITH "tasks\task1\SIGCDCOR.SCX"        │
│                                                             │
│   Gera: tasks\task1\SIGCDCOR_form_codigo_fonte.txt         │
└─────────────────────────────────────────────────────────────┘
                           ↓
┌─────────────────────────────────────────────────────────────┐
│ PASSO 3: Analisar código extraído                          │
│   - Identificar campos (ControlSource)                      │
│   - Identificar lookups (fwbuscaext, sigacess)             │
│   - Identificar validações (PROCEDURE Valid)               │
│   - Copiar propriedades visuais (Width, Height, etc.)      │
└─────────────────────────────────────────────────────────────┘
                           ↓
┌─────────────────────────────────────────────────────────────┐
│ PASSO 4: Preencher tabela de análise pré-migração          │
│   (ver docs/migration_guide.md - Seção "Pre-Migration")    │
└─────────────────────────────────────────────────────────────┘
```

### Fluxo Completo das Ferramentas

| Fase | Ferramenta | Entrada | Saída | Status |
|------|------------|---------|-------|--------|
| **1. Extração** | **ExtractSCXCode.prg** | SIGCDCOR.SCX | SIGCDCOR_form_codigo_fonte.txt | ← **VOCÊ ESTÁ AQUI** |
| 2. Análise | *(Manual - ler .txt)* | SIGCDCOR_form_codigo_fonte.txt | Tabela de análise | - |
| 3. Implementação | *(Desenvolver)* | - | FormCor.prg + CorBO.prg | - |
| 4. Mapeamento | GeradorMapeamento.prg | SIGCDCOR_form_codigo_fonte.txt + FormCor | FormCor_mapeamento.json | - |
| 5. Validação | ValidarUIFidelity.prg | Todos acima | Relatório HTML | - |

---

## 🔍 O Que Extrair de Cada Seção

### SEÇÃO 1: Estrutura do Formulário

**Use para**:
- Mapear hierarquia de objetos (Parent-Child)
- Identificar PageFrames e Pages
- Contar quantidade de controles por tipo

**Exemplo de análise**:
```
Objeto: Pagina → PageFrame principal
Objeto: Lista (Parent: Pagina) → Page1
Objeto: Dados (Parent: Pagina) → Page2
Objeto: Grade (Parent: Lista) → Grid na Page1
```

### SEÇÃO 2: Propriedades Customizadas

**Use para**:
- Copiar propriedades visuais EXATAS (Width, Height, Top, Left, BackColor, FontSize)
- Identificar InputMask de campos
- Verificar RecordSource de grids

**Exemplo de análise**:
```
* PROPRIEDADES DE: Text1
  ControlSource = "SIGCDCOR->cods"      ← Campo da tabela (PK)
  InputMask = "XXXXXXXXXX"               ← Máscara de entrada
  MaxLength = 10                         ← Tamanho máximo
  Width = 120                            ← COPIAR EXATO
  Height = 25                            ← COPIAR EXATO
  Top = 127                              ← COPIAR + 29 (compensação PageFrame)
  Left = 151                             ← COPIAR EXATO
  FontName = "Tahoma"                    ← COPIAR EXATO
  FontSize = 8                           ← COPIAR EXATO
```

### SEÇÃO 3: Métodos e Eventos (CÓDIGO FONTE)

**Use para**:
- Identificar lookups (fwbuscaext, sigacess)
- Identificar validações (PROCEDURE Valid)
- Entender regras de negócio
- Copiar lógica de cálculos

**Exemplo de análise**:
```
PROCEDURE Text3.Valid
    *-- Campo: Grupo (cgrus)
    *-- Validação: Código deve existir na tabela SigCdGrp
    IF !EMPTY(THIS.Value)
        IF !SEEK(THIS.Value, "SigCdGrp", "cgrus")
            MESSAGEBOX("Grupo não encontrado!")
            RETURN 0  ← Impede saída do campo
        ENDIF
    ENDIF
    RETURN 1
ENDPROC

PROCEDURE Text3.DblClick
    *-- Lookup no duplo-clique
    DO fwbuscaext WITH "SigCdGrp", "cgrus", "dgrus", THIS.Value
ENDPROC
```

**Checklist de extração de lookups**:
```
[ ] Identificar campos com fwbuscaext() ou sigacess()
[ ] Anotar: Tabela alvo (SigCdGrp)
[ ] Anotar: Coluna código (cgrus)
[ ] Anotar: Coluna descrição (dgrus)
[ ] Anotar: Evento que dispara (DblClick, KeyPress F4/F5)
```

### SEÇÃO 4: Informações Adicionais

**Use para**:
- Identificar imagens (Picture) do formulário
- Verificar arquivos .h incluídos (RESERVED1)
- Objetos ActiveX/OLE (se houver)

---

## 🧪 Exemplos de Análise Completa

### Exemplo 1: Extrair e Analisar Task1 (FormCor)

```foxpro
*-- 1. Extrair código
CD C:\4c
DO ExtractSCXCode WITH "tasks\task1\SIGCDCOR.SCX"

*-- 2. Abrir arquivo gerado em editor de texto
MODIFY FILE tasks\task1\SIGCDCOR_form_codigo_fonte.txt
```

**Análise**:
```
SEÇÃO 1 - Estrutura:
✓ PageFrame principal: "Pagina"
✓ Page1 = "Lista" (grid de registros)
✓ Page2 = "Dados" (formulário de edição)
✓ Grid: "Grade" (4 colunas)

SEÇÃO 2 - Propriedades:
✓ Form.Width = 800
✓ Form.Height = 580
✓ Text1.ControlSource = "SIGCDCOR->cods" (PK - Código)
✓ Text2.ControlSource = "SIGCDCOR->descs" (Descrição)
✓ Text3.ControlSource = "SIGCDCOR->cgrus" (Grupo - FK)
✓ Text4.ControlSource = "SIGCDCOR->varias" (Variação)

SEÇÃO 3 - Código:
✓ Text3.DblClick → Lookup em SigCdGrp (cgrus, dgrus)
✓ Text8.DblClick → Lookup em SigCdTqe (codigos, descrs)
✓ Text1.Valid → Validação de código único (ALTERAR mode)

SEÇÃO 4 - Adicionais:
✓ PICTURE: C:\4c\vbmp\sigcor.jpg (imagem de fundo)
```

### Exemplo 2: Extrair TODAS as Tasks de uma Vez

```foxpro
CD C:\4c
DO ExtractSCXCode WITH "tasks\*\*.SCX"

*-- Processa:
*-- tasks\task1\SIGCDCOR.SCX → SIGCDCOR_form_codigo_fonte.txt
*-- tasks\task2\SIGCDCAR.SCX → SIGCDCAR_form_codigo_fonte.txt
*-- tasks\task3\SIGCDDEP.SCX → SIGCDDEP_form_codigo_fonte.txt
*-- ... (todos os .SCX encontrados)
```

**Quando usar wildcard**:
- Extrair formulários de múltiplas tasks de uma vez
- Documentar sistema inteiro (gerar .txt de todos .SCX)
- Atualizar extração após mudanças em múltiplos formulários

---

## ❌ Troubleshooting

### Erro: "Arquivo não encontrado"

**Sintoma**:
```
Arquivo não encontrado: C:\4c\tasks\task1\SIGCDCOR.SCX
```

**Soluções**:
1. Verificar se caminho está correto (com `DIR`)
2. Usar caminho absoluto completo
3. Verificar se arquivo existe: `? FILE("tasks\task1\SIGCDCOR.SCX")`

### Erro: "Não foi possível abrir [arquivo]"

**Sintoma**:
```
ERRO: Nao foi possivel abrir C:\4c\tasks\task1\SIGCDCOR.SCX
```

**Causas possíveis**:
- Arquivo está aberto no VFP IDE (fechar antes de extrair)
- Arquivo corrompido (tentar reparar com VFP: `MODIFY FORM ... NOWAIT` e salvar)
- Permissões de leitura (executar como Administrador)

### Problema: Acentuação errada no .txt

**Sintoma**:
```
Caption = "CÃ³digo"  (em vez de "Código")
```

**Causa**: Editor de texto usando UTF-8 em vez de Windows-1252

**Solução**:
1. Abrir .txt em editor que suporta Windows-1252 (Notepad++, VSCode com encoding correto)
2. Em Notepad++: Menu → Encoding → Character Sets → Western European → Windows-1252
3. Em VSCode: Botão "UTF-8" no canto inferior direito → Reopen with Encoding → Windows 1252

### Problema: Código de método vazio ou truncado

**Sintoma**:
Seção 3 não mostra código esperado de um evento

**Causas possíveis**:
1. Método realmente vazio (código foi deletado ou nunca existiu)
2. Campo MEMO corrompido (raro)

**Verificação**:
```foxpro
*-- Abrir .SCX diretamente e verificar
USE tasks\task1\SIGCDCOR.SCX SHARED NOUPDATE
BROWSE FIELDS objname, methods
*-- Ver se campo METHODS tem conteúdo
```

### Problema: "Total de elementos extraídos: 0"

**Sintoma**:
Extração termina com 0 métodos/elementos

**Causas**:
- Formulário/relatório vazio (sem código customizado)
- Todos os controles usam comportamento padrão (sem PROCEDURE/FUNCTION)

**Solução**: Normal para formulários muito simples. Verificar SEÇÃO 1 e SEÇÃO 2 para estrutura e propriedades.

---

## 📚 Comparação com Outras Ferramentas

| Ferramenta | Propósito | Entrada | Saída | Quando Usar |
|------------|-----------|---------|-------|-------------|
| **ExtractSCXCode** | Extrair código de binário | .SCX/.VCX/.FRX | .txt (código-fonte) | **Fase 1** - Antes de migrar |
| **GeradorMapeamento** | Gerar mapeamento JSON | .txt + FormXxx.prg | .json (mapeamento) | **Fase 3** - Após implementar Form |
| **ValidarUIFidelity** | Validar fidelidade visual | .txt + .json + FormXxx.prg | .html (relatório) | **Fase 4** - Antes de commit |

**Fluxo**:
```
ExtractSCXCode → (desenvolver) → GeradorMapeamento → ValidarUIFidelity
```

---

## 📝 Checklist de Uso

### Antes de Migrar Formulário

```
[ ] 1. Extrair código com ExtractSCXCode
[ ] 2. Abrir *_form_codigo_fonte.txt em editor
[ ] 3. Ler SEÇÃO 1 (estrutura de objetos)
[ ] 4. Ler SEÇÃO 2 (propriedades visuais)
[ ] 5. Ler SEÇÃO 3 (métodos e eventos)
[ ] 6. Identificar TODOS os lookups
[ ] 7. Identificar TODAS as validações
[ ] 8. Copiar propriedades visuais EXATAS
[ ] 9. Preencher tabela de análise pré-migração
[ ] 10. Guardar .txt para usar com GeradorMapeamento depois
```

---

## 🔗 Referências

### Documentação Relacionada

- **GeradorMapeamento.prg**: `docs/gerador_mapeamento_guide.md`
- **ValidarUIFidelity.prg**: `docs/ui_fidelity_validation.md`
- **Migration Guide**: `docs/migration_guide.md` (Seção "Pre-Migration Analysis")
- **Form Patterns**: `docs/form_patterns.md` (Propriedades visuais)

### Arquivos de Exemplo

- **Extração de formulário**: `tasks\task1\SIGCDCOR_form_codigo_fonte.txt`
- **Extração de classe**: `docs\FRAMEWORK_class_codigo_fonte.txt`

---

## 💡 Dicas e Boas Práticas

### 1. Sempre Extrair ANTES de Migrar

```foxpro
*-- ERRADO: Migrar sem extrair
*-- Você vai precisar "adivinhar" propriedades e lookups

*-- CORRETO: Extrair primeiro
DO ExtractSCXCode WITH "tasks\task1\SIGCDCOR.SCX"
*-- Depois ler .txt e planejar migração
```

### 2. Usar Wildcard para Múltiplos Arquivos

```foxpro
*-- DEMORADO: Extrair um por um
DO ExtractSCXCode WITH "tasks\task1\SIGCDCOR.SCX"
DO ExtractSCXCode WITH "tasks\task2\SIGCDCAR.SCX"
DO ExtractSCXCode WITH "tasks\task3\SIGCDDEP.SCX"

*-- RÁPIDO: Extrair todos de uma vez
DO ExtractSCXCode WITH "tasks\*\*.SCX"
```

### 3. Preservar .txt no Repositório

```
tasks/
├── task1/
│   ├── SIGCDCOR.SCX                        (NÃO commitar - binário)
│   └── SIGCDCOR_form_codigo_fonte.txt      (✓ COMMITAR - texto)
├── task2/
│   ├── SIGCDCAR.SCX                        (NÃO commitar)
│   └── SIGCDCAR_form_codigo_fonte.txt      (✓ COMMITAR)
```

**Motivo**: .txt permite code review, diff, e documentação versionada.

### 4. Atualizar Extração Após Mudanças

Se o .SCX original mudar (correções, ajustes), re-extrair:

```foxpro
DO ExtractSCXCode WITH "tasks\task1\SIGCDCOR.SCX"
*-- Sobrescreve SIGCDCOR_form_codigo_fonte.txt
```

### 5. Encoding Correto no Editor

Sempre abrir .txt com **Windows-1252** (não UTF-8) para ver acentuação correta.

**Notepad++**: Encoding → Character Sets → Western European → Windows-1252
**VSCode**: Canto inferior direito → "UTF-8" → Reopen with Encoding → Windows 1252

---

## 📌 Resumo

| Item | Descrição |
|------|-----------|
| **Localização** | `C:\4c\ExtractSCXCode.prg` |
| **Fase** | **1 - Preparação** (ANTES de migrar) |
| **Entrada** | `.SCX` (forms), `.VCX` (classes), `.FRX` (reports) |
| **Saída** | `*_form_codigo_fonte.txt`, `*_class_codigo_fonte.txt`, `*_report_codigo_fonte.txt` |
| **Encoding** | Windows-1252 (preserva acentuação pt-BR) |
| **Uso** | `DO ExtractSCXCode WITH "caminho\arquivo.scx"` |
| **Wildcard** | `DO ExtractSCXCode WITH "tasks\*\*.scx"` |
| **Seções** | 1=Estrutura, 2=Propriedades, 3=Código, 4=Adicionais |

---

**Última atualização**: 2026-01-16
**Autor**: Sistema de Refatoração VFP9
