# Padrões de Código

## Convenções Gerais

### Idioma
- Nomes de variáveis, funções e comentários em **português**
- Código consistente com o domínio do negócio (facilita manutenção)

### Nomenclatura

#### Variáveis

**Prefixos obrigatórios:**
```foxpro
* Local
LOCAL lnContador        && Numérico local
LOCAL lcNome           && Character local
LOCAL ldData           && Date local
LOCAL llAtivo          && Logical local
LOCAL loObjeto         && Object local

* Parâmetro
PROCEDURE MinhaFuncao(pnId, pcNome, pdData)

* This (propriedade de classe)
THIS.cNome = "João"
THIS.nIdade = 30
THIS.lAtivo = .T.

* Global/Public
PUBLIC gnConnHandle
PUBLIC gcCaminhoBase
```

**Tipos:**
- `n` - Numeric
- `c` - Character
- `d` - Date
- `t` - DateTime
- `l` - Logical
- `o` - Object
- `a` - Array

#### Controles de Formulário

```foxpro
txtNome           && TextBox
txtCPF
cmdSalvar         && CommandButton
cmdCancelar
grdClientes       && Grid
cboEstado         && ComboBox
chkAtivo          && CheckBox
optMasculino      && OptionButton
lblNome           && Label
```

#### Classes

```foxpro
* PascalCase
DEFINE CLASS ClienteBO AS BusinessBase
DEFINE CLASS FormCliente AS FormBase
DEFINE CLASS ClienteDataAccess AS DataAccess

* Sufixos recomendados
ClienteBO         && Business Object
ProdutoBO
FormCliente       && Formulário
FormProduto
```

### Formatação

#### Indentação
- 4 espaços (ou 1 tab configurado para 4 espaços)
- Sempre indentar blocos internos

```foxpro
PROCEDURE Exemplo()
    LOCAL lnI

    FOR lnI = 1 TO 10
        IF lnI > 5
            ? "Maior que 5"
        ELSE
            ? "Menor ou igual a 5"
        ENDIF
    ENDFOR
ENDPROC
```

#### Linhas em Branco
- 1 linha em branco entre procedimentos/funções
- 1 linha em branco entre seções lógicas dentro de um procedimento

```foxpro
PROCEDURE Funcao1()
    * Código
ENDPROC

PROCEDURE Funcao2()
    * Inicialização
    LOCAL lnVar
    lnVar = 0

    * Processamento principal
    lnVar = lnVar + 1
ENDPROC
```

#### Quebra de Linha
- Quebrar linhas longas com ponto e vírgula (`;`)
- Alinhar continuações de forma legível

```foxpro
lcSQL = "SELECT id, nome, cpf, telefone, email " + ;
        "FROM Clientes " + ;
        "WHERE ativo = 1 " + ;
        "ORDER BY nome"

MESSAGEBOX("Esta é uma mensagem muito longa que " + ;
           "precisa ser quebrada em múltiplas linhas " + ;
           "para melhor legibilidade", ;
           48, ;
           "Título")
```

### Comentários

#### Cabeçalho de Arquivo
```foxpro
*==============================================================================
* NOME_ARQUIVO.PRG
* Descrição breve do propósito do arquivo
* Responsabilidade: o que este arquivo faz
*==============================================================================
```

#### Cabeçalho de Procedimento/Função
```foxpro
*------------------------------------------------------------------------------
* NomeFuncao - Descrição breve
* Parâmetros:
*   pnId: identificador numérico
*   pcNome: nome do cliente
* Retorno: .T. se sucesso, .F. se erro
*------------------------------------------------------------------------------
FUNCTION NomeFuncao(pnId, pcNome)
```

#### Comentários Inline
```foxpro
* Comentários explicam o PORQUÊ, não o QUÊ

* BOM: explica o motivo
* Multiplica por 1.1 porque o imposto estadual é 10%
lnValorFinal = lnValor * 1.1

* RUIM: apenas repete o código
* Multiplica lnValor por 1.1
lnValorFinal = lnValor * 1.1
```

## Estrutura de Código

### Ordem de Declaração em Classes

