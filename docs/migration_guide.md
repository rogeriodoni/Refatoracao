# Migration Guide - Legacy Forms to New Architecture

## ⚠️ ERRO CRÍTICO MAIS COMUM - ESTRUTURA INCOMPLETA DO FORM

**PROBLEMA IDENTIFICADO**: Criar form apenas com campos (Page Dados), sem botões CRUD, sem lista (Page Lista), sem navegação entre páginas.

**SINTOMAS** (form abre mas não funciona):
- ❌ Não tem botões de Incluir, Alterar, Excluir, Consultar, Sair
- ❌ Não tem lista de registros (grid)
- ❌ Não tem botões Salvar/Cancelar
- ❌ Interface "vazia" ou "incompleta"
- ❌ Usuário não consegue usar o form

**CAUSA RAIZ**:
Form criado com apenas 1 página (Dados) e sem seguir o padrão completo do FormCargo.

**SOLUÇÃO OBRIGATÓRIA**:
Todo form de cadastro DEVE ter a estrutura completa do FormCargo:

```
PageFrame com 2 PÁGINAS (PageCount = 2):

  Page1 (Lista) - OBRIGATÓRIA:
    ✅ Container Cabeçalho com título
    ✅ Container Botões com 5 botões CRUD:
       - cmd_4c_Incluir (F2)
       - cmd_4c_Alterar (F3)
       - cmd_4c_Excluir (F4)
       - cmd_4c_Consultar (F5)
       - cmd_4c_Sair (ESC)
    ✅ Grid (grd_4c_Lista) para listar registros

  Page2 (Dados) - OBRIGATÓRIA:
    ✅ Todos os campos do formulário (TextBoxes, Labels)
    ✅ Container Botões com 2 botões:
       - cmd_4c_Salvar (F10)
       - cmd_4c_Cancelar (ESC)
    ✅ Lookups implementados com F4
```

**CHECKLIST OBRIGATÓRIO** (verificar ANTES de considerar form completo):

```
ESTRUTURA:
[ ] PageFrame com PageCount = 2
[ ] Page1.Caption = "Lista"
[ ] Page2.Caption = "Dados"

PAGE1 (LISTA):
[ ] Container cabeçalho (cnt_4c_Cabecalho)
[ ] Label título (lbl_4c_Titulo)
[ ] Container botões (cnt_4c_Botoes)
[ ] 5 botões CRUD (cmd_4c_Incluir, Alterar, Excluir, Consultar, Sair)
[ ] Grid de lista (grd_4c_Lista)

PAGE2 (DADOS):
[ ] Todos os campos (txt_4c_*, lbl_4c_*)
[ ] Container botões (cnt_4c_BotoesDados)
[ ] 2 botões (cmd_4c_Salvar, cmd_4c_Cancelar)

MÉTODOS:
[ ] ConfigurarPageFrame()
[ ] ConfigurarPaginaLista()
[ ] ConfigurarPaginaDados()
[ ] CarregarLista()
[ ] FormParaBO()
[ ] BOParaForm()
[ ] AlternarPagina(par_nPagina)
[ ] BtnIncluirClick(), BtnAlterarClick(), BtnExcluirClick()
[ ] BtnSalvarClick(), BtnCancelarClick()
```

**REFERÊNCIA OBRIGATÓRIA**:
- Sempre usar `FormCargo.prg` como modelo completo
- Copiar estrutura completa, depois adaptar campos específicos
- **NUNCA** criar form "do zero" sem seguir o padrão FormCargo

---

## Filosofia de Refatoracao (3 Pilares Inegociaveis)

**FUNDAMENTAL**: Este projeto eh uma refatoracao baseada em 3 pilares distintos que DEVEM ser seguidos rigorosamente:

```
+========================================================================+
|                       PILARES DA REFATORACAO                           |
+========================================================================+
|  1. UX (User Experience)    → MANTER O MAIS PROXIMO POSSIVEL          |
|  2. BANCO DE DADOS (Schema) → IDENTICO (exceto LogAuditoria)          |
|  3. CODIGO-FONTE/ARQUITETURA → OBRIGATORIAMENTE DIFERENTE             |
+========================================================================+
```

### PILAR 1: UX - User Experience

**O que o usuario ve e usa DEVE ser o mais proximo possivel do original.**

