# Checklist Pré-Deploy - Sistema de Migração Automatizada

**Versão:** 1.0
**Data:** 2026-01-22

---

## ✅ Verificações Obrigatórias Antes de Usar em Produção

### 1. ⚙️ Ambiente e Ferramentas

- [ ] **Visual FoxPro 9** instalado e funcionando
  ```powershell
  Test-Path "C:\Program Files (x86)\Microsoft Visual FoxPro 9\VFP9.EXE"
  ```

- [ ] **PowerShell 5.1+** disponível
  ```powershell
  $PSVersionTable.PSVersion  # Deve ser >= 5.1
  ```

- [ ] **Claude CLI** instalado e autenticado
  ```powershell
  claude --version
  # Deve mostrar versão
  ```

- [ ] **Conexão com SQL Server** funcionando
  - Host: 192.168.15.101
  - Banco: DB_MBAHIA
  - Testar: `ping 192.168.15.101`

- [ ] **Estrutura de diretórios** criada
  ```powershell
  Test-Path "C:\4c\origem"
  Test-Path "C:\4c\tasks"
  Test-Path "C:\4c\automation"
  Test-Path "C:\4c\projeto\app"
  Test-Path "C:\4c\SolicitacaoTesteManual"
  ```

---

### 2. 📄 Arquivos de Configuração

- [ ] **config.json** ajustado
  - Verificar todos os paths
  - Ajustar `maxProblemas` conforme necessário
  - Configurar timeouts apropriados

- [ ] **config.fpw templates** existem
  ```powershell
  Test-Path "C:\4c\automation\configs\extract.fpw"
  Test-Path "C:\4c\automation\configs\mapeamento.fpw"
  Test-Path "C:\4c\automation\configs\test_form.fpw"
  Test-Path "C:\4c\automation\configs\validacao.fpw"
  ```

- [ ] **task_state_template.json** existe
  ```powershell
  Test-Path "C:\4c\automation\task_state_template.json"
  ```

- [ ] **GERADOR_PROMPT_MIGRACAO.md** existe
  ```powershell
  Test-Path "C:\4c\docs\GERADOR_PROMPT_MIGRACAO.md"
  ```

- [ ] **class_mapping.json** criado (opcional, mas recomendado)
  ```json
  {
    "mappings": {
      "SIGCDCOR": { "formClass": "FormCor", "boClass": "CorBO" }
    }
  }
  ```

---

### 3. 🔧 Scripts PowerShell

- [ ] **OrquestradorMigracao.ps1** - Script principal
- [ ] **TaskManager.ps1** - Gerenciamento de tasks
- [ ] **VFPExecutor.ps1** - Wrapper VFP
- [ ] **ClaudeInvoker.ps1** - Wrapper Claude CLI

**Teste rápido:**
```powershell
cd C:\4c\automation
. .\TaskManager.ps1
# Se não der erro, módulo carregado OK
```

---

### 4. 📝 Scripts VFP

- [ ] **ExtractSCXCode.prg** em `C:\4c\projeto\app\utils\`
- [ ] **GeradorMapeamento.prg** em `C:\4c\projeto\app\utils\`
- [ ] **ValidarUIFidelity.prg** em `C:\4c\projeto\app\utils\`
- [ ] **TestFormWrapper.prg** em `C:\4c\automation\vfp_helpers\`

**Teste rápido:**
```powershell
Test-Path "C:\4c\projeto\app\utils\ExtractSCXCode.prg"
```

---

### 5. 🎯 Arquivos de Origem

- [ ] **Pelo menos 1 par SCX/SCT** em `C:\4c\origem\`
  ```powershell
  Get-ChildItem "C:\4c\origem" -Filter "*.scx"
  ```

- [ ] **Arquivos não corrompidos**
  - Abrir no VFP manualmente para verificar

- [ ] **Código-fonte extraído previamente** (para comparação)
  - Útil para validar ExtractSCXCode

---

### 6. 🧪 Testes Unitários (Opcional, mas Recomendado)

#### Teste 1: VFPExecutor.ps1

```powershell
cd C:\4c\automation

# Criar script de teste
@"
* test_hello.prg
? "Hello from VFP"
QUIT RETURN 0
"@ | Out-File -FilePath "C:\4c\automation\test_hello.prg" -Encoding ASCII

# Executar
.\VFPExecutor.ps1 -ConfigFpw "configs\extract.fpw" -ScriptPrg "test_hello.prg" -Timeout 30

# Deve retornar exit code 0
echo $LASTEXITCODE
```

#### Teste 2: ClaudeInvoker.ps1

```powershell
# Criar prompt de teste
"Responda apenas: OK" | Out-File -FilePath "C:\4c\automation\test_prompt.txt" -Encoding UTF8

# Executar
.\ClaudeInvoker.ps1 -PromptFile "test_prompt.txt" -OutputFile "test_output.txt" -Model "haiku"

# Verificar output
cat test_output.txt  # Deve conter "OK" ou resposta do Claude
```

#### Teste 3: TaskManager.ps1

```powershell
. .\TaskManager.ps1

# Criar task de teste
New-Task -TaskId "test001" -ArquivoOriginal "TESTE" -TipoArquivo "SCX" -TasksDir "C:\4c\tasks"

# Verificar se foi criada
Test-Path "C:\4c\tasks\test001\task_state.json"

