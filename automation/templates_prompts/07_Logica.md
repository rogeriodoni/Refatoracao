# MIGRAÇÃO VFP9 - FASE 7: Lógica de Negócio (Grupo {{GrupoLetra}})

## CONTEXTO
- **Projeto**: Migração VFP9 - Sistema 4C
- **Task**: {{TaskId}}
- **Formulário Original**: {{BaseName}}
- **Fase**: 7{{GrupoLetra}} - Lógica de Negócio Grupo {{GrupoLetra}}
- **Procedures**: {{ProcInicio}} a {{ProcFim}} ({{TotalProcedures}} procedures)

## ARQUIVOS DE REFERÊNCIA
- **CLAUDE.md**: `C:\4c\CLAUDE.md` (regras do projeto)
- **Código Original**: `{{TaskPath}}\{{BaseName}}_codigo_fonte.txt`
- **Form Atual**: `C:\4c\projeto\app\forms\cadastros\Form{{BaseName}}.prg`
- **BO**: `C:\4c\projeto\app\classes\{{BaseName}}BO.prg`

## TAREFA
Implementar procedures customizados {{ProcInicio}} a {{ProcFim}} do formulário original.

## PROCEDURES DESTE GRUPO
{{ListaProcedures}}

### Estratégia de Adaptação

#### Análise do Código Original
1. Identificar procedures no código original (PROCEDURE xxxx)
2. Entender lógica de cada procedure
3. Identificar onde devem ser implementados:
   - **Form**: Se manipula UI (campos, grids, botões)
   - **BO**: Se manipula dados/banco (cálculos, validações de negócio)

#### Separação de Responsabilidades

```foxpro
*-- EXEMPLO: Procedure de cálculo fiscal

*-- Original (tudo no form):
PROCEDURE CalcularICMS
    LOCAL lnBase, lnAliquota, lnICMS
    lnBase = ThisForm.txt_Valor.Value
    lnAliquota = ThisForm.txt_Aliquota.Value
    lnICMS = lnBase * lnAliquota / 100
    ThisForm.txt_ICMS.Value = lnICMS

    *-- Salvar no banco
    UPDATE SigMvCab SET ICMS = lnICMS WHERE Id = ThisForm.nId
ENDPROC

*-- Novo (separado):
*-- NO FORM (Form{{BaseName}}.prg):
PROTECTED PROCEDURE CalcularICMS()
    *-- Transferir dados para BO
    THIS.FormParaBO()

    *-- Chamar lógica no BO
    THIS.this_oBusinessObject.CalcularImpostos()

    *-- Atualizar form com resultado
    THIS.BOParaForm()
ENDPROC

*-- NO BO ({{BaseName}}BO.prg):
PROCEDURE CalcularImpostos()
    LOCAL loc_nBase, loc_nAliquota, loc_nICMS

    loc_nBase = THIS.this_nValor
    loc_nAliquota = THIS.this_nAliquota

    *-- Cálculo (lógica de negócio)
    loc_nICMS = loc_nBase * loc_nAliquota / 100

    *-- Armazenar resultado
    THIS.this_nICMS = loc_nICMS
ENDPROC
```

#### Adaptações Comuns

```foxpro
*-- 1. Referências a ThisForm → THIS
ThisForm.txt_Campo.Value  →  THIS.pgf_4c_Principal.Page2.txt_4c_Campo.Value

*-- 2. Referências a campos diretos → BO
m.Codigo  →  THIS.this_oBusinessObject.this_cCodigo

*-- 3. SQL UPDATE/INSERT → Métodos do BO
UPDATE tabela SET campo = valor  →  THIS.this_oBusinessObject.Salvar()

*-- 4. Formatação de valores SQL
"UPDATE tab SET val = " + STR(nValor)  →  FormatarNumeroSQL(nValor, 2)
"UPDATE tab SET dt = '" + DTOC(dData) + "'"  →  FormatarDataSQL(dData)

*-- 5. RETURN dentro de TRY/CATCH → Variável
TRY
    RETURN .F.  ❌ ERRADO
CATCH
ENDTRY

TRY
    loc_lResultado = .F.  ✅ CORRETO
CATCH
ENDTRY
RETURN loc_lResultado
```

## REGRAS OBRIGATÓRIAS
1. ✅ Implementar TODOS os {{TotalProcedures}} procedures deste grupo
2. ✅ Manter lógica IDÊNTICA ao original
3. ✅ Separar responsabilidades:
   - Form: UI, navegação, eventos
   - BO: Dados, cálculos, validações
