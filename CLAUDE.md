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

**MAS**: essa mensagem tambem aparece sem `ISEMPTY()` nenhum no nosso codigo. Os VCX legado Fortyus (`framework.vcx`/`classresp.vcx`) chamam `IsEmpty()` no p-code COMPILADO, que nao da para editar; por isso existe o wrapper `projeto\app\utils\isempty.prg`, que so redireciona para `EMPTY()`. Se o erro aparecer com o wrapper no lugar, o problema eh o **PATH**, nao o codigo — ver regra **#26** e medir `SET("PATH")` ANTES de mexer em qualquer arquivo.

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

### 22. INSERT do BO tem de cobrir TODA coluna NOT NULL - a lista vem do SCHEMA, nunca do legado
O legado grava o registro INTEIRO (`AddCursor` sem query = `SELECT *` + `TABLEUPDATE`), entao coluna que nao aparece na tela continua sendo gravada em branco. O BO migrado lista so as colunas da tela; se alguma das ausentes for `NOT NULL` sem `DEFAULT`, o SQL Server recusa o INSERT inteiro e **o cadastro nao inclui nada**.

```
Nao eh possivel inserir o valor NULL na coluna 'nsenha', tabela 'DB_MBAHIA.dbo.SIGFICHC';
a coluna nao permite nulos. Falha em INSERT.
```

