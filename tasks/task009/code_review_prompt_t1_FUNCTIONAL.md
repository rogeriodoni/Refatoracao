# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (5)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_FILTROS. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Dados' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [GRID-WITH] Bloco WITH ENDPROC define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: ENDPROC.RecordSource).
- [GRID-HEADER] Header Caption ' ' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Data, Conta, Contrapartida, Histórico, Débito, Crédito, , NF, Documento, O. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption ' ' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Data, Conta, Contrapartida, Histórico, Débito, Crédito, , NF, Documento, O. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigmvccr.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2655 linhas total):

*-- Linhas 31 a 87:
31:     *--------------------------------------------------------------------------
32:     * Init - Inicializacao do formulario
33:     *--------------------------------------------------------------------------
34:     PROCEDURE Init()
35:         *-- DODEFAULT() ja chama InicializarForm() atraves do FormBase.Init()
36:         RETURN DODEFAULT()
37:     ENDPROC
38: 
39:     *--------------------------------------------------------------------------
40:     * InicializarForm - Configuracao inicial do formulario
41:     *--------------------------------------------------------------------------
42:     PROTECTED PROCEDURE InicializarForm()
43:         LOCAL loc_lSucesso
44:         loc_lSucesso = .F.
45: 
46:         TRY
47:             THIS.this_oBusinessObject = CREATEOBJECT("sigmvccrBO")
48: 
49:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
50:                 MostrarErro("Erro ao criar sigmvccrBO", "Erro Cr" + CHR(237) + "tico")
51:             ELSE
52:                 *-- Cursor placeholder para grid (evita erros antes do primeiro load)
53:                 IF !USED("cursor_4c_Dados")
54:                     CREATE CURSOR cursor_4c_Dados ;
55:                         (cidchaves C(20), nopers N(10,0), opers C(1), ;
56:                          datas T, contas C(10), scontas C(10), ;
57:                          hists C(50), hist2s C(50), valors N(15,2), ;
58:                          svalors N(15,2), nfs C(15), docus C(20), ;
59:                          grupos C(10), sgrupos C(10), moedas C(3), ;
60:                          smoedas C(3), concs L, emps C(3), ;
61:                          vencs T, cotacaos N(15,7), scotacaos N(15,7), ;
62:                          contapgs N(1,0), jobs C(10), dtemis T, ;
63:                          sopers C(1), tipos C(1))
64:                 ENDIF
65: 
66:                 THIS.ConfigurarPageFrame()
67:                 THIS.ConfigurarPaginaLista()
68:                 THIS.ConfigurarPaginaDados()
69:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
70: 
71:                 *-- Data inicial = hoje
72:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.cnt_4c_Periodo.txt_4c_Dt_inicial.Value = DATE()
73:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.cnt_4c_Periodo.txt_4c_Dt_final.Value   = DATE()
74: 
75:                 IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
76:                     THIS.CarregarLista()
77:                 ENDIF
78: 
79:                 THIS.pgf_4c_Paginas.Visible   = .T.
80:                 THIS.pgf_4c_Paginas.ActivePage = 1
81:                 THIS.this_cModoAtual = "LISTA"
82:                 loc_lSucesso = .T.
83:             ENDIF
84: 
85:         CATCH TO loException
86:             MostrarErro("Erro ao inicializar Formsigmvccr:" + CHR(13) + ;
87:                         "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;

*-- Linhas 95 a 165:
95:     * ConfigurarPageFrame - Cria e configura PageFrame principal
96:     * Legado: Pagina.Width=1003, Top=-29 para ocultar abas
97:     *--------------------------------------------------------------------------
98:     PROTECTED PROCEDURE ConfigurarPageFrame()
99:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
100: 
101:         WITH THIS.pgf_4c_Paginas
102:             .Top       = -29
103:             .Left      = 0
104:             .Width     = 1003
105:             .Height    = 600
106:             .PageCount = 2
107:             .Tabs      = .F.
108:             .Visible   = .T.
109: 
110:             .Page1.Caption  = "Lista"
111:             .Page1.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
112:             .Page1.BackColor = RGB(255, 255, 255)
113: 
114:             .Page2.Caption  = "Dados"
115:             .Page2.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
116:             .Page2.BackColor = RGB(255, 255, 255)
117:         ENDWITH
118:     ENDPROC
119: 
120:     *--------------------------------------------------------------------------
121:     * ConfigurarPaginaLista - Configura Page1 (lista com grid e filtros)
122:     * Compensacao +29 aplicada a todos os controles
123:     * Grid: Top=115+29=144, Left=23, Width=944, Height=473
124:     *--------------------------------------------------------------------------
125:     PROTECTED PROCEDURE ConfigurarPaginaLista()
126:         LOCAL loc_oPagina, loc_oGrade
127:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
128: 
129:         *-- Cabecalho (cntSombra: Top=1+29=30)
130:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
131:         WITH loc_oPagina.cnt_4c_Cabecalho
132:             .Top         = 30
133:             .Left        = -1
134:             .Width       = 1100
135:             .Height      = 80
136:             .BackStyle   = 1
137:             .BackColor   = RGB(53, 53, 53)
138:             .BorderWidth = 0
139:             .Visible     = .T.
140:         ENDWITH
141:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
142:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
143:             .Caption   = "Conta Corrente Geral"
144:             .Top       = 20
145:             .Left      = 20
146:             .Width     = 400
147:             .Height    = 30
148:             .FontName  = "Tahoma"
149:             .FontSize  = 14
150:             .FontBold  = .T.
151:             .BackStyle = 0
152:             .ForeColor = RGB(255, 255, 255)
153:             .Visible   = .T.
154:         ENDWITH
155: 
156:         *-- Botoes CRUD (Grupo_op: Left=467, Top=-1+29=28)
157:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
158:         WITH loc_oPagina.cnt_4c_Botoes
159:             .Top         = 28
160:             .Left        = 467
161:             .Width       = 385
162:             .Height      = 85
163:             .BackStyle = 1
164:             .BackColor = RGB(53, 53, 53)
165:             .BorderWidth = 0

*-- Linhas 183 a 367:
183:             .ForeColor       = RGB(90, 90, 90)
184:             .Visible         = .T.
185:         ENDWITH
186:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
187: 
188:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
189:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
190:             .Caption         = "Visualizar"
191:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
192:             .PicturePosition = 13
193:             .Width           = 75
194:             .Height          = 75
195:             .Left            = 80
196:             .Top             = 5
197:             .FontName        = "Comic Sans MS"
198:             .FontSize        = 8
199:             .Themes          = .F.
200:             .SpecialEffect   = 0
201:             .BackColor       = RGB(255, 255, 255)
202:             .ForeColor       = RGB(90, 90, 90)
203:             .Visible         = .T.
204:         ENDWITH
205:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
206: 
207:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
208:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
209:             .Caption         = "Alterar"
210:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
211:             .PicturePosition = 13
212:             .Width           = 75
213:             .Height          = 75
214:             .Left            = 155
215:             .Top             = 5
216:             .FontName        = "Comic Sans MS"
217:             .FontSize        = 8
218:             .Themes          = .F.
219:             .SpecialEffect   = 0
220:             .BackColor       = RGB(255, 255, 255)
221:             .ForeColor       = RGB(90, 90, 90)
222:             .Visible         = .T.
223:         ENDWITH
224:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
225: 
226:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
227:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
228:             .Caption         = "Excluir"
229:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
230:             .PicturePosition = 13
231:             .Width           = 75
232:             .Height          = 75
233:             .Left            = 230
234:             .Top             = 5
235:             .FontName        = "Comic Sans MS"
236:             .FontSize        = 8
237:             .Themes          = .F.
238:             .SpecialEffect   = 0
239:             .BackColor       = RGB(255, 255, 255)
240:             .ForeColor       = RGB(90, 90, 90)
241:             .Visible         = .T.
242:         ENDWITH
243:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
244: 
245:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
246:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
247:             .Caption         = "Buscar"
248:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
249:             .PicturePosition = 13
250:             .Width           = 75
251:             .Height          = 75
252:             .Left            = 305
253:             .Top             = 5
254:             .FontName        = "Comic Sans MS"
255:             .FontSize        = 8
256:             .Themes          = .F.
257:             .SpecialEffect   = 0
258:             .BackColor       = RGB(255, 255, 255)
259:             .ForeColor       = RGB(90, 90, 90)
260:             .Visible         = .T.
261:         ENDWITH
262:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
263: 
264:         *-- Botao Sair (Grupo_Saida: Left=917, Top=-1+29=28)
265:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
266:         WITH loc_oPagina.cnt_4c_Saida
267:             .Top         = 28
268:             .Left        = 917
269:             .Width       = 85
270:             .Height      = 85
271:             .BackStyle = 1
272:             .BackColor = RGB(53, 53, 53)
273:             .BorderWidth = 0
274:             .Visible     = .T.
275:         ENDWITH
276:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
277:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
278:             .Caption         = "Encerrar"
279:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
280:             .PicturePosition = 13
281:             .Width           = 75
282:             .Height          = 75
283:             .Left            = 5
284:             .Top             = 5
285:             .FontName        = "Comic Sans MS"
286:             .FontSize        = 8
287:             .Themes          = .F.
288:             .SpecialEffect   = 0
289:             .BackColor       = RGB(255, 255, 255)
290:             .ForeColor       = RGB(90, 90, 90)
291:             .Visible         = .T.
292:         ENDWITH
293:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
294: 
295:         *-- Botao Movimento/Anexa (Anexa: Left=847, Top=4+29=33)
296:         loc_oPagina.AddObject("shp_4c_ShpAnexa", "Shape")
297:         WITH loc_oPagina.shp_4c_ShpAnexa
298:             .Top         = 36
299:             .Left        = 760
300:             .Width       = 55
301:             .Height      = 6
302:             .BackStyle   = 0
303:             .BorderStyle = 0
304:             .BorderColor = RGB(136, 189, 188)
305:             .Visible     = .F.
306:         ENDWITH
307: 
308:         loc_oPagina.AddObject("cmd_4c_Anexa", "CommandButton")
309:         WITH loc_oPagina.cmd_4c_Anexa
310:             .Caption         = "Movimento"
311:             .Top             = 33
312:             .Left            = 847
313:             .Width           = 75
314:             .Height          = 75
315:             .FontBold        = .T.
316:             .FontItalic      = .T.
317:             .FontName        = "Comic Sans MS"
318:             .FontSize        = 8
319:             .Picture         = gc_4c_CaminhoIcones + "geral_arquivo_60.jpg"
320:             .PicturePosition = 13
321:             .BackColor       = RGB(255, 255, 255)
322:             .ForeColor       = RGB(90, 90, 90)
323:             .ToolTipText     = "[F7] Documento"
324:             .Themes          = .F.
325:             .Visible         = .F.
326:         ENDWITH
327:         BINDEVENT(loc_oPagina.cmd_4c_Anexa, "Click", THIS, "BtnAnexaClick")
328: 
329:         *-- Filtro de periodo (cntFiltros: Top=83+29=112, Left=5, Width=642, Height=29)
330:         loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
331:         WITH loc_oPagina.cnt_4c_Filtros
332:             .Top         = 112
333:             .Left        = 5
334:             .Width       = 642
335:             .Height      = 29
336:             .BackStyle   = 0
337:             .BorderWidth = 0
338:             .BorderColor = RGB(90, 90, 90)
339:             .Visible     = .T.
340:         ENDWITH
341: 
342:         *-- Sub-container Cnt_periodo (Top=-3 relativo ao cntFiltros, Left=14)
343:         loc_oPagina.cnt_4c_Filtros.AddObject("cnt_4c_Periodo", "Container")
344:         WITH loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo
345:             .Top         = -3
346:             .Left        = 14
347:             .Width       = 271
348:             .Height      = 36
349:             .BackStyle   = 0
350:             .BorderWidth = 0
351:             .Visible     = .T.
352:         ENDWITH
353: 
354:         loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.AddObject("lbl_4c_LblPeriodo", "Label")
355:         WITH loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.lbl_4c_LblPeriodo
356:             .Caption   = "Per" + CHR(237) + "odo : "
357:             .Left      = 17
358:             .Top       = 10
359:             .Width     = 54
360:             .Height    = 15
361:             .FontBold  = .T.
362:             .FontName  = "Tahoma"
363:             .FontSize  = 8
364:             .BackStyle = 0
365:             .ForeColor = RGB(90, 90, 90)
366:             .AutoSize  = .T.
367:         ENDWITH

*-- Linhas 382 a 455:
382:             .ForeColor     = RGB(0, 0, 0)
383:             .BorderColor   = RGB(100, 100, 100)
384:         ENDWITH
385:         BINDEVENT(loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.txt_4c_Dt_inicial, "KeyPress", THIS, "DtInicialKeyPress")
386: 
387:         loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.AddObject("lbl_4c_LblAte", "Label")
388:         WITH loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.lbl_4c_LblAte
389:             .Caption   = "at" + CHR(233)
390:             .Left      = 158
391:             .Top       = 10
392:             .FontBold  = .T.
393:             .FontName  = "Tahoma"
394:             .FontSize  = 8
395:             .BackStyle = 0
396:             .ForeColor = RGB(90, 90, 90)
397:         ENDWITH
398: 
399:         loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.AddObject("txt_4c_Dt_final", "TextBox")
400:         WITH loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.txt_4c_Dt_final
401:             .Value         = DATE()
402:             .Left          = 184
403:             .Top           = 6
404:             .Width         = 80
405:             .Height        = 20
406:             .FontName      = "Tahoma"
407:             .FontSize      = 8
408:             .Format        = "E"
409:             .InputMask     = "99/99/9999"
410:             .SpecialEffect = 1
411:             .Alignment     = 3
412:             .ForeColor     = RGB(0, 0, 0)
413:             .BorderColor   = RGB(100, 100, 100)
414:         ENDWITH
415:         BINDEVENT(loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.txt_4c_Dt_final, "KeyPress", THIS, "DtFinalKeyPress")
416: 
417:         *-- Grid de lista (Grade: Top=115+29=144, Left=23, Width=944, Height=473)
418:         *-- Colunas em ORDEM VISUAL (sem ColumnOrder):
419:         *-- 1=Data(78) 2=O(17) 3=Conta(83) 4=Contra(83) 5=Hist(280)
420:         *-- 6=Debito(80) 7=" "(28) 8=Credito(80) 9="  "(28) 10=NF(78) 11=Doc(78)
421:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
422:         WITH loc_oPagina.grd_4c_Lista
423:             .Top               = 144
424:             .Left              = 23
425:             .Width             = 944
426:             .Height            = 473
427:             .FontName          = "Verdana"
428:             .FontSize          = 8
429:             .ReadOnly          = .T.
430:             .DeleteMark        = .F.
431:             .RecordMark        = .F.
432:             .ScrollBars        = 3
433:             .GridLines         = 3
434:             .GridLineColor     = RGB(238, 238, 238)
435:             .ColumnCount       = 11
436:             .AllowHeaderSizing = .T.
437:             .Visible           = .T.
438:         ENDWITH
439: 
440:         loc_oGrade = loc_oPagina.grd_4c_Lista
441: 
442:         *-- Column1: Data (Width=78, Alignment=2)
443:         WITH loc_oGrade.Column1
444:             .Width     = 78
445:             .Alignment = 2
446:             .FontName  = "Verdana"
447:             .FontSize  = 8
448:             .Movable   = .F.
449:             .Resizable = .F.
450:             .ReadOnly  = .T.
451:             .Header1.Caption   = "Data"
452:             .Header1.FontName  = "Tahoma"
453:             .Header1.FontSize  = 8
454:             .Header1.Alignment = 2
455:             .Header1.ForeColor = RGB(90, 90, 90)

*-- Linhas 606 a 709:
606:             .Header1.ForeColor = RGB(90, 90, 90)
607:         ENDWITH
608: 
609:         BINDEVENT(loc_oGrade, "AfterRowColChange", THIS, "GradeAfterRowColChange")
610: 
611:         THIS.TornarControlesVisiveis(loc_oPagina)
612:     ENDPROC
613: 
614:     *--------------------------------------------------------------------------
615:     * ConfigurarPaginaDados - Configura Page2 (edicao de movimentos)
616:     * Compensacao +29 em TODOS os controles (Top_original + 29)
617:     *--------------------------------------------------------------------------
618:     PROTECTED PROCEDURE ConfigurarPaginaDados()
619:         LOCAL loc_oPagina
620:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
621: 
622:         *-- Botoes Salvar/Cancelar (Grupo_Salva: Left=842, Top=-4+29=25)
623:         loc_oPagina.AddObject("cnt_4c_Salvar", "Container")
624:         WITH loc_oPagina.cnt_4c_Salvar
625:             .Top         = 25
626:             .Left        = 842
627:             .Width       = 160
628:             .Height      = 85
629:             .BackStyle   = 0
630:             .BorderWidth = 0
631:             .Visible     = .T.
632:         ENDWITH
633:         loc_oPagina.cnt_4c_Salvar.AddObject("cmd_4c_Salvar", "CommandButton")
634:         WITH loc_oPagina.cnt_4c_Salvar.cmd_4c_Salvar
635:             .Caption         = "Salvar"
636:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
637:             .PicturePosition = 13
638:             .Width           = 75
639:             .Height          = 75
640:             .Left            = 6
641:             .Top             = 5
642:             .FontName        = "Comic Sans MS"
643:             .FontSize        = 8
644:             .Themes          = .F.
645:             .SpecialEffect   = 0
646:             .BackColor       = RGB(255, 255, 255)
647:             .ForeColor       = RGB(90, 90, 90)
648:             .Visible         = .T.
649:         ENDWITH
650:         BINDEVENT(loc_oPagina.cnt_4c_Salvar.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")
651: 
652:         loc_oPagina.cnt_4c_Salvar.AddObject("cmd_4c_Cancelar", "CommandButton")
653:         WITH loc_oPagina.cnt_4c_Salvar.cmd_4c_Cancelar
654:             .Caption         = "Cancelar"
655:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
656:             .PicturePosition = 13
657:             .Width           = 75
658:             .Height          = 75
659:             .Left            = 81
660:             .Top             = 5
661:             .FontName        = "Comic Sans MS"
662:             .FontSize        = 8
663:             .Themes          = .F.
664:             .SpecialEffect   = 0
665:             .BackColor       = RGB(255, 255, 255)
666:             .ForeColor       = RGB(90, 90, 90)
667:             .Visible         = .T.
668:         ENDWITH
669:         BINDEVENT(loc_oPagina.cnt_4c_Salvar.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
670: 
671:         *-- Shapes divisores visuais (+29 em todos os Tops)
672:         *-- Shape1: Top=153+29=182, secao superior (datas/nf/doc)
673:         loc_oPagina.AddObject("shp_4c_Shape1", "Shape")
674:         WITH loc_oPagina.shp_4c_Shape1
675:             .Top         = 182
676:             .Left        = 9
677:             .Width       = 980
678:             .Height      = 64
679:             .BackStyle   = 0
680:             .Curvature   = 0
681:             .BorderColor = RGB(90, 90, 90)
682:         ENDWITH
683: 
684:         *-- Shape3: Top=224+29=253, secao debito (esquerda)
685:         loc_oPagina.AddObject("shp_4c_Shape3", "Shape")
686:         WITH loc_oPagina.shp_4c_Shape3
687:             .Top         = 253
688:             .Left        = 9
689:             .Width       = 485
690:             .Height      = 117
691:             .BackStyle   = 0
692:             .Curvature   = 0
693:             .BorderColor = RGB(90, 90, 90)
694:         ENDWITH
695: 
696:         *-- Shape2: Top=224+29=253, secao credito (direita)
697:         loc_oPagina.AddObject("shp_4c_Shape2", "Shape")
698:         WITH loc_oPagina.shp_4c_Shape2
699:             .Top         = 253
700:             .Left        = 504
701:             .Width       = 485
702:             .Height      = 117
703:             .BackStyle   = 0
704:             .Curvature   = 0
705:             .BorderColor = RGB(90, 90, 90)
706:         ENDWITH
707: 
708:         *-- Shape6: Top=350+29=379, secao historico
709:         loc_oPagina.AddObject("shp_4c_Shape6", "Shape")

*-- Linhas 836 a 879:
836:             .ForeColor     = RGB(0, 0, 0)
837:             .BorderColor   = RGB(100, 100, 100)
838:         ENDWITH
839:         BINDEVENT(loc_oPagina.txt_4c_Job, "KeyPress", THIS, "JobKeyPress")
840: 
841:         *-- txt_4c_DJob (Top=187+29=216, Left=195, Width=290 - desc job readonly)
842:         loc_oPagina.AddObject("txt_4c_DJob", "TextBox")
843:         WITH loc_oPagina.txt_4c_DJob
844:             .Value         = ""
845:             .Left          = 195
846:             .Top           = 216
847:             .Width         = 290
848:             .Height        = 20
849:             .FontName      = "Tahoma"
850:             .FontSize      = 8
851:             .MaxLength     = 50
852:             .SpecialEffect = 1
853:             .ReadOnly      = .T.
854:             .ForeColor     = RGB(0, 0, 0)
855:             .BorderColor   = RGB(100, 100, 100)
856:         ENDWITH
857: 
858:         *-- Label "Documento :" (Say2: Left=613, Top=191+29=220)
859:         THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label2", "Documento :", 613, 220)
860:         *-- txt_4c_DOCU (Top=187+29=216, Left=678, Width=80)
861:         loc_oPagina.AddObject("txt_4c_DOCU", "TextBox")
862:         WITH loc_oPagina.txt_4c_DOCU
863:             .Value         = ""
864:             .Left          = 678
865:             .Top           = 216
866:             .Width         = 80
867:             .Height        = 20
868:             .FontName      = "Tahoma"
869:             .FontSize      = 8
870:             .MaxLength     = 20
871:             .SpecialEffect = 1
872:             .ForeColor     = RGB(0, 0, 0)
873:             .BorderColor   = RGB(100, 100, 100)
874:         ENDWITH
875: 
876:         *======================================================================
877:         * SECAO DEBITO (esquerda): Oper, Grupo, Conta, Valor, Moeda, Cotacao
878:         * Shape3 cobre Top=253, Left=9, Width=485
879:         *======================================================================

*-- Linhas 898 a 1171:
898:             .ForeColor     = RGB(0, 0, 0)
899:             .BorderColor   = RGB(100, 100, 100)
900:         ENDWITH
901:         BINDEVENT(loc_oPagina.txt_4c_OPER, "KeyPress", THIS, "OperKeyPress")
902: 
903:         *-- Label "Grupo :" (Say4: Left=72, Top=261+29=290)
904:         THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label4", "Grupo :", 72, 290)
905:         *-- txt_4c_Grupo (Top=257+29=286, Left=112, Width=80 - F4)
906:         loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
907:         WITH loc_oPagina.txt_4c_Grupo
908:             .Value         = ""
909:             .Left          = 112
910:             .Top           = 286
911:             .Width         = 80
912:             .Height        = 20
913:             .FontName      = "Tahoma"
914:             .FontSize      = 8
915:             .MaxLength     = 10
916:             .SpecialEffect = 1
917:             .ForeColor     = RGB(0, 0, 0)
918:             .BorderColor   = RGB(100, 100, 100)
919:         ENDWITH
920:         BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress", THIS, "GrupoKeyPress")
921: 
922:         *-- txt_4c_Dgrupo (Top=257+29=286, Left=195, Width=290 - desc grupo readonly)
923:         loc_oPagina.AddObject("txt_4c_Dgrupo", "TextBox")
924:         WITH loc_oPagina.txt_4c_Dgrupo
925:             .Value         = ""
926:             .Left          = 195
927:             .Top           = 286
928:             .Width         = 290
929:             .Height        = 20
930:             .FontName      = "Tahoma"
931:             .FontSize      = 8
932:             .MaxLength     = 50
933:             .SpecialEffect = 1
934:             .ReadOnly      = .T.
935:             .ForeColor     = RGB(0, 0, 0)
936:             .BorderColor   = RGB(100, 100, 100)
937:         ENDWITH
938: 
939:         *-- Label "Conta :" (Say5: Left=72, Top=287+29=316)
940:         THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label5", "Conta :", 72, 316)
941:         *-- txt_4c_Conta (Top=283+29=312, Left=112, Width=80 - F4)
942:         loc_oPagina.AddObject("txt_4c_Conta", "TextBox")
943:         WITH loc_oPagina.txt_4c_Conta
944:             .Value         = ""
945:             .Left          = 112
946:             .Top           = 312
947:             .Width         = 80
948:             .Height        = 20
949:             .FontName      = "Tahoma"
950:             .FontSize      = 8
951:             .MaxLength     = 10
952:             .SpecialEffect = 1
953:             .ForeColor     = RGB(0, 0, 0)
954:             .BorderColor   = RGB(100, 100, 100)
955:         ENDWITH
956:         BINDEVENT(loc_oPagina.txt_4c_Conta, "KeyPress", THIS, "ContaKeyPress")
957: 
958:         *-- txt_4c_Dconta (Top=283+29=312, Left=195, Width=290 - desc conta)
959:         loc_oPagina.AddObject("txt_4c_Dconta", "TextBox")
960:         WITH loc_oPagina.txt_4c_Dconta
961:             .Value         = ""
962:             .Left          = 195
963:             .Top           = 312
964:             .Width         = 290
965:             .Height        = 20
966:             .FontName      = "Tahoma"
967:             .FontSize      = 8
968:             .MaxLength     = 50
969:             .SpecialEffect = 1
970:             .ReadOnly      = .T.
971:             .ForeColor     = RGB(0, 0, 0)
972:             .BorderColor   = RGB(100, 100, 100)
973:         ENDWITH
974: 
975:         *-- Label "Valor :" (Say8: Left=77, Top=313+29=342)
976:         THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label8", "Valor :", 77, 342)
977:         *-- txt_4c_VALOR (Top=309+29=338, Left=112, Width=128)
978:         loc_oPagina.AddObject("txt_4c_VALOR", "TextBox")
979:         WITH loc_oPagina.txt_4c_VALOR
980:             .Value         = 0
981:             .Left          = 112
982:             .Top           = 338
983:             .Width         = 128
984:             .Height        = 20
985:             .FontName      = "Tahoma"
986:             .FontSize      = 8
987:             .InputMask     = "999,999,999.99"
988:             .SpecialEffect = 1
989:             .Alignment     = 3
990:             .ForeColor     = RGB(0, 0, 0)
991:             .BorderColor   = RGB(100, 100, 100)
992:         ENDWITH
993:         BINDEVENT(loc_oPagina.txt_4c_VALOR, "KeyPress", THIS, "ValorKeyPress")
994: 
995:         *-- txt_4c_MOEDA (Top=309+29=338, Left=243, Width=31 - F4)
996:         loc_oPagina.AddObject("txt_4c_MOEDA", "TextBox")
997:         WITH loc_oPagina.txt_4c_MOEDA
998:             .Value         = ""
999:             .Left          = 243
1000:             .Top           = 338
1001:             .Width         = 31
1002:             .Height        = 20
1003:             .FontName      = "Tahoma"
1004:             .FontSize      = 8
1005:             .MaxLength     = 3
1006:             .SpecialEffect = 1
1007:             .ForeColor     = RGB(0, 0, 0)
1008:             .BorderColor   = RGB(100, 100, 100)
1009:         ENDWITH
1010:         BINDEVENT(loc_oPagina.txt_4c_MOEDA, "KeyPress", THIS, "MoedaKeyPress")
1011: 
1012:         *-- Label "Cambio :" (Say_Cotacao: Left=303, Top=313+29=342)
1013:         THIS.AddLabelP2(loc_oPagina, "lbl_4c__Cotacao", "C" + CHR(226) + "mbio :", 303, 342)
1014:         *-- txt_4c_COTACAO (Top=309+29=338, Left=349, Width=108)
1015:         loc_oPagina.AddObject("txt_4c_COTACAO", "TextBox")
1016:         WITH loc_oPagina.txt_4c_COTACAO
1017:             .Value         = 1
1018:             .Left          = 349
1019:             .Top           = 338
1020:             .Width         = 108
1021:             .Height        = 20
1022:             .FontName      = "Tahoma"
1023:             .FontSize      = 8
1024:             .InputMask     = "99,999.9999999"
1025:             .SpecialEffect = 1
1026:             .Alignment     = 3
1027:             .ForeColor     = RGB(0, 0, 0)
1028:             .BorderColor   = RGB(100, 100, 100)
1029:             .Visible       = .F.
1030:         ENDWITH
1031: 
1032:         *-- cmd_4c_Alteracotacao (Top=309+29=338, Left=461, Width=24, Height=23)
1033:         loc_oPagina.AddObject("cmd_4c_Alteracotacao", "CommandButton")
1034:         WITH loc_oPagina.cmd_4c_Alteracotacao
1035:             .Caption       = "$"
1036:             .Top           = 338
1037:             .Left          = 461
1038:             .Width         = 24
1039:             .Height        = 23
1040:             .FontBold      = .T.
1041:             .FontName      = "Tahoma"
1042:             .FontSize      = 12
1043:             .ForeColor     = RGB(90, 90, 90)
1044:             .BackColor     = RGB(255, 255, 255)
1045:             .Themes        = .F.
1046:             .TabStop       = .F.
1047:             .Visible       = .F.
1048:         ENDWITH
1049:         BINDEVENT(loc_oPagina.cmd_4c_Alteracotacao, "Click", THIS, "BtnAlteracotacaoClick")
1050: 
1051:         *======================================================================
1052:         * SECAO CREDITO (direita): SOper, SGrupo, SConta, SValor, SMoeda, SCotacao
1053:         * Shape2 cobre Top=253, Left=504, Width=485
1054:         *======================================================================
1055: 
1056:         *-- Label "Movimento :" (Say11: Left=544, Top=235+29=264)
1057:         THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label11", "Movimento :", 544, 264)
1058:         *-- Label "[D/C]" (Say14: Left=626, Top=264)
1059:         THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label14", "[D/C]", 626, 264)
1060: 
1061:         *-- txt_4c_SOPER (Top=231+29=260, Left=607, Width=15)
1062:         loc_oPagina.AddObject("txt_4c_SOPER", "TextBox")
1063:         WITH loc_oPagina.txt_4c_SOPER
1064:             .Value         = ""
1065:             .Left          = 607
1066:             .Top           = 260
1067:             .Width         = 15
1068:             .Height        = 20
1069:             .FontName      = "Tahoma"
1070:             .FontSize      = 8
1071:             .MaxLength     = 1
1072:             .SpecialEffect = 1
1073:             .ReadOnly      = .T.
1074:             .ForeColor     = RGB(0, 0, 0)
1075:             .BorderColor   = RGB(100, 100, 100)
1076:         ENDWITH
1077: 
1078:         *-- Label "Grupo :" (Say12: Left=567, Top=261+29=290)
1079:         THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label12", "Grupo :", 567, 290)
1080:         *-- txt_4c_SGRUPO (Top=257+29=286, Left=607, Width=80 - F4)
1081:         loc_oPagina.AddObject("txt_4c_SGRUPO", "TextBox")
1082:         WITH loc_oPagina.txt_4c_SGRUPO
1083:             .Value         = ""
1084:             .Left          = 607
1085:             .Top           = 286
1086:             .Width         = 80
1087:             .Height        = 20
1088:             .FontName      = "Tahoma"
1089:             .FontSize      = 8
1090:             .MaxLength     = 10
1091:             .SpecialEffect = 1
1092:             .ForeColor     = RGB(0, 0, 0)
1093:             .BorderColor   = RGB(100, 100, 100)
1094:         ENDWITH
1095:         BINDEVENT(loc_oPagina.txt_4c_SGRUPO, "KeyPress", THIS, "SGrupoKeyPress")
1096: 
1097:         *-- txt_4c_Sdgrupo (Top=257+29=286, Left=689, Width=290 - readonly)
1098:         loc_oPagina.AddObject("txt_4c_Sdgrupo", "TextBox")
1099:         WITH loc_oPagina.txt_4c_Sdgrupo
1100:             .Value         = ""
1101:             .Left          = 689
1102:             .Top           = 286
1103:             .Width         = 290
1104:             .Height        = 20
1105:             .FontName      = "Tahoma"
1106:             .FontSize      = 8
1107:             .MaxLength     = 50
1108:             .SpecialEffect = 1
1109:             .ReadOnly      = .T.
1110:             .ForeColor     = RGB(0, 0, 0)
1111:             .BorderColor   = RGB(100, 100, 100)
1112:         ENDWITH
1113: 
1114:         *-- Label "Conta :" (Say13: Left=567, Top=287+29=316)
1115:         THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label13", "Conta :", 567, 316)
1116:         *-- txt_4c_SCONTA (Top=283+29=312, Left=607, Width=80 - F4)
1117:         loc_oPagina.AddObject("txt_4c_SCONTA", "TextBox")
1118:         WITH loc_oPagina.txt_4c_SCONTA
1119:             .Value         = ""
1120:             .Left          = 607
1121:             .Top           = 312
1122:             .Width         = 80
1123:             .Height        = 20
1124:             .FontName      = "Tahoma"
1125:             .FontSize      = 8
1126:             .MaxLength     = 10
1127:             .SpecialEffect = 1
1128:             .ForeColor     = RGB(0, 0, 0)
1129:             .BorderColor   = RGB(100, 100, 100)
1130:         ENDWITH
1131:         BINDEVENT(loc_oPagina.txt_4c_SCONTA, "KeyPress", THIS, "SContaKeyPress")
1132: 
1133:         *-- txt_4c_SDCONTA (Top=283+29=312, Left=689, Width=290 - desc sconta)
1134:         loc_oPagina.AddObject("txt_4c_SDCONTA", "TextBox")
1135:         WITH loc_oPagina.txt_4c_SDCONTA
1136:             .Value         = ""
1137:             .Left          = 689
1138:             .Top           = 312
1139:             .Width         = 290
1140:             .Height        = 20
1141:             .FontName      = "Tahoma"
1142:             .FontSize      = 8
1143:             .MaxLength     = 50
1144:             .SpecialEffect = 1
1145:             .ReadOnly      = .T.
1146:             .ForeColor     = RGB(0, 0, 0)
1147:             .BorderColor   = RGB(100, 100, 100)
1148:         ENDWITH
1149: 
1150:         *-- Label "Valor :" (Say16: Left=572, Top=313+29=342)
1151:         THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label16", "Valor :", 572, 342)
1152:         *-- txt_4c_SVALOR (Top=309+29=338, Left=607, Width=128)
1153:         loc_oPagina.AddObject("txt_4c_SVALOR", "TextBox")
1154:         WITH loc_oPagina.txt_4c_SVALOR
1155:             .Value         = 0
1156:             .Left          = 607
1157:             .Top           = 338
1158:             .Width         = 128
1159:             .Height        = 20
1160:             .FontName      = "Tahoma"
1161:             .FontSize      = 8
1162:             .InputMask     = "999,999,999.99"
1163:             .SpecialEffect = 1
1164:             .Alignment     = 3
1165:             .ForeColor     = RGB(0, 0, 0)
1166:             .BorderColor   = RGB(100, 100, 100)
1167:         ENDWITH
1168: 
1169:         *-- txt_4c_Smoeda (Top=309+29=338, Left=737, Width=31 - F4)
1170:         loc_oPagina.AddObject("txt_4c_Smoeda", "TextBox")
1171:         WITH loc_oPagina.txt_4c_Smoeda

*-- Linhas 1181 a 2655:
1181:             .ForeColor     = RGB(0, 0, 0)
1182:             .BorderColor   = RGB(100, 100, 100)
1183:         ENDWITH
1184:         BINDEVENT(loc_oPagina.txt_4c_Smoeda, "KeyPress", THIS, "SMoedaKeyPress")
1185: 
1186:         *-- Label "Cambio :" (Say_sCotacao: Left=797, Top=313+29=342)
1187:         THIS.AddLabelP2(loc_oPagina, "lbl_4c__sCotacao", "C" + CHR(226) + "mbio :", 797, 342)
1188:         *-- txt_4c_SCOTACAO (Top=309+29=338, Left=843, Width=108)
1189:         loc_oPagina.AddObject("txt_4c_SCOTACAO", "TextBox")
1190:         WITH loc_oPagina.txt_4c_SCOTACAO
1191:             .Value         = 1
1192:             .Left          = 843
1193:             .Top           = 338
1194:             .Width         = 108
1195:             .Height        = 20
1196:             .FontName      = "Tahoma"
1197:             .FontSize      = 8
1198:             .InputMask     = "99,999.9999999"
1199:             .SpecialEffect = 1
1200:             .Alignment     = 3
1201:             .ForeColor     = RGB(0, 0, 0)
1202:             .BorderColor   = RGB(100, 100, 100)
1203:             .Visible       = .F.
1204:         ENDWITH
1205: 
1206:         *-- cmd_4c_Alterascotacao (Top=309+29=338, Left=955, Width=24, Height=23)
1207:         loc_oPagina.AddObject("cmd_4c_Alterascotacao", "CommandButton")
1208:         WITH loc_oPagina.cmd_4c_Alterascotacao
1209:             .Caption       = "$"
1210:             .Top           = 338
1211:             .Left          = 955
1212:             .Width         = 24
1213:             .Height        = 23
1214:             .FontBold      = .T.
1215:             .FontName      = "Tahoma"
1216:             .FontSize      = 12
1217:             .ForeColor     = RGB(90, 90, 90)
1218:             .BackColor     = RGB(255, 255, 255)
1219:             .Themes        = .F.
1220:             .TabStop       = .F.
1221:             .Visible       = .F.
1222:         ENDWITH
1223:         BINDEVENT(loc_oPagina.cmd_4c_Alterascotacao, "Click", THIS, "BtnAlterascotacaoClick")
1224: 
1225:         *======================================================================
1226:         * SECAO HISTORICO: Hist, Hist2, Opcao_conta
1227:         * Shape6 cobre Top=379, Left=9, Width=980, Height=39
1228:         *======================================================================
1229: 
1230:         *-- Label "Historico :" (Say9: Left=60, Top=362+29=391)
1231:         THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label9", "Hist" + CHR(243) + "rico :", 60, 391)
1232:         *-- txt_4c_HIST (Top=358+29=387, Left=112, Width=300)
1233:         loc_oPagina.AddObject("txt_4c_HIST", "TextBox")
1234:         WITH loc_oPagina.txt_4c_HIST
1235:             .Value         = ""
1236:             .Left          = 112
1237:             .Top           = 387
1238:             .Width         = 300
1239:             .Height        = 20
1240:             .FontName      = "Tahoma"
1241:             .FontSize      = 8
1242:             .MaxLength     = 50
1243:             .SpecialEffect = 1
1244:             .ForeColor     = RGB(0, 0, 0)
1245:             .BorderColor   = RGB(100, 100, 100)
1246:         ENDWITH
1247: 
1248:         *-- txt_4c_Hist2 (Top=358+29=387, Left=415, Width=300)
1249:         loc_oPagina.AddObject("txt_4c_Hist2", "TextBox")
1250:         WITH loc_oPagina.txt_4c_Hist2
1251:             .Value         = ""
1252:             .Left          = 415
1253:             .Top           = 387
1254:             .Width         = 300
1255:             .Height        = 20
1256:             .FontName      = "Tahoma"
1257:             .FontSize      = 8
1258:             .MaxLength     = 50
1259:             .SpecialEffect = 1
1260:             .ForeColor     = RGB(0, 0, 0)
1261:             .BorderColor   = RGB(100, 100, 100)
1262:         ENDWITH
1263: 
1264:         *-- Label "Lancar Contas :" (Say19: Left=758, Top=362+29=391)
1265:         THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label19", "Lan" + CHR(231) + "ar Contas :", 758, 391)
1266:         *-- OptionGroup Opcao_conta (Top=356+29=385, Left=844, Width=99, Height=27)
1267:         loc_oPagina.AddObject("obj_4c_Opcao_conta", "OptionGroup")
1268:         WITH loc_oPagina.obj_4c_Opcao_conta
1269:             .Top         = 385
1270:             .Left        = 844
1271:             .Width       = 99
1272:             .Height      = 27
1273:             .AutoSize    = .T.
1274:             .BorderStyle = 0
1275:             .ButtonCount = 2
1276:             .Value       = 2
1277: 
1278:             .Buttons(1).Caption   = "Sim"
1279:             .Buttons(1).Left      = 5
1280:             .Buttons(1).Top       = 5
1281:             .Buttons(1).AutoSize  = .F.
1282:             .Buttons(1).Width     = 40
1283:             .Buttons(1).Height    = 17
1284:             .Buttons(1).BackStyle = 0
1285:             .Buttons(1).FontName  = "Tahoma"
1286:             .Buttons(1).FontSize  = 8
1287:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1288:             .Buttons(1).Themes    = .F.
1289: 
1290:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1291:             .Buttons(2).Left      = 57
1292:             .Buttons(2).Top       = 6
1293:             .Buttons(2).AutoSize  = .T.
1294:             .Buttons(2).BackStyle = 0
1295:             .Buttons(2).FontName  = "Tahoma"
1296:             .Buttons(2).FontSize  = 8
1297:             .Buttons(2).ForeColor = RGB(90, 90, 90)
1298:             .Buttons(2).Themes    = .F.
1299:         ENDWITH
1300: 
1301:         THIS.TornarControlesVisiveis(loc_oPagina)
1302:     ENDPROC
1303: 
1304:     *--------------------------------------------------------------------------
1305:     * AddLabelP2 - Helper para adicionar label em Page2 (evita repeticao)
1306:     *--------------------------------------------------------------------------
1307:     PROTECTED PROCEDURE AddLabelP2(par_oPagina, par_cNome, par_cCaption, par_nLeft, par_nTop)
1308:         par_oPagina.AddObject(par_cNome, "Label")
1309:         WITH par_oPagina.&par_cNome
1310:             .Caption   = par_cCaption
1311:             .Left      = par_nLeft
1312:             .Top       = par_nTop
1313:             .AutoSize  = .T.
1314:             .Height    = 15
1315:             .FontName  = "Tahoma"
1316:             .FontSize  = 8
1317:             .BackStyle = 0
1318:             .ForeColor = RGB(90, 90, 90)
1319:         ENDWITH
1320:     ENDPROC
1321: 
1322:     *--------------------------------------------------------------------------
1323:     * CarregarLista - Carrega grid com dados do periodo filtrado
1324:     * Legado: SqlDados() - WHERE Datas BETWEEN dtI AND dtF
1325:     *--------------------------------------------------------------------------
1326:     PROCEDURE CarregarLista()
1327:         LOCAL loc_lResultado, loc_dDtI, loc_dDtF, loc_oGrade
1328:         loc_lResultado = .F.
1329: 
1330:         TRY
1331:             loc_dDtI = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.cnt_4c_Periodo.txt_4c_Dt_inicial.Value
1332:             loc_dDtF = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.cnt_4c_Periodo.txt_4c_Dt_final.Value
1333: 
1334:             IF EMPTY(loc_dDtI)
1335:                 loc_dDtI = DATE()
1336:             ENDIF
1337:             IF EMPTY(loc_dDtF)
1338:                 loc_dDtF = DATE()
1339:             ENDIF
1340: 
1341:             THIS.this_oBusinessObject.this_dDtInicial = loc_dDtI
1342:             THIS.this_oBusinessObject.this_dDtFinal   = loc_dDtF
1343: 
1344:             loc_oGrade = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1345:             loc_oGrade.RecordSource = ""
1346: 
1347:             IF USED("cursor_4c_Dados")
1348:                 USE IN cursor_4c_Dados
1349:             ENDIF
1350: 
1351:             IF THIS.this_oBusinessObject.Buscar("")
1352:                 loc_lResultado = .T.
1353:                 loc_oGrade.RecordSource = "cursor_4c_Dados"
1354: 
1355:                 *-- Definir ControlSources APOS RecordSource (CRITICO!)
1356:                 loc_oGrade.Column1.ControlSource  = "cursor_4c_Dados.datas"
1357:                 loc_oGrade.Column2.ControlSource  = "cursor_4c_Dados.opers"
1358:                 loc_oGrade.Column3.ControlSource  = "cursor_4c_Dados.contas"
1359:                 loc_oGrade.Column4.ControlSource  = "cursor_4c_Dados.scontas"
1360:                 loc_oGrade.Column5.ControlSource  = "cursor_4c_Dados.hists"
1361:                 loc_oGrade.Column6.ControlSource  = "cursor_4c_Dados.valors"
1362:                 loc_oGrade.Column7.ControlSource  = "cursor_4c_Dados.moedas"
1363:                 loc_oGrade.Column8.ControlSource  = "cursor_4c_Dados.svalors"
1364:                 loc_oGrade.Column9.ControlSource  = "cursor_4c_Dados.smoedas"
1365:                 loc_oGrade.Column10.ControlSource = "cursor_4c_Dados.nfs"
1366:                 loc_oGrade.Column11.ControlSource = "cursor_4c_Dados.docus"
1367: 
1368:                 *-- Redefinir Header1.Caption APOS RecordSource (OBRIGATORIO - Problema 32)
1369:                 loc_oGrade.Column1.Header1.Caption  = "Data"
1370:                 loc_oGrade.Column2.Header1.Caption  = "O"
1371:                 loc_oGrade.Column3.Header1.Caption  = "Conta"
1372:                 loc_oGrade.Column4.Header1.Caption  = "Contrapartida"
1373:                 loc_oGrade.Column5.Header1.Caption  = "Hist" + CHR(243) + "rico"
1374:                 loc_oGrade.Column6.Header1.Caption  = "D" + CHR(233) + "bito"
1375:                 loc_oGrade.Column7.Header1.Caption  = " "
1376:                 loc_oGrade.Column8.Header1.Caption  = "Cr" + CHR(233) + "dito"
1377:                 loc_oGrade.Column9.Header1.Caption  = ""
1378:                 loc_oGrade.Column10.Header1.Caption = "NF"
1379:                 loc_oGrade.Column11.Header1.Caption = "Documento"
1380: 
1381:                 *-- DynamicForeColor: azul para registros conciliados
1382:                 LOCAL loc_cExprFore
1383:                 loc_cExprFore = "IIF(cursor_4c_Dados.concs, RGB(0,0,255), RGB(0,0,0))"
1384:                 loc_oGrade.Column1.DynamicForeColor  = loc_cExprFore
1385:                 loc_oGrade.Column2.DynamicForeColor  = loc_cExprFore
1386:                 loc_oGrade.Column3.DynamicForeColor  = loc_cExprFore
1387:                 loc_oGrade.Column4.DynamicForeColor  = loc_cExprFore
1388:                 loc_oGrade.Column5.DynamicForeColor  = loc_cExprFore
1389:                 loc_oGrade.Column6.DynamicForeColor  = loc_cExprFore
1390:                 loc_oGrade.Column7.DynamicForeColor  = loc_cExprFore
1391:                 loc_oGrade.Column8.DynamicForeColor  = loc_cExprFore
1392:                 loc_oGrade.Column9.DynamicForeColor  = loc_cExprFore
1393:                 loc_oGrade.Column10.DynamicForeColor = loc_cExprFore
1394:                 loc_oGrade.Column11.DynamicForeColor = loc_cExprFore
1395: 
1396:                 IF RECCOUNT("cursor_4c_Dados") > 0
1397:                     GO TOP IN cursor_4c_Dados
1398:                 ENDIF
1399: 
1400:                 THIS.FormatarGridLista(loc_oGrade)
1401:                 loc_oGrade.Refresh()
1402:             ENDIF
1403: 
1404:         CATCH TO loc_oErro
1405:             MsgErro("Erro ao carregar lista: " + loc_oErro.Message, "Erro")
1406:         ENDTRY
1407: 
1408:         RETURN loc_lResultado
1409:     ENDPROC
1410: 
1411:     *--------------------------------------------------------------------------
1412:     * FormParaBO - Transfere dados do Form para o Business Object
1413:     *--------------------------------------------------------------------------
1414:     PROCEDURE FormParaBO()
1415:         LOCAL loc_oPagina
1416:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1417: 
1418:         WITH THIS.this_oBusinessObject
1419:             .this_dDatas    = NVL(loc_oPagina.txt_4c_Fweditdata_DATA.Value, DATE())
1420:             .this_dVencs    = NVL(loc_oPagina.txt_4c_Fweditdata_VENC.Value, {})
1421:             .this_dDtEmiss  = NVL(loc_oPagina.txt_4c_DtEmis.Value, {})
1422:             .this_cNotas    = ALLTRIM(loc_oPagina.txt_4c_Nota.Value)
1423:             .this_cDocus    = ALLTRIM(loc_oPagina.txt_4c_DOCU.Value)
1424:             .this_cJobs     = ALLTRIM(loc_oPagina.txt_4c_Job.Value)
1425:             .this_cDJobs    = ALLTRIM(loc_oPagina.txt_4c_DJob.Value)
1426:             .this_cOpers    = UPPER(ALLTRIM(loc_oPagina.txt_4c_OPER.Value))
1427:             .this_cGrupos   = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
1428:             .this_cDGrupos  = ALLTRIM(loc_oPagina.txt_4c_Dgrupo.Value)
1429:             .this_cContas   = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)
1430:             .this_cDContas  = ALLTRIM(loc_oPagina.txt_4c_Dconta.Value)
1431:             .this_nValors   = NVL(loc_oPagina.txt_4c_VALOR.Value, 0)
1432:             .this_cMoedas   = UPPER(ALLTRIM(loc_oPagina.txt_4c_MOEDA.Value))
1433:             .this_nCotacaos = NVL(loc_oPagina.txt_4c_COTACAO.Value, 1)
1434:             .this_cSopers   = UPPER(ALLTRIM(loc_oPagina.txt_4c_SOPER.Value))
1435:             .this_cSgrupos  = ALLTRIM(loc_oPagina.txt_4c_SGRUPO.Value)
1436:             .this_cDSgrupos = ALLTRIM(loc_oPagina.txt_4c_Sdgrupo.Value)
1437:             .this_cScontas  = ALLTRIM(loc_oPagina.txt_4c_SCONTA.Value)
1438:             .this_cDScontas = ALLTRIM(loc_oPagina.txt_4c_SDCONTA.Value)
1439:             .this_nSvalors  = NVL(loc_oPagina.txt_4c_SVALOR.Value, 0)
1440:             .this_cSmoedas  = UPPER(ALLTRIM(loc_oPagina.txt_4c_Smoeda.Value))
1441:             .this_nScotacaos = NVL(loc_oPagina.txt_4c_SCOTACAO.Value, 1)
1442:             .this_cHists    = ALLTRIM(loc_oPagina.txt_4c_HIST.Value)
1443:             .this_cHist2s   = ALLTRIM(loc_oPagina.txt_4c_Hist2.Value)
1444:             .this_nContapgs = loc_oPagina.obj_4c_Opcao_conta.Value
1445:             .this_cEmps     = go_4c_Sistema.cCodEmpresa
1446:             .this_cUsuario  = gc_4c_UsuarioLogado
1447:         ENDWITH
1448:     ENDPROC
1449: 
1450:     *--------------------------------------------------------------------------
1451:     * BOParaForm - Transfere dados do Business Object para o Form
1452:     *--------------------------------------------------------------------------
1453:     PROCEDURE BOParaForm()
1454:         LOCAL loc_oPagina
1455:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1456: 
1457:         WITH THIS.this_oBusinessObject
1458:             loc_oPagina.txt_4c_Fweditdata_DATA.Value = NVL(.this_dDatas, DATE())
1459:             loc_oPagina.txt_4c_Fweditdata_VENC.Value = NVL(.this_dVencs, {})
1460:             loc_oPagina.txt_4c_DtEmis.Value          = NVL(.this_dDtEmiss, {})
1461:             loc_oPagina.txt_4c_Nota.Value             = .this_cNotas
1462:             loc_oPagina.txt_4c_DOCU.Value             = .this_cDocus
1463:             loc_oPagina.txt_4c_Job.Value              = .this_cJobs
1464:             loc_oPagina.txt_4c_DJob.Value             = .this_cDJobs
1465:             loc_oPagina.txt_4c__Usuario.Value         = .this_cUsuario
1466:             loc_oPagina.txt_4c_OPER.Value             = .this_cOpers
1467:             loc_oPagina.txt_4c_Grupo.Value            = .this_cGrupos
1468:             loc_oPagina.txt_4c_Dgrupo.Value           = .this_cDGrupos
1469:             loc_oPagina.txt_4c_Conta.Value            = .this_cContas
1470:             loc_oPagina.txt_4c_Dconta.Value           = .this_cDContas
1471:             loc_oPagina.txt_4c_VALOR.Value            = .this_nValors
1472:             loc_oPagina.txt_4c_MOEDA.Value            = .this_cMoedas
1473:             loc_oPagina.txt_4c_COTACAO.Value          = .this_nCotacaos
1474:             loc_oPagina.txt_4c_SOPER.Value            = .this_cSopers
1475:             loc_oPagina.txt_4c_SGRUPO.Value           = .this_cSgrupos
1476:             loc_oPagina.txt_4c_Sdgrupo.Value          = .this_cDSgrupos
1477:             loc_oPagina.txt_4c_SCONTA.Value           = .this_cScontas
1478:             loc_oPagina.txt_4c_SDCONTA.Value          = .this_cDScontas
1479:             loc_oPagina.txt_4c_SVALOR.Value           = .this_nSvalors
1480:             loc_oPagina.txt_4c_Smoeda.Value           = .this_cSmoedas
1481:             loc_oPagina.txt_4c_SCOTACAO.Value         = .this_nScotacaos
1482:             loc_oPagina.txt_4c_HIST.Value             = .this_cHists
1483:             loc_oPagina.txt_4c_Hist2.Value            = .this_cHist2s
1484:             IF !EMPTY(.this_nContapgs)
1485:                 loc_oPagina.obj_4c_Opcao_conta.Value = IIF(.this_nContapgs = 1, 1, 2)
1486:             ENDIF
1487:         ENDWITH
1488: 
1489:         THIS.AtualizarVisibilidadeCotacao()
1490:     ENDPROC
1491: 
1492:     *--------------------------------------------------------------------------
1493:     * LimparCampos - Limpa todos os campos do formulario Page2
1494:     *--------------------------------------------------------------------------
1495:     PROTECTED PROCEDURE LimparCampos()
1496:         LOCAL loc_oPagina
1497:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1498: 
1499:         loc_oPagina.txt_4c_Fweditdata_DATA.Value = DATE()
1500:         loc_oPagina.txt_4c_Fweditdata_VENC.Value = {}
1501:         loc_oPagina.txt_4c_DtEmis.Value          = {}
1502:         loc_oPagina.txt_4c_Nota.Value             = ""
1503:         loc_oPagina.txt_4c_DOCU.Value             = ""
1504:         loc_oPagina.txt_4c_Job.Value              = ""
1505:         loc_oPagina.txt_4c_DJob.Value             = ""
1506:         loc_oPagina.txt_4c__Usuario.Value         = gc_4c_UsuarioLogado
1507:         loc_oPagina.txt_4c_OPER.Value             = "D"
1508:         loc_oPagina.txt_4c_Grupo.Value            = ""
1509:         loc_oPagina.txt_4c_Dgrupo.Value           = ""
1510:         loc_oPagina.txt_4c_Conta.Value            = ""
1511:         loc_oPagina.txt_4c_Dconta.Value           = ""
1512:         loc_oPagina.txt_4c_VALOR.Value            = 0
1513:         loc_oPagina.txt_4c_MOEDA.Value            = ""
1514:         loc_oPagina.txt_4c_COTACAO.Value          = 1
1515:         loc_oPagina.txt_4c_SOPER.Value            = "C"
1516:         loc_oPagina.txt_4c_SGRUPO.Value           = ""
1517:         loc_oPagina.txt_4c_Sdgrupo.Value          = ""
1518:         loc_oPagina.txt_4c_SCONTA.Value           = ""
1519:         loc_oPagina.txt_4c_SDCONTA.Value          = ""
1520:         loc_oPagina.txt_4c_SVALOR.Value           = 0
1521:         loc_oPagina.txt_4c_Smoeda.Value           = ""
1522:         loc_oPagina.txt_4c_SCOTACAO.Value         = 1
1523:         loc_oPagina.txt_4c_HIST.Value             = ""
1524:         loc_oPagina.txt_4c_Hist2.Value            = ""
1525:         loc_oPagina.obj_4c_Opcao_conta.Value      = 1
1526:     ENDPROC
1527: 
1528:     *--------------------------------------------------------------------------
1529:     * HabilitarCampos - Habilita/desabilita campos de edicao
1530:     *--------------------------------------------------------------------------
1531:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1532:         LOCAL loc_oPagina
1533:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1534: 
1535:         loc_oPagina.txt_4c_Fweditdata_DATA.ReadOnly = !par_lHabilitar
1536:         loc_oPagina.txt_4c_Fweditdata_VENC.ReadOnly = !par_lHabilitar
1537:         loc_oPagina.txt_4c_DtEmis.ReadOnly          = !par_lHabilitar
1538:         loc_oPagina.txt_4c_Nota.ReadOnly             = !par_lHabilitar
1539:         loc_oPagina.txt_4c_DOCU.ReadOnly             = !par_lHabilitar
1540:         loc_oPagina.txt_4c_Job.ReadOnly              = !par_lHabilitar
1541:         loc_oPagina.txt_4c_OPER.ReadOnly             = !par_lHabilitar
1542:         loc_oPagina.txt_4c_Grupo.ReadOnly            = !par_lHabilitar
1543:         loc_oPagina.txt_4c_Conta.ReadOnly            = !par_lHabilitar
1544:         loc_oPagina.txt_4c_VALOR.ReadOnly            = !par_lHabilitar
1545:         loc_oPagina.txt_4c_MOEDA.ReadOnly            = !par_lHabilitar
1546:         loc_oPagina.txt_4c_SGRUPO.ReadOnly           = !par_lHabilitar
1547:         loc_oPagina.txt_4c_SCONTA.ReadOnly           = !par_lHabilitar
1548:         loc_oPagina.txt_4c_SVALOR.ReadOnly           = !par_lHabilitar
1549:         loc_oPagina.txt_4c_Smoeda.ReadOnly           = !par_lHabilitar
1550:         loc_oPagina.txt_4c_HIST.ReadOnly             = !par_lHabilitar
1551:         loc_oPagina.txt_4c_Hist2.ReadOnly            = !par_lHabilitar
1552:         loc_oPagina.obj_4c_Opcao_conta.Enabled       = par_lHabilitar
1553: 
1554:         *-- Botoes Salvar/Cancelar
1555:         loc_oPagina.cnt_4c_Salvar.cmd_4c_Salvar.Visible  = par_lHabilitar
1556:         loc_oPagina.cnt_4c_Salvar.cmd_4c_Cancelar.Visible = .T.
1557:     ENDPROC
1558: 
1559:     *--------------------------------------------------------------------------
1560:     * AtualizarVisibilidadeCotacao - Controla visibilidade dos campos de cotacao
1561:     * Legado: Verifica crSigCdMoe.Cotas para mostrar/ocultar cotacao
1562:     *--------------------------------------------------------------------------
1563:     PROCEDURE AtualizarVisibilidadeCotacao()
1564:         LOCAL loc_cMoeda, loc_lCotas, loc_cSQL, loc_nRes
1565:         LOCAL loc_oPagina
1566:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1567: 
1568:         loc_cMoeda = UPPER(ALLTRIM(loc_oPagina.txt_4c_MOEDA.Value))
1569:         loc_lCotas = .F.
1570: 
1571:         IF !EMPTY(loc_cMoeda) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
1572:             loc_cSQL = "SELECT TOP 1 cotas FROM SigCdMoe WHERE Cmoes = " + EscaparSQL(loc_cMoeda)
1573:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Moe") >= 0
1574:                 IF RECCOUNT("cursor_4c_Moe") > 0
1575:                     SELECT cursor_4c_Moe
1576:                     loc_lCotas = NVL(cursor_4c_Moe.cotas, .F.)
1577:                 ENDIF
1578:                 IF USED("cursor_4c_Moe")
1579:                     USE IN cursor_4c_Moe
1580:                 ENDIF
1581:             ENDIF
1582:         ENDIF
1583: 
1584:         loc_oPagina.txt_4c_COTACAO.Visible         = loc_lCotas
1585:         loc_oPagina.lbl_4c__Cotacao.Visible        = loc_lCotas
1586:         loc_oPagina.cmd_4c_Alteracotacao.Visible   = loc_lCotas AND THIS.this_cModoAtual = "ALTERAR"
1587:     ENDPROC
1588: 
1589:     *--------------------------------------------------------------------------
1590:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
1591:     *--------------------------------------------------------------------------
1592:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
1593:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
1594:             RETURN
1595:         ENDIF
1596:         THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1597:         IF par_nPagina = 1
1598:             THIS.CarregarLista()
1599:         ENDIF
1600:     ENDPROC
1601: 
1602:     *==========================================================================
1603:     * HANDLERS DE BOTOES
1604:     *==========================================================================
1605: 
1606:     *--------------------------------------------------------------------------
1607:     * BtnIncluirClick - Incluir novo movimento
1608:     *--------------------------------------------------------------------------
1609:     PROCEDURE BtnIncluirClick()
1610:         THIS.this_oBusinessObject.NovoRegistro()
1611:         THIS.LimparCampos()
1612:         THIS.this_cModoAtual = "INCLUIR"
1613:         THIS.HabilitarCampos(.T.)
1614:         THIS.AlternarPagina(2)
1615:         THIS.pgf_4c_Paginas.Page2.txt_4c_Fweditdata_DATA.SetFocus()
1616:     ENDPROC
1617: 
1618:     *--------------------------------------------------------------------------
1619:     * BtnVisualizarClick - Visualizar movimento selecionado (Consultar no legado)
1620:     *--------------------------------------------------------------------------
1621:     PROCEDURE BtnVisualizarClick()
1622:         LOCAL loc_cCidchaves
1623: 
1624:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1625:             MsgAviso("Nenhum registro selecionado!")
1626:             RETURN
1627:         ENDIF
1628: 
1629:         SELECT cursor_4c_Dados
1630:         loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)
1631: 
1632:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
1633:             THIS.BOParaForm()
1634:             THIS.this_cModoAtual = "VISUALIZAR"
1635:             THIS.HabilitarCampos(.F.)
1636:             THIS.AlternarPagina(2)
1637:         ENDIF
1638:     ENDPROC
1639: 
1640:     *--------------------------------------------------------------------------
1641:     * BtnAlterarClick - Alterar movimento selecionado
1642:     * Legado: verifica bloqueio de periodo, conciliacao e auditoria
1643:     *--------------------------------------------------------------------------
1644:     PROCEDURE BtnAlterarClick()
1645:         LOCAL loc_cCidchaves
1646: 
1647:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1648:             MsgAviso("Nenhum registro selecionado!")
1649:             RETURN
1650:         ENDIF
1651: 
1652:         SELECT cursor_4c_Dados
1653: 
1654:         *-- Verificar se movimento esta conciliado
1655:         IF cursor_4c_Dados.concs
1656:             MsgAviso("Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida !! Movimenta" + CHR(231) + CHR(227) + "o Conciliada !")
1657:             RETURN
1658:         ENDIF
1659: 
1660:         loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)
1661: 
1662:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
1663:             *-- Verificar se e automatico
1664:             IF THIS.this_oBusinessObject.this_lAutos
1665:                 MsgAviso("Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida !! Movimenta" + CHR(231) + CHR(227) + "o Autom" + CHR(225) + "tica !")
1666:                 RETURN
1667:             ENDIF
1668: 
1669:             THIS.this_oBusinessObject.EditarRegistro()
1670:             THIS.BOParaForm()
1671:             THIS.this_cModoAtual = "ALTERAR"
1672:             THIS.HabilitarCampos(.T.)
1673:             THIS.AtualizarVisibilidadeCotacao()
1674:             THIS.AlternarPagina(2)
1675:             THIS.pgf_4c_Paginas.Page2.txt_4c_Fweditdata_DATA.SetFocus()
1676:         ENDIF
1677:     ENDPROC
1678: 
1679:     *--------------------------------------------------------------------------
1680:     * BtnExcluirClick - Excluir movimento selecionado
1681:     *--------------------------------------------------------------------------
1682:     PROCEDURE BtnExcluirClick()
1683:         LOCAL loc_cCidchaves
1684: 
1685:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1686:             MsgAviso("Nenhum registro selecionado!")
1687:             RETURN
1688:         ENDIF
1689: 
1690:         SELECT cursor_4c_Dados
1691: 
1692:         IF cursor_4c_Dados.concs
1693:             MsgAviso("Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida !! Movimenta" + CHR(231) + CHR(227) + "o Conciliada !")
1694:             RETURN
1695:         ENDIF
1696: 
1697:         loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)
1698: 
1699:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
1700:             RETURN
1701:         ENDIF
1702: 
1703:         IF THIS.this_oBusinessObject.this_lAutos
1704:             MsgAviso("Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida !! Movimenta" + CHR(231) + CHR(227) + "o Autom" + CHR(225) + "tica !")
1705:             RETURN
1706:         ENDIF
1707: 
1708:         IF MsgConfirma("Confirma exclus" + CHR(227) + "o do movimento selecionado?")
1709:             IF THIS.this_oBusinessObject.Excluir()
1710:                 MsgSucesso("Movimento exclu" + CHR(237) + "do com sucesso!")
1711:                 THIS.CarregarLista()
1712:             ENDIF
1713:         ENDIF
1714:     ENDPROC
1715: 
1716:     *--------------------------------------------------------------------------
1717:     * BtnBuscarClick - Recarrega lista (equivalente ao Procurar do legado)
1718:     *--------------------------------------------------------------------------
1719:     PROCEDURE BtnBuscarClick()
1720:         THIS.CarregarLista()
1721:     ENDPROC
1722: 
1723:     *--------------------------------------------------------------------------
1724:     * BtnEncerrarClick - Fechar formulario
1725:     *--------------------------------------------------------------------------
1726:     PROCEDURE BtnEncerrarClick()
1727:         THIS.Release()
1728:     ENDPROC
1729: 
1730:     *--------------------------------------------------------------------------
1731:     * BtnSalvarClick - Salvar movimento (Inserir ou Alterar)
1732:     *--------------------------------------------------------------------------
1733:     PROCEDURE BtnSalvarClick()
1734:         LOCAL loc_oPagina, loc_cOper, loc_cGrupo, loc_cConta, loc_cMoeda
1735:         LOCAL loc_cSGrupo, loc_cSConta, loc_cSMoeda, loc_nValor, loc_nSValor
1736:         LOCAL loc_dData
1737: 
1738:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1739: 
1740:         *-- Validacao: Data
1741:         loc_dData = loc_oPagina.txt_4c_Fweditdata_DATA.Value
1742:         IF EMPTY(loc_dData)
1743:             MsgAviso("Data Inv" + CHR(225) + "lida")
1744:             loc_oPagina.txt_4c_Fweditdata_DATA.SetFocus()
1745:             RETURN
1746:         ENDIF
1747: 
1748:         *-- Validacao: Vencimento (quando Lancar Contas = Sim)
1749:         IF loc_oPagina.obj_4c_Opcao_conta.Value = 1
1750:             IF EMPTY(loc_oPagina.txt_4c_Fweditdata_VENC.Value)
1751:                 MsgAviso("Vencimento Inv" + CHR(225) + "lido")
1752:                 loc_oPagina.txt_4c_Fweditdata_VENC.SetFocus()
1753:                 RETURN
1754:             ENDIF
1755:             IF loc_oPagina.txt_4c_Fweditdata_VENC.Value < loc_dData
1756:                 MsgAviso("Vencimento N" + CHR(227) + "o Pode Ser Menor Que a Data de Lan" + CHR(231) + "amento!")
1757:                 loc_oPagina.txt_4c_Fweditdata_VENC.SetFocus()
1758:                 RETURN
1759:             ENDIF
1760:         ENDIF
1761: 
1762:         *-- Validacao: Operacao D ou C
1763:         loc_cOper = UPPER(ALLTRIM(loc_oPagina.txt_4c_OPER.Value))
1764:         IF !INLIST(loc_cOper, "D", "C")
1765:             MsgAviso("Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida! Digite D ou C.")
1766:             loc_oPagina.txt_4c_OPER.SetFocus()
1767:             RETURN
1768:         ENDIF
1769: 
1770:         *-- Validacao: Grupo D
1771:         loc_cGrupo = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
1772:         IF EMPTY(loc_cGrupo)
1773:             MsgAviso("Grupo Inv" + CHR(225) + "lido")
1774:             loc_oPagina.txt_4c_Grupo.SetFocus()
1775:             RETURN
1776:         ENDIF
1777: 
1778:         *-- Validacao: Conta D
1779:         loc_cConta = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)
1780:         IF EMPTY(loc_cConta)
1781:             MsgAviso("Conta Inv" + CHR(225) + "lida")
1782:             loc_oPagina.txt_4c_Conta.SetFocus()
1783:             RETURN
1784:         ENDIF
1785: 
1786:         *-- Validacao: Moeda D
1787:         loc_cMoeda = UPPER(ALLTRIM(loc_oPagina.txt_4c_MOEDA.Value))
1788:         IF EMPTY(loc_cMoeda)
1789:             MsgAviso("Moeda Inv" + CHR(225) + "lida")
1790:             loc_oPagina.txt_4c_MOEDA.SetFocus()
1791:             RETURN
1792:         ENDIF
1793: 
1794:         *-- Validacao: Valor D
1795:         loc_nValor = NVL(loc_oPagina.txt_4c_VALOR.Value, -1)
1796:         IF loc_nValor < 0
1797:             MsgAviso("Valor Inv" + CHR(225) + "lido")
1798:             loc_oPagina.txt_4c_VALOR.SetFocus()
1799:             RETURN
1800:         ENDIF
1801: 
1802:         *-- Validacao: SGrupo C
1803:         loc_cSGrupo = ALLTRIM(loc_oPagina.txt_4c_SGRUPO.Value)
1804:         IF EMPTY(loc_cSGrupo)
1805:             MsgAviso("Grupo (Cr" + CHR(233) + "dito) Inv" + CHR(225) + "lido")
1806:             loc_oPagina.txt_4c_SGRUPO.SetFocus()
1807:             RETURN
1808:         ENDIF
1809: 
1810:         *-- Validacao: SConta C
1811:         loc_cSConta = ALLTRIM(loc_oPagina.txt_4c_SCONTA.Value)
1812:         IF EMPTY(loc_cSConta)
1813:             MsgAviso("Conta (Cr" + CHR(233) + "dito) Inv" + CHR(225) + "lida")
1814:             loc_oPagina.txt_4c_SCONTA.SetFocus()
1815:             RETURN
1816:         ENDIF
1817: 
1818:         *-- Validacao: SMoeda C
1819:         loc_cSMoeda = UPPER(ALLTRIM(loc_oPagina.txt_4c_Smoeda.Value))
1820:         IF EMPTY(loc_cSMoeda)
1821:             MsgAviso("Moeda (Cr" + CHR(233) + "dito) Inv" + CHR(225) + "lida")
1822:             loc_oPagina.txt_4c_Smoeda.SetFocus()
1823:             RETURN
1824:         ENDIF
1825: 
1826:         *-- Validacao: SValor C
1827:         loc_nSValor = NVL(loc_oPagina.txt_4c_SVALOR.Value, -1)
1828:         IF loc_nSValor < 0
1829:             MsgAviso("Valor (Cr" + CHR(233) + "dito) Inv" + CHR(225) + "lido")
1830:             loc_oPagina.txt_4c_SVALOR.SetFocus()
1831:             RETURN
1832:         ENDIF
1833: 
1834:         *-- Validacao: mesma moeda deve ter mesma cotacao
1835:         IF loc_cMoeda == loc_cSMoeda
1836:             IF NVL(loc_oPagina.txt_4c_COTACAO.Value, 1) != NVL(loc_oPagina.txt_4c_SCOTACAO.Value, 1)
1837:                 MsgAviso("Cota" + CHR(231) + CHR(227) + "o Inconsistente!")
1838:                 loc_oPagina.txt_4c_MOEDA.SetFocus()
1839:                 RETURN
1840:             ENDIF
1841:         ENDIF
1842: 
1843:         *-- Validacao: lancamento inconsistente (D e C iguais)
1844:         IF loc_cGrupo + loc_cConta + loc_cMoeda == loc_cSGrupo + loc_cSConta + loc_cSMoeda
1845:             MsgAviso("Lan" + CHR(231) + "amento Inconsistente! D" + CHR(233) + "bito = Cr" + CHR(233) + "dito")
1846:             loc_oPagina.txt_4c_MOEDA.SetFocus()
1847:             RETURN
1848:         ENDIF
1849: 
1850:         THIS.FormParaBO()
1851: 
1852:         IF THIS.this_oBusinessObject.Salvar()
1853:             MsgSucesso("Movimento salvo com sucesso!")
1854:             THIS.AlternarPagina(1)
1855:             THIS.this_cModoAtual = "LISTA"
1856:             THIS.CarregarLista()
1857:         ENDIF
1858:     ENDPROC
1859: 
1860:     *--------------------------------------------------------------------------
1861:     * BtnCancelarClick - Cancelar edicao e voltar para lista
1862:     *--------------------------------------------------------------------------
1863:     PROCEDURE BtnCancelarClick()
1864:         THIS.AlternarPagina(1)
1865:         THIS.this_cModoAtual = "LISTA"
1866:         THIS.CarregarLista()    && OBRIGATORIO: recarrega dados + formatacao (Problema 2)
1867:     ENDPROC
1868: 
1869:     *--------------------------------------------------------------------------
1870:     * BtnAnexaClick - Abrir documento vinculado (F7 no legado)
1871:     *--------------------------------------------------------------------------
1872:     PROCEDURE BtnAnexaClick()
1873:         *-- Legado abre SigCdPgr, SigMvExp ou SigCdLch dependendo do registro
1874:         *-- Implementacao simplificada: informar usuario
1875:         MsgInfo("Funcionalidade de documento vinculado n" + CHR(227) + "o dispon" + CHR(237) + "vel nesta vers" + CHR(227) + "o.")
1876:     ENDPROC
1877: 
1878:     *--------------------------------------------------------------------------
1879:     * BtnAlteracotacaoClick - Habilitar edicao de cotacao D
1880:     *--------------------------------------------------------------------------
1881:     PROCEDURE BtnAlteracotacaoClick()
1882:         THIS.pgf_4c_Paginas.Page2.txt_4c_COTACAO.ReadOnly = .F.
1883:         THIS.pgf_4c_Paginas.Page2.txt_4c_COTACAO.SetFocus()
1884:     ENDPROC
1885: 
1886:     *--------------------------------------------------------------------------
1887:     * BtnAlterascotacaoClick - Habilitar edicao de cotacao C
1888:     *--------------------------------------------------------------------------
1889:     PROCEDURE BtnAlterascotacaoClick()
1890:         THIS.pgf_4c_Paginas.Page2.txt_4c_SCOTACAO.ReadOnly = .F.
1891:         THIS.pgf_4c_Paginas.Page2.txt_4c_SCOTACAO.SetFocus()
1892:     ENDPROC
1893: 
1894:     *==========================================================================
1895:     * HANDLERS DE FILTRO DE DATA
1896:     *==========================================================================
1897: 
1898:     *--------------------------------------------------------------------------
1899:     * DtInicialKeyPress - ENTER/TAB em Dt_inicial ajusta Dt_final se necessario
1900:     *--------------------------------------------------------------------------
1901:     PROCEDURE DtInicialKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1902:         LOCAL loc_oPeriodo
1903:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1904:             loc_oPeriodo = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.cnt_4c_Periodo
1905:             IF !EMPTY(loc_oPeriodo.txt_4c_Dt_inicial.Value)
1906:                 IF loc_oPeriodo.txt_4c_Dt_inicial.Value > loc_oPeriodo.txt_4c_Dt_final.Value
1907:                     loc_oPeriodo.txt_4c_Dt_final.Value = loc_oPeriodo.txt_4c_Dt_inicial.Value
1908:                 ENDIF
1909:             ENDIF
1910:         ENDIF
1911:     ENDPROC
1912: 
1913:     *--------------------------------------------------------------------------
1914:     * DtFinalKeyPress - ENTER/TAB em Dt_final recarrega lista
1915:     *--------------------------------------------------------------------------
1916:     PROCEDURE DtFinalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1917:         LOCAL loc_oPeriodo
1918:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1919:             loc_oPeriodo = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.cnt_4c_Periodo
1920:             IF !EMPTY(loc_oPeriodo.txt_4c_Dt_final.Value)
1921:                 IF loc_oPeriodo.txt_4c_Dt_final.Value < loc_oPeriodo.txt_4c_Dt_inicial.Value
1922:                     loc_oPeriodo.txt_4c_Dt_inicial.Value = loc_oPeriodo.txt_4c_Dt_final.Value
1923:                 ENDIF
1924:             ENDIF
1925:             THIS.CarregarLista()
1926:         ENDIF
1927:     ENDPROC
1928: 
1929:     *==========================================================================
1930:     * HANDLERS DE TECLA - CAMPO OPER
1931:     *==========================================================================
1932: 
1933:     *--------------------------------------------------------------------------
1934:     * OperKeyPress - Valida OPER (D ou C) e seta SOPER automaticamente
1935:     *--------------------------------------------------------------------------
1936:     PROCEDURE OperKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1937:         LOCAL loc_oPagina, loc_cOper
1938: 
1939:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1940:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1941:             loc_cOper   = UPPER(ALLTRIM(loc_oPagina.txt_4c_OPER.Value))
1942: 
1943:             IF !EMPTY(loc_cOper) AND !INLIST(loc_cOper, "D", "C")
1944:                 MsgAviso("Digite (D)" + CHR(233) + "bito ou (C)r" + CHR(233) + "dito !!!")
1945:                 loc_oPagina.txt_4c_OPER.SetFocus()
1946:             ELSE
1947:                 IF loc_cOper = "D"
1948:                     loc_oPagina.txt_4c_SOPER.Value = "C"
1949:                 ELSE
1950:                     IF loc_cOper = "C"
1951:                         loc_oPagina.txt_4c_SOPER.Value = "D"
1952:                     ENDIF
1953:                 ENDIF
1954:             ENDIF
1955:         ENDIF
1956:     ENDPROC
1957: 
1958:     *==========================================================================
1959:     * HANDLERS DE TECLA - VALOR
1960:     *==========================================================================
1961: 
1962:     *--------------------------------------------------------------------------
1963:     * ValorKeyPress - Recalcula SValor quando sair do campo Valor
1964:     *--------------------------------------------------------------------------
1965:     PROCEDURE ValorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1966:         LOCAL loc_oPagina, loc_nValor, loc_nCot, loc_nSCot
1967: 
1968:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1969:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1970:             loc_nValor  = NVL(loc_oPagina.txt_4c_VALOR.Value, 0)
1971: 
1972:             IF loc_nValor < 0
1973:                 MsgAviso("Valor Inv" + CHR(225) + "lido...")
1974:                 loc_oPagina.txt_4c_VALOR.SetFocus()
1975:             ELSE
1976:                 loc_nCot  = NVL(loc_oPagina.txt_4c_COTACAO.Value, 1)
1977:                 loc_nSCot = NVL(loc_oPagina.txt_4c_SCOTACAO.Value, 1)
1978:                 IF loc_nSCot > 0
1979:                     loc_oPagina.txt_4c_SVALOR.Value = loc_nValor * loc_nCot / loc_nSCot
1980:                 ELSE
1981:                     loc_oPagina.txt_4c_SVALOR.Value = loc_nValor
1982:                 ENDIF
1983:             ENDIF
1984:         ENDIF
1985:     ENDPROC
1986: 
1987:     *==========================================================================
1988:     * HANDLERS DE LOOKUP - GRUPO (D)
1989:     *==========================================================================
1990: 
1991:     *--------------------------------------------------------------------------
1992:     * GrupoKeyPress - F4 abre lookup, ENTER/TAB valida grupo existente
1993:     *--------------------------------------------------------------------------
1994:     PROCEDURE GrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1995:         IF par_nKeyCode = 115    && F4
1996:             THIS.AbrirLookupGrupo()
1997:         ELSE
1998:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1999:                 THIS.ValidarGrupo()
2000:             ENDIF
2001:         ENDIF
2002:     ENDPROC
2003: 
2004:     *--------------------------------------------------------------------------
2005:     * AbrirLookupGrupo - Lookup de Grupo de Conta Corrente (SigCdGcr)
2006:     *--------------------------------------------------------------------------
2007:     PROCEDURE AbrirLookupGrupo()
2008:         LOCAL loc_oBusca, loc_oPagina
2009:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
2010: 
2011:         TRY
2012:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGcr", ;
2013:                          "cursor_4c_BuscaGcr", "Codigos", ;
2014:                          ALLTRIM(loc_oPagina.txt_4c_Grupo.Value), ;
2015:                          "Buscar Grupo")
2016:             loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
2017:             loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
2018:             loc_oBusca.Show()
2019: 
2020:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
2021:                 SELECT cursor_4c_BuscaGcr
2022:                 loc_oPagina.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_BuscaGcr.Codigos)
2023:                 loc_oPagina.txt_4c_Dgrupo.Value = ALLTRIM(cursor_4c_BuscaGcr.Descrs)
2024:             ENDIF
2025: 
2026:             IF USED("cursor_4c_BuscaGcr")
2027:                 USE IN cursor_4c_BuscaGcr
2028:             ENDIF
2029:             loc_oBusca.Release()
2030: 
2031:         CATCH TO loc_oErro
2032:             MsgErro("Erro no lookup de Grupo: " + loc_oErro.Message, "Erro")
2033:         ENDTRY
2034:     ENDPROC
2035: 
2036:     *--------------------------------------------------------------------------
2037:     * ValidarGrupo - Valida grupo digitado e busca descricao
2038:     *--------------------------------------------------------------------------
2039:     PROCEDURE ValidarGrupo()
2040:         LOCAL loc_oPagina, loc_cGrupo, loc_cSQL
2041:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
2042:         loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
2043: 
2044:         IF EMPTY(loc_cGrupo)
2045:             loc_oPagina.txt_4c_Dgrupo.Value = ""
2046:             RETURN
2047:         ENDIF
2048: 
2049:         TRY
2050:             loc_cSQL = "SELECT TOP 1 Codigos, Descrs, Classes FROM SigCdGcr" + ;
2051:                        " WHERE Codigos = " + EscaparSQL(loc_cGrupo)
2052: 
2053:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Gcr") >= 0
2054:                 IF RECCOUNT("cursor_4c_Gcr") > 0
2055:                     SELECT cursor_4c_Gcr
2056:                     loc_oPagina.txt_4c_Dgrupo.Value = ALLTRIM(cursor_4c_Gcr.Descrs)
2057:                     IF EMPTY(cursor_4c_Gcr.Classes)
2058:                         MsgAviso("Imposs" + CHR(237) + "vel Realizar Lan" + CHR(231) + "amento Neste Grupo!!!" + CHR(13) + ;
2059:                                  "A Classe do Grupo N" + CHR(227) + "o Foi Informada!!!")
2060:                     ENDIF
2061:                 ELSE
2062:                     MsgAviso("Grupo n" + CHR(227) + "o encontrado: " + loc_cGrupo)
2063:                     loc_oPagina.txt_4c_Grupo.Value  = ""
2064:                     loc_oPagina.txt_4c_Dgrupo.Value = ""
2065:                     loc_oPagina.txt_4c_Grupo.SetFocus()
2066:                 ENDIF
2067:                 IF USED("cursor_4c_Gcr")
2068:                     USE IN cursor_4c_Gcr
2069:                 ENDIF
2070:             ENDIF
2071:         CATCH TO loc_oErro
2072:             MsgErro("Erro ao validar Grupo: " + loc_oErro.Message, "Erro")
2073:         ENDTRY
2074:     ENDPROC
2075: 
2076:     *==========================================================================
2077:     * HANDLERS DE LOOKUP - CONTA (D)
2078:     *==========================================================================
2079: 
2080:     *--------------------------------------------------------------------------
2081:     * ContaKeyPress - F4 abre lookup, ENTER/TAB valida conta
2082:     *--------------------------------------------------------------------------
2083:     PROCEDURE ContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2084:         IF par_nKeyCode = 115    && F4
2085:             THIS.AbrirLookupConta()
2086:         ELSE
2087:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
2088:                 THIS.ValidarConta()
2089:             ENDIF
2090:         ENDIF
2091:     ENDPROC
2092: 
2093:     *--------------------------------------------------------------------------
2094:     * AbrirLookupConta - Lookup de Conta (SigCdCli - Iclis/Rclis)
2095:     *--------------------------------------------------------------------------
2096:     PROCEDURE AbrirLookupConta()
2097:         LOCAL loc_oBusca, loc_oPagina
2098:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
2099: 
2100:         TRY
2101:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
2102:                          "cursor_4c_BuscaCli", "Iclis", ;
2103:                          ALLTRIM(loc_oPagina.txt_4c_Conta.Value), ;
2104:                          "Buscar Conta")
2105:             loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
2106:             loc_oBusca.mAddColuna("Rclis", "", "Descri" + CHR(231) + CHR(227) + "o")
2107:             loc_oBusca.Show()
2108: 
2109:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
2110:                 SELECT cursor_4c_BuscaCli
2111:                 loc_oPagina.txt_4c_Conta.Value   = ALLTRIM(cursor_4c_BuscaCli.Iclis)
2112:                 loc_oPagina.txt_4c_Dconta.Value  = ALLTRIM(cursor_4c_BuscaCli.Rclis)
2113:             ENDIF
2114: 
2115:             IF USED("cursor_4c_BuscaCli")
2116:                 USE IN cursor_4c_BuscaCli
2117:             ENDIF
2118:             loc_oBusca.Release()
2119: 
2120:         CATCH TO loc_oErro
2121:             MsgErro("Erro no lookup de Conta: " + loc_oErro.Message, "Erro")
2122:         ENDTRY
2123:     ENDPROC
2124: 
2125:     *--------------------------------------------------------------------------
2126:     * ValidarConta - Valida conta digitada e busca descricao
2127:     *--------------------------------------------------------------------------
2128:     PROCEDURE ValidarConta()
2129:         LOCAL loc_oPagina, loc_cConta, loc_cSQL
2130:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
2131:         loc_cConta  = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)
2132: 
2133:         IF EMPTY(loc_cConta)
2134:             loc_oPagina.txt_4c_Dconta.Value = ""
2135:             RETURN
2136:         ENDIF
2137: 
2138:         TRY
2139:             loc_cSQL = "SELECT TOP 1 Iclis, Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cConta)
2140: 
2141:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cli") >= 0
2142:                 IF RECCOUNT("cursor_4c_Cli") > 0
2143:                     SELECT cursor_4c_Cli
2144:                     loc_oPagina.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_Cli.Rclis)
2145:                 ELSE
2146:                     MsgAviso("Conta n" + CHR(227) + "o encontrada: " + loc_cConta)
2147:                     loc_oPagina.txt_4c_Conta.Value  = ""
2148:                     loc_oPagina.txt_4c_Dconta.Value = ""
2149:                     loc_oPagina.txt_4c_Conta.SetFocus()
2150:                 ENDIF
2151:                 IF USED("cursor_4c_Cli")
2152:                     USE IN cursor_4c_Cli
2153:                 ENDIF
2154:             ENDIF
2155:         CATCH TO loc_oErro
2156:             MsgErro("Erro ao validar Conta: " + loc_oErro.Message, "Erro")
2157:         ENDTRY
2158:     ENDPROC
2159: 
2160:     *==========================================================================
2161:     * HANDLERS DE LOOKUP - MOEDA (D)
2162:     *==========================================================================
2163: 
2164:     *--------------------------------------------------------------------------
2165:     * MoedaKeyPress - F4 abre lookup de moeda
2166:     *--------------------------------------------------------------------------
2167:     PROCEDURE MoedaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2168:         IF par_nKeyCode = 115    && F4
2169:             THIS.AbrirLookupMoeda()
2170:         ELSE
2171:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
2172:                 THIS.AtualizarVisibilidadeCotacao()
2173:             ENDIF
2174:         ENDIF
2175:     ENDPROC
2176: 
2177:     *--------------------------------------------------------------------------
2178:     * AbrirLookupMoeda - Lookup de Moeda (SigCdMoe - Cmoes/Dmoes)
2179:     *--------------------------------------------------------------------------
2180:     PROCEDURE AbrirLookupMoeda()
2181:         LOCAL loc_oBusca, loc_oPagina
2182:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
2183: 
2184:         TRY
2185:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdMoe", ;
2186:                          "cursor_4c_BuscaMoe", "Cmoes", ;
2187:                          UPPER(ALLTRIM(loc_oPagina.txt_4c_MOEDA.Value)), ;
2188:                          "Buscar Moeda")
2189:             loc_oBusca.mAddColuna("Cmoes", "", "C" + CHR(243) + "digo")
2190:             loc_oBusca.mAddColuna("Dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
2191:             loc_oBusca.Show()
2192: 
2193:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
2194:                 SELECT cursor_4c_BuscaMoe
2195:                 loc_oPagina.txt_4c_MOEDA.Value = UPPER(ALLTRIM(cursor_4c_BuscaMoe.Cmoes))
2196:                 THIS.AtualizarVisibilidadeCotacao()
2197:             ENDIF
2198: 
2199:             IF USED("cursor_4c_BuscaMoe")
2200:                 USE IN cursor_4c_BuscaMoe
2201:             ENDIF
2202:             loc_oBusca.Release()
2203: 
2204:         CATCH TO loc_oErro
2205:             MsgErro("Erro no lookup de Moeda: " + loc_oErro.Message, "Erro")
2206:         ENDTRY
2207:     ENDPROC
2208: 
2209:     *==========================================================================
2210:     * HANDLERS DE LOOKUP - GRUPO CREDITO (S)
2211:     *==========================================================================
2212: 
2213:     *--------------------------------------------------------------------------
2214:     * SGrupoKeyPress - F4 abre lookup de Grupo credito
2215:     *--------------------------------------------------------------------------
2216:     PROCEDURE SGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2217:         IF par_nKeyCode = 115    && F4
2218:             THIS.AbrirLookupSGrupo()
2219:         ELSE
2220:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
2221:                 THIS.ValidarSGrupo()
2222:             ENDIF
2223:         ENDIF
2224:     ENDPROC
2225: 
2226:     *--------------------------------------------------------------------------
2227:     * AbrirLookupSGrupo - Lookup de SGrupo (SigCdGcr)
2228:     *--------------------------------------------------------------------------
2229:     PROCEDURE AbrirLookupSGrupo()
2230:         LOCAL loc_oBusca, loc_oPagina
2231:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
2232: 
2233:         TRY
2234:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGcr", ;
2235:                          "cursor_4c_BuscaGcr2", "Codigos", ;
2236:                          ALLTRIM(loc_oPagina.txt_4c_SGRUPO.Value), ;
2237:                          "Buscar Grupo (Cr" + CHR(233) + "dito)")
2238:             loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
2239:             loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
2240:             loc_oBusca.Show()
2241: 
2242:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr2")
2243:                 SELECT cursor_4c_BuscaGcr2
2244:                 loc_oPagina.txt_4c_SGRUPO.Value  = ALLTRIM(cursor_4c_BuscaGcr2.Codigos)
2245:                 loc_oPagina.txt_4c_Sdgrupo.Value = ALLTRIM(cursor_4c_BuscaGcr2.Descrs)
2246:             ENDIF
2247: 
2248:             IF USED("cursor_4c_BuscaGcr2")
2249:                 USE IN cursor_4c_BuscaGcr2
2250:             ENDIF
2251:             loc_oBusca.Release()
2252: 
2253:         CATCH TO loc_oErro
2254:             MsgErro("Erro no lookup de SGrupo: " + loc_oErro.Message, "Erro")
2255:         ENDTRY
2256:     ENDPROC
2257: 
2258:     *--------------------------------------------------------------------------
2259:     * ValidarSGrupo - Valida SGrupo digitado e busca descricao
2260:     *--------------------------------------------------------------------------
2261:     PROCEDURE ValidarSGrupo()
2262:         LOCAL loc_oPagina, loc_cSGrupo, loc_cSQL
2263:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
2264:         loc_cSGrupo = ALLTRIM(loc_oPagina.txt_4c_SGRUPO.Value)
2265: 
2266:         IF EMPTY(loc_cSGrupo)
2267:             loc_oPagina.txt_4c_Sdgrupo.Value = ""
2268:             RETURN
2269:         ENDIF
2270: 
2271:         TRY
2272:             loc_cSQL = "SELECT TOP 1 Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cSGrupo)
2273: 
2274:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GcrS") >= 0
2275:                 IF RECCOUNT("cursor_4c_GcrS") > 0
2276:                     SELECT cursor_4c_GcrS
2277:                     loc_oPagina.txt_4c_Sdgrupo.Value = ALLTRIM(cursor_4c_GcrS.Descrs)
2278:                 ELSE
2279:                     MsgAviso("Grupo (Cr" + CHR(233) + "dito) n" + CHR(227) + "o encontrado: " + loc_cSGrupo)
2280:                     loc_oPagina.txt_4c_SGRUPO.Value  = ""
2281:                     loc_oPagina.txt_4c_Sdgrupo.Value = ""
2282:                     loc_oPagina.txt_4c_SGRUPO.SetFocus()
2283:                 ENDIF
2284:                 IF USED("cursor_4c_GcrS")
2285:                     USE IN cursor_4c_GcrS
2286:                 ENDIF
2287:             ENDIF
2288:         CATCH TO loc_oErro
2289:             MsgErro("Erro ao validar SGrupo: " + loc_oErro.Message, "Erro")
2290:         ENDTRY
2291:     ENDPROC
2292: 
2293:     *==========================================================================
2294:     * HANDLERS DE LOOKUP - CONTA CREDITO (S)
2295:     *==========================================================================
2296: 
2297:     *--------------------------------------------------------------------------
2298:     * SContaKeyPress - F4 abre lookup de Conta credito
2299:     *--------------------------------------------------------------------------
2300:     PROCEDURE SContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2301:         IF par_nKeyCode = 115    && F4
2302:             THIS.AbrirLookupSConta()
2303:         ELSE
2304:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
2305:                 THIS.ValidarSConta()
2306:             ENDIF
2307:         ENDIF
2308:     ENDPROC
2309: 
2310:     *--------------------------------------------------------------------------
2311:     * AbrirLookupSConta - Lookup de SConta (SigCdCli)
2312:     *--------------------------------------------------------------------------
2313:     PROCEDURE AbrirLookupSConta()
2314:         LOCAL loc_oBusca, loc_oPagina
2315:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
2316: 
2317:         TRY
2318:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
2319:                          "cursor_4c_BuscaCli2", "Iclis", ;
2320:                          ALLTRIM(loc_oPagina.txt_4c_SCONTA.Value), ;
2321:                          "Buscar Conta (Cr" + CHR(233) + "dito)")
2322:             loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
2323:             loc_oBusca.mAddColuna("Rclis", "", "Descri" + CHR(231) + CHR(227) + "o")
2324:             loc_oBusca.Show()
2325: 
2326:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli2")
2327:                 SELECT cursor_4c_BuscaCli2
2328:                 loc_oPagina.txt_4c_SCONTA.Value  = ALLTRIM(cursor_4c_BuscaCli2.Iclis)
2329:                 loc_oPagina.txt_4c_SDCONTA.Value = ALLTRIM(cursor_4c_BuscaCli2.Rclis)
2330:             ENDIF
2331: 
2332:             IF USED("cursor_4c_BuscaCli2")
2333:                 USE IN cursor_4c_BuscaCli2
2334:             ENDIF
2335:             loc_oBusca.Release()
2336: 
2337:         CATCH TO loc_oErro
2338:             MsgErro("Erro no lookup de SConta: " + loc_oErro.Message, "Erro")
2339:         ENDTRY
2340:     ENDPROC
2341: 
2342:     *--------------------------------------------------------------------------
2343:     * ValidarSConta - Valida SConta digitada e busca descricao
2344:     *--------------------------------------------------------------------------
2345:     PROCEDURE ValidarSConta()
2346:         LOCAL loc_oPagina, loc_cSConta, loc_cSQL
2347:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
2348:         loc_cSConta = ALLTRIM(loc_oPagina.txt_4c_SCONTA.Value)
2349: 
2350:         IF EMPTY(loc_cSConta)
2351:             loc_oPagina.txt_4c_SDCONTA.Value = ""
2352:             RETURN
2353:         ENDIF
2354: 
2355:         TRY
2356:             loc_cSQL = "SELECT TOP 1 Iclis, Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cSConta)
2357: 
2358:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliS") >= 0
2359:                 IF RECCOUNT("cursor_4c_CliS") > 0
2360:                     SELECT cursor_4c_CliS
2361:                     loc_oPagina.txt_4c_SDCONTA.Value = ALLTRIM(cursor_4c_CliS.Rclis)
2362:                 ELSE
2363:                     MsgAviso("Conta (Cr" + CHR(233) + "dito) n" + CHR(227) + "o encontrada: " + loc_cSConta)
2364:                     loc_oPagina.txt_4c_SCONTA.Value  = ""
2365:                     loc_oPagina.txt_4c_SDCONTA.Value = ""
2366:                     loc_oPagina.txt_4c_SCONTA.SetFocus()
2367:                 ENDIF
2368:                 IF USED("cursor_4c_CliS")
2369:                     USE IN cursor_4c_CliS
2370:                 ENDIF
2371:             ENDIF
2372:         CATCH TO loc_oErro
2373:             MsgErro("Erro ao validar SConta: " + loc_oErro.Message, "Erro")
2374:         ENDTRY
2375:     ENDPROC
2376: 
2377:     *==========================================================================
2378:     * HANDLERS DE LOOKUP - MOEDA CREDITO (S)
2379:     *==========================================================================
2380: 
2381:     *--------------------------------------------------------------------------
2382:     * SMoedaKeyPress - F4 abre lookup de Moeda credito
2383:     *--------------------------------------------------------------------------
2384:     PROCEDURE SMoedaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2385:         IF par_nKeyCode = 115    && F4
2386:             THIS.AbrirLookupSMoeda()
2387:         ELSE
2388:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
2389:                 THIS.AtualizarVisibilidadeSCotacao()
2390:             ENDIF
2391:         ENDIF
2392:     ENDPROC
2393: 
2394:     *--------------------------------------------------------------------------
2395:     * AbrirLookupSMoeda - Lookup de SMoeda (SigCdMoe)
2396:     *--------------------------------------------------------------------------
2397:     PROCEDURE AbrirLookupSMoeda()
2398:         LOCAL loc_oBusca, loc_oPagina
2399:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
2400: 
2401:         TRY
2402:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdMoe", ;
2403:                          "cursor_4c_BuscaMoe2", "Cmoes", ;
2404:                          UPPER(ALLTRIM(loc_oPagina.txt_4c_Smoeda.Value)), ;
2405:                          "Buscar Moeda (Cr" + CHR(233) + "dito)")
2406:             loc_oBusca.mAddColuna("Cmoes", "", "C" + CHR(243) + "digo")
2407:             loc_oBusca.mAddColuna("Dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
2408:             loc_oBusca.Show()
2409: 
2410:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe2")
2411:                 SELECT cursor_4c_BuscaMoe2
2412:                 loc_oPagina.txt_4c_Smoeda.Value = UPPER(ALLTRIM(cursor_4c_BuscaMoe2.Cmoes))
2413:                 THIS.AtualizarVisibilidadeSCotacao()
2414:             ENDIF
2415: 
2416:             IF USED("cursor_4c_BuscaMoe2")
2417:                 USE IN cursor_4c_BuscaMoe2
2418:             ENDIF
2419:             loc_oBusca.Release()
2420: 
2421:         CATCH TO loc_oErro
2422:             MsgErro("Erro no lookup de SMoeda: " + loc_oErro.Message, "Erro")
2423:         ENDTRY
2424:     ENDPROC
2425: 
2426:     *--------------------------------------------------------------------------
2427:     * AtualizarVisibilidadeSCotacao - Controla visibilidade dos campos de cotacao C
2428:     *--------------------------------------------------------------------------
2429:     PROCEDURE AtualizarVisibilidadeSCotacao()
2430:         LOCAL loc_cSMoeda, loc_lCotas, loc_cSQL
2431:         LOCAL loc_oPagina
2432:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
2433: 
2434:         loc_cSMoeda = UPPER(ALLTRIM(loc_oPagina.txt_4c_Smoeda.Value))
2435:         loc_lCotas  = .F.
2436: 
2437:         IF !EMPTY(loc_cSMoeda) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
2438:             loc_cSQL = "SELECT TOP 1 cotas FROM SigCdMoe WHERE Cmoes = " + EscaparSQL(loc_cSMoeda)
2439:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeS") >= 0
2440:                 IF RECCOUNT("cursor_4c_MoeS") > 0
2441:                     SELECT cursor_4c_MoeS
2442:                     loc_lCotas = NVL(cursor_4c_MoeS.cotas, .F.)
2443:                 ENDIF
2444:                 IF USED("cursor_4c_MoeS")
2445:                     USE IN cursor_4c_MoeS
2446:                 ENDIF
2447:             ENDIF
2448:         ENDIF
2449: 
2450:         loc_oPagina.txt_4c_SCOTACAO.Visible       = loc_lCotas
2451:         loc_oPagina.lbl_4c__sCotacao.Visible      = loc_lCotas
2452:         loc_oPagina.cmd_4c_Alterascotacao.Visible = loc_lCotas AND THIS.this_cModoAtual = "ALTERAR"
2453:     ENDPROC
2454: 
2455:     *==========================================================================
2456:     * HANDLERS DE LOOKUP - JOB
2457:     *==========================================================================
2458: 
2459:     *--------------------------------------------------------------------------
2460:     * JobKeyPress - F4 abre lookup de Job (SigCdCli tipo 10)
2461:     *--------------------------------------------------------------------------
2462:     PROCEDURE JobKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2463:         IF par_nKeyCode = 115    && F4
2464:             THIS.AbrirLookupJob()
2465:         ELSE
2466:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
2467:                 THIS.ValidarJob()
2468:             ENDIF
2469:         ENDIF
2470:     ENDPROC
2471: 
2472:     *--------------------------------------------------------------------------
2473:     * AbrirLookupJob - Lookup de Job (SigCdCli)
2474:     *--------------------------------------------------------------------------
2475:     PROCEDURE AbrirLookupJob()
2476:         LOCAL loc_oBusca, loc_oPagina
2477:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
2478: 
2479:         TRY
2480:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
2481:                          "cursor_4c_BuscaJob", "Iclis", ;
2482:                          ALLTRIM(loc_oPagina.txt_4c_Job.Value), ;
2483:                          "Buscar Job")
2484:             loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
2485:             loc_oBusca.mAddColuna("Rclis", "", "Descri" + CHR(231) + CHR(227) + "o")
2486:             loc_oBusca.Show()
2487: 
2488:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaJob")
2489:                 SELECT cursor_4c_BuscaJob
2490:                 loc_oPagina.txt_4c_Job.Value  = ALLTRIM(cursor_4c_BuscaJob.Iclis)
2491:                 loc_oPagina.txt_4c_DJob.Value = ALLTRIM(cursor_4c_BuscaJob.Rclis)
2492:             ENDIF
2493: 
2494:             IF USED("cursor_4c_BuscaJob")
2495:                 USE IN cursor_4c_BuscaJob
2496:             ENDIF
2497:             loc_oBusca.Release()
2498: 
2499:         CATCH TO loc_oErro
2500:             MsgErro("Erro no lookup de Job: " + loc_oErro.Message, "Erro")
2501:         ENDTRY
2502:     ENDPROC
2503: 
2504:     *--------------------------------------------------------------------------
2505:     * ValidarJob - Valida Job digitado e busca descricao
2506:     *--------------------------------------------------------------------------
2507:     PROCEDURE ValidarJob()
2508:         LOCAL loc_oPagina, loc_cJob, loc_cSQL
2509:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
2510:         loc_cJob    = ALLTRIM(loc_oPagina.txt_4c_Job.Value)
2511: 
2512:         IF EMPTY(loc_cJob)
2513:             loc_oPagina.txt_4c_DJob.Value = ""
2514:             RETURN
2515:         ENDIF
2516: 
2517:         TRY
2518:             loc_cSQL = "SELECT TOP 1 Iclis, Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cJob)
2519: 
2520:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Job") >= 0
2521:                 IF RECCOUNT("cursor_4c_Job") > 0
2522:                     SELECT cursor_4c_Job
2523:                     loc_oPagina.txt_4c_DJob.Value = ALLTRIM(cursor_4c_Job.Rclis)
2524:                 ELSE
2525:                     MsgAviso("Job n" + CHR(227) + "o encontrado: " + loc_cJob)
2526:                     loc_oPagina.txt_4c_Job.Value  = ""
2527:                     loc_oPagina.txt_4c_DJob.Value = ""
2528:                     loc_oPagina.txt_4c_Job.SetFocus()
2529:                 ENDIF
2530:                 IF USED("cursor_4c_Job")
2531:                     USE IN cursor_4c_Job
2532:                 ENDIF
2533:             ENDIF
2534:         CATCH TO loc_oErro
2535:             MsgErro("Erro ao validar Job: " + loc_oErro.Message, "Erro")
2536:         ENDTRY
2537:     ENDPROC
2538: 
2539:     *==========================================================================
2540:     * EVENTO DE GRID
2541:     *==========================================================================
2542: 
2543:     *--------------------------------------------------------------------------
2544:     * GradeAfterRowColChange - Controla visibilidade do botao Anexa
2545:     * Legado: verifica SigCdPgr, SigMvCab, SigCqChm, fChecaAcesso
2546:     *--------------------------------------------------------------------------
2547:     PROCEDURE GradeAfterRowColChange(par_nColIndex)
2548:         LOCAL loc_lMostraAnexa, loc_cEmpr, loc_cDope, loc_nNume
2549:         LOCAL loc_cSQL, loc_nRes
2550:         LOCAL loc_oPagina
2551: 
2552:         loc_lMostraAnexa = .F.
2553:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
2554: 
2555:         TRY
2556:             IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0 AND !EOF("cursor_4c_Dados")
2557:                 SELECT cursor_4c_Dados
2558:                 *-- A visibilidade do Anexa depende de tabelas de outros modulos
2559:                 *-- Simplificado: sempre ocultar (sem acesso a SigCdPgr/SigMvCab/SigCqChm)
2560:                 loc_lMostraAnexa = .F.
2561:             ENDIF
2562:         CATCH TO loc_oErro
2563:             *-- Nao mostrar erro em AfterRowColChange (pode disparar frequentemente)
2564:             loc_lMostraAnexa = .F.
2565:         ENDTRY
2566: 
2567:         loc_oPagina.cmd_4c_Anexa.Visible    = loc_lMostraAnexa
2568:         loc_oPagina.shp_4c_ShpAnexa.Visible = loc_lMostraAnexa
2569:     ENDPROC
2570: 
2571:     *==========================================================================
2572:     * UTILITARIOS
2573:     *==========================================================================
2574: 
2575:     *--------------------------------------------------------------------------
2576:     * AjustarBotoesPorModo - Ajusta visibilidade dos botoes conforme o modo atual
2577:     * Modos: LISTA, INCLUIR, ALTERAR, VISUALIZAR
2578:     *--------------------------------------------------------------------------
2579:     PROTECTED PROCEDURE AjustarBotoesPorModo()
2580:         LOCAL loc_oPg1, loc_oPg2, loc_lEditar
2581:         loc_oPg1   = THIS.pgf_4c_Paginas.Page1
2582:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
2583:         loc_lEditar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2584: 
2585:         *-- Botoes da Page1
2586:         loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = .T.
2587:         loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = .T.
2588:         loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = .T.
2589:         loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = .T.
2590:         loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = .T.
2591:         loc_oPg1.cnt_4c_Saida.cmd_4c_Encerrar.Enabled    = .T.
2592: 
2593:         *-- Botoes da Page2 (Salvar visivel apenas em edicao)
2594:         loc_oPg2.cnt_4c_Salvar.cmd_4c_Salvar.Visible  = loc_lEditar
2595:         loc_oPg2.cnt_4c_Salvar.cmd_4c_Cancelar.Visible = .T.
2596: 
2597:         *-- Botoes de cotacao visiveis apenas em modo ALTERAR
2598:         THIS.AtualizarVisibilidadeCotacao()
2599:         THIS.AtualizarVisibilidadeSCotacao()
2600:     ENDPROC
2601: 
2602:     *--------------------------------------------------------------------------
2603:     * FormatarGridLista - Formata visual do grid da lista
2604:     *--------------------------------------------------------------------------
2605:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
2606:         IF VARTYPE(par_oGrid) != "O"
2607:             RETURN
2608:         ENDIF
2609: 
2610:         par_oGrid.FontName = "Verdana"
2611:         par_oGrid.FontSize = 8
2612:     ENDPROC
2613: 
2614:     *--------------------------------------------------------------------------
2615:     * TornarControlesVisiveis - Torna controles do container visiveis
2616:     *--------------------------------------------------------------------------
2617:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2618:         LOCAL i, loc_oControl
2619: 
2620:         IF VARTYPE(par_oContainer) # "O"
2621:             RETURN
2622:         ENDIF
2623: 
2624:         FOR i = 1 TO par_oContainer.ControlCount
2625:             loc_oControl = par_oContainer.Controls(i)
2626:             *-- Pular containers com nome especifico que devem permanecer ocultos
2627:             IF PEMSTATUS(loc_oControl, "Name", 5) AND ;
2628:                !INLIST(loc_oControl.Name, "cmd_4c_Anexa", "shp_4c_ShpAnexa", ;
2629:                        "txt_4c_COTACAO", "lbl_4c__Cotacao", "cmd_4c_Alteracotacao", ;
2630:                        "txt_4c_SCOTACAO", "lbl_4c__sCotacao", "cmd_4c_Alterascotacao")
2631:                 loc_oControl.Visible = .T.
2632:             ENDIF
2633: 
2634:             IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
2635:                 THIS.TornarControlesVisiveis(loc_oControl)
2636:             ENDIF
2637:         ENDFOR
2638:     ENDPROC
2639: 
2640:     *--------------------------------------------------------------------------
2641:     * Destroy - Limpeza ao fechar formulario
2642:     *--------------------------------------------------------------------------
2643:     PROCEDURE Destroy()
2644:         IF USED("cursor_4c_Dados")
2645:             USE IN cursor_4c_Dados
2646:         ENDIF
2647: 
2648:         IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !ISNULL(THIS.this_oBusinessObject)
2649:             THIS.this_oBusinessObject = .NULL.
2650:         ENDIF
2651: 
2652:         DODEFAULT()
2653:     ENDPROC
2654: 
2655: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigmvccrBO.prg):
*==============================================================================
* sigmvccrBO.prg - Business Object para Movimentos de Conta Corrente Geral
*
* Tabela principal : SigMvCcr
* Chave primaria   : Emps + Nopers (composta)
* Herda de         : BusinessBase
*
* FASE 1/8 - Declaracoes de propriedades e Init()
* Fases seguintes adicionarao: CarregarDoCursor, Inserir, Atualizar,
*   ExecutarExclusao, Buscar, CarregarPorCodigo
*==============================================================================

