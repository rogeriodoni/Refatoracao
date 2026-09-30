# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (6)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.AbrirLookupCanonico()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [LAYOUT-POSITION] Controle 'Conta' (parent: SIGPRGLO): Top original=218 vs migrado 'cnt_4c_Container1' Top=164 (diff=54px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRGLO.Opera��o): Top original=5 vs migrado 'lbl_4c_Label1' Top=115 (diff=110px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRGLO.Opera��o): Left original=180 vs migrado 'lbl_4c_Label1' Left=32 (diff=148px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Empresa' (parent: SIGPRGLO): Left original=138 vs migrado 'lbl_4c_LblEmpresa' Left=83 (diff=55px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGlo.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1729 linhas total):

*-- Linhas 9 a 255:
9: * filtradas por periodo de emissao/entrega, operacao, conta (compradora) e
10: * conta responsavel (vendedor). Reusada pelo legado em tres modos, todos
11: * controlados pelas flags abaixo (espelhadas em SigPrGloBO):
12: *   - Processamento normal de O.P. (this_lReserva=.F., this_lGerPorTp=.F.)
13: *   - Reserva Automatica (this_lReserva=.T.)
14: *   - Processamento por Tipo de O.P. (this_lGerPorTp=.T., habilita cnt_4c_Container1)
15: *
16: * CHAMADA:
17: *   CREATEOBJECT("FormSigPrGlo", par_lReserva, par_lAutom, par_lPorDestino, par_pTipo)
18: *
19: * FASE 3/8 - Estrutura Base: DEFINE CLASS, Init/Destroy/InicializarForm,
20: * cabecalho e containers de agrupamento de campos VAZIOS.
21: * FASE 4/8 - Botoes de acao (Processar/Cancelar) e AlternarPagina() (funil de
22: * bloqueio/desbloqueio da UI durante o processamento - este form OPERACIONAL
23: * eh flat, sem PageFrame de conteudo, entao "pagina" aqui significa o MODO da
24: * tela: "ENTRADA" (usuario preenche os filtros) ou "PROCESSANDO" (BO executa
25: * o processamento em lote e a UI fica bloqueada)).
26: * FASE 5/8 - Campos Principais (Parte 1/2): primeira metade dos campos sem
27: * lookup - periodo de emissao (GetDataei/GetDataef), prazo de entrega
28: * (GetDatapi/GetDatapf), Movimentacao (cnt_4c_Operacao: Get_Operacao/
29: * Get_Operacaoi/Get_Operacaof) e Tipo de O.P. (cnt_4c_Container1:
30: * Get_TpGOp).
31: * FASE 6/8 - Campos Restantes e Lookups (Parte 2/2): cnt_4c_Conta/
32: * cnt_4c_Responsavel (Grupo/Conta/Descricao, SigCdGcr+SigCdCli filtrado por
33: * grupos), cnt_4c_Empresa (SigCdEmp.Cemps/Razas + Chec_pedra), cnt_4c_Previsao
34: * (data previsao/geracao, default vindo do BO) e cnt_4c_Op (numero manual da
35: * OP + checagem de duplicidade em SigOpPic). fAcessoContab/fAcessoContas/
36: * fAcessoEmpresa (funcoes globais Fortyus NAO portadas) substituidas pelo
37: * lookup canonico FormBase.AbrirLookupCanonico(). TODOS os BINDEVENT de
38: * KeyPress (Enter/Tab/F4) registrados em ConfigurarBindEvents(), chamado no
39: * fim de InicializarForm. AjustarVisibilidadeCondicional() reaplica, depois
40: * de TornarControlesVisiveis(), a ocultacao condicional do Init legado
41: * (Cnt_Previsao quando Reserva, Chec_pedra conforme parametros de
42: * transferencia, Cnt_Op conforme GlobAutos).
43: * FASE 7/8 - Eventos Principais: este form OPERACIONAL nao tem verbos CRUD
44: * (Incluir/Alterar/Visualizar/Excluir) - os "eventos principais" do legado
45: * sao BtnProcessarClick/BtnCancelarClick, ligados via BINDEVENT em
46: * ConfigurarBindEvents. BtnCancelarClick e so THIS.Release(). BtnProcessarClick
47: * transcreve as validacoes do Click legado e delega a varredura de
48: * SigMvCab/SigMvItn/SigMvIts para SigPrGloBO.Processar() (monta TmpCabec/
49: * TmpItens/TmpOper na DataSession corrente); com pelo menos 1 item
50: * selecionado, abre FormSigPrGl2 (CREATEOBJECT + VARTYPE + Show FORA do TRY -
51: * regra #29) reproduzindo "Do Form SigPrGl2 With ThisForm, DataSessionId,
52: * Reserva, poDataMgr, (Chec_pedra.Value=0), automatico, GetNop.Value" do
53: * legado (poDataMgr sai, pCnx nao existe mais - gnConnHandle global).
54: * FASE 8/8 - Consolidacao Final: FormParaBO()/BOParaForm() cobrindo TODOS os
55: * 18 campos de filtro da tela contra as properties this_* de SigPrGloBO
56: * (FormParaBO chamado em BtnProcessarClick logo antes de Processar();
57: * BOParaForm no fim de ConfigurarCamposPrevisaoOp, primeiro ponto em que
58: * todos os controles ja existem, aplicando os defaults calculados no Init do
59: * BO). Os handlers dos dois botoes do legado foram renomeados de Cmd*Click
60: * para Btn*Click - prefixo canonico do projeto, que eh o que torna handler de
61: * botao ENUMERAVEL pelos gates das Fases 7/8 (o objeto segue cmd_4c_Processar/
62: * cmd_4c_Cancelar, entao mapeamento.json nao muda).
63: *
64: * SUPERFICIE QUE ESTE LEGADO NAO TEM (ausencias deliberadas, nao omissoes):
65: *   - carga de grade de LISTA: o SCX nao tem Grid, PageFrame nem ListBox, e as
66: *     12 chamadas .AddCursor do Init legado passam string VAZIA na posicao do
67: *     grid (5o argumento) - sao registro de cursor para o processamento em
68: *     lote, nao ligacao de grade;
69: *   - verbos CRUD (Incluir/Alterar/Visualizar/Excluir) e botao de GRAVAR: a
70: *     tela filtra, monta TmpCabec/TmpItens em cursor LOCAL e entrega o
71: *     resultado ao FormSigPrGl2 ("Do Form SigPrGl2 With ..." do legado);
72: *     nenhuma escrita do dump tem tabela como alvo.
73: *==============================================================================
74: 
75: DEFINE CLASS FormSigPrGlo AS FormBase
76: 
77:     Top          = 0
78:     Left         = 0
79:     Width        = 680
80:     Height       = 379
81:     AutoCenter   = .T.
82:     TitleBar     = 0
83:     ShowWindow   = 1
84:     WindowType   = 1
85:     ControlBox   = .F.
86:     Closable     = .F.
87:     MaxButton    = .F.
88:     MinButton    = .F.
89:     BorderStyle  = 2
90:     DataSession  = 2
91:     ClipControls = .F.
92:     Caption      = "Processamento de O.P."
93:     FontName     = "Tahoma"
94:     FontSize     = 8
95: 
96:     *-- Flags de modo de operacao (recebidas via Init, repassadas ao BO em
97:     *-- InicializarForm - equivalem a ThisForm.Reserva/automatico/Pordestino/
98:     *-- GerPorTp do legado)
99:     this_lReserva     = .F.   && .T. = "Processar Reserva Automatica"
100:     this_lAutomatico  = .F.   && .T. = processamento automatico (sem interacao)
101:     this_lPorDestino  = .F.   && .T. = globalizacao por destino
102:     this_lGerPorTp    = .F.   && .T. = "Processar Ordem de Producao por Tipo" (habilita cnt_4c_Container1)
103: 
104:     *--------------------------------------------------------------------------
105:     * Init - recebe as flags de modo (equivalente a LParameters _Reserva,
106:     * _Autom, _PorDestino, lcNomeFrm1, pTipo do legado - lcNomeFrm1 nao e
107:     * usado no migrado, o Caption e resolvido por modo em InicializarForm)
108:     *--------------------------------------------------------------------------
109:     PROCEDURE Init(par_lReserva, par_lAutom, par_lPorDestino, par_pTipo)
110:         THIS.this_lReserva    = IIF(VARTYPE(par_lReserva)    = "L", par_lReserva,    .F.)
111:         THIS.this_lAutomatico = IIF(VARTYPE(par_lAutom)      = "L", par_lAutom,      .F.)
112:         THIS.this_lPorDestino = IIF(VARTYPE(par_lPorDestino) = "L", par_lPorDestino, .F.)
113:         THIS.this_lGerPorTp   = IIF(VARTYPE(par_pTipo)       = "L", par_pTipo,       .F.)
114:         RETURN DODEFAULT()
115:     ENDPROC
116: 
117:     *--------------------------------------------------------------------------
118:     * Destroy - os cursores de trabalho de Processar() (TmpOper/TmpCabec/
119:     * TmpItens/Produtos/cursor_4c_Temp*) ficam ABERTOS de proposito enquanto a
120:     * tela vive: sao o contrato do FormSigPrGl2, que roda MODAL por cima desta
121:     * (equivalente ao "Do Form SigPrGl2 With ThisForm.Datasessionid" do
122:     * legado). Todos vivem na datasession PRIVADA deste form (DataSession = 2),
123:     * que o VFP encerra junto com ele - nao ha o que fechar a mao aqui, so
124:     * delegar ao FormBase (libera this_oBusinessObject e restaura o menu
125:     * principal; DODEFAULT() eh obrigatorio como ULTIMA linha do Destroy).
126:     *--------------------------------------------------------------------------
127:     PROCEDURE Destroy()
128:         DODEFAULT()
129:     ENDPROC
130: 
131:     *--------------------------------------------------------------------------
132:     * InicializarForm - cria o Business Object, repassa as flags de modo e
133:     * monta a estrutura visual (cabecalho + containers de agrupamento vazios +
134:     * botoes de acao Processar/Cancelar). Os campos internos dos containers e
135:     * os eventos (BINDEVENT) sao adicionados nas proximas fases.
136:     *--------------------------------------------------------------------------
137:     PROTECTED PROCEDURE InicializarForm()
138:         LOCAL loc_lSucesso, loc_oErro, loc_cCaption
139:         loc_lSucesso = .F.
140: 
141:         TRY
142:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrGloBO")
143:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
144:                 MsgErro("Falha ao criar SigPrGloBO.", "Erro")
145:             ELSE
146:                 WITH THIS.this_oBusinessObject
147:                     .this_lReserva    = THIS.this_lReserva
148:                     .this_lAutomatico = THIS.this_lAutomatico
149:                     .this_lPorDestino = THIS.this_lPorDestino
150:                     .this_lGerPorTp   = THIS.this_lGerPorTp
151:                 ENDWITH
152: 
153:                 *-- Caption dinamico conforme modo de operacao (equivalente ao
154:                 *-- If ThisForm.Reserva ... Else ... EndIf do Init legado)
155:                 loc_cCaption = "Processamento de O.P."
156:                 IF THIS.this_lReserva
157:                     loc_cCaption = "Processar Reserva Autom" + CHR(225) + "tica"
158:                 ELSE
159:                     IF THIS.this_lGerPorTp
160:                         loc_cCaption = "Processar Ordem de Produ" + CHR(231) + CHR(227) + "o por Tipo"
161:                     ENDIF
162:                 ENDIF
163:                 THIS.Caption = loc_cCaption
164: 
165:                 THIS.ConfigurarPageFrame()
166: 
167:                 THIS.ConfigurarCabecalho()
168:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
169:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
170:                 THIS.ConfigurarShape()
171:                 THIS.ConfigurarPaginaLista()
172:                 THIS.ConfigurarPaginaDados()
173:                 THIS.ConfigurarBotoes()
174:                 THIS.ConfigurarBindEvents()
175: 
176:                 THIS.TornarControlesVisiveis()
177: 
178:                 *-- Visibilidade condicional (Chec_pedra/Cnt_Op/Cnt_Previsao)
179:                 *-- roda DEPOIS de TornarControlesVisiveis, que forca .Visible
180:                 *-- = .T. em tudo - sem isso a ocultacao condicional do legado
181:                 *-- seria sobrescrita.
182:                 THIS.AjustarVisibilidadeCondicional()
183: 
184:                 *-- Estado inicial: aguardando entrada do usuario (equivalente
185:                 *-- ao form legado antes do Click em Processar)
186:                 THIS.AlternarPagina("ENTRADA")
187: 
188:                 loc_lSucesso = .T.
189:             ENDIF
190:         CATCH TO loc_oErro
191:             MsgErro("Erro ao inicializar formul" + CHR(225) + "rio: " + ;
192:                     loc_oErro.Message + " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
193:         ENDTRY
194: 
195:         RETURN loc_lSucesso
196:     ENDPROC
197: 
198:     *--------------------------------------------------------------------------
199:     * ConfigurarPageFrame - imagem de fundo do form (OPERACIONAL flat, sem
200:     * PageFrame de conteudo)
201:     *--------------------------------------------------------------------------
202:     PROTECTED PROCEDURE ConfigurarPageFrame()
203:         LOCAL loc_cImg
204:         loc_cImg = gc_4c_CaminhoIcones + "new_background.jpg"
205:         IF FILE(loc_cImg)
206:             THIS.Picture = loc_cImg
207:         ENDIF
208:         THIS.ScrollBars = 0
209:     ENDPROC
210: 
211:     *--------------------------------------------------------------------------
212:     * ConfigurarCabecalho - faixa cinza escuro com titulo (cntSombra legado)
213:     * Top=0, Left=0, Width=680, Height=80 - BackColor=RGB(100,100,100)
214:     *--------------------------------------------------------------------------
215:     PROTECTED PROCEDURE ConfigurarCabecalho()
216:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
217:         WITH THIS.cnt_4c_Cabecalho
218:             .Top         = 0
219:             .Left        = 0
220:             .Width       = THIS.Width
221:             .Height      = 80
222:             .BackStyle   = 1
223:             .BackColor   = RGB(100, 100, 100)
224:             .BorderWidth = 0
225:             .Visible     = .T.
226: 
227:             .AddObject("lbl_4c_Sombra", "Label")
228:             WITH .lbl_4c_Sombra
229:                 .AutoSize      = .F.
230:                 .FontBold      = .T.
231:                 .FontName      = "Tahoma"
232:                 .FontSize      = 18
233:                 .FontUnderline = .F.
234:                 .WordWrap      = .T.
235:                 .Alignment     = 0
236:                 .BackStyle     = 0
237:                 .Height        = 40
238:                 .Left          = 10
239:                 .Top           = 18
240:                 .Width         = THIS.Width
241:                 .ForeColor     = RGB(0, 0, 0)
242:                 .Caption       = THIS.Caption
243:                 .Visible       = .T.
244:             ENDWITH
245: 
246:             .AddObject("lbl_4c_Titulo", "Label")
247:             WITH .lbl_4c_Titulo
248:                 .AutoSize      = .F.
249:                 .FontBold      = .T.
250:                 .FontName      = "Tahoma"
251:                 .FontSize      = 18
252:                 .FontUnderline = .F.
253:                 .WordWrap      = .T.
254:                 .Alignment     = 0
255:                 .BackStyle     = 0

*-- Linhas 268 a 334:
268:     * ConfigurarShape - retangulo decorativo por tras dos botoes de acao
269:     * (Shape3 legado: Top=7, Left=486, Height=110, Width=173)
270:     *--------------------------------------------------------------------------
271:     PROTECTED PROCEDURE ConfigurarShape()
272:         THIS.AddObject("shp_4c_Shape3", "Shape")
273:         WITH THIS.shp_4c_Shape3
274:             .Top         = 7
275:             .Left        = 486
276:             .Height      = 110
277:             .Width       = 173
278:             .BackStyle   = 0
279:             .BorderStyle = 0
280:             .BorderColor = RGB(90, 90, 90)
281:             .Visible     = .T.
282:         ENDWITH
283:     ENDPROC
284: 
285:     *--------------------------------------------------------------------------
286:     * ConfigurarBotoes - botoes de acao principais (Processar/Cancelar do
287:     * legado). Ficam sobre o shp_4c_Shape3 (Top=7, Left=486, W=173, H=110),
288:     * standalone (fora de CommandGroup), posicoes EXATAS do SIGPRGLO.SCX:
289:     *   Processar: Top=3, Left=528, 75x75, Caption="Processar"
290:     *   Cancelar : Top=3, Left=603, 75x75, Caption="Encerrar" (Cancel=.T. -
291:     *              ativa ESC, unica forma de fechar o form: ControlBox=.F.,
292:     *              Closable=.F., TitleBar=0)
293:     *--------------------------------------------------------------------------
294:     PROTECTED PROCEDURE ConfigurarBotoes()
295:         THIS.AddObject("cmd_4c_Processar", "CommandButton")
296:         WITH THIS.cmd_4c_Processar
297:             .Top             = 3
298:             .Left            = 528
299:             .Height          = 75
300:             .Width           = 75
301:             .FontBold        = .T.
302:             .FontItalic      = .T.
303:             .FontName        = "Tahoma"
304:             .FontSize        = 8
305:             .WordWrap        = .T.
306:             .Caption         = "Processar"
307:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
308:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
309:             .ForeColor       = RGB(90, 90, 90)
310:             .BackColor       = RGB(255, 255, 255)
311:             .Themes          = .T.
312:             .PicturePosition = 13
313:             .SpecialEffect   = 0
314:             .MousePointer    = 15
315:             .Visible         = .T.
316:         ENDWITH
317: 
318:         THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
319:         WITH THIS.cmd_4c_Cancelar
320:             .Top             = 3
321:             .Left            = 603
322:             .Height          = 75
323:             .Width           = 75
324:             .FontBold        = .T.
325:             .FontItalic      = .T.
326:             .FontName        = "Tahoma"
327:             .FontSize        = 8
328:             .WordWrap        = .T.
329:             .Caption         = "Encerrar"
330:             .Cancel          = .T.
331:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
332:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
333:             .ForeColor       = RGB(90, 90, 90)
334:             .BackColor       = RGB(255, 255, 255)

*-- Linhas 346 a 412:
346:     * proximas fases). Nome mantido por convencao do FormBase; este form
347:     * OPERACIONAL nao tem Page1=Lista/Page2=Dados.
348:     *--------------------------------------------------------------------------
349:     PROTECTED PROCEDURE ConfigurarPaginaLista()
350:         THIS.ConfigurarContainers()
351:     ENDPROC
352: 
353:     *--------------------------------------------------------------------------
354:     * ConfigurarPaginaDados - nome mantido por convencao do FormBase (form
355:     * OPERACIONAL flat, sem Page2/Dados real). Monta a primeira metade dos
356:     * campos do SIGPRGLO.SCX (Fase 5/8) - os que nao dependem de lookup.
357:     *--------------------------------------------------------------------------
358:     PROTECTED PROCEDURE ConfigurarPaginaDados()
359:         THIS.ConfigurarCamposPeriodo()
360:         THIS.ConfigurarCamposOperacao()
361:         THIS.ConfigurarCamposTipoOp()
362:         THIS.ConfigurarCamposContas()
363:         THIS.ConfigurarCamposPrevisaoOp()
364:     ENDPROC
365: 
366:     *--------------------------------------------------------------------------
367:     * ConfigurarCamposPeriodo - campos diretos do form (nao ficam dentro de
368:     * container no legado): faixa de Periodo de Emissao (GetDataei/GetDataef)
369:     * e faixa de Previsao de Entrega/Prazo (GetDatapi/GetDatapf), alem do
370:     * label "Movimentacao :" (TxtPedido) que fica acima do cnt_4c_Operacao.
371:     *--------------------------------------------------------------------------
372:     PROTECTED PROCEDURE ConfigurarCamposPeriodo()
373:         *-- Label1: "Periodo de Emissao :" (Top=115, Left=32, Width=101)
374:         THIS.AddObject("lbl_4c_Label1", "Label")
375:         WITH THIS.lbl_4c_Label1
376:             .AutoSize  = .T.
377:             .FontName  = "Tahoma"
378:             .FontSize  = 8
379:             .BackStyle = 0
380:             .Caption   = "Per" + CHR(237) + "odo de Emiss" + CHR(227) + "o :"
381:             .Left      = 32
382:             .Top       = 115
383:             .ForeColor = RGB(90, 90, 90)
384:             .Visible   = .T.
385:         ENDWITH
386: 
387:         *-- GetDataei: inicio do periodo de emissao (Top=111, Left=142, W=80)
388:         THIS.AddObject("txt_4c_Dataei", "TextBox")
389:         WITH THIS.txt_4c_Dataei
390:             .Top           = 111
391:             .Left          = 142
392:             .Width         = 80
393:             .Height        = 23
394:             .Alignment     = 3
395:             .Format        = "K"
396:             .SpecialEffect = 1
397:             .Value         = {}
398:             .Visible       = .T.
399:         ENDWITH
400: 
401:         *-- Label2: "ate" (Top=115, Left=227, Width=18)
402:         THIS.AddObject("lbl_4c_Label2", "Label")
403:         WITH THIS.lbl_4c_Label2
404:             .AutoSize  = .T.
405:             .FontName  = "Tahoma"
406:             .FontSize  = 8
407:             .BackStyle = 0
408:             .Caption   = "at" + CHR(233)
409:             .Left      = 227
410:             .Top       = 115
411:             .ForeColor = RGB(90, 90, 90)
412:             .Visible   = .T.

*-- Linhas 505 a 548:
505:     * de numero (de/ate). ControlSource fica em branco, igual ao legado -
506:     * o valor eh resolvido por codigo (Valid/lookup), adicionado na Fase 6.
507:     *--------------------------------------------------------------------------
508:     PROTECTED PROCEDURE ConfigurarCamposOperacao()
509:         WITH THIS.cnt_4c_Operacao
510:             *-- Get_Operacao: codigo da operacao/movimentacao (Dopes char(20))
511:             .AddObject("txt_4c_Operacao", "TextBox")
512:             WITH .txt_4c_Operacao
513:                 .Top           = 1
514:                 .Left          = 3
515:                 .Width         = 151
516:                 .Height        = 23
517:                 .FontName      = "Courier New"
518:                 .MaxLength     = 20
519:                 .SpecialEffect = 1
520:                 .Value         = ""
521:                 .Visible       = .T.
522:             ENDWITH
523: 
524:             *-- Label1: "de" (Top=5, Left=180, Width=14)
525:             .AddObject("lbl_4c_Label1", "Label")
526:             WITH .lbl_4c_Label1
527:                 .AutoSize  = .T.
528:                 .FontName  = "Tahoma"
529:                 .FontSize  = 8
530:                 .BackStyle = 0
531:                 .Caption   = "de"
532:                 .Left      = 180
533:                 .Top       = 5
534:                 .ForeColor = RGB(90, 90, 90)
535:                 .Visible   = .T.
536:             ENDWITH
537: 
538:             *-- Get_Operacaoi: numero inicial da faixa (Numes, numerico)
539:             .AddObject("txt_4c_Operacaoi", "TextBox")
540:             WITH .txt_4c_Operacaoi
541:                 .Top           = 1
542:                 .Left          = 201
543:                 .Width         = 55
544:                 .Height        = 23
545:                 .FontName      = "Courier New"
546:                 .Alignment     = 3
547:                 .Format        = "K"
548:                 .InputMask     = "999999"

*-- Linhas 585 a 674:
585:         ENDWITH
586:     ENDPROC
587: 
588:     *--------------------------------------------------------------------------
589:     * ConfigurarCamposTipoOp - Label5 ("Tipo de O.P.:", direto no form) +
590:     * Get_TpGOp (dentro do cnt_4c_Container1, ja criado com .Enabled
591:     * condicionado a this_lGerPorTp em ConfigurarContainers).
592:     *--------------------------------------------------------------------------
593:     PROTECTED PROCEDURE ConfigurarCamposTipoOp()
594:         *-- Label5: "Tipo de O.P.:" (Top=169, Left=67, Width=66)
595:         THIS.AddObject("lbl_4c_Label5", "Label")
596:         WITH THIS.lbl_4c_Label5
597:             .AutoSize  = .T.
598:             .FontName  = "Tahoma"
599:             .FontSize  = 8
600:             .Alignment = 0
601:             .BackStyle = 0
602:             .Caption   = "Tipo de O.P.:"
603:             .Left      = 67
604:             .Top       = 169
605:             .ForeColor = RGB(90, 90, 90)
606:             .Visible   = .T.
607:         ENDWITH
608: 
609:         *-- Get_TpGOp: codigo do Tipo de Geracao de OP (char(10), Courier New)
610:         WITH THIS.cnt_4c_Container1
611:             .AddObject("txt_4c_TpGOp", "TextBox")
612:             WITH .txt_4c_TpGOp
613:                 .Top           = 1
614:                 .Left          = 3
615:                 .Width         = 80
616:                 .Height        = 23
617:                 .FontName      = "Courier New"
618:                 .MaxLength     = 10
619:                 .SpecialEffect = 1
620:                 .Value         = ""
621:                 .Visible       = .T.
622:             ENDWITH
623:         ENDWITH
624:     ENDPROC
625: 
626:     *--------------------------------------------------------------------------
627:     * ConfigurarCamposContas - preenche os containers cnt_4c_Conta,
628:     * cnt_4c_Responsavel e cnt_4c_Empresa (ja criados vazios em
629:     * ConfigurarContainers), alem dos labels diretos do form Label6
630:     * ("Conta :"), Label7 ("Vendedor :") e lbl_empresa ("Empresa :").
631:     * ControlSource fica em branco, igual ao legado - o valor eh resolvido
632:     * por lookup (BINDEVENT em ConfigurarBindEvents).
633:     *--------------------------------------------------------------------------
634:     PROTECTED PROCEDURE ConfigurarCamposContas()
635:         LOCAL loc_cEmpPadrao, loc_nResultado
636: 
637:         *-- Label6: "Conta :" (Top=223, Left=95, Width=38)
638:         THIS.AddObject("lbl_4c_Label6", "Label")
639:         WITH THIS.lbl_4c_Label6
640:             .AutoSize  = .T.
641:             .FontName  = "Tahoma"
642:             .FontSize  = 8
643:             .BackStyle = 0
644:             .Caption   = "Conta :"
645:             .Left      = 95
646:             .Top       = 223
647:             .ForeColor = RGB(90, 90, 90)
648:             .Visible   = .T.
649:         ENDWITH
650: 
651:         *-- Label7: "Vendedor :" (Top=250, Left=78, Width=55)
652:         THIS.AddObject("lbl_4c_Label7", "Label")
653:         WITH THIS.lbl_4c_Label7
654:             .AutoSize  = .T.
655:             .FontName  = "Tahoma"
656:             .FontSize  = 8
657:             .BackStyle = 0
658:             .Caption   = "Vendedor :"
659:             .Left      = 78
660:             .Top       = 250
661:             .ForeColor = RGB(90, 90, 90)
662:             .Visible   = .T.
663:         ENDWITH
664: 
665:         *-- lbl_empresa: "Empresa :" (Top=277, Left=83, Width=50)
666:         THIS.AddObject("lbl_4c_LblEmpresa", "Label")
667:         WITH THIS.lbl_4c_LblEmpresa
668:             .AutoSize  = .T.
669:             .FontName  = "Tahoma"
670:             .FontSize  = 8
671:             .BackStyle = 0
672:             .Caption   = "Empresa :"
673:             .Left      = 83
674:             .Top       = 277

*-- Linhas 838 a 881:
838:     * this_dPrevisaoEntrega = Date()+SigCdPam.PrevProds, this_dDataGeracao =
839:     * Date() quando !this_lAutomatico).
840:     *--------------------------------------------------------------------------
841:     PROTECTED PROCEDURE ConfigurarCamposPrevisaoOp()
842:         WITH THIS.cnt_4c_Previsao
843:             *-- Label8: "Previsao de Entrega :" (Top=9, Left=7, Width=106)
844:             .AddObject("lbl_4c_Label8", "Label")
845:             WITH .lbl_4c_Label8
846:                 .AutoSize  = .T.
847:                 .FontBold  = .F.
848:                 .FontItalic = .F.
849:                 .FontName  = "Tahoma"
850:                 .FontSize  = 8
851:                 .BackStyle = 0
852:                 .Caption   = "Previs" + CHR(227) + "o de Entrega :"
853:                 .Left      = 7
854:                 .Top       = 9
855:                 .ForeColor = RGB(90, 90, 90)
856:                 .Visible   = .T.
857:             ENDWITH
858: 
859:             *-- GetPrevisao: data de previsao de entrega (Top=5, Left=134, W=80)
860:             .AddObject("txt_4c_Previsao", "TextBox")
861:             WITH .txt_4c_Previsao
862:                 .Top           = 5
863:                 .Left          = 134
864:                 .Width         = 80
865:                 .Height        = 23
866:                 .Alignment     = 3
867:                 .Format        = "K"
868:                 .SpecialEffect = 1
869:                 .Value         = {}
870:                 .Visible       = .T.
871:             ENDWITH
872: 
873:             *-- Label9: "Data de Geracao :" (Top=9, Left=244, Width=90)
874:             .AddObject("lbl_4c_Label9", "Label")
875:             WITH .lbl_4c_Label9
876:                 .AutoSize  = .T.
877:                 .FontBold  = .F.
878:                 .FontItalic = .F.
879:                 .FontName  = "Tahoma"
880:                 .FontSize  = 8
881:                 .BackStyle = 0

