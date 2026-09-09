# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [BINDEVENT-PARAMS] Handler 'ValidarEmpresa' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarEmpresa(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarDescricaoEmpresa' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarDescricaoEmpresa(par_nKeyCode, par_nShiftAltCtrl)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormSre.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1944 linhas total):

*-- Linhas 38 a 166:
38:     *-- Propriedades de estado
39:     this_oBusinessObject   = .NULL.
40:     this_cModoAtual        = "LISTA"
41:     this_cUltimoEmpValidado  = ""
42:     this_cUltimoDEmpValidado = ""
43: 
44:     *--------------------------------------------------------------------------
45:     * Init - APENAS retorna DODEFAULT (FormBase.Init chama InicializarForm)
46:     *--------------------------------------------------------------------------
47:     PROCEDURE Init()
48:         LOCAL loc_lResultado
49:         loc_lResultado = .F.
50: 
51:         TRY
52:             loc_lResultado = DODEFAULT()
53:         CATCH TO loc_oErro
54:             MsgErro(loc_oErro.Message, "FormSre.Init")
55:         ENDTRY
56: 
57:         RETURN loc_lResultado
58:     ENDPROC
59: 
60:     *--------------------------------------------------------------------------
61:     * InicializarForm - Cria Business Object e configura estrutura completa
62:     *--------------------------------------------------------------------------
63:     PROTECTED PROCEDURE InicializarForm()
64:         LOCAL loc_lResultado
65:         loc_lResultado = .F.
66: 
67:         TRY
68:             THIS.this_oBusinessObject = CREATEOBJECT("SreBO")
69: 
70:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
71:                 MsgErro("Falha ao criar SreBO", "Erro")
72:             ELSE
73:                 THIS.ConfigurarPageFrame()
74: 
75:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
76:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
77: 
78:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
79:                     THIS.CarregarLista()
80:                 ENDIF
81: 
82:                 THIS.pgf_4c_Paginas.Visible = .T.
83:                 THIS.pgf_4c_Paginas.ActivePage = 1
84:                 THIS.this_cModoAtual = "LISTA"
85:                 loc_lResultado = .T.
86:             ENDIF
87:         CATCH TO loc_oErro
88:             MsgErro(loc_oErro.Message, "FormSre.InicializarForm")
89:         ENDTRY
90: 
91:         RETURN loc_lResultado
92:     ENDPROC
93: 
94:     *--------------------------------------------------------------------------
95:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
96:     * PageFrame.Top = -29 esconde as abas; controles internos compensam +29
97:     *--------------------------------------------------------------------------
98:     PROTECTED PROCEDURE ConfigurarPageFrame()
99:         LOCAL loc_oPgf
100:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
101:         loc_oPgf = THIS.pgf_4c_Paginas
102: 
103:         WITH loc_oPgf
104:             .PageCount = 2
105:             .Top       = -29
106:             .Left      = 0
107:             .Width     = THIS.Width
108:             .Height    = THIS.Height + 29
109:             .Tabs      = .F.
110:             .Visible   = .T.
111:             .Page1.Caption   = "Lista"
112:             .Page1.BackColor = RGB(100, 100, 100)
113:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
114:             .Page2.Caption   = "Dados"
115:             .Page2.BackColor = RGB(100, 100, 100)
116:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
117:         ENDWITH
118: 
119:         THIS.ConfigurarPaginaLista()
120:         THIS.ConfigurarPaginaDados()
121:     ENDPROC
122: 
123:     *--------------------------------------------------------------------------
124:     * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD, grid lista
125:     *--------------------------------------------------------------------------
126:     PROTECTED PROCEDURE ConfigurarPaginaLista()
127:         LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida
128:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
129: 
130:         *-- Cabecalho cinza com titulo do formulario
131:         loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
132:         loc_oCab = loc_oPg1.cnt_4c_Cabecalho
133:         WITH loc_oCab
134:             .Top         = 31
135:             .Left        = 0
136:             .Width       = THIS.Width
137:             .Height      = 80
138:             .BackColor   = RGB(100, 100, 100)
139:             .BorderWidth = 0
140:             .Visible     = .T.
141:         ENDWITH
142: 
143:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
144:         WITH loc_oCab.lbl_4c_Sombra
145:             .AutoSize  = .F.
146:             .Caption   = THIS.Caption
147:             .Top       = 15
148:             .Left      = 10
149:             .Width     = THIS.Width
150:             .Height    = 40
151:             .FontName  = "Tahoma"
152:             .FontSize  = 16
153:             .FontBold  = .T.
154:             .ForeColor = RGB(0, 0, 0)
155:             .BackStyle = 0
156:             .Visible   = .T.
157:         ENDWITH
158: 
159:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
160:         WITH loc_oCab.lbl_4c_Titulo
161:             .AutoSize  = .F.
162:             .Caption   = THIS.Caption
163:             .Top       = 18
164:             .Left      = 10
165:             .Width     = THIS.Width
166:             .Height    = 46

