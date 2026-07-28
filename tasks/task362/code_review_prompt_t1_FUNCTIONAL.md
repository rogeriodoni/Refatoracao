# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [BINDEVENT-PARAMS] Handler 'ValidarEstadosLista' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarEstadosLista(par_nKeyCode, par_nShiftAltCtrl)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCEP.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1484 linhas total):

*-- Linhas 33 a 164:
33: 
34:     *-- Filtro de UF (Page1): vazio = grid vazio (original: pUFs=Chr(254)*2 = sem registros)
35:     this_cUfFiltro             = ""
36:     this_cUltimoEstadoValidado = ""
37:     this_cCodUFs               = ""
38: 
39:     *--------------------------------------------------------------------------
40:     * Init - APENAS retorna DODEFAULT (FormBase.Init chama InicializarForm)
41:     *--------------------------------------------------------------------------
42:     PROCEDURE Init()
43:         LOCAL loc_lResultado
44:         loc_lResultado = .F.
45: 
46:         TRY
47:             loc_lResultado = DODEFAULT()
48:         CATCH TO loc_oErro
49:             MsgErro(loc_oErro.Message, "FormCEP.Init")
50:         ENDTRY
51: 
52:         RETURN loc_lResultado
53:     ENDPROC
54: 
55:     *--------------------------------------------------------------------------
56:     * InicializarForm - Configura estrutura completa
57:     * Chamado automaticamente pelo FormBase.Init()
58:     *--------------------------------------------------------------------------
59:     PROTECTED PROCEDURE InicializarForm()
60:         LOCAL loc_lResultado
61:         loc_lResultado = .F.
62: 
63:         TRY
64:             THIS.this_oBusinessObject = CREATEOBJECT("CEPBO")
65: 
66:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
67:                 MsgErro("Falha ao criar CEPBO", "Erro")
68:             ELSE
69:                 THIS.ConfigurarPageFrame()
70: 
71:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
72:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
73:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
74:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
75: 
76:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
77:                     THIS.CarregarLista()
78:                 ENDIF
79: 
80:                 THIS.pgf_4c_Paginas.Visible = .T.
81:                 THIS.pgf_4c_Paginas.ActivePage = 1
82:                 THIS.this_cModoAtual = "LISTA"
83:                 loc_lResultado = .T.
84:             ENDIF
85:         CATCH TO loc_oErro
86:             MsgErro(loc_oErro.Message, "FormCEP.InicializarForm")
87:         ENDTRY
88: 
89:         RETURN loc_lResultado
90:     ENDPROC
91: 
92:     *--------------------------------------------------------------------------
93:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
94:     *--------------------------------------------------------------------------
95:     PROTECTED PROCEDURE ConfigurarPageFrame()
96:         LOCAL loc_oPgf
97:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
98:         loc_oPgf = THIS.pgf_4c_Paginas
99: 
100:         WITH loc_oPgf
101:             .PageCount       = 2
102:             .Top             = -29
103:             .Left            = 0
104:             .Width           = THIS.Width
105:             .Height          = THIS.Height + 29
106:             .Tabs            = .F.
107:             .Visible         = .T.
108:             .Page1.Caption   = "Lista"
109:             .Page1.BackColor = RGB(100, 100, 100)
110:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
111:             .Page2.Caption   = "Dados"
112:             .Page2.BackColor = RGB(100, 100, 100)
113:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
114:         ENDWITH
115: 
116:         THIS.ConfigurarPaginaLista()
117:         THIS.ConfigurarPaginaDados()
118:     ENDPROC
119: 
120:     *--------------------------------------------------------------------------
121:     * ConfigurarPaginaLista - Configura Page1: cabecalho + botoes CRUD + saida
122:     * Fase 4 adiciona: grid de CEPs + filtro UF
123:     *--------------------------------------------------------------------------
124:     PROTECTED PROCEDURE ConfigurarPaginaLista()
125:         LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida, loc_oGrid
126:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
127: 
128:         *-- Container cabecalho cinza (Top = 2 + 29 = 31)
129:         loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
130:         loc_oCab = loc_oPg1.cnt_4c_Cabecalho
131:         WITH loc_oCab
132:             .Top         = 31
133:             .Left        = 0
134:             .Width       = THIS.Width
135:             .Height      = 80
136:             .BackColor   = RGB(100, 100, 100)
137:             .BorderWidth = 0
138:             .Visible     = .T.
139:         ENDWITH
140: 
141:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
142:         WITH loc_oCab.lbl_4c_Sombra
143:             .AutoSize  = .F.
144:             .Caption   = THIS.Caption
145:             .Top       = 15
146:             .Left      = 10
147:             .Width     = THIS.Width
148:             .Height    = 40
149:             .FontName  = "Tahoma"
150:             .FontSize  = 16
151:             .FontBold  = .T.
152:             .ForeColor = RGB(0, 0, 0)
153:             .BackStyle = 0
154:             .Visible   = .T.
155:         ENDWITH
156: 
157:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
158:         WITH loc_oCab.lbl_4c_Titulo
159:             .AutoSize  = .F.
160:             .Caption   = THIS.Caption
161:             .Top       = 18
162:             .Left      = 10
163:             .Width     = THIS.Width
164:             .Height    = 46

