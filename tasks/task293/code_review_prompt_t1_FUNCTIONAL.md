# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (53)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA, CNT_4C_CONTAINER5, CNT_4C_CONTAINER3, CNT_4C_CONTAINER1, CNT_4C_AGUARDE. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [GRID-WITH] Bloco WITH loc_nNewVal define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_nNewVal.RecordSource).
- [NAVEGACAO-PAGINA] Metodo 'AtualizarTotaisPage1' faz ActivePage=2 mas NAO le dados de cursor nem chama CarregarHistorico/CarregarDados. Em forms OPERACIONAL, a navegacao para Page2 DEVE carregar dados da linha selecionada no grid de Page1 (padrao legado: cmd_consulta.Click le do cursor do grid).
- [LAYOUT-POSITION] Controle 'GradeDisp' (parent: SIGPRGLX.PageDados.Page1.Container3): Top original=15 vs migrado 'grd_4c_GradeDisp' Top=181 (diff=166px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'GradeDisp' (parent: SIGPRGLX.PageDados.Page1.Container3): Left original=3 vs migrado 'grd_4c_GradeDisp' Left=239 (diff=236px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRGLX.PageDados.Page1.Container3): Top original=163 vs migrado 'lbl_4c_Label2' Top=115 (diff=48px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Qtd' (parent: SIGPRGLX.PageDados.Page1.Container3): Top original=161 vs migrado 'txt_4c_Tot_Qtd' Top=113 (diff=48px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Est' (parent: SIGPRGLX.PageDados.Page1.Container3): Top original=161 vs migrado 'txt_4c_Tot_Est' Top=113 (diff=48px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Prz' (parent: SIGPRGLX.PageDados.Page1.Container3): Top original=161 vs migrado 'txt_4c_Tot_prze' Top=346 (diff=185px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Prz' (parent: SIGPRGLX.PageDados.Page1.Container3): Left original=292 vs migrado 'txt_4c_Tot_prze' Left=543 (diff=251px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRGLX.PageDados.Page1.Container5): Left original=269 vs migrado 'lbl_4c_Label1' Left=1 (diff=268px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRGLX.PageDados.Page1.Container5): Top original=18 vs migrado 'lbl_4c_Label2' Top=115 (diff=97px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRGLX.PageDados.Page1.Container5): Left original=448 vs migrado 'lbl_4c_Label2' Left=102 (diff=346px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Container1' (parent: SIGPRGLX.PageDados.Page1): Left original=418 vs migrado 'cnt_4c_Container1' Left=523 (diff=105px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'GradeDisp' (parent: SIGPRGLX.PageDados.Page1.Container1): Top original=15 vs migrado 'grd_4c_GradeDisp' Top=181 (diff=166px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'GradeDisp' (parent: SIGPRGLX.PageDados.Page1.Container1): Left original=2 vs migrado 'grd_4c_GradeDisp' Left=239 (diff=237px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRGLX.PageDados.Page1): Top original=348 vs migrado 'lbl_4c_Label1' Top=1 (diff=347px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRGLX.PageDados.Page1): Left original=224 vs migrado 'lbl_4c_Label1' Left=1 (diff=223px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Qtd' (parent: SIGPRGLX.PageDados.Page1): Top original=346 vs migrado 'txt_4c_Tot_Qtd' Top=113 (diff=233px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Qtd' (parent: SIGPRGLX.PageDados.Page1): Left original=271 vs migrado 'txt_4c_Tot_Qtd' Left=145 (diff=126px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Est' (parent: SIGPRGLX.PageDados.Page1): Top original=346 vs migrado 'txt_4c_Tot_Est' Top=113 (diff=233px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Est' (parent: SIGPRGLX.PageDados.Page1): Left original=407 vs migrado 'txt_4c_Tot_Est' Left=207 (diff=200px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Prz' (parent: SIGPRGLX.PageDados.Page1): Left original=476 vs migrado 'txt_4c_Tot_prze' Left=543 (diff=67px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRGLX.PageDados.Page2): Top original=372 vs migrado 'lbl_4c_Label1' Top=1 (diff=371px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRGLX.PageDados.Page2): Left original=403 vs migrado 'lbl_4c_Label1' Left=1 (diff=402px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Qtd' (parent: SIGPRGLX.PageDados.Page2): Top original=370 vs migrado 'txt_4c_Tot_Qtd' Top=113 (diff=257px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Qtd' (parent: SIGPRGLX.PageDados.Page2): Left original=449 vs migrado 'txt_4c_Tot_Qtd' Left=145 (diff=304px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Est' (parent: SIGPRGLX.PageDados.Page2): Top original=370 vs migrado 'txt_4c_Tot_Est' Top=113 (diff=257px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Est' (parent: SIGPRGLX.PageDados.Page2): Left original=516 vs migrado 'txt_4c_Tot_Est' Left=207 (diff=309px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Prz' (parent: SIGPRGLX.PageDados.Page2): Left original=648 vs migrado 'txt_4c_Tot_prze' Left=543 (diff=105px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRGLX.PageDados.Page2): Top original=164 vs migrado 'lbl_4c_Label2' Top=115 (diff=49px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRGLX.PageDados.Page2): Left original=383 vs migrado 'lbl_4c_Label2' Left=102 (diff=281px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRGLX.PageDados.Page3): Top original=147 vs migrado 'lbl_4c_Label2' Top=115 (diff=32px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRGLX.PageDados.Page3): Left original=173 vs migrado 'lbl_4c_Label2' Left=102 (diff=71px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'GradeDisp' (parent: SIGPRGLX.PageDados.Page4): Left original=191 vs migrado 'grd_4c_GradeDisp' Left=239 (diff=48px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRGLX.PageDados.Page4): Top original=418 vs migrado 'lbl_4c_Label2' Top=115 (diff=303px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRGLX.PageDados.Page4): Left original=220 vs migrado 'lbl_4c_Label2' Left=102 (diff=118px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGPRGLX.PageDados.Page4): Left original=192 vs migrado 'lbl_4c_Label3' Left=261 (diff=69px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Qt_pedida' (parent: SIGPRGLX.PageDados.Page4): Left original=312 vs migrado 'txt_4c_Qt_pedida' Left=379 (diff=67px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Qt_Selec' (parent: SIGPRGLX.PageDados.Page4): Left original=312 vs migrado 'txt_4c_Qt_Selec' Left=379 (diff=67px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRGLX.PageDados.Page4): Top original=138 vs migrado 'lbl_4c_Label1' Top=1 (diff=137px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRGLX.PageDados.Page4): Left original=197 vs migrado 'lbl_4c_Label1' Left=1 (diff=196px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRGLX.PageDados.Page5): Top original=415 vs migrado 'lbl_4c_Label2' Top=115 (diff=300px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRGLX.PageDados.Page5): Left original=289 vs migrado 'lbl_4c_Label2' Left=102 (diff=187px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRGLX.PageDados.Page5): Top original=150 vs migrado 'lbl_4c_Label1' Top=1 (diff=149px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRGLX.PageDados.Page5): Left original=246 vs migrado 'lbl_4c_Label1' Left=1 (diff=245px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRGLX.PageDados.Page6): Top original=168 vs migrado 'lbl_4c_Label1' Top=1 (diff=167px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRGLX.PageDados.Page6): Left original=132 vs migrado 'lbl_4c_Label1' Left=1 (diff=131px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Aguarde' (parent: SIGPRGLX): Top original=251 vs migrado 'cnt_4c_Aguarde' Top=18 (diff=233px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Aguarde' (parent: SIGPRGLX): Left original=142 vs migrado 'cnt_4c_Aguarde' Left=260 (diff=118px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRGLX.Aguarde): Left original=208 vs migrado 'lbl_4c_Label1' Left=1 (diff=207px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRGLX.Aguarde): Top original=52 vs migrado 'lbl_4c_Label2' Top=115 (diff=63px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRGLX.Aguarde): Left original=137 vs migrado 'lbl_4c_Label2' Left=102 (diff=35px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGlx.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (3953 linhas total):

*-- Linhas 36 a 124:
36:     *--------------------------------------------------------------------------
37:     * INIT - Inicializa form filho com parametros do form pai
38:     *--------------------------------------------------------------------------
39:     PROCEDURE Init(par_oParentForm, par_dData, par_lReservaAuto, ;
40:                    par_nGerEmphPdr, par_lAutom, par_nNumeroOp, par_lPorDestino)
41: 
42:         LOCAL loc_lSucesso
43: 
44:         loc_lSucesso = .F.
45: 
46:         TRY
47:             *-- Compartilha datasession com form pai ANTES do DODEFAULT
48:             IF !ISNULL(par_oParentForm) AND ISOBJECT(par_oParentForm)
49:                 THIS.DataSessionId   = par_oParentForm.DataSessionId
50:                 THIS.this_oParentForm = par_oParentForm
51:             ENDIF
52: 
53:             *-- Cria e configura o BO antes do DODEFAULT (InicializarForm precisa dele)
54:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrGlxBO")
55: 
56:             THIS.this_oBusinessObject.this_dData       = IIF(TYPE("par_dData")         = "D", par_dData, DATE())
57:             THIS.this_oBusinessObject.this_lReserva    = IIF(TYPE("par_lReservaAuto")  = "L", par_lReservaAuto, .F.)
58:             THIS.this_oBusinessObject.this_nEmphPdr    = IIF(TYPE("par_nGerEmphPdr")   = "N", par_nGerEmphPdr, 0)
59:             THIS.this_oBusinessObject.this_lAutomatico = IIF(TYPE("par_lAutom")        = "L", par_lAutom, .F.)
60:             THIS.this_oBusinessObject.this_nNumerodaop = IIF(TYPE("par_nNumeroOp")     = "N", par_nNumeroOp, 0)
61:             THIS.this_oBusinessObject.this_lPorDestino = IIF(TYPE("par_lPorDestino")   = "L", par_lPorDestino, .F.)
62: 
63:             DODEFAULT()
64:             loc_lSucesso = .T.
65:         CATCH TO loc_oErro
66:             MsgErro("Erro ao inicializar Pr" + CHR(233) + "via da Globaliza" + ;
67:                 CHR(231) + CHR(227) + "o: " + loc_oErro.Message, "Erro")
68:         ENDTRY
69: 
70:         RETURN loc_lSucesso
71:     ENDPROC
72: 
73:     *--------------------------------------------------------------------------
74:     * InicializarForm - Configura controles e estado inicial
75:     *--------------------------------------------------------------------------
76:     PROTECTED PROCEDURE InicializarForm()
77: 
78:         LOCAL loc_cCaption, loc_lPedrasVis
79: 
80:         TRY
81:             THIS.ConfigurarPageFrame()
82: 
83:             *-- Torna controles visiveis (cnt_4c_Aguarde fica oculto por design)
84:             THIS.TornarControlesVisiveis(THIS)
85:             THIS.AjustarVisibilidadeBotoes()
86: 
87:             *-- Exibe e ativa primeira pagina
88:             THIS.pgf_4c_1.Visible    = .T.
89:             THIS.pgf_4c_1.ActivePage = 1
90: 
91:             *-- Caption baseado no modo de operacao
92:             loc_cCaption = "Pr" + CHR(233) + "via da Globaliza" + CHR(231) + CHR(227) + "o"
93:             IF THIS.this_oBusinessObject.this_lReserva
94:                 loc_cCaption = "Pr" + CHR(233) + "via da Reserva Autom" + CHR(225) + "tica"
95:             ENDIF
96:             THIS.Caption = loc_cCaption
97: 
98:             *-- Atualiza labels do cabecalho
99:             THIS.pgf_4c_1.Page1.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = loc_cCaption
100:             THIS.pgf_4c_1.Page1.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = loc_cCaption
101: 
102:             *-- Obtem SigKey do cursor CrSigCdPac (passado pelo form pai)
103:             IF USED("CrSigCdPac") AND RECCOUNT("CrSigCdPac") > 0 AND !EOF("CrSigCdPac")
104:                 THIS.this_oBusinessObject.this_cSigKey = ALLTRIM(CrSigCdPac.sigKeys)
105:             ENDIF
106: 
107:             *-- Visibilidade do botao Pedras (requisicao de material)
108:             *-- Botao adicionado na Fase 4; estado armazenado no BO para uso posterior
109:             loc_lPedrasVis = .F.
110:             IF USED("CrSigCdPam")
111:                 IF !EMPTY(CrSigCdPam.DopEmphs) AND !EMPTY(CrSigCdPam.DopReqcs) AND ;
112:                    !EMPTY(CrSigCdPam.DopPedcs) AND !EMPTY(CrSigCdPam.DopComps) AND ;
113:                    !THIS.this_oBusinessObject.this_lReserva
114:                     loc_lPedrasVis = .T.
115:                 ENDIF
116:             ENDIF
117:             THIS.this_oBusinessObject.this_lPedrasVisiveis = loc_lPedrasVis
118: 
119:             *-- Permissao de prioridade (fChecaAcesso nao portado - concede por padrao)
120:             THIS.this_oBusinessObject.this_lPermitePrioridade    = .T.
121:             THIS.this_oBusinessObject.this_lSelEstoqueVisivel    = .T.
122: 
123:             *-- Cria cursor auxiliar de saldo unitario por produto/cor/tamanho
124:             IF USED("TmpSaldU")

*-- Linhas 138 a 181:
138:     *--------------------------------------------------------------------------
139:     * ConfigurarPageFrame - Cria PageFrame com 6 paginas
140:     *--------------------------------------------------------------------------
141:     PROTECTED PROCEDURE ConfigurarPageFrame()
142: 
143:         LOCAL loc_cBg
144: 
145:         TRY
146:             loc_cBg = gc_4c_CaminhoIcones + "new_background.jpg"
147: 
148:             THIS.AddObject("pgf_4c_1", "PageFrame")
149: 
150:             WITH THIS.pgf_4c_1
151:                 .Top       = -27
152:                 .Left      = -1
153:                 .Width     = 1004
154:                 .Height    = 629
155:                 .PageCount = 6
156:                 .Tabs      = .F.
157:                 .Visible   = .F.
158: 
159:                 WITH .Page1
160:                     .FontBold  = .T.
161:                     .ForeColor = RGB(0, 128, 192)
162:                     .Caption   = "Dados"
163:                     .Picture   = loc_cBg
164:                 ENDWITH
165: 
166:                 WITH .Page2
167:                     .FontBold  = .T.
168:                     .ForeColor = RGB(0, 128, 192)
169:                     .Caption   = "Opera" + CHR(231) + CHR(245) + "es Detalhadas"
170:                     .Picture   = loc_cBg
171:                 ENDWITH
172: 
173:                 WITH .Page3
174:                     .FontBold  = .T.
175:                     .ForeColor = RGB(0, 128, 192)
176:                     .Caption   = "Totais por Linha"
177:                     .Picture   = loc_cBg
178:                     .Enabled   = .F.
179:                 ENDWITH
180: 
181:                 WITH .Page4

*-- Linhas 224 a 276:
224:     * dados editaveis (TmpFinal) + totais + observacoes + foto. Delega para
225:     * ConfigurarPagina2 para preservar o layout multi-fase existente.
226:     *--------------------------------------------------------------------------
227:     PROTECTED PROCEDURE ConfigurarPaginaDados()
228:         THIS.ConfigurarPagina2()
229:     ENDPROC
230: 
231:     *--------------------------------------------------------------------------
232:     * ConfigurarPagina1 - Cabecalho e containers da pagina principal (Fase 3)
233:     *--------------------------------------------------------------------------
234:     * Grids e botoes sao adicionados nas Fases 4-5.
235:     *--------------------------------------------------------------------------
236:     PROTECTED PROCEDURE ConfigurarPagina1()
237: 
238:         LOCAL loc_oPage
239: 
240:         TRY
241:             loc_oPage = THIS.pgf_4c_1.Page1
242: 
243:             *-- Cabecalho cinza com labels sobrepostas (efeito sombra)
244:             loc_oPage.AddObject("cnt_4c_Sombra", "Container")
245:             WITH loc_oPage.cnt_4c_Sombra
246:                 .Top        = -1
247:                 .Left       = 0
248:                 .Width      = THIS.Width
249:                 .Height     = 80
250:                 .BorderWidth = 0
251:                 .BackColor  = RGB(100, 100, 100)
252:                 .BackStyle  = 1
253:                 .Visible    = .F.
254: 
255:                 .AddObject("lbl_4c_LblSombra", "Label")
256:                 WITH .lbl_4c_LblSombra
257:                     .FontBold      = .T.
258:                     .FontName      = "Tahoma"
259:                     .FontSize      = 18
260:                     .FontUnderline = .F.
261:                     .WordWrap      = .T.
262:                     .Alignment     = 0
263:                     .BackStyle     = 0
264:                     .Top           = 18
265:                     .Left          = 13
266:                     .Width         = THIS.Width
267:                     .Height        = 40
268:                     .ForeColor     = RGB(0, 0, 0)
269:                     .AutoSize      = .F.
270:                     .Caption       = "Pr" + CHR(233) + "via da Globaliza" + CHR(231) + CHR(227) + "o"
271:                 ENDWITH
272: 
273:                 .AddObject("lbl_4c_LblTitulo", "Label")
274:                 WITH .lbl_4c_LblTitulo
275:                     .FontBold  = .T.
276:                     .FontName  = "Tahoma"

*-- Linhas 311 a 378:
311:                 .BackStyle     = 1
312:                 .Visible       = .F.
313:             ENDWITH
314: 
315:             *-- Container estoque em producao (Container1) - grid adicionado na Fase 4
316:             loc_oPage.AddObject("cnt_4c_Container1", "Container")
317:             WITH loc_oPage.cnt_4c_Container1
318:                 .Top           = 371
319:                 .Left          = 523
320:                 .Width         = 385
321:                 .Height        = 136
322:                 .SpecialEffect = 0
323:                 .BackColor     = RGB(255, 255, 255)
324:                 .BackStyle     = 1
325:                 .Visible       = .F.
326:             ENDWITH
327: 
328:             THIS.ConfigurarPaginaLista()
329: 
330:         CATCH TO loc_oErro
331:             MsgErro("Erro ao configurar P" + CHR(225) + "gina 1: " + loc_oErro.Message, "Erro")
332:         ENDTRY
333:     ENDPROC
334: 
335:     *--------------------------------------------------------------------------
336:     * ConfigurarPagina2 - Operacoes Detalhadas (TmpFinal)
337:     *--------------------------------------------------------------------------
338:     PROTECTED PROCEDURE ConfigurarPagina2()
339: 
340:         LOCAL loc_oPage, loc_oGrid
341: 
342:         TRY
343:             loc_oPage = THIS.pgf_4c_1.Page2
344: 
345:             loc_oPage.AddObject("grd_4c_GradeItens2", "Grid")
346:             WITH loc_oPage.grd_4c_GradeItens2
347:                 .Top          = 181
348:                 .Left         = 53
349:                 .Width        = 703
350:                 .Height       = 189
351:                 .ColumnCount  = 10
352:                 .RecordSource = IIF(USED("TmpFinal"), "TmpFinal", "")
353:                 .RecordMark   = .F.
354:                 .DeleteMark   = .F.
355:                 .Visible      = .F.
356: 
357:                 WITH .Column1
358:                     .Header1.Caption = "Produto"
359:                     .ControlSource   = "TmpFinal.Cpros"
360:                     .Width           = 90
361:                     .ReadOnly        = .T.
362:                 ENDWITH
363:                 WITH .Column2
364:                     .Header1.Caption = "Cor"
365:                     .ControlSource   = "TmpFinal.CodCors"
366:                     .Width           = 35
367:                     .ReadOnly        = .T.
368:                 ENDWITH
369:                 WITH .Column3
370:                     .Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
371:                     .ControlSource   = "TmpFinal.Dopes"
372:                     .Width           = 60
373:                     .ReadOnly        = .T.
374:                 ENDWITH
375:                 WITH .Column4
376:                     .Header1.Caption = "N" + CHR(250) + "mero"
377:                     .ControlSource   = "TmpFinal.Nops"
378:                     .Width           = 50

*-- Linhas 430 a 462:
430:                 .Caption   = "Totais :"
431:                 .BackStyle = 0
432:                 .Visible   = .F.
433:             ENDWITH
434: 
435:             loc_oPage.AddObject("txt_4c_Tot_Qtd", "TextBox")
436:             WITH loc_oPage.txt_4c_Tot_Qtd
437:                 .Top       = 370
438:                 .Left      = 449
439:                 .Width     = 68
440:                 .Height    = 19
441:                 .ReadOnly  = .T.
442:                 .Alignment = 1
443:                 .Visible   = .F.
444:             ENDWITH
445: 
446:             loc_oPage.AddObject("txt_4c_Tot_Est", "TextBox")
447:             WITH loc_oPage.txt_4c_Tot_Est
448:                 .Top       = 370
449:                 .Left      = 516
450:                 .Width     = 67
451:                 .Height    = 19
452:                 .ReadOnly  = .T.
453:                 .Alignment = 1
454:                 .Visible   = .F.
455:             ENDWITH
456: 
457:             loc_oPage.AddObject("txt_4c_Tot_prc", "TextBox")
458:             WITH loc_oPage.txt_4c_Tot_prc
459:                 .Top       = 370
460:                 .Left      = 581
461:                 .Width     = 67
462:                 .Height    = 19

*-- Linhas 556 a 625:
556:             ENDWITH
557: 
558:             loc_oGrid = loc_oPage.grd_4c_GradeItens2
559:             BINDEVENT(loc_oGrid,                "AfterRowColChange", THIS, "P2GradeAfterRowColChange")
560:             BINDEVENT(loc_oGrid.Column1.Text1,  "GotFocus",          THIS, "P2ColGotFocusToCol7")
561:             BINDEVENT(loc_oGrid.Column2.Text1,  "GotFocus",          THIS, "P2ColGotFocusToCol7")
562:             BINDEVENT(loc_oGrid.Column3.Text1,  "GotFocus",          THIS, "P2ColGotFocusToCol7")
563:             BINDEVENT(loc_oGrid.Column4.Text1,  "GotFocus",          THIS, "P2ColGotFocusToCol7")
564:             BINDEVENT(loc_oGrid.Column5.Text1,  "GotFocus",          THIS, "P2ColGotFocusToCol7")
565:             BINDEVENT(loc_oGrid.Column6.Text1,  "GotFocus",          THIS, "P2ColGotFocusToCol7")
566:             BINDEVENT(loc_oGrid.Column8.Text1,  "GotFocus",          THIS, "P2ColGotFocusToCol7")
567:             BINDEVENT(loc_oGrid.Column9.Text1,  "GotFocus",          THIS, "P2ColGotFocusToCol7")
568:             BINDEVENT(loc_oGrid.Column7.Text1,  "When",              THIS, "P2ColC7When")
569:             BINDEVENT(loc_oGrid.Column7.Text1,  "Valid",             THIS, "P2ColC7Valid")
570:             BINDEVENT(loc_oGrid.Column7.Text1,  "KeyPress",         THIS, "P2ColC7LostFocus")
571:             BINDEVENT(loc_oGrid.Column10.Text1, "When",              THIS, "P2ColC10When")
572:             BINDEVENT(loc_oGrid.Column10.Text1, "Valid",             THIS, "P2ColC10Valid")
573:             BINDEVENT(loc_oGrid.Column10.Text1, "KeyPress",         THIS, "P2ColC10LostFocus")
574:             BINDEVENT(loc_oPage.cmd_4c_Voltar,  "Click",             THIS, "BtnVoltarPage2Click")
575:             BINDEVENT(loc_oPage,                "Activate",          THIS, "Pagina2Activate")
576: 
577:         CATCH TO loc_oErro
578:             MsgErro("Erro ao configurar P" + CHR(225) + "gina 2: " + loc_oErro.Message, "Erro")
579:         ENDTRY
580:     ENDPROC
581: 
582:     *--------------------------------------------------------------------------
583:     * ConfigurarPagina3 - Totais por Linha (TmpLinha)
584:     *--------------------------------------------------------------------------
585:     PROTECTED PROCEDURE ConfigurarPagina3()
586: 
587:         LOCAL loc_oPage
588: 
589:         TRY
590:             loc_oPage = THIS.pgf_4c_1.Page3
591: 
592:             loc_oPage.AddObject("shp_4c_Shape4", "Shape")
593:             WITH loc_oPage.shp_4c_Shape4
594:                 .Top     = 169
595:                 .Left    = 168
596:                 .Width   = 437
597:                 .Height  = 2
598:                 .Visible = .F.
599:             ENDWITH
600: 
601:             loc_oPage.AddObject("lbl_4c_Label2", "Label")
602:             WITH loc_oPage.lbl_4c_Label2
603:                 .Top       = 147
604:                 .Left      = 173
605:                 .Width     = 157
606:                 .Height    = 25
607:                 .Caption   = "Totais por Linha"
608:                 .BackStyle = 0
609:                 .FontBold  = .T.
610:                 .Visible   = .F.
611:             ENDWITH
612: 
613:             loc_oPage.AddObject("grd_4c_GradeLinhas", "Grid")
614:             WITH loc_oPage.grd_4c_GradeLinhas
615:                 .Top          = 181
616:                 .Left         = 167
617:                 .Width        = 438
618:                 .Height       = 292
619:                 .ColumnCount  = 5
620:                 .RecordSource = IIF(USED("TmpLinha"), "TmpLinha", "")
621:                 .RecordMark   = .F.
622:                 .DeleteMark   = .F.
623:                 .ReadOnly     = .T.
624:                 .Visible      = .F.
625: 

*-- Linhas 669 a 736:
669:                 .ToolTipText = "Voltar"
670:             ENDWITH
671: 
672:             BINDEVENT(loc_oPage.cmd_4c_Voltar, "Click", THIS, "BtnVoltarPage3Click")
673: 
674:         CATCH TO loc_oErro
675:             MsgErro("Erro ao configurar P" + CHR(225) + "gina 3: " + loc_oErro.Message, "Erro")
676:         ENDTRY
677:     ENDPROC
678: 
679:     *--------------------------------------------------------------------------
680:     * ConfigurarPagina4 - Selecionar Estoque por Grupo/Conta (TmpDisp)
681:     *--------------------------------------------------------------------------
682:     PROTECTED PROCEDURE ConfigurarPagina4()
683: 
684:         LOCAL loc_oPage, loc_oGrid
685: 
686:         TRY
687:             loc_oPage = THIS.pgf_4c_1.Page4
688: 
689:             loc_oPage.AddObject("shp_4c_Shape4", "Shape")
690:             WITH loc_oPage.shp_4c_Shape4
691:                 .Top     = 159
692:                 .Left    = 191
693:                 .Width   = 370
694:                 .Height  = 2
695:                 .Visible = .F.
696:             ENDWITH
697: 
698:             loc_oPage.AddObject("lbl_4c_Label1", "Label")
699:             WITH loc_oPage.lbl_4c_Label1
700:                 .Top       = 138
701:                 .Left      = 197
702:                 .Width     = 184
703:                 .Height    = 25
704:                 .Caption   = "Selecionar Estoque"
705:                 .BackStyle = 0
706:                 .FontBold  = .T.
707:                 .Visible   = .F.
708:             ENDWITH
709: 
710:             loc_oPage.AddObject("txt_4c_Cpros", "TextBox")
711:             WITH loc_oPage.txt_4c_Cpros
712:                 .Top      = 138
713:                 .Left     = 479
714:                 .Width    = 80
715:                 .Height   = 19
716:                 .ReadOnly = .T.
717:                 .Visible  = .F.
718:             ENDWITH
719: 
720:             loc_oPage.AddObject("grd_4c_GradeDisp", "Grid")
721:             WITH loc_oPage.grd_4c_GradeDisp
722:                 .Top          = 169
723:                 .Left         = 191
724:                 .Width        = 370
725:                 .Height       = 244
726:                 .ColumnCount  = 5
727:                 .RecordSource = IIF(USED("TmpDisp"), "TmpDisp", "")
728:                 .RecordMark   = .F.
729:                 .DeleteMark   = .F.
730:                 .Visible      = .F.
731: 
732:                 WITH .Column1
733:                     .Header1.Caption = "Grupo"
734:                     .ControlSource   = "TmpDisp.Grupos"
735:                     .Width           = 60
736:                     .ReadOnly        = .T.

*-- Linhas 761 a 899:
761:                     .Width           = 65
762:                     .ReadOnly        = .F.
763:                     .Text1.Alignment = 1
764:                 ENDWITH
765:             ENDWITH
766:             THIS.FormatarGrid(loc_oPage.grd_4c_GradeDisp)
767: 
768:             loc_oPage.AddObject("lbl_4c_Label2", "Label")
769:             WITH loc_oPage.lbl_4c_Label2
770:                 .Top       = 418
771:                 .Left      = 220
772:                 .Width     = 82
773:                 .Height    = 16
774:                 .Caption   = "Qtde Pedida : "
775:                 .BackStyle = 0
776:                 .Visible   = .F.
777:             ENDWITH
778: 
779:             loc_oPage.AddObject("lbl_4c_Label3", "Label")
780:             WITH loc_oPage.lbl_4c_Label3
781:                 .Top       = 437
782:                 .Left      = 192
783:                 .Width     = 110
784:                 .Height    = 16
785:                 .Caption   = "Qtde Selecionada : "
786:                 .BackStyle = 0
787:                 .Visible   = .F.
788:             ENDWITH
789: 
790:             loc_oPage.AddObject("txt_4c_Qt_pedida", "TextBox")
791:             WITH loc_oPage.txt_4c_Qt_pedida
792:                 .Top       = 413
793:                 .Left      = 312
794:                 .Width     = 67
795:                 .Height    = 23
796:                 .ReadOnly  = .T.
797:                 .Alignment = 1
798:                 .Visible   = .F.
799:             ENDWITH
800: 
801:             loc_oPage.AddObject("txt_4c_Qt_Selec", "TextBox")
802:             WITH loc_oPage.txt_4c_Qt_Selec
803:                 .Top       = 436
804:                 .Left      = 312
805:                 .Width     = 67
806:                 .Height    = 23
807:                 .ReadOnly  = .T.
808:                 .Alignment = 1
809:                 .Visible   = .F.
810:             ENDWITH
811: 
812:             loc_oPage.AddObject("cmd_4c_Voltar", "CommandButton")
813:             WITH loc_oPage.cmd_4c_Voltar
814:                 .Top         = 12
815:                 .Left        = 704
816:                 .Width       = 75
817:                 .Height      = 75
818:                 .Caption     = "Voltar"
819:                 .FontName    = "Tahoma"
820:                 .FontSize    = 8
821:                 .Themes      = .T.
822:                 .Visible     = .F.
823:                 .ToolTipText = "Voltar"
824:             ENDWITH
825: 
826:             loc_oGrid = loc_oPage.grd_4c_GradeDisp
827:             BINDEVENT(loc_oGrid.Column1.Text1,    "When",      THIS, "P4ColReadOnlyWhen")
828:             BINDEVENT(loc_oGrid.Column2.Text1,    "When",      THIS, "P4ColReadOnlyWhen")
829:             BINDEVENT(loc_oGrid.Column3.Text1,    "When",      THIS, "P4ColReadOnlyWhen")
830:             BINDEVENT(loc_oGrid.Column4.Text1,    "When",      THIS, "P4ColReadOnlyWhen")
831:             BINDEVENT(loc_oGrid.Column5.Text1,    "Valid",     THIS, "P4ColC5Valid")
832:             BINDEVENT(loc_oGrid.Column5.Text1,    "KeyPress", THIS, "P4ColC5LostFocus")
833:             BINDEVENT(loc_oPage.txt_4c_Qt_pedida, "When",      THIS, "P4ColReadOnlyWhen")
834:             BINDEVENT(loc_oPage.txt_4c_Qt_Selec,  "When",      THIS, "P4ColReadOnlyWhen")
835:             BINDEVENT(loc_oPage.cmd_4c_Voltar,    "Click",     THIS, "BtnVoltarPage4Click")
836: 
837:         CATCH TO loc_oErro
838:             MsgErro("Erro ao configurar P" + CHR(225) + "gina 4: " + loc_oErro.Message, "Erro")
839:         ENDTRY
840:     ENDPROC
841: 
842:     *--------------------------------------------------------------------------
843:     * ConfigurarPagina5 - Disponivel por Tamanho (TmpDisp por CodTams)
844:     *--------------------------------------------------------------------------
845:     PROTECTED PROCEDURE ConfigurarPagina5()
846: 
847:         LOCAL loc_oPage, loc_oGrid
848: 
849:         TRY
850:             loc_oPage = THIS.pgf_4c_1.Page5
851: 
852:             loc_oPage.AddObject("shp_4c_Shape4", "Shape")
853:             WITH loc_oPage.shp_4c_Shape4
854:                 .Top     = 171
855:                 .Left    = 240
856:                 .Width   = 328
857:                 .Height  = 2
858:                 .Visible = .F.
859:             ENDWITH
860: 
861:             loc_oPage.AddObject("lbl_4c_Label1", "Label")
862:             WITH loc_oPage.lbl_4c_Label1
863:                 .Top       = 150
864:                 .Left      = 246
865:                 .Width     = 205
866:                 .Height    = 25
867:                 .Caption   = "Selecionar Tamanhos"
868:                 .BackStyle = 0
869:                 .FontBold  = .T.
870:                 .Visible   = .F.
871:             ENDWITH
872: 
873:             loc_oPage.AddObject("txt_4c_Cpros", "TextBox")
874:             WITH loc_oPage.txt_4c_Cpros
875:                 .Top      = 151
876:                 .Left     = 486
877:                 .Width    = 80
878:                 .Height   = 19
879:                 .ReadOnly = .T.
880:                 .Visible  = .F.
881:             ENDWITH
882: 
883:             loc_oPage.AddObject("grd_4c_GradeDisp", "Grid")
884:             WITH loc_oPage.grd_4c_GradeDisp
885:                 .Top          = 181
886:                 .Left         = 239
887:                 .Width        = 327
888:                 .Height       = 228
889:                 .ColumnCount  = 5
890:                 .RecordSource = IIF(USED("TmpDisp"), "TmpDisp", "")
891:                 .RecordMark   = .F.
892:                 .DeleteMark   = .F.
893:                 .Visible      = .F.
894: 
895:                 WITH .Column1
896:                     .Header1.Caption = "Produto"
897:                     .ControlSource   = "TmpDisp.Cpros"
898:                     .Width           = 55
899:                     .ReadOnly        = .T.

*-- Linhas 923 a 1046:
923:                     .Width           = 65
924:                     .ReadOnly        = .F.
925:                     .Text1.Alignment = 1
926:                 ENDWITH
927:             ENDWITH
928:             THIS.FormatarGrid(loc_oPage.grd_4c_GradeDisp)
929: 
930:             loc_oPage.AddObject("lbl_4c_Label2", "Label")
931:             WITH loc_oPage.lbl_4c_Label2
932:                 .Top       = 415
933:                 .Left      = 289
934:                 .Width     = 82
935:                 .Height    = 16
936:                 .Caption   = "Qtde Pedida : "
937:                 .BackStyle = 0
938:                 .Visible   = .F.
939:             ENDWITH
940: 
941:             loc_oPage.AddObject("lbl_4c_Label3", "Label")
942:             WITH loc_oPage.lbl_4c_Label3
943:                 .Top       = 434
944:                 .Left      = 261
945:                 .Width     = 110
946:                 .Height    = 16
947:                 .Caption   = "Qtde Selecionada : "
948:                 .BackStyle = 0
949:                 .Visible   = .F.
950:             ENDWITH
951: 
952:             loc_oPage.AddObject("txt_4c_Qt_pedida", "TextBox")
953:             WITH loc_oPage.txt_4c_Qt_pedida
954:                 .Top       = 410
955:                 .Left      = 379
956:                 .Width     = 67
957:                 .Height    = 23
958:                 .ReadOnly  = .T.
959:                 .Alignment = 1
960:                 .Visible   = .F.
961:             ENDWITH
962: 
963:             loc_oPage.AddObject("txt_4c_Qt_Selec", "TextBox")
964:             WITH loc_oPage.txt_4c_Qt_Selec
965:                 .Top       = 433
966:                 .Left      = 379
967:                 .Width     = 67
968:                 .Height    = 23
969:                 .ReadOnly  = .T.
970:                 .Alignment = 1
971:                 .Visible   = .F.
972:             ENDWITH
973: 
974:             loc_oPage.AddObject("cmd_4c_Voltar", "CommandButton")
975:             WITH loc_oPage.cmd_4c_Voltar
976:                 .Top         = 12
977:                 .Left        = 704
978:                 .Width       = 75
979:                 .Height      = 75
980:                 .Caption     = "Voltar"
981:                 .FontName    = "Tahoma"
982:                 .FontSize    = 8
983:                 .Themes      = .T.
984:                 .Visible     = .F.
985:                 .ToolTipText = "Voltar"
986:             ENDWITH
987: 
988:             loc_oGrid = loc_oPage.grd_4c_GradeDisp
989:             BINDEVENT(loc_oGrid.Column1.Text1,    "GotFocus", THIS, "P5ColGotFocusToCol5")
990:             BINDEVENT(loc_oGrid.Column2.Text1,    "GotFocus", THIS, "P5ColGotFocusToCol5")
991:             BINDEVENT(loc_oGrid.Column3.Text1,    "GotFocus", THIS, "P5ColGotFocusToCol5")
992:             BINDEVENT(loc_oGrid.Column4.Text1,    "GotFocus", THIS, "P5ColGotFocusToCol5")
993:             BINDEVENT(loc_oGrid.Column5.Text1,    "Valid",    THIS, "P5ColC5Valid")
994:             BINDEVENT(loc_oPage.txt_4c_Qt_pedida, "When",    THIS, "P4ColReadOnlyWhen")
995:             BINDEVENT(loc_oPage.txt_4c_Qt_Selec,  "When",    THIS, "P4ColReadOnlyWhen")
996:             BINDEVENT(loc_oPage.cmd_4c_Voltar,    "Click",   THIS, "BtnVoltarPage5Click")
997: 
998:         CATCH TO loc_oErro
999:             MsgErro("Erro ao configurar P" + CHR(225) + "gina 5: " + loc_oErro.Message, "Erro")
1000:         ENDTRY
1001:     ENDPROC
1002: 
1003:     *--------------------------------------------------------------------------
1004:     * ConfigurarPagina6 - Requisicao Manual de Material (SelPedra)
1005:     *--------------------------------------------------------------------------
1006:     PROTECTED PROCEDURE ConfigurarPagina6()
1007: 
1008:         LOCAL loc_oPage, loc_oGrid
1009: 
1010:         TRY
1011:             loc_oPage = THIS.pgf_4c_1.Page6
1012: 
1013:             loc_oPage.AddObject("shp_4c_Shape4", "Shape")
1014:             WITH loc_oPage.shp_4c_Shape4
1015:                 .Top     = 189
1016:                 .Left    = 119
1017:                 .Width   = 500
1018:                 .Height  = 2
1019:                 .Visible = .F.
1020:             ENDWITH
1021: 
1022:             loc_oPage.AddObject("lbl_4c_Label1", "Label")
1023:             WITH loc_oPage.lbl_4c_Label1
1024:                 .Top       = 168
1025:                 .Left      = 132
1026:                 .Width     = 294
1027:                 .Height    = 25
1028:                 .Caption   = "Requisi" + CHR(231) + CHR(227) + "o Manual de Material"
1029:                 .BackStyle = 0
1030:                 .FontBold  = .T.
1031:                 .Visible   = .F.
1032:             ENDWITH
1033: 
1034:             loc_oPage.AddObject("txt_4c_Cpros", "TextBox")
1035:             WITH loc_oPage.txt_4c_Cpros
1036:                 .Top      = 169
1037:                 .Left     = 487
1038:                 .Width    = 80
1039:                 .Height   = 19
1040:                 .ReadOnly = .T.
1041:                 .Visible  = .F.
1042:             ENDWITH
1043: 
1044:             loc_oPage.AddObject("grd_4c_GradePedra", "Grid")
1045:             WITH loc_oPage.grd_4c_GradePedra
1046:                 .Top          = 197

*-- Linhas 1102 a 1164:
1102:             ENDWITH
1103: 
1104:             loc_oGrid = loc_oPage.grd_4c_GradePedra
1105:             BINDEVENT(loc_oGrid.Column1.Text1, "Valid",     THIS, "P6ColC1Valid")
1106:             BINDEVENT(loc_oGrid.Column1.Text1, "KeyPress",  THIS, "P6ColC1KeyPress")
1107:             BINDEVENT(loc_oGrid.Column2.Text1, "When",      THIS, "P6ColC2When")
1108:             BINDEVENT(loc_oGrid.Column3.Text1, "When",      THIS, "P6ColC3When")
1109:             BINDEVENT(loc_oGrid.Column4.Text1, "When",      THIS, "P6ColC4When")
1110:             BINDEVENT(loc_oGrid.Column5.Text1, "When",      THIS, "P6ColC5When")
1111:             BINDEVENT(loc_oGrid.Column5.Text1, "Valid",     THIS, "P6ColC5Valid")
1112:             BINDEVENT(loc_oGrid.Column5.Text1, "KeyPress", THIS, "P6ColC5LostFocus")
1113:             BINDEVENT(loc_oGrid.Column5.Text1, "KeyPress",  THIS, "P6ColC5KeyPress")
1114:             BINDEVENT(loc_oPage.cmd_4c_Voltar, "Click",     THIS, "BtnVoltarPage6Click")
1115: 
1116:         CATCH TO loc_oErro
1117:             MsgErro("Erro ao configurar P" + CHR(225) + "gina 6: " + loc_oErro.Message, "Erro")
1118:         ENDTRY
1119:     ENDPROC
1120: 
1121:     *--------------------------------------------------------------------------
1122:     * ConfigurarContainerAguarde - Overlay de espera (nivel do form)
1123:     *--------------------------------------------------------------------------
1124:     PROTECTED PROCEDURE ConfigurarContainerAguarde()
1125: 
1126:         TRY
1127:             THIS.AddObject("cnt_4c_Aguarde", "Container")
1128:             WITH THIS.cnt_4c_Aguarde
1129:                 .Top           = 251
1130:                 .Left          = 178
1131:                 .Width         = 645
1132:                 .Height        = 98
1133:                 .SpecialEffect = 0
1134:                 .BackColor     = RGB(255, 255, 255)
1135:                 .BackStyle     = 1
1136:                 .Visible       = .F.
1137:                 .ZOrderSet     = 1
1138: 
1139:                 .AddObject("lbl_4c_AguardeMsg", "Label")
1140:                 WITH .lbl_4c_AguardeMsg
1141:                     .FontBold  = .T.
1142:                     .FontName  = "Tahoma"
1143:                     .FontSize  = 14
1144:                     .BackStyle = 0
1145:                     .Caption   = "Aguarde..."
1146:                     .Height    = 29
1147:                     .Left      = 260
1148:                     .Top       = 18
1149:                     .Width     = 131
1150:                     .ForeColor = RGB(255, 0, 0)
1151:                     .AutoSize  = .F.
1152:                 ENDWITH
1153: 
1154:                 .AddObject("lbl_4c_AguardeProc", "Label")
1155:                 WITH .lbl_4c_AguardeProc
1156:                     .FontBold  = .T.
1157:                     .FontName  = "Tahoma"
1158:                     .FontSize  = 14
1159:                     .BackStyle = 0
1160:                     .Caption   = "Processando Dados ......"
1161:                     .Height    = 27
1162:                     .Left      = 171
1163:                     .Top       = 52
1164:                     .Width     = 303

*-- Linhas 1188 a 1294:
1188:     ENDPROC
1189: 
1190:     *--------------------------------------------------------------------------
1191:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
1192:     *--------------------------------------------------------------------------
1193:     * cnt_4c_Aguarde: o container permanece oculto (overlay de processamento),
1194:     * mas seus filhos recebem Visible=.T. para que aparecam quando ativado.
1195:     *--------------------------------------------------------------------------
1196:     PROCEDURE TornarControlesVisiveis(par_oContainer)
1197: 
1198:         LOCAL loc_i, loc_oCtrl, loc_cNome, loc_p
1199: 
1200:         IF ISNULL(par_oContainer) OR !ISOBJECT(par_oContainer)
1201:             RETURN
1202:         ENDIF
1203: 
1204:         FOR loc_i = 1 TO par_oContainer.ControlCount
1205:             loc_oCtrl = par_oContainer.Controls(loc_i)
1206:             loc_cNome = UPPER(ALLTRIM(loc_oCtrl.Name))
1207: 
1208:             IF loc_cNome = "CNT_4C_AGUARDE"
1209:                 *-- Container fica oculto; mas filhos precisam estar visiveis
1210:                 THIS.TornarControlesVisiveis(loc_oCtrl)
1211:                 LOOP
1212:             ENDIF
1213: 
1214:             IF PEMSTATUS(loc_oCtrl, "Visible", 5)
1215:                 loc_oCtrl.Visible = .T.
1216:             ENDIF
1217: 
1218:             IF UPPER(loc_oCtrl.BaseClass) = "PAGEFRAME"
1219:                 FOR loc_p = 1 TO loc_oCtrl.PageCount
1220:                     THIS.TornarControlesVisiveis(loc_oCtrl.Pages(loc_p))
1221:                 ENDFOR
1222:             ELSE
1223:                 IF PEMSTATUS(loc_oCtrl, "ControlCount", 5)
1224:                 IF loc_oCtrl.ControlCount > 0
1225:                     THIS.TornarControlesVisiveis(loc_oCtrl)
1226:                 ENDIF
1227:                 ENDIF
1228:             ENDIF
1229:         ENDFOR
1230:     ENDPROC
1231: 
1232:     *--------------------------------------------------------------------------
1233:     * FormatarGrid - Configura aparencia visual padrao de um grid
1234:     *--------------------------------------------------------------------------
1235:     PROCEDURE FormatarGrid(par_oGrid)
1236: 
1237:         IF ISNULL(par_oGrid) OR !ISOBJECT(par_oGrid)
1238:             RETURN
1239:         ENDIF
1240: 
1241:         WITH par_oGrid
1242:             .FontName   = "Verdana"
1243:             .FontSize   = 8
1244:             .RecordMark = .F.
1245:             .DeleteMark = .F.
1246:             .FontName = "Verdana"
1247:             .FontSize = 8
1248:         ENDWITH
1249:     ENDPROC
1250: 
1251:     *--------------------------------------------------------------------------
1252:     * ConfigurarPaginaLista - Adiciona grade de itens e controles na Page1
1253:     *--------------------------------------------------------------------------
1254:     PROTECTED PROCEDURE ConfigurarPaginaLista()
1255: 
1256:         LOCAL loc_oPage, loc_oGrid
1257: 
1258:         TRY
1259:             loc_oPage = THIS.pgf_4c_1.Page1
1260: 
1261:             *-- Shapes decorativos
1262:             loc_oPage.AddObject("shp_4c_Shape2", "Shape")
1263:             WITH loc_oPage.shp_4c_Shape2
1264:                 .Top     = 12
1265:                 .Left    = 10
1266:                 .Width   = 342
1267:                 .Height  = 110
1268:                 .Visible = .F.
1269:             ENDWITH
1270: 
1271:             loc_oPage.AddObject("shp_4c_Shape3", "Shape")
1272:             WITH loc_oPage.shp_4c_Shape3
1273:                 .Top     = 9
1274:                 .Left    = 605
1275:                 .Width   = 173
1276:                 .Height  = 38
1277:                 .Visible = .F.
1278:             ENDWITH
1279: 
1280:             *-- Imagem do produto
1281:             loc_oPage.AddObject("img_4c_ImgFigJpg", "Image")
1282:             WITH loc_oPage.img_4c_ImgFigJpg
1283:                 .Top     = 255
1284:                 .Left    = 646
1285:                 .Width   = 122
1286:                 .Height  = 89
1287:                 .Stretch = 2
1288:                 .Visible = .F.
1289:             ENDWITH
1290: 
1291:             *-- Grade principal de itens
1292:             loc_oPage.AddObject("grd_4c_GradeItens", "Grid")
1293:             WITH loc_oPage.grd_4c_GradeItens
1294:                 .Top          = 173

*-- Linhas 1389 a 1517:
1389:                 .Caption   = "Totais :"
1390:                 .BackStyle = 0
1391:                 .Visible   = .F.
1392:             ENDWITH
1393: 
1394:             loc_oPage.AddObject("txt_4c_Tot_Qtd", "TextBox")
1395:             WITH loc_oPage.txt_4c_Tot_Qtd
1396:                 .Top       = 346
1397:                 .Left      = 271
1398:                 .Width     = 67
1399:                 .Height    = 19
1400:                 .ReadOnly  = .T.
1401:                 .Alignment = 1
1402:                 .Visible   = .F.
1403:             ENDWITH
1404: 
1405:             loc_oPage.AddObject("txt_4c_Tot_prdc", "TextBox")
1406:             WITH loc_oPage.txt_4c_Tot_prdc
1407:                 .Top       = 346
1408:                 .Left      = 339
1409:                 .Width     = 67
1410:                 .Height    = 19
1411:                 .ReadOnly  = .T.
1412:                 .Alignment = 1
1413:                 .Visible   = .F.
1414:             ENDWITH
1415: 
1416:             loc_oPage.AddObject("txt_4c_Tot_Est", "TextBox")
1417:             WITH loc_oPage.txt_4c_Tot_Est
1418:                 .Top       = 346
1419:                 .Left      = 407
1420:                 .Width     = 68
1421:                 .Height    = 19
1422:                 .ReadOnly  = .T.
1423:                 .Alignment = 1
1424:                 .Visible   = .F.
1425:             ENDWITH
1426: 
1427:             loc_oPage.AddObject("txt_4c_Tot_Prz", "TextBox")
1428:             WITH loc_oPage.txt_4c_Tot_Prz
1429:                 .Top       = 346
1430:                 .Left      = 476
1431:                 .Width     = 67
1432:                 .Height    = 19
1433:                 .ReadOnly  = .T.
1434:                 .Alignment = 1
1435:                 .Visible   = .F.
1436:             ENDWITH
1437: 
1438:             loc_oPage.AddObject("txt_4c_Tot_prze", "TextBox")
1439:             WITH loc_oPage.txt_4c_Tot_prze
1440:                 .Top       = 346
1441:                 .Left      = 543
1442:                 .Width     = 75
1443:                 .Height    = 19
1444:                 .ReadOnly  = .T.
1445:                 .Alignment = 1
1446:                 .Visible   = .F.
1447:             ENDWITH
1448: 
1449:             *-- Popula containers e adiciona botoes
1450:             THIS.ConfigurarContainer5()
1451:             THIS.ConfigurarGradeContainer3()
1452:             THIS.ConfigurarGradeContainer1()
1453:             THIS.ConfigurarBotoesPage1()
1454: 
1455:             *-- BINDEVENTs da grade principal
1456:             loc_oGrid = loc_oPage.grd_4c_GradeItens
1457:             BINDEVENT(loc_oGrid,                "AfterRowColChange", THIS, "GradeItensAfterRowColChange")
1458:             BINDEVENT(loc_oGrid.Column3.Text1,  "Click",             THIS, "ColC3Click")
1459:             BINDEVENT(loc_oGrid.Column7.Text1,  "When",              THIS, "ColC7When")
1460:             BINDEVENT(loc_oGrid.Column7.Text1,  "Valid",             THIS, "ColC7Valid")
1461:             BINDEVENT(loc_oGrid.Column7.Text1,  "KeyPress",         THIS, "ColC7LostFocus")
1462:             BINDEVENT(loc_oGrid.Column8.Text1,  "When",              THIS, "ColC8When")
1463:             BINDEVENT(loc_oGrid.Column8.Text1,  "KeyPress",         THIS, "ColC8LostFocus")
1464:             BINDEVENT(loc_oGrid.Column10.Text1, "When",              THIS, "ColC10When")
1465:             BINDEVENT(loc_oGrid.Column10.Text1, "Valid",             THIS, "ColC10Valid")
1466:             BINDEVENT(loc_oGrid.Column10.Text1, "KeyPress",         THIS, "ColC10LostFocus")
1467:             BINDEVENT(loc_oPage.img_4c_ImgFigJpg, "Click",          THIS, "ImgFigJpgClick")
1468: 
1469:         CATCH TO loc_oErro
1470:             MsgErro("Erro ao configurar lista: " + loc_oErro.Message, "Erro")
1471:         ENDTRY
1472:     ENDPROC
1473: 
1474:     *--------------------------------------------------------------------------
1475:     * ConfigurarContainer5 - Controles de info do produto (barra superior)
1476:     *--------------------------------------------------------------------------
1477:     PROTECTED PROCEDURE ConfigurarContainer5()
1478: 
1479:         LOCAL loc_oCnt
1480: 
1481:         TRY
1482:             loc_oCnt = THIS.pgf_4c_1.Page1.cnt_4c_Container5
1483: 
1484:             loc_oCnt.AddObject("lbl_4c_Lab_periodo", "Label")
1485:             WITH loc_oCnt.lbl_4c_Lab_periodo
1486:                 .Top       = 2
1487:                 .Left      = 8
1488:                 .Width     = 105
1489:                 .Height    = 15
1490:                 .Caption   = "Per" + CHR(237) + "odo: xx meses"
1491:                 .BackStyle = 0
1492:                 .Visible   = .F.
1493:             ENDWITH
1494: 
1495:             loc_oCnt.AddObject("lbl_4c_Lab_produto", "Label")
1496:             WITH loc_oCnt.lbl_4c_Lab_produto
1497:                 .Top       = 18
1498:                 .Left      = 8
1499:                 .Width     = 127
1500:                 .Height    = 15
1501:                 .Caption   = "Referencia Analisada :"
1502:                 .BackStyle = 0
1503:                 .Visible   = .F.
1504:             ENDWITH
1505: 
1506:             loc_oCnt.AddObject("txt_4c_Cpros", "TextBox")
1507:             WITH loc_oCnt.txt_4c_Cpros
1508:                 .Top      = 16
1509:                 .Left     = 141
1510:                 .Width    = 108
1511:                 .Height   = 19
1512:                 .ReadOnly = .T.
1513:                 .Visible  = .F.
1514:             ENDWITH
1515: 
1516:             loc_oCnt.AddObject("lbl_4c_LblQtdVenda", "Label")
1517:             WITH loc_oCnt.lbl_4c_LblQtdVenda

*-- Linhas 1565 a 1608:
1565:     *--------------------------------------------------------------------------
1566:     * ConfigurarGradeContainer3 - Grade de estoque disponivel por grupo/conta
1567:     *--------------------------------------------------------------------------
1568:     PROTECTED PROCEDURE ConfigurarGradeContainer3()
1569: 
1570:         LOCAL loc_oCnt, loc_oGrid
1571: 
1572:         TRY
1573:             loc_oCnt = THIS.pgf_4c_1.Page1.cnt_4c_Container3
1574: 
1575:             loc_oCnt.AddObject("lbl_4c_Label1", "Label")
1576:             WITH loc_oCnt.lbl_4c_Label1
1577:                 .Top       = 1
1578:                 .Left      = 0
1579:                 .Width     = 363
1580:                 .Height    = 16
1581:                 .Caption   = "Estoque Dispon" + CHR(237) + "vel"
1582:                 .BackStyle = 0
1583:                 .FontBold  = .T.
1584:                 .Visible   = .F.
1585:             ENDWITH
1586: 
1587:             loc_oCnt.AddObject("grd_4c_EstDisp", "Grid")
1588:             WITH loc_oCnt.grd_4c_EstDisp
1589:                 .Top          = 15
1590:                 .Left         = 3
1591:                 .Width        = 358
1592:                 .Height       = 147
1593:                 .ColumnCount  = 6
1594:                 .RecordSource = IIF(USED("TmpSaldG"), "TmpSaldG", "")
1595:                 .RecordMark   = .F.
1596:                 .DeleteMark   = .F.
1597:                 .ReadOnly     = .F.
1598:                 .Visible      = .F.
1599: 
1600:                 WITH .Column1
1601:                     .Header1.Caption = "Grupo"
1602:                     .ControlSource   = "TmpSaldG.Grupos"
1603:                     .Width           = 50
1604:                     .ReadOnly        = .T.
1605:                 ENDWITH
1606: 
1607:                 WITH .Column2
1608:                     .Header1.Caption = "Conta"

*-- Linhas 1655 a 1746:
1655:                 .Caption   = "Totais :"
1656:                 .BackStyle = 0
1657:                 .Visible   = .F.
1658:             ENDWITH
1659: 
1660:             loc_oCnt.AddObject("txt_4c_Tot_Qtd", "TextBox")
1661:             WITH loc_oCnt.txt_4c_Tot_Qtd
1662:                 .Top       = 161
1663:                 .Left      = 174
1664:                 .Width     = 58
1665:                 .Height    = 19
1666:                 .ReadOnly  = .T.
1667:                 .Alignment = 1
1668:                 .Visible   = .F.
1669:             ENDWITH
1670: 
1671:             loc_oCnt.AddObject("txt_4c_Tot_Est", "TextBox")
1672:             WITH loc_oCnt.txt_4c_Tot_Est
1673:                 .Top       = 161
1674:                 .Left      = 234
1675:                 .Width     = 58
1676:                 .Height    = 19
1677:                 .ReadOnly  = .T.
1678:                 .Alignment = 1
1679:                 .Visible   = .F.
1680:             ENDWITH
1681: 
1682:             loc_oCnt.AddObject("txt_4c_Tot_Prz", "TextBox")
1683:             WITH loc_oCnt.txt_4c_Tot_Prz
1684:                 .Top       = 161
1685:                 .Left      = 292
1686:                 .Width     = 58
1687:                 .Height    = 19
1688:                 .ReadOnly  = .T.
1689:                 .Alignment = 1
1690:                 .Visible   = .F.
1691:             ENDWITH
1692: 
1693:             *-- BINDEVENTs: coluna Prior editavel somente quando producao plena
1694:             loc_oGrid = loc_oCnt.grd_4c_EstDisp
1695:             BINDEVENT(loc_oGrid.Column6.Text1, "When",      THIS, "EstDispC6When")
1696:             BINDEVENT(loc_oGrid.Column6.Text1, "KeyPress", THIS, "EstDispC6LostFocus")
1697: 
1698:         CATCH TO loc_oErro
1699:             MsgErro("Erro ao configurar Container3: " + loc_oErro.Message, "Erro")
1700:         ENDTRY
1701:     ENDPROC
1702: 
1703:     *--------------------------------------------------------------------------
1704:     * ConfigurarGradeContainer1 - Grade de estoque em producao por fase/OP
1705:     *--------------------------------------------------------------------------
1706:     PROTECTED PROCEDURE ConfigurarGradeContainer1()
1707: 
1708:         LOCAL loc_oCnt
1709: 
1710:         TRY
1711:             loc_oCnt = THIS.pgf_4c_1.Page1.cnt_4c_Container1
1712: 
1713:             loc_oCnt.AddObject("lbl_4c_Label1", "Label")
1714:             WITH loc_oCnt.lbl_4c_Label1
1715:                 .Top       = 1
1716:                 .Left      = 1
1717:                 .Width     = 305
1718:                 .Height    = 16
1719:                 .Caption   = "Estoque Em Produ" + CHR(231) + CHR(227) + "o"
1720:                 .BackStyle = 0
1721:                 .FontBold  = .T.
1722:                 .Visible   = .F.
1723:             ENDWITH
1724: 
1725:             loc_oCnt.AddObject("grd_4c_EstProd", "Grid")
1726:             WITH loc_oCnt.grd_4c_EstProd
1727:                 .Top          = 15
1728:                 .Left         = 2
1729:                 .Width        = 303
1730:                 .Height       = 99
1731:                 .ColumnCount  = 5
1732:                 .RecordSource = IIF(USED("TmpFinal"), "TmpFinal", "")
1733:                 .RecordMark   = .F.
1734:                 .DeleteMark   = .F.
1735:                 .ReadOnly     = .T.
1736:                 .Visible      = .F.
1737: 
1738:                 WITH .Column1
1739:                     .Header1.Caption = "Fase"
1740:                     .ControlSource   = "TmpFinal.Dopes"
1741:                     .Width           = 55
1742:                 ENDWITH
1743: 
1744:                 WITH .Column2
1745:                     .Header1.Caption = "Disponivel"
1746:                     .ControlSource   = "TmpFinal.Saldo"

*-- Linhas 1781 a 1856:
1781:                 .Caption   = "Totais :"
1782:                 .BackStyle = 0
1783:                 .Visible   = .F.
1784:             ENDWITH
1785: 
1786:             loc_oCnt.AddObject("txt_4c_Tot_Qtd", "TextBox")
1787:             WITH loc_oCnt.txt_4c_Tot_Qtd
1788:                 .Top       = 113
1789:                 .Left      = 145
1790:                 .Width     = 61
1791:                 .Height    = 19
1792:                 .ReadOnly  = .T.
1793:                 .Alignment = 1
1794:                 .Visible   = .F.
1795:             ENDWITH
1796: 
1797:             loc_oCnt.AddObject("txt_4c_Tot_Est", "TextBox")
1798:             WITH loc_oCnt.txt_4c_Tot_Est
1799:                 .Top       = 113
1800:                 .Left      = 207
1801:                 .Width     = 61
1802:                 .Height    = 19
1803:                 .ReadOnly  = .T.
1804:                 .Alignment = 1
1805:                 .Visible   = .F.
1806:             ENDWITH
1807: 
1808:         CATCH TO loc_oErro
1809:             MsgErro("Erro ao configurar Container1: " + loc_oErro.Message, "Erro")
1810:         ENDTRY
1811:     ENDPROC
1812: 
1813:     *--------------------------------------------------------------------------
1814:     * ConfigurarBotoesPage1 - Adiciona botoes de acao na Page1
1815:     *--------------------------------------------------------------------------
1816:     PROTECTED PROCEDURE ConfigurarBotoesPage1()
1817: 
1818:         LOCAL loc_oPage
1819: 
1820:         TRY
1821:             loc_oPage = THIS.pgf_4c_1.Page1
1822: 
1823:             loc_oPage.AddObject("cmd_4c_Pedras", "CommandButton")
1824:             WITH loc_oPage.cmd_4c_Pedras
1825:                 .Top         = 2
1826:                 .Left        = 348
1827:                 .Width       = 75
1828:                 .Height      = 75
1829:                 .Caption     = "Requisi" + CHR(231) + CHR(245) + "es"
1830:                 .FontName    = "Tahoma"
1831:                 .FontSize    = 8
1832:                 .Themes      = .T.
1833:                 .Visible     = .F.
1834:                 .ToolTipText = "Requisi" + CHR(231) + CHR(245) + "es de Material"
1835:             ENDWITH
1836: 
1837:             loc_oPage.AddObject("cmd_4c_SelEstoque", "CommandButton")
1838:             WITH loc_oPage.cmd_4c_SelEstoque
1839:                 .Top         = 2
1840:                 .Left        = 423
1841:                 .Width       = 75
1842:                 .Height      = 75
1843:                 .Caption     = "Estoques"
1844:                 .FontName    = "Tahoma"
1845:                 .FontSize    = 8
1846:                 .Themes      = .T.
1847:                 .Visible     = .F.
1848:                 .ToolTipText = "Selecionar Estoque"
1849:             ENDWITH
1850: 
1851:             loc_oPage.AddObject("cmd_4c_Disponivel", "CommandButton")
1852:             WITH loc_oPage.cmd_4c_Disponivel
1853:                 .Top         = 2
1854:                 .Left        = 498
1855:                 .Width       = 75
1856:                 .Height      = 75

*-- Linhas 1918 a 2085:
1918:                 .ToolTipText = "Autorizar edi" + CHR(231) + CHR(227) + "o de quantidade"
1919:             ENDWITH
1920: 
1921:             *-- BINDEVENTs
1922:             BINDEVENT(loc_oPage.cmd_4c_Pedras,     "Click", THIS, "BtnPedrasClick")
1923:             BINDEVENT(loc_oPage.cmd_4c_SelEstoque, "Click", THIS, "BtnSelEstoqueClick")
1924:             BINDEVENT(loc_oPage.cmd_4c_Disponivel, "Click", THIS, "BtnDisponivelClick")
1925:             BINDEVENT(loc_oPage.cmd_4c_TotLinha,   "Click", THIS, "BtnTotLinhaClick")
1926:             BINDEVENT(loc_oPage.cmd_4c_Processar,  "Click", THIS, "BtnProcessarClick")
1927:             BINDEVENT(loc_oPage.cmd_4c_Encerrar,   "Click", THIS, "BtnEncerrarClick")
1928:             BINDEVENT(loc_oPage.cmd_4c_Alteraqtd,  "Click", THIS, "BtnAlteraqtdClick")
1929: 
1930:         CATCH TO loc_oErro
1931:             MsgErro("Erro ao configurar bot" + CHR(245) + "es: " + loc_oErro.Message, "Erro")
1932:         ENDTRY
1933:     ENDPROC
1934: 
1935:     *--------------------------------------------------------------------------
1936:     * AjustarVisibilidadeBotoes - Reaplica visibilidade apos TornarControlesVisiveis
1937:     *--------------------------------------------------------------------------
1938:     PROTECTED PROCEDURE AjustarVisibilidadeBotoes()
1939: 
1940:         LOCAL loc_oPage
1941: 
1942:         TRY
1943:             loc_oPage = THIS.pgf_4c_1.Page1
1944:             IF PEMSTATUS(loc_oPage, "cmd_4c_Disponivel", 5)
1945:                 loc_oPage.cmd_4c_Disponivel.Visible = .F.
1946:             ENDIF
1947:             IF PEMSTATUS(loc_oPage, "cmd_4c_SelEstoque", 5) AND ;
1948:                !ISNULL(THIS.this_oBusinessObject) AND ISOBJECT(THIS.this_oBusinessObject)
1949:                 loc_oPage.cmd_4c_SelEstoque.Visible = THIS.this_oBusinessObject.this_lSelEstoqueVisivel
1950:             ENDIF
1951:             IF PEMSTATUS(loc_oPage, "cmd_4c_Pedras", 5) AND ;
1952:                !ISNULL(THIS.this_oBusinessObject) AND ISOBJECT(THIS.this_oBusinessObject)
1953:                 loc_oPage.cmd_4c_Pedras.Visible = THIS.this_oBusinessObject.this_lPedrasVisiveis
1954:             ENDIF
1955:         CATCH TO loc_oErro
1956:             MsgErro("Erro ao ajustar visibilidade: " + loc_oErro.Message, "Erro")
1957:         ENDTRY
1958:     ENDPROC
1959: 
1960:     *--------------------------------------------------------------------------
1961:     * AlternarPagina - Ativa pagina e gerencia estado das demais
1962:     *--------------------------------------------------------------------------
1963:     PROCEDURE AlternarPagina(par_nPagina)
1964: 
1965:         LOCAL loc_oPgf
1966: 
1967:         TRY
1968:             loc_oPgf = THIS.pgf_4c_1
1969: 
1970:             DO CASE
1971:             CASE par_nPagina <= 2
1972:                 loc_oPgf.Page1.Enabled = .T.
1973:                 loc_oPgf.Page2.Enabled = .T.
1974:                 loc_oPgf.Page3.Enabled = .F.
1975:                 loc_oPgf.Page4.Enabled = .F.
1976:                 loc_oPgf.Page5.Enabled = .F.
1977:                 loc_oPgf.Page6.Enabled = .F.
1978:             CASE par_nPagina = 3
1979:                 loc_oPgf.Page3.Enabled = .T.
1980:                 loc_oPgf.Page4.Enabled = .F.
1981:                 loc_oPgf.Page5.Enabled = .F.
1982:                 loc_oPgf.Page6.Enabled = .F.
1983:             CASE par_nPagina = 4
1984:                 loc_oPgf.Page3.Enabled = .F.
1985:                 loc_oPgf.Page4.Enabled = .T.
1986:                 loc_oPgf.Page5.Enabled = .F.
1987:                 loc_oPgf.Page6.Enabled = .F.
1988:             CASE par_nPagina = 5
1989:                 loc_oPgf.Page3.Enabled = .F.
1990:                 loc_oPgf.Page4.Enabled = .F.
1991:                 loc_oPgf.Page5.Enabled = .T.
1992:                 loc_oPgf.Page6.Enabled = .F.
1993:             CASE par_nPagina = 6
1994:                 loc_oPgf.Page3.Enabled = .F.
1995:                 loc_oPgf.Page4.Enabled = .F.
1996:                 loc_oPgf.Page5.Enabled = .F.
1997:                 loc_oPgf.Page6.Enabled = .T.
1998:             ENDCASE
1999: 
2000:             loc_oPgf.ActivePage = par_nPagina
2001: 
2002:         CATCH TO loc_oErro
2003:             MsgErro("Erro ao alternar p" + CHR(225) + "gina: " + loc_oErro.Message, "Erro")
2004:         ENDTRY
2005:     ENDPROC
2006: 
2007:     *--------------------------------------------------------------------------
2008:     * GradeItensAfterRowColChange - Atualiza painel ao mudar linha (BINDEVENT)
2009:     *--------------------------------------------------------------------------
2010:     PROCEDURE GradeItensAfterRowColChange
2011:         LPARAMETERS par_nColIndex
2012: 
2013:         LOCAL loc_oPage, loc_oCnt3, loc_oCnt5, loc_cCapCor, loc_cCapTam
2014: 
2015:         loc_cCapCor = ""
2016:         loc_cCapTam = ""
2017: 
2018:         IF !USED("TmpFinalg") OR BOF("TmpFinalg") OR EOF("TmpFinalg")
2019:             RETURN
2020:         ENDIF
2021: 
2022:         TRY
2023:             loc_oPage = THIS.pgf_4c_1.Page1
2024: 
2025:             *-- Filtra TmpSaldG pelo item atual
2026:             IF USED("TmpSaldG")
2027:                 SELECT TmpSaldG
2028:                 SET ORDER TO Cpros
2029:                 SET KEY TO ALLTRIM(TmpFinalg.Cpros) + ALLTRIM(TmpFinalg.CodCors) + ;
2030:                     ALLTRIM(TmpFinalg.CodTams)
2031:                 GO TOP
2032:             ENDIF
2033: 
2034:             *-- Filtra TmpFinal pelo item atual (Container1)
2035:             IF USED("TmpFinal")
2036:                 SELECT TmpFinal
2037:                 SET ORDER TO Cpros
2038:                 SET KEY TO ALLTRIM(TmpFinalg.Cpros) + ALLTRIM(TmpFinalg.CodCors) + ;
2039:                     ALLTRIM(TmpFinalg.CodTams)
2040:                 GO TOP
2041:             ENDIF
2042: 
2043:             *-- Totais de Container3 via TmpSaldo (registro unico por produto/cor/tam)
2044:             IF USED("TmpSaldo") AND SEEK(ALLTRIM(TmpFinalg.Cpros) + ;
2045:                ALLTRIM(TmpFinalg.CodCors) + ALLTRIM(TmpFinalg.CodTams), "TmpSaldo")
2046: 
2047:                 loc_oCnt3 = loc_oPage.cnt_4c_Container3
2048:                 IF PEMSTATUS(loc_oCnt3, "txt_4c_Tot_Qtd", 5)
2049:                     loc_oCnt3.txt_4c_Tot_Qtd.Value = TmpSaldo.Saldo
2050:                     loc_oCnt3.txt_4c_Tot_Est.Value = TmpSaldo.Saldo - TmpSaldo.Disps
2051:                     loc_oCnt3.txt_4c_Tot_Prz.Value = TmpSaldo.Disps
2052:                 ENDIF
2053: 
2054:                 loc_cCapCor = IIF(!EMPTY(ALLTRIM(TmpFinalg.CodCors)), ;
2055:                     " Cor:" + ALLTRIM(TmpFinalg.CodCors), "")
2056:                 loc_cCapTam = IIF(!EMPTY(ALLTRIM(TmpFinalg.CodTams)), ;
2057:                     " Tam:" + ALLTRIM(TmpFinalg.CodTams), "")
2058:                 IF PEMSTATUS(loc_oCnt3, "lbl_4c_Label1", 5)
2059:                     loc_oCnt3.lbl_4c_Label1.Caption = "Estoque Dispon" + CHR(237) + ;
2060:                         "vel " + ALLTRIM(TmpFinalg.Cpros) + loc_cCapCor + loc_cCapTam
2061:                 ENDIF
2062: 
2063:                 IF PEMSTATUS(loc_oCnt3, "grd_4c_EstDisp", 5)
2064:                     loc_oCnt3.grd_4c_EstDisp.Refresh
2065:                 ENDIF
2066:             ENDIF
2067: 
2068:             *-- Atualiza Container1 (TmpFinal ja filtrado)
2069:             IF PEMSTATUS(loc_oPage.cnt_4c_Container1, "grd_4c_EstProd", 5)
2070:                 loc_oPage.cnt_4c_Container1.grd_4c_EstProd.Refresh
2071:             ENDIF
2072: 
2073:             *-- Atualiza Container5 com produto/cor/tam
2074:             loc_oCnt5 = loc_oPage.cnt_4c_Container5
2075:             IF PEMSTATUS(loc_oCnt5, "txt_4c_Cpros", 5)
2076:                 loc_oCnt5.txt_4c_Cpros.Value = ALLTRIM(TmpFinalg.Cpros) + ;
2077:                     loc_cCapCor + loc_cCapTam
2078:             ENDIF
2079:             IF PEMSTATUS(loc_oCnt5, "txt_4c_Minima", 5)
2080:                 loc_oCnt5.txt_4c_Minima.Value = TmpFinalg.QtdMins
2081:             ENDIF
2082: 
2083:             *-- Carrega foto
2084:             THIS.CarregarFotoProduto(ALLTRIM(TmpFinalg.Cpros))
2085: 

*-- Linhas 2091 a 3182:
2091:     *--------------------------------------------------------------------------
2092:     * CarregarFotoProduto - Carrega imagem JPG do produto via SQL Server
2093:     *--------------------------------------------------------------------------
2094:     PROTECTED PROCEDURE CarregarFotoProduto(par_cCpros)
2095: 
2096:         LOCAL loc_cArquivo, loc_cSql, loc_cFoto, loc_oImg
2097: 
2098:         loc_cArquivo = ""
2099:         loc_cFoto    = ""
2100: 
2101:         TRY
2102:             loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
2103:             loc_cSql     = "SELECT a.cpros, a.FigJpgs FROM SigCdPro a " + ;
2104:                 "WHERE a.cpros = " + EscaparSQL(par_cCpros)
2105: 
2106:             IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_FotoPro") > 0 AND ;
2107:                USED("cursor_4c_FotoPro") AND RECCOUNT("cursor_4c_FotoPro") > 0
2108:                 SELECT cursor_4c_FotoPro
2109:                 IF !EMPTY(cursor_4c_FotoPro.FigJpgs) AND !ISNULL(cursor_4c_FotoPro.FigJpgs)
2110:                     loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_FotoPro.FigJpgs, ;
2111:                         "data:image/png;base64,",  ""), ;
2112:                         "data:image/jpeg;base64,", ""), ;
2113:                         "data:image/jpg;base64,",  ""), 14)
2114:                     =STRTOFILE(loc_cFoto, loc_cArquivo)
2115:                     loc_oImg = THIS.pgf_4c_1.Page1.img_4c_ImgFigJpg
2116:                     IF FILE(loc_cArquivo) AND PEMSTATUS(loc_oImg, "Picture", 5)
2117:                         loc_oImg.Picture = loc_cArquivo
2118:                         loc_oImg.Visible = .T.
2119:                     ENDIF
2120:                 ELSE
2121:                     THIS.pgf_4c_1.Page1.img_4c_ImgFigJpg.Visible = .F.
2122:                 ENDIF
2123:                 USE IN cursor_4c_FotoPro
2124:             ELSE
2125:                 IF PEMSTATUS(THIS.pgf_4c_1.Page1, "img_4c_ImgFigJpg", 5)
2126:                     THIS.pgf_4c_1.Page1.img_4c_ImgFigJpg.Visible = .F.
2127:                 ENDIF
2128:             ENDIF
2129:         CATCH TO loc_oErro
2130:             MsgErro("Erro ao carregar foto: " + loc_oErro.Message, "Erro")
2131:         ENDTRY
2132:     ENDPROC
2133: 
2134:     *--------------------------------------------------------------------------
2135:     * AtualizarTotaisPage1 - Calcula e exibe totais da grade de itens
2136:     *--------------------------------------------------------------------------
2137:     PROCEDURE AtualizarTotaisPage1()
2138: 
2139:         LOCAL loc_oPage, loc_nSaldo, loc_nEstoque, loc_nProduzir, loc_nFabrs
2140:         LOCAL loc_nProduzir2, loc_nRecno
2141: 
2142:         IF !USED("TmpFinalg") OR RECCOUNT("TmpFinalg") = 0
2143:             RETURN
2144:         ENDIF
2145: 
2146:         TRY
2147:             loc_oPage = THIS.pgf_4c_1.Page1
2148:             IF PEMSTATUS(loc_oPage, "txt_4c_Tot_Qtd", 5)
2149: 
2150:                 loc_nSaldo     = 0
2151:                 loc_nEstoque   = 0
2152:                 loc_nProduzir  = 0
2153:                 loc_nFabrs     = 0
2154:                 loc_nProduzir2 = 0
2155:                 loc_nRecno     = IIF(!BOF("TmpFinalg") AND !EOF("TmpFinalg"), ;
2156:                     RECNO("TmpFinalg"), 0)
2157: 
2158:                 SELECT TmpFinalg
2159:                 SUM Saldo, Estoque, Produzir, Fabrs, Produzir2 ;
2160:                     TO loc_nSaldo, loc_nEstoque, loc_nProduzir, loc_nFabrs, loc_nProduzir2
2161: 
2162:                 IF loc_nRecno > 0 AND RECCOUNT("TmpFinalg") >= loc_nRecno
2163:                     GO loc_nRecno IN TmpFinalg
2164:                 ENDIF
2165: 
2166:                 WITH loc_oPage
2167:                     .txt_4c_Tot_Qtd.Value  = loc_nSaldo
2168:                     .txt_4c_Tot_Est.Value  = loc_nEstoque
2169:                     .txt_4c_Tot_Prz.Value  = loc_nProduzir
2170:                     .txt_4c_Tot_prdc.Value = loc_nFabrs
2171:                     .txt_4c_Tot_prze.Value = loc_nProduzir2
2172:                     .txt_4c_Tot_Qtd.Refresh
2173:                     .txt_4c_Tot_Est.Refresh
2174:                     .txt_4c_Tot_Prz.Refresh
2175:                     .txt_4c_Tot_prdc.Refresh
2176:                     .txt_4c_Tot_prze.Refresh
2177:                 ENDWITH
2178:             ENDIF
2179:         CATCH TO loc_oErro
2180:             MsgErro("Erro ao atualizar totais: " + loc_oErro.Message, "Erro")
2181:         ENDTRY
2182:     ENDPROC
2183: 
2184:     *--------------------------------------------------------------------------
2185:     * ColC7When - Handler When da coluna 7 (Fabrs) - salva valor anterior
2186:     *--------------------------------------------------------------------------
2187:     PROCEDURE ColC7When
2188: 
2189:         LOCAL loc_lResultado
2190: 
2191:         loc_lResultado = .T.
2192:         TRY
2193:             IF USED("TmpFinalg") AND !EOF("TmpFinalg")
2194:                 THIS.this_nOldValue = TmpFinalg.Fabrs
2195:             ENDIF
2196:         CATCH TO loc_oErro
2197:             MsgErro("Erro em ColC7When: " + loc_oErro.Message, "Erro")
2198:         ENDTRY
2199:         RETURN loc_lResultado
2200:     ENDPROC
2201: 
2202:     *--------------------------------------------------------------------------
2203:     * ColC7Valid - Handler Valid da coluna 7 (Fabrs) - valida quantidade
2204:     *--------------------------------------------------------------------------
2205:     PROCEDURE ColC7Valid
2206: 
2207:         LOCAL loc_lResultado, loc_nNewVal, loc_oGrid, loc_nOld
2208: 
2209:         loc_lResultado = 1
2210: 
2211:         TRY
2212:             loc_oGrid   = THIS.pgf_4c_1.Page1.grd_4c_GradeItens
2213:             loc_nNewVal = loc_oGrid.Column7.Text1.Value
2214:             loc_nOld    = THIS.this_nOldValue
2215: 
2216:             IF USED("TmpFinalg") AND !EOF("TmpFinalg") AND USED("TmpSaldU")
2217:                 IF !SEEK(ALLTRIM(TmpFinalg.Cpros), "TmpSaldU", "Cpros")
2218:                     INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinalg.Cpros)
2219:                 ENDIF
2220: 
2221:                 IF loc_nNewVal <> loc_nOld AND TmpSaldU.KeySelmp
2222:                     IF !MsgConfirma("Produto com Sele" + CHR(231) + CHR(227) + ;
2223:                         "o Manual de OP." + CHR(13) + ;
2224:                         "O sistema ir" + CHR(225) + " acionar o modo autom" + ;
2225:                         CHR(225) + "tico. Deseja Continuar?")
2226:                         loc_oGrid.Column7.Text1.Value = loc_nOld
2227:                         loc_lResultado = 0
2228:                     ENDIF
2229:                 ENDIF
2230:             ENDIF
2231: 
2232:             IF loc_lResultado = 1 AND USED("TmpFinalg") AND !EOF("TmpFinalg")
2233:                 DO CASE
2234:                 CASE loc_nNewVal = loc_nOld
2235:                     *-- Sem mudanca
2236:                 CASE loc_nNewVal < 0
2237:                     MsgAviso("A quantidade n" + CHR(227) + "o pode ser um valor negativo!!!")
2238:                     loc_oGrid.Column7.Text1.Value = loc_nOld
2239:                     loc_lResultado = 0
2240:                 CASE loc_nNewVal > TmpFinalg.Saldo
2241:                     MsgAviso("A Quantidade n" + CHR(227) + "o pode ser maior que a do Pedido!!!")
2242:                     loc_oGrid.Column7.Text1.Value = loc_nOld
2243:                     loc_lResultado = 0
2244:                 OTHERWISE
2245:                     SELECT TmpFinalg
2246:                     REPLACE Fabrs WITH loc_nNewVal
2247:                 ENDCASE
2248:             ENDIF
2249:         CATCH TO loc_oErro
2250:             MsgErro("Erro na valida" + CHR(231) + CHR(227) + "o da coluna 7: " + ;
2251:                 loc_oErro.Message, "Erro")
2252:             loc_lResultado = 0
2253:         ENDTRY
2254:         RETURN loc_lResultado
2255:     ENDPROC
2256: 
2257:     *--------------------------------------------------------------------------
2258:     * ColC7LostFocus - Handler LostFocus da coluna 7 - atualiza totais
2259:     *--------------------------------------------------------------------------
2260:     PROCEDURE ColC7LostFocus
2261:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
2262:         THIS.AtualizarTotaisPage1()
2263:     ENDPROC
2264: 
2265:     *--------------------------------------------------------------------------
2266:     * ColC8When - Handler When da coluna 8 (Produzir2) - verifica liberacao
2267:     *--------------------------------------------------------------------------
2268:     PROCEDURE ColC8When
2269: 
2270:         LOCAL loc_lResultado
2271: 
2272:         loc_lResultado = IIF(THIS.this_lLiberado, 1, 0)
2273:         RETURN loc_lResultado
2274:     ENDPROC
2275: 
2276:     *--------------------------------------------------------------------------
2277:     * ColC8LostFocus - Handler LostFocus da coluna 8 - reseta liberacao
2278:     *--------------------------------------------------------------------------
2279:     PROCEDURE ColC8LostFocus
2280:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
2281:         THIS.this_lLiberado = .F.
2282:     ENDPROC
2283: 
2284:     *--------------------------------------------------------------------------
2285:     * ColC10When - Handler When da coluna 10 (Estoque) - salva e checa disponivel
2286:     *--------------------------------------------------------------------------
2287:     PROCEDURE ColC10When
2288: 
2289:         LOCAL loc_lResultado, loc_cSql, loc_lMostraDisp
2290: 
2291:         loc_lResultado  = .T.
2292:         loc_lMostraDisp = .F.
2293: 
2294:         TRY
2295:             IF USED("TmpFinalg") AND !EOF("TmpFinalg")
2296:                 THIS.this_nOldValue = TmpFinalg.Estoque
2297:             ENDIF
2298: 
2299:             IF PEMSTATUS(THIS.pgf_4c_1.Page1, "cmd_4c_Disponivel", 5)
2300:                 THIS.pgf_4c_1.Page1.cmd_4c_Disponivel.Visible = .F.
2301:             ENDIF
2302: 
2303:             *-- Em modo reserva com estoque zero, verifica tipo do grupo
2304:             IF USED("TmpFinalg") AND !EOF("TmpFinalg") AND ;
2305:                !ISNULL(THIS.this_oBusinessObject) AND ISOBJECT(THIS.this_oBusinessObject)
2306:                 IF THIS.this_oBusinessObject.this_lReserva AND TmpFinalg.Estoque = 0
2307:                     loc_cSql = "SELECT a.CGrus, b.TipoEstos " + ;
2308:                         "FROM SigCdPro a INNER JOIN SigCdGrp b ON a.CGrus = b.CGrus " + ;
2309:                         "WHERE a.CPros = " + EscaparSQL(ALLTRIM(TmpFinalg.Cpros))
2310:                     IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_GrpTipo") > 0 AND ;
2311:                        USED("cursor_4c_GrpTipo") AND RECCOUNT("cursor_4c_GrpTipo") > 0
2312:                         SELECT cursor_4c_GrpTipo
2313:                         loc_lMostraDisp = INLIST(cursor_4c_GrpTipo.TipoEstos, 3, 4)
2314:                         USE IN cursor_4c_GrpTipo
2315:                         IF loc_lMostraDisp AND ;
2316:                            PEMSTATUS(THIS.pgf_4c_1.Page1, "cmd_4c_Disponivel", 5)
2317:                             THIS.pgf_4c_1.Page1.cmd_4c_Disponivel.Visible = .T.
2318:                         ENDIF
2319:                     ENDIF
2320:                 ENDIF
2321:             ENDIF
2322:         CATCH TO loc_oErro
2323:             MsgErro("Erro em ColC10When: " + loc_oErro.Message, "Erro")
2324:         ENDTRY
2325:         RETURN loc_lResultado
2326:     ENDPROC
2327: 
2328:     *--------------------------------------------------------------------------
2329:     * ColC10Valid - Handler Valid da coluna 10 (Estoque) - valida quantidade
2330:     *--------------------------------------------------------------------------
2331:     PROCEDURE ColC10Valid
2332: 
2333:         LOCAL loc_lResultado, loc_nNewVal, loc_oGrid, loc_nOld
2334: 
2335:         loc_lResultado = 1
2336: 
2337:         TRY
2338:             loc_oGrid   = THIS.pgf_4c_1.Page1.grd_4c_GradeItens
2339:             loc_nNewVal = loc_oGrid.Column10.Text1.Value
2340:             loc_nOld    = THIS.this_nOldValue
2341: 
2342:             IF USED("TmpFinalg") AND !EOF("TmpFinalg") AND USED("TmpSaldU")
2343:                 IF !SEEK(ALLTRIM(TmpFinalg.Cpros), "TmpSaldU", "Cpros")
2344:                     INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinalg.Cpros)
2345:                 ENDIF
2346: 
2347:                 IF loc_nNewVal <> loc_nOld AND TmpSaldU.KeySelm
2348:                     IF !MsgConfirma("Produto com Sele" + CHR(231) + CHR(227) + ;
2349:                         "o Manual de estoque." + CHR(13) + ;
2350:                         "O sistema ir" + CHR(225) + " acionar o modo autom" + ;
2351:                         CHR(225) + "tico. Deseja Continuar?")
2352:                         loc_oGrid.Column10.Text1.Value = loc_nOld
2353:                         loc_lResultado = 0
2354:                     ENDIF
2355:                 ENDIF
2356:             ENDIF
2357: 
2358:             IF loc_lResultado = 1 AND USED("TmpFinalg") AND !EOF("TmpFinalg")
2359:                 DO CASE
2360:                 CASE loc_nNewVal = loc_nOld
2361:                     *-- Sem mudanca
2362:                 CASE loc_nNewVal < 0
2363:                     MsgAviso("A quantidade n" + CHR(227) + "o pode ser um valor negativo!!!")
2364:                     loc_oGrid.Column10.Text1.Value = loc_nOld
2365:                     loc_lResultado = 0
2366:                 OTHERWISE
2367:                     SELECT TmpFinalg
2368:                     REPLACE Estoque WITH loc_nNewVal
2369:                 ENDCASE
2370:             ENDIF
2371:         CATCH TO loc_oErro
2372:             MsgErro("Erro na valida" + CHR(231) + CHR(227) + "o da coluna 10: " + ;
2373:                 loc_oErro.Message, "Erro")
2374:             loc_lResultado = 0
2375:         ENDTRY
2376:         RETURN loc_lResultado
2377:     ENDPROC
2378: 
2379:     *--------------------------------------------------------------------------
2380:     * ColC10LostFocus - Handler LostFocus da coluna 10 - atualiza totais
2381:     *--------------------------------------------------------------------------
2382:     PROCEDURE ColC10LostFocus
2383:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
2384:         THIS.AtualizarTotaisPage1()
2385:     ENDPROC
2386: 
2387:     *--------------------------------------------------------------------------
2388:     * EstDispC6When - Handler When da coluna Prior do grd_4c_EstDisp
2389:     *--------------------------------------------------------------------------
2390:     PROCEDURE EstDispC6When
2391: 
2392:         LOCAL loc_lResultado
2393: 
2394:         loc_lResultado = 0
2395:         TRY
2396:             IF USED("TmpFinalg") AND !EOF("TmpFinalg")
2397:                 loc_lResultado = IIF(TmpFinalg.Produzir + TmpFinalg.Fabrs = TmpFinalg.Saldo, 1, 0)
2398:             ENDIF
2399:         CATCH TO loc_oErro
2400:             MsgErro("Erro em EstDispC6When: " + loc_oErro.Message, "Erro")
2401:         ENDTRY
2402:         RETURN loc_lResultado
2403:     ENDPROC
2404: 
2405:     *--------------------------------------------------------------------------
2406:     * EstDispC6LostFocus - Handler LostFocus da coluna Prior do grd_4c_EstDisp
2407:     *--------------------------------------------------------------------------
2408:     PROCEDURE EstDispC6LostFocus
2409:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
2410: 
2411:         TRY
2412:             IF USED("TmpSaldG") AND RECCOUNT("TmpSaldG") > 0
2413:                 SELECT TmpSaldG
2414:                 SKIP
2415:                 SKIP -1
2416:                 IF PEMSTATUS(THIS.pgf_4c_1.Page1.cnt_4c_Container3, "grd_4c_EstDisp", 5)
2417:                     THIS.pgf_4c_1.Page1.cnt_4c_Container3.grd_4c_EstDisp.Refresh
2418:                 ENDIF
2419:             ENDIF
2420:         CATCH TO loc_oErro
2421:             MsgErro("Erro em EstDispC6LostFocus: " + loc_oErro.Message, "Erro")
2422:         ENDTRY
2423:     ENDPROC
2424: 
2425:     *--------------------------------------------------------------------------
2426:     * ColC3Click - Handler Click na coluna 3 - navega para Page2 (detalhes)
2427:     *--------------------------------------------------------------------------
2428:     PROCEDURE ColC3Click
2429: 
2430:         TRY
2431:             THIS.pgf_4c_1.ActivePage = 2
2432:         CATCH TO loc_oErro
2433:             MsgErro("Erro ao navegar para Page2: " + loc_oErro.Message, "Erro")
2434:         ENDTRY
2435:     ENDPROC
2436: 
2437:     *--------------------------------------------------------------------------
2438:     * ImgFigJpgClick - Handler Click na imagem do produto
2439:     *--------------------------------------------------------------------------
2440:     PROCEDURE ImgFigJpgClick
2441: 
2442:         TRY
2443:             IF USED("TmpFinalg") AND !EOF("TmpFinalg")
2444:                 THIS.CarregarFotoProduto(ALLTRIM(TmpFinalg.Cpros))
2445:             ENDIF
2446:         CATCH TO loc_oErro
2447:             MsgErro("Erro ao carregar foto: " + loc_oErro.Message, "Erro")
2448:         ENDTRY
2449:     ENDPROC
2450: 
2451:     *--------------------------------------------------------------------------
2452:     * BtnPedrasClick - Abre Page6 com requisicoes de material
2453:     *--------------------------------------------------------------------------
2454:     PROCEDURE BtnPedrasClick
2455: 
2456:         LOCAL loc_lResultado, loc_cCpro
2457: 
2458:         loc_lResultado = .F.
2459:         TRY
2460:             IF USED("TmpFinalg") AND !EOF("TmpFinalg")
2461:                 loc_cCpro = ALLTRIM(TmpFinalg.Cpros)
2462: 
2463:                 IF USED("SelPedra")
2464:                     IF PEMSTATUS(THIS.pgf_4c_1.Page6, "grd_4c_GradePedra", 5)
2465:                         THIS.pgf_4c_1.Page6.grd_4c_GradePedra.RecordSource = ""
2466:                     ENDIF
2467:                     USE IN SelPedra
2468:                 ENDIF
2469: 
2470:                 IF USED("CrSigCdPac")
2471:                     SELECT Cpros, Dpros, Cunis, Qtdes, CodPros, ;
2472:                         SPACE(14) AS Cpro2s ;
2473:                         FROM CrSigCdPac ;
2474:                         INTO CURSOR SelPedra ORDER BY Cpros READWRITE
2475: 
2476:                     IF RECCOUNT("SelPedra") > 0
2477:                         IF PEMSTATUS(THIS.pgf_4c_1.Page6, "grd_4c_GradePedra", 5)
2478:                             THIS.pgf_4c_1.Page6.grd_4c_GradePedra.RecordSource = "SelPedra"
2479:                         ENDIF
2480:                         IF PEMSTATUS(THIS.pgf_4c_1.Page6, "txt_4c_Cpros", 5)
2481:                             THIS.pgf_4c_1.Page6.txt_4c_Cpros.Value = loc_cCpro
2482:                         ENDIF
2483:                         THIS.AlternarPagina(6)
2484:                         loc_lResultado = .T.
2485:                     ELSE
2486:                         MsgAviso("Nenhuma requisi" + CHR(231) + CHR(227) + ;
2487:                             "o de material para este produto.")
2488:                         IF USED("SelPedra")
2489:                             USE IN SelPedra
2490:                         ENDIF
2491:                     ENDIF
2492:                 ENDIF
2493:             ENDIF
2494:         CATCH TO loc_oErro
2495:             MsgErro("Erro ao exibir requisi" + CHR(231) + CHR(245) + "es: " + ;
2496:                 loc_oErro.Message, "Erro")
2497:         ENDTRY
2498:     ENDPROC
2499: 
2500:     *--------------------------------------------------------------------------
2501:     * BtnSelEstoqueClick - Abre Page4 com selecao de estoque disponivel
2502:     *--------------------------------------------------------------------------
2503:     PROCEDURE BtnSelEstoqueClick
2504: 
2505:         LOCAL loc_lResultado, loc_cCpro, loc_cCor, loc_cTam
2506: 
2507:         loc_lResultado = .F.
2508:         TRY
2509:             IF USED("TmpFinalg") AND !EOF("TmpFinalg")
2510:                 loc_cCpro = ALLTRIM(TmpFinalg.Cpros)
2511:                 loc_cCor  = ALLTRIM(TmpFinalg.CodCors)
2512:                 loc_cTam  = ALLTRIM(TmpFinalg.CodTams)
2513: 
2514:                 IF USED("TmpDisp")
2515:                     IF PEMSTATUS(THIS.pgf_4c_1.Page4, "grd_4c_GradeDisp", 5)
2516:                         THIS.pgf_4c_1.Page4.grd_4c_GradeDisp.RecordSource = ""
2517:                     ENDIF
2518:                     USE IN TmpDisp
2519:                 ENDIF
2520: 
2521:                 SELECT Priors, Grupos, Estos, Cpros, CodCors, CodTams, Disps, ;
2522:                     0.000 AS Utilizar ;
2523:                     FROM TmpSaldG ;
2524:                     WHERE Cpros = m.loc_cCpro AND CodCors = m.loc_cCor AND ;
2525:                     CodTams = m.loc_cTam AND Disps > 0 ;
2526:                     INTO CURSOR TmpDisp ORDER BY Priors, Grupos, Estos, Cpros READWRITE
2527: 
2528:                 IF RECCOUNT("TmpDisp") > 0
2529:                     IF PEMSTATUS(THIS.pgf_4c_1.Page4, "txt_4c_Cpros", 5)
2530:                         THIS.pgf_4c_1.Page4.txt_4c_Cpros.Value = loc_cCpro + ;
2531:                             IIF(!EMPTY(loc_cCor), " Cor:" + loc_cCor, "") + ;
2532:                             IIF(!EMPTY(loc_cTam), " Tam:" + loc_cTam, "")
2533:                     ENDIF
2534:                     IF PEMSTATUS(THIS.pgf_4c_1.Page4, "txt_4c_Qt_pedida", 5)
2535:                         THIS.pgf_4c_1.Page4.txt_4c_Qt_pedida.Value = TmpFinalg.Saldo
2536:                     ENDIF
2537:                     IF PEMSTATUS(THIS.pgf_4c_1.Page4, "txt_4c_Qt_Selec", 5)
2538:                         THIS.pgf_4c_1.Page4.txt_4c_Qt_Selec.Value = 0
2539:                     ENDIF
2540:                     THIS.AlternarPagina(4)
2541:                     loc_lResultado = .T.
2542:                 ELSE
2543:                     MsgAviso("Nenhum estoque dispon" + CHR(237) + "vel para este item.")
2544:                     IF USED("TmpDisp")
2545:                         USE IN TmpDisp
2546:                     ENDIF
2547:                 ENDIF
2548:             ENDIF
2549:         CATCH TO loc_oErro
2550:             MsgErro("Erro ao selecionar estoque: " + loc_oErro.Message, "Erro")
2551:         ENDTRY
2552:     ENDPROC
2553: 
2554:     *--------------------------------------------------------------------------
2555:     * BtnDisponivelClick - Abre Page5 com disponivel por tamanho
2556:     *--------------------------------------------------------------------------
2557:     PROCEDURE BtnDisponivelClick
2558: 
2559:         LOCAL loc_lResultado, loc_cCpro, loc_cCor
2560: 
2561:         loc_lResultado = .F.
2562:         TRY
2563:             IF !USED("TmpFinalg") OR EOF("TmpFinalg")
2564:                 *-- sem dados
2565:             ELSE
2566:                 IF TmpFinalg.Estoque <> 0 OR TmpFinalg.Fabrs <> 0
2567:                 MsgAviso("Quantidade de Estoque e Produ" + CHR(231) + CHR(227) + ;
2568:                     "o tem estar Zero antes deste Processo!!!")
2569:                 IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5)
2570:                     THIS.pgf_4c_1.Page1.grd_4c_GradeItens.SetFocus
2571:                 ENDIF
2572:             ELSE
2573:                 loc_cCpro = ALLTRIM(TmpFinalg.Cpros)
2574:                 loc_cCor  = ALLTRIM(TmpFinalg.CodCors)
2575: 
2576:                 IF USED("TmpDisp")
2577:                     IF PEMSTATUS(THIS.pgf_4c_1.Page5, "grd_4c_GradeDisp", 5)
2578:                         THIS.pgf_4c_1.Page5.grd_4c_GradeDisp.RecordSource = ""
2579:                     ENDIF
2580:                     USE IN TmpDisp
2581:                 ENDIF
2582: 
2583:                 SELECT Cpros, CodCors, CodTams, Disps, 0.000 AS Utilizar ;
2584:                     FROM TmpSaldo ;
2585:                     WHERE Cpros = m.loc_cCpro AND CodCors = m.loc_cCor AND Disps > 0 ;
2586:                     INTO CURSOR TmpDisp ORDER BY CodTams READWRITE
2587: 
2588:                 IF RECCOUNT("TmpDisp") > 0
2589:                     IF PEMSTATUS(THIS.pgf_4c_1.Page5, "txt_4c_Cpros", 5)
2590:                         THIS.pgf_4c_1.Page5.txt_4c_Cpros.Value = loc_cCpro + ;
2591:                             IIF(!EMPTY(loc_cCor), " Cor:" + loc_cCor, "")
2592:                     ENDIF
2593:                     IF PEMSTATUS(THIS.pgf_4c_1.Page5, "txt_4c_Qt_pedida", 5)
2594:                         THIS.pgf_4c_1.Page5.txt_4c_Qt_pedida.Value = TmpFinalg.Saldo
2595:                     ENDIF
2596:                     IF PEMSTATUS(THIS.pgf_4c_1.Page5, "txt_4c_Qt_Selec", 5)
2597:                         THIS.pgf_4c_1.Page5.txt_4c_Qt_Selec.Value = 0
2598:                     ENDIF
2599:                     THIS.AlternarPagina(5)
2600:                     loc_lResultado = .T.
2601:                 ELSE
2602:                     MsgAviso("Nenhum disponivel para este item.")
2603:                     IF USED("TmpDisp")
2604:                         USE IN TmpDisp
2605:                     ENDIF
2606:                 ENDIF
2607:                 ENDIF
2608:             ENDIF
2609:         CATCH TO loc_oErro
2610:             MsgErro("Erro ao exibir dispon" + CHR(237) + "veis: " + loc_oErro.Message, "Erro")
2611:         ENDTRY
2612:     ENDPROC
2613: 
2614:     *--------------------------------------------------------------------------
2615:     * BtnTotLinhaClick - Agrupa totais por linha e exibe na Page3
2616:     *--------------------------------------------------------------------------
2617:     PROCEDURE BtnTotLinhaClick
2618: 
2619:         LOCAL loc_lResultado
2620: 
2621:         loc_lResultado = .F.
2622:         TRY
2623:             IF !USED("TmpFinalg") OR RECCOUNT("TmpFinalg") = 0
2624:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " dados para totalizar.")
2625:             ELSE
2626:                 IF USED("TmpLinha")
2627:                     IF PEMSTATUS(THIS.pgf_4c_1.Page3, "grd_4c_GradeLinhas", 5)
2628:                         THIS.pgf_4c_1.Page3.grd_4c_GradeLinhas.RecordSource = ""
2629:                     ENDIF
2630:                 ENDIF
2631: 
2632:                 SELECT Linhas, 0 AS Ordem, SUM(Saldo) AS Saldo, ;
2633:                     SUM(Estoque) AS Estoque, SUM(Produzir) AS Produzir, SUM(Fabrs) AS Fabrs ;
2634:                     FROM TmpFinalg GROUP BY 1 ;
2635:                     UNION ALL ;
2636:                     SELECT PADR("TOTAIS", 10) AS Linhas, 1 AS Ordem, ;
2637:                     SUM(Saldo) AS Saldo, SUM(Estoque) AS Estoque, ;
2638:                     SUM(Produzir) AS Produzir, SUM(Fabrs) AS Fabrs ;
2639:                     FROM TmpFinalg GROUP BY 1 ;
2640:                     INTO CURSOR TmpLinha ORDER BY 2, 1
2641: 
2642:                 THIS.AlternarPagina(3)
2643:                 loc_lResultado = .T.
2644:             ENDIF
2645:         CATCH TO loc_oErro
2646:             MsgErro("Erro ao calcular totais por linha: " + loc_oErro.Message, "Erro")
2647:         ENDTRY
2648:     ENDPROC
2649: 
2650:     *--------------------------------------------------------------------------
2651:     * BtnProcessarClick - Processa globalizacao via BO
2652:     *--------------------------------------------------------------------------
2653:     PROCEDURE BtnProcessarClick
2654: 
2655:         LOCAL loc_lResultado
2656: 
2657:         loc_lResultado = .F.
2658:         THIS.MostrarAguarde("Processando Globaliza" + CHR(231) + CHR(227) + "o...")
2659:         TRY
2660:             IF THIS.this_oBusinessObject.ProcessarGlobalizacao()
2661:                 THIS.AtualizarTotaisPage1()
2662:                 IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5)
2663:                     THIS.pgf_4c_1.Page1.grd_4c_GradeItens.Refresh
2664:                 ENDIF
2665:                 loc_lResultado = .T.
2666:             ENDIF
2667:         CATCH TO loc_oErro
2668:             MsgErro("Erro ao processar: " + loc_oErro.Message, "Erro")
2669:         ENDTRY
2670:         THIS.OcultarAguarde()
2671:     ENDPROC
2672: 
2673:     *--------------------------------------------------------------------------
2674:     * BtnEncerrarClick - Encerra o form filho e reativa o form pai
2675:     *--------------------------------------------------------------------------
2676:     PROCEDURE BtnEncerrarClick
2677: 
2678:         TRY
2679:             IF !ISNULL(THIS.this_oParentForm) AND ISOBJECT(THIS.this_oParentForm)
2680:                 THIS.this_oParentForm.Enabled = .T.
2681:             ENDIF
2682:         CATCH TO loc_oErro
2683:             MsgErro("Erro ao encerrar: " + loc_oErro.Message, "Erro")
2684:         ENDTRY
2685:         THIS.Release()
2686:     ENDPROC
2687: 
2688:     *--------------------------------------------------------------------------
2689:     * BtnAlteraqtdClick - Autoriza edicao de quantidade para estoque (senha)
2690:     *--------------------------------------------------------------------------
2691:     PROCEDURE BtnAlteraqtdClick
2692: 
2693:         LOCAL loc_lResultado, loc_cString, loc_cRetorno, loc_lOk
2694: 
2695:         loc_lResultado = .F.
2696:         loc_cRetorno   = ""
2697:         loc_lOk        = .F.
2698: 
2699:         TRY
2700:             IF !USED("TmpFinalg") OR EOF("TmpFinalg")
2701:                 *-- sem acao
2702:             ELSE
2703:                 IF TmpFinalg.Produzir2 = 0
2704:                 MsgAviso("Referencia Sem Quantidade a Produzir para Estoque!!!")
2705:                 IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5)
2706:                     THIS.pgf_4c_1.Page1.grd_4c_GradeItens.SetFocus
2707:                 ENDIF
2708:             ELSE
2709:                 loc_cString = ALLTRIM(TmpFinalg.Cpros) + " Qt.Min:" + ;
2710:                     ALLTRIM(TRANSFORM(TmpFinalg.QtdMins, "@Z 99999.999")) + " " + ;
2711:                     "Qt.Est:" + ALLTRIM(TRANSFORM(TmpFinalg.Produzir2, "@Z 99999.999"))
2712: 
2713:                 DO FORM SigOpSen WITH "PRDZRISCO", loc_cString, "" TO loc_cRetorno
2714: 
2715:                 CLEAR TYPEAHEAD
2716:                 loc_lOk = (LEFT(loc_cRetorno, 1) = "*")
2717: 
2718:                 IF loc_lOk
2719:                     THIS.this_lLiberado = .T.
2720:                     IF PEMSTATUS(THIS.pgf_4c_1.Page1.grd_4c_GradeItens, "Column8", 5)
2721:                         THIS.pgf_4c_1.Page1.grd_4c_GradeItens.Column8.SetFocus
2722:                     ENDIF
2723:                     loc_lResultado = .T.
2724:                 ELSE
2725:                     MsgAviso("Altera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
2726:                         "o autorizada!!!")
2727:                 ENDIF
2728:                 ENDIF
2729:             ENDIF
2730:         CATCH TO loc_oErro
2731:             MsgErro("Erro em Alteraqtd: " + loc_oErro.Message, "Erro")
2732:         ENDTRY
2733:     ENDPROC
2734: 
2735:     *--------------------------------------------------------------------------
2736:     * Pagina2Activate - Inicializa selecao de estoque/producao ao entrar na Page2
2737:     *--------------------------------------------------------------------------
2738:     PROCEDURE Pagina2Activate()
2739:         LOCAL loc_cCpros, loc_nOldRecno
2740: 
2741:         TRY
2742:             IF USED("TmpFinalg") AND !EOF("TmpFinalg")
2743:                 loc_cCpros = ALLTRIM(TmpFinalg.Cpros)
2744: 
2745:                 THIS.this_nTotSEst = TmpFinalg.Estoque
2746:                 THIS.this_nTotSPrc = TmpFinalg.Fabrs
2747: 
2748:                 IF USED("TmpFinal")
2749:                     loc_nOldRecno = IIF(RECCOUNT("TmpFinal") > 0, RECNO("TmpFinal"), 0)
2750:                     SELECT TmpFinal
2751:                     SET KEY TO (m.loc_cCpros)
2752:                     THIS.AtualizarTotaisPage2()
2753:                     IF loc_nOldRecno > 0 AND loc_nOldRecno <= RECCOUNT("TmpFinal")
2754:                         GO loc_nOldRecno IN TmpFinal
2755:                     ENDIF
2756:                 ENDIF
2757: 
2758:                 IF PEMSTATUS(THIS.pgf_4c_1.Page2, "txt_4c_Tot_sEst", 5)
2759:                     THIS.pgf_4c_1.Page2.txt_4c_Tot_sEst.Value = THIS.this_nTotSEst
2760:                 ENDIF
2761:                 IF PEMSTATUS(THIS.pgf_4c_1.Page2, "txt_4c_Tot_sPrc", 5)
2762:                     THIS.pgf_4c_1.Page2.txt_4c_Tot_sPrc.Value = THIS.this_nTotSPrc
2763:                 ENDIF
2764: 
2765:                 IF PEMSTATUS(THIS.pgf_4c_1.Page2, "edt_4c_ObsItens", 5) AND USED("TmpFinal") AND !EOF("TmpFinal")
2766:                     THIS.pgf_4c_1.Page2.edt_4c_ObsItens.Value = ALLTRIM(TmpFinal.CodObs)
2767:                 ENDIF
2768:             ENDIF
2769:         CATCH TO loc_oErro
2770:             MsgErro("Erro em Pagina2Activate: " + loc_oErro.Message, "Erro")
2771:         ENDTRY
2772:     ENDPROC
2773: 
2774:     *--------------------------------------------------------------------------
2775:     * AtualizarTotaisPage2 - Recalcula totais do grid de Page2
2776:     *--------------------------------------------------------------------------
2777:     PROCEDURE AtualizarTotaisPage2()
2778:         LOCAL loc_nOldRecno, loc_nSaldo, loc_nEstoque, loc_nProduzir, loc_nFabrs
2779: 
2780:         TRY
2781:             IF USED("TmpFinal") AND RECCOUNT("TmpFinal") > 0
2782:                 loc_nOldRecno = RECNO("TmpFinal")
2783:                 SELECT TmpFinal
2784:                 loc_nSaldo    = 0
2785:                 loc_nEstoque  = 0
2786:                 loc_nProduzir = 0
2787:                 loc_nFabrs    = 0
2788:                 SUM Saldo, Estoque, Produzir, Fabrs ;
2789:                     TO loc_nSaldo, loc_nEstoque, loc_nProduzir, loc_nFabrs
2790:                 IF loc_nOldRecno > 0 AND loc_nOldRecno <= RECCOUNT("TmpFinal")
2791:                     GO loc_nOldRecno
2792:                 ENDIF
2793: 
2794:                 IF PEMSTATUS(THIS.pgf_4c_1.Page2, "txt_4c_TotQtdP2", 5)
2795:                     THIS.pgf_4c_1.Page2.txt_4c_TotQtdP2.Value = loc_nSaldo
2796:                 ENDIF
2797:                 IF PEMSTATUS(THIS.pgf_4c_1.Page2, "txt_4c_TotEstP2", 5)
2798:                     THIS.pgf_4c_1.Page2.txt_4c_TotEstP2.Value = loc_nEstoque
2799:                 ENDIF
2800:                 IF PEMSTATUS(THIS.pgf_4c_1.Page2, "txt_4c_TotPrzP2", 5)
2801:                     THIS.pgf_4c_1.Page2.txt_4c_TotPrzP2.Value = loc_nProduzir
2802:                 ENDIF
2803:                 IF PEMSTATUS(THIS.pgf_4c_1.Page2, "txt_4c_TotPrcP2", 5)
2804:                     THIS.pgf_4c_1.Page2.txt_4c_TotPrcP2.Value = loc_nFabrs
2805:                 ENDIF
2806: 
2807:                 THIS.this_oBusinessObject.this_nTotQtdP2  = loc_nSaldo
2808:                 THIS.this_oBusinessObject.this_nTotEstP2  = loc_nEstoque
2809:                 THIS.this_oBusinessObject.this_nTotPrzP2  = loc_nProduzir
2810:                 THIS.this_oBusinessObject.this_nTotPrcP2  = loc_nFabrs
2811:             ENDIF
2812:         CATCH TO loc_oErro
2813:             MsgErro("Erro em AtualizarTotaisPage2: " + loc_oErro.Message, "Erro")
2814:         ENDTRY
2815:     ENDPROC
2816: 
2817:     *--------------------------------------------------------------------------
2818:     * P2GradeAfterRowColChange - Atualiza obs/foto ao mudar linha no grid P2
2819:     *--------------------------------------------------------------------------
2820:     PROCEDURE P2GradeAfterRowColChange(par_nColIndex)
2821:         LOCAL loc_cCpros, loc_oRS, loc_nRes, loc_cSQL
2822: 
2823:         TRY
2824:             IF USED("TmpFinal") AND !EOF("TmpFinal")
2825:                 loc_cCpros = ALLTRIM(TmpFinal.Cpros)
2826: 
2827:                 IF PEMSTATUS(THIS.pgf_4c_1.Page2, "edt_4c_ObsItens", 5)
2828:                     THIS.pgf_4c_1.Page2.edt_4c_ObsItens.Value = ALLTRIM(TmpFinal.CodObs)
2829:                 ENDIF
2830: 
2831:                 IF PEMSTATUS(THIS.pgf_4c_1.Page2, "lbl_4c_Txt_ObsItens", 5)
2832:                     THIS.pgf_4c_1.Page2.lbl_4c_Txt_ObsItens.Caption = ALLTRIM(TmpFinal.Cpros)
2833:                 ENDIF
2834: 
2835:                 IF !EMPTY(loc_cCpros) AND gnConnHandle > 0
2836:                     loc_cSQL = "SELECT TOP 1 Fotos FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCpros)
2837:                     loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FotoP2")
2838:                     IF loc_nRes > 0 AND USED("cursor_4c_FotoP2") AND !EOF("cursor_4c_FotoP2")
2839:                         IF !EMPTY(cursor_4c_FotoP2.Fotos) AND PEMSTATUS(THIS.pgf_4c_1.Page2, "img_4c_ImgFigJpg", 5)
2840:                             THIS.pgf_4c_1.Page2.img_4c_ImgFigJpg.PictureVal = STRCONV(cursor_4c_FotoP2.Fotos, 14)
2841:                         ENDIF
2842:                         USE IN cursor_4c_FotoP2
2843:                     ENDIF
2844:                 ENDIF
2845:             ENDIF
2846:         CATCH TO loc_oErro
2847:             MsgErro("Erro em P2GradeAfterRowColChange: " + loc_oErro.Message, "Erro")
2848:         ENDTRY
2849:     ENDPROC
2850: 
2851:     *--------------------------------------------------------------------------
2852:     * P2ColGotFocusToCol7 - Redireciona foco para coluna Estoque (Col7)
2853:     *--------------------------------------------------------------------------
2854:     PROCEDURE P2ColGotFocusToCol7()
2855:         TRY
2856:             IF PEMSTATUS(THIS.pgf_4c_1.Page2, "grd_4c_GradeItens2", 5)
2857:                 THIS.pgf_4c_1.Page2.grd_4c_GradeItens2.Column7.SetFocus()
2858:             ENDIF
2859:         CATCH TO loc_oErro
2860:             MsgErro("Erro em P2ColGotFocusToCol7: " + loc_oErro.Message, "Erro")
2861:         ENDTRY
2862:     ENDPROC
2863: 
2864:     *--------------------------------------------------------------------------
2865:     * P2ColC7When - Salva valor anterior da coluna Estoque antes de editar
2866:     *--------------------------------------------------------------------------
2867:     FUNCTION P2ColC7When()
2868:         LOCAL loc_lResultado
2869: 
2870:         loc_lResultado = .T.
2871: 
2872:         TRY
2873:             IF USED("TmpFinal") AND !EOF("TmpFinal")
2874:                 THIS.this_oBusinessObject.this_nOldValue = TmpFinal.Estoque
2875:             ENDIF
2876:         CATCH TO loc_oErro
2877:             MsgErro("Erro em P2ColC7When: " + loc_oErro.Message, "Erro")
2878:             loc_lResultado = .F.
2879:         ENDTRY
2880: 
2881:         RETURN loc_lResultado
2882:     ENDFUNC
2883: 
2884:     *--------------------------------------------------------------------------
2885:     * P2ColC7Valid - Valida e aplica edicao de Estoque no grid Page2
2886:     *--------------------------------------------------------------------------
2887:     FUNCTION P2ColC7Valid()
2888:         LOCAL loc_lResultado, loc_nNovo, loc_nTotSEst
2889: 
2890:         loc_lResultado = .T.
2891: 
2892:         TRY
2893:             IF USED("TmpFinal") AND !EOF("TmpFinal")
2894:                 loc_nNovo    = THIS.pgf_4c_1.Page2.grd_4c_GradeItens2.Column7.Text1.Value
2895:                 loc_nTotSEst = THIS.this_oBusinessObject.this_nTotSEst
2896: 
2897:                 IF loc_nNovo < 0
2898:                     MsgAviso("Estoque n" + CHR(227) + "o pode ser negativo.")
2899:                     THIS.pgf_4c_1.Page2.grd_4c_GradeItens2.Column7.Text1.Value = THIS.this_oBusinessObject.this_nOldValue
2900:                     loc_lResultado = .F.
2901:                 ELSE
2902:                     IF loc_nNovo > TmpFinal.Saldo
2903:                         MsgAviso("Estoque n" + CHR(227) + "o pode ser maior que o Saldo.")
2904:                         THIS.pgf_4c_1.Page2.grd_4c_GradeItens2.Column7.Text1.Value = THIS.this_oBusinessObject.this_nOldValue
2905:                         loc_lResultado = .F.
2906:                     ELSE
2907:                         LOCAL loc_nDif
2908:                         loc_nDif = loc_nNovo - THIS.this_oBusinessObject.this_nOldValue
2909:                         IF (THIS.this_oBusinessObject.this_nTotQtdP2 + loc_nDif) > loc_nTotSEst
2910:                             MsgAviso("Total de estoque selecionado excede o dispon?vel.")
2911:                             THIS.pgf_4c_1.Page2.grd_4c_GradeItens2.Column7.Text1.Value = THIS.this_oBusinessObject.this_nOldValue
2912:                             loc_lResultado = .F.
2913:                         ELSE
2914:                             REPLACE TmpFinal.Estoque WITH loc_nNovo
2915:                         ENDIF
2916:                     ENDIF
2917:                 ENDIF
2918:             ENDIF
2919:         CATCH TO loc_oErro
2920:             MsgErro("Erro em P2ColC7Valid: " + loc_oErro.Message, "Erro")
2921:             loc_lResultado = .F.
2922:         ENDTRY
2923: 
2924:         RETURN loc_lResultado
2925:     ENDFUNC
2926: 
2927:     *--------------------------------------------------------------------------
2928:     * P2ColC7LostFocus - Atualiza totais apos sair da coluna Estoque
2929:     *--------------------------------------------------------------------------
2930:     PROCEDURE P2ColC7LostFocus(par_nKeyCode, par_nShiftAltCtrl)
2931:         TRY
2932:             THIS.AtualizarTotaisPage2()
2933:         CATCH TO loc_oErro
2934:             MsgErro("Erro em P2ColC7LostFocus: " + loc_oErro.Message, "Erro")
2935:         ENDTRY
2936:     ENDPROC
2937: 
2938:     *--------------------------------------------------------------------------
2939:     * P2ColC10When - Salva valor anterior da coluna Fabrs antes de editar
2940:     *--------------------------------------------------------------------------
2941:     FUNCTION P2ColC10When()
2942:         LOCAL loc_lResultado
2943: 
2944:         loc_lResultado = .T.
2945: 
2946:         TRY
2947:             IF USED("TmpFinal") AND !EOF("TmpFinal")
2948:                 THIS.this_oBusinessObject.this_nOldValue = TmpFinal.Fabrs
2949:             ENDIF
2950:         CATCH TO loc_oErro
2951:             MsgErro("Erro em P2ColC10When: " + loc_oErro.Message, "Erro")
2952:             loc_lResultado = .F.
2953:         ENDTRY
2954: 
2955:         RETURN loc_lResultado
2956:     ENDFUNC
2957: 
2958:     *--------------------------------------------------------------------------
2959:     * P2ColC10Valid - Valida e aplica edicao de Fabrs no grid Page2
2960:     *--------------------------------------------------------------------------
2961:     FUNCTION P2ColC10Valid()
2962:         LOCAL loc_lResultado, loc_nNovo, loc_nTotSPrc
2963: 
2964:         loc_lResultado = .T.
2965: 
2966:         TRY
2967:             IF USED("TmpFinal") AND !EOF("TmpFinal")
2968:                 loc_nNovo    = THIS.pgf_4c_1.Page2.grd_4c_GradeItens2.Column10.Text1.Value
2969:                 loc_nTotSPrc = THIS.this_oBusinessObject.this_nTotSPrc
2970: 
2971:                 IF loc_nNovo < 0
2972:                     MsgAviso("Fabrica" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ser negativa.")
2973:                     THIS.pgf_4c_1.Page2.grd_4c_GradeItens2.Column10.Text1.Value = THIS.this_oBusinessObject.this_nOldValue
2974:                     loc_lResultado = .F.
2975:                 ELSE
2976:                     IF loc_nNovo > TmpFinal.Saldo
2977:                         MsgAviso("Fabrica" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ser maior que o Saldo.")
2978:                         THIS.pgf_4c_1.Page2.grd_4c_GradeItens2.Column10.Text1.Value = THIS.this_oBusinessObject.this_nOldValue
2979:                         loc_lResultado = .F.
2980:                     ELSE
2981:                         LOCAL loc_nDifF
2982:                         loc_nDifF = loc_nNovo - THIS.this_oBusinessObject.this_nOldValue
2983:                         IF (THIS.this_oBusinessObject.this_nTotPrcP2 + loc_nDifF) > loc_nTotSPrc
2984:                             MsgAviso("Total de produ" + CHR(231) + CHR(227) + "o excede o dispon?vel.")
2985:                             THIS.pgf_4c_1.Page2.grd_4c_GradeItens2.Column10.Text1.Value = THIS.this_oBusinessObject.this_nOldValue
2986:                             loc_lResultado = .F.
2987:                         ELSE
2988:                             REPLACE TmpFinal.Fabrs WITH loc_nNovo
2989:                         ENDIF
2990:                     ENDIF
2991:                 ENDIF
2992:             ENDIF
2993:         CATCH TO loc_oErro
2994:             MsgErro("Erro em P2ColC10Valid: " + loc_oErro.Message, "Erro")
2995:             loc_lResultado = .F.
2996:         ENDTRY
2997: 
2998:         RETURN loc_lResultado
2999:     ENDFUNC
3000: 
3001:     *--------------------------------------------------------------------------
3002:     * P2ColC10LostFocus - Atualiza totais apos sair da coluna Fabrs
3003:     *--------------------------------------------------------------------------
3004:     PROCEDURE P2ColC10LostFocus(par_nKeyCode, par_nShiftAltCtrl)
3005:         TRY
3006:             THIS.AtualizarTotaisPage2()
3007:         CATCH TO loc_oErro
3008:             MsgErro("Erro em P2ColC10LostFocus: " + loc_oErro.Message, "Erro")
3009:         ENDTRY
3010:     ENDPROC
3011: 
3012:     *--------------------------------------------------------------------------
3013:     * BtnVoltarPage2Click - Valida totais e retorna para Page1
3014:     *--------------------------------------------------------------------------
3015:     PROCEDURE BtnVoltarPage2Click()
3016:         LOCAL loc_nOldRecno, loc_nSumEst, loc_nSumFabrs
3017: 
3018:         TRY
3019:             IF USED("TmpFinal") AND USED("TmpFinalg") AND !EOF("TmpFinalg")
3020:                 loc_nOldRecno = IIF(RECCOUNT("TmpFinal") > 0, RECNO("TmpFinal"), 0)
3021:                 SELECT TmpFinal
3022:                 loc_nSumEst   = 0
3023:                 loc_nSumFabrs = 0
3024:                 SUM Estoque, Fabrs TO loc_nSumEst, loc_nSumFabrs
3025:                 IF loc_nOldRecno > 0 AND loc_nOldRecno <= RECCOUNT("TmpFinal")
3026:                     GO loc_nOldRecno IN TmpFinal
3027:                 ENDIF
3028: 
3029:                 IF loc_nSumEst != TmpFinalg.Estoque OR loc_nSumFabrs != TmpFinalg.Fabrs
3030:                     MsgAviso("Os totais de estoque/produ" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o conferem com o item selecionado.")
3031:                     RETURN
3032:                 ENDIF
3033:             ENDIF
3034: 
3035:             THIS.AlternarPagina(1)
3036:             THIS.AtualizarTotaisPage1()
3037: 
3038:             IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5)
3039:                 THIS.pgf_4c_1.Page1.grd_4c_GradeItens.Refresh()
3040:             ENDIF
3041:         CATCH TO loc_oErro
3042:             MsgErro("Erro em BtnVoltarPage2Click: " + loc_oErro.Message, "Erro")
3043:         ENDTRY
3044:     ENDPROC
3045: 
3046:     *--------------------------------------------------------------------------
3047:     * BtnVoltarPage3Click - Retorna para Page1 a partir de Page3
3048:     *--------------------------------------------------------------------------
3049:     PROCEDURE BtnVoltarPage3Click()
3050:         TRY
3051:             THIS.AlternarPagina(1)
3052:             IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5)
3053:                 THIS.pgf_4c_1.Page1.grd_4c_GradeItens.SetFocus()
3054:             ENDIF
3055:         CATCH TO loc_oErro
3056:             MsgErro("Erro em BtnVoltarPage3Click: " + loc_oErro.Message, "Erro")
3057:         ENDTRY
3058:     ENDPROC
3059: 
3060:     *--------------------------------------------------------------------------
3061:     * P4ColReadOnlyWhen - Bloqueia edicao em colunas somente-leitura
3062:     *--------------------------------------------------------------------------
3063:     FUNCTION P4ColReadOnlyWhen()
3064:         RETURN 0
3065:     ENDFUNC
3066: 
3067:     *--------------------------------------------------------------------------
3068:     * P4ColC5Valid - Valida quantidade Utilizar na selecao de estoque (Page4)
3069:     *--------------------------------------------------------------------------
3070:     FUNCTION P4ColC5Valid()
3071:         LOCAL loc_lResultado, loc_nUtil, loc_nSumUtil, loc_nOldRecno
3072:         LOCAL loc_nPSaldo
3073: 
3074:         loc_lResultado = .T.
3075: 
3076:         TRY
3077:             IF USED("TmpDisp") AND !EOF("TmpDisp") AND USED("TmpFinalg") AND !EOF("TmpFinalg")
3078:                 loc_nUtil  = THIS.pgf_4c_1.Page4.grd_4c_GradeDisp.Column5.Text1.Value
3079: 
3080:                 IF loc_nUtil < 0
3081:                     MsgAviso("Quantidade n" + CHR(227) + "o pode ser negativa.")
3082:                     THIS.pgf_4c_1.Page4.grd_4c_GradeDisp.Column5.Text1.Value = 0
3083:                     loc_lResultado = .F.
3084:                 ELSE
3085:                     IF loc_nUtil > TmpDisp.Disps
3086:                         MsgAviso("Quantidade excede o dispon?vel.")
3087:                         THIS.pgf_4c_1.Page4.grd_4c_GradeDisp.Column5.Text1.Value = TmpDisp.Disps
3088:                         loc_lResultado = .F.
3089:                     ELSE
3090:                         loc_nPSaldo = TmpFinalg.Saldo - TmpFinalg.Estoque - TmpFinalg.Fabrs
3091: 
3092:                         loc_nOldRecno = IIF(RECCOUNT("TmpDisp") > 0, RECNO("TmpDisp"), 0)
3093:                         SELECT TmpDisp
3094:                         loc_nSumUtil = 0
3095:                         SUM Utilizar TO loc_nSumUtil
3096:                         IF loc_nOldRecno > 0 AND loc_nOldRecno <= RECCOUNT("TmpDisp")
3097:                             GO loc_nOldRecno
3098:                         ENDIF
3099: 
3100:                         loc_nSumUtil = loc_nSumUtil - TmpDisp.Utilizar + loc_nUtil
3101: 
3102:                         IF loc_nSumUtil > loc_nPSaldo
3103:                             MsgAviso("Total selecionado excede o saldo a produzir.")
3104:                             THIS.pgf_4c_1.Page4.grd_4c_GradeDisp.Column5.Text1.Value = 0
3105:                             loc_lResultado = .F.
3106:                         ELSE
3107:                             REPLACE TmpDisp.Utilizar WITH loc_nUtil
3108:                             IF PEMSTATUS(THIS.pgf_4c_1.Page4, "txt_4c_Qt_Selec", 5)
3109:                                 THIS.pgf_4c_1.Page4.txt_4c_Qt_Selec.Value = loc_nSumUtil
3110:                             ENDIF
3111:                         ENDIF
3112:                     ENDIF
3113:                 ENDIF
3114:             ENDIF
3115:         CATCH TO loc_oErro
3116:             MsgErro("Erro em P4ColC5Valid: " + loc_oErro.Message, "Erro")
3117:             loc_lResultado = .F.
3118:         ENDTRY
3119: 
3120:         RETURN loc_lResultado
3121:     ENDFUNC
3122: 
3123:     *--------------------------------------------------------------------------
3124:     * P4ColC5LostFocus - Avanca para proxima linha apos Enter em Col5 Page4
3125:     *--------------------------------------------------------------------------
3126:     PROCEDURE P4ColC5LostFocus(par_nKeyCode, par_nShiftAltCtrl)
3127:         TRY
3128:             IF LASTKEY() = 13
3129:                 KEYBOARD CHR(24)
3130:             ENDIF
3131:             IF PEMSTATUS(THIS.pgf_4c_1.Page4.grd_4c_GradeDisp.Column5, "Text1", 5)
3132:                 THIS.pgf_4c_1.Page4.grd_4c_GradeDisp.Column5.Text1.Refresh()
3133:             ENDIF
3134:         CATCH TO loc_oErro
3135:             MsgErro("Erro em P4ColC5LostFocus: " + loc_oErro.Message, "Erro")
3136:         ENDTRY
3137:     ENDPROC
3138: 
3139:     *--------------------------------------------------------------------------
3140:     * BtnVoltarPage4Click - Processa selecao de estoque e retorna para Page1
3141:     *--------------------------------------------------------------------------
3142:     PROCEDURE BtnVoltarPage4Click()
3143:         LOCAL loc_cCpros, loc_nUtil, loc_nQtdMin
3144: 
3145:         TRY
3146:             IF USED("TmpDisp")
3147:                 loc_cCpros = ""
3148:                 IF USED("TmpFinalg") AND !EOF("TmpFinalg")
3149:                     loc_cCpros = ALLTRIM(TmpFinalg.Cpros)
3150:                 ENDIF
3151: 
3152:                 SELECT TmpDisp
3153:                 SCAN
3154:                     loc_nUtil   = TmpDisp.Utilizar
3155:                     loc_cCpros  = ALLTRIM(TmpDisp.Grupos)
3156: 
3157:                     IF USED("TmpFinalg")
3158:                         SELECT TmpFinalg
3159:                         LOCATE FOR ALLTRIM(TmpFinalg.Cpros) = m.loc_cCpros
3160:                         IF FOUND()
3161:                             REPLACE TmpFinalg.Produzir   WITH TmpFinalg.Produzir - loc_nUtil
3162:                             REPLACE TmpFinalg.Estoque    WITH TmpFinalg.Estoque  + loc_nUtil
3163: 
3164:                             loc_nQtdMin = 0
3165:                             IF TYPE("TmpFinalg.QtdMins") != "U"
3166:                                 loc_nQtdMin = TmpFinalg.QtdMins
3167:                             ENDIF
3168:                             IF loc_nQtdMin > 0
3169:                                 REPLACE TmpFinalg.Produzir2 WITH IIF(TmpFinalg.Produzir >= loc_nQtdMin, ;
3170:                                     TmpFinalg.Produzir, 0)
3171:                             ELSE
3172:                                 REPLACE TmpFinalg.Produzir2 WITH TmpFinalg.Produzir
3173:                             ENDIF
3174:                         ENDIF
3175:                     ENDIF
3176: 
3177:                     IF USED("TmpSaldo")
3178:                         SELECT TmpSaldo
3179:                         LOCATE FOR ALLTRIM(TmpSaldo.Grupos) = m.loc_cCpros
3180:                         IF FOUND()
3181:                             REPLACE TmpSaldo.Disps WITH TmpSaldo.Disps - loc_nUtil
3182:                         ENDIF

*-- Linhas 3216 a 3331:
3216:     *--------------------------------------------------------------------------
3217:     * P5ColGotFocusToCol5 - Redireciona foco para coluna Utilizar (Col5) Page5
3218:     *--------------------------------------------------------------------------
3219:     PROCEDURE P5ColGotFocusToCol5()
3220:         TRY
3221:             IF PEMSTATUS(THIS.pgf_4c_1.Page5, "grd_4c_GradeDisp", 5)
3222:                 THIS.pgf_4c_1.Page5.grd_4c_GradeDisp.Column5.SetFocus()
3223:             ENDIF
3224:         CATCH TO loc_oErro
3225:             MsgErro("Erro em P5ColGotFocusToCol5: " + loc_oErro.Message, "Erro")
3226:         ENDTRY
3227:     ENDPROC
3228: 
3229:     *--------------------------------------------------------------------------
3230:     * P5ColC5Valid - Valida quantidade Utilizar na selecao por tamanho (Page5)
3231:     *--------------------------------------------------------------------------
3232:     FUNCTION P5ColC5Valid()
3233:         LOCAL loc_lResultado, loc_nUtil, loc_nSumUtil, loc_nOldRecno
3234:         LOCAL loc_nPSaldo
3235: 
3236:         loc_lResultado = .T.
3237: 
3238:         TRY
3239:             IF USED("TmpDisp") AND !EOF("TmpDisp")
3240:                 loc_nUtil = THIS.pgf_4c_1.Page5.grd_4c_GradeDisp.Column5.Text1.Value
3241: 
3242:                 IF loc_nUtil < 0
3243:                     MsgAviso("Quantidade n" + CHR(227) + "o pode ser negativa.")
3244:                     THIS.pgf_4c_1.Page5.grd_4c_GradeDisp.Column5.Text1.Value = 0
3245:                     loc_lResultado = .F.
3246:                 ELSE
3247:                     IF loc_nUtil > TmpDisp.Disps
3248:                         MsgAviso("Quantidade excede o dispon?vel.")
3249:                         THIS.pgf_4c_1.Page5.grd_4c_GradeDisp.Column5.Text1.Value = TmpDisp.Disps
3250:                         loc_lResultado = .F.
3251:                     ELSE
3252:                         loc_nPSaldo = 0
3253:                         IF PEMSTATUS(THIS.pgf_4c_1.Page5, "txt_4c_Qt_pedida", 5)
3254:                             loc_nPSaldo = THIS.pgf_4c_1.Page5.txt_4c_Qt_pedida.Value
3255:                         ENDIF
3256: 
3257:                         loc_nOldRecno = IIF(RECCOUNT("TmpDisp") > 0, RECNO("TmpDisp"), 0)
3258:                         SELECT TmpDisp
3259:                         loc_nSumUtil = 0
3260:                         SUM Utilizar TO loc_nSumUtil
3261:                         IF loc_nOldRecno > 0 AND loc_nOldRecno <= RECCOUNT("TmpDisp")
3262:                             GO loc_nOldRecno
3263:                         ENDIF
3264: 
3265:                         loc_nSumUtil = loc_nSumUtil - TmpDisp.Utilizar + loc_nUtil
3266: 
3267:                         IF loc_nSumUtil > loc_nPSaldo
3268:                             MsgAviso("Total selecionado excede o pedido.")
3269:                             THIS.pgf_4c_1.Page5.grd_4c_GradeDisp.Column5.Text1.Value = 0
3270:                             loc_lResultado = .F.
3271:                         ELSE
3272:                             REPLACE TmpDisp.Utilizar WITH loc_nUtil
3273:                             IF PEMSTATUS(THIS.pgf_4c_1.Page5, "txt_4c_Qt_Selec", 5)
3274:                                 THIS.pgf_4c_1.Page5.txt_4c_Qt_Selec.Value = loc_nSumUtil
3275:                             ENDIF
3276:                         ENDIF
3277:                     ENDIF
3278:                 ENDIF
3279:             ENDIF
3280:         CATCH TO loc_oErro
3281:             MsgErro("Erro em P5ColC5Valid: " + loc_oErro.Message, "Erro")
3282:             loc_lResultado = .F.
3283:         ENDTRY
3284: 
3285:         RETURN loc_lResultado
3286:     ENDFUNC
3287: 
3288:     *--------------------------------------------------------------------------
3289:     * BtnVoltarPage5Click - Processa selecao por tamanho e retorna para Page1
3290:     *--------------------------------------------------------------------------
3291:     PROCEDURE BtnVoltarPage5Click()
3292:         LOCAL loc_cGrupo, loc_nUtil
3293: 
3294:         TRY
3295:             IF USED("TmpDisp")
3296:                 SELECT TmpDisp
3297:                 SCAN
3298:                     loc_nUtil  = TmpDisp.Utilizar
3299:                     loc_cGrupo = ALLTRIM(TmpDisp.Cpros)
3300: 
3301:                     IF USED("TmpFinalg")
3302:                         SELECT TmpFinalg
3303:                         LOCATE FOR ALLTRIM(TmpFinalg.Cpros) = m.loc_cGrupo
3304:                         IF FOUND()
3305:                             REPLACE TmpFinalg.Produzir WITH TmpFinalg.Produzir - loc_nUtil
3306:                             REPLACE TmpFinalg.Estoque  WITH TmpFinalg.Estoque  + loc_nUtil
3307:                         ENDIF
3308:                     ENDIF
3309: 
3310:                     IF USED("TmpSaldo")
3311:                         SELECT TmpSaldo
3312:                         LOCATE FOR ALLTRIM(TmpSaldo.Grupos) = m.loc_cGrupo
3313:                         IF FOUND()
3314:                             REPLACE TmpSaldo.Disps WITH TmpSaldo.Disps - loc_nUtil
3315:                         ENDIF
3316:                     ENDIF
3317:                 ENDSCAN
3318: 
3319:                 USE IN TmpDisp
3320:             ENDIF
3321: 
3322:             THIS.AlternarPagina(1)
3323:             THIS.AtualizarTotaisPage1()
3324: 
3325:             IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5)
3326:                 THIS.pgf_4c_1.Page1.grd_4c_GradeItens.Refresh()
3327:             ENDIF
3328:         CATCH TO loc_oErro
3329:             MsgErro("Erro em BtnVoltarPage5Click: " + loc_oErro.Message, "Erro")
3330:         ENDTRY
3331:     ENDPROC

*-- Linhas 3459 a 3542:
3459:     *--------------------------------------------------------------------------
3460:     * P6ColC5LostFocus - Avanca para proxima linha apos Enter em Col5 Page6
3461:     *--------------------------------------------------------------------------
3462:     PROCEDURE P6ColC5LostFocus(par_nKeyCode, par_nShiftAltCtrl)
3463:         TRY
3464:             IF LASTKEY() = 13
3465:                 KEYBOARD CHR(24)
3466:             ENDIF
3467:             IF PEMSTATUS(THIS.pgf_4c_1.Page6.grd_4c_GradePedra.Column5, "Text1", 5)
3468:                 THIS.pgf_4c_1.Page6.grd_4c_GradePedra.Column5.Text1.Refresh()
3469:             ENDIF
3470:         CATCH TO loc_oErro
3471:             MsgErro("Erro em P6ColC5LostFocus: " + loc_oErro.Message, "Erro")
3472:         ENDTRY
3473:     ENDPROC
3474: 
3475:     *--------------------------------------------------------------------------
3476:     * P6ColC1KeyPress - F4 abre picker de produto (Col1 Cpros Page6)
3477:     *--------------------------------------------------------------------------
3478:     FUNCTION P6ColC1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
3479:         LOCAL loc_cFiltro
3480: 
3481:         IF par_nKeyCode = 115  && F4
3482:             loc_cFiltro = ""
3483:             IF PEMSTATUS(THIS.pgf_4c_1.Page6.grd_4c_GradePedra.Column1.Text1, "Value", 5)
3484:                 loc_cFiltro = ALLTRIM(THIS.pgf_4c_1.Page6.grd_4c_GradePedra.Column1.Text1.Value)
3485:             ENDIF
3486:             THIS.AbrirLookupProdutoP6Col1(loc_cFiltro)
3487:             RETURN 0
3488:         ENDIF
3489: 
3490:         RETURN par_nKeyCode
3491:     ENDFUNC
3492: 
3493:     *--------------------------------------------------------------------------
3494:     * AbrirLookupProdutoP6Col1 - Picker FormBuscaAuxiliar para Cpros (Page6)
3495:     *--------------------------------------------------------------------------
3496:     PROCEDURE AbrirLookupProdutoP6Col1(par_cFiltro)
3497:         LOCAL loc_cFiltro, loc_cCpros, loc_nRes, loc_cSQL
3498: 
3499:         loc_cFiltro = IIF(TYPE("par_cFiltro") = "C", ALLTRIM(par_cFiltro), "")
3500: 
3501:         TRY
3502:             DO FormBuscaAuxiliar WITH gnConnHandle, "SigCdPro", "crLkpPro6C1", "CPros", ;
3503:                 loc_cFiltro, "Produto", 900, "CPros", "DPros"
3504: 
3505:             IF USED("crLkpPro6C1") AND RECCOUNT("crLkpPro6C1") > 0
3506:                 loc_cCpros = ALLTRIM(crLkpPro6C1.CPros)
3507:                 USE IN crLkpPro6C1
3508: 
3509:                 IF USED("SelPedra") AND !EOF("SelPedra") AND !EMPTY(loc_cCpros)
3510:                     loc_cSQL = "SELECT TOP 1 DPros, Cunis FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCpros)
3511:                     loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "crLkpPro6C1Det")
3512: 
3513:                     IF loc_nRes > 0 AND USED("crLkpPro6C1Det") AND !EOF("crLkpPro6C1Det")
3514:                         REPLACE SelPedra.Cpros WITH loc_cCpros
3515:                         REPLACE SelPedra.Dpros WITH ALLTRIM(crLkpPro6C1Det.DPros)
3516:                         REPLACE SelPedra.Cunis WITH ALLTRIM(crLkpPro6C1Det.Cunis)
3517:                         USE IN crLkpPro6C1Det
3518:                     ELSE
3519:                         IF USED("crLkpPro6C1Det")
3520:                             USE IN crLkpPro6C1Det
3521:                         ENDIF
3522:                     ENDIF
3523: 
3524:                     IF PEMSTATUS(THIS.pgf_4c_1.Page6, "grd_4c_GradePedra", 5)
3525:                         THIS.pgf_4c_1.Page6.grd_4c_GradePedra.Refresh()
3526:                     ENDIF
3527:                 ENDIF
3528:             ELSE
3529:                 IF USED("crLkpPro6C1")
3530:                     USE IN crLkpPro6C1
3531:                 ENDIF
3532:             ENDIF
3533:         CATCH TO loc_oErro
3534:             MsgErro("Erro ao abrir lookup de produto: " + loc_oErro.Message, "Erro")
3535:         ENDTRY
3536:     ENDPROC
3537: 
3538:     *--------------------------------------------------------------------------
3539:     * P6ColC5KeyPress - F4 abre picker de produto substituto (Col5 Cpro2s Page6)
3540:     *--------------------------------------------------------------------------
3541:     FUNCTION P6ColC5KeyPress(par_nKeyCode, par_nShiftAltCtrl)
3542:         LOCAL loc_cFiltro

