# Sistema de Testes Automatizados - TesteAutomatico.prg

**Data**: 2026-03-09 (atualizado)
**Status**: FUNCIONAL - Integrado ao pipeline OrquestradorMigracao.ps1

---

## Objetivo

Automatizar testes de formularios migrados para garantir qualidade antes de entrega ao cliente. Integrado como Etapa 6.5 do pipeline.

---

## Arquivo Principal

**Localizacao**: `C:\4c\projeto\app\utils\TesteAutomatico.prg`

### Parametros

```foxpro
LPARAMETERS par_cFormClass, par_cTaskDir, par_cFormType
```

| Parametro | Tipo | Exemplo | Descricao |
|-----------|------|---------|-----------|
| par_cFormClass | String | "Formsigopind" | Nome da classe do form |
| par_cTaskDir | String | "C:\4c\tasks\task039" | Diretorio da tarefa |
| par_cFormType | String | "OPERACIONAL" | Tipo: CRUD, REPORT ou OPERACIONAL |

O 3o parametro eh passado pelo pipeline via `Get-FormTypeFromState()`.

---

## Tipos de Form e Testes Executados

### CRUD (frmcadastro) - Padrao

| Teste | O que Valida |
|-------|-------------|
| **TesteCarregarLista** | CarregarLista() popula grid, cursor tem registros |
| **TesteModoIncluir** | BtnIncluirClick funciona, campos habilitados, LimparCampos OK |
| **TesteModoVisualizar** | BtnVisualizarClick, campos desabilitados, AjustarBotoesPorModo OK |

### REPORT (frmrelatorio)

| Teste | O que Valida |
|-------|-------------|
| **TesteFormParaRelatorio** | Metodo FormParaRelatorio existe e executa sem erro |
| **TesteBotoesRelatorio** | BtnVisualizarClick e BtnImprimirClick existem e funcionam |

### OPERACIONAL (form generico) - NOVO (2026-03-09)

| Teste | O que Valida |
|-------|-------------|
| **TesteContainersFlutuantes** | Containers com Visible=.F. fazem toggle ON/OFF corretamente |
| **TesteCarregarDadosReais** | Metodos de carga (MontaGrade, CarregarSaldos, etc.) populam cursors |
| **TesteNavegacaoPaginas** | Todas as paginas do PageFrame sao navegaveis (ActivePage 1..N) |

---

## Deteccao do Tipo de Form

### No Pipeline (OrquestradorMigracao.ps1)

```powershell
# O tipo vem do analise.json (gerado pelo AnalisadorTarefa.prg)
$formType = Get-FormTypeFromState -TaskId $TaskId

# Passado como 3o parametro ao VFPExecutor
$parameters = @($formClass, $taskPath, $formType)
```

### No TesteAutomatico.prg

```foxpro
*-- Prioridade: hint do pipeline > deteccao automatica
DO CASE
CASE THIS.cFormTypeHint = "REPORT"
    THIS.ExecutarTestesReport()
CASE THIS.cFormTypeHint = "OPERACIONAL"
    THIS.ExecutarTestesOperacional()
OTHERWISE
    THIS.ExecutarTestesCRUD()
ENDCASE
```

---

## Detalhes dos Testes OPERACIONAL

### TesteContainersFlutuantes

Percorre todos os controles das paginas do PageFrame e identifica containers com `Visible=.F.`. Para cada um:

1. Verifica estado inicial (Visible=.F.)
2. Seta Visible=.T. (toggle ON)
3. Verifica que ficou visivel
4. Seta Visible=.F. (toggle OFF)
5. Verifica que voltou ao estado original

### TesteCarregarDadosReais

Busca metodos de carga de dados via PEMSTATUS:
- MontaGrade, CarregarSaldos, CarregarHistorico, CarregarQuitas, CarregarDados

Para cada metodo encontrado:
1. Busca um registro real no banco (SigCdGcr) para usar como parametro
2. Chama o metodo com o parametro
3. Verifica se cursors foram populados (RECCOUNT > 0)

### TesteNavegacaoPaginas

1. Obtem PageCount do PageFrame
2. Navega para cada pagina (ActivePage = 1..N)
3. Faz Refresh em cada pagina
4. Retorna para pagina 1

---

## Integracao com Pipeline

### Etapa 6.5 - Teste Automatico

```
Fluxo:
1. Pipeline detecta formType do task_state.json
2. Chama VFPExecutor com 3 parametros (classe, taskDir, formType)
3. TesteAutomatico executa testes por tipo
4. Gera teste_resultado.json com resultado
5. Pipeline verifica: passou >= threshold (100%)
6. Se falha: retry loop ate 10x com correcao Claude
```

### Resultado (teste_resultado.json)

```json
{
    "formClass": "Formsigopind",
    "formType": "OPERACIONAL",
    "total": 5,
    "passou": 5,
    "falhou": 0,
    "percentual": 100,
    "testes": [
        {"nome": "TesteContainersFlutuantes", "resultado": "PASSOU"},
        {"nome": "TesteCarregarDadosReais", "resultado": "PASSOU"},
        {"nome": "TesteNavegacaoPaginas", "resultado": "PASSOU"}
    ]
}
```

---

## Threshold de Qualidade

| Configuracao | Valor | Descricao |
|-------------|-------|-----------|
| threshold | 100% | TODOS os testes devem passar |
| maxTentativas | 10 | Retry loop com correcao Claude |
| timeout | 300s | Timeout VFP9 por tentativa |

Se o threshold nao for atingido apos 10 tentativas, a Etapa 6.5 **falha** (quality gate) e a migracao eh marcada como FAILED.

---

## Error Capture (gb_4c_ModoTeste)

O TesteAutomatico seta `gb_4c_ModoTeste = .T.` para:
- messages.prg: escreve erros em `vfp_error_details.txt` ao inves de MESSAGEBOX
- FormErro.prg: idem
- VFP sai normalmente (sem TIMEOUT por dialogo modal bloqueante)

---

## Historico

| Data | Mudanca |
|------|---------|
| 2026-01-16 | Versao inicial (RunnerFormProduto - CRUD only) |
| 2026-02-26 | Suporte REPORT (FormParaRelatorio, BotoesRelatorio) |
| 2026-03-09 | Suporte OPERACIONAL (ContainersFlutuantes, CarregarDadosReais, NavegacaoPaginas) |
| 2026-03-09 | 3o parametro formType passado pelo pipeline |

---

**Ultima atualizacao**: 2026-03-09