**A armadilha**: as colunas que faltam sao invisiveis no dump do legado. `nsenha` e `versao` (SigFiChc) nao tem property no BO, nao tem label na tela e **nao sao citadas em lugar nenhum** do codigo legado - existiam so no registro em branco do cursor. Conferir contra `docs/schema.sql` (UTF-16, `Get-Content -Raw` - regra #14) ou o `INFORMATION_SCHEMA`, **nunca** contra o dump do form.

| Coluna que falta | Valor |
|---|---|
| `cidchaves` / `pkchaves` (PK Fortyus) | `EscaparSQL(fUniqueIds())` - **NUNCA** string vazia, senao o 2o registro colide no indice unico |
| `usuars` / `usualts` | `gc_4c_UsuarioLogado` |
| com property no BO | a propria property |
| char sem property | `EscaparSQL("")` |
| numeric / bit | `FormatarNumeroSQL(0, <dec>)` / `0` |
| datetime sem property | sentinela `'19000101'` (nao `GETDATE()`) |

Cuidado com **colunas gemeas** ambas NOT NULL: `tipo`+`tipos` (SigCdRom), `prioridade`+`prioridades` (SigCdClc), `imprs`+`iimprs` (SigOpPic), `cidatrabs`+`cidtrabs` (SigCdCli) - acrescentar a que falta, nao trocar a existente.

**ANTES de acrescentar, conferir se a grafia JA presente no INSERT existe na tabela.** Se nao existe, nao sao gemeas: a migracao errou a grafia e o conserto eh o OPOSTO - **renomear**, nao acrescentar.

| A grafia ja presente existe? | Diagnostico | Conserto |
|---|---|---|
| sim | gemeas de verdade | ACRESCENTAR a que falta |
| nao | erro de grafia da migracao | RENOMEAR a existente |

Suspeitar de **metatese** (`ems`/`ens`, `oas`/`aos`, `tipo`/`tip`): gemeas de verdade diferem por um sufixo inteiro (`imprs`/`iimprs`), nao por letras trocadas de lugar. No `gpdBO`/`SigCdGrp` os SEIS pares eram erro de grafia (`margens`->`margems`, `pmargens`->`pmargems`, `padmargens`->`padmargems`, `tipestos`->`tipoestos`, `sugestoas`->`sugestaos`, `ntipjoals`->`ntipojoals`).

**O erro de grafia nunca fica so no INSERT**: esta no UPDATE (onde o validador so pega parte, porque o parser corta o `SET` na primeira linha sem continuacao) e na leitura do cursor em `CarregarDoCursor`, que **ninguem valida** - nao eh SQL, eh campo VFP. Como `CarregarPorCodigo` usa `SELECT *`, o cursor traz a grafia REAL e a leitura estoura em runtime com `Variable MARGENS is not found`: compila limpo e quebra Alterar/Visualizar. Renomear no arquivo INTEIRO, case-sensitive e com `\b`, preservando os nomes das properties (PILAR 3). Atencao a nomes que sao substring um do outro (`padmargens` contem `margens`).

Gate automatico: `Validate-InsertNotNull` no `ValidadorSQLSchema.ps1` (etapa `05f_validarSQLSchema`) - BLOQUEIA a migracao. Auditorias em lote: `automation\VerificarInsertNotNull.ps1` (INSERT sem coluna NOT NULL) e `automation\VerificarCamposCursorBO.ps1` (campo lido em `CarregarDoCursor` que nao existe em tabela nenhuma). Ao ler a saida do validador, ler **todos** os `[SQL-SCHEMA]` - filtrar so por `OMITE` esconde justamente o `coluna NAO EXISTE` que distingue grafia errada de coluna gemea. Skill: secao **191**. Origem: Erro151 (AliBO); **reincidiu** em Erro159 (CecBO/SigFiChc) mesmo com a regra ja nos prompts - por isso o gate.


### 23. Label de dados: NUNCA inventar `.Width` + `.Alignment = 1` - a classe `say` eh AutoSize/esquerda
A classe **`say`** do Framework legado eh `AutoSize = .T.` / `Alignment = 0`: o label tem a largura **exata do texto** e desenha **da esquerda**. Por isso o `Say` do SCX declara so `Caption`/`Left`/`Top` - **nunca `Width`, nunca `Alignment`** - e os `Left` vem escalonados pelo tamanho de cada legenda, para todas terminarem poucos pixels antes do campo.

```
Say2 "Codigo :" Left=411 | Say1 "Grupo :" Left=415 | Say3 "Conta :" Left=415 | Say4 "Setor :" Left=418
Get_codigo/Get_Grupo/get_Conta/Get_Setor -> Left=455
```
Medido no VFP9 (`TXTWIDTH() * FONTMETRIC(6,...)`, Tahoma 8): os quatro textos terminam em **451**, 4px antes do TextBox. Os `Left` diferentes nao sao descuido, sao o calculo.

```foxpro
* ERRADO - o migrador inventa as DUAS propriedades
.Left = 411
.Width = 60          && o legado nao declara
.Alignment = 1       && encosta o texto na borda DIREITA -> 411+60 = 471 > 455

* CERTO
.Left = 411
.Width = 60          && pode ficar: caixa transparente (BackStyle = 0)
.Alignment = 0       && legado: say com AutoSize=.T. e Alignment=0
```
O texto encostado na borda direita cai **dentro do TextBox**; como o label eh criado ANTES, o controle desenha por cima e come a legenda (`Codigo :` vira `Codi`). Compila limpo, so aparece na tela.

**`AutoSize = .T.` NAO resolve - eh no-op em Label criado por `AddObject`.** Medido nas duas ordens (`Caption`->`AutoSize` e `AutoSize`->`Caption`), antes e depois do `Show()` e reatribuindo o `Caption`: a `Width` fica nos **100** do default. Usar `Alignment = 0` + `Width` explicita que caiba o texto.

A caixa larga que sobra eh inofensiva (`BackStyle = 0` nao pinta e o controle fica por cima) **desde que o label seja criado ANTES do controle** - senao a caixa transparente bloqueia o clique no campo.

**O legado USA `Alignment = 1` legitimamente (884 labels nos dumps) - conferir antes de corrigir:**

| O `Say` do legado declara | Diagnostico | Conserto |
|---|---|---|
| nem `Width` nem `Alignment` | classe `say` pura - migrador inventou | `.Alignment = 0` |
| `Width` e/ou `Alignment` | right-align legitimo | **nao mexer no Alignment** - o erro esta no `Left`/`Width` |

**Detector tem de medir o TEXTO, nao a caixa**: comparar `Left + Width` com o `Left` do controle acusou **414 sites** (quase tudo falso positivo, porque a caixa com `Alignment = 0` eh invisivel); medindo o texto renderizado e filtrando por `Alignment = 1` sobraram 51 candidatos, **27 confirmados pelo dump** em 12 forms.

Auto-fix: CorretorAutomatico **#202** (auto-muta so com o dump confirmando; sem dump, WARNING). Referencia: `FormCES`. Origem: Erro160 (2026-09-16).

### 24. `Format` com `M` eh multiple choice - o `InputMask` eh a LISTA de valores validos
`Format` contendo a letra `M` muda o significado do `InputMask`: ele deixa de ser mascara de digitacao e vira a **lista de valores aceitos**, separada por virgula. O migrador troca o `M` por `!` (que so forca maiuscula) e **descarta o InputMask** - compila limpo e o campo passa a aceitar QUALQUER caractere.

```foxpro
* ERRADO (Formcfi, como saiu da migracao) - campo "Tipo", rotulado "(T / S / I / N / F)", aceitava "A"
.Format    = "K!"
* CERTO - transcrito do SCX legado
.Format    = "KM"
.InputMask = ",T,S,I,N,F"
```

Medido no VFP9: `T`/`S`/`I`/`N`/`F` aceitos, `A`/`X`/`9`/`t`/`s` viram branco.

**A lista eh REGRA DE NEGOCIO - so TRANSCREVER.** `"A,B"` e `"0,1"` aparecem tanto quanto `"S,N"`; nao existe lista padrao. **Lista SEM item vazio coage o branco para o 1o item** (`"S,N"` faz `.Value = ""` valer `"S"`, inclusive no `LimparCampos` do Incluir) - eh o comportamento do legado, NAO acrescentar item vazio que o legado nao tem. A entrada vazia, quando existe, vem como virgula inicial (`",T,S,I,N,F"`) ou final (`"S,N, "`).

**Diagnostico**: `KEYBOARD` num harness NAO dirige controle `Format = "M"` - digitacao simulada da falso negativo ate nas variantes que funcionam em producao. Testar por **atribuicao** (`.Value = "A"` e ler de volta).

Auto-fix: CorretorAutomatico **#203** (muta so com o dump confirmando o par). Referencia: `Formcfi`, `FormCargo`. Origem: Erro161 (8 sites em 2 forms).

### 25. `.Picture` inexistente falha em SILENCIO - o icone vem do legado, nunca de palpite
O VFP9 aceita `.Picture`/`.Icon`/`.DisabledPicture` apontando para arquivo que **nao existe**: sem erro de compilacao, sem erro de runtime, nada no log - o controle so **nao desenha icone**. No `FormCliente` o botao "Visualizar" ficou so com texto no meio de cinco com icone, criados pelo MESMO laco com as MESMAS propriedades.

O migrador **inventa o nome a partir da acao** (`cadastro_incluir.jpg`, `geral_imprimir_32.jpg`) em vez de transcrever o do SCX legado. Duas armadilhas no `vbmp\`:
1. A grafia tem **typo de fabrica**: o arquivo eh `cadastro_vizualizar_60.jpg`, com **Z**.
2. O sufixo `_26`/`_60` **NAO eh o tamanho** - todos os icones sao 32x32; trocar de sufixo eh inocuo.

**O alvo vem do DUMP DO LEGADO, nunca de semelhanca semantica** - o palpite erra:

| form | botao | palpite | o que o legado usa |
|---|---|---|---|
| `FormBAL` | "Fecha" | icone de sair | **`cadastro_salvar_60.jpg`** (fechar = gravar) |
| `FormSigPrGlp` | "Disponiveis" | lupa | **`geral_palete_60.jpg`** |
| `FormCNF` | "Imprimir" | `relatorio_impressora_26` | **`printer.ico`** |
| `FormLin` | inserir (grid) | `cadastro_inserir_26` | **`geral_arquivo_26.jpg`** |

No `FormSigPrGlp`, **4 dos 6** sites teriam recebido icone errado pelo criterio semantico.

**O mesmo nome inventado pode ter alvos DIFERENTES no mesmo form** (`FormLpr`: `geral_imprimir_32.jpg` vira `geral_impressora_normal_60.jpg` na lista e `relatorio_impressora_26.jpg` na toolbar) - a chave eh **form + linha**, replace global corrompe.

**`IF FILE()` mascara, nao resolve**: o `FormSigPrGlp` envolve cada `.Picture` num guard, e por isso os 6 botoes ficaram sem icone desde a migracao sem ninguem notar. Excecao legitima: `gc_4c_LogoRelatorio` (`logo.bmp`) no `config.prg`.

Auto-fix: CorretorAutomatico **#204**. Referencia: `FormCor` (CRUD) e a toolbar de REPORT (`relatorio_video_26`/`relatorio_impressora_26`/`relatorio_excel_26`/`relatorio_sair_60`). Origem: Erro162 (54 sites em 20 forms).

### 26. `SET PATH TO (a), (b), (c)` honra SO a PRIMEIRA expressao
`SET PATH TO` recebe **UMA string** com a lista de diretorios. Com varias expressoes entre parenteses separadas por virgula, o VFP9 usa **so a primeira** e descarta o resto **em silencio** - sem erro de compilacao, sem erro de runtime, nada no log.

```foxpro
* ERRADO - so gcCaminhoBase entra no PATH
SET PATH TO (gcCaminhoBase), (gcCaminhoClasses), (gcCaminhoUtils)
* CERTO - reescrita de EXPRESSAO, sem variavel nova
SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils)
```

Medido no VFP9: com 3 expressoes o `SET("PATH")` fica so com a 1a; concatenado, as 3 entram.

**Especifico do `SET PATH`.** Medido: `SET PROCEDURE TO (a),(b),(c)` e `SET CLASSLIB TO (a),(b)` funcionam e entram TODOS - ali a virgula separa arquivos de verdade. NAO generalizar.

**O sintoma aparece LONGE da causa.** No `config.prg` isso fez `utils\`, `classes\`, `forms\` e `icones\` NUNCA estarem no PATH. Nada quebrou de imediato (o `config.prg` faz `SET PROCEDURE` de tudo com caminho completo), mas a resolucao de UDF por nome de `.prg` parou: os VCX legado chamam `IsEmpty()` no p-code, o VFP procura `isempty.prg` pelo PATH e estoura `File 'isempty.prg' does not exist / Procedure: when` ao digitar em campo com `When`. O wrapper existia e estava certo - so era inalcancavel.

**Diagnostico**: `.prg` que EXISTE aparecendo como "does not exist" -> medir `SET("PATH")` antes de mexer no arquivo. Duas hipoteses plausiveis que NAO se confirmaram (descartadas medindo): `SET PATH` nao eh escopado por data session, e nenhum codigo do projeto redefine PATH depois do startup.

Auto-fix: CorretorAutomatico **#205**, registrado nas DUAS listas (inclusive modo SEGURO - o arquivo de origem eh `start\config.prg`, que nao eh form nem BO). Origem: Erro162_Aba1.

### 27. Funcao GLOBAL do legado chamada pelo p-code do VCX: wrapper em `utils\`, nunca "deixar pra depois"
Os VCX (`framework/classobj/classresp.vcx`) sao **p-code compilado** e chamam funcoes globais da aplicacao legado (`sig.prg`/`SIGFUNCS.PRG`) que **nao vieram no acervo**. Nome desconhecido nao eh erro de compilacao (regra #13): o VFP procura `<nome>.prg` no PATH e so estoura em **RUNTIME**, dentro de `Init`/`Valid`/`Click` **fora de TRY/CATCH** -> **o form FECHA**.

No `GetEstado.Valid` (campo UF do Cadastro de Cliente) o `CreateObject('fwBuscaExt',...)` vem **SEM** o guard `Type()=='O'` que o `GetCEP` tem, e o `Init` do fwBuscaExt chama `fSQLExec()`. Digitar a UF fechava a tela.

Wrapper em `projeto\app\utils\<nome minusculo>.prg`, padrao `isempty.prg`: `LPARAMETERS` + `RETURN`, **sem cabecalho `FUNCTION`** (resolve pelo NOME do arquivo). O comentario tem de dizer de onde vem a chamada e **o que se perde**.

| Categoria | Criterio | Exemplos |
|---|---|---|
| Implementar | os call sites fecham o contrato | `fSQLExec`, `fValidarCpf/CNPJ`, `fAbrirTabs`, `fVerificaPasta`, `fMensagemFixa` |
| No-op documentado | retorno descartado / caminho seguro obvio | `fChkCpoVlc`(.T.), `fChkCntVlc`(.F.), `fGravarLog`, `fInibirBtn`, `fGerPDFCreator` |
| **DEIXAR AUSENTE** | devolve **valor de calculo** | `fCalcularST`, `fCalcularIPI` |

A 3a linha eh a que se erra: stub devolvendo `0` para imposto grava numero errado **em silencio** (regra #17); ausente, o erro aparece alto. Ao contrario, `.F.` puro em `fGerPDFCreator` fazia o usuario clicar e nada acontecer - ali o wrapper **diverge do legado de proposito** e avisa. Ausencia tem de ficar VISIVEL.

**O wrapper tem de reproduzir o CONTRATO, nao so o nome.** Redirecionar para a primitiva VFP de nome parecido NAO basta: `IsEmpty` do Fortyus **nao eh** `EMPTY` do VFP. Medido: `EMPTY(.NULL.)` devolve `.F.` - para a nativa, NULL "nao esta vazio"; para o legado, esta. O `isempty.prg` fazia so `RETURN EMPTY(par_uValor)` e divergia nesse unico caso, em **142** call sites do p-code. O sintoma sai LONGE da causa e sem erro: o `mRetiraNull` do `clsconta` limpa nulos com `Update crSigCdCli Set Obs = "" Where IsEmpty(Obs)`, o `WHERE` nao casava e o campo Obs. do Cadastro de Cliente exibia **`.NULL.`** na tela. Guarda de NULL **antes** de delegar, com `IF` separado - `ISNULL(x) OR EMPTY(x)` avaliaria `EMPTY(x)` de qualquer jeito, porque VFP9 nao faz short-circuit em OR. Ao escrever ou revisar wrapper, testar NULL, vazio, zero, `.F.` e **argumento ausente**, e provar por tabela que todo valor fora do caso corrigido devolve o MESMO de antes. Delegacao com guarda de tipo eh o padrao certo (`fvalidarcpf.prg`/`fvalidarcnpj.prg` checam `VARTYPE` antes de delegar). Skill: secao **217**. Origem: Erro166 (2026-09-22).

**Vale para OBJETO global**: sem `goSistema.ObjectConn` (`cOpenConn` de `classes\sigclcnx.PRG`, que le `dbo.SigConn`), `CreateObject('fSqlConector','cep')` devolve `pnIdConn = -1` e o VCX exibe *"Impossivel Efetuar Conexao Com o Servidor de Banco de Dados..."* - mensagem que **mente**, porque a conexao principal esta viva.

**So apareceu depois do #26**: com o PATH quebrado os VCX nunca alcancavam `utils\`. Consertar resolucao de nome **desenterra ausencias** - rodar a auditoria logo apos mexer em PATH/`SET PROCEDURE`.

Auditoria: `automation\VerificarFuncoesLegadoVCX.ps1` (le o fonte no `.VCT`; ignora linha comentada, varre so os VCX que o projeto carrega). **Sem auto-fix**: o defeito eh a AUSENCIA de um arquivo, nao texto no `.prg` gerado. Skill: secao **210**. Origem: Erro163_Aba1 (2026-09-18).

### 28. Sobreposicao HERDADA do SCX: comparar migrado x legado NUNCA pega
O SCX desloca o `Left` de um campo e **nao desloca o label vizinho junto**, que fica no `Left` da CLASSE. Os dois se cruzam na tela. Transcrever o SCX fielmente **reproduz o defeito**, e toda validacao migrado-x-legado aprova — os dois concordam.

No `FormCliente` o SCX move `getUFIBGE` de 471 para 508 e deixa o label `Say14` ("Contato :") no 518 da classe: ele entra **15px dentro** da caixa e a tela mostra `35ontato :`.

| controle | classe (framework.vcx) | SCX | faixa final |
|---|---|---|---|
| `Say_end9` "UF :" | 417 | — | 417..439 |
| `GetEstado` | **445** | **483** | 483..507 |
| `getUFIBGE` | **471** | **508** | 508..533 |
| `Say14` "Contato :" | 518 | so fonte/cor | **518**..578 |

**Conserto**: preferir os valores da CLASSE (coerentes entre si) a inventar posicao nova — e registrar o desvio em comentario. Aqui, voltar a 445/471 abre 22px antes do label e ainda fecha o vao de 44px entre "UF :" e o campo (espacamento que a classe `say` pressupoe, #23).

**Ao conferir**: somar `Left + Width` e comparar com o `Left` do vizinho de mesma linha (mesmo `Top`, ±6px) **dentro do MESMO container** — `Left`/`Top` sao relativos ao pai. Label sem `.Width` eh AutoSize: a faixa real eh a do **TEXTO**, nao a da caixa.

**Controle CONTIDO em outro fica inalcancavel**: `Get_Regiao` (596..676) cabe inteiro em `Get_Contato` (565..717) — o clique sempre cai no de cima. No legado esse campo estava **aposentado** (linhas de `Visible`/obrigatoriedade COMENTADAS `*!*` no VCX) e ficou soterrado em vez de removido. Esconder torna isso explicito.

**NAO existe detector automatico** e a tentativa foi medida e descartada: varrer pares que se cruzam acusou **7.776 pares em 296 forms** (5.466 so de "contido"), quase tudo falso positivo, porque a mesma VARIAVEL de pai (`loc_oCnt`, `loc_oPg1`) eh reatribuida a containers diferentes (mesmo risco da #11) e porque overlay de barra de botoes sobre faixa eh projeto, nao defeito. Sem auto-fix: escolher QUEM anda depende do resto do layout. Skill: secao **211**. Origem: Erro163_Aba1_2 (2026-09-18).

### 29. `Show()` de form MODAL dentro de TRY fecha a tela a cada erro de runtime
Form modal (`WindowType = 1`) faz o `Show()` **bloquear**: a tela inteira — cada `Valid`, cada `Click` — vive dentro da chamada. Com o `Show()` dentro de um `TRY`, **todo o uso da tela esta dentro do bloco**. E em VFP9 o **`TRY/CATCH` tem precedencia sobre `ON ERROR` em qualquer ponto da pilha**.

Medido (2026-09-18, 3 niveis de chamada entre o TRY e o erro):

```
erro solto                   -> ON ERROR .T.  (e a execucao CONTINUA)
erro dentro do TRY           -> ON ERROR .F.  | CATCH pegou .T.
erro 3 niveis abaixo do TRY  -> ON ERROR .F.  | CATCH pegou .T.
```

A cadeia: erro no `Valid` -> `ON ERROR` **ignorado** (por isso nenhum log aparece) -> salto para o `CATCH` -> TRY abandonado -> `loForm` eh `LOCAL`, a referencia cai -> form **destruido**. Sintoma: *"a tela fecha sozinha e o menu continua"* (o `READ EVENTS` esta acima).

```foxpro
* CERTO - TRY cobre so a CRIACAO
loForm = .NULL.
TRY
    loForm = CREATEOBJECT("FormX")
