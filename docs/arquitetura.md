# Arquitetura do Sistema

## Visão Geral

O sistema foi desenvolvido em Visual FoxPro 9 com arquitetura em camadas, aplicando princípios SOLID e padrões de design modernos. O objetivo é criar uma aplicação manutenível, escalável e testável.

## Princípios Fundamentais

### SOLID

#### Single Responsibility Principle (SRP)
- Cada classe tem uma única responsabilidade
- DataAccess: apenas acesso a dados
- BusinessBase: apenas regras de negócio
- FormBase: apenas interface do usuário

#### Open/Closed Principle (OCP)
- Classes abertas para extensão (herança) mas fechadas para modificação
- Subclasses estendem comportamento das classes base sem modificá-las

#### Liskov Substitution Principle (LSP)
- Subclasses podem substituir suas classes base
- Qualquer Form que herde de FormBase pode ser usado onde FormBase é esperado

#### Interface Segregation Principle (ISP)
- Métodos específicos e focados
- Cada método tem um propósito claro e definido

#### Dependency Inversion Principle (DIP)
- Formulários dependem de abstrações (Business Objects)
- Não há queries SQL diretas nos formulários

## Arquitetura em Camadas

```
┌─────────────────────────────────────────┐
│         CAMADA DE APRESENTAÇÃO          │
│              (FormBase)                 │
│  - Interface do usuário                 │
│  - Bindings de dados                    │
│  - Eventos de controles                 │
└────────────┬────────────────────────────┘
             │
             ▼
┌─────────────────────────────────────────┐
│         CAMADA DE NEGÓCIO               │
│           (BusinessBase)                │
│  - Validações                           │
│  - Regras de negócio                    │
│  - Orquestração de operações            │
└────────────┬────────────────────────────┘
             │
             ▼
┌─────────────────────────────────────────┐
│         CAMADA DE DADOS                 │
│           (DataAccess)                  │
│  - Queries SQL                          │
│  - CRUD operations                      │
│  - Gestão de transações                 │
└────────────┬────────────────────────────┘
             │
             ▼
┌─────────────────────────────────────────┐
│          SQL SERVER DATABASE            │
└─────────────────────────────────────────┘
```

## Estrutura de Diretórios

```
C:\4c\projeto\
│
├── app\
│   ├── start\               # Inicialização
│   │   ├── main.prg        # Programa principal
│   │   └── config.prg      # Configurações
│   │
│   ├── menu\               # Menu da aplicação
│   │   ├── menu.prg       # Menu programático
│   │   └── menu.mpr       # Menu compilado (opcional)
│   │
│   ├── forms\              # Formulários (telas)
│   │   └── [módulos]\     # Organizados por módulo
│   │
│   ├── classes\            # Classes base
│   │   ├── dataaccess.prg
│   │   ├── businessbase.prg
│   │   ├── formbase.prg
│   │   └── gridbase.prg
│   │
│   └── utils\              # Utilitários
│       ├── functions.prg
│       ├── messages.prg
│       └── validators.prg
│
├── icons\                  # Ícones da aplicação
│
└── docs\                   # Documentação
    ├── arquitetura.md
    ├── padroes_codigo.md
    └── guia_desenvolvimento.md
```

## Fluxo de Dados

### Leitura de Dados (Query)
1. **Form** solicita dados ao **Business Object**
2. **Business Object** chama método do **Data Access**
3. **Data Access** executa query SQL no banco
4. **Data Access** retorna cursor com dados
5. **Business Object** processa/valida dados (se necessário)
6. **Business Object** carrega suas propriedades com os dados
7. **Form** faz binding das propriedades do BO para os controles visuais

### Escrita de Dados (Insert/Update)
1. **Form** captura entrada do usuário
2. Ao salvar, **Form** transfere dados para **Business Object**
3. **Business Object** valida os dados
4. **Business Object** executa regras de negócio
5. **Business Object** chama método do **Data Access** para persistir
6. **Data Access** monta e executa SQL (INSERT ou UPDATE)
7. **Data Access** gerencia transação (BEGIN/COMMIT/ROLLBACK)
8. **Form** recebe confirmação e atualiza interface

## Classes Base

### DataAccess
**Responsabilidade:** Acesso a dados SQL Server

**Principais métodos:**
- `ExecutarQuery(pcSQL, pcCursorDestino)` - Executa query SQL
- `IniciarTransacao()` - Inicia transação
- `ConfirmarTransacao()` - Confirma transação
- `ReverterTransacao()` - Reverte transação
- `Buscar(pcFiltro, pcOrdenacao, pcCampos)` - Busca registros

### BusinessBase
**Responsabilidade:** Regras de negócio e validações

**Principais métodos:**
- `NovoRegistro()` - Prepara para inclusão
- `EditarRegistro()` - Prepara para edição
- `Salvar()` - Valida e salva dados
- `Excluir()` - Valida e exclui registro
- `ValidarDados()` - Validações específicas (implementar em subclasses)

