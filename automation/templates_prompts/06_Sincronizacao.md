# MIGRAÇÃO VFP9 - FASE 6: Sincronização Form ↔ BO

## CONTEXTO
- **Projeto**: Migração VFP9 - Sistema 4C
- **Task**: {{TaskId}}
- **Formulário Original**: {{BaseName}}
- **Fase**: 6 - Sincronização (FormParaBO/BOParaForm)
- **Total de Campos**: {{TotalCampos}}

## ARQUIVOS DE REFERÊNCIA
- **CLAUDE.md**: `C:\4c\CLAUDE.md` (regras do projeto - seção FormParaBO/BOParaForm CRÍTICA!)
- **Form Atual**: `C:\4c\projeto\app\forms\cadastros\Form{{BaseName}}.prg`
- **BO**: `C:\4c\projeto\app\classes\{{BaseName}}BO.prg`

## TAREFA
Implementar sincronização COMPLETA entre Form e BO para TODOS os {{TotalCampos}} campos.

### Métodos a Implementar

#### 1. FormParaBO() - Form → Business Object

```foxpro
PROTECTED PROCEDURE FormParaBO()
    *-- Transferir TODOS os campos do form para o BO

    WITH THIS.this_oBusinessObject
        *-- Campos STRING: usar ALLTRIM()
        .this_cCodigo = ALLTRIM(THIS.pgf_4c_Principal.Page2.txt_4c_Codigo.Value)
        .this_cDescricao = ALLTRIM(THIS.pgf_4c_Principal.Page2.txt_4c_Descricao.Value)

        *-- Campos NUMÉRICOS: NÃO usar VAL() se já são numéricos!
        *-- Se TextBox.Value foi inicializado com 0, já é numérico
        .this_nPreco = THIS.pgf_4c_Principal.Page2.txt_4c_Preco.Value  && Direto, SEM VAL()
        .this_nQuantidade = THIS.pgf_4c_Principal.Page2.txt_4c_Quantidade.Value

        *-- Campos STRING que precisam conversão numérica: usar VAL()
        *-- Se TextBox.Value foi inicializado com "", precisa VAL()
        .this_nValor = VAL(THIS.pgf_4c_Principal.Page2.txt_4c_Valor.Value)

        *-- Campos DATA: Direto
        .this_dData = THIS.pgf_4c_Principal.Page2.txt_4c_Data.Value

        *-- Campos LÓGICOS: Direto
        .this_lAtivo = THIS.pgf_4c_Principal.Page2.chk_4c_Ativo.Value

        *-- Repetir para TODOS os {{TotalCampos}} campos...
    ENDWITH
ENDPROC
```

**⚠️ REGRA CRÍTICA sobre VAL()**:
```foxpro
*-- ❌ ERRADO (causa erro "Function argument type mismatch"):
IF TextBox.Value = 0  && Já é numérico
    loc_nValor = VAL(TextBox.Value)  && ERRO! VAL() espera string

*-- ✅ CORRETO - Verificar tipo ANTES:
*-- Se inicializado com .Value = 0 → Usar direto
.this_nPreco = THIS.txt_4c_Preco.Value

*-- Se inicializado com .Value = "" → Usar VAL()
.this_nValor = VAL(THIS.txt_4c_Valor.Value)
```

#### 2. BOParaForm() - Business Object → Form

```foxpro
PROTECTED PROCEDURE BOParaForm()
    *-- Transferir TODOS os campos do BO para o form

    WITH THIS.this_oBusinessObject
        *-- Atribuição direta (sem conversões)
        THIS.pgf_4c_Principal.Page2.txt_4c_Codigo.Value = .this_cCodigo
        THIS.pgf_4c_Principal.Page2.txt_4c_Descricao.Value = .this_cDescricao
        THIS.pgf_4c_Principal.Page2.txt_4c_Preco.Value = .this_nPreco
        THIS.pgf_4c_Principal.Page2.txt_4c_Data.Value = .this_dData
        THIS.pgf_4c_Principal.Page2.chk_4c_Ativo.Value = .this_lAtivo

        *-- Repetir para TODOS os {{TotalCampos}} campos...
    ENDWITH
ENDPROC
```

#### 3. HabilitarCampos() - Controlar ReadOnly por Modo

```foxpro
PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
    LOCAL loc_lReadOnly
    loc_lReadOnly = !par_lHabilitar

    *-- Se modo VISUALIZAR, deixar todos readonly
    IF THIS.this_cModoAtual = "VISUALIZAR"
        loc_lReadOnly = .T.
    ENDIF

    WITH THIS.pgf_4c_Principal.Page2
        *-- TODOS os campos editáveis
        .txt_4c_Codigo.ReadOnly = loc_lReadOnly
        .txt_4c_Descricao.ReadOnly = loc_lReadOnly
        .txt_4c_Preco.ReadOnly = loc_lReadOnly
        .txt_4c_Data.ReadOnly = loc_lReadOnly

        *-- Exceções: campos sempre readonly (calculados, etc.)
        .txt_4c_Total.ReadOnly = .T.  && Sempre readonly (calculado)

        *-- Repetir para TODOS os campos...
    ENDWITH
ENDPROC
```

## REGRAS OBRIGATÓRIAS
1. ✅ FormParaBO(): TODOS os {{TotalCampos}} campos sincronizam
2. ✅ BOParaForm(): TODOS os {{TotalCampos}} campos sincronizam
3. ✅ **CRÍTICO**: VAL() APENAS em strings inicializadas com `""`
4. ✅ **CRÍTICO**: Campos numéricos (inicializados com `0`) → Usar direto, SEM VAL()
5. ✅ ALLTRIM() apenas em strings
6. ✅ HabilitarCampos(): TODOS os campos com ReadOnly correto
7. ✅ Modo VISUALIZAR: TODOS readonly
8. ✅ Modo INCLUIR/ALTERAR: Campos editáveis (exceto calculados)

## MAPEAMENTO FORM ↔ BO
{{TabelaMapeamento}}

## ENTREGA ESPERADA
- Método `FormParaBO()` completo ({{TotalCampos}} campos)
- Método `BOParaForm()` completo ({{TotalCampos}} campos)
- Método `HabilitarCampos()` completo
- Sem erros de tipo (verificar VAL() vs direto)
- Sem erros de sintaxe VFP

## VALIDAÇÃO
- ✅ INCLUIR: Preencher form → Salvar → Verificar banco (TODOS os campos salvos)
- ✅ ALTERAR: Carregar registro → Verificar form (TODOS os campos exibidos)
- ✅ ALTERAR: Modificar campos → Salvar → Verificar banco (TODOS atualizados)
- ✅ VISUALIZAR: TODOS os campos readonly
- ✅ SQL Server: `SELECT * FROM {{NomeTabela}}` mostra TODOS os campos preenchidos