CATCH TO loException
    MostrarErro(...)
    loForm = .NULL.
ENDTRY
IF VARTYPE(loForm) = "O"
    loForm.Show()          && FORA do TRY
ENDIF
```

**Diagnostico**: `Destroy` **sem** `QueryUnload` eh assinatura de **queda de referencia** (`Release()` passaria pelo `QueryUnload`); menu vivo descarta crash de processo. Rastrear com `STRTOFILE` (grava e fecha na hora, sobrevive a morte do processo) em `GotFocus`/`LostFocus` do campo + `QueryUnload`/`Destroy` do form — **`BINDEVENT` em `LostFocus`, nunca em `Valid`** (regra #3), e como `Valid` roda antes, chegar no `LostFocus` ja prova que ele passou.

**Alcance**: `menu.prg` tinha **317 de 320** `Abrir*` assim, porque o TEMPLATE do `OrquestradorMigracao.ps1` mandava "COPIAR EXATAMENTE" esse padrao. **Corrigido no template.** Sem pattern do CorretorAutomatico: WARNING em 317 de 320 sites eh arquitetura, nao lista de revisao.

**Nota**: `COMPILE` pode **nao reescrever** um `.fxp` existente — apagar o `.fxp` antes e conferir o timestamp depois, senao o teste roda codigo velho. Skill: secao **212**. Origem: Erro163_Aba1_2.

### 30. Controle FORA da area do pai eh RECORTADO - some sem erro e sem aparecer em screenshot
Irma da #28, com um agravante: la o controle fica **sobreposto** (feio, mas visivel); aqui fica **fora do container**, que o **recorta**. Nao desenha, nao da erro, nao entra em log e **nao aparece em screenshot nem em validacao de layout** - nenhuma ferramenta do pipeline olha para filho fora da area do pai.

Em form **WRAPPER de VCX** o migrador copia os overrides do SCX dos controles das **PAGINAS** e esquece os filhos **DIRETOS** do container, que ficam no `Left`/`Top` da CLASSE:

| botao (navegacao entre abas) | classe `clsconta` | SCX legado | `cnt_4c_Conta` |
|---|---|---|---|
| `cmdGCarac` | 891, 540 | **633, 397** | `Width = 768` |
| `cmdGFtec` | 924, 540 | **672, 397** | `Height = 450` |
| `cmdgpessoal` | 957, 539 | **711, 397** | |

`891 > 768` e `540 > 450`: os tres sumiram. O `pgframeDados` do `clsconta` **nao mostra tabs** - esses CommandGroup SAO a navegacao. Sem eles, o usuario entrava na aba de endereco e **nao tinha como voltar para a aba 1**; sobrava so o F5, que ninguem adivinha. O `768x450` esta FIEL ao legado; faltavam os `Left`/`Top`.

**Ao migrar wrapper**: no dump do SCX, as linhas de **UM ponto so** (`^  nome.Left`) sao filhos DIRETOS do container - aplicar TODAS; as de varios pontos sao das paginas. Conferir `Left + Width <= pai.Width` e `Top + Height <= pai.Height`. Ignorar nome generico (`Command1`, `Option2`, `Text1`): sao membros internos de CommandGroup/OptionGroup, posicionados pelo VFP.

**NAO existe detector automatico** - tentado e medido duas vezes: varrendo todos os forms sao **66 achados em 53 forms, 100% falso positivo**, porque o **PILAR 3 manda RENOMEAR** os objetos no migrado (`btnReport` -> `cmg_4c_Botoes`, `cntSombra` -> `cnt_4c_Cabecalho`, `Pagina` -> `pgf_4c_Paginas`) e comparar pelo nome do legado nunca casa. A tecnica so funciona onde o nome eh **preservado**, que eh o form wrapper - e existe **UM** (`FormCliente`; `FormRPT` e `FormSigPdMp9` usam VCX sem container de layout). Script descartado, nao commitado. Skill: secao **213**. Origem: Erro163_Aba1_3 (2026-09-18).

### 31. Metodo do VCX legado REFAZ o layout a cada chamada - reaplicar no FUNIL, nunca so no Init
O `mLeDados` do `clsconta` nao carrega so dados: ele **reposiciona a tela** no fim, e faz isso **toda vez que roda**.

```foxpro
With This.pgframeDados
    .Tabs = (This.pcTpCadCli=='0')
    .Top  = Iif(.Tabs, 0, ThisForm.Height - This.PgframeDados.PageHeight)
```

Medido: `clsconta.pgframeDados.Height` = **802** (PageHeight 798 sem abas) contra `Form.Height` = 600 e `pcTpCadCli = '1'` -> `Top = -198`. A pagina 1 **sobe 198px** e o Container RECORTA o topo (irma da **#30**). Com `GetCEP.Top = 200` no SCX, a primeira linha visivel vira **CEP / Pais**: o usuario clica Incluir e cai no bloco de endereco/contato, **sem Codigo / Nome / CPF**. Sem erro, sem log, **sem aparecer em screenshot**.

**O SCX legado ja consertava - o migrador jogou fora.** O `sigcdcli.scx` tem uma `PROCEDURE` **homonima do metodo do VCX**, que existe so para desfazer o reposicionamento depois do `DoDefault`:

```foxpro
PROCEDURE mledados
Lparameters lcGrupo,lcIcli,lcTpCadCli,lcTpBloqCar,lcMudaCpfCgc
DoDefault(lcGrupo,lcIcli,lcTpCadCli,lcTpBloqCar,lcMudaCpfCgc)
thisform.cntConta.pgframeDados.Top = 0
ENDPROC
```

O migrado entra por `AddObject("cnt_4c_Conta", "clsconta")` e **nao tem subclasse onde por o override**, entao copiou o `Top = 0` para o `InicializarForm` - e o `mLeDados` roda de novo em **TODO Incluir/Alterar/Visualizar**. O reset tem de ficar no **FUNIL** de chamadas (`ChamarMLeDadosSeguro`) e tambem nos **CATCH que engolem a excecao**: o reposicionamento fica perto do FIM do metodo e pode ja ter rodado quando o erro estourou. Ao migrar wrapper, varrer o dump do SCX atras de `PROCEDURE` com nome de metodo do VCX (`mledados`, `mgravadados`, `mmontagrade`) - o que vem depois do `DoDefault` eh conserto, nao detalhe.

**`ActivePage` eh o `PageOrder`, NAO a ordem de declaracao**: no `clsconta`, `pgframeDados1` (Cadastro) tem `PageOrder=1`, `pgframeDados2` (Pessoal) tem **3** e `pgframeDados7` (Complemento) tem **2**. `ActivePage = 2` caia em Complemento; pior, o `cmdPessoal.Click` do VCX eh um toggle que so age em 1 ou 3, entao virava **no-op** e o F5 ficava morto. Quando o legado navega chamando `Click` de um botao (`KeyPress` do SCX chama `cmdGPessoal.cmdPessoal.Click()` e **mais nada**), TRANSCREVER - nao pre-setar `ActivePage` antes de delegar.

**Membro interno de CommandGroup com NOME PROPRIO eh a excecao da #30**: ignorar `Command1`/`Option2`/`Text1` continua certo, mas `cmdGCarac.cmdCarac.Top/Left/Height/Width/Picture` eh obrigatorio - o grupo eh `AutoSize = .T.` e a geometria do botao INTERNO **define a altura do grupo**. Medido: inner 32x32 (classe) -> grupo 42; inner 40x40 (SCX) -> grupo **50**, e so com 50 o `.Top = (Height - .Height - 4)` do `mLeDados` cai em 396, o mesmo **397** que o SCX declara no grupo. Aplicar o interno **antes** de posicionar o grupo.

**Para ler as propriedades REAIS de uma classe de VCX** (o `.VCT` eh p-code, `grep` devolve lixo): abrir a `.vcx` como **DBF** no VFP9 e ler a coluna `Properties` (`USE Framework\classresp.vcx` + `SCAN` por `ObjName`/`Class`).

**Sem auto-fix** - o defeito mora em p-code que o corretor nao le, e o universo eh UM form wrapper. Skill: secoes **214**, **215**, **216**. Origem: Erro165 (2026-09-22).

### 32. Form wrapper de VCX: auditar as `ThisForm.<prop>` do p-code, separando as que o VCX cria sozinho
Ao ver `Property X is not found`, a tentacao eh declarar aquela property e seguir. A varredura certa eh enumerar TODAS e separar em duas familias.

Para a MAIORIA o VCX se vira sozinho, com o par guarda + `AddProperty`:

```foxpro
If Type('ThisForm.OldEmpresa') == 'U'
    ThisForm.AddProperty('OldEmpresa', ...)
