# Passo-a-Passo: Migração de Formulário (À Prova de Falhas)

## 🎯 Objetivo

Guia prático com comandos prontos para copiar/colar. Seguir esta ordem EXATAMENTE.

---

## 📋 SEQUÊNCIA COMPLETA

```
1. Criar estrutura de pastas
2. Extrair código do SCX original
3. Analisar código extraído
4. Criar Business Object (BO)
5. Criar Form
6. Gerar mapeamento JSON
7. Corrigir mapeamento JSON
8. VALIDAR com ValidarUIFidelity (OBRIGATÓRIO)
9. Corrigir problemas encontrados
10. Testar manualmente (CRUD)
11. Conclusão
```

---

## PASSO 1: Criar Estrutura de Pastas

### Se for task NOVA:

```bash
# Windows (cmd)
cd C:\4c\tasks
mkdir task2
cd task2

# Copiar SCX original para cá
# Exemplo: copiar SIGCDCAR.SCX para C:\4c\tasks\task2\
```

### Se for REFAZER task existente:

```bash
# Windows (cmd)
cd C:\4c
mkdir backup_task1_20260115

# Fazer backup
copy "projeto\app\forms\cadastros\FormCor.prg" "backup_task1_20260115\"
copy "projeto\app\classes\CorBO.prg" "backup_task1_20260115\"
copy "projeto\app\utils\mapeamentos\FormCor_mapeamento.json" "backup_task1_20260115\"
```

✅ **Resultado**: Pastas criadas, backup feito (se refazendo)

---

## PASSO 2: Extrair Código do SCX Original

### 2.1. Verificar se já existe arquivo .txt

```foxpro
? FILE("C:\4c\tasks\task1\SIGCDCOR_form_codigo_fonte.txt")  && Se .T., pular para Passo 3
```

### 2.2. Se NÃO existir, extrair do SCX:

```foxpro
*-- Abrir VFP9
CD C:\4c\projeto\app\utils

*-- Executar extração
DO ExtractSCXCode WITH "C:\4c\tasks\task1\SIGCDCOR.SCX", ;
                       "C:\4c\tasks\task1\SIGCDCOR_form_codigo_fonte.txt"
```

**Aguardar mensagem**: "Código extraído com sucesso!"

### 2.3. Verificar arquivo gerado:

```foxpro
? FILE("C:\4c\tasks\task1\SIGCDCOR_form_codigo_fonte.txt")  && Deve ser .T.
```

✅ **Resultado**: Arquivo `*_form_codigo_fonte.txt` criado

---

## PASSO 3: Analisar Código Extraído

### 3.1. Abrir arquivo no editor de texto

```bash
notepad C:\4c\tasks\task1\SIGCDCOR_form_codigo_fonte.txt
```

### 3.2. Identificar informações críticas:

**Procurar no arquivo**:

| O Que Procurar | Onde Procurar | Para Que |
|----------------|---------------|----------|
| `Width = XXX` | Início do arquivo | Copiar largura EXATA do form |
| `Height = XXX` | Início do arquivo | Copiar altura EXATA do form |
| `Caption = "..."` | Início do arquivo | Copiar título do form |
| `* SECAO 2: PROPRIEDADES` | Meio do arquivo | Lista de todos os controles |
| `SIGACESS(` | Código dos métodos | Identificar lookups (F4/F5) |
| Campos `Get*` ou `txt*` | Seção de propriedades | Mapear campos de entrada |

### 3.3. Criar tabela de campos (Excel/Papel):

| Campo Original | Campo Novo | Tipo | InputMask | Lookup |
|----------------|------------|------|-----------|--------|
| Getcods | txt_4c_Codigo | CHAR(10) | !!!!!!!!!! | - |
| Get_Grupo | txt_4c_Grupo | CHAR(10) | !!!!!!!!!! | F4: SigCdGru |
| ... | ... | ... | ... | ... |

### 3.4. Consultar schema do banco:

```foxpro
*-- Abrir docs/schema.sql e procurar pela tabela
*-- Exemplo: SigCdCor
*-- Copiar nomes EXATOS das colunas (ccors, dcors, etc.)
```

✅ **Resultado**: Campos mapeados, lookups identificados, schema consultado

---

## PASSO 4: Criar Business Object (BO)

### 4.1. Criar arquivo XxxBO.prg

```bash
# Caminho do arquivo:
C:\4c\projeto\app\classes\CorBO.prg
```

