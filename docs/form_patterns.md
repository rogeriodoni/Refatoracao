# Form Patterns and Best Practices

## ⚠️ REGRA CRÍTICA: Compensação do PageFrame.Top = -29 (LER PRIMEIRO!)

**AVISO:** Esta é a regra mais importante para evitar botões cortados!

### O Problema

O PageFrame usa `.Top = -29` para esconder as abas. Isso empurra TODO o conteúdo das Pages para CIMA em 29 pixels, causando **corte de botões** no topo da tela.

### A Solução (OBRIGATÓRIA)

**COMPENSAR +29 pixels** em todos os containers principais dentro das Pages:

```foxpro
* ERRADO (Framework original - causa corte):
cnt_4c_Cabecalho.Top = 2        ❌ Botões cortados!
cnt_4c_Botoes.Top = 0           ❌ Botões cortados!

* CORRETO (Compensado para novo sistema):
cnt_4c_Cabecalho.Top = 31       ✅ (2 + 29)
cnt_4c_Botoes.Top = 29          ✅ (0 + 29)
cnt_4c_BotoesAcao.Top = 38      ✅ (9 + 29)
```

### Tabela de Conversão Rápida

| Container | Framework | Compensação | Novo Sistema |
|-----------|-----------|-------------|--------------|
| Page1: Cabeçalho | Top = 2 | +29 | **Top = 31** |
| Page1: Botões CRUD | Top = 0 | +29 | **Top = 29** |
| Page2: Botões Ação | Top = 9 | +29 | **Top = 38** |
| Grid | Top = 121 | +0 | Top = 121 (já alto) |

### Checklist OBRIGATÓRIO

```
[ ] PageFrame.Top = -29 configurado
[ ] cnt_4c_Cabecalho.Top = 31 (não 2)
[ ] cnt_4c_Botoes.Top = 29 (não 0)
[ ] cnt_4c_BotoesAcao.Top = 38 (não 9)
[ ] Botões individuais .Top = 5 (dentro dos containers)
[ ] Teste visual: botões completos (não cortados)
```

**Se os botões estão cortados → Você esqueceu de compensar +29!**

---

## Form Visual Standards (frmcadastro)

Todos os formularios de cadastro herdam do `frmcadastro` do framework. As propriedades abaixo DEVEM ser aplicadas:

### Propriedades do Form

```foxpro
* Form principal - SEM barra de titulo, SEM botoes de janela
ControlBox = .F.       && Sem menu de controle
Closable = .F.         && Sem botao fechar
MaxButton = .F.        && Sem botao maximizar
MinButton = .F.        && Sem botao minimizar (opcional, pode nao estar definido)
TitleBar = 0           && Sem barra de titulo
ClipControls = .F.     && Otimizacao de repintura
Themes = .F.           && Sem temas do Windows (aparencia classica)
BorderStyle = 2        && Borda fixa
```

### Imagem de Fundo das Paginas

```foxpro
* Ambas as paginas (Lista e Dados) devem ter imagem de fundo
Page1.Picture = "fundo_cad_1003.jpg"  && ou fundo_cadastro.jpg
Page2.Picture = "fundo_cad_1003.jpg"
Page1.BackColor = RGB(53, 53, 53)     && Cinza escuro
Page2.BackColor = RGB(53, 53, 53)
```

## Botões de Ação

### Main Tab Buttons (Aba Principal) - CRUD Operations

```foxpro
* Botoes SEM ESPACAMENTO entre eles
* Tamanho: 75 x 75 (NAO 80)
* Posicoes: Left = 5, 80, 155, 230, 305 (diferenca de 75)
* Themes = .F. para aparencia classica (sem bordas arredondadas)

WITH cmd_4c_Incluir
    .Height = 75
    .Width = 75
    .Left = 5           && Primeiro botao
    .Top = 5
    .Themes = .F.       && IMPORTANTE: Remove borda arredondada
    .SpecialEffect = 0  && Aparencia plana
    .BackColor = RGB(255, 255, 255)
    .ForeColor = RGB(90, 90, 90)
    .PicturePosition = 13
ENDWITH
```

Standard icons for cadastro forms (located in `gc_4c_CaminhoIcones`):

| Button | Icon File | Description |
|--------|-----------|-------------|
| Incluir (Insert) | `cadastro_inserir_26.jpg` | Add new record |
| Visualizar (View) | `cadastro_vizualizar_60.jpg` | View record details |
| Alterar (Edit) | `cadastro_alterar_60.jpg` | Edit existing record |
| Excluir (Delete) | `cadastro_excluir_60.jpg` | Delete record |
| Procurar (Search) | `cadastro_procurar_60.jpg` | Search records |
| Sair (Exit) | `cadastro_sair_60.jpg` | Close form |

