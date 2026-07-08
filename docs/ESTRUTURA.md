# Estrutura Completa do Projeto

## Visão Geral

```
C:\4c\projeto\
│
├── README.md                      # Documentação principal
├── INICIO_RAPIDO.md              # Guia de início rápido
├── ESTRUTURA.md                  # Este arquivo
├── .gitignore                    # Arquivos ignorados pelo git
│
├── app\                          # Aplicação
│   │
│   ├── start\                    # Inicialização do sistema
│   │   ├── main.prg             # [PRINCIPAL] Programa de entrada
│   │   └── config.prg           # Configurações globais
│   │
│   ├── menu\                     # Menu da aplicação
│   │   ├── menu.prg             # Menu programático
│   │   └── README.md            # Como criar menu com Menu Designer
│   │
│   ├── forms\                    # Formulários (telas)
│   │   └── [vazio]              # Você criará as telas aqui
│   │
│   ├── classes\                  # Classes base da arquitetura
│   │   ├── dataaccess.prg       # [BASE] Acesso a dados SQL
│   │   ├── businessbase.prg     # [BASE] Regras de negócio
│   │   ├── formbase.prg         # [BASE] Formulários
│   │   └── gridbase.prg         # [BASE] Grids de dados
│   │
│   └── utils\                    # Utilitários compartilhados
│       ├── functions.prg        # Funções auxiliares
│       ├── messages.prg         # Mensagens padronizadas
│       └── validators.prg       # Validações comuns
│
├── icons\                        # Ícones da aplicação
│   └── [vazio]                  # Copie os ícones do sistema antigo
│
└── docs\                         # Documentação técnica
    ├── arquitetura.md           # Arquitetura e princípios SOLID
    ├── padroes_codigo.md        # Padrões e convenções de código
    ├── guia_desenvolvimento.md  # Como criar novas telas
    ├── exemplo_completo.md      # Exemplo funcional completo
    └── templates.md             # Templates para BO e Form
```

## Arquivos por Categoria

### 📘 Documentação

| Arquivo | Descrição | Quando Consultar |
|---------|-----------|------------------|
| `README.md` | Visão geral do projeto | Primeiro contato com o projeto |
| `INICIO_RAPIDO.md` | Checklist de configuração | Ao configurar pela primeira vez |
| `ESTRUTURA.md` | Estrutura de pastas (este arquivo) | Para navegar no projeto |
| `docs/arquitetura.md` | Arquitetura e SOLID | Para entender a estrutura |
| `docs/padroes_codigo.md` | Padrões de código | Ao escrever código |
| `docs/guia_desenvolvimento.md` | Criar novas telas | Ao desenvolver funcionalidades |
| `docs/exemplo_completo.md` | Exemplo funcional | Como referência prática |
| `docs/templates.md` | Templates de código | Ao criar novos arquivos |

### 🔧 Classes Base (Não Modificar)

| Arquivo | Classe | Propósito | Herdar De |
|---------|--------|-----------|-----------|
| `app/classes/dataaccess.prg` | `DataAccess` | Acesso a dados SQL Server | `Custom` |
| `app/classes/businessbase.prg` | `BusinessBase` | Regras de negócio | `Custom` |
| `app/classes/formbase.prg` | `FormBase` | Interface do usuário | `Form` |
| `app/classes/gridbase.prg` | `GridBase` | Exibição em grade | `Grid` |

### 🛠️ Utilitários (Usar Quando Necessário)

| Arquivo | Contém | Principais Funções |
|---------|--------|-------------------|
| `app/utils/functions.prg` | Funções auxiliares | `SomenteNumeros()`, `FormatarCPF()`, `FormatarCNPJ()`, `FormatarMoeda()`, `EscaparSQL()` |
| `app/utils/messages.prg` | Mensagens padronizadas | `MsgErro()`, `MsgAviso()`, `MsgSucesso()`, `MsgConfirma()`, `MsgCampoObrigatorio()` |
| `app/utils/validators.prg` | Validações comuns | `ValidarCPF()`, `ValidarCNPJ()`, `ValidarEmail()`, `ValidarTelefone()`, `ValidarData()` |

### ⚙️ Sistema (Configurar uma vez)

| Arquivo | Propósito | Ação Necessária |
|---------|-----------|-----------------|
| `app/start/main.prg` | Programa principal | ✅ Não modificar (já configurado) |
| `app/start/config.prg` | Configurações | ⚠️ **AJUSTAR string de conexão SQL** |
| `app/menu/menu.prg` | Menu principal | 🔧 Adicionar itens conforme criar telas |

### 📝 Seus Arquivos (Você vai criar)

| Local | O que criar | Exemplo |
|-------|-------------|---------|
| `app/forms/cadastros/` | Formulários de cadastro | `formcliente.prg` |
| `app/forms/movimentos/` | Formulários de movimentos | `formpedido.prg` |
| `app/forms/relatorios/` | Formulários de relatórios | `relatorioclientes.prg` |
| `app/classes/` | Business Objects | `clientebo.prg` |

