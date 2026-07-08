# FormProduto - Lições Aprendidas (2026-01-16)

**Data da Migração**: 2026-01-16
**Task**: task5 (SIGCDPRO → FormProduto)
**Complexidade**: EXTREMA (573 objetos, 50+ campos, 15+ grids)
**Estratégia**: 3 fases (MVP → 70% → 100%)
**Status**: FASE 2 - 12 erros corrigidos (9 FASE 1 + 3 FASE 2), pgframeDados implementado com posições exatas

---

## ⚠️ PROBLEMAS CRÍTICOS ENCONTRADOS (FASE 1 MVP)

### 1. ERRO: Property ADICIONARBOTOESCRUD is not found
**Linha**: 137
**Procedimento**: ConfigurarPage1

**Causa**:
- Assumi incorretamente que existiam helper methods no FormBase:
  - `AdicionarBotoesCRUD(container)`
  - `AdicionarBotaoSair(container)`
  - `AdicionarBotoesSalvarCancelar(container)`
- Esses métodos NÃO existem no FormBase

**Solução**:
- Criar botões MANUALMENTE usando `AddObject()` com propriedades individuais
- Seguir padrão do FormCor.prg

**Código Correto**:
```foxpro
*-- Botão Incluir
loc_oContainer.AddObject("cmd_4c_Incluir", "CommandButton")
WITH loc_oContainer.cmd_4c_Incluir
    .Caption = "Incluir"
    .Width = 75
    .Height = 75
    .Left = 5
    .Top = 5
    .Picture = gc_4c_CaminhoIcones + "btn_incluir.jpg"
    .PicturePosition = 13
    .BackColor = RGB(255, 255, 255)
    .ForeColor = RGB(90, 90, 90)
    .Themes = .F.
    .SpecialEffect = 0
    .Visible = .T.
ENDWITH
BINDEVENT(loc_oContainer.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
```

**LIÇÃO**: NUNCA assumir que helper methods existem. Sempre verificar FormBase.prg ou usar FormCor.prg como template.

---

### 2. ERRO: Property BtnIncluirClick is not found
**Linha**: 156
**Procedimento**: ConfigurarPage1

**Causa**:
- Criei BINDEVENT para 9 métodos de click handlers, mas NÃO implementei os métodos
- BINDEVENT referencia método que não existe → erro em tempo de execução

**Métodos que estavam faltando**:
1. `BtnIncluirClick()`
2. `BtnConsultarClick()`
3. `BtnAlterarClick()`
4. `BtnExcluirClick()`
5. `BtnProcurarClick()`
6. `BtnSairClick()`
7. `BtnConfirmarClick()`
8. `BtnCancelarClick()`
9. `GridDblClick()`

**Solução**:
- Implementar TODOS os métodos referenciados por BINDEVENT
- Copiar padrão do FormCor.prg (linhas 741-892)

**Código Correto** (exemplo BtnIncluirClick):
```foxpro
PROCEDURE BtnIncluirClick()
    THIS.this_cModoAtual = "INCLUIR"
    THIS.this_lNovoRegistro = .T.
    THIS.this_oBusinessObject.NovoRegistro()
    THIS.BOParaForm()
    THIS.HabilitarCampos(.T., .T.)
    THIS.AjustarBotoesPorModo()
    THIS.pgf_4c_Principal.ActivePage = 2
    THIS.pgf_4c_Principal.Page2.txt_4c_Codigo.SetFocus()
ENDPROC
```

**LIÇÃO**: Ao usar BINDEVENT, SEMPRE implementar o método de destino ANTES de testar o formulário.

---

### 3. ERRO: Alias 'CURSOR_4C_LISTA' is not found
**Linha**: 293
**Procedimento**: ConfigurarColunasGrid

**Causa**:
- `ConfigurarColunasGrid()` chamado na linha 276 durante construção da interface (ConstruirInterface)
- Nesse momento, o cursor `cursor_4c_Lista` ainda NÃO existe
- Cursor só é criado em `CarregarLista()`, que é chamado DEPOIS (em InicializarForm)

**Fluxo ERRADO**:
```
Init()
  → ConstruirInterface()
      → ConfigurarPage1()
          → ConfigurarColunasGrid()  ← ERRO: cursor não existe ainda!
  → InicializarForm()
      → CarregarLista()  ← Cursor criado AQUI
```

