# SQL Server Guide

## Connection Configuration

### String de Conexao

Configurada em `config.prg` via #DEFINE:

```foxpro
#DEFINE DB_SERVER "192.168.15.101,1435"
#DEFINE DB_NOME "DB_MBAHIA"
#DEFINE DB_USUARIO "sa"
#DEFINE DB_SENHA "SqlServer2022!"
```

### Funcao de Conexao (main.prg)

```foxpro
PROCEDURE ConectarBancoDados()
    LOCAL lcStringConexao, lnHandle
    PUBLIC gnConnHandle

    lcStringConexao = "DRIVER={SQL Server};" + ;
                      "SERVER=" + DB_SERVER + ";" + ;
                      "DATABASE=" + DB_NOME + ";" + ;
                      "UID=" + DB_USUARIO + ";" + ;
                      "PWD=" + DB_SENHA + ";"

    lnHandle = SQLSTRINGCONNECT(lcStringConexao)

    IF lnHandle < 0
        LOCAL ARRAY laErro[1]
        AERROR(laErro)
        MESSAGEBOX("Erro: " + laErro[2], 16, "Erro SQL")
        RETURN .F.
    ENDIF

    gnConnHandle = lnHandle
    SQLSETPROP(gnConnHandle, "QueryTimeOut", 60)
    RETURN .T.
ENDPROC
```

### Variavel Global de Conexao

| Variavel | Tipo | Descricao |
|----------|------|-----------|
| `gnConnHandle` | Numeric | Handle da conexao SQL Server (usado em todo o sistema) |

**IMPORTANTE**: Sempre verificar `gnConnHandle > 0` antes de executar SQLEXEC.

## SQL Formatting Functions (CRITICAL)

### FormatarNumeroSQL - SEMPRE usar para valores numericos

```foxpro
* TRANSFORM() usa SET POINT (virgula no Brasil), SQL Server espera ponto
loc_cSQL = "UPDATE tabela SET campo = " + FormatarNumeroSQL(nValor, 4)
```

### FormatarDataSQL - SEMPRE usar para datas

```foxpro
* DTOC() usa SET DATE (DMY), SQL Server espera ISO (YYYY-MM-DD)
loc_cSQL = "UPDATE tabela SET campo = " + FormatarDataSQL(dData)
* Retorna: '2024-01-15' ou NULL se vazio
```

### EscaparSQL - SEMPRE usar para strings

```foxpro
* Escapa aspas simples e previne SQL injection
loc_cSQL = "SELECT * FROM tabela WHERE campo = " + EscaparSQL(cValor)
```

## Transacoes SQL

### Quando Usar Transacoes

Usar transacoes quando:
- Multiplos INSERTs/UPDATEs que devem ser atomicos
- Salvar dados principais + subtabelas
- Operacoes que podem falhar parcialmente

### Metodos do DataAccess

```foxpro
* Iniciar transacao
DataAccess.IniciarTransacao()
    -> SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

* Confirmar transacao
DataAccess.ConfirmarTransacao()
    -> SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")

* Reverter transacao
DataAccess.ReverterTransacao()
    -> SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
```

### Padrao de Uso em Business Objects

```foxpro
PROTECTED PROCEDURE Salvar(par_lNovo)
    LOCAL loc_lResultado, loc_oDataAccess

    loc_oDataAccess = CREATEOBJECT("DataAccess")
    loc_lResultado = .F.

    * Inicia transacao
    IF !loc_oDataAccess.IniciarTransacao()
        THIS.this_cMensagemErro = "Erro ao iniciar transacao"
        RETURN .F.
    ENDIF

    TRY
        * Salva dados principais
        IF par_lNovo
            loc_lResultado = THIS.Inserir()
        ELSE
            loc_lResultado = THIS.Atualizar()
        ENDIF

        * Salva subtabelas (se sucesso)
        IF loc_lResultado
            loc_lResultado = THIS.SalvarSubtabelas()
        ENDIF

        * Confirma ou reverte
        IF loc_lResultado
            loc_oDataAccess.ConfirmarTransacao()
        ELSE
            loc_oDataAccess.ReverterTransacao()
        ENDIF

    CATCH TO loEx
        loc_oDataAccess.ReverterTransacao()
        THIS.this_cMensagemErro = loEx.Message
        loc_lResultado = .F.
    ENDTRY

    RETURN loc_lResultado
ENDPROC
```

## Tratamento de Erros SQLEXEC

### Padrao Obrigatorio

Apos TODO `SQLEXEC`, verificar resultado e capturar erro:

```foxpro
LOCAL loc_cSQL, loc_nResultado
LOCAL ARRAY loc_aErro[1]

loc_cSQL = "INSERT INTO Tabela (...) VALUES (...)"
loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

IF loc_nResultado < 0
    * Captura mensagem de erro do SQL Server
    LOCAL loc_nErro, loc_cMsgErro
    loc_nErro = AERROR(loc_aErro)

    IF loc_nErro > 0
        loc_cMsgErro = loc_aErro[1, 2]
    ELSE
        loc_cMsgErro = "Erro desconhecido"
    ENDIF

    * Monta mensagem detalhada para debug
    LOCAL loc_cErroSQL
    loc_cErroSQL = "=== ERRO SQL ===" + CHR(13) + CHR(10)
    loc_cErroSQL = loc_cErroSQL + "Mensagem: " + loc_cMsgErro + CHR(13) + CHR(10)
    loc_cErroSQL = loc_cErroSQL + CHR(13) + CHR(10)
    loc_cErroSQL = loc_cErroSQL + "=== SQL EXECUTADO ===" + CHR(13) + CHR(10)
    loc_cErroSQL = loc_cErroSQL + loc_cSQL

    * Exibe com FormErro (tem botao Copiar)
    MostrarErro(loc_cErroSQL, "Erro ao Salvar")

    THIS.this_cMensagemErro = loc_cMsgErro
    RETURN .F.
ENDIF
```

