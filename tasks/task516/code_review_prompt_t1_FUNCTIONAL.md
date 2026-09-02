# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (17)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BINDEVENT-PARAMS] Handler 'ValidarContaCodigo' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarContaCodigo(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarContaDescricao' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarContaDescricao(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'GradMuniUFLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE GradMuniUFLostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'GradMuniMunLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE GradMuniMunLostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'GradProdCodLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE GradProdCodLostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'GradProdDescLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE GradProdDescLostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [GRID-HEADER] Header Caption 'Conta' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: UF, Município, Código, Descrição. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Nome da Conta' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: UF, Município, Código, Descrição. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Data' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: UF, Município, Código, Descrição. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Conta' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: UF, Município, Código, Descrição. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Nome da Conta' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: UF, Município, Código, Descrição. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Data' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: UF, Município, Código, Descrição. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formrst.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1996 linhas total):

*-- Linhas 23 a 159:
23:     this_cModoAtual      = "LISTA"
24: 
25:     *===========================================================================
26:     * Init - Apenas DODEFAULT (FormBase.Init chama InicializarForm)
27:     * REGRA CRITICA: NAO chamar THIS.InicializarForm() aqui - evita chamada dupla
28:     *===========================================================================
29:     PROCEDURE Init()
30:         RETURN DODEFAULT()
31:     ENDPROC
32: 
33:     *===========================================================================
34:     * InicializarForm - Configura estrutura completa do formulario
35:     * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
36:     *===========================================================================
37:     PROTECTED PROCEDURE InicializarForm()
38:         LOCAL loc_lSucesso
39:         loc_lSucesso = .F.
40: 
41:         TRY
42:             THIS.this_oBusinessObject = CREATEOBJECT("rstBO")
43: 
44:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
45:                 MostrarErro("Erro ao criar rstBO" + CHR(13) + ;
46:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
47:                     "Formrst.InicializarForm")
48:             ELSE
49:                 THIS.ConfigurarPageFrame()
50:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
51:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
52:                 THIS.pgf_4c_Paginas.Visible   = .T.
53:                 THIS.pgf_4c_Paginas.ActivePage = 1
54:                 THIS.this_cModoAtual = "LISTA"
55: 
56:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
57:                     THIS.CarregarLista()
58:                 ENDIF
59: 
60:                 loc_lSucesso = .T.
61:             ENDIF
62: 
63:         CATCH TO loException
64:             MostrarErro("Erro ao inicializar Formrst:" + CHR(13) + ;
65:                 loException.Message + CHR(13) + ;
66:                 "Linha: " + TRANSFORM(loException.LineNo), ;
67:                 "Formrst.InicializarForm")
68:         ENDTRY
69: 
70:         RETURN loc_lSucesso
71:     ENDPROC
72: 
73:     *===========================================================================
74:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
75:     * PageFrame.Top = -29 para esconder abas
76:     * Todos os controles internos compensam +29 no Top
77:     *===========================================================================
78:     PROTECTED PROCEDURE ConfigurarPageFrame()
79:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
80: 
81:         WITH THIS.pgf_4c_Paginas
82:             .PageCount = 2
83:             .Top       = -29
84:             .Left      = 0
85:             .Width     = THIS.Width
86:             .Height    = THIS.Height + 29
87:             .Tabs      = .F.
88:             .Visible   = .T.
89: 
90:             .Page1.Caption   = "Lista"
91:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
92:             .Page1.BackColor = RGB(255, 255, 255)
93: 
94:             .Page2.Caption   = "Dados"
95:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
96:             .Page2.BackColor = RGB(255, 255, 255)
97:         ENDWITH
98: 
99:         THIS.ConfigurarPaginaLista()
100:         THIS.ConfigurarPaginaDados()
101:     ENDPROC
102: 
103:     *===========================================================================
104:     * ConfigurarPaginaLista - Configura Page1 (Lista) com Grid e botoes CRUD
105:     * Cabecalho, cnt_4c_Botoes (5 botoes), cnt_4c_Saida (Encerrar), grd_4c_Lista
106:     *===========================================================================
107:     PROTECTED PROCEDURE ConfigurarPaginaLista()
108:         LOCAL loc_oPagina, loc_oGrid
109:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
110: 
111:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
112:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
113: 
114:         *-- Container Cabecalho escuro com titulo (cntSombra no legado)
115:         *-- Top original=2; compensacao PageFrame +29 -> Top=31
116:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
117:         WITH loc_oPagina.cnt_4c_Cabecalho
118:             .Top         = 31
119:             .Left        = 0
120:             .Width       = THIS.Width
121:             .Height      = 80
122:             .BackColor   = RGB(100, 100, 100)
123:             .BorderWidth = 0
124:             .Visible     = .T.
125:         ENDWITH
126: 
127:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
128:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
129:             .Caption   = THIS.Caption
130:             .Top       = 15
131:             .Left      = 10
132:             .Width     = 769
133:             .Height    = 40
134:             .FontName  = "Tahoma"
135:             .FontSize  = 16
136:             .FontBold  = .T.
137:             .ForeColor = RGB(0, 0, 0)
138:             .BackStyle = 0
139:             .AutoSize  = .F.
140:             .Visible   = .T.
141:         ENDWITH
142: 
143:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
144:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
145:             .Caption   = THIS.Caption
146:             .Top       = 18
147:             .Left      = 10
148:             .Width     = 769
149:             .Height    = 46
150:             .FontName  = "Tahoma"
151:             .FontSize  = 16
152:             .FontBold  = .T.
153:             .ForeColor = RGB(255, 255, 255)
154:             .BackStyle = 0
155:             .AutoSize  = .F.
156:             .Visible   = .T.
157:         ENDWITH
158: 
159:         *-- Container Botoes CRUD (Grupo_op no legado - lado direito)

*-- Linhas 192 a 373:
192:             .AutoSize        = .F.
193:             .Visible         = .T.
194:         ENDWITH
195:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
196: 
197:         *-- Botao Visualizar
198:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
199:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
200:             .Caption         = "Visualizar"
201:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
202:             .PicturePosition = 13
203:             .Top             = 5
204:             .Left            = 80
205:             .Width           = 75
206:             .Height          = 75
207:             .BackColor       = RGB(255, 255, 255)
208:             .ForeColor       = RGB(90, 90, 90)
209:             .FontName        = "Comic Sans MS"
210:             .FontBold        = .T.
211:             .FontItalic      = .T.
212:             .FontSize        = 8
213:             .Themes          = .F.
214:             .SpecialEffect   = 0
215:             .MousePointer    = 15
216:             .WordWrap        = .T.
217:             .AutoSize        = .F.
218:             .Visible         = .T.
219:         ENDWITH
220:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
221: 
222:         *-- Botao Alterar
223:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
224:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
225:             .Caption         = "Alterar"
226:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
227:             .PicturePosition = 13
228:             .Top             = 5
229:             .Left            = 155
230:             .Width           = 75
231:             .Height          = 75
232:             .BackColor       = RGB(255, 255, 255)
233:             .ForeColor       = RGB(90, 90, 90)
234:             .FontName        = "Comic Sans MS"
235:             .FontBold        = .T.
236:             .FontItalic      = .T.
237:             .FontSize        = 8
238:             .Themes          = .F.
239:             .SpecialEffect   = 0
240:             .MousePointer    = 15
241:             .WordWrap        = .T.
242:             .AutoSize        = .F.
243:             .Visible         = .T.
244:         ENDWITH
245:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
246: 
247:         *-- Botao Excluir
248:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
249:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
250:             .Caption         = "Excluir"
251:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
252:             .PicturePosition = 13
253:             .Top             = 5
254:             .Left            = 230
255:             .Width           = 75
256:             .Height          = 75
257:             .BackColor       = RGB(255, 255, 255)
258:             .ForeColor       = RGB(90, 90, 90)
259:             .FontName        = "Comic Sans MS"
260:             .FontBold        = .T.
261:             .FontItalic      = .T.
262:             .FontSize        = 8
263:             .Themes          = .F.
264:             .SpecialEffect   = 0
265:             .MousePointer    = 15
266:             .WordWrap        = .T.
267:             .AutoSize        = .F.
268:             .Visible         = .T.
269:         ENDWITH
270:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
271: 
272:         *-- Botao Buscar
273:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
274:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
275:             .Caption         = "Buscar"
276:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
277:             .PicturePosition = 13
278:             .Top             = 5
279:             .Left            = 305
280:             .Width           = 75
281:             .Height          = 75
282:             .BackColor       = RGB(255, 255, 255)
283:             .ForeColor       = RGB(90, 90, 90)
284:             .FontName        = "Comic Sans MS"
285:             .FontBold        = .T.
286:             .FontItalic      = .T.
287:             .FontSize        = 8
288:             .Themes          = .F.
289:             .SpecialEffect   = 0
290:             .MousePointer    = 15
291:             .WordWrap        = .T.
292:             .AutoSize        = .F.
293:             .Visible         = .T.
294:         ENDWITH
295:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
296: 
297:         *-- Container Saida (Grupo_Saida - padrao canonico: Left=917, Width=90)
298:         *-- Transparente sobre a Page - NAO subtrair da largura do cabecalho/grade
299:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
300:         WITH loc_oPagina.cnt_4c_Saida
301:             .Top         = 29
302:             .Left        = 917
303:             .Width       = 90
304:             .Height      = 85
305:             .BackStyle   = 0
306:             .BorderWidth = 0
307:             .Visible     = .T.
308:         ENDWITH
309: 
310:         *-- Botao Encerrar
311:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
312:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
313:             .Caption         = "Encerrar"
314:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
315:             .PicturePosition = 13
316:             .Top             = 5
317:             .Left            = 5
318:             .Width           = 75
319:             .Height          = 75
320:             .BackColor       = RGB(255, 255, 255)
321:             .ForeColor       = RGB(90, 90, 90)
322:             .FontName        = "Comic Sans MS"
323:             .FontBold        = .T.
324:             .FontItalic      = .T.
325:             .FontSize        = 8
326:             .Themes          = .F.
327:             .SpecialEffect   = 0
328:             .MousePointer    = 15
329:             .WordWrap        = .T.
330:             .AutoSize        = .F.
331:             .Visible         = .T.
332:         ENDWITH
333:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
334: 
335:         *-- Grid grd_4c_Lista - exibe SigCdRst + SigCdCli
336:         *-- Top=88+29=117 (compensacao PageFrame); Width=890; Height=483
337:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
338:         loc_oGrid = loc_oPagina.grd_4c_Lista
339: 
340:         loc_oGrid.RecordSource  = ""
341:         loc_oGrid.ColumnCount   = 3
342: 
343:         WITH loc_oGrid
344:             .Top                = 117
345:             .Left               = 26
346:             .Width              = 890
347:             .Height             = 483
348:             .DeleteMark         = .F.
349:             .RecordMark         = .F.
350:             .RowHeight          = 16
351:             .ScrollBars         = 2
352:             .GridLines          = 3
353:             .FontName           = "Verdana"
354:             .FontSize           = 8
355:             .ForeColor          = RGB(90, 90, 90)
356:             .BackColor          = RGB(255, 255, 255)
357:             .GridLineColor      = RGB(238, 238, 238)
358:             .HighlightBackColor = RGB(255, 255, 255)
359:             .HighlightForeColor = RGB(15, 41, 104)
360:             .HighlightStyle     = 2
361:             .Visible            = .T.
362:         ENDWITH
363: 
364:         WITH loc_oGrid.Column1
365:             .Width              = 100
366:             .Resizable          = .T.
367:             .Header1.Caption    = "Conta"
368:         ENDWITH
369: 
370:         WITH loc_oGrid.Column2
371:             .Width              = 450
372:             .Resizable          = .T.
373:             .Header1.Caption    = "Nome da Conta"

