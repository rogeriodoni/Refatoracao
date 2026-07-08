# FASE 9 - Migrar Sub-Pagina: Page3 (Page2 de pgf_4c_DadosInternos)

Voce esta adicionando controles na **Page2** do PageFrame interno `pgf_4c_DadosInternos` do form `Formsigprdis.prg`.

## TAREFA
1. Leia o form existente: `C:\4c\projeto\app\forms\cadastros\Formsigprdis.prg`
2. Leia o codigo fonte original para encontrar todos os controles da pagina `Page3`
3. Crie um novo metodo `PROTECTED PROCEDURE ConfigurarPgPage3()` no form
4. Dentro do metodo, adicione TODOS os controles que existem na pagina `Page3` do original
5. Adicione a chamada `THIS.ConfigurarPgPage3()` no metodo `ConfigurarPaginaDados()` ANTES de `THIS.TornarControlesVisiveis`
6. Para cada controle de lookup/KeyPress, adicione o BINDEVENT e os handlers correspondentes

## ACESSO A PAGINA
```foxpro
LOCAL loc_oPgN
loc_oPgN = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page2

*-- Adicionar controles:
loc_oPgN.AddObject("lbl_4c_NomeLabel", "Label")
WITH loc_oPgN.lbl_4c_NomeLabel
    .Caption = "..."
    .Top = NNN     && COPIAR EXATO do layout.json/original
    .Left = NNN
    .Visible = .T.
ENDWITH
```

## REGRAS CRITICAS
- Copiar Top/Left/Width/Height EXATOS do codigo fonte original
- Usar CHR() para acentos (NUNCA literais)
- BINDEVENT handlers DEVEM ser PUBLIC (nao PROTECTED)
- EscaparSQL/FormatarNumeroSQL/FormatarDataSQL retornam COM aspas
- FormBuscaAuxiliar.Show() sem parametros
- MESSAGEBOX proibido - usar MsgInfo/MsgAviso/MsgErro/MsgConfirma
- Grids: criar cursor placeholder ANTES do RecordSource, ControlSource APOS RecordSource

## CONTROLES ESPERADOS (42 objetos)
Buscar no codigo fonte original todos os controles sob a pagina `Page3`.
Implementar TODOS - NUNCA omitir ou criar stubs TODO.
