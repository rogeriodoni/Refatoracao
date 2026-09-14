# Migration Patterns - VFP9 Refactoring Project

This file consolidates all migration-specific patterns from the project.

## 1. UI Fidelity Rules

### Problemas Identificados (NAO REPETIR)

| Formulario | Problema | Causa | Como Evitar |
|------------|----------|-------|-------------|
| FormCargo | Botao "comido" | Width/Height incorreto | Copiar EXATO |
| FormDepartamento | Botoes fora padrao modo consulta | AjustarBotoesPorModo() incorreto | Seguir padrao |
| FormPlanoContas | Cores/fonte diferentes | RGB/FontSize nao copiados | Copiar EXATOS |
| FormCor | Falta barra imagem | Picture/Image nao adicionado | Verificar objetos visuais |
| FormProduto | Topo cortado | Height/Top incorreto | Verificar Height e Top |
| FormCor/FormCargo | Botoes cortados topo | PageFrame.Top=-29 nao compensado | COMPENSAR +29 pixels |
| FormTam | Form com barra titulo | ControlBox/TitleBar nao copiadas | COPIAR bloco completo |
| Formsigopind | Form cinza (BackColor errado) | VFP9 default e RGB(240,240,240), nao branco | Declarar BackColor EXPLICITAMENTE em DEFINE CLASS |

### PageFrame.Top = -29 Compensacao (OBRIGATORIO)

Formula: `Top_NovoSistema = Top_Framework + 29`

| Objeto | Framework | Compensacao | Novo Sistema |
|--------|-----------|-------------|--------------|
| cnt_4c_Cabecalho | Top = 2 | +29 | Top = 31 |
| cnt_4c_Botoes (Page1) | Top = 0 | +29 | Top = 29 |
| cnt_4c_BotoesAcao (Page2) | Top = 9 | +29 | Top = 38 |
| grd_4c_Dados | Top = 121 | +0 | Top = 121 |

Checklist:
- PageFrame: Top = -29, Tabs = .F.
- Page1 containers: Top = Framework + 29
- Page2 containers: Top = Framework + 29
- Grid: verificar (geralmente alto, nao precisa)

### Propriedades Visuais OBRIGATORIAS

Form: Width, Height, Top, Left, Caption, BackColor, ForeColor, FontName, FontSize, BorderStyle, ControlBox, MaxButton, MinButton, TitleBar, Themes

Form SEM barra titulo (frmcadastro):

```foxpro
ControlBox = .F.
Closable = .F.
MaxButton = .F.
TitleBar = 0
ClipControls = .F.
Themes = .F.
BorderStyle = 2
```

## 2. Botoes CRUD (Especificacoes Completas)

Container: Top=29, Left=542 (varia), Width=465, Height=85, BackStyle=0, BorderWidth=0

| Ordem | Caption | Left | Icone | Evento |
|-------|---------|------|-------|--------|
| 1 | "Incluir" | 5 | cadastro_inserir_26.jpg | BtnIncluirClick |
| 2 | "Visualizar" | 80 | cadastro_vizualizar_60.jpg | BtnVisualizarClick |
| 3 | "Alterar" | 155 | cadastro_alterar_60.jpg | BtnAlterarClick |
| 4 | "Excluir" | 230 | cadastro_excluir_60.jpg | BtnExcluirClick |
| 5 | "Buscar" | 305 | cadastro_procurar_60.jpg | BtnBuscarClick |
| 6 | "Encerrar" | 380 | cadastro_sair_60.jpg | BtnEncerrarClick |

Botao properties: Width=75, Height=75, Top=5, FontName="Tahoma", FontSize=8, BackColor=RGB(255,255,255), ForeColor=RGB(90,90,90), Themes=.F., SpecialEffect=0, PicturePosition=13

Caption SEM tecla atalho! Container transparente (BackStyle=0)!

## 3. Padroes Obrigatorios dos Metodos Btn*Click

BtnIncluirClick - ORDEM:
1. NovoRegistro()
2. LimparCampos()
3. this_cModoAtual = "INCLUIR" (ANTES de HabilitarCampos!)
4. HabilitarCampos(.T.)
5. AlternarPagina(2)

BtnAlterarClick - ORDEM:
1. CarregarPorCodigo(loc_cCodigo)
2. EditarRegistro() (APOS Carregar!)
3. BOParaForm()
4. this_cModoAtual = "ALTERAR" (ANTES de HabilitarCampos!)
5. HabilitarCampos(.T.)
6. AlternarPagina(2)

CarregarPorCodigo no BO: RESETAR this_lNovoRegistro = .F.

## 4. FormParaBO e BOParaForm - Tipos

| TextBox.Value Inicializado | Tipo | Usar VAL()? |
|---------------------------|------|-------------|
| .Value = "" | String | SIM |
| .Value = 0 | Numerico | NAO - direto |
| .Value = {} | Date | NAO - direto |
| .Value = .F. | Logical | NAO - direto |

## 5. AjustarBotoesPorModo

- VISUALIZAR: Salvar disabled, Cancelar enabled (Caption="Voltar")
- INCLUIR/ALTERAR: ambos enabled (Caption="Cancelar")
- Chamar em: BtnIncluirClick, BtnAlterarClick, BtnConsultarClick, BtnCancelarClick

## 6. Grid - Preservar Larguras

Configurar larguras APOS RecordSource, NAO antes.
Re-definir ControlSource de TODAS as colunas APOS cada RecordSource.

## 7. Tipos de Formulario

| Aspecto | CRUD (frmcadastro) | REPORT (frmrelatorio) | OPERACIONAL (form) |
|---------|-------------------|----------------------|--------------------|
| BO herda de | BusinessBase | RelatorioBase | BusinessBase |
| Layout | PageFrame P1+P2 | FLAT | CUSTOM (grids+containers) |
| Metodo chave | FormParaBO/BOParaForm | FormParaRelatorio | MontaGrade/CarregarDados |
| Acao principal | Inserir/Atualizar/Excluir | PrepararDados+REPORT FORM | Buscar/Imprimir/Consultar |
| Destroy | DODEFAULT() | this_oRelatorio = .NULL. | DODEFAULT() |

REPORT: Validar* DEVE ter logica real (busca reversa). Tecla* para data pode ser vazio.
OPERACIONAL: Containers flutuantes Visible=.F. toggleados por botao. CREATE CURSOR mesma ordem em todos os locais.
OPERACIONAL BackColor: VFP9 default e RGB(240,240,240) - NUNCA omitir BackColor na declaracao de propriedades do DEFINE CLASS. Se o original tem BackColor=RGB(255,255,255), declarar EXPLICITAMENTE ou o form abre cinza.

## 8. Mapeamento Legado -> Novo

| Legado | Novo | Observacao |
|--------|------|------------|
| Grupo_op | cnt_4c_Botoes | Container botoes CRUD |
| Command1-6 | cmd_4c_Incluir/Visualizar/etc | Botoes |
| cmd_Incluir.Click() | BtnIncluirClick() | Via BINDEVENT |
| ThisForm.Salvar() | FormParaBO() + this_oBusinessObject.Salvar() | Separacao camadas |
| ThisForm.Carregar() | this_oBusinessObject.Carregar() + BOParaForm() | Separacao camadas |

## 9. Verificacao Visual Obrigatoria (Checklist)

1. Comparar Width/Height do form (EXATO)
2. Comparar Top/Left de TODOS os controles (EXATO)
3. Verificar BackColor/ForeColor (RGB EXATO)
4. Verificar FontName/FontSize (EXATO)
5. Verificar botoes visiveis (nenhum "comido")
6. Verificar botoes CRUD: Width=75, Height=75, Left sequencial
7. Verificar icones CRUD (cadastro_*.jpg corretos)
8. Verificar espacamento entre botoes
9. Verificar Picture/Image do form
10. Verificar topo NAO cortado
11. Verificar form SEM barra titulo (ControlBox=.F., TitleBar=0)
12. Testar TODOS os modos (INCLUIR, ALTERAR, VISUALIZAR)
13. Comparar visualmente lado-a-lado

ValidarUIFidelity.prg:
- Meta: 0 erros criticos (exceto Dataenvironment), ~33 avisos (FormBase), 0 diferencas
- Resultado aceitavel: 37 problemas (4 Dataenvironment + 33 FormBase)

## 10. Migration Workflow (10 Steps)

1. Pre-Migration Analysis (docs/migration_guide.md)
2. Create BO: this_cTabela + this_cCampoChave (NAO this_cNomeTabela!)
3. Create Form: copiar propriedades visuais EXATAS
4. VALIDAR UI Fidelity (OBRIGATORIO)
5. Register in config.prg (ADIR automatico)
6. Add to menu
7. Delete .fxp files
8. Test all modes
9. Re-validate UI Fidelity
10. Commit

## 11. BINDEVENT "Valid" NAO Funciona em TextBox - Usar KeyPress

**NUNCA** usar `BINDEVENT(obj, "Valid", ...)` em TextBox ou ComboBox. Valid via BINDEVENT nao dispara.

**NUNCA** usar `LostFocus` para chamar MontaGrade/CarregarDados/SQLEXEC. LostFocus dispara SEMPRE que o controle perde foco (inclusive por SetFocus chamado de outro lugar), causando RECURSAO INFINITA:
- LostFocus → MontaGrade → Grid.Refresh/SetFocus → LostFocus → MontaGrade → ...

**Usar `KeyPress` com ENTER(13)/TAB(9) para simular Valid:**

```foxpro
*-- ERRADO (nao dispara):
BINDEVENT(txt, "Valid", THIS, "TxtGrupoValid")

*-- ERRADO (recursao infinita se chamar MontaGrade/SQLEXEC):
BINDEVENT(txt, "LostFocus", THIS, "TxtGrupoLostFocus")
PROCEDURE TxtGrupoLostFocus
    THIS.MontaGrade(...)  && RECURSAO! Refresh/SetFocus dispara LostFocus novamente
ENDPROC

*-- CORRETO (simula Valid - so dispara com acao explicita do usuario):
BINDEVENT(txt, "KeyPress", THIS, "TxtGrupoKeyPress")
PROCEDURE TxtGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
    IF par_nKeyCode = 13 OR par_nKeyCode = 9  && ENTER ou TAB
        THIS.MontaGrade(ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value))
    ENDIF
ENDPROC
```

**LostFocus so pode ser usado para**: SetFocus em outro controle, Refresh de labels, ou logica que NAO altera RecordSource/faz SQLEXEC/chama SetFocus.

## 12. MESSAGEBOX Proibido - Usar messages.prg

**NUNCA** usar `MESSAGEBOX()` direto no codigo migrado. Usar funcoes de `messages.prg`:

| Tipo | Funcao | MESSAGEBOX equivalente |
|------|--------|----------------------|
| Informativo | `MsgInfo(msg)` | `MESSAGEBOX(msg, 64, "")` |
| Aviso | `MsgAviso(msg)` | `MESSAGEBOX(msg, 48, "")` |
| Erro | `MsgErro(msg)` | `MESSAGEBOX(msg, 16, "Erro")` |
| Confirmacao | `MsgConfirma(msg)` | `MESSAGEBOX(msg, 36, "")` retorna .T./.F. |

**Motivo**: Essas funcoes verificam `gb_4c_ModoTeste` e suprimem dialogs modais durante testes automatizados. MESSAGEBOX direto bloqueia o pipeline.

## 13. UNION ALL entre tabelas diferentes - Colunas Explicitas

Quando duas tabelas SQL (ex: SigMvCcr e SigMvCpv) precisam de UNION ALL, **NUNCA** usar `SELECT *`:

```foxpro
*-- ERRADO (estruturas diferentes = "selects are not union compatible"):
SELECT 'R' AS Tipo, a.* FROM SigMvCcr a UNION ALL SELECT 'P' AS Tipo, b.* FROM SigMvCpv b

*-- CORRETO (colunas explicitas identicas):
SELECT 'R' AS Tipo, a.Emps, a.Datas, a.Hists FROM SigMvCcr a ;
UNION ALL ;
SELECT 'P' AS Tipo, b.Emps, b.Datas, b.Hists FROM SigMvCpv b
```

## 14. INTO CURSOR READWRITE (evitar "file is in use")

**NUNCA** usar o padrao `INTO CURSOR X` + `USE DBF("X") IN 0 ALIAS Y`. O cursor read-only nao permite reabrir com outro alias.

```foxpro
*-- ERRADO ("file is in use"):
SELECT * FROM tmp ORDER BY Datas INTO CURSOR tmpSorted
USE DBF("tmpSorted") IN 0 ALIAS cursor_4c_Dados

*-- CORRETO:
SELECT * FROM tmp ORDER BY Datas INTO CURSOR cursor_4c_Dados READWRITE
```

## 15. Cursor Placeholder deve ter mesma estrutura do cursor real

O CREATE CURSOR placeholder (criado no InicializarForm para o grid existir antes de dados) **DEVE ter exatamente os mesmos campos** que o cursor que sera populado por SQLEXEC/SELECT INTO. Campos extras ou faltantes causam erros de ControlSource no grid.

## 16. Processamento 2-Fases / Multi-Fase

SIMPLES (<800KB, <15000 linhas): Phase A (UI) + Phase B (Funcionalidade)
COMPLEXO (>=800KB ou >=15000 linhas): 8 fases sequenciais

## 17. CheckBox em Grid Column - ControlSource (Error 1767)

VFP9 Error 1767 "Parent object will not allow this property setting" ocorre quando se tenta definir ControlSource tanto no CheckBox quanto no Column, ou quando Column1.ControlSource e definido ANTES de AddObject("Check1").

```foxpro
*-- ERRADO (causa Error 1767):
loc_oGrid.Column1.ControlSource = "cursor.nMarcas"   && ANTES de AddObject - PROIBIDO
...
loc_oGrid.Column1.AddObject("Check1", "CheckBox")
loc_oGrid.Column1.CurrentControl = "Check1"
loc_oGrid.Column1.Check1.ControlSource = "cursor.nMarcas"  && Check1.ControlSource - CONFLITA
loc_oGrid.Column1.ControlSource = "cursor.nMarcas"   && Column1 apos CurrentControl - OK mas as 2 acima estragam

*-- CORRETO (unica definicao APOS CurrentControl):
loc_oGrid.Column1.AddObject("Check1", "CheckBox")
loc_oGrid.Column1.CurrentControl = "Check1"
loc_oGrid.Column1.Sparse = .F.
loc_oGrid.Column1.Width = 15
loc_oGrid.Column1.Check1.Caption = ""
loc_oGrid.Column1.ControlSource = "cursor.nMarcas"   && UNICA definicao, DEPOIS de CurrentControl
```

Regra: Para Column com CheckBox, definir ControlSource APENAS no Column (nao no Check1), e APENAS DEPOIS de AddObject + CurrentControl.

## 18. AddObject - Sintaxe Correta (NUNCA passar objeto)

VFP9 `AddObject` recebe dois parametros STRING: `parent.AddObject(cNome, cClasse)`. NUNCA passar um objeto pre-criado com CREATEOBJECT como primeiro parametro — causa "Function argument value, type, or count is invalid".

```foxpro
*-- ERRADO (LLM frequentemente gera este padrao):
loc_oBtn = CREATEOBJECT("CommandButton")
WITH loc_oBtn
    .Caption = "Teste"
    .Top = 10
    .Left = 10
ENDWITH
THIS.AddObject(loc_oBtn, "cmd_4c_Teste")   && ERRO! Objeto como 1o param

*-- CORRETO:
THIS.AddObject("cmd_4c_Teste", "CommandButton")
WITH THIS.cmd_4c_Teste
    .Caption = "Teste"
    .Top = 10
    .Left = 10
ENDWITH
THIS.cmd_4c_Teste.Visible = .T.
```