EndIf
```

Essas **nunca** dao erro e nao precisam ser declaradas. As que aparecem **CRUAS**, sem esse par, sao exatamente as que estouram. No `clsconta` sao **18** properties customizadas: **17 auto-criadas** e **UMA** nao - `AlterouLgpd`, que fazia gravar uma ALTERACAO estourar `Erro 1734: Property ALTEROULGPD is not found` em `FORMCLIENTE.CNT_4C_CONTA.MGRAVADADOS`. A varredura nao so acha a que falta: **prova que nao ha outra na fila**.

**Como varrer**: o `.VCT` eh p-code e grep no arquivo inteiro mistura TODAS as classes dele (140+ nomes, com lixo de bytes printaveis). Abrir a `.vcx` como **DBF** no VFP9 e dumpar a coluna `Methods` SO dos registros cujo `Parent`+`ObjName` contem o nome da classe (tecnica da regra #31); extrair `ThisForm.<x>`, descontar as nativas de Form (`Name`, `LockScreen`, `Height`, `BackColor`, `DataSessionId`, `Refresh`, `AddProperty`) e cruzar com as properties **e metodos** do `.prg` migrado - metodo conta, `ThisForm.checaibge` eh chamada de metodo.

**Tres armadilhas ao redor**:
1. **Property de OBJETO que o migrado nao tem** (`ThisForm.Pagina`, o PageFrame do `frmcadastro`) so eh segura se TODO uso estiver sob `If Type('...')=='O'` - conferir os sites, nao presumir.
2. **O bloco recem-habilitado usa cursores.** Declarar faz o `IF` finalmente entrar; o que esta dentro dele precisa existir (`crSigCdLgp` vem do `mIniConta`). Sem conferir, troca-se um erro por outro.
3. **Declarar NAO basta quando o ciclo de vida difere.** O legado eh modal e vive UM registro; o migrado nao fecha entre um e outro. Sem RESET no funil de chamadas (regra #31), o primeiro cliente em que alguem tocar no consentimento deixa `AlterouLgpd` ligado para sempre e todo ALTERAR seguinte grava **historico de LGPD falso** - exatamente o que a tabela existe para nao ter.

Auditoria: `automation\VerificarPropsThisFormVCX.ps1` (exit 1 se houver pendencia; property so tocada apos `Type(...)` sai como WARNING, nao como falha). **Sem auto-fix**: o defeito eh uma declaracao AUSENTE, e so o p-code do VCX diz qual. Skill: secao **218**. Origem: Erro166 (2026-09-22).

### 33. Propriedade que a CLASSE nao tem: compila limpo e a TELA NAO ABRE
Atribuir `.Prop` a um controle cuja classe base nao tem `Prop` **nao eh erro de compilacao**. Estoura no `Init`, dentro do TRY do form, e o usuario ve *"Erro ao inicializar FormX: Linha N - Property FORECOLOR is not found"* — clicou no menu e nada abriu.

O erro mais frequente eh **cor em CONTAINER DE GRUPO**. Medido no VFP9 (2026-09-23):

| classe | ForeColor | BackColor | onde a cor mora de verdade |
|---|---|---|---|
| **OptionGroup** / **CommandGroup** | **NAO** | SIM | nos MEMBROS: `Buttons(N).ForeColor` |
| **PageFrame** | **NAO** | **NAO** (nem `BackStyle`) | na `Page`, que tem as duas |
| **ListBox** | **NAO** | **NAO** | `ItemForeColor` / `ItemBackColor` |
| **Shape** | **NAO** | SIM | `BorderColor` / `FillColor` |
| Container, Label, CommandButton, OptionButton, CheckBox, TextBox, Grid, Column, Header, Page | SIM | SIM | |

E **o legado ja faz certo**: o SCX declara `Option1.ForeColor = 255,0,0` / `Option2.ForeColor = ...`, nos botoes. O migrador eh que iça a propriedade para o nivel do grupo. Transcrever o dump resolve — e a mesma varredura costuma revelar que o migrado **perdeu** o `ForeColor = 90,90,90` dos OUTROS botoes, que saem pretos.

Duas familias vizinhas, mesmo sintoma:

| familia | exemplo | conserto |
|---|---|---|
| **propriedade so do Form Designer** | `ZOrderSet` (o SCX grava o indice de z-order) | REMOVER — o equivalente em runtime eh o METODO `ZOrder()`, que o legado nao chama |
| **propriedade de outra linguagem** | `ShapeType` (eh do VB; no VFP eh `Curvature`) | REMOVER — o default ja eh o retangulo pretendido |

**`WITH` aninhado sequestra o escopo e produz o MESMO erro.** No `Formsigprenv`, `WITH THIS.this_oBusinessObject` + `WITH THIS.cnt_4c__Impressora` dentro fez `.this_nOpcaoImp` (property do BO) resolver contra um `Container` puro. Qualificar explicitamente (`THIS.cnt_4c__Impressora.obj_X.Value`) em vez de aninhar. No mesmo bloco, `.Visible = .T.` sobrando dentro do `WITH` do BO tambem estourava — BO nao tem `Visible`.

**NUNCA chutar a lista de propriedades** — perguntar ao VFP. `automation\DumpPropriedadesBaseClasses.prg` dumpa via `AMEMBERS()` a lista REAL de cada classe base para `automation\propriedades_baseclasses.txt`; `automation\VerificarPropriedadesInexistentes.ps1` audita o projeto contra ela (sem a tabela ele AVISA e sai com 0, nao inventa defeito). Nome de objeto reaproveitado para classes diferentes vira `<<AMBIGUO>>` e nao eh checado (mesmo risco de colisao da regra #11).

WARNING: CorretorAutomatico **#206**. Origem: Erro170 (2026-09-23, `Formgpr` linha 1066; a auditoria achou mais **20 sites em 6 outros forms** — FormDup, FormPzo, FormSigPdAco, FormSIGPRIMP, FormSigPrDsc, FormSigPrGlx, Formsigprenv — todos confirmados medindo no VFP9).

### 34. `Controls` eh indexado por NUMERO - com o NOME a tela nao abre
`Controls` eh **array**, nao colecao por chave. Passar o nome do controle **compila limpo** e estoura em RUNTIME com mensagem diferente conforme o contexto. Medido no VFP9 (2026-09-23):

```
Controls(1)                        -> OK
Controls("lbl_4c_Teste")           -> Invalid subscript reference.
WITH Controls("lbl_4c_Teste")      -> CONTROLS is not an object.     <- Erro171
PEMSTATUS(pg, "lbl_4c_Teste", 5)   -> .T.     <<< o guard NAO protege
EVALUATE("pg." + nome)             -> OK
STORE valor TO ("pg." + nome + ".Prop") -> OK
WITH EVALUATE("pg." + nome)        -> OK
```

O `PEMSTATUS` que costuma cercar esses blocos so verifica existencia pelo nome: devolve `.T.`, o `IF` entra e a linha seguinte quebra — mesma armadilha da regra **#3**.

Alcancar membro por NOME eh o que a regra **#15** ja normatiza: `EVALUATE` para LEITURA, `STORE ... TO (expr)` para ATRIBUICAO.

```foxpro
* ERRADO                                   * CERTO
WITH par_oPage.Controls(par_cNome)         WITH EVALUATE("par_oPage." + par_cNome)
obj.Controls(par_cNome).Value = x          STORE x TO ("obj." + par_cNome + ".Value")
y = obj.Controls(par_cNome).Value          y = EVALUATE("obj." + par_cNome + ".Value")
```

**Se o que se quer eh mesmo o INDICE**, o padrao certo eh um helper nome->indice varrendo `ControlCount` (o `Formccr` tem `ObterIndiceControle`, que devolve `loc_nI`). `Controls(N)` numerico eh o uso correto e majoritario: 402 sites no projeto contra 30 quebrados, todos num form so.

Auto-fix: CorretorAutomatico **#207** (muta `WITH` e atribuicao de linha inteira; leitura embutida em expressao vira WARNING). Origem: Erro171 (2026-09-23, `Formgpd`).

**Dois defeitos vizinhos apareceram na MESMA tela, cada um so visivel depois de consertar o anterior** — `Init` de form grande falha em cadeia, e "a tela abriu" so se prova instanciando:
1. `.Column3.Check1.<prop>` sem `AddObject` -> *Unknown member CHECK1* (regra **#18**: a Column nasce so com `Header1`/`Text1`).
2. `ConfigurarPgpgProdutos()` chamado e **nunca gerado** -> *Property CONFIGURARPGPGPRODUTOS is not found*; eram **71 controles** de uma aba inteira que a migracao perdeu. Auditar `THIS.<membro>` contra o proprio form **e a heranca de FormBase/BusinessBase/GridBase** antes de concluir.

**Ao reconectar uma aba perdida, conferir o TIPO da property no BO**: no `gpdBO`, 5 colunas `numeric(1,0)` MULTI-VALOR (`bpesos` 3 opcoes, `dsccompras` 3, `mncompos` 5, `tpcalcps` 6, `montadescs` 7) tinham virado LOGICO com `(col = 1)` — valores 2..7 liam `.F.` e regravavam 0. Ligar o controle novo a isso institucionaliza perda silenciosa: converter para numerico ANTES de mapear.

### 35. A pagina LISTA tem regra propria - e ela mora no `AddCursor`/`pColuna` do `Init` legado
Tres defeitos da mesma origem: o migrador olha o SCX desenhado e ignora o `Init`, que eh onde o legado define o que a Lista consulta e como a grade fica.

**(a) O filtro eh aplicado SEMPRE, inclusive VAZIO.** O legado liga a grade a uma query ja filtrada:

```foxpro
pcMercs  = []                                       && Init: vazio
lcQryGru = [Select * From SigCdGrp Where Mercs = ?m.pcMercs ]
.AddCursor('SigCdGrp','cgrus','CrSigCdGrp','', ThisForm.Pagina.Lista.Grade, lcQryGru)
```

Com `pcMercs` vazio a consulta **nao casa nada** e a Lista abre VAZIA — de proposito, esperando o usuario escolher. O migrado fazia `IF !EMPTY(filtro)` e caia em `Buscar("")`, que traz a TABELA INTEIRA. Transcrever o `Where` do `AddCursor`, com o mesmo `PADR(...,3)`.

**(b) A grade espelha o `pColuna`, nao o header do SCX.** Os headers desenhados no SCX sao sobrescritos em runtime:

```foxpro
.pfSqlTabela(1).pColuna('cgrus','','','Codigo',60,.T.)
.pfSqlTabela(1).pColuna('dgrus','','','Descricao',250,.T.)
.pfSqlTabela(1).pColuna('mercs','','','Grande Grupo',155,.T.)
.pfSqlTabela(1).pColuna('Unificas','','','Uni',32,.T.)
```

No `Formgpd` o SCX tinha 3 colunas com "Descricao do Grupo"; o `pColuna` tem **4**, com "Descricao" e a coluna `Unificas`/"Uni" — que o migrado perdeu, junto com a coluna no SELECT do BO.

**(c) `Column.Width` vai por ULTIMO.** Mexer em `RecordSource`/`ControlSource` **e na fonte do Grid** faz o VFP recalcular as larguras para o default 90. Medido: atribuidas antes do `FormatarGridLista`, todas voltavam a 90; depois dele, ficam. Irma da regra ja conhecida sobre `RecordSource` resetar `Column.Width`.

**Campo de filtro tem os DOIS eventos do legado.** O `Get_gde` do `Formgpd` tem `Valid` (se o codigo nao existe, abre o picker; ESC limpa) **e** `LostFocus` (recarrega a grade ao SAIR do campo, nao so no Enter). O migrado tinha so `KeyPress` com Enter — digitar e sair nao fazia nada. Como `BINDEVENT` em `"Valid"` nao dispara de forma confiavel em TextBox, as duas coisas moram no handler de `LostFocus`.

### 36. `FormBuscaAuxiliar`: o 1o argumento eh o HANDLE, e errar isso abre picker VAZIO
```foxpro
Init(par_nConn, par_cTabela, par_cCursor, par_cCampo, par_cValor,
     par_cTitulo, par_lBuscaExata, par_lMostraGrid, par_cFiltro)
