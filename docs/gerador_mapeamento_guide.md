# Gerador de Mapeamento Automático - Guia Completo

## Visão Geral

Sistema automatizado para gerar mapeamento de objetos entre formulários legados e migrados, aplicando as regras de nomenclatura do projeto (padrão `_4c_`).

## Arquivos Criados

### 1. **RegrasNomenclatura.prg**
Classe com regras de conversão de nomes legado → novo padrão.

**Regras implementadas:**

| Tipo | Original | Conversão | Resultado |
|------|----------|-----------|-----------|
| Form | `IGCDCOR`, `Sigcdcor` | Sempre | `Form` |
| PageFrame | `Pagina`, `Pageframe1` | Padrão | `pgf_4c_Dados` |
| Page | `Lista` | Primeira página | `Page1` |
| Page | `Dados` | Segunda página | `Page2` |
| TextBox | `Getcods` | Remove `Get`, capitaliza | `txt_4c_Codigo` |
| TextBox | `Get_Grupo` | Remove `Get_`, capitaliza | `txt_4c_Grupo` |
| TextBox | `getTanque` | Remove `get`, capitaliza | `txt_4c_Tanque` |
| Label | `Say1` com Caption="Código :" | Extrai do Caption | `lbl_4c_Codigo` |
| Label | `Say2` com Caption="Descrição :" | Extrai do Caption | `lbl_4c_Descricao` |
| CommandButton | `Inserir` | Mapeia ação | `cmd_4c_Incluir` |
| CommandButton | `Consultar` | Mapeia ação | `cmd_4c_Consultar` |
| CommandButton | `Alterar` | Mapeia ação | `cmd_4c_Alterar` |
| CommandButton | `Excluir` | Mapeia ação | `cmd_4c_Excluir` |
| CommandButton | `procurar` | Capitaliza | `cmd_4c_Procurar` |
| CommandButton | `SAIR` | Mapeia ação | `cmd_4c_Sair` |
| CommandButton | `Salva` | Padroniza | `cmd_4c_Confirmar` |
| CommandButton | `Cancelar` | Mantém | `cmd_4c_Cancelar` |
| Grid | `Grade`, `Grid1` | Padrão | `grd_4c_Dados` |
| Container | `Grupo_op` | Analisa conteúdo | `cnt_4c_BotoesCRUD` |
| Container | `Grupo_Salva` | Analisa conteúdo | `cnt_4c_BotoesConfirmacao` |
| Container | `Grupo_Saida` | Analisa conteúdo | `cnt_4c_BotoesSaida` |
| Container | `cntSombra` | Mantém semântica | `cnt_4c_Sombra` |

### 2. **AnalisadorObjetos.prg**
Classe que analisa código fonte original e extrai hierarquia de objetos.

**Extrai:**
- Caminho completo (ex: `IGCDCOR.Pagina.Dados.Getcods`)
- Nome simples (ex: `Getcods`)
- Tipo (ex: `TextBox`)
- Caminho pai (ex: `IGCDCOR.Pagina.Dados`)
- Propriedades: Caption, ControlSource, InputMask, Width, Height, Top, Left

### 3. **GeradorMapeamento.prg**
Script principal que orquestra o processo.

**Fluxo:**
1. Analisa código original (.txt)
2. Identifica todos os objetos e hierarquia
3. Aplica regras de nomenclatura
4. Gera JSON completo e padronizado
5. Salva em `projeto\app\utils\mapeamentos\`

### 4. **ComparadorUI.prg** (modificado)
Adicionado suporte para carregar e usar mapeamento JSON.

**Novos métodos:**
- `CarregarMapeamento(par_cArquivoJSON)` - Carrega mapeamento do JSON
- `ResolverObjetoComMapeamento(par_cCaminho)` - Resolve usando mapeamento

### 5. **ValidarUIFidelity.prg** (modificado)
Modificado para carregar mapeamento JSON automaticamente se existir.

## Como Usar

### Workflow Completo (Novos Formulários)

```foxpro
*-- 1. Extrair código fonte original
*-- (usar método existente de extração)

