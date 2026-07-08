# CLAUDE.md - Project Guide

This file provides critical guidance to Claude Code when working with code in this repository.

**IMPORTANT**: Detailed VFP9 reference, migration patterns, control properties, and error tables are in the **vfp9-migration skill** (`.claude/skills/vfp9-migration/`). The skill loads automatically during migration tasks.

## Project Overview

Sistema em Visual FoxPro 9 com arquitetura SOLID em camadas, conectando ao SQL Server (192.168.15.101, banco DB_MBAHIA).

### Filosofia de Refatoracao - 3 Pilares Inegociaveis

```
+========================================================================+
|                       PILARES DA REFATORACAO                           |
+========================================================================+
|  1. UX (User Experience)    -> MANTER O MAIS PROXIMO POSSIVEL         |
|  2. BANCO DE DADOS (Schema) -> IDENTICO (exceto LogAuditoria)         |
|  3. CODIGO-FONTE/ARQUITETURA -> OBRIGATORIAMENTE DIFERENTE            |
+========================================================================+
```

**PILAR 1 - UX**: Interface visual PIXEL-PERFECT identica ao legado. Comportamento, teclas de atalho (F4/F5), fluxo de trabalho identicos. O usuario NAO deve perceber diferenca.

**PILAR 2 - Banco**: Schema IDENTICO. NUNCA renomear tabelas/colunas, alterar tipos, adicionar/remover campos. Usar nomes EXATOS (SigCdCor, cgrus, dpros). Schema: `docs/schema.sql`

**PILAR 3 - Codigo**: Arquitetura em camadas (FormBase/BusinessBase/DataAccess). Nomes DIFERENTES do legado. Sufixo `_4c_` em objetos. Prefixos `loc_`, `par_`, `this_` em variaveis.

## Folder Structure

```
C:\4c\
├── CLAUDE.md              # Este arquivo
├── .claude\skills\        # Skills: vfp9-migration (referencia), propagate-lesson (propagar licoes)
├── docs\                  # Documentacao detalhada
│   ├── lookup_implementation.md
│   ├── grid_implementation.md
│   ├── form_patterns.md
│   ├── sql_guide.md
│   ├── migration_guide.md
│   ├── report_guide.md
│   ├── schema.sql
│   └── FRAMEWORK_class_codigo_fonte.txt
├── Framework\             # Sistema legado
├── tasks\                 # Tarefas de migracao
├── projeto\app\           # Codigo fonte novo sistema
│   ├── start\             # main.prg, config.prg
│   ├── classes\           # BOs e classes base
│   ├── forms\             # Formularios (cadastros/relatorios/operacionais)
│   ├── utils\             # functions.prg, messages.prg, validators.prg
│   └── reports\           # Relatorios
└── vbmp\                  # Icones e imagens
```

## Architecture (Three-Layer)

```
FormBase (UI) -> BusinessBase (BO) -> DataAccess (SQL Server)
```

- Forms inherit from `FormBase` (app/classes/formbase.prg)
- BOs inherit from `BusinessBase` (app/classes/businessbase.prg)
- Data layer uses `DataAccess` (app/classes/dataaccess.prg)
- Grids use `GridBase` (app/classes/gridbase.prg)

## Naming Conventions

### Classes & Files
- BOs: `[Entity]BO.prg` (CorBO.prg, ClienteBO.prg)
- Forms: `Form[Entity].prg` (FormCor.prg, FormCliente.prg)
- Reports: `Relatorio[Entity].prg` + `Rel[Entity].frx`

### Objects (suffix _4c_)
- TextBox: `txt_4c_Codigo`, CommandButton: `cmd_4c_Incluir`, Grid: `grd_4c_Dados`, PageFrame: `pgf_4c_Paginas`

### Variables
- Local: `loc_cCodigo`, `loc_nValor` | Parameter: `par_cCodigo` | Property: `this_cCodigo`
- Cursors: `cursor_4c_Dados`, `cursor_4c_Busca`, `cursor_4c_Lista`

## Global Variables

- `gnConnHandle`: SQL Server connection handle
- `gc_4c_UsuarioLogado`: Current logged user
- `go_4c_Sistema`: System object (cEmpresa, cCodEmpresa, cCNPJ, BuscaP, BuscaNome, Matrizes, Transitorio)
- `gc_4c_CaminhoBase/Classes/Utils/Forms/Icones/Reports`: Path variables (RELATIVE, based on SYS(16))
- `_EMPR`: **LEGACY - NEVER use** -> `go_4c_Sistema.cCodEmpresa`

## Critical VFP9 Rules (Top 5)

### 1. NEVER RETURN inside TRY/CATCH
Use flag variable (`loc_lResultado`), RETURN only OUTSIDE TRY/CATCH.

