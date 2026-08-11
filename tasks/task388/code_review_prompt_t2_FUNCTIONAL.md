# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (6)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_PG3, CNT_4C_PG4, CNT_4C_PG5, CNT_4C_PG6, CNT_4C_PG7, CNT_4C_PG8, CNT_4C_PG9, CNT_4C_PG10, CNT_4C_PG11, CNT_4C_PG12. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [LAYOUT-POSITION] Controle 'Botoes' (parent: SIGCDCTA.Pagina.Lista): Top original=85 vs migrado 'cnt_4c_Botoes' Top=28 (diff=57px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Botoes' (parent: SIGCDCTA.Pagina.Lista): Left original=971 vs migrado 'cnt_4c_Botoes' Left=542 (diff=429px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'ISS' (parent: SIGCDCTA.Pagina.Dados.cntConta.pgframeDados.pgFrameDados9.cntIS): Top original=5 vs migrado 'txt_4c_Emissors' Top=165 (diff=160px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'PIS' (parent: SIGCDCTA.Pagina.Dados.cntConta.pgframeDados.pgFrameDados9.cntPI): Top original=5 vs migrado 'txt_4c_Pis' Top=125 (diff=120px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'PIS' (parent: SIGCDCTA.Pagina.Dados.cntConta.pgframeDados.pgFrameDados9.cntPI): Left original=41 vs migrado 'txt_4c_Pis' Left=376 (diff=335px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCTA.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (6072 linhas total):

*-- Linhas 25 a 495:
25:     this_cMensagemErro   = ""
26: 
27:     *===========================================================================
28:     * Init - APENAS DODEFAULT (FormBase chama InicializarForm)
29:     *===========================================================================
30:     PROCEDURE Init()
31:         RETURN DODEFAULT()
32:     ENDPROC
33: 
34:     *===========================================================================
35:     * InicializarForm - Configura estrutura completa
36:     *===========================================================================
37:     PROTECTED PROCEDURE InicializarForm()
38:         LOCAL loc_lSucesso
39:         loc_lSucesso = .F.
40: 
41:         TRY
42:             THIS.this_oBusinessObject = CREATEOBJECT("CTABO")
43: 
44:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
45:                 MostrarErro("Erro ao criar CTABO" + CHR(13) + ;
46:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
47:                     "FormCTA.InicializarForm")
48:             ELSE
49:                 THIS.ConfigurarPageFrame()
50:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
51:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
52:                 THIS.pgf_4c_Paginas.Visible = .T.
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
64:             MostrarErro("Erro ao inicializar FormCTA:" + CHR(13) + ;
65:                 loException.Message + CHR(13) + ;
66:                 "Linha: " + TRANSFORM(loException.LineNo), ;
67:                 "FormCTA.InicializarForm")
68:         ENDTRY
69: 
70:         RETURN loc_lSucesso
71:     ENDPROC
72: 
73:     *===========================================================================
74:     * ConfigurarPageFrame - Cria PageFrame principal
75:     *===========================================================================
76:     PROTECTED PROCEDURE ConfigurarPageFrame()
77:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
78: 
79:         WITH THIS.pgf_4c_Paginas
80:             .PageCount = 2
81:             .Top       = -29
82:             .Left      = 0
83:             .Width     = THIS.Width
84:             .Height    = THIS.Height + 29
85:             .Tabs      = .F.
86:             .Visible   = .T.
87: 
88:             .Page1.Caption   = "Lista"
89:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
90:             .Page1.BackColor = RGB(255, 255, 255)
91: 
92:             .Page2.Caption   = "Dados"
93:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
94:             .Page2.BackColor = RGB(255, 255, 255)
95:         ENDWITH
96: 
97:         THIS.ConfigurarPaginaLista()
98:         THIS.ConfigurarPaginaDados()
99:     ENDPROC
100: 
101:     *===========================================================================
102:     * ConfigurarPaginaLista - Page1: grade + filtros + botoes CRUD
103:     *===========================================================================
104:     PROTECTED PROCEDURE ConfigurarPaginaLista()
105:         LOCAL loc_oPagina
106:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
107:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
108: 
109:         *-- Cabecalho cinza (cntSombra legado Top=1 -> +29 = 30)
110:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
111:         WITH loc_oPagina.cnt_4c_Cabecalho
112:             .Top         = 30
113:             .Left        = 0
114:             .Width       = THIS.Width
115:             .Height      = 80
116:             .BackColor   = RGB(100, 100, 100)
117:             .BorderWidth = 0
118:             .Visible     = .T.
119:         ENDWITH
120: 
121:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
122:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
123:             .Caption   = THIS.Caption
124:             .Top       = 15
125:             .Left      = 10
126:             .Width     = 769
127:             .Height    = 40
128:             .FontName  = "Tahoma"
129:             .FontSize  = 16
130:             .FontBold  = .T.
131:             .ForeColor = RGB(0, 0, 0)
132:             .BackStyle = 0
133:             .AutoSize  = .F.
134:             .Visible   = .T.
135:         ENDWITH
136: 
137:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
138:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
139:             .Caption   = THIS.Caption
140:             .Top       = 18
141:             .Left      = 10
142:             .Width     = 769
143:             .Height    = 46
144:             .FontName  = "Tahoma"
145:             .FontSize  = 16
146:             .FontBold  = .T.
147:             .ForeColor = RGB(255, 255, 255)
148:             .BackStyle = 0
149:             .AutoSize  = .F.
150:             .Visible   = .T.
151:         ENDWITH
152: 
153:         *-- Botoes CRUD (Grupo_op Top=-1 -> +29 = 28; Left=543 canonico)
154:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
155:         WITH loc_oPagina.cnt_4c_Botoes
156:             .Top         = 28
157:             .Left        = 542
158:             .Width       = 385
159:             .Height      = 85
160:             .BackStyle   = 0
161:             .BorderWidth = 0
162:             .Visible     = .T.
163:         ENDWITH
164: 
165:         *-- Incluir (Left=5)
166:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
167:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
168:             .Caption         = "Incluir"
169:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
170:             .PicturePosition = 13
171:             .Top             = 5
172:             .Left            = 5
173:             .Width           = 75
174:             .Height          = 75
175:             .FontName        = "Tahoma"
176:             .FontBold        = .T.
177:             .FontItalic      = .T.
178:             .FontSize        = 8
179:             .ForeColor       = RGB(90, 90, 90)
180:             .BackColor       = RGB(255, 255, 255)
181:             .Themes          = .F.
182:             .SpecialEffect   = 0
183:             .MousePointer    = 15
184:             .WordWrap        = .T.
185:             .AutoSize        = .F.
186:             .Visible         = .T.
187:         ENDWITH
188:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
189: 
190:         *-- Visualizar (Left=80)
191:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
192:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
193:             .Caption         = "Visualizar"
194:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
195:             .PicturePosition = 13
196:             .Top             = 5
197:             .Left            = 80
198:             .Width           = 75
199:             .Height          = 75
200:             .FontName        = "Tahoma"
201:             .FontBold        = .T.
202:             .FontItalic      = .T.
203:             .FontSize        = 8
204:             .ForeColor       = RGB(90, 90, 90)
205:             .BackColor       = RGB(255, 255, 255)
206:             .Themes          = .F.
207:             .SpecialEffect   = 0
208:             .MousePointer    = 15
209:             .WordWrap        = .T.
210:             .AutoSize        = .F.
211:             .Visible         = .T.
212:         ENDWITH
213:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
214: 
215:         *-- Alterar (Left=155)
216:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
217:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
218:             .Caption         = "Alterar"
219:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
220:             .PicturePosition = 13
221:             .Top             = 5
222:             .Left            = 155
223:             .Width           = 75
224:             .Height          = 75
225:             .FontName        = "Tahoma"
226:             .FontBold        = .T.
227:             .FontItalic      = .T.
228:             .FontSize        = 8
229:             .ForeColor       = RGB(90, 90, 90)
230:             .BackColor       = RGB(255, 255, 255)
231:             .Themes          = .F.
232:             .SpecialEffect   = 0
233:             .MousePointer    = 15
234:             .WordWrap        = .T.
235:             .AutoSize        = .F.
236:             .Visible         = .T.
237:         ENDWITH
238:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
239: 
240:         *-- Excluir (Left=230)
241:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
242:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
243:             .Caption         = "Excluir"
244:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
245:             .PicturePosition = 13
246:             .Top             = 5
247:             .Left            = 230
248:             .Width           = 75
249:             .Height          = 75
250:             .FontName        = "Tahoma"
251:             .FontBold        = .T.
252:             .FontItalic      = .T.
253:             .FontSize        = 8
254:             .ForeColor       = RGB(90, 90, 90)
255:             .BackColor       = RGB(255, 255, 255)
256:             .Themes          = .F.
257:             .SpecialEffect   = 0
258:             .MousePointer    = 15
259:             .WordWrap        = .T.
260:             .AutoSize        = .F.
261:             .Visible         = .T.
262:         ENDWITH
263:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
264: 
265:         *-- Procurar/Buscar (Left=305)
266:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
267:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
268:             .Caption         = "Procurar"
269:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
270:             .PicturePosition = 13
271:             .Top             = 5
272:             .Left            = 305
273:             .Width           = 75
274:             .Height          = 75
275:             .FontName        = "Tahoma"
276:             .FontBold        = .T.
277:             .FontItalic      = .T.
278:             .FontSize        = 8
279:             .ForeColor       = RGB(90, 90, 90)
280:             .BackColor       = RGB(255, 255, 255)
281:             .Themes          = .F.
282:             .SpecialEffect   = 0
283:             .MousePointer    = 15
284:             .WordWrap        = .T.
285:             .AutoSize        = .F.
286:             .Visible         = .T.
287:         ENDWITH
288:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
289: 
290:         *-- Container Saida (canonico: Left=917, Width=90)
291:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
292:         WITH loc_oPagina.cnt_4c_Saida
293:             .Top         = 28
294:             .Left        = 917
295:             .Width       = 90
296:             .Height      = 85
297:             .BackStyle   = 0
298:             .BorderWidth = 0
299:             .Visible     = .T.
300:         ENDWITH
301: 
302:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
303:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
304:             .Caption         = "Encerrar"
305:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
306:             .PicturePosition = 13
307:             .Top             = 5
308:             .Left            = 5
309:             .Width           = 75
310:             .Height          = 75
311:             .FontName        = "Tahoma"
312:             .FontBold        = .T.
313:             .FontItalic      = .T.
314:             .FontSize        = 8
315:             .ForeColor       = RGB(90, 90, 90)
316:             .BackColor       = RGB(255, 255, 255)
317:             .Themes          = .F.
318:             .SpecialEffect   = 0
319:             .MousePointer    = 15
320:             .WordWrap        = .T.
321:             .AutoSize        = .F.
322:             .Visible         = .T.
323:         ENDWITH
324:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
325: 
326:         *-- Container de Filtros (cntFiltros: Top=85+29=114, Left=30, W=599, H=49)
327:         loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
328:         WITH loc_oPagina.cnt_4c_Filtros
329:             .Top         = 114
330:             .Left        = 30
331:             .Width       = 599
332:             .Height      = 49
333:             .BackStyle   = 0
334:             .BorderWidth = 1
335:             .Visible     = .T.
336:         ENDWITH
337: 
338:         *-- Label Grupo de Contas
339:         loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_Label2", "Label")
340:         WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_Label2
341:             .Caption   = "\<Grupo de Contas"
342:             .Top       = 4
343:             .Left      = 7
344:             .Width     = 95
345:             .Height    = 15
346:             .FontName  = "Tahoma"
347:             .FontSize  = 8
348:             .ForeColor = RGB(90, 90, 90)
349:             .BackStyle = 0
350:             .AutoSize  = .F.
351:             .Visible   = .T.
352:         ENDWITH
353: 
354:         *-- Grupo (codigo) - txt_4c_Grupo: Top=19, Left=7, Width=81
355:         loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_Grupo", "TextBox")
356:         WITH loc_oPagina.cnt_4c_Filtros.txt_4c_Grupo
357:             .Top           = 19
358:             .Left          = 7
359:             .Width         = 81
360:             .Height        = 25
361:             .FontName      = "Tahoma"
362:             .FontSize      = 8
363:             .SpecialEffect = 1
364:             .ForeColor     = RGB(0, 0, 0)
365:             .BorderColor   = RGB(100, 100, 100)
366:             .Value         = ""
367:             .Visible       = .T.
368:         ENDWITH
369:         BINDEVENT(loc_oPagina.cnt_4c_Filtros.txt_4c_Grupo, "KeyPress", THIS, "TxtGrupoFiltroKeyPress")
370: 
371:         *-- Descricao Grupo - txt_4c_DGrupo: Top=19, Left=91, Width=290
372:         loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_DGrupo", "TextBox")
373:         WITH loc_oPagina.cnt_4c_Filtros.txt_4c_DGrupo
374:             .Top           = 19
375:             .Left          = 91
376:             .Width         = 290
377:             .Height        = 25
378:             .FontName      = "Tahoma"
379:             .FontSize      = 8
380:             .SpecialEffect = 1
381:             .ForeColor     = RGB(0, 0, 0)
382:             .BorderColor   = RGB(100, 100, 100)
383:             .Value         = ""
384:             .ReadOnly      = .T.
385:             .Visible       = .T.
386:         ENDWITH
387:         BINDEVENT(loc_oPagina.cnt_4c_Filtros.txt_4c_DGrupo, "KeyPress", THIS, "TxtDGrupoFiltroKeyPress")
388: 
389:         *-- Label Alterados entre
390:         loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_Label3", "Label")
391:         WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_Label3
392:             .Caption   = "Alterados entre"
393:             .Top       = 3
394:             .Left      = 402
395:             .Width     = 91
396:             .Height    = 15
397:             .FontName  = "Tahoma"
398:             .FontSize  = 8
399:             .ForeColor = RGB(90, 90, 90)
400:             .BackStyle = 0
401:             .AutoSize  = .F.
402:             .Visible   = .T.
403:         ENDWITH
404: 
405:         *-- DtIni: Top=19, Left=402, Width=80
406:         loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_DtIni", "TextBox")
407:         WITH loc_oPagina.cnt_4c_Filtros.txt_4c_DtIni
408:             .Top           = 19
409:             .Left          = 402
410:             .Width         = 80
411:             .Height        = 25
412:             .FontName      = "Tahoma"
413:             .FontSize      = 8
414:             .SpecialEffect = 1
415:             .ForeColor     = RGB(0, 0, 0)
416:             .BorderColor   = RGB(100, 100, 100)
417:             .Value         = DATE() - 365
418:             .InputMask     = "99/99/9999"
419:             .Visible       = .T.
420:         ENDWITH
421:         BINDEVENT(loc_oPagina.cnt_4c_Filtros.txt_4c_DtIni, "KeyPress", THIS, "TxtDtIniKeyPress")
422: 
423:         *-- Label ate
424:         loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_Label4", "Label")
425:         WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_Label4
426:             .Caption   = "at" + CHR(233)
427:             .Top       = 23
428:             .Left      = 486
429:             .Width     = 21
430:             .Height    = 15
431:             .FontName  = "Tahoma"
432:             .FontSize  = 8
433:             .ForeColor = RGB(90, 90, 90)
434:             .BackStyle = 0
435:             .AutoSize  = .F.
436:             .Visible   = .T.
437:         ENDWITH
438: 
439:         *-- DtFim: Top=19, Left=512, Width=80
440:         loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_DtFim", "TextBox")
441:         WITH loc_oPagina.cnt_4c_Filtros.txt_4c_DtFim
442:             .Top           = 19
443:             .Left          = 512
444:             .Width         = 80
445:             .Height        = 25
446:             .FontName      = "Tahoma"
447:             .FontSize      = 8
448:             .SpecialEffect = 1
449:             .ForeColor     = RGB(0, 0, 0)
450:             .BorderColor   = RGB(100, 100, 100)
451:             .Value         = DATE()
452:             .InputMask     = "99/99/9999"
453:             .Visible       = .T.
454:         ENDWITH
455:         BINDEVENT(loc_oPagina.cnt_4c_Filtros.txt_4c_DtFim, "KeyPress", THIS, "TxtDtFimKeyPress")
456: 
457:         *-- Grid de lista (Grade: Top=137+29=166, Left=30, Width=939, Height=454)
458:         *-- ColumnCount ANTES do WITH (VFP9 regra)
459:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
460:         loc_oPagina.grd_4c_Lista.ColumnCount = 5
461:         WITH loc_oPagina.grd_4c_Lista
462:             .Top                = 166
463:             .Left               = 30
464:             .Width              = 939
465:             .Height             = 454
466:             .FontName           = "Courier New"
467:             .FontSize           = 9
468:             .ForeColor          = RGB(90, 90, 90)
469:             .BackColor          = RGB(255, 255, 255)
470:             .GridLineColor      = RGB(238, 238, 238)
471:             .HighlightBackColor = RGB(255, 255, 255)
472:             .HighlightForeColor = RGB(15, 41, 104)
473:             .HighlightStyle     = 2
474:             .DeleteMark         = .F.
475:             .RecordMark         = .F.
476:             .RowHeight          = 16
477:             .ScrollBars         = 2
478:             .GridLines          = 3
479:             .Visible            = .T.
480: 
481:             *-- Coluna 1: Codigo (IClis) Width=100
482:             .Column1.Width      = 100
483:             .Column1.Movable    = .F.
484:             .Column1.Resizable  = .F.
485:             .Column1.ReadOnly   = .T.
486:             .Column1.Header1.Caption   = "C" + CHR(243) + "digo"
487:             .Column1.Header1.FontName  = "Tahoma"
488:             .Column1.Header1.FontSize  = 8
489:             .Column1.Header1.Alignment = 2
490: 
491:             *-- Coluna 2: Nome (Rclis) Width=514
492:             .Column2.Width      = 514
493:             .Column2.ColumnOrder = 2
494:             .Column2.Movable    = .F.
495:             .Column2.Resizable  = .F.

