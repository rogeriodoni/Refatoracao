# FormProduto - Layout Original (SIGCDPRO)

**Data**: 2026-01-16
**Fonte**: C:\4c\tasks\task5\SIGCDPRO_form_codigo_fonte.txt

## Estrutura do PageFrame Aninhado

```
pgf_4c_Principal (Pagina)
├── Page1: Lista (Grid + botões CRUD)
└── Page2: Dados
    ├── Grupo_Salva (Confirmar/Cancelar) - Left=842, Top=5
    ├── CntQtMin (Grid quantidade mínima)
    └── pgframeDados (PageFrame aninhado)
        ├── pgDados (Dados Principais) ← FASE 1
        ├── pgComposicao (Custos)
        ├── pgDadosFiscais (Dados Fiscais)
        ├── PgDadosFaseP (Processos)
        ├── PgDadosConsP (Consumo)
        ├── pgCusto (Composição)
        └── pgDesigner (Page1)
```

## pgframeDados - Propriedades

| Propriedade | Valor | Observação |
|-------------|-------|------------|
| **Top** | **-54** | **CRITICO: Esconde abas (sobe 54 pixels)** |
| **Left** | **-1** | |
| **Width** | **1003** | |
| **Height** | **656** | |
| **PageCount** | **7** | 7 páginas (FASE 1: apenas pgDados) |
| **TabStyle** | **0** | |
| **TabStretch** | **0** | |
| **ErasePage** | **.T.** | |

## pgDados (Page1) - 15 Campos Básicos (FASE 1)

| # | Campo Form | Campo BD | Left | Top | Width | Height | MaxLength | InputMask |
|---|------------|----------|------|-----|-------|--------|-----------|-----------|
| 1 | txt_4c_Codigo | cpros | **113** | **130** | **108** | **23** | 14 | - |
| 2 | txt_4c_Descricao | dpros | **222** | **130** | **290** | **23** | 65 | - |
| 3 | opc_4c_Situacao | situas | **735** | **130** | **142** | **25** | - | - |
| 4 | txt_4c_CodigoBarras | cbars | **626** | **155** | **108** | **21** | 14 | 99999999999999 |
| 5 | txt_4c_Grupo | cgrus | **113** | **178** | **31** | **23** | 3 | - |
| 6 | txt_4c_DescGrupo | dgrus | **145** | **178** | **171** | **23** | 20 | - |
| 7 | txt_4c_ObsPessoal | obspes | **626** | **265** | **220** | **21** | 30 | !!!!!!!!!!!!!!!!!!!!!!!!!!!!!! |
| 8 | txt_4c_Fornecedor | ifors | **113** | **274** | **80** | **23** | 10 | - |
| 9 | txt_4c_DescFornecedor | dfors | **194** | **274** | **318** | **23** | 50 | - |
| 10 | txt_4c_ObsPedidos | obspeds | **626** | **287** | **220** | **21** | 30 | !!!!!!!!!!!!!!!!!!!!!!!!!!!!!! |
| 11 | txt_4c_RefFornecedor | reffs | **113** | **298** | **152** | **23** | 40 | - |
| 12 | txt_4c_CustoFornecedor | custofs | **626** | **375** | **127** | **21** | 14 | 9,999,999.99999 |
| 13 | txt_4c_PrecoVenda | pvens | **626** | **397** | **127** | **21** | 14 | 9,999,999.99999 |
| 14 | txt_4c_DataInclusao | dtincs | **833** | **397** | **79** | **21** | 8 | - |
| 15 | txt_4c_FatorVenda | fvendas | **626** | **419** | **127** | **21** | 9 | 9,999,999.99999 |

## Labels (Say) - Identificados

| Label | Caption | Left | Top | Width | Height | ForeColor |
|-------|---------|------|-----|-------|--------|-----------|
| lblCodigo | "C" + CHR(243) + "digo :" | 65 | 134 | ~47 | 15 | 90,90,90 |
| lblDescricao | "Descri" + CHR(231) + CHR(227) + "o :" | 157 | 134 | ~59 | 15 | 90,90,90 |
| lblGrupo | "Grupo :" | 73 | 182 | 38 | 15 | 90,90,90 |
| lblFornecedor | "Fornecedor :" | 40 | 278 | ~70 | 15 | 90,90,90 |
| lblRefFornecedor | "Refer" + CHR(234) + "ncia :" | 50 | 302 | ~60 | 15 | 90,90,90 |
| lblCusto | "Valor de Custo :" | 546 | 379 | 79 | 15 | 90,90,90 |
| lblPrecoVenda | "Valor de Venda :" | 505 | 400 | ~120 | 15 | 90,90,90 |
| lblFatorVenda | "Fator de Venda :" | ~520 | 423 | ~105 | 15 | 90,90,90 |
| lblObsPessoal | "Observa" + CHR(231) + CHR(227) + "o Pessoal :" | ~540 | 269 | ~80 | 15 | 90,90,90 |
| lblObsPedidos | "Observa" + CHR(231) + CHR(227) + "o para Pedidos :" | ~510 | 291 | ~110 | 15 | 90,90,90 |
| lblDataUsuario | "Data / Usu" + CHR(225) + "rio" | 833 | 365 | 84 | ~ | - |
| lblCodigoBarras | "C" + CHR(243) + "digo de Barras :" | ~540 | 159 | ~80 | 15 | 90,90,90 |

## Observações Críticas

### 1. pgframeDados.Top = -54 (CRITICO!)
- **Esconde as abas** do PageFrame aninhado
- Todos os controles DENTRO das Pages NÃO precisam compensar (coordenadas relativas à Page)
- Controles FORA do pgframeDados (na Page2) SIM precisam considerar essa posição

### 2. Cores e Fontes
- **BackColor dos campos de custo/preço**: RGB(224, 235, 235) - Azul claro
- **ForeColor dos campos de custo/preço**: RGB(36, 84, 155) - Azul escuro
- **ForeColor dos labels**: RGB(90, 90, 90) - Cinza
- **FontName**: Tahoma (labels), Verdana (abas)
- **FontSize**: 8 (padrão)

### 3. Botões Confirmar/Cancelar (Grupo_Salva)
- **Left**: 842 (canto direito)
- **Top**: 5 (topo da Page2)
- **FORA** do pgframeDados (direto na Page2)

### 4. OptionGroup Situação
- **Opção 1**: "Ativo" (Value=1)
- **Opção 2**: "Inativo - Após :" (Value=0)
- **Alignment**: 2 (horizontal com text à esquerda do radio)

### 5. Imagens no pgDados
- **shpFig (Shape)**: Left=543, Top=520, Width=174, Height=103
- **ImgFigJpg (Image)**: Left=544, Top=521, Width=172, Height=101

## Próximos Passos (FASE 2 - Continuação)

Após implementar corretamente o layout dos 15 campos, adicionar:
- **+5 páginas**: pgComposicao, pgDadosFiscais, PgDadosFaseP, PgDadosConsP, pgCusto
- **+25 campos** adicionais distribuídos pelas páginas
- **+13 lookups** adicionais
- **Grid secundário**: CntQtMin (Quantidade Mínima)

## Referência

- **Arquivo original**: C:\4c\tasks\task5\SIGCDPRO_form_codigo_fonte.txt
- **Linhas relevantes**:
  - pgframeDados: 4322-4386
  - Campos: 4415-5500
