# UI Fidelity Validation - Validação Automática

## Visão Geral

Sistema automático para validar a fidelidade visual entre formulários originais (legado) e migrados (novo sistema).

### Componentes

| Arquivo | Descrição |
|---------|-----------|
| `ValidarUIFidelity.prg` | Script principal de validação |
| `ExtratorPropriedades.prg` | Extrai propriedades do código fonte original (.txt) |
| `ComparadorUI.prg` | Compara propriedades entre original e migrado |
| `RelatorioUI.prg` | Gera relatório HTML de diferenças |

## Como Usar

### 1. Sintaxe Básica

```foxpro
DO ValidarUIFidelity WITH "caminho\arquivo_original.txt", "NomeClasseForm"
```

### 2. Exemplos Práticos

#### Validar FormCor
```foxpro
CD C:\4c\projeto\app\utils
DO ValidarUIFidelity WITH "task1\SIGCDCOR_codigo_fonte.txt", "FormCor"
```

#### Validar FormCargo
```foxpro
CD C:\4c\projeto\app\utils
DO ValidarUIFidelity WITH "task2\SIGCDCAR_codigo_fonte.txt", "FormCargo"
```

#### Validar FormDepartamento
```foxpro
CD C:\4c\projeto\app\utils
DO ValidarUIFidelity WITH "task3\SIGCDDPT_codigo_fonte.txt", "FormDepartamento"
```

#### Validar FormPlanoContas
```foxpro
CD C:\4c\projeto\app\utils
DO ValidarUIFidelity WITH "task4\SIGREPLC_codigo_fonte.txt", "FormPlanoContas"
```

#### Validar FormProduto
```foxpro
CD C:\4c\projeto\app\utils
DO ValidarUIFidelity WITH "task5\SIGCDPRO_codigo_fonte.txt", "FormProduto"
```

### 3. Caminho Relativo ou Absoluto

```foxpro
*-- Caminho relativo (assume tasks\):
DO ValidarUIFidelity WITH "task1\SIGCDCOR_codigo_fonte.txt", "FormCor"

*-- Caminho absoluto:
DO ValidarUIFidelity WITH "C:\4c\tasks\task1\SIGCDCOR_codigo_fonte.txt", "FormCor"
```

## O Que é Validado

### Propriedades Visuais Críticas

O script verifica **18 propriedades críticas** para fidelidade visual:

| Propriedade | Tipo | Descrição |
|-------------|------|-----------|
| Width | Numeric | Largura do objeto |
| Height | Numeric | Altura do objeto |
| Top | Numeric | Posição Y (topo) |
| Left | Numeric | Posição X (esquerda) |
| BackColor | RGB | Cor de fundo |
| ForeColor | RGB | Cor do texto |
| FontName | String | Nome da fonte |
| FontSize | Numeric | Tamanho da fonte |
| FontBold | Logical | Fonte em negrito |
| FontItalic | Logical | Fonte em itálico |
| BorderStyle | Numeric | Estilo da borda |
| SpecialEffect | Numeric | Efeito especial (flat, raised, sunken) |
| Picture | String | Caminho da imagem |
| Themes | Logical | Usar temas do Windows |
| Caption | String | Título/texto |
| PicturePosition | Numeric | Posição do ícone |
| Alignment | Numeric | Alinhamento do texto |
| InputMask | String | Máscara de entrada |

### Tolerância Numérica

Para propriedades numéricas (Width, Height, Top, Left), o script aplica uma **tolerância de ±2 pixels** para acomodar arredondamentos.

## Tipos de Diferenças Detectadas

| Tipo | Gravidade | Descrição |
|------|-----------|-----------|
| **ERRO** | Crítico | Objeto ou propriedade não encontrado no form migrado |
| **AVISO** | Médio | Propriedade existe mas não está acessível |
| **DIFERENCA** | Baixo | Valores diferentes entre original e migrado |

## Relatório HTML

### Localização

Relatórios são salvos em:
```
C:\4c\projeto\app\utils\relatorios\UIFidelity_[NomeForm]_[Timestamp].html
```

### Estrutura do Relatório

1. **Cabeçalho**
   - Nome do formulário
   - Data/hora da validação

2. **Resumo Executivo**
   - Total de problemas
   - Erros críticos
   - Avisos
   - Diferenças visuais

3. **Tabela Detalhada**
   - Tipo de diferença (badge colorido)
   - Objeto afetado
   - Propriedade
   - Valor original vs migrado
   - Linha no arquivo original

4. **Estatísticas**
   - Contagem por tipo de diferença

### Visualização

O script oferece abrir o relatório automaticamente no navegador após a validação.

## Fluxo de Trabalho Recomendado

### 1. Durante a Migração

```
1. Extrair código fonte do .SCX original para .txt
2. Implementar FormXxx.prg (formulário migrado)
3. EXECUTAR ValidarUIFidelity ANTES de considerar completo
4. Corrigir diferenças encontradas
5. REPETIR validação até 0 diferenças
6. Marcar migração como completa
```

