# Grid Implementation Guide

## Grid Configuration

### Sistema Antigo (pColuna)
O sistema antigo usa o metodo pColuna com o 4o parametro como titulo:
```foxpro
* pColuna(campo, param2, param3, titulo, largura, visivel)
.pfSqlTabela(1).pColuna('codigos',    '', '', 'Codigo',      080, .T.)
.pfSqlTabela(1).pColuna('Descricaos', '', '', 'Departamento', 290, .T.)
.pfSqlTabela(1).pColuna('Diretors',   '', '', 'Diretor',     080, .T.)
```

### Sistema Novo (GridBase.ConfigurarColunas)
O novo sistema usa array com estrutura diferente:
```foxpro
* Array: [n, 1]=Campo, [n, 2]=Titulo, [n, 3]=Largura, [n, 4]=Alinhamento
DIMENSION loc_aConfig[3, 4]

loc_aConfig[1, 1] = "codigos"       && Campo
loc_aConfig[1, 2] = "Codigo"        && Titulo (header)
loc_aConfig[1, 3] = 80              && Largura
loc_aConfig[1, 4] = 0               && Alinhamento (0=Esq, 1=Dir, 2=Centro)

loc_aConfig[2, 1] = "Descricaos"
loc_aConfig[2, 2] = "Departamento"
loc_aConfig[2, 3] = 290
loc_aConfig[2, 4] = 0

loc_aConfig[3, 1] = "Diretors"
loc_aConfig[3, 2] = "Diretor"
loc_aConfig[3, 3] = 80
loc_aConfig[3, 4] = 0

loc_oGrid.ConfigurarColunas(@loc_aConfig)
loc_oGrid.VincularCursor("cursor_4c_Dados")
```

### Mapeamento pColuna -> ConfigurarColunas
| pColuna (antigo) | ConfigurarColunas (novo) |
|------------------|--------------------------|
| Param 1: Campo   | Array [n, 1]: Campo      |
| Param 4: Titulo  | Array [n, 2]: Titulo     |
| Param 5: Largura | Array [n, 3]: Largura    |
| N/A              | Array [n, 4]: Alinhamento|

## Grid Column Lookups - DEFINITIVE SOLUTION

**IMPORTANTE**: BINDEVENT **NÃO funciona de forma confiável** para eventos de colunas de Grid (DblClick, KeyPress, Valid). A solução é criar **custom TextBox classes com eventos embutidos**.

### Step 1: Create Custom TextBox Classes

Create classes in `app/classes/TextBoxGridLookup.prg`:

```foxpro
*-- Base class with lookup functionality
DEFINE CLASS TextBoxGridBase AS TextBox
    this_cTabela = ""           && Lookup table
    this_cCampoCodigo = ""      && Code field
    this_cCampoDescricao = ""   && Description field
    this_cTitulo = ""           && Search window title

    PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)  && F4/F5
            THIS.AbrirBusca()
            NODEFAULT
        ENDIF
    ENDPROC

    PROCEDURE DblClick()
        THIS.AbrirBusca()
    ENDPROC

    PROCEDURE Valid()
        * Validate and open lookup if not found
        RETURN .T.
    ENDPROC

    PROCEDURE AbrirBusca()
        * Open FormBuscaAuxiliar
    ENDPROC
ENDDEFINE

*-- Specific class for a lookup table
DEFINE CLASS TextBoxGridGrupos AS TextBoxGridBase
    PROCEDURE Init()
        THIS.this_cTabela = "SigCdGcr"
        THIS.this_cCampoCodigo = "Codigos"
        THIS.this_cCampoDescricao = "Descrs"
        THIS.this_cTitulo = "Busca de Grupos Financeiros"
        RETURN .T.
    ENDPROC
ENDDEFINE
```

### Step 2: Load Classes in config.prg

**IMPORTANT**: SET PROCEDURE must be in `config.prg`, NOT in the form file. Commands at the top of a PRG file are not executed when the class is instantiated with CREATEOBJECT.