*-- Linhas 530 a 649:
530:             .Column5.Header1.FontSize  = 8
531:             .Column5.Header1.Alignment = 2
532:         ENDWITH
533:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")
534: 
535:         THIS.TornarControlesVisiveis(loc_oPagina)
536:     ENDPROC
537: 
538:     *===========================================================================
539:     * ConfigurarPaginaDados - Page2: nav + sub-paginas
540:     *===========================================================================
541:     PROTECTED PROCEDURE ConfigurarPaginaDados()
542:         LOCAL loc_oPagina
543:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
544:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
545: 
546:         *-- Botoes Salvar/Cancelar (Grupo_Salva: Top=-7+29=22, Left=842)
547:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
548:         WITH loc_oPagina.cnt_4c_BotoesAcao
549:             .Top         = 22
550:             .Left        = 842
551:             .Width       = 163
552:             .Height      = 85
553:             .BackStyle = 0
554:             .BackColor   = RGB(255, 255, 255)
555:             .BorderWidth = 0
556:             .Visible     = .T.
557:         ENDWITH
558: 
559:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
560:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
561:             .Caption         = "Confirmar"
562:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
563:             .PicturePosition = 13
564:             .Top             = 5
565:             .Left            = 6
566:             .Width           = 75
567:             .Height          = 75
568:             .FontName        = "Tahoma"
569:             .FontBold        = .T.
570:             .FontItalic      = .T.
571:             .FontSize        = 8
572:             .ForeColor       = RGB(90, 90, 90)
573:             .BackColor       = RGB(255, 255, 255)
574:             .Themes          = .F.
575:             .SpecialEffect   = 0
576:             .MousePointer    = 15
577:             .WordWrap        = .T.
578:             .AutoSize        = .F.
579:             .Visible         = .T.
580:         ENDWITH
581:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
582: 
583:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
584:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
585:             .Caption         = "Encerrar"
586:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
587:             .PicturePosition = 13
588:             .Top             = 5
589:             .Left            = 81
590:             .Width           = 75
591:             .Height          = 75
592:             .FontName        = "Tahoma"
593:             .FontBold        = .T.
594:             .FontItalic      = .T.
595:             .FontSize        = 8
596:             .ForeColor       = RGB(90, 90, 90)
597:             .BackColor       = RGB(255, 255, 255)
598:             .Themes          = .F.
599:             .SpecialEffect   = 0
600:             .MousePointer    = 15
601:             .WordWrap        = .T.
602:             .AutoSize        = .F.
603:             .Visible         = .T.
604:         ENDWITH
605:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
606: 
607:         *-- OptionGroup para navegar entre 12 sub-paginas
608:         *-- (fwSelPagina1 Top=3+29=32, Left=1, Width=817, Height=75)
609:         loc_oPagina.AddObject("obj_4c_NavPaginas", "OptionGroup")
610:         loc_oPagina.obj_4c_NavPaginas.ButtonCount = 12
611:         WITH loc_oPagina.obj_4c_NavPaginas
612:             .Top         = 32
613:             .Left        = 1
614:             .Width       = 817
615:             .Height      = 75
616:             .Value       = 1
617:             .BackStyle   = 0
618:             .BorderStyle = 0
619:             .SpecialEffect = 0
620:             .Visible     = .T.
621: 
622:             WITH .Buttons(1)
623:                 .Caption   = "Principal"
624:                 .Top       = 0
625:                 .Left      = 0
626:                 .Width     = 65
627:                 .Height    = 75
628:                 .BackStyle = 0
629:                 .Value     = 0
630:             ENDWITH
631:             WITH .Buttons(2)
632:                 .Caption   = "Comercial"
633:                 .Top       = 0
634:                 .Left      = 65
635:                 .Width     = 65
636:                 .Height    = 75
637:                 .FontName  = "Tahoma"
638:                 .FontSize  = 7
639:                 .BackStyle = 0
640:                 .Value     = 0
641:             ENDWITH
642:             WITH .Buttons(3)
643:                 .Caption   = "Banc" + CHR(225) + "rios"
644:                 .Top       = 0
645:                 .Left      = 130
646:                 .Width     = 65
647:                 .Height    = 75
648:                 .FontName  = "Tahoma"
649:                 .FontSize  = 7

*-- Linhas 750 a 871:
750:                 .Value     = 0
751:             ENDWITH
752:         ENDWITH
753:         BINDEVENT(loc_oPagina.obj_4c_NavPaginas, "Click", THIS, "NavPaginasClick")
754: 
755:         *-- Configurar pgframeDados (12 sub-paginas internas)
756:         THIS.ConfigurarPgpgframeDados(loc_oPagina)
757: 
758:         THIS.TornarControlesVisiveis(loc_oPagina)
759: 
760:         *-- Mostrar apenas sub-pagina 1 inicialmente
761:         THIS.MostrarSubPagina(1)
762:     ENDPROC
763: 
764:     *===========================================================================
765:     * ConfigurarPgpgframeDados - Configura as 12 sub-paginas de dados internos
766:     * Equivalente ao pgframeDados do cntConta.clsconta legado (12 pages)
767:     * par_oPagina = THIS.pgf_4c_Paginas.Page2
768:     *===========================================================================
769:     PROTECTED PROCEDURE ConfigurarPgpgframeDados(par_oPagina)
770:         THIS.ConfigurarSubPagina1(par_oPagina)
771:         THIS.ConfigurarSubPagina2(par_oPagina)
772:         THIS.ConfigurarSubPagina3(par_oPagina)
773:         THIS.ConfigurarSubPagina4(par_oPagina)
774:         THIS.ConfigurarSubPagina5(par_oPagina)
775:         THIS.ConfigurarSubPagina6(par_oPagina)
776:         THIS.ConfigurarSubPagina7(par_oPagina)
777:         THIS.ConfigurarSubPagina8(par_oPagina)
778:         THIS.ConfigurarSubPagina9(par_oPagina)
779:         THIS.ConfigurarSubPagina10(par_oPagina)
780:         THIS.ConfigurarSubPagina11(par_oPagina)
781:         THIS.ConfigurarSubPagina12(par_oPagina)
782:     ENDPROC
783: 
784:     *===========================================================================
785:     * Sub-pagina 1: Principal (identificacao, endere~o, telefone)
786:     * Baseado em pgframeDados1 do cntConta.clsconta
787:     *===========================================================================
788:     PROTECTED PROCEDURE ConfigurarSubPagina1(par_oPagina)
789:         LOCAL loc_oCnt
790:         par_oPagina.AddObject("cnt_4c_Pg1", "Container")
791:         loc_oCnt = par_oPagina.cnt_4c_Pg1
792:         WITH loc_oCnt
793:             .Top         = 107
794:             .Left        = 0
795:             .Width       = 1000
796:             .Height      = 493
797:             .BackStyle   = 0
798:             .BorderWidth = 0
799:             .Visible     = .T.
800:         ENDWITH
801: 
802:         *-- Linha 1: Grupo + Codigo + InsMuns + Emissor
803:         loc_oCnt.AddObject("lbl_4c_LblGrupo", "Label")
804:         WITH loc_oCnt.lbl_4c_LblGrupo
805:             .Caption = "Grupo"
806:             .Top = 84
807:             .Left = 16
808:             .Width = 80
809:             .Height = 15
810:             .FontName = "Tahoma"
811:             .FontSize = 8
812:             .ForeColor = RGB(90, 90, 90)
813:             .BackStyle = 0
814:             .Visible = .T.
815:         ENDWITH
816: 
817:         loc_oCnt.AddObject("txt_4c_Grupos", "TextBox")
818:         WITH loc_oCnt.txt_4c_Grupos
819:             .Top = 99
820:             .Left = 16
821:             .Width = 80
822:             .Height = 23
823:             .FontName = "Tahoma"
824:             .FontSize = 8
825:             .SpecialEffect = 1
826:             .ForeColor = RGB(0, 0, 0)
827:             .BorderColor = RGB(100, 100, 100)
828:             .Value = ""
829:             .Visible = .T.
830:         ENDWITH
831:         BINDEVENT(loc_oCnt.txt_4c_Grupos, "KeyPress", THIS, "TxtGruposKeyPress")
832: 
833:         loc_oCnt.AddObject("lbl_4c_LblCodigo", "Label")
834:         WITH loc_oCnt.lbl_4c_LblCodigo
835:             .Caption = "C" + CHR(243) + "digo"
836:             .Top = 84
837:             .Left = 100
838:             .Width = 80
839:             .Height = 15
840:             .FontName = "Tahoma"
841:             .FontSize = 8
842:             .ForeColor = RGB(90, 90, 90)
843:             .BackStyle = 0
844:             .Visible = .T.
845:         ENDWITH
846: 
847:         loc_oCnt.AddObject("txt_4c_IClis", "TextBox")
848:         WITH loc_oCnt.txt_4c_IClis
849:             .Top = 99
850:             .Left = 100
851:             .Width = 80
852:             .Height = 23
853:             .FontName = "Tahoma"
854:             .FontSize = 8
855:             .SpecialEffect = 1
856:             .ForeColor = RGB(0, 0, 0)
857:             .BorderColor = RGB(100, 100, 100)
858:             .Value = ""
859:             .Visible = .T.
860:         ENDWITH
861: 
862:         *-- InsMuns
863:         loc_oCnt.AddObject("lbl_4c_LblInsMuns", "Label")
864:         WITH loc_oCnt.lbl_4c_LblInsMuns
865:             .Caption = "Ins.Municipal"
866:             .Top = 84
867:             .Left = 184
868:             .Width = 100
869:             .Height = 15
870:             .FontName = "Tahoma"
871:             .FontSize = 8

*-- Linhas 1899 a 1942:
1899:     *===========================================================================
1900:     * Sub-pagina 2: Comercial (Tabela preco, Forma pgto, Limite)
1901:     *===========================================================================
1902:     PROTECTED PROCEDURE ConfigurarSubPagina2(par_oPagina)
1903:         LOCAL loc_oCnt
1904:         par_oPagina.AddObject("cnt_4c_Pg2", "Container")
1905:         loc_oCnt = par_oPagina.cnt_4c_Pg2
1906:         WITH loc_oCnt
1907:             .Top = 107
1908:             .Left = 0
1909:             .Width = 1000
1910:             .Height = 493
1911:             .BackStyle = 0
1912:             .BorderWidth = 0
1913:             .Visible = .F.
1914:         ENDWITH
1915: 
1916:         *-- Tipo Cadastro
1917:         loc_oCnt.AddObject("lbl_4c_LblTpcads", "Label")
1918:         WITH loc_oCnt.lbl_4c_LblTpcads
1919:             .Caption = "Tipo Cadastro"
1920:             .Top = 30
1921:             .Left = 16
1922:             .Width = 100
1923:             .Height = 15
1924:             .FontName = "Tahoma"
1925:             .FontSize = 8
1926:             .ForeColor = RGB(90, 90, 90)
1927:             .BackStyle = 0
1928:             .Visible = .T.
1929:         ENDWITH
1930:         loc_oCnt.AddObject("txt_4c_Tpcads", "TextBox")
1931:         WITH loc_oCnt.txt_4c_Tpcads
1932:             .Top = 45
1933:             .Left = 16
1934:             .Width = 30
1935:             .Height = 23
1936:             .FontName = "Tahoma"
1937:             .FontSize = 8
1938:             .SpecialEffect = 1
1939:             .ForeColor = RGB(0, 0, 0)
1940:             .BorderColor = RGB(100, 100, 100)
1941:             .Value = 0
1942:             .Visible = .T.

*-- Linhas 2515 a 2558:
2515:     *===========================================================================
2516:     * Sub-paginas 3-12: containers com campos chave para BOParaForm
2517:     *===========================================================================
2518:     PROTECTED PROCEDURE ConfigurarSubPagina3(par_oPagina)
2519:         LOCAL loc_oCnt
2520:         par_oPagina.AddObject("cnt_4c_Pg3", "Container")
2521:         loc_oCnt = par_oPagina.cnt_4c_Pg3
2522:         WITH loc_oCnt
2523:             .Top = 107
2524:             .Left = 0
2525:             .Width = 1000
2526:             .Height = 493
2527:             .BackStyle = 0
2528:             .BorderWidth = 0
2529:             .Visible = .F.
2530:         ENDWITH
2531:         *-- Dados Bancarios
2532:         loc_oCnt.AddObject("lbl_4c_TituloP3", "Label")
2533:         WITH loc_oCnt.lbl_4c_TituloP3
2534:             .Caption = "Dados Banc" + CHR(225) + "rios"
2535:             .Top = 80
2536:             .Left = 40
2537:             .Width = 120
2538:             .Height = 15
2539:             .FontName = "Tahoma"
2540:             .FontSize = 10
2541:             .FontBold = .T.
2542:             .ForeColor = RGB(90, 90, 90)
2543:             .BackStyle = 0
2544:             .Visible = .T.
2545:         ENDWITH
2546:         *-- Campos de Endcob (usado em alguns formularios de banco)
2547:         loc_oCnt.AddObject("lbl_4c_LblEndcobs", "Label")
2548:         WITH loc_oCnt.lbl_4c_LblEndcobs
2549:             .Caption = "End.Cobran" + CHR(231) + "a"
2550:             .Top = 110
2551:             .Left = 16
2552:             .Width = 100
2553:             .Height = 15
2554:             .FontName = "Tahoma"
2555:             .FontSize = 8
2556:             .ForeColor = RGB(90, 90, 90)
2557:             .BackStyle = 0
2558:             .Visible = .T.