### 2. Antes de Commit

```
1. Executar ValidarUIFidelity para todos os forms migrados
2. Verificar que NENHUMA diferença existe
3. Incluir relatório no commit (opcional)
4. Fazer commit apenas se validação OK
```

### 3. Code Review

```
1. Revisor executa ValidarUIFidelity
2. Verifica relatório gerado
3. Aprova PR apenas se 0 diferenças
```

## Interpretação de Resultados

### ✅ Sucesso (0 Diferenças)

```
*** UI FIDELITY OK - Nenhuma diferença encontrada! ***
```

**Ação**: Formulário aprovado, pode prosseguir.

### ⚠️ Diferenças Encontradas

```
*** AVISO: Diferenças encontradas! Verifique o relatório. ***
Diferenças: 5
Relatório: C:\4c\projeto\app\utils\relatorios\UIFidelity_FormCor_20250112143022.html
```

**Ação**:
1. Abrir relatório HTML
2. Identificar propriedades divergentes
3. Corrigir no FormXxx.prg
4. Reexecutar validação

### 📊 Diferenças Aceitáveis (Esperadas)

Nem todas as diferenças são problemas reais. Algumas são **esperadas e aceitáveis**:

#### 1. ✅ Dataenvironment (4 erros - ACEITÁVEL)

```
ERRO: Dataenvironment.Top = 220 → (objeto não encontrado)
ERRO: Dataenvironment.Left = 1 → (objeto não encontrado)
ERRO: Dataenvironment.Width = 520 → (objeto não encontrado)
ERRO: Dataenvironment.Height = 200 → (objeto não encontrado)
```

**Por que aceitável?**
- Dataenvironment não é visível na UI do usuário
- Nova arquitetura não usa Dataenvironment visual
- Não afeta a experiência do usuário

**Ação**: ✅ Ignorar - não requer correção

#### 2. ✅ Controles do FormBase (~33 avisos - ACEITÁVEL)

```
AVISO: Pagina.Lista.Grade.Height → (propriedade não existe)
AVISO: Pagina.Lista.Grupo_op.Inserir.Top → (propriedade não existe)
AVISO: Pagina.Dados.Grupo_Salva.Salva.Top → (propriedade não existe)
AVISO: Pagina.Lista.Picture → (propriedade não existe)
```

**Por que aceitável?**
- Controles herdados do FormBase (botões CRUD, grupos)
- Criados dinamicamente em tempo de execução
- Posicionados corretamente pelo FormBase.Init()
- Picture de fundo adicionado pelo FormBase

**Ação**: ✅ Ignorar - são criados em tempo de execução

#### 3. ✅ ForeColor Formato (CORRIGIDO - 0 diferenças esperadas)

```
ANTES (bugado):
DIFERENCA: Say1.ForeColor = "90,90,90" vs "RGB(90,90,90)"

DEPOIS (corrigido):
Normalização automática: "90,90,90" → "RGB(90,90,90)"
```

**O que foi corrigido?**
- ComparadorUI.FormatarValor() agora normaliza ambos os formatos
- TextoParaRGB() converte "90,90,90" para "RGB(90,90,90)"
- Valores idênticos não geram mais diferenças

**Ação**: ✅ Nenhuma - correção automática aplicada

#### Meta de Validação Atualizada

**Resultado esperado após correção de normalização:**
```
Total: 37 problemas
- 4 erros (Dataenvironment - OK)
- 33 avisos (FormBase - OK)
- 0 diferenças (ForeColor normalizado)
```

**Se o resultado for diferente de 37:**
- ❌ Mais erros: Objetos reais faltando (Labels, TextBoxes, etc.) - CORRIGIR!
- ❌ Mais diferenças: Propriedades com valores incorretos - CORRIGIR!
- ✅ Menos problemas: Formulário mais simples, sem todos os controles do FormBase - OK!

## Exemplos de Correções Comuns

### Diferença: Width do Form

**Relatório mostra:**
```
Objeto: Form
Propriedade: Width
Valor Original: 800
Valor Migrado: 750
```

**Correção em FormXxx.prg:**
```foxpro
DEFINE CLASS FormXxx AS FormBase
    Width = 800  && Corrigir para valor EXATO do original
    Height = 600
    ...
ENDDEFINE
```

### Diferença: BackColor de TextBox

**Relatório mostra:**
```
Objeto: txt_Codigo
Propriedade: BackColor
Valor Original: RGB(255,255,255)
Valor Migrado: RGB(240,240,240)
```

**Correção em ConfigurarCampos():**
```foxpro
PROCEDURE ConfigurarCampos()
    ...
    loc_oPagina.txt_4c_Codigo.BackColor = RGB(255,255,255)  && Branco exato
    ...
ENDPROC
```

### Diferença: Picture ausente

**Relatório mostra:**
```
Objeto: Page1
Propriedade: Picture
Valor Original: fundo_cad_1003.jpg
Valor Migrado: (propriedade não existe)
```

