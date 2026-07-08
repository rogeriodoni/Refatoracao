# Teste Manual - Formsigpdmp2 (Componentes de Producao)

**Arquivo:** `C:\4c\projeto\app\forms\operacionais\Formsigpdmp2.prg`  
**Task:** task143  
**Data:** 2026-06-18  
**Requisito:** Abrir via FormSigPdMfa (sub-form operacional - NAO abre standalone)

---

## Pre-requisitos

1. Sistema iniciado: `DO C:\4c\projeto\app\start\main.prg`
2. Usuario logado com acesso ao modulo de Producao
3. Existir pelo menos uma Ordem de Producao (OP) aberta no sistema
4. Banco DB_MBAHIA acessivel em 192.168.15.101

---

## 1. Abertura do Form (via FormSigPdMfa)

| # | Acao | Resultado Esperado |
|---|------|--------------------|
| 1.1 | Navegar no menu ate Producao > Lancamentos | FormSigPdMfa abre |
| 1.2 | Selecionar uma OP existente e clicar Inserir ou Alterar | Formsigpdmp2 abre como sub-form |
| 1.3 | Verificar dimensoes do form | Largura=1000, Altura=600, sem bordas |
| 1.4 | Verificar cabecalho (faixa cinza superior) | Titulo "Componentes" em branco sobre cinza |
| 1.5 | Verificar linha "Movimentacao:" com campos Empresa, Operacao, Codigo | Preenchidos com dados da OP selecionada (ReadOnly) |

---

## 2. Grade Principal (13 Colunas)

| # | Acao | Resultado Esperado |
|---|------|--------------------|
| 2.1 | Observar grid principal | 13 colunas: OF/Envelope, Componente, Envelope, Uni, Tipo de Material, Quantidade, Peso Fabr., Cat., Quantidade, Uni, Lote, Cor, Tam |
| 2.2 | Navegar entre registros com teclas de seta | Cursor se move corretamente |
| 2.3 | Clicar na coluna Componente (Col2) de linha existente | Campo fica editavel, aceita digitacao |
| 2.4 | Digitar codigo de componente invalido em Col2 e pressionar TAB | Lookup FormBuscaAuxiliar abre para selecao |
| 2.5 | Digitar codigo valido e pressionar ENTER | Campo preenchido, cursor avanca |
| 2.6 | Clicar na coluna Tipo de Material (Col5) | Campo fica editavel |
| 2.7 | Pressionar F4 em Col5 | FormBuscaAuxiliar abre para selecao de material |
| 2.8 | Clicar na coluna Envelope (Col3) (se EnvObrig ativo) | Campo fica editavel para digitar codigo do envelope |

---

## 3. Botoes de Acao (lado direito)

| # | Acao | Resultado Esperado |
|---|------|--------------------|
| 3.1 | Clicar botao "Inserir" (Top=222) | Nova linha adicionada ao grid para edicao |
| 3.2 | Preencher Componente e Quantidade na nova linha | Campos aceitos corretamente |
| 3.3 | Mover para outra linha (confirma insercao) | Validacoes de peso/quantidade executadas |
| 3.4 | Clicar botao "Alterar" (Top=297) com linha selecionada | Linha selecionada fica editavel |
| 3.5 | Modificar Quantidade e confirmar | Valor salvo no cursor |
| 3.6 | Clicar botao "Excluir" (Top=372) com linha selecionada | Confirmacao solicitada, registro removido |
| 3.7 | Clicar "Excluir" sem selecionar linha | Mensagem de aviso "Selecione um registro" |

---

## 4. Checkboxes (faixa superior, Top=81)

| # | Checkbox | Left | Acao | Resultado Esperado |
|---|----------|------|------|--------------------|
| 4.1 | Informar Retrabalho | 171 | Marcar | Container de Retrabalho exibido (se habilitado) |
| 4.2 | Repete Tipo Material | 246 | Marcar | Tipo Material replicado automaticamente na proxima insercao |
| 4.3 | Inserir Automatico | 321 | Marcar | Insercao automatica apos validacao do componente |
| 4.4 | Pagamento Lancado | 396 | Verificar estado | Reflete status de pagamento da OP |
| 4.5 | Retrabalho Realizado | 471 | Verificar cor | Vermelho se existem retrabalhos anteriores, azul caso contrario |
| 4.6 | Nao Conformes | 546 | Marcar | Habilita campos de nao-conformidade |
| 4.7 | Repete Retrabalho | 621 | Verificar visibilidade | Deve estar oculto (Visible=.F.) |
| 4.8 | Material Agregado | 696 | Marcar | Habilita campo de agregado |

