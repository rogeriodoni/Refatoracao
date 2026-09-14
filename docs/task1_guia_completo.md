# Task 1 - Guia Completo de Migração: FormCor

Este documento descreve o processo completo de migração do formulário SIGCDCOR (cadastro de cores) para o novo sistema.

## Resultado Esperado

Ao final desta task, você terá:
- ✅ FormCor.prg funcional com interface pixel-perfect
- ✅ CorBO.prg com lógica de negócios
- ✅ ValidarUIFidelity passando com ≤ 37 problemas aceitáveis
- ✅ Lookups funcionando (F4/F5)
- ✅ Modos INCLUIR/ALTERAR/VISUALIZAR/EXCLUIR operacionais

## Arquivos de Referência

| Arquivo | Localização | Propósito |
|---------|-------------|-----------|
| SCX Original | `C:\4c\tasks\task1\SIGCDCOR.SCX` | Formulário legado (binário) |
| Código Extraído | `C:\4c\tasks\task1\SIGCDCOR_form_codigo_fonte.txt` | Propriedades visuais e código |
| FormCor.prg | `C:\4c\projeto\app\forms\cadastros\FormCor.prg` | Novo formulário |
| CorBO.prg | `C:\4c\projeto\app\classes\CorBO.prg` | Business Object |
| Mapeamento JSON | `C:\4c\projeto\app\utils\mapeamentos\FormCor_mapeamento.json` | Mapa de objetos |

## Fase 1: Análise Pré-Migração

### 1.1. Extrair Código Fonte do SCX Original

Se ainda não foi extraído:

```foxpro
CD C:\4c\tasks\task1
DO ExtractSCX WITH "SIGCDCOR.SCX", "SIGCDCOR_form_codigo_fonte.txt"
```

### 1.2. Analisar Estrutura do Formulário Original

Leia o arquivo `SIGCDCOR_form_codigo_fonte.txt` e identifique:

**Seção 1: Estrutura de Objetos**
- Hierarquia de controles (PageFrame, Pages, Labels, TextBoxes)
- Tipo de cada controle (Label, TextBox, CommandButton, etc.)

**Seção 2: Propriedades Customizadas**
- Propriedades visuais de cada controle (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize)
- Valores EXATOS de cada propriedade

**Seção 3: Métodos e Eventos**
- Lookups (F4/F5) - quais campos têm busca
- Validações (Valid events)
- Eventos de negócio (Init, Click, etc.)

### 1.3. Identificar Lookups

Procure no código extraído por:
- `KeyPress` events com `IF nKeyCode = 289` ou `IF nKeyCode = 290` (F4/F5)
- Chamadas para `sigacess.PRG` (lookup legado)

**Exemplo do FormCor**:
```
SIGCDCOR.Pagina.Dados.Get_Grupo.KeyPress:
    IF nKeyCode = 289  && F4
        SigBusCor("grupos")
    ENDIF
```

Crie uma tabela de lookups:

| Campo | Tecla | Função Legado | Nova Implementação |
|-------|-------|---------------|-------------------|
| txt_4c_Grupo | F4 | SigBusCor("grupos") | FormBuscaAuxiliar("SigCdGru", ...) |
| txt_4c_TipoCor | F4 | (não havia) | (adicionar se necessário) |

## Fase 2: Criar Business Object (BO)

### 2.1. Identificar Tabela e Campos

**Tabela**: `SigCdCor` (manter nome EXATO do legado - PILAR 2)

**Campos** (do schema.sql):
```sql
CREATE TABLE SigCdCor (
    cods CHAR(10) NOT NULL PRIMARY KEY,   -- Código da cor
    descs CHAR(50),                        -- Descrição
    varias NUMERIC(14,2),                  -- Variação de preço
    grupos CHAR(10),                       -- Grupo
    Pesos NUMERIC(14,2),                   -- Variação de peso
    tpCors CHAR(1),                        -- Tipo de cor (S/N)
    DiasEnts NUMERIC(3,0),                 -- Dias para entrega
    Tanque CHAR(10)                        -- Tanque
)
```

### 2.2. Criar CorBO.prg

