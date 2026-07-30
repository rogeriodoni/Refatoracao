# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [BINDEVENT-PARAMS] Handler 'OrdemLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE OrdemLostFocus(par_nKeyCode, par_nShiftAltCtrl)

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formcrp.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1287 linhas total):

*-- Linhas 29 a 163:
29:     * par_nTipo: 0=Produtos (default), 1=Contas, 2=Movimentacoes
30:     * Legado: pcTipo (C/char) convertido para numerico no novo sistema
31:     *==========================================================================
32:     PROCEDURE Init(par_nTipo)
33:         THIS.this_nTipos = IIF(VARTYPE(par_nTipo) = "N", par_nTipo, 0)
34: 
35:         DO CASE
36:         CASE THIS.this_nTipos = 1
37:             THIS.Caption = "Caracter" + CHR(237) + "sticas de Contas"
38:         CASE THIS.this_nTipos = 2
39:             THIS.Caption = "Caracter" + CHR(237) + "sticas de Movimenta" + CHR(231) + CHR(245) + "es"
40:         OTHERWISE
41:             THIS.Caption = "Caracter" + CHR(237) + "sticas de Produtos"
42:         ENDCASE
43: 
44:         RETURN DODEFAULT()
45:     ENDPROC
46: 
47:     *==========================================================================
48:     * InicializarForm - Configura estrutura completa
49:     * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
50:     *==========================================================================
51:     PROTECTED PROCEDURE InicializarForm()
52:         LOCAL loc_lSucesso
53:         loc_lSucesso = .F.
54: 
55:         TRY
56:             THIS.this_oBusinessObject = CREATEOBJECT("crpBO")
57: 
58:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
59:                 MostrarErro("Erro ao criar crpBO" + CHR(13) + ;
60:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
61:                     "Formcrp.InicializarForm")
62:             ELSE
63:                 THIS.this_oBusinessObject.this_nTipos = THIS.this_nTipos
64: 
65:                 THIS.ConfigurarPageFrame()
66:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
67:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
68:                 THIS.pgf_4c_Paginas.Visible = .T.
69:                 THIS.pgf_4c_Paginas.ActivePage = 1
70:                 THIS.this_cModoAtual = "LISTA"
71: 
72:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
73:                     THIS.CarregarLista()
74:                 ENDIF
75: 
76:                 loc_lSucesso = .T.
77:             ENDIF
78: 
79:         CATCH TO loException
80:             MostrarErro("Erro ao inicializar Formcrp:" + CHR(13) + ;
81:                 loException.Message + CHR(13) + ;
82:                 "Linha: " + TRANSFORM(loException.LineNo), ;
83:                 "Formcrp.InicializarForm")
84:         ENDTRY
85: 
86:         RETURN loc_lSucesso
87:     ENDPROC
88: 
89:     *==========================================================================
90:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
91:     * Top=-29 para esconder abas; controles internos compensam +29 no Top
92:     *==========================================================================
93:     PROTECTED PROCEDURE ConfigurarPageFrame()
94:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
95: 
96:         WITH THIS.pgf_4c_Paginas
97:             .PageCount = 2
98:             .Top       = -29
99:             .Left      = 0
100:             .Width     = THIS.Width
101:             .Height    = THIS.Height + 29
102:             .Tabs      = .F.
103:             .Visible   = .T.
104: 
105:             .Page1.Caption   = "Lista"
106:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
107:             .Page1.BackColor = RGB(255, 255, 255)
108: 
109:             .Page2.Caption   = "Dados"
110:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
111:             .Page2.BackColor = RGB(255, 255, 255)
112:         ENDWITH
113: 
114:         THIS.ConfigurarPaginaLista()
115:         THIS.ConfigurarPaginaDados()
116:     ENDPROC
117: 
118:     *==========================================================================
119:     * ConfigurarPaginaLista - Configura Page1 (estrutura base Fase 3)
120:     * Cria: cnt_4c_Cabecalho (com labels), cnt_4c_Botoes (vazio), cnt_4c_Saida
121:     * Grade e botoes CRUD serao adicionados na Fase 4
122:     *==========================================================================
123:     PROTECTED PROCEDURE ConfigurarPaginaLista()
124:         LOCAL loc_oPagina
125:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
126: 
127:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
128:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
129: 
130:         *-- Container Cabecalho cinza (cntSombra no legado)
131:         *-- Original: cntSombra.Width=1100. Com comp PageFrame +29: Top=31
132:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
133:         WITH loc_oPagina.cnt_4c_Cabecalho
134:             .Top       = 31
135:             .Left      = 0
136:             .Width     = THIS.Width
137:             .Height    = 80
138:             .BackColor = RGB(100, 100, 100)
139:             .BackStyle = 1
140:             .BorderWidth = 0
141:             .Visible   = .T.
142:         ENDWITH
143: 
144:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
145:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
146:             .Caption   = THIS.Caption
147:             .Top       = 15
148:             .Left      = 10
149:             .Width     = 769
150:             .Height    = 40
151:             .FontName  = "Tahoma"
152:             .FontSize  = 16
153:             .FontBold  = .T.
154:             .ForeColor = RGB(0, 0, 0)
155:             .BackStyle = 0
156:             .AutoSize  = .F.
157:             .Visible   = .T.
158:         ENDWITH
159: 
160:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
161:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
162:             .Caption   = THIS.Caption
163:             .Top       = 18

*-- Linhas 209 a 499:
209:             .AutoSize        = .F.
210:             .Visible         = .T.
211:         ENDWITH
212:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
213: 
214:         *-- Botao Visualizar
215:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
216:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
217:             .Caption         = "Visualizar"
218:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
219:             .PicturePosition = 13
220:             .Top             = 5
221:             .Left            = 80
222:             .Width           = 75
223:             .Height          = 75
224:             .FontName        = "Comic Sans MS"
225:             .FontBold        = .T.
226:             .FontItalic      = .T.
227:             .FontSize        = 8
228:             .ForeColor       = RGB(90, 90, 90)
229:             .BackColor       = RGB(255, 255, 255)
230:             .Themes          = .F.
231:             .SpecialEffect   = 0
232:             .MousePointer    = 15
233:             .WordWrap        = .T.
234:             .AutoSize        = .F.
235:             .Visible         = .T.
236:         ENDWITH
237:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
238: 
239:         *-- Botao Alterar
240:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
241:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
242:             .Caption         = "Alterar"
243:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
244:             .PicturePosition = 13
245:             .Top             = 5
246:             .Left            = 155
247:             .Width           = 75
248:             .Height          = 75
249:             .FontName        = "Comic Sans MS"
250:             .FontBold        = .T.
251:             .FontItalic      = .T.
252:             .FontSize        = 8
253:             .ForeColor       = RGB(90, 90, 90)
254:             .BackColor       = RGB(255, 255, 255)
255:             .Themes          = .F.
256:             .SpecialEffect   = 0
257:             .MousePointer    = 15
258:             .WordWrap        = .T.
259:             .AutoSize        = .F.
260:             .Visible         = .T.
261:         ENDWITH
262:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
263: 
264:         *-- Botao Excluir
265:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
266:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
267:             .Caption         = "Excluir"
268:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
269:             .PicturePosition = 13
270:             .Top             = 5
271:             .Left            = 230
272:             .Width           = 75
273:             .Height          = 75
274:             .FontName        = "Comic Sans MS"
275:             .FontBold        = .T.
276:             .FontItalic      = .T.
277:             .FontSize        = 8
278:             .ForeColor       = RGB(90, 90, 90)
279:             .BackColor       = RGB(255, 255, 255)
280:             .Themes          = .F.
281:             .SpecialEffect   = 0
282:             .MousePointer    = 15
283:             .WordWrap        = .T.
284:             .AutoSize        = .F.
285:             .Visible         = .T.
286:         ENDWITH
287:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
288: 
289:         *-- Botao Buscar
290:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
291:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
292:             .Caption         = "Buscar"
293:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
294:             .PicturePosition = 13
295:             .Top             = 5
296:             .Left            = 305
297:             .Width           = 75
298:             .Height          = 75
299:             .FontName        = "Comic Sans MS"
300:             .FontBold        = .T.
301:             .FontItalic      = .T.
302:             .FontSize        = 8
303:             .ForeColor       = RGB(90, 90, 90)
304:             .BackColor       = RGB(255, 255, 255)
305:             .Themes          = .F.
306:             .SpecialEffect   = 0
307:             .MousePointer    = 15
308:             .WordWrap        = .T.
309:             .AutoSize        = .F.
310:             .Visible         = .T.
311:         ENDWITH
312:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
313: 
314:         *-- Container Saida - PADRAO CANONICO (prevalece sobre legado per CLAUDE.md regra #10)
315:         *-- Legado: Grupo_Saida.Left=919, Top=-1. Canonico: Left=917, Top=29, Width=90
316:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
317:         WITH loc_oPagina.cnt_4c_Saida
318:             .Top       = 29
319:             .Left      = 917
320:             .Width     = 90
321:             .Height    = 85
322:             .BackStyle = 0
323:             .BorderWidth = 0
324:             .Visible   = .T.
325:         ENDWITH
326: 
327:         *-- Botao Encerrar - PADRAO CANONICO: Caption="Encerrar", Width=75, Height=75
328:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
329:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
330:             .Caption         = "Encerrar"
331:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
332:             .PicturePosition = 13
333:             .Top             = 5
334:             .Left            = 5
335:             .Width           = 75
336:             .Height          = 75
337:             .FontName        = "Tahoma"
338:             .FontBold        = .T.
339:             .FontItalic      = .T.
340:             .FontSize        = 8
341:             .ForeColor       = RGB(90, 90, 90)
342:             .BackColor       = RGB(255, 255, 255)
343:             .Themes          = .F.
344:             .SpecialEffect   = 0
345:             .MousePointer    = 15
346:             .WordWrap        = .T.
347:             .AutoSize        = .F.
348:             .Visible         = .T.
349:         ENDWITH
350:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
351: 
352:         *-- Grid de lista (Grade no legado: Top=102, Left=29, Width=940, Height=479)
353:         *-- Top=117 seguindo padrao framework (compensacao +29 do PageFrame)
354:         *-- Width=890: Left=26, termina em 916, nao sobrepoe cnt_4c_Saida (Left=917)
355:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")
356:         loc_oPagina.grd_4c_Dados.ColumnCount = 5
357:         WITH loc_oPagina.grd_4c_Dados
358:             .Top                = 117
359:             .Left               = 26
360:             .Width              = 890
361:             .Height             = 479
362:             .FontName           = "Verdana"
363:             .FontSize           = 8
364:             .ForeColor          = RGB(90, 90, 90)
365:             .BackColor          = RGB(255, 255, 255)
366:             .GridLineColor      = RGB(238, 238, 238)
367:             .HighlightBackColor = RGB(255, 255, 255)
368:             .HighlightForeColor = RGB(15, 41, 104)
369:             .HighlightStyle     = 2
370:             .DeleteMark         = .F.
371:             .RecordMark         = .F.
372:             .RowHeight          = 16
373:             .ScrollBars         = 2
374:             .GridLines          = 3
375:             .Column1.Width      = 100
376:             .Column2.Width      = 300
377:             .Column3.Width      = 55
378:             .Column4.Width      = 250
379:             .Column5.Width      = 60
380:             .Visible            = .T.
381:         ENDWITH
382: 
383:         THIS.TornarControlesVisiveis(loc_oPagina)
384:     ENDPROC
385: 
386:     *==========================================================================
387:     * ConfigurarPaginaDados - Configura Page2 (estrutura base Fase 3)
388:     * Cria: cnt_4c_BotoesAcao (vazio)
389:     * TextBoxes de dados e botoes Salvar/Cancelar serao adicionados nas Fases 4-6
390:     *==========================================================================
391:     PROTECTED PROCEDURE ConfigurarPaginaDados()
392:         LOCAL loc_oPagina
393:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
394: 
395:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
396:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
397: 
398:         *-- Container BotoesAcao (Grupo_Salva no legado: Left=843, Top=-3, Width~160, Height=85)
399:         *-- Com comp +29: Top=26, Left=843
400:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
401:         WITH loc_oPagina.cnt_4c_BotoesAcao
402:             .Top       = 26
403:             .Left      = 843
404:             .Width     = 160
405:             .Height    = 85
406:             .BackStyle = 0
407:             .BorderWidth = 0
408:             .Visible   = .T.
409:         ENDWITH
410: 
411:         *-- Botao Confirmar (Salva.Salva no legado: Left=5, Top=5)
412:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
413:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
414:             .Caption         = "Confirmar"
415:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
416:             .PicturePosition = 13
417:             .Top             = 5
418:             .Left            = 5
419:             .Width           = 75
420:             .Height          = 75
421:             .FontName        = "Comic Sans MS"
422:             .FontBold        = .T.
423:             .FontItalic      = .T.
424:             .FontSize        = 8
425:             .ForeColor       = RGB(90, 90, 90)
426:             .BackColor       = RGB(255, 255, 255)
427:             .Themes          = .F.
428:             .SpecialEffect   = 0
429:             .MousePointer    = 15
430:             .WordWrap        = .T.
431:             .AutoSize        = .F.
432:             .Visible         = .T.
433:         ENDWITH
434:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
435: 
436:         *-- Botao Cancelar (Salva.Cancela no legado: Left=80, Top=5)
437:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
438:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
439:             .Caption         = "Encerrar"
440:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
441:             .PicturePosition = 13
442:             .Top             = 5
443:             .Left            = 80
444:             .Width           = 75
445:             .Height          = 75
446:             .FontName        = "Comic Sans MS"
447:             .FontBold        = .T.
448:             .FontItalic      = .T.
449:             .FontSize        = 8
450:             .ForeColor       = RGB(90, 90, 90)
451:             .BackColor       = RGB(255, 255, 255)
452:             .Themes          = .F.
453:             .SpecialEffect   = 0
454:             .MousePointer    = 15
455:             .WordWrap        = .T.
456:             .AutoSize        = .F.
457:             .Visible         = .T.
458:         ENDWITH
459:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
460: 
461:         *-- Label Codigo (Say1: top=192, left=339 -> +29 comp: top=221)
462:         loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
463:         WITH loc_oPagina.lbl_4c_Codigo
464:             .Caption   = "C" + CHR(243) + "digo :"
465:             .Top       = 221
466:             .Left      = 339
467:             .Width     = 42
468:             .Height    = 17
469:             .FontName  = "Tahoma"
470:             .FontSize  = 8
471:             .FontBold  = .F.
472:             .ForeColor = RGB(90, 90, 90)
473:             .BackStyle = 0
474:             .Alignment = 1
475:             .AutoSize  = .F.
476:             .Visible   = .T.
477:         ENDWITH
478: 
479:         *-- TextBox Codigo (getCodigos: top=188, left=383, width=150, height=23 -> top=217)
480:         *-- Habilitado somente em INCLUIR e BUSCAR (PK nao pode ser alterada)
481:         loc_oPagina.AddObject("txt_4c_Codigos", "TextBox")
482:         WITH loc_oPagina.txt_4c_Codigos
483:             .Value     = ""
484:             .Top       = 217
485:             .Left      = 383
486:             .Width     = 150
487:             .Height    = 23
488:             .FontName  = "Tahoma"
489:             .FontSize  = 8
490:             .MaxLength = 20
491:             .TabIndex  = 1
492:             .Visible   = .T.
493:         ENDWITH
494: 
495:         *-- Label Descricao (Say2: top=218, left=326 -> +29 comp: top=247)
496:         loc_oPagina.AddObject("lbl_4c_Descrs", "Label")
497:         WITH loc_oPagina.lbl_4c_Descrs
498:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
499:             .Top       = 247

*-- Linhas 594 a 1287:
594:             .TabIndex       = 8
595:             .Visible        = .T.
596:         ENDWITH
597:         BINDEVENT(loc_oPagina.txt_4c_CdGrupo, "KeyPress", THIS, "CdGrupoKeyPress")
598:         BINDEVENT(loc_oPagina.txt_4c_CdGrupo, "DblClick", THIS, "CdGrupoDblClick")
599: 
600:         *-- TextBox Descricao Grupo (get_ds_grupo: top=240, left=416, width=150, height=23 -> top=269)
601:         loc_oPagina.AddObject("txt_4c_DsGrupo", "TextBox")
602:         WITH loc_oPagina.txt_4c_DsGrupo
603:             .Value          = ""
604:             .Top            = 269
605:             .Left           = 416
606:             .Width          = 150
607:             .Height         = 23
608:             .FontName       = "Tahoma"
609:             .FontSize       = 8
610:             .ForeColor      = RGB(0, 0, 0)
611:             .SpecialEffect  = 1
612:             .MaxLength      = 40
613:             .TabIndex       = 9
614:             .Visible        = .T.
615:         ENDWITH
616:         BINDEVENT(loc_oPagina.txt_4c_DsGrupo, "KeyPress", THIS, "DsGrupoKeyPress")
617:         BINDEVENT(loc_oPagina.txt_4c_DsGrupo, "DblClick", THIS, "DsGrupoDblClick")
618: 
619:         *-- CheckBox Obrigatorio (chkObrig: top=244, left=573, height=15, width=72 -> top=273)
620:         loc_oPagina.AddObject("chk_4c_Obrig", "CheckBox")
621:         WITH loc_oPagina.chk_4c_Obrig
622:             .Caption   = "Obrigat" + CHR(243) + "rio"
623:             .Value     = 0
624:             .Top       = 273
625:             .Left      = 573
626:             .Width     = 72
627:             .Height    = 15
628:             .FontName  = "Tahoma"
629:             .FontSize  = 8
630:             .ForeColor = RGB(90, 90, 90)
631:             .BackStyle = 0
632:             .Alignment = 0
633:             .AutoSize  = .F.
634:             .Visible   = .T.
635:         ENDWITH
636: 
637:         *-- BINDEVENT para validacao de ordem duplicada (equivalente ao Valid do legado)
638:         BINDEVENT(loc_oPagina.txt_4c_Ordens, "KeyPress", THIS, "OrdemLostFocus")
639: 
640:         THIS.TornarControlesVisiveis(loc_oPagina)
641:     ENDPROC
642: 
643:     *==========================================================================
644:     * CarregarLista - Busca registros e vincula grid ao cursor
645:     * RecordSource FORA do WITH e APOS Buscar() (Problemas 36/48)
646:     * ControlSource e Headers APOS RecordSource (Problemas 32/48)
647:     *==========================================================================
648:     PROCEDURE CarregarLista()
649:         LOCAL loc_lResultado, loc_oGrid
650:         loc_lResultado = .F.
651: 
652:         TRY
653:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
654:                 loc_lResultado = .T.
655:             ELSE
656:                 IF VARTYPE(THIS.this_oBusinessObject) != "O"
657:                     MsgAviso("Business Object n" + CHR(227) + "o inicializado.")
658:                 ELSE
659:                     IF THIS.this_oBusinessObject.Buscar("")
660:                         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
661:                             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
662:                             IF VARTYPE(loc_oGrid) = "O"
663:                                 *-- RecordSource ANTES de ControlSource (auto-bind por ordem de campo)
664:                                 loc_oGrid.ColumnCount = 5
665:                                 loc_oGrid.RecordSource = "cursor_4c_Dados"
666:                                 *-- ControlSource expl?cito APOS RecordSource
667:                                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Codigos"
668:                                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descrs"
669:                                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Cgrus"
670:                                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.Dgrus"
671:                                 loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Ordens"
672:                                 *-- Headers APOS ControlSource (reset pelo RecordSource)
673:                                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
674:                                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
675:                                 loc_oGrid.Column3.Header1.Caption = "Grupo"
676:                                 loc_oGrid.Column4.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o Grupo"
677:                                 loc_oGrid.Column5.Header1.Caption = "Ordem"
678:                                 THIS.FormatarGridLista(loc_oGrid)
679:                             ENDIF
680:                         ENDIF
681:                         loc_lResultado = .T.
682:                     ENDIF
683:                 ENDIF
684:             ENDIF
685:         CATCH TO loException
686:             MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message, ;
687:                 "Formcrp.CarregarLista")
688:             loc_lResultado = .F.
689:         ENDTRY
690: 
691:         RETURN loc_lResultado
692:     ENDPROC
693: 
694:     *==========================================================================
695:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
696:     * Ao voltar para Page1 recarrega a lista
697:     *==========================================================================
698:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
699:         LOCAL loc_lResultado
700:         loc_lResultado = .F.
701: 
702:         TRY
703:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
704:                 MsgAviso("P" + CHR(225) + "gina inv" + CHR(225) + "lida.")
705:             ELSE
706:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
707: 
708:                 IF par_nPagina = 1
709:                     THIS.this_cModoAtual = "LISTA"
710:                     THIS.CarregarLista()
711:                 ENDIF
712: 
713:                 loc_lResultado = .T.
714:             ENDIF
715:         CATCH TO loException
716:             MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loException.Message, ;
717:                 "Formcrp.AlternarPagina")
718:         ENDTRY
719: 
720:         RETURN loc_lResultado
721:     ENDPROC
722: 
723:     *==========================================================================
724:     * BtnIncluirClick - Prepara Page2 para incluir novo registro
725:     *==========================================================================
726:     PROCEDURE BtnIncluirClick()
727:         THIS.this_oBusinessObject.NovoRegistro()
728:         THIS.LimparCampos()
729:         THIS.this_cModoAtual = "INCLUIR"
730:         THIS.HabilitarCampos(.T.)
731:         THIS.AjustarBotoesPorModo()
732:         THIS.AlternarPagina(2)
733:         IF VARTYPE(THIS.pgf_4c_Paginas.Page2) = "O"
734:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Codigos", 5)
735:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Codigos.SetFocus()
736:             ENDIF
737:         ENDIF
738:     ENDPROC
739: 
740:     *==========================================================================
741:     * BtnVisualizarClick - Carrega registro selecionado em modo somente leitura
742:     *==========================================================================
743:     PROCEDURE BtnVisualizarClick()
744:         LOCAL loc_cCodigo
745:         loc_cCodigo = ""
746: 
747:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
748:             MsgAviso("Nenhum registro selecionado.")
749:             RETURN
750:         ENDIF
751:         SELECT cursor_4c_Dados
752:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigos)
753:         IF EMPTY(loc_cCodigo)
754:             MsgAviso("C" + CHR(243) + "digo inv" + CHR(225) + "lido.")
755:             RETURN
756:         ENDIF
757:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
758:             THIS.BOParaForm()
759:             THIS.this_cModoAtual = "VISUALIZAR"
760:             THIS.HabilitarCampos(.F.)
761:             THIS.AjustarBotoesPorModo()
762:             THIS.AlternarPagina(2)
763:             IF VARTYPE(THIS.pgf_4c_Paginas.Page2) = "O"
764:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
765:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus()
766:                 ENDIF
767:             ENDIF
768:         ENDIF
769:     ENDPROC
770: 
771:     *==========================================================================
772:     * BtnAlterarClick - Carrega registro selecionado em modo edicao
773:     *==========================================================================
774:     PROCEDURE BtnAlterarClick()
775:         LOCAL loc_cCodigo
776:         loc_cCodigo = ""
777: 
778:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
779:             MsgAviso("Nenhum registro selecionado.")
780:             RETURN
781:         ENDIF
782:         SELECT cursor_4c_Dados
783:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigos)
784:         IF EMPTY(loc_cCodigo)
785:             MsgAviso("C" + CHR(243) + "digo inv" + CHR(225) + "lido.")
786:             RETURN
787:         ENDIF
788:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
789:             THIS.this_oBusinessObject.EditarRegistro()
790:             THIS.BOParaForm()
791:             THIS.this_cModoAtual = "ALTERAR"
792:             THIS.HabilitarCampos(.T.)
793:             THIS.AjustarBotoesPorModo()
794:             THIS.AlternarPagina(2)
795:             IF VARTYPE(THIS.pgf_4c_Paginas.Page2) = "O"
796:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Descrs", 5)
797:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Descrs.SetFocus()
798:                 ENDIF
799:             ENDIF
800:         ENDIF
801:     ENDPROC
802: 
803:     *==========================================================================
804:     * BtnExcluirClick - Confirma e exclui registro selecionado
805:     *==========================================================================
806:     PROCEDURE BtnExcluirClick()
807:         LOCAL loc_cCodigo, loc_lConfirma
808:         loc_cCodigo  = ""
809:         loc_lConfirma = .F.
810: 
811:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
812:             MsgAviso("Nenhum registro selecionado.")
813:             RETURN
814:         ENDIF
815:         SELECT cursor_4c_Dados
816:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigos)
817:         IF EMPTY(loc_cCodigo)
818:             MsgAviso("C" + CHR(243) + "digo inv" + CHR(225) + "lido.")
819:             RETURN
820:         ENDIF
821:         loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o da caracter" + CHR(237) + ;
822:             "stica '" + loc_cCodigo + "'?", "Excluir")
823:         IF loc_lConfirma
824:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
825:                 IF THIS.this_oBusinessObject.Excluir()
826:                     MsgInfo("Caracter" + CHR(237) + "stica exclu" + CHR(237) + "da com sucesso!")
827:                     THIS.CarregarLista()
828:                 ENDIF
829:             ENDIF
830:         ENDIF
831:     ENDPROC
832: 
833:     *==========================================================================
834:     * BtnBuscarClick - Prepara Page2 para buscar registro por codigo
835:     * Legado: PROCURAR navega para Page2, usuario digita codigo e pressiona OK
836:     *==========================================================================
837:     PROCEDURE BtnBuscarClick()
838:         THIS.LimparCampos()
839:         THIS.this_cModoAtual = "BUSCAR"
840:         THIS.HabilitarCampos(.T.)
841:         THIS.AjustarBotoesPorModo()
842:         THIS.AlternarPagina(2)
843:         IF VARTYPE(THIS.pgf_4c_Paginas.Page2) = "O"
844:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Codigos", 5)
845:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Codigos.SetFocus()
846:             ENDIF
847:         ENDIF
848:     ENDPROC
849: 
850:     *==========================================================================
851:     * BtnEncerrarClick - Fecha o formulario
852:     *==========================================================================
853:     PROCEDURE BtnEncerrarClick()
854:         THIS.Release()
855:     ENDPROC
856: 
857:     *==========================================================================
858:     * BOParaForm - Transfere dados do BO para os campos da Page2
859:     * Usa PEMSTATUS para ser seguro mesmo quando Page2 ainda nao tem todos os campos
860:     *==========================================================================
861:     PROTECTED PROCEDURE BOParaForm()
862:         LOCAL loc_oPagina
863:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
864: 
865:         IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
866:             loc_oPagina.txt_4c_Codigos.Value = THIS.this_oBusinessObject.this_cCodigos
867:         ENDIF
868:         IF PEMSTATUS(loc_oPagina, "txt_4c_Descrs", 5)
869:             loc_oPagina.txt_4c_Descrs.Value = THIS.this_oBusinessObject.this_cDescrs
870:         ENDIF
871:         IF PEMSTATUS(loc_oPagina, "txt_4c_Ordens", 5)
872:             loc_oPagina.txt_4c_Ordens.Value = THIS.this_oBusinessObject.this_nOrdens
873:         ENDIF
874:         IF PEMSTATUS(loc_oPagina, "txt_4c_CdGrupo", 5)
875:             loc_oPagina.txt_4c_CdGrupo.Value = THIS.this_oBusinessObject.this_cCgrus
876:         ENDIF
877:         IF PEMSTATUS(loc_oPagina, "txt_4c_DsGrupo", 5)
878:             loc_oPagina.txt_4c_DsGrupo.Value = THIS.this_oBusinessObject.this_cDgrus
879:         ENDIF
880:         IF PEMSTATUS(loc_oPagina, "chk_4c_Obrig", 5)
881:             loc_oPagina.chk_4c_Obrig.Value = (THIS.this_oBusinessObject.this_nChkobrig .Value = IIF(THIS.this_oBusinessObject.this_nChkobrig = 1, 1, 0))
882:         ENDIF
883:     ENDPROC
884: 
885:     *==========================================================================
886:     * LimparCampos - Limpa os campos da Page2
887:     *==========================================================================
888:     PROTECTED PROCEDURE LimparCampos()
889:         LOCAL loc_oPagina
890:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
891: 
892:         IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
893:             loc_oPagina.txt_4c_Codigos.Value = ""
894:         ENDIF
895:         IF PEMSTATUS(loc_oPagina, "txt_4c_Descrs", 5)
896:             loc_oPagina.txt_4c_Descrs.Value = ""
897:         ENDIF
898:         IF PEMSTATUS(loc_oPagina, "txt_4c_Ordens", 5)
899:             loc_oPagina.txt_4c_Ordens.Value = 0
900:         ENDIF
901:         IF PEMSTATUS(loc_oPagina, "txt_4c_CdGrupo", 5)
902:             loc_oPagina.txt_4c_CdGrupo.Value = ""
903:         ENDIF
904:         IF PEMSTATUS(loc_oPagina, "txt_4c_DsGrupo", 5)
905:             loc_oPagina.txt_4c_DsGrupo.Value = ""
906:         ENDIF
907:         IF PEMSTATUS(loc_oPagina, "chk_4c_Obrig", 5)
908:             loc_oPagina.chk_4c_Obrig.Value = 0
909:         ENDIF
910:     ENDPROC
911: 
912:     *==========================================================================
913:     * HabilitarCampos - Habilita ou desabilita os campos da Page2
914:     * Codigos: editavel apenas em INCLUIR e BUSCAR (PK nao pode ser alterada)
915:     *==========================================================================
916:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
917:         LOCAL loc_oPagina, loc_lHabilitar
918:         loc_oPagina  = THIS.pgf_4c_Paginas.Page2
919:         loc_lHabilitar = (par_lHabilitar = .T.)
920: 
921:         IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
922:             loc_oPagina.txt_4c_Codigos.Enabled = (loc_lHabilitar AND ;
923:                 INLIST(THIS.this_cModoAtual, "INCLUIR", "BUSCAR"))
924:         ENDIF
925:         IF PEMSTATUS(loc_oPagina, "txt_4c_Descrs", 5)
926:             loc_oPagina.txt_4c_Descrs.Enabled = loc_lHabilitar
927:         ENDIF
928:         IF PEMSTATUS(loc_oPagina, "txt_4c_Ordens", 5)
929:             loc_oPagina.txt_4c_Ordens.Enabled = loc_lHabilitar
930:         ENDIF
931:         IF PEMSTATUS(loc_oPagina, "txt_4c_CdGrupo", 5)
932:             loc_oPagina.txt_4c_CdGrupo.Enabled = loc_lHabilitar
933:         ENDIF
934:         IF PEMSTATUS(loc_oPagina, "txt_4c_DsGrupo", 5)
935:             loc_oPagina.txt_4c_DsGrupo.Enabled = loc_lHabilitar
936:         ENDIF
937:         IF PEMSTATUS(loc_oPagina, "chk_4c_Obrig", 5)
938:             loc_oPagina.chk_4c_Obrig.Enabled = loc_lHabilitar
939:         ENDIF
940:     ENDPROC
941: 
942:     *==========================================================================
943:     * AjustarBotoesPorModo - Habilita/desabilita botoes de Page2 conforme modo
944:     * Confirmar: habilitado em INCLUIR/ALTERAR/BUSCAR
945:     * Cancelar: sempre habilitado
946:     *==========================================================================
947:     PROTECTED PROCEDURE AjustarBotoesPorModo()
948:         LOCAL loc_oCnt, loc_lModoEdicao
949:         loc_oCnt      = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
950:         loc_lModoEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "BUSCAR")
951: 
952:         IF PEMSTATUS(loc_oCnt, "cmd_4c_Confirmar", 5)
953:             loc_oCnt.cmd_4c_Confirmar.Enabled = loc_lModoEdicao
954:         ENDIF
955:         IF PEMSTATUS(loc_oCnt, "cmd_4c_Cancelar", 5)
956:             loc_oCnt.cmd_4c_Cancelar.Enabled = .T.
957:         ENDIF
958:     ENDPROC
959: 
960:     *==========================================================================
961:     * FormatarGridLista - Aplica formatacao visual padrao ao grid
962:     *==========================================================================
963:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
964:         WITH par_oGrid
965:             .FontName = "Tahoma"
966:             .FontSize = 8
967:         ENDWITH
968:     ENDPROC
969: 
970:     *==========================================================================
971:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
972:     * Necessario porque AddObject() cria controles com Visible=.F. por padrao
973:     *==========================================================================
974:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
975:         LOCAL loc_nI, loc_oObjeto, loc_nP
976: 
977:         FOR loc_nI = 1 TO par_oContainer.ControlCount
978:             loc_oObjeto = par_oContainer.Controls(loc_nI)
979: 
980:             IF VARTYPE(loc_oObjeto) = "O"
981:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
982:                     loc_oObjeto.Visible = .T.
983:                 ENDIF
984: 
985:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
986:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
987:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
988:                     ENDFOR
989:                 ENDIF
990: 
991:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
992:                     THIS.TornarControlesVisiveis(loc_oObjeto)
993:                 ENDIF
994:             ENDIF
995:         ENDFOR
996:     ENDPROC
997: 
998:     *==========================================================================
999:     * BtnSalvarClick - Valida e salva (Confirmar). Legado: Salva.Click
1000:     * Em modo BUSCAR: filtra lista pelo codigo digitado
1001:     * Em modo INCLUIR/ALTERAR: valida e chama BO.Salvar()
1002:     *==========================================================================
1003:     PROCEDURE BtnSalvarClick()
1004:         LOCAL loc_lSucesso, loc_oPagina, loc_cCodigos, loc_cDescrs
1005:         loc_lSucesso  = .F.
1006:         loc_oPagina   = THIS.pgf_4c_Paginas.Page2
1007:         loc_cCodigos  = ""
1008:         loc_cDescrs   = ""
1009: 
1010:         IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
1011:             loc_cCodigos = ALLTRIM(loc_oPagina.txt_4c_Codigos.Value)
1012:         ENDIF
1013: 
1014:         *-- Modo BUSCAR: filtra a lista por codigo
1015:         IF THIS.this_cModoAtual = "BUSCAR"
1016:             IF !EMPTY(loc_cCodigos)
1017:                 THIS.this_oBusinessObject.Buscar("a.Codigos LIKE " + EscaparSQL(loc_cCodigos + "%"))
1018:             ELSE
1019:                 THIS.this_oBusinessObject.Buscar("")
1020:             ENDIF
1021:             THIS.this_cModoAtual = "LISTA"
1022:             THIS.AlternarPagina(1)
1023:             RETURN
1024:         ENDIF
1025: 
1026:         *-- Validacao minima antes do TRY (Problema 16)
1027:         IF EMPTY(loc_cCodigos)
1028:             MsgAviso("C" + CHR(243) + "digo Inv" + CHR(225) + "lido!")
1029:             IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
1030:                 loc_oPagina.txt_4c_Codigos.SetFocus()
1031:             ENDIF
1032:             RETURN
1033:         ENDIF
1034: 
1035:         IF PEMSTATUS(loc_oPagina, "txt_4c_Descrs", 5)
1036:             loc_cDescrs = ALLTRIM(loc_oPagina.txt_4c_Descrs.Value)
1037:         ENDIF
1038:         IF EMPTY(loc_cDescrs)
1039:             MsgAviso("Descri" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!")
1040:             IF PEMSTATUS(loc_oPagina, "txt_4c_Descrs", 5)
1041:                 loc_oPagina.txt_4c_Descrs.SetFocus()
1042:             ENDIF
1043:             RETURN
1044:         ENDIF
1045: 
1046:         THIS.FormParaBO()
1047: 
1048:         TRY
1049:             IF THIS.this_oBusinessObject.Salvar()
1050:                 MsgInfo("Caracter" + CHR(237) + "stica salva com sucesso!")
1051:                 THIS.this_cModoAtual = "LISTA"
1052:                 THIS.AlternarPagina(1)
1053:                 loc_lSucesso = .T.
1054:             ENDIF
1055:         CATCH TO loException
1056:             MostrarErro("Erro ao salvar:" + CHR(13) + loException.Message + CHR(13) + ;
1057:                 "Linha: " + TRANSFORM(loException.LineNo), "Formcrp.BtnSalvarClick")
1058:         ENDTRY
1059:     ENDPROC
1060: 
1061:     *==========================================================================
1062:     * BtnCancelarClick - Cancela edicao e volta para a lista
1063:     *==========================================================================
1064:     PROCEDURE BtnCancelarClick()
1065:         THIS.this_cModoAtual = "LISTA"
1066:         THIS.AlternarPagina(1)
1067:         THIS.CarregarLista()
1068:     ENDPROC
1069: 
1070:     *==========================================================================
1071:     * FormParaBO - Transfere dados dos campos da Page2 para as propriedades do BO
1072:     * Inverso de BOParaForm()
1073:     *==========================================================================
1074:     PROTECTED PROCEDURE FormParaBO()
1075:         LOCAL loc_oPagina
1076:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1077: 
1078:         IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
1079:             THIS.this_oBusinessObject.this_cCodigos = ALLTRIM(loc_oPagina.txt_4c_Codigos.Value)
1080:         ENDIF
1081:         IF PEMSTATUS(loc_oPagina, "txt_4c_Descrs", 5)
1082:             THIS.this_oBusinessObject.this_cDescrs = ALLTRIM(loc_oPagina.txt_4c_Descrs.Value)
1083:         ENDIF
1084:         IF PEMSTATUS(loc_oPagina, "txt_4c_Ordens", 5)
1085:             THIS.this_oBusinessObject.this_nOrdens = loc_oPagina.txt_4c_Ordens.Value
1086:         ENDIF
1087:         IF PEMSTATUS(loc_oPagina, "txt_4c_CdGrupo", 5)
1088:             THIS.this_oBusinessObject.this_cCgrus = ALLTRIM(loc_oPagina.txt_4c_CdGrupo.Value)
1089:         ENDIF
1090:         IF PEMSTATUS(loc_oPagina, "txt_4c_DsGrupo", 5)
1091:             THIS.this_oBusinessObject.this_cDgrus = ALLTRIM(loc_oPagina.txt_4c_DsGrupo.Value)
1092:         ENDIF
1093:         IF PEMSTATUS(loc_oPagina, "chk_4c_Obrig", 5)
1094:             THIS.this_oBusinessObject.this_nChkobrig = IIF(loc_oPagina.chk_4c_Obrig.Value = 1, 1, 0)
1095:         ENDIF
1096:     ENDPROC
1097: 
1098:     *==========================================================================
1099:     * CdGrupoKeyPress - Handler KeyPress do campo Codigo Grupo (PUBLIC para BINDEVENT)
1100:     *==========================================================================
1101:     PROCEDURE CdGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1102:         IF par_nKeyCode = 28
1103:             THIS.AbrirLookupGrupo("CODIGO")
1104:         ENDIF
1105:     ENDPROC
1106: 
1107:     *==========================================================================
1108:     * CdGrupoDblClick - Handler DblClick do campo Codigo Grupo (PUBLIC para BINDEVENT)
1109:     *==========================================================================
1110:     PROCEDURE CdGrupoDblClick()
1111:         THIS.AbrirLookupGrupo("CODIGO")
1112:     ENDPROC
1113: 
1114:     *==========================================================================
1115:     * DsGrupoKeyPress - Handler KeyPress do campo Descricao Grupo (PUBLIC para BINDEVENT)
1116:     *==========================================================================
1117:     PROCEDURE DsGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1118:         IF par_nKeyCode = 28
1119:             THIS.AbrirLookupGrupo("DESCRICAO")
1120:         ENDIF
1121:     ENDPROC
1122: 
1123:     *==========================================================================
1124:     * DsGrupoDblClick - Handler DblClick do campo Descricao Grupo (PUBLIC para BINDEVENT)
1125:     *==========================================================================
1126:     PROCEDURE DsGrupoDblClick()
1127:         THIS.AbrirLookupGrupo("DESCRICAO")
1128:     ENDPROC
1129: 
1130:     *==========================================================================
1131:     * AbrirLookupGrupo - Abre busca auxiliar para o campo Grupo
1132:     * par_cCampoBusca: "CODIGO" ou "DESCRICAO"
1133:     * pnTipo=2 (Movimentacoes): busca em SigCdGpr (Grupos Grandes), cols: codigos/descs
1134:     * pnTipo=0/1 (Produtos/Contas): busca em SigCdGrp (Grupos Produto), cols: cgrus/dgrus
1135:     * Legado: fwBuscaExt em get_cd_grupo.Valid e get_ds_grupo.Valid
1136:     *==========================================================================
1137:     PROTECTED PROCEDURE AbrirLookupGrupo(par_cCampoBusca)
1138:         LOCAL loc_oPagina, loc_cTabela, loc_cCampoCod, loc_cCampoDesc
1139:         LOCAL loc_cCampoPesquisa, loc_cValorBusca, loc_oBusca, loc_lMovim
1140: 
1141:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1142:         loc_lMovim  = (THIS.this_nTipos = 2)
1143: 
1144:         IF loc_lMovim
1145:             *-- Movimentacoes: SigCdGpr (Grande Grupo) - codigos char(3), descs char(40)
1146:             loc_cTabela    = "SigCdGpr"
1147:             loc_cCampoCod  = "codigos"
1148:             loc_cCampoDesc = "descs"
1149:         ELSE
1150:             *-- Produtos/Contas: SigCdGrp - cgrus char(3), dgrus char(40)
1151:             loc_cTabela    = "SigCdGrp"
1152:             loc_cCampoCod  = "cgrus"
1153:             loc_cCampoDesc = "dgrus"
1154:         ENDIF
1155: 
1156:         IF par_cCampoBusca = "CODIGO"
1157:             loc_cCampoPesquisa = loc_cCampoCod
1158:             loc_cValorBusca    = ALLTRIM(IIF(PEMSTATUS(loc_oPagina, "txt_4c_CdGrupo", 5), ;
1159:                 loc_oPagina.txt_4c_CdGrupo.Value, ""))
1160:         ELSE
1161:             loc_cCampoPesquisa = loc_cCampoDesc
1162:             loc_cValorBusca    = ALLTRIM(IIF(PEMSTATUS(loc_oPagina, "txt_4c_DsGrupo", 5), ;
1163:                 loc_oPagina.txt_4c_DsGrupo.Value, ""))
1164:         ENDIF
1165: 
1166:         IF USED("cursor_4c_BuscaGrupo")
1167:             USE IN cursor_4c_BuscaGrupo
1168:         ENDIF
1169: 
1170:         TRY
1171:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1172:                 loc_cTabela, "cursor_4c_BuscaGrupo", ;
1173:                 loc_cCampoPesquisa, loc_cValorBusca, ;
1174:                 "Grupo")
1175: 
1176:             IF VARTYPE(loc_oBusca) = "O"
1177:                 IF !loc_oBusca.this_lSelecionou OR !loc_oBusca.this_lAchouRegistro
1178:                     IF loc_lMovim
1179:                         loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
1180:                         loc_oBusca.mAddColuna("descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
1181:                     ELSE
1182:                         loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
1183:                         loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
1184:                     ENDIF
1185:                     loc_oBusca.Show()
1186:                 ENDIF
1187: 
1188:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
1189:                     IF PEMSTATUS(loc_oPagina, "txt_4c_CdGrupo", 5)
1190:                         loc_oPagina.txt_4c_CdGrupo.Value = ;
1191:                             ALLTRIM(EVALUATE("cursor_4c_BuscaGrupo." + loc_cCampoCod))
1192:                     ENDIF
1193:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsGrupo", 5)
1194:                         loc_oPagina.txt_4c_DsGrupo.Value = ;
1195:                             ALLTRIM(EVALUATE("cursor_4c_BuscaGrupo." + loc_cCampoDesc))
1196:                     ENDIF
1197:                 ENDIF
1198: 
1199:                 loc_oBusca.Release()
1200:             ENDIF
1201:         CATCH TO loException
1202:             MostrarErro("Erro ao abrir busca de grupo:" + CHR(13) + loException.Message, ;
1203:                 "Formcrp.AbrirLookupGrupo")
1204:         ENDTRY
1205: 
1206:         IF USED("cursor_4c_BuscaGrupo")
1207:             USE IN cursor_4c_BuscaGrupo
1208:         ENDIF
1209:     ENDPROC
1210: 
1211:     *==========================================================================
1212:     * OrdemLostFocus - Valida ordem duplicada ao sair do campo (PUBLIC para BINDEVENT)
1213:     * Legado: Get_Ordem.Valid - SELECT Ordens FROM SigCrRap WHERE Ordens=X AND Codigos<>Y AND nTipos=Z
1214:     *==========================================================================
1215:     PROCEDURE OrdemLostFocus()
1216:         LOCAL loc_oPagina, loc_nOrdem, loc_cCodigos, loc_cSQL, loc_nResult
1217:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1218: 
1219:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1220:             RETURN
1221:         ENDIF
1222: 
1223:         IF !PEMSTATUS(loc_oPagina, "txt_4c_Ordens", 5)
1224:             RETURN
1225:         ENDIF
1226: 
1227:         loc_nOrdem = loc_oPagina.txt_4c_Ordens.Value
1228:         IF loc_nOrdem <= 0
1229:             RETURN
1230:         ENDIF
1231: 
1232:         loc_cCodigos = ""
1233:         IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
1234:             loc_cCodigos = ALLTRIM(loc_oPagina.txt_4c_Codigos.Value)
1235:         ENDIF
1236: 
1237:         TRY
1238:             loc_cSQL = "SELECT Ordens FROM SigCrRap" + ;
1239:                 " WHERE Ordens = " + FormatarNumeroSQL(loc_nOrdem) + ;
1240:                 " AND Codigos <> " + EscaparSQL(loc_cCodigos) + ;
1241:                 " AND nTipos = " + ALLTRIM(STR(THIS.this_nTipos))
1242: 
1243:             IF USED("cursor_4c_ValidaOrdem")
1244:                 USE IN cursor_4c_ValidaOrdem
1245:             ENDIF
1246: 
1247:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaOrdem")
1248: 
1249:             IF loc_nResult < 0
1250:                 MsgAviso("Falha ao verificar ordem.")
1251:             ELSE
1252:                 IF USED("cursor_4c_ValidaOrdem") AND RECCOUNT("cursor_4c_ValidaOrdem") > 0
1253:                     MsgAviso("Ordem j" + CHR(225) + " cadastrada!")
1254:                     loc_oPagina.txt_4c_Ordens.Value = 0
1255:                     loc_oPagina.txt_4c_Ordens.SetFocus()
1256:                 ENDIF
1257:             ENDIF
1258:         CATCH TO loException
1259:             MostrarErro("Erro ao validar ordem:" + CHR(13) + loException.Message, ;
1260:                 "Formcrp.OrdemLostFocus")
1261:         ENDTRY
1262: 
1263:         IF USED("cursor_4c_ValidaOrdem")
1264:             USE IN cursor_4c_ValidaOrdem
1265:         ENDIF
1266:     ENDPROC
1267: 
1268:     *==========================================================================
1269:     * Destroy - Libera recursos
1270:     *==========================================================================
1271:     PROCEDURE Destroy()
1272:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1273:             THIS.this_oBusinessObject = .NULL.
1274:         ENDIF
1275:         IF USED("cursor_4c_Dados")
1276:             USE IN cursor_4c_Dados
1277:         ENDIF
1278:         IF USED("cursor_4c_BuscaGrupo")
1279:             USE IN cursor_4c_BuscaGrupo
1280:         ENDIF
1281:         IF USED("cursor_4c_ValidaOrdem")
1282:             USE IN cursor_4c_ValidaOrdem
1283:         ENDIF
1284:         DODEFAULT()
1285:     ENDPROC
1286: 
1287: ENDDEFINE


### BO (C:\4c\projeto\app\classes\crpBO.prg):
*------------------------------------------------------------------------------
* crpBO.prg - Business Object para Cadastro de Caracteristicas
* Tabela: SigCrRaP | PK: Codigos
* Herda de: BusinessBase
* nTipos: 0=Produtos, 1=Contas, 2=Movimentacoes
*------------------------------------------------------------------------------

DEFINE CLASS crpBO AS BusinessBase

    *-- Propriedades mapeadas da tabela SIGCRRAP (schema.sql)
    *-- codigos char(20) NOT NULL (PK)
    this_cCodigos     = ""
    *-- descrs char(40) NOT NULL
    this_cDescrs      = ""
    *-- impetqs numeric(1,0) NOT NULL
    this_nImpetqs     = 0
    *-- ordens numeric(6,0) NOT NULL
    this_nOrdens      = 0
    *-- ntipos numeric(1,0) NOT NULL (0=Produto, 1=Conta, 2=Movimentacao)
    this_nTipos       = 0
    *-- cgrus char(3) NOT NULL (FK -> SigCdGrp ou SigCdGpr conforme nTipos)
    this_cCgrus       = ""
    *-- cidchaves char(20) NOT NULL (chave interna unica)
    this_cCidchaves   = ""
    *-- chkobrig numeric(1,0) NOT NULL DEFAULT(0)
    this_nChkobrig    = 0
    *-- dgrus: descricao do grupo (calculada via JOIN, nao armazenada na tabela)
    this_cDgrus       = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCrRaP"
            THIS.this_cCampoChave = "Codigos"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "crpBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigos)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * Cursores de Buscar/CarregarPorCodigo sempre incluem dgrus via JOIN
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigos     = TratarNulo(codigos,   "C")
                THIS.this_cDescrs      = TratarNulo(descrs,    "C")
                THIS.this_nImpetqs     = TratarNulo(impetqs,   "N")
                THIS.this_nOrdens      = TratarNulo(ordens,    "N")
                THIS.this_nTipos       = TratarNulo(ntipos,    "N")
                THIS.this_cCgrus       = TratarNulo(cgrus,     "C")
                THIS.this_cCidchaves   = TratarNulo(cidchaves, "C")
                THIS.this_nChkobrig    = TratarNulo(chkobrig,  "N")
                THIS.this_cDgrus       = TratarNulo(dgrus,     "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "crpBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    * Verifica: Codigos obrigatorio, Descrs obrigatorio,
    *           Codigos duplicado (INSERT), Ordens duplicada (INSERT/UPDATE)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido, loc_cSQL, loc_nResultado
        loc_lValido = .T.

        IF EMPTY(THIS.this_cCodigos)
            MsgAviso("C" + CHR(243) + "digo Inv" + CHR(225) + "lido.")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cDescrs)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida.")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            *-- Verificar se Codigos ja existe para o mesmo nTipos
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCrRaP" + ;
                " WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos) + ;
                " AND nTipos = " + FormatarNumeroSQL(THIS.this_nTipos, 0)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCod")
                SELECT cursor_4c_ChkCod
                IF cursor_4c_ChkCod.qtd > 0
                    MsgAviso("Caracter" + CHR(237) + "stica j" + CHR(225) + " cadastrada!")
                    loc_lValido = .F.
                ENDIF
                USE IN cursor_4c_ChkCod
            ELSE
                MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND THIS.this_nOrdens > 0
            *-- Verificar se Ordem ja existe para diferente Codigos com mesmo nTipos
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCrRaP" + ;
                " WHERE Ordens = " + FormatarNumeroSQL(THIS.this_nOrdens, 0) + ;
                " AND Codigos <> " + EscaparSQL(THIS.this_cCodigos) + ;
                " AND nTipos = " + FormatarNumeroSQL(THIS.this_nTipos, 0)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkOrd")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkOrd")
                SELECT cursor_4c_ChkOrd
                IF cursor_4c_ChkOrd.qtd > 0
                    MsgAviso("Ordem da Caracter" + CHR(237) + "stica j" + CHR(225) + " cadastrada!")
                    loc_lValido = .F.
                ENDIF
                USE IN cursor_4c_ChkOrd
            ELSE
                MostrarErro("Erro ao verificar ordem:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigCrRaP
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Gerar cidchaves (substitui fUniqueIds do framework Fortyus)
            THIS.this_cCidchaves = LEFT(SYS(2015) + SYS(2015), 20)

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCrRaP (codigos, descrs, impetqs, ordens, ntipos, cgrus, cidchaves, chkobrig)
                VALUES (
                    <<EscaparSQL(THIS.this_cCodigos)>>,
                    <<EscaparSQL(THIS.this_cDescrs)>>,
                    <<FormatarNumeroSQL(THIS.this_nImpetqs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nOrdens, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nTipos, 0)>>,
                    <<EscaparSQL(THIS.this_cCgrus)>>,
                    <<EscaparSQL(THIS.this_cCidchaves)>>,
                    <<FormatarNumeroSQL(THIS.this_nChkobrig, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir caracter" + CHR(237) + "stica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "crpBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigCrRaP
    * Nao atualiza: codigos (PK), ntipos, cidchaves
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCrRaP
                SET descrs   = <<EscaparSQL(THIS.this_cDescrs)>>,
                    impetqs  = <<FormatarNumeroSQL(THIS.this_nImpetqs, 0)>>,
                    ordens   = <<FormatarNumeroSQL(THIS.this_nOrdens, 0)>>,
                    cgrus    = <<EscaparSQL(THIS.this_cCgrus)>>,
                    chkobrig = <<FormatarNumeroSQL(THIS.this_nChkobrig, 0)>>
                WHERE Codigos = <<EscaparSQL(THIS.this_cCodigos)>>
                  AND nTipos  = <<FormatarNumeroSQL(THIS.this_nTipos, 0)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar caracter" + CHR(237) + "stica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "crpBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigCrRaP
    * Para nTipos=0 (Produtos): verifica uso em sigprcar antes de excluir
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nUso
        loc_lSucesso = .F.

        TRY
            IF THIS.this_nTipos = 0
                *-- Verificar se caracteristica esta sendo usada em produtos
                loc_cSQL = "SELECT COUNT(*) AS qtd FROM sigprcar" + ;
                    " WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkPrCar")
                IF loc_nResultado >= 0 AND USED("cursor_4c_ChkPrCar")
                    SELECT cursor_4c_ChkPrCar
                    loc_nUso = cursor_4c_ChkPrCar.qtd
                    USE IN cursor_4c_ChkPrCar
                    IF loc_nUso > 0
                        MsgAviso("Caracter" + CHR(237) + "stica sendo utilizada em Produtos!")
                        loc_lSucesso = .F.
                    ELSE
                        loc_cSQL = "DELETE FROM SigCrRaP" + ;
                            " WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos) + ;
                            " AND nTipos = " + FormatarNumeroSQL(THIS.this_nTipos, 0)
                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nResultado >= 0
                            THIS.RegistrarAuditoria("DELETE")
                            loc_lSucesso = .T.
                        ELSE
                            MostrarErro("Erro ao excluir caracter" + CHR(237) + "stica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        ENDIF
                    ENDIF
                ELSE
                    MostrarErro("Erro ao verificar depend" + CHR(234) + "ncias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                *-- Contas (nTipos=1) e Movimentacoes (nTipos=2): excluir diretamente
                loc_cSQL = "DELETE FROM SigCrRaP" + ;
                    " WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos) + ;
                    " AND nTipos = " + FormatarNumeroSQL(THIS.this_nTipos, 0)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao excluir caracter" + CHR(237) + "stica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "crpBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com: codigos, descrs, cgrus, ordens, dgrus
    * Filtra por this_nTipos e usa JOIN condicional para descricao do grupo
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados ;
                        (codigos C(20), descrs C(40), cgrus C(3), ordens N(6,0), dgrus C(40))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                IF THIS.this_nTipos = 2
                    *-- Movimentacoes: JOIN com SigCdGpr (Codigos/Descs)
                    loc_cSQL = "SELECT a.Codigos, a.Descrs, a.Cgrus, a.Ordens," + ;
                        " ISNULL(b.Descs, '') AS Dgrus" + ;
                        " FROM SigCrRaP a" + ;
                        " LEFT JOIN SigCdGpr b ON a.Cgrus = b.Codigos" + ;
                        " WHERE a.nTipos = " + FormatarNumeroSQL(THIS.this_nTipos, 0)
                ELSE
                    *-- Produtos (0) e Contas (1): JOIN com SigCdGrp (Cgrus/Dgrus)
                    loc_cSQL = "SELECT a.Codigos, a.Descrs, a.Cgrus, a.Ordens," + ;
                        " ISNULL(b.Dgrus, '') AS Dgrus" + ;
                        " FROM SigCrRaP a" + ;
                        " LEFT JOIN SigCdGrp b ON a.Cgrus = b.Cgrus" + ;
                        " WHERE a.nTipos = " + FormatarNumeroSQL(THIS.this_nTipos, 0)
                ENDIF

                IF !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " AND " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY a.Ordens, a.Codigos"

                IF USED("cursor_4c_Dados")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT cursor_4c_Dados
                        ZAP
                        SET NULL ON
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        SET NULL OFF
                        USE IN cursor_4c_DadosTmp
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar caracter" + CHR(237) + "sticas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar caracter" + CHR(237) + "sticas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "crpBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave primaria
    * Faz JOIN condicional baseado em this_nTipos para obter dgrus
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF THIS.this_nTipos = 2
                *-- Movimentacoes: JOIN com SigCdGpr
                loc_cSQL = "SELECT a.codigos, a.descrs, a.impetqs, a.ordens, a.ntipos," + ;
                    " a.cgrus, a.cidchaves, a.chkobrig," + ;
                    " ISNULL(b.Descs, '') AS dgrus" + ;
                    " FROM SigCrRaP a" + ;
                    " LEFT JOIN SigCdGpr b ON a.Cgrus = b.Codigos" + ;
                    " WHERE a.Codigos = " + EscaparSQL(par_cCodigo) + ;
                    " AND a.nTipos = " + FormatarNumeroSQL(THIS.this_nTipos, 0)
            ELSE
                *-- Produtos e Contas: JOIN com SigCdGrp
                loc_cSQL = "SELECT a.codigos, a.descrs, a.impetqs, a.ordens, a.ntipos," + ;
                    " a.cgrus, a.cidchaves, a.chkobrig," + ;
                    " ISNULL(b.Dgrus, '') AS dgrus" + ;
                    " FROM SigCrRaP a" + ;
                    " LEFT JOIN SigCdGrp b ON a.Cgrus = b.Cgrus" + ;
                    " WHERE a.Codigos = " + EscaparSQL(par_cCodigo) + ;
                    " AND a.nTipos = " + FormatarNumeroSQL(THIS.this_nTipos, 0)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Caracter" + CHR(237) + "stica n" + CHR(227) + "o encontrada!")
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar caracter" + CHR(237) + "stica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "crpBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