**Solução**:
1. **Remover** chamada prematura de `ConfigurarColunasGrid()` da linha 276
2. **Adicionar verificação** no método para só executar se cursor existir:

```foxpro
PROTECTED PROCEDURE ConfigurarColunasGrid()
    LOCAL loc_oGrid

    *-- Só executar se o cursor existir
    IF !USED("cursor_4c_Lista")
        RETURN
    ENDIF

    loc_oGrid = THIS.pgf_4c_Principal.Page1.grd_4c_Dados
    *-- Resto do código...
ENDWITH
ENDPROC
```

3. Método é chamado APENAS em `CarregarLista()` (linha 720), DEPOIS do cursor ser criado

**LIÇÃO**: Métodos que manipulam cursors SÓ devem ser chamados DEPOIS que o cursor existe. SEMPRE adicionar verificação `IF !USED(...)`.

---

### 4. ERRO: Variable 'LOC_CICONPATH' is not found
**Linha**: 378
**Procedimento**: ConfigurarPage2

**Causa**:
- Variável `loc_cIconPath` usada na linha 378, mas NÃO declarada em `LOCAL`
- Declaração estava presente em `ConfigurarPage1()`, mas NÃO em `ConfigurarPage2()`

**Solução**:
```foxpro
PROTECTED PROCEDURE ConfigurarPage2()
    LOCAL loc_oPage2, loc_nTopAtual, loc_nColuna1, loc_nColuna2, loc_cIconPath
    loc_oPage2 = THIS.pgf_4c_Principal.Page2
    loc_cIconPath = gc_4c_CaminhoIcones  ← ADICIONAR ESTA LINHA

    *-- Resto do código...
ENDPROC
```

**LIÇÃO**: SEMPRE declarar variáveis locais em LOCAL, mesmo que outra procedure no mesmo arquivo já tenha declarado a mesma variável. Variáveis LOCAL têm escopo de procedure, NÃO de arquivo.

---

### 5. ERRO: Métodos Auxiliares Faltando (CarregarPorId, AjustarBotoesPorModo, HabilitarCampos, ObterCodigoSelecionado)

**Causa**:
- Button click handlers chamam métodos auxiliares que NÃO foram implementados:
  - `CarregarPorId()` - NO ProdutoBO.prg
  - `AjustarBotoesPorModo()` - NO FormProduto.prg
  - `HabilitarCampos()` - NO FormProduto.prg
  - `ObterCodigoSelecionado()` - NO FormProduto.prg

**Solução**:

**A. Adicionar em ProdutoBO.prg**:
```foxpro
PROCEDURE CarregarPorId(par_cCodigo)
    LOCAL loc_cSQL, loc_nResultado

    loc_cSQL = ""
    loc_cSQL = loc_cSQL + "SELECT "
    loc_cSQL = loc_cSQL + "  cpros, dpros, cbars, cgrus, ifors, reffs, "
    loc_cSQL = loc_cSQL + "  custofs, pvens, fvendas, obspes, obspeds, "
    loc_cSQL = loc_cSQL + "  situas, dtincs, moecusfs, moevs "
    loc_cSQL = loc_cSQL + "FROM SigCdPro "
    loc_cSQL = loc_cSQL + "WHERE cpros = " + EscaparSQL(par_cCodigo)

    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

    IF loc_nResultado < 0 OR RECCOUNT("cursor_4c_Dados") = 0
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        RETURN .F.
    ENDIF

    THIS.CarregarDoCursor("cursor_4c_Dados")
    USE IN cursor_4c_Dados
    RETURN .T.
ENDPROC
```

