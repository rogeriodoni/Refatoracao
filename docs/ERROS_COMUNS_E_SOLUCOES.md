# Erros Comuns e Soluções - Visual FoxPro 9

## Documento de Referência Rápida

Este documento consolida todos os erros encontrados durante o desenvolvimento e suas soluções, para evitar repetição.

---

## 📋 Índice

1. [TRY/CATCH: RETURN Proibido](#1-trycatch-return-proibido)
2. [SET CLASSLIB vs SET PROCEDURE](#2-set-classlib-vs-set-procedure)
3. [READ EVENTS: Localização Correta](#3-read-events-localização-correta)
4. [DO FORM vs CREATEOBJECT](#4-do-form-vs-createobject)
5. [PageFrame: Nomes de Páginas](#5-pageframe-nomes-de-páginas)
6. [Eventos de Objetos Dinâmicos](#6-eventos-de-objetos-dinâmicos)
7. [LOCAL DIMENSION: Sintaxe Incorreta](#7-local-dimension-sintaxe-incorreta)
8. [PEMSTATUS: Verificar Objetos](#8-pemstatus-verificar-objetos)
9. [Arquivos Compilados (.FXP)](#9-arquivos-compilados-fxp)
10. [Show() vs Show(1): Formulário Modal](#10-show-vs-show1-formulário-modal)
11. [Controles Invisíveis com AddObject()](#11-controles-invisíveis-com-addobject)
12. [Property VISIBLE is Not Found](#12-property-visible-is-not-found)
13. [Init() Retorna .F. - Formulário Não Aparece](#13-init-retorna-f---formulário-não-aparece)
14. [BINDEVENT Não Funciona com Valid](#14-bindevent-não-funciona-com-valid)
15. [PicturePosition: Ícone Acima do Texto](#15-pictureposition-ícone-acima-do-texto)
16. [Release() Destrói Objeto Antes de Ler Propriedades](#16-release-destrói-objeto-antes-de-ler-propriedades)
17. [CLEAR EVENTS Fecha o Sistema](#17-clear-events-fecha-o-sistema)
18. [ShowWindow = 2 com Modal](#18-showwindow--2-com-modal)

---

## 1. TRY/CATCH: RETURN Proibido

### ❌ ERRADO
```foxpro
PROCEDURE MinhaFuncao()
    TRY
        IF erro
            RETURN .F.    && NUNCA faça isso!
        ENDIF
        RETURN .T.        && NUNCA faça isso!
    CATCH
        RETURN .F.        && NUNCA faça isso!
    ENDTRY
ENDPROC
```

### ✅ CORRETO
```foxpro
PROCEDURE MinhaFuncao()
    LOCAL llResultado
    llResultado = .F.    && Valor padrão pessimista

    TRY
        IF erro
            llResultado = .F.
        ELSE
            llResultado = .T.
        ENDIF
    CATCH TO loException
        llResultado = .F.
        * Registrar erro se necessário
    ENDTRY

    RETURN llResultado    && RETURN apenas FORA do TRY/CATCH
ENDPROC
```

### Por quê?
- RETURN dentro de TRY/CATCH causa comportamento imprevisível no VFP
- Recursos podem não ser liberados adequadamente
- O ENDTRY pode não ser executado corretamente

---

## 2. SET CLASSLIB vs SET PROCEDURE

### ❌ ERRADO
```foxpro
* Para arquivos .PRG com classes
SET CLASSLIB TO dataaccess.prg ADDITIVE    && ERRO!
```

### ✅ CORRETO
```foxpro
* Para arquivos .PRG com classes (DEFINE CLASS)
SET PROCEDURE TO dataaccess.prg ADDITIVE

* Para arquivos .VCX (Visual Class Library)
SET CLASSLIB TO minhaclasse.vcx ADDITIVE
```

### Regra:
- `.PRG` com `DEFINE CLASS` → **SET PROCEDURE**
- `.VCX` (biblioteca visual) → **SET CLASSLIB**

---

## 3. READ EVENTS: Localização Correta

### ❌ ERRADO
```foxpro
*-- main.prg
DO menu.prg
DesconectarBancoDados()
QUIT

*-- menu.prg
CriarMenuPrincipal()
READ EVENTS    && ERRADO aqui!
```

### ✅ CORRETO
```foxpro
*-- main.prg
CriarMenuPrincipal()    && Chama procedure
READ EVENTS             && READ EVENTS no programa principal
DesconectarBancoDados()
QUIT

*-- menu.prg
PROCEDURE CriarMenuPrincipal()
    * Cria menu
ENDPROC

PROCEDURE SairSistema()
    CLEAR EVENTS    && Termina o READ EVENTS do main.prg
ENDPROC
```

### Regra:
- **READ EVENTS** deve estar no programa principal (main.prg)
- Arquivos chamados com `DO` devem conter apenas procedures
- `CLEAR EVENTS` encerra o loop do READ EVENTS

---

## 4. DO FORM vs CREATEOBJECT

### ❌ ERRADO
```foxpro
* Para formulários definidos como classe em .PRG
DO FORM FormCor.prg    && ERRO! DO FORM é só para .SCX
```

### ✅ CORRETO
```foxpro
* Para formulários .SCX (criados no Form Designer)
DO FORM MeuForm.scx

* Para formulários definidos como classe em .PRG
LOCAL loForm
loForm = CREATEOBJECT("FormCor")
loForm.Show()
```

### Regra:
- `.SCX` (Form Designer) → **DO FORM**
- `.PRG` com `DEFINE CLASS` → **CREATEOBJECT()**

---

## 5. PageFrame: Nomes de Páginas

### ❌ ERRADO
```foxpro
PROCEDURE ConfigurarPageFrame()
    WITH THIS.pgfPaginas
        .PageCount = 2
        .Page1.Name = "pgLista"    && NÃO funciona!
        .Page2.Name = "pgDados"    && NÃO funciona!
    ENDWITH
ENDPROC
```

### ✅ CORRETO - Opção 1 (usar nomes padrão)
```foxpro
* Use os nomes padrão: Page1, Page2, Page3...
THIS.pgfPaginas.Page1.Caption = "Lista"
THIS.pgfPaginas.Page2.Caption = "Dados"
```

### ✅ CORRETO - Opção 2 (definir na classe)
```foxpro
* Criar classe customizada
DEFINE CLASS PageFrameDuasPaginas AS PageFrame
    PageCount = 2
    BorderWidth = 0
    TabStyle = 0
ENDDEFINE

* Usar a classe customizada
ADD OBJECT pgfPaginas AS PageFrameDuasPaginas
```

### Regra:
- **NÃO é possível** renomear páginas do PageFrame em runtime
- Use nomes padrão (Page1, Page2...) ou crie classe customizada

---

## 6. Eventos de Objetos Dinâmicos

### ❌ ERRADO
```foxpro
PROCEDURE ConfigurarBotoes()
    loPagina.AddObject("cmdOK", "CommandButton")
ENDPROC

* Tentar declarar evento assim:
PROCEDURE loPagina.cmdOK.Click()    && ERRO!
    * código
ENDPROC
```

### ✅ CORRETO - Use BINDEVENT
```foxpro
PROCEDURE ConfigurarBotoes()
    loPagina.AddObject("cmdOK", "CommandButton")

    * Vincular evento ao método do form
    BINDEVENT(loPagina.cmdOK, "Click", THIS, "BtnOKClick")
ENDPROC

PROCEDURE BtnOKClick()
    * código do evento
ENDPROC
```

### Regra:
- **Declaração estática** (`PROCEDURE objeto.evento`) → Apenas para objetos com `ADD OBJECT` na definição da classe
- **BINDEVENT** → Para objetos criados dinamicamente com `AddObject()`

### Sintaxe BINDEVENT:
```foxpro
BINDEVENT(objeto, "evento", destino, "método")
         └─────┘  └──────┘  └──────┘  └──────┘
         botão    Click     THIS      MeuMetodo
```

---

## 7. LOCAL DIMENSION: Sintaxe Incorreta

### ❌ ERRADO
```foxpro
LOCAL DIMENSION laConfig[4, 4]    && Sintaxe inválida!
```

### ✅ CORRETO - Opção 1
```foxpro
DIMENSION laConfig[4, 4]    && Array no escopo atual
```

### ✅ CORRETO - Opção 2
```foxpro
LOCAL ARRAY laConfig[4, 4]    && Array local explícito
```

### Regra:
- **LOCAL** e **DIMENSION** não podem ser usados juntos
- Use `DIMENSION` ou `LOCAL ARRAY`

---

## 8. PEMSTATUS: Verificar Objetos

### ❌ ERRADO
```foxpro
PROCEDURE ConfigurarColunas()
    THIS.ColumnCount = 4

    FOR lnI = 1 TO 4
        loColuna = THIS.Columns(lnI)
        loColuna.Header1.Caption = "Título"    && Pode não existir!
        loColuna.Text1.Alignment = 1           && Pode não existir!
    ENDFOR
ENDPROC
```

### ✅ CORRETO
```foxpro
PROCEDURE ConfigurarColunas()
    * Resetar colunas
    THIS.ColumnCount = -1
    THIS.ColumnCount = 4

    FOR lnI = 1 TO 4
        loColuna = THIS.Columns(lnI)

        * Verificar se Header1 existe
        IF PEMSTATUS(loColuna, "Header1", 5)
            loColuna.Header1.Caption = "Título"
        ENDIF

        * Verificar se Text1 existe
        IF PEMSTATUS(loColuna, "Text1", 5)
            loColuna.Text1.Alignment = 1
        ENDIF
    ENDFOR
ENDPROC
```

### Função PEMSTATUS:
```foxpro
PEMSTATUS(objeto, "propriedade", tipo)
```

**Tipos:**
- `5` = Verifica se existe e está acessível
- Retorna `.T.` se existe, `.F.` se não existe

### Quando usar:
- Ao acessar objetos de colunas de Grid criado dinamicamente
- Ao acessar qualquer propriedade/objeto que pode não existir

---

## 9. Arquivos Compilados (.FXP)

### Problema:
O VFP cria arquivos `.fxp` (compilados) ao executar `.prg`. Se você corrigir o código `.prg`, o VFP pode continuar usando o `.fxp` antigo.

### Solução:
Sempre que fizer correções significativas, **delete os arquivos .fxp**:

#### Opção 1 - Script automático:
```batch
C:\4c\LIMPAR_COMPILADOS.bat
```

#### Opção 2 - Manual:
```batch
cd C:\4c\projeto\app
del /s /q *.fxp
```

### Quando deletar:
- Após corrigir erros de sintaxe
- Após mudar estrutura de classes
- Quando o erro persiste mesmo após correção
- Antes de fazer testes importantes

---

## 📝 Checklist de Boas Práticas

Ao desenvolver, sempre verifique:

### Estrutura de Código:
- [ ] Nenhum RETURN dentro de TRY/CATCH
- [ ] TRY/CATCH tem variável local para resultado
- [ ] Variáveis locais declaradas antes do TRY

### Arquivos e Classes:
- [ ] Arquivos .PRG carregados com SET PROCEDURE
- [ ] Arquivos .VCX carregados com SET CLASSLIB
- [ ] Classes instanciadas com CREATEOBJECT()

### Eventos:
- [ ] READ EVENTS apenas no programa principal
- [ ] Eventos dinâmicos vinculados com BINDEVENT
- [ ] Nenhum PROCEDURE objeto.evento para objetos dinâmicos

### Arrays:
- [ ] Uso correto: DIMENSION ou LOCAL ARRAY
- [ ] Nunca: LOCAL DIMENSION

### Objetos:
- [ ] PEMSTATUS antes de acessar propriedades incertas
- [ ] ColumnCount = -1 antes de reconfigurar grid
- [ ] Nomes de páginas do PageFrame são padrão (Page1, Page2)

### Compilação:
- [ ] Deletar .fxp após correções
- [ ] Testar com arquivos recompilados

---

## 🔍 Padrões de Código Aprovados

### Função com TRY/CATCH:
```foxpro
FUNCTION MinhaFuncao(pcParametro)
    LOCAL llSucesso
    llSucesso = .F.

    * Validações rápidas (antes do TRY)
    IF EMPTY(pcParametro)
        RETURN llSucesso
    ENDIF

    TRY
        * Processamento
        IF condicao
            llSucesso = .T.
        ENDIF

    CATCH TO loException
        llSucesso = .F.
        * Registrar erro
    ENDTRY

    RETURN llSucesso
ENDFUNC
```

### Configurar Grid Dinamicamente:
```foxpro
PROCEDURE ConfigurarGrid()
    LOCAL loPagina, laConfig
    loPagina = THIS.pgfPaginas.Page1

    * Adicionar grid
    loPagina.AddObject("grdDados", "GridBase")

    * Configurar colunas
    DIMENSION laConfig[3, 4]
    laConfig[1, 1] = "codigo"
    laConfig[1, 2] = "Código"
    laConfig[1, 3] = 80
    laConfig[1, 4] = 0  && Alinhamento

    loPagina.grdDados.ConfigurarColunas(@laConfig)

    * Vincular evento
    BINDEVENT(loPagina.grdDados, "DblClick", THIS, "GridDblClick")
ENDPROC

PROCEDURE GridDblClick()
    * Tratar duplo clique
ENDPROC
```

### Abrir Formulário:
```foxpro
PROCEDURE AbrirMeuForm()
    LOCAL loForm

    * Criar instância
    loForm = CREATEOBJECT("MeuForm")

    IF VARTYPE(loForm) = "O"
        loForm.Show()
    ELSE
        MESSAGEBOX("Erro ao criar formulário", 16, "Erro")
    ENDIF
ENDPROC
```

---

## 📚 Referências Rápidas

### Comandos de Carregamento:
| Tipo de Arquivo | Comando |
|----------------|---------|
| .PRG (procedures/classes) | SET PROCEDURE TO arquivo.prg ADDITIVE |
| .VCX (visual class lib) | SET CLASSLIB TO arquivo.vcx ADDITIVE |
| .SCX (form visual) | DO FORM arquivo.scx |
| .PRG (form classe) | loForm = CREATEOBJECT("NomeClasse") |

### Declaração de Arrays:
| Sintaxe | Status |
|---------|--------|
| `DIMENSION laArray[n, m]` | ✅ Correto |
| `LOCAL ARRAY laArray[n, m]` | ✅ Correto |
| `PUBLIC ARRAY gaArray[n, m]` | ✅ Correto |
| `LOCAL DIMENSION laArray[n, m]` | ❌ ERRO |

### BINDEVENT vs Declaração Estática:
| Tipo de Objeto | Sintaxe de Evento |
|----------------|-------------------|
| ADD OBJECT na classe | `PROCEDURE objeto.evento()` |
| AddObject() em runtime | `BINDEVENT(obj, "evento", THIS, "metodo")` |

---

## 10. Show() vs Show(1): Formulário Modal

### ❌ ERRADO
```foxpro
PROCEDURE AbrirForm()
    LOCAL loForm
    loForm = CREATEOBJECT("MeuForm")
    loForm.Show()    && Pode não aparecer na tela
ENDPROC
```

### ✅ CORRETO
```foxpro
PROCEDURE AbrirForm()
    LOCAL loForm
    loForm = CREATEOBJECT("MeuForm")
    loForm.Show(1)   && 1 = MODAL - sempre aparece
ENDPROC
```

### Parâmetros de Show():
- **0 ou omitido** = Modeless (não-modal) - Requer READ EVENTS ativo
- **1** = Modal - Bloqueia outras janelas, sempre aparece
- **2** = Modeless como child

### Quando usar cada um:
- **Show(1)** → Formulários de cadastro, diálogos, forms que devem ter atenção exclusiva
- **Show(0)** → Toolbars, painéis auxiliares (requer READ EVENTS no programa principal)

---

## 11. Controles Invisíveis com AddObject()

### ❌ ERRADO
```foxpro
PROCEDURE ConfigurarPagina()
    LOCAL loPagina
    loPagina = THIS.pgfPaginas.Page1

    * Cria controles
    loPagina.AddObject("cmdOK", "CommandButton")
    loPagina.AddObject("txtNome", "TextBox")

    * Controles NÃO aparecem - estão invisíveis!
ENDPROC
```

### ✅ CORRETO - Opção 1: Manual
```foxpro
PROCEDURE ConfigurarPagina()
    LOCAL loPagina
    loPagina = THIS.pgfPaginas.Page1

    * Cria controles
    loPagina.AddObject("cmdOK", "CommandButton")
    loPagina.cmdOK.Visible = .T.    && Torna visível

    loPagina.AddObject("txtNome", "TextBox")
    loPagina.txtNome.Visible = .T.  && Torna visível
ENDPROC
```

### ✅ CORRETO - Opção 2: Recursivo
```foxpro
PROCEDURE ConfigurarPagina()
    LOCAL loPagina
    loPagina = THIS.pgfPaginas.Page1

    * Cria todos os controles...
    loPagina.AddObject("cmdOK", "CommandButton")
    loPagina.AddObject("txtNome", "TextBox")

    * Torna todos visíveis de uma vez
    THIS.TornarControlesVisiveis(loPagina)
ENDPROC

PROTECTED PROCEDURE TornarControlesVisiveis(poContainer)
    LOCAL lnI, loObjeto

    FOR lnI = 1 TO poContainer.ControlCount
        loObjeto = poContainer.Controls(lnI)

        IF VARTYPE(loObjeto) = "O"
            * Verifica se tem .Visible antes de definir
            IF PEMSTATUS(loObjeto, "Visible", 5)
                loObjeto.Visible = .T.
            ENDIF

            * Processa recursivamente containers
            IF PEMSTATUS(loObjeto, "ControlCount", 5)
                THIS.TornarControlesVisiveis(loObjeto)
            ENDIF
        ENDIF
    ENDFOR
ENDPROC
```

### Por quê?
- `AddObject()` cria controles com `.Visible = .F.` por padrão
- Diferente de `ADD OBJECT` no design da classe (que cria visível)

---

## 12. Property VISIBLE is Not Found

### ❌ ERRADO
```foxpro
PROCEDURE ConfigurarPageFrame()
    WITH THIS.pgfPaginas
        .Page1.Visible = .T.  && ERRO! Page não tem .Visible
        .Page2.Visible = .T.  && ERRO! Page não tem .Visible
    ENDWITH
ENDPROC
```

### ✅ CORRETO
```foxpro
PROCEDURE ConfigurarPageFrame()
    WITH THIS.pgfPaginas
        .Visible = .T.         && OK! PageFrame tem .Visible
        .Page1.Caption = "Lista"    && OK! Page tem .Caption
        .Page2.Caption = "Dados"    && OK! Page tem .Caption
    ENDWITH

    * Para alternar páginas:
    THIS.pgfPaginas.ActivePage = 1  && Usa .ActivePage, não .Visible
ENDPROC
```

### Objetos que NÃO têm .Visible:
| Objeto | Como Controlar Visibilidade |
|--------|----------------------------|
| Page (PageFrame) | Use `.ActivePage` para alternar |
| Column (Grid) | Use `Column.Width = 0` ou controle pelo Grid |
| Header (Column) | Sempre visível se Column visível |
| Timer | Não é visual |

### Sempre use PEMSTATUS:
```foxpro
* Padrão seguro para qualquer propriedade
IF PEMSTATUS(loObjeto, "Visible", 5)
    loObjeto.Visible = .T.
ENDIF
```

---

## 13. Init() Retorna .F. - Formulário Não Aparece

### ❌ SINTOMA
```foxpro
* Executa sem erro
loForm = CREATEOBJECT("MeuForm")
loForm.Show(1)

* MAS o formulário NÃO aparece!
* Nenhuma mensagem de erro
* Sistema continua rodando normalmente
```

### 🔍 CAUSA
Quando `Init()` retorna `.F.`, o VFP **cancela a criação do objeto SILENCIOSAMENTE**:
- CREATEOBJECT retorna `.NULL.`
- Nenhum erro é gerado
- Show() nunca é executado

### ❌ ERRADO - O que causava o problema
```foxpro
*-- FormBase.Init()
PROCEDURE Init()
    * Chama inicialização da subclasse
    THIS.InicializarForm()    && Não verificava retorno!

    RETURN .T.
ENDPROC

*-- FormCor.InicializarForm()
PROTECTED PROCEDURE InicializarForm()
    TRY
        IF erro
            RETURN .F.    && ERRADO! RETURN dentro do TRY
        ENDIF
        RETURN .T.        && ERRADO! RETURN dentro do TRY
    CATCH
        ERROR "Erro"      && ERRADO! ERROR faz Init() retornar .F.
    ENDTRY
ENDPROC
```

**Problemas:**
1. `RETURN` dentro de TRY/CATCH (ver §1)
2. `ERROR` faz Init() retornar `.F.` implicitamente
3. FormBase.Init() não verificava retorno de InicializarForm()

### ✅ CORRETO - Solução aplicada
```foxpro
*-- FormBase.Init()
PROCEDURE Init()
    LOCAL llSucesso

    IF !EMPTY(THIS.cTituloForm)
        THIS.Caption = THIS.cTituloForm
    ENDIF

    * Chama inicialização e VERIFICA retorno
    llSucesso = THIS.InicializarForm()

    IF !llSucesso
        RETURN .F.    && Propaga falha
    ENDIF

    THIS.AtualizarEstadoControles()

    RETURN .T.
ENDPROC

*-- FormBase.InicializarForm() padrão
PROTECTED PROCEDURE InicializarForm()
    * Subclasses implementam aqui
    RETURN .T.    && Retorna sucesso por padrão
ENDPROC

*-- FormCor.InicializarForm()
PROTECTED PROCEDURE InicializarForm()
    LOCAL loException, llSucesso

    llSucesso = .F.  && Valor padrão pessimista

    TRY
        THIS.oBusinessObject = CREATEOBJECT("CorBO")

        IF ISNULL(THIS.oBusinessObject)
            MESSAGEBOX("Erro ao criar CorBO!", 16, "Erro")
            llSucesso = .F.
        ELSE
            * Configurações...
            THIS.ConfigurarPageFrame()
            THIS.ConfigurarPaginaLista()
            THIS.ConfigurarPaginaDados()

            llSucesso = .T.
        ENDIF

    CATCH TO loException
        MESSAGEBOX("Erro: " + loException.Message, 16, "Erro")
        llSucesso = .F.
    ENDTRY

    RETURN llSucesso  && RETURN apenas FORA do TRY/CATCH
ENDPROC
```

### Regras Críticas:

1. **NUNCA use RETURN dentro de TRY/CATCH** (ver §1)
   - Use variável local
   - RETURN apenas FORA do bloco

2. **NUNCA use ERROR dentro de Init() ou métodos chamados por Init()**
   - ERROR faz Init() retornar `.F.` implicitamente
   - Use MESSAGEBOX + RETURN .F. explícito

3. **Init() deve verificar retorno de métodos auxiliares**
   - Capture o retorno
   - Se falhou, retorne `.F.`

4. **Sempre retorne .T. ou .F. explicitamente**
   - Não confie em retorno implícito

### Como Diagnosticar:
```foxpro
LOCAL loForm

loForm = CREATEOBJECT("MeuForm")

IF ISNULL(loForm)
    MESSAGEBOX("Init() retornou .F." + CHR(13) + ;
               "Verifique:" + CHR(13) + ;
               "1. RETURN dentro de TRY/CATCH?" + CHR(13) + ;
               "2. ERROR dentro de Init()?" + CHR(13) + ;
               "3. InicializarForm() retorna .F.?", 16, "Debug")
ELSE
    loForm.Show(1)
ENDIF
```

### Ver também:
- §1 - TRY/CATCH: RETURN Proibido
- §10 - Show() vs Show(1)

---

## 14. BINDEVENT Não Funciona com Valid

### ❌ ERRADO
```foxpro
PROCEDURE ConfigurarPaginaDados()
    loPagina.AddObject("txtTanque", "TextBox")

    * Tentativa de vincular Valid - NÃO FUNCIONA!
    BINDEVENT(loPagina.txtTanque, "Valid", THIS, "TxtTanqueValid")
ENDPROC

PROCEDURE TxtTanqueValid()
    * Este código NUNCA será executado!
ENDPROC
```

### ✅ CORRETO (preferido) - Usar LostFocus ao invés de Valid
```foxpro
BINDEVENT(loPagina.txtTanque, "LostFocus", THIS, "TxtTanqueValid")
```

### ✅ CORRETO (alternativa) - Criar classe TextBox com Valid embutido
```foxpro
* Definir classe customizada
DEFINE CLASS TextBoxBuscaTanque AS TextBox
    PROCEDURE Valid()
        * Código de validação AQUI
        LOCAL loLista
        * ... lógica de busca ...
        RETURN .T.
    ENDPROC
ENDDEFINE

* Usar a classe customizada
PROCEDURE ConfigurarPaginaDados()
    loPagina.AddObject("txtTanque", "TextBoxBuscaTanque")
ENDPROC
```

### Eventos que NÃO funcionam com BINDEVENT:
| Evento | Funciona? |
|--------|-----------|
| Valid | ❌ NÃO |
| When | ❌ NÃO |
| Click | ✅ SIM |
| DblClick | ✅ SIM |
| KeyPress | ✅ SIM |

---

## 15. PicturePosition: Ícone Acima do Texto

### ❌ ERRADO
```foxpro
WITH .cmdIncluir
    .Picture = "Add.ico"
    .PicturePosition = 1    && ERRADO! Ícone fica à direita
ENDWITH
```

### ✅ CORRETO
```foxpro
WITH .cmdIncluir
    .Caption = "Incluir"
    .Width = 75
    .Height = 80
    .Picture = "C:\4c\vbmp\Add.ico"
    .PicturePosition = 13   && CORRETO! Ícone acima do texto
ENDWITH
```

### Valores de PicturePosition:
| Valor | Posição do Ícone |
|-------|------------------|
| 0 | Esquerda do texto |
| 1 | Direita do texto |
| **13** | **Acima do texto (USAR ESTE!)** |
| 14 | Abaixo do texto |

---

## 16. Release() Destrói Objeto Antes de Ler Propriedades

### ❌ ERRADO
```foxpro
* No formulário de busca auxiliar
PROCEDURE cmdSelecionar.Click()
    THISFORM.plSelecionou = .T.
    THISFORM.Release()    && Objeto é destruído AQUI!
ENDPROC

* No código chamador
loLista.Show()
IF loLista.plSelecionou    && ERRO! loLista já foi destruído!
    lcValor = CrListaRemota.codigos
ENDIF
```

### ✅ CORRETO - Usar Hide() e Release() depois
```foxpro
* No formulário de busca auxiliar
PROCEDURE cmdSelecionar.Click()
    THISFORM.plSelecionou = .T.
    THISFORM.Hide()       && Apenas OCULTA, objeto permanece
ENDPROC

* No código chamador
loLista.Show()
IF loLista.plSelecionou AND USED('CrListaRemota')
    lcValor = ALLTRIM(CrListaRemota.codigos)
ENDIF
loLista.Release()         && AGORA sim, libera o objeto
loLista = .NULL.
```

### Regra:
- **Hide()** → Oculta o form, objeto continua acessível
- **Release()** → Destrói o objeto completamente
- Use `Hide()` quando precisar ler propriedades após fechar

---

## 17. CLEAR EVENTS Fecha o Sistema

### ❌ ERRADO
```foxpro
PROCEDURE BtnEncerrarClick()
    THIS.Release()
    CLEAR EVENTS    && FECHA TODO O SISTEMA!
ENDPROC
```

### ✅ CORRETO
```foxpro
PROCEDURE BtnEncerrarClick()
    THIS.Release()    && Apenas fecha o formulário
ENDPROC
```

### Quando usar CLEAR EVENTS:
- **APENAS** no menu principal, opção "Sair do Sistema"
- **NUNCA** em formulários de cadastro ou auxiliares

### Por quê?
`CLEAR EVENTS` encerra o loop `READ EVENTS` do programa principal, fechando toda a aplicação.

---

## 18. ShowWindow = 2 com Modal

### ❌ ERRADO - Formulário pode abrir e fechar imediatamente
```foxpro
DEFINE CLASS MeuForm AS FormBase
    ShowWindow = 2     && Top-Level Form
    * Sem WindowType definido
ENDDEFINE

* Ao abrir:
loForm = CREATEOBJECT("MeuForm")
loForm.Show(1)    && Pode ter comportamento instável
```

### ✅ CORRETO
```foxpro
DEFINE CLASS MeuForm AS FormBase
    ShowWindow = 1     && In Top-Level Form (compatível com modal)
    WindowType = 1     && Modal definido na classe
ENDDEFINE

* Ao abrir:
loForm = CREATEOBJECT("MeuForm")
loForm.Show()     && Sem parâmetro - WindowType já define modal
```

### Combinações seguras:
| ShowWindow | WindowType | Show() | Resultado |
|------------|------------|--------|-----------|
| 1 | 1 | Show() | ✅ Modal estável |
| 2 | 1 | Show() | ⚠️ Pode ter problemas |
| 2 | - | Show(1) | ❌ Instável |

---

## 🚨 Sinais de Alerta

Se você vir estes erros, consulte este documento:

| Erro | Seção |
|------|-------|
| "unknown member header1" | §8 - PEMSTATUS |
| "unknown member cntBotoes" | §6 - BINDEVENT |
| "property visible is not found" | §12 - Property VISIBLE |
| Formulário não aparece (sem erro) | §13 - Init() retorna .F. |
| Formulário não aparece (com Show) | §10 - Show(1) |
| Controles invisíveis | §11 - AddObject Visible |
| Persistente após correção | §9 - Arquivos .FXP |
| "Syntax error" em DIMENSION | §7 - LOCAL DIMENSION |
| Sistema fecha imediatamente | §3 - READ EVENTS ou §17 - CLEAR EVENTS |
| "File does not exist" em CREATEOBJECT | §2 - SET PROCEDURE |
| Valid não é executado | §14 - BINDEVENT com Valid |
| Ícone ao lado do texto (não acima) | §15 - PicturePosition |
| "loLista is not an object" | §16 - Release() destrói objeto |
| Formulário abre e fecha sozinho | §17 - CLEAR EVENTS ou §18 - ShowWindow |
| Campo não preenche após seleção | §16 - Hide() vs Release() |

---

**Última atualização:** 2025-11-25
**Versão:** 4.0
**Status:** Validado com 18 erros documentados
