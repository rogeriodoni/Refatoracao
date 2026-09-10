# CLAUDE.md - Project Guide

This file provides critical guidance to Claude Code when working with code in this repository.

**IMPORTANT**: Detailed VFP9 reference, migration patterns, control properties, and error tables are in the **vfp9-migration skill** (`.claude/skills/vfp9-migration/`). The skill loads automatically during migration tasks.

## Project Overview

Sistema em Visual FoxPro 9 com arquitetura SOLID em camadas, conectando ao SQL Server (192.168.200.10, banco DB_MBAHIA - ver `projeto/app/start/config.prg:22-25`).

### Filosofia de Refatoracao - 3 Pilares Inegociaveis

```
+========================================================================+
|                       PILARES DA REFATORACAO                           |
+========================================================================+
|  1. UX (User Experience)    -> MANTER O MAIS PROXIMO POSSIVEL         |
|  2. BANCO DE DADOS (Schema) -> IDENTICO (exceto LogAuditoria)         |
|  3. CODIGO-FONTE/ARQUITETURA -> OBRIGATORIAMENTE DIFERENTE            |
+========================================================================+
```

**PILAR 1 - UX**: Interface visual PIXEL-PERFECT identica ao legado. Comportamento, teclas de atalho (F4/F5), fluxo de trabalho identicos. O usuario NAO deve perceber diferenca.

**PILAR 2 - Banco**: Schema IDENTICO. NUNCA renomear tabelas/colunas, alterar tipos, adicionar/remover campos. Usar nomes EXATOS (SigCdCor, cgrus, dpros). Schema: `docs/schema.sql`

**PILAR 3 - Codigo**: Arquitetura em camadas (FormBase/BusinessBase/DataAccess). Nomes DIFERENTES do legado. Sufixo `_4c_` em objetos. Prefixos `loc_`, `par_`, `this_` em variaveis.

## Folder Structure

```
C:\4c\
├── CLAUDE.md              # Este arquivo
├── .claude\skills\        # Skills: vfp9-migration (referencia), propagate-lesson (propagar licoes)
├── docs\                  # Documentacao detalhada
│   ├── lookup_implementation.md
│   ├── grid_implementation.md
│   ├── form_patterns.md
│   ├── sql_guide.md
│   ├── migration_guide.md
│   ├── report_guide.md
│   ├── schema.sql
│   └── FRAMEWORK_class_codigo_fonte.txt
├── Framework\             # Sistema legado
├── tasks\                 # Tarefas de migracao
├── projeto\app\           # Codigo fonte novo sistema
│   ├── start\             # main.prg, config.prg
│   ├── classes\           # BOs e classes base
│   ├── forms\             # Formularios (cadastros/relatorios/operacionais)
│   ├── utils\             # functions.prg, messages.prg, validators.prg
│   └── reports\           # Relatorios
└── vbmp\                  # Icones e imagens
```

## Architecture (Three-Layer)

```
FormBase (UI) -> BusinessBase (BO) -> DataAccess (SQL Server)
```

- Forms inherit from `FormBase` (app/classes/formbase.prg)
- BOs inherit from `BusinessBase` (app/classes/businessbase.prg)
- Data layer uses `DataAccess` (app/classes/dataaccess.prg)
- Grids use `GridBase` (app/classes/gridbase.prg)

## Naming Conventions

### Classes & Files
- BOs: `[Entity]BO.prg` (CorBO.prg, ClienteBO.prg)
- Forms: `Form[Entity].prg` (FormCor.prg, FormCliente.prg)
- Reports: `Relatorio[Entity].prg` + `Rel[Entity].frx`

### Objects (suffix _4c_)
- TextBox: `txt_4c_Codigo`, CommandButton: `cmd_4c_Incluir`, Grid: `grd_4c_Dados`, PageFrame: `pgf_4c_Paginas`

### Variables
- Local: `loc_cCodigo`, `loc_nValor` | Parameter: `par_cCodigo` | Property: `this_cCodigo`
- Cursors: `cursor_4c_Dados`, `cursor_4c_Busca`, `cursor_4c_Lista`

## Global Variables