*-- Linhas 2643 a 2686:
2643:         ENDWITH
2644:     ENDPROC
2645: 
2646:     PROTECTED PROCEDURE ConfigurarSubPagina4(par_oPagina)
2647:         LOCAL loc_oCnt
2648:         par_oPagina.AddObject("cnt_4c_Pg4", "Container")
2649:         loc_oCnt = par_oPagina.cnt_4c_Pg4
2650:         WITH loc_oCnt
2651:             .Top = 107
2652:             .Left = 0
2653:             .Width = 1000
2654:             .Height = 493
2655:             .BackStyle = 0
2656:             .BorderWidth = 0
2657:             .Visible = .F.
2658:         ENDWITH
2659:         loc_oCnt.AddObject("lbl_4c_TituloP4", "Label")
2660:         WITH loc_oCnt.lbl_4c_TituloP4
2661:             .Caption = "Follow-up"
2662:             .Top = 80
2663:             .Left = 40
2664:             .Width = 100
2665:             .Height = 15
2666:             .FontName = "Tahoma"
2667:             .FontSize = 10
2668:             .FontBold = .T.
2669:             .ForeColor = RGB(90, 90, 90)
2670:             .BackStyle = 0
2671:             .Visible = .T.
2672:         ENDWITH
2673:         *-- Endereco trabalho
2674:         loc_oCnt.AddObject("lbl_4c_LblEndtrabs", "Label")
2675:         WITH loc_oCnt.lbl_4c_LblEndtrabs
2676:             .Caption = "End. Trabalho"
2677:             .Top = 110
2678:             .Left = 16
2679:             .Width = 100
2680:             .Height = 15
2681:             .FontName = "Tahoma"
2682:             .FontSize = 8
2683:             .ForeColor = RGB(90, 90, 90)
2684:             .BackStyle = 0
2685:             .Visible = .T.
2686:         ENDWITH

*-- Linhas 2840 a 2883:
2840:         ENDWITH
2841:     ENDPROC
2842: 
2843:     PROTECTED PROCEDURE ConfigurarSubPagina5(par_oPagina)
2844:         LOCAL loc_oCnt
2845:         par_oPagina.AddObject("cnt_4c_Pg5", "Container")
2846:         loc_oCnt = par_oPagina.cnt_4c_Pg5
2847:         WITH loc_oCnt
2848:             .Top = 107
2849:             .Left = 0
2850:             .Width = 1000
2851:             .Height = 493
2852:             .BackStyle = 0
2853:             .BorderWidth = 0
2854:             .Visible = .F.
2855:         ENDWITH
2856:         loc_oCnt.AddObject("lbl_4c_TituloP5", "Label")
2857:         WITH loc_oCnt.lbl_4c_TituloP5
2858:             .Caption = "Conta Corrente"
2859:             .Top = 80
2860:             .Left = 40
2861:             .Width = 130
2862:             .Height = 15
2863:             .FontName = "Tahoma"
2864:             .FontSize = 10
2865:             .FontBold = .T.
2866:             .ForeColor = RGB(90, 90, 90)
2867:             .BackStyle = 0
2868:             .Visible = .T.
2869:         ENDWITH
2870:         *-- Endereco entrega (cos)
2871:         loc_oCnt.AddObject("lbl_4c_LblEndcos", "Label")
2872:         WITH loc_oCnt.lbl_4c_LblEndcos
2873:             .Caption = "End. Entrega"
2874:             .Top = 110
2875:             .Left = 16
2876:             .Width = 100
2877:             .Height = 15
2878:             .FontName = "Tahoma"
2879:             .FontSize = 8
2880:             .ForeColor = RGB(90, 90, 90)
2881:             .BackStyle = 0
2882:             .Visible = .T.
2883:         ENDWITH

*-- Linhas 3009 a 3052:
3009:         ENDWITH
3010:     ENDPROC
3011: 
3012:     PROTECTED PROCEDURE ConfigurarSubPagina6(par_oPagina)
3013:         LOCAL loc_oCnt
3014:         par_oPagina.AddObject("cnt_4c_Pg6", "Container")
3015:         loc_oCnt = par_oPagina.cnt_4c_Pg6
3016:         WITH loc_oCnt
3017:             .Top = 107
3018:             .Left = 0
3019:             .Width = 1000
3020:             .Height = 493
3021:             .BackStyle = 0
3022:             .BorderWidth = 0
3023:             .Visible = .F.
3024:         ENDWITH
3025:         loc_oCnt.AddObject("lbl_4c_TituloP6", "Label")
3026:         WITH loc_oCnt.lbl_4c_TituloP6
3027:             .Caption = "Dados Fiscais"
3028:             .Top = 80
3029:             .Left = 40
3030:             .Width = 120
3031:             .Height = 15
3032:             .FontName = "Tahoma"
3033:             .FontSize = 10
3034:             .FontBold = .T.
3035:             .ForeColor = RGB(90, 90, 90)
3036:             .BackStyle = 0
3037:             .Visible = .T.
3038:         ENDWITH
3039:         *-- Dados fiscais: Fpubls, Cfos, Codtifs, Tpcps, Rgcs, Pis, Microemps, Optsimples
3040:         loc_oCnt.AddObject("lbl_4c_LblFpubls", "Label")
3041:         WITH loc_oCnt.lbl_4c_LblFpubls
3042:             .Caption = "Finalidade"
3043:             .Top = 110
3044:             .Left = 16
3045:             .Width = 80
3046:             .Height = 15
3047:             .FontName = "Tahoma"
3048:             .FontSize = 8
3049:             .ForeColor = RGB(90, 90, 90)
3050:             .BackStyle = 0
3051:             .Visible = .T.
3052:         ENDWITH

*-- Linhas 3118 a 3139:
3118:             .ForeColor = RGB(0, 0, 0)
3119:             .BorderColor = RGB(100, 100, 100)
3120:             .Value = ""
3121:             .Visible = .T.
3122:         ENDWITH
3123:         loc_oCnt.AddObject("txt_4c_Pis", "TextBox")
3124:         WITH loc_oCnt.txt_4c_Pis
3125:             .Top = 125
3126:             .Left = 376
3127:             .Width = 100
3128:             .Height = 23
3129:             .FontName = "Tahoma"
3130:             .FontSize = 8
3131:             .SpecialEffect = 1
3132:             .ForeColor = RGB(0, 0, 0)
3133:             .BorderColor = RGB(100, 100, 100)
3134:             .Value = ""
3135:             .Visible = .T.
3136:         ENDWITH
3137:         loc_oCnt.AddObject("chk_4c_Microemps", "CheckBox")
3138:         WITH loc_oCnt.chk_4c_Microemps
3139:             .Caption = "Microempresa"

*-- Linhas 3181 a 3224:
3181:         ENDWITH
3182:     ENDPROC
3183: 
3184:     PROTECTED PROCEDURE ConfigurarSubPagina7(par_oPagina)
3185:         LOCAL loc_oCnt
3186:         par_oPagina.AddObject("cnt_4c_Pg7", "Container")
3187:         loc_oCnt = par_oPagina.cnt_4c_Pg7
3188:         WITH loc_oCnt
3189:             .Top = 107
3190:             .Left = 0
3191:             .Width = 1000
3192:             .Height = 493
3193:             .BackStyle = 0
3194:             .BorderWidth = 0
3195:             .Visible = .F.
3196:         ENDWITH
3197:         loc_oCnt.AddObject("lbl_4c_TituloP7", "Label")
3198:         WITH loc_oCnt.lbl_4c_TituloP7
3199:             .Caption = "Complemento"
3200:             .Top = 80
3201:             .Left = 40
3202:             .Width = 120
3203:             .Height = 15
3204:             .FontName = "Tahoma"
3205:             .FontSize = 10
3206:             .FontBold = .T.
3207:             .ForeColor = RGB(90, 90, 90)
3208:             .BackStyle = 0
3209:             .Visible = .T.
3210:         ENDWITH
3211:         *-- Campos misc: Contats, Ctelems, Rg2 (Cpfcs), Emissors, Nomearts
3212:         loc_oCnt.AddObject("lbl_4c_LblContats", "Label")
3213:         WITH loc_oCnt.lbl_4c_LblContats
3214:             .Caption = "Contatos adicionais"
3215:             .Top = 110
3216:             .Left = 16
3217:             .Width = 130
3218:             .Height = 15
3219:             .FontName = "Tahoma"
3220:             .FontSize = 8
3221:             .ForeColor = RGB(90, 90, 90)
3222:             .BackStyle = 0
3223:             .Visible = .T.
3224:         ENDWITH

*-- Linhas 3262 a 3283:
3262:             .ForeColor = RGB(0, 0, 0)
3263:             .BorderColor = RGB(100, 100, 100)
3264:             .Value = ""
3265:             .Visible = .T.
3266:         ENDWITH
3267:         loc_oCnt.AddObject("txt_4c_Emissors", "TextBox")
3268:         WITH loc_oCnt.txt_4c_Emissors
3269:             .Top = 165
3270:             .Left = 16
3271:             .Width = 100
3272:             .Height = 23
3273:             .FontName = "Tahoma"
3274:             .FontSize = 8
3275:             .SpecialEffect = 1
3276:             .ForeColor = RGB(0, 0, 0)
3277:             .BorderColor = RGB(100, 100, 100)
3278:             .Value = ""
3279:             .Visible = .T.
3280:         ENDWITH
3281:         loc_oCnt.AddObject("txt_4c_Senhas", "TextBox")
3282:         WITH loc_oCnt.txt_4c_Senhas
3283:             .Top = 165

*-- Linhas 3394 a 3437:
3394:         ENDWITH
3395:     ENDPROC
3396: 
3397:     PROTECTED PROCEDURE ConfigurarSubPagina8(par_oPagina)
3398:         LOCAL loc_oCnt
3399:         par_oPagina.AddObject("cnt_4c_Pg8", "Container")
3400:         loc_oCnt = par_oPagina.cnt_4c_Pg8
3401:         WITH loc_oCnt
3402:             .Top = 107
3403:             .Left = 0
3404:             .Width = 1000
3405:             .Height = 493
3406:             .BackStyle = 0
3407:             .BorderWidth = 0
3408:             .Visible = .F.
3409:         ENDWITH
3410:         loc_oCnt.AddObject("lbl_4c_TituloP8", "Label")
3411:         WITH loc_oCnt.lbl_4c_TituloP8
3412:             .Caption = "Empresa"
3413:             .Top = 80
3414:             .Left = 40
3415:             .Width = 80
3416:             .Height = 15
3417:             .FontName = "Tahoma"
3418:             .FontSize = 10
3419:             .FontBold = .T.
3420:             .ForeColor = RGB(90, 90, 90)
3421:             .BackStyle = 0
3422:             .Visible = .T.
3423:         ENDWITH
3424:         *-- Empresa / usuario
3425:         loc_oCnt.AddObject("lbl_4c_LblEmps", "Label")
3426:         WITH loc_oCnt.lbl_4c_LblEmps
3427:             .Caption = "Empresa"
3428:             .Top = 110
3429:             .Left = 16
3430:             .Width = 80
3431:             .Height = 15
3432:             .FontName = "Tahoma"
3433:             .FontSize = 8
3434:             .ForeColor = RGB(90, 90, 90)
3435:             .BackStyle = 0
3436:             .Visible = .T.
3437:         ENDWITH

*-- Linhas 3511 a 3554:
3511:         ENDWITH
3512:     ENDPROC
3513: 
3514:     PROTECTED PROCEDURE ConfigurarSubPagina9(par_oPagina)
3515:         LOCAL loc_oCnt
3516:         par_oPagina.AddObject("cnt_4c_Pg9", "Container")
3517:         loc_oCnt = par_oPagina.cnt_4c_Pg9
3518:         WITH loc_oCnt
3519:             .Top = 107
3520:             .Left = 0
3521:             .Width = 1000
3522:             .Height = 493
3523:             .BackStyle = 0
3524:             .BorderWidth = 0
3525:             .Visible = .F.
3526:         ENDWITH
3527: 
3528:         loc_oCnt.AddObject("lbl_4c_TituloP9", "Label")
3529:         WITH loc_oCnt.lbl_4c_TituloP9
3530:             .Caption = "Dados Cont" + CHR(225) + "beis"
3531:             .Top = 5
3532:             .Left = 16
3533:             .Width = 200
3534:             .Height = 15
3535:             .FontName = "Tahoma"
3536:             .FontSize = 10
3537:             .FontBold = .T.
3538:             .ForeColor = RGB(90, 90, 90)
3539:             .BackStyle = 0
3540:             .Visible = .T.
3541:         ENDWITH
3542: 
3543:         *-- Cabecalho das colunas
3544:         LOCAL loc_aHdr[7,2]
3545:         loc_aHdr[1,1] = "Gr.Cont" + CHR(225) + "bil"   && header caption
3546:         loc_aHdr[1,2] = 65                              && Left
3547:         loc_aHdr[2,1] = "Conta"
3548:         loc_aHdr[2,2] = 150
3549:         loc_aHdr[3,1] = "Descri" + CHR(231) + CHR(227) + "o"
3550:         loc_aHdr[3,2] = 235
3551:         loc_aHdr[4,1] = "Al" + CHR(237) + "quota%"
3552:         loc_aHdr[4,2] = 438
3553:         loc_aHdr[5,1] = "Receita"
3554:         loc_aHdr[5,2] = 500