```foxpro
* In config.prg (before loading the form):
SET PROCEDURE TO (gcCaminhoClasses + "TextBoxGridLookup.prg") ADDITIVE

* In the form's ConfigurarGridCentroCusto:
WITH loc_oGrid
    .Column1.ControlSource = "cursor_4c_CCLocal.Grupos"
    .Column1.Width = 80
    .Column1.Header1.Caption = "Grupo"

    * Remove default TextBox and add custom class
    IF PEMSTATUS(.Column1, "Text1", 5)
        .Column1.RemoveObject("Text1")
    ENDIF
    .Column1.AddObject("txtGrupos", "TextBoxGridGrupos")
    .Column1.txtGrupos.InputMask = "!!!!!!!!!!"
    .Column1.txtGrupos.Visible = .T.
    .Column1.CurrentControl = "txtGrupos"
ENDWITH
```

### Why This Works

1. **Native VFP events**: Valid, KeyPress, DblClick are defined inside the class, not via BINDEVENT
2. **Runs in context**: The TextBox methods run when the user interacts with the cell
3. **Full control**: Each lookup type has its own class with specific behavior
4. **Consistent**: F4/F5, DblClick, and validation all trigger the same lookup

### Example Implementation

See `FormCargo.prg` for a complete implementation with:
- `TextBoxGridGrupos` - Lookup for Grupos Financeiros (SigCdGcr)
- `TextBoxGridContas` - Lookup for Contas (SigReCtb) filtered by Grupo
- `TextBoxGridMoedas` - Lookup for Moedas (SigCdMoe)

## Subtabelas (Grids Editaveis com Persistencia)

Padrao para formularios com subtabelas (ex: Centro de Custo em Cargos):

### 1. Criar Cursor Local para Edicao
```foxpro
PROTECTED PROCEDURE CriarCursorSubtabela()
    IF USED("cursor_4c_SubLocal")
        USE IN cursor_4c_SubLocal
    ENDIF

    CREATE CURSOR cursor_4c_SubLocal (;
        Campo1 C(10), ;
        Campo2 C(20), ;
        ValorN N(14, 2))

    THIS.ConfigurarGridSubtabela()
ENDPROC
```

### 2. Carregar Dados do Banco para o Cursor Local
```foxpro
PROTECTED PROCEDURE CarregarSubtabela(par_cChave)
    LOCAL loc_cCampo1, loc_cCampo2, loc_nValor

    THIS.CriarCursorSubtabela()

    IF THIS.this_oBusinessObject.CarregarSubtabela(par_cChave)
        IF USED("cursor_4c_SubRemoto") AND RECCOUNT("cursor_4c_SubRemoto") > 0
            SELECT cursor_4c_SubRemoto
            GO TOP
            SCAN
                * Captura valores ANTES de mudar de cursor
                loc_cCampo1 = ALLTRIM(cursor_4c_SubRemoto.Campo1)
                loc_cCampo2 = ALLTRIM(cursor_4c_SubRemoto.Campo2)
                loc_nValor = cursor_4c_SubRemoto.ValorN

                * Insere no cursor local
                INSERT INTO cursor_4c_SubLocal (Campo1, Campo2, ValorN) ;
                    VALUES (loc_cCampo1, loc_cCampo2, loc_nValor)
            ENDSCAN
            USE IN cursor_4c_SubRemoto
        ENDIF
    ENDIF

    SELECT cursor_4c_SubLocal
    IF RECCOUNT() = 0
        APPEND BLANK  && Linha em branco para edicao
    ENDIF
    GO TOP
    THIS.pgf_4c_Paginas.Page2.grd_4c_Subtabela.Refresh()
ENDPROC
```