*-- 2. Gerar mapeamento JSON
CD C:\4c\projeto\app\utils
DO GeradorMapeamento WITH "task1\SIGCDCOR_form_codigo_fonte.txt", "FormCor"

*-- Output:
*--   C:\4c\projeto\app\utils\mapeamentos\FormCor_mapeamento.json

*-- 3. [OPCIONAL] Revisar e ajustar JSON manualmente
*-- Abrir JSON em editor de texto e revisar mapeamentos

*-- 4. Implementar formulário SEGUINDO o JSON
*-- JSON = contrato/especificação de como nomear os objetos

*-- 5. Validar UI Fidelity (usará o mapeamento automaticamente)
DO ValidarUIFidelity WITH "task1\SIGCDCOR_form_codigo_fonte.txt", "FormCor"

*-- Output:
*--   Relatório HTML com diferenças REAIS (usando mapeamento correto)
```

### Exemplo de JSON Gerado

```json
{
  "form_original": "SIGCDCOR",
  "form_migrado": "FormCor",
  "entidade": "Cor",
  "mapeamento": {
    "IGCDCOR": "Form",
    "IGCDCOR.Pagina": "pgf_4c_Dados",
    "IGCDCOR.Pagina.Lista": "pgf_4c_Dados.Page1",
    "IGCDCOR.Pagina.Dados": "pgf_4c_Dados.Page2",
    "Pagina.Dados.Say1": "pgf_4c_Dados.Page2.lbl_4c_Codigo",
    "Pagina.Dados.Getcods": "pgf_4c_Dados.Page2.txt_4c_Codigo",
    "Pagina.Dados.Say2": "pgf_4c_Dados.Page2.lbl_4c_Descricao",
    "Pagina.Dados.Getdescs": "pgf_4c_Dados.Page2.txt_4c_Descricao",
    "Pagina.Lista.Grade": "pgf_4c_Dados.Page1.grd_4c_Dados",
    "Pagina.Lista.Grupo_op.Inserir": "pgf_4c_Dados.Page1.cnt_4c_BotoesCRUD.cmd_4c_Incluir",
    "Pagina.Lista.Grupo_op.Alterar": "pgf_4c_Dados.Page1.cnt_4c_BotoesCRUD.cmd_4c_Alterar"
  }
}
```

### Uso para Formulários Já Migrados

```foxpro
*-- 1. Gerar mapeamento (mesmo comando)
DO GeradorMapeamento WITH "task1\SIGCDCOR_form_codigo_fonte.txt", "FormCor"

*-- 2. Revisar JSON gerado
*-- Ajustar mapeamentos que não correspondem ao implementado

*-- 3. Validar (detectará diferenças reais)
DO ValidarUIFidelity WITH "task1\SIGCDCOR_form_codigo_fonte.txt", "FormCor"

*-- 4. Corrigir diferenças encontradas no FormCor.prg

