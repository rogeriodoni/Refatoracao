# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (52)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA, CNT_4C_CONTAINER5, CNT_4C_CONTAINER3, CNT_4C_CONTAINER1, CNT_4C_AGUARDE. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [GRID-WITH] Bloco WITH loc_nNewVal define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_nNewVal.RecordSource).
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGlx.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (3954 linhas total):

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
346:             loc_oPage.grd_4c_GradeItens2.ColumnCount  = 10
347:             loc_oPage.grd_4c_GradeItens2.RecordSource = IIF(USED("TmpFinal"), "TmpFinal", "")
348:             WITH loc_oPage.grd_4c_GradeItens2
349:                 .Top          = 181
350:                 .Left         = 53
351:                 .Width        = 703
352:                 .Height       = 189
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
614:             loc_oPage.grd_4c_GradeLinhas.ColumnCount  = 5
615:             loc_oPage.grd_4c_GradeLinhas.RecordSource = IIF(USED("TmpLinha"), "TmpLinha", "")
616:             WITH loc_oPage.grd_4c_GradeLinhas
617:                 .Top          = 181
618:                 .Left         = 167
619:                 .Width        = 438
620:                 .Height       = 292
621:                 .RecordMark   = .F.
622:                 .DeleteMark   = .F.
623:                 .ReadOnly     = .T.
624:                 .Visible      = .F.
625: 

*-- Linhas 669 a 738:
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
721:             loc_oPage.grd_4c_GradeDisp.ColumnCount  = 5
722:             loc_oPage.grd_4c_GradeDisp.RecordSource = IIF(USED("TmpDisp"), "TmpDisp", "")
723:             WITH loc_oPage.grd_4c_GradeDisp
724:                 .Top          = 169
725:                 .Left         = 191
726:                 .Width        = 370
727:                 .Height       = 244
728:                 .RecordMark   = .F.
729:                 .DeleteMark   = .F.
730:                 .Visible      = .F.
731: 
732:                 WITH .Column1
733:                     .Header1.Caption = "Grupo"
734:                     .ControlSource   = "TmpDisp.Grupos"
735:                     .Width           = 60
736:                     .ReadOnly        = .T.
737:                 ENDWITH
738:                 WITH .Column2

*-- Linhas 761 a 901:
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
814:                 .Top         = 2
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
884:             loc_oPage.grd_4c_GradeDisp.ColumnCount  = 5
885:             loc_oPage.grd_4c_GradeDisp.RecordSource = IIF(USED("TmpDisp"), "TmpDisp", "")
886:             WITH loc_oPage.grd_4c_GradeDisp
887:                 .Top          = 181
888:                 .Left         = 239
889:                 .Width        = 327
890:                 .Height       = 228
891:                 .RecordMark   = .F.
892:                 .DeleteMark   = .F.
893:                 .Visible      = .F.
894: 
895:                 WITH .Column1
896:                     .Header1.Caption = "Produto"
897:                     .ControlSource   = "TmpDisp.Cpros"
898:                     .Width           = 55
899:                     .ReadOnly        = .T.
900:                 ENDWITH
901:                 WITH .Column2

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
976:                 .Top         = 2
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
1045:             loc_oPage.grd_4c_GradePedra.ColumnCount  = 5
1046:             loc_oPage.grd_4c_GradePedra.RecordSource = IIF(USED("SelPedra"), "SelPedra", "")

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

*-- Linhas 1188 a 1295:
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
1208:             IF INLIST(loc_cNome, "CNT_4C_AGUARDE", "CNT_4C_SOMBRA", ;
1209:                 "CNT_4C_CONTAINER5", "CNT_4C_CONTAINER3", "CNT_4C_CONTAINER1")
1210:                 *-- Containers ocultos por design: torna filhos visiveis mas mantem container oculto
1211:                 THIS.TornarControlesVisiveis(loc_oCtrl)
1212:                 LOOP
1213:             ENDIF
1214: 
1215:             IF PEMSTATUS(loc_oCtrl, "Visible", 5)
1216:                 loc_oCtrl.Visible = .T.
1217:             ENDIF
1218: 
1219:             IF UPPER(loc_oCtrl.BaseClass) = "PAGEFRAME"
1220:                 FOR loc_p = 1 TO loc_oCtrl.PageCount
1221:                     THIS.TornarControlesVisiveis(loc_oCtrl.Pages(loc_p))
1222:                 ENDFOR
1223:             ELSE
1224:                 IF PEMSTATUS(loc_oCtrl, "ControlCount", 5)
1225:                 IF loc_oCtrl.ControlCount > 0
1226:                     THIS.TornarControlesVisiveis(loc_oCtrl)
1227:                 ENDIF
1228:                 ENDIF
1229:             ENDIF
1230:         ENDFOR
1231:     ENDPROC
1232: 
1233:     *--------------------------------------------------------------------------
1234:     * FormatarGrid - Configura aparencia visual padrao de um grid
1235:     *--------------------------------------------------------------------------
1236:     PROCEDURE FormatarGrid(par_oGrid)
1237: 
1238:         IF ISNULL(par_oGrid) OR !ISOBJECT(par_oGrid)
1239:             RETURN
1240:         ENDIF
1241: 
1242:         WITH par_oGrid
1243:             .FontName   = "Verdana"
1244:             .FontSize   = 8
1245:             .RecordMark = .F.
1246:             .DeleteMark = .F.
1247:             .FontName = "Verdana"
1248:             .FontSize = 8
1249:         ENDWITH
1250:     ENDPROC
1251: 
1252:     *--------------------------------------------------------------------------
1253:     * ConfigurarPaginaLista - Adiciona grade de itens e controles na Page1
1254:     *--------------------------------------------------------------------------
1255:     PROTECTED PROCEDURE ConfigurarPaginaLista()
1256: 
1257:         LOCAL loc_oPage, loc_oGrid
1258: 
1259:         TRY
1260:             loc_oPage = THIS.pgf_4c_1.Page1
1261: 
1262:             *-- Shapes decorativos
1263:             loc_oPage.AddObject("shp_4c_Shape2", "Shape")
1264:             WITH loc_oPage.shp_4c_Shape2
1265:                 .Top     = 12
1266:                 .Left    = 10
1267:                 .Width   = 342
1268:                 .Height  = 110
1269:                 .Visible = .F.
1270:             ENDWITH
1271: 
1272:             loc_oPage.AddObject("shp_4c_Shape3", "Shape")
1273:             WITH loc_oPage.shp_4c_Shape3
1274:                 .Top     = 9
1275:                 .Left    = 605
1276:                 .Width   = 173
1277:                 .Height  = 38
1278:                 .Visible = .F.
1279:             ENDWITH
1280: 
1281:             *-- Imagem do produto
1282:             loc_oPage.AddObject("img_4c_ImgFigJpg", "Image")
1283:             WITH loc_oPage.img_4c_ImgFigJpg
1284:                 .Top     = 255
1285:                 .Left    = 646
1286:                 .Width   = 122
1287:                 .Height  = 89
1288:                 .Stretch = 2
1289:                 .Visible = .F.
1290:             ENDWITH
1291: 
1292:             *-- Grade principal de itens
1293:             loc_oPage.AddObject("grd_4c_GradeItens", "Grid")
1294:             loc_oPage.grd_4c_GradeItens.ColumnCount  = 10
1295:             loc_oPage.grd_4c_GradeItens.RecordSource = IIF(USED("TmpFinalg"), "TmpFinalg", "")

*-- Linhas 1390 a 1518:
1390:                 .Caption   = "Totais :"
1391:                 .BackStyle = 0
1392:                 .Visible   = .F.
1393:             ENDWITH
1394: 
1395:             loc_oPage.AddObject("txt_4c_Tot_Qtd", "TextBox")
1396:             WITH loc_oPage.txt_4c_Tot_Qtd
1397:                 .Top       = 346
1398:                 .Left      = 271
1399:                 .Width     = 67
1400:                 .Height    = 19
1401:                 .ReadOnly  = .T.
1402:                 .Alignment = 1
1403:                 .Visible   = .F.
1404:             ENDWITH
1405: 
1406:             loc_oPage.AddObject("txt_4c_Tot_prdc", "TextBox")
1407:             WITH loc_oPage.txt_4c_Tot_prdc
1408:                 .Top       = 346
1409:                 .Left      = 339
1410:                 .Width     = 67
1411:                 .Height    = 19
1412:                 .ReadOnly  = .T.
1413:                 .Alignment = 1
1414:                 .Visible   = .F.
1415:             ENDWITH
1416: 
1417:             loc_oPage.AddObject("txt_4c_Tot_Est", "TextBox")
1418:             WITH loc_oPage.txt_4c_Tot_Est
1419:                 .Top       = 346
1420:                 .Left      = 407
1421:                 .Width     = 68
1422:                 .Height    = 19
1423:                 .ReadOnly  = .T.
1424:                 .Alignment = 1
1425:                 .Visible   = .F.
1426:             ENDWITH
1427: 
1428:             loc_oPage.AddObject("txt_4c_Tot_Prz", "TextBox")
1429:             WITH loc_oPage.txt_4c_Tot_Prz
1430:                 .Top       = 346
1431:                 .Left      = 476
1432:                 .Width     = 67
1433:                 .Height    = 19
1434:                 .ReadOnly  = .T.
1435:                 .Alignment = 1
1436:                 .Visible   = .F.
1437:             ENDWITH
1438: 
1439:             loc_oPage.AddObject("txt_4c_Tot_prze", "TextBox")
1440:             WITH loc_oPage.txt_4c_Tot_prze
1441:                 .Top       = 346
1442:                 .Left      = 543
1443:                 .Width     = 75
1444:                 .Height    = 19
1445:                 .ReadOnly  = .T.
1446:                 .Alignment = 1
1447:                 .Visible   = .F.
1448:             ENDWITH
1449: 
1450:             *-- Popula containers e adiciona botoes
1451:             THIS.ConfigurarContainer5()
1452:             THIS.ConfigurarGradeContainer3()
1453:             THIS.ConfigurarGradeContainer1()
1454:             THIS.ConfigurarBotoesPage1()
1455: 
1456:             *-- BINDEVENTs da grade principal
1457:             loc_oGrid = loc_oPage.grd_4c_GradeItens
1458:             BINDEVENT(loc_oGrid,                "AfterRowColChange", THIS, "GradeItensAfterRowColChange")
1459:             BINDEVENT(loc_oGrid.Column3.Text1,  "Click",             THIS, "ColC3Click")
1460:             BINDEVENT(loc_oGrid.Column7.Text1,  "When",              THIS, "ColC7When")
1461:             BINDEVENT(loc_oGrid.Column7.Text1,  "Valid",             THIS, "ColC7Valid")
1462:             BINDEVENT(loc_oGrid.Column7.Text1,  "KeyPress",         THIS, "ColC7LostFocus")
1463:             BINDEVENT(loc_oGrid.Column8.Text1,  "When",              THIS, "ColC8When")
1464:             BINDEVENT(loc_oGrid.Column8.Text1,  "KeyPress",         THIS, "ColC8LostFocus")
1465:             BINDEVENT(loc_oGrid.Column10.Text1, "When",              THIS, "ColC10When")
1466:             BINDEVENT(loc_oGrid.Column10.Text1, "Valid",             THIS, "ColC10Valid")
1467:             BINDEVENT(loc_oGrid.Column10.Text1, "KeyPress",         THIS, "ColC10LostFocus")
1468:             BINDEVENT(loc_oPage.img_4c_ImgFigJpg, "Click",          THIS, "ImgFigJpgClick")
1469: 
1470:         CATCH TO loc_oErro
1471:             MsgErro("Erro ao configurar lista: " + loc_oErro.Message, "Erro")
1472:         ENDTRY
1473:     ENDPROC
1474: 
1475:     *--------------------------------------------------------------------------
1476:     * ConfigurarContainer5 - Controles de info do produto (barra superior)
1477:     *--------------------------------------------------------------------------
1478:     PROTECTED PROCEDURE ConfigurarContainer5()
1479: 
1480:         LOCAL loc_oCnt
1481: 
1482:         TRY
1483:             loc_oCnt = THIS.pgf_4c_1.Page1.cnt_4c_Container5
1484: 
1485:             loc_oCnt.AddObject("lbl_4c_Lab_periodo", "Label")
1486:             WITH loc_oCnt.lbl_4c_Lab_periodo
1487:                 .Top       = 2
1488:                 .Left      = 8
1489:                 .Width     = 105
1490:                 .Height    = 15
1491:                 .Caption   = "Per" + CHR(237) + "odo: xx meses"
1492:                 .BackStyle = 0
1493:                 .Visible   = .F.
1494:             ENDWITH
1495: 
1496:             loc_oCnt.AddObject("lbl_4c_Lab_produto", "Label")
1497:             WITH loc_oCnt.lbl_4c_Lab_produto
1498:                 .Top       = 18
1499:                 .Left      = 8
1500:                 .Width     = 127
1501:                 .Height    = 15
1502:                 .Caption   = "Referencia Analisada :"
1503:                 .BackStyle = 0
1504:                 .Visible   = .F.
1505:             ENDWITH
1506: 
1507:             loc_oCnt.AddObject("txt_4c_Cpros", "TextBox")
1508:             WITH loc_oCnt.txt_4c_Cpros
1509:                 .Top      = 16
1510:                 .Left     = 141
1511:                 .Width    = 108
1512:                 .Height   = 19
1513:                 .ReadOnly = .T.
1514:                 .Visible  = .F.
1515:             ENDWITH
1516: 
1517:             loc_oCnt.AddObject("lbl_4c_LblQtdVenda", "Label")
1518:             WITH loc_oCnt.lbl_4c_LblQtdVenda

*-- Linhas 1566 a 1609:
1566:     *--------------------------------------------------------------------------
1567:     * ConfigurarGradeContainer3 - Grade de estoque disponivel por grupo/conta
1568:     *--------------------------------------------------------------------------
1569:     PROTECTED PROCEDURE ConfigurarGradeContainer3()
1570: 
1571:         LOCAL loc_oCnt, loc_oGrid
1572: 
1573:         TRY
1574:             loc_oCnt = THIS.pgf_4c_1.Page1.cnt_4c_Container3
1575: 
1576:             loc_oCnt.AddObject("lbl_4c_Label1", "Label")
1577:             WITH loc_oCnt.lbl_4c_Label1
1578:                 .Top       = 1
1579:                 .Left      = 0
1580:                 .Width     = 363
1581:                 .Height    = 16
1582:                 .Caption   = "Estoque Dispon" + CHR(237) + "vel"
1583:                 .BackStyle = 0
1584:                 .FontBold  = .T.
1585:                 .Visible   = .F.
1586:             ENDWITH
1587: 
1588:             loc_oCnt.AddObject("grd_4c_EstDisp", "Grid")
1589:             loc_oCnt.grd_4c_EstDisp.ColumnCount  = 6
1590:             loc_oCnt.grd_4c_EstDisp.RecordSource = IIF(USED("TmpSaldG"), "TmpSaldG", "")
1591:             WITH loc_oCnt.grd_4c_EstDisp
1592:                 .Top          = 15
1593:                 .Left         = 3
1594:                 .Width        = 358
1595:                 .Height       = 147
1596:                 .RecordMark   = .F.
1597:                 .DeleteMark   = .F.
1598:                 .ReadOnly     = .F.
1599:                 .Visible      = .F.
1600: 
1601:                 WITH .Column1
1602:                     .Header1.Caption = "Grupo"
1603:                     .ControlSource   = "TmpSaldG.Grupos"
1604:                     .Width           = 50
1605:                     .ReadOnly        = .T.
1606:                 ENDWITH
1607: 
1608:                 WITH .Column2
1609:                     .Header1.Caption = "Conta"