### Array AERROR - Estrutura

| Indice | Conteudo |
|--------|----------|
| [1, 1] | Numero do erro |
| [1, 2] | Mensagem de erro (texto) |
| [1, 3] | Parametro adicional |
| [1, 4] | Numero do workaround |
| [1, 5] | Triggers (se aplicavel) |
| [1, 6] | Codigo nativo ODBC |
| [1, 7] | Origem do erro |

### Erros SQL Comuns

| Erro | Causa | Solucao |
|------|-------|---------|
| "converting varchar to numeric" | TRANSFORM() com SET POINT | Usar FormatarNumeroSQL() |
| "Cannot insert NULL" | Campo NOT NULL sem valor | Verificar schema.sql |
| "Violation of PRIMARY KEY" | Chave duplicada | Verificar antes de INSERT |
| "String or binary data truncated" | Valor maior que coluna | Verificar tamanho no schema |
| "Foreign key constraint" | FK invalida | Verificar registro pai existe |

## Tabelas com Muitos Campos NOT NULL

Algumas tabelas do sistema têm dezenas ou centenas de campos NOT NULL (ex: SigCdPro tem ~130). Ao criar o INSERT:

### Estratégia de INSERT Completo

1. **Consultar o schema** (`docs/schema.sql`) para listar TODOS os campos NOT NULL
2. **Separar em duas categorias**:
   - Campos usados no formulário (com valores reais das propriedades)
   - Campos não usados (com valores default: `''` para CHAR, `0` para NUMERIC, `0` para BIT)

3. **Estrutura do INSERT**:
```foxpro
loc_cSQL = "INSERT INTO Tabela (" + ;
    "campo1, campo2, campo3, ..., " + ;        && Campos usados
    "campoX, campoY, campoZ" + ;               && Campos NOT NULL nao usados
    ") VALUES ("

*-- Valores dos campos usados (com dados do formulario)
loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cCampo1) + ", "
loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCampo2, 2) + ", "

*-- Valores DEFAULT para campos NOT NULL nao usados
loc_cSQL = loc_cSQL + "'', "     && campo CHAR nao usado
loc_cSQL = loc_cSQL + "0, "      && campo NUMERIC nao usado
loc_cSQL = loc_cSQL + "0"        && campo BIT nao usado

loc_cSQL = loc_cSQL + ")"
```

### Tipos de Dados e Defaults

| Tipo SQL | Default | Exemplo |
|----------|---------|---------|
| CHAR(n), VARCHAR(n) | `''` | `loc_cSQL = loc_cSQL + "'', "` |
| NUMERIC(p,s), INT | `0` | `loc_cSQL = loc_cSQL + "0, "` |
| BIT | `0` | `loc_cSQL = loc_cSQL + "0, "` |
| DATETIME | `NULL` ou `GETDATE()` | Campos datetime geralmente permitem NULL |
| TEXT | `NULL` | Campos text geralmente permitem NULL |

### IMPORTANTE: UPDATE não precisa de todos os campos

O UPDATE só precisa atualizar os campos que foram modificados pelo usuário. Não é necessário incluir todos os campos NOT NULL - apenas os que estão sendo alterados.

## Validacao de Campos Obrigatorios

### Padrao no Business Object

Implementar metodo `Validar()` chamado ANTES de `Inserir()` ou `Atualizar()`:

```foxpro
PROTECTED PROCEDURE Validar()
    * Limpa mensagem anterior
    THIS.this_cMensagemErro = ""

    * Valida campos obrigatorios
    IF EMPTY(THIS.this_cCodigo)
        THIS.this_cMensagemErro = "C" + CHR(243) + "digo " + CHR(233) + " obrigat" + CHR(243) + "rio"
        RETURN .F.
    ENDIF

    IF EMPTY(THIS.this_cDescricao)
        THIS.this_cMensagemErro = "Descri" + CHR(231) + CHR(227) + "o " + CHR(233) + " obrigat" + CHR(243) + "ria"
        RETURN .F.
    ENDIF

    * Valida regras de negocio
    IF THIS.this_nValor < 0
        THIS.this_cMensagemErro = "Valor n" + CHR(227) + "o pode ser negativo"
        RETURN .F.
    ENDIF

    RETURN .T.
ENDPROC

* Chamar no metodo Salvar:
PROTECTED PROCEDURE Salvar(par_lNovo)
    * Valida ANTES de tentar salvar
    IF !THIS.Validar()
        RETURN .F.
    ENDIF

    * Prossegue com INSERT/UPDATE
    ...
ENDPROC
```

## Cursor Naming Convention

Use `cursor_4c_` prefix for all cursors:
- `cursor_4c_Dados` - Main data cursor
- `cursor_4c_Busca` - Search/lookup cursor
- `cursor_4c_Verifica` - Validation cursor
- `cursor_4c_Lista` - List cursor

**IMPORTANT**: Do NOT use `ListaRemota` or `CrListaRemota` - use `cursor_4c_Busca` instead.