```foxpro
*====================================================================
* CorBO.prg
* Business Object para Cor (SigCdCor)
*====================================================================
DEFINE CLASS CorBO AS BusinessBase

    *-- Propriedades da entidade (this_ prefix)
    this_cCodigo = ""
    this_cDescricao = ""
    this_nVariacaoPreco = 0.00
    this_cGrupo = ""
    this_nPeso = 0.00
    this_cTipoCor = ""
    this_nDiasEntrega = 0
    this_cTanque = ""

    *-- Nome da tabela (EXATO do legado)
    cTabela = "SigCdCor"
    cCampoCodigo = "cods"

    *====================================================================
    * CarregarDoCursor
    * Preenche propriedades do BO a partir do cursor
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAlias)
        LOCAL loc_cAliasAnterior
        loc_cAliasAnterior = ALIAS()

        SELECT (par_cAlias)

        THIS.this_cCodigo = ALLTRIM(cods)
        THIS.this_cDescricao = ALLTRIM(descs)
        THIS.this_nVariacaoPreco = varias
        THIS.this_cGrupo = ALLTRIM(grupos)
        THIS.this_nPeso = Pesos
        THIS.this_cTipoCor = ALLTRIM(tpCors)
        THIS.this_nDiasEntrega = DiasEnts
        THIS.this_cTanque = ALLTRIM(Tanque)

        IF !EMPTY(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF

        RETURN .T.
    ENDPROC

    *====================================================================
    * Inserir
    * Insere novo registro na tabela
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado

        TEXT TO loc_cSQL NOSHOW TEXTMERGE
            INSERT INTO <<THIS.cTabela>> (
                cods, descs, varias, grupos, Pesos,
                tpCors, DiasEnts, Tanque
            ) VALUES (
                <<EscaparSQL(THIS.this_cCodigo)>>,
                <<EscaparSQL(THIS.this_cDescricao)>>,
                <<FormatarNumeroSQL(THIS.this_nVariacaoPreco, 2)>>,
                <<EscaparSQL(THIS.this_cGrupo)>>,
                <<FormatarNumeroSQL(THIS.this_nPeso, 2)>>,
                <<EscaparSQL(THIS.this_cTipoCor)>>,
                <<ALLTRIM(STR(THIS.this_nDiasEntrega))>>,
                <<EscaparSQL(THIS.this_cTanque)>>
            )
        ENDTEXT

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

        IF loc_nResultado < 0
            MostrarErro("Erro ao inserir cor", loc_cSQL)
            RETURN .F.
        ENDIF

        THIS.RegistrarAuditoria("INSERT")
        RETURN .T.
    ENDPROC

    *====================================================================
    * Atualizar
    * Atualiza registro existente
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado

        TEXT TO loc_cSQL NOSHOW TEXTMERGE
            UPDATE <<THIS.cTabela>>
            SET descs = <<EscaparSQL(THIS.this_cDescricao)>>,
                varias = <<FormatarNumeroSQL(THIS.this_nVariacaoPreco, 2)>>,
                grupos = <<EscaparSQL(THIS.this_cGrupo)>>,
                Pesos = <<FormatarNumeroSQL(THIS.this_nPeso, 2)>>,
                tpCors = <<EscaparSQL(THIS.this_cTipoCor)>>,
                DiasEnts = <<ALLTRIM(STR(THIS.this_nDiasEntrega))>>,
                Tanque = <<EscaparSQL(THIS.this_cTanque)>>
            WHERE cods = <<EscaparSQL(THIS.this_cCodigo)>>
        ENDTEXT

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

        IF loc_nResultado < 0
            MostrarErro("Erro ao atualizar cor", loc_cSQL)
            RETURN .F.
        ENDIF

        THIS.RegistrarAuditoria("UPDATE")
        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterChavePrimaria
    * Retorna valor da chave primaria (para auditoria)
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDPROC

    *====================================================================
    * Validar
    * Valida dados antes de salvar
    *====================================================================
    PROTECTED PROCEDURE Validar()
        *-- Codigo obrigatorio
        IF EMPTY(THIS.this_cCodigo)
            MsgErro("C" + CHR(243) + "digo " + CHR(233) + " obrigat" + CHR(243) + "rio!")
            RETURN .F.
        ENDIF

        *-- Descricao obrigatoria
        IF EMPTY(THIS.this_cDescricao)
            MsgErro("Descri" + CHR(231) + CHR(227) + "o " + CHR(233) + " obrigat" + CHR(243) + "ria!")
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

ENDDEFINE
```

### 2.3. Registrar BO no config.prg

Adicione em `C:\4c\projeto\app\start\config.prg`:

```foxpro
PROCEDURE ConfigurarAmbiente()
    *-- ... (existente)

    *-- Business Objects
    SET PROCEDURE TO (gcCaminhoClasses + "CorBO.prg") ADDITIVE
    *-- ... (outros BOs)
ENDPROC
```

## Fase 3: Criar Formulário (FormCor.prg)

### 3.1. Estrutura Básica

```foxpro
*====================================================================
* FormCor.prg
* Formulário de cadastro de Cores
*====================================================================
DEFINE CLASS FormCor AS FormBase

    *-- Propriedades
    this_oBusinessObject = .NULL.
    this_lNovoRegistro = .F.

    *-- Configuracoes do formulário
    Caption = "Cadastro de Cores"
    Width = 1000
    Height = 600

    *====================================================================
    * Init
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()

        *-- Cria Business Object
        THIS.this_oBusinessObject = CREATEOBJECT("CorBO")

        *-- Configura interface
        THIS.CriarInterface()

        *-- Configura lookups
        THIS.ConfigurarLookups()

        RETURN .T.
    ENDPROC

    *====================================================================
    * CriarInterface
    * Cria controles da interface
    *====================================================================
    PROTECTED PROCEDURE CriarInterface()
        LOCAL loc_oPagina

        *-- Pega referência para Page2 (aba Dados)
        loc_oPagina = THIS.pgf_4c_Principal.Page2

        *-- Código: Label
        loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
        WITH loc_oPagina.lbl_4c_Codigo
            .Caption = "C" + CHR(243) + "digo : "
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Left = 335
            .Top = 131
            .AutoSize = .T.
            .Visible = .T.
        ENDWITH

        *-- Código: TextBox
        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Left = 386
            .Top = 127
            .Width = 41
            .Height = 24
            .SpecialEffect = 1
            .InputMask = "!!!!!!!!!!"
            .MaxLength = 10
            .Value = ""
            .Visible = .T.
        ENDWITH

        *-- Descrição: Label
        loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
        WITH loc_oPagina.lbl_4c_Descricao
            .Caption = "Descri" + CHR(231) + CHR(227) + "o : "
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Left = 322
            .Top = 158
            .AutoSize = .T.
            .Visible = .T.
        ENDWITH

        *-- Descrição: TextBox
        loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
        WITH loc_oPagina.txt_4c_Descricao
            .Left = 386
            .Top = 154
            .Width = 290
            .Height = 24
            .SpecialEffect = 1
            .MaxLength = 50
            .Value = ""
            .Visible = .T.
        ENDWITH

        *-- ... (repetir para todos os campos)

        *-- IMPORTANTE: Copiar Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize EXATOS do arquivo original!

    ENDPROC

    *====================================================================
    * ConfigurarLookups
    * Configura teclas de atalho para lookups
    *====================================================================
    PROTECTED PROCEDURE ConfigurarLookups()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Principal.Page2

        *-- Lookup de Grupo (F4)
        BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress", THIS, "LookupGrupo", 1)

        *-- ... (outros lookups)
    ENDPROC

    *====================================================================
    * LookupGrupo
    * Lookup de grupo de cores (F4)
    *====================================================================
    PROTECTED PROCEDURE LookupGrupo(nKeyCode, nShiftAltCtrl)
        IF nKeyCode = 289  && F4
            LOCAL loc_oLookup, loc_cCodigo
            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
                "SigCdGru", ;
                "grupos", ;
                "C" + CHR(243) + "digo,Descri" + CHR(231) + CHR(227) + "o", ;
                "cgrus,dgrus", ;
                "100,400")

            loc_cCodigo = loc_oLookup.Executar()

            IF !EMPTY(loc_cCodigo)
                THIS.pgf_4c_Principal.Page2.txt_4c_Grupo.Value = loc_cCodigo
                THIS.pgf_4c_Principal.Page2.txt_4c_Grupo.SetFocus()
            ENDIF

            NODEFAULT
        ENDIF
    ENDPROC

    *====================================================================
    * FormParaBO
    * Transfere dados do formulário para o BO
    *====================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Principal.Page2

        WITH THIS.this_oBusinessObject
            .this_cCodigo = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
            .this_cDescricao = ALLTRIM(loc_oPagina.txt_4c_Descricao.Value)
            .this_nVariacaoPreco = VAL(loc_oPagina.txt_4c_Variacao.Value)
            .this_cGrupo = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
            .this_nPeso = VAL(loc_oPagina.txt_4c_Peso.Value)
            .this_cTipoCor = ALLTRIM(loc_oPagina.txt_4c_TipoCor.Value)
            .this_nDiasEntrega = VAL(loc_oPagina.txt_4c_DiasEntrega.Value)
            .this_cTanque = ALLTRIM(loc_oPagina.txt_4c_Tanque.Value)
        ENDWITH

        RETURN .T.
    ENDPROC

    *====================================================================
    * BOParaForm
    * Transfere dados do BO para o formulário
    *====================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Principal.Page2

        WITH THIS.this_oBusinessObject
            loc_oPagina.txt_4c_Codigo.Value = .this_cCodigo
            loc_oPagina.txt_4c_Descricao.Value = .this_cDescricao
            loc_oPagina.txt_4c_Variacao.Value = TRANSFORM(.this_nVariacaoPreco, "9999.99")
            loc_oPagina.txt_4c_Grupo.Value = .this_cGrupo
            loc_oPagina.txt_4c_Peso.Value = TRANSFORM(.this_nPeso, "9999.99")
            loc_oPagina.txt_4c_TipoCor.Value = .this_cTipoCor
            loc_oPagina.txt_4c_DiasEntrega.Value = TRANSFORM(.this_nDiasEntrega, "999")
            loc_oPagina.txt_4c_Tanque.Value = .this_cTanque
        ENDWITH

        RETURN .T.
    ENDPROC

    *====================================================================
    * CarregarGrid
    * Carrega dados no grid de listagem
    *====================================================================
    PROTECTED PROCEDURE CarregarGrid()
        LOCAL loc_cSQL, loc_nResultado

        TEXT TO loc_cSQL NOSHOW
            SELECT cods, descs, grupos
            FROM SigCdCor
            ORDER BY cods
        ENDTEXT

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Lista")

        IF loc_nResultado < 0
            MostrarErro("Erro ao carregar lista de cores", loc_cSQL)
            RETURN .F.
        ENDIF

        LOCAL loc_oGrid
        loc_oGrid = THIS.pgf_4c_Principal.Page1.grd_4c_Lista

        loc_oGrid.RecordSource = "cursor_4c_Lista"
        loc_oGrid.Column1.ControlSource = "cods"
        loc_oGrid.Column2.ControlSource = "descs"
        loc_oGrid.Column3.ControlSource = "grupos"

        loc_oGrid.Refresh()
        RETURN .T.
    ENDPROC

ENDDEFINE
```

