# 📊 Guia de Apresentações - Material de Sponsor e Treinamento

**Versão:** 1.0
**Data:** 2026-01-22

Este documento explica como usar os materiais de apresentação criados.

---

## 📦 Materiais Disponíveis

| Material | Arquivo | Público | Duração | Formato |
|----------|---------|---------|---------|---------|
| **Apresentação para Sponsor** | `APRESENTACAO_SPONSOR.md` | Gestores, Decisores | 40 min | Markdown (Marp) |
| **Treinamento Técnico** | `TREINAMENTO_TECNICO.md` | Desenvolvedores, QA | 2-3 horas | Markdown |

---

## 🎯 Material 1: Apresentação para Sponsor

### Objetivo
Apresentar o sistema de migração automatizada para decisores, buscando aprovação para prosseguir com implementação.

### Público-Alvo
- ✅ Sponsor do projeto
- ✅ Gerentes técnicos
- ✅ Product Owners
- ✅ Stakeholders interessados em ROI

### Estrutura (31 slides)

```
1-5.   Contexto e Problema (10 min)
6-15.  Solução Técnica (15 min)
16-20. ROI e Benefícios (10 min)
21-25. Implementação e Riscos (5 min)
26-31. Q&A e Decisão (10 min)
```

### Como Apresentar

#### **Opção A: Converter para PowerPoint**

```powershell
# Instalar Marp CLI (requer Node.js)
npm install -g @marp-team/marp-cli

# Converter para PPTX
cd C:\4c\automation
marp APRESENTACAO_SPONSOR.md --pptx -o APRESENTACAO_SPONSOR.pptx

# Abrir no PowerPoint
start APRESENTACAO_SPONSOR.pptx
```

#### **Opção B: Apresentar como HTML (Reveal.js)**

```powershell
# Converter para HTML interativo
marp APRESENTACAO_SPONSOR.md --html -o APRESENTACAO_SPONSOR.html

# Abrir no navegador
start APRESENTACAO_SPONSOR.html

# Navegação:
# - Setas: Próximo/Anterior slide
# - F: Fullscreen
# - O: Overview
```

#### **Opção C: Apresentar Diretamente do Markdown**

Use um editor com preview ao vivo:
- VS Code + extensão Marp
- Typora (suporta apresentação de slides)

---

### Dicas de Apresentação

#### **Slide 1-5: Contexto (10 min)**

**Foco:** Estabelecer o problema e sua magnitude

- Enfatize **300-400 horas** de migração manual
- Mostre **risco de inconsistência** (código varia entre desenvolvedores)
- Use comparação lado-a-lado (Manual vs Automatizado)

**Pergunta para engajar:** "Alguém já participou de migração manual? Quanto tempo levou?"

---

#### **Slide 6-15: Solução Técnica (15 min)**

**Foco:** Demonstrar que a solução é robusta e confiável

- **Não se aprofunde demais** em detalhes técnicos (evite jargões)
- Use **analogias:** "Como uma linha de montagem automática"
- Mostre **rastreabilidade:** "Tudo é registrado, nada se perde"

**Pontos-chave:**
- 8 etapas automatizadas
- Validação em múltiplos níveis
- Claude AI gera código de qualidade

**Se houver desenvolvedores na audiência:**
- Aprofundar em Etapa 5 (Migração com IA)
- Mostrar exemplo de código gerado

**Se houver apenas gestores:**
- Focar em **tempo economizado** e **qualidade**
- Pular detalhes de código

---

#### **Slide 16-20: ROI e Benefícios (10 min)**

**Foco:** Justificar o investimento (já foi feito) e mostrar retorno

**Números-chave para enfatizar:**
- 💰 **Economia:** R$ 40.000 - R$ 60.000
- ⏱️ **Tempo:** 75% mais rápido
- 📊 **Consistência:** 100% (vs variável)
- 💵 **Custo API:** Apenas $200-500

**Comparação poderosa:**
```
Manual: 300-400 horas × R$ 200/hora = R$ 60.000 - R$ 80.000
Automatizado: 50-100 horas + $500 API = R$ 10.000 - R$ 20.000 + R$ 2.500

ECONOMIA: R$ 40.000 - R$ 60.000 (67-75%)
```

**Pergunta retórica:** "Vale a pena economizar R$ 50.000 em 3 meses?"

---

#### **Slide 21-25: Implementação e Riscos (5 min)**