4. ✅ Adaptar referências (ThisForm → THIS)
5. ✅ Usar FormatarNumeroSQL/FormatarDataSQL/EscaparSQL
6. ✅ NUNCA usar RETURN dentro de TRY/CATCH
7. ✅ Comentar lógica complexa
8. ✅ Preservar nomes de variáveis quando possível (ajuda rastrear)
9. ❌ NUNCA inventar nomes de colunas SQL - copiar do código ORIGINAL e validar em `docs/schema.sql`
10. ⚠️ Em JOINs: verificar o ALIAS correto de cada coluna (ex: `b.Cpfs` de SigCdCli, NÃO `a.Cpfs` de SigMvSlc)
11. ⚠️ Tabela SigCdPam é registro único - NÃO tem coluna PK para WHERE, usar `SELECT TOP 1 ... FROM SigCdPam`
12. ⚠️ LostFocus ≠ Valid: Valid SÓ dispara quando valor MUDA, LostFocus dispara SEMPRE. Handlers via BINDEVENT LostFocus que abrem lookup/busca DEVEM ter guardia de valor alterado (ver abaixo)
13. ⚠️ Validar* (busca reversa por descrição): PRIMEIRO buscar direto no banco (SELECT WHERE campo = valor). SÓ abrir FormBuscaAuxiliar se NÃO encontrou
14. ⚠️ DynamicForeColor/DynamicBackColor: SEMPRE usar PEMSTATUS(obj, "DynamicForeColor", 5) antes de atribuir
15. ❌ NUNCA usar COMMIT/ROLLBACK avulsos em UPDATE/INSERT/DELETE simples. A conexão ODBC opera em AUTOCOMMIT — cada SQLEXEC já é transação implícita. COMMIT/ROLLBACK avulsos causam "ROLLBACK TRANSACTION has no corresponding BEGIN TRANSACTION". Usar transações SOMENTE via DataAccess.IniciarTransacao()/ConfirmarTransacao()/ReverterTransacao() para operações multi-statement

### ⚠️ REGRA CRÍTICA: LostFocus vs Valid (Diferença Comportamental)
No legado, **Valid** só dispara quando o valor do campo MUDA. Mas **BINDEVENT com LostFocus** dispara em CADA perda de foco (ex: ao clicar em outro campo ou botão).

**Consequência**: Se o handler via LostFocus abre `FormBuscaAuxiliar` sem verificar se o valor mudou, a janela de busca abre TODA vez que o usuário navega pelo form.

**Solução OBRIGATÓRIA**: Adicionar propriedade de rastreamento + guardia:
```foxpro
*-- Propriedade no form:
this_cUltimoGrupoValidado = ""

*-- No handler:
PROCEDURE ValidarGrupo()
    LOCAL loc_cGrupo, loc_lPular
    loc_lPular = .F.
    TRY
        loc_cGrupo = ALLTRIM(THIS.txt_4c_Grupo.Value)
        IF loc_cGrupo == THIS.this_cUltimoGrupoValidado
            loc_lPular = .T.
        ENDIF
        IF !loc_lPular
            THIS.this_cUltimoGrupoValidado = loc_cGrupo
            *-- Lógica de validação aqui...
        ENDIF
    CATCH TO loException
        MostrarErro(loException, "ValidarGrupo")
    ENDTRY
ENDPROC
```

### ⚠️ REGRA CRÍTICA: Busca Reversa por Descrição (Padrão fAcessoContab)
Campos de descrição no legado usam `fAcessoContab('D', ...)` que faz **SEEK por Descrs primeiro** e SÓ abre janela de busca se não encontrou.

**ERRADO** - SEMPRE abre janela:
```foxpro
PROCEDURE ValidarDGrupo()
    *-- Abre FormBuscaAuxiliar TODA vez que tem valor
    loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ...)  && ❌ SEMPRE abre!
```

**CORRETO** - Busca direto, só abre se não achou:
```foxpro
PROCEDURE ValidarDGrupo()
    *-- 1. Buscar direto por descrição
    loc_nResult = SQLEXEC(gnConnHandle, ;
        "SELECT TOP 1 Codigos, Descrs FROM SigCdGcr WHERE Descrs = " + EscaparSQL(loc_cDGrupo), ;
        "cursor_4c_Val")
    IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Val") > 0
        *-- Achou: preencher campos sem abrir janela ✅
        loc_oPag1.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_Val.Codigos)
    ELSE
        *-- Não achou: aí sim abre janela ✅
        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ...)
    ENDIF
```

### ⚠️ REGRA CRÍTICA: Nomes de Colunas SQL
**NUNCA inventar nomes de colunas.** O banco usa nomes abreviados (ex: `Concs` não `Concils`, `Tipos` não `Tipo`, `Valors` não `Valos`).

**Processo OBRIGATÓRIO:**
1. Copiar a query SQL do código ORIGINAL legado
2. Verificar cada coluna em `docs/schema.sql` (`CREATE TABLE [dbo].[NomeTabela]`)
3. Em JOINs: confirmar de qual tabela (alias) cada coluna vem
4. NUNCA "normalizar" ou "melhorar" nomes de colunas - usar EXATAMENTE como no schema

## CATEGORIAS DE PROCEDURES (Ajuda na Separação)

| Categoria | Implementar em | Exemplos |
|-----------|----------------|----------|
| **Cálculos** | BO | CalcularTotal, CalcularICMS, CalcularComissao |
| **Validações** | BO | ValidarEstoque, ValidarCPF, ValidarLimite |
| **Manipulação UI** | Form | HabilitarCampos, MostrarOcultarGrid, AtualizarLabels |
| **Eventos** | Form | BtnSalvarClick, OnKeyPress, OnChange |
| **SQL/Banco** | BO | Inserir, Atualizar, Excluir, CarregarDados |
| **Grids** | Form | AdicionarItem, RemoverItem, AtualizarTotalizadores |
| **Impressão** | Form | ImprimirRelatorio, GerarPDF |

## ENTREGA ESPERADA
- TODOS os {{TotalProcedures}} procedures implementados
- Separação correta (Form vs BO)
- Lógica idêntica ao original
- Código compilável sem erros
- Comentários em lógica complexa

## VALIDAÇÃO
- ✅ Código compila sem erros
- ✅ Comportamento idêntico ao original
- ✅ Teste comparativo (novo vs antigo): mesmos resultados
- ✅ Cálculos corretos (validar com dados reais)
- ✅ Validações funcionam conforme original