*-- Linhas 3554 a 3812:
3554:     ENDFUNC
3555: 
3556:     *--------------------------------------------------------------------------
3557:     * AbrirLookupProdutoP6Col5 - Picker FormBuscaAuxiliar para Cpro2s (Page6)
3558:     *--------------------------------------------------------------------------
3559:     PROCEDURE AbrirLookupProdutoP6Col5(par_cFiltro)
3560:         LOCAL loc_cFiltro, loc_cCpro2
3561: 
3562:         loc_cFiltro = IIF(TYPE("par_cFiltro") = "C", ALLTRIM(par_cFiltro), "")
3563: 
3564:         TRY
3565:             DO FormBuscaAuxiliar WITH gnConnHandle, "SigCdPro", "crLkpPro6C5", "CPros", ;
3566:                 loc_cFiltro, "Produto Substituto", 900, "CPros", "DPros"
3567: 
3568:             IF USED("crLkpPro6C5") AND RECCOUNT("crLkpPro6C5") > 0
3569:                 loc_cCpro2 = ALLTRIM(crLkpPro6C5.CPros)
3570:                 USE IN crLkpPro6C5
3571: 
3572:                 IF USED("SelPedra") AND !EOF("SelPedra") AND !EMPTY(loc_cCpro2)
3573:                     REPLACE SelPedra.Cpro2s WITH loc_cCpro2
3574: 
3575:                     IF PEMSTATUS(THIS.pgf_4c_1.Page6, "grd_4c_GradePedra", 5)
3576:                         THIS.pgf_4c_1.Page6.grd_4c_GradePedra.Refresh()
3577:                     ENDIF
3578:                 ENDIF
3579:             ELSE
3580:                 IF USED("crLkpPro6C5")
3581:                     USE IN crLkpPro6C5
3582:                 ENDIF
3583:             ENDIF
3584:         CATCH TO loc_oErro
3585:             MsgErro("Erro ao abrir lookup de produto substituto: " + loc_oErro.Message, "Erro")
3586:         ENDTRY
3587:     ENDPROC
3588: 
3589:     *--------------------------------------------------------------------------
3590:     * BtnVoltarPage6Click - Retorna de Page6 (requisicao manual) para Page1
3591:     *--------------------------------------------------------------------------
3592:     PROCEDURE BtnVoltarPage6Click()
3593:         TRY
3594:             THIS.AlternarPagina(1)
3595:             IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5)
3596:                 THIS.pgf_4c_1.Page1.grd_4c_GradeItens.SetFocus()
3597:             ENDIF
3598:         CATCH TO loc_oErro
3599:             MsgErro("Erro em BtnVoltarPage6Click: " + loc_oErro.Message, "Erro")
3600:         ENDTRY
3601:     ENDPROC
3602: 
3603:     *--------------------------------------------------------------------------
3604:     * MostrarAguarde - Exibe overlay de processamento com mensagem
3605:     *--------------------------------------------------------------------------
3606:     PROCEDURE MostrarAguarde(par_cMensagem)
3607: 
3608:         IF PEMSTATUS(THIS, "cnt_4c_Aguarde", 5)
3609:             IF TYPE("par_cMensagem") = "C" AND !EMPTY(par_cMensagem)
3610:                 THIS.cnt_4c_Aguarde.lbl_4c_AguardeDet.Caption = par_cMensagem
3611:             ENDIF
3612:             THIS.cnt_4c_Aguarde.Visible = .T.
3613:             THIS.cnt_4c_Aguarde.ZOrder(0)
3614:         ENDIF
3615:         THIS.this_lProcessando = .T.
3616:         DOEVENTS
3617:     ENDPROC
3618: 
3619:     *--------------------------------------------------------------------------
3620:     * OcultarAguarde - Oculta overlay de processamento
3621:     *--------------------------------------------------------------------------
3622:     PROCEDURE OcultarAguarde()
3623: 
3624:         IF PEMSTATUS(THIS, "cnt_4c_Aguarde", 5)
3625:             THIS.cnt_4c_Aguarde.lbl_4c_AguardeDet.Caption = ""
3626:             THIS.cnt_4c_Aguarde.Visible = .F.
3627:         ENDIF
3628:         THIS.this_lProcessando = .F.
3629:         DOEVENTS
3630:     ENDPROC
3631: 
3632:     *--------------------------------------------------------------------------
3633:     * BtnIncluirClick - Form OPERACIONAL: incluir requisicao manual de material
3634:     * (equivalente ao botao Pedras do legado, que abre Page6 para adicionar
3635:     *  itens da requisicao vinculados ao produto corrente da grade)
3636:     *--------------------------------------------------------------------------
3637:     PROCEDURE BtnIncluirClick()
3638: 
3639:         TRY
3640:             IF !USED("TmpFinalg") OR EOF("TmpFinalg")
3641:                 MsgAviso("Selecione uma refer" + CHR(234) + "ncia na grade antes de incluir requisi" + ;
3642:                     CHR(231) + CHR(245) + "es de material.")
3643:                 IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5)
3644:                     THIS.pgf_4c_1.Page1.grd_4c_GradeItens.SetFocus
3645:                 ENDIF
3646:             ELSE
3647:                 THIS.BtnPedrasClick()
3648:             ENDIF
3649:         CATCH TO loc_oErro
3650:             MsgErro("Erro ao incluir requisi" + CHR(231) + CHR(227) + "o: " + ;
3651:                 loc_oErro.Message, "Erro")
3652:         ENDTRY
3653:     ENDPROC
3654: 
3655:     *--------------------------------------------------------------------------
3656:     * BtnAlterarClick - Form OPERACIONAL: alterar quantidade a produzir para
3657:     * estoque do item selecionado (exige autorizacao por senha, replica o
3658:     * comportamento do botao Alteraqtd do legado)
3659:     *--------------------------------------------------------------------------
3660:     PROCEDURE BtnAlterarClick()
3661: 
3662:         TRY
3663:             IF !USED("TmpFinalg") OR EOF("TmpFinalg")
3664:                 MsgAviso("Selecione uma refer" + CHR(234) + "ncia na grade antes de alterar quantidade.")
3665:                 IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5)
3666:                     THIS.pgf_4c_1.Page1.grd_4c_GradeItens.SetFocus
3667:                 ENDIF
3668:             ELSE
3669:                 THIS.BtnAlteraqtdClick()
3670:             ENDIF
3671:         CATCH TO loc_oErro
3672:             MsgErro("Erro ao alterar quantidade: " + loc_oErro.Message, "Erro")
3673:         ENDTRY
3674:     ENDPROC
3675: 
3676:     *--------------------------------------------------------------------------
3677:     * BtnVisualizarClick - Form OPERACIONAL: exibir foto do produto corrente
3678:     * (equivalente ao clique na Image ImgFigJpg do legado)
3679:     *--------------------------------------------------------------------------
3680:     PROCEDURE BtnVisualizarClick()
3681: 
3682:         TRY
3683:             IF !USED("TmpFinalg") OR EOF("TmpFinalg")
3684:                 MsgAviso("Selecione uma refer" + CHR(234) + "ncia na grade antes de visualizar a foto.")
3685:                 IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5)
3686:                     THIS.pgf_4c_1.Page1.grd_4c_GradeItens.SetFocus
3687:                 ENDIF
3688:             ELSE
3689:                 THIS.CarregarFotoProduto(ALLTRIM(TmpFinalg.Cpros))
3690:             ENDIF
3691:         CATCH TO loc_oErro
3692:             MsgErro("Erro ao visualizar foto: " + loc_oErro.Message, "Erro")
3693:         ENDTRY
3694:     ENDPROC
3695: 
3696:     *--------------------------------------------------------------------------
3697:     * BtnExcluirClick - Form OPERACIONAL: zerar a selecao de producao/estoque
3698:     * do item corrente da grade (reverte producao para o saldo total, limpa
3699:     * marcacoes de estoque/producao selecionadas). Espelha o rollback feito
3700:     * pelo botao Cancelar da Page2 do legado quando aplicado ao registro atual.
3701:     *--------------------------------------------------------------------------
3702:     PROCEDURE BtnExcluirClick()
3703: 
3704:         LOCAL loc_nSaldoTotal, loc_cCpro, loc_cCor, loc_cTam
3705: 
3706:         TRY
3707:             IF !USED("TmpFinalg") OR EOF("TmpFinalg")
3708:                 MsgAviso("Selecione uma refer" + CHR(234) + "ncia na grade antes de zerar a sele" + ;
3709:                     CHR(231) + CHR(227) + "o.")
3710:                 IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5)
3711:                     THIS.pgf_4c_1.Page1.grd_4c_GradeItens.SetFocus
3712:                 ENDIF
3713:             ELSE
3714:                 IF !MsgConfirma("Zerar sele" + CHR(231) + CHR(227) + "o de estoque/produ" + ;
3715:                     CHR(231) + CHR(227) + "o da refer" + CHR(234) + "ncia corrente?")
3716:                     RETURN
3717:                 ENDIF
3718: 
3719:                 loc_cCpro     = ALLTRIM(TmpFinalg.Cpros)
3720:                 loc_cCor      = ALLTRIM(TmpFinalg.CodCors)
3721:                 loc_cTam      = ALLTRIM(TmpFinalg.CodTams)
3722:                 loc_nSaldoTotal = TmpFinalg.Saldo
3723: 
3724:                 SELECT TmpFinalg
3725:                 REPLACE Estoque WITH 0, Fabrs WITH 0, Produzir WITH loc_nSaldoTotal, ;
3726:                     Produzir2 WITH 0, UsuLibs WITH " " IN TmpFinalg
3727: 
3728:                 IF USED("TmpSaldo")
3729:                     IF SEEK(loc_cCpro + loc_cCor + loc_cTam, "TmpSaldo")
3730:                         REPLACE TmpSaldo.Disps WITH TmpSaldo.Saldo IN TmpSaldo
3731:                     ENDIF
3732:                 ENDIF
3733: 
3734:                 THIS.AtualizarTotaisPage1()
3735:                 IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5)
3736:                     THIS.pgf_4c_1.Page1.grd_4c_GradeItens.Refresh
3737:                 ENDIF
3738:             ENDIF
3739:         CATCH TO loc_oErro
3740:             MsgErro("Erro ao zerar sele" + CHR(231) + CHR(227) + "o: " + ;
3741:                 loc_oErro.Message, "Erro")
3742:         ENDTRY
3743:     ENDPROC
3744: 
3745:     *--------------------------------------------------------------------------
3746:     * CarregarLista - Vincula GradeItens da Page1 ao cursor TmpFinalg
3747:     *--------------------------------------------------------------------------
3748:     PROCEDURE CarregarLista()
3749:         TRY
3750:             IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5) AND USED("TmpFinalg")
3751:                 WITH THIS.pgf_4c_1.Page1.grd_4c_GradeItens
3752:                     .ColumnCount  = 10
3753:                     .RecordSource = "TmpFinalg"
3754:                 ENDWITH
3755:             ENDIF
3756:             THIS.AtualizarTotaisPage1()
3757:         CATCH TO loc_oErro
3758:             MsgErro("Erro ao carregar lista: " + loc_oErro.Message, "Erro")
3759:         ENDTRY
3760:     ENDPROC
3761: 
3762:     *--------------------------------------------------------------------------
3763:     * AjustarBotoesPorModo - Delega para AjustarVisibilidadeBotoes
3764:     *--------------------------------------------------------------------------
3765:     PROCEDURE AjustarBotoesPorModo()
3766:         THIS.AjustarVisibilidadeBotoes()
3767:     ENDPROC
3768: 
3769:     *--------------------------------------------------------------------------
3770:     * FormParaBO - Sincroniza totais dos cursores de producao para o BO
3771:     *--------------------------------------------------------------------------
3772:     PROCEDURE FormParaBO()
3773:         LOCAL loc_nSal, loc_nEst, loc_nPrz, loc_nPrc, loc_nPrze
3774:         LOCAL loc_nSal2, loc_nEst2, loc_nPrz2, loc_nPrc2
3775:         LOCAL loc_nRecno
3776: 
3777:         TRY
3778:             IF USED("TmpFinalg") AND RECCOUNT("TmpFinalg") > 0
3779:                 loc_nRecno = IIF(!BOF("TmpFinalg") AND !EOF("TmpFinalg"), RECNO("TmpFinalg"), 0)
3780: 
3781:                 loc_nSal   = 0
3782:                 loc_nEst   = 0
3783:                 loc_nPrz   = 0
3784:                 loc_nPrc   = 0
3785:                 loc_nPrze  = 0
3786: 
3787:                 SELECT TmpFinalg
3788:                 SUM Saldo, Estoque, Produzir, Fabrs, Produzir2 ;
3789:                     TO loc_nSal, loc_nEst, loc_nPrz, loc_nPrc, loc_nPrze
3790: 
3791:                 IF loc_nRecno > 0 AND RECCOUNT("TmpFinalg") >= loc_nRecno
3792:                     GO loc_nRecno IN TmpFinalg
3793:                 ENDIF
3794: 
3795:                 THIS.this_oBusinessObject.this_nTotQtd  = loc_nSal
3796:                 THIS.this_oBusinessObject.this_nTotEst  = loc_nEst
3797:                 THIS.this_oBusinessObject.this_nTotPrz  = loc_nPrz
3798:                 THIS.this_oBusinessObject.this_nTotPrdc = loc_nPrc
3799:                 THIS.this_oBusinessObject.this_nTotPrze = loc_nPrze
3800:             ENDIF
3801: 
3802:             IF USED("TmpFinal") AND RECCOUNT("TmpFinal") > 0
3803:                 loc_nRecno = IIF(!BOF("TmpFinal") AND !EOF("TmpFinal"), RECNO("TmpFinal"), 0)
3804: 
3805:                 loc_nSal2  = 0
3806:                 loc_nEst2  = 0
3807:                 loc_nPrz2  = 0
3808:                 loc_nPrc2  = 0
3809: 
3810:                 SELECT TmpFinal
3811:                 SUM Saldo, Estoque, Produzir, Fabrs ;
3812:                     TO loc_nSal2, loc_nEst2, loc_nPrz2, loc_nPrc2