*-- Linhas 208 a 497:
208:             .AutoSize        = .F.
209:             .Visible         = .T.
210:         ENDWITH
211:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
212: 
213:         loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
214:         WITH loc_oBotoes.cmd_4c_Visualizar
215:             .Caption         = "Visualizar"
216:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
217:             .PicturePosition = 13
218:             .Top             = 5
219:             .Left            = 80
220:             .Width           = 75
221:             .Height          = 75
222:             .BackColor       = RGB(255, 255, 255)
223:             .ForeColor       = RGB(90, 90, 90)
224:             .FontName        = "Tahoma"
225:             .FontSize        = 8
226:             .FontBold        = .T.
227:             .FontItalic      = .T.
228:             .Themes          = .F.
229:             .SpecialEffect   = 0
230:             .MousePointer    = 15
231:             .WordWrap        = .T.
232:             .AutoSize        = .F.
233:             .Visible         = .T.
234:         ENDWITH
235:         BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
236: 
237:         loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
238:         WITH loc_oBotoes.cmd_4c_Alterar
239:             .Caption         = "Alterar"
240:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
241:             .PicturePosition = 13
242:             .Top             = 5
243:             .Left            = 155
244:             .Width           = 75
245:             .Height          = 75
246:             .BackColor       = RGB(255, 255, 255)
247:             .ForeColor       = RGB(90, 90, 90)
248:             .FontName        = "Tahoma"
249:             .FontSize        = 8
250:             .FontBold        = .T.
251:             .FontItalic      = .T.
252:             .Themes          = .F.
253:             .SpecialEffect   = 0
254:             .MousePointer    = 15
255:             .WordWrap        = .T.
256:             .AutoSize        = .F.
257:             .Visible         = .T.
258:         ENDWITH
259:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
260: 
261:         loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
262:         WITH loc_oBotoes.cmd_4c_Excluir
263:             .Caption         = "Excluir"
264:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
265:             .PicturePosition = 13
266:             .Top             = 5
267:             .Left            = 230
268:             .Width           = 75
269:             .Height          = 75
270:             .BackColor       = RGB(255, 255, 255)
271:             .ForeColor       = RGB(90, 90, 90)
272:             .FontName        = "Tahoma"
273:             .FontSize        = 8
274:             .FontBold        = .T.
275:             .FontItalic      = .T.
276:             .Themes          = .F.
277:             .SpecialEffect   = 0
278:             .MousePointer    = 15
279:             .WordWrap        = .T.
280:             .AutoSize        = .F.
281:             .Visible         = .T.
282:         ENDWITH
283:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
284: 
285:         loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
286:         WITH loc_oBotoes.cmd_4c_Buscar
287:             .Caption         = "Buscar"
288:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
289:             .PicturePosition = 13
290:             .Top             = 5
291:             .Left            = 305
292:             .Width           = 75
293:             .Height          = 75
294:             .BackColor       = RGB(255, 255, 255)
295:             .ForeColor       = RGB(90, 90, 90)
296:             .FontName        = "Tahoma"
297:             .FontSize        = 8
298:             .FontBold        = .T.
299:             .FontItalic      = .T.
300:             .Themes          = .F.
301:             .SpecialEffect   = 0
302:             .MousePointer    = 15
303:             .WordWrap        = .T.
304:             .AutoSize        = .F.
305:             .Visible         = .T.
306:         ENDWITH
307:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
308: 
309:         *-- Container Encerrar (canonico: Left=917, Width=90 - CLAUDE.md regra #10)
310:         loc_oPg1.AddObject("cnt_4c_Saida", "Container")
311:         loc_oSaida = loc_oPg1.cnt_4c_Saida
312:         WITH loc_oSaida
313:             .Top         = 29
314:             .Left        = 917
315:             .Width       = 90
316:             .Height      = 85
317:             .BackStyle   = 0
318:             .BorderWidth = 0
319:             .Visible     = .T.
320:         ENDWITH
321: 
322:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
323:         WITH loc_oSaida.cmd_4c_Encerrar
324:             .Caption         = "Encerrar"
325:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
326:             .PicturePosition = 13
327:             .Top             = 5
328:             .Left            = 5
329:             .Width           = 75
330:             .Height          = 75
331:             .BackColor       = RGB(255, 255, 255)
332:             .ForeColor       = RGB(90, 90, 90)
333:             .FontName        = "Tahoma"
334:             .FontSize        = 8
335:             .FontBold        = .T.
336:             .FontItalic      = .T.
337:             .Themes          = .F.
338:             .SpecialEffect   = 0
339:             .MousePointer    = 15
340:             .WordWrap        = .T.
341:             .AutoSize        = .F.
342:             .Visible         = .T.
343:         ENDWITH
344:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
345: 
346:         *-- Grid lista: Emp + Codigo + Descricao + Tipo N.F.
347:         *-- (colunas conforme AddCursor/pColuna do legado - Fase 4)
348:         loc_oPg1.AddObject("grd_4c_Lista", "Grid")
349:         loc_oPg1.grd_4c_Lista.RecordSource = ""
350:         loc_oPg1.grd_4c_Lista.ColumnCount  = 4
351: 
352:         WITH loc_oPg1.grd_4c_Lista
353:             .Top                     = 117
354:             .Left                    = 12
355:             .Width                   = 890
356:             .Height                  = 480
357:             .FontName                = "Verdana"
358:             .FontSize                = 8
359:             .ForeColor               = RGB(90, 90, 90)
360:             .BackColor               = RGB(255, 255, 255)
361:             .GridLineColor           = RGB(238, 238, 238)
362:             .HighlightBackColor      = RGB(255, 255, 255)
363:             .HighlightForeColor      = RGB(15, 41, 104)
364:             .HighlightStyle          = 2
365:             .DeleteMark              = .F.
366:             .RecordMark              = .F.
367:             .RowHeight               = 16
368:             .ScrollBars              = 2
369:             .GridLines               = 3
370:             .ReadOnly                = .T.
371:             .Visible                 = .T.
372:             .Column1.Width           = 90
373:             .Column2.Width           = 140
374:             .Column3.Width           = 460
375:             .Column4.Width           = 170
376:             .Column1.ReadOnly        = .T.
377:             .Column2.ReadOnly        = .T.
378:             .Column3.ReadOnly        = .T.
379:             .Column4.ReadOnly        = .T.
380:             .Column1.Header1.Caption = "Emp"
381:             .Column2.Header1.Caption = "C" + CHR(243) + "digo"
382:             .Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
383:             .Column4.Header1.Caption = "Tipo N.F."
384:         ENDWITH
385: 
386:         THIS.TornarControlesVisiveis(loc_oPg1)
387:     ENDPROC
388: 
389:     *--------------------------------------------------------------------------
390:     * ConfigurarPaginaDados - Page2: container de botoes de acao + campos
391:     * FASE 5/8: primeira metade dos campos (Codigo, Descricao, Empresa/DEmpresa,
392:     * Modelo, Tipo N.F., Bloqueia NF, Tipo NF (OptionGroup), label Numeracao NF)
393:     * Todos os Tops compensados com +29 (PageFrame.Top = -29)
394:     *--------------------------------------------------------------------------
395:     PROTECTED PROCEDURE ConfigurarPaginaDados()
396:         LOCAL loc_oPg2, loc_oBotoesAcao
397:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
398: 
399:         loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
400:         loc_oBotoesAcao = loc_oPg2.cnt_4c_BotoesAcao
401:         WITH loc_oBotoesAcao
402:             .Top         = 33
403:             .Left        = 842
404:             .Width       = 160
405:             .Height      = 85
406:             .BackStyle   = 0
407:             .BorderWidth = 0
408:             .Visible     = .T.
409:         ENDWITH
410: 
411:         loc_oBotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
412:         WITH loc_oBotoesAcao.cmd_4c_Confirmar
413:             .Caption         = "Confirmar"
414:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
415:             .PicturePosition = 13
416:             .Top             = 5
417:             .Left            = 5
418:             .Width           = 75
419:             .Height          = 75
420:             .BackColor       = RGB(255, 255, 255)
421:             .ForeColor       = RGB(90, 90, 90)
422:             .FontName        = "Tahoma"
423:             .FontSize        = 8
424:             .FontBold        = .T.
425:             .FontItalic      = .T.
426:             .Themes          = .F.
427:             .SpecialEffect   = 0
428:             .MousePointer    = 15
429:             .WordWrap        = .T.
430:             .AutoSize        = .F.
431:             .Visible         = .T.
432:         ENDWITH
433:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
434: 
435:         loc_oBotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
436:         WITH loc_oBotoesAcao.cmd_4c_Cancelar
437:             .Caption         = "Encerrar"
438:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
439:             .PicturePosition = 13
440:             .Top             = 5
441:             .Left            = 80
442:             .Width           = 75
443:             .Height          = 75
444:             .BackColor       = RGB(255, 255, 255)
445:             .ForeColor       = RGB(90, 90, 90)
446:             .FontName        = "Tahoma"
447:             .FontSize        = 8
448:             .FontBold        = .T.
449:             .FontItalic      = .T.
450:             .Themes          = .F.
451:             .SpecialEffect   = 0
452:             .MousePointer    = 15
453:             .WordWrap        = .T.
454:             .AutoSize        = .F.
455:             .Visible         = .T.
456:         ENDWITH
457:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
458: 
459:         *======================================================================
460:         *-- Codigo (Getcods: top=121+29=150, left=275, width=31)
461:         *-- Label1 (Say1 "C" + CHR(243) + "digo :"): top=125+29=154, left=229
462:         *======================================================================
463:         loc_oPg2.AddObject("txt_4c_Codigo", "TextBox")
464:         WITH loc_oPg2.txt_4c_Codigo
465:             .Value         = ""
466:             .Top           = 150
467:             .Left          = 275
468:             .Width         = 31
469:             .Height        = 24
470:             .MaxLength     = 3
471:             .FontName      = "Tahoma"
472:             .FontSize      = 8
473:             .BackColor     = RGB(255, 255, 255)
474:             .ForeColor     = RGB(0, 0, 0)
475:             .SpecialEffect = 1
476:             .Visible       = .T.
477:         ENDWITH
478: 
479:         loc_oPg2.AddObject("lbl_4c_Label1", "Label")
480:         WITH loc_oPg2.lbl_4c_Label1
481:             .Caption   = "C" + CHR(243) + "digo :"
482:             .Top       = 154
483:             .Left      = 229
484:             .Width     = 42
485:             .Height    = 15
486:             .AutoSize  = .F.
487:             .FontName  = "Tahoma"
488:             .FontSize  = 8
489:             .FontBold  = .F.
490:             .BackStyle = 0
491:             .ForeColor = RGB(90, 90, 90)
492:             .Visible   = .T.
493:         ENDWITH
494: 
495:         *======================================================================
496:         *-- Descricao (Getdescs: top=121+29=150, left=390, width=209)
497:         *-- Label2 (Say2 "Descri" + CHR(231) + CHR(227) + "o :"): top=125+29=154, left=331

*-- Linhas 582 a 633:
582:         ENDWITH
583: 
584:         *-- Lookup de Empresa (fAcessoEmpresa no legado): F4/DblClick abrem
585:         *-- FormBuscaAuxiliar; LostFocus valida por codigo (Emps) ou por
586:         *-- descricao (DEmps) e faz busca reversa (ver Problema 45: guard
587:         *-- contra reabertura em toda perda de foco sem valor alterado)
588:         BINDEVENT(loc_oPg2.txt_4c_Emps, "KeyPress", THIS, "EmpsKeyPress")
589:         BINDEVENT(loc_oPg2.txt_4c_Emps, "DblClick", THIS, "EmpsDblClick")
590:         BINDEVENT(loc_oPg2.txt_4c_Emps, "KeyPress", THIS, "ValidarEmpresa")
591:         BINDEVENT(loc_oPg2.txt_4c_DEmps, "KeyPress", THIS, "DEmpsKeyPress")
592:         BINDEVENT(loc_oPg2.txt_4c_DEmps, "DblClick", THIS, "DEmpsDblClick")
593:         BINDEVENT(loc_oPg2.txt_4c_DEmps, "KeyPress", THIS, "ValidarDescricaoEmpresa")
594: 
595:         *======================================================================
596:         *-- Modelo (getModelo: top=175+29=204, left=275, width=31)
597:         *-- Label12 (Say12 "Modelo :"): top=179+29=208, left=228
598:         *======================================================================
599:         loc_oPg2.AddObject("txt_4c_Modelo", "TextBox")
600:         WITH loc_oPg2.txt_4c_Modelo
601:             .Value         = ""
602:             .Top           = 204
603:             .Left          = 275
604:             .Width         = 31
605:             .Height        = 24
606:             .MaxLength     = 5
607:             .FontName      = "Tahoma"
608:             .FontSize      = 8
609:             .BackColor     = RGB(255, 255, 255)
610:             .ForeColor     = RGB(0, 0, 0)
611:             .SpecialEffect = 1
612:             .Visible       = .T.
613:         ENDWITH
614: 
615:         loc_oPg2.AddObject("lbl_4c_Label12", "Label")
616:         WITH loc_oPg2.lbl_4c_Label12
617:             .Caption   = "Modelo :"
618:             .Top       = 208
619:             .Left      = 228
620:             .Width     = 43
621:             .Height    = 15
622:             .AutoSize  = .F.
623:             .FontName  = "Tahoma"
624:             .FontSize  = 8
625:             .FontBold  = .F.
626:             .BackStyle = 0
627:             .ForeColor = RGB(90, 90, 90)
628:             .Visible   = .T.
629:         ENDWITH
630: 
631:         *======================================================================
632:         *-- Tipo N.F. (gettiponf: top=175+29=204, left=390, width=48)
633:         *-- Label14 (Say14 "Tipo NF :"): top=179+29=208, left=341

*-- Linhas 691 a 734:
691:         *-- Tipo NF (Op_TipoNF: top=203+29=232, left=271, width=420, height=25)
692:         *-- ButtonCount=4: Automatico / Manual / Automatico Sem Alteracao / Documento
693:         *======================================================================
694:         loc_oPg2.AddObject("obj_4c_Op_TipoNF", "OptionGroup")
695:         WITH loc_oPg2.obj_4c_Op_TipoNF
696:             .ButtonCount = 4
697:             .AutoSize    = .F.
698:             .BackStyle   = 0
699:             .BorderStyle = 0
700:             .Value       = 1
701:             .Top         = 232
702:             .Left        = 271
703:             .Width       = 420
704:             .Height      = 25
705:             .Visible     = .T.
706:         ENDWITH
707:         WITH loc_oPg2.obj_4c_Op_TipoNF.Buttons(1)
708:             .Caption   = "Autom" + CHR(225) + "tico"
709:             .Left      = 5
710:             .Top       = 5
711:             .Width     = 85
712:             .Height    = 15
713:             .AutoSize  = .T.
714:             .FontName  = "Tahoma"
715:             .FontSize  = 8
716:             .BackStyle = 0
717:             .ForeColor = RGB(90, 90, 90)
718:             .Themes    = .F.
719:         ENDWITH
720:         WITH loc_oPg2.obj_4c_Op_TipoNF.Buttons(2)
721:             .Caption   = "Manual"
722:             .Left      = 95
723:             .Top       = 5
724:             .Width     = 60
725:             .Height    = 15
726:             .AutoSize  = .T.
727:             .FontName  = "Tahoma"
728:             .FontSize  = 8
729:             .BackStyle = 0
730:             .ForeColor = RGB(90, 90, 90)
731:             .Themes    = .F.
732:         ENDWITH
733:         WITH loc_oPg2.obj_4c_Op_TipoNF.Buttons(3)
734:             .Caption   = "Autom" + CHR(225) + "tico Sem Altera" + CHR(231) + CHR(227) + "o"

*-- Linhas 805 a 848:
805:         *-- Numeracao de NF (fwoption2: nnfobrigs) top=224+29=253, left=271,
806:         *-- width=180, height=25, ButtonCount=2: Opcional / Obrigatoria
807:         *======================================================================
808:         loc_oPg2.AddObject("obj_4c_Fwoption2", "OptionGroup")
809:         WITH loc_oPg2.obj_4c_Fwoption2
810:             .ButtonCount = 2
811:             .AutoSize    = .F.
812:             .BackStyle   = 0
813:             .BorderStyle = 0
814:             .Value       = 1
815:             .Top         = 253
816:             .Left        = 271
817:             .Width       = 180
818:             .Height      = 25
819:             .Visible     = .T.
820:         ENDWITH
821:         WITH loc_oPg2.obj_4c_Fwoption2.Buttons(1)
822:             .Caption   = "Opcional"
823:             .Left      = 5
824:             .Top       = 5
825:             .Width     = 60
826:             .Height    = 15
827:             .AutoSize  = .T.
828:             .FontName  = "Tahoma"
829:             .FontSize  = 8
830:             .BackStyle = 0
831:             .ForeColor = RGB(90, 90, 90)
832:             .Themes    = .F.
833:         ENDWITH
834:         WITH loc_oPg2.obj_4c_Fwoption2.Buttons(2)
835:             .Caption   = "Obrigat" + CHR(243) + "ria"
836:             .Left      = 95
837:             .Top       = 5
838:             .Width     = 75
839:             .Height    = 15
840:             .AutoSize  = .T.
841:             .FontName  = "Tahoma"
842:             .FontSize  = 8
843:             .BackStyle = 0
844:             .ForeColor = RGB(90, 90, 90)
845:             .Themes    = .F.
846:         ENDWITH
847: 
848:         *======================================================================

*-- Linhas 868 a 911:
868:         *-- Imprime NF (Op_AlteraPeso: impnfs) top=246+29=275, left=271,
869:         *-- width=175, height=25, ButtonCount=3: Sim / Nao / Eletronica
870:         *======================================================================
871:         loc_oPg2.AddObject("obj_4c_Op_AlteraPeso", "OptionGroup")
872:         WITH loc_oPg2.obj_4c_Op_AlteraPeso
873:             .ButtonCount = 3
874:             .AutoSize    = .F.
875:             .BackStyle   = 0
876:             .BorderStyle = 0
877:             .Value       = 1
878:             .Top         = 275
879:             .Left        = 271
880:             .Width       = 175
881:             .Height      = 25
882:             .Visible     = .T.
883:         ENDWITH
884:         WITH loc_oPg2.obj_4c_Op_AlteraPeso.Buttons(1)
885:             .Caption   = "Sim"
886:             .Left      = 5
887:             .Top       = 5
888:             .Width     = 40
889:             .Height    = 15
890:             .AutoSize  = .T.
891:             .FontName  = "Tahoma"
892:             .FontSize  = 8
893:             .BackStyle = 0
894:             .ForeColor = RGB(90, 90, 90)
895:             .Themes    = .F.
896:         ENDWITH
897:         WITH loc_oPg2.obj_4c_Op_AlteraPeso.Buttons(2)
898:             .Caption   = "N" + CHR(227) + "o"
899:             .Left      = 50
900:             .Top       = 5
901:             .Width     = 40
902:             .Height    = 15
903:             .AutoSize  = .T.
904:             .FontName  = "Tahoma"
905:             .FontSize  = 8
906:             .BackStyle = 0
907:             .ForeColor = RGB(90, 90, 90)
908:             .Themes    = .F.
909:         ENDWITH
910:         WITH loc_oPg2.obj_4c_Op_AlteraPeso.Buttons(3)
911:             .Caption   = "Eletr" + CHR(244) + "nica"

*-- Linhas 922 a 1054:
922:         ENDWITH
923: 
924:         *-- ck_BlqInss so fica habilitado quando Imprime NF = Sim (Problema 31:
925:         *-- InteractiveChange precisa recalcular o Enabled do checkbox)
926:         BINDEVENT(loc_oPg2.obj_4c_Op_AlteraPeso, "InteractiveChange", THIS, "AjustarChkBlqInss")
927: 
928:         *======================================================================
929:         *-- Label5 (Say5 "Dados ECF Fiscal :") top=273+29=302, left=181, width=90
930:         *======================================================================
931:         loc_oPg2.AddObject("lbl_4c_Label5", "Label")
932:         WITH loc_oPg2.lbl_4c_Label5
933:             .Caption   = "Dados ECF Fiscal :"
934:             .Top       = 302
935:             .Left      = 181
936:             .Width     = 90
937:             .Height    = 15
938:             .AutoSize  = .F.
939:             .FontName  = "Tahoma"
940:             .FontSize  = 8
941:             .FontBold  = .F.
942:             .BackStyle = 0
943:             .ForeColor = RGB(90, 90, 90)
944:             .Visible   = .T.
945:         ENDWITH
946: 
947:         *======================================================================
948:         *-- Dados ECF Fiscal (Optiongroup1: mostecfs) top=269+29=298, left=271,
949:         *-- width=96, height=25, ButtonCount=2: Sim / Nao
950:         *======================================================================
951:         loc_oPg2.AddObject("obj_4c_Optiongroup1", "OptionGroup")
952:         WITH loc_oPg2.obj_4c_Optiongroup1
953:             .ButtonCount = 2
954:             .AutoSize    = .F.
955:             .BackStyle   = 0
956:             .BorderStyle = 0
957:             .Value       = 1
958:             .Top         = 298
959:             .Left        = 271
960:             .Width       = 100
961:             .Height      = 25
962:             .Visible     = .T.
963:         ENDWITH
964:         WITH loc_oPg2.obj_4c_Optiongroup1.Buttons(1)
965:             .Caption   = "Sim"
966:             .Left      = 5
967:             .Top       = 5
968:             .Width     = 40
969:             .Height    = 15
970:             .AutoSize  = .T.
971:             .FontName  = "Tahoma"
972:             .FontSize  = 8
973:             .BackStyle = 0
974:             .ForeColor = RGB(90, 90, 90)
975:             .Themes    = .F.
976:         ENDWITH
977:         WITH loc_oPg2.obj_4c_Optiongroup1.Buttons(2)
978:             .Caption   = "N" + CHR(227) + "o"
979:             .Left      = 50
980:             .Top       = 5
981:             .Width     = 40
982:             .Height    = 15
983:             .AutoSize  = .T.
984:             .FontName  = "Tahoma"
985:             .FontSize  = 8
986:             .BackStyle = 0
987:             .ForeColor = RGB(90, 90, 90)
988:             .Themes    = .F.
989:         ENDWITH
990: 
991:         *======================================================================
992:         *-- Label6 (Say6 "Servi" + CHR(231) + "os :") top=296+29=325, left=222, width=49
993:         *======================================================================
994:         loc_oPg2.AddObject("lbl_4c_Label6", "Label")
995:         WITH loc_oPg2.lbl_4c_Label6
996:             .Caption   = "Servi" + CHR(231) + "os :"
997:             .Top       = 325
998:             .Left      = 222
999:             .Width     = 49
1000:             .Height    = 15
1001:             .AutoSize  = .F.
1002:             .FontName  = "Tahoma"
1003:             .FontSize  = 8
1004:             .FontBold  = .F.
1005:             .BackStyle = 0
1006:             .ForeColor = RGB(90, 90, 90)
1007:             .Visible   = .T.
1008:         ENDWITH
1009: 
1010:         *======================================================================
1011:         *-- Servicos (fwoption1: TpServicos) top=291+29=320, left=271,
1012:         *-- width=232, height=27, ButtonCount=3: Sim / Nao / Sim Com Itens
1013:         *======================================================================
1014:         loc_oPg2.AddObject("obj_4c_Fwoption1", "OptionGroup")
1015:         WITH loc_oPg2.obj_4c_Fwoption1
1016:             .ButtonCount = 3
1017:             .AutoSize    = .F.
1018:             .BackStyle   = 0
1019:             .BorderStyle = 0
1020:             .Value       = 2
1021:             .Top         = 320
1022:             .Left        = 271
1023:             .Width       = 232
1024:             .Height      = 27
1025:             .Visible     = .T.
1026:         ENDWITH
1027:         WITH loc_oPg2.obj_4c_Fwoption1.Buttons(1)
1028:             .Caption   = "Sim"
1029:             .Left      = 5
1030:             .Top       = 6
1031:             .Width     = 40
1032:             .Height    = 15
1033:             .AutoSize  = .T.
1034:             .FontName  = "Tahoma"
1035:             .FontSize  = 8
1036:             .BackStyle = 0
1037:             .ForeColor = RGB(90, 90, 90)
1038:             .Themes    = .F.
1039:         ENDWITH
1040:         WITH loc_oPg2.obj_4c_Fwoption1.Buttons(2)
1041:             .Caption   = "N" + CHR(227) + "o"
1042:             .Left      = 51
1043:             .Top       = 6
1044:             .Width     = 40
1045:             .Height    = 15
1046:             .AutoSize  = .T.
1047:             .FontName  = "Tahoma"
1048:             .FontSize  = 8
1049:             .BackStyle = 0
1050:             .ForeColor = RGB(90, 90, 90)
1051:             .Themes    = .F.
1052:         ENDWITH
1053:         WITH loc_oPg2.obj_4c_Fwoption1.Buttons(3)
1054:             .Caption   = "Sim Com Itens"

*-- Linhas 1087 a 1130:
1087:         *-- Selo Transporte (optSeloTrans: SeloTrans) top=317+29=346, left=271,
1088:         *-- width=96, height=25, ButtonCount=2: Sim / Nao
1089:         *======================================================================
1090:         loc_oPg2.AddObject("obj_4c_OptSeloTrans", "OptionGroup")
1091:         WITH loc_oPg2.obj_4c_OptSeloTrans
1092:             .ButtonCount = 2
1093:             .AutoSize    = .F.
1094:             .BackStyle   = 0
1095:             .BorderStyle = 0
1096:             .Value       = 1
1097:             .Top         = 346
1098:             .Left        = 271
1099:             .Width       = 100
1100:             .Height      = 25
1101:             .Visible     = .T.
1102:         ENDWITH
1103:         WITH loc_oPg2.obj_4c_OptSeloTrans.Buttons(1)
1104:             .Caption   = "Sim"
1105:             .Left      = 5
1106:             .Top       = 5
1107:             .Width     = 40
1108:             .Height    = 15
1109:             .AutoSize  = .T.
1110:             .FontName  = "Tahoma"
1111:             .FontSize  = 8
1112:             .BackStyle = 0
1113:             .ForeColor = RGB(90, 90, 90)
1114:             .Themes    = .F.
1115:         ENDWITH
1116:         WITH loc_oPg2.obj_4c_OptSeloTrans.Buttons(2)
1117:             .Caption   = "N" + CHR(227) + "o"
1118:             .Left      = 50
1119:             .Top       = 5
1120:             .Width     = 40
1121:             .Height    = 15
1122:             .AutoSize  = .T.
1123:             .FontName  = "Tahoma"
1124:             .FontSize  = 8
1125:             .BackStyle = 0
1126:             .ForeColor = RGB(90, 90, 90)
1127:             .Themes    = .F.
1128:         ENDWITH
1129: 
1130:         *======================================================================

*-- Linhas 1199 a 1742:
1199:             .Visible       = .T.
1200:         ENDWITH
1201: 
1202:         THIS.TornarControlesVisiveis(loc_oPg2)
1203:     ENDPROC
1204: 
1205:     *--------------------------------------------------------------------------
1206:     * ValidarEmpresa - LostFocus de txt_4c_Emps. Valida o codigo da empresa
1207:     * digitado e preenche a descricao (Razas). Se nao encontrar, abre o
1208:     * lookup para o usuario selecionar. Equivale ao fAcessoEmpresa(...,'C',...)
1209:     * do legado (sigacess.PRG).
1210:     *--------------------------------------------------------------------------
1211:     PROCEDURE ValidarEmpresa(par_nKeyCode, par_nShiftAltCtrl)
1212:         LOCAL loc_oPg2, loc_cCod, loc_cSQL
1213: 
1214:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1215:         loc_cCod = ALLTRIM(loc_oPg2.txt_4c_Emps.Value)
1216: 
1217:         *-- Guard (Problema 45): nao reabrir/revalidar se o valor nao mudou
1218:         IF loc_cCod == THIS.this_cUltimoEmpValidado
1219:             RETURN
1220:         ENDIF
1221:         THIS.this_cUltimoEmpValidado = loc_cCod
1222: 
1223:         IF EMPTY(loc_cCod)
1224:             loc_oPg2.txt_4c_DEmps.Value = ""
1225:             RETURN
1226:         ENDIF
1227: 
1228:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1229:             RETURN
1230:         ENDIF
1231: 
1232:         loc_cSQL = "SELECT TOP 1 Cemps, Razas FROM SigCdEmp" + ;
1233:             " WHERE Cemps = " + EscaparSQL(loc_cCod)
1234: 
1235:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpValid") >= 1 AND RECCOUNT("cursor_4c_EmpValid") > 0
1236:             SELECT cursor_4c_EmpValid
1237:             loc_oPg2.txt_4c_Emps.Value  = ALLTRIM(cursor_4c_EmpValid.Cemps)
1238:             loc_oPg2.txt_4c_DEmps.Value = ALLTRIM(cursor_4c_EmpValid.Razas)
1239:             THIS.this_cUltimoEmpValidado  = ALLTRIM(cursor_4c_EmpValid.Cemps)
1240:             THIS.this_cUltimoDEmpValidado = ALLTRIM(cursor_4c_EmpValid.Razas)
1241:             IF USED("cursor_4c_EmpValid")
1242:                 USE IN cursor_4c_EmpValid
1243:             ENDIF
1244:         ELSE
1245:             IF USED("cursor_4c_EmpValid")
1246:                 USE IN cursor_4c_EmpValid
1247:             ENDIF
1248:             THIS.AbrirLookupEmpresa()
1249:         ENDIF
1250:     ENDPROC
1251: 
1252:     *--------------------------------------------------------------------------
1253:     * ValidarDescricaoEmpresa - LostFocus de txt_4c_DEmps. Faz busca reversa
1254:     * pela razao social (Razas) e preenche o codigo (Cemps). Se nao encontrar,
1255:     * abre o lookup. Equivale ao fAcessoEmpresa(...,'D',...) do legado.
1256:     *--------------------------------------------------------------------------
1257:     PROCEDURE ValidarDescricaoEmpresa(par_nKeyCode, par_nShiftAltCtrl)
1258:         LOCAL loc_oPg2, loc_cDesc, loc_cSQL
1259: 
1260:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
1261:         loc_cDesc = ALLTRIM(loc_oPg2.txt_4c_DEmps.Value)
1262: 
1263:         *-- Guard (Problema 45): nao reabrir/revalidar se o valor nao mudou
1264:         IF loc_cDesc == THIS.this_cUltimoDEmpValidado
1265:             RETURN
1266:         ENDIF
1267:         THIS.this_cUltimoDEmpValidado = loc_cDesc
1268: 
1269:         IF EMPTY(loc_cDesc)
1270:             RETURN
1271:         ENDIF
1272: 
1273:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1274:             RETURN
1275:         ENDIF
1276: 
1277:         loc_cSQL = "SELECT TOP 1 Cemps, Razas FROM SigCdEmp" + ;
1278:             " WHERE Razas LIKE " + EscaparSQL(loc_cDesc + "%") + ;
1279:             " ORDER BY Razas"
1280: 
1281:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DEmpValid") >= 1 AND RECCOUNT("cursor_4c_DEmpValid") > 0
1282:             SELECT cursor_4c_DEmpValid
1283:             loc_oPg2.txt_4c_Emps.Value  = ALLTRIM(cursor_4c_DEmpValid.Cemps)
1284:             loc_oPg2.txt_4c_DEmps.Value = ALLTRIM(cursor_4c_DEmpValid.Razas)
1285:             THIS.this_cUltimoEmpValidado  = ALLTRIM(cursor_4c_DEmpValid.Cemps)
1286:             THIS.this_cUltimoDEmpValidado = ALLTRIM(cursor_4c_DEmpValid.Razas)
1287:             IF USED("cursor_4c_DEmpValid")
1288:                 USE IN cursor_4c_DEmpValid
1289:             ENDIF
1290:         ELSE
1291:             IF USED("cursor_4c_DEmpValid")
1292:                 USE IN cursor_4c_DEmpValid
1293:             ENDIF
1294:             THIS.AbrirLookupEmpresa()
1295:         ENDIF
1296:     ENDPROC
1297: 
1298:     *--------------------------------------------------------------------------
1299:     * AbrirLookupEmpresa - Abre FormBuscaAuxiliar para selecao de Empresa
1300:     * (SigCdEmp). Disparado por F4/DblClick em txt_4c_Emps/txt_4c_DEmps e
1301:     * como fallback quando ValidarEmpresa/ValidarDescricaoEmpresa nao
1302:     * encontram o registro digitado.
1303:     *--------------------------------------------------------------------------
1304:     PROCEDURE AbrirLookupEmpresa()
1305:         LOCAL loc_oPg2, loc_oBusca
1306: 
1307:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1308:             RETURN
1309:         ENDIF
1310: 
1311:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1312: 
1313:         IF !loc_oPg2.txt_4c_Emps.Enabled
1314:             RETURN
1315:         ENDIF
1316: 
1317:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1318:             "SigCdEmp", ;
1319:             "cursor_4c_BuscaEmpresa", ;
1320:             "Cemps", ;
1321:             ALLTRIM(loc_oPg2.txt_4c_Emps.Value), ;
1322:             "Buscar Empresa", ;
1323:             .F., .F., ;
1324:             "")
1325: 
1326:         loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
1327:         loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
1328:         loc_oBusca.Show()
1329: 
1330:         IF loc_oBusca.this_lSelecionou
1331:             IF USED("cursor_4c_BuscaEmpresa")
1332:                 SELECT cursor_4c_BuscaEmpresa
1333:                 loc_oPg2.txt_4c_Emps.Value  = ALLTRIM(cursor_4c_BuscaEmpresa.Cemps)
1334:                 loc_oPg2.txt_4c_DEmps.Value = ALLTRIM(cursor_4c_BuscaEmpresa.Razas)
1335:                 THIS.this_cUltimoEmpValidado  = ALLTRIM(cursor_4c_BuscaEmpresa.Cemps)
1336:                 THIS.this_cUltimoDEmpValidado = ALLTRIM(cursor_4c_BuscaEmpresa.Razas)
1337:             ENDIF
1338:         ELSE
1339:             loc_oPg2.txt_4c_Emps.Value    = ""
1340:             loc_oPg2.txt_4c_DEmps.Value   = ""
1341:             THIS.this_cUltimoEmpValidado  = ""
1342:             THIS.this_cUltimoDEmpValidado = ""
1343:         ENDIF
1344: 
1345:         IF USED("cursor_4c_BuscaEmpresa")
1346:             USE IN cursor_4c_BuscaEmpresa
1347:         ENDIF
1348:         loc_oBusca.Release()
1349:     ENDPROC
1350: 
1351:     *--------------------------------------------------------------------------
1352:     * Handlers KeyPress/DblClick dos campos de Empresa (F4 abre o lookup)
1353:     *--------------------------------------------------------------------------
1354:     PROCEDURE EmpsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1355:         IF par_nKeyCode = 28  && F4
1356:             THIS.AbrirLookupEmpresa()
1357:         ENDIF
1358:     ENDPROC
1359: 
1360:     PROCEDURE EmpsDblClick()
1361:         THIS.AbrirLookupEmpresa()
1362:     ENDPROC
1363: 
1364:     PROCEDURE DEmpsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1365:         IF par_nKeyCode = 28  && F4
1366:             THIS.AbrirLookupEmpresa()
1367:         ENDIF
1368:     ENDPROC
1369: 
1370:     PROCEDURE DEmpsDblClick()
1371:         THIS.AbrirLookupEmpresa()
1372:     ENDPROC
1373: 
1374:     *--------------------------------------------------------------------------
1375:     * BOParaForm - Transfere valores do Business Object para o Form (Page2)
1376:     *--------------------------------------------------------------------------
1377:     PROTECTED PROCEDURE BOParaForm()
1378:         LOCAL loc_oPg2, loc_oBO
1379:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1380:         loc_oBO  = THIS.this_oBusinessObject
1381: 
1382:         TRY
1383:             loc_oPg2.txt_4c_Codigo.Value    = ALLTRIM(loc_oBO.this_cCodigo)
1384:             loc_oPg2.txt_4c_Descricao.Value = ALLTRIM(loc_oBO.this_cDescricao)
1385:             loc_oPg2.txt_4c_Emps.Value      = ALLTRIM(loc_oBO.this_cEmps)
1386:             loc_oPg2.txt_4c_DEmps.Value     = ALLTRIM(loc_oBO.BuscarDescricaoEmpresa(loc_oBO.this_cEmps))
1387:             loc_oPg2.txt_4c_Modelo.Value    = ALLTRIM(loc_oBO.this_cModelos)
1388:             loc_oPg2.txt_4c_Tiponf.Value    = ALLTRIM(loc_oBO.this_cCtiponfs)
1389:             loc_oPg2.txt_4c_Inicials.Value  = ALLTRIM(loc_oBO.this_cInicials)
1390:             loc_oPg2.txt_4c_Finals.Value    = ALLTRIM(loc_oBO.this_cFinals)
1391: 
1392:             loc_oPg2.chk_4c_Ck_BlqInss.Value = (loc_oBO.this_nBlqinss .Value = IIF(loc_oBO.this_nBlqinss = 1, 1, 0))
1393: 
1394:             *-- OptionGroups: usa valor gravado se dentro da faixa, senao default
1395:             loc_oPg2.obj_4c_Op_TipoNF.Value    = IIF(BETWEEN(loc_oBO.this_nTiponfs, 1, 4), loc_oBO.this_nTiponfs, 1)
1396:             loc_oPg2.obj_4c_Fwoption2.Value    = IIF(BETWEEN(loc_oBO.this_nNnfobrigs, 1, 2), loc_oBO.this_nNnfobrigs, 1)
1397:             loc_oPg2.obj_4c_Op_AlteraPeso.Value = IIF(BETWEEN(loc_oBO.this_nImpnfs, 1, 3), loc_oBO.this_nImpnfs, 1)
1398:             loc_oPg2.obj_4c_Optiongroup1.Value = IIF(BETWEEN(loc_oBO.this_nMostecfs, 1, 2), loc_oBO.this_nMostecfs, 1)
1399:             loc_oPg2.obj_4c_Fwoption1.Value    = IIF(BETWEEN(loc_oBO.this_nTpservicos, 1, 3), loc_oBO.this_nTpservicos, 2)
1400:             loc_oPg2.obj_4c_OptSeloTrans.Value = IIF(BETWEEN(loc_oBO.this_nSelotrans, 1, 2), loc_oBO.this_nSelotrans, 1)
1401: 
1402:             *-- Reseta guardas de lookup (Problema 45) com os valores recem-carregados,
1403:             *-- evitando reabertura indevida do lookup no primeiro LostFocus
1404:             THIS.this_cUltimoEmpValidado  = loc_oPg2.txt_4c_Emps.Value
1405:             THIS.this_cUltimoDEmpValidado = loc_oPg2.txt_4c_DEmps.Value
1406: 
1407:             THIS.AjustarChkBlqInss()
1408:         CATCH TO loException
1409:             MsgErro(loException.Message, "FormSre.BOParaForm")
1410:         ENDTRY
1411:     ENDPROC
1412: 
1413:     *--------------------------------------------------------------------------
1414:     * LimparCampos - Limpa todos os campos da Page2 e restaura valores default
1415:     * dos OptionGroups (mesmos defaults usados em ConfigurarPaginaDados)
1416:     *--------------------------------------------------------------------------
1417:     PROTECTED PROCEDURE LimparCampos()
1418:         LOCAL loc_oPg2
1419:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1420: 
1421:         TRY
1422:             loc_oPg2.txt_4c_Codigo.Value    = ""
1423:             loc_oPg2.txt_4c_Descricao.Value = ""
1424:             loc_oPg2.txt_4c_Emps.Value      = ""
1425:             loc_oPg2.txt_4c_DEmps.Value     = ""
1426:             loc_oPg2.txt_4c_Modelo.Value    = ""
1427:             loc_oPg2.txt_4c_Tiponf.Value    = ""
1428:             loc_oPg2.txt_4c_Inicials.Value  = ""
1429:             loc_oPg2.txt_4c_Finals.Value    = ""
1430: 
1431:             loc_oPg2.chk_4c_Ck_BlqInss.Value = 0
1432: 
1433:             loc_oPg2.obj_4c_Op_TipoNF.Value     = 1  && Automatico
1434:             loc_oPg2.obj_4c_Fwoption2.Value     = 1  && Opcional
1435:             loc_oPg2.obj_4c_Op_AlteraPeso.Value = 1  && Sim
1436:             loc_oPg2.obj_4c_Optiongroup1.Value  = 1  && Sim
1437:             loc_oPg2.obj_4c_Fwoption1.Value     = 2  && Nao
1438:             loc_oPg2.obj_4c_OptSeloTrans.Value  = 1  && Sim
1439: 
1440:             THIS.this_cUltimoEmpValidado  = ""
1441:             THIS.this_cUltimoDEmpValidado = ""
1442: 
1443:             THIS.AjustarChkBlqInss()
1444:         CATCH TO loException
1445:             MsgErro(loException.Message, "FormSre.LimparCampos")
1446:         ENDTRY
1447:     ENDPROC
1448: 
1449:     *--------------------------------------------------------------------------
1450:     * HabilitarCampos - Habilita/desabilita campos da Page2 conforme modo
1451:     * Regras extraidas do comportamento.json (eventos When de cada controle):
1452:     * - Codigo: editavel em INCLUIR e BUSCAR (Getcods.When -> nao em ALTERAR/CONSULTAR)
1453:     * - Emps/DEmps: editaveis somente em INCLUIR
1454:     * - Descricao/Modelo/TipoNF/Inicial/Final: editaveis em INCLUIR e ALTERAR
1455:     * - OptionGroups: habilitados em INCLUIR e ALTERAR
1456:     * - ck_BlqInss: habilitado em INCLUIR/ALTERAR E Imprime NF (Op_AlteraPeso) = Sim
1457:     *--------------------------------------------------------------------------
1458:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1459:         LOCAL loc_oPg2, loc_lEdit, loc_lIncluir, loc_lCodBusca
1460:         loc_oPg2      = THIS.pgf_4c_Paginas.Page2
1461:         loc_lEdit     = (VARTYPE(par_lHabilitar) = "L" AND par_lHabilitar)
1462:         loc_lIncluir  = (loc_lEdit AND THIS.this_cModoAtual = "INCLUIR")
1463:         loc_lCodBusca = (loc_lEdit AND INLIST(THIS.this_cModoAtual, "INCLUIR", "BUSCAR"))
1464: 
1465:         TRY
1466:             loc_oPg2.txt_4c_Codigo.ReadOnly    = !loc_lCodBusca
1467:             loc_oPg2.txt_4c_Emps.ReadOnly      = !loc_lIncluir
1468:             loc_oPg2.txt_4c_DEmps.ReadOnly     = !loc_lIncluir
1469: 
1470:             loc_oPg2.txt_4c_Descricao.ReadOnly = !loc_lEdit
1471:             loc_oPg2.txt_4c_Modelo.ReadOnly    = !loc_lEdit
1472:             loc_oPg2.txt_4c_Tiponf.ReadOnly    = !loc_lEdit
1473:             loc_oPg2.txt_4c_Inicials.ReadOnly  = !loc_lEdit
1474:             loc_oPg2.txt_4c_Finals.ReadOnly    = !loc_lEdit
1475: 
1476:             loc_oPg2.obj_4c_Op_TipoNF.Enabled     = loc_lEdit
1477:             loc_oPg2.obj_4c_Fwoption2.Enabled     = loc_lEdit
1478:             loc_oPg2.obj_4c_Op_AlteraPeso.Enabled = loc_lEdit
1479:             loc_oPg2.obj_4c_Optiongroup1.Enabled  = loc_lEdit
1480:             loc_oPg2.obj_4c_Fwoption1.Enabled     = loc_lEdit
1481:             loc_oPg2.obj_4c_OptSeloTrans.Enabled  = loc_lEdit
1482: 
1483:             THIS.AjustarChkBlqInss()
1484:             THIS.AjustarBotoesPorModo()
1485:         CATCH TO loException
1486:             MsgErro(loException.Message, "FormSre.HabilitarCampos")
1487:         ENDTRY
1488:     ENDPROC
1489: 
1490:     *--------------------------------------------------------------------------
1491:     * AjustarBotoesPorModo - Habilita/desabilita cmd_4c_Confirmar/cmd_4c_Cancelar
1492:     * conforme o modo atual. Confirmar fica habilitado em INCLUIR/ALTERAR/BUSCAR
1493:     * e tambem em EXCLUIR (usuario precisa confirmar a exclusao do registro).
1494:     *--------------------------------------------------------------------------
1495:     PROCEDURE AjustarBotoesPorModo()
1496:         LOCAL loc_oBotoesAcao
1497: 
1498:         TRY
1499:             loc_oBotoesAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
1500:             loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "BUSCAR", "EXCLUIR")
1501:             loc_oBotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1502:         CATCH TO loException
1503:             MsgErro(loException.Message, "FormSre.AjustarBotoesPorModo")
1504:         ENDTRY
1505:     ENDPROC
1506: 
1507:     *--------------------------------------------------------------------------
1508:     * AjustarChkBlqInss - Recalcula o Enabled de chk_4c_Ck_BlqInss. So fica
1509:     * habilitado quando o form esta em edicao (INCLUIR/ALTERAR) E Imprime NF
1510:     * (obj_4c_Op_AlteraPeso) = 1 (Sim). Reproduz o When original:
1511:     * inlist(pcEscolha,'INSERIR','ALTERAR') and CrSigCdSer.impnfs = 1
1512:     * Ligado tambem ao InteractiveChange de obj_4c_Op_AlteraPeso (Problema 31).
1513:     *--------------------------------------------------------------------------
1514:     PROCEDURE AjustarChkBlqInss()
1515:         LOCAL loc_oPg2, loc_lEdit
1516: 
1517:         TRY
1518:             loc_oPg2  = THIS.pgf_4c_Paginas.Page2
1519:             loc_lEdit = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1520:             loc_oPg2.chk_4c_Ck_BlqInss.Enabled = (loc_lEdit AND loc_oPg2.obj_4c_Op_AlteraPeso.Value = 1)
1521:         CATCH TO loException
1522:             MsgErro(loException.Message, "FormSre.AjustarChkBlqInss")
1523:         ENDTRY
1524:     ENDPROC
1525: 
1526:     *--------------------------------------------------------------------------
1527:     * BtnIncluirClick - Inicia inclusao de nova serie de nota fiscal
1528:     * Legado: do case pcEscolha='INSERIR' -> foco em getEmps
1529:     *--------------------------------------------------------------------------
1530:     PROCEDURE BtnIncluirClick()
1531:         TRY
1532:             THIS.this_oBusinessObject.NovoRegistro()
1533:             THIS.LimparCampos()
1534:             THIS.this_cModoAtual = "INCLUIR"
1535:             THIS.HabilitarCampos(.T.)
1536:             THIS.AlternarPagina(2)
1537:             THIS.pgf_4c_Paginas.Page2.txt_4c_Emps.SetFocus
1538:         CATCH TO loException
1539:             MsgErro(loException.Message, "FormSre.BtnIncluirClick")
1540:         ENDTRY
1541:     ENDPROC
1542: 
1543:     *--------------------------------------------------------------------------
1544:     * BtnVisualizarClick - Abre registro selecionado para visualizacao
1545:     *--------------------------------------------------------------------------
1546:     PROCEDURE BtnVisualizarClick()
1547:         LOCAL loc_cEmpCods
1548:         loc_cEmpCods = ""
1549: 
1550:         TRY
1551:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1552:                 SELECT cursor_4c_Dados
1553:                 loc_cEmpCods = ALLTRIM(cursor_4c_Dados.empcods)
1554:             ENDIF
1555: 
1556:             IF EMPTY(loc_cEmpCods)
1557:                 MsgAviso("Selecione um registro na lista.", "Aviso")
1558:             ELSE
1559:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cEmpCods)
1560:                     THIS.LimparCampos()
1561:                     THIS.BOParaForm()
1562:                     THIS.this_cModoAtual = "VISUALIZAR"
1563:                     THIS.HabilitarCampos(.F.)
1564:                     THIS.AlternarPagina(2)
1565:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
1566:                 ENDIF
1567:             ENDIF
1568:         CATCH TO loException
1569:             MsgErro(loException.Message, "FormSre.BtnVisualizarClick")
1570:         ENDTRY
1571:     ENDPROC
1572: 
1573:     *--------------------------------------------------------------------------
1574:     * BtnAlterarClick - Abre registro selecionado para alteracao
1575:     *--------------------------------------------------------------------------
1576:     PROCEDURE BtnAlterarClick()
1577:         LOCAL loc_cEmpCods
1578:         loc_cEmpCods = ""
1579: 
1580:         TRY
1581:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1582:                 SELECT cursor_4c_Dados
1583:                 loc_cEmpCods = ALLTRIM(cursor_4c_Dados.empcods)
1584:             ENDIF
1585: 
1586:             IF EMPTY(loc_cEmpCods)
1587:                 MsgAviso("Selecione um registro na lista.", "Aviso")
1588:             ELSE
1589:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cEmpCods)
1590:                     THIS.this_oBusinessObject.EditarRegistro()
1591:                     THIS.LimparCampos()
1592:                     THIS.BOParaForm()
1593:                     THIS.this_cModoAtual = "ALTERAR"
1594:                     THIS.HabilitarCampos(.T.)
1595:                     THIS.AlternarPagina(2)
1596:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Descricao.SetFocus
1597:                 ENDIF
1598:             ENDIF
1599:         CATCH TO loException
1600:             MsgErro(loException.Message, "FormSre.BtnAlterarClick")
1601:         ENDTRY
1602:     ENDPROC
1603: 
1604:     *--------------------------------------------------------------------------
1605:     * BtnExcluirClick - Prepara exclusao do registro selecionado (a exclusao
1606:     * de fato ocorre na confirmacao via cmd_4c_Confirmar - Fase 8)
1607:     *--------------------------------------------------------------------------
1608:     PROCEDURE BtnExcluirClick()
1609:         LOCAL loc_cEmpCods
1610:         loc_cEmpCods = ""
1611: 
1612:         TRY
1613:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1614:                 SELECT cursor_4c_Dados
1615:                 loc_cEmpCods = ALLTRIM(cursor_4c_Dados.empcods)
1616:             ENDIF
1617: 
1618:             IF EMPTY(loc_cEmpCods)
1619:                 MsgAviso("Selecione um registro na lista.", "Aviso")
1620:             ELSE
1621:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cEmpCods)
1622:                     THIS.LimparCampos()
1623:                     THIS.BOParaForm()
1624:                     THIS.this_cModoAtual = "EXCLUIR"
1625:                     THIS.HabilitarCampos(.F.)
1626:                     THIS.AlternarPagina(2)
1627:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
1628:                 ENDIF
1629:             ENDIF
1630:         CATCH TO loException
1631:             MsgErro(loException.Message, "FormSre.BtnExcluirClick")
1632:         ENDTRY
1633:     ENDPROC
1634: 
1635:     *--------------------------------------------------------------------------
1636:     * FormParaBO - Transfere valores do Form (Page2) para o Business Object
1637:     * this_cEmpCods (PK) eh recalculado internamente pelo BO (ValidarDados/
1638:     * Inserir) a partir de this_cEmps + this_cCodigo, nao precisa ser setado aqui
1639:     *--------------------------------------------------------------------------
1640:     PROTECTED PROCEDURE FormParaBO()
1641:         LOCAL loc_oPg2, loc_oBO, loc_lResultado
1642:         loc_lResultado = .F.
1643:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1644:         loc_oBO  = THIS.this_oBusinessObject
1645: 
1646:         TRY
1647:             loc_oBO.this_cCodigo     = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
1648:             loc_oBO.this_cDescricao  = ALLTRIM(loc_oPg2.txt_4c_Descricao.Value)
1649:             loc_oBO.this_cEmps       = ALLTRIM(loc_oPg2.txt_4c_Emps.Value)
1650:             loc_oBO.this_cModelos    = ALLTRIM(loc_oPg2.txt_4c_Modelo.Value)
1651:             loc_oBO.this_cCtiponfs   = ALLTRIM(loc_oPg2.txt_4c_Tiponf.Value)
1652:             loc_oBO.this_cInicials   = ALLTRIM(loc_oPg2.txt_4c_Inicials.Value)
1653:             loc_oBO.this_cFinals     = ALLTRIM(loc_oPg2.txt_4c_Finals.Value)
1654: 
1655:             loc_oBO.this_nBlqinss    = IIF(loc_oPg2.chk_4c_Ck_BlqInss.Value, 1, 0)
1656: 
1657:             loc_oBO.this_nTiponfs    = loc_oPg2.obj_4c_Op_TipoNF.Value
1658:             loc_oBO.this_nNnfobrigs  = loc_oPg2.obj_4c_Fwoption2.Value
1659:             loc_oBO.this_nImpnfs     = loc_oPg2.obj_4c_Op_AlteraPeso.Value
1660:             loc_oBO.this_nMostecfs   = loc_oPg2.obj_4c_Optiongroup1.Value
1661:             loc_oBO.this_nTpservicos = loc_oPg2.obj_4c_Fwoption1.Value
1662:             loc_oBO.this_nSelotrans  = loc_oPg2.obj_4c_OptSeloTrans.Value
1663: 
1664:             loc_lResultado = .T.
1665:         CATCH TO loException
1666:             MsgErro(loException.Message, "FormSre.FormParaBO")
1667:         ENDTRY
1668: 
1669:         RETURN loc_lResultado
1670:     ENDPROC
1671: 
1672:     *--------------------------------------------------------------------------
1673:     * BtnBuscarClick - Vai para Page2 no modo BUSCAR (Codigo ou Descricao)
1674:     * Legado: Procedure de Buscar localiza por Getcods, senao por Getdescs
1675:     *--------------------------------------------------------------------------
1676:     PROCEDURE BtnBuscarClick()
1677:         TRY
1678:             THIS.this_oBusinessObject.NovoRegistro()
1679:             THIS.LimparCampos()
1680:             THIS.this_cModoAtual = "BUSCAR"
1681:             THIS.HabilitarCampos(.T.)
1682:             THIS.AlternarPagina(2)
1683:             THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.SetFocus
1684:         CATCH TO loException
1685:             MsgErro(loException.Message, "FormSre.BtnBuscarClick")
1686:         ENDTRY
1687:     ENDPROC
1688: 
1689:     *--------------------------------------------------------------------------
1690:     * BtnEncerrarClick - Fecha o formulario
1691:     *--------------------------------------------------------------------------
1692:     PROCEDURE BtnEncerrarClick()
1693:         THIS.Release()
1694:     ENDPROC
1695: 
1696:     *--------------------------------------------------------------------------
1697:     * BtnSalvarClick (Confirmar) - Comportamento depende do this_cModoAtual:
1698:     * - BUSCAR:  localiza na grade por Codigo (prioridade) ou Descricao
1699:     * - EXCLUIR: confirma e executa a exclusao
1700:     * - INCLUIR/ALTERAR: valida campos obrigatorios e salva
1701:     *--------------------------------------------------------------------------
1702:     PROCEDURE BtnSalvarClick()
1703:         LOCAL loc_oPg2, loc_cCodBusca, loc_cDescBusca, loc_lResultado
1704:         loc_lResultado = .F.
1705:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1706: 
1707:         IF THIS.this_cModoAtual = "BUSCAR"
1708:             TRY
1709:                 loc_cCodBusca  = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
1710:                 loc_cDescBusca = ALLTRIM(loc_oPg2.txt_4c_Descricao.Value)
1711: 
1712:                 THIS.this_cModoAtual = "LISTA"
1713:                 THIS.AlternarPagina(1)
1714: 
1715:                 IF USED("cursor_4c_Dados")
1716:                     SELECT cursor_4c_Dados
1717:                     IF !EMPTY(loc_cCodBusca)
1718:                         LOCATE FOR ALLTRIM(cursor_4c_Dados.cods) = loc_cCodBusca
1719:                     ELSE
1720:                         IF !EMPTY(loc_cDescBusca)
1721:                             LOCATE FOR UPPER(ALLTRIM(cursor_4c_Dados.descs)) = UPPER(loc_cDescBusca)
1722:                         ENDIF
1723:                     ENDIF
1724:                     IF !FOUND()
1725:                         GO TOP IN cursor_4c_Dados
1726:                     ENDIF
1727:                 ENDIF
1728:                 loc_lResultado = .T.
1729:             CATCH TO loException
1730:                 MsgErro(loException.Message, "FormSre.BtnSalvarClick")
1731:             ENDTRY
1732: 
1733:             RETURN loc_lResultado
1734:         ENDIF
1735: 
1736:         IF THIS.this_cModoAtual = "EXCLUIR"
1737:             TRY
1738:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o desta s" + CHR(233) + "rie?", "Excluir")
1739:                     IF THIS.this_oBusinessObject.Excluir()
1740:                         MsgInfo("S" + CHR(233) + "rie exclu" + CHR(237) + "da com sucesso!")
1741:                         THIS.this_cModoAtual = "LISTA"
1742:                         THIS.AlternarPagina(1)