```foxpro
DEFINE CLASS MinhaClasse AS Custom

    *-- Propriedades públicas
    cNome = ""
    nIdade = 0

    *-- Propriedades protegidas (comentadas como tal)
    * PROTECTED
    cChaveInterna = ""

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init(pcNome)
        THIS.cNome = pcNome
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Métodos públicos
    *--------------------------------------------------------------------------
    PROCEDURE MetodoPublico()
        * Código
    ENDPROC

    *--------------------------------------------------------------------------
    * Métodos protegidos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MetodoProtegido()
        * Código
    ENDPROC

    *--------------------------------------------------------------------------
    * DESTROY - Destrutor
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        * Limpeza de recursos
    ENDPROC

ENDDEFINE
```

### Ordem de Declaração em Procedimentos

```foxpro
PROCEDURE NomeProcedimento(parametros)
    * 1. Declaração de variáveis locais
    LOCAL lnVar1, lcVar2, loObjeto

    * 2. Validação de parâmetros
    IF VARTYPE(parametro) != "N"
        RETURN .F.
    ENDIF

    * 3. Inicialização
    lnVar1 = 0
    loObjeto = CREATEOBJECT("MinhaClasse")

    * 4. Processamento principal
    TRY
        * Lógica principal aqui
    CATCH TO loException
        * Tratamento de erro
    ENDTRY

    * 5. Limpeza e retorno
    loObjeto = .NULL.
    RETURN .T.
ENDPROC
```

## Validações

### Validação de Parâmetros

```foxpro
FUNCTION ProcessarCliente(pnId, pcNome)
    * Valida tipo e valor dos parâmetros
    IF VARTYPE(pnId) != "N" OR pnId <= 0
        RETURN .F.
    ENDIF

    IF VARTYPE(pcNome) != "C" OR EMPTY(pcNome)
        RETURN .F.
    ENDIF

    * Continua processamento...
ENDFUNC
```

### Validação de Estado

```foxpro
PROCEDURE Salvar()
    * Valida estado antes de processar
    IF !THIS.lEmEdicao
        THIS.cMensagemErro = "Não está em modo de edição"
        RETURN .F.
    ENDIF

    * Continua processamento...
ENDPROC
```

## Tratamento de Erros

### Estrutura TRY/CATCH

```foxpro
TRY
    * Código que pode gerar erro
    lnResultado = SQLEXEC(gnConnHandle, lcSQL)

    IF lnResultado < 0
        * Trata erro SQL específico
        LOCAL ARRAY laErro[1]
        AERROR(laErro)
        THIS.cMensagemErro = laErro[2]
        RETURN .F.
    ENDIF

    RETURN .T.

CATCH TO loException
    * Trata exceção geral
    THIS.cMensagemErro = "Exceção: " + loException.Message
    RETURN .F.
ENDTRY
```

### Registro de Erros

```foxpro
PROTECTED PROCEDURE RegistrarErro(pnCodigo, pcMensagem)
    THIS.nUltimoErro = pnCodigo
    THIS.cMensagemErro = pcMensagem

    * Se for erro SQL, captura detalhes adicionais
    IF pnCodigo < 0
        LOCAL ARRAY laErro[1]
        IF AERROR(laErro) > 0
            THIS.cMensagemErro = THIS.cMensagemErro + CHR(13) + ;
                                 "Detalhes: " + laErro[2]
        ENDIF
    ENDIF
ENDPROC
```

## SQL Dinâmico

### Construção Segura de SQL

```foxpro
* NUNCA concatenar diretamente valores do usuário
* RUIM:
lcSQL = "SELECT * FROM Clientes WHERE nome = '" + lcNome + "'"

* BOM: usar função de escape
lcSQL = "SELECT * FROM Clientes WHERE nome = " + EscaparSQL(lcNome)

* Ou usar parâmetros
lcSQL = "SELECT * FROM Clientes WHERE nome = ?pcNome"
```

### Formatação de SQL Complexo

