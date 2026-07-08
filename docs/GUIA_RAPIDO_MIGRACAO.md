# Guia Rápido de Migração - 7 Passos

**Versão**: 1.1 (Corrigido)
**Data**: 2026-01-16
**Objetivo**: Migrar formulário do sistema legado para nova arquitetura

---

## 📋 Pré-requisitos

- Visual FoxPro 9 instalado
- Claude Code configurado
- Conexão com SQL Server (192.168.15.101)
- Arquivo .SCX original na pasta `tasks\taskX\`

---

## 🚀 Os 7 Passos da Migração (ORDEM CORRIGIDA)

### Passo 1: Extrair Código-Fonte do .SCX

**Objetivo**: Converter arquivo binário (.SCX) para texto legível (.txt)

**Comando**:
```foxpro
DO C:\4c\ExtractSCXCode WITH "C:\4c\tasks\task1\SIGCDCOR.SCX"
```

**Resultado esperado**:
```
✅ Arquivo gerado: C:\4c\tasks\task1\SIGCDCOR_form_codigo_fonte.txt
✅ Console mostra: "Extraidos XX elementos para: ..."
```

**Documentação**: `docs/ExtractSCXCode_guide.md`

---

### Passo 2: Gerar Mapeamento JSON (Contrato de Nomenclatura)

**Objetivo**: Criar mapeamento entre objetos originais e novos (padrão _4c_) ANTES de implementar

**Comando**:
```foxpro
DO C:\4c\projeto\app\utils\GeradorMapeamento WITH "tasks\task1\SIGCDCOR_form_codigo_fonte.txt", "FormCor"
```

**⚠️ ATENÇÃO AO CAMINHO**:
- ✅ CORRETO: `"tasks\task1\SIGCDCOR_form_codigo_fonte.txt"`
- ❌ ERRADO: `"task1\SIGCDCOR_form_codigo_fonte.txt"` (falta "tasks\")

**Resultado esperado**:
```
✅ Arquivo gerado: C:\4c\projeto\app\utils\mapeamentos\FormCor_mapeamento.json
✅ Console mostra: "Mapeamento gerado com sucesso"
✅ Console mostra: "XX objetos mapeados"
```

**IMPORTANTE**: O JSON serve como **"contrato de nomenclatura"** - especifica EXATAMENTE como cada objeto deve ser nomeado no FormCor.prg.

**Exemplo do JSON gerado**:
```json
{
  "form_original": "SIGCDCOR",
  "form_migrado": "FormCor",
  "mapeamento": {
    "SIGCDCOR": "FormCor",
    "SIGCDCOR.Pagina": "pgf_4c_Paginas",
    "SIGCDCOR.Pagina.Dados": "Page2",
    "SIGCDCOR.Pagina.Dados.Getcods": "txt_4c_Codigo"
  }
}
```

**Documentação**: `docs/gerador_mapeamento_guide.md`

---

### Passo 3: Gerar Prompt de Implementação com Meta-Prompt

**Objetivo**: Analisar .txt + JSON e gerar prompt estruturado para Claude Code

**Como fazer**:

1. Abrir `docs/GERADOR_PROMPT_MIGRACAO.md`
2. Copiar o **meta-prompt completo** (seção "Meta-Prompt Completo")
3. Colar no Claude Code (ou Claude.ai)
4. **Atualizar a seção INPUT**:

```markdown
## INPUT - Informações da Task

**Task**: task1
**Nome do Formulário Original**: SIGCDCOR
**Nome do Formulário Novo**: FormCor
**Arquivo de Referência**: C:\4c\tasks\task1\SIGCDCOR_form_codigo_fonte.txt
**Mapeamento JSON**: C:\4c\projeto\app\utils\mapeamentos\FormCor_mapeamento.json

**Conteúdo do arquivo** (primeiros 500 linhas ou completo):
[COLAR AQUI O CONTEÚDO DO SIGCDCOR_form_codigo_fonte.txt]

