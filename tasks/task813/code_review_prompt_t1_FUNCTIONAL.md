# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (13)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_CALCULOCOL. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [GRID-WITH] Bloco WITH THIS.grd_4c_TotalProdutos define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_TotalProdutos.RecordSource).
- [GRID-WITH] Bloco WITH THIS.grd_4c_Produto define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Produto.RecordSource).
- [GRID-WITH] Bloco WITH THIS.grd_4c_ProdutoTam define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_ProdutoTam.RecordSource).
- [GRID-WITH] Bloco WITH THIS.grd_4c_Servicos define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Servicos.RecordSource).
- [GRID-WITH] Bloco WITH THIS.grd_4c_Componentes define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Componentes.RecordSource).
- [GRID-WITH] Bloco WITH THIS.grd_4c_TotalProdutos define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_TotalProdutos.RecordSource).
- [GRID-WITH] Bloco WITH THIS.grd_4c_Produto define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Produto.RecordSource).
- [GRID-WITH] Bloco WITH THIS.grd_4c_Servicos define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Servicos.RecordSource).
- [GRID-WITH] Bloco WITH THIS.grd_4c_ProdutoTam define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_ProdutoTam.RecordSource).
- [GRID-WITH] Bloco WITH THIS.grd_4c_Componentes define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Componentes.RecordSource).
- [LAYOUT-POSITION] Controle 'Label5' (parent: SIGOPTOT.Container1): Top original=3 vs migrado 'lbl_4c_Label5' Top=438 (diff=435px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label5' (parent: SIGOPTOT.Container1): Left original=4 vs migrado 'lbl_4c_Label5' Left=169 (diff=165px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpTot.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1575 linhas total):

*-- Linhas 17 a 77:
17: *
18: * Uso canonico (a ser fixado nas Fases seguintes, no form de movimento que
19: * abrir este dialogo):
20: *   loForm = CREATEOBJECT("FormSigOpTot", THISFORM, SET("Datasession"))
21: *   IF VARTYPE(loForm) = "O"
22: *       loForm.Show()
23: *   ENDIF
24: *
25: * Layout: form PLANO, SEM PageFrame - o SCX legado nao tem PageFrame algum
26: * (cntSombra + grades de totais direto na form + bloco de campos de total +
27: * CommandGroup OK). NAO segue o padrao Page1(Lista)/Page2(Dados) de CRUD, e
28: * nao ha sequer o padrao generico Lista/Dados de outros forms OPERACIONAL
29: * com grid editavel (ex.: FormFpm) - este e um dialogo de CONSULTA/
30: * totalizacao, mesma familia de FormSigOpCcj/FormSigOpAut (dialogos OPERACIONAL
31: * planos da familia SigOp). Form 1127x600, DataSession=2 (igual ao legado).
32: *
33: * Fase 3/8 - Estrutura base: propriedades visuais (PILAR 1, transcritas de
34: * tasks\task813\SigOpTot_form_codigo_fonte.txt, SECAO 2), Init() recebendo
35: * par_oParentForm/par_nDataSessionId (equivalentes a pform/datses do legado,
36: * com o mesmo Set Datasession To antes de qualquer outra coisa),
37: * InicializarForm() (cria SigOpTotBO + DefinirContexto + cabecalho) e o
38: * cabecalho (cntSombra -> cnt_4c_Cabecalho, com os valores EXATOS do dump:
39: * FontSize=18, lblSombra Top=18/ForeColor preto, lblTitulo Top=17/ForeColor
40: * branco).
41: *
42: * Fase 4/8 - Grades: SIGOPTOT NAO tem PageFrame nem botoes CRUD - o template
43: * generico de fase 4 ["Grid e Botoes CRUD (Page1)"] nao se aplica a este
44: * dialogo (nao ha Incluir/Alterar/Excluir/Buscar no SCX legado, so as 6
45: * grades de totalizacao e o botao OK/Retornar - ver cabecalho acima e
46: * meta_prompt.md). Adicionados ConfigurarGrades() (estrutura visual das 6
47: * grades + cursores placeholder, EXATOS do dump: Grade_ProdutoTam ->
48: * grd_4c_ProdutoTam, grade_total -> grd_4c_TotalProdutos, GrdTCompo ->
49: * grd_4c_Componentes, Grade_Serv -> grd_4c_Servicos, Grade_Produto ->
50: * grd_4c_Produto, Container1+GradeCol -> cnt_4c_CalculoCol+grd_4c_Col - os
51: * nomes _4c_ sao DIFERENTES do placeholder generico "grd_4c_Dados" do
52: * mapeamento.json, que colapsa as 6 grades em 1 nome so e nao serve aqui -
53: * regra PILAR 3) e CarregarLista() (chama SigOpTotBO.ProcessarTotais e
54: * rebinda cada grade ao cursor real do BO, com a mesma exclusao mutua
55: * Grade_Serv/Grade_ProdutoTam e o toggle de GrdTCompo do Init legado,
56: * linhas 1580-1591). cnt_4c_CalculoCol (Container1/GradeCol) e reproduzido
57: * so por fidelidade estrutural (PILAR 1): no legado ele e Visible=.F. e
58: * NUNCA tem RecordSource atribuido em lugar nenhum do form (nem Init nem
59: * calctotais) - fica permanentemente oculto, igual ao original.
60: * Adicionados tambem ConfigurarBotoes() (SIGOPTOT.OK -> cmg_4c_OK: o
61: * CommandGroup de um unico botao "Retornar", no canto superior direito, com
62: * os valores EXATOS do dump) e CmdRetornarClick(), que transcreve as duas
63: * acoes do btnSair.Click legado (reabilitar o form pai + Release). O metodo
64: * de carga chama-se CarregarLista() e e PUBLIC, porque o harness de teste
65: * automatizado o aciona de FORA da classe (regra CLAUDE.md #3). O bloco de
66: * campos de total (Label1-5/Get_TotQtde/Get_TotPeso/Get_TotPesoC/
67: * Get_Compensacao/Get_mtcub/lblTotPes/getTotPes) e os eventos de recalculo
68: * entram nas fases seguintes.
69: *
70: * Fase 5/8 - Campos principais (parte 1/2): adicionado ConfigurarCamposTotais()
71: * com a PRIMEIRA metade do bloco de campos de total do dump (SECAO 2 -
72: * Label1/Get_TotQtde "Total Quantidade", Label2/Get_TotPeso "Total do Peso" e
73: * os indicadores de sinal Get_QOper/Get_POper, que ficam na MESMA linha dos
74: * dois primeiros, direto na form - no legado nenhum tem ControlSource: o
75: * proprio CalcTotais() escreve o valor via .Value (fase de eventos, ainda
76: * nao migrada). Valores (Top/Left/Width/Height/Format/ToolTipText) EXATOS do
77: * dump (PILAR 1). A segunda metade (Label3/Get_TotPesoC, Label4/

*-- Linhas 85 a 391:
85: * ao dump, so aparece quando SigOpTotBO.this_lMostrarMtCub fica .T. - e
86: * lblTotPes/txt_4c_TotPes, com o rotulo dinamico "Total <DocQtd2s> :"/
87: * "Total Peso :" que o BO calcula em PrepararRotuloTotalPeso). Nao ha
88: * lookup nenhum neste form (dialogo de totalizacao, sem FormBuscaAuxiliar -
89: * ver analise.json/mapeamento.json, secao "lookups" vazia): o unico campo
90: * nao somente-leitura e txt_4c_Compensacao, ligado via BINDEVENT "LostFocus"
91: * (regra CLAUDE.md - Valid nao dispara de forma confiavel em TextBox) ao
92: * metodo PUBLIC ValidarCompensacao(), que reproduz literalmente o
93: * PROCEDURE Valid de Get_Compensacao (linhas 1767-1779 do dump): grava o
94: * valor digitado no cursor COMPARTILHADO TprMvCab.VCompensas ANTES de
95: * chamar SigOpTotBO.ValidarCompensacao() - CalcularTotais() (chamado por
96: * ValidarCompensacao) le TprMvCab.VCompensas direto do cursor, igual ao
97: * legado (onde o ControlSource 'TprMvCab.VCompensas' escreve no cursor
98: * antes do Valid rodar) - se o valor for invalido (negativo), desfaz a
99: * gravacao no cursor e repoe o TextBox com o valor anterior, com
100: * MsgAviso("Valor de Compensacao Invalido") no lugar do MessageBox cru do
101: * legado. RebindCamposTotais() (chamado ao fim de CarregarLista() e de
102: * ValidarCompensacao(), sempre depois que o BO recalculou) espelha nos
103: * controles os totais do BO (this_nTotQtde/this_cQOper/this_nTotPeso/
104: * this_cPOper/this_nTotPesoC/this_nTotPes/this_cRotuloTotalPeso/
105: * this_lMostrarMtCub/this_nMtCub) e o valor corrente de
106: * TprMvCab.VCompensas, e decide o ReadOnly de txt_4c_Compensacao pelo MESMO
107: * criterio do When legado (InList(ParentForm.Op_Escolha,'INSERIR',
108: * 'ALTERAR')) - unica forma praticavel de reproduzir When via BINDEVENT
109: * em TextBox (regra CLAUDE.md #3), e suficiente porque este dialogo e
110: * modal e Op_Escolha do form pai nao muda durante a vida dele.
111: *
112: * Fase 7/8 - Eventos principais: SIGOPTOT NAO tem Incluir/Alterar/Visualizar/
113: * Excluir no legado - comportamento.json confirma um UNICO evento de botao
114: * (SIGOPTOT.OK.Click) entre os 24 metodos do dump; os demais 22 (Text1.When
115: * das 6 grades + Get_Compensacao.When) so retornam .F./InList(...) e nao
116: * abrem Click/DblClick nenhum. O "evento principal" deste dialogo e o botao
117: * de retorno ao form pai, cujo handler (CmdRetornarClick, transcrito do
118: * btnSair.Click legado) e o BINDEVENT que o liga ja foram escritos na
119: * Fase 4/8, junto com ConfigurarBotoes() - nao ha codigo novo para esta fase
120: * alem desta nota. O unico outro evento interativo do dialogo, o Valid do
121: * campo editavel (Get_Compensacao), tambem ja foi migrado (ValidarCompensacao,
122: * Fase 6/8).
123: *
124: * Metodos CRUD-canonicos (BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/
125: * BtnExcluirClick) NAO se aplicam: o legado nao tem Page1(Lista)/Page2(Dados)
126: * nem modos INCLUIR/ALTERAR/VISUALIZAR/EXCLUIR (analise.json: campos/lookups
127: * vazios; layout.json sem BaseClass PageFrame/Grid fora das 6 grades de
128: * totalizacao), e inventa-los criaria estrutura que o legado nao tem (viola
129: * PILAR 1) ou stub vazio sem logica real (reprovado pela regra de
130: * completude) - mesma analise de FormSigOpCcj.prg/FormSigOpAlC.prg, familia
131: * SigOp. Este e um dialogo de CONSULTA/totalizacao (ver nota no topo do
132: * arquivo); nao ha FormParaBO/BOParaForm no sentido CRUD porque nao ha uma
133: * unica entidade editavel - o campo editavel grava direto no cursor
134: * compartilhado do form pai (ValidarCompensacaoExec) e os totais sao so
135: * exibidos (RebindCamposTotais), nunca gravados pelo usuario.
136: *
137: * Fase 8/8 - Consolidacao final: pela mesma analise das Fases 7-8 acima,
138: * nenhum dos metodos genericos de fechamento do template CRUD se aplica a
139: * este dialogo - cada um foi conferido individualmente contra o dump e
140: * contra comportamento.json (24 metodos, nenhum deles Buscar/Salvar/
141: * Cancelar/Encerrar):
142: *   - BtnBuscarClick/BtnSalvarClick/BtnCancelarClick: nao existem no
143: *     legado (sem Page1/Page2, sem modo INCLUIR/ALTERAR com commit
144: *     proprio) e inventa-los duplicaria Inserir()/ExecutarExclusao(), que
145: *     sao passos INTERNOS de ProcessarComponentes() (area de troca
146: *     SigTempD), nunca acoes que o usuario aciona por um botao.
147: *   - BtnEncerrarClick: e o CmdRetornarClick ja existente (Fase 4/8) - o
148: *     unico botao do dialogo (SIGOPTOT.OK/"Retornar") e a saida.
149: *   - HabilitarCampos/LimparCampos: nao ha alternancia de modo
150: *     INCLUIR/ALTERAR/VISUALIZAR dentro deste dialogo (ele e aberto pelo
151: *     form pai ja no modo que interessa) - o unico campo editavel
152: *     (txt_4c_Compensacao) tem o ReadOnly dele recalculado a cada carga
153: *     por RebindCamposTotais(), que e o equivalente funcional e ja
154: *     existe desde a Fase 6/8; LimparCampos nao se aplica porque nao ha
155: *     o que "limpar" para o proximo registro - o dialogo e encerrado
156: *     (Release) e reaberto do zero pelo form pai a cada totalizacao.
157: *   - AjustarBotoesPorModo: nao ha botoes CRUD cuja Enabled dependa do
158: *     modo - o unico CommandGroup (cmg_4c_OK) fica sempre habilitado.
159: *   - CarregarLista: implementado desde a Fase 4/8 (nome PUBLIC, regra
160: *     CLAUDE.md #3 - acionado pelo harness de teste automatizado) e e
161: *     quem orquestra SigOpTotBO.ProcessarTotais() + o rebind das 6
162: *     grades + RebindCamposTotais(); nada a acrescentar aqui.
163: *   - Integracao em menu.prg/config.prg: NAO se aplica. Este dialogo
164: *     nunca e aberto pelo usuario a partir de um popup do menu - no
165: *     legado e sempre CREATEOBJECT("SIGOPTOT", pform, datses) + Show(1)
166: *     disparado por um form de MOVIMENTO (TprMvCab), nunca por item de
167: *     menu (ver "Uso canonico" no topo deste arquivo). Adicionar um
168: *     DEFINE BAR/ON SELECTION BAR para abrir este dialogo isolado, sem
169: *     o form pai que fornece os cursores crSigCdOpe/TprMvCab/crTpmMvItn,
170: *     inventaria uma funcionalidade que o sistema legado nao tem (viola
171: *     PILAR 1) e abriria uma tela sem dados para somar. A integracao
172: *     real (o form de movimento chamando CREATEOBJECT("FormSigOpTot",
173: *     THISFORM, SET("Datasession")) + Show()) e responsabilidade da
174: *     migracao DAQUELE form de movimento, nao desta task. Pela mesma
175: *     razao, config.prg nao precisa de nenhum SET PROCEDURE novo: a
176: *     carga sob demanda (CLAUDE.md, secao "config.prg - Carga SOB
177: *     DEMANDA") ja resolve SigOpTotBO.prg/FormSigOpTot.prg pelo indice
178: *     de classes no momento em que o form pai fizer
179: *     CREATEOBJECT("FormSigOpTot", ...) - CREATEOBJECT literal dentro de
180: *     outro Form/BO nao exige edicao em config.prg.
181: *
182: * CONFERENCIA DE COMPLETUDE (comportamento.json, 24 metodos do dump):
183: * Init -> InicializarForm/ProcessarTotais; Procedure(calctotais) ->
184: * CalcularTotais+RebindCamposTotais; Destroy -> Destroy(); as 6
185: * Text1.When das grades -> colunas ReadOnly=.T. desde ConfigurarGrades
186: * (Fase 4/8), nenhuma celula e editavel, When=.F. e portanto implicito;
187: * Get_Compensacao.When -> RebindCamposTotais (ReadOnly por modo,
188: * Fase 6/8); Get_Compensacao.Valid -> ValidarCompensacao (Fase 6/8);
189: * OK.Click -> CmdRetornarClick (Fase 4/8). Nenhum metodo do dump ficou
190: * sem equivalente, e nenhum metodo deste form e estrutura vazia/stub -
191: * FormSigOpTot.prg e SigOpTotBO.prg estao completos.
192: *==============================================================================
193: 
194: DEFINE CLASS FormSigOpTot AS FormBase
195: 
196:     *-- Propriedades visuais (PILAR 1: identico ao legado SIGOPTOT.SCX)
197:     Width        = 1127
198:     Height       = 600
199:     AutoCenter   = .T.
200:     Caption      = "Total Itens"
201:     ShowWindow   = 1
202:     WindowType   = 1
203:     ControlBox   = .F.
204:     MaxButton    = .F.
205:     Movable      = .T.
206:     TitleBar     = 0
207:     BorderStyle  = 2
208:     ShowTips     = .T.
209:     DataSession  = 2
210:     AlwaysOnTop  = .T.
211: 
212:     *-- Referencia ao form que abriu este dialogo (legado "ThisForm.ParentForm").
213:     *-- Usado por CmdRetornarClick() para reabilitar o form de origem
214:     *-- antes de encerrar este dialogo.
215:     this_oParentForm = .NULL.
216: 
217:     *-- DataSessionId do formulario de origem (legado "datses"), guardado so
218:     *-- para repassar ao Business Object via DefinirContexto - a troca de
219:     *-- sessao em si acontece uma unica vez, no Init.
220:     this_nDataSessionId = 0
221: 
222:     *-- Guarda de reentrancia de ValidarCompensacao(): o handler esta ligado
223:     *-- a "LostFocus" e exibe MsgAviso, que e modal - ao devolver o foco o
224:     *-- proprio LostFocus redispara e empilharia uma segunda validacao
225:     *-- (regra CLAUDE.md #47). Liberada pelo WRAPPER, nunca pelo corpo, para
226:     *-- que os RETURN antecipados do corpo nao deixem a flag travada em .T.
227:     this_lEmValidacaoCompensacao = .F.
228: 
229:     *--------------------------------------------------------------------------
230:     * Init - Recebe os mesmos parametros do Init legado (pform, datses).
231:     * Reproduz a MESMA ordem do legado: guarda a referencia ao form pai,
232:     * troca para a DataSession do form pai (Set Datasession To DatSes) ANTES
233:     * de qualquer outra coisa, e so entao aciona DODEFAULT() (que dispara
234:     *
235:     * Em modo de teste automatizado (TestFormWrapper/ValidarUIFidelity) este
236:     * form e instanciado sem form pai nem DataSessionId validos, so para
237:     * validar a estrutura visual - sem a troca de sessao, THIS.InicializarForm
238:     * ainda monta o cabecalho normalmente (as fases seguintes, que leem
239:     * cursores do pai, precisarao continuar respeitando gb_4c_ModoTeste).
240:     *--------------------------------------------------------------------------
241:     PROCEDURE Init(par_oParentForm, par_nDataSessionId)
242:         LOCAL loc_lSucesso
243:         loc_lSucesso = .F.
244: 
245:         THIS.this_oParentForm    = IIF(VARTYPE(par_oParentForm) = "O", par_oParentForm, .NULL.)
246:         THIS.this_nDataSessionId = IIF(VARTYPE(par_nDataSessionId) = "N", par_nDataSessionId, 0)
247: 
248:         IF THIS.this_nDataSessionId > 0
249:             SET DATASESSION TO (THIS.this_nDataSessionId)
250:         ENDIF
251: 
252:         loc_lSucesso = DODEFAULT()
253: 
254:         RETURN loc_lSucesso
255:     ENDPROC
256: 
257:     *--------------------------------------------------------------------------
258:     * InicializarForm - Cria o Business Object, repassa o contexto do form
259:     * pai (DefinirContexto) e monta a tela: cabecalho, as 6 grades de
260:     * totalizacao, o CommandGroup de retorno e a carga dos totais
261:     * (CarregarLista -> SigOpTotBO.ProcessarTotais), o bloco COMPLETO de
262:     * campos de total (ConfigurarCamposTotais) e o evento de recalculo do
263:     * unico campo editavel (ValidarCompensacao, ligado por BINDEVENT).
264:     *--------------------------------------------------------------------------
265:     PROTECTED PROCEDURE InicializarForm()
266:         LOCAL loc_lSucesso, loc_oErro
267:         loc_lSucesso = .F.
268: 
269:         TRY
270:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpTotBO")
271: 
272:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
273:                 THIS.this_oBusinessObject.DefinirContexto(THIS.this_oParentForm, THIS.this_nDataSessionId)
274: 
275:                 THIS.ConfigurarPageFrame()
276:                 THIS.ConfigurarCabecalho()
277: 
278:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
279:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
280: 
281:                 THIS.ConfigurarGrades()
282: 
283:                 *-- ConfigurarBotoes() vem DEPOIS de ConfigurarCabecalho(): o
284:                 *-- CommandGroup fica em Top=-2, dentro da area da faixa do
285:                 *-- cabecalho (Top=0..80), e so desenha POR CIMA dela se for
286:                 *-- adicionado depois (regra CLAUDE.md #11).
287:                 THIS.ConfigurarBotoes()
288: 
289:                 *-- Bloco COMPLETO de campos de total (as duas metades do
290:                 *-- bloco do dump), mais o BINDEVENT de txt_4c_Compensacao.
291:                 THIS.ConfigurarCamposTotais()
292: 
293:                 THIS.TornarControlesVisiveis(THIS)
294: 
295:                 *-- CarregarLista() roda DEPOIS do TornarControlesVisiveis -
296:                 *-- ele mesmo decide a visibilidade final de
297:                 *-- grd_4c_Servicos/grd_4c_ProdutoTam/grd_4c_Componentes
298:                 *-- (exclusao mutua do Init legado), e nao pode ser
299:                 *-- sobrescrito pelo pass genereico de visibilidade.
300:                 THIS.CarregarLista()
301: 
302:                 loc_lSucesso = .T.
303:             ELSE
304:                 MsgErro("Erro ao criar Business Object de Total de Itens." + CHR(13) + ;
305:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
306:             ENDIF
307:         CATCH TO loc_oErro
308:             MsgErro(loc_oErro.Message + CHR(13) + ;
309:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
310:                 "Procedure: " + loc_oErro.Procedure, "Erro ao inicializar FormSigOpTot")
311:         ENDTRY
312: 
313:         RETURN loc_lSucesso
314:     ENDPROC
315: 
316:     *--------------------------------------------------------------------------
317:     * ConfigurarPageFrame - SIGOPTOT legado NAO TEM PageFrame: layout PLANO
318:     * com fundo new_background.jpg (Picture do dump), igual ao padrao de
319:     * dialogos OPERACIONAL planos da familia SigOp (ver FormSigOpCcj.prg).
320:     * Mantido so para configurar a aparencia base do form - nao cria pagina
321:     * alguma. FontName/FontSize aqui sao o DEFAULT do form (Tahoma 8); as
322:     * grades usam Verdana 8, conforme o dump de cada Grid.
323:     *--------------------------------------------------------------------------
324:     PROTECTED PROCEDURE ConfigurarPageFrame()
325:         THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
326:         THIS.SetAll("FontName", "Tahoma")
327:         THIS.SetAll("FontSize", 8)
328:     ENDPROC
329: 
330:     *--------------------------------------------------------------------------
331:     * ConfigurarCabecalho - Container header cinza (cntSombra do legado).
332:     * Valores EXATOS do dump (PILAR 1): Top=0, Left=0, Height=80,
333:     * BackColor=100,100,100, BorderWidth=0 (Width = THIS.Width, nao o 1136
334:     * literal do SCX - regra CLAUDE.md #11: a largura segue o form, nunca um
335:     * literal maior/menor). lblSombra (Top=18, Height=40, ForeColor preto) e
336:     * lblTitulo (Top=17, Height=46, ForeColor branco) com FontSize=18 (o
337:     * legado declara 18 para este form, nao o generico 16 de outros
338:     * cabecalhos) - efeito de sombra: o titulo branco fica 1px acima e 6px
339:     * mais alto que a sombra preta por baixo.
340:     *--------------------------------------------------------------------------
341:     PROTECTED PROCEDURE ConfigurarCabecalho()
342:         LOCAL loc_oErro
343:         TRY
344:             THIS.AddObject("cnt_4c_Cabecalho", "Container")
345:             WITH THIS.cnt_4c_Cabecalho
346:                 .Top         = 0
347:                 .Left        = 0
348:                 .Width       = THIS.Width
349:                 .Height      = 80
350:                 .BackStyle   = 1
351:                 .BackColor   = RGB(100, 100, 100)
352:                 .BorderWidth = 0
353:                 .Visible     = .T.
354:             ENDWITH
355: 
356:             THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
357:             WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
358:                 .FontBold      = .T.
359:                 .FontName      = "Tahoma"
360:                 .FontSize      = 18
361:                 .FontUnderline = .F.
362:                 .WordWrap      = .T.
363:                 .Alignment     = 0
364:                 .BackStyle     = 0
365:                 .AutoSize      = .F.
366:                 .Caption       = THIS.Caption
367:                 .Height        = 40
368:                 .Left          = 10
369:                 .Top           = 18
370:                 .Width         = THIS.Width - 21
371:                 .ForeColor     = RGB(0, 0, 0)
372:                 .Visible       = .T.
373:             ENDWITH
374: 
375:             THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
376:             WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
377:                 .FontBold      = .T.
378:                 .FontName      = "Tahoma"
379:                 .FontSize      = 18
380:                 .WordWrap      = .T.
381:                 .Alignment     = 0
382:                 .BackStyle     = 0
383:                 .AutoSize      = .F.
384:                 .Caption       = THIS.Caption
385:                 .Height        = 46
386:                 .Left          = 10
387:                 .Top           = 17
388:                 .Width         = THIS.Width - 21
389:                 .ForeColor     = RGB(255, 255, 255)
390:                 .Visible       = .T.
391:             ENDWITH

*-- Linhas 404 a 470:
404:     * reconfigura ControlSource/Header/Width depois que o BO
405:     * processa os totais de verdade (regra "Grid RecordSource reseta
406:     * Header/Width" - FORMCOR_LICOES_APRENDIDAS Problema 2/48).
407:     *
408:     * Visibilidade inicial (igual ao legado antes de qualquer calculo):
409:     * grd_4c_TotalProdutos/grd_4c_Produto/grd_4c_ProdutoTam = .T.;
410:     * grd_4c_Servicos/grd_4c_Componentes/cnt_4c_CalculoCol = .F. (ligados
411:     * depois, so quando this_lTemServicos/this_lTemComponentes forem .T. -
412:     * cnt_4c_CalculoCol fica SEMPRE .F., ver cabecalho do arquivo).
413:     *--------------------------------------------------------------------------
414:     PROTECTED PROCEDURE ConfigurarGrades()
415:         LOCAL loc_oBO, loc_oErro
416:         loc_oBO = THIS.this_oBusinessObject
417: 
418:         TRY
419:             *-- Cursores placeholder - mesma estrutura dos cursores reais
420:             *-- que o BO cria (xValIte/xValServ com INDEX ON Moeda, igual a
421:             *-- CalcularTotais/MontarGradeServicos; ProEesti/ProTam/csCompo
422:             *-- sem indice, igual a MontarGradeProdutos/MontarGradeProdutoTam/
423:             *-- ProcessarComponentes).
424:             IF !USED(loc_oBO.this_cCursorValIte)
425:                 SET NULL ON
426:                 CREATE CURSOR (loc_oBO.this_cCursorValIte) (Moeda C(3), Total N(15,2))
427:                 SET NULL OFF
428:                 INDEX ON Moeda TAG Moeda
429:             ENDIF
430:             IF !USED(loc_oBO.this_cCursorValServ)
431:                 SET NULL ON
432:                 CREATE CURSOR (loc_oBO.this_cCursorValServ) (Moeda C(3), Total N(15,2))
433:                 SET NULL OFF
434:                 INDEX ON Moeda TAG Moeda
435:             ENDIF
436:             IF !USED(loc_oBO.this_cCursorProEesti)
437:                 SET NULL ON
438:                 CREATE CURSOR (loc_oBO.this_cCursorProEesti) (Cpros C(14), Qtds N(11,3))
439:                 SET NULL OFF
440:             ENDIF
441:             IF !USED(loc_oBO.this_cCursorProTam)
442:                 SET NULL ON
443:                 CREATE CURSOR (loc_oBO.this_cCursorProTam) (Cpros C(20), Qtds N(11,3))
444:                 SET NULL OFF
445:             ENDIF
446:             IF !USED(loc_oBO.this_cCursorCompo)
447:                 SET NULL ON
448:                 CREATE CURSOR (loc_oBO.this_cCursorCompo) (Codigos C(14), Qtds N(11,3), UniCompos C(3), QtsCons N(11,3))
449:                 SET NULL OFF
450:             ENDIF
451: 
452:             *-- grd_4c_TotalProdutos (legado: grade_total) - Total por moeda
453:             *-- dos PRODUTOS. Sempre visivel.
454:             THIS.AddObject("grd_4c_TotalProdutos", "Grid")
455:             WITH THIS.grd_4c_TotalProdutos
456:                 .Top          = 84
457:                 .Left         = 5
458:                 .Height       = 322
459:                 .FontName     = "Verdana"
460:                 .FontSize     = 8
461:                 .DeleteMark   = .F.
462:                 .RecordMark   = .F.
463:                 .ReadOnly     = .T.
464:                 .RowHeight    = 16
465:                 .ScrollBars   = 2
466:                 .GridLineColor = RGB(238, 238, 238)
467:                 .ColumnCount  = 2
468:                 .RecordSource = loc_oBO.this_cCursorValIte
469:                 .Column1.ControlSource = loc_oBO.this_cCursorValIte + ".Moeda"
470:                 .Column1.Movable  = .F.

*-- Linhas 495 a 518:
495:                 .Column2.Width = 135
496:                 .Width    = 208
497:                 .Visible  = .T.
498:             ENDWITH
499: 
500:             *-- grd_4c_Produto (legado: Grade_Produto) - Total por PRODUTO
501:             *-- (Cpros), sem agrupar por tamanho. Sempre visivel.
502:             THIS.AddObject("grd_4c_Produto", "Grid")
503:             WITH THIS.grd_4c_Produto
504:                 .Top          = 84
505:                 .Left         = 446
506:                 .Height       = 322
507:                 .FontName     = "Verdana"
508:                 .FontSize     = 8
509:                 .DeleteMark   = .F.
510:                 .RecordMark   = .F.
511:                 .ReadOnly     = .T.
512:                 .RowHeight    = 16
513:                 .ScrollBars   = 2
514:                 .GridLineColor = RGB(238, 238, 238)
515:                 .ColumnCount  = 2
516:                 .RecordSource = loc_oBO.this_cCursorProEesti
517:                 .Column1.ControlSource = loc_oBO.this_cCursorProEesti + ".Cpros"
518:                 .Column1.Movable  = .F.

*-- Linhas 543 a 570:
543:                 .Column2.Width = 80
544:                 .Width    = 237
545:                 .Visible  = .T.
546:             ENDWITH
547: 
548:             *-- grd_4c_ProdutoTam (legado: Grade_ProdutoTam) - Total por
549:             *-- PRODUTO+TAMANHO (comentario original "Mena - 20/10/2017").
550:             *-- Ocupa a MESMA posicao de grd_4c_Servicos - as duas sao
551:             *-- mutuamente exclusivas (CarregarLista decide qual aparece,
552:             *-- igual ao Init legado linhas 1580-1587). Visivel por
553:             *-- DEFAULT (so fica oculta se houver servicos).
554:             THIS.AddObject("grd_4c_ProdutoTam", "Grid")
555:             WITH THIS.grd_4c_ProdutoTam
556:                 .Top          = 84
557:                 .Left         = 216
558:                 .Height       = 322
559:                 .FontName     = "Verdana"
560:                 .FontSize     = 8
561:                 .DeleteMark   = .F.
562:                 .RecordMark   = .F.
563:                 .ReadOnly     = .T.
564:                 .RowHeight    = 16
565:                 .ScrollBars   = 2
566:                 .GridLineColor = RGB(238, 238, 238)
567:                 .ColumnCount  = 2
568:                 .RecordSource = loc_oBO.this_cCursorProTam
569:                 .Column1.ControlSource = loc_oBO.this_cCursorProTam + ".Cpros"
570:                 .Column1.Movable  = .F.

*-- Linhas 595 a 620:
595:                 .Column2.Width = 45
596:                 .Width    = 227
597:                 .Visible  = .T.
598:             ENDWITH
599: 
600:             *-- grd_4c_Servicos (legado: Grade_Serv) - Total por moeda dos
601:             *-- SERVICOS. So aparece quando crSigCdOpe.HabServs = 1 - nasce
602:             *-- oculta (CarregarLista decide, exclusao mutua com
603:             *-- grd_4c_ProdutoTam, que fica na MESMA posicao).
604:             THIS.AddObject("grd_4c_Servicos", "Grid")
605:             WITH THIS.grd_4c_Servicos
606:                 .Top          = 84
607:                 .Left         = 226
608:                 .Height       = 322
609:                 .FontName     = "Verdana"
610:                 .FontSize     = 8
611:                 .DeleteMark   = .F.
612:                 .RecordMark   = .F.
613:                 .ReadOnly     = .T.
614:                 .RowHeight    = 16
615:                 .ScrollBars   = 2
616:                 .GridLineColor = RGB(238, 238, 238)
617:                 .ColumnCount  = 2
618:                 .RecordSource = loc_oBO.this_cCursorValServ
619:                 .Column1.ControlSource = loc_oBO.this_cCursorValServ + ".Moeda"
620:                 .Column1.Movable  = .F.

*-- Linhas 645 a 669:
645:                 .Column2.Width = 135
646:                 .Width    = 208
647:                 .Visible  = .F.
648:             ENDWITH
649: 
650:             *-- grd_4c_Componentes (legado: GrdTCompo) - materia-prima
651:             *-- consumida, so quando crSigCdOpe.TotCompos = 1 E ha linhas em
652:             *-- csCompo. Nasce oculta (CarregarLista decide).
653:             THIS.AddObject("grd_4c_Componentes", "Grid")
654:             WITH THIS.grd_4c_Componentes
655:                 .Top          = 84
656:                 .Left         = 686
657:                 .Height       = 322
658:                 .FontName     = "Verdana"
659:                 .FontSize     = 8
660:                 .DeleteMark   = .F.
661:                 .RecordMark   = .F.
662:                 .ReadOnly     = .T.
663:                 .RowHeight    = 16
664:                 .ScrollBars   = 2
665:                 .GridLineColor = RGB(238, 238, 238)
666:                 .ColumnCount  = 4
667:                 .RecordSource = loc_oBO.this_cCursorCompo
668:                 .Column1.ControlSource = loc_oBO.this_cCursorCompo + ".Codigos"
669:                 .Column1.Movable  = .F.

*-- Linhas 852 a 975:
852:     * classe commandgroup e cai no prefixo generico obj_4c_) - mapeamento.json
853:     * corrigido junto, no mesmo passo desta fase.
854:     *--------------------------------------------------------------------------
855:     PROTECTED PROCEDURE ConfigurarBotoes()
856:         LOCAL loc_oErro
857: 
858:         TRY
859:             THIS.AddObject("cmg_4c_OK", "CommandGroup")
860:             WITH THIS.cmg_4c_OK
861:                 .ButtonCount = 1
862: 
863:                 WITH .Buttons(1)
864:                     .Top           = 5
865:                     .Left          = 5
866:                     .Width         = 75
867:                     .Height        = 75
868:                     .Caption       = "Retornar"
869:                     .FontName      = "Comic Sans MS"
870:                     .FontSize      = 8
871:                     .FontBold      = .T.
872:                     .FontItalic    = .T.
873:                     .WordWrap      = .T.
874:                     .Picture       = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
875:                     .Cancel        = .T.
876:                     .MousePointer  = 15
877:                     .SpecialEffect = 0
878:                     .ForeColor     = RGB(90, 90, 90)
879:                     .BackColor     = RGB(255, 255, 255)
880:                     .Themes        = .F.
881:                     .ToolTipText   = "[Esc] Voltar Para a Tela Principal da Opera" + ;
882:                         CHR(231) + CHR(227) + "o"
883:                 ENDWITH
884: 
885:                 .AutoSize      = .T.
886:                 .Top           = -2
887:                 .Left          = 1045
888:                 .Width         = 85
889:                 .Height        = 85
890:                 .BackStyle     = 0
891:                 .BorderStyle   = 0
892:                 .SpecialEffect = 1
893:                 .Themes        = .F.
894:                 .Value         = 0
895:                 .TabIndex      = 1
896:                 .Visible       = .T.
897:             ENDWITH
898: 
899:             BINDEVENT(THIS.cmg_4c_OK.Buttons(1), "Click", THIS, "CmdRetornarClick")
900:         CATCH TO loc_oErro
901:             MsgErro(loc_oErro.Message + CHR(13) + ;
902:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro ao configurar bot" + ;
903:                 CHR(245) + "es")
904:         ENDTRY
905:     ENDPROC
906: 
907:     *--------------------------------------------------------------------------
908:     * ConfigurarCamposTotais - Bloco de campos de total, direto na form
909:     * (sem container - igual ao legado). Bloco COMPLETO, na ordem do dump:
910:     * os dois totais principais (Label1/Get_TotQtde, Label2/Get_TotPeso) com
911:     * os indicadores de sinal na mesma linha de cada um (Get_QOper ao lado de
912:     * Get_TotQtde, Get_POper ao lado de Get_TotPeso), mais Label3/Get_TotPesoC
913:     * (Peso C), Label4/Get_Compensacao (o UNICO campo editavel),
914:     * Label5/Get_mtcub (Metro Cubico, nasce Visible=.F. igual ao dump) e
915:     * lblTotPes/getTotPes (Total do Peso, com a legenda dinamica que o BO
916:     * monta em PrepararRotuloTotalPeso).
917:     *
918:     * Nenhum destes campos tem ControlSource no legado - CalcTotais()
919:     * escreve o valor calculado direto em .Value (.get_TotQtde.Value =
920:     * Abs(lnTotQtde), .Get_QOper.Value = Iif(...,'E','S')); por isso aqui so
921:     * se cria a estrutura visual com valor inicial neutro (0 para os
922:     * numericos, "" para os indicadores de sinal) - a logica de calculo
923:     * (CalcTotais) e os eventos que a disparam entram nas fases de eventos,
924:     * ainda nao migradas (ver cabecalho do arquivo).
925:     *
926:     * Formato de exibicao (regra CLAUDE.md #49): o dump declara estes campos
927:     * com ".Format = "999,999.999""/".Format = "999,999.99"" (nao
928:     * ".InputMask"), mas .Format em TextBox VFP9 so aceita codigos de letra
929:     * (K/!/T) - padrao de digito so tem efeito como .InputMask (e e assim
930:     * que o proprio dump trata o campo gemeo Get_mtcub, que usa
931:     * ".InputMask = "999,999.999""). Transcrito como .InputMask para
932:     * preservar o EFEITO visual (separador de milhar + decimais), que e o
933:     * que a fidelidade de UX (PILAR 1) exige.
934:     *--------------------------------------------------------------------------
935:     PROTECTED PROCEDURE ConfigurarCamposTotais()
936:         LOCAL loc_oErro
937: 
938:         TRY
939:             THIS.AddObject("lbl_4c_Label1", "Label")
940:             WITH THIS.lbl_4c_Label1
941:                 .FontBold  = .T.
942:                 .FontName  = "Tahoma"
943:                 .FontSize  = 8
944:                 .BackStyle = 0
945:                 .Alignment = 0
946:                 .Caption   = "Total Quantidade :"
947:                 .Height    = 15
948:                 .Left      = 163
949:                 .Top       = 463
950:                 .Width     = 105
951:                 .ForeColor = RGB(90, 90, 90)
952:                 .Visible   = .T.
953:             ENDWITH
954: 
955:             THIS.AddObject("txt_4c_TotQtde", "TextBox")
956:             WITH THIS.txt_4c_TotQtde
957:                 .FontName          = "Courier New"
958:                 .FontSize          = 8
959:                 .Format            = "999,999.999"
960:                 .Height            = 23
961:                 .Left              = 275
962:                 .Top               = 459
963:                 .Width             = 88
964:                 .ReadOnly          = .T.
965:                 .DisabledBackColor = RGB(255, 255, 255)
966:                 .ToolTipText       = "Total em Quantidade"
967:                 .Value             = 0
968:                 .Visible           = .T.
969:             ENDWITH
970: 
971:             THIS.AddObject("lbl_4c_Label2", "Label")
972:             WITH THIS.lbl_4c_Label2
973:                 .FontBold  = .T.
974:                 .FontName  = "Tahoma"
975:                 .FontSize  = 8

*-- Linhas 1070 a 1113:
1070:                 .Value             = 0
1071:                 .Visible           = .T.
1072:             ENDWITH
1073:             BINDEVENT(THIS.txt_4c_Compensacao, "LostFocus", THIS, "ValidarCompensacao")
1074: 
1075:             *-- Label3/txt_4c_TotPesoC ("Total do Peso C :") - resultado de
1076:             *-- CalcularTotais (this_nTotPesoC), somente leitura.
1077:             THIS.AddObject("lbl_4c_Label3", "Label")
1078:             WITH THIS.lbl_4c_Label3
1079:                 .FontBold  = .T.
1080:                 .FontName  = "Tahoma"
1081:                 .FontSize  = 8
1082:                 .BackStyle = 0
1083:                 .AutoSize  = .F.
1084:                 .Alignment = 0
1085:                 .Caption   = "Total do Peso C :"
1086:                 .Height    = 15
1087:                 .Left      = 174
1088:                 .Top       = 538
1089:                 .Width     = 94
1090:                 .ForeColor = RGB(90, 90, 90)
1091:                 .Visible   = .T.
1092:             ENDWITH
1093: 
1094:             THIS.AddObject("txt_4c_TotPesoC", "TextBox")
1095:             WITH THIS.txt_4c_TotPesoC
1096:                 .FontName          = "Courier New"
1097:                 .FontSize          = 8
1098:                 .Format            = "999,999.99"
1099:                 .Height            = 23
1100:                 .Left              = 275
1101:                 .Top               = 534
1102:                 .Width             = 88
1103:                 .ReadOnly          = .T.
1104:                 .DisabledBackColor = RGB(255, 255, 255)
1105:                 .ToolTipText       = "Total do Peso em Compensa" + CHR(231) + CHR(227) + "o"
1106:                 .Value             = 0
1107:                 .Visible           = .T.
1108:             ENDWITH
1109: 
1110:             *-- lblTotPes/txt_4c_TotPes ("Total do Peso :", bottom - rotulo
1111:             *-- dinamico via SigOpTotBO.this_cRotuloTotalPeso). Dump declara
1112:             *-- AutoSize=.F. + Alignment=1 (right-align LEGITIMO - regra
1113:             *-- CLAUDE.md #23, os dois estao presentes no dump).

*-- Linhas 1148 a 1377:
1148:             *-- Visible=.F. - so aparecem quando SigOpTotBO.this_lMostrarMtCub
1149:             *-- fica .T. (CrSigOpCdd.MtCubs <> 0), decidido por
1150:             *-- RebindCamposTotais() ao fim de CarregarLista(). Por isso NAO
1151:             *-- entram na lista de exclusao do TornarControlesVisiveis (regra
1152:             *-- "containers flutuantes") - aqui o .F. inicial e o estado
1153:             *-- normal, igual ao legado, e quem liga e este mesmo metodo.
1154:             THIS.AddObject("lbl_4c_Label5", "Label")
1155:             WITH THIS.lbl_4c_Label5
1156:                 .FontBold  = .T.
1157:                 .FontName  = "Tahoma"
1158:                 .FontSize  = 8
1159:                 .BackStyle = 0
1160:                 .AutoSize  = .F.
1161:                 .Alignment = 0
1162:                 .Caption   = "TT Metro C" + CHR(250) + "bico :"
1163:                 .Height    = 15
1164:                 .Left      = 169
1165:                 .Top       = 438
1166:                 .Width     = 99
1167:                 .ForeColor = RGB(90, 90, 90)
1168:                 .Visible   = .F.
1169:             ENDWITH
1170: 
1171:             THIS.AddObject("txt_4c_Mtcub", "TextBox")
1172:             WITH THIS.txt_4c_Mtcub
1173:                 .FontBold          = .T.
1174:                 .FontName          = "Courier New"
1175:                 .FontSize          = 8
1176:                 .InputMask         = "999,999.999"
1177:                 .Height            = 23
1178:                 .Left              = 275
1179:                 .Top               = 434
1180:                 .Width             = 88
1181:                 .ReadOnly          = .T.
1182:                 .DisabledBackColor = RGB(255, 255, 255)
1183:                 .ToolTipText       = "Total em Metros C" + CHR(250) + "bicos"
1184:                 .Value             = 0
1185:                 .Visible           = .F.
1186:             ENDWITH
1187:         CATCH TO loc_oErro
1188:             MsgErro(loc_oErro.Message + CHR(13) + ;
1189:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro ao configurar campos de totais")
1190:         ENDTRY
1191:     ENDPROC
1192: 
1193:     *--------------------------------------------------------------------------
1194:     * ValidarCompensacao - Transcricao do PROCEDURE Valid de Get_Compensacao
1195:     * (dump, linhas 1767-1779):
1196:     *   If (This.Value < 0)
1197:     *       =MessageBox('Valor de Compensacao Invalido', 48, 'Atencao!!!')
1198:     *       This.Value = This.AntValue
1199:     *       Return 0
1200:     *   Else
1201:     *       This.Refresh
1202:     *       Thisform.CalcTotais()
1203:     *   EndIf
1204:     *
1205:     * Validar<Campo> e o nome canonico do projeto para o handler que
1206:     * reproduz o Valid de um campo digitavel. Get_Compensacao e o UNICO
1207:     * campo digitavel do dump (o When dele devolve
1208:     * InList(ThisForm.ParentForm.Op_Escolha,'INSERIR','ALTERAR'), enquanto os
1209:     * outros 21 devolvem .F.) e o UNICO com PROCEDURE Valid.
1210:     *
1211:     * O ControlSource do legado ('TprMvCab.VCompensas') escreve o valor
1212:     * digitado no cursor ANTES do Valid rodar - e por isso que CalcTotais()
1213:     * (que le TprMvCab.VCompensas direto do cursor, nunca de uma copia)
1214:     * ja calcula com o valor novo. Aqui a mesma ordem e reproduzida
1215:     * explicitamente: grava no cursor PRIMEIRO, so depois chama
1216:     * SigOpTotBO.ValidarCompensacao() (que valida e aciona CalcularTotais).
1217:     * Falhando (valor negativo), desfaz a gravacao no cursor e repoe o
1218:     * TextBox - o rollback "This.Value = This.AntValue" do legado.
1219:     *
1220:     * Wrapper fino + ValidarCompensacaoExec(): o corpo tem RETURN antecipado
1221:     * (guardas de modo de teste e de cursor) e exibe MsgAviso, que e modal e
1222:     * devolve o foco ao sair, redisparando o proprio LostFocus. Com set no
1223:     * topo e clear no fim do CORPO, o primeiro RETURN antecipado deixaria a
1224:     * flag travada em .T. e MATARIA a validacao pelo resto da vida do form
1225:     * (regra CLAUDE.md #47).
1226:     *
1227:     * Metodo PUBLIC (sem PROTECTED): acionado por BINDEVENT, que falha em
1228:     * silencio quando o handler e protegido (regra CLAUDE.md #3).
1229:     *--------------------------------------------------------------------------
1230:     PROCEDURE ValidarCompensacao()
1231:         IF THIS.this_lEmValidacaoCompensacao
1232:             RETURN
1233:         ENDIF
1234: 
1235:         THIS.this_lEmValidacaoCompensacao = .T.
1236:         THIS.ValidarCompensacaoExec()
1237:         THIS.this_lEmValidacaoCompensacao = .F.
1238:     ENDPROC
1239: 
1240:     *--------------------------------------------------------------------------
1241:     * ValidarCompensacaoExec - Corpo de ValidarCompensacao(). Esta separado
1242:     * so para que o wrapper libere this_lEmValidacaoCompensacao em TODOS os
1243:     * caminhos de saida, inclusive nos dois RETURN antecipados.
1244:     *--------------------------------------------------------------------------
1245:     PROTECTED PROCEDURE ValidarCompensacaoExec()
1246:         LOCAL loc_oBO, loc_nValorNovo, loc_nValorAnterior, loc_lSucesso
1247: 
1248:         IF (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
1249:             RETURN
1250:         ENDIF
1251: 
1252:         loc_oBO = THIS.this_oBusinessObject
1253: 
1254:         IF VARTYPE(loc_oBO) != "O" OR !USED("TprMvCab")
1255:             RETURN
1256:         ENDIF
1257: 
1258:         loc_nValorNovo     = THIS.txt_4c_Compensacao.Value
1259:         loc_nValorAnterior = TprMvCab.VCompensas
1260: 
1261:         REPLACE TprMvCab.VCompensas WITH loc_nValorNovo IN TprMvCab
1262: 
1263:         loc_lSucesso = loc_oBO.ValidarCompensacao(loc_nValorNovo)
1264: 
1265:         IF loc_lSucesso
1266:             THIS.txt_4c_Compensacao.Refresh()
1267:             THIS.RebindCamposTotais()
1268:         ELSE
1269:             REPLACE TprMvCab.VCompensas WITH loc_nValorAnterior IN TprMvCab
1270:             THIS.txt_4c_Compensacao.Value = loc_nValorAnterior
1271:             MsgAviso(loc_oBO.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
1272:         ENDIF
1273:     ENDPROC
1274: 
1275:     *--------------------------------------------------------------------------
1276:     * RebindCamposTotais - Espelha nos controles os totais que
1277:     * SigOpTotBO.CalcularTotais() (via ProcessarTotais, em CarregarLista(),
1278:     * ou via SigOpTotBO.ValidarCompensacao(), chamado pelo
1279:     * ValidarCompensacao() deste form) acabou de recalcular:
1280:     * Get_QOper/get_TotQtde/Get_POper/Get_TotPeso/
1281:     * Get_TotPesoC/getTotPes.Value e ThisForm.lblTotPes.Caption do bloco
1282:     * "With ThisForm" do calctotais legado (linhas 1358-1365), mais a
1283:     * secao de metro cubico (If CrSigOpCdd.MtCubs <> 0, linhas 1374-1378).
1284:     *
1285:     * Tambem reaplica o valor corrente de TprMvCab.VCompensas em
1286:     * txt_4c_Compensacao (equivalente ao ControlSource do legado) e decide
1287:     * o ReadOnly pelo MESMO criterio do When original (InList(ParentForm.
1288:     * Op_Escolha,'INSERIR','ALTERAR')) - unica forma praticavel de
1289:     * reproduzir When sem BINDEVENT confiavel em TextBox (regra CLAUDE.md
1290:     * #3), suficiente porque este dialogo e modal e Op_Escolha nao muda
1291:     * durante a vida dele.
1292:     *--------------------------------------------------------------------------
1293:     PROTECTED PROCEDURE RebindCamposTotais()
1294:         LOCAL loc_oBO, loc_cModoOperacao
1295:         loc_oBO = THIS.this_oBusinessObject
1296: 
1297:         THIS.txt_4c_TotQtde.Value    = loc_oBO.this_nTotQtde
1298:         THIS.txt_4c_QOper.Value      = loc_oBO.this_cQOper
1299:         THIS.txt_4c_TotPeso.Value    = loc_oBO.this_nTotPeso
1300:         THIS.txt_4c_POper.Value      = loc_oBO.this_cPOper
1301:         THIS.txt_4c_TotPesoC.Value   = loc_oBO.this_nTotPesoC
1302:         THIS.txt_4c_TotPes.Value     = loc_oBO.this_nTotPes
1303:         THIS.lbl_4c_LblTotPes.Caption = loc_oBO.this_cRotuloTotalPeso
1304: 
1305:         THIS.lbl_4c_Label5.Visible = loc_oBO.this_lMostrarMtCub
1306:         THIS.txt_4c_Mtcub.Visible  = loc_oBO.this_lMostrarMtCub
1307:         IF loc_oBO.this_lMostrarMtCub
1308:             THIS.txt_4c_Mtcub.Value = loc_oBO.this_nMtCub
1309:         ENDIF
1310: 
1311:         IF USED("TprMvCab")
1312:             THIS.txt_4c_Compensacao.Value = TprMvCab.VCompensas
1313:         ENDIF
1314: 
1315:         loc_cModoOperacao = ""
1316:         IF VARTYPE(THIS.this_oParentForm) = "O" AND PEMSTATUS(THIS.this_oParentForm, "Op_Escolha", 5)
1317:             loc_cModoOperacao = THIS.this_oParentForm.Op_Escolha
1318:         ENDIF
1319:         THIS.txt_4c_Compensacao.ReadOnly = !INLIST(loc_cModoOperacao, "INSERIR", "ALTERAR")
1320:     ENDPROC
1321: 
1322:     *--------------------------------------------------------------------------
1323:     * CmdRetornarClick - Transcricao do btnSair.Click legado, que tem duas
1324:     * acoes: reabilitar o form que abriu este dialogo
1325:     * (ThisForm.ParentForm.Enabled = .t.) e encerrar a propria tela
1326:     * (ThisForm.Release).
1327:     *
1328:     * Release() e nao Hide() porque este dialogo NAO devolve valor ao
1329:     * chamador - ele so EXIBE os totais, e nao existe property nem metodo de
1330:     * resultado para alguem ler depois que a tela fecha. A guarda de VARTYPE
1331:     * existe porque o form pai e opcional no Init (o harness de teste
1332:     * instancia o dialogo sem pai nenhum).
1333:     *
1334:     * Metodo PUBLIC (sem PROTECTED): e acionado por BINDEVENT, que falha em
1335:     * silencio quando o handler e protegido (regra CLAUDE.md #3).
1336:     *--------------------------------------------------------------------------
1337:     PROCEDURE CmdRetornarClick()
1338:         IF VARTYPE(THIS.this_oParentForm) = "O"
1339:             THIS.this_oParentForm.Enabled = .T.
1340:         ENDIF
1341: 
1342:         THIS.Release()
1343:     ENDPROC
1344: 
1345:     *--------------------------------------------------------------------------
1346:     * CarregarLista - Chama SigOpTotBO.ProcessarTotais() com os cursores que
1347:     * o form pai ja deixou abertos na DataSession compartilhada (regra do
1348:     * cabecalho do arquivo) e rebinda as 6 grades ao resultado. Fora do modo
1349:     * de teste automatizado (TestFormWrapper/ValidarUIFidelity - mesma flag
1350:     * de FORMCOR_LICOES_APRENDIDAS Problema 4) e so quando os cursores do
1351:     * form pai (crSigCdOpe/TprMvCab/crTpmMvItn) realmente existem - sem
1352:     * eles nao ha nada para somar, e ConfigurarGrades() ja deixou a
1353:     * estrutura visual completa com os cursores placeholder vazios.
1354:     *--------------------------------------------------------------------------
1355:     FUNCTION CarregarLista()
1356:         LOCAL loc_lSucesso, loc_cDopes, loc_oErro
1357:         loc_lSucesso = .F.
1358: 
1359:         IF (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
1360:             RETURN .T.
1361:         ENDIF
1362: 
1363:         IF !USED("crSigCdOpe") OR !USED("TprMvCab") OR !USED("crTpmMvItn")
1364:             RETURN .T.
1365:         ENDIF
1366: 
1367:         TRY
1368:             loc_cDopes = IIF(TYPE("TprMvCab.Dopes") != "U", ALLTRIM(TprMvCab.Dopes), "")
1369: 
1370:             IF THIS.this_oBusinessObject.ProcessarTotais(loc_cDopes)
1371:                 THIS.RebindGradeTotalProdutos()
1372:                 THIS.RebindGradeProduto()
1373:                 THIS.RebindGradesServicoOuTamanho()
1374:                 THIS.RebindGradeComponentes()
1375:                 THIS.RebindCamposTotais()
1376:                 loc_lSucesso = .T.
1377:             ELSE

*-- Linhas 1385 a 1575:
1385:         RETURN loc_lSucesso
1386:     ENDFUNC
1387: 
1388:     *--------------------------------------------------------------------------
1389:     * RebindGradeTotalProdutos - Reaplica RecordSource/ControlSource/
1390:     * Header/Width de grd_4c_TotalProdutos depois que SigOpTotBO.
1391:     * CalcularTotais() processou this_cCursorValIte (xValIte) de verdade.
1392:     * Sempre visivel (igual ao legado - Grade_Total.Visible = .t. no Init,
1393:     * sem nenhuma condicao).
1394:     *--------------------------------------------------------------------------
1395:     PROTECTED PROCEDURE RebindGradeTotalProdutos()
1396:         LOCAL loc_cCursor
1397:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorValIte
1398: 
1399:         WITH THIS.grd_4c_TotalProdutos
1400:             .RecordSource = loc_cCursor
1401:             .Column1.ControlSource = loc_cCursor + ".Moeda"
1402:             .Column2.ControlSource = loc_cCursor + ".Total"
1403:             .Column1.Header1.Caption = "Moeda"
1404:             .Column2.Header1.Caption = "Total dos Produtos"
1405:             .Column1.Width = 40
1406:             .Column2.Width = 135
1407:             .Visible = .T.
1408:             .Refresh()
1409:         ENDWITH
1410:     ENDPROC
1411: 
1412:     *--------------------------------------------------------------------------
1413:     * RebindGradeProduto - Reaplica RecordSource/ControlSource/Header/Width
1414:     * de grd_4c_Produto depois que SigOpTotBO.MontarGradeProdutos() recriou
1415:     * this_cCursorProEesti (ProEesti) de verdade. Sempre visivel.
1416:     *--------------------------------------------------------------------------
1417:     PROTECTED PROCEDURE RebindGradeProduto()
1418:         LOCAL loc_cCursor
1419:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorProEesti
1420: 
1421:         WITH THIS.grd_4c_Produto
1422:             .RecordSource = loc_cCursor
1423:             .Column1.ControlSource = loc_cCursor + ".Cpros"
1424:             .Column2.ControlSource = loc_cCursor + ".Qtds"
1425:             .Column1.Header1.Caption = "Produto"
1426:             .Column2.Header1.Caption = "Total"
1427:             .Column1.Width = 125
1428:             .Column2.Width = 80
1429:             .Visible = .T.
1430:             .Refresh()
1431:         ENDWITH
1432:     ENDPROC
1433: 
1434:     *--------------------------------------------------------------------------
1435:     * RebindGradesServicoOuTamanho - Reproduz a exclusao mutua do Init
1436:     * legado (linhas 1580-1587): grd_4c_Servicos e grd_4c_ProdutoTam ocupam
1437:     * a MESMA posicao na tela - com servicos (this_lTemServicos),
1438:     * grd_4c_Servicos aparece ligado a xValServ e grd_4c_ProdutoTam fica
1439:     * oculta; sem servicos, o inverso (grd_4c_ProdutoTam ligado a ProTam).
1440:     *--------------------------------------------------------------------------
1441:     PROTECTED PROCEDURE RebindGradesServicoOuTamanho()
1442:         LOCAL loc_cCursor
1443: 
1444:         IF THIS.this_oBusinessObject.this_lTemServicos
1445:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorValServ
1446: 
1447:             WITH THIS.grd_4c_Servicos
1448:                 .RecordSource = loc_cCursor
1449:                 .Column1.ControlSource = loc_cCursor + ".Moeda"
1450:                 .Column2.ControlSource = loc_cCursor + ".Total"
1451:                 .Column1.Header1.Caption = "Moeda"
1452:                 .Column2.Header1.Caption = "Total dos Servi" + CHR(231) + "os"
1453:                 .Column1.Width = 40
1454:                 .Column2.Width = 135
1455:                 .Visible = .T.
1456:                 .Refresh()
1457:             ENDWITH
1458: 
1459:             THIS.grd_4c_ProdutoTam.Visible = .F.
1460:         ELSE
1461:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorProTam
1462: 
1463:             WITH THIS.grd_4c_ProdutoTam
1464:                 .RecordSource = loc_cCursor
1465:                 .Column1.ControlSource = loc_cCursor + ".Cpros"
1466:                 .Column2.ControlSource = loc_cCursor + ".Qtds"
1467:                 .Column1.Header1.Caption = "Produto + Tam"
1468:                 .Column2.Header1.Caption = "Total"
1469:                 .Column1.Width = 150
1470:                 .Column2.Width = 45
1471:                 .Visible = .T.
1472:                 .Refresh()
1473:             ENDWITH
1474: 
1475:             THIS.grd_4c_Servicos.Visible = .F.
1476:         ENDIF
1477:     ENDPROC
1478: 
1479:     *--------------------------------------------------------------------------
1480:     * RebindGradeComponentes - Reproduz "If Not llTemCompo / GrdTCompo.
1481:     * Visible = .f. / EndIf" do Init legado (linha 1589-1591): so aparece
1482:     * quando SigOpTotBO.ProcessarComponentes() achou linhas em csCompo
1483:     * (this_lTemComponentes).
1484:     *--------------------------------------------------------------------------
1485:     PROTECTED PROCEDURE RebindGradeComponentes()
1486:         LOCAL loc_cCursor
1487:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorCompo
1488: 
1489:         IF THIS.this_oBusinessObject.this_lTemComponentes
1490:             WITH THIS.grd_4c_Componentes
1491:                 .RecordSource = loc_cCursor
1492:                 .Column1.ControlSource = loc_cCursor + ".Codigos"
1493:                 .Column2.ControlSource = loc_cCursor + ".Qtds"
1494:                 .Column3.ControlSource = loc_cCursor + ".UniCompos"
1495:                 .Column4.ControlSource = loc_cCursor + ".QtsCons"
1496:                 .Column1.Header1.Caption = "Componente"
1497:                 .Column2.Header1.Caption = "Quantidade"
1498:                 .Column3.Header1.Caption = "Unid."
1499:                 .Column4.Header1.Caption = "Consumo"
1500:                 .Column1.Width = 80
1501:                 .Column2.Width = 80
1502:                 .Column3.Width = 30
1503:                 .Column4.Width = 60
1504:                 .Visible = .T.
1505:                 .Refresh()
1506:             ENDWITH
1507:         ELSE
1508:             THIS.grd_4c_Componentes.Visible = .F.
1509:         ENDIF
1510:     ENDPROC
1511: 
1512:     *--------------------------------------------------------------------------
1513:     * TornarControlesVisiveis - AddObject cria controles com Visible=.F. por
1514:     * padrao; percorre recursivamente Controls (containers) e Pages (quando
1515:     * algum container interno vier a ter PageFrame) para garantir que tudo
1516:     * fique visivel apos a montagem.
1517:     *
1518:     * EXCECAO (regra do meta_prompt.md - "containers flutuantes"):
1519:     * grd_4c_Servicos, grd_4c_Componentes e cnt_4c_CalculoCol nascem
1520:     * Visible=.F. de proposito (exclusao mutua / bloco morto - ver
1521:     * ConfigurarGrades()) e NAO podem ser forcados a .T. por este
1522:     * passo generico; CarregarLista() decide a visibilidade final das
1523:     * duas primeiras, e cnt_4c_CalculoCol fica oculto para sempre.
1524:     * lbl_4c_Label5/txt_4c_Mtcub (bloco de metro cubico) sao a MESMA
1525:     * excecao - nascem Visible=.F. em ConfigurarCamposTotais() (fieis ao
1526:     * dump) e so RebindCamposTotais() (via CarregarLista) decide se
1527:     * aparecem, quando SigOpTotBO.this_lMostrarMtCub fica .T.
1528:     *--------------------------------------------------------------------------
1529:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1530:         LOCAL loc_nI, loc_oControl, loc_nP
1531: 
1532:         IF VARTYPE(par_oContainer) != "O"
1533:             RETURN
1534:         ENDIF
1535: 
1536:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1537:             loc_oControl = par_oContainer.Controls(loc_nI)
1538: 
1539:             IF INLIST(UPPER(loc_oControl.Name), "GRD_4C_SERVICOS", "GRD_4C_COMPONENTES", ;
1540:                     "CNT_4C_CALCULOCOL", "LBL_4C_LABEL5", "TXT_4C_MTCUB")
1541:                 LOOP
1542:             ENDIF
1543: 
1544:             IF PEMSTATUS(loc_oControl, "Visible", 5)
1545:                 loc_oControl.Visible = .T.
1546:             ENDIF
1547: 
1548:             IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
1549:                 FOR loc_nP = 1 TO loc_oControl.PageCount
1550:                     THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
1551:                 ENDFOR
1552:             ENDIF
1553: 
1554:             IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1555:                 THIS.TornarControlesVisiveis(loc_oControl)
1556:             ENDIF
1557:         ENDFOR
1558:     ENDPROC
1559: 
1560:     *--------------------------------------------------------------------------
1561:     * Destroy - Libera a referencia ao Business Object. A reabilitacao do
1562:     * form pai (legado: ThisForm.ParentForm.Enabled = .t.) fica no handler do
1563:     * botao Retornar (CmdRetornarClick), nao aqui - o legado tambem faz isso
1564:     * no Click, e
1565:     * no Destroy/QueryUnload.
1566:     *--------------------------------------------------------------------------
1567:     PROCEDURE Destroy()
1568:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1569:             THIS.this_oBusinessObject = .NULL.
1570:         ENDIF
1571: 
1572:         DODEFAULT()
1573:     ENDPROC
1574: 
1575: ENDDEFINE

