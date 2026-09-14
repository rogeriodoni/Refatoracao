# Guia: Como Refazer a Task1 do Zero

## Objetivo

Refazer a migração do FormCor completamente para:
- ✅ Validar que o processo documentado está correto
- ✅ Verificar que ValidarUIFidelity funciona corretamente
- ✅ Confirmar meta de 37 problemas
- ✅ Criar template para task2, task3, task4, task5, etc.

## Pré-Requisitos

- [ ] SQL Server rodando (192.168.15.101)
- [ ] Banco DB_MBAHIA acessível
- [ ] Visual FoxPro 9 instalado
- [ ] Código fonte original: `C:\4c\tasks\task1\SIGCDCOR_form_codigo_fonte.txt`

## Fase 0: Backup e Limpeza

### 0.1. Fazer Backup dos Arquivos Atuais

```bash
cd C:\4c
mkdir backup_task1_$(date +%Y%m%d_%H%M%S) 2>/dev/null || mkdir backup_task1

# Backup do FormCor atual
copy "projeto\app\forms\cadastros\FormCor.prg" "backup_task1\" 2>nul
copy "projeto\app\classes\CorBO.prg" "backup_task1\" 2>nul
copy "projeto\app\utils\mapeamentos\FormCor_mapeamento.json" "backup_task1\" 2>nul
```