Para containers e pages:
```foxpro
loc_oP1.AddObject("lbl_4c_Nome", "Label")
WITH loc_oP1.lbl_4c_Nome
    .Caption = "Nome:"
    .Top = 12
ENDWITH
loc_oP1.lbl_4c_Nome.Visible = .T.
```

Regra: AddObject SEMPRE recebe (string_nome, string_classe). Properties via WITH referenciando pelo nome no parent. CREATEOBJECT so para BOs/Custom objects, NUNCA para controles UI.

## 19. Grid Column CurrentControl="Check1" EXIGE AddObject Previo

Quando um Grid usa `.Column1.CurrentControl = "Check1"`, o CheckBox DEVE ser adicionado a Column ANTES. Grids criados via AddObject tem apenas Header1 e Text1 por padrao — Check1 NAO existe ate ser criado explicitamente.

```foxpro
*-- ERRADO (causa "Unknown member CHECK1"):
WITH loc_oP1.grd_4c_Dados
    .Column1.Sparse = .F.
    .Column1.CurrentControl = "Check1"   && FALHA! Check1 nao existe
ENDWITH

*-- CORRETO:
WITH loc_oP1.grd_4c_Dados
    .Column1.AddObject("Check1", "CheckBox")
    .Column1.Check1.Caption = ""
    .Column1.Sparse = .F.
    .Column1.CurrentControl = "Check1"   && OK! Check1 ja foi criado
ENDWITH
```

IMPACTO: Este erro e especialmente perigoso porque ocorre dentro de TRY/CATCH e cascateia silenciosamente — destruindo TODOS os controles criados APOS o grid (OptionGroups, CheckBoxes, BINDEVENTs).

## 20. IF THEN inline NAO Funciona em VFP9

VFP9 NAO suporta a keyword `THEN` em IF. O pattern `IF cond THEN cmd` (tudo numa unica linha) gera:
`Command contains unrecognized phrase/keyword.`

```foxpro
*-- ERRADO:
IF EMPTY(loc_cCodigo) THEN RETURN .F.

*-- CORRETO:
IF EMPTY(loc_cCodigo)
    RETURN .F.
ENDIF
```