**Conteúdo do JSON** (completo):
[COLAR AQUI O CONTEÚDO DO FormCor_mapeamento.json]
```

5. Executar o meta-prompt
6. **Copiar o prompt GERADO** pelo meta-prompt

**Resultado esperado**:
```
✅ Meta-prompt gera 6 tabelas de análise:
   - Tabela 1: Campos identificados
   - Tabela 2: Lookups identificados
   - Tabela 3: Validações identificadas
   - Tabela 4: Grade (grid)
   - Tabela 5: Propriedades visuais
   - Tabela 6: Estrutura do PageFrame

✅ Prompt estruturado gerado (copiar para usar no Passo 4)
✅ Prompt inclui instrução para seguir JSON de nomenclatura
```

**Documentação**: `docs/GERADOR_PROMPT_MIGRACAO.md`
**Exemplo**: `docs/EXEMPLO_USO_META_PROMPT.md`

---

### Passo 4: Executar Prompt Gerado (Claude Code Implementa)

**Objetivo**: Claude Code cria FormCor.prg, CorBO.prg **SEGUINDO o JSON** como especificação

**Como fazer**:

1. Abrir Claude Code no terminal
2. **Colar o prompt gerado pelo meta-prompt** (Passo 3)
3. **IMPORTANTE**: Verificar se o prompt menciona o JSON:
   ```
   "Implementar FormCor.prg seguindo EXATAMENTE o mapeamento JSON:
   C:\4c\projeto\app\utils\mapeamentos\FormCor_mapeamento.json"
   ```
4. Responder "Começar" ou "Sim"
5. Aguardar Claude Code implementar TUDO:
   - CorBO.prg (Business Object)
   - FormCor.prg (Formulário com nomes do JSON)
   - Atualizar config.prg (SET PROCEDURE)
   - Implementar lookups (3 campos)
   - Implementar validações

**Resultado esperado**:
```
✅ Arquivo criado: C:\4c\projeto\app\classes\CorBO.prg
✅ Arquivo criado: C:\4c\projeto\app\forms\cadastros\FormCor.prg
✅ Arquivo atualizado: C:\4c\projeto\app\start\config.prg
✅ Claude Code confirma: "Implementação completa seguindo JSON!"
✅ Nomes dos objetos correspondem ao FormCor_mapeamento.json
```

**⚠️ CRÍTICO**: FormCor.prg DEVE usar os nomes EXATOS do JSON. Exemplo:
- JSON diz: `"SIGCDCOR.Pagina.Dados.Getcods": "txt_4c_Codigo"`
- FormCor.prg DEVE ter: `THIS.pgf_4c_Paginas.Page2.AddObject("txt_4c_Codigo", "TextBox")`

**Se os nomes não corresponderem**: ValidarUIFidelity (Passo 5) reportará 100+ erros.

---

### Passo 5: Validar UI Fidelity (ValidarUIFidelity)

**Objetivo**: Verificar se interface do FormCor é pixel-perfect com o original e se segue o JSON

**Comando**:
```foxpro
CD C:\4c\projeto\app\utils
DO ValidarUIFidelity WITH "task1\SIGCDCOR_form_codigo_fonte.txt", "FormCor"
```

**Resultado esperado**:
```
✅ Relatório HTML gerado em: projeto\app\utils\relatorios\UIFidelity_FormCor_YYYYMMDDHHMMSS.html
✅ Console mostra: "Total de problemas: ~37"
   - 4 erros (Dataenvironment) ✅ ACEITÁVEL
   - 33 avisos (FormBase) ✅ ACEITÁVEL
   - 0 diferenças críticas ✅ OBJETIVO