### Data Tab Buttons (Aba Dados) - Save/Cancel Operations

```foxpro
* REGRA PARA MODO VISUALIZAR:
* - NAO criar botao OK separado
* - Manter Confirmar e Cancelar VISIVEIS
* - Confirmar fica DESABILITADO (Enabled = .F.)
* - Cancelar fica HABILITADO (para voltar a lista)

PROTECTED PROCEDURE AjustarBotoesPorModo()
    LOCAL loc_lVisualizar
    loc_lVisualizar = (THIS.this_cModoAtual == "VISUALIZAR")

    * Confirmar: visivel mas desabilitado no modo visualizar
    loc_oPagina.cmd_4c_Confirmar.Visible = .T.
    loc_oPagina.cmd_4c_Confirmar.Enabled = !loc_lVisualizar

    * Cancelar: sempre visivel e habilitado
    loc_oPagina.cmd_4c_Cancelar.Visible = .T.
    loc_oPagina.cmd_4c_Cancelar.Enabled = .T.
ENDPROC
```

Standard icons:

| Button | Icon File | Description |
|--------|-----------|-------------|
| Salvar (Save) | `cadastro_salvar_60.jpg` | Save changes |
| Cancelar (Cancel) | `cadastro_cancelar_60.jpg` | Cancel and discard changes |

### Botoes de Acao em Grids (Inserir/Excluir linha)

```foxpro
* REGRA: Usar When ao inves de Enabled
* Motivo: Enabled = .F. escurece o icone, When mantem aparencia
* O When retorna .F. para desabilitar a acao sem alterar visual

PROCEDURE BtnInserirLinha_When()
    * Retorna .F. no modo VISUALIZAR para desabilitar
    RETURN (THIS.this_cModoAtual != "VISUALIZAR")
ENDPROC

* Ao criar o botao, NAO alterar Enabled:
WITH cmd_4c_InserirLinha
    .Enabled = .T.  && Sempre habilitado visualmente
    * A logica de When desabilita a acao
ENDWITH
```

## Form Modes (INCLUIR/ALTERAR/VISUALIZAR)

### Button Visibility by Mode

| Mode | Confirmar | Cancelar | OK | Description |
|------|-----------|----------|----| ------------|
| INCLUIR | Visible | Visible | Hidden | Insert new record |
| ALTERAR | Visible | Visible | Hidden | Edit existing record |
| VISUALIZAR | Hidden | Hidden | Visible | View only - just close |

### Implementation Pattern

```foxpro
*-- 1. Create OK button (initially hidden) in ConfigurarPaginaDados:
loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_OK", "CommandButton")
WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_OK
    .Caption = "OK"
    .Visible = .F.  && Hidden by default
    .Picture = loc_cIconPath + "cadastro_vizualizar_60.jpg"
    * ... other properties
ENDWITH
BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_OK, "Click", THIS, "BtnOKClick")

*-- 2. Add AjustarBotoesPorModo method:
PROTECTED PROCEDURE AjustarBotoesPorModo()
    LOCAL loc_oPagina, loc_lVisualizar
    loc_oPagina = THIS.pgf_4c_Principal.Page2
    loc_lVisualizar = (THIS.this_cModoAtual == "VISUALIZAR")

    * No modo VISUALIZAR: mostra apenas OK
    * Nos demais modos: mostra Confirmar e Cancelar
    loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Confirmar.Visible = !loc_lVisualizar
    loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar.Visible = !loc_lVisualizar
    loc_oPagina.cnt_4c_BotoesDados.cmd_4c_OK.Visible = loc_lVisualizar
ENDPROC

*-- 3. Add BtnOKClick method - MUST call IrParaLista or CarregarLista:
PROCEDURE BtnOKClick()
    THIS.IrParaLista()  && IMPORTANTE: Deve recarregar a lista
ENDPROC

*-- 4. Call AjustarBotoesPorModo in each mode change:
PROCEDURE BtnVisualizarClick()
    THIS.this_cModoAtual = "VISUALIZAR"  && Define modo ANTES de IrParaDados
    * ... load data ...
    THIS.IrParaDados()
    THIS.AjustarBotoesPorModo()
ENDPROC
```

### Page Navigation Methods

**CRITICAL**: These methods handle page switching. Follow these rules strictly:

```foxpro
*-- IrParaDados - NUNCA deve definir this_cModoAtual
*-- O modo eh definido em BtnIncluirClick, BtnVisualizarClick ou BtnAlterarClick
PROCEDURE IrParaDados()
    THIS.pgf_4c_Principal.ActivePage = 2
    * NAO COLOCAR: THIS.this_cModoAtual = "DADOS"  && ERRADO - sobrescreve VISUALIZAR!
ENDPROC

*-- IrParaLista - DEVE chamar CarregarLista para atualizar o grid
PROCEDURE IrParaLista()
    THIS.pgf_4c_Principal.ActivePage = 1
    THIS.this_cModoAtual = "LISTA"
    THIS.CarregarLista()  && IMPORTANTE: Recarrega dados no grid
ENDPROC
```

### Correct Call Order

```
BtnVisualizarClick:
  1. this_cModoAtual = "VISUALIZAR"   <- Define modo primeiro
  2. CarregarPorId() / BOParaForm()   <- Carrega dados
  3. IrParaDados()                     <- Muda pagina (NAO muda modo)
  4. HabilitarCampos(.F.)             <- Desabilita campos
  5. AjustarBotoesPorModo()           <- Ajusta botoes por ultimo

BtnOKClick:
  1. IrParaLista()                    <- Recarrega lista e muda pagina
     ou
  1. CarregarLista()                  <- Recarrega dados
  2. ActivePage = 1                   <- Muda pagina
  3. this_cModoAtual = "LISTA"        <- Reseta modo
```

## PageFrame Patterns

### PageFrame Visibility in Nested Structures

When making controls visible recursively, PageFrames need special handling:

```foxpro
* ERRADO: Apenas percorre Controls
FOR i = 1 TO oContainer.ControlCount
    oContainer.Controls(i).Visible = .T.
ENDFOR

* CORRETO: Tambem percorre Pages de PageFrames
IF PEMSTATUS(oContainer, "PageCount", 5)
    FOR i = 1 TO oContainer.PageCount
        THIS.TornarControlesVisiveis(oContainer.Pages(i))
    ENDFOR
ENDIF
```

### PageFrame Page Names

Cannot rename pages at runtime. Use default names (Page1, Page2) or create a custom PageFrame class.

### OptionGroup - Horizontal Positioning

**CRITICO**: Ao criar OptionGroup via AddObject, usar `.Buttons(N)` (NAO `.Option1`).
Sem definir `.Left` em cada Button, todos ficam sobrepostos no Left=0 e o usuario so ve o primeiro.

```foxpro
loc_oPagina.AddObject("opt_4c_Filtro", "OptionGroup")
WITH loc_oPagina.opt_4c_Filtro
    .ButtonCount = 3
    .BackStyle   = 0
    .BorderStyle = 0
    .Left        = 253
    .Top         = 82
    .Width       = 206
    .Height      = 26
    .Visible     = .T.
ENDWITH
*-- OBRIGATORIO: Definir Left, Top, AutoSize, ForeColor, Themes em CADA Button
WITH loc_oPagina.opt_4c_Filtro.Buttons(1)
    .Caption   = "Global"
    .Left      = 5
    .Top       = 5
    .Width     = 60
    .AutoSize  = .T.
    .FontName  = "Tahoma"
    .FontSize  = 8
    .ForeColor = RGB(90, 90, 90)
    .Themes    = .F.
ENDWITH
WITH loc_oPagina.opt_4c_Filtro.Buttons(2)
    .Caption   = "Positivos"
    .Left      = 63          && Left anterior + Width anterior (~3px gap)
    .Top       = 5
    .Width     = 70
    .AutoSize  = .T.
    .FontName  = "Tahoma"
    .FontSize  = 8
    .ForeColor = RGB(90, 90, 90)
    .Themes    = .F.
ENDWITH
WITH loc_oPagina.opt_4c_Filtro.Buttons(3)
    .Caption   = "Negativos"
    .Left      = 131
    .Top       = 5
    .Width     = 76
    .AutoSize  = .T.
    .FontName  = "Tahoma"
    .FontSize  = 8
    .ForeColor = RGB(90, 90, 90)
    .Themes    = .F.
ENDWITH
```

### OptionGroup/Filtro - InteractiveChange (carga de dados)

**CRITICO**: Se o OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter BINDEVENT para InteractiveChange que recarrega a grade. Sem isso, mudar a opcao nao tem efeito.

```foxpro
*-- Adicionar BINDEVENT apos criar o OptionGroup:
BINDEVENT(par_oPagina.opt_4c_Filtro, "InteractiveChange", THIS, "FiltroSaldoChanged")

*-- Metodo handler:
PROCEDURE FiltroSaldoChanged()
    IF !EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value))
        THIS.CarregarGradeSaldo()
    ENDIF
ENDPROC
```