**B. Adicionar em FormProduto.prg**:
```foxpro
PROTECTED PROCEDURE AjustarBotoesPorModo()
    LOCAL loc_oPagina, loc_lVisualizar
    loc_oPagina = THIS.pgf_4c_Principal.Page2
    loc_lVisualizar = (THIS.this_cModoAtual == "VISUALIZAR")

    *-- Confirmar: sempre visível, desabilitado no modo VISUALIZAR
    loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Visible = .T.
    loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = !loc_lVisualizar

    *-- Cancelar: sempre visível e habilitado
    loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Visible = .T.
    loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
ENDPROC

PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar, par_lHabilitarCodigo)
    LOCAL loc_oPagina
    loc_oPagina = THIS.pgf_4c_Principal.Page2

    *-- Código só é editável em modo INCLUIR
    loc_oPagina.txt_4c_Codigo.Enabled = par_lHabilitarCodigo

    *-- Demais campos (FASE 1 - 15 campos)
    loc_oPagina.txt_4c_Descricao.Enabled = par_lHabilitar
    loc_oPagina.txt_4c_CodigoBarras.Enabled = par_lHabilitar
    loc_oPagina.txt_4c_Grupo.Enabled = par_lHabilitar
    loc_oPagina.txt_4c_DescGrupo.Enabled = .F.  && Lookup result
    loc_oPagina.txt_4c_Fornecedor.Enabled = par_lHabilitar
    loc_oPagina.txt_4c_DescFornecedor.Enabled = .F.  && Lookup result
    loc_oPagina.txt_4c_RefFornecedor.Enabled = par_lHabilitar
    loc_oPagina.txt_4c_CustoFornecedor.Enabled = par_lHabilitar
    loc_oPagina.txt_4c_PrecoVenda.Enabled = par_lHabilitar
    loc_oPagina.txt_4c_FatorVenda.Enabled = par_lHabilitar
    loc_oPagina.txt_4c_ObsPessoal.Enabled = par_lHabilitar
    loc_oPagina.txt_4c_ObsPedidos.Enabled = par_lHabilitar
    loc_oPagina.txt_4c_DataInclusao.Enabled = .F.  && Gerado automaticamente
ENDPROC

PROTECTED PROCEDURE ObterCodigoSelecionado()
    IF USED("cursor_4c_Lista") AND RECCOUNT("cursor_4c_Lista") > 0
        SELECT cursor_4c_Lista
        RETURN ALLTRIM(cursor_4c_Lista.cpros)
    ENDIF
    RETURN ""
ENDPROC
```

**LIÇÃO**: Ao implementar button click handlers, SEMPRE verificar se todos os métodos auxiliares chamados estão implementados (tanto no Form quanto no BO).

---

### 6. ERRO: Formulário abre e fecha silenciosamente (sem erro)

**Causa**:
Dois problemas combinados:
1. **CarregarLista() nunca chamado** - Grid ficava vazio na inicialização
2. **Controles invisíveis** - AddObject() cria controles com `.Visible = .F.` por padrão

**Sintoma**: Formulário aparece por 1 segundo e fecha, sem mensagem de erro

**Solução A - CarregarLista() no Init()**:
```foxpro
PROCEDURE Init()
    DODEFAULT()
    THIS.this_oBusinessObject = CREATEOBJECT("ProdutoBO")
    THIS.ConstruirInterface()

    *-- CRÍTICO: Carregar lista inicial
    IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
        IF !THIS.CarregarLista()
            *-- Se falhar, não impede abertura
        ENDIF
    ENDIF

    *-- Ativar Page1 (Lista)
    THIS.pgf_4c_Principal.ActivePage = 1
    THIS.this_cModoAtual = "LISTA"

    RETURN .T.
ENDPROC
```

**Solução B - TornarControlesVisiveis()**:
```foxpro
PROTECTED PROCEDURE ConstruirInterface()
    THIS.AdicionarPageFrame()
    THIS.ConfigurarPage1()
    THIS.ConfigurarPage2()

    *-- CRÍTICO: Tornar controles visíveis
    THIS.TornarControlesVisiveis(THIS.pgf_4c_Principal.Page1)
    THIS.TornarControlesVisiveis(THIS.pgf_4c_Principal.Page2)
ENDPROC

PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
    LOCAL loc_nI, loc_oObjeto

    FOR loc_nI = 1 TO par_oContainer.ControlCount
        loc_oObjeto = par_oContainer.Controls(loc_nI)

        IF VARTYPE(loc_oObjeto) = "O"
            IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                loc_oObjeto.Visible = .T.
            ENDIF

            *-- Trata PageFrame - itera Pages
            IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                LOCAL loc_nP
                FOR loc_nP = 1 TO loc_oObjeto.PageCount
                    THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                ENDFOR
            ENDIF

            *-- Trata containers
            IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                THIS.TornarControlesVisiveis(loc_oObjeto)
            ENDIF
        ENDIF
    ENDFOR
ENDPROC
```