*-- Linhas 379 a 433:
379:             .Header1.Caption    = "Data"
380:         ENDWITH
381: 
382:         BINDEVENT(loc_oGrid, "DblClick", THIS, "BtnVisualizarClick")
383: 
384:         THIS.TornarControlesVisiveis(loc_oPagina)
385:     ENDPROC
386: 
387:     *===========================================================================
388:     * ConfigurarPaginaDados - Configura Page2 (Dados)
389:     * Fase 5: cnt_4c_Salva + labels + TextBoxes + OptionGroup + Shape + Image
390:     * Fase 6: GradMuni + GradProd (grids com botoes inline)
391:     * Top de todos os controles = Top_original_legado + 29 (compensacao PageFrame)
392:     *===========================================================================
393:     PROTECTED PROCEDURE ConfigurarPaginaDados()
394:         LOCAL loc_oPagina
395:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
396: 
397:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
398:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
399: 
400:         *-- ===================================================================
401:         *-- cnt_4c_Salva (Grupo_Salva) - Confirmar + Cancelar
402:         *-- Canonico: Top=4+29=33, Left=842, Width=160, Height=85
403:         *-- ===================================================================
404:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
405:         WITH loc_oPagina.cnt_4c_Salva
406:             .Top         = 33
407:             .Left        = 842
408:             .Width       = 160
409:             .Height      = 85
410:             .BackStyle   = 0
411:             .BorderWidth = 0
412:             .Visible     = .T.
413:         ENDWITH
414: 
415:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
416:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
417:             .Caption         = "Confirmar"
418:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
419:             .PicturePosition = 13
420:             .Top             = 5
421:             .Left            = 5
422:             .Width           = 75
423:             .Height          = 75
424:             .BackColor       = RGB(255, 255, 255)
425:             .ForeColor       = RGB(90, 90, 90)
426:             .FontName        = "Comic Sans MS"
427:             .FontBold        = .T.
428:             .FontItalic      = .T.
429:             .FontSize        = 8
430:             .Themes          = .F.
431:             .SpecialEffect   = 0
432:             .MousePointer    = 15
433:             .WordWrap        = .T.

*-- Linhas 494 a 580:
494:             .BorderStyle = 1
495:             .Visible     = .T.
496:         ENDWITH
497:         BINDEVENT(loc_oPagina.txt_4c_Codigo, "KeyPress", THIS, "ValidarContaCodigo")
498: 
499:         *-- Get_Desc: txt_4c_Desc - Top=47+29=76, Left=212, Width=290
500:         *-- When original: EMPTY(get_codigo) AND pcescolha='INSERIR'
501:         loc_oPagina.AddObject("txt_4c_Desc", "TextBox")
502:         WITH loc_oPagina.txt_4c_Desc
503:             .Value       = ""
504:             .Top         = 76
505:             .Left        = 212
506:             .Width       = 290
507:             .Height      = 25
508:             .MaxLength   = 40
509:             .FontName    = "Tahoma"
510:             .FontSize    = 8
511:             .ForeColor   = RGB(90, 90, 90)
512:             .BackColor   = RGB(255, 255, 255)
513:             .BorderStyle = 1
514:             .Visible     = .T.
515:         ENDWITH
516:         BINDEVENT(loc_oPagina.txt_4c_Desc, "KeyPress", THIS, "ValidarContaDescricao")
517: 
518:         *-- ===================================================================
519:         *-- Say11: "Checa Matriz :" - Top=79+29=108, Left=42, Width=71
520:         *-- ===================================================================
521:         loc_oPagina.AddObject("lbl_4c_ChkMatrix", "Label")
522:         WITH loc_oPagina.lbl_4c_ChkMatrix
523:             .Caption   = "Checa Matriz :"
524:             .Top       = 108
525:             .Left      = 42
526:             .Width     = 80
527:             .Height    = 17
528:             .FontName  = "Tahoma"
529:             .FontSize  = 8
530:             .ForeColor = RGB(90, 90, 90)
531:             .BackStyle = 0
532:             .AutoSize  = .F.
533:             .Alignment = 1
534:             .Visible   = .T.
535:         ENDWITH
536: 
537:         *-- op_con: opt_4c_ChkMatrix - Top=77+29=106, Left=124, Width=98, Height=22
538:         *-- Value=1 = Sim (this_nChkMatrs=1), Value=2 = Nao (this_nChkMatrs=0)
539:         *-- When original: INLIST(pcEscolha,'INSERIR','ALTERAR')
540:         loc_oPagina.AddObject("opt_4c_ChkMatrix", "OptionGroup")
541:         WITH loc_oPagina.opt_4c_ChkMatrix
542:             .ButtonCount = 2
543:             .Top         = 106
544:             .Left        = 124
545:             .Width       = 103
546:             .Height      = 22
547:             .BackStyle   = 0
548:             .BorderStyle = 0
549:             .Value       = 2
550:             .Visible     = .T.
551:         ENDWITH
552:         WITH loc_oPagina.opt_4c_ChkMatrix.Buttons(1)
553:             .Caption   = "Sim"
554:             .BackStyle = 0
555:             .Left      = 5
556:             .Top       = 3
557:             .Width     = 42
558:             .AutoSize  = .T.
559:             .FontName  = "Tahoma"
560:             .FontSize  = 8
561:             .ForeColor = RGB(90, 90, 90)
562:             .Themes    = .F.
563:         ENDWITH
564:         WITH loc_oPagina.opt_4c_ChkMatrix.Buttons(2)
565:             .Caption   = "N" + CHR(227) + "o"
566:             .BackStyle = 0
567:             .Left      = 50
568:             .Top       = 3
569:             .Width     = 43
570:             .AutoSize  = .T.
571:             .FontName  = "Tahoma"
572:             .FontSize  = 8
573:             .ForeColor = RGB(90, 90, 90)
574:             .Themes    = .F.
575:         ENDWITH
576: 
577:         *-- ===================================================================
578:         *-- Shape4: shp_4c_Shape4 - borda decorativa em volta da imagem do produto
579:         *-- Top=10+29=39, Left=648, Width=163, Height=111
580:         *-- ===================================================================

*-- Linhas 601 a 644:
601:             .Stretch = 2
602:             .Visible = .F.
603:         ENDWITH
604:         BINDEVENT(loc_oPagina.img_4c_ImgProds, "Click", THIS, "ImgProdsClick")
605: 
606:         *-- ===================================================================
607:         *-- Say3: "Municípios pertencentes a esta restrição:"
608:         *-- Top=116+29=145, Left=44, Width=199, Height=15
609:         *-- ===================================================================
610:         loc_oPagina.AddObject("lbl_4c_TituloMunis", "Label")
611:         WITH loc_oPagina.lbl_4c_TituloMunis
612:             .Caption   = "Munic" + CHR(237) + "pios pertencentes a esta restri" + CHR(231) + CHR(227) + "o:"
613:             .Top       = 145
614:             .Left      = 44
615:             .Width     = 199
616:             .Height    = 15
617:             .FontName  = "Tahoma"
618:             .FontSize  = 8
619:             .ForeColor = RGB(90, 90, 90)
620:             .BackStyle = 0
621:             .AutoSize  = .F.
622:             .Visible   = .T.
623:         ENDWITH
624: 
625:         *-- ===================================================================
626:         *-- Say4: "Produtos restringidos:"
627:         *-- Top=116+29=145, Left=418, Width=108, Height=15
628:         *-- ===================================================================
629:         loc_oPagina.AddObject("lbl_4c_TituloProds", "Label")
630:         WITH loc_oPagina.lbl_4c_TituloProds
631:             .Caption   = "Produtos restringidos:"
632:             .Top       = 145
633:             .Left      = 418
634:             .Width     = 108
635:             .Height    = 15
636:             .FontName  = "Tahoma"
637:             .FontSize  = 8
638:             .ForeColor = RGB(90, 90, 90)
639:             .BackStyle = 0
640:             .AutoSize  = .F.
641:             .Visible   = .T.
642:         ENDWITH
643: 
644:         *-- ===================================================================

*-- Linhas 684 a 750:
684:             .SpecialEffect   = 0
685:             .Visible         = .T.
686:         ENDWITH
687:         BINDEVENT(loc_oPagina.cmd_4c_InserirMuni, "Click", THIS, "BtnInserirMuniClick")
688: 
689:         *-- cmd_4c_ExcluirMuni - Excluir linha do GradMuni (excluir do legado)
690:         *-- Top=350+29=379, Left=356, Width=45, Height=45
691:         loc_oPagina.AddObject("cmd_4c_ExcluirMuni", "CommandButton")
692:         WITH loc_oPagina.cmd_4c_ExcluirMuni
693:             .Caption         = ""
694:             .ToolTipText     = "Excluir Munic" + CHR(237) + "pio"
695:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
696:             .PicturePosition = 0
697:             .Top             = 379
698:             .Left            = 356
699:             .Width           = 45
700:             .Height          = 45
701:             .FontBold        = .T.
702:             .FontName        = "Verdana"
703:             .FontSize        = 8
704:             .ForeColor       = RGB(36, 84, 155)
705:             .BackColor       = RGB(255, 255, 255)
706:             .Themes          = .F.
707:             .SpecialEffect   = 0
708:             .Visible         = .T.
709:         ENDWITH
710:         BINDEVENT(loc_oPagina.cmd_4c_ExcluirMuni, "Click", THIS, "BtnExcluirMuniClick")
711: 
712:         *-- ===================================================================
713:         *-- grd_4c_Munis (GradMuni) - Grade de Municipios
714:         *-- Top=133+29=162, Left=41, Width=309, Height=456
715:         *-- Col1=UF(24), Col2=Municipio(263)
716:         *-- ===================================================================
717:         loc_oPagina.AddObject("grd_4c_Munis", "Grid")
718:         loc_oPagina.grd_4c_Munis.ColumnCount = 3
719:         loc_oPagina.grd_4c_Munis.RecordSource = "cursor_4c_Munis"
720:         loc_oPagina.grd_4c_Munis.ColumnCount  = 2
721: 
722:         WITH loc_oPagina.grd_4c_Munis
723:             .Top                = 162
724:             .Left               = 41
725:             .Width              = 309
726:             .Height             = 456
727:             .DeleteMark         = .F.
728:             .RecordMark         = .F.
729:             .RowHeight          = 16
730:             .ScrollBars         = 2
731:             .GridLines          = 3
732:             .GridLineColor      = RGB(238, 238, 238)
733:             .HeaderHeight       = 20
734:             .FontName           = "Tahoma"
735:             .FontSize           = 8
736:             .ForeColor          = RGB(0, 0, 0)
737:             .BackColor          = RGB(255, 255, 255)
738:             .HighlightBackColor = RGB(255, 255, 255)
739:             .HighlightForeColor = RGB(15, 41, 104)
740:             .HighlightStyle     = 2
741:             .Visible            = .T.
742: 
743:             .Column1.ControlSource     = "cursor_4c_Munis.uf"
744:             .Column1.Width             = 24
745:             .Column1.FontName          = "Tahoma"
746:             .Column1.FontSize          = 8
747:             .Column1.Resizable         = .T.
748:             .Column1.Header1.Caption   = "UF"
749:             .Column1.Header1.Alignment = 2
750: 

*-- Linhas 757 a 849:
757:             .Column2.Header1.Alignment = 2
758:         ENDWITH
759: 
760:         BINDEVENT(loc_oPagina.grd_4c_Munis.Column1.Text1, "KeyPress", THIS, "GradMuniUFLostFocus")
761:         BINDEVENT(loc_oPagina.grd_4c_Munis.Column2.Text1, "KeyPress", THIS, "GradMuniMunLostFocus")
762: 
763:         *-- ===================================================================
764:         *-- cmd_4c_InserirProd - Inserir linha no GradProd (InserirV do legado)
765:         *-- Top=305+29=334, Left=912, Width=45, Height=45
766:         *-- ===================================================================
767:         loc_oPagina.AddObject("cmd_4c_InserirProd", "CommandButton")
768:         WITH loc_oPagina.cmd_4c_InserirProd
769:             .Caption         = ""
770:             .ToolTipText     = "Inserir Produto"
771:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
772:             .PicturePosition = 0
773:             .Top             = 334
774:             .Left            = 912
775:             .Width           = 45
776:             .Height          = 45
777:             .FontBold        = .T.
778:             .FontName        = "Verdana"
779:             .FontSize        = 8
780:             .ForeColor       = RGB(36, 84, 155)
781:             .BackColor       = RGB(255, 255, 255)
782:             .Themes          = .F.
783:             .SpecialEffect   = 0
784:             .Visible         = .T.
785:         ENDWITH
786:         BINDEVENT(loc_oPagina.cmd_4c_InserirProd, "Click", THIS, "BtnInserirProdClick")
787: 
788:         *-- cmd_4c_ExcluirProd - Excluir linha do GradProd (ExcluirV do legado)
789:         *-- Top=350+29=379, Left=912, Width=45, Height=45
790:         loc_oPagina.AddObject("cmd_4c_ExcluirProd", "CommandButton")
791:         WITH loc_oPagina.cmd_4c_ExcluirProd
792:             .Caption         = ""
793:             .ToolTipText     = "Excluir Produto"
794:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
795:             .PicturePosition = 0
796:             .Top             = 379
797:             .Left            = 912
798:             .Width           = 45
799:             .Height          = 45
800:             .FontBold        = .T.
801:             .FontName        = "Verdana"
802:             .FontSize        = 8
803:             .ForeColor       = RGB(36, 84, 155)
804:             .BackColor       = RGB(255, 255, 255)
805:             .Themes          = .F.
806:             .SpecialEffect   = 0
807:             .Visible         = .T.
808:         ENDWITH
809:         BINDEVENT(loc_oPagina.cmd_4c_ExcluirProd, "Click", THIS, "BtnExcluirProdClick")
810: 
811:         *-- ===================================================================
812:         *-- grd_4c_Prods (GradProd) - Grade de Produtos
813:         *-- Top=133+29=162, Left=417, Width=490, Height=456
814:         *-- Col1=Codigo(108), Col2=Descricao(360)
815:         *-- ===================================================================
816:         loc_oPagina.AddObject("grd_4c_Prods", "Grid")
817:         loc_oPagina.grd_4c_Prods.ColumnCount = 3
818:         loc_oPagina.grd_4c_Prods.RecordSource = "cursor_4c_Prods"
819:         loc_oPagina.grd_4c_Prods.ColumnCount  = 2
820: 
821:         WITH loc_oPagina.grd_4c_Prods
822:             .Top                = 162
823:             .Left               = 417
824:             .Width              = 490
825:             .Height             = 456
826:             .DeleteMark         = .F.
827:             .RecordMark         = .F.
828:             .RowHeight          = 16
829:             .ScrollBars         = 2
830:             .GridLines          = 3
831:             .GridLineColor      = RGB(238, 238, 238)
832:             .HeaderHeight       = 20
833:             .FontName           = "Tahoma"
834:             .FontSize           = 8
835:             .ForeColor          = RGB(0, 0, 0)
836:             .BackColor          = RGB(255, 255, 255)
837:             .HighlightBackColor = RGB(255, 255, 255)
838:             .HighlightForeColor = RGB(15, 41, 104)
839:             .HighlightStyle     = 2
840:             .Visible            = .T.
841: 
842:             .Column1.ControlSource     = "cursor_4c_Prods.cpros"
843:             .Column1.Width             = 108
844:             .Column1.FontName          = "Tahoma"
845:             .Column1.FontSize          = 8
846:             .Column1.Resizable         = .T.
847:             .Column1.Header1.Caption   = "C" + CHR(243) + "digo"
848:             .Column1.Header1.Alignment = 2
849: 

