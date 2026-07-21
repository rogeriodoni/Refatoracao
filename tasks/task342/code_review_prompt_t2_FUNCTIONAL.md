# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (4)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_SAIDA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [LAYOUT-POSITION] Controle 'Grupo' (parent: SIGCDACG.Pagina.Dados.Pagina.Cadastro): Top original=8 vs migrado 'lbl_4c_Grupo' Top=126 (diff=118px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Grupo' (parent: SIGCDACG.Pagina.Dados.Pagina.Cadastro): Left original=401 vs migrado 'lbl_4c_Grupo' Left=200 (diff=201px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'NomeCompleto' (parent: SIGCDACG.Pagina.Dados.Pagina.Cadastro): Top original=34 vs migrado 'lbl_4c_NomeCompleto' Top=126 (diff=92px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formacg.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1739 linhas total):

*-- Linhas 32 a 138:
32:     *==========================================================================
33:     * Init
34:     *==========================================================================
35:     PROCEDURE Init()
36:         RETURN DODEFAULT()
37:     ENDPROC
38: 
39:     *==========================================================================
40:     * InicializarForm
41:     *==========================================================================
42:     PROTECTED PROCEDURE InicializarForm()
43:         LOCAL loc_lSucesso
44:         loc_lSucesso = .F.
45:         TRY
46:             THIS.this_oBusinessObject = CREATEOBJECT("acgBO")
47:             IF VARTYPE(THIS.this_oBusinessObject) <> "O" OR ISNULL(THIS.this_oBusinessObject)
48:                 MsgErro("Erro ao criar acgBO", "Erro")
49:             ELSE
50:                 THIS.ConfigurarPageFrame()
51:                 THIS.ConfigurarPaginaLista()
52:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
53:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
54:                 THIS.ConfigurarPaginaDados()
55: 
56:                 IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
57:                     THIS.CarregarLista()
58:                 ENDIF
59: 
60:                 THIS.pgf_4c_Paginas.Visible  = .T.
61:                 THIS.pgf_4c_Paginas.ActivePage = 1
62:                 THIS.this_cModoAtual = "LISTA"
63:                 THIS.AjustarBotoesPorModo()
64:                 loc_lSucesso = .T.
65:             ENDIF
66:         CATCH TO loc_oErro
67:             MsgErro("Erro ao inicializar: " + loc_oErro.Message + ;
68:                 " [" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
69:         ENDTRY
70:         RETURN loc_lSucesso
71:     ENDPROC
72: 
73:     *==========================================================================
74:     * ConfigurarPageFrame
75:     *==========================================================================
76:     PROTECTED PROCEDURE ConfigurarPageFrame()
77:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
78:         WITH THIS.pgf_4c_Paginas
79:             .PageCount = 2
80:             .Top       = -29
81:             .Left      = 0
82:             .Width     = 1000
83:             .Height    = 629
84:             .Tabs      = .F.
85:             .Page1.Caption = "Lista"
86:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
87:             .Page2.Caption = "Dados"
88:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
89:         ENDWITH
90:     ENDPROC
91: 
92:     *==========================================================================
93:     * ConfigurarPaginaLista - Page1: grid de grupos + botoes CRUD
94:     *==========================================================================
95:     PROTECTED PROCEDURE ConfigurarPaginaLista()
96:         LOCAL loc_oP1
97:         loc_oP1 = THIS.pgf_4c_Paginas.Page1
98: 
99:         *-- Cabecalho cinza (sombra + titulo)
100:         loc_oP1.AddObject("cnt_4c_Cabecalho", "Container")
101:         WITH loc_oP1.cnt_4c_Cabecalho
102:             .Top       = 31
103:             .Left      = 0
104:             .Width     = 1000
105:             .Height    = 85
106:             .BackStyle = 1
107:             .BackColor = RGB(215,215,215)
108:             .BorderWidth = 0
109:             .Visible   = .T.
110:         ENDWITH
111:         loc_oP1.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
112:         WITH loc_oP1.cnt_4c_Cabecalho.lbl_4c_Sombra
113:             .Caption   = ""
114:             .Top       = 0
115:             .Left      = 0
116:             .Width     = 1000
117:             .Height    = 85
118:             .AutoSize  = .F.
119:             .BackStyle = 1
120:             .BackColor = RGB(215,215,215)
121:         ENDWITH
122:         loc_oP1.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
123:         WITH loc_oP1.cnt_4c_Cabecalho.lbl_4c_Titulo
124:             .Caption   = "Acesso de Grupos"
125:             .Top       = 30
126:             .Left      = 10
127:             .Width     = 500
128:             .Height    = 25
129:             .AutoSize  = .F.
130:             .FontName  = "Tahoma"
131:             .FontSize  = 14
132:             .FontBold  = .T.
133:             .BackStyle = 0
134:             .ForeColor = RGB(60,60,60)
135:         ENDWITH
136: 
137:         *-- Container botoes CRUD (Incluir, Alterar, Excluir, Buscar, Copiar)
138:         loc_oP1.AddObject("cnt_4c_Botoes", "Container")

*-- Linhas 163 a 416:
163:             .ForeColor       = RGB(90,90,90)
164:             .Visible         = .T.
165:         ENDWITH
166:         BINDEVENT(loc_oP1.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
167: 
168:         loc_oP1.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
169:         WITH loc_oP1.cnt_4c_Botoes.cmd_4c_Alterar
170:             .Caption         = "Alterar"
171:             .Left            = 85
172:             .Top             = 5
173:             .Width           = 75
174:             .Height          = 75
175:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
176:             .PicturePosition = 13
177:             .FontName        = "Tahoma"
178:             .FontSize        = 8
179:             .Themes          = .F.
180:             .SpecialEffect   = 0
181:             .BackColor       = RGB(255,255,255)
182:             .ForeColor       = RGB(90,90,90)
183:             .Visible         = .T.
184:         ENDWITH
185:         BINDEVENT(loc_oP1.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
186: 
187:         loc_oP1.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
188:         WITH loc_oP1.cnt_4c_Botoes.cmd_4c_Excluir
189:             .Caption         = "Excluir"
190:             .Left            = 165
191:             .Top             = 5
192:             .Width           = 75
193:             .Height          = 75
194:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
195:             .PicturePosition = 13
196:             .FontName        = "Tahoma"
197:             .FontSize        = 8
198:             .Themes          = .F.
199:             .SpecialEffect   = 0
200:             .BackColor       = RGB(255,255,255)
201:             .ForeColor       = RGB(90,90,90)
202:             .Visible         = .T.
203:         ENDWITH
204:         BINDEVENT(loc_oP1.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
205: 
206:         loc_oP1.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
207:         WITH loc_oP1.cnt_4c_Botoes.cmd_4c_Buscar
208:             .Caption         = "Buscar"
209:             .Left            = 245
210:             .Top             = 5
211:             .Width           = 75
212:             .Height          = 75
213:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
214:             .PicturePosition = 13
215:             .FontName        = "Tahoma"
216:             .FontSize        = 8
217:             .Themes          = .F.
218:             .SpecialEffect   = 0
219:             .BackColor       = RGB(255,255,255)
220:             .ForeColor       = RGB(90,90,90)
221:             .Visible         = .T.
222:         ENDWITH
223:         BINDEVENT(loc_oP1.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
224: 
225:         loc_oP1.cnt_4c_Botoes.AddObject("cmd_4c_CopiarAcesso", "CommandButton")
226:         WITH loc_oP1.cnt_4c_Botoes.cmd_4c_CopiarAcesso
227:             .Caption         = "Copiar" + CHR(13) + "Acessos"
228:             .Left            = 325
229:             .Top             = 5
230:             .Width           = 75
231:             .Height          = 75
232:             .Picture         = gc_4c_CaminhoIcones + "geral_copiar_26.jpg"
233:             .PicturePosition = 13
234:             .FontName        = "Tahoma"
235:             .FontSize        = 8
236:             .Themes          = .F.
237:             .SpecialEffect   = 0
238:             .BackColor       = RGB(255,255,255)
239:             .ForeColor       = RGB(90,90,90)
240:             .Visible         = .T.
241:         ENDWITH
242:         BINDEVENT(loc_oP1.cnt_4c_Botoes.cmd_4c_CopiarAcesso, "Click", THIS, "BtnCopiarAcessoClick")
243: 
244:         *-- Painel de copia (oculto por padrao - ativado por BtnCopiarAcessoClick)
245:         loc_oP1.AddObject("cnt_4c_PainelCopia", "Container")
246:         WITH loc_oP1.cnt_4c_PainelCopia
247:             .Top       = 29
248:             .Left      = 480
249:             .Width     = 430
250:             .Height    = 85
251:             .BackStyle = 1
252:             .BackColor = RGB(235,235,255)
253:             .BorderWidth = 1
254:             .Visible   = .F.
255:         ENDWITH
256:         loc_oP1.cnt_4c_PainelCopia.AddObject("lbl_4c_CopiarDe", "Label")
257:         WITH loc_oP1.cnt_4c_PainelCopia.lbl_4c_CopiarDe
258:             .Caption   = "Copiar do Grupo:"
259:             .Top       = 10
260:             .Left      = 10
261:             .Width     = 120
262:             .Height    = 17
263:             .AutoSize  = .F.
264:             .FontName  = "Tahoma"
265:             .FontSize  = 8
266:             .BackStyle = 0
267:             .ForeColor = RGB(60,60,60)
268:         ENDWITH
269:         loc_oP1.cnt_4c_PainelCopia.AddObject("txt_4c_GrupoOrigem", "TextBox")
270:         WITH loc_oP1.cnt_4c_PainelCopia.txt_4c_GrupoOrigem
271:             .Top           = 30
272:             .Left          = 10
273:             .Width         = 120
274:             .Height        = 23
275:             .MaxLength     = 10
276:             .Value         = ""
277:             .FontName      = "Tahoma"
278:             .FontSize      = 8
279:             .BorderStyle   = 1
280:             .SpecialEffect = 1
281:             .BackColor     = RGB(255,255,255)
282:         ENDWITH
283:         BINDEVENT(loc_oP1.cnt_4c_PainelCopia.txt_4c_GrupoOrigem, "KeyPress", THIS, "TxtGrupoOrigemValid")
284:         loc_oP1.cnt_4c_PainelCopia.AddObject("cmd_4c_CopiarOk", "CommandButton")
285:         WITH loc_oP1.cnt_4c_PainelCopia.cmd_4c_CopiarOk
286:             .Caption = "Copiar"
287:             .Left    = 145
288:             .Top     = 18
289:             .Width   = 75
290:             .Height  = 50
291:             .FontName = "Tahoma"
292:             .FontSize = 8
293:             .Themes  = .T.
294:             .Visible = .T.
295:         ENDWITH
296:         BINDEVENT(loc_oP1.cnt_4c_PainelCopia.cmd_4c_CopiarOk, "Click", THIS, "BtnCopiarOkClick")
297:         loc_oP1.cnt_4c_PainelCopia.AddObject("cmd_4c_CopiarCancelar", "CommandButton")
298:         WITH loc_oP1.cnt_4c_PainelCopia.cmd_4c_CopiarCancelar
299:             .Caption = "Cancelar"
300:             .Left    = 235
301:             .Top     = 18
302:             .Width   = 75
303:             .Height  = 50
304:             .FontName = "Tahoma"
305:             .FontSize = 8
306:             .Themes  = .T.
307:             .Visible = .T.
308:         ENDWITH
309:         BINDEVENT(loc_oP1.cnt_4c_PainelCopia.cmd_4c_CopiarCancelar, "Click", THIS, "BtnCopiarCancelarClick")
310: 
311:         *-- Container Saida canonico (Left=917, Width=90)
312:         loc_oP1.AddObject("cnt_4c_Saida", "Container")
313:         WITH loc_oP1.cnt_4c_Saida
314:             .Top       = 29
315:             .Left      = 917
316:             .Width     = 90
317:             .Height    = 85
318:             .BackStyle = 0
319:             .BorderWidth = 0
320:             .Visible   = .T.
321:         ENDWITH
322:         loc_oP1.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
323:         WITH loc_oP1.cnt_4c_Saida.cmd_4c_Encerrar
324:             .Caption         = "Encerrar"
325:             .Left            = 5
326:             .Top             = 5
327:             .Width           = 75
328:             .Height          = 75
329:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
330:             .PicturePosition = 13
331:             .FontName        = "Tahoma"
332:             .FontSize        = 8
333:             .Themes          = .F.
334:             .SpecialEffect   = 0
335:             .BackColor       = RGB(255,255,255)
336:             .ForeColor       = RGB(90,90,90)
337:             .Visible         = .T.
338:         ENDWITH
339:         BINDEVENT(loc_oP1.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
340: 
341:         *-- Grid principal
342:         loc_oP1.AddObject("grd_4c_Lista", "Grid")
343:         WITH loc_oP1.grd_4c_Lista
344:             .Top             = 121
345:             .Left            = 12
346:             .Width           = 976
347:             .Height          = 455
348:             .ColumnCount     = 2
349:             .RecordSourceType = 1
350:             .ReadOnly        = .T.
351:             .DeleteMark      = .F.
352:             .RecordMark      = .F.
353:             .ScrollBars      = 3
354:             .GridLines       = 3
355:             .AllowHeaderSizing = .T.
356:             .FontName        = "Tahoma"
357:             .FontSize        = 8
358:             .GridLineColor   = RGB(238,238,238)
359:             .Visible         = .T.
360:             .Column1.Width   = 120
361:             .Column1.Header1.Caption = ""
362:             .Column2.Width   = 500
363:             .Column2.Header1.Caption = ""
364:         ENDWITH
365: 
366:         THIS.TornarControlesVisiveis(loc_oP1)
367:         loc_oP1.cnt_4c_PainelCopia.Visible = .F.
368:     ENDPROC
369: 
370:     *==========================================================================
371:     * ConfigurarPaginaDados - Page2: campos + 4 abas internas
372:     *==========================================================================
373:     PROTECTED PROCEDURE ConfigurarPaginaDados()
374:         LOCAL loc_oP2
375:         loc_oP2 = THIS.pgf_4c_Paginas.Page2
376: 
377:         *-- Cabecalho cinza
378:         loc_oP2.AddObject("cnt_4c_Cabecalho", "Container")
379:         WITH loc_oP2.cnt_4c_Cabecalho
380:             .Top       = 29
381:             .Left      = 0
382:             .Width     = 1000
383:             .Height    = 85
384:             .BackStyle = 1
385:             .BackColor = RGB(215,215,215)
386:             .BorderWidth = 0
387:             .Visible   = .T.
388:         ENDWITH
389:         loc_oP2.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
390:         WITH loc_oP2.cnt_4c_Cabecalho.lbl_4c_Sombra
391:             .Caption   = ""
392:             .Top       = 0
393:             .Left      = 0
394:             .Width     = 1000
395:             .Height    = 85
396:             .AutoSize  = .F.
397:             .BackStyle = 1
398:             .BackColor = RGB(215,215,215)
399:         ENDWITH
400:         loc_oP2.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
401:         WITH loc_oP2.cnt_4c_Cabecalho.lbl_4c_Titulo
402:             .Caption   = "Acesso de Grupos - Dados"
403:             .Top       = 30
404:             .Left      = 10
405:             .Width     = 500
406:             .Height    = 25
407:             .AutoSize  = .F.
408:             .FontName  = "Tahoma"
409:             .FontSize  = 14
410:             .FontBold  = .T.
411:             .BackStyle = 0
412:             .ForeColor = RGB(60,60,60)
413:         ENDWITH
414: 
415:         *-- Botoes Salvar/Cancelar (sobrepostos ao cabecalho, lado direito)
416:         loc_oP2.AddObject("cnt_4c_BotoesDados", "Container")

*-- Linhas 440 a 501:
440:             .ForeColor       = RGB(90,90,90)
441:             .Visible         = .T.
442:         ENDWITH
443:         BINDEVENT(loc_oP2.cnt_4c_BotoesDados.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")
444:         loc_oP2.cnt_4c_BotoesDados.AddObject("cmd_4c_Cancelar", "CommandButton")
445:         WITH loc_oP2.cnt_4c_BotoesDados.cmd_4c_Cancelar
446:             .Caption         = "Encerrar"
447:             .Left            = 85
448:             .Top             = 5
449:             .Width           = 75
450:             .Height          = 75
451:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
452:             .PicturePosition = 13
453:             .FontName        = "Tahoma"
454:             .FontSize        = 8
455:             .Themes          = .F.
456:             .SpecialEffect   = 0
457:             .BackColor       = RGB(255,255,255)
458:             .ForeColor       = RGB(90,90,90)
459:             .Visible         = .T.
460:         ENDWITH
461:         BINDEVENT(loc_oP2.cnt_4c_BotoesDados.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
462: 
463:         *-- Campo Grupo
464:         loc_oP2.AddObject("lbl_4c_Grupo", "Label")
465:         WITH loc_oP2.lbl_4c_Grupo
466:             .Caption   = "Grupo:"
467:             .Top       = 126
468:             .Left      = 200
469:             .Width     = 50
470:             .Height    = 17
471:             .AutoSize  = .F.
472:             .FontName  = "Tahoma"
473:             .FontSize  = 8
474:             .BackStyle = 0
475:             .ForeColor = RGB(60,60,60)
476:             .Alignment = 1
477:         ENDWITH
478:         loc_oP2.AddObject("txt_4c_Grupo", "TextBox")
479:         WITH loc_oP2.txt_4c_Grupo
480:             .Top           = 122
481:             .Left          = 255
482:             .Width         = 100
483:             .Height        = 23
484:             .MaxLength     = 10
485:             .Value         = ""
486:             .FontName      = "Tahoma"
487:             .FontSize      = 8
488:             .BorderStyle   = 1
489:             .SpecialEffect = 1
490:             .BackColor     = RGB(255,255,255)
491:             .ForeColor     = RGB(0,0,0)
492:             .Visible       = .T.
493:         ENDWITH
494: 
495:         *-- Campo NomeCompleto
496:         loc_oP2.AddObject("lbl_4c_NomeCompleto", "Label")
497:         WITH loc_oP2.lbl_4c_NomeCompleto
498:             .Caption   = "Nome:"
499:             .Top       = 126
500:             .Left      = 375
501:             .Width     = 45

*-- Linhas 545 a 910:
545:         THIS.ConfigurarAbaBarra()
546:         THIS.ConfigurarPgPage1()
547: 
548:         THIS.TornarControlesVisiveis(loc_oP2)
549:     ENDPROC
550: 
551:     *==========================================================================
552:     * ConfigurarAbaUsuarios - Page1 interna: listboxes de usuarios
553:     *==========================================================================
554:     PROTECTED PROCEDURE ConfigurarAbaUsuarios()
555:         LOCAL loc_oAba
556:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
557: 
558:         loc_oAba.AddObject("lbl_4c_Disponiveis", "Label")
559:         WITH loc_oAba.lbl_4c_Disponiveis
560:             .Caption  = "Usu" + CHR(225) + "rios Dispon" + CHR(237) + "veis"
561:             .Top      = 8
562:             .Left     = 80
563:             .Width    = 200
564:             .Height   = 17
565:             .AutoSize = .F.
566:             .FontName = "Tahoma"
567:             .FontSize = 8
568:             .FontBold = .T.
569:             .BackStyle = 0
570:             .ForeColor = RGB(60,60,60)
571:         ENDWITH
572: 
573:         loc_oAba.AddObject("lbx_4c_Disponiveis", "ListBox")
574:         WITH loc_oAba.lbx_4c_Disponiveis
575:             .Top           = 28
576:             .Left          = 80
577:             .Width         = 200
578:             .Height        = 350
579:             .MultiSelect   = .T.
580:             .RowSourceType = 0
581:             .FontName      = "Tahoma"
582:             .FontSize      = 8
583:             .Visible       = .T.
584:         ENDWITH
585:         BINDEVENT(loc_oAba.lbx_4c_Disponiveis, "Click", THIS, "LbxDisponiveisClick")
586: 
587:         loc_oAba.AddObject("lbl_4c_Label3", "Label")
588:         WITH loc_oAba.lbl_4c_Label3
589:             .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
590:             .Top       = 426
591:             .Left      = 327
592:             .Width     = 60
593:             .Height    = 15
594:             .AutoSize  = .F.
595:             .FontName  = "Tahoma"
596:             .FontSize  = 8
597:             .BackStyle = 0
598:             .ForeColor = RGB(60,60,60)
599:         ENDWITH
600: 
601:         loc_oAba.AddObject("lbl_4c_StatusDisp", "Label")
602:         WITH loc_oAba.lbl_4c_StatusDisp
603:             .Caption   = ""
604:             .Top       = 382
605:             .Left      = 143
606:             .Width     = 120
607:             .Height    = 17
608:             .AutoSize  = .F.
609:             .FontName  = "Tahoma"
610:             .FontSize  = 8
611:             .BackStyle = 0
612:             .ForeColor = RGB(0,128,0)
613:         ENDWITH
614: 
615:         *-- Botoes de transferencia
616:         loc_oAba.AddObject("cmd_4c_AddUsu", "CommandButton")
617:         WITH loc_oAba.cmd_4c_AddUsu
618:             .Caption     = CHR(187)
619:             .Top         = 75
620:             .Left        = 295
621:             .Width       = 45
622:             .Height      = 30
623:             .FontName    = "Tahoma"
624:             .FontSize    = 10
625:             .FontBold    = .T.
626:             .Themes      = .T.
627:             .Visible     = .T.
628:             .ToolTipText = "Adicionar selecionados"
629:         ENDWITH
630:         BINDEVENT(loc_oAba.cmd_4c_AddUsu, "Click", THIS, "BtnAddUsuClick")
631: 
632:         loc_oAba.AddObject("cmd_4c_AddAllUsu", "CommandButton")
633:         WITH loc_oAba.cmd_4c_AddAllUsu
634:             .Caption     = CHR(187) + CHR(187)
635:             .Top         = 120
636:             .Left        = 295
637:             .Width       = 45
638:             .Height      = 30
639:             .FontName    = "Tahoma"
640:             .FontSize    = 10
641:             .FontBold    = .T.
642:             .Themes      = .T.
643:             .Visible     = .T.
644:             .ToolTipText = "Adicionar todos"
645:         ENDWITH
646:         BINDEVENT(loc_oAba.cmd_4c_AddAllUsu, "Click", THIS, "BtnAddAllUsuClick")
647: 
648:         loc_oAba.AddObject("cmd_4c_RemUsu", "CommandButton")
649:         WITH loc_oAba.cmd_4c_RemUsu
650:             .Caption     = CHR(171)
651:             .Top         = 170
652:             .Left        = 295
653:             .Width       = 45
654:             .Height      = 30
655:             .FontName    = "Tahoma"
656:             .FontSize    = 10
657:             .FontBold    = .T.
658:             .Themes      = .T.
659:             .Visible     = .T.
660:             .ToolTipText = "Remover selecionados"
661:         ENDWITH
662:         BINDEVENT(loc_oAba.cmd_4c_RemUsu, "Click", THIS, "BtnRemUsuClick")
663: 
664:         loc_oAba.AddObject("cmd_4c_RemAllUsu", "CommandButton")
665:         WITH loc_oAba.cmd_4c_RemAllUsu
666:             .Caption     = CHR(171) + CHR(171)
667:             .Top         = 215
668:             .Left        = 295
669:             .Width       = 45
670:             .Height      = 30
671:             .FontName    = "Tahoma"
672:             .FontSize    = 10
673:             .FontBold    = .T.
674:             .Themes      = .T.
675:             .Visible     = .T.
676:             .ToolTipText = "Remover todos"
677:         ENDWITH
678:         BINDEVENT(loc_oAba.cmd_4c_RemAllUsu, "Click", THIS, "BtnRemAllUsuClick")
679: 
680:         loc_oAba.AddObject("lbl_4c_Selecionados", "Label")
681:         WITH loc_oAba.lbl_4c_Selecionados
682:             .Caption  = "Usu" + CHR(225) + "rios do Grupo"
683:             .Top      = 8
684:             .Left     = 356
685:             .Width    = 200
686:             .Height   = 17
687:             .AutoSize = .F.
688:             .FontName = "Tahoma"
689:             .FontSize = 8
690:             .FontBold = .T.
691:             .BackStyle = 0
692:             .ForeColor = RGB(60,60,60)
693:         ENDWITH
694: 
695:         loc_oAba.AddObject("lbx_4c_Selecionados", "ListBox")
696:         WITH loc_oAba.lbx_4c_Selecionados
697:             .Top           = 28
698:             .Left          = 356
699:             .Width         = 200
700:             .Height        = 350
701:             .MultiSelect   = .T.
702:             .RowSourceType = 0
703:             .FontName      = "Tahoma"
704:             .FontSize      = 8
705:             .Visible       = .T.
706:         ENDWITH
707:         BINDEVENT(loc_oAba.lbx_4c_Selecionados, "Click", THIS, "LbxSelecionadosClick")
708: 
709:         loc_oAba.AddObject("lbl_4c_Label5", "Label")
710:         WITH loc_oAba.lbl_4c_Label5
711:             .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
712:             .Top       = 426
713:             .Left      = 529
714:             .Width     = 60
715:             .Height    = 15
716:             .AutoSize  = .F.
717:             .FontName  = "Tahoma"
718:             .FontSize  = 8
719:             .BackStyle = 0
720:             .ForeColor = RGB(60,60,60)
721:         ENDWITH
722: 
723:         loc_oAba.AddObject("lbl_4c_StatusSel", "Label")
724:         WITH loc_oAba.lbl_4c_StatusSel
725:             .Caption   = ""
726:             .Top       = 382
727:             .Left      = 419
728:             .Width     = 120
729:             .Height    = 17
730:             .AutoSize  = .F.
731:             .FontName  = "Tahoma"
732:             .FontSize  = 8
733:             .BackStyle = 0
734:             .ForeColor = RGB(0,128,0)
735:         ENDWITH
736:     ENDPROC
737: 
738:     *==========================================================================
739:     * ConfigurarAbaProgramas - Page2 interna: grid de programas com checkbox
740:     *==========================================================================
741:     PROTECTED PROCEDURE ConfigurarAbaProgramas()
742:         LOCAL loc_oAba, loc_oGrid
743:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2
744: 
745:         loc_oAba.AddObject("lbl_4c_FiltroAcesso", "Label")
746:         WITH loc_oAba.lbl_4c_FiltroAcesso
747:             .Caption   = "Filtro:"
748:             .Top       = 10
749:             .Left      = 10
750:             .Width     = 45
751:             .Height    = 17
752:             .AutoSize  = .F.
753:             .FontName  = "Tahoma"
754:             .FontSize  = 8
755:             .BackStyle = 0
756:             .ForeColor = RGB(60,60,60)
757:         ENDWITH
758:         loc_oAba.AddObject("txt_4c_FiltroAcesso", "TextBox")
759:         WITH loc_oAba.txt_4c_FiltroAcesso
760:             .Top           = 7
761:             .Left          = 60
762:             .Width         = 300
763:             .Height        = 23
764:             .Value         = ""
765:             .FontName      = "Tahoma"
766:             .FontSize      = 8
767:             .BorderStyle   = 1
768:             .SpecialEffect = 1
769:             .BackColor     = RGB(255,255,255)
770:         ENDWITH
771:         BINDEVENT(loc_oAba.txt_4c_FiltroAcesso, "LostFocus", THIS, "TxtFiltroAcessoValid")
772: 
773:         loc_oAba.AddObject("grd_4c_Programas", "Grid")
774:         loc_oGrid = loc_oAba.grd_4c_Programas
775:         WITH loc_oGrid
776:             .Top              = 35
777:             .Left             = 5
778:             .Width            = 990
779:             .Height           = 400
780:             .ColumnCount      = 4
781:             .RecordSourceType = 1
782:             .ReadOnly         = .F.
783:             .DeleteMark       = .F.
784:             .RecordMark       = .F.
785:             .ScrollBars       = 3
786:             .GridLines        = 3
787:             .AllowHeaderSizing = .T.
788:             .FontName         = "Tahoma"
789:             .FontSize         = 8
790:             .GridLineColor    = RGB(238,238,238)
791:             .Visible          = .T.
792:             .Column1.Width    = 380
793:             .Column1.ReadOnly = .T.
794:             .Column1.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
795:             .Column2.Width    = 120
796:             .Column2.ReadOnly = .T.
797:             .Column2.Header1.Caption = "Programa"
798:             .Column3.Width    = 65
799:             .Column3.ReadOnly = .F.
800:             .Column3.Sparse   = .F.
801:             .Column3.Header1.Caption = ""
802:             .Column4.Width    = 120
803:             .Column4.ReadOnly = .T.
804:             .Column4.Header1.Caption = "Parametro"
805:         ENDWITH
806:         WITH loc_oGrid.Column3
807:             .AddObject("chk_4c_Marcas", "CheckBox")
808:         ENDWITH
809:         WITH loc_oGrid.Column3.chk_4c_Marcas
810:             .Caption   = ""
811:             .Width     = 60
812:             .Height    = 17
813:             .BackStyle = 0
814:             .Themes    = .F.
815:         ENDWITH
816:         BINDEVENT(loc_oGrid.Column3.chk_4c_Marcas, "When", THIS, "ChkMarcasWhen")
817:     ENDPROC
818: 
819:     *==========================================================================
820:     * ConfigurarAbaBarra - Page3 interna: grid barra de ferramentas
821:     *==========================================================================
822:     PROTECTED PROCEDURE ConfigurarAbaBarra()
823:         LOCAL loc_oAba, loc_oGrid
824:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3
825: 
826:         loc_oAba.AddObject("grd_4c_Barra", "Grid")
827:         loc_oGrid = loc_oAba.grd_4c_Barra
828:         WITH loc_oGrid
829:             .Top              = 10
830:             .Left             = 5
831:             .Width            = 990
832:             .Height           = 430
833:             .ColumnCount      = 2
834:             .RecordSourceType = 1
835:             .ReadOnly         = .F.
836:             .DeleteMark       = .F.
837:             .RecordMark       = .F.
838:             .ScrollBars       = 3
839:             .GridLines        = 3
840:             .AllowHeaderSizing = .T.
841:             .FontName         = "Tahoma"
842:             .FontSize         = 8
843:             .GridLineColor    = RGB(238,238,238)
844:             .Visible          = .T.
845:             .Column1.Width    = 550
846:             .Column1.ReadOnly = .T.
847:             .Column1.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
848:             .Column2.Width    = 80
849:             .Column2.ReadOnly = .F.
850:             .Column2.Sparse   = .F.
851:             .Column2.Header1.Caption = ""
852:         ENDWITH
853:         WITH loc_oGrid.Column2
854:             .AddObject("chk_4c_SelBarras", "CheckBox")
855:         ENDWITH
856:         WITH loc_oGrid.Column2.chk_4c_SelBarras
857:             .Caption   = ""
858:             .Width     = 75
859:             .Height    = 17
860:             .BackStyle = 0
861:             .Themes    = .F.
862:         ENDWITH
863:         BINDEVENT(loc_oGrid.Column2.chk_4c_SelBarras, "When", THIS, "ChkSelBarrasWhen")
864:     ENDPROC
865: 
866:     *==========================================================================
867:     * ConfigurarPgPage1 - Page4 interna: grid "Acesso Tela" com ComboBox Status
868:     * Corresponde a SIGCDACG.Pagina.Dados.Pagina.Page1 (caption "Acesso Tela")
869:     *==========================================================================
870:     PROTECTED PROCEDURE ConfigurarPgPage1()
871:         LOCAL loc_oAba, loc_oGrid
872:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page4
873: 
874:         loc_oAba.AddObject("grd_4c_Telas", "Grid")
875:         loc_oGrid = loc_oAba.grd_4c_Telas
876:         WITH loc_oGrid
877:             .Top               = 26
878:             .Left              = 13
879:             .Width             = 969
880:             .Height            = 414
881:             .ColumnCount       = 3
882:             .RecordSourceType  = 1
883:             .ReadOnly          = .F.
884:             .DeleteMark        = .F.
885:             .RecordMark        = .F.
886:             .ScrollBars        = 2
887:             .GridLines         = 3
888:             .AllowHeaderSizing = .F.
889:             .AllowRowSizing    = .F.
890:             .FontName          = "Tahoma"
891:             .FontSize          = 8
892:             .GridLineColor     = RGB(238,238,238)
893:             .RowHeight         = 16
894:             .Visible           = .T.
895:             .Column1.Width     = 360
896:             .Column1.ReadOnly  = .T.
897:             .Column1.Header1.Caption = "Tela"
898:             .Column2.Width     = 360
899:             .Column2.ReadOnly  = .T.
900:             .Column2.Header1.Caption = "Campo"
901:             .Column3.Width     = 168
902:             .Column3.ReadOnly  = .F.
903:             .Column3.Sparse    = .F.
904:             .Column3.Header1.Caption = "Status"
905:         ENDWITH
906:         WITH loc_oGrid.Column3
907:             .AddObject("cbo_4c_CmbStatus", "ComboBox")
908:         ENDWITH
909:         WITH loc_oGrid.Column3.cbo_4c_CmbStatus
910:             .RowSourceType = 1

*-- Linhas 919 a 1277:
919:             .FontName      = "Tahoma"
920:             .FontSize      = 8
921:         ENDWITH
922:         BINDEVENT(loc_oGrid.Column3.cbo_4c_CmbStatus, "When", THIS, "ChkStatusWhen")
923:     ENDPROC
924: 
925:     *==========================================================================
926:     * CarregarLista - Carrega cursor_4c_Dados e vincula ao grd_4c_Lista
927:     *==========================================================================
928:     PROCEDURE CarregarLista()
929:         LOCAL loc_lSucesso, loc_oGrid
930:         loc_lSucesso = .F.
931:         TRY
932:             IF THIS.this_oBusinessObject.Buscar("")
933:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
934:                 loc_oGrid.ColumnCount = 2
935:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
936:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Grupos"
937:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.NComps"
938:                 loc_oGrid.Column1.Header1.Caption = ""
939:                 loc_oGrid.Column2.Header1.Caption = ""
940:                 loc_oGrid.Column1.Width = 120
941:                 loc_oGrid.Column2.Width = 500
942:                 loc_oGrid.FontName = "Tahoma"
943:                 loc_oGrid.FontSize = 8
944:                 loc_oGrid.Refresh()
945:                 loc_lSucesso = .T.
946:             ENDIF
947:         CATCH TO loc_oErro
948:             MsgErro("Erro ao carregar lista: " + loc_oErro.Message, "Erro")
949:         ENDTRY
950:         RETURN loc_lSucesso
951:     ENDPROC
952: 
953:     *==========================================================================
954:     * CarregarDadosGrupo - Carrega todas as 4 abas para o grupo
955:     *==========================================================================
956:     PROCEDURE CarregarDadosGrupo(par_cGrupos)
957:         LOCAL loc_lSucesso
958:         loc_lSucesso = .F.
959:         TRY
960:             THIS.CarregarUsuariosAbas(par_cGrupos)
961:             THIS.CarregarProgramasAba(par_cGrupos)
962:             THIS.CarregarBarraAba(par_cGrupos)
963:             THIS.CarregarTelasAba(par_cGrupos)
964:             loc_lSucesso = .T.
965:         CATCH TO loc_oErro
966:             MsgErro("Erro ao carregar dados do grupo: " + loc_oErro.Message, "Erro")
967:         ENDTRY
968:         RETURN loc_lSucesso
969:     ENDPROC
970: 
971:     *==========================================================================
972:     * CarregarUsuariosAbas - Preenche as duas listboxes de usuarios
973:     *==========================================================================
974:     PROCEDURE CarregarUsuariosAbas(par_cGrupos)
975:         LOCAL loc_oAba, loc_lNovoGrupo, loc_cUsu, loc_lNaGrupo
976:         TRY
977:             loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
978:             loc_oAba.lbx_4c_Disponiveis.Clear()
979:             loc_oAba.lbx_4c_Selecionados.Clear()
980:             loc_oAba.lbl_4c_StatusDisp.Caption = ""
981:             loc_oAba.lbl_4c_StatusSel.Caption  = ""
982: 
983:             loc_lNovoGrupo = EMPTY(ALLTRIM(par_cGrupos))
984: 
985:             *-- Carregar usuarios do grupo (se grupo existente)
986:             IF !loc_lNovoGrupo
987:                 THIS.this_oBusinessObject.CarregarUsuariosDoGrupo(par_cGrupos)
988:             ENDIF
989: 
990:             *-- Carregar todos os usuarios do sistema
991:             IF THIS.this_oBusinessObject.BuscarTodosUsuarios() AND USED("cursor_4c_TodosUsuarios")
992:                 SELECT cursor_4c_TodosUsuarios
993:                 GO TOP
994:                 SCAN
995:                     loc_cUsu = ALLTRIM(Usuarios)
996:                     loc_lNaGrupo = .F.
997:                     IF !loc_lNovoGrupo AND USED("cursor_4c_UsuariosGrupo")
998:                         SELECT cursor_4c_UsuariosGrupo
999:                         LOCATE FOR ALLTRIM(Usuarios) == m.loc_cUsu
1000:                         IF !EOF()
1001:                             loc_lNaGrupo = .T.
1002:                         ENDIF
1003:                     ENDIF
1004:                     SELECT cursor_4c_TodosUsuarios
1005:                     IF loc_lNaGrupo
1006:                         loc_oAba.lbx_4c_Selecionados.AddItem(loc_cUsu)
1007:                     ELSE
1008:                         loc_oAba.lbx_4c_Disponiveis.AddItem(loc_cUsu)
1009:                     ENDIF
1010:                 ENDSCAN
1011:             ENDIF
1012:         CATCH TO loc_oErro
1013:             MsgErro("Erro ao carregar usu" + CHR(225) + "rios: " + loc_oErro.Message, "Erro")
1014:         ENDTRY
1015:     ENDPROC
1016: 
1017:     *==========================================================================
1018:     * CarregarProgramasAba - Vincula cursor_4c_Programas ao grd_4c_Programas
1019:     *==========================================================================
1020:     PROCEDURE CarregarProgramasAba(par_cGrupos)
1021:         LOCAL loc_oGrid
1022:         TRY
1023:             IF THIS.this_oBusinessObject.CarregarProgramas(par_cGrupos)
1024:                 THIS.this_cFiltroPrograma = ""
1025:                 IF USED("cursor_4c_Programas")
1026:                     SELECT cursor_4c_Programas
1027:                     SET FILTER TO
1028:                 ENDIF
1029:                 loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2.grd_4c_Programas
1030:                 loc_oGrid.ColumnCount = 4
1031:                 loc_oGrid.RecordSource = "cursor_4c_Programas"
1032:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Programas.Descricaos"
1033:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Programas.Programas"
1034:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Programas.Marcas"
1035:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Programas.Parametros"
1036:                 loc_oGrid.Column1.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1037:                 loc_oGrid.Column2.Header1.Caption = "Programa"
1038:                 loc_oGrid.Column3.Header1.Caption = ""
1039:                 loc_oGrid.Column4.Header1.Caption = "Parametro"
1040:                 loc_oGrid.Column1.Width = 380
1041:                 loc_oGrid.Column2.Width = 120
1042:                 loc_oGrid.Column3.Width = 65
1043:                 loc_oGrid.Column4.Width = 120
1044:                 loc_oGrid.FontName = "Tahoma"
1045:                 loc_oGrid.FontSize = 8
1046:                 loc_oGrid.Refresh()
1047:             ENDIF
1048:         CATCH TO loc_oErro
1049:             MsgErro("Erro ao carregar programas: " + loc_oErro.Message, "Erro")
1050:         ENDTRY
1051:     ENDPROC
1052: 
1053:     *==========================================================================
1054:     * CarregarBarraAba - Vincula TmpBarra ao grd_4c_Barra
1055:     *==========================================================================
1056:     PROCEDURE CarregarBarraAba(par_cGrupos)
1057:         LOCAL loc_oGrid
1058:         TRY
1059:             IF THIS.this_oBusinessObject.CarregarBarra(par_cGrupos)
1060:                 loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3.grd_4c_Barra
1061:                 loc_oGrid.ColumnCount = 2
1062:                 loc_oGrid.RecordSource = "TmpBarra"
1063:                 loc_oGrid.Column1.ControlSource = "TmpBarra.Descricaos"
1064:                 loc_oGrid.Column2.ControlSource = "TmpBarra.SelBarras"
1065:                 loc_oGrid.Column1.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1066:                 loc_oGrid.Column2.Header1.Caption = ""
1067:                 loc_oGrid.Column1.Width = 550
1068:                 loc_oGrid.Column2.Width = 80
1069:                 loc_oGrid.FontName = "Tahoma"
1070:                 loc_oGrid.FontSize = 8
1071:                 loc_oGrid.Refresh()
1072:             ENDIF
1073:         CATCH TO loc_oErro
1074:             MsgErro("Erro ao carregar barra: " + loc_oErro.Message, "Erro")
1075:         ENDTRY
1076:     ENDPROC
1077: 
1078:     *==========================================================================
1079:     * CarregarTelasAba - Vincula crSigAcTel ao grd_4c_Telas
1080:     *==========================================================================
1081:     PROCEDURE CarregarTelasAba(par_cGrupos)
1082:         LOCAL loc_oGrid
1083:         TRY
1084:             IF THIS.this_oBusinessObject.CarregarAcessoTelas(par_cGrupos)
1085:                 loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page4.grd_4c_Telas
1086:                 loc_oGrid.ColumnCount = 3
1087:                 loc_oGrid.RecordSource = "crSigAcTel"
1088:                 loc_oGrid.Column1.ControlSource = "crSigAcTel.cDescTelas"
1089:                 loc_oGrid.Column2.ControlSource = "crSigAcTel.cDescCamps"
1090:                 loc_oGrid.Column3.ControlSource = "crSigAcTel.nStatus"
1091:                 loc_oGrid.Column1.Header1.Caption = "Tela"
1092:                 loc_oGrid.Column2.Header1.Caption = "Campo"
1093:                 loc_oGrid.Column3.Header1.Caption = "Status"
1094:                 loc_oGrid.Column1.Width = 360
1095:                 loc_oGrid.Column2.Width = 360
1096:                 loc_oGrid.Column3.Width = 168
1097:                 loc_oGrid.Column3.cbo_4c_CmbStatus.RowSourceType = 1
1098:                 loc_oGrid.Column3.cbo_4c_CmbStatus.RowSource = "Padr" + CHR(227) + "o," + ;
1099:                     "Invis" + CHR(237) + "vel," + ;
1100:                     "N" + CHR(227) + "o Edit" + CHR(225) + "vel," + ;
1101:                     "Obrigat" + CHR(243) + "rio"
1102:                 loc_oGrid.FontName = "Tahoma"
1103:                 loc_oGrid.FontSize = 8
1104:                 loc_oGrid.Refresh()
1105:             ENDIF
1106:         CATCH TO loc_oErro
1107:             MsgErro("Erro ao carregar acesso a telas: " + loc_oErro.Message, "Erro")
1108:         ENDTRY
1109:     ENDPROC
1110: 
1111:     *==========================================================================
1112:     * FormParaBO
1113:     *==========================================================================
1114:     PROTECTED PROCEDURE FormParaBO()
1115:         WITH THIS.this_oBusinessObject
1116:             .this_cGrupos = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value)
1117:             .this_cNComps = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_NomeCompleto.Value)
1118:         ENDWITH
1119:     ENDPROC
1120: 
1121:     *==========================================================================
1122:     * BOParaForm
1123:     *==========================================================================
1124:     PROTECTED PROCEDURE BOParaForm()
1125:         WITH THIS.pgf_4c_Paginas.Page2
1126:             .txt_4c_Grupo.Value        = THIS.this_oBusinessObject.this_cGrupos
1127:             .txt_4c_NomeCompleto.Value = THIS.this_oBusinessObject.this_cNComps
1128:         ENDWITH
1129:     ENDPROC
1130: 
1131:     *==========================================================================
1132:     * LimparCampos
1133:     *==========================================================================
1134:     PROTECTED PROCEDURE LimparCampos()
1135:         LOCAL loc_oP2, loc_oAbas
1136:         loc_oP2   = THIS.pgf_4c_Paginas.Page2
1137:         loc_oAbas = loc_oP2.pgf_4c_Abas
1138:         loc_oP2.txt_4c_Grupo.Value        = ""
1139:         loc_oP2.txt_4c_NomeCompleto.Value = ""
1140:         loc_oAbas.Page1.lbx_4c_Disponiveis.Clear()
1141:         loc_oAbas.Page1.lbx_4c_Selecionados.Clear()
1142:         loc_oAbas.Page1.lbl_4c_StatusDisp.Caption = ""
1143:         loc_oAbas.Page1.lbl_4c_StatusSel.Caption  = ""
1144:         loc_oAbas.Page2.txt_4c_FiltroAcesso.Value = ""
1145:         loc_oAbas.Page2.grd_4c_Programas.RecordSource = ""
1146:         loc_oAbas.Page3.grd_4c_Barra.RecordSource = ""
1147:         loc_oAbas.Page4.grd_4c_Telas.RecordSource = ""
1148:         THIS.this_cFiltroPrograma = ""
1149:     ENDPROC
1150: 
1151:     *==========================================================================
1152:     * HabilitarCampos
1153:     *==========================================================================
1154:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1155:         LOCAL loc_oP2
1156:         loc_oP2 = THIS.pgf_4c_Paginas.Page2
1157:         *-- Grupo: so editavel no INCLUIR
1158:         loc_oP2.txt_4c_Grupo.Enabled = (par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
1159:         loc_oP2.txt_4c_NomeCompleto.Enabled = par_lHabilitar
1160:         THIS.HabilitarAbaUsuarios(par_lHabilitar)
1161:         THIS.HabilitarColunasGrid(par_lHabilitar)
1162:     ENDPROC
1163: 
1164:     *==========================================================================
1165:     * HabilitarAbaUsuarios
1166:     *==========================================================================
1167:     PROTECTED PROCEDURE HabilitarAbaUsuarios(par_lHabilitar)
1168:         LOCAL loc_oAba
1169:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
1170:         loc_oAba.cmd_4c_AddUsu.Enabled    = par_lHabilitar
1171:         loc_oAba.cmd_4c_AddAllUsu.Enabled = par_lHabilitar
1172:         loc_oAba.cmd_4c_RemUsu.Enabled    = par_lHabilitar
1173:         loc_oAba.cmd_4c_RemAllUsu.Enabled = par_lHabilitar
1174:     ENDPROC
1175: 
1176:     *==========================================================================
1177:     * HabilitarColunasGrid - Habilita/desabilita colunas de checkbox nos grids
1178:     *==========================================================================
1179:     PROTECTED PROCEDURE HabilitarColunasGrid(par_lHabilitar)
1180:         TRY
1181:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2.grd_4c_Programas.Column3.ReadOnly = !par_lHabilitar
1182:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3.grd_4c_Barra.Column2.ReadOnly     = !par_lHabilitar
1183:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page4.grd_4c_Telas.Column3.ReadOnly     = !par_lHabilitar
1184:         CATCH TO loc_oErro
1185:             MsgErro("Erro ao habilitar grids: " + loc_oErro.Message, "Erro")
1186:         ENDTRY
1187:     ENDPROC
1188: 
1189:     *==========================================================================
1190:     * AjustarBotoesPorModo - Ajusta estado dos botoes CRUD conforme modo atual
1191:     *==========================================================================
1192:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1193:         LOCAL loc_lNaLista, loc_oBotoes
1194:         TRY
1195:             loc_lNaLista = (THIS.this_cModoAtual = "LISTA")
1196:             loc_oBotoes  = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
1197:             loc_oBotoes.cmd_4c_Incluir.Enabled      = .T.
1198:             loc_oBotoes.cmd_4c_Alterar.Enabled      = loc_lNaLista
1199:             loc_oBotoes.cmd_4c_Excluir.Enabled      = loc_lNaLista
1200:             loc_oBotoes.cmd_4c_Buscar.Enabled       = loc_lNaLista
1201:             loc_oBotoes.cmd_4c_CopiarAcesso.Enabled = loc_lNaLista
1202:             THIS.pgf_4c_Paginas.Page1.cnt_4c_Saida.cmd_4c_Encerrar.Enabled = .T.
1203:         CATCH TO loc_oErro
1204:             MsgErro("Erro em AjustarBotoesPorModo: " + loc_oErro.Message, "Erro")
1205:         ENDTRY
1206:     ENDPROC
1207: 
1208:     *==========================================================================
1209:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
1210:     *==========================================================================
1211:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
1212:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
1213:             RETURN .F.
1214:         ENDIF
1215:         THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1216:         RETURN .T.
1217:     ENDPROC
1218: 
1219:     *==========================================================================
1220:     * AtivaCopia - Mostra/oculta painel de copia de acessos na Page1
1221:     *==========================================================================
1222:     PROCEDURE AtivaCopia(par_lAtivo)
1223:         LOCAL loc_oP1
1224:         loc_oP1 = THIS.pgf_4c_Paginas.Page1
1225:         loc_oP1.cnt_4c_PainelCopia.Visible = par_lAtivo
1226:         loc_oP1.cnt_4c_Botoes.Visible      = !par_lAtivo
1227:         loc_oP1.grd_4c_Lista.Enabled       = !par_lAtivo
1228:         IF par_lAtivo
1229:             loc_oP1.cnt_4c_PainelCopia.txt_4c_GrupoOrigem.Value = ""
1230:             loc_oP1.cnt_4c_PainelCopia.txt_4c_GrupoOrigem.SetFocus()
1231:         ENDIF
1232:     ENDPROC
1233: 
1234:     *==========================================================================
1235:     * SalvarDadosRelacionados - Salva usuarios, programas, barra e telas
1236:     *==========================================================================
1237:     PROCEDURE SalvarDadosRelacionados(par_cGrupos)
1238:         LOCAL loc_lSucesso, loc_oAba1, loc_nI, loc_cUsu
1239:         loc_lSucesso = .T.
1240:         TRY
1241:             loc_oAba1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
1242: 
1243:             *-- Cursor temporario com usuarios selecionados
1244:             IF USED("cursor_4c_UsrSalvar")
1245:                 USE IN cursor_4c_UsrSalvar
1246:             ENDIF
1247:             SET NULL ON
1248:             CREATE CURSOR cursor_4c_UsrSalvar (Usuarios C(10))
1249:             SET NULL OFF
1250:             FOR loc_nI = 1 TO loc_oAba1.lbx_4c_Selecionados.ListCount
1251:                 loc_cUsu = ALLTRIM(loc_oAba1.lbx_4c_Selecionados.List(loc_nI))
1252:                 IF !EMPTY(loc_cUsu)
1253:                     INSERT INTO cursor_4c_UsrSalvar VALUES (m.loc_cUsu)
1254:                 ENDIF
1255:             ENDFOR
1256: 
1257:             IF !THIS.this_oBusinessObject.SalvarUsuarios(par_cGrupos, "cursor_4c_UsrSalvar")
1258:                 loc_lSucesso = .F.
1259:             ENDIF
1260:             IF USED("cursor_4c_UsrSalvar")
1261:                 USE IN cursor_4c_UsrSalvar
1262:             ENDIF
1263: 
1264:             *-- Salvar programas (limpar filtro antes)
1265:             IF USED("cursor_4c_Programas")
1266:                 SELECT cursor_4c_Programas
1267:                 SET FILTER TO
1268:                 GO TOP
1269:                 IF !THIS.this_oBusinessObject.SalvarProgramas(par_cGrupos, "cursor_4c_Programas")
1270:                     loc_lSucesso = .F.
1271:                 ENDIF
1272:             ENDIF
1273: 
1274:             *-- Salvar barra
1275:             IF USED("TmpBarra")
1276:                 IF !THIS.this_oBusinessObject.SalvarBarra(par_cGrupos, "TmpBarra")
1277:                     loc_lSucesso = .F.

*-- Linhas 1294 a 1739:
1294:     *==========================================================================
1295:     * ObterStatusUsuario - Retorna "Ativo" ou "Inativo" para um usuario
1296:     *==========================================================================
1297:     PROCEDURE ObterStatusUsuario(par_cUsuarios)
1298:         LOCAL loc_cStatus, loc_nResult
1299:         loc_cStatus = ""
1300:         TRY
1301:             loc_nResult = SQLEXEC(gnConnHandle, ;
1302:                 "SELECT cAtivos FROM sigcdusu WHERE Usuarios = " + EscaparSQL(ALLTRIM(par_cUsuarios)), ;
1303:                 "cursor_4c_TmpUsu")
1304:             IF loc_nResult >= 0 AND USED("cursor_4c_TmpUsu") AND RECCOUNT("cursor_4c_TmpUsu") > 0
1305:                 SELECT cursor_4c_TmpUsu
1306:                 IF ALLTRIM(cAtivos) = "N"
1307:                     loc_cStatus = "Inativo"
1308:                 ELSE
1309:                     loc_cStatus = "Ativo"
1310:                 ENDIF
1311:             ENDIF
1312:             IF USED("cursor_4c_TmpUsu")
1313:                 USE IN cursor_4c_TmpUsu
1314:             ENDIF
1315:         CATCH TO loc_oErro
1316:             MsgErro("Erro ao obter status do usu" + CHR(225) + "rio: " + loc_oErro.Message, "Erro")
1317:         ENDTRY
1318:         RETURN loc_cStatus
1319:     ENDPROC
1320: 
1321:     *==========================================================================
1322:     * --- HANDLERS DE BOTOES ---
1323:     *==========================================================================
1324: 
1325:     PROCEDURE BtnIncluirClick()
1326:         THIS.this_oBusinessObject.NovoRegistro()
1327:         THIS.LimparCampos()
1328:         THIS.this_cModoAtual = "INCLUIR"
1329:         THIS.HabilitarCampos(.T.)
1330:         THIS.CarregarDadosGrupo("")
1331:         THIS.AlternarPagina(2)
1332:         THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.SetFocus()
1333:     ENDPROC
1334: 
1335:     PROCEDURE BtnAlterarClick()
1336:         LOCAL loc_cGrupos
1337:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1338:             MsgAviso("Selecione um grupo na lista.")
1339:             RETURN
1340:         ENDIF
1341:         SELECT cursor_4c_Dados
1342:         loc_cGrupos = ALLTRIM(Grupos)
1343:         IF EMPTY(loc_cGrupos)
1344:             MsgAviso("Selecione um grupo na lista.")
1345:             RETURN
1346:         ENDIF
1347:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cGrupos)
1348:             THIS.this_oBusinessObject.EditarRegistro()
1349:             THIS.BOParaForm()
1350:             THIS.this_cModoAtual = "ALTERAR"
1351:             THIS.HabilitarCampos(.T.)
1352:             THIS.CarregarDadosGrupo(loc_cGrupos)
1353:             THIS.AlternarPagina(2)
1354:         ENDIF
1355:     ENDPROC
1356: 
1357:     PROCEDURE BtnVisualizarClick()
1358:         LOCAL loc_cGrupos
1359:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1360:             MsgAviso("Selecione um grupo na lista.")
1361:             RETURN
1362:         ENDIF
1363:         SELECT cursor_4c_Dados
1364:         loc_cGrupos = ALLTRIM(Grupos)
1365:         IF EMPTY(loc_cGrupos)
1366:             MsgAviso("Selecione um grupo na lista.")
1367:             RETURN
1368:         ENDIF
1369:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cGrupos)
1370:             THIS.BOParaForm()
1371:             THIS.this_cModoAtual = "VISUALIZAR"
1372:             THIS.HabilitarCampos(.F.)
1373:             THIS.CarregarDadosGrupo(loc_cGrupos)
1374:             THIS.AlternarPagina(2)
1375:         ENDIF
1376:     ENDPROC
1377: 
1378:     PROCEDURE BtnExcluirClick()
1379:         LOCAL loc_cGrupos
1380:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1381:             MsgAviso("Selecione um grupo na lista.")
1382:             RETURN
1383:         ENDIF
1384:         SELECT cursor_4c_Dados
1385:         loc_cGrupos = ALLTRIM(Grupos)
1386:         IF EMPTY(loc_cGrupos)
1387:             MsgAviso("Selecione um grupo na lista.")
1388:             RETURN
1389:         ENDIF
1390:         IF MsgConfirma("Confirma exclus" + CHR(227) + "o do grupo " + loc_cGrupos + "?")
1391:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cGrupos)
1392:                 IF THIS.this_oBusinessObject.Excluir()
1393:                     MsgInfo("Grupo exclu" + CHR(237) + "do com sucesso.")
1394:                     THIS.CarregarLista()
1395:                 ENDIF
1396:             ENDIF
1397:         ENDIF
1398:     ENDPROC
1399: 
1400:     PROCEDURE BtnBuscarClick()
1401:         LOCAL loc_oBusca, loc_cGrupoSel
1402:         TRY
1403:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "sigcdgra", ;
1404:                 "cursor_4c_Busca", "Grupos", "", "Buscar Grupo")
1405:             loc_oBusca.mAddColuna("Grupos", "", "Grupo")
1406:             loc_oBusca.mAddColuna("NComps", "", "Nome")
1407:             loc_oBusca.Show()
1408:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
1409:                 SELECT cursor_4c_Busca
1410:                 loc_cGrupoSel = ALLTRIM(Grupos)
1411:                 USE IN cursor_4c_Busca
1412:                 THIS.this_oBusinessObject.Buscar(loc_cGrupoSel)
1413:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.ColumnCount = 2
1414:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
1415:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column1.ControlSource = "cursor_4c_Dados.Grupos"
1416:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column2.ControlSource = "cursor_4c_Dados.NComps"
1417:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column1.Header1.Caption = ""
1418:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column2.Header1.Caption = ""
1419:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
1420:             ELSE
1421:                 IF USED("cursor_4c_Busca")
1422:                     USE IN cursor_4c_Busca
1423:                 ENDIF
1424:             ENDIF
1425:         CATCH TO loc_oErro
1426:             MsgErro("Erro ao buscar grupo: " + loc_oErro.Message, "Erro")
1427:         ENDTRY
1428:     ENDPROC
1429: 
1430:     PROCEDURE BtnSalvarClick()
1431:         LOCAL loc_cGrupos, loc_cNome
1432:         loc_cGrupos = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value)
1433:         loc_cNome   = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_NomeCompleto.Value)
1434: 
1435:         IF EMPTY(loc_cGrupos)
1436:             MsgAviso("C" + CHR(243) + "digo do grupo " + CHR(233) + " obrigat" + CHR(243) + "rio.")
1437:             THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.SetFocus()
1438:             RETURN
1439:         ENDIF
1440: 
1441:         IF EMPTY(loc_cNome)
1442:             MsgAviso("Nome do grupo " + CHR(233) + " obrigat" + CHR(243) + "rio.")
1443:             THIS.pgf_4c_Paginas.Page2.txt_4c_NomeCompleto.SetFocus()
1444:             RETURN
1445:         ENDIF
1446: 
1447:         IF THIS.this_cModoAtual = "INCLUIR"
1448:             IF THIS.this_oBusinessObject.VerificarDuplicidade(loc_cGrupos)
1449:                 MsgAviso("Grupo " + loc_cGrupos + " j" + CHR(225) + " cadastrado.")
1450:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.SetFocus()
1451:                 RETURN
1452:             ENDIF
1453:         ENDIF
1454: 
1455:         THIS.FormParaBO()
1456: 
1457:         IF THIS.this_oBusinessObject.Salvar()
1458:             IF !THIS.SalvarDadosRelacionados(loc_cGrupos)
1459:                 MsgAviso("Grupo salvo, mas houve erro ao salvar dados relacionados.")
1460:             ELSE
1461:                 MsgInfo("Grupo salvo com sucesso.")
1462:             ENDIF
1463:             THIS.this_cModoAtual = "LISTA"
1464:             THIS.AlternarPagina(1)
1465:             THIS.CarregarLista()
1466:             THIS.AjustarBotoesPorModo()
1467:         ENDIF
1468:     ENDPROC
1469: 
1470:     PROCEDURE BtnCancelarClick()
1471:         THIS.this_cModoAtual = "LISTA"
1472:         THIS.AlternarPagina(1)
1473:         THIS.CarregarLista()
1474:         THIS.AjustarBotoesPorModo()
1475:     ENDPROC
1476: 
1477:     PROCEDURE BtnEncerrarClick()
1478:         THIS.Release()
1479:     ENDPROC
1480: 
1481:     PROCEDURE BtnCopiarAcessoClick()
1482:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1483:             MsgAviso("Selecione um grupo destino para copiar acessos.")
1484:             RETURN
1485:         ENDIF
1486:         THIS.AtivaCopia(.T.)
1487:     ENDPROC
1488: 
1489:     *==========================================================================
1490:     * TxtGrupoOrigemValid - Lookup do grupo de origem no painel de copia
1491:     *==========================================================================
1492:     PROCEDURE TxtGrupoOrigemValid(par_nKeyCode, par_nShiftAltCtrl)
1493:         IF !INLIST(par_nKeyCode, 13, 9, 115)
1494:             RETURN
1495:         ENDIF
1496:         LOCAL loc_oTxt, loc_oBusca, loc_cValor
1497:         TRY
1498:             loc_oTxt = THIS.pgf_4c_Paginas.Page1.cnt_4c_PainelCopia.txt_4c_GrupoOrigem
1499:             loc_cValor = ALLTRIM(loc_oTxt.Value)
1500:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "sigcdgra", ;
1501:                 "cursor_4c_BuscaOrigem", "Grupos", loc_cValor, "Selecionar Grupo Origem")
1502:             loc_oBusca.mAddColuna("Grupos", "", "Grupo")
1503:             loc_oBusca.mAddColuna("NComps", "", "Nome")
1504:             loc_oBusca.Show()
1505:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOrigem")
1506:                 SELECT cursor_4c_BuscaOrigem
1507:                 loc_oTxt.Value = ALLTRIM(Grupos)
1508:                 USE IN cursor_4c_BuscaOrigem
1509:             ELSE
1510:                 IF USED("cursor_4c_BuscaOrigem")
1511:                     USE IN cursor_4c_BuscaOrigem
1512:                 ENDIF
1513:             ENDIF
1514:         CATCH TO loc_oErro
1515:             MsgErro("Erro ao buscar grupo de origem: " + loc_oErro.Message, "Erro")
1516:         ENDTRY
1517:     ENDPROC
1518: 
1519:     *==========================================================================
1520:     * BtnCopiarOkClick - Executa copia de acessos entre grupos
1521:     *==========================================================================
1522:     PROCEDURE BtnCopiarOkClick()
1523:         LOCAL loc_cGrupoOrigem, loc_cGrupoDestino
1524:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1525:             MsgAviso("Selecione um grupo destino na lista.")
1526:             RETURN
1527:         ENDIF
1528:         loc_cGrupoOrigem = ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_PainelCopia.txt_4c_GrupoOrigem.Value)
1529:         IF EMPTY(loc_cGrupoOrigem)
1530:             MsgAviso("Informe o grupo de origem.")
1531:             THIS.pgf_4c_Paginas.Page1.cnt_4c_PainelCopia.txt_4c_GrupoOrigem.SetFocus()
1532:             RETURN
1533:         ENDIF
1534:         SELECT cursor_4c_Dados
1535:         loc_cGrupoDestino = ALLTRIM(Grupos)
1536:         IF UPPER(loc_cGrupoOrigem) = UPPER(loc_cGrupoDestino)
1537:             MsgAviso("Grupo de origem e destino s" + CHR(227) + "o iguais.")
1538:             RETURN
1539:         ENDIF
1540:         IF MsgConfirma("Copiar acessos de [" + loc_cGrupoOrigem + "] para [" + loc_cGrupoDestino + "]?")
1541:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cGrupoDestino)
1542:                 IF THIS.this_oBusinessObject.CopiarAcessos(loc_cGrupoOrigem)
1543:                     MsgInfo("Acessos copiados com sucesso.")
1544:                     THIS.AtivaCopia(.F.)
1545:                 ENDIF
1546:             ENDIF
1547:         ENDIF
1548:     ENDPROC
1549: 
1550:     PROCEDURE BtnCopiarCancelarClick()
1551:         THIS.AtivaCopia(.F.)
1552:     ENDPROC
1553: 
1554:     *==========================================================================
1555:     * --- HANDLERS DE LISTBOX ---
1556:     *==========================================================================
1557: 
1558:     PROCEDURE LbxDisponiveisClick()
1559:         LOCAL loc_oAba, loc_cUsu, loc_cStatus
1560:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
1561:         IF loc_oAba.lbx_4c_Disponiveis.ListIndex > 0
1562:             loc_cUsu    = ALLTRIM(loc_oAba.lbx_4c_Disponiveis.List(loc_oAba.lbx_4c_Disponiveis.ListIndex))
1563:             loc_cStatus = THIS.ObterStatusUsuario(loc_cUsu)
1564:             loc_oAba.lbl_4c_StatusDisp.Caption  = loc_cStatus
1565:             loc_oAba.lbl_4c_StatusDisp.ForeColor = IIF(loc_cStatus = "Inativo", RGB(200,0,0), RGB(0,128,0))
1566:         ENDIF
1567:     ENDPROC
1568: 
1569:     PROCEDURE LbxSelecionadosClick()
1570:         LOCAL loc_oAba, loc_cUsu, loc_cStatus
1571:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
1572:         IF loc_oAba.lbx_4c_Selecionados.ListIndex > 0
1573:             loc_cUsu    = ALLTRIM(loc_oAba.lbx_4c_Selecionados.List(loc_oAba.lbx_4c_Selecionados.ListIndex))
1574:             loc_cStatus = THIS.ObterStatusUsuario(loc_cUsu)
1575:             loc_oAba.lbl_4c_StatusSel.Caption  = loc_cStatus
1576:             loc_oAba.lbl_4c_StatusSel.ForeColor = IIF(loc_cStatus = "Inativo", RGB(200,0,0), RGB(0,128,0))
1577:         ENDIF
1578:     ENDPROC
1579: 
1580:     *==========================================================================
1581:     * --- HANDLERS DE TRANSFERENCIA DE USUARIOS ---
1582:     *==========================================================================
1583: 
1584:     PROCEDURE BtnAddUsuClick()
1585:         LOCAL loc_oAba, loc_nI, loc_cUsu
1586:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1587:             RETURN
1588:         ENDIF
1589:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
1590:         FOR loc_nI = loc_oAba.lbx_4c_Disponiveis.ListCount TO 1 STEP -1
1591:             IF loc_oAba.lbx_4c_Disponiveis.Selected(loc_nI)
1592:                 loc_cUsu = ALLTRIM(loc_oAba.lbx_4c_Disponiveis.List(loc_nI))
1593:                 loc_oAba.lbx_4c_Selecionados.AddItem(loc_cUsu)
1594:                 loc_oAba.lbx_4c_Disponiveis.RemoveItem(loc_nI)
1595:             ENDIF
1596:         ENDFOR
1597:     ENDPROC
1598: 
1599:     PROCEDURE BtnAddAllUsuClick()
1600:         LOCAL loc_oAba, loc_nI
1601:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1602:             RETURN
1603:         ENDIF
1604:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
1605:         FOR loc_nI = 1 TO loc_oAba.lbx_4c_Disponiveis.ListCount
1606:             loc_oAba.lbx_4c_Selecionados.AddItem(ALLTRIM(loc_oAba.lbx_4c_Disponiveis.List(loc_nI)))
1607:         ENDFOR
1608:         loc_oAba.lbx_4c_Disponiveis.Clear()
1609:     ENDPROC
1610: 
1611:     PROCEDURE BtnRemUsuClick()
1612:         LOCAL loc_oAba, loc_nI, loc_cUsu
1613:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1614:             RETURN
1615:         ENDIF
1616:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
1617:         FOR loc_nI = loc_oAba.lbx_4c_Selecionados.ListCount TO 1 STEP -1
1618:             IF loc_oAba.lbx_4c_Selecionados.Selected(loc_nI)
1619:                 loc_cUsu = ALLTRIM(loc_oAba.lbx_4c_Selecionados.List(loc_nI))
1620:                 loc_oAba.lbx_4c_Disponiveis.AddItem(loc_cUsu)
1621:                 loc_oAba.lbx_4c_Selecionados.RemoveItem(loc_nI)
1622:             ENDIF
1623:         ENDFOR
1624:     ENDPROC
1625: 
1626:     PROCEDURE BtnRemAllUsuClick()
1627:         LOCAL loc_oAba, loc_nI
1628:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1629:             RETURN
1630:         ENDIF
1631:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
1632:         FOR loc_nI = 1 TO loc_oAba.lbx_4c_Selecionados.ListCount
1633:             loc_oAba.lbx_4c_Disponiveis.AddItem(ALLTRIM(loc_oAba.lbx_4c_Selecionados.List(loc_nI)))
1634:         ENDFOR
1635:         loc_oAba.lbx_4c_Selecionados.Clear()
1636:     ENDPROC
1637: 
1638:     *==========================================================================
1639:     * TxtFiltroAcessoValid - Aplica filtro na grid de programas
1640:     *==========================================================================
1641:     PROCEDURE TxtFiltroAcessoValid()
1642:         THIS.this_cFiltroPrograma = UPPER(ALLTRIM( ;
1643:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2.txt_4c_FiltroAcesso.Value))
1644:         IF USED("cursor_4c_Programas")
1645:             SELECT cursor_4c_Programas
1646:             IF EMPTY(THIS.this_cFiltroPrograma)
1647:                 SET FILTER TO
1648:             ELSE
1649:                 SET FILTER TO THISFORM.this_cFiltroPrograma $ UPPER(ALLTRIM(Descricaos))
1650:             ENDIF
1651:             GO TOP
1652:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2.grd_4c_Programas.Refresh()
1653:         ENDIF
1654:     ENDPROC
1655: 
1656:     *==========================================================================
1657:     * ChkMarcasWhen - Permite editar checkbox Marcas somente em INCLUIR/ALTERAR
1658:     *==========================================================================
1659:     PROCEDURE ChkMarcasWhen()
1660:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1661:     ENDPROC
1662: 
1663:     *==========================================================================
1664:     * ChkSelBarrasWhen - Permite editar checkbox SelBarras somente em INCLUIR/ALTERAR
1665:     *==========================================================================
1666:     PROCEDURE ChkSelBarrasWhen()
1667:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1668:     ENDPROC
1669: 
1670:     *==========================================================================
1671:     * ChkStatusWhen - Permite editar checkbox nStatus somente em INCLUIR/ALTERAR
1672:     *==========================================================================
1673:     PROCEDURE ChkStatusWhen()
1674:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1675:     ENDPROC
1676: 
1677:     *==========================================================================
1678:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
1679:     *==========================================================================
1680:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1681:         LOCAL loc_nI, loc_oCtrl, loc_cNome
1682:         IF VARTYPE(par_oContainer) <> "O"
1683:             RETURN
1684:         ENDIF
1685:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1686:             loc_oCtrl = par_oContainer.Controls(loc_nI)
1687:             IF VARTYPE(loc_oCtrl) = "O"
1688:                 loc_cNome = UPPER(loc_oCtrl.Name)
1689:                 IF INLIST(loc_cNome, "CNT_4C_CABECALHO", "CNT_4C_SAIDA")
1690:                     LOOP
1691:                 ENDIF
1692:                 IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
1693:                     THIS.TornarControlesVisiveis(loc_oCtrl)
1694:                 ENDIF
1695:                 IF PEMSTATUS(loc_oCtrl, "Visible", 5)
1696:                     loc_oCtrl.Visible = .T.
1697:                 ENDIF
1698:             ENDIF
1699:         ENDFOR
1700:     ENDPROC
1701: 
1702:     *==========================================================================
1703:     * Destroy
1704:     *==========================================================================
1705:     PROCEDURE Destroy()
1706:         IF USED("cursor_4c_Dados")
1707:             USE IN cursor_4c_Dados
1708:         ENDIF
1709:         IF USED("cursor_4c_Programas")
1710:             USE IN cursor_4c_Programas
1711:         ENDIF
1712:         IF USED("TmpBarra")
1713:             USE IN TmpBarra
1714:         ENDIF
1715:         IF USED("crSigAcTel")
1716:             USE IN crSigAcTel
1717:         ENDIF
1718:         IF USED("cursor_4c_TodosUsuarios")
1719:             USE IN cursor_4c_TodosUsuarios
1720:         ENDIF
1721:         IF USED("cursor_4c_UsuariosGrupo")
1722:             USE IN cursor_4c_UsuariosGrupo
1723:         ENDIF
1724:         IF USED("cursor_4c_UsrSalvar")
1725:             USE IN cursor_4c_UsrSalvar
1726:         ENDIF
1727:         IF USED("cursor_4c_BuscaOrigem")
1728:             USE IN cursor_4c_BuscaOrigem
1729:         ENDIF
1730:         IF USED("cursor_4c_Busca")
1731:             USE IN cursor_4c_Busca
1732:         ENDIF
1733:         IF USED("cursor_4c_TmpUsu")
1734:             USE IN cursor_4c_TmpUsu
1735:         ENDIF
1736:         DODEFAULT()
1737:     ENDPROC
1738: 
1739: ENDDEFINE


