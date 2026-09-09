# FASE 10 - Migrar Sub-Pagina: pgDesconto (Page3 de pgf_4c_DadosInternos)

Voce esta adicionando controles na **Page3** do PageFrame interno `pgf_4c_DadosInternos` do form `FormTbv.prg`.

## TAREFA
1. Leia o form existente: `C:\4c\projeto\app\forms\cadastros\FormTbv.prg`
2. Leia o codigo fonte original para encontrar todos os controles da pagina `pgDesconto`
3. Crie um novo metodo `PROTECTED PROCEDURE ConfigurarPgpgDesconto()` no form
4. Dentro do metodo, adicione TODOS os controles que existem na pagina `pgDesconto` do original
5. Adicione a chamada `THIS.ConfigurarPgpgDesconto()` no metodo `ConfigurarPaginaDados()` ANTES de `THIS.TornarControlesVisiveis`
6. Para cada controle de lookup/KeyPress, adicione o BINDEVENT e os handlers correspondentes

## ACESSO A PAGINA
```foxpro
LOCAL loc_oPgN
loc_oPgN = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page3

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

## CONTROLES ESPERADOS (70 objetos)
Buscar no codigo fonte original todos os controles sob a pagina `pgDesconto`.
Implementar TODOS - NUNCA omitir ou criar stubs TODO.