# Limpar
Remove-Item "C:\4c\tasks\test001" -Recurse -Force
```

---

### 7. 📋 Validações do Projeto Base

- [ ] **config.prg** funciona
  ```foxpro
  CD C:\4c\projeto\app\start
  DO config.prg
  * Não deve dar erro
  ```

- [ ] **FormBase** carregado
  ```foxpro
  loForm = CREATEOBJECT("FormBase")
  ? TYPE("loForm")  && Deve ser "O"
  ```

- [ ] **BusinessBase** carregado
  ```foxpro
  loBO = CREATEOBJECT("BusinessBase")
  ? TYPE("loBO")  && Deve ser "O"
  ```

- [ ] **Conexão com SQL Server** funciona
  ```foxpro
  DO config.prg
  ? gnConnHandle  && Deve ser > 0
  ```

---

### 8. 🔐 Segurança

- [ ] **Arquivos .env com credenciais FORA de C:\4c\origem\**
- [ ] **Claude CLI** autenticado com conta/chave apropriada
- [ ] **Backup** do banco de dados antes de testes
- [ ] **Usuário de teste** no banco (não usar produção)

---

### 9. 📊 Monitoramento

- [ ] **Espaço em disco suficiente**
  - Cada task: ~5-10 MB
  - 100 tasks: ~500 MB - 1 GB

- [ ] **Logs rotativos** configurados (opcional)
  - Evitar logs gigantes

- [ ] **Alertas** configurados (opcional)
  - Email/Slack quando task falha

---

### 10. 📚 Documentação

- [ ] **README.md** lido e compreendido
- [ ] **ANALISE_CRITICA_PROCESSO.md** revisado
- [ ] **ARQUITETURA_SISTEMA.md** compreendido
- [ ] **C:\4c\CLAUDE.md** e `docs\` consultados

---

## 🧪 Teste de Integração Completo (Dry Run)

Antes de processar formulários reais, faça um teste completo com formulário simples:

### Passo 1: Preparar Formulário de Teste

```powershell
# Copiar FormCor.scx/.sct para C:\4c\origem\ (se já migrado, usar como teste)
# OU usar outro formulário SIMPLES (poucos campos, sem lookups)
```

### Passo 2: Executar Migração

```powershell
cd C:\4c\automation
.\OrquestradorMigracao.ps1
```

### Passo 3: Verificar Cada Etapa

```powershell
cd C:\4c\tasks\task001

# Verificar estado
cat task_state.json

# Verificar logs
cat logs\01_moverArquivos.log
cat logs\02_extractCode.log
cat logs\03_gerarMetaPrompt.log
cat logs\04_gerarMapeamento.log
cat logs\05_migracao.log
cat logs\06_testForm.log
cat logs\07_validarUI.log
cat logs\08_gerarTestManual.log
```

### Passo 4: Validar Outputs

```powershell
# Código-fonte extraído
Test-Path "SIGCDCOR_codigo_fonte.txt"

# Meta-prompt gerado
Test-Path "meta_prompt.md"

# Mapeamento gerado
Test-Path "mapeamento.json"

# Código migrado
Test-Path "C:\4c\projeto\app\forms\cadastros\FormCor.prg"
Test-Path "C:\4c\projeto\app\classes\CorBO.prg"

# Relatório de validação UI
Test-Path "validacao_ui_report.html"
start validacao_ui_report.html  # Abrir no navegador

# Solicitação de teste manual
Test-Path "C:\4c\SolicitacaoTesteManual\task001_SIGCDCOR.md"
```

### Passo 5: Teste Manual do Formulário

```foxpro
CD C:\4c\projeto\app\start
DO config.prg

CD C:\4c\projeto\app\forms\cadastros
DO FormCor

* Testar:
* - Abrir formulário
* - Clicar em Incluir
* - Preencher campos
* - Clicar em Confirmar
* - Verificar se salvou no banco
```

---

## ✅ Critérios de Aceitação do Dry Run

O teste está **APROVADO** se:

- ✅ Todas as 8 etapas completaram com sucesso
- ✅ `task_state.json` → `status = COMPLETED`
- ✅ Formulário abre sem erros
- ✅ Botões funcionam (Incluir, Alterar, Visualizar)
- ✅ ValidarUIFidelity: `total <= maxProblemas`
- ✅ Dados salvam no banco corretamente
- ✅ Logs não contêm erros críticos

Se **REPROVADO**:
1. Identificar qual etapa falhou
2. Consultar `ANALISE_CRITICA_PROCESSO.md` → seção "Troubleshooting"
3. Corrigir problema
4. Repetir dry run

---

## 🚀 Pronto para Produção

Após aprovação no dry run:

1. [ ] Processar 5 formulários simples
2. [ ] Revisar código gerado manualmente
3. [ ] Ajustar `config.json` baseado em resultados
4. [ ] Processar 10 formulários de complexidade média
5. [ ] Avaliar taxa de sucesso
6. [ ] Se taxa > 70%, escalar para todos formulários
7. [ ] Se taxa < 70%, investigar problemas comuns e melhorar processo

---

## 📞 Suporte

Se encontrar problemas:
1. Consultar **ANALISE_CRITICA_PROCESSO.md** → "Troubleshooting"
2. Verificar logs em `C:\4c\tasks\taskXXX\logs\`
3. Revisar `task_state.json` para identificar etapa falha
4. Consultar documentação técnica em `C:\4c\docs\`

---

## 🎯 Metas de Qualidade

| Métrica | Meta | Como Medir |
|---------|------|------------|
| Taxa de sucesso (1ª tentativa) | > 70% | tasks completadas / tasks iniciadas |
| Tempo médio por task | < 60 min | Duração fim-a-fim |
| Problemas UI (média) | < 10 | ValidarUIFidelity total |
| Erros críticos | 0 | TestFormWrapper exit code |
| Intervenções manuais | < 30% | tasks que precisaram [R]etry/[C]ontinue |

---

**Checklist preparado por:** Sistema de Automação de Migração
**Última atualização:** 2026-01-22
**Versão:** 1.0
