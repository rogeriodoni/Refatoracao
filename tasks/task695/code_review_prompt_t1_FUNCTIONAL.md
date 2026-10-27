# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (27)
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [METODO-INEXISTENTE] Metodo 'THIS.ValidarContaSelecionada()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.PodeAlterarCadastro()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.AbrirVisaoCadastral()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.AbaResultadoDisponivel()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.KeyPress()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [NAVEGACAO-PAGINA] Metodo 'BtnCancelarClick' faz ActivePage=2 mas NAO le dados de cursor nem chama CarregarHistorico/CarregarDados. Em forms OPERACIONAL, a navegacao para Page2 DEVE carregar dados da linha selecionada no grid de Page1 (padrao legado: cmd_consulta.Click le do cursor do grid).
- [GRID-HEADER] Header Caption 'O' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Disponível, Grupo, Limite Crédito, Moe, Conta, Histórico, Titulo, Vencto, Valor, V.Pago, Saldo, Código, Data, Emp, Valor Mov., Header1, Mes/Ano, Total, Tipo, Vecto, , Tipos, Vl. Pendente, PEDIDOS, ITENS, Produto, Quantidade, %, PRODUÇÃO, Fase, Qtde, Dt. Entrega, O.P., Envelope, Pedido, Status, ESTOQUE, MOVIMENTAÇÃO, Vencimento, Banco, Agencia, Número, Grupo Carteira, Conta Carteira, Arquivo, Dias Pag., Operação, Alinea, Entrada, Grupo/Origem, Conta/Origem, Grupo/Destino, Conta/Destino, Lote, Protocolo, Prorrogações, Usuário, Data / Hora, No. Oper. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Bco.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Disponível, Grupo, Limite Crédito, Moe, Conta, Histórico, Titulo, Vencto, Valor, V.Pago, Saldo, Código, Data, Emp, Valor Mov., Header1, Mes/Ano, Total, Tipo, Vecto, , Tipos, Vl. Pendente, PEDIDOS, ITENS, Produto, Quantidade, %, PRODUÇÃO, Fase, Qtde, Dt. Entrega, O.P., Envelope, Pedido, Status, ESTOQUE, MOVIMENTAÇÃO, Vencimento, Banco, Agencia, Número, Grupo Carteira, Conta Carteira, Arquivo, Dias Pag., Operação, Alinea, Entrada, Grupo/Origem, Conta/Origem, Grupo/Destino, Conta/Destino, Lote, Protocolo, Prorrogações, Usuário, Data / Hora, No. Oper. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Ag.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Disponível, Grupo, Limite Crédito, Moe, Conta, Histórico, Titulo, Vencto, Valor, V.Pago, Saldo, Código, Data, Emp, Valor Mov., Header1, Mes/Ano, Total, Tipo, Vecto, , Tipos, Vl. Pendente, PEDIDOS, ITENS, Produto, Quantidade, %, PRODUÇÃO, Fase, Qtde, Dt. Entrega, O.P., Envelope, Pedido, Status, ESTOQUE, MOVIMENTAÇÃO, Vencimento, Banco, Agencia, Número, Grupo Carteira, Conta Carteira, Arquivo, Dias Pag., Operação, Alinea, Entrada, Grupo/Origem, Conta/Origem, Grupo/Destino, Conta/Destino, Lote, Protocolo, Prorrogações, Usuário, Data / Hora, No. Oper. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Cheque' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Disponível, Grupo, Limite Crédito, Moe, Conta, Histórico, Titulo, Vencto, Valor, V.Pago, Saldo, Código, Data, Emp, Valor Mov., Header1, Mes/Ano, Total, Tipo, Vecto, , Tipos, Vl. Pendente, PEDIDOS, ITENS, Produto, Quantidade, %, PRODUÇÃO, Fase, Qtde, Dt. Entrega, O.P., Envelope, Pedido, Status, ESTOQUE, MOVIMENTAÇÃO, Vencimento, Banco, Agencia, Número, Grupo Carteira, Conta Carteira, Arquivo, Dias Pag., Operação, Alinea, Entrada, Grupo/Origem, Conta/Origem, Grupo/Destino, Conta/Destino, Lote, Protocolo, Prorrogações, Usuário, Data / Hora, No. Oper. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Bco.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Disponível, Grupo, Limite Crédito, Moe, Conta, Histórico, Titulo, Vencto, Valor, V.Pago, Saldo, Código, Data, Emp, Valor Mov., Header1, Mes/Ano, Total, Tipo, Vecto, , Tipos, Vl. Pendente, PEDIDOS, ITENS, Produto, Quantidade, %, PRODUÇÃO, Fase, Qtde, Dt. Entrega, O.P., Envelope, Pedido, Status, ESTOQUE, MOVIMENTAÇÃO, Vencimento, Banco, Agencia, Número, Grupo Carteira, Conta Carteira, Arquivo, Dias Pag., Operação, Alinea, Entrada, Grupo/Origem, Conta/Origem, Grupo/Destino, Conta/Destino, Lote, Protocolo, Prorrogações, Usuário, Data / Hora, No. Oper. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Ag.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Disponível, Grupo, Limite Crédito, Moe, Conta, Histórico, Titulo, Vencto, Valor, V.Pago, Saldo, Código, Data, Emp, Valor Mov., Header1, Mes/Ano, Total, Tipo, Vecto, , Tipos, Vl. Pendente, PEDIDOS, ITENS, Produto, Quantidade, %, PRODUÇÃO, Fase, Qtde, Dt. Entrega, O.P., Envelope, Pedido, Status, ESTOQUE, MOVIMENTAÇÃO, Vencimento, Banco, Agencia, Número, Grupo Carteira, Conta Carteira, Arquivo, Dias Pag., Operação, Alinea, Entrada, Grupo/Origem, Conta/Origem, Grupo/Destino, Conta/Destino, Lote, Protocolo, Prorrogações, Usuário, Data / Hora, No. Oper. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Cheque' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Disponível, Grupo, Limite Crédito, Moe, Conta, Histórico, Titulo, Vencto, Valor, V.Pago, Saldo, Código, Data, Emp, Valor Mov., Header1, Mes/Ano, Total, Tipo, Vecto, , Tipos, Vl. Pendente, PEDIDOS, ITENS, Produto, Quantidade, %, PRODUÇÃO, Fase, Qtde, Dt. Entrega, O.P., Envelope, Pedido, Status, ESTOQUE, MOVIMENTAÇÃO, Vencimento, Banco, Agencia, Número, Grupo Carteira, Conta Carteira, Arquivo, Dias Pag., Operação, Alinea, Entrada, Grupo/Origem, Conta/Origem, Grupo/Destino, Conta/Destino, Lote, Protocolo, Prorrogações, Usuário, Data / Hora, No. Oper. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Cartão' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Disponível, Grupo, Limite Crédito, Moe, Conta, Histórico, Titulo, Vencto, Valor, V.Pago, Saldo, Código, Data, Emp, Valor Mov., Header1, Mes/Ano, Total, Tipo, Vecto, , Tipos, Vl. Pendente, PEDIDOS, ITENS, Produto, Quantidade, %, PRODUÇÃO, Fase, Qtde, Dt. Entrega, O.P., Envelope, Pedido, Status, ESTOQUE, MOVIMENTAÇÃO, Vencimento, Banco, Agencia, Número, Grupo Carteira, Conta Carteira, Arquivo, Dias Pag., Operação, Alinea, Entrada, Grupo/Origem, Conta/Origem, Grupo/Destino, Conta/Destino, Lote, Protocolo, Prorrogações, Usuário, Data / Hora, No. Oper. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Crédito' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Disponível, Grupo, Limite Crédito, Moe, Conta, Histórico, Titulo, Vencto, Valor, V.Pago, Saldo, Código, Data, Emp, Valor Mov., Header1, Mes/Ano, Total, Tipo, Vecto, , Tipos, Vl. Pendente, PEDIDOS, ITENS, Produto, Quantidade, %, PRODUÇÃO, Fase, Qtde, Dt. Entrega, O.P., Envelope, Pedido, Status, ESTOQUE, MOVIMENTAÇÃO, Vencimento, Banco, Agencia, Número, Grupo Carteira, Conta Carteira, Arquivo, Dias Pag., Operação, Alinea, Entrada, Grupo/Origem, Conta/Origem, Grupo/Destino, Conta/Destino, Lote, Protocolo, Prorrogações, Usuário, Data / Hora, No. Oper. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Nº Cartão' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Disponível, Grupo, Limite Crédito, Moe, Conta, Histórico, Titulo, Vencto, Valor, V.Pago, Saldo, Código, Data, Emp, Valor Mov., Header1, Mes/Ano, Total, Tipo, Vecto, , Tipos, Vl. Pendente, PEDIDOS, ITENS, Produto, Quantidade, %, PRODUÇÃO, Fase, Qtde, Dt. Entrega, O.P., Envelope, Pedido, Status, ESTOQUE, MOVIMENTAÇÃO, Vencimento, Banco, Agencia, Número, Grupo Carteira, Conta Carteira, Arquivo, Dias Pag., Operação, Alinea, Entrada, Grupo/Origem, Conta/Origem, Grupo/Destino, Conta/Destino, Lote, Protocolo, Prorrogações, Usuário, Data / Hora, No. Oper. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Qtde.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Disponível, Grupo, Limite Crédito, Moe, Conta, Histórico, Titulo, Vencto, Valor, V.Pago, Saldo, Código, Data, Emp, Valor Mov., Header1, Mes/Ano, Total, Tipo, Vecto, , Tipos, Vl. Pendente, PEDIDOS, ITENS, Produto, Quantidade, %, PRODUÇÃO, Fase, Qtde, Dt. Entrega, O.P., Envelope, Pedido, Status, ESTOQUE, MOVIMENTAÇÃO, Vencimento, Banco, Agencia, Número, Grupo Carteira, Conta Carteira, Arquivo, Dias Pag., Operação, Alinea, Entrada, Grupo/Origem, Conta/Origem, Grupo/Destino, Conta/Destino, Lote, Protocolo, Prorrogações, Usuário, Data / Hora, No. Oper. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Agência' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Disponível, Grupo, Limite Crédito, Moe, Conta, Histórico, Titulo, Vencto, Valor, V.Pago, Saldo, Código, Data, Emp, Valor Mov., Header1, Mes/Ano, Total, Tipo, Vecto, , Tipos, Vl. Pendente, PEDIDOS, ITENS, Produto, Quantidade, %, PRODUÇÃO, Fase, Qtde, Dt. Entrega, O.P., Envelope, Pedido, Status, ESTOQUE, MOVIMENTAÇÃO, Vencimento, Banco, Agencia, Número, Grupo Carteira, Conta Carteira, Arquivo, Dias Pag., Operação, Alinea, Entrada, Grupo/Origem, Conta/Origem, Grupo/Destino, Conta/Destino, Lote, Protocolo, Prorrogações, Usuário, Data / Hora, No. Oper. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Alínea' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Disponível, Grupo, Limite Crédito, Moe, Conta, Histórico, Titulo, Vencto, Valor, V.Pago, Saldo, Código, Data, Emp, Valor Mov., Header1, Mes/Ano, Total, Tipo, Vecto, , Tipos, Vl. Pendente, PEDIDOS, ITENS, Produto, Quantidade, %, PRODUÇÃO, Fase, Qtde, Dt. Entrega, O.P., Envelope, Pedido, Status, ESTOQUE, MOVIMENTAÇÃO, Vencimento, Banco, Agencia, Número, Grupo Carteira, Conta Carteira, Arquivo, Dias Pag., Operação, Alinea, Entrada, Grupo/Origem, Conta/Origem, Grupo/Destino, Conta/Destino, Lote, Protocolo, Prorrogações, Usuário, Data / Hora, No. Oper. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'Origem' (parent: SIGOPCGV.fld_principal.pag_consulta): Top original=89 vs migrado 'cnt_4c_Origem' Top=5 (diff=84px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Saida' (parent: SIGOPCGV.fld_principal.pag_resultado.SelecionaImpCad): Left original=379 vs migrado 'cmd_4c_Saida' Left=329 (diff=50px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Visualizar' (parent: SIGOPCGV.fld_principal.pag_resultado.SelecionaImpCad): Left original=231 vs migrado 'cmd_4c_Visualizar' Left=179 (diff=52px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Imprimir' (parent: SIGOPCGV.fld_principal.pag_resultado.SelecionaImpCad): Left original=306 vs migrado 'cmd_4c_Imprimir' Left=254 (diff=52px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Anexa' (parent: SIGOPCGV.fld_principal.pag_resultado.Result.Saldo): Top original=407 vs migrado 'cmd_4c_AnexaPend' Top=180 (diff=227px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Anexa' (parent: SIGOPCGV.fld_principal.pag_resultado.Result.Saldo): Left original=744 vs migrado 'cmd_4c_AnexaPend' Left=835 (diff=91px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Anexa' (parent: SIGOPCGV.fld_principal.pag_resultado.Result.Vendas): Left original=203 vs migrado 'cmd_4c_AnexaPend' Left=835 (diff=632px, tolerancia=30px)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES FUNCIONAIS
- [CONTAINER-VISIVEL] TornarControlesVisiveis nao filtra containers ocultos (Visible=.F.). Adicionar INLIST
- [BUSCA-CURSOR] FormBuscaAuxiliar sem this_cCursorDestino no Modo 2
- [OPTIONGROUP-LEFT] Buttons sobrepostos - definir .Left, .Top, .AutoSize em CADA Button
- [CARGA-DADOS] Validar* sem chamada de carga / OptionGroup sem InteractiveChange
- [BINDEVENT-PARAMS] Handler sem LPARAMETERS (AfterRowColChange(par_nColIndex), KeyPress(par_nKeyCode, par_nShift))
- [STUB-MSGAVISO] Btn*Click com MsgAviso placeholder ao inves de logica real
- [LOSTFOCUS-SEM-GUARDIA] Handler abre busca sem verificar se valor mudou
- [INIT-DUPLICADO] Init() chama DODEFAULT() + InicializarForm() (duplicado)
- [METODO-INEXISTENTE] THIS.Metodo() chamado mas nao definido no Form. LLM pode ter inventado. IMPLEMENTAR ou REMOVER.

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopcgv.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (6247 linhas total):

*-- Linhas 21 a 64:
21: *                      PageOrder - ver ConfigurarPageFrameResultado), as duas
22: *                      grades da aba Saldo (historico de conta corrente e
23: *                      saldo por moeda) carregadas de verdade pelo BO, o
24: *                      OptionGroup de navegacao entre as 10 abas, o filtro de
25: *                      periodo (cnt_periodo) e os CommandGroups Cadastro /
26: *                      Movimento / Voltar com a alternancia de visibilidade
27: *                      do legado (cmd_cadastro.Click / cmd_movimenta.Click /
28: *                      cmd_voltar.Click).
29: *
30: * Carga de dados: CarregarDados() -> sigopcgvBO.CarregarHistoricoSaldo(),
31: * que reproduz o trecho "Verificando Historicos / Verificando Saldo" do
32: * Processa() legado (SigMvCcr para dbHistorico; SigMvSlc + SigCdGcr +
33: * SigCdCli + SigClLcr, ou a soma do proprio dbHistorico quando ha periodo,
34: * para dbSaldo). Repintura num funil unico (AtualizarGradesSaldo - GO TOP +
35: * Refresh depois de trocar o ActivePage, regras #21 e #46).
36: *
37: * FASE 5/8 - Campos de dados das abas (parte 1). Entrega, por
38: * ConfigurarPaginaDados, o conteudo das abas que o Processa()/PCartao()/
39: * PEstoque() legado alimenta:
40: *
41: *   aba 2 Pendencias : grade TmpPar (6 colunas), grade de formas de pagamento
42: *                      crTmpTipos com CheckBox marcavel (os 4 handlers de
43: *                      toggle + FiltrarTipos), filtro de grupo, total das
44: *                      pendencias visiveis e os botoes Documento (abre o
45: *                      FormSigMvExp) e Listagem (SigReIpd).
46: *   aba 3 Cheques    : quatro grades (dbAberto / DbFollow / DbTitulo /
47: *                      dbDevolvido), filtro de grupo, os nove totais do pe da
48: *                      pagina (limite, a vencer, vencidos, devolvidos, saldo
49: *                      c/c, negociados, estoque, disponivel e total em aberto)
50: *                      e o follow-up / observacao da linha corrente.
51: *   aba 4 Cartao     : grade TmpCart (cartoes de credito em aberto).
52: *   aba 6 Estoque    : grade dbEstoque (produtos em poder do cliente) com
53: *                      filtro de grupo.
54: *
55: * Carga pelo BO: CarregarParametros (SigCdPam/SigCdGcr), CarregarPendencias
56: * (SigMvCcr + SigMvCab/SigMvPar/SigCdOpe/SigOpFp), CarregarCheques (SigChe +
57: * SigCqChm + SigCdOpt + SigCheh + SigMvCcr/SigOpOpe + SigClLcr/SigMvSlc/
58: * SigMvEst para os totais), CarregarCartoes (SigCdCrd) e CarregarEstoque
59: * (SigMvEst + SigCdEmp). Repintura num funil por aba, despachados por
60: * AtualizarAbaResultadoAtiva depois da troca de ActivePage (regras #21 e #46).
61: *
62: * FASE 6/8 - Campos de dados das abas (parte 2). Entrega, pelas mesmas
63: * ConfigurarPaginaDados/CarregarAbasResultado/AtualizarAbaResultadoAtiva, o
64: * conteudo das duas abas AUTOSSUFICIENTES que faltavam (cada uma com sua

*-- Linhas 117 a 160:
117: *       impressora via Set Printer To Name() e dependem do array gaprinters
118: *       (populado no login do framework legado) e do FormSigOpIpb de
119: *       selecao de impressora - infraestrutura de hardware nunca portada.
120: *       Os dois metodos avisam com MsgAviso em vez de fingir sucesso.
121: *
122: * As tres abas restantes (5 Vendas, 7 Operacoes Pend., 8 Producao)
123: * continuam de fora: as tres sao alimentadas pelo MESMO PProduto() legado
124: * (~700 linhas, com o padrao de staging SigTempC/CidQuerys do framework
125: * Fortyus - equivalente ja usado no projeto em SigPrGl2BO/SigTempD) e por
126: * isso formam uma unidade que precisa de uma fase propria. O wrapper
127: * clsconta (cntConta) da visao cadastral tambem continua de fora.
128: *
129: * FASE 8/8 - Eventos auxiliares e consolidacao final. Este form eh
130: * OPERACIONAL de CONSULTA (ver nota da FASE 7/8) e NAO tem Page1=Lista/
131: * Page2=Dados, mas cada nome canonico de evento auxiliar TEM contraparte no
132: * legado - e eh ela que foi entregue aqui, com os funis das fases anteriores
133: * passando a entrar por esses metodos (regra #40):
134: *
135: *   FormParaBO()      -> os cinco criterios do container Origem (Conta / Nome
136: *                        / CPF / Conjuge / Telefone), o optFiltro e o periodo
137: *                        do cnt_periodo; CarregarDados() entra por ele.
138: *   BOParaForm()      -> o caminho inverso (preenchimento cruzado que o legado
139: *                        faz no fim de cada Valid de pesquisa);
140: *                        AtualizarCamposOrigem() entra por ele.
141: *   HabilitarCampos() -> a cascata de When dos criterios (Get_cpf.When,
142: *                        Get_dconta.When, GetConj.When, getTelefone.When,
143: *                        optFiltro.When), em ReadOnly para nao disputar o foco.
144: *   LimparCampos()    -> o Space(N) dos cinco campos do cmd_voltar.Click mais o
145: *                        LimparDados() do BO (implementado nesta fase: zera
146: *                        criterios, flags de controle e totais derivados).
147: *   CarregarLista()   -> funil de (re)carga da consulta (CarregarDados +
148: *                        CarregarAbasResultado, a sequencia do Processa()).
149: *   AjustarBotoesPorModo() -> os gates de acesso do Init legado (fChecaAcesso
150: *                        CADASTRO/MOVIMENTA, com o reposicionamento do
151: *                        grp_operacao) e o do par Cmd_MudaCli/Cmd_MudaMov mais
152: *                        IMPRIMIR no Imprime; AlternarPagina() e
153: *                        AjustarVisibilidadeResultado() entram por ele.
154: *   BtnBuscarClick()  -> dispara a consulta (cmd_movimenta.Click na Consulta;
155: *                        refaz a consulta corrente na pagina Resultado).
156: *   BtnSalvarClick()  -> o bloco "Deseja salvar as alteracoes?" que ABRE o
157: *                        cmd_voltar.Click legado (mValidaObj + mGravaDados do
158: *                        cntConta); BtnVoltarClick() entra por ele e aborta a
159: *                        saida quando a validacao do cadastro recusa.
160: *   BtnCancelarClick()/BtnEncerrarClick() -> cmd_cancela.Click ([ESC] Sair) e o

*-- Linhas 167 a 377:
167: * VARTYPE+Show() fora do TRY - CLAUDE.md regra #29) e auditoria final de
168: * consistencia (compilacao limpa de sigopcgvBO.prg/Formsigopcgv.prg/menu.prg
169: * e cruzamento de THIS.<metodo>() e THIS.this_oBusinessObject.<metodo>() do
170: * form contra as PROCEDURE/FUNCTION do form e do BO). config.prg carrega os
171: * dois arquivos automaticamente via ADIR (*BO.prg / operacionais\Form*.prg),
172: * sem necessidade de SET PROCEDURE manual.
173: *==============================================================================
174: 
175: DEFINE CLASS Formsigopcgv AS FormBase
176: 
177:     DataSession  = 2
178:     Height       = 600
179:     Width        = 1000
180:     AutoCenter   = .T.
181:     Caption      = "Pesquisa Global de Vendas"
182:     ShowWindow   = 1
183:     ControlBox   = .F.
184:     Closable     = .F.
185:     MaxButton    = .F.
186:     MinButton    = .F.
187:     TitleBar     = 0
188:     WindowType   = 1
189:     ClipControls = .F.
190:     Themes       = .F.
191:     BorderStyle  = 2
192:     FontName     = "Verdana"
193:     FontSize     = 8
194:     ForeColor    = RGB(36, 84, 155)
195: 
196:     this_oBusinessObject = .NULL.
197:     this_cModoAtual       = ""
198:     this_lEmLookupOrigem  = .F.   && guarda de reentrancia (regra #37/#47) dos lookups da Origem
199: 
200:     *-- Visao corrente da pagina Resultado: "MOVIMENTO" mostra o PageFrame das
201:     *-- 10 abas + OptionGroup + filtro de periodo (cmd_movimenta.Click do
202:     *-- legado); "CADASTRO" mostra a visao cadastral da conta e esconde os tres
203:     *-- (cmd_cadastro.Click do legado).
204:     this_cModoResultado   = ""
205: 
206:     *-- Parametros recebidos em Init (equivalentes as PUBLIC vars do form legado)
207:     this_oFormPai      = .NULL.   && loForm1 - form chamador
208:     this_cContaInicial = ""       && _Conta  - conta pre-selecionada ao abrir
209:     this_cCpfInicial   = ""       && _CPF    - cpf/cgc pre-selecionado ao abrir
210: 
211:     *==========================================================================
212:     * Init - Recebe os parametros do legado e delega para FormBase.Init
213:     *==========================================================================
214:     PROCEDURE Init()
215:         LPARAMETERS par_oFormPai, par_cConta, par_cCpf, par_cTitulo
216: 
217:         THIS.this_oFormPai      = IIF(TYPE("par_oFormPai") = "O", par_oFormPai, .NULL.)
218:         THIS.this_cContaInicial = IIF(TYPE("par_cConta")   = "C", par_cConta,   "")
219:         THIS.this_cCpfInicial   = IIF(TYPE("par_cCpf")     = "C", par_cCpf,     "")
220: 
221:         IF TYPE("par_cTitulo") = "C" AND !EMPTY(par_cTitulo)
222:             THIS.Caption = par_cTitulo
223:         ENDIF
224: 
225:         RETURN DODEFAULT()
226:     ENDPROC
227: 
228:     *==========================================================================
229:     * Destroy - Libera Business Object e eventuais cursores abertos
230:     *==========================================================================
231:     PROCEDURE Destroy()
232:         LOCAL loc_oErro
233:         TRY
234:             IF !ISNULL(THIS.this_oBusinessObject)
235:                 THIS.this_oBusinessObject = .NULL.
236:             ENDIF
237:         CATCH TO loc_oErro
238:             *-- nao exibir erro no Destroy
239:         ENDTRY
240:         DODEFAULT()
241:     ENDPROC
242: 
243:     *==========================================================================
244:     * InicializarForm - Chamado por FormBase.Init via DODEFAULT
245:     *==========================================================================
246:     PROTECTED PROCEDURE InicializarForm()
247:         LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
248:         loc_lSucesso   = .F.
249:         loc_lContinuar = .T.
250: 
251:         TRY
252:             IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
253:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
254:             ENDIF
255: 
256:             THIS.this_oBusinessObject = CREATEOBJECT("sigopcgvBO")
257:             IF VARTYPE(THIS.this_oBusinessObject) <> "O"
258:                 MsgErro("Falha ao criar sigopcgvBO.", "Erro")
259:                 loc_lContinuar = .F.
260:             ENDIF
261: 
262:             IF loc_lContinuar AND (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI)
263:                 IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
264:                     MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
265:                             "o Com o Servidor de Banco de Dados...", ;
266:                             "Conex" + CHR(227) + "o")
267:                     loc_lContinuar = .F.
268:                 ENDIF
269:             ENDIF
270: 
271:             IF loc_lContinuar
272:                 *-- Repassa para o Business Object os parametros recebidos no Init
273:                 THIS.this_oBusinessObject.this_cConta = THIS.this_cContaInicial
274:                 THIS.this_oBusinessObject.this_cCpf    = THIS.this_cCpfInicial
275: 
276:                 *-- Cursores locais da aba Saldo (dbSaldo/dbHistorico) tem de
277:                 *-- existir ANTES dos grids que os referenciam no ControlSource
278:                 THIS.this_oBusinessObject.CriarCursoresLocais()
279: 
280:                 THIS.ConfigurarPageFrame()
281: 
282:                 THIS.pgf_4c_Paginas.Visible = .T.
283: 
284:                 *-- Entra pelo funil de troca de pagina (regra #40): eh ele que
285:                 *-- repoe o modo e a altura do form (o Init legado abre a tela
286:                 *-- com Height = 300, so a pagina Consulta a vista)
287:                 THIS.AlternarPagina(1)
288: 
289:                 loc_lSucesso = .T.
290:             ENDIF
291: 
292:         CATCH TO loc_oErro
293:             MsgErro(loc_oErro.Message + CHR(13) + ;
294:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
295:                     "Proc: " + loc_oErro.Procedure, "Erro InicializarForm")
296:         ENDTRY
297: 
298:         RETURN loc_lSucesso
299:     ENDPROC
300: 
301:     *==========================================================================
302:     * ConfigurarPageFrame - Cria pgf_4c_Paginas (fld_principal do legado)
303:     *   Page1 = Consulta  (criterios de pesquisa)
304:     *   Page2 = Resultado (abas Saldo/Cheque/Vendas/Estoque/Pendencias/
305:     *                      Conserto/Cartao/Producao/H.Cheques/Credito)
306:     *==========================================================================
307:     PROTECTED PROCEDURE ConfigurarPageFrame()
308:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
309:         WITH THIS.pgf_4c_Paginas
310:             .Top       = -33
311:             .Left      = -1
312:             .Width     = 1003
313:             .Height    = 635
314:             .PageCount = 2
315:             .TabStop   = .F.
316:             .Themes    = .F.
317:             .Visible   = .F.
318: 
319:             .Page1.Caption = "Consulta"
320:             .Page2.Caption = "Resultado"
321: 
322:             IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
323:                 .Page1.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
324:                 .Page2.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
325:             ENDIF
326:         ENDWITH
327: 
328:         THIS.ConfigurarPaginaConsulta()
329:         THIS.ConfigurarPaginaResultado()
330:     ENDPROC
331: 
332:     *==========================================================================
333:     * ConfigurarPaginaConsulta - Page1: cabecalho (equivalente ao cntSombra
334:     * do legado), criterios de pesquisa (container Origem - ConfigurarOrigem)
335:     * e o CommandGroup de navegacao (grp_operacao - ConfigurarGrupoOperacao).
336:     *==========================================================================
337:     PROTECTED PROCEDURE ConfigurarPaginaConsulta()
338:         LOCAL loc_oPg
339:         loc_oPg = THIS.pgf_4c_Paginas.Page1
340: 
341:         loc_oPg.AddObject("cnt_4c_Cabecalho", "Container")
342:         WITH loc_oPg.cnt_4c_Cabecalho
343:             .Top         = 5
344:             .Left        = -1
345:             *-- Page nao expoe Width/Height em runtime (regra #9.2): a largura
346:             *-- da faixa vem do FORM, nao da Page
347:             .Width       = THIS.Width + 2
348:             .Height      = 80
349:             .BackStyle   = 1
350:             .BackColor   = RGB(100, 100, 100)
351:             .BorderWidth = 0
352:             .Visible     = .T.
353: 
354:             .AddObject("lbl_4c_Sombra", "Label")
355:             WITH .lbl_4c_Sombra
356:                 .Top       = 17
357:                 .Left      = 10
358:                 .Width     = THIS.Width
359:                 .Height    = 46
360:                 .AutoSize  = .F.
361:                 .WordWrap  = .T.
362:                 .FontBold  = .T.
363:                 .FontName  = "Tahoma"
364:                 .FontSize  = 18
365:                 .BackStyle = 0
366:                 .ForeColor = RGB(0, 0, 0)
367:                 .Caption   = THIS.Caption
368:                 .Visible   = .T.
369:             ENDWITH
370: 
371:             .AddObject("lbl_4c_Titulo", "Label")
372:             WITH .lbl_4c_Titulo
373:                 .Top       = 18
374:                 .Left      = 10
375:                 .Width     = THIS.Width
376:                 .Height    = 46
377:                 .AutoSize  = .F.

*-- Linhas 395 a 438:
395:     * Conta (codigo exato), Nome, CPF/CGC, Conjuge, Telefone + filtro
396:     * Iniciais/Qualquer Parte. Espelha SIGOPCGV.fld_principal.pag_consulta.Origem
397:     *==========================================================================
398:     PROTECTED PROCEDURE ConfigurarOrigem()
399:         LOCAL loc_oPg
400:         loc_oPg = THIS.pgf_4c_Paginas.Page1
401: 
402:         loc_oPg.AddObject("cnt_4c_Origem", "Container")
403:         WITH loc_oPg.cnt_4c_Origem
404:             .Top           = 89
405:             .Left          = 12
406:             .Width         = 702
407:             .Height        = 235
408:             .BackStyle     = 0
409:             .BorderWidth   = 0
410:             .SpecialEffect = 0
411:             .BackColor     = RGB(255, 255, 255)
412:             .Visible       = .T.
413:         ENDWITH
414: 
415:         WITH loc_oPg.cnt_4c_Origem
416:             *-- Labels (classe say do legado - Alignment/Width so quando o dump declara)
417:             .AddObject("lbl_4c_Conta", "Label")
418:             WITH .lbl_4c_Conta
419:                 .Top       = 5
420:                 .Left      = 5
421:                 .Width     = 115
422:                 .Height    = 15
423:                 .Alignment = 1
424:                 .FontBold  = .T.
425:                 .FontSize  = 8
426:                 .BackStyle = 0
427:                 .ForeColor = RGB(90, 90, 90)
428:                 .Caption   = "Conta para Pesquisa"
429:                 .Visible   = .T.
430:             ENDWITH
431: 
432:             .AddObject("lbl_4c_LabelConta", "Label")
433:             WITH .lbl_4c_LabelConta
434:                 .Top       = 30
435:                 .Left      = 49
436:                 .Width     = 60
437:                 .Height    = 15
438:                 .Alignment = 0

*-- Linhas 533 a 576:
533:             ENDWITH
534: 
535:             *-- Filtro de pesquisa por Nome: Iniciais (prefixo) / Qualquer Parte (contem)
536:             .AddObject("obj_4c_OptFiltro", "OptionGroup")
537:             WITH .obj_4c_OptFiltro
538:                 .Top         = 63
539:                 .Left        = 82
540:                 .Width       = 175
541:                 .Height      = 19
542:                 .ButtonCount = 2
543:                 .BackStyle   = 0
544:                 .BorderStyle = 0
545:                 .Value       = 1
546:                 WITH .Buttons(1)
547:                     .Caption   = "\<Iniciais"
548:                     .Top       = 5
549:                     .Left      = 5
550:                     .Width     = 50
551:                     .Height    = 15
552:                     .Style     = 0
553:                     .BackStyle = 0
554:                     .FontSize  = 8
555:                 ENDWITH
556:                 WITH .Buttons(2)
557:                     .Caption   = "\<Qualquer Parte"
558:                     .Top       = 5
559:                     .Left      = 62
560:                     .Width     = 91
561:                     .Height    = 15
562:                     .Style     = 0
563:                     .BackStyle = 0
564:                     .FontSize  = 8
565:                 ENDWITH
566:                 .Visible = .T.
567:             ENDWITH
568: 
569:             *-- Campo Nome: pesquisa por LIKE (Get_dconta)
570:             .AddObject("txt_4c_DConta", "TextBox")
571:             WITH .txt_4c_DConta
572:                 .Top               = 84
573:                 .Left              = 49
574:                 .Width             = 278
575:                 .Height            = 21
576:                 .Value             = ""

*-- Linhas 615 a 675:
615:             ENDWITH
616:         ENDWITH
617: 
618:         *-- Desabilita o filtro Iniciais/Qualquer Parte quando o form foi aberto
619:         *-- apenas para pesquisa por CPF (this_lSomenteCPF - equivalente a plCPF)
620:         loc_oPg.cnt_4c_Origem.obj_4c_OptFiltro.Enabled = !THIS.this_oBusinessObject.this_lSomenteCPF
621: 
622:         *-- Lookup ao SAIR do campo (LostFocus), nunca KeyPress (regra #47)
623:         BINDEVENT(loc_oPg.cnt_4c_Origem.txt_4c_Conta,    "LostFocus", THIS, "TxtContaLostFocus")
624:         BINDEVENT(loc_oPg.cnt_4c_Origem.txt_4c_DConta,   "LostFocus", THIS, "TxtDContaLostFocus")
625:         BINDEVENT(loc_oPg.cnt_4c_Origem.txt_4c_Cpf,      "LostFocus", THIS, "TxtCpfLostFocus")
626:         BINDEVENT(loc_oPg.cnt_4c_Origem.txt_4c_Conjuge,  "LostFocus", THIS, "TxtConjugeLostFocus")
627:         BINDEVENT(loc_oPg.cnt_4c_Origem.txt_4c_Telefone, "LostFocus", THIS, "TxtTelefoneLostFocus")
628:     ENDPROC
629: 
630:     *==========================================================================
631:     * ConfigurarGrupoOperacao - CommandGroup com os 3 botoes de navegacao da
632:     * pagina Consulta (grp_operacao do legado): Cadastro, Movimento e
633:     * [ESC] Sair.
634:     *==========================================================================
635:     PROTECTED PROCEDURE ConfigurarGrupoOperacao()
636:         LOCAL loc_oPg
637:         loc_oPg = THIS.pgf_4c_Paginas.Page1
638: 
639:         loc_oPg.AddObject("cmg_4c_GrpOperacao", "CommandGroup")
640:         WITH loc_oPg.cmg_4c_GrpOperacao
641:             .Top         = 3
642:             .Left        = 769
643:             .Width       = 235
644:             .Height      = 85
645:             .ButtonCount = 3
646:             .BackStyle   = 0
647:             .BorderStyle = 0
648:             .SpecialEffect = 1
649:             .BorderColor = RGB(136, 189, 188)
650:             .Themes      = .F.
651: 
652:             WITH .Buttons(1)
653:                 .Top        = 5
654:                 .Left       = 5
655:                 .Width      = 75
656:                 .Height     = 75
657:                 .FontBold   = .T.
658:                 .FontItalic = .T.
659:                 .FontName   = "Comic Sans MS"
660:                 .FontSize   = 8
661:                 .Caption    = "\<Cadastro"
662:                 .ToolTipText = "Dados Cadastrais"
663:                 .ForeColor  = RGB(90, 90, 90)
664:                 .BackColor  = RGB(255, 255, 255)
665:                 .Themes     = .F.
666:                 IF FILE(gc_4c_CaminhoIcones + "geral_contatos_60.jpg")
667:                     .Picture = gc_4c_CaminhoIcones + "geral_contatos_60.jpg"
668:                 ENDIF
669:             ENDWITH
670: 
671:             WITH .Buttons(2)
672:                 .Top        = 5
673:                 .Left       = 80
674:                 .Width      = 75
675:                 .Height     = 75

*-- Linhas 709 a 1236:
709:             .Visible = .T.
710:         ENDWITH
711: 
712:         BINDEVENT(loc_oPg.cmg_4c_GrpOperacao.Buttons(1), "Click", THIS, "BtnCadastroClick")
713:         BINDEVENT(loc_oPg.cmg_4c_GrpOperacao.Buttons(2), "Click", THIS, "BtnMovimentoClick")
714:         BINDEVENT(loc_oPg.cmg_4c_GrpOperacao.Buttons(3), "Click", THIS, "BtnCancelarClick")
715:     ENDPROC
716: 
717:     *==========================================================================
718:     * TxtContaLostFocus - Pesquisa por codigo exato da conta (Get_conta.Valid)
719:     *==========================================================================
720:     PROCEDURE TxtContaLostFocus()
721:         LOCAL loc_oPg, loc_cValor, loc_oErro
722: 
723:         IF THIS.this_lEmLookupOrigem
724:             RETURN
725:         ENDIF
726:         THIS.this_lEmLookupOrigem = .T.
727: 
728:         TRY
729:             loc_oPg   = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
730:             loc_cValor = ALLTRIM(loc_oPg.txt_4c_Conta.Value)
731: 
732:             IF !EMPTY(loc_cValor)
733:                 IF THIS.this_oBusinessObject.BuscarPorConta(loc_cValor)
734:                     THIS.AtualizarCamposOrigem()
735:                 ELSE
736:                     MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, "Pesquisa de Conta")
737:                 ENDIF
738:             ENDIF
739:         CATCH TO loc_oErro
740:             MsgErro(loc_oErro.Message, "Erro ao pesquisar conta")
741:         ENDTRY
742: 
743:         THIS.this_lEmLookupOrigem = .F.
744:     ENDPROC
745: 
746:     *==========================================================================
747:     * TxtDContaLostFocus - Pesquisa por nome (Get_dconta.Valid). Com optFiltro
748:     * = 1 (Iniciais) usa prefixo "valor%"; com optFiltro = 2 (Qualquer Parte)
749:     * usa "%valor%". 1 resultado -> carrega direto; 2+ -> abre picker.
750:     *==========================================================================
751:     PROCEDURE TxtDContaLostFocus()
752:         LOCAL loc_oPg, loc_cValor, loc_cModo, loc_oErro
753: 
754:         IF THIS.this_lEmLookupOrigem
755:             RETURN
756:         ENDIF
757:         THIS.this_lEmLookupOrigem = .T.
758: 
759:         TRY
760:             loc_oPg    = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
761:             loc_cValor = ALLTRIM(loc_oPg.txt_4c_DConta.Value)
762: 
763:             IF !EMPTY(loc_cValor)
764:                 loc_cModo = IIF(loc_oPg.obj_4c_OptFiltro.Value = 1, "INICIAIS", "QUALQUER")
765: 
766:                 IF THIS.this_oBusinessObject.BuscarPorNome(loc_cValor, "cursor_4c_BuscaNome", loc_cModo)
767:                     THIS.SelecionarDaListaOrigem("cursor_4c_BuscaNome", "Nome do Cliente")
768:                 ELSE
769:                     MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, "Pesquisa por Nome")
770:                 ENDIF
771:             ENDIF
772:         CATCH TO loc_oErro
773:             MsgErro(loc_oErro.Message, "Erro ao pesquisar por nome")
774:         ENDTRY
775: 
776:         THIS.this_lEmLookupOrigem = .F.
777:     ENDPROC
778: 
779:     *==========================================================================
780:     * TxtCpfLostFocus - Pesquisa por CPF/CGC validado (Get_cpf.Valid)
781:     *==========================================================================
782:     PROCEDURE TxtCpfLostFocus()
783:         LOCAL loc_oPg, loc_cValor, loc_oErro
784: 
785:         IF THIS.this_lEmLookupOrigem
786:             RETURN
787:         ENDIF
788:         THIS.this_lEmLookupOrigem = .T.
789: 
790:         TRY
791:             loc_oPg   = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
792:             loc_cValor = ALLTRIM(loc_oPg.txt_4c_Cpf.Value)
793: 
794:             IF !EMPTY(loc_cValor)
795:                 IF THIS.this_oBusinessObject.BuscarPorCpf(loc_cValor, "cursor_4c_BuscaCpf")
796:                     THIS.SelecionarDaListaOrigem("cursor_4c_BuscaCpf", "Cliente")
797:                 ELSE
798:                     MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, "Pesquisa por CPF / CGC")
799:                 ENDIF
800:             ENDIF
801:         CATCH TO loc_oErro
802:             MsgErro(loc_oErro.Message, "Erro ao pesquisar por CPF/CGC")
803:         ENDTRY
804: 
805:         THIS.this_lEmLookupOrigem = .F.
806:     ENDPROC
807: 
808:     *==========================================================================
809:     * TxtConjugeLostFocus - Pesquisa pelo nome do conjuge (GetConj.Valid)
810:     *==========================================================================
811:     PROCEDURE TxtConjugeLostFocus()
812:         LOCAL loc_oPg, loc_cValor, loc_oErro
813: 
814:         IF THIS.this_lEmLookupOrigem
815:             RETURN
816:         ENDIF
817:         THIS.this_lEmLookupOrigem = .T.
818: 
819:         TRY
820:             loc_oPg   = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
821:             loc_cValor = ALLTRIM(loc_oPg.txt_4c_Conjuge.Value)
822: 
823:             IF !EMPTY(loc_cValor)
824:                 IF THIS.this_oBusinessObject.BuscarPorConjuge(loc_cValor, "cursor_4c_BuscaConjuge")
825:                     THIS.SelecionarDaListaOrigem("cursor_4c_BuscaConjuge", "Nome do C" + CHR(244) + "njuge")
826:                 ELSE
827:                     MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, "Pesquisa por C" + CHR(244) + "njuge")
828:                 ENDIF
829:             ENDIF
830:         CATCH TO loc_oErro
831:             MsgErro(loc_oErro.Message, "Erro ao pesquisar por c" + CHR(244) + "njuge")
832:         ENDTRY
833: 
834:         THIS.this_lEmLookupOrigem = .F.
835:     ENDPROC
836: 
837:     *==========================================================================
838:     * TxtTelefoneLostFocus - Pesquisa pelo telefone (getTelefone.Valid)
839:     *==========================================================================
840:     PROCEDURE TxtTelefoneLostFocus()
841:         LOCAL loc_oPg, loc_cValor, loc_oErro
842: 
843:         IF THIS.this_lEmLookupOrigem
844:             RETURN
845:         ENDIF
846:         THIS.this_lEmLookupOrigem = .T.
847: 
848:         TRY
849:             loc_oPg   = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
850:             loc_cValor = ALLTRIM(loc_oPg.txt_4c_Telefone.Value)
851: 
852:             IF !EMPTY(loc_cValor)
853:                 IF THIS.this_oBusinessObject.BuscarPorTelefone(loc_cValor, "cursor_4c_BuscaTelefone")
854:                     THIS.SelecionarDaListaOrigem("cursor_4c_BuscaTelefone", "Telefone")
855:                 ELSE
856:                     MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, "Pesquisa por Telefone")
857:                 ENDIF
858:             ENDIF
859:         CATCH TO loc_oErro
860:             MsgErro(loc_oErro.Message, "Erro ao pesquisar por telefone")
861:         ENDTRY
862: 
863:         THIS.this_lEmLookupOrigem = .F.
864:     ENDPROC
865: 
866:     *==========================================================================
867:     * SelecionarDaListaOrigem - Resolve um cursor com 1+ candidatos (Nome/CPF/
868:     * Conjuge/Telefone): com 1 resultado carrega direto; com mais de 1, abre o
869:     * picker (FormBuscaAuxiliar.DefinirCursor/Mostrar - Pattern A) para o
870:     * usuario escolher, e entao recarrega a conta completa por codigo exato.
871:     *==========================================================================
872:     PROTECTED PROCEDURE SelecionarDaListaOrigem(par_cCursor, par_cTitulo)
873:         LOCAL loc_oBusca, loc_cConta, loc_oErro, loc_lTemCursor
874: 
875:         *-- Sem RETURN dentro do TRY (regra #1): o guard vira flag
876:         TRY
877:             loc_lTemCursor = USED(par_cCursor)
878: 
879:             IF loc_lTemCursor
880:                 IF RECCOUNT(par_cCursor) = 1
881:                     SELECT (par_cCursor)
882:                     GO TOP
883:                     loc_cConta = ALLTRIM(Iclis)
884:                     IF THIS.this_oBusinessObject.BuscarPorConta(loc_cConta)
885:                         THIS.AtualizarCamposOrigem()
886:                     ENDIF
887:                 ELSE
888:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
889:                     IF VARTYPE(loc_oBusca) = "O"
890:                         loc_oBusca.DefinirCursor(par_cCursor, "Iclis", "Rclis", par_cTitulo)
891:                         IF loc_oBusca.Mostrar()
892:                             loc_cConta = loc_oBusca.cCodigoSelecionado
893:                             IF !EMPTY(loc_cConta) AND THIS.this_oBusinessObject.BuscarPorConta(loc_cConta)
894:                                 THIS.AtualizarCamposOrigem()
895:                             ENDIF
896:                         ENDIF
897:                         loc_oBusca.Release()
898:                     ENDIF
899:                 ENDIF
900: 
901:                 IF USED(par_cCursor)
902:                     USE IN (par_cCursor)
903:                 ENDIF
904:             ENDIF
905:         CATCH TO loc_oErro
906:             MsgErro(loc_oErro.Message, "Erro ao selecionar registro")
907:         ENDTRY
908:     ENDPROC
909: 
910:     *==========================================================================
911:     * AtualizarCamposOrigem - Reflete no formulario os dados do cliente ja
912:     * localizados no Business Object (equivalente ao preenchimento cruzado
913:     * dos campos Conta/Nome/CPF/Conjuge/Telefone do legado apos qualquer
914:     * pesquisa bem-sucedida).
915:     *==========================================================================
916:     PROTECTED PROCEDURE AtualizarCamposOrigem()
917:         *-- Funil unico do caminho BO -> tela (ver BOParaForm): alem dos cinco
918:         *-- campos, ele devolve a opcao de filtro e o periodo e reaplica a
919:         *-- cascata de When dos criterios
920:         THIS.BOParaForm()
921:     ENDPROC
922: 
923:     *==========================================================================
924:     * ValidarContaSelecionada - Guard comum aos dois botoes de entrada na
925:     * pagina Resultado. No legado o Do Case que abre cmd_cadastro.Click e
926:     * cmd_movimenta.Click eh identico nos dois: conta vazia ou inexistente em
927:     * SigCdCli recusa a acao com "Conta de Estoque Invalida !!!" e devolve o
928:     * foco ao campo Conta. Fica num metodo unico porque o legado o tem UMA vez
929:     * (no Click do CommandGroup) e vale para todas as opcoes.
930:     *==========================================================================
931:     FUNCTION ValidarContaSelecionada()
932:         LOCAL loc_oCnt, loc_cConta, loc_lOk
933:         loc_lOk  = .F.
934:         loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
935: 
936:         *-- Fonte UNICA eh o campo da tela, nunca a property guardada antes
937:         loc_cConta = ALLTRIM(loc_oCnt.txt_4c_Conta.Value)
938: 
939:         IF EMPTY(loc_cConta)
940:             MsgAviso("Conta de Estoque Inv" + CHR(225) + "lida !!!", "Aten" + CHR(231) + CHR(227) + "o")
941:             loc_oCnt.txt_4c_Conta.SetFocus()
942:         ELSE
943:             *-- "Ja resolvida" exige a DESCRICAO carregada, nao apenas o codigo
944:             *-- igual: o FormParaBO copia o codigo da tela para o BO, e sem esta
945:             *-- segunda condicao um codigo inexistente digitado depois de uma
946:             *-- consulta valida passaria sem conferencia no banco
947:             IF ALLTRIM(THIS.this_oBusinessObject.this_cConta) == loc_cConta AND ;
948:                     !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cDescConta))
949:                 *-- Conta ja resolvida por uma das pesquisas da Origem
950:                 loc_lOk = .T.
951:             ELSE
952:                 IF THIS.this_oBusinessObject.BuscarPorConta(loc_cConta)
953:                     THIS.AtualizarCamposOrigem()
954:                     loc_lOk = .T.
955:                 ELSE
956:                     MsgAviso("Conta de Estoque Inv" + CHR(225) + "lida !!!", "Aten" + CHR(231) + CHR(227) + "o")
957:                     loc_oCnt.txt_4c_Conta.SetFocus()
958:                 ENDIF
959:             ENDIF
960:         ENDIF
961: 
962:         RETURN loc_lOk
963:     ENDFUNC
964: 
965:     *==========================================================================
966:     * BtnCadastroClick - cmd_cadastro.Click do grp_operacao da pagina Consulta:
967:     * valida a conta, carrega os dados e abre a pagina Resultado na visao
968:     * CADASTRO (sem o PageFrame das abas, sem OptionGroup e sem periodo).
969:     *==========================================================================
970:     PROCEDURE BtnCadastroClick()
971:         IF !THIS.ValidarContaSelecionada()
972:             RETURN
973:         ENDIF
974: 
975:         THIS.this_oBusinessObject.this_cEscolha = "ALTERAR"
976:         THIS.CarregarDados()
977:         THIS.AjustarVisibilidadeResultado("CADASTRO")
978:         THIS.AlternarPagina(2)
979:     ENDPROC
980: 
981:     *==========================================================================
982:     * BtnMovimentoClick - cmd_movimenta.Click do grp_operacao da pagina
983:     * Consulta: valida a conta, carrega os dados e abre a pagina Resultado na
984:     * visao MOVIMENTO (PageFrame das 10 abas + OptionGroup + periodo).
985:     *==========================================================================
986:     PROCEDURE BtnMovimentoClick()
987:         IF !THIS.ValidarContaSelecionada()
988:             RETURN
989:         ENDIF
990: 
991:         THIS.this_oBusinessObject.this_cEscolha = "CONSULTAR"
992:         THIS.CarregarDados()
993:         THIS.AjustarVisibilidadeResultado("MOVIMENTO")
994:         THIS.AlternarPagina(2)
995:     ENDPROC
996: 
997:     *==========================================================================
998:     * BtnCancelarConsultaClick - [ESC] Sair (ThisForm.Release do legado)
999:     *==========================================================================
1000:     PROCEDURE BtnCancelarConsultaClick()
1001:         *-- Mantido como alias do nome canonico: o Buttons(3) do grp_operacao
1002:         *-- esta ligado a BtnCancelarClick, que eh quem tem o comportamento
1003:         *-- (encerrar na Consulta, abandonar a consulta na pagina Resultado)
1004:         THIS.BtnCancelarClick()
1005:     ENDPROC
1006: 
1007:     *==========================================================================
1008:     * EVENTOS PRINCIPAIS DOS BOTOES (FASE 7/8)
1009:     *
1010:     * O legado SIGOPCGV herda de `form` (nao de `frmcadastro`), por isso NAO
1011:     * tem a barra CRUD de cinco botoes: o grp_operacao da pagina Consulta tem
1012:     * tres (cmd_cadastro / cmd_movimenta / cmd_cancela) e o da pagina
1013:     * Resultado tem um (cmd_voltar), mais Cmd_MudaCli / Cmd_MudaMov / Imprime.
1014:     * A unica variavel de modo que ele usa eh pcEscolha, e ela so recebe dois
1015:     * valores:
1016:     *
1017:     *   'ALTERAR'   - Cmd_MudaCli.Click e cmd_cadastro.Click quando
1018:     *                 fChecaAcesso('SIGOPCGV','ALTERAR') devolve .T.; eh o
1019:     *                 que libera a gravacao do cadastro no cmd_voltar.Click
1020:     *                 ("Deseja salvar as alteracoes?" -> mValidaObj +
1021:     *                 mGravaDados do cntConta).
1022:     *   'CONSULTAR' - cmd_movimenta.Click, Cmd_MudaMov.Click e o MESMO
1023:     *                 cmd_cadastro.Click quando o usuario nao tem o acesso.
1024:     *
1025:     * Dai o mapeamento abaixo: Alterar e Visualizar sao as duas pontas reais
1026:     * desse IIF do legado - mesma entrada, mesma validacao de conta, mesma
1027:     * visao cadastral; o que muda eh o modo, que decide se a tela grava.
1028:     * Incluir e Excluir de conta NAO existem nesta tela: criar botao para eles
1029:     * seria inventar funcionalidade que o legado nao tem (PILAR 1), entao os
1030:     * dois handlers reproduzem a ausencia - dizem onde a operacao mora de
1031:     * verdade (SIGCDCLI -> FormCliente) e devolvem o foco ao campo Conta.
1032:     *==========================================================================
1033: 
1034:     *==========================================================================
1035:     * PodeAlterarCadastro - fChecaAcesso('SIGOPCGV','ALTERAR') do legado.
1036:     * PUBLIC: consultado pelos handlers e pelo harness de teste (regra #3).
1037:     *==========================================================================
1038:     FUNCTION PodeAlterarCadastro()
1039:         LOCAL loc_lAcesso, loc_oErro
1040:         loc_lAcesso = .T.
1041: 
1042:         TRY
1043:             loc_lAcesso = fChecaAcesso("SIGOPCGV", "ALTERAR")
1044:         CATCH TO loc_oErro
1045:             *-- Regra #9: CATCH nunca silencioso. Sem a tabela de acesso
1046:             *-- disponivel o legado tratava o usuario como SEM permissao,
1047:             *-- isto eh, cai para 'CONSULTAR' (somente leitura).
1048:             MsgAviso(loc_oErro.Message, ;
1049:                 "Verifica" + CHR(231) + CHR(227) + "o de acesso")
1050:             loc_lAcesso = .F.
1051:         ENDTRY
1052: 
1053:         RETURN loc_lAcesso
1054:     ENDFUNC
1055: 
1056:     *==========================================================================
1057:     * AbrirVisaoCadastral - funil UNICO do cmd_cadastro.Click legado, usado
1058:     * pelos dois botoes que entram na visao cadastral (Alterar e Visualizar):
1059:     * valida a conta ("Conta de Estoque Invalida !!!" do Do Case legado),
1060:     * guarda o modo no BO, carrega a consulta e abre a pagina Resultado na
1061:     * visao CADASTRO - exatamente a sequencia do legado.
1062:     * PUBLIC: chamado pelos handlers e pelo harness de teste (regra #3).
1063:     *==========================================================================
1064:     FUNCTION AbrirVisaoCadastral(par_cEscolha)
1065:         LOCAL loc_lOk, loc_cEscolha
1066:         loc_lOk      = .F.
1067:         loc_cEscolha = IIF(VARTYPE(par_cEscolha) = "C" AND !EMPTY(par_cEscolha), ;
1068:             UPPER(ALLTRIM(par_cEscolha)), "CONSULTAR")
1069: 
1070:         IF THIS.ValidarContaSelecionada()
1071:             THIS.this_oBusinessObject.this_cEscolha = loc_cEscolha
1072:             THIS.CarregarDados()
1073:             THIS.AjustarVisibilidadeResultado("CADASTRO")
1074:             THIS.AlternarPagina(2)
1075:             loc_lOk = .T.
1076:         ENDIF
1077: 
1078:         RETURN loc_lOk
1079:     ENDFUNC
1080: 
1081:     *==========================================================================
1082:     * FocarCampoConta - devolve o foco ao campo Conta da pagina Consulta
1083:     * (This.Parent.Parent.Origem.Get_Conta.SetFocus do legado), so quando essa
1084:     * pagina esta a vista. SetFocus falha com a pagina ainda nao pintada ou em
1085:     * execucao sem interface, por isso vai guardado.
1086:     * PUBLIC: chamado pelos handlers e pelo harness de teste (regra #3).
1087:     *==========================================================================
1088:     PROCEDURE FocarCampoConta()
1089:         LOCAL loc_oErro
1090: 
1091:         TRY
1092:             IF THIS.pgf_4c_Paginas.ActivePage = 1
1093:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.txt_4c_Conta.SetFocus()
1094:             ENDIF
1095:         CATCH TO loc_oErro
1096:             *-- pagina nao pintada / execucao sem interface: nao eh erro de
1097:             *-- negocio (mesmo tratamento do SetFocus em AlternarPagina)
1098:         ENDTRY
1099:     ENDPROC
1100: 
1101:     *==========================================================================
1102:     * BtnAlterarClick - ponta 'ALTERAR' do cmd_cadastro.Click legado:
1103:     *   ThisForm.pcEscolha = IIF(fChecaAcesso('SIGOPCGV','ALTERAR'),
1104:     *                            'ALTERAR', 'CONSULTAR')
1105:     * O legado NAO avisa quando falta o acesso - simplesmente abre a conta
1106:     * somente para leitura -, entao aqui tambem nao se avisa.
1107:     *==========================================================================
1108:     PROCEDURE BtnAlterarClick()
1109:         LOCAL loc_cEscolha
1110:         loc_cEscolha = IIF(THIS.PodeAlterarCadastro(), "ALTERAR", "CONSULTAR")
1111:         THIS.AbrirVisaoCadastral(loc_cEscolha)
1112:     ENDPROC
1113: 
1114:     *==========================================================================
1115:     * BtnVisualizarClick - ponta 'CONSULTAR' do mesmo cmd_cadastro.Click:
1116:     * abre a conta na visao cadastral em modo somente leitura, que eh o que o
1117:     * legado faz com quem nao tem o acesso de alteracao. Sem 'ALTERAR' no BO,
1118:     * o cmd_voltar.Click nao oferece gravacao.
1119:     *==========================================================================
1120:     PROCEDURE BtnVisualizarClick()
1121:         THIS.AbrirVisaoCadastral("CONSULTAR")
1122:     ENDPROC
1123: 
1124:     *==========================================================================
1125:     * BtnIncluirClick - o legado NAO inclui conta nesta tela (ver a nota do
1126:     * bloco acima: pcEscolha so assume 'CONSULTAR'/'ALTERAR' e o grp_operacao
1127:     * nao tem botao de inclusao). Reproduz a ausencia em vez de inventar a
1128:     * operacao, informando onde ela mora de verdade.
1129:     *==========================================================================
1130:     PROCEDURE BtnIncluirClick()
1131:         MsgAviso("Pesquisa Global de Vendas " + CHR(233) + " uma tela de " + ;
1132:             "consulta: a inclus" + CHR(227) + "o de contas " + CHR(233) + ;
1133:             " feita no Cadastro de Clientes.", THIS.Caption)
1134:         THIS.FocarCampoConta()
1135:     ENDPROC
1136: 
1137:     *==========================================================================
1138:     * BtnExcluirClick - irmao do BtnIncluirClick: o legado tambem nao exclui
1139:     * conta nesta tela. Reproduz a ausencia e aponta o Cadastro de Clientes.
1140:     *==========================================================================
1141:     PROCEDURE BtnExcluirClick()
1142:         MsgAviso("Pesquisa Global de Vendas " + CHR(233) + " uma tela de " + ;
1143:             "consulta: a exclus" + CHR(227) + "o de contas " + CHR(233) + ;
1144:             " feita no Cadastro de Clientes.", THIS.Caption)
1145:         THIS.FocarCampoConta()
1146:     ENDPROC
1147: 
1148:     *==========================================================================
1149:     * ConfigurarPaginaResultado - Page2 (pag_resultado do legado).
1150:     *
1151:     * ORDEM DE CRIACAO: o PageFrame das abas vem PRIMEIRO e as barras de
1152:     * navegacao/acao DEPOIS, porque elas ficam por cima dele - o cnt_periodo
1153:     * do legado esta em Top = 120..156 e o PageFrame em Top = 127, isto eh,
1154:     * sobrepostos. Criar na ordem inversa faria o PageFrame cobrir o filtro
1155:     * de periodo (mesmo raciocinio da regra #11).
1156:     *==========================================================================
1157:     PROTECTED PROCEDURE ConfigurarPaginaResultado()
1158:         LOCAL loc_oPg
1159:         loc_oPg = THIS.pgf_4c_Paginas.Page2
1160:         *-- Page NAO tem a propriedade Visible (quem controla a exibicao eh o
1161:         *-- PageFrame, via ActivePage)
1162: 
1163:         THIS.ConfigurarPageFrameResultado()
1164:         THIS.ConfigurarPaginaDados()
1165:         THIS.ConfigurarNavegacaoResultado()
1166:         THIS.ConfigurarPeriodoResultado()
1167:         THIS.ConfigurarBotoesResultado()
1168:         THIS.ConfigurarPaineisImpressao()
1169:     ENDPROC
1170: 
1171:     *==========================================================================
1172:     * ConfigurarPageFrameResultado - PageFrame interno "Result" (fld_principal.
1173:     * pag_resultado.Result do legado): 10 abas, uma por assunto. Tabs = .F.
1174:     * porque a navegacao eh feita pelo OptionGroup obj_4c_OptResultado, nao
1175:     * por clique na aba.
1176:     *
1177:     * ORDEM DAS PAGINAS (regra #31): o legado navega com
1178:     * "result.ActivePage = this.Value" (Optiongroup1.InteractiveChange), e
1179:     * ActivePage eh o PageOrder, NAO a ordem de declaracao. No SCX legado as
1180:     * paginas estao declaradas fora de ordem (Result.Page2 "Cheques" tem
1181:     * PageOrder = 3, Page5 "Pendencias" tem PageOrder = 2, Page7 "Cartao" tem
1182:     * PageOrder = 4, Page3 "Vendas" tem PageOrder = 5...). Aqui as 10 abas sao
1183:     * declaradas JA na ordem de PageOrder do legado, de modo que
1184:     * "ActivePage = Value" caia exatamente na mesma aba que o legado abre para
1185:     * cada opcao do OptionGroup:
1186:     *
1187:     *   1 Saldo Conta Corrente   2 Pendencias Financeiras   3 Cheques
1188:     *   4 Cartao                 5 Vendas                   6 Estoque
1189:     *   7 Movimen. Pend.         8 Producao                  9 Hist. Cheques
1190:     *  10 Credito
1191:     *
1192:     * Declarar em ordem de PageOrder (em vez de atribuir .PageOrder em runtime,
1193:     * que no VFP9 reordena as demais paginas em cascata) deixa o default do
1194:     * PageFrame igual ao PageOrder do legado.
1195:     *==========================================================================
1196:     PROTECTED PROCEDURE ConfigurarPageFrameResultado()
1197:         LOCAL loc_oPg
1198:         loc_oPg = THIS.pgf_4c_Paginas.Page2
1199: 
1200:         loc_oPg.AddObject("pgf_4c_Resultado", "PageFrame")
1201:         WITH loc_oPg.pgf_4c_Resultado
1202:             .Top           = 127
1203:             .Left          = -1
1204:             .Width         = 1003
1205:             .Height        = 476
1206:             .PageCount     = 10
1207:             *-- SpecialEffect de PageFrame eh READ-ONLY em runtime: o legado
1208:             *-- declara 2 no SCX, mas o VFP9 nao aceita a atribuicao aqui
1209:             .Tabs          = .F.
1210:             .Themes        = .F.
1211:             .Visible       = .T.
1212: 
1213:             .Page1.FontName  = "Verdana"
1214:             .Page1.FontSize  = 8
1215:             .Page1.Caption   = "Saldo"
1216:             .Page1.BackColor = RGB(255, 255, 255)
1217:             .Page1.ForeColor = RGB(36, 84, 155)
1218: 
1219:             .Page2.FontName  = "Tahoma"
1220:             .Page2.FontSize  = 8
1221:             .Page2.Caption   = "Pend" + CHR(234) + "ncias"
1222:             .Page2.BackColor = RGB(255, 255, 255)
1223:             .Page2.ForeColor = RGB(90, 90, 90)
1224: 
1225:             .Page3.FontName  = "Tahoma"
1226:             .Page3.FontSize  = 8
1227:             .Page3.Caption   = "Cheques"
1228:             .Page3.BackColor = RGB(255, 255, 255)
1229:             .Page3.ForeColor = RGB(90, 90, 90)
1230: 
1231:             .Page4.FontName  = "Tahoma"
1232:             .Page4.FontSize  = 8
1233:             .Page4.Caption   = "Cart" + CHR(227) + "o"
1234:             .Page4.BackColor = RGB(255, 255, 255)
1235:             .Page4.ForeColor = RGB(90, 90, 90)
1236: 

*-- Linhas 1297 a 1340:
1297:     * ainda depende da porcao truncada do Processa() legado (ver comentario
1298:     * de CriarCursoresLocais no BO) - fica para fase seguinte.
1299:     *==========================================================================
1300:     PROTECTED PROCEDURE ConfigurarAbaSaldo()
1301:         LOCAL loc_oPg
1302:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page1
1303: 
1304:         loc_oPg.AddObject("lbl_4c_Historico", "Label")
1305:         WITH loc_oPg.lbl_4c_Historico
1306:             .Top       = 90
1307:             .Left      = 11
1308:             .Width     = 160
1309:             .Height    = 15
1310:             .Alignment = 0
1311:             .FontSize  = 8
1312:             .BackStyle = 0
1313:             .ForeColor = RGB(90, 90, 90)
1314:             .Caption   = "Hist" + CHR(243) + "rico Conta Corrente"
1315:             .Visible   = .T.
1316:         ENDWITH
1317: 
1318:         loc_oPg.AddObject("grd_4c_Historico", "Grid")
1319:         WITH loc_oPg.grd_4c_Historico
1320:             .Top           = 104
1321:             .Left          = 11
1322:             .Width         = 721
1323:             .Height        = 292
1324:             .FontName      = "Courier New"
1325:             .DeleteMark    = .F.
1326:             .RecordMark    = .F.
1327:             .ReadOnly      = .T.
1328:             .ScrollBars    = 2
1329:             .RecordSource  = "dbHistorico"
1330:             .ColumnCount   = 6
1331:             .Themes        = .F.
1332:             .Visible       = .T.
1333: 
1334:             .Columns(1).ControlSource      = "dbHistorico.emps"
1335:             .Columns(1).Header1.Caption    = "Emp"
1336:             .Columns(1).Width              = 31
1337:             .Columns(1).ReadOnly           = .T.
1338: 
1339:             .Columns(2).ControlSource      = "dbHistorico.datas"
1340:             .Columns(2).Header1.Caption    = "Data"

*-- Linhas 1422 a 1482:
1422:     ENDPROC
1423: 
1424:     *==========================================================================
1425:     * ConfigurarNavegacaoResultado - OptionGroup de navegacao entre as 10 abas
1426:     * da pagina Resultado (Optiongroup1 do legado, Top = 12 / Left = 44 /
1427:     * 760x85, 10 botoes graficos de 75x75 lado a lado).
1428:     *
1429:     * O legado navega com "result.ActivePage = this.Value" - por isso as abas
1430:     * foram declaradas na ordem de PageOrder (ver ConfigurarPageFrameResultado)
1431:     * e aqui as legendas/icones/posicoes de cada opcao sao transcritas do dump
1432:     * na MESMA ordem, para opcao N abrir a aba N.
1433:     *
1434:     * OptionGroup nao tem ForeColor (regra #33): a cor vai em cada Buttons(N).
1435:     * Nenhum ButtonsValue eh atribuido - quem guarda a selecao eh o Value
1436:     * do grupo (1..10), e valor nao-zero no botao marcaria todos de uma vez.
1437:     *==========================================================================
1438:     PROTECTED PROCEDURE ConfigurarNavegacaoResultado()
1439:         LOCAL loc_oPg, loc_oOpt
1440:         loc_oPg = THIS.pgf_4c_Paginas.Page2
1441: 
1442:         loc_oPg.AddObject("obj_4c_OptResultado", "OptionGroup")
1443:         loc_oOpt = loc_oPg.obj_4c_OptResultado
1444: 
1445:         WITH loc_oOpt
1446:             .Top           = 12
1447:             .Left          = 44
1448:             .Width         = 760
1449:             .Height        = 85
1450:             .ButtonCount   = 10
1451:             .BackStyle     = 0
1452:             .BorderStyle   = 0
1453:             .SpecialEffect = 1
1454:             .BorderColor   = RGB(136, 189, 188)
1455:             .Value         = 0
1456:             .Themes        = .F.
1457:             .Visible       = .T.
1458:         ENDWITH
1459: 
1460:         *-- Opcao 1 - Saldo Conta Corrente (optSaldo)
1461:         THIS.ConfigurarBotaoNavegacao(loc_oOpt, 1, 5, ;
1462:             "Saldo Conta Corrente", "geral_nota_60.jpg", 7, 2, .T., "")
1463: 
1464:         *-- Opcao 2 - Pendencias Financeiras (optPendencia)
1465:         THIS.ConfigurarBotaoNavegacao(loc_oOpt, 2, 80, ;
1466:             "Pend" + CHR(234) + "ncias Financeiras", "geral_pendencia_60.jpg", 7, 2, .T., "")
1467: 
1468:         *-- Opcao 3 - Cheques (optCheque)
1469:         THIS.ConfigurarBotaoNavegacao(loc_oOpt, 3, 155, ;
1470:             "Cheques", "cheque.png", 0, 2, .T., "")
1471: 
1472:         *-- Opcao 4 - Cartao (optCartao)
1473:         THIS.ConfigurarBotaoNavegacao(loc_oOpt, 4, 230, ;
1474:             "Cart" + CHR(227) + "o", "cartao.png", 0, 0, .F., "")
1475: 
1476:         *-- Opcao 5 - Vendas (optVendas)
1477:         THIS.ConfigurarBotaoNavegacao(loc_oOpt, 5, 305, ;
1478:             "Vendas", "geral_pastas_60.jpg", 0, 0, .F., "")
1479: 
1480:         *-- Opcao 6 - Estoque (optEstoque)
1481:         THIS.ConfigurarBotaoNavegacao(loc_oOpt, 6, 380, ;
1482:             "Estoque", "geral_empilha_60.jpg", 0, 2, .T., "")

*-- Linhas 1498 a 1609:
1498:         THIS.ConfigurarBotaoNavegacao(loc_oOpt, 10, 680, ;
1499:             "Cr" + CHR(233) + "dito", "geral_calculadora_60.jpg", 0, 0, .F., "")
1500: 
1501:         BINDEVENT(loc_oOpt, "InteractiveChange", THIS, "OptResultadoInteractiveChange")
1502:     ENDPROC
1503: 
1504:     *==========================================================================
1505:     * ConfigurarBotaoNavegacao - Aplica a um Buttons(N) do OptionGroup de
1506:     * navegacao as propriedades comuns a todas as 10 opcoes do legado (botao
1507:     * grafico 75x75, Comic Sans MS 8 bold italic, cinza sobre branco, sem
1508:     * tema) mais o que varia de uma para outra.
1509:     *
1510:     * par_oGrupo    : o OptionGroup (passado por referencia de objeto, para nao
1511:     *                 aninhar WITH de AddObject - ver regra do WITH aninhado)
1512:     * par_nIndice   : indice do botao (1..10)
1513:     * par_nLeft     : Left do botao dentro do grupo
1514:     * par_cCaption  : legenda transcrita do dump
1515:     * par_cIcone    : arquivo em vbmp\
1516:     * par_nPicPos   : PicturePosition (0 = default do dump, 7 = acima do texto)
1517:     * par_nAlign    : Alignment (0 = default do dump, 2 = centralizado)
1518:     * par_lWordWrap : WordWrap
1519:     * par_cToolTip  : ToolTipText ("" quando o dump nao declara)
1520:     *==========================================================================
1521:     PROTECTED PROCEDURE ConfigurarBotaoNavegacao(par_oGrupo, par_nIndice, par_nLeft, ;
1522:             par_cCaption, par_cIcone, par_nPicPos, par_nAlign, par_lWordWrap, par_cToolTip)
1523: 
1524:         WITH par_oGrupo.Buttons(par_nIndice)
1525:             .Top        = 5
1526:             .Left       = par_nLeft
1527:             .Width      = 75
1528:             .Height     = 75
1529:             .FontBold   = .T.
1530:             .FontItalic = .T.
1531:             .FontName   = "Comic Sans MS"
1532:             .FontSize   = 8
1533:             .Style      = 1
1534:             .AutoSize   = .F.
1535:             .WordWrap   = par_lWordWrap
1536:             .Alignment  = par_nAlign
1537:             .Caption    = par_cCaption
1538:             .ForeColor  = RGB(90, 90, 90)
1539:             .BackColor  = RGB(255, 255, 255)
1540:             .Themes     = .F.
1541: 
1542:             IF par_nPicPos > 0
1543:                 .PicturePosition = par_nPicPos
1544:             ENDIF
1545: 
1546:             IF !EMPTY(par_cToolTip)
1547:                 .ToolTipText = par_cToolTip
1548:             ENDIF
1549: 
1550:             IF FILE(gc_4c_CaminhoIcones + par_cIcone)
1551:                 .Picture = gc_4c_CaminhoIcones + par_cIcone
1552:             ENDIF
1553:         ENDWITH
1554:     ENDPROC
1555: 
1556:     *==========================================================================
1557:     * ConfigurarPeriodoResultado - Filtro de periodo da pagina Resultado
1558:     * (cnt_periodo do legado: Top = 120 / Left = -1 / 252x36, transparente).
1559:     *
1560:     * O periodo eh o que decide COMO o saldo eh calculado em
1561:     * sigopcgvBO.CarregarHistoricoSaldo: em branco usa o consolidado de
1562:     * SigMvSlc; preenchido limita o historico ao intervalo e soma o proprio
1563:     * historico - exatamente o IF do Processa() legado.
1564:     *
1565:     * lbl_periodo/lbl_periodo_a sao da classe "say" (AutoSize = .T. no dump);
1566:     * aqui vao com AutoSize = .F. + Width/Height transcritos, porque AutoSize
1567:     * eh no-op em Label criado por AddObject (regra #23).
1568:     *==========================================================================
1569:     PROTECTED PROCEDURE ConfigurarPeriodoResultado()
1570:         LOCAL loc_oPg, loc_oCnt
1571:         loc_oPg = THIS.pgf_4c_Paginas.Page2
1572: 
1573:         loc_oPg.AddObject("cnt_4c_Periodo", "Container")
1574:         loc_oCnt = loc_oPg.cnt_4c_Periodo
1575: 
1576:         WITH loc_oCnt
1577:             .Top         = 120
1578:             .Left        = -1
1579:             .Width       = 252
1580:             .Height      = 36
1581:             .BackStyle   = 0
1582:             .BorderWidth = 0
1583:             .Visible     = .T.
1584:         ENDWITH
1585: 
1586:         loc_oCnt.AddObject("lbl_4c_Periodo", "Label")
1587:         WITH loc_oCnt.lbl_4c_Periodo
1588:             .Top       = 10
1589:             .Left      = 16
1590:             .Width     = 48
1591:             .Height    = 17
1592:             .AutoSize  = .F.
1593:             .Alignment = 0
1594:             .FontName  = "Tahoma"
1595:             .FontSize  = 8
1596:             .BackStyle = 0
1597:             .ForeColor = RGB(90, 90, 90)
1598:             .Caption   = "Per" + CHR(237) + "o\<do : "
1599:             .Visible   = .T.
1600:         ENDWITH
1601: 
1602:         loc_oCnt.AddObject("txt_4c_DtInicial", "TextBox")
1603:         WITH loc_oCnt.txt_4c_DtInicial
1604:             .Top           = 8
1605:             .Left          = 66
1606:             .Width         = 80
1607:             .Height        = 21
1608:             .Value         = {}
1609:             .Format        = "K"

*-- Linhas 1644 a 1706:
1644:         *-- O legado recarrega a consulta no LostFocus da data final
1645:         *-- (get_dt_final.LostFocus: ConsultaExecutada = .f. + Processa()).
1646:         *-- LostFocus, nunca KeyPress (regra #47).
1647:         BINDEVENT(loc_oCnt.txt_4c_DtInicial, "LostFocus", THIS, "DtPeriodoLostFocus")
1648:         BINDEVENT(loc_oCnt.txt_4c_DtFinal,   "LostFocus", THIS, "DtPeriodoLostFocus")
1649:     ENDPROC
1650: 
1651:     *==========================================================================
1652:     * ConfigurarBotoesResultado - Barra de acao da pagina Resultado:
1653:     *
1654:     *   cmg_4c_MudaCli  (Cmd_MudaCli do legado) - troca para a visao CADASTRO
1655:     *   cmg_4c_MudaMov  (Cmd_MudaMov do legado) - troca para a visao MOVIMENTO
1656:     *   cmg_4c_Voltar   (grp_operacao do legado) - volta para a pagina Consulta
1657:     *
1658:     * Os tres sao CommandGroup de 1 botao, 85x85, transparentes, exatamente
1659:     * como no dump. MudaCli e MudaMov ocupam o MESMO Left (794) de proposito:
1660:     * no legado so um dos dois esta visivel a cada momento, e e' justamente o
1661:     * clique em um que mostra o outro.
1662:     *
1663:     * lblSaldoCash/getSaldoCash acompanham a visao CADASTRO (o legado os
1664:     * esconde em cmd_cadastro.Click e os mantem fora da visao MOVIMENTO).
1665:     *==========================================================================
1666:     PROTECTED PROCEDURE ConfigurarBotoesResultado()
1667:         LOCAL loc_oPg
1668:         loc_oPg = THIS.pgf_4c_Paginas.Page2
1669: 
1670:         *-- Cmd_MudaCli: "Cadastro"
1671:         loc_oPg.AddObject("cmg_4c_MudaCli", "CommandGroup")
1672:         WITH loc_oPg.cmg_4c_MudaCli
1673:             .Top           = 12
1674:             .Left          = 794
1675:             .Width         = 85
1676:             .Height        = 85
1677:             .ButtonCount   = 1
1678:             .BackStyle     = 0
1679:             .BorderStyle   = 0
1680:             .SpecialEffect = 1
1681:             .BorderColor   = RGB(136, 189, 188)
1682:             .Themes        = .F.
1683: 
1684:             WITH .Buttons(1)
1685:                 .Top         = 5
1686:                 .Left        = 5
1687:                 .Width       = 75
1688:                 .Height      = 75
1689:                 .FontBold    = .T.
1690:                 .FontItalic  = .T.
1691:                 .FontName    = "Comic Sans MS"
1692:                 .FontSize    = 8
1693:                 .Caption     = "\<Cadastro"
1694:                 .ToolTipText = "Dados Cadastrais"
1695:                 .ForeColor   = RGB(90, 90, 90)
1696:                 .BackColor   = RGB(255, 255, 255)
1697:                 .Themes      = .F.
1698:                 IF FILE(gc_4c_CaminhoIcones + "geral_contatos_60.jpg")
1699:                     .Picture = gc_4c_CaminhoIcones + "geral_contatos_60.jpg"
1700:                 ENDIF
1701:             ENDWITH
1702: 
1703:             .Visible = .T.
1704:         ENDWITH
1705: 
1706:         *-- Cmd_MudaMov: "Movimento"

*-- Linhas 1809 a 1900:
1809:             .Visible           = .F.
1810:         ENDWITH
1811: 
1812:         BINDEVENT(loc_oPg.cmg_4c_MudaCli.Buttons(1), "Click", THIS, "BtnMudaCliClick")
1813:         BINDEVENT(loc_oPg.cmg_4c_MudaMov.Buttons(1), "Click", THIS, "BtnMudaMovClick")
1814:         BINDEVENT(loc_oPg.cmg_4c_Voltar.Buttons(1),  "Click", THIS, "BtnVoltarClick")
1815:     ENDPROC
1816: 
1817:     *==========================================================================
1818:     * ConfigurarPaineisImpressao - Botao Imprime (pag_resultado.Imprime) e os
1819:     * dois paineis modais de selecao de impressao do legado:
1820:     *
1821:     *   cnt_4c_SelecionaImpCad      (SelecionaImpCad)      - visao CADASTRO
1822:     *   cnt_4c_SelecionaImpressao   (SelecionaImpress?o)   - visao MOVIMENTO
1823:     *==========================================================================
1824:     PROTECTED PROCEDURE ConfigurarPaineisImpressao()
1825:         LOCAL loc_oPg
1826:         loc_oPg = THIS.pgf_4c_Paginas.Page2
1827: 
1828:         loc_oPg.AddObject("cmd_4c_Imprime", "CommandButton")
1829:         WITH loc_oPg.cmd_4c_Imprime
1830:             .Top             = 134
1831:             .Left            = 858
1832:             .Width           = 137
1833:             .Height          = 37
1834:             .FontBold        = .T.
1835:             .FontItalic      = .T.
1836:             .FontName        = "Comic Sans MS"
1837:             .FontSize        = 8
1838:             .Caption         = "     \<Imprimir"
1839:             .ToolTipText     = "Impress" + CHR(227) + "o"
1840:             .PicturePosition = 1
1841:             .ForeColor       = RGB(90, 90, 90)
1842:             .BackColor       = RGB(255, 255, 255)
1843:             .Themes          = .F.
1844:             IF FILE(gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg")
1845:                 .Picture = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
1846:             ENDIF
1847:             .Visible = .T.
1848:         ENDWITH
1849:         BINDEVENT(loc_oPg.cmd_4c_Imprime, "Click", THIS, "BtnImprimeClick")
1850: 
1851:         THIS.ConfigurarPainelImpressaoCadastro(loc_oPg)
1852:         THIS.ConfigurarPainelImpressaoMovimento(loc_oPg)
1853:     ENDPROC
1854: 
1855:     *==========================================================================
1856:     * ConfigurarPainelImpressaoCadastro - SelecionaImpCad do legado: painel
1857:     * simples (5 checkboxes) usado quando Imprime eh acionado na visao
1858:     * CADASTRO.
1859:     *==========================================================================
1860:     PROTECTED PROCEDURE ConfigurarPainelImpressaoCadastro(par_oPg)
1861:         LOCAL loc_oCnt
1862:         par_oPg.AddObject("cnt_4c_SelecionaImpCad", "Container")
1863:         loc_oCnt = par_oPg.cnt_4c_SelecionaImpCad
1864: 
1865:         WITH loc_oCnt
1866:             .Top           = 213
1867:             .Left          = 270
1868:             .Width         = 458
1869:             .Height        = 178
1870:             .SpecialEffect = 0
1871:             .BackColor     = RGB(255, 255, 255)
1872:             IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
1873:                 .Picture = gc_4c_CaminhoIcones + "new_background.jpg"
1874:             ENDIF
1875:             .Visible = .F.
1876:         ENDWITH
1877: 
1878:         loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
1879:         WITH loc_oCnt.lbl_4c_Titulo
1880:             .Top       = 6
1881:             .Left      = 5
1882:             .Width     = 226
1883:             .Height    = 17
1884:             .AutoSize  = .F.
1885:             .FontBold  = .T.
1886:             .FontName  = "Tahoma"
1887:             .FontSize  = 8
1888:             .BackStyle = 0
1889:             .ForeColor = RGB(90, 90, 90)
1890:             .Caption   = "Impress" + CHR(227) + "o da Consulta (Cadastro)"
1891:             .Visible   = .T.
1892:         ENDWITH
1893: 
1894:         loc_oCnt.AddObject("chk_4c_Generico", "CheckBox")
1895:         WITH loc_oCnt.chk_4c_Generico
1896:             .Top       = 37
1897:             .Left      = 18
1898:             .Width     = 99
1899:             .Height    = 15
1900:             .AutoSize  = .T.

*-- Linhas 1974 a 2091:
1974:             .Caption   = "Impressora 40 colunas"
1975:             .Value     = 1
1976:             .Visible   = .T.
1977:         ENDWITH
1978: 
1979:         loc_oCnt.AddObject("cmd_4c_Visualizar", "CommandButton")
1980:         WITH loc_oCnt.cmd_4c_Visualizar
1981:             .Top             = 5
1982:             .Left            = 231
1983:             .Width           = 75
1984:             .Height          = 75
1985:             .FontBold        = .T.
1986:             .FontItalic      = .T.
1987:             .FontName        = "Comic Sans MS"
1988:             .PicturePosition = 13
1989:             .Caption         = "V" + CHR(237) + "deo"
1990:             .ForeColor       = RGB(90, 90, 90)
1991:             .BackColor       = RGB(255, 255, 255)
1992:             .Themes          = .F.
1993:             IF FILE(gc_4c_CaminhoIcones + "relatorio_video_26.jpg")
1994:                 .Picture = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
1995:             ENDIF
1996:             .Visible = .T.
1997:         ENDWITH
1998: 
1999:         loc_oCnt.AddObject("cmd_4c_Imprimir", "CommandButton")
2000:         WITH loc_oCnt.cmd_4c_Imprimir
2001:             .Top             = 5
2002:             .Left            = 306
2003:             .Width           = 75
2004:             .Height          = 75
2005:             .FontBold        = .T.
2006:             .FontItalic      = .T.
2007:             .FontName        = "Comic Sans MS"
2008:             .WordWrap        = .F.
2009:             .PicturePosition = 13
2010:             .Caption         = " Impressora    "
2011:             .ForeColor       = RGB(90, 90, 90)
2012:             .BackColor       = RGB(255, 255, 255)
2013:             .Themes          = .F.
2014:             IF FILE(gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg")
2015:                 .Picture = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
2016:             ENDIF
2017:             .Visible = .T.
2018:         ENDWITH
2019: 
2020:         loc_oCnt.AddObject("cmd_4c_Saida", "CommandButton")
2021:         WITH loc_oCnt.cmd_4c_Saida
2022:             .Top        = 5
2023:             .Left        = 379
2024:             .Width       = 75
2025:             .Height      = 75
2026:             .FontBold    = .T.
2027:             .FontItalic  = .T.
2028:             .FontName    = "Comic Sans MS"
2029:             .FontSize    = 8
2030:             .Cancel      = .T.
2031:             .Caption     = "Encerrar"
2032:             .ForeColor   = RGB(90, 90, 90)
2033:             .BackColor   = RGB(255, 255, 255)
2034:             .Themes      = .F.
2035:             IF FILE(gc_4c_CaminhoIcones + "cadastro_sair_60.jpg")
2036:                 .Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
2037:             ENDIF
2038:             .Visible = .T.
2039:         ENDWITH
2040: 
2041:         BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnImpCadVisualizarClick")
2042:         BINDEVENT(loc_oCnt.cmd_4c_Imprimir,   "Click", THIS, "BtnImpCadImprimirClick")
2043:         BINDEVENT(loc_oCnt.cmd_4c_Saida,      "Click", THIS, "BtnImpCadSaidaClick")
2044:     ENDPROC
2045: 
2046:     *==========================================================================
2047:     * ConfigurarPainelImpressaoMovimento - SelecionaImpress?o do legado:
2048:     * painel completo (14 checkboxes + periodo de produtos adquiridos) usado
2049:     * quando Imprime eh acionado na visao MOVIMENTO.
2050:     *==========================================================================
2051:     PROTECTED PROCEDURE ConfigurarPainelImpressaoMovimento(par_oPg)
2052:         LOCAL loc_oCnt, loc_oProd
2053:         par_oPg.AddObject("cnt_4c_SelecionaImpressao", "Container")
2054:         loc_oCnt = par_oPg.cnt_4c_SelecionaImpressao
2055: 
2056:         WITH loc_oCnt
2057:             .Top           = 145
2058:             .Left          = 295
2059:             .Width         = 409
2060:             .Height        = 315
2061:             .SpecialEffect = 0
2062:             .BackColor     = RGB(255, 255, 255)
2063:             IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
2064:                 .Picture = gc_4c_CaminhoIcones + "new_background.jpg"
2065:             ENDIF
2066:             .Visible = .F.
2067:         ENDWITH
2068: 
2069:         loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
2070:         WITH loc_oCnt.lbl_4c_Titulo
2071:             .Top       = 12
2072:             .Left      = 10
2073:             .Width     = 132
2074:             .Height    = 15
2075:             .AutoSize  = .T.
2076:             .FontBold  = .T.
2077:             .FontName  = "Tahoma"
2078:             .FontSize  = 8
2079:             .BackStyle = 0
2080:             .ForeColor = RGB(90, 90, 90)
2081:             .Caption   = "Impress" + CHR(227) + "o da Consulta"
2082:             .Visible   = .T.
2083:         ENDWITH
2084: 
2085:         loc_oCnt.AddObject("chk_4c_Saldo", "CheckBox")
2086:         WITH loc_oCnt.chk_4c_Saldo
2087:             .Top       = 88
2088:             .Left      = 10
2089:             .Width     = 137
2090:             .Height    = 15
2091:             .AutoSize  = .T.

*-- Linhas 2387 a 2650:
2387:             .ForeColor     = RGB(0, 0, 0)
2388:             .SpecialEffect = 1
2389:             .Visible       = .T.
2390:         ENDWITH
2391: 
2392:         loc_oCnt.AddObject("cmd_4c_Visualizar", "CommandButton")
2393:         WITH loc_oCnt.cmd_4c_Visualizar
2394:             .Top             = 4
2395:             .Left            = 179
2396:             .Width           = 75
2397:             .Height          = 75
2398:             .FontBold        = .T.
2399:             .FontItalic      = .T.
2400:             .FontName        = "Comic Sans MS"
2401:             .WordWrap        = .F.
2402:             .PicturePosition = 13
2403:             .Caption         = "    V" + CHR(237) + "deo            "
2404:             .ForeColor       = RGB(90, 90, 90)
2405:             .BackColor       = RGB(255, 255, 255)
2406:             .Themes          = .F.
2407:             IF FILE(gc_4c_CaminhoIcones + "relatorio_video_26.jpg")
2408:                 .Picture = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
2409:             ENDIF
2410:             .Visible = .T.
2411:         ENDWITH
2412: 
2413:         loc_oCnt.AddObject("cmd_4c_Imprimir", "CommandButton")
2414:         WITH loc_oCnt.cmd_4c_Imprimir
2415:             .Top             = 4
2416:             .Left            = 254
2417:             .Width           = 75
2418:             .Height          = 75
2419:             .FontBold        = .T.
2420:             .FontItalic      = .T.
2421:             .FontName        = "Comic Sans MS"
2422:             .WordWrap        = .F.
2423:             .PicturePosition = 13
2424:             .Caption         = " Impressora    "
2425:             .ForeColor       = RGB(90, 90, 90)
2426:             .BackColor       = RGB(255, 255, 255)
2427:             .Themes          = .F.
2428:             IF FILE(gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg")
2429:                 .Picture = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
2430:             ENDIF
2431:             .Visible = .T.
2432:         ENDWITH
2433: 
2434:         loc_oCnt.AddObject("cmd_4c_Saida", "CommandButton")
2435:         WITH loc_oCnt.cmd_4c_Saida
2436:             .Top             = 4
2437:             .Left            = 329
2438:             .Width           = 75
2439:             .Height          = 75
2440:             .FontBold        = .T.
2441:             .FontItalic      = .T.
2442:             .FontName        = "Comic Sans MS"
2443:             .FontSize        = 8
2444:             .Cancel          = .T.
2445:             .PicturePosition = 13
2446:             .Caption         = "Encerrar"
2447:             .ForeColor       = RGB(90, 90, 90)
2448:             .BackColor       = RGB(255, 255, 255)
2449:             .Themes          = .F.
2450:             IF FILE(gc_4c_CaminhoIcones + "cadastro_sair_60.jpg")
2451:                 .Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
2452:             ENDIF
2453:             .Visible = .T.
2454:         ENDWITH
2455: 
2456:         BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnImpMovVisualizarClick")
2457:         BINDEVENT(loc_oCnt.cmd_4c_Imprimir,   "Click", THIS, "BtnImpMovImprimirClick")
2458:         BINDEVENT(loc_oCnt.cmd_4c_Saida,      "Click", THIS, "BtnImpMovSaidaClick")
2459:     ENDPROC
2460: 
2461:     *==========================================================================
2462:     * BtnImprimeClick - Imprime.Click do legado: centraliza o painel de
2463:     * impressao correto (SelecionaImpressao na visao MOVIMENTO,
2464:     * SelecionaImpCad na visao CADASTRO - distincao por cmg_4c_MudaCli.
2465:     * Visible, regra #40: so um dos dois MudaCli/MudaMov fica visivel por
2466:     * vez, e MudaCli visivel = visao MOVIMENTO em curso) e desabilita o
2467:     * resto da tela enquanto o painel esta aberto.
2468:     *==========================================================================
2469:     PROCEDURE BtnImprimeClick()
2470:         LOCAL loc_oPg, loc_oPainel, loc_nLeft, loc_nTop
2471: 
2472:         loc_oPg = THIS.pgf_4c_Paginas.Page2
2473:         loc_oPg.cmd_4c_Imprime.Enabled = .F.
2474: 
2475:         loc_oPainel = IIF(loc_oPg.cmg_4c_MudaCli.Visible, ;
2476:             loc_oPg.cnt_4c_SelecionaImpressao, loc_oPg.cnt_4c_SelecionaImpCad)
2477: 
2478:         loc_nLeft = INT(THIS.Width - loc_oPainel.Width)
2479:         loc_nLeft = IIF(loc_nLeft > 0, INT(loc_nLeft / 2), 0)
2480:         loc_nTop  = INT(THIS.Height - loc_oPainel.Height)
2481:         loc_nTop  = IIF(loc_nTop > 0, INT(loc_nTop / 2), 0)
2482: 
2483:         loc_oPainel.Left    = loc_nLeft
2484:         loc_oPainel.Top     = loc_nTop
2485:         loc_oPainel.Visible = .T.
2486:         loc_oPainel.ZOrder(0)
2487: 
2488:         THIS.DesabilitarControlesImpressao()
2489:     ENDPROC
2490: 
2491:     *==========================================================================
2492:     * DesabilitarControlesImpressao / RestaurarControlesImpressao - bloco
2493:     * repetido nos dois paineis (Saida/Visualizar/Imprimir) do legado para
2494:     * travar/destravar o resto da tela enquanto o popup de impressao esta
2495:     * aberto. cntConta (visao cadastral) ainda nao existe nesta migracao
2496:     * (fica para a fase do wrapper clsconta) - guardado por PEMSTATUS.
2497:     *==========================================================================
2498:     PROTECTED PROCEDURE DesabilitarControlesImpressao()
2499:         LOCAL loc_oPg
2500:         loc_oPg = THIS.pgf_4c_Paginas.Page2
2501: 
2502:         THIS.pgf_4c_Paginas.Page1.Enabled = .F.
2503:         loc_oPg.pgf_4c_Resultado.Enabled  = .F.
2504:         IF PEMSTATUS(loc_oPg, "cntConta", 5)
2505:             loc_oPg.cntConta.Enabled = .F.
2506:         ENDIF
2507:         loc_oPg.cmg_4c_MudaMov.Enabled = .F.
2508:         loc_oPg.cmg_4c_MudaCli.Enabled = .F.
2509:         loc_oPg.cmg_4c_Voltar.Enabled  = .F.
2510:     ENDPROC
2511: 
2512:     PROTECTED PROCEDURE RestaurarControlesImpressao()
2513:         LOCAL loc_oPg
2514:         loc_oPg = THIS.pgf_4c_Paginas.Page2
2515: 
2516:         THIS.pgf_4c_Paginas.Page1.Enabled = .T.
2517:         loc_oPg.pgf_4c_Resultado.Enabled  = .T.
2518:         IF PEMSTATUS(loc_oPg, "cntConta", 5)
2519:             loc_oPg.cntConta.Enabled = .T.
2520:         ENDIF
2521:         loc_oPg.cmg_4c_MudaMov.Enabled = .T.
2522:         loc_oPg.cmg_4c_MudaCli.Enabled = .T.
2523:         loc_oPg.cmg_4c_Voltar.Enabled  = .T.
2524:         loc_oPg.cmd_4c_Imprime.Enabled = .T.
2525:     ENDPROC
2526: 
2527:     *==========================================================================
2528:     * BtnImpCadSaidaClick / BtnImpCadVisualizarClick / BtnImpCadImprimirClick
2529:     * Saida/Visualizar/Imprimir.Click do SelecionaImpCad legado.
2530:     *==========================================================================
2531:     PROCEDURE BtnImpCadSaidaClick()
2532:         THIS.pgf_4c_Paginas.Page2.cnt_4c_SelecionaImpCad.Visible = .F.
2533:         THIS.RestaurarControlesImpressao()
2534:     ENDPROC
2535: 
2536:     PROCEDURE BtnImpCadVisualizarClick()
2537:         LOCAL loc_oPnl
2538:         loc_oPnl = THIS.pgf_4c_Paginas.Page2.cnt_4c_SelecionaImpCad
2539:         THIS.ImpressaoCad("V", loc_oPnl.chk_4c_Generico.Value = 1, ;
2540:             loc_oPnl.chk_4c_Pessoais.Value = 1, loc_oPnl.chk_4c_Bancarias.Value = 1, ;
2541:             loc_oPnl.chk_4c_Followup.Value = 1, loc_oPnl.chk_4c_Impressora.Value = 1)
2542:         loc_oPnl.Visible = .F.
2543:         THIS.RestaurarControlesImpressao()
2544:     ENDPROC
2545: 
2546:     PROCEDURE BtnImpCadImprimirClick()
2547:         LOCAL loc_oPnl
2548:         loc_oPnl = THIS.pgf_4c_Paginas.Page2.cnt_4c_SelecionaImpCad
2549:         THIS.ImpressaoCad("I", loc_oPnl.chk_4c_Generico.Value = 1, ;
2550:             loc_oPnl.chk_4c_Pessoais.Value = 1, loc_oPnl.chk_4c_Bancarias.Value = 1, ;
2551:             loc_oPnl.chk_4c_Followup.Value = 1, loc_oPnl.chk_4c_Impressora.Value = 1)
2552:         loc_oPnl.Visible = .F.
2553:         THIS.RestaurarControlesImpressao()
2554:     ENDPROC
2555: 
2556:     *==========================================================================
2557:     * BtnImpMovSaidaClick / BtnImpMovVisualizarClick / BtnImpMovImprimirClick
2558:     * Saida/Visualizar/Imprimir.Click do SelecionaImpress?o legado.
2559:     *==========================================================================
2560:     PROCEDURE BtnImpMovSaidaClick()
2561:         THIS.pgf_4c_Paginas.Page2.cnt_4c_SelecionaImpressao.Visible = .F.
2562:         THIS.RestaurarControlesImpressao()
2563:     ENDPROC
2564: 
2565:     PROCEDURE BtnImpMovVisualizarClick()
2566:         LOCAL loc_oPnl
2567:         loc_oPnl = THIS.pgf_4c_Paginas.Page2.cnt_4c_SelecionaImpressao
2568:         THIS.Impressao("V", loc_oPnl.chk_4c_Saldo.Value = 1, loc_oPnl.chk_4c_Limite.Value = 1, ;
2569:             loc_oPnl.chk_4c_ChqPend.Value = 1, loc_oPnl.chk_4c_ChqDev.Value = 1, ;
2570:             loc_oPnl.chk_4c_ChqDep.Value = 1, loc_oPnl.chk_4c_Cartao.Value = 1, ;
2571:             loc_oPnl.chk_4c_Pend.Value = 1, loc_oPnl.chk_4c_MovPend.Value = 1, .F., ;
2572:             loc_oPnl.chk_4c_Negociado.Value = 1, loc_oPnl.chk_4c_ResVenda.Value = 1, ;
2573:             loc_oPnl.chk_4c_ProdAdq.Value = 1, loc_oPnl.chk_4c_Producao.Value = 1, ;
2574:             loc_oPnl.chk_4c_Estoque.Value = 1)
2575:         loc_oPnl.Visible = .F.
2576:         THIS.RestaurarControlesImpressao()
2577:     ENDPROC
2578: 
2579:     PROCEDURE BtnImpMovImprimirClick()
2580:         LOCAL loc_oPnl
2581:         loc_oPnl = THIS.pgf_4c_Paginas.Page2.cnt_4c_SelecionaImpressao
2582:         THIS.Impressao("I", loc_oPnl.chk_4c_Saldo.Value = 1, loc_oPnl.chk_4c_Limite.Value = 1, ;
2583:             loc_oPnl.chk_4c_ChqPend.Value = 1, loc_oPnl.chk_4c_ChqDev.Value = 1, ;
2584:             loc_oPnl.chk_4c_ChqDep.Value = 1, loc_oPnl.chk_4c_Cartao.Value = 1, ;
2585:             loc_oPnl.chk_4c_Pend.Value = 1, loc_oPnl.chk_4c_MovPend.Value = 1, ;
2586:             loc_oPnl.chk_4c_Imp40.Value = 1, loc_oPnl.chk_4c_Negociado.Value = 1, ;
2587:             loc_oPnl.chk_4c_ResVenda.Value = 1, loc_oPnl.chk_4c_ProdAdq.Value = 1, ;
2588:             loc_oPnl.chk_4c_Producao.Value = 1, loc_oPnl.chk_4c_Estoque.Value = 1)
2589:         loc_oPnl.Visible = .F.
2590:         THIS.RestaurarControlesImpressao()
2591:     ENDPROC
2592: 
2593:     *==========================================================================
2594:     * AlternarPagina - FUNIL de troca de pagina (regra #40). Alem de mudar o
2595:     * ActivePage (DODEFAULT -> FormBase), repoe o modo corrente e a altura do
2596:     * form, e repinta as grades quando a pagina Resultado fica visivel.
2597:     *
2598:     * Altura: o legado trabalha com a tela encolhida em 300 na pagina Consulta
2599:     * (ThisForm.Height = 300 no proprio Init e no cmd_voltar.Click) e em 600
2600:     * na pagina Resultado (cmd_cadastro.Click/cmd_movimenta.Click). Reproduzir
2601:     * isso faz o relatorio de UI Fidelity acusar DIFERENCA de Height contra o
2602:     * valor DECLARADO no SCX (600) - eh falso positivo conhecido do comparador,
2603:     * que le o dump estatico e nao executa o Init legado.
2604:     *
2605:     * Limpeza dos campos: so na VOLTA da pagina Resultado (cmd_voltar.Click do
2606:     * legado limpa Conta/Nome/CPF/Conjuge/Telefone). Na abertura da tela nao
2607:     * se limpa nada, senao a conta recebida por parametro no Init seria
2608:     * descartada.
2609:     *==========================================================================
2610:     PROCEDURE AlternarPagina(par_nPagina)
2611:         LOCAL loc_lVoltando, loc_oCnt, loc_oErro
2612: 
2613:         loc_lVoltando = (par_nPagina = 1 AND THIS.this_cModoAtual == "RESULTADO")
2614: 
2615:         DODEFAULT(par_nPagina)
2616: 
2617:         DO CASE
2618:             CASE par_nPagina = 1
2619:                 THIS.this_cModoAtual = "CONSULTA"
2620: 
2621:                 IF THIS.Height <> 300
2622:                     THIS.Height = 300
2623:                 ENDIF
2624: 
2625:                 IF loc_lVoltando
2626:                     *-- Limpeza dos cinco criterios + LimparDados do BO, num
2627:                     *-- funil unico (LimparCampos) - o bloco do cmd_voltar.Click
2628:                     loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
2629:                     THIS.LimparCampos()
2630: 
2631:                     TRY
2632:                         loc_oCnt.txt_4c_Conta.SetFocus()
2633:                     CATCH TO loc_oErro
2634:                         *-- SetFocus falha com a pagina ainda nao pintada ou em
2635:                         *-- modo de teste automatizado: nao eh erro de negocio
2636:                     ENDTRY
2637:                 ELSE
2638:                     *-- Abertura da tela: nada a limpar (a conta pode ter vindo
2639:                     *-- por parametro no Init), mas a cascata de When do legado
2640:                     *-- precisa valer desde o primeiro desenho
2641:                     THIS.HabilitarCampos(.T.)
2642:                 ENDIF
2643: 
2644:             CASE par_nPagina = 2
2645:                 THIS.this_cModoAtual = "RESULTADO"
2646: 
2647:                 IF THIS.Height <> 600
2648:                     THIS.Height = 600
2649:                 ENDIF
2650: 

*-- Linhas 2668 a 2801:
2668:     * PUBLIC de proposito: eh chamado de fora da classe pelos botoes e pelo
2669:     * harness de teste automatizado (regra #3).
2670:     *==========================================================================
2671:     PROCEDURE CarregarDados()
2672:         LOCAL loc_lSucesso, loc_oCnt, loc_oErro
2673:         loc_lSucesso = .F.
2674: 
2675:         TRY
2676:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2677:                 *-- Criterios e periodo da tela -> BO num funil unico
2678:                 *-- (fonte unica eh o campo, nao a property)
2679:                 THIS.FormParaBO()
2680: 
2681:                 loc_lSucesso = THIS.this_oBusinessObject.CarregarHistoricoSaldo()
2682: 
2683:                 IF !loc_lSucesso AND !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
2684:                     MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
2685:                         "Consulta de Saldo")
2686:                 ENDIF
2687: 
2688:                 THIS.AtualizarGradesSaldo()
2689: 
2690:                 *-- Abas alimentadas pelo mesmo Processa() legado (Pendencias,
2691:                 *-- Cheques) e pelos PCartao()/PEstoque() (Cartao, Estoque)
2692:                 THIS.CarregarAbasResultado()
2693:             ENDIF
2694:         CATCH TO loc_oErro
2695:             MsgErro(loc_oErro.Message + CHR(13) + ;
2696:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2697:                 "Proc: " + loc_oErro.Procedure, "Erro ao carregar a consulta")
2698:         ENDTRY
2699: 
2700:         RETURN loc_lSucesso
2701:     ENDPROC
2702: 
2703:     *==========================================================================
2704:     * AtualizarGradesSaldo - Funil UNICO de repintura das grades da aba Saldo
2705:     * (regra #21a: popular o cursor nao repinta a grade - o legado sempre
2706:     * fecha com "Go Top In <cursor>" + "<grid>.Refresh").
2707:     *
2708:     * Chamado no fim da carga E no AlternarPagina(2), DEPOIS da troca de
2709:     * ActivePage, porque Refresh em pagina oculta nao pinta (regra #46).
2710:     * PUBLIC: chamado de fora da classe (botoes e harness de teste).
2711:     *==========================================================================
2712:     PROCEDURE AtualizarGradesSaldo()
2713:         LOCAL loc_oAba, loc_oErro, loc_lTemAbas
2714: 
2715:         *-- Sem RETURN dentro do TRY (regra #1): o guard vira flag
2716:         TRY
2717:             loc_lTemAbas = PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "pgf_4c_Resultado", 5)
2718: 
2719:             IF loc_lTemAbas
2720:                 loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page1
2721: 
2722:                 IF USED("dbHistorico")
2723:                     SELECT dbHistorico
2724:                     GO TOP
2725:                 ENDIF
2726:                 IF USED("dbSaldo")
2727:                     SELECT dbSaldo
2728:                     GO TOP
2729:                 ENDIF
2730: 
2731:                 IF PEMSTATUS(loc_oAba, "grd_4c_Historico", 5)
2732:                     loc_oAba.grd_4c_Historico.Refresh()
2733:                 ENDIF
2734:                 IF PEMSTATUS(loc_oAba, "grd_4c_Saldo", 5)
2735:                     loc_oAba.grd_4c_Saldo.Refresh()
2736:                 ENDIF
2737:             ENDIF
2738:         CATCH TO loc_oErro
2739:             MsgErro(loc_oErro.Message + CHR(13) + ;
2740:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
2741:                 "Erro ao atualizar as grades de saldo")
2742:         ENDTRY
2743:     ENDPROC
2744: 
2745:     *==========================================================================
2746:     * AjustarVisibilidadeResultado - Funil UNICO de visibilidade da pagina
2747:     * Resultado, transcrito de cmd_cadastro.Click (Cmd_MudaCli) e de
2748:     * cmd_movimenta.Click (Cmd_MudaMov) do legado. Nos dois metodos o legado
2749:     * mexe exatamente no mesmo conjunto, em sentidos opostos:
2750:     *
2751:     *   visao CADASTRO  : Result/OptionGroup/cnt_periodo escondidos,
2752:     *                     MudaCli escondido e MudaMov visivel
2753:     *   visao MOVIMENTO : Result/OptionGroup/cnt_periodo visiveis,
2754:     *                     MudaMov escondido e MudaCli visivel
2755:     *
2756:     * O par MudaCli/MudaMov nunca fica visivel ao mesmo tempo - os dois estao
2757:     * no mesmo Left (794) no legado.
2758:     *
2759:     * PUBLIC: chamado de fora da classe (botoes da pagina Consulta e harness).
2760:     *==========================================================================
2761:     PROCEDURE AjustarVisibilidadeResultado(par_cModo)
2762:         LOCAL loc_oPg, loc_lMovimento, loc_oErro
2763: 
2764:         loc_lMovimento = (UPPER(ALLTRIM(IIF(VARTYPE(par_cModo) = "C", par_cModo, ""))) == "MOVIMENTO")
2765: 
2766:         TRY
2767:             loc_oPg = THIS.pgf_4c_Paginas.Page2
2768: 
2769:             THIS.this_cModoResultado = IIF(loc_lMovimento, "MOVIMENTO", "CADASTRO")
2770: 
2771:             loc_oPg.pgf_4c_Resultado.Visible   = loc_lMovimento
2772:             loc_oPg.pgf_4c_Resultado.Enabled   = loc_lMovimento
2773: 
2774:             loc_oPg.obj_4c_OptResultado.Visible = loc_lMovimento
2775:             loc_oPg.obj_4c_OptResultado.Enabled = loc_lMovimento
2776: 
2777:             loc_oPg.cnt_4c_Periodo.Visible = loc_lMovimento
2778:             loc_oPg.cnt_4c_Periodo.Enabled = loc_lMovimento
2779: 
2780:             *-- Visao CADASTRO oferece ir para MOVIMENTO, e vice-versa
2781:             loc_oPg.cmg_4c_MudaMov.Visible = !loc_lMovimento
2782:             loc_oPg.cmg_4c_MudaMov.Enabled = !loc_lMovimento
2783: 
2784:             loc_oPg.cmg_4c_MudaCli.Visible = loc_lMovimento
2785:             loc_oPg.cmg_4c_MudaCli.Enabled = loc_lMovimento
2786: 
2787:             *-- Saldo de cashback acompanha a visao cadastral
2788:             loc_oPg.lbl_4c_SaldoCash.Visible = !loc_lMovimento
2789:             loc_oPg.txt_4c_SaldoCash.Visible = !loc_lMovimento
2790: 
2791:             IF loc_lMovimento
2792:                 *-- Abre na aba 1 (Saldo), como o legado faz com ResultPageToSet
2793:                 IF loc_oPg.obj_4c_OptResultado.Value < 1
2794:                     loc_oPg.obj_4c_OptResultado.Value = 1
2795:                 ENDIF
2796:                 loc_oPg.pgf_4c_Resultado.ActivePage = loc_oPg.obj_4c_OptResultado.Value
2797:                 loc_oPg.pgf_4c_Resultado.Refresh()
2798:             ENDIF
2799: 
2800:             loc_oPg.Refresh()
2801:         CATCH TO loc_oErro

*-- Linhas 2810 a 2979:
2810:     ENDPROC
2811: 
2812:     *==========================================================================
2813:     * OptResultadoInteractiveChange - Optiongroup1.InteractiveChange do legado:
2814:     *   result.ActivePage = this.Value  +  result.Refresh()
2815:     * O Value do grupo eh 1..10 e, com as abas declaradas em ordem de
2816:     * PageOrder, cai direto na aba correspondente. Value = 0 (nenhuma opcao
2817:     * marcada, estado inicial do legado) nao troca de aba.
2818:     *==========================================================================
2819:     PROCEDURE OptResultadoInteractiveChange()
2820:         LOCAL loc_oPg, loc_nOpcao, loc_oErro
2821: 
2822:         TRY
2823:             loc_oPg    = THIS.pgf_4c_Paginas.Page2
2824:             loc_nOpcao = loc_oPg.obj_4c_OptResultado.Value
2825: 
2826:             IF BETWEEN(loc_nOpcao, 1, loc_oPg.pgf_4c_Resultado.PageCount)
2827:                 loc_oPg.pgf_4c_Resultado.ActivePage = loc_nOpcao
2828:                 loc_oPg.pgf_4c_Resultado.Refresh()
2829: 
2830:                 *-- Repintura da aba que acabou de ficar a vista
2831:                 THIS.AtualizarAbaResultadoAtiva()
2832:             ENDIF
2833:         CATCH TO loc_oErro
2834:             MsgErro(loc_oErro.Message + CHR(13) + ;
2835:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
2836:                 "Erro ao trocar de aba")
2837:         ENDTRY
2838:     ENDPROC
2839: 
2840:     *==========================================================================
2841:     * DtPeriodoLostFocus - Recarrega a consulta quando o periodo muda
2842:     * (get_dt_final.LostFocus do legado: ConsultaExecutada = .f. + Processa()).
2843:     * Nao faz nada enquanto a pagina Resultado nao estiver em uso, para nao
2844:     * disparar consulta so por passar o foco pelos campos.
2845:     *==========================================================================
2846:     PROCEDURE DtPeriodoLostFocus()
2847:         IF THIS.this_cModoAtual == "RESULTADO"
2848:             THIS.this_oBusinessObject.this_lConsultaExecutada = .F.
2849:             THIS.CarregarDados()
2850:         ENDIF
2851:     ENDPROC
2852: 
2853:     *==========================================================================
2854:     * BtnMudaCliClick - cmd_cadastro.Click do Cmd_MudaCli legado: troca a
2855:     * pagina Resultado para a visao CADASTRO.
2856:     *==========================================================================
2857:     PROCEDURE BtnMudaCliClick()
2858:         THIS.this_oBusinessObject.this_cEscolha = "ALTERAR"
2859:         THIS.AjustarVisibilidadeResultado("CADASTRO")
2860:     ENDPROC
2861: 
2862:     *==========================================================================
2863:     * BtnMudaMovClick - cmd_movimenta.Click do Cmd_MudaMov legado: troca a
2864:     * pagina Resultado para a visao MOVIMENTO.
2865:     *==========================================================================
2866:     PROCEDURE BtnMudaMovClick()
2867:         THIS.this_oBusinessObject.this_cEscolha = "CONSULTAR"
2868:         THIS.AjustarVisibilidadeResultado("MOVIMENTO")
2869:         THIS.AtualizarGradesSaldo()
2870:     ENDPROC
2871: 
2872:     *==========================================================================
2873:     * BtnVoltarClick - cmd_voltar.Click do grp_operacao da pagina Resultado.
2874:     * Com Automatico = .T. (tela aberta por outro form apenas para mostrar uma
2875:     * conta) o legado FECHA e devolve o controle ao chamador; caso contrario
2876:     * volta para a pagina Consulta, que eh o que o funil AlternarPagina(1) faz
2877:     * (limpa os campos, encolhe a tela e devolve o foco ao campo Conta).
2878:     *==========================================================================
2879:     PROCEDURE BtnVoltarClick()
2880:         *-- Bloco de gravacao que abre o cmd_voltar.Click legado: em modo
2881:         *-- ALTERAR pergunta e grava o cadastro antes de sair, e mValidaObj()
2882:         *-- recusando mantem a tela aberta (o "Return .f." do legado)
2883:         IF !THIS.BtnSalvarClick()
2884:             RETURN
2885:         ENDIF
2886: 
2887:         IF THIS.this_oBusinessObject.this_lAutomatico
2888:             THIS.BtnEncerrarClick()
2889:         ELSE
2890:             THIS.AlternarPagina(1)
2891:         ENDIF
2892:     ENDPROC
2893: 
2894:     *==========================================================================
2895:     * ConfigurarPaginaDados - Funil dos CAMPOS DE DADOS da pagina Resultado,
2896:     * isto eh, o conteudo de cada aba do PageFrame interno (Result do legado).
2897:     *
2898:     * A Fase 4 entregou a moldura (as 10 abas, o OptionGroup de navegacao, o
2899:     * filtro de periodo e a barra Cadastro/Movimento/Voltar) mais o conteudo da
2900:     * aba 1 (Saldo). Esta fase acrescenta o conteudo das abas alimentadas pelo
2901:     * Processa()/PCartao()/PEstoque() do legado:
2902:     *
2903:     *   aba 2 Pendencias  - grade TmpPar + grade de formas de pagamento
2904:     *                       (crTmpTipos, com CheckBox marcavel) + total
2905:     *   aba 3 Cheques     - quatro grades (aberto / follow-up / titulos /
2906:     *                       devolvidos) + os nove totais do pe da pagina
2907:     *   aba 4 Cartao      - grade TmpCart (cartoes em aberto)
2908:     *   aba 6 Estoque     - grade dbEstoque (produtos em poder do cliente)
2909:     *
2910:     * As abas 5 (Vendas), 7 (Operacoes Pend.), 8 (Producao), 9 (Historico
2911:     * de Cheques) e 10 (Credito) sao alimentadas por PProduto()/PVenda()/
2912:     * mAtivaHCheque()/mAtivaCredito() do legado - os quatro compartilham o mesmo
2913:     * bloco de cursores (dbProduto/dbProdTodos/dbOperac/dbConserto/dbOpera/
2914:     * dbProduc/dbItens) e por isso formam uma unidade, entregue na fase
2915:     * seguinte junto com o wrapper clsconta e o bloco de impressao.
2916:     *==========================================================================
2917:     PROTECTED PROCEDURE ConfigurarPaginaDados()
2918:         THIS.ConfigurarAbaPendencias()
2919:         THIS.ConfigurarAbaCheques()
2920:         THIS.ConfigurarAbaCartao()
2921:         THIS.ConfigurarAbaEstoque()
2922:         THIS.ConfigurarAbaHCheques()
2923:         THIS.ConfigurarAbaCredito()
2924:     ENDPROC
2925: 
2926:     *==========================================================================
2927:     * ConfigurarAbaPendencias - Aba 2 (Result.Pendencias do legado):
2928:     *
2929:     *   Grd_Pendente -> grd_4c_Pendentes  (TmpPar, 6 colunas)
2930:     *   grdTipos     -> grd_4c_TiposPend  (crTmpTipos, CheckBox marcavel)
2931:     *   Cmb_Grupo    -> cbo_4c_GrupoPend  (filtro de grupo)
2932:     *   getTotPends  -> txt_4c_TotPend    (total do que esta visivel na grade)
2933:     *   Anexa        -> cmd_4c_AnexaPend  (abre o documento da pendencia)
2934:     *   CmdImpPend   -> cmd_4c_ImpPend    (listagem SigReIpd)
2935:     *
2936:     * As colunas sao declaradas na ordem de ColumnOrder do dump (vencto, O,
2937:     * valor, moeda, tipo, historico), que eh a ordem em que o legado as mostra.
2938:     *==========================================================================
2939:     PROTECTED PROCEDURE ConfigurarAbaPendencias()
2940:         LOCAL loc_oPg, loc_oGrid
2941:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page2
2942: 
2943:         loc_oPg.AddObject("shp_4c_Pendencias", "Shape")
2944:         WITH loc_oPg.shp_4c_Pendencias
2945:             .Top         = 42
2946:             .Left        = 18
2947:             .Width       = 735
2948:             .Height      = 413
2949:             .BackStyle   = 0
2950:             .BorderColor = RGB(90, 90, 90)
2951:             .Visible     = .T.
2952:         ENDWITH
2953: 
2954:         loc_oPg.AddObject("lbl_4c_GrupoPend", "Label")
2955:         WITH loc_oPg.lbl_4c_GrupoPend
2956:             .Top       = 53
2957:             .Left      = 42
2958:             .Width     = 41
2959:             .Height    = 15
2960:             .AutoSize  = .F.
2961:             .Alignment = 0
2962:             .FontName  = "Tahoma"
2963:             .FontSize  = 8
2964:             .BackStyle = 0
2965:             .ForeColor = RGB(90, 90, 90)
2966:             .Caption   = "Grupo : "
2967:             .Visible   = .T.
2968:         ENDWITH
2969: 
2970:         loc_oPg.AddObject("cbo_4c_GrupoPend", "ComboBox")
2971:         WITH loc_oPg.cbo_4c_GrupoPend
2972:             .Top           = 49
2973:             .Left          = 85
2974:             .Width         = 300
2975:             .Height        = 24
2976:             .Style         = 2
2977:             .RowSourceType = 0
2978:             .FontName      = "Tahoma"
2979:             .FontSize      = 8

*-- Linhas 3125 a 3175:
3125:         *-- CheckBox de grade nao alterna pelo binding nativo: os quatro
3126:         *-- handlers (Click/MouseDown suprimem o toggle padrao, MouseUp e
3127:         *-- KeyPress alternam por codigo) sao obrigatorios
3128:         BINDEVENT(loc_oGrid.Columns(1).chk_4c_TipoPend, "Click", ;
3129:             THIS, "ChkTipoPendClick")
3130:         BINDEVENT(loc_oGrid.Columns(1).chk_4c_TipoPend, "MouseDown", ;
3131:             THIS, "ChkTipoPendMouseDown")
3132:         BINDEVENT(loc_oGrid.Columns(1).chk_4c_TipoPend, "MouseUp", ;
3133:             THIS, "ChkTipoPendMouseUp")
3134:         BINDEVENT(loc_oGrid.Columns(1).chk_4c_TipoPend, "KeyPress", ;
3135:             THIS, "ChkTipoPendKeyPress")
3136: 
3137:         *-- Total das pendencias visiveis (getTotPends)
3138:         loc_oPg.AddObject("txt_4c_TotPend", "TextBox")
3139:         WITH loc_oPg.txt_4c_TotPend
3140:             .Top           = 427
3141:             .Left          = 56
3142:             .Width         = 150
3143:             .Height        = 23
3144:             .FontName      = "Tahoma"
3145:             .FontSize      = 8
3146:             .Value         = 0
3147:             .InputMask     = "999,999,999.99"
3148:             .ReadOnly      = .T.
3149:             .ForeColor     = RGB(0, 0, 0)
3150:             .BorderColor   = RGB(100, 100, 100)
3151:             .SpecialEffect = 1
3152:             .Visible       = .T.
3153:         ENDWITH
3154: 
3155:         *-- Botao "Documento" (Anexa). Icone-only (Caption = ""): Picture +
3156:         *-- DisabledPicture + Themes = .T. para o icone desenhar sempre, e o
3157:         *-- botao NUNCA eh desabilitado em runtime - a condicao que o legado
3158:         *-- usava para habilitar/desabilitar vive dentro do proprio handler.
3159:         loc_oPg.AddObject("cmd_4c_AnexaPend", "CommandButton")
3160:         WITH loc_oPg.cmd_4c_AnexaPend
3161:             .Top             = 180
3162:             .Left            = 835
3163:             .Width           = 40
3164:             .Height          = 40
3165:             .FontName        = "Verdana"
3166:             .FontSize        = 8
3167:             .Caption         = ""
3168:             .Picture         = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
3169:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
3170:             .ToolTipText     = "Documento"
3171:             .ForeColor       = RGB(36, 84, 155)
3172:             .BackColor       = RGB(255, 255, 255)
3173:             .Themes          = .T.
3174:             .Visible         = .T.
3175:         ENDWITH

*-- Linhas 3192 a 3257:
3192:             .Visible         = .T.
3193:         ENDWITH
3194: 
3195:         BINDEVENT(loc_oPg.cbo_4c_GrupoPend, "InteractiveChange", ;
3196:             THIS, "CboGrupoPendInteractiveChange")
3197:         BINDEVENT(loc_oPg.cmd_4c_AnexaPend, "Click", THIS, "BtnAnexaPendClick")
3198:         BINDEVENT(loc_oPg.cmd_4c_ImpPend,   "Click", THIS, "BtnImpPendClick")
3199:     ENDPROC
3200: 
3201:     *==========================================================================
3202:     * ConfigurarAbaCheques - Aba 3 (Result.Cheque do legado). Tem quatro grades
3203:     * e doze campos somente-leitura:
3204:     *
3205:     *   grd_che_aberto    -> grd_4c_ChequeAberto    (dbAberto)
3206:     *   Grd_followup      -> grd_4c_ChequeFollowup  (DbFollow)
3207:     *   Grd_titulo        -> grd_4c_ChequeTitulo    (DbTitulo)
3208:     *   grd_che_devolvido -> grd_4c_ChequeDevolvido (dbDevolvido)
3209:     *
3210:     * Os Shapes sao as molduras dos quatro blocos (BackStyle = 0, so a borda) e
3211:     * os dois quadradinhos de 14x14 sao a LEGENDA de cor da grade de cheques em
3212:     * aberto: verde-claro = tem follow-up, vermelho = devolvido.
3213:     *
3214:     * Os campos de total sao somente-leitura no legado (When devolvendo .F.) -
3215:     * aqui vao com ReadOnly = .T., que eh o equivalente sem BINDEVENT em "When".
3216:     *==========================================================================
3217:     PROTECTED PROCEDURE ConfigurarAbaCheques()
3218:         LOCAL loc_oPg, loc_oGrid
3219:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page3
3220: 
3221:         *-- Molduras dos quatro blocos
3222:         THIS.AdicionarMolduraAba(loc_oPg, "shp_4c_ChequeAberto",      61,   8, 479, 129)
3223:         THIS.AdicionarMolduraAba(loc_oPg, "shp_4c_ChequeFollowup",    61, 494, 482, 129)
3224:         THIS.AdicionarMolduraAba(loc_oPg, "shp_4c_ChequeTitulo",     203,   8, 479, 108)
3225:         THIS.AdicionarMolduraAba(loc_oPg, "shp_4c_ChequeDevolvido",  203, 494, 393, 108)
3226:         THIS.AdicionarMolduraAba(loc_oPg, "shp_4c_HistDevolvido",    231, 888, 110,  45)
3227:         THIS.AdicionarMolduraAba(loc_oPg, "shp_4c_ContasReceber",    325, 493, 471, 119)
3228:         THIS.AdicionarMolduraAba(loc_oPg, "shp_4c_ObsNegociados",    325,   8, 479,  67)
3229: 
3230:         *-- Legenda de cor da grade de cheques em aberto
3231:         loc_oPg.AddObject("shp_4c_LegendaDevolvido", "Shape")
3232:         WITH loc_oPg.shp_4c_LegendaDevolvido
3233:             .Top           = 65
3234:             .Left          = 295
3235:             .Width         = 14
3236:             .Height        = 14
3237:             .BackStyle     = 1
3238:             .SpecialEffect = 0
3239:             .BackColor     = RGB(255, 0, 0)
3240:             .Visible       = .T.
3241:         ENDWITH
3242: 
3243:         loc_oPg.AddObject("shp_4c_LegendaFollowup", "Shape")
3244:         WITH loc_oPg.shp_4c_LegendaFollowup
3245:             .Top           = 65
3246:             .Left          = 196
3247:             .Width         = 14
3248:             .Height        = 14
3249:             .BackStyle     = 1
3250:             .SpecialEffect = 0
3251:             .BackColor     = RGB(220, 255, 220)
3252:             .Visible       = .T.
3253:         ENDWITH
3254: 
3255:         *-- Rotulos
3256:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_GrupoCheque",  36,  16,  41, 15, "Grupo : ")
3257:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_ChequeAberto", 65,  11,  97, 15, ;

*-- Linhas 3516 a 3572:
3516:         THIS.AdicionarTotalAba(loc_oPg, "txt_4c_VlEstoque",       390, 841, 115, 23, .T.)
3517:         THIS.AdicionarTotalAba(loc_oPg, "txt_4c_LimiteDisp",      413, 841, 115, 23, .T.)
3518: 
3519:         BINDEVENT(loc_oPg.cbo_4c_GrupoCheque, "InteractiveChange", ;
3520:             THIS, "CboGrupoChequeInteractiveChange")
3521:         BINDEVENT(loc_oPg.grd_4c_ChequeAberto, "AfterRowColChange", ;
3522:             THIS, "GradeChequeAbertoAfterRowColChange")
3523:         BINDEVENT(loc_oPg.grd_4c_ChequeTitulo, "AfterRowColChange", ;
3524:             THIS, "GradeChequeTituloAfterRowColChange")
3525:     ENDPROC
3526: 
3527:     *==========================================================================
3528:     * ConfigurarAbaCartao - Aba 4 (Result.Cartao do legado): moldura, rotulo e
3529:     * a grade dos cartoes de credito em aberto (TmpCart, 6 colunas na ordem de
3530:     * ColumnOrder do dump).
3531:     *==========================================================================
3532:     PROTECTED PROCEDURE ConfigurarAbaCartao()
3533:         LOCAL loc_oPg, loc_oGrid
3534:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page4
3535: 
3536:         THIS.AdicionarMolduraAba(loc_oPg, "shp_4c_CartaoAberto", 56, 132, 735, 274)
3537: 
3538:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_CartaoAberto", 57, 139, 93, 15, ;
3539:             "Cart" + CHR(245) + "es em Aberto")
3540: 
3541:         loc_oPg.AddObject("grd_4c_Cartao", "Grid")
3542:         loc_oGrid = loc_oPg.grd_4c_Cartao
3543:         WITH loc_oGrid
3544:             .Top          = 72
3545:             .Left         = 137
3546:             .Width        = 725
3547:             .Height       = 254
3548:             .FontName     = "Courier New"
3549:             .DeleteMark   = .F.
3550:             .RecordMark   = .F.
3551:             .ReadOnly     = .T.
3552:             .Highlight    = .T.
3553:             .HighlightRow = .T.
3554:             .ScrollBars   = 2
3555:             .RecordSource = "TmpCart"
3556:             .ColumnCount  = 6
3557:             .Themes       = .F.
3558:             .Visible      = .T.
3559: 
3560:             .Columns(1).ControlSource   = "TmpCart.vencs"
3561:             .Columns(1).Header1.Caption = "Vencimento"
3562:             .Columns(1).Width           = 75
3563:             .Columns(1).Alignment       = 0
3564:             .Columns(1).ReadOnly        = .T.
3565: 
3566:             .Columns(2).ControlSource   = "TmpCart.fpags"
3567:             .Columns(2).Header1.Caption = "Cart" + CHR(227) + "o"
3568:             .Columns(2).Width           = 100
3569:             .Columns(2).Alignment       = 0
3570:             .Columns(2).ReadOnly        = .T.
3571: 
3572:             .Columns(3).ControlSource   = "TmpCart.nocreditos"

*-- Linhas 3604 a 3647:
3604:     * nao tem coluna de operacao - eh uma coluna reservada, que o legado
3605:     * tambem mostra vazia.
3606:     *==========================================================================
3607:     PROTECTED PROCEDURE ConfigurarAbaEstoque()
3608:         LOCAL loc_oPg, loc_oGrid
3609:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page6
3610: 
3611:         THIS.AdicionarMolduraAba(loc_oPg, "shp_4c_EstoqueProduto", 86, 303, 392, 361)
3612: 
3613:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_GrupoEstoque", 60, 307, 41, 15, "Grupo : ")
3614: 
3615:         loc_oPg.AddObject("cbo_4c_GrupoEstoque", "ComboBox")
3616:         WITH loc_oPg.cbo_4c_GrupoEstoque
3617:             .Top           = 56
3618:             .Left          = 350
3619:             .Width         = 300
3620:             .Height        = 24
3621:             .Style         = 2
3622:             .RowSourceType = 0
3623:             .FontName      = "Tahoma"
3624:             .FontSize      = 8
3625:             .ForeColor     = RGB(0, 0, 0)
3626:             .BackColor     = RGB(255, 255, 255)
3627:             .Visible       = .T.
3628:         ENDWITH
3629: 
3630:         loc_oPg.AddObject("grd_4c_Estoque", "Grid")
3631:         loc_oGrid = loc_oPg.grd_4c_Estoque
3632:         WITH loc_oGrid
3633:             .Top          = 92
3634:             .Left         = 308
3635:             .Width        = 381
3636:             .Height       = 347
3637:             .FontName     = "Courier New"
3638:             .DeleteMark   = .F.
3639:             .RecordMark   = .F.
3640:             .ReadOnly     = .T.
3641:             .Highlight    = .T.
3642:             .HighlightRow = .T.
3643:             .ScrollBars   = 2
3644:             .RecordSource = "dbEstoque"
3645:             .ColumnCount  = 3
3646:             .Themes       = .F.
3647:             .Visible      = .T.

*-- Linhas 3665 a 3723:
3665:             .Columns(3).ReadOnly        = .T.
3666:         ENDWITH
3667: 
3668:         BINDEVENT(loc_oPg.cbo_4c_GrupoEstoque, "InteractiveChange", ;
3669:             THIS, "CboGrupoEstoqueInteractiveChange")
3670:     ENDPROC
3671: 
3672:     *==========================================================================
3673:     * ConfigurarAbaHCheques - Aba 9 (Result.hcheques do legado - "H.Cheques"):
3674:     * tres grades (GradeCheque/GradeMovimenta/GradeProrrog) e o follow-up da
3675:     * linha corrente, transcritas de mativahcheque()/GradeCheque.
3676:     * AfterRowColChange.
3677:     *
3678:     * Cnt_Descricao e Cnt_periodo existem no dump (ambos Visible = .F.) mas o
3679:     * legado nunca os preenche nem os usa no filtro (regra documentada em
3680:     * CarregarHCheques do BO) - ficam aqui so por fidelidade estrutural,
3681:     * ocultos, sem BINDEVENT.
3682:     *==========================================================================
3683:     PROTECTED PROCEDURE ConfigurarAbaHCheques()
3684:         LOCAL loc_oPg, loc_oGrid
3685:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page9
3686: 
3687:         *-- GradeCheque (dbCheqHist) - historico de cheques da conta
3688:         loc_oPg.AddObject("grd_4c_HistCheque", "Grid")
3689:         loc_oGrid = loc_oPg.grd_4c_HistCheque
3690:         WITH loc_oGrid
3691:             .Top          = 57
3692:             .Left         = 152
3693:             .Width        = 696
3694:             .Height       = 124
3695:             .FontName     = "Courier New"
3696:             .DeleteMark   = .F.
3697:             .RecordMark   = .F.
3698:             .ReadOnly     = .T.
3699:             .Highlight    = .T.
3700:             .HighlightRow = .T.
3701:             .ScrollBars   = 2
3702:             .RecordSource = "dbCheqHist"
3703:             .ColumnCount  = 11
3704:             .Themes       = .F.
3705:             .Visible      = .T.
3706: 
3707:             .Columns(1).ControlSource   = "dbCheqHist.Vencs"
3708:             .Columns(1).Header1.Caption = "Vencimento"
3709:             .Columns(1).Width           = 75
3710:             .Columns(1).ReadOnly        = .T.
3711: 
3712:             .Columns(2).ControlSource   = "dbCheqHist.Bancos"
3713:             .Columns(2).Header1.Caption = "Banco"
3714:             .Columns(2).Width           = 50
3715:             .Columns(2).ReadOnly        = .T.
3716: 
3717:             .Columns(3).ControlSource   = "dbCheqHist.Agencias"
3718:             .Columns(3).Header1.Caption = "Ag" + CHR(234) + "ncia"
3719:             .Columns(3).Width           = 55
3720:             .Columns(3).ReadOnly        = .T.
3721: 
3722:             .Columns(4).ControlSource   = "dbCheqHist.NContas"
3723:             .Columns(4).Header1.Caption = "Conta"

*-- Linhas 3888 a 3931:
3888: 
3889:         *-- Cnt_Descricao / Cnt_periodo - presentes no SCX, ocultos e nunca
3890:         *-- escritos pelo legado (ver comentario de CarregarHCheques no BO);
3891:         *-- ficam so por fidelidade estrutural, sem BINDEVENT.
3892:         loc_oPg.AddObject("cnt_4c_DescricaoCheque", "Container")
3893:         WITH loc_oPg.cnt_4c_DescricaoCheque
3894:             .Top       = 319
3895:             .Left      = 151
3896:             .Width     = 457
3897:             .Height    = 46
3898:             .BackStyle = 0
3899:             .Visible   = .F.
3900:         ENDWITH
3901:         THIS.AdicionarRotuloAba(loc_oPg.cnt_4c_DescricaoCheque, "lbl_4c_Origem", 4, 9, 46, 15, "Origem :")
3902:         THIS.AdicionarRotuloAba(loc_oPg.cnt_4c_DescricaoCheque, "lbl_4c_Destino", 24, 7, 48, 15, "Destino :")
3903:         loc_oPg.cnt_4c_DescricaoCheque.AddObject("txt_4c_DescOrigem", "TextBox")
3904:         WITH loc_oPg.cnt_4c_DescricaoCheque.txt_4c_DescOrigem
3905:             .Top     = 3
3906:             .Left    = 57
3907:             .Width   = 386
3908:             .Height  = 20
3909:             .Value   = ""
3910:             .Visible = .T.
3911:         ENDWITH
3912:         loc_oPg.cnt_4c_DescricaoCheque.AddObject("txt_4c_DescDestino", "TextBox")
3913:         WITH loc_oPg.cnt_4c_DescricaoCheque.txt_4c_DescDestino
3914:             .Top     = 22
3915:             .Left    = 57
3916:             .Width   = 386
3917:             .Height  = 20
3918:             .Value   = ""
3919:             .Visible = .T.
3920:         ENDWITH
3921: 
3922:         loc_oPg.AddObject("cnt_4c_PeriodoCheque", "Container")
3923:         WITH loc_oPg.cnt_4c_PeriodoCheque
3924:             .Top       = 368
3925:             .Left      = 151
3926:             .Width     = 280
3927:             .Height    = 36
3928:             .BackStyle = 0
3929:             .Visible   = .F.
3930:         ENDWITH
3931:         THIS.AdicionarRotuloAba(loc_oPg.cnt_4c_PeriodoCheque, "lbl_4c_PeriodoCheque", 10, 26, 67, 15, "Vencimento : ")

*-- Linhas 3949 a 4001:
3949:             .Visible = .T.
3950:         ENDWITH
3951: 
3952:         BINDEVENT(loc_oPg.grd_4c_HistCheque, "AfterRowColChange", ;
3953:             THIS, "GradeHistChequeAfterRowColChange")
3954:     ENDPROC
3955: 
3956:     *==========================================================================
3957:     * ConfigurarAbaCredito - Aba 10 (Result.Credito do legado): PageFrame
3958:     * PgCredito com a pagina Consultas (Cnt_banco/Cnt_Valor/Grade/Cnt_Docs) e
3959:     * o rotulo de situacao (Label2), transcritos de mativacredito().
3960:     *==========================================================================
3961:     PROTECTED PROCEDURE ConfigurarAbaCredito()
3962:         LOCAL loc_oPg, loc_oCns, loc_oGrid
3963:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page10
3964: 
3965:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_SituacaoCredito", 53, 3, 996, 47, "CLIENTE")
3966:         loc_oPg.lbl_4c_SituacaoCredito.FontName = "Tahoma"
3967:         loc_oPg.lbl_4c_SituacaoCredito.FontSize = 10
3968:         loc_oPg.lbl_4c_SituacaoCredito.FontBold = .T.
3969:         loc_oPg.lbl_4c_SituacaoCredito.ForeColor = RGB(0, 0, 255)
3970: 
3971:         loc_oPg.AddObject("pgf_4c_Credito", "PageFrame")
3972:         WITH loc_oPg.pgf_4c_Credito
3973:             .Top       = 96
3974:             .Left      = 0
3975:             .Width     = 1003
3976:             .Height    = 408
3977:             .PageCount = 1
3978:             .Tabs      = .F.
3979:             .Themes    = .F.
3980:             .Visible   = .T.
3981:             .Page1.Caption = "Consultas"
3982:         ENDWITH
3983:         loc_oCns = loc_oPg.pgf_4c_Credito.Page1
3984: 
3985:         *-- Cnt_banco
3986:         loc_oCns.AddObject("cnt_4c_CreditoBanco", "Container")
3987:         WITH loc_oCns.cnt_4c_CreditoBanco
3988:             .Top       = 273
3989:             .Left      = 170
3990:             .Width     = 479
3991:             .Height    = 40
3992:             .BackStyle = 0
3993:             .Visible   = .T.
3994:         ENDWITH
3995:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoBanco, "lbl_4c_Bco",   1, 6,   30, 15, "Bco")
3996:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoBanco, "lbl_4c_Age",   1, 43,  40, 15, "Ag" + CHR(234) + "ncia")
3997:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoBanco, "lbl_4c_Cta",   1, 95,  40, 15, "Conta")
3998:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoBanco, "lbl_4c_NumI",  1, 173, 65, 15, "Num.Inicial")
3999:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoBanco, "lbl_4c_NumF",  1, 265, 60, 15, "Num.Final")
4000:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoBanco, "lbl_4c_Serie", 1, 357, 40, 15, "S" + CHR(233) + "rie")
4001:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoBanco, "lbl_4c_DtAb",  1, 408, 70, 15, "Dt Abertura")

*-- Linhas 4192 a 4729:
4192:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoDocs, "lbl_4c_TipoDocto", 1, 11, 53, 15, "Tipo Docto")
4193:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoDocs, "lbl_4c_DataDocto", 1, 97, 25, 15, "Data")
4194:         WITH loc_oCns.cnt_4c_CreditoDocs
4195:             .AddObject("obj_4c_OptDocs", "OptionGroup")
4196:             WITH .obj_4c_OptDocs
4197:                 .Top           = 15
4198:                 .Left          = 5
4199:                 .Width         = 89
4200:                 .Height        = 25
4201:                 .ButtonCount   = 2
4202:                 .BackStyle     = 0
4203:                 .BorderStyle   = 0
4204:                 .ControlSource = "dbCredito.NChkDocs"
4205:                 WITH .Buttons(1)
4206:                     .Caption   = "RG"
4207:                     .Top       = 5
4208:                     .Left      = 5
4209:                     .BackStyle = 0
4210:                     .FontSize  = 8
4211:                 ENDWITH
4212:                 WITH .Buttons(2)
4213:                     .Caption   = "CNH"
4214:                     .Top       = 5
4215:                     .Left      = 45
4216:                     .Height    = 15
4217:                     .BackStyle = 0
4218:                     .FontSize  = 8
4219:                 ENDWITH
4220:                 .Visible = .T.
4221:             ENDWITH
4222: 
4223:             .AddObject("txt_4c_DataDoc", "TextBox")
4224:             WITH .txt_4c_DataDoc
4225:                 .Top           = 14
4226:                 .Left          = 95
4227:                 .Width         = 85
4228:                 .Height        = 23
4229:                 .Value         = {}
4230:                 .ControlSource = "dbCredito.TdDocs"
4231:                 .Visible       = .T.
4232:             ENDWITH
4233:         ENDWITH
4234:     ENDPROC
4235: 
4236:     *==========================================================================
4237:     * AdicionarMolduraAba - Shape de moldura (os "Shape" das abas do legado:
4238:     * BackStyle = 0, so a borda cinza). Fabrica usada pelas abas acima para nao
4239:     * repetir o mesmo bloco de nove propriedades em cada moldura.
4240:     *==========================================================================
4241:     PROTECTED PROCEDURE AdicionarMolduraAba(par_oPagina, par_cNome, ;
4242:             par_nTop, par_nLeft, par_nWidth, par_nHeight)
4243: 
4244:         par_oPagina.AddObject(par_cNome, "Shape")
4245: 
4246:         *-- Membro alcancado por NOME: EVALUATE na leitura (regra #15/#34)
4247:         WITH EVALUATE("par_oPagina." + par_cNome)
4248:             .Top         = par_nTop
4249:             .Left        = par_nLeft
4250:             .Width       = par_nWidth
4251:             .Height      = par_nHeight
4252:             .BackStyle   = 0
4253:             .BorderColor = RGB(90, 90, 90)
4254:             .Visible     = .T.
4255:         ENDWITH
4256:     ENDPROC
4257: 
4258:     *==========================================================================
4259:     * AdicionarRotuloAba - Label de dados das abas. ForeColor RGB(90,90,90) (a
4260:     * classe "say" do legado nao declara cor; branco ficaria invisivel sobre a
4261:     * textura clara da Page - regra #12) e AutoSize = .F. com a Width/Height do
4262:     * dump (regra #23: AutoSize eh no-op em Label criado por AddObject).
4263:     *==========================================================================
4264:     PROTECTED PROCEDURE AdicionarRotuloAba(par_oPagina, par_cNome, ;
4265:             par_nTop, par_nLeft, par_nWidth, par_nHeight, par_cCaption)
4266: 
4267:         par_oPagina.AddObject(par_cNome, "Label")
4268: 
4269:         WITH EVALUATE("par_oPagina." + par_cNome)
4270:             .Top       = par_nTop
4271:             .Left      = par_nLeft
4272:             .Width     = par_nWidth
4273:             .Height    = par_nHeight
4274:             .AutoSize  = .F.
4275:             .Alignment = 0
4276:             .FontName  = "Tahoma"
4277:             .FontSize  = 8
4278:             .BackStyle = 0
4279:             .ForeColor = RGB(90, 90, 90)
4280:             .Caption   = par_cCaption
4281:             .Visible   = .T.
4282:         ENDWITH
4283:     ENDPROC
4284: 
4285:     *==========================================================================
4286:     * AdicionarTotalAba - TextBox somente-leitura de total/observacao das abas
4287:     * (os fwget com "When -> RETURN .F." do legado). par_lNumerico diz se o
4288:     * campo mostra valor (InputMask "999,999,999.99", como no dump) ou texto.
4289:     *==========================================================================
4290:     PROTECTED PROCEDURE AdicionarTotalAba(par_oPagina, par_cNome, ;
4291:             par_nTop, par_nLeft, par_nWidth, par_nHeight, par_lNumerico)
4292: 
4293:         par_oPagina.AddObject(par_cNome, "TextBox")
4294: 
4295:         WITH EVALUATE("par_oPagina." + par_cNome)
4296:             .Top           = par_nTop
4297:             .Left          = par_nLeft
4298:             .Width         = par_nWidth
4299:             .Height        = par_nHeight
4300:             .FontName      = "Tahoma"
4301:             .FontSize      = 8
4302:             .ReadOnly      = .T.
4303:             .ForeColor     = RGB(0, 0, 0)
4304:             .BorderColor   = RGB(100, 100, 100)
4305:             .SpecialEffect = 1
4306:             .Visible       = .T.
4307: 
4308:             IF par_lNumerico
4309:                 .Value     = 0
4310:                 .InputMask = "999,999,999.99"
4311:             ELSE
4312:                 .Value     = ""
4313:             ENDIF
4314:         ENDWITH
4315:     ENDPROC
4316: 
4317:     *==========================================================================
4318:     * PreencherComboGrupo - Popula o ComboBox "Grupo :" de uma aba com os
4319:     * grupos presentes no cursor de resultado, no formato do legado
4320:     * ("<codigo com 10> - <descricao>"), e deixa o primeiro selecionado.
4321:     *
4322:     * Equivale ao efeito acumulado das chamadas a Carrega_Combo() que o legado
4323:     * faz dentro do SCAN de carga. PUBLIC: chamado pelos funis de carga e pelo
4324:     * harness de teste.
4325:     *==========================================================================
4326:     PROCEDURE PreencherComboGrupo(par_oCombo, par_cCursorOrigem)
4327:         LOCAL loc_nGrupos, loc_oErro
4328: 
4329:         TRY
4330:             IF VARTYPE(par_oCombo) = "O"
4331:                 par_oCombo.Clear()
4332: 
4333:                 loc_nGrupos = THIS.this_oBusinessObject.CarregarGruposCursor( ;
4334:                     par_cCursorOrigem, "cursor_4c_GruposAba")
4335: 
4336:                 IF loc_nGrupos > 0 AND USED("cursor_4c_GruposAba")
4337:                     SELECT cursor_4c_GruposAba
4338:                     SCAN
4339:                         par_oCombo.AddItem( ;
4340:                             PADR(ALLTRIM(TratarNulo(cursor_4c_GruposAba.Codigos, "")), 10) + ;
4341:                             " - " + ALLTRIM(TratarNulo(cursor_4c_GruposAba.Descrs, "")))
4342:                     ENDSCAN
4343: 
4344:                     IF par_oCombo.ListCount > 0
4345:                         par_oCombo.ListIndex = 1
4346:                     ENDIF
4347:                 ENDIF
4348: 
4349:                 IF USED("cursor_4c_GruposAba")
4350:                     USE IN cursor_4c_GruposAba
4351:                 ENDIF
4352:             ENDIF
4353:         CATCH TO loc_oErro
4354:             MsgErro(loc_oErro.Message + CHR(13) + ;
4355:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
4356:                 "Erro ao montar o filtro de grupo")
4357:         ENDTRY
4358:     ENDPROC
4359: 
4360:     *==========================================================================
4361:     * FiltrarPorGrupo - Aplica em <cursor> o filtro de grupo escolhido no
4362:     * combo, exatamente como o "Set Key To Left(.Value,10)" do legado. O tag de
4363:     * UMA coluna (Grupos) eh usado de proposito: chave parcial sobre indice
4364:     * composto nao casa com SET EXACT ON.
4365:     *
4366:     * Combo vazio (nenhum grupo carregado) limpa o filtro, para a grade nao
4367:     * ficar vazia sem motivo.
4368:     *==========================================================================
4369:     PROTECTED PROCEDURE FiltrarPorGrupo(par_cCursor, par_cValorCombo)
4370:         LOCAL loc_cGrupo
4371: 
4372:         IF !USED(par_cCursor)
4373:             RETURN
4374:         ENDIF
4375: 
4376:         loc_cGrupo = LEFT(IIF(VARTYPE(par_cValorCombo) = "C", par_cValorCombo, ""), 10)
4377: 
4378:         SELECT (par_cCursor)
4379:         SET ORDER TO TAG Grupos
4380:         IF EMPTY(loc_cGrupo)
4381:             SET KEY TO
4382:         ELSE
4383:             SET KEY TO loc_cGrupo
4384:         ENDIF
4385:         GO TOP
4386:     ENDPROC
4387: 
4388:     *==========================================================================
4389:     * AtualizarAbaResultadoAtiva - Despachante UNICO de repintura da pagina
4390:     * Resultado: chama o funil da aba que esta a vista.
4391:     *
4392:     * Existe para que os DOIS caminhos que deixam a aba visivel - a troca de
4393:     * pagina (AlternarPagina(2)) e a troca de aba (OptResultadoInteractiveChange)
4394:     * - repintem exatamente a mesma coisa. Refresh em pagina oculta nao pinta
4395:     * (regra #46), por isso o despachante eh sempre chamado DEPOIS de o
4396:     * ActivePage ja estar trocado.
4397:     *
4398:     * As abas 5, 7, 8, 9 e 10 (Vendas, Operacoes Pend., Producao, Historico
4399:     * de Cheques e Credito) ganham o seu CASE junto com o conteudo delas, na
4400:     * fase seguinte.
4401:     * PUBLIC: chamado de fora (botoes e harness de teste).
4402:     *==========================================================================
4403:     PROCEDURE AtualizarAbaResultadoAtiva()
4404:         LOCAL loc_nAba, loc_oErro
4405: 
4406:         TRY
4407:             loc_nAba = 0
4408:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "pgf_4c_Resultado", 5)
4409:                 loc_nAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.ActivePage
4410:             ENDIF
4411: 
4412:             DO CASE
4413:                 CASE loc_nAba = 1
4414:                     THIS.AtualizarGradesSaldo()
4415:                 CASE loc_nAba = 2
4416:                     THIS.AtualizarGradePendencias()
4417:                 CASE loc_nAba = 3
4418:                     THIS.AtualizarGradesCheques()
4419:                 CASE loc_nAba = 4
4420:                     THIS.AtualizarGradeCartao()
4421:                 CASE loc_nAba = 6
4422:                     THIS.AtualizarGradeEstoque()
4423:                 CASE loc_nAba = 9
4424:                     THIS.AtualizarGradeHCheques()
4425:                 CASE loc_nAba = 10
4426:                     THIS.AtualizarGradeCredito()
4427:             ENDCASE
4428:         CATCH TO loc_oErro
4429:             MsgErro(loc_oErro.Message + CHR(13) + ;
4430:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
4431:                 "Erro ao atualizar a aba de resultado")
4432:         ENDTRY
4433:     ENDPROC
4434: 
4435:     *==========================================================================
4436:     * AtualizarGradePendencias - Funil UNICO de repintura da aba Pendencias
4437:     * (regra #21a: popular cursor nao repinta a grade). Reaplica o filtro de
4438:     * grupo, recalcula o total e so entao da GO TOP + Refresh.
4439:     * PUBLIC: chamado de fora (botoes, combo e harness de teste).
4440:     *==========================================================================
4441:     PROCEDURE AtualizarGradePendencias()
4442:         LOCAL loc_oAba, loc_oErro
4443: 
4444:         TRY
4445:             IF THIS.AbaResultadoDisponivel(2)
4446:                 loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page2
4447: 
4448:                 THIS.FiltrarPorGrupo("TmpPar", loc_oAba.cbo_4c_GrupoPend.Value)
4449:                 THIS.FiltrarTipos()
4450: 
4451:                 IF USED("crTmpTipos")
4452:                     GO TOP IN crTmpTipos
4453:                 ENDIF
4454: 
4455:                 loc_oAba.grd_4c_TiposPend.Refresh()
4456:                 loc_oAba.grd_4c_Pendentes.Refresh()
4457:             ENDIF
4458:         CATCH TO loc_oErro
4459:             MsgErro(loc_oErro.Message + CHR(13) + ;
4460:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
4461:                 "Erro ao atualizar a grade de pend" + CHR(234) + "ncias")
4462:         ENDTRY
4463:     ENDPROC
4464: 
4465:     *==========================================================================
4466:     * FiltrarTipos - FiltraTipos() do legado: monta o filtro de TmpPar com as
4467:     * formas de pagamento MARCADAS em crTmpTipos e atualiza o total.
4468:     *
4469:     * Nenhuma forma marcada deixa a grade vazia de proposito ("Set Filter To
4470:     * 0=1" no legado) - eh o que diz ao usuario que o filtro excluiu tudo.
4471:     * O filtro de grupo (SET KEY) e o de tipos (SET FILTER) sao independentes e
4472:     * convivem, como no legado.
4473:     * PUBLIC: chamado pelos handlers do CheckBox e pelo harness de teste.
4474:     *==========================================================================
4475:     PROCEDURE FiltrarTipos()
4476:         LOCAL loc_cTipos, loc_oAba, loc_oErro
4477: 
4478:         TRY
4479:             IF USED("TmpPar") AND USED("crTmpTipos")
4480:                 loc_cTipos = ""
4481: 
4482:                 SELECT crTmpTipos
4483:                 GO TOP
4484:                 SCAN
4485:                     IF TratarNulo(crTmpTipos.Listas, 0) = 1
4486:                         loc_cTipos = loc_cTipos + ;
4487:                             IIF(EMPTY(loc_cTipos), "fPags = ", " OR fPags = ") + ;
4488:                             CHR(39) + ALLTRIM(TratarNulo(crTmpTipos.fPags, "")) + CHR(39)
4489:                     ENDIF
4490:                 ENDSCAN
4491:                 GO TOP IN crTmpTipos
4492: 
4493:                 SELECT TmpPar
4494:                 IF EMPTY(loc_cTipos)
4495:                     SET FILTER TO 0 = 1
4496:                 ELSE
4497:                     SET FILTER TO &loc_cTipos.
4498:                 ENDIF
4499:                 LOCATE
4500: 
4501:                 IF THIS.AbaResultadoDisponivel(2)
4502:                     loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page2
4503:                     loc_oAba.txt_4c_TotPend.Value = THIS.this_oBusinessObject.TotalPendencias()
4504:                     loc_oAba.txt_4c_TotPend.Refresh()
4505:                 ENDIF
4506:             ENDIF
4507:         CATCH TO loc_oErro
4508:             MsgErro(loc_oErro.Message + CHR(13) + ;
4509:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
4510:                 "Erro ao filtrar as formas de pagamento")
4511:         ENDTRY
4512:     ENDPROC
4513: 
4514:     *==========================================================================
4515:     * ChkTipoPendKeyPress - Alterna a marca da forma de pagamento por TECLADO
4516:     * (Enter/Espaco), como o KeyPress do Check1 do legado. O NODEFAULT suprime
4517:     * o toggle nativo para o valor nao ser alternado duas vezes.
4518:     * PUBLIC: alvo de BINDEVENT (regra #3).
4519:     *==========================================================================
4520:     PROCEDURE ChkTipoPendKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4521:         IF INLIST(par_nKeyCode, 13, 32) AND USED("crTmpTipos") AND !EOF("crTmpTipos")
4522:             REPLACE crTmpTipos.Listas ;
4523:                 WITH IIF(TratarNulo(crTmpTipos.Listas, 0) = 0, 1, 0) IN crTmpTipos
4524: 
4525:             IF THIS.AbaResultadoDisponivel(2)
4526:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page2.grd_4c_TiposPend.Refresh()
4527:             ENDIF
4528: 
4529:             THIS.FiltrarTipos()
4530:             THIS.AtualizarGradePendencias()
4531:             NODEFAULT
4532:         ENDIF
4533:     ENDPROC
4534: 
4535:     *==========================================================================
4536:     * ChkTipoPendMouseUp - Alterna a marca por CLIQUE, delegando ao mesmo
4537:     * handler do teclado (MouseUp do Check1 legado: This.KeyPress(13,0)).
4538:     *==========================================================================
4539:     PROCEDURE ChkTipoPendMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
4540:         THIS.ChkTipoPendKeyPress(13, 0)
4541:         NODEFAULT
4542:     ENDPROC
4543: 
4544:     *==========================================================================
4545:     * ChkTipoPendMouseDown - Suprime o toggle nativo do CheckBox (NoDefault do
4546:     * MouseDown legado): quem alterna o valor eh o MouseUp/KeyPress.
4547:     *==========================================================================
4548:     PROCEDURE ChkTipoPendMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
4549:         NODEFAULT
4550:     ENDPROC
4551: 
4552:     *==========================================================================
4553:     * ChkTipoPendClick - Suprime o Click nativo (NoDefault do Click legado),
4554:     * pela mesma razao do MouseDown.
4555:     *==========================================================================
4556:     PROCEDURE ChkTipoPendClick()
4557:         NODEFAULT
4558:     ENDPROC
4559: 
4560:     *==========================================================================
4561:     * CboGrupoPendInteractiveChange - Cmb_Grupo.InteractiveChange da aba
4562:     * Pendencias: aplica o filtro de grupo, recalcula o total e repinta.
4563:     *==========================================================================
4564:     PROCEDURE CboGrupoPendInteractiveChange()
4565:         THIS.AtualizarGradePendencias()
4566:     ENDPROC
4567: 
4568:     *==========================================================================
4569:     * BtnAnexaPendClick - Anexa.Click da aba Pendencias: abre o documento da
4570:     * pendencia selecionada (FormSigMvExp, o SigMvExp do legado).
4571:     *
4572:     * A condicao que o legado usava para HABILITAR o botao (linha valida, com
4573:     * Dopes e Numes) vive aqui dentro: botao icone-only desabilitado em runtime
4574:     * perde o icone, por isso ele fica sempre ativo e avisa quando a linha
4575:     * corrente nao tem documento.
4576:     *==========================================================================
4577:     PROCEDURE BtnAnexaPendClick()
4578:         LOCAL loc_oForm, loc_oErro
4579: 
4580:         IF !USED("TmpPar") OR EOF("TmpPar") OR ;
4581:            EMPTY(TratarNulo(TmpPar.dopes, "")) OR TratarNulo(TmpPar.numes, 0) = 0
4582:             MsgAviso("Selecione uma pend" + CHR(234) + "ncia com documento para " + ;
4583:                 "consultar.", "Documento")
4584:             RETURN
4585:         ENDIF
4586: 
4587:         loc_oForm = .NULL.
4588:         TRY
4589:             loc_oForm = CREATEOBJECT("FormSigMvExp", ;
4590:                 ALLTRIM(TmpPar.dopes), "C", TmpPar.numes, ALLTRIM(TmpPar.emps), .T.)
4591:         CATCH TO loc_oErro
4592:             MostrarErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel abrir o " + ;
4593:                 "documento:" + CHR(13) + loc_oErro.Message, "Documento")
4594:             loc_oForm = .NULL.
4595:         ENDTRY
4596: 
4597:         *-- Show() de form modal FORA do TRY (regra #29)
4598:         IF VARTYPE(loc_oForm) = "O"
4599:             loc_oForm.Show()
4600:         ENDIF
4601:     ENDPROC
4602: 
4603:     *==========================================================================
4604:     * BtnImpPendClick - CmdImpPend.Click da aba Pendencias: listagem das
4605:     * pendencias visiveis (Report Form SigReIpd do legado).
4606:     *
4607:     * O cursor crImpPend tem a MESMA estrutura que o legado monta antes do
4608:     * REPORT FORM, e o relatorio roda pelo helper canonico de impressao
4609:     * (isolamento de locale + guard de FRX ausente + restauracao do menu).
4610:     *==========================================================================
4611:     PROCEDURE BtnImpPendClick()
4612:         LOCAL loc_cConta, loc_cNome, loc_cGrupo, loc_nTotal, loc_oAba
4613:         LOCAL loc_lTemLinha, loc_oErro
4614: 
4615:         TRY
4616:             IF !USED("TmpPar")
4617:                 MsgAviso("Nenhuma pend" + CHR(234) + "ncia a listar.", "Listagem")
4618:             ELSE
4619:                 loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page2
4620:                 loc_cGrupo = "G" + LEFT(loc_oAba.cbo_4c_GrupoPend.Value, 10)
4621:                 loc_cConta = ALLTRIM(THIS.this_oBusinessObject.this_cConta)
4622:                 loc_cNome  = ALLTRIM(THIS.this_oBusinessObject.this_cDescConta)
4623:                 loc_nTotal = THIS.this_oBusinessObject.TotalPendencias()
4624: 
4625:                 IF USED("crImpPend")
4626:                     USE IN crImpPend
4627:                 ENDIF
4628:                 CREATE CURSOR crImpPend (Tipo N(1), EmpDopNums C(29), Conta C(10), ;
4629:                     rClis C(40), Emps C(3), Dopes C(20), Numes N(6), Grupo C(10), ;
4630:                     Datas D, cPros C(14), dPros C(40), Qtds N(9,3), cUnis C(3), ;
4631:                     Units N(11,2), Totas N(11,2), TotGeral N(13,2), Grupos C(40))
4632: 
4633:                 loc_lTemLinha = .F.
4634:                 SELECT TmpPar
4635:                 GO TOP
4636:                 SCAN
4637:                     INSERT INTO crImpPend ;
4638:                         (Tipo, Conta, rClis, Emps, Dopes, Numes, Grupo, Datas, ;
4639:                          dPros, Totas, TotGeral, Grupos) ;
4640:                         VALUES ;
4641:                         (0, loc_cConta, LEFT(loc_cNome, 40), ;
4642:                          TratarNulo(TmpPar.emps, ""), ;
4643:                          TratarNulo(TmpPar.dopes, ""), ;
4644:                          TratarNulo(TmpPar.numes, 0), ;
4645:                          TratarNulo(TmpPar.grupos, ""), ;
4646:                          ConverterParaData(TmpPar.vencs), ;
4647:                          LEFT(TratarNulo(TmpPar.hists, ""), 40), ;
4648:                          TratarNulo(TmpPar.valos, 0), ;
4649:                          loc_nTotal, ;
4650:                          LEFT(loc_cGrupo, 40))
4651:                     loc_lTemLinha = .T.
4652:                 ENDSCAN
4653:                 GO TOP IN TmpPar
4654: 
4655:                 IF !loc_lTemLinha
4656:                     MsgAviso("Nenhuma pend" + CHR(234) + "ncia a listar.", "Listagem")
4657:                 ELSE
4658:                     SELECT crImpPend
4659:                     GO TOP
4660:                     THIS.ImprimirListagem("SigReIpd", "crImpPend")
4661:                 ENDIF
4662:             ENDIF
4663:         CATCH TO loc_oErro
4664:             MsgErro(loc_oErro.Message + CHR(13) + ;
4665:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
4666:                 "Erro ao listar as pend" + CHR(234) + "ncias")
4667:         ENDTRY
4668:     ENDPROC
4669: 
4670:     *==========================================================================
4671:     * ImprimirListagem - Helper canonico de REPORT FORM: resolve o caminho do
4672:     * FRX em gc_4c_CaminhoReports, avisa quando o arquivo nao existe (em vez de
4673:     * estourar sem dizer qual), isola o locale (SET POINT/SEPARATOR/
4674:     * REPORTBEHAVIOR, que os FRX Fortyus exigem para nao imprimir "*****" nos
4675:     * numericos) e restaura o menu, que o preview do VFP9 corrompe.
4676:     *==========================================================================
4677:     PROTECTED PROCEDURE ImprimirListagem(par_cRelatorioBase, par_cCursorDados)
4678:         LOCAL loc_cFrx, loc_cPonto, loc_cSeparador, loc_nBehavior, loc_oErro
4679: 
4680:         loc_cFrx = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")
4681: 
4682:         IF !FILE(loc_cFrx)
4683:             MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
4684:                 "o encontrado:" + CHR(13) + loc_cFrx, "Listagem")
4685:             RETURN
4686:         ENDIF
4687: 
4688:         IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
4689:             MsgAviso("Nenhum registro encontrado com os filtros informados.", "Listagem")
4690:             RETURN
4691:         ENDIF
4692: 
4693:         loc_cPonto     = SET("Point")
4694:         loc_cSeparador = SET("Separator")
4695:         loc_nBehavior  = SET("REPORTBEHAVIOR")
4696: 
4697:         TRY
4698:             SET POINT TO "."
4699:             SET SEPARATOR TO ","
4700:             SET REPORTBEHAVIOR 80
4701: 
4702:             SELECT (par_cCursorDados)
4703:             GO TOP
4704: 
4705:             REPORT FORM (loc_cFrx) TO PRINTER PROMPT PREVIEW
4706:         CATCH TO loc_oErro
4707:             MostrarErro("Erro ao gerar a listagem:" + CHR(13) + loc_oErro.Message, ;
4708:                 "Listagem")
4709:         FINALLY
4710:             SET POINT TO loc_cPonto
4711:             SET SEPARATOR TO loc_cSeparador
4712:             SET REPORTBEHAVIOR loc_nBehavior
4713:         ENDTRY
4714: 
4715:         *-- O preview do VFP9 corrompe _MSYSMENU: devolver o menu do sistema
4716:         TRY
4717:             SET SYSMENU TO DEFAULT
4718:             RELEASE POPUP popArquivo, popCadastros, popMovimentos, ;
4719:                 popRelatorios, popFerramentas, popAjuda
4720:             CriarMenuPrincipal()
4721:         CATCH TO loc_oErro
4722:             *-- Menu ausente (form aberto fora do menu principal ou em teste)
4723:             *-- nao eh erro de negocio
4724:         ENDTRY
4725:     ENDPROC
4726: 
4727:     *==========================================================================
4728:     * ImpressaoCad - ImpressaoCad() do legado: monta _varRB/_varH (os dois
4729:     * memos que o SigReGcd.frx exibe nos blocos de Referencias Bancarias e

*-- Linhas 4740 a 4792:
4740:     * Sem essa infraestrutura de hardware o caminho correto eh avisar, nao
4741:     * fingir sucesso silencioso.
4742:     *==========================================================================
4743:     PROTECTED PROCEDURE ImpressaoCad(par_cSaida, par_lGenerico, par_lPessoais, ;
4744:             par_lBancarias, par_lFollowup, par_lTermica)
4745:         LOCAL loc_cConta, loc_cSQL, loc_oErro
4746:         LOCAL _varRB, _varH
4747: 
4748:         *-- Guard de parametro FORA do TRY: com o RETURN dentro do bloco ele
4749:         *-- violaria a regra #1 (nunca RETURN dentro de TRY/CATCH), e aqui nao
4750:         *-- ha o que proteger - a condicao le apenas os parametros recebidos
4751:         IF par_lTermica AND par_cSaida != "V"
4752:             MsgAviso("Impress" + CHR(227) + "o em impressora t" + CHR(233) + ;
4753:                 "rmica de 40 colunas n" + CHR(227) + "o est" + CHR(225) + ;
4754:                 " dispon" + CHR(237) + "vel neste sistema." + CHR(13) + ;
4755:                 "Use a op" + CHR(231) + CHR(227) + "o V" + CHR(237) + "deo ou " + ;
4756:                 "desmarque " + CHR(34) + "Impressora 40 colunas" + CHR(34) + ".", ;
4757:                 "Impress" + CHR(227) + "o")
4758:             RETURN
4759:         ENDIF
4760: 
4761:         TRY
4762:             loc_cConta = ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.txt_4c_Conta.Value)
4763: 
4764:             _varRB = ""
4765:             _varH  = ""
4766: 
4767:             IF par_lBancarias
4768:                 IF USED("crSigCdCeb")
4769:                     USE IN crSigCdCeb
4770:                 ENDIF
4771:                 loc_cSQL = "SELECT nbancos, bancos, nagencias, agencias, btels, ramals" + ;
4772:                     " FROM SigCdCeb WHERE iclis = " + EscaparSQL(loc_cConta)
4773:                 SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdCeb")
4774: 
4775:                 IF USED("crSigCdCeb")
4776:                     SELECT crSigCdCeb
4777:                     IF EOF()
4778:                         _varRB = "N" + CHR(227) + "o Constam Refer" + CHR(234) + ;
4779:                             "ncias Bancarias Referentes ao Cliente!"
4780:                     ELSE
4781:                         SCAN
4782:                             _varRB = _varRB + TratarNulo(nbancos, "") + " " + ;
4783:                                 LEFT(TratarNulo(bancos, ""), 22) + " " + ;
4784:                                 TratarNulo(nagencias, "") + " " + ;
4785:                                 LEFT(TratarNulo(agencias, ""), 22) + " " + ;
4786:                                 TratarNulo(btels, "") + " " + TratarNulo(ramals, "")
4787:                         ENDSCAN
4788:                     ENDIF
4789:                     USE IN crSigCdCeb
4790:                 ENDIF
4791:             ENDIF
4792: 

*-- Linhas 4853 a 4905:
4853:     * impressoras do legado (gaprinters/SigOpIbo), o caminho termico vira
4854:     * aviso em vez de ficar calado.
4855:     *==========================================================================
4856:     PROTECTED PROCEDURE Impressao(par_cSaida, par_lSaldo, par_lLimite, ;
4857:             par_lChequePend, par_lChequeDev, par_lChequeDep, par_lCartao, ;
4858:             par_lPend, par_lOper, par_lTermica, par_lChqNeg, par_lResVenda, ;
4859:             par_lProdutos, par_lProducao, par_lEstoque)
4860:         LOCAL loc_cConta, loc_cSQL, loc_nValTipo, loc_cCabTipo, loc_oErro
4861:         LOCAL loc_dDtIni, loc_dDtFim
4862: 
4863:         *-- Guard de parametro FORA do TRY (regra #1, igual ao ImpressaoCad)
4864:         IF par_lTermica AND par_cSaida != "V"
4865:             MsgAviso("Impress" + CHR(227) + "o em impressora t" + CHR(233) + ;
4866:                 "rmica de 40 colunas n" + CHR(227) + "o est" + CHR(225) + ;
4867:                 " dispon" + CHR(237) + "vel neste sistema." + CHR(13) + ;
4868:                 "Use a op" + CHR(231) + CHR(227) + "o V" + CHR(237) + "deo ou " + ;
4869:                 "desmarque " + CHR(34) + "Impressora 40 colunas" + CHR(34) + ".", ;
4870:                 "Impress" + CHR(227) + "o")
4871:             RETURN
4872:         ENDIF
4873: 
4874:         TRY
4875:             loc_cConta = ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.txt_4c_Conta.Value)
4876: 
4877:             IF USED("TmpRelGv")
4878:                 USE IN TmpRelGv
4879:             ENDIF
4880:             CREATE CURSOR TmpRelGv (ValTipo N(3), CabTipo C(70), Grupo C(10), ;
4881:                 Valor N(12,2), Moeda C(3), Data D, Descricao C(50), Observa C(76), ;
4882:                 Opers C(1), ValoPg N(12,2), Saldo N(12,2), Cpros C(14), DPros C(40), ;
4883:                 Numes N(6), Dopes C(20), PrazoEnts D, Fase C(10), Qtds N(9,2), ;
4884:                 Nenvs N(10), Nops N(10), xPer N(6,2), Emps C(3), Pesos N(9,2), ;
4885:                 Cbars N(14), Reffs C(40), Colecoes C(10), Anos C(4), Meses C(2))
4886:             INDEX ON STR(ValTipo, 3) + Anos + Meses + Grupo TAG ValGrupo
4887: 
4888:             IF USED("TmpTotal")
4889:                 USE IN TmpTotal
4890:             ENDIF
4891:             CREATE CURSOR TmpTotal (Moeda C(3), Valor N(12,2))
4892:             INDEX ON Moeda TAG Moeda
4893: 
4894:             *-- (1) Saldo de Conta Corrente
4895:             IF par_lSaldo
4896:                 loc_nValTipo = 1
4897:                 loc_cCabTipo = "Saldos de Conta Corrente"
4898:                 IF USED("dbSaldo")
4899:                     SELECT dbSaldo
4900:                     GO TOP
4901:                     IF !EOF()
4902:                         SCAN
4903:                             INSERT INTO TmpRelGv (CabTipo, ValTipo, Grupo, Valor, Moeda) ;
4904:                                 VALUES (loc_cCabTipo, loc_nValTipo, dbSaldo.grupos, ;
4905:                                     dbSaldo.saldos, dbSaldo.moedas)

*-- Linhas 5284 a 5649:
5284:             SELECT TmpRelGv
5285:             GO TOP
5286:             IF EOF()
5287:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " dados para imprimir...", ;
5288:                     "Impress" + CHR(227) + "o")
5289:             ELSE
5290:                 THIS.ImprimirListagem("SIGOPCGV", "TmpRelGv")
5291:             ENDIF
5292: 
5293:             IF USED("TmpRelGv")
5294:                 USE IN TmpRelGv
5295:             ENDIF
5296:             IF USED("TmpTotal")
5297:                 USE IN TmpTotal
5298:             ENDIF
5299:         CATCH TO loc_oErro
5300:             MsgErro(loc_oErro.Message + CHR(13) + ;
5301:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
5302:                 "Erro ao gerar a impress" + CHR(227) + "o")
5303:         ENDTRY
5304:     ENDPROC
5305: 
5306:     *==========================================================================
5307:     * AtualizarGradesCheques - Funil UNICO de repintura da aba Cheques: aplica
5308:     * o filtro de grupo nas duas grades filtraveis, espelha os totais do BO nos
5309:     * campos somente-leitura e repinta as quatro grades.
5310:     * PUBLIC: chamado de fora (combo, carga e harness de teste).
5311:     *==========================================================================
5312:     PROCEDURE AtualizarGradesCheques()
5313:         LOCAL loc_oAba, loc_oErro
5314: 
5315:         TRY
5316:             IF THIS.AbaResultadoDisponivel(3)
5317:                 loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page3
5318: 
5319:                 THIS.FiltrarPorGrupo("dbAberto",    loc_oAba.cbo_4c_GrupoCheque.Value)
5320:                 THIS.FiltrarPorGrupo("dbDevolvido", loc_oAba.cbo_4c_GrupoCheque.Value)
5321: 
5322:                 IF USED("DbTitulo")
5323:                     GO TOP IN DbTitulo
5324:                 ENDIF
5325:                 IF USED("DbFollow")
5326:                     GO TOP IN DbFollow
5327:                 ENDIF
5328: 
5329:                 THIS.PreencherTotaisCheques()
5330: 
5331:                 loc_oAba.grd_4c_ChequeAberto.Refresh()
5332:                 loc_oAba.grd_4c_ChequeFollowup.Refresh()
5333:                 loc_oAba.grd_4c_ChequeTitulo.Refresh()
5334:                 loc_oAba.grd_4c_ChequeDevolvido.Refresh()
5335:             ENDIF
5336:         CATCH TO loc_oErro
5337:             MsgErro(loc_oErro.Message + CHR(13) + ;
5338:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
5339:                 "Erro ao atualizar as grades de cheques")
5340:         ENDTRY
5341:     ENDPROC
5342: 
5343:     *==========================================================================
5344:     * PreencherTotaisCheques - Espelha nos campos somente-leitura da aba
5345:     * Cheques os totais calculados pelo BO (o fim do Processa() legado), mais o
5346:     * total da grade de devolvidos, que o legado recalcula a cada troca de
5347:     * grupo no Cmb_Grupo.InteractiveChange.
5348:     *
5349:     * "Limite Disponivel" sai em VERMELHO quando negativo e AZUL quando
5350:     * positivo, como no legado.
5351:     *==========================================================================
5352:     PROCEDURE PreencherTotaisCheques()
5353:         LOCAL loc_oAba, loc_oBO, loc_nTotDev, loc_cMoeda, loc_oErro
5354: 
5355:         TRY
5356:             IF THIS.AbaResultadoDisponivel(3) AND VARTYPE(THIS.this_oBusinessObject) = "O"
5357:                 loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page3
5358:                 loc_oBO  = THIS.this_oBusinessObject
5359: 
5360:                 loc_oAba.txt_4c_LimiteCred.Value  = loc_oBO.this_nLimiteCredito
5361:                 loc_oAba.txt_4c_ChqAVencer.Value  = loc_oBO.this_nChequesAVencer
5362:                 loc_oAba.txt_4c_ChqVencidos.Value = loc_oBO.this_nChequesVencidos
5363:                 loc_oAba.txt_4c_ChqDevolv.Value   = loc_oBO.this_nChequesDevolvidos
5364:                 loc_oAba.txt_4c_SaldoCC.Value     = loc_oBO.this_nSaldoContaCorrente
5365:                 loc_oAba.txt_4c_ChqNegoc.Value    = loc_oBO.this_nChequesNegociados
5366:                 loc_oAba.txt_4c_VlEstoque.Value   = loc_oBO.this_nValorEstoque
5367:                 loc_oAba.txt_4c_LimiteDisp.Value  = loc_oBO.this_nLimiteDisponivel
5368: 
5369:                 loc_oAba.txt_4c_LimiteDisp.ForeColor = ;
5370:                     IIF(loc_oBO.this_nLimiteDisponivel < 0, RGB(255, 0, 0), RGB(0, 0, 255))
5371: 
5372:                 loc_oAba.txt_4c_TotChequeAberto.Value = loc_oBO.this_nTotalChequeAberto
5373: 
5374:                 *-- Total dos devolvidos VISIVEIS (respeita o filtro de grupo)
5375:                 loc_nTotDev = 0
5376:                 IF USED("dbDevolvido")
5377:                     SELECT dbDevolvido
5378:                     SUM dbDevolvido.valors TO loc_nTotDev
5379:                     GO TOP IN dbDevolvido
5380:                 ENDIF
5381:                 loc_oAba.txt_4c_TotDevolvido.Value = loc_nTotDev
5382: 
5383:                 *-- Moeda do limite de credito nos dois rotulos "R$" do legado
5384:                 loc_cMoeda = ALLTRIM(loc_oBO.this_cMoedaPadrao)
5385:                 IF !EMPTY(loc_cMoeda)
5386:                     loc_oAba.lbl_4c_MoedaConta.Caption = loc_cMoeda
5387:                     loc_oAba.lbl_4c_MoedaHist.Caption  = loc_cMoeda
5388:                 ENDIF
5389: 
5390:                 loc_oAba.Refresh()
5391:             ENDIF
5392:         CATCH TO loc_oErro
5393:             MsgErro(loc_oErro.Message + CHR(13) + ;
5394:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
5395:                 "Erro ao exibir os totais de cheques")
5396:         ENDTRY
5397:     ENDPROC
5398: 
5399:     *==========================================================================
5400:     * CboGrupoChequeInteractiveChange - Cmb_Grupo.InteractiveChange da aba
5401:     * Cheques: refaz o filtro de grupo, os totais e a repintura.
5402:     *==========================================================================
5403:     PROCEDURE CboGrupoChequeInteractiveChange()
5404:         THIS.AtualizarGradesCheques()
5405:     ENDPROC
5406: 
5407:     *==========================================================================
5408:     * GradeChequeAbertoAfterRowColChange - grd_che_aberto.AfterRowColChange do
5409:     * legado: o follow-up exibido eh o do cheque da linha corrente.
5410:     *
5411:     * Sem filtro de coluna de proposito: aqui o AfterRowColChange eh usado para
5412:     * carregar o DETALHE da linha corrente (uso correto do evento), nao para
5413:     * validar celula.
5414:     *==========================================================================
5415:     PROCEDURE GradeChequeAbertoAfterRowColChange(par_nColIndex)
5416:         LOCAL loc_oAba, loc_oErro
5417: 
5418:         TRY
5419:             IF USED("DbFollow") AND USED("dbAberto") AND THIS.AbaResultadoDisponivel(3)
5420:                 loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page3
5421: 
5422:                 SELECT DbFollow
5423:                 SET ORDER TO TAG Nums
5424:                 IF EOF("dbAberto") OR EMPTY(TratarNulo(dbAberto.Nums, ""))
5425:                     SET KEY TO
5426:                 ELSE
5427:                     SET KEY TO PADR(ALLTRIM(dbAberto.Nums), 8)
5428:                 ENDIF
5429:                 GO TOP
5430: 
5431:                 loc_oAba.grd_4c_ChequeFollowup.Refresh()
5432:                 SELECT dbAberto
5433:             ENDIF
5434:         CATCH TO loc_oErro
5435:             MsgErro(loc_oErro.Message + CHR(13) + ;
5436:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
5437:                 "Erro ao exibir o follow-up do cheque")
5438:         ENDTRY
5439:     ENDPROC
5440: 
5441:     *==========================================================================
5442:     * GradeChequeTituloAfterRowColChange - Grd_titulo.AfterRowColChange do
5443:     * legado: a observacao do titulo corrente vai para os dois campos de
5444:     * observacao (o legado parte o historico de 40 em duas metades de 20).
5445:     *==========================================================================
5446:     PROCEDURE GradeChequeTituloAfterRowColChange(par_nColIndex)
5447:         LOCAL loc_oAba, loc_cHists, loc_oErro
5448: 
5449:         TRY
5450:             IF USED("DbTitulo") AND THIS.AbaResultadoDisponivel(3)
5451:                 loc_oAba   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page3
5452:                 loc_cHists = IIF(EOF("DbTitulo"), "", TratarNulo(DbTitulo.Hists, ""))
5453: 
5454:                 loc_oAba.txt_4c_ObsNegoc1.Value = LEFT(loc_cHists, 20)
5455:                 loc_oAba.txt_4c_ObsNegoc2.Value = RIGHT(loc_cHists, 20)
5456:                 loc_oAba.txt_4c_ObsNegoc1.Refresh()
5457:                 loc_oAba.txt_4c_ObsNegoc2.Refresh()
5458:             ENDIF
5459:         CATCH TO loc_oErro
5460:             MsgErro(loc_oErro.Message + CHR(13) + ;
5461:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
5462:                 "Erro ao exibir a observa" + CHR(231) + CHR(227) + "o do t" + ;
5463:                 CHR(237) + "tulo")
5464:         ENDTRY
5465:     ENDPROC
5466: 
5467:     *==========================================================================
5468:     * AtualizarGradeCartao - Funil UNICO de repintura da aba Cartao.
5469:     * PUBLIC: chamado de fora (carga e harness de teste).
5470:     *==========================================================================
5471:     PROCEDURE AtualizarGradeCartao()
5472:         LOCAL loc_oErro
5473: 
5474:         TRY
5475:             IF THIS.AbaResultadoDisponivel(4)
5476:                 IF USED("TmpCart")
5477:                     GO TOP IN TmpCart
5478:                 ENDIF
5479:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page4.grd_4c_Cartao.Refresh()
5480:             ENDIF
5481:         CATCH TO loc_oErro
5482:             MsgErro(loc_oErro.Message + CHR(13) + ;
5483:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
5484:                 "Erro ao atualizar a grade de cart" + CHR(245) + "es")
5485:         ENDTRY
5486:     ENDPROC
5487: 
5488:     *==========================================================================
5489:     * AtualizarGradeEstoque - Funil UNICO de repintura da aba Estoque: aplica o
5490:     * filtro de grupo e repinta.
5491:     * PUBLIC: chamado de fora (combo, carga e harness de teste).
5492:     *==========================================================================
5493:     PROCEDURE AtualizarGradeEstoque()
5494:         LOCAL loc_oAba, loc_oErro
5495: 
5496:         TRY
5497:             IF THIS.AbaResultadoDisponivel(6)
5498:                 loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page6
5499:                 THIS.FiltrarPorGrupo("dbEstoque", loc_oAba.cbo_4c_GrupoEstoque.Value)
5500:                 loc_oAba.grd_4c_Estoque.Refresh()
5501:             ENDIF
5502:         CATCH TO loc_oErro
5503:             MsgErro(loc_oErro.Message + CHR(13) + ;
5504:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
5505:                 "Erro ao atualizar a grade de estoque")
5506:         ENDTRY
5507:     ENDPROC
5508: 
5509:     *==========================================================================
5510:     * CboGrupoEstoqueInteractiveChange - Cmb_Grupo.InteractiveChange da aba
5511:     * Estoque.
5512:     *==========================================================================
5513:     PROCEDURE CboGrupoEstoqueInteractiveChange()
5514:         THIS.AtualizarGradeEstoque()
5515:     ENDPROC
5516: 
5517:     *==========================================================================
5518:     * AtualizarGradeHCheques - Funil UNICO de repintura da aba H.Cheques
5519:     * (regra #21a). GO TOP nos tres cursores + Refresh das tres grades.
5520:     * PUBLIC: chamado de fora (carga, grid e harness de teste).
5521:     *==========================================================================
5522:     PROCEDURE AtualizarGradeHCheques()
5523:         LOCAL loc_oAba, loc_oErro
5524: 
5525:         TRY
5526:             IF THIS.AbaResultadoDisponivel(9)
5527:                 loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page9
5528: 
5529:                 IF USED("dbCheqHist")
5530:                     SELECT dbCheqHist
5531:                     GO TOP
5532:                 ENDIF
5533:                 IF USED("dbCheqMovim")
5534:                     SELECT dbCheqMovim
5535:                     GO TOP
5536:                 ENDIF
5537:                 IF USED("dbCheqProrrog")
5538:                     SELECT dbCheqProrrog
5539:                     GO TOP
5540:                 ENDIF
5541: 
5542:                 loc_oAba.grd_4c_HistCheque.Refresh()
5543:                 loc_oAba.grd_4c_MovCheque.Refresh()
5544:                 loc_oAba.grd_4c_ProrrogCheque.Refresh()
5545: 
5546:                 loc_oAba.cnt_4c_Followup.txt_4c_UltFollowup.Value = ;
5547:                     TratarNulo(THIS.this_oBusinessObject.this_cFollowUpCheque, "")
5548:             ENDIF
5549:         CATCH TO loc_oErro
5550:             MsgErro(loc_oErro.Message + CHR(13) + ;
5551:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
5552:                 "Erro ao atualizar a grade de hist" + CHR(243) + "rico de cheques")
5553:         ENDTRY
5554:     ENDPROC
5555: 
5556:     *==========================================================================
5557:     * GradeHistChequeAfterRowColChange - Transcricao do AfterRowColChange da
5558:     * GradeCheque do legado (aba H.Cheques): ao mudar de linha, recarrega a
5559:     * movimentacao/prorrogacoes/follow-up do cheque agora selecionado e
5560:     * atualiza o Caption do form com o cliente da conta (todas as linhas desta
5561:     * grade pertencem a mesma conta pesquisada - this_cDescConta/this_cCpf ja
5562:     * carregados, sem precisar reconsultar SigCdCli a cada linha).
5563:     * PUBLIC: ligado via BINDEVENT.
5564:     *==========================================================================
5565:     PROCEDURE GradeHistChequeAfterRowColChange(par_nColIndex)
5566:         LOCAL loc_oAba, loc_oBO, loc_cNums, loc_oErro
5567: 
5568:         TRY
5569:             loc_oBO = THIS.this_oBusinessObject
5570:             IF VARTYPE(loc_oBO) = "O" AND USED("dbCheqHist") AND RECCOUNT("dbCheqHist") > 0
5571:                 loc_cNums = ALLTRIM(dbCheqHist.Nums)
5572: 
5573:                 IF !EMPTY(loc_cNums)
5574:                     THIS.Caption = "Hist" + CHR(243) + "rico de Cheques de: " + ;
5575:                         ALLTRIM(loc_oBO.this_cConta) + " - " + ;
5576:                         ALLTRIM(loc_oBO.this_cDescConta) + " / " + ALLTRIM(loc_oBO.this_cCpf)
5577: 
5578:                     loc_oBO.CarregarMovimentoCheque(loc_cNums)
5579: 
5580:                     IF THIS.AbaResultadoDisponivel(9)
5581:                         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page9
5582: 
5583:                         SELECT dbCheqMovim
5584:                         GO TOP
5585:                         loc_oAba.grd_4c_MovCheque.Refresh()
5586: 
5587:                         SELECT dbCheqProrrog
5588:                         GO TOP
5589:                         loc_oAba.grd_4c_ProrrogCheque.Refresh()
5590: 
5591:                         loc_oAba.cnt_4c_Followup.txt_4c_UltFollowup.Value = ;
5592:                             TratarNulo(loc_oBO.this_cFollowUpCheque, "")
5593:                     ENDIF
5594:                 ENDIF
5595:             ENDIF
5596:         CATCH TO loc_oErro
5597:             MsgErro(loc_oErro.Message + CHR(13) + ;
5598:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
5599:                 "Erro ao atualizar a movimenta" + CHR(231) + CHR(227) + "o do cheque")
5600:         ENDTRY
5601:     ENDPROC
5602: 
5603:     *==========================================================================
5604:     * AtualizarGradeCredito - Funil UNICO de repintura da aba Credito: GO TOP
5605:     * + Refresh da grade e o rotulo colorido de situacao do cliente (Label2 do
5606:     * legado - vermelho quando SigCdCli.Situas = "*", azul nos demais casos).
5607:     * PUBLIC: chamado de fora (carga e harness de teste).
5608:     *==========================================================================
5609:     PROCEDURE AtualizarGradeCredito()
5610:         LOCAL loc_oAba, loc_oBO, loc_oErro
5611: 
5612:         TRY
5613:             IF THIS.AbaResultadoDisponivel(10)
5614:                 loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page10
5615:                 loc_oBO  = THIS.this_oBusinessObject
5616: 
5617:                 IF USED("dbCredito")
5618:                     SELECT dbCredito
5619:                     GO TOP
5620:                 ENDIF
5621: 
5622:                 loc_oAba.pgf_4c_Credito.Page1.grd_4c_Credito.Refresh()
5623: 
5624:                 IF VARTYPE(loc_oBO) = "O"
5625:                     loc_oAba.lbl_4c_SituacaoCredito.Caption = ;
5626:                         IIF(EMPTY(loc_oBO.this_cLabelSituacaoCredito), ;
5627:                             "CLIENTE", ALLTRIM(loc_oBO.this_cLabelSituacaoCredito))
5628:                     loc_oAba.lbl_4c_SituacaoCredito.ForeColor = ;
5629:                         IIF(loc_oBO.this_lSituacaoVermelha, RGB(255, 0, 0), RGB(0, 0, 255))
5630:                 ENDIF
5631:             ENDIF
5632:         CATCH TO loc_oErro
5633:             MsgErro(loc_oErro.Message + CHR(13) + ;
5634:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
5635:                 "Erro ao atualizar a grade de cr" + CHR(233) + "dito")
5636:         ENDTRY
5637:     ENDPROC
5638: 
5639:     *==========================================================================
5640:     * AbaResultadoDisponivel - .T. quando a aba N da pagina Resultado ja esta
5641:     * montada. As repinturas sao chamadas tambem durante a carga, antes de a
5642:     * fase de montagem terminar - por isso o guard, que evita "object is not
5643:     * found" sem precisar de TRY vazio em cada chamador.
5644:     *==========================================================================
5645:     PROTECTED FUNCTION AbaResultadoDisponivel(par_nAba)
5646:         LOCAL loc_lDisponivel, loc_oPg
5647:         loc_lDisponivel = .F.
5648: 
5649:         IF PEMSTATUS(THIS, "pgf_4c_Paginas", 5)

*-- Linhas 5667 a 5796:
5667:     * grade pelo seu funil.
5668:     * PUBLIC: chamado por CarregarDados e pelo harness de teste.
5669:     *==========================================================================
5670:     PROCEDURE CarregarAbasResultado()
5671:         LOCAL loc_oBO, loc_lSucesso, loc_oErro
5672:         loc_lSucesso = .F.
5673: 
5674:         TRY
5675:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
5676:                 loc_oBO = THIS.this_oBusinessObject
5677: 
5678:                 *-- Parametros (grupo padrao, moedas, tipo de preco, flags de
5679:                 *-- limite) - de quem dependem os totais da aba Cheques
5680:                 loc_oBO.CarregarParametros()
5681: 
5682:                 *-- Pendencias
5683:                 IF loc_oBO.CarregarPendencias()
5684:                     IF THIS.AbaResultadoDisponivel(2)
5685:                         THIS.PreencherComboGrupo( ;
5686:                             THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page2.cbo_4c_GrupoPend, ;
5687:                             "TmpPar")
5688:                     ENDIF
5689:                     THIS.AtualizarGradePendencias()
5690:                 ELSE
5691:                     IF !EMPTY(loc_oBO.this_cMensagemErro)
5692:                         MsgAviso(loc_oBO.this_cMensagemErro, "Pend" + CHR(234) + "ncias")
5693:                     ENDIF
5694:                 ENDIF
5695: 
5696:                 *-- Cheques
5697:                 IF loc_oBO.CarregarCheques()
5698:                     IF THIS.AbaResultadoDisponivel(3)
5699:                         THIS.PreencherComboGrupo( ;
5700:                             THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page3.cbo_4c_GrupoCheque, ;
5701:                             "dbAberto")
5702:                     ENDIF
5703:                     THIS.AtualizarGradesCheques()
5704:                 ELSE
5705:                     IF !EMPTY(loc_oBO.this_cMensagemErro)
5706:                         MsgAviso(loc_oBO.this_cMensagemErro, "Cheques")
5707:                     ENDIF
5708:                 ENDIF
5709: 
5710:                 *-- Cartoes
5711:                 IF loc_oBO.CarregarCartoes()
5712:                     THIS.AtualizarGradeCartao()
5713:                 ELSE
5714:                     IF !EMPTY(loc_oBO.this_cMensagemErro)
5715:                         MsgAviso(loc_oBO.this_cMensagemErro, "Cart" + CHR(245) + "es")
5716:                     ENDIF
5717:                 ENDIF
5718: 
5719:                 *-- Estoque
5720:                 IF loc_oBO.CarregarEstoque()
5721:                     IF THIS.AbaResultadoDisponivel(6)
5722:                         THIS.PreencherComboGrupo( ;
5723:                             THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page6.cbo_4c_GrupoEstoque, ;
5724:                             "dbEstoque")
5725:                     ENDIF
5726:                     THIS.AtualizarGradeEstoque()
5727:                 ELSE
5728:                     IF !EMPTY(loc_oBO.this_cMensagemErro)
5729:                         MsgAviso(loc_oBO.this_cMensagemErro, "Estoque")
5730:                     ENDIF
5731:                 ENDIF
5732: 
5733:                 *-- H.Cheques
5734:                 IF loc_oBO.CarregarHCheques()
5735:                     THIS.AtualizarGradeHCheques()
5736:                 ELSE
5737:                     IF !EMPTY(loc_oBO.this_cMensagemErro)
5738:                         MsgAviso(loc_oBO.this_cMensagemErro, "Hist" + CHR(243) + "rico de Cheques")
5739:                     ENDIF
5740:                 ENDIF
5741: 
5742:                 *-- Credito
5743:                 IF loc_oBO.CarregarCredito()
5744:                     THIS.AtualizarGradeCredito()
5745:                 ELSE
5746:                     IF !EMPTY(loc_oBO.this_cMensagemErro)
5747:                         MsgAviso(loc_oBO.this_cMensagemErro, "Cr" + CHR(233) + "dito")
5748:                     ENDIF
5749:                 ENDIF
5750: 
5751:                 loc_lSucesso = .T.
5752:             ENDIF
5753:         CATCH TO loc_oErro
5754:             MsgErro(loc_oErro.Message + CHR(13) + ;
5755:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
5756:                 "Proc: " + loc_oErro.Procedure, "Erro ao carregar as abas de resultado")
5757:         ENDTRY
5758: 
5759:         RETURN loc_lSucesso
5760:     ENDPROC
5761: 
5762: 
5763: 
5764:     *==========================================================================
5765:     *                   FASE 8/8 - EVENTOS AUXILIARES
5766:     *
5767:     * Os nomes canonicos abaixo nao sao decoracao: cada um recebeu o bloco do
5768:     * legado que faz aquele papel nesta tela, e os metodos das fases anteriores
5769:     * passaram a entrar por eles (funil unico, regra #40).
5770:     *
5771:     *   FormParaBO / BOParaForm  -> os cinco criterios do container Origem
5772:     *                               (Conta / Nome / CPF / Conjuge / Telefone),
5773:     *                               o optFiltro e o periodo do cnt_periodo.
5774:     *   HabilitarCampos          -> a cascata de When do legado nos criterios
5775:     *                               (Get_cpf.When, Get_dconta.When,
5776:     *                               GetConj.When, getTelefone.When,
5777:     *                               optFiltro.When).
5778:     *   LimparCampos             -> o Space(N) dos cinco campos no
5779:     *                               cmd_voltar.Click mais o LimparDados do BO.
5780:     *   AjustarBotoesPorModo     -> os gates de acesso do Init legado
5781:     *                               (fChecaAcesso CADASTRO/MOVIMENTA) e do par
5782:     *                               Cmd_MudaCli/Cmd_MudaMov (mais IMPRIMIR no
5783:     *                               Imprime), aplicados conforme a pagina e a
5784:     *                               visao correntes.
5785:     *   CarregarLista            -> funil de (re)carga da consulta.
5786:     *   BtnBuscarClick           -> dispara/refaz a consulta.
5787:     *   BtnSalvarClick           -> o bloco "Deseja salvar as alteracoes?" do
5788:     *                               cmd_voltar.Click (mValidaObj + mGravaDados).
5789:     *   BtnCancelarClick /
5790:     *   BtnEncerrarClick         -> cmd_cancela.Click ([ESC] Sair).
5791:     *==========================================================================
5792: 
5793:     *==========================================================================
5794:     * FormParaBO - Leva para o Business Object TODO criterio que a tela possui:
5795:     * os cinco campos do container Origem, a opcao de filtro de nome
5796:     * (optFiltro) e o periodo da pagina Resultado. Fonte UNICA eh o controle,

*-- Linhas 5806 a 6086:
5806:     *
5807:     * PUBLIC: chamado por CarregarDados e pelo harness de teste (regra #3).
5808:     *==========================================================================
5809:     PROTECTED PROCEDURE FormParaBO()
5810:         LOCAL loc_lSucesso, loc_oBO, loc_oCnt, loc_oPer, loc_oErro
5811:         loc_lSucesso = .F.
5812: 
5813:         TRY
5814:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
5815:                 loc_oBO = THIS.this_oBusinessObject
5816: 
5817:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_Origem", 5)
5818:                     loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
5819: 
5820:                     loc_oBO.this_cConta     = ALLTRIM(loc_oCnt.txt_4c_Conta.Value)
5821:                     loc_oBO.this_cDescConta = ALLTRIM(loc_oCnt.txt_4c_DConta.Value)
5822:                     loc_oBO.this_cCpf       = ALLTRIM(loc_oCnt.txt_4c_Cpf.Value)
5823:                     loc_oBO.this_cConjuge   = ALLTRIM(loc_oCnt.txt_4c_Conjuge.Value)
5824:                     loc_oBO.this_cTelefone  = ALLTRIM(loc_oCnt.txt_4c_Telefone.Value)
5825: 
5826:                     *-- optFiltro tem ControlSource NUMERICO de 2 opcoes: o
5827:                     *-- valor gravado eh o INDICE 1-based (1 = Iniciais,
5828:                     *-- 2 = Qualquer Parte), nunca 0/1 logico
5829:                     loc_oBO.this_nOpcaoFiltro = loc_oCnt.obj_4c_OptFiltro.Value
5830:                 ENDIF
5831: 
5832:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "cnt_4c_Periodo", 5)
5833:                     loc_oPer = THIS.pgf_4c_Paginas.Page2.cnt_4c_Periodo
5834: 
5835:                     *-- ConverterParaData (nao TTOD): o TextBox nasce com {}
5836:                     *-- (DATE) e a coluna do banco chega como DATETIME (regra #16)
5837:                     loc_oBO.this_dDataInicial = ;
5838:                         ConverterParaData(loc_oPer.txt_4c_DtInicial.Value)
5839:                     loc_oBO.this_dDataFinal = ;
5840:                         ConverterParaData(loc_oPer.txt_4c_DtFinal.Value)
5841:                 ENDIF
5842: 
5843:                 loc_lSucesso = .T.
5844:             ENDIF
5845:         CATCH TO loc_oErro
5846:             MsgErro(loc_oErro.Message + CHR(13) + ;
5847:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
5848:                 "Proc: " + loc_oErro.Procedure, ;
5849:                 "Erro ao transferir os crit" + CHR(233) + "rios para o Business Object")
5850:         ENDTRY
5851: 
5852:         RETURN loc_lSucesso
5853:     ENDPROC
5854: 
5855:     *==========================================================================
5856:     * BOParaForm - Caminho inverso do FormParaBO: devolve aos controles o que o
5857:     * Business Object carregou (equivalente ao preenchimento cruzado dos campos
5858:     * Conta/Nome/CPF/Conjuge/Telefone que o legado faz no fim de cada Valid de
5859:     * pesquisa bem-sucedida).
5860:     *
5861:     * optFiltro so eh reescrito com indice valido (1..ButtonCount): o BO nasce
5862:     * com this_nOpcaoFiltro = 0 e atribuir 0 a um OptionGroup 1-based
5863:     * desmarcaria as duas opcoes.
5864:     *
5865:     * PUBLIC: chamado por AtualizarCamposOrigem e pelo harness de teste.
5866:     *==========================================================================
5867:     PROTECTED PROCEDURE BOParaForm()
5868:         LOCAL loc_oBO, loc_oCnt, loc_oPer, loc_oErro
5869: 
5870:         TRY
5871:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
5872:                 loc_oBO = THIS.this_oBusinessObject
5873: 
5874:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_Origem", 5)
5875:                     loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
5876: 
5877:                     loc_oCnt.txt_4c_Conta.Value    = loc_oBO.this_cConta
5878:                     loc_oCnt.txt_4c_DConta.Value   = loc_oBO.this_cDescConta
5879:                     loc_oCnt.txt_4c_Cpf.Value      = loc_oBO.this_cCpf
5880:                     loc_oCnt.txt_4c_Conjuge.Value  = loc_oBO.this_cConjuge
5881:                     loc_oCnt.txt_4c_Telefone.Value = loc_oBO.this_cTelefone
5882: 
5883:                     IF BETWEEN(loc_oBO.this_nOpcaoFiltro, 1, ;
5884:                             loc_oCnt.obj_4c_OptFiltro.ButtonCount)
5885:                         loc_oCnt.obj_4c_OptFiltro.Value = loc_oBO.this_nOpcaoFiltro
5886:                     ENDIF
5887: 
5888:                     loc_oCnt.Refresh()
5889:                 ENDIF
5890: 
5891:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "cnt_4c_Periodo", 5)
5892:                     loc_oPer = THIS.pgf_4c_Paginas.Page2.cnt_4c_Periodo
5893:                     loc_oPer.txt_4c_DtInicial.Value = loc_oBO.this_dDataInicial
5894:                     loc_oPer.txt_4c_DtFinal.Value   = loc_oBO.this_dDataFinal
5895:                 ENDIF
5896: 
5897:                 *-- Criterio novo na tela muda a cascata de When do legado
5898:                 THIS.HabilitarCampos(.T.)
5899:             ENDIF
5900:         CATCH TO loc_oErro
5901:             MsgErro(loc_oErro.Message + CHR(13) + ;
5902:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
5903:                 "Proc: " + loc_oErro.Procedure, ;
5904:                 "Erro ao exibir os dados do cliente")
5905:         ENDTRY
5906:     ENDPROC
5907: 
5908:     *==========================================================================
5909:     * HabilitarCampos - Cascata de When dos criterios da Origem, transcrita
5910:     * campo a campo do dump legado:
5911:     *
5912:     *   Get_conta.When    -> .T. (sempre digitavel)
5913:     *   Get_cpf.When      -> Empty(Get_Conta)
5914:     *   Get_dconta.When   -> Empty(Get_Conta) And Empty(Get_Cpf) And !plCPF
5915:     *   GetConj.When      -> Empty(Get_Conta) And Empty(Get_Cpf) And
5916:     *                        Empty(Get_DConta) And !plCPF
5917:     *   getTelefone.When  -> Empty(Get_Conta) And Empty(Get_Cpf) And
5918:     *                        Empty(Get_DConta) And Empty(getConj)
5919:     *   optFiltro.When    -> !plCPF
5920:     *
5921:     * Usa ReadOnly nos TextBox (e nao Enabled): o When legado bloqueia a
5922:     * DIGITACAO e mantem o texto legivel - exatamente o que ReadOnly faz -, e
5923:     * ReadOnly pode ser trocado durante o LostFocus do proprio campo sem
5924:     * disputar o foco corrente. O OptionGroup nao tem ReadOnly, e a regra dele
5925:     * depende apenas de plCPF (que nao muda no meio da digitacao), por isso
5926:     * continua em Enabled.
5927:     *
5928:     * par_lHabilitar = .F. tranca TODOS os criterios de uma vez (usado quando a
5929:     * tela esta com um painel modal aberto por cima); omitido ou .T. aplica a
5930:     * cascata do legado. PUBLIC: chamado pelos funis e pelo harness de teste.
5931:     *==========================================================================
5932:     PROCEDURE HabilitarCampos(par_lHabilitar)
5933:         LOCAL loc_oCnt, loc_lLiberar, loc_lSoCpf, loc_oErro
5934:         LOCAL loc_lTemConta, loc_lTemCpf, loc_lTemNome, loc_lTemConjuge
5935: 
5936:         loc_lLiberar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
5937: 
5938:         TRY
5939:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_Origem", 5)
5940:                 loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
5941: 
5942:                 loc_lSoCpf = .F.
5943:                 IF VARTYPE(THIS.this_oBusinessObject) = "O"
5944:                     loc_lSoCpf = THIS.this_oBusinessObject.this_lSomenteCPF
5945:                 ENDIF
5946: 
5947:                 loc_lTemConta   = !EMPTY(ALLTRIM(loc_oCnt.txt_4c_Conta.Value))
5948:                 loc_lTemCpf     = !EMPTY(ALLTRIM(loc_oCnt.txt_4c_Cpf.Value))
5949:                 loc_lTemNome    = !EMPTY(ALLTRIM(loc_oCnt.txt_4c_DConta.Value))
5950:                 loc_lTemConjuge = !EMPTY(ALLTRIM(loc_oCnt.txt_4c_Conjuge.Value))
5951: 
5952:                 loc_oCnt.txt_4c_Conta.ReadOnly = !loc_lLiberar
5953: 
5954:                 loc_oCnt.txt_4c_Cpf.ReadOnly = ;
5955:                     !(loc_lLiberar AND !loc_lTemConta)
5956: 
5957:                 loc_oCnt.txt_4c_DConta.ReadOnly = ;
5958:                     !(loc_lLiberar AND !loc_lTemConta AND !loc_lTemCpf AND !loc_lSoCpf)
5959: 
5960:                 loc_oCnt.txt_4c_Conjuge.ReadOnly = ;
5961:                     !(loc_lLiberar AND !loc_lTemConta AND !loc_lTemCpf AND ;
5962:                       !loc_lTemNome AND !loc_lSoCpf)
5963: 
5964:                 loc_oCnt.txt_4c_Telefone.ReadOnly = ;
5965:                     !(loc_lLiberar AND !loc_lTemConta AND !loc_lTemCpf AND ;
5966:                       !loc_lTemNome AND !loc_lTemConjuge)
5967: 
5968:                 loc_oCnt.obj_4c_OptFiltro.Enabled = (loc_lLiberar AND !loc_lSoCpf)
5969:             ENDIF
5970:         CATCH TO loc_oErro
5971:             MsgErro(loc_oErro.Message + CHR(13) + ;
5972:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
5973:                 "Proc: " + loc_oErro.Procedure, ;
5974:                 "Erro ao habilitar os crit" + CHR(233) + "rios de pesquisa")
5975:         ENDTRY
5976:     ENDPROC
5977: 
5978:     *==========================================================================
5979:     * LimparCampos - Bloco de limpeza do cmd_voltar.Click legado:
5980:     *
5981:     *   .Get_conta.Value    = Space(10)
5982:     *   .Get_dconta.Value   = Space(50)
5983:     *   .Get_cpf.Value      = Space(20)
5984:     *   .GetConj.Value      = Space(40)
5985:     *   .getTelefone.Value  = Space(15)
5986:     *   .Refresh
5987:     *
5988:     * mais o LimparDados do BO (que zera os criterios, os flags de controle da
5989:     * consulta e os totais derivados - sem isso a tela mostraria os numeros da
5990:     * conta anterior) e a reaplicacao da cascata de When, que volta a liberar
5991:     * os cinco campos agora que estao vazios.
5992:     *
5993:     * O periodo NAO eh limpo: o legado tambem o preserva entre consultas.
5994:     * PUBLIC: chamado por AlternarPagina e pelo harness de teste.
5995:     *==========================================================================
5996:     PROTECTED PROCEDURE LimparCampos()
5997:         LOCAL loc_oCnt, loc_oErro
5998: 
5999:         TRY
6000:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_Origem", 5)
6001:                 loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
6002: 
6003:                 loc_oCnt.txt_4c_Conta.Value    = ""
6004:                 loc_oCnt.txt_4c_DConta.Value   = ""
6005:                 loc_oCnt.txt_4c_Cpf.Value      = ""
6006:                 loc_oCnt.txt_4c_Conjuge.Value  = ""
6007:                 loc_oCnt.txt_4c_Telefone.Value = ""
6008:                 loc_oCnt.Refresh()
6009:             ENDIF
6010: 
6011:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
6012:                 THIS.this_oBusinessObject.LimparDados()
6013:             ENDIF
6014: 
6015:             THIS.HabilitarCampos(.T.)
6016:         CATCH TO loc_oErro
6017:             MsgErro(loc_oErro.Message + CHR(13) + ;
6018:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
6019:                 "Proc: " + loc_oErro.Procedure, ;
6020:                 "Erro ao limpar os crit" + CHR(233) + "rios de pesquisa")
6021:         ENDTRY
6022:     ENDPROC
6023: 
6024:     *==========================================================================
6025:     * AjustarBotoesPorModo - Gates de acesso do legado, num funil unico.
6026:     *
6027:     * Pagina Consulta (Init legado):
6028:     *   If Not fChecaAcesso('SIGOPCGV','CADASTRO')  -> Cmd_Cadastro invisivel
6029:     *   If !fChecaAcesso('SIGOPCGV','MOVIMENTA')    -> Cmd_Movimenta invisivel
6030:     *   (Cmd_Cancela nunca depende de acesso)
6031:     *
6032:     * Pagina Resultado (cmd_cadastro.Click do Cmd_MudaCli e cmd_movimenta.Click
6033:     * do Cmd_MudaMov):
6034:     *   .Imprime.Visible = fChecaAcesso('SIGOPCGV','IMPRIMIR')
6035:     *   visao MOVIMENTO  -> MudaCli visivel se fChecaAcesso(...,'CADASTRO')
6036:     *   visao CADASTRO   -> MudaMov visivel se fChecaAcesso(...,'MOVIMENTA')
6037:     *   (o par nunca fica visivel junto - os dois estao no mesmo Left no SCX)
6038:     *
6039:     * O legado tambem reposiciona o grp_operacao quando esconde um botao
6040:     * (Cmd_Movimenta.Left - 81, Width - 81, Left + 81): isso vai junto, para a
6041:     * barra nao ficar com um buraco no lugar do botao escondido.
6042:     *
6043:     * PUBLIC: chamado por AlternarPagina, por AjustarVisibilidadeResultado e
6044:     * pelo harness de teste (regra #3).
6045:     *==========================================================================
6046:     PROCEDURE AjustarBotoesPorModo()
6047:         LOCAL loc_oPg1, loc_oPg2, loc_oGrp, loc_oErro
6048:         LOCAL loc_lCadastro, loc_lMovimenta, loc_lImprimir
6049:         LOCAL loc_lResultado, loc_lVisaoMov, loc_nLargura, loc_nLeft
6050: 
6051:         TRY
6052:             loc_lCadastro  = fChecaAcesso("SIGOPCGV", "CADASTRO")
6053:             loc_lMovimenta = fChecaAcesso("SIGOPCGV", "MOVIMENTA")
6054:             loc_lImprimir  = fChecaAcesso("SIGOPCGV", "IMPRIMIR")
6055: 
6056:             loc_lResultado = (THIS.this_cModoAtual == "RESULTADO")
6057:             loc_lVisaoMov  = (THIS.this_cModoResultado == "MOVIMENTO")
6058: 
6059:             *-- Pagina Consulta
6060:             loc_oPg1 = THIS.pgf_4c_Paginas.Page1
6061:             IF PEMSTATUS(loc_oPg1, "cmg_4c_GrpOperacao", 5)
6062:                 loc_oGrp = loc_oPg1.cmg_4c_GrpOperacao
6063: 
6064:                 loc_oGrp.Buttons(1).Visible = loc_lCadastro
6065:                 loc_oGrp.Buttons(1).Enabled = loc_lCadastro
6066:                 loc_oGrp.Buttons(2).Visible = loc_lMovimenta
6067:                 loc_oGrp.Buttons(2).Enabled = loc_lMovimenta
6068:                 loc_oGrp.Buttons(3).Visible = .T.
6069:                 loc_oGrp.Buttons(3).Enabled = .T.
6070: 
6071:                 *-- Fecha o buraco deixado por botao escondido (o legado move os
6072:                 *-- botoes restantes 81px para a esquerda e encolhe o grupo)
6073:                 loc_nLargura = 235
6074:                 loc_nLeft    = 769
6075: 
6076:                 IF !loc_lCadastro
6077:                     loc_oGrp.Buttons(2).Left = 5
6078:                     loc_oGrp.Buttons(3).Left = 80
6079:                     loc_nLargura = loc_nLargura - 81
6080:                     loc_nLeft    = loc_nLeft + 81
6081:                 ENDIF
6082: 
6083:                 IF !loc_lMovimenta
6084:                     loc_oGrp.Buttons(3).Left = IIF(loc_lCadastro, 80, 5)
6085:                     loc_nLargura = loc_nLargura - 81
6086:                     loc_nLeft    = loc_nLeft + 81

*-- Linhas 6117 a 6247:
6117:         CATCH TO loc_oErro
6118:             MsgErro(loc_oErro.Message + CHR(13) + ;
6119:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
6120:                 "Proc: " + loc_oErro.Procedure, ;
6121:                 "Erro ao ajustar os bot" + CHR(245) + "es")
6122:         ENDTRY
6123:     ENDPROC
6124: 
6125:     *==========================================================================
6126:     * CarregarLista - Funil de (re)carga da consulta. Nesta tela a "lista" sao
6127:     * as grades das abas da pagina Resultado, e quem as popula eh o
6128:     * CarregarDados (historico/saldo) somado ao CarregarAbasResultado
6129:     * (pendencias, cheques, cartoes, estoque, historico de cheques e credito),
6130:     * que ele ja encadeia - exatamente a sequencia do Processa() legado.
6131:     * PUBLIC: chamado pelos botoes e pelo harness de teste (regra #3).
6132:     *==========================================================================
6133:     PROCEDURE CarregarLista()
6134:         RETURN THIS.CarregarDados()
6135:     ENDPROC
6136: 
6137:     *==========================================================================
6138:     * BtnBuscarClick - Dispara a consulta. Na pagina Consulta eh a entrada do
6139:     * cmd_movimenta.Click legado (valida a conta, carrega e abre a pagina
6140:     * Resultado na visao MOVIMENTO); com a pagina Resultado ja aberta, refaz a
6141:     * consulta da conta corrente - o mesmo que o legado faz no
6142:     * get_dt_final.LostFocus (ConsultaExecutada = .f. + Processa()).
6143:     *==========================================================================
6144:     PROCEDURE BtnBuscarClick()
6145:         IF THIS.this_cModoAtual == "RESULTADO"
6146:             THIS.this_oBusinessObject.this_lConsultaExecutada = .F.
6147:             THIS.CarregarLista()
6148:             THIS.AtualizarAbaResultadoAtiva()
6149:         ELSE
6150:             THIS.BtnMovimentoClick()
6151:         ENDIF
6152:     ENDPROC
6153: 
6154:     *==========================================================================
6155:     * BtnSalvarClick - Bloco de gravacao do cmd_voltar.Click legado:
6156:     *
6157:     *   IF ThisForm.pcEscolha = 'ALTERAR'
6158:     *       IF MessageBox('Deseja salvar as alteracoes?',32+4,...) = 6
6159:     *           IF thisform...CntConta.mvalidaobj() < 1
6160:     *               RETURN .f.
6161:     *           endif
6162:     *           thisform...CntConta.mgravadados()
6163:     *       ENDIF
6164:     *   ENDIF
6165:     *
6166:     * Retorna .F. SO quando a saida deve ser abortada (a validacao do cadastro
6167:     * recusou): fora do modo ALTERAR, ou com o usuario respondendo Nao, o
6168:     * legado simplesmente segue - por isso .T. nos dois casos.
6169:     *
6170:     * A gravacao em si eh do wrapper cadastral da conta (cntConta), por onde o
6171:     * legado edita o cliente; sem ele na tela a alteracao se faz pelo Cadastro
6172:     * de Clientes, e o metodo diz isso em vez de devolver sucesso falso.
6173:     *
6174:     * PUBLIC: chamado por BtnVoltarClick e pelo harness de teste (regra #3).
6175:     *==========================================================================
6176:     PROCEDURE BtnSalvarClick()
6177:         LOCAL loc_lProsseguir, loc_oPg, loc_nValida, loc_oErro
6178: 
6179:         *-- Fora de ALTERAR nao ha o que gravar e a saida segue normalmente
6180:         IF !(UPPER(ALLTRIM(THIS.this_oBusinessObject.this_cEscolha)) == "ALTERAR")
6181:             RETURN .T.
6182:         ENDIF
6183: 
6184:         IF !MsgConfirma("Deseja salvar as altera" + CHR(231) + CHR(245) + "es?", ;
6185:                 "Altera" + CHR(231) + CHR(227) + "o de Cliente")
6186:             RETURN .T.
6187:         ENDIF
6188: 
6189:         loc_oPg = THIS.pgf_4c_Paginas.Page2
6190: 
6191:         IF !PEMSTATUS(loc_oPg, "cntConta", 5)
6192:             MsgAviso("A altera" + CHR(231) + CHR(227) + "o dos dados cadastrais " + ;
6193:                 "desta conta se faz pelo Cadastro de Clientes.", THIS.Caption)
6194:             RETURN .F.
6195:         ENDIF
6196: 
6197:         loc_lProsseguir = .T.
6198: 
6199:         TRY
6200:             *-- mValidaObj() < 1 recusa a gravacao e mantem a tela aberta
6201:             loc_nValida = loc_oPg.cntConta.mValidaObj()
6202: 
6203:             IF VARTYPE(loc_nValida) = "N" AND loc_nValida < 1
6204:                 loc_lProsseguir = .F.
6205:             ELSE
6206:                 loc_oPg.cntConta.mGravaDados()
6207:             ENDIF
6208:         CATCH TO loc_oErro
6209:             MsgErro(loc_oErro.Message + CHR(13) + ;
6210:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
6211:                 "Proc: " + loc_oErro.Procedure, ;
6212:                 "Erro ao gravar a altera" + CHR(231) + CHR(227) + "o do cliente")
6213:             loc_lProsseguir = .F.
6214:         ENDTRY
6215: 
6216:         RETURN loc_lProsseguir
6217:     ENDPROC
6218: 
6219:     *==========================================================================
6220:     * BtnCancelarClick - cmd_cancela.Click do grp_operacao legado ("[ESC] Sair",
6221:     * Cancel = .T., Click = ThisForm.Release). Com a pagina Resultado aberta o
6222:     * Cancelar ABANDONA a consulta sem passar pela gravacao (quem oferece
6223:     * gravar eh o Voltar, via BtnSalvarClick) e devolve a tela para a Consulta;
6224:     * na pagina Consulta ele encerra, como no legado.
6225:     *==========================================================================
6226:     PROCEDURE BtnCancelarClick()
6227:         IF THIS.pgf_4c_Paginas.ActivePage = 2
6228:             THIS.this_oBusinessObject.this_cEscolha = "CONSULTAR"
6229:             THIS.AlternarPagina(1)
6230:         ELSE
6231:             THIS.BtnEncerrarClick()
6232:         ENDIF
6233:     ENDPROC
6234: 
6235:     *==========================================================================
6236:     * BtnEncerrarClick - Fecha a tela devolvendo o controle ao form chamador,
6237:     * como o legado faz no ramo Automatico do cmd_voltar.Click
6238:     * (ThisForm.Release + poForm1.Enabled = .t.).
6239:     *==========================================================================
6240:     PROCEDURE BtnEncerrarClick()
6241:         IF VARTYPE(THIS.this_oFormPai) = "O" AND !THIS.this_oFormPai.Enabled
6242:             THIS.this_oFormPai.Enabled = .T.
6243:         ENDIF
6244: 
6245:         THIS.Release()
6246:     ENDPROC
6247: ENDDEFINE