| Aspecto | Regra | Validacao |
|---------|-------|-----------|
| Interface Visual | Identica (cores, fontes, tamanhos, posicoes) | ValidarUIFidelity.prg |
| Comportamento | Identico (teclas F4/F5, Tab, validacoes) | Teste manual |
| Fluxo de Trabalho | Identico (sequencia de telas) | Teste manual |
| Mensagens | Similares (texto, tom, momento) | Teste manual |
| Performance | Similar ou melhor | Teste de carga |

### PILAR 2: Banco de Dados

**O schema DEVE permanecer IDENTICO ao original (exceto LogAuditoria).**

| Acao | Permitido? | Exemplo |
|------|------------|---------|
| Renomear tabelas | **NAO** | Manter SigCdCor, SigCdPro |
| Renomear colunas | **NAO** | Manter cgrus, dpros |
| Alterar tipos | **NAO** | Manter CHAR(20), NUMERIC(14,2) |
| Adicionar/remover colunas | **NAO** | - |
| Criar tabelas | **NAO** | Excecao: LogAuditoria |

**Justificativa**: O banco pode ter integracoes com outros sistemas.

### PILAR 3: Codigo-Fonte/Arquitetura

**O codigo interno DEVE ser completamente reescrito com nova arquitetura.**

| Aspecto | Legado (NAO usar) | Novo (USAR) |
|---------|------------------|-------------|
| Arquitetura | Monolitica (.SCX) | Camadas (Form/BO/DataAccess) |
| Classes | Sigcdcor, frmcadastro | FormCor, FormBase |
| Objetos | Text1, Command1 | txt_4c_Codigo, cmd_4c_Salvar |
| Variaveis | lcCod, pVal | loc_cCodigo, par_nValor |
| Arquivos | Tudo em 1 .SCX | Separado (.prg) |

**Justificativa**: Melhorar manutencao, legibilidade e escalabilidade.

### Resumo dos 3 Pilares

| Pilar | Regra | Como Validar |
|-------|-------|--------------|
| 1. UX | Manter o mais proximo possivel | ValidarUIFidelity.prg + teste manual |
| 2. Banco | IDENTICO (exceto LogAuditoria) | docs/schema.sql |
| 3. Codigo | OBRIGATORIAMENTE diferente | Code review (camadas, nomenclatura) |

---

## UI Fidelity Requirements (PILAR 1 - CRITICAL)

**A interface do usuario DEVE ser o mais proxima possivel do sistema legado.** Estamos refatorando apenas as camadas internas (arquitetura, codigo, organizacao), mas a experiencia visual do usuario deve permanecer EXATAMENTE a mesma.

### O que DEVE ser preservado:

| Elemento | Detalhes |
|----------|----------|
| **Cores** | BackColor, ForeColor de todos os controles (usar RGB exato) |
| **Tamanhos** | Width, Height de forms, controles, grids |
| **Posicoes** | Left, Top de cada controle (layout identico) |
| **Fontes** | FontName, FontSize, FontBold, FontItalic |
| **Bordas** | BorderStyle, BorderColor, SpecialEffect |
| **Espacamentos** | Distancia entre controles, margens |
| **Abas/Paginas** | Estrutura de PageFrames, ordem das abas |
| **Icones** | Mesmos icones nos botoes (usar pasta vbmp\) |
| **Comportamento** | Ordem de tabulacao, teclas de atalho (F4, F5, etc.) |

### Problemas Identificados (NAO REPETIR)

Estes erros foram encontrados em migracoes anteriores e **NAO devem ocorrer novamente**:

| Formulario | Problema | Causa | Como Evitar |
|------------|----------|-------|-------------|
| FormCargo | Botao "comido" (fora da area visivel) | Width/Height do form incorreto | Copiar Width/Height EXATO do original |
| FormDepartamento | Botoes fora do padrao em modo consulta | AjustarBotoesPorModo() incorreto | Seguir padrao frmcadastro (Confirmar disabled, Cancelar enabled) |
| FormPlanoContas | Cores e fonte diferentes | RGB e FontSize nao copiados | Copiar BackColor, ForeColor, FontName, FontSize EXATOS |
| FormCor | Falta barra de imagem superior | Picture/Image nao adicionado | Verificar todos os objetos visuais (Picture, Image, Shape) |
| FormProduto | Topo do formulario cortado | Height ou Top incorreto | Verificar Height do form e Top dos controles |

### Processo OBRIGATORIO de Verificacao Visual

**ANTES de considerar a migracao completa**, executar este checklist:

```
VERIFICACAO VISUAL OBRIGATORIA:
[ ] 1. Comparar Width/Height do form com original (EXATO)
[ ] 2. Comparar Top/Left de TODOS os controles (EXATO)
[ ] 3. Verificar BackColor/ForeColor de form e controles (RGB EXATO)
[ ] 4. Verificar FontName/FontSize de TODOS os controles (EXATO)
[ ] 5. Verificar se TODOS os botoes estao visiveis (nenhum "comido")
[ ] 6. Verificar espacamento entre botoes (EXATO)
[ ] 7. Verificar se Picture/Image do form esta presente
[ ] 8. Verificar se topo do form NAO esta cortado
[ ] 9. Testar TODOS os modos (INCLUIR, ALTERAR, VISUALIZAR)
[ ] 10. Comparar visualmente lado-a-lado com screenshot original
```

**NAO APROXIMAR, NAO ESTIMAR, NAO "AJUSTAR" - COPIAR EXATO!**

### Como extrair propriedades visuais do legado:

```foxpro
* No codigo fonte extraido (.txt), procurar EXATAMENTE por:
Width = XXX
Height = XXX
Top = XXX
Left = XXX
BackColor = RGB(XXX, XXX, XXX)
ForeColor = RGB(XXX, XXX, XXX)
FontName = "..."
FontSize = XXX
BorderStyle = XXX
SpecialEffect = XXX
Picture = "..."
```

## Pre-Migration Analysis (MANDATORY)

Before writing any code, analyze the source form completely:

### 1. Field Analysis
```foxpro
* Search for all ControlSource bindings in the source code:
* Pattern: ControlSource = "cursorName.fieldName"
* Example: ControlSource = "crSigCdPro.cgrus"

* For each field, identify:
* - Field name in database
* - Data type (C=char, N=numeric, D=date, L=logical, M=memo)
* - Size/precision
* - Required or optional
* - Default value
```

### 2. Field Type Classification
| VFP Type | Database Type | BO Property Prefix | Form Control | SQL Formatting |
|----------|---------------|-------------------|--------------|----------------|
| Character | VARCHAR | this_c | TextBox (.Value="") | EscaparSQL() |
| Numeric | NUMERIC/DECIMAL | this_n | TextBox (.Value=0) | FormatarNumeroSQL() |
| Date | DATE/DATETIME | this_d | TextBox | FormatarDataSQL() |
| Logical | BIT/INT | this_l | CheckBox | IIF(.T.,"1","0") |
| Memo | TEXT/NVARCHAR(MAX) | this_c | EditBox | EscaparSQL() |

### 3. Lookup/Validation Analysis (CRÍTICO - NÃO PULAR!)

**IMPORTANTE**: Antes de codificar, identificar TODOS os lookups no código extraído. Se um campo tem lookup no original, DEVE ter no novo.

#### 🔍 PADRÕES DE LOOKUP NO CÓDIGO LEGADO (Procurar por ESTES exatamente)

**Padrão 1: fwBuscaExt (SQL Server search) - MAIS COMUM**
```foxpro
PROCEDURE Valid
Local loLista
If Not Empty(This.Value)
    loLista = CreateObject('fwbuscaext', ThisForm.poDataMgr.pnIdConn, 'SigCdTqe', 'CrListaRemota', 'codigos', This.Value, 'Seleção', .t.)
    If Not loLista.plAchouRegistro
        loLista.mAddColuna('codigos', '', 'Código')
        loLista.mAddColuna('descrs',  '', 'Descrição')
        loLista.Show()
    EndIf
EndIf
ENDPROC
```
**Como identificar**: Procurar por `CreateObject('fwbuscaext'` no código extraído
**Tabela lookup**: Terceiro parâmetro ('SigCdTqe')
**Campo código**: Quinto parâmetro ('codigos')
**Campo descrição**: Dentro de `mAddColuna` ('descrs')

**Padrão 2: fwBuscaSel (Local cursor search)**
```foxpro
PROCEDURE Valid
Local loLista
If Not Empty(This.Value)
    loLista = CreateObject('fwBuscaSel', 'cursor_local', 'campo_codigo', This.Value, 'Título', .t.)
    loLista.mAddColuna('campo_codigo', '', 'Código')
    loLista.Show()
EndIf
ENDPROC
```
**Como identificar**: Procurar por `CreateObject('fwBuscaSel'` no código extraído

