# Documentacao do Sistema VFP9

> **FILOSOFIA DO PROJETO**: Refatoracao INTERNA apenas.
> - **UI**: Interface visual (cores, fontes, tamanhos, layout) DEVE permanecer IDENTICA ao legado
> - **DB**: Nomes de tabelas e colunas NAO serao alterados (usar exatamente como estao)
> - O usuario NAO deve perceber diferenca. Unica adicao ao banco: tabela LogAuditoria.

## Estrutura de Pastas

```
C:\4c\
├── CLAUDE.md      # Instrucoes principais para Claude Code
├── docs\          # TODA documentacao (este diretorio)
├── tasks\         # Arquivos fonte das tarefas de migracao
├── projeto\       # Codigo do novo sistema
└── vbmp\          # Icones e imagens
```

**IMPORTANTE**: Toda documentacao tecnica deve ficar em `docs\`.
Arquivos de tarefas (SCX, screenshots, codigo fonte extraido) ficam em `tasks\`.

---

## Indice da Documentacao

### Referencia Rapida

| Documento | Descricao |
|-----------|-----------|
| [ERROS_COMUNS_E_SOLUCOES.md](ERROS_COMUNS_E_SOLUCOES.md) | **LEIA PRIMEIRO** - Erros comuns e solucoes |
| [schema.sql](schema.sql) | Schema completo do banco DB_MBAHIA |

### Arquitetura e Padroes

| Documento | Descricao |
|-----------|-----------|
| [arquitetura.md](arquitetura.md) | Visao geral da arquitetura em camadas |
| [padroes_codigo.md](padroes_codigo.md) | Convencoes de nomenclatura e padroes |
| [ESTRUTURA.md](ESTRUTURA.md) | Estrutura de pastas do projeto |

### Guias de Desenvolvimento

| Documento | Descricao |
|-----------|-----------|
| [guia_desenvolvimento.md](guia_desenvolvimento.md) | Passo a passo para desenvolver |
| [templates.md](templates.md) | Templates de BO e Formularios |
| [exemplo_completo.md](exemplo_completo.md) | Exemplo completo de implementacao |
| [INICIO_RAPIDO.md](INICIO_RAPIDO.md) | Como iniciar rapidamente |

### Correcoes e Referencias

| Documento | Descricao |
|-----------|-----------|
| [CORRECAO_TRY_CATCH.md](CORRECAO_TRY_CATCH.md) | Correcao de RETURN em TRY/CATCH |
| [CORRECAO_MENU.md](CORRECAO_MENU.md) | Correcao de acentos no menu |
| [SET_CLASSLIB_vs_SET_PROCEDURE.md](SET_CLASSLIB_vs_SET_PROCEDURE.md) | Diferenca entre SET CLASSLIB e SET PROCEDURE |
| [REGRAS_DESENVOLVIMENTO.md](REGRAS_DESENVOLVIMENTO.md) | Regras obrigatorias |

### Codigo Fonte do Sistema Legado

| Documento | Descricao |
|-----------|-----------|
| [FRAMEWORK_class_codigo_fonte.txt](FRAMEWORK_class_codigo_fonte.txt) | **Codigo fonte extraido do FRAMEWORK.VCX** - Classes base do sistema legado (331 objetos). Referencia para entender comportamentos originais, heranca de classes e implementacoes existentes. |

---

## Tarefas de Migracao

As tarefas de migracao ficam em `C:\4c\tasks\`:

| Pasta | Tela | Tipo | Status | Observacoes |
|-------|------|------|--------|-------------|
| task1 | SIGCDCOR - Cadastro de Cores | Cadastro | Concluido | FormCor.prg, CorBO.prg |
| task2 | SIGCDCAR - Cadastro de Cargos | Cadastro | Concluido | FormCargo.prg, CargoBO.prg |
| task3 | SIGCDDPT - Cadastro de Departamentos | Cadastro | Concluido | FormDepartamento.prg, DepartamentoBO.prg |
| task4 | SIGREPLC - Plano de Contas | Relatorio | Concluido | FormRelPlanoContas.prg, PlanoContasBO.prg |
| task5 | SIGCDPRO - Cadastro de Produtos | Cadastro | 90% | FormProduto.prg - UI em ajuste |

### Arquivos por Tarefa

| Task | Business Object | Formulario | Relatorio |
|------|-----------------|------------|-----------|
| task1 | CorBO.prg | FormCor.prg | - |
| task2 | CargoBO.prg | FormCargo.prg | - |
| task3 | DepartamentoBO.prg | FormDepartamento.prg | - |
| task4 | PlanoContasBO.prg | FormRelPlanoContas.prg | RelatorioPlanoContas.prg |
| task5 | ProdutoBO.prg | FormProduto.prg | - |

Cada pasta de tarefa contem:
- Arquivos SCX/VCX originais
- Screenshots de referencia
- Codigo fonte extraido (.txt)

---

## Executar o Sistema

```foxpro
CD C:\4c\projeto\app\start
DO main.prg
```

Testar formulario especifico:
```foxpro
CD C:\4c\projeto\app\forms\cadastros
DO FORM FormCor
```

---

## Conexao com Banco

- **Servidor**: 192.168.15.101
- **Banco**: DB_MBAHIA
- **Handle**: gnConnHandle (variavel global)

---

## Links Uteis

- **CLAUDE.md** (raiz): Instrucoes completas para Claude Code
- **projeto\app\start\config.prg**: Configuracao de conexao
- **projeto\app\start\main.prg**: Ponto de entrada do sistema
