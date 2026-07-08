# Regras de Desenvolvimento - Visual FoxPro 9

## Guia Definitivo para Evitar Retrabalho

Este documento consolida todas as regras e padrões aprendidos durante o desenvolvimento. **Consulte ANTES de implementar qualquer funcionalidade.**

---

## Indice

1. [Formularios](#1-formularios)
2. [Botoes com Icones](#2-botoes-com-icones)
3. [Campos com Busca em Tabelas Relacionadas](#3-campos-com-busca-em-tabelas-relacionadas)
4. [Eventos e BINDEVENT](#4-eventos-e-bindevent)
5. [Grid e Colunas](#5-grid-e-colunas)
6. [TRY/CATCH](#6-trycatch)
7. [Auditoria](#7-auditoria)
8. [Documentacao e Boas Praticas](#8-documentacao-e-boas-praticas)
9. [Checklist de Implementacao](#9-checklist-de-implementacao)

---

## 1. Formulários

### 1.1 Propriedades Obrigatórias para Forms Modais

```foxpro
DEFINE CLASS MeuForm AS FormBase
    DataSession = 2        && Sessão de dados privada
    Height = 600
    Width = 1000
    ShowWindow = 1         && In Top-Level Form (NÃO usar 2)
    WindowType = 1         && Modal
    AutoCenter = .T.
```

| Propriedade | Valor | Descrição |
|-------------|-------|-----------|
| `ShowWindow` | `1` | Compatível com modal. **NUNCA use `2` para forms modais** |
| `WindowType` | `1` | Define como modal na classe |
| `DataSession` | `2` | Sessão de dados privada (recomendado) |

### 1.2 Como Abrir um Formulário

```foxpro
PROCEDURE AbrirMeuForm()
    LOCAL loForm

    TRY
        loForm = CREATEOBJECT("MeuForm")

        IF VARTYPE(loForm) = "O"
            loForm.Show()  && SEM parâmetro - WindowType já define modal
        ENDIF

    CATCH TO loException
        MESSAGEBOX("Erro: " + loException.Message, 16, "Erro")
    ENDTRY
ENDPROC
```

### 1.3 Fechar Formulário - NUNCA usar CLEAR EVENTS

```foxpro
* ❌ ERRADO - Fecha o sistema inteiro
PROCEDURE BtnFecharClick()
    THIS.Release()
    CLEAR EVENTS    && NUNCA faça isso!
ENDPROC

* ✅ CORRETO
PROCEDURE BtnFecharClick()
    THIS.Release()
ENDPROC
```

### 1.4 Init() Deve Sempre Criar o Objeto

O `Init()` de formulários auxiliares (como busca) deve **sempre retornar `.T.`** para garantir que o objeto seja criado:

```foxpro
* ❌ ERRADO - Objeto não é criado se retornar .F.
PROCEDURE Init()
    IF condicao
        RETURN .F.    && CREATEOBJECT retorna .NULL.!
    ENDIF
    RETURN .T.
ENDPROC

* ✅ CORRETO - Usar propriedades para controle
PROCEDURE Init()
    IF condicao
        THIS.plEncontrou = .T.
    ELSE
        THIS.plEncontrou = .F.
    ENDIF
    RETURN .T.    && SEMPRE retorna .T.
ENDPROC
```

---

## 2. Botões com Ícones

### 2.1 PicturePosition = 13 (Ícone Acima, Texto Abaixo)

```foxpro
WITH .cmdIncluir
    .Caption = "Incluir"
    .Width = 75
    .Height = 80
    .Picture = "C:\4c\vbmp\Add.ico"
    .PicturePosition = 13    && IMPORTANTE: 13 = ícone acima, texto abaixo
ENDWITH
```

| PicturePosition | Resultado |
|-----------------|-----------|
| `0` | Esquerda do texto |
| `1` | Direita do texto |
| `13` | **Acima do texto (usar este!)** |
| `14` | Abaixo do texto |

### 2.2 Dimensões Padrão de Botões com Ícone

```foxpro
.Width = 75
.Height = 80
.FontName = "Tahoma"
.FontSize = 8
```

### 2.3 Ícones Disponíveis (case-sensitive!)

| Função | Arquivo |
|--------|---------|
| Incluir | `Add.ico` |
| Visualizar | `Book.ico` |
| Alterar | `altera.ico` |
| Excluir | `Delete.ico` |
| Buscar | `Search.ico` |
| Encerrar | `Shutdown.ico` |
| Confirmar | `button_ok.ico` |
| Cancelar | `button_cancel.ico` |

---

## 3. Campos com Busca em Tabelas Relacionadas

### 3.1 Padrão: Classe TextBox Customizada

Para campos que buscam em tabelas auxiliares (ex: Tanque, Grupo, etc.), **criar uma classe TextBox específica** com o `Valid()` embutido:

```foxpro
*------------------------------------------------------------------------------
* TextBoxBuscaTanque - TextBox com busca automatica na tabela SigCdTqe
*------------------------------------------------------------------------------
DEFINE CLASS TextBoxBuscaTanque AS TextBox
    Height = 24
    MaxLength = 10
    InputMask = "!!!!!!!!!!"
    FontName = "Tahoma"
    FontSize = 8

    PROCEDURE Valid()
        LOCAL loc_oLista, loc_cValor, loc_cValorSelecionado

        loc_cValor = THIS.Value
        loc_cValorSelecionado = ""

        IF !EMPTY(loc_cValor)
            TRY
                * Cria objeto de busca auxiliar
                loc_oLista = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdTqe", ;
                                       "cursor_4c_Busca", "codigos", loc_cValor, "Selecao", .T.)

                IF VARTYPE(loc_oLista) = "O"
                    * Se nao encontrou registro exato e tem registros, mostra lista
                    IF !loc_oLista.this_lAchouRegistro AND USED("cursor_4c_Busca") AND RECCOUNT("cursor_4c_Busca") > 0
                        loc_oLista.mAddColuna("codigos", "", "Codigo")
                        loc_oLista.mAddColuna("descrs", "", "Descricao")
                        loc_oLista.Show()
                    ENDIF

                    * Verifica se usuario selecionou ou cancelou
                    IF loc_oLista.this_lSelecionou AND USED("cursor_4c_Busca")
                        loc_cValorSelecionado = ALLTRIM(cursor_4c_Busca.codigos)
                    ENDIF

                    * Libera o form
                    loc_oLista.Release()
                    loc_oLista = .NULL.
                ENDIF

                * Fecha cursor
                IF USED("cursor_4c_Busca")
                    USE IN cursor_4c_Busca
                ENDIF

            CATCH TO loc_oEx
                loc_cValorSelecionado = ""
                IF USED("cursor_4c_Busca")
                    USE IN cursor_4c_Busca
                ENDIF
            ENDTRY
        ENDIF

        THIS.Value = loc_cValorSelecionado
        THIS.Refresh()
        RETURN .T.
    ENDPROC
ENDDEFINE
```

### 3.2 Usar a Classe no Formulário

```foxpro
* Usar a classe customizada em vez de TextBox genérico
loPagina.AddObject("txtTanque", "TextBoxBuscaTanque")
WITH loPagina.txtTanque
    .Left = 420
    .Top = 250
    .Width = 80
ENDWITH
```

### 3.3 FormBuscaAuxiliar - Hide() vs Release()

O formulário de busca deve usar `Hide()` para permitir leitura das propriedades após fechar:

```foxpro
* ❌ ERRADO - Objeto é destruído, propriedades inacessíveis
PROCEDURE cmdSelecionar.Click()
    THISFORM.plSelecionou = .T.
    THISFORM.Release()    && Destrói o objeto!
ENDPROC

* ✅ CORRETO - Objeto permanece acessível
PROCEDURE cmdSelecionar.Click()
    THISFORM.plSelecionou = .T.
    THISFORM.Hide()       && Apenas oculta
ENDPROC

* No codigo chamador, fazer Release() apos ler valores:
IF loc_oLista.this_lSelecionou AND USED("cursor_4c_Busca")
    loc_cValor = cursor_4c_Busca.codigos
ENDIF
loc_oLista.Release()    && Agora sim, libera
```

---

## 4. Eventos e BINDEVENT

### 4.1 BINDEVENT NÃO Funciona com Valid

```foxpro
* ❌ ERRADO - Valid não funciona com BINDEVENT
BINDEVENT(loPagina.txtTanque, "Valid", THIS, "TxtTanqueValid")

* ✅ CORRETO (preferido) - Usar LostFocus ao invés de Valid
BINDEVENT(loPagina.txtTanque, "LostFocus", THIS, "TxtTanqueValid")

* ✅ CORRETO (alternativa) - Criar classe com Valid embutido
DEFINE CLASS TextBoxBuscaTanque AS TextBox
    PROCEDURE Valid()
        * Código da validação aqui
        RETURN .T.
    ENDPROC
ENDDEFINE
```

### 4.2 BINDEVENT Funciona Com

| Evento | Funciona? |
|--------|-----------|
| Click | ✅ Sim |
| DblClick | ✅ Sim |
| KeyPress | ✅ Sim |
| Valid | ❌ **NÃO** |
| When | ❌ **NÃO** |
| GotFocus | ✅ Sim |
| LostFocus | ✅ Sim |

### 4.3 Sintaxe Correta do BINDEVENT

```foxpro
* Para eventos que funcionam
BINDEVENT(loPagina.cmdIncluir, "Click", THIS, "BtnIncluirClick")
BINDEVENT(loPagina.grdDados, "DblClick", THIS, "GridDblClick")
```

---

## 5. Grid e Colunas

### 5.1 Títulos das Colunas com Acentos

Usar caracteres acentuados diretamente:

```foxpro
DIMENSION laConfig[4, 4]

laConfig[1, 1] = "cods"
laConfig[1, 2] = "Código"        && Com acento
laConfig[1, 3] = 75
laConfig[1, 4] = 0

laConfig[2, 1] = "descs"
laConfig[2, 2] = "Descrição"     && Com acento
laConfig[2, 3] = 301
laConfig[2, 4] = 0

laConfig[3, 1] = "varias"
laConfig[3, 2] = "Variação Preço"  && Com acento
laConfig[3, 3] = 100
laConfig[3, 4] = 1

laConfig[4, 1] = "Pesos"
laConfig[4, 2] = "Variação Peso"   && Com acento
laConfig[4, 3] = 100
laConfig[4, 4] = 1
```

### 5.2 Larguras das Colunas

Copiar exatamente do código original:
```foxpro
* Do código original:
* .pfSqlTabela(1).pColuna('cods','','','Código',75,.t.)
* Usar: laConfig[1, 3] = 75
```

---

## 6. TRY/CATCH

### 6.1 NUNCA usar RETURN dentro de TRY/CATCH

```foxpro
* ❌ ERRADO
TRY
    IF erro
        RETURN .F.    && NUNCA!
    ENDIF
CATCH
    RETURN .F.        && NUNCA!
ENDTRY

* ✅ CORRETO
LOCAL llSucesso
llSucesso = .F.

TRY
    IF !erro
        llSucesso = .T.
    ENDIF
CATCH TO loEx
    llSucesso = .F.
ENDTRY

RETURN llSucesso    && RETURN apenas FORA do TRY/CATCH
```

---

## 7. Auditoria

### 7.1 Auditoria Centralizada de Operacoes

Todo Business Object deve implementar auditoria automatica para operacoes de Insert, Update e Delete. Utilizar o metodo centralizado `RegistrarAuditoria`:

```foxpro
*--------------------------------------------------------------------------
* RegistrarAuditoria - Registra operacao no log de auditoria
* Parametros: par_cOperacao = "INSERT", "UPDATE" ou "DELETE"
*--------------------------------------------------------------------------
PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
    LOCAL loc_cSQL

    loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
               "VALUES (" + EscaparSQL(THIS.this_cTabela) + ", " + ;
               EscaparSQL(par_cOperacao) + ", " + ;
               EscaparSQL(TRANSFORM(THIS.ObterChavePrimaria())) + ", " + ;
               EscaparSQL(gcUsuarioLogado) + ", GETDATE())"

    SQLEXEC(gnConnHandle, loc_cSQL)
ENDPROC

*--------------------------------------------------------------------------
* ObterChavePrimaria - Retorna valor da chave primaria do registro atual
* Cada BO deve implementar este metodo conforme sua chave
*--------------------------------------------------------------------------
PROTECTED PROCEDURE ObterChavePrimaria()
    * Implementar em cada subclasse
    * Exemplo: RETURN THIS.this_cCodigo
    RETURN ""
ENDPROC
```

### 7.2 Chamada da Auditoria

Chamar o registro de auditoria apos cada operacao bem-sucedida:

```foxpro
PROTECTED PROCEDURE Inserir()
    LOCAL loc_cSQL, loc_nResultado

    loc_cSQL = "INSERT INTO SigCdCor ..."
    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

    IF loc_nResultado >= 0
        THIS.RegistrarAuditoria("INSERT")
        RETURN .T.
    ENDIF

    RETURN .F.
ENDPROC

PROTECTED PROCEDURE Atualizar()
    * ... codigo de update ...
    IF loc_nResultado >= 0
        THIS.RegistrarAuditoria("UPDATE")
        RETURN .T.
    ENDIF
    RETURN .F.
ENDPROC

PROCEDURE Excluir()
    * ... codigo de delete ...
    IF loc_nResultado >= 0
        THIS.RegistrarAuditoria("DELETE")
        RETURN .T.
    ENDIF
    RETURN .F.
ENDPROC
```

### 7.3 Estrutura da Tabela de Auditoria (TSQL)

```sql
CREATE TABLE LogAuditoria (
    Id              INT IDENTITY(1,1) PRIMARY KEY,
    Tabela          VARCHAR(100) NOT NULL,
    Operacao        VARCHAR(10) NOT NULL,
    ChaveRegistro   VARCHAR(100) NOT NULL,
    Usuario         VARCHAR(50) NOT NULL,
    DataHora        DATETIME NOT NULL DEFAULT GETDATE(),
    DadosAnteriores NVARCHAR(MAX) NULL,
    DadosNovos      NVARCHAR(MAX) NULL
);

CREATE INDEX IX_LogAuditoria_Tabela ON LogAuditoria(Tabela);
CREATE INDEX IX_LogAuditoria_DataHora ON LogAuditoria(DataHora);
CREATE INDEX IX_LogAuditoria_Usuario ON LogAuditoria(Usuario);
```

---

## 8. Documentacao e Boas Praticas

### 8.1 Regras para Codigo Original

- **NAO copiar literalmente** trechos substanciais de codigo de outras fontes
- **NAO referenciar arquivos de origem** (ex: "Baseado em: SIGCDCOR.SCX")
- Demonstrar pensamento independente na organizacao e estrutura do codigo
- Adaptar e reescrever logica conforme os padroes deste projeto

### 8.2 Cabecalho Padrao para Arquivos

```foxpro
*==============================================================================
* NOMEDOARQUIVO.PRG
* Descricao breve da funcionalidade
*
* Tabela: NomeDaTabela
*
* REGRAS APLICADAS:
* - Nomenclatura: loc_ para locais, par_ para parametros, this_ para classe
* - Controles: tipo_4c_Nome (txt_4c_, cmd_4c_, grd_4c_, lbl_4c_)
* - Demais regras conforme REGRAS_DESENVOLVIMENTO.md
*==============================================================================
```

### 8.3 Comentarios Descritivos

Adicionar comentarios que expliquem o "por que" e nao apenas o "o que":

```foxpro
* ERRADO - Apenas descreve o obvio
* Seta o valor para zero
THIS.nContador = 0

* CORRETO - Explica o proposito
* Reinicia contador para nova sessao de edicao
THIS.nContador = 0
```

### 8.4 Nomenclatura de Cursores

Usar o padrao `cursor_4c_` seguido de nome descritivo:

| Uso | Nome do Cursor |
|-----|----------------|
| Busca auxiliar | `cursor_4c_Busca` |
| Dados principais | `cursor_4c_Dados` |
| Verificacao | `cursor_4c_Verifica` |
| Listagem | `cursor_4c_Lista` |

**IMPORTANTE**: NAO usar o termo "ListaRemota" ou "CrListaRemota".

---

## 9. Checklist de Implementacao

### Antes de Comecar

- [ ] Analisei o código original completamente
- [ ] Identifiquei todos os campos e validações
- [ ] Identifiquei campos com busca em tabelas relacionadas
- [ ] Tenho o print/screenshot da tela original

### Formulário

- [ ] `ShowWindow = 1` (não 2)
- [ ] `WindowType = 1` para modais
- [ ] `Show()` sem parâmetro (WindowType já define)
- [ ] **Nenhum** `CLEAR EVENTS` no botão fechar

### Botões com Ícone

- [ ] `PicturePosition = 13`
- [ ] Width = 75, Height = 80
- [ ] Verificar case dos nomes de arquivos .ico

### Campos de Busca

- [ ] Criar classe TextBox específica com Valid embutido
- [ ] **NÃO** usar BINDEVENT para Valid
- [ ] FormBuscaAuxiliar usa `Hide()` (não Release)
- [ ] Release() após ler valores do cursor

### Grid

- [ ] Títulos com acentos conforme original
- [ ] Larguras conforme original
- [ ] BINDEVENT para DblClick funciona

### Código

- [ ] RETURN apenas FORA de TRY/CATCH
- [ ] Init() sempre retorna .T. (usar propriedades para status)
- [ ] Deletar arquivos .FXP antes de testar

---

## Estrutura de Classes para Novos Cadastros

```
FormCor.prg
├── PageFrameDuasPaginas (PageFrame customizado)
├── TextBoxBuscaTanque (TextBox com Valid para busca)
└── FormCor AS FormBase
    ├── InicializarForm()
    ├── ConfigurarPageFrame()
    ├── ConfigurarPaginaLista()
    ├── ConfigurarPaginaDados()
    ├── CarregarLista()
    ├── FormParaBO()
    ├── BOParaForm()
    └── Eventos dos botões
```

---

## Arquivos Necessários para Nova Funcionalidade

1. **Business Object**: `projeto/app/classes/NovoBO.prg`
2. **Formulário**: `projeto/app/forms/cadastros/FormNovo.prg`
3. **Classes de TextBox customizadas** (se houver campos de busca)
4. **Registrar em config.prg**: `SET PROCEDURE TO ... ADDITIVE`
5. **Adicionar ao menu**: `menu.prg`

---

## Relatorios

### Criacao de Relatorios com RelatorioBase

Usar a classe `RelatorioBase` em `app/classes/relatoriobase.prg` para padronizar a criacao de relatorios:

```foxpro
DEFINE CLASS RelatorioCores AS RelatorioBase

    PROCEDURE Init()
        DODEFAULT("C:\4c\projeto\app\reports\RelCores.frx", "Relatorio de Cores")
        THIS.this_cCursorDados = "cursor_4c_RelCores"
        RETURN .T.
    ENDPROC

    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_cSQL, loc_nResultado

        loc_cSQL = "SELECT cods, descs, varias, Pesos, grupos, tpCors " + ;
                   "FROM SigCdCor"

        IF !EMPTY(THIS.this_cFiltro)
            loc_cSQL = loc_cSQL + " WHERE " + THIS.this_cFiltro
        ENDIF

        loc_cSQL = loc_cSQL + " ORDER BY cods"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = "Erro ao buscar dados"
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

ENDDEFINE
```

### Uso do Relatorio

```foxpro
* Visualizar
loc_oRelatorio = CREATEOBJECT("RelatorioCores")
loc_oRelatorio.Visualizar()

* Imprimir diretamente
loc_oRelatorio = CREATEOBJECT("RelatorioCores")
loc_oRelatorio.this_lVisualizarAntes = .F.
loc_oRelatorio.Imprimir()

* Exportar para PDF
loc_oRelatorio = CREATEOBJECT("RelatorioCores")
loc_oRelatorio.ExportarPDF("C:\Temp\RelCores.pdf")
```

### Estrutura de Pastas para Relatorios

```
projeto/app/reports/
    RelCores.frx        && Relatorio de Cores
    RelCores.frt
    RelCargos.frx       && Relatorio de Cargos
    RelCargos.frt
```

---

## Ordem de Implementacao Recomendada

1. Criar Business Object (validacoes e SQL)
2. Criar classes TextBox customizadas para campos de busca
3. Criar formulário básico (sem funcionalidade)
4. Adicionar controles visuais
5. Implementar eventos
6. Testar cada operação individualmente
7. Deletar .FXP e testar novamente
8. Integrar ao menu

---

**Ultima atualizacao:** 2025-12-02
**Versao:** 2.0