**LIÇÃO**:
- SEMPRE chamar `CarregarLista()` no `Init()` após construir interface
- SEMPRE chamar `TornarControlesVisiveis()` após criar controles com AddObject()
- Formulário que abre e fecha = `Init()` retornou `.F.` OU controles invisíveis

---

### 7. ERRO: Variable 'GB_4C_VALIDANDOUI' is not found
**Linha**: 713
**Procedimento**: CarregarLista

**Causa**:
- Referência direta à variável global `gb_4c_ValidandoUI` sem verificar se existe
- Variável só existe durante execução do ValidarUIFidelity.prg

**Código ERRADO**:
```foxpro
IF gb_4c_ValidandoUI
    RETURN .T.
ENDIF
```

**Código CORRETO**:
```foxpro
IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
    RETURN .T.
ENDIF
```

**LIÇÃO**: SEMPRE verificar se variável global existe antes de usar: `TYPE("nome_var") = "L"` ou `TYPE("nome_var") = "C"`.

---

### 8. ERRO: Property THIS_CMODOATUAL is not found
**Linha**: 52
**Procedimento**: Init

**Causa**:
- Propriedades `this_cModoAtual` e `this_cCodigoAtual` usadas mas NÃO declaradas
- Estão no FormCor.prg, mas não no FormBase (não são herdadas)

**Solução**:
```foxpro
DEFINE CLASS FormProduto AS FormBase
    *-- Propriedades herdadas sobrescritas
    this_cTitulo = "Cadastro de Produtos"
    this_cTabela = "SigCdPro"
    this_cChavePrimaria = "cpros"

    *-- Controle de modo do formulário (OBRIGATÓRIO)
    this_cModoAtual = "LISTA"         && LISTA, INCLUIR, ALTERAR, VISUALIZAR
    this_cCodigoAtual = ""            && Código do registro atual

    *-- Resto do código...
ENDDEFINE
```

**LIÇÃO**:
- Verificar FormCor.prg para ver TODAS as propriedades necessárias (linhas 50-60)
- Propriedades de controle de modo NÃO estão no FormBase, devem ser declaradas
- Propriedades obrigatórias: `this_cModoAtual`, `this_cCodigoAtual`

---

### 9. ERRO: Formulário abre e fecha imediatamente (mesmo sem erro)
**Linha**: N/A
**Sintoma**: Formulário aparece por 1 segundo e fecha, mesmo sem mensagem de erro

**Causa**:
- Faltavam **propriedades visuais críticas** que definem o formulário como modal
- FormCor tem 15+ propriedades visuais que FormProduto NÃO tinha
- Sem `WindowType = 1` e `ShowWindow = 1`, o formulário não fica modal corretamente

**Propriedades que estavam faltando**:
```foxpro
DataSession = 2
ShowWindow = 1      && CRÍTICO para modal
WindowType = 1      && CRÍTICO para modal
AutoCenter = .T.
ControlBox = .F.
Closable = .F.
MaxButton = .F.
MinButton = .F.
TitleBar = 0
ClipControls = .F.
Themes = .F.
BorderStyle = 2
```

**Solução**:
```foxpro
DEFINE CLASS FormProduto AS FormBase
    *-- Propriedades visuais do formulário (CRÍTICAS)
    DataSession = 2
    Height = 600
    Width = 1000
    Caption = "Cadastro de Produtos"
    ShowWindow = 1      && CRÍTICO
    WindowType = 1      && CRÍTICO
    AutoCenter = .T.

    *-- Sem barra de título (padrão frmcadastro legado)
    ControlBox = .F.
    Closable = .F.
    MaxButton = .F.
    MinButton = .F.
    TitleBar = 0
    ClipControls = .F.
    Themes = .F.
    BorderStyle = 2

    *-- Resto do código...
ENDDEFINE
```

**LIÇÃO**:
- SEMPRE copiar TODAS as propriedades visuais do FormCor (linhas 34-51)
- Não declarar propriedades visuais em ConstruirInterface() - declarar na classe
- `WindowType = 1` + `ShowWindow = 1` são CRÍTICOS para formulários modais funcionarem
- Testar com script debug (TesteFormProdutoDebug.prg) ajuda a identificar problemas