**Padrão 3: SIGACESS (Função legada - MENOS COMUM)**
```foxpro
PROCEDURE KeyPress
LPARAMETERS nKeyCode, nShiftAltCtrl
If nKeyCode = 286  && F4
    Local lcRetorno
    lcRetorno = sigacess("SigCdGrp", "cgrus", "dgrus", "", "", .F.)
    If !Empty(lcRetorno)
        This.Value = lcRetorno
    EndIf
EndIf
ENDPROC
```
**Como identificar**: Procurar por `sigacess(` ou `SIGACESS(` no código extraído
**Tabela lookup**: Primeiro parâmetro ("SigCdGrp")
**Campo código**: Segundo parâmetro ("cgrus")
**Campo descrição**: Terceiro parâmetro ("dgrus")

**Padrão 4: Classes customizadas de TextBox**
```foxpro
Objeto: Get_Grupo
  Parent: SIGCDPRO.Pagina.Dados
  Class: TextBoxBuscaGrupo  && <-- CLASSE CUSTOMIZADA COM LOOKUP EMBUTIDO
  BaseClass: textbox
```
**Como identificar**: Verificar na seção "SECAO 1: ESTRUTURA DO FORMULARIO" se a Class NÃO é "fwget" ou "textbox" padrão
**Ação**: Procurar código dessa classe no Framework\framework.vcx ou .txt

#### 📝 COMO PROCURAR NO CÓDIGO EXTRAÍDO

**PASSO 1: Abrir arquivo .txt no Notepad++**
```bash
notepad tasks\taskX\ARQUIVO_form_codigo_fonte.txt
```

**PASSO 2: Buscar (Ctrl+F) por ESTES padrões (um de cada vez):**
```
1. fwbuscaext        (case-insensitive)
2. fwBuscaSel        (case-insensitive)
3. sigacess(         (case-insensitive)
4. CreateObject(     (case-insensitive) - depois verificar se é lookup
5. PROCEDURE Valid   (case-sensitive) - depois ver se tem lookup dentro
6. PROCEDURE KeyPress (case-sensitive) - depois ver se é F4/F5
```

**PASSO 3: Para cada match, anotar na tabela:**

| Campo | Tabela Lookup | Campo Código | Campo Descrição | Padrão | Implementado |
|-------|---------------|--------------|-----------------|--------|--------------|
| getTanque | SigCdTqe | codigos | descrs | fwbuscaext (Valid) | [ ] |
| Get_Grupo | SigCdGrp | cgrus | dgrus | sigacess (KeyPress F4) | [ ] |

**PASSO 4: NO NOVO SISTEMA, implementar TODOS usando FormBuscaAuxiliar**

```foxpro
* Mesmo que o original use fwbuscaext ou sigacess,
* NO NOVO SISTEMA usar FormBuscaAuxiliar (padrão unificado)
```

#### ⚠️ ARMADILHAS COMUNS (Não cair!)

❌ **ERRADO**: "Não vi SIGACESS, então não tem lookup"
✅ **CORRETO**: Procurar por TODOS os padrões (fwbuscaext, fwBuscaSel, sigacess, classes customizadas)

❌ **ERRADO**: "O campo referencia outra tabela, mas não tem código de lookup, então não preciso"
✅ **CORRETO**: Se referencia outra tabela (FK), provavelmente tinha lookup que foi perdido. Verificar com usuário.

❌ **ERRADO**: "Valid só valida S/N, não é lookup"
```foxpro
PROCEDURE Valid
Return Inlist(This.Value,"S","N"," ")  && Isto é VALIDAÇÃO, não lookup
ENDPROC
```
✅ **CORRETO**: Apenas validação. Lookup tem CreateObject ou sigacess.

#### 📋 CHECKLIST DE VERIFICAÇÃO

Antes de começar a codificar o Form:

```
[ ] Procurei por "fwbuscaext" no código extraído (case-insensitive)
[ ] Procurei por "fwBuscaSel" no código extraído (case-insensitive)
[ ] Procurei por "sigacess(" no código extraído (case-insensitive)
[ ] Procurei por "CreateObject(" e verifiquei cada um
[ ] Procurei por "PROCEDURE Valid" e verifiquei cada um
[ ] Procurei por "PROCEDURE KeyPress" e verifiquei se tem F4/F5
[ ] Anotei TODOS os lookups encontrados na tabela
[ ] Confirmei campos que referenciam outras tabelas (FK)
```

#### 📊 EXEMPLO COMPLETO (FormCor - task1)

**Código extraído**: `tasks\task1\SIGCDCOR_form_codigo_fonte.txt`