*-- Linhas 1656 a 1747:
1656:                 .Caption   = "Totais :"
1657:                 .BackStyle = 0
1658:                 .Visible   = .F.
1659:             ENDWITH
1660: 
1661:             loc_oCnt.AddObject("txt_4c_Tot_Qtd", "TextBox")
1662:             WITH loc_oCnt.txt_4c_Tot_Qtd
1663:                 .Top       = 161
1664:                 .Left      = 174
1665:                 .Width     = 58
1666:                 .Height    = 19
1667:                 .ReadOnly  = .T.
1668:                 .Alignment = 1
1669:                 .Visible   = .F.
1670:             ENDWITH
1671: 
1672:             loc_oCnt.AddObject("txt_4c_Tot_Est", "TextBox")
1673:             WITH loc_oCnt.txt_4c_Tot_Est
1674:                 .Top       = 161
1675:                 .Left      = 234
1676:                 .Width     = 58
1677:                 .Height    = 19
1678:                 .ReadOnly  = .T.
1679:                 .Alignment = 1
1680:                 .Visible   = .F.
1681:             ENDWITH
1682: 
1683:             loc_oCnt.AddObject("txt_4c_Tot_Prz", "TextBox")
1684:             WITH loc_oCnt.txt_4c_Tot_Prz
1685:                 .Top       = 161
1686:                 .Left      = 292
1687:                 .Width     = 58
1688:                 .Height    = 19
1689:                 .ReadOnly  = .T.
1690:                 .Alignment = 1
1691:                 .Visible   = .F.
1692:             ENDWITH
1693: 
1694:             *-- BINDEVENTs: coluna Prior editavel somente quando producao plena
1695:             loc_oGrid = loc_oCnt.grd_4c_EstDisp
1696:             BINDEVENT(loc_oGrid.Column6.Text1, "When",      THIS, "EstDispC6When")
1697:             BINDEVENT(loc_oGrid.Column6.Text1, "KeyPress", THIS, "EstDispC6LostFocus")
1698: 
1699:         CATCH TO loc_oErro
1700:             MsgErro("Erro ao configurar Container3: " + loc_oErro.Message, "Erro")
1701:         ENDTRY
1702:     ENDPROC
1703: 
1704:     *--------------------------------------------------------------------------
1705:     * ConfigurarGradeContainer1 - Grade de estoque em producao por fase/OP
1706:     *--------------------------------------------------------------------------
1707:     PROTECTED PROCEDURE ConfigurarGradeContainer1()
1708: 
1709:         LOCAL loc_oCnt
1710: 
1711:         TRY
1712:             loc_oCnt = THIS.pgf_4c_1.Page1.cnt_4c_Container1
1713: 
1714:             loc_oCnt.AddObject("lbl_4c_Label1", "Label")
1715:             WITH loc_oCnt.lbl_4c_Label1
1716:                 .Top       = 1
1717:                 .Left      = 1
1718:                 .Width     = 305
1719:                 .Height    = 16
1720:                 .Caption   = "Estoque Em Produ" + CHR(231) + CHR(227) + "o"
1721:                 .BackStyle = 0
1722:                 .FontBold  = .T.
1723:                 .Visible   = .F.
1724:             ENDWITH
1725: 
1726:             loc_oCnt.AddObject("grd_4c_EstProd", "Grid")
1727:             loc_oCnt.grd_4c_EstProd.ColumnCount  = 5
1728:             loc_oCnt.grd_4c_EstProd.RecordSource = IIF(USED("TmpFinal"), "TmpFinal", "")
1729:             WITH loc_oCnt.grd_4c_EstProd
1730:                 .Top          = 15
1731:                 .Left         = 2
1732:                 .Width        = 303
1733:                 .Height       = 99
1734:                 .RecordMark   = .F.
1735:                 .DeleteMark   = .F.
1736:                 .ReadOnly     = .T.
1737:                 .Visible      = .F.
1738: 
1739:                 WITH .Column1
1740:                     .Header1.Caption = "Fase"
1741:                     .ControlSource   = "TmpFinal.Dopes"
1742:                     .Width           = 55
1743:                 ENDWITH
1744: 
1745:                 WITH .Column2
1746:                     .Header1.Caption = "Disponivel"
1747:                     .ControlSource   = "TmpFinal.Saldo"

*-- Linhas 1782 a 1857:
1782:                 .Caption   = "Totais :"
1783:                 .BackStyle = 0
1784:                 .Visible   = .F.
1785:             ENDWITH
1786: 
1787:             loc_oCnt.AddObject("txt_4c_Tot_Qtd", "TextBox")
1788:             WITH loc_oCnt.txt_4c_Tot_Qtd
1789:                 .Top       = 113
1790:                 .Left      = 145
1791:                 .Width     = 61
1792:                 .Height    = 19
1793:                 .ReadOnly  = .T.
1794:                 .Alignment = 1
1795:                 .Visible   = .F.
1796:             ENDWITH
1797: 
1798:             loc_oCnt.AddObject("txt_4c_Tot_Est", "TextBox")
1799:             WITH loc_oCnt.txt_4c_Tot_Est
1800:                 .Top       = 113
1801:                 .Left      = 207
1802:                 .Width     = 61
1803:                 .Height    = 19
1804:                 .ReadOnly  = .T.
1805:                 .Alignment = 1
1806:                 .Visible   = .F.
1807:             ENDWITH
1808: 
1809:         CATCH TO loc_oErro
1810:             MsgErro("Erro ao configurar Container1: " + loc_oErro.Message, "Erro")
1811:         ENDTRY
1812:     ENDPROC
1813: 
1814:     *--------------------------------------------------------------------------
1815:     * ConfigurarBotoesPage1 - Adiciona botoes de acao na Page1
1816:     *--------------------------------------------------------------------------
1817:     PROTECTED PROCEDURE ConfigurarBotoesPage1()
1818: 
1819:         LOCAL loc_oPage
1820: 
1821:         TRY
1822:             loc_oPage = THIS.pgf_4c_1.Page1
1823: 
1824:             loc_oPage.AddObject("cmd_4c_Pedras", "CommandButton")
1825:             WITH loc_oPage.cmd_4c_Pedras
1826:                 .Top         = 2
1827:                 .Left        = 348
1828:                 .Width       = 75
1829:                 .Height      = 75
1830:                 .Caption     = "Requisi" + CHR(231) + CHR(245) + "es"
1831:                 .FontName    = "Tahoma"
1832:                 .FontSize    = 8
1833:                 .Themes      = .T.
1834:                 .Visible     = .F.
1835:                 .ToolTipText = "Requisi" + CHR(231) + CHR(245) + "es de Material"
1836:             ENDWITH
1837: 
1838:             loc_oPage.AddObject("cmd_4c_SelEstoque", "CommandButton")
1839:             WITH loc_oPage.cmd_4c_SelEstoque
1840:                 .Top         = 2
1841:                 .Left        = 423
1842:                 .Width       = 75
1843:                 .Height      = 75
1844:                 .Caption     = "Estoques"
1845:                 .FontName    = "Tahoma"
1846:                 .FontSize    = 8
1847:                 .Themes      = .T.
1848:                 .Visible     = .F.
1849:                 .ToolTipText = "Selecionar Estoque"
1850:             ENDWITH
1851: 
1852:             loc_oPage.AddObject("cmd_4c_Disponivel", "CommandButton")
1853:             WITH loc_oPage.cmd_4c_Disponivel
1854:                 .Top         = 2
1855:                 .Left        = 498
1856:                 .Width       = 75
1857:                 .Height      = 75

*-- Linhas 1919 a 2086:
1919:                 .ToolTipText = "Autorizar edi" + CHR(231) + CHR(227) + "o de quantidade"
1920:             ENDWITH
1921: 
1922:             *-- BINDEVENTs
1923:             BINDEVENT(loc_oPage.cmd_4c_Pedras,     "Click", THIS, "BtnPedrasClick")
1924:             BINDEVENT(loc_oPage.cmd_4c_SelEstoque, "Click", THIS, "BtnSelEstoqueClick")
1925:             BINDEVENT(loc_oPage.cmd_4c_Disponivel, "Click", THIS, "BtnDisponivelClick")
1926:             BINDEVENT(loc_oPage.cmd_4c_TotLinha,   "Click", THIS, "BtnTotLinhaClick")
1927:             BINDEVENT(loc_oPage.cmd_4c_Processar,  "Click", THIS, "BtnProcessarClick")
1928:             BINDEVENT(loc_oPage.cmd_4c_Encerrar,   "Click", THIS, "BtnEncerrarClick")
1929:             BINDEVENT(loc_oPage.cmd_4c_Alteraqtd,  "Click", THIS, "BtnAlteraqtdClick")
1930: 
1931:         CATCH TO loc_oErro
1932:             MsgErro("Erro ao configurar bot" + CHR(245) + "es: " + loc_oErro.Message, "Erro")
1933:         ENDTRY
1934:     ENDPROC
1935: 
1936:     *--------------------------------------------------------------------------
1937:     * AjustarVisibilidadeBotoes - Reaplica visibilidade apos TornarControlesVisiveis
1938:     *--------------------------------------------------------------------------
1939:     PROTECTED PROCEDURE AjustarVisibilidadeBotoes()
1940: 
1941:         LOCAL loc_oPage
1942: 
1943:         TRY
1944:             loc_oPage = THIS.pgf_4c_1.Page1
1945:             IF PEMSTATUS(loc_oPage, "cmd_4c_Disponivel", 5)
1946:                 loc_oPage.cmd_4c_Disponivel.Visible = .F.
1947:             ENDIF
1948:             IF PEMSTATUS(loc_oPage, "cmd_4c_SelEstoque", 5) AND ;
1949:                !ISNULL(THIS.this_oBusinessObject) AND ISOBJECT(THIS.this_oBusinessObject)
1950:                 loc_oPage.cmd_4c_SelEstoque.Visible = THIS.this_oBusinessObject.this_lSelEstoqueVisivel
1951:             ENDIF
1952:             IF PEMSTATUS(loc_oPage, "cmd_4c_Pedras", 5) AND ;
1953:                !ISNULL(THIS.this_oBusinessObject) AND ISOBJECT(THIS.this_oBusinessObject)
1954:                 loc_oPage.cmd_4c_Pedras.Visible = THIS.this_oBusinessObject.this_lPedrasVisiveis
1955:             ENDIF
1956:         CATCH TO loc_oErro
1957:             MsgErro("Erro ao ajustar visibilidade: " + loc_oErro.Message, "Erro")
1958:         ENDTRY
1959:     ENDPROC
1960: 
1961:     *--------------------------------------------------------------------------
1962:     * AlternarPagina - Ativa pagina e gerencia estado das demais
1963:     *--------------------------------------------------------------------------
1964:     PROCEDURE AlternarPagina(par_nPagina)
1965: 
1966:         LOCAL loc_oPgf
1967: 
1968:         TRY
1969:             loc_oPgf = THIS.pgf_4c_1
1970: 
1971:             DO CASE
1972:             CASE par_nPagina <= 2
1973:                 loc_oPgf.Page1.Enabled = .T.
1974:                 loc_oPgf.Page2.Enabled = .T.
1975:                 loc_oPgf.Page3.Enabled = .F.
1976:                 loc_oPgf.Page4.Enabled = .F.
1977:                 loc_oPgf.Page5.Enabled = .F.
1978:                 loc_oPgf.Page6.Enabled = .F.
1979:             CASE par_nPagina = 3
1980:                 loc_oPgf.Page3.Enabled = .T.
1981:                 loc_oPgf.Page4.Enabled = .F.
1982:                 loc_oPgf.Page5.Enabled = .F.
1983:                 loc_oPgf.Page6.Enabled = .F.
1984:             CASE par_nPagina = 4
1985:                 loc_oPgf.Page3.Enabled = .F.
1986:                 loc_oPgf.Page4.Enabled = .T.
1987:                 loc_oPgf.Page5.Enabled = .F.
1988:                 loc_oPgf.Page6.Enabled = .F.
1989:             CASE par_nPagina = 5
1990:                 loc_oPgf.Page3.Enabled = .F.
1991:                 loc_oPgf.Page4.Enabled = .F.
1992:                 loc_oPgf.Page5.Enabled = .T.
1993:                 loc_oPgf.Page6.Enabled = .F.
1994:             CASE par_nPagina = 6
1995:                 loc_oPgf.Page3.Enabled = .F.
1996:                 loc_oPgf.Page4.Enabled = .F.
1997:                 loc_oPgf.Page5.Enabled = .F.
1998:                 loc_oPgf.Page6.Enabled = .T.
1999:             ENDCASE
2000: 
2001:             loc_oPgf.ActivePage = par_nPagina
2002: 
2003:         CATCH TO loc_oErro
2004:             MsgErro("Erro ao alternar p" + CHR(225) + "gina: " + loc_oErro.Message, "Erro")
2005:         ENDTRY
2006:     ENDPROC
2007: 
2008:     *--------------------------------------------------------------------------
2009:     * GradeItensAfterRowColChange - Atualiza painel ao mudar linha (BINDEVENT)
2010:     *--------------------------------------------------------------------------
2011:     PROCEDURE GradeItensAfterRowColChange
2012:         LPARAMETERS par_nColIndex
2013: 
2014:         LOCAL loc_oPage, loc_oCnt3, loc_oCnt5, loc_cCapCor, loc_cCapTam
2015: 
2016:         loc_cCapCor = ""
2017:         loc_cCapTam = ""
2018: 
2019:         IF !USED("TmpFinalg") OR BOF("TmpFinalg") OR EOF("TmpFinalg")
2020:             RETURN
2021:         ENDIF
2022: 
2023:         TRY
2024:             loc_oPage = THIS.pgf_4c_1.Page1
2025: 
2026:             *-- Filtra TmpSaldG pelo item atual
2027:             IF USED("TmpSaldG")
2028:                 SELECT TmpSaldG
2029:                 SET ORDER TO Cpros
2030:                 SET KEY TO ALLTRIM(TmpFinalg.Cpros) + ALLTRIM(TmpFinalg.CodCors) + ;
2031:                     ALLTRIM(TmpFinalg.CodTams)
2032:                 GO TOP
2033:             ENDIF
2034: 
2035:             *-- Filtra TmpFinal pelo item atual (Container1)
2036:             IF USED("TmpFinal")
2037:                 SELECT TmpFinal
2038:                 SET ORDER TO Cpros
2039:                 SET KEY TO ALLTRIM(TmpFinalg.Cpros) + ALLTRIM(TmpFinalg.CodCors) + ;
2040:                     ALLTRIM(TmpFinalg.CodTams)
2041:                 GO TOP
2042:             ENDIF
2043: 
2044:             *-- Totais de Container3 via TmpSaldo (registro unico por produto/cor/tam)
2045:             IF USED("TmpSaldo") AND SEEK(ALLTRIM(TmpFinalg.Cpros) + ;
2046:                ALLTRIM(TmpFinalg.CodCors) + ALLTRIM(TmpFinalg.CodTams), "TmpSaldo")
2047: 
2048:                 loc_oCnt3 = loc_oPage.cnt_4c_Container3
2049:                 IF PEMSTATUS(loc_oCnt3, "txt_4c_Tot_Qtd", 5)
2050:                     loc_oCnt3.txt_4c_Tot_Qtd.Value = TmpSaldo.Saldo
2051:                     loc_oCnt3.txt_4c_Tot_Est.Value = TmpSaldo.Saldo - TmpSaldo.Disps
2052:                     loc_oCnt3.txt_4c_Tot_Prz.Value = TmpSaldo.Disps
2053:                 ENDIF
2054: 
2055:                 loc_cCapCor = IIF(!EMPTY(ALLTRIM(TmpFinalg.CodCors)), ;
2056:                     " Cor:" + ALLTRIM(TmpFinalg.CodCors), "")
2057:                 loc_cCapTam = IIF(!EMPTY(ALLTRIM(TmpFinalg.CodTams)), ;
2058:                     " Tam:" + ALLTRIM(TmpFinalg.CodTams), "")
2059:                 IF PEMSTATUS(loc_oCnt3, "lbl_4c_Label1", 5)
2060:                     loc_oCnt3.lbl_4c_Label1.Caption = "Estoque Dispon" + CHR(237) + ;
2061:                         "vel " + ALLTRIM(TmpFinalg.Cpros) + loc_cCapCor + loc_cCapTam
2062:                 ENDIF
2063: 
2064:                 IF PEMSTATUS(loc_oCnt3, "grd_4c_EstDisp", 5)
2065:                     loc_oCnt3.grd_4c_EstDisp.Refresh
2066:                 ENDIF
2067:             ENDIF
2068: 
2069:             *-- Atualiza Container1 (TmpFinal ja filtrado)
2070:             IF PEMSTATUS(loc_oPage.cnt_4c_Container1, "grd_4c_EstProd", 5)
2071:                 loc_oPage.cnt_4c_Container1.grd_4c_EstProd.Refresh
2072:             ENDIF
2073: 
2074:             *-- Atualiza Container5 com produto/cor/tam
2075:             loc_oCnt5 = loc_oPage.cnt_4c_Container5
2076:             IF PEMSTATUS(loc_oCnt5, "txt_4c_Cpros", 5)
2077:                 loc_oCnt5.txt_4c_Cpros.Value = ALLTRIM(TmpFinalg.Cpros) + ;
2078:                     loc_cCapCor + loc_cCapTam
2079:             ENDIF
2080:             IF PEMSTATUS(loc_oCnt5, "txt_4c_Minima", 5)
2081:                 loc_oCnt5.txt_4c_Minima.Value = TmpFinalg.QtdMins
2082:             ENDIF
2083: 
2084:             *-- Carrega foto
2085:             THIS.CarregarFotoProduto(ALLTRIM(TmpFinalg.Cpros))
2086: 