*-- Linhas 856 a 917:
856:             .Column2.Header1.Alignment = 2
857:         ENDWITH
858: 
859:         BINDEVENT(loc_oPagina.grd_4c_Prods.Column1.Text1, "KeyPress", THIS, "GradProdCodLostFocus")
860:         BINDEVENT(loc_oPagina.grd_4c_Prods.Column2.Text1, "KeyPress", THIS, "GradProdDescLostFocus")
861:         BINDEVENT(loc_oPagina.grd_4c_Prods, "AfterRowColChange", THIS, "GradProdAfterRowColChange")
862: 
863:         *-- BINDEVENTs para Confirmar e Cancelar (criados acima no cnt_4c_Salva)
864:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
865:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
866: 
867:         THIS.TornarControlesVisiveis(loc_oPagina)
868: 
869:         *-- img_4c_ImgProds inicia oculta (TornarControlesVisiveis setou .T. acima)
870:         loc_oPagina.img_4c_ImgProds.Visible = .F.
871:     ENDPROC
872: 
873:     *===========================================================================
874:     * CarregarLista - Carrega dados no grid da Page1 via BO
875:     * Vincula RecordSource, ControlSource e Header1.Caption apos Buscar()
876:     *===========================================================================
877:     PROCEDURE CarregarLista()
878:         LOCAL loc_lResultado, loc_oGrid
879:         loc_lResultado = .F.
880: 
881:         TRY
882:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
883:                 loc_lResultado = .T.
884:             ELSE
885:                 IF !THIS.this_oBusinessObject.Buscar("")
886:                     loc_lResultado = .F.
887:                 ELSE
888:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
889: 
890:                     loc_oGrid.ColumnCount = 3
891:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
892:                     loc_oGrid.ColumnCount  = 3
893: 
894:                     *-- Reconfigurar ControlSource e Headers apos RecordSource
895:                     *-- (RecordSource reseta essas propriedades - Problema #2 FORMCOR_LICOES)
896:                     WITH loc_oGrid
897:                         .Column1.ControlSource   = "cursor_4c_Dados.iclis"
898:                         .Column1.Width           = 100
899:                         .Column1.Header1.Caption = "Conta"
900: 
901:                         .Column2.ControlSource   = "cursor_4c_Dados.Rclis"
902:                         .Column2.Width           = 450
903:                         .Column2.Header1.Caption = "Nome da Conta"
904: 
905:                         .Column3.ControlSource   = "cursor_4c_Dados.datas"
906:                         .Column3.Width           = 80
907:                         .Column3.Header1.Caption = "Data"
908:                     ENDWITH
909: 
910:                     THIS.FormatarGridLista(loc_oGrid)
911: 
912:                     IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
913:                         GO TOP IN cursor_4c_Dados
914:                     ENDIF
915: 
916:                     loc_lResultado = .T.
917:                 ENDIF

*-- Linhas 929 a 1654:
929:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
930:     * Ao voltar para Page1 recarrega a lista automaticamente
931:     *===========================================================================
932:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
933:         LOCAL loc_lResultado
934:         loc_lResultado = .F.
935: 
936:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
937:             RETURN .F.
938:         ENDIF
939: 
940:         TRY
941:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
942:             IF par_nPagina = 1
943:                 THIS.CarregarLista()
944:             ENDIF
945:             loc_lResultado = .T.
946:         CATCH TO loException
947:             MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + ;
948:                 loException.Message, "Formrst.AlternarPagina")
949:             loc_lResultado = .F.
950:         ENDTRY
951: 
952:         RETURN loc_lResultado
953:     ENDPROC
954: 
955:     *===========================================================================
956:     * BtnIncluirClick - Prepara modo INCLUIR e navega para Page2
957:     *===========================================================================
958:     PROCEDURE BtnIncluirClick()
959:         THIS.this_oBusinessObject.NovoRegistro()
960:         THIS.this_cModoAtual = "INCLUIR"
961:         THIS.LimparCampos()
962:         THIS.InicializarGradesVazias()
963:         THIS.HabilitarCampos(.T.)
964:         THIS.AlternarPagina(2)
965:         THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.SetFocus()
966:     ENDPROC
967: 
968:     *===========================================================================
969:     * BtnVisualizarClick - Carrega registro selecionado em modo VISUALIZAR
970:     *===========================================================================
971:     PROCEDURE BtnVisualizarClick()
972:         LOCAL loc_cSkChaves
973:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
974:             MsgAviso("Selecione um registro na lista.", "Aviso")
975:             RETURN
976:         ENDIF
977:         SELECT cursor_4c_Dados
978:         loc_cSkChaves = ALLTRIM(cursor_4c_Dados.skchaves)
979:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cSkChaves)
980:             THIS.this_cModoAtual = "VISUALIZAR"
981:             THIS.BOParaForm()
982:             THIS.CarregarGrades(loc_cSkChaves)
983:             THIS.HabilitarCampos(.F.)
984:             THIS.AlternarPagina(2)
985:         ENDIF
986:     ENDPROC
987: 
988:     *===========================================================================
989:     * BtnAlterarClick - Carrega registro selecionado em modo ALTERAR
990:     *===========================================================================
991:     PROCEDURE BtnAlterarClick()
992:         LOCAL loc_cSkChaves
993:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
994:             MsgAviso("Selecione um registro na lista.", "Aviso")
995:             RETURN
996:         ENDIF
997:         SELECT cursor_4c_Dados
998:         loc_cSkChaves = ALLTRIM(cursor_4c_Dados.skchaves)
999:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cSkChaves)
1000:             THIS.this_oBusinessObject.EditarRegistro()
1001:             THIS.this_cModoAtual = "ALTERAR"
1002:             THIS.BOParaForm()
1003:             THIS.CarregarGrades(loc_cSkChaves)
1004:             THIS.HabilitarCampos(.T.)
1005:             THIS.AlternarPagina(2)
1006:         ENDIF
1007:     ENDPROC
1008: 
1009:     *===========================================================================
1010:     * BtnExcluirClick - Exclui registro selecionado com confirmacao
1011:     *===========================================================================
1012:     PROCEDURE BtnExcluirClick()
1013:         LOCAL loc_cSkChaves, loc_cIclis
1014:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
1015:             MsgAviso("Selecione um registro na lista.", "Aviso")
1016:             RETURN
1017:         ENDIF
1018:         SELECT cursor_4c_Dados
1019:         loc_cSkChaves = ALLTRIM(cursor_4c_Dados.skchaves)
1020:         loc_cIclis    = ALLTRIM(cursor_4c_Dados.iclis)
1021:         IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da exclusividade" + CHR(13) + ;
1022:                 "da conta: " + loc_cIclis + " ?", "Excluir")
1023:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cSkChaves)
1024:                 IF THIS.this_oBusinessObject.Excluir()
1025:                     MsgInfo("Exclusividade exclu" + CHR(237) + "da com sucesso!")
1026:                     THIS.CarregarLista()
1027:                 ENDIF
1028:             ENDIF
1029:         ENDIF
1030:     ENDPROC
1031: 
1032:     *===========================================================================
1033:     * BtnBuscarClick - Recarrega a lista completa (reset de filtro)
1034:     *===========================================================================
1035:     PROCEDURE BtnBuscarClick()
1036:         THIS.CarregarLista()
1037:     ENDPROC
1038: 
1039:     *===========================================================================
1040:     * BtnEncerrarClick - Fecha o formulario
1041:     *===========================================================================
1042:     PROCEDURE BtnEncerrarClick()
1043:         THIS.Release()
1044:     ENDPROC
1045: 
1046:     *===========================================================================
1047:     * Destroy - Limpa cursores e recursos ao fechar o formulario
1048:     *===========================================================================
1049:     PROCEDURE Destroy()
1050:         IF USED("cursor_4c_Dados")
1051:             USE IN cursor_4c_Dados
1052:         ENDIF
1053:         IF USED("cursor_4c_Munis")
1054:             USE IN cursor_4c_Munis
1055:         ENDIF
1056:         IF USED("cursor_4c_Prods")
1057:             USE IN cursor_4c_Prods
1058:         ENDIF
1059:         THIS.this_oBusinessObject = .NULL.
1060:         DODEFAULT()
1061:     ENDPROC
1062: 
1063:     *===========================================================================
1064:     * TornarControlesVisiveis - Torna todos os controles do container visiveis
1065:     * Percorre Pages de PageFrames e controles de Containers recursivamente
1066:     *===========================================================================
1067:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1068:         LOCAL loc_nI, loc_oObjeto, loc_nP
1069: 
1070:         IF VARTYPE(par_oContainer) != "O"
1071:             RETURN
1072:         ENDIF
1073: 
1074:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1075:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1076: 
1077:             IF VARTYPE(loc_oObjeto) = "O"
1078:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1079:                     loc_oObjeto.Visible = .T.
1080:                 ENDIF
1081: 
1082:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1083:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1084:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1085:                     ENDFOR
1086:                 ENDIF
1087: 
1088:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1089:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1090:                 ENDIF
1091:             ENDIF
1092:         ENDFOR
1093:     ENDPROC
1094: 
1095:     *===========================================================================
1096:     * FormatarGridLista - Formata visual do grid da lista (fonte padrao)
1097:     *===========================================================================
1098:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1099:         IF VARTYPE(par_oGrid) != "O"
1100:             RETURN
1101:         ENDIF
1102: 
1103:         WITH par_oGrid
1104:             .FontName = "Tahoma"
1105:             .FontSize = 8
1106:         ENDWITH
1107:     ENDPROC
1108: 
1109:     *===========================================================================
1110:     * ValidarContaCodigo - Handler LostFocus txt_4c_Codigo
1111:     * Valida conta por codigo via fAcessoContas (sigacess.PRG)
1112:     * Equivalente ao Get_codigo.Valid do legado SIGCDRST
1113:     *===========================================================================
1114:     PROCEDURE ValidarContaCodigo(par_nKeyCode, par_nShiftAltCtrl)
1115:         LOCAL loc_cCodigo, loc_oPg2, loc_cGrupo, loc_nResult
1116:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
1117:         loc_cCodigo = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
1118: 
1119:         IF EMPTY(loc_cCodigo)
1120:             loc_oPg2.txt_4c_Desc.Value = ""
1121:             RETURN
1122:         ENDIF
1123: 
1124:         loc_cGrupo = ""
1125:         TRY
1126:             *-- fAcessoContas: busca por codigo ('C'), preenche ambos os controles
1127:             IF !fAcessoContas(Usuar, loc_cGrupo, "C", loc_cCodigo, ;
1128:                               loc_oPg2.txt_4c_Codigo, loc_oPg2.txt_4c_Desc)
1129:                 MsgAviso("Acesso Negado !!", "Aviso")
1130:                 loc_oPg2.txt_4c_Codigo.Value = ""
1131:                 loc_oPg2.txt_4c_Desc.Value   = ""
1132:                 loc_oPg2.txt_4c_Codigo.SetFocus()
1133:             ENDIF
1134:         CATCH TO loException
1135:             *-- fAcessoContas indisponivel: busca direta em SigCdCli
1136:             loc_nResult = SQLEXEC(gnConnHandle, ;
1137:                 "SELECT TOP 1 Iclis, Rclis FROM SigCdCli" + ;
1138:                 " WHERE Iclis = " + EscaparSQL(loc_cCodigo), ;
1139:                 "cursor_4c_BuscaCli")
1140:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_BuscaCli") > 0
1141:                 loc_oPg2.txt_4c_Codigo.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
1142:                 loc_oPg2.txt_4c_Desc.Value   = ALLTRIM(cursor_4c_BuscaCli.Rclis)
1143:             ELSE
1144:                 MsgAviso("Conta n" + CHR(227) + "o encontrada.", "Aviso")
1145:                 loc_oPg2.txt_4c_Codigo.Value = ""
1146:                 loc_oPg2.txt_4c_Desc.Value   = ""
1147:                 loc_oPg2.txt_4c_Codigo.SetFocus()
1148:             ENDIF
1149:             IF USED("cursor_4c_BuscaCli")
1150:                 USE IN cursor_4c_BuscaCli
1151:             ENDIF
1152:         ENDTRY
1153:     ENDPROC
1154: 
1155:     *===========================================================================
1156:     * ValidarContaDescricao - Handler LostFocus txt_4c_Desc
1157:     * Valida conta por descricao via fAcessoContas (sigacess.PRG)
1158:     * Equivalente ao Get_Desc.Valid do legado SIGCDRST
1159:     *===========================================================================
1160:     PROCEDURE ValidarContaDescricao(par_nKeyCode, par_nShiftAltCtrl)
1161:         LOCAL loc_cDesc, loc_oPg2, loc_cGrupo, loc_nResult
1162:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1163:         loc_cDesc  = ALLTRIM(loc_oPg2.txt_4c_Desc.Value)
1164: 
1165:         IF EMPTY(loc_cDesc)
1166:             loc_oPg2.txt_4c_Codigo.Value = ""
1167:             RETURN
1168:         ENDIF
1169: 
1170:         loc_cGrupo = ""
1171:         TRY
1172:             *-- fAcessoContas: busca por descricao ('D'), preenche ambos os controles
1173:             IF !fAcessoContas(Usuar, loc_cGrupo, "D", loc_cDesc, ;
1174:                               loc_oPg2.txt_4c_Codigo, loc_oPg2.txt_4c_Desc)
1175:                 MsgAviso("Acesso Negado !!", "Aviso")
1176:                 loc_oPg2.txt_4c_Desc.Value   = ""
1177:                 loc_oPg2.txt_4c_Codigo.Value = ""
1178:                 loc_oPg2.txt_4c_Desc.SetFocus()
1179:             ENDIF
1180:         CATCH TO loException
1181:             *-- fAcessoContas indisponivel: busca direta em SigCdCli por nome
1182:             loc_nResult = SQLEXEC(gnConnHandle, ;
1183:                 "SELECT TOP 1 Iclis, Rclis FROM SigCdCli" + ;
1184:                 " WHERE Rclis LIKE " + EscaparSQL(loc_cDesc + "%"), ;
1185:                 "cursor_4c_BuscaCli")
1186:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_BuscaCli") > 0
1187:                 loc_oPg2.txt_4c_Codigo.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
1188:                 loc_oPg2.txt_4c_Desc.Value   = ALLTRIM(cursor_4c_BuscaCli.Rclis)
1189:             ELSE
1190:                 MsgAviso("Conta n" + CHR(227) + "o encontrada.", "Aviso")
1191:                 loc_oPg2.txt_4c_Desc.Value   = ""
1192:                 loc_oPg2.txt_4c_Codigo.Value = ""
1193:                 loc_oPg2.txt_4c_Desc.SetFocus()
1194:             ENDIF
1195:             IF USED("cursor_4c_BuscaCli")
1196:                 USE IN cursor_4c_BuscaCli
1197:             ENDIF
1198:         ENDTRY
1199:     ENDPROC
1200: 
1201:     *===========================================================================
1202:     * ImgProdsClick - Handler Click em img_4c_ImgProds
1203:     * Recarrega imagem do produto selecionado em GradProd (cursor_4c_Prods)
1204:     * Equivalente ao imgProds.Click do legado SIGCDRST
1205:     *===========================================================================
1206:     PROCEDURE ImgProdsClick()
1207:         LOCAL loc_cCodPro, loc_nResult, loc_cArquivo, loc_cFoto, loc_oPg2
1208:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1209: 
1210:         IF !USED("cursor_4c_Prods") OR EOF("cursor_4c_Prods")
1211:             RETURN
1212:         ENDIF
1213: 
1214:         SELECT cursor_4c_Prods
1215:         loc_cCodPro = ALLTRIM(cursor_4c_Prods.cpros)
1216:         IF EMPTY(loc_cCodPro)
1217:             RETURN
1218:         ENDIF
1219: 
1220:         TRY
1221:             loc_nResult = SQLEXEC(gnConnHandle, ;
1222:                 "SELECT a.cpros, a.FigJpgs FROM SigCdPro a" + ;
1223:                 " WHERE a.cpros = " + EscaparSQL(loc_cCodPro), ;
1224:                 "cursor_4c_ImgPro")
1225:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ImgPro") > 0
1226:                 SELECT cursor_4c_ImgPro
1227:                 IF !EMPTY(NVL(cursor_4c_ImgPro.FigJpgs, "")) AND !ISNULL(cursor_4c_ImgPro.FigJpgs)
1228:                     loc_cArquivo = SYS(2023) + "\" + goSistema.Sys2015Tmp + SYS(2015) + ".jpg"
1229:                     loc_cFoto    = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_ImgPro.FigJpgs, ;
1230:                         "data:image/png;base64,", ""), ;
1231:                         "data:image/jpeg;base64,", ""), ;
1232:                         "data:image/jpg;base64,", ""), 14)
1233:                     STRTOFILE(loc_cFoto, loc_cArquivo)
1234:                     loc_oPg2.img_4c_ImgProds.Picture = loc_cArquivo
1235:                     loc_oPg2.img_4c_ImgProds.Visible = .T.
1236:                 ENDIF
1237:             ENDIF
1238:             IF USED("cursor_4c_ImgPro")
1239:                 USE IN cursor_4c_ImgPro
1240:             ENDIF
1241:         CATCH TO loException
1242:             MsgErro("Erro ao exibir imagem:" + CHR(13) + loException.Message, ;
1243:                 "Formrst.ImgProdsClick")
1244:             IF USED("cursor_4c_ImgPro")
1245:                 USE IN cursor_4c_ImgPro
1246:             ENDIF
1247:         ENDTRY
1248:     ENDPROC
1249: 
1250:     *===========================================================================
1251:     * BtnSalvarClick - Valida e persiste o registro (INCLUIR ou ALTERAR)
1252:     * Chamado via BINDEVENT cnt_4c_Salva.cmd_4c_Confirmar Click
1253:     *===========================================================================
1254:     PROCEDURE BtnSalvarClick()
1255:         LOCAL loc_lResultado, loc_cIclis, loc_nQtdProd, loc_oPg2, loc_lValido, loc_nRec
1256:         loc_lResultado = .F.
1257:         loc_lValido    = .F.
1258:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1259: 
1260:         TRY
1261:             *-- Validar conta obrigatoria
1262:             loc_cIclis = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
1263:             IF EMPTY(loc_cIclis)
1264:                 MsgAviso("Conta obrigat" + CHR(243) + "ria.", "Aviso")
1265:                 loc_oPg2.txt_4c_Codigo.SetFocus()
1266:             ELSE
1267:                 *-- Contar produtos com cpros valido
1268:                 loc_nQtdProd = 0
1269:                 IF USED("cursor_4c_Prods")
1270:                     SELECT cursor_4c_Prods
1271:                     loc_nRec = RECNO()
1272:                     GO TOP
1273:                     SCAN FOR !DELETED()
1274:                         IF !EMPTY(ALLTRIM(cpros))
1275:                             loc_nQtdProd = loc_nQtdProd + 1
1276:                         ENDIF
1277:                     ENDSCAN
1278:                     IF loc_nRec > 0 AND loc_nRec <= RECCOUNT("cursor_4c_Prods")
1279:                         GO (loc_nRec) IN cursor_4c_Prods
1280:                     ENDIF
1281:                 ENDIF
1282:                 IF loc_nQtdProd = 0
1283:                     MsgAviso("Informe ao menos um produto.", "Aviso")
1284:                 ELSE
1285:                     IF THIS.this_cModoAtual = "INCLUIR"
1286:                         IF THIS.this_oBusinessObject.VerificarContaCadastrada(loc_cIclis)
1287:                             MsgAviso("Esta conta j" + CHR(225) + " possui exclusividade cadastrada.", "Aviso")
1288:                             loc_oPg2.txt_4c_Codigo.SetFocus()
1289:                         ELSE
1290:                             loc_lValido = .T.
1291:                         ENDIF
1292:                     ELSE
1293:                         loc_lValido = .T.
1294:                     ENDIF
1295:                 ENDIF
1296:             ENDIF
1297: 
1298:             IF loc_lValido
1299:                 THIS.FormParaBO()
1300:                 IF THIS.this_oBusinessObject.Salvar()
1301:                     MsgInfo("Exclusividade gravada com sucesso!")
1302:                     THIS.this_cModoAtual = "LISTA"
1303:                     THIS.AlternarPagina(1)
1304:                     loc_lResultado = .T.
1305:                 ENDIF
1306:             ENDIF
1307:         CATCH TO loException
1308:             MsgErro("Erro ao salvar:" + CHR(13) + loException.Message, "Formrst.BtnSalvarClick")
1309:         ENDTRY
1310:     ENDPROC
1311: 
1312:     *===========================================================================
1313:     * BtnCancelarClick - Cancela edicao e retorna para lista
1314:     * Chamado via BINDEVENT cnt_4c_Salva.cmd_4c_Cancelar Click
1315:     *===========================================================================
1316:     PROCEDURE BtnCancelarClick()
1317:         THIS.this_cModoAtual = "LISTA"
1318:         THIS.AlternarPagina(1)
1319:     ENDPROC
1320: 
1321:     *===========================================================================
1322:     * FormParaBO - Transfere valores dos controles para propriedades do BO
1323:     *===========================================================================
1324:     PROTECTED PROCEDURE FormParaBO()
1325:         LOCAL loc_oPg2
1326:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1327:         THIS.this_oBusinessObject.this_cIclis    = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
1328:         THIS.this_oBusinessObject.this_cRclis    = ALLTRIM(loc_oPg2.txt_4c_Desc.Value)
1329:         THIS.this_oBusinessObject.this_nChkMatrs = IIF(loc_oPg2.opt_4c_ChkMatrix.Value = 1, 1, 0)
1330:     ENDPROC
1331: 
1332:     *===========================================================================
1333:     * BOParaForm - Transfere propriedades do BO para controles do formulario
1334:     *===========================================================================
1335:     PROTECTED PROCEDURE BOParaForm()
1336:         LOCAL loc_oPg2
1337:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1338:         loc_oPg2.txt_4c_Codigo.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cIclis)
1339:         loc_oPg2.txt_4c_Desc.Value      = ALLTRIM(THIS.this_oBusinessObject.this_cRclis)
1340:         loc_oPg2.opt_4c_ChkMatrix.Value = IIF(THIS.this_oBusinessObject.this_nChkMatrs = 1, 1, 2)
1341:     ENDPROC
1342: 
1343:     *===========================================================================
1344:     * HabilitarCampos - Liga/desliga edicao dos controles da Page2
1345:     * par_lHabilitar=.T.: INCLUIR/ALTERAR; .F.: VISUALIZAR (somente leitura)
1346:     *===========================================================================
1347:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1348:         LOCAL loc_oPg2
1349:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1350:         loc_oPg2.txt_4c_Codigo.ReadOnly      = !par_lHabilitar
1351:         loc_oPg2.opt_4c_ChkMatrix.Enabled    = par_lHabilitar
1352:         loc_oPg2.grd_4c_Munis.ReadOnly       = !par_lHabilitar
1353:         loc_oPg2.grd_4c_Prods.ReadOnly       = !par_lHabilitar
1354:     ENDPROC
1355: 
1356:     *===========================================================================
1357:     * LimparCampos - Reseta controles da Page2 para estado inicial
1358:     *===========================================================================
1359:     PROTECTED PROCEDURE LimparCampos()
1360:         LOCAL loc_oPg2
1361:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1362:         loc_oPg2.txt_4c_Codigo.Value     = ""
1363:         loc_oPg2.txt_4c_Desc.Value       = ""
1364:         loc_oPg2.opt_4c_ChkMatrix.Value  = 2
1365:         loc_oPg2.img_4c_ImgProds.Visible = .F.
1366:     ENDPROC
1367: 
1368:     *===========================================================================
1369:     * CarregarGrades - Popula ambas as grids via BO para o skChaves dado
1370:     *===========================================================================
1371:     PROTECTED PROCEDURE CarregarGrades(par_cSkChaves)
1372:         THIS.this_oBusinessObject.BuscarMunicipios(par_cSkChaves)
1373:         THIS.this_oBusinessObject.BuscarProdutos(par_cSkChaves)
1374:         THIS.RefreshGridMunis()
1375:         THIS.RefreshGridProds()
1376:     ENDPROC
1377: 
1378:     *===========================================================================
1379:     * InicializarGradesVazias - Cria cursores locais vazios (1 linha em branco)
1380:     * Usado em modo INCLUIR para permitir digitacao imediata nas grades
1381:     *===========================================================================
1382:     PROTECTED PROCEDURE InicializarGradesVazias()
1383:         IF USED("cursor_4c_Munis")
1384:             USE IN cursor_4c_Munis
1385:         ENDIF
1386:         SET NULL ON
1387:         CREATE CURSOR cursor_4c_Munis (skchaves C(20), pkchaves C(20), codibges C(7), ;
1388:             tipos C(1), UFIBGEs N(2,0), munici C(40), uf C(2))
1389:         SET NULL OFF
1390:         APPEND BLANK IN cursor_4c_Munis
1391:         GO TOP IN cursor_4c_Munis
1392: 
1393:         IF USED("cursor_4c_Prods")
1394:             USE IN cursor_4c_Prods
1395:         ENDIF
1396:         SET NULL ON
1397:         CREATE CURSOR cursor_4c_Prods (skchaves C(20), pkchaves C(20), cpros C(14), ;
1398:             dpros C(40), tipos C(1))
1399:         SET NULL OFF
1400:         APPEND BLANK IN cursor_4c_Prods
1401:         GO TOP IN cursor_4c_Prods
1402: 
1403:         THIS.RefreshGridMunis()
1404:         THIS.RefreshGridProds()
1405:     ENDPROC
1406: 
1407:     *===========================================================================
1408:     * RefreshGridMunis - Rebinda grd_4c_Munis ao cursor_4c_Munis
1409:     * Necessario apos BuscarMunicipios() recriar o cursor (Problema #2/#48)
1410:     *===========================================================================
1411:     PROTECTED PROCEDURE RefreshGridMunis()
1412:         LOCAL loc_oGrid
1413:         TRY
1414:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Munis
1415:             loc_oGrid.ColumnCount = 3
1416:             loc_oGrid.RecordSource = "cursor_4c_Munis"
1417:             loc_oGrid.ColumnCount  = 2
1418:             WITH loc_oGrid
1419:                 .Column1.ControlSource   = "cursor_4c_Munis.uf"
1420:                 .Column1.Width           = 24
1421:                 .Column1.Header1.Caption = "UF"
1422:                 .Column2.ControlSource   = "cursor_4c_Munis.munici"
1423:                 .Column2.Width           = 263
1424:                 .Column2.Header1.Caption = "Munic" + CHR(237) + "pio"
1425:             ENDWITH
1426:             loc_oGrid.Refresh()
1427:         CATCH TO loException
1428:             MsgErro("Erro ao atualizar grade munic" + CHR(237) + "pios:" + CHR(13) + ;
1429:                 loException.Message, "Formrst.RefreshGridMunis")
1430:         ENDTRY
1431:     ENDPROC
1432: 
1433:     *===========================================================================
1434:     * RefreshGridProds - Rebinda grd_4c_Prods ao cursor_4c_Prods
1435:     * Necessario apos BuscarProdutos() recriar o cursor (Problema #2/#48)
1436:     *===========================================================================
1437:     PROTECTED PROCEDURE RefreshGridProds()
1438:         LOCAL loc_oGrid
1439:         TRY
1440:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Prods
1441:             loc_oGrid.ColumnCount = 3
1442:             loc_oGrid.RecordSource = "cursor_4c_Prods"
1443:             loc_oGrid.ColumnCount  = 2
1444:             WITH loc_oGrid
1445:                 .Column1.ControlSource   = "cursor_4c_Prods.cpros"
1446:                 .Column1.Width           = 108
1447:                 .Column1.Header1.Caption = CHR(67) + CHR(243) + "digo"
1448:                 .Column2.ControlSource   = "cursor_4c_Prods.dpros"
1449:                 .Column2.Width           = 360
1450:                 .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1451:             ENDWITH
1452:             loc_oGrid.Refresh()
1453:         CATCH TO loException
1454:             MsgErro("Erro ao atualizar grade produtos:" + CHR(13) + loException.Message, ;
1455:                 "Formrst.RefreshGridProds")
1456:         ENDTRY
1457:     ENDPROC
1458: 
1459:     *===========================================================================
1460:     * GradMuniUFLostFocus - Valida UF digitada na Column1 de grd_4c_Munis
1461:     * Busca em SigCdUfs; se nao encontrado abre FormBuscaAuxiliar
1462:     *===========================================================================
1463:     PROCEDURE GradMuniUFLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1464:         LOCAL loc_cUF, loc_nResult, loc_oBusca
1465: 
1466:         IF !USED("cursor_4c_Munis") OR EOF("cursor_4c_Munis") OR BOF("cursor_4c_Munis")
1467:             RETURN
1468:         ENDIF
1469: 
1470:         SELECT cursor_4c_Munis
1471:         loc_cUF = ALLTRIM(cursor_4c_Munis.uf)
1472: 
1473:         IF EMPTY(loc_cUF)
1474:             RETURN
1475:         ENDIF
1476: 
1477:         TRY
1478:             loc_nResult = SQLEXEC(gnConnHandle, ;
1479:                 "SELECT TOP 1 estados, ufibges FROM SigCdUfs" + ;
1480:                 " WHERE estados = " + EscaparSQL(loc_cUF), ;
1481:                 "cursor_4c_BuscaUf")
1482:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_BuscaUf") > 0
1483:                 SELECT cursor_4c_Munis
1484:                 REPLACE uf      WITH ALLTRIM(cursor_4c_BuscaUf.estados), ;
1485:                         UFIBGEs WITH cursor_4c_BuscaUf.ufibges
1486:             ELSE
1487:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1488:                     "SELECT estados AS codigo, estados AS descricao FROM SigCdUfs" + ;
1489:                     " WHERE estados LIKE " + EscaparSQL(loc_cUF + "%") + ;
1490:                     " ORDER BY estados", ;
1491:                     "cursor_4c_BuscaUfs")
1492:                 IF loc_nResult < 0 OR RECCOUNT("cursor_4c_BuscaUfs") = 0
1493:                     IF USED("cursor_4c_BuscaUfs")
1494:                         USE IN cursor_4c_BuscaUfs
1495:                     ENDIF
1496:                     SQLEXEC(gnConnHandle, ;
1497:                         "SELECT estados AS codigo, estados AS descricao FROM SigCdUfs ORDER BY estados", ;
1498:                         "cursor_4c_BuscaUfs")
1499:                 ENDIF
1500:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1501:                 IF VARTYPE(loc_oBusca) = "O"
1502:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaUfs", "codigo", "descricao", "UF")
1503:                     loc_oBusca.Mostrar()
1504:                     IF !EMPTY(ALLTRIM(loc_oBusca.cCodigoSelecionado))
1505:                         loc_nResult = SQLEXEC(gnConnHandle, ;
1506:                             "SELECT TOP 1 estados, ufibges FROM SigCdUfs" + ;
1507:                             " WHERE estados = " + EscaparSQL(ALLTRIM(loc_oBusca.cCodigoSelecionado)), ;
1508:                             "cursor_4c_UfSel")
1509:                         IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_UfSel") > 0
1510:                             SELECT cursor_4c_Munis
1511:                             REPLACE uf      WITH ALLTRIM(cursor_4c_UfSel.estados), ;
1512:                                     UFIBGEs WITH cursor_4c_UfSel.ufibges
1513:                         ENDIF
1514:                         IF USED("cursor_4c_UfSel")
1515:                             USE IN cursor_4c_UfSel
1516:                         ENDIF
1517:                     ELSE
1518:                         SELECT cursor_4c_Munis
1519:                         REPLACE uf WITH "", UFIBGEs WITH 0
1520:                     ENDIF
1521:                     IF USED("cursor_4c_BuscaUfs")
1522:                         USE IN cursor_4c_BuscaUfs
1523:                     ENDIF
1524:                 ENDIF
1525:             ENDIF
1526:             IF USED("cursor_4c_BuscaUf")
1527:                 USE IN cursor_4c_BuscaUf
1528:             ENDIF
1529:             THIS.pgf_4c_Paginas.Page2.grd_4c_Munis.Refresh()
1530:         CATCH TO loException
1531:             MsgErro("Erro ao validar UF:" + CHR(13) + loException.Message, ;
1532:                 "Formrst.GradMuniUFLostFocus")
1533:             IF USED("cursor_4c_BuscaUf")
1534:                 USE IN cursor_4c_BuscaUf
1535:             ENDIF
1536:             IF USED("cursor_4c_BuscaUfs")
1537:                 USE IN cursor_4c_BuscaUfs
1538:             ENDIF
1539:         ENDTRY
1540:     ENDPROC
1541: 
1542:     *===========================================================================
1543:     * GradMuniMunLostFocus - Valida municipio digitado na Column2 de grd_4c_Munis
1544:     * Verifica duplicidade + busca em SigCdMun; se nao encontrado abre picker
1545:     *===========================================================================
1546:     PROCEDURE GradMuniMunLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1547:         LOCAL loc_cMunici, loc_cUF, loc_nContagem, loc_nResult, loc_oBusca, loc_nRec
1548: 
1549:         IF !USED("cursor_4c_Munis") OR EOF("cursor_4c_Munis") OR BOF("cursor_4c_Munis")
1550:             RETURN
1551:         ENDIF
1552: 
1553:         SELECT cursor_4c_Munis
1554:         loc_cMunici = ALLTRIM(cursor_4c_Munis.munici)
1555:         loc_cUF     = ALLTRIM(cursor_4c_Munis.uf)
1556: 
1557:         IF EMPTY(loc_cMunici)
1558:             RETURN
1559:         ENDIF
1560: 
1561:         TRY
1562:             *-- Verificar duplicidade: mesmo uf + munici em outra linha
1563:             SELECT cursor_4c_Munis
1564:             loc_nRec = RECNO()
1565:             GO TOP
1566:             loc_nContagem = 0
1567:             SCAN FOR !DELETED()
1568:                 IF ALLTRIM(uf) = loc_cUF AND ALLTRIM(munici) = loc_cMunici
1569:                     loc_nContagem = loc_nContagem + 1
1570:                 ENDIF
1571:             ENDSCAN
1572:             IF loc_nRec > 0 AND loc_nRec <= RECCOUNT("cursor_4c_Munis")
1573:                 GO (loc_nRec) IN cursor_4c_Munis
1574:             ENDIF
1575: 
1576:             IF loc_nContagem > 1
1577:                 MsgAviso("Munic" + CHR(237) + "pio j" + CHR(225) + ;
1578:                     " adicionado para este estado.", "Aviso")
1579:                 SELECT cursor_4c_Munis
1580:                 REPLACE munici WITH "", codibges WITH "", UFIBGEs WITH 0, uf WITH ""
1581:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Munis.Refresh()
1582:             ELSE
1583:                 *-- Busca exata em SigCdMun pelo nome do municipio
1584:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1585:                     "SELECT TOP 1 a.codigos, a.descs," + ;
1586:                     " ISNULL(b.estados,'') AS uf, ISNULL(b.ufibges,0) AS UFIBGEs" + ;
1587:                     " FROM SigCdMun a" + ;
1588:                     " LEFT JOIN SigCdUfs b ON b.ufibges = a.ufibges" + ;
1589:                     " WHERE a.descs = " + EscaparSQL(loc_cMunici), ;
1590:                     "cursor_4c_BuscaMun")
1591:                 IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_BuscaMun") > 0
1592:                     SELECT cursor_4c_Munis
1593:                     REPLACE codibges WITH ALLTRIM(cursor_4c_BuscaMun.codigos), ;
1594:                             munici   WITH ALLTRIM(cursor_4c_BuscaMun.descs), ;
1595:                             uf       WITH ALLTRIM(cursor_4c_BuscaMun.uf), ;
1596:                             UFIBGEs  WITH cursor_4c_BuscaMun.UFIBGEs
1597:                 ELSE
1598:                     *-- Abrir picker de municipios
1599:                     loc_nResult = SQLEXEC(gnConnHandle, ;
1600:                         "SELECT a.codigos AS codigo, a.descs AS descricao" + ;
1601:                         " FROM SigCdMun a" + ;
1602:                         " WHERE a.descs LIKE " + EscaparSQL(loc_cMunici + "%") + ;
1603:                         " ORDER BY a.descs", ;
1604:                         "cursor_4c_BuscaMuns")
1605:                     IF loc_nResult < 0 OR RECCOUNT("cursor_4c_BuscaMuns") = 0
1606:                         IF USED("cursor_4c_BuscaMuns")
1607:                             USE IN cursor_4c_BuscaMuns
1608:                         ENDIF
1609:                         SQLEXEC(gnConnHandle, ;
1610:                             "SELECT a.codigos AS codigo, a.descs AS descricao" + ;
1611:                             " FROM SigCdMun a ORDER BY a.descs", ;
1612:                             "cursor_4c_BuscaMuns")
1613:                     ENDIF
1614:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1615:                     IF VARTYPE(loc_oBusca) = "O"
1616:                         loc_oBusca.DefinirCursor("cursor_4c_BuscaMuns", "codigo", "descricao", ;
1617:                             "Munic" + CHR(237) + "pio")
1618:                         loc_oBusca.Mostrar()
1619:                         IF !EMPTY(ALLTRIM(loc_oBusca.cCodigoSelecionado))
1620:                             loc_nResult = SQLEXEC(gnConnHandle, ;
1621:                                 "SELECT TOP 1 a.codigos, a.descs," + ;
1622:                                 " ISNULL(b.estados,'') AS uf, ISNULL(b.ufibges,0) AS UFIBGEs" + ;
1623:                                 " FROM SigCdMun a" + ;
1624:                                 " LEFT JOIN SigCdUfs b ON b.ufibges = a.ufibges" + ;
1625:                                 " WHERE a.codigos = " + ;
1626:                                 EscaparSQL(ALLTRIM(loc_oBusca.cCodigoSelecionado)), ;
1627:                                 "cursor_4c_MunSel")
1628:                             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_MunSel") > 0
1629:                                 SELECT cursor_4c_Munis
1630:                                 REPLACE codibges WITH ALLTRIM(cursor_4c_MunSel.codigos), ;
1631:                                         munici   WITH ALLTRIM(cursor_4c_MunSel.descs), ;
1632:                                         uf       WITH ALLTRIM(cursor_4c_MunSel.uf), ;
1633:                                         UFIBGEs  WITH cursor_4c_MunSel.UFIBGEs
1634:                             ENDIF
1635:                             IF USED("cursor_4c_MunSel")
1636:                                 USE IN cursor_4c_MunSel
1637:                             ENDIF
1638:                         ELSE
1639:                             SELECT cursor_4c_Munis
1640:                             REPLACE munici WITH "", codibges WITH "", UFIBGEs WITH 0, uf WITH ""
1641:                         ENDIF
1642:                         IF USED("cursor_4c_BuscaMuns")
1643:                             USE IN cursor_4c_BuscaMuns
1644:                         ENDIF
1645:                     ENDIF
1646:                 ENDIF
1647:                 IF USED("cursor_4c_BuscaMun")
1648:                     USE IN cursor_4c_BuscaMun
1649:                 ENDIF
1650:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Munis.Refresh()
1651:             ENDIF
1652:         CATCH TO loException
1653:             MsgErro("Erro ao validar munic" + CHR(237) + "pio:" + CHR(13) + loException.Message, ;
1654:                 "Formrst.GradMuniMunLostFocus")