```foxpro
* SQL legível e manutenível
lcSQL = "SELECT " + ;
        "    c.id, " + ;
        "    c.nome, " + ;
        "    c.cpf, " + ;
        "    e.nome AS estado " + ;
        "FROM Clientes c " + ;
        "INNER JOIN Estados e ON e.id = c.estado_id " + ;
        "WHERE c.ativo = 1 " + ;
        "  AND c.data_cadastro >= " + EscaparSQL(DTOC(ldDataInicial)) + ;
        "ORDER BY c.nome"
```

## Boas Práticas Específicas

### Liberação de Recursos

```foxpro
* Sempre liberar objetos
loObjeto = CREATEOBJECT("MinhaClasse")
* ... usar objeto ...
loObjeto = .NULL.  && Libera memória

* Sempre fechar cursores
USE IN curClientes

* Sempre limpar WAIT WINDOW
WAIT CLEAR
```

### Uso de Cursores

```foxpro
* Verificar se cursor existe antes de usar
IF USED("curClientes")
    USE IN curClientes
ENDIF

* Criar cursor
SQLEXEC(gnConnHandle, lcSQL, "curClientes")

* Trabalhar com cursor
SELECT curClientes
GO TOP
SCAN
    * Processar registros
ENDSCAN

* Fechar cursor
USE IN curClientes
```

### Constantes vs Valores Mágicos

```foxpro
* RUIM: números mágicos
IF lnStatus = 1
    * ...
ENDIF

* BOM: usar constantes nomeadas
#DEFINE STATUS_ATIVO 1
#DEFINE STATUS_INATIVO 0

IF lnStatus = STATUS_ATIVO
    * ...
ENDIF
```

### Evitar Código Duplicado

```foxpro
* RUIM: repetição de código
PROCEDURE ProcessarCliente1()
    lcSQL = "UPDATE Clientes SET ultima_atualizacao = GETDATE() WHERE id = " + TRANSFORM(lnId)
    SQLEXEC(gnConnHandle, lcSQL)
ENDPROC

PROCEDURE ProcessarCliente2()
    lcSQL = "UPDATE Clientes SET ultima_atualizacao = GETDATE() WHERE id = " + TRANSFORM(lnId)
    SQLEXEC(gnConnHandle, lcSQL)
ENDPROC

* BOM: criar função reutilizável
PROCEDURE AtualizarTimestampCliente(pnId)
    LOCAL lcSQL
    lcSQL = "UPDATE Clientes SET ultima_atualizacao = GETDATE() WHERE id = " + TRANSFORM(pnId)
    RETURN SQLEXEC(gnConnHandle, lcSQL) > 0
ENDPROC
```

### Mensagens ao Usuário

```foxpro
* Usar funções padronizadas de messages.prg
MsgErro("Erro ao salvar registro")
MsgSucesso("Registro salvo com sucesso")
MsgConfirma("Confirma a exclusão?")

* Evitar MESSAGEBOX direto (exceto em casos muito específicos)
```

## Code Smells a Evitar

1. **God Class** - Classe que faz tudo
   - Dividir responsabilidades em classes menores

2. **Long Method** - Métodos muito longos
   - Quebrar em métodos menores com responsabilidades específicas

3. **Magic Numbers** - Números sem significado
   - Usar constantes nomeadas

4. **Duplicated Code** - Código repetido
   - Criar funções/métodos reutilizáveis

5. **Deep Nesting** - Muitos níveis de IF/FOR aninhados
   - Usar early returns e guard clauses

6. **Shotgun Surgery** - Mudança pequena afeta muitos arquivos
   - Centralizar comportamentos relacionados

## Checklist de Revisão de Código

- [ ] Nomenclatura segue os padrões?
- [ ] Variáveis têm prefixos corretos?
- [ ] Comentários explicam o "porquê"?
- [ ] Tratamento de erros implementado?
- [ ] Validações de parâmetros presentes?
- [ ] Recursos liberados corretamente?
- [ ] SQL usa escape de strings?
- [ ] Sem código duplicado?
- [ ] Sem números mágicos?
- [ ] Métodos com responsabilidade única?
- [ ] Indentação correta?
- [ ] Sem SQL direto em formulários?