### BO (C:\4c\projeto\app\classes\acgBO.prg):
*==============================================================================
* acgBO.prg - Business Object para Acesso de Grupos (SIGCDACG)
* Tabela Principal: sigcdgra (PK: Grupos)
* Tabelas Relacionadas:
*   - sigcdacg (usuarios do grupo)
*   - sigcdacu (acessos de programa por grupo/usuario)
*   - sigcdacb (barra de ferramentas por grupo)
*   - sigactel (acesso a campos em telas por grupo)
*   - sigcdprg (programas disponiveis)
*   - sigcdusu (usuarios cadastrados)
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF

DEFINE CLASS acgBO AS BusinessBase

    *-- Propriedades: sigcdgra
    this_cGrupos    = ""   && grupos char(10) NOT NULL - PK
    this_cNComps    = ""   && ncomps char(30) NOT NULL - nome do grupo

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "sigcdgra"
        THIS.this_cCampoChave = "Grupos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria (BusinessBase)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cGrupos)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cGrupos = TratarNulo(Grupos, "C")
            THIS.this_cNComps = TratarNulo(NComps, "C")
            loc_lResultado = .T.
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca grupos com filtro opcional para exibir no grid
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_lResultado, loc_nResult
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT Grupos, NComps FROM sigcdgra"
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + ;
                    " WHERE Grupos LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%")
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY Grupos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                IF USED("cursor_4c_Dados")
                    SELECT cursor_4c_Dados
                    GO TOP
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar grupos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega grupo pela PK
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cGrupos)
        LOCAL loc_cSQL, loc_lResultado, loc_nResult
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT Grupos, NComps FROM sigcdgra WHERE Grupos = " + ;
                EscaparSQL(ALLTRIM(par_cGrupos))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult >= 0
                IF USED("cursor_4c_Carrega") AND RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MsgErro("Erro ao carregar grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar grupo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT sigcdgra (registro principal)
    * Dados relacionados sao salvos separadamente via SalvarUsuarios,
    * SalvarProgramas, SalvarBarra, SalvarAcessoTelas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "INSERT INTO sigcdgra (Grupos, NComps) VALUES (" + ;
                EscaparSQL(LEFT(ALLTRIM(THIS.this_cGrupos), 10)) + ", " + ;
                EscaparSQL(LEFT(ALLTRIM(THIS.this_cNComps), 30)) + ")"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                IF USED("cursor_4c_Ins")
                    USE IN cursor_4c_Ins
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir grupo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE sigcdgra (registro principal)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "UPDATE sigcdgra SET NComps = " + ;
                EscaparSQL(LEFT(ALLTRIM(THIS.this_cNComps), 30)) + ;
                " WHERE Grupos = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cGrupos), 10))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                IF USED("cursor_4c_Upd")
                    USE IN cursor_4c_Upd
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar grupo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE sigcdgra e todas as tabelas relacionadas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado, loc_cGrupoSQL
        loc_lResultado = .F.
        loc_cGrupoSQL = EscaparSQL(LEFT(ALLTRIM(THIS.this_cGrupos), 10))
        TRY
            *-- Excluir dependencias (ordem importa para FK)
            loc_cSQL = "DELETE FROM sigactel WHERE grupos = " + loc_cGrupoSQL
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del1")
            IF USED("cursor_4c_Del1")
                USE IN cursor_4c_Del1
            ENDIF

            loc_cSQL = "DELETE FROM sigcdacb WHERE grupos = " + loc_cGrupoSQL
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del2")
            IF USED("cursor_4c_Del2")
                USE IN cursor_4c_Del2
            ENDIF

            loc_cSQL = "DELETE FROM sigcdacu WHERE grupos = " + loc_cGrupoSQL
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del3")
            IF USED("cursor_4c_Del3")
                USE IN cursor_4c_Del3
            ENDIF

            loc_cSQL = "DELETE FROM sigcdacg WHERE grupos = " + loc_cGrupoSQL
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del4")
            IF USED("cursor_4c_Del4")
                USE IN cursor_4c_Del4
            ENDIF

            *-- Excluir registro principal
            loc_cSQL = "DELETE FROM sigcdgra WHERE Grupos = " + loc_cGrupoSQL
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del5")
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                IF USED("cursor_4c_Del5")
                    USE IN cursor_4c_Del5
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir grupo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarTodosGrupos - Lista todos os grupos (para listbox de copia)
    * Retorna cursor: cursor_4c_ListaGrupos (Grupos, NComps)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarTodosGrupos()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT Grupos, NComps FROM sigcdgra ORDER BY Grupos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ListaGrupos")
            IF loc_nResult >= 0
                IF USED("cursor_4c_ListaGrupos")
                    SELECT cursor_4c_ListaGrupos
                    GO TOP
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar grupos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarTodosUsuarios - Lista todos os usuarios do sistema
    * Retorna cursor: cursor_4c_TodosUsuarios (Usuarios, NComps, cAtivos)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarTodosUsuarios()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT Usuarios, NComps, cAtivos FROM sigcdusu ORDER BY NComps"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TodosUsuarios")
            IF loc_nResult >= 0
                IF USED("cursor_4c_TodosUsuarios")
                    SELECT cursor_4c_TodosUsuarios
                    GO TOP
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar usu" + CHR(225) + "rios:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar usu" + CHR(225) + "rios:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarUsuariosDoGrupo - Carrega usuarios pertencentes ao grupo
    * Retorna cursor: cursor_4c_UsuariosGrupo (Usuarios, NComps, cAtivos)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarUsuariosDoGrupo(par_cGrupos)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT a.Usuarios, u.NComps, u.cAtivos" + ;
                " FROM sigcdacg a" + ;
                " LEFT JOIN sigcdusu u ON u.Usuarios = a.Usuarios" + ;
                " WHERE a.grupos = " + EscaparSQL(ALLTRIM(par_cGrupos)) + ;
                " ORDER BY a.Usuarios"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UsuariosGrupo")
            IF loc_nResult >= 0
                IF USED("cursor_4c_UsuariosGrupo")
                    SELECT cursor_4c_UsuariosGrupo
                    GO TOP
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar usu" + CHR(225) + "rios do grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar usu" + CHR(225) + "rios do grupo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarProgramas - Carrega programas disponiveis com marcacao do grupo
    * Retorna cursor: cursor_4c_Programas (Descricaos, Programas, Parametros,
    *                 BarraForms, Marcas)
    * Marcas=1: programa ja liberado ao grupo; Marcas=0: nao liberado
    *--------------------------------------------------------------------------
    PROCEDURE CarregarProgramas(par_cGrupos)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT a.Descricaos, a.Programas, a.Parametros, a.BarraForms," + ;
                " CASE WHEN b.pkchaves IS NOT NULL THEN 1 ELSE 0 END AS Marcas" + ;
                " FROM sigcdprg a" + ;
                " LEFT JOIN sigcdacu b ON b.Programas = a.Programas" + ;
                " AND b.Parametros = a.Parametros" + ;
                " AND b.grupos = " + EscaparSQL(ALLTRIM(par_cGrupos)) + ;
                " AND b.usuarios = ''" + ;
                " ORDER BY a.Descricaos, a.Programas, a.Parametros"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Programas")
            IF loc_nResult >= 0
                IF USED("cursor_4c_Programas")
                    SELECT cursor_4c_Programas
                    GO TOP
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar programas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar programas:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarBarra - Carrega itens de barra de ferramentas com marcacao do grupo
    * Retorna cursor: TmpBarra (BarraOrdem, Descricaos, BarraForms, Programas,
    *                           Parametros, SelBarras, Usuarios)
    * SelBarras=1: item ativo no grupo; SelBarras=0: inativo
    *--------------------------------------------------------------------------
    PROCEDURE CarregarBarra(par_cGrupos)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT DISTINCT a.BarraOrdem, a.Descricaos, a.BarraForms," + ;
                " a.Programas, a.Parametros," + ;
                " CASE WHEN b.pkchaves IS NOT NULL THEN 1 ELSE 0 END AS SelBarras," + ;
                " '' AS Usuarios" + ;
                " FROM sigcdacb a" + ;
                " LEFT JOIN sigcdacb b ON b.Programas = a.Programas" + ;
                " AND b.Parametros = a.Parametros" + ;
                " AND b.grupos = " + EscaparSQL(ALLTRIM(par_cGrupos)) + ;
                " AND b.usuarios = ''" + ;
                " WHERE a.grupos = '' AND a.usuarios = ''" + ;
                " ORDER BY a.BarraOrdem, a.Descricaos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpBarra")
            IF loc_nResult >= 0
                IF USED("TmpBarra")
                    SELECT TmpBarra
                    GO TOP
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar barra:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar barra:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarAcessoTelas - Carrega controle de acesso a campos nas telas
    * par_cGrupos: codigo do grupo (vazio = inserindo novo, traz template com nStatus=1)
    * Retorna cursor: crSigAcTel (cCodigos, cDescTelas, cCampos, cObjetos,
    *                              cDescCamps, nStatus, Grupos, Usuarios, pkchaves)
    * nStatus=0: campo liberado; nStatus=1: campo bloqueado (default)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarAcessoTelas(par_cGrupos)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado, loc_cGrupoSQL
        loc_lResultado = .F.
        loc_cGrupoSQL = EscaparSQL(ALLTRIM(par_cGrupos))
        TRY
            IF EMPTY(ALLTRIM(par_cGrupos))
                *-- Novo grupo: retorna template com todos os campos bloqueados
                loc_cSQL = "SELECT cCodigos, cDescTelas, cCampos, cObjetos, cDescCamps," + ;
                    " 1 AS nStatus, '' AS Grupos, '' AS Usuarios, '' AS pkchaves" + ;
                    " FROM sigactel WHERE grupos = '' AND usuarios = ''" + ;
                    " ORDER BY cCodigos"
            ELSE
                *-- Grupo existente: mostra estado real com defaults bloqueados
                loc_cSQL = "SELECT a.cCodigos, a.cDescTelas, a.cCampos, a.cObjetos, a.cDescCamps," + ;
                    " ISNULL(b.nStatus, 1) AS nStatus," + ;
                    " ISNULL(b.Grupos, '') AS Grupos," + ;
                    " ISNULL(b.Usuarios, '') AS Usuarios," + ;
                    " ISNULL(b.pkchaves, '') AS pkchaves" + ;
                    " FROM sigactel a" + ;
                    " LEFT JOIN sigactel b ON b.cCodigos = a.cCodigos" + ;
                    " AND b.cCampos = a.cCampos" + ;
                    " AND b.grupos = " + loc_cGrupoSQL + ;
                    " AND b.usuarios = ''" + ;
                    " WHERE a.grupos = '' AND a.usuarios = ''" + ;
                    " ORDER BY a.cCodigos"
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigAcTel")
            IF loc_nResult >= 0
                IF USED("crSigAcTel")
                    SELECT crSigAcTel
                    GO TOP
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar acesso telas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar acesso telas:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarUsuarios - Salva lista de usuarios do grupo (delete + reinsert)
    * par_cGrupos: codigo do grupo
    * par_cCursorUsuarios: cursor com campo Usuarios char(10)
    *--------------------------------------------------------------------------
    PROCEDURE SalvarUsuarios(par_cGrupos, par_cCursorUsuarios)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado, loc_cGrupoSQL, loc_cUsuario
        loc_lResultado = .T.
        loc_cGrupoSQL = EscaparSQL(LEFT(ALLTRIM(par_cGrupos), 10))
        TRY
            *-- Deletar usuarios existentes do grupo
            loc_cSQL = "DELETE FROM sigcdacg WHERE grupos = " + loc_cGrupoSQL
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelAcg")
            IF USED("cursor_4c_DelAcg")
                USE IN cursor_4c_DelAcg
            ENDIF

            *-- Reinserir usuarios selecionados
            IF USED(par_cCursorUsuarios) AND RECCOUNT(par_cCursorUsuarios) > 0
                SELECT (par_cCursorUsuarios)
                GO TOP
                SCAN
                    loc_cUsuario = ALLTRIM(Usuarios)
                    IF !EMPTY(loc_cUsuario)
                        loc_cSQL = "INSERT INTO sigcdacg (grupos, usuarios, pkchaves)" + ;
                            " VALUES (" + loc_cGrupoSQL + ", " + ;
                            EscaparSQL(LEFT(loc_cUsuario, 10)) + ", " + ;
                            EscaparSQL(fUniqueIds()) + ")"
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsAcg")
                        IF USED("cursor_4c_InsAcg")
                            USE IN cursor_4c_InsAcg
                        ENDIF
                        IF loc_nResult < 0
                            loc_lResultado = .F.
                        ENDIF
                    ENDIF
                    SELECT (par_cCursorUsuarios)
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar usu" + CHR(225) + "rios:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarProgramas - Salva acessos de programa do grupo (delete + reinsert)
    * par_cGrupos: codigo do grupo
    * par_cCursorProgramas: cursor com campos Programas, Parametros, Marcas
    *   Marcas=1: programa liberado ao grupo
    *--------------------------------------------------------------------------
    PROCEDURE SalvarProgramas(par_cGrupos, par_cCursorProgramas)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado, loc_cGrupoSQL
        LOCAL loc_cProg, loc_cParam, loc_nMarcas
        loc_lResultado = .T.
        loc_cGrupoSQL = EscaparSQL(LEFT(ALLTRIM(par_cGrupos), 10))
        TRY
            *-- Deletar acessos de programa do grupo (somente nivel grupo, usuarios='')
            loc_cSQL = "DELETE FROM sigcdacu WHERE grupos = " + loc_cGrupoSQL + ;
                " AND usuarios = ''"
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelAcu")
            IF USED("cursor_4c_DelAcu")
                USE IN cursor_4c_DelAcu
            ENDIF

            *-- Reinserir programas selecionados (Marcas=1)
            IF USED(par_cCursorProgramas) AND RECCOUNT(par_cCursorProgramas) > 0
                SELECT (par_cCursorProgramas)
                GO TOP
                SCAN
                    loc_nMarcas = Marcas
                    loc_cProg   = ALLTRIM(Programas)
                    loc_cParam  = ALLTRIM(Parametros)
                    IF loc_nMarcas = 1 AND !EMPTY(loc_cProg)
                        loc_cSQL = "INSERT INTO sigcdacu (grupos, programas, parametros, usuarios, pkchaves)" + ;
                            " VALUES (" + loc_cGrupoSQL + ", " + ;
                            EscaparSQL(LEFT(loc_cProg, 15)) + ", " + ;
                            EscaparSQL(LEFT(loc_cParam, 10)) + ", '', " + ;
                            EscaparSQL(fUniqueIds()) + ")"
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsAcu")
                        IF USED("cursor_4c_InsAcu")
                            USE IN cursor_4c_InsAcu
                        ENDIF
                        IF loc_nResult < 0
                            loc_lResultado = .F.
                        ENDIF
                    ENDIF
                    SELECT (par_cCursorProgramas)
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar programas:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarBarra - Salva configuracao da barra de ferramentas do grupo
    * par_cGrupos: codigo do grupo
    * par_cCursorBarra: cursor TmpBarra com campos BarraOrdem, Descricaos,
    *   BarraForms, Programas, Parametros, SelBarras
    *   SelBarras=.T./1: item selecionado para o grupo
    *--------------------------------------------------------------------------
    PROCEDURE SalvarBarra(par_cGrupos, par_cCursorBarra)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado, loc_cGrupoSQL
        LOCAL loc_cDescricaos, loc_cBarraForms, loc_nBarraOrdem
        LOCAL loc_cProg, loc_cParam, loc_lSel
        loc_lResultado = .T.
        loc_cGrupoSQL = EscaparSQL(LEFT(ALLTRIM(par_cGrupos), 10))
        TRY
            *-- Deletar barra existente do grupo (nivel grupo, usuarios='')
            loc_cSQL = "DELETE FROM sigcdacb WHERE grupos = " + loc_cGrupoSQL + ;
                " AND usuarios = ''"
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelAcb")
            IF USED("cursor_4c_DelAcb")
                USE IN cursor_4c_DelAcb
            ENDIF

            *-- Reinserir itens selecionados
            IF USED(par_cCursorBarra) AND RECCOUNT(par_cCursorBarra) > 0
                SELECT (par_cCursorBarra)
                GO TOP
                SCAN
                    loc_lSel        = SelBarras
                    loc_cDescricaos = ALLTRIM(Descricaos)
                    loc_cBarraForms = ALLTRIM(BarraForms)
                    loc_nBarraOrdem = BarraOrdem
                    loc_cProg       = ALLTRIM(Programas)
                    loc_cParam      = ALLTRIM(Parametros)
                    IF loc_lSel
                        loc_cSQL = "INSERT INTO sigcdacb" + ;
                            " (grupos, usuarios, descricaos, barraforms, barraordem, programas, parametros, selbarras, pkchaves)" + ;
                            " VALUES (" + loc_cGrupoSQL + ", '', " + ;
                            EscaparSQL(LEFT(loc_cDescricaos, 73)) + ", " + ;
                            EscaparSQL(LEFT(loc_cBarraForms, 50)) + ", " + ;
                            FormatarNumeroSQL(loc_nBarraOrdem) + ", " + ;
                            EscaparSQL(LEFT(loc_cProg, 15)) + ", " + ;
                            EscaparSQL(LEFT(loc_cParam, 10)) + ", 1, " + ;
                            EscaparSQL(fUniqueIds()) + ")"
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsAcb")
                        IF USED("cursor_4c_InsAcb")
                            USE IN cursor_4c_InsAcb
                        ENDIF
                        IF loc_nResult < 0
                            loc_lResultado = .F.
                        ENDIF
                    ENDIF
                    SELECT (par_cCursorBarra)
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar barra:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarAcessoTelas - Salva configuracao de acesso a campos nas telas
    * par_cGrupos: codigo do grupo
    * par_cCursorAcTel: cursor crSigAcTel com campos cCodigos, cDescTelas,
    *   cCampos, cObjetos, cDescCamps, nStatus
    *   nStatus=0: campo liberado (salva); nStatus=1: bloqueado (nao salva)
    *--------------------------------------------------------------------------
    PROCEDURE SalvarAcessoTelas(par_cGrupos, par_cCursorAcTel)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado, loc_cGrupoSQL
        LOCAL loc_cCampos, loc_cCodigos, loc_cDescCamps, loc_cDescTelas
        LOCAL loc_cObjetos, loc_nStatus
        loc_lResultado = .T.
        loc_cGrupoSQL = EscaparSQL(LEFT(ALLTRIM(par_cGrupos), 10))
        TRY
            *-- Deletar registros existentes do grupo (nivel grupo, usuarios='')
            loc_cSQL = "DELETE FROM sigactel WHERE grupos = " + loc_cGrupoSQL + ;
                " AND usuarios = ''"
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelAcTel")
            IF USED("cursor_4c_DelAcTel")
                USE IN cursor_4c_DelAcTel
            ENDIF

            *-- Reinserir apenas campos liberados (nStatus=0)
            IF USED(par_cCursorAcTel) AND RECCOUNT(par_cCursorAcTel) > 0
                SELECT (par_cCursorAcTel)
                GO TOP
                SCAN
                    loc_nStatus    = nStatus
                    loc_cCodigos   = ALLTRIM(cCodigos)
                    loc_cCampos    = ALLTRIM(cCampos)
                    loc_cDescCamps = ALLTRIM(cDescCamps)
                    loc_cDescTelas = ALLTRIM(cDescTelas)
                    loc_cObjetos   = ALLTRIM(cObjetos)
                    IF loc_nStatus <> 1
                        loc_cSQL = "INSERT INTO sigactel" + ;
                            " (ccampos, ccodigos, cdesccamps, cdesctelas, cobjetos, nstatus, grupos, pkchaves, usuarios)" + ;
                            " VALUES (" + ;
                            EscaparSQL(LEFT(loc_cCampos, 30)) + ", " + ;
                            EscaparSQL(LEFT(loc_cCodigos, 10)) + ", " + ;
                            EscaparSQL(LEFT(loc_cDescCamps, 50)) + ", " + ;
                            EscaparSQL(LEFT(loc_cDescTelas, 50)) + ", " + ;
                            EscaparSQL(LEFT(loc_cObjetos, 100)) + ", " + ;
                            FormatarNumeroSQL(loc_nStatus) + ", " + ;
                            loc_cGrupoSQL + ", " + ;
                            EscaparSQL(fUniqueIds()) + ", '')"
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsAcTel")
                        IF USED("cursor_4c_InsAcTel")
                            USE IN cursor_4c_InsAcTel
                        ENDIF
                        IF loc_nResult < 0
                            loc_lResultado = .F.
                        ENDIF
                    ENDIF
                    SELECT (par_cCursorAcTel)
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar acesso telas:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CopiarAcessos - Copia todos os acessos de par_cGrupoOrigem para THIS.this_cGrupos
    * Usa INSERT ... SELECT direto no SQL Server para eficiencia
    *--------------------------------------------------------------------------
    PROCEDURE CopiarAcessos(par_cGrupoOrigem)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        LOCAL loc_cGrupoDest, loc_cGrupoOri
        loc_lResultado = .F.
        loc_cGrupoDest = EscaparSQL(LEFT(ALLTRIM(THIS.this_cGrupos), 10))
        loc_cGrupoOri  = EscaparSQL(LEFT(ALLTRIM(par_cGrupoOrigem), 10))
        TRY
            *-- Copiar usuarios: apenas os que o destino ainda nao tem
            loc_cSQL = "INSERT INTO sigcdacg (grupos, usuarios, pkchaves)" + ;
                " SELECT " + loc_cGrupoDest + ", a.usuarios, LEFT(NEWID(), 20)" + ;
                " FROM sigcdacg a" + ;
                " WHERE a.grupos = " + loc_cGrupoOri + ;
                " AND NOT EXISTS (SELECT 1 FROM sigcdacg b" + ;
                " WHERE b.grupos = " + loc_cGrupoDest + " AND b.usuarios = a.usuarios)"
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CpAcg")
            IF USED("cursor_4c_CpAcg")
                USE IN cursor_4c_CpAcg
            ENDIF

            *-- Copiar acessos de programa (nivel grupo)
            loc_cSQL = "INSERT INTO sigcdacu (grupos, programas, parametros, usuarios, pkchaves)" + ;
                " SELECT " + loc_cGrupoDest + ", a.programas, a.parametros, '', LEFT(NEWID(), 45)" + ;
                " FROM sigcdacu a" + ;
                " WHERE a.grupos = " + loc_cGrupoOri + " AND a.usuarios = ''" + ;
                " AND NOT EXISTS (SELECT 1 FROM sigcdacu b" + ;
                " WHERE b.grupos = " + loc_cGrupoDest + " AND b.usuarios = ''" + ;
                " AND b.programas = a.programas AND b.parametros = a.parametros)"
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CpAcu")
            IF USED("cursor_4c_CpAcu")
                USE IN cursor_4c_CpAcu
            ENDIF

            *-- Copiar barra de ferramentas (nivel grupo)
            loc_cSQL = "INSERT INTO sigcdacb" + ;
                " (grupos, usuarios, descricaos, barraforms, barraordem, programas, parametros, selbarras, pkchaves)" + ;
                " SELECT " + loc_cGrupoDest + ", '', a.descricaos, a.barraforms, a.barraordem," + ;
                " a.programas, a.parametros, a.selbarras, LEFT(NEWID(), 20)" + ;
                " FROM sigcdacb a" + ;
                " WHERE a.grupos = " + loc_cGrupoOri + " AND a.usuarios = ''" + ;
                " AND NOT EXISTS (SELECT 1 FROM sigcdacb b" + ;
                " WHERE b.grupos = " + loc_cGrupoDest + " AND b.usuarios = ''" + ;
                " AND b.programas = a.programas AND b.parametros = a.parametros)"
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CpAcb")
            IF USED("cursor_4c_CpAcb")
                USE IN cursor_4c_CpAcb
            ENDIF

            *-- Copiar acesso a telas (nivel grupo)
            loc_cSQL = "INSERT INTO sigactel" + ;
                " (ccampos, ccodigos, cdesccamps, cdesctelas, cobjetos, nstatus, grupos, pkchaves, usuarios)" + ;
                " SELECT a.ccampos, a.ccodigos, a.cdesccamps, a.cdesctelas, a.cobjetos," + ;
                " a.nstatus, " + loc_cGrupoDest + ", LEFT(NEWID(), 20), ''" + ;
                " FROM sigactel a" + ;
                " WHERE a.grupos = " + loc_cGrupoOri + " AND a.usuarios = ''" + ;
                " AND NOT EXISTS (SELECT 1 FROM sigactel b" + ;
                " WHERE b.grupos = " + loc_cGrupoDest + " AND b.usuarios = ''" + ;
                " AND b.ccodigos = a.ccodigos AND b.ccampos = a.ccampos)"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CpAcTel")
            IF USED("cursor_4c_CpAcTel")
                USE IN cursor_4c_CpAcTel
            ENDIF

            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao copiar acessos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao copiar acessos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarDuplicidade - Verifica se codigo de grupo ja existe
    * Retorna .T. se ja existe (duplicado), .F. se disponivel
    *--------------------------------------------------------------------------
    PROCEDURE VerificarDuplicidade(par_cGrupos)
        LOCAL loc_cSQL, loc_nResult, loc_lDuplicado
        loc_lDuplicado = .F.
        TRY
            loc_cSQL = "SELECT Grupos FROM sigcdgra WHERE Grupos = " + ;
                EscaparSQL(ALLTRIM(par_cGrupos))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dup")
            IF loc_nResult >= 0
                IF USED("cursor_4c_Dup") AND RECCOUNT("cursor_4c_Dup") > 0
                    loc_lDuplicado = .T.
                ENDIF
                IF USED("cursor_4c_Dup")
                    USE IN cursor_4c_Dup
                ENDIF
            ELSE
                MsgErro("Erro ao verificar duplicidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar duplicidade:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lDuplicado
    ENDPROC

ENDDEFINE