*-- Linhas 2092 a 3183:
2092:     *--------------------------------------------------------------------------
2093:     * CarregarFotoProduto - Carrega imagem JPG do produto via SQL Server
2094:     *--------------------------------------------------------------------------
2095:     PROTECTED PROCEDURE CarregarFotoProduto(par_cCpros)
2096: 
2097:         LOCAL loc_cArquivo, loc_cSql, loc_cFoto, loc_oImg
2098: 
2099:         loc_cArquivo = ""
2100:         loc_cFoto    = ""
2101: 
2102:         TRY
2103:             loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
2104:             loc_cSql     = "SELECT a.cpros, a.FigJpgs FROM SigCdPro a " + ;
2105:                 "WHERE a.cpros = " + EscaparSQL(par_cCpros)
2106: 
2107:             IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_FotoPro") > 0 AND ;
2108:                USED("cursor_4c_FotoPro") AND RECCOUNT("cursor_4c_FotoPro") > 0
2109:                 SELECT cursor_4c_FotoPro
2110:                 IF !EMPTY(cursor_4c_FotoPro.FigJpgs) AND !ISNULL(cursor_4c_FotoPro.FigJpgs)
2111:                     loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_FotoPro.FigJpgs, ;
2112:                         "data:image/png;base64,",  ""), ;
2113:                         "data:image/jpeg;base64,", ""), ;
2114:                         "data:image/jpg;base64,",  ""), 14)
2115:                     =STRTOFILE(loc_cFoto, loc_cArquivo)
2116:                     loc_oImg = THIS.pgf_4c_1.Page1.img_4c_ImgFigJpg
2117:                     IF FILE(loc_cArquivo) AND PEMSTATUS(loc_oImg, "Picture", 5)
2118:                         loc_oImg.Picture = loc_cArquivo
2119:                         loc_oImg.Visible = .T.
2120:                     ENDIF
2121:                 ELSE
2122:                     THIS.pgf_4c_1.Page1.img_4c_ImgFigJpg.Visible = .F.
2123:                 ENDIF
2124:                 USE IN cursor_4c_FotoPro
2125:             ELSE
2126:                 IF PEMSTATUS(THIS.pgf_4c_1.Page1, "img_4c_ImgFigJpg", 5)
2127:                     THIS.pgf_4c_1.Page1.img_4c_ImgFigJpg.Visible = .F.
2128:                 ENDIF
2129:             ENDIF
2130:         CATCH TO loc_oErro
2131:             MsgErro("Erro ao carregar foto: " + loc_oErro.Message, "Erro")
2132:         ENDTRY
2133:     ENDPROC
2134: 
2135:     *--------------------------------------------------------------------------
2136:     * AtualizarTotaisPage1 - Calcula e exibe totais da grade de itens
2137:     *--------------------------------------------------------------------------
2138:     PROCEDURE AtualizarTotaisPage1()
2139: 
2140:         LOCAL loc_oPage, loc_nSaldo, loc_nEstoque, loc_nProduzir, loc_nFabrs
2141:         LOCAL loc_nProduzir2, loc_nRecno
2142: 
2143:         IF !USED("TmpFinalg") OR RECCOUNT("TmpFinalg") = 0
2144:             RETURN
2145:         ENDIF
2146: 
2147:         TRY
2148:             loc_oPage = THIS.pgf_4c_1.Page1
2149:             IF PEMSTATUS(loc_oPage, "txt_4c_Tot_Qtd", 5)
2150: 
2151:                 loc_nSaldo     = 0
2152:                 loc_nEstoque   = 0
2153:                 loc_nProduzir  = 0
2154:                 loc_nFabrs     = 0
2155:                 loc_nProduzir2 = 0
2156:                 loc_nRecno     = IIF(!BOF("TmpFinalg") AND !EOF("TmpFinalg"), ;
2157:                     RECNO("TmpFinalg"), 0)
2158: 
2159:                 SELECT TmpFinalg
2160:                 SUM Saldo, Estoque, Produzir, Fabrs, Produzir2 ;
2161:                     TO loc_nSaldo, loc_nEstoque, loc_nProduzir, loc_nFabrs, loc_nProduzir2
2162: 
2163:                 IF loc_nRecno > 0 AND RECCOUNT("TmpFinalg") >= loc_nRecno
2164:                     GO loc_nRecno IN TmpFinalg
2165:                 ENDIF
2166: 
2167:                 WITH loc_oPage
2168:                     .txt_4c_Tot_Qtd.Value  = loc_nSaldo
2169:                     .txt_4c_Tot_Est.Value  = loc_nEstoque
2170:                     .txt_4c_Tot_Prz.Value  = loc_nProduzir
2171:                     .txt_4c_Tot_prdc.Value = loc_nFabrs
2172:                     .txt_4c_Tot_prze.Value = loc_nProduzir2
2173:                     .txt_4c_Tot_Qtd.Refresh
2174:                     .txt_4c_Tot_Est.Refresh
2175:                     .txt_4c_Tot_Prz.Refresh
2176:                     .txt_4c_Tot_prdc.Refresh
2177:                     .txt_4c_Tot_prze.Refresh
2178:                 ENDWITH
2179:             ENDIF
2180:         CATCH TO loc_oErro
2181:             MsgErro("Erro ao atualizar totais: " + loc_oErro.Message, "Erro")
2182:         ENDTRY
2183:     ENDPROC
2184: 
2185:     *--------------------------------------------------------------------------
2186:     * ColC7When - Handler When da coluna 7 (Fabrs) - salva valor anterior
2187:     *--------------------------------------------------------------------------
2188:     PROCEDURE ColC7When
2189: 
2190:         LOCAL loc_lResultado
2191: 
2192:         loc_lResultado = .T.
2193:         TRY
2194:             IF USED("TmpFinalg") AND !EOF("TmpFinalg")
2195:                 THIS.this_nOldValue = TmpFinalg.Fabrs
2196:             ENDIF
2197:         CATCH TO loc_oErro
2198:             MsgErro("Erro em ColC7When: " + loc_oErro.Message, "Erro")
2199:         ENDTRY
2200:         RETURN loc_lResultado
2201:     ENDPROC
2202: 
2203:     *--------------------------------------------------------------------------
2204:     * ColC7Valid - Handler Valid da coluna 7 (Fabrs) - valida quantidade
2205:     *--------------------------------------------------------------------------
2206:     PROCEDURE ColC7Valid
2207: 
2208:         LOCAL loc_lResultado, loc_nNewVal, loc_oGrid, loc_nOld
2209: 
2210:         loc_lResultado = 1
2211: 
2212:         TRY
2213:             loc_oGrid   = THIS.pgf_4c_1.Page1.grd_4c_GradeItens
2214:             loc_nNewVal = loc_oGrid.Column7.Text1.Value
2215:             loc_nOld    = THIS.this_nOldValue
2216: 
2217:             IF USED("TmpFinalg") AND !EOF("TmpFinalg") AND USED("TmpSaldU")
2218:                 IF !SEEK(ALLTRIM(TmpFinalg.Cpros), "TmpSaldU", "Cpros")
2219:                     INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinalg.Cpros)
2220:                 ENDIF
2221: 
2222:                 IF loc_nNewVal <> loc_nOld AND TmpSaldU.KeySelmp
2223:                     IF !MsgConfirma("Produto com Sele" + CHR(231) + CHR(227) + ;
2224:                         "o Manual de OP." + CHR(13) + ;
2225:                         "O sistema ir" + CHR(225) + " acionar o modo autom" + ;
2226:                         CHR(225) + "tico. Deseja Continuar?")
2227:                         loc_oGrid.Column7.Text1.Value = loc_nOld
2228:                         loc_lResultado = 0
2229:                     ENDIF
2230:                 ENDIF
2231:             ENDIF
2232: 
2233:             IF loc_lResultado = 1 AND USED("TmpFinalg") AND !EOF("TmpFinalg")
2234:                 DO CASE
2235:                 CASE loc_nNewVal = loc_nOld
2236:                     *-- Sem mudanca
2237:                 CASE loc_nNewVal < 0
2238:                     MsgAviso("A quantidade n" + CHR(227) + "o pode ser um valor negativo!!!")
2239:                     loc_oGrid.Column7.Text1.Value = loc_nOld
2240:                     loc_lResultado = 0
2241:                 CASE loc_nNewVal > TmpFinalg.Saldo
2242:                     MsgAviso("A Quantidade n" + CHR(227) + "o pode ser maior que a do Pedido!!!")
2243:                     loc_oGrid.Column7.Text1.Value = loc_nOld
2244:                     loc_lResultado = 0
2245:                 OTHERWISE
2246:                     SELECT TmpFinalg
2247:                     REPLACE Fabrs WITH loc_nNewVal
2248:                 ENDCASE
2249:             ENDIF
2250:         CATCH TO loc_oErro
2251:             MsgErro("Erro na valida" + CHR(231) + CHR(227) + "o da coluna 7: " + ;
2252:                 loc_oErro.Message, "Erro")
2253:             loc_lResultado = 0
2254:         ENDTRY
2255:         RETURN loc_lResultado
2256:     ENDPROC
2257: 
2258:     *--------------------------------------------------------------------------
2259:     * ColC7LostFocus - Handler LostFocus da coluna 7 - atualiza totais
2260:     *--------------------------------------------------------------------------
2261:     PROCEDURE ColC7LostFocus
2262:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
2263:         THIS.AtualizarTotaisPage1()
2264:     ENDPROC
2265: 
2266:     *--------------------------------------------------------------------------
2267:     * ColC8When - Handler When da coluna 8 (Produzir2) - verifica liberacao
2268:     *--------------------------------------------------------------------------
2269:     PROCEDURE ColC8When
2270: 
2271:         LOCAL loc_lResultado
2272: 
2273:         loc_lResultado = IIF(THIS.this_lLiberado, 1, 0)
2274:         RETURN loc_lResultado
2275:     ENDPROC
2276: 
2277:     *--------------------------------------------------------------------------
2278:     * ColC8LostFocus - Handler LostFocus da coluna 8 - reseta liberacao
2279:     *--------------------------------------------------------------------------
2280:     PROCEDURE ColC8LostFocus
2281:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
2282:         THIS.this_lLiberado = .F.
2283:     ENDPROC
2284: 
2285:     *--------------------------------------------------------------------------
2286:     * ColC10When - Handler When da coluna 10 (Estoque) - salva e checa disponivel
2287:     *--------------------------------------------------------------------------
2288:     PROCEDURE ColC10When
2289: 
2290:         LOCAL loc_lResultado, loc_cSql, loc_lMostraDisp
2291: 
2292:         loc_lResultado  = .T.
2293:         loc_lMostraDisp = .F.
2294: 
2295:         TRY
2296:             IF USED("TmpFinalg") AND !EOF("TmpFinalg")
2297:                 THIS.this_nOldValue = TmpFinalg.Estoque
2298:             ENDIF
2299: 
2300:             IF PEMSTATUS(THIS.pgf_4c_1.Page1, "cmd_4c_Disponivel", 5)
2301:                 THIS.pgf_4c_1.Page1.cmd_4c_Disponivel.Visible = .F.
2302:             ENDIF
2303: 
2304:             *-- Em modo reserva com estoque zero, verifica tipo do grupo
2305:             IF USED("TmpFinalg") AND !EOF("TmpFinalg") AND ;
2306:                !ISNULL(THIS.this_oBusinessObject) AND ISOBJECT(THIS.this_oBusinessObject)
2307:                 IF THIS.this_oBusinessObject.this_lReserva AND TmpFinalg.Estoque = 0
2308:                     loc_cSql = "SELECT a.CGrus, b.TipoEstos " + ;
2309:                         "FROM SigCdPro a INNER JOIN SigCdGrp b ON a.CGrus = b.CGrus " + ;
2310:                         "WHERE a.CPros = " + EscaparSQL(ALLTRIM(TmpFinalg.Cpros))
2311:                     IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_GrpTipo") > 0 AND ;
2312:                        USED("cursor_4c_GrpTipo") AND RECCOUNT("cursor_4c_GrpTipo") > 0
2313:                         SELECT cursor_4c_GrpTipo
2314:                         loc_lMostraDisp = INLIST(cursor_4c_GrpTipo.TipoEstos, 3, 4)
2315:                         USE IN cursor_4c_GrpTipo
2316:                         IF loc_lMostraDisp AND ;
2317:                            PEMSTATUS(THIS.pgf_4c_1.Page1, "cmd_4c_Disponivel", 5)
2318:                             THIS.pgf_4c_1.Page1.cmd_4c_Disponivel.Visible = .T.
2319:                         ENDIF
2320:                     ENDIF
2321:                 ENDIF
2322:             ENDIF
2323:         CATCH TO loc_oErro
2324:             MsgErro("Erro em ColC10When: " + loc_oErro.Message, "Erro")
2325:         ENDTRY
2326:         RETURN loc_lResultado
2327:     ENDPROC
2328: 
2329:     *--------------------------------------------------------------------------
2330:     * ColC10Valid - Handler Valid da coluna 10 (Estoque) - valida quantidade
2331:     *--------------------------------------------------------------------------
2332:     PROCEDURE ColC10Valid
2333: 
2334:         LOCAL loc_lResultado, loc_nNewVal, loc_oGrid, loc_nOld
2335: 
2336:         loc_lResultado = 1
2337: 
2338:         TRY
2339:             loc_oGrid   = THIS.pgf_4c_1.Page1.grd_4c_GradeItens
2340:             loc_nNewVal = loc_oGrid.Column10.Text1.Value
2341:             loc_nOld    = THIS.this_nOldValue
2342: 
2343:             IF USED("TmpFinalg") AND !EOF("TmpFinalg") AND USED("TmpSaldU")
2344:                 IF !SEEK(ALLTRIM(TmpFinalg.Cpros), "TmpSaldU", "Cpros")
2345:                     INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinalg.Cpros)
2346:                 ENDIF
2347: 
2348:                 IF loc_nNewVal <> loc_nOld AND TmpSaldU.KeySelm
2349:                     IF !MsgConfirma("Produto com Sele" + CHR(231) + CHR(227) + ;
2350:                         "o Manual de estoque." + CHR(13) + ;
2351:                         "O sistema ir" + CHR(225) + " acionar o modo autom" + ;
2352:                         CHR(225) + "tico. Deseja Continuar?")
2353:                         loc_oGrid.Column10.Text1.Value = loc_nOld
2354:                         loc_lResultado = 0
2355:                     ENDIF
2356:                 ENDIF
2357:             ENDIF
2358: 
2359:             IF loc_lResultado = 1 AND USED("TmpFinalg") AND !EOF("TmpFinalg")
2360:                 DO CASE
2361:                 CASE loc_nNewVal = loc_nOld
2362:                     *-- Sem mudanca
2363:                 CASE loc_nNewVal < 0
2364:                     MsgAviso("A quantidade n" + CHR(227) + "o pode ser um valor negativo!!!")
2365:                     loc_oGrid.Column10.Text1.Value = loc_nOld
2366:                     loc_lResultado = 0
2367:                 OTHERWISE
2368:                     SELECT TmpFinalg
2369:                     REPLACE Estoque WITH loc_nNewVal
2370:                 ENDCASE
2371:             ENDIF
2372:         CATCH TO loc_oErro
2373:             MsgErro("Erro na valida" + CHR(231) + CHR(227) + "o da coluna 10: " + ;
2374:                 loc_oErro.Message, "Erro")
2375:             loc_lResultado = 0
2376:         ENDTRY
2377:         RETURN loc_lResultado
2378:     ENDPROC
2379: 
2380:     *--------------------------------------------------------------------------
2381:     * ColC10LostFocus - Handler LostFocus da coluna 10 - atualiza totais
2382:     *--------------------------------------------------------------------------
2383:     PROCEDURE ColC10LostFocus
2384:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
2385:         THIS.AtualizarTotaisPage1()
2386:     ENDPROC
2387: 
2388:     *--------------------------------------------------------------------------
2389:     * EstDispC6When - Handler When da coluna Prior do grd_4c_EstDisp
2390:     *--------------------------------------------------------------------------
2391:     PROCEDURE EstDispC6When
2392: 
2393:         LOCAL loc_lResultado
2394: 
2395:         loc_lResultado = 0
2396:         TRY
2397:             IF USED("TmpFinalg") AND !EOF("TmpFinalg")
2398:                 loc_lResultado = IIF(TmpFinalg.Produzir + TmpFinalg.Fabrs = TmpFinalg.Saldo, 1, 0)
2399:             ENDIF
2400:         CATCH TO loc_oErro
2401:             MsgErro("Erro em EstDispC6When: " + loc_oErro.Message, "Erro")
2402:         ENDTRY
2403:         RETURN loc_lResultado
2404:     ENDPROC
2405: 
2406:     *--------------------------------------------------------------------------
2407:     * EstDispC6LostFocus - Handler LostFocus da coluna Prior do grd_4c_EstDisp
2408:     *--------------------------------------------------------------------------
2409:     PROCEDURE EstDispC6LostFocus
2410:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
2411: 
2412:         TRY
2413:             IF USED("TmpSaldG") AND RECCOUNT("TmpSaldG") > 0
2414:                 SELECT TmpSaldG
2415:                 SKIP
2416:                 SKIP -1
2417:                 IF PEMSTATUS(THIS.pgf_4c_1.Page1.cnt_4c_Container3, "grd_4c_EstDisp", 5)
2418:                     THIS.pgf_4c_1.Page1.cnt_4c_Container3.grd_4c_EstDisp.Refresh
2419:                 ENDIF
2420:             ENDIF
2421:         CATCH TO loc_oErro
2422:             MsgErro("Erro em EstDispC6LostFocus: " + loc_oErro.Message, "Erro")
2423:         ENDTRY
2424:     ENDPROC
2425: 
2426:     *--------------------------------------------------------------------------
2427:     * ColC3Click - Handler Click na coluna 3 - navega para Page2 (detalhes)
2428:     *--------------------------------------------------------------------------
2429:     PROCEDURE ColC3Click
2430: 
2431:         TRY
2432:             THIS.AlternarPagina(2)
2433:         CATCH TO loc_oErro
2434:             MsgErro("Erro ao navegar para Page2: " + loc_oErro.Message, "Erro")
2435:         ENDTRY
2436:     ENDPROC
2437: 
2438:     *--------------------------------------------------------------------------
2439:     * ImgFigJpgClick - Handler Click na imagem do produto
2440:     *--------------------------------------------------------------------------
2441:     PROCEDURE ImgFigJpgClick
2442: 
2443:         TRY
2444:             IF USED("TmpFinalg") AND !EOF("TmpFinalg")
2445:                 THIS.CarregarFotoProduto(ALLTRIM(TmpFinalg.Cpros))
2446:             ENDIF
2447:         CATCH TO loc_oErro
2448:             MsgErro("Erro ao carregar foto: " + loc_oErro.Message, "Erro")
2449:         ENDTRY
2450:     ENDPROC
2451: 
2452:     *--------------------------------------------------------------------------
2453:     * BtnPedrasClick - Abre Page6 com requisicoes de material
2454:     *--------------------------------------------------------------------------
2455:     PROCEDURE BtnPedrasClick
2456: 
2457:         LOCAL loc_lResultado, loc_cCpro
2458: 
2459:         loc_lResultado = .F.
2460:         TRY
2461:             IF USED("TmpFinalg") AND !EOF("TmpFinalg")
2462:                 loc_cCpro = ALLTRIM(TmpFinalg.Cpros)
2463: 
2464:                 IF USED("SelPedra")
2465:                     IF PEMSTATUS(THIS.pgf_4c_1.Page6, "grd_4c_GradePedra", 5)
2466:                         THIS.pgf_4c_1.Page6.grd_4c_GradePedra.RecordSource = ""
2467:                     ENDIF
2468:                     USE IN SelPedra
2469:                 ENDIF
2470: 
2471:                 IF USED("CrSigCdPac")
2472:                     SELECT Cpros, Dpros, Cunis, Qtdes, CodPros, ;
2473:                         SPACE(14) AS Cpro2s ;
2474:                         FROM CrSigCdPac ;
2475:                         INTO CURSOR SelPedra ORDER BY Cpros READWRITE
2476: 
2477:                     IF RECCOUNT("SelPedra") > 0
2478:                         IF PEMSTATUS(THIS.pgf_4c_1.Page6, "grd_4c_GradePedra", 5)
2479:                             THIS.pgf_4c_1.Page6.grd_4c_GradePedra.RecordSource = "SelPedra"
2480:                         ENDIF
2481:                         IF PEMSTATUS(THIS.pgf_4c_1.Page6, "txt_4c_Cpros", 5)
2482:                             THIS.pgf_4c_1.Page6.txt_4c_Cpros.Value = loc_cCpro
2483:                         ENDIF
2484:                         THIS.AlternarPagina(6)
2485:                         loc_lResultado = .T.
2486:                     ELSE
2487:                         MsgAviso("Nenhuma requisi" + CHR(231) + CHR(227) + ;
2488:                             "o de material para este produto.")
2489:                         IF USED("SelPedra")
2490:                             USE IN SelPedra
2491:                         ENDIF
2492:                     ENDIF
2493:                 ENDIF
2494:             ENDIF
2495:         CATCH TO loc_oErro
2496:             MsgErro("Erro ao exibir requisi" + CHR(231) + CHR(245) + "es: " + ;
2497:                 loc_oErro.Message, "Erro")
2498:         ENDTRY
2499:     ENDPROC
2500: 
2501:     *--------------------------------------------------------------------------
2502:     * BtnSelEstoqueClick - Abre Page4 com selecao de estoque disponivel
2503:     *--------------------------------------------------------------------------
2504:     PROCEDURE BtnSelEstoqueClick
2505: 
2506:         LOCAL loc_lResultado, loc_cCpro, loc_cCor, loc_cTam
2507: 
2508:         loc_lResultado = .F.
2509:         TRY
2510:             IF USED("TmpFinalg") AND !EOF("TmpFinalg")
2511:                 loc_cCpro = ALLTRIM(TmpFinalg.Cpros)
2512:                 loc_cCor  = ALLTRIM(TmpFinalg.CodCors)
2513:                 loc_cTam  = ALLTRIM(TmpFinalg.CodTams)
2514: 
2515:                 IF USED("TmpDisp")
2516:                     IF PEMSTATUS(THIS.pgf_4c_1.Page4, "grd_4c_GradeDisp", 5)
2517:                         THIS.pgf_4c_1.Page4.grd_4c_GradeDisp.RecordSource = ""
2518:                     ENDIF
2519:                     USE IN TmpDisp
2520:                 ENDIF
2521: 
2522:                 SELECT Priors, Grupos, Estos, Cpros, CodCors, CodTams, Disps, ;
2523:                     0.000 AS Utilizar ;
2524:                     FROM TmpSaldG ;
2525:                     WHERE Cpros = m.loc_cCpro AND CodCors = m.loc_cCor AND ;
2526:                     CodTams = m.loc_cTam AND Disps > 0 ;
2527:                     INTO CURSOR TmpDisp ORDER BY Priors, Grupos, Estos, Cpros READWRITE
2528: 
2529:                 IF RECCOUNT("TmpDisp") > 0
2530:                     IF PEMSTATUS(THIS.pgf_4c_1.Page4, "txt_4c_Cpros", 5)
2531:                         THIS.pgf_4c_1.Page4.txt_4c_Cpros.Value = loc_cCpro + ;
2532:                             IIF(!EMPTY(loc_cCor), " Cor:" + loc_cCor, "") + ;
2533:                             IIF(!EMPTY(loc_cTam), " Tam:" + loc_cTam, "")
2534:                     ENDIF
2535:                     IF PEMSTATUS(THIS.pgf_4c_1.Page4, "txt_4c_Qt_pedida", 5)
2536:                         THIS.pgf_4c_1.Page4.txt_4c_Qt_pedida.Value = TmpFinalg.Saldo
2537:                     ENDIF
2538:                     IF PEMSTATUS(THIS.pgf_4c_1.Page4, "txt_4c_Qt_Selec", 5)
2539:                         THIS.pgf_4c_1.Page4.txt_4c_Qt_Selec.Value = 0
2540:                     ENDIF
2541:                     THIS.AlternarPagina(4)
2542:                     loc_lResultado = .T.
2543:                 ELSE
2544:                     MsgAviso("Nenhum estoque dispon" + CHR(237) + "vel para este item.")
2545:                     IF USED("TmpDisp")
2546:                         USE IN TmpDisp
2547:                     ENDIF
2548:                 ENDIF
2549:             ENDIF
2550:         CATCH TO loc_oErro
2551:             MsgErro("Erro ao selecionar estoque: " + loc_oErro.Message, "Erro")
2552:         ENDTRY
2553:     ENDPROC
2554: 
2555:     *--------------------------------------------------------------------------
2556:     * BtnDisponivelClick - Abre Page5 com disponivel por tamanho
2557:     *--------------------------------------------------------------------------
2558:     PROCEDURE BtnDisponivelClick
2559: 
2560:         LOCAL loc_lResultado, loc_cCpro, loc_cCor
2561: 
2562:         loc_lResultado = .F.
2563:         TRY
2564:             IF !USED("TmpFinalg") OR EOF("TmpFinalg")
2565:                 *-- sem dados
2566:             ELSE
2567:                 IF TmpFinalg.Estoque <> 0 OR TmpFinalg.Fabrs <> 0
2568:                 MsgAviso("Quantidade de Estoque e Produ" + CHR(231) + CHR(227) + ;
2569:                     "o tem estar Zero antes deste Processo!!!")
2570:                 IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5)
2571:                     THIS.pgf_4c_1.Page1.grd_4c_GradeItens.SetFocus
2572:                 ENDIF
2573:             ELSE
2574:                 loc_cCpro = ALLTRIM(TmpFinalg.Cpros)
2575:                 loc_cCor  = ALLTRIM(TmpFinalg.CodCors)
2576: 
2577:                 IF USED("TmpDisp")
2578:                     IF PEMSTATUS(THIS.pgf_4c_1.Page5, "grd_4c_GradeDisp", 5)
2579:                         THIS.pgf_4c_1.Page5.grd_4c_GradeDisp.RecordSource = ""
2580:                     ENDIF
2581:                     USE IN TmpDisp
2582:                 ENDIF
2583: 
2584:                 SELECT Cpros, CodCors, CodTams, Disps, 0.000 AS Utilizar ;
2585:                     FROM TmpSaldo ;
2586:                     WHERE Cpros = m.loc_cCpro AND CodCors = m.loc_cCor AND Disps > 0 ;
2587:                     INTO CURSOR TmpDisp ORDER BY CodTams READWRITE
2588: 
2589:                 IF RECCOUNT("TmpDisp") > 0
2590:                     IF PEMSTATUS(THIS.pgf_4c_1.Page5, "txt_4c_Cpros", 5)
2591:                         THIS.pgf_4c_1.Page5.txt_4c_Cpros.Value = loc_cCpro + ;
2592:                             IIF(!EMPTY(loc_cCor), " Cor:" + loc_cCor, "")
2593:                     ENDIF
2594:                     IF PEMSTATUS(THIS.pgf_4c_1.Page5, "txt_4c_Qt_pedida", 5)
2595:                         THIS.pgf_4c_1.Page5.txt_4c_Qt_pedida.Value = TmpFinalg.Saldo
2596:                     ENDIF
2597:                     IF PEMSTATUS(THIS.pgf_4c_1.Page5, "txt_4c_Qt_Selec", 5)
2598:                         THIS.pgf_4c_1.Page5.txt_4c_Qt_Selec.Value = 0
2599:                     ENDIF
2600:                     THIS.AlternarPagina(5)
2601:                     loc_lResultado = .T.
2602:                 ELSE
2603:                     MsgAviso("Nenhum disponivel para este item.")
2604:                     IF USED("TmpDisp")
2605:                         USE IN TmpDisp
2606:                     ENDIF
2607:                 ENDIF
2608:                 ENDIF
2609:             ENDIF
2610:         CATCH TO loc_oErro
2611:             MsgErro("Erro ao exibir dispon" + CHR(237) + "veis: " + loc_oErro.Message, "Erro")
2612:         ENDTRY
2613:     ENDPROC
2614: 
2615:     *--------------------------------------------------------------------------
2616:     * BtnTotLinhaClick - Agrupa totais por linha e exibe na Page3
2617:     *--------------------------------------------------------------------------
2618:     PROCEDURE BtnTotLinhaClick
2619: 
2620:         LOCAL loc_lResultado
2621: 
2622:         loc_lResultado = .F.
2623:         TRY
2624:             IF !USED("TmpFinalg") OR RECCOUNT("TmpFinalg") = 0
2625:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " dados para totalizar.")
2626:             ELSE
2627:                 IF USED("TmpLinha")
2628:                     IF PEMSTATUS(THIS.pgf_4c_1.Page3, "grd_4c_GradeLinhas", 5)
2629:                         THIS.pgf_4c_1.Page3.grd_4c_GradeLinhas.RecordSource = ""
2630:                     ENDIF
2631:                 ENDIF
2632: 
2633:                 SELECT Linhas, 0 AS Ordem, SUM(Saldo) AS Saldo, ;
2634:                     SUM(Estoque) AS Estoque, SUM(Produzir) AS Produzir, SUM(Fabrs) AS Fabrs ;
2635:                     FROM TmpFinalg GROUP BY 1 ;
2636:                     UNION ALL ;
2637:                     SELECT PADR("TOTAIS", 10) AS Linhas, 1 AS Ordem, ;
2638:                     SUM(Saldo) AS Saldo, SUM(Estoque) AS Estoque, ;
2639:                     SUM(Produzir) AS Produzir, SUM(Fabrs) AS Fabrs ;
2640:                     FROM TmpFinalg GROUP BY 1 ;
2641:                     INTO CURSOR TmpLinha ORDER BY 2, 1
2642: 
2643:                 THIS.AlternarPagina(3)
2644:                 loc_lResultado = .T.
2645:             ENDIF
2646:         CATCH TO loc_oErro
2647:             MsgErro("Erro ao calcular totais por linha: " + loc_oErro.Message, "Erro")
2648:         ENDTRY
2649:     ENDPROC
2650: 
2651:     *--------------------------------------------------------------------------
2652:     * BtnProcessarClick - Processa globalizacao via BO
2653:     *--------------------------------------------------------------------------
2654:     PROCEDURE BtnProcessarClick
2655: 
2656:         LOCAL loc_lResultado
2657: 
2658:         loc_lResultado = .F.
2659:         THIS.MostrarAguarde("Processando Globaliza" + CHR(231) + CHR(227) + "o...")
2660:         TRY
2661:             IF THIS.this_oBusinessObject.ProcessarGlobalizacao()
2662:                 THIS.AtualizarTotaisPage1()
2663:                 IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5)
2664:                     THIS.pgf_4c_1.Page1.grd_4c_GradeItens.Refresh
2665:                 ENDIF
2666:                 loc_lResultado = .T.
2667:             ENDIF
2668:         CATCH TO loc_oErro
2669:             MsgErro("Erro ao processar: " + loc_oErro.Message, "Erro")
2670:         ENDTRY
2671:         THIS.OcultarAguarde()
2672:     ENDPROC
2673: 
2674:     *--------------------------------------------------------------------------
2675:     * BtnEncerrarClick - Encerra o form filho e reativa o form pai
2676:     *--------------------------------------------------------------------------
2677:     PROCEDURE BtnEncerrarClick
2678: 
2679:         TRY
2680:             IF !ISNULL(THIS.this_oParentForm) AND ISOBJECT(THIS.this_oParentForm)
2681:                 THIS.this_oParentForm.Enabled = .T.
2682:             ENDIF
2683:         CATCH TO loc_oErro
2684:             MsgErro("Erro ao encerrar: " + loc_oErro.Message, "Erro")
2685:         ENDTRY
2686:         THIS.Release()
2687:     ENDPROC
2688: 
2689:     *--------------------------------------------------------------------------
2690:     * BtnAlteraqtdClick - Autoriza edicao de quantidade para estoque (senha)
2691:     *--------------------------------------------------------------------------
2692:     PROCEDURE BtnAlteraqtdClick
2693: 
2694:         LOCAL loc_lResultado, loc_cString, loc_cRetorno, loc_lOk
2695: 
2696:         loc_lResultado = .F.
2697:         loc_cRetorno   = ""
2698:         loc_lOk        = .F.
2699: 
2700:         TRY
2701:             IF !USED("TmpFinalg") OR EOF("TmpFinalg")
2702:                 *-- sem acao
2703:             ELSE
2704:                 IF TmpFinalg.Produzir2 = 0
2705:                 MsgAviso("Referencia Sem Quantidade a Produzir para Estoque!!!")
2706:                 IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5)
2707:                     THIS.pgf_4c_1.Page1.grd_4c_GradeItens.SetFocus
2708:                 ENDIF
2709:             ELSE
2710:                 loc_cString = ALLTRIM(TmpFinalg.Cpros) + " Qt.Min:" + ;
2711:                     ALLTRIM(TRANSFORM(TmpFinalg.QtdMins, "@Z 99999.999")) + " " + ;
2712:                     "Qt.Est:" + ALLTRIM(TRANSFORM(TmpFinalg.Produzir2, "@Z 99999.999"))
2713: 
2714:                 DO FORM SigOpSen WITH "PRDZRISCO", loc_cString, "" TO loc_cRetorno
2715: 
2716:                 CLEAR TYPEAHEAD
2717:                 loc_lOk = (LEFT(loc_cRetorno, 1) = "*")
2718: 
2719:                 IF loc_lOk
2720:                     THIS.this_lLiberado = .T.
2721:                     IF PEMSTATUS(THIS.pgf_4c_1.Page1.grd_4c_GradeItens, "Column8", 5)
2722:                         THIS.pgf_4c_1.Page1.grd_4c_GradeItens.Column8.SetFocus
2723:                     ENDIF
2724:                     loc_lResultado = .T.
2725:                 ELSE
2726:                     MsgAviso("Altera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
2727:                         "o autorizada!!!")
2728:                 ENDIF
2729:                 ENDIF
2730:             ENDIF
2731:         CATCH TO loc_oErro
2732:             MsgErro("Erro em Alteraqtd: " + loc_oErro.Message, "Erro")
2733:         ENDTRY
2734:     ENDPROC
2735: 
2736:     *--------------------------------------------------------------------------
2737:     * Pagina2Activate - Inicializa selecao de estoque/producao ao entrar na Page2
2738:     *--------------------------------------------------------------------------
2739:     PROCEDURE Pagina2Activate()
2740:         LOCAL loc_cCpros, loc_nOldRecno
2741: 
2742:         TRY
2743:             IF USED("TmpFinalg") AND !EOF("TmpFinalg")
2744:                 loc_cCpros = ALLTRIM(TmpFinalg.Cpros)
2745: 
2746:                 THIS.this_nTotSEst = TmpFinalg.Estoque
2747:                 THIS.this_nTotSPrc = TmpFinalg.Fabrs
2748: 
2749:                 IF USED("TmpFinal")
2750:                     loc_nOldRecno = IIF(RECCOUNT("TmpFinal") > 0, RECNO("TmpFinal"), 0)
2751:                     SELECT TmpFinal
2752:                     SET KEY TO (m.loc_cCpros)
2753:                     THIS.AtualizarTotaisPage2()
2754:                     IF loc_nOldRecno > 0 AND loc_nOldRecno <= RECCOUNT("TmpFinal")
2755:                         GO loc_nOldRecno IN TmpFinal
2756:                     ENDIF
2757:                 ENDIF
2758: 
2759:                 IF PEMSTATUS(THIS.pgf_4c_1.Page2, "txt_4c_Tot_sEst", 5)
2760:                     THIS.pgf_4c_1.Page2.txt_4c_Tot_sEst.Value = THIS.this_nTotSEst
2761:                 ENDIF
2762:                 IF PEMSTATUS(THIS.pgf_4c_1.Page2, "txt_4c_Tot_sPrc", 5)
2763:                     THIS.pgf_4c_1.Page2.txt_4c_Tot_sPrc.Value = THIS.this_nTotSPrc
2764:                 ENDIF
2765: 
2766:                 IF PEMSTATUS(THIS.pgf_4c_1.Page2, "edt_4c_ObsItens", 5) AND USED("TmpFinal") AND !EOF("TmpFinal")
2767:                     THIS.pgf_4c_1.Page2.edt_4c_ObsItens.Value = ALLTRIM(TmpFinal.CodObs)
2768:                 ENDIF
2769:             ENDIF
2770:         CATCH TO loc_oErro
2771:             MsgErro("Erro em Pagina2Activate: " + loc_oErro.Message, "Erro")
2772:         ENDTRY
2773:     ENDPROC
2774: 
2775:     *--------------------------------------------------------------------------
2776:     * AtualizarTotaisPage2 - Recalcula totais do grid de Page2
2777:     *--------------------------------------------------------------------------
2778:     PROCEDURE AtualizarTotaisPage2()
2779:         LOCAL loc_nOldRecno, loc_nSaldo, loc_nEstoque, loc_nProduzir, loc_nFabrs
2780: 
2781:         TRY
2782:             IF USED("TmpFinal") AND RECCOUNT("TmpFinal") > 0
2783:                 loc_nOldRecno = RECNO("TmpFinal")
2784:                 SELECT TmpFinal
2785:                 loc_nSaldo    = 0
2786:                 loc_nEstoque  = 0
2787:                 loc_nProduzir = 0
2788:                 loc_nFabrs    = 0
2789:                 SUM Saldo, Estoque, Produzir, Fabrs ;
2790:                     TO loc_nSaldo, loc_nEstoque, loc_nProduzir, loc_nFabrs
2791:                 IF loc_nOldRecno > 0 AND loc_nOldRecno <= RECCOUNT("TmpFinal")
2792:                     GO loc_nOldRecno
2793:                 ENDIF
2794: 
2795:                 IF PEMSTATUS(THIS.pgf_4c_1.Page2, "txt_4c_TotQtdP2", 5)
2796:                     THIS.pgf_4c_1.Page2.txt_4c_TotQtdP2.Value = loc_nSaldo
2797:                 ENDIF
2798:                 IF PEMSTATUS(THIS.pgf_4c_1.Page2, "txt_4c_TotEstP2", 5)
2799:                     THIS.pgf_4c_1.Page2.txt_4c_TotEstP2.Value = loc_nEstoque
2800:                 ENDIF
2801:                 IF PEMSTATUS(THIS.pgf_4c_1.Page2, "txt_4c_TotPrzP2", 5)
2802:                     THIS.pgf_4c_1.Page2.txt_4c_TotPrzP2.Value = loc_nProduzir
2803:                 ENDIF
2804:                 IF PEMSTATUS(THIS.pgf_4c_1.Page2, "txt_4c_TotPrcP2", 5)
2805:                     THIS.pgf_4c_1.Page2.txt_4c_TotPrcP2.Value = loc_nFabrs
2806:                 ENDIF
2807: 
2808:                 THIS.this_oBusinessObject.this_nTotQtdP2  = loc_nSaldo
2809:                 THIS.this_oBusinessObject.this_nTotEstP2  = loc_nEstoque
2810:                 THIS.this_oBusinessObject.this_nTotPrzP2  = loc_nProduzir
2811:                 THIS.this_oBusinessObject.this_nTotPrcP2  = loc_nFabrs
2812:             ENDIF
2813:         CATCH TO loc_oErro
2814:             MsgErro("Erro em AtualizarTotaisPage2: " + loc_oErro.Message, "Erro")
2815:         ENDTRY
2816:     ENDPROC
2817: 
2818:     *--------------------------------------------------------------------------
2819:     * P2GradeAfterRowColChange - Atualiza obs/foto ao mudar linha no grid P2
2820:     *--------------------------------------------------------------------------
2821:     PROCEDURE P2GradeAfterRowColChange(par_nColIndex)
2822:         LOCAL loc_cCpros, loc_oRS, loc_nRes, loc_cSQL
2823: 
2824:         TRY
2825:             IF USED("TmpFinal") AND !EOF("TmpFinal")
2826:                 loc_cCpros = ALLTRIM(TmpFinal.Cpros)
2827: 
2828:                 IF PEMSTATUS(THIS.pgf_4c_1.Page2, "edt_4c_ObsItens", 5)
2829:                     THIS.pgf_4c_1.Page2.edt_4c_ObsItens.Value = ALLTRIM(TmpFinal.CodObs)
2830:                 ENDIF
2831: 
2832:                 IF PEMSTATUS(THIS.pgf_4c_1.Page2, "lbl_4c_Txt_ObsItens", 5)
2833:                     THIS.pgf_4c_1.Page2.lbl_4c_Txt_ObsItens.Caption = ALLTRIM(TmpFinal.Cpros)
2834:                 ENDIF
2835: 
2836:                 IF !EMPTY(loc_cCpros) AND gnConnHandle > 0
2837:                     loc_cSQL = "SELECT TOP 1 Fotos FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCpros)
2838:                     loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FotoP2")
2839:                     IF loc_nRes > 0 AND USED("cursor_4c_FotoP2") AND !EOF("cursor_4c_FotoP2")
2840:                         IF !EMPTY(cursor_4c_FotoP2.Fotos) AND PEMSTATUS(THIS.pgf_4c_1.Page2, "img_4c_ImgFigJpg", 5)
2841:                             THIS.pgf_4c_1.Page2.img_4c_ImgFigJpg.PictureVal = STRCONV(cursor_4c_FotoP2.Fotos, 14)
2842:                         ENDIF
2843:                         USE IN cursor_4c_FotoP2
2844:                     ENDIF
2845:                 ENDIF
2846:             ENDIF
2847:         CATCH TO loc_oErro
2848:             MsgErro("Erro em P2GradeAfterRowColChange: " + loc_oErro.Message, "Erro")
2849:         ENDTRY
2850:     ENDPROC
2851: 
2852:     *--------------------------------------------------------------------------
2853:     * P2ColGotFocusToCol7 - Redireciona foco para coluna Estoque (Col7)
2854:     *--------------------------------------------------------------------------
2855:     PROCEDURE P2ColGotFocusToCol7()
2856:         TRY
2857:             IF PEMSTATUS(THIS.pgf_4c_1.Page2, "grd_4c_GradeItens2", 5)
2858:                 THIS.pgf_4c_1.Page2.grd_4c_GradeItens2.Column7.SetFocus()
2859:             ENDIF
2860:         CATCH TO loc_oErro
2861:             MsgErro("Erro em P2ColGotFocusToCol7: " + loc_oErro.Message, "Erro")
2862:         ENDTRY
2863:     ENDPROC
2864: 
2865:     *--------------------------------------------------------------------------
2866:     * P2ColC7When - Salva valor anterior da coluna Estoque antes de editar
2867:     *--------------------------------------------------------------------------
2868:     FUNCTION P2ColC7When()
2869:         LOCAL loc_lResultado
2870: 
2871:         loc_lResultado = .T.
2872: 
2873:         TRY
2874:             IF USED("TmpFinal") AND !EOF("TmpFinal")
2875:                 THIS.this_oBusinessObject.this_nOldValue = TmpFinal.Estoque
2876:             ENDIF
2877:         CATCH TO loc_oErro
2878:             MsgErro("Erro em P2ColC7When: " + loc_oErro.Message, "Erro")
2879:             loc_lResultado = .F.
2880:         ENDTRY
2881: 
2882:         RETURN loc_lResultado
2883:     ENDFUNC
2884: 
2885:     *--------------------------------------------------------------------------
2886:     * P2ColC7Valid - Valida e aplica edicao de Estoque no grid Page2
2887:     *--------------------------------------------------------------------------
2888:     FUNCTION P2ColC7Valid()
2889:         LOCAL loc_lResultado, loc_nNovo, loc_nTotSEst
2890: 
2891:         loc_lResultado = .T.
2892: 
2893:         TRY
2894:             IF USED("TmpFinal") AND !EOF("TmpFinal")
2895:                 loc_nNovo    = THIS.pgf_4c_1.Page2.grd_4c_GradeItens2.Column7.Text1.Value
2896:                 loc_nTotSEst = THIS.this_oBusinessObject.this_nTotSEst
2897: 
2898:                 IF loc_nNovo < 0
2899:                     MsgAviso("Estoque n" + CHR(227) + "o pode ser negativo.")
2900:                     THIS.pgf_4c_1.Page2.grd_4c_GradeItens2.Column7.Text1.Value = THIS.this_oBusinessObject.this_nOldValue
2901:                     loc_lResultado = .F.
2902:                 ELSE
2903:                     IF loc_nNovo > TmpFinal.Saldo
2904:                         MsgAviso("Estoque n" + CHR(227) + "o pode ser maior que o Saldo.")
2905:                         THIS.pgf_4c_1.Page2.grd_4c_GradeItens2.Column7.Text1.Value = THIS.this_oBusinessObject.this_nOldValue
2906:                         loc_lResultado = .F.
2907:                     ELSE
2908:                         LOCAL loc_nDif
2909:                         loc_nDif = loc_nNovo - THIS.this_oBusinessObject.this_nOldValue
2910:                         IF (THIS.this_oBusinessObject.this_nTotQtdP2 + loc_nDif) > loc_nTotSEst
2911:                             MsgAviso("Total de estoque selecionado excede o dispon?vel.")
2912:                             THIS.pgf_4c_1.Page2.grd_4c_GradeItens2.Column7.Text1.Value = THIS.this_oBusinessObject.this_nOldValue
2913:                             loc_lResultado = .F.
2914:                         ELSE
2915:                             REPLACE TmpFinal.Estoque WITH loc_nNovo
2916:                         ENDIF
2917:                     ENDIF
2918:                 ENDIF
2919:             ENDIF
2920:         CATCH TO loc_oErro
2921:             MsgErro("Erro em P2ColC7Valid: " + loc_oErro.Message, "Erro")
2922:             loc_lResultado = .F.
2923:         ENDTRY
2924: 
2925:         RETURN loc_lResultado
2926:     ENDFUNC
2927: 
2928:     *--------------------------------------------------------------------------
2929:     * P2ColC7LostFocus - Atualiza totais apos sair da coluna Estoque
2930:     *--------------------------------------------------------------------------
2931:     PROCEDURE P2ColC7LostFocus(par_nKeyCode, par_nShiftAltCtrl)
2932:         TRY
2933:             THIS.AtualizarTotaisPage2()
2934:         CATCH TO loc_oErro
2935:             MsgErro("Erro em P2ColC7LostFocus: " + loc_oErro.Message, "Erro")
2936:         ENDTRY
2937:     ENDPROC
2938: 
2939:     *--------------------------------------------------------------------------
2940:     * P2ColC10When - Salva valor anterior da coluna Fabrs antes de editar
2941:     *--------------------------------------------------------------------------
2942:     FUNCTION P2ColC10When()
2943:         LOCAL loc_lResultado
2944: 
2945:         loc_lResultado = .T.
2946: 
2947:         TRY
2948:             IF USED("TmpFinal") AND !EOF("TmpFinal")
2949:                 THIS.this_oBusinessObject.this_nOldValue = TmpFinal.Fabrs
2950:             ENDIF
2951:         CATCH TO loc_oErro
2952:             MsgErro("Erro em P2ColC10When: " + loc_oErro.Message, "Erro")
2953:             loc_lResultado = .F.
2954:         ENDTRY
2955: 
2956:         RETURN loc_lResultado
2957:     ENDFUNC
2958: 
2959:     *--------------------------------------------------------------------------
2960:     * P2ColC10Valid - Valida e aplica edicao de Fabrs no grid Page2
2961:     *--------------------------------------------------------------------------
2962:     FUNCTION P2ColC10Valid()
2963:         LOCAL loc_lResultado, loc_nNovo, loc_nTotSPrc
2964: 
2965:         loc_lResultado = .T.
2966: 
2967:         TRY
2968:             IF USED("TmpFinal") AND !EOF("TmpFinal")
2969:                 loc_nNovo    = THIS.pgf_4c_1.Page2.grd_4c_GradeItens2.Column10.Text1.Value
2970:                 loc_nTotSPrc = THIS.this_oBusinessObject.this_nTotSPrc
2971: 
2972:                 IF loc_nNovo < 0
2973:                     MsgAviso("Fabrica" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ser negativa.")
2974:                     THIS.pgf_4c_1.Page2.grd_4c_GradeItens2.Column10.Text1.Value = THIS.this_oBusinessObject.this_nOldValue
2975:                     loc_lResultado = .F.
2976:                 ELSE
2977:                     IF loc_nNovo > TmpFinal.Saldo
2978:                         MsgAviso("Fabrica" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ser maior que o Saldo.")
2979:                         THIS.pgf_4c_1.Page2.grd_4c_GradeItens2.Column10.Text1.Value = THIS.this_oBusinessObject.this_nOldValue
2980:                         loc_lResultado = .F.
2981:                     ELSE
2982:                         LOCAL loc_nDifF
2983:                         loc_nDifF = loc_nNovo - THIS.this_oBusinessObject.this_nOldValue
2984:                         IF (THIS.this_oBusinessObject.this_nTotPrcP2 + loc_nDifF) > loc_nTotSPrc
2985:                             MsgAviso("Total de produ" + CHR(231) + CHR(227) + "o excede o dispon?vel.")
2986:                             THIS.pgf_4c_1.Page2.grd_4c_GradeItens2.Column10.Text1.Value = THIS.this_oBusinessObject.this_nOldValue
2987:                             loc_lResultado = .F.
2988:                         ELSE
2989:                             REPLACE TmpFinal.Fabrs WITH loc_nNovo
2990:                         ENDIF
2991:                     ENDIF
2992:                 ENDIF
2993:             ENDIF
2994:         CATCH TO loc_oErro
2995:             MsgErro("Erro em P2ColC10Valid: " + loc_oErro.Message, "Erro")
2996:             loc_lResultado = .F.
2997:         ENDTRY
2998: 
2999:         RETURN loc_lResultado
3000:     ENDFUNC
3001: 
3002:     *--------------------------------------------------------------------------
3003:     * P2ColC10LostFocus - Atualiza totais apos sair da coluna Fabrs
3004:     *--------------------------------------------------------------------------
3005:     PROCEDURE P2ColC10LostFocus(par_nKeyCode, par_nShiftAltCtrl)
3006:         TRY
3007:             THIS.AtualizarTotaisPage2()
3008:         CATCH TO loc_oErro
3009:             MsgErro("Erro em P2ColC10LostFocus: " + loc_oErro.Message, "Erro")
3010:         ENDTRY
3011:     ENDPROC
3012: 
3013:     *--------------------------------------------------------------------------
3014:     * BtnVoltarPage2Click - Valida totais e retorna para Page1
3015:     *--------------------------------------------------------------------------
3016:     PROCEDURE BtnVoltarPage2Click()
3017:         LOCAL loc_nOldRecno, loc_nSumEst, loc_nSumFabrs
3018: 
3019:         TRY
3020:             IF USED("TmpFinal") AND USED("TmpFinalg") AND !EOF("TmpFinalg")
3021:                 loc_nOldRecno = IIF(RECCOUNT("TmpFinal") > 0, RECNO("TmpFinal"), 0)
3022:                 SELECT TmpFinal
3023:                 loc_nSumEst   = 0
3024:                 loc_nSumFabrs = 0
3025:                 SUM Estoque, Fabrs TO loc_nSumEst, loc_nSumFabrs
3026:                 IF loc_nOldRecno > 0 AND loc_nOldRecno <= RECCOUNT("TmpFinal")
3027:                     GO loc_nOldRecno IN TmpFinal
3028:                 ENDIF
3029: 
3030:                 IF loc_nSumEst != TmpFinalg.Estoque OR loc_nSumFabrs != TmpFinalg.Fabrs
3031:                     MsgAviso("Os totais de estoque/produ" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o conferem com o item selecionado.")
3032:                     RETURN
3033:                 ENDIF
3034:             ENDIF
3035: 
3036:             THIS.AlternarPagina(1)
3037:             THIS.AtualizarTotaisPage1()
3038: 
3039:             IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5)
3040:                 THIS.pgf_4c_1.Page1.grd_4c_GradeItens.Refresh()
3041:             ENDIF
3042:         CATCH TO loc_oErro
3043:             MsgErro("Erro em BtnVoltarPage2Click: " + loc_oErro.Message, "Erro")
3044:         ENDTRY
3045:     ENDPROC
3046: 
3047:     *--------------------------------------------------------------------------
3048:     * BtnVoltarPage3Click - Retorna para Page1 a partir de Page3
3049:     *--------------------------------------------------------------------------
3050:     PROCEDURE BtnVoltarPage3Click()
3051:         TRY
3052:             THIS.AlternarPagina(1)
3053:             IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5)
3054:                 THIS.pgf_4c_1.Page1.grd_4c_GradeItens.SetFocus()
3055:             ENDIF
3056:         CATCH TO loc_oErro
3057:             MsgErro("Erro em BtnVoltarPage3Click: " + loc_oErro.Message, "Erro")
3058:         ENDTRY
3059:     ENDPROC
3060: 
3061:     *--------------------------------------------------------------------------
3062:     * P4ColReadOnlyWhen - Bloqueia edicao em colunas somente-leitura
3063:     *--------------------------------------------------------------------------
3064:     FUNCTION P4ColReadOnlyWhen()
3065:         RETURN 0
3066:     ENDFUNC
3067: 
3068:     *--------------------------------------------------------------------------
3069:     * P4ColC5Valid - Valida quantidade Utilizar na selecao de estoque (Page4)
3070:     *--------------------------------------------------------------------------
3071:     FUNCTION P4ColC5Valid()
3072:         LOCAL loc_lResultado, loc_nUtil, loc_nSumUtil, loc_nOldRecno
3073:         LOCAL loc_nPSaldo
3074: 
3075:         loc_lResultado = .T.
3076: 
3077:         TRY
3078:             IF USED("TmpDisp") AND !EOF("TmpDisp") AND USED("TmpFinalg") AND !EOF("TmpFinalg")
3079:                 loc_nUtil  = THIS.pgf_4c_1.Page4.grd_4c_GradeDisp.Column5.Text1.Value
3080: 
3081:                 IF loc_nUtil < 0
3082:                     MsgAviso("Quantidade n" + CHR(227) + "o pode ser negativa.")
3083:                     THIS.pgf_4c_1.Page4.grd_4c_GradeDisp.Column5.Text1.Value = 0
3084:                     loc_lResultado = .F.
3085:                 ELSE
3086:                     IF loc_nUtil > TmpDisp.Disps
3087:                         MsgAviso("Quantidade excede o dispon?vel.")
3088:                         THIS.pgf_4c_1.Page4.grd_4c_GradeDisp.Column5.Text1.Value = TmpDisp.Disps
3089:                         loc_lResultado = .F.
3090:                     ELSE
3091:                         loc_nPSaldo = TmpFinalg.Saldo - TmpFinalg.Estoque - TmpFinalg.Fabrs
3092: 
3093:                         loc_nOldRecno = IIF(RECCOUNT("TmpDisp") > 0, RECNO("TmpDisp"), 0)
3094:                         SELECT TmpDisp
3095:                         loc_nSumUtil = 0
3096:                         SUM Utilizar TO loc_nSumUtil
3097:                         IF loc_nOldRecno > 0 AND loc_nOldRecno <= RECCOUNT("TmpDisp")
3098:                             GO loc_nOldRecno
3099:                         ENDIF
3100: 
3101:                         loc_nSumUtil = loc_nSumUtil - TmpDisp.Utilizar + loc_nUtil
3102: 
3103:                         IF loc_nSumUtil > loc_nPSaldo
3104:                             MsgAviso("Total selecionado excede o saldo a produzir.")
3105:                             THIS.pgf_4c_1.Page4.grd_4c_GradeDisp.Column5.Text1.Value = 0
3106:                             loc_lResultado = .F.
3107:                         ELSE
3108:                             REPLACE TmpDisp.Utilizar WITH loc_nUtil
3109:                             IF PEMSTATUS(THIS.pgf_4c_1.Page4, "txt_4c_Qt_Selec", 5)
3110:                                 THIS.pgf_4c_1.Page4.txt_4c_Qt_Selec.Value = loc_nSumUtil
3111:                             ENDIF
3112:                         ENDIF
3113:                     ENDIF
3114:                 ENDIF
3115:             ENDIF
3116:         CATCH TO loc_oErro
3117:             MsgErro("Erro em P4ColC5Valid: " + loc_oErro.Message, "Erro")
3118:             loc_lResultado = .F.
3119:         ENDTRY
3120: 
3121:         RETURN loc_lResultado
3122:     ENDFUNC
3123: 
3124:     *--------------------------------------------------------------------------
3125:     * P4ColC5LostFocus - Avanca para proxima linha apos Enter em Col5 Page4
3126:     *--------------------------------------------------------------------------
3127:     PROCEDURE P4ColC5LostFocus(par_nKeyCode, par_nShiftAltCtrl)
3128:         TRY
3129:             IF LASTKEY() = 13
3130:                 KEYBOARD CHR(24)
3131:             ENDIF
3132:             IF PEMSTATUS(THIS.pgf_4c_1.Page4.grd_4c_GradeDisp.Column5, "Text1", 5)
3133:                 THIS.pgf_4c_1.Page4.grd_4c_GradeDisp.Column5.Text1.Refresh()
3134:             ENDIF
3135:         CATCH TO loc_oErro
3136:             MsgErro("Erro em P4ColC5LostFocus: " + loc_oErro.Message, "Erro")
3137:         ENDTRY
3138:     ENDPROC
3139: 
3140:     *--------------------------------------------------------------------------
3141:     * BtnVoltarPage4Click - Processa selecao de estoque e retorna para Page1
3142:     *--------------------------------------------------------------------------
3143:     PROCEDURE BtnVoltarPage4Click()
3144:         LOCAL loc_cCpros, loc_nUtil, loc_nQtdMin
3145: 
3146:         TRY
3147:             IF USED("TmpDisp")
3148:                 loc_cCpros = ""
3149:                 IF USED("TmpFinalg") AND !EOF("TmpFinalg")
3150:                     loc_cCpros = ALLTRIM(TmpFinalg.Cpros)
3151:                 ENDIF
3152: 
3153:                 SELECT TmpDisp
3154:                 SCAN
3155:                     loc_nUtil   = TmpDisp.Utilizar
3156:                     loc_cCpros  = ALLTRIM(TmpDisp.Grupos)
3157: 
3158:                     IF USED("TmpFinalg")
3159:                         SELECT TmpFinalg
3160:                         LOCATE FOR ALLTRIM(TmpFinalg.Cpros) = m.loc_cCpros
3161:                         IF FOUND()
3162:                             REPLACE TmpFinalg.Produzir   WITH TmpFinalg.Produzir - loc_nUtil
3163:                             REPLACE TmpFinalg.Estoque    WITH TmpFinalg.Estoque  + loc_nUtil
3164: 
3165:                             loc_nQtdMin = 0
3166:                             IF TYPE("TmpFinalg.QtdMins") != "U"
3167:                                 loc_nQtdMin = TmpFinalg.QtdMins
3168:                             ENDIF
3169:                             IF loc_nQtdMin > 0
3170:                                 REPLACE TmpFinalg.Produzir2 WITH IIF(TmpFinalg.Produzir >= loc_nQtdMin, ;
3171:                                     TmpFinalg.Produzir, 0)
3172:                             ELSE
3173:                                 REPLACE TmpFinalg.Produzir2 WITH TmpFinalg.Produzir
3174:                             ENDIF
3175:                         ENDIF
3176:                     ENDIF
3177: 
3178:                     IF USED("TmpSaldo")
3179:                         SELECT TmpSaldo
3180:                         LOCATE FOR ALLTRIM(TmpSaldo.Grupos) = m.loc_cCpros
3181:                         IF FOUND()
3182:                             REPLACE TmpSaldo.Disps WITH TmpSaldo.Disps - loc_nUtil
3183:                         ENDIF

*-- Linhas 3217 a 3332:
3217:     *--------------------------------------------------------------------------
3218:     * P5ColGotFocusToCol5 - Redireciona foco para coluna Utilizar (Col5) Page5
3219:     *--------------------------------------------------------------------------
3220:     PROCEDURE P5ColGotFocusToCol5()
3221:         TRY
3222:             IF PEMSTATUS(THIS.pgf_4c_1.Page5, "grd_4c_GradeDisp", 5)
3223:                 THIS.pgf_4c_1.Page5.grd_4c_GradeDisp.Column5.SetFocus()
3224:             ENDIF
3225:         CATCH TO loc_oErro
3226:             MsgErro("Erro em P5ColGotFocusToCol5: " + loc_oErro.Message, "Erro")
3227:         ENDTRY
3228:     ENDPROC
3229: 
3230:     *--------------------------------------------------------------------------
3231:     * P5ColC5Valid - Valida quantidade Utilizar na selecao por tamanho (Page5)
3232:     *--------------------------------------------------------------------------
3233:     FUNCTION P5ColC5Valid()
3234:         LOCAL loc_lResultado, loc_nUtil, loc_nSumUtil, loc_nOldRecno
3235:         LOCAL loc_nPSaldo
3236: 
3237:         loc_lResultado = .T.
3238: 
3239:         TRY
3240:             IF USED("TmpDisp") AND !EOF("TmpDisp")
3241:                 loc_nUtil = THIS.pgf_4c_1.Page5.grd_4c_GradeDisp.Column5.Text1.Value
3242: 
3243:                 IF loc_nUtil < 0
3244:                     MsgAviso("Quantidade n" + CHR(227) + "o pode ser negativa.")
3245:                     THIS.pgf_4c_1.Page5.grd_4c_GradeDisp.Column5.Text1.Value = 0
3246:                     loc_lResultado = .F.
3247:                 ELSE
3248:                     IF loc_nUtil > TmpDisp.Disps
3249:                         MsgAviso("Quantidade excede o dispon?vel.")
3250:                         THIS.pgf_4c_1.Page5.grd_4c_GradeDisp.Column5.Text1.Value = TmpDisp.Disps
3251:                         loc_lResultado = .F.
3252:                     ELSE
3253:                         loc_nPSaldo = 0
3254:                         IF PEMSTATUS(THIS.pgf_4c_1.Page5, "txt_4c_Qt_pedida", 5)
3255:                             loc_nPSaldo = THIS.pgf_4c_1.Page5.txt_4c_Qt_pedida.Value
3256:                         ENDIF
3257: 
3258:                         loc_nOldRecno = IIF(RECCOUNT("TmpDisp") > 0, RECNO("TmpDisp"), 0)
3259:                         SELECT TmpDisp
3260:                         loc_nSumUtil = 0
3261:                         SUM Utilizar TO loc_nSumUtil
3262:                         IF loc_nOldRecno > 0 AND loc_nOldRecno <= RECCOUNT("TmpDisp")
3263:                             GO loc_nOldRecno
3264:                         ENDIF
3265: 
3266:                         loc_nSumUtil = loc_nSumUtil - TmpDisp.Utilizar + loc_nUtil
3267: 
3268:                         IF loc_nSumUtil > loc_nPSaldo
3269:                             MsgAviso("Total selecionado excede o pedido.")
3270:                             THIS.pgf_4c_1.Page5.grd_4c_GradeDisp.Column5.Text1.Value = 0
3271:                             loc_lResultado = .F.
3272:                         ELSE
3273:                             REPLACE TmpDisp.Utilizar WITH loc_nUtil
3274:                             IF PEMSTATUS(THIS.pgf_4c_1.Page5, "txt_4c_Qt_Selec", 5)
3275:                                 THIS.pgf_4c_1.Page5.txt_4c_Qt_Selec.Value = loc_nSumUtil
3276:                             ENDIF
3277:                         ENDIF
3278:                     ENDIF
3279:                 ENDIF
3280:             ENDIF
3281:         CATCH TO loc_oErro
3282:             MsgErro("Erro em P5ColC5Valid: " + loc_oErro.Message, "Erro")
3283:             loc_lResultado = .F.
3284:         ENDTRY
3285: 
3286:         RETURN loc_lResultado
3287:     ENDFUNC
3288: 
3289:     *--------------------------------------------------------------------------
3290:     * BtnVoltarPage5Click - Processa selecao por tamanho e retorna para Page1
3291:     *--------------------------------------------------------------------------
3292:     PROCEDURE BtnVoltarPage5Click()
3293:         LOCAL loc_cGrupo, loc_nUtil
3294: 
3295:         TRY
3296:             IF USED("TmpDisp")
3297:                 SELECT TmpDisp
3298:                 SCAN
3299:                     loc_nUtil  = TmpDisp.Utilizar
3300:                     loc_cGrupo = ALLTRIM(TmpDisp.Cpros)
3301: 
3302:                     IF USED("TmpFinalg")
3303:                         SELECT TmpFinalg
3304:                         LOCATE FOR ALLTRIM(TmpFinalg.Cpros) = m.loc_cGrupo
3305:                         IF FOUND()
3306:                             REPLACE TmpFinalg.Produzir WITH TmpFinalg.Produzir - loc_nUtil
3307:                             REPLACE TmpFinalg.Estoque  WITH TmpFinalg.Estoque  + loc_nUtil
3308:                         ENDIF
3309:                     ENDIF
3310: 
3311:                     IF USED("TmpSaldo")
3312:                         SELECT TmpSaldo
3313:                         LOCATE FOR ALLTRIM(TmpSaldo.Grupos) = m.loc_cGrupo
3314:                         IF FOUND()
3315:                             REPLACE TmpSaldo.Disps WITH TmpSaldo.Disps - loc_nUtil
3316:                         ENDIF
3317:                     ENDIF
3318:                 ENDSCAN
3319: 
3320:                 USE IN TmpDisp
3321:             ENDIF
3322: 
3323:             THIS.AlternarPagina(1)
3324:             THIS.AtualizarTotaisPage1()
3325: 
3326:             IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5)
3327:                 THIS.pgf_4c_1.Page1.grd_4c_GradeItens.Refresh()
3328:             ENDIF
3329:         CATCH TO loc_oErro
3330:             MsgErro("Erro em BtnVoltarPage5Click: " + loc_oErro.Message, "Erro")
3331:         ENDTRY
3332:     ENDPROC

