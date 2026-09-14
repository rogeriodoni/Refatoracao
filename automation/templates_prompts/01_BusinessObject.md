# MIGRAÇÃO VFP9 - FASE 1: Business Object

## CONTEXTO
- **Projeto**: Migração VFP9 - Sistema 4C
- **Task**: {{TaskId}}
- **Formulário Original**: {{BaseName}}
- **Fase**: 1 de {{TotalFases}} (Business Object)

## ARQUIVOS DE REFERÊNCIA
- **CLAUDE.md**: `C:\4c\CLAUDE.md` (regras do projeto)
- **Código Original**: `{{TaskPath}}\{{BaseName}}_codigo_fonte.txt`
- **Inventário**: `{{TaskPath}}\inventario.json`
- **Schema SQL**: `C:\4c\docs\schema.sql`
- **Exemplo**: `C:\4c\projeto\app\classes\CorBO.prg`

## TAREFA
Criar arquivo `{{BaseName}}BO.prg` com TODAS as propriedades da tabela correspondente.

### Identificar Tabela Principal
Analisar código original para identificar:
- Nome da tabela (procurar por `SELECT`, `FROM`, `RecordSource`)
- Campos da tabela (consultar `schema.sql`)

### Criar Business Object Completo

```foxpro
*==============================================================================
* {{BaseName}}BO.prg
* Business Object para [NomeTabela]
* Gerado automaticamente em: {{Timestamp}}
*==============================================================================
DEFINE CLASS {{BaseName}}BO AS BusinessBase

    *-- Propriedades de dados (TODOS os campos da tabela)
    this_cCampo1 = ""
    this_nCampo2 = 0
    this_dCampo3 = {}
    *... (TODOS os campos)

    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela = "[NomeTabela]"
        THIS.this_cCampoChave = "[CampoPK]"
        RETURN .T.
    ENDPROC

    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        *... carregar TODOS os campos
    ENDPROC

    PROTECTED PROCEDURE Inserir()
        *... SQL INSERT com TODOS os campos
    ENDPROC

    PROTECTED PROCEDURE Atualizar()
        *... SQL UPDATE com TODOS os campos
    ENDPROC

    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_[CampoPK])
    ENDPROC

ENDDEFINE
```

## REGRAS OBRIGATÓRIAS
1. ✅ Herdar de `BusinessBase` (app/classes/businessbase.prg)
2. ✅ Declarar TODAS as propriedades da tabela (this_c*, this_n*, this_d*, this_l*)
3. ✅ `Init()`: Definir `this_cTabela` e `this_cCampoChave`
4. ✅ `CarregarDoCursor()`: Carregar TODOS os campos
5. ✅ `Inserir()`: SQL INSERT com TODOS os campos (usar FormatarNumeroSQL, FormatarDataSQL, EscaparSQL)
6. ✅ `Atualizar()`: SQL UPDATE com TODOS os campos
7. ✅ `ObterChavePrimaria()`: Retornar PK para auditoria
8. ❌ NUNCA usar RETURN dentro de TRY/CATCH (usar variável)
9. ❌ NUNCA omitir campos (paridade 100%)
10. ❌ NUNCA inventar nomes de colunas SQL - SEMPRE consultar `schema.sql` para nomes EXATOS
11. ⚠️ Em queries com JOIN, verificar de QUAL tabela (alias) cada coluna vem (ex: `b.Cpfs` de SigCdCli, NÃO `a.Cpfs` de SigMvSlc)
12. ❌ NUNCA usar COMMIT/ROLLBACK avulsos após SQLEXEC simples. A conexão ODBC opera em AUTOCOMMIT. Usar transações SOMENTE via DataAccess para operações multi-statement

### ⚠️ REGRA CRÍTICA: Nomes de Colunas SQL (NUNCA INVENTAR!)
Os nomes de colunas no banco são frequentemente abreviados e não-intuitivos. **SEMPRE consultar `docs/schema.sql`** antes de escrever qualquer query.

**Erros comuns já encontrados:**
| Coluna ERRADA (inventada) | Coluna CORRETA (schema.sql) | Tabela |
|---------------------------|----------------------------|--------|
| `Codpams` | NÃO EXISTE (SigCdPam é registro único) | SigCdPam |
| `Concils` | `Concs` | SigMvCcr |
| `Usuar` | `Usualts` | SigMvCcr |
| `Tipo` | `Tipos` | SigMvCcr |
| `Valos` (em SigMvCcr) | `Valors` | SigMvCcr |
| `Hists2` | `Hist2s` | SigMvCcr |
| `hiss3` | `Shists` | SigMvCcr |
| `a.Cpfs` (SigMvSlc) | `b.Cpfs` (SigCdCli via JOIN) | SigMvSlc+SigCdCli |
| `a.Matris` (SigMvSlc) | `b.ContaMats` (SigCdCli via JOIN) | SigMvSlc+SigCdCli |
| `a.Situas` (SigMvSlc) | `b.Situas` (SigCdCli via JOIN) | SigMvSlc+SigCdCli |

**Processo obrigatório para queries SQL:**
1. Identificar a tabela no código original legado
2. Abrir `docs/schema.sql` e buscar `CREATE TABLE [dbo].[NomeTabela]`
3. Copiar nomes de colunas EXATOS do schema
4. Em JOINs: verificar qual coluna pertence a qual tabela (alias a, b, m, etc.)

## ENTREGA ESPERADA
- Arquivo `{{BaseName}}BO.prg` completo
- Salvar em: `C:\4c\projeto\app\classes\{{BaseName}}BO.prg`
- TODOS os campos da tabela implementados
- Métodos CRUD funcionais
- Sem erros de sintaxe VFP

## VALIDAÇÃO
- ✅ Código compila sem erros
- ✅ TODOS os campos têm propriedade correspondente
- ✅ `CarregarDoCursor()` completo
- ✅ `Inserir()`/`Atualizar()` completos
- ✅ `ObterChavePrimaria()` retorna PK correta
