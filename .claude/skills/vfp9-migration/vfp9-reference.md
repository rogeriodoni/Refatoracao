# VFP9 Language Reference

Quick reference for VFP9 language features, functions, and gotchas.
Source: HackFox (hackfox.github.io) + project experience.

---

## Functions that DO NOT EXIST in VFP9

**LLMs frequently hallucinate these - NEVER use:**

| Function/Syntax | Error Generated | Correct Alternative |
|----------------|-----------------|---------------------|
| `ISEMPTY()` | "File 'isempty.prg' does not exist" | `EMPTY()` |
| `ELSEIF` | Syntax error | `ELSE` + `IF` + `ENDIF` |
| Ternary `? :` | Syntax error | `IIF(condition, true_val, false_val)` |
| `LOCATE IN alias FOR` | Syntax error | `SELECT alias` + `LOCATE FOR` |
| `LOCAL DIMENSION` | Invalid syntax | `DIMENSION` or `LOCAL ARRAY` |

---

## Functions that DO EXIST (commonly confused)

### Testing/Type Functions
| Function | Purpose | Gotcha |
|----------|---------|--------|
| `EMPTY(expr)` | Test if empty | Returns .F. for .NULL. (use ISNULL instead) |
| `ISNULL(expr)` | Test if NULL | |
| `NVL(expr, alt)` | NULL coalesce | |
| `BETWEEN(val, lo, hi)` | Range check | |
| `TYPE("expr")` | Type as string | Argument is a STRING (quoted) |
| `VARTYPE(expr)` | Type of value | Argument is the VALUE itself (not quoted) |
| `PEMSTATUS(obj, prop, mode)` | Check property exists | mode 5 = property exists |

### String Functions
| Function | Purpose |
|----------|---------|
| `ALLTRIM(str)` | Remove leading/trailing spaces |
| `PADL(str, len)` | Pad left |
| `PADR(str, len)` | Pad right |
| `TRANSFORM(val, fmt)` | Format value as string |
| `STR(num, len, dec)` | Number to string |
| `VAL(str)` | String to number (**ONLY on strings! Error on numeric**) |
| `SUBSTR(str, start, len)` | Substring |
| `AT(find, str)` | Position of substring |
| `UPPER(str)` / `LOWER(str)` | Case conversion |
| `LEN(str)` | String length |
| `STRTRAN(str, find, replace)` | String replace |
| `CHRTRAN(str, find, replace)` | Character-level replace |
| `CHR(nCode)` | ASCII code to character |
| `ASC(char)` | Character to ASCII code |

### Numeric Functions
| Function | Purpose |
|----------|---------|
| `INT(num)` | Truncate to integer |
| `CEILING(num)` | Round up |
| `FLOOR(num)` | Round down |
| `ROUND(num, dec)` | Round to N decimals |
| `MOD(num, div)` | Modulo |
| `ABS(num)` | Absolute value |
| `MAX(a, b)` / `MIN(a, b)` | Maximum/Minimum |

### Date Functions
| Function | Purpose |
|----------|---------|
| `DATE()` | Current date |
| `DATETIME()` | Current datetime |
| `YEAR(date)` | Extract year |
| `MONTH(date)` | Extract month |
| `DAY(date)` | Extract day |
| `DTOC(date)` | Date to character (**uses SET DATE - NAO usar em SQL!**) |
| `CTOD(str)` | Character to date |
| `DTOS(date)` | Date to string (YYYYMMDD - safe for comparisons) |
| `GOMONTH(date, n)` | Add N months |

### Object Functions
| Function | Purpose | Notes |
|----------|---------|-------|
| `CREATEOBJECT(class)` | Create instance | Requires SET PROCEDURE/CLASSLIB |
| `EVALUATE(expr)` | Evaluate expression | **Returns value, does NOT assign!** |
| `DODEFAULT()` | Call parent method | Scope operator for inheritance |
| `BINDEVENT(src, evt, obj, method)` | Bind event handler | Handler must be PUBLIC |
| `SYS(16)` | Current program path | Used for relative paths |

---

## EVALUATE() - CRITICAL Gotcha

EVALUATE() evaluates an expression and RETURNS the result. It does NOT execute assignment.