*-- Linhas 3460 a 3543:
3460:     *--------------------------------------------------------------------------
3461:     * P6ColC5LostFocus - Avanca para proxima linha apos Enter em Col5 Page6
3462:     *--------------------------------------------------------------------------
3463:     PROCEDURE P6ColC5LostFocus(par_nKeyCode, par_nShiftAltCtrl)
3464:         TRY
3465:             IF LASTKEY() = 13
3466:                 KEYBOARD CHR(24)
3467:             ENDIF
3468:             IF PEMSTATUS(THIS.pgf_4c_1.Page6.grd_4c_GradePedra.Column5, "Text1", 5)
3469:                 THIS.pgf_4c_1.Page6.grd_4c_GradePedra.Column5.Text1.Refresh()
3470:             ENDIF
3471:         CATCH TO loc_oErro
3472:             MsgErro("Erro em P6ColC5LostFocus: " + loc_oErro.Message, "Erro")
3473:         ENDTRY
3474:     ENDPROC
3475: 
3476:     *--------------------------------------------------------------------------
3477:     * P6ColC1KeyPress - F4 abre picker de produto (Col1 Cpros Page6)
3478:     *--------------------------------------------------------------------------
3479:     FUNCTION P6ColC1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
3480:         LOCAL loc_cFiltro
3481: 
3482:         IF par_nKeyCode = 115  && F4
3483:             loc_cFiltro = ""
3484:             IF PEMSTATUS(THIS.pgf_4c_1.Page6.grd_4c_GradePedra.Column1.Text1, "Value", 5)
3485:                 loc_cFiltro = ALLTRIM(THIS.pgf_4c_1.Page6.grd_4c_GradePedra.Column1.Text1.Value)
3486:             ENDIF
3487:             THIS.AbrirLookupProdutoP6Col1(loc_cFiltro)
3488:             RETURN 0
3489:         ENDIF
3490: 
3491:         RETURN par_nKeyCode
3492:     ENDFUNC
3493: 
3494:     *--------------------------------------------------------------------------
3495:     * AbrirLookupProdutoP6Col1 - Picker FormBuscaAuxiliar para Cpros (Page6)
3496:     *--------------------------------------------------------------------------
3497:     PROCEDURE AbrirLookupProdutoP6Col1(par_cFiltro)
3498:         LOCAL loc_cFiltro, loc_cCpros, loc_nRes, loc_cSQL
3499: 
3500:         loc_cFiltro = IIF(TYPE("par_cFiltro") = "C", ALLTRIM(par_cFiltro), "")
3501: 
3502:         TRY
3503:             DO FormBuscaAuxiliar WITH gnConnHandle, "SigCdPro", "crLkpPro6C1", "CPros", ;
3504:                 loc_cFiltro, "Produto", 900, "CPros", "DPros"
3505: 
3506:             IF USED("crLkpPro6C1") AND RECCOUNT("crLkpPro6C1") > 0
3507:                 loc_cCpros = ALLTRIM(crLkpPro6C1.CPros)
3508:                 USE IN crLkpPro6C1
3509: 
3510:                 IF USED("SelPedra") AND !EOF("SelPedra") AND !EMPTY(loc_cCpros)
3511:                     loc_cSQL = "SELECT TOP 1 DPros, Cunis FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCpros)
3512:                     loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "crLkpPro6C1Det")
3513: 
3514:                     IF loc_nRes > 0 AND USED("crLkpPro6C1Det") AND !EOF("crLkpPro6C1Det")
3515:                         REPLACE SelPedra.Cpros WITH loc_cCpros
3516:                         REPLACE SelPedra.Dpros WITH ALLTRIM(crLkpPro6C1Det.DPros)
3517:                         REPLACE SelPedra.Cunis WITH ALLTRIM(crLkpPro6C1Det.Cunis)
3518:                         USE IN crLkpPro6C1Det
3519:                     ELSE
3520:                         IF USED("crLkpPro6C1Det")
3521:                             USE IN crLkpPro6C1Det
3522:                         ENDIF
3523:                     ENDIF
3524: 
3525:                     IF PEMSTATUS(THIS.pgf_4c_1.Page6, "grd_4c_GradePedra", 5)
3526:                         THIS.pgf_4c_1.Page6.grd_4c_GradePedra.Refresh()
3527:                     ENDIF
3528:                 ENDIF
3529:             ELSE
3530:                 IF USED("crLkpPro6C1")
3531:                     USE IN crLkpPro6C1
3532:                 ENDIF
3533:             ENDIF
3534:         CATCH TO loc_oErro
3535:             MsgErro("Erro ao abrir lookup de produto: " + loc_oErro.Message, "Erro")
3536:         ENDTRY
3537:     ENDPROC
3538: 
3539:     *--------------------------------------------------------------------------
3540:     * P6ColC5KeyPress - F4 abre picker de produto substituto (Col5 Cpro2s Page6)
3541:     *--------------------------------------------------------------------------
3542:     FUNCTION P6ColC5KeyPress(par_nKeyCode, par_nShiftAltCtrl)
3543:         LOCAL loc_cFiltro

