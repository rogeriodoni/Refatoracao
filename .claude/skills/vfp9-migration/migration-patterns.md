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
- LostFocus ? MontaGrade ? Grid.Refresh/SetFocus ? LostFocus ? MontaGrade ? ...

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

VFP9 `AddObject` recebe dois parametros STRING: `parent.AddObject(cNome, cClasse)`. NUNCA passar um objeto pre-criado com CREATEOBJECT como primeiro parametro � causa "Function argument value, type, or count is invalid".

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

Quando um Grid usa `.Column1.CurrentControl = "Check1"`, o CheckBox DEVE ser adicionado a Column ANTES. Grids criados via AddObject tem apenas Header1 e Text1 por padrao � Check1 NAO existe ate ser criado explicitamente.

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

IMPACTO: Este erro e especialmente perigoso porque ocorre dentro de TRY/CATCH e cascateia silenciosamente � destruindo TODOS os controles criados APOS o grid (OptionGroups, CheckBoxes, BINDEVENTs).

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

Isso e corrigido automaticamente pelo CorretorAutomatico (pattern #46). O alias fica selecionado como workarea ativa apos o SELECT � se necessario, restaurar o alias original com SELECT (loc_cAliasAnterior).

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
loc_oGrid.ColumnCount = 3  && DESTROI colunas ? auto-bind ? "Variable 'cods' is not found"
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

**Regra**: Labels no cabe�alho escuro (cnt_4c_Cabecalho com BackColor=53,53,53) = branco. Labels em Page2 com imagem de fundo = preto. Copiar posicoes/tamanhos EXATOS do original (Say1.Left, Say1.Top, etc).

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
*-- ERRADO: destr�i colunas a cada chamada
PROCEDURE CarregarLista()
    loc_oGrid.RecordSource = "cursor_4c_Dados"
    loc_oGrid.ColumnCount = 3
    loc_oGrid.Column1.ControlSource = ...  && reconfigura tudo

*-- CORRETO: configurar UMA VEZ, depois s� refresh
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
    .BackColor   = RGB(100, 100, 100)
    .FontName    = "Tahoma"      && ERRO: "Property FONTNAME is not found"
    .FontSize    = 8             && nunca executa (cascata do erro acima)
    .Buttons(1).Caption = "OK"   && nunca executa ? botao fica "Command1"

*-- CORRETO: FontName em cada Button
WITH loc_oPagina.grp_4c_Operacao
    .ButtonCount = 2
    .BackColor   = RGB(100, 100, 100)
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
    .BackColor   = RGB(100, 100, 100)        && BLOCO ESCURO que nao existia!
    .Buttons(1).BackColor = RGB(100, 100, 100)

*-- CORRETO: copiar BackStyle/BorderStyle EXATOS do original
WITH par_oPagina.grp_4c_Operacao
    .BackStyle    = 0                   && TRANSPARENTE (original)
    .BorderStyle  = 0                   && SEM BORDA (original)
    .SpecialEffect = 1                  && COPIAR do original
    .Themes       = .F.
    .Buttons(1).BackColor = RGB(255,255,255)  && COPIAR do original
```

**Regra**: Copiar BackStyle, BorderStyle, SpecialEffect EXATOS do codigo fonte original. Se original tem BackStyle=0, o migrado DEVE ter BackStyle=0 � NUNCA adicionar BackColor quando original nao tem.

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
.Buttons(1).BackColor = RGB(100, 100, 100)  && Original: RGB(255,255,255)!

*-- CORRETO: copiar EXATAMENTE do codigo fonte original
.Buttons(1).Left       = 178           && EXATO do original
.Buttons(1).FontName   = "Comic Sans MS"  && EXATO do original
.Buttons(1).FontBold   = .T.           && EXATO do original
.Buttons(1).FontItalic = .T.           && EXATO do original
.Buttons(1).BackColor  = RGB(255,255,255) && EXATO do original
.Buttons(1).ForeColor  = RGB(90,90,90)    && EXATO do original
```

**Regra**: Left, Top, Width, Height, FontName, FontBold, FontItalic, BackColor, ForeColor dos Buttons(N) DEVEM ser copiados do codigo fonte original. NUNCA inventar valores default.

**Complemento OptionGroup (task022)**: OptionButton (dentro de OptionGroup) TEM BackStyle � regra diferente de CommandButton que NAO tem (patterns #59/#60 do CorretorAutomatico). Omitir `.BackStyle = 0` em OptionGroup.Buttons(N) faz o fundo opaco (default) clipar captions acentuadas:

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

**Regra**: Trocar APENAS o path (`..\\framework\\imagens\\` ? `gc_4c_CaminhoIcones +`). O nome do arquivo DEVE ser identico ao original.

## 52. Propriedades do FORM: COPIAR TODAS do original (task170)

Propriedades como TitleBar, ControlBox, MaxButton, MinButton, Closable controlam a aparencia da janela. Omiti-las faz VFP9 usar defaults que alteram completamente o visual.

```foxpro
*-- ERRADO: omitir propriedades da janela (VFP9 usa defaults)
DEFINE CLASS Formsigopind AS FormBase
    Caption    = "Individual"
    Width      = 1000
    Height     = 600
    *-- TitleBar, ControlBox, etc. AUSENTES ? barra de titulo aparece!

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
*-- ERRADO: ForeColor branco em fundo claro ? texto invisivel
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
    *-- RecordMark/DeleteMark AUSENTES ? barras de marcacao visiveis!

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

O container `cntSombra` do framework `frmcadastro` tem fundo escuro (barra de cabe�alho). Ao migrar para `cnt_4c_Cabecalho`, o pipeline gerava `BackStyle = 0` (transparente) � o cabe�alho ficava invis�vel.

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
    .BackColor   = RGB(100, 100, 100)
    .BorderWidth = 0
ENDWITH
WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
    .ForeColor = RGB(255,255,255)
ENDWITH
```

**Regra**: Em forms CRUD (frmcadastro), `cnt_4c_Cabecalho` DEVE ter `BackStyle = 1` (opaco) + `BackColor = RGB(100, 100, 100)` e `lbl_4c_Titulo.ForeColor = RGB(255,255,255)` (branco sobre escuro).

## 57. NovoRegistro()/EditarRegistro() DEVEM chamar DODEFAULT() (task001)

BOs que sobrescrevem `NovoRegistro()` ou `EditarRegistro()` sem chamar `DODEFAULT()` impedem que `BusinessBase` sete `this_lEmEdicao = .T.`. Resultado: `Salvar()` SEMPRE retorna `.F.` silenciosamente ("n�o est� em modo de edi��o").

```foxpro
*-- ERRADO: sem DODEFAULT � this_lEmEdicao fica .F. � Salvar FALHA
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

**Regra**: TODO BO que sobrescreve `NovoRegistro()` ou `EditarRegistro()` DEVE ter `DODEFAULT()` como primeira linha. Sem isso, `this_lEmEdicao` fica `.F.` e nenhuma opera��o de salvar funciona.

## 58. Bot�es CRUD Width=75 e posi��es EXATAS, Encerrar em container SEPARADO (task002)

O pipeline gerava bot�es com Width=65 e gaps de 7px entre eles. O original tem bot�es Width=75 colados (sem gap). Al�m disso, o Encerrar ficava no mesmo container dos bot�es CRUD; no original est� em `grupo_saida` separado.

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

**Regra**: Bot�es CRUD em forms `frmcadastro` DEVEM ter Width=75 e posi��es Left=5,80,155,230,305 (tocando). Encerrar/Sair DEVE estar em `cnt_4c_Saida` (container separado, Left=916, W=85).

## 59. Lookup textbox DEVE disparar em ENTER/TAB al�m de F4 (task002)

O original usa evento `Valid` que dispara quando o usu�rio sai do campo (TAB/ENTER). O pipeline gerava lookup apenas para F4 e DblClick. Se o usu�rio digitar valor e pressionar TAB, nada acontecia.

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

**Regra**: Campos com lookup (fwBuscaExt no legado) DEVEM disparar busca em F4(63) E ENTER(13)/TAB(9) no KeyPress handler. ENTER/TAB s� disparam se o campo n�o est� vazio.

## 60. Code Review CHECK 23 deve considerar ChkRegister como source de WHERE (task002)

O Code Review SQL-FILTRO-INVENTADO removeu a verifica��o `SELECT COUNT(*) FROM SigCdUsu WHERE deptos = valor` classificando 'deptos' como coluna inventada. Mas o original tinha `ChkRegister('SigCdUsu','deptos',valor)` � que � a mesma verifica��o no framework legado.

**Causa**: CHECK 23 extra�a colunas de WHERE do original via regex em SQL (WHERE/AND/OR). `ChkRegister('tabela','coluna',valor)` n�o usa WHERE expl�cito, ent�o a coluna n�o era detectada. Fix aplicado: extrair colunas do 2� par�metro de ChkRegister e adicionar � lista de colunas WHERE conhecidas.

**Regra**: Verifica��es de depend�ncia entre tabelas (ChkRegister no legado) s�o regras de neg�cio REAIS. O Code Review NUNCA deve remov�-las.

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

**Reforco (task021)**: O gerador continua emitindo `PEMSTATUS((par_cAliasCursor), "campo", 5)` dentro de `CarregarDoCursor(par_cAliasCursor)`. A forma `(par_cAliasCursor)` com parenteses sugere macro expansion de alias � mas PEMSTATUS nao aceita alias em NENHUMA forma. CorretorAutomatico #84 normaliza automaticamente:

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
- **F4(115) / F5(116)**: Sempre abrir FormBuscaAuxiliar direto (lookup for�ado pelo usuario).

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

Em forms `frmcadastro`, os containers que hospedam botoes da toolbar (`cnt_4c_Botoes`, `cnt_4c_Saida`, `cnt_4c_BotoesDados`) devem ter `BackStyle=0` (transparente). LLM frequentemente copia o padrao do cabecalho (`cnt_4c_Cabecalho` com BackStyle=1 + BackColor=RGB(100, 100, 100)) e aplica aos containers de botoes, criando uma caixa cinza escura ao redor dos botoes que nao existe no layout original.

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
    .BackColor   = RGB(100, 100, 100)      && cinza escuro destoa do layout
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

**EXCECAO UNICA**: `cnt_4c_Cabecalho` continua com `BackStyle=1` + `BackColor=RGB(100, 100, 100)` (cntSombra do frmcadastro) + label branco. Essa regra NAO muda - vale apenas para containers de BOTOES.

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

## 87. cnt_4c_Botoes.Left=542 em forms 1000px � NAO copiar Left=343 do legado (task019)

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

**Regra**: Em forms `frmcadastro` migrados (Width=1000), `cnt_4c_Botoes.Left` DEVE ser `542`. NAO copiar `Grupo_op.Left` direto do SCX � o legado tinha form 770px; o migrado tem 1000px. Formula: `Left = FormWidth - CntBotoesWidth - 68 = 1000 - 390 - 68 = 542`.

## 88. Page1.Picture + Page2.Picture obrigatorios em frmcadastro (task019)

Em forms `frmcadastro` migrados, o fundo visual padrao nao vem do Form.BackColor � vem da propriedade `Picture` de cada Page do PageFrame principal. Se `ConfigurarPageFrame` define apenas `Caption` e `BackColor` sem `Picture`, Page1 e Page2 ficam totalmente brancas, sem o fundo grafico padrao do framework (fundo_cad_1003.jpg).

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

O container do header escuro (`cnt_4c_Sombra` ou `cnt_4c_Cabecalho`) DEVE ocupar a largura TOTAL do form. O container do botao Encerrar (`cnt_4c_Saida`) eh transparente (`BackStyle = 0`) e fica POR CIMA do header � o fundo escuro precisa estender por baixo dele ate a borda direita do form.

```foxpro
*-- ERRADO: gerador deixa 60px a direita achando que precisa poupar espaco para o Encerrar
loc_oPagina.AddObject("cnt_4c_Sombra", "Container")
WITH loc_oPagina.cnt_4c_Sombra
    .Top         = 31
    .Left        = 0
    .Width       = THIS.Width - 60     && 940 em form 1000px � faixa clara a direita
    .Height      = 80
    .BackColor   = RGB(100, 100, 100)
ENDWITH
```

```foxpro
*-- CORRETO: largura total do form; cnt_4c_Saida fica por cima (transparente)
loc_oPagina.AddObject("cnt_4c_Sombra", "Container")
WITH loc_oPagina.cnt_4c_Sombra
    .Top         = 31
    .Left        = 0
    .Width       = THIS.Width          && 1000 � cobre toda a largura
    .Height      = 80
    .BackColor   = RGB(100, 100, 100)
ENDWITH
```

**Regra**: Em forms `frmcadastro`, `cnt_4c_Sombra.Width` (ou `cnt_4c_Cabecalho.Width`) DEVE ser `THIS.Width` (ou valor >= Form.Width, como 1020 em FormCor). NUNCA `THIS.Width - N` para "abrir espaco" para o Encerrar � o container do Encerrar e transparente e precisa do fundo escuro POR BAIXO.

## 90. MsgAviso para validacao UI, MsgErro APENAS para exceptions tecnicas (task020)

`MostrarErro`/`MsgErro` exibe dialog vermelho com icone X + botao "Fechar Aplicacao". Usado para validacao de pre-condicao (ex: "Selecione um registro na lista"), o usuario interpreta como crash fatal e pode fechar a aplicacao por engano.

**Regra de escolha**:
- `MsgAviso(msg)` � validacao de UI, orientacao ao usuario: "Selecione...", "Informe...", "Escolha...", "Campo obrigatorio", "Valor invalido", "Ja cadastrado", "Deve conter pelo menos X caracteres".
- `MsgErro(msg)` / `MostrarErro(msg, titulo)` � SOMENTE exceptions tecnicas: CATCH blocks ("Erro ao inserir: " + loException.Message), falhas de SQL (CapturarErroSQL), conexao perdida, arquivo/recurso inexistente.

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
        MostrarErro("Erro ao inserir: " + loException.Message, "Erro")   && OK � exception real
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

**Relacao com regra #43**: A #43 proibe resetar `ColumnCount` destrutivamente em CarregarLista (ex: setar para zero e depois subir). Esta regra (#91) especifica que ColumnCount deve estar definido no valor esperado ANTES do RecordSource � e que isso eh um set, nao um reset.

## 92. loc_oPagina.Picture em ConfigurarPaginaLista/Dados (task021)

Complementa regra #88. Alguns forms usam metodos separados para configurar cada pagina:
- `ConfigurarPaginaLista()` comeca com `loc_oPagina = THIS.pgf_4c_Paginas.Page1`
- `ConfigurarPaginaDados()` comeca com `loc_oPagina = THIS.pgf_4c_Paginas.Page2`

Nesses casos, o fundo NAO esta no WITH block de ConfigurarPageFrame � precisa ser setado explicitamente em cada metodo via `loc_oPagina.Picture = ...`. Se um dos metodos esquece, a respectiva pagina fica totalmente branca.

```foxpro
*-- ERRADO: ConfigurarPaginaDados sem Picture � Page2 branca
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
    .Width     = 60          && expandimos para caber caption � mas agora extrapola
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

**Regra**: Ao gerar OptionGroup, calcular `container.Width >= MAX(Buttons[i].Left + Buttons[i].Width) + 10`. NAO copiar cegamente do SCX legado � se algum button foi expandido (ex: para CHR codes acentuados), o container precisa crescer proporcionalmente.

Recomendacao: tambem usar `.AutoSize = .F.` nos Buttons (AutoSize em VFP9 pode calcular largura aquem com fontes acentuadas).

CorretorAutomatico #87 calcula e ajusta container automaticamente.

## 98. Padrao Canonico Saida/Encerrar � PREVALECE sobre PILAR 1 (tasks 016-022)

### Contexto

Tasks 016-022 evidenciaram que o gerador continua copiando **pixel-perfect do SCX legado** os valores do bloco de saida (container `Grupo_Saida` + botao X), mesmo com as regras individuais ja presentes nos prompts e no CorretorAutomatico. Isso acontece porque o PILAR 1 (pixel-perfect legado) conflita com o padrao canonico estabelecido por `FormCor`/`FormMoe` para esse bloco � e sem uma regra de precedencia explicita, o modelo oscila.

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

Containers filhos diretos de `Page1`/`Page2` (header, shadow, content) DEVEM usar `.Width = THIS.Width` � NUNCA `THIS.Width - 60` achando que precisam "deixar espaco" para o botao Encerrar. O `cnt_4c_Saida` eh flutuante/transparente **por cima** da Page, nao ocupa area dela. A subtracao so deixa uma faixa clara visivel a direita expondo o fundo nativo do form.

```foxpro
*-- ERRADO (deixa faixa clara a direita)
.Width = THIS.Width - 60

*-- CORRETO (cobre toda a largura)
.Width = THIS.Width
```

### Por que o PILAR 1 NAO se aplica aqui

O SCX legado foi desenhado para um form de **770px** com um "botao X" de 50px dentro de um container `Grupo_Saida` compacto de 60px. O sistema novo padroniza forms CRUD em **1000px** com o Encerrar tendo as mesmas dimensoes 75x75 dos demais botoes CRUD (Incluir/Alterar/Visualizar/Excluir). Copiar o SCX legado quebra a harmonia visual com o restante da UI � o Encerrar fica visualmente menor que os outros botoes.

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

1. Ver o bloco `Grupo_Saida` no SCX legado? **Nao copiar as dimensoes** � usar canonico.
2. Ver `cmdSair` / `cmdX` / botao de saida com Caption != "Encerrar"? **Trocar Caption para "Encerrar"**.
3. Escrever `.Width = THIS.Width - 60`? **Substituir por `THIS.Width`**.
4. Duvidas de espacamento? Consultar `FormCor` ou `docs/framework_frmcadastro_layout.md`.

## 99. VFP9 gotchas: PUBLIC em DEFINE CLASS, Page.Width, MostrarAviso (task016)

Tres erros descobertos na migra��o do task016 (SigCdCol) que precisam estar nos prompts porque custaram retries caros:

### 99.1 `PUBLIC FUNCTION`/`PUBLIC PROCEDURE` em `DEFINE CLASS` = SYNTAX ERROR

**Sintomas duplos:**
- Em build: `.ERR` com cascade de "Statement is not valid in a class definition" + "Nesting error" linha-por-linha do metodo afetado em diante.
- Em runtime: ao tentar abrir o form, `CREATEOBJECT("XxxBO")` retorna `.F.` (logical) e o FormBase exibe **"Erro ao criar formul�rio de [Entidade] � VARTYPE retornou: L"**. Bug observado nas tasks 016 (SigCdCol) e 018 (SigCdUfs/UfsBO.prg).

```foxpro
*-- ERRADO � "Statement is not valid in a class definition"
DEFINE CLASS ColBO AS BusinessBase
    PUBLIC FUNCTION Buscar(par_cFiltro)    && <-- PUBLIC nao eh modifier valido
        ...
    ENDFUNC
ENDDEFINE

*-- CORRETO � metodos sao PUBLIC por default
DEFINE CLASS ColBO AS BusinessBase
    FUNCTION Buscar(par_cFiltro)
        ...
    ENDFUNC
ENDDEFINE

*-- Modifiers validos em DEFINE CLASS: PROTECTED, HIDDEN (NUNCA PUBLIC)
PROTECTED PROCEDURE CarregarLista()
HIDDEN FUNCTION CalcularInterno()
```

**Auto-fix**: `CorretorAutomatico.Corrigir-PublicProcedureEmDefineClass` (pattern #42) detecta `PUBLIC PROCEDURE` E `PUBLIC FUNCTION` dentro de `DEFINE CLASS ... ENDDEFINE` e remove o `PUBLIC`. Versao inicial cobria apenas `PROCEDURE`; estendido em 2026-05-13 para tambem cobrir `FUNCTION` apos task018 reportar o bug.

### 99.2 `Page.Width` / `Page.Height` READ-ONLY em runtime

```foxpro
*-- ERRADO � "CREATEOBJECT retornou valor nao-objeto" na instanciacao
WITH loc_oPage   && Page eh THIS.pgf_4c_Paginas.Page1
    .Width  = THIS.Width     && <-- Page.Width nao eh settable
    .Height = THIS.Height
ENDWITH

*-- CORRETO � PageFrame controla Width/Height das Pages automaticamente
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
*-- ERRADO � "File 'mostraraviso.prg' does not exist" em runtime
IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Colecoes.Value))
    MostrarAviso("Grupo invalido.", "")    && <-- MostrarAviso nao existe
    RETURN
ENDIF

*-- CORRETO � usar MsgAviso para validacao de UI (dialog amarelo)
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
| `MostrarAviso` | **NAO EXISTE** | � | � |
| `MessageBox(...)` | **PROIBIDO** | � | � |

## 100. SQLEXEC em cursor de grid sem fechar antes � "uncommitted changes" (task016)

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

## 101. REPORT btnReport e CommandGroup (NAO Container) com 4 Buttons (task023+024)

Forms REPORT (frmrelatorio) tem 4 botoes superiores (Visualizar/Imprimir/DocExcel/Sair). NO LEGADO o `btnReport` da `framework.vcx` e uma **CommandGroup** com `ButtonCount=4`, NAO um Container com 4 CommandButtons separados. Migrar como Container quebra o aspecto visual (cada botao com sua borda) e dificulta replicacao do estilo de grupo.

### Sintoma

- Visual: 4 botoes aparecem como caixas individuais separadas (cada um com borda propria), nao como um grupo coeso.
- Captions truncadas se Width < ~75 e `PicturePosition=1` (Picture-LEFT): "sualiz" em vez de "Visualizar".
- Ultimo botao (Encerrar) cortado quando `cnt_4c_Botoes.Left+Width` > `Form.Width`.

### ERRADO (atual gerador antes de 2026-05-15)

```foxpro
THIS.AddObject("cnt_4c_Botoes", "Container")
WITH THIS.cnt_4c_Botoes
    .Left = 542 / .Width = 325   && overflow em Form.Width=800
ENDWITH
THIS.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
WITH THIS.cnt_4c_Botoes.cmd_4c_Visualizar
    .Width = 67 / .PicturePosition = 1   && icone a esquerda, caption truncada
    .FontName = "Tahoma"
ENDWITH
*-- ... mais 3 CommandButtons individuais
```

### CORRETO (replicar framework.vcx btnReport)

```foxpro
THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
WITH THIS.cmg_4c_Botoes
    .Top           = 0
    .Left          = 529                       && encaixa em form 800px
    .Width         = 273
    .Height        = 80
    .ButtonCount   = 4                         && 4 botoes
    .BackStyle     = 0                         && transparente
    .BorderStyle   = 0                         && sem borda externa
    .BorderColor   = RGB(136, 189, 188)
    .SpecialEffect = 1                         && Plain
    .Themes        = .F.
    .Visible       = .T.

    WITH .Buttons(1)
        .Top             = 5
        .Left            = 5                   && Buttons: 5, 71, 137, 203 (incrementos de 66)
        .Width           = 65                  && todos com mesmo tamanho
        .Height          = 70
        .Caption         = "Visualizar"        && ou "\<V" + CHR(237) + "deo" com hotkey
        .FontName        = "Comic Sans MS"     && NAO "Tahoma"
        .FontBold        = .T.
        .FontItalic      = .T.
        .FontSize        = 8
        .BackColor       = RGB(255, 255, 255)
        .ForeColor       = RGB(90, 90, 90)
        .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
        .PicturePosition = 13                   && icone ACIMA do caption (NAO 1 = esquerda)
        .SpecialEffect   = 0                   && 3D nos botoes
        .MousePointer    = 15                  && cursor mao
        .ToolTipText     = "Gerar o Relat" + CHR(243) + "rio no V" + CHR(237) + "deo"
        .Themes          = .F.
        .Visible         = .T.
    ENDWITH

    *-- Buttons(2) = Imprimir, Buttons(3) = DocExcel/Excel/Documento, Buttons(4) = Sair (Cancel=.T.)
    *-- Mesmas propriedades, Lefts: 71, 137, 203
ENDWITH

*-- BINDEVENT usa Buttons(N), nao CommandButton nomeado
BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnDocumentoClick")
BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")
```

### Referencia

Propriedades exatas extraidas da `framework.vcx` (frmrelatorio.btnReport) via VFP9 IDE - imagens em `C:\4c\origem\`:
- `configuracaoBotoesRelatorio.jpg` - propriedades do CommandGroup btnReport
- `video.jpg` - Buttons(1) Visualiza
- `impressora.jpg` - Buttons(2) Imprime
- `excel.jpg` - Buttons(3) DocExcel (caption original "\<Arquivos Email" + icon `geral_email_*.jpg`; sobreposto por subclasses como Excel/Documento)
- `botao_encerrar.jpg` - Buttons(4) Sair (Cancel=.T., Caption="Encerrar")

### Auto-fix

CorretorAutomatico #99 (`Corrigir-PicturePositionReport`) detecta `.PicturePosition = 1` em CommandButton/Buttons() com `.Picture = gc_4c_CaminhoIcones + "relatorio_*"` e converte para `13`. Conversao estrutural Container->CommandGroup nao e automatizada (alto risco de falsos positivos); cabe ao prompt REPORT gerar correto.

## 102. REPORT forms - Top de controles NAO deve subtrair 85 (offset sistematico) (retrospectiva 2026-05-19)

Forms REPORT (frmrelatorio, layout FLAT) tem um toolbar `cmg_4c_Botoes` fixado em `Top=0, Height=80`. Os controles de filtro (TextBox de datas, ComboBox de empresa, CheckBox de opcoes, etc.) estao posicionados NO SCX em coordenadas ABSOLUTAS que ja consideram o toolbar (ex: `txt_4c_DtInicial.Top = 125` = 45px abaixo do toolbar de 80px).

**O bug**: o gerador subtrai ~85 de todos os valores Top, resultando em controles sobrepostos ao toolbar (ex: `Top = 40` em vez de `Top = 125`). Isso afeta tipicamente 15-40 controles por form.

**Evidencia** (retrospectiva 05/2026):
- task032 (sigreapp): ~40 controles com delta Top = -85 (ex: `txt_4c_DtInicial`: SCX=125, PRG=40)
- task064 (SIGRECPM): ~15 controles com delta Top = -85 (ex: `txt_4c_DtInicial`: SCX=93, PRG=8)
- task055, task052, task053, task061: mesmo padrao

**Comparacao com CRUD**: Forms CRUD tem `PageFrame.Top = -29` e requerem compensacao `+29` nos containers da page. Forms REPORT NAO tem PageFrame - os controles ficam diretamente no form. NAO ha compensacao de offset a aplicar.

```foxpro
*-- ERRADO: gerador subtrai 85 do Top original do SCX
WITH THIS
    .AddObject("txt_4c_DtInicial", "TextBox")
ENDWITH
WITH THIS.txt_4c_DtInicial
    .Top  = 40    && SCX tinha 125 - gerador subtraiu 85 (ERRADO)
    .Left = 80
    .Width = 100
    .Height = 24
ENDWITH

*-- CORRETO: copiar Top EXATO do SCX
WITH THIS.txt_4c_DtInicial
    .Top  = 125   && valor exato do SCX, sem ajuste
    .Left = 80
    .Width = 100
    .Height = 24
ENDWITH
```

**Regra**: Em forms REPORT, copiar valor `.Top` EXATAMENTE do SCX para TODOS os controles. NAO subtrair altura do toolbar (80/85px). NAO aplicar nenhuma compensacao. O SCX ja posiciona os controles abaixo do toolbar com coordenadas absolutas.

**Checklist REPORT antes de commitar**:
- [ ] Verificar no `layout_vs_prg_report.json` se delta Top esta proximo de zero para todos controles
- [ ] Se todos os deltas Top forem ~-85, o gerador aplicou offset incorreto - corrigir manualmente somando 85 a todos

**Nao automatizavel no CorretorAutomatico**: a correcao requer saber o Top original do SCX, que so existe no JSON de analise. O corretor nao tem acesso a esses valores. Deve ser corrigido no prompt de geracao.

## 103. cntAguarde ausente em REPORT e OPERACIONAL com processamento pesado (retrospectiva 2026-05-19)

Muitos forms REPORT e OPERACIONAL do legado tem um container `cntAguarde` (tambem chamado `cnt_4c_Aguarde`) com dois labels internos ("Aguardando..." / nome do processo). Este container eh visualmente sobreposto ao form principal e aparece durante processamentos longos (geracao de relatorio, busca pesada).

O gerador frequentemente OMITE este container, causando:
- Erros no `ValidarUIFidelity` (`cntAguarde.Label1 NOT FOUND`, `cntAguarde.Label2 NOT FOUND`)
- Form sem feedback visual durante operacoes demoradas

**Evidencia** (retrospectiva 05/2026):
- task053 (SIGRECMG, OPERACIONAL): `cntAguarde.Label1` e `cntAguarde.Label2` ausentes
- task064 (SIGRECPM, REPORT): `cntAguarde.Label1` e `cntAguarde.Label2` ausentes

**Padrao canonico do cntAguarde**:

```foxpro
*-- Adicionar ao InicializarForm / ConfigurarControles
THIS.AddObject("cnt_4c_Aguarde", "Container")
WITH THIS.cnt_4c_Aguarde
    .Top       = 168        && posicao do SCX original
    .Left      = 312        && posicao do SCX original
    .Width     = 273        && largura do SCX original
    .Height    = 49         && altura do SCX original
    .BackColor = RGB(255, 255, 204)   && amarelo claro (aviso)
    .BorderWidth = 2
    .Visible   = .F.        && inicia oculto
    .ZOrder(0)              && trazer para frente quando visivel
    .AddObject("Label1", "Label")
    .AddObject("Label2", "Label")
ENDWITH
WITH THIS.cnt_4c_Aguarde.Label1
    .Caption   = "Aguarde..."
    .Top       = 5
    .Left      = 5
    .Width     = 263
    .Height    = 18
    .FontBold  = .T.
ENDWITH
WITH THIS.cnt_4c_Aguarde.Label2
    .Caption   = ""         && preenchido dinamicamente com nome da operacao
    .Top       = 25
    .Left      = 5
    .Width     = 263
    .Height    = 18
ENDWITH

*-- Uso: antes do processamento pesado
PROCEDURE PrepararDados()
    THIS.cnt_4c_Aguarde.Label2.Caption = "Gerando relat" + CHR(243) + "rio..."
    THIS.cnt_4c_Aguarde.Visible = .T.
    THIS.Refresh()
    TRY
        *-- processamento pesado aqui
    CATCH TO loErro
        MsgErro(loErro.Message, "Erro")
    ENDTRY
    THIS.cnt_4c_Aguarde.Visible = .F.
ENDPROC
```

**Regra**: Ao migrar form REPORT ou OPERACIONAL, verificar no SCX se existe container `cntAguarde` (qualquer variante de nome). Se existir, incluir na migracao com:
- Top/Left/Width/Height copiados do SCX
- `Visible = .F.` inicial
- Label1 e Label2 internos presentes
- Toggle `Visible = .T./.F.` em torno de operacoes pesadas (PrepararDados, MontaGrade, etc.)

---

## 104. REPORT Buttons(N).Picture/Caption: canonicos do framework btnReport (atualizado 2026-06-26)

**Bug original** (Formsigatcrp 2026-06-25): Form REPORT gerado usava `.Picture = gc_4c_Icones + "geral_visualizar_60.jpg"` (e variantes `geral_imprimir_60.jpg`, `geral_fechar_60.jpg`). Esses arquivos **NAO EXISTEM** em `C:\4c\vbmp\` — 3 dos 4 botoes apareciam sem icone.

**Bug derivado** (FormSigReAac.prg task025, 2026-06-26): Botao 3 foi gerado como `Caption="Excel"` + `Picture=relatorio_excel_26.jpg` baseando-se no `Name="DocExcel"` do framework, mas o framework `frmrelatorio.btnReport.Command3` (ver `docs/FRAMEWORK_class_codigo_fonte.txt` linhas ~6644-6664) define `Picture=geral_envelope_32.jpg` + `Caption="\<Arquivos Email"`. O "DocExcel" eh apenas o nome interno legado.

**Causa raiz**: O LLM (a) inventou nomes "razoaveis" por analogia, (b) confiou no `Name` interno em vez de validar `Picture`/`Caption` reais do framework.

**Fix canonico** (template `FormSigReAac.prg:179-249`):

| Botao | Picture canonico | Caption canonico | ToolTipText |
|-------|------------------|------------------|-------------|
| Buttons(1) Visualizar     | `relatorio_video_26.jpg`      | `"\<Visualizar"`     | `"Gerar o Relatorio no Video"` |
| Buttons(2) Imprimir       | `relatorio_impressora_26.jpg` | `"\<Imprimir"`       | `"Enviar o Relatorio Para Impressora"` |
| Buttons(3) Arquivos Email | `geral_envelope_32.jpg`       | `"\<Arquivos Email"` | `"Arquivos Email"` |
| Buttons(4) Encerrar       | `relatorio_sair_60.jpg`       | `"\<Encerrar"`       | `"[Esc] Encerrar"` |

ATENCAO Buttons(3): NAO eh Excel. O `Name = "DocExcel"` do framework eh nome interno legado; o botao visual eh envelope de email com caption "Arquivos Email".

**Path**: SEMPRE `gc_4c_CaminhoIcones +` (NUNCA `gc_4c_Icones` — variavel legada).

```foxpro
* ERRADO (arquivos inexistentes + variavel legada)
.Picture = gc_4c_Icones + "geral_visualizar_60.jpg"
.Picture = gc_4c_Icones + "geral_imprimir_60.jpg"
.Picture = gc_4c_Icones + "geral_fechar_60.jpg"

* ERRADO (botao 3 tratado como Excel - bug task025)
WITH .Buttons(3)
    .Caption = "Excel"
    .Picture = gc_4c_CaminhoIcones + "relatorio_excel_26.jpg"
    .ToolTipText = "Exportar para Excel"
ENDWITH

* CORRETO
.Picture = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
.Picture = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"

WITH .Buttons(3)
    .Caption = "\<Arquivos Email"
    .Picture = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
    .ToolTipText = "Arquivos Email"
ENDWITH

.Picture = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
```

**FontName canonico** (framework `frmrelatorio.btnReport.CommandN`):
- Os 4 Buttons(N) DEVEM ter `FontName="Comic Sans MS"` + `FontSize=8`. O SCX original NAO sobrescreve FontName, entao herdam Comic Sans MS do framework.
- Gerador frequentemente coloca `FontName="Tahoma"` por default - quebra fidelidade visual.
- Buttons(1) costuma vir SEM FontName/FontSize declarados (herda do CommandGroup). Explicitar nos 4 botoes eh mais robusto.

**Regra de precedencia geometria — SCX overrides ANTES de defaults framework**:
- Defaults do framework btnReport: `Width=273, Left=529, Height=80; Buttons Width=65, Height=70, Lefts=5/71/137/203 (inc 66)`.
- O SCX original PODE sobrescrever essa geometria. Quando sobrescreve, USAR os valores do SCX. Defaults so aplicam quando SCX NAO sobrescreve.
- Antes de aplicar defaults, LER a secao "PROPRIEDADES DE: <FORM>" em `tasks/<task>/<form>_form_codigo_fonte.txt` e procurar `btnReport.Width/Left/Height/Top` e `btnReport.Visualiza/Imprime/DocExcel/sair.Top/Left/Width/Height`.
- Ex: SigReAac.scx tem `btnReport.Width=310, Left=494, Height=85` + `CommandN.Width=75, Height=75` com Lefts=5/80/155/230 (inc 75). Migrar com defaults quebra Pilar 1 (UX pixel-perfect).
- NAO automatizavel (precisa ler arquivo da task). Regra explicita nos prompts.

**WordWrap canonico** (framework `frmrelatorio.btnReport`):
- Buttons(1) Visualiza: `WordWrap = .F.` (framework Command1, linha 6615 — caption curto "Vídeo"/"Visualizar" cabe).
- Buttons(2) Imprime:   `WordWrap` NAO declarado (default .F. — "Impressora"/"Imprimir" cabe).
- Buttons(3) DocExcel:  `WordWrap = .T.` (framework Command3, linha 6653 — caption longo "Arquivos Email" PRECISA quebrar em 2 linhas).
- Buttons(4) Sair:      `WordWrap = .T.` (framework Command4, linha 6673 — "Encerrar" cabe mas framework set por consistencia).
- Sem `WordWrap=.T.` em Buttons(3)/(4), captions longos sao TRUNCADOS visualmente.

**Auto-fix**:
- Pattern #96 (`Corrigir-PictureReportIconesInexistentes`) — substitui nomes inexistentes + padroniza `gc_4c_Icones`->`gc_4c_CaminhoIcones`. Tambem mapeia `geral_excel_60.jpg`->`geral_envelope_32.jpg`.
- Pattern #100 (`Corrigir-Buttons3RelatorioEmail`) — dentro de `WITH .Buttons(3)/ENDWITH`, troca Caption "Excel"->"\<Arquivos Email", Picture `relatorio_excel_26.jpg`->`geral_envelope_32.jpg`, ToolTipText "Exportar para Excel"/"Gerar Uma Planilha Excel*"->"Arquivos Email".
- Pattern #101 (`Corrigir-ButtonsReportFontNameComicSans`) — em forms REPORT (com `cmg_4c_Botoes`), dentro de qualquer `WITH ...Buttons(N)/ENDWITH`, troca `FontName="Tahoma"` -> `"Comic Sans MS"` e injeta `FontName="Comic Sans MS"`+`FontSize=8` (apos `.Caption`) se ausentes. Geometria (Width/Height/Left) NAO eh auto-corrigida — depende do SCX.
- Pattern #102 (`Corrigir-ButtonsReportWordWrap`) — em forms REPORT, dentro de `WITH ...Buttons(3)/ENDWITH` ou `WITH ...Buttons(4)/ENDWITH`, injeta `.WordWrap = .T.` apos `.Caption` se ausente. NAO toca em Buttons(1)/(2) (mantem WordWrap=.F. default).
- Pattern #96 estendido (2026-06-26, task026) — alem dos `geral_*` nomes ja mapeados, agora tambem mapeia nomes corrompidos/legados: `"ideo.jpg"` -> `"relatorio_video_26.jpg"`, `"otao_encerrar.jpg"` -> `"relatorio_sair_60.jpg"`, `"video.jpg"`/`"impressora.jpg"`/`"excel.jpg"`/`"botao_encerrar.jpg"` -> canonicos com sufixo `_26/_60`.
- Pattern #103 (`Corrigir-GridReportCanonico`) — em forms REPORT (com `cmg_4c_Botoes`), dentro de qualquer `WITH ...grd_4c_*/ENDWITH`, substitui `.RowHeight=16` -> `18`, `.FontName="Verdana"` -> `"Tahoma"`, e INJETA `.HeaderHeight=0` apos `.Width`/`.Height` se ausente. Match framework `frmrelatorio` canonico onde grids tem header escondido (Label externa serve como pseudo-header).

---

## 106. ANTES de migrar: checar SCX mais recente em correcoes/ (task026 2026-06-26)

**Bug**: `tasks/task026/SIGREADS.scx` (4957 bytes, 2020-03-25) estava desatualizado vs `C:\4c\origem\correcoes\SigReAds.SCX` (5829 bytes, 2024-01-09). O SCX mais novo tinha 41 objetos (vs 35 da task) — incluia `Label2`, `Grdgrupo`, `Fwbtnp1`, `Fwbtnp2` e `optTipoRel.ButtonCount=5` (vs 3). Form migrado com SCX antigo ficou sem o grid de Grupo de Produto, sem os 2 botoes de SelTudo/Apaga do segundo grid, e com 3 opcoes em vez de 5 no optTipoRel.

**Causa raiz**: O pipeline copia o SCX para `tasks/task<NNN>/` no inicio da migracao e nunca mais re-verifica. Se a versao em producao for atualizada depois, o pipeline gera form contra SCX antigo.

**Fix (manual, antes de migrar)**:

1. **Verificar se existe SCX mais novo**:
```powershell
$basename = "SIGREADS"  # nome do form
$scxAtual = "C:\4c\tasks\task<NNN>\$basename.scx"
$scxCorrecoes = "C:\4c\origem\correcoes\$basename.SCX"
$scxInstall = Get-ChildItem "C:\4install\FortyusMC*\Fortyus\$basename.SCX" -ErrorAction SilentlyContinue | Sort-Object LastWriteTime -Descending | Select-Object -First 1

foreach ($f in @($scxAtual, $scxCorrecoes, $scxInstall.FullName)) {
    if ($f -and (Test-Path $f)) {
        $info = Get-Item $f
        Write-Host "$($info.LastWriteTime)  $($info.Length) bytes  $f"
    }
}
```

2. **Se houver mais novo, copiar para task e re-extrair**:
```powershell
Copy-Item C:\4c\origem\correcoes\SigReAds.SCX C:\4c\tasks\task026\SIGREADS.scx -Force
Copy-Item C:\4c\origem\correcoes\SigReAds.SCT C:\4c\tasks\task026\SIGREADS.sct -Force

# Re-extrair via VFP9 launcher (.prg que chama ExtractSCXCode + QUIT)
# Conteudo do launcher:
#   SET SAFETY OFF
#   SET RESOURCE OFF
#   SET DEFAULT TO ("C:\4c")
#   DO ("C:\4c\projeto\app\utils\ExtractSCXCode.prg") WITH "C:\4c\tasks\task026\SIGREADS.SCX"
#   QUIT
& "C:\Program Files (x86)\Microsoft Visual FoxPro 9\vfp9.exe" -t "C:\4c\tasks\task026\_extract_launcher.prg"
```

3. Verificar `tasks/task<NNN>/<basename>_form_codigo_fonte.txt` regenerado e proceder com migracao.

**Pastas onde procurar SCX mais novos (em ordem de prioridade)**:
1. `C:\4c\origem\correcoes\<basename>.SCX` (versao de teste/correcao do usuario)
2. `C:\4install\FortyusMC_teste\FortyusMC\Fortyus\<basename>.SCX` (versao de teste)
3. `C:\4install\FortyusMC\Fortyus\<basename>.SCX` (versao oficial)
4. `C:\4install\WorkSpace\FortyusMC\Fortyus\<basename>.SCX`

**NAO automatizavel** — decisao de fonte cabe ao migrador. Regra explicita nos prompts REPORT/CRUD/OPERACIONAL.

---

## 105. REPORT OBRIGATORIO ter ConfigurarCabecalho/cnt_4c_Cabecalho (Formsigatcrp 2026-06-25)

**Bug**: `Formsigatcrp.prg` (REPORT) nao criava o container superior cinza (`cnt_4c_Cabecalho`) que eh o equivalente ao `cntSombra` do framework `frmrelatorio` legado. Resultado visual: faltava a faixa cinza superior com o titulo, descaracterizando o form — nao parece um relatorio do sistema.

**Causa**: O gerador omitiu a chamada/criacao do cabecalho. Regras existentes (#176, #193) cobriam BackColor/Width corretos MAS nao garantiam a EXISTENCIA do bloco.

**Fix canonico** (template `FormSigReAac.prg:104-146`):

1. **Em `InicializarForm`** — chamada ANTES de `CriarBotoesRelatorio`:
```foxpro
IF loc_lSucesso
    THIS.ConfigurarCabecalho()      && OBRIGATORIO ANTES de CriarBotoesRelatorio
    THIS.CriarBotoesRelatorio()
    THIS.CriarFiltros...()
    ...
ENDIF
```

2. **PROCEDURE ConfigurarCabecalho** — Container 0,0 com 2 labels sobrepostos:
```foxpro
PROCEDURE ConfigurarCabecalho
    THIS.AddObject("cnt_4c_Cabecalho", "Container")
    WITH THIS.cnt_4c_Cabecalho
        .Top         = 0
        .Left        = 0
        .Width       = THIS.Width
        .Height      = 80
        .BackStyle   = 1
        .BackColor   = RGB(100, 100, 100)
        .BorderWidth = 0
        .Visible     = .T.

        .AddObject("lbl_4c_Sombra", "Label")     && sombra preta (Top=22,Left=22)
        WITH .lbl_4c_Sombra
            .Top=22 / .Left=22 / .Width=THISFORM.Width / .Height=30
            .Caption=THISFORM.Caption / .FontName="Tahoma" / .FontSize=14 / .FontBold=.T.
            .ForeColor=RGB(0,0,0) / .BackStyle=0 / .Visible=.T.
        ENDWITH

        .AddObject("lbl_4c_Titulo", "Label")     && titulo branco (Top=20,Left=20)
        WITH .lbl_4c_Titulo
            .Top=20 / .Left=20 / .Width=THISFORM.Width / .Height=30
            .Caption=THISFORM.Caption / .FontName="Tahoma" / .FontSize=14 / .FontBold=.T.
            .ForeColor=RGB(255,255,255) / .BackStyle=0 / .Visible=.T.
        ENDWITH
    ENDWITH
ENDPROC
```

**Z-order critico**: ConfigurarCabecalho() DEVE ser chamado ANTES de CriarBotoesRelatorio() — assim os botoes ficam visualmente NA FRENTE do cabecalho cinza.

**Quando aplicar**: TODO form que herda `FormBase` e tem `cmg_4c_Botoes` (CommandGroup REPORT) ou `PROCEDURE CriarBotoesRelatorio`. Aplica somente para REPORT, NAO para CRUD/OPERACIONAL.

**Auto-fix**: CorretorAutomatico Pattern #97 (`Corrigir-CabecalhoReportAusente`). Detecta REPORT sem cabecalho e insere bloco completo + chamada.

---

## 106. cnt_4c_Cabecalho Labels com AutoSize=.T. truncam titulo atras dos botoes (Formsigrecmc 2026-06-25)

**Bug**: Form REPORT migrado com Caption longa (ex: "Relatorio de Clientes que Mais/Menos/Nao Compram em Valores e Quantidades", 71 caracteres) gerava `lbl_4c_Sombra`/`lbl_4c_Titulo` em `cnt_4c_Cabecalho` com `.AutoSize = .T.`. Como AutoSize=.T. faz `Width = pixel-width do Caption`, a Label expandia ate ~500-600px, ultrapassando a area dos botoes (cmg_4c_Botoes Left=529, Graficos Left=460). Resultado visual: usuario via "Relatorio de Clientes que Mais/Menos/Nao Compram e..." e o restante ficava atras dos botoes (Z-order coloca botoes na frente).

**Causa**: Gerador usava `AutoSize=.T.` pensando que era "responsivo", mas o cabecalho cinza tem area FIXA disponivel (do Left=10 ate Left=460 ou 529, dependendo de ter botao Graficos extra).

**Fix canonico** (template `FormSigReAac.prg:104-146`):

```foxpro
* ERRADO
.AddObject("lbl_4c_Titulo", "Label")
WITH .lbl_4c_Titulo
    .AutoSize  = .T.                && expande sem limite
    .Caption   = THIS.Caption       && caption longo passa por baixo dos botoes
    ...
ENDWITH

* CORRETO
.AddObject("lbl_4c_Titulo", "Label")
WITH .lbl_4c_Titulo
    .AutoSize  = .F.                && (default) - Width fixo
    .Width     = THIS.Width         && Container Width (= THISFORM.Width)
    .Height    = 30
    .Caption   = THIS.Caption       && clipped naturalmente se ultrapassar Width
    ...
ENDWITH
```

**Adicional manual**: Captions REAIS muito longas (>50 caracteres) podem precisar encurtar para caber na area visivel (~440px com botao Graficos extra). Encurtamento depende do form — NAO automatizavel:
- Original: "Relatorio de Clientes que Mais/Menos/Nao Compram em Valores e Quantidades"
- Encurtado: "Clientes Mais/Menos/Nao Compram"

**Aplica-se a**: TODO form com `cnt_4c_Cabecalho` (todos REPORT) usando `AutoSize = .T.` em `lbl_4c_Sombra`/`lbl_4c_Titulo`.

**Auto-fix**: CorretorAutomatico Pattern #98 (`Corrigir-CabecalhoLabelsAutoSize`). Remove `AutoSize=.T.` + adiciona `Width=THIS.Width` se faltando.

---

## 107. Standalone CommandButton com Themes=.F.+Enabled=.F. NAO renderiza Picture (Formsigrecmc 2026-06-25)

**Bug**: CommandButton declarado via `THIS.AddObject("cmd_4c_X","CommandButton")` (standalone, FORA de CommandGroup) com `.Picture` definido + `.Themes = .F.` + `.Enabled = .F.` (estado inicial) NAO mostra o icone — apenas o Caption renderiza. Os Buttons(N) DENTRO de cmg_4c_Botoes com a mesma config FUNCIONAM porque CommandGroup gerencia render diferente.

**Sintoma**: Botao aparece como retangulo branco com texto "Graficos" centralizado, mas sem o icone de pizza chart no topo. Comparativamente, os 4 botoes do cmg_4c_Botoes (Visualizar/Imprimir/Excel/Encerrar) mostram icones corretamente.

**Causa**: Standalone CommandButton com Themes=.F. desabilita o tema visual do Windows — VFP9 entra em modo "owner-draw" simplificado que omite Picture quando Enabled=.F. (botao "cinza nativo"). Buttons() dentro de CommandGroup nao tem esse problema porque o CommandGroup gerencia o render dos sub-botoes.

**Fix canonico** para standalone CommandButton com Picture:

```foxpro
* ERRADO
THIS.AddObject("cmd_4c_Graficos", "CommandButton")
WITH THIS.cmd_4c_Graficos
    .Picture  = gc_4c_CaminhoIcones + "icone.jpg"
    .Themes   = .F.        && impede render do Picture em standalone
    .Enabled  = .F.        && estado inicial sem icone visivel
    ...
ENDWITH

* CORRETO
THIS.AddObject("cmd_4c_Graficos", "CommandButton")
WITH THIS.cmd_4c_Graficos
    .Picture          = gc_4c_CaminhoIcones + "icone.jpg"
    .DisabledPicture  = gc_4c_CaminhoIcones + "icone.jpg"  && garante render quando disabled
    .Themes           = .T.        && Windows tema renderiza Picture corretamente
    .Enabled          = .T.        && (logica do form desabilita depois - icone ja carregado)
    ...
ENDWITH
```

**Aplica-se a**: standalone CommandButton (THIS.AddObject ou container.AddObject) com `.Picture` definido. **NAO aplica** a Buttons(N) dentro de cmg_4c_Botoes (CommandGroup mantem Themes=.F. canonico).

**Auto-fix**: CorretorAutomatico Pattern #99 (`Corrigir-StandaloneCommandButtonTheme`). Detecta padrao + ajusta.

---

## 108. Standalone CommandButton auxiliar (SelTudo/Apaga ao lado de Grid) OMITE `.Picture` inteira (Formsigrecmc 2026-07-01)

**Bug**: Botoes standalone auxiliares ao lado de grids de selecao — tipicamente `cmd_4c_SelTudo` (Selecionar Todos) e `cmd_4c_Apaga` (Desmarcar/apaga) — sao gerados pelo pipeline SEM a linha `.Picture = ...`. O SCX original SEMPRE tem `.Picture` nesses botoes (framework imagens `geral_marcar_26.jpg` para Selecionar, `cadastro_excluir_26.jpg` para Desmarcar). O botao renderiza como um retangulo branco 45x45 sem qualquer icone.

**Sintoma**: Botoes ao lado direito de grids de selecao (tipicamente 45x45 na coluna da direita, Left=735, Top=204/248 em REPORT) aparecem como caixas vazias. Diferente do Pattern #99 (que trata `.Themes=.F.` bloqueando o Picture DEFINIDO), aqui o `.Picture` esta AUSENTE — a linha nem foi gerada.

**Causa**: Durante a Fase A (UI), o LLM lista as propriedades dos botoes standalone com base no SCX mas OMITE `.Picture` para botoes que ele nao reconhece como parte do padrao REPORT canonico (Visualizar/Imprimir/Excel/Encerrar). Botoes auxiliares (SelTudo/Apaga) nao estao em nenhum template canonico da skill — a instrucao "copiar EXATO" (regra #51/#171) nao dispara porque nao ha instrucao explicita listando esses botoes.

**Fix canonico**:

```foxpro
* ERRADO — .Picture ausente
loc_oPg.AddObject("cmd_4c_SelTudo", "CommandButton")
WITH loc_oPg.cmd_4c_SelTudo
    .Top           = 204
    .Left          = 735
    .Width         = 45
    .Height        = 45
    .Caption       = ""
    .Themes        = .F.
    .ToolTipText   = "Selecionar"
    * .Picture ausente -> renderiza como caixa vazia
ENDWITH

* CORRETO — Picture do original + padrao standalone (#99)
loc_oPg.AddObject("cmd_4c_SelTudo", "CommandButton")
WITH loc_oPg.cmd_4c_SelTudo
    .Top             = 204
    .Left            = 735
    .Width           = 45
    .Height          = 45
    .Caption         = ""
    .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
    .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
    .Themes          = .T.
    .ToolTipText     = "Selecionar"
ENDWITH
```

**Mapeamento canonico ToolTipText -> Icone** (framework/imagens no original):

| ToolTipText original | Icone canonico |
|---------------------|----------------|
| "Selecionar" / "Marcar Todos" | `geral_marcar_26.jpg` |
| "Desmarcar" / "Limpar" | `cadastro_excluir_26.jpg` |

**Aplica-se a**: qualquer standalone CommandButton (nao Buttons(N) de CommandGroup) com ToolTipText que casa com o mapeamento canonico acima e sem `.Picture` definido. Tipico em forms REPORT com grid de selecao (SelTudo/Apaga sao par comum), mas tambem pode aparecer em forms OPERACIONAIS com multi-selecao.

**Como prevenir**: quando gerar bloco WITH para cmd_4c_SelTudo/cmd_4c_Apaga (ou qualquer standalone com ToolTipText "Selecionar"/"Desmarcar"), SEMPRE incluir `.Picture` copiada EXATA do SCX original.

**Auto-fix**: CorretorAutomatico Pattern #104 (`Corrigir-StandaloneButtonPictureAusente`). Detecta WITH cmd_4c_* sem `.Picture` mas com `.ToolTipText` conhecida e injeta `.Picture` + `.DisabledPicture` + normaliza `.Themes = .T.` conforme mapeamento canonico. Bug detectado em Formsigrecmc.prg (task052) por teste manual (erro6.PNG, 2026-07-01).

---

## 109. SigCdOpe eh single-column: NUNCA usar `descrs`/`Descrs` (Formsigrecmc/FormSigReCmp 2026-07-01)

**Bug**: Lookup FormBuscaAuxiliar e queries SELECT contra `SigCdOpe` referenciam uma coluna `descrs`/`Descrs` que NAO EXISTE nessa tabela. `SigCdOpe` tem `Dopes` (char(20)) que eh PK **E** descricao da operacao ao mesmo tempo — nao ha coluna de codigo separada.

**Sintoma runtime**: 
```
Erro: Variable 'DESCRS' is not found.
Linha: 327
Procedure: configurargrid
```

O erro dispara em `FormBuscaAuxiliar.ConfigurarGrid` (linha 327: `.Columns(loc_nI).ControlSource = THIS.this_cCursorDestino + "." + loc_cCampo`) quando tenta bindar a coluna "descrs" que nao existe no cursor retornado pelo SELECT.

**Causa raiz**: LLM assume por padrao que tabelas de cadastro tem colunas separadas `codigo`/`descricao` (padrao comum em SigCdCli, SigCdEmp, SigCdMoe, etc.). Mas algumas tabelas VFP9 legadas usam a descricao COMO chave primaria — SigCdOpe eh uma delas. `dopes` = "descricao da operacao" (por ex: "VENDA A VISTA", "DEVOLUCAO DE VENDA").

**Verificar no schema**:
```sql
CREATE TABLE [dbo].[SigCdOpe](
    [dopes] [char](20) NOT NULL,   -- PK e descricao ao mesmo tempo
    ...
) CONSTRAINT [sigcdope_dopes] PRIMARY KEY CLUSTERED
```

Nao ha `descrs`, `desops`, `nomes`, ou qualquer outra coluna de descricao. Apenas `dopes`.

**Fix canonico** — FormBuscaAuxiliar com uma unica coluna:

```foxpro
* ERRADO — duas colunas (descrs nao existe)
loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
    "SigCdOpe", "cursor_4c_BuscaOpe", "Dopes", loc_cValor, ;
    "Opera" + CHR(231) + CHR(227) + "o")
loc_oBusca.mAddColuna("Dopes",  "", "C" + CHR(243) + "digo")
loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")  && Descrs NAO EXISTE
loc_oBusca.Show()

* CORRETO — uma unica coluna (Dopes eh a descricao)
loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
    "SigCdOpe", "cursor_4c_BuscaOpe", "Dopes", loc_cValor, ;
    "Sele" + CHR(231) + CHR(227) + "o de Opera" + CHR(231) + CHR(227) + "o")
loc_oBusca.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
loc_oBusca.Show()
```

**Fix canonico — SELECT direto**:

```foxpro
* ERRADO
loc_cSQL = "SELECT Dopes, Descrs FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cCod)

* CORRETO
loc_cSQL = "SELECT Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cCod)
```

**Templates de referencia** (single-column canonico):
- `FormSIGREADS.prg:1554` — `loc_oBusca.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")`
- `Formsigrevto.prg:900` — mesmo padrao

**Tabelas com PK-descricao unificada conhecidas**:

| Tabela | Coluna PK/Descricao | Tipo | Uso |
|--------|---------------------|------|-----|
| SigCdOpe | `Dopes` | char(20) | Descricao da operacao (VENDA, DEVOLUCAO, etc.) |

Ao encontrar outras, adicionar a esta lista.

**Aplica-se a**: qualquer arquivo `.prg` (form REPORT/OPERACIONAL, BO) que faca lookup ou SELECT contra SigCdOpe. Anti-pattern comum em migracoes onde LLM assume padrao codigo+descricao.

**Como prevenir**: SEMPRE consultar `docs/schema.sql` antes de escrever query ou lookup. Se a tabela tem UMA UNICA coluna char/varchar identificavel como PK, ela provavelmente eh single-column (PK+descricao). Grep no schema por `PRIMARY KEY CLUSTERED` proximo ao CREATE TABLE.

**Auto-fix**: CorretorAutomatico Pattern #105 (`Corrigir-SigCdOpeDescrsColuna`). Detecta (a) `mAddColuna("descrs"|"Descrs", ...)` dentro de bloco que menciona SigCdOpe nas +/-15 linhas anteriores; e (b) `SELECT ... Descrs ... FROM SigCdOpe`. Bug em Formsigrecmc.prg:1848 (task052, erro7.PNG) e FormSigReCmp.prg:1767/1813 (task045).

---

## 110. CommandButton icone-only (`Caption=""`) NUNCA setar `.Enabled=.F.` em runtime (Formsigrecmc 2026-07-01)

**Bug**: Standalone CommandButton com `Caption=""` + `.Picture` fica como retangulo vazio quando `.Enabled=.F.` — o icone e o DisabledPicture NAO renderizam. Independente de `.Themes=.T.` ou `.F.`

**Sintoma**: Botao inicialmente mostra icone (com Enabled=.T.). Ao ser desabilitado no runtime (via `cmd_4c_X.Enabled = .F.`), icone some, botao vira retangulo cinza vazio.

**Refina Pattern #99**: A regra `Themes=.T. + DisabledPicture` do #99 funciona apenas para botoes COM caption nao-vazio. Exemplo: `cmd_4c_Graficos` (`Caption = "Gr" + CHR(225) + "ficos"`) renderiza icone-grayed quando disabled porque o theme rendering tem "ancora textual" para layoutar o DisabledPicture. Icone-only (`Caption = ""`) nao tem essa ancora — theme rendering ignora DisabledPicture e pinta apenas o background do botao.

**Causa raiz**: VFP9 standalone CommandButton delegate render ao Windows theme quando `Themes=.T.`. O theme (visual style engine) espera um par (caption + optional-picture) para layout. Sem caption, o layout colapsa e o picture nao entra no rectangle desenhado. Com `Themes=.F.`, o VFP9 usa render classico proprio, mas ha bug historico (documentado no #99) onde Enabled=.F. + Picture nao renderiza — mesmo problema por caminho diferente.

**Fix canonico** — 3 opcoes em ordem de preferencia:

**(a) NAO desabilitar o botao** (preferido — clique inocuo em muitos casos):

```foxpro
* ERRADO — icone some ao desabilitar
IF !EMPTY(loc_cValor)
    THIS.AbrirBuscaOperacao()
    loc_oPg.grd_4c_Dados.Enabled   = .F.
    loc_oPg.cmd_4c_Apaga.Enabled   = .F.     && icone some!
    loc_oPg.cmd_4c_SelTudo.Enabled = .F.     && icone some!
ENDIF

* CORRETO — desabilita apenas alvo funcional; botoes ficam clickaveis mas
* handler ja seria inocuo (SelTudo/Apaga so mexem em cursor que report ignora)
IF !EMPTY(loc_cValor)
    THIS.AbrirBuscaOperacao()
    loc_oPg.grd_4c_Dados.Enabled = .F.
ENDIF
```

**(b) Desabilitar via check condicional dentro do handler**:

```foxpro
PROCEDURE CmdSelTudoClick()
    LOCAL loc_oPg
    loc_oPg = THIS.pgf_4c_Paginas.Page1
    IF !loc_oPg.grd_4c_Dados.Enabled
        RETURN   && no-op quando grade desabilitada
    ENDIF
    IF USED("CrSigCdTom")
        SELECT CrSigCdTom
        REPLACE ALL CrSigCdTom.nMarca WITH 1
        loc_oPg.grd_4c_Dados.Refresh()
    ENDIF
ENDPROC
```

**(c) `.Visible=.F.` em vez de `.Enabled=.F.`** — botao some completamente mas sem retangulo vazio:

```foxpro
* Aceitavel se UX do form permite botao "sumir"
loc_oPg.cmd_4c_SelTudo.Visible = IIF(EMPTY(loc_cValor), .T., .F.)
```

**Escopo**: apenas standalone `cmd_4c_*` icone-only (Caption=""). Buttons(N) DENTRO de CommandGroup nao tem esse problema (CommandGroup gerencia render diferente). Botoes standalone COM caption (ex: cmd_4c_Graficos) tambem nao tem — Pattern #99 se aplica normal.

**Aplica-se a**: qualquer form que precise disabilitar CommandButton icone-only baseado em estado. Comum em REPORT/OPERACIONAL com pares SelTudo/Apaga ao lado de grid de selecao.

**Auto-fix**: CorretorAutomatico Pattern #106 (`Corrigir-IconOnlyButtonDisableRuntime`). Detecta `cmd_4c_*.Enabled = .F.`/`.Enabled = .T.` em runtime (fora do bloco AddObject inicial) onde o botao foi declarado com `Caption = ""` + `.Picture`, e remove as linhas. Solucao (a) — a mais segura.

**Bug**: Formsigrecmc.prg cmd_4c_SelTudo/cmd_4c_Apaga (task052, erro8.PNG, 2026-07-01). `TxtNmOperacaoKeyPress` desabilitava os botoes quando Movimentacao era preenchida (comportamento SCX original). Icones sumiam. Fix: removidas as linhas `.Enabled = .F./.T.` dos botoes; mantido apenas `grd_4c_Dados.Enabled`.

---

## 111. Container de botoes sobre Grid causa "ghost trails" ao scrollar (FormBuscaAuxiliar 2026-07-01)

**Bug**: Container filho de Form com `CommandButton`s dentro + `BackStyle=0` (transparente) + posicao (Top..Top+Height) sobrepondo o retangulo do Grid irmao gera "ghost trails" — os botoes aparecem duplicados/multiplicados visualmente ao scrollar as linhas do Grid.

**Sintoma**: Ao abrir FormBuscaAuxiliar (ou qualquer form com container de botoes overlay em Grid) e arrastar a scrollbar da lista, os botoes "Selecionar"/"Cancela" aparecem stackados 3+ vezes verticalmente, poluindo visualmente a area do grid.

**Root cause**: `BackStyle=0` = container totalmente transparente. Grid re-renderiza rows na scroll operation (redraw parcial da area visivel). Sem fundo opaco por tras dos botoes que ficam por cima, cada redraw parcial do grid deixa um "carimbo" dos botoes na regiao afetada — VFP9 nao dispara re-render completo do container overlay quando a area por tras muda. Resultado: multiplas "copias" fantasmas dos botoes empilhadas.

**Fix canonico** — 2 opcoes:

**(a) Posicao FORA da bbox do Grid** (preferido — sem overlay):

```foxpro
* Assumindo grid.Top=82 + grid.Height=224 -> grid.bottom = 306
THIS.AddObject("grd_4c_Lista", "Grid")
WITH THIS.grd_4c_Lista
    .Top    = 82
    .Height = 224   && bottom = 306
    ...
ENDWITH

* CORRETO — container abaixo do grid
THIS.AddObject("cnt_4c_Botoes", "Container")
WITH THIS.cnt_4c_Botoes
    .Top       = 310   && FORA da bbox (grid.bottom + margem)
    .Left      = 232
    .Width     = 138
    .Height    = 56
    .BackStyle = 0    && transparente OK - sem overlay com grid
    ...
ENDWITH
```

**(b) `BackStyle=1` + `BackColor` opaco** (se overlay for necessario por design):

```foxpro
* ERRADO — overlay + transparente => ghost trails
WITH THIS.cnt_4c_Botoes
    .Top       = 252   && DENTRO do grid area (grid.bottom=306)
    .BackStyle = 0    && !!! ghost trails no scroll
    ...
ENDWITH

* CORRETO — overlay OK, mas com fundo opaco
WITH THIS.cnt_4c_Botoes
    .Top       = 252   && overlay intencional
    .BackStyle = 1
    .BackColor = RGB(255, 255, 255)   && fundo branco opaco limpa area
    ...
ENDWITH
```

**Regra**: Antes de definir `.BackStyle = 0` em Container que tem `CommandButton` dentro, verificar se ha `Grid` irmao no mesmo parent Form/Container. Se as bboxes se sobrepoem, forcar `.BackStyle = 1` + `.BackColor = RGB(255,255,255)` OU mover Top para fora da bbox do Grid.

**Aplica-se a**: qualquer form com Container de CommandButtons overlay em Grid — comum em FormBuscaAuxiliar/FormBuscaSimples, forms operacionais com toolbar sobre grade, forms REPORT com botoes ao lado de grid de selecao.

**Auto-fix**: CorretorAutomatico Pattern #107 (`Corrigir-ContainerBotoesOverlayGrid`). Detecta Container declarado com CommandButton dentro (`AddObject("cmd_4c_*"...)`) + `.BackStyle = 0` cuja bbox sobrepoe Grid irmao. Forca `.BackStyle = 1` + `.BackColor = RGB(255,255,255)` (preserva Top intencional; se layout precisar de "fora do grid" isso deve vir do SCX original).

**Bug**: `C:\4c\projeto\app\classes\FormBuscaAuxiliar.prg` cnt_4c_Botoes (task052, Erro9.PNG, 2026-07-01). Container tinha `Top=252` (grid `Top=82 + Height=224 = 306` → overlay) + `BackStyle=0`. Fix aplicado: `Height=375` (form), `Top=310` (container abaixo do grid), `BackStyle=1 + BackColor=RGB(255,255,255)` (defesa em profundidade).

---

## 112. OptionGroup.Buttons(N).Value != 0 marca todos radio buttons simultaneamente (Formsigregli 2026-07-01)

**Bug**: `WITH OptionGroup.Buttons(N)` com `.Value = M` (onde M != 0 e != 1) faz o radio button aparecer sempre marcado. Se multiplos Buttons(N) tem `.Value = N` (padrao 2, 3, 4...), TODOS os radios do grupo aparecem selecionados de uma vez — comportamento visual quebrado.

**Sintoma**: OptionGroup com 3+ opcoes mostra todos os radio buttons circulares preenchidos (indicando "selecionado"). Usuario nao consegue trocar visualmente entre opcoes; primeira interacao pode desmarcar tudo ou marcar apenas um. Estado inconsistente.

**Root cause**: Confusao entre duas propriedades diferentes:

| Propriedade | Tipo | Semantica |
|-------------|------|-----------|
| `OptionGroup.Value` | INTEGER (1..N) | Qual dos N botoes esta selecionado (0=nenhum) |
| `OptionButton.Value` (Buttons(N)) | BOOLEAN (0/1) | Este botao individual esta marcado ou nao |

O gerador LLM confunde os dois e transcreve o valor semantico do OptionGroup para cada OptionButton individual. Como VFP9 trata QUALQUER numero nao-zero como truthy no OptionButton.Value, `Value=2/3/4/5/6` = todos "marcados".

**Fix canonico**:

```foxpro
* ERRADO — todos os radio buttons aparecem marcados
loc_oPg.AddObject("obj_4c_Tipo", "OptionGroup")
WITH loc_oPg.obj_4c_Tipo
    .ButtonCount = 3
ENDWITH
WITH loc_oPg.obj_4c_Tipo.Buttons(1)
    .Caption = "Op" + CHR(231) + CHR(227) + "o A"
    .Value   = 1     && OK — significa "marcado"
ENDWITH
WITH loc_oPg.obj_4c_Tipo.Buttons(2)
    .Caption = "Op" + CHR(231) + CHR(227) + "o B"
    .Value   = 2     && BUG — VFP9 trata como truthy, botao aparece marcado
ENDWITH
WITH loc_oPg.obj_4c_Tipo.Buttons(3)
    .Caption = "Op" + CHR(231) + CHR(227) + "o C"
    .Value   = 3     && BUG — mesmo
ENDWITH

* CORRETO — OptionGroup.Value controla qual esta selecionado
loc_oPg.AddObject("obj_4c_Tipo", "OptionGroup")
WITH loc_oPg.obj_4c_Tipo
    .ButtonCount = 3
    .Value       = 1     && default: 1o botao selecionado (0=nenhum)
ENDWITH
WITH loc_oPg.obj_4c_Tipo.Buttons(1)
    .Caption = "Op" + CHR(231) + CHR(227) + "o A"
    * NAO setar .Value — deixar default 0
ENDWITH
WITH loc_oPg.obj_4c_Tipo.Buttons(2)
    .Caption = "Op" + CHR(231) + CHR(227) + "o B"
    * NAO setar .Value
ENDWITH
WITH loc_oPg.obj_4c_Tipo.Buttons(3)
    .Caption = "Op" + CHR(231) + CHR(227) + "o C"
    * NAO setar .Value
ENDWITH
```

**Regra**: dentro de `WITH ...Buttons(N)` (onde N > 0), NUNCA setar `.Value = M` com M > 1. Se quiser default selection, setar apenas `OptionGroup.Value = indice`. `Buttons(1).Value = 1` eh valido tambem (equivalente a `OptionGroup.Value = 1`), mas nao consistente com como VFP9 espera — evitar.

**Aplica-se a**: qualquer OptionGroup migrado do SCX. Nao se aplica a CommandGroup (Buttons(N) de CommandGroup nao tem semantica de radio).

**Como prevenir**: quando extrair propriedades do SCX, `Option1.Value = 0` do source → NAO transcrever para `Buttons(1).Value = ...` no migrado. Somente `OptionGroup.Value = X` deve ser transcrito.

**Auto-fix**: CorretorAutomatico Pattern #108 (`Corrigir-OptionButtonValueSpurio`). Detecta linha `.Value = M` (M != 0 e != 1) dentro de bloco `WITH ...Buttons(N)/ENDWITH`, remove a linha. SCOPE limitado: apenas Buttons(N) — nao afeta OptionGroup.Value ou controles standalone.

**Bug**: Formsigregli.prg (task108, 2026-07-01) em 5 OptionGroups: `obj_4c_Get_Tipo` (6 buttons, Value=1..6), `obj_4c_TpOrdem` (Buttons(2).Value=2), `obj_4c_Get_Boleto` (Buttons(2..4).Value=2..4), `obj_4c_Get_Pedido` (Buttons(2).Value=2), `obj_4c_Opt_Ordem` (Buttons(2..4).Value=2..4). Todos os radio buttons apareciam marcados de uma vez.

---

## 113. TornarControlesVisiveis skip com LOOP deixa sub-controles hidden permanente (Formsigregli 2026-07-01)

**Bug**: Metodo recursivo `TornarControlesVisiveis` em forms OPERACIONAL/CRUD tem lista de skip para containers que devem comecar ocultos (`cnt_4c_Etiquetas`/`cnt_4c_Relacao` alternados por logica do form, `cnt_4c_Sombra` sempre visivel por outro caminho). Quando o skip usa `LOOP`, pula TANTO setar Visible do container QUANTO recursar dentro dele. Sub-controles ficam com `Visible=.F.` permanente. Quando logica posterior mostra o container (`container.Visible=.T.`), o container aparece VAZIO — filhos nao ficaram visiveis.

**Sintoma**: Usuario seleciona opcao no form (ex: "Etiquetas" no OptionGroup Tipo de Impressao) e a area que deveria mostrar sub-controles filhos (Divididas, Imprimir, Processos, etc.) aparece completamente vazia.

**Root cause**: `AddObject()` cria controles com `Visible=.F.` por padrao (essa eh a semantica do VFP9). Forms OPERACIONAL usam `TornarControlesVisiveis` recursivo apos ConfigurarPaginaDados para setar `Visible=.T.` em todos filhos criados. Quando ha container hidden-por-default (que sera mostrado depois por logica), o skip com `LOOP` pula tudo — nem recursa. Sub-controles nunca recebem `Visible=.T.`

**Fix canonico** — recursar ANTES do LOOP:

```foxpro
* ERRADO — sub-controles ficam Visible=.F. permanente
PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
    LOCAL loc_i, loc_oControl
    FOR loc_i = 1 TO par_oContainer.ControlCount
        loc_oControl = par_oContainer.Controls(loc_i)
        IF INLIST(UPPER(loc_oControl.Name), "CNT_4C_SOMBRA", "CNT_4C_ETIQUETAS", "CNT_4C_RELACAO")
            LOOP   && !!! pula recursao — filhos ficam hidden
        ENDIF
        IF PEMSTATUS(loc_oControl, "Visible", 5)
            loc_oControl.Visible = .T.
        ENDIF
        IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
            THIS.TornarControlesVisiveis(loc_oControl)
        ENDIF
    ENDFOR
ENDPROC

* CORRETO — recursar dentro do container skipped ANTES do LOOP
PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
    LOCAL loc_i, loc_oControl
    FOR loc_i = 1 TO par_oContainer.ControlCount
        loc_oControl = par_oContainer.Controls(loc_i)
        IF INLIST(UPPER(loc_oControl.Name), "CNT_4C_SOMBRA", "CNT_4C_ETIQUETAS", "CNT_4C_RELACAO")
            *-- Container preserva estado inicial hidden, mas RECURSAR para
            *-- tornar sub-controles Visible=.T. antes do container ser mostrado
            IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                THIS.TornarControlesVisiveis(loc_oControl)
            ENDIF
            LOOP
        ENDIF
        IF PEMSTATUS(loc_oControl, "Visible", 5)
            loc_oControl.Visible = .T.
        ENDIF
        IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
            THIS.TornarControlesVisiveis(loc_oControl)
        ENDIF
    ENDFOR
ENDPROC
```

**Regra**: em `TornarControlesVisiveis` (ou variantes), skip com LOOP para containers hidden-por-default SEMPRE deve recursar em sub-controles antes do LOOP. Objetivo do skip eh preservar `Visible` do CONTAINER — sub-controles devem receber `Visible=.T.` para aparecerem quando container for mostrado.

**Aplica-se a**: forms OPERACIONAL com containers alternados por logica (typical: Tipo de Impressao / modo de operacao / paginas custom que nao usam PageFrame). Padrao: Container criado `Visible=.F.`, mostrado posteriormente por handler de evento.

**Como prevenir**: quando gerar `TornarControlesVisiveis` ou funcao equivalente com skip list, o corpo do IF de skip DEVE ter recursao antes do LOOP. Nunca apenas `LOOP` puro para container com sub-controles.

**Auto-fix**: CorretorAutomatico Pattern #109 (`Corrigir-TornarControlesVisiveisSkipRecursivo`). Detecta `PROCEDURE TornarControlesVisiveis` contendo `IF INLIST(...) [tres-linhas ou menos] LOOP ENDIF` sem chamada recursiva `THIS.TornarControlesVisiveis(...)` dentro. Injeta bloco `IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0 / THIS.TornarControlesVisiveis(loc_oControl) / ENDIF` antes do LOOP.

**Bug**: Formsigregli.prg (task108, 2026-07-01). Containers `cnt_4c_Etiquetas` e `cnt_4c_Relacao` criados com `Visible=.F.` (correto — alternados por `TipoInteractiveChange`). `TornarControlesVisiveis` pulava eles com LOOP puro. Quando usuario selecionava Tipo (ex: Etiquetas), o container ficava visivel mas TODOS os sub-controles invisiveis. User via container vazio.

## 114. fAcessoEmpresa() NAO foi portada — usar VerificarAcessoEmpresa/FormBuscaAuxiliar (Formsigatcrp/Formsigrepes 2026-07-02)

**Sintoma runtime**: `File 'facessoempresa.prg' does not exist` — Procedure ValidarEmp/ValidarEmpresa, ao digitar codigo empresa (Tab/Enter/F4).

**Causa**: A funcao global `fAcessoEmpresa()` do Framework legado (`C:\4c\Framework\sigacess.PRG:732`) NAO foi portada para a nova arquitetura. Quando codigo migrado a chama sem prefixo (`fAcessoEmpresa(...)` em vez de `THIS.metodo()`), VFP9 procura por `facessoempresa.prg` externo — arquivo que nao existe. Diferente do topico #6 (metodo PROTECTED sem THIS.), aqui NAO existe um metodo local — a funcao legado precisa ser SUBSTITUIDA por outro mecanismo.

**Codigo ERRADO (2 modos)**:

```foxpro
* MODO CHECK (3 args) — apenas verifica acesso, retorna boolean
llOk = fAcessoEmpresa(gc_4c_UsuarioLogado, "C", csEmpUsu.Cemps)

* MODO LOOKUP (5 args) — valida + popula 2 textboxes
fAcessoEmpresa(gc_4c_UsuarioLogado, "C", loc_cVal, THIS.txt_4c_Emp, THIS.txt_4c_Demp)
=fAcessoEmpresa(gc_4c_UsuarioLogado, "D", loc_oP1.txt_4c_DsEmpresa.Value, ;
    loc_oP1.txt_4c_CdEmpresa, loc_oP1.txt_4c_DsEmpresa)
```

**Codigo CORRETO — MODO CHECK**:

```foxpro
* Chamada -> helper em utils/functions.prg
llOk = VerificarAcessoEmpresa(gc_4c_UsuarioLogado, csEmpUsu.Cemps)
```

Helper `VerificarAcessoEmpresa(cUsuario, cCodEmp)` (declarado em `utils/functions.prg`, apos `fChecaAcesso`) preserva regras do legado:
- Usuario `4CONTROL` -> acesso total (.T.)
- Usuario SEM registros em `SigCdAcE` -> acesso irrestrito (.T.)
- Caso contrario, exige linha `SigCdAcE.Usuarios = usu AND .Emps = emp`

**Codigo CORRETO — MODO LOOKUP** (substituir por bloco FormBuscaAuxiliar):

```foxpro
* Modo C: chave = Cemps (codigo)
loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdEmp", ;
    "cursor_4c_BuscaEmp", "Cemps", loc_cVal, ;
    "Sele" + CHR(231) + CHR(227) + "o de Empresa", .T.)
IF VARTYPE(loc_oBusca) = "O"
    IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
        IF USED("cursor_4c_BuscaEmp")
            THIS.txt_4c_Emp.Value  = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
            THIS.txt_4c_Demp.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
        ENDIF
    ELSE
        IF !loc_oBusca.this_lAchouRegistro
            loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
            loc_oBusca.Show()
            * ... (populacao pos-Show)
        ENDIF
    ENDIF
    loc_oBusca.Release()
ENDIF
```

Para MODO D (busca por descricao), trocar `"Cemps"` por `"Razas"` na chamada CREATEOBJECT e inverter a ordem das mAddColuna (Razas primeiro, Cemps depois).

**Regra**: qualquer chamada `fAcessoEmpresa(` (com ou sem `=`, `!`, atribuicao) em codigo migrado eh SEMPRE bug — a funcao NAO existe na nova arquitetura. Ao migrar `Get_Empresa.Valid` / `getEmpresa.Valid` / `get_cd_empresa.Valid` do legado, gerar diretamente uma das duas substituicoes acima em vez de chamar `fAcessoEmpresa`.

**Aplica-se a**: forms REPORT e OPERACIONAL com filtro de Empresa (getEmpresa+getDesEmpresa / txt_CdEmpresa+txt_DsEmpresa / txt_Emp+txt_Demp). Ambos textboxes precisam handler Valid/LostFocus/KeyPress apontando ao lookup em SigCdEmp.

**Como prevenir**: no prompt Phase B / OPERACIONAL / REPORT (regra "fAcessoEmpresa() NAO EXISTE (nao portada)"), o gerador ja recebe orientacao para gerar diretamente `VerificarAcessoEmpresa` (modo check) ou bloco FormBuscaAuxiliar (modo lookup).

**Auto-fix**: CorretorAutomatico Pattern #110 (`Corrigir-fAcessoEmpresa`). Detecta `fAcessoEmpresa(usu,"C",cod)` (3 args, uso "check") e substitui por `VerificarAcessoEmpresa(usu, cod)`. Para 5-args (uso "lookup"), NAO auto-substitui (bloco multi-linha exige contexto do form) — emite warning para o gerador reescrever manualmente.

**Bug**: Formsigatcrp.prg (Erro14, 2026-07-02) — `ValidarEmp` linha 2290 e `ValidarDemp` linha 2313. Formsigrepes.prg (2026-07-02) — 4 chamadas (SCAN de acesso 4274, CmdLancClick 6213, `ValidarEmpresa` 6505, `ValidarDsEmpresa` 7188). Padrao canonico apos correcao: `Formsigatcrp.prg:2278-2378`.

## 115. fAcessoContas() PROIBIDO para lookup UX — auto-carrega primeiro registro sem selecao (Formsigatcrp Gerente/Vendedor 2026-07-02)

**Sintoma UX**: user digita parte de codigo em txtCod<X> (ex: "11" em Gerente), da Tab/Enter, e o form auto-preenche txtNom<X> com o PRIMEIRO registro cujo IClis contenha "11" (ex: `"1101 - GAVETA LOJA 001 CHAMPA JOIAS"`) SEM abrir picker ou permitir escolha. User espera picker listando todos os codigos comecando com "11".

**Causa**: `fAcessoContas()` (utils/functions.prg:719) foi portada do legado sigacess.PRG e funcionalmente executa, mas seu fluxo interno tem UX inadequada para lookup:
1. Query com `LIKE '%valor%'` (**contains**, nao starts-with) — traz registros com valor em qualquer posicao
2. `LOCATE FOR crAc4.IClis = pTxt` — busca exato. Se falha (partial), abre picker `FormBuscaSimples`
3. Apos picker fechar (mesmo por cancel/ESC), popula pSt1/pSt2 com `crAc4.IClis`/`crAc4.Descr` do **registro atual** do cursor — que pode ser o primeiro (posicao default) ou o que o grid posicionou

Diferente de `fAcessoEmpresa()` (topic #114) que nao existe, `fAcessoContas()` **existe e executa** — o problema eh comportamental, nao runtime.

**Codigo ERRADO**:

```foxpro
PROCEDURE ValidarCodGer(par_nKeyCode, par_nShiftAltCtrl)
    IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
        RETURN
    ENDIF
    loc_cVal = ALLTRIM(THIS.txt_4c_CodGer.Value)
    IF !EMPTY(loc_cVal)
        IF !fAcessoContas(gc_4c_UsuarioLogado, "", "C", loc_cVal, ;
                THIS.txt_4c_CodGer, THIS.txt_4c_NomGer)
            MsgAviso("Acesso Negado !!")
            ...
        ENDIF
    ENDIF
ENDPROC
```

**Codigo CORRETO** (mesmo padrao do fix Erro15 Empresa):

```foxpro
PROCEDURE ValidarCodGer(par_nKeyCode, par_nShiftAltCtrl)
    LOCAL loc_cVal, loc_nResult
    IF par_nKeyCode = 115
        THIS.AbrirBuscaGer()
        RETURN
    ENDIF
    IF par_nKeyCode != 13 AND par_nKeyCode != 9
        RETURN
    ENDIF
    loc_cVal = ALLTRIM(THIS.txt_4c_CodGer.Value)
    IF EMPTY(loc_cVal)
        THIS.txt_4c_NomGer.Value = ""
        THIS.txt_4c_NomGer.Refresh
        RETURN
    ENDIF
    TRY
        loc_nResult = SQLEXEC(gnConnHandle, ;
            "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cVal), ;
            "cursor_4c_GerVal")
        IF loc_nResult > 0 AND USED("cursor_4c_GerVal") AND !EOF("cursor_4c_GerVal")
            SELECT cursor_4c_GerVal
            THIS.txt_4c_CodGer.Value = ALLTRIM(cursor_4c_GerVal.IClis)
            THIS.txt_4c_NomGer.Value = ALLTRIM(cursor_4c_GerVal.RClis)
        ELSE
            THIS.AbrirBuscaGer()
        ENDIF
        IF USED("cursor_4c_GerVal")
            USE IN cursor_4c_GerVal
        ENDIF
    CATCH TO loc_oErro
        MsgErro(loc_oErro.Message, "Erro")
    ENDTRY
ENDPROC

PROCEDURE AbrirBuscaGer()
    LOCAL loc_oBusca, loc_cValor, loc_cSQL, loc_nResult, loc_cTitulo
    loc_cValor  = ALLTRIM(THIS.txt_4c_CodGer.Value)
    IF EMPTY(loc_cValor)
        loc_cValor = ALLTRIM(THIS.txt_4c_NomGer.Value)
    ENDIF
    loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o de Gerente"

    IF USED("cursor_4c_BuscaGer")
        USE IN cursor_4c_BuscaGer
    ENDIF

    TRY
        IF EMPTY(loc_cValor)
            loc_cSQL = "SELECT IClis, RClis FROM SigCdCli ORDER BY IClis"
        ELSE
            loc_cSQL = "SELECT IClis, RClis FROM SigCdCli " + ;
                       "WHERE IClis LIKE " + EscaparSQL(loc_cValor + "%") + ;
                       " OR RTRIM(RClis) LIKE " + EscaparSQL(loc_cValor + "%") + ;
                       " ORDER BY IClis"
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGer")

        *-- Fallback: se filtro nao trouxe nada, mostra lista completa
        IF (loc_nResult < 1 OR RECCOUNT("cursor_4c_BuscaGer") = 0) AND !EMPTY(loc_cValor)
            IF USED("cursor_4c_BuscaGer")
                USE IN cursor_4c_BuscaGer
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT IClis, RClis FROM SigCdCli ORDER BY IClis", ;
                "cursor_4c_BuscaGer")
        ENDIF

        IF loc_nResult < 1 OR RECCOUNT("cursor_4c_BuscaGer") = 0
            MsgAviso("Nenhum gerente encontrado.", "Gerente")
            RETURN
        ENDIF

        *-- Cria picker SEM SQL automatica (nao passa par_cTabela)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaGer"
            loc_oBusca.this_cTitulo        = loc_cTitulo
            loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
            loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
            loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("RClis", "", "Nome")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGer")
                SELECT cursor_4c_BuscaGer
                THIS.txt_4c_CodGer.Value = ALLTRIM(cursor_4c_BuscaGer.IClis)
                THIS.txt_4c_NomGer.Value = ALLTRIM(cursor_4c_BuscaGer.RClis)
            ENDIF
            loc_oBusca.Release()
        ENDIF
    CATCH TO loc_oErro
        MsgErro(loc_oErro.Message, "Erro")
    ENDTRY
    IF USED("cursor_4c_BuscaGer")
        USE IN cursor_4c_BuscaGer
    ENDIF
ENDPROC
```

**ValidarNom<X>**: espelho de ValidarCod<X> — SQL exato em `RTRIM(RClis) = valor`, so ativo quando txt_4c_Cod<X> vazio, miss chama mesmo `AbrirBusca<X>()`.

**Regra**: qualquer chamada `fAcessoContas(usu, grp, "C"|"D", val, oCod, oDsc)` em codigo migrado como handler de Valid/KeyPress/LostFocus eh SEMPRE bug UX. Ao migrar `Get_Ger.Valid` / `getCodGer.Valid` / `getVendedor.Valid` do legado, gerar diretamente o padrao SQL exato + `AbrirBusca<X>()`+ `FormBuscaAuxiliar` acima. `fAcessoContas()` **continua valida** para contexto backend (validacao de acesso sem UI, SCAN loops em SQL builders).

**Aplica-se a**: forms REPORT/OPERACIONAL com filtros Gerente / Vendedor / Cliente / Fornecedor via SigCdCli. Ambos textboxes (Cod<X> + Nom<X>) precisam handlers KeyPress simetricos.

**Como prevenir**: no prompt REPORT / OPERACIONAL / Phase B (regra "fAcessoContas() NAO USAR para lookup UX"), o gerador ja recebe orientacao para NAO usar fAcessoContas em handlers de textbox.

**Auto-fix**: NAO ha pattern automatico. Transformacao eh multi-linha e requer contexto do form (nomes dos textboxes, tabela SigCdCli filtrada por grupo, tipo de campo). CorretorAutomatico poderia injetar comentario-warning ao detectar `fAcessoContas(...)` com 6 args + textbox reference (`THIS.txt_4c_*`), mas isso duplica valor limitado — o prompt eh a linha de defesa principal.

**Excecao consciente**: `fAcessoContas()` com filtro de grupo especifico (ex: `Cliente` em Formsigatcrp usa `loc_lcGrupo` do contexto) PODE ter semantica intencional (limitar clientes a grupo especifico). Nesses casos, avaliar caso-a-caso antes de substituir; nao aplicar substituicao automatica cega.

**Bug**: Formsigatcrp.prg (Erro16, 2026-07-02) — 4 chamadas em `ValidarCodGer` linha 2621, `ValidarNomGer` linha 2651, `ValidarCodVen` linha 2677, `ValidarNomVen` linha 2707. `ValidarCliente`/`ValidarNomCli` NAO tocadas (passam `loc_lcGrupo` — possivel semantica intencional). Padrao canonico apos correcao: `Formsigatcrp.prg:2612-2790`.

## 116. .RecordMark/.DeleteMark em CommandButton engole erro em `InicializarForm` -> `CREATEOBJECT` retorna .F. silenciosamente (Formsigrepes 2026-07-02)

**Sintoma UX**: user seleciona item no menu (ex: Relatorios > Posicao de Estoque), aparece dialog "Erro ao criar formulario de Posicao de Estoque / VARTYPE retornou: L". Form NAO abre. Sem stack trace, sem detalhe do erro.

**Causa raiz dupla**:
1. **Propriedade invalida**: gerador copia `.RecordMark = .F.` + `.DeleteMark = .F.` (validos para Grid — barras laterais de marcacao) e cola em WITH de CommandButton adjacente (padrao classico: botoes `cmd_4c_SelXxx` / `cmd_4c_DslXxx` ao lado de grids de selecao multipla em Page1 de forms REPORT). VFP9 trava com `Property RECORDMARK is not found` ao instanciar o form.
2. **CATCH silencioso em `InicializarForm`**: template do `PROCEDURE InicializarForm` gera TRY/CATCH que apenas armazena `THIS.this_cMensagemErro = loc_oErro.Message` e seta `loc_lSucesso = .F.` — SEM chamar `MsgErro()`. Como `CREATEOBJECT("FormXxx")` retorna `.F.` quando `InicializarForm` retorna `.F.`, o proc `AbrirFormXxx` no menu detecta `VARTYPE(loForm) != "O"` e mostra apenas "VARTYPE retornou: L" — sem o erro subjacente. Debug quase impossivel sem instrumentacao.

**Codigo ERRADO**:

```foxpro
*-- Botao ao lado de grid de selecao multipla
loc_oPage.AddObject("cmd_4c_SelOrigMerc", "CommandButton")
WITH loc_oPage.cmd_4c_SelOrigMerc
    .Top         = 217
    .Left        = 405
    .Height      = 45
    .Width       = 45
    .Caption     = ""
    .Picture     = gc_4c_CaminhoIcones + "geral_selecionar_26.jpg"
    .ToolTipText = "Selecionar"
    .Themes      = .F.
    .Visible     = .T.
    .RecordMark   = .F.    && <-- ERRADO: CommandButton nao tem
    .DeleteMark   = .F.    && <-- ERRADO: CommandButton nao tem
ENDWITH
```

**Codigo CORRETO**:

```foxpro
loc_oPage.AddObject("cmd_4c_SelOrigMerc", "CommandButton")
WITH loc_oPage.cmd_4c_SelOrigMerc
    .Top         = 217
    .Left        = 405
    .Height      = 45
    .Width       = 45
    .Caption     = ""
    .Picture     = gc_4c_CaminhoIcones + "geral_selecionar_26.jpg"
    .ToolTipText = "Selecionar"
    .Themes      = .F.
    .Visible     = .T.
ENDWITH
```

**Regra**: `.RecordMark` e `.DeleteMark` sao propriedades EXCLUSIVAS de Grid (e classes derivadas como GridBase). QUALQUER outro controle (CommandButton, Label, Container, TextBox, ComboBox, Spinner, OptionButton, CheckBox, PageFrame, Page, Shape, Image, EditBox, ListBox, OptionGroup, CommandGroup) causa runtime error "Property RECORDMARK is not found" quando o form for instanciado.

**Recomendacao complementar — CATCH VERBOSO em InicializarForm**: alterar o template do `PROCEDURE InicializarForm` para logar o erro no CATCH em vez de engolir:

```foxpro
CATCH TO loc_oErro
    THIS.this_cMensagemErro = loc_oErro.Message
    MsgErro("Erro em InicializarForm: " + loc_oErro.Message + ;
        " | LN=" + TRANSFORM(loc_oErro.LineNo) + ;
        " | PROC=" + loc_oErro.Procedure)
    loc_lSucesso = .F.
ENDTRY
```

Sem esse `MsgErro`, todo erro de instanciacao vira "VARTYPE retornou: L" no menu — inutil para debug. Aplicar em NOVOS forms gerados e em templates de refactor.

**Aplica-se a**: forms REPORT/OPERACIONAL/CRUD com grids de selecao multipla + CommandButtons "Sel"/"Dsl" adjacentes (padrao classico de filtros com marcacao). Formsigrepes.prg tinha 9 CommandButtons afetados (SelOrigMerc, SelTipoInvs, SelLinha, SelGrupo, SelGrpVenda, SelSitTrib, SelCor, SelSubgrupo, SelClasFis) — todos ao lado de grids na Page1.

**Como prevenir**: no prompt REPORT / OPERACIONAL / Phase A (regra ".RecordMark/.DeleteMark SO em Grid"), gerador recebe orientacao explicita para nao copiar essas propriedades em CommandButton.

**Auto-fix**: CorretorAutomatico Pattern #111 (`Corrigir-CommandButtonRecordMarkInvalido`). Fase 1: mapeia todos os nomes de objetos criados via `AddObject("<nome>", "<tipo>")` onde tipo != "Grid". Fase 2: dentro de blocos `WITH <objetoNaoGrid>`, remove linhas `.RecordMark = .F.` e `.DeleteMark = .F.` (qualquer indent/espaco). Preserva ocorrencias em WITH de Grid.

**Bug**: Formsigrepes.prg (Erro17, 2026-07-02) — 9 CommandButtons corrompidos + CATCH silencioso escondendo o erro. Padrao canonico apos correcao: `Formsigrepes.prg:1631-1671, 2696-3076`.


## 117. fwprogressbar NAO PORTADA — instalar stub em classes/fwprogressbar.prg (Formsigrepes 2026-07-02)

**Sintoma UX**: user seleciona item no menu (ex: Relatorios > Posicao de Estoque), aparece dialog "Erro ao criar formulario de Posicao de Estoque / VARTYPE retornou: L". Form NAO abre. Sintoma identico ao Erro17 (.RecordMark em CommandButton) mas causa diferente.

**Causa raiz**: A classe `fwprogressbar` do Framework legado (barra de progresso para queries pesadas) foi usada em REPORT/OPERACIONAL forms migrados (ex: `CREATEOBJECT("fwprogressbar", "Aguarde! Montando Filtros...", 18)` em `MCursor()`) MAS a classe NAO foi portada para a nova arquitetura. VFP9 procura `fwprogressbar.prg` externo, NAO encontra, dispara "Class 'fwprogressbar' is not found" (ou similar) durante Init. CATCH silencioso em `InicializarForm` engole a exception -> `Init()` retorna `.F.` -> `CREATEOBJECT("FormXxx")` retorna `.F.` (Logical) -> menu handler mostra "VARTYPE retornou: L". Debug quase impossivel sem CATCH verboso.

**Codigo ERRADO** (form usa fwprogressbar sem stub instalado):

```foxpro
PROCEDURE MCursor
    LOCAL loc_oBarraCr
    loc_oBarraCr = CREATEOBJECT("fwprogressbar", "Aguarde! Montando Filtros...", 18)
    loc_oBarraCr.Show()   && Class not found -> exception -> CATCH silencioso em InicializarForm
    ...
ENDPROC
```

**Correcao (2 passos)**:

1. **Criar stub em `C:\4c\projeto\app\classes\fwprogressbar.prg`** com interface esperada pelos chamadores:

```foxpro
DEFINE CLASS fwprogressbar AS Form
    Height = 90
    Width = 380
    AutoCenter = .T.
    BorderStyle = 1
    Caption = "Aguarde..."
    ControlBox = .F.
    AlwaysOnTop = .T.
    this_nTotal = 0
    this_nAtual = 0

    ADD OBJECT Titulo AS Label WITH Top=8, Left=10, Width=360, Height=18, ;
        AutoSize=.F., FontName="Tahoma", FontSize=9, FontBold=.T., BackStyle=0, Caption=""
    ADD OBJECT SubTitulo AS Label WITH Top=28, Left=10, Width=360, Height=14, ;
        AutoSize=.F., FontName="Tahoma", FontSize=8, BackStyle=0, Caption=""
    ADD OBJECT shpThermBg AS Shape WITH Top=48, Left=10, Width=360, Height=18, ;
        BorderColor=RGB(120,120,120), FillColor=RGB(240,240,240), FillStyle=0
    ADD OBJECT shpThermBar AS Shape WITH Top=49, Left=11, Width=1, Height=16, ;
        BorderColor=RGB(0,120,215), FillColor=RGB(0,120,215), FillStyle=0
    ADD OBJECT lblPercentage AS Label WITH Top=68, Left=10, Width=360, Height=14, ;
        AutoSize=.F., Alignment=2, FontName="Tahoma", FontSize=8, BackStyle=0, Caption="0%"

    PROCEDURE Init
        LPARAMETERS par_cTitulo, par_nTotal
        IF VARTYPE(par_cTitulo) = "C"
            THIS.Titulo.Caption = par_cTitulo
        ENDIF
        THIS.this_nTotal = IIF(VARTYPE(par_nTotal) = "N" AND par_nTotal > 0, par_nTotal, 1)
        THIS.this_nAtual = 0
        RETURN .T.
    ENDPROC

    PROCEDURE Update
        LPARAMETERS par_lRefresh
        THIS.this_nAtual = MIN(THIS.this_nAtual + 1, THIS.this_nTotal)
        LOCAL loc_nPct
        loc_nPct = INT((THIS.this_nAtual / THIS.this_nTotal) * 100)
        THIS.shpThermBar.Width = MAX(1, INT((loc_nPct / 100.0) * 358))
        THIS.lblPercentage.Caption = TRANSFORM(loc_nPct) + "%"
        IF par_lRefresh
            THIS.Refresh
        ENDIF
    ENDPROC

    PROCEDURE Complete
        LPARAMETERS par_lRefresh
        THIS.this_nAtual = THIS.this_nTotal
        THIS.shpThermBar.Width = 358
        THIS.lblPercentage.Caption = "100%"
        IF par_lRefresh
            THIS.Refresh
        ENDIF
        THIS.Hide()
    ENDPROC
ENDDEFINE
```

2. **Registrar em `C:\4c\projeto\app\start\config.prg`** apos as outras `CarregarSeExistir` de classes base:

```foxpro
CarregarSeExistir(gcCaminhoClasses + "fwprogressbar.prg")
```

**Interface esperada pelos chamadores** (formalize em qualquer alteracao do stub):
- `CREATEOBJECT("fwprogressbar", cTitulo, nTotal)` — construtor
- `.Show()` — exibe modal com 0%
- `.Update(.T.)` — incrementa 1 unidade, refresca
- `.Complete(.T.)` — seta 100% e fecha
- `.Titulo`, `.SubTitulo`, `.lblPercentage` — Labels acessiveis externamente (ex: `loc_oBar.Titulo.FontBold = .T.`)

**Aplica-se a**: forms REPORT/OPERACIONAL que fazem processamento pesado (queries SQL longas, calculo de saldos, movimentacoes). BOs de processamento como `SigPrCccBO.prg` (7 chamadas) tambem. Detecta-se via `grep -c "fwprogressbar" *.prg` — se > 0, verificar se stub existe em classes/.

**Como prevenir**: prompt REPORT/OPERACIONAL/Phase B agora orienta gerador a criar o stub se ainda nao existir e registrar em config.prg.

**Auto-fix**: nao automavel via CorretorAutomatico (que edita 1 form por vez). Verificacao manual OU via script one-shot que faz `grep -l fwprogressbar app/forms/**/*.prg` -> se algum encontrar E stub nao existe em `classes/fwprogressbar.prg` -> criar stub + registrar em config.prg.

**Bug**: Formsigrepes.prg + SigPrCccBO.prg (Erro17, 2026-07-02) — 15 chamadas a fwprogressbar em Formsigrepes + 7 em SigPrCccBO sem classe portada.


## 118. KeyPress handler: LPARAMETERS + guard Enter/Tab/F4 obrigatorios (Formsigrepes 2026-07-02)

**Sintoma UX**: user abre form REPORT/OPERACIONAL, tudo carrega, mas ao **digitar o primeiro caractere em um campo de lookup** (ex: Empresa, Grupo, Fornecedor), aparece dialog "Erro Detalhado / Erro ao abrir Relatorio de Posicao de Estoque / Erro: No PARAMETER statement is found. / Linha: 6489 / Procedure: validarempresa". Form fica travado.

**Causa raiz dupla**:

1. **LPARAMETERS ausente**: Handlers bindados a KeyPress via `BINDEVENT(txt, "KeyPress", THIS, "Nome")` — VFP9 passa 2 argumentos automaticos (`nKeyCode`, `nShiftAltCtrl`) para o handler. Se o handler NAO declara `LPARAMETERS par_nKeyCode, par_nShiftAltCtrl` na primeira linha do corpo, VFP dispara "No PARAMETER statement is found" no primeiro keystroke. Erro engolido silenciosamente se CATCH de InicializarForm ou menu handler nao for verboso.
2. **Guard ausente em handlers de LOOKUP**: Mesmo apos adicionar LPARAMETERS, se o handler abre `FormBuscaAuxiliar` (picker modal) SEM guard, o picker abre a CADA tecla digitada. User digita "0" -> picker abre com busca "0" -> user nao consegue digitar "1" (modal ativo). UX quebrada. Padrao correto: guard imediatamente apos LPARAMETERS.

**Codigo ERRADO** (sem LPARAMETERS, sem guard):

```foxpro
PROCEDURE ValidarEmpresa
    LOCAL loc_oP1, loc_oBusca
    loc_oP1 = THIS.pgf_4c_Paginas.Page1
    IF !EMPTY(loc_oP1.txt_4c_CdEmpresa.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdEmp", ...)
        ...
    ENDIF
ENDPROC
```

**Codigo CORRETO** (padrao canonico):

```foxpro
PROCEDURE ValidarEmpresa
    LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
    IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
        RETURN
    ENDIF
    LOCAL loc_oP1, loc_oBusca
    loc_oP1 = THIS.pgf_4c_Paginas.Page1
    IF !EMPTY(loc_oP1.txt_4c_CdEmpresa.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdEmp", ...)
        ...
    ENDIF
ENDPROC
```

**Semantica das teclas** (par_nKeyCode):
- `13` = ENTER — commit do valor digitado
- `9` = TAB — commit + navegacao
- `115` = F4 — forcar abertura do picker (mesmo com campo vazio)
- Outras teclas -> RETURN (handler NAO executa)

**Excecao — handlers de checkbox mutual-exclusion**: Handlers `ValidarChk*` que apenas toggle-checkbox para exclusao mutua (ex: `IF chk_A.Value = 1 THEN chk_B.Value = 0`) NAO precisam do guard 13/9/115 — sao inocuous se rodarem em qualquer keystroke. Mas AINDA precisam de LPARAMETERS senao rebentam.

**Padrao canonico**: `Formsigatcrp.prg:2614-2624` (ValidarCodGer) e `Formsigrepes.prg:6488-6497` (ValidarEmpresa).

**Aplica-se a**: TODOS handlers bindados a KeyPress via BINDEVENT — tipico prefixo `Validar*` (lookup + validacao) mas tambem `GridChk*KeyPress`, `Btn*KeyPress`, etc.

**Como prevenir**: prompt REPORT/OPERACIONAL/Phase A/Phase B agora orienta gerador a emitir LPARAMETERS + guard 13/9/115 em todo handler bindado a KeyPress.

**Auto-fix**:
- **Pattern #30 (`Corrigir-BindEventSemParametros`) — estendido**: detecta agora `PROCEDURE Handler` (SEM parens) alem de `PROCEDURE Handler()`. Injeta `LPARAMETERS par_nKeyCode, par_nShiftAltCtrl` como nova linha imediatamente apos, indentada consistente com o proximo `LOCAL`/comando.
- **Pattern #112 (novo, `Corrigir-KeyPressGuardLookup`)**: detecta `PROCEDURE Validar*` bindado a KeyPress que contem `CREATEOBJECT("FormBuscaAuxiliar"...)` no corpo, injeta guard `IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115 / RETURN / ENDIF` apos LPARAMETERS.

**Bug**: Formsigrepes.prg (Erro18, 2026-07-02) — 32 handlers `Validar*` sem LPARAMETERS (crash no primeiro keystroke) + 24 handlers de lookup sem guard (picker abrindo a cada tecla).


## 119. FormBuscaAuxiliar manual-API NAO POPULA cursor -> picker abre vazio (Formsigrepes 2026-07-02)

**Sintoma UX**: user digita codigo em campo de lookup + ENTER -> picker abre com grid VAZIO (nenhum registro listado), mesmo que a tabela tenha muitos registros. Cabecalho do grid pode ate mostrar as colunas configuradas mas nao ha linhas.

**Causa raiz**: FormBuscaAuxiliar tem 2 APIs distintas:

1. **Init API (correta)**: `CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "Tabela", "cursor", "Campo", cVal, "Titulo", .T.[, .T., cFiltro])` — o Init dispara SQLEXEC internamente: primeiro tenta match exato `WHERE Campo = cVal`, se falhar tenta LIKE `WHERE Campo LIKE 'cVal%'`. Popula cursor.
2. **Manual API (broken)**: `CREATEOBJECT("FormBuscaAuxiliar")` SEM params -> Init apenas chama `CriarControles()` sem SQL. Depois o codigo seta `this_cTabela`/`this_cCampoBusca`/`this_cValorBusca`/`this_cCursorDestino`/`mAddColuna(...)` e chama `.Show()`. Mas `Show()` -> `ConfigurarGrid()` -> `IF !USED(THIS.this_cCursorDestino) RETURN` — cursor NAO existe (nenhuma SQLEXEC foi feita) -> grid abre VAZIO.

Alem disso, o codigo manual-API frequentemente seta propriedades **inexistentes** em FormBuscaAuxiliar: `this_cFiltro`, `this_cCursorOrigem`, `this_nMaxRegistros`, `this_cCampoChave` — VFP9 cria essas como propriedades DINAMICAS adhoc, mas elas NAO tem efeito nenhum (ConfigurarGrid nao le, Init nao le).

**Codigo ERRADO** (manual-API):

```foxpro
PROCEDURE ValidarLinha
    LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
    IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
        RETURN
    ENDIF
    LOCAL loc_oP1, loc_oBusca
    loc_oP1 = THIS.pgf_4c_Paginas.Page1
    IF EMPTY(loc_oP1.txt_4c_Linha.Value)
        loc_oP1.txt_4c_DLinha.Value = SPACE(40)
    ELSE
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")          && SEM params
        loc_oBusca.this_cTabela = "SigCdLin"                    && seta props avulsas
        loc_oBusca.this_cCampoChave = "Linhas"                  && propriedade INEXISTENTE
        loc_oBusca.this_cCampoBusca = "Linhas"
        loc_oBusca.this_cValorBusca = loc_oP1.txt_4c_Linha.Value
        loc_oBusca.mAddColuna("Linhas", "", "Linhas")
        loc_oBusca.mAddColuna("Descs", "", "Descricao")
        loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
        loc_oBusca.Show()                                        && Grid VAZIO — nunca houve SQLEXEC
        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
            loc_oP1.txt_4c_Linha.Value = cursor_4c_Busca.Linhas
            loc_oP1.txt_4c_DLinha.Value = cursor_4c_Busca.Descs
        ENDIF
    ENDIF
ENDPROC
```

**Codigo CORRETO (Opcao A) — Init com params**:

```foxpro
PROCEDURE ValidarLinha
    LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
    IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
        RETURN
    ENDIF
    LOCAL loc_oP1
    loc_oP1 = THIS.pgf_4c_Paginas.Page1
    THIS.AbrirLookup(loc_oP1.txt_4c_Linha, loc_oP1.txt_4c_DLinha, ;
        "SigCdLin", "Linhas", "Descs", "Linhas", loc_oP1.txt_4c_Linha.Value, ;
        "cursor_4c_BuscaLin", "Linhas", "", par_nKeyCode = 115)
ENDPROC
```

Onde `AbrirLookup` eh o **helper canonico** em `Formsigrepes.prg:3318-3385`:

```foxpro
PROTECTED PROCEDURE AbrirLookup(par_oTxtCod, par_oTxtDesc, par_cTabela, ;
    par_cCampoCod, par_cCampoDesc, par_cCampoBusca, par_cValorBusca, ;
    par_cCursor, par_cTitulo, par_cFiltro, par_lForcarPicker)

    LOCAL loc_cVal, loc_oBusca, loc_cSQL, loc_cWhereBase
    loc_cVal = ALLTRIM(IIF(VARTYPE(par_cValorBusca) = "C", par_cValorBusca, ""))
    loc_cWhereBase = IIF(!EMPTY(par_cFiltro), " AND (" + par_cFiltro + ")", "")

    IF EMPTY(loc_cVal) AND !par_lForcarPicker
        par_oTxtDesc.Value = ""
        par_oTxtCod.Refresh
        par_oTxtDesc.Refresh
        RETURN
    ENDIF

    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, par_cTabela, ;
        par_cCursor, par_cCampoBusca, loc_cVal, par_cTitulo, .T., .T., par_cFiltro)
    IF VARTYPE(loc_oBusca) != "O"
        RETURN
    ENDIF

    IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro AND !par_lForcarPicker
        IF USED(par_cCursor)
            par_oTxtCod.Value  = ALLTRIM(EVALUATE(par_cCursor + "." + par_cCampoCod))
            par_oTxtDesc.Value = ALLTRIM(EVALUATE(par_cCursor + "." + par_cCampoDesc))
        ENDIF
    ELSE
        *-- Popular cursor completo antes de Show (evita grid vazio)
        IF USED(par_cCursor)
            USE IN (par_cCursor)
        ENDIF
        IF EMPTY(loc_cVal)
            loc_cSQL = "SELECT * FROM " + par_cTabela + ;
                IIF(!EMPTY(par_cFiltro), " WHERE " + par_cFiltro, "") + ;
                " ORDER BY " + par_cCampoBusca
        ELSE
            loc_cSQL = "SELECT * FROM " + par_cTabela + " WHERE CAST(" + par_cCampoBusca + ;
                " AS VARCHAR(100)) LIKE " + EscaparSQL(loc_cVal + "%") + loc_cWhereBase + ;
                " ORDER BY " + par_cCampoBusca
        ENDIF
        IF SQLEXEC(gnConnHandle, loc_cSQL, par_cCursor) < 1 OR RECCOUNT(par_cCursor) = 0
            *-- Fallback: lista completa
            IF USED(par_cCursor)
                USE IN (par_cCursor)
            ENDIF
            =SQLEXEC(gnConnHandle, "SELECT * FROM " + par_cTabela + ;
                IIF(!EMPTY(par_cFiltro), " WHERE " + par_cFiltro, "") + ;
                " ORDER BY " + par_cCampoBusca, par_cCursor)
        ENDIF
        loc_oBusca.mAddColuna(par_cCampoCod,  "", "C" + CHR(243) + "digo")
        loc_oBusca.mAddColuna(par_cCampoDesc, "", "Descri" + CHR(231) + CHR(227) + "o")
        loc_oBusca.Show()
        IF loc_oBusca.this_lSelecionou AND USED(par_cCursor)
            par_oTxtCod.Value  = ALLTRIM(EVALUATE(par_cCursor + "." + par_cCampoCod))
            par_oTxtDesc.Value = ALLTRIM(EVALUATE(par_cCursor + "." + par_cCampoDesc))
        ELSE
            IF !par_lForcarPicker
                par_oTxtCod.Value  = ""
                par_oTxtDesc.Value = ""
            ENDIF
        ENDIF
    ENDIF
    loc_oBusca.Release()
    IF USED(par_cCursor)
        USE IN (par_cCursor)
    ENDIF
    par_oTxtCod.Refresh
    par_oTxtDesc.Refresh
ENDPROC
```

**Codigo CORRETO (Opcao B) — pre-popular cursor manualmente**:

```foxpro
IF USED("cursor_4c_BuscaLin")
    USE IN cursor_4c_BuscaLin
ENDIF
=SQLEXEC(gnConnHandle, "SELECT * FROM SigCdLin WHERE Linhas LIKE " + EscaparSQL(cVal + "%") + " ORDER BY Linhas", "cursor_4c_BuscaLin")

loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaLin"
loc_oBusca.mAddColuna("Linhas", "", "Codigo")
loc_oBusca.mAddColuna("Descs", "", "Descricao")
loc_oBusca.Show()   && Agora Show ve o cursor USED -> ConfigurarGrid bind funciona
```

**Semantica das propriedades reais de FormBuscaAuxiliar** (declaradas em `classes/FormBuscaAuxiliar.prg`):
- `this_cTabela` — nome da tabela SQL Server (usado se chamou Init com params)
- `this_cCursorDestino` — nome do cursor onde vai o SELECT (obrigatorio para Show funcionar)
- `this_cCampoBusca` — coluna a pesquisar
- `this_cValorBusca` — valor de busca (armazenado, mas SQL apenas roda se Init teve params)
- `this_lSelecionou` — .T. se user clicou Selecionar (ou match exato encontrado)
- `this_lAchouRegistro` — .T. se match exato foi encontrado no Init

**Aplica-se a**: TODOS os handlers que abrem FormBuscaAuxiliar — tipicamente `Validar*` em REPORT/OPERACIONAL/CRUD.

**Como prevenir**: prompt REPORT/OPERACIONAL/Phase A/Phase B agora orienta gerador a usar Init com params (Opcao A com helper `AbrirLookup`) ou pre-popular cursor (Opcao B).

**Auto-fix**: NAO automavel — refatoracao estrutural (helper reutilizavel + rewrite dos handlers). CorretorAutomatico poderia DETECTAR o anti-pattern (CREATEOBJECT("FormBuscaAuxiliar") vazio + setters de props) e emitir warning para revisao manual, mas o fix ideal requer entender contexto de dominio (tabela, filtro, cursor destino).

**Bug**: Formsigrepes.prg (Erro18, 2026-07-02) — 13 handlers `Validar*` com manual-API abriam picker vazio: ValidarLinha, ValidarGrandeGrupo, ValidarFip, ValidarGrupoProduto, ValidarSubgrupo, ValidarProduto, ValidarDescricao, ValidarDsGrupoProd, ValidarDsSubgrupo, ValidarDLinha, ValidarDFip, ValidarDsGGrupo, ValidarRefFornecedor. Refatorados para helper `AbrirLookup`.


## 120. REPORT Buttons(N).Left + Width DEVE caber em CommandGroup.Width (Formsigrepes 2026-07-02)

**Sintoma UX**: 4 botoes do cabecalho REPORT (Visualizar/Imprimir/Arquivos Email/Encerrar) aparecem parcialmente cortados — Encerrar (Buttons(4)) fica com metade da largura ou sumido pela borda direita do CommandGroup.

**Causa raiz**: SCX legado tinha geometria compativel com CommandGroup Width maior (ex: SigReAac com Width=310, Buttons Width=75, Lefts=5/80/155/230 -> ends 305 fits). Mas quando o form migrado tem CommandGroup Width **menor** (ex: 273, canonico framework btnReport) e o gerador copiou Lefts do SCX legado (5/80/155/230, inc 75) mantendo Buttons Width original (65), o ultimo botao transborda:

- Buttons(4) ends = 230 + 65 = **295** > CommandGroup Width **273** -> overflow **22px** cortado.

Gerador nao valida `MAX(Buttons[i].Left + Buttons[i].Width) <= CommandGroup.Width` — passa geometria incompativel e VFP9 renderiza silenciosamente com clipping.

**Codigo ERRADO**:

```foxpro
THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
WITH THIS.cmg_4c_Botoes
    .Width = 273
    .ButtonCount = 4
ENDWITH
WITH THIS.cmg_4c_Botoes.Buttons(4)   && Encerrar
    .Left = 230       && 230 + 65 = 295 > 273 -> CORTADO
    .Width = 65
    ...
ENDWITH
```

**Codigo CORRETO (padrao canonico framework btnReport com gap 2 — fits Width=273)**:

```foxpro
WITH THIS.cmg_4c_Botoes.Buttons(1)   && Visualizar
    .Left = 5
    .Width = 65
ENDWITH
WITH THIS.cmg_4c_Botoes.Buttons(2)   && Imprimir
    .Left = 72        && 5 + 65 + 2 = 72
    .Width = 65
ENDWITH
WITH THIS.cmg_4c_Botoes.Buttons(3)   && Arquivos Email
    .Left = 139       && 72 + 65 + 2 = 139
    .Width = 65
ENDWITH
WITH THIS.cmg_4c_Botoes.Buttons(4)   && Encerrar
    .Left = 206       && 139 + 65 + 2 = 206
    .Width = 65        && 206 + 65 = 271 <= 273 OK
ENDWITH
```

**Formulas para calcular Lefts validos**:

Dado `CG_Width` (CommandGroup Width) e `Btn_Width` (Buttons Width) e 4 botoes:
- `Total_Btn = 4 * Btn_Width` (soma das larguras)
- `Free_Space = CG_Width - Total_Btn - 5*margem_esq` (espaco livre para gaps + margens laterais)
- `Gap = FLOOR(Free_Space / 3)` (3 gaps entre 4 botoes)
- `Lefts = 5, 5+Btn_Width+Gap, 5+2*(Btn_Width+Gap), 5+3*(Btn_Width+Gap)`

Para CG=273, Btn=65: Total=260, Free=273-260-5=8, Gap=2. Lefts=5/72/139/206.
Para CG=310, Btn=75: Total=300, Free=310-300-5=5, Gap=1. Lefts=5/81/157/233 (ou 5/80/155/230 do SCX ends 305 fits).

**Framework defaults** (rule 3205 no prompt REPORT): CG=273, Btn=65, Lefts=5/71/137/203 (inc 66, gap 1, ends 268).
**Alternativo canonico** (usado no Formsigrepes fix): CG=273, Btn=65, Lefts=5/72/139/206 (gap 2, ends 271).

**Aplica-se a**: TODOS os REPORT forms — validar sempre que `MAX(Buttons[i].Left + Buttons[i].Width) <= cmg_4c_Botoes.Width` na Fase A. SCX legado com geometria incompativel deve ser normalizada pelo gerador.

**Como prevenir**: prompt REPORT agora orienta gerador a validar Left+Width <= CommandGroup.Width e recalcular se necessario.

**Auto-fix**: **CorretorAutomatico #113 (novo, `Corrigir-CmgReportButtonsOverflow`)**: (a) detecta bloco `AddObject("cmg_4c_Botoes", "CommandGroup")` + `.Width = N`; (b) coleta Left+Width de todos os Buttons; (c) se `MAX(Left+Width) > cmg.Width`, recalcula Lefts com formula acima (gap FLOOR((Width - Total_Btn - 5) / 3)) e substitui.

**Bug**: Formsigrepes.prg (Erro19, 2026-07-02) — CommandGroup Width=273, Buttons Width=65, Lefts=5/80/155/230 (copiados do SCX SigReAac que tem CG Width=310). Encerrar renderizava cortado 22px. Fix aplicado: Lefts=5/72/139/206.


## 121. MsgAviso("...encontrada") antes de THIS.AbrirBusca<X>() — anti-padrao de UX (FormSIGREADS 2026-07-02)

**Sintoma UX**: user digita codigo em campo de lookup (Empresa, Vendedor, Operacao, Moeda, etc.) e pressiona Enter/Tab. Aparece dialog blocking "Empresa nao encontrada / OK". User clica OK. Um segundo dialog abre (o picker). Mas o picker esta com grid parcialmente/totalmente vazio ou nao filtrado — porque **o valor digitado foi limpo entre o Aviso e o Picker**.

**Causa raiz**: gerador emite handler `Validar<Campo>` com padrao errado no ramo ELSE do match exato:

```foxpro
PROCEDURE ValidarEmpresa
    ...
    IF loc_nResult > 0 AND !EOF("cursor_val")
        <fill fields>
    ELSE
        MsgAviso("Empresa n" + CHR(227) + "o encontrada.", "Empresa")   && ← REDUNDANTE
        loc_oPagina.txt_4c_Empresa.Value    = ""                          && ← QUEBRA UX (perde LIKE prefix)
        loc_oPagina.txt_4c_DesEmpresa.Value = ""
        THIS.AbrirBuscaEmpresa()                                          && picker abre SEM prefix
    ENDIF
ENDPROC
```

Problemas:
1. **Dialog blocking desnecessario**: user tem que clicar OK antes do picker abrir. 2 modais em sequencia.
2. **Feedback visual redundante**: o proprio picker abrindo JA indica "nao achou match exato". Nenhum ganho semantico.
3. **Valor digitado perdido**: `.Value = ""` limpa o campo ANTES do picker abrir. `AbrirBuscaEmpresa` le `loc_oPagina.txt_4c_Empresa.Value` como valor de busca — encontra string vazia -> picker abre com todos os registros (sem filtro LIKE prefix).
4. **Assustador**: "nao encontrada" soa como erro. Nao eh — eh apenas match nao exato, um caso comum.

**Codigo ERRADO** (padrao gerado pelo migrador em ~49 forms):

```foxpro
ELSE
    MsgAviso("Vendedor n" + CHR(227) + "o encontrado.", "Vendedor")
    loc_oPagina.txt_4c_Vended.Value = ""
    loc_oPagina.txt_4c_Dvend.Value  = ""
    THIS.AbrirBuscaVended()
ENDIF
```

**Codigo CORRETO** (padrao canonico apos fix):

```foxpro
ELSE
    *-- Miss no match exato: abrir picker direto (LIKE prefix usa valor digitado)
    THIS.AbrirBuscaVended()
ENDIF
```

Beneficios:
- **1 modal apenas** (picker) — user nao precisa clicar OK antes.
- **Valor digitado preservado** — picker le txt_4c_Vended.Value que ainda tem o valor. Faz LIKE prefix (`WHERE Nome LIKE 'X%'`) e lista opcoes relacionadas.
- **Feedback visual** ainda claro — picker abrindo indica que precisa selecionar.

**Aplica-se a**: TODOS os handlers `Validar<Campo>` que abrem `AbrirBusca<X>()` como fallback do match exato. Detecta-se via grep: `MsgAviso.*encontrad.*THIS\.AbrirBusca`.

**Como prevenir**: prompt REPORT/OPERACIONAL/Phase A/Phase B agora orienta gerador a NAO emitir MsgAviso + clear-field antes de AbrirBusca — usar apenas AbrirBusca direto.

**Auto-fix**: **CorretorAutomatico #114 (novo, `Corrigir-MsgAvisoAntesDoPicker`)**: detecta `MsgAviso(...encontrad...)` seguido em ate 5 linhas por `THIS.AbrirBusca<X>()`. Aceita linhas intermediarias de clear-field (`.Value = ""` ou `.Value = SPACE(N)`) e linhas em branco. Qualquer outra coisa entre eles cancela o match. Remove a linha MsgAviso E as linhas de clear-field, preserva `THIS.AbrirBusca<X>()`, injeta comentario `*-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix`.

**Bug**: FormSIGREADS.prg (Erro20, 2026-07-02) — 4 handlers (ValidarEmpresa/ValidarVended/ValidarOperacao/ValidarMoeda) com o padrao. Aplicado em batch em 49 forms com mesmo anti-padrao — **38 forms tiveram fixes aplicados, 224 correcoes totais**. Preservado `MsgAviso("Nenhum dado encontrado para os filtros selecionados")` legitimo em Excel export (linha 1780) que NAO eh anti-padrao (message + RETURN, sem picker).


## 122. SigCdGcr tem coluna `descrs` (com 'r'), NAO `descs` — confusao classica com SigCdGpr/SigCdLin/SigCdCol (FormSIGREAEG 2026-07-02)

**Sintoma UX**: user digita codigo em campo "Grupo de Estoque" (ou "Grupo Contabil") e pressiona Enter/Tab. Aparece dialog Microsoft Visual FoxPro: **"Connectivity error: [Microsoft][ODBC SQL Server Driver][SQL Server]Nome de coluna 'descs' invalido."**. Form fica inutilizavel.

**Causa raiz**: schema real de `SigCdGcr` (Grupo Contabil de Cadastros — Grupo de Estoque) tem coluna **`descrs`** com 'r' entre 'sc' e 's'. Outras tabelas com nome parecido tem coluna diferente:

| Tabela | Coluna descricao | Nota |
|--------|------------------|------|
| **SigCdGcr** (Grupo Estoque) | **`descrs`** char(40) | Indice `[descrs]` linha 21685 |
| SigCdGpr (Grande Grupo) | `descs` char(40) | Indice `[descs]` linha ~21747 |
| SigCdLin (Linha) | `descs` char(...) | Indice `[descs]` linha 21915 |
| SigCdCol (Colecao) | `descs` char(...) | Indice `[descs]` linha 21269 |
| SigCdOpe (Operacao) | `Dopes` char(20) | PK+descricao — nao tem descs/descrs (pattern #105) |

Migrador gera lookup para SigCdGcr copiando template de outros lookups similares (SigCdGpr por exemplo) e usa `descs` — SQL Server rejeita. Erro engolido em CATCH silencioso ou aparece direto quando VFP9 ODBC exibe.

**Codigo ERRADO** (typical geracao para SigCdGcr):

```foxpro
loc_cSQL = "SELECT TOP 1 codigos, descs FROM SigCdGcr WHERE codigos = " + ;
           EscaparSQL(loc_cCodigo)
...
loc_oPagina.txt_4c_DsGrEstoque.Value = ALLTRIM(cursor.descs)

*-- No picker
loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
    "SigCdGcr", loc_cCursor, "codigos", loc_cValor, "Selecionar Grupo", "")
loc_oBusca.mAddColuna("codigos", "", "Codigo")
loc_oBusca.mAddColuna("descs",   "", "Descricao")   && ← ERRADO
...
loc_oPagina.txt_4c_DsGrEstoque.Value = ALLTRIM(descs)   && ← ERRADO
```

**Codigo CORRETO**:

```foxpro
loc_cSQL = "SELECT TOP 1 codigos, descrs FROM SigCdGcr WHERE codigos = " + ;
           EscaparSQL(loc_cCodigo)
...
loc_oPagina.txt_4c_DsGrEstoque.Value = ALLTRIM(cursor.descrs)

loc_oBusca.mAddColuna("descrs",  "", "Descricao")
loc_oPagina.txt_4c_DsGrEstoque.Value = ALLTRIM(descrs)
```

**Contextos afetados** por PROCEDURE:
1. **SELECT clause em SQLEXEC**: `SELECT codigos, descs FROM SigCdGcr` -> `descrs`
2. **Cursor reference**: `cursor_4c_SigCdGcr.descs` -> `descrs`
3. **mAddColuna do picker**: `mAddColuna("descs", ...)` dentro de bloco AbrirBusca* que abre FormBuscaAuxiliar sobre SigCdGcr
4. **ALLTRIM(descs) apos SELECT (cursor)**: variavel implicita apos setar alias

**Aplica-se a**: TODOS os forms/BOs que fazem lookup em `SigCdGcr` (Grupo de Estoque, Grupo Contabil). Detecta-se via grep: linhas com `SigCdGcr` E `descs` no mesmo escopo (mesma PROCEDURE ou mesmo SQL statement).

**Como prevenir**: prompt REPORT/OPERACIONAL/Phase B agora orienta gerador a consultar `docs/schema.sql` para colunas reais de tabelas com sufixo comum (Gcr vs Gpr vs Lin vs Col vs Ope). Regra generica: NUNCA assumir nome de coluna por analogia — SEMPRE ler schema.sql. Nomes diferentes de tabelas irmas na mesma familia do sistema (Sig*Cd*) sao esperados.

**Auto-fix**: **CorretorAutomatico #115 (novo, `Corrigir-SigCdGcrDescrsColuna`)**: Fase 1 identifica cursores derivados de SigCdGcr (via SQLEXEC `FROM SigCdGcr` + destino cursor, e via FormBuscaAuxiliar Init com "SigCdGcr"). Fase 2 corrige `descs` em linhas com SigCdGcr, em `<cursor>.descs` e dentro de blocos AbrirBusca* de SigCdGcr (mAddColuna, ALLTRIM apos SELECT).

**Bug**: FormSIGREAEG.prg (Erro21, 2026-07-02) + sweep global em FormSIGREEGG.prg, FormSigReCsp.prg, Formsigreegp.prg. 4 forms, ~14 refs corrigidas.

## 123. REPORT FORM estoura "Invalid path or file name" quando `gcLogoRel` aponta para logo.bmp inexistente (FormRelPlanoContas 2026-07-03)

**Sintoma runtime**: user clica "Visualizar" em form REPORT, `REPORT FORM (loc_cArquivoFRX) PREVIEW NOCONSOLE` estoura `"Invalid path or file name."` no `TRY/CATCH` do menu (`AbrirRelXxx`), com `Linha=449 Procedure=btnvisualizarclick`. Aparente contradiacao: `IF FILE(loc_cArquivoFRX)` **passou** (o FRX existe), mas `REPORT FORM` falhou logo depois. FRX check foi TRUE + REPORT FORM falhou = problema NAO eh o FRX principal.

**Causa raiz** (config-level, afeta TODOS os FRX legados que referenciam `gcLogoRel`):
- `config.prg:95` setava incondicionalmente `gc_4c_LogoRelatorio = ADDBS(gc_4c_CaminhoIcones) + "logo.bmp"`, propagado em `config.prg:134` para o alias legado `gcLogoRel`.
- Arquivo `C:\4c\vbmp\logo.bmp` **NAO EXISTE** no repositorio (nunca foi copiado do sistema legado).
- Todos os FRX migrados/importados do Framework legado tem uma Image com `Picture = gcLogoRel` + `Print When = not empty(gcLogoRel)`.
- Como `gcLogoRel` NAO estava vazio (era string com path invalido), `Print When = not empty("...\logo.bmp") = .T.` → VFP tenta carregar a imagem em runtime → arquivo nao existe → runtime error **"Invalid path or file name."** dentro do REPORT FORM.
- FRX+FRT sao validos; o erro NAO eh no arquivo do relatorio — eh na imagem embutida.

**Fix config-level** (`config.prg:93-100`, aplicado 2026-07-03):
```foxpro
* Logo para relatorios (usa caminho relativo)
* IMPORTANTE: Se o arquivo nao existir, deixar vazio para o Print When
* "not empty(gcLogoRel)" dos FRXs legados retornar .F. e nao tentar carregar
* imagem inexistente (causa "Invalid path or file name" em REPORT FORM).
PUBLIC gc_4c_LogoRelatorio
gc_4c_LogoRelatorio = ADDBS(gc_4c_CaminhoIcones) + "logo.bmp"
IF NOT FILE(gc_4c_LogoRelatorio)
    gc_4c_LogoRelatorio = ""
ENDIF
```

Assim `gcLogoRel = ""` (linha 134 propaga), Print When retorna `.F.` e VFP pula a imagem sem tentar carregar.

**Fix form-level defensivo** (`FormRelPlanoContas.prg:442-491`, boa pratica para TODO form REPORT):
```foxpro
PROCEDURE BtnVisualizarClick()
    LOCAL loc_cArquivoFRX, loc_oErro
    TRY
        loc_cArquivoFRX = FULLPATH(gc_4c_CaminhoReports + "relplanocontas.frx")
        IF THIS.ValidarFiltros()
            IF THIS.Processamento()
                IF FILE(loc_cArquivoFRX)
                    REPORT FORM (loc_cArquivoFRX) PREVIEW NOCONSOLE
                ELSE
                    MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + loc_cArquivoFRX, "Erro")
                ENDIF
            ELSE
                MostrarErro("Erro ao processar relat" + CHR(243) + "rio.", "Erro")
            ENDIF
        ENDIF
    CATCH TO loc_oErro
        MostrarErro("Erro ao visualizar relat" + CHR(243) + "rio:" + CHR(13) + ;
                   "Erro: " + loc_oErro.Message + CHR(13) + ;
                   "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
    ENDTRY
    THIS.Refresh()
ENDPROC
```

Dois beneficios: (1) `FULLPATH()` normaliza path removendo `..\` (mais robusto para APIs VFP que rejeitam paths com `..\`); (2) `TRY/CATCH` local expoe mensagem descritiva ao inves de propagar para o handler generico do menu com "Erro ao abrir Relatorio de X".

**Aplica-se a**:
- **Config**: `config.prg` (aplicado 1x, resolve globalmente para todos os FRX que usam `gcLogoRel`)
- **Prompt REPORT**: gerador de forms REPORT DEVE emitir `BtnVisualizarClick`/`BtnImprimirClick` com TRY/CATCH + `FULLPATH()` padrao canonico (referencia: `Formsigrecgr.prg:564-611` no BO + `FormSigReCmp.prg:1486-1512` no form)

**Como prevenir**:
- Config-level: **JA APLICADO** — enquanto `config.prg` mantiver o guard `IF NOT FILE(...)`, novos FRXs legados que referenciam `gcLogoRel` funcionam de graca.
- Se logo.bmp for adicionado a `C:\4c\vbmp\`, a guarda cai naturalmente (path fica valido, imagem renderiza — comportamento esperado do sistema original).
- Form-level: templates de REPORT (prompt block) agora orientam TRY/CATCH + FULLPATH obrigatorios em `BtnVisualizarClick`/`BtnImprimirClick`.

**Auto-fix**: NAO automavel. (1) A guarda em config.prg eh 1-shot, ja aplicada. (2) O TRY/CATCH em handlers de REPORT FORM eh refatoracao estrutural sensivel a estilo do gerador — melhor documentar no prompt do que auto-aplicar via regex. Se surgirem mais forms com o mesmo anti-padrao, considerar CorretorAutomatico wrap-in-try-catch.

**Bug**: FormRelPlanoContas.prg (Erro22, 2026-07-03). Diagnostico complicado porque `IF FILE(loc_cArquivoFRX)` passava (FRX existe) — devemos suspeitar de picture-references dentro do FRT em erros "Invalid path or file name" quando o FRX principal esta acessivel.


## 124. INDEX ON composto (A+B) com SEEK parcial FALHA 100% com SET EXACT ON (PlanoContasBO 2026-07-03)

**Sintoma runtime**: Relatorio Plano de Contas gerado sem os registros de nivel folha (contas analiticas / clientes SigCdCli). Report mostra ate nivel intermediario correto (Titulo -> Grupo -> Sub-grupo -> Conta = niveis 1-4 do SigCdCss + SigCdGcr) mas o nivel 5 (registros de SigCdCli, tipicamente `IClis="1110100001"` GAVETA, `IClis="C000001"` clientes, etc.) some completamente. Nenhuma exception, nenhum MsgErro — o processamento roda ate o fim silenciosamente com o cursor `cPlconta` incompleto.

**Causa raiz** (interacao SET EXACT ON x INDEX composto x SEEK parcial):

`config.prg:193` seta `SET EXACT ON` globalmente. Com `EXACT ON`, o comportamento de `SEEK()` muda:
- Com `EXACT OFF` (default VFP): SEEK acha primeira entrada cujo prefixo bate com a chave de busca — funciona bem em qualquer indice.
- Com `EXACT ON`: SEEK exige match da CHAVE INTEIRA do indice contra a chave de busca — se chave de busca tem N chars e chave do indice tem M chars (N != M), SEEK retorna .F. sempre.

Codigo problematico (`PlanoContasBO.prg:71` antes do fix):
```foxpro
loc_cSQL = "SELECT Grupos, IClis, RClis FROM SigCdCli"
SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdCli")
SELECT crSigCdCli
INDEX ON Grupos + IClis TAG Grupos   && chave composta: 10 + 10 = 20 chars
```

Depois em `GerarRelatorio()` sub-fase 3 (`PlanoContasBO.prg:316`):
```foxpro
loc_cLsGrupo = cPlconta.cContas          && C(10), ex: "11101     "
SELECT crSigCdCli
SET ORDER TO Grupos
IF SEEK(loc_cLsGrupo, "crSigCdCli", "Grupos")   && SEEK com 10 chars vs indice de 20 chars
    ...  && NUNCA entra aqui com EXACT ON
ENDIF
```

Com `EXACT ON`, SEEK("11101     ") contra "11101     0000000001" (entrada real do indice composto Grupos+IClis) exige match integral dos 20 chars — impossivel porque a chave de busca so tem 10 chars. `IF SEEK()` cai silenciosamente, sub-fase 3 pula todos os inserts, `cPlconta` fica sem os niveis-folha.

**Por que Sub-fase 2 (grupos) funcionava**:

O cursor `crSigCdGcr` usa indice single-column: `INDEX ON Classes TAG Classes` (chave 10 chars). `SEEK(loc_cLsClasse, "crSigCdGcr", "Classes")` passa 10 chars contra indice de 10 chars — match integral bate, `EXACT ON` nao quebra. Por isso os grupos (nivel 4) apareciam.

**Fix aplicado** (`PlanoContasBO.prg:75` e `SigRePlcBO.prg:74`):
```foxpro
SELECT crSigCdCli
*-- Index single-column: SEEK usa apenas Grupos como chave.
*-- Composto (Grupos+IClis) quebra com SET EXACT ON porque
*-- a chave do SEEK (10 chars) nunca casa exato com a chave do
*-- indice (20 chars), fazendo o nivel 5 (clientes) sumir do relatorio.
INDEX ON Grupos TAG Grupos
```

`IClis` nao era usado no SEEK nem no `SCAN WHILE crSigCdCli.Grupos = loc_cLsGrupo` — o indice composto so servia como identificacao unica das linhas, sem valor funcional para o SEEK. Retirar `+ IClis` deixa a chave do indice em 10 chars (igual a chave do SEEK) e o match funciona.

**Alternativas quando compound key precisa ficar**:

Se algum outro uso do TAG realmente precisa da chave composta (multi-key seek, uniqueness enforcement), duas opcoes:

1. **Pad-completar a chave do SEEK** ate o tamanho da chave do indice:
   ```foxpro
   SEEK(loc_cLsGrupo + SPACE(10), "crSigCdCli", "Grupos")   && 10 + 10 = 20 chars
   ```
   Mas isso so funciona se souber exatamente que IClis daquele grupo comeca com espacos — impraticavel.

2. **SET EXACT OFF local** salvando/restaurando:
   ```foxpro
   LOCAL loc_cExact
   loc_cExact = SET("Exact")
   SET EXACT OFF
   IF SEEK(loc_cLsGrupo, "crSigCdCli", "Grupos")
       ...
   ENDIF
   IF loc_cExact = "ON"
       SET EXACT ON
   ENDIF
   ```
   Funciona mas polui o codigo com boilerplate SET/restore. Preferir single-column INDEX.

**Auditoria cross-file** (heuristica para detectar o mesmo bug em outros arquivos):

Para cada arquivo com `INDEX ON A + B TAG X` num cursor de trabalho:
- Listar todos os `SEEK(..., cursor, "X")` no mesmo arquivo.
- Se TODOS os SEEK usam apenas `A` (nao a chave composta A+B), o INDEX deveria ser single-column.
- Se algum SEEK usa `A + B` explicitamente, manter compound.

Regex approximation:
```
INDEX ON (\w+)\s*\+\s*(\w+)\s+TAG\s+(\w+)   && capturar A, B, TagName
SEEK\(.*,\s*"<cursor>",\s*"\3"\)             && procurar SEEKs do mesmo tag
```

Se todos os SEEK do TAG passam so o primeiro campo, converter para `INDEX ON \1 TAG \3`.

**Aplica-se a**:
- **Cursores temporarios criados via `SELECT ... INTO ...` + `INDEX ON A + B TAG X`** onde SEEK do codigo so passa `A`
- **REPORT**: BOs de relatorio com processamento em fases (expansao hierarquica) — Erro23 foi aqui
- **OPERACIONAL**: BOs de processamento (saldos/movimento) que fazem lookup em cursores em memoria
- **Phase B (funcionalidade)**: Sempre que gerador criar cursor + INDEX + SEEK

**Como prevenir**:
- Gerador (prompts REPORT/OPERACIONAL/Phase B): explicitamente orientar que INDEX ON composto so vale se todos os SEEK do TAG passarem a chave completa. Regra adicionada em `## Regras VFP Criticas` nos 3 blocos.
- Skill vfp9-migration: esta secao.
- Testes manuais: relatorio hierarquico com todos os niveis deve ser validado por contagem de paginas (Erro23 mostrava "001 de 005" vs original "001 de 028" — diferenca gigante sinalizava dados faltando).

**Auto-fix**: NAO trivialmente automavel. Detector precisaria correlacionar `INDEX ON A + B TAG X` com `SEEK(..., "X")` do mesmo cursor no mesmo arquivo, extrair a chave passada ao SEEK, verificar se e apenas `A`, e so entao converter. Isso e AST-level analysis, arriscado via regex por causa de indirecoes (SEEK numa variavel, SEEK com expressao concatenada, etc). Melhor: documentar como regra manual + auditar novos BOs quando forem criados.

**Bug**: PlanoContasBO.prg + SigRePlcBO.prg (Erro23, 2026-07-03) — relatorio Plano de Contas do sistema legado SIGREPLC perdeu contas analiticas / clientes SigCdCli. Reference: FormRelPlanoContas.prg usa `CREATEOBJECT("PlanoContasBO")` que roda `GerarRelatorio()` — antes do fix, cursor `cPlconta` tinha ~50 registros (grupos), depois do fix passou a ter centenas (com todos os clientes).

## 125. fwprogressbar stub — interface COMPLETA obrigatoria (Formsigrepes 2026-07-07)

**Problema**: Forms/BOs migrados que instanciam `fwprogressbar` (barra de progresso do framework legado) frequentemente acessam membros que o stub em `classes/fwprogressbar.prg` NAO expoe. Runtime estoura `Unknown member <NOME>` dentro de loops de processamento (SCAN WHILE com `.Update(.T.)`), tipicamente em `Processamento`/`MCursor`/`GerarRelatorio`.

**Membros GARANTIDOS pelo stub** (`C:\4c\projeto\app\classes\fwprogressbar.prg`):

| Membro | Tipo | Uso tipico no legado |
|--------|------|----------------------|
| `Titulo`        | Label | `loBarra.Titulo.Caption = "Processando..."` |
| `SubTitulo`     | Label | Mensagem secundaria (categoria, subprocesso) |
| `Rodape`        | Label | **`loBarra.Rodape.Caption = "<ESC> para interromper..."`** (adicionado 2026-07-07 apos Erro26) |
| `lblPercentage` | Label | Auto-atualizada por `.Update()` — nao acessar direto |
| `shpThermBg`    | Shape | Barra de fundo (borda cinza) |
| `shpThermBar`   | Shape | Barra de progresso (fill azul, cresce com `.Update()`) |
| `Init(cTitulo, nTotal)` | Method | Chamado por `CREATEOBJECT("fwprogressbar", cTit, nTot)` |
| `Update(lRefresh)`      | Method | Incrementa contador + repinta se `lRefresh=.T.` |
| `Complete(lRefresh)`    | Method | Seta 100% + Hide() |
| `Show()` / `Hide()`     | Method | Herdados de Form base |

**Codigo ERRADO** (form migrado tenta adicionar membro faltante como propriedade dinamica):
```foxpro
* Formsigrepes.prg linha 4562 (ANTES do fix - Erro26)
loBarra = CREATEOBJECT("fwprogressbar", "Processando Estoque...", lnTotal)
loBarra.Rodape.Caption = "<ESC> para interromper..."  && ERRO: Unknown member RODAPE
```

**Codigo CORRETO** (adicionar membro AO STUB, form fica intocado):
```foxpro
* classes/fwprogressbar.prg — adicionar Label Rodape + ajustar Height
DEFINE CLASS fwprogressbar AS Form
    Height = 108   && +18 para acomodar novo Label
    ...
    ADD OBJECT Rodape AS Label WITH ;
        Top       = 86, ;    && lblPercentage.Top(68) + 18
        Left      = 10, ;
        Width     = 360, ;
        Height    = 14, ;
        Alignment = 2, ;
        BackStyle = 0, ;
        Caption   = ""
ENDDEFINE
```

**Regra ABSOLUTA**: Se um membro do framework legado esta ausente do stub e o form migrado precisa dele, **SEMPRE adicionar ao stub — NUNCA alterar o form migrado**. Isso mantem os forms sincronizados com a interface esperada pelo framework original e evita divergencias entre forms.

**Detectar o problema**:
```powershell
# Listar todos os acessos a membros do fwprogressbar no codigo migrado
Grep -Pattern 'loBarra\.(\w+)|loc_oBarra\.(\w+)|loBarraFil\.(\w+)' -Path C:\4c\projeto\app -Glob '*.prg'
# Comparar com membros expostos em classes/fwprogressbar.prg (ADD OBJECT / PROCEDURE)
```

**Aplica-se a**:
- **REPORT**: BOs de relatorio com processamento pesado (relatorios financeiros, hierarquicos, retroativos)
- **OPERACIONAL**: BOs de saldo/custo/movimento — MCursor com scan de milhares de registros

**Auto-fix**: CorretorAutomatico Pattern #116 (`Corrigir-FwProgressBarStubMembros`) — verifica presenca dos membros canonicos no stub e adiciona ausentes. Pattern eh SEGURO porque so afeta o arquivo do stub (nao os forms migrados).

**Bug**: Formsigrepes.prg linha 4562 `loBarra.Rodape.Caption = "<ESC> para interromper..."` + linha 6442 `loc_oBarra.Rodape.Caption = "<ESC> para interromper..."` (Erro26, 2026-07-07). Fix: adicionado `ADD OBJECT Rodape AS Label` ao stub, `Height` 90→108. Referencia canonica: `classes/fwprogressbar.prg` completo.

## 126. REPORT FORM &var. (macro) OU REPORT FORM (var) (parenteses) SEM guard IF FILE() — helper canonico THIS.ExecutarReportForm() (Formsigrepes + FormSIGREVIS 2026-07-07)

**Problema**: Forms REPORT/OPERACIONAL migrados que abrem FRXs de duas formas equivalentes estouram "File does not exist" em runtime quando o FRX legado nao foi portado:
- **(a) Macro substitution**: `REPORT FORM &loc_cReportPath. PREVIEW NOCONSOLE` onde `loc_cReportPath = gc_4c_CaminhoReports + "SIGREPEX"` — comum em BOs/forms grandes migrados de Fortyus (Formsigrepes)
- **(b) Parenteses**: `REPORT FORM (loc_cFrxPath) PREVIEW NOCONSOLE` onde `loc_cFrxPath = gc_4c_CaminhoReports + "SigReVis.frx"` — comum em forms REPORT gerados pelo pipeline novo com FRX suffix ja incluso no valor (FormSIGREVIS)

A mensagem de erro NAO indica QUAL FRX falta — apenas o line number da procedure (Visualizacao/Impressao/Documento/BtnVisualizarClick). Dev fica sem saber qual arquivo precisa criar.

**Codigo ERRADO** (Formsigrepes.prg pre-fix — 15 chamadas em Visualizacao/Impressao/Documento):
```foxpro
PROCEDURE Visualizacao
    LOCAL loc_oP1
    loc_oP1 = THIS.pgf_4c_Paginas.Page1
    DO CASE
        CASE (loc_oP1.obj_4c_OptTipImps.Value = 3)
            THIS.CriaDet48c()
            SELECT crDet48c
            GO TOP IN crDet48c
            LOCAL loc_cReportPath1
            loc_cReportPath1 = gc_4c_CaminhoReports + "SIGREPE1"
            REPORT FORM &loc_cReportPath1. PREVIEW NOCONSOLE   && ERRO: "File does not exist" sem indicar SIGREPE1.frx
        CASE (loc_oP1.obj_4c_OptTipImps.Value = 2)
            LOCAL loc_cReportPath2
            loc_cReportPath2 = gc_4c_CaminhoReports + "SIGREPE2"
            REPORT FORM &loc_cReportPath2. PREVIEW NOCONSOLE
        OTHERWISE
            IF loc_oP1.chk_4c_UltComp.Value = 1
                LOCAL loc_cReportPathS
                loc_cReportPathS = gc_4c_CaminhoReports + "SIGREPES"
                REPORT FORM &loc_cReportPathS. PREVIEW NOCONSOLE
            ELSE
                LOCAL loc_cReportPathX
                loc_cReportPathX = gc_4c_CaminhoReports + "SIGREPEX"
                REPORT FORM &loc_cReportPathX. PREVIEW NOCONSOLE
            ENDIF
    ENDCASE
ENDPROC
```

**Codigo CORRETO** (helper canonico injetado uma vez + chamadas curtas):
```foxpro
*-- =============================================
*-- PROCEDURE ExecutarReportForm
*-- Executa REPORT FORM apenas se o FRX existir; caso contrario,
*-- exibe mensagem de erro descritiva com o path faltante.
*-- par_cModo: "PREVIEW" | "PRINTER_PROMPT" | "PRINTER"
*-- =============================================
PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo)
    LOCAL loc_cFRX
    loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")

    IF NOT FILE(loc_cFRX)
        MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + ;
            loc_cFRX + CHR(13) + CHR(13) + ;
            "O FRX legado ainda n" + CHR(227) + "o foi portado para o novo sistema.", "Erro")
        RETURN .F.
    ENDIF

    DO CASE
        CASE par_cModo == "PREVIEW"
            REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
        CASE par_cModo == "PRINTER_PROMPT"
            REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
        CASE par_cModo == "PRINTER"
            REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
    ENDCASE

    RETURN .T.
ENDPROC

PROCEDURE Visualizacao
    LOCAL loc_oP1
    loc_oP1 = THIS.pgf_4c_Paginas.Page1
    DO CASE
        CASE (loc_oP1.obj_4c_OptTipImps.Value = 3)
            THIS.CriaDet48c()
            SELECT crDet48c
            GO TOP IN crDet48c
            THIS.ExecutarReportForm("SIGREPE1", "PREVIEW")
        CASE (loc_oP1.obj_4c_OptTipImps.Value = 2)
            THIS.ExecutarReportForm("SIGREPE2", "PREVIEW")
        OTHERWISE
            IF loc_oP1.chk_4c_UltComp.Value = 1
                THIS.ExecutarReportForm("SIGREPES", "PREVIEW")
            ELSE
                THIS.ExecutarReportForm("SIGREPEX", "PREVIEW")
            ENDIF
    ENDCASE
ENDPROC
```

**Mapeamento REPORT FORM (macro) → par_cModo**:

| Sufixo original | par_cModo | REPORT FORM final |
|-----------------|-----------|-------------------|
| `PREVIEW NOCONSOLE` | `"PREVIEW"` | `REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE` |
| `TO PRINTER PROMPT NOCONSOLE` | `"PRINTER_PROMPT"` | `REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE` |
| `TO PRINTER NOCONSOLE` | `"PRINTER"` | `REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE` |

**Aplica-se a**:
- **REPORT**: BtnVisualizarClick, BtnImprimirClick, Visualizacao, Impressao, Documento
- **OPERACIONAL**: forms que emitem comanda/etiqueta/documento por impressora — mesmo padrao macro

**Auto-fix**: CorretorAutomatico Pattern #117 (`Corrigir-ReportFormSemGuard`) automatiza a migracao:
1. Detecta linhas `REPORT FORM &<var>.` (macro substitution) na forma canonica
2. Deduz `par_cRelatorioBase` da atribuicao anterior `<var> = gc_4c_CaminhoReports + "<BASE>"`
3. Deduz `par_cModo` do sufixo (PREVIEW/TO PRINTER PROMPT/TO PRINTER)
4. Se helper `ExecutarReportForm` nao existe no arquivo, injeta antes da primeira procedure que emite REPORT FORM
5. Substitui `LOCAL loc_c...` + atribuicao + `REPORT FORM &var.` por `THIS.ExecutarReportForm("<BASE>", "<MODO>")`

**Bug**: Formsigrepes.prg linha 5533 procedure Visualizacao (Erro27, 2026-07-07) — 5 FRXs legados (SIGREPE1/2/3/S/X) nao portados; runtime error mostrava apenas "File does not exist" sem indicar qual arquivo. Fix aplicou helper + 15 substituicoes em Visualizacao (5) + Impressao (4) + Documento (4). Mensagem final passa a mostrar path completo: `C:\4c\projeto\app\reports\SIGREPEX.frx` + "O FRX legado ainda nao foi portado" — dev sabe imediatamente o que criar.

**Regra**: `REPORT FORM (loc_cFRX)` (parenteses ao inves de macro) e OBRIGATORIO no helper — permite passar path pre-computado com FULLPATH() sem depender de macro substitution do escopo. Sem `(...)`, VFP9 exige macro `&var.` que perde o teste de existencia.

**Complementa**: `feedback_gclogorel_file_guard.md` (Erro22) trata `gcLogoRel`/`gcCabRel` dentro do FRX apontando pra logo.bmp inexistente. Este pattern trata FRX inteiro ausente. Ambos usam TRY/CATCH + FULLPATH() como camada defensiva; este acrescenta guard IF FILE() ANTES do REPORT FORM.

## 127. FRX legado Fortyus renderiza asteriscos em campos numericos no VFP9 default — isolar locale + REPORTBEHAVIOR 80 durante REPORT FORM (Formsigrepes 2026-07-07)

**Problema**: FRXs migrados do framework Fortyus (desenhados em VFP6/7/8) renderizam campos numericos como `*******` (asteriscos) no VFP9 mesmo com valores curtos e cursores populados corretamente. O relatorio abre (nao ha erro), o cabecalho renderiza OK (empresa, titulo), mas os campos de quantidade/valor mostram apenas asteriscos. Diagnostico revela que dados estao corretos (`SQtds=2`, `TRANSFORM(SQtds,'999,999.999')=[      2.000]` = 11 chars) — o problema eh como o VFP9 REMEDE o campo em runtime.

**Causa raiz** (2 fatores compostos):

1. **REPORTBEHAVIOR 90** (VFP9 default): re-mede fontes/larguras em runtime usando metricas do VFP9 (`GDIPlus`). FRXs desenhados na IDE do VFP6/7/8 tinham metricas ligeiramente diferentes. Uma diferenca de 1-2px em field width faz o valor formatado nao caber -> asteriscos.

2. **SET POINT TO ","** (BR locale, forcado por config.prg): o config.prg do sistema novo usa `SET POINT TO ","` (formato BR: virgula = decimal). Mas PICTUREs literais dos FRXs Fortyus foram escritas com `9,999.999` (formato US: virgula = milhar, ponto = decimal). Quando VFP9 evalua o TRANSFORM em runtime com POINT=",", os separadores da PICTURE conflitam e o resultado ganha chars extras.

**Codigo ERRADO** (Formsigrepes.prg pre-Erro28 - helper Pattern #117 basico):
```foxpro
PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo)
    LOCAL loc_cFRX
    loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")

    IF NOT FILE(loc_cFRX)
        MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + loc_cFRX, "Erro")
        RETURN .F.
    ENDIF

    DO CASE
        CASE par_cModo == "PREVIEW"
            REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE   && Renderiza asteriscos!
        ...
    ENDCASE

    RETURN .T.
ENDPROC
```

**Codigo CORRETO** (helper Pattern #117 com isolamento canonico):
```foxpro
PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo)
    LOCAL loc_cFRX
    loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")

    IF NOT FILE(loc_cFRX)
        MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + ;
            loc_cFRX + CHR(13) + CHR(13) + ;
            "O FRX legado ainda n" + CHR(227) + "o foi portado para o novo sistema.", "Erro")
        RETURN .F.
    ENDIF

    *-- Isolamento de locale + modo de renderizacao (Erro28)
    LOCAL loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig
    loc_cPointOrig    = SET("POINT")
    loc_cSepOrig      = SET("SEPARATOR")
    loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
    SET POINT TO "."
    SET SEPARATOR TO ","
    SET REPORTBEHAVIOR 80

    DO CASE
        CASE par_cModo == "PREVIEW"
            REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
        CASE par_cModo == "PRINTER_PROMPT"
            REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
        CASE par_cModo == "PRINTER"
            REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
    ENDCASE

    SET POINT TO (loc_cPointOrig)
    SET SEPARATOR TO (loc_cSepOrig)
    SET REPORTBEHAVIOR (loc_nBehaviorOrig)

    RETURN .T.
ENDPROC
```

**Por que os 3 SETs**:

| SET | Antes | Durante REPORT FORM | Motivo |
|-----|-------|---------------------|--------|
| `POINT`          | `,` (BR)  | `.` (US)  | FRX PICTURE `9,999.999` usa `,` como thousand e `.` como decimal (formato US do design legado) |
| `SEPARATOR`      | default (`,`) | `,` (US) | Complementa POINT — thousand separator no formato US |
| `REPORTBEHAVIOR` | `90` (default do config.prg) | `80` (classic) | Modo 80 mede fontes/larguras exatamente como a IDE do designer VFP6/7/8; modo 90 remede em runtime e overflow |

**Debug diagnostico** (instrumentacao removida apos fix):
Adicionar `STRTOFILE("SQtds=" + TRANSFORM(SQtds) + " TotSQtds=" + TRANSFORM(TotSQtds) + " TRANSFORM='" + TRANSFORM(TotSQtds, "@R 9,999.999") + "'", "C:\4c\debug.log")` antes do REPORT FORM revela: valores CURTOS + TRANSFORM produz string curta -> confirma que problema eh do renderizador, nao dos dados.

**Aplica-se a**:
- **REPORT**: todos os forms que executam `REPORT FORM` de FRXs legados do framework Fortyus (SIGREPE*.frx, SIGREPD*.frx, RelPlanoContas.frx, SigReDp*.frx etc)
- **OPERACIONAL**: forms que emitem comanda/etiqueta usando FRX legado
- **Phase B**: sempre que gerador criar handler de report (BtnVisualizarClick/BtnImprimirClick)

**Auto-fix**: CorretorAutomatico Pattern #117 (`Corrigir-ReportFormSemGuard`) — o bloco helper injetado JA inclui os 3 SETs isolados (atualizado apos Erro28). Nenhuma acao adicional necessaria em migracoes novas. Para forms migrados ANTES da atualizacao do Pattern #117 (helper simplificado), rodar `Corrigir-ReportFormLocaleIsolation` (Pattern secundario — TODO se aparecer bug em mais forms).

**Bug**: Formsigrepes.prg (Erro28, 2026-07-07). Sintoma inicial: coluna Estoque mostrando `*******PC` em todas as linhas do relatorio de posicao. Instrumentacao revelou dados corretos (SQtds=2, TRANSFORM formata em 9 chars) e config correto (POINT=".", SEPARATOR=","). Fix: `SET REPORTBEHAVIOR 80` foi decisivo. Referencia canonica: `Formsigrepes.prg:5508-5555` (ExecutarReportForm com isolamento completo).

## 128. REPORT FORM em cursor vazio renderiza preview em branco sem mensagem — helper ExecutarReportForm com par_cCursorDados opcional (FormSIGREVIS 2026-07-07)

**Problema**: Forms REPORT/OPERACIONAL que executam `REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE` sobre cursor vazio (SELECT que retornou 0 registros) abrem preview em branco — VFP9 nao sinaliza erro, apenas renderiza paginas em branco. Usuario clica "Visualizar", ve tela cinza vazia e nao sabe se filtros estao errados ou se realmente nao ha dados. UX quebrada.

**Codigo ERRADO** (FormSIGREVIS.prg pre-fix — helper de 2 params):
```foxpro
PROCEDURE BtnVisualizarClick()
    TRY
        IF !THIS.ValidarPeriodo()
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.PrepararDados()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
            RETURN
        ENDIF
        *-- PrepararDados retorna .T. mesmo com 0 registros no SELECT;
        *-- helper nao checa cursor e abre preview vazio.
        THIS.ExecutarReportForm("SigReVis", "PREVIEW")
    CATCH TO loc_oErro
        ...
    ENDTRY
ENDPROC
```

**Codigo CORRETO** (helper com 3o param opcional + guard cursor vazio):
```foxpro
*-- Helper: 3o parametro OPCIONAL
PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
    LOCAL loc_cFRX
    loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")

    IF NOT FILE(loc_cFRX)
        MsgErro(...)
        RETURN .F.
    ENDIF

    *-- Guard cursor vazio (Erro30)
    IF VARTYPE(par_cCursorDados) == "C" AND !EMPTY(par_cCursorDados)
        IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
            MsgAviso("Nenhum registro encontrado com os filtros informados.", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
    ENDIF

    *-- Isolamento locale + REPORTBEHAVIOR + DO CASE (Erro28)
    ...
ENDPROC

*-- Caller: passa nome do cursor no 3o arg
PROCEDURE BtnVisualizarClick()
    TRY
        IF !THIS.ValidarPeriodo() / RETURN / ENDIF
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.PrepararDados()
            MsgErro(...) / RETURN
        ENDIF
        THIS.ExecutarReportForm("SigReVis", "PREVIEW", THIS.this_oRelatorio.this_cCursorDados)
    CATCH TO loc_oErro
        ...
    ENDTRY
ENDPROC
```

**Por que par_cCursorDados eh OPCIONAL**:
- `VARTYPE(par_cCursorDados) == "C" AND !EMPTY(par_cCursorDados)` garante retrocompatibilidade
- Callers antigos que passam apenas 2 args continuam funcionando (guard so aciona se 3o arg for string nao-vazia)
- Novas migracoes/refactors passam o cursor -> guard ativo

**Convencao do 3o arg**: NOME do cursor populado por `PrepararDados()` — geralmente `THIS.this_oRelatorio.this_cCursorDados` (propriedade que BOs herdam de RelatorioBase indicando qual cursor eles produzem).

**Aplica-se a**:
- **REPORT**: TODO handler BtnVisualizarClick/BtnImprimirClick/BtnExcelClick — passar o cursor de dados no 3o arg
- **OPERACIONAL**: forms que emitem relatorios via helper ExecutarReportForm

**Auto-fix**: Pattern #117 injeta helper JA com os 3 params. Substituicao de chamadas mantem apenas 2 args (Pattern nao sabe qual cursor cada handler usa). Refactor manual dos callsites para passar o 3o arg eh RECOMENDADO mas nao automatico. Nao ha falso positivo em nao passar (chamada de 2 args funciona sem o guard, comportamento igual ao pre-fix).

**Bug**: FormSIGREVIS.prg BtnVisualizarClick (Erro30, 2026-07-07). Usuario reportou "erro nao ocorre mas nao mostra mensagem quando nao tem dados" — preview abria em branco sem qualquer aviso. Fix: adicionado 3o parametro + guard + callers atualizados a passar `THIS.this_oRelatorio.this_cCursorDados`. Referencia canonica: `FormSIGREVIS.prg` (helper e callers pos-Erro30).

## 129. SELECT VFP local com variavel LOCAL sem prefixo `m.` estoura "Column 'LOC_CXXX' is not found" (sigrevtoBO 2026-07-07)

**Problema**: SELECT VFP local (`SELECT ... FROM crCursor ... INTO CURSOR novoCursor`) que referencia uma variavel LOCAL (declarada com `LOCAL loc_cXxx`) sem prefixo `m.` estoura runtime `SQL: Column 'LOC_CXXX' is not found`. VFP tem ambiguidade de name resolution: identificador solto no SELECT / GROUP BY / IIF / WHERE / SUM pode ser (a) coluna de tabela do FROM ou (b) memory variable local. Sem qualificador, VFP tenta COLUNA primeiro e falha antes mesmo de olhar variaveis.

**Codigo ERRADO** (sigrevtoBO.prg pre-fix Branch A):
```foxpro
LOCAL loc_cMoeda, loc_cMoeOpe
loc_cMoeda   = ALLTRIM(THIS.this_cMoeda)
loc_cMoeOpe  = ""
...
SQLEXEC(gnConnHandle, "SELECT ... FROM SigMvPar ...", "crSigMvPar")
...
SELECT crSigMvPar.Emps, crSigMvPar.Dopes, ;
       loc_cMoeda AS cMoeda, ;                    && ERRO: "Column 'LOC_CMOEDA' is not found"
       0 AS mValVars, 0 AS mValDevs, ;
       SUM(IIF(loc_cMoeda = MoeFpgs, Valos, ;
           Valos * fBuscarCotacao(MoeFpgs, Datas, gnConnHandle) / ;
                  fBuscarCotacao(loc_cMoeda, Datas, gnConnHandle))) AS mValos ;
  FROM crSigMvPar ;
  GROUP BY crSigMvPar.Emps, crSigMvPar.Dopes, loc_cMoeda, 4, 5 ;
  ORDER BY crSigMvPar.Emps, crSigMvPar.Dopes ;
  INTO CURSOR cursor_4c_Relatorio READWRITE
```

**Codigo CORRETO** (prefixar TODA ref de var local com `m.`):
```foxpro
SELECT crSigMvPar.Emps, crSigMvPar.Dopes, ;
       m.loc_cMoeda AS cMoeda, ;
       0 AS mValVars, 0 AS mValDevs, ;
       SUM(IIF(m.loc_cMoeda = MoeFpgs, Valos, ;
           Valos * fBuscarCotacao(MoeFpgs, Datas, gnConnHandle) / ;
                  fBuscarCotacao(m.loc_cMoeda, Datas, gnConnHandle))) AS mValos ;
  FROM crSigMvPar ;
  GROUP BY crSigMvPar.Emps, crSigMvPar.Dopes, m.loc_cMoeda, 4, 5 ;
  ORDER BY crSigMvPar.Emps, crSigMvPar.Dopes ;
  INTO CURSOR cursor_4c_Relatorio READWRITE
```

**Regra distintiva SELECT local vs SQLEXEC**:

| Contexto | Como usar var local |
|----------|---------------------|
| `SELECT ... INTO CURSOR X READWRITE` (VFP local) | `m.loc_cXxx` — prefixo direto na expressao |
| `SQLEXEC(gnConnHandle, "SELECT ... WHERE col=" + EscaparSQL(loc_cXxx), "cursor")` (SQL Server) | `EscaparSQL(loc_cXxx)` — string concat, VFP nunca vai ao servidor |
| `SELECT ... FROM tabela_remota ... INTO CURSOR` (SPT view) | `m.` funciona se cursor eh VFP local; se query remota, embutir literal via concat |

**Onde prefixar `m.`** dentro de bloco SELECT VFP local:
- SELECT column list: `m.loc_c AS x`
- IIF/SUM/CASE expressoes: `SUM(IIF(m.loc_c = tabela.campo, ...))`
- Function args: `fFn(m.loc_c, ...)`, `TRANSFORM(m.loc_c, "...")`
- GROUP BY / ORDER BY: `GROUP BY m.loc_c, tabela.campo`
- WHERE clause: `WHERE tabela.col = m.loc_c`

**Onde NAO prefixar**:
- LOCAL declaration: `LOCAL loc_cXxx` (statement level — nao ha ambiguidade)
- Atribuicao: `loc_cXxx = ALLTRIM(...)` (assignment — VFP resolve como memvar sem `m.`)
- Fora de blocos SELECT VFP local: `IF !EMPTY(loc_cXxx)` (procedural code — resolve normal)
- Como argumento de `EscaparSQL(loc_cXxx)` (funcao de wrapper para SQLEXEC — VFP passa por valor)

**Aplica-se a**:
- **REPORT**: BOs de relatorio que constroem cursores derivados via SELECT-INTO-CURSOR (comum em Branch A/B com SigMvPar/SigMvCab, cotacao de moeda, sumarizacoes)
- **OPERACIONAL**: BOs de processamento com queries agregadas locais
- **Phase B**: sempre que gerador criar `SELECT ... FROM cr ... INTO CURSOR ... READWRITE`

**Auto-fix**: CorretorAutomatico Pattern #118 (`Corrigir-SelectLocalVarSemMPrefix`) — detecta blocos `SELECT ... INTO CURSOR` (multi-linha via `;`) + varredura de identifiers matching `loc_c\w+` + prefixa com `m.` onde nao ja qualificado por table alias (`crXxx.`) ou ja com `m.`. Idempotente.

**Bug**: sigrevtoBO.prg PrepararDados linhas 239-283 (Erro30-b, 2026-07-07). Branch A (SigMvPar): 4 refs a `loc_cMoeda`. Branch B (SigMvCab): 8 refs a `loc_cMoeda` + `loc_cMoeOpe`. Runtime dialog `PrepararDados: SQL: Column 'LOC_CMOEDA' is not found` bloqueava Visualizar/Imprimir/Documento do "Relatorio Total Por Operacao". Fix aplicou `m.` a todas 12 refs.

## 130. SELECT VFP local — alias em SELECT list DEVE bater com nome do memvar quando ele aparece em GROUP BY (refinement do #129 — Erro31 2026-07-08)

**Problema**: Aplicar apenas o `m.` prefix (regra #129) NAO basta quando o alias da coluna em SELECT list difere do nome do memvar E o mesmo memvar aparece em GROUP BY / SUM(IIF(...)). Erro31 (2026-07-08) reincidiu Erro30-b no MESMO BO/PROC (`sigrevtoBO.prg PrepararDados`) mesmo com todas 12 refs prefixadas: `PrepararDados: SQL: Column 'LOC_CMOEDA' is not found`. A causa raiz identificada por comparacao com o legado (`sigrevto_form_codigo_fonte.txt:492-517`, que funciona) e que o VFP9's SELECT engine falha em resolver `m.<var>` em GROUP BY quando a mesma variavel aparece em SELECT list com alias DIFERENTE.

**Padrao legado que funciona** (comprovado em producao ha anos):
```foxpro
Local lcMoeda
lcMoeda = ThisForm.get_moeda.Value

Select Emps, Dopes, lcMoeda AS lcMoeda, ;                        && alias == memvar name
       lnValVars AS mValVars, lnValDevs AS mValDevs, ;
       Sum(Iif(lcMoeda = Moefpgs, Valos, ...)) AS mValos ;         && unprefixed OK — nao ha coluna lcMoeda
  From crSigMvPar ;
  GROUP BY Emps, Dopes, lcMoeda, 4, 5;                             && GROUP BY resolve VIA ALIAS
  ORDER BY Emps, Dopes, lcMoeda, 4, 5;
  Into Cursor csRelatorio
```

**Codigo ERRADO** (mesmo com `m.` prefix — Erro31):
```foxpro
SELECT crSigMvPar.Emps, crSigMvPar.Dopes, ;
       m.loc_cMoeda AS cMoeda, ;                                   && alias `cMoeda` != memvar `loc_cMoeda`
       0 AS mValVars, 0 AS mValDevs, ;
       SUM(IIF(m.loc_cMoeda = MoeFpgs, ...)) AS mValos ;
  FROM crSigMvPar ;
  GROUP BY crSigMvPar.Emps, crSigMvPar.Dopes, m.loc_cMoeda, 4, 5 ; && ERRO reincide
  INTO CURSOR cursor_4c_Relatorio READWRITE
```

**Codigo CORRETO** (mimica legacy — alias = memvar name):
```foxpro
SELECT crSigMvPar.Emps, crSigMvPar.Dopes, ;
       loc_cMoeda AS loc_cMoeda, ;                                 && alias == memvar name (drop m.)
       0 AS mValVars, 0 AS mValDevs, ;
       SUM(IIF(loc_cMoeda = MoeFpgs, ...)) AS mValos ;             && inner refs unprefixed OK
  FROM crSigMvPar ;
  GROUP BY crSigMvPar.Emps, crSigMvPar.Dopes, loc_cMoeda, 4, 5 ;   && GROUP BY resolve via alias
  INTO CURSOR cursor_4c_Relatorio READWRITE
```

**Regra refinada** (unifica #129 + #130):
- **SELECT list**: `loc_cXxx AS loc_cXxx` (alias == memvar name, sem `m.` — permite GROUP BY resolver via alias). NUNCA `m.loc_cXxx AS <different>`.
- **Inner refs (IIF, SUM, function args)**: `m.loc_cXxx` seguro (nao ha colisao com colunas do FROM porque naming convention `loc_c*` eh unica), OU unprefixed (VFP resolve como memvar por falta de coluna).
- **GROUP BY / ORDER BY**: `loc_cXxx` unprefixed (resolve via alias) OU `m.loc_cXxx` (memvar).
- **WHERE**: `m.loc_cXxx` seguro.

**Auto-fix**: CorretorAutomatico Pattern #118 (`Corrigir-SelectLocalVarSemMPrefix`) recebeu **Fase 3** (2026-07-08): detecta em SELECT list `m.<memvar> AS <alias>` onde `<alias>` != `<memvar>` e normaliza para `<memvar> AS <memvar>` (drop `m.` prefix + alias rename). IIF/SUM/GROUP BY inner refs mantem `m.` prefix (idempotente). Sweep retroativo em todos os BOs de REPORT com SELECT-INTO-CURSOR.

**Bug**: sigrevtoBO.prg PrepararDados linhas 239-248 (Branch A) e 271-285 (Branch B). Erro31 (2026-07-08) reincidiu Erro30-b porque Pattern #118 v1 apenas prefixou `m.` mas manteve alias `cMoeda`. Fix Fase 3 aplicou `loc_cMoeda AS loc_cMoeda` + drop `m.` inner refs para mimicar legacy. Cliente destravou "Relatorio Total Por Operacao".

**Como NAO acontecer novamente**: Ao gerar SELECT-INTO-CURSOR VFP local em BOs de REPORT/OPERACIONAL, SEMPRE usar alias = nome da variavel local. Templates dos prompts devem preferir o padrao legado (alias=memvar) sobre invencao de aliases decorativos (`cMoeda`, `nValor`, etc).

## 131. REPORT: cursor de saida e aliases em SELECT list DEVEM bater com nomes esperados pelo FRX legado (Erro32/33 sigrevtoBO 2026-07-08)

**Problema**: Apos resolver o SELECT-INTO-CURSOR alias mismatch (regra #130), sigrevtoBO ainda estourou 2 erros em runtime:

- **Erro32** (2026-07-08): `Arquivo de relatorio nao encontrado: C:\4C\PROJETO\APP\REPORTS\SIGREVTO.FRX. O FRX legado ainda nao foi portado.` — helper `ExecutarReportForm` do Pattern #117 tem guard IF FILE() que dispara MostrarErro descritivo. Fix: copiar `sigrevto.frx` + `sigrevto.frt` do legado (`C:\4install\FortyusMC\Fortyus\`) para `C:\4c\projeto\app\reports\SigReVto.frx`/`SigReVto.frt`.

- **Erro33** (2026-07-08): `Variable 'LCMOEDA' is not found. Linha: 718. Procedure: executarreportform` — apos FRX carregar, REPORT FORM tentou avaliar expressao `lcMoeda` do FRX legado mas nao achou nem coluna nem memvar. Causa raiz: **o FRX legado referencia colunas/cursores pelos nomes que o codigo LEGADO criava** (`csRelatorio`, `lcMoeda`); a migracao renomeou para `cursor_4c_Relatorio` e `loc_cMoeda AS loc_cMoeda`, quebrando o binding do FRX.

**Codigo ERRADO** (migrated com naming convention nova, quebra FRX):
```foxpro
this_cCursorDados = "cursor_4c_Relatorio"    && FRX espera "csRelatorio"

SELECT crSigMvPar.Emps, crSigMvPar.Dopes, ;
       loc_cMoeda AS loc_cMoeda, ;              && FRX espera coluna "lcMoeda"
       ...
  INTO CURSOR cursor_4c_Relatorio READWRITE     && FRX espera cursor "csRelatorio"
```

**Codigo CORRETO** (mimica cursor+aliases legados esperados pelo FRX):
```foxpro
this_cCursorDados = "csRelatorio"                && bate com FRX

SELECT crSigMvPar.Emps, crSigMvPar.Dopes, ;
       loc_cMoeda AS lcMoeda, ;                  && alias == nome que o FRX espera
       ...
  FROM crSigMvPar ;
  GROUP BY crSigMvPar.Emps, crSigMvPar.Dopes, lcMoeda, 4, 5 ;  && GROUP BY via ALIAS (evita Erro31)
  INTO CURSOR csRelatorio READWRITE              && bate com FRX
```

**Regra unificada REPORT** (cobre #129 + #130 + #131):
1. **Cursor de saida**: nome DEVE bater com o que o FRX legado espera. Ver legado: `Into Cursor <nome_final>` da PROCEDURE `processamento` antes de `Report Form` na PROCEDURE `visualizacao`.
2. **Alias em SELECT list**: nomes DEVEM bater com colunas que o FRX referencia (frequentemente = nome do memvar legado, ex: `lcMoeda`, `lcTitulo`). NAO usar `loc_cXxx AS loc_cXxx` (novo nome) — usar `loc_cXxx AS lcXxx` (nome legado).
3. **GROUP BY**: usar o ALIAS (nome legado) — VFP resolve via SELECT list, sem ambiguidade.
4. **Inner refs (IIF/SUM/function args)**: usar memvar novo (`loc_cXxx`) sem `m.` prefix — sem colisao com colunas do FROM porque naming convention.
5. **FRX/FRT**: copiar de `C:\4install\FortyusMC\Fortyus\<nome>.frx` (+ `.frt`) para `C:\4c\projeto\app\reports\<Nome>.frx` antes de testar.

**Como identificar os nomes esperados pelo FRX**:
- Cursor: procurar no legado `_form_codigo_fonte.txt` por `Into Cursor <X>` na PROCEDURE `processamento` (ultima ocorrencia OU a que precede o SELECT antes do REPORT FORM).
- Colunas/aliases: procurar no legado `Select ... AS <coluna>` — a lista das colunas ali sao as que o FRX consome. Corroborar com strings dentro do FRT (`grep -a` em `<nome>.frt`).
- Memvars usados como colunas: `<Select ... lcXxx AS lcXxx>` no legado significa que o FRX referencia `lcXxx` como coluna.

**Auto-fix**: NAO automavel de forma segura via CorretorAutomatico — a identificacao do cursor final legado e das colunas do FRX exige contexto que varia por report. Marcar como REGRA DE GERACAO (prompts) e como CHECKLIST de teste manual (checar cursor+aliases antes de rodar).

**Bug e escopo**: 100 BOs de REPORT no projeto; ~66 FRXs legados ja copiados em 2026-07-08 apos Erro32; ~39 BOs ainda usam `cursor_4c_*` (padrao novo, incompativel com FRX legado). Corrigir per-form conforme usuario testa cada relatorio.

## 132. RegistrarAuditoria — NUNCA usar `FormatarDataSQL(DATETIME())` para DataHora — usar `GETDATE()` (Erro35 2026-07-08)

**Problema**: BOs REPORT com auditoria custom sobrescrevem `BusinessBase.RegistrarAuditoria()` para gravar em `LogAuditoria` com detalhes especificos do relatorio (operacao, chave, dados). O gerador as vezes usa `FormatarDataSQL(DATETIME())` para o campo `DataHora`. Isso quebra em runtime: `[Microsoft][ODBC SQL Server Driver][SQL Server]Nao e possivel inserir o valor NULL na coluna 'DataHora', tabela 'DB_MBAHIA.dbo.LogAuditoria'; a coluna nao permite nulos. Falha em INSERT.`

**Causa raiz**: `FormatarDataSQL(pdData)` em `utils/functions.prg` historicamente checava `VARTYPE(pdData) != "D"` e retornava `"NULL"` quando o argumento nao era tipo Date. `DATETIME()` retorna tipo T (DateTime), nao D — filtro rejeitava, funcao retornava "NULL" literal, INSERT batia na NOT NULL constraint de `LogAuditoria.DataHora`.

**Codigo ERRADO**:
```foxpro
PROCEDURE RegistrarAuditoria(par_cOperacao)
    loc_cSQL = "INSERT INTO LogAuditoria (DataHora, Usuario, Operacao, ...) " + ;
               "VALUES (" + ;
               FormatarDataSQL(DATETIME()) + ", " + ;    && ERRO: retorna "NULL"
               EscaparSQL(loc_cUsuario) + ", " + ;
               ...
```

**Codigo CORRETO** (padrao canonico `BusinessBase.RegistrarAuditoria` em `classes/businessbase.prg:267`):
```foxpro
PROCEDURE RegistrarAuditoria(par_cOperacao)
    loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
               "VALUES (" + EscaparSQL(THIS.this_cTabela) + ", " + ;
               EscaparSQL(par_cOperacao) + ", " + ;
               EscaparSQL(loc_cChave) + ", " + ;
               EscaparSQL(loc_cUsuario) + ", GETDATE())"   && GETDATE() = SQL Server nativa, server-side
```

**Regra**: em SQL Server, timestamp atual DEVE ser produzido via `GETDATE()` (avaliada server-side). NUNCA calcular no VFP e passar formatado — introduz clock skew VFP↔SQL Server + risco de bug de formatacao.

**Melhoria sistemica** (2026-07-08): `FormatarDataSQL()` foi extendida para aceitar **ambos** tipos D e T. Para T retorna `'YYYY-MM-DD HH:MM:SS'`. Isso previne recorrencia se algum caller acidentalmente passar DATETIME() ou variavel `t*`. Mas mesmo assim, para `RegistrarAuditoria` a preferencia canonica eh `GETDATE()`.

**Auto-fix**: CorretorAutomatico Pattern #119 (`Corrigir-FormatarDataSQLDatetime`) detecta chamadas `FormatarDataSQL(DATETIME())` em qualquer arquivo e substitui por literal `GETDATE()`. Regex flexivel para whitespace: `FormatarDataSQL\s*\(\s*DATETIME\s*\(\s*\)\s*\)`. Idempotente.

**Bug**: SigReAacBO/SIGREDESBO/SigReDdpBO/sigredocBO tinham `FormatarDataSQL(DATETIME())` em `RegistrarAuditoria` (Erro35, 2026-07-08, "Relatorio Log de Acessos"). Fix substituiu por `GETDATE()`. Melhoria sistemica em `FormatarDataSQL` aceita T agora.

## 133. `&m.<var>.` eh macro quebrada em VFP9 — usar `&<var>.` sem prefixo `m.` (SIGREADSBO 2026-07-14, Erro37)

**Problema**: Reports migrados com Pattern #118 (prefixar `m.` em refs de var LOCAL dentro de SELECT VFP local) tiveram a regra aplicada indiscriminadamente, inclusive dentro de macros `&…`. Resultado: `WHERE &m.loc_cWhere1.` — VFP9 estoura `Error 10: Syntax error.` no primeiro `PrepararDados()`, sem indicar linha nem contexto. O erro aparece como modal simples "Syntax error." que aborta o relatorio antes do REPORT FORM.

**Causa raiz**: Em VFP9 o macro operator `&` le o nome do macro ATE o primeiro `.` (o `.` termina o nome). Assim:
- `&loc_cWhere.` → expande `loc_cWhere` (correto)
- `&m.loc_cWhere.` → tenta expandir a variavel chamada `m` (que nao existe), sobra `loc_cWhere.` como lixo depois → parser erra

O prefixo `m.` de escopo memvar existe APENAS em contextos de expressao normal (SELECT list, WHERE column ops, function args, GROUP BY, ORDER BY). Nao existe DENTRO de macro `&…` — la o parser trata caractere por caractere ate o `.` terminador.

**Codigo ERRADO** (gerado por Pattern #118 v1 indiscriminado):
```foxpro
loc_cWhere1 = IIF(loc_nTipoVars=1, "ValInis > Valos", "0=0")

SELECT Emps, Dopes, ... FROM TmpCsRelat ;
    WHERE &m.loc_cWhere1. ;             && ERRO 10: "Syntax error."
    UNION ALL ;
SELECT Emps, Dopes, ... FROM TmpCsRela2 ;
    WHERE &m.loc_cWhere2. ;             && idem
    INTO CURSOR csRelatorio1
```

**Codigo CORRETO** (mimetiza o legado — sempre `&<var>.` sem `m.`):
```foxpro
SELECT Emps, Dopes, ... FROM TmpCsRelat ;
    WHERE &loc_cWhere1. ;
    UNION ALL ;
SELECT Emps, Dopes, ... FROM TmpCsRela2 ;
    WHERE &loc_cWhere2. ;
    INTO CURSOR csRelatorio1
```

**Regra distintiva**: se a var LOCAL aparece **dentro de `&<var>.`**, NAO usar `m.`. Se aparece em qualquer outro contexto dentro do SELECT (SELECT list, WHERE column ops, function args, GROUP BY, ORDER BY, IIF/SUM inner refs), Pattern #118 continua valendo (prefixar `m.`).

**Auto-fix**: CorretorAutomatico Pattern #120 (`Corrigir-MacroMPrefixQuebrado`). Regex `&m\.` -> `&` — safe global replace, ja que `&m.` NUNCA eh construcao valida em VFP9 (o unico "m." legitimo eh prefixo de escopo memvar em ref normal, e nunca aparece com `&` na frente). Idempotente.

**Complementa Pattern #118**: a Fase 2 do Corrigir-SelectLocalVarSemMPrefix (prefixa `m.` em refs de var local dentro de SELECT-INTO-CURSOR) precisa excluir tokens dentro de macros `&…`. Pattern #120 remedia depois; recomendacao futura eh Fase 2 de #118 pular ocorrencias dentro de `&\w+\.`.

**Bug**: SIGREADSBO.PrepararDados linha 492 (WHERE &m.loc_cWhere1. UNION WHERE &m.loc_cWhere2.) — reproduzido em diagnostico end-to-end (Erro37, 2026-07-14, FormSIGREADS "Relatorio de Apuracao de Descontos/Acrescimos"). Varredura global apos fix: 13 ocorrencias em 8 arquivos migrados: SIGREADSBO (2), sigopcgpBO (1), sigrecheBO (6), sigrecpeBO (1), sigrecrtBO (2), sigrecsmBO (1), SigReIr1BO (1), Formsigrepes (1). Todos corrigidos por replace_all `&m.` → `&`. Fix validado por compilacao dos 8 arquivos + PrepararDados end-to-end no SIGREADSBO.

## 134. INSERT em SQL Server: helpers por TIPO destino + LEFT() por TAMANHO destino (SIGREADSBO SigTempR 2026-07-14, Erro39)

**Problema**: BOs REPORT que geram cursores analiticos frequentemente inserem os dados em tabela temporaria SQL Server (`SigTempR` mais comum) para JOIN posterior com movimentacao detalhada (`SigMvItn`). O INSERT falha silenciosamente quando (a) valor origem excede tamanho da coluna destino, OU (b) helper usado nao bate com o tipo da coluna destino. SQLEXEC retorna <0 sem MsgErro claro; o CATCH ate captura, mas a mensagem eh generica ("String or binary data would be truncated" / "Cannot convert varchar to numeric").

**Causa raiz**:
- **Tamanho**: `SigCdCli.Rclis` eh `char(50)` mas `SigTempR.Razas` eh `char(40)`. Passar `EscaparSQL(csRelatorio.RClis)` insere valor de ate 50 chars em coluna char(40) — SQL Server 8152 "String or binary data would be truncated" aborta o INSERT.
- **Tipo**: `SigTempR.CodObs` eh `numeric(3,0)`. `EscaparSQL(csRelatorio.CodObs)` (numeric) retorna `''` (string vazia — a funcao filtra `VARTYPE != "C"`). SQL Server rejeita conversao `'' -> numeric(3,0)` com erro de conversao.

**Codigo ERRADO**:
```foxpro
loc_cSQL = "INSERT INTO SigTempR (Emps, Razas, CodObs, ...) VALUES (" + ;
           EscaparSQL(csRelatorio.Emps) + ", " + ;
           EscaparSQL(csRelatorio.RClis) + ", " + ;             && RClis char(50) > Razas char(40) — trunca
           EscaparSQL(csRelatorio.CodObs) + ", " + ;            && CodObs numeric, EscaparSQL retorna ''
           ...
```

**Codigo CORRETO**:
```foxpro
loc_cSQL = "INSERT INTO SigTempR (Emps, Razas, CodObs, ...) VALUES (" + ;
           EscaparSQL(csRelatorio.Emps) + ", " + ;
           EscaparSQL(LEFT(csRelatorio.RClis, 40)) + ", " + ;    && LEFT trunca antes de EscaparSQL
           FormatarNumeroSQL(csRelatorio.CodObs, 0) + ", " + ;   && FormatarNumeroSQL para coluna numeric
           ...
```

**Regra**:
1. Antes de escrever INSERT, consultar `docs/schema.sql` para cada coluna DESTINO: tipo + tamanho + NULL/NOT NULL.
2. Escolher helper por TIPO destino (nao tipo origem):
   - CHAR/VARCHAR/TEXT → `EscaparSQL(...)` — retorna WITH aspas + escape de `'`
   - NUMERIC/INT → `FormatarNumeroSQL(campo, decimais)` — retorna sem aspas, ponto decimal
   - DATE → `FormatarDataSQL(campo)` — retorna WITH aspas, formato ISO 'YYYY-MM-DD'
   - DATETIME → `FormatarDataSQL(campo)` (aceita T) ou literal `GETDATE()` para "agora" (preferencial)
   - BIT → `IIF(campo, 1, 0)` — retorna 0/1 sem aspas
3. Se origem CHAR(M) > destino CHAR(N), aplicar `LEFT(campo, N)` ANTES do helper.
4. Se origem NUMERIC pode exceder precisao/escala destino (raro), ROUND ou validar antes.

**Tabelas criticas**: `SigTempR` (compartilhada por muitos relatorios analiticos), `LogAuditoria` (auditoria), `SigMv*` (movimentacao). Cada relatorio analitico que insere em SigTempR deve verificar as ~34 colunas contra o cursor de origem.

**Auto-fix**: NAO automavel univoco. Requer:
1. Parsear `docs/schema.sql` extraindo tabela → coluna → tipo + tamanho.
2. Correlacionar cada `INSERT INTO Tabela (col1, col2, ...) VALUES (...)` com sua tabela+coluna destino.
3. Ler o `csRelatorio.CampoOrigem` e correlacionar com cursor origem (via SELECT anterior no BO ou via cursor legado documentado).
4. Comparar tipos/tamanhos e sugerir/aplicar helper adequado.

Pattern parcial (detectar SIM, corrigir NAO) possivel — mas o fix universal exige info que so o schema.sql tem em conjunto com o SELECT origem. Manual por relatorio.

**Bug**: SIGREADSBO.PrepararDados INSERT INTO SigTempR (Erro39, 2026-07-14, FormSIGREADS "Descontos/Acrescimos" modo Analitico). Fix per-callsite: linha 552 `EscaparSQL(LEFT(csRelatorio.RClis, 40))`; linha 555 `FormatarNumeroSQL(csRelatorio.CodObs, 0)`. Outras colunas foram validadas contra schema: Emps char(3)=char(3), Dopes char(20)=char(20), MascNum char(10)=char(10), Vends char(10) em CPros char(14) OK, Obses TEXT em Obss TEXT OK, EmpDopNums 29 chars exatos, CIdQuerys+CIdChaves via SYS(2015) 10 chars, Usuars char(10)=char(10) Contas.

## 135. Grid Column CheckBox EXIGE `.Sparse = .F.` — sem isso, selecao individual quebra (FormSIGREADS 2026-07-14, Erro41)

**Problema**: Forms com Grid onde `Column1.CurrentControl = "Check1"` (checkbox de selecao por linha) tem comportamento estranho: apenas 1 linha do grid mostra o CheckBox como controle clickavel; as demais linhas mostram o valor bruto do campo (0/1) renderizado como TEXTO PLANO. Usuario NAO consegue clicar nas checkboxes das demais linhas — apenas na linha corrente.

**Sintomas visuais**:
- 1 unica linha com CheckBox visivel (a linha selecionada)
- Demais linhas mostrando "0" ou "1" em texto (parece "grid quebrado")
- Se `.HeaderHeight = 0`, os "0"/"1" ficam bem visiveis como valores brutos

**Sintomas comportamentais**:
- Botoes "Selecionar Todos" (`REPLACE ALL Marca WITH 1`) e "Desmarcar Todos" (`REPLACE ALL Marca WITH 0`) FUNCIONAM (agem no cursor diretamente)
- Selecao INDIVIDUAL por click no CheckBox NAO funciona nas linhas nao-correntes
- Formularios que dependem de selecao multipla via checkboxes ficam praticamente inutilizaveis

**Causa raiz**: Default VFP9 eh `Column.Sparse = .T.`, que instrui o Grid a renderizar o `CurrentControl` (CheckBox/ComboBox/Spinner/etc) **APENAS** na linha atualmente selecionada — as demais linhas mostram o dado como texto plano. Isso serve para performance em grids muito grandes (evita instanciar N controles), mas quebra completamente a UX de CheckBox column.

**Codigo ERRADO** (default Sparse=.T. — CheckBox so aparece em 1 linha):
```foxpro
WITH loc_oGrid.Column1
    .Width = 15
    .AddObject("Check1", "CheckBox")
    .Check1.Caption = ""
    .Check1.Value   = 0
    .CurrentControl = "Check1"
    .ControlSource  = loc_cCursor + ".Marca"
ENDWITH
```

**Codigo CORRETO** (Sparse=.F. — CheckBox aparece em TODAS as linhas):
```foxpro
WITH loc_oGrid.Column1
    .Width     = 15
    .Alignment = 0
    .Enabled   = .T.
    .Sparse    = .F.                    && OBRIGATORIO
    .AddObject("Check1", "CheckBox")
    .Check1.Caption = ""
    .CurrentControl = "Check1"
    .ControlSource  = loc_cCursor + ".Marca"
ENDWITH
```

**Nota**: nao setar `.Check1.Value = 0` explicito — o binding via `Column1.ControlSource` cuida disso e o valor manual compete com o binding em algumas situacoes.

**Auto-fix**: CorretorAutomatico Pattern #121 (`Corrigir-GridColumnCheckboxSparse`). Detecta bloco `WITH ...Column1` (ou `WITH par_oGrd.Column1`, `WITH loc_oGridXxx.Column1`, etc) que contem `CurrentControl = "Check1"` mas NAO contem `.Sparse = .F.` — injeta a linha `.Sparse = .F.` antes de `.AddObject("Check1", ...)`. Idempotente (nao afeta blocos que ja tem `Sparse`).

**Padrao canonico**: `Formsigrepes.prg:3095-3104` (grid checkbox column proven em producao).

**Bug**: FormSIGREADS.prg linhas 441-451 (`grd_4c_TipoOps` — Tipo de Operacao) + linhas 545-555 (`grd_4c_Grupos` — Grupo de Produto) — 2026-07-14, Erro41. Usuario nao conseguia marcar tipos de operacao nem grupos de produto individualmente, apenas via botoes SelTudo/Apaga. Fix aplicado: adicionado `.Sparse = .F.` + `.Alignment = 0` + `.Enabled = .T.` + removido `.Check1.Value = 0` que competia com ControlSource. Padrao canonico verificado contra `Formsigrepes.prg`.

## 136. REPORT BtnVisualizarClick/BtnImprimirClick DEVEM guard `!EMPTY(cMensagemErro)` antes de MsgErro (FormSIGREADS 2026-07-14, Erro40)

**Problema**: Apos migrar `ImprimirRelatorio` para o helper canonico `ExecutarReportForm` (Pattern #117), os handlers `BtnVisualizarClick`/`BtnImprimirClick` do form REPORT comecam a exibir um modal com titulo "Relatorio" e corpo VAZIO (apenas icone X vermelho) quando o cursor de dados esta vazio. O helper ja mostrou seu proprio MsgAviso "Nenhum registro encontrado...", entao o usuario ve DOIS modais em sequencia — o segundo em branco.

**Causa raiz**: O helper `ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)` gerencia dois casos que retornam `.F.` SEM setar `this_cMensagemErro`:
1. FRX ausente → chama `MostrarErro("Arquivo de relatorio nao encontrado...")` proprio + retorna `.F.`
2. Cursor vazio → chama `MsgAviso("Nenhum registro encontrado com os filtros informados.")` proprio + retorna `.F.`

Em ambos, o helper JA notificou o usuario. Mas os handlers legados fazem:
```foxpro
IF !THIS.this_oRelatorio.Atualizar()
    MsgErro(THIS.this_oRelatorio.this_cMensagemErro, "Relat" + CHR(243) + "rio")
ENDIF
```

Sem checar se `cMensagemErro` esta vazio → `MsgErro("", "Relatorio")` mostra modal vazio.

**Codigo ERRADO** (modal duplicado — o segundo em branco):
```foxpro
PROCEDURE BtnVisualizarClick()
    TRY
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Atualizar()
            MsgErro(THIS.this_oRelatorio.this_cMensagemErro, "Relat" + CHR(243) + "rio")
        ENDIF
    CATCH TO loc_oErro
        MsgErro(loc_oErro.Message, "Erro")
    ENDTRY
ENDPROC
```

**Codigo CORRETO** (guard cMensagemErro):
```foxpro
PROCEDURE BtnVisualizarClick()
    TRY
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Atualizar() ;
           AND !EMPTY(THIS.this_oRelatorio.this_cMensagemErro)
            MsgErro(THIS.this_oRelatorio.this_cMensagemErro, "Relat" + CHR(243) + "rio")
        ENDIF
    CATCH TO loc_oErro
        MsgErro(loc_oErro.Message, "Erro")
    ENDTRY
ENDPROC
```

**Regra**: sempre que uma chamada retorna `.F.` mas pode ter mostrado sua propria mensagem (helper com MsgAviso proprio), o caller deve verificar `!EMPTY(cMensagemErro)` antes de exibir seu proprio MsgErro. Alternativa arquitetural: convencionar que TODA rota que retorna `.F.` DEVE preencher `cMensagemErro` (mais explicit) — o helper Pattern #117 poderia setar `THIS.this_cMensagemErro = ""` no retorno .F. para deixar claro que "ja mostrei mensagem".

**Auto-fix**: CorretorAutomatico Pattern #122 (`Corrigir-BtnReportGuardEmptyMsgErro`). Detecta o padrao:
```
IF !THIS.this_oRelatorio.<method>()
    MsgErro(THIS.this_oRelatorio.this_cMensagemErro, ...)
ENDIF
```
Onde `<method>` esta em `("Atualizar"|"Inserir"|"ImprimirRelatorio"|"PrepararDados")`. Injeta guard `AND !EMPTY(...)` na condicao do IF. Idempotente. Preserva indentacao e handles com `TRY/CATCH` circundante.

**Padrao canonico**: FormSIGREADS.BtnVisualizarClick/BtnImprimirClick pos-fix (2026-07-14).

**Bug**: FormSIGREADS.prg BtnVisualizarClick (linhas 1729-1743) e BtnImprimirClick (linhas 1748-1761) — 2026-07-14, Erro40. Cursor de dados vazio (filtros nao retornaram nada) disparava MsgAviso "Nenhum registro encontrado" do helper + MsgErro vazio do handler em sequencia. Fix per-callsite aplicado.


## 137. SigCdEmp — colunas canonicas sao `Cemps`/`Razas`, NUNCA `Emps`/`emps`/`NComps`/`nemp` (FormSigReAiv + FormSIGREHCP 2026-07-16, Erro44)

**Problema**: Ao digitar o codigo da empresa no campo `txt_4c_Empresa` (ou equivalente) de um form REPORT/OPERACIONAL, o VFP9 exibe modal `Microsoft Visual FoxPro / Connectivity error: [Microsoft][ODBC SQL Server Driver][SQL Server]Nome de coluna 'Emps' invalido.`. O TextBox nunca resolve para valor valido; lookup FormBuscaAuxiliar tambem falha silenciosamente.

**Causa raiz**: A tabela `SigCdEmp` (SIGCDEMP) tem **PK** `Cemps` (char(3), codigo empresa) e **descricao** `Razas` (char(40), razao social). As colunas `Emps`/`emps` e `NComps`/`nemp` **NAO EXISTEM** na tabela. Bug introduzido pela migracao porque:

1. **Framework legado usa `fAcessoEmpresa(Usuar, cModo, cValor, oGetX, oGetDX)`** — funcao que abstrai o nome da coluna internamente (query hardcoded na Framework). Codigo legado nunca menciona a coluna diretamente.
2. **fAcessoEmpresa NAO foi portada** (ver `feedback_facessoempresa_nao_portada.md`) — gerador cai em fallback SQL direto.
3. **O gerador inventa nomes de coluna** por analogia:
   - `SigCdBal.Emps` (INVENTARIOS) e `SigIvTrh.Emps` (TRANSACOES DE INVENTARIO) sao tabelas relacionadas que **realmente tem** `emps` (char(3), identifica empresa origem dos dados). Gerador projeta `Emps` para `SigCdEmp` por analogia.
   - Nomes de TextBox no SCX legado (`Get_Empresa`/`getDEmps`/`GetCemps`/`GetDEmps`) sugerem "emps" como token de coluna.

**Codigo ERRADO** (SELECT inventado — FormSigReAiv.prg pre-Erro44):
```foxpro
loc_cSQL = "SELECT Emps, NComps FROM SigCdEmP WHERE Emps = " + EscaparSQL(loc_cCodigo)
loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
IF !EOF()
    loc_oPg.txt_4c_Empresa.Value  = ALLTRIM(Emps)       && Runtime: Variable 'EMPS' is not found
    loc_oPg.txt_4c_Dempresa.Value = ALLTRIM(NComps)     && Runtime: Variable 'NCOMPS' is not found
ENDIF
```

**Codigo ERRADO** (FormBuscaAuxiliar filter col — FormSIGREHCP.prg pre-Erro44):
```foxpro
loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
    "SigCdEmp", "cursor_4c_BuscaCEmps", "emps", loc_cValor, ;
    "Sele" + CHR(231) + CHR(227) + "o de Empresa", .F., .T., "")
loc_oBusca.mAddColuna("emps", "", "C" + CHR(243) + "digo")   && filtro por coluna inexistente
loc_oBusca.mAddColuna("nemp", "", "Empresa")                 && idem
```

**Codigo CORRETO**:
```foxpro
loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cCodigo)
loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
IF !EOF()
    loc_oPg.txt_4c_Empresa.Value  = ALLTRIM(Cemps)
    loc_oPg.txt_4c_Dempresa.Value = ALLTRIM(Razas)
ENDIF

loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
    "SigCdEmp", "cursor_4c_BuscaCEmps", "cemps", loc_cValor, ;
    "Sele" + CHR(231) + CHR(227) + "o de Empresa", .F., .T., "")
loc_oBusca.mAddColuna("cemps", "XXX", "C" + CHR(243) + "digo")   && mask 3 X (char(3))
loc_oBusca.mAddColuna("razas", "",    "Empresa")
```

**Regra IMPORTANTE — nao aplicar em outras tabelas**:
- `SigCdBal.emps` (SigCdBal char(3)) — coluna EXISTE. `SELECT Codigos, Grupos FROM SigCdBal WHERE Emps = <empresa>` esta CORRETO.
- `SigIvTrh.emps` (SigIvTrh char(3)) — coluna EXISTE. `SELECT a.*, b.dPros FROM SigIvTrh a WHERE Emps = <empresa>` esta CORRETO.
- Muitas outras tabelas `Sig*Mv*`/`Sig*Iv*` que rastreiam movimentacoes por empresa tem `emps` legitimo.

A regra so se aplica quando o `FROM` (ou 2o arg de `FormBuscaAuxiliar`) eh **`SigCdEmp`** (cadastro de empresa).

**Padrao canonico** (varios forms REPORT ja implementam corretamente):
- `Formsigrevto.prg` linhas 1167/1233 — `SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps/Razas LIKE`
- `Formsigreimp.prg` linhas 1060/1387 — `SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE Cemps = ...`
- `Formsigrehpr.prg` linhas 834/1366
- `Formsigrehbr.prg` linha 2239
- `Formsigrefcd.prg` linhas 463/803
- `Formsigrepes.prg` linha 4327 — `SELECT Cemps FROM SigCdEmp WHERE Ativas = 1`

**Auto-fix**: CorretorAutomatico Pattern #125 (`Corrigir-SigCdEmpColunasInvalidas`).

Fase 1 — **identificar cursores populados de SigCdEmp**:
- SQLEXEC: `FROM SigCdEmp` + cursor destino nas proximas 3 linhas
- FormBuscaAuxiliar: `CREATEOBJECT("FormBuscaAuxiliar", ..., "SigCdEmp", <cursor>, ...)` — cursor pode ser string literal OU variavel `loc_c*` (backward search por atribuicao)

Fase 2 — **corrigir contextos SigCdEmp** (preservando case):
- (a) Linhas com `SigCdEmp` E token `emps`/`Emps`/`EMPS`/`nemp`/`Nemp`/`NComps`/`ncomps`/`NCOMPS` → substituir por `cemps`/`Cemps`/`CEMPS`/`razas`/`Razas`/`Razas`/`razas`/`RAZAS`. Aplica em SELECT list, WHERE clause, JOIN condicoes.
- (b) Dentro de bloco `AbrirBusca*` que abre `SigCdEmp` (detectado por proximidade de `CREATEOBJECT("FormBuscaAuxiliar")` com `"SigCdEmp"`): substituir 3o argumento (filter col) do CREATEOBJECT e `mAddColuna("emps"|...)` → forma correta.
- (c) Referencias `<cursor>.emps`/`<cursor>.nemp`/`<cursor>.NComps` para cursores identificados na Fase 1 → substituir.

Preservacao de case por token:
- `emps` → `cemps`, `Emps` → `Cemps`, `EMPS` → `CEMPS`
- `nemp` → `razas`, `Nemp` → `Razas`, `NEMP` → `RAZAS`
- `NComps` → `Razas`, `ncomps` → `razas`, `NCOMPS` → `RAZAS`

Idempotente (segundo run nao altera nada). Safety: `SigCdBal.emps`/`SigIvTrh.emps` NUNCA sao tocados porque o predicado da Fase 2(a) exige `SigCdEmp` na mesma linha.

**Bug**: 
- `FormSigReAiv.prg` (Analise Entre Inventarios) linhas 662-766 — 6 refs no Form (ValidarEmpresa + AbrirBuscaEmpresa). BO OK (usava `SigIvTrh.Emps` legitimo).
- `FormSIGREHCP.prg` (Historico Custo Produto) linhas 957-1060 — 15 refs no Form (2 SELECT + 4 FormBuscaAuxiliar/mAddColuna blocks). BO sem refs.

Ambos 2026-07-16, Erro44 reportado via screenshot em `origem/correcoes/Erro44.PNG`. Fix per-callsite aplicado antes de escrever este Pattern; Pattern #125 protege proximas migracoes.

**Referencias correlatas**:
- `feedback_facessoempresa_nao_portada.md` — causa raiz upstream (Framework fAcessoEmpresa nao portada)
- `feedback_sigcdgcr_descrs_col.md` — mesmo tipo de bug (coluna inventada por analogia)
- Pattern #105 (SigCdOpe.descrs) — mesma familia de bugs
- Pattern #115 (SigCdGcr.descrs) — mesma familia de bugs

