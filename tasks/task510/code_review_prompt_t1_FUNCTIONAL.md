# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (8)
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BINDEVENT-PARAMS] Handler 'ValidarCodigo' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarCodigo(par_nKeyCode, par_nShiftAltCtrl)
- [GRID-HEADER] Header Caption 'Regiões' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: UF, Município, Código, Nome do Vendedor. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Descrição' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: UF, Município, Código, Nome do Vendedor. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Regiões' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: UF, Município, Código, Nome do Vendedor. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Descrição' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: UF, Município, Código, Nome do Vendedor. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormReg.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1689 linhas total):

*-- Linhas 25 a 152:
25:     *==========================================================================
26:     * Init - Inicializa o formulario
27:     * REGRA CRITICA: Apenas RETURN DODEFAULT()
28:     * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
29:     *==========================================================================
30:     PROCEDURE Init()
31:         RETURN DODEFAULT()
32:     ENDPROC
33: 
34:     *==========================================================================
35:     * InicializarForm - Configura estrutura completa do formulario
36:     * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
37:     *==========================================================================
38:     PROTECTED PROCEDURE InicializarForm()
39:         LOCAL loc_lSucesso
40:         loc_lSucesso = .F.
41: 
42:         TRY
43:             *-- Caption com acento (CHR(245) = o-tilde)
44:             THIS.Caption = "Cadastro de Regi" + CHR(245) + "es"
45: 
46:             THIS.this_oBusinessObject = CREATEOBJECT("RegBO")
47: 
48:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
49:                 MostrarErro("Erro ao criar RegBO" + CHR(13) + ;
50:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
51:                     "FormReg.InicializarForm")
52:             ELSE
53:                 THIS.ConfigurarPageFrame()
54: 
55:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
56:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
57:                 THIS.pgf_4c_Paginas.Visible = .T.
58:                 THIS.pgf_4c_Paginas.ActivePage = 1
59:                 THIS.this_cModoAtual = "LISTA"
60: 
61:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
62:                     THIS.CarregarLista()
63:                 ENDIF
64: 
65:                 loc_lSucesso = .T.
66:             ENDIF
67: 
68:         CATCH TO loException
69:             MostrarErro("Erro ao inicializar FormReg:" + CHR(13) + ;
70:                 loException.Message + CHR(13) + ;
71:                 "Linha: " + TRANSFORM(loException.LineNo), ;
72:                 "FormReg.InicializarForm")
73:         ENDTRY
74: 
75:         RETURN loc_lSucesso
76:     ENDPROC
77: 
78:     *==========================================================================
79:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
80:     * Top=-29 para esconder abas; controles compensam +29 no Top
81:     *==========================================================================
82:     PROTECTED PROCEDURE ConfigurarPageFrame()
83:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
84: 
85:         WITH THIS.pgf_4c_Paginas
86:             .PageCount = 2
87:             .Top       = -29
88:             .Left      = 0
89:             .Width     = THIS.Width
90:             .Height    = THIS.Height + 29
91:             .Tabs      = .F.
92:             .Visible   = .T.
93: 
94:             .Page1.Caption   = "Lista"
95:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
96:             .Page1.BackColor = RGB(255, 255, 255)
97: 
98:             .Page2.Caption   = "Dados"
99:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
100:             .Page2.BackColor = RGB(255, 255, 255)
101:         ENDWITH
102: 
103:         THIS.ConfigurarPaginaLista()
104:         THIS.ConfigurarPaginaDados()
105:     ENDPROC
106: 
107:     *==========================================================================
108:     * ConfigurarPaginaLista - Configura Page1 com containers principais
109:     * Legado: cntSombra Top=1, Grupo_op Left=544/Top=-1, Grupo_Saida Left=919
110:     * Compensacao PageFrame +29: Tops ajustados
111:     *==========================================================================
112:     PROTECTED PROCEDURE ConfigurarPaginaLista()
113:         LOCAL loc_oPagina
114:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
115: 
116:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
117:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
118: 
119:         *-- Container Cabecalho (cntSombra no legado: Top=1 + 29 = 30 -> canonico 31)
120:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
121:         WITH loc_oPagina.cnt_4c_Cabecalho
122:             .Top         = 31
123:             .Left        = 0
124:             .Width       = THIS.Width
125:             .Height      = 80
126:             .BackColor   = RGB(100, 100, 100)
127:             .BorderWidth = 0
128:             .Visible     = .T.
129:         ENDWITH
130: 
131:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
132:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
133:             .Caption   = THIS.Caption
134:             .Top       = 15
135:             .Left      = 10
136:             .Width     = 769
137:             .Height    = 40
138:             .FontName  = "Tahoma"
139:             .FontSize  = 16
140:             .FontBold  = .T.
141:             .ForeColor = RGB(0, 0, 0)
142:             .BackStyle = 0
143:             .AutoSize  = .F.
144:             .Visible   = .T.
145:         ENDWITH
146: 
147:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
148:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
149:             .Caption   = THIS.Caption
150:             .Top       = 18
151:             .Left      = 10
152:             .Width     = 769

*-- Linhas 208 a 518:
208:             .AutoSize        = .F.
209:             .Visible         = .T.
210:         ENDWITH
211:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
212: 
213:         *-- Botao Incluir
214:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
215:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
216:             .Caption         = "Incluir"
217:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
218:             .PicturePosition = 13
219:             .Top             = 5
220:             .Left            = 5
221:             .Width           = 75
222:             .Height          = 75
223:             .FontName        = "Comic Sans MS"
224:             .FontBold        = .T.
225:             .FontItalic      = .T.
226:             .FontSize        = 8
227:             .ForeColor       = RGB(90, 90, 90)
228:             .BackColor       = RGB(255, 255, 255)
229:             .Themes          = .F.
230:             .SpecialEffect   = 0
231:             .MousePointer    = 15
232:             .WordWrap        = .T.
233:             .AutoSize        = .F.
234:             .Visible         = .T.
235:         ENDWITH
236:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
237: 
238:         *-- Botao Visualizar
239:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
240:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
241:             .Caption         = "Visualizar"
242:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
243:             .PicturePosition = 13
244:             .Top             = 5
245:             .Left            = 80
246:             .Width           = 75
247:             .Height          = 75
248:             .FontName        = "Comic Sans MS"
249:             .FontBold        = .T.
250:             .FontItalic      = .T.
251:             .FontSize        = 8
252:             .ForeColor       = RGB(90, 90, 90)
253:             .BackColor       = RGB(255, 255, 255)
254:             .Themes          = .F.
255:             .SpecialEffect   = 0
256:             .MousePointer    = 15
257:             .WordWrap        = .T.
258:             .AutoSize        = .F.
259:             .Visible         = .T.
260:         ENDWITH
261:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
262: 
263:         *-- Botao Alterar
264:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
265:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
266:             .Caption         = "Alterar"
267:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
268:             .PicturePosition = 13
269:             .Top             = 5
270:             .Left            = 155
271:             .Width           = 75
272:             .Height          = 75
273:             .FontName        = "Comic Sans MS"
274:             .FontBold        = .T.
275:             .FontItalic      = .T.
276:             .FontSize        = 8
277:             .ForeColor       = RGB(90, 90, 90)
278:             .BackColor       = RGB(255, 255, 255)
279:             .Themes          = .F.
280:             .SpecialEffect   = 0
281:             .MousePointer    = 15
282:             .WordWrap        = .T.
283:             .AutoSize        = .F.
284:             .Visible         = .T.
285:         ENDWITH
286:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
287: 
288:         *-- Botao Excluir
289:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
290:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
291:             .Caption         = "Excluir"
292:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
293:             .PicturePosition = 13
294:             .Top             = 5
295:             .Left            = 230
296:             .Width           = 75
297:             .Height          = 75
298:             .FontName        = "Comic Sans MS"
299:             .FontBold        = .T.
300:             .FontItalic      = .T.
301:             .FontSize        = 8
302:             .ForeColor       = RGB(90, 90, 90)
303:             .BackColor       = RGB(255, 255, 255)
304:             .Themes          = .F.
305:             .SpecialEffect   = 0
306:             .MousePointer    = 15
307:             .WordWrap        = .T.
308:             .AutoSize        = .F.
309:             .Visible         = .T.
310:         ENDWITH
311:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
312: 
313:         *-- Botao Buscar
314:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
315:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
316:             .Caption         = "Buscar"
317:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
318:             .PicturePosition = 13
319:             .Top             = 5
320:             .Left            = 305
321:             .Width           = 75
322:             .Height          = 75
323:             .FontName        = "Comic Sans MS"
324:             .FontBold        = .T.
325:             .FontItalic      = .T.
326:             .FontSize        = 8
327:             .ForeColor       = RGB(90, 90, 90)
328:             .BackColor       = RGB(255, 255, 255)
329:             .Themes          = .F.
330:             .SpecialEffect   = 0
331:             .MousePointer    = 15
332:             .WordWrap        = .T.
333:             .AutoSize        = .F.
334:             .Visible         = .T.
335:         ENDWITH
336:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
337: 
338:         *-- Grid de listagem (Top=117 = 88+29 compensacao PageFrame, Left=26, Width=890)
339:         *-- Colunas: regiaos (Regioes), descs (Descricao) - de SigCdReg via cursor_4c_Dados
340:         *-- RecordSource e ColumnCount FORA do WITH (Problem 36: evita Unknown member COLUMN1)
341:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
342:         loc_oPagina.grd_4c_Lista.RecordSource = ""
343:         loc_oPagina.grd_4c_Lista.ColumnCount  = 2
344:         WITH loc_oPagina.grd_4c_Lista
345:             .Top                = 117
346:             .Left               = 26
347:             .Width              = 890
348:             .Height             = 498
349:             .FontName           = "Verdana"
350:             .FontSize           = 8
351:             .ForeColor          = RGB(90, 90, 90)
352:             .BackColor          = RGB(255, 255, 255)
353:             .GridLineColor      = RGB(238, 238, 238)
354:             .HighlightBackColor = RGB(255, 255, 255)
355:             .HighlightForeColor = RGB(15, 41, 104)
356:             .HighlightStyle     = 2
357:             .DeleteMark         = .F.
358:             .RecordMark         = .F.
359:             .RowHeight          = 16
360:             .ScrollBars         = 2
361:             .GridLines          = 3
362:             .Visible            = .T.
363:             .Column1.Width              = 100
364:             .Column2.Width              = 400
365:             .Column1.Header1.Caption    = "Regi" + CHR(245) + "es"
366:             .Column2.Header1.Caption    = "Descri" + CHR(231) + CHR(227) + "o"
367:         ENDWITH
368:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")
369: 
370:         THIS.TornarControlesVisiveis(loc_oPagina)
371:     ENDPROC
372: 
373:     *==========================================================================
374:     * ConfigurarPaginaDados - Configura Page2: botoes + campos basicos + label Municipios
375:     * Legado: Grupo_Salva Left=843, Top=-4+29=25
376:     * Fase 5: Confirmar/Cancelar + txt/lbl Codigo + txt/lbl Descricao + lbl Municipios
377:     *==========================================================================
378:     PROTECTED PROCEDURE ConfigurarPaginaDados()
379:         LOCAL loc_oPagina
380:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
381: 
382:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
383:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
384: 
385:         *-- Container BotoesAcao (Grupo_Salva no legado: Left=843, Top=-4+29=25)
386:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
387:         WITH loc_oPagina.cnt_4c_BotoesAcao
388:             .Top         = 25
389:             .Left        = 843
390:             .Width       = 160
391:             .Height      = 85
392:             .BackStyle   = 0
393:             .BorderWidth = 0
394:             .Visible     = .T.
395:         ENDWITH
396: 
397:         *-- Botao Confirmar (cadastro_salvar_60.jpg - Problem 16: icone correto)
398:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
399:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
400:             .Caption         = "Confirmar"
401:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
402:             .PicturePosition = 13
403:             .Top             = 5
404:             .Left            = 5
405:             .Width           = 75
406:             .Height          = 75
407:             .FontName        = "Comic Sans MS"
408:             .FontBold        = .T.
409:             .FontItalic      = .T.
410:             .FontSize        = 8
411:             .ForeColor       = RGB(90, 90, 90)
412:             .BackColor       = RGB(255, 255, 255)
413:             .Themes          = .F.
414:             .SpecialEffect   = 0
415:             .MousePointer    = 15
416:             .WordWrap        = .T.
417:             .AutoSize        = .F.
418:             .Visible         = .T.
419:         ENDWITH
420:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
421: 
422:         *-- Botao Cancelar
423:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
424:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
425:             .Caption         = "Encerrar"
426:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
427:             .PicturePosition = 13
428:             .Top             = 5
429:             .Left            = 80
430:             .Width           = 75
431:             .Height          = 75
432:             .FontName        = "Comic Sans MS"
433:             .FontBold        = .T.
434:             .FontItalic      = .T.
435:             .FontSize        = 8
436:             .ForeColor       = RGB(90, 90, 90)
437:             .BackColor       = RGB(255, 255, 255)
438:             .Themes          = .F.
439:             .SpecialEffect   = 0
440:             .MousePointer    = 15
441:             .WordWrap        = .T.
442:             .AutoSize        = .F.
443:             .Visible         = .T.
444:         ENDWITH
445:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
446: 
447:         *-- Label Codigo (Say2 legado: Top=86+29=115, Left=53)
448:         loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
449:         WITH loc_oPagina.lbl_4c_Codigo
450:             .Caption   = "C" + CHR(243) + "digo :"
451:             .Top       = 115
452:             .Left      = 53
453:             .Width     = 50
454:             .Height    = 17
455:             .FontName  = "Tahoma"
456:             .FontSize  = 8
457:             .ForeColor = RGB(90, 90, 90)
458:             .BackStyle = 0
459:             .Alignment = 1
460:             .Visible   = .T.
461:         ENDWITH
462: 
463:         *-- TextBox Codigo (Get_codigo legado: Top=82+29=111, Left=97, Width=80, Height=23)
464:         *-- MaxLength=10 conforme SigCdReg.regiaos char(10)
465:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
466:         WITH loc_oPagina.txt_4c_Codigo
467:             .Value     = ""
468:             .Top       = 111
469:             .Left      = 97
470:             .Width     = 80
471:             .Height    = 23
472:             .FontName  = "Tahoma"
473:             .FontSize  = 8
474:             .MaxLength = 10
475:             .ReadOnly  = .F.
476:             .Visible   = .T.
477:         ENDWITH
478:         BINDEVENT(loc_oPagina.txt_4c_Codigo, "KeyPress", THIS, "ValidarCodigo")
479: 
480:         *-- Label Descricao (Say1 legado: Top=86+29=115, Left=210)
481:         loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
482:         WITH loc_oPagina.lbl_4c_Descricao
483:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
484:             .Top       = 115
485:             .Left      = 210
486:             .Width     = 60
487:             .Height    = 17
488:             .FontName  = "Tahoma"
489:             .FontSize  = 8
490:             .ForeColor = RGB(90, 90, 90)
491:             .BackStyle = 0
492:             .Alignment = 1
493:             .Visible   = .T.
494:         ENDWITH
495: 
496:         *-- TextBox Descricao (Get_Desc legado: Top=82+29=111, Left=267, Width=150)
497:         *-- MaxLength=30 conforme SigCdReg.descs char(30)
498:         loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
499:         WITH loc_oPagina.txt_4c_Descricao
500:             .Value     = ""
501:             .Top       = 111
502:             .Left      = 267
503:             .Width     = 150
504:             .Height    = 23
505:             .FontName  = "Tahoma"
506:             .FontSize  = 8
507:             .MaxLength = 30
508:             .ReadOnly  = .F.
509:             .Visible   = .T.
510:         ENDWITH
511: 
512:         *-- Label Municipios (Say3 legado: Top=128+29=157, Left=54, Width=189, Height=15)
513:         loc_oPagina.AddObject("lbl_4c_Municipios", "Label")
514:         WITH loc_oPagina.lbl_4c_Municipios
515:             .Caption   = "Munic" + CHR(237) + "pios pertencentes a regi" + CHR(227) + "o"
516:             .Top       = 157
517:             .Left      = 54
518:             .Width     = 189

*-- Linhas 573 a 1689:
573:             .Column2.Header1.Caption     = "Munic" + CHR(237) + "pio"
574:             .Visible            = .T.
575:         ENDWITH
576:         BINDEVENT(loc_oPagina.grd_4c_Municipios, "AfterRowColChange", THIS, ;
577:             "GradMuniAfterRowColChange")
578: 
579:         *-- Botao Inserir Municipio (inserir legado: Top=324+29=353, Left=414, 45x45)
580:         loc_oPagina.AddObject("cmd_4c_InserirMun", "CommandButton")
581:         WITH loc_oPagina.cmd_4c_InserirMun
582:             .Top             = 353
583:             .Left            = 414
584:             .Width           = 40
585:             .Height          = 40
586:             .Caption         = ""
587:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
588:             .PicturePosition = 14
589:             .SpecialEffect   = 0
590:             .MousePointer    = 15
591:             .ToolTipText     = "Inserir Munic" + CHR(237) + "pio"
592:             .Themes          = .F.
593:             .Visible         = .T.
594:         ENDWITH
595:         BINDEVENT(loc_oPagina.cmd_4c_InserirMun, "Click", THIS, "BtnInserirMunClick")
596: 
597:         *-- Botao Excluir Municipio (excluir legado: Top=369+29=398, Left=414, 45x45)
598:         loc_oPagina.AddObject("cmd_4c_ExcluirMun", "CommandButton")
599:         WITH loc_oPagina.cmd_4c_ExcluirMun
600:             .Top             = 398
601:             .Left            = 414
602:             .Width           = 40
603:             .Height          = 40
604:             .Caption         = ""
605:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
606:             .PicturePosition = 14
607:             .SpecialEffect   = 0
608:             .MousePointer    = 15
609:             .ToolTipText     = "Excluir Munic" + CHR(237) + "pio"
610:             .Themes          = .F.
611:             .Visible         = .T.
612:         ENDWITH
613:         BINDEVENT(loc_oPagina.cmd_4c_ExcluirMun, "Click", THIS, "BtnExcluirMunClick")
614: 
615:         *-- Grid Vendedores (GradVend legado: Top=146+29=175, Left=497, Width=402, Height=438)
616:         *-- RecordSource e ColumnCount FORA do WITH (Problem 36)
617:         *-- ControlSource definido em RebindGridsDetalhe() apos criacao do cursor crVend
618:         loc_oPagina.AddObject("grd_4c_Vendedores", "Grid")
619:         loc_oPagina.grd_4c_Vendedores.RecordSource = ""
620:         loc_oPagina.grd_4c_Vendedores.ColumnCount  = 2
621:         WITH loc_oPagina.grd_4c_Vendedores
622:             .Top                = 175
623:             .Left               = 497
624:             .Width              = 402
625:             .Height             = 438
626:             .FontName           = "Tahoma"
627:             .FontSize           = 8
628:             .ForeColor          = RGB(90, 90, 90)
629:             .BackColor          = RGB(255, 255, 255)
630:             .GridLineColor      = RGB(238, 238, 238)
631:             .HighlightBackColor = RGB(255, 255, 255)
632:             .HighlightForeColor = RGB(15, 41, 104)
633:             .HighlightStyle     = 2
634:             .RecordMark         = .F.
635:             .DeleteMark         = .F.
636:             .HeaderHeight       = 20
637:             .RowHeight          = 18
638:             .ScrollBars         = 2
639:             .GridLines          = 3
640:             .AllowHeaderSizing  = .F.
641:             .AllowRowSizing     = .F.
642:             .Column1.Width               = 90
643:             .Column2.Width               = 290
644:             .Column1.Header1.Caption     = "C" + CHR(243) + "digo"
645:             .Column2.Header1.Caption     = "Nome do Vendedor"
646:             .Visible            = .T.
647:         ENDWITH
648:         BINDEVENT(loc_oPagina.grd_4c_Vendedores, "AfterRowColChange", THIS, ;
649:             "GradVendAfterRowColChange")
650: 
651:         *-- Botao Inserir Vendedor (InserirV legado: Top=324+29=353, Left=903, 45x45)
652:         loc_oPagina.AddObject("cmd_4c_InserirVend", "CommandButton")
653:         WITH loc_oPagina.cmd_4c_InserirVend
654:             .Top             = 353
655:             .Left            = 903
656:             .Width           = 40
657:             .Height          = 40
658:             .Caption         = ""
659:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
660:             .PicturePosition = 14
661:             .SpecialEffect   = 0
662:             .MousePointer    = 15
663:             .ToolTipText     = "Inserir Vendedor"
664:             .Themes          = .F.
665:             .Visible         = .T.
666:         ENDWITH
667:         BINDEVENT(loc_oPagina.cmd_4c_InserirVend, "Click", THIS, "BtnInserirVendClick")
668: 
669:         *-- Botao Excluir Vendedor (ExcluirV legado: Top=369+29=398, Left=903, 45x45)
670:         loc_oPagina.AddObject("cmd_4c_ExcluirVend", "CommandButton")
671:         WITH loc_oPagina.cmd_4c_ExcluirVend
672:             .Top             = 398
673:             .Left            = 903
674:             .Width           = 40
675:             .Height          = 40
676:             .Caption         = ""
677:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
678:             .PicturePosition = 14
679:             .SpecialEffect   = 0
680:             .MousePointer    = 15
681:             .ToolTipText     = "Excluir Vendedor"
682:             .Themes          = .F.
683:             .Visible         = .T.
684:         ENDWITH
685:         BINDEVENT(loc_oPagina.cmd_4c_ExcluirVend, "Click", THIS, "BtnExcluirVendClick")
686: 
687:         THIS.TornarControlesVisiveis(loc_oPagina)
688:     ENDPROC
689: 
690:     *==========================================================================
691:     * CarregarLista - Carrega dados no grid da Page1
692:     * BO.Buscar() cria cursor_4c_Dados com: regiaos, descs, skchaves
693:     * ControlSource APOS RecordSource (Problem 36) + headers reconfigurados (Problem 32)
694:     *==========================================================================
695:     PROCEDURE CarregarLista()
696:         LOCAL loc_lSucesso, loc_oGrid
697:         loc_lSucesso = .F.
698: 
699:         TRY
700:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
701:                 loc_lSucesso = .T.
702:             ELSE
703:                 IF THIS.this_oBusinessObject.Buscar("")
704:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
705: 
706:                     *-- RecordSource e ColumnCount antes das colunas (Problem 36)
707:                     loc_oGrid.ColumnCount = 2
708:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
709:                     loc_oGrid.ColumnCount  = 2
710: 
711:                     *-- ControlSource APOS RecordSource
712:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.regiaos"
713:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
714: 
715:                     loc_oGrid.Column1.Width = 100
716:                     loc_oGrid.Column2.Width = 400
717: 
718:                     *-- Reconfigurar headers: VFP9 os reseta ao mudar RecordSource (Problem 32)
719:                     loc_oGrid.Column1.Header1.Caption = "Regi" + CHR(245) + "es"
720:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
721: 
722:                     THIS.FormatarGridLista(loc_oGrid)
723:                     loc_oGrid.Refresh()
724:                     loc_lSucesso = .T.
725:                 ENDIF
726:             ENDIF
727:         CATCH TO loException
728:             MostrarErro(loException, "FormReg.CarregarLista")
729:         ENDTRY
730: 
731:         RETURN loc_lSucesso
732:     ENDPROC
733: 
734:     *==========================================================================
735:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
736:     * Itera Pages de PageFrames E Controls de Containers
737:     *==========================================================================
738:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
739:         LOCAL loc_nI, loc_oObjeto, loc_nP
740: 
741:         FOR loc_nI = 1 TO par_oContainer.ControlCount
742:             loc_oObjeto = par_oContainer.Controls(loc_nI)
743: 
744:             IF VARTYPE(loc_oObjeto) = "O"
745:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
746:                     loc_oObjeto.Visible = .T.
747:                 ENDIF
748: 
749:                 *-- Trata PageFrame: itera Pages explicitamente
750:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
751:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
752:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
753:                     ENDFOR
754:                 ENDIF
755: 
756:                 *-- Recursao para containers com ControlCount
757:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
758:                     THIS.TornarControlesVisiveis(loc_oObjeto)
759:                 ENDIF
760:             ENDIF
761:         ENDFOR
762:     ENDPROC
763: 
764:     *==========================================================================
765:     * FormatarGridLista - Formata visual do grid da lista
766:     *==========================================================================
767:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
768:         WITH par_oGrid
769:             .FontName = "Verdana"
770:             .FontSize = 8
771:         ENDWITH
772:     ENDPROC
773: 
774:     *==========================================================================
775:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
776:     * Ao voltar para Page1 recarrega o grid automaticamente
777:     *==========================================================================
778:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
779:         LOCAL loc_lSucesso
780:         loc_lSucesso = .F.
781: 
782:         TRY
783:             IF VARTYPE(par_nPagina) != "N" OR !INLIST(par_nPagina, 1, 2)
784:                 loc_lSucesso = .F.
785:             ELSE
786:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
787:                 IF par_nPagina = 1
788:                     THIS.CarregarLista()
789:                 ENDIF
790:                 loc_lSucesso = .T.
791:             ENDIF
792:         CATCH TO loException
793:             MostrarErro(loException, "FormReg.AlternarPagina")
794:         ENDTRY
795: 
796:         RETURN loc_lSucesso
797:     ENDPROC
798: 
799:     *==========================================================================
800:     * BtnIncluirClick - Prepara form para incluir nova regiao
801:     * Metodos de Page2 (LimparCampos/HabilitarCampos/AjustarBotoesPorModo) sao
802:     * guardados com PEMSTATUS pois sao adicionados em fase posterior
803:     *==========================================================================
804:     PROCEDURE BtnIncluirClick()
805:         TRY
806:             THIS.this_oBusinessObject.NovoRegistro()
807:             THIS.this_cModoAtual = "INCLUIR"
808:             IF PEMSTATUS(THIS, "LimparCampos", 5)
809:                 THIS.LimparCampos()
810:             ENDIF
811:             IF PEMSTATUS(THIS, "HabilitarCampos", 5)
812:                 THIS.HabilitarCampos(.T.)
813:             ENDIF
814:             IF PEMSTATUS(THIS, "AjustarBotoesPorModo", 5)
815:                 THIS.AjustarBotoesPorModo()
816:             ENDIF
817:             THIS.pgf_4c_Paginas.ActivePage = 2
818:         CATCH TO loException
819:             MostrarErro(loException, "FormReg.BtnIncluirClick")
820:         ENDTRY
821:     ENDPROC
822: 
823:     *==========================================================================
824:     * BtnVisualizarClick - Visualiza regiao selecionada (somente leitura)
825:     * Tambem ativado pelo DblClick no grid
826:     *==========================================================================
827:     PROCEDURE BtnVisualizarClick()
828:         LOCAL loc_cCodigo
829:         TRY
830:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 ;
831:                OR EOF("cursor_4c_Dados")
832:                 MsgAviso("Selecione uma regi" + CHR(227) + "o na lista.", "Visualizar")
833:             ELSE
834:                 SELECT cursor_4c_Dados
835:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.regiaos)
836:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
837:                     THIS.this_cModoAtual = "VISUALIZAR"
838:                     IF PEMSTATUS(THIS, "BOParaForm", 5)
839:                         THIS.BOParaForm()
840:                     ENDIF
841:                     IF PEMSTATUS(THIS, "HabilitarCampos", 5)
842:                         THIS.HabilitarCampos(.F.)
843:                     ENDIF
844:                     IF PEMSTATUS(THIS, "AjustarBotoesPorModo", 5)
845:                         THIS.AjustarBotoesPorModo()
846:                     ENDIF
847:                     THIS.pgf_4c_Paginas.ActivePage = 2
848:                 ENDIF
849:             ENDIF
850:         CATCH TO loException
851:             MostrarErro(loException, "FormReg.BtnVisualizarClick")
852:         ENDTRY
853:     ENDPROC
854: 
855:     *==========================================================================
856:     * BtnAlterarClick - Carrega regiao selecionada para edicao
857:     *==========================================================================
858:     PROCEDURE BtnAlterarClick()
859:         LOCAL loc_cCodigo
860:         TRY
861:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 ;
862:                OR EOF("cursor_4c_Dados")
863:                 MsgAviso("Selecione uma regi" + CHR(227) + "o na lista.", "Alterar")
864:             ELSE
865:                 SELECT cursor_4c_Dados
866:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.regiaos)
867:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
868:                     THIS.this_oBusinessObject.EditarRegistro()
869:                     THIS.this_cModoAtual = "ALTERAR"
870:                     IF PEMSTATUS(THIS, "BOParaForm", 5)
871:                         THIS.BOParaForm()
872:                     ENDIF
873:                     IF PEMSTATUS(THIS, "HabilitarCampos", 5)
874:                         THIS.HabilitarCampos(.T.)
875:                     ENDIF
876:                     IF PEMSTATUS(THIS, "AjustarBotoesPorModo", 5)
877:                         THIS.AjustarBotoesPorModo()
878:                     ENDIF
879:                     THIS.pgf_4c_Paginas.ActivePage = 2
880:                 ENDIF
881:             ENDIF
882:         CATCH TO loException
883:             MostrarErro(loException, "FormReg.BtnAlterarClick")
884:         ENDTRY
885:     ENDPROC
886: 
887:     *==========================================================================
888:     * BtnExcluirClick - Exclui regiao selecionada apos confirmacao
889:     * Totalmente funcional: BO.CarregarPorCodigo + Excluir + CarregarLista
890:     *==========================================================================
891:     PROCEDURE BtnExcluirClick()
892:         LOCAL loc_cCodigo
893:         TRY
894:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 ;
895:                OR EOF("cursor_4c_Dados")
896:                 MsgAviso("Selecione uma regi" + CHR(227) + "o na lista.", "Excluir")
897:             ELSE
898:                 SELECT cursor_4c_Dados
899:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.regiaos)
900:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da regi" + ;
901:                                CHR(227) + "o '" + loc_cCodigo + "'?", "Excluir")
902:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
903:                         IF THIS.this_oBusinessObject.Excluir()
904:                             MsgInfo("Regi" + CHR(227) + "o exclu" + CHR(237) + ;
905:                                     "da com sucesso!", "Excluir")
906:                             THIS.CarregarLista()
907:                         ENDIF
908:                     ENDIF
909:                 ENDIF
910:             ENDIF
911:         CATCH TO loException
912:             MostrarErro(loException, "FormReg.BtnExcluirClick")
913:         ENDTRY
914:     ENDPROC
915: 
916:     *==========================================================================
917:     * BtnBuscarClick - Abre FormBuscaAuxiliar para selecionar regiao na lista
918:     * Posiciona o grid no registro selecionado apos a busca
919:     *==========================================================================
920:     PROCEDURE BtnBuscarClick()
921:         LOCAL loc_oBusca, loc_cCodigo
922:         TRY
923:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
924:                 "SigCdReg", "cursor_4c_BuscaReg", "regiaos", "", ;
925:                 "Buscar Regi" + CHR(245) + "es")
926: 
927:             IF VARTYPE(loc_oBusca) = "O"
928:                 IF !loc_oBusca.this_lAchouRegistro
929:                     loc_oBusca.mAddColuna("regiaos", "", "Regi" + CHR(245) + "es")
930:                     loc_oBusca.mAddColuna("descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
931:                     loc_oBusca.Show()
932:                 ENDIF
933: 
934:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaReg")
935:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaReg.regiaos)
936:                     IF USED("cursor_4c_Dados")
937:                         SELECT cursor_4c_Dados
938:                         LOCATE FOR ALLTRIM(regiaos) = loc_cCodigo
939:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
940:                     ENDIF
941:                 ENDIF
942: 
943:                 IF USED("cursor_4c_BuscaReg")
944:                     USE IN cursor_4c_BuscaReg
945:                 ENDIF
946:                 loc_oBusca.Release()
947:             ENDIF
948:         CATCH TO loException
949:             MostrarErro(loException, "FormReg.BtnBuscarClick")
950:         ENDTRY
951:     ENDPROC
952: 
953:     *==========================================================================
954:     * BtnEncerrarClick - Fecha o formulario
955:     *==========================================================================
956:     PROCEDURE BtnEncerrarClick()
957:         THIS.Release()
958:     ENDPROC
959: 
960:     *==========================================================================
961:     * BtnSalvarClick - Salva regiao: validacao fora do TRY, FormParaBO + Salvar()
962:     * BO.Inserir() gera skchaves e chama InserirFilhos (crMuni+crVend)
963:     * BO.Atualizar() rebuilda SigCdRgi a partir de crMuni+crVend
964:     *==========================================================================
965:     PROCEDURE BtnSalvarClick()
966:         LOCAL loc_lSucesso, loc_oPagina2
967:         loc_lSucesso = .F.
968:         loc_oPagina2 = THIS.pgf_4c_Paginas.Page2
969: 
970:         *-- Validacoes FORA do TRY (REGRA CRITICA - Problem 16)
971:         IF EMPTY(ALLTRIM(loc_oPagina2.txt_4c_Codigo.Value))
972:             MsgAviso("C" + CHR(243) + "digo da regi" + CHR(227) + "o " + ;
973:                      CHR(233) + " obrigat" + CHR(243) + "rio.", "Salvar")
974:             loc_oPagina2.txt_4c_Codigo.SetFocus
975:             RETURN
976:         ENDIF
977:         IF EMPTY(ALLTRIM(loc_oPagina2.txt_4c_Descricao.Value))
978:             MsgAviso("Descri" + CHR(231) + CHR(227) + "o da regi" + CHR(227) + ;
979:                      "o " + CHR(233) + " obrigat" + CHR(243) + "ria.", "Salvar")
980:             loc_oPagina2.txt_4c_Descricao.SetFocus
981:             RETURN
982:         ENDIF
983: 
984:         TRY
985:             THIS.FormParaBO()
986:             loc_lSucesso = THIS.this_oBusinessObject.Salvar()
987:             IF loc_lSucesso
988:                 MsgInfo("Regi" + CHR(227) + "o salva com sucesso!", "Salvar")
989:                 THIS.this_cModoAtual = "LISTA"
990:                 THIS.AlternarPagina(1)
991:             ENDIF
992:         CATCH TO loException
993:             MostrarErro(loException, "FormReg.BtnSalvarClick")
994:         ENDTRY
995:     ENDPROC
996: 
997:     *==========================================================================
998:     * BtnCancelarClick - Cancela edicao e retorna para a lista
999:     * AlternarPagina(1) ja chama CarregarLista() automaticamente
1000:     *==========================================================================
1001:     PROCEDURE BtnCancelarClick()
1002:         TRY
1003:             THIS.this_cModoAtual = "LISTA"
1004:             THIS.AlternarPagina(1)
1005:         CATCH TO loException
1006:             MostrarErro(loException, "FormReg.BtnCancelarClick")
1007:         ENDTRY
1008:     ENDPROC
1009: 
1010:     *==========================================================================
1011:     * ValidarCodigo - Verifica duplicidade ao sair de txt_4c_Codigo (INCLUIR)
1012:     * Ativado via BINDEVENT LostFocus
1013:     *==========================================================================
1014:     PROCEDURE ValidarCodigo(par_nKeyCode, par_nShiftAltCtrl)
1015:         LOCAL loc_cCodigo, loc_oPagina2, loc_cSQL, loc_nResult
1016:         loc_oPagina2 = THIS.pgf_4c_Paginas.Page2
1017:         loc_cCodigo  = ALLTRIM(loc_oPagina2.txt_4c_Codigo.Value)
1018: 
1019:         TRY
1020:             IF !EMPTY(loc_cCodigo) AND THIS.this_cModoAtual = "INCLUIR"
1021:                 loc_cSQL    = "SELECT COUNT(*) AS qtde FROM SigCdReg" + ;
1022:                               " WHERE regiaos = " + EscaparSQL(loc_cCodigo)
1023:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkReg")
1024:                 IF loc_nResult > 0 AND USED("cursor_4c_ChkReg")
1025:                     SELECT cursor_4c_ChkReg
1026:                     IF cursor_4c_ChkReg.qtde > 0
1027:                         MsgAviso("Regi" + CHR(227) + "o '" + loc_cCodigo + ;
1028:                                  "' j" + CHR(225) + " cadastrada!", "Validar")
1029:                         loc_oPagina2.txt_4c_Codigo.Value = ""
1030:                         loc_oPagina2.txt_4c_Codigo.SetFocus
1031:                     ENDIF
1032:                 ENDIF
1033:                 IF USED("cursor_4c_ChkReg")
1034:                     USE IN cursor_4c_ChkReg
1035:                 ENDIF
1036:             ENDIF
1037:         CATCH TO loException
1038:             MostrarErro(loException, "FormReg.ValidarCodigo")
1039:         ENDTRY
1040:     ENDPROC
1041: 
1042:     *==========================================================================
1043:     * FormParaBO - Transfere valores do formulario para o Business Object
1044:     * Chamado antes de Salvar(); crMuni e crVend ja refletem estado dos grids
1045:     *==========================================================================
1046:     PROTECTED PROCEDURE FormParaBO()
1047:         LOCAL loc_oPagina2
1048:         loc_oPagina2 = THIS.pgf_4c_Paginas.Page2
1049: 
1050:         THIS.this_oBusinessObject.this_cRegiaos = ;
1051:             ALLTRIM(loc_oPagina2.txt_4c_Codigo.Value)
1052:         THIS.this_oBusinessObject.this_cDescs   = ;
1053:             ALLTRIM(loc_oPagina2.txt_4c_Descricao.Value)
1054:     ENDPROC
1055: 
1056:     *==========================================================================
1057:     * BOParaForm - Transfere Business Object para o formulario
1058:     * Carrega tambem crMuni e crVend via BO (usados pelos grids da Fase 6)
1059:     *==========================================================================
1060:     PROTECTED PROCEDURE BOParaForm()
1061:         LOCAL loc_oPagina2, loc_cSkChaves
1062:         loc_oPagina2  = THIS.pgf_4c_Paginas.Page2
1063:         loc_cSkChaves = ALLTRIM(THIS.this_oBusinessObject.this_cSkChaves)
1064: 
1065:         loc_oPagina2.txt_4c_Codigo.Value    = ;
1066:             ALLTRIM(THIS.this_oBusinessObject.this_cRegiaos)
1067:         loc_oPagina2.txt_4c_Descricao.Value = ;
1068:             ALLTRIM(THIS.this_oBusinessObject.this_cDescs)
1069: 
1070:         *-- Carrega cursores para os grids (Fase 6 vincula RecordSource)
1071:         THIS.this_oBusinessObject.BuscarMunicipios(loc_cSkChaves)
1072:         THIS.this_oBusinessObject.BuscarVendedores(loc_cSkChaves)
1073: 
1074:         *-- Rebind grids apos recreacao dos cursores (Problem 36/32)
1075:         THIS.RebindGridsDetalhe()
1076:     ENDPROC
1077: 
1078:     *==========================================================================
1079:     * LimparCampos - Limpa campos da Page2 e recria cursores vazios
1080:     * crMuni e crVend vazios (1 linha em branco) prontos para o usuario preencher
1081:     *==========================================================================
1082:     PROTECTED PROCEDURE LimparCampos()
1083:         LOCAL loc_oPagina2
1084:         loc_oPagina2 = THIS.pgf_4c_Paginas.Page2
1085: 
1086:         loc_oPagina2.txt_4c_Codigo.Value    = ""
1087:         loc_oPagina2.txt_4c_Descricao.Value = ""
1088: 
1089:         *-- Reinicializa cursores de detalhe vazios (BuscarMunicipios("") cria cursor + 1 blank)
1090:         IF USED("crMuni")
1091:             USE IN crMuni
1092:         ENDIF
1093:         IF USED("crVend")
1094:             USE IN crVend
1095:         ENDIF
1096:         THIS.this_oBusinessObject.BuscarMunicipios("")
1097:         THIS.this_oBusinessObject.BuscarVendedores("")
1098:         THIS.RebindGridsDetalhe()
1099:     ENDPROC
1100: 
1101:     *==========================================================================
1102:     * HabilitarCampos - Habilita ou desabilita campos da Page2 conforme modo
1103:     * par_lHabilitar: .T. = editavel (INCLUIR/ALTERAR), .F. = readonly (VISUALIZAR)
1104:     * Codigo somente editavel no INCLUIR; no ALTERAR eh readonly (chave primaria)
1105:     *==========================================================================
1106:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1107:         LOCAL loc_oPagina2
1108:         loc_oPagina2 = THIS.pgf_4c_Paginas.Page2
1109: 
1110:         *-- Codigo: editavel apenas no INCLUIR (chave nao pode mudar no ALTERAR)
1111:         loc_oPagina2.txt_4c_Codigo.ReadOnly = ;
1112:             !par_lHabilitar OR THIS.this_cModoAtual = "ALTERAR"
1113:         loc_oPagina2.txt_4c_Descricao.ReadOnly = !par_lHabilitar
1114: 
1115:         *-- Grids e botoes de detalhe (Fase 6)
1116:         IF PEMSTATUS(loc_oPagina2, "grd_4c_Municipios", 5)
1117:             loc_oPagina2.grd_4c_Municipios.ReadOnly = !par_lHabilitar
1118:         ENDIF
1119:         IF PEMSTATUS(loc_oPagina2, "grd_4c_Vendedores", 5)
1120:             loc_oPagina2.grd_4c_Vendedores.ReadOnly = !par_lHabilitar
1121:         ENDIF
1122:         IF PEMSTATUS(loc_oPagina2, "cmd_4c_InserirMun", 5)
1123:         ENDIF
1124:         IF PEMSTATUS(loc_oPagina2, "cmd_4c_InserirVend", 5)
1125:         ENDIF
1126:     ENDPROC
1127: 
1128:     *==========================================================================
1129:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme this_cModoAtual
1130:     * VISUALIZAR: Confirmar disabled; INCLUIR/ALTERAR: ambos enabled
1131:     *==========================================================================
1132:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1133:         LOCAL loc_oPagina2, loc_lEditando
1134:         loc_oPagina2  = THIS.pgf_4c_Paginas.Page2
1135:         loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1136: 
1137:         WITH loc_oPagina2.cnt_4c_BotoesAcao
1138:             .cmd_4c_Confirmar.Enabled = loc_lEditando
1139:             .cmd_4c_Cancelar.Enabled  = .T.
1140:             .Visible     = .T.
1141:         ENDWITH
1142:     ENDPROC
1143: 
1144:     *==========================================================================
1145:     * Destroy - Libera recursos ao fechar o formulario
1146:     *==========================================================================
1147:     PROCEDURE Destroy()
1148:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1149:             THIS.this_oBusinessObject = .NULL.
1150:         ENDIF
1151: 
1152:         IF USED("cursor_4c_Dados")
1153:             USE IN cursor_4c_Dados
1154:         ENDIF
1155:         IF USED("crMuni")
1156:             USE IN crMuni
1157:         ENDIF
1158:         IF USED("crVend")
1159:             USE IN crVend
1160:         ENDIF
1161: 
1162:         DODEFAULT()
1163:     ENDPROC
1164: 
1165:     *==========================================================================
1166:     * RebindGridsDetalhe - Revincula grids apos recreacao dos cursores crMuni/crVend
1167:     * Problem 36: RecordSource/ColumnCount fora de WITH
1168:     * Problem 32: headers precisam ser re-especificados apos mudar RecordSource
1169:     *==========================================================================
1170:     PROTECTED PROCEDURE RebindGridsDetalhe()
1171:         LOCAL loc_oPagina2, loc_oGridMuni, loc_oGridVend, loc_oErro
1172:         loc_oPagina2 = THIS.pgf_4c_Paginas.Page2
1173: 
1174:         TRY
1175:             IF PEMSTATUS(loc_oPagina2, "grd_4c_Municipios", 5) AND USED("crMuni")
1176:                 loc_oGridMuni = loc_oPagina2.grd_4c_Municipios
1177:                 loc_oGridMuni.RecordSource = ""
1178:                 loc_oGridMuni.RecordSource = "crMuni"
1179:                 loc_oGridMuni.ColumnCount  = 2
1180:                 loc_oGridMuni.Column1.ControlSource   = "crMuni.uf"
1181:                 loc_oGridMuni.Column2.ControlSource   = "crMuni.munici"
1182:                 loc_oGridMuni.Column1.Width            = 24
1183:                 loc_oGridMuni.Column2.Width            = 312
1184:                 loc_oGridMuni.Column1.Header1.Caption  = "UF"
1185:                 loc_oGridMuni.Column2.Header1.Caption  = "Munic" + CHR(237) + "pio"
1186:                 loc_oGridMuni.Refresh()
1187:             ENDIF
1188: 
1189:             IF PEMSTATUS(loc_oPagina2, "grd_4c_Vendedores", 5) AND USED("crVend")
1190:                 loc_oGridVend = loc_oPagina2.grd_4c_Vendedores
1191:                 loc_oGridVend.RecordSource = ""
1192:                 loc_oGridVend.RecordSource = "crVend"
1193:                 loc_oGridVend.ColumnCount  = 2
1194:                 loc_oGridVend.Column1.ControlSource   = "crVend.iclis"
1195:                 loc_oGridVend.Column2.ControlSource   = "crVend.vend"
1196:                 loc_oGridVend.Column1.Width            = 90
1197:                 loc_oGridVend.Column2.Width            = 290
1198:                 loc_oGridVend.Column1.Header1.Caption  = "C" + CHR(243) + "digo"
1199:                 loc_oGridVend.Column2.Header1.Caption  = "Nome do Vendedor"
1200:                 loc_oGridVend.Refresh()
1201:             ENDIF
1202:         CATCH TO loc_oErro
1203:             MsgErro(loc_oErro.Message, "Erro ao vincular grids de detalhe")
1204:         ENDTRY
1205:     ENDPROC
1206: 
1207:     *==========================================================================
1208:     * GradMuniAfterRowColChange - Valida celula ao navegar no grid de Municipios
1209:     * PUBLIC: BINDEVENT exige metodo publico
1210:     * par_nColIndex: coluna ANTERIOR ao movimento (1=saiu da coluna UF, 2=saiu da coluna Municipio)
1211:     *==========================================================================
1212:     PROCEDURE GradMuniAfterRowColChange(par_nColIndex)
1213:         LOCAL loc_oErro
1214:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1215:             RETURN
1216:         ENDIF
1217:         IF !USED("crMuni") OR EOF("crMuni")
1218:             RETURN
1219:         ENDIF
1220:         TRY
1221:             DO CASE
1222:                 CASE par_nColIndex = 1
1223:                     THIS.ValidarUFMuni()
1224:                 CASE par_nColIndex = 2
1225:                     THIS.ValidarMuniMuni()
1226:             ENDCASE
1227:         CATCH TO loc_oErro
1228:             MsgErro(loc_oErro.Message, "Erro ao validar munic" + CHR(237) + "pio")
1229:         ENDTRY
1230:     ENDPROC
1231: 
1232:     *==========================================================================
1233:     * ValidarUFMuni - Valida e normaliza campo UF no cursor crMuni
1234:     * Lookup exato em SigCdUfs; se nao encontrado, abre FormBuscaAuxiliar (picker)
1235:     *==========================================================================
1236:     PROTECTED PROCEDURE ValidarUFMuni()
1237:         LOCAL loc_lResultado, loc_cUF, loc_nResult, loc_oBusca, loc_oErro
1238:         loc_lResultado = .T.
1239: 
1240:         TRY
1241:             loc_cUF = ALLTRIM(crMuni.uf)
1242:             IF !EMPTY(loc_cUF)
1243:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1244:                     "SELECT TOP 1 estados, descrs FROM SigCdUfs " + ;
1245:                     "WHERE estados = " + EscaparSQL(loc_cUF), ;
1246:                     "cursor_4c_UfLocal")
1247:                 IF loc_nResult > 0 AND USED("cursor_4c_UfLocal") AND !EOF("cursor_4c_UfLocal")
1248:                     REPLACE crMuni.uf WITH ALLTRIM(cursor_4c_UfLocal.estados) IN crMuni
1249:                     IF USED("cursor_4c_UfLocal")
1250:                         USE IN cursor_4c_UfLocal
1251:                     ENDIF
1252:                 ELSE
1253:                     IF USED("cursor_4c_UfLocal")
1254:                         USE IN cursor_4c_UfLocal
1255:                     ENDIF
1256:                     *-- Nao encontrado: abre picker com todos os estados
1257:                     loc_nResult = SQLEXEC(gnConnHandle, ;
1258:                         "SELECT estados, descrs FROM SigCdUfs ORDER BY estados", ;
1259:                         "cursor_4c_UfLocal")
1260:                     IF loc_nResult > 0 AND USED("cursor_4c_UfLocal")
1261:                         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1262:                         loc_oBusca.DefinirCursor("cursor_4c_UfLocal", "estados", "descrs", ;
1263:                             "Selecionar UF")
1264:                         loc_oBusca.Mostrar()
1265:                         IF loc_oBusca.this_lSelecionou
1266:                             REPLACE crMuni.uf WITH ;
1267:                                 ALLTRIM(loc_oBusca.cCodigoSelecionado) IN crMuni
1268:                         ELSE
1269:                             REPLACE crMuni.uf WITH "" IN crMuni
1270:                             loc_lResultado = .F.
1271:                         ENDIF
1272:                         loc_oBusca.Release()
1273:                         loc_oBusca = .NULL.
1274:                         IF USED("cursor_4c_UfLocal")
1275:                             USE IN cursor_4c_UfLocal
1276:                         ENDIF
1277:                     ELSE
1278:                         MsgErro("Erro ao consultar estados.", "Erro UF")
1279:                         REPLACE crMuni.uf WITH "" IN crMuni
1280:                         loc_lResultado = .F.
1281:                     ENDIF
1282:                 ENDIF
1283:             ENDIF
1284:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Municipios", 5)
1285:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Municipios.Refresh()
1286:             ENDIF
1287:         CATCH TO loc_oErro
1288:             IF USED("cursor_4c_UfLocal")
1289:                 USE IN cursor_4c_UfLocal
1290:             ENDIF
1291:             IF VARTYPE(loc_oBusca) = "O"
1292:                 loc_oBusca.Release()
1293:                 loc_oBusca = .NULL.
1294:             ENDIF
1295:             MsgErro(loc_oErro.Message, "Erro ao validar UF")
1296:             loc_lResultado = .F.
1297:         ENDTRY
1298:         RETURN loc_lResultado
1299:     ENDPROC
1300: 
1301:     *==========================================================================
1302:     * ValidarMuniMuni - Valida e normaliza campo munici no cursor crMuni
1303:     * Lookup em SigCdMun filtrado pela UF corrente; atualiza crMuni.codibges
1304:     *==========================================================================
1305:     PROTECTED PROCEDURE ValidarMuniMuni()
1306:         LOCAL loc_lResultado, loc_cMuni, loc_cUF, loc_nResult, loc_cSQL
1307:         LOCAL loc_oBusca, loc_oErro
1308:         loc_lResultado = .T.
1309: 
1310:         TRY
1311:             loc_cMuni = ALLTRIM(crMuni.munici)
1312:             loc_cUF   = ALLTRIM(crMuni.uf)
1313: 
1314:             IF !EMPTY(loc_cMuni)
1315:                 *-- Busca exata/parcial em SigCdMun filtrada pela UF
1316:                 loc_cSQL = "SELECT TOP 1 m.codigos AS codibges, m.descs AS munici" + ;
1317:                     " FROM SigCdMun m" + ;
1318:                     " INNER JOIN SigCdUfs u ON u.ufibges = m.ufibges"
1319:                 IF !EMPTY(loc_cUF)
1320:                     loc_cSQL = loc_cSQL + " WHERE u.estados = " + EscaparSQL(loc_cUF) + ;
1321:                         " AND m.codigos = " + EscaparSQL(loc_cMuni)
1322:                 ELSE
1323:                     loc_cSQL = loc_cSQL + ;
1324:                         " WHERE m.codigos = " + EscaparSQL(loc_cMuni)
1325:                 ENDIF
1326:                 loc_cSQL = loc_cSQL + " ORDER BY m.descs"
1327: 
1328:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MuniLocal")
1329:                 IF loc_nResult > 0 AND USED("cursor_4c_MuniLocal") AND !EOF("cursor_4c_MuniLocal")
1330:                     REPLACE crMuni.codibges WITH ;
1331:                         ALLTRIM(cursor_4c_MuniLocal.codibges) IN crMuni
1332:                     REPLACE crMuni.munici WITH ;
1333:                         ALLTRIM(cursor_4c_MuniLocal.munici) IN crMuni
1334:                     IF USED("cursor_4c_MuniLocal")
1335:                         USE IN cursor_4c_MuniLocal
1336:                     ENDIF
1337:                     THIS.ValidarDuplicadosMuni()
1338:                 ELSE
1339:                     IF USED("cursor_4c_MuniLocal")
1340:                         USE IN cursor_4c_MuniLocal
1341:                     ENDIF
1342:                     *-- Nao encontrado: abre picker filtrado pela UF
1343:                     loc_cSQL = "SELECT m.codigos AS codibges, m.descs AS munici" + ;
1344:                         " FROM SigCdMun m" + ;
1345:                         " INNER JOIN SigCdUfs u ON u.ufibges = m.ufibges"
1346:                     IF !EMPTY(loc_cUF)
1347:                         loc_cSQL = loc_cSQL + " WHERE u.estados = " + EscaparSQL(loc_cUF)
1348:                     ENDIF
1349:                     loc_cSQL = loc_cSQL + " ORDER BY m.descs"
1350: 
1351:                     loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MuniLocal")
1352:                     IF loc_nResult > 0 AND USED("cursor_4c_MuniLocal")
1353:                         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1354:                         loc_oBusca.DefinirCursor("cursor_4c_MuniLocal", "codibges", "munici", ;
1355:                             "Selecionar Munic" + CHR(237) + "pio")
1356:                         loc_oBusca.Mostrar()
1357:                         IF loc_oBusca.this_lSelecionou
1358:                             REPLACE crMuni.codibges WITH ;
1359:                                 ALLTRIM(loc_oBusca.cCodigoSelecionado) IN crMuni
1360:                             REPLACE crMuni.munici WITH ;
1361:                                 ALLTRIM(loc_oBusca.cDescricaoSelecionada) IN crMuni
1362:                             THIS.ValidarDuplicadosMuni()
1363:                         ELSE
1364:                             REPLACE crMuni.codibges WITH "" IN crMuni
1365:                             REPLACE crMuni.munici   WITH "" IN crMuni
1366:                             loc_lResultado = .F.
1367:                         ENDIF
1368:                         loc_oBusca.Release()
1369:                         loc_oBusca = .NULL.
1370:                         IF USED("cursor_4c_MuniLocal")
1371:                             USE IN cursor_4c_MuniLocal
1372:                         ENDIF
1373:                     ELSE
1374:                         MsgAviso("Nenhum munic" + CHR(237) + "pio encontrado.", ;
1375:                             "Munic" + CHR(237) + "pio")
1376:                         REPLACE crMuni.codibges WITH "" IN crMuni
1377:                         REPLACE crMuni.munici   WITH "" IN crMuni
1378:                         loc_lResultado = .F.
1379:                     ENDIF
1380:                 ENDIF
1381:             ENDIF
1382:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Municipios", 5)
1383:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Municipios.Refresh()
1384:             ENDIF
1385:         CATCH TO loc_oErro
1386:             IF USED("cursor_4c_MuniLocal")
1387:                 USE IN cursor_4c_MuniLocal
1388:             ENDIF
1389:             IF VARTYPE(loc_oBusca) = "O"
1390:                 loc_oBusca.Release()
1391:                 loc_oBusca = .NULL.
1392:             ENDIF
1393:             MsgErro(loc_oErro.Message, "Erro ao validar munic" + CHR(237) + "pio")
1394:             loc_lResultado = .F.
1395:         ENDTRY
1396:         RETURN loc_lResultado
1397:     ENDPROC
1398: 
1399:     *==========================================================================
1400:     * ValidarDuplicadosMuni - Avisa se ha municipios duplicados em crMuni
1401:     *==========================================================================
1402:     PROTECTED PROCEDURE ValidarDuplicadosMuni()
1403:         LOCAL loc_lResultado, loc_oErro
1404:         loc_lResultado = .T.
1405: 
1406:         TRY
1407:             IF USED("crMuni")
1408:                 SELECT codibges FROM crMuni ;
1409:                     WHERE !EMPTY(ALLTRIM(codibges)) ;
1410:                     GROUP BY codibges ;
1411:                     HAVING SUM(1) > 1 ;
1412:                     INTO CURSOR cursor_4c_DupMuni NOFILTER
1413:                 IF !EOF("cursor_4c_DupMuni")
1414:                     MsgAviso("Munic" + CHR(237) + "pio duplicado detectado na lista.")
1415:                     loc_lResultado = .F.
1416:                 ENDIF
1417:                 IF USED("cursor_4c_DupMuni")
1418:                     USE IN cursor_4c_DupMuni
1419:                 ENDIF
1420:             ENDIF
1421:         CATCH TO loc_oErro
1422:             IF USED("cursor_4c_DupMuni")
1423:                 USE IN cursor_4c_DupMuni
1424:             ENDIF
1425:             MsgErro(loc_oErro.Message, "Erro ao verificar duplicados de munic" + CHR(237) + "pios")
1426:             loc_lResultado = .F.
1427:         ENDTRY
1428:         RETURN loc_lResultado
1429:     ENDPROC
1430: 
1431:     *==========================================================================
1432:     * GradVendAfterRowColChange - Valida celula ao navegar no grid de Vendedores
1433:     * PUBLIC: BINDEVENT exige metodo publico
1434:     * par_nColIndex: coluna ANTERIOR ao movimento (1=saiu da coluna Codigo/iclis)
1435:     *==========================================================================
1436:     PROCEDURE GradVendAfterRowColChange(par_nColIndex)
1437:         LOCAL loc_oErro
1438:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1439:             RETURN
1440:         ENDIF
1441:         IF !USED("crVend") OR EOF("crVend")
1442:             RETURN
1443:         ENDIF
1444:         TRY
1445:             IF par_nColIndex = 1
1446:                 THIS.ValidarCodigoVend()
1447:             ENDIF
1448:         CATCH TO loc_oErro
1449:             MsgErro(loc_oErro.Message, "Erro ao validar vendedor")
1450:         ENDTRY
1451:     ENDPROC
1452: 
1453:     *==========================================================================
1454:     * ValidarCodigoVend - Valida e normaliza campo iclis no cursor crVend
1455:     * Lookup em SigCdCli; preenche automaticamente crVend.vend (razaos)
1456:     *==========================================================================
1457:     PROTECTED PROCEDURE ValidarCodigoVend()
1458:         LOCAL loc_lResultado, loc_cIclis, loc_nResult, loc_oBusca, loc_cSQL, loc_oErro
1459:         loc_lResultado = .T.
1460: 
1461:         TRY
1462:             loc_cIclis = ALLTRIM(crVend.iclis)
1463:             IF !EMPTY(loc_cIclis)
1464:                 *-- Busca exata em SigCdCli
1465:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1466:                     "SELECT TOP 1 iclis, razaos FROM SigCdCli " + ;
1467:                     "WHERE iclis = " + EscaparSQL(loc_cIclis), ;
1468:                     "cursor_4c_VendLocal")
1469:                 IF loc_nResult > 0 AND USED("cursor_4c_VendLocal") AND !EOF("cursor_4c_VendLocal")
1470:                     REPLACE crVend.iclis WITH ALLTRIM(cursor_4c_VendLocal.iclis) IN crVend
1471:                     REPLACE crVend.vend  WITH ALLTRIM(cursor_4c_VendLocal.razaos) IN crVend
1472:                     IF USED("cursor_4c_VendLocal")
1473:                         USE IN cursor_4c_VendLocal
1474:                     ENDIF
1475:                     THIS.ValidarDuplicadosVend()
1476:                 ELSE
1477:                     IF USED("cursor_4c_VendLocal")
1478:                         USE IN cursor_4c_VendLocal
1479:                     ENDIF
1480:                     *-- Nao encontrado exato: busca parcial por codigo ou nome
1481:                     loc_cSQL = "SELECT iclis, razaos FROM SigCdCli " + ;
1482:                         "WHERE iclis LIKE " + EscaparSQL(loc_cIclis + "%") + ;
1483:                         " ORDER BY iclis"
1484:                     loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VendLocal")
1485:                     IF loc_nResult <= 0 OR !USED("cursor_4c_VendLocal") OR ;
1486:                             EOF("cursor_4c_VendLocal")
1487:                         IF USED("cursor_4c_VendLocal")
1488:                             USE IN cursor_4c_VendLocal
1489:                         ENDIF
1490:                         *-- Fallback: mostra todos os clientes
1491:                         loc_nResult = SQLEXEC(gnConnHandle, ;
1492:                             "SELECT iclis, razaos FROM SigCdCli ORDER BY iclis", ;
1493:                             "cursor_4c_VendLocal")
1494:                     ENDIF
1495:                     IF loc_nResult > 0 AND USED("cursor_4c_VendLocal")
1496:                         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1497:                         loc_oBusca.DefinirCursor("cursor_4c_VendLocal", "iclis", "razaos", ;
1498:                             "Selecionar Vendedor")
1499:                         loc_oBusca.Mostrar()
1500:                         IF loc_oBusca.this_lSelecionou
1501:                             REPLACE crVend.iclis WITH ;
1502:                                 ALLTRIM(loc_oBusca.cCodigoSelecionado) IN crVend
1503:                             REPLACE crVend.vend  WITH ;
1504:                                 ALLTRIM(loc_oBusca.cDescricaoSelecionada) IN crVend
1505:                             THIS.ValidarDuplicadosVend()
1506:                         ELSE
1507:                             REPLACE crVend.iclis WITH "" IN crVend
1508:                             REPLACE crVend.vend  WITH "" IN crVend
1509:                             loc_lResultado = .F.
1510:                         ENDIF
1511:                         loc_oBusca.Release()
1512:                         loc_oBusca = .NULL.
1513:                         IF USED("cursor_4c_VendLocal")
1514:                             USE IN cursor_4c_VendLocal
1515:                         ENDIF
1516:                     ELSE
1517:                         MsgAviso("Nenhum vendedor encontrado.")
1518:                         REPLACE crVend.iclis WITH "" IN crVend
1519:                         REPLACE crVend.vend  WITH "" IN crVend
1520:                         loc_lResultado = .F.
1521:                     ENDIF
1522:                 ENDIF
1523:             ENDIF
1524:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Vendedores", 5)
1525:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Vendedores.Refresh()
1526:             ENDIF
1527:         CATCH TO loc_oErro
1528:             IF USED("cursor_4c_VendLocal")
1529:                 USE IN cursor_4c_VendLocal
1530:             ENDIF
1531:             IF VARTYPE(loc_oBusca) = "O"
1532:                 loc_oBusca.Release()
1533:                 loc_oBusca = .NULL.
1534:             ENDIF
1535:             MsgErro(loc_oErro.Message, "Erro ao validar vendedor")
1536:             loc_lResultado = .F.
1537:         ENDTRY
1538:         RETURN loc_lResultado
1539:     ENDPROC
1540: 
1541:     *==========================================================================
1542:     * ValidarDuplicadosVend - Avisa se ha vendedores duplicados em crVend
1543:     *==========================================================================
1544:     PROTECTED PROCEDURE ValidarDuplicadosVend()
1545:         LOCAL loc_lResultado, loc_oErro
1546:         loc_lResultado = .T.
1547: 
1548:         TRY
1549:             IF USED("crVend")
1550:                 SELECT iclis FROM crVend ;
1551:                     WHERE !EMPTY(ALLTRIM(iclis)) ;
1552:                     GROUP BY iclis ;
1553:                     HAVING SUM(1) > 1 ;
1554:                     INTO CURSOR cursor_4c_DupVend NOFILTER
1555:                 IF !EOF("cursor_4c_DupVend")
1556:                     MsgAviso("Vendedor duplicado detectado na lista.")
1557:                     loc_lResultado = .F.
1558:                 ENDIF
1559:                 IF USED("cursor_4c_DupVend")
1560:                     USE IN cursor_4c_DupVend
1561:                 ENDIF
1562:             ENDIF
1563:         CATCH TO loc_oErro
1564:             IF USED("cursor_4c_DupVend")
1565:                 USE IN cursor_4c_DupVend
1566:             ENDIF
1567:             MsgErro(loc_oErro.Message, "Erro ao verificar duplicados de vendedores")
1568:             loc_lResultado = .F.
1569:         ENDTRY
1570:         RETURN loc_lResultado
1571:     ENDPROC
1572: 
1573:     *==========================================================================
1574:     * BtnInserirMunClick - Adiciona linha em branco ao cursor crMuni
1575:     * PUBLIC: BINDEVENT exige metodo publico
1576:     *==========================================================================
1577:     PROCEDURE BtnInserirMunClick()
1578:         LOCAL loc_oErro
1579:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1580:             RETURN
1581:         ENDIF
1582:         IF !USED("crMuni")
1583:             RETURN
1584:         ENDIF
1585:         TRY
1586:             SELECT crMuni
1587:             APPEND BLANK
1588:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Municipios", 5)
1589:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Municipios.Refresh()
1590:             ENDIF
1591:         CATCH TO loc_oErro
1592:             MostrarErro("Erro ao inserir munic" + CHR(237) + "pio:" + CHR(13) + ;
1593:                 loc_oErro.Message, "FormReg.BtnInserirMunClick")
1594:         ENDTRY
1595:     ENDPROC
1596: 
1597:     *==========================================================================
1598:     * BtnExcluirMunClick - Remove linha atual do cursor crMuni
1599:     * PUBLIC: BINDEVENT exige metodo publico
1600:     *==========================================================================
1601:     PROCEDURE BtnExcluirMunClick()
1602:         LOCAL loc_oErro
1603:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1604:             RETURN
1605:         ENDIF
1606:         IF !USED("crMuni") OR EOF("crMuni")
1607:             RETURN
1608:         ENDIF
1609:         IF !MsgConfirma("Excluir o munic" + CHR(237) + "pio selecionado?")
1610:             RETURN
1611:         ENDIF
1612:         TRY
1613:             DELETE IN crMuni
1614:             SELECT crMuni
1615:             PACK
1616:             IF RECCOUNT("crMuni") = 0
1617:                 APPEND BLANK
1618:             ENDIF
1619:             IF RECCOUNT("crMuni") > 0
1620:                 GO BOTTOM IN crMuni
1621:             ENDIF
1622:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Municipios", 5)
1623:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Municipios.Refresh()
1624:             ENDIF
1625:         CATCH TO loc_oErro
1626:             MostrarErro("Erro ao excluir munic" + CHR(237) + "pio:" + CHR(13) + ;
1627:                 loc_oErro.Message, "FormReg.BtnExcluirMunClick")
1628:         ENDTRY
1629:     ENDPROC
1630: 
1631:     *==========================================================================
1632:     * BtnInserirVendClick - Adiciona linha em branco ao cursor crVend
1633:     * PUBLIC: BINDEVENT exige metodo publico
1634:     *==========================================================================
1635:     PROCEDURE BtnInserirVendClick()
1636:         LOCAL loc_oErro
1637:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1638:             RETURN
1639:         ENDIF
1640:         IF !USED("crVend")
1641:             RETURN
1642:         ENDIF
1643:         TRY
1644:             SELECT crVend
1645:             APPEND BLANK
1646:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Vendedores", 5)
1647:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Vendedores.Refresh()
1648:             ENDIF
1649:         CATCH TO loc_oErro
1650:             MostrarErro("Erro ao inserir vendedor:" + CHR(13) + ;
1651:                 loc_oErro.Message, "FormReg.BtnInserirVendClick")
1652:         ENDTRY
1653:     ENDPROC
1654: 
1655:     *==========================================================================
1656:     * BtnExcluirVendClick - Remove linha atual do cursor crVend
1657:     * PUBLIC: BINDEVENT exige metodo publico
1658:     *==========================================================================
1659:     PROCEDURE BtnExcluirVendClick()
1660:         LOCAL loc_oErro
1661:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1662:             RETURN
1663:         ENDIF
1664:         IF !USED("crVend") OR EOF("crVend")
1665:             RETURN
1666:         ENDIF
1667:         IF !MsgConfirma("Excluir o vendedor selecionado?")
1668:             RETURN
1669:         ENDIF
1670:         TRY
1671:             DELETE IN crVend
1672:             SELECT crVend
1673:             PACK
1674:             IF RECCOUNT("crVend") = 0
1675:                 APPEND BLANK
1676:             ENDIF
1677:             IF RECCOUNT("crVend") > 0
1678:                 GO BOTTOM IN crVend
1679:             ENDIF
1680:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Vendedores", 5)
1681:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Vendedores.Refresh()
1682:             ENDIF
1683:         CATCH TO loc_oErro
1684:             MostrarErro("Erro ao excluir vendedor:" + CHR(13) + ;
1685:                 loc_oErro.Message, "FormReg.BtnExcluirVendClick")
1686:         ENDTRY
1687:     ENDPROC
1688: 
1689: ENDDEFINE


### BO (C:\4c\projeto\app\classes\RegBO.prg):
*====================================================================
* RegBO.prg
*
* Business Object para Cadastro de Regioes
* Tabela principal : SigCdReg (regiaos, descs, skchaves)
* Tabela filha     : SigCdRgi (municipios tipos='M' e vendedores tipos='C')
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS RegBO AS BusinessBase

    *-- ----------------------------------------------------------------
    *-- Propriedades da entidade principal (SigCdReg)
    *-- ----------------------------------------------------------------
    this_cRegiaos   = ""    && regiaos  char(10)  - PK
    this_cDescs     = ""    && descs    char(30)
    this_cSkChaves  = ""    && skchaves char(20)  - chave UUID (liga SigCdRgi)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdReg"
            THIS.this_cCampoChave = "regiaos"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "RegBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cRegiaos  = TratarNulo(regiaos,  "C")
                THIS.this_cDescs    = TratarNulo(descs,    "C")
                THIS.this_cSkChaves = TratarNulo(skchaves, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "RegBO.CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Seleciona todas as regioes para o grid de listagem
    * par_cFiltro: filtro opcional (nao usado - mantido por padrao)
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT regiaos, descs, skchaves" + ;
                       " FROM SigCdReg" + ;
                       " ORDER BY regiaos"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult < 0
                MsgErro("Erro ao buscar regi" + CHR(245) + "es: " + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "RegBO.Buscar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega uma regiao pelo codigo (PK)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cRegiaos)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT regiaos, descs, skchaves" + ;
                       " FROM SigCdReg" + ;
                       " WHERE regiaos = " + EscaparSQL(ALLTRIM(par_cRegiaos))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult < 0
                MsgErro("Erro ao carregar regi" + CHR(227) + "o: " + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "RegBO.CarregarPorCodigo")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * BuscarMunicipios - Carrega municipios da regiao no crMuni
    * par_cSkChaves: skchaves da regiao
    *====================================================================
    PROCEDURE BuscarMunicipios(par_cSkChaves)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED("crMuni")
                USE IN crMuni
            ENDIF

            IF EMPTY(ALLTRIM(par_cSkChaves))
                *-- Regiao nova: criar cursor vazio com linha em branco
                SET NULL ON
                CREATE CURSOR crMuni (skchaves C(20), pkChaves C(20), ;
                    codibges C(7), tipos C(1), iclis C(10), munici C(40), uf C(2))
                SET NULL OFF
                APPEND BLANK
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT DISTINCT a.skchaves, a.pkChaves, a.codibges, a.tipos," + ;
                           " c.descs AS munici, d.estados AS uf" + ;
                           " FROM SigCdRgi a" + ;
                           " LEFT JOIN sigcdmun c ON c.codigos = a.codibges" + ;
                           " LEFT JOIN sigcdufs d ON d.ufibges = c.ufibges" + ;
                           " WHERE a.skchaves = " + EscaparSQL(ALLTRIM(par_cSkChaves)) + ;
                           " AND a.tipos = 'M'" + ;
                           " ORDER BY c.descs"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MuniTemp")
                IF loc_nResult < 0
                    MsgErro("Erro ao carregar munic" + CHR(237) + "pios: " + CapturarErroSQL(), "Erro SQL")
                ELSE
                    SET NULL ON
                    CREATE CURSOR crMuni (skchaves C(20), pkChaves C(20), ;
                        codibges C(7), tipos C(1), iclis C(10), munici C(40), uf C(2))
                    SET NULL OFF

                    IF RECCOUNT("cursor_4c_MuniTemp") > 0
                        APPEND FROM DBF("cursor_4c_MuniTemp")
                    ENDIF

                    IF RECCOUNT("crMuni") = 0
                        APPEND BLANK
                    ENDIF

                    GO TOP IN crMuni
                    loc_lSucesso = .T.
                ENDIF

                IF USED("cursor_4c_MuniTemp")
                    USE IN cursor_4c_MuniTemp
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "RegBO.BuscarMunicipios")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * BuscarVendedores - Carrega vendedores/clientes da regiao no crVend
    * par_cSkChaves: skchaves da regiao
    *====================================================================
    PROCEDURE BuscarVendedores(par_cSkChaves)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED("crVend")
                USE IN crVend
            ENDIF

            IF EMPTY(ALLTRIM(par_cSkChaves))
                *-- Regiao nova: criar cursor vazio com linha em branco
                SET NULL ON
                CREATE CURSOR crVend (skchaves C(20), pkChaves C(20), ;
                    codibges C(7), tipos C(1), iclis C(10), vend C(50))
                SET NULL OFF
                APPEND BLANK
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT DISTINCT a.skchaves, a.pkChaves, a.codibges, a.tipos," + ;
                           " a.iclis, c.razaos AS vend" + ;
                           " FROM SigCdRgi a" + ;
                           " LEFT JOIN sigcdcli c ON c.iclis = a.iclis" + ;
                           " WHERE a.skchaves = " + EscaparSQL(ALLTRIM(par_cSkChaves)) + ;
                           " AND a.tipos = 'C'" + ;
                           " ORDER BY c.razaos"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VendTemp")
                IF loc_nResult < 0
                    MsgErro("Erro ao carregar vendedores: " + CapturarErroSQL(), "Erro SQL")
                ELSE
                    SET NULL ON
                    CREATE CURSOR crVend (skchaves C(20), pkChaves C(20), ;
                        codibges C(7), tipos C(1), iclis C(10), vend C(50))
                    SET NULL OFF

                    IF RECCOUNT("cursor_4c_VendTemp") > 0
                        APPEND FROM DBF("cursor_4c_VendTemp")
                    ENDIF

                    IF RECCOUNT("crVend") = 0
                        APPEND BLANK
                    ENDIF

                    GO TOP IN crVend
                    loc_lSucesso = .T.
                ENDIF

                IF USED("cursor_4c_VendTemp")
                    USE IN cursor_4c_VendTemp
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "RegBO.BuscarVendedores")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * InserirFilhos - Insere registros em SigCdRgi a partir de crMuni e crVend
    * par_cSkChaves: skchaves da regiao (recem gerado ou existente)
    *====================================================================
    PROTECTED PROCEDURE InserirFilhos(par_cSkChaves)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cPkChaves
        loc_lSucesso = .T.
        TRY
            *-- Inserir municipios do crMuni (tipos='M', codibges nao vazio)
            IF USED("crMuni")
                SELECT crMuni
                GO TOP
                SCAN
                    IF !EMPTY(ALLTRIM(crMuni.codibges)) .AND. !DELETED()
                        loc_cPkChaves = fUniqueIds()
                        loc_cSQL = "INSERT INTO SigCdRgi" + ;
                                   " (pkChaves, skchaves, codibges, tipos, iclis)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(loc_cPkChaves) + ", " + ;
                                   EscaparSQL(ALLTRIM(par_cSkChaves)) + ", " + ;
                                   EscaparSQL(ALLTRIM(crMuni.codibges)) + ", 'M', '')"
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsMuni")
                        IF USED("cursor_4c_InsMuni")
                            USE IN cursor_4c_InsMuni
                        ENDIF
                        IF loc_nResult < 0
                            MsgErro("Erro ao inserir munic" + CHR(237) + "pio: " + ;
                                    CapturarErroSQL(), "Erro SQL")
                            loc_lSucesso = .F.
                            EXIT
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF

            *-- Inserir vendedores do crVend (tipos='C', iclis nao vazio)
            IF loc_lSucesso AND USED("crVend")
                SELECT crVend
                GO TOP
                SCAN
                    IF !EMPTY(ALLTRIM(crVend.iclis)) .AND. !DELETED()
                        loc_cPkChaves = fUniqueIds()
                        loc_cSQL = "INSERT INTO SigCdRgi" + ;
                                   " (pkChaves, skchaves, codibges, tipos, iclis)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(loc_cPkChaves) + ", " + ;
                                   EscaparSQL(ALLTRIM(par_cSkChaves)) + ", '', 'C', " + ;
                                   EscaparSQL(ALLTRIM(crVend.iclis)) + ")"
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsVend")
                        IF USED("cursor_4c_InsVend")
                            USE IN cursor_4c_InsVend
                        ENDIF
                        IF loc_nResult < 0
                            MsgErro("Erro ao inserir vendedor: " + CapturarErroSQL(), "Erro SQL")
                            loc_lSucesso = .F.
                            EXIT
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "RegBO.InserirFilhos")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - INSERT na tabela SigCdReg + filhos em SigCdRgi
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cSkChaves
        loc_lSucesso = .F.
        TRY
            *-- Gerar chave UUID para skchaves
            loc_cSkChaves = fUniqueIds()
            THIS.this_cSkChaves = loc_cSkChaves

            loc_cSQL = "INSERT INTO SigCdReg (regiaos, descs, skchaves)" + ;
                       " VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cRegiaos)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDescs)) + ", " + ;
                       EscaparSQL(loc_cSkChaves) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsReg")
            IF USED("cursor_4c_InsReg")
                USE IN cursor_4c_InsReg
            ENDIF

            IF loc_nResult < 0
                MsgErro("Erro ao inserir regi" + CHR(227) + "o:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = THIS.InserirFilhos(loc_cSkChaves)
                IF loc_lSucesso
                    THIS.RegistrarAuditoria("INSERT")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "RegBO.Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - UPDATE em SigCdReg + rebuild de SigCdRgi
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            *-- Atualizar descricao (regiaos nao pode ser alterado)
            loc_cSQL = "UPDATE SigCdReg" + ;
                       " SET descs = " + EscaparSQL(ALLTRIM(THIS.this_cDescs)) + ;
                       " WHERE regiaos = " + EscaparSQL(ALLTRIM(THIS.this_cRegiaos))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdReg")
            IF USED("cursor_4c_UpdReg")
                USE IN cursor_4c_UpdReg
            ENDIF

            IF loc_nResult < 0
                MsgErro("Erro ao atualizar regi" + CHR(227) + "o:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- Remover todos os filhos existentes e reinserir
                loc_cSQL = "DELETE FROM SigCdRgi" + ;
                           " WHERE skchaves = " + EscaparSQL(ALLTRIM(THIS.this_cSkChaves))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelRgi")
                IF USED("cursor_4c_DelRgi")
                    USE IN cursor_4c_DelRgi
                ENDIF

                IF loc_nResult < 0
                    MsgErro("Erro ao remover municipios/vendedores:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                ELSE
                    loc_lSucesso = THIS.InserirFilhos(ALLTRIM(THIS.this_cSkChaves))
                    IF loc_lSucesso
                        THIS.RegistrarAuditoria("UPDATE")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "RegBO.Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - DELETE de SigCdRgi + SigCdReg
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            *-- Excluir filhos primeiro (integridade referencial)
            loc_cSQL = "DELETE FROM SigCdRgi" + ;
                       " WHERE skchaves = " + EscaparSQL(ALLTRIM(THIS.this_cSkChaves))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelRgi")
            IF USED("cursor_4c_DelRgi")
                USE IN cursor_4c_DelRgi
            ENDIF

            IF loc_nResult < 0
                MsgErro("Erro ao excluir municipios/vendedores:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- Excluir regiao principal
                loc_cSQL = "DELETE FROM SigCdReg" + ;
                           " WHERE regiaos = " + EscaparSQL(ALLTRIM(THIS.this_cRegiaos))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelReg")
                IF USED("cursor_4c_DelReg")
                    USE IN cursor_4c_DelReg
                ENDIF

                IF loc_nResult < 0
                    MsgErro("Erro ao excluir regi" + CHR(227) + "o:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                ELSE
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "RegBO.ExecutarExclusao")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cRegiaos)
    ENDPROC

ENDDEFINE