*-- Linhas 3741 a 3803:
3741:                 .Visible       = .T.
3742:             ENDWITH
3743: 
3744:             *-- BINDEVENT para lookups: F4 abre picker
3745:             LOCAL loc_oGruRef, loc_oCdRef, loc_oDsRef
3746:             loc_oGruRef = THIS.LocalizarControle(loc_oCnt, "txt_4c_Gru" + loc_cSfx)
3747:             loc_oCdRef  = THIS.LocalizarControle(loc_oCnt, "txt_4c_Cd"  + loc_cSfx)
3748:             loc_oDsRef  = THIS.LocalizarControle(loc_oCnt, "txt_4c_Ds"  + loc_cSfx)
3749:             IF VARTYPE(loc_oGruRef) = "O"
3750:                 BINDEVENT(loc_oGruRef, "KeyPress", THIS, "TxtGru" + loc_cSfx + "KeyPress")
3751:             ENDIF
3752:             IF VARTYPE(loc_oCdRef) = "O"
3753:                 BINDEVENT(loc_oCdRef, "KeyPress", THIS, "TxtCd" + loc_cSfx + "KeyPress")
3754:             ENDIF
3755:             IF VARTYPE(loc_oDsRef) = "O"
3756:                 BINDEVENT(loc_oDsRef, "KeyPress", THIS, "TxtDs" + loc_cSfx + "KeyPress")
3757:             ENDIF
3758: 
3759:             loc_nTop = loc_nTop + 26
3760:         ENDFOR
3761:     ENDPROC
3762: 
3763:     PROTECTED PROCEDURE ConfigurarSubPagina10(par_oPagina)
3764:         LOCAL loc_oCnt
3765:         par_oPagina.AddObject("cnt_4c_Pg10", "Container")
3766:         loc_oCnt = par_oPagina.cnt_4c_Pg10
3767:         WITH loc_oCnt
3768:             .Top = 107
3769:             .Left = 0
3770:             .Width = 1000
3771:             .Height = 493
3772:             .BackStyle = 0
3773:             .BorderWidth = 0
3774:             .Visible = .F.
3775:         ENDWITH
3776:         loc_oCnt.AddObject("lbl_4c_TituloP10", "Label")
3777:         WITH loc_oCnt.lbl_4c_TituloP10
3778:             .Caption = "Informa" + CHR(231) + CHR(245) + "es Cadastrais"
3779:             .Top = 80
3780:             .Left = 40
3781:             .Width = 170
3782:             .Height = 15
3783:             .FontName = "Tahoma"
3784:             .FontSize = 10
3785:             .FontBold = .T.
3786:             .ForeColor = RGB(90, 90, 90)
3787:             .BackStyle = 0
3788:             .Visible = .T.
3789:         ENDWITH
3790:         *-- LGPD / Consentimentos
3791:         loc_oCnt.AddObject("chk_4c_Autdados", "CheckBox")
3792:         WITH loc_oCnt.chk_4c_Autdados
3793:             .Caption = "Autoriza dados"
3794:             .Top = 110
3795:             .Left = 16
3796:             .Width = 120
3797:             .Height = 23
3798:             .FontName = "Tahoma"
3799:             .FontSize = 8
3800:             .ForeColor = RGB(90, 90, 90)
3801:             .Alignment = 0
3802:             .SpecialEffect = 1
3803:             .Value = 0

*-- Linhas 3965 a 4008:
3965:         ENDWITH
3966:     ENDPROC
3967: 
3968:     PROTECTED PROCEDURE ConfigurarSubPagina11(par_oPagina)
3969:         LOCAL loc_oCnt
3970:         par_oPagina.AddObject("cnt_4c_Pg11", "Container")
3971:         loc_oCnt = par_oPagina.cnt_4c_Pg11
3972:         WITH loc_oCnt
3973:             .Top = 107
3974:             .Left = 0
3975:             .Width = 1000
3976:             .Height = 493
3977:             .BackStyle = 0
3978:             .BorderWidth = 0
3979:             .Visible = .F.
3980:         ENDWITH
3981:         loc_oCnt.AddObject("lbl_4c_TituloP11", "Label")
3982:         WITH loc_oCnt.lbl_4c_TituloP11
3983:             .Caption = "Caracter" + CHR(237) + "sticas"
3984:             .Top = 80
3985:             .Left = 40
3986:             .Width = 120
3987:             .Height = 15
3988:             .FontName = "Tahoma"
3989:             .FontSize = 10
3990:             .FontBold = .T.
3991:             .ForeColor = RGB(90, 90, 90)
3992:             .BackStyle = 0
3993:             .Visible = .T.
3994:         ENDWITH
3995:         *-- Flags numericos
3996:         loc_oCnt.AddObject("chk_4c_Gerbals", "CheckBox")
3997:         WITH loc_oCnt.chk_4c_Gerbals
3998:             .Caption = "Geracao Boleto"
3999:             .Top = 110
4000:             .Left = 16
4001:             .Width = 120
4002:             .Height = 23
4003:             .FontName = "Tahoma"
4004:             .FontSize = 8
4005:             .ForeColor = RGB(90, 90, 90)
4006:             .Alignment = 0
4007:             .SpecialEffect = 1
4008:             .Value = 0

*-- Linhas 4172 a 4215:
4172:         ENDWITH
4173:     ENDPROC
4174: 
4175:     PROTECTED PROCEDURE ConfigurarSubPagina12(par_oPagina)
4176:         LOCAL loc_oCnt
4177:         par_oPagina.AddObject("cnt_4c_Pg12", "Container")
4178:         loc_oCnt = par_oPagina.cnt_4c_Pg12
4179:         WITH loc_oCnt
4180:             .Top = 107
4181:             .Left = 0
4182:             .Width = 1000
4183:             .Height = 493
4184:             .BackStyle = 0
4185:             .BorderWidth = 0
4186:             .Visible = .F.
4187:         ENDWITH
4188:         loc_oCnt.AddObject("lbl_4c_TituloP12", "Label")
4189:         WITH loc_oCnt.lbl_4c_TituloP12
4190:             .Caption = "Perfil"
4191:             .Top = 80
4192:             .Left = 40
4193:             .Width = 80
4194:             .Height = 15
4195:             .FontName = "Tahoma"
4196:             .FontSize = 10
4197:             .FontBold = .T.
4198:             .ForeColor = RGB(90, 90, 90)
4199:             .BackStyle = 0
4200:             .Visible = .T.
4201:         ENDWITH
4202:         *-- Perfil (memo)
4203:         loc_oCnt.AddObject("lbl_4c_LblPerfil", "Label")
4204:         WITH loc_oCnt.lbl_4c_LblPerfil
4205:             .Caption = "Perfil do Cliente"
4206:             .Top = 110
4207:             .Left = 16
4208:             .Width = 120
4209:             .Height = 15
4210:             .FontName = "Tahoma"
4211:             .FontSize = 8
4212:             .ForeColor = RGB(90, 90, 90)
4213:             .BackStyle = 0
4214:             .Visible = .T.
4215:         ENDWITH

*-- Linhas 4260 a 4346:
4260:     *===========================================================================
4261:     * MostrarSubPagina - Exibe a sub-pagina indicada, oculta as demais
4262:     *===========================================================================
4263:     PROCEDURE MostrarSubPagina(par_nPagina)
4264:         LOCAL loc_oPagina, loc_nIdx
4265:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
4266:         LOCAL ARRAY loc_aNomes[12]
4267:         loc_aNomes[1] = "cnt_4c_Pg1"
4268:         loc_aNomes[2] = "cnt_4c_Pg2"
4269:         loc_aNomes[3] = "cnt_4c_Pg3"
4270:         loc_aNomes[4] = "cnt_4c_Pg4"
4271:         loc_aNomes[5] = "cnt_4c_Pg5"
4272:         loc_aNomes[6] = "cnt_4c_Pg6"
4273:         loc_aNomes[7] = "cnt_4c_Pg7"
4274:         loc_aNomes[8] = "cnt_4c_Pg8"
4275:         loc_aNomes[9] = "cnt_4c_Pg9"
4276:         loc_aNomes[10] = "cnt_4c_Pg10"
4277:         loc_aNomes[11] = "cnt_4c_Pg11"
4278:         loc_aNomes[12] = "cnt_4c_Pg12"
4279: 
4280:         FOR loc_nIdx = 1 TO 12
4281:             IF PEMSTATUS(loc_oPagina, loc_aNomes[loc_nIdx], 5)
4282:                 loc_oPagina.Controls(loc_aNomes[loc_nIdx]).Visible = (loc_nIdx = par_nPagina)
4283:             ENDIF
4284:         ENDFOR
4285: 
4286:         THIS.this_nSubPagina = par_nPagina
4287:         IF PEMSTATUS(loc_oPagina, "obj_4c_NavPaginas", 5)
4288:             loc_oPagina.obj_4c_NavPaginas.Value = par_nPagina
4289:         ENDIF
4290:     ENDPROC
4291: 
4292:     *===========================================================================
4293:     * NavPaginasClick - Handler do OptionGroup de navegacao
4294:     *===========================================================================
4295:     PROCEDURE NavPaginasClick()
4296:         LOCAL loc_nSel
4297:         loc_nSel = THIS.pgf_4c_Paginas.Page2.obj_4c_NavPaginas.Value
4298:         IF loc_nSel >= 1 AND loc_nSel <= 12
4299:             THIS.MostrarSubPagina(loc_nSel)
4300:         ENDIF
4301:     ENDPROC
4302: 
4303:     *===========================================================================
4304:     * CarregarLista - Popula grid com contas do filtro atual
4305:     *===========================================================================
4306:     PROCEDURE CarregarLista()
4307:         LOCAL loc_oPg1, loc_cFiltro, loc_cGrupo, loc_dDtIni, loc_dDtFim
4308: 
4309:         TRY
4310:             loc_oPg1 = THIS.pgf_4c_Paginas.Page1
4311:             loc_cGrupo = ""
4312:             loc_dDtIni = DATE() - 365
4313:             loc_dDtFim = DATE()
4314: 
4315:             IF PEMSTATUS(loc_oPg1, "cnt_4c_Filtros", 5)
4316:                 IF PEMSTATUS(loc_oPg1.cnt_4c_Filtros, "txt_4c_Grupo", 5)
4317:                     loc_cGrupo = ALLTRIM(NVL(loc_oPg1.cnt_4c_Filtros.txt_4c_Grupo.Value, ""))
4318:                 ENDIF
4319:                 IF PEMSTATUS(loc_oPg1.cnt_4c_Filtros, "txt_4c_DtIni", 5)
4320:                     IF VARTYPE(loc_oPg1.cnt_4c_Filtros.txt_4c_DtIni.Value) = "D"
4321:                         loc_dDtIni = loc_oPg1.cnt_4c_Filtros.txt_4c_DtIni.Value
4322:                     ENDIF
4323:                 ENDIF
4324:                 IF PEMSTATUS(loc_oPg1.cnt_4c_Filtros, "txt_4c_DtFim", 5)
4325:                     IF VARTYPE(loc_oPg1.cnt_4c_Filtros.txt_4c_DtFim.Value) = "D"
4326:                         loc_dDtFim = loc_oPg1.cnt_4c_Filtros.txt_4c_DtFim.Value
4327:                     ENDIF
4328:                 ENDIF
4329:             ENDIF
4330: 
4331:             IF !EMPTY(loc_cGrupo)
4332:                 loc_cFiltro = "a.Grupos = " + EscaparSQL(PADR(loc_cGrupo, 10)) + ;
4333:                     " AND a.DtAlts BETWEEN " + FormatarDataSQL(loc_dDtIni) + ;
4334:                     " AND " + FormatarDataSQL(loc_dDtFim)
4335:                 THIS.this_oBusinessObject.BuscarComFiltro(loc_cGrupo, loc_dDtIni, loc_dDtFim)
4336:             ELSE
4337:                 loc_cFiltro = "a.DtAlts BETWEEN " + FormatarDataSQL(loc_dDtIni) + ;
4338:                     " AND " + FormatarDataSQL(loc_dDtFim)
4339:                 THIS.this_oBusinessObject.Buscar(loc_cFiltro)
4340:             ENDIF
4341: 
4342:             IF USED("cursor_4c_Dados")
4343:                 loc_oPg1.grd_4c_Lista.ColumnCount = 3
4344:                 loc_oPg1.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
4345:                 WITH loc_oPg1.grd_4c_Lista
4346:                     .Column1.ControlSource   = "cursor_4c_Dados.IClis"

