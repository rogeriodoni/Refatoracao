# MIGRAÇÃO VFP9 - FASE 5: Grids de Detalhe

## CONTEXTO
- **Projeto**: Migração VFP9 - Sistema 4C
- **Task**: {{TaskId}}
- **Formulário Original**: {{BaseName}}
- **Fase**: 5 - Implementar Grids de Detalhe
- **Total de Grids**: {{NumGrids}}

## ARQUIVOS DE REFERÊNCIA
- **CLAUDE.md**: `C:\4c\CLAUDE.md` (regras do projeto)
- **Grid Guide**: `C:\4c\docs\grid_implementation.md`
- **Código Original**: `{{TaskPath}}\{{BaseName}}_codigo_fonte.txt`
- **Form Atual**: `C:\4c\projeto\app\forms\cadastros\Form{{BaseName}}.prg`
- **GridBase**: `C:\4c\projeto\app\classes\GridBase.prg`

## TAREFA
Implementar TODOS os {{NumGrids}} grids de sub-tabelas identificados.

## GRIDS A IMPLEMENTAR
{{ListaGrids}}

### Exemplo de Implementação

```foxpro
PROTECTED PROCEDURE ConfigurarGridItens()
    LOCAL loc_oGrid, loc_oPagina
    loc_oPagina = THIS.pgf_4c_Principal.Page2

    *-- Criar grid
    loc_oPagina.AddObject("grd_4c_Itens", "Grid")

    WITH loc_oPagina.grd_4c_Itens
        .Top = XXX        && COPIAR do original
        .Left = XXX
        .Width = XXX
        .Height = XXX
        .ReadOnly = .F.
        .DeleteMark = .F.
        .RecordMark = .F.
        .ScrollBars = 3
        .GridLines = 3
        .ColumnCount = 7  && Número de colunas
        .FontName = "Tahoma"
        .FontSize = 8
        .Visible = .T.
    ENDWITH

    *-- Configurar colunas
    *-- Coluna 1: Produto
    WITH loc_oPagina.grd_4c_Itens.Column1
        .Width = 200
        .Header1.Caption = "Produto"
        .ControlSource = "cursor_4c_Itens.CodigoProduto"

        *-- Lookup dentro do grid (usar TextBoxGridLookup)
        IF PEMSTATUS(., "Text1", 5)
            .RemoveObject("Text1")
        ENDIF
        .AddObject("txt_4c_Produto", "TextBoxGridLookup")
        .txt_4c_Produto.TabelaLookup = "SigCdPro"
        .txt_4c_Produto.CampoCodigo = "cpros"
        .txt_4c_Produto.CampoDescricao = "dpros"
        .CurrentControl = "txt_4c_Produto"
        .Sparse = .F.
    ENDWITH

    *-- Coluna 2: Quantidade
    WITH loc_oPagina.grd_4c_Itens.Column2
        .Width = 80
        .Header1.Caption = "Quantidade"
        .ControlSource = "cursor_4c_Itens.Quantidade"
        .InputMask = "999,999.99"
    ENDWITH

    *-- ... (Repetir para todas as colunas)

ENDPROC

PROTECTED PROCEDURE CriarCursorItens()
    *-- Criar cursor para grid
    IF USED("cursor_4c_Itens")
        USE IN cursor_4c_Itens
    ENDIF

    CREATE CURSOR cursor_4c_Itens (;
        CodigoProduto C(20),;
        Quantidade N(14,2),;
        Preco N(14,2),;
        Total N(14,2);
    )

    *-- Definir RecordSource APÓS criar cursor
    THIS.pgf_4c_Principal.Page2.grd_4c_Itens.RecordSource = "cursor_4c_Itens"
ENDPROC

PROTECTED PROCEDURE AdicionarItem()
    *-- Adicionar registro no cursor
    SELECT cursor_4c_Itens
    APPEND BLANK
    THIS.pgf_4c_Principal.Page2.grd_4c_Itens.Refresh()
ENDPROC

PROTECTED PROCEDURE RemoverItem()
    *-- Remover registro do cursor
    SELECT cursor_4c_Itens
    IF !EOF()
        DELETE
        PACK
        THIS.pgf_4c_Principal.Page2.grd_4c_Itens.Refresh()
    ENDIF
ENDPROC

PROTECTED PROCEDURE AtualizarTotalizadores()
    LOCAL loc_nTotal

    *-- Calcular total
    SELECT cursor_4c_Itens
    SUM Total TO loc_nTotal

    *-- Atualizar campo de total
    THIS.pgf_4c_Principal.Page2.txt_4c_TotalGeral.Value = loc_nTotal
ENDPROC
```