*-- Linhas 1756 a 1885:
1756: 
1757:         *-- INCLUIR/ALTERAR: validacoes obrigatorias FORA do TRY (CLAUDE.md #1)
1758:         IF THIS.this_cModoAtual = "INCLUIR" AND EMPTY(ALLTRIM(loc_oPg2.txt_4c_Emps.Value))
1759:             MsgAviso("Empresa " + CHR(233) + " obrigat" + CHR(243) + "ria.", "")
1760:             loc_oPg2.txt_4c_Emps.SetFocus
1761:             RETURN .F.
1762:         ENDIF
1763: 
1764:         IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Codigo.Value))
1765:             MsgAviso("S" + CHR(233) + "rie inv" + CHR(225) + "lida.", "")
1766:             loc_oPg2.txt_4c_Codigo.SetFocus
1767:             RETURN .F.
1768:         ENDIF
1769: 
1770:         IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Tiponf.Value))
1771:             MsgAviso("Tipo Nota Fiscal.", "")
1772:             loc_oPg2.txt_4c_Tiponf.SetFocus
1773:             RETURN .F.
1774:         ENDIF
1775: 
1776:         TRY
1777:             IF THIS.FormParaBO()
1778:                 IF THIS.this_oBusinessObject.Salvar()
1779:                     MsgInfo("S" + CHR(233) + "rie salva com sucesso!")
1780:                     THIS.this_cModoAtual = "LISTA"
1781:                     THIS.AlternarPagina(1)
1782:                     loc_lResultado = .T.
1783:                 ELSE
1784:                     IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
1785:                         MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro ao Salvar")
1786:                     ENDIF
1787:                 ENDIF
1788:             ENDIF
1789:         CATCH TO loException
1790:             MsgErro(loException.Message, "FormSre.BtnSalvarClick")
1791:         ENDTRY
1792: 
1793:         RETURN loc_lResultado
1794:     ENDPROC
1795: 
1796:     *--------------------------------------------------------------------------
1797:     * BtnCancelarClick - Cancela edicao/busca e volta para a lista
1798:     *--------------------------------------------------------------------------
1799:     PROCEDURE BtnCancelarClick()
1800:         TRY
1801:             THIS.this_cModoAtual = "LISTA"
1802:             THIS.AlternarPagina(1)
1803:         CATCH TO loException
1804:             MsgErro(loException.Message, "FormSre.BtnCancelarClick")
1805:         ENDTRY
1806:     ENDPROC
1807: 
1808:     *--------------------------------------------------------------------------
1809:     * TornarControlesVisiveis - Torna visiveis todos os controles do
1810:     * container, percorrendo Pages (PageFrame) e Controls recursivamente
1811:     *--------------------------------------------------------------------------
1812:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1813:         LOCAL loc_nI, loc_oObjeto, loc_nP
1814: 
1815:         IF VARTYPE(par_oContainer) != "O"
1816:             RETURN
1817:         ENDIF
1818: 
1819:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1820:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1821: 
1822:             IF VARTYPE(loc_oObjeto) = "O"
1823:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1824:                     loc_oObjeto.Visible = .T.
1825:                 ENDIF
1826: 
1827:                 *-- Trata PageFrame - itera Pages
1828:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1829:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1830:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1831:                     ENDFOR
1832:                 ENDIF
1833: 
1834:                 *-- Trata containers com ControlCount
1835:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1836:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1837:                 ENDIF
1838:             ENDIF
1839:         ENDFOR
1840:     ENDPROC
1841: 
1842:     *--------------------------------------------------------------------------
1843:     * CarregarLista - Busca series de nota fiscal e carrega grid da Page1
1844:     *--------------------------------------------------------------------------
1845:     PROCEDURE CarregarLista()
1846:         LOCAL loc_lResultado, loc_oGrid
1847:         loc_lResultado = .F.
1848: 
1849:         TRY
1850:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1851:                 SET NULL ON
1852:                 CREATE CURSOR cursor_4c_Dados (empcods C(6), emps C(3), cods C(3), descs C(20), ctiponfs C(5))
1853:                 SET NULL OFF
1854:                 loc_lResultado = .T.
1855:             ELSE
1856:                 IF THIS.this_oBusinessObject.Buscar("")
1857:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
1858:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1859: 
1860:                         loc_oGrid.ColumnCount  = 4
1861:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
1862:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.emps"
1863:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.cods"
1864:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.descs"
1865:                         loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.ctiponfs"
1866: 
1867:                         loc_oGrid.Column1.Width = 90
1868:                         loc_oGrid.Column2.Width = 140
1869:                         loc_oGrid.Column3.Width = 460
1870:                         loc_oGrid.Column4.Width = 170
1871: 
1872:                         loc_oGrid.Column1.ReadOnly = .T.
1873:                         loc_oGrid.Column2.ReadOnly = .T.
1874:                         loc_oGrid.Column3.ReadOnly = .T.
1875:                         loc_oGrid.Column4.ReadOnly = .T.
1876: 
1877:                         loc_oGrid.Column1.Header1.Caption = "Emp"
1878:                         loc_oGrid.Column2.Header1.Caption = "C" + CHR(243) + "digo"
1879:                         loc_oGrid.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1880:                         loc_oGrid.Column4.Header1.Caption = "Tipo N.F."
1881: 
1882:                         THIS.FormatarGridLista(loc_oGrid)
1883:                     ENDIF
1884:                     loc_lResultado = .T.
1885:                 ENDIF