```

**Critérios de Aceitação**:
- ✅ **≤ 37 problemas** (4 Dataenvironment + 33 FormBase)
- ✅ **0 diferenças visuais críticas** (Width, Height, Top, Left, BackColor, FontSize)
- ❌ **> 100 problemas** = FormCor.prg NÃO seguiu o JSON (voltar ao Passo 4)

**Como ValidarUIFidelity usa o JSON**:
1. Carrega `FormCor_mapeamento.json` automaticamente
2. Para cada objeto original (ex: `SIGCDCOR.Pagina.Dados.Getcods`)
3. Procura objeto migrado usando JSON (ex: `FormCor.pgf_4c_Paginas.Page2.txt_4c_Codigo`)
4. Compara 18 propriedades visuais

**Documentação**: `docs/ui_fidelity_validation.md`

---

### Passo 6: Testes Manuais (Obrigatório)

**Objetivo**: Verificar se TODAS as funcionalidades funcionam corretamente

**Como testar**:

```foxpro
*-- Abrir formulário
CD C:\4c\projeto\app\start
DO main.prg
*-- Ou testar diretamente:
CD C:\4c\projeto\app\forms\cadastros
DO FORM FormCor
```

**Checklist de Testes**:

```
MODO LISTA:
[ ] Grid carrega registros do banco
[ ] Grid mostra 4 colunas com cabeçalhos corretos
[ ] Grid permite navegação com setas
[ ] Botão INCLUIR abre Page2 em modo edição
[ ] Botão ALTERAR abre Page2 com registro selecionado
[ ] Botão EXCLUIR pede confirmação e exclui registro
[ ] Botão CONSULTAR abre Page2 em modo leitura (campos desabilitados)
[ ] Botão SAIR fecha formulário

MODO INCLUIR:
[ ] Page2 abre com campos vazios
[ ] Todos os campos estão HABILITADOS
[ ] F4 abre lookup em txt_4c_Grupo
[ ] F4 abre lookup em txt_4c_Tanque
[ ] Validação S/N funciona em txt_4c_TipoCor
[ ] Botão SALVAR grava no banco e volta para Page1
[ ] Botão CANCELAR descarta mudanças e volta para Page1

MODO ALTERAR:
[ ] Page2 abre com dados do registro selecionado
[ ] Todos os campos estão HABILITADOS
[ ] F4 abre lookup em txt_4c_Codigo (busca no próprio SigCdCor)
[ ] Alterações são salvas no banco
[ ] Botão CANCELAR descarta mudanças

MODO CONSULTAR:
[ ] Page2 abre com dados do registro
[ ] Todos os campos estão DESABILITADOS
[ ] Botão SALVAR está DESABILITADO
[ ] Botão CANCELAR está HABILITADO (permite voltar)

VISUAL (UI Fidelity):
[ ] Botões NÃO estão cortados no topo
[ ] Cores correspondem ao original
[ ] Fontes correspondem ao original
[ ] Tamanhos/posições correspondem ao original
```

**Se algum teste falhar**: Anotar problema e ir para Passo 7.

---

### Passo 7: Solicitar Correções e Atualizar Documentação

**Objetivo**: Corrigir problemas encontrados e documentar lições aprendidas

**Como fazer**:

1. **Listar problemas encontrados** nos testes:
   ```
   Exemplo:
   - Grid perde cabeçalhos após CarregarLista()
   - Lookup em txt_4c_Grupo não abre
   - Botões cortados no topo (primeiros 29px invisíveis)
   - ValidarUIFidelity reportou 150 erros (muito alto)
   ```

2. **Solicitar correções ao Claude Code**:
   ```
   Claude, encontrei os seguintes problemas nos testes:

   1. Grid perde cabeçalhos após CarregarLista()
   2. Lookup em txt_4c_Grupo não abre ao pressionar F4
   3. Botões estão cortados no topo do formulário

   Por favor, corrija estes problemas seguindo a documentação:
   - docs/FORMCOR_LICOES_APRENDIDAS.md (5 problemas conhecidos)
   - docs/grid_implementation.md (configuração de grid)
   - docs/lookup_implementation.md (implementação de lookups)
   ```

3. **Após correções, repetir**:
   - Passo 5 (ValidarUIFidelity)
   - Passo 6 (Testes manuais)

4. **Quando tudo funcionar**, solicitar atualização de documentação:
   ```
   Claude, a migração está completa e todos os testes passaram.

   Se encontramos problemas NOVOS (não documentados), por favor:
   1. Adicionar ao docs/FORMCOR_LICOES_APRENDIDAS.md
   2. Criar seção específica com:
      - Sintomas
      - Causa
      - Código problemático (ERRADO)
      - Código correto (CORRETO)
      - Checklist de verificação
   ```

---

## 📊 Fluxo Visual Completo (CORRIGIDO)

```
┌─────────────────────────────────────────────────────────────────┐
│                    FLUXO DE MIGRAÇÃO                             │
└─────────────────────────────────────────────────────────────────┘