*-- Linhas 3555 a 3813:
3555:     ENDFUNC
3556: 
3557:     *--------------------------------------------------------------------------
3558:     * AbrirLookupProdutoP6Col5 - Picker FormBuscaAuxiliar para Cpro2s (Page6)
3559:     *--------------------------------------------------------------------------
3560:     PROCEDURE AbrirLookupProdutoP6Col5(par_cFiltro)
3561:         LOCAL loc_cFiltro, loc_cCpro2
3562: 
3563:         loc_cFiltro = IIF(TYPE("par_cFiltro") = "C", ALLTRIM(par_cFiltro), "")
3564: 
3565:         TRY
3566:             DO FormBuscaAuxiliar WITH gnConnHandle, "SigCdPro", "crLkpPro6C5", "CPros", ;
3567:                 loc_cFiltro, "Produto Substituto", 900, "CPros", "DPros"
3568: 
3569:             IF USED("crLkpPro6C5") AND RECCOUNT("crLkpPro6C5") > 0
3570:                 loc_cCpro2 = ALLTRIM(crLkpPro6C5.CPros)
3571:                 USE IN crLkpPro6C5
3572: 
3573:                 IF USED("SelPedra") AND !EOF("SelPedra") AND !EMPTY(loc_cCpro2)
3574:                     REPLACE SelPedra.Cpro2s WITH loc_cCpro2
3575: 
3576:                     IF PEMSTATUS(THIS.pgf_4c_1.Page6, "grd_4c_GradePedra", 5)
3577:                         THIS.pgf_4c_1.Page6.grd_4c_GradePedra.Refresh()
3578:                     ENDIF
3579:                 ENDIF
3580:             ELSE
3581:                 IF USED("crLkpPro6C5")
3582:                     USE IN crLkpPro6C5
3583:                 ENDIF
3584:             ENDIF
3585:         CATCH TO loc_oErro
3586:             MsgErro("Erro ao abrir lookup de produto substituto: " + loc_oErro.Message, "Erro")
3587:         ENDTRY
3588:     ENDPROC
3589: 
3590:     *--------------------------------------------------------------------------
3591:     * BtnVoltarPage6Click - Retorna de Page6 (requisicao manual) para Page1
3592:     *--------------------------------------------------------------------------
3593:     PROCEDURE BtnVoltarPage6Click()
3594:         TRY
3595:             THIS.AlternarPagina(1)
3596:             IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5)
3597:                 THIS.pgf_4c_1.Page1.grd_4c_GradeItens.SetFocus()
3598:             ENDIF
3599:         CATCH TO loc_oErro
3600:             MsgErro("Erro em BtnVoltarPage6Click: " + loc_oErro.Message, "Erro")
3601:         ENDTRY
3602:     ENDPROC
3603: 
3604:     *--------------------------------------------------------------------------
3605:     * MostrarAguarde - Exibe overlay de processamento com mensagem
3606:     *--------------------------------------------------------------------------
3607:     PROCEDURE MostrarAguarde(par_cMensagem)
3608: 
3609:         IF PEMSTATUS(THIS, "cnt_4c_Aguarde", 5)
3610:             IF TYPE("par_cMensagem") = "C" AND !EMPTY(par_cMensagem)
3611:                 THIS.cnt_4c_Aguarde.lbl_4c_AguardeDet.Caption = par_cMensagem
3612:             ENDIF
3613:             THIS.cnt_4c_Aguarde.Visible = .T.
3614:             THIS.cnt_4c_Aguarde.ZOrder(0)
3615:         ENDIF
3616:         THIS.this_lProcessando = .T.
3617:         DOEVENTS
3618:     ENDPROC
3619: 
3620:     *--------------------------------------------------------------------------
3621:     * OcultarAguarde - Oculta overlay de processamento
3622:     *--------------------------------------------------------------------------
3623:     PROCEDURE OcultarAguarde()
3624: 
3625:         IF PEMSTATUS(THIS, "cnt_4c_Aguarde", 5)
3626:             THIS.cnt_4c_Aguarde.lbl_4c_AguardeDet.Caption = ""
3627:             THIS.cnt_4c_Aguarde.Visible = .F.
3628:         ENDIF
3629:         THIS.this_lProcessando = .F.
3630:         DOEVENTS
3631:     ENDPROC
3632: 
3633:     *--------------------------------------------------------------------------
3634:     * BtnIncluirClick - Form OPERACIONAL: incluir requisicao manual de material
3635:     * (equivalente ao botao Pedras do legado, que abre Page6 para adicionar
3636:     *  itens da requisicao vinculados ao produto corrente da grade)
3637:     *--------------------------------------------------------------------------
3638:     PROCEDURE BtnIncluirClick()
3639: 
3640:         TRY
3641:             IF !USED("TmpFinalg") OR EOF("TmpFinalg")
3642:                 MsgAviso("Selecione uma refer" + CHR(234) + "ncia na grade antes de incluir requisi" + ;
3643:                     CHR(231) + CHR(245) + "es de material.")
3644:                 IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5)
3645:                     THIS.pgf_4c_1.Page1.grd_4c_GradeItens.SetFocus
3646:                 ENDIF
3647:             ELSE
3648:                 THIS.BtnPedrasClick()
3649:             ENDIF
3650:         CATCH TO loc_oErro
3651:             MsgErro("Erro ao incluir requisi" + CHR(231) + CHR(227) + "o: " + ;
3652:                 loc_oErro.Message, "Erro")
3653:         ENDTRY
3654:     ENDPROC
3655: 
3656:     *--------------------------------------------------------------------------
3657:     * BtnAlterarClick - Form OPERACIONAL: alterar quantidade a produzir para
3658:     * estoque do item selecionado (exige autorizacao por senha, replica o
3659:     * comportamento do botao Alteraqtd do legado)
3660:     *--------------------------------------------------------------------------
3661:     PROCEDURE BtnAlterarClick()
3662: 
3663:         TRY
3664:             IF !USED("TmpFinalg") OR EOF("TmpFinalg")
3665:                 MsgAviso("Selecione uma refer" + CHR(234) + "ncia na grade antes de alterar quantidade.")
3666:                 IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5)
3667:                     THIS.pgf_4c_1.Page1.grd_4c_GradeItens.SetFocus
3668:                 ENDIF
3669:             ELSE
3670:                 THIS.BtnAlteraqtdClick()
3671:             ENDIF
3672:         CATCH TO loc_oErro
3673:             MsgErro("Erro ao alterar quantidade: " + loc_oErro.Message, "Erro")
3674:         ENDTRY
3675:     ENDPROC
3676: 
3677:     *--------------------------------------------------------------------------
3678:     * BtnVisualizarClick - Form OPERACIONAL: exibir foto do produto corrente
3679:     * (equivalente ao clique na Image ImgFigJpg do legado)
3680:     *--------------------------------------------------------------------------
3681:     PROCEDURE BtnVisualizarClick()
3682: 
3683:         TRY
3684:             IF !USED("TmpFinalg") OR EOF("TmpFinalg")
3685:                 MsgAviso("Selecione uma refer" + CHR(234) + "ncia na grade antes de visualizar a foto.")
3686:                 IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5)
3687:                     THIS.pgf_4c_1.Page1.grd_4c_GradeItens.SetFocus
3688:                 ENDIF
3689:             ELSE
3690:                 THIS.CarregarFotoProduto(ALLTRIM(TmpFinalg.Cpros))
3691:             ENDIF
3692:         CATCH TO loc_oErro
3693:             MsgErro("Erro ao visualizar foto: " + loc_oErro.Message, "Erro")
3694:         ENDTRY
3695:     ENDPROC
3696: 
3697:     *--------------------------------------------------------------------------
3698:     * BtnExcluirClick - Form OPERACIONAL: zerar a selecao de producao/estoque
3699:     * do item corrente da grade (reverte producao para o saldo total, limpa
3700:     * marcacoes de estoque/producao selecionadas). Espelha o rollback feito
3701:     * pelo botao Cancelar da Page2 do legado quando aplicado ao registro atual.
3702:     *--------------------------------------------------------------------------
3703:     PROCEDURE BtnExcluirClick()
3704: 
3705:         LOCAL loc_nSaldoTotal, loc_cCpro, loc_cCor, loc_cTam
3706: 
3707:         TRY
3708:             IF !USED("TmpFinalg") OR EOF("TmpFinalg")
3709:                 MsgAviso("Selecione uma refer" + CHR(234) + "ncia na grade antes de zerar a sele" + ;
3710:                     CHR(231) + CHR(227) + "o.")
3711:                 IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5)
3712:                     THIS.pgf_4c_1.Page1.grd_4c_GradeItens.SetFocus
3713:                 ENDIF
3714:             ELSE
3715:                 IF !MsgConfirma("Zerar sele" + CHR(231) + CHR(227) + "o de estoque/produ" + ;
3716:                     CHR(231) + CHR(227) + "o da refer" + CHR(234) + "ncia corrente?")
3717:                     RETURN
3718:                 ENDIF
3719: 
3720:                 loc_cCpro     = ALLTRIM(TmpFinalg.Cpros)
3721:                 loc_cCor      = ALLTRIM(TmpFinalg.CodCors)
3722:                 loc_cTam      = ALLTRIM(TmpFinalg.CodTams)
3723:                 loc_nSaldoTotal = TmpFinalg.Saldo
3724: 
3725:                 SELECT TmpFinalg
3726:                 REPLACE Estoque WITH 0, Fabrs WITH 0, Produzir WITH loc_nSaldoTotal, ;
3727:                     Produzir2 WITH 0, UsuLibs WITH " " IN TmpFinalg
3728: 
3729:                 IF USED("TmpSaldo")
3730:                     IF SEEK(loc_cCpro + loc_cCor + loc_cTam, "TmpSaldo")
3731:                         REPLACE TmpSaldo.Disps WITH TmpSaldo.Saldo IN TmpSaldo
3732:                     ENDIF
3733:                 ENDIF
3734: 
3735:                 THIS.AtualizarTotaisPage1()
3736:                 IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5)
3737:                     THIS.pgf_4c_1.Page1.grd_4c_GradeItens.Refresh
3738:                 ENDIF
3739:             ENDIF
3740:         CATCH TO loc_oErro
3741:             MsgErro("Erro ao zerar sele" + CHR(231) + CHR(227) + "o: " + ;
3742:                 loc_oErro.Message, "Erro")
3743:         ENDTRY
3744:     ENDPROC
3745: 
3746:     *--------------------------------------------------------------------------
3747:     * CarregarLista - Vincula GradeItens da Page1 ao cursor TmpFinalg
3748:     *--------------------------------------------------------------------------
3749:     PROCEDURE CarregarLista()
3750:         TRY
3751:             IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5) AND USED("TmpFinalg")
3752:                 WITH THIS.pgf_4c_1.Page1.grd_4c_GradeItens
3753:                     .ColumnCount  = 10
3754:                     .RecordSource = "TmpFinalg"
3755:                 ENDWITH
3756:             ENDIF
3757:             THIS.AtualizarTotaisPage1()
3758:         CATCH TO loc_oErro
3759:             MsgErro("Erro ao carregar lista: " + loc_oErro.Message, "Erro")
3760:         ENDTRY
3761:     ENDPROC
3762: 
3763:     *--------------------------------------------------------------------------
3764:     * AjustarBotoesPorModo - Delega para AjustarVisibilidadeBotoes
3765:     *--------------------------------------------------------------------------
3766:     PROCEDURE AjustarBotoesPorModo()
3767:         THIS.AjustarVisibilidadeBotoes()
3768:     ENDPROC
3769: 
3770:     *--------------------------------------------------------------------------
3771:     * FormParaBO - Sincroniza totais dos cursores de producao para o BO
3772:     *--------------------------------------------------------------------------
3773:     PROCEDURE FormParaBO()
3774:         LOCAL loc_nSal, loc_nEst, loc_nPrz, loc_nPrc, loc_nPrze
3775:         LOCAL loc_nSal2, loc_nEst2, loc_nPrz2, loc_nPrc2
3776:         LOCAL loc_nRecno
3777: 
3778:         TRY
3779:             IF USED("TmpFinalg") AND RECCOUNT("TmpFinalg") > 0
3780:                 loc_nRecno = IIF(!BOF("TmpFinalg") AND !EOF("TmpFinalg"), RECNO("TmpFinalg"), 0)
3781: 
3782:                 loc_nSal   = 0
3783:                 loc_nEst   = 0
3784:                 loc_nPrz   = 0
3785:                 loc_nPrc   = 0
3786:                 loc_nPrze  = 0
3787: 
3788:                 SELECT TmpFinalg
3789:                 SUM Saldo, Estoque, Produzir, Fabrs, Produzir2 ;
3790:                     TO loc_nSal, loc_nEst, loc_nPrz, loc_nPrc, loc_nPrze
3791: 
3792:                 IF loc_nRecno > 0 AND RECCOUNT("TmpFinalg") >= loc_nRecno
3793:                     GO loc_nRecno IN TmpFinalg
3794:                 ENDIF
3795: 
3796:                 THIS.this_oBusinessObject.this_nTotQtd  = loc_nSal
3797:                 THIS.this_oBusinessObject.this_nTotEst  = loc_nEst
3798:                 THIS.this_oBusinessObject.this_nTotPrz  = loc_nPrz
3799:                 THIS.this_oBusinessObject.this_nTotPrdc = loc_nPrc
3800:                 THIS.this_oBusinessObject.this_nTotPrze = loc_nPrze
3801:             ENDIF
3802: 
3803:             IF USED("TmpFinal") AND RECCOUNT("TmpFinal") > 0
3804:                 loc_nRecno = IIF(!BOF("TmpFinal") AND !EOF("TmpFinal"), RECNO("TmpFinal"), 0)
3805: 
3806:                 loc_nSal2  = 0
3807:                 loc_nEst2  = 0
3808:                 loc_nPrz2  = 0
3809:                 loc_nPrc2  = 0
3810: 
3811:                 SELECT TmpFinal
3812:                 SUM Saldo, Estoque, Produzir, Fabrs ;
3813:                     TO loc_nSal2, loc_nEst2, loc_nPrz2, loc_nPrc2