### FormBase
**Responsabilidade:** Interface do usuário

**Principais métodos:**
- `Novo()` - Inicia inclusão
- `Salvar()` - Salva alterações
- `Excluir()` - Exclui registro
- `Cancelar()` - Cancela edição
- `FormParaBO()` - Transfere dados do form para BO (implementar em subclasses)
- `BOParaForm()` - Transfere dados do BO para form (implementar em subclasses)

### GridBase
**Responsabilidade:** Exibição de dados em grade

**Principais métodos:**
- `ConfigurarColunas(paConfig)` - Configura colunas
- `VincularCursor(pcCursor)` - Vincula a um cursor
- `ObterValorColunaAtual(pcColuna)` - Obtém valor da linha selecionada
- `AtualizarDados()` - Atualiza exibição

## Conexão com Banco de Dados

A conexão é estabelecida no `main.prg` e armazenada na variável pública `gnConnHandle`:

```foxpro
PUBLIC gnConnHandle
gnConnHandle = SQLSTRINGCONNECT(lcStringConexao)
```

Todas as operações SQL usam este handle:

```foxpro
SQLEXEC(gnConnHandle, "SELECT * FROM Clientes", "cursor_Clientes")
```

## Utilitários

### functions.prg
Funções auxiliares compartilhadas:
- Formatação (CPF, CNPJ, telefone, moeda, data)
- Conversão de tipos
- Escape SQL
- Geração de GUID

### messages.prg
Mensagens padronizadas:
- MsgErro, MsgAviso, MsgInfo, MsgSucesso
- MsgConfirma, MsgConfirmaExclusao
- MsgCampoObrigatorio, MsgCampoInvalido

### validators.prg
Validações comuns:
- ValidarCPF, ValidarCNPJ
- ValidarEmail, ValidarTelefone
- ValidarData, ValidarIntervaloData
- ValidarCampoObrigatorio

## Padrões de Nomenclatura

### Prefixos de Variáveis
- `loc_` - Local (lnContador, lcNome)
- `par_` - Parâmetro (pnId, pcNome)
- `this_` - This (THIS.cNome)
- `glo_` - Global/Public (gnConnHandle)

### Prefixos de Controles
- `txt_4c_` - TextBox
- `cmd_4c_` - CommandButton
- `grd_4c_` - Grid
- `cbo_4c_` - ComboBox
- `chk_4c_` - CheckBox
- `opt_4c_` - OptionButton
- `lbl_4c_` - Label

### Prefixos de Objetos
- `obj_4c_` - Objeto (objPagina)
- `pag_4c_` - Pagina (pagCliente)
- `frm_4c_` - Formulario (frmCliente)
- `bus_4c_` - Business (busCliente)
- `dat_4c_` - Data Access (datCliente)
- `cnt_4c_` - Container (cntCliente)
- `lst_4c_` - Lista (lstCliente)
- `grd_4c_` - Grid (grdCliente)
- `opt_4c_` - Option (optCliente)
- `chk_4c_` - Checkbox (chkCliente)
- `txt_4c_` - TextBox (txtCliente)
- `lbl_4c_` - Label (lblCliente)
- `cmd_4c_` - CommandButton (cmdCliente)
- `cbo_4c_` - ComboBox (cboCliente)
- `opt_4c_` - OptionButton (optCliente)
- `cursor_4c_` - Cursor (cursor_Cliente)
- `conn_4c_` - Connection (conn_Banco)

### Nomenclatura de Classes
- PascalCase para classes: `ClienteBO`, `FormCliente`
- Sufixo `BO` para Business Objects
- Sufixo `DA` para Data Access (quando necessário)

## Tratamento de Erros

Usar blocos TRY/CATCH em todas as operações críticas:

```foxpro
TRY
    * Código que pode gerar erro
CATCH TO loException
    * Tratamento do erro
    MESSAGEBOX("Erro: " + loException.Message)
ENDTRY
```

## Transações

Sempre usar transações para operações que envolvem múltiplas queries:

```foxpro
IF THIS.oDataAccess.IniciarTransacao()
    * Executa operações
    IF llSucesso
        THIS.oDataAccess.ConfirmarTransacao()
    ELSE
        THIS.oDataAccess.ReverterTransacao()
    ENDIF
ENDIF
```

## Boas Práticas

1. **Nunca** escrever SQL diretamente nos formulários
2. **Sempre** validar dados antes de salvar
3. **Sempre** usar transações para operações múltiplas
4. **Sempre** tratar erros com TRY/CATCH
5. **Nunca** expor handles ou objetos internos publicamente
6. **Sempre** liberar recursos (USE IN, RELEASE objects)
7. **Sempre** usar mensagens padronizadas (messages.prg)
8. **Sempre** usar validações comuns (validators.prg)
9. **Nunca** repetir código - criar funções reutilizáveis
10. **Sempre** comentar o "porquê", não o "o quê"