- `gnConnHandle`: SQL Server connection handle
- `gc_4c_UsuarioLogado`: Current logged user
- `go_4c_Sistema`: System object (cEmpresa, cCodEmpresa, cCNPJ, BuscaP, BuscaNome, Matrizes, Transitorio)
- `gc_4c_CaminhoBase/Classes/Utils/Forms/Icones/Reports`: Path variables (RELATIVE, based on SYS(16))
- `_EMPR`: **LEGACY - NEVER use** -> `go_4c_Sistema.cCodEmpresa`

## Critical VFP9 Rules (Top 5)

### 1. NEVER RETURN inside TRY/CATCH
Use flag variable (`loc_lResultado`), RETURN only OUTSIDE TRY/CATCH.

### 2. ISEMPTY() does NOT exist
Use `EMPTY()`. ISEMPTY generates "File 'isempty.prg' does not exist".

### 3. BINDEVENT requires PUBLIC methods
PROTECTED methods fail silently. Handlers must declare event parameters (AfterRowColChange needs par_nColIndex, KeyPress needs par_nKeyCode + par_nShiftAltCtrl).

**Mesma regra vale para `TesteAutomatico.prg`**: o harness chama `THIS.oForm.CarregarLista()` / `AlternarPagina()` / `AjustarBotoesPorModo()` / `BtnIncluirClick()` / `BtnCancelarClick()` direto de fora da classe (nao via BINDEVENT). `PEMSTATUS(oForm, "Metodo", 5)` retorna `.T.` mesmo se o metodo for PROTECTED (so verifica existencia, nao escopo) - o teste entra no branch e a chamada real falha em runtime com `Property METODO is not found.`. Esses metodos DEVEM ser PUBLIC. Auto-fix: CorretorAutomatico Pattern #196.

### 4. Portuguese accents: use CHR() codes
NEVER literal accented chars in .PRG. Key codes: CHR(225)=a-acute, CHR(227)=a-tilde, CHR(231)=c-cedilla, CHR(233)=e-acute, CHR(237)=i-acute, CHR(243)=o-acute, CHR(245)=o-tilde, CHR(250)=u-acute.

### 5. SQL Formatting: ALWAYS use helper functions
`FormatarNumeroSQL()`, `FormatarDataSQL()`, `EscaparSQL()` - all return WITH quotes, NEVER add extra quotes.

### 6. Unattended execution: SET SAFETY OFF in auxiliary scripts
Pipeline runs overnight without supervision. Any .prg script that writes files (STRTOFILE, COPY FILE, COMPILE) MUST start with `SET SAFETY OFF` + `SET RESOURCE OFF`. Modal dialogs block the pipeline indefinitely.

### 7. MsgConfirma() retorna LOGICAL, nao numerico
`MsgConfirma()` retorna `.T.`/`.F.`. NUNCA `IF var = 6`. Usar `IF var` / `IF !var`.

### 8. Metodos PROTECTED devem ser chamados com THIS.
Sem `THIS.`, VFP9 busca `nomeMetodo.prg` externo → "File does not exist". SEMPRE `THIS.NomeMetodo()`.

### 9. CATCH nunca silencioso
Todo CATCH deve ter `MsgErro(loc_oErro.Message, "Erro")` no minimo. CATCH vazio engole erros e impossibilita debug.

### 9.1 PUBLIC nao existe em DEFINE CLASS
`PUBLIC FUNCTION` / `PUBLIC PROCEDURE` dentro de `DEFINE CLASS ... ENDDEFINE` = SYNTAX ERROR. Metodos sao PUBLIC por default. Apenas `PROTECTED` e `HIDDEN` sao modifiers validos.

### 9.2 Page.Width / Page.Height READ-ONLY em runtime
Pages (PageFrame.PageN) NAO aceitam atribuicao a `.Width`/`.Height` em runtime. Tentar causa "CREATEOBJECT retornou valor nao-objeto". PageFrame controla automaticamente.

### 9.3 MostrarAviso NAO EXISTE
Apenas `MostrarErro` (FormErro.prg), `MsgAviso`, `MsgErro`, `MsgConfirma`, `MsgInfo` (messages.prg). `MostrarAviso(...)` causa "File 'mostraraviso.prg' does not exist" em runtime. CorretorAutomatico #90 auto-corrige.