## REGRAS OBRIGATÓRIAS
1. ✅ Usar `Grid` padrão VFP (ou GridBase se disponível)
2. ✅ Criar cursor ANTES de definir RecordSource
3. ✅ Configurar TODAS as colunas (Width, Header.Caption, ControlSource)
4. ✅ Lookups internos usando `TextBoxGridLookup` (ver grid_implementation.md)
5. ✅ Remover Text1 padrão ANTES de adicionar controle customizado
6. ✅ `.CurrentControl` e `.Sparse = .F.` para controles customizados
7. ✅ Implementar AdicionarItem(), RemoverItem(), EditarItem()
8. ✅ Implementar totalizadores (se aplicável)
9. ❌ **NUNCA** usar propriedades que não existem: AllowAddNew, AllowDelete, AllowEdit
10. ✅ **ColumnOrder**: Se o grid usa `.ColumnOrder` para reordenar colunas visualmente, RESTAURAR ColumnOrder APÓS cada `.RecordSource =` (RecordSource reseta ColumnOrder!)

### ⚠️ RecordSource Reseta ControlSource e ColumnOrder (CRÍTICO!)

Quando `.RecordSource` é (re)atribuído, VFP faz **auto-bind** dos campos do cursor para as colunas pela ORDEM dos campos no cursor (campo 1 → Column1, campo 2 → Column2, etc.), **ignorando** qualquer ControlSource/ColumnOrder definido anteriormente.

**REGRA 1**: NUNCA usar ColumnOrder. Definir colunas na **ordem visual direta** (Column1 = primeira coluna visual).

**REGRA 2**: Re-definir `.ControlSource` de TODAS as colunas APÓS cada `.RecordSource =`.

```foxpro
*-- ❌ ERRADO - ControlSource definido ANTES de RecordSource (será sobrescrito):
loc_oGrd.Column1.ControlSource = "cursor.Emps"    && Será ignorado!
loc_oGrd.Column2.ControlSource = "cursor.Datas"   && Será ignorado!
loc_oGrd.RecordSource = "cursor"                    && Auto-bind: Column1→campo1, Column2→campo2

*-- ✅ CORRETO - ControlSource APÓS RecordSource:
loc_oGrd.RecordSource = "cursor"

*-- Re-definir TODOS os ControlSource (OBRIGATÓRIO)
loc_oGrd.Column1.ControlSource = "cursor.Emps"
loc_oGrd.Column2.ControlSource = "cursor.Datas"
loc_oGrd.Column3.ControlSource = "cursor.Hists"

*-- Restaurar larguras
loc_oGrd.Column1.Width = 30
loc_oGrd.Column2.Width = 71
```

## ENTREGA ESPERADA
- TODOS os {{NumGrids}} grids configurados
- Cursores criados para cada grid
- Colunas configuradas com larguras corretas
- Lookups internos funcionais (TextBoxGridLookup)
- Métodos AdicionarItem/RemoverItem/EditarItem implementados
- Totalizadores automáticos (se aplicável)
- Sem erros de sintaxe VFP

## VALIDAÇÃO
- ✅ Grid exibe dados do cursor
- ✅ Lookups internos funcionam (F4 dentro do grid)
- ✅ AdicionarItem() adiciona linha no grid
- ✅ RemoverItem() remove linha do grid
- ✅ Totalizadores atualizam automaticamente
- ✅ Larguras de colunas idênticas ao original