*-- Linhas 4365 a 4443:
4365:     *===========================================================================
4366:     * AlternarPagina - Alterna entre Page1 (LISTA) e Page2 (DADOS)
4367:     *===========================================================================
4368:     PROCEDURE AlternarPagina(par_cModo)
4369:         THIS.this_cModoAtual = par_cModo
4370: 
4371:         IF par_cModo = "DADOS"
4372:             THIS.pgf_4c_Paginas.ActivePage = 2
4373:             THIS.MostrarSubPagina(1)
4374:         ELSE
4375:             THIS.pgf_4c_Paginas.ActivePage = 1
4376:             THIS.AjustarBotoesPorModo()
4377:             THIS.CarregarLista()
4378:         ENDIF
4379:     ENDPROC
4380: 
4381:     *===========================================================================
4382:     * AjustarBotoesPorModo - Habilita/desabilita botoes conforme registros
4383:     *===========================================================================
4384:     PROCEDURE AjustarBotoesPorModo()
4385:         LOCAL loc_lTemRegistro, loc_oBotoes
4386:         loc_lTemRegistro = USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
4387:         loc_oBotoes = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
4388: 
4389:         IF PEMSTATUS(loc_oBotoes, "cmd_4c_Visualizar", 5)
4390:             loc_oBotoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
4391:         ENDIF
4392:         IF PEMSTATUS(loc_oBotoes, "cmd_4c_Alterar", 5)
4393:             loc_oBotoes.cmd_4c_Alterar.Enabled = loc_lTemRegistro
4394:         ENDIF
4395:         IF PEMSTATUS(loc_oBotoes, "cmd_4c_Excluir", 5)
4396:             loc_oBotoes.cmd_4c_Excluir.Enabled = loc_lTemRegistro
4397:         ENDIF
4398:     ENDPROC
4399: 
4400:     *===========================================================================
4401:     * FormParaBO - Transfere dados dos controles para o BO
4402:     *===========================================================================
4403:     PROCEDURE FormParaBO()
4404:         LOCAL loc_oPg1, loc_oPg2, loc_oP
4405:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
4406: 
4407:         WITH THIS.this_oBusinessObject
4408:             *-- Sub-pagina 1: Principal
4409:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Pg1", 5)
4410:                 loc_oP = loc_oPg2.cnt_4c_Pg1
4411:                 .this_cGrupos   = IIF(PEMSTATUS(loc_oP,"txt_4c_Grupos",5), ALLTRIM(NVL(loc_oP.txt_4c_Grupos.Value,"")), "")
4412:                 .this_cIClis    = IIF(PEMSTATUS(loc_oP,"txt_4c_IClis",5), ALLTRIM(NVL(loc_oP.txt_4c_IClis.Value,"")), "")
4413:                 .this_cRclis    = IIF(PEMSTATUS(loc_oP,"txt_4c_Rclis",5), ALLTRIM(NVL(loc_oP.txt_4c_Rclis.Value,"")), "")
4414:                 .this_cRazaos   = IIF(PEMSTATUS(loc_oP,"txt_4c_Razaos",5), ALLTRIM(NVL(loc_oP.txt_4c_Razaos.Value,"")), "")
4415:                 .this_cCpfs     = IIF(PEMSTATUS(loc_oP,"txt_4c_Cpfs",5), ALLTRIM(NVL(loc_oP.txt_4c_Cpfs.Value,"")), "")
4416:                 .this_cRgs      = IIF(PEMSTATUS(loc_oP,"txt_4c_Rgs",5), ALLTRIM(NVL(loc_oP.txt_4c_Rgs.Value,"")), "")
4417:                 .this_cSituas   = IIF(PEMSTATUS(loc_oP,"txt_4c_Situas",5), ALLTRIM(NVL(loc_oP.txt_4c_Situas.Value,"")), "")
4418:                 .this_cInscmuns = IIF(PEMSTATUS(loc_oP,"txt_4c_Inscmuns",5), ALLTRIM(NVL(loc_oP.txt_4c_Inscmuns.Value,"")), "")
4419:                 .this_nInativas = IIF(PEMSTATUS(loc_oP,"chk_4c_Inativas",5), IIF(loc_oP.chk_4c_Inativas.Value=1,1,0), 0)
4420:                 .this_cCodigos  = IIF(PEMSTATUS(loc_oP,"txt_4c_Codigos",5), ALLTRIM(NVL(loc_oP.txt_4c_Codigos.Value,"")), "")
4421:                 .this_cFpags    = IIF(PEMSTATUS(loc_oP,"txt_4c_Fpags",5), ALLTRIM(NVL(loc_oP.txt_4c_Fpags.Value,"")), "")
4422:                 .this_cGrupovens = IIF(PEMSTATUS(loc_oP,"txt_4c_Grupovens",5), ALLTRIM(NVL(loc_oP.txt_4c_Grupovens.Value,"")), "")
4423:                 .this_dNascs    = IIF(PEMSTATUS(loc_oP,"txt_4c_Nascs",5), NVL(loc_oP.txt_4c_Nascs.Value,{}), {})
4424:                 .this_cNacionals = IIF(PEMSTATUS(loc_oP,"txt_4c_Nacionals",5), ALLTRIM(NVL(loc_oP.txt_4c_Nacionals.Value,"")), "")
4425:                 .this_cSexos    = IIF(PEMSTATUS(loc_oP,"txt_4c_Sexos",5), ALLTRIM(NVL(loc_oP.txt_4c_Sexos.Value,"")), "")
4426:                 .this_cEstcivils = IIF(PEMSTATUS(loc_oP,"cmb_4c_Estcivils",5), ALLTRIM(NVL(loc_oP.cmb_4c_Estcivils.Value,"")), "")
4427:                 .this_cConjuges  = IIF(PEMSTATUS(loc_oP,"txt_4c_Conjuges",5), ALLTRIM(NVL(loc_oP.txt_4c_Conjuges.Value,"")), "")
4428:                 .this_cCpfcs    = IIF(PEMSTATUS(loc_oP,"txt_4c_Cpfcs",5), ALLTRIM(NVL(loc_oP.txt_4c_Cpfcs.Value,"")), "")
4429:                 .this_cRgconjuges = IIF(PEMSTATUS(loc_oP,"txt_4c_Rgconjuges",5), ALLTRIM(NVL(loc_oP.txt_4c_Rgconjuges.Value,"")), "")
4430:                 .this_nIdcontas  = IIF(PEMSTATUS(loc_oP,"txt_4c_Idcontas",5), NVL(loc_oP.txt_4c_Idcontas.Value,0), 0)
4431:                 .this_cCeps     = IIF(PEMSTATUS(loc_oP,"txt_4c_Ceps",5), ALLTRIM(NVL(loc_oP.txt_4c_Ceps.Value,"")), "")
4432:                 .this_cPaises   = IIF(PEMSTATUS(loc_oP,"txt_4c_Paises",5), ALLTRIM(NVL(loc_oP.txt_4c_Paises.Value,"")), "")
4433:                 .this_cRegiaos  = IIF(PEMSTATUS(loc_oP,"txt_4c_Regiaos",5), ALLTRIM(NVL(loc_oP.txt_4c_Regiaos.Value,"")), "")
4434:                 .this_cEndes    = IIF(PEMSTATUS(loc_oP,"txt_4c_Endes",5), ALLTRIM(NVL(loc_oP.txt_4c_Endes.Value,"")), "")
4435:                 .this_cNums     = IIF(PEMSTATUS(loc_oP,"txt_4c_Nums",5), ALLTRIM(NVL(loc_oP.txt_4c_Nums.Value,"")), "")
4436:                 .this_cCompls   = IIF(PEMSTATUS(loc_oP,"txt_4c_Compls",5), ALLTRIM(NVL(loc_oP.txt_4c_Compls.Value,"")), "")
4437:                 .this_cBairs    = IIF(PEMSTATUS(loc_oP,"txt_4c_Bairs",5), ALLTRIM(NVL(loc_oP.txt_4c_Bairs.Value,"")), "")
4438:                 .this_cCidas    = IIF(PEMSTATUS(loc_oP,"txt_4c_Cidas",5), ALLTRIM(NVL(loc_oP.txt_4c_Cidas.Value,"")), "")
4439:                 .this_cEstas    = IIF(PEMSTATUS(loc_oP,"txt_4c_Estas",5), ALLTRIM(NVL(loc_oP.txt_4c_Estas.Value,"")), "")
4440:                 .this_cDdds     = IIF(PEMSTATUS(loc_oP,"txt_4c_Ddds",5), ALLTRIM(NVL(loc_oP.txt_4c_Ddds.Value,"")), "")
4441:                 .this_cTel1s    = IIF(PEMSTATUS(loc_oP,"txt_4c_Tel1s",5), ALLTRIM(NVL(loc_oP.txt_4c_Tel1s.Value,"")), "")
4442:                 .this_cTel2s    = IIF(PEMSTATUS(loc_oP,"txt_4c_Tel2s",5), ALLTRIM(NVL(loc_oP.txt_4c_Tel2s.Value,"")), "")
4443:                 .this_cFaxs     = IIF(PEMSTATUS(loc_oP,"txt_4c_Faxs",5), ALLTRIM(NVL(loc_oP.txt_4c_Faxs.Value,"")), "")

*-- Linhas 4521 a 4553:
4521:                 .this_cFpubls   = IIF(PEMSTATUS(loc_oP,"txt_4c_Fpubls",5), ALLTRIM(NVL(loc_oP.txt_4c_Fpubls.Value,"")), "")
4522:                 .this_cCfos     = IIF(PEMSTATUS(loc_oP,"txt_4c_Cfos",5), ALLTRIM(NVL(loc_oP.txt_4c_Cfos.Value,"")), "")
4523:                 .this_cCodtifs  = IIF(PEMSTATUS(loc_oP,"txt_4c_Codtifs",5), ALLTRIM(NVL(loc_oP.txt_4c_Codtifs.Value,"")), "")
4524:                 .this_cTpcps    = IIF(PEMSTATUS(loc_oP,"txt_4c_Tpcps",5), ALLTRIM(NVL(loc_oP.txt_4c_Tpcps.Value,"")), "")
4525:                 .this_cRgcs     = IIF(PEMSTATUS(loc_oP,"txt_4c_Rgcs",5), ALLTRIM(NVL(loc_oP.txt_4c_Rgcs.Value,"")), "")
4526:                 .this_cPis      = IIF(PEMSTATUS(loc_oP,"txt_4c_Pis",5), ALLTRIM(NVL(loc_oP.txt_4c_Pis.Value,"")), "")
4527:                 .this_cMicroemps = IIF(PEMSTATUS(loc_oP,"chk_4c_Microemps",5), IIF(loc_oP.chk_4c_Microemps.Value=1,"S","N"), "N")
4528:                 .this_cOptsimples = IIF(PEMSTATUS(loc_oP,"chk_4c_Optsimples",5), IIF(loc_oP.chk_4c_Optsimples.Value=1,"S","N"), "N")
4529:                 .this_cSuframas = IIF(PEMSTATUS(loc_oP,"txt_4c_Suframas",5), ALLTRIM(NVL(loc_oP.txt_4c_Suframas.Value,"")), "")
4530:             ENDIF
4531: 
4532:             *-- Sub-pagina 7: Complemento
4533:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Pg7", 5)
4534:                 loc_oP = loc_oPg2.cnt_4c_Pg7
4535:                 .this_cContats  = IIF(PEMSTATUS(loc_oP,"txt_4c_Contats",5), ALLTRIM(NVL(loc_oP.txt_4c_Contats.Value,"")), "")
4536:                 .this_cCtelems  = IIF(PEMSTATUS(loc_oP,"txt_4c_Ctelems",5), ALLTRIM(NVL(loc_oP.txt_4c_Ctelems.Value,"")), "")
4537:                 .this_cNomearts = IIF(PEMSTATUS(loc_oP,"txt_4c_Nomearts",5), ALLTRIM(NVL(loc_oP.txt_4c_Nomearts.Value,"")), "")
4538:                 .this_cEmissors = IIF(PEMSTATUS(loc_oP,"txt_4c_Emissors",5), ALLTRIM(NVL(loc_oP.txt_4c_Emissors.Value,"")), "")
4539:                 .this_cSenhas   = IIF(PEMSTATUS(loc_oP,"txt_4c_Senhas",5), ALLTRIM(NVL(loc_oP.txt_4c_Senhas.Value,"")), "")
4540:                 .this_nColetors = IIF(PEMSTATUS(loc_oP,"txt_4c_Coletors",5), NVL(loc_oP.txt_4c_Coletors.Value,0), 0)
4541:                 .this_nConsignas = IIF(PEMSTATUS(loc_oP,"txt_4c_Consignas",5), NVL(loc_oP.txt_4c_Consignas.Value,0), 0)
4542:                 .this_nMasters  = IIF(PEMSTATUS(loc_oP,"txt_4c_Masters",5), NVL(loc_oP.txt_4c_Masters.Value,0), 0)
4543:                 .this_nIntconts = IIF(PEMSTATUS(loc_oP,"txt_4c_Intconts",5), NVL(loc_oP.txt_4c_Intconts.Value,0), 0)
4544:                 .this_cObspagto = IIF(PEMSTATUS(loc_oP,"txt_4c_Obspagto",5), ALLTRIM(NVL(loc_oP.txt_4c_Obspagto.Value,"")), "")
4545:                 .this_cPracas   = IIF(PEMSTATUS(loc_oP,"txt_4c_Pracas",5), ALLTRIM(NVL(loc_oP.txt_4c_Pracas.Value,"")), "")
4546:             ENDIF
4547: 
4548:             *-- Sub-pagina 8: Empresa
4549:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Pg8", 5)
4550:                 loc_oP = loc_oPg2.cnt_4c_Pg8
4551:                 .this_cEmps     = IIF(PEMSTATUS(loc_oP,"txt_4c_Emps",5), ALLTRIM(NVL(loc_oP.txt_4c_Emps.Value,"")), "")
4552:             ENDIF
4553: 

*-- Linhas 4614 a 4657:
4614:     *===========================================================================
4615:     * BOParaForm - Transfere dados do BO para os controles
4616:     *===========================================================================
4617:     PROCEDURE BOParaForm()
4618:         LOCAL loc_oPg2, loc_oP
4619:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
4620: 
4621:         WITH THIS.this_oBusinessObject
4622:             *-- Sub-pagina 1
4623:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Pg1", 5)
4624:                 loc_oP = loc_oPg2.cnt_4c_Pg1
4625:                 IF PEMSTATUS(loc_oP,"txt_4c_Grupos",5)
4626:                     loc_oP.txt_4c_Grupos.Value = .this_cGrupos
4627:                 ENDIF
4628:                 IF PEMSTATUS(loc_oP,"txt_4c_IClis",5)
4629:                     loc_oP.txt_4c_IClis.Value = .this_cIClis
4630:                 ENDIF
4631:                 IF PEMSTATUS(loc_oP,"txt_4c_Rclis",5)
4632:                     loc_oP.txt_4c_Rclis.Value = .this_cRclis
4633:                 ENDIF
4634:                 IF PEMSTATUS(loc_oP,"txt_4c_Razaos",5)
4635:                     loc_oP.txt_4c_Razaos.Value = .this_cRazaos
4636:                 ENDIF
4637:                 IF PEMSTATUS(loc_oP,"txt_4c_Cpfs",5)
4638:                     loc_oP.txt_4c_Cpfs.Value = .this_cCpfs
4639:                 ENDIF
4640:                 IF PEMSTATUS(loc_oP,"txt_4c_Rgs",5)
4641:                     loc_oP.txt_4c_Rgs.Value = .this_cRgs
4642:                 ENDIF
4643:                 IF PEMSTATUS(loc_oP,"txt_4c_Situas",5)
4644:                     loc_oP.txt_4c_Situas.Value = .this_cSituas
4645:                 ENDIF
4646:                 IF PEMSTATUS(loc_oP,"txt_4c_Inscmuns",5)
4647:                     loc_oP.txt_4c_Inscmuns.Value = .this_cInscmuns
4648:                 ENDIF
4649:                 IF PEMSTATUS(loc_oP,"chk_4c_Inativas",5)
4650:                     loc_oP.chk_4c_Inativas.Value = IIF(.this_nInativas=1,1,0)
4651:                 ENDIF
4652:                 IF PEMSTATUS(loc_oP,"txt_4c_Codigos",5)
4653:                     loc_oP.txt_4c_Codigos.Value = .this_cCodigos
4654:                 ENDIF
4655:                 IF PEMSTATUS(loc_oP,"txt_4c_Grupovens",5)
4656:                     loc_oP.txt_4c_Grupovens.Value = .this_cGrupovens
4657:                 ENDIF

*-- Linhas 4915 a 4960:
4915:                     loc_oP.txt_4c_Tpcps.Value = .this_cTpcps
4916:                 ENDIF
4917:                 IF PEMSTATUS(loc_oP,"txt_4c_Rgcs",5)
4918:                     loc_oP.txt_4c_Rgcs.Value = .this_cRgcs
4919:                 ENDIF
4920:                 IF PEMSTATUS(loc_oP,"txt_4c_Pis",5)
4921:                     loc_oP.txt_4c_Pis.Value = .this_cPis
4922:                 ENDIF
4923:                 IF PEMSTATUS(loc_oP,"chk_4c_Microemps",5)
4924:                     loc_oP.chk_4c_Microemps.Value = IIF(ALLTRIM(.this_cMicroemps)="S",1,0)
4925:                 ENDIF
4926:                 IF PEMSTATUS(loc_oP,"chk_4c_Optsimples",5)
4927:                     loc_oP.chk_4c_Optsimples.Value = IIF(ALLTRIM(.this_cOptsimples)="S",1,0)
4928:                 ENDIF
4929:                 IF PEMSTATUS(loc_oP,"txt_4c_Suframas",5)
4930:                     loc_oP.txt_4c_Suframas.Value = .this_cSuframas
4931:                 ENDIF
4932:             ENDIF
4933:             IF PEMSTATUS(loc_oPg2,"cnt_4c_Pg7",5)
4934:                 loc_oP = loc_oPg2.cnt_4c_Pg7
4935:                 IF PEMSTATUS(loc_oP,"txt_4c_Contats",5)
4936:                     loc_oP.txt_4c_Contats.Value = .this_cContats
4937:                 ENDIF
4938:                 IF PEMSTATUS(loc_oP,"txt_4c_Ctelems",5)
4939:                     loc_oP.txt_4c_Ctelems.Value = .this_cCtelems
4940:                 ENDIF
4941:                 IF PEMSTATUS(loc_oP,"txt_4c_Nomearts",5)
4942:                     loc_oP.txt_4c_Nomearts.Value = .this_cNomearts
4943:                 ENDIF
4944:                 IF PEMSTATUS(loc_oP,"txt_4c_Emissors",5)
4945:                     loc_oP.txt_4c_Emissors.Value = .this_cEmissors
4946:                 ENDIF
4947:                 IF PEMSTATUS(loc_oP,"txt_4c_Coletors",5)
4948:                     loc_oP.txt_4c_Coletors.Value = .this_nColetors
4949:                 ENDIF
4950:                 IF PEMSTATUS(loc_oP,"txt_4c_Consignas",5)
4951:                     loc_oP.txt_4c_Consignas.Value = .this_nConsignas
4952:                 ENDIF
4953:                 IF PEMSTATUS(loc_oP,"txt_4c_Masters",5)
4954:                     loc_oP.txt_4c_Masters.Value = .this_nMasters
4955:                 ENDIF
4956:                 IF PEMSTATUS(loc_oP,"txt_4c_Intconts",5)
4957:                     loc_oP.txt_4c_Intconts.Value = .this_nIntconts
4958:                 ENDIF
4959:                 IF PEMSTATUS(loc_oP,"txt_4c_Obspagto",5)
4960:                     loc_oP.txt_4c_Obspagto.Value = .this_cObspagto