**Foco:** Tranquilizar sobre riscos e mostrar plano realista

**Enfatize progressão faseada:**
- ✅ Não é "tudo ou nada"
- ✅ 3 fases com critérios claros
- ✅ Pode parar a qualquer momento

**Riscos honestos:**
- "Taxa de sucesso pode ser 60-70% inicialmente" (honestidade)
- "Mas vai melhorar para 80-90% após ajustes"

**Mitigações claras:**
- 3 melhorias críticas **antes** de produção
- Teste com 5 formulários simples **primeiro**

---

#### **Slide 26-31: Q&A e Decisão (10 min)**

**Foco:** Responder dúvidas e pedir decisão

**Perguntas esperadas (prepare respostas):**

**P: "E se der errado?"**
R: "Sistema para e pede decisão. Você sempre tem controle. Pode continuar manual se necessário."

**P: "Quanto custa a API do Claude?"**
R: "$2-5 por formulário. 100 formulários = $200-500. Menos de 5% do custo total."

**P: "Precisa treinar a equipe?"**
R: "Sim, 2-3 horas. Temos material completo de treinamento (mostrar TREINAMENTO_TECNICO.md)."

**P: "Quando podemos começar?"**
R: "Fase 1 pode começar na próxima semana. Pré-requisitos já estão prontos."

**Peça decisão explícita:**
> "Com base no que vimos, recomendo **aprovar** a implementação em 3 fases.
> Começamos com 5 formulários simples para validar.
> Se taxa > 60%, prosseguimos. Se não, paramos e reavaliamos.
>
> **Posso contar com a aprovação para Fase 1?**"

---

### Checklist Pré-Apresentação

- [ ] Converter MD para PPTX ou HTML
- [ ] Testar apresentação (navegação, animações)
- [ ] Preparar demo ao vivo (opcional - task001 completo)
- [ ] Ter backup: Se demo falhar, usar screenshots
- [ ] Imprimir 1 cópia do RESUMO_EXECUTIVO.md (handout)
- [ ] Preparar respostas para perguntas comuns
- [ ] Timer: 40 minutos (35 apresentação + 5 buffer)

---

## 🎓 Material 2: Treinamento Técnico

### Objetivo
Capacitar equipe técnica para operar o sistema de migração de forma autônoma.

### Público-Alvo
- ✅ Desenvolvedores VFP
- ✅ QA (Quality Assurance)
- ✅ DevOps
- ❌ Não é para gestores (muito técnico)

### Estrutura (6 módulos)

```
Módulo 1: Overview e Setup (30 min)
Módulo 2: Primeira Migração (45 min) ← HANDS-ON
Módulo 3: Monitoramento e Debug (30 min)
Módulo 4: Operação em Lote (30 min) ← HANDS-ON
Módulo 5: Validação e QA (30 min)
Módulo 6: Q&A e Prática (30 min) ← HANDS-ON
```

**Total:** 2-3 horas (com exercícios práticos)

---

### Como Conduzir o Treinamento

#### **Pré-Treinamento (1 semana antes)**

```markdown
**Email para participantes:**

Assunto: Treinamento - Sistema de Migração Automatizada

Olá,

Na próxima semana teremos treinamento hands-on do sistema de migração.

**Pré-requisitos (instalar ANTES):**
1. Visual FoxPro 9
2. PowerShell 5.1+ (já vem no Windows)
3. Claude CLI: npm install -g @anthropic-ai/claude-code
4. Git (opcional, mas recomendado)

**Ler antes do treinamento:**
- README.md (15 min)
- INDEX.md (5 min - apenas navegar)

**Trazer:**
- Notebook com ambiente configurado
- Dúvidas anotadas

Até lá!
```

---

#### **Módulo 1: Overview e Setup (30 min)**

**Objetivo:** Nivelar conhecimento e verificar setup

**Formato:** Apresentação + Verificação prática

```powershell
# Executar junto com participantes:
# 1. Verificar VFP
Test-Path "C:\Program Files (x86)\Microsoft Visual FoxPro 9\VFP9.EXE"

# 2. Verificar PowerShell
$PSVersionTable.PSVersion

# 3. Verificar Claude CLI
claude --version

# 4. Verificar estrutura
Test-Path C:\4c\automation\config.json

# ✅ Todos devem retornar sucesso antes de prosseguir
```