*-- Linhas 944 a 991:
944:     ENDPROC
945: 
946:     *--------------------------------------------------------------------------
947:     * ConfigurarContainers - cria VAZIOS os containers de agrupamento de
948:     * campos, nas posicoes do SIGPRGLO.SCX legado (tasks\task615\layout.json).
949:     * cnt_4c_Container1 fica desabilitado fora do modo "Gerar por Tipo".
950:     *--------------------------------------------------------------------------
951:     PROTECTED PROCEDURE ConfigurarContainers()
952:         *-- Container1: Tipo de O.P. (Get_TpGOp) - habilitado so quando this_lGerPorTp
953:         THIS.AddObject("cnt_4c_Container1", "Container")
954:         WITH THIS.cnt_4c_Container1
955:             .Top         = 164
956:             .Left        = 139
957:             .Width       = 346
958:             .Height      = 25
959:             .BackStyle   = 0
960:             .BorderWidth = 0
961:             .Enabled     = THIS.this_lGerPorTp
962:             .Visible     = .T.
963:         ENDWITH
964: 
965:         *-- Operacao: codigo + faixa de/ate (Get_Operacao/Get_Operacaoi/Get_Operacaof)
966:         THIS.AddObject("cnt_4c_Operacao", "Container")
967:         WITH THIS.cnt_4c_Operacao
968:             .Top         = 191
969:             .Left        = 139
970:             .Width       = 350
971:             .Height      = 25
972:             .BackStyle   = 0
973:             .BorderWidth = 0
974:             .Visible     = .T.
975:         ENDWITH
976: 
977:         *-- Conta: grupo/conta/descricao - filtro de movimentacao (compradora)
978:         THIS.AddObject("cnt_4c_Conta", "Container")
979:         WITH THIS.cnt_4c_Conta
980:             .Top         = 218
981:             .Left        = 139
982:             .Width       = 553
983:             .Height      = 25
984:             .BackStyle   = 0
985:             .BorderWidth = 0
986:             .Visible     = .T.
987:         ENDWITH
988: 
989:         *-- Responsavel: grupo/conta/descricao do vendedor
990:         THIS.AddObject("cnt_4c_Responsavel", "Container")
991:         WITH THIS.cnt_4c_Responsavel

