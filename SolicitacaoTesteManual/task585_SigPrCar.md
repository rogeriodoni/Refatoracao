# Solicitacao de Teste Manual

**Task ID:** task585
**Formulario:** FormSigPrCar (origem: SIGPRCAR - "Caracteristicas do Produto")
**Tipo:** OPERACIONAL - dialogo MODAL FILHO (nao tem entrada de menu)
**Data:** 2026-09-26

---

## 1. Objetivo do Teste

Validar o dialogo de Caracteristicas do Produto migrado de `SigPrCar.SCX`.

**ATENCAO - este form NAO abre pelo menu.** No legado ele eh aberto pelo Cadastro
de Produtos (`SIGCDPRO.Pagina.Dados.pgframeDados.pgDados.cmdCaracts.btnCaracts.Valid`
-> `Do Form SigPrCar With ThisForm`). Ver o item 5 (LACUNA DE INTEGRACAO) antes de
testar: hoje nao existe caminho pela UI para chegar nele.

## 2. Pre-Requisitos

- [ ] Form migrado: `C:\4c\projeto\app\forms\operacionais\FormSigPrCar.prg`
- [ ] Business Object: `C:\4c\projeto\app\classes\SigPrCarBO.prg`
- [ ] Banco acessivel (DB_MBAHIA) com um produto em `SigCdPro` e caracteristicas
      em `SigCrRap` cujo `cgrus` bata com o `cgrus` desse produto (ou seja em
      branco - o filtro do legado eh `CGrus In (<cgrus do produto>, Space(3))`)
- [ ] Deletar `.fxp` antes de testar: `del /s /q C:\4c\projeto\app\*.fxp`

**Como abrir enquanto a integracao nao existe** (o form exige produto e modo):

```foxpro
loForm = CREATEOBJECT("FormSigPrCar", .NULL., "<CPros do produto>", "ALTERAR")
loForm.Show()
```

## 3. Casos de Teste

### 3.1. UI Fidelity (PILAR 1)

- [ ] Form 480 x 540, SEM barra de titulo (TitleBar = 0), centralizado, modal
- [ ] Faixa cinza no topo (Top=0, Height=80, RGB(100,100,100)) com o titulo
      "Caracteristicas do Produto" em Tahoma 18 bold branco, sobre a sombra preta
- [ ] Grade em Top=103, Left=8, 463 x 411, 2 colunas: "Caracteristica" (150px) e
      "Descricao" (290px), headers centralizados em cinza RGB(90,90,90)
- [ ] Grade SEM as barras laterais de marcacao (RecordMark/DeleteMark = .F.)
- [ ] Tres botoes em Top=3: Inserir (Left=255), Excluir (Left=330), Encerrar
      (Left=405), 75x75, com icone (inserir/excluir/sair) E legenda
- [ ] Fundo do form = `Framework\imagens\new_background.jpg`

### 3.2. Modo do form PAI = ALTERAR (ou INCLUIR)

- [ ] Inserir e Excluir VISIVEIS e habilitados
- [ ] Clicar **Inserir** -> aparece UMA linha em branco na grade e o foco vai
      para a celula "Caracteristica"
- [ ] Clicar **Inserir** de novo SEM preencher -> NAO cria segunda linha em
      branco (o legado faz `Locate For ... And Empty(Codigos)` antes de inserir)
- [ ] Na celula "Caracteristica", digitar um codigo que EXISTE e dar ENTER/TAB ->
      preenche codigo e descricao sem abrir dialogo nenhum
- [ ] Digitar um codigo que NAO existe (ou apertar F4) -> abre a busca "Selecao"
      listando Codigo + Descricao, filtrada pelo grupo do produto
- [ ] Repetir pela celula "Descricao": a busca abre com as colunas na ordem
      INVERTIDA (Descricao + Codigo), como no legado
- [ ] Com a celula "Caracteristica" JA preenchida, tentar editar a "Descricao" da
      mesma linha -> o foco volta para "Caracteristica" (regra do When legado:
      a Descricao so eh editavel enquanto o Codigo estiver vazio)
- [ ] Escolher no picker uma caracteristica JA lancada em outra linha -> aviso
      "Caracteristica ja informada para este produto!" e a linha volta a ficar
      em branco (nada gravado)
- [ ] Dispensar o picker com ESC -> a linha volta a ficar em branco
- [ ] Selecionar a linha e clicar **Excluir** -> a linha desaparece da grade

### 3.3. Modo do form PAI = VISUALIZAR/CONSULTAR