*-- Linhas 207 a 417:
207:             .AutoSize        = .F.
208:             .Visible         = .T.
209:         ENDWITH
210:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
211: 
212:         *-- Botao Visualizar
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
237:         *-- Botao Alterar
238:         loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
239:         WITH loc_oBotoes.cmd_4c_Alterar
240:             .Caption         = "Alterar"
241:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
242:             .PicturePosition = 13
243:             .Top             = 5
244:             .Left            = 155
245:             .Width           = 75
246:             .Height          = 75
247:             .BackColor       = RGB(255, 255, 255)
248:             .ForeColor       = RGB(90, 90, 90)
249:             .FontName        = "Tahoma"
250:             .FontSize        = 8
251:             .FontBold        = .T.
252:             .FontItalic      = .T.
253:             .Themes          = .F.
254:             .SpecialEffect   = 0
255:             .MousePointer    = 15
256:             .WordWrap        = .T.
257:             .AutoSize        = .F.
258:             .Visible         = .T.
259:         ENDWITH
260:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
261: 
262:         *-- Botao Excluir
263:         loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
264:         WITH loc_oBotoes.cmd_4c_Excluir
265:             .Caption         = "Excluir"
266:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
267:             .PicturePosition = 13
268:             .Top             = 5
269:             .Left            = 230
270:             .Width           = 75
271:             .Height          = 75
272:             .BackColor       = RGB(255, 255, 255)
273:             .ForeColor       = RGB(90, 90, 90)
274:             .FontName        = "Tahoma"
275:             .FontSize        = 8
276:             .FontBold        = .T.
277:             .FontItalic      = .T.
278:             .Themes          = .F.
279:             .SpecialEffect   = 0
280:             .MousePointer    = 15
281:             .WordWrap        = .T.
282:             .AutoSize        = .F.
283:             .Visible         = .T.
284:         ENDWITH
285:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
286: 
287:         *-- Botao Buscar
288:         loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
289:         WITH loc_oBotoes.cmd_4c_Buscar
290:             .Caption         = "Buscar"
291:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
292:             .PicturePosition = 13
293:             .Top             = 5
294:             .Left            = 305
295:             .Width           = 75
296:             .Height          = 75
297:             .BackColor       = RGB(255, 255, 255)
298:             .ForeColor       = RGB(90, 90, 90)
299:             .FontName        = "Tahoma"
300:             .FontSize        = 8
301:             .FontBold        = .T.
302:             .FontItalic      = .T.
303:             .Themes          = .F.
304:             .SpecialEffect   = 0
305:             .MousePointer    = 15
306:             .WordWrap        = .T.
307:             .AutoSize        = .F.
308:             .Visible         = .T.
309:         ENDWITH
310:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
311: 
312:         *-- Container Encerrar (canonico: Left=917, Width=90)
313:         loc_oPg1.AddObject("cnt_4c_Saida", "Container")
314:         loc_oSaida = loc_oPg1.cnt_4c_Saida
315:         WITH loc_oSaida
316:             .Top         = 29
317:             .Left        = 917
318:             .Width       = 90
319:             .Height      = 85
320:             .BackStyle   = 0
321:             .BorderWidth = 0
322:             .Visible     = .T.
323:         ENDWITH
324: 
325:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
326:         WITH loc_oSaida.cmd_4c_Encerrar
327:             .Caption         = "Encerrar"
328:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
329:             .PicturePosition = 13
330:             .Top             = 5
331:             .Left            = 5
332:             .Width           = 75
333:             .Height          = 75
334:             .BackColor       = RGB(255, 255, 255)
335:             .ForeColor       = RGB(90, 90, 90)
336:             .FontName        = "Tahoma"
337:             .FontSize        = 8
338:             .FontBold        = .T.
339:             .FontItalic      = .T.
340:             .Themes          = .F.
341:             .SpecialEffect   = 0
342:             .MousePointer    = 15
343:             .WordWrap        = .T.
344:             .AutoSize        = .F.
345:             .Visible         = .T.
346:         ENDWITH
347:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
348: 
349:         *-- Label "Filtrar Pela UF :" (top=96+29=125, left=71)
350:         loc_oPg1.AddObject("lbl_4c_FiltrarUF", "Label")
351:         WITH loc_oPg1.lbl_4c_FiltrarUF
352:             .Caption   = "Filtrar Pela UF :"
353:             .Top       = 125
354:             .Left      = 71
355:             .Height    = 17
356:             .AutoSize  = .T.
357:             .FontName  = "Tahoma"
358:             .FontSize  = 8
359:             .ForeColor = RGB(255, 255, 255)
360:             .BackStyle = 0
361:             .Visible   = .T.
362:         ENDWITH
363: 
364:         *-- TextBox UF (top=92+29=121, left=160, width=30, maxlength=2)
365:         loc_oPg1.AddObject("txt_4c_Estados", "TextBox")
366:         WITH loc_oPg1.txt_4c_Estados
367:             .Value     = ""
368:             .Top       = 121
369:             .Left      = 160
370:             .Width     = 30
371:             .Height    = 23
372:             .MaxLength = 2
373:             .FontName  = "Tahoma"
374:             .FontSize  = 8
375:             .Visible   = .T.
376:         ENDWITH
377:         BINDEVENT(loc_oPg1.txt_4c_Estados, "KeyPress", THIS, "ValidarEstadosLista")
378: 
379:         *-- Nota de filtro (top=96+29=125, left=214)
380:         loc_oPg1.AddObject("lbl_4c_NotaFiltro", "Label")
381:         WITH loc_oPg1.lbl_4c_NotaFiltro
382:             .Caption   = "NOTA: Devido " + CHR(224) + " grande quantidade de dados, " + ;
383:                          "o processo de filtro pode levar alguns minutos."
384:             .Top       = 125
385:             .Left      = 214
386:             .Width     = 518
387:             .Height    = 15
388:             .AutoSize  = .F.
389:             .FontName  = "Tahoma"
390:             .FontSize  = 8
391:             .ForeColor = RGB(255, 255, 255)
392:             .BackStyle = 0
393:             .Visible   = .T.
394:         ENDWITH
395: 
396:         *-- Grid principal (top=128+29=157, left=11, width=972, height=481)
397:         *-- RecordSource e ColumnCount fora do WITH para garantir criacao das colunas
398:         loc_oPg1.AddObject("grd_4c_Lista", "Grid")
399:         loc_oGrid = loc_oPg1.grd_4c_Lista
400:         loc_oGrid.RecordSource = ""
401:         loc_oGrid.ColumnCount  = 6
402: 
403:         WITH loc_oGrid
404:             .Top                = 157
405:             .Left               = 11
406:             .Width              = 972
407:             .Height             = 481
408:             .FontName           = "Verdana"
409:             .FontSize           = 8
410:             .ForeColor          = RGB(90, 90, 90)
411:             .BackColor          = RGB(255, 255, 255)
412:             .GridLineColor      = RGB(238, 238, 238)
413:             .HighlightBackColor = RGB(255, 255, 255)
414:             .HighlightForeColor = RGB(15, 41, 104)
415:             .HighlightStyle     = 2
416:             .DeleteMark         = .F.
417:             .RecordMark         = .F.

*-- Linhas 451 a 501:
451:             .Width           = 60
452:         ENDWITH
453: 
454:         THIS.TornarControlesVisiveis(loc_oPg1)
455:     ENDPROC
456: 
457:     *--------------------------------------------------------------------------
458:     * ConfigurarPaginaDados - Configura Page2: cabecalho + botoes acao
459:     * Fase 5-6 adiciona: labels + TextBoxes dos campos CEP
460:     *--------------------------------------------------------------------------
461:     PROTECTED PROCEDURE ConfigurarPaginaDados()
462:         LOCAL loc_oPg2, loc_oCab, loc_oBotoesAcao
463:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
464: 
465:         *-- Container cabecalho cinza (Top = 2 + 29 = 31)
466:         loc_oPg2.AddObject("cnt_4c_Cabecalho", "Container")
467:         loc_oCab = loc_oPg2.cnt_4c_Cabecalho
468:         WITH loc_oCab
469:             .Top         = 31
470:             .Left        = 0
471:             .Width       = THIS.Width
472:             .Height      = 80
473:             .BackColor   = RGB(100, 100, 100)
474:             .BorderWidth = 0
475:             .Visible     = .T.
476:         ENDWITH
477: 
478:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
479:         WITH loc_oCab.lbl_4c_Sombra
480:             .AutoSize  = .F.
481:             .Caption   = THIS.Caption
482:             .Top       = 15
483:             .Left      = 10
484:             .Width     = THIS.Width
485:             .Height    = 40
486:             .FontName  = "Tahoma"
487:             .FontSize  = 16
488:             .FontBold  = .T.
489:             .ForeColor = RGB(0, 0, 0)
490:             .BackStyle = 0
491:             .Visible   = .T.
492:         ENDWITH
493: 
494:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
495:         WITH loc_oCab.lbl_4c_Titulo
496:             .AutoSize  = .F.
497:             .Caption   = THIS.Caption
498:             .Top       = 18
499:             .Left      = 10
500:             .Width     = THIS.Width
501:             .Height    = 46