### 9.4 DataSession=2 reseta SET DATE/CENTURY
Forms com `DataSession = 2` (private datasession) recebem datasession isolada com SETs no DEFAULT VFP (`SET DATE TO AMERICAN`, `SET CENTURY OFF`). Sem correcao, datas exibem como `05/25/26` (MM/DD/YY) em vez de `25/05/2026`. Fix sistemico em `FormBase.Init()` (chama `SET DATE TO BRITISH` + `SET CENTURY ON`). **Pre-requisito**: Form Init() DEVE chamar `DODEFAULT()` para que FormBase.Init() execute. Auto-fix: CorretorAutomatico #95.

### 10. Padrao Canonico Saida/Encerrar (PREVALECE sobre PILAR 1)
O bloco de saida dos forms CRUD (container + botao Encerrar) segue o padrao canonico do sistema novo, **NAO o SCX legado**. Esta regra tem precedencia sobre o PILAR 1 (pixel-perfect legado) para este bloco especifico.

| Objeto | Propriedade | Valor canonico |
|--------|-------------|----------------|
| `cnt_4c_Saida` | Left | **917** |
| `cnt_4c_Saida` | Width | **90** |
| `cnt_4c_Saida` | Height | 85 |
| `cmd_4c_Encerrar` | Left / Top | 5 / 5 |
| `cmd_4c_Encerrar` | Width / Height | **75 / 75** |
| `cmd_4c_Encerrar` | Caption | **"Encerrar"** |
| Containers de Page | Width | **`THIS.Width`** (NUNCA `THIS.Width - 60/-65`) |

Se o SCX legado tem `Grupo_Saida.Left=935`, `Width=60`, botao com `Caption="X"`/`"Sair"`/`"Fechar"` ou `Width=50`, **IGNORAR e usar o canonico**. O container de saida eh flutuante/transparente sobre a Page, por isso a Page nao precisa "deixar espaco" — subtrair largura deixa faixa clara exposta.

Auto-fix: CorretorAutomatico patterns **#81, #88, #89**. Referencia: `FormCor`/`FormMoe`.

### 11. Faixa do Cabecalho nas DUAS Paginas (PREVALECE sobre PILAR 1)
A faixa cinza do cabecalho vai na pagina **Lista E na pagina Dados**. No `frmcadastro` legado o `cntSombra` existe so em `Pagina.Lista` — padronizar as duas paginas foi decisao do time (Erro152) e tem precedencia sobre o PILAR 1 neste bloco.

| Objeto (na Page2 tambem) | Propriedade | Valor canonico |
|--------------------------|-------------|----------------|
| `cnt_4c_Cabecalho` | Top / Left | **29** / 0 |
| `cnt_4c_Cabecalho` | Width / Height | **`THIS.Width`** / **80** |
| `cnt_4c_Cabecalho` | BackColor | **RGB(100, 100, 100)** |
| `lbl_4c_Sombra` | Top / ForeColor | 15 / RGB(0,0,0) |
| `lbl_4c_Titulo` | Top / ForeColor | 18 / RGB(255,255,255) |
| ambos os labels | Font / Caption | Tahoma 16 bold / **`THIS.Caption`** |

**A faixa tem de ser o PRIMEIRO `AddObject` da pagina** — os containers de botao ficam em Top=29..33, dentro da area da faixa, e precisam ser criados depois para desenhar por cima. Consequencia: nenhum controle de dados pode ter `Top < 109` (29+80). **Excecao**: se a pagina tem um PageFrame/Container interno que cobre tudo (`Formgpd.pgf_4c_Divisoes`), ele pinta por cima da faixa — criar a faixa DEPOIS dele e trazer a barra de botoes para frente com `ZOrder(0)`.

**NUNCA detectar o cabecalho pelo NOME**, em nenhuma direcao: 8 forms chamam a faixa de `cnt_4c_Sombra` (detectar por nome duplicou a faixa em 3 forms) e o `Formpgr` usa `cnt_4c_Cabecalho` para um container de CAMPOS (reusar o nome estoura "object already exists" — nesse caso usar `cnt_4c_FaixaTitulo`). Identificar sempre por `BackColor = RGB(100,100,100)` **+ `Height >= 60`**.

