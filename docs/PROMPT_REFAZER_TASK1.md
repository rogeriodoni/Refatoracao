# Prompt para Refazer Task1 (FormCor) - Versão Completa

**Data**: 2026-01-16
**Objetivo**: Migrar FormCor do zero aplicando TODAS as lições aprendidas

---

## 📋 Contexto

Você irá refazer a migração do **FormCor (Cadastro de Cores)** do sistema legado para a nova arquitetura, aplicando todas as correções documentadas em `docs/FORMCOR_LICOES_APRENDIDAS.md`.

---

## 🎯 Prompt para Claude Code

```
Preciso refazer a migração do FormCor (task1) do zero, aplicando todas as lições aprendidas.

ARQUIVOS DE REFERÊNCIA OBRIGATÓRIOS:
1. docs/FORMCOR_LICOES_APRENDIDAS.md - Ler COMPLETAMENTE antes de começar
2. CLAUDE.md - Seção "Compensação do PageFrame.Top = -29"
3. docs/migration_guide.md - Checklist geral
4. tasks/task1/SIGCDCOR_form_codigo_fonte.txt - Código fonte original
5. Framework/FormCargo.prg - Modelo de referência

REGRAS CRÍTICAS (NÃO DESVIAR):

1. PROBLEMA: Grade perde cabeçalhos após RecordSource
   SOLUÇÃO: SEMPRE reconfigurar Header1.Caption APÓS definir RecordSource

   CORRETO:
   loc_oGrid.RecordSource = "cursor_4c_Dados"
   loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cods"
   loc_oGrid.Column1.Header1.Caption = "Código"  ← OBRIGATÓRIO após RecordSource

2. PROBLEMA: Botões cortados no topo (PageFrame.Top = -29)
   SOLUÇÃO: Compensar +29 pixels em TODOS os controles de topo

   CORRETO:
   cnt_4c_Cabecalho.Top = 31    (2 + 29)
   cnt_4c_Botoes.Top = 29        (0 + 29)
   cnt_4c_BotoesAcao.Top = 38    (9 + 29)

3. PROBLEMA: "Connection handle is invalid" no ValidarUIFidelity
   SOLUÇÃO: Verificar gb_4c_ValidandoUI antes de CarregarLista()

   CORRETO:
   IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
       IF !THIS.CarregarLista()
           * Falha não impede abertura
       ENDIF
   ENDIF

4. PROBLEMA: Mapeamento JSON incorreto causa 104 falsos positivos
   SOLUÇÃO: Criar mapeamento com hierarquia correta

   CORRETO:
   "SIGCDCOR.Pagina": "pgf_4c_Paginas"    (com "s")
   "SIGCDCOR.Pagina.Lista": "Page1"        (Lista = Page1)
   "SIGCDCOR.Pagina.Dados": "Page2"        (Dados = Page2)

ESTRUTURA DO FORMULÁRIO:

PageFrame: pgf_4c_Paginas
├── Page1 (Lista)
│   ├── cnt_4c_Cabecalho (Top = 31)
│   ├── cnt_4c_Botoes (Top = 29)
│   │   ├── cmd_4c_Incluir
│   │   ├── cmd_4c_Alterar
│   │   ├── cmd_4c_Excluir
│   │   ├── cmd_4c_Consultar
│   │   └── cmd_4c_Sair
│   └── grd_4c_Dados (4 colunas: cods, descs, varias, pesos)
│
└── Page2 (Dados)
    ├── cnt_4c_BotoesAcao (Top = 38)
    │   ├── cmd_4c_Salvar
    │   └── cmd_4c_Cancelar
    └── Campos:
        ├── txt_4c_Codigo (com lookup F4)
        ├── txt_4c_Descricao
        ├── txt_4c_Variacao
        ├── txt_4c_Grupo (com lookup F4)
        ├── txt_4c_Peso
        ├── txt_4c_TipoCor (validação S/N)
        ├── txt_4c_DiasEntrega
        └── txt_4c_Tanque (com lookup F4)

BUSINESS OBJECT (CorBO.prg):

Propriedades obrigatórias:
- this_cCodigo (PK)
- this_cDescricao
- this_nVariacao
- this_cGrupo
- this_nPeso
- this_cTipoCor
- this_nDiasEntrega
- this_cTanque

LOOKUPS OBRIGATÓRIOS (3):

1. txt_4c_Grupo → SigCdGrp (cgrus, dgrus)
2. txt_4c_Tanque → SigCdTqe (codigos, descrs)
3. EXTRA: txt_4c_Codigo em modo ALTERAR (busca no próprio SigCdCor)

VALIDAÇÕES:

1. txt_4c_TipoCor: INLIST(valor, "S", "N", "")
2. txt_4c_Codigo: Obrigatório, único (PK)
3. txt_4c_Descricao: Obrigatório

CHECKLIST DE VALIDAÇÃO FINAL:

[ ] PageFrame.Top = -29 e Tabs = .F.
[ ] Containers compensados (+29 pixels)
[ ] Grid com RecordSource + Headers reconfigurados
[ ] InicializarForm() verifica gb_4c_ValidandoUI
[ ] Mapeamento JSON com hierarquia correta
[ ] ValidarUIFidelity executado: ≤ 37 problemas
[ ] Lookups funcionam (F4/DblClick)
[ ] Validações funcionam
[ ] INCLUIR/ALTERAR/EXCLUIR/VISUALIZAR funcionam

ORDEM DE DESENVOLVIMENTO:

1. Criar CorBO.prg (todas as propriedades, Inserir, Atualizar, Excluir, Buscar)
2. Criar FormCor.prg (estrutura completa)
3. Configurar Page1 (Lista com grid)
4. Configurar Page2 (Dados com campos)
5. Implementar lookups (3 campos)
6. Implementar validações
7. Criar mapeamento JSON
8. Executar ValidarUIFidelity
9. Corrigir até ≤ 37 problemas
10. Testar todos os modos

IMPORTANTE:
- Ler docs/FORMCOR_LICOES_APRENDIDAS.md ANTES de começar
- Aplicar TODAS as soluções documentadas
- NÃO repetir os 5 problemas conhecidos
- Validar com ValidarUIFidelity ANTES de considerar completo

Começar agora?
```