```

O `Init` faz `SQLEXEC(par_nConn, loc_cSQL, par_cCursor)`: o 1o argumento vai **direto** para o `SQLEXEC`. Passar a tabela (ou um cursor, ou um `SELECT` inteiro) ali desloca TODOS os argumentos — `par_cTabela` recebe o nome da COLUNA, `par_cCursor` recebe o titulo — e a consulta nunca acontece.

**Nao estoura**: o `Init` tem `IF VARTYPE(par_cTabela) != "C" / RETURN .T.`, e com string em tudo ele segue adiante. O usuario clica no lookup e ve um picker **vazio**.

```foxpro
* ERRADO                                     * CERTO
CREATEOBJECT("FormBuscaAuxiliar", ;          CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
    "SigCdGpr", "codigos", "descs", ...)         "SigCdGpr", "cursor_4c_BuscaGde", "Codigos", ;
                                                 ALLTRIM(<valor atual>), "Grande Grupo")
```

Auditoria: `automation\VerificarFormBuscaAuxiliar.ps1`. WARNING: CorretorAutomatico **#208** (sem auto-fix — tabela/cursor/campo corretos vem do dump do legado, e parte dos sites quer reusar um cursor JA populado). Sweep 2026-09-23: **55 sites em 16 forms**.

**Ao escrever a auditoria, tratar CONTINUACAO DE LINHA**: a forma dominante eh `CREATEOBJECT("FormBuscaAuxiliar", ;` com o 1o argumento na linha SEGUINTE. Sem juntar as continuacoes, o script le argumento vazio e acusa TUDO — a 1a versao desta auditoria deu **95 achados, ~86 falsos positivos**. E tirar o `)` final, senao `gnConnHandle)` nao casa com `^gnConnHandle$`.

### 37. `FormBuscaAuxiliar` tem CONTRATO: `this_lAchouRegistro` antes do `Show()`
O `Init` ja tenta o **match exato** e, achando **1** registro, resolve o valor sozinho:

```foxpro
IF loc_nResultado > 0 AND RECCOUNT(par_cCursor) = 1
    THIS.this_lAchouRegistro = .T.
    THIS.this_lSelecionou    = .T.
    RETURN .T.