### 2. ISEMPTY() does NOT exist
Use `EMPTY()`. ISEMPTY generates "File 'isempty.prg' does not exist".

### 3. BINDEVENT requires PUBLIC methods
PROTECTED methods fail silently. Handlers must declare event parameters (AfterRowColChange needs par_nColIndex, KeyPress needs par_nKeyCode + par_nShiftAltCtrl).

### 4. Portuguese accents: use CHR() codes
NEVER literal accented chars in .PRG. Key codes: CHR(225)=a-acute, CHR(227)=a-tilde, CHR(231)=c-cedilla, CHR(233)=e-acute, CHR(237)=i-acute, CHR(243)=o-acute, CHR(245)=o-tilde, CHR(250)=u-acute.

### 5. SQL Formatting: ALWAYS use helper functions
`FormatarNumeroSQL()`, `FormatarDataSQL()`, `EscaparSQL()` - all return WITH quotes, NEVER add extra quotes.

### 6. Unattended execution: SET SAFETY OFF in auxiliary scripts
Pipeline runs overnight without supervision. Any .prg script that writes files (STRTOFILE, COPY FILE, COMPILE) MUST start with `SET SAFETY OFF` + `SET RESOURCE OFF`. Modal dialogs block the pipeline indefinitely.

### 7. MsgConfirma() retorna LOGICAL, nao numerico
`MsgConfirma()` retorna `.T.`/`.F.`. NUNCA `IF var = 6`. Usar `IF var` / `IF !var`.

### 8. Metodos PROTECTED devem ser chamados com THIS.
Sem `THIS.`, VFP9 busca `nomeMetodo.prg` externo → "File does not exist". SEMPRE `THIS.NomeMetodo()`.

### 9. CATCH nunca silencioso
Todo CATCH deve ter `MsgErro(loc_oErro.Message, "Erro")` no minimo. CATCH vazio engole erros e impossibilita debug.

### 9.1 PUBLIC nao existe em DEFINE CLASS
`PUBLIC FUNCTION` / `PUBLIC PROCEDURE` dentro de `DEFINE CLASS ... ENDDEFINE` = SYNTAX ERROR. Metodos sao PUBLIC por default. Apenas `PROTECTED` e `HIDDEN` sao modifiers validos.

### 9.2 Page.Width / Page.Height READ-ONLY em runtime
Pages (PageFrame.PageN) NAO aceitam atribuicao a `.Width`/`.Height` em runtime. Tentar causa "CREATEOBJECT retornou valor nao-objeto". PageFrame controla automaticamente.

### 9.3 MostrarAviso NAO EXISTE
Apenas `MostrarErro` (FormErro.prg), `MsgAviso`, `MsgErro`, `MsgConfirma`, `MsgInfo` (messages.prg). `MostrarAviso(...)` causa "File 'mostraraviso.prg' does not exist" em runtime. CorretorAutomatico #90 auto-corrige.

### 9.4 DataSession=2 reseta SET DATE/CENTURY
Forms com `DataSession = 2` (private datasession) recebem datasession isolada com SETs no DEFAULT VFP (`SET DATE TO AMERICAN`, `SET CENTURY OFF`). Sem correcao, datas exibem como `05/25/26` (MM/DD/YY) em vez de `25/05/2026`. Fix sistemico em `FormBase.Init()` (chama `SET DATE TO BRITISH` + `SET CENTURY ON`). **Pre-requisito**: Form Init() DEVE chamar `DODEFAULT()` para que FormBase.Init() execute. Auto-fix: CorretorAutomatico #95.

### 10. Padrao Canonico Saida/Encerrar (PREVALECE sobre PILAR 1)
O bloco de saida dos forms CRUD (container + botao Encerrar) segue o padrao canonico do sistema novo, **NAO o SCX legado**. Esta regra tem precedencia sobre o PILAR 1 (pixel-perfect legado) para este bloco especifico.

| Objeto | Propriedade | Valor canonico |
|--------|-------------|----------------|
| `cnt_4c_Saida` | Left | **917** |
| `cnt_4c_Saida` | Width | **90** |
| `cnt_4c_Saida` | Height | 85 |
| `cmd_4c_Encerrar` | Left / Top | 5 / 5 |
| `cmd_4c_Encerrar` | Width / Height | **75 / 75** |
| `cmd_4c_Encerrar` | Caption | **"Encerrar"** |
| Containers de Page | Width | **`THIS.Width`** (NUNCA `THIS.Width - 60/-65`) |

Se o SCX legado tem `Grupo_Saida.Left=935`, `Width=60`, botao com `Caption="X"`/`"Sair"`/`"Fechar"` ou `Width=50`, **IGNORAR e usar o canonico**. O container de saida eh flutuante/transparente sobre a Page, por isso a Page nao precisa "deixar espaco" — subtrair largura deixa faixa clara exposta.