*-- Linhas 1894 a 1944:
1894:     *--------------------------------------------------------------------------
1895:     * FormatarGridLista - Formata visual do grid da lista
1896:     *--------------------------------------------------------------------------
1897:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1898:         WITH par_oGrid
1899:             .FontName = "Tahoma"
1900:             .FontSize = 8
1901:         ENDWITH
1902:     ENDPROC
1903: 
1904:     *--------------------------------------------------------------------------
1905:     * AlternarPagina - Alterna entre Lista (1) e Dados (2)
1906:     *--------------------------------------------------------------------------
1907:     PROCEDURE AlternarPagina(par_nPagina)
1908:         LOCAL loc_lResultado
1909:         loc_lResultado = .F.
1910: 
1911:         TRY
1912:             IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
1913:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1914:                 IF par_nPagina = 1
1915:                     THIS.CarregarLista()
1916:                 ENDIF
1917:                 loc_lResultado = .T.
1918:             ENDIF
1919:         CATCH TO loc_oErro
1920:             MsgErro(loc_oErro.Message, "FormSre.AlternarPagina")
1921:         ENDTRY
1922: 
1923:         RETURN loc_lResultado
1924:     ENDPROC
1925: 
1926:     *--------------------------------------------------------------------------
1927:     * Destroy - Libera Business Object e cursores abertos pelo form
1928:     *--------------------------------------------------------------------------
1929:     PROCEDURE Destroy()
1930:         TRY
1931:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1932:                 THIS.this_oBusinessObject = .NULL.
1933:             ENDIF
1934:             IF USED("cursor_4c_Dados")
1935:                 USE IN cursor_4c_Dados
1936:             ENDIF
1937:         CATCH TO loc_oErro
1938:             MsgErro(loc_oErro.Message, "FormSre.Destroy")
1939:         ENDTRY
1940: 
1941:         DODEFAULT()
1942:     ENDPROC
1943: 
1944: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SreBO.prg):
*====================================================================
* SreBO.prg
*
* Business Object para Cadastro de Serie de Nota Fiscal
* Tabela: SigCdSer
* Chave Primaria: EmpCods (char(6) = Emps + Cods)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SreBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdSer)
    this_cEmpCods    = ""    && empcods  char(6) - PK (concatenacao de Emps + Cods)
    this_cEmps       = ""    && cemps     char(3) - Empresa (FK SigCdEmp.CEmps)
    this_cDEmps      = ""    && Descricao da empresa (SigCdEmp.Razas) - somente exibicao, nao persistido
    this_cCodigo     = ""    && cods     char(3) - Codigo da serie
    this_cDescricao  = ""    && descs    char(20) - Descricao da serie
    this_nImpnfs     = 0     && impnfs   numeric(1,0) - Imprime NF: 1=Sim 2=Nao 3=Eletronica
    this_nTiponfs    = 0     && tiponfs  numeric(1,0) - Tipo NF: 1=Automatico 2=Manual 3=AutomaticoSemAlteracao 4=Documento
    this_cModelos    = ""    && modelos  char(2) - Modelo da nota fiscal
    this_cCtiponfs   = ""    && ctiponfs char(5) - Tipo N.F. (codigo complementar)
    this_nMostecfs   = 0     && mostecfs numeric(1,0) - Mostra Dados ECF Fiscal: 1=Sim 2=Nao
    this_nTpservicos = 0     && tpservicos numeric(1,0) - Servicos: 1=Sim 2=Nao 3=SimComItens
    this_nNnfobrigs  = 0     && nnfobrigs numeric(1,0) - Numeracao de NF: 1=Opcional 2=Obrigatoria
    this_nBlqinss    = 0     && blqinss  numeric(1,0) - Bloquear NF Caso Exista Anterior Nao Impressa
    this_nSelotrans  = 0     && selotrans numeric(1,0) - Selo Transporte: 1=Sim 2=Nao
    this_cInicials   = ""    && inicials char(2) - Selo Transporte Inicial
    this_cFinals     = ""    && finals   char(2) - Selo Transporte Final
    this_cCoddisp    = ""    && coddisp  char(2) - Codigo dispositivo (nao editado neste formulario, mantido por fidelidade de schema)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdSer"
            THIS.this_cCampoChave = "EmpCods"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SreBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria (EmpCods) para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cEmpCods)
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cEmpCods    = TratarNulo(empcods,    "C")
                THIS.this_cEmps       = TratarNulo(emps,       "C")
                THIS.this_cCodigo     = TratarNulo(cods,       "C")
                THIS.this_cDescricao  = TratarNulo(descs,      "C")
                THIS.this_nImpnfs     = TratarNulo(impnfs,     "N")
                THIS.this_nTiponfs    = TratarNulo(tiponfs,    "N")
                THIS.this_cModelos    = TratarNulo(modelos,    "C")
                THIS.this_cCtiponfs   = TratarNulo(ctiponfs,   "C")
                THIS.this_nMostecfs   = TratarNulo(mostecfs,   "N")
                THIS.this_nTpservicos = TratarNulo(tpservicos, "N")
                THIS.this_nNnfobrigs  = TratarNulo(nnfobrigs,  "N")
                THIS.this_nBlqinss    = TratarNulo(blqinss,    "N")
                THIS.this_nSelotrans  = TratarNulo(selotrans,  "N")
                THIS.this_cInicials   = TratarNulo(inicials,   "C")
                THIS.this_cFinals     = TratarNulo(finals,     "C")
                THIS.this_cCoddisp    = TratarNulo(coddisp,    "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "SreBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar (reproduz Grupo_Salva.Click)
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cCodigo))
            MsgAviso("S" + CHR(233) + "rie inv" + CHR(225) + "lida.")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            THIS.this_cEmpCods = PADR(ALLTRIM(THIS.this_cEmps), 3) + PADR(ALLTRIM(THIS.this_cCodigo), 3)
            IF THIS.VerificarChaveExistente(THIS.this_cEmpCods)
                MsgAviso("S" + CHR(233) + "rie j" + CHR(225) + " cadastrada.")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cCtiponfs))
            MsgAviso("Tipo Nota Fiscal.")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * VerificarChaveExistente - Verifica se EmpCods ja existe (equivalente
    * a ChkRegister('SigCdSer','EmpCods',lcKey) do legado)
    *====================================================================
    PROCEDURE VerificarChaveExistente(par_cEmpCods)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdSer" + ;
                " WHERE empcods = " + EscaparSQL(par_cEmpCods)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkEmpCods")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkEmpCods")
                SELECT cursor_4c_ChkEmpCods
                loc_lExiste = (cursor_4c_ChkEmpCods.qtd > 0)
                USE IN cursor_4c_ChkEmpCods
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar chave:" + CHR(13) + loException.Message, "SreBO.VerificarChaveExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigCdSer
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cEmpCods = PADR(ALLTRIM(THIS.this_cEmps), 3) + PADR(ALLTRIM(THIS.this_cCodigo), 3)

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdSer (empcods, emps, cods, descs, impnfs,
                    tiponfs, modelos, ctiponfs, mostecfs, tpservicos,
                    nnfobrigs, blqinss, selotrans, inicials, finals, coddisp)
                VALUES (
                    <<EscaparSQL(THIS.this_cEmpCods)>>,
                    <<EscaparSQL(THIS.this_cEmps)>>,
                    <<EscaparSQL(THIS.this_cCodigo)>>,
                    <<EscaparSQL(THIS.this_cDescricao)>>,
                    <<FormatarNumeroSQL(THIS.this_nImpnfs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nTiponfs, 0)>>,
                    <<EscaparSQL(THIS.this_cModelos)>>,
                    <<EscaparSQL(THIS.this_cCtiponfs)>>,
                    <<FormatarNumeroSQL(THIS.this_nMostecfs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nTpservicos, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nNnfobrigs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nBlqinss, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nSelotrans, 0)>>,
                    <<EscaparSQL(THIS.this_cInicials)>>,
                    <<EscaparSQL(THIS.this_cFinals)>>,
                    <<EscaparSQL(THIS.this_cCoddisp)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir s" + CHR(233) + "rie:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "SreBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdSer
    * OBS: empcods/emps/cods sao a chave e nao sao alterados no UPDATE
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdSer
                SET descs      = <<EscaparSQL(THIS.this_cDescricao)>>,
                    impnfs     = <<FormatarNumeroSQL(THIS.this_nImpnfs, 0)>>,
                    tiponfs    = <<FormatarNumeroSQL(THIS.this_nTiponfs, 0)>>,
                    modelos    = <<EscaparSQL(THIS.this_cModelos)>>,
                    ctiponfs   = <<EscaparSQL(THIS.this_cCtiponfs)>>,
                    mostecfs   = <<FormatarNumeroSQL(THIS.this_nMostecfs, 0)>>,
                    tpservicos = <<FormatarNumeroSQL(THIS.this_nTpservicos, 0)>>,
                    nnfobrigs  = <<FormatarNumeroSQL(THIS.this_nNnfobrigs, 0)>>,
                    blqinss    = <<FormatarNumeroSQL(THIS.this_nBlqinss, 0)>>,
                    selotrans  = <<FormatarNumeroSQL(THIS.this_nSelotrans, 0)>>,
                    inicials   = <<EscaparSQL(THIS.this_cInicials)>>,
                    finals     = <<EscaparSQL(THIS.this_cFinals)>>,
                    coddisp    = <<EscaparSQL(THIS.this_cCoddisp)>>
                WHERE empcods = <<EscaparSQL(THIS.this_cEmpCods)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar s" + CHR(233) + "rie:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "SreBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdSer
    * Verifica uso em Notas Fiscais (SigMvNfi.series) antes de excluir
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nUso
        loc_lSucesso = .F.
        loc_nUso     = 0

        TRY
            *-- Verificar se a serie esta sendo usada em Notas Fiscais
            loc_cSQL = "SELECT COUNT(*) AS nNreg1s FROM SigMvNfi" + ;
                " WHERE series = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkNfi")

            IF loc_nResultado < 0
                MostrarErro("Erro ao verificar depend" + CHR(234) + "ncias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_ChkNfi")
                    SELECT cursor_4c_ChkNfi
                    loc_nUso = NVL(cursor_4c_ChkNfi.nNreg1s, 0)
                    USE IN cursor_4c_ChkNfi
                ENDIF

                IF loc_nUso > 0
                    MsgAviso("S" + CHR(233) + "rie n" + CHR(227) + "o pode ser excluida pois est" + CHR(225) + " sendo usada em Notas Fiscais!")
                ELSE
                    loc_cSQL = "DELETE FROM SigCdSer WHERE empcods = " + EscaparSQL(THIS.this_cEmpCods)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResultado >= 0
                        THIS.RegistrarAuditoria("DELETE")
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao excluir s" + CHR(233) + "rie:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "SreBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com empcods, emps, cods, descs, ctiponfs
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (empcods C(6), emps C(3), cods C(3), descs C(20), ctiponfs C(5))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT empcods, emps, cods, descs, ctiponfs FROM SigCdSer"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY empcods"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar s" + CHR(233) + "ries:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "SreBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (EmpCods)
    * par_cCodigo eh o EmpCods completo (Emps + Cods, 6 caracteres)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT empcods, emps, cods, descs, impnfs, tiponfs," + ;
                " modelos, ctiponfs, mostecfs, tpservicos, nnfobrigs," + ;
                " blqinss, selotrans, inicials, finals, coddisp" + ;
                " FROM SigCdSer WHERE empcods = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("S" + CHR(233) + "rie n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar s" + CHR(233) + "rie:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "SreBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * BuscarDescricaoEmpresa - Retorna Razas (SigCdEmp) para exibicao
    * (equivalente a CursorQuery('SigCdEmp','crSigCdEmp','Cemps',Cemps) do legado)
    *====================================================================
    PROCEDURE BuscarDescricaoEmpresa(par_cEmps)
        LOCAL loc_cSQL, loc_nResultado, loc_cDescricao
        loc_cDescricao = ""

        TRY
            IF !EMPTY(ALLTRIM(par_cEmps))
                loc_cSQL = "SELECT razas FROM SigCdEmp WHERE cemps = " + EscaparSQL(par_cEmps)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emp")
                IF loc_nResultado >= 0 AND USED("cursor_4c_Emp")
                    SELECT cursor_4c_Emp
                    IF RECCOUNT() > 0
                        loc_cDescricao = TratarNulo(razas, "C")
                    ENDIF
                    USE IN cursor_4c_Emp
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao buscar empresa:" + CHR(13) + loException.Message, "SreBO.BuscarDescricaoEmpresa")
        ENDTRY

        RETURN loc_cDescricao
    ENDPROC

ENDDEFINE