## Fluxo de Trabalho

### 1. Configuração Inicial (Uma Vez)
```
1. Editar app/start/config.prg
   └─ Ajustar DB_SERVER, DB_NOME, DB_USUARIO, DB_SENHA

2. Copiar ícones para icons/

3. Executar app/start/main.prg no VFP
   └─ Testar conexão com banco
```

### 2. Para Cada Nova Tela
```
1. Receber:
   ├─ Código original (.txt)
   └─ Print da tela (.png)

2. Análise (docs/guia_desenvolvimento.md)
   ├─ Identificar tabelas
   ├─ Listar validações
   └─ Mapear funcionalidades

3. Desenvolvimento
   ├─ Criar Business Object (app/classes/[nome]bo.prg)
   │  └─ Usar docs/templates.md como base
   │
   └─ Criar Formulário (app/forms/[modulo]/form[nome].prg)
      └─ Usar docs/templates.md como base

4. Integração
   └─ Adicionar item no app/menu/menu.prg

5. Testes
   ├─ Inclusão
   ├─ Edição
   ├─ Exclusão
   └─ Validações
```

## Variáveis Globais do Sistema

Definidas em `main.prg` e disponíveis em toda aplicação:

| Variável | Tipo | Propósito |
|----------|------|-----------|
| `gnConnHandle` | Numeric | Handle da conexão SQL Server |
| `gcCaminhoBase` | Character | Caminho base da aplicação |
| `gcCaminhoClasses` | Character | Caminho das classes |
| `gcCaminhoUtils` | Character | Caminho dos utilitários |
| `gcCaminhoForms` | Character | Caminho dos formulários |
| `gcCaminhoIcones` | Character | Caminho dos ícones |

## Constantes do Sistema

Definidas em `config.prg`:

| Constante | Valor/Propósito |
|-----------|-----------------|
| `APP_NOME` | Nome da aplicação |
| `APP_VERSAO` | Versão atual |
| `DB_SERVER` | Servidor SQL Server |
| `DB_NOME` | Nome do banco de dados |
| `DB_TIMEOUT` | Timeout de conexão |
| `DB_QUERY_TIMEOUT` | Timeout de queries |

## Relacionamento Entre Classes

```
Formulário (FormBase)
    │
    │ instancia
    ├─────────────────────►  Business Object (BusinessBase)
    │                              │
    │                              │ instancia
    │                              └──────────►  Data Access (DataAccess)
    │                                                  │
    │                                                  │ usa
    │                                                  └──────────► SQL Server
    │
    │ exibe dados em
    └─────────────────────►  Grid (GridBase)
```

## Padrão de Nomenclatura de Arquivos

### Business Objects
```
[NomeEntidade]BO.prg

Exemplos:
- ClienteBO.prg
- ProdutoBO.prg
- PedidoBO.prg
```

### Formulários
```
Form[NomeEntidade].prg

Exemplos:
- FormCliente.prg
- FormProduto.prg
- FormPedido.prg
```

## Prioridade de Leitura da Documentação

1. **Primeiro:** `INICIO_RAPIDO.md` - Configuração inicial
2. **Segundo:** `docs/arquitetura.md` - Entender a estrutura
3. **Terceiro:** `docs/exemplo_completo.md` - Ver exemplo prático
4. **Quarto:** `docs/guia_desenvolvimento.md` - Processo de desenvolvimento
5. **Referência:** `docs/templates.md` - Ao criar novos arquivos
6. **Referência:** `docs/padroes_codigo.md` - Ao escrever código

## Comandos Úteis

### Iniciar o Sistema
```foxpro
CD C:\4c\projeto\app\start
DO main.prg
```

### Testar uma Tela Específica
```foxpro
CD C:\4c\projeto\app\forms
DO FORM formcliente
```

### Recarregar Configurações
```foxpro
DO app\start\config.prg
```

## Status das Pastas

| Pasta | Status | Ação Necessária |
|-------|--------|-----------------|
| `app/start/` | ✅ Pronta | Apenas ajustar config.prg |
| `app/menu/` | ✅ Pronta | Adicionar itens conforme necessário |
| `app/classes/` | ✅ Pronta | Criar seus BOs aqui |
| `app/utils/` | ✅ Pronta | Usar as funções existentes |
| `app/forms/` | 📝 Vazia | Você vai criar as telas aqui |
| `icons/` | 📝 Vazia | Copiar ícones do sistema antigo |
| `docs/` | ✅ Pronta | Consultar conforme necessário |

## Próximos Passos

1. ✅ Estrutura criada
2. ⬜ Ajustar `app/start/config.prg`
3. ⬜ Testar conexão com banco
4. ⬜ Copiar ícones
5. ⬜ Estudar exemplo completo
6. ⬜ Criar primeira tela

---

**Data de Criação:** 2025-11-24
**Status:** Estrutura base completa e funcional
**Pronto para:** Começar desenvolvimento das telas