*-- Linhas 5074 a 5117:
5074:     *===========================================================================
5075:     * LimparCampos - Limpa todos os controles de entrada
5076:     *===========================================================================
5077:     PROCEDURE LimparCampos()
5078:         LOCAL loc_oPg2, loc_oP
5079:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
5080:         *-- Sub-pagina 1
5081:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Pg1", 5)
5082:             loc_oP = loc_oPg2.cnt_4c_Pg1
5083:             IF PEMSTATUS(loc_oP,"txt_4c_Grupos",5)
5084:                 loc_oP.txt_4c_Grupos.Value = ""
5085:             ENDIF
5086:             IF PEMSTATUS(loc_oP,"txt_4c_IClis",5)
5087:                 loc_oP.txt_4c_IClis.Value = ""
5088:             ENDIF
5089:             IF PEMSTATUS(loc_oP,"txt_4c_Rclis",5)
5090:                 loc_oP.txt_4c_Rclis.Value = ""
5091:             ENDIF
5092:             IF PEMSTATUS(loc_oP,"txt_4c_Razaos",5)
5093:                 loc_oP.txt_4c_Razaos.Value = ""
5094:             ENDIF
5095:             IF PEMSTATUS(loc_oP,"txt_4c_Cpfs",5)
5096:                 loc_oP.txt_4c_Cpfs.Value = ""
5097:             ENDIF
5098:             IF PEMSTATUS(loc_oP,"txt_4c_Rgs",5)
5099:                 loc_oP.txt_4c_Rgs.Value = ""
5100:             ENDIF
5101:             IF PEMSTATUS(loc_oP,"txt_4c_Situas",5)
5102:                 loc_oP.txt_4c_Situas.Value = ""
5103:             ENDIF
5104:             IF PEMSTATUS(loc_oP,"chk_4c_Inativas",5)
5105:                 loc_oP.chk_4c_Inativas.Value = 0
5106:             ENDIF
5107:             IF PEMSTATUS(loc_oP,"txt_4c_Endes",5)
5108:                 loc_oP.txt_4c_Endes.Value = ""
5109:             ENDIF
5110:             IF PEMSTATUS(loc_oP,"txt_4c_Ceps",5)
5111:                 loc_oP.txt_4c_Ceps.Value = ""
5112:             ENDIF
5113:             IF PEMSTATUS(loc_oP,"txt_4c_Cidas",5)
5114:                 loc_oP.txt_4c_Cidas.Value = ""
5115:             ENDIF
5116:             IF PEMSTATUS(loc_oP,"txt_4c_Estas",5)
5117:                 loc_oP.txt_4c_Estas.Value = ""