---

## 5. Botao Lotes (Top=81, Left=846)

| # | Acao | Resultado Esperado |
|---|------|--------------------|
| 5.1 | Selecionar linha no grid que tenha saldo de lote | - |
| 5.2 | Clicar botao "Lotes" | Container flutuante de lotes aparece (Top=207, Left=287) |
| 5.3 | Verificar grid de lotes | 3 colunas: Lote, Componente, Saldo |
| 5.4 | Verificar que o grid principal ainda esta visivel por baixo | Container flutuante sobrepoe parcialmente |
| 5.5 | Clicar "Ok" no container de lotes | Container fecha, botao Lotes reabilitado |

---

## 6. Campos Inferiores

| # | Campo | Posicao | Verificacao |
|---|-------|---------|-------------|
| 6.1 | Cor/Tamanho | Top=506, Left=108/143 | ReadOnly, preenchido com Cor e Tam do componente selecionado |
| 6.2 | Descricao | Top=529, Left=108 | ReadOnly, descricao do componente |
| 6.3 | Observacao | Top=552, Left=108 | ReadOnly, observacao da OP |

---

## 7. Container de Servico (Cnt_Servico) - quando tipo = servico

| # | Acao | Resultado Esperado |
|---|------|--------------------|
| 7.1 | Inserir componente do tipo Servico na grade | Container de Servico aparece (Top=501, Left=404) |
| 7.2 | Verificar campos: Servico (cpro), Descricao (dpro), Valor, Moeda, Quantidade, Total, Retrabalho | Todos preenchidos/editaveis conforme configuracao |
| 7.3 | Alterar Quantidade no container | Total recalculado automaticamente |

---

## 8. Validacoes e Regras de Negocio

| # | Cenario | Resultado Esperado |
|---|---------|---------------------|
| 8.1 | Tentar inserir componente sem Tipo de Material | Mensagem "Existem Lancamentos Sem Tipo de Material!!!" |
| 8.2 | Tentar inserir componente sem Cor (quando obrigatorio) | Mensagem "Existem Lancamentos Sem Cor!!!" |
| 8.3 | Tentar inserir componente sem Tamanho (quando obrigatorio) | Mensagem de aviso correspondente |
| 8.4 | Quantidade zero ou negativa | Validacao impede avanco |
| 8.5 | Limite de componentes excedido | Mensagem de limite |
| 8.6 | Usuario sem permissao de Inserir | Botao Inserir desabilitado/oculto |
| 8.7 | Usuario sem permissao de Alterar | Botao Alterar desabilitado/oculto |

---

## 9. Encerrar / Sair

| # | Acao | Resultado Esperado |
|---|------|--------------------|
| 9.1 | Clicar botao "Encerrar" (canto superior direito) | Form fecha, retorna ao FormSigPdMfa |
| 9.2 | Verificar que FormSigPdMfa ainda esta aberto e atualizado | Grid do pai atualizado com os novos componentes |

---

## 10. Testes de Regressao

| # | Cenario | Verificar |
|---|---------|-----------|
| 10.1 | Abrir form em modo VISUALIZAR | Todos os controles ReadOnly, botoes Inserir/Alterar/Excluir ocultos |
| 10.2 | Abrir form com OP que tem PCC ativo | Botao "Encerrar PCC" aparece (Top=81, Left=771) |
| 10.3 | Abrir form para OP com controle de lote ativo | InfoLote=.T., coluna Lote editavel |
| 10.4 | Abrir form para OP com envelope obrigatorio | Coluna Envelope editavel, validacao ativa |
| 10.5 | Testar com datasession do form pai (crSigCdOpd acessivel) | Sem erros de "Table not found" ou "Alias not found" |

---

## Observacoes Tecnicas

- **Datasession**: Form abre com DataSession=2 mas chama `SET DATASESSION TO par_nDatSes` imediatamente em InicializarForm() para acessar cursores do pai (xNensi, TmpNens, crSigCdOpd).
- **Proxy**: `THIS.poDataMgr` e um DataMgrProxy que delega para `gnConnHandle` - sub-forms legados que acessem `pForm.poDataMgr.SqlExecute()` devem funcionar normalmente.
- **BINDEVENTs com nFlags=2**: Colunas When/Valid do grid usam `BINDEVENT(..., "When", ..., 2)` e `BINDEVENT(..., "Valid", ..., 2)` - o valor de retorno do handler controla se a celula fica editavel.
- **Sem RETURN dentro de TRY**: Metodos que precisavam de saida antecipada usam flag `loc_lSucesso` e RETURN fora do TRY/CATCH.