---

## 🚀 Como Usar Este Prompt

### Opção 1: Prompt Completo (Recomendado)
Copiar TODO o conteúdo da seção "Prompt para Claude Code" acima e colar diretamente no Claude Code.

### Opção 2: Prompt Curto + Referências
```
Refazer task1 (FormCor) do zero aplicando docs/FORMCOR_LICOES_APRENDIDAS.md.

Estrutura:
- CorBO.prg: 8 propriedades (cCodigo, cDescricao, nVariacao, cGrupo, nPeso, cTipoCor, nDiasEntrega, cTanque)
- FormCor.prg: Page1 (Lista) + Page2 (Dados)
- 3 lookups: Grupo, Tanque, Codigo
- Validações: TipoCor (S/N), Codigo (PK), Descricao (obrigatório)

Regras CRÍTICAS:
1. Grade: Reconfigurar headers APÓS RecordSource
2. PageFrame: Compensar +29px em controles de topo
3. Init: Verificar gb_4c_ValidandoUI antes de CarregarLista
4. Mapeamento: Page1=Lista, Page2=Dados
5. ValidarUIFidelity: ≤37 problemas esperados

Começar?
```

### Opção 3: Prompt Minimalista
```
Refazer FormCor (task1) do zero seguindo docs/FORMCOR_LICOES_APRENDIDAS.md.
Aplicar TODAS as 5 soluções documentadas.
Validar com ValidarUIFidelity antes de finalizar.
```

---

## 📊 Resultado Esperado

Após a migração completa:

```
ARQUIVOS CRIADOS:
✅ projeto/app/classes/CorBO.prg (Business Object)
✅ projeto/app/forms/cadastros/FormCor.prg (Formulário)
✅ projeto/app/utils/mapeamentos/FormCor_mapeamento.json (Mapeamento)

VALIDAÇÃO:
✅ ValidarUIFidelity: ≤37 problemas (4 Dataenvironment + 33 FormBase)
✅ Lookups funcionam (F4/DblClick em 3 campos)
✅ Grid com cabeçalhos corretos
✅ Botões NÃO cortados no topo
✅ INCLUIR/ALTERAR/EXCLUIR/VISUALIZAR funcionam

TESTES MANUAIS:
✅ Incluir novo registro
✅ Alterar registro existente
✅ Excluir registro
✅ Visualizar registro (campos desabilitados, botão Cancelar habilitado)
✅ F4 abre lookup em Grupo, Tanque, Codigo
✅ Validação S/N no TipoCor
```

---

## 🔧 Troubleshooting

Se surgirem problemas durante a migração:

### Problema: ValidarUIFidelity > 100 erros
**Solução**: Revisar mapeamento JSON (Page1/Page2 trocadas)

### Problema: Grid sem cabeçalhos
**Solução**: Adicionar linhas de Header1.Caption APÓS RecordSource

### Problema: Botões cortados no topo
**Solução**: Verificar compensação +29px nos containers

### Problema: "Connection handle is invalid"
**Solução**: Adicionar verificação gb_4c_ValidandoUI no Init

### Problema: Objetos duplicados no log
**Solução**: Verificar se ComparadorUI.prg está atualizado (linha 625-629)

---

## 📚 Referências Obrigatórias

Ler ANTES de começar:
1. ✅ `docs/FORMCOR_LICOES_APRENDIDAS.md` - **5 problemas críticos**
2. ✅ `CLAUDE.md` - Compensação PageFrame.Top=-29
3. ✅ `docs/migration_guide.md` - Checklist geral
4. ✅ `tasks/task1/SIGCDCOR_form_codigo_fonte.txt` - Código original

Consultar durante:
- `docs/lookup_implementation.md` - Implementação de lookups
- `docs/grid_implementation.md` - Configuração de grids
- `docs/form_patterns.md` - Padrões de formulários

---

## ✅ Critérios de Sucesso

A task1 está COMPLETA quando:

1. ✅ ValidarUIFidelity ≤ 37 problemas
2. ✅ Todos os 3 lookups funcionam (F4/DblClick)
3. ✅ Grid com 4 colunas e cabeçalhos corretos
4. ✅ Botões visíveis (não cortados)
5. ✅ INCLUIR/ALTERAR/EXCLUIR/VISUALIZAR testados manualmente
6. ✅ Validações funcionam (S/N no TipoCor, campos obrigatórios)
7. ✅ Code review aprovado (camadas, nomenclatura, _4c_)

---

**Última atualização**: 2026-01-16
**Autor**: Sistema de Refatoração VFP9
