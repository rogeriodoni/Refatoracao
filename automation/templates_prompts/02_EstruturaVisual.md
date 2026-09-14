# MIGRAÇÃO VFP9 - FASE 2: Estrutura Visual

## CONTEXTO
- **Projeto**: Migração VFP9 - Sistema 4C
- **Task**: {{TaskId}}
- **Formulário Original**: {{BaseName}}
- **Fase**: 2 de {{TotalFases}} (Estrutura Visual)

## ARQUIVOS DE REFERÊNCIA
- **CLAUDE.md**: `C:\4c\CLAUDE.md` (regras do projeto)
- **Código Original**: `{{TaskPath}}\{{BaseName}}_codigo_fonte.txt`
- **Inventário**: `{{TaskPath}}\inventario.json`
- **Exemplo**: `C:\4c\projeto\app\forms\cadastros\FormCor.prg`
- **FormBase**: `C:\4c\projeto\app\classes\FormBase.prg`

## TAREFA
Criar arquivo `Form{{BaseName}}.prg` com estrutura visual base (SEM campos ainda).

### Estrutura a Criar

```foxpro
*==============================================================================
* Form{{BaseName}}.prg
* Formulário para {{BaseName}}
* Gerado automaticamente em: {{Timestamp}}
*==============================================================================
DEFINE CLASS Form{{BaseName}} AS FormBase

    *-- Propriedades do formulário
    this_oBusinessObject = .NULL.

    PROCEDURE Init()
        DODEFAULT()

        *-- Criar Business Object
        THIS.this_oBusinessObject = CREATEOBJECT("{{BaseName}}BO")

        *-- Configurar estrutura
        THIS.ConfigurarFormulario()
        THIS.ConfigurarPageFrame()
        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()

        RETURN .T.
    ENDPROC

    PROTECTED PROCEDURE ConfigurarFormulario()
        *-- Copiar propriedades EXATAS do original
        WITH THIS
            .Width = XXX      && COPIAR do original
            .Height = XXX     && COPIAR do original
            .Caption = "..."  && COPIAR do original (com CHR())
            .BackColor = RGB(X,X,X)
            .FontName = "..."
            .FontSize = X
            .ControlBox = .F.
            .TitleBar = 0
            .Themes = .F.
        ENDWITH
    ENDPROC

    PROTECTED PROCEDURE ConfigurarPageFrame()
        *-- Criar PageFrame principal
        THIS.AddObject("pgf_4c_Principal", "PageFrame")

        WITH THIS.pgf_4c_Principal
            .PageCount = 2
            .Top = -29        && Esconde abas
            .Tabs = .F.
            .Width = XXX      && COPIAR do original
            .Height = XXX
            .Visible = .T.
        ENDWITH
    ENDPROC

    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Principal.Page1

        *-- Container de botões CRUD (6 botões padrão)
        *-- Grid de listagem
        *-- (Implementar conforme FormBase)
    ENDPROC

    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Principal.Page2

        *-- Criar containers para grupos de campos
        *-- (campos serão adicionados na próxima fase)
    ENDPROC

ENDDEFINE
```

## REGRAS OBRIGATÓRIAS
1. ✅ Herdar de `FormBase` (app/classes/formbase.prg)
2. ✅ Copiar propriedades visuais EXATAS do original (Width, Height, BackColor, etc.)
3. ✅ PageFrame com `Top = -29` e `Tabs = .F.` (esconde abas)
4. ✅ PageCount ANTES de acessar `.Page1`/`.Page2`
5. ✅ Criar estrutura de containers para receber campos depois
6. ❌ **NÃO adicionar campos ainda** (próxima fase)
7. ❌ **NÃO implementar lookups ainda** (próxima fase)
8. ✅ Seguir padrão de botões CRUD do CLAUDE.md (Width=75, Height=75)

## ENTREGA ESPERADA
- Arquivo `Form{{BaseName}}.prg` completo
- Salvar em: `C:\4c\projeto\app\forms\cadastros\Form{{BaseName}}.prg`
- Estrutura base criada (PageFrame, Pages, Containers)
- Botões CRUD padrão (6 botões: Incluir, Visualizar, Alterar, Excluir, Buscar, Encerrar)
- Grid de listagem criado (vazio ok)
- Sem erros de sintaxe VFP

## VALIDAÇÃO
- ✅ Código compila sem erros
- ✅ Form abre sem erros: `DO Form{{BaseName}}`
- ✅ PageFrame visível com 2 Pages
- ✅ Botões CRUD presentes e visíveis
- ✅ Propriedades visuais EXATAS do original
- ✅ Estrutura pronta para receber campos