*-- Linhas 542 a 609:
542:             .AutoSize        = .F.
543:             .Visible         = .T.
544:         ENDWITH
545:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
546: 
547:         loc_oBotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
548:         WITH loc_oBotoesAcao.cmd_4c_Cancelar
549:             .Caption         = "Encerrar"
550:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
551:             .PicturePosition = 13
552:             .Top             = 5
553:             .Left            = 80
554:             .Width           = 75
555:             .Height          = 75
556:             .BackColor       = RGB(255, 255, 255)
557:             .ForeColor       = RGB(90, 90, 90)
558:             .FontName        = "Tahoma"
559:             .FontSize        = 8
560:             .FontBold        = .T.
561:             .FontItalic      = .T.
562:             .Themes          = .F.
563:             .SpecialEffect   = 0
564:             .MousePointer    = 15
565:             .WordWrap        = .T.
566:             .AutoSize        = .F.
567:             .Visible         = .T.
568:         ENDWITH
569:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
570: 
571:         *-- === CAMPO: CEP ===
572:         *-- Label "CEP :" (top=149+29=178, left=243)
573:         loc_oPg2.AddObject("lbl_4c_LabelCEP", "Label")
574:         WITH loc_oPg2.lbl_4c_LabelCEP
575:             .Caption   = "CEP :"
576:             .Top       = 178
577:             .Left      = 243
578:             .Height    = 17
579:             .AutoSize  = .T.
580:             .FontName  = "Tahoma"
581:             .FontSize  = 8
582:             .ForeColor = RGB(90, 90, 90)
583:             .BackStyle = 0
584:             .Visible   = .T.
585:         ENDWITH
586: 
587:         *-- TextBox CEP (top=145+29=174, left=275, width=80, maxlength=9)
588:         *-- Editavel apenas em INCLUIR (original: getCEPS.When = InList([INSERIR],[PROCURAR]))
589:         loc_oPg2.AddObject("txt_4c_CEPS", "TextBox")
590:         WITH loc_oPg2.txt_4c_CEPS
591:             .Value     = ""
592:             .Top       = 174
593:             .Left      = 275
594:             .Width     = 80
595:             .Height    = 23
596:             .MaxLength = 9
597:             .FontName  = "Tahoma"
598:             .FontSize  = 8
599:             .Enabled   = .F.
600:             .Visible   = .T.
601:         ENDWITH
602: 
603:         *-- === CAMPO: TipoNomes (Tipo de Endereco) ===
604:         *-- Label "Tipo :" (top=175+29=204, left=242)
605:         loc_oPg2.AddObject("lbl_4c_LabelTipo", "Label")
606:         WITH loc_oPg2.lbl_4c_LabelTipo
607:             .Caption   = "Tipo :"
608:             .Top       = 204
609:             .Left      = 242

*-- Linhas 770 a 814:
770:             .Enabled   = .F.
771:             .Visible   = .T.
772:         ENDWITH
773:         BINDEVENT(loc_oPg2.txt_4c_Cidades, "KeyPress", THIS, "CidadesKeyPress")
774:         BINDEVENT(loc_oPg2.txt_4c_Cidades, "DblClick", THIS, "CidadesDblClick")
775: 
776:         *-- === CAMPO: Estados (UF em dados - sempre readonly) ===
777:         *-- Original: getEstados.When = .F. (nunca habilitado)
778:         *-- Label "UF :" (top=308+29=337, left=249)
779:         loc_oPg2.AddObject("lbl_4c_LabelEstados", "Label")
780:         WITH loc_oPg2.lbl_4c_LabelEstados
781:             .Caption   = "UF :"
782:             .Top       = 337
783:             .Left      = 249
784:             .Height    = 17
785:             .AutoSize  = .T.
786:             .FontName  = "Tahoma"
787:             .FontSize  = 8
788:             .ForeColor = RGB(90, 90, 90)
789:             .BackStyle = 0
790:             .Visible   = .T.
791:         ENDWITH
792: 
793:         *-- TextBox UF dados (top=304+29=333, left=275, width=24, maxlength=2)
794:         loc_oPg2.AddObject("txt_4c_Estados", "TextBox")
795:         WITH loc_oPg2.txt_4c_Estados
796:             .Value     = ""
797:             .Top       = 333
798:             .Left      = 275
799:             .Width     = 24
800:             .Height    = 23
801:             .MaxLength = 2
802:             .FontName  = "Tahoma"
803:             .FontSize  = 8
804:             .Enabled   = .F.
805:             .ReadOnly  = .T.
806:             .Visible   = .T.
807:         ENDWITH
808: 
809:         *-- === CAMPO: Nums (Numero) ===
810:         *-- Label "N?mero :" (top=334+29=363, left=225)
811:         loc_oPg2.AddObject("lbl_4c_LabelNums", "Label")
812:         WITH loc_oPg2.lbl_4c_LabelNums
813:             .Caption   = "N" + CHR(250) + "mero :"
814:             .Top       = 363

*-- Linhas 837 a 926:
837:             .Visible   = .T.
838:         ENDWITH
839: 
840:         THIS.TornarControlesVisiveis(loc_oPg2)
841:     ENDPROC
842: 
843:     *--------------------------------------------------------------------------
844:     * TornarControlesVisiveis - Torna todos controles visiveis recursivamente
845:     *--------------------------------------------------------------------------
846:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
847:         LOCAL loc_nI, loc_oObjeto
848: 
849:         FOR loc_nI = 1 TO par_oContainer.ControlCount
850:             loc_oObjeto = par_oContainer.Controls(loc_nI)
851: 
852:             IF VARTYPE(loc_oObjeto) = "O"
853:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
854:                     loc_oObjeto.Visible = .T.
855:                 ENDIF
856: 
857:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
858:                     LOCAL loc_nP
859:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
860:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
861:                     ENDFOR
862:                 ENDIF
863: 
864:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
865:                     THIS.TornarControlesVisiveis(loc_oObjeto)
866:                 ENDIF
867:             ENDIF
868:         ENDFOR
869:     ENDPROC
870: 
871:     *--------------------------------------------------------------------------
872:     * FormatarGridLista - Formata visual do grid de lista
873:     *--------------------------------------------------------------------------
874:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
875:         WITH par_oGrid
876:             .FontName = "Tahoma"
877:             .FontSize = 8
878:         ENDWITH
879:     ENDPROC
880: 
881:     *--------------------------------------------------------------------------
882:     * CarregarLista - Carrega grid Page1 com CEPs filtrados por UF
883:     * Fase 4 completa: vincula RecordSource ao grid e configura colunas
884:     * Comportamento original: grid vazio quando UF nao selecionada
885:     *--------------------------------------------------------------------------
886:     PROCEDURE CarregarLista()
887:         LOCAL loc_lResultado
888:         loc_lResultado = .F.
889: 
890:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
891:             RETURN .T.
892:         ENDIF
893: 
894:         TRY
895:             LOCAL loc_oGrid
896:             IF EMPTY(ALLTRIM(THIS.this_cUfFiltro))
897:                 *-- Original inicia com grid vazio (pUFs = Chr(254)*2 nao retorna nada)
898:                 IF USED("cursor_4c_Dados")
899:                     USE IN cursor_4c_Dados
900:                 ENDIF
901:                 SET NULL ON
902:                 CREATE CURSOR cursor_4c_Dados (cIdChaves C(20), Ceps C(9), TipoNomes C(15), ;
903:                     Nomes C(72), Bairros C(72), Cidades C(72), Estados C(2), ;
904:                     Comples C(72), Nums C(11), cBarCeps C(7), TipoCeps C(1))
905:                 SET NULL OFF
906:                 loc_lResultado = .T.
907:             ELSE
908:                 IF THIS.this_oBusinessObject.Buscar(THIS.this_cUfFiltro)
909:                     loc_lResultado = .T.
910:                 ENDIF
911:             ENDIF
912: 
913:             IF loc_lResultado AND PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
914:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
915:                 loc_oGrid.ColumnCount = 6
916:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
917:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Ceps"
918:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.TipoNomes"
919:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Nomes"
920:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.Bairros"
921:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Cidades"
922:                 loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.Estados"
923:                 loc_oGrid.Column1.Header1.Caption = "CEP"
924:                 loc_oGrid.Column2.Header1.Caption = "Tipo"
925:                 loc_oGrid.Column3.Header1.Caption = "Endere" + CHR(231) + "o"
926:                 loc_oGrid.Column4.Header1.Caption = "Bairro"

