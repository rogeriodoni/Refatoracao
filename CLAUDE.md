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