```foxpro
*-- WRONG - "Operator/operand type mismatch":
EVALUATE("objeto.Value = 0")       && = is COMPARISON, not assignment!
EVALUATE("objeto.InputMask = '999.99'")  && Error!

*-- CORRECT - Get reference first, then assign:
LOCAL loc_oControl
loc_oControl = EVALUATE("par_oContainer." + par_cNomeCampo)
loc_oControl.Value = 0
loc_oControl.InputMask = "999.99"
```

---

## VFP OR Does NOT Short-Circuit

Both sides of OR are ALWAYS evaluated, even if the first is .T.

```foxpro
*-- WRONG - If variable doesn't exist, second side FAILS:
IF TYPE("myVar") != "L" OR !myVar
    && VFP evaluates BOTH sides -> error if myVar undefined
ENDIF

*-- CORRECT - Use nested IF:
IF TYPE("myVar") = "L"
    IF myVar = .T.
        loc_lFlag = .T.
    ENDIF
ENDIF

*-- ALTERNATIVE - AND does short-circuit:
IF NOT (TYPE("myVar") = "L" AND myVar)
    && If TYPE fails, VFP does NOT evaluate myVar
ENDIF
```

---

## RETURN Inside TRY/CATCH - FORBIDDEN

VFP9 does NOT allow RETURN inside TRY or CATCH blocks.

```foxpro
*-- WRONG - "RETURN/RETRY statement not allowed in TRY/CATCH":
TRY
    RETURN .T.     && FORBIDDEN!
CATCH
    RETURN .F.     && FORBIDDEN!
ENDTRY

*-- CORRECT - Use flag variable:
LOCAL loc_lResultado
loc_lResultado = .F.
TRY
    loc_lResultado = .T.
CATCH
    loc_lResultado = .F.
ENDTRY
RETURN loc_lResultado   && RETURN only OUTSIDE TRY/CATCH
```

---

## Array Syntax

```foxpro
*-- CORRECT:
DIMENSION laArray[n, m]
LOCAL ARRAY laArray[n, m]

*-- WRONG:
LOCAL DIMENSION laArray[n, m]   && Invalid syntax in VFP9
```

---

## BINDEVENT Limitations

| Works With | Does NOT Work With |
|------------|-------------------|
| Click | Valid |
| DblClick | When |
| KeyPress | Grid column events (unreliable) |
| GotFocus | **PROTECTED methods** |
| LostFocus | |
| InteractiveChange | |
| AfterRowColChange | |

**Handlers MUST declare event parameters:**
| Event | Required Parameters |
|-------|-------------------|
| AfterRowColChange | `par_nColIndex` |
| KeyPress | `par_nKeyCode, par_nShiftAltCtrl` |
| Click, DblClick, GotFocus, LostFocus | (none) |

---

## DataSession=2 Resets SET Commands - Date Format Bug

**Forms com `DataSession = 2` (private datasession) ganham datasession isolada com SETs no DEFAULT VFP**, ignorando configuracoes globais do `main.prg`/`config.prg`.

| SET Command | Default em Private DataSession | Resultado se nao corrigido |
|-------------|-------------------------------|----------------------------|
| `SET DATE` | `AMERICAN` (MDY) | Data exibe `05/25/26` em vez de `25/05/2026` |
| `SET CENTURY` | `OFF` (2 digitos) | Ano sem seculo (`26` em vez de `2026`) |
| `SET MARK` | `-` | Separador errado (`05-25-26`) |

**Fix sistemico (ja aplicado em `app/classes/formbase.prg` em 2026-05-25)**: `FormBase.Init()` chama `SET DATE TO BRITISH` + `SET CENTURY ON` + `SET CENTURY TO 19 ROLLOVER 50` + `SET MARK TO "/"` ANTES de qualquer outra logica. Como Init() roda DENTRO da datasession privada apos sua criacao, os SETs ficam corretos para o ciclo de vida do form.

**Pre-requisito**: Forms que sobrescrevem `PROCEDURE Init()` DEVEM chamar `DODEFAULT()`. Sem isso, FormBase.Init() nao executa e o fix nao se aplica.

```foxpro
*-- CORRETO: Init delega para FormBase.Init() via DODEFAULT()
PROCEDURE Init()
    RETURN DODEFAULT()  && Executa SET DATE TO BRITISH + SET CENTURY ON
ENDPROC

*-- CORRETO: Init com logica propria mas ainda chama DODEFAULT()
PROCEDURE Init()
    DODEFAULT()  && SEMPRE primeiro - aplica SETs do FormBase
    THIS.MeuSetupExtra()
ENDPROC

*-- ERRADO: Init custom sem DODEFAULT() - datas viram MM/DD/YY
PROCEDURE Init()
    THIS.MeuSetupExtra()  && BUG: FormBase.Init() nunca roda
ENDPROC
```