*-- Linhas 5183 a 5774:
5183:     *===========================================================================
5184:     * HabilitarCampos - Habilita/desabilita controles conforme modo
5185:     *===========================================================================
5186:     PROCEDURE HabilitarCampos(par_lHabilitar)
5187:         LOCAL loc_oPg2, loc_oP, loc_i
5188:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
5189:         LOCAL ARRAY loc_aSubPags[12]
5190:         loc_aSubPags[1] = "cnt_4c_Pg1"
5191:         loc_aSubPags[2] = "cnt_4c_Pg2"
5192:         loc_aSubPags[3] = "cnt_4c_Pg3"
5193:         loc_aSubPags[4] = "cnt_4c_Pg4"
5194:         loc_aSubPags[5] = "cnt_4c_Pg5"
5195:         loc_aSubPags[6] = "cnt_4c_Pg6"
5196:         loc_aSubPags[7] = "cnt_4c_Pg7"
5197:         loc_aSubPags[8] = "cnt_4c_Pg8"
5198:         loc_aSubPags[9] = "cnt_4c_Pg9"
5199:         loc_aSubPags[10] = "cnt_4c_Pg10"
5200:         loc_aSubPags[11] = "cnt_4c_Pg11"
5201:         loc_aSubPags[12] = "cnt_4c_Pg12"
5202: 
5203:         FOR loc_i = 1 TO 12
5204:             IF PEMSTATUS(loc_oPg2, loc_aSubPags[loc_i], 5)
5205:                 loc_oP = loc_oPg2.Controls(loc_aSubPags[loc_i])
5206:                 LOCAL loc_j
5207:                 FOR loc_j = 1 TO loc_oP.ControlCount
5208:                     LOCAL loc_oCtrl
5209:                     loc_oCtrl = loc_oP.Controls(loc_j)
5210:                     IF VARTYPE(loc_oCtrl) = "O" AND ;
5211:                         (PEMSTATUS(loc_oCtrl, "ReadOnly", 5) OR PEMSTATUS(loc_oCtrl, "Value", 5))
5212:                         IF !INLIST(UPPER(loc_oCtrl.Name), ;
5213:                             "TXT_4C_DATAINCS", "TXT_4C_DTALTS", "TXT_4C_ULTCOMPS", ;
5214:                             "TXT_4C_IDCONTAS", "TXT_4C_USUALTS", "TXT_4C_USUARS")
5215:                             IF PEMSTATUS(loc_oCtrl, "Enabled", 5)
5216:                                 loc_oCtrl.Enabled = par_lHabilitar
5217:                             ENDIF
5218:                         ENDIF
5219:                     ENDIF
5220:                 ENDFOR
5221:             ENDIF
5222:         ENDFOR
5223: 
5224:         *-- Botoes Salvar/Cancelar sempre habilitados em modo dados
5225:         IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
5226:             WITH loc_oPg2.cnt_4c_BotoesAcao
5227:                 IF PEMSTATUS(.cmd_4c_Confirmar, "Enabled", 5)
5228:                     .cmd_4c_Confirmar.Enabled = .T.
5229:                 ENDIF
5230:                 IF PEMSTATUS(.cmd_4c_Cancelar, "Enabled", 5)
5231:                     .cmd_4c_Cancelar.Enabled = .T.
5232:                 ENDIF
5233:                 .Visible     = .T.
5234:             ENDWITH
5235:         ENDIF
5236:     ENDPROC
5237: 
5238:     *===========================================================================
5239:     * Eventos CRUD - Page 1
5240:     *===========================================================================
5241:     PROCEDURE BtnIncluirClick()
5242:         THIS.this_oBusinessObject.NovoRegistro()
5243:         THIS.LimparCampos()
5244:         THIS.HabilitarCampos(.T.)
5245:         THIS.AlternarPagina("DADOS")
5246:         THIS.MostrarSubPagina(1)
5247: 
5248:         *-- Auto-preenche empresa
5249:         LOCAL loc_oP
5250:         loc_oP = THIS.pgf_4c_Paginas.Page2.cnt_4c_Pg8
5251:         IF PEMSTATUS(loc_oP, "txt_4c_Emps", 5)
5252:             loc_oP.txt_4c_Emps.Value = go_4c_Sistema.cCodEmpresa
5253:         ENDIF
5254:     ENDPROC
5255: 
5256:     PROCEDURE BtnVisualizarClick()
5257:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
5258:             MsgAviso("Selecione um registro para visualizar.", "Visualizar")
5259:             RETURN
5260:         ENDIF
5261:         SELECT cursor_4c_Dados
5262:         LOCAL loc_cCodigo
5263:         loc_cCodigo = ALLTRIM(NVL(cursor_4c_Dados.IClis, ""))
5264:         IF EMPTY(loc_cCodigo)
5265:             MsgAviso("Selecione um registro para visualizar.", "Visualizar")
5266:             RETURN
5267:         ENDIF
5268: 
5269:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
5270:             THIS.BOParaForm()
5271:             THIS.HabilitarCampos(.F.)
5272:             THIS.AlternarPagina("DADOS")
5273:             THIS.MostrarSubPagina(1)
5274:         ELSE
5275:             MsgAviso("Erro ao carregar conta selecionada.", "Visualizar")
5276:         ENDIF
5277:     ENDPROC
5278: 
5279:     PROCEDURE BtnAlterarClick()
5280:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
5281:             MsgAviso("Selecione um registro para alterar.", "Alterar")
5282:             RETURN
5283:         ENDIF
5284:         SELECT cursor_4c_Dados
5285:         LOCAL loc_cCodigo
5286:         loc_cCodigo = ALLTRIM(NVL(cursor_4c_Dados.IClis, ""))
5287:         IF EMPTY(loc_cCodigo)
5288:             MsgAviso("Selecione um registro para alterar.", "Alterar")
5289:             RETURN
5290:         ENDIF
5291: 
5292:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
5293:             THIS.this_oBusinessObject.EditarRegistro()
5294:             THIS.BOParaForm()
5295:             THIS.HabilitarCampos(.T.)
5296:             THIS.AlternarPagina("DADOS")
5297:             THIS.MostrarSubPagina(1)
5298:         ELSE
5299:             MsgAviso("Erro ao carregar conta para edi" + CHR(231) + CHR(227) + "o.", "Alterar")
5300:         ENDIF
5301:     ENDPROC
5302: 
5303:     PROCEDURE BtnExcluirClick()
5304:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
5305:             MsgAviso("Selecione um registro para excluir.", "Excluir")
5306:             RETURN
5307:         ENDIF
5308:         SELECT cursor_4c_Dados
5309:         LOCAL loc_cCodigo, loc_cNome, loc_lConfirma
5310:         loc_cCodigo = ALLTRIM(NVL(cursor_4c_Dados.IClis, ""))
5311:         loc_cNome   = ALLTRIM(NVL(cursor_4c_Dados.Rclis, ""))
5312:         IF EMPTY(loc_cCodigo)
5313:             MsgAviso("Selecione um registro para excluir.", "Excluir")
5314:             RETURN
5315:         ENDIF
5316: 
5317:         loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o da conta:" + CHR(13) + ;
5318:             loc_cNome + " [" + loc_cCodigo + "] ?", "Excluir Conta")
5319:         IF !loc_lConfirma
5320:             RETURN
5321:         ENDIF
5322: 
5323:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
5324:             IF THIS.this_oBusinessObject.Excluir()
5325:                 MsgInfo("Conta exclu" + CHR(237) + "da com sucesso.", "Excluir")
5326:                 THIS.CarregarLista()
5327:             ELSE
5328:                 MsgErro("Erro ao excluir conta:" + CHR(13) + ;
5329:                     THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
5330:             ENDIF
5331:         ELSE
5332:             MsgErro("Erro ao carregar conta para exclus" + CHR(227) + "o.", "Erro")
5333:         ENDIF
5334:     ENDPROC
5335: 
5336:     PROCEDURE BtnBuscarClick()
5337:         LOCAL loc_oPg1, loc_cTerm, loc_oBusca
5338:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
5339: 
5340:         *-- Busca por nome/codigo via lookup
5341:         loc_cTerm = ""
5342:         IF PEMSTATUS(loc_oPg1.cnt_4c_Filtros, "txt_4c_Grupo", 5)
5343:             loc_cTerm = ALLTRIM(NVL(loc_oPg1.cnt_4c_Filtros.txt_4c_Grupo.Value, ""))
5344:         ENDIF
5345: 
5346:         TRY
5347:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
5348:                 "SigCdCli", "cursor_4c_Busca", "IClis", loc_cTerm, ;
5349:                 "Busca de Contas", .T., .T., "")
5350:             IF VARTYPE(loc_oBusca) = "O"
5351:                 loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
5352:                 loc_oBusca.mAddColuna("Rclis", "", "Nome")
5353:                 loc_oBusca.mAddColuna("Cpfs", "", "CPF/CNPJ")
5354:                 loc_oBusca.Show()
5355:                 IF loc_oBusca.this_lSelecionou
5356:                     IF USED("cursor_4c_Busca")
5357:                         SELECT cursor_4c_Busca
5358:                         LOCAL loc_cSel
5359:                         loc_cSel = ALLTRIM(NVL(cursor_4c_Busca.IClis, ""))
5360:                         USE IN cursor_4c_Busca
5361:                         IF !EMPTY(loc_cSel) AND PEMSTATUS(loc_oPg1.cnt_4c_Filtros, "txt_4c_Grupo", 5)
5362:                             loc_oPg1.cnt_4c_Filtros.txt_4c_Grupo.Value = loc_cSel
5363:                             THIS.CarregarLista()
5364:                         ENDIF
5365:                     ENDIF
5366:                 ENDIF
5367:             ENDIF
5368:         CATCH TO loException
5369:             MsgErro("Erro na busca:" + CHR(13) + loException.Message, "Erro")
5370:         ENDTRY
5371:     ENDPROC
5372: 
5373:     PROCEDURE BtnEncerrarClick()
5374:         THIS.Release()
5375:     ENDPROC
5376: 
5377:     *===========================================================================
5378:     * Eventos CRUD - Page 2
5379:     *===========================================================================
5380:     PROCEDURE BtnSalvarClick()
5381:         THIS.FormParaBO()
5382:         IF THIS.this_oBusinessObject.Salvar()
5383:             MsgInfo("Conta salva com sucesso.", "Confirmar")
5384:             THIS.AlternarPagina("LISTA")
5385:         ELSE
5386:             LOCAL loc_cMsg
5387:             loc_cMsg = THIS.this_oBusinessObject.this_cMensagemErro
5388:             IF EMPTY(loc_cMsg)
5389:                 loc_cMsg = "Verifique os campos obrigat" + CHR(243) + "rios."
5390:             ENDIF
5391:             MsgAviso(loc_cMsg, "N" + CHR(227) + "o foi poss" + CHR(237) + "vel salvar")
5392:         ENDIF
5393:     ENDPROC
5394: 
5395:     PROCEDURE BtnCancelarClick()
5396:         THIS.AlternarPagina("LISTA")
5397:     ENDPROC
5398: 
5399:     *===========================================================================
5400:     * KeyPress handlers - Filtros
5401:     *===========================================================================
5402:     PROCEDURE TxtGrupoFiltroKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5403:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
5404:             THIS.AbrirLookupGrupoFiltro(.F.)
5405:             RETURN
5406:         ENDIF
5407:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
5408:             THIS.CarregarLista()
5409:         ENDIF
5410:     ENDPROC
5411: 
5412:     PROCEDURE TxtDtIniKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5413:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
5414:             THIS.CarregarLista()
5415:         ENDIF
5416:     ENDPROC
5417: 
5418:     PROCEDURE TxtDtFimKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5419:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
5420:             THIS.CarregarLista()
5421:         ENDIF
5422:     ENDPROC
5423: 
5424:     PROCEDURE TxtGruposKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5425:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
5426:             THIS.AbrirLookupGrupoConta()
5427:             RETURN
5428:         ENDIF
5429:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
5430:             RETURN
5431:         ENDIF
5432:         LOCAL loc_cGrupo, loc_nRet
5433:         loc_cGrupo = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.cnt_4c_Pg1.txt_4c_Grupos.Value, ""))
5434:         IF EMPTY(loc_cGrupo)
5435:             RETURN
5436:         ENDIF
5437:         *-- Validar grupo via lookup SigCdGrc
5438:         LOCAL loc_nRet2
5439:         loc_nRet2 = SQLEXEC(gnConnHandle, ;
5440:             "SELECT TOP 1 codigos, descrs FROM SigCdGrc WHERE codigos = " + ;
5441:             EscaparSQL(PADR(loc_cGrupo, 10)), ;
5442:             "cursor_4c_GrupoValida")
5443:         IF loc_nRet2 > 0 AND RECCOUNT("cursor_4c_GrupoValida") > 0
5444:             SELECT cursor_4c_GrupoValida
5445:             THIS.pgf_4c_Paginas.Page2.cnt_4c_Pg1.txt_4c_Grupos.Value = ALLTRIM(codigos)
5446:             USE IN cursor_4c_GrupoValida
5447:         ELSE
5448:             IF USED("cursor_4c_GrupoValida")
5449:                 USE IN cursor_4c_GrupoValida
5450:             ENDIF
5451:         ENDIF
5452:     ENDPROC
5453: 
5454:     *===========================================================================
5455:     * TxtDGrupoFiltroKeyPress - KeyPress no campo descricao do grupo filtro
5456:     *===========================================================================
5457:     PROCEDURE TxtDGrupoFiltroKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5458:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
5459:             THIS.AbrirLookupGrupoFiltro(.T.)
5460:             RETURN
5461:         ENDIF
5462:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
5463:             THIS.CarregarLista()
5464:         ENDIF
5465:     ENDPROC
5466: 
5467:     *===========================================================================
5468:     * AbrirLookupGrupoFiltro - Abre picker SigCdGcr para filtros (codigo ou descr)
5469:     *===========================================================================
5470:     PROCEDURE AbrirLookupGrupoFiltro(par_lPorDescr)
5471:         LOCAL loc_oFiltros, loc_oLookup, loc_cValorAtual
5472:         LOCAL loc_lResultado
5473:         loc_lResultado = .F.
5474: 
5475:         TRY
5476:             loc_oFiltros = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros
5477: 
5478:             IF par_lPorDescr
5479:                 loc_cValorAtual = ALLTRIM(NVL(loc_oFiltros.txt_4c_DGrupo.Value, ""))
5480:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
5481:                     "SigCdGcr", "cursor_4c_GrupoFiltro", "Descrs", loc_cValorAtual, ;
5482:                     "Grupo de Contas", .F., .T., "")
5483:             ELSE
5484:                 loc_cValorAtual = ALLTRIM(NVL(loc_oFiltros.txt_4c_Grupo.Value, ""))
5485:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
5486:                     "SigCdGcr", "cursor_4c_GrupoFiltro", "Codigos", loc_cValorAtual, ;
5487:                     "Grupo de Contas", .F., .T., "")
5488:             ENDIF
5489: 
5490:             IF VARTYPE(loc_oLookup) = "O"
5491:                 loc_oLookup.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
5492:                 loc_oLookup.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
5493:                 loc_oLookup.Show()
5494: 
5495:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_GrupoFiltro")
5496:                     SELECT cursor_4c_GrupoFiltro
5497:                     loc_oFiltros.txt_4c_Grupo.Value  = ALLTRIM(NVL(cursor_4c_GrupoFiltro.Codigos, ""))
5498:                     loc_oFiltros.txt_4c_DGrupo.Value = ALLTRIM(NVL(cursor_4c_GrupoFiltro.Descrs, ""))
5499:                     USE IN cursor_4c_GrupoFiltro
5500:                     THIS.CarregarLista()
5501:                     loc_lResultado = .T.
5502:                 ELSE
5503:                     IF USED("cursor_4c_GrupoFiltro")
5504:                         USE IN cursor_4c_GrupoFiltro
5505:                     ENDIF
5506:                 ENDIF
5507:                 loc_oLookup.Release()
5508:                 loc_oLookup = .NULL.
5509:             ENDIF
5510: 
5511:         CATCH TO loErr
5512:             IF USED("cursor_4c_GrupoFiltro")
5513:                 USE IN cursor_4c_GrupoFiltro
5514:             ENDIF
5515:             MsgErro("Erro no lookup de Grupo:" + CHR(13) + loErr.Message, "Erro")
5516:         ENDTRY
5517: 
5518:         RETURN loc_lResultado
5519:     ENDPROC
5520: 
5521:     *===========================================================================
5522:     * AbrirLookupGrupoConta - Abre picker SigCdGcr p/ campo Grupos da sub-pag1
5523:     *===========================================================================
5524:     PROCEDURE AbrirLookupGrupoConta()
5525:         LOCAL loc_oPg1Cnt, loc_oLookup, loc_cValorAtual
5526:         LOCAL loc_lResultado
5527:         loc_lResultado = .F.
5528: 
5529:         TRY
5530:             loc_oPg1Cnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Pg1
5531:             loc_cValorAtual = ALLTRIM(NVL(loc_oPg1Cnt.txt_4c_Grupos.Value, ""))
5532: 
5533:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
5534:                 "SigCdGcr", "cursor_4c_GrupoContaLkp", "Codigos", loc_cValorAtual, ;
5535:                 "Grupo de Contas", .F., .T., "")
5536: 
5537:             IF VARTYPE(loc_oLookup) = "O"
5538:                 loc_oLookup.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
5539:                 loc_oLookup.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
5540:                 loc_oLookup.Show()
5541: 
5542:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_GrupoContaLkp")
5543:                     SELECT cursor_4c_GrupoContaLkp
5544:                     loc_oPg1Cnt.txt_4c_Grupos.Value = ALLTRIM(NVL(cursor_4c_GrupoContaLkp.Codigos, ""))
5545:                     USE IN cursor_4c_GrupoContaLkp
5546:                     loc_lResultado = .T.
5547:                 ELSE
5548:                     IF USED("cursor_4c_GrupoContaLkp")
5549:                         USE IN cursor_4c_GrupoContaLkp
5550:                     ENDIF
5551:                 ENDIF
5552:                 loc_oLookup.Release()
5553:                 loc_oLookup = .NULL.
5554:             ENDIF
5555: 
5556:         CATCH TO loErr
5557:             IF USED("cursor_4c_GrupoContaLkp")
5558:                 USE IN cursor_4c_GrupoContaLkp
5559:             ENDIF
5560:             MsgErro("Erro no lookup de Grupo:" + CHR(13) + loErr.Message, "Erro")
5561:         ENDTRY
5562: 
5563:         RETURN loc_lResultado
5564:     ENDPROC
5565: 
5566:     *===========================================================================
5567:     * LookupTaxGrupo - Abre picker SigCdGcr para getCdGrupos das celulas fiscais
5568:     * par_cTrib = sufixo 2 letras (IC, IP, II, IS, IR, IN, PI, CS, CO)
5569:     *===========================================================================
5570:     PROCEDURE LookupTaxGrupo(par_cTrib)
5571:         LOCAL loc_oPg9, loc_oGru, loc_oCd, loc_oDs, loc_oLookup, loc_i
5572:         LOCAL loc_lResultado
5573:         loc_lResultado = .F.
5574: 
5575:         TRY
5576:             loc_oPg9 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Pg9
5577:             loc_oGru = .NULL.
5578:             loc_oCd  = .NULL.
5579:             loc_oDs  = .NULL.
5580: 
5581:             FOR loc_i = 1 TO loc_oPg9.ControlCount
5582:                 LOCAL loc_oC
5583:                 loc_oC = loc_oPg9.Controls(loc_i)
5584:                 DO CASE
5585:                 CASE UPPER(loc_oC.Name) = UPPER("txt_4c_Gru" + par_cTrib)
5586:                     loc_oGru = loc_oC
5587:                 CASE UPPER(loc_oC.Name) = UPPER("txt_4c_Cd" + par_cTrib)
5588:                     loc_oCd = loc_oC
5589:                 CASE UPPER(loc_oC.Name) = UPPER("txt_4c_Ds" + par_cTrib)
5590:                     loc_oDs = loc_oC
5591:                 ENDCASE
5592:             ENDFOR
5593: 
5594:             IF VARTYPE(loc_oGru) != "O"
5595:                 loc_lResultado = .F.
5596:             ENDIF
5597: 
5598:             LOCAL loc_cValor
5599:             loc_cValor = ALLTRIM(NVL(loc_oGru.Value, ""))
5600: 
5601:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
5602:                 "SigCdGcr", "cursor_4c_TaxGruLkp", "Codigos", loc_cValor, ;
5603:                 "Grupo Cont" + CHR(225) + "bil - " + par_cTrib, .F., .T., "")
5604: 
5605:             IF VARTYPE(loc_oLookup) = "O"
5606:                 loc_oLookup.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
5607:                 loc_oLookup.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
5608:                 loc_oLookup.Show()
5609: 
5610:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_TaxGruLkp")
5611:                     SELECT cursor_4c_TaxGruLkp
5612:                     LOCAL loc_cGruSel
5613:                     loc_cGruSel = ALLTRIM(NVL(cursor_4c_TaxGruLkp.Codigos, ""))
5614:                     USE IN cursor_4c_TaxGruLkp
5615:                     loc_oGru.Value = loc_cGruSel
5616:                     IF VARTYPE(loc_oCd) = "O"
5617:                         loc_oCd.Value = ""
5618:                     ENDIF
5619:                     IF VARTYPE(loc_oDs) = "O"
5620:                         loc_oDs.Value = ""
5621:                     ENDIF
5622:                     loc_lResultado = .T.
5623:                 ELSE
5624:                     IF USED("cursor_4c_TaxGruLkp")
5625:                         USE IN cursor_4c_TaxGruLkp
5626:                     ENDIF
5627:                 ENDIF
5628:                 loc_oLookup.Release()
5629:                 loc_oLookup = .NULL.
5630:             ENDIF
5631: 
5632:         CATCH TO loErr
5633:             IF USED("cursor_4c_TaxGruLkp")
5634:                 USE IN cursor_4c_TaxGruLkp
5635:             ENDIF
5636:             MsgErro("Erro no lookup de Grupo Cont" + CHR(225) + "bil:" + CHR(13) + ;
5637:                 loErr.Message, "Erro")
5638:         ENDTRY
5639: 
5640:         RETURN loc_lResultado
5641:     ENDPROC
5642: 
5643:     *===========================================================================
5644:     * LookupTaxConta - Abre picker SigCdCli (filtrado por grupo) para contas fiscais
5645:     * par_lPorDescr: .F.=busca por codigo, .T.=busca por descricao
5646:     *===========================================================================
5647:     PROCEDURE LookupTaxConta(par_cTrib, par_lPorDescr)
5648:         LOCAL loc_oPg9, loc_oGru, loc_oCd, loc_oDs, loc_oLookup, loc_i
5649:         LOCAL loc_lResultado, loc_cSQL, loc_cGrupo, loc_cValor, loc_nRet
5650:         loc_lResultado = .F.
5651: 
5652:         TRY
5653:             loc_oPg9 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Pg9
5654:             loc_oGru = .NULL.
5655:             loc_oCd  = .NULL.
5656:             loc_oDs  = .NULL.
5657: 
5658:             FOR loc_i = 1 TO loc_oPg9.ControlCount
5659:                 LOCAL loc_oC2
5660:                 loc_oC2 = loc_oPg9.Controls(loc_i)
5661:                 DO CASE
5662:                 CASE UPPER(loc_oC2.Name) = UPPER("txt_4c_Gru" + par_cTrib)
5663:                     loc_oGru = loc_oC2
5664:                 CASE UPPER(loc_oC2.Name) = UPPER("txt_4c_Cd" + par_cTrib)
5665:                     loc_oCd = loc_oC2
5666:                 CASE UPPER(loc_oC2.Name) = UPPER("txt_4c_Ds" + par_cTrib)
5667:                     loc_oDs = loc_oC2
5668:                 ENDCASE
5669:             ENDFOR
5670: 
5671:             IF VARTYPE(loc_oGru) != "O" OR VARTYPE(loc_oCd) != "O"
5672:                 loc_lResultado = .F.
5673:             ENDIF
5674: 
5675:             loc_cGrupo = ALLTRIM(NVL(loc_oGru.Value, ""))
5676:             IF EMPTY(loc_cGrupo)
5677:                 MsgAviso("Informe primeiro o Grupo Cont" + CHR(225) + "bil.", "Conta")
5678:                 loc_lResultado = .F.
5679:             ENDIF
5680: 
5681:             IF par_lPorDescr
5682:                 loc_cValor = ALLTRIM(NVL(loc_oDs.Value, ""))
5683:             ELSE
5684:                 loc_cValor = ALLTRIM(NVL(loc_oCd.Value, ""))
5685:             ENDIF
5686: 
5687:             LOCAL loc_cFiltroGrupo
5688:             loc_cFiltroGrupo = "Grupos = " + EscaparSQL(PADR(loc_cGrupo, 10))
5689: 
5690:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
5691:                 "SigCdCli", "cursor_4c_TaxContaLkp", "IClis", loc_cValor, ;
5692:                 "Conta - " + par_cTrib + " (Grupo: " + ALLTRIM(loc_cGrupo) + ")", ;
5693:                 .F., .T., loc_cFiltroGrupo)
5694: 
5695:             IF VARTYPE(loc_oLookup) = "O"
5696:                 loc_oLookup.mAddColuna("IClis",  "", "C" + CHR(243) + "digo")
5697:                 loc_oLookup.mAddColuna("Rclis",  "", "Nome")
5698:                 loc_oLookup.Show()
5699: 
5700:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_TaxContaLkp")
5701:                     SELECT cursor_4c_TaxContaLkp
5702:                     loc_oCd.Value = ALLTRIM(NVL(cursor_4c_TaxContaLkp.IClis, ""))
5703:                     IF VARTYPE(loc_oDs) = "O"
5704:                         loc_oDs.Value = ALLTRIM(NVL(cursor_4c_TaxContaLkp.Rclis, ""))
5705:                     ENDIF
5706:                     USE IN cursor_4c_TaxContaLkp
5707:                     loc_lResultado = .T.
5708:                 ELSE
5709:                     IF USED("cursor_4c_TaxContaLkp")
5710:                         USE IN cursor_4c_TaxContaLkp
5711:                     ENDIF
5712:                 ENDIF
5713:                 loc_oLookup.Release()
5714:                 loc_oLookup = .NULL.
5715:             ENDIF
5716: 
5717:         CATCH TO loErr
5718:             IF USED("cursor_4c_TaxContaLkp")
5719:                 USE IN cursor_4c_TaxContaLkp
5720:             ENDIF
5721:             IF USED("cursor_4c_TaxContaLkp2")
5722:                 USE IN cursor_4c_TaxContaLkp2
5723:             ENDIF
5724:             MsgErro("Erro no lookup de Conta:" + CHR(13) + loErr.Message, "Erro")
5725:         ENDTRY
5726: 
5727:         RETURN loc_lResultado
5728:     ENDPROC
5729: 
5730:     *===========================================================================
5731:     * MontarCfgFis - Monta a string composta CfgFisXXs a partir de campos individuais
5732:     * Formato: PADR(Gru,10)+PADR(Cd,10)+PADR(Ds,10)+TRANSFORM(Pct,"99.9")+Rec+Tip+Fin
5733:     *===========================================================================
5734:     PROTECTED PROCEDURE MontarCfgFis(par_oPg9, par_cSfx)
5735:         LOCAL loc_cGru, loc_cCd, loc_cDs, loc_nPct, loc_cRec, loc_nTip, loc_nFin
5736:         loc_cGru = ""
5737:         loc_cCd  = ""
5738:         loc_cDs  = ""
5739:         loc_nPct = 0
5740:         loc_cRec = ""
5741:         loc_nTip = 0
5742:         loc_nFin = 0
5743: 
5744:         LOCAL loc_oGru2, loc_oCd2, loc_oDs2, loc_oPct2, loc_oRec2, loc_oTip2, loc_oFin2
5745:         loc_oGru2 = THIS.LocalizarControle(par_oPg9, "txt_4c_Gru" + par_cSfx)
5746:         IF VARTYPE(loc_oGru2) = "O"
5747:             loc_cGru = ALLTRIM(NVL(loc_oGru2.Value, ""))
5748:         ENDIF
5749:         loc_oCd2  = THIS.LocalizarControle(par_oPg9, "txt_4c_Cd"  + par_cSfx)
5750:         loc_oDs2  = THIS.LocalizarControle(par_oPg9, "txt_4c_Ds"  + par_cSfx)
5751:         loc_oPct2 = THIS.LocalizarControle(par_oPg9, "txt_4c_Pct" + par_cSfx)
5752:         loc_oRec2 = THIS.LocalizarControle(par_oPg9, "txt_4c_Rec" + par_cSfx)
5753:         loc_oTip2 = THIS.LocalizarControle(par_oPg9, "chk_4c_Tip" + par_cSfx)
5754:         loc_oFin2 = THIS.LocalizarControle(par_oPg9, "chk_4c_Fin" + par_cSfx)
5755: 
5756:         IF VARTYPE(loc_oCd2)  = "O"
5757:             loc_cCd  = ALLTRIM(NVL(loc_oCd2.Value, ""))
5758:         ENDIF
5759:         IF VARTYPE(loc_oDs2)  = "O"
5760:             loc_cDs  = ALLTRIM(NVL(loc_oDs2.Value, ""))
5761:         ENDIF
5762:         IF VARTYPE(loc_oPct2) = "O"
5763:             loc_nPct = NVL(loc_oPct2.Value, 0)
5764:         ENDIF
5765:         IF VARTYPE(loc_oRec2) = "O"
5766:             loc_cRec = ALLTRIM(NVL(loc_oRec2.Value, ""))
5767:         ENDIF
5768:         IF VARTYPE(loc_oTip2) = "O"
5769:             loc_nTip = IIF(loc_oTip2.Value = 1, 1, 0)
5770:         ENDIF
5771:         IF VARTYPE(loc_oFin2) = "O"
5772:             loc_nFin = IIF(loc_oFin2.Value = 1, 1, 0)
5773:         ENDIF
5774: 

