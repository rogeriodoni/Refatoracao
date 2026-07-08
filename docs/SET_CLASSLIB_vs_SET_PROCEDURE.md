# SET CLASSLIB vs SET PROCEDURE

## Diferença Importante no Visual FoxPro

### ❌ ERRADO (o que estava antes)

```foxpro
SET CLASSLIB TO (gcCaminhoClasses + "dataaccess.prg") ADDITIVE
SET CLASSLIB TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
```

### ✅ CORRETO (o que está agora)

```foxpro
SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg") ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
```

---

## Por Quê?

### SET CLASSLIB
- Usado para **arquivos .VCX** (Visual Class Library)
- São bibliotecas criadas visualmente no Class Designer do VFP
- Formato binário, não editável em editor de texto

**Exemplo:**
```foxpro
SET CLASSLIB TO framework.vcx ADDITIVE
```

### SET PROCEDURE
- Usado para **arquivos .PRG** (Program Files)
- São arquivos de código-fonte em texto puro
- Podem conter DEFINE CLASS, funções, procedures

**Exemplo:**
```foxpro
SET PROCEDURE TO dataaccess.prg ADDITIVE
SET PROCEDURE TO functions.prg ADDITIVE
```

---

## No Nosso Projeto

Todos os nossos arquivos são `.PRG`, então usamos **SET PROCEDURE**:

```foxpro
*-- Classes base
SET PROCEDURE TO dataaccess.prg ADDITIVE
SET PROCEDURE TO businessbase.prg ADDITIVE
SET PROCEDURE TO formbase.prg ADDITIVE
SET PROCEDURE TO gridbase.prg ADDITIVE

*-- Business Objects
SET PROCEDURE TO CorBO.prg ADDITIVE

*-- Utilitários
SET PROCEDURE TO functions.prg ADDITIVE
SET PROCEDURE TO messages.prg ADDITIVE
SET PROCEDURE TO validators.prg ADDITIVE
```

---

## Quando Usar Cada Um?

| Comando | Tipo de Arquivo | Uso |
|---------|----------------|-----|
| **SET CLASSLIB** | `.vcx` | Bibliotecas visuais (criadas no Class Designer) |
| **SET PROCEDURE** | `.prg` | Código-fonte com classes, funções, procedures |

---

## ADDITIVE

A palavra `ADDITIVE` significa **adicionar** ao invés de substituir:

```foxpro
*-- SEM ADDITIVE (substitui)
SET PROCEDURE TO arquivo1.prg
SET PROCEDURE TO arquivo2.prg  && arquivo1 é descarregado!

*-- COM ADDITIVE (adiciona)
SET PROCEDURE TO arquivo1.prg ADDITIVE
SET PROCEDURE TO arquivo2.prg ADDITIVE  && ambos ficam carregados
```

**Sempre use ADDITIVE** para não perder os arquivos anteriores!

---

## Checklist do Nosso Projeto

✅ Todos os arquivos são `.prg`
✅ Usamos `SET PROCEDURE TO ... ADDITIVE`
✅ Carregamos na ordem: Classes Base → BOs → Utilitários

---

## Se Tivéssemos Usado .VCX

Se tivéssemos criado as classes no Class Designer (framework.vcx):

```foxpro
*-- Classes visuais
SET CLASSLIB TO framework.vcx ADDITIVE

*-- Código .prg ainda usa PROCEDURE
SET PROCEDURE TO functions.prg ADDITIVE
```

---

## Resumo

🎯 **Regra Simples:**
- Arquivo `.VCX` → `SET CLASSLIB`
- Arquivo `.PRG` → `SET PROCEDURE`

🔧 **No nosso projeto:**
- Tudo é `.PRG`
- Logo, tudo é `SET PROCEDURE`

✅ **Já está corrigido em:**
- `C:\4c\projeto\app\start\config.prg`
- `C:\4c\TESTAR_CORES.prg`

---

**Pronto!** Agora o sistema vai funcionar corretamente! 🎉