### Eventos de Carga de Dados (LostFocus + Lookup)

**CRITICO**: Campos de filtro que disparam carga de dados no legado (Valid chama MontaGrade) DEVEM ter a mesma logica no novo sistema.

```foxpro
*-- No LostFocus (ValidarGrupo): apos validar, CARREGAR DADOS
PROCEDURE ValidarGrupo()
    *-- ... validacao SQL ...
    IF loc_lGrupoValido
        THIS.CarregarGradeSaldo()   && OBRIGATORIO: equivalente ao MontaGrade do legado
    ENDIF
ENDPROC

*-- No BtnProcurarClick: apos selecionar, CARREGAR DADOS
PROCEDURE BtnProcurarClick()
    *-- ... lookup FormBuscaAuxiliar ...
    IF !EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value))
        THIS.CarregarGradeSaldo()   && OBRIGATORIO: carregar apos selecao
    ENDIF
ENDPROC
```

## Formularios OPERACIONAL (form generico)

Forms operacionais herdam de `form` generico (NAO de frmcadastro). Exemplos: SIGOPIND (Conta Corrente Individual), telas de consulta e processamento.

### Caracteristicas do Layout OPERACIONAL

| Aspecto | CRUD | OPERACIONAL |
|---------|------|-------------|
| PageFrame | Page1=Lista, Page2=Dados | Multiplas pages com grids e containers |
| Containers | Fixos (sempre visiveis) | **Flutuantes** (Visible toggled por botoes) |
| Botoes | Incluir/Alterar/Excluir padrao | **Customizados** (Imprimir, Consultar, etc.) |
| Dados | 1 tabela principal | Multiplos grids/cursors (Saldos, Historico, etc.) |

### Containers Flutuantes (Padrao OPERACIONAL)

Containers que ficam `Visible=.F.` e sao alternados por botoes:

```foxpro
*-- Criacao (no ConfigurarPagina):
loc_oPagina.AddObject("cnt_4c_Saldo", "Container")
WITH loc_oPagina.cnt_4c_Saldo
    .Top = 300
    .Left = 50
    .Width = 400
    .Height = 200
    .Visible = .F.     && ESCONDIDO por padrao
ENDWITH

*-- Toggle via botao:
PROCEDURE BtnImprimirSaldoClick()
    WITH THIS.pgf_4c_Paginas.Page2.cnt_4c_Saldo
        .Visible = !.Visible
    ENDWITH
ENDPROC
```

**ATENCAO**: `TornarControlesVisiveis()` generico torna TUDO visivel, incluindo containers flutuantes. Filtrar por nome para evitar ativacao indevida.

### CREATE CURSOR - Ordem Consistente (CRITICO!)

Se o mesmo cursor eh criado em multiplos locais, a ordem dos campos DEVE ser identica:

```foxpro
*-- ❌ ERRADO - Ordens diferentes:
*-- Init: CREATE CURSOR cursor_4c_Dados (Contas C(20), Rclis C(60), Moedas C(10))
*-- Carregar: CREATE CURSOR cursor_4c_Dados (Moedas C(10), Contas C(20), Rclis C(60))

*-- ✅ CORRETO - Mesma ordem em TODOS os locais:
CREATE CURSOR cursor_4c_Dados (Contas C(20), Rclis C(60), Moedas C(10))
```

---

## CommandGroup (Grupos de Botoes)

```foxpro
par_oAba.AddObject("cmg_4c_Composicao", "CommandGroup")
WITH par_oAba.cmg_4c_Composicao
    .ButtonCount = 5
    .BackStyle = 0
    .BorderStyle = 0
    .Top = 145
    .Left = 947
    .Width = 50
    .Height = 210
    .Themes = .F.

    *-- Botao 1
    .Command1.Top = 5
    .Command1.Left = 5
    .Command1.Height = 40
    .Command1.Width = 40
    .Command1.Caption = "+"
    .Command1.Visible = .T.
    * ... demais botoes

    .Visible = .T.
ENDWITH
```

## InputMask - Validating User Input

**ALWAYS** implement InputMask from original forms to validate user input directly in the field.

### Common InputMask Patterns