PASSO 1: EXTRAIR CÓDIGO
┌────────────────────────────────────────┐
│ DO ExtractSCXCode                      │
│ Entrada: SIGCDCOR.SCX                  │
│ Saída: SIGCDCOR_form_codigo_fonte.txt │
└────────────────────────────────────────┘
              ↓
PASSO 2: GERAR MAPEAMENTO JSON (CONTRATO)
┌────────────────────────────────────────┐
│ DO GeradorMapeamento                   │
│ Entrada: .txt                          │
│ Saída: FormCor_mapeamento.json         │
│ (Especifica nomes dos objetos)         │
└────────────────────────────────────────┘
              ↓
PASSO 3: GERAR PROMPT (META-PROMPT)
┌────────────────────────────────────────┐
│ Meta-prompt analisa .txt + JSON        │
│ Gera: 6 tabelas + prompt estruturado   │
│ Prompt instrui Claude a seguir JSON    │
└────────────────────────────────────────┘
              ↓
PASSO 4: IMPLEMENTAR (CLAUDE CODE)
┌────────────────────────────────────────┐
│ Claude Code executa prompt gerado      │
│ Cria: CorBO.prg + FormCor.prg          │
│ SEGUINDO nomes do JSON                 │
│ Implementa: lookups + validações       │
└────────────────────────────────────────┘
              ↓
PASSO 5: VALIDAR UI FIDELITY
┌────────────────────────────────────────┐
│ DO ValidarUIFidelity                   │
│ Usa JSON para mapear objetos           │
│ Compara: Original vs Migrado           │
│ Saída: Relatório HTML                  │
│ Meta: ≤37 problemas                    │
└────────────────────────────────────────┘
              ↓
PASSO 6: TESTES MANUAIS
┌────────────────────────────────────────┐
│ Testar: INCLUIR, ALTERAR, EXCLUIR     │
│ Testar: Lookups (F4)                   │
│ Testar: Validações                     │
│ Testar: Visual (botões, cores)        │
└────────────────────────────────────────┘
              ↓
       ┌──────────┐
       │ Passou?  │
       └──────────┘
         ↓      ↓
        SIM    NÃO
         ↓      ↓
     ┌─────┐   └──→ PASSO 7: CORRIGIR
     │ FIM │        ┌────────────────────────────┐
     └─────┘        │ Listar problemas           │
                    │ Solicitar correções        │
                    │ Atualizar documentação     │
                    │ Voltar para Passo 5        │
                    └────────────────────────────┘
```

---

## ⚠️ Erros Comuns e Como Evitar

### Erro 1: Executar Passo 4 ANTES do Passo 2

**Sintoma**: Claude Code cria objetos com nomes diferentes do JSON

**Causa**: JSON não existia quando Claude implementou

**Solução**: SEMPRE executar GeradorMapeamento (Passo 2) ANTES de implementar (Passo 4)

### Erro 2: Caminho Errado no GeradorMapeamento

**Sintoma**:
```
Arquivo nao encontrado: task1\SIGCDCOR_form_codigo_fonte.txt
```

**Causa**: Falta "tasks\" no caminho

**Solução**:
```foxpro
*-- ❌ ERRADO:
DO GeradorMapeamento WITH "task1\SIGCDCOR_form_codigo_fonte.txt", "FormCor"