**Pagina cheia exige re-layout, nao so a injecao**: deslocar os filhos diretos ate o primeiro controle de dados ficar em `Top >= 115`; encolher no rodape apenas controles FOLHA (Grid/EditBox/Image/Shape) — encolher Container/PageFrame CORTA o conteudo interno; o que nao encolhe vira aumento do `Form.Height` (e a grade da Lista cresce junto). Ficam POR CIMA da faixa, sem deslocar: `cnt_4c_Botoes*`/`cnt_4c_Salva*`/`cnt_4c_Saida` e a barra de acao do topo (CommandButton/Container/OptionGroup com Top 20..55 e Height 60..100).

**Ao varrer os forms**, a pagina chega aos metodos de tres formas: variavel (`loc_oPagina = ...Page2`), `Pages(2)` e **PARAMETRO** (`ConfigurarPaginaDados(par_oPagina)`, encadeado ate 3 niveis no FormCTA). Ignorar o caso do parametro faz a ferramenta "nao ver" a faixa que ja existe (FormEmn) nem os controles que ficariam soterrados. Variavel reatribuida a outra coisa (`loc_oPage = par_oPage`, Formpag) tem de PERDER o mapeamento.

Nao se aplica a form sem pagina de dados real: `FormFpd` (OPERACIONAL com PageFrame stub fora da tela) e `FormGcp` (Page2 declarada "reservada").