*-- Linhas 1663 a 1877:
1663: 
1664:     *===========================================================================
1665:     * GradProdCodLostFocus - Valida codigo de produto (cpros) na Column1 de grd_4c_Prods
1666:     * Busca em SigCdPro; se nao encontrado abre FormBuscaAuxiliar
1667:     *===========================================================================
1668:     PROCEDURE GradProdCodLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1669:         LOCAL loc_cCpros, loc_nResult, loc_oBusca
1670: 
1671:         IF !USED("cursor_4c_Prods") OR EOF("cursor_4c_Prods") OR BOF("cursor_4c_Prods")
1672:             RETURN
1673:         ENDIF
1674: 
1675:         SELECT cursor_4c_Prods
1676:         loc_cCpros = ALLTRIM(cursor_4c_Prods.cpros)
1677: 
1678:         IF EMPTY(loc_cCpros)
1679:             RETURN
1680:         ENDIF
1681: 
1682:         TRY
1683:             loc_nResult = SQLEXEC(gnConnHandle, ;
1684:                 "SELECT TOP 1 a.cpros, a.dpros FROM SigCdPro a" + ;
1685:                 " WHERE a.cpros = " + EscaparSQL(loc_cCpros), ;
1686:                 "cursor_4c_BuscaPro")
1687:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_BuscaPro") > 0
1688:                 SELECT cursor_4c_Prods
1689:                 REPLACE cpros WITH ALLTRIM(cursor_4c_BuscaPro.cpros), ;
1690:                         dpros WITH ALLTRIM(cursor_4c_BuscaPro.dpros)
1691:             ELSE
1692:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1693:                     "SELECT a.cpros AS codigo, a.dpros AS descricao FROM SigCdPro a" + ;
1694:                     " WHERE a.cpros LIKE " + EscaparSQL(loc_cCpros + "%") + ;
1695:                     " ORDER BY a.cpros", ;
1696:                     "cursor_4c_BuscaPros")
1697:                 IF loc_nResult < 0 OR RECCOUNT("cursor_4c_BuscaPros") = 0
1698:                     IF USED("cursor_4c_BuscaPros")
1699:                         USE IN cursor_4c_BuscaPros
1700:                     ENDIF
1701:                     SQLEXEC(gnConnHandle, ;
1702:                         "SELECT a.cpros AS codigo, a.dpros AS descricao FROM SigCdPro a" + ;
1703:                         " ORDER BY a.cpros", ;
1704:                         "cursor_4c_BuscaPros")
1705:                 ENDIF
1706:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1707:                 IF VARTYPE(loc_oBusca) = "O"
1708:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaPros", "codigo", "descricao", ;
1709:                         CHR(67) + CHR(243) + "digo do Produto")
1710:                     loc_oBusca.Mostrar()
1711:                     IF !EMPTY(ALLTRIM(loc_oBusca.cCodigoSelecionado))
1712:                         loc_nResult = SQLEXEC(gnConnHandle, ;
1713:                             "SELECT TOP 1 a.cpros, a.dpros FROM SigCdPro a" + ;
1714:                             " WHERE a.cpros = " + EscaparSQL(ALLTRIM(loc_oBusca.cCodigoSelecionado)), ;
1715:                             "cursor_4c_ProSel")
1716:                         IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ProSel") > 0
1717:                             SELECT cursor_4c_Prods
1718:                             REPLACE cpros WITH ALLTRIM(cursor_4c_ProSel.cpros), ;
1719:                                     dpros WITH ALLTRIM(cursor_4c_ProSel.dpros)
1720:                         ENDIF
1721:                         IF USED("cursor_4c_ProSel")
1722:                             USE IN cursor_4c_ProSel
1723:                         ENDIF
1724:                     ELSE
1725:                         SELECT cursor_4c_Prods
1726:                         REPLACE cpros WITH "", dpros WITH ""
1727:                     ENDIF
1728:                     IF USED("cursor_4c_BuscaPros")
1729:                         USE IN cursor_4c_BuscaPros
1730:                     ENDIF
1731:                 ENDIF
1732:             ENDIF
1733:             IF USED("cursor_4c_BuscaPro")
1734:                 USE IN cursor_4c_BuscaPro
1735:             ENDIF
1736:             THIS.pgf_4c_Paginas.Page2.grd_4c_Prods.Refresh()
1737:         CATCH TO loException
1738:             MsgErro("Erro ao validar produto:" + CHR(13) + loException.Message, ;
1739:                 "Formrst.GradProdCodLostFocus")
1740:             IF USED("cursor_4c_BuscaPro")
1741:                 USE IN cursor_4c_BuscaPro
1742:             ENDIF
1743:             IF USED("cursor_4c_BuscaPros")
1744:                 USE IN cursor_4c_BuscaPros
1745:             ENDIF
1746:         ENDTRY
1747:     ENDPROC
1748: 
1749:     *===========================================================================
1750:     * GradProdDescLostFocus - Valida descricao (dpros) na Column2 de grd_4c_Prods
1751:     * Verifica duplicidade de cpros + busca em SigCdPro por descricao
1752:     *===========================================================================
1753:     PROCEDURE GradProdDescLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1754:         LOCAL loc_cDpros, loc_cCpros, loc_nContagem, loc_nResult, loc_oBusca, loc_nRec
1755: 
1756:         IF !USED("cursor_4c_Prods") OR EOF("cursor_4c_Prods") OR BOF("cursor_4c_Prods")
1757:             RETURN
1758:         ENDIF
1759: 
1760:         SELECT cursor_4c_Prods
1761:         loc_cDpros = ALLTRIM(cursor_4c_Prods.dpros)
1762:         loc_cCpros = ALLTRIM(cursor_4c_Prods.cpros)
1763: 
1764:         IF EMPTY(loc_cDpros)
1765:             RETURN
1766:         ENDIF
1767: 
1768:         TRY
1769:             IF !EMPTY(loc_cCpros)
1770:                 *-- Verificar duplicidade: mesmo cpros em outra linha
1771:                 SELECT cursor_4c_Prods
1772:                 loc_nRec = RECNO()
1773:                 GO TOP
1774:                 loc_nContagem = 0
1775:                 SCAN FOR !DELETED()
1776:                     IF ALLTRIM(cpros) = loc_cCpros
1777:                         loc_nContagem = loc_nContagem + 1
1778:                     ENDIF
1779:                 ENDSCAN
1780:                 IF loc_nRec > 0 AND loc_nRec <= RECCOUNT("cursor_4c_Prods")
1781:                     GO (loc_nRec) IN cursor_4c_Prods
1782:                 ENDIF
1783:                 IF loc_nContagem > 1
1784:                     MsgAviso("Produto j" + CHR(225) + " adicionado a esta exclusividade.", "Aviso")
1785:                     SELECT cursor_4c_Prods
1786:                     REPLACE cpros WITH "", dpros WITH ""
1787:                 ENDIF
1788:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Prods.Refresh()
1789:             ELSE
1790:                 *-- cpros vazio: buscar produto por descricao digitada
1791:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1792:                     "SELECT a.cpros AS codigo, a.dpros AS descricao FROM SigCdPro a" + ;
1793:                     " WHERE a.dpros LIKE " + EscaparSQL(loc_cDpros + "%") + ;
1794:                     " ORDER BY a.dpros", ;
1795:                     "cursor_4c_BuscaDpros")
1796:                 IF loc_nResult < 0 OR RECCOUNT("cursor_4c_BuscaDpros") = 0
1797:                     IF USED("cursor_4c_BuscaDpros")
1798:                         USE IN cursor_4c_BuscaDpros
1799:                     ENDIF
1800:                     SQLEXEC(gnConnHandle, ;
1801:                         "SELECT a.cpros AS codigo, a.dpros AS descricao FROM SigCdPro a" + ;
1802:                         " ORDER BY a.dpros", ;
1803:                         "cursor_4c_BuscaDpros")
1804:                 ENDIF
1805:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1806:                 IF VARTYPE(loc_oBusca) = "O"
1807:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaDpros", "codigo", "descricao", ;
1808:                         "Descri" + CHR(231) + CHR(227) + "o do Produto")
1809:                     loc_oBusca.Mostrar()
1810:                     IF !EMPTY(ALLTRIM(loc_oBusca.cCodigoSelecionado))
1811:                         SELECT cursor_4c_Prods
1812:                         REPLACE cpros WITH ALLTRIM(loc_oBusca.cCodigoSelecionado), ;
1813:                                 dpros WITH ALLTRIM(loc_oBusca.cDescricaoSelecionada)
1814:                     ELSE
1815:                         SELECT cursor_4c_Prods
1816:                         REPLACE cpros WITH "", dpros WITH ""
1817:                     ENDIF
1818:                     IF USED("cursor_4c_BuscaDpros")
1819:                         USE IN cursor_4c_BuscaDpros
1820:                     ENDIF
1821:                 ENDIF
1822:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Prods.Refresh()
1823:             ENDIF
1824:         CATCH TO loException
1825:             MsgErro("Erro ao validar descri" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
1826:                 loException.Message, "Formrst.GradProdDescLostFocus")
1827:             IF USED("cursor_4c_BuscaDpros")
1828:                 USE IN cursor_4c_BuscaDpros
1829:             ENDIF
1830:         ENDTRY
1831:     ENDPROC
1832: 
1833:     *===========================================================================
1834:     * GradProdAfterRowColChange - Exibe imagem do produto selecionado em grd_4c_Prods
1835:     * LPARAMETERS obrigatorio para AfterRowColChange via BINDEVENT
1836:     *===========================================================================
1837:     PROCEDURE GradProdAfterRowColChange(par_nColIndex)
1838:         LOCAL loc_cCodPro, loc_nResult, loc_cArquivo, loc_cFoto, loc_oPg2, loc_lTemImagem
1839:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1840: 
1841:         IF !USED("cursor_4c_Prods") OR EOF("cursor_4c_Prods") OR BOF("cursor_4c_Prods")
1842:             loc_oPg2.img_4c_ImgProds.Visible = .F.
1843:             RETURN
1844:         ENDIF
1845: 
1846:         SELECT cursor_4c_Prods
1847:         loc_cCodPro = ALLTRIM(cursor_4c_Prods.cpros)
1848: 
1849:         IF EMPTY(loc_cCodPro)
1850:             loc_oPg2.img_4c_ImgProds.Visible = .F.
1851:             RETURN
1852:         ENDIF
1853: 
1854:         TRY
1855:             loc_lTemImagem = .F.
1856:             loc_nResult = SQLEXEC(gnConnHandle, ;
1857:                 "SELECT a.FigJpgs FROM SigCdPro a WHERE a.cpros = " + EscaparSQL(loc_cCodPro), ;
1858:                 "cursor_4c_ImgArc")
1859:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ImgArc") > 0
1860:                 SELECT cursor_4c_ImgArc
1861:                 IF !EMPTY(NVL(cursor_4c_ImgArc.FigJpgs, "")) AND !ISNULL(cursor_4c_ImgArc.FigJpgs)
1862:                     loc_cArquivo = SYS(2023) + "\" + goSistema.Sys2015Tmp + SYS(2015) + ".jpg"
1863:                     loc_cFoto    = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_ImgArc.FigJpgs, ;
1864:                         "data:image/png;base64,", ""), ;
1865:                         "data:image/jpeg;base64,", ""), ;
1866:                         "data:image/jpg;base64,", ""), 14)
1867:                     STRTOFILE(loc_cFoto, loc_cArquivo)
1868:                     loc_oPg2.img_4c_ImgProds.Picture = loc_cArquivo
1869:                     loc_oPg2.img_4c_ImgProds.Visible = .T.
1870:                     loc_lTemImagem = .T.
1871:                 ENDIF
1872:             ENDIF
1873:             IF USED("cursor_4c_ImgArc")
1874:                 USE IN cursor_4c_ImgArc
1875:             ENDIF
1876:             IF !loc_lTemImagem
1877:                 loc_oPg2.img_4c_ImgProds.Visible = .F.

