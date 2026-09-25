# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (19)
- [BINDEVENT-PARAMS] Handler 'ValidarDataInicial' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarDataInicial(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarDataFinal' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarDataFinal(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarGrupo' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarGrupo(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarConta' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarConta(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarDconta' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarDconta(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarMoeda' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarMoeda(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarValor' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarValor(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarCotacao' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarCotacao(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarJob' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarJob(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarSGrupo' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarSGrupo(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarSConta' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarSConta(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarSDconta' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarSDconta(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarSValor' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarSValor(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarSmoeda' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarSmoeda(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarSCotacao' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarSCotacao(par_nKeyCode, par_nShiftAltCtrl)
- [GRID-HEADER] Header Caption ' ' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Data, Conta, Contrapartida, Histórico, Débito, Crédito, , NF, Documento, O. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption ' ' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Data, Conta, Contrapartida, Histórico, Débito, Crédito, , NF, Documento, O. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGMVCCR.Pagina.Lista.cntFiltros.Cnt_periodo): Top original=10 vs migrado 'lbl_4c_Label17' Top=220 (diff=210px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGMVCCR.Pagina.Lista.cntFiltros.Cnt_periodo): Left original=17 vs migrado 'lbl_4c_Label17' Left=84 (diff=67px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigmvccr.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2555 linhas total):

*-- Linhas 23 a 155:
23: 
24:     *-- Controle de dedup dos handlers de LostFocus (evita reabrir lookup/
25:     *-- refazer validacao quando o campo perde foco sem o valor ter mudado)
26:     this_cUltimoGrupoValidado    = ""
27:     this_cUltimaContaValidada    = ""
28:     this_cUltimaMoedaValidada    = ""
29:     this_cUltimoSGrupoValidado   = ""
30:     this_cUltimaSContaValidada   = ""
31:     this_cUltimaSMoedaValidada   = ""
32:     this_cUltimoJobValidado      = ""
33: 
34:     *===========================================================================
35:     * Init - Inicializa o formulario
36:     * REGRA CRITICA: Apenas RETURN DODEFAULT()
37:     * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
38:     *===========================================================================
39:     PROCEDURE Init()
40:         RETURN DODEFAULT()
41:     ENDPROC
42: 
43:     *===========================================================================
44:     * InicializarForm - Configura estrutura completa
45:     * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
46:     *===========================================================================
47:     PROTECTED PROCEDURE InicializarForm()
48:         LOCAL loc_lSucesso
49:         loc_lSucesso = .F.
50: 
51:         TRY
52:             THIS.this_oBusinessObject = CREATEOBJECT("sigmvccrBO")
53: 
54:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
55:                 MostrarErro("Erro ao criar sigmvccrBO" + CHR(13) + ;
56:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
57:                     "Formsigmvccr.InicializarForm")
58:             ELSE
59:                 THIS.ConfigurarPageFrame()
60:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
61:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
62:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
63:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
64:                 THIS.pgf_4c_Paginas.Visible = .T.
65:                 THIS.pgf_4c_Paginas.ActivePage = 1
66:                 THIS.this_cModoAtual = "LISTA"
67:                 THIS.CarregarLista()
68: 
69:                 loc_lSucesso = .T.
70:             ENDIF
71: 
72:         CATCH TO loException
73:             MostrarErro("Erro ao inicializar Formsigmvccr:" + CHR(13) + ;
74:                 loException.Message + CHR(13) + ;
75:                 "Linha: " + TRANSFORM(loException.LineNo), ;
76:                 "Formsigmvccr.InicializarForm")
77:         ENDTRY
78: 
79:         RETURN loc_lSucesso
80:     ENDPROC
81: 
82:     *===========================================================================
83:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
84:     * Top=-29 para esconder abas; controles compensam +29 no Top
85:     *===========================================================================
86:     PROTECTED PROCEDURE ConfigurarPageFrame()
87:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
88: 
89:         WITH THIS.pgf_4c_Paginas
90:             .PageCount = 2
91:             .Top       = -29
92:             .Left      = 0
93:             .Width     = THIS.Width
94:             .Height    = THIS.Height + 29
95:             .Tabs      = .F.
96:             .Visible   = .T.
97: 
98:             .Page1.Caption   = "Lista"
99:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
100:             .Page1.BackColor = RGB(255, 255, 255)
101: 
102:             .Page2.Caption   = "Dados"
103:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
104:             .Page2.BackColor = RGB(255, 255, 255)
105:         ENDWITH
106: 
107:         THIS.ConfigurarPaginaLista()
108:         THIS.ConfigurarPaginaDados()
109:     ENDPROC
110: 
111:     *===========================================================================
112:     * ConfigurarPaginaLista - Estrutura completa de Page1 (Lista)
113:     * Cabecalho, filtro de periodo, grid de lancamentos e botoes CRUD
114:     *===========================================================================
115:     PROTECTED PROCEDURE ConfigurarPaginaLista()
116:         LOCAL loc_oPagina, loc_oCnt, loc_oCntP, loc_oGrid
117:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
118: 
119:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
120: 
121:         *-- Container Cabecalho (cntSombra no legado)
122:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
123:         WITH loc_oPagina.cnt_4c_Cabecalho
124:             .Top         = 31
125:             .Left        = 0
126:             .Width       = THIS.Width
127:             .Height      = 80
128:             .BackColor   = RGB(100, 100, 100)
129:             .BorderWidth = 0
130:             .Visible     = .T.
131:         ENDWITH
132: 
133:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
134:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
135:             .Caption   = THIS.Caption
136:             .Top       = 15
137:             .Left      = 10
138:             .Width     = 769
139:             .Height    = 40
140:             .FontName  = "Tahoma"
141:             .FontSize  = 16
142:             .FontBold  = .T.
143:             .ForeColor = RGB(0, 0, 0)
144:             .BackStyle = 0
145:             .AutoSize  = .F.
146:             .Visible   = .T.
147:         ENDWITH
148: 
149:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
150:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
151:             .Caption   = THIS.Caption
152:             .Top       = 18
153:             .Left      = 10
154:             .Width     = 769
155:             .Height    = 46

*-- Linhas 194 a 358:
194:             .SpecialEffect   = 0
195:             .Visible         = .T.
196:         ENDWITH
197:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
198: 
199:         *-- Botao Visualizar
200:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
201:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
202:             .Caption         = "Visualizar"
203:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
204:             .PicturePosition = 13
205:             .Top             = 5
206:             .Left            = 80
207:             .Width           = 75
208:             .Height          = 75
209:             .FontName        = "Comic Sans MS"
210:             .FontSize        = 8
211:             .FontBold        = .T.
212:             .FontItalic      = .T.
213:             .ForeColor       = RGB(90, 90, 90)
214:             .BackColor       = RGB(255, 255, 255)
215:             .Themes          = .F.
216:             .SpecialEffect   = 0
217:             .Visible         = .T.
218:         ENDWITH
219:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
220: 
221:         *-- Botao Alterar
222:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
223:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
224:             .Caption         = "Alterar"
225:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
226:             .PicturePosition = 13
227:             .Top             = 5
228:             .Left            = 155
229:             .Width           = 75
230:             .Height          = 75
231:             .FontName        = "Comic Sans MS"
232:             .FontSize        = 8
233:             .FontBold        = .T.
234:             .FontItalic      = .T.
235:             .ForeColor       = RGB(90, 90, 90)
236:             .BackColor       = RGB(255, 255, 255)
237:             .Themes          = .F.
238:             .SpecialEffect   = 0
239:             .Visible         = .T.
240:         ENDWITH
241:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
242: 
243:         *-- Botao Excluir
244:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
245:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
246:             .Caption         = "Excluir"
247:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
248:             .PicturePosition = 13
249:             .Top             = 5
250:             .Left            = 230
251:             .Width           = 75
252:             .Height          = 75
253:             .FontName        = "Comic Sans MS"
254:             .FontSize        = 8
255:             .FontBold        = .T.
256:             .FontItalic      = .T.
257:             .ForeColor       = RGB(90, 90, 90)
258:             .BackColor       = RGB(255, 255, 255)
259:             .Themes          = .F.
260:             .SpecialEffect   = 0
261:             .Visible         = .T.
262:         ENDWITH
263:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
264: 
265:         *-- Botao Buscar
266:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
267:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
268:             .Caption         = "Buscar"
269:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
270:             .PicturePosition = 13
271:             .Top             = 5
272:             .Left            = 305
273:             .Width           = 75
274:             .Height          = 75
275:             .FontName        = "Comic Sans MS"
276:             .FontSize        = 8
277:             .FontBold        = .T.
278:             .FontItalic      = .T.
279:             .ForeColor       = RGB(90, 90, 90)
280:             .BackColor       = RGB(255, 255, 255)
281:             .Themes          = .F.
282:             .SpecialEffect   = 0
283:             .Visible         = .T.
284:         ENDWITH
285:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
286: 
287:         *-- Container de Saida (canonico CLAUDE.md regra #10 - prevalece sobre PILAR 1)
288:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
289:         WITH loc_oPagina.cnt_4c_Saida
290:             .Top         = 29
291:             .Left        = 917
292:             .Width       = 90
293:             .Height      = 85
294:             .BackStyle   = 0
295:             .BorderWidth = 0
296:             .Visible     = .T.
297:         ENDWITH
298: 
299:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
300:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
301:             .Caption         = "Encerrar"
302:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
303:             .PicturePosition = 13
304:             .Top             = 5
305:             .Left            = 5
306:             .Width           = 75
307:             .Height          = 75
308:             .FontName        = "Comic Sans MS"
309:             .FontSize        = 8
310:             .FontBold        = .T.
311:             .FontItalic      = .T.
312:             .ForeColor       = RGB(90, 90, 90)
313:             .BackColor       = RGB(255, 255, 255)
314:             .Themes          = .F.
315:             .SpecialEffect   = 0
316:             .Visible         = .T.
317:         ENDWITH
318:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
319: 
320:         *-- Filtro de periodo (legado: cntFiltros.Top=83, Cnt_periodo Left=14,Top=-3)
321:         loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
322:         loc_oCnt = loc_oPagina.cnt_4c_Filtros
323:         WITH loc_oCnt
324:             .Top         = 112
325:             .Left        = 5
326:             .Width       = 642
327:             .Height      = 29
328:             .BackStyle   = 0
329:             .BorderWidth = 0
330:             .Visible     = .T.
331:         ENDWITH
332: 
333:         loc_oCnt.AddObject("cnt_4c__periodo", "Container")
334:         loc_oCntP = loc_oCnt.cnt_4c__periodo
335:         WITH loc_oCntP
336:             .Top         = -3
337:             .Left        = 14
338:             .Width       = 271
339:             .Height      = 36
340:             .BackStyle   = 0
341:             .BorderWidth = 0
342:             .Visible     = .T.
343:         ENDWITH
344: 
345:         loc_oCntP.AddObject("lbl_4c_Label1", "Label")
346:         WITH loc_oCntP.lbl_4c_Label1
347:             .Caption   = "Per" + CHR(237) + "odo : "
348:             .Top       = 10
349:             .Left      = 17
350:             .Width     = 54
351:             .Height    = 15
352:             .AutoSize  = .F.
353:             .FontName  = "Tahoma"
354:             .FontSize  = 8
355:             .ForeColor = RGB(90, 90, 90)
356:             .BackStyle = 0
357:             .Visible   = .T.
358:         ENDWITH

*-- Linhas 368 a 439:
368:             .FontSize  = 8
369:             .Visible   = .T.
370:         ENDWITH
371:         BINDEVENT(loc_oCntP.txt_4c_Dt_inicial, "KeyPress", THIS, "ValidarDataInicial")
372: 
373:         loc_oCntP.AddObject("lbl_4c_Label2", "Label")
374:         WITH loc_oCntP.lbl_4c_Label2
375:             .Caption   = "at" + CHR(233)
376:             .Top       = 10
377:             .Left      = 158
378:             .Width     = 20
379:             .Height    = 15
380:             .AutoSize  = .F.
381:             .FontName  = "Tahoma"
382:             .FontSize  = 8
383:             .ForeColor = RGB(90, 90, 90)
384:             .BackStyle = 0
385:             .Visible   = .T.
386:         ENDWITH
387: 
388:         loc_oCntP.AddObject("txt_4c_Dt_final", "TextBox")
389:         WITH loc_oCntP.txt_4c_Dt_final
390:             .Top       = 6
391:             .Left      = 184
392:             .Width     = 80
393:             .Height    = 21
394:             .Value     = DATE()
395:             .FontName  = "Tahoma"
396:             .FontSize  = 8
397:             .Visible   = .T.
398:         ENDWITH
399:         BINDEVENT(loc_oCntP.txt_4c_Dt_final, "KeyPress", THIS, "ValidarDataFinal")
400: 
401:         *-- Grid de lancamentos (legado: Grade Top=115,Left=23,Width=944,Height=473)
402:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
403:         loc_oGrid = loc_oPagina.grd_4c_Lista
404:         WITH loc_oGrid
405:             .Top                = 144
406:             .Left               = 23
407:             .Width              = 944
408:             .Height             = 473
409:             .ColumnCount        = 11
410:             .RecordSourceType   = 1
411:             .ReadOnly           = .T.
412:             .DeleteMark         = .F.
413:             .RecordMark         = .F.
414:             .ScrollBars         = 2
415:             .GridLines          = 3
416:             .GridLineColor      = RGB(238, 238, 238)
417:             .HighlightBackColor = RGB(255, 255, 255)
418:             .HighlightForeColor = RGB(15, 41, 104)
419:             .HighlightStyle     = 2
420:             .RowHeight          = 16
421:             .FontName           = "Tahoma"
422:             .FontSize           = 8
423:             .Visible            = .T.
424: 
425:             .Column1.Width      = 78
426:             .Column1.Alignment  = 2
427:             .Column1.FontSize   = 8
428:             .Column1.ReadOnly   = .T.
429:             .Column1.Header1.Caption   = "Data"
430:             .Column1.Header1.Alignment = 2
431:             .Column1.Header1.ForeColor = RGB(90, 90, 90)
432: 
433:             .Column2.Width      = 83
434:             .Column2.FontSize   = 8
435:             .Column2.ReadOnly   = .T.
436:             .Column2.Header1.Caption   = "Conta"
437:             .Column2.Header1.Alignment = 2
438:             .Column2.Header1.ForeColor = RGB(90, 90, 90)
439: 

*-- Linhas 504 a 554:
504:             .Column11.Header1.ForeColor = RGB(90, 90, 90)
505:         ENDWITH
506: 
507:         THIS.TornarControlesVisiveis(loc_oPagina)
508:     ENDPROC
509: 
510:     *===========================================================================
511:     * ConfigurarPaginaDados - Estrutura base de Page2 (Dados)
512:     * Campos e botoes de acao serao adicionados nas proximas fases
513:     *===========================================================================
514:     PROTECTED PROCEDURE ConfigurarPaginaDados()
515:         LOCAL loc_oPagina
516:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
517: 
518:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
519: 
520:         *-- Cabecalho cinza (identico ao da pagina Lista) - CLAUDE.md regra #11
521:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
522:         WITH loc_oPagina.cnt_4c_Cabecalho
523:             .Top           = 29
524:             .Left          = 0
525:             .Width         = THIS.Width
526:             .Height        = 80
527:             .BackColor     = RGB(100, 100, 100)
528:             .BorderWidth   = 0
529:             .SpecialEffect = 0
530:             .Visible       = .T.
531: 
532:             .AddObject("lbl_4c_Sombra", "Label")
533:             WITH .lbl_4c_Sombra
534:                 .Caption   = THIS.Caption
535:                 .Top       = 15
536:                 .Left      = 10
537:                 .Width     = THIS.Width
538:                 .Height    = 40
539:                 .FontName  = "Tahoma"
540:                 .FontSize  = 16
541:                 .FontBold  = .T.
542:                 .ForeColor = RGB(0, 0, 0)
543:                 .BackStyle = 0
544:                 .AutoSize  = .F.
545:                 .Visible   = .T.
546:             ENDWITH
547: 
548:             .AddObject("lbl_4c_Titulo", "Label")
549:             WITH .lbl_4c_Titulo
550:                 .Caption   = THIS.Caption
551:                 .Top       = 18
552:                 .Left      = 10
553:                 .Width     = THIS.Width
554:                 .Height    = 46

*-- Linhas 597 a 662:
597:             .SpecialEffect   = 0
598:             .Visible         = .T.
599:         ENDWITH
600:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
601: 
602:         *-- Botao Cancelar
603:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
604:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
605:             .Caption         = "Encerrar"
606:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
607:             .PicturePosition = 13
608:             .Top             = 5
609:             .Left            = 80
610:             .Width           = 75
611:             .Height          = 75
612:             .FontName        = "Comic Sans MS"
613:             .FontSize        = 8
614:             .FontBold        = .T.
615:             .FontItalic      = .T.
616:             .ForeColor       = RGB(90, 90, 90)
617:             .BackColor       = RGB(255, 255, 255)
618:             .Themes          = .F.
619:             .SpecialEffect   = 0
620:             .Visible         = .T.
621:         ENDWITH
622:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
623: 
624:         *-- Shape1 (legado Top=153,Left=9,Width=980,Height=64) - moldura da linha superior
625:         loc_oPagina.AddObject("shp_4c_Shape1", "Shape")
626:         WITH loc_oPagina.shp_4c_Shape1
627:             .Top    = 182
628:             .Left   = 9
629:             .Width  = 980
630:             .Height = 64
631:             .Visible = .T.
632:         ENDWITH
633: 
634:         *-- Shape3 (legado Top=224,Left=9,Width=485,Height=117) - moldura do painel D (lado esquerdo)
635:         loc_oPagina.AddObject("shp_4c_Shape3", "Shape")
636:         WITH loc_oPagina.shp_4c_Shape3
637:             .Top    = 253
638:             .Left   = 9
639:             .Width  = 485
640:             .Height = 117
641:             .Visible = .T.
642:         ENDWITH
643: 
644:         *-- Linha superior: Lancamento / Vencimento / Emissao / Nota Fiscal / Documento / Usuario / Job
645:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
646:         WITH loc_oPagina.lbl_4c_Label1
647:             .Caption   = "Lan" + CHR(231) + "amento :"
648:             .Top       = 194
649:             .Left      = 43
650:             .Width     = 65
651:             .Height    = 15
652:             .AutoSize  = .F.
653:             .FontName  = "Tahoma"
654:             .FontSize  = 8
655:             .ForeColor = RGB(90, 90, 90)
656:             .BackStyle = 0
657:             .Visible   = .T.
658:         ENDWITH
659: 
660:         loc_oPagina.AddObject("txt_4c_Fweditdata_DATA", "TextBox")
661:         WITH loc_oPagina.txt_4c_Fweditdata_DATA
662:             .Top      = 190

*-- Linhas 1062 a 1115:
1062:             .Themes    = .F.
1063:             .Visible   = .T.
1064:         ENDWITH
1065:         BINDEVENT(loc_oPagina.cmd_4c_Alteracotacao, "Click", THIS, "BtnAlterarCotacaoClick")
1066: 
1067:         *-- BINDEVENTs dos campos ja criados nesta pagina (Grupo/Conta/Moeda/
1068:         *-- Valor/Cotacao/Job) - LostFocus reproduz o Valid do legado
1069:         BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress", THIS, "ValidarGrupo")
1070:         BINDEVENT(loc_oPagina.txt_4c_Conta, "KeyPress", THIS, "ValidarConta")
1071:         BINDEVENT(loc_oPagina.txt_4c_Dconta, "KeyPress", THIS, "ValidarDconta")
1072:         BINDEVENT(loc_oPagina.txt_4c_MOEDA, "KeyPress", THIS, "ValidarMoeda")
1073:         BINDEVENT(loc_oPagina.txt_4c_VALOR, "KeyPress", THIS, "ValidarValor")
1074:         BINDEVENT(loc_oPagina.txt_4c_COTACAO, "KeyPress", THIS, "ValidarCotacao")
1075:         BINDEVENT(loc_oPagina.txt_4c_Job, "KeyPress", THIS, "ValidarJob")
1076: 
1077:         *-- Shape2 (legado Top=224,Left=504,Width=485,Height=117) - moldura do
1078:         *-- painel S (contrapartida)
1079:         loc_oPagina.AddObject("shp_4c_Shape2", "Shape")
1080:         WITH loc_oPagina.shp_4c_Shape2
1081:             .Top     = 253
1082:             .Left    = 504
1083:             .Width   = 485
1084:             .Height  = 117
1085:             .Visible = .T.
1086:         ENDWITH
1087: 
1088:         *-- Painel S (lado direito, dentro de shp_4c_Shape2): Movimento/Grupo/
1089:         *-- Conta/Valor/Moeda/Cambio da contrapartida (espelho do painel D)
1090:         loc_oPagina.AddObject("lbl_4c_Label11", "Label")
1091:         WITH loc_oPagina.lbl_4c_Label11
1092:             .Caption   = "Movimento :"
1093:             .Top       = 264
1094:             .Left      = 544
1095:             .Width     = 59
1096:             .Height    = 15
1097:             .AutoSize  = .F.
1098:             .FontName  = "Tahoma"
1099:             .FontSize  = 8
1100:             .ForeColor = RGB(90, 90, 90)
1101:             .BackStyle = 0
1102:             .Visible   = .T.
1103:         ENDWITH
1104: 
1105:         loc_oPagina.AddObject("txt_4c_SOPER", "TextBox")
1106:         WITH loc_oPagina.txt_4c_SOPER
1107:             .Top       = 260
1108:             .Left      = 607
1109:             .Width     = 15
1110:             .Height    = 21
1111:             .Value     = ""
1112:             .MaxLength = 1
1113:             .ReadOnly  = .T.
1114:             .FontName  = "Tahoma"
1115:             .FontSize  = 8

*-- Linhas 1158 a 1347:
1158:             .FontSize  = 8
1159:             .Visible   = .T.
1160:         ENDWITH
1161:         BINDEVENT(loc_oPagina.txt_4c_SGRUPO, "KeyPress", THIS, "ValidarSGrupo")
1162: 
1163:         loc_oPagina.AddObject("txt_4c_Sdgrupo", "TextBox")
1164:         WITH loc_oPagina.txt_4c_Sdgrupo
1165:             .Top       = 286
1166:             .Left      = 689
1167:             .Width     = 290
1168:             .Height    = 21
1169:             .Value     = ""
1170:             .MaxLength = 40
1171:             .ReadOnly  = .T.
1172:             .FontName  = "Tahoma"
1173:             .FontSize  = 8
1174:             .Visible   = .T.
1175:         ENDWITH
1176: 
1177:         loc_oPagina.AddObject("lbl_4c_Label13", "Label")
1178:         WITH loc_oPagina.lbl_4c_Label13
1179:             .Caption   = "Conta :"
1180:             .Top       = 316
1181:             .Left      = 567
1182:             .Width     = 36
1183:             .Height    = 15
1184:             .AutoSize  = .F.
1185:             .FontName  = "Tahoma"
1186:             .FontSize  = 8
1187:             .ForeColor = RGB(90, 90, 90)
1188:             .BackStyle = 0
1189:             .Visible   = .T.
1190:         ENDWITH
1191: 
1192:         loc_oPagina.AddObject("txt_4c_SCONTA", "TextBox")
1193:         WITH loc_oPagina.txt_4c_SCONTA
1194:             .Top       = 312
1195:             .Left      = 607
1196:             .Width     = 80
1197:             .Height    = 21
1198:             .Value     = ""
1199:             .MaxLength = 10
1200:             .FontName  = "Tahoma"
1201:             .FontSize  = 8
1202:             .Visible   = .T.
1203:         ENDWITH
1204:         BINDEVENT(loc_oPagina.txt_4c_SCONTA, "KeyPress", THIS, "ValidarSConta")
1205: 
1206:         loc_oPagina.AddObject("txt_4c_SDCONTA", "TextBox")
1207:         WITH loc_oPagina.txt_4c_SDCONTA
1208:             .Top       = 312
1209:             .Left      = 689
1210:             .Width     = 290
1211:             .Height    = 21
1212:             .Value     = ""
1213:             .MaxLength = 50
1214:             .ReadOnly  = .T.
1215:             .FontName  = "Tahoma"
1216:             .FontSize  = 8
1217:             .Visible   = .T.
1218:         ENDWITH
1219:         BINDEVENT(loc_oPagina.txt_4c_SDCONTA, "KeyPress", THIS, "ValidarSDconta")
1220: 
1221:         loc_oPagina.AddObject("lbl_4c_Label16", "Label")
1222:         WITH loc_oPagina.lbl_4c_Label16
1223:             .Caption   = "Valor :"
1224:             .Top       = 342
1225:             .Left      = 572
1226:             .Width     = 31
1227:             .Height    = 15
1228:             .AutoSize  = .F.
1229:             .FontName  = "Tahoma"
1230:             .FontSize  = 8
1231:             .ForeColor = RGB(90, 90, 90)
1232:             .BackStyle = 0
1233:             .Visible   = .T.
1234:         ENDWITH
1235: 
1236:         loc_oPagina.AddObject("txt_4c_SVALOR", "TextBox")
1237:         WITH loc_oPagina.txt_4c_SVALOR
1238:             .Top       = 338
1239:             .Left      = 607
1240:             .Width     = 128
1241:             .Height    = 23
1242:             .Value     = 0
1243:             .InputMask = "999,999,999.99"
1244:             .FontName  = "Tahoma"
1245:             .FontSize  = 8
1246:             .Visible   = .T.
1247:         ENDWITH
1248:         BINDEVENT(loc_oPagina.txt_4c_SVALOR, "KeyPress", THIS, "ValidarSValor")
1249: 
1250:         loc_oPagina.AddObject("txt_4c_Smoeda", "TextBox")
1251:         WITH loc_oPagina.txt_4c_Smoeda
1252:             .Top       = 338
1253:             .Left      = 737
1254:             .Width     = 31
1255:             .Height    = 21
1256:             .Value     = ""
1257:             .MaxLength = 3
1258:             .FontName  = "Tahoma"
1259:             .FontSize  = 8
1260:             .Visible   = .T.
1261:         ENDWITH
1262:         BINDEVENT(loc_oPagina.txt_4c_Smoeda, "KeyPress", THIS, "ValidarSmoeda")
1263: 
1264:         loc_oPagina.AddObject("lbl_4c__sCotacao", "Label")
1265:         WITH loc_oPagina.lbl_4c__sCotacao
1266:             .Caption   = "C" + CHR(226) + "mbio :"
1267:             .Top       = 342
1268:             .Left      = 797
1269:             .Width     = 42
1270:             .Height    = 15
1271:             .AutoSize  = .F.
1272:             .FontName  = "Tahoma"
1273:             .FontSize  = 8
1274:             .ForeColor = RGB(90, 90, 90)
1275:             .BackStyle = 0
1276:             .Visible   = .T.
1277:         ENDWITH
1278: 
1279:         loc_oPagina.AddObject("txt_4c_SCOTACAO", "TextBox")
1280:         WITH loc_oPagina.txt_4c_SCOTACAO
1281:             .Top       = 338
1282:             .Left      = 843
1283:             .Width     = 108
1284:             .Height    = 21
1285:             .Value     = 0
1286:             .InputMask = "999,999.9999999"
1287:             .FontName  = "Tahoma"
1288:             .FontSize  = 8
1289:             .Visible   = .T.
1290:         ENDWITH
1291:         BINDEVENT(loc_oPagina.txt_4c_SCOTACAO, "KeyPress", THIS, "ValidarSCotacao")
1292: 
1293:         loc_oPagina.AddObject("cmd_4c_Alterascotacao", "CommandButton")
1294:         WITH loc_oPagina.cmd_4c_Alterascotacao
1295:             .Caption   = "$"
1296:             .Top       = 338
1297:             .Left      = 955
1298:             .Width     = 24
1299:             .Height    = 23
1300:             .FontName  = "Tahoma"
1301:             .FontSize  = 8
1302:             .FontBold  = .T.
1303:             .ForeColor = RGB(90, 90, 90)
1304:             .Themes    = .F.
1305:             .Visible   = .T.
1306:         ENDWITH
1307:         BINDEVENT(loc_oPagina.cmd_4c_Alterascotacao, "Click", THIS, "BtnAlterarSCotacaoClick")
1308: 
1309:         *-- Shape6 (legado Top=350,Left=9,Width=980,Height=39) - moldura do
1310:         *-- historico (Get_HIST + Get_Hist2 + Lancar Contas)
1311:         loc_oPagina.AddObject("shp_4c_Shape6", "Shape")
1312:         WITH loc_oPagina.shp_4c_Shape6
1313:             .Top     = 379
1314:             .Left    = 9
1315:             .Width   = 980
1316:             .Height  = 39
1317:             .Visible = .T.
1318:         ENDWITH
1319: 
1320:         loc_oPagina.AddObject("lbl_4c_Label9", "Label")
1321:         WITH loc_oPagina.lbl_4c_Label9
1322:             .Caption   = "Hist" + CHR(243) + "rico :"
1323:             .Top       = 391
1324:             .Left      = 60
1325:             .Width     = 52
1326:             .Height    = 15
1327:             .AutoSize  = .F.
1328:             .FontName  = "Tahoma"
1329:             .FontSize  = 8
1330:             .ForeColor = RGB(90, 90, 90)
1331:             .BackStyle = 0
1332:             .Visible   = .T.
1333:         ENDWITH
1334: 
1335:         loc_oPagina.AddObject("txt_4c_HIST", "TextBox")
1336:         WITH loc_oPagina.txt_4c_HIST
1337:             .Top       = 387
1338:             .Left      = 112
1339:             .Width     = 300
1340:             .Height    = 21
1341:             .Value     = ""
1342:             .MaxLength = 60
1343:             .Format    = "K!"
1344:             .FontName  = "Tahoma"
1345:             .FontSize  = 8
1346:             .Visible   = .T.
1347:         ENDWITH

*-- Linhas 1375 a 1465:
1375:             .Visible   = .T.
1376:         ENDWITH
1377: 
1378:         *-- OptionGroup Lancar Contas (legado Opcao_conta: Option1="Sim"
1379:         *-- Value=0, Option2="Nao" Value=1 - ControlSource craltcc.contapgs)
1380:         loc_oPagina.AddObject("obj_4c_Opcao_conta", "OptionGroup")
1381:         WITH loc_oPagina.obj_4c_Opcao_conta
1382:             .Top         = 385
1383:             .Left        = 844
1384:             .Width       = 99
1385:             .Height      = 27
1386:             .ButtonCount = 2
1387:             .BackStyle   = 0
1388:             .BorderStyle = 0
1389:             .Visible     = .T.
1390:         ENDWITH
1391:         WITH loc_oPagina.obj_4c_Opcao_conta.Buttons(1)
1392:             .Caption   = "Sim"
1393:             .Value     = 0
1394:             .Left      = 5
1395:             .Top       = 5
1396:             .AutoSize  = .F.
1397:             .FontName  = "Tahoma"
1398:             .FontSize  = 8
1399:             .ForeColor = RGB(90, 90, 90)
1400:             .BackStyle = 0
1401:             .Themes    = .F.
1402:         ENDWITH
1403:         WITH loc_oPagina.obj_4c_Opcao_conta.Buttons(2)
1404:             .Caption   = "N" + CHR(227) + "o"
1405:             .Value     = 1
1406:             .Left      = 57
1407:             .Top       = 6
1408:             .AutoSize  = .T.
1409:             .Alignment = 0
1410:             .FontName  = "Tahoma"
1411:             .FontSize  = 8
1412:             .ForeColor = RGB(90, 90, 90)
1413:             .BackStyle = 0
1414:             .Themes    = .F.
1415:         ENDWITH
1416: 
1417:         THIS.TornarControlesVisiveis(loc_oPagina)
1418:     ENDPROC
1419: 
1420:     *===========================================================================
1421:     * CarregarLista - Carrega grade de lancamentos filtrada por periodo
1422:     * Legado (sqldados): filtra SEMPRE por Datas Between Dt_inicial e Dt_final,
1423:     * nunca traz a tabela inteira (CLAUDE.md regra #35a)
1424:     *===========================================================================
1425:     PROCEDURE CarregarLista()
1426:         LOCAL loc_lResultado, loc_oGrid, loc_oPeriodo, loc_dDtI, loc_dDtF, loc_tDtF, loc_cFiltro
1427:         loc_lResultado = .F.
1428: 
1429:         TRY
1430:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1431:                 LOCAL loc_nDsAtual
1432:                 loc_nDsAtual = THIS.DataSessionID
1433:                 SET DATASESSION TO 1
1434:                 IF USED("cursor_4c_Dados")
1435:                     USE IN cursor_4c_Dados
1436:                 ENDIF
1437:                 SET NULL ON
1438:                 CREATE CURSOR cursor_4c_Dados ;
1439:                     (cidchaves C(20), datas T, contas C(10), scontas C(10), hists C(60), ;
1440:                      valors N(11,2), svalors N(11,2), smoedas C(3), moedas C(3), ;
1441:                      nfs C(10), docus C(10), opers C(1))
1442:                 SET NULL OFF
1443:                 SET DATASESSION TO (loc_nDsAtual)
1444:                 loc_lResultado = .T.
1445:             ELSE
1446:                 loc_oPeriodo = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.cnt_4c__periodo
1447: 
1448:                 loc_dDtI = loc_oPeriodo.txt_4c_Dt_inicial.Value
1449:                 loc_dDtF = loc_oPeriodo.txt_4c_Dt_final.Value
1450: 
1451:                 IF EMPTY(loc_dDtI)
1452:                     loc_dDtI = DATE()
1453:                 ENDIF
1454:                 IF EMPTY(loc_dDtF)
1455:                     loc_dDtF = DATE()
1456:                 ENDIF
1457: 
1458:                 loc_tDtF = DATETIME(YEAR(loc_dDtF), MONTH(loc_dDtF), DAY(loc_dDtF), 23, 59, 59)
1459: 
1460:                 loc_cFiltro = "AND a.datas BETWEEN " + FormatarDataSQL(loc_dDtI) + ;
1461:                     " AND " + FormatarDataSQL(loc_tDtF)
1462: 
1463:                 IF !THIS.this_oBusinessObject.Buscar(loc_cFiltro)
1464:                     loc_lResultado = .F.
1465:                 ELSE

*-- Linhas 1511 a 1934:
1511:     *===========================================================================
1512:     * FormatarGridLista - Formata visual do grid da lista
1513:     *===========================================================================
1514:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1515:         WITH par_oGrid
1516:             IF .ColumnCount > 0
1517:                 .FontName = "Tahoma"
1518:             ENDIF
1519:         ENDWITH
1520:     ENDPROC
1521: 
1522:     *===========================================================================
1523:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
1524:     *===========================================================================
1525:     PROCEDURE AlternarPagina(par_nPagina)
1526:         LOCAL loc_lResultado
1527:         loc_lResultado = .F.
1528: 
1529:         IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
1530:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1531: 
1532:             IF par_nPagina = 1
1533:                 THIS.this_cModoAtual = "LISTA"
1534:                 THIS.CarregarLista()
1535:             ENDIF
1536: 
1537:             loc_lResultado = .T.
1538:         ENDIF
1539: 
1540:         RETURN loc_lResultado
1541:     ENDPROC
1542: 
1543:     *===========================================================================
1544:     * ValidarDataInicial - LostFocus do campo Dt_inicial (legado: Dt_inicial.Valid)
1545:     *===========================================================================
1546:     PROCEDURE ValidarDataInicial(par_nKeyCode, par_nShiftAltCtrl)
1547:         LOCAL loc_oPeriodo
1548:         loc_oPeriodo = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.cnt_4c__periodo
1549: 
1550:         IF !EMPTY(loc_oPeriodo.txt_4c_Dt_inicial.Value) AND !EMPTY(loc_oPeriodo.txt_4c_Dt_final.Value)
1551:             IF loc_oPeriodo.txt_4c_Dt_inicial.Value > loc_oPeriodo.txt_4c_Dt_final.Value
1552:                 loc_oPeriodo.txt_4c_Dt_final.Value = loc_oPeriodo.txt_4c_Dt_inicial.Value
1553:             ENDIF
1554:         ENDIF
1555:     ENDPROC
1556: 
1557:     *===========================================================================
1558:     * ValidarDataFinal - LostFocus do campo Dt_final (legado: Dt_final.Valid
1559:     * chama ThisForm.SqlDados apos validar o cruzamento das datas)
1560:     *===========================================================================
1561:     PROCEDURE ValidarDataFinal(par_nKeyCode, par_nShiftAltCtrl)
1562:         LOCAL loc_oPeriodo
1563:         loc_oPeriodo = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.cnt_4c__periodo
1564: 
1565:         IF !EMPTY(loc_oPeriodo.txt_4c_Dt_inicial.Value) AND !EMPTY(loc_oPeriodo.txt_4c_Dt_final.Value)
1566:             IF loc_oPeriodo.txt_4c_Dt_final.Value < loc_oPeriodo.txt_4c_Dt_inicial.Value
1567:                 loc_oPeriodo.txt_4c_Dt_inicial.Value = loc_oPeriodo.txt_4c_Dt_final.Value
1568:             ENDIF
1569:         ENDIF
1570: 
1571:         THIS.CarregarLista()
1572:     ENDPROC
1573: 
1574:     *===========================================================================
1575:     * AvisarPrimeiroLancamento - Legado (ChkRegister('SigMvSlc', laCampo))
1576:     * avisa quando Grupo+Conta+Moeda ainda nao tem nenhum lancamento em
1577:     * SigMvSlc. Na arquitetura nova nao existe ThisForm.podatamgr, entao a
1578:     * checagem eh feita direto via SQLEXEC.
1579:     *===========================================================================
1580:     PROTECTED PROCEDURE AvisarPrimeiroLancamento(par_cGrupo, par_cConta, par_cMoeda)
1581:         LOCAL loc_nResult
1582: 
1583:         IF EMPTY(par_cGrupo) OR EMPTY(par_cConta) OR EMPTY(par_cMoeda)
1584:             RETURN
1585:         ENDIF
1586: 
1587:         IF USED("cursor_4c_ChkReg")
1588:             USE IN cursor_4c_ChkReg
1589:         ENDIF
1590: 
1591:         loc_nResult = SQLEXEC(gnConnHandle, "SELECT TOP 1 Grupos FROM SigMvSlc" + ;
1592:             " WHERE Grupos = " + EscaparSQL(par_cGrupo) + ;
1593:             " AND Contas = " + EscaparSQL(par_cConta) + ;
1594:             " AND Moedas = " + EscaparSQL(par_cMoeda), "cursor_4c_ChkReg")
1595: 
1596:         IF loc_nResult >= 0 AND (!USED("cursor_4c_ChkReg") OR RECCOUNT("cursor_4c_ChkReg") = 0)
1597:             MsgAviso("Aten" + CHR(231) + CHR(227) + "o !!! Primeiro Lan" + CHR(231) + "amento deste Grupo/Conta/Moeda")
1598:         ENDIF
1599: 
1600:         IF USED("cursor_4c_ChkReg")
1601:             USE IN cursor_4c_ChkReg
1602:         ENDIF
1603:     ENDPROC
1604: 
1605:     *===========================================================================
1606:     * ValidarGrupo - LostFocus de txt_4c_Grupo (legado: Get_grupo.Valid)
1607:     * Usa fAcessoContab (ja portada em utils/functions.prg) para validar
1608:     * acesso e preencher a descricao; depois confere se o grupo tem Classe
1609:     * cadastrada (sem Classe, o lancamento eh bloqueado no legado).
1610:     *===========================================================================
1611:     PROCEDURE ValidarGrupo(par_nKeyCode, par_nShiftAltCtrl)
1612:         LOCAL loc_oPg, loc_cValor
1613: 
1614:         loc_oPg   = THIS.pgf_4c_Paginas.Page2
1615:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_Grupo.Value)
1616: 
1617:         IF loc_cValor == THIS.this_cUltimoGrupoValidado
1618:             RETURN
1619:         ENDIF
1620:         THIS.this_cUltimoGrupoValidado = loc_cValor
1621: 
1622:         IF !EMPTY(loc_cValor)
1623:             fAcessoContab(gc_4c_UsuarioLogado, "C", loc_cValor, loc_oPg.txt_4c_Grupo, ;
1624:                 loc_oPg.txt_4c_Dgrupo, loc_oPg.txt_4c_Conta.Value, loc_oPg.txt_4c_Fweditdata_DATA.Value)
1625:         ELSE
1626:             loc_oPg.txt_4c_Dgrupo.Value = ""
1627:         ENDIF
1628: 
1629:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_Grupo.Value)
1630:         IF !EMPTY(loc_cValor)
1631:             IF USED("cursor_4c_ValGrp")
1632:                 USE IN cursor_4c_ValGrp
1633:             ENDIF
1634:             SQLEXEC(gnConnHandle, "SELECT Codigos, Classes FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cValor), "cursor_4c_ValGrp")
1635: 
1636:             IF !USED("cursor_4c_ValGrp") OR RECCOUNT("cursor_4c_ValGrp") = 0 OR EMPTY(NVL(cursor_4c_ValGrp.Classes, ""))
1637:                 MsgErro("Imposs" + CHR(237) + "vel Realizar Lan" + CHR(231) + "amento Neste Grupo!!!" + CHR(13) + ;
1638:                     "A Classe do Grupo N" + CHR(227) + "o Foi Informada!!!", "Aten" + CHR(231) + CHR(227) + "o")
1639:                 loc_oPg.txt_4c_Grupo.Value = ""
1640:                 loc_oPg.txt_4c_Dgrupo.Value = ""
1641:                 THIS.this_cUltimoGrupoValidado = ""
1642:             ENDIF
1643: 
1644:             IF USED("cursor_4c_ValGrp")
1645:                 USE IN cursor_4c_ValGrp
1646:             ENDIF
1647:         ENDIF
1648: 
1649:         THIS.AvisarPrimeiroLancamento(ALLTRIM(loc_oPg.txt_4c_Grupo.Value), ALLTRIM(loc_oPg.txt_4c_Conta.Value), ALLTRIM(loc_oPg.txt_4c_MOEDA.Value))
1650:     ENDPROC
1651: 
1652:     *===========================================================================
1653:     * ValidarConta - LostFocus de txt_4c_Conta (legado: Get_conta.Valid)
1654:     * fAcessoContas/fChecarInativas ja portadas em utils/functions.prg
1655:     *===========================================================================
1656:     PROCEDURE ValidarConta(par_nKeyCode, par_nShiftAltCtrl)
1657:         LOCAL loc_oPg, loc_cValor, loc_cGrupo
1658: 
1659:         loc_oPg   = THIS.pgf_4c_Paginas.Page2
1660:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_Conta.Value)
1661: 
1662:         IF loc_cValor == THIS.this_cUltimaContaValidada
1663:             RETURN
1664:         ENDIF
1665:         THIS.this_cUltimaContaValidada = loc_cValor
1666: 
1667:         loc_cGrupo = ALLTRIM(loc_oPg.txt_4c_Grupo.Value)
1668: 
1669:         IF EMPTY(loc_cValor)
1670:             loc_oPg.txt_4c_Dconta.Value = ""
1671:             RETURN
1672:         ENDIF
1673: 
1674:         IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "C", loc_cValor, loc_oPg.txt_4c_Conta, loc_oPg.txt_4c_Dconta)
1675:             MsgErro("Acesso Negado !!", "Aviso")
1676:             loc_oPg.txt_4c_Conta.Value = ""
1677:             loc_oPg.txt_4c_Dconta.Value = ""
1678:             THIS.this_cUltimaContaValidada = ""
1679:             RETURN
1680:         ENDIF
1681: 
1682:         IF !fChecarInativas(loc_oPg.txt_4c_Conta.Value, gnConnHandle)
1683:             MsgErro("Conta Inativa ...", "Aviso")
1684:             loc_oPg.txt_4c_Conta.Value = ""
1685:             loc_oPg.txt_4c_Dconta.Value = ""
1686:             THIS.this_cUltimaContaValidada = ""
1687:             RETURN
1688:         ENDIF
1689: 
1690:         THIS.AvisarPrimeiroLancamento(loc_cGrupo, ALLTRIM(loc_oPg.txt_4c_Conta.Value), ALLTRIM(loc_oPg.txt_4c_MOEDA.Value))
1691:     ENDPROC
1692: 
1693:     *===========================================================================
1694:     * ValidarDconta - LostFocus de txt_4c_Dconta (legado: Get_dconta.Valid)
1695:     * Quando a Conta foi preenchida sem Grupo, resolve o Grupo (e a
1696:     * descricao do Grupo) a partir de SigCdCli/SigCdGcr.
1697:     *===========================================================================
1698:     PROCEDURE ValidarDconta(par_nKeyCode, par_nShiftAltCtrl)
1699:         LOCAL loc_oPg
1700: 
1701:         loc_oPg = THIS.pgf_4c_Paginas.Page2
1702: 
1703:         IF EMPTY(ALLTRIM(loc_oPg.txt_4c_Conta.Value)) OR !EMPTY(ALLTRIM(loc_oPg.txt_4c_Grupo.Value))
1704:             RETURN
1705:         ENDIF
1706: 
1707:         IF USED("cursor_4c_ResGrp")
1708:             USE IN cursor_4c_ResGrp
1709:         ENDIF
1710:         SQLEXEC(gnConnHandle, "SELECT Grupos FROM SigCdCli WHERE IClis = " + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Conta.Value)), "cursor_4c_ResGrp")
1711:         IF USED("cursor_4c_ResGrp") AND RECCOUNT("cursor_4c_ResGrp") > 0 AND !EMPTY(NVL(cursor_4c_ResGrp.Grupos, ""))
1712:             loc_oPg.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_ResGrp.Grupos)
1713:         ENDIF
1714:         IF USED("cursor_4c_ResGrp")
1715:             USE IN cursor_4c_ResGrp
1716:         ENDIF
1717: 
1718:         IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_Grupo.Value))
1719:             IF USED("cursor_4c_ResGrpD")
1720:                 USE IN cursor_4c_ResGrpD
1721:             ENDIF
1722:             SQLEXEC(gnConnHandle, "SELECT Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Grupo.Value)), "cursor_4c_ResGrpD")
1723:             IF USED("cursor_4c_ResGrpD") AND RECCOUNT("cursor_4c_ResGrpD") > 0 AND !EMPTY(NVL(cursor_4c_ResGrpD.Descrs, ""))
1724:                 loc_oPg.txt_4c_Dgrupo.Value = ALLTRIM(cursor_4c_ResGrpD.Descrs)
1725:             ENDIF
1726:             IF USED("cursor_4c_ResGrpD")
1727:                 USE IN cursor_4c_ResGrpD
1728:             ENDIF
1729:         ENDIF
1730:     ENDPROC
1731: 
1732:     *===========================================================================
1733:     * ValidarSGrupo / ValidarSConta / ValidarSDconta - espelho do painel D
1734:     * para a contrapartida (legado: Get_SGRUPO/Get_SCONTA/Get_SDCONTA.Valid)
1735:     *===========================================================================
1736:     PROCEDURE ValidarSGrupo(par_nKeyCode, par_nShiftAltCtrl)
1737:         LOCAL loc_oPg, loc_cValor
1738: 
1739:         loc_oPg   = THIS.pgf_4c_Paginas.Page2
1740:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_SGRUPO.Value)
1741: 
1742:         IF loc_cValor == THIS.this_cUltimoSGrupoValidado
1743:             RETURN
1744:         ENDIF
1745:         THIS.this_cUltimoSGrupoValidado = loc_cValor
1746: 
1747:         IF !EMPTY(loc_cValor)
1748:             fAcessoContab(gc_4c_UsuarioLogado, "C", loc_cValor, loc_oPg.txt_4c_SGRUPO, ;
1749:                 loc_oPg.txt_4c_Sdgrupo, loc_oPg.txt_4c_SCONTA.Value, loc_oPg.txt_4c_Fweditdata_DATA.Value)
1750:         ELSE
1751:             loc_oPg.txt_4c_Sdgrupo.Value = ""
1752:         ENDIF
1753: 
1754:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_SGRUPO.Value)
1755:         IF !EMPTY(loc_cValor)
1756:             IF USED("cursor_4c_ValSGrp")
1757:                 USE IN cursor_4c_ValSGrp
1758:             ENDIF
1759:             SQLEXEC(gnConnHandle, "SELECT Codigos, Classes FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cValor), "cursor_4c_ValSGrp")
1760: 
1761:             IF !USED("cursor_4c_ValSGrp") OR RECCOUNT("cursor_4c_ValSGrp") = 0 OR EMPTY(NVL(cursor_4c_ValSGrp.Classes, ""))
1762:                 MsgErro("Imposs" + CHR(237) + "vel Realizar Lan" + CHR(231) + "amento Neste Grupo!!!" + CHR(13) + ;
1763:                     "A Classe do Grupo N" + CHR(227) + "o Foi Informada!!!", "Aten" + CHR(231) + CHR(227) + "o")
1764:                 loc_oPg.txt_4c_SGRUPO.Value = ""
1765:                 loc_oPg.txt_4c_Sdgrupo.Value = ""
1766:                 THIS.this_cUltimoSGrupoValidado = ""
1767:             ENDIF
1768: 
1769:             IF USED("cursor_4c_ValSGrp")
1770:                 USE IN cursor_4c_ValSGrp
1771:             ENDIF
1772:         ENDIF
1773: 
1774:         THIS.AvisarPrimeiroLancamento(ALLTRIM(loc_oPg.txt_4c_SGRUPO.Value), ALLTRIM(loc_oPg.txt_4c_SCONTA.Value), ALLTRIM(loc_oPg.txt_4c_Smoeda.Value))
1775:     ENDPROC
1776: 
1777:     PROCEDURE ValidarSConta(par_nKeyCode, par_nShiftAltCtrl)
1778:         LOCAL loc_oPg, loc_cValor, loc_cGrupo
1779: 
1780:         loc_oPg   = THIS.pgf_4c_Paginas.Page2
1781:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_SCONTA.Value)
1782: 
1783:         IF loc_cValor == THIS.this_cUltimaSContaValidada
1784:             RETURN
1785:         ENDIF
1786:         THIS.this_cUltimaSContaValidada = loc_cValor
1787: 
1788:         loc_cGrupo = ALLTRIM(loc_oPg.txt_4c_SGRUPO.Value)
1789: 
1790:         IF EMPTY(loc_cValor)
1791:             loc_oPg.txt_4c_SDCONTA.Value = ""
1792:             RETURN
1793:         ENDIF
1794: 
1795:         IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "C", loc_cValor, loc_oPg.txt_4c_SCONTA, loc_oPg.txt_4c_SDCONTA)
1796:             MsgErro("Acesso Negado !!", "Aviso")
1797:             loc_oPg.txt_4c_SCONTA.Value = ""
1798:             loc_oPg.txt_4c_SDCONTA.Value = ""
1799:             THIS.this_cUltimaSContaValidada = ""
1800:             RETURN
1801:         ENDIF
1802: 
1803:         IF !fChecarInativas(loc_oPg.txt_4c_SCONTA.Value, gnConnHandle)
1804:             MsgErro("Conta Inativa ...", "Aviso")
1805:             loc_oPg.txt_4c_SCONTA.Value = ""
1806:             loc_oPg.txt_4c_SDCONTA.Value = ""
1807:             THIS.this_cUltimaSContaValidada = ""
1808:             RETURN
1809:         ENDIF
1810: 
1811:         THIS.AvisarPrimeiroLancamento(loc_cGrupo, ALLTRIM(loc_oPg.txt_4c_SCONTA.Value), ALLTRIM(loc_oPg.txt_4c_Smoeda.Value))
1812:     ENDPROC
1813: 
1814:     PROCEDURE ValidarSDconta(par_nKeyCode, par_nShiftAltCtrl)
1815:         LOCAL loc_oPg
1816: 
1817:         loc_oPg = THIS.pgf_4c_Paginas.Page2
1818: 
1819:         IF EMPTY(ALLTRIM(loc_oPg.txt_4c_SCONTA.Value)) OR !EMPTY(ALLTRIM(loc_oPg.txt_4c_SGRUPO.Value))
1820:             RETURN
1821:         ENDIF
1822: 
1823:         IF USED("cursor_4c_ResSGrp")
1824:             USE IN cursor_4c_ResSGrp
1825:         ENDIF
1826:         SQLEXEC(gnConnHandle, "SELECT Grupos FROM SigCdCli WHERE IClis = " + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_SCONTA.Value)), "cursor_4c_ResSGrp")
1827:         IF USED("cursor_4c_ResSGrp") AND RECCOUNT("cursor_4c_ResSGrp") > 0 AND !EMPTY(NVL(cursor_4c_ResSGrp.Grupos, ""))
1828:             loc_oPg.txt_4c_SGRUPO.Value = ALLTRIM(cursor_4c_ResSGrp.Grupos)
1829:         ENDIF
1830:         IF USED("cursor_4c_ResSGrp")
1831:             USE IN cursor_4c_ResSGrp
1832:         ENDIF
1833: 
1834:         IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_SGRUPO.Value))
1835:             IF USED("cursor_4c_ResSGrpD")
1836:                 USE IN cursor_4c_ResSGrpD
1837:             ENDIF
1838:             SQLEXEC(gnConnHandle, "SELECT Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_SGRUPO.Value)), "cursor_4c_ResSGrpD")
1839:             IF USED("cursor_4c_ResSGrpD") AND RECCOUNT("cursor_4c_ResSGrpD") > 0 AND !EMPTY(NVL(cursor_4c_ResSGrpD.Descrs, ""))
1840:                 loc_oPg.txt_4c_Sdgrupo.Value = ALLTRIM(cursor_4c_ResSGrpD.Descrs)
1841:             ENDIF
1842:             IF USED("cursor_4c_ResSGrpD")
1843:                 USE IN cursor_4c_ResSGrpD
1844:             ENDIF
1845:         ENDIF
1846:     ENDPROC
1847: 
1848:     *===========================================================================
1849:     * ValidarJob / (txt_4c_DJob eh so leitura) - legado: getJob.Valid
1850:     * chamada original tem argumentos extras (.f. x7, 10) que a assinatura
1851:     * portada de fAcessoContas nao aceita - usados so os 6 primeiros, que
1852:     * cobrem o essencial (usuario/grupo/tipo/valor/origem/destino)
1853:     *===========================================================================
1854:     PROCEDURE ValidarJob(par_nKeyCode, par_nShiftAltCtrl)
1855:         LOCAL loc_oPg, loc_cValor
1856: 
1857:         loc_oPg   = THIS.pgf_4c_Paginas.Page2
1858:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_Job.Value)
1859: 
1860:         IF loc_cValor == THIS.this_cUltimoJobValidado
1861:             RETURN
1862:         ENDIF
1863:         THIS.this_cUltimoJobValidado = loc_cValor
1864: 
1865:         IF EMPTY(loc_cValor)
1866:             loc_oPg.txt_4c_DJob.Value = ""
1867:             RETURN
1868:         ENDIF
1869: 
1870:         IF !fAcessoContas(gc_4c_UsuarioLogado, "", "C", loc_cValor, loc_oPg.txt_4c_Job, loc_oPg.txt_4c_DJob)
1871:             MsgErro("Acesso Negado!!!", "Aviso")
1872:             loc_oPg.txt_4c_Job.Value = ""
1873:             loc_oPg.txt_4c_DJob.Value = ""
1874:             THIS.this_cUltimoJobValidado = ""
1875:         ENDIF
1876:     ENDPROC
1877: 
1878:     *===========================================================================
1879:     * ProcessarMudancaMoeda - nucleo comum de Get_MOEDA.Valid/Get_smoeda.Valid
1880:     * par_cLado: "D" (Moeda/Cotacao) ou "S" (Smoeda/SCotacao)
1881:     * Resolve a cotacao vigente em SigCdCot na data do lancamento, espelha a
1882:     * moeda/cotacao para o outro lado quando ele ainda esta vazio, recalcula
1883:     * o valor convertido e ajusta a visibilidade dos campos de cambio.
1884:     *===========================================================================
1885:     PROTECTED PROCEDURE ProcessarMudancaMoeda(par_cLado)
1886:         LOCAL loc_oPg, loc_cValor, loc_lCotas, loc_dData, loc_nCotacao, loc_lAlterar
1887: 
1888:         loc_oPg = THIS.pgf_4c_Paginas.Page2
1889: 
1890:         IF par_cLado == "D"
1891:             loc_cValor = ALLTRIM(loc_oPg.txt_4c_MOEDA.Value)
1892:             IF loc_cValor == THIS.this_cUltimaMoedaValidada
1893:                 RETURN
1894:             ENDIF
1895:             THIS.this_cUltimaMoedaValidada = loc_cValor
1896:         ELSE
1897:             loc_cValor = ALLTRIM(loc_oPg.txt_4c_Smoeda.Value)
1898:             IF loc_cValor == THIS.this_cUltimaSMoedaValidada
1899:                 RETURN
1900:             ENDIF
1901:             THIS.this_cUltimaSMoedaValidada = loc_cValor
1902:         ENDIF
1903: 
1904:         IF EMPTY(loc_cValor)
1905:             RETURN
1906:         ENDIF
1907: 
1908:         IF USED("cursor_4c_ValMoe")
1909:             USE IN cursor_4c_ValMoe
1910:         ENDIF
1911:         SQLEXEC(gnConnHandle, "SELECT CMoes, Cotas FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cValor), "cursor_4c_ValMoe")
1912: 
1913:         IF !USED("cursor_4c_ValMoe") OR RECCOUNT("cursor_4c_ValMoe") = 0
1914:             IF USED("cursor_4c_ValMoe")
1915:                 USE IN cursor_4c_ValMoe
1916:             ENDIF
1917:             IF par_cLado == "D"
1918:                 THIS.AbrirLookupMoeda()
1919:             ELSE
1920:                 THIS.AbrirLookupSMoeda()
1921:             ENDIF
1922:             RETURN
1923:         ENDIF
1924: 
1925:         loc_lCotas = ConverterParaLogico(cursor_4c_ValMoe.Cotas)
1926:         loc_cValor = ALLTRIM(cursor_4c_ValMoe.CMoes)
1927:         USE IN cursor_4c_ValMoe
1928: 
1929:         IF par_cLado == "D"
1930:             loc_oPg.txt_4c_MOEDA.Value = loc_cValor
1931:         ELSE
1932:             loc_oPg.txt_4c_Smoeda.Value = loc_cValor
1933:         ENDIF
1934: 

*-- Linhas 1985 a 2478:
1985:         ELSE
1986:             THIS.AvisarPrimeiroLancamento(ALLTRIM(loc_oPg.txt_4c_SGRUPO.Value), ALLTRIM(loc_oPg.txt_4c_SCONTA.Value), ALLTRIM(loc_oPg.txt_4c_Smoeda.Value))
1987:         ENDIF
1988:     ENDPROC
1989: 
1990:     PROCEDURE ValidarMoeda(par_nKeyCode, par_nShiftAltCtrl)
1991:         THIS.ProcessarMudancaMoeda("D")
1992:     ENDPROC
1993: 
1994:     PROCEDURE ValidarSmoeda(par_nKeyCode, par_nShiftAltCtrl)
1995:         THIS.ProcessarMudancaMoeda("S")
1996:     ENDPROC
1997: 
1998:     *===========================================================================
1999:     * AbrirLookupMoeda / AbrirLookupSMoeda - legado usa fwbuscasel em
2000:     * crSigCdMoe; no sistema novo, FormBuscaAuxiliar em SigCdMoe (CMoes/DMoes)
2001:     *===========================================================================
2002:     PROCEDURE AbrirLookupMoeda()
2003:         LOCAL loc_oPg, loc_oBusca
2004: 
2005:         loc_oPg = THIS.pgf_4c_Paginas.Page2
2006: 
2007:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2008:             "SigCdMoe", "cursor_4c_BuscaMoeda", "CMoes", ;
2009:             ALLTRIM(loc_oPg.txt_4c_MOEDA.Value), "Moedas")
2010: 
2011:         IF VARTYPE(loc_oBusca) = "O"
2012:             IF !loc_oBusca.this_lAchouRegistro
2013:                 loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
2014:                 loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
2015:                 loc_oBusca.Show()
2016:             ENDIF
2017: 
2018:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
2019:                 loc_oPg.txt_4c_MOEDA.Value = ALLTRIM(cursor_4c_BuscaMoeda.CMoes)
2020:             ELSE
2021:                 loc_oPg.txt_4c_MOEDA.Value = ""
2022:             ENDIF
2023: 
2024:             loc_oBusca.Release()
2025:         ENDIF
2026: 
2027:         IF USED("cursor_4c_BuscaMoeda")
2028:             USE IN cursor_4c_BuscaMoeda
2029:         ENDIF
2030: 
2031:         *-- sincroniza o dedup com o valor final (permite reabrir o lookup se
2032:         *-- o usuario digitar de novo o mesmo codigo invalido)
2033:         THIS.this_cUltimaMoedaValidada = ALLTRIM(loc_oPg.txt_4c_MOEDA.Value)
2034:     ENDPROC
2035: 
2036:     PROCEDURE AbrirLookupSMoeda()
2037:         LOCAL loc_oPg, loc_oBusca
2038: 
2039:         loc_oPg = THIS.pgf_4c_Paginas.Page2
2040: 
2041:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2042:             "SigCdMoe", "cursor_4c_BuscaSMoeda", "CMoes", ;
2043:             ALLTRIM(loc_oPg.txt_4c_Smoeda.Value), "Moedas")
2044: 
2045:         IF VARTYPE(loc_oBusca) = "O"
2046:             IF !loc_oBusca.this_lAchouRegistro
2047:                 loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
2048:                 loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
2049:                 loc_oBusca.Show()
2050:             ENDIF
2051: 
2052:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSMoeda")
2053:                 loc_oPg.txt_4c_Smoeda.Value = ALLTRIM(cursor_4c_BuscaSMoeda.CMoes)
2054:             ELSE
2055:                 loc_oPg.txt_4c_Smoeda.Value = ""
2056:             ENDIF
2057: 
2058:             loc_oBusca.Release()
2059:         ENDIF
2060: 
2061:         IF USED("cursor_4c_BuscaSMoeda")
2062:             USE IN cursor_4c_BuscaSMoeda
2063:         ENDIF
2064: 
2065:         *-- sincroniza o dedup com o valor final (permite reabrir o lookup se
2066:         *-- o usuario digitar de novo o mesmo codigo invalido)
2067:         THIS.this_cUltimaSMoedaValidada = ALLTRIM(loc_oPg.txt_4c_Smoeda.Value)
2068:     ENDPROC
2069: 
2070:     *===========================================================================
2071:     * ValidarValor - LostFocus de txt_4c_VALOR (legado: Get_VALOR.Valid)
2072:     *===========================================================================
2073:     PROCEDURE ValidarValor(par_nKeyCode, par_nShiftAltCtrl)
2074:         LOCAL loc_oPg
2075: 
2076:         loc_oPg = THIS.pgf_4c_Paginas.Page2
2077: 
2078:         IF loc_oPg.txt_4c_VALOR.Value < 0
2079:             MsgAviso("Valor Inv" + CHR(225) + "lido...")
2080:             loc_oPg.txt_4c_VALOR.Value = 0
2081:             RETURN
2082:         ENDIF
2083: 
2084:         IF loc_oPg.txt_4c_SCOTACAO.Value != 0
2085:             loc_oPg.txt_4c_SVALOR.Value = loc_oPg.txt_4c_VALOR.Value * loc_oPg.txt_4c_COTACAO.Value / loc_oPg.txt_4c_SCOTACAO.Value
2086:         ENDIF
2087:     ENDPROC
2088: 
2089:     *===========================================================================
2090:     * ValidarCotacao / ValidarSCotacao - LostFocus de txt_4c_COTACAO e
2091:     * txt_4c_SCOTACAO (legado: Get_COTACAO.Valid / Get_SCOTACAO.Valid)
2092:     * Ambos recalculam o SValor a partir de Valor*Cotacao/SCotacao
2093:     *===========================================================================
2094:     PROCEDURE ValidarCotacao(par_nKeyCode, par_nShiftAltCtrl)
2095:         LOCAL loc_oPg
2096: 
2097:         loc_oPg = THIS.pgf_4c_Paginas.Page2
2098: 
2099:         IF loc_oPg.txt_4c_SCOTACAO.Value != 0
2100:             loc_oPg.txt_4c_SVALOR.Value = loc_oPg.txt_4c_VALOR.Value * loc_oPg.txt_4c_COTACAO.Value / loc_oPg.txt_4c_SCOTACAO.Value
2101:         ENDIF
2102:     ENDPROC
2103: 
2104:     PROCEDURE ValidarSCotacao(par_nKeyCode, par_nShiftAltCtrl)
2105:         LOCAL loc_oPg
2106: 
2107:         loc_oPg = THIS.pgf_4c_Paginas.Page2
2108: 
2109:         IF loc_oPg.txt_4c_SCOTACAO.Value != 0
2110:             loc_oPg.txt_4c_SVALOR.Value = loc_oPg.txt_4c_VALOR.Value * loc_oPg.txt_4c_COTACAO.Value / loc_oPg.txt_4c_SCOTACAO.Value
2111:         ENDIF
2112:     ENDPROC
2113: 
2114:     *===========================================================================
2115:     * ValidarSValor - LostFocus de txt_4c_SVALOR (legado: Get_SVALOR.Valid)
2116:     * Quando o usuario digita o valor convertido diretamente, a cotacao da
2117:     * contrapartida eh recalculada a partir dele (em vez do caminho normal
2118:     * Cotacao -> SValor)
2119:     *===========================================================================
2120:     PROCEDURE ValidarSValor(par_nKeyCode, par_nShiftAltCtrl)
2121:         LOCAL loc_oPg
2122: 
2123:         loc_oPg = THIS.pgf_4c_Paginas.Page2
2124: 
2125:         IF loc_oPg.txt_4c_SVALOR.Value != 0
2126:             loc_oPg.txt_4c_SCOTACAO.Value = (loc_oPg.txt_4c_VALOR.Value * loc_oPg.txt_4c_COTACAO.Value) / loc_oPg.txt_4c_SVALOR.Value
2127:         ENDIF
2128:     ENDPROC
2129: 
2130:     *===========================================================================
2131:     * BtnAlterarCotacaoClick / BtnAlterarSCotacaoClick - legado abre
2132:     * "Do Form SigOpAlC" (tela auxiliar nao migrada) para digitar manualmente
2133:     * a cotacao; substituido por INPUTBOX() mantendo o efeito (grava a nova
2134:     * cotacao + usuario que alterou + recalcula o valor convertido)
2135:     *===========================================================================
2136:     PROCEDURE BtnAlterarCotacaoClick()
2137:         LOCAL loc_oPg, loc_cResp, loc_nNovaCotacao
2138: 
2139:         loc_oPg  = THIS.pgf_4c_Paginas.Page2
2140:         loc_cResp = INPUTBOX("Informe a nova cota" + CHR(231) + CHR(227) + "o para " + ALLTRIM(loc_oPg.txt_4c_MOEDA.Value) + ":", ;
2141:             "Alterar Cota" + CHR(231) + CHR(227) + "o", TRANSFORM(loc_oPg.txt_4c_COTACAO.Value))
2142: 
2143:         IF !EMPTY(loc_cResp)
2144:             loc_nNovaCotacao = VAL(loc_cResp)
2145:             IF loc_nNovaCotacao > 0
2146:                 loc_oPg.txt_4c_COTACAO.Value = loc_nNovaCotacao
2147:                 IF VARTYPE(THIS.this_oBusinessObject) = "O"
2148:                     THIS.this_oBusinessObject.this_cCotusus = gc_4c_UsuarioLogado
2149:                 ENDIF
2150:                 IF loc_oPg.txt_4c_SCOTACAO.Value != 0
2151:                     loc_oPg.txt_4c_SVALOR.Value = loc_oPg.txt_4c_VALOR.Value * loc_oPg.txt_4c_COTACAO.Value / loc_oPg.txt_4c_SCOTACAO.Value
2152:                 ENDIF
2153:             ENDIF
2154:         ENDIF
2155:     ENDPROC
2156: 
2157:     PROCEDURE BtnAlterarSCotacaoClick()
2158:         LOCAL loc_oPg, loc_cResp, loc_nNovaCotacao
2159: 
2160:         loc_oPg  = THIS.pgf_4c_Paginas.Page2
2161:         loc_cResp = INPUTBOX("Informe a nova cota" + CHR(231) + CHR(227) + "o para " + ALLTRIM(loc_oPg.txt_4c_Smoeda.Value) + ":", ;
2162:             "Alterar Cota" + CHR(231) + CHR(227) + "o", TRANSFORM(loc_oPg.txt_4c_SCOTACAO.Value))
2163: 
2164:         IF !EMPTY(loc_cResp)
2165:             loc_nNovaCotacao = VAL(loc_cResp)
2166:             IF loc_nNovaCotacao > 0
2167:                 loc_oPg.txt_4c_SCOTACAO.Value = loc_nNovaCotacao
2168:                 IF VARTYPE(THIS.this_oBusinessObject) = "O"
2169:                     THIS.this_oBusinessObject.this_cCotusus = gc_4c_UsuarioLogado
2170:                 ENDIF
2171:                 IF loc_oPg.txt_4c_SCOTACAO.Value != 0
2172:                     loc_oPg.txt_4c_SVALOR.Value = loc_oPg.txt_4c_VALOR.Value * loc_oPg.txt_4c_COTACAO.Value / loc_oPg.txt_4c_SCOTACAO.Value
2173:                 ENDIF
2174:             ENDIF
2175:         ENDIF
2176:     ENDPROC
2177: 
2178:     *===========================================================================
2179:     * BtnIncluirClick - Inclusao de novo lancamento
2180:     *===========================================================================
2181:     PROCEDURE BtnIncluirClick()
2182:         THIS.this_oBusinessObject.NovoRegistro()
2183:         THIS.LimparCampos()
2184:         THIS.this_cModoAtual = "INCLUIR"
2185:         THIS.HabilitarCampos(.T.)
2186:         THIS.AjustarBotoesPorModo()
2187:         THIS.AlternarPagina(2)
2188:     ENDPROC
2189: 
2190:     *===========================================================================
2191:     * BtnVisualizarClick - Visualizacao do lancamento selecionado na grade
2192:     *===========================================================================
2193:     PROCEDURE BtnVisualizarClick()
2194:         LOCAL loc_cChave
2195: 
2196:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
2197:             MsgAviso("Nenhum lan" + CHR(231) + "amento selecionado!")
2198:             RETURN
2199:         ENDIF
2200: 
2201:         loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
2202: 
2203:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
2204:             THIS.BOParaForm()
2205:             THIS.this_cModoAtual = "VISUALIZAR"
2206:             THIS.HabilitarCampos(.F.)
2207:             THIS.AjustarBotoesPorModo()
2208:             THIS.AlternarPagina(2)
2209:         ENDIF
2210:     ENDPROC
2211: 
2212:     *===========================================================================
2213:     * BtnAlterarClick - Alteracao do lancamento selecionado na grade
2214:     *===========================================================================
2215:     PROCEDURE BtnAlterarClick()
2216:         LOCAL loc_cChave
2217: 
2218:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
2219:             MsgAviso("Nenhum lan" + CHR(231) + "amento selecionado!")
2220:             RETURN
2221:         ENDIF
2222: 
2223:         loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
2224: 
2225:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
2226:             THIS.this_oBusinessObject.EditarRegistro()
2227:             THIS.BOParaForm()
2228:             THIS.this_cModoAtual = "ALTERAR"
2229:             THIS.HabilitarCampos(.T.)
2230:             THIS.AjustarBotoesPorModo()
2231:             THIS.AlternarPagina(2)
2232:         ENDIF
2233:     ENDPROC
2234: 
2235:     *===========================================================================
2236:     * BtnExcluirClick - Exclusao do lancamento selecionado na grade
2237:     *===========================================================================
2238:     PROCEDURE BtnExcluirClick()
2239:         LOCAL loc_cChave
2240: 
2241:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
2242:             MsgAviso("Nenhum lan" + CHR(231) + "amento selecionado!")
2243:             RETURN
2244:         ENDIF
2245: 
2246:         loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
2247: 
2248:         IF MsgConfirma("Confirma exclus" + CHR(227) + "o do lan" + CHR(231) + "amento selecionado?", "Confirma" + CHR(231) + CHR(227) + "o")
2249:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
2250:                 IF THIS.this_oBusinessObject.Excluir()
2251:                     MsgSucesso("Lan" + CHR(231) + "amento exclu" + CHR(237) + "do com sucesso!")
2252:                     THIS.CarregarLista()
2253:                 ENDIF
2254:             ENDIF
2255:         ENDIF
2256:     ENDPROC
2257: 
2258:     *===========================================================================
2259:     * BtnBuscarClick - Recarrega a grade com o periodo informado nos filtros
2260:     *===========================================================================
2261:     PROCEDURE BtnBuscarClick()
2262:         THIS.CarregarLista()
2263:     ENDPROC
2264: 
2265:     *===========================================================================
2266:     * BtnEncerrarClick - Fecha o formulario
2267:     *===========================================================================
2268:     PROCEDURE BtnEncerrarClick()
2269:         THIS.Release()
2270:     ENDPROC
2271: 
2272:     *===========================================================================
2273:     * BtnSalvarClick - Confirma a inclusao/alteracao do lancamento (Confirmar)
2274:     * Salvar() do BusinessBase decide INSERT/UPDATE sozinho (this_lNovoRegistro
2275:     * ja foi setado por NovoRegistro()/EditarRegistro() nos botoes de origem)
2276:     *===========================================================================
2277:     PROCEDURE BtnSalvarClick()
2278:         THIS.FormParaBO()
2279: 
2280:         IF THIS.this_oBusinessObject.Salvar()
2281:             MsgInfo("Lan" + CHR(231) + "amento salvo com sucesso!", "Confirmar")
2282:             THIS.AlternarPagina(1)
2283:         ELSE
2284:             IF !THIS.this_oBusinessObject.this_lErroExibido
2285:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o lan" + CHR(231) + "amento.", "Confirmar")
2286:             ENDIF
2287:         ENDIF
2288:     ENDPROC
2289: 
2290:     *===========================================================================
2291:     * BtnCancelarClick - Cancela a inclusao/alteracao/visualizacao e volta
2292:     * para a lista, recarregando a grade (CLAUDE.md/migration_guide Problema 2)
2293:     *===========================================================================
2294:     PROCEDURE BtnCancelarClick()
2295:         THIS.AlternarPagina(1)
2296:     ENDPROC
2297: 
2298:     *===========================================================================
2299:     * AjustarBotoesPorModo - Confirmar fica desabilitado em VISUALIZAR (padrao
2300:     * canonico frmcadastro: Confirmar disabled, Cancelar sempre enabled)
2301:     *===========================================================================
2302:     PROCEDURE AjustarBotoesPorModo()
2303:         LOCAL loc_oBotoesAcao
2304:         loc_oBotoesAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
2305: 
2306:         loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = (THIS.this_cModoAtual != "VISUALIZAR")
2307:         loc_oBotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
2308:     ENDPROC
2309: 
2310:     *===========================================================================
2311:     * LimparCampos - Limpa todos os campos editaveis da Page2 (modo INCLUIR)
2312:     *===========================================================================
2313:     PROTECTED PROCEDURE LimparCampos()
2314:         LOCAL loc_oPg
2315:         loc_oPg = THIS.pgf_4c_Paginas.Page2
2316: 
2317:         loc_oPg.txt_4c_Fweditdata_DATA.Value = {}
2318:         loc_oPg.txt_4c_Fweditdata_VENC.Value = {}
2319:         loc_oPg.txt_4c_DtEmis.Value          = {}
2320:         loc_oPg.txt_4c_Nota.Value            = ""
2321:         loc_oPg.txt_4c__Usuario.Value        = gc_4c_UsuarioLogado
2322:         loc_oPg.txt_4c_Job.Value             = ""
2323:         loc_oPg.txt_4c_DJob.Value            = ""
2324:         loc_oPg.txt_4c_DOCU.Value            = ""
2325:         loc_oPg.txt_4c_OPER.Value            = "D"
2326:         loc_oPg.txt_4c_Grupo.Value           = ""
2327:         loc_oPg.txt_4c_Dgrupo.Value          = ""
2328:         loc_oPg.txt_4c_Conta.Value           = ""
2329:         loc_oPg.txt_4c_Dconta.Value          = ""
2330:         loc_oPg.txt_4c_VALOR.Value           = 0
2331:         loc_oPg.txt_4c_MOEDA.Value           = ""
2332:         loc_oPg.txt_4c_COTACAO.Value         = 0
2333:         loc_oPg.txt_4c_SOPER.Value           = "C"
2334:         loc_oPg.txt_4c_SGRUPO.Value          = ""
2335:         loc_oPg.txt_4c_Sdgrupo.Value         = ""
2336:         loc_oPg.txt_4c_SCONTA.Value          = ""
2337:         loc_oPg.txt_4c_SDCONTA.Value         = ""
2338:         loc_oPg.txt_4c_SVALOR.Value          = 0
2339:         loc_oPg.txt_4c_Smoeda.Value          = ""
2340:         loc_oPg.txt_4c_SCOTACAO.Value        = 0
2341:         loc_oPg.txt_4c_HIST.Value            = ""
2342:         loc_oPg.txt_4c_Hist2.Value           = ""
2343:         loc_oPg.obj_4c_Opcao_conta.Value     = 1
2344: 
2345:         THIS.this_cUltimoGrupoValidado  = ""
2346:         THIS.this_cUltimaContaValidada  = ""
2347:         THIS.this_cUltimaMoedaValidada  = ""
2348:         THIS.this_cUltimoSGrupoValidado = ""
2349:         THIS.this_cUltimaSContaValidada = ""
2350:         THIS.this_cUltimaSMoedaValidada = ""
2351:         THIS.this_cUltimoJobValidado    = ""
2352: 
2353:         RETURN .T.
2354:     ENDPROC
2355: 
2356:     *===========================================================================
2357:     * HabilitarCampos - Habilita/desabilita os campos editaveis da Page2
2358:     * conforme o modo atual (INCLUIR/ALTERAR = .T., VISUALIZAR = .F.)
2359:     * Campos somente-leitura (descricoes de lookup, Usuario, SOPER) permanecem
2360:     * SEMPRE ReadOnly - nao entram nesta lista (regra #19 CLAUDE.md)
2361:     *===========================================================================
2362:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
2363:         LOCAL loc_oPg
2364:         loc_oPg = THIS.pgf_4c_Paginas.Page2
2365: 
2366:         loc_oPg.txt_4c_Fweditdata_DATA.Enabled = par_lHabilitar
2367:         loc_oPg.txt_4c_Fweditdata_VENC.Enabled = par_lHabilitar
2368:         loc_oPg.txt_4c_DtEmis.Enabled          = par_lHabilitar
2369:         loc_oPg.txt_4c_Nota.Enabled            = par_lHabilitar
2370:         loc_oPg.txt_4c_Job.Enabled             = par_lHabilitar
2371:         loc_oPg.txt_4c_DOCU.Enabled            = par_lHabilitar
2372:         loc_oPg.txt_4c_OPER.Enabled            = par_lHabilitar
2373:         loc_oPg.txt_4c_Grupo.Enabled           = par_lHabilitar
2374:         loc_oPg.txt_4c_Conta.Enabled           = par_lHabilitar
2375:         loc_oPg.txt_4c_VALOR.Enabled           = par_lHabilitar
2376:         loc_oPg.txt_4c_MOEDA.Enabled           = par_lHabilitar
2377:         loc_oPg.txt_4c_COTACAO.Enabled         = par_lHabilitar
2378:         loc_oPg.txt_4c_SGRUPO.Enabled          = par_lHabilitar
2379:         loc_oPg.txt_4c_SCONTA.Enabled          = par_lHabilitar
2380:         loc_oPg.txt_4c_SVALOR.Enabled          = par_lHabilitar
2381:         loc_oPg.txt_4c_Smoeda.Enabled          = par_lHabilitar
2382:         loc_oPg.txt_4c_SCOTACAO.Enabled        = par_lHabilitar
2383:         loc_oPg.txt_4c_HIST.Enabled            = par_lHabilitar
2384:         loc_oPg.txt_4c_Hist2.Enabled           = par_lHabilitar
2385:         loc_oPg.obj_4c_Opcao_conta.Enabled     = par_lHabilitar
2386:         loc_oPg.cmd_4c_Alteracotacao.Enabled   = par_lHabilitar
2387:         loc_oPg.cmd_4c_Alterascotacao.Enabled  = par_lHabilitar
2388: 
2389:         RETURN .T.
2390:     ENDPROC
2391: 
2392:     *===========================================================================
2393:     * FormParaBO - Transfere os valores da Page2 para o BusinessObject
2394:     * (chamado antes de Salvar())
2395:     *===========================================================================
2396:     PROTECTED PROCEDURE FormParaBO()
2397:         LOCAL loc_oPg, loc_oBO
2398:         loc_oPg = THIS.pgf_4c_Paginas.Page2
2399:         loc_oBO = THIS.this_oBusinessObject
2400: 
2401:         loc_oBO.this_dDatas     = loc_oPg.txt_4c_Fweditdata_DATA.Value
2402:         loc_oBO.this_dVencs     = loc_oPg.txt_4c_Fweditdata_VENC.Value
2403:         loc_oBO.this_dDtemis    = loc_oPg.txt_4c_DtEmis.Value
2404:         loc_oBO.this_cNfs       = ALLTRIM(loc_oPg.txt_4c_Nota.Value)
2405:         loc_oBO.this_cJobs      = ALLTRIM(loc_oPg.txt_4c_Job.Value)
2406:         loc_oBO.this_cDocus     = ALLTRIM(loc_oPg.txt_4c_DOCU.Value)
2407:         loc_oBO.this_cOpers     = ALLTRIM(loc_oPg.txt_4c_OPER.Value)
2408:         loc_oBO.this_cGrupos    = ALLTRIM(loc_oPg.txt_4c_Grupo.Value)
2409:         loc_oBO.this_cContas    = ALLTRIM(loc_oPg.txt_4c_Conta.Value)
2410:         loc_oBO.this_nValors    = loc_oPg.txt_4c_VALOR.Value
2411:         loc_oBO.this_cMoedas    = ALLTRIM(loc_oPg.txt_4c_MOEDA.Value)
2412:         loc_oBO.this_nCotacaos  = loc_oPg.txt_4c_COTACAO.Value
2413:         loc_oBO.this_cSopers    = ALLTRIM(loc_oPg.txt_4c_SOPER.Value)
2414:         loc_oBO.this_cSgrupos   = ALLTRIM(loc_oPg.txt_4c_SGRUPO.Value)
2415:         loc_oBO.this_cScontas   = ALLTRIM(loc_oPg.txt_4c_SCONTA.Value)
2416:         loc_oBO.this_nSvalors   = loc_oPg.txt_4c_SVALOR.Value
2417:         loc_oBO.this_cSmoedas   = ALLTRIM(loc_oPg.txt_4c_Smoeda.Value)
2418:         loc_oBO.this_nScotacaos = loc_oPg.txt_4c_SCOTACAO.Value
2419:         loc_oBO.this_cHists     = ALLTRIM(loc_oPg.txt_4c_HIST.Value)
2420:         loc_oBO.this_cHist2s    = ALLTRIM(loc_oPg.txt_4c_Hist2.Value)
2421:         loc_oBO.this_nContapgs  = IIF(loc_oPg.obj_4c_Opcao_conta.Value = 1, 0, 1)
2422: 
2423:         *-- Metadados que nao tem campo proprio na tela (preenchidos apenas
2424:         *-- quando ainda vazios, para nao sobrescrever o registro carregado
2425:         *-- em modo ALTERAR - CarregarPorCodigo ja os trouxe do banco)
2426:         IF EMPTY(ALLTRIM(NVL(loc_oBO.this_cEmps, "")))
2427:             loc_oBO.this_cEmps = go_4c_Sistema.cCodEmpresa
2428:         ENDIF
2429:         loc_oBO.this_cUsualts = gc_4c_UsuarioLogado
2430: 
2431:         RETURN .T.
2432:     ENDPROC
2433: 
2434:     *===========================================================================
2435:     * BOParaForm - Transfere os valores do BusinessObject para a Page2
2436:     * (chamado apos CarregarPorCodigo(), em Alterar/Visualizar)
2437:     *===========================================================================
2438:     PROTECTED PROCEDURE BOParaForm()
2439:         LOCAL loc_oPg, loc_oBO
2440:         loc_oPg = THIS.pgf_4c_Paginas.Page2
2441:         loc_oBO = THIS.this_oBusinessObject
2442: 
2443:         loc_oPg.txt_4c_Fweditdata_DATA.Value = loc_oBO.this_dDatas
2444:         loc_oPg.txt_4c_Fweditdata_VENC.Value = loc_oBO.this_dVencs
2445:         loc_oPg.txt_4c_DtEmis.Value          = loc_oBO.this_dDtemis
2446:         loc_oPg.txt_4c_Nota.Value            = loc_oBO.this_cNfs
2447:         loc_oPg.txt_4c__Usuario.Value        = loc_oBO.this_cUsualts
2448:         loc_oPg.txt_4c_Job.Value             = loc_oBO.this_cJobs
2449:         loc_oPg.txt_4c_DOCU.Value            = loc_oBO.this_cDocus
2450:         loc_oPg.txt_4c_OPER.Value            = loc_oBO.this_cOpers
2451:         loc_oPg.txt_4c_Grupo.Value           = loc_oBO.this_cGrupos
2452:         loc_oPg.txt_4c_Conta.Value           = loc_oBO.this_cContas
2453:         loc_oPg.txt_4c_VALOR.Value           = loc_oBO.this_nValors
2454:         loc_oPg.txt_4c_MOEDA.Value           = loc_oBO.this_cMoedas
2455:         loc_oPg.txt_4c_COTACAO.Value         = loc_oBO.this_nCotacaos
2456:         loc_oPg.txt_4c_SOPER.Value           = loc_oBO.this_cSopers
2457:         loc_oPg.txt_4c_SGRUPO.Value          = loc_oBO.this_cSgrupos
2458:         loc_oPg.txt_4c_SCONTA.Value          = loc_oBO.this_cScontas
2459:         loc_oPg.txt_4c_SVALOR.Value          = loc_oBO.this_nSvalors
2460:         loc_oPg.txt_4c_Smoeda.Value          = loc_oBO.this_cSmoedas
2461:         loc_oPg.txt_4c_SCOTACAO.Value        = loc_oBO.this_nScotacaos
2462:         loc_oPg.txt_4c_HIST.Value            = loc_oBO.this_cHists
2463:         loc_oPg.txt_4c_Hist2.Value           = loc_oBO.this_cHist2s
2464:         loc_oPg.obj_4c_Opcao_conta.Value     = IIF(loc_oBO.this_nContapgs = 0, 1, 2)
2465: 
2466:         *-- Descricoes de lookup (nao existem no BO - resolvidas com as
2467:         *-- MESMAS funcoes globais ja portadas usadas em ValidarGrupo/
2468:         *-- ValidarConta/ValidarSGrupo/ValidarSConta/ValidarJob, chamadas
2469:         *-- direto para so preencher a descricao, sem os efeitos colaterais
2470:         *-- de validacao interativa (MsgErro/limpeza de campo/aviso)
2471:         loc_oPg.txt_4c_Dgrupo.Value  = ""
2472:         IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_Grupo.Value))
2473:             fAcessoContab(gc_4c_UsuarioLogado, "C", ALLTRIM(loc_oPg.txt_4c_Grupo.Value), ;
2474:                 loc_oPg.txt_4c_Grupo, loc_oPg.txt_4c_Dgrupo, loc_oPg.txt_4c_Conta.Value, loc_oPg.txt_4c_Fweditdata_DATA.Value)
2475:         ENDIF
2476: 
2477:         loc_oPg.txt_4c_Dconta.Value = ""
2478:         IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_Conta.Value))