**Se alguém falhar:**
- Pausar para ajudar individualmente
- OU pular esse participante para depois (não atrasar grupo)

---

#### **Módulo 2: Primeira Migração (45 min) ← HANDS-ON**

**Objetivo:** TODOS executam uma migração completa

**Formato:** Hands-on guiado (instrutor vai executando, todos acompanham)

**Passos (acompanhar juntos):**

1. **Preparar arquivo** (5 min)
```powershell
# Verificar se há arquivo em origem
Get-ChildItem C:\4c\origem -Filter "*.scx"
```

2. **Executar orquestrador** (30 min)
```powershell
cd C:\4c\automation
.\OrquestradorMigracao.ps1

# Instrutor narra cada etapa:
# "Agora está extraindo código... deve levar 15-30 segundos"
# "Próxima etapa: gerar meta-prompt... 5 segundos"
# "Agora Claude vai gerar código... pode levar 5-10 minutos"
```

3. **Revisar resultado** (10 min)
```powershell
# Ver estado
cat C:\4c\tasks\task001\task_state.json

# Abrir relatório UI
start C:\4c\tasks\task001\validacao_ui_report.html
```

**Checkpoint:** Todos devem ter task001 COMPLETED antes de prosseguir

---

#### **Módulo 3: Monitoramento e Debug (30 min)**

**Objetivo:** Saber interpretar logs e troubleshooting

**Formato:** Apresentação + Exercícios

**Exercício 1: Simular Erro**

```powershell
# Instrutor edita config.json e diminui timeout propositalmente
{
  "claude": { "timeout": 10 }  # ← Vai dar timeout!
}

# Executa migração
.\OrquestradorMigracao.ps1

# Mostra como:
# 1. Identificar erro no log
# 2. Ver mensagem no task_state.json
# 3. Decidir: [R]etry depois de corrigir config

# Corrige config.json
{
  "claude": { "timeout": 600 }
}

# [R]etry
```

**Exercício 2: Interpretar Logs**

```powershell
# Distribuir arquivo de log com erro para cada participante
# Pedir para identificar:
# 1. Qual etapa falhou?
# 2. Qual foi o erro?
# 3. O que fazer para corrigir?
```

---

#### **Módulo 4: Operação em Lote (30 min) ← HANDS-ON**

**Objetivo:** Processar múltiplos formulários

**Formato:** Hands-on guiado

```powershell
# Colocar 3 arquivos em origem
Copy-Item "C:\backup\SIGCD*.scx/sct" C:\4c\origem\

# Executar lote com pausa
.\processar_lote_com_revisao.ps1 -Quantidade 3

# Instrutor guia cada pausa:
# "Agora vamos revisar task001 antes de continuar..."
# "Pressione ENTER para próximo"
```

**Discussão:** Quando usar cada modo (Manual/Semi/Auto)?

---

#### **Módulo 5: Validação e QA (30 min)**

**Objetivo:** Saber aprovar/reprovar uma task

**Formato:** Apresentação + Exercício

**Exercício: Revisar Relatório UI**

```powershell
# Distribuir 3 relatórios diferentes:
# - Relatório 1: 0 erros, 33 avisos (APROVAR)
# - Relatório 2: 50 erros críticos (REPROVAR)
# - Relatório 3: 10 diferenças (ANALISAR)

# Cada participante decide: Aprovar ou Reprovar?
# Discussão em grupo sobre decisões
```

---

#### **Módulo 6: Q&A e Prática (30 min) ← HANDS-ON**

**Objetivo:** Consolidar aprendizado

**Exercício Final (em duplas):**

```
Dupla A: Processar 2 formulários
Dupla B: Processar 2 formulários

Cada dupla deve:
1. Executar migração
2. Monitorar logs
3. Validar UI
4. Aprovar/reprovar
5. Apresentar resultados

Tempo: 20 minutos
```

**Q&A final:** Dúvidas abertas (10 min)

---

### Checklist Pré-Treinamento (Instrutor)

- [ ] Verificar que TODOS têm pré-requisitos instalados (1 semana antes)
- [ ] Preparar 10+ arquivos SCX/SCT para prática
- [ ] Testar todos os comandos ANTES do treinamento
- [ ] Preparar arquivos de exemplo (logs com erro, relatórios UI)
- [ ] Imprimir handout (comandos úteis, troubleshooting)
- [ ] Configurar projetor/screenshare
- [ ] Timer para controlar tempo de cada módulo