---

## 📋 CHECKLIST DE VERIFICAÇÃO PRÉ-TESTE (Evitar Erros)

Antes de testar qualquer formulário novo, verificar:

```
[ ] 1. Propriedades Visuais (CRÍTICO)
    [ ] Copiar TODAS as propriedades visuais do FormCor (linhas 34-51)
    [ ] WindowType = 1 (modal)
    [ ] ShowWindow = 1 (compatibilidade modal)
    [ ] DataSession = 2
    [ ] ControlBox = .F., TitleBar = 0, BorderStyle = 2
    [ ] NÃO declarar Width/Height em ConstruirInterface()

[ ] 2. Helper Methods
    [ ] NUNCA assumir que métodos como AdicionarBotoesCRUD() existem
    [ ] Verificar FormBase.prg OU usar FormCor.prg como template
    [ ] Criar botões MANUALMENTE com AddObject()

[ ] 3. Button Click Handlers
    [ ] Implementar TODOS os métodos referenciados por BINDEVENT
    [ ] BtnIncluirClick, BtnConsultarClick, BtnAlterarClick, BtnExcluirClick
    [ ] BtnProcurarClick, BtnSairClick
    [ ] BtnConfirmarClick, BtnCancelarClick
    [ ] GridDblClick

[ ] 4. Métodos Auxiliares no Form
    [ ] AjustarBotoesPorModo()
    [ ] HabilitarCampos(par_lHabilitar, par_lHabilitarCodigo)
    [ ] ObterCodigoSelecionado()
    [ ] TornarControlesVisiveis(par_oContainer)

[ ] 5. Métodos no Business Object
    [ ] CarregarPorId(par_cCodigo) - buscar por PK
    [ ] Buscar(pcFiltro) - listagem com filtro (herdado do BusinessBase)
    [ ] Salvar() - herdado do BusinessBase
    [ ] Excluir() - herdado do BusinessBase
    [ ] NovoRegistro() - herdado do BusinessBase

[ ] 6. Cursors e Ordem de Execução
    [ ] Métodos que usam cursors SÓ chamados DEPOIS do cursor existir
    [ ] Adicionar verificação IF !USED("cursor_xxx") em métodos críticos
    [ ] NÃO chamar ConfigurarColunasGrid() antes de CarregarLista()

[ ] 7. Variáveis Locais
    [ ] SEMPRE declarar variáveis em LOCAL, mesmo que outra procedure declare
    [ ] Escopo de LOCAL é procedure, NÃO arquivo
    [ ] loc_cIconPath = gc_4c_CaminhoIcones (declarar em CADA procedure)

[ ] 8. Propriedades de Controle de Modo
    [ ] this_cModoAtual = "LISTA"
    [ ] this_cCodigoAtual = ""
    [ ] Copiar de FormCor.prg (linhas 54-55)

[ ] 9. Init() e CarregarLista()
    [ ] Chamar CarregarLista() no Init() após ConstruirInterface()
    [ ] Chamar TornarControlesVisiveis() após criar controles
    [ ] Definir ActivePage = 1 e this_cModoAtual = "LISTA"

[ ] 10. Variáveis Globais
    [ ] SEMPRE usar TYPE("var") antes de acessar variável global
    [ ] Exemplo: IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI

[ ] 11. Delete .fxp Files
    [ ] del /s /q C:\4c\projeto\app\*.fxp
    [ ] SEMPRE antes de testar após alterações

[ ] 12. Grep para Métodos Faltando
    [ ] grep "THIS\." no arquivo para encontrar chamadas de métodos
    [ ] Verificar se TODOS os métodos estão implementados
```

---

## 🎯 PADRÃO CORRETO DE IMPLEMENTAÇÃO (Template)

### Estrutura Mínima de um FormCRUD (MVP):