*-- Linhas 2498 a 2555:
2498:                 loc_oPg.txt_4c_Job, loc_oPg.txt_4c_DJob)
2499:         ENDIF
2500: 
2501:         THIS.this_cUltimoGrupoValidado   = ALLTRIM(loc_oPg.txt_4c_Grupo.Value)
2502:         THIS.this_cUltimaContaValidada   = ALLTRIM(loc_oPg.txt_4c_Conta.Value)
2503:         THIS.this_cUltimaMoedaValidada   = ALLTRIM(loc_oPg.txt_4c_MOEDA.Value)
2504:         THIS.this_cUltimoSGrupoValidado  = ALLTRIM(loc_oPg.txt_4c_SGRUPO.Value)
2505:         THIS.this_cUltimaSContaValidada  = ALLTRIM(loc_oPg.txt_4c_SCONTA.Value)
2506:         THIS.this_cUltimaSMoedaValidada  = ALLTRIM(loc_oPg.txt_4c_Smoeda.Value)
2507:         THIS.this_cUltimoJobValidado     = ALLTRIM(loc_oPg.txt_4c_Job.Value)
2508: 
2509:         RETURN .T.
2510:     ENDPROC
2511: 
2512:     *===========================================================================
2513:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
2514:     * REGRA: Deve iterar Pages E Controls para PageFrames aninhados
2515:     *===========================================================================
2516:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2517:         LOCAL loc_nI, loc_oObjeto, loc_nP
2518: 
2519:         FOR loc_nI = 1 TO par_oContainer.ControlCount
2520:             loc_oObjeto = par_oContainer.Controls(loc_nI)
2521: 
2522:             IF VARTYPE(loc_oObjeto) = "O"
2523:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
2524:                     loc_oObjeto.Visible = .T.
2525:                 ENDIF
2526: 
2527:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
2528:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
2529:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
2530:                     ENDFOR
2531:                 ENDIF
2532: 
2533:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
2534:                     THIS.TornarControlesVisiveis(loc_oObjeto)
2535:                 ENDIF
2536:             ENDIF
2537:         ENDFOR
2538:     ENDPROC
2539: 
2540:     *===========================================================================
2541:     * Destroy - Libera recursos do formulario
2542:     *===========================================================================
2543:     PROCEDURE Destroy()
2544:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2545:             THIS.this_oBusinessObject = .NULL.
2546:         ENDIF
2547: 
2548:         IF USED("cursor_4c_Dados")
2549:             USE IN cursor_4c_Dados
2550:         ENDIF
2551: 
2552:         DODEFAULT()
2553:     ENDPROC
2554: 
2555: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigmvccrBO.prg):
*====================================================================
* sigmvccrBO.prg
*
* Business Object para Conta Corrente Geral
* Tabela: SigMvCcr
* Chave: cidchaves (PK Fortyus)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS sigmvccrBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigMvCcr)
    this_cCidchaves    = ""    && cidchaves   char(20)   - PK
    this_lAutos        = .F.   && autos       bit
    this_lConcs        = .F.   && concs       bit
    this_cContages     = ""    && contages    char(10)
    this_cContas       = ""    && contas      char(10)
    this_cContems      = ""    && contems     char(10)
    this_nCotacaos     = 0     && cotacaos    numeric(15,7)
    this_dDatalts      = {}    && datalts     datetime
    this_dDatas        = {}    && datas       datetime
    this_dDataconcs    = {}    && dataconcs   datetime
    this_dDatatrans    = {}    && datatrans   datetime
    this_dDatexcs      = {}    && datexcs     datetime
    this_cDocus        = ""    && docus       char(10)
    this_cDopes        = ""    && dopes       char(20)
    this_dDtemis       = {}    && dtemis      datetime
    this_cEmps         = ""    && emps        char(3)
    this_cGrupages     = ""    && grupages    char(10)
    this_cGrupems      = ""    && grupems     char(10)
    this_cGrupos       = ""    && grupos      char(10)
    this_cHists        = ""    && hists       char(60)
    this_cLocals       = ""    && locals      char(10)
    this_cMoedas       = ""    && moedas      char(3)
    this_cNfs          = ""    && nfs         char(10)
    this_nNlancs       = 0     && nlancs      numeric(6,0)
    this_nNopers       = 0     && nopers      numeric(7,0)
    this_nNtrans       = 0     && ntrans      numeric(6,0)
    this_nNumes        = 0     && numes       numeric(6,0)
    this_cOpers        = ""    && opers       char(1) - D/C
    this_nSaldocs      = 0     && saldocs     numeric(15,2)
    this_nSaldons      = 0     && saldons     numeric(15,2)
    this_nSaldos       = 0     && saldos      numeric(15,2)
    this_cScontas      = ""    && scontas     char(10)
    this_nScotacaos    = 0     && scotacaos   numeric(15,7)
    this_cSgrupos      = ""    && sgrupos     char(10)
    this_cShists       = ""    && shists      char(40)
    this_cSmoedas      = ""    && smoedas     char(3)
    this_cSopers       = ""    && sopers      char(1) - D/C
    this_nSvalors      = 0     && svalors     numeric(11,2)
    this_cTipos        = ""    && tipos       char(1)
    this_cTitbans      = ""    && titbans     char(12)
    this_cTitulos      = ""    && titulos     char(10)
    this_cUsualts      = ""    && usualts     char(10)
    this_cUsuexcs      = ""    && usuexcs     char(10)
    this_nValliqs      = 0     && valliqs     numeric(11,2)
    this_nValocurs     = 0     && valocurs    numeric(11,2)
    this_nValors       = 0     && valors      numeric(11,2)
    this_nValpags      = 0     && valpags     numeric(11,2)
    this_dVencs        = {}    && vencs       datetime
    this_cVlancs       = ""    && vlancs      char(10)
    this_cVopers       = ""    && vopers      char(13)
    this_nContapgs     = 0     && contapgs    numeric(1,0)
    this_cDopcs        = ""    && dopcs       char(20)
    this_nNumcs        = 0     && numcs       numeric(6,0)
    this_cCotusus      = ""    && cotusus     char(10)
    this_cBcontas      = ""    && bcontas     char(10)
    this_cBgrupos      = ""    && bgrupos     char(10)
    this_nBorderos     = 0     && borderos    numeric(6,0)
    this_cHist2s       = ""    && hist2s      char(80)
    this_nIntconts     = 0     && intconts    numeric(6,0)
    this_cUsuconcs     = ""    && usuconcs    char(10)
    this_cAuditors     = ""    && auditors    char(10)
    this_dDtaudits     = {}    && dtaudits    datetime
    this_nValprev      = 0     && valprev     numeric(11,2)
    this_cEmpdopncs    = ""    && empdopncs   char(29)
    this_cEmpdopnums   = ""    && empdopnums  char(29)
    this_cGruconmoes   = ""    && gruconmoes  char(23)
    this_cPagos        = ""    && pagos       char(1)
    this_cDopotps      = ""    && dopotps     char(23)
    this_cUsupagos     = ""    && usupagos    char(10)
    this_nTitcancs     = 0     && titcancs    numeric(1,0)
    this_dDtconfs      = {}    && dtconfs     datetime
    this_cUsuconfs     = ""    && usuconfs    char(10)
    this_nNopercancs   = 0     && nopercancs  numeric(7,0)
    this_cEspecienfs   = ""    && especienfs  char(6)
    this_cJobs         = ""    && jobs        char(10)
    this_nImpostos     = 0     && impostos    numeric(11,2)
    this_nTpimpostos   = 0     && tpimpostos  numeric(2,0)
    this_cTitpais      = ""    && titpais     char(10)
    this_cEmpccs       = ""    && empccs      char(3)
    this_nRecor        = 0     && recor       numeric(1,0)
    this_cCompet       = ""    && compet      char(7)
    this_cEmpos        = ""    && empos       char(3)
    this_cOridopnums   = ""    && oridopnums  char(29)
    this_cPastas       = ""    && pastas      text
    this_cRcontas      = ""    && rcontas     char(10)
    this_cTpdocnf      = ""    && tpdocnf     char(2)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigMvCcr"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "sigmvccrBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna a chave primaria (cidchaves) para
    * uso em RegistrarAuditoria()
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas do cursor SQL para as
    * propriedades do BO. SEMPRE usar SELECT (par_cAliasCursor) antes de
    * acessar os campos (regra #8 CLAUDE.md).
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cCidchaves = TratarNulo(cidchaves, "C")
                IF VARTYPE(autos) = "L"
                    THIS.this_lAutos = autos
                ELSE
                    THIS.this_lAutos = (NVL(autos, 0) = 1)
                ENDIF
                IF VARTYPE(concs) = "L"
                    THIS.this_lConcs = concs
                ELSE
                    THIS.this_lConcs = (NVL(concs, 0) = 1)
                ENDIF
                THIS.this_cContages = TratarNulo(contages, "C")
                THIS.this_cContas = TratarNulo(contas, "C")
                THIS.this_cContems = TratarNulo(contems, "C")
                THIS.this_nCotacaos = TratarNulo(cotacaos, "N")
                THIS.this_dDatalts = TratarNulo(datalts, "D")
                THIS.this_dDatas = TratarNulo(datas, "D")
                THIS.this_dDataconcs = TratarNulo(dataconcs, "D")
                THIS.this_dDatatrans = TratarNulo(datatrans, "D")
                THIS.this_dDatexcs = TratarNulo(datexcs, "D")
                THIS.this_cDocus = TratarNulo(docus, "C")
                THIS.this_cDopes = TratarNulo(dopes, "C")
                THIS.this_dDtemis = TratarNulo(dtemis, "D")
                THIS.this_cEmps = TratarNulo(emps, "C")
                THIS.this_cGrupages = TratarNulo(grupages, "C")
                THIS.this_cGrupems = TratarNulo(grupems, "C")
                THIS.this_cGrupos = TratarNulo(grupos, "C")
                THIS.this_cHists = TratarNulo(hists, "C")
                THIS.this_cLocals = TratarNulo(locals, "C")
                THIS.this_cMoedas = TratarNulo(moedas, "C")
                THIS.this_cNfs = TratarNulo(nfs, "C")
                THIS.this_nNlancs = TratarNulo(nlancs, "N")
                THIS.this_nNopers = TratarNulo(nopers, "N")
                THIS.this_nNtrans = TratarNulo(ntrans, "N")
                THIS.this_nNumes = TratarNulo(numes, "N")
                THIS.this_cOpers = TratarNulo(opers, "C")
                THIS.this_nSaldocs = TratarNulo(saldocs, "N")
                THIS.this_nSaldons = TratarNulo(saldons, "N")
                THIS.this_nSaldos = TratarNulo(saldos, "N")
                THIS.this_cScontas = TratarNulo(scontas, "C")
                THIS.this_nScotacaos = TratarNulo(scotacaos, "N")
                THIS.this_cSgrupos = TratarNulo(sgrupos, "C")
                THIS.this_cShists = TratarNulo(shists, "C")
                THIS.this_cSmoedas = TratarNulo(smoedas, "C")
                THIS.this_cSopers = TratarNulo(sopers, "C")
                THIS.this_nSvalors = TratarNulo(svalors, "N")
                THIS.this_cTipos = TratarNulo(tipos, "C")
                THIS.this_cTitbans = TratarNulo(titbans, "C")
                THIS.this_cTitulos = TratarNulo(titulos, "C")
                THIS.this_cUsualts = TratarNulo(usualts, "C")
                THIS.this_cUsuexcs = TratarNulo(usuexcs, "C")
                THIS.this_nValliqs = TratarNulo(valliqs, "N")
                THIS.this_nValocurs = TratarNulo(valocurs, "N")
                THIS.this_nValors = TratarNulo(valors, "N")
                THIS.this_nValpags = TratarNulo(valpags, "N")
                THIS.this_dVencs = TratarNulo(vencs, "D")
                THIS.this_cVlancs = TratarNulo(vlancs, "C")
                THIS.this_cVopers = TratarNulo(vopers, "C")
                THIS.this_nContapgs = TratarNulo(contapgs, "N")
                THIS.this_cDopcs = TratarNulo(dopcs, "C")
                THIS.this_nNumcs = TratarNulo(numcs, "N")
                THIS.this_cCotusus = TratarNulo(cotusus, "C")
                THIS.this_cBcontas = TratarNulo(bcontas, "C")
                THIS.this_cBgrupos = TratarNulo(bgrupos, "C")
                THIS.this_nBorderos = TratarNulo(borderos, "N")
                THIS.this_cHist2s = TratarNulo(hist2s, "C")
                THIS.this_nIntconts = TratarNulo(intconts, "N")
                THIS.this_cUsuconcs = TratarNulo(usuconcs, "C")
                THIS.this_cAuditors = TratarNulo(auditors, "C")
                THIS.this_dDtaudits = TratarNulo(dtaudits, "D")
                THIS.this_nValprev = TratarNulo(valprev, "N")
                THIS.this_cEmpdopncs = TratarNulo(empdopncs, "C")
                THIS.this_cEmpdopnums = TratarNulo(empdopnums, "C")
                THIS.this_cGruconmoes = TratarNulo(gruconmoes, "C")
                THIS.this_cPagos = TratarNulo(pagos, "C")
                THIS.this_cDopotps = TratarNulo(dopotps, "C")
                THIS.this_cUsupagos = TratarNulo(usupagos, "C")
                THIS.this_nTitcancs = TratarNulo(titcancs, "N")
                THIS.this_dDtconfs = TratarNulo(dtconfs, "D")
                THIS.this_cUsuconfs = TratarNulo(usuconfs, "C")
                THIS.this_nNopercancs = TratarNulo(nopercancs, "N")
                THIS.this_cEspecienfs = TratarNulo(especienfs, "C")
                THIS.this_cJobs = TratarNulo(jobs, "C")
                THIS.this_nImpostos = TratarNulo(impostos, "N")
                THIS.this_nTpimpostos = TratarNulo(tpimpostos, "N")
                THIS.this_cTitpais = TratarNulo(titpais, "C")
                THIS.this_cEmpccs = TratarNulo(empccs, "C")
                THIS.this_nRecor = TratarNulo(recor, "N")
                THIS.this_cCompet = TratarNulo(compet, "C")
                THIS.this_cEmpos = TratarNulo(empos, "C")
                THIS.this_cOridopnums = TratarNulo(oridopnums, "C")
                THIS.this_cPastas = TratarNulo(pastas, "C")
                THIS.this_cRcontas = TratarNulo(rcontas, "C")
                THIS.this_cTpdocnf = TratarNulo(tpdocnf, "C")

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvccrBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro em SigMvCcr
    * PK (cidchaves) gerada via fUniqueIds() se ainda nao preenchida
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(NVL(THIS.this_cCidchaves, "")))
                THIS.this_cCidchaves = LEFT(fUniqueIds(), 20)
            ENDIF

            *-- Campo computado: Grupos + Contas + Moedas (chave de grupo/conta/moeda)
            THIS.this_cGruconmoes = PADR(THIS.this_cGrupos, 10) + PADR(THIS.this_cContas, 10) + PADR(THIS.this_cMoedas, 3)

            *-- Campos computados: Emps + Dopes + Numes/Numcs (chave de movimentacao)
            THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)
            THIS.this_cEmpdopncs = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumcs, 6)

            *-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
            *-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
            *-- com limite de 8192 caracteres ("Line is too long" em runtime).
            loc_cSQL = "INSERT INTO SigMvCcr ("
            loc_cSQL = loc_cSQL + "cidchaves, autos, concs, contages, contas, contems, cotacaos, datalts,"
            loc_cSQL = loc_cSQL + "datas, dataconcs, datatrans, datexcs, docus, dopes, dtemis, emps,"
            loc_cSQL = loc_cSQL + "grupages, grupems, grupos, hists, locals, moedas, nfs, nlancs,"
            loc_cSQL = loc_cSQL + "nopers, ntrans, numes, opers, saldocs, saldons, saldos, scontas,"
            loc_cSQL = loc_cSQL + "scotacaos, sgrupos, shists, smoedas, sopers, svalors, tipos, titbans,"
            loc_cSQL = loc_cSQL + "titulos, usualts, usuexcs, valliqs, valocurs, valors, valpags, vencs,"
            loc_cSQL = loc_cSQL + "vlancs, vopers, contapgs, dopcs, numcs, cotusus, bcontas, bgrupos,"
            loc_cSQL = loc_cSQL + "borderos, hist2s, intconts, usuconcs, auditors, dtaudits, valprev, empdopncs,"
            loc_cSQL = loc_cSQL + "empdopnums, gruconmoes, pagos, dopotps, usupagos, titcancs, dtconfs, usuconfs,"
            loc_cSQL = loc_cSQL + "nopercancs, especienfs, jobs, impostos, tpimpostos, titpais, empccs, recor,"
            loc_cSQL = loc_cSQL + "compet, empos, oridopnums, pastas, rcontas, tpdocnf"
            loc_cSQL = loc_cSQL + ") VALUES ("
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCidchaves, 20)) + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lAutos, 1, 0) + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lConcs, 1, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cContages, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cContas, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cContems, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCotacaos, 7) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatalts) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatas) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDataconcs) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatatrans) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatexcs) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDocus, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtemis) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrupages, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrupems, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cHists, 60)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cLocals, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cMoedas, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNfs, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNlancs, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNopers, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNtrans, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cOpers, 1)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nSaldocs, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nSaldons, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nSaldos, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cScontas, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nScotacaos, 7) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cSgrupos, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cShists, 40)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cSmoedas, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cSopers, 1)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nSvalors, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTipos, 1)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTitbans, 12)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTitulos, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsualts, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsuexcs, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValliqs, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValocurs, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValors, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValpags, 2) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dVencs) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cVlancs, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cVopers, 13)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nContapgs, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopcs, 20)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumcs, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCotusus, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cBcontas, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cBgrupos, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nBorderos, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cHist2s, 80)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nIntconts, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsuconcs, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cAuditors, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtaudits) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValprev, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpdopncs, 29)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGruconmoes, 23)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cPagos, 1)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopotps, 23)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsupagos, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTitcancs, 0) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtconfs) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsuconfs, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNopercancs, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEspecienfs, 6)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cJobs, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nImpostos, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTpimpostos, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTitpais, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpccs, 3)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nRecor, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCompet, 7)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpos, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cOridopnums, 29)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cPastas) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cRcontas, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTpdocnf, 2)) + ")"

            IF USED("cursor_4c_Insert")
                USE IN cursor_4c_Insert
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")

            IF loc_nResult < 0
                MsgErro("Erro ao inserir lancamento de conta corrente:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                IF USED("cursor_4c_Insert")
                    USE IN cursor_4c_Insert
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvccrBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente em SigMvCcr (por cidchaves)
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Campo computado: Grupos + Contas + Moedas (chave de grupo/conta/moeda)
            THIS.this_cGruconmoes = PADR(THIS.this_cGrupos, 10) + PADR(THIS.this_cContas, 10) + PADR(THIS.this_cMoedas, 3)

            *-- Campos computados: Emps + Dopes + Numes/Numcs (chave de movimentacao)
            THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)
            THIS.this_cEmpdopncs = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumcs, 6)

            *-- Data de alteracao
            THIS.this_dDatalts = DATETIME()

            *-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
            *-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
            *-- com limite de 8192 caracteres ("Line is too long" em runtime).
            loc_cSQL = "UPDATE SigMvCcr SET"
            loc_cSQL = loc_cSQL + " autos = " + IIF(THIS.this_lAutos, 1, 0) + ","
            loc_cSQL = loc_cSQL + " concs = " + IIF(THIS.this_lConcs, 1, 0) + ","
            loc_cSQL = loc_cSQL + " contages = " + EscaparSQL(LEFT(THIS.this_cContages, 10)) + ","
            loc_cSQL = loc_cSQL + " contas = " + EscaparSQL(LEFT(THIS.this_cContas, 10)) + ","
            loc_cSQL = loc_cSQL + " contems = " + EscaparSQL(LEFT(THIS.this_cContems, 10)) + ","
            loc_cSQL = loc_cSQL + " cotacaos = " + FormatarNumeroSQL(THIS.this_nCotacaos, 7) + ","
            loc_cSQL = loc_cSQL + " datalts = " + FormatarDataSQL(THIS.this_dDatalts) + ","
            loc_cSQL = loc_cSQL + " datas = " + FormatarDataSQL(THIS.this_dDatas) + ","
            loc_cSQL = loc_cSQL + " dataconcs = " + FormatarDataSQL(THIS.this_dDataconcs) + ","
            loc_cSQL = loc_cSQL + " datatrans = " + FormatarDataSQL(THIS.this_dDatatrans) + ","
            loc_cSQL = loc_cSQL + " datexcs = " + FormatarDataSQL(THIS.this_dDatexcs) + ","
            loc_cSQL = loc_cSQL + " docus = " + EscaparSQL(LEFT(THIS.this_cDocus, 10)) + ","
            loc_cSQL = loc_cSQL + " dopes = " + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
            loc_cSQL = loc_cSQL + " dtemis = " + FormatarDataSQL(THIS.this_dDtemis) + ","
            loc_cSQL = loc_cSQL + " emps = " + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
            loc_cSQL = loc_cSQL + " grupages = " + EscaparSQL(LEFT(THIS.this_cGrupages, 10)) + ","
            loc_cSQL = loc_cSQL + " grupems = " + EscaparSQL(LEFT(THIS.this_cGrupems, 10)) + ","
            loc_cSQL = loc_cSQL + " grupos = " + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + ","
            loc_cSQL = loc_cSQL + " hists = " + EscaparSQL(LEFT(THIS.this_cHists, 60)) + ","
            loc_cSQL = loc_cSQL + " locals = " + EscaparSQL(LEFT(THIS.this_cLocals, 10)) + ","
            loc_cSQL = loc_cSQL + " moedas = " + EscaparSQL(LEFT(THIS.this_cMoedas, 3)) + ","
            loc_cSQL = loc_cSQL + " nfs = " + EscaparSQL(LEFT(THIS.this_cNfs, 10)) + ","
            loc_cSQL = loc_cSQL + " nlancs = " + FormatarNumeroSQL(THIS.this_nNlancs, 0) + ","
            loc_cSQL = loc_cSQL + " nopers = " + FormatarNumeroSQL(THIS.this_nNopers, 0) + ","
            loc_cSQL = loc_cSQL + " ntrans = " + FormatarNumeroSQL(THIS.this_nNtrans, 0) + ","
            loc_cSQL = loc_cSQL + " numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
            loc_cSQL = loc_cSQL + " opers = " + EscaparSQL(LEFT(THIS.this_cOpers, 1)) + ","
            loc_cSQL = loc_cSQL + " saldocs = " + FormatarNumeroSQL(THIS.this_nSaldocs, 2) + ","
            loc_cSQL = loc_cSQL + " saldons = " + FormatarNumeroSQL(THIS.this_nSaldons, 2) + ","
            loc_cSQL = loc_cSQL + " saldos = " + FormatarNumeroSQL(THIS.this_nSaldos, 2) + ","
            loc_cSQL = loc_cSQL + " scontas = " + EscaparSQL(LEFT(THIS.this_cScontas, 10)) + ","
            loc_cSQL = loc_cSQL + " scotacaos = " + FormatarNumeroSQL(THIS.this_nScotacaos, 7) + ","
            loc_cSQL = loc_cSQL + " sgrupos = " + EscaparSQL(LEFT(THIS.this_cSgrupos, 10)) + ","
            loc_cSQL = loc_cSQL + " shists = " + EscaparSQL(LEFT(THIS.this_cShists, 40)) + ","
            loc_cSQL = loc_cSQL + " smoedas = " + EscaparSQL(LEFT(THIS.this_cSmoedas, 3)) + ","
            loc_cSQL = loc_cSQL + " sopers = " + EscaparSQL(LEFT(THIS.this_cSopers, 1)) + ","
            loc_cSQL = loc_cSQL + " svalors = " + FormatarNumeroSQL(THIS.this_nSvalors, 2) + ","
            loc_cSQL = loc_cSQL + " tipos = " + EscaparSQL(LEFT(THIS.this_cTipos, 1)) + ","
            loc_cSQL = loc_cSQL + " titbans = " + EscaparSQL(LEFT(THIS.this_cTitbans, 12)) + ","
            loc_cSQL = loc_cSQL + " titulos = " + EscaparSQL(LEFT(THIS.this_cTitulos, 10)) + ","
            loc_cSQL = loc_cSQL + " usualts = " + EscaparSQL(LEFT(THIS.this_cUsualts, 10)) + ","
            loc_cSQL = loc_cSQL + " usuexcs = " + EscaparSQL(LEFT(THIS.this_cUsuexcs, 10)) + ","
            loc_cSQL = loc_cSQL + " valliqs = " + FormatarNumeroSQL(THIS.this_nValliqs, 2) + ","
            loc_cSQL = loc_cSQL + " valocurs = " + FormatarNumeroSQL(THIS.this_nValocurs, 2) + ","
            loc_cSQL = loc_cSQL + " valors = " + FormatarNumeroSQL(THIS.this_nValors, 2) + ","
            loc_cSQL = loc_cSQL + " valpags = " + FormatarNumeroSQL(THIS.this_nValpags, 2) + ","
            loc_cSQL = loc_cSQL + " vencs = " + FormatarDataSQL(THIS.this_dVencs) + ","
            loc_cSQL = loc_cSQL + " vlancs = " + EscaparSQL(LEFT(THIS.this_cVlancs, 10)) + ","
            loc_cSQL = loc_cSQL + " vopers = " + EscaparSQL(LEFT(THIS.this_cVopers, 13)) + ","
            loc_cSQL = loc_cSQL + " contapgs = " + FormatarNumeroSQL(THIS.this_nContapgs, 0) + ","
            loc_cSQL = loc_cSQL + " dopcs = " + EscaparSQL(LEFT(THIS.this_cDopcs, 20)) + ","
            loc_cSQL = loc_cSQL + " numcs = " + FormatarNumeroSQL(THIS.this_nNumcs, 0) + ","
            loc_cSQL = loc_cSQL + " cotusus = " + EscaparSQL(LEFT(THIS.this_cCotusus, 10)) + ","
            loc_cSQL = loc_cSQL + " bcontas = " + EscaparSQL(LEFT(THIS.this_cBcontas, 10)) + ","
            loc_cSQL = loc_cSQL + " bgrupos = " + EscaparSQL(LEFT(THIS.this_cBgrupos, 10)) + ","
            loc_cSQL = loc_cSQL + " borderos = " + FormatarNumeroSQL(THIS.this_nBorderos, 0) + ","
            loc_cSQL = loc_cSQL + " hist2s = " + EscaparSQL(LEFT(THIS.this_cHist2s, 80)) + ","
            loc_cSQL = loc_cSQL + " intconts = " + FormatarNumeroSQL(THIS.this_nIntconts, 0) + ","
            loc_cSQL = loc_cSQL + " usuconcs = " + EscaparSQL(LEFT(THIS.this_cUsuconcs, 10)) + ","
            loc_cSQL = loc_cSQL + " auditors = " + EscaparSQL(LEFT(THIS.this_cAuditors, 10)) + ","
            loc_cSQL = loc_cSQL + " dtaudits = " + FormatarDataSQL(THIS.this_dDtaudits) + ","
            loc_cSQL = loc_cSQL + " valprev = " + FormatarNumeroSQL(THIS.this_nValprev, 2) + ","
            loc_cSQL = loc_cSQL + " empdopncs = " + EscaparSQL(LEFT(THIS.this_cEmpdopncs, 29)) + ","
            loc_cSQL = loc_cSQL + " empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ","
            loc_cSQL = loc_cSQL + " gruconmoes = " + EscaparSQL(LEFT(THIS.this_cGruconmoes, 23)) + ","
            loc_cSQL = loc_cSQL + " pagos = " + EscaparSQL(LEFT(THIS.this_cPagos, 1)) + ","
            loc_cSQL = loc_cSQL + " dopotps = " + EscaparSQL(LEFT(THIS.this_cDopotps, 23)) + ","
            loc_cSQL = loc_cSQL + " usupagos = " + EscaparSQL(LEFT(THIS.this_cUsupagos, 10)) + ","
            loc_cSQL = loc_cSQL + " titcancs = " + FormatarNumeroSQL(THIS.this_nTitcancs, 0) + ","
            loc_cSQL = loc_cSQL + " dtconfs = " + FormatarDataSQL(THIS.this_dDtconfs) + ","
            loc_cSQL = loc_cSQL + " usuconfs = " + EscaparSQL(LEFT(THIS.this_cUsuconfs, 10)) + ","
            loc_cSQL = loc_cSQL + " nopercancs = " + FormatarNumeroSQL(THIS.this_nNopercancs, 0) + ","
            loc_cSQL = loc_cSQL + " especienfs = " + EscaparSQL(LEFT(THIS.this_cEspecienfs, 6)) + ","
            loc_cSQL = loc_cSQL + " jobs = " + EscaparSQL(LEFT(THIS.this_cJobs, 10)) + ","
            loc_cSQL = loc_cSQL + " impostos = " + FormatarNumeroSQL(THIS.this_nImpostos, 2) + ","
            loc_cSQL = loc_cSQL + " tpimpostos = " + FormatarNumeroSQL(THIS.this_nTpimpostos, 0) + ","
            loc_cSQL = loc_cSQL + " titpais = " + EscaparSQL(LEFT(THIS.this_cTitpais, 10)) + ","
            loc_cSQL = loc_cSQL + " empccs = " + EscaparSQL(LEFT(THIS.this_cEmpccs, 3)) + ","
            loc_cSQL = loc_cSQL + " recor = " + FormatarNumeroSQL(THIS.this_nRecor, 0) + ","
            loc_cSQL = loc_cSQL + " compet = " + EscaparSQL(LEFT(THIS.this_cCompet, 7)) + ","
            loc_cSQL = loc_cSQL + " empos = " + EscaparSQL(LEFT(THIS.this_cEmpos, 3)) + ","
            loc_cSQL = loc_cSQL + " oridopnums = " + EscaparSQL(LEFT(THIS.this_cOridopnums, 29)) + ","
            loc_cSQL = loc_cSQL + " pastas = " + EscaparSQL(THIS.this_cPastas) + ","
            loc_cSQL = loc_cSQL + " rcontas = " + EscaparSQL(LEFT(THIS.this_cRcontas, 10)) + ","
            loc_cSQL = loc_cSQL + " tpdocnf = " + EscaparSQL(LEFT(THIS.this_cTpdocnf, 2))
            loc_cSQL = loc_cSQL + " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

            IF USED("cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

            IF loc_nResult < 0
                MsgErro("Erro ao atualizar lancamento de conta corrente:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                IF USED("cursor_4c_Update")
                    USE IN cursor_4c_Update
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvccrBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Lista lancamentos de conta corrente com filtro opcional
    * par_cFiltro: condicoes WHERE adicionais (ex: "AND a.datas BETWEEN ...")
    * Popula cursor_4c_Dados (usado pelo grd_4c_Lista do form)
    *====================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.cidchaves, a.datas, a.contas, a.scontas, a.hists," + ;
                " a.valors, a.svalors, a.smoedas, a.moedas, a.nfs, a.docus, a.opers" + ;
                " FROM SigMvCcr a WHERE 1 = 1"

            IF !EMPTY(ALLTRIM(NVL(par_cFiltro, "")))
                loc_cSQL = loc_cSQL + " " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.emps, a.datas"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult < 0
                MsgErro("Erro ao buscar lancamentos de conta corrente:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em sigmvccrBO.Buscar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * CarregarPorCodigo - Carrega um lancamento pela chave primaria (cidchaves)
    *====================================================================
    FUNCTION CarregarPorCodigo(par_cChave)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT * FROM SigMvCcr WHERE cidchaves = " + EscaparSQL(ALLTRIM(par_cChave))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
            ELSE
                MsgErro("Lan" + CHR(231) + "amento n" + CHR(227) + "o encontrado.", "Erro")
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro em sigmvccrBO.CarregarPorCodigo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * ExecutarExclusao - Exclui lancamento (por cidchaves)
    * Legado (msv_excluir): marca DatExcs/UsuExcs antes de excluir fisicamente
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigMvCcr SET datexcs = " + GETDATE() + ;
                ", usuexcs = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

            IF USED("cursor_4c_ExcUpd")
                USE IN cursor_4c_ExcUpd
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ExcUpd")

            IF loc_nResult < 0
                MsgErro("Erro ao marcar exclus" + CHR(227) + "o do lan" + CHR(231) + "amento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_ExcUpd")
                    USE IN cursor_4c_ExcUpd
                ENDIF

                loc_cSQL = "DELETE FROM SigMvCcr WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

                IF USED("cursor_4c_ExcDel")
                    USE IN cursor_4c_ExcDel
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ExcDel")

                IF loc_nResult < 0
                    MsgErro("Erro ao excluir lan" + CHR(231) + "amento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ENDIF

                IF USED("cursor_4c_ExcDel")
                    USE IN cursor_4c_ExcDel
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em sigmvccrBO.ExecutarExclusao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