- [ ] Inserir e Excluir **INVISIVEIS**
- [ ] O retangulo decorativo (Shape1) encolhe para abracar so o Encerrar
- [ ] As duas celulas da grade ficam READ-ONLY (nao aceitam digitacao)
- [ ] Encerrar continua habilitado

### 3.4. Encerrar

- [ ] Em ALTERAR/INCLUIR, deixar uma linha em branco e clicar **Encerrar** ->
      a linha em branco eh descartada (nao sobra registro vazio em `SigPrCar`)
- [ ] Limpar a caracteristica de uma linha que VEIO do banco e clicar Encerrar ->
      o registro correspondente eh EXCLUIDO de `SigPrCar`
- [ ] Ao fechar, o form PAI volta a ficar habilitado

### 3.5. Banco (PILAR 2)

- [ ] `SELECT * FROM SigPrCar WHERE cpros = '<produto>'` reflete exatamente o que
      a grade mostrava ao encerrar
- [ ] Cada inclusao/alteracao/exclusao gerou linha em `LogAuditoria`
- [ ] `pkchaves` de cada linha eh unico (nunca em branco)

## 4. O que ja foi verificado automaticamente (2026-09-26)

| Verificacao | Resultado |
|---|---|
| Compilacao do Form e do BO | limpa, sem `.err` |
| Instanciacao real no VFP9 (modo teste) | OK - 480x540, 2 colunas 150/290, MaxLength 20/40, Margin 0 |
| `HabilitarCampos(.F.)` | trancou as 2 colunas e Inserir/Excluir; Encerrar seguiu habilitado |
| `HabilitarCampos(.T.)` | destrancou tudo |
| `BtnInserirClick()` | criou 1 linha com `cpros` preenchido e `pkchaves` gerado |
| `FormParaBO` / `BOParaForm` / `LimparCampos` | round-trip linha -> BO -> linha OK; sem cursor devolvem `.F.` sem estourar |
| Regras do CLAUDE.md | sem `RETURN` dentro de `TRY`, sem acento literal, sem `MESSAGEBOX`/`ISEMPTY`/`.Self`/`Controls("nome")` |
| Colunas NOT NULL do INSERT (regra #22) | as 3 de `SigPrCar` (codigos/cpros/pkchaves) estao cobertas |
| Completude (TODO/stub/procedure vazia) | nenhum problema |
| `ValidarUIFidelity` | 4 DIFERENCA + 6 AVISO (era 9 + 6) - ver item 4.1 |

### 4.1. Validacao de UI - o que sobrou e por que

Relatorio: `projeto\app\utils\relatorios\UIFidelity_FormSigPrCar_20260926082129.html`

Foram CONSERTADOS nesta fase (eram diferencas reais):

| Objeto | Propriedade | Conserto |
|---|---|---|
| `SIGPRCAR` | `Themes` | o SCX declara `.F.` e a classe usava o default `.T.` - transcrito |
| `SIGPRCAR` | `Picture` | o `ValidarUIFidelity.prg` nao declarava `gc_4c_CaminhoFramework` (nao roda `config.prg`) - a global agora eh declarada la, junto de `gc_4c_CaminhoIcones` |
| `cntSombra` | `Width` | 800 literal do SCX no lugar de `THIS.Width` |
| `lblSombra` / `lblTitulo` | `Width` | 769 literal do SCX (= 800 - 31) |

**Sobraram 4 DIFERENCA, todas do mesmo tipo: o comparador le o valor de DESENHO
no SCX e compara com o valor de RUNTIME do form migrado - e nos quatro casos eh o
proprio `Init` do LEGADO que muda esse valor.** Nao ha conserto possivel no form
sem mentir para o usuario:

| # | Objeto / Prop | SCX (desenho) | Migrado (runtime) | Por que o migrado esta certo |
|---|---|---|---|---|
| 1-2 | `lblSombra.Caption` e `lblTitulo.Caption` | `Cadastro de Testes` | `Caracteristicas do Produto` | o Caption no SCX eh um PLACEHOLDER esquecido de copiar-e-colar; o `Init` legado faz `ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption`, entao **o legado em execucao tambem mostra "Caracteristicas do Produto"**. Gravar "Cadastro de Testes" poria um titulo ERRADO na tela. |
| 3-4 | `Shape1.Left` e `Shape1.Width` | 239 / 250 | 400 / 85 | o `Init` legado tem `If Not llVis / .Shape1.Width = .cmdSair.Width + 10 / .Shape1.Left = .cmdSair.Left - 5`. O validador instancia SEM parametros, logo o modo cai em CONSULTAR (o mesmo default do legado: `Iif(Type(...)='C', ..., [CONSULTAR])`) e o retangulo encolhe - **exatamente o que o legado faz nesse modo**. |

Os 6 AVISO (`Column1/Column2.FontName/FontSize/Width` como "propriedade nao
existe") sao limitacao do comparador com sub-propriedade pontuada de `Grid`: o
form DEFINE as seis (`ConfigurarGrid`), e a instanciacao confirmou 150/290 e
Tahoma 8. AVISO nao bloqueia o gate.

**DECISAO NECESSARIA (do time):** o gate `07_validarUI` reprova com
`diferencas > 0`. Como as 4 restantes sao artefato de "desenho x runtime",
ha duas saidas, e a escolha nao eh deste form:
1. aceitar as 4 como conhecidas para este form; ou
2. ensinar o `ComparadorUI.prg` a PULAR a propriedade quando o `Init` do proprio
   dump legado a reatribui (ele ja tem normalizacoes desse tipo - nome de arquivo
   em `Picture`, `new_background.jpg` <-> `fundo_cad_1003.jpg`, hotkey em
   `Caption`, Caption dinamica `(expr)`). Mexe na semantica do gate para ~500
   forms, entao NAO foi feito por conta propria.

## 5. LACUNA DE INTEGRACAO (fora do escopo desta task - decidir com o time)

O botao que abre este dialogo **nao existe no `FormProduto` migrado**. No legado:

```foxpro
* SIGCDPRO.Pagina.Dados.pgframeDados.pgDados.cmdCaracts
PROCEDURE btnCaracts.Valid
Do Form SigPrCar With ThisForm
```

O mesmo vale para o dialogo IRMAO de Tamanhos (`SigPrTam` -> `Formsigprtam`, ja
migrado): tambem nao esta ligado ao `FormProduto`. Ou seja, a lacuna eh
**sistemica da familia de dialogos filhos do Cadastro de Produtos**, nao deste
form. Ligar os dois exige editar `FormProduto.prg` (aba pgDados, CommandGroups
`cmdCaracts` e `cmdTamanho`) - trabalho que pertence a task do FormProduto.

Por isso tambem **NAO foi criada entrada de menu**: o dialogo nao funciona sem um
produto. Eh a mesma decisao ja tomada para o `Formsigprtam`, que tambem nao tem
entrada de menu.

## 6. DIVERGENCIA DELIBERADA DO LEGADO (conferir se eh aceitavel)

| | Legado | Migrado |
|---|---|---|
| Quem grava | o `TABLEUPDATE` do form PAI sobre o cursor compartilhado `crSigPrCar` | o proprio dialogo, via `SigPrCarBO`, NA HORA |
| Efeito de Cancelar no PAI | as caracteristicas lancadas no dialogo eram DESCARTADAS | as caracteristicas **ja estao gravadas** e permanecem |

Motivo: o form migrado tem `DataSession = 2` (privada) e BO proprio - nao ha
cursor compartilhado com o pai para o pai persistir. **Consequencia a validar com
o usuario:** incluir uma caracteristica e depois cancelar a alteracao do PRODUTO
deixa a caracteristica gravada. Se isso for inaceitavel, o conserto nao eh neste
form: eh compartilhar o cursor com o `FormProduto` (o dialogo passa a so mexer no
cursor e o `FormProduto.Salvar` persiste), o que precisa ser decidido junto com a
integracao do item 5.

## 7. Resultado do Teste

- [ ] UI Fidelity: **APROVADO / REPROVADO**
- [ ] Inserir + lookup por Codigo: **APROVADO / REPROVADO**
- [ ] Inserir + lookup por Descricao: **APROVADO / REPROVADO**
- [ ] Bloqueio de duplicidade: **APROVADO / REPROVADO**
- [ ] Excluir: **APROVADO / REPROVADO**
- [ ] Encerrar (descarte de linha em branco): **APROVADO / REPROVADO**
- [ ] Modo VISUALIZAR (botoes ocultos, grade read-only): **APROVADO / REPROVADO**
- [ ] Banco + auditoria: **APROVADO / REPROVADO**

### Problemas Encontrados

1.
2.
3.

### Aprovacao

- [ ] **APROVADO**
- [ ] **REPROVADO** - necessita correcoes

**Testador:** ___________________________
**Data:** ___________________________