A faixa tem de ser o PRIMEIRO `AddObject` da pagina Dados: os containers de botao ficam em `Top = 29..33`, DENTRO da area da faixa, e so aparecem se criados DEPOIS dela — invertido, o cabecalho COBRE Confirmar/Encerrar (Erro156, auto-fix **#195**). O `ZOrder(0)` da excecao (`Formgpd`) eh o que distingue esse caso de um bug. Conferir tambem que os labels da faixa nao ficaram PELADOS (`AddObject` sem propriedade nenhuma) — o titulo sai como label default minusculo, preto sobre cinza.

WARNING: CorretorAutomatico **#190**. Ferramentas: `automation\LibCabecalhoPaginas.ps1` (parsers compartilhados), `automation\DiagnosticoCabecalhoPaginas.ps1`, `automation\AplicarCabecalhoComDeslocamento.ps1` (injeta + re-layouta), `automation\InjetarCabecalhoPaginaDados.ps1` (so paginas com espaco livre). Referencia: `Formcfo`.

### 12. Label de dados NUNCA com ForeColor branco - canonico RGB(90, 90, 90)
As Pages do PageFrame recebem `.BackColor = RGB(100,100,100)` **e** `.Picture = fundo_cad_1003.jpg` (textura CLARA). A Picture cobre o BackColor, entao `.ForeColor = RGB(255,255,255)` num controle criado direto na Page (ou em container `BackStyle = 0`) fica **INVISIVEL** - o usuario clica Incluir e ve as caixas de texto sem legenda.

| Objeto no dump do SCX legado | ForeColor no migrado |
|------------------------------|----------------------|
| **nao declara** ForeColor (classe `say`) | **`RGB(90, 90, 90)`** |
| `36,84,155` (titulo de secao, Verdana bold) | `RGB(36, 84, 155)` |
| `255,0,0` (nota de rodape) | `RGB(255, 0, 0)` |
| quase-branco (`231,254,253`) | escurecer p/ cor das labels irmas |

`Say<N>` do legado vira `lbl_4c_Label<N>` no migrado - procurar pelos **dois** nomes no dump. **Branco continua correto** em: `lbl_4c_Titulo`/`lbl_4c_Sombra` do cabecalho; controle em container OPACO escuro (`BackStyle=1` + BackColor `RGB(100,100,100)`/`RGB(90,90,90)`); rotulo de barra de progresso; e `HighlightForeColor`/`SelectedForeColor`/`SelectedItemForeColor` (linha selecionada).

WARNING: CorretorAutomatico **#191**. Referencia: `FormCor`. Origem: Erro153 (sweep de 217 sites em 23 forms).


### 13. NUNCA chamar helper que voce nao definiu (erro so em RUNTIME)
Em VFP9, nome desconhecido seguido de `(` **nao eh erro de compilacao**: o interpretador resolve procurando `<nome>.prg` em disco. O `.prg` compila limpo e o erro so aparece quando o usuario aciona o botao: `File 'nomedafuncao.prg' does not exist.`

Duas familias com a mesma mensagem:

| Familia | Causa | Fix |
|---------|-------|-----|
| **Helper inexistente** | migrador inventou a funcao e nunca definiu | DEFINIR em `projeto\app\utils\functions.prg` |
| **Metodo sem `THIS.`** | `ValidarDados()` no lugar de `THIS.ValidarDados()` | prefixar com `THIS.` (regra #8) |

**Helpers globais que JA existem** (nao reinventar): `TratarNulo`, `EscaparSQL`, `FormatarNumeroSQL`, `FormatarDataSQL`, `ConverterParaLogico`, `MsgErro`, `MsgAviso`, `MsgInfo`, `MsgConfirma`, `MostrarErro`, `Centralizar`, `CapturarErroSQL`.

**Helper que le coluna do banco tem de testar `VARTYPE` antes de comparar**: coluna `bit` do SQL Server chega ao VFP ora como Logico (`.T.`/`.F.`) ora como Numerico (0/1) conforme o driver; `numeric(1,0)` sempre Numerico; char de marcacao como `"S"`/`"N"`. Comparar Logico com `1` estoura *Operator/operand type mismatch*.

Auditoria: `automation\VerificarFuncoesNaoDefinidas.ps1`. WARNING: CorretorAutomatico **#192**. Origem: Erro154 (`ConverterParaLogico` chamado em 17 sites de 6 BOs sem existir).

### 14. `docs/schema.sql` eh UTF-16 - NUNCA validar schema com grep
`grep`/`awk`/`findstr` tratam o arquivo como **binario** e devolvem **ZERO ocorrencias silenciosamente**, fazendo tabela e coluna EXISTENTES parecerem inexistentes. O perigo nao eh o zero: eh a "correcao" que ele sugere - apontar o BO para outra tabela grava dado no lugar errado e viola o PILAR 2.

```powershell
# CERTO - Get-Content -Raw respeita o BOM UTF-16
$t = Get-Content 'C:\4c\docs\schema.sql' -Raw
[regex]::Matches($t, '(?i)CREATE TABLE \[dbo\]\.\[([A-Za-z0-9_]+)\]').Count   # 682
```

`tasks\<task>\schema_ascii.sql` **nao** eh fonte de verdade: eh snapshot congelado na epoca da task (task351 tem 674 tabelas contra 682 do canonico) e faz tabela nova parecer ausente.

**Erro `Nome de objeto 'X' invalido`** vem do SQL Server (nao do VFP) e nao quebra compilacao. Diagnosticar nesta ordem:

1. a tabela esta no schema canonico? (encoding certo)
2. o legado usa o mesmo nome? (`tasks\<task>\*_form_codigo_fonte.txt`)
3. **existe no schema + legado usa o mesmo nome** -> migrado esta FIEL; a divergencia eh de **BANCO/ambiente** e NAO se conserta no codigo
4. **legado usa outro nome** -> erro de migracao: corrigir para o nome do legado

Auditoria: `automation\VerificarTabelasInexistentes.ps1`. WARNING: CorretorAutomatico **#193**. Origem: Erro155 (FormBlq — `grep` no schema disse "10 tabelas ausentes"; na verdade era **1**).

### 15. `EVALUATE()` NAO atribui - use `STORE ... TO (...)`
`EVALUATE()` **avalia** uma expressao e devolve o valor. Com um `=` dentro da string, o VFP enxerga uma **comparacao**, avalia como `.T.`/`.F.` e descarta - **sem erro e sem aviso**, o campo nunca muda.

```foxpro
* ERRADO - nao limpa nada
EVALUATE("loc_oCnt." + par_cTxtDesc + ".Value = ''")

* CERTO
STORE ""        TO ("loc_oCnt." + par_cTxtDesc + ".Value")
STORE loc_cDesc TO ("loc_oCnt." + par_cTxtDesc + ".Value")
```

**EVALUATE continua CERTO para LEITURA** - o `=` fica FORA da string e eh comparacao mesmo:

```foxpro
loc_c    = EVALUATE("loc_oCnt." + par_cTxtCon + ".Value")
loc_oCnt = EVALUATE("loc_oPg2." + par_cCnt)
IF EVALUATE("VARTYPE(loc_oCnt." + par_cX + ")") = "O"
IF EVALUATE("loc_oCnt." + par_cTxtCon + ".Value") = "X"
```

Auto-fix: CorretorAutomatico **#194** (forma segura; valor com concatenacao/funcao vira WARNING). Origem: Erro155 - no `Formlch` a descricao do GRUPO nunca apareceu nos 7 containers, desde a migracao.

### 16. `TTOD()` so aceita DATETIME - com DATE dispara erro 11 em RUNTIME
`TTOD()` converte DATETIME -> DATE. Passar um **DATE** estoura `Function argument value, type, or count is invalid.` O `.prg` **compila limpo** — o usuario so descobre ao acionar o botao.

O mesmo campo chega com tipos DIFERENTES conforme o caminho:

| Origem do valor | Tipo |
|-----------------|------|
| TextBox criado com `.Value = {}` | **DATE** (modo INCLUIR) |
| coluna `datetime` do SQL Server via SQLEXEC | **DATETIME** (modo ALTERAR) |
| cursor VFP com coluna `D` / `T` | DATE / DATETIME |

Por isso o form **funciona em ALTERAR e explode em INCLUIR**. No legado nao acontecia porque o TextBox tinha `ControlSource` na coluna datetime.

```foxpro
* ERRADO
loc_dBase_d = TTOD(THIS.this_dDataBase)     && erro 11 quando eh DATE

* CERTO
loc_dBase_d = ConverterParaData(THIS.this_dDataBase)
```

`ConverterParaData()` (`utils\functions.prg`) normaliza DATE/DATETIME/CHAR; com DATETIME o resultado eh identico ao TTOD, entao a troca nao regride. `TTOD()` direto **so** em coluna de cursor vinda de SQLEXEC. **NUNCA** trocar dentro de `SELECT`/`INDEX ON` — UDF ali muda o plano e quebra Rushmore.

Auto-fix: CorretorAutomatico **#197**. Origem: Erro157 (FormCCJ "Calculo de Juros" nao gravava nada).

### 17. Formula de calculo do legado: TRANSCREVER, nunca reescrever
A expressao aritmetica eh **regra de negocio**. Reescrita, a tela grava valor errado **sem erro nenhum na tela** — ninguem reporta.

```foxpro
* Legado: lnLiq = Round(lnValor - (lnValor*((lnDias/30*(lnFator/100)))),2)
* ERRADO (o que o migrador escreveu): juros SOMADOS, taxa DIARIA
loc_nLiquido = loc_nValor + loc_nValor * (loc_nFator / 100) * loc_nDias
* CERTO: juros DESCONTADOS, taxa MENSAL prorrateada
loc_nLiquido = ROUND(loc_nValor - (loc_nValor * ((loc_nDias / 30) * (loc_nFator / 100))), 2)
```

Vao JUNTO com a formula, e o migrador costuma jogar fora:
1. **SINAL** — o legado NAO zera diferenca de datas negativa; data anterior a base gera dias negativos de proposito.
2. **GUARDS** — `Abs(lnDias) > 999` avisa, limpa o campo e ABORTA porque a coluna destino eh `numeric(3,0)`; sem ele a gravacao estoura no SQL Server.
3. **CRITERIO DOS TOTAIS** — `Where Not Empty(Dias)` exclui as linhas com zero, resultado diferente de acumular tudo no `SCAN`. Totais com **fonte unica**: o BO calcula, o form so espelha.

Transcrever do dump legado (`tasks\<task>\*_form_codigo_fonte.txt`) linha a linha e so depois trocar os nomes. Sem auto-fix possivel — regra de negocio nao se detecta por regex.


### 18. `Column.AddObject` NAO faz o controle aparecer - falta o `CurrentControl`
Adicionar OptionGroup/CheckBox/ComboBox/Spinner a uma `Column` de Grid **cria o objeto mas nao o exibe**: a coluna segue desenhando o `Text1` dela. O controle existe, responde a `PEMSTATUS` e nunca aparece — o usuario ve o valor cru numa caixa de texto e nao tem como marcar nada.

```foxpro
grd.Column3.AddObject("opt_4c_Tipos", "OptionGroup")
WITH grd.Column3.opt_4c_Tipos
    .ButtonCount = 3
ENDWITH
grd.Column3.CurrentControl = "opt_4c_Tipos"   && SEM ISTO nada aparece
grd.Column3.Sparse         = .F.              && senao so aparece na linha ativa
grd.Column3.ReadOnly       = .F.              && senao aparece mas nao aceita clique
```

`Column.ReadOnly` tem de vir **DEPOIS** de `Grid.ReadOnly` — o do grid propaga para as colunas e sobrescreve.

Auto-fix: CorretorAutomatico **#198**. Origem: Erro158 (FormCco — OptionGroup Inserir/Excluir da coluna Tipo nunca apareceu).

### 19. `MaxLength` vem da largura da COLUNA no schema, nunca do `Width` em pixels
O migrador copia o `Width` do controle para o `MaxLength` — sao numeros vizinhos no mesmo `WITH`, mas um eh pixel e o outro caractere.

```foxpro
* ERRADO (FormCco, como saiu da migracao)
.Width = 220
.MaxLength = 220          && SigCdClc.descs eh char(30)
* CERTO
.MaxLength = 30
```

O usuario digita mais do que cabe e o SQL Server recusa o INSERT com *String or binary data would be truncated*. O `LEFT()` do INSERT/UPDATE no BO tem de usar o MESMO numero. **Alerta imediato: `MaxLength` igual ao `Width`.** Conferir em `docs/schema.sql` (UTF-16, ler com `Get-Content -Raw`).

WARNING: CorretorAutomatico **#199**. Origem: Erro158.

### 20. Falha de gravacao NUNCA eh muda - o `BusinessBase` ja reporta
`BusinessBase.Salvar()` e `Excluir()` chamam `ExibirFalha()` em todo caminho de validacao que antes devolvia `.F.` calado (fora de edicao, `ValidarDados`/`AntesDeGravar`/`AntesDeExcluir` recusando, CATCH), e marcam `this_lErroExibido`.

**O form NAO precisa de `ELSE`** em `IF <bo>.Salvar()`. Se tiver um, guardar:

```foxpro
IF THIS.this_oBusinessObject.Salvar()
    MsgInfo("Registro salvo com sucesso!", "Confirmar")
    THIS.AlternarPagina(1)
ELSE
    IF !THIS.this_oBusinessObject.this_lErroExibido
        MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o registro.", "Confirmar")
    ENDIF
ENDIF
```

Subclasses (`Inserir`/`Atualizar`/`ExecutarExclusao`) continuam exibindo o proprio `MsgErro` com o texto do SQL Server — a base detecta e nao repete. Se a subclasse deixar `this_cMensagemErro` preenchido sem exibir, a base exibe.

Origem: Erro158 — o defeito estava em **249 sites de 107 forms** e foi corrigido num arquivo so. O pattern #200, que os acusava um a um, foi **aposentado**.
### 21. Popular cursor NAO repinta a grade; e a condicao que CERCA a validacao eh regra
**(a)** Grade ligada a cursor vazio nao passa a exibir sozinha as linhas inseridas depois. O legado sempre fecha com `Go Top In <cursor>` + `<grid>.Refresh` — reproduzir num metodo unico chamado em TODO caminho que popula o cursor (Incluir/Alterar/Visualizar). Sem isso a grade fica visualmente vazia com o cursor cheio, e o sintoma reportado ("a tela nao traz dados") manda o diagnostico para SQL/cursor/permissao.

**(b)** As condicoes ao redor da validacao fazem parte dela. No FormCco o legado so dispara a consulta de sobreposicao quando `(FaixaI + FaixaF) <> 0` — sem esse guard, faixa 0 a 0 casa com qualquer registro cujo intervalo contenha zero e bloqueia a gravacao indevidamente. O migrado tambem tinha descartado a checagem `FaixaI > FaixaF` inteira e rodava tudo so no INCLUIR, quando o legado roda em INCLUIR **e** ALTERAR.

Sem auto-fix. Origem: Erro158.

**Full VFP9 reference, control properties, and 58 common errors**: See vfp9-migration skill.

## BusinessBase Property Names (CORRECT)

| WRONG | CORRECT |
|-------|---------|
| this_cNomeTabela | `this_cTabela` |
| this_cChavePrimaria | `this_cCampoChave` |
| this_oBO | `this_oBusinessObject` |
| ObterTodos() | `Buscar("")` |
| Deletar/Remover() | `Excluir()` (PUBLIC, chama ExecutarExclusao internamente) |

**IMPORTANTE**: Forms chamam `this_oBusinessObject.Excluir()` (PUBLIC). BOs sobrecarregam `ExecutarExclusao()` (PROTECTED). NUNCA chamar ExecutarExclusao() de fora do BO.

## config.prg - Dynamic Loading

ADIR() loads all `*BO.prg` and `Form*.prg` automatically. No manual SET PROCEDURE needed.

```
New entity checklist:
[ ] [Entity]BO.prg in app/classes/
[ ] Form[Entity].prg in app/forms/
[ ] Menu item in menu.prg
[ ] Delete .fxp files before testing
```

## Audit System

BusinessBase has `RegistrarAuditoria(par_cOperacao)` and `ObterChavePrimaria()`. Override ObterChavePrimaria in each BO. Called in Inserir/Atualizar/ExecutarExclusao.

## Form Types

| | CRUD (frmcadastro) | REPORT (frmrelatorio) | OPERACIONAL (form) |
|--|---|---|---|
| BO herda de | BusinessBase | RelatorioBase | BusinessBase |
| Layout | PageFrame Page1+Page2 | FLAT | CUSTOM (grids+containers) |
| Metodo chave | FormParaBO/BOParaForm | FormParaRelatorio | MontaGrade/CarregarDados |
| Acao principal | Inserir/Atualizar/Excluir | PrepararDados+REPORT FORM | Buscar/Imprimir |
| Destroy | DODEFAULT() | this_oRelatorio = .NULL. | DODEFAULT() |

## Processamento de Migracao

- **TODOS os forms**: Processamento multi-fase em 8 fases sequenciais (desde 2026-03-24)
- Modo SIMPLES (2 fases) desativado - gerava problemas recorrentes em forms OPERACIONAIS
- Docs: `docs/PROCESSAMENTO_MULTI_FASE.md`, `docs/METODOLOGIA_ARQUIVOS_GRANDES.md`

## Running the Application

```foxpro
CD C:\4c\projeto\app\start
DO main.prg
```

## REGRA FUNDAMENTAL: SEMPRE FUNCIONALIDADE COMPLETA

**PROIBIDO** criar versoes reduzidas, MVPs ou versoes simplificadas. Paridade funcional 100% com legado. TODOS os campos, lookups e funcionalidades. Se contexto insuficiente, dividir tarefa em partes - NUNCA omitir silenciosamente.

## Documentation Index

| Topic | File |
|-------|------|
| **VFP9 Reference + Control Properties + Errors** | `.claude/skills/vfp9-migration/` |
| **Propagar Licoes Aprendidas** | `.claude/skills/propagate-lesson/` |
| Guia Rapido Migracao | `docs/GUIA_RAPIDO_MIGRACAO.md` |
| Processamento Multi-Fase | `docs/PROCESSAMENTO_MULTI_FASE.md` |
| Estrategia Hibrida Contexto | `docs/ESTRATEGIA_HIBRIDA_CONTEXTO.md` |
| Lookups (FormBuscaAuxiliar) | `docs/lookup_implementation.md` |
| Grids (TextBoxGridLookup) | `docs/grid_implementation.md` |
| Forms (PageFrames, modos) | `docs/form_patterns.md` |
| SQL (SQLEXEC, transacoes) | `docs/sql_guide.md` |
| Migration (checklist) | `docs/migration_guide.md` |
| Reports (FRX, toolbar) | `docs/report_guide.md` |
| Testes Automatizados | `docs/TESTES_AUTOMATIZADOS.md` |
| Database Schema | `docs/schema.sql` |
| Framework Classes | `docs/FRAMEWORK_class_codigo_fonte.txt` |
| UI Fidelity Validation | `docs/ui_fidelity_validation.md` |
| FormCor Licoes | `docs/FORMCOR_LICOES_APRENDIDAS.md` |
| FormProduto Licoes | `docs/FORMPRODUTO_LICOES_APRENDIDAS.md` |