```foxpro
DEFINE CLASS Form[Entidade] AS FormBase
    this_cTitulo = "Cadastro de [Entidade]"
    this_cTabela = "SigCd[Tabela]"
    this_cChavePrimaria = "[campo_pk]"

    *-- Controle de modo (OBRIGATÓRIO)
    this_cModoAtual = "LISTA"
    this_cCodigoAtual = ""

    PROCEDURE Init()
        DODEFAULT()

        THIS.this_oBusinessObject = CREATEOBJECT("[Entidade]BO")
        THIS.ConstruirInterface()

        *-- CRÍTICO: Carregar lista inicial
        IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
            IF !THIS.CarregarLista()
                *-- Se falhar, não impede abertura
            ENDIF
        ENDIF

        *-- Ativar Page1 (Lista)
        THIS.pgf_4c_Principal.ActivePage = 1
        THIS.this_cModoAtual = "LISTA"

        RETURN .T.
    ENDPROC

    *-- CONSTRUÇÃO DA INTERFACE (AddObject, BINDEVENT)
    PROTECTED PROCEDURE ConstruirInterface()
        THIS.AdicionarPageFrame()
        THIS.ConfigurarPage1()  && Lista (Grid + Botões CRUD)
        THIS.ConfigurarPage2()  && Dados (Campos + Botões Confirmar/Cancelar)

        *-- CRÍTICO: Tornar controles visíveis (AddObject cria com Visible = .F.)
        THIS.TornarControlesVisiveis(THIS.pgf_4c_Principal.Page1)
        THIS.TornarControlesVisiveis(THIS.pgf_4c_Principal.Page2)
    ENDPROC

    *-- PAGEFRAME
    PROTECTED PROCEDURE AdicionarPageFrame()
        *-- Criar PageFrame...
    ENDPROC

    *-- PAGE 1: LISTA
    PROTECTED PROCEDURE ConfigurarPage1()
        *-- 1. Criar container botões CRUD
        *-- 2. Criar 5 botões MANUALMENTE (Incluir, Consultar, Alterar, Excluir, Procurar)
        *-- 3. Criar botão Sair MANUALMENTE
        *-- 4. Criar Grid
        *-- 5. BINDEVENT para TODOS os botões
        *-- 6. BINDEVENT para Grid.DblClick
        *-- NÃO chamar ConfigurarColunasGrid() aqui!
    ENDPROC

    *-- CONFIGURAR COLUNAS DO GRID
    PROTECTED PROCEDURE ConfigurarColunasGrid()
        *-- SEMPRE verificar se cursor existe
        IF !USED("cursor_4c_Lista")
            RETURN
        ENDIF
        *-- Configurar Width, Header.Caption, ControlSource, ReadOnly
    ENDPROC

    *-- PAGE 2: DADOS
    PROTECTED PROCEDURE ConfigurarPage2()
        LOCAL loc_cIconPath  ← DECLARAR SEMPRE
        loc_cIconPath = gc_4c_CaminhoIcones

        *-- 1. Criar container botões Confirmar/Cancelar
        *-- 2. Criar 2 botões MANUALMENTE (Confirmar, Cancelar)
        *-- 3. BINDEVENT para Confirmar/Cancelar
        *-- 4. Criar campos (labels + textboxes)
        *-- 5. BINDEVENT para lookups (F4/DblClick)
    ENDPROC

    *-- BUTTON CLICK HANDLERS (9 métodos obrigatórios)
    PROCEDURE BtnIncluirClick()
        *-- Ver código acima
    ENDPROC

    PROCEDURE BtnConsultarClick()
        *-- Ver código acima
    ENDPROC

    PROCEDURE BtnAlterarClick()
        *-- Ver código acima
    ENDPROC

    PROCEDURE BtnExcluirClick()
        *-- Ver código acima
    ENDPROC

    PROCEDURE BtnProcurarClick()
        *-- Ver código acima
    ENDPROC

    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    PROCEDURE GridDblClick()
        THIS.BtnConsultarClick()
    ENDPROC

    PROCEDURE BtnConfirmarClick()
        *-- Ver código acima
    ENDPROC

    PROCEDURE BtnCancelarClick()
        *-- Ver código acima
    ENDPROC

    *-- MÉTODOS AUXILIARES (3 obrigatórios)
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        *-- Ver código acima
    ENDPROC

    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar, par_lHabilitarCodigo)
        *-- Ver código acima
    ENDPROC

    PROTECTED PROCEDURE ObterCodigoSelecionado()
        *-- Ver código acima
    ENDPROC

    *-- OVERRIDES DO FORMBASE
    PROTECTED PROCEDURE CarregarLista()
        *-- SQL para carregar cursor_4c_Lista
        *-- RecordSource = "cursor_4c_Lista"
        *-- ConfigurarColunasGrid() ← CHAMAR AQUI
    ENDPROC

    PROTECTED PROCEDURE BOParaForm()
        *-- Carregar dados do BO para os campos
    ENDPROC

    PROTECTED PROCEDURE FormParaBO()
        *-- Carregar dados dos campos para o BO
    ENDPROC

    PROTECTED PROCEDURE ValidarDados()
        *-- Validações de campos obrigatórios
    ENDPROC

    *-- TORNAR CONTROLES VISÍVEIS (OBRIGATÓRIO)
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                *-- Trata PageFrame - itera Pages
                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    LOCAL loc_nP
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                *-- Trata containers
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

ENDDEFINE
```