*-- Linhas 3829 a 3954:
3829:     *--------------------------------------------------------------------------
3830:     * BOParaForm - Atualiza totais da UI a partir do estado do BO/cursores
3831:     *--------------------------------------------------------------------------
3832:     PROCEDURE BOParaForm()
3833:         TRY
3834:             THIS.AtualizarTotaisPage1()
3835:             THIS.AtualizarTotaisPage2()
3836:         CATCH TO loc_oErro
3837:             MsgErro("Erro em BOParaForm: " + loc_oErro.Message, "Erro")
3838:         ENDTRY
3839:     ENDPROC
3840: 
3841:     *--------------------------------------------------------------------------
3842:     * HabilitarCampos - Habilita/desabilita colunas editaveis conforme estado
3843:     *--------------------------------------------------------------------------
3844:     PROCEDURE HabilitarCampos()
3845:         LOCAL loc_lBloquear
3846: 
3847:         TRY
3848:             loc_lBloquear = THIS.this_lProcessando
3849: 
3850:             IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5)
3851:                 WITH THIS.pgf_4c_1.Page1.grd_4c_GradeItens
3852:                     IF PEMSTATUS(.Column7, "ReadOnly", 5)
3853:                         .Column7.ReadOnly = loc_lBloquear
3854:                     ENDIF
3855:                     IF PEMSTATUS(.Column8, "ReadOnly", 5)
3856:                         .Column8.ReadOnly = loc_lBloquear
3857:                     ENDIF
3858:                     IF PEMSTATUS(.Column10, "ReadOnly", 5)
3859:                         .Column10.ReadOnly = loc_lBloquear
3860:                     ENDIF
3861:                 ENDWITH
3862:             ENDIF
3863: 
3864:             IF PEMSTATUS(THIS.pgf_4c_1.Page1, "cmd_4c_Processar", 5)
3865:                 THIS.pgf_4c_1.Page1.cmd_4c_Processar.Enabled = !loc_lBloquear
3866:             ENDIF
3867:         CATCH TO loc_oErro
3868:             MsgErro("Erro em HabilitarCampos: " + loc_oErro.Message, "Erro")
3869:         ENDTRY
3870:     ENDPROC
3871: 
3872:     *--------------------------------------------------------------------------
3873:     * LimparCampos - Zera os campos de totalizacao das paginas 1 e 2
3874:     *--------------------------------------------------------------------------
3875:     PROCEDURE LimparCampos()
3876:         TRY
3877:             IF PEMSTATUS(THIS.pgf_4c_1.Page1, "txt_4c_Tot_Qtd", 5)
3878:                 WITH THIS.pgf_4c_1.Page1
3879:                     .txt_4c_Tot_Qtd.Value  = 0
3880:                     .txt_4c_Tot_Est.Value  = 0
3881:                     .txt_4c_Tot_Prz.Value  = 0
3882:                     .txt_4c_Tot_prdc.Value = 0
3883:                     .txt_4c_Tot_prze.Value = 0
3884:                 ENDWITH
3885:             ENDIF
3886: 
3887:             IF PEMSTATUS(THIS.pgf_4c_1.Page2, "txt_4c_TotQtdP2", 5)
3888:                 WITH THIS.pgf_4c_1.Page2
3889:                     .txt_4c_TotQtdP2.Value = 0
3890:                     .txt_4c_TotEstP2.Value = 0
3891:                     .txt_4c_TotPrzP2.Value = 0
3892:                     .txt_4c_TotPrcP2.Value = 0
3893:                 ENDWITH
3894:             ENDIF
3895:         CATCH TO loc_oErro
3896:             MsgErro("Erro em LimparCampos: " + loc_oErro.Message, "Erro")
3897:         ENDTRY
3898:     ENDPROC
3899: 
3900:     *--------------------------------------------------------------------------
3901:     * BtnBuscarClick - Atualiza a exibicao da previa (recarrega grade e totais)
3902:     *--------------------------------------------------------------------------
3903:     PROCEDURE BtnBuscarClick()
3904:         TRY
3905:             THIS.CarregarLista()
3906:             IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5)
3907:                 THIS.pgf_4c_1.Page1.grd_4c_GradeItens.Refresh()
3908:             ENDIF
3909:         CATCH TO loc_oErro
3910:             MsgErro("Erro ao atualizar visualiza" + CHR(231) + CHR(227) + "o: " + ;
3911:                 loc_oErro.Message, "Erro")
3912:         ENDTRY
3913:     ENDPROC
3914: 
3915:     *--------------------------------------------------------------------------
3916:     * BtnSalvarClick - Confirma e processa a globalizacao (alias de Processar)
3917:     *--------------------------------------------------------------------------
3918:     PROCEDURE BtnSalvarClick()
3919:         THIS.BtnProcessarClick()
3920:     ENDPROC
3921: 
3922:     *--------------------------------------------------------------------------
3923:     * BtnCancelarClick - Encerra sem processar (alias de Encerrar)
3924:     *--------------------------------------------------------------------------
3925:     PROCEDURE BtnCancelarClick()
3926:         THIS.BtnEncerrarClick()
3927:     ENDPROC
3928: 
3929:     *--------------------------------------------------------------------------
3930:     * Destroy - Libera recursos ao fechar
3931:     *--------------------------------------------------------------------------
3932:     PROCEDURE Destroy()
3933: 
3934:         TRY
3935:             *-- Fecha cursor auxiliar criado em InicializarForm
3936:             IF USED("TmpSaldU")
3937:                 USE IN TmpSaldU
3938:             ENDIF
3939: 
3940:             *-- Reabilita form pai (foi desabilitado ao abrir este form filho)
3941:             IF !ISNULL(THIS.this_oParentForm) AND ISOBJECT(THIS.this_oParentForm)
3942:                 THIS.this_oParentForm.Enabled = .T.
3943:             ENDIF
3944: 
3945:             *-- Libera referencias
3946:             THIS.this_oParentForm = .NULL.
3947:         CATCH TO loc_oErro
3948:             MsgErro("Erro ao encerrar FormSigPrGlx: " + loc_oErro.Message, "Erro")
3949:         ENDTRY
3950: 
3951:         DODEFAULT()
3952:     ENDPROC
3953: 
3954: ENDDEFINE


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