```

Dai o padrao canonico do projeto (137 arquivos), que tem de ser seguido inteiro:

```foxpro
IF VARTYPE(loc_oBusca) = "O"
    IF !loc_oBusca.this_lAchouRegistro          && 1) Show SO se nao resolveu
        loc_oBusca.mAddColuna(...)
        loc_oBusca.Show()
    ENDIF
    IF loc_oBusca.this_lSelecionou AND USED("<cursor>")   && 2) atribui SO sob guarda
        SELECT <cursor>
        <controle>.Value = ALLTRIM(<cursor>.<col>)
    ENDIF
    loc_oBusca.Release()
ENDIF
```

**Os dois erros andam juntos e sao invisiveis no codigo:**

| erro | sintoma |
|---|---|
| `Show()` sem a guarda | com valor JA valido, o dialogo abre por cima da tela preenchida e o usuario precisa dispensar |
| atribuir o valor FORA da guarda `this_lSelecionou` (tipico: `<controle>.Value = loc_cCodigo` no FIM do metodo) | nada escolhido -> `loc_cCodigo` vazio -> **o campo eh ZERADO** e o que dependia dele (filtro/grade) esvazia |

**Nao duplicar a checagem de existencia** com um `SQLEXEC` proprio antes de chamar o picker: o `Init` ja faz o match exato, e a segunda consulta so cria um caminho para divergir.

**Abrir form MODAL de dentro de `LostFocus` pede guarda de reentrancia.** O `Show()` bloqueia, o foco sai e volta, e o proprio `LostFocus` pode disparar de novo — empilhando um segundo picker. Property booleana no form, setada na entrada e limpa DEPOIS do `ENDTRY` (para valer tambem quando o CATCH dispara).

**Diagnostico barato**: num teste headless, `Show()` de form modal **trava** a execucao. Se o script termina dentro do timeout, o picker nao abriu — eh prova de que a guarda pegou.

**Sem auto-fix e sem auditoria** — medido e descartado: `Show()` sem guarda aparece em **530 sites de 176 arquivos** (o padrao MAJORITARIO), e com match exato ele abre com 1 linha, o que eh incomodo e nao quebrado; um detector disso seria WARNING massivo. A atribuicao fora da guarda da 334 contra 2407 dentro, com heuristica grosseira demais para separar falso positivo. O que torna o caso um defeito de verdade eh o **legado**: o `Valid` do `Get_gde` so abre o picker `If Not Seek(This.Value, 'crSigCdGpr', 'Codigos')`. Conferir contra o dump, nao contra a contagem.

Origem: Erro173 (2026-09-23, `Formgpd`) — regressao introduzida ao consertar o Erro172.

### 38. `.Self` NAO existe em VFP9 - dentro de `WITH`, repetir a expressao
`Self` eh de Delphi/Object Pascal. Em VFP9 o objeto **nao tem** essa propriedade, e dentro de um bloco `WITH` nao ha como referenciar o proprio objeto com ponto. Medido no VFP9 (2026-09-23):

```
WITH obj / PEMSTATUS(.Self, "x", 5)   -> ERRO "Property SELF is not found."
PEMSTATUS(obj, "Self", 5)             -> .F.   (objeto nao tem Self)
PEMSTATUS(<expr do WITH>, "x", 5)     -> OK
PEMSTATUS(<variavel>, "x", 5)         -> OK
```

```foxpro
* ERRADO                                     * CERTO
WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes   WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
    IF PEMSTATUS(.Self, "cmd_4c_Incluir", 5)       IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes, "cmd_4c_Incluir", 5)