*-- Linhas 1889 a 1996:
1889:     *===========================================================================
1890:     * BtnInserirMuniClick - Adiciona linha em branco na grade de municipios
1891:     *===========================================================================
1892:     PROCEDURE BtnInserirMuniClick()
1893:         TRY
1894:             IF !USED("cursor_4c_Munis")
1895:                 THIS.InicializarGradesVazias()
1896:             ELSE
1897:                 SELECT cursor_4c_Munis
1898:                 APPEND BLANK
1899:                 REPLACE tipos    WITH "M", ;
1900:                         pkchaves WITH "", ;
1901:                         munici   WITH "", ;
1902:                         codibges WITH "", ;
1903:                         uf       WITH "", ;
1904:                         UFIBGEs  WITH 0
1905:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Munis.Refresh()
1906:             ENDIF
1907:         CATCH TO loException
1908:             MsgErro("Erro ao inserir munic" + CHR(237) + "pio:" + CHR(13) + loException.Message, ;
1909:                 "Formrst.BtnInserirMuniClick")
1910:         ENDTRY
1911:     ENDPROC
1912: 
1913:     *===========================================================================
1914:     * BtnExcluirMuniClick - Remove municipio selecionado da grade
1915:     *===========================================================================
1916:     PROCEDURE BtnExcluirMuniClick()
1917:         IF !USED("cursor_4c_Munis") OR EOF("cursor_4c_Munis") OR BOF("cursor_4c_Munis")
1918:             MsgAviso("Selecione um munic" + CHR(237) + "pio para excluir.", "Aviso")
1919:             RETURN
1920:         ENDIF
1921:         TRY
1922:             SELECT cursor_4c_Munis
1923:             DELETE
1924:             THIS.pgf_4c_Paginas.Page2.grd_4c_Munis.Refresh()
1925:         CATCH TO loException
1926:             MsgErro("Erro ao excluir munic" + CHR(237) + "pio:" + CHR(13) + loException.Message, ;
1927:                 "Formrst.BtnExcluirMuniClick")
1928:         ENDTRY
1929:     ENDPROC
1930: 
1931:     *===========================================================================
1932:     * BtnInserirProdClick - Adiciona linha em branco na grade de produtos
1933:     *===========================================================================
1934:     PROCEDURE BtnInserirProdClick()
1935:         TRY
1936:             IF !USED("cursor_4c_Prods")
1937:                 THIS.InicializarGradesVazias()
1938:             ELSE
1939:                 SELECT cursor_4c_Prods
1940:                 APPEND BLANK
1941:                 REPLACE tipos    WITH "P", ;
1942:                         pkchaves WITH "", ;
1943:                         cpros    WITH "", ;
1944:                         dpros    WITH ""
1945:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Prods.Refresh()
1946:             ENDIF
1947:         CATCH TO loException
1948:             MsgErro("Erro ao inserir produto:" + CHR(13) + loException.Message, ;
1949:                 "Formrst.BtnInserirProdClick")
1950:         ENDTRY
1951:     ENDPROC
1952: 
1953:     *===========================================================================
1954:     * BtnExcluirProdClick - Remove produto selecionado da grade
1955:     *===========================================================================
1956:     PROCEDURE BtnExcluirProdClick()
1957:         IF !USED("cursor_4c_Prods") OR EOF("cursor_4c_Prods") OR BOF("cursor_4c_Prods")
1958:             MsgAviso("Selecione um produto para excluir.", "Aviso")
1959:             RETURN
1960:         ENDIF
1961:         TRY
1962:             SELECT cursor_4c_Prods
1963:             DELETE
1964:             THIS.pgf_4c_Paginas.Page2.grd_4c_Prods.Refresh()
1965:         CATCH TO loException
1966:             MsgErro("Erro ao excluir produto:" + CHR(13) + loException.Message, ;
1967:                 "Formrst.BtnExcluirProdClick")
1968:         ENDTRY
1969:     ENDPROC
1970: 
1971:     *===========================================================================
1972:     * AjustarBotoesPorModo - Ajusta estado dos botoes de acao conforme modo atual
1973:     * INCLUIR/ALTERAR -> Confirmar habilitado; VISUALIZAR -> Confirmar desabilitado
1974:     *===========================================================================
1975:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1976:         LOCAL loc_oPg2, loc_lEditando
1977:         TRY
1978:             loc_oPg2      = THIS.pgf_4c_Paginas.Page2
1979:             loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1980: 
1981:             loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = loc_lEditando OR (THIS.this_cModoAtual = "EXCLUIR")
1982:             loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
1983: 
1984:             loc_oPg2.cmd_4c_InserirMuni.Enabled = loc_lEditando
1985:             loc_oPg2.cmd_4c_ExcluirMuni.Enabled = loc_lEditando
1986:             loc_oPg2.cmd_4c_InserirProd.Enabled = loc_lEditando
1987:             loc_oPg2.cmd_4c_ExcluirProd.Enabled = loc_lEditando
1988:             loc_oPg2.grd_4c_Munis.ReadOnly       = !loc_lEditando
1989:             loc_oPg2.grd_4c_Prods.ReadOnly       = !loc_lEditando
1990:         CATCH TO loException
1991:             MsgErro("Erro ao ajustar bot" + CHR(245) + "es:" + CHR(13) + loException.Message, ;
1992:                 "Formrst.AjustarBotoesPorModo")
1993:         ENDTRY
1994:     ENDPROC
1995: 
1996: ENDDEFINE