### Business Object Mínimo:

```foxpro
DEFINE CLASS [Entidade]BO AS BusinessBase
    *-- Propriedades (campos da tabela)
    this_c[Campo1] = ""
    this_n[Campo2] = 0
    *-- etc.

    PROTECTED PROCEDURE Inserir()
        *-- SQL INSERT
    ENDPROC

    PROTECTED PROCEDURE Atualizar()
        *-- SQL UPDATE
    ENDPROC

    PROCEDURE CarregarPorId(par_cCodigo)  ← OBRIGATÓRIO!
        *-- SQL SELECT WHERE pk = par_cCodigo
        *-- CarregarDoCursor()
        *-- RETURN .T./.F.
    ENDPROC

    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        *-- Carregar propriedades do cursor
    ENDPROC

    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_c[CampoPK]
    ENDPROC

ENDDEFINE
```

---

---

## ⚠️ NOVOS PROBLEMAS ENCONTRADOS (FASE 2 - pgframeDados)

### 10. ERRO: Property BORDERWIDTH is read-only
**Linha**: 452
**Procedimento**: ConfigurarPage2

**Causa**:
- Tentei setar `.BorderWidth = 0` em um PageFrame criado via `AddObject()`
- `BorderWidth` é uma propriedade **read-only** em PageFrames quando criados programaticamente
- Só pode ser definida em PageFrames criados no Form Designer

**Solução**:
- Remover linha `.BorderWidth = 0`
- PageFrame vai usar valor padrão do VFP9

**Código Correto**:
```foxpro
WITH loc_oPgframeDados
    .Left = -1
    .Top = -54
    .Width = 1003
    .Height = 656
    *-- .BorderWidth = 0  ← REMOVER - read-only!
    .Visible = .T.
ENDWITH
```

**LIÇÃO**: Propriedades que funcionam no Form Designer podem ser read-only quando criadas via código. Sempre testar ou consultar documentação VFP9.

---

### 11. ERRO: Property BACKCOLOR is read-only (PageFrame)
**Linha**: 452
**Procedimento**: ConfigurarPage2

**Causa**:
- Tentei setar `.BackColor = RGB(236, 233, 216)` em um PageFrame criado via `AddObject()`
- `BackColor` é **read-only** em PageFrames quando criados programaticamente
- BackColor pode ser setado nas **Pages individuais**, mas não no PageFrame pai

**Solução**:
- Remover `.BackColor` do PageFrame
- Setar `.BackColor` nas Pages individuais (Page1, Page2, etc.)

**Código Correto**:
```foxpro
*-- PageFrame: NÃO setar BackColor
WITH loc_oPgframeDados
    .Left = -1
    .Top = -54
    *-- .BackColor = RGB(236, 233, 216)  ← REMOVER - read-only!
    .Visible = .T.
ENDWITH

*-- Page: SIM setar BackColor
WITH loc_oPgframeDados.Page1
    .Caption = "Dados Principais"
    .BackColor = RGB(236, 233, 216)  ← OK aqui!
ENDWITH
```

**LIÇÃO**: PageFrame.BackColor é read-only via código. Setar BackColor nas Pages individuais.

---

### 12. ERRO: Property ERASEPAGE is not found
**Linha**: 455
**Procedimento**: ConfigurarPage2

**Causa**:
- Tentei setar `.ErasePage = .T.` em um PageFrame criado via `AddObject()`
- `ErasePage` NÃO existe como propriedade de PageFrame
- Provavelmente confundi com outra propriedade ou é específica de versões antigas