*-- Linhas 948 a 1484:
948:     *--------------------------------------------------------------------------
949:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
950:     *--------------------------------------------------------------------------
951:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
952:         LOCAL loc_lResultado
953:         loc_lResultado = .F.
954: 
955:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
956:             RETURN .F.
957:         ENDIF
958: 
959:         TRY
960:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
961: 
962:             IF par_nPagina = 1
963:                 THIS.CarregarLista()
964:                 THIS.this_cModoAtual = "LISTA"
965:             ENDIF
966: 
967:             loc_lResultado = .T.
968:         CATCH TO loc_oErro
969:             MsgErro(loc_oErro.Message, "FormCEP.AlternarPagina")
970:         ENDTRY
971: 
972:         RETURN loc_lResultado
973:     ENDPROC
974: 
975:     *--------------------------------------------------------------------------
976:     * AjustarBotoesPorModo - Habilita/desabilita botoes conforme modo atual
977:     *--------------------------------------------------------------------------
978:     PROTECTED PROCEDURE AjustarBotoesPorModo()
979:         LOCAL loc_oPg1, loc_oBotoes, loc_oPg2, loc_oBotAcao
980:         loc_oPg1    = THIS.pgf_4c_Paginas.Page1
981:         loc_oBotoes = loc_oPg1.cnt_4c_Botoes
982:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
983:         loc_oBotAcao = loc_oPg2.cnt_4c_BotoesAcao
984: 
985:         DO CASE
986:             CASE THIS.this_cModoAtual = "INCLUIR" OR THIS.this_cModoAtual = "ALTERAR"
987:                 loc_oBotAcao.cmd_4c_Confirmar.Enabled = .T.
988:                 loc_oBotAcao.cmd_4c_Cancelar.Enabled  = .T.
989: 
990:             CASE THIS.this_cModoAtual = "VISUALIZAR"
991:                 loc_oBotAcao.cmd_4c_Confirmar.Enabled = .F.
992:                 loc_oBotAcao.cmd_4c_Cancelar.Enabled  = .T.
993: 
994:             OTHERWISE
995:                 *-- LISTA: nada a ajustar em Page2
996:         ENDCASE
997:     ENDPROC
998: 
999:     *--------------------------------------------------------------------------
1000:     * FormParaBO - Transfere valores do Form para o BO
1001:     *--------------------------------------------------------------------------
1002:     PROTECTED PROCEDURE FormParaBO()
1003:         LOCAL loc_oPg2
1004:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1005: 
1006:         THIS.this_oBusinessObject.this_cCeps      = ALLTRIM(loc_oPg2.txt_4c_CEPS.Value)
1007:         THIS.this_oBusinessObject.this_cTipoNomes = ALLTRIM(loc_oPg2.txt_4c_TipoNomes.Value)
1008:         THIS.this_oBusinessObject.this_cNomes     = ALLTRIM(loc_oPg2.txt_4c_Nomes.Value)
1009:         THIS.this_oBusinessObject.this_cComples   = ALLTRIM(loc_oPg2.txt_4c_Comples.Value)
1010:         THIS.this_oBusinessObject.this_cBairros   = ALLTRIM(loc_oPg2.txt_4c_Bairros.Value)
1011:         THIS.this_oBusinessObject.this_cCidades   = UPPER(ALLTRIM(loc_oPg2.txt_4c_Cidades.Value))
1012:         THIS.this_oBusinessObject.this_cEstados   = ALLTRIM(loc_oPg2.txt_4c_Estados.Value)
1013:         THIS.this_oBusinessObject.this_cNums      = ALLTRIM(loc_oPg2.txt_4c_Nums.Value)
1014:     ENDPROC
1015: 
1016:     *--------------------------------------------------------------------------
1017:     * BOParaForm - Transfere valores do BO para o Form
1018:     *--------------------------------------------------------------------------
1019:     PROTECTED PROCEDURE BOParaForm()
1020:         LOCAL loc_oPg2
1021:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1022: 
1023:         loc_oPg2.txt_4c_CEPS.Value      = THIS.this_oBusinessObject.this_cCeps
1024:         loc_oPg2.txt_4c_TipoNomes.Value = THIS.this_oBusinessObject.this_cTipoNomes
1025:         loc_oPg2.txt_4c_Nomes.Value     = THIS.this_oBusinessObject.this_cNomes
1026:         loc_oPg2.txt_4c_Comples.Value   = THIS.this_oBusinessObject.this_cComples
1027:         loc_oPg2.txt_4c_Bairros.Value   = THIS.this_oBusinessObject.this_cBairros
1028:         loc_oPg2.txt_4c_Cidades.Value   = THIS.this_oBusinessObject.this_cCidades
1029:         loc_oPg2.txt_4c_Estados.Value   = THIS.this_oBusinessObject.this_cEstados
1030:         loc_oPg2.txt_4c_Nums.Value      = THIS.this_oBusinessObject.this_cNums
1031:     ENDPROC
1032: 
1033:     *--------------------------------------------------------------------------
1034:     * HabilitarCampos - Habilita ou desabilita campos de edicao
1035:     * CEP: so editavel em INCLUIR (original: getCEPS.When = InList([INSERIR],[PROCURAR]))
1036:     * Estados (UF Dados): nunca habilitado (original: getEstados.When = .F.)
1037:     *--------------------------------------------------------------------------
1038:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1039:         LOCAL loc_oPg2, loc_lHabCEP
1040:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1041:         loc_lHabCEP = par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")
1042: 
1043:         loc_oPg2.txt_4c_CEPS.Enabled      = loc_lHabCEP
1044:         loc_oPg2.txt_4c_TipoNomes.Enabled = par_lHabilitar
1045:         loc_oPg2.txt_4c_Nomes.Enabled     = par_lHabilitar
1046:         loc_oPg2.txt_4c_Comples.Enabled   = par_lHabilitar
1047:         loc_oPg2.txt_4c_Bairros.Enabled   = par_lHabilitar
1048:         loc_oPg2.txt_4c_Cidades.Enabled   = par_lHabilitar
1049:         *-- Estados (UF) NUNCA habilitado (original: getEstados.When = .F.)
1050:         loc_oPg2.txt_4c_Estados.Enabled   = .F.
1051:         loc_oPg2.txt_4c_Nums.Enabled      = par_lHabilitar
1052:     ENDPROC
1053: 
1054:     *--------------------------------------------------------------------------
1055:     * LimparCampos - Limpa valores dos campos do formulario
1056:     *--------------------------------------------------------------------------
1057:     PROTECTED PROCEDURE LimparCampos()
1058:         LOCAL loc_oPg2
1059:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1060: 
1061:         loc_oPg2.txt_4c_CEPS.Value      = ""
1062:         loc_oPg2.txt_4c_TipoNomes.Value = ""
1063:         loc_oPg2.txt_4c_Nomes.Value     = ""
1064:         loc_oPg2.txt_4c_Comples.Value   = ""
1065:         loc_oPg2.txt_4c_Bairros.Value   = ""
1066:         loc_oPg2.txt_4c_Cidades.Value   = ""
1067:         loc_oPg2.txt_4c_Estados.Value   = ""
1068:         loc_oPg2.txt_4c_Nums.Value      = ""
1069:     ENDPROC
1070: 
1071:     *==========================================================================
1072:     * EVENTOS DOS BOTOES - Page1 (Lista)
1073:     *==========================================================================
1074: 
1075:     *--------------------------------------------------------------------------
1076:     * BtnIncluirClick - Incluir novo CEP
1077:     *--------------------------------------------------------------------------
1078:     PROCEDURE BtnIncluirClick()
1079:         TRY
1080:             THIS.this_oBusinessObject.NovoRegistro()
1081:             THIS.LimparCampos()
1082:             THIS.this_cModoAtual = "INCLUIR"
1083:             THIS.HabilitarCampos(.T.)
1084:             THIS.AjustarBotoesPorModo()
1085:             *-- Pre-preencher UF a partir do filtro da lista (original: getEstados copiado no Click)
1086:             IF !EMPTY(THIS.this_cUfFiltro)
1087:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Estados.Value = THIS.this_cUfFiltro
1088:             ENDIF
1089:             THIS.AlternarPagina(2)
1090:         CATCH TO loc_oErro
1091:             MsgErro(loc_oErro.Message, "FormCEP.BtnIncluirClick")
1092:         ENDTRY
1093:     ENDPROC
1094: 
1095:     *--------------------------------------------------------------------------
1096:     * BtnVisualizarClick - Visualizar CEP selecionado (somente leitura)
1097:     *--------------------------------------------------------------------------
1098:     PROCEDURE BtnVisualizarClick()
1099:         LOCAL loc_cChave
1100:         loc_cChave = ""
1101: 
1102:         TRY
1103:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1104:                 SELECT cursor_4c_Dados
1105:                 loc_cChave = ALLTRIM(cursor_4c_Dados.cIdChaves)
1106:             ENDIF
1107: 
1108:             IF EMPTY(loc_cChave)
1109:                 MsgAviso("Selecione um registro na lista.", "Aviso")
1110:             ELSE
1111:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1112:                     THIS.BOParaForm()
1113:                     THIS.this_cModoAtual = "VISUALIZAR"
1114:                     THIS.HabilitarCampos(.F.)
1115:                     THIS.AjustarBotoesPorModo()
1116:                     THIS.AlternarPagina(2)
1117:                 ENDIF
1118:             ENDIF
1119:         CATCH TO loc_oErro
1120:             MsgErro(loc_oErro.Message, "FormCEP.BtnVisualizarClick")
1121:         ENDTRY
1122:     ENDPROC
1123: 
1124:     *--------------------------------------------------------------------------
1125:     * BtnAlterarClick - Alterar CEP selecionado
1126:     *--------------------------------------------------------------------------
1127:     PROCEDURE BtnAlterarClick()
1128:         LOCAL loc_cChave
1129:         loc_cChave = ""
1130: 
1131:         TRY
1132:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1133:                 SELECT cursor_4c_Dados
1134:                 loc_cChave = ALLTRIM(cursor_4c_Dados.cIdChaves)
1135:             ENDIF
1136: 
1137:             IF EMPTY(loc_cChave)
1138:                 MsgAviso("Selecione um registro na lista.", "Aviso")
1139:             ELSE
1140:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1141:                     THIS.this_oBusinessObject.EditarRegistro()
1142:                     THIS.BOParaForm()
1143:                     THIS.this_cModoAtual = "ALTERAR"
1144:                     THIS.HabilitarCampos(.T.)
1145:                     THIS.AjustarBotoesPorModo()
1146:                     THIS.AlternarPagina(2)
1147:                 ENDIF
1148:             ENDIF
1149:         CATCH TO loc_oErro
1150:             MsgErro(loc_oErro.Message, "FormCEP.BtnAlterarClick")
1151:         ENDTRY
1152:     ENDPROC
1153: 
1154:     *--------------------------------------------------------------------------
1155:     * BtnExcluirClick - Excluir CEP selecionado
1156:     *--------------------------------------------------------------------------
1157:     PROCEDURE BtnExcluirClick()
1158:         LOCAL loc_cChave, loc_cCeps
1159:         loc_cChave = ""
1160:         loc_cCeps  = ""
1161: 
1162:         TRY
1163:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1164:                 SELECT cursor_4c_Dados
1165:                 loc_cChave = ALLTRIM(cursor_4c_Dados.cIdChaves)
1166:                 loc_cCeps  = ALLTRIM(cursor_4c_Dados.Ceps)
1167:             ENDIF
1168: 
1169:             IF EMPTY(loc_cChave)
1170:                 MsgAviso("Selecione um registro na lista.", "Aviso")
1171:             ELSE
1172:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do CEP " + loc_cCeps + "?", ;
1173:                                "Exclus" + CHR(227) + "o")
1174:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1175:                         IF THIS.this_oBusinessObject.Excluir()
1176:                             MsgInfo("CEP exclu" + CHR(237) + "do com sucesso!", "Sucesso")
1177:                             THIS.CarregarLista()
1178:                         ENDIF
1179:                     ENDIF
1180:                 ENDIF
1181:             ENDIF
1182:         CATCH TO loc_oErro
1183:             MsgErro(loc_oErro.Message, "FormCEP.BtnExcluirClick")
1184:         ENDTRY
1185:     ENDPROC
1186: 
1187:     *--------------------------------------------------------------------------
1188:     * ValidarEstadosLista - Valida UF digitada e recarrega grid (LostFocus)
1189:     * Espelha logica original: fwBuscaExt em SigCdUfs + seta CodUFs (IBGE)
1190:     *--------------------------------------------------------------------------
1191:     PROCEDURE ValidarEstadosLista(par_nKeyCode, par_nShiftAltCtrl)
1192:         LOCAL loc_cEstado, loc_oBusca, loc_cCodUF
1193:         loc_cEstado = ""
1194:         loc_cCodUF  = ""
1195: 
1196:         TRY
1197:             IF !PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "txt_4c_Estados", 5)
1198:                 RETURN
1199:             ENDIF
1200: 
1201:             loc_cEstado = UPPER(ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Estados.Value))
1202: 
1203:             IF loc_cEstado == UPPER(ALLTRIM(THIS.this_cUltimoEstadoValidado))
1204:                 RETURN
1205:             ENDIF
1206: 
1207:             THIS.this_cUltimoEstadoValidado = loc_cEstado
1208: 
1209:             IF EMPTY(loc_cEstado)
1210:                 THIS.this_cUfFiltro = ""
1211:                 THIS.this_cCodUFs   = ""
1212:                 THIS.CarregarLista()
1213:             ELSE
1214:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1215:                     "SigCdUfs", "cursor_4c_BuscaUf", "Estados", loc_cEstado, ;
1216:                     "Selecionar UF")
1217: 
1218:                 IF VARTYPE(loc_oBusca) = "O"
1219:                     IF !loc_oBusca.this_lAchouRegistro
1220:                         loc_oBusca.mAddColuna("Estados", "", "UF")
1221:                         loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1222:                         loc_oBusca.mAddColuna("UFIBGES", "", "IBGE")
1223:                         loc_oBusca.Show()
1224:                     ENDIF
1225: 
1226:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUf")
1227:                         SELECT cursor_4c_BuscaUf
1228:                         loc_cEstado = ALLTRIM(cursor_4c_BuscaUf.Estados)
1229:                         loc_cCodUF  = ALLTRIM(cursor_4c_BuscaUf.UFIBGES)
1230:                     ENDIF
1231: 
1232:                     loc_oBusca.Release()
1233:                 ENDIF
1234: 
1235:                 IF USED("cursor_4c_BuscaUf")
1236:                     USE IN cursor_4c_BuscaUf
1237:                 ENDIF
1238: 
1239:                 IF EMPTY(loc_cEstado)
1240:                     THIS.pgf_4c_Paginas.Page1.txt_4c_Estados.Value = ""
1241:                     THIS.this_cUfFiltro = ""
1242:                     THIS.this_cCodUFs   = ""
1243:                 ELSE
1244:                     THIS.pgf_4c_Paginas.Page1.txt_4c_Estados.Value = loc_cEstado
1245:                     THIS.this_cUfFiltro = loc_cEstado
1246:                     THIS.this_cCodUFs   = loc_cCodUF
1247:                     THIS.CarregarLista()
1248:                 ENDIF
1249:             ENDIF
1250:         CATCH TO loc_oErro
1251:             MsgErro(loc_oErro.Message, "FormCEP.ValidarEstadosLista")
1252:             IF USED("cursor_4c_BuscaUf")
1253:                 USE IN cursor_4c_BuscaUf
1254:             ENDIF
1255:         ENDTRY
1256:     ENDPROC
1257: 
1258:     *--------------------------------------------------------------------------
1259:     * BtnBuscarClick - Filtrar por UF (abre picker de UF)
1260:     *--------------------------------------------------------------------------
1261:     PROCEDURE BtnBuscarClick()
1262:         LOCAL loc_oBusca, loc_cUf
1263:         loc_cUf = ""
1264: 
1265:         TRY
1266:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1267:                 "SigCdUfs", "cursor_4c_BuscaUf", "Estados", "", ;
1268:                 "Selecionar UF")
1269: 
1270:             IF VARTYPE(loc_oBusca) = "O"
1271:                 loc_oBusca.mAddColuna("Estados", "", "UF")
1272:                 loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1273:                 loc_oBusca.mAddColuna("UFIBGES", "", "IBGE")
1274:                 loc_oBusca.Show()
1275: 
1276:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUf")
1277:                     SELECT cursor_4c_BuscaUf
1278:                     loc_cUf = ALLTRIM(cursor_4c_BuscaUf.Estados)
1279:                 ENDIF
1280: 
1281:                 loc_oBusca.Release()
1282:             ENDIF
1283: 
1284:             IF USED("cursor_4c_BuscaUf")
1285:                 USE IN cursor_4c_BuscaUf
1286:             ENDIF
1287: 
1288:             IF !EMPTY(loc_cUf)
1289:                 THIS.this_cUfFiltro = loc_cUf
1290:                 THIS.this_cUltimoEstadoValidado = loc_cUf
1291:                 THIS.CarregarLista()
1292:             ENDIF
1293:         CATCH TO loc_oErro
1294:             MsgErro(loc_oErro.Message, "FormCEP.BtnBuscarClick")
1295:             IF USED("cursor_4c_BuscaUf")
1296:                 USE IN cursor_4c_BuscaUf
1297:             ENDIF
1298:         ENDTRY
1299:     ENDPROC
1300: 
1301:     *--------------------------------------------------------------------------
1302:     * BtnEncerrarClick - Fechar formulario
1303:     *--------------------------------------------------------------------------
1304:     PROCEDURE BtnEncerrarClick()
1305:         TRY
1306:             THIS.Release()
1307:         CATCH TO loc_oErro
1308:             MsgErro(loc_oErro.Message, "FormCEP.BtnEncerrarClick")
1309:         ENDTRY
1310:     ENDPROC
1311: 
1312:     *==========================================================================
1313:     * EVENTOS DOS BOTOES - Page2 (Dados)
1314:     *==========================================================================
1315: 
1316:     *--------------------------------------------------------------------------
1317:     * BtnSalvarClick - Salvar registro (Confirmar)
1318:     *--------------------------------------------------------------------------
1319:     PROCEDURE BtnSalvarClick()
1320:         LOCAL loc_oPg2, loc_cCeps, loc_cTipo, loc_cNome, loc_cUF
1321:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
1322:         loc_cCeps = ALLTRIM(loc_oPg2.txt_4c_CEPS.Value)
1323:         loc_cTipo = ALLTRIM(loc_oPg2.txt_4c_TipoNomes.Value)
1324:         loc_cNome = ALLTRIM(loc_oPg2.txt_4c_Nomes.Value)
1325:         loc_cUF   = ALLTRIM(loc_oPg2.txt_4c_Estados.Value)
1326: 
1327:         *-- Validacoes obrigatorias ANTES do TRY (original: Click handler valida antes de DoDefault)
1328:         IF THIS.this_cModoAtual = "INCLUIR" OR THIS.this_cModoAtual = "ALTERAR"
1329:             IF EMPTY(loc_cCeps)
1330:                 MsgAviso("O CEP N" + CHR(227) + "o Pode Ficar Em Branco!!!", ;
1331:                          "Aten" + CHR(231) + CHR(227) + "o")
1332:                 loc_oPg2.txt_4c_CEPS.SetFocus()
1333:                 RETURN
1334:             ENDIF
1335: 
1336:             IF EMPTY(loc_cTipo)
1337:                 MsgAviso("O Tipo de Endere" + CHR(231) + "o N" + CHR(227) + "o Pode Ficar Em Branco!!!", ;
1338:                          "Aten" + CHR(231) + CHR(227) + "o")
1339:                 loc_oPg2.txt_4c_TipoNomes.SetFocus()
1340:                 RETURN
1341:             ENDIF
1342: 
1343:             IF EMPTY(loc_cNome)
1344:                 MsgAviso("O Endere" + CHR(231) + "o N" + CHR(227) + "o Pode Ficar Em Branco!!!", ;
1345:                          "Aten" + CHR(231) + CHR(227) + "o")
1346:                 loc_oPg2.txt_4c_Nomes.SetFocus()
1347:                 RETURN
1348:             ENDIF
1349: 
1350:             *-- Garantir UF preenchida (original: valida getEstados da lista antes de salvar)
1351:             IF EMPTY(loc_cUF) AND !EMPTY(THIS.this_cUfFiltro)
1352:                 loc_oPg2.txt_4c_Estados.Value = THIS.this_cUfFiltro
1353:                 loc_cUF = THIS.this_cUfFiltro
1354:             ENDIF
1355: 
1356:             IF EMPTY(loc_cUF)
1357:                 MsgAviso("A UF N" + CHR(227) + "o Foi Preenchida!!!", ;
1358:                          "Aten" + CHR(231) + CHR(227) + "o")
1359:                 THIS.AlternarPagina(1)
1360:                 RETURN
1361:             ENDIF
1362:         ENDIF
1363: 
1364:         TRY
1365:             THIS.FormParaBO()
1366: 
1367:             IF THIS.this_oBusinessObject.Salvar()
1368:                 MsgInfo("CEP salvo com sucesso!", "Sucesso")
1369:                 THIS.AlternarPagina(1)
1370:             ENDIF
1371:         CATCH TO loc_oErro
1372:             MsgErro(loc_oErro.Message, "FormCEP.BtnSalvarClick")
1373:         ENDTRY
1374:     ENDPROC
1375: 
1376:     *--------------------------------------------------------------------------
1377:     * BtnCancelarClick - Cancelar e voltar para lista
1378:     *--------------------------------------------------------------------------
1379:     PROCEDURE BtnCancelarClick()
1380:         TRY
1381:             THIS.AlternarPagina(1)
1382:         CATCH TO loc_oErro
1383:             MsgErro(loc_oErro.Message, "FormCEP.BtnCancelarClick")
1384:         ENDTRY
1385:     ENDPROC
1386: 
1387:     *--------------------------------------------------------------------------
1388:     * CidadesKeyPress - Trata F4 no campo Cidade para abrir lookup
1389:     *--------------------------------------------------------------------------
1390:     PROCEDURE CidadesKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1391:         IF par_nKeyCode = 28  && F4
1392:             THIS.AbrirLookupCidades()
1393:         ENDIF
1394:     ENDPROC
1395: 
1396:     *--------------------------------------------------------------------------
1397:     * CidadesDblClick - DblClick no campo Cidade abre lookup
1398:     *--------------------------------------------------------------------------
1399:     PROCEDURE CidadesDblClick()
1400:         THIS.AbrirLookupCidades()
1401:     ENDPROC
1402: 
1403:     *--------------------------------------------------------------------------
1404:     * AbrirLookupCidades - Busca municipio em SigCdMun filtrado por UFIBGES
1405:     * Original: getCidades.Valid usa fwBuscaExt em SigCdMun com filtro laFil[UFIBGES]=CodUFs
1406:     *--------------------------------------------------------------------------
1407:     PROCEDURE AbrirLookupCidades()
1408:         LOCAL loc_oPg2
1409:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1410: 
1411:         IF !loc_oPg2.txt_4c_Cidades.Enabled
1412:             RETURN
1413:         ENDIF
1414: 
1415:         LOCAL loc_oBusca, loc_cSQL, loc_nResult
1416:         loc_cSQL = ""
1417: 
1418:         TRY
1419:             *-- Query filtrada por UFIBGES quando UF selecionada (original: laFil[UFIBGES]=CodUFs)
1420:             IF !EMPTY(THIS.this_cCodUFs)
1421:                 loc_cSQL = "SELECT Descs FROM SigCdMun" + ;
1422:                            " WHERE UFIBGES = " + EscaparSQL(THIS.this_cCodUFs) + ;
1423:                            " ORDER BY Descs"
1424:             ELSE
1425:                 loc_cSQL = "SELECT Descs FROM SigCdMun ORDER BY Descs"
1426:             ENDIF
1427: 
1428:             IF USED("cursor_4c_BuscaMun")
1429:                 USE IN cursor_4c_BuscaMun
1430:             ENDIF
1431: 
1432:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMun")
1433:             IF loc_nResult < 0
1434:                 MsgErro("Erro ao buscar munic" + CHR(237) + "pios:" + CHR(13) + ;
1435:                         CapturarErroSQL(), "Erro SQL")
1436:             ELSE
1437:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1438:                 IF VARTYPE(loc_oBusca) = "O"
1439:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaMun"
1440:                     loc_oBusca.this_cTitulo = "Selecionar Cidade"
1441:                     loc_oBusca.mAddColuna("Descs", "", "Cidade")
1442:                     loc_oBusca.Show()
1443: 
1444:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMun")
1445:                         SELECT cursor_4c_BuscaMun
1446:                         loc_oPg2.txt_4c_Cidades.Value = UPPER(ALLTRIM(cursor_4c_BuscaMun.Descs))
1447:                     ENDIF
1448: 
1449:                     loc_oBusca.Release()
1450:                 ENDIF
1451:             ENDIF
1452:         CATCH TO loc_oErro
1453:             MsgErro(loc_oErro.Message, "FormCEP.AbrirLookupCidades")
1454:         ENDTRY
1455: 
1456:         IF USED("cursor_4c_BuscaMun")
1457:             USE IN cursor_4c_BuscaMun
1458:         ENDIF
1459:     ENDPROC
1460: 
1461:     *--------------------------------------------------------------------------
1462:     * Destroy - Limpeza ao fechar o formulario
1463:     *--------------------------------------------------------------------------
1464:     PROCEDURE Destroy()
1465:         TRY
1466:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1467:                 THIS.this_oBusinessObject = .NULL.
1468:             ENDIF
1469: 
1470:             IF USED("cursor_4c_Dados")
1471:                 USE IN cursor_4c_Dados
1472:             ENDIF
1473: 
1474:             IF USED("cursor_4c_BuscaMun")
1475:                 USE IN cursor_4c_BuscaMun
1476:             ENDIF
1477:         CATCH TO loc_oErro
1478:             MsgErro(loc_oErro.Message, "FormCEP.Destroy")
1479:         ENDTRY
1480: 
1481:         DODEFAULT()
1482:     ENDPROC
1483: 
1484: ENDDEFINE


