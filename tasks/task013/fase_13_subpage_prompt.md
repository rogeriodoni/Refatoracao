# FASE 13 - Migrar Sub-Pagina: pgDadosFiscais (Page6 de pgf_4c_DadosInternos)

Voce esta adicionando controles na **Page6** do PageFrame interno `pgf_4c_DadosInternos` do form `FormProduto.prg`.

=== INSTRUCOES ESPECIFICAS DO USUARIO ===
INSTRUCOES ESPECIFICAS PARA MIGRACAO DO CADASTRO DE PRODUTOS (sigcdpro)

=== TABELA PRINCIPAL ===
- Tabela principal do BO: SigCdPro (NAO SigPrFtp!)
- SigPrFtp eh tabela AUXILIAR de ficha tecnica, usada APENAS na sub-pagina pgComposicao
- Campo chave (PK): cpros
- O BO (ProdutoBO) DEVE mapear TODAS as colunas de SigCdPro (150+ campos)
- Consultar schema.sql para lista completa de colunas

=== ESTRUTURA DO FORM ===
- Form CRUD com PageFrame principal (Page1=Lista, Page2=Dados)
- Page2 tem PageFrame INTERNO (pgframeDados) com 7 abas:
  1. pgDados - Dados principais do produto (tab principal)
  2. pgComposicao - Composicao/ficha tecnica (usa SigPrCpo, SigSubCp, SigPrFtp)
  3. pgDadosFiscais - Dados fiscais (classificacao, origem, tributos)
  4. PgDadosFaseP - Fases de producao (usa SigCdPrf, matrizes)
  5. PgDadosConsP - Consulta de componentes
  6. pgCusto - Custos e precificacao
  7. pgDesigner - Designer/tarefas (usa SigPrTar, SigPrArq)

=== CAMPOS BIT (LOGICAL) em SigCdPro ===
Estes campos sao BIT no SQL Server e devem ser declarados como this_lXxx = .F. (NAO this_nXxx = 0):
- instalas, prodwebs, opcvars, consigs, fabrproprs, encoms, chkgarvit, cravcers, varias

=== TABELAS AUXILIARES (NAO confundir com principal) ===
- SigPrFtp: Ficha tecnica de produto (cgrus, cods, coefs, cpros, pkchaves, valors)
- SigPrCpo: Composicao do produto (componentes)
- SigSubCp: Sub-componentes
- SigCdPrf: Fases de producao
- SigPrTar: Tarefas do designer
- SigPrArq: Arquivos do designer

=== LOOKUPS ===
O form legado tem ~20 lookups diferentes. TODOS devem usar FormBuscaAuxiliar com mAddColuna.
Principais: Grupo (SigCdGrp), SubGrupo (SigCdPsg), Linha, Cor (SigCdCor), Tamanho (SigCdTam),
Fornecedor (SigCdCli), Acabamento (SigCdAca), Classificacao, Local, Unidade, etc.

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

## CONTROLES ESPERADOS (54 objetos)
Buscar no codigo fonte original todos os controles sob a pagina `pgDadosFiscais`.
Implementar TODOS - NUNCA omitir ou criar stubs TODO.
