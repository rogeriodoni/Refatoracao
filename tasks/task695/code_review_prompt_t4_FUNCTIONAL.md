# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (26)
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
- [LAYOUT-POSITION] Controle 'Origem' (parent: SIGOPCGV.fld_principal.pag_consulta): Top original=89 vs migrado 'cnt_4c_Origem' Top=5 (diff=84px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Saida' (parent: SIGOPCGV.fld_principal.pag_resultado.SelecionaImpCad): Left original=379 vs migrado 'cmd_4c_Saida' Left=329 (diff=50px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Visualizar' (parent: SIGOPCGV.fld_principal.pag_resultado.SelecionaImpCad): Left original=231 vs migrado 'cmd_4c_Visualizar' Left=179 (diff=52px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Imprimir' (parent: SIGOPCGV.fld_principal.pag_resultado.SelecionaImpCad): Left original=306 vs migrado 'cmd_4c_Imprimir' Left=254 (diff=52px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Anexa' (parent: SIGOPCGV.fld_principal.pag_resultado.Result.Vendas): Top original=177 vs migrado 'cmd_4c_AnexaSaldo' Top=407 (diff=230px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Anexa' (parent: SIGOPCGV.fld_principal.pag_resultado.Result.Vendas): Left original=203 vs migrado 'cmd_4c_AnexaSaldo' Left=744 (diff=541px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Anexa' (parent: SIGOPCGV.fld_principal.pag_resultado.Result.Pendencias): Top original=180 vs migrado 'cmd_4c_AnexaSaldo' Top=407 (diff=227px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Anexa' (parent: SIGOPCGV.fld_principal.pag_resultado.Result.Pendencias): Left original=835 vs migrado 'cmd_4c_AnexaSaldo' Left=744 (diff=91px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopcgv.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (6300 linhas total):

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

*-- Linhas 1418 a 1504:
1418:         ENDWITH
1419: 
1420:         *-- Botao "Documento" (Anexa) do historico de conta corrente (Result.
1421:         *-- Saldo.Anexa do legado): mesmo padrao icone-only do cmd_4c_AnexaPend
1422:         *-- da aba Pendencias (regra do botao nunca desabilitado em runtime).
1423:         loc_oPg.AddObject("cmd_4c_AnexaSaldo", "CommandButton")
1424:         WITH loc_oPg.cmd_4c_AnexaSaldo
1425:             .Top             = 407
1426:             .Left            = 744
1427:             .Width           = 40
1428:             .Height          = 40
1429:             .FontName        = "Verdana"
1430:             .FontSize        = 8
1431:             .Caption         = ""
1432:             .Picture         = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
1433:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
1434:             .ToolTipText     = "Documento"
1435:             .ForeColor       = RGB(90, 90, 90)
1436:             .BackColor       = RGB(255, 255, 255)
1437:             .Themes          = .T.
1438:             .Visible         = .T.
1439:         ENDWITH
1440:         BINDEVENT(loc_oPg.cmd_4c_AnexaSaldo, "Click", THIS, "BtnAnexaSaldoClick")
1441: 
1442:         loc_oPg.grd_4c_Historico.Refresh()
1443:         loc_oPg.grd_4c_Saldo.Refresh()
1444:     ENDPROC
1445: 
1446:     *==========================================================================
1447:     * ConfigurarNavegacaoResultado - OptionGroup de navegacao entre as 10 abas
1448:     * da pagina Resultado (Optiongroup1 do legado, Top = 12 / Left = 44 /
1449:     * 760x85, 10 botoes graficos de 75x75 lado a lado).
1450:     *
1451:     * O legado navega com "result.ActivePage = this.Value" - por isso as abas
1452:     * foram declaradas na ordem de PageOrder (ver ConfigurarPageFrameResultado)
1453:     * e aqui as legendas/icones/posicoes de cada opcao sao transcritas do dump
1454:     * na MESMA ordem, para opcao N abrir a aba N.
1455:     *
1456:     * OptionGroup nao tem ForeColor (regra #33): a cor vai em cada Buttons(N).
1457:     * Nenhum ButtonsValue eh atribuido - quem guarda a selecao eh o Value
1458:     * do grupo (1..10), e valor nao-zero no botao marcaria todos de uma vez.
1459:     *==========================================================================
1460:     PROTECTED PROCEDURE ConfigurarNavegacaoResultado()
1461:         LOCAL loc_oPg, loc_oOpt
1462:         loc_oPg = THIS.pgf_4c_Paginas.Page2
1463: 
1464:         loc_oPg.AddObject("obj_4c_OptResultado", "OptionGroup")
1465:         loc_oOpt = loc_oPg.obj_4c_OptResultado
1466: 
1467:         WITH loc_oOpt
1468:             .Top           = 12
1469:             .Left          = 44
1470:             .Width         = 760
1471:             .Height        = 85
1472:             .ButtonCount   = 10
1473:             .BackStyle     = 0
1474:             .BorderStyle   = 0
1475:             .SpecialEffect = 1
1476:             .BorderColor   = RGB(136, 189, 188)
1477:             .Value         = 0
1478:             .Themes        = .F.
1479:             .Visible       = .T.
1480:         ENDWITH
1481: 
1482:         *-- Opcao 1 - Saldo Conta Corrente (optSaldo)
1483:         THIS.ConfigurarBotaoNavegacao(loc_oOpt, 1, 5, ;
1484:             "Saldo Conta Corrente", "geral_nota_60.jpg", 7, 2, .T., "")
1485: 
1486:         *-- Opcao 2 - Pendencias Financeiras (optPendencia)
1487:         THIS.ConfigurarBotaoNavegacao(loc_oOpt, 2, 80, ;
1488:             "Pend" + CHR(234) + "ncias Financeiras", "geral_pendencia_60.jpg", 7, 2, .T., "")
1489: 
1490:         *-- Opcao 3 - Cheques (optCheque)
1491:         THIS.ConfigurarBotaoNavegacao(loc_oOpt, 3, 155, ;
1492:             "Cheques", "cheque.png", 0, 2, .T., "")
1493: 
1494:         *-- Opcao 4 - Cartao (optCartao)
1495:         THIS.ConfigurarBotaoNavegacao(loc_oOpt, 4, 230, ;
1496:             "Cart" + CHR(227) + "o", "cartao.png", 0, 0, .F., "")
1497: 
1498:         *-- Opcao 5 - Vendas (optVendas)
1499:         THIS.ConfigurarBotaoNavegacao(loc_oOpt, 5, 305, ;
1500:             "Vendas", "geral_pastas_60.jpg", 0, 0, .F., "")
1501: 
1502:         *-- Opcao 6 - Estoque (optEstoque)
1503:         THIS.ConfigurarBotaoNavegacao(loc_oOpt, 6, 380, ;
1504:             "Estoque", "geral_empilha_60.jpg", 0, 2, .T., "")

*-- Linhas 1520 a 1631:
1520:         THIS.ConfigurarBotaoNavegacao(loc_oOpt, 10, 680, ;
1521:             "Cr" + CHR(233) + "dito", "geral_calculadora_60.jpg", 0, 0, .F., "")
1522: 
1523:         BINDEVENT(loc_oOpt, "InteractiveChange", THIS, "OptResultadoInteractiveChange")
1524:     ENDPROC
1525: 
1526:     *==========================================================================
1527:     * ConfigurarBotaoNavegacao - Aplica a um Buttons(N) do OptionGroup de
1528:     * navegacao as propriedades comuns a todas as 10 opcoes do legado (botao
1529:     * grafico 75x75, Comic Sans MS 8 bold italic, cinza sobre branco, sem
1530:     * tema) mais o que varia de uma para outra.
1531:     *
1532:     * par_oGrupo    : o OptionGroup (passado por referencia de objeto, para nao
1533:     *                 aninhar WITH de AddObject - ver regra do WITH aninhado)
1534:     * par_nIndice   : indice do botao (1..10)
1535:     * par_nLeft     : Left do botao dentro do grupo
1536:     * par_cCaption  : legenda transcrita do dump
1537:     * par_cIcone    : arquivo em vbmp\
1538:     * par_nPicPos   : PicturePosition (0 = default do dump, 7 = acima do texto)
1539:     * par_nAlign    : Alignment (0 = default do dump, 2 = centralizado)
1540:     * par_lWordWrap : WordWrap
1541:     * par_cToolTip  : ToolTipText ("" quando o dump nao declara)
1542:     *==========================================================================
1543:     PROTECTED PROCEDURE ConfigurarBotaoNavegacao(par_oGrupo, par_nIndice, par_nLeft, ;
1544:             par_cCaption, par_cIcone, par_nPicPos, par_nAlign, par_lWordWrap, par_cToolTip)
1545: 
1546:         WITH par_oGrupo.Buttons(par_nIndice)
1547:             .Top        = 5
1548:             .Left       = par_nLeft
1549:             .Width      = 75
1550:             .Height     = 75
1551:             .FontBold   = .T.
1552:             .FontItalic = .T.
1553:             .FontName   = "Comic Sans MS"
1554:             .FontSize   = 8
1555:             .Style      = 1
1556:             .AutoSize   = .F.
1557:             .WordWrap   = par_lWordWrap
1558:             .Alignment  = par_nAlign
1559:             .Caption    = par_cCaption
1560:             .ForeColor  = RGB(90, 90, 90)
1561:             .BackColor  = RGB(255, 255, 255)
1562:             .Themes     = .F.
1563: 
1564:             IF par_nPicPos > 0
1565:                 .PicturePosition = par_nPicPos
1566:             ENDIF
1567: 
1568:             IF !EMPTY(par_cToolTip)
1569:                 .ToolTipText = par_cToolTip
1570:             ENDIF
1571: 
1572:             IF FILE(gc_4c_CaminhoIcones + par_cIcone)
1573:                 .Picture = gc_4c_CaminhoIcones + par_cIcone
1574:             ENDIF
1575:         ENDWITH
1576:     ENDPROC
1577: 
1578:     *==========================================================================
1579:     * ConfigurarPeriodoResultado - Filtro de periodo da pagina Resultado
1580:     * (cnt_periodo do legado: Top = 120 / Left = -1 / 252x36, transparente).
1581:     *
1582:     * O periodo eh o que decide COMO o saldo eh calculado em
1583:     * sigopcgvBO.CarregarHistoricoSaldo: em branco usa o consolidado de
1584:     * SigMvSlc; preenchido limita o historico ao intervalo e soma o proprio
1585:     * historico - exatamente o IF do Processa() legado.
1586:     *
1587:     * lbl_periodo/lbl_periodo_a sao da classe "say" (AutoSize = .T. no dump);
1588:     * aqui vao com AutoSize = .F. + Width/Height transcritos, porque AutoSize
1589:     * eh no-op em Label criado por AddObject (regra #23).
1590:     *==========================================================================
1591:     PROTECTED PROCEDURE ConfigurarPeriodoResultado()
1592:         LOCAL loc_oPg, loc_oCnt
1593:         loc_oPg = THIS.pgf_4c_Paginas.Page2
1594: 
1595:         loc_oPg.AddObject("cnt_4c_Periodo", "Container")
1596:         loc_oCnt = loc_oPg.cnt_4c_Periodo
1597: 
1598:         WITH loc_oCnt
1599:             .Top         = 120
1600:             .Left        = -1
1601:             .Width       = 252
1602:             .Height      = 36
1603:             .BackStyle   = 0
1604:             .BorderWidth = 0
1605:             .Visible     = .T.
1606:         ENDWITH
1607: 
1608:         loc_oCnt.AddObject("lbl_4c_Periodo", "Label")
1609:         WITH loc_oCnt.lbl_4c_Periodo
1610:             .Top       = 10
1611:             .Left      = 16
1612:             .Width     = 48
1613:             .Height    = 17
1614:             .AutoSize  = .F.
1615:             .Alignment = 0
1616:             .FontName  = "Tahoma"
1617:             .FontSize  = 8
1618:             .BackStyle = 0
1619:             .ForeColor = RGB(90, 90, 90)
1620:             .Caption   = "Per" + CHR(237) + "o\<do : "
1621:             .Visible   = .T.
1622:         ENDWITH
1623: 
1624:         loc_oCnt.AddObject("txt_4c_DtInicial", "TextBox")
1625:         WITH loc_oCnt.txt_4c_DtInicial
1626:             .Top           = 8
1627:             .Left          = 66
1628:             .Width         = 80
1629:             .Height        = 21
1630:             .Value         = {}
1631:             .Format        = "K"

*-- Linhas 1666 a 1728:
1666:         *-- O legado recarrega a consulta no LostFocus da data final
1667:         *-- (get_dt_final.LostFocus: ConsultaExecutada = .f. + Processa()).
1668:         *-- LostFocus, nunca KeyPress (regra #47).
1669:         BINDEVENT(loc_oCnt.txt_4c_DtInicial, "LostFocus", THIS, "DtPeriodoLostFocus")
1670:         BINDEVENT(loc_oCnt.txt_4c_DtFinal,   "LostFocus", THIS, "DtPeriodoLostFocus")
1671:     ENDPROC
1672: 
1673:     *==========================================================================
1674:     * ConfigurarBotoesResultado - Barra de acao da pagina Resultado:
1675:     *
1676:     *   cmg_4c_MudaCli  (Cmd_MudaCli do legado) - troca para a visao CADASTRO
1677:     *   cmg_4c_MudaMov  (Cmd_MudaMov do legado) - troca para a visao MOVIMENTO
1678:     *   cmg_4c_Voltar   (grp_operacao do legado) - volta para a pagina Consulta
1679:     *
1680:     * Os tres sao CommandGroup de 1 botao, 85x85, transparentes, exatamente
1681:     * como no dump. MudaCli e MudaMov ocupam o MESMO Left (794) de proposito:
1682:     * no legado so um dos dois esta visivel a cada momento, e e' justamente o
1683:     * clique em um que mostra o outro.
1684:     *
1685:     * lblSaldoCash/getSaldoCash acompanham a visao CADASTRO (o legado os
1686:     * esconde em cmd_cadastro.Click e os mantem fora da visao MOVIMENTO).
1687:     *==========================================================================
1688:     PROTECTED PROCEDURE ConfigurarBotoesResultado()
1689:         LOCAL loc_oPg
1690:         loc_oPg = THIS.pgf_4c_Paginas.Page2
1691: 
1692:         *-- Cmd_MudaCli: "Cadastro"
1693:         loc_oPg.AddObject("cmg_4c_MudaCli", "CommandGroup")
1694:         WITH loc_oPg.cmg_4c_MudaCli
1695:             .Top           = 12
1696:             .Left          = 794
1697:             .Width         = 85
1698:             .Height        = 85
1699:             .ButtonCount   = 1
1700:             .BackStyle     = 0
1701:             .BorderStyle   = 0
1702:             .SpecialEffect = 1
1703:             .BorderColor   = RGB(136, 189, 188)
1704:             .Themes        = .F.
1705: 
1706:             WITH .Buttons(1)
1707:                 .Top         = 5
1708:                 .Left        = 5
1709:                 .Width       = 75
1710:                 .Height      = 75
1711:                 .FontBold    = .T.
1712:                 .FontItalic  = .T.
1713:                 .FontName    = "Comic Sans MS"
1714:                 .FontSize    = 8
1715:                 .Caption     = "\<Cadastro"
1716:                 .ToolTipText = "Dados Cadastrais"
1717:                 .ForeColor   = RGB(90, 90, 90)
1718:                 .BackColor   = RGB(255, 255, 255)
1719:                 .Themes      = .F.
1720:                 IF FILE(gc_4c_CaminhoIcones + "geral_contatos_60.jpg")
1721:                     .Picture = gc_4c_CaminhoIcones + "geral_contatos_60.jpg"
1722:                 ENDIF
1723:             ENDWITH
1724: 
1725:             .Visible = .T.
1726:         ENDWITH
1727: 
1728:         *-- Cmd_MudaMov: "Movimento"

*-- Linhas 1831 a 1922:
1831:             .Visible           = .F.
1832:         ENDWITH
1833: 
1834:         BINDEVENT(loc_oPg.cmg_4c_MudaCli.Buttons(1), "Click", THIS, "BtnMudaCliClick")
1835:         BINDEVENT(loc_oPg.cmg_4c_MudaMov.Buttons(1), "Click", THIS, "BtnMudaMovClick")
1836:         BINDEVENT(loc_oPg.cmg_4c_Voltar.Buttons(1),  "Click", THIS, "BtnVoltarClick")
1837:     ENDPROC
1838: 
1839:     *==========================================================================
1840:     * ConfigurarPaineisImpressao - Botao Imprime (pag_resultado.Imprime) e os
1841:     * dois paineis modais de selecao de impressao do legado:
1842:     *
1843:     *   cnt_4c_SelecionaImpCad      (SelecionaImpCad)      - visao CADASTRO
1844:     *   cnt_4c_SelecionaImpressao   (SelecionaImpress?o)   - visao MOVIMENTO
1845:     *==========================================================================
1846:     PROTECTED PROCEDURE ConfigurarPaineisImpressao()
1847:         LOCAL loc_oPg
1848:         loc_oPg = THIS.pgf_4c_Paginas.Page2
1849: 
1850:         loc_oPg.AddObject("cmd_4c_Imprime", "CommandButton")
1851:         WITH loc_oPg.cmd_4c_Imprime
1852:             .Top             = 134
1853:             .Left            = 858
1854:             .Width           = 137
1855:             .Height          = 37
1856:             .FontBold        = .T.
1857:             .FontItalic      = .T.
1858:             .FontName        = "Comic Sans MS"
1859:             .FontSize        = 8
1860:             .Caption         = "     \<Imprimir"
1861:             .ToolTipText     = "Impress" + CHR(227) + "o"
1862:             .PicturePosition = 1
1863:             .ForeColor       = RGB(90, 90, 90)
1864:             .BackColor       = RGB(255, 255, 255)
1865:             .Themes          = .F.
1866:             IF FILE(gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg")
1867:                 .Picture = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
1868:             ENDIF
1869:             .Visible = .T.
1870:         ENDWITH
1871:         BINDEVENT(loc_oPg.cmd_4c_Imprime, "Click", THIS, "BtnImprimeClick")
1872: 
1873:         THIS.ConfigurarPainelImpressaoCadastro(loc_oPg)
1874:         THIS.ConfigurarPainelImpressaoMovimento(loc_oPg)
1875:     ENDPROC
1876: 
1877:     *==========================================================================
1878:     * ConfigurarPainelImpressaoCadastro - SelecionaImpCad do legado: painel
1879:     * simples (5 checkboxes) usado quando Imprime eh acionado na visao
1880:     * CADASTRO.
1881:     *==========================================================================
1882:     PROTECTED PROCEDURE ConfigurarPainelImpressaoCadastro(par_oPg)
1883:         LOCAL loc_oCnt
1884:         par_oPg.AddObject("cnt_4c_SelecionaImpCad", "Container")
1885:         loc_oCnt = par_oPg.cnt_4c_SelecionaImpCad
1886: 
1887:         WITH loc_oCnt
1888:             .Top           = 213
1889:             .Left          = 270
1890:             .Width         = 458
1891:             .Height        = 178
1892:             .SpecialEffect = 0
1893:             .BackColor     = RGB(255, 255, 255)
1894:             IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
1895:                 .Picture = gc_4c_CaminhoIcones + "new_background.jpg"
1896:             ENDIF
1897:             .Visible = .F.
1898:         ENDWITH
1899: 
1900:         loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
1901:         WITH loc_oCnt.lbl_4c_Titulo
1902:             .Top       = 6
1903:             .Left      = 5
1904:             .Width     = 226
1905:             .Height    = 17
1906:             .AutoSize  = .F.
1907:             .FontBold  = .T.
1908:             .FontName  = "Tahoma"
1909:             .FontSize  = 8
1910:             .BackStyle = 0
1911:             .ForeColor = RGB(90, 90, 90)
1912:             .Caption   = "Impress" + CHR(227) + "o da Consulta (Cadastro)"
1913:             .Visible   = .T.
1914:         ENDWITH
1915: 
1916:         loc_oCnt.AddObject("chk_4c_Generico", "CheckBox")
1917:         WITH loc_oCnt.chk_4c_Generico
1918:             .Top       = 37
1919:             .Left      = 18
1920:             .Width     = 99
1921:             .Height    = 15
1922:             .AutoSize  = .T.

*-- Linhas 1996 a 2113:
1996:             .Caption   = "Impressora 40 colunas"
1997:             .Value     = 1
1998:             .Visible   = .T.
1999:         ENDWITH
2000: 
2001:         loc_oCnt.AddObject("cmd_4c_Visualizar", "CommandButton")
2002:         WITH loc_oCnt.cmd_4c_Visualizar
2003:             .Top             = 4
2004:             .Left            = 231
2005:             .Width           = 75
2006:             .Height          = 75
2007:             .FontBold        = .T.
2008:             .FontItalic      = .T.
2009:             .FontName        = "Comic Sans MS"
2010:             .PicturePosition = 13
2011:             .Caption         = "V" + CHR(237) + "deo"
2012:             .ForeColor       = RGB(90, 90, 90)
2013:             .BackColor       = RGB(255, 255, 255)
2014:             .Themes          = .F.
2015:             IF FILE(gc_4c_CaminhoIcones + "relatorio_video_26.jpg")
2016:                 .Picture = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
2017:             ENDIF
2018:             .Visible = .T.
2019:         ENDWITH
2020: 
2021:         loc_oCnt.AddObject("cmd_4c_Imprimir", "CommandButton")
2022:         WITH loc_oCnt.cmd_4c_Imprimir
2023:             .Top             = 4
2024:             .Left            = 306
2025:             .Width           = 75
2026:             .Height          = 75
2027:             .FontBold        = .T.
2028:             .FontItalic      = .T.
2029:             .FontName        = "Comic Sans MS"
2030:             .WordWrap        = .F.
2031:             .PicturePosition = 13
2032:             .Caption         = " Impressora    "
2033:             .ForeColor       = RGB(90, 90, 90)
2034:             .BackColor       = RGB(255, 255, 255)
2035:             .Themes          = .F.
2036:             IF FILE(gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg")
2037:                 .Picture = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
2038:             ENDIF
2039:             .Visible = .T.
2040:         ENDWITH
2041: 
2042:         loc_oCnt.AddObject("cmd_4c_Saida", "CommandButton")
2043:         WITH loc_oCnt.cmd_4c_Saida
2044:             .Top        = 4
2045:             .Left        = 379
2046:             .Width       = 75
2047:             .Height      = 75
2048:             .FontBold    = .T.
2049:             .FontItalic  = .T.
2050:             .FontName    = "Comic Sans MS"
2051:             .FontSize    = 8
2052:             .Cancel      = .T.
2053:             .Caption     = "Encerrar"
2054:             .ForeColor   = RGB(90, 90, 90)
2055:             .BackColor   = RGB(255, 255, 255)
2056:             .Themes      = .F.
2057:             IF FILE(gc_4c_CaminhoIcones + "cadastro_sair_60.jpg")
2058:                 .Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
2059:             ENDIF
2060:             .Visible = .T.
2061:         ENDWITH
2062: 
2063:         BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnImpCadVisualizarClick")
2064:         BINDEVENT(loc_oCnt.cmd_4c_Imprimir,   "Click", THIS, "BtnImpCadImprimirClick")
2065:         BINDEVENT(loc_oCnt.cmd_4c_Saida,      "Click", THIS, "BtnImpCadSaidaClick")
2066:     ENDPROC
2067: 
2068:     *==========================================================================
2069:     * ConfigurarPainelImpressaoMovimento - SelecionaImpress?o do legado:
2070:     * painel completo (14 checkboxes + periodo de produtos adquiridos) usado
2071:     * quando Imprime eh acionado na visao MOVIMENTO.
2072:     *==========================================================================
2073:     PROTECTED PROCEDURE ConfigurarPainelImpressaoMovimento(par_oPg)
2074:         LOCAL loc_oCnt, loc_oProd
2075:         par_oPg.AddObject("cnt_4c_SelecionaImpressao", "Container")
2076:         loc_oCnt = par_oPg.cnt_4c_SelecionaImpressao
2077: 
2078:         WITH loc_oCnt
2079:             .Top           = 145
2080:             .Left          = 295
2081:             .Width         = 409
2082:             .Height        = 315
2083:             .SpecialEffect = 0
2084:             .BackColor     = RGB(255, 255, 255)
2085:             IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
2086:                 .Picture = gc_4c_CaminhoIcones + "new_background.jpg"
2087:             ENDIF
2088:             .Visible = .F.
2089:         ENDWITH
2090: 
2091:         loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
2092:         WITH loc_oCnt.lbl_4c_Titulo
2093:             .Top       = 12
2094:             .Left      = 10
2095:             .Width     = 132
2096:             .Height    = 15
2097:             .AutoSize  = .T.
2098:             .FontBold  = .T.
2099:             .FontName  = "Tahoma"
2100:             .FontSize  = 8
2101:             .BackStyle = 0
2102:             .ForeColor = RGB(90, 90, 90)
2103:             .Caption   = "Impress" + CHR(227) + "o da Consulta"
2104:             .Visible   = .T.
2105:         ENDWITH
2106: 
2107:         loc_oCnt.AddObject("chk_4c_Saldo", "CheckBox")
2108:         WITH loc_oCnt.chk_4c_Saldo
2109:             .Top       = 88
2110:             .Left      = 10
2111:             .Width     = 137
2112:             .Height    = 15
2113:             .AutoSize  = .T.

*-- Linhas 2409 a 2672:
2409:             .ForeColor     = RGB(0, 0, 0)
2410:             .SpecialEffect = 1
2411:             .Visible       = .T.
2412:         ENDWITH
2413: 
2414:         loc_oCnt.AddObject("cmd_4c_Visualizar", "CommandButton")
2415:         WITH loc_oCnt.cmd_4c_Visualizar
2416:             .Top             = 4
2417:             .Left            = 179
2418:             .Width           = 75
2419:             .Height          = 75
2420:             .FontBold        = .T.
2421:             .FontItalic      = .T.
2422:             .FontName        = "Comic Sans MS"
2423:             .WordWrap        = .F.
2424:             .PicturePosition = 13
2425:             .Caption         = "    V" + CHR(237) + "deo            "
2426:             .ForeColor       = RGB(90, 90, 90)
2427:             .BackColor       = RGB(255, 255, 255)
2428:             .Themes          = .F.
2429:             IF FILE(gc_4c_CaminhoIcones + "relatorio_video_26.jpg")
2430:                 .Picture = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
2431:             ENDIF
2432:             .Visible = .T.
2433:         ENDWITH
2434: 
2435:         loc_oCnt.AddObject("cmd_4c_Imprimir", "CommandButton")
2436:         WITH loc_oCnt.cmd_4c_Imprimir
2437:             .Top             = 4
2438:             .Left            = 254
2439:             .Width           = 75
2440:             .Height          = 75
2441:             .FontBold        = .T.
2442:             .FontItalic      = .T.
2443:             .FontName        = "Comic Sans MS"
2444:             .WordWrap        = .F.
2445:             .PicturePosition = 13
2446:             .Caption         = " Impressora    "
2447:             .ForeColor       = RGB(90, 90, 90)
2448:             .BackColor       = RGB(255, 255, 255)
2449:             .Themes          = .F.
2450:             IF FILE(gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg")
2451:                 .Picture = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
2452:             ENDIF
2453:             .Visible = .T.
2454:         ENDWITH
2455: 
2456:         loc_oCnt.AddObject("cmd_4c_Saida", "CommandButton")
2457:         WITH loc_oCnt.cmd_4c_Saida
2458:             .Top             = 4
2459:             .Left            = 329
2460:             .Width           = 75
2461:             .Height          = 75
2462:             .FontBold        = .T.
2463:             .FontItalic      = .T.
2464:             .FontName        = "Comic Sans MS"
2465:             .FontSize        = 8
2466:             .Cancel          = .T.
2467:             .PicturePosition = 13
2468:             .Caption         = "Encerrar"
2469:             .ForeColor       = RGB(90, 90, 90)
2470:             .BackColor       = RGB(255, 255, 255)
2471:             .Themes          = .F.
2472:             IF FILE(gc_4c_CaminhoIcones + "cadastro_sair_60.jpg")
2473:                 .Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
2474:             ENDIF
2475:             .Visible = .T.
2476:         ENDWITH
2477: 
2478:         BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnImpMovVisualizarClick")
2479:         BINDEVENT(loc_oCnt.cmd_4c_Imprimir,   "Click", THIS, "BtnImpMovImprimirClick")
2480:         BINDEVENT(loc_oCnt.cmd_4c_Saida,      "Click", THIS, "BtnImpMovSaidaClick")
2481:     ENDPROC
2482: 
2483:     *==========================================================================
2484:     * BtnImprimeClick - Imprime.Click do legado: centraliza o painel de
2485:     * impressao correto (SelecionaImpressao na visao MOVIMENTO,
2486:     * SelecionaImpCad na visao CADASTRO - distincao por cmg_4c_MudaCli.
2487:     * Visible, regra #40: so um dos dois MudaCli/MudaMov fica visivel por
2488:     * vez, e MudaCli visivel = visao MOVIMENTO em curso) e desabilita o
2489:     * resto da tela enquanto o painel esta aberto.
2490:     *==========================================================================
2491:     PROCEDURE BtnImprimeClick()
2492:         LOCAL loc_oPg, loc_oPainel, loc_nLeft, loc_nTop
2493: 
2494:         loc_oPg = THIS.pgf_4c_Paginas.Page2
2495:         loc_oPg.cmd_4c_Imprime.Enabled = .F.
2496: 
2497:         loc_oPainel = IIF(loc_oPg.cmg_4c_MudaCli.Visible, ;
2498:             loc_oPg.cnt_4c_SelecionaImpressao, loc_oPg.cnt_4c_SelecionaImpCad)
2499: 
2500:         loc_nLeft = INT(THIS.Width - loc_oPainel.Width)
2501:         loc_nLeft = IIF(loc_nLeft > 0, INT(loc_nLeft / 2), 0)
2502:         loc_nTop  = INT(THIS.Height - loc_oPainel.Height)
2503:         loc_nTop  = IIF(loc_nTop > 0, INT(loc_nTop / 2), 0)
2504: 
2505:         loc_oPainel.Left    = loc_nLeft
2506:         loc_oPainel.Top     = loc_nTop
2507:         loc_oPainel.Visible = .T.
2508:         loc_oPainel.ZOrder(0)
2509: 
2510:         THIS.DesabilitarControlesImpressao()
2511:     ENDPROC
2512: 
2513:     *==========================================================================
2514:     * DesabilitarControlesImpressao / RestaurarControlesImpressao - bloco
2515:     * repetido nos dois paineis (Saida/Visualizar/Imprimir) do legado para
2516:     * travar/destravar o resto da tela enquanto o popup de impressao esta
2517:     * aberto. cntConta (visao cadastral) ainda nao existe nesta migracao
2518:     * (fica para a fase do wrapper clsconta) - guardado por PEMSTATUS.
2519:     *==========================================================================
2520:     PROTECTED PROCEDURE DesabilitarControlesImpressao()
2521:         LOCAL loc_oPg
2522:         loc_oPg = THIS.pgf_4c_Paginas.Page2
2523: 
2524:         THIS.pgf_4c_Paginas.Page1.Enabled = .F.
2525:         loc_oPg.pgf_4c_Resultado.Enabled  = .F.
2526:         IF PEMSTATUS(loc_oPg, "cntConta", 5)
2527:             loc_oPg.cntConta.Enabled = .F.
2528:         ENDIF
2529:         loc_oPg.cmg_4c_MudaMov.Enabled = .F.
2530:         loc_oPg.cmg_4c_MudaCli.Enabled = .F.
2531:         loc_oPg.cmg_4c_Voltar.Enabled  = .F.
2532:     ENDPROC
2533: 
2534:     PROTECTED PROCEDURE RestaurarControlesImpressao()
2535:         LOCAL loc_oPg
2536:         loc_oPg = THIS.pgf_4c_Paginas.Page2
2537: 
2538:         THIS.pgf_4c_Paginas.Page1.Enabled = .T.
2539:         loc_oPg.pgf_4c_Resultado.Enabled  = .T.
2540:         IF PEMSTATUS(loc_oPg, "cntConta", 5)
2541:             loc_oPg.cntConta.Enabled = .T.
2542:         ENDIF
2543:         loc_oPg.cmg_4c_MudaMov.Enabled = .T.
2544:         loc_oPg.cmg_4c_MudaCli.Enabled = .T.
2545:         loc_oPg.cmg_4c_Voltar.Enabled  = .T.
2546:         loc_oPg.cmd_4c_Imprime.Enabled = .T.
2547:     ENDPROC
2548: 
2549:     *==========================================================================
2550:     * BtnImpCadSaidaClick / BtnImpCadVisualizarClick / BtnImpCadImprimirClick
2551:     * Saida/Visualizar/Imprimir.Click do SelecionaImpCad legado.
2552:     *==========================================================================
2553:     PROCEDURE BtnImpCadSaidaClick()
2554:         THIS.pgf_4c_Paginas.Page2.cnt_4c_SelecionaImpCad.Visible = .F.
2555:         THIS.RestaurarControlesImpressao()
2556:     ENDPROC
2557: 
2558:     PROCEDURE BtnImpCadVisualizarClick()
2559:         LOCAL loc_oPnl
2560:         loc_oPnl = THIS.pgf_4c_Paginas.Page2.cnt_4c_SelecionaImpCad
2561:         THIS.ImpressaoCad("V", loc_oPnl.chk_4c_Generico.Value = 1, ;
2562:             loc_oPnl.chk_4c_Pessoais.Value = 1, loc_oPnl.chk_4c_Bancarias.Value = 1, ;
2563:             loc_oPnl.chk_4c_Followup.Value = 1, loc_oPnl.chk_4c_Impressora.Value = 1)
2564:         loc_oPnl.Visible = .F.
2565:         THIS.RestaurarControlesImpressao()
2566:     ENDPROC
2567: 
2568:     PROCEDURE BtnImpCadImprimirClick()
2569:         LOCAL loc_oPnl
2570:         loc_oPnl = THIS.pgf_4c_Paginas.Page2.cnt_4c_SelecionaImpCad
2571:         THIS.ImpressaoCad("I", loc_oPnl.chk_4c_Generico.Value = 1, ;
2572:             loc_oPnl.chk_4c_Pessoais.Value = 1, loc_oPnl.chk_4c_Bancarias.Value = 1, ;
2573:             loc_oPnl.chk_4c_Followup.Value = 1, loc_oPnl.chk_4c_Impressora.Value = 1)
2574:         loc_oPnl.Visible = .F.
2575:         THIS.RestaurarControlesImpressao()
2576:     ENDPROC
2577: 
2578:     *==========================================================================
2579:     * BtnImpMovSaidaClick / BtnImpMovVisualizarClick / BtnImpMovImprimirClick
2580:     * Saida/Visualizar/Imprimir.Click do SelecionaImpress?o legado.
2581:     *==========================================================================
2582:     PROCEDURE BtnImpMovSaidaClick()
2583:         THIS.pgf_4c_Paginas.Page2.cnt_4c_SelecionaImpressao.Visible = .F.
2584:         THIS.RestaurarControlesImpressao()
2585:     ENDPROC
2586: 
2587:     PROCEDURE BtnImpMovVisualizarClick()
2588:         LOCAL loc_oPnl
2589:         loc_oPnl = THIS.pgf_4c_Paginas.Page2.cnt_4c_SelecionaImpressao
2590:         THIS.Impressao("V", loc_oPnl.chk_4c_Saldo.Value = 1, loc_oPnl.chk_4c_Limite.Value = 1, ;
2591:             loc_oPnl.chk_4c_ChqPend.Value = 1, loc_oPnl.chk_4c_ChqDev.Value = 1, ;
2592:             loc_oPnl.chk_4c_ChqDep.Value = 1, loc_oPnl.chk_4c_Cartao.Value = 1, ;
2593:             loc_oPnl.chk_4c_Pend.Value = 1, loc_oPnl.chk_4c_MovPend.Value = 1, .F., ;
2594:             loc_oPnl.chk_4c_Negociado.Value = 1, loc_oPnl.chk_4c_ResVenda.Value = 1, ;
2595:             loc_oPnl.chk_4c_ProdAdq.Value = 1, loc_oPnl.chk_4c_Producao.Value = 1, ;
2596:             loc_oPnl.chk_4c_Estoque.Value = 1)
2597:         loc_oPnl.Visible = .F.
2598:         THIS.RestaurarControlesImpressao()
2599:     ENDPROC
2600: 
2601:     PROCEDURE BtnImpMovImprimirClick()
2602:         LOCAL loc_oPnl
2603:         loc_oPnl = THIS.pgf_4c_Paginas.Page2.cnt_4c_SelecionaImpressao
2604:         THIS.Impressao("I", loc_oPnl.chk_4c_Saldo.Value = 1, loc_oPnl.chk_4c_Limite.Value = 1, ;
2605:             loc_oPnl.chk_4c_ChqPend.Value = 1, loc_oPnl.chk_4c_ChqDev.Value = 1, ;
2606:             loc_oPnl.chk_4c_ChqDep.Value = 1, loc_oPnl.chk_4c_Cartao.Value = 1, ;
2607:             loc_oPnl.chk_4c_Pend.Value = 1, loc_oPnl.chk_4c_MovPend.Value = 1, ;
2608:             loc_oPnl.chk_4c_Imp40.Value = 1, loc_oPnl.chk_4c_Negociado.Value = 1, ;
2609:             loc_oPnl.chk_4c_ResVenda.Value = 1, loc_oPnl.chk_4c_ProdAdq.Value = 1, ;
2610:             loc_oPnl.chk_4c_Producao.Value = 1, loc_oPnl.chk_4c_Estoque.Value = 1)
2611:         loc_oPnl.Visible = .F.
2612:         THIS.RestaurarControlesImpressao()
2613:     ENDPROC
2614: 
2615:     *==========================================================================
2616:     * AlternarPagina - FUNIL de troca de pagina (regra #40). Alem de mudar o
2617:     * ActivePage (DODEFAULT -> FormBase), repoe o modo corrente e a altura do
2618:     * form, e repinta as grades quando a pagina Resultado fica visivel.
2619:     *
2620:     * Altura: o legado trabalha com a tela encolhida em 300 na pagina Consulta
2621:     * (ThisForm.Height = 300 no proprio Init e no cmd_voltar.Click) e em 600
2622:     * na pagina Resultado (cmd_cadastro.Click/cmd_movimenta.Click). Reproduzir
2623:     * isso faz o relatorio de UI Fidelity acusar DIFERENCA de Height contra o
2624:     * valor DECLARADO no SCX (600) - eh falso positivo conhecido do comparador,
2625:     * que le o dump estatico e nao executa o Init legado.
2626:     *
2627:     * Limpeza dos campos: so na VOLTA da pagina Resultado (cmd_voltar.Click do
2628:     * legado limpa Conta/Nome/CPF/Conjuge/Telefone). Na abertura da tela nao
2629:     * se limpa nada, senao a conta recebida por parametro no Init seria
2630:     * descartada.
2631:     *==========================================================================
2632:     PROCEDURE AlternarPagina(par_nPagina)
2633:         LOCAL loc_lVoltando, loc_oCnt, loc_oErro
2634: 
2635:         loc_lVoltando = (par_nPagina = 1 AND THIS.this_cModoAtual == "RESULTADO")
2636: 
2637:         DODEFAULT(par_nPagina)
2638: 
2639:         DO CASE
2640:             CASE par_nPagina = 1
2641:                 THIS.this_cModoAtual = "CONSULTA"
2642: 
2643:                 IF THIS.Height <> 300
2644:                     THIS.Height = 300
2645:                 ENDIF
2646: 
2647:                 IF loc_lVoltando
2648:                     *-- Limpeza dos cinco criterios + LimparDados do BO, num
2649:                     *-- funil unico (LimparCampos) - o bloco do cmd_voltar.Click
2650:                     loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
2651:                     THIS.LimparCampos()
2652: 
2653:                     TRY
2654:                         loc_oCnt.txt_4c_Conta.SetFocus()
2655:                     CATCH TO loc_oErro
2656:                         *-- SetFocus falha com a pagina ainda nao pintada ou em
2657:                         *-- modo de teste automatizado: nao eh erro de negocio
2658:                     ENDTRY
2659:                 ELSE
2660:                     *-- Abertura da tela: nada a limpar (a conta pode ter vindo
2661:                     *-- por parametro no Init), mas a cascata de When do legado
2662:                     *-- precisa valer desde o primeiro desenho
2663:                     THIS.HabilitarCampos(.T.)
2664:                 ENDIF
2665: 
2666:             CASE par_nPagina = 2
2667:                 THIS.this_cModoAtual = "RESULTADO"
2668: 
2669:                 IF THIS.Height <> 600
2670:                     THIS.Height = 600
2671:                 ENDIF
2672: 

*-- Linhas 2690 a 2823:
2690:     * PUBLIC de proposito: eh chamado de fora da classe pelos botoes e pelo
2691:     * harness de teste automatizado (regra #3).
2692:     *==========================================================================
2693:     PROCEDURE CarregarDados()
2694:         LOCAL loc_lSucesso, loc_oCnt, loc_oErro
2695:         loc_lSucesso = .F.
2696: 
2697:         TRY
2698:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2699:                 *-- Criterios e periodo da tela -> BO num funil unico
2700:                 *-- (fonte unica eh o campo, nao a property)
2701:                 THIS.FormParaBO()
2702: 
2703:                 loc_lSucesso = THIS.this_oBusinessObject.CarregarHistoricoSaldo()
2704: 
2705:                 IF !loc_lSucesso AND !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
2706:                     MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
2707:                         "Consulta de Saldo")
2708:                 ENDIF
2709: 
2710:                 THIS.AtualizarGradesSaldo()
2711: 
2712:                 *-- Abas alimentadas pelo mesmo Processa() legado (Pendencias,
2713:                 *-- Cheques) e pelos PCartao()/PEstoque() (Cartao, Estoque)
2714:                 THIS.CarregarAbasResultado()
2715:             ENDIF
2716:         CATCH TO loc_oErro
2717:             MsgErro(loc_oErro.Message + CHR(13) + ;
2718:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2719:                 "Proc: " + loc_oErro.Procedure, "Erro ao carregar a consulta")
2720:         ENDTRY
2721: 
2722:         RETURN loc_lSucesso
2723:     ENDPROC
2724: 
2725:     *==========================================================================
2726:     * AtualizarGradesSaldo - Funil UNICO de repintura das grades da aba Saldo
2727:     * (regra #21a: popular o cursor nao repinta a grade - o legado sempre
2728:     * fecha com "Go Top In <cursor>" + "<grid>.Refresh").
2729:     *
2730:     * Chamado no fim da carga E no AlternarPagina(2), DEPOIS da troca de
2731:     * ActivePage, porque Refresh em pagina oculta nao pinta (regra #46).
2732:     * PUBLIC: chamado de fora da classe (botoes e harness de teste).
2733:     *==========================================================================
2734:     PROCEDURE AtualizarGradesSaldo()
2735:         LOCAL loc_oAba, loc_oErro, loc_lTemAbas
2736: 
2737:         *-- Sem RETURN dentro do TRY (regra #1): o guard vira flag
2738:         TRY
2739:             loc_lTemAbas = PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "pgf_4c_Resultado", 5)
2740: 
2741:             IF loc_lTemAbas
2742:                 loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page1
2743: 
2744:                 IF USED("dbHistorico")
2745:                     SELECT dbHistorico
2746:                     GO TOP
2747:                 ENDIF
2748:                 IF USED("dbSaldo")
2749:                     SELECT dbSaldo
2750:                     GO TOP
2751:                 ENDIF
2752: 
2753:                 IF PEMSTATUS(loc_oAba, "grd_4c_Historico", 5)
2754:                     loc_oAba.grd_4c_Historico.Refresh()
2755:                 ENDIF
2756:                 IF PEMSTATUS(loc_oAba, "grd_4c_Saldo", 5)
2757:                     loc_oAba.grd_4c_Saldo.Refresh()
2758:                 ENDIF
2759:             ENDIF
2760:         CATCH TO loc_oErro
2761:             MsgErro(loc_oErro.Message + CHR(13) + ;
2762:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
2763:                 "Erro ao atualizar as grades de saldo")
2764:         ENDTRY
2765:     ENDPROC
2766: 
2767:     *==========================================================================
2768:     * AjustarVisibilidadeResultado - Funil UNICO de visibilidade da pagina
2769:     * Resultado, transcrito de cmd_cadastro.Click (Cmd_MudaCli) e de
2770:     * cmd_movimenta.Click (Cmd_MudaMov) do legado. Nos dois metodos o legado
2771:     * mexe exatamente no mesmo conjunto, em sentidos opostos:
2772:     *
2773:     *   visao CADASTRO  : Result/OptionGroup/cnt_periodo escondidos,
2774:     *                     MudaCli escondido e MudaMov visivel
2775:     *   visao MOVIMENTO : Result/OptionGroup/cnt_periodo visiveis,
2776:     *                     MudaMov escondido e MudaCli visivel
2777:     *
2778:     * O par MudaCli/MudaMov nunca fica visivel ao mesmo tempo - os dois estao
2779:     * no mesmo Left (794) no legado.
2780:     *
2781:     * PUBLIC: chamado de fora da classe (botoes da pagina Consulta e harness).
2782:     *==========================================================================
2783:     PROCEDURE AjustarVisibilidadeResultado(par_cModo)
2784:         LOCAL loc_oPg, loc_lMovimento, loc_oErro
2785: 
2786:         loc_lMovimento = (UPPER(ALLTRIM(IIF(VARTYPE(par_cModo) = "C", par_cModo, ""))) == "MOVIMENTO")
2787: 
2788:         TRY
2789:             loc_oPg = THIS.pgf_4c_Paginas.Page2
2790: 
2791:             THIS.this_cModoResultado = IIF(loc_lMovimento, "MOVIMENTO", "CADASTRO")
2792: 
2793:             loc_oPg.pgf_4c_Resultado.Visible   = loc_lMovimento
2794:             loc_oPg.pgf_4c_Resultado.Enabled   = loc_lMovimento
2795: 
2796:             loc_oPg.obj_4c_OptResultado.Visible = loc_lMovimento
2797:             loc_oPg.obj_4c_OptResultado.Enabled = loc_lMovimento
2798: 
2799:             loc_oPg.cnt_4c_Periodo.Visible = loc_lMovimento
2800:             loc_oPg.cnt_4c_Periodo.Enabled = loc_lMovimento
2801: 
2802:             *-- Visao CADASTRO oferece ir para MOVIMENTO, e vice-versa
2803:             loc_oPg.cmg_4c_MudaMov.Visible = !loc_lMovimento
2804:             loc_oPg.cmg_4c_MudaMov.Enabled = !loc_lMovimento
2805: 
2806:             loc_oPg.cmg_4c_MudaCli.Visible = loc_lMovimento
2807:             loc_oPg.cmg_4c_MudaCli.Enabled = loc_lMovimento
2808: 
2809:             *-- Saldo de cashback acompanha a visao cadastral
2810:             loc_oPg.lbl_4c_SaldoCash.Visible = !loc_lMovimento
2811:             loc_oPg.txt_4c_SaldoCash.Visible = !loc_lMovimento
2812: 
2813:             IF loc_lMovimento
2814:                 *-- Abre na aba 1 (Saldo), como o legado faz com ResultPageToSet
2815:                 IF loc_oPg.obj_4c_OptResultado.Value < 1
2816:                     loc_oPg.obj_4c_OptResultado.Value = 1
2817:                 ENDIF
2818:                 loc_oPg.pgf_4c_Resultado.ActivePage = loc_oPg.obj_4c_OptResultado.Value
2819:                 loc_oPg.pgf_4c_Resultado.Refresh()
2820:             ENDIF
2821: 
2822:             loc_oPg.Refresh()
2823:         CATCH TO loc_oErro

*-- Linhas 2832 a 3001:
2832:     ENDPROC
2833: 
2834:     *==========================================================================
2835:     * OptResultadoInteractiveChange - Optiongroup1.InteractiveChange do legado:
2836:     *   result.ActivePage = this.Value  +  result.Refresh()
2837:     * O Value do grupo eh 1..10 e, com as abas declaradas em ordem de
2838:     * PageOrder, cai direto na aba correspondente. Value = 0 (nenhuma opcao
2839:     * marcada, estado inicial do legado) nao troca de aba.
2840:     *==========================================================================
2841:     PROCEDURE OptResultadoInteractiveChange()
2842:         LOCAL loc_oPg, loc_nOpcao, loc_oErro
2843: 
2844:         TRY
2845:             loc_oPg    = THIS.pgf_4c_Paginas.Page2
2846:             loc_nOpcao = loc_oPg.obj_4c_OptResultado.Value
2847: 
2848:             IF BETWEEN(loc_nOpcao, 1, loc_oPg.pgf_4c_Resultado.PageCount)
2849:                 loc_oPg.pgf_4c_Resultado.ActivePage = loc_nOpcao
2850:                 loc_oPg.pgf_4c_Resultado.Refresh()
2851: 
2852:                 *-- Repintura da aba que acabou de ficar a vista
2853:                 THIS.AtualizarAbaResultadoAtiva()
2854:             ENDIF
2855:         CATCH TO loc_oErro
2856:             MsgErro(loc_oErro.Message + CHR(13) + ;
2857:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
2858:                 "Erro ao trocar de aba")
2859:         ENDTRY
2860:     ENDPROC
2861: 
2862:     *==========================================================================
2863:     * DtPeriodoLostFocus - Recarrega a consulta quando o periodo muda
2864:     * (get_dt_final.LostFocus do legado: ConsultaExecutada = .f. + Processa()).
2865:     * Nao faz nada enquanto a pagina Resultado nao estiver em uso, para nao
2866:     * disparar consulta so por passar o foco pelos campos.
2867:     *==========================================================================
2868:     PROCEDURE DtPeriodoLostFocus()
2869:         IF THIS.this_cModoAtual == "RESULTADO"
2870:             THIS.this_oBusinessObject.this_lConsultaExecutada = .F.
2871:             THIS.CarregarDados()
2872:         ENDIF
2873:     ENDPROC
2874: 
2875:     *==========================================================================
2876:     * BtnMudaCliClick - cmd_cadastro.Click do Cmd_MudaCli legado: troca a
2877:     * pagina Resultado para a visao CADASTRO.
2878:     *==========================================================================
2879:     PROCEDURE BtnMudaCliClick()
2880:         THIS.this_oBusinessObject.this_cEscolha = "ALTERAR"
2881:         THIS.AjustarVisibilidadeResultado("CADASTRO")
2882:     ENDPROC
2883: 
2884:     *==========================================================================
2885:     * BtnMudaMovClick - cmd_movimenta.Click do Cmd_MudaMov legado: troca a
2886:     * pagina Resultado para a visao MOVIMENTO.
2887:     *==========================================================================
2888:     PROCEDURE BtnMudaMovClick()
2889:         THIS.this_oBusinessObject.this_cEscolha = "CONSULTAR"
2890:         THIS.AjustarVisibilidadeResultado("MOVIMENTO")
2891:         THIS.AtualizarGradesSaldo()
2892:     ENDPROC
2893: 
2894:     *==========================================================================
2895:     * BtnVoltarClick - cmd_voltar.Click do grp_operacao da pagina Resultado.
2896:     * Com Automatico = .T. (tela aberta por outro form apenas para mostrar uma
2897:     * conta) o legado FECHA e devolve o controle ao chamador; caso contrario
2898:     * volta para a pagina Consulta, que eh o que o funil AlternarPagina(1) faz
2899:     * (limpa os campos, encolhe a tela e devolve o foco ao campo Conta).
2900:     *==========================================================================
2901:     PROCEDURE BtnVoltarClick()
2902:         *-- Bloco de gravacao que abre o cmd_voltar.Click legado: em modo
2903:         *-- ALTERAR pergunta e grava o cadastro antes de sair, e mValidaObj()
2904:         *-- recusando mantem a tela aberta (o "Return .f." do legado)
2905:         IF !THIS.BtnSalvarClick()
2906:             RETURN
2907:         ENDIF
2908: 
2909:         IF THIS.this_oBusinessObject.this_lAutomatico
2910:             THIS.BtnEncerrarClick()
2911:         ELSE
2912:             THIS.AlternarPagina(1)
2913:         ENDIF
2914:     ENDPROC
2915: 
2916:     *==========================================================================
2917:     * ConfigurarPaginaDados - Funil dos CAMPOS DE DADOS da pagina Resultado,
2918:     * isto eh, o conteudo de cada aba do PageFrame interno (Result do legado).
2919:     *
2920:     * A Fase 4 entregou a moldura (as 10 abas, o OptionGroup de navegacao, o
2921:     * filtro de periodo e a barra Cadastro/Movimento/Voltar) mais o conteudo da
2922:     * aba 1 (Saldo). Esta fase acrescenta o conteudo das abas alimentadas pelo
2923:     * Processa()/PCartao()/PEstoque() do legado:
2924:     *
2925:     *   aba 2 Pendencias  - grade TmpPar + grade de formas de pagamento
2926:     *                       (crTmpTipos, com CheckBox marcavel) + total
2927:     *   aba 3 Cheques     - quatro grades (aberto / follow-up / titulos /
2928:     *                       devolvidos) + os nove totais do pe da pagina
2929:     *   aba 4 Cartao      - grade TmpCart (cartoes em aberto)
2930:     *   aba 6 Estoque     - grade dbEstoque (produtos em poder do cliente)
2931:     *
2932:     * As abas 5 (Vendas), 7 (Operacoes Pend.), 8 (Producao), 9 (Historico
2933:     * de Cheques) e 10 (Credito) sao alimentadas por PProduto()/PVenda()/
2934:     * mAtivaHCheque()/mAtivaCredito() do legado - os quatro compartilham o mesmo
2935:     * bloco de cursores (dbProduto/dbProdTodos/dbOperac/dbConserto/dbOpera/
2936:     * dbProduc/dbItens) e por isso formam uma unidade, entregue na fase
2937:     * seguinte junto com o wrapper clsconta e o bloco de impressao.
2938:     *==========================================================================
2939:     PROTECTED PROCEDURE ConfigurarPaginaDados()
2940:         THIS.ConfigurarAbaPendencias()
2941:         THIS.ConfigurarAbaCheques()
2942:         THIS.ConfigurarAbaCartao()
2943:         THIS.ConfigurarAbaEstoque()
2944:         THIS.ConfigurarAbaHCheques()
2945:         THIS.ConfigurarAbaCredito()
2946:     ENDPROC
2947: 
2948:     *==========================================================================
2949:     * ConfigurarAbaPendencias - Aba 2 (Result.Pendencias do legado):
2950:     *
2951:     *   Grd_Pendente -> grd_4c_Pendentes  (TmpPar, 6 colunas)
2952:     *   grdTipos     -> grd_4c_TiposPend  (crTmpTipos, CheckBox marcavel)
2953:     *   Cmb_Grupo    -> cbo_4c_GrupoPend  (filtro de grupo)
2954:     *   getTotPends  -> txt_4c_TotPend    (total do que esta visivel na grade)
2955:     *   Anexa        -> cmd_4c_AnexaPend  (abre o documento da pendencia)
2956:     *   CmdImpPend   -> cmd_4c_ImpPend    (listagem SigReIpd)
2957:     *
2958:     * As colunas sao declaradas na ordem de ColumnOrder do dump (vencto, O,
2959:     * valor, moeda, tipo, historico), que eh a ordem em que o legado as mostra.
2960:     *==========================================================================
2961:     PROTECTED PROCEDURE ConfigurarAbaPendencias()
2962:         LOCAL loc_oPg, loc_oGrid
2963:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page2
2964: 
2965:         loc_oPg.AddObject("shp_4c_Pendencias", "Shape")
2966:         WITH loc_oPg.shp_4c_Pendencias
2967:             .Top         = 42
2968:             .Left        = 18
2969:             .Width       = 735
2970:             .Height      = 413
2971:             .BackStyle   = 0
2972:             .BorderColor = RGB(90, 90, 90)
2973:             .Visible     = .T.
2974:         ENDWITH
2975: 
2976:         loc_oPg.AddObject("lbl_4c_GrupoPend", "Label")
2977:         WITH loc_oPg.lbl_4c_GrupoPend
2978:             .Top       = 53
2979:             .Left      = 42
2980:             .Width     = 41
2981:             .Height    = 15
2982:             .AutoSize  = .F.
2983:             .Alignment = 0
2984:             .FontName  = "Tahoma"
2985:             .FontSize  = 8
2986:             .BackStyle = 0
2987:             .ForeColor = RGB(90, 90, 90)
2988:             .Caption   = "Grupo : "
2989:             .Visible   = .T.
2990:         ENDWITH
2991: 
2992:         loc_oPg.AddObject("cbo_4c_GrupoPend", "ComboBox")
2993:         WITH loc_oPg.cbo_4c_GrupoPend
2994:             .Top           = 49
2995:             .Left          = 85
2996:             .Width         = 300
2997:             .Height        = 24
2998:             .Style         = 2
2999:             .RowSourceType = 0
3000:             .FontName      = "Tahoma"
3001:             .FontSize      = 8

*-- Linhas 3147 a 3196:
3147:         *-- CheckBox de grade nao alterna pelo binding nativo: os quatro
3148:         *-- handlers (Click/MouseDown suprimem o toggle padrao, MouseUp e
3149:         *-- KeyPress alternam por codigo) sao obrigatorios
3150:         BINDEVENT(loc_oGrid.Columns(1).chk_4c_TipoPend, "Click", ;
3151:             THIS, "ChkTipoPendClick")
3152:         BINDEVENT(loc_oGrid.Columns(1).chk_4c_TipoPend, "MouseDown", ;
3153:             THIS, "ChkTipoPendMouseDown")
3154:         BINDEVENT(loc_oGrid.Columns(1).chk_4c_TipoPend, "MouseUp", ;
3155:             THIS, "ChkTipoPendMouseUp")
3156:         BINDEVENT(loc_oGrid.Columns(1).chk_4c_TipoPend, "KeyPress", ;
3157:             THIS, "ChkTipoPendKeyPress")
3158: 
3159:         *-- Total das pendencias visiveis (getTotPends)
3160:         loc_oPg.AddObject("txt_4c_TotPend", "TextBox")
3161:         WITH loc_oPg.txt_4c_TotPend
3162:             .Top           = 427
3163:             .Left          = 56
3164:             .Width         = 150
3165:             .Height        = 23
3166:             .FontName      = "Tahoma"
3167:             .FontSize      = 8
3168:             .Value         = 0
3169:             .InputMask     = "999,999,999.99"
3170:             .ReadOnly      = .T.
3171:             .ForeColor     = RGB(0, 0, 0)
3172:             .BorderColor   = RGB(100, 100, 100)
3173:             .SpecialEffect = 1
3174:             .Visible       = .T.
3175:         ENDWITH
3176: 
3177:         *-- Botao "Documento" (Anexa). Icone-only (Caption = ""): Picture +
3178:         *-- DisabledPicture + Themes = .T. para o icone desenhar sempre, e o
3179:         *-- botao NUNCA eh desabilitado em runtime - a condicao que o legado
3180:         *-- usava para habilitar/desabilitar vive dentro do proprio handler.
3181:         loc_oPg.AddObject("cmd_4c_AnexaPend", "CommandButton")
3182:         WITH loc_oPg.cmd_4c_AnexaPend
3183:             .Top             = 180
3184:             .Left            = 835
3185:             .Width           = 40
3186:             .Height          = 40
3187:             .FontName        = "Verdana"
3188:             .FontSize        = 8
3189:             .Caption         = ""
3190:             .Picture         = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
3191:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
3192:             .ToolTipText     = "Documento"
3193:             .ForeColor       = RGB(36, 84, 155)
3194:             .BackColor       = RGB(255, 255, 255)
3195:             .Themes          = .T.
3196:             .Visible         = .T.

*-- Linhas 3214 a 3279:
3214:             .Visible         = .T.
3215:         ENDWITH
3216: 
3217:         BINDEVENT(loc_oPg.cbo_4c_GrupoPend, "InteractiveChange", ;
3218:             THIS, "CboGrupoPendInteractiveChange")
3219:         BINDEVENT(loc_oPg.cmd_4c_AnexaPend, "Click", THIS, "BtnAnexaPendClick")
3220:         BINDEVENT(loc_oPg.cmd_4c_ImpPend,   "Click", THIS, "BtnImpPendClick")
3221:     ENDPROC
3222: 
3223:     *==========================================================================
3224:     * ConfigurarAbaCheques - Aba 3 (Result.Cheque do legado). Tem quatro grades
3225:     * e doze campos somente-leitura:
3226:     *
3227:     *   grd_che_aberto    -> grd_4c_ChequeAberto    (dbAberto)
3228:     *   Grd_followup      -> grd_4c_ChequeFollowup  (DbFollow)
3229:     *   Grd_titulo        -> grd_4c_ChequeTitulo    (DbTitulo)
3230:     *   grd_che_devolvido -> grd_4c_ChequeDevolvido (dbDevolvido)
3231:     *
3232:     * Os Shapes sao as molduras dos quatro blocos (BackStyle = 0, so a borda) e
3233:     * os dois quadradinhos de 14x14 sao a LEGENDA de cor da grade de cheques em
3234:     * aberto: verde-claro = tem follow-up, vermelho = devolvido.
3235:     *
3236:     * Os campos de total sao somente-leitura no legado (When devolvendo .F.) -
3237:     * aqui vao com ReadOnly = .T., que eh o equivalente sem BINDEVENT em "When".
3238:     *==========================================================================
3239:     PROTECTED PROCEDURE ConfigurarAbaCheques()
3240:         LOCAL loc_oPg, loc_oGrid
3241:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page3
3242: 
3243:         *-- Molduras dos quatro blocos
3244:         THIS.AdicionarMolduraAba(loc_oPg, "shp_4c_ChequeAberto",      61,   8, 479, 129)
3245:         THIS.AdicionarMolduraAba(loc_oPg, "shp_4c_ChequeFollowup",    61, 494, 482, 129)
3246:         THIS.AdicionarMolduraAba(loc_oPg, "shp_4c_ChequeTitulo",     203,   8, 479, 108)
3247:         THIS.AdicionarMolduraAba(loc_oPg, "shp_4c_ChequeDevolvido",  203, 494, 393, 108)
3248:         THIS.AdicionarMolduraAba(loc_oPg, "shp_4c_HistDevolvido",    231, 888, 110,  45)
3249:         THIS.AdicionarMolduraAba(loc_oPg, "shp_4c_ContasReceber",    325, 493, 471, 119)
3250:         THIS.AdicionarMolduraAba(loc_oPg, "shp_4c_ObsNegociados",    325,   8, 479,  67)
3251: 
3252:         *-- Legenda de cor da grade de cheques em aberto
3253:         loc_oPg.AddObject("shp_4c_LegendaDevolvido", "Shape")
3254:         WITH loc_oPg.shp_4c_LegendaDevolvido
3255:             .Top           = 65
3256:             .Left          = 295
3257:             .Width         = 14
3258:             .Height        = 14
3259:             .BackStyle     = 1
3260:             .SpecialEffect = 0
3261:             .BackColor     = RGB(255, 0, 0)
3262:             .Visible       = .T.
3263:         ENDWITH
3264: 
3265:         loc_oPg.AddObject("shp_4c_LegendaFollowup", "Shape")
3266:         WITH loc_oPg.shp_4c_LegendaFollowup
3267:             .Top           = 65
3268:             .Left          = 196
3269:             .Width         = 14
3270:             .Height        = 14
3271:             .BackStyle     = 1
3272:             .SpecialEffect = 0
3273:             .BackColor     = RGB(220, 255, 220)
3274:             .Visible       = .T.
3275:         ENDWITH
3276: 
3277:         *-- Rotulos
3278:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_GrupoCheque",  36,  16,  41, 15, "Grupo : ")
3279:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_ChequeAberto", 65,  11,  97, 15, ;

*-- Linhas 3538 a 3594:
3538:         THIS.AdicionarTotalAba(loc_oPg, "txt_4c_VlEstoque",       390, 841, 115, 23, .T.)
3539:         THIS.AdicionarTotalAba(loc_oPg, "txt_4c_LimiteDisp",      413, 841, 115, 23, .T.)
3540: 
3541:         BINDEVENT(loc_oPg.cbo_4c_GrupoCheque, "InteractiveChange", ;
3542:             THIS, "CboGrupoChequeInteractiveChange")
3543:         BINDEVENT(loc_oPg.grd_4c_ChequeAberto, "AfterRowColChange", ;
3544:             THIS, "GradeChequeAbertoAfterRowColChange")
3545:         BINDEVENT(loc_oPg.grd_4c_ChequeTitulo, "AfterRowColChange", ;
3546:             THIS, "GradeChequeTituloAfterRowColChange")
3547:     ENDPROC
3548: 
3549:     *==========================================================================
3550:     * ConfigurarAbaCartao - Aba 4 (Result.Cartao do legado): moldura, rotulo e
3551:     * a grade dos cartoes de credito em aberto (TmpCart, 6 colunas na ordem de
3552:     * ColumnOrder do dump).
3553:     *==========================================================================
3554:     PROTECTED PROCEDURE ConfigurarAbaCartao()
3555:         LOCAL loc_oPg, loc_oGrid
3556:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page4
3557: 
3558:         THIS.AdicionarMolduraAba(loc_oPg, "shp_4c_CartaoAberto", 56, 132, 735, 274)
3559: 
3560:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_CartaoAberto", 57, 139, 93, 15, ;
3561:             "Cart" + CHR(245) + "es em Aberto")
3562: 
3563:         loc_oPg.AddObject("grd_4c_Cartao", "Grid")
3564:         loc_oGrid = loc_oPg.grd_4c_Cartao
3565:         WITH loc_oGrid
3566:             .Top          = 72
3567:             .Left         = 137
3568:             .Width        = 725
3569:             .Height       = 254
3570:             .FontName     = "Courier New"
3571:             .DeleteMark   = .F.
3572:             .RecordMark   = .F.
3573:             .ReadOnly     = .T.
3574:             .Highlight    = .T.
3575:             .HighlightRow = .T.
3576:             .ScrollBars   = 2
3577:             .RecordSource = "TmpCart"
3578:             .ColumnCount  = 6
3579:             .Themes       = .F.
3580:             .Visible      = .T.
3581: 
3582:             .Columns(1).ControlSource   = "TmpCart.vencs"
3583:             .Columns(1).Header1.Caption = "Vencimento"
3584:             .Columns(1).Width           = 75
3585:             .Columns(1).Alignment       = 0
3586:             .Columns(1).ReadOnly        = .T.
3587: 
3588:             .Columns(2).ControlSource   = "TmpCart.fpags"
3589:             .Columns(2).Header1.Caption = "Cart" + CHR(227) + "o"
3590:             .Columns(2).Width           = 100
3591:             .Columns(2).Alignment       = 0
3592:             .Columns(2).ReadOnly        = .T.
3593: 
3594:             .Columns(3).ControlSource   = "TmpCart.nocreditos"

*-- Linhas 3626 a 3669:
3626:     * nao tem coluna de operacao - eh uma coluna reservada, que o legado
3627:     * tambem mostra vazia.
3628:     *==========================================================================
3629:     PROTECTED PROCEDURE ConfigurarAbaEstoque()
3630:         LOCAL loc_oPg, loc_oGrid
3631:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page6
3632: 
3633:         THIS.AdicionarMolduraAba(loc_oPg, "shp_4c_EstoqueProduto", 86, 303, 392, 361)
3634: 
3635:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_GrupoEstoque", 60, 307, 41, 15, "Grupo : ")
3636: 
3637:         loc_oPg.AddObject("cbo_4c_GrupoEstoque", "ComboBox")
3638:         WITH loc_oPg.cbo_4c_GrupoEstoque
3639:             .Top           = 56
3640:             .Left          = 350
3641:             .Width         = 300
3642:             .Height        = 24
3643:             .Style         = 2
3644:             .RowSourceType = 0
3645:             .FontName      = "Tahoma"
3646:             .FontSize      = 8
3647:             .ForeColor     = RGB(0, 0, 0)
3648:             .BackColor     = RGB(255, 255, 255)
3649:             .Visible       = .T.
3650:         ENDWITH
3651: 
3652:         loc_oPg.AddObject("grd_4c_Estoque", "Grid")
3653:         loc_oGrid = loc_oPg.grd_4c_Estoque
3654:         WITH loc_oGrid
3655:             .Top          = 92
3656:             .Left         = 308
3657:             .Width        = 381
3658:             .Height       = 347
3659:             .FontName     = "Courier New"
3660:             .DeleteMark   = .F.
3661:             .RecordMark   = .F.
3662:             .ReadOnly     = .T.
3663:             .Highlight    = .T.
3664:             .HighlightRow = .T.
3665:             .ScrollBars   = 2
3666:             .RecordSource = "dbEstoque"
3667:             .ColumnCount  = 3
3668:             .Themes       = .F.
3669:             .Visible      = .T.

*-- Linhas 3687 a 3745:
3687:             .Columns(3).ReadOnly        = .T.
3688:         ENDWITH
3689: 
3690:         BINDEVENT(loc_oPg.cbo_4c_GrupoEstoque, "InteractiveChange", ;
3691:             THIS, "CboGrupoEstoqueInteractiveChange")
3692:     ENDPROC
3693: 
3694:     *==========================================================================
3695:     * ConfigurarAbaHCheques - Aba 9 (Result.hcheques do legado - "H.Cheques"):
3696:     * tres grades (GradeCheque/GradeMovimenta/GradeProrrog) e o follow-up da
3697:     * linha corrente, transcritas de mativahcheque()/GradeCheque.
3698:     * AfterRowColChange.
3699:     *
3700:     * Cnt_Descricao e Cnt_periodo existem no dump (ambos Visible = .F.) mas o
3701:     * legado nunca os preenche nem os usa no filtro (regra documentada em
3702:     * CarregarHCheques do BO) - ficam aqui so por fidelidade estrutural,
3703:     * ocultos, sem BINDEVENT.
3704:     *==========================================================================
3705:     PROTECTED PROCEDURE ConfigurarAbaHCheques()
3706:         LOCAL loc_oPg, loc_oGrid
3707:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page9
3708: 
3709:         *-- GradeCheque (dbCheqHist) - historico de cheques da conta
3710:         loc_oPg.AddObject("grd_4c_HistCheque", "Grid")
3711:         loc_oGrid = loc_oPg.grd_4c_HistCheque
3712:         WITH loc_oGrid
3713:             .Top          = 57
3714:             .Left         = 152
3715:             .Width        = 696
3716:             .Height       = 124
3717:             .FontName     = "Courier New"
3718:             .DeleteMark   = .F.
3719:             .RecordMark   = .F.
3720:             .ReadOnly     = .T.
3721:             .Highlight    = .T.
3722:             .HighlightRow = .T.
3723:             .ScrollBars   = 2
3724:             .RecordSource = "dbCheqHist"
3725:             .ColumnCount  = 11
3726:             .Themes       = .F.
3727:             .Visible      = .T.
3728: 
3729:             .Columns(1).ControlSource   = "dbCheqHist.Vencs"
3730:             .Columns(1).Header1.Caption = "Vencimento"
3731:             .Columns(1).Width           = 75
3732:             .Columns(1).ReadOnly        = .T.
3733: 
3734:             .Columns(2).ControlSource   = "dbCheqHist.Bancos"
3735:             .Columns(2).Header1.Caption = "Banco"
3736:             .Columns(2).Width           = 50
3737:             .Columns(2).ReadOnly        = .T.
3738: 
3739:             .Columns(3).ControlSource   = "dbCheqHist.Agencias"
3740:             .Columns(3).Header1.Caption = "Agencia"
3741:             .Columns(3).Width           = 55
3742:             .Columns(3).ReadOnly        = .T.
3743: 
3744:             .Columns(4).ControlSource   = "dbCheqHist.NContas"
3745:             .Columns(4).Header1.Caption = "Conta"

*-- Linhas 3910 a 3953:
3910: 
3911:         *-- Cnt_Descricao / Cnt_periodo - presentes no SCX, ocultos e nunca
3912:         *-- escritos pelo legado (ver comentario de CarregarHCheques no BO);
3913:         *-- ficam so por fidelidade estrutural, sem BINDEVENT.
3914:         loc_oPg.AddObject("cnt_4c_DescricaoCheque", "Container")
3915:         WITH loc_oPg.cnt_4c_DescricaoCheque
3916:             .Top       = 319
3917:             .Left      = 151
3918:             .Width     = 457
3919:             .Height    = 46
3920:             .BackStyle = 0
3921:             .Visible   = .F.
3922:         ENDWITH
3923:         THIS.AdicionarRotuloAba(loc_oPg.cnt_4c_DescricaoCheque, "lbl_4c_Origem", 4, 9, 46, 15, "Origem :")
3924:         THIS.AdicionarRotuloAba(loc_oPg.cnt_4c_DescricaoCheque, "lbl_4c_Destino", 24, 7, 48, 15, "Destino :")
3925:         loc_oPg.cnt_4c_DescricaoCheque.AddObject("txt_4c_DescOrigem", "TextBox")
3926:         WITH loc_oPg.cnt_4c_DescricaoCheque.txt_4c_DescOrigem
3927:             .Top     = 3
3928:             .Left    = 57
3929:             .Width   = 386
3930:             .Height  = 20
3931:             .Value   = ""
3932:             .Visible = .T.
3933:         ENDWITH
3934:         loc_oPg.cnt_4c_DescricaoCheque.AddObject("txt_4c_DescDestino", "TextBox")
3935:         WITH loc_oPg.cnt_4c_DescricaoCheque.txt_4c_DescDestino
3936:             .Top     = 22
3937:             .Left    = 57
3938:             .Width   = 386
3939:             .Height  = 20
3940:             .Value   = ""
3941:             .Visible = .T.
3942:         ENDWITH
3943: 
3944:         loc_oPg.AddObject("cnt_4c_PeriodoCheque", "Container")
3945:         WITH loc_oPg.cnt_4c_PeriodoCheque
3946:             .Top       = 368
3947:             .Left      = 151
3948:             .Width     = 280
3949:             .Height    = 36
3950:             .BackStyle = 0
3951:             .Visible   = .F.
3952:         ENDWITH
3953:         THIS.AdicionarRotuloAba(loc_oPg.cnt_4c_PeriodoCheque, "lbl_4c_PeriodoCheque", 10, 26, 67, 15, "Vencimento : ")

*-- Linhas 3971 a 4023:
3971:             .Visible = .T.
3972:         ENDWITH
3973: 
3974:         BINDEVENT(loc_oPg.grd_4c_HistCheque, "AfterRowColChange", ;
3975:             THIS, "GradeHistChequeAfterRowColChange")
3976:     ENDPROC
3977: 
3978:     *==========================================================================
3979:     * ConfigurarAbaCredito - Aba 10 (Result.Credito do legado): PageFrame
3980:     * PgCredito com a pagina Consultas (Cnt_banco/Cnt_Valor/Grade/Cnt_Docs) e
3981:     * o rotulo de situacao (Label2), transcritos de mativacredito().
3982:     *==========================================================================
3983:     PROTECTED PROCEDURE ConfigurarAbaCredito()
3984:         LOCAL loc_oPg, loc_oCns, loc_oGrid
3985:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page10
3986: 
3987:         THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_SituacaoCredito", 53, 3, 996, 47, "CLIENTE")
3988:         loc_oPg.lbl_4c_SituacaoCredito.FontName = "Tahoma"
3989:         loc_oPg.lbl_4c_SituacaoCredito.FontSize = 10
3990:         loc_oPg.lbl_4c_SituacaoCredito.FontBold = .T.
3991:         loc_oPg.lbl_4c_SituacaoCredito.ForeColor = RGB(0, 0, 255)
3992: 
3993:         loc_oPg.AddObject("pgf_4c_Credito", "PageFrame")
3994:         WITH loc_oPg.pgf_4c_Credito
3995:             .Top       = 96
3996:             .Left      = 0
3997:             .Width     = 1003
3998:             .Height    = 408
3999:             .PageCount = 1
4000:             .Tabs      = .F.
4001:             .Themes    = .F.
4002:             .Visible   = .T.
4003:             .Page1.Caption = "Consultas"
4004:         ENDWITH
4005:         loc_oCns = loc_oPg.pgf_4c_Credito.Page1
4006: 
4007:         *-- Cnt_banco
4008:         loc_oCns.AddObject("cnt_4c_CreditoBanco", "Container")
4009:         WITH loc_oCns.cnt_4c_CreditoBanco
4010:             .Top       = 273
4011:             .Left      = 170
4012:             .Width     = 479
4013:             .Height    = 40
4014:             .BackStyle = 0
4015:             .Visible   = .T.
4016:         ENDWITH
4017:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoBanco, "lbl_4c_Bco",   1, 6,   30, 15, "Bco")
4018:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoBanco, "lbl_4c_Age",   1, 43,  40, 15, "Ag" + CHR(234) + "ncia")
4019:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoBanco, "lbl_4c_Cta",   1, 95,  40, 15, "Conta")
4020:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoBanco, "lbl_4c_NumI",  1, 173, 65, 15, "Num.Inicial")
4021:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoBanco, "lbl_4c_NumF",  1, 265, 60, 15, "Num.Final")
4022:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoBanco, "lbl_4c_Serie", 1, 357, 40, 15, "S" + CHR(233) + "rie")
4023:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoBanco, "lbl_4c_DtAb",  1, 408, 70, 15, "Dt Abertura")

*-- Linhas 4214 a 4782:
4214:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoDocs, "lbl_4c_TipoDocto", 1, 11, 53, 15, "Tipo Docto")
4215:         THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoDocs, "lbl_4c_DataDocto", 1, 97, 25, 15, "Data")
4216:         WITH loc_oCns.cnt_4c_CreditoDocs
4217:             .AddObject("obj_4c_OptDocs", "OptionGroup")
4218:             WITH .obj_4c_OptDocs
4219:                 .Top           = 15
4220:                 .Left          = 5
4221:                 .Width         = 89
4222:                 .Height        = 25
4223:                 .ButtonCount   = 2
4224:                 .BackStyle     = 0
4225:                 .BorderStyle   = 0
4226:                 .ControlSource = "dbCredito.NChkDocs"
4227:                 WITH .Buttons(1)
4228:                     .Caption   = "RG"
4229:                     .Top       = 5
4230:                     .Left      = 5
4231:                     .BackStyle = 0
4232:                     .FontSize  = 8
4233:                 ENDWITH
4234:                 WITH .Buttons(2)
4235:                     .Caption   = "CNH"
4236:                     .Top       = 5
4237:                     .Left      = 45
4238:                     .Height    = 15
4239:                     .BackStyle = 0
4240:                     .FontSize  = 8
4241:                 ENDWITH
4242:                 .Visible = .T.
4243:             ENDWITH
4244: 
4245:             .AddObject("txt_4c_DataDoc", "TextBox")
4246:             WITH .txt_4c_DataDoc
4247:                 .Top           = 14
4248:                 .Left          = 95
4249:                 .Width         = 85
4250:                 .Height        = 23
4251:                 .Value         = {}
4252:                 .ControlSource = "dbCredito.TdDocs"
4253:                 .Visible       = .T.
4254:             ENDWITH
4255:         ENDWITH
4256:     ENDPROC
4257: 
4258:     *==========================================================================
4259:     * AdicionarMolduraAba - Shape de moldura (os "Shape" das abas do legado:
4260:     * BackStyle = 0, so a borda cinza). Fabrica usada pelas abas acima para nao
4261:     * repetir o mesmo bloco de nove propriedades em cada moldura.
4262:     *==========================================================================
4263:     PROTECTED PROCEDURE AdicionarMolduraAba(par_oPagina, par_cNome, ;
4264:             par_nTop, par_nLeft, par_nWidth, par_nHeight)
4265: 
4266:         par_oPagina.AddObject(par_cNome, "Shape")
4267: 
4268:         *-- Membro alcancado por NOME: EVALUATE na leitura (regra #15/#34)
4269:         WITH EVALUATE("par_oPagina." + par_cNome)
4270:             .Top         = par_nTop
4271:             .Left        = par_nLeft
4272:             .Width       = par_nWidth
4273:             .Height      = par_nHeight
4274:             .BackStyle   = 0
4275:             .BorderColor = RGB(90, 90, 90)
4276:             .Visible     = .T.
4277:         ENDWITH
4278:     ENDPROC
4279: 
4280:     *==========================================================================
4281:     * AdicionarRotuloAba - Label de dados das abas. ForeColor RGB(90,90,90) (a
4282:     * classe "say" do legado nao declara cor; branco ficaria invisivel sobre a
4283:     * textura clara da Page - regra #12) e AutoSize = .F. com a Width/Height do
4284:     * dump (regra #23: AutoSize eh no-op em Label criado por AddObject).
4285:     *==========================================================================
4286:     PROTECTED PROCEDURE AdicionarRotuloAba(par_oPagina, par_cNome, ;
4287:             par_nTop, par_nLeft, par_nWidth, par_nHeight, par_cCaption)
4288: 
4289:         par_oPagina.AddObject(par_cNome, "Label")
4290: 
4291:         WITH EVALUATE("par_oPagina." + par_cNome)
4292:             .Top       = par_nTop
4293:             .Left      = par_nLeft
4294:             .Width     = par_nWidth
4295:             .Height    = par_nHeight
4296:             .AutoSize  = .F.
4297:             .Alignment = 0
4298:             .FontName  = "Tahoma"
4299:             .FontSize  = 8
4300:             .BackStyle = 0
4301:             .ForeColor = RGB(90, 90, 90)
4302:             .Caption   = par_cCaption
4303:             .Visible   = .T.
4304:         ENDWITH
4305:     ENDPROC
4306: 
4307:     *==========================================================================
4308:     * AdicionarTotalAba - TextBox somente-leitura de total/observacao das abas
4309:     * (os fwget com "When -> RETURN .F." do legado). par_lNumerico diz se o
4310:     * campo mostra valor (InputMask "999,999,999.99", como no dump) ou texto.
4311:     *==========================================================================
4312:     PROTECTED PROCEDURE AdicionarTotalAba(par_oPagina, par_cNome, ;
4313:             par_nTop, par_nLeft, par_nWidth, par_nHeight, par_lNumerico)
4314: 
4315:         par_oPagina.AddObject(par_cNome, "TextBox")
4316: 
4317:         WITH EVALUATE("par_oPagina." + par_cNome)
4318:             .Top           = par_nTop
4319:             .Left          = par_nLeft
4320:             .Width         = par_nWidth
4321:             .Height        = par_nHeight
4322:             .FontName      = "Tahoma"
4323:             .FontSize      = 8
4324:             .ReadOnly      = .T.
4325:             .ForeColor     = RGB(0, 0, 0)
4326:             .BorderColor   = RGB(100, 100, 100)
4327:             .SpecialEffect = 1
4328:             .Visible       = .T.
4329: 
4330:             IF par_lNumerico
4331:                 .Value     = 0
4332:                 .InputMask = "999,999,999.99"
4333:             ELSE
4334:                 .Value     = ""
4335:             ENDIF
4336:         ENDWITH
4337:     ENDPROC
4338: 
4339:     *==========================================================================
4340:     * PreencherComboGrupo - Popula o ComboBox "Grupo :" de uma aba com os
4341:     * grupos presentes no cursor de resultado, no formato do legado
4342:     * ("<codigo com 10> - <descricao>"), e deixa o primeiro selecionado.
4343:     *
4344:     * Equivale ao efeito acumulado das chamadas a Carrega_Combo() que o legado
4345:     * faz dentro do SCAN de carga. PUBLIC: chamado pelos funis de carga e pelo
4346:     * harness de teste.
4347:     *==========================================================================
4348:     PROCEDURE PreencherComboGrupo(par_oCombo, par_cCursorOrigem)
4349:         LOCAL loc_nGrupos, loc_oErro
4350: 
4351:         TRY
4352:             IF VARTYPE(par_oCombo) = "O"
4353:                 par_oCombo.Clear()
4354: 
4355:                 loc_nGrupos = THIS.this_oBusinessObject.CarregarGruposCursor( ;
4356:                     par_cCursorOrigem, "cursor_4c_GruposAba")
4357: 
4358:                 IF loc_nGrupos > 0 AND USED("cursor_4c_GruposAba")
4359:                     SELECT cursor_4c_GruposAba
4360:                     SCAN
4361:                         par_oCombo.AddItem( ;
4362:                             PADR(ALLTRIM(TratarNulo(cursor_4c_GruposAba.Codigos, "")), 10) + ;
4363:                             " - " + ALLTRIM(TratarNulo(cursor_4c_GruposAba.Descrs, "")))
4364:                     ENDSCAN
4365: 
4366:                     IF par_oCombo.ListCount > 0
4367:                         par_oCombo.ListIndex = 1
4368:                     ENDIF
4369:                 ENDIF
4370: 
4371:                 IF USED("cursor_4c_GruposAba")
4372:                     USE IN cursor_4c_GruposAba
4373:                 ENDIF
4374:             ENDIF
4375:         CATCH TO loc_oErro
4376:             MsgErro(loc_oErro.Message + CHR(13) + ;
4377:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
4378:                 "Erro ao montar o filtro de grupo")
4379:         ENDTRY
4380:     ENDPROC
4381: 
4382:     *==========================================================================
4383:     * FiltrarPorGrupo - Aplica em <cursor> o filtro de grupo escolhido no
4384:     * combo, exatamente como o "Set Key To Left(.Value,10)" do legado. O tag de
4385:     * UMA coluna (Grupos) eh usado de proposito: chave parcial sobre indice
4386:     * composto nao casa com SET EXACT ON.
4387:     *
4388:     * Combo vazio (nenhum grupo carregado) limpa o filtro, para a grade nao
4389:     * ficar vazia sem motivo.
4390:     *==========================================================================
4391:     PROTECTED PROCEDURE FiltrarPorGrupo(par_cCursor, par_cValorCombo)
4392:         LOCAL loc_cGrupo
4393: 
4394:         IF !USED(par_cCursor)
4395:             RETURN
4396:         ENDIF
4397: 
4398:         loc_cGrupo = LEFT(IIF(VARTYPE(par_cValorCombo) = "C", par_cValorCombo, ""), 10)
4399: 
4400:         SELECT (par_cCursor)
4401:         SET ORDER TO TAG Grupos
4402:         IF EMPTY(loc_cGrupo)
4403:             SET KEY TO
4404:         ELSE
4405:             SET KEY TO loc_cGrupo
4406:         ENDIF
4407:         GO TOP
4408:     ENDPROC
4409: 
4410:     *==========================================================================
4411:     * AtualizarAbaResultadoAtiva - Despachante UNICO de repintura da pagina
4412:     * Resultado: chama o funil da aba que esta a vista.
4413:     *
4414:     * Existe para que os DOIS caminhos que deixam a aba visivel - a troca de
4415:     * pagina (AlternarPagina(2)) e a troca de aba (OptResultadoInteractiveChange)
4416:     * - repintem exatamente a mesma coisa. Refresh em pagina oculta nao pinta
4417:     * (regra #46), por isso o despachante eh sempre chamado DEPOIS de o
4418:     * ActivePage ja estar trocado.
4419:     *
4420:     * As abas 5, 7, 8, 9 e 10 (Vendas, Operacoes Pend., Producao, Historico
4421:     * de Cheques e Credito) ganham o seu CASE junto com o conteudo delas, na
4422:     * fase seguinte.
4423:     * PUBLIC: chamado de fora (botoes e harness de teste).
4424:     *==========================================================================
4425:     PROCEDURE AtualizarAbaResultadoAtiva()
4426:         LOCAL loc_nAba, loc_oErro
4427: 
4428:         TRY
4429:             loc_nAba = 0
4430:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "pgf_4c_Resultado", 5)
4431:                 loc_nAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.ActivePage
4432:             ENDIF
4433: 
4434:             DO CASE
4435:                 CASE loc_nAba = 1
4436:                     THIS.AtualizarGradesSaldo()
4437:                 CASE loc_nAba = 2
4438:                     THIS.AtualizarGradePendencias()
4439:                 CASE loc_nAba = 3
4440:                     THIS.AtualizarGradesCheques()
4441:                 CASE loc_nAba = 4
4442:                     THIS.AtualizarGradeCartao()
4443:                 CASE loc_nAba = 6
4444:                     THIS.AtualizarGradeEstoque()
4445:                 CASE loc_nAba = 9
4446:                     THIS.AtualizarGradeHCheques()
4447:                 CASE loc_nAba = 10
4448:                     THIS.AtualizarGradeCredito()
4449:             ENDCASE
4450:         CATCH TO loc_oErro
4451:             MsgErro(loc_oErro.Message + CHR(13) + ;
4452:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
4453:                 "Erro ao atualizar a aba de resultado")
4454:         ENDTRY
4455:     ENDPROC
4456: 
4457:     *==========================================================================
4458:     * AtualizarGradePendencias - Funil UNICO de repintura da aba Pendencias
4459:     * (regra #21a: popular cursor nao repinta a grade). Reaplica o filtro de
4460:     * grupo, recalcula o total e so entao da GO TOP + Refresh.
4461:     * PUBLIC: chamado de fora (botoes, combo e harness de teste).
4462:     *==========================================================================
4463:     PROCEDURE AtualizarGradePendencias()
4464:         LOCAL loc_oAba, loc_oErro
4465: 
4466:         TRY
4467:             IF THIS.AbaResultadoDisponivel(2)
4468:                 loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page2
4469: 
4470:                 THIS.FiltrarPorGrupo("TmpPar", loc_oAba.cbo_4c_GrupoPend.Value)
4471:                 THIS.FiltrarTipos()
4472: 
4473:                 IF USED("crTmpTipos")
4474:                     GO TOP IN crTmpTipos
4475:                 ENDIF
4476: 
4477:                 loc_oAba.grd_4c_TiposPend.Refresh()
4478:                 loc_oAba.grd_4c_Pendentes.Refresh()
4479:             ENDIF
4480:         CATCH TO loc_oErro
4481:             MsgErro(loc_oErro.Message + CHR(13) + ;
4482:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
4483:                 "Erro ao atualizar a grade de pend" + CHR(234) + "ncias")
4484:         ENDTRY
4485:     ENDPROC
4486: 
4487:     *==========================================================================
4488:     * FiltrarTipos - FiltraTipos() do legado: monta o filtro de TmpPar com as
4489:     * formas de pagamento MARCADAS em crTmpTipos e atualiza o total.
4490:     *
4491:     * Nenhuma forma marcada deixa a grade vazia de proposito ("Set Filter To
4492:     * 0=1" no legado) - eh o que diz ao usuario que o filtro excluiu tudo.
4493:     * O filtro de grupo (SET KEY) e o de tipos (SET FILTER) sao independentes e
4494:     * convivem, como no legado.
4495:     * PUBLIC: chamado pelos handlers do CheckBox e pelo harness de teste.
4496:     *==========================================================================
4497:     PROCEDURE FiltrarTipos()
4498:         LOCAL loc_cTipos, loc_oAba, loc_oErro
4499: 
4500:         TRY
4501:             IF USED("TmpPar") AND USED("crTmpTipos")
4502:                 loc_cTipos = ""
4503: 
4504:                 SELECT crTmpTipos
4505:                 GO TOP
4506:                 SCAN
4507:                     IF TratarNulo(crTmpTipos.Listas, 0) = 1
4508:                         loc_cTipos = loc_cTipos + ;
4509:                             IIF(EMPTY(loc_cTipos), "fPags = ", " OR fPags = ") + ;
4510:                             CHR(39) + ALLTRIM(TratarNulo(crTmpTipos.fPags, "")) + CHR(39)
4511:                     ENDIF
4512:                 ENDSCAN
4513:                 GO TOP IN crTmpTipos
4514: 
4515:                 SELECT TmpPar
4516:                 IF EMPTY(loc_cTipos)
4517:                     SET FILTER TO 0 = 1
4518:                 ELSE
4519:                     SET FILTER TO &loc_cTipos.
4520:                 ENDIF
4521:                 LOCATE
4522: 
4523:                 IF THIS.AbaResultadoDisponivel(2)
4524:                     loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page2
4525:                     loc_oAba.txt_4c_TotPend.Value = THIS.this_oBusinessObject.TotalPendencias()
4526:                     loc_oAba.txt_4c_TotPend.Refresh()
4527:                 ENDIF
4528:             ENDIF
4529:         CATCH TO loc_oErro
4530:             MsgErro(loc_oErro.Message + CHR(13) + ;
4531:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
4532:                 "Erro ao filtrar as formas de pagamento")
4533:         ENDTRY
4534:     ENDPROC
4535: 
4536:     *==========================================================================
4537:     * ChkTipoPendKeyPress - Alterna a marca da forma de pagamento por TECLADO
4538:     * (Enter/Espaco), como o KeyPress do Check1 do legado. O NODEFAULT suprime
4539:     * o toggle nativo para o valor nao ser alternado duas vezes.
4540:     * PUBLIC: alvo de BINDEVENT (regra #3).
4541:     *==========================================================================
4542:     PROCEDURE ChkTipoPendKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4543:         IF INLIST(par_nKeyCode, 13, 32) AND USED("crTmpTipos") AND !EOF("crTmpTipos")
4544:             REPLACE crTmpTipos.Listas ;
4545:                 WITH IIF(TratarNulo(crTmpTipos.Listas, 0) = 0, 1, 0) IN crTmpTipos
4546: 
4547:             IF THIS.AbaResultadoDisponivel(2)
4548:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page2.grd_4c_TiposPend.Refresh()
4549:             ENDIF
4550: 
4551:             THIS.FiltrarTipos()
4552:             THIS.AtualizarGradePendencias()
4553:             NODEFAULT
4554:         ENDIF
4555:     ENDPROC
4556: 
4557:     *==========================================================================
4558:     * ChkTipoPendMouseUp - Alterna a marca por CLIQUE, delegando ao mesmo
4559:     * handler do teclado (MouseUp do Check1 legado: This.KeyPress(13,0)).
4560:     *==========================================================================
4561:     PROCEDURE ChkTipoPendMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
4562:         THIS.ChkTipoPendKeyPress(13, 0)
4563:         NODEFAULT
4564:     ENDPROC
4565: 
4566:     *==========================================================================
4567:     * ChkTipoPendMouseDown - Suprime o toggle nativo do CheckBox (NoDefault do
4568:     * MouseDown legado): quem alterna o valor eh o MouseUp/KeyPress.
4569:     *==========================================================================
4570:     PROCEDURE ChkTipoPendMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
4571:         NODEFAULT
4572:     ENDPROC
4573: 
4574:     *==========================================================================
4575:     * ChkTipoPendClick - Suprime o Click nativo (NoDefault do Click legado),
4576:     * pela mesma razao do MouseDown.
4577:     *==========================================================================
4578:     PROCEDURE ChkTipoPendClick()
4579:         NODEFAULT
4580:     ENDPROC
4581: 
4582:     *==========================================================================
4583:     * CboGrupoPendInteractiveChange - Cmb_Grupo.InteractiveChange da aba
4584:     * Pendencias: aplica o filtro de grupo, recalcula o total e repinta.
4585:     *==========================================================================
4586:     PROCEDURE CboGrupoPendInteractiveChange()
4587:         THIS.AtualizarGradePendencias()
4588:     ENDPROC
4589: 
4590:     *==========================================================================
4591:     * BtnAnexaPendClick - Anexa.Click da aba Pendencias: abre o documento da
4592:     * pendencia selecionada (FormSigMvExp, o SigMvExp do legado).
4593:     *
4594:     * A condicao que o legado usava para HABILITAR o botao (linha valida, com
4595:     * Dopes e Numes) vive aqui dentro: botao icone-only desabilitado em runtime
4596:     * perde o icone, por isso ele fica sempre ativo e avisa quando a linha
4597:     * corrente nao tem documento.
4598:     *==========================================================================
4599:     PROCEDURE BtnAnexaPendClick()
4600:         LOCAL loc_oForm, loc_oErro
4601: 
4602:         IF !USED("TmpPar") OR EOF("TmpPar") OR ;
4603:            EMPTY(TratarNulo(TmpPar.dopes, "")) OR TratarNulo(TmpPar.numes, 0) = 0
4604:             MsgAviso("Selecione uma pend" + CHR(234) + "ncia com documento para " + ;
4605:                 "consultar.", "Documento")
4606:             RETURN
4607:         ENDIF
4608: 
4609:         loc_oForm = .NULL.
4610:         TRY
4611:             loc_oForm = CREATEOBJECT("FormSigMvExp", ;
4612:                 ALLTRIM(TmpPar.dopes), "C", TmpPar.numes, ALLTRIM(TmpPar.emps), .T.)
4613:         CATCH TO loc_oErro
4614:             MostrarErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel abrir o " + ;
4615:                 "documento:" + CHR(13) + loc_oErro.Message, "Documento")
4616:             loc_oForm = .NULL.
4617:         ENDTRY
4618: 
4619:         *-- Show() de form modal FORA do TRY (regra #29)
4620:         IF VARTYPE(loc_oForm) = "O"
4621:             loc_oForm.Show()
4622:         ENDIF
4623:     ENDPROC
4624: 
4625:     *==========================================================================
4626:     * BtnAnexaSaldoClick - Anexa.Click da aba Saldo (Result.Saldo.Anexa do
4627:     * legado): abre o documento do lancamento corrente do historico de conta
4628:     * corrente, mesmo padrao do BtnAnexaPendClick, lendo de dbHistorico.
4629:     *==========================================================================
4630:     PROCEDURE BtnAnexaSaldoClick()
4631:         LOCAL loc_oForm, loc_oErro
4632: 
4633:         IF !USED("dbHistorico") OR EOF("dbHistorico") OR ;
4634:            EMPTY(TratarNulo(dbHistorico.dopes, "")) OR TratarNulo(dbHistorico.numes, 0) = 0
4635:             MsgAviso("Selecione um lan" + CHR(231) + "amento com documento para " + ;
4636:                 "consultar.", "Documento")
4637:             RETURN
4638:         ENDIF
4639: 
4640:         loc_oForm = .NULL.
4641:         TRY
4642:             loc_oForm = CREATEOBJECT("FormSigMvExp", ;
4643:                 ALLTRIM(dbHistorico.dopes), "C", dbHistorico.numes, ALLTRIM(dbHistorico.emps), .T.)
4644:         CATCH TO loc_oErro
4645:             MostrarErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel abrir o " + ;
4646:                 "documento:" + CHR(13) + loc_oErro.Message, "Documento")
4647:             loc_oForm = .NULL.
4648:         ENDTRY
4649: 
4650:         *-- Show() de form modal FORA do TRY (regra #29)
4651:         IF VARTYPE(loc_oForm) = "O"
4652:             loc_oForm.Show()
4653:         ENDIF
4654:     ENDPROC
4655: 
4656:     *==========================================================================
4657:     * BtnImpPendClick - CmdImpPend.Click da aba Pendencias: listagem das
4658:     * pendencias visiveis (Report Form SigReIpd do legado).
4659:     *
4660:     * O cursor crImpPend tem a MESMA estrutura que o legado monta antes do
4661:     * REPORT FORM, e o relatorio roda pelo helper canonico de impressao
4662:     * (isolamento de locale + guard de FRX ausente + restauracao do menu).
4663:     *==========================================================================
4664:     PROCEDURE BtnImpPendClick()
4665:         LOCAL loc_cConta, loc_cNome, loc_cGrupo, loc_nTotal, loc_oAba
4666:         LOCAL loc_lTemLinha, loc_oErro
4667: 
4668:         TRY
4669:             IF !USED("TmpPar")
4670:                 MsgAviso("Nenhuma pend" + CHR(234) + "ncia a listar.", "Listagem")
4671:             ELSE
4672:                 loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page2
4673:                 loc_cGrupo = "G" + LEFT(loc_oAba.cbo_4c_GrupoPend.Value, 10)
4674:                 loc_cConta = ALLTRIM(THIS.this_oBusinessObject.this_cConta)
4675:                 loc_cNome  = ALLTRIM(THIS.this_oBusinessObject.this_cDescConta)
4676:                 loc_nTotal = THIS.this_oBusinessObject.TotalPendencias()
4677: 
4678:                 IF USED("crImpPend")
4679:                     USE IN crImpPend
4680:                 ENDIF
4681:                 CREATE CURSOR crImpPend (Tipo N(1), EmpDopNums C(29), Conta C(10), ;
4682:                     rClis C(40), Emps C(3), Dopes C(20), Numes N(6), Grupo C(10), ;
4683:                     Datas D, cPros C(14), dPros C(40), Qtds N(9,3), cUnis C(3), ;
4684:                     Units N(11,2), Totas N(11,2), TotGeral N(13,2), Grupos C(40))
4685: 
4686:                 loc_lTemLinha = .F.
4687:                 SELECT TmpPar
4688:                 GO TOP
4689:                 SCAN
4690:                     INSERT INTO crImpPend ;
4691:                         (Tipo, Conta, rClis, Emps, Dopes, Numes, Grupo, Datas, ;
4692:                          dPros, Totas, TotGeral, Grupos) ;
4693:                         VALUES ;
4694:                         (0, loc_cConta, LEFT(loc_cNome, 40), ;
4695:                          TratarNulo(TmpPar.emps, ""), ;
4696:                          TratarNulo(TmpPar.dopes, ""), ;
4697:                          TratarNulo(TmpPar.numes, 0), ;
4698:                          TratarNulo(TmpPar.grupos, ""), ;
4699:                          ConverterParaData(TmpPar.vencs), ;
4700:                          LEFT(TratarNulo(TmpPar.hists, ""), 40), ;
4701:                          TratarNulo(TmpPar.valos, 0), ;
4702:                          loc_nTotal, ;
4703:                          LEFT(loc_cGrupo, 40))
4704:                     loc_lTemLinha = .T.
4705:                 ENDSCAN
4706:                 GO TOP IN TmpPar
4707: 
4708:                 IF !loc_lTemLinha
4709:                     MsgAviso("Nenhuma pend" + CHR(234) + "ncia a listar.", "Listagem")
4710:                 ELSE
4711:                     SELECT crImpPend
4712:                     GO TOP
4713:                     THIS.ImprimirListagem("SigReIpd", "crImpPend")
4714:                 ENDIF
4715:             ENDIF
4716:         CATCH TO loc_oErro
4717:             MsgErro(loc_oErro.Message + CHR(13) + ;
4718:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
4719:                 "Erro ao listar as pend" + CHR(234) + "ncias")
4720:         ENDTRY
4721:     ENDPROC
4722: 
4723:     *==========================================================================
4724:     * ImprimirListagem - Helper canonico de REPORT FORM: resolve o caminho do
4725:     * FRX em gc_4c_CaminhoReports, avisa quando o arquivo nao existe (em vez de
4726:     * estourar sem dizer qual), isola o locale (SET POINT/SEPARATOR/
4727:     * REPORTBEHAVIOR, que os FRX Fortyus exigem para nao imprimir "*****" nos
4728:     * numericos) e restaura o menu, que o preview do VFP9 corrompe.
4729:     *==========================================================================
4730:     PROTECTED PROCEDURE ImprimirListagem(par_cRelatorioBase, par_cCursorDados)
4731:         LOCAL loc_cFrx, loc_cPonto, loc_cSeparador, loc_nBehavior, loc_oErro
4732: 
4733:         loc_cFrx = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")
4734: 
4735:         IF !FILE(loc_cFrx)
4736:             MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
4737:                 "o encontrado:" + CHR(13) + loc_cFrx, "Listagem")
4738:             RETURN
4739:         ENDIF
4740: 
4741:         IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
4742:             MsgAviso("Nenhum registro encontrado com os filtros informados.", "Listagem")
4743:             RETURN
4744:         ENDIF
4745: 
4746:         loc_cPonto     = SET("Point")
4747:         loc_cSeparador = SET("Separator")
4748:         loc_nBehavior  = SET("REPORTBEHAVIOR")
4749: 
4750:         TRY
4751:             SET POINT TO "."
4752:             SET SEPARATOR TO ","
4753:             SET REPORTBEHAVIOR 80
4754: 
4755:             SELECT (par_cCursorDados)
4756:             GO TOP
4757: 
4758:             REPORT FORM (loc_cFrx) TO PRINTER PROMPT PREVIEW
4759:         CATCH TO loc_oErro
4760:             MostrarErro("Erro ao gerar a listagem:" + CHR(13) + loc_oErro.Message, ;
4761:                 "Listagem")
4762:         FINALLY
4763:             SET POINT TO loc_cPonto
4764:             SET SEPARATOR TO loc_cSeparador
4765:             SET REPORTBEHAVIOR loc_nBehavior
4766:         ENDTRY
4767: 
4768:         *-- O preview do VFP9 corrompe _MSYSMENU: devolver o menu do sistema
4769:         TRY
4770:             SET SYSMENU TO DEFAULT
4771:             RELEASE POPUP popArquivo, popCadastros, popMovimentos, ;
4772:                 popRelatorios, popFerramentas, popAjuda
4773:             CriarMenuPrincipal()
4774:         CATCH TO loc_oErro
4775:             *-- Menu ausente (form aberto fora do menu principal ou em teste)
4776:             *-- nao eh erro de negocio
4777:         ENDTRY
4778:     ENDPROC
4779: 
4780:     *==========================================================================
4781:     * ImpressaoCad - ImpressaoCad() do legado: monta _varRB/_varH (os dois
4782:     * memos que o SigReGcd.frx exibe nos blocos de Referencias Bancarias e

*-- Linhas 4793 a 4845:
4793:     * Sem essa infraestrutura de hardware o caminho correto eh avisar, nao
4794:     * fingir sucesso silencioso.
4795:     *==========================================================================
4796:     PROTECTED PROCEDURE ImpressaoCad(par_cSaida, par_lGenerico, par_lPessoais, ;
4797:             par_lBancarias, par_lFollowup, par_lTermica)
4798:         LOCAL loc_cConta, loc_cSQL, loc_oErro
4799:         LOCAL _varRB, _varH
4800: 
4801:         *-- Guard de parametro FORA do TRY: com o RETURN dentro do bloco ele
4802:         *-- violaria a regra #1 (nunca RETURN dentro de TRY/CATCH), e aqui nao
4803:         *-- ha o que proteger - a condicao le apenas os parametros recebidos
4804:         IF par_lTermica AND par_cSaida != "V"
4805:             MsgAviso("Impress" + CHR(227) + "o em impressora t" + CHR(233) + ;
4806:                 "rmica de 40 colunas n" + CHR(227) + "o est" + CHR(225) + ;
4807:                 " dispon" + CHR(237) + "vel neste sistema." + CHR(13) + ;
4808:                 "Use a op" + CHR(231) + CHR(227) + "o V" + CHR(237) + "deo ou " + ;
4809:                 "desmarque " + CHR(34) + "Impressora 40 colunas" + CHR(34) + ".", ;
4810:                 "Impress" + CHR(227) + "o")
4811:             RETURN
4812:         ENDIF
4813: 
4814:         TRY
4815:             loc_cConta = ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.txt_4c_Conta.Value)
4816: 
4817:             _varRB = ""
4818:             _varH  = ""
4819: 
4820:             IF par_lBancarias
4821:                 IF USED("crSigCdCeb")
4822:                     USE IN crSigCdCeb
4823:                 ENDIF
4824:                 loc_cSQL = "SELECT nbancos, bancos, nagencias, agencias, btels, ramals" + ;
4825:                     " FROM SigCdCeb WHERE iclis = " + EscaparSQL(loc_cConta)
4826:                 SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdCeb")
4827: 
4828:                 IF USED("crSigCdCeb")
4829:                     SELECT crSigCdCeb
4830:                     IF EOF()
4831:                         _varRB = "N" + CHR(227) + "o Constam Refer" + CHR(234) + ;
4832:                             "ncias Bancarias Referentes ao Cliente!"
4833:                     ELSE
4834:                         SCAN
4835:                             _varRB = _varRB + TratarNulo(nbancos, "") + " " + ;
4836:                                 LEFT(TratarNulo(bancos, ""), 22) + " " + ;
4837:                                 TratarNulo(nagencias, "") + " " + ;
4838:                                 LEFT(TratarNulo(agencias, ""), 22) + " " + ;
4839:                                 TratarNulo(btels, "") + " " + TratarNulo(ramals, "")
4840:                         ENDSCAN
4841:                     ENDIF
4842:                     USE IN crSigCdCeb
4843:                 ENDIF
4844:             ENDIF
4845: 

*-- Linhas 4906 a 4958:
4906:     * impressoras do legado (gaprinters/SigOpIbo), o caminho termico vira
4907:     * aviso em vez de ficar calado.
4908:     *==========================================================================
4909:     PROTECTED PROCEDURE Impressao(par_cSaida, par_lSaldo, par_lLimite, ;
4910:             par_lChequePend, par_lChequeDev, par_lChequeDep, par_lCartao, ;
4911:             par_lPend, par_lOper, par_lTermica, par_lChqNeg, par_lResVenda, ;
4912:             par_lProdutos, par_lProducao, par_lEstoque)
4913:         LOCAL loc_cConta, loc_cSQL, loc_nValTipo, loc_cCabTipo, loc_oErro
4914:         LOCAL loc_dDtIni, loc_dDtFim
4915: 
4916:         *-- Guard de parametro FORA do TRY (regra #1, igual ao ImpressaoCad)
4917:         IF par_lTermica AND par_cSaida != "V"
4918:             MsgAviso("Impress" + CHR(227) + "o em impressora t" + CHR(233) + ;
4919:                 "rmica de 40 colunas n" + CHR(227) + "o est" + CHR(225) + ;
4920:                 " dispon" + CHR(237) + "vel neste sistema." + CHR(13) + ;
4921:                 "Use a op" + CHR(231) + CHR(227) + "o V" + CHR(237) + "deo ou " + ;
4922:                 "desmarque " + CHR(34) + "Impressora 40 colunas" + CHR(34) + ".", ;
4923:                 "Impress" + CHR(227) + "o")
4924:             RETURN
4925:         ENDIF
4926: 
4927:         TRY
4928:             loc_cConta = ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.txt_4c_Conta.Value)
4929: 
4930:             IF USED("TmpRelGv")
4931:                 USE IN TmpRelGv
4932:             ENDIF
4933:             CREATE CURSOR TmpRelGv (ValTipo N(3), CabTipo C(70), Grupo C(10), ;
4934:                 Valor N(12,2), Moeda C(3), Data D, Descricao C(50), Observa C(76), ;
4935:                 Opers C(1), ValoPg N(12,2), Saldo N(12,2), Cpros C(14), DPros C(40), ;
4936:                 Numes N(6), Dopes C(20), PrazoEnts D, Fase C(10), Qtds N(9,2), ;
4937:                 Nenvs N(10), Nops N(10), xPer N(6,2), Emps C(3), Pesos N(9,2), ;
4938:                 Cbars N(14), Reffs C(40), Colecoes C(10), Anos C(4), Meses C(2))
4939:             INDEX ON STR(ValTipo, 3) + Anos + Meses + Grupo TAG ValGrupo
4940: 
4941:             IF USED("TmpTotal")
4942:                 USE IN TmpTotal
4943:             ENDIF
4944:             CREATE CURSOR TmpTotal (Moeda C(3), Valor N(12,2))
4945:             INDEX ON Moeda TAG Moeda
4946: 
4947:             *-- (1) Saldo de Conta Corrente
4948:             IF par_lSaldo
4949:                 loc_nValTipo = 1
4950:                 loc_cCabTipo = "Saldos de Conta Corrente"
4951:                 IF USED("dbSaldo")
4952:                     SELECT dbSaldo
4953:                     GO TOP
4954:                     IF !EOF()
4955:                         SCAN
4956:                             INSERT INTO TmpRelGv (CabTipo, ValTipo, Grupo, Valor, Moeda) ;
4957:                                 VALUES (loc_cCabTipo, loc_nValTipo, dbSaldo.grupos, ;
4958:                                     dbSaldo.saldos, dbSaldo.moedas)

*-- Linhas 5337 a 5702:
5337:             SELECT TmpRelGv
5338:             GO TOP
5339:             IF EOF()
5340:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " dados para imprimir...", ;
5341:                     "Impress" + CHR(227) + "o")
5342:             ELSE
5343:                 THIS.ImprimirListagem("SIGOPCGV", "TmpRelGv")
5344:             ENDIF
5345: 
5346:             IF USED("TmpRelGv")
5347:                 USE IN TmpRelGv
5348:             ENDIF
5349:             IF USED("TmpTotal")
5350:                 USE IN TmpTotal
5351:             ENDIF
5352:         CATCH TO loc_oErro
5353:             MsgErro(loc_oErro.Message + CHR(13) + ;
5354:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
5355:                 "Erro ao gerar a impress" + CHR(227) + "o")
5356:         ENDTRY
5357:     ENDPROC
5358: 
5359:     *==========================================================================
5360:     * AtualizarGradesCheques - Funil UNICO de repintura da aba Cheques: aplica
5361:     * o filtro de grupo nas duas grades filtraveis, espelha os totais do BO nos
5362:     * campos somente-leitura e repinta as quatro grades.
5363:     * PUBLIC: chamado de fora (combo, carga e harness de teste).
5364:     *==========================================================================
5365:     PROCEDURE AtualizarGradesCheques()
5366:         LOCAL loc_oAba, loc_oErro
5367: 
5368:         TRY
5369:             IF THIS.AbaResultadoDisponivel(3)
5370:                 loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page3
5371: 
5372:                 THIS.FiltrarPorGrupo("dbAberto",    loc_oAba.cbo_4c_GrupoCheque.Value)
5373:                 THIS.FiltrarPorGrupo("dbDevolvido", loc_oAba.cbo_4c_GrupoCheque.Value)
5374: 
5375:                 IF USED("DbTitulo")
5376:                     GO TOP IN DbTitulo
5377:                 ENDIF
5378:                 IF USED("DbFollow")
5379:                     GO TOP IN DbFollow
5380:                 ENDIF
5381: 
5382:                 THIS.PreencherTotaisCheques()
5383: 
5384:                 loc_oAba.grd_4c_ChequeAberto.Refresh()
5385:                 loc_oAba.grd_4c_ChequeFollowup.Refresh()
5386:                 loc_oAba.grd_4c_ChequeTitulo.Refresh()
5387:                 loc_oAba.grd_4c_ChequeDevolvido.Refresh()
5388:             ENDIF
5389:         CATCH TO loc_oErro
5390:             MsgErro(loc_oErro.Message + CHR(13) + ;
5391:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
5392:                 "Erro ao atualizar as grades de cheques")
5393:         ENDTRY
5394:     ENDPROC
5395: 
5396:     *==========================================================================
5397:     * PreencherTotaisCheques - Espelha nos campos somente-leitura da aba
5398:     * Cheques os totais calculados pelo BO (o fim do Processa() legado), mais o
5399:     * total da grade de devolvidos, que o legado recalcula a cada troca de
5400:     * grupo no Cmb_Grupo.InteractiveChange.
5401:     *
5402:     * "Limite Disponivel" sai em VERMELHO quando negativo e AZUL quando
5403:     * positivo, como no legado.
5404:     *==========================================================================
5405:     PROCEDURE PreencherTotaisCheques()
5406:         LOCAL loc_oAba, loc_oBO, loc_nTotDev, loc_cMoeda, loc_oErro
5407: 
5408:         TRY
5409:             IF THIS.AbaResultadoDisponivel(3) AND VARTYPE(THIS.this_oBusinessObject) = "O"
5410:                 loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page3
5411:                 loc_oBO  = THIS.this_oBusinessObject
5412: 
5413:                 loc_oAba.txt_4c_LimiteCred.Value  = loc_oBO.this_nLimiteCredito
5414:                 loc_oAba.txt_4c_ChqAVencer.Value  = loc_oBO.this_nChequesAVencer
5415:                 loc_oAba.txt_4c_ChqVencidos.Value = loc_oBO.this_nChequesVencidos
5416:                 loc_oAba.txt_4c_ChqDevolv.Value   = loc_oBO.this_nChequesDevolvidos
5417:                 loc_oAba.txt_4c_SaldoCC.Value     = loc_oBO.this_nSaldoContaCorrente
5418:                 loc_oAba.txt_4c_ChqNegoc.Value    = loc_oBO.this_nChequesNegociados
5419:                 loc_oAba.txt_4c_VlEstoque.Value   = loc_oBO.this_nValorEstoque
5420:                 loc_oAba.txt_4c_LimiteDisp.Value  = loc_oBO.this_nLimiteDisponivel
5421: 
5422:                 loc_oAba.txt_4c_LimiteDisp.ForeColor = ;
5423:                     IIF(loc_oBO.this_nLimiteDisponivel < 0, RGB(255, 0, 0), RGB(0, 0, 255))
5424: 
5425:                 loc_oAba.txt_4c_TotChequeAberto.Value = loc_oBO.this_nTotalChequeAberto
5426: 
5427:                 *-- Total dos devolvidos VISIVEIS (respeita o filtro de grupo)
5428:                 loc_nTotDev = 0
5429:                 IF USED("dbDevolvido")
5430:                     SELECT dbDevolvido
5431:                     SUM dbDevolvido.valors TO loc_nTotDev
5432:                     GO TOP IN dbDevolvido
5433:                 ENDIF
5434:                 loc_oAba.txt_4c_TotDevolvido.Value = loc_nTotDev
5435: 
5436:                 *-- Moeda do limite de credito nos dois rotulos "R$" do legado
5437:                 loc_cMoeda = ALLTRIM(loc_oBO.this_cMoedaPadrao)
5438:                 IF !EMPTY(loc_cMoeda)
5439:                     loc_oAba.lbl_4c_MoedaConta.Caption = loc_cMoeda
5440:                     loc_oAba.lbl_4c_MoedaHist.Caption  = loc_cMoeda
5441:                 ENDIF
5442: 
5443:                 loc_oAba.Refresh()
5444:             ENDIF
5445:         CATCH TO loc_oErro
5446:             MsgErro(loc_oErro.Message + CHR(13) + ;
5447:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
5448:                 "Erro ao exibir os totais de cheques")
5449:         ENDTRY
5450:     ENDPROC
5451: 
5452:     *==========================================================================
5453:     * CboGrupoChequeInteractiveChange - Cmb_Grupo.InteractiveChange da aba
5454:     * Cheques: refaz o filtro de grupo, os totais e a repintura.
5455:     *==========================================================================
5456:     PROCEDURE CboGrupoChequeInteractiveChange()
5457:         THIS.AtualizarGradesCheques()
5458:     ENDPROC
5459: 
5460:     *==========================================================================
5461:     * GradeChequeAbertoAfterRowColChange - grd_che_aberto.AfterRowColChange do
5462:     * legado: o follow-up exibido eh o do cheque da linha corrente.
5463:     *
5464:     * Sem filtro de coluna de proposito: aqui o AfterRowColChange eh usado para
5465:     * carregar o DETALHE da linha corrente (uso correto do evento), nao para
5466:     * validar celula.
5467:     *==========================================================================
5468:     PROCEDURE GradeChequeAbertoAfterRowColChange(par_nColIndex)
5469:         LOCAL loc_oAba, loc_oErro
5470: 
5471:         TRY
5472:             IF USED("DbFollow") AND USED("dbAberto") AND THIS.AbaResultadoDisponivel(3)
5473:                 loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page3
5474: 
5475:                 SELECT DbFollow
5476:                 SET ORDER TO TAG Nums
5477:                 IF EOF("dbAberto") OR EMPTY(TratarNulo(dbAberto.Nums, ""))
5478:                     SET KEY TO
5479:                 ELSE
5480:                     SET KEY TO PADR(ALLTRIM(dbAberto.Nums), 8)
5481:                 ENDIF
5482:                 GO TOP
5483: 
5484:                 loc_oAba.grd_4c_ChequeFollowup.Refresh()
5485:                 SELECT dbAberto
5486:             ENDIF
5487:         CATCH TO loc_oErro
5488:             MsgErro(loc_oErro.Message + CHR(13) + ;
5489:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
5490:                 "Erro ao exibir o follow-up do cheque")
5491:         ENDTRY
5492:     ENDPROC
5493: 
5494:     *==========================================================================
5495:     * GradeChequeTituloAfterRowColChange - Grd_titulo.AfterRowColChange do
5496:     * legado: a observacao do titulo corrente vai para os dois campos de
5497:     * observacao (o legado parte o historico de 40 em duas metades de 20).
5498:     *==========================================================================
5499:     PROCEDURE GradeChequeTituloAfterRowColChange(par_nColIndex)
5500:         LOCAL loc_oAba, loc_cHists, loc_oErro
5501: 
5502:         TRY
5503:             IF USED("DbTitulo") AND THIS.AbaResultadoDisponivel(3)
5504:                 loc_oAba   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page3
5505:                 loc_cHists = IIF(EOF("DbTitulo"), "", TratarNulo(DbTitulo.Hists, ""))
5506: 
5507:                 loc_oAba.txt_4c_ObsNegoc1.Value = LEFT(loc_cHists, 20)
5508:                 loc_oAba.txt_4c_ObsNegoc2.Value = RIGHT(loc_cHists, 20)
5509:                 loc_oAba.txt_4c_ObsNegoc1.Refresh()
5510:                 loc_oAba.txt_4c_ObsNegoc2.Refresh()
5511:             ENDIF
5512:         CATCH TO loc_oErro
5513:             MsgErro(loc_oErro.Message + CHR(13) + ;
5514:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
5515:                 "Erro ao exibir a observa" + CHR(231) + CHR(227) + "o do t" + ;
5516:                 CHR(237) + "tulo")
5517:         ENDTRY
5518:     ENDPROC
5519: 
5520:     *==========================================================================
5521:     * AtualizarGradeCartao - Funil UNICO de repintura da aba Cartao.
5522:     * PUBLIC: chamado de fora (carga e harness de teste).
5523:     *==========================================================================
5524:     PROCEDURE AtualizarGradeCartao()
5525:         LOCAL loc_oErro
5526: 
5527:         TRY
5528:             IF THIS.AbaResultadoDisponivel(4)
5529:                 IF USED("TmpCart")
5530:                     GO TOP IN TmpCart
5531:                 ENDIF
5532:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page4.grd_4c_Cartao.Refresh()
5533:             ENDIF
5534:         CATCH TO loc_oErro
5535:             MsgErro(loc_oErro.Message + CHR(13) + ;
5536:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
5537:                 "Erro ao atualizar a grade de cart" + CHR(245) + "es")
5538:         ENDTRY
5539:     ENDPROC
5540: 
5541:     *==========================================================================
5542:     * AtualizarGradeEstoque - Funil UNICO de repintura da aba Estoque: aplica o
5543:     * filtro de grupo e repinta.
5544:     * PUBLIC: chamado de fora (combo, carga e harness de teste).
5545:     *==========================================================================
5546:     PROCEDURE AtualizarGradeEstoque()
5547:         LOCAL loc_oAba, loc_oErro
5548: 
5549:         TRY
5550:             IF THIS.AbaResultadoDisponivel(6)
5551:                 loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page6
5552:                 THIS.FiltrarPorGrupo("dbEstoque", loc_oAba.cbo_4c_GrupoEstoque.Value)
5553:                 loc_oAba.grd_4c_Estoque.Refresh()
5554:             ENDIF
5555:         CATCH TO loc_oErro
5556:             MsgErro(loc_oErro.Message + CHR(13) + ;
5557:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
5558:                 "Erro ao atualizar a grade de estoque")
5559:         ENDTRY
5560:     ENDPROC
5561: 
5562:     *==========================================================================
5563:     * CboGrupoEstoqueInteractiveChange - Cmb_Grupo.InteractiveChange da aba
5564:     * Estoque.
5565:     *==========================================================================
5566:     PROCEDURE CboGrupoEstoqueInteractiveChange()
5567:         THIS.AtualizarGradeEstoque()
5568:     ENDPROC
5569: 
5570:     *==========================================================================
5571:     * AtualizarGradeHCheques - Funil UNICO de repintura da aba H.Cheques
5572:     * (regra #21a). GO TOP nos tres cursores + Refresh das tres grades.
5573:     * PUBLIC: chamado de fora (carga, grid e harness de teste).
5574:     *==========================================================================
5575:     PROCEDURE AtualizarGradeHCheques()
5576:         LOCAL loc_oAba, loc_oErro
5577: 
5578:         TRY
5579:             IF THIS.AbaResultadoDisponivel(9)
5580:                 loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page9
5581: 
5582:                 IF USED("dbCheqHist")
5583:                     SELECT dbCheqHist
5584:                     GO TOP
5585:                 ENDIF
5586:                 IF USED("dbCheqMovim")
5587:                     SELECT dbCheqMovim
5588:                     GO TOP
5589:                 ENDIF
5590:                 IF USED("dbCheqProrrog")
5591:                     SELECT dbCheqProrrog
5592:                     GO TOP
5593:                 ENDIF
5594: 
5595:                 loc_oAba.grd_4c_HistCheque.Refresh()
5596:                 loc_oAba.grd_4c_MovCheque.Refresh()
5597:                 loc_oAba.grd_4c_ProrrogCheque.Refresh()
5598: 
5599:                 loc_oAba.cnt_4c_Followup.txt_4c_UltFollowup.Value = ;
5600:                     TratarNulo(THIS.this_oBusinessObject.this_cFollowUpCheque, "")
5601:             ENDIF
5602:         CATCH TO loc_oErro
5603:             MsgErro(loc_oErro.Message + CHR(13) + ;
5604:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
5605:                 "Erro ao atualizar a grade de hist" + CHR(243) + "rico de cheques")
5606:         ENDTRY
5607:     ENDPROC
5608: 
5609:     *==========================================================================
5610:     * GradeHistChequeAfterRowColChange - Transcricao do AfterRowColChange da
5611:     * GradeCheque do legado (aba H.Cheques): ao mudar de linha, recarrega a
5612:     * movimentacao/prorrogacoes/follow-up do cheque agora selecionado e
5613:     * atualiza o Caption do form com o cliente da conta (todas as linhas desta
5614:     * grade pertencem a mesma conta pesquisada - this_cDescConta/this_cCpf ja
5615:     * carregados, sem precisar reconsultar SigCdCli a cada linha).
5616:     * PUBLIC: ligado via BINDEVENT.
5617:     *==========================================================================
5618:     PROCEDURE GradeHistChequeAfterRowColChange(par_nColIndex)
5619:         LOCAL loc_oAba, loc_oBO, loc_cNums, loc_oErro
5620: 
5621:         TRY
5622:             loc_oBO = THIS.this_oBusinessObject
5623:             IF VARTYPE(loc_oBO) = "O" AND USED("dbCheqHist") AND RECCOUNT("dbCheqHist") > 0
5624:                 loc_cNums = ALLTRIM(dbCheqHist.Nums)
5625: 
5626:                 IF !EMPTY(loc_cNums)
5627:                     THIS.Caption = "Hist" + CHR(243) + "rico de Cheques de: " + ;
5628:                         ALLTRIM(loc_oBO.this_cConta) + " - " + ;
5629:                         ALLTRIM(loc_oBO.this_cDescConta) + " / " + ALLTRIM(loc_oBO.this_cCpf)
5630: 
5631:                     loc_oBO.CarregarMovimentoCheque(loc_cNums)
5632: 
5633:                     IF THIS.AbaResultadoDisponivel(9)
5634:                         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page9
5635: 
5636:                         SELECT dbCheqMovim
5637:                         GO TOP
5638:                         loc_oAba.grd_4c_MovCheque.Refresh()
5639: 
5640:                         SELECT dbCheqProrrog
5641:                         GO TOP
5642:                         loc_oAba.grd_4c_ProrrogCheque.Refresh()
5643: 
5644:                         loc_oAba.cnt_4c_Followup.txt_4c_UltFollowup.Value = ;
5645:                             TratarNulo(loc_oBO.this_cFollowUpCheque, "")
5646:                     ENDIF
5647:                 ENDIF
5648:             ENDIF
5649:         CATCH TO loc_oErro
5650:             MsgErro(loc_oErro.Message + CHR(13) + ;
5651:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
5652:                 "Erro ao atualizar a movimenta" + CHR(231) + CHR(227) + "o do cheque")
5653:         ENDTRY
5654:     ENDPROC
5655: 
5656:     *==========================================================================
5657:     * AtualizarGradeCredito - Funil UNICO de repintura da aba Credito: GO TOP
5658:     * + Refresh da grade e o rotulo colorido de situacao do cliente (Label2 do
5659:     * legado - vermelho quando SigCdCli.Situas = "*", azul nos demais casos).
5660:     * PUBLIC: chamado de fora (carga e harness de teste).
5661:     *==========================================================================
5662:     PROCEDURE AtualizarGradeCredito()
5663:         LOCAL loc_oAba, loc_oBO, loc_oErro
5664: 
5665:         TRY
5666:             IF THIS.AbaResultadoDisponivel(10)
5667:                 loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page10
5668:                 loc_oBO  = THIS.this_oBusinessObject
5669: 
5670:                 IF USED("dbCredito")
5671:                     SELECT dbCredito
5672:                     GO TOP
5673:                 ENDIF
5674: 
5675:                 loc_oAba.pgf_4c_Credito.Page1.grd_4c_Credito.Refresh()
5676: 
5677:                 IF VARTYPE(loc_oBO) = "O"
5678:                     loc_oAba.lbl_4c_SituacaoCredito.Caption = ;
5679:                         IIF(EMPTY(loc_oBO.this_cLabelSituacaoCredito), ;
5680:                             "CLIENTE", ALLTRIM(loc_oBO.this_cLabelSituacaoCredito))
5681:                     loc_oAba.lbl_4c_SituacaoCredito.ForeColor = ;
5682:                         IIF(loc_oBO.this_lSituacaoVermelha, RGB(255, 0, 0), RGB(0, 0, 255))
5683:                 ENDIF
5684:             ENDIF
5685:         CATCH TO loc_oErro
5686:             MsgErro(loc_oErro.Message + CHR(13) + ;
5687:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
5688:                 "Erro ao atualizar a grade de cr" + CHR(233) + "dito")
5689:         ENDTRY
5690:     ENDPROC
5691: 
5692:     *==========================================================================
5693:     * AbaResultadoDisponivel - .T. quando a aba N da pagina Resultado ja esta
5694:     * montada. As repinturas sao chamadas tambem durante a carga, antes de a
5695:     * fase de montagem terminar - por isso o guard, que evita "object is not
5696:     * found" sem precisar de TRY vazio em cada chamador.
5697:     *==========================================================================
5698:     PROTECTED FUNCTION AbaResultadoDisponivel(par_nAba)
5699:         LOCAL loc_lDisponivel, loc_oPg
5700:         loc_lDisponivel = .F.
5701: 
5702:         IF PEMSTATUS(THIS, "pgf_4c_Paginas", 5)

*-- Linhas 5720 a 5849:
5720:     * grade pelo seu funil.
5721:     * PUBLIC: chamado por CarregarDados e pelo harness de teste.
5722:     *==========================================================================
5723:     PROCEDURE CarregarAbasResultado()
5724:         LOCAL loc_oBO, loc_lSucesso, loc_oErro
5725:         loc_lSucesso = .F.
5726: 
5727:         TRY
5728:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
5729:                 loc_oBO = THIS.this_oBusinessObject
5730: 
5731:                 *-- Parametros (grupo padrao, moedas, tipo de preco, flags de
5732:                 *-- limite) - de quem dependem os totais da aba Cheques
5733:                 loc_oBO.CarregarParametros()
5734: 
5735:                 *-- Pendencias
5736:                 IF loc_oBO.CarregarPendencias()
5737:                     IF THIS.AbaResultadoDisponivel(2)
5738:                         THIS.PreencherComboGrupo( ;
5739:                             THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page2.cbo_4c_GrupoPend, ;
5740:                             "TmpPar")
5741:                     ENDIF
5742:                     THIS.AtualizarGradePendencias()
5743:                 ELSE
5744:                     IF !EMPTY(loc_oBO.this_cMensagemErro)
5745:                         MsgAviso(loc_oBO.this_cMensagemErro, "Pend" + CHR(234) + "ncias")
5746:                     ENDIF
5747:                 ENDIF
5748: 
5749:                 *-- Cheques
5750:                 IF loc_oBO.CarregarCheques()
5751:                     IF THIS.AbaResultadoDisponivel(3)
5752:                         THIS.PreencherComboGrupo( ;
5753:                             THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page3.cbo_4c_GrupoCheque, ;
5754:                             "dbAberto")
5755:                     ENDIF
5756:                     THIS.AtualizarGradesCheques()
5757:                 ELSE
5758:                     IF !EMPTY(loc_oBO.this_cMensagemErro)
5759:                         MsgAviso(loc_oBO.this_cMensagemErro, "Cheques")
5760:                     ENDIF
5761:                 ENDIF
5762: 
5763:                 *-- Cartoes
5764:                 IF loc_oBO.CarregarCartoes()
5765:                     THIS.AtualizarGradeCartao()
5766:                 ELSE
5767:                     IF !EMPTY(loc_oBO.this_cMensagemErro)
5768:                         MsgAviso(loc_oBO.this_cMensagemErro, "Cart" + CHR(245) + "es")
5769:                     ENDIF
5770:                 ENDIF
5771: 
5772:                 *-- Estoque
5773:                 IF loc_oBO.CarregarEstoque()
5774:                     IF THIS.AbaResultadoDisponivel(6)
5775:                         THIS.PreencherComboGrupo( ;
5776:                             THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page6.cbo_4c_GrupoEstoque, ;
5777:                             "dbEstoque")
5778:                     ENDIF
5779:                     THIS.AtualizarGradeEstoque()
5780:                 ELSE
5781:                     IF !EMPTY(loc_oBO.this_cMensagemErro)
5782:                         MsgAviso(loc_oBO.this_cMensagemErro, "Estoque")
5783:                     ENDIF
5784:                 ENDIF
5785: 
5786:                 *-- H.Cheques
5787:                 IF loc_oBO.CarregarHCheques()
5788:                     THIS.AtualizarGradeHCheques()
5789:                 ELSE
5790:                     IF !EMPTY(loc_oBO.this_cMensagemErro)
5791:                         MsgAviso(loc_oBO.this_cMensagemErro, "Hist" + CHR(243) + "rico de Cheques")
5792:                     ENDIF
5793:                 ENDIF
5794: 
5795:                 *-- Credito
5796:                 IF loc_oBO.CarregarCredito()
5797:                     THIS.AtualizarGradeCredito()
5798:                 ELSE
5799:                     IF !EMPTY(loc_oBO.this_cMensagemErro)
5800:                         MsgAviso(loc_oBO.this_cMensagemErro, "Cr" + CHR(233) + "dito")
5801:                     ENDIF
5802:                 ENDIF
5803: 
5804:                 loc_lSucesso = .T.
5805:             ENDIF
5806:         CATCH TO loc_oErro
5807:             MsgErro(loc_oErro.Message + CHR(13) + ;
5808:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
5809:                 "Proc: " + loc_oErro.Procedure, "Erro ao carregar as abas de resultado")
5810:         ENDTRY
5811: 
5812:         RETURN loc_lSucesso
5813:     ENDPROC
5814: 
5815: 
5816: 
5817:     *==========================================================================
5818:     *                   FASE 8/8 - EVENTOS AUXILIARES
5819:     *
5820:     * Os nomes canonicos abaixo nao sao decoracao: cada um recebeu o bloco do
5821:     * legado que faz aquele papel nesta tela, e os metodos das fases anteriores
5822:     * passaram a entrar por eles (funil unico, regra #40).
5823:     *
5824:     *   FormParaBO / BOParaForm  -> os cinco criterios do container Origem
5825:     *                               (Conta / Nome / CPF / Conjuge / Telefone),
5826:     *                               o optFiltro e o periodo do cnt_periodo.
5827:     *   HabilitarCampos          -> a cascata de When do legado nos criterios
5828:     *                               (Get_cpf.When, Get_dconta.When,
5829:     *                               GetConj.When, getTelefone.When,
5830:     *                               optFiltro.When).
5831:     *   LimparCampos             -> o Space(N) dos cinco campos no
5832:     *                               cmd_voltar.Click mais o LimparDados do BO.
5833:     *   AjustarBotoesPorModo     -> os gates de acesso do Init legado
5834:     *                               (fChecaAcesso CADASTRO/MOVIMENTA) e do par
5835:     *                               Cmd_MudaCli/Cmd_MudaMov (mais IMPRIMIR no
5836:     *                               Imprime), aplicados conforme a pagina e a
5837:     *                               visao correntes.
5838:     *   CarregarLista            -> funil de (re)carga da consulta.
5839:     *   BtnBuscarClick           -> dispara/refaz a consulta.
5840:     *   BtnSalvarClick           -> o bloco "Deseja salvar as alteracoes?" do
5841:     *                               cmd_voltar.Click (mValidaObj + mGravaDados).
5842:     *   BtnCancelarClick /
5843:     *   BtnEncerrarClick         -> cmd_cancela.Click ([ESC] Sair).
5844:     *==========================================================================
5845: 
5846:     *==========================================================================
5847:     * FormParaBO - Leva para o Business Object TODO criterio que a tela possui:
5848:     * os cinco campos do container Origem, a opcao de filtro de nome
5849:     * (optFiltro) e o periodo da pagina Resultado. Fonte UNICA eh o controle,

*-- Linhas 5859 a 6139:
5859:     *
5860:     * PUBLIC: chamado por CarregarDados e pelo harness de teste (regra #3).
5861:     *==========================================================================
5862:     PROTECTED PROCEDURE FormParaBO()
5863:         LOCAL loc_lSucesso, loc_oBO, loc_oCnt, loc_oPer, loc_oErro
5864:         loc_lSucesso = .F.
5865: 
5866:         TRY
5867:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
5868:                 loc_oBO = THIS.this_oBusinessObject
5869: 
5870:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_Origem", 5)
5871:                     loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
5872: 
5873:                     loc_oBO.this_cConta     = ALLTRIM(loc_oCnt.txt_4c_Conta.Value)
5874:                     loc_oBO.this_cDescConta = ALLTRIM(loc_oCnt.txt_4c_DConta.Value)
5875:                     loc_oBO.this_cCpf       = ALLTRIM(loc_oCnt.txt_4c_Cpf.Value)
5876:                     loc_oBO.this_cConjuge   = ALLTRIM(loc_oCnt.txt_4c_Conjuge.Value)
5877:                     loc_oBO.this_cTelefone  = ALLTRIM(loc_oCnt.txt_4c_Telefone.Value)
5878: 
5879:                     *-- optFiltro tem ControlSource NUMERICO de 2 opcoes: o
5880:                     *-- valor gravado eh o INDICE 1-based (1 = Iniciais,
5881:                     *-- 2 = Qualquer Parte), nunca 0/1 logico
5882:                     loc_oBO.this_nOpcaoFiltro = loc_oCnt.obj_4c_OptFiltro.Value
5883:                 ENDIF
5884: 
5885:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "cnt_4c_Periodo", 5)
5886:                     loc_oPer = THIS.pgf_4c_Paginas.Page2.cnt_4c_Periodo
5887: 
5888:                     *-- ConverterParaData (nao TTOD): o TextBox nasce com {}
5889:                     *-- (DATE) e a coluna do banco chega como DATETIME (regra #16)
5890:                     loc_oBO.this_dDataInicial = ;
5891:                         ConverterParaData(loc_oPer.txt_4c_DtInicial.Value)
5892:                     loc_oBO.this_dDataFinal = ;
5893:                         ConverterParaData(loc_oPer.txt_4c_DtFinal.Value)
5894:                 ENDIF
5895: 
5896:                 loc_lSucesso = .T.
5897:             ENDIF
5898:         CATCH TO loc_oErro
5899:             MsgErro(loc_oErro.Message + CHR(13) + ;
5900:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
5901:                 "Proc: " + loc_oErro.Procedure, ;
5902:                 "Erro ao transferir os crit" + CHR(233) + "rios para o Business Object")
5903:         ENDTRY
5904: 
5905:         RETURN loc_lSucesso
5906:     ENDPROC
5907: 
5908:     *==========================================================================
5909:     * BOParaForm - Caminho inverso do FormParaBO: devolve aos controles o que o
5910:     * Business Object carregou (equivalente ao preenchimento cruzado dos campos
5911:     * Conta/Nome/CPF/Conjuge/Telefone que o legado faz no fim de cada Valid de
5912:     * pesquisa bem-sucedida).
5913:     *
5914:     * optFiltro so eh reescrito com indice valido (1..ButtonCount): o BO nasce
5915:     * com this_nOpcaoFiltro = 0 e atribuir 0 a um OptionGroup 1-based
5916:     * desmarcaria as duas opcoes.
5917:     *
5918:     * PUBLIC: chamado por AtualizarCamposOrigem e pelo harness de teste.
5919:     *==========================================================================
5920:     PROTECTED PROCEDURE BOParaForm()
5921:         LOCAL loc_oBO, loc_oCnt, loc_oPer, loc_oErro
5922: 
5923:         TRY
5924:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
5925:                 loc_oBO = THIS.this_oBusinessObject
5926: 
5927:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_Origem", 5)
5928:                     loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
5929: 
5930:                     loc_oCnt.txt_4c_Conta.Value    = loc_oBO.this_cConta
5931:                     loc_oCnt.txt_4c_DConta.Value   = loc_oBO.this_cDescConta
5932:                     loc_oCnt.txt_4c_Cpf.Value      = loc_oBO.this_cCpf
5933:                     loc_oCnt.txt_4c_Conjuge.Value  = loc_oBO.this_cConjuge
5934:                     loc_oCnt.txt_4c_Telefone.Value = loc_oBO.this_cTelefone
5935: 
5936:                     IF BETWEEN(loc_oBO.this_nOpcaoFiltro, 1, ;
5937:                             loc_oCnt.obj_4c_OptFiltro.ButtonCount)
5938:                         loc_oCnt.obj_4c_OptFiltro.Value = loc_oBO.this_nOpcaoFiltro
5939:                     ENDIF
5940: 
5941:                     loc_oCnt.Refresh()
5942:                 ENDIF
5943: 
5944:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "cnt_4c_Periodo", 5)
5945:                     loc_oPer = THIS.pgf_4c_Paginas.Page2.cnt_4c_Periodo
5946:                     loc_oPer.txt_4c_DtInicial.Value = loc_oBO.this_dDataInicial
5947:                     loc_oPer.txt_4c_DtFinal.Value   = loc_oBO.this_dDataFinal
5948:                 ENDIF
5949: 
5950:                 *-- Criterio novo na tela muda a cascata de When do legado
5951:                 THIS.HabilitarCampos(.T.)
5952:             ENDIF
5953:         CATCH TO loc_oErro
5954:             MsgErro(loc_oErro.Message + CHR(13) + ;
5955:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
5956:                 "Proc: " + loc_oErro.Procedure, ;
5957:                 "Erro ao exibir os dados do cliente")
5958:         ENDTRY
5959:     ENDPROC
5960: 
5961:     *==========================================================================
5962:     * HabilitarCampos - Cascata de When dos criterios da Origem, transcrita
5963:     * campo a campo do dump legado:
5964:     *
5965:     *   Get_conta.When    -> .T. (sempre digitavel)
5966:     *   Get_cpf.When      -> Empty(Get_Conta)
5967:     *   Get_dconta.When   -> Empty(Get_Conta) And Empty(Get_Cpf) And !plCPF
5968:     *   GetConj.When      -> Empty(Get_Conta) And Empty(Get_Cpf) And
5969:     *                        Empty(Get_DConta) And !plCPF
5970:     *   getTelefone.When  -> Empty(Get_Conta) And Empty(Get_Cpf) And
5971:     *                        Empty(Get_DConta) And Empty(getConj)
5972:     *   optFiltro.When    -> !plCPF
5973:     *
5974:     * Usa ReadOnly nos TextBox (e nao Enabled): o When legado bloqueia a
5975:     * DIGITACAO e mantem o texto legivel - exatamente o que ReadOnly faz -, e
5976:     * ReadOnly pode ser trocado durante o LostFocus do proprio campo sem
5977:     * disputar o foco corrente. O OptionGroup nao tem ReadOnly, e a regra dele
5978:     * depende apenas de plCPF (que nao muda no meio da digitacao), por isso
5979:     * continua em Enabled.
5980:     *
5981:     * par_lHabilitar = .F. tranca TODOS os criterios de uma vez (usado quando a
5982:     * tela esta com um painel modal aberto por cima); omitido ou .T. aplica a
5983:     * cascata do legado. PUBLIC: chamado pelos funis e pelo harness de teste.
5984:     *==========================================================================
5985:     PROCEDURE HabilitarCampos(par_lHabilitar)
5986:         LOCAL loc_oCnt, loc_lLiberar, loc_lSoCpf, loc_oErro
5987:         LOCAL loc_lTemConta, loc_lTemCpf, loc_lTemNome, loc_lTemConjuge
5988: 
5989:         loc_lLiberar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
5990: 
5991:         TRY
5992:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_Origem", 5)
5993:                 loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
5994: 
5995:                 loc_lSoCpf = .F.
5996:                 IF VARTYPE(THIS.this_oBusinessObject) = "O"
5997:                     loc_lSoCpf = THIS.this_oBusinessObject.this_lSomenteCPF
5998:                 ENDIF
5999: 
6000:                 loc_lTemConta   = !EMPTY(ALLTRIM(loc_oCnt.txt_4c_Conta.Value))
6001:                 loc_lTemCpf     = !EMPTY(ALLTRIM(loc_oCnt.txt_4c_Cpf.Value))
6002:                 loc_lTemNome    = !EMPTY(ALLTRIM(loc_oCnt.txt_4c_DConta.Value))
6003:                 loc_lTemConjuge = !EMPTY(ALLTRIM(loc_oCnt.txt_4c_Conjuge.Value))
6004: 
6005:                 loc_oCnt.txt_4c_Conta.ReadOnly = !loc_lLiberar
6006: 
6007:                 loc_oCnt.txt_4c_Cpf.ReadOnly = ;
6008:                     !(loc_lLiberar AND !loc_lTemConta)
6009: 
6010:                 loc_oCnt.txt_4c_DConta.ReadOnly = ;
6011:                     !(loc_lLiberar AND !loc_lTemConta AND !loc_lTemCpf AND !loc_lSoCpf)
6012: 
6013:                 loc_oCnt.txt_4c_Conjuge.ReadOnly = ;
6014:                     !(loc_lLiberar AND !loc_lTemConta AND !loc_lTemCpf AND ;
6015:                       !loc_lTemNome AND !loc_lSoCpf)
6016: 
6017:                 loc_oCnt.txt_4c_Telefone.ReadOnly = ;
6018:                     !(loc_lLiberar AND !loc_lTemConta AND !loc_lTemCpf AND ;
6019:                       !loc_lTemNome AND !loc_lTemConjuge)
6020: 
6021:                 loc_oCnt.obj_4c_OptFiltro.Enabled = (loc_lLiberar AND !loc_lSoCpf)
6022:             ENDIF
6023:         CATCH TO loc_oErro
6024:             MsgErro(loc_oErro.Message + CHR(13) + ;
6025:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
6026:                 "Proc: " + loc_oErro.Procedure, ;
6027:                 "Erro ao habilitar os crit" + CHR(233) + "rios de pesquisa")
6028:         ENDTRY
6029:     ENDPROC
6030: 
6031:     *==========================================================================
6032:     * LimparCampos - Bloco de limpeza do cmd_voltar.Click legado:
6033:     *
6034:     *   .Get_conta.Value    = Space(10)
6035:     *   .Get_dconta.Value   = Space(50)
6036:     *   .Get_cpf.Value      = Space(20)
6037:     *   .GetConj.Value      = Space(40)
6038:     *   .getTelefone.Value  = Space(15)
6039:     *   .Refresh
6040:     *
6041:     * mais o LimparDados do BO (que zera os criterios, os flags de controle da
6042:     * consulta e os totais derivados - sem isso a tela mostraria os numeros da
6043:     * conta anterior) e a reaplicacao da cascata de When, que volta a liberar
6044:     * os cinco campos agora que estao vazios.
6045:     *
6046:     * O periodo NAO eh limpo: o legado tambem o preserva entre consultas.
6047:     * PUBLIC: chamado por AlternarPagina e pelo harness de teste.
6048:     *==========================================================================
6049:     PROTECTED PROCEDURE LimparCampos()
6050:         LOCAL loc_oCnt, loc_oErro
6051: 
6052:         TRY
6053:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_Origem", 5)
6054:                 loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
6055: 
6056:                 loc_oCnt.txt_4c_Conta.Value    = ""
6057:                 loc_oCnt.txt_4c_DConta.Value   = ""
6058:                 loc_oCnt.txt_4c_Cpf.Value      = ""
6059:                 loc_oCnt.txt_4c_Conjuge.Value  = ""
6060:                 loc_oCnt.txt_4c_Telefone.Value = ""
6061:                 loc_oCnt.Refresh()
6062:             ENDIF
6063: 
6064:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
6065:                 THIS.this_oBusinessObject.LimparDados()
6066:             ENDIF
6067: 
6068:             THIS.HabilitarCampos(.T.)
6069:         CATCH TO loc_oErro
6070:             MsgErro(loc_oErro.Message + CHR(13) + ;
6071:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
6072:                 "Proc: " + loc_oErro.Procedure, ;
6073:                 "Erro ao limpar os crit" + CHR(233) + "rios de pesquisa")
6074:         ENDTRY
6075:     ENDPROC
6076: 
6077:     *==========================================================================
6078:     * AjustarBotoesPorModo - Gates de acesso do legado, num funil unico.
6079:     *
6080:     * Pagina Consulta (Init legado):
6081:     *   If Not fChecaAcesso('SIGOPCGV','CADASTRO')  -> Cmd_Cadastro invisivel
6082:     *   If !fChecaAcesso('SIGOPCGV','MOVIMENTA')    -> Cmd_Movimenta invisivel
6083:     *   (Cmd_Cancela nunca depende de acesso)
6084:     *
6085:     * Pagina Resultado (cmd_cadastro.Click do Cmd_MudaCli e cmd_movimenta.Click
6086:     * do Cmd_MudaMov):
6087:     *   .Imprime.Visible = fChecaAcesso('SIGOPCGV','IMPRIMIR')
6088:     *   visao MOVIMENTO  -> MudaCli visivel se fChecaAcesso(...,'CADASTRO')
6089:     *   visao CADASTRO   -> MudaMov visivel se fChecaAcesso(...,'MOVIMENTA')
6090:     *   (o par nunca fica visivel junto - os dois estao no mesmo Left no SCX)
6091:     *
6092:     * O legado tambem reposiciona o grp_operacao quando esconde um botao
6093:     * (Cmd_Movimenta.Left - 81, Width - 81, Left + 81): isso vai junto, para a
6094:     * barra nao ficar com um buraco no lugar do botao escondido.
6095:     *
6096:     * PUBLIC: chamado por AlternarPagina, por AjustarVisibilidadeResultado e
6097:     * pelo harness de teste (regra #3).
6098:     *==========================================================================
6099:     PROCEDURE AjustarBotoesPorModo()
6100:         LOCAL loc_oPg1, loc_oPg2, loc_oGrp, loc_oErro
6101:         LOCAL loc_lCadastro, loc_lMovimenta, loc_lImprimir
6102:         LOCAL loc_lResultado, loc_lVisaoMov, loc_nLargura, loc_nLeft
6103: 
6104:         TRY
6105:             loc_lCadastro  = fChecaAcesso("SIGOPCGV", "CADASTRO")
6106:             loc_lMovimenta = fChecaAcesso("SIGOPCGV", "MOVIMENTA")
6107:             loc_lImprimir  = fChecaAcesso("SIGOPCGV", "IMPRIMIR")
6108: 
6109:             loc_lResultado = (THIS.this_cModoAtual == "RESULTADO")
6110:             loc_lVisaoMov  = (THIS.this_cModoResultado == "MOVIMENTO")
6111: 
6112:             *-- Pagina Consulta
6113:             loc_oPg1 = THIS.pgf_4c_Paginas.Page1
6114:             IF PEMSTATUS(loc_oPg1, "cmg_4c_GrpOperacao", 5)
6115:                 loc_oGrp = loc_oPg1.cmg_4c_GrpOperacao
6116: 
6117:                 loc_oGrp.Buttons(1).Visible = loc_lCadastro
6118:                 loc_oGrp.Buttons(1).Enabled = loc_lCadastro
6119:                 loc_oGrp.Buttons(2).Visible = loc_lMovimenta
6120:                 loc_oGrp.Buttons(2).Enabled = loc_lMovimenta
6121:                 loc_oGrp.Buttons(3).Visible = .T.
6122:                 loc_oGrp.Buttons(3).Enabled = .T.
6123: 
6124:                 *-- Fecha o buraco deixado por botao escondido (o legado move os
6125:                 *-- botoes restantes 81px para a esquerda e encolhe o grupo)
6126:                 loc_nLargura = 235
6127:                 loc_nLeft    = 769
6128: 
6129:                 IF !loc_lCadastro
6130:                     loc_oGrp.Buttons(2).Left = 5
6131:                     loc_oGrp.Buttons(3).Left = 80
6132:                     loc_nLargura = loc_nLargura - 81
6133:                     loc_nLeft    = loc_nLeft + 81
6134:                 ENDIF
6135: 
6136:                 IF !loc_lMovimenta
6137:                     loc_oGrp.Buttons(3).Left = IIF(loc_lCadastro, 80, 5)
6138:                     loc_nLargura = loc_nLargura - 81
6139:                     loc_nLeft    = loc_nLeft + 81

*-- Linhas 6170 a 6300:
6170:         CATCH TO loc_oErro
6171:             MsgErro(loc_oErro.Message + CHR(13) + ;
6172:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
6173:                 "Proc: " + loc_oErro.Procedure, ;
6174:                 "Erro ao ajustar os bot" + CHR(245) + "es")
6175:         ENDTRY
6176:     ENDPROC
6177: 
6178:     *==========================================================================
6179:     * CarregarLista - Funil de (re)carga da consulta. Nesta tela a "lista" sao
6180:     * as grades das abas da pagina Resultado, e quem as popula eh o
6181:     * CarregarDados (historico/saldo) somado ao CarregarAbasResultado
6182:     * (pendencias, cheques, cartoes, estoque, historico de cheques e credito),
6183:     * que ele ja encadeia - exatamente a sequencia do Processa() legado.
6184:     * PUBLIC: chamado pelos botoes e pelo harness de teste (regra #3).
6185:     *==========================================================================
6186:     PROCEDURE CarregarLista()
6187:         RETURN THIS.CarregarDados()
6188:     ENDPROC
6189: 
6190:     *==========================================================================
6191:     * BtnBuscarClick - Dispara a consulta. Na pagina Consulta eh a entrada do
6192:     * cmd_movimenta.Click legado (valida a conta, carrega e abre a pagina
6193:     * Resultado na visao MOVIMENTO); com a pagina Resultado ja aberta, refaz a
6194:     * consulta da conta corrente - o mesmo que o legado faz no
6195:     * get_dt_final.LostFocus (ConsultaExecutada = .f. + Processa()).
6196:     *==========================================================================
6197:     PROCEDURE BtnBuscarClick()
6198:         IF THIS.this_cModoAtual == "RESULTADO"
6199:             THIS.this_oBusinessObject.this_lConsultaExecutada = .F.
6200:             THIS.CarregarLista()
6201:             THIS.AtualizarAbaResultadoAtiva()
6202:         ELSE
6203:             THIS.BtnMovimentoClick()
6204:         ENDIF
6205:     ENDPROC
6206: 
6207:     *==========================================================================
6208:     * BtnSalvarClick - Bloco de gravacao do cmd_voltar.Click legado:
6209:     *
6210:     *   IF ThisForm.pcEscolha = 'ALTERAR'
6211:     *       IF MessageBox('Deseja salvar as alteracoes?',32+4,...) = 6
6212:     *           IF thisform...CntConta.mvalidaobj() < 1
6213:     *               RETURN .f.
6214:     *           endif
6215:     *           thisform...CntConta.mgravadados()
6216:     *       ENDIF
6217:     *   ENDIF
6218:     *
6219:     * Retorna .F. SO quando a saida deve ser abortada (a validacao do cadastro
6220:     * recusou): fora do modo ALTERAR, ou com o usuario respondendo Nao, o
6221:     * legado simplesmente segue - por isso .T. nos dois casos.
6222:     *
6223:     * A gravacao em si eh do wrapper cadastral da conta (cntConta), por onde o
6224:     * legado edita o cliente; sem ele na tela a alteracao se faz pelo Cadastro
6225:     * de Clientes, e o metodo diz isso em vez de devolver sucesso falso.
6226:     *
6227:     * PUBLIC: chamado por BtnVoltarClick e pelo harness de teste (regra #3).
6228:     *==========================================================================
6229:     PROCEDURE BtnSalvarClick()
6230:         LOCAL loc_lProsseguir, loc_oPg, loc_nValida, loc_oErro
6231: 
6232:         *-- Fora de ALTERAR nao ha o que gravar e a saida segue normalmente
6233:         IF !(UPPER(ALLTRIM(THIS.this_oBusinessObject.this_cEscolha)) == "ALTERAR")
6234:             RETURN .T.
6235:         ENDIF
6236: 
6237:         IF !MsgConfirma("Deseja salvar as altera" + CHR(231) + CHR(245) + "es?", ;
6238:                 "Altera" + CHR(231) + CHR(227) + "o de Cliente")
6239:             RETURN .T.
6240:         ENDIF
6241: 
6242:         loc_oPg = THIS.pgf_4c_Paginas.Page2
6243: 
6244:         IF !PEMSTATUS(loc_oPg, "cntConta", 5)
6245:             MsgAviso("A altera" + CHR(231) + CHR(227) + "o dos dados cadastrais " + ;
6246:                 "desta conta se faz pelo Cadastro de Clientes.", THIS.Caption)
6247:             RETURN .F.
6248:         ENDIF
6249: 
6250:         loc_lProsseguir = .T.
6251: 
6252:         TRY
6253:             *-- mValidaObj() < 1 recusa a gravacao e mantem a tela aberta
6254:             loc_nValida = loc_oPg.cntConta.mValidaObj()
6255: 
6256:             IF VARTYPE(loc_nValida) = "N" AND loc_nValida < 1
6257:                 loc_lProsseguir = .F.
6258:             ELSE
6259:                 loc_oPg.cntConta.mGravaDados()
6260:             ENDIF
6261:         CATCH TO loc_oErro
6262:             MsgErro(loc_oErro.Message + CHR(13) + ;
6263:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
6264:                 "Proc: " + loc_oErro.Procedure, ;
6265:                 "Erro ao gravar a altera" + CHR(231) + CHR(227) + "o do cliente")
6266:             loc_lProsseguir = .F.
6267:         ENDTRY
6268: 
6269:         RETURN loc_lProsseguir
6270:     ENDPROC
6271: 
6272:     *==========================================================================
6273:     * BtnCancelarClick - cmd_cancela.Click do grp_operacao legado ("[ESC] Sair",
6274:     * Cancel = .T., Click = ThisForm.Release). Com a pagina Resultado aberta o
6275:     * Cancelar ABANDONA a consulta sem passar pela gravacao (quem oferece
6276:     * gravar eh o Voltar, via BtnSalvarClick) e devolve a tela para a Consulta;
6277:     * na pagina Consulta ele encerra, como no legado.
6278:     *==========================================================================
6279:     PROCEDURE BtnCancelarClick()
6280:         IF THIS.pgf_4c_Paginas.ActivePage = 2
6281:             THIS.this_oBusinessObject.this_cEscolha = "CONSULTAR"
6282:             THIS.AlternarPagina(1)
6283:         ELSE
6284:             THIS.BtnEncerrarClick()
6285:         ENDIF
6286:     ENDPROC
6287: 
6288:     *==========================================================================
6289:     * BtnEncerrarClick - Fecha a tela devolvendo o controle ao form chamador,
6290:     * como o legado faz no ramo Automatico do cmd_voltar.Click
6291:     * (ThisForm.Release + poForm1.Enabled = .t.).
6292:     *==========================================================================
6293:     PROCEDURE BtnEncerrarClick()
6294:         IF VARTYPE(THIS.this_oFormPai) = "O" AND !THIS.this_oFormPai.Enabled
6295:             THIS.this_oFormPai.Enabled = .T.
6296:         ENDIF
6297: 
6298:         THIS.Release()
6299:     ENDPROC
6300: ENDDEFINE