| Pattern | Meaning | Example |
|---------|---------|---------|
| `9` | Numeric digit only (0-9) | `999.99` for decimals |
| `!` | Uppercase letter conversion | `!!!!!!!!!!` for codes |
| `X` | Any character | `XXXX` for free text |
| `A` | Alpha only (A-Z, a-z) | `AAAA` for names |
| `.` | Decimal separator | `9999.99` |
| `,` | Thousands separator | `999,999.99` |
| `S,N, ` | Restrict to S, N or space | `S,N, ` for yes/no |
| `99999999999999` | Numeric code (14 digits) | Barcode fields |
| `9999999999999` | Numeric code (13 digits) | EAN13 fields |

### S/N Field Validation Pattern

For fields that accept only S (Sim) or N (Não), implement validation via BINDEVENT LostFocus:

```foxpro
*-- 1. Create generic validation method in the form
PROTECTED PROCEDURE ValidarCampoSN(par_oTextBox, par_cNomeCampo)
    LOCAL loc_cValor

    IF VARTYPE(par_oTextBox) != "O"
        RETURN
    ENDIF

    loc_cValor = UPPER(ALLTRIM(par_oTextBox.Value))

    IF EMPTY(loc_cValor)
        par_oTextBox.Value = ""
        RETURN
    ENDIF

    IF !INLIST(loc_cValor, "S", "N")
        MsgAviso("O campo '" + par_cNomeCampo + "' deve ser 'S' (Sim) ou 'N' (N" + CHR(227) + "o)")
        par_oTextBox.Value = ""
        par_oTextBox.SetFocus()
        RETURN
    ENDIF

    par_oTextBox.Value = loc_cValor
ENDPROC

*-- 2. Create specific validation procedure for each S/N field
PROCEDURE ValidarCampoXxx()
    LOCAL loc_oPagina
    loc_oPagina = THIS.pgf_4c_Principal.Page2
    THIS.ValidarCampoSN(loc_oPagina.txt_4c_CampoXxx, "Nome do Campo")
ENDPROC

*-- 3. Add BINDEVENT in ConfigurarPaginaDados (after creating the TextBox)
BINDEVENT(loc_oPagina.txt_4c_CampoXxx, "LostFocus", THIS, "ValidarCampoXxx")
```

**IMPORTANT**: The TextBox should have `InputMask = "S,N, "` (restricts to S, N, or space only) and `MaxLength = 1`.

## AddObject Creates Invisible Controls

Objects created with `AddObject()` have `Visible = .F.` by default. Always set `.Visible = .T.` after creation.

## TextBox Default Value

TextBox.Value defaults to `.F.` (logical false), NOT empty string. Always initialize:

```foxpro
loContainer.AddObject("txt_4c_Campo", "TextBox")
loContainer.txt_4c_Campo.Value = ""  && IMPORTANTE: Inicializar como string
```

## Release() vs .NULL. (CRITICO!)

`.Release()` so existe em objetos **Form**. Objetos Custom (BO, RelatorioBase) NAO tem `.Release()`.

```foxpro
*-- Form: pode usar .Release()
loForm.Release()

*-- BO/Custom: usar .NULL.
THIS.this_oBusinessObject = .NULL.
THIS.this_oRelatorio = .NULL.

*-- ERRADO - "Property RELEASE is not found":
THIS.this_oBusinessObject.Release()  && Custom NAO tem Release!
```

## Formularios REPORT (frmrelatorio)

Forms de relatorio usam layout FLAT (sem PageFrame CRUD) e herdam de RelatorioBase:

### Estrutura Basica

```foxpro
DEFINE CLASS FormSigatcrp AS Form
    this_oRelatorio = .NULL.      && Objeto RelatorioBase (NAO BO)

    PROCEDURE Init()
        THIS.this_oRelatorio = CREATEOBJECT("sigatcrpBO")
        THIS.ConfigurarFormulario()
        THIS.ConfigurarCampos()
        THIS.ConfigurarBotoes()
        RETURN .T.
    ENDPROC

    *-- Transfere filtros do form para o BO
    PROCEDURE FormParaRelatorio()
        WITH THIS.this_oRelatorio
            .this_dDataIni = THIS.txt_4c_DataIni.Value
            .this_dDataFim = THIS.txt_4c_DataFim.Value
        ENDWITH
    ENDPROC

    PROCEDURE BtnVisualizarClick()
        THIS.FormParaRelatorio()
        THIS.this_oRelatorio.Visualizar()
    ENDPROC

    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.   && NAO usar .Release()!
        ENDIF
        DODEFAULT()
    ENDPROC
ENDDEFINE
```

### Validar* e Tecla* em REPORT Forms

- **Validar*** (LostFocus): busca reversa por nome/descricao → FormBuscaAuxiliar. NUNCA vazio.
- **Tecla*** (KeyPress): handlers de data/PV sem lookup. Podem ser vazios (intencionalmente).