### BO (C:\4c\projeto\app\classes\CEPBO.prg):
*====================================================================
* CEPBO.prg
*
* Business Object para CEP (Cadastro de Enderecos Postais)
* Tabela principal: cep (cidchaves PK)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS CEPBO AS BusinessBase

	*-- Propriedades da entidade (tabela: cep)
	this_cCidChaves   = ""   && cidchaves char(20)  - PK (ID unico gerado por fUniqueIds)
	this_cCeps        = ""   && ceps char(9)        - CEP (ex: 41820-610)
	this_cTipoNomes   = ""   && tiponomes char(15)  - Tipo de endereco (R, AV, TV, AL...)
	this_cNomes       = ""   && nomes char(72)      - Nome do endereco
	this_cBairros     = ""   && bairros char(72)    - Bairro
	this_cCidades     = ""   && cidades char(72)    - Cidade
	this_cEstados     = ""   && estados char(2)     - UF (sigla)
	this_cComples     = ""   && comples char(72)    - Complemento
	this_cNums        = ""   && nums char(11)       - Numero
	this_cTipoCeps    = ""   && tipoceps char(1)    - Tipo do CEP
	this_cBarCeps     = ""   && cBarCeps char(7)    - Codigo de barras CEP

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "cep"
		THIS.this_cCampoChave = "cidchaves"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCidChaves)
	ENDPROC

	*====================================================================
	* Buscar - Carrega lista de CEPs no cursor_4c_Dados
	* par_cFiltro: sigla da UF para filtrar (vazio = todos)
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(par_cFiltro)
				loc_cSQL = "SELECT cIdChaves, Ceps, TipoNomes, Nomes, Bairros, Cidades, Estados, Comples, Nums, cBarCeps, TipoCeps" + ;
				           " FROM Cep" + ;
				           " ORDER BY Ceps"
			ELSE
				loc_cSQL = "SELECT cIdChaves, Ceps, TipoNomes, Nomes, Bairros, Cidades, Estados, Comples, Nums, cBarCeps, TipoCeps" + ;
				           " FROM Cep" + ;
				           " WHERE Estados = " + EscaparSQL(UPPER(ALLTRIM(par_cFiltro))) + ;
				           " ORDER BY Ceps"
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar CEP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao buscar CEP:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega um registro pelo cIdChaves (PK)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCidChaves)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT cIdChaves, Ceps, TipoNomes, Nomes, Bairros, Cidades, Estados, Comples, Nums, cBarCeps, TipoCeps" + ;
			           " FROM Cep" + ;
			           " WHERE cIdChaves = " + EscaparSQL(ALLTRIM(par_cCidChaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar CEP:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_cCidChaves  = TratarNulo(cIdChaves,  "C")
			THIS.this_cCeps       = TratarNulo(Ceps,       "C")
			THIS.this_cTipoNomes  = TratarNulo(TipoNomes,  "C")
			THIS.this_cNomes      = TratarNulo(Nomes,      "C")
			THIS.this_cBairros    = TratarNulo(Bairros,    "C")
			THIS.this_cCidades    = TratarNulo(Cidades,    "C")
			THIS.this_cEstados    = TratarNulo(Estados,    "C")
			THIS.this_cComples    = TratarNulo(Comples,    "C")
			THIS.this_cNums       = TratarNulo(Nums,       "C")
			THIS.this_cTipoCeps   = TratarNulo(TipoCeps,   "C")
			THIS.this_cBarCeps    = TratarNulo(cBarCeps,   "C")
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - INSERT na tabela Cep
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			*-- Gerar chave unica via SQL Server NEWID()
			loc_nResultado = SQLEXEC(gnConnHandle, "SELECT LEFT(NEWID(), 20) AS novo_uuid", "cursor_4c_Uuid")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Uuid") > 0
				SELECT cursor_4c_Uuid
				THIS.this_cCidChaves = ALLTRIM(cursor_4c_Uuid.novo_uuid)
			ENDIF
			IF USED("cursor_4c_Uuid")
				USE IN cursor_4c_Uuid
			ENDIF

			IF EMPTY(THIS.this_cCidChaves)
				MsgErro("Erro ao gerar chave " + CHR(250) + "nica para o CEP.", "Erro")
			ELSE
				loc_cSQL = "INSERT INTO Cep (cIdChaves, Ceps, TipoNomes, Nomes, Bairros, Cidades, Estados, Comples, Nums, cBarCeps, TipoCeps)" + ;
				           " VALUES (" + ;
				           EscaparSQL(THIS.this_cCidChaves) + "," + ;
				           EscaparSQL(THIS.this_cCeps)      + "," + ;
				           EscaparSQL(THIS.this_cTipoNomes) + "," + ;
				           EscaparSQL(THIS.this_cNomes)     + "," + ;
				           EscaparSQL(THIS.this_cBairros)   + "," + ;
				           EscaparSQL(THIS.this_cCidades)   + "," + ;
				           EscaparSQL(THIS.this_cEstados)   + "," + ;
				           EscaparSQL(THIS.this_cComples)   + "," + ;
				           EscaparSQL(THIS.this_cNums)      + "," + ;
				           EscaparSQL(THIS.this_cBarCeps)   + "," + ;
				           EscaparSQL(THIS.this_cTipoCeps)  + ;
				           ")"

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
				IF loc_nResultado >= 0
					THIS.RegistrarAuditoria("INSERT")
					loc_lSucesso = .T.
				ELSE
					MsgErro("Erro ao inserir CEP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao inserir CEP:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE na tabela Cep
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE Cep SET" + ;
			           " Ceps       = " + EscaparSQL(THIS.this_cCeps)      + "," + ;
			           " TipoNomes  = " + EscaparSQL(THIS.this_cTipoNomes) + "," + ;
			           " Nomes      = " + EscaparSQL(THIS.this_cNomes)     + "," + ;
			           " Bairros    = " + EscaparSQL(THIS.this_cBairros)   + "," + ;
			           " Cidades    = " + EscaparSQL(THIS.this_cCidades)   + "," + ;
			           " Estados    = " + EscaparSQL(THIS.this_cEstados)   + "," + ;
			           " Comples    = " + EscaparSQL(THIS.this_cComples)   + "," + ;
			           " Nums       = " + EscaparSQL(THIS.this_cNums)      + "," + ;
			           " cBarCeps   = " + EscaparSQL(THIS.this_cBarCeps)   + "," + ;
			           " TipoCeps   = " + EscaparSQL(THIS.this_cTipoCeps)  + ;
			           " WHERE cIdChaves = " + EscaparSQL(THIS.this_cCidChaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar CEP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao atualizar CEP:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE da tabela Cep
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM Cep WHERE cIdChaves = " + EscaparSQL(THIS.this_cCidChaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir CEP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao excluir CEP:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