**Auto-fix**: CorretorAutomatico Pattern #95 (`Corrigir-InitFormSemDodefault`) detecta forms com DataSession=2 + Init() sem DODEFAULT() e insere `DODEFAULT()` no inicio do corpo.

**Referencia**: `feedback_datasession_privada_set_date.md` (memoria 2026-05-25, bug reportado em `C:\4c\origem\ErroData.jpg` afetando 42 forms).

---

## PEMSTATUS Inside WITH - Reference Bug

Inside WITH block, `.Name` prepends to the WITH object, causing invalid reference.

```foxpro
*-- WRONG:
WITH loc_oGrid.Column1
    IF PEMSTATUS(.Column1, "Text1", 5)  && .Column1 = Column1.Column1 = ERROR!
ENDWITH

*-- CORRECT:
WITH loc_oGrid.Column1
    IF PEMSTATUS(loc_oGrid.Column1, "Text1", 5)  && Full reference
ENDWITH
```

---

## Commands NEVER to Use

| Command | Why | Alternative |
|---------|-----|-------------|
| ACCEPT, INPUT | Obsolete Xbase | Form controls |
| INSERT (Xbase) | Physical record rewrite | SQL INSERT or APPEND |
| JOIN (Xbase) | Cartesian, inflexible | SQL SELECT |
| SET COMPATIBLE ON | Breaks everything | Native FoxPro syntax |
| SORT | Inefficient | SQL SELECT + ORDER BY |
| FIND | Obsolete | SEEK or LOCATE |
| CLEAR EVENTS | Closes entire app | **Only in menu "Exit System"** |

### Use With Extreme Caution
| Command | Why |
|---------|-----|
| ZAP | No DELETE TRIGGER, no undo. Use `ZAP IN alias` |
| PACK | Risk of catastrophic failure. Back up first |

### PUBLIC/PROTECTED PROCEDURE Inside DEFINE CLASS

VFP9 does NOT accept `PUBLIC PROCEDURE` or `PRIVATE PROCEDURE` modifiers inside DEFINE CLASS blocks. All methods are PUBLIC by default. Using `PUBLIC PROCEDURE` causes "Syntax error" and cascading "Statement is not valid in a class definition" on ALL subsequent lines.

```foxpro
*-- WRONG (causes Syntax error):
DEFINE CLASS FormXxx AS FormBase
    PUBLIC PROCEDURE BtnSalvarClick()
        ...
    ENDPROC
ENDDEFINE

*-- CORRECT:
DEFINE CLASS FormXxx AS FormBase
    PROCEDURE BtnSalvarClick()
        ...
    ENDPROC
ENDDEFINE
```

`PROTECTED PROCEDURE` IS valid inside DEFINE CLASS (restricts visibility), but note that BINDEVENT handlers MUST be non-protected to work.

---

## Portuguese Accents (pt-BR) - CHR() Codes

**NEVER use literal accented characters in .PRG files.**

| Char | CHR() | Example |
|------|-------|---------|
| a with acute | CHR(225) | "Usu" + CHR(225) + "rios" |
| a with grave | CHR(224) | |
| a with circumflex | CHR(226) | "par" + CHR(226) + "metro" |
| a with tilde | CHR(227) | "conex" + CHR(227) + "o" |
| e with acute | CHR(233) | "caf" + CHR(233) |
| e with circumflex | CHR(234) | "voc" + CHR(234) |
| i with acute | CHR(237) | "sa" + CHR(237) + "da" |
| o with acute | CHR(243) | "Relat" + CHR(243) + "rios" |
| o with circumflex | CHR(244) | |
| o with tilde | CHR(245) | |
| u with acute | CHR(250) | "conte" + CHR(250) + "do" |
| c with cedilla | CHR(231) | "lan" + CHR(231) + "amento" |
| copyright | CHR(169) | CHR(169) + " 2025" |

---

## SQL Formatting Functions (Project-Specific)