```

**COMPILA LIMPO e so estoura em RUNTIME.** E quando o metodo nao tem TRY/CATCH, o usuario ve o **`Program Error` CRU do VFP**, nao o `MostrarErro` do form — foi assim no Erro174, ao clicar Incluir (`BtnIncluirClick` -> `AjustarBotoesPorModo`). Diante de um Program Error cru em vez do dialogo do projeto, procurar o metodo SEM TRY/CATCH no caminho daquele botao.

Auto-fix: CorretorAutomatico **#209**. Este eh AUTO-FIX de verdade, nao WARNING: a expressao certa eh exatamente a do `WITH` que abre o bloco, esta na mesma regiao do arquivo e nao depende do dump do legado nem de julgamento. Nao muta so quando nao da para resolver com certeza — `.Self` fora de qualquer `WITH`, ou expressao de `WITH` com macro (`&`/`$`). Com `WITH` aninhado vale o **mais interno**.

Sweep 2026-09-23: **83 sites em 4 forms** (`Formgpd` 6, `FormPAT` 24, `FormPEN` 18, `FormROM` 35). Origem: Erro174.

### 39. Pagina preenchida por DOIS metodos: se um esquecer o +29, a aba fica com texto sobre texto
Quando `ConfigurarAba<X>` e `ConfigurarPgpg<X>` preenchem a MESMA `pgf_4c_Divisoes.PageN`, basta um deles transcrever o `Top` CRU do SCX — sem a compensacao do `pgf_4c_Paginas.Top = -29` — para os controles dele caírem ~29px acima e pousarem em cima do que o outro ja desenhou. **Nao ha erro, nao ha log**: so a aba desformatada.

Medido no `Formgpd` (Erro175), controle a controle contra o `layout.json`:

| metodo | controles | com +29 | **sem +29** |
|---|---|---|---|
| `ConfigurarAbaConfiguracao` | 32 | 14 | 1 |
| **`ConfigurarPgpgConfig`** | 83 | 14 | **67** |
| `ConfigurarPgpgEstoque` | 46 | 46 | 0 |

**Como diagnosticar** (o que funcionou): escopar a UM metodo do `.prg` e UMA pagina do SCX — a correspondencia se descobre LENDO o codigo, na primeira linha do metodo (`loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.PageN`). Com esse escopo, parear por `Left` (±3) e comparar o `Top` com `legado.top` contra `legado.top + 29`. **Conferir que o pareamento saiu 1-para-1**: legado casado com dois migrados eh sinal de ruido, nao de defeito.

**NAO existe ferramenta para isso — tentado DUAS vezes e descartado**:
1. Auditoria varrendo o projeto contra o `layout.json` inteiro: **4220 achados em ~230 forms**, quase tudo falso positivo, inclusive 11 no proprio `Formgpd` JA CORRIGIDO (pareou o `lbl_4c_Titulo` da faixa do cabecalho com um `fwcombo1`).
2. Versao dirigida, exigindo metodo + pagina: acusou **49** no metodo recem-corrigido e **18** num que estava certo. O pareamento "legado mais proximo pelo Top cru" so vale enquanto os controles estao UNIFORMEMENTE deslocados; depois de corrigidos, o vizinho mais proximo passa a ser outro controle e o verificador se perde.

A raiz eh a mesma da regra **#30**: o PILAR 3 manda RENOMEAR os objetos, entao nao ha como casar migrado com legado por nome, e casar por geometria sempre encontra um sosia. Serve para diagnosticar um caso conhecido, **nao** para validar em massa nem para confirmar o conserto — o conserto se confere instanciando e olhando a tela.

**Defeitos vizinhos, da mesma origem** (migrador lendo o controle errado no dump):
- `Tptribs` com o `Top` do `Get_CodServs` (409) em vez do `Get_TpTrib` (385): as duas linhas viraram uma so ("SerTipo Paba ICMS").
- `Obrigfiscs` em `Left=440` quando o legado tem `Left=176` — foi parar do outro lado da tela, sobre outro bloco.
- **Label DUPLICADO**: o `ConfigurarAba*` inventou `lbl_4c_Obrigfiscs` ("Obrig. Fiscal :") para uma linha cujo label o `ConfigurarPgpg*` ja criava a partir do `Label2` do legado ("Class. Fiscal Obrigatoria :"). Ao achar dois labels na mesma linha, conferir qual existe no SCX — o legado tem UM.

Origem: Erro175 (2026-09-23, abas Estoque/Fiscal e Configuracao do `Formgpd`).

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