### 4.2. Estrutura do BO (Template):

```foxpro
*=============================================================================
* CorBO.prg
* Business Object: Cor (Cadastro de Cores)
* Tabela: SigCdCor
*=============================================================================

DEFINE CLASS CorBO AS BusinessBase
    *-- TODAS as propriedades (uma para cada campo da tabela)
    this_cCodigo = ""           && ccors
    this_cDescricao = ""        && dcors
    this_nVariacao = 0          && nvaris
    this_cGrupo = ""            && cgrus
    *-- ... demais campos

    *-- Construtor
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela = "SigCdCor"
        THIS.this_cCampoChave = "ccors"
        RETURN .T.
    ENDPROC

    *-- CarregarDoCursor: Mapear TODOS os campos
    PROTECTED PROCEDURE CarregarDoCursor()
        THIS.this_cCodigo = ALLTRIM(ccors)
        THIS.this_cDescricao = ALLTRIM(dcors)
        THIS.this_nVariacao = nvaris
        THIS.this_cGrupo = ALLTRIM(cgrus)
        *-- ... demais campos
    ENDPROC

    *-- Validar: Regras de negócio
    PROTECTED PROCEDURE Validar()
        IF EMPTY(THIS.this_cCodigo)
            THIS.AdicionarErro("Código é obrigatório")
            RETURN .F.
        ENDIF
        *-- ... demais validações
        RETURN .T.
    ENDPROC

    *-- Inserir: SQL INSERT
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL
        loc_cSQL = "INSERT INTO SigCdCor (ccors, dcors, nvaris, cgrus) " + ;
                   "VALUES (" + ;
                   EscaparSQL(THIS.this_cCodigo) + ", " + ;
                   EscaparSQL(THIS.this_cDescricao) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nVariacao, 2) + ", " + ;
                   EscaparSQL(THIS.this_cGrupo) + ")"

        LOCAL loc_nResultado
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

        IF loc_nResultado >= 0
            THIS.RegistrarAuditoria("INSERT")
            RETURN .T.
        ENDIF

        THIS.TratarErroSQL()
        RETURN .F.
    ENDPROC

    *-- Atualizar: SQL UPDATE
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL
        loc_cSQL = "UPDATE SigCdCor SET " + ;
                   "dcors = " + EscaparSQL(THIS.this_cDescricao) + ", " + ;
                   "nvaris = " + FormatarNumeroSQL(THIS.this_nVariacao, 2) + ", " + ;
                   "cgrus = " + EscaparSQL(THIS.this_cGrupo) + " " + ;
                   "WHERE ccors = " + EscaparSQL(THIS.this_cCodigo)

        LOCAL loc_nResultado
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

        IF loc_nResultado >= 0
            THIS.RegistrarAuditoria("UPDATE")
            RETURN .T.
        ENDIF

        THIS.TratarErroSQL()
        RETURN .F.
    ENDPROC

    *-- Excluir: SQL DELETE
    PROTECTED PROCEDURE Excluir()
        LOCAL loc_cSQL
        loc_cSQL = "DELETE FROM SigCdCor WHERE ccors = " + EscaparSQL(THIS.this_cCodigo)

        LOCAL loc_nResultado
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

        IF loc_nResultado >= 0
            THIS.RegistrarAuditoria("DELETE")
            RETURN .T.
        ENDIF

        THIS.TratarErroSQL()
        RETURN .F.
    ENDPROC

    *-- ObterChavePrimaria: Para auditoria
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDPROC
ENDDEFINE
```

### 4.3. Registrar no config.prg:

```foxpro
*-- Abrir: C:\4c\projeto\app\start\config.prg
*-- Adicionar na seção "Business Objects":

SET PROCEDURE TO (gc_4c_CaminhoClasses + "CorBO.prg") ADDITIVE
```

### 4.4. Testar BO:

```foxpro
CD C:\4c\projeto\app\start
DO main.prg

*-- Deletar .fxp
DELETE FILE C:\4c\projeto\app\classes\*.fxp

*-- Testar
loBO = CREATEOBJECT("CorBO")
? TYPE("loBO") = "O"  && Deve ser .T.
? loBO.this_cTabela = "SigCdCor"  && Deve ser .T.

RELEASE loBO
```

✅ **Resultado**: CorBO.prg criado, registrado e testado

---

## PASSO 5: Criar Form

### 5.1. Criar arquivo FormXxx.prg