**Buscas realizadas**:
```
1. "fwbuscaext" → ENCONTRADO 1 match (getTanque)
2. "fwBuscaSel" → NENHUM match
3. "sigacess(" → NENHUM match
4. "PROCEDURE Valid" → ENCONTRADOS 2 (getTanque=lookup, Get_TpCor=validação)
```

**Tabela de Lookups**:
| Campo | Tabela Lookup | Campo Código | Campo Descrição | Padrão | Implementado |
|-------|---------------|--------------|-----------------|--------|--------------|
| getTanque | SigCdTqe | codigos | descrs | fwbuscaext (Valid) | [ ] |

**Get_TpCor**: NÃO é lookup (apenas validação S/N)

---

**REGRA DE OURO**: Se tem dúvida se é lookup, procurar por `CreateObject` ou `sigacess` no método. Se não tem, é apenas validação.

### 4. Event Mapping
| Original Event | New Implementation |
|----------------|-------------------|
| Valid | BINDEVENT or custom TextBox class |
| LostFocus | BINDEVENT(control, "LostFocus", ...) |
| KeyPress F4/F5 | BINDEVENT + check nKeyCode = 63/64 |
| DblClick | BINDEVENT(control, "DblClick", ...) |
| Click (button) | BINDEVENT(button, "Click", ...) |

## Migration Requirements (Baseado nos 3 Pilares)

### PILAR 1 - UX (Manter o Mais Proximo Possivel)
1. **Visual layout matches** - Field positions, tabs structure EXATAS
2. **All functionality preserved** - Buttons, validations, lookups, calculations
3. **Behavior identical** - F4/F5 lookups, Tab order, keyboard shortcuts

### PILAR 2 - Banco de Dados (IDENTICO)
1. **Use exact table/column names** - SigCdCor, cgrus, dpros (NAO renomear)
2. **No schema changes** - NAO adicionar/remover/alterar colunas
3. **Reference docs/schema.sql** - Consultar schema antes de SQL

### PILAR 3 - Codigo-Fonte (OBRIGATORIAMENTE DIFERENTE)
1. **Layered architecture** - Form/BO/DataAccess (NAO monolitico)
2. **New class names** - FormCor, CorBO (NAO Sigcdcor)
3. **New object names** - txt_4c_Codigo (NAO Text1)
4. **New variable names** - loc_cCodigo (NAO lcCod)
5. **Separate files** - FormCor.prg, CorBO.prg (NAO tudo em .SCX)

## Migration Checklist

**IMPORTANTE**: Antes de escrever QUALQUER código, preencher a tabela de lookups abaixo.
Se um campo tem lookup no sistema antigo, DEVE ter lookup no novo.

### Tabela de Lookups (OBRIGATÓRIO preencher antes de codificar)

```
| Campo      | Tabela Lookup | Campo Codigo | Campo Descricao | Implementado |
|------------|---------------|--------------|-----------------|--------------|
| (exemplo)  | SigCdTqe      | codigos      | descrs          | [ ]          |
```

Identificar lookups procurando no código fonte:
- Classes customizadas de TextBox (ex: `TextBoxBuscaTanque`)
- `CreateObject('fwBuscaSel'` ou `CreateObject('fwBuscaExt'`
- `PROCEDURE Valid()` dentro de TextBox
- Campos que referenciam outras tabelas (FK)

### Complete Checklist

