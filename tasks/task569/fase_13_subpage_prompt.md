# FASE 13 - Migrar Sub-Pagina: pgDadosFiscais (Page6 de pgf_4c_DadosInternos)

Voce esta adicionando controles na **Page6** do PageFrame interno `pgf_4c_DadosInternos` do form `FormProduto.prg`.

=== INSTRUCOES ESPECIFICAS DO USUARIO ===
RE-MIGRACAO DO SIGCDPRO (Cadastro de Produtos) - Erro178, 2026-09-24

MOTIVO: a migracao anterior (task504) entregou a pagina "Dados Principais"
PELA METADE e trocou o paradigma de navegacao. Medido cruzando o layout.json
com o _mapeamento.json e o FormProduto.prg gerado:

  pgDados (Dados Principais)  legado = 176 controles
                              presentes no .prg = 35
                              AUSENTES = 141

  Ausentes por tipo: 63 textbox, 31 label, 20 commandgroup, 16 checkbox,
                     4 editbox, 2 image, 2 shape, 2 optiongroup, 1 commandbutton

  As OUTRAS SEIS paginas estavam corretas, 1 para 1 com o legado:
  pgCusto 11, pgDadosFiscais 58, PgDadosFaseP 54, PgDadosConsP 6,
  pgDesigner 21, pgComposicao (74 + 10 do cntMtPrima).

O QUE A NOVA MIGRACAO TEM DE ACERTAR

1) pgDados COMPLETA - os 176 controles.
   Blocos que sumiram inteiros na migracao anterior (conferir contra a tela de
   referencia sigcdpro_02.png, que mostra a pagina cheia):
     - coluna da DIREITA: Equivalente, Barra, EAN/GTIN, Qtde. Minima,
       Qtde. Pedido, Obs. Componente, Observacao, Complemento, Ult. Compra,
       Qtde Ult. Compra, Estoque, Valor de Custo, Valor de Venda, Fator de Venda
     - coluna da EXTREMA DIREITA: Ativo/Inativo-Apos, Lote Minimo, Produto Web
       (Sim/Nao/So Valor/So Estoque), Variacao, Garantia + Vitalicia,
       Altura, Largura, Diametro, Espessura, Comprimento (MM/CM)
     - bloco INFERIOR: EditBox "Descricao de Compra", EditBox "Descricao
       Completa", EditBox "Observacao da Compra", Situacao (Consigna /
       Fabr. Propria / Encomenda), Entrega, Dimensao (3 campos + ppp/aaa/ccc),
       Volumes, "Imagem Principal" e "Imagem Tecnica" (2 image + botoes)
     - Data / Usuario: Inclusao (Get_DtIncs, Get_Usuario) e Alteracao
       (getDataAlts, getUsuaAlts)
   Os 63 textbox NAO sao so desenho: cada um precisa de bind, de entrada em
   FormParaBO/BOParaForm e, quando o legado tem, do lookup (os 20 commandgroup
   sao os botoes de busca ao lado dos campos). Tela cheia que nao grava eh
   violacao da REGRA FUNDAMENTAL do projeto.