### BO (C:\4c\projeto\app\classes\rstBO.prg):
*==============================================================================
* rstBO.prg - Business Object para Exclusividade Por Contas (SigCdRst/SigCdRsi)
* Herda de BusinessBase
*==============================================================================

DEFINE CLASS rstBO AS BusinessBase

    *-- SigCdRst - Propriedades principais
    this_cSkChaves  = ""    && skchaves  C(20) PK
    this_cIclis     = ""    && iclis     C(10) FK SigCdCli
    this_nChkMatrs  = 0     && chkmatrs  N(1,0) Checa Matriz (op_con)
    this_dDatas     = {}    && datas     D nullable
    this_dDtAlts    = {}    && dtalts    D nullable (auditoria)

    *-- Propriedade derivada (JOIN SigCdCli) - somente exibicao
    this_cRclis     = ""    && Rclis C(40) nome do cliente

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdRst"
            THIS.this_cCampoChave = "skChaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da PK para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cSkChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - SELECT lista de exclusividades com nome do cliente
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            loc_cSQL = "SELECT a.skchaves, a.iclis, ISNULL(b.Rclis,'') AS Rclis," + ;
                       " a.chkmatrs, a.datas, a.dtalts" + ;
                       " FROM SigCdRst a" + ;
                       " LEFT JOIN SigCdCli b ON b.Iclis = a.Iclis" + ;
                       " ORDER BY b.Rclis"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar exclusividades:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                SET NULL ON
                CREATE CURSOR cursor_4c_Dados (skchaves C(20), iclis C(10), Rclis C(40), ;
                    chkmatrs N(1,0), datas T, dtalts T)
                SET NULL OFF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro SigCdRst por skChaves
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cSkChaves)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT a.skchaves, a.iclis, ISNULL(b.Rclis,'') AS Rclis," + ;
                       " a.chkmatrs, a.datas, a.dtalts" + ;
                       " FROM SigCdRst a" + ;
                       " LEFT JOIN SigCdCli b ON b.Iclis = a.Iclis" + ;
                       " WHERE a.skchaves = " + EscaparSQL(par_cSkChaves)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                MsgErro("Registro n" + CHR(227) + "o encontrado.", "Aviso")
            ENDIF
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cSkChaves = TratarNulo(skchaves, "C")
            THIS.this_cIclis    = TratarNulo(iclis,    "C")
            THIS.this_cRclis    = TratarNulo(Rclis,    "C")
            THIS.this_nChkMatrs = TratarNulo(chkmatrs, "N")
            THIS.this_dDatas    = TratarNulo(datas,    "D")
            THIS.this_dDtAlts   = TratarNulo(dtalts,   "D")
            loc_lResultado = .T.
        ENDIF
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarMunicipios - Carrega SigCdRsi tipo 'M' para o skChaves dado
    * Popula cursor_4c_Munis com: skchaves, pkchaves, codibges, tipos, UFIBGEs, munici, uf
    *--------------------------------------------------------------------------
    FUNCTION BuscarMunicipios(par_cSkChaves)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_Munis")
                USE IN cursor_4c_Munis
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Munis (skchaves C(20), pkchaves C(20), codibges C(7), ;
                tipos C(1), UFIBGEs N(2,0), munici C(40), uf C(2))
            SET NULL OFF

            IF !EMPTY(par_cSkChaves)
                loc_cSQL = "SELECT DISTINCT a.skchaves, a.pkchaves, a.codibges, a.tipos," + ;
                           " a.ufibges AS UFIBGEs," + ;
                           " ISNULL(c.descs,'') AS munici, ISNULL(d.estados,'') AS uf" + ;
                           " FROM SigCdRsi a" + ;
                           " LEFT JOIN SigCdMun c ON c.codigos = a.codibges" + ;
                           " LEFT JOIN SigCdUfs d ON d.ufibges = a.ufibges" + ;
                           " WHERE a.skchaves = " + EscaparSQL(par_cSkChaves) + " AND a.tipos = 'M'"
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_MunisTmp")
                    TABLEREVERT(.T., "cursor_4c_MunisTmp")
                    USE IN cursor_4c_MunisTmp
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MunisTmp")
                IF loc_nResult >= 0
                    SELECT cursor_4c_MunisTmp
                    SCAN
                        SELECT cursor_4c_Munis
                        APPEND BLANK
                        REPLACE skchaves WITH ALLTRIM(NVL(cursor_4c_MunisTmp.skchaves, "")), ;
                                pkchaves WITH ALLTRIM(NVL(cursor_4c_MunisTmp.pkchaves, "")), ;
                                codibges WITH ALLTRIM(NVL(cursor_4c_MunisTmp.codibges, "")), ;
                                tipos    WITH ALLTRIM(NVL(cursor_4c_MunisTmp.tipos, "")), ;
                                UFIBGEs  WITH NVL(cursor_4c_MunisTmp.UFIBGEs, 0), ;
                                munici   WITH ALLTRIM(NVL(cursor_4c_MunisTmp.munici, "")), ;
                                uf       WITH ALLTRIM(NVL(cursor_4c_MunisTmp.uf, ""))
                        SELECT cursor_4c_MunisTmp
                    ENDSCAN
                    IF USED("cursor_4c_MunisTmp")
                        USE IN cursor_4c_MunisTmp
                    ENDIF
                ENDIF
            ENDIF

            SELECT cursor_4c_Munis
            IF RECCOUNT() = 0
                APPEND BLANK
            ENDIF
            GO TOP IN cursor_4c_Munis
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar munic" + CHR(237) + "pios:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_MunisTmp")
                USE IN cursor_4c_MunisTmp
            ENDIF
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarProdutos - Carrega SigCdRsi tipo 'P' para o skChaves dado
    * Popula cursor_4c_Prods com: skchaves, pkchaves, cpros, dpros, tipos
    *--------------------------------------------------------------------------
    FUNCTION BuscarProdutos(par_cSkChaves)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_Prods")
                USE IN cursor_4c_Prods
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Prods (skchaves C(20), pkchaves C(20), cpros C(14), ;
                dpros C(40), tipos C(1))
            SET NULL OFF

            IF !EMPTY(par_cSkChaves)
                loc_cSQL = "SELECT DISTINCT a.skchaves, a.pkchaves, a.cpros," + ;
                           " ISNULL(c.dpros,'') AS dpros, a.tipos" + ;
                           " FROM SigCdRsi a" + ;
                           " LEFT JOIN SigCdPro c ON c.cpros = a.cpros" + ;
                           " WHERE a.skchaves = " + EscaparSQL(par_cSkChaves) + " AND a.tipos = 'P'"
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_ProdsTmp")
                    TABLEREVERT(.T., "cursor_4c_ProdsTmp")
                    USE IN cursor_4c_ProdsTmp
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdsTmp")
                IF loc_nResult >= 0
                    SELECT cursor_4c_ProdsTmp
                    SCAN
                        SELECT cursor_4c_Prods
                        APPEND BLANK
                        REPLACE skchaves WITH ALLTRIM(NVL(cursor_4c_ProdsTmp.skchaves, "")), ;
                                pkchaves WITH ALLTRIM(NVL(cursor_4c_ProdsTmp.pkchaves, "")), ;
                                cpros    WITH ALLTRIM(NVL(cursor_4c_ProdsTmp.cpros, "")), ;
                                dpros    WITH ALLTRIM(NVL(cursor_4c_ProdsTmp.dpros, "")), ;
                                tipos    WITH ALLTRIM(NVL(cursor_4c_ProdsTmp.tipos, ""))
                        SELECT cursor_4c_ProdsTmp
                    ENDSCAN
                    IF USED("cursor_4c_ProdsTmp")
                        USE IN cursor_4c_ProdsTmp
                    ENDIF
                ENDIF
            ENDIF

            SELECT cursor_4c_Prods
            IF RECCOUNT() = 0
                APPEND BLANK
            ENDIF
            GO TOP IN cursor_4c_Prods
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar produtos:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_ProdsTmp")
                USE IN cursor_4c_ProdsTmp
            ENDIF
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarContaCadastrada - Checa se Iclis ja tem exclusividade em SigCdRst
    *--------------------------------------------------------------------------
    FUNCTION VerificarContaCadastrada(par_cIclis)
        LOCAL loc_lExiste, loc_nResult
        loc_lExiste = .F.
        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 skchaves FROM SigCdRst WHERE iclis = " + EscaparSQL(par_cIclis), ;
                "cursor_4c_ChkRst")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ChkRst") > 0
                loc_lExiste = .T.
            ENDIF
            IF USED("cursor_4c_ChkRst")
                USE IN cursor_4c_ChkRst
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_ChkRst")
                USE IN cursor_4c_ChkRst
            ENDIF
        ENDTRY
        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarChaveUnica - Gera chave C(20) via NEWID do SQL Server
    *--------------------------------------------------------------------------
    FUNCTION GerarChaveUnica()
        LOCAL loc_cChave, loc_nResult
        loc_cChave = ""
        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT LEFT(REPLACE(CAST(NEWID() AS VARCHAR(36)),'-',''),20) AS novachave", ;
                "cursor_4c_NewId")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_NewId") > 0
                SELECT cursor_4c_NewId
                loc_cChave = ALLTRIM(novachave)
            ENDIF
            IF USED("cursor_4c_NewId")
                USE IN cursor_4c_NewId
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao gerar chave:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_NewId")
                USE IN cursor_4c_NewId
            ENDIF
        ENDTRY
        RETURN loc_cChave
    ENDFUNC

    *--------------------------------------------------------------------------
    * InserirItensSigCdRsi - INSERT SigCdRsi de cursor_4c_Munis e cursor_4c_Prods
    * Metodo auxiliar compartilhado por Inserir() e Atualizar()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InserirItensSigCdRsi()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cPkChave
        loc_lResultado = .T.

        *-- INSERT municipios (tipo 'M')
        IF USED("cursor_4c_Munis")
            SELECT cursor_4c_Munis
            GO TOP
            SCAN
                IF !EMPTY(ALLTRIM(cursor_4c_Munis.codibges)) OR cursor_4c_Munis.UFIBGEs <> 0
                    loc_cPkChave = THIS.GerarChaveUnica()
                    IF EMPTY(loc_cPkChave)
                        loc_lResultado = .F.
                    ELSE
                        loc_cSQL = "INSERT INTO SigCdRsi" + ;
                                   " (skchaves, pkchaves, codibges, tipos, ufibges, cpros, dtalts)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(THIS.this_cSkChaves) + "," + ;
                                   EscaparSQL(loc_cPkChave) + "," + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Munis.codibges)) + "," + ;
                                   "'M'," + ;
                                   FormatarNumeroSQL(cursor_4c_Munis.UFIBGEs) + "," + ;
                                   "''," + ;
                                   "GETDATE())"
                        *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                        IF USED("cursor_4c_InsRsi")
                            TABLEREVERT(.T., "cursor_4c_InsRsi")
                            USE IN cursor_4c_InsRsi
                        ENDIF

                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsRsi")
                        IF USED("cursor_4c_InsRsi")
                            USE IN cursor_4c_InsRsi
                        ENDIF
                        IF loc_nResult < 0
                            MsgErro("Erro ao inserir munic" + CHR(237) + "pio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            loc_lResultado = .F.
                        ENDIF
                    ENDIF
                ENDIF
                SELECT cursor_4c_Munis
            ENDSCAN
        ENDIF

        *-- INSERT produtos (tipo 'P')
        IF USED("cursor_4c_Prods")
            SELECT cursor_4c_Prods
            GO TOP
            SCAN
                IF !EMPTY(ALLTRIM(cursor_4c_Prods.cpros))
                    loc_cPkChave = THIS.GerarChaveUnica()
                    IF EMPTY(loc_cPkChave)
                        loc_lResultado = .F.
                    ELSE
                        loc_cSQL = "INSERT INTO SigCdRsi" + ;
                                   " (skchaves, pkchaves, codibges, tipos, ufibges, cpros, dtalts)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(THIS.this_cSkChaves) + "," + ;
                                   EscaparSQL(loc_cPkChave) + "," + ;
                                   "''," + ;
                                   "'P'," + ;
                                   "0," + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Prods.cpros)) + "," + ;
                                   "GETDATE())"
                        *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                        IF USED("cursor_4c_InsRsi")
                            TABLEREVERT(.T., "cursor_4c_InsRsi")
                            USE IN cursor_4c_InsRsi
                        ENDIF

                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsRsi")
                        IF USED("cursor_4c_InsRsi")
                            USE IN cursor_4c_InsRsi
                        ENDIF
                        IF loc_nResult < 0
                            MsgErro("Erro ao inserir produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            loc_lResultado = .F.
                        ENDIF
                    ENDIF
                ENDIF
                SELECT cursor_4c_Prods
            ENDSCAN
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdRst + INSERT SigCdRsi de cursor_4c_Munis e cursor_4c_Prods
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.
        TRY
            loc_cSQL = THIS.GerarChaveUnica()
            IF EMPTY(loc_cSQL)
                MsgErro("Erro ao gerar chave prim" + CHR(225) + "ria.", "Erro")
            ELSE
                THIS.this_cSkChaves = loc_cSQL

                loc_cSQL = "INSERT INTO SigCdRst (skchaves, iclis, chkmatrs, datas, dtalts)" + ;
                           " VALUES (" + ;
                           EscaparSQL(THIS.this_cSkChaves) + "," + ;
                           EscaparSQL(THIS.this_cIclis) + "," + ;
                           FormatarNumeroSQL(THIS.this_nChkMatrs) + "," + ;
                           "GETDATE(), NULL)"
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_InsRst")
                    TABLEREVERT(.T., "cursor_4c_InsRst")
                    USE IN cursor_4c_InsRst
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsRst")
                IF USED("cursor_4c_InsRst")
                    USE IN cursor_4c_InsRst
                ENDIF

                IF loc_nResult >= 0
                    IF THIS.InserirItensSigCdRsi()
                        THIS.RegistrarAuditoria("INSERT")
                        loc_lResultado = .T.
                    ENDIF
                ELSE
                    MsgErro("Erro ao inserir exclusividade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigCdRst + DELETE SigCdRsi + INSERT SigCdRsi novos itens
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.
        TRY
            *-- DELETE SigCdRsi antigos
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "DELETE FROM SigCdRsi WHERE skchaves = " + EscaparSQL(THIS.this_cSkChaves), ;
                "cursor_4c_DelRsi")
            IF USED("cursor_4c_DelRsi")
                USE IN cursor_4c_DelRsi
            ENDIF

            IF loc_nResult >= 0
                *-- UPDATE SigCdRst
                loc_cSQL = "UPDATE SigCdRst SET" + ;
                           " iclis = " + EscaparSQL(THIS.this_cIclis) + "," + ;
                           " chkmatrs = " + FormatarNumeroSQL(THIS.this_nChkMatrs) + "," + ;
                           " dtalts = GETDATE()" + ;
                           " WHERE skchaves = " + EscaparSQL(THIS.this_cSkChaves)
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_UpdRst")
                    TABLEREVERT(.T., "cursor_4c_UpdRst")
                    USE IN cursor_4c_UpdRst
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdRst")
                IF USED("cursor_4c_UpdRst")
                    USE IN cursor_4c_UpdRst
                ENDIF

                IF loc_nResult >= 0
                    IF THIS.InserirItensSigCdRsi()
                        THIS.RegistrarAuditoria("UPDATE")
                        loc_lResultado = .T.
                    ENDIF
                ELSE
                    MsgErro("Erro ao atualizar exclusividade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MsgErro("Erro ao limpar itens da exclusividade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE SigCdRsi e SigCdRst (nesta ordem - FK constraint)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_nResult
        loc_lResultado = .F.
        TRY
            *-- DELETE SigCdRsi primeiro (filho)
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "DELETE FROM SigCdRsi WHERE skchaves = " + EscaparSQL(THIS.this_cSkChaves), ;
                "cursor_4c_DelRsi2")
            IF USED("cursor_4c_DelRsi2")
                USE IN cursor_4c_DelRsi2
            ENDIF

            IF loc_nResult >= 0
                *-- DELETE SigCdRst (pai)
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "DELETE FROM SigCdRst WHERE skchaves = " + EscaparSQL(THIS.this_cSkChaves), ;
                    "cursor_4c_DelRst")
                IF USED("cursor_4c_DelRst")
                    USE IN cursor_4c_DelRst
                ENDIF

                IF loc_nResult >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao excluir exclusividade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MsgErro("Erro ao excluir itens da exclusividade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

