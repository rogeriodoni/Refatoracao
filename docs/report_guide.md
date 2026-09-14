# Report Implementation Guide

## Creating Reports Programmatically (Recommended)

Use `GeradorRelatorio` class to create FRX files via code (similar to forms):

```foxpro
* In app/reports/GerarRelXxx.prg:
LOCAL loc_oGerador

loc_oGerador = CREATEOBJECT("GeradorRelatorio", ;
    "C:\4c\projeto\app\reports\RelXxx.frx", ;
    "Titulo do Relatorio", ;
    "cursor_4c_Dados")

loc_oGerador.Criar()

* Page Header
loc_oGerador.AdicionarPageHeader(1.200)
loc_oGerador.AdicionarLabel([gc_4c_CabecalhoRelatorio], 0, 0.100, 0.100, 5.000, "Arial", 14, .T.)
loc_oGerador.AdicionarLabel(["Subtitulo"], 0, 0.500, 0.100, 4.000, "Arial", 12, .T.)
loc_oGerador.AdicionarLinha(0, 1.050, 0.000, 10.000, 1)

* Column Header
loc_oGerador.AdicionarColHeader(0.350)
loc_oGerador.AdicionarLabel(["Coluna1"], 1, 0.080, 0.100, 2.000, "Arial", 9, .T.)
loc_oGerador.AdicionarLabel(["Coluna2"], 1, 0.080, 2.200, 4.000, "Arial", 9, .T.)

* Detail
loc_oGerador.AdicionarDetail(0.280)
loc_oGerador.AdicionarCampo("campo1", 4, 0.040, 0.100, 2.000, "Arial", 9, .F.)
loc_oGerador.AdicionarCampo("campo2", 4, 0.040, 2.200, 4.000, "Arial", 9, .F.)

* Page Footer
loc_oGerador.AdicionarPageFooter(0.400)
loc_oGerador.AdicionarLabel(["P" + CHR(225) + "gina " + ALLTRIM(STR(_PAGENO))], 7, 0.150, 4.500, 1.500, "Arial", 8, .F.)

loc_oGerador.Finalizar()
```

## GeradorRelatorio Methods

| Method | Parameters | Description |
|--------|------------|-------------|
| Criar() | - | Creates FRX structure |
| AdicionarPageHeader(altura) | altura | Adds page header band |
| AdicionarColHeader(altura) | altura | Adds column header band |
| AdicionarDetail(altura) | altura | Adds detail band |
| AdicionarPageFooter(altura) | altura | Adds page footer band |
| AdicionarLabel(texto, banda, top, left, width, fonte, tamanho, negrito) | ... | Adds text label |
| AdicionarCampo(campo, banda, top, left, width, fonte, tamanho, negrito) | ... | Adds data field |
| AdicionarLinha(banda, top, left, width, espessura) | ... | Adds horizontal line |
| Finalizar() | - | Saves and closes FRX |

## Band Codes
- 0 = Page Header
- 1 = Column Header
- 4 = Detail
- 7 = Page Footer

## Migrating Legacy FRX Files

When migrating legacy FRX files, use `CriarNovoFRX.prg` to:
1. Copy the legacy FRX/FRT files
2. Update variable names to standardized nomenclature

```foxpro
* In app/reports/CriarNovoFRX.prg:
* Uses COPY FILE to preserve FRX structure, then SCAN to update variables:
* - gcLogoRel → gc_4c_LogoRelatorio
* - gcCabRel → gc_4c_CabecalhoRelatorio
* - goSistema.* → go_4c_Sistema.*
```

**IMPORTANT**: Creating FRX from scratch programmatically is complex. The simplified structure may cause "Report file is invalid" or "No records found for current platform" errors. Always use legacy FRX as base and update variables.

## Using Reports (RelatorioBase)

```foxpro
DEFINE CLASS RelatorioXxx AS RelatorioBase
    PROCEDURE Init()
        DODEFAULT("C:\4c\projeto\app\reports\RelXxx.frx", "Titulo")
        THIS.this_cCursorDados = "cursor_4c_Dados"
        RETURN .T.
    ENDPROC
ENDDEFINE

* Usage:
loc_oRelatorio = CREATEOBJECT("RelatorioXxx")
loc_oRelatorio.Visualizar()     && Preview
loc_oRelatorio.Imprimir()       && Print
loc_oRelatorio.ExportarPDF()    && Export to HTML (VFP9 limitation)
```