2) NAVEGACAO - o legado NAO usa abas visiveis.
     SIGCDPRO.Pagina.Dados.pgframeDados : top = -58   <- abas ESCONDIDAS
     SIGCDPRO.Pagina.Dados.Optiongroup1 : top=3 left=8 width=610 height=85
                                          ButtonCount = 8
     cada botao: Style=1 (grafico), 75x75, Top=5, Picture do framework
                 (ex.: Option1 = geral_produtos_60.jpg, Caption "\<Principal",
                 Name "optDados"), ForeColor 90,90,90, BackColor branco,
                 Themes = .F., FontName "Comic Sans MS", FontBold+FontItalic
   Quem troca de pagina eh esse OptionGroup (mesmo padrao do clsconta no
   FormCliente - CLAUDE.md regra #31). A migracao anterior criou um PageFrame
   com .Tabs = .T. em Top=120 e, de quebra, a barra de abas cortou os botoes
   Salvar/Encerrar que ficam em Top=85.
   Com as abas ocultas e a geometria do legado, as coordenadas do layout.json
   entram DIRETAS, sem o deslocamento que originou a regra #39.

3) NAO REGREDIR o que ja estava certo:
   - as seis paginas listadas acima batem com o legado - manter a contagem;
   - AlternarPagina(1) tem de repor this_cModoAtual = "LISTA" E chamar
     THIS.AjustarBotoesPorModo() no fim (CLAUDE.md regra #40 / Erro176): sem
     isso os botoes CRUD ficam cinza depois de gravar;
   - Buscar eh busca POR EXEMPLO do legado (abre a ficha em branco com os
     campos plProcurar editaveis e o Confirmar executa o LocateCursor), NUNCA
     um picker FormBuscaAuxiliar inventado (Erro167 / Erro177).

REFERENCIA VISUAL: sigcdpro_01.png (pagina Lista) e sigcdpro_02.png (pagina
Dados Principais cheia). As demais (03..08) sao as outras abas.

ADENDO (12:52) - O "BUSCAR" DESTE FORM TAMBEM EH BUSCA POR EXEMPLO

Conferido no dump do proprio SIGCDPRO: existe PROCEDURE msv_procurar e SETE
campos marcados com plprocurar = .T. na pgDados. NAO existe picker.

  PROCEDURE msv_procurar
    pGru = Padr(...Pagina.Lista.cntFiltros.getCgru.Value, 3)
    pPro = Padr(...pgDados.getCpro.Value, 14)
    pDes = Padr(...pgDados.getDpro.Value, 40)
    pD2s = Padr(...pgDados.getDpro2s.Value, 40)
    pRff = Padr(...pgDados.getRefs.Value, 15)
    pFor = Padr(...pgDados.Getifor.Value, 10)
    pBar = ...pgDados.getCbar.Value
    pCnj = ...pgDados.getconjunto.Value
    lcBus = Iif(Empty(pGru), [], [CGrus = ?pGru And ])
    Do Case
      Case Not Empty(pPro)   -> CursorQuery([SigCdPro], [crTmp], [CPros], pPro)
      Case Not Empty(pDes)   -> SqlExecute([Select * From SigCdPro Where ] + lcBus + [DPros = ?pDes], [crTmp])
      ...                    (transcrever o Do Case INTEIRO do dump, na ordem)
    EndCase
  (ThisForm.Tipo2 escolhe entre SigCdPro e SigCdPrc - preservar)

Portanto o BtnBuscarClick do form migrado NAO pode chamar
CREATEOBJECT("FormBuscaAuxiliar"): tem de abrir a ficha em branco em modo
BUSCAR com os campos plProcurar editaveis (getCpro, getDpro, getDpro2s,
getRefs, Getifor, getCbar, getconjunto) e deixar o Confirmar executar o
msv_procurar. A migracao anterior (task504) errou exatamente isso - eh o mesmo
defeito do Erro167 (FormCliente) e do Erro177 (Formgpd), na terceira tela.

Ver tambem as regras #40 (Erro176) e a secao 226/227 da skill vfp9-migration.

=== FIM DAS INSTRUCOES ===

## TAREFA
1. Leia o form existente: `C:\4c\projeto\app\forms\cadastros\FormProduto.prg`
2. Leia o codigo fonte original para encontrar todos os controles da pagina `pgDadosFiscais`
3. Crie um novo metodo `PROTECTED PROCEDURE ConfigurarPgpgDadosFiscais()` no form
4. Dentro do metodo, adicione TODOS os controles que existem na pagina `pgDadosFiscais` do original
5. Adicione a chamada `THIS.ConfigurarPgpgDadosFiscais()` no metodo `ConfigurarPaginaDados()` ANTES de `THIS.TornarControlesVisiveis`
6. Para cada controle de lookup/KeyPress, adicione o BINDEVENT e os handlers correspondentes

## ACESSO A PAGINA
```foxpro
LOCAL loc_oPgN
loc_oPgN = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page6

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

## CONTROLES ESPERADOS (64 objetos)
Buscar no codigo fonte original todos os controles sob a pagina `pgDadosFiscais`.
Implementar TODOS - NUNCA omitir ou criar stubs TODO.