*-- Linhas 3828 a 3953:
3828:     *--------------------------------------------------------------------------
3829:     * BOParaForm - Atualiza totais da UI a partir do estado do BO/cursores
3830:     *--------------------------------------------------------------------------
3831:     PROCEDURE BOParaForm()
3832:         TRY
3833:             THIS.AtualizarTotaisPage1()
3834:             THIS.AtualizarTotaisPage2()
3835:         CATCH TO loc_oErro
3836:             MsgErro("Erro em BOParaForm: " + loc_oErro.Message, "Erro")
3837:         ENDTRY
3838:     ENDPROC
3839: 
3840:     *--------------------------------------------------------------------------
3841:     * HabilitarCampos - Habilita/desabilita colunas editaveis conforme estado
3842:     *--------------------------------------------------------------------------
3843:     PROCEDURE HabilitarCampos()
3844:         LOCAL loc_lBloquear
3845: 
3846:         TRY
3847:             loc_lBloquear = THIS.this_lProcessando
3848: 
3849:             IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5)
3850:                 WITH THIS.pgf_4c_1.Page1.grd_4c_GradeItens
3851:                     IF PEMSTATUS(.Column7, "ReadOnly", 5)
3852:                         .Column7.ReadOnly = loc_lBloquear
3853:                     ENDIF
3854:                     IF PEMSTATUS(.Column8, "ReadOnly", 5)
3855:                         .Column8.ReadOnly = loc_lBloquear
3856:                     ENDIF
3857:                     IF PEMSTATUS(.Column10, "ReadOnly", 5)
3858:                         .Column10.ReadOnly = loc_lBloquear
3859:                     ENDIF
3860:                 ENDWITH
3861:             ENDIF
3862: 
3863:             IF PEMSTATUS(THIS.pgf_4c_1.Page1, "cmd_4c_Processar", 5)
3864:                 THIS.pgf_4c_1.Page1.cmd_4c_Processar.Enabled = !loc_lBloquear
3865:             ENDIF
3866:         CATCH TO loc_oErro
3867:             MsgErro("Erro em HabilitarCampos: " + loc_oErro.Message, "Erro")
3868:         ENDTRY
3869:     ENDPROC
3870: 
3871:     *--------------------------------------------------------------------------
3872:     * LimparCampos - Zera os campos de totalizacao das paginas 1 e 2
3873:     *--------------------------------------------------------------------------
3874:     PROCEDURE LimparCampos()
3875:         TRY
3876:             IF PEMSTATUS(THIS.pgf_4c_1.Page1, "txt_4c_Tot_Qtd", 5)
3877:                 WITH THIS.pgf_4c_1.Page1
3878:                     .txt_4c_Tot_Qtd.Value  = 0
3879:                     .txt_4c_Tot_Est.Value  = 0
3880:                     .txt_4c_Tot_Prz.Value  = 0
3881:                     .txt_4c_Tot_prdc.Value = 0
3882:                     .txt_4c_Tot_prze.Value = 0
3883:                 ENDWITH
3884:             ENDIF
3885: 
3886:             IF PEMSTATUS(THIS.pgf_4c_1.Page2, "txt_4c_TotQtdP2", 5)
3887:                 WITH THIS.pgf_4c_1.Page2
3888:                     .txt_4c_TotQtdP2.Value = 0
3889:                     .txt_4c_TotEstP2.Value = 0
3890:                     .txt_4c_TotPrzP2.Value = 0
3891:                     .txt_4c_TotPrcP2.Value = 0
3892:                 ENDWITH
3893:             ENDIF
3894:         CATCH TO loc_oErro
3895:             MsgErro("Erro em LimparCampos: " + loc_oErro.Message, "Erro")
3896:         ENDTRY
3897:     ENDPROC
3898: 
3899:     *--------------------------------------------------------------------------
3900:     * BtnBuscarClick - Atualiza a exibicao da previa (recarrega grade e totais)
3901:     *--------------------------------------------------------------------------
3902:     PROCEDURE BtnBuscarClick()
3903:         TRY
3904:             THIS.CarregarLista()
3905:             IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5)
3906:                 THIS.pgf_4c_1.Page1.grd_4c_GradeItens.Refresh()
3907:             ENDIF
3908:         CATCH TO loc_oErro
3909:             MsgErro("Erro ao atualizar visualiza" + CHR(231) + CHR(227) + "o: " + ;
3910:                 loc_oErro.Message, "Erro")
3911:         ENDTRY
3912:     ENDPROC
3913: 
3914:     *--------------------------------------------------------------------------
3915:     * BtnSalvarClick - Confirma e processa a globalizacao (alias de Processar)
3916:     *--------------------------------------------------------------------------
3917:     PROCEDURE BtnSalvarClick()
3918:         THIS.BtnProcessarClick()
3919:     ENDPROC
3920: 
3921:     *--------------------------------------------------------------------------
3922:     * BtnCancelarClick - Encerra sem processar (alias de Encerrar)
3923:     *--------------------------------------------------------------------------
3924:     PROCEDURE BtnCancelarClick()
3925:         THIS.BtnEncerrarClick()
3926:     ENDPROC
3927: 
3928:     *--------------------------------------------------------------------------
3929:     * Destroy - Libera recursos ao fechar
3930:     *--------------------------------------------------------------------------
3931:     PROCEDURE Destroy()
3932: 
3933:         TRY
3934:             *-- Fecha cursor auxiliar criado em InicializarForm
3935:             IF USED("TmpSaldU")
3936:                 USE IN TmpSaldU
3937:             ENDIF
3938: 
3939:             *-- Reabilita form pai (foi desabilitado ao abrir este form filho)
3940:             IF !ISNULL(THIS.this_oParentForm) AND ISOBJECT(THIS.this_oParentForm)
3941:                 THIS.this_oParentForm.Enabled = .T.
3942:             ENDIF
3943: 
3944:             *-- Libera referencias
3945:             THIS.this_oParentForm = .NULL.
3946:         CATCH TO loc_oErro
3947:             MsgErro("Erro ao encerrar FormSigPrGlx: " + loc_oErro.Message, "Erro")
3948:         ENDTRY
3949: 
3950:         DODEFAULT()
3951:     ENDPROC
3952: 
3953: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrGlxBO.prg):
*=============================================================================*
* SigPrGlxBO.prg - Business Object para Previa da Globalizacao
*=============================================================================*
* Herda de: BusinessBase
* Form associado: FormSigPrGlx.prg (forms\operacionais\)
* Descricao: Gerencia a previa da globalizacao de producao.
*            Opera sobre cursores temporarios passados pelo form pai
*            (TmpFinalg, TmpFinal, TmpSaldG, TmpFabr, TmpSaldU)
*            alem de cursores SQL criados em tempo de execucao.
*            Nao possui tabela SQL Server propria (opera em varias tabelas).
*=============================================================================*