DEFINE CLASS sigmvccrBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Identificacao da tabela (nomes CORRETOS do BusinessBase)
    *--------------------------------------------------------------------------
    this_cTabela      = "SigMvCcr"
    this_cCampoChave  = "Nopers"

    *--------------------------------------------------------------------------
    * Chave primaria composta: Emps + Nopers
    *--------------------------------------------------------------------------
    this_cEmps        = ""    && C(3)  - Empresa (parte 1 da PK)
    this_nNopers      = 0     && N     - Numero da Operacao (parte 2 da PK)

    *--------------------------------------------------------------------------
    * Operacao e vinculo com outros documentos
    *--------------------------------------------------------------------------
    this_cOpers       = ""    && C(1)  - Tipo: D=Debito / C=Credito
    this_cSopers      = ""    && C(1)  - Contra-operacao: C/D (espelho)
    this_cDopes       = ""    && C     - Tipo documento debito vinculado
    this_nNumes       = 0     && N     - Numero documento debito vinculado
    this_cDopcs       = ""    && C     - Tipo documento credito vinculado
    this_nNumcs       = 0     && N     - Numero documento credito vinculado
    this_cVOpers      = ""    && C     - Vinculo de operacao externa

    *--------------------------------------------------------------------------
    * Datas
    *--------------------------------------------------------------------------
    this_dDatas       = {}    && T     - Data do lancamento
    this_dVencs       = {}    && T     - Data de vencimento
    this_dDtEmiss     = {}    && T     - Data de emissao
    this_dDatAlts     = {}    && T     - Data de alteracao
    this_dDatExcs     = {}    && T     - Data de exclusao

    *--------------------------------------------------------------------------
    * Lado Debito
    *--------------------------------------------------------------------------
    this_cGrupos      = ""    && C     - Grupo debito
    this_cContas      = ""    && C     - Conta debito
    this_cMoedas      = ""    && C     - Moeda debito
    this_nCotacaos    = 0     && N     - Cotacao debito
    this_nValors      = 0     && N     - Valor debito

    *--------------------------------------------------------------------------
    * Lado Credito (S = S-side / contra-partida)
    *--------------------------------------------------------------------------
    this_cSgrupos     = ""    && C     - Grupo credito
    this_cScontas     = ""    && C     - Conta credito
    this_cSmoedas     = ""    && C     - Moeda credito
    this_nScotacaos   = 0     && N     - Cotacao credito
    this_nSvalors     = 0     && N     - Valor credito

    *--------------------------------------------------------------------------
    * Historico e documentacao
    *--------------------------------------------------------------------------
    this_cHists       = ""    && C     - Historico linha 1
    this_cHist2s      = ""    && C     - Historico linha 2
    this_cNotas       = ""    && C     - Numero da nota fiscal
    this_cDocus       = ""    && C     - Numero do documento

    *--------------------------------------------------------------------------
    * Job / Centro de custo
    *--------------------------------------------------------------------------
    this_cJobs        = ""    && C     - Codigo do job (conta tipo 10)

    *--------------------------------------------------------------------------
    * Campos de controle interno
    *--------------------------------------------------------------------------
    this_lAutos       = .F.   && L     - Flag auto-lancamento
    this_cGruconmoes  = ""    && C     - Concatenacao Grupo+Conta+Moeda
    this_cCidchaves   = ""    && C     - Chave unica do registro (gerada por fGerUniqueKey)
    this_cCotUsus     = ""    && C     - Cotacao definida manualmente pelo usuario
    this_nContapgs    = 0     && N     - Opcao Lancar Contas (0=Nao)
    this_nConcs       = 0     && N     - Flag conciliado

    *--------------------------------------------------------------------------
    * Auditoria
    *--------------------------------------------------------------------------
    this_cUsualts     = ""    && C     - Usuario que fez a ultima alteracao
    this_cUsuExcs     = ""    && C     - Usuario que fez a exclusao

    *--------------------------------------------------------------------------
    * Propriedades de exibicao (lookup - nao armazenadas na tabela SigMvCcr)
    *--------------------------------------------------------------------------
    this_cDGrupos     = ""    && C     - Descricao do grupo debito (SigCdGcr)
    this_cDContas     = ""    && C     - Descricao da conta debito
    this_cDSgrupos    = ""    && C     - Descricao do grupo credito (SigCdGcr)
    this_cDScontas    = ""    && C     - Descricao da conta credito
    this_cUsuario     = ""    && C     - Nome/login do usuario logado (exibicao)
    this_cDJobs       = ""    && C     - Descricao do job (conta tipo 10)

    *--------------------------------------------------------------------------
    * Propriedades de filtro para Buscar() - periodo
    *--------------------------------------------------------------------------
    this_dDtInicial   = {}    && D     - Data inicial para filtro de periodo
    this_dDtFinal     = {}    && D     - Data final para filtro de periodo

    *==========================================================================
    * METODOS
    *==========================================================================

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigMvCcr"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Lista movimentos de conta corrente filtrados por periodo e WHERE
    * par_cFiltro: clausula WHERE adicional (ex: "a.Datas BETWEEN '...' AND '...'")
    *              Se vazio, usa this_dDtInicial e this_dDtFinal como filtro
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_cWhere
        LOCAL loc_cDtI, loc_cDtF
        loc_lResultado = .F.

        IF VARTYPE(par_cFiltro) != "C"
            par_cFiltro = ""
        ENDIF

        TRY
            IF !EMPTY(par_cFiltro)
                loc_cWhere = " WHERE " + par_cFiltro
            ELSE
                *-- Usar datas do BO como filtro
                IF !EMPTY(THIS.this_dDtInicial) AND !EMPTY(THIS.this_dDtFinal)
                    loc_cDtI = FormatarDataSQL(THIS.this_dDtInicial)
                    loc_cDtF = FormatarDataSQL(THIS.this_dDtFinal)
                ELSE
                    *-- Padrao: mes atual
                    loc_cDtI = FormatarDataSQL(DATE() - DAY(DATE()) + 1)
                    loc_cDtF = FormatarDataSQL(DATE())
                ENDIF
                loc_cWhere = " WHERE a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                             " AND a.Opers = 'D'" + ;
                             " AND a.Datas BETWEEN " + loc_cDtI + " AND " + loc_cDtF
            ENDIF

            loc_cSQL = "SELECT a.cidchaves, a.nopers, a.opers, a.datas," + ;
                       " a.contas, a.scontas, a.hists, a.hist2s," + ;
                       " a.valors, a.svalors, a.nfs, a.docus," + ;
                       " a.grupos, a.sgrupos, a.moedas, a.smoedas," + ;
                       " a.concs, a.emps, a.vencs, a.cotacaos," + ;
                       " a.scotacaos, a.contapgs, a.jobs, a.dtemis," + ;
                       " a.sopers, a.tipos" + ;
                       " FROM SigMvCcr a" + loc_cWhere + ;
                       " ORDER BY a.datas, a.nopers"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados") >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar movimentos: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Buscar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo cidchaves (chave primaria)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCidchaves)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.cidchaves, a.emps, a.nopers, a.opers, a.sopers," + ;
                       " a.dopes, a.numes, a.dopcs, a.numcs, a.vopers," + ;
                       " a.datas, a.vencs, a.dtemis, a.datalts, a.datexcs," + ;
                       " a.grupos, a.contas, a.moedas, a.cotacaos, a.valors," + ;
                       " a.sgrupos, a.scontas, a.smoedas, a.scotacaos, a.svalors," + ;
                       " a.hists, a.hist2s, a.nfs, a.docus, a.jobs," + ;
                       " a.autos, a.gruconmoes, a.cotusus, a.contapgs, a.concs," + ;
                       " a.usualts, a.usuexcs" + ;
                       " FROM SigMvCcr a" + ;
                       " WHERE a.cidchaves = " + EscaparSQL(par_cCidchaves)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega") >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MsgErro("Erro ao carregar registro: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorCodigo: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Transfere dados do cursor para propriedades do BO
    * OBRIGATORIO: SELECT (par_cAliasCursor) antes de acessar campos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidchaves   = ALLTRIM(TratarNulo(cidchaves,   "C"))
            THIS.this_cEmps        = ALLTRIM(TratarNulo(emps,        "C"))
            THIS.this_nNopers      = TratarNulo(nopers,      "N")
            THIS.this_cOpers       = ALLTRIM(TratarNulo(opers,       "C"))
            THIS.this_cSopers      = ALLTRIM(TratarNulo(sopers,      "C"))
            THIS.this_cDopes       = ALLTRIM(TratarNulo(dopes,       "C"))
            THIS.this_nNumes       = TratarNulo(numes,       "N")
            THIS.this_cDopcs       = ALLTRIM(TratarNulo(dopcs,       "C"))
            THIS.this_nNumcs       = TratarNulo(numcs,       "N")
            THIS.this_cVOpers      = ALLTRIM(TratarNulo(vopers,      "C"))
            THIS.this_dDatas       = TratarNulo(datas,       "D")
            THIS.this_dVencs       = TratarNulo(vencs,       "D")
            THIS.this_dDtEmiss     = TratarNulo(dtemis,      "D")
            THIS.this_dDatAlts     = TratarNulo(datalts,     "D")
            THIS.this_dDatExcs     = TratarNulo(datexcs,     "D")
            THIS.this_cGrupos      = ALLTRIM(TratarNulo(grupos,      "C"))
            THIS.this_cContas      = ALLTRIM(TratarNulo(contas,      "C"))
            THIS.this_cMoedas      = ALLTRIM(TratarNulo(moedas,      "C"))
            THIS.this_nCotacaos    = TratarNulo(cotacaos,    "N")
            THIS.this_nValors      = TratarNulo(valors,      "N")
            THIS.this_cSgrupos     = ALLTRIM(TratarNulo(sgrupos,     "C"))
            THIS.this_cScontas     = ALLTRIM(TratarNulo(scontas,     "C"))
            THIS.this_cSmoedas     = ALLTRIM(TratarNulo(smoedas,     "C"))
            THIS.this_nScotacaos   = TratarNulo(scotacaos,   "N")
            THIS.this_nSvalors     = TratarNulo(svalors,     "N")
            THIS.this_cHists       = ALLTRIM(TratarNulo(hists,       "C"))
            THIS.this_cHist2s      = ALLTRIM(TratarNulo(hist2s,      "C"))
            THIS.this_cNotas       = ALLTRIM(TratarNulo(nfs,         "C"))
            THIS.this_cDocus       = ALLTRIM(TratarNulo(docus,       "C"))
            THIS.this_cJobs        = ALLTRIM(TratarNulo(jobs,        "C"))
            THIS.this_lAutos       = (TratarNulo(autos,      "N") = 1)
            THIS.this_cGruconmoes  = ALLTRIM(TratarNulo(gruconmoes,  "C"))
            THIS.this_cCotUsus     = ALLTRIM(TratarNulo(cotusus,     "C"))
            THIS.this_nContapgs    = TratarNulo(contapgs,    "N")
            THIS.this_nConcs       = TratarNulo(concs,       "N")
            THIS.this_cUsualts     = ALLTRIM(TratarNulo(usualts,     "C"))
            THIS.this_cUsuExcs     = ALLTRIM(TratarNulo(usuexcs,     "C"))
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo movimento de conta corrente
    * Gera nopers sequencial e cidchaves = DTOS(datas)+PADL(nopers,12,'0')
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nNopers, loc_cCidchaves
        LOCAL loc_cDtDados, loc_cDtVencs, loc_cDtEmis, loc_nRes
        loc_lResultado = .F.

        *-- Validacoes fora do TRY
        IF EMPTY(THIS.this_cGrupos) OR EMPTY(THIS.this_cContas)
            MsgErro("Grupo e Conta (D" + CHR(233) + "bito) s" + CHR(227) + "o obrigat" + ;
                    CHR(243) + "rios.", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.this_cSgrupos) OR EMPTY(THIS.this_cScontas)
            MsgErro("Grupo e Conta (Cr" + CHR(233) + "dito) s" + CHR(227) + "o obrigat" + ;
                    CHR(243) + "rios.", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.this_cOpers)
            MsgErro("O tipo de opera" + CHR(231) + CHR(227) + "o (D/C) " + CHR(233) + ;
                    " obrigat" + CHR(243) + "rio.", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            *-- Gerar proximo nopers para a empresa
            loc_cSQL = "SELECT ISNULL(MAX(nopers), 0) + 1 AS proxNopers" + ;
                       " FROM SigMvCcr WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NextNoper") >= 0
                SELECT cursor_4c_NextNoper
                loc_nNopers = cursor_4c_NextNoper.proxNopers
                IF USED("cursor_4c_NextNoper")
                    USE IN cursor_4c_NextNoper
                ENDIF

                *-- Gerar cidchaves: DTOS(datas) + PADL(nopers,12,'0')
                loc_cDtDados = DTOS(IIF(EMPTY(THIS.this_dDatas), DATE(), THIS.this_dDatas))
                loc_cCidchaves = loc_cDtDados + PADL(TRANSFORM(loc_nNopers), 12, "0")
                THIS.this_cCidchaves = loc_cCidchaves
                THIS.this_nNopers    = loc_nNopers

                *-- Formatar datas para SQL
                loc_cDtDados = FormatarDataSQL(THIS.this_dDatas)
                loc_cDtVencs = FormatarDataSQL(THIS.this_dVencs)
                loc_cDtEmis  = FormatarDataSQL(THIS.this_dDtEmiss)

                *-- gruconmoes = grupos + contas + moedas
                THIS.this_cGruconmoes = ALLTRIM(THIS.this_cGrupos) + ;
                                        ALLTRIM(THIS.this_cContas) + ;
                                        ALLTRIM(THIS.this_cMoedas)

                *-- Montar INSERT com todos os campos NOT NULL da tabela
                loc_cSQL = "INSERT INTO SigMvCcr" + ;
                    " (cidchaves, emps, nopers, opers, sopers," + ;
                    " datas, vencs, dtemis," + ;
                    " grupos, contas, moedas, cotacaos, valors," + ;
                    " sgrupos, scontas, smoedas, scotacaos, svalors," + ;
                    " hists, hist2s, nfs, docus, jobs," + ;
                    " contapgs, concs, autos, usualts, usuexcs," + ;
                    " gruconmoes, cotusus, tipos, shists," + ;
                    " dopes, numes, dopcs, numcs, vopers," + ;
                    " contages, contems, saldocs, saldons, saldos," + ;
                    " valliqs, valocurs, valpags, vlancs," + ;
                    " bcontas, bgrupos, borderos, intconts, nlancs, ntrans," + ;
                    " usuconcs, auditors, valprev," + ;
                    " empdopncs, empdopnums, dopotps," + ;
                    " pagos, usupagos, titcancs, usuconfs," + ;
                    " nopercancs, especienfs, impostos, tpimpostos, titpais," + ;
                    " empccs, locals, titbans, titulos, grupages, grupems)" + ;
                    " VALUES (" + ;
                    EscaparSQL(loc_cCidchaves) + "," + ;
                    EscaparSQL(go_4c_Sistema.cCodEmpresa) + "," + ;
                    FormatarNumeroSQL(loc_nNopers) + "," + ;
                    EscaparSQL(THIS.this_cOpers) + "," + ;
                    EscaparSQL(THIS.this_cSopers) + "," + ;
                    loc_cDtDados + "," + loc_cDtVencs + "," + loc_cDtEmis + "," + ;
                    EscaparSQL(THIS.this_cGrupos) + "," + ;
                    EscaparSQL(THIS.this_cContas) + "," + ;
                    EscaparSQL(THIS.this_cMoedas) + "," + ;
                    FormatarNumeroSQL(THIS.this_nCotacaos) + "," + ;
                    FormatarNumeroSQL(THIS.this_nValors) + "," + ;
                    EscaparSQL(THIS.this_cSgrupos) + "," + ;
                    EscaparSQL(THIS.this_cScontas) + "," + ;
                    EscaparSQL(THIS.this_cSmoedas) + "," + ;
                    FormatarNumeroSQL(THIS.this_nScotacaos) + "," + ;
                    FormatarNumeroSQL(THIS.this_nSvalors) + "," + ;
                    EscaparSQL(THIS.this_cHists) + "," + ;
                    EscaparSQL(THIS.this_cHist2s) + "," + ;
                    EscaparSQL(THIS.this_cNotas) + "," + ;
                    EscaparSQL(THIS.this_cDocus) + "," + ;
                    EscaparSQL(THIS.this_cJobs) + "," + ;
                    FormatarNumeroSQL(THIS.this_nContapgs) + "," + ;
                    FormatarNumeroSQL(THIS.this_nConcs) + "," + ;
                    IIF(THIS.this_lAutos, "1", "0") + "," + ;
                    EscaparSQL(gc_4c_UsuarioLogado) + ",''" + "," + ;
                    EscaparSQL(THIS.this_cGruconmoes) + "," + ;
                    EscaparSQL(THIS.this_cCotUsus) + ",''" + "," + ;
                    "''" + "," + ;
                    EscaparSQL(THIS.this_cDopes) + "," + ;
                    FormatarNumeroSQL(THIS.this_nNumes) + "," + ;
                    EscaparSQL(THIS.this_cDopcs) + "," + ;
                    FormatarNumeroSQL(THIS.this_nNumcs) + "," + ;
                    EscaparSQL(THIS.this_cVOpers) + "," + ;
                    "'','',0,0,0," + ;
                    "0,0,0,''" + "," + ;
                    "'','',0,0,0,0," + ;
                    "'','',0," + ;
                    "'','',''" + "," + ;
                    "'','',0,''," + ;
                    "0,'',0,0,''" + "," + ;
                    EscaparSQL(go_4c_Sistema.cCodEmpresa) + ",'','','','','')"

                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nRes >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao inserir movimento: " + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MsgErro("Erro ao gerar n" + CHR(250) + "mero de opera" + CHR(231) + CHR(227) + "o: " + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Inserir: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza movimento de conta corrente existente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nRes
        LOCAL loc_cDtDados, loc_cDtVencs, loc_cDtEmis
        loc_lResultado = .F.

        *-- Validacoes fora do TRY
        IF EMPTY(THIS.this_cCidchaves)
            MsgErro("Chave do registro n" + CHR(227) + "o informada para atualiza" + ;
                    CHR(231) + CHR(227) + "o.", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.this_cGrupos) OR EMPTY(THIS.this_cContas)
            MsgErro("Grupo e Conta (D" + CHR(233) + "bito) s" + CHR(227) + "o obrigat" + ;
                    CHR(243) + "rios.", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            *-- Formatar datas para SQL
            loc_cDtDados = FormatarDataSQL(THIS.this_dDatas)
            loc_cDtVencs = FormatarDataSQL(THIS.this_dVencs)
            loc_cDtEmis  = FormatarDataSQL(THIS.this_dDtEmiss)

            *-- Recalcular gruconmoes
            THIS.this_cGruconmoes = ALLTRIM(THIS.this_cGrupos) + ;
                                    ALLTRIM(THIS.this_cContas) + ;
                                    ALLTRIM(THIS.this_cMoedas)

            loc_cSQL = "UPDATE SigMvCcr SET" + ;
                " opers       = " + EscaparSQL(THIS.this_cOpers) + "," + ;
                " sopers      = " + EscaparSQL(THIS.this_cSopers) + "," + ;
                " datas       = " + loc_cDtDados + "," + ;
                " vencs       = " + loc_cDtVencs + "," + ;
                " dtemis      = " + loc_cDtEmis + "," + ;
                " grupos      = " + EscaparSQL(THIS.this_cGrupos) + "," + ;
                " contas      = " + EscaparSQL(THIS.this_cContas) + "," + ;
                " moedas      = " + EscaparSQL(THIS.this_cMoedas) + "," + ;
                " cotacaos    = " + FormatarNumeroSQL(THIS.this_nCotacaos) + "," + ;
                " valors      = " + FormatarNumeroSQL(THIS.this_nValors) + "," + ;
                " sgrupos     = " + EscaparSQL(THIS.this_cSgrupos) + "," + ;
                " scontas     = " + EscaparSQL(THIS.this_cScontas) + "," + ;
                " smoedas     = " + EscaparSQL(THIS.this_cSmoedas) + "," + ;
                " scotacaos   = " + FormatarNumeroSQL(THIS.this_nScotacaos) + "," + ;
                " svalors     = " + FormatarNumeroSQL(THIS.this_nSvalors) + "," + ;
                " hists       = " + EscaparSQL(THIS.this_cHists) + "," + ;
                " hist2s      = " + EscaparSQL(THIS.this_cHist2s) + "," + ;
                " nfs         = " + EscaparSQL(THIS.this_cNotas) + "," + ;
                " docus       = " + EscaparSQL(THIS.this_cDocus) + "," + ;
                " jobs        = " + EscaparSQL(THIS.this_cJobs) + "," + ;
                " contapgs    = " + FormatarNumeroSQL(THIS.this_nContapgs) + "," + ;
                " cotusus     = " + EscaparSQL(THIS.this_cCotUsus) + "," + ;
                " gruconmoes  = " + EscaparSQL(THIS.this_cGruconmoes) + "," + ;
                " dopes       = " + EscaparSQL(THIS.this_cDopes) + "," + ;
                " numes       = " + FormatarNumeroSQL(THIS.this_nNumes) + "," + ;
                " dopcs       = " + EscaparSQL(THIS.this_cDopcs) + "," + ;
                " numcs       = " + FormatarNumeroSQL(THIS.this_nNumcs) + "," + ;
                " vopers      = " + EscaparSQL(THIS.this_cVOpers) + "," + ;
                " datalts     = GETDATE()," + ;
                " usualts     = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRes >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar movimento: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Atualizar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui movimento: marca DatExcs e deleta o registro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nRes
        loc_lResultado = .F.

        TRY
            *-- Primeiro: marcar data/usuario de exclusao (soft delete marker)
            loc_cSQL = "UPDATE SigMvCcr" + ;
                       " SET datexcs = GETDATE()," + ;
                       " usuexcs = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRes < 0
                MsgErro("Erro ao marcar exclus" + CHR(227) + "o: " + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                *-- Segundo: deletar o registro definitivamente
                loc_cSQL = "DELETE FROM SigMvCcr" + ;
                           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)
                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nRes >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao excluir movimento: " + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ExecutarExclusao: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

