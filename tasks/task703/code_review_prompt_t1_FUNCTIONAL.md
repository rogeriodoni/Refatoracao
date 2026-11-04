# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (4)
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 4 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 4 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [NAVEGACAO-PAGINA] Metodo 'AlternarPagina' faz ActivePage=2 mas NAO le dados de cursor nem chama CarregarHistorico/CarregarDados. Em forms OPERACIONAL, a navegacao para Page2 DEVE carregar dados da linha selecionada no grid de Page1 (padrao legado: cmd_consulta.Click le do cursor do grid).

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopclg.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2023 linhas total):

*-- Linhas 28 a 425:
28: * nao sendo Lista/Dados de CRUD - mesma convencao de FormSigOpCgr.prg/
29: * Formsigopcgc.prg (familia de dialogos de pesquisa/consulta OPERACIONAL).
30: *
31: * FASE 3/8: Estrutura base do Form - DEFINE CLASS, Init/InicializarForm,
32: * ConfigurarPageFrame com as 2 paginas (Dados/Resultado) e os containers
33: * principais vazios: cnt_4c_Cabecalho (faixa do titulo, nas DUAS paginas -
34: * regra CLAUDE.md #11, que prevalece sobre o legado, cujo dump so tem
35: * cntSombra em PgDados), cnt_4c_Botoes (Page1) e cnt_4c_BotoesAcao (Page2).
36: *
37: * Largura do form escalada para o canonico 1000x600 (legado: 800x600),
38: * mesma convencao de FormSigOpCgr.prg. Os botoes sao transcritos com o
39: * tamanho fisico do dump (75x75/85x85); so a largura do form e a posicao
40: * horizontal dos containers mudam.
41: *
42: * FASE 4/8: CommandGroup cmg_4c_Acoes dentro de cnt_4c_Botoes (Page1 -
43: * 2 botoes: Processar/btnProcessar e Encerrar/btnSair, transcritos do
44: * cmdProcessar legado - ButtonCount=2, mesmo Width/Height do container) e
45: * CommandGroup cmg_4c_Voltar dentro de cnt_4c_BotoesAcao (Page2 - 1 botao,
46: * transcrito do cmdBotoes legado: Caption/Picture de sair ("Encerrar" +
47: * cadastro_sair_60.jpg), mas o Click real (Fase 7/8) volta para a pagina
48: * de filtros - por isso o handler se chamara BtnVoltarClick e nao
49: * BtnEncerrarClick, nome pela ACAO real e nao pela legenda do botao).
50: * Grade grd_4c_Dados (Page2), ligada a this_oBusinessObject.this_cCursorLog
51: * via VincularGradeLog() - FONTE UNICA do bind (regra CLAUDE.md #41/#48),
52: * com cursor placeholder criado por InicializarCursorLog() ANTES do Grid
53: * ser configurado (regra #41 - Column.ControlSource de cursor inexistente
54: * derruba o Init). ControlSource/Width/Header1.Caption das 7 colunas
55: * transcritos do PROCEDURE processamento legado (que SOBRESCREVE os
56: * headers do dump estatico do SCX - regra "a pagina segue o Init/metodo
57: * legado, nao o dump"): Usuario Rede/Data/Hora/Programa/Operacao (ligada a
58: * cOpers, a descricao calculada, nao a Opers crua)/Usuario Sistema/
59: * Parametro. Geometria do Grid (Top=197/Left=63/Width=656/Height=307) =
60: * valores do dump + compensacao +29 do PageFrame.Top=-29 (regra #1/#11) -
61: * sem rescala horizontal, pois a faixa de botoes Left=917 nao alcanca essa
62: * altura (Top>=197). AlternarPagina(par_nPagina) tambem entra nesta fase,
63: * com o guard que o legado tem no proprio fluxo (Processamento so chega em
64: * "ActivePage = 2" quando a consulta devolve linha - "If Eof() Then
65: * Return" - aqui expresso contra this_oBusinessObject.this_nQtdeLog, que
66: * ja existe desde a Fase 1/2) e o toggle de Page2.Enabled (btnDados.Click
67: * legado faz Enabled=.f. antes de voltar para a Pagina 1).
68: *
69: * O BINDEVENT dos botoes e da grade (Click/AfterRowColChange) ficou para a
70: * Fase 7/8 de proposito: o delegate de BINDEVENT tem de EXISTIR no momento
71: * do bind (regra CLAUDE.md sobre BINDEVENT com delegate inexistente
72: * estourando no bind, nao no clique) e BtnProcessarClick depende dos
73: * campos de filtro das Fases 5/6 (na Fase 4 FormParaBO ainda nao existia).
74: *
75: * FASE 5/8 (PARTE 1/2): primeira metade dos campos de filtro da Page1 -
76: * txt_4c_UserRede (Usuario de Rede), txt_4c_DtIni/txt_4c_DtFin (Periodo) e
77: * txt_4c_HrIni/txt_4c_HrFin (Horario de Acesso, Format "R" + InputMask
78: * "99:99" transcritos do dump) e txt_4c_Prg (Programa) + os labels
79: * correspondentes (Say1/Say2/Say3/Say4/Say5/Say6 do legado). Todos filhos
80: * DIRETOS da Page1 (sem container de agrupamento no dump), Top = dump + 29
81: * (compensacao PageFrame.Top=-29), Left mantido igual ao dump (so os
82: * containers de botao usam posicao canonica rescalada - Fase 3/4).
83: * Caracteres acentuados via CHR() (regra CLAUDE.md #4): CHR(225)=a-acute,
84: * CHR(237)=i-acute, CHR(224)=a-grave (confirmado no .scx - byte 0xE0 -
85: * usado entre as duas datas/horarios do periodo, ex. "01/01 " + CHR(224) +
86: * " 31/01"). O lookup de Programa (SigCdPrg.Programas) entrou na Fase 6/8,
87: * abaixo.
88: *
89: * FASE 6/8 (PARTE 2/2): segunda metade dos campos - cbo_4c_GetOperacao
90: * (ComboBox de Operacao, RowSourceType=1 + Style=2 com a lista
91: * "Liberacao,Entrada,Saida,Transacao, " transcrita LITERALMENTE do dump,
92: * item em branco final incluido), txt_4c_UserSis (Usuario do Sistema),
93: * txt_4c_Param (Parametros) e txt_4c_Trans (Transacao) + os labels
94: * Say7/Say8/Say9/Say10 do legado; na Page2, txt_4c_Fwget1 (Transacao do
95: * registro corrente, Enabled=.F. no dump) + o Say10 homonimo dela
96: * (FontBold=.T.), com o ControlSource ligado dentro de VincularGradeLog()
97: * para acompanhar a grade - igual ao bloco final do PROCEDURE
98: * processamento legado, que liga grade e fwget1 juntos.
99: *
100: * Lookups COMPLETOS nesta fase, cada um com a API que corresponde ao
101: * browse do legado:
102: *   - Programa (GetPrg.Valid -> fwBuscaInt, browse sobre cursor LOCAL):
103: *     sigopclgBO.BuscarProgramas() popula cursor_4c_Programas, LOCATE
104: *     tenta o match e, falhando, FormBuscaAuxiliar recebe o cursor ja
105: *     populado via DefinirCursor() - reduzido a UMA coluna, porque
106: *     SigCdPrg.Programas eh codigo E descricao (familia de SigCdOpe).
107: *   - Usuario do Sistema (GetUserSis.Valid -> fwBuscaExt, consulta o SQL
108: *     Server): FormBuscaAuxiliar com Init por parametros (1o argumento =
109: *     gnConnHandle, regra CLAUDE.md #36) + guarda this_lAchouRegistro
110: *     antes do Show e this_lSelecionou antes de atribuir (regra #37).
111: * Os dois vao em "LostFocus" (o legado valida no Valid, ao SAIR do campo),
112: * com guarda de reentrancia this_lEmLookup, mais F4/DblClick como entradas
113: * diretas - os handlers de KeyPress TESTAM a tecla (regra #47).
114: *
115: * FASE 7/8: eventos dos botoes e o fluxo de pesquisa que eles disparam,
116: * mais os BINDEVENT correspondentes (que so podiam entrar agora - o
117: * delegate de BINDEVENT tem de EXISTIR no momento do bind).
118: *
119: * O legado NAO tem barra CRUD: SIGOPCLG herda de "form" PURO (nao de
120: * frmcadastro), nao tem Grupo_Op nem pcEscolha, e nenhum dos seus 3 botoes
121: * eh Incluir/Alterar/Visualizar/Excluir. Por isso NAO existem
122: * BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick: os
123: * "eventos principais dos botoes" desta tela sao os 3 Click que o dump
124: * PROVA existirem, um handler por BOTAO (como no legado, onde cada botao
125: * tem o seu proprio .Click - nao ha despachante por .Value a transcrever):
126: *   - cmg_4c_Acoes.Buttons(1) -> BtnProcessarClick  (Command1.Click:
127: *     MessageBox de confirmacao + ThisForm.Processamento)
128: *   - cmg_4c_Acoes.Buttons(2) -> BtnEncerrarClick   (btnSair.Click:
129: *     ThisForm.Release)
130: *   - cmg_4c_Voltar.Buttons(1) -> BtnVoltarClick    (btnDados.Click:
131: *     PgResultado.Enabled=.f. + ActivePage=1 - volta para os filtros, NAO
132: *     fecha a tela; o nome segue a ACAO e nao a legenda "Encerrar")
133: *
134: * O PROCEDURE processamento legado fica repartido entre o form e o BO,
135: * cada parte do lado de quem ela pertence:
136: *   - form: confirmacao, leitura dos 10 filtros (FormParaBO), exibicao das
137: *     mensagens com o ICONE do legado (16 = MsgErro para "Nenhum Parametro
138: *     de Selecao foi Preenchido"; 64 = MsgInfo para "Nenhum Registro
139: *     Encontrado para Selecao"), o bind/unbind da grade e a troca de pagina.
140: *   - BO (Fase 1/2): a validacao de "nenhum filtro", o WHERE dinamico e o
141: *     SQLEXEC em cursor_4c_Log (sigopclgBO.BuscarLog()).
142: * DesvincularGradeLog transcreve a 1a linha do processamento legado
143: * ("GrdLog.RecordSource = ''") e nao eh cosmetica: BuscarLog() faz USE IN +
144: * SQLEXEC sobre o MESMO alias, e SQLEXEC sobre alias ligado a Grid ZERA o
145: * ColumnCount. A ordem do caminho de sucesso eh desvincular -> consultar ->
146: * VincularGradeLog -> AlternarPagina(2) -> RepintarGradeLog, porque Refresh
147: * em pagina OCULTA nao pinta (regra CLAUDE.md #21).
148: * Nesta fase tambem entra o AfterRowColChange da grade
149: * (GrdDadosAfterRowColChange = "fwget1.Refresh" do legado + sincronizacao
150: * do registro corrente do BO via CarregarDoCursor), porque a grade e o
151: * campo txt_4c_Fwget1 ja existem e sem ele a Transacao exibida ficaria
152: * presa na primeira linha; e o "PgResultado.Enabled=.f." do Init legado,
153: * que eh o estado inicial do toggle que BtnVoltarClick/AlternarPagina usam.
154: *
155: * FASE 8/8: CarregarLog, BOParaForm e LimparCampos.
156: *
157: * CarregarLog eh o FUNIL unico de carga da grade - o corpo do "PROCEDURE
158: * processamento" legado, que na Fase 7 estava inline no BtnProcessarClick.
159: * O Click do botao ficou com o que o Click legado de fato tem (a
160: * confirmacao) e delega o resto, para que qualquer caminho que precise
161: * repopular a grade use o MESMO metodo: popular cursor NAO repinta a grade
162: * sozinho e a repintura tem de vir DEPOIS de a pagina estar visivel
163: * (regra CLAUDE.md #21/#46), e duplicar essa sequencia eh o que faz uma das
164: * copias esquecer o Refresh e a grade aparecer vazia com o cursor cheio.
165: *
166: * BOParaForm eh o sentido inverso de FormParaBO - escreve os 10 filtros das
167: * propriedades do BO de volta nos controles da Page1. LimparCampos reseta
168: * sigopclgBO.LimparDados() + BOParaForm + o ".GetUserRede.SetFocus" do Init
169: * legado (mesmo padrao de FormSigOpCgr.prg).
170: * O legado nao tem botao de "Limpar" - os campos ja nascem vazios no
171: * AddObject - mas LimparCampos centraliza o estado inicial (chamado no fim
172: * de InicializarForm, substituindo a atribuicao solta de ActivePage) e
173: * completa o par FormParaBO/BOParaForm que o pipeline exige em todo form.
174: * O SetFocus fica guardado por THIS.Visible: na chamada feita dentro de
175: * InicializarForm o form ainda nao foi exibido (SetFocus em controle
176: * invisivel estoura), igual ao Init legado, que roda antes do Show().
177: *
178: * AUSENCIAS LEGITIMAS (nao sao omissao - o legado nao tem o que migrar):
179: *   - BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick:
180: *     tela de CONSULTA somente-leitura, sem CRUD no legado (ver acima).
181: *   - Inserir/Atualizar/ExecutarExclusao no BO: o comportamento padrao
182: *     herdado de BusinessBase ja eh o correto para consulta.
183: *   - CarregarLista: o nome canonico popula a grade da pagina de LISTA do
184: *     frmcadastro, que esta tela nao tem - aqui a grade eh o RESULTADO de
185: *     uma consulta disparada pelos filtros, e quem a alimenta eh
186: *     CarregarLog (acima). Renomea-lo para CarregarLista chamaria de
187: *     "lista" o que o legado chama de pgResultado.
188: *   - BtnCancelarClick: eh o "Cancelar" da Page2 de Dados do frmcadastro,
189: *     que pressupoe um modo de EDICAO cancelavel. Esta tela nao edita nada;
190: *     o botao que o legado tem na pgResultado nao cancela, ele VOLTA para os
191: *     filtros (PgResultado.Enabled=.f. + ActivePage=1) e esta migrado como
192: *     BtnVoltarClick, com o nome seguindo a ACAO e nao a legenda.
193: *==============================================================================
194: 
195: DEFINE CLASS Formsigopclg AS FormBase
196: 
197:     *-- Dimensoes e propriedades visuais (padrao canonico de form
198:     *-- OPERACIONAL - framework_frmcadastro_layout.md / FormSigOpCgr.prg).
199:     *-- Legado: Width=800/Height=600 (SIGOPCLG.SCX); escalado para o
200:     *-- canonico 1000x600.
201:     Height      = 600
202:     Width       = 1000
203:     BorderStyle = 2
204:     AutoCenter  = .T.
205:     ShowTips    = .T.
206:     Caption     = "Consulta do Log"
207:     ControlBox  = .F.
208:     Closable    = .F.
209:     MaxButton   = .F.
210:     MinButton   = .F.
211:     TitleBar    = 0
212:     WindowState = 0
213:     ShowWindow  = 1
214:     WindowType  = 1
215:     DataSession = 2
216:     Themes      = .F.
217: 
218:     *-- Guarda de reentrancia dos lookups (Programa / Usuario do Sistema).
219:     *-- O picker (FormBuscaAuxiliar) eh MODAL: ao fechar, o foco volta para
220:     *-- o TextBox e o proprio LostFocus que o abriu pode disparar de novo,
221:     *-- empilhando um segundo dialogo (regra CLAUDE.md #37/#47).
222:     this_lEmLookup = .F.
223: 
224:     *==========================================================================
225:     * Init() - o legado nao recebe parametros ("PROCEDURE Init" sem
226:     * LPARAMETERS) - DODEFAULT() ja chama InicializarForm via FormBase.Init
227:     *==========================================================================
228:     PROCEDURE Init()
229:         RETURN DODEFAULT()
230:     ENDPROC
231: 
232:     *==========================================================================
233:     * ValidarParametros - guarda de conexao do Init legado (CreateObject de
234:     * poDataMgr e checagem .pnIdconn > 0), com bypass para os modos sem
235:     * usuario (teste automatizado / validacao de UI).
236:     *
237:     * PUBLIC de proposito: o harness da etapa 06b chama metodos do form de
238:     * FORA da classe, e metodo PROTECTED falha em runtime mesmo com
239:     * PEMSTATUS devolvendo .T. (regra CLAUDE.md #1/TesteAutomatico).
240:     *==========================================================================
241:     PROCEDURE ValidarParametros()
242:         LOCAL loc_lValido
243:         loc_lValido = .T.
244: 
245:         IF TYPE("gb_4c_ModoTeste") = "L"
246:             IF gb_4c_ModoTeste
247:                 RETURN .T.
248:             ENDIF
249:         ENDIF
250: 
251:         IF TYPE("gb_4c_ValidandoUI") = "L"
252:             IF gb_4c_ValidandoUI
253:                 RETURN .T.
254:             ENDIF
255:         ENDIF
256: 
257:         DO CASE
258:             CASE TYPE("gnConnHandle") != "N"
259:                 MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + "o " + ;
260:                         "Com o Servidor de Banco de Dados...", "Conex" + CHR(227) + "o")
261:                 loc_lValido = .F.
262:             CASE gnConnHandle <= 0
263:                 MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + "o " + ;
264:                         "Com o Servidor de Banco de Dados...", "Conex" + CHR(227) + "o")
265:                 loc_lValido = .F.
266:         ENDCASE
267: 
268:         RETURN loc_lValido
269:     ENDPROC
270: 
271:     *==========================================================================
272:     * InicializarForm - Chamado por FormBase.Init via DODEFAULT
273:     *==========================================================================
274:     PROTECTED PROCEDURE InicializarForm()
275:         LOCAL loc_lSucesso, loc_oErro
276:         loc_lSucesso = .F.
277: 
278:         *-- A guarda de conexao fica FORA do TRY (mesmo padrao de
279:         *-- FormSigOpCgr.prg): o harness de teste automatizado define
280:         *-- gnConnHandle = 0 de proposito, e a guarda precisa devolver
281:         *-- antes de qualquer SQLEXEC/CREATEOBJECT que dependa de conexao.
282:         IF !THIS.ValidarParametros()
283:             RETURN .F.
284:         ENDIF
285: 
286:         TRY
287:             THIS.this_oBusinessObject = CREATEOBJECT("sigopclgBO")
288: 
289:             *-- Cursor placeholder de cursor_4c_Log ANTES do PageFrame: a
290:             *-- Page2 liga Grid.RecordSource a este alias na mesma fase
291:             *-- (regra CLAUDE.md #41 - Column.ControlSource de cursor
292:             *-- inexistente derruba o Init).
293:             THIS.InicializarCursorLog()
294: 
295:             THIS.ConfigurarPageFrame()
296:             THIS.ConfigurarPaginaLista()
297:             THIS.ConfigurarPaginaDados()
298:             THIS.TornarControlesVisiveis(THIS)
299: 
300:             THIS.pgf_4c_Paginas.Visible    = .T.
301: 
302:             *-- ".PgfPagina.PgResultado.Enabled=.f." do Init legado: a pagina
303:             *-- de resultado nasce DESLIGADA e so eh habilitada quando a
304:             *-- consulta devolve linha (BtnProcessarClick -> AlternarPagina(2),
305:             *-- Fase 7/8). Sem este estado inicial o toggle de AlternarPagina
306:             *-- comecaria invertido - BtnVoltarClick desliga a Page2, logo
307:             *-- alguem tem de deixa-la desligada na abertura.
308:             THIS.pgf_4c_Paginas.Page2.Enabled = .F.
309: 
310:             THIS.pgf_4c_Paginas.ActivePage = 1
311: 
312:             *-- Estado inicial do Init legado (filtros vazios) + o
313:             *-- ".GetUserRede.SetFocus" final (Fase 8/8) - consolidado em
314:             *-- LimparCampos, mesmo padrao de FormSigOpCgr.prg.
315:             THIS.LimparCampos()
316: 
317:             loc_lSucesso = .T.
318:         CATCH TO loc_oErro
319:             MsgErro(loc_oErro.Message + CHR(13) + ;
320:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
321:                     "Procedure: " + loc_oErro.Procedure, "Erro ao Inicializar")
322:         ENDTRY
323: 
324:         RETURN loc_lSucesso
325:     ENDPROC
326: 
327:     *==========================================================================
328:     * InicializarCursorLog - Cria o cursor placeholder do resultado da
329:     * pesquisa (equivalente a estrutura do "Select '          ' As cOpers,
330:     * a.* From SigOpLog a" do PROCEDURE processamento legado). Mesma
331:     * estrutura que THIS.this_oBusinessObject.BuscarLog() popula via
332:     * SQLEXEC - existe so para o Grid poder ser configurado
333:     * (RecordSource/ControlSource) nesta fase sem a tela quebrar; o
334:     * SQLEXEC de BuscarLog() fecha e recria este alias do zero (Fase 7/8).
335:     *==========================================================================
336:     PROTECTED PROCEDURE InicializarCursorLog()
337:         LOCAL loc_cCursor
338:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorLog
339: 
340:         IF !USED(loc_cCursor)
341:             SET NULL ON
342:             CREATE CURSOR (loc_cCursor) ;
343:                 (cOpers C(10), UsuaRedes C(20), Datars T, Horas C(8), ;
344:                  Progs C(20), Opers C(1), Usuasis C(20), Parametros C(10), ;
345:                  Transacaos C(100), CVersaos C(70), cidchaves C(20), Copias C(1))
346:             SET NULL OFF
347:         ENDIF
348:     ENDPROC
349: 
350:     *==========================================================================
351:     * ConfigurarPageFrame - Constroi o PageFrame com 2 paginas
352:     * (Dados/Resultado, espelhando PgDados/pgResultado do legado)
353:     *==========================================================================
354:     PROTECTED PROCEDURE ConfigurarPageFrame()
355:         LOCAL loc_oPgf
356: 
357:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
358:         loc_oPgf = THIS.pgf_4c_Paginas
359: 
360:         loc_oPgf.PageCount = 2
361:         loc_oPgf.Top       = -29
362:         loc_oPgf.Left      = 0
363:         loc_oPgf.Width     = THIS.Width
364:         loc_oPgf.Height    = THIS.Height + 29
365:         loc_oPgf.TabIndex  = 1
366:         loc_oPgf.Tabs      = .F.
367: 
368:         loc_oPgf.Page1.Caption = "Dados"
369:         loc_oPgf.Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
370: 
371:         loc_oPgf.Page2.Caption = "Resultado"
372:         loc_oPgf.Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
373: 
374:         loc_oPgf.Visible    = .T.
375:         loc_oPgf.ActivePage = 1
376:     ENDPROC
377: 
378:     *==========================================================================
379:     * ConfigurarPaginaLista - Estrutura da Page1 (Dados/filtros): faixa do
380:     * cabecalho + CommandGroup cmg_4c_Acoes (Processar/Encerrar) + 1a
381:     * metade dos campos de filtro (Usuario de Rede, Periodo, Horario,
382:     * Programa - Fase 5/8). 2a metade (Operacao, Usuario do Sistema,
383:     * Parametros, Transacao) vem na Fase 6/8.
384:     *==========================================================================
385:     PROTECTED PROCEDURE ConfigurarPaginaLista()
386:         LOCAL loc_oPag, loc_oCab
387: 
388:         loc_oPag = THIS.pgf_4c_Paginas.Page1
389: 
390:         *-- Faixa do cabecalho - PRIMEIRO AddObject da pagina (regra
391:         *-- CLAUDE.md #11/#39): os containers de botao ficam em Top=29..33
392:         *-- (dentro da area da faixa) e tem de ser criados DEPOIS para
393:         *-- desenhar por cima.
394:         loc_oPag.AddObject("cnt_4c_Cabecalho", "Container")
395:         loc_oCab = loc_oPag.cnt_4c_Cabecalho
396:         WITH loc_oCab
397:             .Top           = 29
398:             .Left          = 0
399:             .Width         = THIS.Width
400:             .Height        = 80
401:             .BorderWidth   = 0
402:             .SpecialEffect = 0
403:             .BackColor     = RGB(100, 100, 100)
404: 
405:             .AddObject("lbl_4c_Sombra", "Label")
406:             WITH .lbl_4c_Sombra
407:                 .Top       = 15
408:                 .Left      = 10
409:                 .Width     = THIS.Width
410:                 .Height    = 40
411:                 .FontName  = "Tahoma"
412:                 .FontSize  = 16
413:                 .FontBold  = .T.
414:                 .WordWrap  = .T.
415:                 .Alignment = 0
416:                 .BackStyle = 0
417:                 .ForeColor = RGB(0, 0, 0)
418:                 .Caption   = THIS.Caption
419:             ENDWITH
420: 
421:             .AddObject("lbl_4c_Titulo", "Label")
422:             WITH .lbl_4c_Titulo
423:                 .Top       = 18
424:                 .Left      = 10
425:                 .Width     = THIS.Width

*-- Linhas 512 a 555:
512:         *-- PageFrame.Top=-29, regra CLAUDE.md #1/#11).
513:         *--
514:         *-- Parte 2 (Fase 6/8, abaixo): Operacao (ComboBox), Usuario do
515:         *-- Sistema, Parametros, Transacao + os BINDEVENT dos lookups de
516:         *-- Programa (SigCdPrg) e Usuario do Sistema (SigCdUsu).
517: 
518:         *-- Say4 "Usuario da Rede :" (Left=98/Top=197 no dump)
519:         loc_oPag.AddObject("lbl_4c_Label4", "Label")
520:         WITH loc_oPag.lbl_4c_Label4
521:             .Top       = 226
522:             .Left      = 98
523:             .Width     = 85
524:             .Height    = 15
525:             .FontName  = "Tahoma"
526:             .FontSize  = 8
527:             .FontBold  = .F.
528:             .Alignment = 0
529:             .AutoSize  = .F.
530:             .BackStyle = 0
531:             .ForeColor = RGB(90, 90, 90)
532:             .Caption   = "Usu" + CHR(225) + "rio da Rede :"
533:         ENDWITH
534: 
535:         *-- GetUserRede do legado - Usuario de Rede (this_cUserRede no BO)
536:         loc_oPag.AddObject("txt_4c_UserRede", "TextBox")
537:         WITH loc_oPag.txt_4c_UserRede
538:             .Top       = 223
539:             .Left      = 189
540:             .Width     = 152
541:             .Height    = 23
542:             .FontName  = "Tahoma"
543:             .FontSize  = 8
544:             .MaxLength = 20
545:             .Value     = ""
546:             .TabIndex  = 1
547:         ENDWITH
548: 
549:         *-- Say2 "Periodo :" (Left=141/Top=224 no dump)
550:         loc_oPag.AddObject("lbl_4c_Label2", "Label")
551:         WITH loc_oPag.lbl_4c_Label2
552:             .Top       = 253
553:             .Left      = 141
554:             .Width     = 45
555:             .Height    = 15

*-- Linhas 694 a 737:
694:         ENDWITH
695: 
696:         *-- GetPrg do legado - Programa (this_cPrg no BO; lookup contra
697:         *-- SigCdPrg.Programas em ValidarPrgLostFocus, Fase 6/8 - BINDEVENT
698:         *-- no fim deste metodo). Format/InputMask do dump sao override
699:         *-- VAZIO do Form Designer - nao transcritos (regra CLAUDE.md #49).
700:         loc_oPag.AddObject("txt_4c_Prg", "TextBox")
701:         WITH loc_oPag.txt_4c_Prg
702:             .Top       = 305
703:             .Left      = 189
704:             .Width     = 152
705:             .Height    = 23
706:             .FontName  = "Tahoma"
707:             .FontSize  = 8
708:             .Alignment = 3
709:             .MaxLength = 20
710:             .Value     = ""
711:             .TabIndex  = 6
712:         ENDWITH
713: 
714:         *-- Say8 "Operacao :" (Left=130/Top=306 no dump)
715:         loc_oPag.AddObject("lbl_4c_Label8", "Label")
716:         WITH loc_oPag.lbl_4c_Label8
717:             .Top       = 335
718:             .Left      = 130
719:             .Width     = 55
720:             .Height    = 15
721:             .FontName  = "Tahoma"
722:             .FontSize  = 8
723:             .FontBold  = .F.
724:             .Alignment = 0
725:             .AutoSize  = .F.
726:             .BackStyle = 0
727:             .ForeColor = RGB(90, 90, 90)
728:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
729:         ENDWITH
730: 
731:         *-- GetOperacao do legado - ComboBox de Operacao (this_cOperacao no
732:         *-- BO). RowSourceType = 1 (lista literal) + Style = 2 (DropDownList):
733:         *-- o .Value eh o TEXTO da opcao escolhida, e eh esse texto que
734:         *-- sigopclgBO.BuscarLog() mapeia para o codigo de SigOpLog.Opers
735:         *-- (Entrada=E, Saida=S, Liberacao=L, qualquer outra = os tres <>).
736:         *--
737:         *-- A lista eh REGRA DE NEGOCIO - transcrita LITERALMENTE do dump

*-- Linhas 862 a 953:
862:         ENDWITH
863: 
864:         *----------------------------------------------------------------------
865:         * Lookups (PROCEDURE Valid de GetPrg e GetUserSis no legado)
866:         *
867:         * O picker vai em "LostFocus" e NAO em "KeyPress" (regra CLAUDE.md
868:         * #47): o legado valida no Valid, isto eh ao SAIR do campo; ligado a
869:         * "KeyPress" sem teste de tecla o dialogo subiria a CADA caractere
870:         * digitado e o usuario nao conseguiria terminar de digitar o codigo.
871:         *
872:         * Os handlers de "KeyPress" existem so para o atalho F4 (115) - eles
873:         * TESTAM a tecla e delegam ao funil AbrirLookup<X>, por isso declaram
874:         * (par_nKeyCode, par_nShiftAltCtrl) (regra CLAUDE.md #3: handler de
875:         * KeyPress sem os parametros estoura a cada tecla).
876:         *----------------------------------------------------------------------
877:         BINDEVENT(loc_oPag.txt_4c_Prg,     "LostFocus", THIS, "ValidarPrgLostFocus")
878:         BINDEVENT(loc_oPag.txt_4c_Prg,     "KeyPress",  THIS, "PrgKeyPress")
879:         BINDEVENT(loc_oPag.txt_4c_Prg,     "DblClick",  THIS, "PrgDblClick")
880: 
881:         BINDEVENT(loc_oPag.txt_4c_UserSis, "LostFocus", THIS, "ValidarUserSisLostFocus")
882:         BINDEVENT(loc_oPag.txt_4c_UserSis, "KeyPress",  THIS, "UserSisKeyPress")
883:         BINDEVENT(loc_oPag.txt_4c_UserSis, "DblClick",  THIS, "UserSisDblClick")
884: 
885:         *----------------------------------------------------------------------
886:         * FASE 7/8 - BINDEVENT dos botoes de acao do cmg_4c_Acoes.
887:         *
888:         * UM handler por BOTAO (bind em Buttons(N), nao no grupo), porque no
889:         * legado cada botao tem o SEU proprio .Click: "Command1.Click" chama
890:         * ThisForm.Processamento e "btnSair.Click" faz ThisForm.Release - nao
891:         * ha despachante por .Value do CommandGroup para transcrever.
892:         *
893:         * O bind fica aqui (e nao na Fase 4, com o AddObject dos botoes) de
894:         * proposito: o delegate de BINDEVENT tem de EXISTIR no momento do
895:         * bind, senao estoura no BIND e nao no clique - e BtnProcessarClick
896:         * depende de FormParaBO, que consome os campos de filtro das Fases
897:         * 5/6.
898:         *----------------------------------------------------------------------
899:         BINDEVENT(loc_oPag.cnt_4c_Botoes.cmg_4c_Acoes.Buttons(1), "Click", ;
900:                   THIS, "BtnProcessarClick")
901:         BINDEVENT(loc_oPag.cnt_4c_Botoes.cmg_4c_Acoes.Buttons(2), "Click", ;
902:                   THIS, "BtnEncerrarClick")
903:     ENDPROC
904: 
905:     *==========================================================================
906:     * ConfigurarPaginaDados - Estrutura da Page2 (Resultado): faixa do
907:     * cabecalho + CommandGroup cmg_4c_Voltar (botao de retorno) + grade
908:     * grd_4c_Dados (resultado da pesquisa) + o campo txt_4c_Fwget1
909:     * (Transacao do registro corrente, Fase 6/8) + os BINDEVENT de Click do
910:     * botao de retorno e do AfterRowColChange da grade, que mantem esse
911:     * campo sincronizado com a linha corrente (Fase 7/8).
912:     *==========================================================================
913:     PROTECTED PROCEDURE ConfigurarPaginaDados()
914:         LOCAL loc_oPag, loc_oCab
915: 
916:         loc_oPag = THIS.pgf_4c_Paginas.Page2
917: 
918:         *-- Faixa do cabecalho tambem na pagina Resultado (regra CLAUDE.md
919:         *-- #11 - decisao do time, prevalece sobre o legado, cujo dump so
920:         *-- tem cntSombra em PgDados).
921:         loc_oPag.AddObject("cnt_4c_Cabecalho", "Container")
922:         loc_oCab = loc_oPag.cnt_4c_Cabecalho
923:         WITH loc_oCab
924:             .Top           = 29
925:             .Left          = 0
926:             .Width         = THIS.Width
927:             .Height        = 80
928:             .BorderWidth   = 0
929:             .SpecialEffect = 0
930:             .BackColor     = RGB(100, 100, 100)
931: 
932:             .AddObject("lbl_4c_Sombra", "Label")
933:             WITH .lbl_4c_Sombra
934:                 .Top       = 15
935:                 .Left      = 10
936:                 .Width     = THIS.Width
937:                 .Height    = 40
938:                 .FontName  = "Tahoma"
939:                 .FontSize  = 16
940:                 .FontBold  = .T.
941:                 .WordWrap  = .T.
942:                 .Alignment = 0
943:                 .BackStyle = 0
944:                 .ForeColor = RGB(0, 0, 0)
945:                 .Caption   = THIS.Caption
946:             ENDWITH
947: 
948:             .AddObject("lbl_4c_Titulo", "Label")
949:             WITH .lbl_4c_Titulo
950:                 .Top       = 18
951:                 .Left      = 10
952:                 .Width     = THIS.Width
953:                 .Height    = 46

*-- Linhas 1057 a 1159:
1057:         *-- fwget1 do legado - Transacao do registro corrente da grade.
1058:         *-- Enabled = .F. no dump: o campo eh somente EXIBICAO (o conteudo
1059:         *-- vem do cursor via ControlSource, ligado em VincularGradeLog -
1060:         *-- FONTE UNICA do bind, igual ao bloco final do PROCEDURE
1061:         *-- processamento legado, que liga a grade e o fwget1 juntos).
1062:         *-- DisabledBackColor transcrito do dump para o texto desabilitado
1063:         *-- continuar legivel sobre branco.
1064:         loc_oPag.AddObject("txt_4c_Fwget1", "TextBox")
1065:         WITH loc_oPag.txt_4c_Fwget1
1066:             .Top               = 508
1067:             .Left              = 140
1068:             .Width             = 578
1069:             .Height            = 23
1070:             .FontName          = "Tahoma"
1071:             .FontSize          = 8
1072:             .Alignment         = 3
1073:             .MaxLength         = 150
1074:             .Value             = ""
1075:             .Enabled           = .F.
1076:             .BackColor         = RGB(255, 255, 255)
1077:             .DisabledBackColor = RGB(255, 255, 255)
1078:             .TabIndex          = 4
1079:         ENDWITH
1080: 
1081:         THIS.VincularGradeLog()
1082: 
1083:         *----------------------------------------------------------------------
1084:         * FASE 7/8 - BINDEVENT do botao de retorno e da grade.
1085:         *
1086:         * cmg_4c_Voltar.Buttons(1) -> BtnVoltarClick: o "btnDados.Click" do
1087:         * cmdBotoes legado NAO fecha a tela (apesar da legenda "Encerrar" e do
1088:         * icone de sair) - ele desliga a pgResultado e volta para a pagina de
1089:         * filtros; o nome do handler segue a ACAO real.
1090:         *
1091:         * grd_4c_Dados "AfterRowColChange" -> GrdDadosAfterRowColChange, que
1092:         * transcreve o "fwget1.Refresh" do GrdLog legado. O handler declara o
1093:         * par_nColIndex do evento (regra CLAUDE.md #3) e NAO filtra coluna:
1094:         * aqui o objetivo eh acompanhar a linha CORRENTE (regra #46).
1095:         *----------------------------------------------------------------------
1096:         BINDEVENT(loc_oPag.cnt_4c_BotoesAcao.cmg_4c_Voltar.Buttons(1), "Click", ;
1097:                   THIS, "BtnVoltarClick")
1098: 
1099:         BINDEVENT(loc_oPag.grd_4c_Dados, "AfterRowColChange", ;
1100:                   THIS, "GrdDadosAfterRowColChange")
1101:     ENDPROC
1102: 
1103:     *==========================================================================
1104:     * VincularGradeLog - Liga grd_4c_Dados ao cursor de resultado
1105:     * (this_oBusinessObject.this_cCursorLog). Transcrito do bloco final do
1106:     * PROCEDURE processamento legado, que SOBRESCREVE em runtime os headers
1107:     * estaticos do dump do SCX (Column5 e' "Opera??o" ligada a cOpers - a
1108:     * descricao calculada - e nao a Opers crua).
1109:     *
1110:     * ORDEM OBRIGATORIA (regra CLAUDE.md #41/#48): ColumnCount ->
1111:     * RecordSource -> ControlSource -> Width -> Header1.Caption, porque
1112:     * atribuir RecordSource RECALCULA as larguras para o default 90 e
1113:     * zera os captions - vale em TODO site que re-vincula a grade (a
1114:     * repintura da Fase 7/8 chama este MESMO metodo, nao duplica o bind).
1115:     *
1116:     * PUBLIC de proposito (regra CLAUDE.md #1/#51 - o harness da etapa 06b
1117:     * chama metodos do form de FORA da classe).
1118:     *==========================================================================
1119:     PROCEDURE VincularGradeLog()
1120:         LOCAL loc_oGrid, loc_cCursor, loc_lSucesso, loc_oErro
1121: 
1122:         loc_lSucesso = .F.
1123:         loc_cCursor  = THIS.this_oBusinessObject.this_cCursorLog
1124: 
1125:         *-- Column.ControlSource de cursor INEXISTENTE derruba o Init
1126:         *-- (regra CLAUDE.md #41) - o placeholder tem de existir antes.
1127:         IF !USED(loc_cCursor)
1128:             THIS.InicializarCursorLog()
1129:         ENDIF
1130: 
1131:         loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados
1132: 
1133:         TRY
1134:             *-- ColumnCount so eh reatribuido quando DIVERGE de 7: qualquer
1135:             *-- atribuicao recria os objetos Column (regra CLAUDE.md #144).
1136:             IF loc_oGrid.ColumnCount != 7
1137:                 loc_oGrid.ColumnCount = 7
1138:             ENDIF
1139: 
1140:             loc_oGrid.RecordSource = loc_cCursor
1141: 
1142:             loc_oGrid.Column1.ControlSource = loc_cCursor + ".UsuaRedes"
1143:             loc_oGrid.Column2.ControlSource = loc_cCursor + ".Datars"
1144:             loc_oGrid.Column3.ControlSource = loc_cCursor + ".Horas"
1145:             loc_oGrid.Column4.ControlSource = loc_cCursor + ".Progs"
1146:             loc_oGrid.Column5.ControlSource = loc_cCursor + ".cOpers"
1147:             loc_oGrid.Column6.ControlSource = loc_cCursor + ".Usuasis"
1148:             loc_oGrid.Column7.ControlSource = loc_cCursor + ".Parametros"
1149: 
1150:             *-- Width e Header1.Caption DEPOIS do RecordSource/ControlSource
1151:             WITH loc_oGrid.Column1
1152:                 .Width             = 130
1153:                 .Movable           = .F.
1154:                 .Resizable         = .F.
1155:                 .Header1.Caption   = "Usuario Rede"
1156:                 .Header1.Alignment = 2
1157:                 .Header1.ForeColor = RGB(36, 84, 155)
1158:             ENDWITH
1159: 

*-- Linhas 1227 a 2023:
1227:         CATCH TO loc_oErro
1228:             MsgErro(loc_oErro.Message + CHR(13) + ;
1229:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1230:                     "Procedure: " + loc_oErro.Procedure, ;
1231:                     "Erro ao Vincular a Grade do Log")
1232:         ENDTRY
1233: 
1234:         RETURN loc_lSucesso
1235:     ENDPROC
1236: 
1237:     *==========================================================================
1238:     * AlternarPagina - troca a pagina ativa do PageFrame (equivalente a
1239:     * ThisForm.PgfPagina.ActivePage = N no legado). A ida para a Pagina 2
1240:     * (Resultado) so acontece se a consulta ja tiver devolvido linha
1241:     * (equivalente ao "If Eof() Then Return" do PROCEDURE processamento
1242:     * legado - sem isso o legado nunca chega a mudar de pagina); o toggle
1243:     * de Page2.Enabled transcreve o Enabled=.t./.f. que o legado liga/
1244:     * desliga ao entrar/sair da pagina de resultado (processamento liga,
1245:     * btnDados.Click desliga).
1246:     *
1247:     * PUBLIC de proposito (regra CLAUDE.md #1/TesteAutomatico - o harness
1248:     * chama metodos do form direto de fora da classe).
1249:     *==========================================================================
1250:     PROCEDURE AlternarPagina(par_nPagina)
1251:         DO CASE
1252:             CASE par_nPagina = 2
1253:                 IF THIS.this_oBusinessObject.this_nQtdeLog = 0
1254:                     RETURN
1255:                 ENDIF
1256:                 THIS.pgf_4c_Paginas.Page2.Enabled = .T.
1257:                 THIS.pgf_4c_Paginas.ActivePage    = 2
1258:             OTHERWISE
1259:                 THIS.pgf_4c_Paginas.Page2.Enabled = .F.
1260:                 THIS.pgf_4c_Paginas.ActivePage    = par_nPagina
1261:         ENDCASE
1262:     ENDPROC
1263: 
1264:     *==========================================================================
1265:     * FormParaBO - Transfere os 10 filtros da Page1 para as propriedades de
1266:     * filtro de sigopclgBO, na MESMA ordem do bloco "With ThisForm.PgfPagina.
1267:     * PgDados / lcUserRede = .GetUserRede.Value / ..." do PROCEDURE
1268:     * processamento legado.
1269:     *
1270:     * PROTECTED EXPLICITO: FormBase declara este hook como PROTECTED e o VFP9
1271:     * NAO deixa a subclasse ALARGAR o escopo - omitir o modificador nao
1272:     * tornaria o metodo publico, so esconderia o fato (regra CLAUDE.md #51).
1273:     * Chamado sempre por THIS. (regra #8).
1274:     *
1275:     * As datas passam por ConverterParaData(): o TextBox nasce com .Value = {}
1276:     * (DATE) e as propriedades this_dDtIni/this_dDtFin do BO sao DATE, mas o
1277:     * helper normaliza DATE/DATETIME/CHAR e nunca estoura o erro 11 que
1278:     * TTOD() dispararia com um DATE (regra CLAUDE.md #16).
1279:     *
1280:     * As horas vao CRUAS (HHMM, 4 digitos, como o Format "R" + InputMask
1281:     * "99:99" do dump produzem) - eh BuscarLog() que monta o "HH:MM:00" do
1282:     * legado, igual ao Substr(lcHrIni,1,2)+":"+Substr(lcHrIni,3,2)+":00".
1283:     *==========================================================================
1284:     PROTECTED PROCEDURE FormParaBO()
1285:         LOCAL loc_oPag, loc_oBO
1286: 
1287:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1288:         loc_oBO  = THIS.this_oBusinessObject
1289: 
1290:         loc_oBO.this_cUserRede = ALLTRIM(loc_oPag.txt_4c_UserRede.Value)
1291:         loc_oBO.this_dDtIni    = ConverterParaData(loc_oPag.txt_4c_DtIni.Value)
1292:         loc_oBO.this_dDtFin    = ConverterParaData(loc_oPag.txt_4c_DtFin.Value)
1293:         loc_oBO.this_cHrIni    = ALLTRIM(loc_oPag.txt_4c_HrIni.Value)
1294:         loc_oBO.this_cHrFin    = ALLTRIM(loc_oPag.txt_4c_HrFin.Value)
1295:         loc_oBO.this_cPrg      = ALLTRIM(loc_oPag.txt_4c_Prg.Value)
1296:         loc_oBO.this_cOperacao = ALLTRIM(loc_oPag.cbo_4c_GetOperacao.Value)
1297:         loc_oBO.this_cUserSis  = ALLTRIM(loc_oPag.txt_4c_UserSis.Value)
1298:         loc_oBO.this_cParam    = ALLTRIM(loc_oPag.txt_4c_Param.Value)
1299:         loc_oBO.this_cTrans    = ALLTRIM(loc_oPag.txt_4c_Trans.Value)
1300: 
1301:         RETURN .T.
1302:     ENDPROC
1303: 
1304:     *==========================================================================
1305:     * BOParaForm - Sentido inverso de FormParaBO: escreve os 10 filtros das
1306:     * propriedades de sigopclgBO de volta nos controles da Page1.
1307:     *
1308:     * O legado nao tem fluxo que precise disso sozinho (nao ha botao
1309:     * "Limpar" nem reabertura com filtro pre-preenchido) - este metodo
1310:     * existe para completar o par FormParaBO/BOParaForm (convencao do
1311:     * pipeline, presente em todo form) e para LimparCampos, que zera
1312:     * sigopclgBO.this_c*/this_d* e usa este metodo para refletir o estado
1313:     * limpo na tela - mesma convencao de FormSigOpCgr.prg.
1314:     *
1315:     * PROTECTED EXPLICITO: o escopo vem da HERANCA (FormBase declara
1316:     * PROTECTED PROCEDURE BOParaForm) e nao da ausencia do modificador aqui
1317:     * (regra CLAUDE.md #51).
1318:     *==========================================================================
1319:     PROTECTED PROCEDURE BOParaForm()
1320:         LOCAL loc_oPag, loc_oBO, loc_lSucesso, loc_oErro
1321: 
1322:         loc_lSucesso = .F.
1323: 
1324:         TRY
1325:             loc_oPag = THIS.pgf_4c_Paginas.Page1
1326:             loc_oBO  = THIS.this_oBusinessObject
1327: 
1328:             loc_oPag.txt_4c_UserRede.Value    = loc_oBO.this_cUserRede
1329:             loc_oPag.txt_4c_DtIni.Value       = loc_oBO.this_dDtIni
1330:             loc_oPag.txt_4c_DtFin.Value       = loc_oBO.this_dDtFin
1331:             loc_oPag.txt_4c_HrIni.Value       = loc_oBO.this_cHrIni
1332:             loc_oPag.txt_4c_HrFin.Value       = loc_oBO.this_cHrFin
1333:             loc_oPag.txt_4c_Prg.Value         = loc_oBO.this_cPrg
1334:             loc_oPag.cbo_4c_GetOperacao.Value = loc_oBO.this_cOperacao
1335:             loc_oPag.txt_4c_UserSis.Value     = loc_oBO.this_cUserSis
1336:             loc_oPag.txt_4c_Param.Value       = loc_oBO.this_cParam
1337:             loc_oPag.txt_4c_Trans.Value       = loc_oBO.this_cTrans
1338: 
1339:             loc_lSucesso = .T.
1340:         CATCH TO loc_oErro
1341:             MsgErro(loc_oErro.Message + CHR(13) + ;
1342:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1343:                     "Procedure: " + loc_oErro.Procedure, ;
1344:                     "Erro ao Exibir os Filtros na Tela")
1345:         ENDTRY
1346: 
1347:         RETURN loc_lSucesso
1348:     ENDPROC
1349: 
1350:     *==========================================================================
1351:     * LimparCampos - Estado inicial da tela (filtros vazios, sem resultado
1352:     * de pesquisa), chamado no fim de InicializarForm.
1353:     *
1354:     * O legado nao tem botao de "Limpar" - os campos ja nascem vazios no
1355:     * AddObject - mas centralizar o reset em UM metodo (BO.LimparDados() +
1356:     * BOParaForm) segue a mesma convencao de FormSigOpCgr.prg e deixa um
1357:     * unico lugar preparado caso outro fluxo precise zerar a tela no futuro.
1358:     *
1359:     * Fecha reproduzindo ".GetUserRede.SetFocus" do Init legado - guardado
1360:     * por THIS.Visible porque, na chamada feita de dentro de
1361:     * InicializarForm, o form ainda nao foi exibido (SetFocus em controle
1362:     * invisivel estoura), exatamente como no Init legado, que roda antes do
1363:     * Show().
1364:     *
1365:     * PROTECTED EXPLICITO pelo mesmo motivo de FormParaBO/BOParaForm (regra
1366:     * CLAUDE.md #51).
1367:     *==========================================================================
1368:     PROTECTED PROCEDURE LimparCampos()
1369:         LOCAL loc_oPag
1370: 
1371:         THIS.this_oBusinessObject.LimparDados()
1372:         THIS.BOParaForm()
1373: 
1374:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1375: 
1376:         IF THIS.Visible AND THIS.pgf_4c_Paginas.ActivePage = 1 AND ;
1377:            PEMSTATUS(loc_oPag, "txt_4c_UserRede", 5) AND ;
1378:            loc_oPag.txt_4c_UserRede.Enabled
1379:             loc_oPag.txt_4c_UserRede.SetFocus()
1380:         ENDIF
1381:     ENDPROC
1382: 
1383:     *==========================================================================
1384:     * DesvincularGradeLog - Solta grd_4c_Dados e txt_4c_Fwget1 do cursor de
1385:     * resultado ANTES da consulta. Transcricao da PRIMEIRA linha do PROCEDURE
1386:     * processamento legado ("GrdLog.RecordSource = ''").
1387:     *
1388:     * Nao eh cosmetico: BuscarLog() faz USE IN + SQLEXEC sobre o MESMO alias,
1389:     * e SQLEXEC sobre o alias ligado a um Grid ZERA o ColumnCount - a grade
1390:     * vira um retangulo branco sem cabecalho e sem coluna, sem erro e sem log.
1391:     * Soltando antes e re-vinculando depois (VincularGradeLog), a grade
1392:     * sobrevive a troca de cursor.
1393:     *
1394:     * PUBLIC de proposito (regra CLAUDE.md #1/#51 - o harness da etapa 06b
1395:     * chama metodos do form de FORA da classe).
1396:     *==========================================================================
1397:     PROCEDURE DesvincularGradeLog()
1398:         LOCAL loc_oPag, loc_oGrid, loc_nCol
1399: 
1400:         loc_oPag  = THIS.pgf_4c_Paginas.Page2
1401:         loc_oGrid = loc_oPag.grd_4c_Dados
1402: 
1403:         *-- O fwget1 sai primeiro: ControlSource apontando para alias fechado
1404:         *-- nao sobrevive ao USE IN que BuscarLog() faz em seguida.
1405:         IF PEMSTATUS(loc_oPag, "txt_4c_Fwget1", 5)
1406:             loc_oPag.txt_4c_Fwget1.ControlSource = ""
1407:             loc_oPag.txt_4c_Fwget1.Value         = ""
1408:         ENDIF
1409: 
1410:         FOR loc_nCol = 1 TO loc_oGrid.ColumnCount
1411:             loc_oGrid.Columns(loc_nCol).ControlSource = ""
1412:         ENDFOR
1413: 
1414:         loc_oGrid.RecordSource = ""
1415:     ENDPROC
1416: 
1417:     *==========================================================================
1418:     * RepintarGradeLog - Posiciona no inicio do cursor e repinta a grade.
1419:     *
1420:     * Popular o cursor NAO repinta a grade sozinho, e Refresh em pagina
1421:     * OCULTA nao pinta (regra CLAUDE.md #21): por isso este metodo eh
1422:     * chamado DEPOIS de AlternarPagina(2), ou seja depois de a Page2 ja
1423:     * estar ativa, e eh o unico lugar que faz GO TOP + Refresh - FONTE
1424:     * UNICA da repintura, igual VincularGradeLog eh a do bind.
1425:     *
1426:     * PUBLIC de proposito (regra CLAUDE.md #1/#51).
1427:     *==========================================================================
1428:     PROCEDURE RepintarGradeLog()
1429:         LOCAL loc_cCursor, loc_oPag
1430: 
1431:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorLog
1432:         loc_oPag    = THIS.pgf_4c_Paginas.Page2
1433: 
1434:         IF USED(loc_cCursor)
1435:             IF RECCOUNT(loc_cCursor) > 0
1436:                 GO TOP IN (loc_cCursor)
1437:             ENDIF
1438:         ENDIF
1439: 
1440:         loc_oPag.grd_4c_Dados.Refresh()
1441: 
1442:         *-- O fwget1 acompanha a linha corrente da grade (ControlSource no
1443:         *-- cursor): depois de reposicionar, ele tambem precisa repintar.
1444:         IF PEMSTATUS(loc_oPag, "txt_4c_Fwget1", 5)
1445:             loc_oPag.txt_4c_Fwget1.Refresh()
1446:         ENDIF
1447:     ENDPROC
1448: 
1449:     *==========================================================================
1450:     * BtnProcessarClick - Botao "Processar" (Buttons(1) do cmg_4c_Acoes,
1451:     * Command1/btnProcessar do cmdProcessar legado).
1452:     *
1453:     * Transcricao do Click legado, que eh SO a confirmacao mais a chamada do
1454:     * PROCEDURE processamento:
1455:     *
1456:     *   If (MessageBox('Confirma o Processamento?', 4+32+256, ...) = 6)
1457:     *       ThisForm.Processamento      && -> THIS.CarregarLog()
1458:     *   EndIf
1459:     *
1460:     * O 4+32+256 do legado eh Sim/Nao + icone de interrogacao + 2o botao
1461:     * como default, ou seja o MsgConfirma() do projeto (que devolve LOGICO -
1462:     * regra CLAUDE.md #7, NUNCA comparar com 6). Recusando a confirmacao, o
1463:     * legado nao chama Processamento e a tela CONTINUA como estava.
1464:     *
1465:     * O corpo do processamento legado mora em CarregarLog(), que eh o FUNIL
1466:     * unico de carga da grade (regra CLAUDE.md #21/#46): o Click eh so o
1467:     * gatilho, para que qualquer outro caminho que precise repopular a grade
1468:     * use o MESMO metodo e nao uma segunda copia da sequencia.
1469:     *
1470:     * PUBLIC de proposito: eh delegate de BINDEVENT (regra CLAUDE.md #3) e
1471:     * tambem alvo do harness da etapa 06b.
1472:     *==========================================================================
1473:     PROCEDURE BtnProcessarClick()
1474:         LOCAL loc_lResultado
1475: 
1476:         loc_lResultado = .F.
1477: 
1478:         IF MsgConfirma("Confirma o Processamento?", ;
1479:                        "Confirma" + CHR(231) + CHR(227) + "o!!!")
1480:             loc_lResultado = THIS.CarregarLog()
1481:         ENDIF
1482: 
1483:         RETURN loc_lResultado
1484:     ENDPROC
1485: 
1486:     *==========================================================================
1487:     * CarregarLog - FUNIL unico de carga da grade de resultado. Transcricao do
1488:     * "PROCEDURE processamento" legado, da 1a a ultima linha.
1489:     *
1490:     * Metodo UNICO de proposito (regra CLAUDE.md #21/#46): popular cursor NAO
1491:     * repinta a grade sozinho, e a repintura tem de acontecer DEPOIS de a
1492:     * pagina de resultado estar visivel. Deixar essa sequencia inline no
1493:     * handler do botao obrigaria a duplica-la em todo caminho futuro que
1494:     * precise recarregar - e e' exatamente a duplicacao que faz uma das copias
1495:     * esquecer o Refresh e a grade aparecer vazia com o cursor cheio.
1496:     *
1497:     * As duas recusas do processamento legado ficam no BO, que devolve a
1498:     * mensagem pronta em this_cMensagemErro, e cada uma mantem o ICONE do
1499:     * legado:
1500:     *   - nenhum filtro preenchido -> MessageBox(...,16,...) = MsgErro
1501:     *     (BuscarLog devolve .F.)
1502:     *   - consulta sem linha        -> MessageBox(...,64,...) = MsgInfo
1503:     *     (BuscarLog devolve .T. com this_nQtdeLog = 0; o legado faz
1504:     *      "If Eof() / MessageBox / Return" e NAO muda de pagina)
1505:     *
1506:     * Ordem obrigatoria no caminho de sucesso: desvincular -> consultar ->
1507:     * re-vincular (o SQLEXEC recriou o alias) -> trocar de pagina ->
1508:     * repintar (Refresh em pagina oculta nao pinta - regra #21).
1509:     *
1510:     * NUNCA ha RETURN dentro do TRY/CATCH (regra CLAUDE.md #1): o early-exit
1511:     * eh a flag loc_lProsseguir e o RETURN unico fica DEPOIS do ENDTRY.
1512:     *
1513:     * PUBLIC de proposito: alvo do harness da etapa 06b, que chama os metodos
1514:     * de carga de FORA da classe (regra CLAUDE.md #3).
1515:     *==========================================================================
1516:     PROCEDURE CarregarLog()
1517:         LOCAL loc_lProsseguir, loc_oBO, loc_oErro
1518: 
1519:         loc_lProsseguir = .T.
1520:         loc_oBO         = THIS.this_oBusinessObject
1521: 
1522:         TRY
1523:             *-- "GrdLog.RecordSource = ''" - 1a linha do processamento legado
1524:             THIS.DesvincularGradeLog()
1525: 
1526:             THIS.FormParaBO()
1527: 
1528:             IF !loc_oBO.BuscarLog()
1529:                 *-- Nenhum filtro preenchido ou falha de SQL (icone 16 no legado)
1530:                 IF !EMPTY(ALLTRIM(loc_oBO.this_cMensagemErro))
1531:                     MsgErro(loc_oBO.this_cMensagemErro, "Consulta do Log")
1532:                 ENDIF
1533:                 loc_lProsseguir = .F.
1534:             ENDIF
1535: 
1536:             IF loc_lProsseguir
1537:                 IF loc_oBO.this_nQtdeLog = 0
1538:                     *-- "If Eof() / MessageBox(...,64,...) / Return" do legado
1539:                     MsgInfo(IIF(EMPTY(ALLTRIM(loc_oBO.this_cMensagemErro)), ;
1540:                             "Nenhum Registro Encontrado para Sele" + CHR(231) + ;
1541:                             CHR(227) + "o", loc_oBO.this_cMensagemErro), ;
1542:                             "Consulta do Log")
1543:                     loc_lProsseguir = .F.
1544:                 ENDIF
1545:             ENDIF
1546: 
1547:             IF loc_lProsseguir
1548:                 *-- Bloco final do processamento legado: re-liga a grade e o
1549:                 *-- fwget1 ao cursor novo, habilita a pgResultado e vai para
1550:                 *-- ela (AlternarPagina) - e so depois repinta.
1551:                 THIS.VincularGradeLog()
1552:                 THIS.AlternarPagina(2)
1553:                 THIS.RepintarGradeLog()
1554:             ELSE
1555:                 *-- Recusado: o legado deixa a grade solta (o "RecordSource =
1556:                 *-- ''" seguido de Return). Re-vincular ao cursor evita grade
1557:                 *-- orfa se o usuario voltar para a pagina de resultado.
1558:                 THIS.VincularGradeLog()
1559:             ENDIF
1560:         CATCH TO loc_oErro
1561:             MsgErro(loc_oErro.Message + CHR(13) + ;
1562:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1563:                     "Procedure: " + loc_oErro.Procedure, ;
1564:                     "Erro ao Processar a Consulta do Log")
1565:             loc_lProsseguir = .F.
1566:         ENDTRY
1567: 
1568:         RETURN loc_lProsseguir
1569:     ENDPROC
1570: 
1571:     *==========================================================================
1572:     * BtnEncerrarClick - Botao "Encerrar" (Buttons(2) do cmg_4c_Acoes,
1573:     * Command2/btnSair do cmdProcessar legado).
1574:     *
1575:     * Transcricao literal do "PROCEDURE btnSair.Click / ThisForm.Release".
1576:     * A liberacao do poDataMgr que o PROCEDURE Release legado faz nao tem
1577:     * equivalente aqui: a conexao eh a global gnConnHandle, do config.prg, e
1578:     * nao um objeto por tela - o Destroy() do form fecha os cursores proprios
1579:     * e delega o resto a FormBase via DODEFAULT().
1580:     *
1581:     * PUBLIC de proposito: delegate de BINDEVENT (regra CLAUDE.md #3).
1582:     *==========================================================================
1583:     PROCEDURE BtnEncerrarClick()
1584:         THIS.Release()
1585:     ENDPROC
1586: 
1587:     *==========================================================================
1588:     * BtnVoltarClick - Unico botao do cmg_4c_Voltar (Command1/btnDados do
1589:     * cmdBotoes legado, na pgResultado).
1590:     *
1591:     * O nome segue a ACAO e nao a legenda: o botao tem Caption "Encerrar" e
1592:     * icone de sair, mas o Click legado NAO fecha a tela -
1593:     *
1594:     *   ThisForm.PgfPagina.PgResultado.Enabled = .f.
1595:     *   ThisForm.PgfPagina.ActivePage = 1
1596:     *
1597:     * - ele volta para a pagina de filtros. As duas linhas sao exatamente o
1598:     * ramo OTHERWISE de AlternarPagina(), que eh o FUNIL dessa troca.
1599:     *
1600:     * PUBLIC de proposito: delegate de BINDEVENT (regra CLAUDE.md #3).
1601:     *==========================================================================
1602:     PROCEDURE BtnVoltarClick()
1603:         THIS.AlternarPagina(1)
1604:     ENDPROC
1605: 
1606:     *==========================================================================
1607:     * GrdDadosAfterRowColChange - AfterRowColChange do GrdLog legado:
1608:     *
1609:     *   LPARAMETERS nColIndex
1610:     *   ThisForm.PgfPagina.PgResultado.fwget1.Refresh
1611:     *
1612:     * O par_nColIndex EH declarado mesmo sem ser usado: handler de
1613:     * AfterRowColChange ligado por BINDEVENT tem de declarar o parametro do
1614:     * evento (regra CLAUDE.md #3).
1615:     *
1616:     * SEM filtro de coluna, de proposito: este eh justamente o uso CERTO de
1617:     * AfterRowColChange - acompanhar a linha CORRENTE (regra CLAUDE.md #46;
1618:     * validacao de celula iria no Valid do TextBox da Column, e esta grade
1619:     * eh ReadOnly). Alem do Refresh do legado, sincroniza o registro
1620:     * corrente do BO com a linha da grade, que eh o que CarregarDoCursor()
1621:     * existe para fazer.
1622:     *
1623:     * PUBLIC de proposito: delegate de BINDEVENT (regra CLAUDE.md #3).
1624:     *==========================================================================
1625:     PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
1626:         LOCAL loc_cCursor, loc_oPag
1627: 
1628:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorLog
1629:         loc_oPag    = THIS.pgf_4c_Paginas.Page2
1630: 
1631:         IF USED(loc_cCursor)
1632:             IF RECCOUNT(loc_cCursor) > 0 AND !EOF(loc_cCursor)
1633:                 THIS.this_oBusinessObject.CarregarDoCursor(loc_cCursor)
1634:             ENDIF
1635:         ENDIF
1636: 
1637:         *-- "fwget1.Refresh" do legado - a Transacao da linha corrente
1638:         IF PEMSTATUS(loc_oPag, "txt_4c_Fwget1", 5)
1639:             loc_oPag.txt_4c_Fwget1.Refresh()
1640:         ENDIF
1641:     ENDPROC
1642: 
1643:     *==========================================================================
1644:     * ValidarPrgLostFocus - funil do lookup de Programa.
1645:     *
1646:     * Transcricao do PROCEDURE Valid do GetPrg legado:
1647:     *   IF not IsEmpty(This.value)
1648:     *       ThisForm.PoDatamgr.SqlExecute([Select Distinct Programas
1649:     *                   From SigCdPrg Order By Programas],"crSigCdPrg")
1650:     *       SELECT crSigCdPrg / LOCATE FOR Programas = This.Value
1651:     *       If EOF()
1652:     *           xBrow = CreateObject('fwBuscaInt','crSigCdPrg','Programas',
1653:     *                                This.Value,'Progamas',.t.)
1654:     *           xBrow.mAddColuna('Programas','','Programa',.t.) / xBrow.Show
1655:     *       ENDIF
1656:     *       IF LASTKEY()<>27 / This.value = crSigCdPrg.Programas / ENDIF
1657:     *   ENDIF
1658:     *
1659:     * fwBuscaInt = browse sobre cursor LOCAL (ja populado), diferente do
1660:     * fwBuscaExt do GetUserSis, que consulta o SQL Server - por isso aqui o
1661:     * cursor eh populado ANTES (sigopclgBO.BuscarProgramas) e entregue ao
1662:     * FormBuscaAuxiliar pela API DefinirCursor, nao pelo Init com parametros.
1663:     *
1664:     * Wrapper fino com a guarda de reentrancia; o corpo fica no *Exec para
1665:     * a flag ser liberada mesmo nos RETURN antecipados dele (regra CLAUDE.md
1666:     * #47 - set/clear no wrapper, nunca em volta de corpo com RETURN).
1667:     *
1668:     * PUBLIC (sem modificador) porque eh delegate de BINDEVENT: metodo
1669:     * PROTECTED falha em silencio no bind (regra CLAUDE.md #3).
1670:     *==========================================================================
1671:     PROCEDURE ValidarPrgLostFocus()
1672:         IF THIS.this_lEmLookup
1673:             RETURN
1674:         ENDIF
1675: 
1676:         THIS.this_lEmLookup = .T.
1677:         THIS.ValidarPrgLostFocusExec()
1678:         THIS.this_lEmLookup = .F.
1679:     ENDPROC
1680: 
1681:     *==========================================================================
1682:     * ValidarPrgLostFocusExec - corpo do lookup de Programa
1683:     *==========================================================================
1684:     PROTECTED PROCEDURE ValidarPrgLostFocusExec()
1685:         LOCAL loc_oPag, loc_cValor, loc_cCursor
1686: 
1687:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
1688:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_Prg.Value)
1689: 
1690:         *-- "If not IsEmpty(This.value)" do legado: campo vazio nao valida
1691:         *-- nada e nao abre dialogo nenhum.
1692:         IF EMPTY(loc_cValor)
1693:             RETURN
1694:         ENDIF
1695: 
1696:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorProgramas
1697: 
1698:         IF !THIS.this_oBusinessObject.BuscarProgramas(loc_cCursor)
1699:             IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
1700:                 MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Programas")
1701:             ENDIF
1702:             RETURN
1703:         ENDIF
1704: 
1705:         IF !USED(loc_cCursor)
1706:             RETURN
1707:         ENDIF
1708: 
1709:         *-- "SELECT crSigCdPrg / LOCATE FOR Programas = This.Value" do
1710:         *-- legado. Comparacao com == sobre ALLTRIM/UPPER: o SET EXACT ON
1711:         *-- global (config.prg) faz o "=" exigir a chave inteira com o
1712:         *-- padding do char(15), e ai o LOCATE nunca casaria.
1713:         SELECT (loc_cCursor)
1714:         LOCATE FOR UPPER(ALLTRIM(Programas)) == UPPER(loc_cValor)
1715: 
1716:         IF FOUND()
1717:             *-- "This.value = crSigCdPrg.Programas" do legado
1718:             loc_oPag.txt_4c_Prg.Value = ALLTRIM(EVALUATE(loc_cCursor + ".Programas"))
1719:         ELSE
1720:             *-- "If EOF() ... xBrow.Show" do legado
1721:             THIS.ExibirPickerPrg()
1722:         ENDIF
1723:     ENDPROC
1724: 
1725:     *==========================================================================
1726:     * ExibirPickerPrg - browse de Programas sobre o cursor LOCAL ja populado
1727:     * (fwBuscaInt do legado). NAO exibe aviso e NAO apaga o codigo digitado
1728:     * quando o universo esta vazio: universo vazio nao eh erro, e apagar o
1729:     * campo impediria o usuario de preencher (regra CLAUDE.md #50).
1730:     *==========================================================================
1731:     PROTECTED PROCEDURE ExibirPickerPrg()
1732:         LOCAL loc_oPag, loc_cCursor, loc_oBusca, loc_cCodigo
1733: 
1734:         loc_oPag    = THIS.pgf_4c_Paginas.Page1
1735:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorProgramas
1736: 
1737:         IF !USED(loc_cCursor)
1738:             RETURN
1739:         ENDIF
1740: 
1741:         IF RECCOUNT(loc_cCursor) = 0
1742:             RETURN
1743:         ENDIF
1744: 
1745:         *-- O LOCATE que falhou deixou o ponteiro em EOF - o browse tem de
1746:         *-- comecar da primeira linha.
1747:         SELECT (loc_cCursor)
1748:         GO TOP
1749: 
1750:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1751: 
1752:         IF VARTYPE(loc_oBusca) != "O"
1753:             RETURN
1754:         ENDIF
1755: 
1756:         *-- Titulo "Progamas" transcrito LITERALMENTE do legado (o 5o
1757:         *-- argumento do CreateObject('fwBuscaInt',...) tem essa grafia no
1758:         *-- dump) - PILAR 1: o usuario nao deve perceber diferenca.
1759:         loc_oBusca.DefinirCursor(loc_cCursor, "Programas", "Programas", "Progamas")
1760: 
1761:         *-- SigCdPrg.Programas eh coluna UNICA - eh ao mesmo tempo codigo e
1762:         *-- descricao (mesma familia de SigCdOpe.Dopes). DefinirCursor sempre
1763:         *-- adiciona o PAR codigo+descricao, o que aqui exibiria a mesma
1764:         *-- coluna duas vezes; zerar o contador e re-adicionar deixa UMA
1765:         *-- coluna, com o header do legado ("Programa", singular).
1766:         loc_oBusca.this_nColunas = 0
1767:         loc_oBusca.mAddColuna("Programas", "", "Programa")
1768: 
1769:         *-- Mostrar() devolve .T. so quando houve selecao de fato; em ESC/
1770:         *-- Cancelar o codigo digitado pelo usuario eh PRESERVADO, igual ao
1771:         *-- "If LastKey() <> 27" do legado.
1772:         IF loc_oBusca.Mostrar()
1773:             loc_cCodigo = ALLTRIM(loc_oBusca.cCodigoSelecionado)
1774:             IF !EMPTY(loc_cCodigo)
1775:                 loc_oPag.txt_4c_Prg.Value = loc_cCodigo
1776:             ENDIF
1777:         ENDIF
1778: 
1779:         loc_oBusca.Release()
1780:     ENDPROC
1781: 
1782:     *==========================================================================
1783:     * PrgKeyPress - atalho F4 (115) do campo Programa. TESTA a tecla antes de
1784:     * abrir qualquer dialogo (regra CLAUDE.md #47) e declara os dois
1785:     * parametros do evento (regra CLAUDE.md #3).
1786:     *==========================================================================
1787:     PROCEDURE PrgKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1788:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1789:             THIS.AbrirLookupPrg()
1790:         ENDIF
1791:     ENDPROC
1792: 
1793:     *==========================================================================
1794:     * PrgDblClick - duplo clique no campo Programa abre o browse
1795:     *==========================================================================
1796:     PROCEDURE PrgDblClick()
1797:         THIS.AbrirLookupPrg()
1798:     ENDPROC
1799: 
1800:     *==========================================================================
1801:     * AbrirLookupPrg - entrada direta no browse de Programas (F4/DblClick):
1802:     * abre a lista independente do que esta digitado, sem o LOCATE do
1803:     * LostFocus.
1804:     *
1805:     * Guarda SAVE/RESTORE em vez de set/clear (regra CLAUDE.md #47): este
1806:     * metodo tambem pode ser alcancado com o funil do LostFocus ja em curso,
1807:     * e um clear simples liberaria a flag cedo demais.
1808:     *==========================================================================
1809:     PROCEDURE AbrirLookupPrg()
1810:         LOCAL loc_lEmLookupAnt
1811: 
1812:         loc_lEmLookupAnt    = THIS.this_lEmLookup
1813:         THIS.this_lEmLookup = .T.
1814:         THIS.AbrirLookupPrgExec()
1815:         THIS.this_lEmLookup = loc_lEmLookupAnt
1816:     ENDPROC
1817: 
1818:     *==========================================================================
1819:     * AbrirLookupPrgExec - corpo de AbrirLookupPrg
1820:     *==========================================================================
1821:     PROTECTED PROCEDURE AbrirLookupPrgExec()
1822:         LOCAL loc_cCursor
1823: 
1824:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorProgramas
1825: 
1826:         IF !THIS.this_oBusinessObject.BuscarProgramas(loc_cCursor)
1827:             IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
1828:                 MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Programas")
1829:             ENDIF
1830:             RETURN
1831:         ENDIF
1832: 
1833:         THIS.ExibirPickerPrg()
1834:     ENDPROC
1835: 
1836:     *==========================================================================
1837:     * ValidarUserSisLostFocus - funil do lookup de Usuario do Sistema.
1838:     *
1839:     * Transcricao do PROCEDURE Valid do GetUserSis legado:
1840:     *   If not IsEmpty(This.value)
1841:     *       xBrox = CreateObject('fwBuscaExt',Thisform.poDatamgr.pnIdconn,
1842:     *                            'SigCdUsu','crSigCdUsu','Usuarios',
1843:     *                            This.Value,'Sele??o',.t.,'Usuarios')
1844:     *       If Not xBrox.plAchouRegistro
1845:     *           xBrox.mAddColuna('Usuarios','','Usu?rios',.t.) / xBrox.Show()
1846:     *       EndIf
1847:     *       If lastkey()<>27
1848:     *           This.value = evaluate("crSigCdUsu.Usuarios") / This.Refresh
1849:     *       endif
1850:     *   endif
1851:     *
1852:     * fwBuscaExt consulta o SQL Server por conta propria, exatamente como o
1853:     * Init com parametros do FormBuscaAuxiliar - por isso aqui NAO ha
1854:     * SQLEXEC nem LOCATE no form (duplicar a checagem de existencia so cria
1855:     * um caminho para divergir - regra CLAUDE.md #37).
1856:     *
1857:     * PUBLIC: delegate de BINDEVENT (regra CLAUDE.md #3).
1858:     *==========================================================================
1859:     PROCEDURE ValidarUserSisLostFocus()
1860:         IF THIS.this_lEmLookup
1861:             RETURN
1862:         ENDIF
1863: 
1864:         THIS.this_lEmLookup = .T.
1865:         THIS.ValidarUserSisLostFocusExec()
1866:         THIS.this_lEmLookup = .F.
1867:     ENDPROC
1868: 
1869:     *==========================================================================
1870:     * ValidarUserSisLostFocusExec - corpo do lookup de Usuario do Sistema
1871:     *==========================================================================
1872:     PROTECTED PROCEDURE ValidarUserSisLostFocusExec()
1873:         LOCAL loc_oPag, loc_cValor
1874: 
1875:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
1876:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_UserSis.Value)
1877: 
1878:         *-- "If not IsEmpty(This.value)" do legado
1879:         IF EMPTY(loc_cValor)
1880:             RETURN
1881:         ENDIF
1882: 
1883:         THIS.ExibirPickerUserSis(loc_cValor)
1884:     ENDPROC
1885: 
1886:     *==========================================================================
1887:     * ExibirPickerUserSis - lookup de SigCdUsu.Usuarios (fwBuscaExt legado)
1888:     *==========================================================================
1889:     PROTECTED PROCEDURE ExibirPickerUserSis(par_cValor)
1890:         LOCAL loc_oPag, loc_cCursor, loc_cValor, loc_oBusca, loc_cCodigo
1891: 
1892:         loc_oPag    = THIS.pgf_4c_Paginas.Page1
1893:         loc_cCursor = "cursor_4c_BuscaUsuario"
1894:         loc_cValor  = IIF(VARTYPE(par_cValor) = "C", ALLTRIM(par_cValor), "")
1895: 
1896:         *-- 1o argumento = HANDLE da conexao (regra CLAUDE.md #36): passar a
1897:         *-- tabela ali desloca TODOS os argumentos e o picker abre vazio sem
1898:         *-- erro nenhum. O 9o argumento do fwBuscaExt legado ('Usuarios') NAO
1899:         *-- eh transcrito: no FormBuscaAuxiliar aquela posicao eh um filtro
1900:         *-- WHERE adicional, e "Usuarios" ali geraria SQL invalido.
1901:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1902:             "SigCdUsu", loc_cCursor, "Usuarios", loc_cValor, ;
1903:             "Sele" + CHR(231) + CHR(227) + "o")
1904: 
1905:         IF VARTYPE(loc_oBusca) != "O"
1906:             RETURN
1907:         ENDIF
1908: 
1909:         *-- Contrato do FormBuscaAuxiliar (regra CLAUDE.md #37): o Init ja
1910:         *-- tentou o match EXATO; achando 1 registro, o valor esta resolvido
1911:         *-- e o dialogo NAO deve aparecer - equivale ao
1912:         *-- "If Not xBrox.plAchouRegistro" do legado.
1913:         IF !loc_oBusca.this_lAchouRegistro
1914:             loc_oBusca.mAddColuna("Usuarios", "", "Usu" + CHR(225) + "rios")
1915:             loc_oBusca.Show()
1916:         ENDIF
1917: 
1918:         *-- "If lastkey()<>27 / This.value = evaluate('crSigCdUsu.Usuarios')"
1919:         *-- do legado: atribui SO sob a guarda de selecao. Atribuir fora dela
1920:         *-- ZERARIA o codigo que o usuario digitou (regra CLAUDE.md #37/#50).
1921:         IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
1922:             SELECT (loc_cCursor)
1923:             loc_cCodigo = ALLTRIM(EVALUATE(loc_cCursor + ".Usuarios"))
1924:             IF !EMPTY(loc_cCodigo)
1925:                 loc_oPag.txt_4c_UserSis.Value = loc_cCodigo
1926:             ENDIF
1927:         ENDIF
1928: 
1929:         loc_oBusca.Release()
1930: 
1931:         *-- Cursor do lookup eh descartavel: fechado aqui para a proxima
1932:         *-- consulta nascer limpa (o alias nao alimenta grade nenhuma).
1933:         IF USED(loc_cCursor)
1934:             IF CURSORGETPROP("Buffering", loc_cCursor) > 1
1935:                 TABLEREVERT(.T., loc_cCursor)
1936:             ENDIF
1937:             USE IN (loc_cCursor)
1938:         ENDIF
1939:     ENDPROC
1940: 
1941:     *==========================================================================
1942:     * UserSisKeyPress - atalho F4 (115) do campo Usuario do Sistema
1943:     *==========================================================================
1944:     PROCEDURE UserSisKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1945:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1946:             THIS.AbrirLookupUserSis()
1947:         ENDIF
1948:     ENDPROC
1949: 
1950:     *==========================================================================
1951:     * UserSisDblClick - duplo clique no campo Usuario do Sistema
1952:     *==========================================================================
1953:     PROCEDURE UserSisDblClick()
1954:         THIS.AbrirLookupUserSis()
1955:     ENDPROC
1956: 
1957:     *==========================================================================
1958:     * AbrirLookupUserSis - entrada direta no lookup de Usuario do Sistema
1959:     * (F4/DblClick). Guarda SAVE/RESTORE (regra CLAUDE.md #47).
1960:     *==========================================================================
1961:     PROCEDURE AbrirLookupUserSis()
1962:         LOCAL loc_lEmLookupAnt
1963: 
1964:         loc_lEmLookupAnt    = THIS.this_lEmLookup
1965:         THIS.this_lEmLookup = .T.
1966:         THIS.AbrirLookupUserSisExec()
1967:         THIS.this_lEmLookup = loc_lEmLookupAnt
1968:     ENDPROC
1969: 
1970:     *==========================================================================
1971:     * AbrirLookupUserSisExec - corpo de AbrirLookupUserSis
1972:     *==========================================================================
1973:     PROTECTED PROCEDURE AbrirLookupUserSisExec()
1974:         LOCAL loc_oPag
1975: 
1976:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1977:         THIS.ExibirPickerUserSis(ALLTRIM(loc_oPag.txt_4c_UserSis.Value))
1978:     ENDPROC
1979: 
1980:     *==========================================================================
1981:     * TornarControlesVisiveis - AddObject cria controles com Visible=.F.
1982:     * por padrao; percorre Pages (PageFrame) e Controls (Container)
1983:     * recursivamente tornando tudo visivel apos a montagem.
1984:     *==========================================================================
1985:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1986:         LOCAL loc_nI, loc_oObjeto, loc_nP
1987: 
1988:         IF VARTYPE(par_oContainer) != "O"
1989:             RETURN
1990:         ENDIF
1991: 
1992:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1993:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1994: 
1995:             IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1996:                 loc_oObjeto.Visible = .T.
1997:             ENDIF
1998: 
1999:             IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
2000:                 FOR loc_nP = 1 TO loc_oObjeto.PageCount
2001:                     THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
2002:                 ENDFOR
2003:             ENDIF
2004: 
2005:             IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
2006:                 THIS.TornarControlesVisiveis(loc_oObjeto)
2007:             ENDIF
2008:         ENDFOR
2009:     ENDPROC
2010: 
2011:     *==========================================================================
2012:     * Destroy - cursor_4c_Log (Fase 4), cursor_4c_Programas e
2013:     * cursor_4c_BuscaUsuario (Fase 6, lookups de Programa e de Usuario do
2014:     * Sistema) nao precisam de USE IN explicito: DataSession=2
2015:     * eh sessao de dados PRIVADA do form, e o VFP9 fecha todos os cursores
2016:     * dela junto com a sessao, ao destruir o form. FormBase.Destroy() ja
2017:     * zera this_oBusinessObject e restaura o menu principal.
2018:     *==========================================================================
2019:     PROCEDURE Destroy()
2020:         DODEFAULT()
2021:     ENDPROC
2022: 
2023: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigopclgBO.prg):
*============================================================================
* sigopclgBO.prg - Business Object para Consulta do Log (SigOpLog)
*
* Tabela principal : SigOpLog (PK: cidchaves char(20))
* Form OPERACIONAL de consulta - o legado SIGOPCLG nao grava em tabela
* nenhuma: o PROCEDURE Processamento monta um SELECT dinamico conforme os
* filtros preenchidos e exibe o resultado na Page "Resultado".
*
* Lookups usados pelo form (nao persistidos nesta entidade):
*   GetPrg.Valid     -> SigCdPrg.Programas (lista de programas)
*   GetUserSis.Valid -> SigCdUsu.Usuarios  (usuario do sistema)
*
* Herda de: BusinessBase
* Fase 1: propriedades de filtro + Init + BuscarLog
* Fase 2: CarregarDoCursor (TODAS as colunas de SigOpLog), ObterChavePrimaria,
*         DescreverOperacao, LimparRegistro, LimparDados e BuscarProgramas
*============================================================================

DEFINE CLASS sigopclgBO AS BusinessBase

    *==========================================================================
    * Propriedades de filtro (espelham os campos da Page "Dados" do legado)
    *==========================================================================
    this_cUserRede = ""    && char(20) - Usuario de Rede (filtro SigOpLog.Usuaredes =)
    this_dDtIni    = {}    && date     - Periodo: data inicial (filtro SigOpLog.Datars >=)
    this_dDtFin    = {}    && date     - Periodo: data final (filtro SigOpLog.Datars <=)
    this_cHrIni    = ""    && char(4)  - Horario de Acesso inicial, HHMM (Format "R" + InputMask 99:99)
    this_cHrFin    = ""    && char(4)  - Horario de Acesso final, HHMM (Format "R" + InputMask 99:99)
    this_cPrg      = ""    && char(20) - Programa (filtro SigOpLog.Progs =; lookup SigCdPrg.Programas)
    this_cOperacao = ""    && char(20) - Operacao: "Liberacao"/"Entrada"/"Saida"/"Transacao" (filtro SigOpLog.Opers)
    this_cUserSis  = ""    && char(20) - Usuario do Sistema (filtro SigOpLog.Usuasis =; lookup SigCdUsu.Usuarios)
    this_cParam    = ""    && char(10) - Parametros (filtro SigOpLog.Parametros LIKE "valor%")
    this_cTrans    = ""    && char(100) - Transacao (filtro SigOpLog.Transacaos LIKE "valor%")

    *==========================================================================
    * Resultado da consulta (grid da Page "Resultado")
    *==========================================================================
    this_cCursorLog       = "cursor_4c_Log"        && Alias do cursor com o resultado da pesquisa
    this_cCursorProgramas = "cursor_4c_Programas"  && Alias do cursor do lookup de Programas (SigCdPrg)
    this_nQtdeLog         = 0                      && Quantidade de linhas retornadas pela ultima pesquisa

    *==========================================================================
    * Registro corrente do Log - TODAS as colunas de SigOpLog mais a descricao
    * calculada cOpers. Preenchidas por CarregarDoCursor() a partir da linha
    * corrente do cursor do grid (o legado usa o proprio cursor como
    * ControlSource das 7 colunas do GrdLog e do fwget1 da Transacao; estas
    * propriedades existem para o form ler o registro selecionado sem precisar
    * tocar o cursor direto).
    *
    * Os nomes espelham as colunas do schema (docs/schema.sql):
    *   usuaredes  char(20)  NOT NULL | datars     datetime NULL  | horas    char(8)  NOT NULL
    *   progs      char(20)  NOT NULL | opers      char(1)  NOT NULL | usuasis char(20) NOT NULL
    *   parametros char(10)  NOT NULL | transacaos char(100) NOT NULL| cversaos char(70) NOT NULL
    *   cidchaves  char(20)  NOT NULL | copias     bit      NOT NULL
    *==========================================================================
    this_cUsuaRedes    = ""    && usuaredes  - Usuario de rede que gerou o registro
    this_dDatars       = {}    && datars     - Data do acesso (a hora fica em this_cHoras)
    this_cHoras        = ""    && horas      - Hora do acesso, formato HH:MM:SS
    this_cProgs        = ""    && progs      - Programa acessado
    this_cOpers        = ""    && opers      - Codigo da operacao: E, S, L ou outro
    this_cUsuaSis      = ""    && usuasis    - Usuario do sistema
    this_cParametros   = ""    && parametros - Parametros da chamada
    this_cTransacaos   = ""    && transacaos - Transacao registrada
    this_cCVersaos     = ""    && cversaos   - Versao do executavel que gravou o log
    this_cCidChaves    = ""    && cidchaves  - Chave primaria do registro
    this_nCopias       = 0     && copias     - Coluna bit: 1 ou 0 (bit chega Logico ou Numerico conforme o driver)
    this_cOperacaoDesc = ""    && cOpers     - Descricao da operacao (Entrada/Saida/Liberacao/Transacao)

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigOpLog"
            THIS.this_cCampoChave = "cidchaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BuscarLog - Monta a consulta dinamica do Log de Acessos conforme os
    * filtros preenchidos pelo usuario (equivalente ao PROCEDURE Processamento
    * do legado SIGOPCLG) e popula THIS.this_cCursorLog ("cursor_4c_Log").
    *
    * Cada filtro so entra no WHERE se a propriedade correspondente estiver
    * preenchida (mesma logica condicional do legado, transcrita literalmente -
    * inclusive o guard de "nenhum parametro preenchido" e o mapeamento de
    * Operacao para o codigo de 1 letra gravado em Opers).
    *
    * Retorna .T. quando a consulta foi executada (mesmo com zero linhas) e
    * .F. quando nenhum filtro foi informado ou o SQL falhou; nos dois casos
    * de falha THIS.this_cMensagemErro traz o motivo, para o form decidir
    * entre MsgAviso (validacao) e MsgErro (falha tecnica) - este BO nao
    * chama MsgAviso/MsgErro diretamente nesse caminho.
    *
    * Responsabilidade do FORM apos chamar este metodo (Problema 48): limpar
    * e reatribuir Grid.RecordSource + cada Column.ControlSource +
    * Column.Header1.Caption, porque o SQLEXEC recria o cursor a cada busca -
    * exatamente como o legado faz em Processamento (RecordSource = '' no
    * inicio do metodo, RecordSource + ControlSource de novo no fim).
    *==========================================================================
    PROCEDURE BuscarLog()
        LOCAL loc_lResultado, loc_cSQL, loc_cWhere, loc_cHrIniSQL, loc_cHrFinSQL
        LOCAL loc_cOperFiltro, loc_dDtFinCompleta, loc_nResultado, loc_oErro

        loc_lResultado = .F.
        THIS.this_cMensagemErro = ""
        THIS.this_nQtdeLog = 0

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cUserRede))  AND ;
               EMPTY(THIS.this_dDtIni)              AND ;
               EMPTY(THIS.this_dDtFin)              AND ;
               EMPTY(ALLTRIM(THIS.this_cHrIni))     AND ;
               EMPTY(ALLTRIM(THIS.this_cHrFin))     AND ;
               EMPTY(ALLTRIM(THIS.this_cPrg))       AND ;
               EMPTY(ALLTRIM(THIS.this_cOperacao))  AND ;
               EMPTY(ALLTRIM(THIS.this_cUserSis))   AND ;
               EMPTY(ALLTRIM(THIS.this_cParam))     AND ;
               EMPTY(ALLTRIM(THIS.this_cTrans))

                THIS.this_cMensagemErro = "Pesquisa n" + CHR(227) + "o pode ser realizada," + CHR(13) + ;
                    "Nenhum Parametro de Sele" + CHR(231) + CHR(227) + "o foi Preenchido"
                loc_lResultado = .F.

            ELSE

                *-- Monta o WHERE dinamico - so entra o que o usuario preencheu
                loc_cWhere = ""

                IF !EMPTY(ALLTRIM(THIS.this_cUserRede))
                    loc_cWhere = loc_cWhere + " UsuaRedes = " + EscaparSQL(ALLTRIM(THIS.this_cUserRede))
                ENDIF

                IF !EMPTY(THIS.this_dDtIni)
                    loc_cWhere = loc_cWhere + IIF(!EMPTY(loc_cWhere), " AND", "") + ;
                        " Datars >= " + FormatarDataSQL(THIS.this_dDtIni)
                ENDIF

                IF !EMPTY(THIS.this_dDtFin)
                    *-- Legado soma 23:59:59 ao fim do periodo (fDtoSQL(ldDtFin,'23:59:59'))
                    loc_dDtFinCompleta = DATETIME(YEAR(THIS.this_dDtFin), MONTH(THIS.this_dDtFin), ;
                        DAY(THIS.this_dDtFin), 23, 59, 59)
                    loc_cWhere = loc_cWhere + IIF(!EMPTY(loc_cWhere), " AND", "") + ;
                        " Datars <= " + FormatarDataSQL(loc_dDtFinCompleta)
                ENDIF

                IF !EMPTY(ALLTRIM(THIS.this_cHrIni))
                    loc_cHrIniSQL = PADL(ALLTRIM(THIS.this_cHrIni), 4, "0")
                    loc_cWhere = loc_cWhere + IIF(!EMPTY(loc_cWhere), " AND", "") + ;
                        " Horas >= " + EscaparSQL(SUBSTR(loc_cHrIniSQL, 1, 2) + ":" + SUBSTR(loc_cHrIniSQL, 3, 2) + ":00")
                ENDIF

                IF !EMPTY(ALLTRIM(THIS.this_cHrFin))
                    loc_cHrFinSQL = PADL(ALLTRIM(THIS.this_cHrFin), 4, "0")
                    loc_cWhere = loc_cWhere + IIF(!EMPTY(loc_cWhere), " AND", "") + ;
                        " Horas <= " + EscaparSQL(SUBSTR(loc_cHrFinSQL, 1, 2) + ":" + SUBSTR(loc_cHrFinSQL, 3, 2) + ":00")
                ENDIF

                IF !EMPTY(ALLTRIM(THIS.this_cPrg))
                    loc_cWhere = loc_cWhere + IIF(!EMPTY(loc_cWhere), " AND", "") + ;
                        " Progs = " + EscaparSQL(ALLTRIM(THIS.this_cPrg))
                ENDIF

                IF !EMPTY(ALLTRIM(THIS.this_cOperacao))
                    *-- Mapeamento identico ao legado: Entrada=E, Saida=S, Liberacao=L,
                    *-- qualquer outra opcao (Transacao) = nenhum dos tres codigos acima.
                    *-- Medido no VFP9 em 2026-10-29: UPPER() converte os acentos
                    *-- (CHR(231) -> CHR(199), CHR(227) -> CHR(195)), por isso a comparacao
                    *-- com "LIBERA" + CHR(199) + CHR(195) + "O" casa com a opcao acentuada
                    *-- escolhida no ComboBox, igual ao Upper(lcOperacao) do legado.
                    DO CASE
                        CASE UPPER(ALLTRIM(THIS.this_cOperacao)) == "ENTRADA"
                            loc_cOperFiltro = " Opers = 'E'"
                        CASE UPPER(ALLTRIM(THIS.this_cOperacao)) == "SAIDA"
                            loc_cOperFiltro = " Opers = 'S'"
                        CASE UPPER(ALLTRIM(THIS.this_cOperacao)) == "LIBERA" + CHR(199) + CHR(195) + "O"
                            loc_cOperFiltro = " Opers = 'L'"
                        OTHERWISE
                            loc_cOperFiltro = " Opers <> 'E' AND Opers <> 'S' AND Opers <> 'L'"
                    ENDCASE
                    loc_cWhere = loc_cWhere + IIF(!EMPTY(loc_cWhere), " AND", "") + loc_cOperFiltro
                ENDIF

                IF !EMPTY(ALLTRIM(THIS.this_cUserSis))
                    loc_cWhere = loc_cWhere + IIF(!EMPTY(loc_cWhere), " AND", "") + ;
                        " Usuasis = " + EscaparSQL(ALLTRIM(THIS.this_cUserSis))
                ENDIF

                IF !EMPTY(ALLTRIM(THIS.this_cParam))
                    loc_cWhere = loc_cWhere + IIF(!EMPTY(loc_cWhere), " AND", "") + ;
                        " Parametros LIKE " + EscaparSQL(ALLTRIM(THIS.this_cParam) + "%")
                ENDIF

                IF !EMPTY(ALLTRIM(THIS.this_cTrans))
                    loc_cWhere = loc_cWhere + IIF(!EMPTY(loc_cWhere), " AND", "") + ;
                        " Transacaos LIKE " + EscaparSQL(ALLTRIM(THIS.this_cTrans) + "%")
                ENDIF

                *-- Colunas: cOpers (descricao calculada) primeiro, depois TODAS as
                *-- colunas de SigOpLog - o legado faz [Select '          ' As cOpers, a.*].
                *-- A descricao sai de um CASE no proprio SELECT porque cursor de SQL
                *-- pass-through nasce somente-leitura no VFP e o
                *-- "Replace All cOpers With Iif(...)" do legado nao teria onde gravar;
                *-- o mapeamento eh o MESMO de THIS.DescreverOperacao().
                loc_cSQL = "SELECT " + ;
                    "CASE a.Opers " + ;
                        "WHEN 'E' THEN 'Entrada' " + ;
                        "WHEN 'S' THEN 'Saida' " + ;
                        "WHEN 'L' THEN 'Libera" + CHR(231) + CHR(227) + "o' " + ;
                        "ELSE 'Transa" + CHR(231) + CHR(227) + "o' " + ;
                    "END AS cOpers, " + ;
                    "a.UsuaRedes, a.Datars, a.Horas, a.Progs, a.Opers, a.Usuasis, " + ;
                    "a.Parametros, a.Transacaos, a.CVersaos, a.cidchaves, a.Copias " + ;
                    "FROM SigOpLog a " + ;
                    "WHERE " + loc_cWhere

                IF USED(THIS.this_cCursorLog)
                    IF CURSORGETPROP("Buffering", THIS.this_cCursorLog) > 1
                        TABLEREVERT(.T., THIS.this_cCursorLog)
                    ENDIF
                    USE IN (THIS.this_cCursorLog)
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorLog)

                IF loc_nResultado >= 0
                    SELECT (THIS.this_cCursorLog)
                    GO TOP
                    THIS.this_nQtdeLog = RECCOUNT()

                    IF THIS.this_nQtdeLog = 0
                        THIS.this_cMensagemErro = "Nenhum Registro Encontrado para Sele" + CHR(231) + CHR(227) + "o"
                        THIS.LimparRegistro()
                    ELSE
                        *-- Deixa o registro corrente do BO espelhando a 1a linha da grade
                        THIS.CarregarDoCursor(THIS.this_cCursorLog)
                    ENDIF

                    loc_lResultado = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao executar a pesquisa do Log:" + CHR(13) + CapturarErroSQL()
                    loc_lResultado = .F.
                ENDIF

            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao executar a pesquisa do Log: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega a linha CORRENTE do cursor do resultado para
    * as propriedades do registro, mapeando TODAS as colunas de SigOpLog mais
    * a descricao calculada cOpers.
    *
    * par_cCursor eh opcional: sem ele usa THIS.this_cCursorLog.
    *
    * Chamado pelo form no AfterRowColChange do GrdLog - no legado esse evento
    * faz "ThisForm.PgfPagina.PgResultado.fwget1.Refresh", porque o fwget1 da
    * Transacao tem ControlSource no cursor; aqui o form le
    * THIS.this_cTransacaos depois desta chamada.
    *
    * O alias que estava selecionado eh restaurado no fim, para a chamada nao
    * mexer na area de trabalho corrente de quem chamou.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cCursor)
        LOCAL loc_lResultado, loc_cAlias, loc_cAliasAnterior, loc_uCopias, loc_oErro

        loc_lResultado = .F.
        loc_cAliasAnterior = ALIAS()
        THIS.this_cMensagemErro = ""

        TRY
            IF VARTYPE(par_cCursor) = "C" AND !EMPTY(ALLTRIM(par_cCursor))
                loc_cAlias = ALLTRIM(par_cCursor)
            ELSE
                loc_cAlias = THIS.this_cCursorLog
            ENDIF

            DO CASE
                CASE !USED(loc_cAlias)
                    THIS.this_cMensagemErro = "Cursor [" + loc_cAlias + "] n" + CHR(227) + ;
                        "o est" + CHR(225) + " aberto para leitura do Log."

                CASE RECCOUNT(loc_cAlias) = 0
                    THIS.this_cMensagemErro = "Cursor [" + loc_cAlias + "] n" + CHR(227) + ;
                        "o possui registros."
                    THIS.LimparRegistro()

                OTHERWISE
                    SELECT (loc_cAlias)

                    IF EOF() OR BOF()
                        GO TOP
                    ENDIF

                    THIS.this_cUsuaRedes  = ALLTRIM(TratarNulo(UsuaRedes, ""))
                    THIS.this_dDatars     = ConverterParaData(TratarNulo(Datars, {}))
                    THIS.this_cHoras      = ALLTRIM(TratarNulo(Horas, ""))
                    THIS.this_cProgs      = ALLTRIM(TratarNulo(Progs, ""))
                    THIS.this_cOpers      = TratarNulo(Opers, "")
                    THIS.this_cUsuaSis    = ALLTRIM(TratarNulo(Usuasis, ""))
                    THIS.this_cParametros = ALLTRIM(TratarNulo(Parametros, ""))
                    THIS.this_cTransacaos = ALLTRIM(TratarNulo(Transacaos, ""))
                    THIS.this_cCVersaos   = ALLTRIM(TratarNulo(CVersaos, ""))
                    THIS.this_cCidChaves  = ALLTRIM(TratarNulo(cidchaves, ""))

                    *-- copias eh coluna bit: conforme o driver chega Logico (.T./.F.)
                    *-- ou Numerico (0/1), por isso testar VARTYPE antes de usar o valor
                    loc_uCopias = NVL(Copias, 0)
                    IF VARTYPE(loc_uCopias) = "L"
                        THIS.this_nCopias = IIF(loc_uCopias, 1, 0)
                    ELSE
                        THIS.this_nCopias = loc_uCopias
                    ENDIF

                    *-- cOpers so existe no cursor vindo de BuscarLog(); vindo de outro
                    *-- lugar, a descricao sai do mesmo mapeamento usado pelo legado
                    IF TYPE(loc_cAlias + ".cOpers") == "C"
                        THIS.this_cOperacaoDesc = ALLTRIM(TratarNulo(cOpers, ""))
                    ELSE
                        THIS.this_cOperacaoDesc = THIS.DescreverOperacao(THIS.this_cOpers)
                    ENDIF

                    loc_lResultado = .T.
            ENDCASE
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar o registro do Log: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lResultado = .F.
        ENDTRY

        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * DescreverOperacao - Converte o codigo gravado em SigOpLog.Opers na
    * descricao exibida na coluna "Operacao" do grid.
    *
    * Transcricao do legado (PROCEDURE Processamento):
    *   Replace All cOpers With Iif(Opers='E','Entrada',Iif(Opers='S','Saida',
    *               Iif(Opers='L','Liberacao','Transacao')))
    *==========================================================================
    PROCEDURE DescreverOperacao(par_cOpers)
        LOCAL loc_cCodigo, loc_cDescricao

        IF VARTYPE(par_cOpers) = "C"
            loc_cCodigo = UPPER(ALLTRIM(par_cOpers))
        ELSE
            loc_cCodigo = ""
        ENDIF

        DO CASE
            CASE loc_cCodigo == "E"
                loc_cDescricao = "Entrada"
            CASE loc_cCodigo == "S"
                loc_cDescricao = "Saida"
            CASE loc_cCodigo == "L"
                loc_cDescricao = "Libera" + CHR(231) + CHR(227) + "o"
            OTHERWISE
                loc_cDescricao = "Transa" + CHR(231) + CHR(227) + "o"
        ENDCASE

        RETURN loc_cDescricao
    ENDPROC

    *==========================================================================
    * BuscarProgramas - Popula o cursor do lookup de Programas usado pelo
    * Valid do campo Programa (GetPrg) do legado:
    *   SqlExecute([Select Distinct Programas From SigCdPrg Order By Programas],
    *              "crSigCdPrg")
    *
    * par_cCursor eh opcional: sem ele usa THIS.this_cCursorProgramas.
    * Retorna .T. quando a consulta rodou (mesmo com zero linhas).
    *
    * Nos dois caminhos de falha (SQL e excecao) o motivo fica em
    * THIS.this_cMensagemErro e quem EXIBE eh o FORM - mesma convencao
    * documentada em BuscarLog, deste mesmo BO. A excecao NAO eh engolida: o
    * unico chamador (o lookup de Programa em Formsigopclg) reporta com
    * MsgErro, e exibir aqui TAMBEM empilharia dois dialogos sobre a mesma
    * falha (regra CLAUDE.md #20 - fonte unica de reporte).
    *==========================================================================
    PROCEDURE BuscarProgramas(par_cCursor)
        LOCAL loc_lResultado, loc_cAlias, loc_cSQL, loc_nResultado, loc_oErro

        loc_lResultado = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF VARTYPE(par_cCursor) = "C" AND !EMPTY(ALLTRIM(par_cCursor))
                loc_cAlias = ALLTRIM(par_cCursor)
            ELSE
                loc_cAlias = THIS.this_cCursorProgramas
            ENDIF

            loc_cSQL = "SELECT DISTINCT Programas FROM SigCdPrg ORDER BY Programas"

            IF USED(loc_cAlias)
                IF CURSORGETPROP("Buffering", loc_cAlias) > 1
                    TABLEREVERT(.T., loc_cAlias)
                ENDIF
                USE IN (loc_cAlias)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

            IF loc_nResultado >= 0
                SELECT (loc_cAlias)
                GO TOP
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao carregar a lista de Programas:" + CHR(13) + CapturarErroSQL()
                loc_lResultado = .F.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar a lista de Programas: " + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * LimparRegistro - Zera somente as propriedades do registro corrente do
    * Log, preservando os filtros digitados pelo usuario (usado quando a
    * pesquisa nao retorna linha nenhuma)
    *==========================================================================
    PROCEDURE LimparRegistro()
        THIS.this_cUsuaRedes    = ""
        THIS.this_dDatars       = {}
        THIS.this_cHoras        = ""
        THIS.this_cProgs        = ""
        THIS.this_cOpers        = ""
        THIS.this_cUsuaSis      = ""
        THIS.this_cParametros   = ""
        THIS.this_cTransacaos   = ""
        THIS.this_cCVersaos     = ""
        THIS.this_cCidChaves    = ""
        THIS.this_nCopias       = 0
        THIS.this_cOperacaoDesc = ""
    ENDPROC

    *==========================================================================
    * LimparDados - Zera filtros e registro corrente, deixando o BO como na
    * abertura da tela (o form chama este metodo ao voltar da Page "Resultado"
    * para a Page "Dados", para a consulta seguinte comecar limpa)
    *==========================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cUserRede = ""
        THIS.this_dDtIni    = {}
        THIS.this_dDtFin    = {}
        THIS.this_cHrIni    = ""
        THIS.this_cHrFin    = ""
        THIS.this_cPrg      = ""
        THIS.this_cOperacao = ""
        THIS.this_cUserSis  = ""
        THIS.this_cParam    = ""
        THIS.this_cTrans    = ""

        THIS.this_nQtdeLog = 0
        THIS.LimparRegistro()
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Chave do registro corrente (SigOpLog.cidchaves),
    * conforme THIS.this_cCampoChave definido no Init
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDPROC

    *==========================================================================
    * Este BO eh somente-leitura: SIGOPCLG eh um visualizador do Log de
    * Acessos e o legado nao tem gravacao nesta tela - o dump
    * sigopclg_form_codigo_fonte.txt nao tem nenhum TABLEUPDATE, nenhum
    * .AddCursor e nenhum Insert Into / Update / Delete From (o log eh gravado
    * por outros pontos da aplicacao). O comportamento padrao herdado de
    * BusinessBase - recusar a operacao preenchendo this_cMensagemErro, que o
    * Salvar()/Excluir() reportam pelo ExibirFalha() - ja eh o correto para
    * Inserir(), Atualizar() e ExecutarExclusao(), por isso eles ficam
    * herdados em vez de sobrescritos: sobrescrever exigiria inventar a lista
    * de colunas de um INSERT ou de um UPDATE que o legado nao faz, e a regra
    * #22 do CLAUDE.md manda tirar essa lista do schema, nunca de adivinhacao.
    * RegistrarAuditoria() tambem fica herdado de BusinessBase - ele eh
    * acionado por Inserir/Atualizar/ExecutarExclusao, que aqui nunca gravam -
    * e ObterChavePrimaria() acima ja devolve a chave certa (cidchaves) caso
    * alguma rotina de auditoria venha a ser acionada sobre este BO.
    *==========================================================================

ENDDEFINE