DEFINE CLASS SigPrGlxBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Parametros recebidos do form pai via Init/ConfigurarParametros
    *--------------------------------------------------------------------------

    *-- Indica modo reserva automatica (nao produz OP, apenas reserva estoque)
    this_lReserva           = .F.

    *-- Indica modo de processamento automatico (sem confirmacao manual)
    this_lAutomatico        = .F.

    *-- Indica se o destino das OPs segue o destino do movimento origem
    this_lPorDestino        = .F.

    *-- Numero de emphasis (empresa) padrao para geracao de OP
    this_nEmphPdr           = 0

    *-- Numero da OP pre-definida (quando GlobAutos = 2 no parametro)
    this_nNumerodaop        = 0

    *-- Data de referencia para processamento (data da globalizacao)
    this_dData              = {}

    *-- Chave de assinatura unica para rastreio de registros gerados
    this_cSigKey            = ""

    *--------------------------------------------------------------------------
    * Controle de edicao inline nos grids de itens (Page1 e Page2)
    *--------------------------------------------------------------------------

    *-- Valor anterior antes de edicao em Column7/Column10 do GradeItens
    this_nOldValue          = 0

    *-- Valor anterior antes de edicao em Column5 do GradePedra (Page6)
    this_nAntValue          = 0

    *-- Flag de liberacao para edicao de coluna normalmente bloqueada (Column8)
    this_lLiberado          = .F.

    *--------------------------------------------------------------------------
    * Controle de exibicao e estado de botoes da UI
    *--------------------------------------------------------------------------

    *-- Controla visibilidade do botao Pedras (requisicao manual de material)
    this_lPedrasVisiveis    = .F.

    *-- Controla visibilidade do botao Disponivel
    this_lDisponivelVisivel = .F.

    *-- Controla visibilidade do botao SelEstoque (selecionar estoque por grupo)
    this_lSelEstoqueVisivel = .F.

    *--------------------------------------------------------------------------
    * Acumuladores de totais da pagina principal (Page1 - GradeItens)
    *--------------------------------------------------------------------------

    *-- Total de quantidade / saldo (coluna Saldo do TmpFinalg)
    this_nTotQtd            = 0

    *-- Total de estoque (coluna Estoque do TmpFinalg)
    this_nTotEst            = 0

    *-- Total a produzir / prazo (coluna Produzir do TmpFinalg)
    this_nTotPrz            = 0

    *-- Total de producao / fabrico (coluna Fabrs do TmpFinalg)
    this_nTotPrdc           = 0

    *-- Total de producao para estoque (coluna Produzir2 do TmpFinalg)
    this_nTotPrze           = 0

    *--------------------------------------------------------------------------
    * Acumuladores de totais da pagina de operacoes detalhadas (Page2)
    *--------------------------------------------------------------------------

    *-- Total de quantidade (Page2 - TmpFinal)
    this_nTotQtdP2          = 0

    *-- Total de estoque (Page2 - TmpFinal)
    this_nTotEstP2          = 0

    *-- Total a produzir (Page2 - TmpFinal)
    this_nTotPrzP2          = 0

    *-- Total de producao (Page2 - TmpFinal.Fabrs)
    this_nTotPrcP2          = 0

    *-- Quantidade selecionada de estoque para a referencia corrente (Tot_sEst)
    this_nTotSEst           = 0

    *-- Quantidade selecionada de producao para a referencia corrente (Tot_sPrc)
    this_nTotSPrc           = 0

    *--------------------------------------------------------------------------
    * Permissoes de acesso
    *--------------------------------------------------------------------------

    *-- Indica se usuario tem permissao para alterar prioridade (SIGPRGLO/PRIORIDADE)
    this_lPermitePrioridade = .F.

    *--------------------------------------------------------------------------
    * INIT - Inicializa BO sem tabela SQL propria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Le totais acumulados do cursor de itens
    *--------------------------------------------------------------------------
    * Para forms OPERACIONAIS este BO nao mapeia registro-a-registro:
    * recebe o alias do cursor de itens (TmpFinalg para Page1, TmpFinal para
    * Page2) e calcula os totais para exibir nos textboxes Tot_Qtd/Est/Prz/etc.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_cAlias, loc_nRecno, loc_nSaldo, loc_nEstoque
        LOCAL loc_nProduzir, loc_nFabrs, loc_nProduzir2
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            loc_cAlias = IIF(EMPTY(par_cAliasCursor), "TmpFinalg", par_cAliasCursor)

            IF !USED(loc_cAlias)
                loc_lSucesso = .F.
            ELSE
                SELECT (loc_cAlias)
                loc_nRecno = IIF(RECCOUNT() > 0, RECNO(), 0)

                loc_nSaldo     = 0
                loc_nEstoque   = 0
                loc_nProduzir  = 0
                loc_nFabrs     = 0
                loc_nProduzir2 = 0

                IF RECCOUNT() > 0
                    SUM Saldo, Estoque, Produzir, Fabrs ;
                        TO loc_nSaldo, loc_nEstoque, loc_nProduzir, loc_nFabrs

                    IF TYPE(loc_cAlias + ".Produzir2") != "U"
                        SUM Produzir2 TO loc_nProduzir2
                    ENDIF

                    IF loc_nRecno > 0 AND loc_nRecno <= RECCOUNT()
                        GO loc_nRecno
                    ENDIF
                ENDIF

                IF UPPER(loc_cAlias) = "TMPFINAL"
                    THIS.this_nTotQtdP2  = loc_nSaldo
                    THIS.this_nTotEstP2  = loc_nEstoque
                    THIS.this_nTotPrzP2  = loc_nProduzir
                    THIS.this_nTotPrcP2  = loc_nFabrs
                ELSE
                    THIS.this_nTotQtd  = loc_nSaldo
                    THIS.this_nTotEst  = loc_nEstoque
                    THIS.this_nTotPrz  = loc_nProduzir
                    THIS.this_nTotPrdc = loc_nFabrs
                    THIS.this_nTotPrze = loc_nProduzir2
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar totais do cursor: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave de rastreio da execucao (SigKey unica)
    *--------------------------------------------------------------------------
    * Cada execucao da previa gera uma SigKey por fGerUniqueKey no legado.
    * Enquanto o form nao a define, retorna string vazia. Usada para vincular
    * registros gerados (SigOpPic/SigCdNei/SigMvCab) na fase Processar.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cSigKey)
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Registra execucao da globalizacao em LogAuditoria
    *--------------------------------------------------------------------------
    * OPERACIONAL: nao existe INSERT em tabela unica. O metodo delega para
    * RegistrarAuditoria com operacao "GLOBALIZACAO" (ou "RESERVA_AUTO"),
    * marcando que a previa foi confirmada. As gravacoes reais dos registros
    * (SigMvCab/SigOpPic/SigCdNei) ocorrem na fase Processar do form.
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_cOperacao

        loc_lSucesso = .F.

        TRY
            loc_cOperacao = IIF(THIS.this_lReserva, ;
                "RESERVA_AUTO_GLOBALIZACAO", ;
                "PREVIA_GLOBALIZACAO")

            THIS.RegistrarAuditoria(loc_cOperacao)
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao registrar globalizacao: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Registra reprocessamento em LogAuditoria
    *--------------------------------------------------------------------------
    * Chamado quando o usuario reexecuta o Processar apos ajustar quantidades
    * (edicoes em GradeItens Column7/Column10). Registra evento no log.
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            THIS.RegistrarAuditoria("REPROCESSAMENTO_GLOBALIZACAO")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao registrar reprocessamento: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Insere entrada na tabela LogAuditoria
    *--------------------------------------------------------------------------
    * Grava operacao no log para rastreabilidade. Usa GETDATE() literal
    * (nao GETDATE()) para DataHora conforme feedback #35.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario, loc_cModulo
        LOCAL loc_nResultado, loc_oErro

        TRY
            loc_cChave   = THIS.ObterChavePrimaria()
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                gc_4c_UsuarioLogado, "SISTEMA")
            loc_cModulo  = "SigPrGlx"

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                "(Modulo, Operacao, ChavePrimaria, Usuario, DataHora, Detalhes) " + ;
                "VALUES (" + ;
                EscaparSQL(loc_cModulo) + ", " + ;
                EscaparSQL(par_cOperacao) + ", " + ;
                EscaparSQL(loc_cChave) + ", " + ;
                EscaparSQL(loc_cUsuario) + ", " + ;
                "GETDATE(), " + ;
                EscaparSQL("SigKey=" + loc_cChave + ;
                    "; Reserva=" + IIF(THIS.this_lReserva, "S", "N") + ;
                    "; Automatico=" + IIF(THIS.this_lAutomatico, "S", "N") + ;
                    "; PorDestino=" + IIF(THIS.this_lPorDestino, "S", "N") + ;
                    "; NumeroOP=" + TRANSFORM(THIS.this_nNumerodaop)) + ;
                ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Falha ao gravar LogAuditoria para operacao " + ;
                    par_cOperacao, "Auditoria")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RegistrarAuditoria: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE

