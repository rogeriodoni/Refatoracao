# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (10)
- [BINDEVENT-PARAMS] Handler 'NcaixaLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE NcaixaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'EmpresaLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE EmpresaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ModeloLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ModeloLostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'NumUsuLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE NumUsuLostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'CoosLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE CoosLostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'CROLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE CROLostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [LAYOUT-POSITION] Controle 'Optiongroup1' (parent: SIGCDFBI.Pagina.Dados): Top original=429 vs migrado 'obj_4c_Optiongroup1' Top=3 (diff=426px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup1' (parent: SIGCDFBI.Pagina.Dados): Left original=625 vs migrado 'obj_4c_Optiongroup1' Left=5 (diff=620px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup2' (parent: SIGCDFBI.Pagina.Dados): Top original=451 vs migrado 'obj_4c_Optiongroup2' Top=3 (diff=448px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup2' (parent: SIGCDFBI.Pagina.Dados): Left original=624 vs migrado 'obj_4c_Optiongroup2' Left=5 (diff=619px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormFBI.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2181 linhas total):

*-- Linhas 32 a 164:
32:     *====================================================================
33:     * Init - Inicializa o formulario
34:     *====================================================================
35:     PROCEDURE Init()
36:         LOCAL loc_lSucesso
37:         loc_lSucesso = .F.
38:         TRY
39:             loc_lSucesso = DODEFAULT()
40:         CATCH TO loc_oErro
41:             MostrarErro(loc_oErro, "FormFBI.Init")
42:         ENDTRY
43:         RETURN loc_lSucesso
44:     ENDPROC
45: 
46:     *====================================================================
47:     * InicializarForm - Configura estrutura completa do formulario
48:     * Chamado automaticamente pelo FormBase.Init()
49:     *====================================================================
50:     PROTECTED PROCEDURE InicializarForm()
51:         LOCAL loc_lSucesso
52:         loc_lSucesso = .F.
53: 
54:         TRY
55:             *-- Criar o Business Object
56:             THIS.this_oBusinessObject = CREATEOBJECT("FBIBO")
57: 
58:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
59:                 MostrarErro("Erro ao criar FBIBO", "FormFBI.InicializarForm")
60:                 loc_lSucesso = .F.
61:             ENDIF
62: 
63:             *-- Configurar estrutura do PageFrame
64:             THIS.ConfigurarPageFrame()
65: 
66:             *-- Configurar Page1 (Lista com Grid e Botoes CRUD)
67:             THIS.ConfigurarPaginaLista()
68: 
69:             *-- Configurar Page2 (Dados com Campos e Botoes Salvar/Cancelar)
70:             THIS.ConfigurarPaginaDados()
71: 
72:             *-- Carregar lista inicial (pula se estiver validando UI)
73:             IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
74:                 THIS.CarregarLista()
75:             ENDIF
76: 
77:             *-- Exibir Page1 (Lista) como pagina inicial
78:             THIS.pgf_4c_Paginas.Visible = .T.
79:             THIS.pgf_4c_Paginas.ActivePage = 1
80:             THIS.this_cModoAtual = "LISTA"
81: 
82:             loc_lSucesso = .T.
83: 
84:         CATCH TO loc_oErro
85:             MostrarErro(loc_oErro, "FormFBI.InicializarForm")
86:         ENDTRY
87: 
88:         RETURN loc_lSucesso
89:     ENDPROC
90: 
91:     *====================================================================
92:     * ConfigurarPageFrame - Cria o PageFrame com 2 paginas
93:     *====================================================================
94:     PROTECTED PROCEDURE ConfigurarPageFrame()
95:         *-- Adicionar PageFrame principal
96:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
97:         WITH THIS.pgf_4c_Paginas
98:             .PageCount  = 2
99:             .Top        = -29
100:             .Left       = 0
101:             .Width      = THIS.Width
102:             .Height     = THIS.Height + 29
103:             .Tabs       = .F.
104:             .Visible    = .T.
105: 
106:             *-- Cor de fundo das paginas
107:             .Page1.BackColor = RGB(100, 100, 100)
108:             .Page2.BackColor = RGB(100, 100, 100)
109: 
110:             *-- Imagem de fundo
111:             .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
112:             .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
113: 
114:             .Page1.Caption = "Lista"
115:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
116:             .Page2.Caption = "Dados"
117:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
118:         ENDWITH
119:     ENDPROC
120: 
121:     *====================================================================
122:     * ConfigurarPaginaLista - Configura Page1 com Grid e Botoes CRUD
123:     *====================================================================
124:     PROTECTED PROCEDURE ConfigurarPaginaLista()
125:         LOCAL loc_oPagina
126:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
127: 
128:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
129:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
130: 
131:         *-- Container cabecalho (cntSombra no legado)
132:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
133:         WITH loc_oPagina.cnt_4c_Cabecalho
134:             .Top         = 31
135:             .Left        = 0
136:             .Width       = THIS.Width
137:             .Height      = 80
138:             .BackColor   = RGB(100, 100, 100)
139:             .BorderWidth = 0
140:             .Visible     = .T.
141:         ENDWITH
142: 
143:         *-- Label sombra (efeito visual)
144:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
145:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
146:             .Top       = 15
147:             .Left      = 10
148:             .Width     = 769
149:             .Height    = 40
150:             .Caption   = "Cadastro de Fabrica" + CHR(231) + CHR(227) + "o"
151:             .FontName  = "Tahoma"
152:             .FontSize  = 16
153:             .FontBold  = .T.
154:             .ForeColor = RGB(0, 0, 0)
155:             .BackStyle = 0
156:             .AutoSize  = .F.
157:             .Visible   = .T.
158:         ENDWITH
159: 
160:         *-- Label titulo principal
161:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
162:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
163:             .Top       = 18
164:             .Left      = 10

*-- Linhas 209 a 507:
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
225:             .FontSize        = 8
226:             .FontBold        = .T.
227:             .FontItalic      = .T.
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
250:             .FontSize        = 8
251:             .FontBold        = .T.
252:             .FontItalic      = .T.
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
275:             .FontSize        = 8
276:             .FontBold        = .T.
277:             .FontItalic      = .T.
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
300:             .FontSize        = 8
301:             .FontBold        = .T.
302:             .FontItalic      = .T.
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
314:         *-- Container Encerrar (canonico: Left=917, Width=90)
315:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
316:         WITH loc_oPagina.cnt_4c_Saida
317:             .Top         = 29
318:             .Left        = 917
319:             .Width       = 90
320:             .Height      = 85
321:             .BackStyle   = 0
322:             .BorderWidth = 0
323:             .Visible     = .T.
324:         ENDWITH
325: 
326:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
327:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
328:             .Caption         = "Encerrar"
329:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
330:             .PicturePosition = 13
331:             .Top             = 5
332:             .Left            = 5
333:             .Width           = 75
334:             .Height          = 75
335:             .FontName        = "Comic Sans MS"
336:             .FontSize        = 8
337:             .FontBold        = .T.
338:             .FontItalic      = .T.
339:             .ForeColor       = RGB(90, 90, 90)
340:             .BackColor       = RGB(255, 255, 255)
341:             .Themes          = .F.
342:             .SpecialEffect   = 0
343:             .MousePointer    = 15
344:             .WordWrap        = .T.
345:             .AutoSize        = .F.
346:             .Visible         = .T.
347:         ENDWITH
348:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
349: 
350:         *-- Grid de lista
351:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
352:         WITH loc_oPagina.grd_4c_Lista
353:             .Top                  = 121
354:             .Left                 = 12
355:             .Width                = 890
356:             .Height               = 440
357:             .FontName             = "Verdana"
358:             .FontSize             = 8
359:             .ForeColor            = RGB(90, 90, 90)
360:             .BackColor            = RGB(255, 255, 255)
361:             .GridLineColor        = RGB(238, 238, 238)
362:             .HighlightBackColor   = RGB(255, 255, 255)
363:             .HighlightForeColor   = RGB(15, 41, 104)
364:             .HighlightStyle       = 2
365:             .DeleteMark           = .F.
366:             .RecordMark           = .F.
367:             .RowHeight            = 16
368:             .ScrollBars           = 2
369:             .GridLines            = 3
370:             .ColumnCount          = 4
371:             .Visible              = .T.
372:         ENDWITH
373: 
374:         *-- Configurar colunas do grid apos ColumnCount
375:         WITH loc_oPagina.grd_4c_Lista
376:             .Column1.Width              = 160
377:             .Column1.Header1.Caption    = "N" + CHR(186) + " Fabrica" + CHR(231) + CHR(227) + "o"
378:             .Column1.Alignment          = 0
379: 
380:             .Column2.Width              = 80
381:             .Column2.Header1.Caption    = "Empresa"
382:             .Column2.Alignment          = 0
383: 
384:             .Column3.Width              = 300
385:             .Column3.Header1.Caption    = "Fabrica" + CHR(231) + CHR(227) + "o (Criptografado)"
386:             .Column3.Alignment          = 0
387: 
388:             .Column4.Width              = 120
389:             .Column4.Header1.Caption    = "Caixa"
390:             .Column4.Alignment          = 0
391:         ENDWITH
392: 
393:         *-- Tornar controles visiveis
394:         THIS.TornarControlesVisiveis(loc_oPagina)
395:     ENDPROC
396: 
397:     *====================================================================
398:     * ConfigurarPaginaDados - Configura Page2 com campos e botoes
399:     *====================================================================
400:     PROTECTED PROCEDURE ConfigurarPaginaDados()
401:         LOCAL loc_oPagina
402:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
403: 
404:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
405:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
406: 
407:         *-- Container botoes Salvar/Cancelar (Grupo_Salva no legado)
408:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
409:         WITH loc_oPagina.cnt_4c_BotoesAcao
410:             .Top         = 33
411:             .Left        = 842
412:             .Width       = 160
413:             .Height      = 85
414:             .BackStyle   = 0
415:             .BorderWidth = 0
416:             .Visible     = .T.
417:         ENDWITH
418: 
419:         *-- Botao Confirmar (Salvar)
420:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
421:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
422:             .Caption         = "Confirmar"
423:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
424:             .PicturePosition = 13
425:             .Top             = 5
426:             .Left            = 5
427:             .Width           = 75
428:             .Height          = 75
429:             .FontName        = "Comic Sans MS"
430:             .FontSize        = 8
431:             .FontBold        = .T.
432:             .FontItalic      = .T.
433:             .ForeColor       = RGB(90, 90, 90)
434:             .BackColor       = RGB(255, 255, 255)
435:             .Themes          = .F.
436:             .SpecialEffect   = 0
437:             .MousePointer    = 15
438:             .WordWrap        = .T.
439:             .AutoSize        = .F.
440:             .Visible         = .T.
441:         ENDWITH
442:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
443: 
444:         *-- Botao Cancelar
445:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
446:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
447:             .Caption         = "Encerrar"
448:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
449:             .PicturePosition = 13
450:             .Top             = 5
451:             .Left            = 80
452:             .Width           = 75
453:             .Height          = 75
454:             .FontName        = "Comic Sans MS"
455:             .FontSize        = 8
456:             .FontBold        = .T.
457:             .FontItalic      = .T.
458:             .ForeColor       = RGB(90, 90, 90)
459:             .BackColor       = RGB(255, 255, 255)
460:             .Themes          = .F.
461:             .SpecialEffect   = 0
462:             .MousePointer    = 15
463:             .WordWrap        = .T.
464:             .AutoSize        = .F.
465:             .Visible         = .T.
466:         ENDWITH
467:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
468: 
469:         *-- === COLUNA ESQUERDA - Campos da Page2 (Fase 5: primeiros 50%) ===
470: 
471:         *-- NFAB - No. Fabricacao (chave de negocio, desabilitado no ALTERAR)
472:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
473:         WITH loc_oPagina.lbl_4c_Label1
474:             .Top       = 216
475:             .Left      = 137
476:             .Width     = 115
477:             .Height    = 17
478:             .Caption   = "N" + CHR(186) + " Fabrica" + CHR(231) + CHR(227) + "o - NFAB. :"
479:             .FontName  = "Tahoma"
480:             .FontSize  = 8
481:             .ForeColor = RGB(255, 255, 255)
482:             .BackStyle = 0
483:             .Alignment = 1
484:             .AutoSize  = .F.
485:             .Visible   = .T.
486:         ENDWITH
487: 
488:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
489:         WITH loc_oPagina.txt_4c_Codigo
490:             .Top       = 213
491:             .Left      = 256
492:             .Width     = 157
493:             .Height    = 23
494:             .Value     = ""
495:             .MaxLength = 20
496:             .FontName  = "Tahoma"
497:             .FontSize  = 8
498:             .BackColor = RGB(255, 255, 255)
499:             .ForeColor = RGB(0, 0, 0)
500:             .Visible   = .T.
501:         ENDWITH
502: 
503:         *-- NSEQ - No. do Caixa (obrigatorio 3 digitos)
504:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
505:         WITH loc_oPagina.lbl_4c_Label3
506:             .Top       = 241
507:             .Left      = 146

*-- Linhas 531 a 574:
531:             .ForeColor = RGB(0, 0, 0)
532:             .Visible   = .T.
533:         ENDWITH
534:         BINDEVENT(loc_oPagina.txt_4c_Ncaixa, "KeyPress", THIS, "NcaixaLostFocus")
535: 
536:         *-- Contador Reinicio de Operacao
537:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
538:         WITH loc_oPagina.lbl_4c_Label4
539:             .Top       = 265
540:             .Left      = 96
541:             .Width     = 158
542:             .Height    = 17
543:             .Caption   = "Contador Reinicio de Opera" + CHR(231) + CHR(227) + "o :"
544:             .FontName  = "Tahoma"
545:             .FontSize  = 8
546:             .ForeColor = RGB(255, 255, 255)
547:             .BackStyle = 0
548:             .Alignment = 1
549:             .AutoSize  = .F.
550:             .Visible   = .T.
551:         ENDWITH
552: 
553:         loc_oPagina.AddObject("txt_4c_Interv", "TextBox")
554:         WITH loc_oPagina.txt_4c_Interv
555:             .Top       = 262
556:             .Left      = 256
557:             .Width     = 38
558:             .Height    = 21
559:             .Value     = ""
560:             .MaxLength = 4
561:             .FontName  = "Tahoma"
562:             .FontSize  = 8
563:             .BackColor = RGB(255, 255, 255)
564:             .ForeColor = RGB(0, 0, 0)
565:             .Visible   = .T.
566:         ENDWITH
567: 
568:         *-- Empresa (lookup em SigCdEmp)
569:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
570:         WITH loc_oPagina.lbl_4c_Label5
571:             .Top       = 290
572:             .Left      = 204
573:             .Width     = 50
574:             .Height    = 17

*-- Linhas 596 a 640:
596:             .ForeColor = RGB(0, 0, 0)
597:             .Visible   = .T.
598:         ENDWITH
599:         BINDEVENT(loc_oPagina.txt_4c_Emp, "KeyPress", THIS, "EmpresaLostFocus")
600:         BINDEVENT(loc_oPagina.txt_4c_Emp, "KeyPress", THIS, "EmpresaKeyPress")
601: 
602:         *-- GT Inicial
603:         loc_oPagina.AddObject("lbl_4c_Label12", "Label")
604:         WITH loc_oPagina.lbl_4c_Label12
605:             .Top       = 314
606:             .Left      = 202
607:             .Width     = 52
608:             .Height    = 17
609:             .Caption   = "GT Inicial :"
610:             .FontName  = "Tahoma"
611:             .FontSize  = 8
612:             .ForeColor = RGB(255, 255, 255)
613:             .BackStyle = 0
614:             .Alignment = 1
615:             .AutoSize  = .F.
616:             .Visible   = .T.
617:         ENDWITH
618: 
619:         loc_oPagina.AddObject("txt_4c_GTInicial", "TextBox")
620:         WITH loc_oPagina.txt_4c_GTInicial
621:             .Top       = 311
622:             .Left      = 256
623:             .Width     = 175
624:             .Height    = 23
625:             .Value     = ""
626:             .MaxLength = 30
627:             .FontName  = "Tahoma"
628:             .FontSize  = 8
629:             .BackColor = RGB(255, 255, 255)
630:             .ForeColor = RGB(0, 0, 0)
631:             .Visible   = .T.
632:         ENDWITH
633: 
634:         *-- GT Atual
635:         loc_oPagina.AddObject("lbl_4c_Label30", "Label")
636:         WITH loc_oPagina.lbl_4c_Label30
637:             .Top       = 339
638:             .Left      = 204
639:             .Width     = 50
640:             .Height    = 17

*-- Linhas 694 a 773:
694:             .ForeColor = RGB(0, 0, 0)
695:             .Visible   = .T.
696:         ENDWITH
697:         BINDEVENT(loc_oPagina.txt_4c_Modelo, "KeyPress", THIS, "ModeloLostFocus")
698:         BINDEVENT(loc_oPagina.txt_4c_Modelo, "KeyPress", THIS, "ModeloKeyPress")
699: 
700:         *-- Numero do Usuario do ECF
701:         loc_oPagina.AddObject("lbl_4c_Label17", "Label")
702:         WITH loc_oPagina.lbl_4c_Label17
703:             .Top       = 390
704:             .Left      = 114
705:             .Width     = 140
706:             .Height    = 17
707:             .Caption   = "Numero do Usu" + CHR(225) + "rio do ECF :"
708:             .FontName  = "Tahoma"
709:             .FontSize  = 8
710:             .ForeColor = RGB(255, 255, 255)
711:             .BackStyle = 0
712:             .Alignment = 1
713:             .AutoSize  = .F.
714:             .Visible   = .T.
715:         ENDWITH
716: 
717:         loc_oPagina.AddObject("txt_4c_NumUsu", "TextBox")
718:         WITH loc_oPagina.txt_4c_NumUsu
719:             .Top       = 386
720:             .Left      = 256
721:             .Width     = 25
722:             .Height    = 21
723:             .Value     = ""
724:             .MaxLength = 2
725:             .InputMask = "99"
726:             .FontName  = "Tahoma"
727:             .FontSize  = 8
728:             .BackColor = RGB(255, 255, 255)
729:             .ForeColor = RGB(0, 0, 0)
730:             .Visible   = .T.
731:         ENDWITH
732:         BINDEVENT(loc_oPagina.txt_4c_NumUsu, "GotFocus", THIS, "NumUsuGotFocus")
733:         BINDEVENT(loc_oPagina.txt_4c_NumUsu, "KeyPress", THIS, "NumUsuLostFocus")
734: 
735:         *-- Tipo do ECF
736:         loc_oPagina.AddObject("lbl_4c_Label18", "Label")
737:         WITH loc_oPagina.lbl_4c_Label18
738:             .Top       = 414
739:             .Left      = 188
740:             .Width     = 66
741:             .Height    = 17
742:             .Caption   = "Tipo do ECF :"
743:             .FontName  = "Tahoma"
744:             .FontSize  = 8
745:             .ForeColor = RGB(255, 255, 255)
746:             .BackStyle = 0
747:             .Alignment = 1
748:             .AutoSize  = .F.
749:             .Visible   = .T.
750:         ENDWITH
751: 
752:         loc_oPagina.AddObject("txt_4c_TipoECF", "TextBox")
753:         WITH loc_oPagina.txt_4c_TipoECF
754:             .Top       = 410
755:             .Left      = 256
756:             .Width     = 59
757:             .Height    = 23
758:             .Value     = ""
759:             .MaxLength = 7
760:             .FontName  = "Tahoma"
761:             .FontSize  = 8
762:             .BackColor = RGB(255, 255, 255)
763:             .ForeColor = RGB(0, 0, 0)
764:             .Visible   = .T.
765:         ENDWITH
766: 
767:         *-- Versao do Software Basico
768:         loc_oPagina.AddObject("lbl_4c_Label19", "Label")
769:         WITH loc_oPagina.lbl_4c_Label19
770:             .Top       = 437
771:             .Left      = 121
772:             .Width     = 133
773:             .Height    = 17

*-- Linhas 924 a 967:
924:             .ForeColor = RGB(0, 0, 0)
925:             .Visible   = .T.
926:         ENDWITH
927:         BINDEVENT(loc_oPagina.txt_4c_Coos, "KeyPress", THIS, "CoosLostFocus")
928: 
929:         *-- === COLUNA DIREITA - primeiros campos (Fase 5) ===
930: 
931:         *-- Data do Cadastro do ECF
932:         loc_oPagina.AddObject("lbl_4c_Label23", "Label")
933:         WITH loc_oPagina.lbl_4c_Label23
934:             .Top       = 216
935:             .Left      = 497
936:             .Width     = 131
937:             .Height    = 17
938:             .Caption   = "Data do Cadastro do ECF :"
939:             .FontName  = "Tahoma"
940:             .FontSize  = 8
941:             .ForeColor = RGB(255, 255, 255)
942:             .BackStyle = 0
943:             .Alignment = 1
944:             .AutoSize  = .F.
945:             .Visible   = .T.
946:         ENDWITH
947: 
948:         loc_oPagina.AddObject("txt_4c_DtCad", "TextBox")
949:         WITH loc_oPagina.txt_4c_DtCad
950:             .Top       = 213
951:             .Left      = 630
952:             .Width     = 80
953:             .Height    = 21
954:             .Value     = {}
955:             .Format    = "D"
956:             .FontName  = "Tahoma"
957:             .FontSize  = 8
958:             .BackColor = RGB(255, 255, 255)
959:             .ForeColor = RGB(0, 0, 0)
960:             .Visible   = .T.
961:         ENDWITH
962: 
963:         *-- === COLUNA DIREITA - campos restantes (Fase 6) ===
964: 
965:         *-- Hora do Cadastro do ECF
966:         loc_oPagina.AddObject("lbl_4c_Label24", "Label")
967:         WITH loc_oPagina.lbl_4c_Label24

*-- Linhas 1028 a 1071:
1028:             .ForeColor = RGB(0, 0, 0)
1029:             .Visible   = .T.
1030:         ENDWITH
1031:         BINDEVENT(loc_oPagina.txt_4c_CRO, "KeyPress", THIS, "CROLostFocus")
1032: 
1033:         *-- Leitura Mem. Fiscal Automatico
1034:         loc_oPagina.AddObject("lbl_4c_Label13", "Label")
1035:         WITH loc_oPagina.lbl_4c_Label13
1036:             .Top       = 285
1037:             .Left      = 468
1038:             .Width     = 160
1039:             .Height    = 17
1040:             .Caption   = "Leitura Mem. Fiscal Autom" + CHR(225) + "tico :"
1041:             .FontName  = "Tahoma"
1042:             .FontSize  = 8
1043:             .ForeColor = RGB(255, 255, 255)
1044:             .BackStyle = 0
1045:             .Alignment = 1
1046:             .AutoSize  = .F.
1047:             .Visible   = .T.
1048:         ENDWITH
1049: 
1050:         loc_oPagina.AddObject("chk_4c_Chk_LeitMF", "CheckBox")
1051:         WITH loc_oPagina.chk_4c_Chk_LeitMF
1052:             .Top       = 285
1053:             .Left      = 630
1054:             .Width     = 18
1055:             .Height    = 17
1056:             .Caption   = ""
1057:             .Value     = 0
1058:             .Alignment = 0
1059:             .BackStyle = 0
1060:             .AutoSize  = .T.
1061:             .Visible   = .T.
1062:         ENDWITH
1063: 
1064:         *-- Gaveta Acoplada
1065:         loc_oPagina.AddObject("lbl_4c_Label7", "Label")
1066:         WITH loc_oPagina.lbl_4c_Label7
1067:             .Top       = 304
1068:             .Left      = 534
1069:             .Width     = 94
1070:             .Height    = 17
1071:             .Caption   = "Gaveta Acoplada :"

*-- Linhas 1309 a 1422:
1309:             .Visible   = .T.
1310:         ENDWITH
1311: 
1312:         *-- Autentica (OptionGroup 1=Sim, 2=Nao)
1313:         loc_oPagina.AddObject("lbl_4c_Label14", "Label")
1314:         WITH loc_oPagina.lbl_4c_Label14
1315:             .Top       = 461
1316:             .Left      = 573
1317:             .Width     = 55
1318:             .Height    = 17
1319:             .Caption   = "Autentica :"
1320:             .FontName  = "Tahoma"
1321:             .FontSize  = 8
1322:             .ForeColor = RGB(255, 255, 255)
1323:             .BackStyle = 0
1324:             .Alignment = 1
1325:             .AutoSize  = .F.
1326:             .Visible   = .T.
1327:         ENDWITH
1328: 
1329:         loc_oPagina.AddObject("obj_4c_Optiongroup1", "OptionGroup")
1330:         WITH loc_oPagina.obj_4c_Optiongroup1
1331:             .ButtonCount = 2
1332:             .BackStyle   = 0
1333:             .BorderStyle = 0
1334:             .Value       = 1
1335:             .Top         = 458
1336:             .Left        = 625
1337:             .Width       = 95
1338:             .Height      = 22
1339:             .Visible     = .T.
1340:             WITH .Buttons(1)
1341:                 .Caption   = "Sim"
1342:                 .Left      = 5
1343:                 .Top       = 3
1344:                 .Width     = 44
1345:                 .Height    = 17
1346:                 .AutoSize  = .T.
1347:                 .ForeColor = RGB(90, 90, 90)
1348:                 .BackStyle = 0
1349:             ENDWITH
1350:             WITH .Buttons(2)
1351:                 .Caption   = "N" + CHR(227) + "o"
1352:                 .Left      = 56
1353:                 .Top       = 3
1354:                 .Width     = 61
1355:                 .Height    = 17
1356:                 .AutoSize  = .T.
1357:                 .FontName  = "Tahoma"
1358:                 .FontSize  = 8
1359:                 .ForeColor = RGB(90, 90, 90)
1360:                 .BackStyle = 0
1361:             ENDWITH
1362:         ENDWITH
1363: 
1364:         *-- Imprime Codigo de Barras (OptionGroup 1=Sim, 2=Nao)
1365:         loc_oPagina.AddObject("lbl_4c_Label26", "Label")
1366:         WITH loc_oPagina.lbl_4c_Label26
1367:             .Top       = 483
1368:             .Left      = 496
1369:             .Width     = 132
1370:             .Height    = 17
1371:             .Caption   = "Imprime C" + CHR(243) + "digo de Barras :"
1372:             .FontName  = "Tahoma"
1373:             .FontSize  = 8
1374:             .ForeColor = RGB(255, 255, 255)
1375:             .BackStyle = 0
1376:             .Alignment = 1
1377:             .AutoSize  = .F.
1378:             .Visible   = .T.
1379:         ENDWITH
1380: 
1381:         loc_oPagina.AddObject("obj_4c_Optiongroup2", "OptionGroup")
1382:         WITH loc_oPagina.obj_4c_Optiongroup2
1383:             .ButtonCount = 2
1384:             .BackStyle   = 0
1385:             .BorderStyle = 0
1386:             .Value       = 1
1387:             .Top         = 480
1388:             .Left        = 624
1389:             .Width       = 95
1390:             .Height      = 22
1391:             .Visible     = .T.
1392:             WITH .Buttons(1)
1393:                 .Caption   = "Sim"
1394:                 .Left      = 5
1395:                 .Top       = 3
1396:                 .Width     = 44
1397:                 .Height    = 17
1398:                 .AutoSize  = .T.
1399:                 .ForeColor = RGB(90, 90, 90)
1400:                 .BackStyle = 0
1401:             ENDWITH
1402:             WITH .Buttons(2)
1403:                 .Caption   = "N" + CHR(227) + "o"
1404:                 .Left      = 56
1405:                 .Top       = 3
1406:                 .Width     = 61
1407:                 .Height    = 17
1408:                 .AutoSize  = .T.
1409:                 .FontName  = "Tahoma"
1410:                 .FontSize  = 8
1411:                 .ForeColor = RGB(90, 90, 90)
1412:                 .BackStyle = 0
1413:             ENDWITH
1414:         ENDWITH
1415: 
1416:         *-- Codigo Nacional do ECF (ReadOnly - getcodnac.When = .F. no legado)
1417:         loc_oPagina.AddObject("lbl_4c_Label28", "Label")
1418:         WITH loc_oPagina.lbl_4c_Label28
1419:             .Top       = 509
1420:             .Left      = 506
1421:             .Width     = 122
1422:             .Height    = 17

*-- Linhas 1480 a 2181:
1480:         ENDWITH
1481: 
1482:         *-- Tornar controles visiveis
1483:         THIS.TornarControlesVisiveis(loc_oPagina)
1484:     ENDPROC
1485: 
1486:     *====================================================================
1487:     * CarregarLista - Carrega dados no Grid da Page1
1488:     *====================================================================
1489:     PROCEDURE CarregarLista()
1490:         LOCAL loc_lResultado, loc_oGrid
1491:         loc_lResultado = .F.
1492: 
1493:         TRY
1494:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1495:                 loc_lResultado = .T.
1496:             ELSE
1497:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1498: 
1499:                 IF THIS.this_oBusinessObject.Buscar("")
1500:                     loc_oGrid.ColumnCount = 4
1501:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
1502:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cImpFabs"
1503:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.emps"
1504:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.cImpFabs"
1505:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.cncaixas"
1506: 
1507:                     *-- Redefinir headers apos RecordSource (VFP9 reseta cabecalhos)
1508:                     loc_oGrid.Column1.Header1.Caption = "N" + CHR(186) + " Fabrica" + CHR(231) + CHR(227) + "o"
1509:                     loc_oGrid.Column2.Header1.Caption = "Empresa"
1510:                     loc_oGrid.Column3.Header1.Caption = "Fabrica" + CHR(231) + CHR(227) + "o (Criptografado)"
1511:                     loc_oGrid.Column4.Header1.Caption = "Caixa"
1512: 
1513:                     THIS.FormatarGridLista(loc_oGrid)
1514:                     loc_lResultado = .T.
1515:                 ENDIF
1516:             ENDIF
1517:         CATCH TO loc_oErro
1518:             MostrarErro(loc_oErro, "FormFBI.CarregarLista")
1519:         ENDTRY
1520: 
1521:         RETURN loc_lResultado
1522:     ENDPROC
1523: 
1524:     *====================================================================
1525:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
1526:     *====================================================================
1527:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
1528:         LOCAL loc_lResultado
1529:         loc_lResultado = .F.
1530: 
1531:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
1532:             RETURN .F.
1533:         ENDIF
1534: 
1535:         THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1536: 
1537:         IF par_nPagina = 1
1538:             THIS.CarregarLista()
1539:         ENDIF
1540: 
1541:         loc_lResultado = .T.
1542:         RETURN loc_lResultado
1543:     ENDPROC
1544: 
1545:     *====================================================================
1546:     * FormatarGridLista - Formata visual do grid da lista
1547:     *====================================================================
1548:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1549:         WITH par_oGrid
1550:             .FontName = "Verdana"
1551:             .FontSize = 8
1552:         ENDWITH
1553:     ENDPROC
1554: 
1555:     *====================================================================
1556:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
1557:     *====================================================================
1558:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1559:         LOCAL loc_nI, loc_oObjeto, loc_nP
1560: 
1561:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1562:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1563: 
1564:             IF VARTYPE(loc_oObjeto) = "O"
1565:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1566:                     loc_oObjeto.Visible = .T.
1567:                 ENDIF
1568: 
1569:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1570:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1571:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1572:                     ENDFOR
1573:                 ENDIF
1574: 
1575:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1576:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1577:                 ENDIF
1578:             ENDIF
1579:         ENDFOR
1580:     ENDPROC
1581: 
1582:     *====================================================================
1583:     * Destroy - Libera recursos
1584:     *====================================================================
1585:     PROCEDURE Destroy()
1586:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1587:             THIS.this_oBusinessObject = .NULL.
1588:         ENDIF
1589:         DODEFAULT()
1590:     ENDPROC
1591: 
1592:     *====================================================================
1593:     * NcaixaLostFocus - Valida 3 digitos obrigatorios no Nr. Caixa
1594:     * Legado: Get_ncaixa.Click
1595:     *====================================================================
1596:     PROCEDURE NcaixaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1597:         LOCAL loc_oPg2, loc_cValor
1598:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1599:         loc_cValor = ALLTRIM(loc_oPg2.txt_4c_Ncaixa.Value)
1600:         IF !EMPTY(loc_cValor) AND LEN(loc_cValor) < 3
1601:             MsgAviso("Obrigatorio Preenchimento de 3 d" + CHR(237) + "gitos")
1602:             loc_oPg2.txt_4c_Ncaixa.SetFocus()
1603:         ENDIF
1604:     ENDPROC
1605: 
1606:     *====================================================================
1607:     * EmpresaLostFocus - Lookup de empresa (SigCdEmp) ao sair do campo
1608:     * Legado: Get_Emp.Valid - fwBuscaExt em SigCdEmp
1609:     *====================================================================
1610:     PROCEDURE EmpresaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1611:         LOCAL loc_oPg2, loc_cEmpresa, loc_oBusca
1612:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1613:         loc_cEmpresa = ALLTRIM(loc_oPg2.txt_4c_Emp.Value)
1614: 
1615:         IF EMPTY(loc_cEmpresa)
1616:             RETURN
1617:         ENDIF
1618: 
1619:         TRY
1620:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1621:                 "SigCdEmp", "cursor_4c_BuscaEmp", "CEmps", loc_cEmpresa, ;
1622:                 "Empresas")
1623: 
1624:             IF VARTYPE(loc_oBusca) = "O"
1625:                 IF loc_oBusca.this_lAchouRegistro AND loc_oBusca.this_lSelecionou
1626:                     IF USED("cursor_4c_BuscaEmp")
1627:                         loc_oPg2.txt_4c_Emp.Value = ALLTRIM(cursor_4c_BuscaEmp.CEmps)
1628:                     ENDIF
1629:                 ELSE
1630:                     IF !loc_oBusca.this_lAchouRegistro
1631:                     loc_oBusca.mAddColuna("CEmps", "", "C" + CHR(243) + "digo")
1632:                     loc_oBusca.mAddColuna("Razas", "", "Descri" + CHR(231) + CHR(227) + "o")
1633:                     loc_oBusca.Show()
1634:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
1635:                         loc_oPg2.txt_4c_Emp.Value = ALLTRIM(cursor_4c_BuscaEmp.CEmps)
1636:                     ENDIF
1637:                     ENDIF
1638:                 ENDIF
1639:                 loc_oBusca.Release()
1640:             ENDIF
1641:         CATCH TO loc_oErro
1642:             MostrarErro(loc_oErro, "FormFBI.EmpresaLostFocus")
1643:         ENDTRY
1644: 
1645:         IF USED("cursor_4c_BuscaEmp")
1646:             USE IN cursor_4c_BuscaEmp
1647:         ENDIF
1648:     ENDPROC
1649: 
1650:     *====================================================================
1651:     * EmpresaKeyPress - Abre lookup de empresa com F4
1652:     *====================================================================
1653:     PROCEDURE EmpresaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1654:         IF par_nKeyCode = 115
1655:             THIS.EmpresaLostFocus()
1656:         ENDIF
1657:     ENDPROC
1658: 
1659:     *====================================================================
1660:     * ModeloLostFocus - Lookup de modelo ECF (SigFiMpM) ao sair do campo
1661:     * Legado: GetModelo.Valid - fwBuscaExt em SigFiMpM (cModelos, cMarcas, cversbs, cidecfs)
1662:     *====================================================================
1663:     PROCEDURE ModeloLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1664:         LOCAL loc_oPg2, loc_cModelo, loc_oBusca
1665:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1666:         loc_cModelo = ALLTRIM(loc_oPg2.txt_4c_Modelo.Value)
1667: 
1668:         IF EMPTY(loc_cModelo)
1669:             RETURN
1670:         ENDIF
1671: 
1672:         TRY
1673:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1674:                 "SigFiMpM", "cursor_4c_BuscaModelo", "cModelos", loc_cModelo, ;
1675:                 "Modelos")
1676: 
1677:             IF VARTYPE(loc_oBusca) = "O"
1678:                 IF loc_oBusca.this_lAchouRegistro AND loc_oBusca.this_lSelecionou
1679:                     IF USED("cursor_4c_BuscaModelo")
1680:                         loc_oPg2.txt_4c_Modelo.Value = ALLTRIM(cursor_4c_BuscaModelo.cModelos)
1681:                         loc_oPg2.txt_4c_Codnac.Value = ALLTRIM(cursor_4c_BuscaModelo.cidecfs)
1682:                     ENDIF
1683:                 ELSE
1684:                     IF !loc_oBusca.this_lAchouRegistro
1685:                     loc_oBusca.mAddColuna("cModelos", "", "Modelo")
1686:                     loc_oBusca.mAddColuna("cMarcas",  "", "Marca")
1687:                     loc_oBusca.mAddColuna("cversbs",  "", "Vers" + CHR(227) + "o S.B.")
1688:                     loc_oBusca.mAddColuna("cidecfs",  "", "Cod.Nac.ECF")
1689:                     loc_oBusca.Show()
1690:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaModelo")
1691:                         loc_oPg2.txt_4c_Modelo.Value = ALLTRIM(cursor_4c_BuscaModelo.cModelos)
1692:                         loc_oPg2.txt_4c_Codnac.Value = ALLTRIM(cursor_4c_BuscaModelo.cidecfs)
1693:                     ENDIF
1694:                     ENDIF
1695:                 ENDIF
1696:                 loc_oBusca.Release()
1697:             ENDIF
1698:         CATCH TO loc_oErro
1699:             MostrarErro(loc_oErro, "FormFBI.ModeloLostFocus")
1700:         ENDTRY
1701: 
1702:         IF USED("cursor_4c_BuscaModelo")
1703:             USE IN cursor_4c_BuscaModelo
1704:         ENDIF
1705:     ENDPROC
1706: 
1707:     *====================================================================
1708:     * ModeloKeyPress - Abre lookup de modelo com F4 ou F5
1709:     *====================================================================
1710:     PROCEDURE ModeloKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1711:         IF par_nKeyCode = 115 OR par_nKeyCode = 64
1712:             THIS.ModeloLostFocus()
1713:         ENDIF
1714:     ENDPROC
1715: 
1716:     *====================================================================
1717:     * NumUsuGotFocus - Valida que Modelo foi preenchido antes de NumUsu
1718:     * Legado: GetNumUsu.GotFocus
1719:     *====================================================================
1720:     PROCEDURE NumUsuGotFocus()
1721:         LOCAL loc_oPg2
1722:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1723:         IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Modelo.Value))
1724:             MsgAviso("Obrigatorio Preenchimento")
1725:             loc_oPg2.txt_4c_Modelo.SetFocus()
1726:         ENDIF
1727:     ENDPROC
1728: 
1729:     *====================================================================
1730:     * NumUsuLostFocus - Formata numero do usuario com mascara @L 99
1731:     * Legado: GetNumUsu.LostFocus - TRANSFORM(Val(This.Value), '@L 99')
1732:     *====================================================================
1733:     PROCEDURE NumUsuLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1734:         LOCAL loc_oPg2, loc_cValor
1735:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1736:         loc_cValor = loc_oPg2.txt_4c_NumUsu.Value
1737:         IF !EMPTY(ALLTRIM(loc_cValor))
1738:             loc_oPg2.txt_4c_NumUsu.Value = TRANSFORM(VAL(loc_cValor), "@L 99")
1739:         ENDIF
1740:     ENDPROC
1741: 
1742:     *====================================================================
1743:     * CoosLostFocus - Formata COO Inicial com mascara @L 999999
1744:     * Legado: GetCoos.LostFocus - TRANSFORM(Val(This.Value), '@L 999999')
1745:     *====================================================================
1746:     PROCEDURE CoosLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1747:         LOCAL loc_oPg2, loc_cValor
1748:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1749:         loc_cValor = loc_oPg2.txt_4c_Coos.Value
1750:         IF !EMPTY(ALLTRIM(loc_cValor))
1751:             loc_oPg2.txt_4c_Coos.Value = TRANSFORM(VAL(loc_cValor), "@L 999999")
1752:         ENDIF
1753:     ENDPROC
1754: 
1755:     *====================================================================
1756:     * CROLostFocus - Formata CRO Inicial com mascara @L 999999
1757:     * Legado: GetCroniop.LostFocus - TRANSFORM(Val(This.Value), '@L 999999')
1758:     *====================================================================
1759:     PROCEDURE CROLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1760:         LOCAL loc_oPg2, loc_cValor
1761:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1762:         loc_cValor = loc_oPg2.txt_4c_CRO.Value
1763:         IF !EMPTY(ALLTRIM(loc_cValor))
1764:             loc_oPg2.txt_4c_CRO.Value = TRANSFORM(VAL(loc_cValor), "@L 999999")
1765:         ENDIF
1766:     ENDPROC
1767: 
1768:     *====================================================================
1769:     * FormParaBO - Transfere valores dos controles do form para o BO
1770:     *====================================================================
1771:     PROTECTED PROCEDURE FormParaBO()
1772:         LOCAL loc_lResultado, loc_oPg2, loc_oBO
1773:         loc_lResultado = .F.
1774: 
1775:         TRY
1776:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1777:             loc_oBO  = THIS.this_oBusinessObject
1778: 
1779:             loc_oBO.this_cCodigo    = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
1780:             loc_oBO.this_cNcaixas   = ALLTRIM(loc_oPg2.txt_4c_Ncaixa.Value)
1781:             loc_oBO.this_cInterv    = ALLTRIM(loc_oPg2.txt_4c_Interv.Value)
1782:             loc_oBO.this_cEmpresa   = ALLTRIM(loc_oPg2.txt_4c_Emp.Value)
1783:             loc_oBO.this_cGTInics   = ALLTRIM(loc_oPg2.txt_4c_GTInicial.Value)
1784:             loc_oBO.this_cGTAtuas   = ALLTRIM(loc_oPg2.txt_4c_Gtatual.Value)
1785:             loc_oBO.this_cModelo    = ALLTRIM(loc_oPg2.txt_4c_Modelo.Value)
1786:             loc_oBO.this_cNumUsuars = ALLTRIM(loc_oPg2.txt_4c_NumUsu.Value)
1787:             loc_oBO.this_cTipoECF   = ALLTRIM(loc_oPg2.txt_4c_TipoECF.Value)
1788:             loc_oBO.this_cVersaoSB  = ALLTRIM(loc_oPg2.txt_4c_VerSB.Value)
1789:             loc_oBO.this_dDataSB    = loc_oPg2.txt_4c_DataSB.Value
1790:             loc_oBO.this_cHoraSB    = ALLTRIM(loc_oPg2.txt_4c_HoraSB.Value)
1791:             loc_oBO.this_cCmdRFD    = ALLTRIM(loc_oPg2.txt_4c_CmdRFD.Value)
1792:             loc_oBO.this_cIfCoos    = ALLTRIM(loc_oPg2.txt_4c_Coos.Value)
1793:             loc_oBO.this_dDtCadECF  = loc_oPg2.txt_4c_DtCad.Value
1794:             loc_oBO.this_cHrCadECF  = ALLTRIM(loc_oPg2.txt_4c_HrCad.Value)
1795:             loc_oBO.this_cCROIniOps = ALLTRIM(loc_oPg2.txt_4c_CRO.Value)
1796:             loc_oBO.this_cCodNac    = ALLTRIM(loc_oPg2.txt_4c_Codnac.Value)
1797:             loc_oBO.this_lLeitMF    = (loc_oPg2.chk_4c_Chk_LeitMF.Value  = 1)
1798:             loc_oBO.this_lGaveta    = (loc_oPg2.chk_4c_Chk_gaveta.Value  = 1)
1799:             loc_oBO.this_lImpCheque = (loc_oPg2.chk_4c_Chk_impche.Value  = 1)
1800:             loc_oBO.this_lMFD       = (loc_oPg2.chk_4c_Fwcheckbox2.Value = 1)
1801:             loc_oBO.this_lInativa   = (loc_oPg2.chk_4c_Fwcheckbox1.Value = 1)
1802:             loc_oBO.this_lBomPara   = (loc_oPg2.chk_4c_Chk_Bompara.Value = 1)
1803:             loc_oBO.this_lNominal   = (loc_oPg2.chk_4c_Chk_nominal.Value = 1)
1804:             loc_oBO.this_lCruzado   = (loc_oPg2.chk_4c_Chk_cruzado.Value = 1)
1805:             loc_oBO.this_lPerto     = (loc_oPg2.chk_4c_Chk_perto.Value   = 1)
1806:             loc_oBO.this_nAutentica = loc_oPg2.obj_4c_Optiongroup1.Value
1807:             loc_oBO.this_nImpBars   = loc_oPg2.obj_4c_Optiongroup2.Value
1808:             loc_oBO.this_lISSQN     = (loc_oPg2.chk_4c_Fwcheckbox3.Value = 1)
1809: 
1810:             loc_lResultado = .T.
1811:         CATCH TO loc_oErro
1812:             MostrarErro(loc_oErro, "FormFBI.FormParaBO")
1813:         ENDTRY
1814: 
1815:         RETURN loc_lResultado
1816:     ENDPROC
1817: 
1818:     *====================================================================
1819:     * BOParaForm - Transfere valores do BO para os controles do form
1820:     *====================================================================
1821:     PROTECTED PROCEDURE BOParaForm()
1822:         LOCAL loc_lResultado, loc_oPg2, loc_oBO
1823:         loc_lResultado = .F.
1824: 
1825:         TRY
1826:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1827:             loc_oBO  = THIS.this_oBusinessObject
1828: 
1829:             loc_oPg2.txt_4c_Codigo.Value       = loc_oBO.this_cCodigo
1830:             loc_oPg2.txt_4c_Ncaixa.Value       = loc_oBO.this_cNcaixas
1831:             loc_oPg2.txt_4c_Interv.Value       = loc_oBO.this_cInterv
1832:             loc_oPg2.txt_4c_Emp.Value          = loc_oBO.this_cEmpresa
1833:             loc_oPg2.txt_4c_GTInicial.Value    = loc_oBO.this_cGTInics
1834:             loc_oPg2.txt_4c_Gtatual.Value      = loc_oBO.this_cGTAtuas
1835:             loc_oPg2.txt_4c_Modelo.Value       = loc_oBO.this_cModelo
1836:             loc_oPg2.txt_4c_NumUsu.Value       = loc_oBO.this_cNumUsuars
1837:             loc_oPg2.txt_4c_TipoECF.Value      = loc_oBO.this_cTipoECF
1838:             loc_oPg2.txt_4c_VerSB.Value        = loc_oBO.this_cVersaoSB
1839:             loc_oPg2.txt_4c_DataSB.Value       = loc_oBO.this_dDataSB
1840:             loc_oPg2.txt_4c_HoraSB.Value       = loc_oBO.this_cHoraSB
1841:             loc_oPg2.txt_4c_CmdRFD.Value       = loc_oBO.this_cCmdRFD
1842:             loc_oPg2.txt_4c_Coos.Value         = loc_oBO.this_cIfCoos
1843:             loc_oPg2.txt_4c_DtCad.Value        = loc_oBO.this_dDtCadECF
1844:             loc_oPg2.txt_4c_HrCad.Value        = loc_oBO.this_cHrCadECF
1845:             loc_oPg2.txt_4c_CRO.Value          = loc_oBO.this_cCROIniOps
1846:             loc_oPg2.txt_4c_Codnac.Value       = loc_oBO.this_cCodNac
1847:             loc_oPg2.chk_4c_Chk_LeitMF.Value  = IIF(loc_oBO.this_lLeitMF,    1, 0)
1848:             loc_oPg2.chk_4c_Chk_gaveta.Value  = IIF(loc_oBO.this_lGaveta,    1, 0)
1849:             loc_oPg2.chk_4c_Chk_impche.Value  = IIF(loc_oBO.this_lImpCheque, 1, 0)
1850:             loc_oPg2.chk_4c_Fwcheckbox2.Value = IIF(loc_oBO.this_lMFD,       1, 0)
1851:             loc_oPg2.chk_4c_Fwcheckbox1.Value = IIF(loc_oBO.this_lInativa,   1, 0)
1852:             loc_oPg2.chk_4c_Chk_Bompara.Value = IIF(loc_oBO.this_lBomPara,   1, 0)
1853:             loc_oPg2.chk_4c_Chk_nominal.Value = IIF(loc_oBO.this_lNominal,   1, 0)
1854:             loc_oPg2.chk_4c_Chk_cruzado.Value = IIF(loc_oBO.this_lCruzado,   1, 0)
1855:             loc_oPg2.chk_4c_Chk_perto.Value   = IIF(loc_oBO.this_lPerto,     1, 0)
1856:             loc_oPg2.obj_4c_Optiongroup1.Value = loc_oBO.this_nAutentica
1857:             loc_oPg2.obj_4c_Optiongroup2.Value = loc_oBO.this_nImpBars
1858:             loc_oPg2.chk_4c_Fwcheckbox3.Value = IIF(loc_oBO.this_lISSQN,     1, 0)
1859: 
1860:             loc_lResultado = .T.
1861:         CATCH TO loc_oErro
1862:             MostrarErro(loc_oErro, "FormFBI.BOParaForm")
1863:         ENDTRY
1864: 
1865:         RETURN loc_lResultado
1866:     ENDPROC
1867: 
1868:     *====================================================================
1869:     * HabilitarCampos - Habilita/desabilita campos conforme modo
1870:     * par_lHabilitar=.T. -> campos editaveis; .F. -> somente leitura
1871:     *====================================================================
1872:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1873:         LOCAL loc_lResultado, loc_oPg2
1874:         loc_lResultado = .F.
1875: 
1876:         TRY
1877:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1878: 
1879:             loc_oPg2.txt_4c_Ncaixa.ReadOnly    = !par_lHabilitar
1880:             loc_oPg2.txt_4c_Interv.ReadOnly    = !par_lHabilitar
1881:             loc_oPg2.txt_4c_Emp.ReadOnly       = !par_lHabilitar
1882:             loc_oPg2.txt_4c_GTInicial.ReadOnly = !par_lHabilitar
1883:             loc_oPg2.txt_4c_Gtatual.ReadOnly   = !par_lHabilitar
1884:             loc_oPg2.txt_4c_Modelo.ReadOnly    = !par_lHabilitar
1885:             loc_oPg2.txt_4c_NumUsu.ReadOnly    = !par_lHabilitar
1886:             loc_oPg2.txt_4c_TipoECF.ReadOnly   = !par_lHabilitar
1887:             loc_oPg2.txt_4c_VerSB.ReadOnly     = !par_lHabilitar
1888:             loc_oPg2.txt_4c_DataSB.ReadOnly    = !par_lHabilitar
1889:             loc_oPg2.txt_4c_HoraSB.ReadOnly    = !par_lHabilitar
1890:             loc_oPg2.txt_4c_CmdRFD.ReadOnly    = !par_lHabilitar
1891:             loc_oPg2.txt_4c_Coos.ReadOnly      = !par_lHabilitar
1892:             loc_oPg2.txt_4c_DtCad.ReadOnly     = !par_lHabilitar
1893:             loc_oPg2.txt_4c_HrCad.ReadOnly     = !par_lHabilitar
1894:             loc_oPg2.txt_4c_CRO.ReadOnly       = !par_lHabilitar
1895: 
1896:             *-- Codigo: editavel apenas em INCLUIR
1897:             loc_oPg2.txt_4c_Codigo.ReadOnly = !(THIS.this_cModoAtual = "INCLUIR")
1898: 
1899:             *-- Codnac: sempre somente leitura (populado pelo lookup de modelo)
1900:             loc_oPg2.txt_4c_Codnac.ReadOnly = .T.
1901:             loc_oPg2.txt_4c_Codnac.Enabled  = .F.
1902: 
1903:             loc_oPg2.chk_4c_Chk_LeitMF.Enabled  = par_lHabilitar
1904:             loc_oPg2.chk_4c_Chk_gaveta.Enabled  = par_lHabilitar
1905:             loc_oPg2.chk_4c_Chk_impche.Enabled  = par_lHabilitar
1906:             loc_oPg2.chk_4c_Fwcheckbox2.Enabled = par_lHabilitar
1907:             loc_oPg2.chk_4c_Fwcheckbox1.Enabled = par_lHabilitar
1908:             loc_oPg2.chk_4c_Chk_Bompara.Enabled = par_lHabilitar
1909:             loc_oPg2.chk_4c_Chk_nominal.Enabled = par_lHabilitar
1910:             loc_oPg2.chk_4c_Chk_cruzado.Enabled = par_lHabilitar
1911:             loc_oPg2.chk_4c_Chk_perto.Enabled   = par_lHabilitar
1912:             loc_oPg2.obj_4c_Optiongroup1.Enabled = par_lHabilitar
1913:             loc_oPg2.obj_4c_Optiongroup2.Enabled = par_lHabilitar
1914:             loc_oPg2.chk_4c_Fwcheckbox3.Enabled = par_lHabilitar
1915: 
1916:             loc_lResultado = .T.
1917:         CATCH TO loc_oErro
1918:             MostrarErro(loc_oErro, "FormFBI.HabilitarCampos")
1919:         ENDTRY
1920: 
1921:         RETURN loc_lResultado
1922:     ENDPROC
1923: 
1924:     *====================================================================
1925:     * LimparCampos - Reseta todos os campos da Page2 para valores padrao
1926:     *====================================================================
1927:     PROTECTED PROCEDURE LimparCampos()
1928:         LOCAL loc_lResultado, loc_oPg2
1929:         loc_lResultado = .F.
1930: 
1931:         TRY
1932:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1933: 
1934:             loc_oPg2.txt_4c_Codigo.Value       = ""
1935:             loc_oPg2.txt_4c_Ncaixa.Value       = ""
1936:             loc_oPg2.txt_4c_Interv.Value       = ""
1937:             loc_oPg2.txt_4c_Emp.Value          = ""
1938:             loc_oPg2.txt_4c_GTInicial.Value    = ""
1939:             loc_oPg2.txt_4c_Gtatual.Value      = ""
1940:             loc_oPg2.txt_4c_Modelo.Value       = ""
1941:             loc_oPg2.txt_4c_NumUsu.Value       = ""
1942:             loc_oPg2.txt_4c_TipoECF.Value      = ""
1943:             loc_oPg2.txt_4c_VerSB.Value        = ""
1944:             loc_oPg2.txt_4c_DataSB.Value       = {}
1945:             loc_oPg2.txt_4c_HoraSB.Value       = ""
1946:             loc_oPg2.txt_4c_CmdRFD.Value       = ""
1947:             loc_oPg2.txt_4c_Coos.Value         = ""
1948:             loc_oPg2.txt_4c_DtCad.Value        = {}
1949:             loc_oPg2.txt_4c_HrCad.Value        = ""
1950:             loc_oPg2.txt_4c_CRO.Value          = ""
1951:             loc_oPg2.txt_4c_Codnac.Value       = ""
1952:             loc_oPg2.chk_4c_Chk_LeitMF.Value  = 0
1953:             loc_oPg2.chk_4c_Chk_gaveta.Value  = 0
1954:             loc_oPg2.chk_4c_Chk_impche.Value  = 0
1955:             loc_oPg2.chk_4c_Fwcheckbox2.Value = 0
1956:             loc_oPg2.chk_4c_Fwcheckbox1.Value = 0
1957:             loc_oPg2.chk_4c_Chk_Bompara.Value = 0
1958:             loc_oPg2.chk_4c_Chk_nominal.Value = 0
1959:             loc_oPg2.chk_4c_Chk_cruzado.Value = 0
1960:             loc_oPg2.chk_4c_Chk_perto.Value   = 0
1961:             loc_oPg2.obj_4c_Optiongroup1.Value = 1
1962:             loc_oPg2.obj_4c_Optiongroup2.Value = 1
1963:             loc_oPg2.chk_4c_Fwcheckbox3.Value = 0
1964: 
1965:             loc_lResultado = .T.
1966:         CATCH TO loc_oErro
1967:             MostrarErro(loc_oErro, "FormFBI.LimparCampos")
1968:         ENDTRY
1969: 
1970:         RETURN loc_lResultado
1971:     ENDPROC
1972: 
1973:     *====================================================================
1974:     * AjustarBotoesPorModo - Habilita botao Confirmar apenas em INCLUIR/ALTERAR
1975:     *====================================================================
1976:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1977:         LOCAL loc_lConfirmarAtivo
1978:         loc_lConfirmarAtivo = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1979:         THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lConfirmarAtivo
1980:     ENDPROC
1981: 
1982:     *====================================================================
1983:     * BtnIncluirClick - Prepara formulario para inclusao de novo registro
1984:     *====================================================================
1985:     PROCEDURE BtnIncluirClick()
1986:         THIS.this_oBusinessObject.NovoRegistro()
1987:         THIS.this_cModoAtual = "INCLUIR"
1988:         THIS.LimparCampos()
1989:         THIS.pgf_4c_Paginas.Page2.txt_4c_Emp.Value = go_4c_Sistema.cCodEmpresa
1990:         THIS.HabilitarCampos(.T.)
1991:         THIS.AjustarBotoesPorModo()
1992:         THIS.AlternarPagina(2)
1993:         THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.SetFocus()
1994:     ENDPROC
1995: 
1996:     *====================================================================
1997:     * BtnVisualizarClick - Carrega registro selecionado para visualizacao
1998:     *====================================================================
1999:     PROCEDURE BtnVisualizarClick()
2000:         LOCAL loc_lResultado, loc_cChave
2001:         loc_lResultado = .F.
2002: 
2003:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
2004:             MsgAviso("Nenhum registro selecionado.")
2005:             RETURN .F.
2006:         ENDIF
2007: 
2008:         loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
2009: 
2010:         TRY
2011:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
2012:                 THIS.this_cModoAtual = "VISUALIZAR"
2013:                 THIS.BOParaForm()
2014:                 THIS.HabilitarCampos(.F.)
2015:                 THIS.AjustarBotoesPorModo()
2016:                 THIS.AlternarPagina(2)
2017:                 loc_lResultado = .T.
2018:             ENDIF
2019:         CATCH TO loc_oErro
2020:             MostrarErro(loc_oErro, "FormFBI.BtnVisualizarClick")
2021:         ENDTRY
2022: 
2023:         RETURN loc_lResultado
2024:     ENDPROC
2025: 
2026:     *====================================================================
2027:     * BtnAlterarClick - Carrega registro selecionado para edicao
2028:     *====================================================================
2029:     PROCEDURE BtnAlterarClick()
2030:         LOCAL loc_lResultado, loc_cChave
2031:         loc_lResultado = .F.
2032: 
2033:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
2034:             MsgAviso("Nenhum registro selecionado.")
2035:             RETURN .F.
2036:         ENDIF
2037: 
2038:         loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
2039: 
2040:         TRY
2041:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
2042:                 THIS.this_oBusinessObject.EditarRegistro()
2043:                 THIS.this_cModoAtual = "ALTERAR"
2044:                 THIS.BOParaForm()
2045:                 THIS.HabilitarCampos(.T.)
2046:                 THIS.AjustarBotoesPorModo()
2047:                 THIS.AlternarPagina(2)
2048:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Ncaixa.SetFocus()
2049:                 loc_lResultado = .T.
2050:             ENDIF
2051:         CATCH TO loc_oErro
2052:             MostrarErro(loc_oErro, "FormFBI.BtnAlterarClick")
2053:         ENDTRY
2054: 
2055:         RETURN loc_lResultado
2056:     ENDPROC
2057: 
2058:     *====================================================================
2059:     * BtnExcluirClick - Exclui registro selecionado apos confirmacao
2060:     *====================================================================
2061:     PROCEDURE BtnExcluirClick()
2062:         LOCAL loc_lResultado, loc_cChave, loc_lConfirma
2063:         loc_lResultado = .F.
2064: 
2065:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
2066:             MsgAviso("Nenhum registro selecionado.")
2067:             RETURN .F.
2068:         ENDIF
2069: 
2070:         loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
2071: 
2072:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
2073:             RETURN .F.
2074:         ENDIF
2075: 
2076:         loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?")
2077:         IF !loc_lConfirma
2078:             RETURN .F.
2079:         ENDIF
2080: 
2081:         TRY
2082:             IF THIS.this_oBusinessObject.Excluir()
2083:                 MsgInfo("Registro exclu" + CHR(237) + "do com sucesso.")
2084:                 THIS.CarregarLista()
2085:                 loc_lResultado = .T.
2086:             ENDIF
2087:         CATCH TO loc_oErro
2088:             MostrarErro(loc_oErro, "FormFBI.BtnExcluirClick")
2089:         ENDTRY
2090: 
2091:         RETURN loc_lResultado
2092:     ENDPROC
2093: 
2094:     *====================================================================
2095:     * BtnBuscarClick - Abre FormBuscaAuxiliar para pesquisa em SigFiMpf
2096:     *====================================================================
2097:     PROCEDURE BtnBuscarClick()
2098:         LOCAL loc_oBusca, loc_lResultado
2099:         loc_lResultado = .F.
2100: 
2101:         TRY
2102:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2103:                 "SigFiMpf", "cursor_4c_BuscaFBI", "cImpFabs", "", ;
2104:                 "Fabrica" + CHR(231) + CHR(227) + "o")
2105: 
2106:             IF VARTYPE(loc_oBusca) = "O"
2107:                 loc_oBusca.mAddColuna("cImpFabs", "", "N" + CHR(186) + " Fabrica" + CHR(231) + CHR(227) + "o")
2108:                 loc_oBusca.mAddColuna("emps",     "", "Empresa")
2109:                 loc_oBusca.mAddColuna("cncaixas", "", "Caixa")
2110:                 loc_oBusca.Show()
2111:                 THIS.CarregarLista()
2112:                 loc_lResultado = .T.
2113:             ENDIF
2114:         CATCH TO loc_oErro
2115:             MostrarErro(loc_oErro, "FormFBI.BtnBuscarClick")
2116:         ENDTRY
2117: 
2118:         IF USED("cursor_4c_BuscaFBI")
2119:             USE IN cursor_4c_BuscaFBI
2120:         ENDIF
2121: 
2122:         RETURN loc_lResultado
2123:     ENDPROC
2124: 
2125:     *====================================================================
2126:     * BtnEncerrarClick - Fecha o formulario
2127:     *====================================================================
2128:     PROCEDURE BtnEncerrarClick()
2129:         THIS.Release()
2130:     ENDPROC
2131: 
2132:     *====================================================================
2133:     * BtnSalvarClick - Valida dados e salva o registro atual
2134:     * Legado: Salva.Click
2135:     *====================================================================
2136:     PROCEDURE BtnSalvarClick()
2137:         LOCAL loc_lResultado, loc_oPg2
2138:         loc_lResultado = .F.
2139: 
2140:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2141: 
2142:         *-- Validacoes FORA do TRY (Regra VFP9 #1: RETURN nao permitido dentro de TRY)
2143:         IF THIS.this_cModoAtual = "INCLUIR"
2144:             IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Codigo.Value))
2145:                 MsgAviso("N" + CHR(186) + " Fabrica" + CHR(231) + CHR(227) + "o (NFAB) " + CHR(233) + " obrigat" + CHR(243) + "rio.")
2146:                 loc_oPg2.txt_4c_Codigo.SetFocus()
2147:                 RETURN .F.
2148:             ENDIF
2149:         ENDIF
2150: 
2151:         IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Modelo.Value))
2152:             MsgAviso("Modelo " + CHR(233) + " obrigat" + CHR(243) + "rio.")
2153:             loc_oPg2.txt_4c_Modelo.SetFocus()
2154:             RETURN .F.
2155:         ENDIF
2156: 
2157:         TRY
2158:             THIS.FormParaBO()
2159: 
2160:             IF THIS.this_oBusinessObject.Salvar()
2161:                 MsgInfo("Registro salvo com sucesso.")
2162:                 THIS.this_cModoAtual = "LISTA"
2163:                 THIS.AlternarPagina(1)
2164:                 loc_lResultado = .T.
2165:             ENDIF
2166:         CATCH TO loc_oErro
2167:             MostrarErro(loc_oErro, "FormFBI.BtnSalvarClick")
2168:         ENDTRY
2169: 
2170:         RETURN loc_lResultado
2171:     ENDPROC
2172: 
2173:     *====================================================================
2174:     * BtnCancelarClick - Cancela operacao e retorna para lista
2175:     *====================================================================
2176:     PROCEDURE BtnCancelarClick()
2177:         THIS.this_cModoAtual = "LISTA"
2178:         THIS.AlternarPagina(1)
2179:     ENDPROC
2180: 
2181: ENDDEFINE


### BO (C:\4c\projeto\app\classes\FBIBO.prg):
*====================================================================
* FBIBO.prg
*
* Business Object para Cadastro de Fabricacao (SigFiMpf)
* Herda de: BusinessBase
*
* Tabela: SigFiMpf
* Chave primaria: cidchaves (gerada por Sys(2015)+Sys(2015))
* Chave de negocio: cImpFabs (No. Fabricacao / NFAB)
*
* Campos GT (cgtinics, cgtatuas) armazenados como strings no legado.
*====================================================================

DEFINE CLASS FBIBO AS BusinessBase

    *-- Chave primaria interna
    this_cChaves        = ""   && cidchaves char(30)  - PK gerada automaticamente

    *-- Identificacao do ECF
    this_cCodigo        = ""   && cImpFabs char(20)   - No. Fabricacao / NFAB (chave negocio)
    this_cEmpresa       = ""   && emps char(3)         - Codigo da empresa
    this_cNcaixas       = ""   && cncaixas char(3)     - No. do Caixa / NSEQ

    *-- Contadores e registradores
    this_cInterv        = ""   && cnintervs char(4)    - Contador Reinicio de Operacao
    this_cGTInics       = ""   && cgtinics char(30)    - GT Inicial (string)
    this_cGTAtuas       = ""   && cgtatuas char(30)    - GT Atual (string)

    *-- Modelo e identificacao do ECF
    this_cModelo        = ""   && cModelos char(30)    - Modelo da impressora ECF
    this_cNumUsuars     = ""   && cnumusuars char(2)   - Numero do Usuario do ECF
    this_cTipoECF       = ""   && ctipoecfs char(7)    - Tipo do ECF
    this_cCodNac        = ""   && cidecfs char(6)      - Codigo Nacional do ECF
    this_cIfCoos        = ""   && cIfCoos char(6)      - COO Inicial (Troca Aplicativo)
    this_cCROIniOps     = ""   && ccroiniops char(6)   - CRO Inicial de Operacoes

    *-- Software Basico
    this_cVersaoSB      = ""   && cversaosbs char(10)  - Versao do Software Basico
    this_dDataSB        = {}   && tdatasbs date        - Data do Software Basico
    this_cHoraSB        = ""   && chorasbs char(8)     - Hora do Software Basico (HH:MM:SS)

    *-- Dados de cadastro do ECF
    this_dDtCadECF      = {}   && tdtcadecfs date      - Data do Cadastro do ECF
    this_cHrCadECF      = ""   && chrcadecfs char(8)   - Hora do Cadastro do ECF (HH:MM:SS)

    *-- Comando RFD
    this_cCmdRFD        = ""   && ccmdgers char(3)     - Comando de Geracao RFD

    *-- Flags booleanos (BIT no SQL Server)
    this_lGaveta        = .F.  && gavetas              - Gaveta Acoplada
    this_lImpCheque     = .F.  && impches              - Impressora de Cheques
    this_lPerto         = .F.  && Pertos               - Pertochek / Check-Pronto
    this_lBomPara       = .F.  && bompara              - Bom Para (uso cheque)
    this_lNominal       = .F.  && nominal              - Nominal
    this_lCruzado       = .F.  && cruzado              - Cruzado
    this_lInativa       = .F.  && ImpAtivas            - Impressora Inativa
    this_lLeitMF        = .F.  && MemFautos            - Leitura Mem. Fiscal Automatico
    this_lMFD           = .F.  && impmfds              - MFD (Memoria de Fita Detalhe)
    this_lISSQN         = .F.  && cissqns              - Incidencia Desconto ISSQN

    *-- Opcoes OptionGroup (N: 1=Sim, 2=Nao)
    this_nAutentica     = 1    && Autenticas           - Autentica cheque (1=Sim, 2=Nao)
    this_nImpBars       = 1    && nImpBars             - Imprime Cod. de Barras (1=Sim, 2=Nao)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigFiMpf"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cChaves
    ENDPROC

    *====================================================================
    * LimparDados - Limpa propriedades (chamado por NovoRegistro)
    *====================================================================
    PROTECTED PROCEDURE LimparDados()
        THIS.this_cChaves    = ""
        THIS.this_cCodigo    = ""
        THIS.this_cEmpresa   = ""
        THIS.this_cNcaixas   = ""
        THIS.this_cInterv    = ""
        THIS.this_cGTInics   = ""
        THIS.this_cGTAtuas   = ""
        THIS.this_cModelo    = ""
        THIS.this_cNumUsuars = ""
        THIS.this_cTipoECF   = ""
        THIS.this_cCodNac    = ""
        THIS.this_cIfCoos    = ""
        THIS.this_cCROIniOps = ""
        THIS.this_cVersaoSB  = ""
        THIS.this_dDataSB    = {}
        THIS.this_cHoraSB    = ""
        THIS.this_dDtCadECF  = {}
        THIS.this_cHrCadECF  = ""
        THIS.this_cCmdRFD    = ""
        THIS.this_lGaveta    = .F.
        THIS.this_lImpCheque = .F.
        THIS.this_lPerto     = .F.
        THIS.this_lBomPara   = .F.
        THIS.this_lNominal   = .F.
        THIS.this_lCruzado   = .F.
        THIS.this_lInativa   = .F.
        THIS.this_lLeitMF    = .F.
        THIS.this_lMFD       = .F.
        THIS.this_lISSQN     = .F.
        THIS.this_nAutentica = 1
        THIS.this_nImpBars   = 1
    ENDPROC

    *====================================================================
    * Buscar - Retorna lista de registros (cursor_4c_Dados)
    *====================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, cImpFabs, emps, cncaixas, cnintervs," + ;
                       " cgtinics, cgtatuas, cModelos, cnumusuars, ctipoecfs," + ;
                       " cidecfs, cIfCoos, ccroiniops, cversaosbs," + ;
                       " tdatasbs, chorasbs, tdtcadecfs, chrcadecfs, ccmdgers," + ;
                       " gavetas, impches, Pertos, bompara, nominal, cruzado," + ;
                       " ImpAtivas, MemFautos, Autenticas, impmfds, nImpBars, cissqns" + ;
                       " FROM SigFiMpf"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE cImpFabs LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%")
                loc_cSQL = loc_cSQL + loc_cWhere
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY cImpFabs"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado > 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar registros: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FBIBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (cidchaves)
    *====================================================================
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, cImpFabs, emps, cncaixas, cnintervs," + ;
                       " cgtinics, cgtatuas, cModelos, cnumusuars, ctipoecfs," + ;
                       " cidecfs, cIfCoos, ccroiniops, cversaosbs," + ;
                       " tdatasbs, chorasbs, tdtcadecfs, chrcadecfs, ccmdgers," + ;
                       " gavetas, impches, Pertos, bompara, nominal, cruzado," + ;
                       " ImpAtivas, MemFautos, Autenticas, impmfds, nImpBars, cissqns" + ;
                       " FROM SigFiMpf WHERE cidchaves = " + EscaparSQL(par_cCodigo)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                MostrarErro("Registro n" + CHR(227) + "o encontrado.", "")
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FBIBO.CarregarPorCodigo")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cChaves    = TratarNulo(cidchaves, "C")
                THIS.this_cCodigo    = TratarNulo(cImpFabs, "C")
                THIS.this_cEmpresa   = TratarNulo(emps, "C")
                THIS.this_cNcaixas   = TratarNulo(cncaixas, "C")
                THIS.this_cInterv    = TratarNulo(cnintervs, "C")
                THIS.this_cGTInics   = TratarNulo(cgtinics, "C")
                THIS.this_cGTAtuas   = TratarNulo(cgtatuas, "C")
                THIS.this_cModelo    = TratarNulo(cModelos, "C")
                THIS.this_cNumUsuars = TratarNulo(cnumusuars, "C")
                THIS.this_cTipoECF   = TratarNulo(ctipoecfs, "C")
                THIS.this_cCodNac    = TratarNulo(cidecfs, "C")
                THIS.this_cIfCoos    = TratarNulo(cIfCoos, "C")
                THIS.this_cCROIniOps = TratarNulo(ccroiniops, "C")
                THIS.this_cVersaoSB  = TratarNulo(cversaosbs, "C")
                THIS.this_dDataSB    = TratarNulo(tdatasbs, "D")
                THIS.this_cHoraSB    = TratarNulo(chorasbs, "C")
                THIS.this_dDtCadECF  = TratarNulo(tdtcadecfs, "D")
                THIS.this_cHrCadECF  = TratarNulo(chrcadecfs, "C")
                THIS.this_cCmdRFD    = TratarNulo(ccmdgers, "C")
                IF VARTYPE(gavetas) = "L"
                    THIS.this_lGaveta = gavetas
                ELSE
                    IF VARTYPE(gavetas) = "L"
                        THIS.this_lGaveta = gavetas
                    ELSE
                        THIS.this_lGaveta = (NVL(gavetas, 0) = 1)
                    ENDIF
                ENDIF
                IF VARTYPE(impches) = "L"
                    THIS.this_lImpCheque = impches
                ELSE
                    IF VARTYPE(impches) = "L"
                        THIS.this_lImpCheque = impches
                    ELSE
                        THIS.this_lImpCheque = (NVL(impches, 0) = 1)
                    ENDIF
                ENDIF
                IF VARTYPE(Pertos) = "L"
                    THIS.this_lPerto = Pertos
                ELSE
                    IF VARTYPE(Pertos) = "L"
                        THIS.this_lPerto = Pertos
                    ELSE
                        THIS.this_lPerto = (NVL(Pertos, 0) = 1)
                    ENDIF
                ENDIF
                IF VARTYPE(bompara) = "L"
                    THIS.this_lBomPara = bompara
                ELSE
                    IF VARTYPE(bompara) = "L"
                        THIS.this_lBomPara = bompara
                    ELSE
                        THIS.this_lBomPara = (NVL(bompara, 0) = 1)
                    ENDIF
                ENDIF
                IF VARTYPE(nominal) = "L"
                    THIS.this_lNominal = nominal
                ELSE
                    IF VARTYPE(nominal) = "L"
                        THIS.this_lNominal = nominal
                    ELSE
                        THIS.this_lNominal = (NVL(nominal, 0) = 1)
                    ENDIF
                ENDIF
                IF VARTYPE(cruzado) = "L"
                    THIS.this_lCruzado = cruzado
                ELSE
                    IF VARTYPE(cruzado) = "L"
                        THIS.this_lCruzado = cruzado
                    ELSE
                        THIS.this_lCruzado = (NVL(cruzado, 0) = 1)
                    ENDIF
                ENDIF
                IF VARTYPE(ImpAtivas) = "L"
                    THIS.this_lInativa = ImpAtivas
                ELSE
                    IF VARTYPE(ImpAtivas) = "L"
                        THIS.this_lInativa = ImpAtivas
                    ELSE
                        THIS.this_lInativa = (NVL(ImpAtivas, 0) = 1)
                    ENDIF
                ENDIF
                IF VARTYPE(MemFautos) = "L"
                    THIS.this_lLeitMF = MemFautos
                ELSE
                    IF VARTYPE(MemFautos) = "L"
                        THIS.this_lLeitMF = MemFautos
                    ELSE
                        THIS.this_lLeitMF = (NVL(MemFautos, 0) = 1)
                    ENDIF
                ENDIF
                IF VARTYPE(impmfds) = "L"
                    THIS.this_lMFD = impmfds
                ELSE
                    IF VARTYPE(impmfds) = "L"
                        THIS.this_lMFD = impmfds
                    ELSE
                        THIS.this_lMFD = (NVL(impmfds, 0) = 1)
                    ENDIF
                ENDIF
                IF VARTYPE(cissqns) = "L"
                    THIS.this_lISSQN = cissqns
                ELSE
                    IF VARTYPE(cissqns) = "L"
                        THIS.this_lISSQN = cissqns
                    ELSE
                        THIS.this_lISSQN = (NVL(cissqns, 0) = 1)
                    ENDIF
                ENDIF
                THIS.this_nAutentica = NVL(Autenticas, 1)
                THIS.this_nImpBars   = NVL(nImpBars, 1)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FBIBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - INSERT em SigFiMpf
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        LOCAL loc_cDataSB, loc_cDtCadECF
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cChaves)
                THIS.this_cChaves = SYS(2015) + SYS(2015)
            ENDIF

            loc_cDataSB   = IIF(EMPTY(THIS.this_dDataSB),   "NULL", FormatarDataSQL(THIS.this_dDataSB))
            loc_cDtCadECF = IIF(EMPTY(THIS.this_dDtCadECF), "NULL", FormatarDataSQL(THIS.this_dDtCadECF))

            loc_cSQL = "INSERT INTO SigFiMpf (" + ;
                       " cidchaves, cImpFabs, emps, cncaixas, cnintervs," + ;
                       " cgtinics, cgtatuas, cModelos, cnumusuars, ctipoecfs," + ;
                       " cidecfs, cIfCoos, ccroiniops, cversaosbs," + ;
                       " tdatasbs, chorasbs, tdtcadecfs, chrcadecfs, ccmdgers," + ;
                       " gavetas, impches, Pertos, bompara, nominal, cruzado," + ;
                       " ImpAtivas, MemFautos, Autenticas, impmfds, nImpBars, cissqns" + ;
                       ") VALUES (" + ;
                       EscaparSQL(THIS.this_cChaves) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodigo), 20)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmpresa), 3)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cNcaixas), 3)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cInterv), 4)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cGTInics), 30)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cGTAtuas), 30)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cModelo), 30)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cNumUsuars), 2)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cTipoECF), 7)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodNac), 6)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cIfCoos), 6)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cCROIniOps), 6)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cVersaoSB), 10)) + ", " + ;
                       loc_cDataSB + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cHoraSB), 8)) + ", " + ;
                       loc_cDtCadECF + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cHrCadECF), 8)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cCmdRFD), 3)) + ", " + ;
                       IIF(THIS.this_lGaveta,    "1", "0") + ", " + ;
                       IIF(THIS.this_lImpCheque, "1", "0") + ", " + ;
                       IIF(THIS.this_lPerto,     "1", "0") + ", " + ;
                       IIF(THIS.this_lBomPara,   "1", "0") + ", " + ;
                       IIF(THIS.this_lNominal,   "1", "0") + ", " + ;
                       IIF(THIS.this_lCruzado,   "1", "0") + ", " + ;
                       IIF(THIS.this_lInativa,   "1", "0") + ", " + ;
                       IIF(THIS.this_lLeitMF,    "1", "0") + ", " + ;
                       FormatarNumeroSQL(THIS.this_nAutentica) + ", " + ;
                       IIF(THIS.this_lMFD,       "1", "0") + ", " + ;
                       FormatarNumeroSQL(THIS.this_nImpBars) + ", " + ;
                       IIF(THIS.this_lISSQN,     "1", "0") + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir registro: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FBIBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - UPDATE em SigFiMpf
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        LOCAL loc_cDataSB, loc_cDtCadECF
        loc_lSucesso = .F.

        TRY
            loc_cDataSB   = IIF(EMPTY(THIS.this_dDataSB),   "NULL", FormatarDataSQL(THIS.this_dDataSB))
            loc_cDtCadECF = IIF(EMPTY(THIS.this_dDtCadECF), "NULL", FormatarDataSQL(THIS.this_dDtCadECF))

            loc_cSQL = "UPDATE SigFiMpf SET" + ;
                       " cImpFabs   = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodigo), 20)) + "," + ;
                       " emps       = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmpresa), 3)) + "," + ;
                       " cncaixas   = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cNcaixas), 3)) + "," + ;
                       " cnintervs  = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cInterv), 4)) + "," + ;
                       " cgtinics   = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cGTInics), 30)) + "," + ;
                       " cgtatuas   = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cGTAtuas), 30)) + "," + ;
                       " cModelos   = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cModelo), 30)) + "," + ;
                       " cnumusuars = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cNumUsuars), 2)) + "," + ;
                       " ctipoecfs  = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cTipoECF), 7)) + "," + ;
                       " cidecfs    = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodNac), 6)) + "," + ;
                       " cIfCoos    = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cIfCoos), 6)) + "," + ;
                       " ccroiniops = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCROIniOps), 6)) + "," + ;
                       " cversaosbs = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cVersaoSB), 10)) + "," + ;
                       " tdatasbs   = " + loc_cDataSB + "," + ;
                       " chorasbs   = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cHoraSB), 8)) + "," + ;
                       " tdtcadecfs = " + loc_cDtCadECF + "," + ;
                       " chrcadecfs = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cHrCadECF), 8)) + "," + ;
                       " ccmdgers   = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCmdRFD), 3)) + "," + ;
                       " gavetas    = " + IIF(THIS.this_lGaveta,    "1", "0") + "," + ;
                       " impches    = " + IIF(THIS.this_lImpCheque, "1", "0") + "," + ;
                       " Pertos     = " + IIF(THIS.this_lPerto,     "1", "0") + "," + ;
                       " bompara    = " + IIF(THIS.this_lBomPara,   "1", "0") + "," + ;
                       " nominal    = " + IIF(THIS.this_lNominal,   "1", "0") + "," + ;
                       " cruzado    = " + IIF(THIS.this_lCruzado,   "1", "0") + "," + ;
                       " ImpAtivas  = " + IIF(THIS.this_lInativa,   "1", "0") + "," + ;
                       " MemFautos  = " + IIF(THIS.this_lLeitMF,    "1", "0") + "," + ;
                       " Autenticas = " + FormatarNumeroSQL(THIS.this_nAutentica) + "," + ;
                       " impmfds    = " + IIF(THIS.this_lMFD,       "1", "0") + "," + ;
                       " nImpBars   = " + FormatarNumeroSQL(THIS.this_nImpBars) + "," + ;
                       " cissqns    = " + IIF(THIS.this_lISSQN,     "1", "0") + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar registro: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FBIBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - DELETE em SigFiMpf com verificacao de dependencias
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_lMovimento
        loc_lSucesso  = .F.
        loc_lMovimento = .F.

        TRY
            *-- Verificar movimentos em SigMvCab
            loc_cSQL = "SELECT EmpDopNums FROM SigMvCab WHERE nEmps = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ChkMvCab")
                TABLEREVERT(.T., "cursor_4c_ChkMvCab")
                USE IN cursor_4c_ChkMvCab
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkMvCab")
            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ChkMvCab") > 0
                loc_lMovimento = .T.
            ENDIF
            IF USED("cursor_4c_ChkMvCab")
                USE IN cursor_4c_ChkMvCab
            ENDIF

            *-- Verificar movimentos em SigExMvc
            IF !loc_lMovimento
                loc_cSQL = "SELECT EmpDopNums FROM SigExMvc WHERE nEmps = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_ChkExMvc")
                    TABLEREVERT(.T., "cursor_4c_ChkExMvc")
                    USE IN cursor_4c_ChkExMvc
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkExMvc")
                IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ChkExMvc") > 0
                    loc_lMovimento = .T.
                ENDIF
                IF USED("cursor_4c_ChkExMvc")
                    USE IN cursor_4c_ChkExMvc
                ENDIF
            ENDIF

            *-- Verificar lancamentos em SigFiRX
            IF !loc_lMovimento
                loc_cSQL = "SELECT datas FROM SigFiRX WHERE serifab = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_ChkFiRX")
                    TABLEREVERT(.T., "cursor_4c_ChkFiRX")
                    USE IN cursor_4c_ChkFiRX
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkFiRX")
                IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ChkFiRX") > 0
                    loc_lMovimento = .T.
                ENDIF
                IF USED("cursor_4c_ChkFiRX")
                    USE IN cursor_4c_ChkFiRX
                ENDIF
            ENDIF

            IF loc_lMovimento
                MsgAviso("Impressora Fiscal N" + CHR(227) + "o Pode Ser Exclui" + CHR(237) + "da, Possui Movimenta" + CHR(231) + CHR(227) + "o !!!")
            ELSE
                loc_cSQL = "DELETE FROM SigFiMpf WHERE cidchaves = " + EscaparSQL(THIS.this_cChaves)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao excluir registro: " + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FBIBO.ExecutarExclusao")
            IF USED("cursor_4c_ChkMvCab")
                USE IN cursor_4c_ChkMvCab
            ENDIF
            IF USED("cursor_4c_ChkExMvc")
                USE IN cursor_4c_ChkExMvc
            ENDIF
            IF USED("cursor_4c_ChkFiRX")
                USE IN cursor_4c_ChkFiRX
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

