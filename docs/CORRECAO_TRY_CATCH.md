# Correção: RETURN dentro de TRY/CATCH

## Problema Identificado

No Visual FoxPro, **não se deve usar RETURN dentro de blocos TRY/CATCH**. Isso pode causar comportamento inesperado e problemas de execução.

### ❌ Padrão INCORRETO

```foxpro
PROCEDURE MinhaFuncao()
    TRY
        * código
        IF lnResultado < 0
            RETURN .F.    && ERRADO!
        ENDIF
        RETURN .T.        && ERRADO!
    CATCH TO loError
        RETURN .F.        && ERRADO!
    ENDTRY
ENDPROC
```

### ✅ Padrão CORRETO

```foxpro
PROCEDURE MinhaFuncao()
    LOCAL llResultado
    llResultado = .F.

    TRY
        * código
        IF lnResultado < 0
            llResultado = .F.    && CORRETO!
        ELSE
            llResultado = .T.    && CORRETO!
        ENDIF
    CATCH TO loError
        llResultado = .F.        && CORRETO!
    ENDTRY

    RETURN llResultado           && CORRETO!
ENDPROC
```

---

## Arquivos Corrigidos

### 1. main.prg ✅

**Procedures corrigidos:**
- `ConectarBancoDados()` - linha 65
- `TestarConexao()` - linha 202

**O que foi feito:**
- Adicionada variável `llConectado` e `llConexaoOK`
- Removidos todos os RETURNs de dentro do TRY/CATCH
- RETURN movido para depois do ENDTRY

### 2. dataaccess.prg ✅

**Procedures corrigidos:**
- `ExecutarQuery()` - linha 38
- `IniciarTransacao()` - linha 80
- `ConfirmarTransacao()` - linha 112
- `ReverterTransacao()` - linha 144

**O que foi feito:**
- Adicionada variável `llSucesso` em cada método
- Substituídos os RETURNs por atribuições à variável
- RETURN movido para depois do ENDTRY

### 3. businessbase.prg ✅

**Procedures corrigidos:**
- `Salvar()` - linha 88

**O que foi feito:**
- Movida declaração de `llResultado = .F.` para antes do TRY
- Removidos RETURNs de dentro do TRY/CATCH
- RETURN movido para depois do ENDTRY

### 4. CorBO.prg ✅

**Status:** Nenhuma correção necessária
- Não contém RETURNs dentro de TRY/CATCH

### 5. Utilitários ✅

**Status:** Nenhuma correção necessária
- functions.prg, messages.prg, validators.prg não usam TRY/CATCH

---

## Resumo das Mudanças

| Arquivo | Linhas Afetadas | Métodos Corrigidos |
|---------|----------------|-------------------|
| main.prg | 65-112, 202-226 | 2 |
| dataaccess.prg | 38-75, 80-107, 112-139, 144-165 | 4 |
| businessbase.prg | 88-134 | 1 |
| **Total** | | **7 métodos** |

---

## Por Que Esta Correção é Importante?

### Problemas que podem ocorrer com RETURN em TRY/CATCH:

1. **Comportamento Imprevisível**
   - O VFP pode não executar corretamente o ENDTRY
   - Pode deixar o estado do sistema inconsistente

2. **Limpeza de Recursos**
   - Código após o TRY/CATCH não é executado
   - Recursos podem não ser liberados adequadamente

3. **Debug Difícil**
   - Erros podem ser silenciosos
   - Difícil rastrear o fluxo de execução

### Benefícios da Correção:

✅ **Fluxo Claro** - Sempre executa até o final
✅ **Previsível** - Comportamento consistente
✅ **Manutenível** - Código mais legível
✅ **Seguro** - Garante limpeza de recursos

---

## Padrão de Código Adotado

```foxpro
*-- Padrão para métodos que retornam .T./.F.
PROCEDURE MeuMetodo()
    LOCAL llSucesso
    llSucesso = .F.  && Valor padrão pessimista

    *-- Validações rápidas (antes do TRY)
    IF condicaoInvalida
        RETURN llSucesso  && OK aqui, está fora do TRY
    ENDIF

    TRY
        *-- Processamento principal
        IF tudoCerto
            llSucesso = .T.
        ELSE
            llSucesso = .F.
        ENDIF

    CATCH TO loError
        *-- Tratamento de erro
        llSucesso = .F.
        THIS.RegistrarErro(loError.Message)
    ENDTRY

    RETURN llSucesso  && Sempre após ENDTRY
ENDPROC
```

---

## Checklist de Validação

Após correções, verificar:

- [x] Nenhum RETURN dentro de TRY
- [x] Nenhum RETURN dentro de CATCH
- [x] Variáveis locais declaradas antes do TRY
- [x] RETURN sempre após ENDTRY
- [x] Valor padrão define comportamento pessimista (.F.)
- [x] Código compila sem erros
- [x] Testes funcionais passam

---

## Para Futuros Desenvolvimentos

**SEMPRE lembrar:**

```foxpro
❌ NÃO FAZER:
TRY
    RETURN .T.  && NUNCA!
CATCH
    RETURN .F.  && NUNCA!
ENDTRY

✅ FAZER:
LOCAL llResultado
llResultado = .F.
TRY
    llResultado = .T.
CATCH
    llResultado = .F.
ENDTRY
RETURN llResultado
```

---

## Referências

- **Visual FoxPro Help:** "TRY...CATCH...FINALLY Command"
- **Best Practices:** Sempre use variáveis para armazenar resultado
- **Testing:** Execute testes após qualquer mudança em TRY/CATCH

---

**Data da Correção:** 2025-11-24
**Arquivos Afetados:** 3 (main.prg, dataaccess.prg, businessbase.prg)
**Status:** ✅ Concluído e Validado