### 3.2. Registrar Form no config.prg

```foxpro
PROCEDURE ConfigurarAmbiente()
    *-- ... (existente)

    *-- Formulários
    SET PROCEDURE TO (gcCaminhoForms + "cadastros\FormCor.prg") ADDITIVE
    *-- ... (outros forms)
ENDPROC
```

## Fase 4: Criar Mapeamento JSON

### 4.1. Criar arquivo FormCor_mapeamento.json

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
    "SIGCDCOR.Pagina.Dados.Say2": "lbl_4c_Descricao",
    "SIGCDCOR.Pagina.Dados.Say3": "lbl_4c_Variacao",
    "SIGCDCOR.Pagina.Dados.Say4": "lbl_4c_Grupo",
    "SIGCDCOR.Pagina.Dados.Say5": "lbl_4c_Peso",
    "SIGCDCOR.Pagina.Dados.Say6": "lbl_4c_DiasEntrega",
    "SIGCDCOR.Pagina.Dados.Say7": "lbl_4c_TipoCor",
    "SIGCDCOR.Pagina.Dados.Say8": "lbl_4c_DiasHint",
    "SIGCDCOR.Pagina.Dados.Say9": "lbl_4c_TipoCorHint",
    "SIGCDCOR.Pagina.Dados.Say10": "lbl_4c_Tanque",
    "SIGCDCOR.Pagina.Dados.Getcods": "txt_4c_Codigo",
    "SIGCDCOR.Pagina.Dados.Getdescs": "txt_4c_Descricao",
    "SIGCDCOR.Pagina.Dados.Getvarias": "txt_4c_Variacao",
    "SIGCDCOR.Pagina.Dados.Get_Grupo": "txt_4c_Grupo",
    "SIGCDCOR.Pagina.Dados.Get_Peso": "txt_4c_Peso",
    "SIGCDCOR.Pagina.Dados.Get_TpCor": "txt_4c_TipoCor",
    "SIGCDCOR.Pagina.Dados.getDiasEnts": "txt_4c_DiasEntrega",
    "SIGCDCOR.Pagina.Dados.getTanque": "txt_4c_Tanque"
  }
}
```

Salvar em: `C:\4c\projeto\app\utils\mapeamentos\FormCor_mapeamento.json`

## Fase 5: Validação e Testes

### 5.1. Deletar .fxp Compilados

```foxpro
CD C:\4c\projeto\app
del /s /q *.fxp
```

### 5.2. Executar ValidarUIFidelity

```foxpro
CD C:\4c\projeto\app\utils
DO ValidarUIFidelity WITH "task1\SIGCDCOR_form_codigo_fonte.txt", "FormCor"
```

### 5.3. Interpretar Resultados

**Meta Esperada**:
```
Total: 37 problemas
- 4 erros (Dataenvironment - OK)
- 33 avisos (FormBase - OK)
- 0 diferenças (ForeColor normalizado automaticamente)
```

**Se houver mais erros**:
1. Ler o relatório HTML gerado
2. Para cada ERRO crítico (exceto Dataenvironment):
   - Verificar se objeto existe no FormCor.prg
   - Verificar mapeamento no JSON
   - Corrigir e rodar ValidarUIFidelity novamente

### 5.4. Teste Manual

```foxpro
CD C:\4c\projeto\app\start
DO main.prg