---

### Checklist Durante Treinamento

- [ ] Módulo 1: Todos passaram no checklist de setup?
- [ ] Módulo 2: Todos têm task001 COMPLETED?
- [ ] Módulo 3: Todos sabem ler logs?
- [ ] Módulo 4: Todos executaram lote?
- [ ] Módulo 5: Todos sabem aprovar/reprovar?
- [ ] Módulo 6: Todos fizeram exercício final?

**Meta:** 80%+ dos participantes completam todos os módulos

---

### Material de Apoio (Distribuir)

**Durante treinamento:**
- [ ] Handout impresso (comandos úteis - 1 página)
- [ ] Checklist de troubleshooting (1 página)

**Pós-treinamento:**
- [ ] Link para documentação completa (INDEX.md)
- [ ] Contato para suporte técnico
- [ ] Formulário de feedback

---

## 📊 Comparação dos Materiais

| Aspecto | Apresentação Sponsor | Treinamento Técnico |
|---------|---------------------|---------------------|
| **Público** | Gestores, Decisores | Desenvolvedores, QA |
| **Objetivo** | Aprovar implementação | Capacitar operação |
| **Duração** | 40 minutos | 2-3 horas |
| **Formato** | Slides (apresentação) | Markdown (hands-on) |
| **Foco** | ROI, Benefícios | Como usar, Debug |
| **Hands-on** | ❌ Não (demo opcional) | ✅ Sim (3 exercícios) |
| **Nível técnico** | Baixo-Médio | Alto |
| **Decisão esperada** | ✅ Aprovar Fase 1 | ✅ Equipe capacitada |

---

## 🎯 Roadmap de Apresentações

### Semana 1: Apresentação para Sponsor
- [ ] Agendar reunião (40 min)
- [ ] Preparar material (converter MD → PPTX)
- [ ] Apresentar e buscar aprovação
- [ ] Se aprovado: Prosseguir para Fase 1

### Semana 2: Treinamento Técnico (Turma 1)
- [ ] Enviar pré-requisitos (1 semana antes)
- [ ] Realizar treinamento (2-3 horas)
- [ ] Coletar feedback
- [ ] Ajustar material se necessário

### Semana 3: Treinamento Técnico (Turma 2)
- [ ] Repetir com segunda turma (se necessário)
- [ ] Certificar participantes

### Semana 4+: Implementação
- [ ] Equipe capacitada inicia Fase 1
- [ ] Instrutor dá suporte conforme necessário

---

## 📞 Suporte

### Dúvidas sobre Apresentação
- Consultar APRESENTACAO_SPONSOR.md (comentários no final)
- Revisar RESUMO_EXECUTIVO.md (reforçar argumentos)

### Dúvidas sobre Treinamento
- Consultar TREINAMENTO_TECNICO.md
- Testar comandos ANTES de ministrar

---

## 📝 Feedback e Melhoria Contínua

### Após Apresentação Sponsor
```markdown
**Perguntas para refletir:**
- [ ] Aprovação foi obtida?
- [ ] Quais objeções foram levantadas?
- [ ] Quais slides geraram mais dúvidas?
- [ ] Material precisa ser ajustado?
```

### Após Treinamento Técnico
```markdown
**Formulário de feedback (participantes):**
1. Nível de clareza (1-5): ___
2. Material hands-on suficiente? (Sim/Não): ___
3. Sente-se capaz de operar o sistema? (Sim/Não): ___
4. Sugestões de melhoria: ___________________

**Taxa de sucesso esperada:** 80%+ respondem "Sim" na pergunta 3
```

---

## ✅ Conclusão

Você tem agora **2 materiais profissionais**:

1. **APRESENTACAO_SPONSOR.md** (31 slides)
   - Para buscar aprovação
   - Foco em ROI e benefícios
   - Decisão: Aprovar Fase 1

2. **TREINAMENTO_TECNICO.md** (6 módulos)
   - Para capacitar equipe
   - Foco em operação prática
   - Resultado: Equipe autônoma

**Próximos passos:**
1. Agendar apresentação para sponsor
2. Se aprovado: Agendar treinamento técnico
3. Coletar feedback e melhorar materiais
4. Iniciar Fase 1 com equipe capacitada

---

**Boa apresentação! 🎉**

_Última atualização: 2026-01-22_
_Versão: 1.0_