*-- Linhas 5781 a 5824:
5781:     *===========================================================================
5782:     * ParsearCfgFis - Parseia a string CfgFisXXs e preenche os campos individuais
5783:     *===========================================================================
5784:     PROTECTED PROCEDURE ParsearCfgFis(par_oPg9, par_cSfx, par_cStr)
5785:         LOCAL loc_cStr, loc_cGru, loc_cCd, loc_cDs, loc_nPct, loc_cRec, loc_nTip, loc_nFin
5786:         loc_cStr = NVL(par_cStr, "")
5787:         loc_cGru = ALLTRIM(SUBSTR(loc_cStr + SPACE(37), 1,  10))
5788:         loc_cCd  = ALLTRIM(SUBSTR(loc_cStr + SPACE(37), 11, 10))
5789:         loc_cDs  = ALLTRIM(SUBSTR(loc_cStr + SPACE(37), 21, 10))
5790:         loc_nPct = VAL(SUBSTR(loc_cStr + SPACE(37), 31,  4))
5791:         loc_cRec = SUBSTR(loc_cStr + SPACE(37), 36, 1)
5792:         loc_nTip = VAL(SUBSTR(loc_cStr + SPACE(37), 37, 1))
5793: 
5794:         LOCAL loc_cExtended, loc_nFin2
5795:         loc_cExtended = loc_cStr + SPACE(38)
5796:         loc_nFin2 = VAL(SUBSTR(loc_cExtended, 38, 1))
5797: 
5798:         LOCAL loc_oGru, loc_oCd, loc_oDs, loc_oPct, loc_oRec, loc_oTip, loc_oFin
5799:         loc_oGru = THIS.LocalizarControle(par_oPg9, "txt_4c_Gru" + par_cSfx)
5800:         loc_oCd  = THIS.LocalizarControle(par_oPg9, "txt_4c_Cd"  + par_cSfx)
5801:         loc_oDs  = THIS.LocalizarControle(par_oPg9, "txt_4c_Ds"  + par_cSfx)
5802:         loc_oPct = THIS.LocalizarControle(par_oPg9, "txt_4c_Pct" + par_cSfx)
5803:         loc_oRec = THIS.LocalizarControle(par_oPg9, "txt_4c_Rec" + par_cSfx)
5804:         loc_oTip = THIS.LocalizarControle(par_oPg9, "chk_4c_Tip" + par_cSfx)
5805:         loc_oFin = THIS.LocalizarControle(par_oPg9, "chk_4c_Fin" + par_cSfx)
5806: 
5807:         IF VARTYPE(loc_oGru) = "O"
5808:             loc_oGru.Value = loc_cGru
5809:         ENDIF
5810:         IF VARTYPE(loc_oCd)  = "O"
5811:             loc_oCd.Value  = loc_cCd
5812:         ENDIF
5813:         IF VARTYPE(loc_oDs)  = "O"
5814:             loc_oDs.Value  = loc_cDs
5815:         ENDIF
5816:         IF VARTYPE(loc_oPct) = "O"
5817:             loc_oPct.Value = loc_nPct
5818:         ENDIF
5819:         IF VARTYPE(loc_oRec) = "O"
5820:             loc_oRec.Value = loc_cRec
5821:         ENDIF
5822:         IF VARTYPE(loc_oTip) = "O"
5823:             loc_oTip.Value = loc_nTip
5824:         ENDIF

*-- Linhas 5830 a 6072:
5830:     *===========================================================================
5831:     * LocalizarControle - Localiza controle por nome em um container
5832:     *===========================================================================
5833:     PROTECTED PROCEDURE LocalizarControle(par_oContainer, par_cNome)
5834:         LOCAL loc_i, loc_oCtrl
5835:         IF VARTYPE(par_oContainer) != "O"
5836:             RETURN .NULL.
5837:         ENDIF
5838:         FOR loc_i = 1 TO par_oContainer.ControlCount
5839:             loc_oCtrl = par_oContainer.Controls(loc_i)
5840:             IF UPPER(loc_oCtrl.Name) = UPPER(par_cNome)
5841:                 RETURN loc_oCtrl
5842:             ENDIF
5843:         ENDFOR
5844:         RETURN .NULL.
5845:     ENDPROC
5846: 
5847:     *===========================================================================
5848:     * KeyPress handlers para campos getCdGrupos dos 9 tributos fiscais
5849:     *===========================================================================
5850:     PROCEDURE TxtGruICKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5851:         IF par_nKeyCode = 115
5852:             THIS.LookupTaxGrupo("IC")
5853:         ENDIF
5854:     ENDPROC
5855: 
5856:     PROCEDURE TxtGruIPKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5857:         IF par_nKeyCode = 115
5858:             THIS.LookupTaxGrupo("IP")
5859:         ENDIF
5860:     ENDPROC
5861: 
5862:     PROCEDURE TxtGruIIKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5863:         IF par_nKeyCode = 115
5864:             THIS.LookupTaxGrupo("II")
5865:         ENDIF
5866:     ENDPROC
5867: 
5868:     PROCEDURE TxtGruISKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5869:         IF par_nKeyCode = 115
5870:             THIS.LookupTaxGrupo("IS")
5871:         ENDIF
5872:     ENDPROC
5873: 
5874:     PROCEDURE TxtGruIRKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5875:         IF par_nKeyCode = 115
5876:             THIS.LookupTaxGrupo("IR")
5877:         ENDIF
5878:     ENDPROC
5879: 
5880:     PROCEDURE TxtGruINKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5881:         IF par_nKeyCode = 115
5882:             THIS.LookupTaxGrupo("IN")
5883:         ENDIF
5884:     ENDPROC
5885: 
5886:     PROCEDURE TxtGruPIKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5887:         IF par_nKeyCode = 115
5888:             THIS.LookupTaxGrupo("PI")
5889:         ENDIF
5890:     ENDPROC
5891: 
5892:     PROCEDURE TxtGruCSKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5893:         IF par_nKeyCode = 115
5894:             THIS.LookupTaxGrupo("CS")
5895:         ENDIF
5896:     ENDPROC
5897: 
5898:     PROCEDURE TxtGruCOKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5899:         IF par_nKeyCode = 115
5900:             THIS.LookupTaxGrupo("CO")
5901:         ENDIF
5902:     ENDPROC
5903: 
5904:     *===========================================================================
5905:     * KeyPress handlers para campos getCdContas dos 9 tributos fiscais
5906:     *===========================================================================
5907:     PROCEDURE TxtCdICKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5908:         IF par_nKeyCode = 115
5909:             THIS.LookupTaxConta("IC", .F.)
5910:         ENDIF
5911:     ENDPROC
5912: 
5913:     PROCEDURE TxtCdIPKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5914:         IF par_nKeyCode = 115
5915:             THIS.LookupTaxConta("IP", .F.)
5916:         ENDIF
5917:     ENDPROC
5918: 
5919:     PROCEDURE TxtCdIIKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5920:         IF par_nKeyCode = 115
5921:             THIS.LookupTaxConta("II", .F.)
5922:         ENDIF
5923:     ENDPROC
5924: 
5925:     PROCEDURE TxtCdISKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5926:         IF par_nKeyCode = 115
5927:             THIS.LookupTaxConta("IS", .F.)
5928:         ENDIF
5929:     ENDPROC
5930: 
5931:     PROCEDURE TxtCdIRKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5932:         IF par_nKeyCode = 115
5933:             THIS.LookupTaxConta("IR", .F.)
5934:         ENDIF
5935:     ENDPROC
5936: 
5937:     PROCEDURE TxtCdINKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5938:         IF par_nKeyCode = 115
5939:             THIS.LookupTaxConta("IN", .F.)
5940:         ENDIF
5941:     ENDPROC
5942: 
5943:     PROCEDURE TxtCdPIKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5944:         IF par_nKeyCode = 115
5945:             THIS.LookupTaxConta("PI", .F.)
5946:         ENDIF
5947:     ENDPROC
5948: 
5949:     PROCEDURE TxtCdCSKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5950:         IF par_nKeyCode = 115
5951:             THIS.LookupTaxConta("CS", .F.)
5952:         ENDIF
5953:     ENDPROC
5954: 
5955:     PROCEDURE TxtCdCOKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5956:         IF par_nKeyCode = 115
5957:             THIS.LookupTaxConta("CO", .F.)
5958:         ENDIF
5959:     ENDPROC
5960: 
5961:     *===========================================================================
5962:     * KeyPress handlers para campos getDsContas dos 9 tributos fiscais
5963:     *===========================================================================
5964:     PROCEDURE TxtDsICKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5965:         IF par_nKeyCode = 115
5966:             THIS.LookupTaxConta("IC", .T.)
5967:         ENDIF
5968:     ENDPROC
5969: 
5970:     PROCEDURE TxtDsIPKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5971:         IF par_nKeyCode = 115
5972:             THIS.LookupTaxConta("IP", .T.)
5973:         ENDIF
5974:     ENDPROC
5975: 
5976:     PROCEDURE TxtDsIIKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5977:         IF par_nKeyCode = 115
5978:             THIS.LookupTaxConta("II", .T.)
5979:         ENDIF
5980:     ENDPROC
5981: 
5982:     PROCEDURE TxtDsISKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5983:         IF par_nKeyCode = 115
5984:             THIS.LookupTaxConta("IS", .T.)
5985:         ENDIF
5986:     ENDPROC
5987: 
5988:     PROCEDURE TxtDsIRKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5989:         IF par_nKeyCode = 115
5990:             THIS.LookupTaxConta("IR", .T.)
5991:         ENDIF
5992:     ENDPROC
5993: 
5994:     PROCEDURE TxtDsINKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5995:         IF par_nKeyCode = 115
5996:             THIS.LookupTaxConta("IN", .T.)
5997:         ENDIF
5998:     ENDPROC
5999: 
6000:     PROCEDURE TxtDsPIKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6001:         IF par_nKeyCode = 115
6002:             THIS.LookupTaxConta("PI", .T.)
6003:         ENDIF
6004:     ENDPROC
6005: 
6006:     PROCEDURE TxtDsCSKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6007:         IF par_nKeyCode = 115
6008:             THIS.LookupTaxConta("CS", .T.)
6009:         ENDIF
6010:     ENDPROC
6011: 
6012:     PROCEDURE TxtDsCOKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6013:         IF par_nKeyCode = 115
6014:             THIS.LookupTaxConta("CO", .T.)
6015:         ENDIF
6016:     ENDPROC
6017: 
6018:     *===========================================================================
6019:     * TornarControlesVisiveis - Torna controles do container visiveis
6020:     *===========================================================================
6021:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
6022:         LOCAL loc_i, loc_oControl
6023:         IF VARTYPE(par_oContainer) != "O"
6024:             RETURN
6025:         ENDIF
6026:         FOR loc_i = 1 TO par_oContainer.ControlCount
6027:             loc_oControl = par_oContainer.Controls(loc_i)
6028:             IF INLIST(UPPER(loc_oControl.Name), ;
6029:                 "CNT_4C_CABECALHO", "CNT_4C_PG2", "CNT_4C_PG3", "CNT_4C_PG4", ;
6030:                 "CNT_4C_PG5", "CNT_4C_PG6", "CNT_4C_PG7", "CNT_4C_PG8", ;
6031:                 "CNT_4C_PG9", "CNT_4C_PG10", "CNT_4C_PG11", "CNT_4C_PG12")
6032:                 LOOP
6033:             ENDIF
6034:             loc_oControl.Visible = .T.
6035:             IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
6036:                 THIS.TornarControlesVisiveis(loc_oControl)
6037:             ENDIF
6038:         ENDFOR
6039:     ENDPROC
6040: 
6041:     *===========================================================================
6042:     * Destroy - Libera recursos
6043:     *===========================================================================
6044:     PROCEDURE Destroy()
6045:         IF USED("cursor_4c_Dados")
6046:             USE IN cursor_4c_Dados
6047:         ENDIF
6048:         IF USED("cursor_4c_Busca")
6049:             USE IN cursor_4c_Busca
6050:         ENDIF
6051:         IF USED("cursor_4c_GrupoValida")
6052:             USE IN cursor_4c_GrupoValida
6053:         ENDIF
6054:         IF USED("cursor_4c_GrupoFiltro")
6055:             USE IN cursor_4c_GrupoFiltro
6056:         ENDIF
6057:         IF USED("cursor_4c_GrupoContaLkp")
6058:             USE IN cursor_4c_GrupoContaLkp
6059:         ENDIF
6060:         IF USED("cursor_4c_TaxGruLkp")
6061:             USE IN cursor_4c_TaxGruLkp
6062:         ENDIF
6063:         IF USED("cursor_4c_TaxContaLkp")
6064:             USE IN cursor_4c_TaxContaLkp
6065:         ENDIF
6066:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
6067:             THIS.this_oBusinessObject = .NULL.
6068:         ENDIF
6069:         DODEFAULT()
6070:     ENDPROC
6071: 
6072: ENDDEFINE