*-- No menu, abrir Cadastros > Cores
```

**Checklist de testes**:
- [ ] Modo INCLUIR: Preencher todos os campos, salvar
- [ ] Modo ALTERAR: Editar registro, salvar
- [ ] Modo VISUALIZAR: Ver registro (campos desabilitados)
- [ ] Modo EXCLUIR: Deletar registro
- [ ] Lookups (F4/F5): Testar em todos os campos com lookup
- [ ] Grid: Carregar lista, selecionar registro
- [ ] Validações: Testar campos obrigatórios

## Fase 6: Conclusão

### 6.1. Checklist Final

```
[ ] ValidarUIFidelity ≤ 37 problemas
[ ] FormCor.prg criado e registrado em config.prg
[ ] CorBO.prg criado e registrado em config.prg
[ ] Mapeamento JSON criado
[ ] Todos os campos visíveis e posicionados corretamente
[ ] Lookups funcionando (F4/F5)
[ ] Modos INCLUIR/ALTERAR/VISUALIZAR/EXCLUIR funcionando
[ ] Grid de listagem carregando e selecionando
[ ] Código documentado e sem console.log/SET STEP ON
```

### 6.2. Commit

```bash
git add .
git commit -m "Task1: Migração do FormCor concluída

- FormCor.prg: Interface pixel-perfect com FormBase
- CorBO.prg: Business logic com validações
- Mapeamento JSON: 22 objetos mapeados
- ValidarUIFidelity: 37 problemas (todos aceitáveis)
- Lookups funcionando (F4 para Grupo)
- Testes: INCLUIR/ALTERAR/VISUALIZAR/EXCLUIR OK

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"
```

## Anexos

### A. Estrutura Completa de Campos do FormCor

| Campo Original | Campo Novo | Tipo | InputMask | Lookup |
|----------------|------------|------|-----------|--------|
| Getcods | txt_4c_Codigo | CHAR(10) | !!!!!!!!!! | - |
| Getdescs | txt_4c_Descricao | CHAR(50) | - | - |
| Getvarias | txt_4c_Variacao | NUMERIC(14,2) | 9999.99 | - |
| Get_Grupo | txt_4c_Grupo | CHAR(10) | !!!!!!!!!! | F4: SigCdGru |
| Get_Peso | txt_4c_Peso | NUMERIC(14,2) | 9999.99 | - |
| Get_TpCor | txt_4c_TipoCor | CHAR(1) | ! | - |
| getDiasEnts | txt_4c_DiasEntrega | NUMERIC(3,0) | 999 | - |
| getTanque | txt_4c_Tanque | CHAR(10) | !!!!!!!!!!! | - |

### B. Referências

- **ValidarUIFidelity**: `C:\4c\docs\ui_fidelity_validation.md`
- **FormBase**: `C:\4c\projeto\app\classes\formbase.prg`
- **BusinessBase**: `C:\4c\projeto\app\classes\businessbase.prg`
- **FormBuscaAuxiliar**: `C:\4c\docs\lookup_implementation.md`
- **Schema SQL**: `C:\4c\docs\schema.sql`

---

**Última atualização**: 2026-01-15
**Autor**: Sistema de Refatoração VFP9