```
VALIDACAO DOS 3 PILARES (OBRIGATORIO):
[ ] PILAR 1 - UX: Copiar propriedades visuais EXATAS (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize)
[ ] PILAR 1 - UX: Executar ValidarUIFidelity.prg ANTES de commit
[ ] PILAR 2 - BANCO: Usar nomes EXATOS de tabelas/colunas (SigCdCor, cgrus, dpros)
[ ] PILAR 2 - BANCO: NAO adicionar/remover colunas
[ ] PILAR 3 - CODIGO: Usar arquitetura em camadas (Form/BO/DataAccess)
[ ] PILAR 3 - CODIGO: Usar novos nomes de classes (FormCor, CorBO)
[ ] PILAR 3 - CODIGO: Usar sufixo _4c_ em objetos (txt_4c_Codigo)
[ ] PILAR 3 - CODIGO: Usar prefixos em variaveis (loc_, par_, this_)

PRE-MIGRATION:
[ ] Codigo fonte extraido e analisado
[ ] Todos os campos identificados e tipados
[ ] **TABELA DE LOOKUPS PREENCHIDA** (acima)
[ ] Eventos mapeados

BUSINESS OBJECT:
[ ] Todas as propriedades declaradas com tipo correto (this_c, this_n, this_d, this_l)
[ ] CarregarDoCursor usando TratarNulo e ConverterParaLogico
[ ] Inserir/Atualizar usando FormatarNumeroSQL e FormatarDataSQL
[ ] EscaparSQL para todos os campos texto
[ ] Validacoes implementadas
[ ] **LISTAR todas as propriedades this_* para referencia no Form**

MAPEAMENTO BO <-> FORM (CRITICO):
[ ] Criar tabela de mapeamento ANTES de codificar FormParaBO/BOParaForm:

| Campo Form | Propriedade BO | Tipo | Existe no BO? |
|------------|----------------|------|---------------|
| txt_4c_Codigo | this_cCodigo | C | [x] |
| txt_4c_ValorCusto | this_nCusto | N | [x] |
| (preencher para TODOS os campos) |

[ ] Verificar CADA propriedade com grep no arquivo BO
[ ] NAO inventar nomes - usar EXATAMENTE o que esta declarado no BO

FORMULARIO:
[ ] Todos os TextBox inicializados (.Value = "" ou .Value = 0)
[ ] PageFrame.Visible = .T. apos AddObject
[ ] TornarControlesVisiveis percorre Pages E Controls
[ ] Lookups com BINDEVENT para KeyPress/DblClick
[ ] FormParaBO e BOParaForm completos (ver verificacao abaixo)
[ ] HabilitarCampos inclui TODOS os controles editaveis

VERIFICACAO DE COMPLETUDE (FormParaBO/BOParaForm/HabilitarCampos):
[ ] Contar propriedades this_ no BO
[ ] Contar campos mapeados em FormParaBO - DEVE SER IGUAL
[ ] Contar campos mapeados em BOParaForm - DEVE SER IGUAL
[ ] Contar controles em HabilitarCampos - DEVE INCLUIR TODOS
[ ] **VALIDAR NOMES**: Cada .this_xxx em FormParaBO/BOParaForm DEVE existir no BO

REGRA CRITICA - Validacao de Propriedades BO:
Antes de usar qualquer propriedade .this_xxx em FormParaBO ou BOParaForm:
1. Abrir o arquivo [Entidade]BO.prg
2. Buscar pela propriedade EXATA (ex: grep "this_nCusto" no BO)
3. Se nao existir, NAO INVENTAR - usar apenas propriedades declaradas
4. Nomes comuns que geram erro:
   - this_nCustoFinal (ERRADO) -> this_nCusto (CORRETO)
   - this_nValorTotal (ERRADO) -> verificar nome real no BO
   - this_cDescricaoProduto (ERRADO) -> this_cDescricao (CORRETO)

TESTES:
[ ] Novo registro - campos em branco salvam corretamente
[ ] Edicao - todos os campos carregam e salvam
[ ] Exclusao - verificacoes de dependencia funcionam
[ ] Lookups - F4/DblClick abrem busca correta
[ ] Validacoes - campos obrigatorios bloqueiam salvamento
```

## Migracoes Complexas (Formularios Multi-Aba)

### Diretrizes para Formularios com Multiplas Abas

Formularios complexos podem ter centenas de objetos. A migracao deve ser **COMPLETA** e **FIEL** ao original.

### Processo de Analise Pre-Migracao

1. **Identificar estrutura de PageFrames**:
   - Contar quantas abas existem
   - Mapear nome interno vs caption de cada aba
   - Documentar PageCount, Top, Left, Width, Height do PageFrame

2. **Listar TODOS os objetos de cada aba**:
   - Grids: nome, colunas, headers, posicao
   - Containers: nome, controles filhos
   - Botoes: CommandGroups, CommandButtons
   - Campos: TextBox, ComboBox, CheckBox

3. **Criar mapa de componentes por aba**:

```
| Aba | Nome Interno | Caption | Objetos Principais |
|-----|--------------|---------|-------------------|
| 1   | pgDados      | Dados Principais | campos basicos |
| 2   | pgComposicao | Custos | grdCompo(14col), GradeGRUPO(3col) |
| 3   | pgDadosFiscais | Dados Fiscais | grdCmv, campos ICMS/IPI |
| ... | ... | ... | ... |
```

### Padrao de Implementacao por Aba

Cada aba deve ter seu proprio metodo de configuracao:

