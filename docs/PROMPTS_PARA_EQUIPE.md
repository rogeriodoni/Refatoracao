# Prompts para Migração de Formulários VFP9

Este documento contém os prompts padronizados para usar com Claude Code ao migrar formulários do sistema legado para o novo sistema.

## 🔥 NOVO: Guia Passo-a-Passo Completo

**Recomendamos usar este guia visual com comandos prontos**:
📘 `C:\4c\docs\PASSO_A_PASSO_MIGRACAO.md`

Este guia contém:
- ✅ Sequência lógica desde extração do SCX até testes
- ✅ Comandos EXATOS para copiar/colar (ExtractSCXCode, GeradorMapeamento, ValidarUIFidelity)
- ✅ O que fazer quando ValidarUIFidelity falhar
- ✅ Quando fazer teste manual vs validação automática
- ✅ Cheat sheet com todos os comandos

## 📋 Índice

1. [Prompt: Refazer Task Existente](#1-prompt-refazer-task-existente)
2. [Prompt: Fazer Task do Zero](#2-prompt-fazer-task-do-zero)
3. [Prompt: Validar Task Completa](#3-prompt-validar-task-completa)
4. [Comandos Prontos (Cheat Sheet)](#4-comandos-prontos-cheat-sheet)
5. [Contexto Necessário](#5-contexto-necessário)
6. [Boas Práticas](#6-boas-práticas)
7. [Troubleshooting](#7-troubleshooting)
8. [Exemplos de Conversas Completas](#8-exemplos-de-conversas-completas)
9. [Checklist de Prompt Efetivo](#9-checklist-de-prompt-efetivo)
10. [Resumo Rápido](#10-resumo-rápido)

---

## 1. Prompt: Refazer Task Existente

Use este prompt quando já existe uma migração (FormXxx.prg e XxxBO.prg) mas você quer refazê-la do zero para validar o processo ou corrigir problemas.

### 📝 Prompt Completo

```
Vou refazer a task1 (migração do FormCor) completamente do zero para validar o processo de migração e garantir que novas tasks sejam feitas corretamente.

OBJETIVO:
- Deletar arquivos atuais (FormCor.prg, CorBO.prg, mapeamento JSON)
- Refazer a migração passo-a-passo seguindo o guia
- Validar com ValidarUIFidelity (meta: 37 problemas)
- Documentar qualquer problema encontrado

ARQUIVOS DE REFERÊNCIA:
- Guia: C:\4c\docs\REFAZER_TASK1.md (seguir rigorosamente)
- Original: C:\4c\tasks\task1\SIGCDCOR_form_codigo_fonte.txt
- Documentação: C:\4c\CLAUDE.md

PROCESSO:
1. Fazer backup dos arquivos atuais
2. Deletar FormCor.prg, CorBO.prg, mapeamento JSON
3. Seguir REFAZER_TASK1.md desde a Fase 0
4. CRÍTICO: Fase 5 (Validação) DEVE resultar em 37 problemas
5. Testar todos os modos CRUD
6. Documentar problemas encontrados

VALIDAÇÃO OBRIGATÓRIA:
- ValidarUIFidelity DEVE passar com 37 problemas:
  * 4 erros (Dataenvironment - aceitável)
  * 33 avisos (FormBase - aceitável)
  * 0 diferenças visuais (ForeColor normalizado)

Por favor, me guie através do processo passo-a-passo, começando pela Fase 0 (Backup e Limpeza).
```

### 🎯 Variações por Task

#### Refazer Task2 (FormCargo):
```
Vou refazer a task2 (migração do FormCargo) completamente do zero.

OBJETIVO:
- Deletar arquivos atuais (FormCargo.prg, CargoBO.prg, mapeamento JSON)
- Refazer seguindo o processo validado da task1
- Validar com ValidarUIFidelity (meta: ≤37 problemas)

ARQUIVOS:
- Guia base: C:\4c\docs\REFAZER_TASK1.md (adaptar para FormCargo)
- Original: C:\4c\tasks\task2\SIGCDCAR_form_codigo_fonte.txt
- Tabela: SigCdCar (docs/schema.sql)

Siga o mesmo processo da task1, adaptando para FormCargo.
```

#### Refazer Task3 (FormDepartamento):
```
Vou refazer a task3 (migração do FormDepartamento) completamente do zero.

OBJETIVO:
- Deletar FormDepartamento.prg, DepartamentoBO.prg, mapeamento JSON
- Refazer seguindo processo validado
- Validar com ValidarUIFidelity (meta: ≤37 problemas)

ARQUIVOS:
- Guia base: C:\4c\docs\REFAZER_TASK1.md (adaptar para FormDepartamento)
- Original: C:\4c\tasks\task3\SIGCDDPT_form_codigo_fonte.txt
- Tabela: SigCdDpt (docs/schema.sql)

Siga o processo da task1, adaptando para FormDepartamento.
```

---

## 2. Prompt: Fazer Task do Zero

Use este prompt quando for migrar um formulário que NUNCA foi migrado antes (task nova).

### 📝 Prompt Completo

```
Vou migrar um novo formulário do sistema legado para o novo sistema seguindo a arquitetura em camadas validada.

TASK: task2 - FormCargo
FORMULÁRIO ORIGINAL: SIGCDCAR
TABELA: SigCdCar

OBJETIVO:
- Criar CargoBO.prg (Business Object)
- Criar FormCargo.prg (Interface)
- Criar FormCargo_mapeamento.json
- Validar com ValidarUIFidelity (meta: ≤37 problemas)
- Testar CRUD completo

ARQUIVOS DE REFERÊNCIA:
- Checklist: C:\4c\docs\CHECKLIST_MIGRACAO_RAPIDO.md
- Guia completo: C:\4c\docs\task1_guia_completo.md (usar como base)
- Original: C:\4c\tasks\task2\SIGCDCAR_form_codigo_fonte.txt
- Schema: C:\4c\docs\schema.sql (tabela SigCdCar)
- CLAUDE.md: Regras CRÍTICAS (3 pilares)

PROCESSO:
1. ANÁLISE: Extrair propriedades, mapear campos, identificar lookups
2. BUSINESS OBJECT: Criar CargoBO.prg com TODAS as propriedades
3. FORM: Criar FormCargo.prg pixel-perfect
4. MAPEAMENTO: Gerar e corrigir JSON
5. VALIDAÇÃO: ValidarUIFidelity (OBRIGATÓRIO - meta: ≤37 problemas)
6. TESTES: CRUD completo + Lookups

REGRAS CRÍTICAS (3 PILARES):
1. UX: Interface PIXEL-PERFECT (Width/Height/Top/Left exatos)
2. BANCO: Schema IDÊNTICO (usar nomes EXATOS: SigCdCar, ccars, etc.)
3. CÓDIGO: Arquitetura DIFERENTE (Form/BO separados, nomenclatura _4c_)

VALIDAÇÃO OBRIGATÓRIA:
- ValidarUIFidelity DEVE passar com ≤37 problemas
- Se houver mais, CORRIGIR antes de continuar

Por favor, comece pela ANÁLISE do código fonte original.
```

### 🎯 Template Genérico para Qualquer Task Nova

```
Vou migrar um novo formulário do sistema legado.

TASK: task[N] - Form[Entidade]
FORMULÁRIO ORIGINAL: [SIGCDXXX]
TABELA: [SigCdXxx]

OBJETIVO:
- Criar [Entidade]BO.prg
- Criar Form[Entidade].prg
- Criar Form[Entidade]_mapeamento.json
- Validar com ValidarUIFidelity (meta: ≤37 problemas)
- Testar CRUD completo

ARQUIVOS:
- Checklist: C:\4c\docs\CHECKLIST_MIGRACAO_RAPIDO.md
- Original: C:\4c\tasks\task[N]\[ARQUIVO]_form_codigo_fonte.txt
- Schema: C:\4c\docs\schema.sql (tabela [SigCdXxx])

Siga o processo: ANÁLISE → BO → FORM → JSON → VALIDAÇÃO → TESTES.
```

### 📋 Exemplos Práticos

#### Task2 - FormCargo (do zero):
```
TASK: task2 - FormCargo
ORIGINAL: SIGCDCAR
TABELA: SigCdCar
ARQUIVO: C:\4c\tasks\task2\SIGCDCAR_form_codigo_fonte.txt

Criar CargoBO.prg e FormCargo.prg seguindo CHECKLIST_MIGRACAO_RAPIDO.md
```

#### Task3 - FormDepartamento (do zero):
```
TASK: task3 - FormDepartamento
ORIGINAL: SIGCDDPT
TABELA: SigCdDpt
ARQUIVO: C:\4c\tasks\task3\SIGCDDPT_form_codigo_fonte.txt

Criar DepartamentoBO.prg e FormDepartamento.prg seguindo CHECKLIST_MIGRACAO_RAPIDO.md
```

#### Task4 - FormPlanoContas (do zero):
```
TASK: task4 - FormPlanoContas
ORIGINAL: SIGREPLC
TABELA: SigRePLC
ARQUIVO: C:\4c\tasks\task4\SIGREPLC_form_codigo_fonte.txt

Criar PlanoContasBO.prg e FormPlanoContas.prg seguindo CHECKLIST_MIGRACAO_RAPIDO.md
```

#### Task5 - FormProduto (do zero):
```
TASK: task5 - FormProduto
ORIGINAL: SIGCDPRO
TABELA: SigCdPro
ARQUIVO: C:\4c\tasks\task5\SIGCDPRO_form_codigo_fonte.txt

Criar ProdutoBO.prg e FormProduto.prg seguindo CHECKLIST_MIGRACAO_RAPIDO.md
```

---

## 3. Prompt: Validar Task Completa

Use este prompt quando a migração estiver "completa" mas você quer validar se está tudo correto.

### 📝 Prompt Completo

```
Preciso validar se a migração do Form[Entidade] está completa e correta.

TASK: task[N] - Form[Entidade]

ARQUIVOS PARA VALIDAR:
- Form: C:\4c\projeto\app\forms\cadastros\Form[Entidade].prg
- BO: C:\4c\projeto\app\classes\[Entidade]BO.prg
- JSON: C:\4c\projeto\app\utils\mapeamentos\Form[Entidade]_mapeamento.json
- Original: C:\4c\tasks\task[N]\[ARQUIVO]_form_codigo_fonte.txt

VALIDAÇÕES NECESSÁRIAS:

1. CÓDIGO:
   [ ] Form[Entidade].prg existe e compila
   [ ] [Entidade]BO.prg existe e compila
   [ ] Registrados em config.prg
   [ ] Nomenclatura correta (_4c_, loc_, par_, this_)

2. ValidarUIFidelity:
   [ ] Executar ValidarUIFidelity
   [ ] Resultado: ≤37 problemas
   [ ] Relatório HTML gerado
   [ ] Somente erros aceitáveis (Dataenvironment + FormBase)

3. FUNCIONALIDADE:
   [ ] Modo INCLUIR funciona
   [ ] Modo ALTERAR funciona
   [ ] Modo VISUALIZAR funciona
   [ ] Modo EXCLUIR funciona
   [ ] Lookups (F4/F5) funcionam
   [ ] Grid carrega dados

4. INTERFACE:
   [ ] Todos os campos visíveis
   [ ] Posicionamento correto (pixel-perfect)
   [ ] Cores e fontes corretas

Por favor, execute todas as validações e reporte o status.
```

---

## 4. Comandos Prontos (Cheat Sheet)

### 📝 Comandos Essenciais para Copiar/Colar

#### Extrair Código do SCX (Se não tiver .txt)
```foxpro
*-- Task1 (FormCor):
CD C:\4c\projeto\app\utils
DO ExtractSCXCode WITH "C:\4c\tasks\task1\SIGCDCOR.SCX", ;
                       "C:\4c\tasks\task1\SIGCDCOR_form_codigo_fonte.txt"

*-- Task2 (FormCargo):
DO ExtractSCXCode WITH "C:\4c\tasks\task2\SIGCDCAR.SCX", ;
                       "C:\4c\tasks\task2\SIGCDCAR_form_codigo_fonte.txt"

*-- Task3 (FormDepartamento):
DO ExtractSCXCode WITH "C:\4c\tasks\task3\SIGCDDPT.SCX", ;
                       "C:\4c\tasks\task3\SIGCDDPT_form_codigo_fonte.txt"
```

#### Gerar Mapeamento JSON
```foxpro
*-- Task1 (FormCor):
CD C:\4c\projeto\app\utils
DO GeradorMapeamento WITH "c:\4c\tasks\task1\SIGCDCOR_form_codigo_fonte.txt", "FormCor"

*-- Task2 (FormCargo):
DO GeradorMapeamento WITH "c:\4c\tasks\task2\SIGCDCAR_form_codigo_fonte.txt", "FormCargo"

*-- Task3 (FormDepartamento):
DO GeradorMapeamento WITH "c:\4c\tasks\task3\SIGCDDPT_form_codigo_fonte.txt", "FormDepartamento"

*-- Task4 (FormPlanoContas):
DO GeradorMapeamento WITH "c:\4c\tasks\task4\SIGREPLC_form_codigo_fonte.txt", "FormPlanoContas"

*-- Task5 (FormProduto):
DO GeradorMapeamento WITH "c:\4c\tasks\task5\SIGCDPRO_form_codigo_fonte.txt", "FormProduto"
```

#### Validar UI Fidelity (OBRIGATÓRIO!)
```foxpro
*-- SEMPRE deletar .fxp antes:
DELETE FILE C:\4c\projeto\app\*.fxp /S

*-- Task1 (FormCor):
CD C:\4c\projeto\app\utils
DO ValidarUIFidelity WITH "c:\4c\tasks\task1\SIGCDCOR_form_codigo_fonte.txt", "FormCor"

*-- Task2 (FormCargo):
DO ValidarUIFidelity WITH "c:\4c\tasks\task2\SIGCDCAR_form_codigo_fonte.txt", "FormCargo"

*-- Task3 (FormDepartamento):
DO ValidarUIFidelity WITH "c:\4c\tasks\task3\SIGCDDPT_form_codigo_fonte.txt", "FormDepartamento"

*-- Task4 (FormPlanoContas):
DO ValidarUIFidelity WITH "c:\4c\tasks\task4\SIGREPLC_form_codigo_fonte.txt", "FormPlanoContas"

*-- Task5 (FormProduto):
DO ValidarUIFidelity WITH "c:\4c\tasks\task5\SIGCDPRO_form_codigo_fonte.txt", "FormProduto"
```

#### Teste Rápido de Validação (Task1)
```foxpro
CD C:\4c\projeto\app\utils
DO testar_validacao.prg
*-- Resultado esperado: 37 problemas
```

#### Testar BO Isoladamente
```foxpro
CD C:\4c\projeto\app\start
DO main.prg

DELETE FILE C:\4c\projeto\app\classes\*.fxp

loBO = CREATEOBJECT("CorBO")
? TYPE("loBO") = "O"  && Deve ser .T.
? loBO.this_cTabela = "SigCdCor"  && Deve ser .T.

RELEASE loBO
```

#### Testar Form Visualmente
```foxpro
CD C:\4c\projeto\app\start
DO main.prg

DELETE FILE C:\4c\projeto\app\forms\*.fxp

loForm = CREATEOBJECT("FormCor")
loForm.Show()

*-- Verificar visualmente, depois:
loForm.Release()
```

#### Consultar Banco (Teste Manual)
```foxpro
*-- Verificar se registro foi inserido:
SELECT * FROM SigCdCor WHERE ccors = 'TEST001'

*-- Verificar se foi alterado:
SELECT dcors FROM SigCdCor WHERE ccors = 'TEST001'

*-- Verificar se foi excluído:
SELECT COUNT(*) FROM SigCdCor WHERE ccors = 'TEST001'  && Deve retornar 0
```

### 📊 Tabela de Referência Rápida

| Task | Formulário | Tabela | Arquivo Original | Comando ValidarUIFidelity |
|------|------------|--------|------------------|---------------------------|
| task1 | FormCor | SigCdCor | SIGCDCOR_form_codigo_fonte.txt | `DO ValidarUIFidelity WITH "c:\4c\tasks\task1\SIGCDCOR_form_codigo_fonte.txt", "FormCor"` |
| task2 | FormCargo | SigCdCar | SIGCDCAR_form_codigo_fonte.txt | `DO ValidarUIFidelity WITH "c:\4c\tasks\task2\SIGCDCAR_form_codigo_fonte.txt", "FormCargo"` |
| task3 | FormDepartamento | SigCdDpt | SIGCDDPT_form_codigo_fonte.txt | `DO ValidarUIFidelity WITH "c:\4c\tasks\task3\SIGCDDPT_form_codigo_fonte.txt", "FormDepartamento"` |
| task4 | FormPlanoContas | SigRePLC | SIGREPLC_form_codigo_fonte.txt | `DO ValidarUIFidelity WITH "c:\4c\tasks\task4\SIGREPLC_form_codigo_fonte.txt", "FormPlanoContas"` |
| task5 | FormProduto | SigCdPro | SIGCDPRO_form_codigo_fonte.txt | `DO ValidarUIFidelity WITH "c:\4c\tasks\task5\SIGCDPRO_form_codigo_fonte.txt", "FormProduto"` |

---

## 5. Contexto Necessário

### 📁 Arquivos Que Claude Code Precisa Conhecer

Ao iniciar uma nova conversa, certifique-se de que Claude Code tem acesso a:

#### Documentação Principal:
- ✅ `C:\4c\CLAUDE.md` - Regras críticas, 3 pilares, nomenclatura
- ✅ `C:\4c\docs\schema.sql` - Schema do banco (nomes EXATOS de tabelas/colunas)

#### Guias de Processo:
- ✅ `C:\4c\docs\task1_guia_completo.md` - Exemplo completo de migração
- ✅ `C:\4c\docs\REFAZER_TASK1.md` - Processo de refatoração
- ✅ `C:\4c\docs\CHECKLIST_MIGRACAO_RAPIDO.md` - Checklist resumido

#### Guias Técnicos:
- ✅ `C:\4c\docs\ui_fidelity_validation.md` - Como usar ValidarUIFidelity
- ✅ `C:\4c\docs\lookup_implementation.md` - Como implementar lookups
- ✅ `C:\4c\docs\grid_implementation.md` - Como implementar grids
- ✅ `C:\4c\docs\form_patterns.md` - Padrões de formulário
- ✅ `C:\4c\docs\sql_guide.md` - SQL e funções (FormatarNumeroSQL, etc.)

#### Arquivos da Task:
- ✅ Código fonte original: `C:\4c\tasks\task[N]\[ARQUIVO]_form_codigo_fonte.txt`
- ✅ FormBase: `C:\4c\projeto\app\classes\formbase.prg`
- ✅ BusinessBase: `C:\4c\projeto\app\classes\businessbase.prg`

### 🔍 Como Verificar se Claude Code Tem Contexto

Ao abrir nova conversa, pergunte:

```
Você tem acesso aos seguintes arquivos?
- C:\4c\CLAUDE.md
- C:\4c\docs\REFAZER_TASK1.md
- C:\4c\docs\CHECKLIST_MIGRACAO_RAPIDO.md
- C:\4c\docs\ui_fidelity_validation.md

Por favor, confirme se consegue ler esses arquivos.
```

---

## 6. Boas Práticas

### ✅ DO (Fazer)

1. **Sempre mencionar o guia de referência**
   ```
   Seguir: C:\4c\docs\REFAZER_TASK1.md
   ```

2. **Especificar meta de validação**
   ```
   ValidarUIFidelity DEVE passar com ≤37 problemas
   ```

3. **Identificar task e arquivos claramente**
   ```
   TASK: task2 - FormCargo
   ORIGINAL: C:\4c\tasks\task2\SIGCDCAR_form_codigo_fonte.txt
   ```

4. **Solicitar processo passo-a-passo**
   ```
   Por favor, me guie através do processo passo-a-passo.
   ```

5. **Mencionar os 3 PILARES**
   ```
   Seguir os 3 PILARES do CLAUDE.md:
   1. UX: Pixel-perfect
   2. BANCO: Schema idêntico
   3. CÓDIGO: Arquitetura diferente
   ```

### ❌ DON'T (Não Fazer)

1. **Não ser vago**
   ```
   ❌ "Quero migrar um formulário"
   ✅ "TASK: task2 - FormCargo, Original: SIGCDCAR"
   ```

2. **Não pular a validação**
   ```
   ❌ "Crie o form e pronto"
   ✅ "Crie o form E valide com ValidarUIFidelity"
   ```

3. **Não aceitar "quase certo"**
   ```
   ❌ "45 problemas está bom"
   ✅ "≤37 problemas é obrigatório"
   ```

4. **Não omitir arquivos de referência**
   ```
   ❌ "Siga o processo"
   ✅ "Siga: C:\4c\docs\REFAZER_TASK1.md"
   ```

5. **Não misturar refazer com criar novo**
   ```
   ❌ "Migre ou refaça o FormCargo"
   ✅ "REFAZER task2" OU "CRIAR task2 do zero"
   ```

---

## 7. Troubleshooting

### Problema: Claude Code não encontra arquivos

**Solução**: Fornecer caminho absoluto
```
Arquivo: C:\4c\docs\REFAZER_TASK1.md
(não apenas "REFAZER_TASK1.md")
```

### Problema: Validação falha com mais de 37 problemas

**Solução**: Pedir análise do relatório
```
ValidarUIFidelity gerou 50 problemas (esperado: ≤37).
Analise o relatório HTML e identifique os 13 problemas ALÉM dos 37 esperados.
```

### Problema: Claude Code pula etapas

**Solução**: Solicitar passo-a-passo
```
NÃO faça tudo de uma vez.
Me guie através de CADA FASE separadamente:
1. Análise PRIMEIRO
2. Depois confirmo para prosseguir com BO
3. Depois confirmo para prosseguir com Form
...
```

### Problema: Código não compila

**Solução**: Verificar arquivos .fxp
```
Antes de testar, execute:
DELETE FILE C:\4c\projeto\app\*.fxp /S
```

### Problema: ValidarUIFidelity não encontra objeto

**Solução**: Verificar mapeamento JSON
```
ValidarUIFidelity reporta "objeto não encontrado".
Verifique se FormCargo_mapeamento.json tem os nomes REAIS dos objetos:
- Abrir FormCargo.prg
- Comparar nomes no código com JSON
- Corrigir JSON manualmente
```

---

## 8. Exemplos de Conversas Completas

### 📘 Exemplo 1: Refazer Task1

```
USUÁRIO:
Vou refazer a task1 (migração do FormCor) completamente do zero para validar o processo.

OBJETIVO:
- Deletar arquivos atuais
- Refazer seguindo C:\4c\docs\REFAZER_TASK1.md
- Validar com ValidarUIFidelity (meta: 37 problemas)

ARQUIVOS:
- Guia: C:\4c\docs\REFAZER_TASK1.md
- Original: C:\4c\tasks\task1\SIGCDCOR_form_codigo_fonte.txt

Por favor, comece pela Fase 0 (Backup e Limpeza).

---

CLAUDE CODE:
Vou guiá-lo através da Fase 0: Backup e Limpeza.

Fase 0.1 - Fazer Backup:
[comandos de backup...]

Fase 0.2 - Deletar Arquivos:
[comandos de deleção...]

Pronto! Arquivos deletados. Pronto para Fase 1?

---

USUÁRIO:
Sim, prossiga para Fase 1.

---

[... conversa continua fase por fase ...]
```

### 📘 Exemplo 2: Criar Task2 do Zero

```
USUÁRIO:
Vou migrar o FormCargo (task2) pela primeira vez.

TASK: task2 - FormCargo
ORIGINAL: SIGCDCAR
ARQUIVO: C:\4c\tasks\task2\SIGCDCAR_form_codigo_fonte.txt
TABELA: SigCdCar

Siga: C:\4c\docs\CHECKLIST_MIGRACAO_RAPIDO.md

Comece pela ANÁLISE do código fonte original.

---

CLAUDE CODE:
Vou começar analisando o código fonte original do SIGCDCAR.

[lê o arquivo...]

Análise completa:
1. Campos identificados: [lista...]
2. Lookups encontrados: [lista...]
3. Validações: [lista...]

Tabela de mapeamento:
[tabela com campos...]

Pronto para criar CargoBO.prg?

---

[... conversa continua ...]
```

### 📘 Exemplo 3: Validar Task Completa

```
USUÁRIO:
Preciso validar se a task3 (FormDepartamento) está completa.

ARQUIVOS:
- Form: C:\4c\projeto\app\forms\cadastros\FormDepartamento.prg
- BO: C:\4c\projeto\app\classes\DepartamentoBO.prg
- JSON: C:\4c\projeto\app\utils\mapeamentos\FormDepartamento_mapeamento.json

Execute todas as validações:
1. Código compila
2. ValidarUIFidelity (≤37 problemas)
3. Testes CRUD

---

CLAUDE CODE:
Vou executar todas as validações.

1. Verificando código...
[resultados...]

2. Executando ValidarUIFidelity...
[resultados...]

3. Instruções para testes CRUD...
[passo a passo...]

Resumo: [status final...]
```

---

## 9. Checklist de Prompt Efetivo

Antes de enviar seu prompt, verifique:

```
[ ] Identifica claramente se é REFAZER ou CRIAR DO ZERO
[ ] Especifica número da task (task1, task2, etc.)
[ ] Menciona nome do formulário (FormCor, FormCargo, etc.)
[ ] Fornece caminho do arquivo original (.txt)
[ ] Referencia guia apropriado (REFAZER_TASK1.md ou CHECKLIST_MIGRACAO_RAPIDO.md)
[ ] Menciona meta de validação (≤37 problemas)
[ ] Solicita processo passo-a-passo (se aplicável)
[ ] Usa caminhos absolutos (C:\4c\...)
```

---

## 10. Resumo Rápido

| Cenário | Prompt Chave | Guia | Meta |
|---------|--------------|------|------|
| **Refazer Task** | "Vou refazer a task[N]... seguir REFAZER_TASK1.md" | `REFAZER_TASK1.md` | ≤37 problemas |
| **Criar do Zero** | "Vou migrar task[N]... seguir CHECKLIST_MIGRACAO_RAPIDO.md" | `CHECKLIST_MIGRACAO_RAPIDO.md` | ≤37 problemas |
| **Validar** | "Validar task[N]... executar ValidarUIFidelity" | `ui_fidelity_validation.md` | ≤37 problemas |

---

## 📞 Suporte

Se tiver dúvidas:
1. Consulte `C:\4c\CLAUDE.md` (regras críticas)
2. Leia `C:\4c\docs\task1_guia_completo.md` (exemplo completo)
3. Verifique `C:\4c\docs\ui_fidelity_validation.md` (validação)

---

**Última atualização**: 2026-01-15
**Versão**: 1.0
**Autor**: Equipe de Migração VFP9