```foxpro
*-- FormatarNumeroSQL(nValor, nDecimais) - SEMPRE para numeros em SQL
*-- TRANSFORM() usa SET POINT (virgula no BR), SQL Server espera ponto
loc_cSQL = "UPDATE t SET campo = " + FormatarNumeroSQL(nValor, 4)

*-- FormatarDataSQL(dData) - SEMPRE para datas em SQL
*-- JA RETORNA COM ASPAS ('YYYY-MM-DD') - NUNCA adicionar aspas extras!
loc_cSQL = "UPDATE t SET campo = " + FormatarDataSQL(dData)

*-- EscaparSQL(cValor) - SEMPRE para strings em SQL
*-- JA RETORNA COM ASPAS ('valor') - NUNCA adicionar aspas extras!
loc_cSQL = "WHERE campo = " + EscaparSQL(cValor)
*-- WRONG: "WHERE campo = '" + EscaparSQL(cValor) + "'"  && Gera ''valor''
*-- CORRECT: "WHERE campo = " + EscaparSQL(cValor)        && Gera 'valor'

*-- CapturarErroSQL() - Captura mensagem de erro SQL via AERROR()
MostrarErro("Erro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
```

---

## Loading Files in VFP9

| File Type | Command | Use Case |
|-----------|---------|----------|
| .PRG with classes | `SET PROCEDURE TO file.prg ADDITIVE` | Load class definitions |
| .VCX visual lib | `SET CLASSLIB TO file.vcx ADDITIVE` | Load visual classes |
| .SCX visual form | `DO FORM file.scx` | Run visual form |
| .PRG class form | `loForm = CREATEOBJECT("Class")` then `loForm.Show()` | Run programmatic form |

---

## Utility Functions (Project app/utils/)

| File | Functions |
|------|-----------|
| functions.prg | SomenteNumeros(), FormatarCPF(), FormatarCNPJ(), EscaparSQL(), FormatarNumeroSQL(), FormatarDataSQL(), CapturarErroSQL(), fChecaAcesso(), fAcessoContab(), fAcessoContas(), fVerificaBloqueio(), fRecalculaS(), fProcessarS(), fDtoSQL(), fUniqueIds() |
| messages.prg | MsgErro(), MsgAviso(), MsgSucesso(), MsgConfirma(), MostrarErro() |
| validators.prg | ValidarCPF(), ValidarCNPJ(), ValidarEmail(), ValidarData() |

---

## REPORT FORM TO FILE - Macro Expansion Required

VFP9 `REPORT FORM ... TO FILE` does NOT accept inline expressions or name expressions `(var)`.
Must use macro expansion `&var`.

```foxpro
*-- WRONG - "Command contains unrecognized phrase/keyword":
REPORT FORM MyReport TO FILE ADDBS(SYS(2023)) + "output.xls" TYPE XLS NOCONSOLE
REPORT FORM MyReport TO FILE (loc_cFile) TYPE XLS NOCONSOLE

*-- CORRECT - Pre-compute into variable, use macro expansion:
LOCAL loc_cArqExcel
loc_cArqExcel = ADDBS(SYS(2023)) + "output.xls"
REPORT FORM MyReport TO FILE &loc_cArqExcel TYPE XLS NOCONSOLE
```

---

## this_cMensagemErro - Form Classes MUST Declare

`this_cMensagemErro` is defined in **BusinessBase**, NOT in **FormBase**.
If a Form class uses `THIS.this_cMensagemErro` (e.g., in CATCH blocks), it MUST declare the property.

```foxpro
*-- WRONG - "Property THIS_CMENSAGEMERRO is not found":
DEFINE CLASS FormXxx AS FormBase
    *-- No property declaration, but uses THIS.this_cMensagemErro in CATCH
ENDDEFINE

*-- CORRECT - Declare property in Form class:
DEFINE CLASS FormXxx AS FormBase
    this_cMensagemErro = ""    && Required! Not inherited from FormBase
ENDDEFINE
```

**Impact**: Without this declaration, if ANY error occurs during InicializarForm(), the CATCH block itself fails, masking the real error.

---

## Error Message in CATCH - Include LineNo

```foxpro
CATCH TO loException
    MostrarErro("Erro:" + CHR(13) + ;
               "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
               loException.Message, "Erro")
ENDTRY

*-- Or pass Exception object directly:
CATCH TO loException
    MostrarErro(loException, "NomeDoMetodo")
ENDTRY
```

Properties: LineNo, Message, Procedure, Details

---

## CREATE CURSOR Limits

- Character field max: C(254) - NOT C(290) etc.
- Same cursor created in multiple places: field ORDER must be IDENTICAL
- SET NULL ON before CREATE CURSOR if APPEND FROM SQLEXEC data with NULLs
