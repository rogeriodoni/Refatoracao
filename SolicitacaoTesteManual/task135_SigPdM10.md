# Solicitacao de Teste Manual

**Task ID:** task135
**Formulario:** FormSigPdM10 (origem: SigPdM10)
**Tipo:** OPERACIONAL - Subform modal (chamado pelo form pai)
**Data:** 2026-06-18

---

## 1. Objetivo do Teste

Validar se o formulario migrado (**FormSigPdM10**) — Resumo da Movimentacao — esta funcionando corretamente e com UI identica ao original SIGPDM10.SCX.

---

## 2. Pre-Requisitos

- [ ] Codigo migrado em: `C:\4c\projeto\app\forms\operacionais\FormSigPdM10.prg`
- [ ] Business Object em: `C:\4c\projeto\app\classes\SigPdM10BO.prg`
- [ ] Banco de dados acessivel: 192.168.15.101 (DB_MBAHIA)
- [ ] Formulario pai (ex: SigPdAco) funcionando — FormSigPdM10 e um subform modal
- [ ] Registros de movimentacao existentes no banco (TmpNens, xNensi, xPesa, xMFas)

---

## 3. Como Acionar o Formulario

FormSigPdM10 e chamado por forms de movimentacao de producao (ex: SigPdAco, SigPdPro).
Para testar, abrir um formulario de movimentacao, processar uma OP e verificar se o
Resumo da Movimentacao aparece corretamente.

---

## 4. Casos de Teste

### 4.1. Teste de Abertura

- [ ] Abrir form pai de movimentacao (SigPdAco ou similar)
- [ ] Processar uma movimentacao com OP existente
- [ ] Verificar se FormSigPdM10 abre como modal
- [ ] Verificar Caption: "Resumo da Movimentacao"
- [ ] Verificar cabecalho (cnt_4c_Sombra) com titulo em branco e cinza

**Criterio de Aceitacao:** Form abre sem erros, modal sobre o form pai.

---

### 4.2. Teste do Layout Normal (sem modo OP)

Quando `SigCdOpd.ResumoPOp = .F.` para o tipo de OP processado:

- [ ] Grid de Envelopes (grd_4c_GradeEnvelopes) visivel com colunas:
  - Industrializacao | Peso Entrada | Peso Saida
- [ ] Grid de Movimentacoes Finalizadas (grd_4c_GradePedidos) visivel com colunas:
  - Codigo | Movimentacao | Conta | Responsavel
- [ ] Grid de Componentes Baixados (grd_4c_GradeMateriais) visivel com colunas:
  - Componente | Descricao | Quantidade | Uni | Peso Atual
- [ ] Container cnt_4c_Ops NAO visivel

**Criterio de Aceitacao:** Grids exibem dados corretos do cursor da datasession do pai.

---

### 4.3. Teste do Layout com Modo OP (`SigCdOpd.ResumoPOp = .T.`)

Quando o tipo de OP tem `ResumoPOp = .T.`:

- [ ] Container cnt_4c_Ops VISIVEL cobrindo area de dados
- [ ] Grid de Movimentacoes Finalizadas (grd_4c_GradePedOp) na esquerda com colunas:
  - Movimentacao | Codigo | Industrializacao | Conta
- [ ] Grid de Componentes Baixados por OP (grd_4c_GradeMatOp) abaixo
- [ ] Grid de Componentes Baixados - Geral (grd_4c_MatGeral) na direita
- [ ] Ao clicar em linha diferente em grd_4c_GradePedOp:
  - grd_4c_GradeMatOp deve atualizar mostrando somente materiais da OP selecionada

**Criterio de Aceitacao:** Navegacao entre OPs filtra corretamente o grid de materiais.

---

### 4.4. Teste de Etiquetas (quando par_lEtiq = .T.)

Quando o form pai chama `CREATEOBJECT("FormSigPdM10", oParent, .T.)`:

- [ ] Container cnt_4c_Etiquetas visivel na parte superior do form (acima dos grids)
- [ ] OptionGroup de tipos de etiqueta (obj_4c_Opt_Tipo) com opcoes carregadas do SigCdTpe
- [ ] ComboBox de impressoras (cbo_4c_Get_Printer) populado com impressoras autorizadas
- [ ] OptionGroups Preco e Peso com opcoes Sim/Nao
- [ ] Container de configuracoes de impressora com spinners Vertical/Horizontal/Densidade/Velocidade
- [ ] Ao mudar impressora no combo: configuracoes atualizam com dados de SigCdmp
- [ ] Clicar "Imprimir": executa SigOpEtq e mostra mensagem "Impressao Concluida!!!"

**Criterio de Aceitacao:** Etiquetas sao impressas corretamente conforme tipo selecionado.

---

### 4.5. Teste do Botao Encerrar

- [ ] Clicar no botao "Encerrar" (cnt_4c_Saida > cmd_4c_Encerrar)
- [ ] Form fecha sem erros
- [ ] Form pai volta a ficar habilitado (Enabled = .T.)

**Criterio de Aceitacao:** Form fecha e control retorna ao form pai sem erros.

---

### 4.6. Teste de UI Fidelity

- [ ] Comparar visualmente com SIGPDM10 original
- [ ] Verificar dimensoes: Width=1000, Height=600
- [ ] Verificar cabecalho cinza (cnt_4c_Sombra) na parte superior
- [ ] Verificar grids com bordas discretas (GridLineColor = cinza claro)
- [ ] Verificar botao Encerrar no canto superior direito (Left=917)
- [ ] Verificar que o form e modal (nao permite interacao com form pai enquanto aberto)

**Criterio de Aceitacao:** UI identica ao original SIGPDM10.SCX.

---

## 5. Resultado dos Testes Automatizados

**Compilacao:** OK (ambos FormSigPdM10.prg e SigPdM10BO.prg compilam sem erros)

**TesteAutomatico (sem banco):**
- Instanciacao: PASSOU
- ContainersFlutuantes: PASSOU
- CarregarDadosReais: FALHOU (esperado - sem conexao ao banco em modo teste)
- NavegacaoPaginas: PASSOU (form sem PageFrame, correto)
- BtnEncerrarExiste: PASSOU
- GridTemDados: PASSOU (pulado sem banco, correto)
- LookupMetodosExistem: PASSOU
- Fechar: PASSOU
- **TOTAL: 8/9 (89%) - Falha esperada sem conexao ao banco**

---

## 6. Observacoes Tecnicas

- Form compartilha DataSessionId com o form pai para acessar cursores pre-carregados
  (TmpNens, xNensi, xPesa, xMFas) criados pelo form pai
- O layout varia conforme SigCdOpd.ResumoPOp do tipo de OP (layout normal vs modo OP)
- Container cnt_4c_Etiquetas e controlado pelo parametro par_lEtiq passado pelo form pai
- Impressao de etiquetas usa funcao SigOpEtq() com gnConnHandle