### 3. Salvar do Cursor Local para o Banco (no BO)
```foxpro
PROCEDURE SalvarSubtabela(par_cChave, par_cCursorOrigem)
    * Primeiro exclui registros existentes
    loc_cSQL = "DELETE FROM TabelaSubtabela WHERE ChavePai = " + EscaparSQL(par_cChave)
    SQLEXEC(gnConnHandle, loc_cSQL)

    * Insere novos registros do cursor local
    IF USED(par_cCursorOrigem) AND RECCOUNT(par_cCursorOrigem) > 0
        SELECT (par_cCursorOrigem)
        GO TOP
        SCAN
            loc_cCampo1 = ALLTRIM(Campo1)
            loc_cCampo2 = ALLTRIM(Campo2)
            loc_nValor = ValorN

            * So insere se tiver dados validos (ignora linhas em branco)
            IF !EMPTY(loc_cCampo1) AND !EMPTY(loc_cCampo2)
                loc_cSQL = "INSERT INTO TabelaSubtabela (...) VALUES (...)"
                SQLEXEC(gnConnHandle, loc_cSQL)
            ENDIF
        ENDSCAN
    ENDIF
    RETURN .T.
ENDPROC
```

### 4. Validacao de Duplicidade
```foxpro
PROTECTED PROCEDURE ValidarDuplicidadeSubtabela()
    LOCAL loc_cCampo1, loc_cCampo2, loc_nRecno, loc_nCount

    IF !USED("cursor_4c_SubLocal")
        RETURN
    ENDIF

    loc_cCampo1 = ALLTRIM(cursor_4c_SubLocal.Campo1)
    loc_cCampo2 = ALLTRIM(cursor_4c_SubLocal.Campo2)

    IF EMPTY(loc_cCampo1) OR EMPTY(loc_cCampo2)
        RETURN
    ENDIF

    loc_nRecno = RECNO("cursor_4c_SubLocal")

    SELECT cursor_4c_SubLocal
    COUNT FOR ALLTRIM(Campo1) == loc_cCampo1 AND ;
              ALLTRIM(Campo2) == loc_cCampo2 TO loc_nCount

    GO loc_nRecno IN cursor_4c_SubLocal

    IF loc_nCount > 1
        MsgAviso("Combinacao ja existe!")
        REPLACE Campo1 WITH "", Campo2 WITH "" IN cursor_4c_SubLocal
    ENDIF
ENDPROC
```

## Grid Properties Reference

### Standard Grid Properties
```foxpro
WITH loc_oGrid
    .ScrollBars = 2                        && SOMENTE VERTICAL (nao 3)
    .GridLineColor = RGB(238, 238, 238)    && Cinza claro para linhas
    .RowHeight = 16                        && Altura da linha
    .ForeColor = RGB(90, 90, 90)           && Texto cinza escuro
    .BackColor = RGB(255, 255, 255)        && Fundo branco
    .HighlightBackColor = RGB(255, 255, 255)
    .HighlightForeColor = RGB(15, 41, 104) && Azul escuro
    .HighlightStyle = 2
    .DeleteMark = .F.                      && Sem marca de exclusao
    .RecordMark = .F.                      && Sem marca de registro
    .FontName = "Verdana"                  && OU "Tahoma"
    .FontSize = 8
ENDWITH
```

## InputMask in Grid Columns

**IMPORTANTE**: InputMask deve ser definido no Text1 da coluna, NÃO na Column:

```foxpro
* CORRETO:
.Column1.Text1.InputMask = "!!!!!!!!!!"  && Forces uppercase

* ERRADO:
.Column1.InputMask = "!!!!!!!!!"  && Nao funciona
```

### Common InputMask Patterns

| Pattern | Meaning | Example |
|---------|---------|---------|
| `!` | Uppercase letter conversion | `!!!!!!!!!!` for codes |
| `9` | Numeric digit only (0-9) | `999.99` for decimals |
| `X` | Any character | `XXXX` for free text |
| `S,N, ` | Restrict to S, N or space | `S,N, ` for yes/no |