**Ou manualmente no Windows Explorer:**
1. Copiar `C:\4c\projeto\app\forms\cadastros\FormCor.prg` para `C:\4c\backup_task1\`
2. Copiar `C:\4c\projeto\app\classes\CorBO.prg` para `C:\4c\backup_task1\`
3. Copiar `C:\4c\projeto\app\utils\mapeamentos\FormCor_mapeamento.json` para `C:\4c\backup_task1\`

### 0.2. Deletar Arquivos da Migração Atual

```foxpro
*-- No VFP9:
DELETE FILE C:\4c\projeto\app\forms\cadastros\FormCor.prg
DELETE FILE C:\4c\projeto\app\forms\cadastros\FormCor.fxp
DELETE FILE C:\4c\projeto\app\classes\CorBO.prg
DELETE FILE C:\4c\projeto\app\classes\CorBO.fxp
DELETE FILE C:\4c\projeto\app\utils\mapeamentos\FormCor_mapeamento.json
```

### 0.3. Remover do config.prg (Temporário)

Abrir `C:\4c\projeto\app\start\config.prg` e **comentar** as linhas:

```foxpro
*-- COMENTAR TEMPORARIAMENTE:
* SET PROCEDURE TO (gc_4c_CaminhoClasses + "CorBO.prg") ADDITIVE
* SET PROCEDURE TO (gc_4c_CaminhoForms + "cadastros\FormCor.prg") ADDITIVE
```

### 0.4. Limpar Arquivos .fxp Compilados

```foxpro
*-- No VFP9:
CD C:\4c\projeto\app
DELETE FILE *.fxp /S
```

### 0.5. Verificar Estado Limpo

```foxpro
*-- Deve dar erro "File does not exist":
? FILE("C:\4c\projeto\app\forms\cadastros\FormCor.prg")  && Deve retornar .F.
? FILE("C:\4c\projeto\app\classes\CorBO.prg")  && Deve retornar .F.
```

✅ **Checkpoint**: Arquivos deletados, ambiente limpo para começar do zero.

---

## Fase 1: Análise Pré-Migração (30 min)

Seguir: `C:\4c\docs\task1_guia_completo.md` - Fase 1

### 1.1. Verificar Código Fonte Original

```foxpro
? FILE("C:\4c\tasks\task1\SIGCDCOR_form_codigo_fonte.txt")  && Deve ser .T.
```

### 1.2. Analisar Estrutura Visual

Abrir o arquivo e procurar:
- **SECAO 2: PROPRIEDADES CUSTOMIZADAS** - propriedades visuais
- Identificar todos os controles (Say1, Say2, Get*, etc.)

### 1.3. Identificar Lookups

Procurar no código por:
- `SIGACESS(` - chamadas de lookup
- `F4` ou `F5` - teclas de atalho

**Resultado esperado**: Encontrar 1 lookup (F4 no campo Grupo).

### 1.4. Criar Tabela de Mapeamento de Campos

| Campo Original | Campo Novo | Tipo | InputMask | Lookup |
|----------------|------------|------|-----------|--------|
| Getcods | txt_4c_Codigo | CHAR(10) | !!!!!!!!!! | - |
| Getdescs | txt_4c_Descricao | CHAR(50) | - | - |
| Getvarias | txt_4c_Variacao | NUMERIC(14,2) | 9999.99 | - |
| Get_Grupo | txt_4c_Grupo | CHAR(10) | !!!!!!!!!! | F4: SigCdGru |
| Get_Peso | txt_4c_Peso | NUMERIC(14,2) | 9999.99 | - |
| Get_TpCor | txt_4c_TipoCor | CHAR(1) | ! | - |
| getDiasEnts | txt_4c_DiasEntrega | NUMERIC(3,0) | 999 | - |
| getTanque | txt_4c_Tanque | CHAR(10) | !!!!!!!!!! | - |

✅ **Checkpoint**: Estrutura analisada, mapeamento de campos criado.

---

## Fase 2: Criar Business Object (60 min)

Seguir: `C:\4c\docs\task1_guia_completo.md` - Fase 2

### 2.1. Criar Arquivo CorBO.prg

Criar arquivo: `C:\4c\projeto\app\classes\CorBO.prg`

Usar o código completo da seção **Fase 2.2** do guia task1.

**Pontos críticos**:
- ✅ Todas as 8 propriedades declaradas (this_cCodigo, this_cDescricao, etc.)
- ✅ Método CarregarDoCursor() com todos os campos
- ✅ Método Validar() com regras de negócio
- ✅ Método Inserir() com SQL INSERT
- ✅ Método Atualizar() com SQL UPDATE
- ✅ Método Excluir() com SQL DELETE
- ✅ Método ObterChavePrimaria() retornando this_cCodigo

### 2.2. Registrar no config.prg

Descomentar a linha em `C:\4c\projeto\app\start\config.prg`:

```foxpro
SET PROCEDURE TO (gc_4c_CaminhoClasses + "CorBO.prg") ADDITIVE
```

### 2.3. Testar CorBO Isoladamente

```foxpro
CD C:\4c\projeto\app\start
DO main.prg  && Carregar ambiente

*-- Testar instanciação
loBO = CREATEOBJECT("CorBO")
? TYPE("loBO") = "O"  && Deve ser .T.
? loBO.Name = "CorBO"  && Deve ser .T.

*-- Testar propriedades
loBO.this_cCodigo = "TEST001"
loBO.this_cDescricao = "Teste"
? loBO.this_cCodigo = "TEST001"  && Deve ser .T.

RELEASE loBO
```

✅ **Checkpoint**: CorBO.prg criado, registrado e testado.

---

## Fase 3: Criar FormCor.prg (120 min)

Seguir: `C:\4c\docs\task1_guia_completo.md` - Fase 3

### 3.1. Criar Arquivo FormCor.prg

Criar arquivo: `C:\4c\projeto\app\forms\cadastros\FormCor.prg`

Usar o código completo da seção **Fase 3** do guia task1.

**CRÍTICO - Propriedades Visuais Pixel-Perfect**:

```foxpro
DEFINE CLASS FormCor AS FormBase
    *-- COPIAR VALORES EXATOS DO ORIGINAL:
    Width = 1003        && NÃO aproximar!
    Height = 465        && NÃO aproximar!
    Caption = "Cadastro de Cores"

    *-- Business Object
    this_oBusinessObject = .NULL.
    this_cEntidade = "SigCdCor"
    this_cCampoChave = "ccors"

    PROCEDURE Init()
        DODEFAULT()
        THIS.this_oBusinessObject = CREATEOBJECT("CorBO")
        THIS.ConfigurarFormulario()
        RETURN .T.
    ENDPROC

    *-- ... resto do código conforme guia
ENDDEFINE
```

### 3.2. Implementar ConfigurarFormulario()

**Pontos críticos**:
- ✅ Adicionar PageFrame (pgf_4c_Principal)
- ✅ Adicionar Page "Dados" (Page2)
- ✅ Adicionar todos os 8 campos com Width/Height/Top/Left EXATOS
- ✅ Copiar BackColor, ForeColor, FontName, FontSize do original
- ✅ Aplicar InputMask correto em cada campo

### 3.3. Implementar Lookups (F4)

```foxpro
PROCEDURE ConfigurarLookups()
    *-- Lookup de Grupo (F4)
    BINDEVENT(THIS.pgf_4c_Principal.Page2.txt_4c_Grupo, "KeyPress", THIS, "LookupGrupo")
ENDPROC

PROCEDURE LookupGrupo(nKeyCode, nShiftAltCtrl)
    IF nKeyCode = 286  && F4
        LOCAL loc_cRetorno
        loc_cRetorno = sigacess("SigCdGru", "cgrus", "dgrus", "", "", .F.)

        IF !EMPTY(loc_cRetorno)
            THIS.pgf_4c_Principal.Page2.txt_4c_Grupo.Value = loc_cRetorno
            THIS.pgf_4c_Principal.Page2.txt_4c_Grupo.SetFocus()
        ENDIF
    ENDIF
ENDPROC
```

### 3.4. Implementar FormParaBO() e BOParaForm()

**CRÍTICO**: Mapear TODOS os 8 campos:

```foxpro
PROCEDURE FormParaBO()
    LOCAL loc_oPagina
    loc_oPagina = THIS.pgf_4c_Principal.Page2

    THIS.this_oBusinessObject.this_cCodigo = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
    THIS.this_oBusinessObject.this_cDescricao = ALLTRIM(loc_oPagina.txt_4c_Descricao.Value)
    THIS.this_oBusinessObject.this_nVariacao = loc_oPagina.txt_4c_Variacao.Value
    THIS.this_oBusinessObject.this_cGrupo = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
    THIS.this_oBusinessObject.this_nPeso = loc_oPagina.txt_4c_Peso.Value
    THIS.this_oBusinessObject.this_cTipoCor = ALLTRIM(loc_oPagina.txt_4c_TipoCor.Value)
    THIS.this_oBusinessObject.this_nDiasEntrega = loc_oPagina.txt_4c_DiasEntrega.Value
    THIS.this_oBusinessObject.this_cTanque = ALLTRIM(loc_oPagina.txt_4c_Tanque.Value)
ENDPROC

PROCEDURE BOParaForm()
    LOCAL loc_oPagina
    loc_oPagina = THIS.pgf_4c_Principal.Page2

    loc_oPagina.txt_4c_Codigo.Value = THIS.this_oBusinessObject.this_cCodigo
    loc_oPagina.txt_4c_Descricao.Value = THIS.this_oBusinessObject.this_cDescricao
    loc_oPagina.txt_4c_Variacao.Value = THIS.this_oBusinessObject.this_nVariacao
    loc_oPagina.txt_4c_Grupo.Value = THIS.this_oBusinessObject.this_cGrupo
    loc_oPagina.txt_4c_Peso.Value = THIS.this_oBusinessObject.this_nPeso
    loc_oPagina.txt_4c_TipoCor.Value = THIS.this_oBusinessObject.this_cTipoCor
    loc_oPagina.txt_4c_DiasEntrega.Value = THIS.this_oBusinessObject.this_nDiasEntrega
    loc_oPagina.txt_4c_Tanque.Value = THIS.this_oBusinessObject.this_cTanque
ENDPROC
```

### 3.5. Registrar no config.prg

Descomentar a linha em `C:\4c\projeto\app\start\config.prg`:

```foxpro
SET PROCEDURE TO (gc_4c_CaminhoForms + "cadastros\FormCor.prg") ADDITIVE
```

### 3.6. Testar FormCor Isoladamente

```foxpro
CD C:\4c\projeto\app\start
DO main.prg

*-- Testar instanciação
loForm = CREATEOBJECT("FormCor")
? TYPE("loForm") = "O"  && Deve ser .T.
loForm.Show()

*-- Verificar visualmente:
*-- [ ] PageFrame visível
*-- [ ] Page "Dados" visível
*-- [ ] Todos os 8 campos visíveis
*-- [ ] Labels com texto correto
*-- [ ] Botões CRUD visíveis (herdados do FormBase)

loForm.Release()
```

✅ **Checkpoint**: FormCor.prg criado, registrado e visualmente verificado.

---

## Fase 4: Criar Mapeamento JSON (30 min)

Seguir: `C:\4c\docs\task1_guia_completo.md` - Fase 4

### 4.1. Gerar Mapeamento com GeradorMapeamento.prg

```foxpro
CD C:\4c\projeto\app\utils
DO GeradorMapeamento WITH "c:\4c\tasks\task1\SIGCDCOR_form_codigo_fonte.txt", "FormCor"
```

### 4.2. Verificar Arquivo Gerado

Abrir: `C:\4c\projeto\app\utils\mapeamentos\FormCor_mapeamento.json`

**Verificar**:
- ✅ Arquivo existe
- ✅ Formato JSON válido
- ✅ Contém seção "mapeamento"
- ✅ Pelo menos 20 objetos mapeados

### 4.3. Corrigir Mapeamento Manualmente

**CRÍTICO**: GeradorMapeamento gera nomes genéricos. Você DEVE corrigir manualmente!

Abrir `FormCor.prg` e identificar os nomes REAIS dos objetos, depois atualizar o JSON:

```json
{
  "form_original": "SIGCDCOR",
  "form_migrado": "FormCor",
  "entidade": "Cor",
  "mapeamento": {
    "SIGCDCOR": "Form",
    "SIGCDCOR.Pagina": "pgf_4c_Principal",
    "SIGCDCOR.Pagina.Dados": "Page2",
    "SIGCDCOR.Pagina.Dados.Say1": "lbl_4c_Codigo",
    "SIGCDCOR.Pagina.Dados.Getcods": "txt_4c_Codigo",
    "SIGCDCOR.Pagina.Dados.Say2": "lbl_4c_Descricao",
    "SIGCDCOR.Pagina.Dados.Getdescs": "txt_4c_Descricao",
    "SIGCDCOR.Pagina.Dados.Say3": "lbl_4c_Variacao",
    "SIGCDCOR.Pagina.Dados.Getvarias": "txt_4c_Variacao",
    "SIGCDCOR.Pagina.Dados.Say4": "lbl_4c_Grupo",
    "SIGCDCOR.Pagina.Dados.Get_Grupo": "txt_4c_Grupo",
    "SIGCDCOR.Pagina.Dados.Say5": "lbl_4c_Peso",
    "SIGCDCOR.Pagina.Dados.Get_Peso": "txt_4c_Peso",
    "SIGCDCOR.Pagina.Dados.Say6": "lbl_4c_TipoCor",
    "SIGCDCOR.Pagina.Dados.Get_TpCor": "txt_4c_TipoCor",
    "SIGCDCOR.Pagina.Dados.Say7": "lbl_4c_DiasEntrega",
    "SIGCDCOR.Pagina.Dados.getDiasEnts": "txt_4c_DiasEntrega",
    "SIGCDCOR.Pagina.Dados.Say10": "lbl_4c_Tanque",
    "SIGCDCOR.Pagina.Dados.getTanque": "txt_4c_Tanque",
    "Dataenvironment": "obj_4c_Dataenvironment"
  }
}
```

✅ **Checkpoint**: Mapeamento JSON criado e corrigido com nomes reais.

---

## Fase 5: VALIDAÇÃO (30 min) - MOMENTO CRÍTICO! 🎯

### 5.1. Limpar Arquivos .fxp

```foxpro
CD C:\4c\projeto\app\utils
DELETE FILE *.fxp /S
```

### 5.2. Executar ValidarUIFidelity

```foxpro
CD C:\4c\projeto\app\utils
DO ValidarUIFidelity WITH "c:\4c\tasks\task1\SIGCDCOR_form_codigo_fonte.txt", "FormCor"
```

### 5.3. Verificar Resultado ESPERADO

**META: 37 problemas (todos aceitáveis)**

```
========================================================================
ValidarUIFidelity - Log de Execução
========================================================================
...
  - 37 diferenças encontradas

========================================================================
RESUMO:
- 4 erros críticos (Dataenvironment - OK)
- 33 avisos (FormBase - OK)
- 0 diferenças visuais (ForeColor normalizado)
========================================================================
```

### 5.4. Abrir Relatório HTML

Localização: `C:\4c\projeto\app\utils\relatorios\UIFidelity_FormCor_[timestamp].html`

**Verificar**:
- ✅ Total: 37 problemas
- ✅ 4 erros críticos (somente Dataenvironment)
- ✅ 33 avisos (somente controles FormBase: Grade, Grupo_op, Grupo_Salva, Picture)
- ✅ 0 diferenças visuais

### 5.5. O Que Fazer se o Resultado for DIFERENTE

#### ❌ Cenário 1: Mais de 37 problemas (ex: 50, 60, 100+)

**Causa**: Objetos faltando ou propriedades incorretas.

**Ação**:
1. Abrir relatório HTML
2. Identificar erros ALÉM dos 37 esperados
3. Para cada erro:
   - Se for Label/TextBox não encontrado → Adicionar no FormCor.prg
   - Se for propriedade diferente → Corrigir valor (Width/Height/BackColor/etc.)
4. Reexecutar ValidarUIFidelity
5. Repetir até chegar em 37

#### ❌ Cenário 2: Menos de 37 problemas (ex: 20, 15)

**Causa**: Formulário mais simples que o esperado (menos controles do FormBase).

**Ação**:
1. Verificar se todos os campos estão visíveis
2. Se sim, resultado OK (formulário mais simples)
3. Se não, adicionar campos faltantes

#### ❌ Cenário 3: Diferenças visuais (ForeColor não normalizado)

**Causa**: Correção de normalização não aplicada.

**Ação**:
1. Verificar se ComparadorUI.prg está atualizado
2. Deletar ComparadorUI.fxp
3. Reexecutar validação

✅ **Checkpoint CRÍTICO**: Validação DEVE passar com 37 problemas!

---

## Fase 6: Teste Manual (60 min)

### 6.1. Testar Modos CRUD

```foxpro
CD C:\4c\projeto\app\start
DO main.prg

*-- Abrir FormCor pelo menu: Cadastros > Cores
```

#### Teste 1: INCLUIR
1. Clicar em "Incluir"
2. Preencher campos:
   - Código: TEST001
   - Descrição: Teste de Cor
   - Variação: 10.50
   - Grupo: (F4 para buscar)
   - Peso: 5.25
   - Tipo: A
   - Dias Entrega: 15
   - Tanque: TQ001
3. Clicar em "Confirmar"
4. ✅ Verificar mensagem de sucesso
5. ✅ Verificar no banco (SELECT * FROM SigCdCor WHERE ccors = 'TEST001')

#### Teste 2: VISUALIZAR
1. Localizar registro TEST001 na grid
2. Duplo-clicar (ou clicar em "Consultar")
3. ✅ Campos preenchidos corretamente
4. ✅ Campos desabilitados (ReadOnly)
5. ✅ Botão "Confirmar" desabilitado

#### Teste 3: ALTERAR
1. Selecionar registro TEST001
2. Clicar em "Alterar"
3. Modificar Descrição: "Teste de Cor - Alterado"
4. Clicar em "Confirmar"
5. ✅ Verificar mensagem de sucesso
6. ✅ Verificar no banco (descrição alterada)

#### Teste 4: EXCLUIR
1. Selecionar registro TEST001
2. Clicar em "Excluir"
3. Confirmar exclusão
4. ✅ Verificar mensagem de sucesso
5. ✅ Verificar no banco (registro deletado)

### 6.2. Testar Lookups

#### Lookup de Grupo (F4)
1. Modo INCLUIR
2. Focar campo "Grupo"
3. Pressionar F4
4. ✅ FormBuscaAuxiliar abre
5. ✅ Grid mostra grupos cadastrados
6. Selecionar um grupo
7. ✅ Campo "Grupo" preenchido com código selecionado

### 6.3. Testar Grid de Listagem

1. Abrir FormCor
2. ✅ Grid carrega registros automaticamente
3. ✅ Colunas: Código, Descrição, Variação, Grupo, etc.
4. Duplo-clicar em um registro
5. ✅ Abre em modo VISUALIZAR com dados corretos

✅ **Checkpoint**: Todos os testes manuais passaram!

---

## Fase 7: Conclusão

### 7.1. Checklist Final

```
VALIDAÇÃO:
[x] ValidarUIFidelity: 37 problemas (todos aceitáveis)
[x] Relatório HTML: 4 erros + 33 avisos + 0 diferenças

ARQUIVOS:
[x] FormCor.prg criado
[x] CorBO.prg criado
[x] FormCor_mapeamento.json criado
[x] Registrados em config.prg

FUNCIONALIDADE:
[x] Modo INCLUIR funciona
[x] Modo ALTERAR funciona
[x] Modo VISUALIZAR funciona
[x] Modo EXCLUIR funciona
[x] Lookup F4 (Grupo) funciona
[x] Grid de listagem carrega
[x] Duplo-clique na grid abre registro

INTERFACE:
[x] Todos os campos visíveis
[x] Labels com texto correto
[x] Botões CRUD visíveis
[x] Cores e fontes corretas
```

### 7.2. Commit (Opcional)

```bash
git add .
git commit -m "Task1: Migração do FormCor REFAZER - Validado

- FormCor.prg: Interface pixel-perfect
- CorBO.prg: Lógica de negócios completa
- Mapeamento JSON: 22 objetos mapeados
- ValidarUIFidelity: 37 problemas (PASS)
- Testes: CRUD completo + Lookups OK

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"
```

### 7.3. Documentar Problemas Encontrados

Se você encontrou algum problema durante a refatoração, documente em:

`C:\4c\docs\PROBLEMAS_REFAZER_TASK1.md`

Exemplo:
```markdown
# Problemas Encontrados ao Refazer Task1

## 1. [Descrever problema]
- **O que aconteceu**: ...
- **Como resolver**: ...

## 2. [Outro problema]
- **O que aconteceu**: ...
- **Como resolver**: ...
```

---

## 📊 Métricas de Sucesso

| Métrica | Meta | Status |
|---------|------|--------|
| ValidarUIFidelity | 37 problemas | ⏳ |
| Testes CRUD | 4/4 passando | ⏳ |
| Lookups | 1/1 funcionando | ⏳ |
| Grid | Carregando | ⏳ |
| Tempo total | ~5h | ⏳ |

---

## 🎯 Próximos Passos

Após refazer task1 com sucesso:

1. ✅ **Validar processo documentado**
   - Se encontrou alguma inconsistência, atualizar `task1_guia_completo.md`

2. ✅ **Usar como template para task2**
   - Copiar estrutura de passos
   - Adaptar para FormCargo

3. ✅ **Criar checklist resumido**
   - Versão compacta para task2, task3, task4, task5

4. ✅ **Automatizar partes repetitivas**
   - Script para criar estrutura de arquivos
   - Template de BO
   - Template de Form

---

## 🚨 IMPORTANTE

**NÃO pule a Fase 5 (Validação)!**

A validação com ValidarUIFidelity é OBRIGATÓRIA. Um formulário só está completo quando:
- ✅ ValidarUIFidelity passa com 37 problemas
- ✅ Todos os testes manuais passam
- ✅ Interface visualmente idêntica ao original

**Tempo estimado total**: 5-6 horas para refazer task1 completamente do zero.

**Objetivo**: Ao final, você terá:
1. Processo validado
2. FormCor funcionando perfeitamente
3. Template para próximas tasks
4. Confiança no processo de migração