*-- 5. Re-validar até 0 diferenças
```

## Benefícios

### 1. **Automação Escalável**
- Gera mapeamento para centenas de formulários automaticamente
- Aplica regras de nomenclatura do projeto de forma consistente
- Reduz tempo de configuração manual

### 2. **JSON = Contrato/Especificação**
- Define exatamente como implementar cada objeto
- Serve como documentação do mapeamento
- Facilita revisão e ajustes

### 3. **Validação Precisa**
- ValidarUIFidelity usa mapeamento correto
- Detecta diferenças REAIS (não falsos positivos)
- Relatório HTML confiável

### 4. **Reutilização**
- Pode refazer tasks usando o mesmo JSON
- Mapeamento persiste entre execuções
- Facilita manutenção futura

### 5. **Padronização**
- Todos os formulários seguem o mesmo padrão
- Regras centralizadas em RegrasNomenclatura.prg
- Fácil ajustar regras globalmente

## Quando Revisar JSON Manualmente

Revisar o JSON gerado se:

1. **Nomes ambíguos** - Ex: `Say1`, `Say2`, `Say3` (Labels genéricos)
2. **Containers complexos** - Ex: Containers com múltiplos propósitos
3. **Controles customizados** - Ex: Classes customizadas do sistema legado
4. **PageFrames com muitas Pages** - Ex: 3+ abas com nomes genéricos
5. **Grids com colunas nomeadas** - Ex: Colunas específicas que precisam nomes descritivos

## Estrutura de Diretórios

```
C:\4c\
├── docs\
│   └── gerador_mapeamento_guide.md   # Este arquivo
├── projeto\
│   └── app\
│       └── utils\
│           ├── GeradorMapeamento.prg       # Script principal
│           ├── AnalisadorObjetos.prg       # Analisador de hierarquia
│           ├── RegrasNomenclatura.prg      # Regras de conversão
│           ├── ComparadorUI.prg            # (modificado) Usa mapeamento
│           ├── ValidarUIFidelity.prg       # (modificado) Carrega JSON
│           └── mapeamentos\                # JSONs gerados
│               ├── FormCor_mapeamento.json
│               ├── FormCargo_mapeamento.json
│               └── FormDepartamento_mapeamento.json
└── tasks\
    ├── task1\
    │   └── SIGCDCOR_form_codigo_fonte.txt
    ├── task2\
    │   └── SIGCDCAR_form_codigo_fonte.txt
    └── task3\
        └── SIGCDDPT_form_codigo_fonte.txt
```

## Troubleshooting

### Problema: JSON não carregado no ValidarUIFidelity

**Causa:** Arquivo não encontrado ou nome incorreto.

**Solução:**
```foxpro
*-- Verificar se JSON existe
? FILE("C:\4c\projeto\app\utils\mapeamentos\FormCor_mapeamento.json")

*-- Verificar nome do formulário
*-- JSON deve ser: <NomeForm>_mapeamento.json
```

### Problema: Mapeamento incorreto para objeto específico

**Causa:** Regra de nomenclatura não aplicável ao caso.

**Solução:**
1. Editar JSON manualmente
2. Corrigir mapeamento do objeto específico
3. Salvar JSON
4. Re-executar ValidarUIFidelity

### Problema: Muitos objetos não mapeados

**Causa:** Código original tem estrutura diferente do esperado.

**Solução:**
1. Revisar código fonte extraído (.txt)
2. Verificar se DEFINE CLASS e ADD OBJECT estão presentes
3. Ajustar AnalisadorObjetos.prg se necessário
4. Re-gerar JSON

## Extensibilidade

### Adicionar Nova Regra de Nomenclatura

Editar `RegrasNomenclatura.prg`:

```foxpro
PROTECTED PROCEDURE ConverterNomeTextBox(par_cNome)
    *-- ... código existente ...

    *-- Nova regra
    CASE loc_cNomeLower = "novopadrao"
        loc_cBase = "NovoNome"

    *-- ... resto do código ...
ENDPROC
```

### Suportar Novo Tipo de Controle

Editar `RegrasNomenclatura.prg`:

```foxpro
PROTECTED PROCEDURE ObterPrefixo(par_cTipo)
    *-- ... código existente ...

    CASE par_cTipo = "NovoTipo"
        loc_cPrefixo = "novo"

    *-- ... resto do código ...
ENDPROC
```

## Próximos Passos

1. ✅ Testar geração de JSON para FormCor
2. ⏳ Validar FormCor com mapeamento carregado
3. ⏳ Gerar JSON para FormCargo, FormDepartamento
4. ⏳ Validar todos os formulários migrados
5. ⏳ Ajustar regras de nomenclatura conforme necessário
6. ⏳ Documentar casos especiais encontrados

## Conclusão

O sistema de geração de mapeamento automatizado:
- ✅ Escalável para centenas de formulários
- ✅ Aplica regras de nomenclatura do projeto
- ✅ Gera JSON completo e padronizado
- ✅ Integrado com ValidarUIFidelity
- ✅ Permite ajustes manuais quando necessário
- ✅ Serve como documentação do mapeamento

**Resultado:** Validação de UI Fidelity precisa e confiável, com mapeamento correto entre objetos legados e migrados.
