# Solicitacao de Teste Manual

**Task ID:** task108
**Formulario:** Formsigregli (origem: sigregli)
**Tipo:** OPERACIONAL - Impressao de Relacoes e Etiquetas de OP/OS
**Data:** 2026-06-05

---

## 1. Objetivo do Teste

Validar se o formulario migrado (**Formsigregli**) esta funcionando corretamente,
com UI proxima ao original e todas as funcoes de impressao/visualizacao operacionais.

## 2. Pre-Requisitos

- [ ] Codigo migrado esta em: `C:\4c\projeto\app\forms\operacionais\Formsigregli.prg`
- [ ] Business Object em: `C:\4c\projeto\app\classes\sigregliBO.prg`
- [ ] Banco de dados acessivel: 192.168.15.101 (DB_MBAHIA)
- [ ] Impressora configurada (para testes de impressao real)
- [ ] Relatorios FRX disponiveis em `C:\4c\projeto\app\reports\`
- [ ] Usuario com permissao de teste

## 3. Contexto do Formulario

Form operacional para impressao de relacoes e etiquetas de Ordens de Producao/Servico.

**Funcionalidades:**
- 6 tipos de impressao (OptionGroup Tipo):
  1. **Relacao** - Lista de OS/OP com ordenacao simples
  2. **Etiqueta** - Etiquetas adesivas de OS/OP
  3. **Tira Auxiliar** - Tiras auxiliares (2a ordem)
  4. **Tira Definitiva** - Tiras definitivas (2a ordem)
  5. **Relacao Especial** - Relacao com filtros especificos
  6. **Etiqueta Final** - Etiquetas finais
- Filtros: Classificacao, Linha, Cor, Fase, Descricao da Fase
- Parametros: Sequencia Inicial/Final, Ordem, 2a Ordem
- Dois containers flutuantes: Etiquetas e Relacao (conforme tipo selecionado)
- Botao Imprimir e Visualizar (video)

## 4. Casos de Teste

### 4.1. Teste de Abertura do Formulario

- [ ] Abrir o formulario via menu do sistema
- [ ] Verificar titulo: "Impressao de Relacoes e Etiquetas" na barra superior
- [ ] Verificar dimensoes: 600 x 600 pixels (centralizado)
- [ ] Verificar que OptionGroup "Tipo" tem 6 opcoes
- [ ] Verificar que os campos de filtro estao visiveis: Classificacao, Linha, Cor, Fase, Descricao
- [ ] Verificar campos: Sequencia Ini/Fim, Ordem, 2a Ordem
- [ ] Verificar botoes: Video, Impressora, Encerrar

### 4.2. Teste de Selecao de Tipo de Impressao

- [ ] Selecionar Tipo = 1 (Relacao)
  - Container Relacao deve aparecer
  - Container Etiquetas deve desaparecer
  - Botao Video deve estar HABILITADO
- [ ] Selecionar Tipo = 2 (Etiqueta)
  - Container Etiquetas deve aparecer
  - Container Relacao deve desaparecer
  - Campos Boleto e Label9 devem ficar visiveis no container Etiquetas
- [ ] Selecionar Tipo = 3 (Tira Auxiliar)
  - Se 2a Ordem > 0: Container Etiquetas aparece sem Boleto/Label9
  - Se 2a Ordem = 0: Containers nao aparecem (uso direto de impressao)
- [ ] Selecionar Tipo = 5 (Relacao Especial)
  - Ambos containers devem desaparecer
  - Botao Video deve estar DESABILITADO
- [ ] Selecionar Tipo = 6 (Etiqueta Final)
  - Container Etiquetas deve aparecer

### 4.3. Teste de Lookups (F4/Tab/Enter ativam busca)

- [ ] Campo Classificacao: pressionar F4 abre FormBuscaAuxiliar para SigCdCls
- [ ] Campo Linha: pressionar F4 abre FormBuscaAuxiliar para SigCdLin
- [ ] Campo Cor: pressionar F4 abre FormBuscaAuxiliar para SigCdCor
- [ ] Campo Fase: pressionar F4 - SEEK em crGruposBal; se nao encontrar, abre FormBuscaAuxiliar para SigCdGcr
- [ ] Campo Descricao Fase: pressionar F4 - SEEK em crGruposBal por descricao; se nao encontrar, abre FormBuscaAuxiliar
- [ ] Apos selecionar Fase, campo Descricao Fase deve ser preenchido automaticamente
- [ ] Digitar codigo invalido e pressionar Tab -> campo deve ser limpo ou abrir lista

### 4.4. Teste de Opcao de Ordem (OptionGroup TpOrdem)

- [ ] Selecionar TpOrdem = 1 (Processamento) - campos de Fase e Descricao devem ser relevantes
- [ ] Selecionar TpOrdem = 2 (Sequencia) - verificar se filtros de sequencia funcionam

### 4.5. Teste de Impressao (Tipo = 1 - Relacao)

- [ ] Selecionar Tipo = 1 (Relacao)
- [ ] Preencher filtros basicos (ou deixar em branco para imprimir todos)
- [ ] Clicar em "Impressora" (cmd_4c_Imprimir)
- [ ] Verificar que o relatorio e enviado para impressao/visualizacao
- [ ] Se Tipo=1 sem 2a Ordem: ProcRelacao chamado
- [ ] Se Tipo=1 com 2a Ordem > 0: ProcRelacao2 chamado

### 4.6. Teste de Visualizacao em Video

- [ ] Selecionar Tipo = 1 (Relacao) - botao Video habilitado
- [ ] Clicar em "Video" (cmd_4c_Visualizar)
- [ ] Verificar que relatorio aparece em pre-visualizacao na tela
- [ ] Fechar pre-visualizacao

### 4.7. Teste de Etiquetas (Tipo = 2)

- [ ] Selecionar Tipo = 2 (Etiqueta)
- [ ] Verificar container Etiquetas com opcoes: Divididas, 2Linhas, Boleto, Processo, Obs Pedido, etc.
- [ ] Preencher parametros de etiqueta
- [ ] Clicar em Imprimir -> ProcEtiquetas chamado

### 4.8. Teste de Encerramento

- [ ] Clicar em "Encerrar" (cmd_4c_Saida)
- [ ] Formulario deve fechar sem erros
- [ ] Verificar que o formulario pai (se houver) permanece aberto

### 4.9. Teste de Parametros via Menu (par_nNop)

- [ ] Abrir formulario via menu com par_nNop especifico (nao nulo)
- [ ] Verificar que TpOrdem e configurado conforme par_nNop
- [ ] Se TpOrdem for definido, OptionGroup deve estar DESABILITADO (nao alteravel pelo usuario)

## 5. Metricas de Qualidade (Automaticas)

### Compilacao
- Erros: 0 (ambos os arquivos compilaram)
- Status: APROVADO

### Teste de Formulario
- Objeto criado: OK
- Formulario visivel: OK (600 x 600)
- Formulario fechado: OK
- Status: APROVADO (botoes CRUD nao se aplicam a form OPERACIONAL)

### Validacao UI
- Erros criticos: 4 (DataEnvironment - sempre aceitaveis)
- Avisos: 500 (OptionButton.Option1.* - limitacao do validador, false positives)
- Diferencas: 3 (2 caption design-time vs runtime; 1 color format RGB vs decimal - false positives)
- Status: 3 diferencas sao falsos positivos - validacao manual recomendada

## 6. Resultado do Teste

- [ ] UI Fidelity: **APROVADO / REPROVADO**
- [ ] Abertura do formulario: **APROVADO / REPROVADO**
- [ ] Selecao de tipos: **APROVADO / REPROVADO**
- [ ] Lookups funcionando: **APROVADO / REPROVADO**
- [ ] Impressao Relacao: **APROVADO / REPROVADO**
- [ ] Impressao Etiqueta: **APROVADO / REPROVADO**
- [ ] Visualizacao Video: **APROVADO / REPROVADO**
- [ ] Encerramento: **APROVADO / REPROVADO**

### Problemas Encontrados

*(Listar problemas encontrados durante o teste manual)*

1.
2.
3.

### Aprovacao

- [ ] **APROVADO** - Formulario pronto para producao
- [ ] **REPROVADO** - Necessita correcoes

**Testador:** ___________________________
**Data:** ___________________________
**Assinatura:** ___________________________

---

**Arquivos Migrados:**
- Form: `C:\4c\projeto\app\forms\operacionais\Formsigregli.prg`
- BO: `C:\4c\projeto\app\classes\sigregliBO.prg`

**Proximos Passos:**
- Se APROVADO: Commit do codigo e deploy
- Se REPROVADO: Abrir issues para correcoes necessarias