Auto-fix: CorretorAutomatico patterns **#81, #88, #89**. Referencia: `FormCor`/`FormMoe`.

**Full VFP9 reference, control properties, and 58 common errors**: See vfp9-migration skill.

## BusinessBase Property Names (CORRECT)

| WRONG | CORRECT |
|-------|---------|
| this_cNomeTabela | `this_cTabela` |
| this_cChavePrimaria | `this_cCampoChave` |
| this_oBO | `this_oBusinessObject` |
| ObterTodos() | `Buscar("")` |
| Deletar/Remover() | `Excluir()` (PUBLIC, chama ExecutarExclusao internamente) |

**IMPORTANTE**: Forms chamam `this_oBusinessObject.Excluir()` (PUBLIC). BOs sobrecarregam `ExecutarExclusao()` (PROTECTED). NUNCA chamar ExecutarExclusao() de fora do BO.

## config.prg - Dynamic Loading

ADIR() loads all `*BO.prg` and `Form*.prg` automatically. No manual SET PROCEDURE needed.

```
New entity checklist:
[ ] [Entity]BO.prg in app/classes/
[ ] Form[Entity].prg in app/forms/
[ ] Menu item in menu.prg
[ ] Delete .fxp files before testing
```

## Audit System

BusinessBase has `RegistrarAuditoria(par_cOperacao)` and `ObterChavePrimaria()`. Override ObterChavePrimaria in each BO. Called in Inserir/Atualizar/ExecutarExclusao.

## Form Types

| | CRUD (frmcadastro) | REPORT (frmrelatorio) | OPERACIONAL (form) |
|--|---|---|---|
| BO herda de | BusinessBase | RelatorioBase | BusinessBase |
| Layout | PageFrame Page1+Page2 | FLAT | CUSTOM (grids+containers) |
| Metodo chave | FormParaBO/BOParaForm | FormParaRelatorio | MontaGrade/CarregarDados |
| Acao principal | Inserir/Atualizar/Excluir | PrepararDados+REPORT FORM | Buscar/Imprimir |
| Destroy | DODEFAULT() | this_oRelatorio = .NULL. | DODEFAULT() |

## Processamento de Migracao

- **TODOS os forms**: Processamento multi-fase em 8 fases sequenciais (desde 2026-03-24)
- Modo SIMPLES (2 fases) desativado - gerava problemas recorrentes em forms OPERACIONAIS
- Docs: `docs/PROCESSAMENTO_MULTI_FASE.md`, `docs/METODOLOGIA_ARQUIVOS_GRANDES.md`

## Running the Application

```foxpro
CD C:\4c\projeto\app\start
DO main.prg
```

## REGRA FUNDAMENTAL: SEMPRE FUNCIONALIDADE COMPLETA

**PROIBIDO** criar versoes reduzidas, MVPs ou versoes simplificadas. Paridade funcional 100% com legado. TODOS os campos, lookups e funcionalidades. Se contexto insuficiente, dividir tarefa em partes - NUNCA omitir silenciosamente.

## Documentation Index

| Topic | File |
|-------|------|
| **VFP9 Reference + Control Properties + Errors** | `.claude/skills/vfp9-migration/` |
| **Propagar Licoes Aprendidas** | `.claude/skills/propagate-lesson/` |
| Guia Rapido Migracao | `docs/GUIA_RAPIDO_MIGRACAO.md` |
| Processamento Multi-Fase | `docs/PROCESSAMENTO_MULTI_FASE.md` |
| Estrategia Hibrida Contexto | `docs/ESTRATEGIA_HIBRIDA_CONTEXTO.md` |
| Lookups (FormBuscaAuxiliar) | `docs/lookup_implementation.md` |
| Grids (TextBoxGridLookup) | `docs/grid_implementation.md` |
| Forms (PageFrames, modos) | `docs/form_patterns.md` |
| SQL (SQLEXEC, transacoes) | `docs/sql_guide.md` |
| Migration (checklist) | `docs/migration_guide.md` |
| Reports (FRX, toolbar) | `docs/report_guide.md` |
| Testes Automatizados | `docs/TESTES_AUTOMATIZADOS.md` |
| Database Schema | `docs/schema.sql` |
| Framework Classes | `docs/FRAMEWORK_class_codigo_fonte.txt` |
| UI Fidelity Validation | `docs/ui_fidelity_validation.md` |
| FormCor Licoes | `docs/FORMCOR_LICOES_APRENDIDAS.md` |
| FormProduto Licoes | `docs/FORMPRODUTO_LICOES_APRENDIDAS.md` |