*-- Linhas 1038 a 1729:
1038: 
1039:     *--------------------------------------------------------------------------
1040:     * AjustarVisibilidadeCondicional - reaplica, DEPOIS de
1041:     * TornarControlesVisiveis (que forca .Visible = .T. em tudo), a
1042:     * ocultacao condicional do Init legado:
1043:     *   - Cnt_Previsao.Visible = .F. quando this_lReserva
1044:     *   - Chec_pedra.Visible = .T. so quando os 4 parametros de transferencia
1045:     *     de reserva estao configurados (DopEmphs/DopReqcs/DopPedcs/TransfRes)
1046:     *   - Cnt_Op.Visible = (GlobAutos = 2 And !this_lReserva)
1047:     *--------------------------------------------------------------------------
1048:     PROTECTED PROCEDURE AjustarVisibilidadeCondicional()
1049:         LOCAL loc_oBO
1050:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1051:             RETURN
1052:         ENDIF
1053:         loc_oBO = THIS.this_oBusinessObject
1054: 
1055:         THIS.cnt_4c_Previsao.Visible = !THIS.this_lReserva
1056: 
1057:         THIS.cnt_4c_Empresa.chk_4c_ChecPedra.Visible = ;
1058:             !EMPTY(ALLTRIM(loc_oBO.this_cPamDopEmphs))  AND ;
1059:             !EMPTY(ALLTRIM(loc_oBO.this_cPamDopReqcs))  AND ;
1060:             !EMPTY(ALLTRIM(loc_oBO.this_cPamDopPedcs))  AND ;
1061:             !EMPTY(ALLTRIM(loc_oBO.this_cPamTransfRes))
1062: 
1063:         THIS.cnt_4c_Op.Visible = (loc_oBO.this_nPamGlobAutos = 2 AND !THIS.this_lReserva)
1064:     ENDPROC
1065: 
1066:     *--------------------------------------------------------------------------
1067:     * ConfigurarBindEvents - registra os handlers de KeyPress (Enter/Tab/F4)
1068:     * de TODOS os campos com lookup do form. Chamado em InicializarForm,
1069:     * depois que todos os controles ja existem (ConfigurarPaginaDados +
1070:     * ConfigurarBotoes).
1071:     *--------------------------------------------------------------------------
1072:     PROTECTED PROCEDURE ConfigurarBindEvents()
1073:         BINDEVENT(THIS.cnt_4c_Operacao.txt_4c_Operacao, "KeyPress", THIS, "OperacaoKeyPress")
1074:         BINDEVENT(THIS.cnt_4c_Container1.txt_4c_TpGOp,  "KeyPress", THIS, "TpGOpKeyPress")
1075: 
1076:         BINDEVENT(THIS.cnt_4c_Conta.txt_4c_Grupo,  "KeyPress", THIS, "ConGrupoKeyPress")
1077:         BINDEVENT(THIS.cnt_4c_Conta.txt_4c_Conta,  "KeyPress", THIS, "ConContaKeyPress")
1078:         BINDEVENT(THIS.cnt_4c_Conta.txt_4c_Dconta, "KeyPress", THIS, "ConDcontaKeyPress")
1079: 
1080:         BINDEVENT(THIS.cnt_4c_Responsavel.txt_4c_Grupo,  "KeyPress", THIS, "RespGrupoKeyPress")
1081:         BINDEVENT(THIS.cnt_4c_Responsavel.txt_4c_Conta,  "KeyPress", THIS, "RespContaKeyPress")
1082:         BINDEVENT(THIS.cnt_4c_Responsavel.txt_4c_Dconta, "KeyPress", THIS, "RespDcontaKeyPress")
1083: 
1084:         BINDEVENT(THIS.cnt_4c_Empresa.txt_4c_CdEmpresa, "KeyPress", THIS, "EmpresaCodKeyPress")
1085:         BINDEVENT(THIS.cnt_4c_Empresa.txt_4c_DsEmpresa, "KeyPress", THIS, "EmpresaDescKeyPress")
1086: 
1087:         BINDEVENT(THIS.cnt_4c_Op.txt_4c_Nop, "KeyPress", THIS, "NopKeyPress")
1088: 
1089:         BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
1090:         BINDEVENT(THIS.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
1091:     ENDPROC
1092: 
1093:     *--------------------------------------------------------------------------
1094:     * FormParaBO - copia os campos de filtro da tela para as properties
1095:     * this_* de THIS.this_oBusinessObject (SigPrGloBO.prg, declaradas na
1096:     * Fase 1). Este form OPERACIONAL nao grava registro nenhum diretamente
1097:     * (Processar() recebe os valores por parametro posicional, ja que e
1098:     * transcricao literal do Click legado - ver cabecalho de
1099:     * BtnProcessarClick), mas as properties de filtro do BO existem
1100:     * justamente para refletir o estado corrente da tela - chamado logo
1101:     * antes de THIS.this_oBusinessObject.Processar(...) em BtnProcessarClick.
1102:     *--------------------------------------------------------------------------
1103:     PROTECTED PROCEDURE FormParaBO()
1104:         LOCAL loc_oBO
1105:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1106:             RETURN .F.
1107:         ENDIF
1108:         loc_oBO = THIS.this_oBusinessObject
1109: 
1110:         loc_oBO.this_dDataEmissaoIni = THIS.txt_4c_Dataei.Value
1111:         loc_oBO.this_dDataEmissaoFim = THIS.txt_4c_Dataef.Value
1112:         loc_oBO.this_dDataPrazoIni   = THIS.txt_4c_Datapi.Value
1113:         loc_oBO.this_dDataPrazoFim   = THIS.txt_4c_Datapf.Value
1114: 
1115:         loc_oBO.this_cOperacao       = PADR(ALLTRIM(THIS.cnt_4c_Operacao.txt_4c_Operacao.Value), 20)
1116:         loc_oBO.this_nOperacaoIni    = THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value
1117:         loc_oBO.this_nOperacaoFim    = THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value
1118: 
1119:         loc_oBO.this_cContaGrupo     = PADR(ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Grupo.Value), 10)
1120:         loc_oBO.this_cContaConta     = PADR(ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Conta.Value), 10)
1121:         loc_oBO.this_cContaDescricao = PADR(ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Dconta.Value), 40)
1122: 
1123:         loc_oBO.this_cRespGrupo      = PADR(ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_Grupo.Value), 10)
1124:         loc_oBO.this_cRespConta      = PADR(ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_Conta.Value), 10)
1125:         loc_oBO.this_cRespDescricao  = PADR(ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_Dconta.Value), 40)
1126: 
1127:         loc_oBO.this_cEmpresaCodigo    = PADR(ALLTRIM(THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value), 3)
1128:         loc_oBO.this_cEmpresaRazao     = PADR(ALLTRIM(THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value), 40)
1129:         loc_oBO.this_lNaoEmpenharPedra = (THIS.cnt_4c_Empresa.chk_4c_ChecPedra.Value = 1)
1130: 
1131:         loc_oBO.this_dPrevisaoEntrega = THIS.cnt_4c_Previsao.txt_4c_Previsao.Value
1132:         loc_oBO.this_dDataGeracao     = THIS.cnt_4c_Previsao.txt_4c_Geracao.Value
1133: 
1134:         loc_oBO.this_nNumeroOP      = THIS.cnt_4c_Op.txt_4c_Nop.Value
1135:         loc_oBO.this_cTipoGeracaoOP = PADR(ALLTRIM(THIS.cnt_4c_Container1.txt_4c_TpGOp.Value), 10)
1136: 
1137:         RETURN .T.
1138:     ENDPROC
1139: 
1140:     *--------------------------------------------------------------------------
1141:     * BOParaForm - espelha as properties this_* de THIS.this_oBusinessObject
1142:     * de volta para os campos da tela. Chamado ao final de
1143:     * ConfigurarCamposPrevisaoOp (primeiro ponto em InicializarForm em que
1144:     * TODOS os controles de filtro ja existem) para aplicar os defaults
1145:     * calculados no Init do BO (this_dPrevisaoEntrega/this_dDataGeracao -
1146:     * equivalente ao GetPrevisao.Value/GetGeracao.Value do Init legado).
1147:     *--------------------------------------------------------------------------
1148:     PROTECTED PROCEDURE BOParaForm()
1149:         LOCAL loc_oBO
1150:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1151:             RETURN .F.
1152:         ENDIF
1153:         loc_oBO = THIS.this_oBusinessObject
1154: 
1155:         THIS.txt_4c_Dataei.Value = loc_oBO.this_dDataEmissaoIni
1156:         THIS.txt_4c_Dataef.Value = loc_oBO.this_dDataEmissaoFim
1157:         THIS.txt_4c_Datapi.Value = loc_oBO.this_dDataPrazoIni
1158:         THIS.txt_4c_Datapf.Value = loc_oBO.this_dDataPrazoFim
1159: 
1160:         THIS.cnt_4c_Operacao.txt_4c_Operacao.Value  = ALLTRIM(loc_oBO.this_cOperacao)
1161:         THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value = loc_oBO.this_nOperacaoIni
1162:         THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value = loc_oBO.this_nOperacaoFim
1163: 
1164:         THIS.cnt_4c_Conta.txt_4c_Grupo.Value  = ALLTRIM(loc_oBO.this_cContaGrupo)
1165:         THIS.cnt_4c_Conta.txt_4c_Conta.Value  = ALLTRIM(loc_oBO.this_cContaConta)
1166:         THIS.cnt_4c_Conta.txt_4c_Dconta.Value = ALLTRIM(loc_oBO.this_cContaDescricao)
1167: 
1168:         THIS.cnt_4c_Responsavel.txt_4c_Grupo.Value  = ALLTRIM(loc_oBO.this_cRespGrupo)
1169:         THIS.cnt_4c_Responsavel.txt_4c_Conta.Value  = ALLTRIM(loc_oBO.this_cRespConta)
1170:         THIS.cnt_4c_Responsavel.txt_4c_Dconta.Value = ALLTRIM(loc_oBO.this_cRespDescricao)
1171: 
1172:         *-- Empresa/Chec_pedra: so aplica quando o BO ja tem codigo resolvido
1173:         *-- (ConfigurarCamposContas roda ANTES e ja fez o lookup default de
1174:         *-- go_4c_Sistema.cCodEmpresa direto na tela, sem passar pelo BO) -
1175:         *-- sem esse guard, BOParaForm apagaria o default com o SPACE(3)
1176:         *-- inicial da property.
1177:         IF !EMPTY(ALLTRIM(loc_oBO.this_cEmpresaCodigo))
1178:             THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value = ALLTRIM(loc_oBO.this_cEmpresaCodigo)
1179:             THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value = ALLTRIM(loc_oBO.this_cEmpresaRazao)
1180:         ENDIF
1181:         THIS.cnt_4c_Empresa.chk_4c_ChecPedra.Value = IIF(loc_oBO.this_lNaoEmpenharPedra, 1, 0)
1182: 
1183:         THIS.cnt_4c_Previsao.txt_4c_Previsao.Value = loc_oBO.this_dPrevisaoEntrega
1184:         THIS.cnt_4c_Previsao.txt_4c_Geracao.Value  = loc_oBO.this_dDataGeracao
1185: 
1186:         THIS.cnt_4c_Op.txt_4c_Nop.Value = loc_oBO.this_nNumeroOP
1187:         THIS.cnt_4c_Container1.txt_4c_TpGOp.Value = ALLTRIM(loc_oBO.this_cTipoGeracaoOP)
1188: 
1189:         RETURN .T.
1190:     ENDPROC
1191: 
1192:     *--------------------------------------------------------------------------
1193:     * BtnCancelarClick - equivalente ao SIGPRGLO.Cancelar.Click legado
1194:     * (ThisForm.Release). PUBLIC porque e alvo de BINDEVENT (regra #3).
1195:     *--------------------------------------------------------------------------
1196:     PROCEDURE BtnCancelarClick()
1197:         THIS.Release()
1198:     ENDPROC
1199: 
1200:     *--------------------------------------------------------------------------
1201:     * BtnProcessarClick - equivalente ao SIGPRGLO.Processar.Click legado
1202:     * (tasks\task615\SigPrGlo_form_codigo_fonte.txt linhas 1383-1703):
1203:     * validacoes de UI identicas ao legado (early-exit com foco no campo que
1204:     * falhou), depois delega a varredura de SigMvCab/SigMvItn/SigMvIts para
1205:     * THIS.this_oBusinessObject.Processar() (SigPrGloBO.prg), que monta
1206:     * TmpCabec/TmpItens na DataSession corrente. Com pelo menos um item
1207:     * selecionado, abre FormSigPrGl2 exatamente como o legado fazia com
1208:     * "Do Form SigPrGl2 With ThisForm, ThisForm.Datasessionid, ThisForm.
1209:     * Reserva, ThisForm.poDataMgr, (ThisForm.Empresa.Chec_pedra.Value=0),
1210:     * ThisForm.automatico, ThisForm.Cnt_Op.GetNop.Value" - mapeamento
1211:     * posicional contra o LParameters real de SigPrGl2 (tasks\task614\
1212:     * SigPrGl2_form_codigo_fonte.txt:1171 - _ParentForm,_Data,_ReservaAuto,
1213:     * pCnx,_nGerEmphPdr,_Autom,_NumeroOp; pCnx sai, pois a conexao agora vem
1214:     * de gnConnHandle - regra Global Variables).
1215:     * PUBLIC porque e alvo de BINDEVENT (regra #3).
1216:     *--------------------------------------------------------------------------
1217:     PROCEDURE BtnProcessarClick()
1218:         LOCAL loc_lSucesso, loc_oErro
1219: 
1220:         IF EMPTY(THIS.cnt_4c_Previsao.txt_4c_Previsao.Value)
1221:             MsgAviso("A Data de Previs" + CHR(227) + "o Deve Ser Preenchida!!!", "Aten" + CHR(231) + CHR(227) + "o")
1222:             THIS.cnt_4c_Previsao.txt_4c_Previsao.SetFocus
1223:             RETURN
1224:         ENDIF
1225:         IF EMPTY(THIS.cnt_4c_Previsao.txt_4c_Geracao.Value)
1226:             MsgAviso("A Data de Gera" + CHR(231) + CHR(227) + "o Deve Ser Preenchida!!!", "Aten" + CHR(231) + CHR(227) + "o")
1227:             THIS.cnt_4c_Previsao.txt_4c_Geracao.SetFocus
1228:             RETURN
1229:         ENDIF
1230:         IF THIS.this_oBusinessObject.this_nPamGlobAutos = 2 AND THIS.cnt_4c_Op.txt_4c_Nop.Value = 0 AND !THIS.this_lReserva
1231:             MsgAviso("O N" + CHR(250) + "mero da OP " + CHR(233) + " Manual e Deve Ser Preenchido!!!", "Aten" + CHR(231) + CHR(227) + "o")
1232:             THIS.cnt_4c_Op.txt_4c_Nop.SetFocus
1233:             RETURN
1234:         ENDIF
1235:         IF THIS.this_lGerPorTp AND EMPTY(THIS.cnt_4c_Container1.txt_4c_TpGOp.Value)
1236:             MsgAviso("O Tipo de Gera" + CHR(231) + CHR(227) + "o da OP " + CHR(233) + " Obrigat" + CHR(243) + "rio ser Preenchido!!!", "Aten" + CHR(231) + CHR(227) + "o")
1237:             THIS.cnt_4c_Container1.txt_4c_TpGOp.SetFocus
1238:             RETURN
1239:         ENDIF
1240:         IF !EMPTY(THIS.txt_4c_Dataei.Value) AND !EMPTY(THIS.txt_4c_Dataef.Value) AND THIS.txt_4c_Dataef.Value < THIS.txt_4c_Dataei.Value
1241:             MsgAviso("A Data Final Deve Ser Maior Que a Inicial!!!", "Aten" + CHR(231) + CHR(227) + "o")
1242:             THIS.txt_4c_Dataei.SetFocus
1243:             RETURN
1244:         ENDIF
1245:         IF !EMPTY(THIS.txt_4c_Datapi.Value) AND !EMPTY(THIS.txt_4c_Datapf.Value) AND THIS.txt_4c_Datapf.Value < THIS.txt_4c_Datapi.Value
1246:             MsgAviso("A Data Final Deve Ser Maior Que a Inicial!!!", "Aten" + CHR(231) + CHR(227) + "o")
1247:             THIS.txt_4c_Datapi.SetFocus
1248:             RETURN
1249:         ENDIF
1250: 
1251:         THIS.FormParaBO()
1252: 
1253:         THIS.AlternarPagina("PROCESSANDO")
1254: 
1255:         TRY
1256:             loc_lSucesso = THIS.this_oBusinessObject.Processar( ;
1257:                 THIS.txt_4c_Dataei.Value, THIS.txt_4c_Dataef.Value, ;
1258:                 THIS.txt_4c_Datapi.Value, THIS.txt_4c_Datapf.Value, ;
1259:                 ALLTRIM(THIS.cnt_4c_Operacao.txt_4c_Operacao.Value), ;
1260:                 THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value, THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value, ;
1261:                 ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Grupo.Value), ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Conta.Value), ;
1262:                 ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_Grupo.Value), ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_Conta.Value), ;
1263:                 IIF(EMPTY(ALLTRIM(THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value)), ;
1264:                     ALLTRIM(go_4c_Sistema.cCodEmpresa), ALLTRIM(THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value)), ;
1265:                 ALLTRIM(THIS.cnt_4c_Container1.txt_4c_TpGOp.Value))
1266:         CATCH TO loc_oErro
1267:             loc_lSucesso = .F.
1268:             MsgErro(loc_oErro.Message + " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro ao Processar")
1269:         ENDTRY
1270: 
1271:         THIS.AlternarPagina("ENTRADA")
1272: 
1273:         IF !loc_lSucesso
1274:             IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
1275:                 MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
1276:             ENDIF
1277:             RETURN
1278:         ENDIF
1279: 
1280:         IF !USED("TmpItens") OR !USED("TmpCabec") OR EOF("TmpItens") OR EOF("TmpCabec")
1281:             MsgAviso("Nenhum Item Selecionado Para Processar!!!", "Aten" + CHR(231) + CHR(227) + "o")
1282:             THIS.txt_4c_Dataei.SetFocus
1283:             RETURN
1284:         ENDIF
1285: 
1286:         *-- CREATEOBJECT/Show FORA de qualquer TRY (regra #29 - Show() de
1287:         *-- form modal dentro de TRY fecha a tela a cada erro de runtime).
1288:         *-- FormSigPrGl2 desabilita/reabilita THIS sozinho (Init/Destroy),
1289:         *-- entao nao duplicamos THIS.Enabled = .F. aqui.
1290:         LOCAL loc_oFormFilho
1291:         loc_oFormFilho = CREATEOBJECT("FormSigPrGl2", THIS, THIS.DataSessionId, THIS.this_lReserva, ;
1292:             (THIS.cnt_4c_Empresa.chk_4c_ChecPedra.Value = 0), THIS.this_lAutomatico, ;
1293:             THIS.cnt_4c_Op.txt_4c_Nop.Value, THIS.this_lPorDestino)
1294:         IF VARTYPE(loc_oFormFilho) = "O"
1295:             loc_oFormFilho.Show()
1296:         ENDIF
1297:     ENDPROC
1298: 
1299:     *--------------------------------------------------------------------------
1300:     * OperacaoKeyPress - lookup de Movimentacao (cnt_4c_Operacao.txt_4c_
1301:     * Operacao, equivalente ao Get_Operacao.Valid legado). SigCdOpe so tem
1302:     * Dopes como coluna de texto (nao ha Descrs) - filtro adicional por
1303:     * Globalizas IN (1,2), igual ao TmpOper do Init legado. Enter/Tab vazio
1304:     * zera a faixa de numero (Get_Operacaoi/Get_Operacaof), igual ao legado.
1305:     *--------------------------------------------------------------------------
1306:     PROCEDURE OperacaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1307:         LOCAL loc_cValor, loc_nResultado
1308:         IF !(par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115)
1309:             RETURN
1310:         ENDIF
1311: 
1312:         WITH THIS.cnt_4c_Operacao
1313:             loc_cValor = ALLTRIM(.txt_4c_Operacao.Value)
1314: 
1315:             IF EMPTY(loc_cValor)
1316:                 .txt_4c_Operacaoi.Value = 0
1317:                 .txt_4c_Operacaof.Value = 0
1318:                 IF par_nKeyCode != 115
1319:                     RETURN
1320:                 ENDIF
1321:             ENDIF
1322: 
1323:             IF par_nKeyCode != 115 AND !EMPTY(loc_cValor) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
1324:                 IF USED("cursor_4c_ChkOper")
1325:                     USE IN cursor_4c_ChkOper
1326:                 ENDIF
1327:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
1328:                     "SELECT Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cValor) + ;
1329:                     " AND Globalizas IN (1,2)", "cursor_4c_ChkOper")
1330:                 IF loc_nResultado > 0 AND USED("cursor_4c_ChkOper") AND RECCOUNT("cursor_4c_ChkOper") > 0
1331:                     IF USED("cursor_4c_ChkOper")
1332:                         USE IN cursor_4c_ChkOper
1333:                     ENDIF
1334:                     RETURN
1335:                 ENDIF
1336:                 IF USED("cursor_4c_ChkOper")
1337:                     USE IN cursor_4c_ChkOper
1338:                 ENDIF
1339:             ENDIF
1340: 
1341:             THIS.AbrirLookupCanonico("SigCdOpe", "Dopes", "Dopes", ;
1342:                 "Movimenta" + CHR(231) + CHR(227) + "o", loc_cValor, ;
1343:                 .txt_4c_Operacao, .NULL., "Globalizas IN (1,2)")
1344:         ENDWITH
1345:     ENDPROC
1346: 
1347:     *--------------------------------------------------------------------------
1348:     * TpGOpKeyPress - lookup do Tipo de Geracao da OP (cnt_4c_Container1.
1349:     * txt_4c_TpGOp, equivalente ao Get_TpGOp.Valid legado - fwBuscaSel sobre
1350:     * CrTmpTpGop, aqui reproduzido como lookup direto em SigInTgo). O filtro
1351:     * de acesso por usuario (fChecaAcesso) nao foi portado - ver regra de
1352:     * funcoes de acesso Fortyus nao portadas.
1353:     *--------------------------------------------------------------------------
1354:     PROCEDURE TpGOpKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1355:         LOCAL loc_cValor, loc_nResultado
1356:         IF !(par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115)
1357:             RETURN
1358:         ENDIF
1359: 
1360:         WITH THIS.cnt_4c_Container1
1361:             loc_cValor = ALLTRIM(.txt_4c_TpGOp.Value)
1362: 
1363:             IF par_nKeyCode != 115 AND !EMPTY(loc_cValor) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
1364:                 IF USED("cursor_4c_ChkTpGOp")
1365:                     USE IN cursor_4c_ChkTpGOp
1366:                 ENDIF
1367:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
1368:                     "SELECT Codigos FROM SigInTgo WHERE Codigos = " + EscaparSQL(loc_cValor), ;
1369:                     "cursor_4c_ChkTpGOp")
1370:                 IF loc_nResultado > 0 AND USED("cursor_4c_ChkTpGOp") AND RECCOUNT("cursor_4c_ChkTpGOp") > 0
1371:                     IF USED("cursor_4c_ChkTpGOp")
1372:                         USE IN cursor_4c_ChkTpGOp
1373:                     ENDIF
1374:                     RETURN
1375:                 ENDIF
1376:                 IF USED("cursor_4c_ChkTpGOp")
1377:                     USE IN cursor_4c_ChkTpGOp
1378:                 ENDIF
1379:             ENDIF
1380: 
1381:             THIS.AbrirLookupCanonico("SigInTgo", "Codigos", "Descs", ;
1382:                 "Tipos de Gera" + CHR(231) + CHR(227) + "o de OP", loc_cValor, ;
1383:                 .txt_4c_TpGOp, .NULL.)
1384:             .Visible     = .T.
1385:         ENDWITH
1386:     ENDPROC
1387: 
1388:     *--------------------------------------------------------------------------
1389:     * ConGrupoKeyPress / RespGrupoKeyPress - lookup do Grupo de Conta
1390:     * (SigCdGcr), equivalente ao Get_grupo.Valid (fAcessoContab) das duas
1391:     * containers Conta/Responsavel. Nao ha campo de descricao visivel para
1392:     * o Grupo no form - so validacao/preenchimento do codigo.
1393:     *--------------------------------------------------------------------------
1394:     PROCEDURE ConGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1395:         THIS.ProcessarLookupGrupo(par_nKeyCode, THIS.cnt_4c_Conta.txt_4c_Grupo)
1396:     ENDPROC
1397: 
1398:     PROCEDURE RespGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1399:         THIS.ProcessarLookupGrupo(par_nKeyCode, THIS.cnt_4c_Responsavel.txt_4c_Grupo)
1400:     ENDPROC
1401: 
1402:     PROTECTED PROCEDURE ProcessarLookupGrupo(par_nKeyCode, par_oTxtGrupo)
1403:         LOCAL loc_cValor, loc_nResultado
1404:         IF !(par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115)
1405:             RETURN
1406:         ENDIF
1407: 
1408:         loc_cValor = ALLTRIM(par_oTxtGrupo.Value)
1409: 
1410:         IF par_nKeyCode != 115 AND !EMPTY(loc_cValor) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
1411:             IF USED("cursor_4c_ChkGrupo")
1412:                 USE IN cursor_4c_ChkGrupo
1413:             ENDIF
1414:             loc_nResultado = SQLEXEC(gnConnHandle, ;
1415:                 "SELECT Codigos FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cValor), ;
1416:                 "cursor_4c_ChkGrupo")
1417:             IF loc_nResultado > 0 AND USED("cursor_4c_ChkGrupo") AND RECCOUNT("cursor_4c_ChkGrupo") > 0
1418:                 IF USED("cursor_4c_ChkGrupo")
1419:                     USE IN cursor_4c_ChkGrupo
1420:                 ENDIF
1421:                 RETURN
1422:             ENDIF
1423:             IF USED("cursor_4c_ChkGrupo")
1424:                 USE IN cursor_4c_ChkGrupo
1425:             ENDIF
1426:         ENDIF
1427: 
1428:         THIS.AbrirLookupCanonico("SigCdGcr", "Codigos", "Descrs", ;
1429:             "Grupo de Conta", loc_cValor, par_oTxtGrupo, .NULL.)
1430:     ENDPROC
1431: 
1432:     *--------------------------------------------------------------------------
1433:     * ConContaKeyPress / RespContaKeyPress - lookup da Conta por CODIGO
1434:     * (SigCdCli.Iclis, filtrado por grupos = grupo digitado), equivalente ao
1435:     * Get_conta.Valid (fAcessoContas modo 'C') das containers Conta/
1436:     * Responsavel. Ao selecionar/casar, preenche a descricao (Rclis) no
1437:     * txt_4c_Dconta irmao.
1438:     *--------------------------------------------------------------------------
1439:     PROCEDURE ConContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1440:         WITH THIS.cnt_4c_Conta
1441:             THIS.ProcessarLookupConta(par_nKeyCode, .txt_4c_Grupo, .txt_4c_Conta, .txt_4c_Dconta)
1442:             .Visible     = .T.
1443:         ENDWITH
1444:     ENDPROC
1445: 
1446:     PROCEDURE RespContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1447:         WITH THIS.cnt_4c_Responsavel
1448:             THIS.ProcessarLookupConta(par_nKeyCode, .txt_4c_Grupo, .txt_4c_Conta, .txt_4c_Dconta)
1449:             .Visible     = .T.
1450:         ENDWITH
1451:     ENDPROC
1452: 
1453:     PROTECTED PROCEDURE ProcessarLookupConta(par_nKeyCode, par_oTxtGrupo, par_oTxtConta, par_oTxtDconta)
1454:         LOCAL loc_cValor, loc_cGrupo, loc_cFiltroExtra, loc_nResultado
1455:         IF !(par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115)
1456:             RETURN
1457:         ENDIF
1458: 
1459:         loc_cValor = ALLTRIM(par_oTxtConta.Value)
1460:         loc_cGrupo = ALLTRIM(par_oTxtGrupo.Value)
1461:         loc_cFiltroExtra = ""
1462:         IF !EMPTY(loc_cGrupo)
1463:             loc_cFiltroExtra = "grupos = " + EscaparSQL(loc_cGrupo)
1464:         ENDIF
1465: 
1466:         IF par_nKeyCode != 115 AND !EMPTY(loc_cValor) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
1467:             IF USED("cursor_4c_ChkConta")
1468:                 USE IN cursor_4c_ChkConta
1469:             ENDIF
1470:             loc_nResultado = SQLEXEC(gnConnHandle, ;
1471:                 "SELECT Iclis, Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cValor) + ;
1472:                 IIF(EMPTY(loc_cFiltroExtra), "", " AND " + loc_cFiltroExtra), ;
1473:                 "cursor_4c_ChkConta")
1474:             IF loc_nResultado > 0 AND USED("cursor_4c_ChkConta") AND RECCOUNT("cursor_4c_ChkConta") > 0
1475:                 par_oTxtDconta.Value = ALLTRIM(cursor_4c_ChkConta.Rclis)
1476:                 IF USED("cursor_4c_ChkConta")
1477:                     USE IN cursor_4c_ChkConta
1478:                 ENDIF
1479:                 RETURN
1480:             ENDIF
1481:             IF USED("cursor_4c_ChkConta")
1482:                 USE IN cursor_4c_ChkConta
1483:             ENDIF
1484:         ENDIF
1485: 
1486:         THIS.AbrirLookupCanonico("SigCdCli", "Iclis", "Rclis", ;
1487:             "Conta", loc_cValor, par_oTxtConta, par_oTxtDconta, loc_cFiltroExtra)
1488:     ENDPROC
1489: 
1490:     *--------------------------------------------------------------------------
1491:     * ConDcontaKeyPress / RespDcontaKeyPress - lookup da Conta por
1492:     * DESCRICAO (SigCdCli.Rclis, filtrado por grupos), equivalente ao
1493:     * Get_dconta.Valid (fAcessoContas modo 'D'). Ao casar/selecionar,
1494:     * preenche TAMBEM o codigo (Iclis) no txt_4c_Conta irmao.
1495:     *--------------------------------------------------------------------------
1496:     PROCEDURE ConDcontaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1497:         WITH THIS.cnt_4c_Conta
1498:             THIS.ProcessarLookupContaPorDescricao(par_nKeyCode, .txt_4c_Grupo, .txt_4c_Conta, .txt_4c_Dconta)
1499:             .Visible     = .T.
1500:         ENDWITH
1501:     ENDPROC
1502: 
1503:     PROCEDURE RespDcontaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1504:         WITH THIS.cnt_4c_Responsavel
1505:             THIS.ProcessarLookupContaPorDescricao(par_nKeyCode, .txt_4c_Grupo, .txt_4c_Conta, .txt_4c_Dconta)
1506:             .Visible     = .T.
1507:         ENDWITH
1508:     ENDPROC
1509: 
1510:     PROTECTED PROCEDURE ProcessarLookupContaPorDescricao(par_nKeyCode, par_oTxtGrupo, par_oTxtConta, par_oTxtDconta)
1511:         LOCAL loc_cValor, loc_cGrupo, loc_cFiltroExtra, loc_nResultado
1512:         IF !(par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115)
1513:             RETURN
1514:         ENDIF
1515: 
1516:         loc_cValor = ALLTRIM(par_oTxtDconta.Value)
1517:         loc_cGrupo = ALLTRIM(par_oTxtGrupo.Value)
1518:         loc_cFiltroExtra = ""
1519:         IF !EMPTY(loc_cGrupo)
1520:             loc_cFiltroExtra = "grupos = " + EscaparSQL(loc_cGrupo)
1521:         ENDIF
1522: 
1523:         IF par_nKeyCode != 115 AND !EMPTY(loc_cValor) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
1524:             IF USED("cursor_4c_ChkContaD")
1525:                 USE IN cursor_4c_ChkContaD
1526:             ENDIF
1527:             loc_nResultado = SQLEXEC(gnConnHandle, ;
1528:                 "SELECT Iclis, Rclis FROM SigCdCli WHERE Rclis = " + EscaparSQL(loc_cValor) + ;
1529:                 IIF(EMPTY(loc_cFiltroExtra), "", " AND " + loc_cFiltroExtra), ;
1530:                 "cursor_4c_ChkContaD")
1531:             IF loc_nResultado > 0 AND USED("cursor_4c_ChkContaD") AND RECCOUNT("cursor_4c_ChkContaD") > 0
1532:                 par_oTxtConta.Value  = ALLTRIM(cursor_4c_ChkContaD.Iclis)
1533:                 par_oTxtDconta.Value = ALLTRIM(cursor_4c_ChkContaD.Rclis)
1534:                 IF USED("cursor_4c_ChkContaD")
1535:                     USE IN cursor_4c_ChkContaD
1536:                 ENDIF
1537:                 RETURN
1538:             ENDIF
1539:             IF USED("cursor_4c_ChkContaD")
1540:                 USE IN cursor_4c_ChkContaD
1541:             ENDIF
1542:         ENDIF
1543: 
1544:         THIS.AbrirLookupCanonico("SigCdCli", "Iclis", "Rclis", ;
1545:             "Conta", loc_cValor, par_oTxtConta, par_oTxtDconta, loc_cFiltroExtra)
1546:     ENDPROC
1547: 
1548:     *--------------------------------------------------------------------------
1549:     * EmpresaCodKeyPress / EmpresaDescKeyPress - lookup de Empresa
1550:     * (SigCdEmp.Cemps/Razas), equivalente ao par get_cd_empresa.Valid /
1551:     * get_ds_empresa.Valid (fAcessoEmpresa modos 'C'/'D') - fAcessoEmpresa
1552:     * NAO foi portada (funcao global Fortyus - ver regra de funcoes de
1553:     * acesso nao portadas), substituida pelo lookup canonico em SigCdEmp.
1554:     *--------------------------------------------------------------------------
1555:     PROCEDURE EmpresaCodKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1556:         LOCAL loc_cValor, loc_nResultado
1557:         IF !(par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115)
1558:             RETURN
1559:         ENDIF
1560: 
1561:         WITH THIS.cnt_4c_Empresa
1562:             loc_cValor = ALLTRIM(.txt_4c_CdEmpresa.Value)
1563: 
1564:             IF par_nKeyCode != 115 AND !EMPTY(loc_cValor) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
1565:                 IF USED("cursor_4c_ChkEmpCod")
1566:                     USE IN cursor_4c_ChkEmpCod
1567:                 ENDIF
1568:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
1569:                     "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cValor), ;
1570:                     "cursor_4c_ChkEmpCod")
1571:                 IF loc_nResultado > 0 AND USED("cursor_4c_ChkEmpCod") AND RECCOUNT("cursor_4c_ChkEmpCod") > 0
1572:                     .txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_ChkEmpCod.Razas)
1573:                     IF USED("cursor_4c_ChkEmpCod")
1574:                         USE IN cursor_4c_ChkEmpCod
1575:                     ENDIF
1576:                     RETURN
1577:                 ENDIF
1578:                 IF USED("cursor_4c_ChkEmpCod")
1579:                     USE IN cursor_4c_ChkEmpCod
1580:                 ENDIF
1581:             ENDIF
1582: 
1583:             THIS.AbrirLookupCanonico("SigCdEmp", "Cemps", "Razas", ;
1584:                 "Sele" + CHR(231) + CHR(227) + "o de Empresa", loc_cValor, ;
1585:                 .txt_4c_CdEmpresa, .txt_4c_DsEmpresa)
1586:             .Visible     = .T.
1587:         ENDWITH
1588:     ENDPROC
1589: 
1590:     PROCEDURE EmpresaDescKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1591:         LOCAL loc_cValor, loc_nResultado
1592:         IF !(par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115)
1593:             RETURN
1594:         ENDIF
1595: 
1596:         WITH THIS.cnt_4c_Empresa
1597:             loc_cValor = ALLTRIM(.txt_4c_DsEmpresa.Value)
1598: 
1599:             IF par_nKeyCode != 115 AND !EMPTY(loc_cValor) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
1600:                 IF USED("cursor_4c_ChkEmpDesc")
1601:                     USE IN cursor_4c_ChkEmpDesc
1602:                 ENDIF
1603:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
1604:                     "SELECT Cemps, Razas FROM SigCdEmp WHERE Razas = " + EscaparSQL(loc_cValor), ;
1605:                     "cursor_4c_ChkEmpDesc")
1606:                 IF loc_nResultado > 0 AND USED("cursor_4c_ChkEmpDesc") AND RECCOUNT("cursor_4c_ChkEmpDesc") > 0
1607:                     .txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_ChkEmpDesc.Cemps)
1608:                     .txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_ChkEmpDesc.Razas)
1609:                     IF USED("cursor_4c_ChkEmpDesc")
1610:                         USE IN cursor_4c_ChkEmpDesc
1611:                     ENDIF
1612:                     RETURN
1613:                 ENDIF
1614:                 IF USED("cursor_4c_ChkEmpDesc")
1615:                     USE IN cursor_4c_ChkEmpDesc
1616:                 ENDIF
1617:             ENDIF
1618: 
1619:             THIS.AbrirLookupCanonico("SigCdEmp", "Cemps", "Razas", ;
1620:                 "Sele" + CHR(231) + CHR(227) + "o de Empresa", loc_cValor, ;
1621:                 .txt_4c_CdEmpresa, .txt_4c_DsEmpresa)
1622:             .Visible     = .T.
1623:         ENDWITH
1624:     ENDPROC
1625: 
1626:     *--------------------------------------------------------------------------
1627:     * NopKeyPress - Numero manual da O.P. (cnt_4c_Op.txt_4c_Nop), equivalente
1628:     * ao GetNop.Valid legado: NAO eh um picker, eh checagem de duplicidade
1629:     * contra SigOpPic.Numps. Se ja existe, avisa e limpa o campo.
1630:     *--------------------------------------------------------------------------
1631:     PROCEDURE NopKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1632:         LOCAL loc_nValor, loc_nResultado
1633:         IF !(par_nKeyCode = 13 OR par_nKeyCode = 9)
1634:             RETURN
1635:         ENDIF
1636: 
1637:         WITH THIS.cnt_4c_Op
1638:             loc_nValor = .txt_4c_Nop.Value
1639:             IF loc_nValor > 0 AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
1640:                 IF USED("cursor_4c_ChkNop")
1641:                     USE IN cursor_4c_ChkNop
1642:                 ENDIF
1643:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
1644:                     "SELECT Numps FROM SigOpPic WHERE Numps = " + FormatarNumeroSQL(loc_nValor, 0), ;
1645:                     "cursor_4c_ChkNop")
1646:                 IF loc_nResultado >= 0 AND USED("cursor_4c_ChkNop") AND RECCOUNT("cursor_4c_ChkNop") > 0
1647:                     MsgAviso("N" + CHR(250) + "mero de Op j" + CHR(225) + " existe. Favor Corrigir!!!", ;
1648:                              "Aten" + CHR(231) + CHR(227) + "o")
1649:                     .txt_4c_Nop.Value = 0
1650:                     .txt_4c_Nop.SetFocus
1651:                 ENDIF
1652:                 IF USED("cursor_4c_ChkNop")
1653:                     USE IN cursor_4c_ChkNop
1654:                 ENDIF
1655:             ENDIF
1656:             .Visible     = .T.
1657:         ENDWITH
1658:     ENDPROC
1659: 
1660:     *--------------------------------------------------------------------------
1661:     * AlternarPagina - funil de bloqueio/desbloqueio da UI durante o
1662:     * processamento em lote. Este form OPERACIONAL eh flat (sem PageFrame de
1663:     * conteudo), entao nao ha pagina para navegar - "par_cModo" alterna o
1664:     * ESTADO da tela entre:
1665:     *   "ENTRADA"     - usuario preenche os filtros (UI liberada)
1666:     *   "PROCESSANDO" - THIS.this_oBusinessObject executa o processamento em
1667:     *                   lote (UI bloqueada, equivalente ao trecho do Click
1668:     *                   legado que roda entre a validacao e o Messagebox de
1669:     *                   conclusao)
1670:     * Chamado no fim de InicializarForm ("ENTRADA") e, nas proximas fases,
1671:     * no BtnProcessarClick (antes/depois de THIS.this_oBusinessObject.Processar)
1672:     *--------------------------------------------------------------------------
1673:     PROCEDURE AlternarPagina(par_cModo)
1674:         LOCAL loc_lLiberado
1675:         loc_lLiberado = (UPPER(ALLTRIM(par_cModo)) != "PROCESSANDO")
1676: 
1677:         THIS.cmd_4c_Processar.Enabled = loc_lLiberado
1678: 
1679:         THIS.cnt_4c_Container1.Enabled   = loc_lLiberado AND THIS.this_lGerPorTp
1680:         THIS.cnt_4c_Operacao.Enabled     = loc_lLiberado
1681:         THIS.cnt_4c_Conta.Enabled        = loc_lLiberado
1682:         THIS.cnt_4c_Responsavel.Enabled  = loc_lLiberado
1683:         THIS.cnt_4c_Empresa.Enabled      = loc_lLiberado
1684:         THIS.cnt_4c_Previsao.Enabled     = loc_lLiberado
1685:         THIS.cnt_4c_Op.Enabled           = loc_lLiberado
1686: 
1687:         IF loc_lLiberado
1688:             THIS.MousePointer = 0
1689:         ELSE
1690:             THIS.MousePointer = 11
1691:         ENDIF
1692:     ENDPROC
1693: 
1694:     *--------------------------------------------------------------------------
1695:     * TornarControlesVisiveis - torna visiveis (recursivamente) os controles
1696:     * criados via AddObject, que nascem com Visible = .F.
1697:     *--------------------------------------------------------------------------
1698:     PROCEDURE TornarControlesVisiveis()
1699:         LOCAL loc_i, loc_oCtrl
1700:         FOR loc_i = 1 TO THIS.ControlCount
1701:             loc_oCtrl = THIS.Controls[loc_i]
1702:             IF VARTYPE(loc_oCtrl) != "O"
1703:                 LOOP
1704:             ENDIF
1705:             IF PEMSTATUS(loc_oCtrl, "Visible", 5)
1706:                 loc_oCtrl.Visible = .T.
1707:             ENDIF
1708:             IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
1709:                 THIS.TornarSubControlesVisiveis(loc_oCtrl)
1710:             ENDIF
1711:         ENDFOR
1712:     ENDPROC
1713: 
1714:     PROTECTED PROCEDURE TornarSubControlesVisiveis(par_oContainer)
1715:         LOCAL loc_i, loc_oCtrl
1716:         FOR loc_i = 1 TO par_oContainer.ControlCount
1717:             loc_oCtrl = par_oContainer.Controls[loc_i]
1718:             IF VARTYPE(loc_oCtrl) = "O"
1719:                 IF PEMSTATUS(loc_oCtrl, "Visible", 5)
1720:                     loc_oCtrl.Visible = .T.
1721:                 ENDIF
1722:                 IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
1723:                     THIS.TornarSubControlesVisiveis(loc_oCtrl)
1724:                 ENDIF
1725:             ENDIF
1726:         ENDFOR
1727:     ENDPROC
1728: 
1729: ENDDEFINE

