# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (10)
- [BINDEVENT-PARAMS] Handler 'ValidarEmpsDados' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarEmpsDados(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarVensDados' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarVensDados(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarDVensDados' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarDVensDados(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarSituacao' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarSituacao(par_nKeyCode, par_nShiftAltCtrl)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDVEN.Pagina.Lista.CntPeriodo): Top original=6 vs migrado 'lbl_4c_Label11' Top=425 (diff=419px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDVEN.Pagina.Lista.CntPeriodo): Left original=19 vs migrado 'lbl_4c_Label11' Left=305 (diff=286px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDVEN.Pagina.Lista.cntEmps): Top original=6 vs migrado 'lbl_4c_Label11' Top=425 (diff=419px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDVEN.Pagina.Lista.cntEmps): Left original=16 vs migrado 'lbl_4c_Label11' Left=305 (diff=289px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDVEN.Pagina.Lista.cntVens): Top original=7 vs migrado 'lbl_4c_Label11' Top=425 (diff=418px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDVEN.Pagina.Lista.cntVens): Left original=33 vs migrado 'lbl_4c_Label11' Left=305 (diff=272px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormVEN.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1798 linhas total):

*-- Linhas 23 a 158:
23:     this_cModoAtual      = "LISTA"
24: 
25:     *-- Guardas anti-retrigger para validacoes LostFocus (Problema 45)
26:     this_cUltimoEmpsValidado     = ""
27:     this_cUltimoVensValidado     = ""
28:     this_cUltimoDVensValidado    = ""
29:     this_cUltimaSituacaoValidada = ""
30: 
31:     *===========================================================================
32:     * Init - Inicializa o formulario
33:     * REGRA CRITICA: Apenas RETURN DODEFAULT()
34:     * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
35:     *===========================================================================
36:     PROCEDURE Init()
37:         RETURN DODEFAULT()
38:     ENDPROC
39: 
40:     *===========================================================================
41:     * InicializarForm - Configura estrutura completa
42:     * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
43:     *===========================================================================
44:     PROTECTED PROCEDURE InicializarForm()
45:         LOCAL loc_lSucesso
46:         loc_lSucesso = .F.
47: 
48:         TRY
49:             THIS.Caption = "Cadastro de Presen" + CHR(231) + "a de Vendedores"
50: 
51:             THIS.this_oBusinessObject = CREATEOBJECT("VENBO")
52: 
53:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
54:                 MostrarErro("Erro ao criar VENBO" + CHR(13) + ;
55:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
56:                     "FormVEN.InicializarForm")
57:             ELSE
58:                 THIS.ConfigurarPageFrame()
59:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
60:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
61:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
62:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
63:                 THIS.pgf_4c_Paginas.Visible = .T.
64:                 THIS.pgf_4c_Paginas.ActivePage = 1
65:                 THIS.this_cModoAtual = "LISTA"
66: 
67:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
68:                     THIS.CarregarLista()
69:                 ENDIF
70: 
71:                 loc_lSucesso = .T.
72:             ENDIF
73: 
74:         CATCH TO loException
75:             MostrarErro("Erro ao inicializar FormVEN:" + CHR(13) + ;
76:                 loException.Message + CHR(13) + ;
77:                 "Linha: " + TRANSFORM(loException.LineNo), ;
78:                 "FormVEN.InicializarForm")
79:         ENDTRY
80: 
81:         RETURN loc_lSucesso
82:     ENDPROC
83: 
84:     *===========================================================================
85:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
86:     * Top=-29 para esconder abas; controles compensam +29 no Top
87:     *===========================================================================
88:     PROTECTED PROCEDURE ConfigurarPageFrame()
89:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
90: 
91:         WITH THIS.pgf_4c_Paginas
92:             .PageCount = 2
93:             .Top       = -29
94:             .Left      = 0
95:             .Width     = THIS.Width
96:             .Height    = THIS.Height + 29
97:             .Tabs      = .F.
98:             .Visible   = .T.
99: 
100:             .Page1.Caption   = "Lista"
101:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
102:             .Page1.BackColor = RGB(255, 255, 255)
103: 
104:             .Page2.Caption   = "Dados"
105:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
106:             .Page2.BackColor = RGB(255, 255, 255)
107:         ENDWITH
108: 
109:         THIS.ConfigurarPaginaLista()
110:         THIS.ConfigurarPaginaDados()
111:     ENDPROC
112: 
113:     *===========================================================================
114:     * ConfigurarPaginaLista - Estrutura completa da Page1 (Lista)
115:     * Cabecalho canonico (1o AddObject) + botoes CRUD (Grupo_op) +
116:     * cnt_4c_Saida/Encerrar (padrao canonico, regra #10) + Grid de listagem
117:     *===========================================================================
118:     PROTECTED PROCEDURE ConfigurarPaginaLista()
119:         LOCAL loc_oPagina
120:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
121: 
122:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
123: 
124:         *-- Container Cabecalho (cntSombra no legado) - Top=2+29=31
125:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
126:         WITH loc_oPagina.cnt_4c_Cabecalho
127:             .Top         = 31
128:             .Left        = 0
129:             .Width       = THIS.Width
130:             .Height      = 80
131:             .BackColor   = RGB(100, 100, 100)
132:             .BorderWidth = 0
133:             .Visible     = .T.
134:         ENDWITH
135: 
136:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
137:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
138:             .Caption   = THIS.Caption
139:             .Top       = 15
140:             .Left      = 10
141:             .Width     = 769
142:             .Height    = 40
143:             .FontName  = "Tahoma"
144:             .FontSize  = 16
145:             .FontBold  = .T.
146:             .ForeColor = RGB(0, 0, 0)
147:             .BackStyle = 0
148:             .AutoSize  = .F.
149:             .Visible   = .T.
150:         ENDWITH
151: 
152:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
153:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
154:             .Caption   = THIS.Caption
155:             .Top       = 18
156:             .Left      = 10
157:             .Width     = 769
158:             .Height    = 46

*-- Linhas 200 a 420:
200:             .AutoSize        = .F.
201:             .Visible         = .T.
202:         ENDWITH
203:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
204: 
205:         *-- Botao Visualizar (Left=80)
206:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
207:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
208:             .Caption         = "Visualizar"
209:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
210:             .PicturePosition = 13
211:             .Top             = 5
212:             .Left            = 80
213:             .Width           = 75
214:             .Height          = 75
215:             .FontName        = "Tahoma"
216:             .FontBold        = .T.
217:             .FontItalic      = .T.
218:             .FontSize        = 8
219:             .ForeColor       = RGB(90, 90, 90)
220:             .BackColor       = RGB(255, 255, 255)
221:             .Themes          = .F.
222:             .SpecialEffect   = 0
223:             .MousePointer    = 15
224:             .WordWrap        = .T.
225:             .AutoSize        = .F.
226:             .Visible         = .T.
227:         ENDWITH
228:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
229: 
230:         *-- Botao Alterar (Left=155)
231:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
232:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
233:             .Caption         = "Alterar"
234:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
235:             .PicturePosition = 13
236:             .Top             = 5
237:             .Left            = 155
238:             .Width           = 75
239:             .Height          = 75
240:             .FontName        = "Tahoma"
241:             .FontBold        = .T.
242:             .FontItalic      = .T.
243:             .FontSize        = 8
244:             .ForeColor       = RGB(90, 90, 90)
245:             .BackColor       = RGB(255, 255, 255)
246:             .Themes          = .F.
247:             .SpecialEffect   = 0
248:             .MousePointer    = 15
249:             .WordWrap        = .T.
250:             .AutoSize        = .F.
251:             .Visible         = .T.
252:         ENDWITH
253:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
254: 
255:         *-- Botao Excluir (Left=230)
256:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
257:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
258:             .Caption         = "Excluir"
259:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
260:             .PicturePosition = 13
261:             .Top             = 5
262:             .Left            = 230
263:             .Width           = 75
264:             .Height          = 75
265:             .FontName        = "Tahoma"
266:             .FontBold        = .T.
267:             .FontItalic      = .T.
268:             .FontSize        = 8
269:             .ForeColor       = RGB(90, 90, 90)
270:             .BackColor       = RGB(255, 255, 255)
271:             .Themes          = .F.
272:             .SpecialEffect   = 0
273:             .MousePointer    = 15
274:             .WordWrap        = .T.
275:             .AutoSize        = .F.
276:             .Visible         = .T.
277:         ENDWITH
278:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
279: 
280:         *-- Botao Buscar (Left=305)
281:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
282:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
283:             .Caption         = "Buscar"
284:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
285:             .PicturePosition = 13
286:             .Top             = 5
287:             .Left            = 305
288:             .Width           = 75
289:             .Height          = 75
290:             .FontName        = "Tahoma"
291:             .FontBold        = .T.
292:             .FontItalic      = .T.
293:             .FontSize        = 8
294:             .ForeColor       = RGB(90, 90, 90)
295:             .BackColor       = RGB(255, 255, 255)
296:             .Themes          = .F.
297:             .SpecialEffect   = 0
298:             .MousePointer    = 15
299:             .WordWrap        = .T.
300:             .AutoSize        = .F.
301:             .Visible         = .T.
302:         ENDWITH
303:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
304: 
305:         *-- Container Saida - PADRAO CANONICO (prevalece sobre legado, regra #10)
306:         *-- Legado: Grupo_Saida.Left=919, Top=-1. Canonico: Left=917, Top=29, Width=90
307:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
308:         WITH loc_oPagina.cnt_4c_Saida
309:             .Top         = 29
310:             .Left        = 917
311:             .Width       = 90
312:             .Height      = 85
313:             .BackStyle   = 0
314:             .BorderWidth = 0
315:             .Visible     = .T.
316:         ENDWITH
317: 
318:         *-- Botao Encerrar - PADRAO CANONICO: Caption="Encerrar", Width=75, Height=75
319:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
320:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
321:             .Caption         = "Encerrar"
322:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
323:             .PicturePosition = 13
324:             .Top             = 5
325:             .Left            = 5
326:             .Width           = 75
327:             .Height          = 75
328:             .FontName        = "Tahoma"
329:             .FontBold        = .T.
330:             .FontItalic      = .T.
331:             .FontSize        = 8
332:             .ForeColor       = RGB(90, 90, 90)
333:             .BackColor       = RGB(255, 255, 255)
334:             .Themes          = .F.
335:             .SpecialEffect   = 0
336:             .MousePointer    = 15
337:             .WordWrap        = .T.
338:             .AutoSize        = .F.
339:             .Visible         = .T.
340:         ENDWITH
341:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
342: 
343:         *-- Grid de listagem de vendedores
344:         *-- Original: Grade.Top=131, Left=29, Width=940, Height=456
345:         *-- Canonico framework: Top=160 (131+29 compensacao), Left=26, Width=880, Height=456
346:         *-- (Width=880 para nao sobrepor cnt_4c_Saida em Left=917; Height preservada do legado)
347:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
348:         *-- ColumnCount FORA do WITH (Problema 36: dentro do WITH nao cria colunas imediatamente)
349:         loc_oPagina.grd_4c_Lista.ColumnCount = 11
350:         WITH loc_oPagina.grd_4c_Lista
351:             .Top                = 160
352:             .Left               = 26
353:             .Width              = 880
354:             .Height             = 456
355:             .FontName           = "Verdana"
356:             .FontSize           = 8
357:             .ForeColor          = RGB(90, 90, 90)
358:             .BackColor          = RGB(255, 255, 255)
359:             .GridLineColor      = RGB(238, 238, 238)
360:             .HighlightBackColor = RGB(255, 255, 255)
361:             .HighlightForeColor = RGB(15, 41, 104)
362:             .HighlightStyle     = 2
363:             .DeleteMark         = .F.
364:             .RecordMark         = .F.
365:             .RowHeight          = 16
366:             .ScrollBars         = 2
367:             .GridLines          = 3
368:             .Visible            = .T.
369:         ENDWITH
370:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")
371: 
372:         THIS.TornarControlesVisiveis(loc_oPagina)
373:     ENDPROC
374: 
375:     *===========================================================================
376:     * ConfigurarPaginaDados - Estrutura completa da Page2 (Dados)
377:     * Cabecalho canonico (1o AddObject) + container de botoes Confirmar/Cancelar
378:     * + todos os campos de dados do vendedor + lookups/validacoes via BINDEVENT
379:     *===========================================================================
380:     PROTECTED PROCEDURE ConfigurarPaginaDados()
381:         LOCAL loc_oPagina
382:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
383: 
384:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
385: 
386:         *-- Cabecalho cinza (identico ao da pagina Lista) - regra #11
387:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
388:         WITH loc_oPagina.cnt_4c_Cabecalho
389:             .Top           = 29
390:             .Left          = 0
391:             .Width         = THIS.Width
392:             .Height        = 80
393:             .BackColor     = RGB(100, 100, 100)
394:             .BorderWidth   = 0
395:             .SpecialEffect = 0
396:             .Visible       = .T.
397:         ENDWITH
398: 
399:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
400:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
401:             .Caption   = THIS.Caption
402:             .Top       = 15
403:             .Left      = 10
404:             .Width     = THIS.Width
405:             .Height    = 40
406:             .FontName  = "Tahoma"
407:             .FontSize  = 16
408:             .FontBold  = .T.
409:             .ForeColor = RGB(0, 0, 0)
410:             .BackStyle = 0
411:             .AutoSize  = .F.
412:             .Visible   = .T.
413:         ENDWITH
414: 
415:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
416:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
417:             .Caption   = THIS.Caption
418:             .Top       = 18
419:             .Left      = 10
420:             .Width     = THIS.Width

*-- Linhas 464 a 532:
464:             .AutoSize        = .F.
465:             .Visible         = .T.
466:         ENDWITH
467:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
468: 
469:         *-- Botao Cancelar (Grupo_Salva.Cancelar no legado)
470:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
471:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
472:             .Caption         = "Encerrar"
473:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
474:             .PicturePosition = 13
475:             .Top             = 5
476:             .Left            = 80
477:             .Width           = 75
478:             .Height          = 75
479:             .FontName        = "Tahoma"
480:             .FontBold        = .T.
481:             .FontItalic      = .T.
482:             .FontSize        = 8
483:             .ForeColor       = RGB(90, 90, 90)
484:             .BackColor       = RGB(255, 255, 255)
485:             .Themes          = .F.
486:             .SpecialEffect   = 0
487:             .MousePointer    = 15
488:             .WordWrap        = .T.
489:             .AutoSize        = .F.
490:             .Visible         = .T.
491:         ENDWITH
492:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
493: 
494:         *-- Codigo: Say7.Top=124+29=153, getcodigo.Top=121+29=150 (legado: When retorna .F. - nunca recebe foco)
495:         loc_oPagina.AddObject("lbl_4c_Label7", "Label")
496:         WITH loc_oPagina.lbl_4c_Label7
497:             .Caption   = "C" + CHR(243) + "digo : "
498:             .Top       = 153
499:             .Left      = 325
500:             .Width     = 47
501:             .Height    = 17
502:             .AutoSize  = .F.
503:             .Alignment = 0
504:             .FontName  = "Tahoma"
505:             .FontSize  = 8
506:             .ForeColor = RGB(90, 90, 90)
507:             .BackStyle = 0
508:             .Visible   = .T.
509:         ENDWITH
510: 
511:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
512:         WITH loc_oPagina.txt_4c_Codigo
513:             .Value         = ""
514:             .Top           = 150
515:             .Left          = 372
516:             .Width         = 160
517:             .Height        = 24
518:             .MaxLength     = 20
519:             .Enabled       = .F.
520:             .FontName      = "Tahoma"
521:             .FontSize      = 8
522:             .ForeColor     = RGB(90, 90, 90)
523:             .BackColor     = RGB(255, 255, 255)
524:             .BorderStyle   = 1
525:             .SpecialEffect = 0
526:             .Visible       = .T.
527:         ENDWITH
528: 
529:         *-- Loja/Empresa: Say1.Top=151+29=180, getEmps.Top=148+29=177 (editavel so em INCLUIR)
530:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
531:         WITH loc_oPagina.lbl_4c_Label1
532:             .Caption   = "Cod Loja : "

*-- Linhas 560 a 603:
560:             .Visible       = .T.
561:         ENDWITH
562:         *-- Lookup/validacao: LostFocus busca UF em SigcdEmp + fAcessoEmpresa (regra #27, VerificarAcessoEmpresa)
563:         BINDEVENT(loc_oPagina.txt_4c_Emps, "KeyPress", THIS, "ValidarEmpsDados")
564: 
565:         *-- Empresa Registro: Say12.Top=152+29=181, GetEmpReg.Top=148+29=177 (readonly, preenchido via pegaempreg)
566:         loc_oPagina.AddObject("lbl_4c_Label12", "Label")
567:         WITH loc_oPagina.lbl_4c_Label12
568:             .Caption   = "Empresa Registro :"
569:             .Top       = 181
570:             .Left      = 590
571:             .Width     = 95
572:             .Height    = 17
573:             .AutoSize  = .F.
574:             .Alignment = 0
575:             .FontName  = "Tahoma"
576:             .FontSize  = 8
577:             .ForeColor = RGB(90, 90, 90)
578:             .BackStyle = 0
579:             .Visible   = .T.
580:         ENDWITH
581: 
582:         loc_oPagina.AddObject("txt_4c_EmpReg", "TextBox")
583:         WITH loc_oPagina.txt_4c_EmpReg
584:             .Value         = ""
585:             .Top           = 177
586:             .Left          = 685
587:             .Width         = 33
588:             .Height        = 24
589:             .MaxLength     = 3
590:             .Enabled       = .F.
591:             .FontName      = "Tahoma"
592:             .FontSize      = 8
593:             .ForeColor     = RGB(90, 90, 90)
594:             .BackColor     = RGB(255, 255, 255)
595:             .BorderStyle   = 1
596:             .SpecialEffect = 0
597:             .Visible       = .T.
598:         ENDWITH
599: 
600:         *-- Estado: Say3.Top=178+29=207, GetUfs.Top=175+29=204 (readonly, preenchido via lookup de Emps)
601:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
602:         WITH loc_oPagina.lbl_4c_Label3
603:             .Caption   = "Estado : "

*-- Linhas 719 a 763:
719:             .Visible       = .T.
720:         ENDWITH
721:         *-- Lookup/validacao: fAcessoContas 'C'/'D' (portada em utils\functions.prg) + pegaempreg (so no Cod Vendedor)
722:         BINDEVENT(loc_oPagina.txt_4c_Vens,  "KeyPress", THIS, "ValidarVensDados")
723:         BINDEVENT(loc_oPagina.txt_4c_DVens, "KeyPress", THIS, "ValidarDVensDados")
724: 
725:         *-- Data Inicial: Say5.Top=259+29=288, getDtini.Top=256+29=285 (editavel em INCLUIR/ALTERAR)
726:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
727:         WITH loc_oPagina.lbl_4c_Label5
728:             .Caption   = "Data Inicial :"
729:             .Top       = 288
730:             .Left      = 305
731:             .Width     = 67
732:             .Height    = 17
733:             .AutoSize  = .F.
734:             .Alignment = 0
735:             .FontName  = "Tahoma"
736:             .FontSize  = 8
737:             .ForeColor = RGB(90, 90, 90)
738:             .BackStyle = 0
739:             .Visible   = .T.
740:         ENDWITH
741: 
742:         loc_oPagina.AddObject("txt_4c_Dtini", "TextBox")
743:         WITH loc_oPagina.txt_4c_Dtini
744:             .Value         = {}
745:             .Top           = 285
746:             .Left          = 372
747:             .Width         = 94
748:             .Height        = 24
749:             .FontName      = "Tahoma"
750:             .FontSize      = 8
751:             .ForeColor     = RGB(90, 90, 90)
752:             .BackColor     = RGB(255, 255, 255)
753:             .BorderStyle   = 1
754:             .SpecialEffect = 0
755:             .Visible       = .T.
756:         ENDWITH
757: 
758:         *-- Data Final: Say6.Top=286+29=315, GetDtfin.Top=283+29=312 (editavel em INCLUIR/ALTERAR)
759:         loc_oPagina.AddObject("lbl_4c_Label6", "Label")
760:         WITH loc_oPagina.lbl_4c_Label6
761:             .Caption   = "Data Final :"
762:             .Top       = 315
763:             .Left      = 310

*-- Linhas 823 a 866:
823:             .Visible       = .T.
824:         ENDWITH
825:         *-- Validacao: FOLGA exige fChecaAcesso ou usuario/vendedor na mesma empresa (transcrito do legado)
826:         BINDEVENT(loc_oPagina.cbo_4c_CmbSituas, "KeyPress", THIS, "ValidarSituacao")
827: 
828:         *-- Cargo: Say9.Top=340+29=369, cmbCargo.Top=337+29=366 (RowSource EXATO do legado)
829:         loc_oPagina.AddObject("lbl_4c_Label9", "Label")
830:         WITH loc_oPagina.lbl_4c_Label9
831:             .Caption   = "Cargo : "
832:             .Top       = 369
833:             .Left      = 329
834:             .Width     = 43
835:             .Height    = 17
836:             .AutoSize  = .F.
837:             .Alignment = 0
838:             .FontName  = "Tahoma"
839:             .FontSize  = 8
840:             .ForeColor = RGB(90, 90, 90)
841:             .BackStyle = 0
842:             .Visible   = .T.
843:         ENDWITH
844: 
845:         loc_oPagina.AddObject("cbo_4c_CmbCargo", "ComboBox")
846:         WITH loc_oPagina.cbo_4c_CmbCargo
847:             .RowSourceType = 1
848:             .RowSource     = "GERENTE,VENDEDOR"
849:             .Value         = ""
850:             .Top           = 366
851:             .Left          = 372
852:             .Width         = 160
853:             .Height        = 24
854:             .Style         = 2
855:             .FontName      = "Tahoma"
856:             .FontSize      = 8
857:             .ForeColor     = RGB(90, 90, 90)
858:             .BackColor     = RGB(255, 255, 255)
859:             .SpecialEffect = 1
860:             .Visible       = .T.
861:         ENDWITH
862: 
863:         *-- Comissao %: Say10.Top=369+29=398, getpdes.Top=364+29=393 (InputMask EXATO do legado)
864:         loc_oPagina.AddObject("lbl_4c_Label10", "Label")
865:         WITH loc_oPagina.lbl_4c_Label10
866:             .Caption   = "Comiss" + CHR(227) + "o % : "

*-- Linhas 962 a 1012:
962:             .Visible       = .T.
963:         ENDWITH
964: 
965:         THIS.TornarControlesVisiveis(loc_oPagina)
966:     ENDPROC
967: 
968:     *===========================================================================
969:     * CarregarLista - Carrega cursor_4c_Dados via VENBO.Buscar() e configura o Grid
970:     * Colunas espelham o legado (Init: AddCursor + pColuna x11)
971:     *===========================================================================
972:     PROCEDURE CarregarLista()
973:         LOCAL loc_lResultado, loc_oGrid
974:         loc_lResultado = .F.
975: 
976:         TRY
977:             IF !THIS.this_oBusinessObject.Buscar("")
978:                 loc_lResultado = .F.
979:             ELSE
980:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
981: 
982:                 *-- PROBLEMA 48: ColumnCount/RecordSource ANTES de ControlSource (FORA do WITH - Problema 36)
983:                 loc_oGrid.ColumnCount  = 11
984:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
985: 
986:                 *-- PROBLEMA 48: ControlSource APOS RecordSource (auto-bind seria sobrescrito)
987:                 loc_oGrid.Column1.ControlSource  = "cursor_4c_Dados.codvens"
988:                 loc_oGrid.Column2.ControlSource  = "cursor_4c_Dados.nome"
989:                 loc_oGrid.Column3.ControlSource  = "cursor_4c_Dados.emps"
990:                 loc_oGrid.Column4.ControlSource  = "cursor_4c_Dados.empreg"
991:                 loc_oGrid.Column5.ControlSource  = "cursor_4c_Dados.gruvens"
992:                 loc_oGrid.Column6.ControlSource  = "cursor_4c_Dados.dtini"
993:                 loc_oGrid.Column7.ControlSource  = "cursor_4c_Dados.dtfin"
994:                 loc_oGrid.Column8.ControlSource  = "cursor_4c_Dados.situas"
995:                 loc_oGrid.Column9.ControlSource  = "cursor_4c_Dados.cargo"
996:                 loc_oGrid.Column10.ControlSource = "cursor_4c_Dados.usualts"
997:                 loc_oGrid.Column11.ControlSource = "cursor_4c_Dados.dtalts"
998: 
999:                 *-- Larguras EXATAS do legado (Init: pColuna(...,largura,...))
1000:                 loc_oGrid.Column1.Width  = 75
1001:                 loc_oGrid.Column2.Width  = 150
1002:                 loc_oGrid.Column3.Width  = 75
1003:                 loc_oGrid.Column4.Width  = 75
1004:                 loc_oGrid.Column5.Width  = 75
1005:                 loc_oGrid.Column6.Width  = 75
1006:                 loc_oGrid.Column7.Width  = 75
1007:                 loc_oGrid.Column8.Width  = 75
1008:                 loc_oGrid.Column9.Width  = 75
1009:                 loc_oGrid.Column10.Width = 75
1010:                 loc_oGrid.Column11.Width = 75
1011: 
1012:                 *-- PROBLEMA 2/32/40: Headers APOS RecordSource, captions EXATOS do legado

*-- Linhas 1040 a 1313:
1040:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
1041:     * Ao voltar para Page1, recarrega a lista
1042:     *===========================================================================
1043:     PROCEDURE AlternarPagina(par_nPagina)
1044:         LOCAL loc_lResultado
1045:         loc_lResultado = .F.
1046: 
1047:         TRY
1048:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
1049:                 MsgAviso("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + TRANSFORM(par_nPagina))
1050:             ELSE
1051:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1052: 
1053:                 IF par_nPagina = 1
1054:                     THIS.this_cModoAtual = "LISTA"
1055:                     THIS.CarregarLista()
1056:                 ENDIF
1057: 
1058:                 loc_lResultado = .T.
1059:             ENDIF
1060: 
1061:         CATCH TO loException
1062:             MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loException.Message, ;
1063:                 "FormVEN.AlternarPagina")
1064:         ENDTRY
1065: 
1066:         RETURN loc_lResultado
1067:     ENDPROC
1068: 
1069:     *===========================================================================
1070:     * FormatarGridLista - Formata visual do grid de lista (FontName/FontSize)
1071:     *===========================================================================
1072:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1073:         TRY
1074:             WITH par_oGrid
1075:                 .FontName = "Tahoma"
1076:                 .FontSize = 8
1077:             ENDWITH
1078:         CATCH TO loException
1079:             MostrarErro("Erro ao formatar grid:" + CHR(13) + loException.Message, ;
1080:                 "FormVEN.FormatarGridLista")
1081:         ENDTRY
1082:     ENDPROC
1083: 
1084:     *===========================================================================
1085:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
1086:     * REGRA: Chamar SEMPRE com parametro: THIS.TornarControlesVisiveis(loc_oPagina)
1087:     *===========================================================================
1088:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1089:         LOCAL loc_nI, loc_oObjeto, loc_nP
1090: 
1091:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1092:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1093: 
1094:             IF VARTYPE(loc_oObjeto) = "O"
1095:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1096:                     loc_oObjeto.Visible = .T.
1097:                 ENDIF
1098: 
1099:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1100:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1101:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1102:                     ENDFOR
1103:                 ENDIF
1104: 
1105:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1106:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1107:                 ENDIF
1108:             ENDIF
1109:         ENDFOR
1110:     ENDPROC
1111: 
1112:     *===========================================================================
1113:     * BtnIncluirClick - Abre Page2 para incluir novo registro
1114:     * PUBLIC: BINDEVENT requer metodo publico (regra #3)
1115:     *===========================================================================
1116:     PROCEDURE BtnIncluirClick()
1117:         THIS.this_oBusinessObject.NovoRegistro()
1118:         THIS.LimparCampos()
1119:         THIS.this_cModoAtual = "INCLUIR"
1120:         THIS.HabilitarCampos(.T.)
1121:         THIS.AjustarBotoesPorModo()
1122:         THIS.AlternarPagina(2)
1123:     ENDPROC
1124: 
1125:     *===========================================================================
1126:     * BtnVisualizarClick - Abre Page2 em modo somente leitura
1127:     * PUBLIC: BINDEVENT requer metodo publico (regra #3)
1128:     *===========================================================================
1129:     PROCEDURE BtnVisualizarClick()
1130:         LOCAL loc_cCodigo
1131:         loc_cCodigo = ""
1132: 
1133:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1134:             SELECT cursor_4c_Dados
1135:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigo)
1136:         ENDIF
1137: 
1138:         IF EMPTY(loc_cCodigo)
1139:             MsgAviso("Selecione um registro para visualizar.")
1140:         ELSE
1141:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1142:                 THIS.this_cModoAtual = "VISUALIZAR"
1143:                 THIS.BOParaForm()
1144:                 THIS.HabilitarCampos(.F.)
1145:                 THIS.AjustarBotoesPorModo()
1146:                 THIS.AlternarPagina(2)
1147:             ENDIF
1148:         ENDIF
1149:     ENDPROC
1150: 
1151:     *===========================================================================
1152:     * BtnAlterarClick - Abre Page2 para alterar registro selecionado
1153:     * PUBLIC: BINDEVENT requer metodo publico (regra #3)
1154:     *===========================================================================
1155:     PROCEDURE BtnAlterarClick()
1156:         LOCAL loc_cCodigo
1157:         loc_cCodigo = ""
1158: 
1159:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1160:             SELECT cursor_4c_Dados
1161:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigo)
1162:         ENDIF
1163: 
1164:         IF EMPTY(loc_cCodigo)
1165:             MsgAviso("Selecione um registro para alterar.")
1166:         ELSE
1167:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1168:                 THIS.this_oBusinessObject.EditarRegistro()
1169:                 THIS.this_cModoAtual = "ALTERAR"
1170:                 THIS.BOParaForm()
1171:                 THIS.HabilitarCampos(.T.)
1172:                 THIS.AjustarBotoesPorModo()
1173:                 THIS.AlternarPagina(2)
1174:             ENDIF
1175:         ENDIF
1176:     ENDPROC
1177: 
1178:     *===========================================================================
1179:     * BtnExcluirClick - Exclui registro selecionado com confirmacao
1180:     * PUBLIC: BINDEVENT requer metodo publico (regra #3)
1181:     *===========================================================================
1182:     PROCEDURE BtnExcluirClick()
1183:         LOCAL loc_cCodigo
1184:         loc_cCodigo = ""
1185: 
1186:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1187:             SELECT cursor_4c_Dados
1188:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigo)
1189:         ENDIF
1190: 
1191:         IF EMPTY(loc_cCodigo)
1192:             MsgAviso("Selecione um registro para excluir.")
1193:         ELSE
1194:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1195:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do vendedor [" + loc_cCodigo + "]?", ;
1196:                     "Confirmar Exclus" + CHR(227) + "o")
1197:                     IF THIS.this_oBusinessObject.Excluir()
1198:                         MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
1199:                         THIS.CarregarLista()
1200:                     ENDIF
1201:                 ENDIF
1202:             ENDIF
1203:         ENDIF
1204:     ENDPROC
1205: 
1206:     *===========================================================================
1207:     * BtnBuscarClick - Abre picker para localizar registro na lista
1208:     * Apos selecao, posiciona o cursor no registro encontrado
1209:     * PUBLIC: BINDEVENT requer metodo publico (regra #3)
1210:     *===========================================================================
1211:     PROCEDURE BtnBuscarClick()
1212:         LOCAL loc_oBusca, loc_cCodigo
1213:         loc_cCodigo = ""
1214: 
1215:         TRY
1216:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1217:                 "SigCdVen", "cursor_4c_BuscaVen", "codigo", "", ;
1218:                 "Buscar Vendedor")
1219: 
1220:             IF VARTYPE(loc_oBusca) = "O"
1221:                 loc_oBusca.mAddColuna("codigo",  "", "C" + CHR(243) + "digo")
1222:                 loc_oBusca.mAddColuna("codvens", "", "Vendedor")
1223:                 loc_oBusca.mAddColuna("situas",  "", "Situa" + CHR(231) + CHR(227) + "o")
1224:                 loc_oBusca.Show()
1225: 
1226:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaVen")
1227:                     SELECT cursor_4c_BuscaVen
1228:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaVen.codigo)
1229:                 ENDIF
1230: 
1231:                 loc_oBusca.Release()
1232:             ENDIF
1233: 
1234:             IF USED("cursor_4c_BuscaVen")
1235:                 USE IN cursor_4c_BuscaVen
1236:             ENDIF
1237: 
1238:             IF !EMPTY(loc_cCodigo) AND USED("cursor_4c_Dados")
1239:                 SELECT cursor_4c_Dados
1240:                 LOCATE FOR ALLTRIM(codigo) == loc_cCodigo
1241:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
1242:             ENDIF
1243: 
1244:         CATCH TO loException
1245:             MostrarErro("Erro na busca:" + CHR(13) + loException.Message, "FormVEN.BtnBuscarClick")
1246:             IF USED("cursor_4c_BuscaVen")
1247:                 USE IN cursor_4c_BuscaVen
1248:             ENDIF
1249:         ENDTRY
1250:     ENDPROC
1251: 
1252:     *===========================================================================
1253:     * BtnEncerrarClick - Fecha o formulario
1254:     * PUBLIC: BINDEVENT requer metodo publico (regra #3)
1255:     *===========================================================================
1256:     PROCEDURE BtnEncerrarClick()
1257:         THIS.Release()
1258:     ENDPROC
1259: 
1260:     *===========================================================================
1261:     * HabilitarCampos - Habilita ou desabilita campos de edicao da Page2
1262:     *
1263:     * Campos SEMPRE readonly no legado (When retorna .F. / preenchidos por lookup):
1264:     *   txt_4c_Codigo, txt_4c_Ufs, txt_4c_Grupo, txt_4c_EmpReg
1265:     * txt_4c_DVens: editavel apenas quando txt_4c_Vens esta vazio (legado:
1266:     *   When = Empty(Parent.GetVens.Value)) - permite busca por descricao
1267:     * Campos editaveis SOMENTE em modo INCLUIR (When = INLIST(pcEscolha,'INSERIR')):
1268:     *   txt_4c_Emps, txt_4c_Vens
1269:     * Campos editaveis em INCLUIR e ALTERAR:
1270:     *   txt_4c_Dtini, txt_4c_Dtfin, cbo_4c_CmbSituas, cbo_4c_CmbCargo,
1271:     *   txt_4c_Comis, txt_4c_Subsidio, txt_4c_Pmeta
1272:     *===========================================================================
1273:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1274:         LOCAL loc_oPagina
1275:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1276: 
1277:         IF PEMSTATUS(loc_oPagina, "txt_4c_Emps", 5)
1278:             loc_oPagina.txt_4c_Emps.Enabled = par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")
1279:         ENDIF
1280: 
1281:         IF PEMSTATUS(loc_oPagina, "txt_4c_Vens", 5)
1282:             loc_oPagina.txt_4c_Vens.Enabled = par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")
1283:         ENDIF
1284: 
1285:         IF PEMSTATUS(loc_oPagina, "txt_4c_DVens", 5)
1286:             loc_oPagina.txt_4c_DVens.Enabled = par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR") ;
1287:                 AND EMPTY(ALLTRIM(loc_oPagina.txt_4c_Vens.Value))
1288:         ENDIF
1289: 
1290:         IF PEMSTATUS(loc_oPagina, "txt_4c_Dtini", 5)
1291:             loc_oPagina.txt_4c_Dtini.Enabled = par_lHabilitar AND INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1292:         ENDIF
1293: 
1294:         IF PEMSTATUS(loc_oPagina, "txt_4c_Dtfin", 5)
1295:             loc_oPagina.txt_4c_Dtfin.Enabled = par_lHabilitar AND INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1296:         ENDIF
1297: 
1298:         IF PEMSTATUS(loc_oPagina, "cbo_4c_CmbSituas", 5)
1299:             loc_oPagina.cbo_4c_CmbSituas.Enabled = par_lHabilitar
1300:         ENDIF
1301: 
1302:         IF PEMSTATUS(loc_oPagina, "cbo_4c_CmbCargo", 5)
1303:             loc_oPagina.cbo_4c_CmbCargo.Enabled = par_lHabilitar
1304:         ENDIF
1305: 
1306:         IF PEMSTATUS(loc_oPagina, "txt_4c_Comis", 5)
1307:             loc_oPagina.txt_4c_Comis.Enabled = par_lHabilitar
1308:         ENDIF
1309: 
1310:         IF PEMSTATUS(loc_oPagina, "txt_4c_Subsidio", 5)
1311:             loc_oPagina.txt_4c_Subsidio.Enabled = par_lHabilitar
1312:         ENDIF
1313: 

*-- Linhas 1320 a 1686:
1320:     * AjustarBotoesPorModo - Ajusta estado dos botoes da Page2 conforme modo
1321:     * INCLUIR/ALTERAR: Confirmar habilitado | VISUALIZAR: Confirmar desabilitado
1322:     *===========================================================================
1323:     PROCEDURE AjustarBotoesPorModo()
1324:         LOCAL loc_oPagina, loc_lEditando
1325:         loc_oPagina   = THIS.pgf_4c_Paginas.Page2
1326:         loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1327: 
1328:         IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
1329:             IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1330:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando OR (THIS.this_cModoAtual = "EXCLUIR")
1331:             ENDIF
1332:             IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
1333:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
1334:             ENDIF
1335:         ENDIF
1336:     ENDPROC
1337: 
1338:     *===========================================================================
1339:     * FormParaBO - Transfere valores dos campos da Page2 para o BusinessObject
1340:     *===========================================================================
1341:     PROTECTED PROCEDURE FormParaBO()
1342:         LOCAL loc_oPagina, loc_oBO
1343:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1344:         loc_oBO     = THIS.this_oBusinessObject
1345: 
1346:         loc_oBO.this_cEmps     = ALLTRIM(loc_oPagina.txt_4c_Emps.Value)
1347:         loc_oBO.this_cUfs      = ALLTRIM(loc_oPagina.txt_4c_Ufs.Value)
1348:         loc_oBO.this_cGrupo    = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
1349:         loc_oBO.this_cCodVens  = ALLTRIM(loc_oPagina.txt_4c_Vens.Value)
1350:         loc_oBO.this_dDtIni    = loc_oPagina.txt_4c_Dtini.Value
1351:         loc_oBO.this_dDtFin    = loc_oPagina.txt_4c_Dtfin.Value
1352:         loc_oBO.this_cSituas   = ALLTRIM(loc_oPagina.cbo_4c_CmbSituas.Value)
1353:         loc_oBO.this_cCargo    = ALLTRIM(loc_oPagina.cbo_4c_CmbCargo.Value)
1354:         loc_oBO.this_nComis    = loc_oPagina.txt_4c_Comis.Value
1355:         loc_oBO.this_nSubsidio = loc_oPagina.txt_4c_Subsidio.Value
1356:         loc_oBO.this_nPmeta    = loc_oPagina.txt_4c_Pmeta.Value
1357:     ENDPROC
1358: 
1359:     *===========================================================================
1360:     * BOParaForm - Transfere valores do BusinessObject para os campos da Page2
1361:     * Reconstroi a descricao do vendedor (SigCdCli.Rclis) e a empresa de
1362:     * registro (THIS.PegaEmpReg), equivalentes ao CrTmpCli/pegaempreg do legado
1363:     *===========================================================================
1364:     PROTECTED PROCEDURE BOParaForm()
1365:         LOCAL loc_oPagina, loc_oBO
1366:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1367:         loc_oBO     = THIS.this_oBusinessObject
1368: 
1369:         loc_oPagina.txt_4c_Codigo.Value    = loc_oBO.this_cCodigo
1370:         loc_oPagina.txt_4c_Emps.Value      = loc_oBO.this_cEmps
1371:         loc_oPagina.txt_4c_Ufs.Value       = loc_oBO.this_cUfs
1372:         loc_oPagina.txt_4c_Grupo.Value     = loc_oBO.this_cGrupo
1373:         loc_oPagina.txt_4c_Vens.Value      = loc_oBO.this_cCodVens
1374:         loc_oPagina.txt_4c_Dtini.Value     = loc_oBO.this_dDtIni
1375:         loc_oPagina.txt_4c_Dtfin.Value     = loc_oBO.this_dDtFin
1376:         loc_oPagina.cbo_4c_CmbSituas.Value = loc_oBO.this_cSituas
1377:         loc_oPagina.cbo_4c_CmbCargo.Value  = loc_oBO.this_cCargo
1378:         loc_oPagina.txt_4c_Comis.Value     = loc_oBO.this_nComis
1379:         loc_oPagina.txt_4c_Subsidio.Value  = loc_oBO.this_nSubsidio
1380:         loc_oPagina.txt_4c_Pmeta.Value     = loc_oBO.this_nPmeta
1381: 
1382:         THIS.this_cUltimoEmpsValidado     = ALLTRIM(loc_oBO.this_cEmps)
1383:         THIS.this_cUltimoVensValidado     = ALLTRIM(loc_oBO.this_cCodVens)
1384:         THIS.this_cUltimaSituacaoValidada = ALLTRIM(loc_oBO.this_cSituas)
1385: 
1386:         *-- Descricao do vendedor (CrTmpCli.Rclis no legado: Grupo_op.Click)
1387:         loc_oPagina.txt_4c_DVens.Value = ""
1388:         IF !EMPTY(ALLTRIM(loc_oBO.this_cCodVens))
1389:             IF USED("cursor_4c_DescVen")
1390:                 USE IN cursor_4c_DescVen
1391:             ENDIF
1392:             IF SQLEXEC(gnConnHandle, "SELECT Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_oBO.this_cCodVens) + ;
1393:                     " AND Grupos = " + EscaparSQL(loc_oBO.this_cGrupo), "cursor_4c_DescVen") >= 1
1394:                 IF RECCOUNT("cursor_4c_DescVen") > 0
1395:                     loc_oPagina.txt_4c_DVens.Value = TratarNulo(cursor_4c_DescVen.Rclis, "")
1396:                 ENDIF
1397:             ENDIF
1398:             IF USED("cursor_4c_DescVen")
1399:                 USE IN cursor_4c_DescVen
1400:             ENDIF
1401:         ENDIF
1402:         THIS.this_cUltimoDVensValidado = ALLTRIM(loc_oPagina.txt_4c_DVens.Value)
1403: 
1404:         THIS.PegaEmpReg()
1405:     ENDPROC
1406: 
1407:     *===========================================================================
1408:     * LimparCampos - Limpa campos da Page2 para novo registro (modo INCLUIR)
1409:     * Preenche txt_4c_Grupo com o grupo padrao (SigCdPam.GrPadVens), igual ao
1410:     * legado (Init/Grupo_op.Click: thisform.pagina.dados.getGrupo.value = crSigCdPam.GrPadVens)
1411:     *===========================================================================
1412:     PROTECTED PROCEDURE LimparCampos()
1413:         LOCAL loc_oPagina
1414:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1415: 
1416:         loc_oPagina.txt_4c_Codigo.Value    = ""
1417:         loc_oPagina.txt_4c_Emps.Value      = ""
1418:         loc_oPagina.txt_4c_EmpReg.Value    = ""
1419:         loc_oPagina.txt_4c_Ufs.Value       = ""
1420:         loc_oPagina.txt_4c_Grupo.Value     = ""
1421:         loc_oPagina.txt_4c_Vens.Value      = ""
1422:         loc_oPagina.txt_4c_DVens.Value     = ""
1423:         loc_oPagina.txt_4c_Dtini.Value     = {}
1424:         loc_oPagina.txt_4c_Dtfin.Value     = {}
1425:         loc_oPagina.cbo_4c_CmbSituas.Value = ""
1426:         loc_oPagina.cbo_4c_CmbCargo.Value  = ""
1427:         loc_oPagina.txt_4c_Comis.Value     = 0
1428:         loc_oPagina.txt_4c_Subsidio.Value  = 0
1429:         loc_oPagina.txt_4c_Pmeta.Value     = 0
1430: 
1431:         THIS.this_cUltimoEmpsValidado     = ""
1432:         THIS.this_cUltimoVensValidado     = ""
1433:         THIS.this_cUltimoDVensValidado    = ""
1434:         THIS.this_cUltimaSituacaoValidada = ""
1435: 
1436:         IF USED("cursor_4c_ParamGrupo")
1437:             USE IN cursor_4c_ParamGrupo
1438:         ENDIF
1439:         IF SQLEXEC(gnConnHandle, "SELECT GrPadVens FROM SigCdPam", "cursor_4c_ParamGrupo") >= 1
1440:             IF RECCOUNT("cursor_4c_ParamGrupo") > 0
1441:                 loc_oPagina.txt_4c_Grupo.Value = TratarNulo(cursor_4c_ParamGrupo.GrPadVens, "")
1442:             ENDIF
1443:         ENDIF
1444:         IF USED("cursor_4c_ParamGrupo")
1445:             USE IN cursor_4c_ParamGrupo
1446:         ENDIF
1447:     ENDPROC
1448: 
1449:     *===========================================================================
1450:     * PegaEmpReg - Apresenta a empresa de registro do vendedor (SigCdCli)
1451:     * Transcrito de PROCEDURE pegaempreg do legado
1452:     *===========================================================================
1453:     PROTECTED PROCEDURE PegaEmpReg()
1454:         LOCAL loc_oPagina, loc_cGrupo, loc_cVens
1455:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1456:         loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
1457:         loc_cVens   = ALLTRIM(loc_oPagina.txt_4c_Vens.Value)
1458: 
1459:         IF EMPTY(loc_cGrupo) OR EMPTY(loc_cVens)
1460:             loc_oPagina.txt_4c_EmpReg.Value = ""
1461:         ELSE
1462:             IF USED("cursor_4c_AuxCli")
1463:                 USE IN cursor_4c_AuxCli
1464:             ENDIF
1465:             IF SQLEXEC(gnConnHandle, "SELECT emps FROM SigCdCli WHERE grupos = " + EscaparSQL(loc_cGrupo) + ;
1466:                     " AND iclis = " + EscaparSQL(loc_cVens), "cursor_4c_AuxCli") >= 1
1467:                 IF RECCOUNT("cursor_4c_AuxCli") > 0
1468:                     loc_oPagina.txt_4c_EmpReg.Value = TratarNulo(cursor_4c_AuxCli.emps, "")
1469:                 ELSE
1470:                     loc_oPagina.txt_4c_EmpReg.Value = ""
1471:                 ENDIF
1472:             ENDIF
1473:             IF USED("cursor_4c_AuxCli")
1474:                 USE IN cursor_4c_AuxCli
1475:             ENDIF
1476:         ENDIF
1477:     ENDPROC
1478: 
1479:     *===========================================================================
1480:     * ValidarEmpsDados - LostFocus de txt_4c_Emps (Page2)
1481:     * Legado: LostFocus busca UF em SigcdEmp; Valid chama fAcessoEmpresa
1482:     * (nao portada - regra #27 - substituida por VerificarAcessoEmpresa, que
1483:     * so faz o CHECK de acesso, sem popular textbox)
1484:     * PUBLIC: BINDEVENT requer metodo publico (regra #3)
1485:     *===========================================================================
1486:     PROCEDURE ValidarEmpsDados()
1487:         LOCAL loc_oPagina, loc_cEmp
1488:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1489:         loc_cEmp    = ALLTRIM(loc_oPagina.txt_4c_Emps.Value)
1490: 
1491:         IF loc_cEmp == THIS.this_cUltimoEmpsValidado
1492:             RETURN
1493:         ENDIF
1494:         THIS.this_cUltimoEmpsValidado = loc_cEmp
1495: 
1496:         IF EMPTY(loc_cEmp)
1497:             loc_oPagina.txt_4c_Ufs.Value = ""
1498:             RETURN
1499:         ENDIF
1500: 
1501:         IF USED("cursor_4c_LocalEmp")
1502:             USE IN cursor_4c_LocalEmp
1503:         ENDIF
1504:         IF SQLEXEC(gnConnHandle, "SELECT * FROM SigcdEmp WHERE cemps = " + EscaparSQL(loc_cEmp), "cursor_4c_LocalEmp") < 1
1505:             MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + "o com Servidor de Banco de Dados.", "Erro")
1506:         ELSE
1507:             IF RECCOUNT("cursor_4c_LocalEmp") > 0
1508:                 loc_oPagina.txt_4c_Ufs.Value = TratarNulo(cursor_4c_LocalEmp.estas, "")
1509:             ELSE
1510:                 loc_oPagina.txt_4c_Ufs.Value = ""
1511:             ENDIF
1512:         ENDIF
1513:         IF USED("cursor_4c_LocalEmp")
1514:             USE IN cursor_4c_LocalEmp
1515:         ENDIF
1516: 
1517:         IF !VerificarAcessoEmpresa(gc_4c_UsuarioLogado, loc_cEmp)
1518:             MsgErro("Empresa Inv" + CHR(225) + "lida !!", "Erro")
1519:             loc_oPagina.txt_4c_Emps.Value = ""
1520:             loc_oPagina.txt_4c_Ufs.Value  = ""
1521:             THIS.this_cUltimoEmpsValidado = ""
1522:         ENDIF
1523:     ENDPROC
1524: 
1525:     *===========================================================================
1526:     * ValidarVensDados - LostFocus de txt_4c_Vens (Page2)
1527:     * Legado: Valid chama fAcessoContas(Usuar,Grupo,'C',Value,This,getDVENS) e,
1528:     * se autorizado, thisform.pegaempreg() (portado em utils\functions.prg)
1529:     * PUBLIC: BINDEVENT requer metodo publico (regra #3)
1530:     *===========================================================================
1531:     PROCEDURE ValidarVensDados()
1532:         LOCAL loc_oPagina, loc_cVens, loc_cGrupo
1533:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1534:         loc_cVens   = ALLTRIM(loc_oPagina.txt_4c_Vens.Value)
1535: 
1536:         IF loc_cVens == THIS.this_cUltimoVensValidado
1537:             RETURN
1538:         ENDIF
1539:         THIS.this_cUltimoVensValidado = loc_cVens
1540: 
1541:         loc_cGrupo = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
1542: 
1543:         IF EMPTY(loc_cVens)
1544:             loc_oPagina.txt_4c_DVens.Value = ""
1545:             THIS.this_cUltimoDVensValidado = ""
1546:         ELSE
1547:             IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "C", loc_cVens, loc_oPagina.txt_4c_Vens, loc_oPagina.txt_4c_DVens)
1548:                 MsgErro("Acesso Negado !!", "Erro")
1549:                 loc_oPagina.txt_4c_Vens.Value  = ""
1550:                 loc_oPagina.txt_4c_DVens.Value = ""
1551:                 THIS.this_cUltimoVensValidado  = ""
1552:                 THIS.this_cUltimoDVensValidado = ""
1553:             ELSE
1554:                 THIS.this_cUltimoDVensValidado = ALLTRIM(loc_oPagina.txt_4c_DVens.Value)
1555:                 THIS.PegaEmpReg()
1556:             ENDIF
1557:         ENDIF
1558: 
1559:         loc_oPagina.txt_4c_DVens.Enabled = loc_oPagina.txt_4c_Vens.Enabled AND EMPTY(ALLTRIM(loc_oPagina.txt_4c_Vens.Value))
1560:     ENDPROC
1561: 
1562:     *===========================================================================
1563:     * ValidarDVensDados - LostFocus de txt_4c_DVens (Page2)
1564:     * Legado: Valid chama fAcessoContas(Usuar,Grupo,'D',Value,getVens,This)
1565:     * (busca por descricao, portado em utils\functions.prg)
1566:     * PUBLIC: BINDEVENT requer metodo publico (regra #3)
1567:     *===========================================================================
1568:     PROCEDURE ValidarDVensDados()
1569:         LOCAL loc_oPagina, loc_cDVens, loc_cGrupo
1570:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1571:         loc_cDVens  = ALLTRIM(loc_oPagina.txt_4c_DVens.Value)
1572: 
1573:         IF loc_cDVens == THIS.this_cUltimoDVensValidado
1574:             RETURN
1575:         ENDIF
1576:         THIS.this_cUltimoDVensValidado = loc_cDVens
1577: 
1578:         loc_cGrupo = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
1579: 
1580:         IF EMPTY(loc_cDVens)
1581:             loc_oPagina.txt_4c_Vens.Value = ""
1582:             THIS.this_cUltimoVensValidado = ""
1583:         ELSE
1584:             IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "D", loc_cDVens, loc_oPagina.txt_4c_Vens, loc_oPagina.txt_4c_DVens)
1585:                 MsgErro("Acesso Negado !!", "Erro")
1586:                 loc_oPagina.txt_4c_Vens.Value  = ""
1587:                 loc_oPagina.txt_4c_DVens.Value = ""
1588:                 THIS.this_cUltimoVensValidado  = ""
1589:                 THIS.this_cUltimoDVensValidado = ""
1590:             ELSE
1591:                 THIS.this_cUltimoVensValidado = ALLTRIM(loc_oPagina.txt_4c_Vens.Value)
1592:                 THIS.PegaEmpReg()
1593:             ENDIF
1594:         ENDIF
1595:     ENDPROC
1596: 
1597:     *===========================================================================
1598:     * ValidarSituacao - LostFocus de cbo_4c_CmbSituas (Page2)
1599:     * Legado: so permite gravar situacao FOLGA quem tem acesso (fChecaAcesso)
1600:     * ou se usuario logado eh da mesma empresa do vendedor (SigCdCli)
1601:     * PUBLIC: BINDEVENT requer metodo publico (regra #3)
1602:     *===========================================================================
1603:     PROCEDURE ValidarSituacao()
1604:         LOCAL loc_oPagina, loc_cSituacao, loc_cCodVens, loc_cSQL
1605:         loc_oPagina   = THIS.pgf_4c_Paginas.Page2
1606:         loc_cSituacao = ALLTRIM(loc_oPagina.cbo_4c_CmbSituas.Value)
1607: 
1608:         IF loc_cSituacao == THIS.this_cUltimaSituacaoValidada
1609:             RETURN
1610:         ENDIF
1611:         THIS.this_cUltimaSituacaoValidada = loc_cSituacao
1612: 
1613:         IF loc_cSituacao != "FOLGA"
1614:             RETURN
1615:         ENDIF
1616: 
1617:         IF fChecaAcesso("SIGCDVEN", "FOLGA")
1618:             RETURN
1619:         ENDIF
1620: 
1621:         loc_cCodVens = ALLTRIM(loc_oPagina.txt_4c_Vens.Value)
1622:         loc_cSQL = "SELECT emps FROM SigCdCli WHERE iclis = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
1623:             " AND emps IN (SELECT emps FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cCodVens) + ")"
1624: 
1625:         IF USED("cursor_4c_ChecaFolga")
1626:             USE IN cursor_4c_ChecaFolga
1627:         ENDIF
1628: 
1629:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChecaFolga") < 1 OR RECCOUNT("cursor_4c_ChecaFolga") = 0
1630:             MsgErro("Acesso Negado para definir situa" + CHR(231) + CHR(227) + "o FOLGA!", "Erro")
1631:             loc_oPagina.cbo_4c_CmbSituas.Value = ""
1632:             THIS.this_cUltimaSituacaoValidada  = ""
1633:         ENDIF
1634: 
1635:         IF USED("cursor_4c_ChecaFolga")
1636:             USE IN cursor_4c_ChecaFolga
1637:         ENDIF
1638:     ENDPROC
1639: 
1640:     *===========================================================================
1641:     * BtnSalvarClick - Valida e grava o registro (Confirmar)
1642:     * Validacoes e verificacao de sobreposicao de periodo transcritas
1643:     * LITERALMENTE do legado (Pagina.Dados.Grupo_Salva.Salva.Click) - regra #17
1644:     * PUBLIC: BINDEVENT requer metodo publico (regra #3)
1645:     *===========================================================================
1646:     PROCEDURE BtnSalvarClick()
1647:         LOCAL loc_oPagina, loc_cCheCod, loc_cDatI, loc_cDatF, loc_cQuery
1648:         LOCAL loc_cCodVens, loc_cSituas, loc_dDtIni, loc_dDtFin, loc_cEmps
1649:         LOCAL loc_cAnoMes, loc_cCodigoGerado, loc_lProsseguir
1650:         loc_oPagina     = THIS.pgf_4c_Paginas.Page2
1651:         loc_lProsseguir = .T.
1652: 
1653:         IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1654:             loc_cEmps    = ALLTRIM(loc_oPagina.txt_4c_Emps.Value)
1655:             loc_cCodVens = ALLTRIM(loc_oPagina.txt_4c_Vens.Value)
1656:             loc_dDtIni   = loc_oPagina.txt_4c_Dtini.Value
1657:             loc_dDtFin   = loc_oPagina.txt_4c_Dtfin.Value
1658:             loc_cSituas  = ALLTRIM(loc_oPagina.cbo_4c_CmbSituas.Value)
1659: 
1660:             IF EMPTY(loc_cEmps)
1661:                 MsgErro("Empresa n" + CHR(227) + "o pode ficar em branco!", "Confirmar")
1662:                 loc_oPagina.txt_4c_Emps.SetFocus
1663:                 loc_lProsseguir = .F.
1664:             ENDIF
1665: 
1666:             IF loc_lProsseguir AND EMPTY(loc_cCodVens)
1667:                 MsgErro("Vendedor n" + CHR(227) + "o pode ficar em branco!", "Confirmar")
1668:                 loc_oPagina.txt_4c_Emps.SetFocus
1669:                 loc_lProsseguir = .F.
1670:             ENDIF
1671: 
1672:             IF loc_lProsseguir AND EMPTY(loc_dDtIni)
1673:                 MsgErro("Data Inicial n" + CHR(227) + "o pode ficar em branco!", "Confirmar")
1674:                 loc_oPagina.txt_4c_Dtini.SetFocus
1675:                 loc_lProsseguir = .F.
1676:             ENDIF
1677: 
1678:             IF loc_lProsseguir AND loc_cSituas != "ATIVO" AND EMPTY(loc_dDtFin)
1679:                 MsgErro("Data final n" + CHR(227) + "o pode ficar em branco!", "Confirmar")
1680:                 loc_oPagina.txt_4c_Dtfin.SetFocus
1681:                 loc_lProsseguir = .F.
1682:             ENDIF
1683: 
1684:             IF loc_lProsseguir AND EMPTY(loc_cSituas)
1685:                 MsgErro("Situa" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ficar em branco!", "Confirmar")
1686:                 loc_oPagina.cbo_4c_CmbSituas.SetFocus

*-- Linhas 1770 a 1798:
1770: 
1771:     *===========================================================================
1772:     * BtnCancelarClick - Cancela edicao e retorna para a lista (Cancelar)
1773:     * PUBLIC: BINDEVENT requer metodo publico (regra #3)
1774:     *===========================================================================
1775:     PROCEDURE BtnCancelarClick()
1776:         THIS.AlternarPagina(1)
1777:     ENDPROC
1778: 
1779:     *===========================================================================
1780:     * Destroy - Libera recursos do formulario
1781:     *===========================================================================
1782:     PROCEDURE Destroy()
1783:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1784:             THIS.this_oBusinessObject = .NULL.
1785:         ENDIF
1786: 
1787:         IF USED("cursor_4c_Dados")
1788:             USE IN cursor_4c_Dados
1789:         ENDIF
1790: 
1791:         IF USED("cursor_4c_Carrega")
1792:             USE IN cursor_4c_Carrega
1793:         ENDIF
1794: 
1795:         DODEFAULT()
1796:     ENDPROC
1797: 
1798: ENDDEFINE


### BO (C:\4c\projeto\app\classes\VENBO.prg):
*====================================================================
* VENBO.prg
*
* Business Object para Vendedores
* Tabela principal: SigCdVen (codigo PK)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS VENBO AS BusinessBase

	*-- Propriedades da entidade (SigCdVen)
	this_cCodigo    = ""   && codigo char(20)      - PK (codigo do vendedor)
	this_cEmps      = ""   && emps char(3)         - codigo da empresa/loja
	this_cGrupo     = ""   && gruvens char(10)     - grupo do vendedor
	this_cCodVens   = ""   && codvens char(10)     - codigo do vendedor (cliente)
	this_cNomeVen   = ""   && nomeven varchar(255) - nome do vendedor
	this_cUfs       = ""   && ufs char(2)          - estado
	this_dDtIni     = {}   && dtini datetime       - data inicial (NULL)
	this_dDtFin     = {}   && dtfin datetime       - data final (NULL)
	this_cSituas    = ""   && situas char(30)      - situacao
	this_cCargo     = ""   && cargo char(15)       - cargo
	this_nComis     = 0    && comis numeric(7,4)   - comissao %
	this_nSubsidio  = 0    && subsidio numeric(7,4) - subsidio %
	this_nPmeta     = 0    && pmeta numeric(7,4)   - meta %
	this_cFolga     = ""   && folga char(1)        - folga (S/N) - NOT NULL, sem campo na tela
	this_dDtAlts    = {}   && dtalts datetime      - data da ultima alteracao (NULL)
	this_cUsuAlts   = ""   && usualts char(10)     - usuario da ultima alteracao

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		LOCAL loc_lSucesso
		loc_lSucesso = .F.
		TRY
			DODEFAULT()
			THIS.this_cTabela     = "SigCdVen"
			THIS.this_cCampoChave = "codigo"
			loc_lSucesso = .T.
		CATCH TO loException
			MostrarErro(loException, "VENBO.Init")
		ENDTRY
		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCodigo)
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Carrega propriedades do BO a partir de cursor
	* REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)
				THIS.this_cCodigo   = TratarNulo(codigo,   "")
				THIS.this_cEmps     = TratarNulo(emps,     "")
				THIS.this_cGrupo    = TratarNulo(gruvens,  "")
				THIS.this_cCodVens  = TratarNulo(codvens,  "")
				THIS.this_cNomeVen  = TratarNulo(nomeven,  "")
				THIS.this_cUfs      = TratarNulo(ufs,      "")
				THIS.this_dDtIni    = TratarNulo(dtini,    {})
				THIS.this_dDtFin    = TratarNulo(dtfin,    {})
				THIS.this_cSituas   = TratarNulo(situas,   "")
				THIS.this_cCargo    = TratarNulo(cargo,    "")
				THIS.this_nComis    = TratarNulo(comis,    0)
				THIS.this_nSubsidio = TratarNulo(subsidio, 0)
				THIS.this_nPmeta    = TratarNulo(pmeta,    0)
				THIS.this_cFolga    = TratarNulo(folga,    "")
				THIS.this_dDtAlts   = TratarNulo(dtalts,   {})
				THIS.this_cUsuAlts  = TratarNulo(usualts,  "")
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "VENBO.CarregarDoCursor")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - Insere novo registro na tabela SigCdVen
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				INSERT INTO SigCdVen (codigo, emps, gruvens, codvens, nomeven, ufs,
					dtini, dtfin, situas, cargo, comis, subsidio, pmeta, folga,
					dtalts, usualts)
				VALUES (
					<<EscaparSQL(THIS.this_cCodigo)>>,
					<<EscaparSQL(THIS.this_cEmps)>>,
					<<EscaparSQL(THIS.this_cGrupo)>>,
					<<EscaparSQL(THIS.this_cCodVens)>>,
					<<EscaparSQL(THIS.this_cNomeVen)>>,
					<<EscaparSQL(THIS.this_cUfs)>>,
					<<FormatarDataSQL(THIS.this_dDtIni)>>,
					<<FormatarDataSQL(THIS.this_dDtFin)>>,
					<<EscaparSQL(THIS.this_cSituas)>>,
					<<EscaparSQL(THIS.this_cCargo)>>,
					<<FormatarNumeroSQL(THIS.this_nComis, 4)>>,
					<<FormatarNumeroSQL(THIS.this_nSubsidio, 4)>>,
					<<FormatarNumeroSQL(THIS.this_nPmeta, 4)>>,
					<<EscaparSQL(THIS.this_cFolga)>>,
					GETDATE(),
					<<EscaparSQL(gc_4c_UsuarioLogado)>>
				)
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao inserir vendedor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "VENBO.Inserir")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - Atualiza registro existente na tabela SigCdVen
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				UPDATE SigCdVen
				SET emps     = <<EscaparSQL(THIS.this_cEmps)>>,
					gruvens  = <<EscaparSQL(THIS.this_cGrupo)>>,
					codvens  = <<EscaparSQL(THIS.this_cCodVens)>>,
					nomeven  = <<EscaparSQL(THIS.this_cNomeVen)>>,
					ufs      = <<EscaparSQL(THIS.this_cUfs)>>,
					dtini    = <<FormatarDataSQL(THIS.this_dDtIni)>>,
					dtfin    = <<FormatarDataSQL(THIS.this_dDtFin)>>,
					situas   = <<EscaparSQL(THIS.this_cSituas)>>,
					cargo    = <<EscaparSQL(THIS.this_cCargo)>>,
					comis    = <<FormatarNumeroSQL(THIS.this_nComis, 4)>>,
					subsidio = <<FormatarNumeroSQL(THIS.this_nSubsidio, 4)>>,
					pmeta    = <<FormatarNumeroSQL(THIS.this_nPmeta, 4)>>,
					dtalts   = GETDATE(),
					usualts  = <<EscaparSQL(gc_4c_UsuarioLogado)>>
				WHERE codigo = <<EscaparSQL(THIS.this_cCodigo)>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao atualizar vendedor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "VENBO.Atualizar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - Exclui registro da tabela SigCdVen
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigCdVen WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao excluir vendedor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "VENBO.ExecutarExclusao")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Buscar - Busca registros com filtro opcional
	* Retorna cursor_4c_Dados espelhando as colunas do Grade legado
	* (Init: AddCursor lcQrycdVen + pColuna x11):
	* codigo, codvens, nome (SigCdUsu.ncomps), emps, empreg (SigCdCli.emps),
	* gruvens, dtini, dtfin, situas, cargo, usualts, dtalts
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
				IF !USED("cursor_4c_Dados")
					SET NULL ON
					CREATE CURSOR cursor_4c_Dados (codigo C(20), codvens C(10), ;
						nome C(30), emps C(3), empreg C(3), gruvens C(10), ;
						dtini T, dtfin T, situas C(30), cargo C(15), ;
						usualts C(10), dtalts T)
					SET NULL OFF
				ENDIF
				loc_lSucesso = .T.
			ELSE
				loc_cSQL = "SELECT a.codigo, a.codvens, ISNULL(b.ncomps,'') AS nome," + ;
					" a.emps, c.emps AS empreg, a.gruvens, a.dtini, a.dtfin," + ;
					" a.situas, a.cargo, a.usualts, a.dtalts" + ;
					" FROM SigCdVen a" + ;
					" LEFT JOIN SigCdUsu b ON a.codvens = b.usuarios" + ;
					" LEFT JOIN SigCdCli c ON a.gruvens = c.grupos AND a.codvens = c.iclis"

				IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
					loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
				ENDIF

				loc_cSQL = loc_cSQL + " ORDER BY a.codigo"

				IF USED("cursor_4c_Dados")
					USE IN cursor_4c_Dados
				ENDIF
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
				IF loc_nResultado >= 0
					loc_lSucesso = .T.
				ELSE
					MostrarErro("Erro ao buscar vendedores:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
				ENDIF
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "VENBO.Buscar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega registro pela chave primaria (codigo)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCodigo)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT codigo, emps, gruvens, codvens, nomeven, ufs," + ;
				" dtini, dtfin, situas, cargo, comis, subsidio, pmeta, folga," + ;
				" dtalts, usualts" + ;
				" FROM SigCdVen WHERE codigo = " + EscaparSQL(par_cCodigo)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

			IF loc_nResultado >= 0
				IF RECCOUNT("cursor_4c_Carrega") > 0
					loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
					THIS.this_lNovoRegistro = .F.
				ELSE
					MsgAviso("Vendedor n" + CHR(227) + "o encontrado!")
				ENDIF

				IF USED("cursor_4c_Carrega")
					USE IN cursor_4c_Carrega
				ENDIF
			ELSE
				MostrarErro("Erro ao carregar vendedor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "VENBO.CarregarPorCodigo")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