```bash
# Caminho do arquivo:
C:\4c\projeto\app\forms\cadastros\FormCor.prg
```

### 5.2. Estrutura do Form (Mínimo):

```foxpro
*=============================================================================
* FormCor.prg
* Formulário: Cadastro de Cores
*=============================================================================

DEFINE CLASS FormCor AS FormBase
    *-- Propriedades visuais (COPIAR DO ORIGINAL!)
    Width = 1003        && EXATO do original
    Height = 465        && EXATO do original
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

    PROCEDURE ConfigurarFormulario()
        *-- Adicionar PageFrame
        THIS.AddObject("pgf_4c_Principal", "PageFrame")
        THIS.pgf_4c_Principal.Top = 50
        THIS.pgf_4c_Principal.Left = 5
        THIS.pgf_4c_Principal.Width = THIS.Width - 15
        THIS.pgf_4c_Principal.Height = THIS.Height - 100
        THIS.pgf_4c_Principal.PageCount = 2
        THIS.pgf_4c_Principal.Visible = .T.

        *-- Configurar Page "Dados"
        THIS.pgf_4c_Principal.Page2.Caption = "Dados"

        *-- Adicionar campos (exemplo: Código)
        THIS.pgf_4c_Principal.Page2.AddObject("lbl_4c_Codigo", "Label")
        THIS.pgf_4c_Principal.Page2.lbl_4c_Codigo.Caption = "C" + CHR(243) + "digo:"
        THIS.pgf_4c_Principal.Page2.lbl_4c_Codigo.Top = 20
        THIS.pgf_4c_Principal.Page2.lbl_4c_Codigo.Left = 10
        THIS.pgf_4c_Principal.Page2.lbl_4c_Codigo.AutoSize = .T.
        THIS.pgf_4c_Principal.Page2.lbl_4c_Codigo.ForeColor = RGB(90,90,90)
        THIS.pgf_4c_Principal.Page2.lbl_4c_Codigo.Visible = .T.

        THIS.pgf_4c_Principal.Page2.AddObject("txt_4c_Codigo", "TextBox")
        THIS.pgf_4c_Principal.Page2.txt_4c_Codigo.Top = 18
        THIS.pgf_4c_Principal.Page2.txt_4c_Codigo.Left = 100
        THIS.pgf_4c_Principal.Page2.txt_4c_Codigo.Width = 120
        THIS.pgf_4c_Principal.Page2.txt_4c_Codigo.Height = 22
        THIS.pgf_4c_Principal.Page2.txt_4c_Codigo.InputMask = "!!!!!!!!!!"
        THIS.pgf_4c_Principal.Page2.txt_4c_Codigo.BackColor = RGB(255,255,255)
        THIS.pgf_4c_Principal.Page2.txt_4c_Codigo.Value = ""
        THIS.pgf_4c_Principal.Page2.txt_4c_Codigo.Visible = .T.

        *-- Repetir para TODOS os campos...
        *-- (Descrição, Variação, Grupo, Peso, TipoCor, DiasEntrega, Tanque)

        THIS.ConfigurarLookups()
    ENDPROC

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

    PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Principal.Page2

        THIS.this_oBusinessObject.this_cCodigo = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
        THIS.this_oBusinessObject.this_cDescricao = ALLTRIM(loc_oPagina.txt_4c_Descricao.Value)
        *-- ... TODOS os campos
    ENDPROC

    PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Principal.Page2

        loc_oPagina.txt_4c_Codigo.Value = THIS.this_oBusinessObject.this_cCodigo
        loc_oPagina.txt_4c_Descricao.Value = THIS.this_oBusinessObject.this_cDescricao
        *-- ... TODOS os campos
    ENDPROC

    PROCEDURE CarregarDados(par_cChave)
        LOCAL loc_cSQL, loc_nResultado

        loc_cSQL = "SELECT * FROM SigCdCor WHERE ccors = " + EscaparSQL(par_cChave)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

        IF loc_nResultado > 0 AND !EOF("cursor_4c_Dados")
            THIS.this_oBusinessObject.CarregarDoCursor()
            THIS.BOParaForm()
            USE IN cursor_4c_Dados
            RETURN .T.
        ENDIF

        RETURN .F.
    ENDPROC
ENDDEFINE
```

### 5.3. Registrar no config.prg:

```foxpro
*-- Abrir: C:\4c\projeto\app\start\config.prg
*-- Adicionar na seção "Formulários":

SET PROCEDURE TO (gc_4c_CaminhoForms + "cadastros\FormCor.prg") ADDITIVE
```

### 5.4. Testar Form visualmente:

```foxpro
CD C:\4c\projeto\app\start
DO main.prg

*-- Deletar .fxp
DELETE FILE C:\4c\projeto\app\forms\*.fxp

*-- Testar
loForm = CREATEOBJECT("FormCor")
loForm.Show()

*-- VERIFICAR VISUALMENTE:
*-- [ ] PageFrame aparece
*-- [ ] Page "Dados" aparece
*-- [ ] Todos os campos aparecem
*-- [ ] Labels com texto correto

*-- Fechar
loForm.Release()
```

✅ **Resultado**: FormCor.prg criado, registrado e visualmente OK

---

## PASSO 6: Gerar Mapeamento JSON

### 6.1. Executar GeradorMapeamento:

```foxpro
*-- COMANDO EXATO (copiar/colar):
CD C:\4c\projeto\app\utils
DO GeradorMapeamento WITH "c:\4c\tasks\task1\SIGCDCOR_form_codigo_fonte.txt", "FormCor"
```

**Aguardar mensagem**: "Mapeamento gerado com sucesso!"

### 6.2. Verificar arquivo gerado:

```foxpro
? FILE("C:\4c\projeto\app\utils\mapeamentos\FormCor_mapeamento.json")  && Deve ser .T.
```

### 6.3. Abrir JSON no editor:

```bash
notepad C:\4c\projeto\app\utils\mapeamentos\FormCor_mapeamento.json
```

**Exemplo de conteúdo**:
```json
{
  "form_original": "SIGCDCOR",
  "form_migrado": "FormCor",
  "entidade": "Cor",
  "mapeamento": {
    "SIGCDCOR": "Form",
    "SIGCDCOR.Pagina": "pgf_4c_Dados",
    "SIGCDCOR.Pagina.Dados": "Page_4c_Dados",
    "SIGCDCOR.Pagina.Dados.Say1": "lbl_4c_Label1",
    "SIGCDCOR.Pagina.Dados.Getcods": "txt_4c_TextBox1"
  }
}
```

✅ **Resultado**: JSON gerado com nomes GENÉRICOS (próximo passo: corrigir!)

---

## PASSO 7: Corrigir Mapeamento JSON

### 7.1. Abrir FormCor.prg lado a lado com o JSON:

```bash
# Janela 1: FormCor.prg
notepad C:\4c\projeto\app\forms\cadastros\FormCor.prg

# Janela 2: JSON
notepad C:\4c\projeto\app\utils\mapeamentos\FormCor_mapeamento.json
```

### 7.2. Para cada objeto no JSON:

| JSON (ERRADO) | FormCor.prg (CERTO) | JSON Corrigido |
|---------------|---------------------|----------------|
| `"pgf_4c_Dados"` | `pgf_4c_Principal` | `"pgf_4c_Principal"` |
| `"Page_4c_Dados"` | `Page2` | `"Page2"` |
| `"lbl_4c_Label1"` | `lbl_4c_Codigo` | `"lbl_4c_Codigo"` |
| `"txt_4c_TextBox1"` | `txt_4c_Codigo` | `"txt_4c_Codigo"` |
| `"lbl_4c_Label2"` | `lbl_4c_Descricao` | `"lbl_4c_Descricao"` |

### 7.3. JSON CORRIGIDO (exemplo):

```json
{
  "form_original": "SIGCDCOR",
  "form_migrado": "FormCor",
  "entidade": "Cor",
  "mapeamento": {
    "Dataenvironment": "obj_4c_Dataenvironment",
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
    "SIGCDCOR.Pagina.Dados.Get_Grupo": "txt_4c_Grupo"
  }
}
```

### 7.4. Salvar JSON corrigido

✅ **Resultado**: JSON com nomes REAIS dos objetos

---

## PASSO 8: VALIDAR com ValidarUIFidelity (OBRIGATÓRIO!)

### 8.1. Limpar arquivos .fxp:

```foxpro
*-- SEMPRE fazer isso antes de validar!
CD C:\4c\projeto\app
DELETE FILE *.fxp /S
```

### 8.2. Executar ValidarUIFidelity:

```foxpro
*-- COMANDO EXATO para Task1 (copiar/colar):
CD C:\4c\projeto\app\utils
DO ValidarUIFidelity WITH "c:\4c\tasks\task1\SIGCDCOR_form_codigo_fonte.txt", "FormCor"
```

**Comandos para outras tasks**:

```foxpro
*-- Task2 (FormCargo):
DO ValidarUIFidelity WITH "c:\4c\tasks\task2\SIGCDCAR_form_codigo_fonte.txt", "FormCargo"

*-- Task3 (FormDepartamento):
DO ValidarUIFidelity WITH "c:\4c\tasks\task3\SIGCDDPT_form_codigo_fonte.txt", "FormDepartamento"

*-- Task4 (FormPlanoContas):
DO ValidarUIFidelity WITH "c:\4c\tasks\task4\SIGREPLC_form_codigo_fonte.txt", "FormPlanoContas"

*-- Task5 (FormProduto):
DO ValidarUIFidelity WITH "c:\4c\tasks\task5\SIGCDPRO_form_codigo_fonte.txt", "FormProduto"
```

### 8.3. Verificar resultado no console:

**ESPERADO** (✅ SUCESSO):
```
========================================================================
ValidarUIFidelity - Log de Execução
========================================================================
...
  - 37 diferenças encontradas

*** AVISO: Diferenças encontradas! Verifique o relatório. ***
Relatório HTML: C:\4c\projeto\app\utils\relatorios\UIFidelity_FormCor_20260115XXXXXX.html
```

**Resultado correto**: 37 problemas
- 4 erros (Dataenvironment)
- 33 avisos (FormBase)
- 0 diferenças visuais

### 8.4. Abrir relatório HTML:

```bash
# Vai estar em:
C:\4c\projeto\app\utils\relatorios\UIFidelity_FormCor_[timestamp].html
```

**Verificar no relatório**:
```
Total de Problemas: 37
- Erros Críticos: 4 (somente Dataenvironment)
- Avisos: 33 (somente FormBase: Grade, Grupo_op, Grupo_Salva, Picture)
- Diferenças Visuais: 0 (ForeColor normalizado)
```

### 8.5. O que fazer se resultado for DIFERENTE de 37:

#### ❌ Cenário A: Mais de 37 problemas (ex: 50, 60, 100)

**Causa**: Objetos faltando ou propriedades incorretas

**Ação**:
1. Abrir relatório HTML
2. Procurar erros ALÉM dos 37 esperados
3. Para cada erro extra:
   - Se for "Label/TextBox não encontrado" → Adicionar no FormCor.prg
   - Se for "Width/Height/BackColor diferente" → Corrigir valor no FormCor.prg
   - Se for "objeto não encontrado no JSON" → Corrigir FormCor_mapeamento.json
4. Deletar .fxp: `DELETE FILE C:\4c\projeto\app\*.fxp /S`
5. Reexecutar ValidarUIFidelity
6. Repetir até chegar em 37

#### ❌ Cenário B: Diferenças visuais (ForeColor não normalizado)

**Causa**: ComparadorUI.prg desatualizado

**Ação**:
```foxpro
*-- Deletar ComparadorUI.fxp
DELETE FILE C:\4c\projeto\app\utils\ComparadorUI.fxp

*-- Reexecutar validação
DO ValidarUIFidelity WITH "c:\4c\tasks\task1\SIGCDCOR_form_codigo_fonte.txt", "FormCor"
```

✅ **Resultado**: ValidarUIFidelity passou com 37 problemas!

---

## PASSO 9: Corrigir Problemas (Se Houver)

Se ValidarUIFidelity retornou MAIS de 37 problemas, seguir esta ordem:

### 9.1. Abrir relatório HTML e identificar erros extras

### 9.2. Para cada erro extra:

**Tipo de Erro**: "Objeto não encontrado"
- **Ação**: Adicionar objeto no FormCor.prg (Label ou TextBox faltando)

**Tipo de Erro**: "Width diferente (esperado: 120, encontrado: 100)"
- **Ação**: Corrigir Width no FormCor.prg: `.Width = 120`

**Tipo de Erro**: "BackColor diferente"
- **Ação**: Corrigir BackColor no FormCor.prg: `.BackColor = RGB(255,255,255)`

**Tipo de Erro**: "ForeColor diferente (90,90,90 vs RGB(90,90,90))"
- **Ação**: Deletar ComparadorUI.fxp e revalidar

### 9.3. Após cada correção:

```foxpro
*-- 1. Deletar .fxp
DELETE FILE C:\4c\projeto\app\*.fxp /S

*-- 2. Reexecutar validação
CD C:\4c\projeto\app\utils
DO ValidarUIFidelity WITH "c:\4c\tasks\task1\SIGCDCOR_form_codigo_fonte.txt", "FormCor"

*-- 3. Verificar se diminuiu os problemas
```

### 9.4. Repetir até atingir 37 problemas

✅ **Resultado**: Todos os problemas extras corrigidos, validação OK (37 problemas)

---

## PASSO 10: Testar Manualmente (CRUD)

### 10.1. Abrir sistema:

```foxpro
CD C:\4c\projeto\app\start
DO main.prg

*-- No menu, navegar até: Cadastros > Cores
```

### 10.2. Teste 1: INCLUIR

```
1. Clicar em botão "Incluir"
2. Preencher campos:
   - Código: TEST001
   - Descrição: Teste de Migração
   - Variação: 10.50
   - Grupo: (pressionar F4, selecionar um grupo)
   - Peso: 5.25
   - Tipo: A
   - Dias Entrega: 15
   - Tanque: TQ001
3. Clicar em "Confirmar"
4. ✅ Verificar mensagem: "Registro salvo com sucesso"
5. ✅ Verificar no banco:
   SELECT * FROM SigCdCor WHERE ccors = 'TEST001'
```

### 10.3. Teste 2: VISUALIZAR

```
1. Na grid, localizar registro TEST001
2. Duplo-clicar no registro (ou clicar em "Consultar")
3. ✅ Verificar:
   - Campos preenchidos corretamente
   - Campos desabilitados (ReadOnly)
   - Botão "Confirmar" desabilitado
   - Botão "Cancelar" habilitado
```

### 10.4. Teste 3: ALTERAR

```
1. Selecionar registro TEST001
2. Clicar em botão "Alterar"
3. Modificar campo Descrição: "Teste de Migração - ALTERADO"
4. Clicar em "Confirmar"
5. ✅ Verificar mensagem: "Registro atualizado com sucesso"
6. ✅ Verificar no banco:
   SELECT dcors FROM SigCdCor WHERE ccors = 'TEST001'
   -- Deve retornar "Teste de Migração - ALTERADO"
```

### 10.5. Teste 4: EXCLUIR

```
1. Selecionar registro TEST001
2. Clicar em botão "Excluir"
3. Confirmar exclusão (clicar "Sim" no diálogo)
4. ✅ Verificar mensagem: "Registro excluído com sucesso"
5. ✅ Verificar no banco:
   SELECT * FROM SigCdCor WHERE ccors = 'TEST001'
   -- Deve retornar 0 registros
```

### 10.6. Teste 5: Lookups (F4/F5)

```
1. Modo INCLUIR
2. Focar campo "Grupo"
3. Pressionar F4
4. ✅ Verificar:
   - FormBuscaAuxiliar abre
   - Grid mostra grupos cadastrados
   - Colunas: Código, Descrição
5. Duplo-clicar em um grupo
6. ✅ Verificar:
   - Campo "Grupo" preenchido com código selecionado
   - FormBuscaAuxiliar fecha
```

### 10.7. Teste 6: Grid de Listagem

```
1. Abrir FormCor
2. ✅ Verificar:
   - Grid carrega registros automaticamente
   - Colunas aparecem: Código, Descrição, Variação, Grupo, etc.
3. Duplo-clicar em um registro
4. ✅ Verificar:
   - Abre em modo VISUALIZAR
   - Dados corretos preenchidos
```

✅ **Resultado**: Todos os testes manuais passaram!

---

## PASSO 11: Conclusão

### 11.1. Checklist Final:

```
VALIDAÇÃO:
[x] ValidarUIFidelity: 37 problemas (PASS)
[x] Relatório HTML verificado

ARQUIVOS:
[x] FormCor.prg criado
[x] CorBO.prg criado
[x] FormCor_mapeamento.json criado e corrigido
[x] Registrados em config.prg

FUNCIONALIDADE:
[x] INCLUIR funciona
[x] ALTERAR funciona
[x] VISUALIZAR funciona
[x] EXCLUIR funciona
[x] Lookup F4 funciona
[x] Grid carrega e seleciona

INTERFACE:
[x] Todos os campos visíveis
[x] Posicionamento correto
[x] Cores e fontes corretas
```

### 11.2. Commit (Opcional):