**Correção em ConfigurarPaginaLista():**
```foxpro
PROCEDURE ConfigurarPaginaLista()
    ...
    loc_oPagina.Picture = "fundo_cad_1003.jpg"
    ...
ENDPROC
```

## Limitações Conhecidas

### 1. Objetos com Nomes Diferentes

Se o objeto no sistema legado tem nome `txt_Codigo` e no migrado é `txt_4c_Codigo`, o script **não encontrará** automaticamente.

**Solução**: Manter nomes compatíveis ou adicionar mapeamento em `ComparadorUI.ResolverObjeto()`.

### 2. Propriedades Calculadas

Propriedades que são calculadas em tempo de execução (ex: Width baseado em outro controle) podem não corresponder ao valor estático do .txt.

**Solução**: Validar visualmente além do script automático.

### 3. Controles Dinâmicos

Controles adicionados dinamicamente em runtime não aparecem no .txt original.

**Solução**: Documentar controles dinâmicos separadamente.

## Integração com CI/CD (Futuro)

### Script de Validação em Lote

```foxpro
*-- ValidarTodos.prg
LOCAL ARRAY loc_aForms[5, 2]

loc_aForms[1, 1] = "task1\SIGCDCOR_codigo_fonte.txt"
loc_aForms[1, 2] = "FormCor"

loc_aForms[2, 1] = "task2\SIGCDCAR_codigo_fonte.txt"
loc_aForms[2, 2] = "FormCargo"

loc_aForms[3, 1] = "task3\SIGCDDPT_codigo_fonte.txt"
loc_aForms[3, 2] = "FormDepartamento"

loc_aForms[4, 1] = "task4\SIGREPLC_codigo_fonte.txt"
loc_aForms[4, 2] = "FormPlanoContas"

loc_aForms[5, 1] = "task5\SIGCDPRO_codigo_fonte.txt"
loc_aForms[5, 2] = "FormProduto"

LOCAL i, loc_lTodosOK
loc_lTodosOK = .T.

FOR i = 1 TO ALEN(loc_aForms, 1)
    ? "Validando " + loc_aForms[i, 2] + "..."
    IF !DO ValidarUIFidelity WITH loc_aForms[i, 1], loc_aForms[i, 2]
        loc_lTodosOK = .F.
    ENDIF
ENDFOR

IF loc_lTodosOK
    ? "*** TODOS OS FORMULARIOS OK ***"
    RETURN 0  && Exit code success
ELSE
    ? "*** ERROS ENCONTRADOS ***"
    RETURN 1  && Exit code error
ENDIF
```

## Troubleshooting

### Erro: "Subscript is outside defined range"

**Causa**: Arquivos .fxp compilados desatualizados em cache após atualização dos scripts.

**Solução**:
1. O script `ValidarUIFidelity.prg` agora limpa automaticamente os arquivos .fxp antes de executar
2. Se o erro persistir, deletar manualmente:
   ```bash
   DEL C:\4c\projeto\app\utils\*.fxp
   ```
3. Executar novamente o ValidarUIFidelity

### Erro: "Arquivo original não encontrado"

**Causa**: Caminho do .txt incorreto.

**Solução**: Verificar se arquivo existe em `C:\4c\tasks\taskX\arquivo.txt`.

### Erro: "Nenhuma propriedade encontrada no arquivo original"

**Causa**: Formato do arquivo .txt não está correto ou não contém a "SECAO 2: PROPRIEDADES CUSTOMIZADAS".

**Solução**:
1. Verificar se arquivo foi extraído corretamente do SCX original
2. Procurar por linha contendo "* SECAO 2: PROPRIEDADES CUSTOMIZADAS"
3. Verificar se há linhas "* PROPRIEDADES DE: xxx" seguidas de propriedades

### Erro: "Erro ao instanciar formulário"

**Causa**: Classe do form não está carregada ou nome incorreto.

**Solução**:
1. Verificar se `SET PROCEDURE TO FormXxx.prg ADDITIVE` foi executado em `config.prg`
2. Verificar se nome da classe está correto (case-sensitive)

### Relatório com muitos "objeto não encontrado"

**Causa**: Estrutura do form migrado muito diferente do original.

**Solução**: Revisar arquitetura do form migrado para manter estrutura próxima ao original.

## Contribuindo

### Adicionar Nova Propriedade Crítica

Editar `ExtratorPropriedades.prg`:

```foxpro
DIMENSION aPropriedadesCriticas[19]  && Aumentar tamanho
...
aPropriedadesCriticas[19] = "NovaPropriedade"
```

### Melhorar Mapeamento de Objetos

Editar `ComparadorUI.ResolverObjeto()` para adicionar novos prefixos:

```foxpro
*-- Remove prefixos comuns do sistema legado
par_cCaminho = STRTRAN(par_cCaminho, "NovoFormLegado.", "")
```

## Referências

- **CLAUDE.md**: Seção "UI FIDELITY - REGRA CRITICA (OBRIGATORIO)"
- **docs/migration_guide.md**: Processo de migração completo
- **docs/form_patterns.md**: Padrões visuais dos formulários