Isso e corrigido automaticamente pelo CorretorAutomatico (pattern #45). NUNCA gerar IF com THEN em VFP9.

## 21. COUNT TO var IN alias NAO Funciona em VFP9

VFP9 COUNT nao tem clausula IN. O pattern `COUNT TO var IN alias` gera:
`Command contains unrecognized phrase/keyword.`

```foxpro
*-- ERRADO:
COUNT TO loc_nTotal IN cursor_4c_Dados

*-- CORRETO:
SELECT cursor_4c_Dados
COUNT TO loc_nTotal

*-- Com condicao FOR:
SELECT cursor_4c_Dados
COUNT TO loc_nTotal FOR campo = "X"
```

Isso e corrigido automaticamente pelo CorretorAutomatico (pattern #46). O alias fica selecionado como workarea ativa apos o SELECT — se necessario, restaurar o alias original com SELECT (loc_cAliasAnterior).

## 22. CheckBox .Value - SEMPRE Numerico (NUNCA logico)

CheckBox.Value DEVE ser NUMERICO (0/1). Usar `.T.`/`.F.` (logico) causa "Operator/operand type mismatch" quando comparado com `= 1`/`= 0` no resto do codigo. VFP9 pode mudar o tipo internamente ao marcar/desmarcar, causando inconsistencias.

```foxpro
*-- ERRADO (type mismatch em comparacoes):
.Value = .T.                     && Inicializa como logico
IF chk_4c_Custo.Value            && Truthy test falha se tipo mudou
chk_4c_Custo.Value = .F.         && Pode conflitar com comparacoes = 1

*-- CORRETO (numerico consistente):
.Value = 1                       && Inicializa como numerico
IF chk_4c_Custo.Value = 1        && Comparacao numerica segura
chk_4c_Custo.Value = 0           && Atribuicao numerica consistente
IIF(chk.Value = 1, "sim", "nao") && IIF com comparacao explicita
```

Isso e corrigido automaticamente pelo CorretorAutomatico (pattern #47): troca `.Value = .T.` por `.Value = 1` e `.Value = .F.` por `.Value = 0` em controles `chk_4c_*`.

## 23. Picture do Form - SEMPRE copiar com path adaptado

O form original pode ter `.Picture = "..\framework\imagens\fundo_cadastro.jpg"`. O form migrado DEVE copiar esta propriedade usando o path do novo sistema:

```foxpro
*-- ERRADO (Picture omitido):
*-- (nenhuma atribuicao de Picture)

*-- CORRETO:
THIS.Picture = gc_4c_CaminhoIcones + "fundo_cadastro.jpg"
```

O ValidarUIFidelity compara Picture por JUSTFNAME (apenas nome do arquivo). Se o form original tem Picture e o migrado nao, sera flagged como DIFERENCA.

## 24. Caption com Hotkeys (\<) - PRESERVAR marcadores

Labels VFP usam `\<` para definir teclas de atalho (sublinha a letra seguinte). O form migrado DEVE preservar estes marcadores:

```foxpro
*-- ERRADO (hotkey removido):
.Caption = "Atendente :"

*-- CORRETO (hotkey preservado):
.Caption = "\<Atendente :"
```

O ValidarUIFidelity normaliza `\<` antes de comparar, mas o comportamento de hotkey do form depende de manter o marcador.

## 25. Cursor do Grid CRUD - Usar nome padrao cursor_4c_Dados

O TesteAutomatico verifica se o cursor principal do grid foi criado apos CarregarLista(). O nome padrao e `cursor_4c_Dados`. Forms que usam nomes diferentes (cursor_4c_Lista, cursor_4c_ListaEest) agora sao aceitos pelo teste, mas o padrao RECOMENDADO e `cursor_4c_Dados`:

```foxpro
*-- RECOMENDADO:
SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.RecordSource = "cursor_4c_Dados"
```

## 26. InicializarForm - SEM TRY/CATCH (FormBase ja protege)

O FormBase.Init() envolve a chamada a InicializarForm() em TRY/CATCH automaticamente, exibindo MsgErro com linha e procedure do erro. Por isso, forms migrados NAO devem incluir TRY/CATCH proprio no InicializarForm:

```foxpro
*-- CORRETO: InicializarForm sem TRY/CATCH
PROCEDURE InicializarForm
    THIS.ConfigurarPageFrame()
    THIS.ConfigurarPaginaLista()
    THIS.ConfigurarPaginaDados()
    THIS.TornarControlesVisiveis()
    THIS.InicializarDados()
    THIS.ConfigurarBINDEVENTs()
    RETURN .T.
ENDPROC

*-- ERRADO: TRY/CATCH redundante (FormBase ja faz isso)
PROCEDURE InicializarForm
    TRY
        THIS.ConfigurarPageFrame()
        ...
        loc_lSucesso = .T.
    CATCH TO loc_oErro
        MsgErro(loc_oErro.Message)
    ENDTRY
    RETURN loc_lSucesso
ENDPROC
```

## 27. Page.Visible NAO EXISTE em VFP9

Page (PageFrame.PageN) NAO tem propriedade Visible. Tentar setar `.Page1.Visible = .T.` causa "Property VISIBLE is not found". Pages sao controladas pelo PageFrame (ActivePage). Para tornar o PageFrame visivel, use apenas `pgf_4c_Paginas.Visible = .T.`:

```foxpro
*-- CORRETO:
THIS.pgf_4c_Paginas.Visible = .T.

*-- ERRADO (causa runtime error):
THIS.pgf_4c_Paginas.Page1.Visible = .T.
THIS.pgf_4c_Paginas.Page2.Visible = .T.
```

CorretorAutomatico #49 remove automaticamente linhas `.PageN.Visible`.

## 29. PageFrame.Visible = .T. OBRIGATORIO apos AddObject

Objetos criados via `AddObject` em VFP9 iniciam com `Visible = .F.`. O PageFrame DEVE ser tornado visivel apos configurar tudo, senao o form abre em branco (grid pode aparecer mas cabecalho/botoes ficam invisiveis):

```foxpro
*-- CORRETO: tornar visivel antes de ActivePage
THIS.pgf_4c_Paginas.Visible = .T.
THIS.pgf_4c_Paginas.ActivePage = 1

*-- ERRADO: form abre em branco (PageFrame invisivel)
THIS.pgf_4c_Paginas.ActivePage = 1
*-- Faltou: THIS.pgf_4c_Paginas.Visible = .T.
```

CorretorAutomatico #50 detecta e adiciona automaticamente.

## 30. ColumnCount NAO deve ser redefinido em CarregarLista

Ao recarregar dados do grid via `RecordSource`, NAO redefinir `ColumnCount`. Redefinir `ColumnCount` destroi e recria colunas, causando auto-bind que tenta avaliar campos como variaveis ("Variable 'XXX' is not found"):

```foxpro
*-- CORRETO: so mudar RecordSource e ControlSources
loc_oGrid.RecordSource = "cursor_4c_Dados"
loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cods"

*-- ERRADO: ColumnCount destroi colunas existentes
loc_oGrid.RecordSource = "cursor_4c_Dados"
loc_oGrid.ColumnCount = 3  && DESTROI colunas → auto-bind → "Variable 'cods' is not found"
```

## 28. BINDEVENT Buttons(N) - Verificar ButtonCount

Ao fazer BINDEVENT em CommandGroup/OptionGroup Buttons, verificar que o indice N nao excede o ButtonCount. Acessar `.Buttons(2)` em um grupo com `ButtonCount = 1` causa "BUTTONS is not an object":

```foxpro
*-- Se grp_4c_Sair tem ButtonCount = 1, apenas Buttons(1) existe
BINDEVENT(loc_oCnt.grp_4c_Sair.Buttons(1), "Click", THIS, "BtnSairClick")
*-- ERRADO: Buttons(2) nao existe!
BINDEVENT(loc_oCnt.grp_4c_Sair.Buttons(2), "Click", THIS, "BtnCancelaClick")
```

## 31. FormatarGridLista - Metodo Obrigatorio em Forms CRUD

Forms CRUD que usam CarregarLista() devem implementar `FormatarGridLista(par_oGrid)`. O metodo padrao aplica FontName="Tahoma" e FontSize=8 ao grid. A LLM frequentemente CHAMA este metodo mas NAO o define, causando "Property FORMATARGRIDLISTA is not found" em runtime (compilacao OK, teste sem banco OK).

```foxpro
*-- OBRIGATORIO em todo Form CRUD que tem CarregarLista
PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
    WITH par_oGrid
        IF .ColumnCount > 0
            .FontName = "Tahoma"
            .FontSize = 8
        ENDIF
    ENDWITH
ENDPROC
```

CorretorAuto #51 adiciona automaticamente se chamado mas nao definido.

## 32. Property Declaration + AddObject Conflito

Se a classe declara uma propriedade (ex: `pgf_4c_Paginas = .NULL.`) e depois faz `THIS.AddObject("pgf_4c_Paginas", "PageFrame")`, VFP9 gera "Object name is invalid" porque o nome ja existe como propriedade.

**Regra**: NUNCA declarar propriedade com o mesmo nome de um objeto que sera criado via AddObject. O AddObject cria o membro automaticamente.

CorretorAuto #52 remove a declaracao de propriedade conflitante.

## 33. AddObject Nome Duplicado no Mesmo Container

Dois `AddObject("lbl_4c_Label1", "Label")` no mesmo container/metodo causa "Object name is invalid" no segundo. Cada objeto dentro de um container deve ter nome unico.

**Regra**: Ao criar labels/controles genericos dentro de containers, usar nomes descritivos unicos (lbl_4c_Titulo, lbl_4c_LblMoeda, lbl_4c_LblPeriodo) ao inves de nomes genericos repetidos (lbl_4c_Label1).

CorretorAuto #53 renomeia automaticamente com sufixo numerico.

## 34. PageFrame AddObject + Tabs=.F. -> Page.Height = PageFrame.Height + 4 (OPERACIONAL)

Em forms OPERACIONAL criados via `DEFINE CLASS ... AS FORM` com PageFrame criado por `AddObject`:
- Se `Tabs = .F.`, o VFP9 adiciona **+4** ao `Page.Height` em runtime
- ValidarUIFidelity instancia o form e le os valores em runtime
- Resultado: se `.Height = 635` declarado na PageFrame, o `Page.Height` em runtime = **639**
- A comparacao com o form original (SCX) que tem Page.Height=635 gera "1 diferenca visual"

**Regra**: Para PageFrame OPERACIONAL com `Tabs=.F.` e `AddObject`, declarar:
```foxpro
*-- ERRADO: copia Height do original, mas runtime mostra +4
WITH THIS.pgf_4c_1
    .Height = 635   && runtime mostra 639 (diff!)
    .Tabs   = .F.
ENDWITH

*-- CORRETO: compensar -4 para que runtime = valor original
WITH THIS.pgf_4c_1
    .Height = 631   && runtime mostra 635 (correto!)
    .Tabs   = .F.
ENDWITH
```

**Referencia**: Formsigopind task159 - ValidarUIFidelity reportou SIGOPIND.Page.Height=639 vs esperado=635. Fix: PageFrame.Height = 635 - 4 = 631.

## 35. MsgConfirma() retorna LOGICAL, nao numerico (task158)

`MsgConfirma()` de `messages.prg` retorna `.T.`/`.F.` (faz `RETURN lnResposta = 6` internamente).

```foxpro
*-- ERRADO: "Operator/operand type mismatch" em runtime
loc_nConfirm = MsgConfirma("Confirma?", "Titulo")
IF loc_nConfirm = 6  && ERRO: compara logical com numerico

*-- CORRETO:
IF MsgConfirma("Confirma?", "Titulo")
    && ... executa acao
ENDIF
```

**Regra**: NUNCA comparar retorno de MsgConfirma com 6 ou 7. Usar direto como condicao logica.
CorretorAuto #57 detecta e corrige.

## 36. Botoes CRUD: posicao do lado DIREITO, nao esquerdo (task158)

No Framework legado, os botoes CRUD ficam dentro de `Grupo_op` que tem `Left = 543` (lado direito do form 1000px). A posicao real de cada botao = `Grupo_op.Left + Botao.Left`.

```foxpro
*-- ERRADO: Botoes comecam na esquerda
cmd_4c_Incluir.Left    = 5     && usuario ve botoes na esquerda
cmd_4c_Visualizar.Left = 85

*-- CORRETO: Calcular offset do container original
*-- Grupo_op.Left=543, Inserir.Left=5 -> 543+5=548
cmd_4c_Incluir.Left    = 548   && usuario ve botoes na direita
cmd_4c_Visualizar.Left = 623   && 543+80
cmd_4c_Alterar.Left    = 698   && 543+155
cmd_4c_Excluir.Left    = 773   && 543+230
cmd_4c_Buscar.Left     = 848   && 543+305
cmd_4c_Encerrar.Left   = 923   && Grupo_Saida.Left=918+Sair.Left=5
```

**Regra**: SEMPRE ler o `Left` do container de grupo do original e SOMAR ao Left de cada botao. NUNCA posicionar botoes a partir de Left=0 ou Left=5.

## 37. GridLines = 3 para grids de listagem (task158)

O Framework Grade usa linhas horizontais E verticais. `GridLines = 1` mostra so horizontais.

**Regra**: Grids de listagem (Page1) devem ter `GridLines = 3` (ambas).

## 38. Labels ForeColor: PRETO em fundo claro, BRANCO em fundo escuro (task158)

Labels da classe `say` do Framework usam ForeColor escuro por padrao. Em Page2 (Dados) com imagem de fundo clara:

```foxpro
*-- ERRADO: branco invisivel em fundo claro
.ForeColor = RGB(255, 255, 255)
.BackStyle = 0   && transparente

*-- CORRETO: preto legivel em fundo claro
.ForeColor = RGB(0, 0, 0)
.BackStyle = 0
```

**Regra**: Labels no cabeçalho escuro (cnt_4c_Cabecalho com BackColor=53,53,53) = branco. Labels em Page2 com imagem de fundo = preto. Copiar posicoes/tamanhos EXATOS do original (Say1.Left, Say1.Top, etc).

## 39. Colunas de banco: NUNCA remover sufixo 's' (task159)

SigMvCcr tem `Tipos` (nao `Tipo`), `Opers` (nao `Oper`), `Grupos` (nao `Grupo`). O original usa `'R' as Tipo` como ALIAS em SELECT, nao como coluna real.

**Regra**: Copiar nomes de colunas EXATAMENTE do `docs/schema.sql`. Se o original usa alias (`'R' as Tipo`), o migrado deve referenciar a coluna real (`Tipos`) no SELECT direto.

## 40. Metodos PROTECTED chamados sem THIS. -> "File not found" (task159)

```foxpro
*-- ERRADO: VFP9 procura FormatarGrupoSQL.prg
loc_cGrupo = FormatarGrupoSQL(par_cGrupo)

*-- CORRETO: chama metodo da propria classe
loc_cGrupo = THIS.FormatarGrupoSQL(par_cGrupo)
```

**Regra**: Toda chamada a metodo/funcao DENTRO de DEFINE CLASS deve usar `THIS.`. Sem THIS, VFP9 busca .prg externo.
CorretorAuto #58 detecta (manual fix).

## 41. CATCH NUNCA silencioso (task159)

```foxpro
*-- ERRADO: engole erros, impossibilita debug
CATCH TO loc_oErro
    IF USED("cursor_temp")
        USE IN cursor_temp
    ENDIF
ENDTRY

*-- CORRETO: sempre exibir mensagem
CATCH TO loc_oErro
    MsgErro("Erro: " + loc_oErro.Message, "Erro")
    IF USED("cursor_temp")
        USE IN cursor_temp
    ENDIF
ENDTRY
```

**Regra**: Todo CATCH deve ter pelo menos `MsgErro(loc_oErro.Message)`. Cleanup de cursores vem DEPOIS da mensagem.

## 42. Form chama Excluir() (PUBLIC), BO sobrescreve ExecutarExclusao() (PROTECTED) (task158)

```foxpro
*-- ERRADO no Form: ExecutarExclusao eh PROTECTED
THIS.this_oBusinessObject.ExecutarExclusao()  && "Property not found"

*-- CORRETO no Form:
THIS.this_oBusinessObject.Excluir()  && PUBLIC, chama ExecutarExclusao internamente

*-- No BO: sobrescrever ExecutarExclusao (nao Excluir)
PROTECTED PROCEDURE ExecutarExclusao()
    && DELETE FROM tabela WHERE ...
ENDPROC
```

## 43. CarregarLista NAO deve resetar ColumnCount/RecordSource (task169)

Setting ColumnCount destroys ALL columns even if value is the same. Setting RecordSource re-triggers auto-bind.

```foxpro
*-- ERRADO: destrói colunas a cada chamada
PROCEDURE CarregarLista()
    loc_oGrid.RecordSource = "cursor_4c_Dados"
    loc_oGrid.ColumnCount = 3
    loc_oGrid.Column1.ControlSource = ...  && reconfigura tudo

*-- CORRETO: configurar UMA VEZ, depois só refresh
PROCEDURE CarregarLista()
    IF loc_oGrid.ColumnCount != 3 OR EMPTY(loc_oGrid.RecordSource)
        *-- Primeira vez: configurar grid completo
        loc_oGrid.RecordSource = "cursor_4c_Dados"
        loc_oGrid.ColumnCount = 3
        loc_oGrid.Column1.ControlSource = ...
    ENDIF
    SELECT cursor_4c_Dados
    GO TOP
    loc_oGrid.Refresh()
```

**Regra**: Grid configurado em ConfigurarPaginaLista (estrutura) + CarregarLista (dados). CarregarLista so reconfigura se ColumnCount mudou ou RecordSource esta vazio.

## 44. APPEND FROM requer SELECT cursor antes (task169)

`ZAP IN cursor_name` NAO muda a work area corrente. `APPEND FROM DBF("tmp")` opera na work area CORRENTE. Sem SELECT, dados vao para o cursor errado.

```foxpro
*-- ERRADO: APPEND vai para work area errada
loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
ZAP IN cursor_4c_Dados
APPEND FROM DBF("cursor_4c_DadosTmp")   && vai para cursor_4c_DadosTmp (work area corrente)!

*-- CORRETO: SELECT antes de APPEND
loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
SELECT cursor_4c_Dados
ZAP
APPEND FROM DBF("cursor_4c_DadosTmp")   && vai para cursor_4c_Dados (selecionado)
USE IN cursor_4c_DadosTmp
```

**Regra**: Sempre `SELECT cursor_destino` antes de `APPEND FROM`. O padrao ZAP+APPEND no BO.Buscar() deve selecionar o cursor de destino primeiro.

## 45. CommandGroup.FontName NAO EXISTE em VFP9 (task170)

CommandGroup, assim como OptionGroup, NAO tem propriedades FontName/FontSize no nivel do grupo. Devem ser definidas em cada Buttons(N) individualmente.

```foxpro
*-- ERRADO: FontName no CommandGroup
WITH loc_oPagina.grp_4c_Operacao
    .ButtonCount = 2
    .BackColor   = RGB(53,53,53)
    .FontName    = "Tahoma"      && ERRO: "Property FONTNAME is not found"
    .FontSize    = 8             && nunca executa (cascata do erro acima)
    .Buttons(1).Caption = "OK"   && nunca executa → botao fica "Command1"

*-- CORRETO: FontName em cada Button
WITH loc_oPagina.grp_4c_Operacao
    .ButtonCount = 2
    .BackColor   = RGB(53,53,53)
    .Buttons(1).Caption  = "OK"
    .Buttons(1).FontName = "Tahoma"
    .Buttons(1).FontSize = 8
    .Buttons(2).Caption  = "Cancelar"
    .Buttons(2).FontName = "Tahoma"
    .Buttons(2).FontSize = 8
```

**Regra**: Controles de grupo (OptionGroup, CommandGroup) NAO tem FontName. Definir em cada Button individual. Erro cascateia dentro do TRY/CATCH e impede toda configuracao subsequente.

## 46. AlternarPagina DEVE chamar AjustarBotoesPorModo (task169)

Em forms CRUD, ao voltar da Page2 para Page1, o modo muda para "LISTA" mas os botoes ficam no estado anterior (desabilitados por BtnIncluirClick/BtnAlterarClick).

```foxpro
*-- ERRADO: botoes ficam desabilitados apos salvar/cancelar
PROCEDURE AlternarPagina(par_nPagina)
    IF par_nPagina = 1
        THIS.this_cModoAtual = "LISTA"
        THIS.CarregarLista()
    ENDIF

*-- CORRETO: resetar estado dos botoes
PROCEDURE AlternarPagina(par_nPagina)
    IF par_nPagina = 1
        THIS.this_cModoAtual = "LISTA"
        THIS.AjustarBotoesPorModo()
        THIS.CarregarLista()
    ENDIF
```

**Regra**: AlternarPagina para Page1 DEVE chamar AjustarBotoesPorModo() ANTES de CarregarLista().

## 47. CommandGroup BackStyle=0 (transparente) - COPIAR do original (task170)

Muitos forms usam CommandGroup como container logico INVISIVEL (BackStyle=0, BorderStyle=0). A migracao adicionava BackColor escuro tornando o grupo um bloco opaco que nao existia no original.

```foxpro
*-- ERRADO: CommandGroup opaco (nao existia no original)
WITH par_oPagina.grp_4c_Operacao
    .BackColor   = RGB(53,53,53)        && BLOCO ESCURO que nao existia!
    .Buttons(1).BackColor = RGB(53,53,53)

*-- CORRETO: copiar BackStyle/BorderStyle EXATOS do original
WITH par_oPagina.grp_4c_Operacao
    .BackStyle    = 0                   && TRANSPARENTE (original)
    .BorderStyle  = 0                   && SEM BORDA (original)
    .SpecialEffect = 1                  && COPIAR do original
    .Themes       = .F.
    .Buttons(1).BackColor = RGB(255,255,255)  && COPIAR do original
```

**Regra**: Copiar BackStyle, BorderStyle, SpecialEffect EXATOS do codigo fonte original. Se original tem BackStyle=0, o migrado DEVE ter BackStyle=0 — NUNCA adicionar BackColor quando original nao tem.

## 48. ForeColor de Labels: COPIAR do original, NUNCA assumir (task170)

Labels sobre fundo escuro (header) usam ForeColor branco. Labels sobre fundo claro (body do form) usam ForeColor cinza. A migracao assumiu ForeColor branco para TODAS as labels, tornando labels do body INVISIVEIS.

```foxpro
*-- ERRADO: assumir ForeColor baseado no "tema" do form
WITH par_oPagina.lbl_4c_Periodo
    .ForeColor = RGB(255,255,255)  && INVISIVEL sobre fundo claro!

*-- CORRETO: copiar ForeColor EXATO do codigo fonte original
WITH par_oPagina.lbl_4c_Periodo
    .ForeColor = RGB(90,90,90)     && Valor EXATO do original
    .FontBold  = .T.               && Copiar do original tambem
```

**Regra**: ForeColor, FontBold, FontItalic de CADA label devem ser copiados do codigo fonte original. NUNCA assumir cor baseado no "tema" do form.

## 49. Buttons(N) em CommandGroup: propriedades EXATAS do original (task170)

Buttons dentro de CommandGroup tem posicoes, fontes e cores proprias que variam por form. A migracao inventava Left=0, FontName="Tahoma" quando o original tinha valores completamente diferentes.

```foxpro
*-- ERRADO: inventar propriedades dos Buttons
.Buttons(1).Left      = 0              && Original: 178!
.Buttons(1).FontName  = "Tahoma"       && Original: "Comic Sans MS"!
.Buttons(1).BackColor = RGB(53,53,53)  && Original: RGB(255,255,255)!

*-- CORRETO: copiar EXATAMENTE do codigo fonte original
.Buttons(1).Left       = 178           && EXATO do original
.Buttons(1).FontName   = "Comic Sans MS"  && EXATO do original
.Buttons(1).FontBold   = .T.           && EXATO do original
.Buttons(1).FontItalic = .T.           && EXATO do original
.Buttons(1).BackColor  = RGB(255,255,255) && EXATO do original
.Buttons(1).ForeColor  = RGB(90,90,90)    && EXATO do original
```

**Regra**: Left, Top, Width, Height, FontName, FontBold, FontItalic, BackColor, ForeColor dos Buttons(N) DEVEM ser copiados do codigo fonte original. NUNCA inventar valores default.

**Complemento OptionGroup (task022)**: OptionButton (dentro de OptionGroup) TEM BackStyle — regra diferente de CommandButton que NAO tem (patterns #59/#60 do CorretorAutomatico). Omitir `.BackStyle = 0` em OptionGroup.Buttons(N) faz o fundo opaco (default) clipar captions acentuadas:

```foxpro
*-- ERRADO: sem BackStyle=0, "Nao" (= CHR(227)) aparece como "Na"
WITH loc_oPagina.obj_4c_OpcaoSNA.Buttons(2)
    .Caption   = "N" + CHR(227) + "o"
    .Left      = 73
    .Width     = 37
    .AutoSize  = .T.
    .FontName  = "Tahoma"
    .FontSize  = 8
ENDWITH
```

```foxpro
*-- CORRETO: BackStyle=0 transparente + Width suficiente
WITH loc_oPagina.obj_4c_OpcaoSNA.Buttons(2)
    .Caption   = "N" + CHR(227) + "o"
    .Left      = 73
    .Width     = 45              && margem para caracter acentuado
    .AutoSize  = .T.
    .BackStyle = 0               && transparente como no SCX legado
    .FontName  = "Tahoma"
    .FontSize  = 8
ENDWITH
```

**Regra**: SCX tipicamente tem `OptionN.BackStyle = 0` explicitamente. Migrador DEVE copiar. CorretorAutomatico #86 injeta automaticamente se ausente.

## 50. Propriedades do BO preservam sufixo "s" da coluna do banco (task170)

Colunas do banco VFP9 frequentemente terminam em "s" (Moedas, Contas, Grupos, Saldos). As propriedades do BO mapeiam EXATAMENTE esses nomes. A migracao "corrigia" removendo o "s", gerando "Property not found".

```foxpro
*-- ERRADO: remover o "s" da coluna do banco
THIS.this_oBusinessObject.this_cMoeda = loc_cMoeda    && "Property THIS_CMOEDA is not found"
THIS.this_oBusinessObject.this_cConta = loc_cConta    && "Property THIS_CCONTA is not found"

*-- CORRETO: preservar nome EXATO da coluna do banco
THIS.this_oBusinessObject.this_cMoedas = loc_cMoeda   && OK - propriedade existe no BO
THIS.this_oBusinessObject.this_cContas = loc_cConta    && OK - propriedade existe no BO
```

**Regra**: Verificar SEMPRE o DEFINE CLASS do BO para confirmar o nome exato da propriedade. Colunas do banco (Moedas, Contas, Grupos, Saldos) geram propriedades com o MESMO nome (this_cMoedas, this_cContas, etc.).

## 51. Nomes de icones/imagens: COPIAR EXATO do original (task170)

O atributo .Picture deve usar o nome de arquivo EXATO do original. A migracao inventava nomes genericos (.bmp) que nao existiam na pasta de icones.

```foxpro
*-- ERRADO: inventar nomes de imagem
.Picture = gc_4c_CaminhoIcones + "consultar.bmp"    && ARQUIVO NAO EXISTE!
.Picture = gc_4c_CaminhoIcones + "sair.bmp"          && ARQUIVO NAO EXISTE!
.Picture = gc_4c_CaminhoIcones + "imprimir.bmp"      && ARQUIVO NAO EXISTE!

*-- CORRETO: copiar nome EXATO do original, trocar so o path
*-- Original: ..\framework\imagens\geral_procura_60.jpg
.Picture = gc_4c_CaminhoIcones + "geral_procura_60.jpg"         && EXATO do original
*-- Original: ..\framework\imagens\cadastro_sair_60.jpg
.Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"         && EXATO do original
*-- Original: ..\framework\imagens\geral_impressora_normal_60.jpg
.Picture = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg" && EXATO do original
```

**Regra**: Trocar APENAS o path (`..\\framework\\imagens\\` → `gc_4c_CaminhoIcones +`). O nome do arquivo DEVE ser identico ao original.

## 52. Propriedades do FORM: COPIAR TODAS do original (task170)

Propriedades como TitleBar, ControlBox, MaxButton, MinButton, Closable controlam a aparencia da janela. Omiti-las faz VFP9 usar defaults que alteram completamente o visual.

```foxpro
*-- ERRADO: omitir propriedades da janela (VFP9 usa defaults)
DEFINE CLASS Formsigopind AS FormBase
    Caption    = "Individual"
    Width      = 1000
    Height     = 600
    *-- TitleBar, ControlBox, etc. AUSENTES → barra de titulo aparece!

*-- CORRETO: copiar TODAS do original
DEFINE CLASS Formsigopind AS FormBase
    Caption    = "Individual"
    Width      = 1000
    Height     = 600
    TitleBar   = 0          && original: sem barra de titulo
    ControlBox = .F.        && original: sem botao de controle
    MaxButton  = .F.        && original: sem maximizar
    MinButton  = .F.        && original: sem minimizar
    Closable   = .F.        && original: sem fechar pelo X
```

**Regra**: TODAS as propriedades visuais do DEFINE CLASS do form devem vir do original: TitleBar, ControlBox, MaxButton, MinButton, Closable, ClipControls, BorderStyle, BackColor, Picture.

## 53. CommandButton ForeColor/BackColor/Themes EXATOS do original (task173)

Botoes avulsos (CommandButton fora de CommandGroup) DEVEM copiar ForeColor, BackColor, FontName, FontBold, FontItalic, Themes do original. Se o pipeline inventa valores (ex: ForeColor branco), o texto fica invisivel.

```foxpro
*-- ERRADO: ForeColor branco em fundo claro → texto invisivel
WITH loc_oPagina.cmd_4c_Cmd_procurar
    .ForeColor = RGB(255, 255, 255)  && INVISIVEL!
    .FontName  = "Tahoma"            && original usa Comic Sans MS
    .Picture   = gc_4c_CaminhoIcones + "geral_procura_60.jpg"  && nome ERRADO

*-- CORRETO: copiar EXATO do original
WITH loc_oPagina.cmd_4c_Cmd_procurar
    .ForeColor  = RGB(90, 90, 90)    && do original
    .BackColor  = RGB(255, 255, 255) && do original
    .FontName   = "Comic Sans MS"    && do original
    .FontBold   = .T.                && do original
    .FontItalic = .T.                && do original
    .Themes     = .F.                && do original
    .Picture    = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"  && nome EXATO
```

**Regra**: TODAS as propriedades visuais de CommandButton devem vir do original. Especialmente ForeColor, BackColor, FontName, FontBold, FontItalic, Themes e Picture.

## 54. Grid RecordMark/DeleteMark em forms OPERACIONAIS (task173)

Grids criados manualmente via AddObject em forms OPERACIONAIS nao herdam de GridBase (que ja define RecordMark=.F.). Sem essas propriedades, barras de marcacao aparecem na lateral esquerda do grid.

```foxpro
*-- ERRADO: grid sem RecordMark/DeleteMark
loc_oPagina.AddObject("grd_4c_Saldos", "Grid")
WITH loc_oPagina.grd_4c_Saldos
    .Top    = 137
    .Width  = 980
    .Height = 454
    *-- RecordMark/DeleteMark AUSENTES → barras de marcacao visiveis!

*-- CORRETO: sempre incluir
WITH loc_oPagina.grd_4c_Saldos
    .Top        = 137
    .Width      = 980
    .Height     = 454
    .RecordMark = .F.
    .DeleteMark = .F.
```

**Regra**: TODO grid criado via AddObject em forms OPERACIONAIS DEVE ter `.RecordMark = .F.` e `.DeleteMark = .F.`.

## 55. ChkRegister NAO EXISTE em BusinessBase (task171)

O legado usa `ThisForm.poDataMgr.ChkRegister('Tabela','Coluna',Valor)` (metodo do Framework `fSqlConector`) para verificar duplicidade antes de inserir. Na arquitetura nova, `BusinessBase` NAO tem esse metodo. Chamar `THIS.this_oBusinessObject.ChkRegister(...)` causa "Property CHKREGISTER is not found".

```foxpro
*-- ERRADO: ChkRegister nao existe em BusinessBase
IF THIS.this_oBusinessObject.ChkRegister("SigCdTam", "Cods", loc_cCodigo)
    MsgAviso("Registro j" + CHR(225) + " Cadastrado !!")
    RETURN
ENDIF

*-- CORRETO: usar SQLEXEC com SELECT COUNT(*)
loc_cSQLDup = "SELECT COUNT(*) AS nExiste FROM SigCdTam WHERE cods = " + EscaparSQL(loc_cCodigo)
loc_nDup = SQLEXEC(gnConnHandle, loc_cSQLDup, "cursor_4c_DupCheck")
IF loc_nDup >= 0 AND NVL(cursor_4c_DupCheck.nExiste, 0) > 0
    IF USED("cursor_4c_DupCheck")
        USE IN cursor_4c_DupCheck
    ENDIF
    MsgAviso("Registro j" + CHR(225) + " Cadastrado !!")
    RETURN
ENDIF
IF USED("cursor_4c_DupCheck")
    USE IN cursor_4c_DupCheck
ENDIF
```

**Regra**: Quando o original usa `ChkRegister('Tabela','Coluna',Valor)`, substituir por SQLEXEC com `SELECT COUNT(*) AS nExiste FROM Tabela WHERE Coluna = valor`, usando `EscaparSQL()` para o valor. Verificar `NVL(cursor.nExiste, 0) > 0` e fechar o cursor com `USE IN`.

## 56. cnt_4c_Cabecalho DEVE ter fundo escuro opaco (task001)

O container `cntSombra` do framework `frmcadastro` tem fundo escuro (barra de cabeçalho). Ao migrar para `cnt_4c_Cabecalho`, o pipeline gerava `BackStyle = 0` (transparente) — o cabeçalho ficava invisível.

```foxpro
*-- ERRADO: cabecalho transparente (invisivel)
WITH loc_oPagina.cnt_4c_Cabecalho
    .BackStyle   = 0
    .BorderWidth = 0
ENDWITH
WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
    .ForeColor = RGB(90,90,90)
ENDWITH

*-- CORRETO: fundo escuro opaco + texto branco
WITH loc_oPagina.cnt_4c_Cabecalho
    .BackStyle   = 1
    .BackColor   = RGB(53,53,53)
    .BorderWidth = 0
ENDWITH
WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
    .ForeColor = RGB(255,255,255)
ENDWITH
```

**Regra**: Em forms CRUD (frmcadastro), `cnt_4c_Cabecalho` DEVE ter `BackStyle = 1` (opaco) + `BackColor = RGB(53,53,53)` e `lbl_4c_Titulo.ForeColor = RGB(255,255,255)` (branco sobre escuro).

## 57. NovoRegistro()/EditarRegistro() DEVEM chamar DODEFAULT() (task001)

BOs que sobrescrevem `NovoRegistro()` ou `EditarRegistro()` sem chamar `DODEFAULT()` impedem que `BusinessBase` sete `this_lEmEdicao = .T.`. Resultado: `Salvar()` SEMPRE retorna `.F.` silenciosamente ("não está em modo de edição").

```foxpro
*-- ERRADO: sem DODEFAULT — this_lEmEdicao fica .F. — Salvar FALHA
PROCEDURE NovoRegistro()
    THIS.this_cCodigos = ""
    THIS.this_cDescricaos = ""
ENDPROC

*-- CORRETO: DODEFAULT() como primeira linha
PROCEDURE NovoRegistro()
    DODEFAULT()
    THIS.this_cCodigos = ""
    THIS.this_cDescricaos = ""
ENDPROC
```

**Regra**: TODO BO que sobrescreve `NovoRegistro()` ou `EditarRegistro()` DEVE ter `DODEFAULT()` como primeira linha. Sem isso, `this_lEmEdicao` fica `.F.` e nenhuma operação de salvar funciona.

## 58. Botões CRUD Width=75 e posições EXATAS, Encerrar em container SEPARADO (task002)

O pipeline gerava botões com Width=65 e gaps de 7px entre eles. O original tem botões Width=75 colados (sem gap). Além disso, o Encerrar ficava no mesmo container dos botões CRUD; no original está em `grupo_saida` separado.

```foxpro
*-- ERRADO: botoes Width=65 com gaps, Encerrar no mesmo container
WITH loc_oPagina.cnt_4c_Botoes
    .Left  = 542
    .Width = 450
ENDWITH
*-- cmd_4c_Incluir.Left=5, .Width=65
*-- cmd_4c_Visualizar.Left=77, .Width=65  (gap de 7px!)
*-- cmd_4c_Encerrar.Left=375, .Width=65   (dentro de cnt_4c_Botoes)

*-- CORRETO: botoes Width=75 sem gap, Encerrar em cnt_4c_Saida separado
WITH loc_oPagina.cnt_4c_Botoes
    .Left  = 544
    .Width = 390
ENDWITH
*-- cmd_4c_Incluir.Left=5, .Width=75
*-- cmd_4c_Visualizar.Left=80, .Width=75  (5+75=80, sem gap)
*-- cmd_4c_Alterar.Left=155, .Width=75
*-- cmd_4c_Excluir.Left=230, .Width=75
*-- cmd_4c_Buscar.Left=305, .Width=75
loc_oPagina.AddObject("cnt_4c_Saida", "Container")
WITH loc_oPagina.cnt_4c_Saida
    .Left  = 916
    .Width = 85
ENDWITH
*-- cmd_4c_Encerrar.Left=5, .Width=75  (dentro de cnt_4c_Saida)
```

**Regra**: Botões CRUD em forms `frmcadastro` DEVEM ter Width=75 e posições Left=5,80,155,230,305 (tocando). Encerrar/Sair DEVE estar em `cnt_4c_Saida` (container separado, Left=916, W=85).

## 59. Lookup textbox DEVE disparar em ENTER/TAB além de F4 (task002)

O original usa evento `Valid` que dispara quando o usuário sai do campo (TAB/ENTER). O pipeline gerava lookup apenas para F4 e DblClick. Se o usuário digitar valor e pressionar TAB, nada acontecia.

```foxpro
*-- ERRADO: apenas F4 dispara lookup
PROCEDURE DiretoresKeyPress(par_nKeyCode, par_nShiftAltCtrl)
    IF par_nKeyCode = 63
        THIS.AbrirLookupDiretor()
    ENDIF
ENDPROC

*-- CORRETO: F4 + ENTER + TAB disparam lookup (comportamento do Valid original)
PROCEDURE DiretoresKeyPress(par_nKeyCode, par_nShiftAltCtrl)
    DO CASE
    CASE par_nKeyCode = 63
        THIS.AbrirLookupDiretor()
    CASE INLIST(par_nKeyCode, 13, 9)
        IF !EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Diretores.Value))
            THIS.AbrirLookupDiretor()
        ENDIF
    ENDCASE
ENDPROC
```

**Regra**: Campos com lookup (fwBuscaExt no legado) DEVEM disparar busca em F4(63) E ENTER(13)/TAB(9) no KeyPress handler. ENTER/TAB só disparam se o campo não está vazio.

## 60. Code Review CHECK 23 deve considerar ChkRegister como source de WHERE (task002)

O Code Review SQL-FILTRO-INVENTADO removeu a verificação `SELECT COUNT(*) FROM SigCdUsu WHERE deptos = valor` classificando 'deptos' como coluna inventada. Mas o original tinha `ChkRegister('SigCdUsu','deptos',valor)` — que é a mesma verificação no framework legado.

**Causa**: CHECK 23 extraía colunas de WHERE do original via regex em SQL (WHERE/AND/OR). `ChkRegister('tabela','coluna',valor)` não usa WHERE explícito, então a coluna não era detectada. Fix aplicado: extrair colunas do 2º parâmetro de ChkRegister e adicionar à lista de colunas WHERE conhecidas.

**Regra**: Verificações de dependência entre tabelas (ChkRegister no legado) são regras de negócio REAIS. O Code Review NUNCA deve removê-las.

## 61. PEMSTATUS() so funciona com OBJETOS, NUNCA com cursores (task003)

PEMSTATUS() verifica propriedades/metodos de **objetos VFP**. Quando usado com alias de cursor criado por SQLEXEC, VFP9 tenta avaliar o alias como variavel de memoria e gera "Variable 'LOC_TMPXXX' is not found".

```foxpro
*-- ERRADO: loc_TmpOpi eh alias de cursor, nao objeto
IF PEMSTATUS(loc_TmpOpi, "Codtgops", 5)
    THIS.this_cCodTgOpOriginal = loc_TmpOpi.Codtgops
ENDIF
```

```foxpro
*-- CORRETO opcao 1: Se query eh SELECT *, campo sempre existe - acessar direto
THIS.this_cCodTgOpOriginal = loc_TmpOpi.Codtgops

*-- CORRETO opcao 2: Se precisa verificar existencia do campo no cursor
IF TYPE("loc_TmpOpi.Codtgops") != "U"
    THIS.this_cCodTgOpOriginal = loc_TmpOpi.Codtgops
ENDIF
```

**Regra**: PEMSTATUS eh para objetos (THIS, loc_oObj). Para cursores, usar TYPE("alias.campo") ou acessar direto.

**Reforco (task021)**: O gerador continua emitindo `PEMSTATUS((par_cAliasCursor), "campo", 5)` dentro de `CarregarDoCursor(par_cAliasCursor)`. A forma `(par_cAliasCursor)` com parenteses sugere macro expansion de alias — mas PEMSTATUS nao aceita alias em NENHUMA forma. CorretorAutomatico #84 normaliza automaticamente:

```foxpro
*-- ERRADO (ainda aparece em CarregarDoCursor gerado)
IF PEMSTATUS((par_cAliasCursor), "desvends", 5)
    THIS.this_cDesVends = TratarNulo(desvends, "C")
ENDIF
```

```foxpro
*-- CORRETO
IF TYPE(par_cAliasCursor + ".desvends") != "U"
    THIS.this_cDesVends = TratarNulo(desvends, "C")
ENDIF
```

## 62. NUNCA usar ALLTRIM em campos CHAR ao montar chaves compostas (task003)

Campos CHAR de tamanho fixo no SQL Server (Emps CHAR(3), Dopps CHAR(20)) ja possuem o tamanho correto com padding de espacos a direita. Ao montar chaves compostas como EmpDnPs (33 chars = 3+20+10), a concatenacao DIRETA gera o valor correto. Usar ALLTRIM+PADR destroi o layout interno da chave.

```foxpro
*-- ERRADO: ALLTRIM remove espacos internos, PADR repadea no final
loc_cEdn = PADR(ALLTRIM(loc_TmpOpi.Emps) + ;
                ALLTRIM(loc_TmpOpi.Dopps) + ;
                STR(loc_TmpOpi.Nops, 10), 33)
```

```foxpro
*-- CORRETO: concatenacao direta preserva layout fixo
loc_cEdn = loc_TmpOpi.Emps + loc_TmpOpi.Dopps + STR(loc_TmpOpi.Nops, 10)
```

**Regra**: COPIAR concatenacao EXATA do codigo original. Campos CHAR com tamanho fixo NUNCA devem receber ALLTRIM ao compor chaves.

## 63. Campos BIT do SQL Server = LOGICAL no VFP9, NUNCA comparar com numerico (task003)

Campos BIT no SQL Server (ChkSubn, Divs, Imprs, IImprs) chegam como LOGICAL (.T./.F.) no VFP9 via SQLEXEC. Campos NUMERIC(1,0) (Globalizas, Servicos, GrComps) chegam como NUMERIC. O tratamento eh diferente.

```foxpro
*-- ERRADO: ChkSubn eh BIT -> LOGICAL. NVL com 0 (numerico) causa type mismatch
IF NVL(loc_TmpNens.ChkSubn, 0) = 1
    && "Operator/operand type mismatch"
ENDIF
```

```foxpro
*-- CORRETO para campos BIT: tratar como LOGICAL direto
IF loc_TmpNens.ChkSubn
    && funciona
ENDIF

*-- CORRETO para campos NUMERIC(1,0): NVL + comparacao numerica OK
IF NVL(loc_LocalEest.Globalizas, 0) = 1
    && Globaliza eh NUMERIC(1,0) - funciona
ENDIF
```

**Como distinguir**: Consultar schema.sql ou INFORMATION_SCHEMA. `[campo] [bit]` = LOGICAL. `[campo] [numeric](1,0)` = NUMERIC. Campos BIT comuns: ChkSubn, Divs, Imprs, IImprs. O original VFP tipicamente usa `Not campo` ou `IF campo` para BIT.

## 64. Lookup DEVE validar ao sair do campo (ENTER/TAB) antes de abrir FormBuscaAuxiliar (task003)

Campos com lookup (fwBuscaExt no legado) devem ter comportamento diferente conforme a tecla pressionada no KeyPress handler:

- **ENTER(13) / TAB(9)**: Primeiro VALIDAR o valor digitado contra a tabela de referencia via SQLEXEC. Se encontrar, preencher campo de descricao. Se NAO encontrar, abrir FormBuscaAuxiliar automaticamente.
- **F4(115) / F5(116)**: Sempre abrir FormBuscaAuxiliar direto (lookup forçado pelo usuario).

```foxpro
*-- ERRADO: abre lookup em qualquer tecla, ignora valor digitado
PROCEDURE TxtCodigoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
    IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
        THIS.AbrirLookupCodigo()
    ENDIF
ENDPROC

*-- CORRETO: valida primeiro em ENTER/TAB, abre direto em F4/F5
PROCEDURE TxtCodigoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
    IF par_nKeyCode = 115 OR par_nKeyCode = 116
        *-- F4/F5: abre lookup direto
        THIS.AbrirLookupCodigo()
    ENDIF
    IF par_nKeyCode = 13 OR par_nKeyCode = 9
        *-- ENTER/TAB: valida valor digitado
        loc_cCodigo = ALLTRIM(THIS.txt_4c_Codigo.Value)
        IF !EMPTY(loc_cCodigo)
            loc_cSQL = "SELECT descricao FROM tabela WHERE codigo = " + EscaparSQL(loc_cCodigo)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Tmp")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Tmp") > 0
                THIS.txt_4c_Descricao.Value = ALLTRIM(cursor_4c_Tmp.descricao)
            ELSE
                THIS.AbrirLookupCodigo()
            ENDIF
            USE IN SELECT("cursor_4c_Tmp")
        ENDIF
    ENDIF
ENDPROC
```

**IMPORTANTE**: F4=115, F5=116. NUNCA usar 63 (que eh '?' ASCII). CorretorAutomatico #67 corrige automaticamente.

**Regra**: O legado fazia validacao via Valid() do textbox. Na migracao, simular via KeyPress ENTER/TAB. O usuario espera que ao digitar codigo e pressionar TAB, a descricao seja preenchida automaticamente.

## 65. Z-ORDER AddObject: PageFrame interno cobre OptionGroup/botoes (task005)

Quando Page2 de um form CRUD tem:
- OptionGroup de navegacao (tabs: Principal, Componente, Fiscal, etc.)
- Botoes Confirmar/Cancelar
- PageFrame interno (pgf_4c_DadosInternos) com sub-paginas

VFP9 AddObject coloca o ULTIMO objeto adicionado no topo do z-order. Se o PageFrame interno e adicionado DEPOIS do OptionGroup, ele fica NA FRENTE e cobre os controles de navegacao.

```foxpro
*-- ERRADO: PageFrame adicionado por ultimo, cobre OptionGroup
loc_oPagina.AddObject("obj_4c_NavegacaoDados", "OptionGroup")
loc_oPagina.AddObject("cnt_4c_Salva", "Container")
loc_oPagina.AddObject("pgf_4c_DadosInternos", "PageFrame")
*-- OptionGroup e Salva ficam ATRAS do PageFrame (invisiveis!)
```

```foxpro
*-- CORRETO: ZOrder(0) traz controles de navegacao para frente
loc_oPagina.AddObject("obj_4c_NavegacaoDados", "OptionGroup")
loc_oPagina.AddObject("cnt_4c_Salva", "Container")
loc_oPagina.AddObject("pgf_4c_DadosInternos", "PageFrame")
*-- ... configurar todos os objetos ...
loc_oPagina.obj_4c_NavegacaoDados.ZOrder(0)
loc_oPagina.cnt_4c_Salva.ZOrder(0)
```

**ZOrder(0)** = trazer para frente. **ZOrder(1)** = enviar para tras.

## 66. PageFrame interno .Tabs = .F. quando navegacao e via OptionGroup (task005)

Se o form original usa OptionGroup para navegar entre sub-paginas (Principal, Componente, Fiscal, etc.), o PageFrame interno DEVE ter `.Tabs = .F.` para esconder os tabs nativos do VFP9.

```foxpro
*-- ERRADO: tabs nativos visiveis + OptionGroup = duplicacao
WITH loc_oPagina.pgf_4c_DadosInternos
    .Tabs = .T.   && tabs nativos aparecem, consomem espaco
    .Top  = -25    && Top insuficiente para esconder tabs
ENDWITH

*-- CORRETO: tabs escondidos, navegacao via OptionGroup
WITH loc_oPagina.pgf_4c_DadosInternos
    .Tabs = .F.   && sem tabs nativos
    .Top  = -54    && posicao EXATA do layout.json original
ENDWITH
```

**Regra**: Copiar o valor de `.Top` do PageFrame interno do layout.json (tipicamente negativo, ex: -54). Valor diferente causa sobreposicao de controles.

## 67. Container Left+Width NAO pode exceder Form.Width (task005)

Containers posicionados com `Left + Width > Form.Width` ficam parcialmente fora da area visivel.

```foxpro
*-- ERRADO: 959 + 90 = 1049 > Form.Width(1000) = botao cortado
WITH loc_oPagina.cnt_4c_Saida
    .Left  = 959
    .Width = 90    && 49px alem da borda direita do form
ENDWITH

*-- CORRETO: 905 + 90 = 995 < 1000 = botao visivel
WITH loc_oPagina.cnt_4c_Saida
    .Left  = 905
    .Width = 90
ENDWITH
```

**Regra**: Para TODOS os containers em qualquer Page, validar que `Left + Width <= Form.Width` (normalmente 1000). Se exceder, ajustar Left para caber.

## 68. NUNCA inventar tabelas de lookup - copiar do original (task006)

A LLM frequentemente inventa tabelas de lookup para preencher campos de descricao. Se o original NAO faz Seek/lookup para um campo, o migrado NAO deve criar query de lookup.

```foxpro
*-- ERRADO: LLM inventou SigCdCcr (tabela NAO existe) para lookup de Contas
loc_nResultado = SQLEXEC(gnConnHandle, ;
    "SELECT Contas, Descrs FROM SigCdCcr" + ;
    " WHERE Contas = " + EscaparSQL(loc_cConta), ;
    "cursor_4c_BuscaConta")

*-- ERRADO: LLM inventou SigCdJob (tabela NAO existe) para lookup de Jobs
loc_nResultado = SQLEXEC(gnConnHandle, ;
    "SELECT Jobs, Descrs FROM SigCdJob" + ;
    " WHERE Jobs = " + EscaparSQL(loc_cJob), ;
    "cursor_4c_BuscaJob")
```

```foxpro
*-- CORRETO para Contas: usar SigCdCli (Clientes) conforme original
loc_nResultado = SQLEXEC(gnConnHandle, ;
    "SELECT IClis, RClis AS Descrs FROM SigCdCli" + ;
    " WHERE IClis = " + EscaparSQL(loc_cConta), ;
    "cursor_4c_BuscaConta")

*-- CORRETO para Jobs: original NAO faz lookup, campo apenas exibido
loc_oPg2.txt_4c_DJob.Value = ""
```

**Regra**: Antes de criar query de lookup, VERIFICAR no codigo original se existe Seek/fwBuscaSel/fwBuscaExt para aquele campo. Se nao existe, o campo eh apenas exibido sem descricao. Tabelas de referencia validas estao no CLAUDE.md (SigCdGcr, SigCdMoe, SigCdCli, etc.).

## 69. WHERE Emps SOMENTE em tabelas que tem a coluna (task006)

A LLM adiciona `WHERE Emps = go_4c_Sistema.cCodEmpresa` em TODAS as queries, mas muitas tabelas de cadastro generico NAO tem coluna `Emps`.

```foxpro
*-- ERRADO: SigCdGcr NAO tem coluna Emps -> "Invalid column name 'Emps'"
loc_nResultado = SQLEXEC(gnConnHandle, ;
    "SELECT Codigos, Descrs FROM SigCdGcr" + ;
    " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
    " AND Codigos = " + EscaparSQL(loc_cGrupo), ;
    "cursor_4c_BuscaGrupo")

*-- CORRETO: SigCdGcr eh tabela compartilhada, sem filtro por empresa
loc_nResultado = SQLEXEC(gnConnHandle, ;
    "SELECT Codigos, Descrs FROM SigCdGcr" + ;
    " WHERE Codigos = " + EscaparSQL(loc_cGrupo), ;
    "cursor_4c_BuscaGrupo")
```

**Tabelas SEM coluna Emps** (cadastros genericos compartilhados): SigCdGcr (Grupos CC), SigCdMoe (Moedas), SigCdCot (Cotacoes - colunas: CMoes/Valos, NAO Moedas/Cotacaos), SigCdCor (Cores), SigCdUni (Unidades), SigCdTam (Tamanhos), SigCdLin (Linhas).

**Tabelas COM coluna Emps** (dados por empresa): SigMvCcr, SigMvSlc, SigCdCli, SigCdPro, SigCdPam.

**Regra**: Verificar no schema.sql se a tabela tem `emps` antes de adicionar filtro. O original usava `Seek(valor, [cursor], [campo])` sem filtro de empresa em tabelas genericas.

## 70. gb_4c_ValidandoUI guard obrigatorio em InicializarForm

Forms que usam `gb_4c_ValidandoUI` DEVEM ter guard no inicio de InicializarForm (apos LOCAL, antes de TRY). Sem isso: "Variable GB_4C_VALIDANDOUI is not found". Guard: `IF TYPE("gb_4c_ValidandoUI") != "L"` + `PUBLIC gb_4c_ValidandoUI` + `gb_4c_ValidandoUI = .F.` + `ENDIF`. CorretorAuto #70 auto-fix.

## 71. VAL(STR(x.Value)) redundante - usar .Value direto

`loc_oBO.this_nXxx = VAL(STR(campo.Value))` redundante. .Value ja retorna numerico. ERRADO: `STR(campo.Value)` atribui STRING a propriedade numerica. CORRETO: `campo.Value` direto. CorretorAuto #71 auto-fix.

## 72. Etapa 05f deve propagar renames do BO para o Form

Quando ValidadorSQLSchema renomeia propriedade no BO (ex: `this_nSituas` para `this_cSituas`), o Form tambem deve ser atualizado. Sem isso: "Property THIS_NSITUAS is not found". Pipeline emite AVISO quando detecta propriedades orfas no Form.

## 73. ComboBox.Value em FormParaBO: NUNCA usar NVL(combo.Value, "")

ComboBox.Value pode ser NUMERICO (0 quando sem selecao, ou ListIndex) OU STRING (texto selecionado), dependendo de Style e estado. `NVL(combo.Value, "")` falha quando Value eh 0 (numerico) porque NVL exige tipos iguais. CORRETO: `IIF(VARTYPE(combo.Value) = "C", combo.Value, "")`.

## 74. IIF() avalia AMBOS os ramos em VFP9 - NUNCA NVL dentro de IIF com tipo diferente

`IIF(VARTYPE(campo) = "L", campo, (NVL(campo, 0) = 1))` FALHA porque VFP9 avalia ambos os ramos. Quando campo eh LOGICAL, `NVL(campo, 0)` executa e falha (LOGICAL != NUMERIC). CORRETO: usar IF/ELSE/ENDIF em vez de IIF. CorretorAuto #66 corrigido para gerar IF/ELSE/ENDIF.

## 75. BOParaForm CheckBox deve atribuir NUMERICO nao LOGICAL

Quando CorretorAuto #47 define CheckBox.Value como NUMERICO (0/1), BOParaForm tambem deve atribuir NUMERICO. ERRADO: `chk.Value = (loc_oBO.this_nXxx = 1)` - atribui .T./.F. (LOGICAL), causa "Data type mismatch". CORRETO: `chk.Value = IIF(loc_oBO.this_nXxx = 1, 1, 0)` - atribui 1/0 (NUMERICO). CorretorAuto #73 auto-fix.

## 76. ValidadorSQLSchema falsos positivos com concatenacao multi-linha

ValidadorSQLSchema gerava falsos positivos em queries SQL com `" + ;` (concatenacao multi-linha VFP9). Parser corrigido para juntar linhas antes de analisar nomes de colunas.

## 77. Propriedades this_ declaradas com nome diferente do uso causam Error 174

Quando propriedades de guarda LostFocus sao declaradas com nomes "amigaveis" (ex: `this_cUltGrupo`) mas o codigo referencia nomes diferentes baseados em colunas do banco (ex: `THIS.this_cUltCgrus`), VFP9 gera Error 174 "Property is not found" no primeiro LostFocus que tenta LER a propriedade nao declarada.

```foxpro
*-- ERRADO: declaracao e uso com nomes DIFERENTES
DEFINE CLASS FormProduto AS FormBase
    this_cUltGrupo      = ""    && declarado com nome amigavel
    this_cUltFornecedor = ""
    this_cUltCor        = ""

PROCEDURE ValidarGrupoLostFocus()
    IF loc_cCod == THIS.this_cUltCgrus    && BOOM! Error 174 - this_cUltCgrus nao declarado
        RETURN
    ENDIF
    THIS.this_cUltCgrus = loc_cCod
ENDPROC
```

```foxpro
*-- CORRETO: declaracao usa EXATAMENTE o mesmo nome referenciado no codigo
DEFINE CLASS FormProduto AS FormBase
    this_cUltCgrus      = ""    && nome IDENTICO ao THIS.this_cUltCgrus do codigo
    this_cUltIfors      = ""    && nome IDENTICO ao THIS.this_cUltIfors do codigo
    this_cUltCodcors    = ""    && nome IDENTICO ao THIS.this_cUltCodcors do codigo

PROCEDURE ValidarGrupoLostFocus()
    IF loc_cCod == THIS.this_cUltCgrus    && OK - propriedade declarada
        RETURN
    ENDIF
    THIS.this_cUltCgrus = loc_cCod
ENDPROC
```

**Regra**: TODA propriedade referenciada como `THIS.this_cXxx` DEVE ter declaracao identica `this_cXxx = ""` no cabecalho DEFINE CLASS. Nomes "amigaveis" diferentes da referencia causam crash silencioso no primeiro LostFocus.

**Complemento (task018)**: Props auxiliares de UI (descricoes de lookups, ex: `this_cDsGrupos`, `this_cDclasse`) que passam por `FormParaBO`/`BOParaForm` mas NAO sao persistidas no SQL TAMBEM precisam ser declaradas no `DEFINE CLASS` do BO. Do contrario, `BOParaForm` lendo `this_oBusinessObject.this_cDsGrupos` em instancia fresca (apos `CarregarDoCursor` que so popula props SQL) dispara "Property not found".

```foxpro
DEFINE CLASS CmrBO AS BusinessBase
    *-- Props persistidas (SQL)
    this_cGrupos     = ""
    this_cClasses    = ""
    this_nCpartidas  = 0

    *-- Props auxiliares de UI (NAO persistidas, mas usadas em BOParaForm/FormParaBO)
    this_cDsGrupos   = ""    && Descricao do grupo via lookup SigCdGcr
    this_cDclasse    = ""    && Descricao da classe via lookup SigCdCss
```

## 78. Container.BorderStyle nao existe em VFP9

Container VFP9 tem `BorderWidth` mas NAO tem `BorderStyle`. A propriedade `BorderStyle` pertence a CommandGroup e OptionGroup. LLM frequentemente inventa `.BorderStyle = 0` em Container, causando Error 174 "Property BORDERSTYLE is not found".

```foxpro
*-- ERRADO: Container nao tem BorderStyle
loc_oPagina.AddObject("cnt_4c_BotoesDados", "Container")
WITH loc_oPagina.cnt_4c_BotoesDados
    .BackStyle   = 0
    .BorderStyle = 0    && BOOM! Error 174
    .BorderWidth = 0
ENDWITH
```

```foxpro
*-- CORRETO: Usar apenas BorderWidth
loc_oPagina.AddObject("cnt_4c_BotoesDados", "Container")
WITH loc_oPagina.cnt_4c_BotoesDados
    .BackStyle   = 0
    .BorderWidth = 0
ENDWITH
```

CorretorAuto #68 remove automaticamente `.BorderStyle` em contexto de Container.

## 79. Containers de botoes CRUD devem ser TRANSPARENTES (BackStyle=0)

Em forms `frmcadastro`, os containers que hospedam botoes da toolbar (`cnt_4c_Botoes`, `cnt_4c_Saida`, `cnt_4c_BotoesDados`) devem ter `BackStyle=0` (transparente). LLM frequentemente copia o padrao do cabecalho (`cnt_4c_Cabecalho` com BackStyle=1 + BackColor=RGB(53,53,53)) e aplica aos containers de botoes, criando uma caixa cinza escura ao redor dos botoes que nao existe no layout original.

O fundo do form ja e fornecido pela imagem `fundo_cad_1003.jpg` aplicada em `Page.Picture`. Containers opacos escuros destoam visualmente, pois os botoes da toolbar devem "flutuar" sobre o fundo da pagina, nao aparecer dentro de uma caixa propria.

```foxpro
*-- ERRADO: Container opaco escuro cria caixa cinza ao redor dos botoes
loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
WITH loc_oPagina.cnt_4c_Botoes
    .Top         = 29
    .Left        = 542
    .Width       = 390
    .Height      = 85
    .BackStyle   = 1                    && OPACO - ERRADO!
    .BackColor   = RGB(53, 53, 53)      && cinza escuro destoa do layout
    .BorderWidth = 0
ENDWITH
```

```foxpro
*-- CORRETO: Container transparente deixa o fundo da Page aparecer
loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
WITH loc_oPagina.cnt_4c_Botoes
    .Top         = 29
    .Left        = 542
    .Width       = 390
    .Height      = 85
    .BackStyle   = 0                    && TRANSPARENTE
    .BorderWidth = 0
ENDWITH
```

**Regra**: `cnt_4c_Botoes`, `cnt_4c_Saida`, `cnt_4c_BotoesDados` -> `BackStyle=0`. NUNCA adicionar `BackColor` escuro.

**EXCECAO UNICA**: `cnt_4c_Cabecalho` continua com `BackStyle=1` + `BackColor=RGB(53,53,53)` (cntSombra do frmcadastro) + label branco. Essa regra NAO muda - vale apenas para containers de BOTOES.

## 80. PageFrame.Height deve compensar Top=-29 (formula Form.Height + 29)

Em forms `frmcadastro` com `PageFrame` oculto (tabs escondidas), o PageFrame eh posicionado com `Top=-29` para esconder a area das abas. Consequencia: a area util visivel do PageFrame comeca em y=0 (no form) e termina em y = `Top + Height` = `-29 + Height`.

Se `PageFrame.Height = Form.Height` (ex: ambos 600), a area visivel cobre de y=0 ate y=571, deixando **29 pixels descobertos** no bottom. Esse espaco mostra o fundo cinza nativo do form, aparecendo como uma borda/faixa cinza indesejada.

```foxpro
*-- ERRADO: PageFrame.Height igual ao Form.Height deixa 29px no bottom
DEFINE CLASS FormDepartamento AS FormBase
    Height = 600

    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        WITH THIS.pgf_4c_Paginas
            .Top    = -29
            .Left   = 0
            .Width  = 1003
            .Height = 600      && ERRADO! cobre de -29 ate 571, sobra 29px
            .Tabs   = .F.
        ENDWITH
    ENDPROC
```

```foxpro
*-- CORRETO: PageFrame.Height = Form.Height + 29 cobre o form inteiro
DEFINE CLASS FormDepartamento AS FormBase
    Height = 600

    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        WITH THIS.pgf_4c_Paginas
            .Top    = -29
            .Left   = 0
            .Width  = 1003
            .Height = 629      && CORRETO! cobre de -29 ate 600
            .Tabs   = .F.
        ENDWITH
    ENDPROC
```

**Formula**: `PageFrame.Height = Form.Height + 29`

| Form.Height | PageFrame.Height |
|-------------|------------------|
| 600         | 629              |
| 650         | 679              |
| 700         | 729              |

Sempre que `PageFrame.Top = -29`, a altura DEVE compensar esse deslocamento para cobrir o form inteiro e esconder o fundo nativo que aparece como borda inferior.

## 81. BOs devem implementar ValidarDados() nao Validar() (task017)

BusinessBase.Salvar() chama `THIS.ValidarDados()`. Se o BO implementa `PROTECTED PROCEDURE Validar()` (nome errado), a validacao e silenciosamente pulada e `Inserir()` roda com valores default, tipicamente falhando no SQL com erros como "Function argument value, type, or count is invalid".

```foxpro
*-- ERRADO: nome do metodo nao bate com hook de BusinessBase
PROTECTED PROCEDURE Validar()
    IF EMPTY(THIS.this_cCodigo)
        MsgAviso("Codigo obrigatorio")
        RETURN .F.
    ENDIF
    RETURN .T.
ENDPROC
```

```foxpro
*-- CORRETO: ValidarDados() eh o hook oficial
PROTECTED PROCEDURE ValidarDados()
    IF EMPTY(THIS.this_cCodigo)
        THIS.this_cMensagemErro = "Codigo obrigatorio"
        RETURN .F.
    ENDIF
    RETURN .T.
ENDPROC
```

**Regra**: TODO BO que sobrescreve validacao DEVE usar `PROTECTED PROCEDURE ValidarDados()`, NUNCA `Validar()`.

## 82. IIF() exige LOGICAL no 1o argumento - numerico direto quebra (task017)

Em VFP9, o 1o argumento de IIF() DEVE ser logical. Passar numerico direto (`IIF(this_nFlag, '1', '0')`) gera "Function argument value, type, or count is invalid." quando o valor e 0. Pode funcionar silenciosamente com valor != 0 por coercao em algumas versoes, mas falha em 0.

```foxpro
*-- ERRADO: this_nObrigFator eh numerico 0/1; IIF(0, ...) falha
TEXT TO loc_cSQL TEXTMERGE NOSHOW
    INSERT INTO SigCdMoe (..., obgFator)
    VALUES (..., <<IIF(THIS.this_nObrigFator, '1', '0')>>)
ENDTEXT
```

```foxpro
*-- CORRETO: comparar explicitamente para gerar LOGICAL
TEXT TO loc_cSQL TEXTMERGE NOSHOW
    INSERT INTO SigCdMoe (..., obgFator)
    VALUES (..., <<IIF(THIS.this_nObrigFator = 1, '1', '0')>>)
ENDTEXT
```

**Regra**: Em TODO IIF() cujo 1o arg seja `this_n*` ou outra expressao numerica, comparar explicitamente (`= 1`, `> 0`, `!= 0`). Critico em TEXTMERGE SQL de Inserir/Atualizar.

## 83. CarregarDoCursor: NUMERIC(1,0) preserva tipo NUMERIC em this_n* (task017)

Colunas NUMERIC(1,0) usadas como flag (0/1) no SQL Server chegam como NUMERIC no cursor VFP9. Se o gerador escreve o ramo ELSE generico `THIS.this_nXxx = (NVL(col, 0) = 1)`, o tipo vira LOGICAL (`.T.`/`.F.`), e qualquer comparacao posterior com numero (ex: `(this_nXxx = 1)` em BOParaForm) dispara "Operator/operand type mismatch".

```foxpro
*-- ERRADO: sempre converte para LOGICAL, mesmo quando coluna ja eh numerica
IF VARTYPE(obgFator) = "L"
    THIS.this_nObrigFator = obgFator                        && LOGICAL em prop numerica!
ELSE
    THIS.this_nObrigFator = (NVL(obgFator, 0) = 1)          && LOGICAL em prop numerica!
ENDIF
```

```foxpro
*-- CORRETO: preserva NUMERIC; converte LOGICAL para 0/1 apenas se vier como BIT
IF VARTYPE(obgFator) = "N"
    THIS.this_nObrigFator = NVL(obgFator, 0)
ELSE
    THIS.this_nObrigFator = IIF(NVL(obgFator, .F.), 1, 0)
ENDIF
```

**Regra**: Consultar schema antes de escolher a prop:
- SQL BIT -> LOGICAL no cursor -> prop `this_l*` (LOGICAL)
- SQL NUMERIC(1,0) -> NUMERIC no cursor -> prop `this_n*` (NUMERIC)

NUNCA usar `(NVL(col, 0) = 1)` para popular prop `this_n*` - converte para LOGICAL.

## 84. Lookups FormBuscaAuxiliar: usar BINDEVENT "KeyPress" NAO "LostFocus" (task017/018)

Complementa regras #11 (BINDEVENT Valid) e #64 (lookup validar ENTER/TAB). Especifico para lookups que abrem FormBuscaAuxiliar.

**Bug observado**: Usuario digita valor, TAB -> LostFocus dispara -> ValidarXxx cria FormBuscaAuxiliar -> dialog abre e toma foco -> LostFocus do textbox dispara NOVAMENTE -> ValidarXxx chamado recursivamente -> segundo FormBuscaAuxiliar empilhado. Quando usuario clica "Selecionar" no primeiro, o segundo ja fechou o cursor, grade aparece vazia, campo retorna vazio.

```foxpro
*-- ERRADO: LostFocus causa recursao quando dialog toma foco
BINDEVENT(loc_oPagina.txt_4c_Codigo, "LostFocus", THIS, "ValidarCodigo")

PROCEDURE ValidarCodigo()
    loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.Value)
    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ...)
    loc_oBusca.Show()  && Show toma foco -> LostFocus do textbox -> recursao
    ...
ENDPROC
```

```foxpro
*-- CORRETO: KeyPress so dispara em tecla do usuario, nunca em mudanca de foco programatica
BINDEVENT(loc_oPagina.txt_4c_Codigo, "KeyPress", THIS, "ValidarCodigo")

PROCEDURE ValidarCodigo(par_nKeyCode, par_nShiftAltCtrl)
    *-- Dispara apenas em ENTER/TAB/F4; ignora demais teclas e navegacao programatica
    IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
        RETURN
    ENDIF

    loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.Value)
    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ...)
    loc_oBusca.Show()  && Show toma foco -> KeyPress NAO dispara (sem tecla)
    ...
ENDPROC
```

**Regra**: TODO handler `Validar*` que cria `FormBuscaAuxiliar` DEVE:
1. Estar bound como `BINDEVENT(txt, "KeyPress", THIS, "Validar*")` - NAO `"LostFocus"`
2. Aceitar parametros `(par_nKeyCode, par_nShiftAltCtrl)`
3. Retornar cedo se `par_nKeyCode` nao for ENTER(13), TAB(9) ou F4(115)

Sem isso, usuario ve grade vazia e campo em branco apos "Selecionar".

**Reforco (task022)**: O gerador continua emitindo `IF par_nKeyCode = 115` (so F4) em handlers de lookup. User digita valor e pressiona TAB ou ENTER, esperando validacao, mas nada acontece. A condicao correta inclui TODAS as 3 teclas:

```foxpro
*-- ERRADO: so F4 dispara
PROCEDURE GrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
    IF par_nKeyCode = 115
        THIS.AbrirLookupGrupo()
    ENDIF
ENDPROC
```

```foxpro
*-- CORRETO: ENTER/TAB/F4 disparam
PROCEDURE GrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
    IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
        THIS.AbrirLookupGrupo()
    ENDIF
ENDPROC
```

CorretorAutomatico #85 detecta `IF par_nKeyCode = 115` isolado em handler que chama `FormBuscaAuxiliar` ou `AbrirLookup*` e expande para a condicao com 3 teclas.

## 85. ALLTRIM() em campo numerico gera "Function argument" error (task018)

ALLTRIM() exige string. Se aplicado a `.Value` numerico (ex: TextBox com InputMask numerico, Spinner), dispara "Function argument value, type, or count is invalid." ao clicar Salvar/validar.

```foxpro
*-- ERRADO: txt_4c_Ordems.Value = 0 (numerico); ALLTRIM falha
IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Ordems.Value))
    MsgAviso("Ordem obrigatoria")
    RETURN
ENDIF
```

```foxpro
*-- CORRETO A: comparacao direta no numerico
IF loc_oPg2.txt_4c_Ordems.Value = 0
    MsgAviso("Ordem obrigatoria")
    RETURN
ENDIF

*-- CORRETO B: TRANSFORM antes de ALLTRIM (quando precisa string)
loc_cValor = ALLTRIM(TRANSFORM(loc_oPg2.txt_4c_Ordems.Value))
```

**Regra**: Se o controle tem `.Value = 0/numeric` no AddObject ou `InputMask = "9..."` -> e numerico. Nunca passar direto para ALLTRIM. TRANSFORM converte qualquer tipo para string de forma segura.

## 86. cnt_4c_Saida e cmd_4c_Encerrar: dimensoes canonicas (task018)

Referencia: `FormCor.prg`. O container e o botao Encerrar devem ter dimensoes que mantenham o botao com as mesmas medidas dos CRUD (Width=75, Height=75), para que o conjunto fique visualmente uniforme.

```foxpro
*-- CORRETO - padrao FormCor/FormMoe
loc_oPagina.AddObject("cnt_4c_Saida", "Container")
WITH loc_oPagina.cnt_4c_Saida
    .Top         = 29
    .Left        = 917
    .Width       = 90
    .Height      = 85
    .BackStyle   = 0
    .BorderWidth = 0
ENDWITH

loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
    .Caption         = "Encerrar"
    .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
    .PicturePosition = 13
    .Top             = 5
    .Left            = 5
    .Width           = 75
    .Height          = 75
    ...
ENDWITH
```

**Valores a EVITAR** (gerador antigo): `cnt_4c_Saida` com Left=935/Width=60, botao Width=50 - Encerrar fica visivelmente menor que CRUD.

## 87. cnt_4c_Botoes.Left=542 em forms 1000px — NAO copiar Left=343 do legado (task019)

Forms VFP9 legados tipicamente tem Width=770, e o container de botoes CRUD (`Grupo_op` no SCX) usa `Left=343`. O form migrado tem Width=1000. Copiar `Left=343` direto faz os botoes ficarem no meio do form, com grande espaco vazio a direita antes do Encerrar.

```foxpro
*-- ERRADO: Left=343 copiado do legado 770px
loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
WITH loc_oPagina.cnt_4c_Botoes
    .Top         = 29
    .Left        = 343        && coordenada LEGACY 770px - NO NOVO 1000px fica centralizado
    .Width       = 390
    .Height      = 85
ENDWITH
```

```foxpro
*-- CORRETO: Left=542 no form 1000px (padrao FormCor/FormMoe)
loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
WITH loc_oPagina.cnt_4c_Botoes
    .Top         = 29
    .Left        = 542        && direita: ends em 932 (deixa 917-995 para cnt_4c_Saida)
    .Width       = 390
    .Height      = 85
ENDWITH
```

**Regra**: Em forms `frmcadastro` migrados (Width=1000), `cnt_4c_Botoes.Left` DEVE ser `542`. NAO copiar `Grupo_op.Left` direto do SCX — o legado tinha form 770px; o migrado tem 1000px. Formula: `Left = FormWidth - CntBotoesWidth - 68 = 1000 - 390 - 68 = 542`.

## 88. Page1.Picture + Page2.Picture obrigatorios em frmcadastro (task019)

Em forms `frmcadastro` migrados, o fundo visual padrao nao vem do Form.BackColor — vem da propriedade `Picture` de cada Page do PageFrame principal. Se `ConfigurarPageFrame` define apenas `Caption` e `BackColor` sem `Picture`, Page1 e Page2 ficam totalmente brancas, sem o fundo grafico padrao do framework (fundo_cad_1003.jpg).

```foxpro
*-- ERRADO: Paginas ficam brancas sem fundo grafico
PROTECTED PROCEDURE ConfigurarPageFrame()
    THIS.AddObject("pgf_4c_Paginas", "PageFrame")
    WITH THIS.pgf_4c_Paginas
        .PageCount = 2
        .Top       = -29
        .Tabs      = .F.
        .Page1.Caption   = "Lista"
        .Page1.BackColor = RGB(255, 255, 255)    && fundo branco - SEM imagem
        .Page2.Caption   = "Dados"
        .Page2.BackColor = RGB(255, 255, 255)
    ENDWITH
ENDPROC
```

```foxpro
*-- CORRETO: Page.Picture fornece o fundo padrao do framework
PROTECTED PROCEDURE ConfigurarPageFrame()
    THIS.AddObject("pgf_4c_Paginas", "PageFrame")
    WITH THIS.pgf_4c_Paginas
        .PageCount = 2
        .Top       = -29
        .Tabs      = .F.
        .Page1.Caption   = "Lista"
        .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        .Page1.BackColor = RGB(255, 255, 255)
        .Page2.Caption   = "Dados"
        .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        .Page2.BackColor = RGB(255, 255, 255)
    ENDWITH
ENDPROC
```

**Regra**: TODO `ConfigurarPageFrame` em forms `frmcadastro` (C:\4c\projeto\app\forms\cadastros\) DEVE setar `.Page1.Picture` E `.Page2.Picture` apontando para `gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"`. Referencia: `FormCor.prg:98-103`.

## 89. cnt_4c_Sombra/cnt_4c_Cabecalho.Width = THIS.Width (task019)

O container do header escuro (`cnt_4c_Sombra` ou `cnt_4c_Cabecalho`) DEVE ocupar a largura TOTAL do form. O container do botao Encerrar (`cnt_4c_Saida`) eh transparente (`BackStyle = 0`) e fica POR CIMA do header — o fundo escuro precisa estender por baixo dele ate a borda direita do form.

```foxpro
*-- ERRADO: gerador deixa 60px a direita achando que precisa poupar espaco para o Encerrar
loc_oPagina.AddObject("cnt_4c_Sombra", "Container")
WITH loc_oPagina.cnt_4c_Sombra
    .Top         = 31
    .Left        = 0
    .Width       = THIS.Width - 60     && 940 em form 1000px — faixa clara a direita
    .Height      = 80
    .BackColor   = RGB(53, 53, 53)
ENDWITH
```

```foxpro
*-- CORRETO: largura total do form; cnt_4c_Saida fica por cima (transparente)
loc_oPagina.AddObject("cnt_4c_Sombra", "Container")
WITH loc_oPagina.cnt_4c_Sombra
    .Top         = 31
    .Left        = 0
    .Width       = THIS.Width          && 1000 — cobre toda a largura
    .Height      = 80
    .BackColor   = RGB(53, 53, 53)
ENDWITH
```

**Regra**: Em forms `frmcadastro`, `cnt_4c_Sombra.Width` (ou `cnt_4c_Cabecalho.Width`) DEVE ser `THIS.Width` (ou valor >= Form.Width, como 1020 em FormCor). NUNCA `THIS.Width - N` para "abrir espaco" para o Encerrar — o container do Encerrar e transparente e precisa do fundo escuro POR BAIXO.

## 90. MsgAviso para validacao UI, MsgErro APENAS para exceptions tecnicas (task020)

`MostrarErro`/`MsgErro` exibe dialog vermelho com icone X + botao "Fechar Aplicacao". Usado para validacao de pre-condicao (ex: "Selecione um registro na lista"), o usuario interpreta como crash fatal e pode fechar a aplicacao por engano.

**Regra de escolha**:
- `MsgAviso(msg)` — validacao de UI, orientacao ao usuario: "Selecione...", "Informe...", "Escolha...", "Campo obrigatorio", "Valor invalido", "Ja cadastrado", "Deve conter pelo menos X caracteres".
- `MsgErro(msg)` / `MostrarErro(msg, titulo)` — SOMENTE exceptions tecnicas: CATCH blocks ("Erro ao inserir: " + loException.Message), falhas de SQL (CapturarErroSQL), conexao perdida, arquivo/recurso inexistente.

```foxpro
*-- ERRADO: validacao de selecao usando MostrarErro (dialog vermelho assustador)
PROCEDURE BtnAlterarClick()
    IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
        MostrarErro("Selecione um registro na lista.", "")   && user acha que travou
        RETURN
    ENDIF
    ...
ENDPROC
```

```foxpro
*-- CORRETO: MsgAviso amarelo para orientar o usuario
PROCEDURE BtnAlterarClick()
    IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
        MsgAviso("Selecione um registro na lista.")
        RETURN
    ENDIF
    ...
ENDPROC

PROCEDURE Inserir()
    TRY
        SQLEXEC(...)
    CATCH TO loException
        MostrarErro("Erro ao inserir: " + loException.Message, "Erro")   && OK — exception real
    ENDTRY
ENDPROC
```

**Heuristica de deteccao**: se a primeira palavra da mensagem for imperativa ("Selecione", "Informe", "Escolha", "Digite") ou se a mensagem terminar em "obrigat*" ou "inv" (invalido/invalida) ou contiver "Ja cadastrado" -> use `MsgAviso`. Se comeca com "Erro ao...", "Falha ao...", contem `loException.Message` ou `CapturarErroSQL()` -> `MsgErro`/`MostrarErro`.

## 91. Grid.ColumnCount DEVE ser setado antes de cada RecordSource em CarregarLista (task021)

Sempre que `grd.RecordSource = "cursor_..."` for definido, o Grid reseta suas colunas e, se `ColumnCount` nao estiver setado com valor explicito, auto-expande para TODAS as colunas do cursor. Se o cursor tem mais campos que queremos exibir (ex: cursor com 10 colunas para grid que deve mostrar 3), o grid vira uma bagunca com 10 colunas e headers duplicados/estranhos.

```foxpro
*-- ERRADO: RecordSource sem ColumnCount explicito antes
PROCEDURE CarregarLista()
    IF THIS.this_oBusinessObject.Buscar("")
        loc_oGrid.RecordSource = "cursor_4c_Dados"   && cursor tem 10 campos
        loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.datas"
        loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.desvends"
        loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.cods"
        * Grid auto-expandiu para 10 colunas. Headers extras aparecem.
    ENDIF
ENDPROC
```

```foxpro
*-- CORRETO: ColumnCount=N DEVE preceder RecordSource
PROCEDURE CarregarLista()
    IF THIS.this_oBusinessObject.Buscar("")
        loc_oGrid.ColumnCount = 3                    && reset das colunas visuais
        loc_oGrid.RecordSource = "cursor_4c_Dados"   && bind agora respeita 3 colunas
        loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.datas"
        loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.desvends"
        loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.cods"
    ENDIF
ENDPROC
```

**Regra**: TODA chamada `grd.RecordSource = "..."` DEVE ter `grd.ColumnCount = N` na linha imediatamente anterior, onde N corresponde ao numero de colunas `.ColumnX.ControlSource` que configuramos depois. Vale para CarregarLista, ExecutarBusca, e qualquer outro refresh de grid que muda RecordSource.

**Relacao com regra #43**: A #43 proibe resetar `ColumnCount` destrutivamente em CarregarLista (ex: setar para zero e depois subir). Esta regra (#91) especifica que ColumnCount deve estar definido no valor esperado ANTES do RecordSource — e que isso eh um set, nao um reset.

## 92. loc_oPagina.Picture em ConfigurarPaginaLista/Dados (task021)

Complementa regra #88. Alguns forms usam metodos separados para configurar cada pagina:
- `ConfigurarPaginaLista()` comeca com `loc_oPagina = THIS.pgf_4c_Paginas.Page1`
- `ConfigurarPaginaDados()` comeca com `loc_oPagina = THIS.pgf_4c_Paginas.Page2`

Nesses casos, o fundo NAO esta no WITH block de ConfigurarPageFrame — precisa ser setado explicitamente em cada metodo via `loc_oPagina.Picture = ...`. Se um dos metodos esquece, a respectiva pagina fica totalmente branca.

```foxpro
*-- ERRADO: ConfigurarPaginaDados sem Picture — Page2 branca
PROTECTED PROCEDURE ConfigurarPaginaDados()
    LOCAL loc_oPagina, loc_cIcones
    loc_oPagina = THIS.pgf_4c_Paginas.Page2
    loc_cIcones = gc_4c_CaminhoIcones

    *-- Container botoes Confirmar/Cancelar
    loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
    ...
```

```foxpro
*-- CORRETO: Picture setado antes de qualquer AddObject
PROTECTED PROCEDURE ConfigurarPaginaDados()
    LOCAL loc_oPagina, loc_cIcones
    loc_oPagina = THIS.pgf_4c_Paginas.Page2
    loc_cIcones = gc_4c_CaminhoIcones

    *-- Fundo padrao do framework frmcadastro (sem isso Page2 fica totalmente branca)
    loc_oPagina.Picture = loc_cIcones + "fundo_cad_1003.jpg"

    *-- Container botoes Confirmar/Cancelar
    loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
    ...
```

**Regra**: TODO metodo `ConfigurarPagina*` (ou similar que assina `loc_oPagina = THIS.pgf_4c_Paginas.PageN`) DEVE setar `loc_oPagina.Picture = ... "fundo_cad_1003.jpg"` ANTES do primeiro `AddObject`.

## 93. FormParaBO deve popular TODAS as props usadas em Inserir/Atualizar (task021)

`FormParaBO` que so popula props ligadas a controles visiveis deixa os demais campos (data, empresa, GUID, flags auto) chegarem vazios no `Inserir()`. O SQL grava NULL ou default, e o usuario percebe depois (registro sem data, sem empresa, etc.).

```foxpro
*-- ERRADO: so popula o campo visivel; data e empresa chegam vazias
PROTECTED PROCEDURE FormParaBO()
    LOCAL loc_oPg2
    loc_oPg2 = THIS.pgf_4c_Paginas.Page2

    IF PEMSTATUS(loc_oPg2, "txt_4c_Conta", 5)
        THIS.this_oBusinessObject.this_cVends = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)
    ENDIF
    *-- this_dDatas, this_cEmps nunca populados -> NULL no Insert
ENDPROC
```

```foxpro
*-- CORRETO: popula campos visiveis + auto-preenche campos de sistema
PROTECTED PROCEDURE FormParaBO()
    LOCAL loc_oPg2
    loc_oPg2 = THIS.pgf_4c_Paginas.Page2

    IF PEMSTATUS(loc_oPg2, "txt_4c_Conta", 5)
        THIS.this_oBusinessObject.this_cVends = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)
    ENDIF

    *-- Campos auto-gerados apenas em INCLUIR (em ALTERAR preservar CarregarDoCursor)
    IF THIS.this_cModoAtual == "INCLUIR"
        IF EMPTY(THIS.this_oBusinessObject.this_dDatas)
            THIS.this_oBusinessObject.this_dDatas = DATE()
        ENDIF
        IF EMPTY(THIS.this_oBusinessObject.this_cEmps)
            THIS.this_oBusinessObject.this_cEmps = go_4c_Sistema.cCodEmpresa
        ENDIF
    ENDIF
ENDPROC
```

**Regra**: Auditar cada `PROCEDURE Inserir()` (e Atualizar) - listar todas as props `THIS.this_[cdn]\w+` referenciadas. Confirmar que TODAS aparecem em `FormParaBO()` (direto do form OU atribuidas com default em INCLUIR). Campos de sistema comuns:
- `this_dDatas`, `this_dDtInc`, `this_dDtAlt` -> `DATE()` ou `DATETIME()`
- `this_cEmps`, `this_cCodEmpresa` -> `go_4c_Sistema.cCodEmpresa`
- `this_cUsuars`, `this_cUsuario` -> `gc_4c_UsuarioLogado`
- `this_cCidChaves`, chaves GUID -> geradas em Inserir via `SYS(2015)` ou funcao equivalente

## 94. Cursor index: usar TAG por coluna, NAO TAG unico "ordem" (task021)

Quando o BO popula cursor e o form precisa alterar ordenacao em runtime (ex: OptionGroup "Ordenar por: Base/Nivel2/Nivel3/Nivel4"), o form chama `SET ORDER TO TAG <nome>` com o nome da coluna escolhida. Para isso funcionar, o BO DEVE criar um TAG por coluna, com o nome da coluna como nome do tag.

```foxpro
*-- ERRADO: nome de tag generico. Segundo INDEX destroi o primeiro porque o tag eh o mesmo.
SELECT cursor_4c_Localizacoes
DO CASE
CASE par_nOrdem = 2
    loc_cOrdem = "Nivel2s"
CASE par_nOrdem = 3
    loc_cOrdem = "Nivel3s"
CASE par_nOrdem = 4
    loc_cOrdem = "Nivel4s"
OTHERWISE
    loc_cOrdem = "Locals"
ENDCASE
INDEX ON &loc_cOrdem TAG ordem IN cursor_4c_Localizacoes    && TAG unico "ordem"

*-- No form, depois: SET ORDER TO TAG Locals -> ERRO "Tag Locals nao encontrado"
```

```foxpro
*-- CORRETO: um TAG por coluna; form pode trocar ordem sem repopular
SELECT cursor_4c_Localizacoes
INDEX ON Locals  TAG Locals
INDEX ON Nivel2s TAG Nivel2s
INDEX ON Nivel3s TAG Nivel3s
INDEX ON Nivel4s TAG Nivel4s

*-- Ordem inicial
DO CASE
CASE par_nOrdem = 2
    SET ORDER TO TAG Nivel2s IN cursor_4c_Localizacoes
CASE par_nOrdem = 3
    SET ORDER TO TAG Nivel3s IN cursor_4c_Localizacoes
CASE par_nOrdem = 4
    SET ORDER TO TAG Nivel4s IN cursor_4c_Localizacoes
OTHERWISE
    SET ORDER TO TAG Locals IN cursor_4c_Localizacoes
ENDCASE
GO TOP IN cursor_4c_Localizacoes
```

**Regra**: Se o form faz `SET ORDER TO TAG <nome>` (para N nomes distintos), o BO DEVE criar N tags com esses nomes exatos. Auditoria via grep cruzado:
- Form: `grep 'SET ORDER TO TAG' FormXxx.prg` -> lista de nomes usados
- BO: `grep 'INDEX ON .* TAG' XxxBO.prg` -> lista de tags criados
- Nomes no form ausentes no BO = bugs ("Tag not found" em runtime).

## 95. Campos auto-preenchidos NAO devem ser ReadOnly/Enabled=.F. no AddObject (task021)

Quando um TextBox e auto-preenchido em certos fluxos (ex: Valid event que faz SEEK e copia valor de outro cursor, ou clique em grid que popula campos relacionados), o gerador frequentemente interpreta como "display only" e cria o AddObject com `.ReadOnly = .T.` + `.Enabled = .F.`. Isso bloqueia completamente a digitacao e torna o campo inutilizavel.

```foxpro
*-- ERRADO: campo bloqueado, user nao consegue digitar
loc_oPagina.AddObject("txt_4c_Base", "TextBox")
WITH loc_oPagina.txt_4c_Base
    .Value    = ""
    .Top      = 216
    .Left     = 667
    .Width    = 54
    .Height   = 24
    .ReadOnly = .T.    && bloqueia edicao
    .Enabled  = .F.    && redundante + bloqueia ainda mais
    .Visible  = .T.
ENDWITH
```

```foxpro
*-- CORRETO: campo editavel; HabilitarCampos controla o Enabled por modo
loc_oPagina.AddObject("txt_4c_Base", "TextBox")
WITH loc_oPagina.txt_4c_Base
    .Value     = ""
    .Top       = 216
    .Left      = 667
    .Width     = 54
    .Height    = 24
    .MaxLength = 2     && se o campo tem tamanho fixo, usar MaxLength
    .Enabled   = .F.   && Enabled inicial OK (HabilitarCampos habilita em INCLUIR/ALTERAR)
    .Visible   = .T.
ENDWITH

*-- Em HabilitarCampos(par_lHabilitar):
IF PEMSTATUS(loc_oPg2, "txt_4c_Base", 5)
    loc_oPg2.txt_4c_Base.Enabled = par_lHabilitar
ENDIF
```

**Regra**: No AddObject de TextBox, NUNCA setar `.ReadOnly = .T.` a menos que o SCX legado tenha essa propriedade explicita. Comentarios como "preenchido ao selecionar linha no grid" descrevem UMA das formas de popular o campo, nao significa que esta bloqueado a edicao manual. Se o campo precisa ser desabilitado em modo VISUALIZAR, isso eh trabalho do `HabilitarCampos(.F.)`, nao do AddObject.

## 96. Forms 1-N com grid secundario: cursor vazio em BtnIncluirClick (task021)

Forms CRUD que tem grid secundario (ex: header de contagem + grid de itens contados por localizacao) populam esse grid em modo VISUALIZAR/ALTERAR via metodo tipo `CarregarItens` ou `CarregarLocalizacoes`. Mas em modo INCLUIR, esse cursor NAO e populado automaticamente - user clica Incluir, Page2 abre, mas nao consegue adicionar itens porque o cursor do grid secundario nao existe.

```foxpro
*-- ERRADO: BtnIncluirClick sem cursor vazio -> grid secundario inerte
PROCEDURE BtnIncluirClick()
    THIS.this_oBusinessObject.NovoRegistro()
    THIS.this_cModoAtual = "INCLUIR"
    THIS.LimparCampos()
    THIS.HabilitarCampos(.T.)
    THIS.AlternarPagina(2)
    *-- cursor_4c_Localizacoes NAO existe -> user nao consegue adicionar
ENDPROC
```

```foxpro
*-- CORRETO: criar cursor vazio com mesma estrutura + tags usados no form
PROCEDURE BtnIncluirClick()
    THIS.this_oBusinessObject.NovoRegistro()

    *-- Cursor secundario vazio (mesma estrutura do SELECT do BO)
    IF USED("cursor_4c_Localizacoes")
        USE IN cursor_4c_Localizacoes
    ENDIF
    CREATE CURSOR cursor_4c_Localizacoes ( ;
        Locals C(9), qtde N(9,0), QtdCtg N(5,0), ;
        Nivel1s C(2), Nivel2s C(2), Nivel3s C(2), Nivel4s C(3))
    INDEX ON Locals  TAG Locals
    INDEX ON Nivel2s TAG Nivel2s
    INDEX ON Nivel3s TAG Nivel3s
    INDEX ON Nivel4s TAG Nivel4s

    THIS.this_cModoAtual = "INCLUIR"
    THIS.LimparCampos()
    THIS.HabilitarCampos(.T.)
    THIS.AlternarPagina(2)
    THIS.ConfigurarGrdDados()        && bind do grid no cursor vazio
ENDPROC
```

**Regra**: Forms CRUD com grid secundario DEVEM criar o cursor vazio em `BtnIncluirClick` antes de `AlternarPagina(2)`. Estrutura do cursor: MESMAS colunas que o BO retorna no SELECT do metodo de carga (nomes e tipos). Tags: criar TODOS os tags que o form usa em `SET ORDER TO TAG <nome>` (regra #94 complementa). Depois chamar `ConfigurarGrdDados()` para fazer bind do grid.

## 97. OptionGroup.Width deve acomodar Buttons(N).Left + Width + margem (task022)

Complementa regra do complemento de #49 (BackStyle=0 em OptionButtons) e patterns #60/#86 (BackStyle management).

Quando expandimos o Width de um `Buttons(N)` dentro de OptionGroup (ex: para caber caption com acentos via CHR como `"N" + CHR(227) + "o"`), o CONTAINER OptionGroup tambem precisa crescer. OptionGroup com `BorderStyle=0` nao desenha borda visual mas AINDA clipa conteudo: qualquer pixel alem de `OptionGroup.Width` fica invisivel.

```foxpro
*-- ERRADO: container Width=100, mas botao "Nao" ocupa Left=72 + Width=60 = 132 (clipa)
loc_oPagina.AddObject("obj_4c_Opcaocontab", "OptionGroup")
WITH loc_oPagina.obj_4c_Opcaocontab
    .ButtonCount = 2
    .Width       = 100       && copiado do SCX legado onde buttons eram menores
    .BorderStyle = 0
ENDWITH
WITH loc_oPagina.obj_4c_Opcaocontab.Buttons(2)
    .Caption   = "N" + CHR(227) + "o"
    .Left      = 72
    .Width     = 60          && expandimos para caber caption — mas agora extrapola
ENDWITH
```

```foxpro
*-- CORRETO: container Width >= max(Left+Width) dos buttons + margem de 10
loc_oPagina.AddObject("obj_4c_Opcaocontab", "OptionGroup")
WITH loc_oPagina.obj_4c_Opcaocontab
    .ButtonCount = 2
    .Width       = 140       && max(72+60) + 8 = 140 (margem)
    .BorderStyle = 0
ENDWITH
```

**Regra**: Ao gerar OptionGroup, calcular `container.Width >= MAX(Buttons[i].Left + Buttons[i].Width) + 10`. NAO copiar cegamente do SCX legado — se algum button foi expandido (ex: para CHR codes acentuados), o container precisa crescer proporcionalmente.

Recomendacao: tambem usar `.AutoSize = .F.` nos Buttons (AutoSize em VFP9 pode calcular largura aquem com fontes acentuadas).

CorretorAutomatico #87 calcula e ajusta container automaticamente.

## 98. Padrao Canonico Saida/Encerrar — PREVALECE sobre PILAR 1 (tasks 016-022)

### Contexto

Tasks 016-022 evidenciaram que o gerador continua copiando **pixel-perfect do SCX legado** os valores do bloco de saida (container `Grupo_Saida` + botao X), mesmo com as regras individuais ja presentes nos prompts e no CorretorAutomatico. Isso acontece porque o PILAR 1 (pixel-perfect legado) conflita com o padrao canonico estabelecido por `FormCor`/`FormMoe` para esse bloco — e sem uma regra de precedencia explicita, o modelo oscila.

### A regra

O bloco de saida do form CRUD migrado usa o **padrao canonico do sistema novo**, NAO o SCX legado. Esta regra **prevalece sobre o PILAR 1** para este bloco.

### Valores canonicos (inegociaveis)

```foxpro
*-- Container de saida (padrao FormCor)
loc_oPagina.AddObject("cnt_4c_Saida", "Container")
WITH loc_oPagina.cnt_4c_Saida
    .Left      = 917    && NAO 935 (legado), NAO 945+, NAO THIS.Width - 60
    .Top       = 29     && compensa PageFrame.Top=-29
    .Width     = 90     && NAO 60 (legado), NAO menos
    .Height    = 85
    .BackStyle = 0      && transparente (fundo vem da Page.Picture)
ENDWITH

*-- Botao Encerrar (mesmas dimensoes dos botoes CRUD)
WITH loc_oPagina.cnt_4c_Saida
    .AddObject("cmd_4c_Encerrar", "CommandButton")
ENDWITH
WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
    .Left    = 5
    .Top     = 5
    .Width   = 75       && NAO 50 (legado)
    .Height  = 75
    .Caption = "Encerrar"    && NAO "X", NAO "Sair", NAO "Fechar", NAO ""
    .Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
    .Themes  = .F.
ENDWITH
```

### Containers de Page (nunca subtrair largura por causa do Encerrar)

Containers filhos diretos de `Page1`/`Page2` (header, shadow, content) DEVEM usar `.Width = THIS.Width` — NUNCA `THIS.Width - 60` achando que precisam "deixar espaco" para o botao Encerrar. O `cnt_4c_Saida` eh flutuante/transparente **por cima** da Page, nao ocupa area dela. A subtracao so deixa uma faixa clara visivel a direita expondo o fundo nativo do form.

```foxpro
*-- ERRADO (deixa faixa clara a direita)
.Width = THIS.Width - 60

*-- CORRETO (cobre toda a largura)
.Width = THIS.Width
```

### Por que o PILAR 1 NAO se aplica aqui

O SCX legado foi desenhado para um form de **770px** com um "botao X" de 50px dentro de um container `Grupo_Saida` compacto de 60px. O sistema novo padroniza forms CRUD em **1000px** com o Encerrar tendo as mesmas dimensoes 75x75 dos demais botoes CRUD (Incluir/Alterar/Visualizar/Excluir). Copiar o SCX legado quebra a harmonia visual com o restante da UI — o Encerrar fica visualmente menor que os outros botoes.

### Exemplo de migracao (CAPTION="X" -> "Encerrar")

```foxpro
*-- SCX legado (ignorar)
ADD OBJECT cmdSair AS commandbutton WITH ;
    Left=0, Top=0, Width=50, Height=50, ;
    Caption="X", ;      && wingdings "X" visual
    FontName="Wingdings", FontSize=20

*-- Migrado (padrao canonico)
WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
    .Left    = 5
    .Top     = 5
    .Width   = 75
    .Height  = 75
    .Caption = "Encerrar"
    .Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
ENDWITH
```

### Auto-fix (seguranca)

CorretorAutomatico patterns aplicados em cascata:
- **#74** (ampliado): BINDEVENT LostFocus em handler de lookup -> KeyPress (detecta por nome contendo "Lookup"/"Validar" mesmo sem CREATEOBJECT no mesmo escopo).
- **#81**: `cnt_4c_Saida` exato normalizado para Left=917, W=90; `cmd_4c_Encerrar` para W=75, H=75.
- **#88**: `.Width = THIS.Width - 60/-65/-70` em Page container -> `THIS.Width` (apenas em forms CRUD).
- **#89**: Botao generico de saida (`cmd_4c_Sair`/`cmd_4c_Fechar`/`cmd_4c_Cancelar`/`cmd_4c_X`) com Caption "X"/"Sair"/"Fechar"/"Cancelar" -> Caption="Encerrar", W=75, H=75. Preserva nome do objeto para nao quebrar referencias.

### Checklist mental ao migrar

1. Ver o bloco `Grupo_Saida` no SCX legado? **Nao copiar as dimensoes** — usar canonico.
2. Ver `cmdSair` / `cmdX` / botao de saida com Caption != "Encerrar"? **Trocar Caption para "Encerrar"**.
3. Escrever `.Width = THIS.Width - 60`? **Substituir por `THIS.Width`**.
4. Duvidas de espacamento? Consultar `FormCor` ou `docs/framework_frmcadastro_layout.md`.

## 99. VFP9 gotchas: PUBLIC em DEFINE CLASS, Page.Width, MostrarAviso (task016)

Tres erros descobertos na migração do task016 (SigCdCol) que precisam estar nos prompts porque custaram retries caros:

### 99.1 `PUBLIC FUNCTION`/`PUBLIC PROCEDURE` em `DEFINE CLASS` = SYNTAX ERROR

```foxpro
*-- ERRADO — "Statement is not valid in a class definition"
DEFINE CLASS ColBO AS BusinessBase
    PUBLIC FUNCTION Buscar(par_cFiltro)    && <-- PUBLIC nao eh modifier valido
        ...
    ENDFUNC
ENDDEFINE

*-- CORRETO — metodos sao PUBLIC por default
DEFINE CLASS ColBO AS BusinessBase
    FUNCTION Buscar(par_cFiltro)
        ...
    ENDFUNC
ENDDEFINE

*-- Modifiers validos em DEFINE CLASS: PROTECTED, HIDDEN (NUNCA PUBLIC)
PROTECTED PROCEDURE CarregarLista()
HIDDEN FUNCTION CalcularInterno()
```

### 99.2 `Page.Width` / `Page.Height` READ-ONLY em runtime

```foxpro
*-- ERRADO — "CREATEOBJECT retornou valor nao-objeto" na instanciacao
WITH loc_oPage   && Page eh THIS.pgf_4c_Paginas.Page1
    .Width  = THIS.Width     && <-- Page.Width nao eh settable
    .Height = THIS.Height
ENDWITH

*-- CORRETO — PageFrame controla Width/Height das Pages automaticamente
*-- Se precisa cobrir area, usar containers FILHOS da Page:
loc_oPage.AddObject("cnt_4c_Conteudo", "Container")
WITH loc_oPage.cnt_4c_Conteudo
    .Left   = 0
    .Top    = 29    && compensacao PageFrame.Top=-29
    .Width  = 1000  && fixo ou THIS.Width do form pai
    .Height = 500
ENDWITH
```

### 99.3 `MostrarAviso` NAO EXISTE

```foxpro
*-- ERRADO — "File 'mostraraviso.prg' does not exist" em runtime
IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Colecoes.Value))
    MostrarAviso("Grupo invalido.", "")    && <-- MostrarAviso nao existe
    RETURN
ENDIF

*-- CORRETO — usar MsgAviso para validacao de UI (dialog amarelo)
IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Colecoes.Value))
    MsgAviso("Grupo invalido.", "")
    RETURN
ENDIF
```

**Tabela de funcoes de mensagem (definitiva):**

| Funcao | Definida em | Uso | Dialog |
|---|---|---|---|
| `MsgInfo(msg, titulo)` | messages.prg | Informativo | Azul |
| `MsgAviso(msg, titulo)` | messages.prg | Validacao UI | Amarelo |
| `MsgErro(msg, titulo)` | messages.prg | Exception tecnica leve | Vermelho |
| `MsgConfirma(msg, titulo)` | messages.prg | Sim/Nao | Azul |
| `MostrarErro(msg, titulo)` | FormErro.prg | Exception tecnica grave (com "Fechar Aplicacao") | Vermelho |
| `MostrarAviso` | **NAO EXISTE** | — | — |
| `MessageBox(...)` | **PROIBIDO** | — | — |

## 100. SQLEXEC em cursor de grid sem fechar antes — "uncommitted changes" (task016)

### Problema

Em `BO.Buscar()` / `BO.CarregarPorCodigo()`, executar `SQLEXEC(handle, sql, "cursor_4c_Dados")` quando o form usa `cursor_4c_Dados` como `grd.RecordSource`:

```
Erro em: ColBO.Buscar
Linha: 53
Table buffer for alias "CURSOR_4C_DADOS" contains uncommitted changes.
```

Acontece na **segunda** chamada (primeira cria o cursor limpo; segunda o cursor ja existe com buffer possivelmente alterado pelo grid).

### Fix obrigatorio

Antes de `SQLEXEC`, fechar o cursor anterior:

```foxpro
FUNCTION Buscar(par_cFiltro)
    LOCAL loc_cSQL, loc_nResult, loc_lSucesso
    loc_lSucesso = .F.

    TRY
        loc_cSQL = "SELECT ... FROM SigCdCol ORDER BY colecoes"

        *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
        IF USED("cursor_4c_Dados")
            TABLEREVERT(.T., "cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
        ...
    CATCH TO loException
        MostrarErro(loException, "ColBO.Buscar")
    ENDTRY

    RETURN loc_lSucesso
ENDFUNC
```

### Auto-fix

CorretorAutomatico #91 (`Corrigir-SQLExecCursorGuard`) detecta `SQLEXEC(...,"cursor_4c_Xxx")` em BOs e injeta o guard automaticamente.