```bash
git add .
git commit -m "Task1: Migração do FormCor concluída

- FormCor.prg: Interface pixel-perfect
- CorBO.prg: Lógica de negócios completa
- Mapeamento JSON: 22 objetos mapeados
- ValidarUIFidelity: 37 problemas (PASS)
- Testes: CRUD completo + Lookups OK

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"
```

### 11.3. Documentar Problemas Encontrados (Se Houver):

Se encontrou algum problema durante a migração, criar arquivo:

```
C:\4c\docs\PROBLEMAS_TASK1.md
```

Conteúdo:
```markdown
# Problemas Encontrados - Task1

## 1. [Descrever problema]
- **O que aconteceu**: ...
- **Como resolver**: ...
- **Tempo perdido**: XX minutos

## 2. [Outro problema]
- **O que aconteceu**: ...
- **Como resolver**: ...
```

✅ **Resultado**: Migração completa e documentada!

---

## 📊 Resumo Visual do Processo

```
┌─────────────────────────────────────────────────────────────┐
│                    FLUXO DE MIGRAÇÃO                        │
└─────────────────────────────────────────────────────────────┘

PREPARAÇÃO (30 min)
├─ 1. Criar pastas
├─ 2. Extrair código do SCX (ExtractSCXCode)
└─ 3. Analisar código extraído

DESENVOLVIMENTO (3-4h)
├─ 4. Criar BO (XxxBO.prg)
├─ 5. Criar Form (FormXxx.prg)
├─ 6. Gerar JSON (GeradorMapeamento)
└─ 7. Corrigir JSON manualmente

VALIDAÇÃO (30-60 min) ⚠️ CRÍTICO
├─ 8. ValidarUIFidelity ────┐
│                            │
├─ Resultado = 37? ─────────┤
│   SIM → Prosseguir         │
│   NÃO → 9. Corrigir ───────┘
│          e revalidar
│
└─ Resultado = 37? ─────────> 10. Testar manualmente

CONCLUSÃO (30 min)
└─ 11. Checklist final + Commit
```

---

## ⏱️ Tempo Estimado Total

| Fase | Tempo |
|------|-------|
| Preparação | 30 min |
| Desenvolvimento | 3-4h |
| Validação + Correções | 30-60 min |
| Testes Manuais | 30-60 min |
| Conclusão | 30 min |
| **TOTAL** | **5-6h** |

---

## 🚨 REGRAS CRÍTICAS

1. ✅ **SEMPRE executar ValidarUIFidelity** - NÃO pular!
2. ✅ **Meta: 37 problemas** - Se tiver mais, CORRIGIR!
3. ✅ **Deletar .fxp antes de testar** - Senão testa código antigo!
4. ✅ **Corrigir JSON manualmente** - GeradorMapeamento gera nomes genéricos!
5. ✅ **Testar TODOS os modos** - INCLUIR/ALTERAR/VISUALIZAR/EXCLUIR!

---

## 📚 Comandos Rápidos (Cheat Sheet)

```foxpro
*-- Extrair código do SCX
DO ExtractSCXCode WITH "C:\4c\tasks\task1\SIGCDCOR.SCX", ;
                       "C:\4c\tasks\task1\SIGCDCOR_form_codigo_fonte.txt"

*-- Gerar mapeamento JSON
CD C:\4c\projeto\app\utils
DO GeradorMapeamento WITH "c:\4c\tasks\task1\SIGCDCOR_form_codigo_fonte.txt", "FormCor"

*-- Validar UI Fidelity (Task1)
CD C:\4c\projeto\app\utils
DELETE FILE C:\4c\projeto\app\*.fxp /S
DO ValidarUIFidelity WITH "c:\4c\tasks\task1\SIGCDCOR_form_codigo_fonte.txt", "FormCor"

*-- Validar UI Fidelity (Task2)
DO ValidarUIFidelity WITH "c:\4c\tasks\task2\SIGCDCAR_form_codigo_fonte.txt", "FormCargo"

*-- Testar BO
loBO = CREATEOBJECT("CorBO")
? TYPE("loBO") = "O"

*-- Testar Form
loForm = CREATEOBJECT("FormCor")
loForm.Show()

*-- Consultar banco
SELECT * FROM SigCdCor WHERE ccors = 'TEST001'
```

---

**Última atualização**: 2026-01-15
**Versão**: 2.0
**Status**: À prova de falhas ✅