*-- ✅ CORRETO:
DO GeradorMapeamento WITH "tasks\task1\SIGCDCOR_form_codigo_fonte.txt", "FormCor"
```

### Erro 3: FormCor.prg Não Segue o JSON

**Sintoma**: ValidarUIFidelity reporta 150+ erros

**Causa**: Claude Code não usou os nomes do JSON ao implementar

**Solução**:
1. Abrir `FormCor_mapeamento.json` e ver nomes esperados
2. Abrir `FormCor.prg` e verificar nomes reais
3. Solicitar ao Claude Code:
   ```
   Claude, o FormCor.prg não seguiu o mapeamento JSON.

   JSON esperava: "txt_4c_Codigo"
   FormCor.prg tem: "txt_Codigo"

   Por favor, refatorar FormCor.prg para usar os nomes EXATOS do JSON:
   C:\4c\projeto\app\utils\mapeamentos\FormCor_mapeamento.json
   ```
4. Re-executar Passo 5 (ValidarUIFidelity)

### Erro 4: Pular Testes Manuais

**Sintoma**: ValidarUIFidelity passou, mas formulário não funciona

**Causa**: ValidarUIFidelity só valida UI, não funcionalidade

**Solução**: SEMPRE executar Passo 6 (testes manuais) completo

---

## 🎯 Por Que GeradorMapeamento é Passo 2 (Não Passo 4)?

### Workflow Antigo (ERRADO):
```
1. ExtractSCXCode → .txt
2. Meta-prompt → prompt
3. Claude implementa → FormCor.prg (nomes aleatórios)
4. GeradorMapeamento → JSON (tenta adivinhar mapeamento)
5. ValidarUIFidelity → 150+ erros (nomes não batem)
```

### Workflow Novo (CORRETO):
```
1. ExtractSCXCode → .txt
2. GeradorMapeamento → JSON (define contrato de nomes)
3. Meta-prompt → prompt (instrui Claude a seguir JSON)
4. Claude implementa → FormCor.prg (nomes do JSON)
5. ValidarUIFidelity → ≤37 problemas (nomes batem!)
```

**Benefício**: JSON como "contrato" garante que Claude Code use nomes corretos desde o início.

---

## 📚 Documentação de Referência

| Passo | Documentação |
|-------|--------------|
| 1. ExtractSCXCode | `docs/ExtractSCXCode_guide.md` |
| 2. GeradorMapeamento | `docs/gerador_mapeamento_guide.md` |
| 3. Meta-Prompt | `docs/GERADOR_PROMPT_MIGRACAO.md` + `docs/EXEMPLO_USO_META_PROMPT.md` |
| 4. Implementação | `docs/form_patterns.md` + `docs/lookup_implementation.md` |
| 5. ValidarUIFidelity | `docs/ui_fidelity_validation.md` |
| 6. Testes | `docs/migration_guide.md` (seção "Testing") |
| 7. Correções | `docs/FORMCOR_LICOES_APRENDIDAS.md` (5 problemas conhecidos) |

**Referência Geral**: `CLAUDE.md` (instruções críticas para Claude Code)

---

## ✅ Checklist de Conclusão

Migração está COMPLETA quando:

```
[ ] ValidarUIFidelity: ≤37 problemas
[ ] Testes manuais: TODOS os 20+ itens passaram
[ ] FormCor.prg usa nomes EXATOS do JSON
[ ] Grid: Mostra dados e cabeçalhos corretos
[ ] Lookups: F4 funciona em TODOS os campos (3x)
[ ] Validações: S/N funciona, campos obrigatórios validam
[ ] Visual: Botões NÃO cortados, cores/fontes corretas
[ ] Modos: INCLUIR/ALTERAR/VISUALIZAR/EXCLUIR funcionam
[ ] Code review: Arquitetura em camadas (Form/BO/DataAccess)
[ ] Documentação: Problemas novos adicionados às lições aprendidas
[ ] Commit: Código versionado com mensagem descritiva
```

---

## 🎯 Resumo dos 7 Passos (ORDEM CORRETA)

| # | Passo | Ferramenta | Tempo Estimado |
|---|-------|------------|----------------|
| 1 | Extrair código | ExtractSCXCode.prg | 1 min |
| 2 | **Gerar JSON (contrato)** | **GeradorMapeamento.prg** | **1 min** |
| 3 | Gerar prompt | Meta-prompt (Claude.ai) | 5 min |
| 4 | Implementar (seguir JSON) | Claude Code | 30-60 min |
| 5 | Validar UI | ValidarUIFidelity.prg | 2 min |
| 6 | Testes manuais | Manual (VFP9) | 15-30 min |
| 7 | Correções | Claude Code | Variável |

**Tempo total**: ~1-2 horas (sem correções)
**Tempo com meta-prompt**: 98% mais rápido que processo manual (5h → 1-2h)

---

---

## Pipeline Automatizado (OrquestradorMigracao.ps1)

Os 7 passos acima podem ser executados automaticamente pelo OrquestradorMigracao:

```powershell
cd C:\4c\automation
.\OrquestradorMigracao.ps1 -TaskId taskXXX
```

O pipeline executa: Extração → Análise → **Análise Comportamental** → **Extração Layout** → Meta-Prompt → Mapeamento → Esqueletos → Migração → Correção → Compilação → Completude → **Code Review** → Teste → UI Fidelity → Teste Manual

**Screenshots de referência** (opcional): Colocar `{BaseName}_01.png`, `{BaseName}_02.png` etc junto ao SCX em `C:\4c\origem`. O pipeline move automaticamente e usa como contexto visual.

### Tipos de Formulário Suportados

| Tipo | Detecção | Padrão | Pasta |
|------|----------|--------|-------|
| **CRUD** (frmcadastro) | Automática (default) | PageFrame, BusinessBase, FormParaBO/BOParaForm | cadastros/ |
| **REPORT** (frmrelatorio) | Automática (analise.json) | Layout FLAT, RelatorioBase, FormParaRelatorio | relatorios/ |
| **OPERACIONAL** (form genérico) | Automática (analise.json) | Custom layout, grids+containers flutuantes | operacionais/ |

### config.prg - Carregamento Dinâmico

O `config.prg` usa `ADIR()` com wildcards para carregar arquivos automaticamente:
- `*BO.prg` → Business Objects
- `Form*.prg` → Formulários (cadastros, relatórios, operacionais)

**NÃO é necessário** registrar manualmente novos arquivos via SET PROCEDURE.

### TesteAutomatico - Suporte CRUD, REPORT e OPERACIONAL

O TesteAutomatico.prg recebe o tipo de form como 3º parâmetro (passado pelo pipeline):

| Tipo | Testes Executados |
|------|-------------------|
| **CRUD** | CarregarLista, ModoIncluir, ModoVisualizar, Fechar |
| **REPORT** | FormParaRelatorio, BotoesRelatorio, Fechar |
| **OPERACIONAL** | ContainersFlutuantes (toggle ON/OFF), CarregarDadosReais (MontaGrade etc.), NavegacaoPaginas |

### Retry com Correção Automática (Etapas 6 e 6.5)

Quando o VFP9 trava (timeout) ou testes falham, o pipeline tenta corrigir automaticamente via Claude em loop de até **10 tentativas**:

1. Detecta erro (timeout, exit code, testes < 100%)
2. Coleta contexto (vfp_output.txt, log, teste_resultado.json, código fonte)
3. Claude corrige o código (prompt com erro + 15 soluções comuns)
4. CorretorAutomatico.ps1 + Recompilação + Delete .fxp
5. Re-testa automaticamente

| Etapa | Comportamento em falha final |
|-------|------------------------------|
| **6 (TestForm)** | Auto-skip (não bloqueia) |
| **6.5 (TesteAutomatico)** | Fail + throw (quality gate) |

### Remove-DuplicateForms (Prevenção de Conflitos)

Antes da Etapa 5, o pipeline chama `Remove-DuplicateForms` para evitar que cópias antigas do mesmo Form em outras pastas (cadastros/operacionais/relatorios) causem conflitos no ADIR:

- Detecta Form*.prg com mesmo nome em pastas diferentes da preferida
- Renomeia para `.bak` (preserva backup)
- Limpa `.fxp` correspondentes

Config: `config.json` → `retry.maxTentativasRuntimeFix: 10`

---

**Última atualização**: 2026-03-04
**Versão**: 1.3 (Adicionado retry com correção automática Etapas 6/6.5)
**Autor**: Sistema de Refatoração VFP9