**Solução**:
- Remover linha `.ErasePage = .T.` completamente
- Propriedade não é necessária para funcionamento do PageFrame

**Código Correto**:
```foxpro
WITH loc_oPgframeDados
    .Left = -1
    .Top = -54
    .Width = 1003
    .Height = 656
    .PageCount = 1
    .Tabs = .T.
    .TabStyle = 0
    .TabStretch = 0
    *-- .ErasePage = .T.  ← REMOVER - não existe!
    .Visible = .T.
ENDWITH
```

**LIÇÃO**: Nem todas as propriedades do arquivo .txt extraído são válidas via código. Sempre testar propriedades não-comuns.

---

## 📊 ESTATÍSTICAS DOS ERROS

| Erro | Tipo | Gravidade | Tempo Perdido | Prevenível? |
|------|------|-----------|---------------|-------------|
| 1. AdicionarBotoesCRUD | Método inexistente | ALTA | ~5min | ✅ Sim (verificar FormBase) |
| 2. BtnIncluirClick | Método não implementado | ALTA | ~10min | ✅ Sim (implementar antes de BINDEVENT) |
| 3. cursor_4c_Lista | Cursor inexistente | MÉDIA | ~5min | ✅ Sim (adicionar IF !USED) |
| 4. loc_cIconPath | Variável não declarada | BAIXA | ~2min | ✅ Sim (LOCAL em cada procedure) |
| 5. Métodos auxiliares | Métodos não implementados | ALTA | ~15min | ✅ Sim (copiar de FormCor) |
| 6. Form abre/fecha | CarregarLista + Visible | ALTA | ~10min | ✅ Sim (seguir padrão FormCor Init) |
| 7. gb_4c_ValidandoUI | Variável global inexistente | BAIXA | ~2min | ✅ Sim (TYPE antes de usar) |
| 8. this_cModoAtual | Propriedade não declarada | MÉDIA | ~3min | ✅ Sim (copiar de FormCor) |
| 9. WindowType/ShowWindow | Propriedades visuais faltando | CRÍTICA | ~20min | ✅ Sim (copiar TODAS de FormCor) |
| 10. BorderWidth | Propriedade read-only | BAIXA | ~2min | ✅ Sim (testar ou consultar docs) |
| 11. BackColor (PageFrame) | Propriedade read-only | BAIXA | ~2min | ✅ Sim (setar nas Pages, não no PageFrame) |
| 12. ErasePage | Propriedade inexistente | BAIXA | ~2min | ✅ Sim (testar propriedades não-comuns) |

**Total tempo perdido**: ~78 minutos (1h18min)
**Total de erros**: 12 (9 FASE 1 + 3 FASE 2)
**Prevenível**: 100% (todos os erros poderiam ser evitados com checklist)
**Erro mais grave**: #9 (WindowType/ShowWindow) - formulário não funcionava

---

## 🚀 PRÓXIMOS PASSOS (Após Corrigir Erros Básicos)

1. ✅ Testar abertura do form (sem erros)
2. ⏳ Testar modo INCLUIR (inserir produto)
3. ⏳ Testar lookups (Grupo, Fornecedor)
4. ⏳ Testar modo ALTERAR (editar produto)
5. ⏳ Testar modo VISUALIZAR (consultar produto)
6. ⏳ Testar modo EXCLUIR (deletar produto)
7. ⏳ Testar busca (BtnProcurarClick)
8. ⏳ Validar UI Fidelity (ValidarUIFidelity.prg)
9. ⏳ Implementar FASE 2 (pgframeDados com 5 sub-pages, +25 campos, +13 lookups)
10. ⏳ Implementar FASE 3 (+12 sub-pages, +14 grids, 100% funcionalidade)

---

## 📚 REFERÊNCIAS

- **FormCor.prg**: Template completo de FormCRUD (linhas 741-953)
- **FormBase.prg**: Classe base (verificar métodos disponíveis)
- **FORMCOR_LICOES_APRENDIDAS.md**: 5 problemas críticos do FormCor
- **CLAUDE.md**: Guia geral do projeto (3 pilares, nomenclatura)

---

**Data da última atualização**: 2026-01-16
**Status**: Erros básicos corrigidos, aguardando teste inicial