```foxpro
* Estrutura padrao de configuracao de aba
PROTECTED PROCEDURE ConfigurarAbaXxx()
    LOCAL loc_oAba
    loc_oAba = THIS.pgf_4c_Principal.Page2.pgf_4c_Abas.PageN

    *-- 1. Grids (na ordem do legado)
    THIS.ConfigurarGridXxx(loc_oAba)

    *-- 2. Containers com campos
    THIS.ConfigurarContainerXxx(loc_oAba)

    *-- 3. Campos soltos
    THIS.AdicionarLabel(loc_oAba, ...)
    THIS.AdicionarTextBox(loc_oAba, ...)

    *-- 4. Botoes de acao
    THIS.ConfigurarBotoesXxx(loc_oAba)

    *-- 5. BINDEVENTs
    BINDEVENT(loc_oAba.txt_4c_Campo, "LostFocus", THIS, "ValidarCampo")
ENDPROC
```

### Verificacao de Completude por Aba

Antes de considerar uma aba completa, verificar:

```
ABA X - [Nome]:
[ ] Todos os Labels criados com posicoes do legado
[ ] Todos os TextBox criados com InputMask do legado
[ ] Todos os Grids criados com colunas e headers do legado
[ ] Todos os Containers criados com controles filhos
[ ] Todos os CommandGroups criados com botoes
[ ] Todos os ComboBox criados com RowSource
[ ] BINDEVENTs para lookups (F4, DblClick, LostFocus)
[ ] BINDEVENTs para botoes (Click)
[ ] Metodos de carga de dados do grid
[ ] Metodos de validacao
```

## Common Migration Errors

| Erro | Causa | Solução |
|------|-------|---------|
| "converting varchar to numeric" | TRANSFORM() com SET POINT | Usar FormatarNumeroSQL() |
| "converting varchar to numeric" em lookup | Campo codigo eh numerico no BD | Usar CAST(campo AS VARCHAR) no WHERE |
| "Operator/operand type mismatch" | Campo boolean C vs N | Usar ConverterParaLogico() |
| "Function argument type mismatch" | TextBox.Value = .F. | Inicializar .Value = "" |
| Controles invisiveis | PageFrame aninhado | Percorrer Pages() alem de Controls() |
| Lookup nao abre | Evento nao vinculado | BINDEVENT para KeyPress/DblClick |
| **Campo sem lookup (deveria ter)** | Nao analisou fonte original | **Preencher tabela de lookups ANTES de codificar** |
| Campos nao salvam/carregam | FormParaBO ou BOParaForm incompleto | Contar propriedades BO vs campos mapeados |
| Campo sempre desabilitado | HabilitarCampos incompleto | Verificar se controle esta na lista |
| **"Property THIS_XXX is not found"** | Nome de propriedade inventado/errado | **Verificar nome EXATO no [Entidade]BO.prg** |
| "Unknown member XXX" | Campo do form foi removido mas ainda referenciado | Atualizar FormParaBO/BOParaForm/LimparCampos |
| Campo S/N aceita qualquer letra | InputMask = "!" ao inves de "S,N, " | Usar `InputMask = "S,N, "` |
| Codigo de barras aceita letras | InputMask = "!" ao inves de numerico | Usar `InputMask = "99999999999999"` |
| Botao OK nao aparece no VISUALIZAR | IrParaDados() sobrescreve modo | Remover `this_cModoAtual = "DADOS"` |
| Lista vazia apos clicar OK | BtnOKClick() nao recarrega lista | Chamar IrParaLista() ou CarregarLista() |
| **Botao "comido" (fora da area visivel)** | Width/Height do form incorreto | **Copiar Width/Height EXATO do original** |
| **Botoes fora do padrao em modo consulta** | AjustarBotoesPorModo() incorreto | **Confirmar disabled, Cancelar enabled no modo VISUALIZAR** |
| **Cores e fonte diferentes** | RGB e FontSize nao copiados | **Copiar BackColor, ForeColor, FontName, FontSize EXATOS** |
| **Falta barra de imagem superior** | Picture/Image nao adicionado | **Verificar TODOS os objetos visuais (Picture, Image, Shape)** |
| **Topo do formulario cortado** | Height ou Top incorreto | **Verificar Height do form e Top dos controles** |

## Validacao Final dos 3 Pilares (OBRIGATORIO Antes de Commit)

## Validacao Final dos 3 Pilares (OBRIGATORIO Antes de Commit)

Antes de considerar a migracao completa e fazer commit, VALIDAR os 3 pilares:

### Checklist de Validacao Final

