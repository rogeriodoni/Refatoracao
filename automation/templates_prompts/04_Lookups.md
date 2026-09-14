# MIGRAÇÃO VFP9 - FASE 4: Lookups

## CONTEXTO
- **Projeto**: Migração VFP9 - Sistema 4C
- **Task**: {{TaskId}}
- **Formulário Original**: {{BaseName}}
- **Fase**: 4 - Implementar Lookups
- **Total de Lookups**: {{NumLookups}}

## ARQUIVOS DE REFERÊNCIA
- **CLAUDE.md**: `C:\4c\CLAUDE.md` (regras do projeto)
- **Lookup Guide**: `C:\4c\docs\lookup_implementation.md`
- **Código Original**: `{{TaskPath}}\{{BaseName}}_codigo_fonte.txt`
- **Form Atual**: `C:\4c\projeto\app\forms\cadastros\Form{{BaseName}}.prg`
- **Inventário**: `{{TaskPath}}\inventario.json`

## TAREFA
Implementar TODOS os {{NumLookups}} lookups identificados no formulário.

## LOOKUPS A IMPLEMENTAR
{{ListaLookups}}

### Exemplo de Implementação

```foxpro
*-- Método de lookup
PROTECTED PROCEDURE LookupCodigoCliente()
    LOCAL loc_oFormBusca, loc_cCodigoSelecionado, loc_cNomeSelecionado

    *-- Criar FormBuscaAuxiliar
    loc_oFormBusca = CREATEOBJECT("FormBuscaAuxiliar")

    *-- Configurar busca
    WITH loc_oFormBusca
        .this_cTabelaOrigem = "SigCdCli"
        .this_cCampoCodigo = "Iclis"
        .this_cCampoDescricao = "Rclis"
        .this_cTitulo = "Buscar Cliente"
        .this_cCursorDestino = "cursor_4c_Cliente"
    ENDWITH

    *-- Exibir busca
    loc_oFormBusca.Show()

    *-- Verificar se selecionou
    IF loc_oFormBusca.this_lSelecionou
        *-- Obter dados do cursor
        SELECT cursor_4c_Cliente
        loc_cCodigoSelecionado = cursor_4c_Cliente.Iclis
        loc_cNomeSelecionado = cursor_4c_Cliente.Rclis

        *-- Preencher campos
        THIS.pgf_4c_Principal.Page2.txt_4c_CodigoCliente.Value = ALLTRIM(loc_cCodigoSelecionado)
        THIS.pgf_4c_Principal.Page2.txt_4c_NomeCliente.Value = ALLTRIM(loc_cNomeSelecionado)

        *-- Setar foco
        THIS.pgf_4c_Principal.Page2.txt_4c_CodigoCliente.SetFocus()
    ENDIF

    *-- Liberar form
    loc_oFormBusca.Release()
ENDPROC

*-- BINDEVENT para F4
PROCEDURE ConfigurarLookups()
    *-- Cliente (F4)
    BINDEVENT(THIS.pgf_4c_Principal.Page2.txt_4c_CodigoCliente, "KeyPress", THIS, "OnKeyPressCodigoCliente")

    *-- (Repetir para todos os lookups...)
ENDPROC

PROCEDURE OnKeyPressCodigoCliente(nKeyCode, nShiftAltCtrl)
    IF nKeyCode = 286  && F4
        THIS.LookupCodigoCliente()
    ENDIF
ENDPROC
```

## REGRAS OBRIGATÓRIAS
1. ✅ Usar `FormBuscaAuxiliar` (padrão do projeto)
2. ✅ Configurar:
   - `this_cTabelaOrigem` (tabela de lookup)
   - `this_cCampoCodigo` (campo código)
   - `this_cCampoDescricao` (campo descrição)
   - `this_cCursorDestino` (nome do cursor)
3. ✅ Usar `this_lSelecionou` para verificar se selecionou (NÃO `ObterCodigoSelecionado()`)
4. ✅ Ler dados do cursor de destino
5. ✅ BINDEVENT para capturar F4/F5
6. ✅ Métodos de lookup devem ser PUBLIC (NÃO PROTECTED)
7. ✅ Preencher campo principal + campos dependentes
8. ✅ Validar código digitado manualmente (quando sai do campo)
9. ⚠️ **LostFocus ≠ Valid**: Handlers via BINDEVENT LostFocus DEVEM ter guardia de valor alterado (propriedade `this_cUltimo*Validado` + comparação antes de processar). SEM GUARDIA = janela de busca abre TODA vez que o usuário navega no form!
10. ⚠️ **Busca reversa por descrição**: PRIMEIRO fazer SELECT direto no banco. SÓ abrir FormBuscaAuxiliar se NÃO encontrou o registro. O legado (fAcessoContab) faz SEEK primeiro e só abre fwBuscaInt se não achou.
11. ⚠️ **DynamicForeColor/DynamicBackColor**: SEMPRE proteger com `PEMSTATUS(obj, "DynamicForeColor", 5)` antes de atribuir

## ENTREGA ESPERADA
- Métodos `Lookup[Campo]()` para TODOS os lookups
- Métodos `OnKeyPress[Campo]()` para TODOS os lookups
- Método `ConfigurarLookups()` com TODOS os BINDEVENT
- Validação de código manual para TODOS os campos
- Sem erros de sintaxe VFP

## VALIDAÇÃO
- ✅ F4 abre FormBuscaAuxiliar
- ✅ Seleção preenche campo principal + dependentes
- ✅ ESC cancela sem preencher
- ✅ Código inválido digitado manualmente exibe erro
- ✅ TODOS os {{NumLookups}} lookups funcionam
