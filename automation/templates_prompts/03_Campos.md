# MIGRAÇÃO VFP9 - FASE 3: Campos de Entrada (Grupo {{GrupoLetra}})

## CONTEXTO
- **Projeto**: Migração VFP9 - Sistema 4C
- **Task**: {{TaskId}}
- **Formulário Original**: {{BaseName}}
- **Fase**: Campos Grupo {{GrupoLetra}} (campos {{CampoInicio}} a {{CampoFim}})

## ARQUIVOS DE REFERÊNCIA
- **CLAUDE.md**: `C:\4c\CLAUDE.md` (regras do projeto)
- **Código Original**: `{{TaskPath}}\{{BaseName}}_codigo_fonte.txt`
- **Form Atual**: `C:\4c\projeto\app\forms\cadastros\Form{{BaseName}}.prg`
- **Inventário**: `{{TaskPath}}\inventario.json`

## TAREFA
Adicionar campos {{CampoInicio}} a {{CampoFim}} ao método `ConfigurarPaginaDados()` do `Form{{BaseName}}.prg`.

### Exemplo de Implementação

```foxpro
PROTECTED PROCEDURE ConfigurarPaginaDados()
    LOCAL loc_oPagina, loc_oContainer
    loc_oPagina = THIS.pgf_4c_Principal.Page2

    *-- Container para grupo de campos
    loc_oPagina.AddObject("cnt_4c_Grupo{{GrupoLetra}}", "Container")
    WITH loc_oPagina.cnt_4c_Grupo{{GrupoLetra}}
        .Top = XXX        && COPIAR do original + 29 (compensa PageFrame.Top=-29)
        .Left = XXX       && COPIAR do original
        .Width = XXX
        .Height = XXX
        .BackStyle = 0
        .BorderWidth = 0
        .Visible = .T.
    ENDWITH

    *-- Campo 1: [Nome do Campo]
    *-- Label
    loc_oPagina.cnt_4c_Grupo{{GrupoLetra}}.AddObject("lbl_4c_Campo1", "Label")
    WITH loc_oPagina.cnt_4c_Grupo{{GrupoLetra}}.lbl_4c_Campo1
        .Caption = "..."  && COPIAR do original (com CHR())
        .Top = XXX        && COPIAR do original
        .Left = XXX
        .Width = XXX
        .Height = XXX
        .FontName = "..."
        .FontSize = X
        .BackStyle = 0
        .Visible = .T.
    ENDWITH

    *-- TextBox
    loc_oPagina.cnt_4c_Grupo{{GrupoLetra}}.AddObject("txt_4c_Campo1", "TextBox")
    WITH loc_oPagina.cnt_4c_Grupo{{GrupoLetra}}.txt_4c_Campo1
        .Value = ""           && String OU 0 OU {} conforme tipo
        .Top = XXX
        .Left = XXX
        .Width = XXX
        .Height = XXX
        .FontName = "..."
        .FontSize = X
        .InputMask = "..."    && Se aplicável
        .BackColor = RGB(X,X,X)
        .ForeColor = RGB(X,X,X)
        .Visible = .T.
    ENDWITH

    *-- Repetir para TODOS os campos do grupo...

ENDPROC
```

## REGRAS OBRIGATÓRIAS
1. ✅ Adicionar TODOS os campos {{CampoInicio}}-{{CampoFim}} (não omitir nenhum)
2. ✅ Copiar propriedades visuais EXATAS do original (Top, Left, Width, Height, BackColor, ForeColor, FontName, FontSize)
3. ✅ **CRÍTICO**: Compensar Top com +29 pixels (PageFrame.Top=-29)
4. ✅ Inicializar `.Value` corretamente:
   - String: `.Value = ""`
   - Numérico: `.Value = 0`
   - Data: `.Value = {}`
   - Lógico: `.Value = .F.`
5. ✅ Usar prefixo `_4c_` nos nomes (txt_4c_Codigo, lbl_4c_Codigo)
6. ✅ InputMask correto para campos numéricos/data
7. ✅ **CheckBox.Value DEVE ser consistente com tipo inicializado** (ver regra abaixo)
8. ❌ **NÃO implementar lookups** (próxima fase)
9. ❌ **NÃO implementar FormParaBO/BOParaForm** (fase posterior)

### ⚠️ CheckBox.Value - Tipo DEVE ser Consistente (CRÍTICO!)

Se CheckBox é inicializado com `.Value = .F.` (lógico), TODOS os acessos DEVEM usar `.T.`/`.F.`:

```foxpro
*-- Inicialização:
.Value = .F.          && Tipo LÓGICO

*-- ❌ ERRADO - "Operator/operand type mismatch":
loc_lNovoValor = (chk_4c_Campo.Value = 1)   && Comparar lógico com numérico!
chk_4c_Campo.Value = 0                       && Atribuir numérico a lógico!

*-- ✅ CORRETO - Manter tipo lógico:
loc_lNovoValor = (chk_4c_Campo.Value = .T.)  && Lógico com lógico
chk_4c_Campo.Value = .F.                      && Lógico
*-- Carregar de banco (Concs é numérico 0/1):
chk_4c_Campo.Value = (NVL(cursor.Concs, 0) = 1)  && Converte para lógico
```

## CAMPOS DESTE GRUPO
{{ListaCampos}}

## ENTREGA ESPERADA
- Método `ConfigurarPaginaDados()` atualizado
- TODOS os {{TotalCamposGrupo}} campos deste grupo implementados
- Cada campo tem Label + TextBox/ComboBox/CheckBox
- Propriedades visuais EXATAS
- Sem erros de sintaxe VFP

## VALIDAÇÃO
- ✅ Código compila sem erros
- ✅ Form abre e exibe TODOS os campos deste grupo
- ✅ Campos visíveis e posicionados corretamente
- ✅ ValidarUIFidelity: 0 diferenças nos campos deste grupo