```
PILAR 1 - UX (User Experience):
[ ] Executar ValidarUIFidelity.prg e obter 0 diferencas
    CD C:\4c\projeto\app\utils
    DO ValidarUIFidelity WITH "taskX\ARQUIVO_codigo_fonte.txt", "FormEntidade"
[ ] Testar todos os modos: INCLUIR, ALTERAR, VISUALIZAR, EXCLUIR
[ ] Testar teclas de atalho: F4/F5 (lookups), Tab (navegacao)
[ ] Comparar visualmente lado-a-lado com screenshot original
[ ] Verificar que NENHUM botao esta "comido" (fora da area visivel)
[ ] Verificar que NENHUM topo esta cortado
[ ] Verificar cores EXATAS (BackColor, ForeColor)
[ ] Verificar fontes EXATAS (FontName, FontSize)

PILAR 2 - Banco de Dados:
[ ] Verificar que SQLs usam nomes EXATOS de tabelas (SigCdCor, NAO Cores)
[ ] Verificar que SQLs usam nomes EXATOS de colunas (cgrus, NAO codigo_grupo)
[ ] Verificar que NAO ha ALTER TABLE, CREATE TABLE (exceto LogAuditoria)
[ ] Verificar que NAO ha ADD COLUMN, DROP COLUMN
[ ] Consultar docs/schema.sql para confirmar tipos de dados

PILAR 3 - Codigo-Fonte/Arquitetura:
[ ] Verificar arquitetura em camadas: FormXxx.prg + XxxBO.prg + DataAccess
[ ] Verificar nome da classe: FormXxx (NAO Sigcdxxx)
[ ] Verificar nomes de objetos: txt_4c_Codigo (NAO Text1)
[ ] Verificar nomes de variaveis: loc_cCodigo (NAO lcCod)
[ ] Verificar prefixos obrigatorios: loc_, par_, this_
[ ] Verificar sufixo obrigatorio: _4c_ em objetos
[ ] Verificar que NAO ha codigo monolitico no Form
[ ] Verificar que Business Object tem TODAS as propriedades
[ ] Verificar que FormParaBO e BOParaForm estao COMPLETOS
```

### Criterios de Aprovacao

| Pilar | Criterio | Como Verificar |
|-------|----------|----------------|
| 1. UX | 0 diferencas no ValidarUIFidelity.prg | Executar script |
| 2. Banco | Nomes exatos, sem schema changes | Code review (grep "ALTER", "CREATE", "DROP") |
| 3. Codigo | Camadas, nomes novos, _4c_ | Code review (verificar classes, objetos, variaveis) |

### Consequencias de Nao Validar

| Pilar Violado | Consequencia |
|---------------|-------------|
| 1. UX | Usuario percebe diferenca, rejeita sistema novo |
| 2. Banco | Quebra integracoes, perde dados, corrompe sistema |
| 3. Codigo | Perde beneficios da refatoracao, dificil manutencao |

### Script de Validacao Rapida

```foxpro
*-- ValidacaoRapida.prg
*-- Executar ANTES de commit

LOCAL loc_lPilar1OK, loc_lPilar2OK, loc_lPilar3OK

? "===== VALIDACAO DOS 3 PILARES ====="
? ""

*-- PILAR 1: UX
? "PILAR 1 - UX:"
CD C:\4c\projeto\app\utils
loc_lPilar1OK = DO ValidarUIFidelity WITH "taskX\ARQUIVO.txt", "FormXxx"
? IIF(loc_lPilar1OK, "  [OK] 0 diferencas", "  [ERRO] Diferencas encontradas!")
? ""

*-- PILAR 2: Banco
? "PILAR 2 - BANCO:"
? "  [ ] Verificar manualmente: nomes exatos, sem schema changes"
? ""

*-- PILAR 3: Codigo
? "PILAR 3 - CODIGO:"
? "  [ ] Verificar manualmente: camadas, nomes novos, _4c_"
? ""

IF !loc_lPilar1OK
    ? "*** ATENCAO: PILAR 1 (UX) FALHOU ***"
    ? "Corrigir diferencas antes de commit!"
    RETURN .F.
ENDIF

? "===== VALIDACAO CONCLUIDA ====="
RETURN .T.
```

### Aprovacao Final

**Somente fazer commit se:**
1. ✅ PILAR 1: ValidarUIFidelity.prg retornou 0 diferencas
2. ✅ PILAR 2: Code review confirmou nomes exatos do banco
3. ✅ PILAR 3: Code review confirmou camadas, nomes novos, _4c_

**Caso contrario**: Retornar ao codigo e corrigir ANTES de commit.