## VFP9 Report Limitations

1. **No native PDF export** - Use HTML export, user prints to PDF from browser
2. **REPORT FORM syntax** - Do NOT use `NOCONSOLE` with `TYPE HTML`:
```foxpro
* WRONG:
REPORT FORM myreport TO FILE myfile.html TYPE HTML NOCONSOLE

* CORRECT:
REPORT FORM myreport TO FILE myfile.html TYPE HTML
```

## Report Toolbar Icons

Standard icons for report toolbar buttons (located in `gc_4c_CaminhoIcones`):

| Button | Icon File |
|--------|-----------|
| Video (Preview) | `relatorio_video_26.jpg` |
| Impressora (Print) | `relatorio_impressora_26.jpg` |
| Email | `geral_envelope_32.jpg` |
| Encerrar (Exit) | `relatorio_sair_60.jpg` |

```foxpro
* Example usage:
cmdVisualizar.Picture = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
cmdImprimir.Picture = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
cmdEmail.Picture = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
cmdSair.Picture = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
```

## Report Forms (frmrelatorio) - Formularios de Relatorio

### Diferenca entre CRUD e REPORT

| Aspecto | CRUD (frmcadastro) | REPORT (frmrelatorio) |
|---------|-------------------|----------------------|
| BO herda de | BusinessBase | **RelatorioBase** |
| Layout | PageFrame (Page1=Lista, Page2=Dados) | **FLAT** (filtros + botoes) |
| Metodo chave | FormParaBO / BOParaForm | **FormParaRelatorio** |
| Acao principal | INSERT/UPDATE/DELETE | PrepararDados() + REPORT FORM |
| Botoes | Incluir/Alterar/Excluir/Buscar/Encerrar | **Imprimir/Visualizar/Cancelar** |
| TesteAutomatico | CarregarLista + ModoIncluir | FormParaRelatorio + BotoesRelatorio |

### Destroy em Forms REPORT (CRITICO!)

```foxpro
*-- BO/RelatorioBase herda de Custom, NAO de Form
*-- Custom NAO tem metodo .Release()!

*-- ERRADO - "Property RELEASE is not found":
PROCEDURE Destroy()
    IF VARTYPE(THIS.this_oRelatorio) = "O"
        THIS.this_oRelatorio.Release()   && ERRO! Custom nao tem Release!
    ENDIF
ENDPROC

*-- CORRETO:
PROCEDURE Destroy()
    IF VARTYPE(THIS.this_oRelatorio) = "O"
        THIS.this_oRelatorio = .NULL.    && Limpa referencia
    ENDIF
    DODEFAULT()
ENDPROC
```

### Validar* (LostFocus) em Forms REPORT

Forms de relatorio frequentemente tem campos de filtro com validacao por LostFocus. Quando o usuario digita uma descricao e sai do campo, o sistema busca o codigo correspondente.

```foxpro
*-- Padrao: ValidarXxx() chamado via BINDEVENT LostFocus
PROCEDURE ValidarNomGer()
    LOCAL loc_cValor
    loc_cValor = ALLTRIM(THIS.txt_4c_NomGer.Value)
    IF EMPTY(loc_cValor)
        THIS.txt_4c_CodGer.Value = ""
        THIS.txt_4c_NomGer.Value = ""
        RETURN
    ENDIF
    *-- Busca reversa por nome
    THIS.AbrirBuscaNomGer()
ENDPROC
```

**REGRA**: Validar* procedures NUNCA devem ser vazias. Cada uma deve:
1. Ler valor do campo descricao
2. Se vazio, limpar campos relacionados
3. Se preenchido, abrir busca reversa (FormBuscaAuxiliar)

### Tecla* (KeyPress) em Forms REPORT

Handlers de KeyPress para campos de data ou campos que NAO precisam de lookup F4/F5 sao **intencionalmente vazios**:

```foxpro
*-- Campos de data nao precisam de lookup
PROCEDURE TeclaDataIni(par_nKeyCode, par_nShiftAltCtrl)
    *-- Sem acao especial para teclas em campo de data
ENDPROC
```

**REGRA**: Tecla* com `par_nKeyCode` no parametro sao validos mesmo vazios (Test-CompletudeCodigo os ignora).
