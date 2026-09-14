---
name: vfp9-migration
description: >
  VFP9 migration reference for converting legacy Visual FoxPro forms to the new
  layered architecture. Use when: migrating SCX forms, creating FormX/XxxBO files,
  fixing VFP9 compilation errors, debugging runtime errors in VFP9, checking valid
  properties for VFP9 controls, running the migration pipeline, or writing any
  VFP9/FoxPro code. Triggers on keywords: migration, migrar, SCX, VFP, FoxPro,
  FormBase, BusinessBase, BO.prg, Form*.prg, CorretorAutomatico, ValidarUIFidelity,
  SQLEXEC, PageFrame, Grid, BINDEVENT, .prg, cadastro, relatorio, operacional.
---

# VFP9 Migration Skill

This skill provides comprehensive VFP9 reference and project-specific migration patterns.

## Quick Reference Files

| File | Content | When to Use |
|------|---------|-------------|
| `control-properties.md` | Valid properties per VFP9 control (Grid, PageFrame, Form, etc.) | "Property XXX not found" errors, checking if property exists |
| `vfp9-reference.md` | VFP9 language reference, functions, gotchas | Writing VFP9 code, fixing syntax errors, SQL formatting |
| `migration-patterns.md` | UI fidelity rules, button specs, form patterns, workflow | Migrating forms, creating BO/Form files |
| `corretor-patterns.md` | 94 auto-fix patterns + common errors table | Debugging errors, understanding CorretorAutomatico fixes |

## Architecture (Three-Layer)

```
FormBase (UI) --> BusinessBase (BO) --> DataAccess (SQL Server)
```

- **FormBase**: UI, data bindings, control events (app/classes/formbase.prg)
- **BusinessBase**: Business rules, validations, CRUD (app/classes/businessbase.prg)
- **DataAccess**: SQL queries, transactions (app/classes/dataaccess.prg)

## Naming Conventions (PILAR 3 - OBRIGATORIO)

### Classes
| Type | Legacy (NEVER) | New (ALWAYS) |
|------|---------------|--------------|
| Forms | Sigcdcor, frmcadastro | FormCor, FormBase |
| BOs | N/A | CorBO, ProdutoBO |
| Base | fwGrade, fwBuscaSel | GridBase, FormBuscaAuxiliar |

### Objects (suffix _4c_)
| Type | Legacy (NEVER) | New (ALWAYS) |
|------|---------------|--------------|
| TextBox | Text1 | txt_4c_Codigo |
| Button | Command1 | cmd_4c_Incluir |
| Grid | Grid1 | grd_4c_Dados |
| PageFrame | Pageframe1 | pgf_4c_Paginas |

### Variables
| Scope | Legacy (NEVER) | New (ALWAYS) |
|-------|---------------|--------------|
| Local | lcCod, lnVal | loc_cCodigo, loc_nValor |
| Parameter | pCod, pVal | par_cCodigo, par_nValor |
| Property | cCodigo | this_cCodigo, this_nValor |

### Files
- Business Objects: `[Entity]BO.prg` (CorBO.prg)
- Forms: `Form[Entity].prg` (FormCor.prg)
- Reports: `Rel[Entity].frx` + `Relatorio[Entity].prg`
- Cursors: `cursor_4c_` prefix (cursor_4c_Dados, cursor_4c_Busca)

## Global Variables

| Variable | Purpose |
|----------|---------|
| gnConnHandle | SQL Server connection handle |
| gc_4c_UsuarioLogado | Current logged user |
| go_4c_Sistema | System object (.cEmpresa, .cCodEmpresa, .cCNPJ, .BuscaP, .BuscaNome, .Matrizes, .Transitorio) |
| gc_4c_CaminhoBase | Base path |
| gc_4c_CaminhoClasses | Classes folder path |
| gc_4c_CaminhoForms | Forms folder path |
| gc_4c_CaminhoIcones | Icons folder path (C:\4c\vbmp\) |
| gc_4c_CaminhoUtils | Utils folder path |
| gc_4c_CaminhoReports | Reports folder path |
| _EMPR | **LEGACY - NEVER use in new code** -> go_4c_Sistema.cCodEmpresa |

## Top 10 Most Common Errors (Quick)

| # | Error | Fix |
|---|-------|-----|
| 1 | RETURN in TRY/CATCH | Use flag variable, RETURN after ENDTRY |
| 2 | "Property XXX not found" | Check control-properties.md for valid properties |
| 3 | ISEMPTY() | Use EMPTY() (ISEMPTY doesn't exist) |
| 4 | BINDEVENT silent fail | Method must be PUBLIC (not PROTECTED) |
| 5 | "Unknown member PAGE1" | Set .PageCount BEFORE accessing .Page1 |
| 6 | PageFrame.BackColor | Use Page1.BackColor (PageFrame has no BackColor) |
| 7 | Grid AllowDelete/Edit | These don't exist. Use .ReadOnly |
| 8 | Column.FontName | Column has no FontName. Use Grid.FontName |
| 9 | VAL() on numeric | Don't use VAL() if .Value is already numeric |
| 10 | OptionGroup.Button1 | Use .Buttons(1) syntax |
| 11 | Datas exibem MM/DD/YY em forms com `DataSession=2` | Form Init() deve chamar `DODEFAULT()` para herdar `SET DATE TO BRITISH`/`SET CENTURY ON` aplicados em FormBase.Init() (datasession privada reseta SETs). Auto-fix: Pattern #95 |

**Full error table**: See `corretor-patterns.md`

## BusinessBase Property Names (CORRECT)

| Property | WRONG Name | CORRECT Name |
|----------|-----------|--------------|
| Table name | this_cNomeTabela | `this_cTabela` |
| PK field | this_cChavePrimaria | `this_cCampoChave` |
| BO reference | this_oBO | `this_oBusinessObject` |
| Get all | ObterTodos() | `Buscar("")` |
| Delete | Excluir() | `ExecutarExclusao()` |
| Load by code | CarregarPorId() | `CarregarPorCodigo()` |

## config.prg - Dynamic Loading (ADIR)

New BO/Form files are loaded automatically via ADIR wildcards.
No need to manually add SET PROCEDURE for new files.

```
Checklist for new entity:
[ ] Create [Entity]BO.prg in app/classes/
[ ] Create Form[Entity].prg in app/forms/cadastros|relatorios|operacionais/
[ ] Add menu item in menu.prg (popup POR TIPO):
    - CRUD (frmcadastro) -> popCadastros
    - REPORT (frmrelatorio) -> popRelatorios
    - OPERACIONAL (form) -> popMovimentos
    Steps: DEFINE BAR N + ON SELECTION BAR N + PROCEDURE AbrirFormXxx()
[ ] Delete .fxp files before testing
```
