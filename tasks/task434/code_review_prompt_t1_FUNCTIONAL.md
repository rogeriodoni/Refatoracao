# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (13)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [GRID-HEADER] Header Caption 'Valor' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Descrição, Coeficiente, Produto, Ordem, Código, Sequencia. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Moeda' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Descrição, Coeficiente, Produto, Ordem, Código, Sequencia. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Acréscimo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Descrição, Coeficiente, Produto, Ordem, Código, Sequencia. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Seqüencia' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Descrição, Coeficiente, Produto, Ordem, Código, Sequencia. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Valor' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Descrição, Coeficiente, Produto, Ordem, Código, Sequencia. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Moeda' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Descrição, Coeficiente, Produto, Ordem, Código, Sequencia. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Acréscimo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Descrição, Coeficiente, Produto, Ordem, Código, Sequencia. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Valor' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Descrição, Coeficiente, Produto, Ordem, Código, Sequencia. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Moeda' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Descrição, Coeficiente, Produto, Ordem, Código, Sequencia. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Acréscimo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Descrição, Coeficiente, Produto, Ordem, Código, Sequencia. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDFTI.Pagina.Dados): Top original=12 vs migrado 'lbl_4c_Label11' Top=119 (diff=107px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDFTI.Pagina.Dados): Left original=121 vs migrado 'lbl_4c_Label11' Left=442 (diff=321px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormFti.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2465 linhas total):

*-- Linhas 27 a 184:
27:     this_cAntValue       = ""
28: 
29:     *==========================================================================
30:     * Init - Inicializacao delegada ao FormBase (que chama InicializarForm)
31:     *==========================================================================
32:     PROCEDURE Init()
33:         LOCAL loc_lResultado
34:         loc_lResultado = .F.
35:         TRY
36:             loc_lResultado = DODEFAULT()
37:         CATCH TO loException
38:             MsgErro("Erro em FormFti.Init:" + CHR(13) + loException.Message + ;
39:                     CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
40:         ENDTRY
41:         RETURN loc_lResultado
42:     ENDPROC
43: 
44:     *==========================================================================
45:     * InicializarForm - Chamado por FormBase.Init()
46:     *==========================================================================
47:     PROTECTED PROCEDURE InicializarForm()
48:         LOCAL loc_lResultado
49:         loc_lResultado = .F.
50: 
51:         TRY
52:             THIS.this_oBusinessObject = CREATEOBJECT("FtiBO")
53:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
54:                 THIS.CriarCursoresGrade()
55:                 THIS.ConfigurarPageFrame()
56: 
57:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
58:                     IF !THIS.this_oBusinessObject.CarregarParametros()
59:                         MsgErro("Erro ao carregar par" + CHR(226) + "metros de feitios", "Erro")
60:                     ENDIF
61:                     THIS.CarregarLista()
62:                 ENDIF
63: 
64:                 THIS.pgf_4c_Paginas.Visible = .T.
65:                 THIS.pgf_4c_Paginas.ActivePage = 1
66:                 THIS.this_cModoAtual = "LISTA"
67:                 loc_lResultado = .T.
68:             ELSE
69:                 MsgErro("Erro ao criar FtiBO", "Erro")
70:             ENDIF
71:         CATCH TO loException
72:             MsgErro("Erro em FormFti.InicializarForm:" + CHR(13) + loException.Message + ;
73:                     CHR(13) + "Linha: " + TRANSFORM(loException.LineNo) + ;
74:                     CHR(13) + "Proc: " + loException.Procedure, "Erro")
75:         ENDTRY
76: 
77:         RETURN loc_lResultado
78:     ENDPROC
79: 
80:     *==========================================================================
81:     * CriarCursoresGrade - Cria cursores csGrade e csCusto (locais, sem SQL Server)
82:     *==========================================================================
83:     PROTECTED PROCEDURE CriarCursoresGrade()
84:         IF USED("csGrade")
85:             USE IN csGrade
86:         ENDIF
87:         SET NULL ON
88:         CREATE CURSOR csGrade (Cgrus C(3), CPros C(14), Dgrus C(20), Coefs N(8,4), Ordem N(1,0))
89:         SET NULL OFF
90:         SELECT csGrade
91:         INDEX ON CPros TAG CPros
92: 
93:         IF USED("csCusto")
94:             USE IN csCusto
95:         ENDIF
96:         SET NULL ON
97:         CREATE CURSOR csCusto (Cpros C(14), Dpros C(40), Seqs N(5), Coefs N(8,4))
98:         SET NULL OFF
99:     ENDPROC
100: 
101:     *==========================================================================
102:     * ConfigurarPageFrame - Cria PageFrame principal com 2 paginas
103:     *==========================================================================
104:     PROTECTED PROCEDURE ConfigurarPageFrame()
105:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
106:         WITH THIS.pgf_4c_Paginas
107:             .Top       = -29
108:             .Left      = 0
109:             .Width     = THIS.Width
110:             .Height    = THIS.Height + 29
111:             .PageCount = 2
112:             .Tabs      = .F.
113:             .Visible   = .T.
114:         ENDWITH
115: 
116:         THIS.pgf_4c_Paginas.Page1.BackColor = RGB(200, 200, 200)
117:         THIS.pgf_4c_Paginas.Page2.BackColor = RGB(200, 200, 200)
118: 
119:         IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
120:             THIS.pgf_4c_Paginas.Page1.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
121:             THIS.pgf_4c_Paginas.Page2.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
122:         ENDIF
123: 
124:         THIS.ConfigurarPaginaLista()
125:         THIS.ConfigurarPaginaDados()
126:     ENDPROC
127: 
128:     *==========================================================================
129:     * ConfigurarPaginaLista - Estrutura da Page1 (Lista)
130:     * Criados aqui: cntSombra, cnt_4c_Botoes(shell), cnt_4c_Saida, XML buttons
131:     * Grid e botoes CRUD: Fase 4
132:     *==========================================================================
133:     PROTECTED PROCEDURE ConfigurarPaginaLista()
134:         LOCAL loc_oPagina
135:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
136: 
137:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
138:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
139: 
140:         *-- Cabecalho cinza (cntSombra: Top=1, Left=-1, Width=1008, H=80 -> comp +29)
141:         loc_oPagina.AddObject("cnt_4c_Sombra", "Container")
142:         WITH loc_oPagina.cnt_4c_Sombra
143:             .Top         = 30
144:             .Left        = 0
145:             .Width       = THIS.Width
146:             .Height      = 80
147:             .BackColor   = RGB(100, 100, 100)
148:             .BorderWidth = 0
149:             .Visible     = .T.
150:         ENDWITH
151: 
152:         loc_oPagina.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
153:         WITH loc_oPagina.cnt_4c_Sombra.lbl_4c_Sombra
154:             .Top       = 15
155:             .Left      = 10
156:             .Width     = 769
157:             .Height    = 40
158:             .AutoSize  = .F.
159:             .Caption   = "Cadastro de Feitios"
160:             .FontName  = "Tahoma"
161:             .FontSize  = 16
162:             .FontBold  = .T.
163:             .ForeColor = RGB(0, 0, 0)
164:             .BackStyle = 0
165:             .Visible   = .T.
166:         ENDWITH
167: 
168:         loc_oPagina.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
169:         WITH loc_oPagina.cnt_4c_Sombra.lbl_4c_Titulo
170:             .Top       = 18
171:             .Left      = 10
172:             .Width     = 769
173:             .Height    = 46
174:             .AutoSize  = .F.
175:             .Caption   = "Cadastro de Feitios"
176:             .FontName  = "Tahoma"
177:             .FontSize  = 16
178:             .FontBold  = .T.
179:             .ForeColor = RGB(255, 255, 255)
180:             .BackStyle = 0
181:             .Visible   = .T.
182:         ENDWITH
183: 
184:         *-- Container botoes CRUD (Grupo_op: Left=543, Top=-1+29=28, W=385, H=85)

*-- Linhas 228 a 319:
228:             .MousePointer    = 15
229:             .Visible         = .T.
230:         ENDWITH
231:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
232: 
233:         *-- Botao Exporta XML (Top=83+29=112, Left=712, W=105, H=45)
234:         loc_oPagina.AddObject("cmd_4c_BtnExpXML", "CommandButton")
235:         WITH loc_oPagina.cmd_4c_BtnExpXML
236:             .Caption         = "Exporta XML"
237:             .Top             = 112
238:             .Left            = 712
239:             .Width           = 105
240:             .Height          = 45
241:             .Picture         = gc_4c_CaminhoIcones + "exportar_48.png"
242:             .PicturePosition = 1
243:             .FontName        = "Comic Sans MS"
244:             .FontSize        = 8
245:             .FontBold        = .T.
246:             .FontItalic      = .T.
247:             .ForeColor       = RGB(90, 90, 90)
248:             .BackColor       = RGB(255, 255, 255)
249:             .Themes          = .F.
250:             .SpecialEffect   = 0
251:             .WordWrap        = .T.
252:             .ToolTipText     = "Exporta Opera" + CHR(231) + CHR(227) + "o Para Um Arquivo XML"
253:             .Visible         = .T.
254:         ENDWITH
255:         BINDEVENT(loc_oPagina.cmd_4c_BtnExpXML, "Click", THIS, "BtnExpXMLClick")
256: 
257:         *-- Botao Importa XML (Top=83+29=112, Left=818, W=105, H=45)
258:         loc_oPagina.AddObject("cmd_4c_BtnImpXML", "CommandButton")
259:         WITH loc_oPagina.cmd_4c_BtnImpXML
260:             .Caption         = "Importa XML"
261:             .Top             = 112
262:             .Left            = 818
263:             .Width           = 105
264:             .Height          = 45
265:             .Picture         = gc_4c_CaminhoIcones + "importar_48.png"
266:             .PicturePosition = 1
267:             .FontName        = "Comic Sans MS"
268:             .FontSize        = 8
269:             .FontBold        = .T.
270:             .FontItalic      = .T.
271:             .ForeColor       = RGB(90, 90, 90)
272:             .BackColor       = RGB(255, 255, 255)
273:             .Themes          = .F.
274:             .SpecialEffect   = 0
275:             .WordWrap        = .T.
276:             .ToolTipText     = "Importa Opera" + CHR(231) + CHR(227) + "o De Um Arquivo XML"
277:             .Visible         = .T.
278:         ENDWITH
279:         BINDEVENT(loc_oPagina.cmd_4c_BtnImpXML, "Click", THIS, "BtnImpXMLClick")
280: 
281:         *-- Grid principal de lista (Grade: Top=133+29=162, Left=12, W=940, H=458)
282:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
283:         WITH loc_oPagina.grd_4c_Lista
284:             .Top               = 162
285:             .Left              = 12
286:             .Width             = 940
287:             .Height            = 458
288:             .ColumnCount       = 5
289:             .FontName          = "Verdana"
290:             .FontSize          = 8
291:             .ForeColor         = RGB(90, 90, 90)
292:             .GridLineColor     = RGB(90, 90, 90)
293:             .RowHeight         = 16
294:             .HeaderHeight      = 16
295:             .AllowHeaderSizing = .F.
296:             .AllowRowSizing    = .F.
297:             .DeleteMark        = .F.
298:             .RecordMark        = .F.
299:             .ScrollBars        = 2
300:             .ReadOnly          = .T.
301:             .Visible           = .T.
302:         ENDWITH
303:         WITH loc_oPagina.grd_4c_Lista.Column1
304:             .ControlSource = "cursor_4c_Dados.cods"
305:             .Width         = 50
306:             .Movable       = .F.
307:             .Resizable     = .F.
308:         ENDWITH
309:         loc_oPagina.grd_4c_Lista.Column1.Header1.Caption = "C" + CHR(243) + "digo"
310:         WITH loc_oPagina.grd_4c_Lista.Column2
311:             .ControlSource = "cursor_4c_Dados.descs"
312:             .Width         = 270
313:             .Movable       = .F.
314:             .Resizable     = .F.
315:         ENDWITH
316:         loc_oPagina.grd_4c_Lista.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
317:         WITH loc_oPagina.grd_4c_Lista.Column3
318:             .ControlSource = "cursor_4c_Dados.valors"
319:             .Width         = 120

*-- Linhas 359 a 605:
359:             .MousePointer    = 15
360:             .Visible         = .T.
361:         ENDWITH
362:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
363: 
364:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
365:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
366:             .Caption         = "Visualizar"
367:             .Top             = 5
368:             .Left            = 80
369:             .Width           = 75
370:             .Height          = 75
371:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
372:             .PicturePosition = 13
373:             .FontName        = "Comic Sans MS"
374:             .FontSize        = 8
375:             .FontBold        = .T.
376:             .FontItalic      = .T.
377:             .ForeColor       = RGB(90, 90, 90)
378:             .BackColor       = RGB(255, 255, 255)
379:             .Themes          = .F.
380:             .SpecialEffect   = 0
381:             .WordWrap        = .T.
382:             .MousePointer    = 15
383:             .Visible         = .T.
384:         ENDWITH
385:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
386: 
387:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
388:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
389:             .Caption         = "Alterar"
390:             .Top             = 5
391:             .Left            = 155
392:             .Width           = 75
393:             .Height          = 75
394:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
395:             .PicturePosition = 13
396:             .FontName        = "Comic Sans MS"
397:             .FontSize        = 8
398:             .FontBold        = .T.
399:             .FontItalic      = .T.
400:             .ForeColor       = RGB(90, 90, 90)
401:             .BackColor       = RGB(255, 255, 255)
402:             .Themes          = .F.
403:             .SpecialEffect   = 0
404:             .WordWrap        = .T.
405:             .MousePointer    = 15
406:             .Visible         = .T.
407:         ENDWITH
408:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
409: 
410:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
411:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
412:             .Caption         = "Excluir"
413:             .Top             = 5
414:             .Left            = 230
415:             .Width           = 75
416:             .Height          = 75
417:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
418:             .PicturePosition = 13
419:             .FontName        = "Comic Sans MS"
420:             .FontSize        = 8
421:             .FontBold        = .T.
422:             .FontItalic      = .T.
423:             .ForeColor       = RGB(90, 90, 90)
424:             .BackColor       = RGB(255, 255, 255)
425:             .Themes          = .F.
426:             .SpecialEffect   = 0
427:             .WordWrap        = .T.
428:             .MousePointer    = 15
429:             .Visible         = .T.
430:         ENDWITH
431:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
432: 
433:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
434:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
435:             .Caption         = "Buscar"
436:             .Top             = 5
437:             .Left            = 305
438:             .Width           = 75
439:             .Height          = 75
440:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
441:             .PicturePosition = 13
442:             .FontName        = "Comic Sans MS"
443:             .FontSize        = 8
444:             .FontBold        = .T.
445:             .FontItalic      = .T.
446:             .ForeColor       = RGB(90, 90, 90)
447:             .BackColor       = RGB(255, 255, 255)
448:             .Themes          = .F.
449:             .SpecialEffect   = 0
450:             .WordWrap        = .T.
451:             .MousePointer    = 15
452:             .Visible         = .T.
453:         ENDWITH
454:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
455: 
456:         THIS.TornarControlesVisiveis(loc_oPagina)
457:     ENDPROC
458: 
459:     *==========================================================================
460:     * ConfigurarPaginaDados - Estrutura da Page2 (Dados)
461:     * Criados aqui: cnt_4c_Salva, cnt_4c_BotoesLinha, pgf_4c_Configuracao(shell)
462:     * TextBoxes e OptionGroups: Fases 5-6
463:     * Grids de configuracao: Fase 4
464:     *==========================================================================
465:     PROTECTED PROCEDURE ConfigurarPaginaDados()
466:         LOCAL loc_oPagina
467:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
468: 
469:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
470:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
471: 
472:         *-- Container Salvar/Cancelar (Grupo_Salva: Left=818, Top=10+29=39, W=160, H=85)
473:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
474:         WITH loc_oPagina.cnt_4c_Salva
475:             .Top         = 39
476:             .Left        = 818
477:             .Width       = 160
478:             .Height      = 85
479:             .BackStyle = 1
480:             .BackColor = RGB(255, 255, 255)
481:             .BorderWidth = 0
482:             .Visible     = .T.
483:         ENDWITH
484: 
485:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
486:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
487:             .Caption         = "Confirmar"
488:             .Top             = 5
489:             .Left            = 5
490:             .Width           = 75
491:             .Height          = 75
492:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
493:             .PicturePosition = 13
494:             .FontName        = "Comic Sans MS"
495:             .FontSize        = 8
496:             .FontBold        = .T.
497:             .FontItalic      = .T.
498:             .ForeColor       = RGB(90, 90, 90)
499:             .BackColor       = RGB(255, 255, 255)
500:             .Themes          = .F.
501:             .SpecialEffect   = 0
502:             .WordWrap        = .T.
503:             .MousePointer    = 15
504:             .Visible         = .T.
505:         ENDWITH
506:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
507: 
508:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
509:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
510:             .Caption         = "Encerrar"
511:             .Top             = 5
512:             .Left            = 80
513:             .Width           = 75
514:             .Height          = 75
515:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
516:             .PicturePosition = 13
517:             .FontName        = "Comic Sans MS"
518:             .FontSize        = 8
519:             .FontBold        = .T.
520:             .FontItalic      = .T.
521:             .ForeColor       = RGB(90, 90, 90)
522:             .BackColor       = RGB(255, 255, 255)
523:             .Themes          = .F.
524:             .SpecialEffect   = 0
525:             .WordWrap        = .T.
526:             .MousePointer    = 15
527:             .Visible         = .T.
528:         ENDWITH
529:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
530: 
531:         *-- Container botao Excluir Linha da grade (cmdBotoes: Top=361+29=390, Left=755, W=85)
532:         loc_oPagina.AddObject("cnt_4c_BotoesLinha", "Container")
533:         WITH loc_oPagina.cnt_4c_BotoesLinha
534:             .Top         = 390
535:             .Left        = 755
536:             .Width       = 85
537:             .Height      = 85
538:             .BackStyle = 1
539:             .BackColor = RGB(255, 255, 255)
540:             .BorderWidth = 0
541:             .Visible     = .T.
542:         ENDWITH
543: 
544:         loc_oPagina.cnt_4c_BotoesLinha.AddObject("cmd_4c_ExcluirLinha", "CommandButton")
545:         WITH loc_oPagina.cnt_4c_BotoesLinha.cmd_4c_ExcluirLinha
546:             .Caption         = "Excluir"
547:             .Top             = 5
548:             .Left            = 5
549:             .Width           = 75
550:             .Height          = 75
551:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
552:             .PicturePosition = 13
553:             .FontName        = "Comic Sans MS"
554:             .FontSize        = 8
555:             .FontBold        = .T.
556:             .FontItalic      = .T.
557:             .ForeColor       = RGB(90, 90, 90)
558:             .BackColor       = RGB(255, 255, 255)
559:             .Themes          = .F.
560:             .SpecialEffect   = 0
561:             .WordWrap        = .T.
562:             .MousePointer    = 15
563:             .Visible         = .T.
564:         ENDWITH
565:         BINDEVENT(loc_oPagina.cnt_4c_BotoesLinha.cmd_4c_ExcluirLinha, "Click", THIS, "BtnExcluirLinhaClick")
566: 
567:         *-- PageFrame Configuracao aninhado (Top=184+29=213, Left=-2, W=1003, H=420)
568:         loc_oPagina.AddObject("pgf_4c_Configuracao", "PageFrame")
569:         WITH loc_oPagina.pgf_4c_Configuracao
570:             .Top       = 213
571:             .Left      = -2
572:             .Width     = 1003
573:             .Height    = 420
574:             .PageCount = 2
575:             .Tabs      = .T.
576:             .Visible   = .T.
577:         ENDWITH
578:         loc_oPagina.pgf_4c_Configuracao.Page1.Caption = "Grupos de Produto"
579:         loc_oPagina.pgf_4c_Configuracao.Page2.Caption = "Custos Fixo"
580: 
581:         *-- =================================================================
582:         *-- CAMPOS PRINCIPAIS DA PAGE2 - PARTE 1 (Fase 5/8)
583:         *-- =================================================================
584: 
585:         *-- Label1: "Código : " (top=12+29=41, left=121, W=45, H=15)
586:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
587:         WITH loc_oPagina.lbl_4c_Label1
588:             .Caption   = "C" + CHR(243) + "digo : "
589:             .Top       = 41
590:             .Left      = 121
591:             .Width     = 45
592:             .Height    = 15
593:             .AutoSize  = .F.
594:             .FontName  = "Tahoma"
595:             .FontSize  = 8
596:             .FontBold  = .F.
597:             .ForeColor = RGB(90, 90, 90)
598:             .BackStyle = 0
599:             .Alignment = 1
600:             .Visible   = .T.
601:         ENDWITH
602: 
603:         *-- txt_4c_Codigo: (top=8+29=37, left=166, W=34, H=23)
604:         *-- When original: InList(ThisForm.pcEscolha,'INSERIR','PROCURAR') -> so editavel em INCLUIR
605:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")

*-- Linhas 683 a 827:
683:         ENDWITH
684: 
685:         *-- opt_4c_TpFtio: (top=33+29=62, left=316, W=283, H=27, 3 buttons)
686:         *-- InteractiveChange: Value=3 (Sem Feitio) zera Valor e Acrescimo
687:         loc_oPagina.AddObject("opt_4c_TpFtio", "OptionGroup")
688:         WITH loc_oPagina.opt_4c_TpFtio
689:             .ButtonCount = 3
690:             .Top         = 62
691:             .Left        = 316
692:             .Width       = 283
693:             .Height      = 27
694:             .BackStyle   = 0
695:             .BorderStyle = 0
696:             .Value       = 1
697:             .Visible     = .T.
698:         ENDWITH
699:         WITH loc_oPagina.opt_4c_TpFtio.Buttons(1)
700:             .Caption   = "Por Peso"
701:             .BackStyle = 0
702:             .Left      = 5
703:             .Top       = 5
704:             .Width     = 70
705:             .AutoSize  = .T.
706:             .FontName  = "Tahoma"
707:             .FontSize  = 8
708:             .ForeColor = RGB(90, 90, 90)
709:             .Themes    = .F.
710:         ENDWITH
711:         WITH loc_oPagina.opt_4c_TpFtio.Buttons(2)
712:             .Caption   = "Valor Adicional"
713:             .BackStyle = 0
714:             .Left      = 80
715:             .Top       = 5
716:             .Width     = 65
717:             .AutoSize  = .T.
718:             .FontName  = "Tahoma"
719:             .FontSize  = 8
720:             .ForeColor = RGB(90, 90, 90)
721:             .Themes    = .F.
722:         ENDWITH
723:         WITH loc_oPagina.opt_4c_TpFtio.Buttons(3)
724:             .Caption   = "Informativo"
725:             .BackStyle = 0
726:             .Left      = 160
727:             .Top       = 5
728:             .Width     = 75
729:             .AutoSize  = .T.
730:             .FontName  = "Tahoma"
731:             .FontSize  = 8
732:             .ForeColor = RGB(90, 90, 90)
733:             .Themes    = .F.
734:         ENDWITH
735:         BINDEVENT(loc_oPagina.opt_4c_TpFtio, "InteractiveChange", THIS, "TpFtioChanged")
736: 
737:         *-- Label4: "Moeda : " (top=64+29=93, left=122, W=44, H=15)
738:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
739:         WITH loc_oPagina.lbl_4c_Label4
740:             .Caption   = "Moeda : "
741:             .Top       = 93
742:             .Left      = 122
743:             .Width     = 44
744:             .Height    = 15
745:             .AutoSize  = .F.
746:             .FontName  = "Tahoma"
747:             .FontSize  = 8
748:             .FontBold  = .F.
749:             .ForeColor = RGB(90, 90, 90)
750:             .BackStyle = 0
751:             .Alignment = 1
752:             .Visible   = .T.
753:         ENDWITH
754: 
755:         *-- txt_4c_CdMoeda: codigo moeda (top=60+29=89, left=166, W=32, H=23)
756:         *-- When original: INSERIR E moeda vazia  |  Valid: fwbuscaext SigCdMoe por cmoes
757:         loc_oPagina.AddObject("txt_4c_CdMoeda", "TextBox")
758:         WITH loc_oPagina.txt_4c_CdMoeda
759:             .Value     = ""
760:             .Top       = 89
761:             .Left      = 166
762:             .Width     = 32
763:             .Height    = 23
764:             .FontName  = "Tahoma"
765:             .FontSize  = 8
766:             .ForeColor = RGB(90, 90, 90)
767:             .MaxLength = 6
768:             .Visible   = .T.
769:         ENDWITH
770:         BINDEVENT(loc_oPagina.txt_4c_CdMoeda, "KeyPress", THIS, "ValidarCdMoeda")
771: 
772:         *-- txt_4c_DsMoeda: descricao moeda (top=60+29=89, left=201, W=115, H=23)
773:         *-- When original: INSERIR E moeda vazia  |  Valid: fwbuscaext SigCdMoe por dmoes
774:         loc_oPagina.AddObject("txt_4c_DsMoeda", "TextBox")
775:         WITH loc_oPagina.txt_4c_DsMoeda
776:             .Value     = ""
777:             .Top       = 89
778:             .Left      = 201
779:             .Width     = 115
780:             .Height    = 23
781:             .FontName  = "Tahoma"
782:             .FontSize  = 8
783:             .ForeColor = RGB(90, 90, 90)
784:             .MaxLength = 20
785:             .Visible   = .T.
786:         ENDWITH
787:         BINDEVENT(loc_oPagina.txt_4c_DsMoeda, "KeyPress", THIS, "ValidarDsMoeda")
788: 
789:         *-- Label5: "Multiplicador : " (top=64+29=93, left=401, W=71, H=15)
790:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
791:         WITH loc_oPagina.lbl_4c_Label5
792:             .Caption   = "Multiplicador : "
793:             .Top       = 93
794:             .Left      = 401
795:             .Width     = 71
796:             .Height    = 15
797:             .AutoSize  = .F.
798:             .FontName  = "Tahoma"
799:             .FontSize  = 8
800:             .FontBold  = .F.
801:             .ForeColor = RGB(90, 90, 90)
802:             .BackStyle = 0
803:             .Alignment = 0
804:             .Visible   = .T.
805:         ENDWITH
806: 
807:         *-- txt_4c_Acrescimo: Multiplicador (top=60+29=89, left=474, W=94, H=23)
808:         loc_oPagina.AddObject("txt_4c_Acrescimo", "TextBox")
809:         WITH loc_oPagina.txt_4c_Acrescimo
810:             .Value     = 0
811:             .Top       = 89
812:             .Left      = 474
813:             .Width     = 94
814:             .Height    = 23
815:             .FontName  = "Tahoma"
816:             .FontSize  = 8
817:             .ForeColor = RGB(90, 90, 90)
818:             .InputMask = "999.9999"
819:             .Visible   = .T.
820:         ENDWITH
821: 
822:         *-- Label12: "sem uso :" (top=14+29=43, left=586, W=59) - OCULTO (Visible=.F. no original)
823:         loc_oPagina.AddObject("lbl_4c_Label12", "Label")
824:         WITH loc_oPagina.lbl_4c_Label12
825:             .Caption   = "sem uso :"
826:             .Top       = 43
827:             .Left      = 586

*-- Linhas 973 a 1016:
973:         ENDWITH
974: 
975:         *-- opt_4c_CusVenda: Custo/Venda (top=112+29=141, left=161, W=158, H=17, Value=2)
976:         loc_oPagina.AddObject("opt_4c_CusVenda", "OptionGroup")
977:         WITH loc_oPagina.opt_4c_CusVenda
978:             .ButtonCount   = 2
979:             .Top           = 141
980:             .Left          = 161
981:             .Width         = 158
982:             .Height        = 17
983:             .BackStyle     = 0
984:             .BorderStyle   = 0
985:             .SpecialEffect = 0
986:             .Value         = 2
987:             .Visible       = .T.
988:         ENDWITH
989:         WITH loc_oPagina.opt_4c_CusVenda.Buttons(1)
990:             .Caption   = "Custo"
991:             .BackStyle = 0
992:             .Left      = 5
993:             .Top       = 1
994:             .AutoSize  = .T.
995:             .FontName  = "Tahoma"
996:             .FontSize  = 8
997:             .ForeColor = RGB(90, 90, 90)
998:             .Themes    = .F.
999:         ENDWITH
1000:         WITH loc_oPagina.opt_4c_CusVenda.Buttons(2)
1001:             .Caption   = "Venda"
1002:             .BackStyle = 0
1003:             .Left      = 98
1004:             .Top       = 1
1005:             .AutoSize  = .T.
1006:             .FontName  = "Tahoma"
1007:             .FontSize  = 8
1008:             .ForeColor = RGB(90, 90, 90)
1009:             .Themes    = .F.
1010:         ENDWITH
1011: 
1012:         *-- lbl_4c_Label13: "Utilizado na Etiqueta : " (top=114+29=143, left=359)
1013:         loc_oPagina.AddObject("lbl_4c_Label13", "Label")
1014:         WITH loc_oPagina.lbl_4c_Label13
1015:             .Caption   = "Utilizado na Etiqueta : "
1016:             .Top       = 143

*-- Linhas 1027 a 1070:
1027:         ENDWITH
1028: 
1029:         *-- opt_4c_Etiquetas: Sim/Sim-AU/Não (top=108+29=137, left=474, W=182, H=25, Value=3)
1030:         loc_oPagina.AddObject("opt_4c_Etiquetas", "OptionGroup")
1031:         WITH loc_oPagina.opt_4c_Etiquetas
1032:             .ButtonCount   = 3
1033:             .Top           = 137
1034:             .Left          = 474
1035:             .Width         = 182
1036:             .Height        = 25
1037:             .BackStyle     = 0
1038:             .BorderStyle   = 0
1039:             .SpecialEffect = 0
1040:             .Value         = 3
1041:             .Visible       = .T.
1042:         ENDWITH
1043:         WITH loc_oPagina.opt_4c_Etiquetas.Buttons(1)
1044:             .Caption   = "Sim"
1045:             .BackStyle = 0
1046:             .Left      = 5
1047:             .Top       = 5
1048:             .AutoSize  = .T.
1049:             .FontName  = "Tahoma"
1050:             .FontSize  = 8
1051:             .ForeColor = RGB(90, 90, 90)
1052:             .Themes    = .F.
1053:         ENDWITH
1054:         WITH loc_oPagina.opt_4c_Etiquetas.Buttons(2)
1055:             .Caption   = "Sim - AU"
1056:             .BackStyle = 0
1057:             .Left      = 60
1058:             .Top       = 5
1059:             .AutoSize  = .T.
1060:             .FontName  = "Tahoma"
1061:             .FontSize  = 8
1062:             .ForeColor = RGB(90, 90, 90)
1063:             .Themes    = .F.
1064:         ENDWITH
1065:         WITH loc_oPagina.opt_4c_Etiquetas.Buttons(3)
1066:             .Caption   = "N" + CHR(227) + "o"
1067:             .BackStyle = 0
1068:             .Left      = 140
1069:             .Top       = 5
1070:             .AutoSize  = .T.

*-- Linhas 1092 a 1135:
1092:         ENDWITH
1093: 
1094:         *-- opt_4c_Cfixo: Multiplicador/Divisor (top=132+29=161, left=161, W=162, H=17, Value=1)
1095:         loc_oPagina.AddObject("opt_4c_Cfixo", "OptionGroup")
1096:         WITH loc_oPagina.opt_4c_Cfixo
1097:             .ButtonCount   = 2
1098:             .Top           = 161
1099:             .Left          = 161
1100:             .Width         = 162
1101:             .Height        = 17
1102:             .BackStyle     = 0
1103:             .BorderStyle   = 0
1104:             .SpecialEffect = 0
1105:             .Value         = 1
1106:             .Visible       = .T.
1107:         ENDWITH
1108:         WITH loc_oPagina.opt_4c_Cfixo.Buttons(1)
1109:             .Caption   = "Multiplicador"
1110:             .BackStyle = 0
1111:             .Left      = 5
1112:             .Top       = 1
1113:             .AutoSize  = .T.
1114:             .FontName  = "Tahoma"
1115:             .FontSize  = 8
1116:             .ForeColor = RGB(90, 90, 90)
1117:             .Themes    = .F.
1118:         ENDWITH
1119:         WITH loc_oPagina.opt_4c_Cfixo.Buttons(2)
1120:             .Caption   = "Divisor"
1121:             .BackStyle = 0
1122:             .Left      = 98
1123:             .Top       = 1
1124:             .AutoSize  = .T.
1125:             .FontName  = "Tahoma"
1126:             .FontSize  = 8
1127:             .ForeColor = RGB(90, 90, 90)
1128:             .Themes    = .F.
1129:         ENDWITH
1130: 
1131:         *-- lbl_4c_Label10: "Aplicar Sobre Custo : " (top=153+29=182, left=60)
1132:         loc_oPagina.AddObject("lbl_4c_Label10", "Label")
1133:         WITH loc_oPagina.lbl_4c_Label10
1134:             .Caption   = "Aplicar Sobre Custo : "
1135:             .Top       = 182

*-- Linhas 1146 a 1233:
1146:         ENDWITH
1147: 
1148:         *-- opt_4c_Fwoption1: Sim/Não (top=151+29=180, left=161, W=144, H=19, Value=2)
1149:         loc_oPagina.AddObject("opt_4c_Fwoption1", "OptionGroup")
1150:         WITH loc_oPagina.opt_4c_Fwoption1
1151:             .ButtonCount   = 2
1152:             .Top           = 180
1153:             .Left          = 161
1154:             .Width         = 144
1155:             .Height        = 19
1156:             .BackStyle     = 0
1157:             .BorderStyle   = 0
1158:             .SpecialEffect = 0
1159:             .Value         = 2
1160:             .Visible       = .T.
1161:         ENDWITH
1162:         WITH loc_oPagina.opt_4c_Fwoption1.Buttons(1)
1163:             .Caption   = "Sim"
1164:             .BackStyle = 0
1165:             .Left      = 5
1166:             .Top       = 2
1167:             .AutoSize  = .T.
1168:             .FontName  = "Tahoma"
1169:             .FontSize  = 8
1170:             .ForeColor = RGB(90, 90, 90)
1171:             .Themes    = .F.
1172:         ENDWITH
1173:         WITH loc_oPagina.opt_4c_Fwoption1.Buttons(2)
1174:             .Caption   = "N" + CHR(227) + "o"
1175:             .BackStyle = 0
1176:             .Left      = 98
1177:             .Top       = 2
1178:             .AutoSize  = .T.
1179:             .FontName  = "Tahoma"
1180:             .FontSize  = 8
1181:             .ForeColor = RGB(90, 90, 90)
1182:             .Themes    = .F.
1183:         ENDWITH
1184: 
1185:         THIS.ConfigurarPgPage1()
1186:         THIS.ConfigurarPgPage2()
1187:         THIS.TornarControlesVisiveis(loc_oPagina)
1188:     ENDPROC
1189: 
1190:     *==========================================================================
1191:     * ConfigurarPgPage1 - Configura grd_4c_Grade (Grupos de Produto) do pgf_4c_Configuracao.Page1
1192:     *==========================================================================
1193:     PROTECTED PROCEDURE ConfigurarPgPage1()
1194:         LOCAL loc_oPgGrupos
1195:         loc_oPgGrupos = THIS.pgf_4c_Paginas.Page2.pgf_4c_Configuracao.Page1
1196: 
1197:         *-- grd_4c_Grade (Grupos de Produto: Top=16, Left=234, W=521, H=371, RecordSource=csGrade)
1198:         loc_oPgGrupos.AddObject("grd_4c_Grade", "Grid")
1199:         WITH loc_oPgGrupos.grd_4c_Grade
1200:             .Top               = 16
1201:             .Left              = 234
1202:             .Width             = 521
1203:             .Height            = 371
1204:             .ColumnCount       = 5
1205:             .FontName          = "Tahoma"
1206:             .FontSize          = 8
1207:             .AllowHeaderSizing = .F.
1208:             .AllowRowSizing    = .F.
1209:             .DeleteMark        = .F.
1210:             .RecordMark        = .F.
1211:             .HeaderHeight      = 16
1212:             .RowHeight         = 16
1213:             .ScrollBars        = 2
1214:             .GridLineColor     = RGB(238, 238, 238)
1215:             .RecordSource      = "csGrade"
1216:             .Visible           = .T.
1217:         ENDWITH
1218:         WITH loc_oPgGrupos.grd_4c_Grade.Column1
1219:             .ColumnOrder   = 2
1220:             .ControlSource = "csGrade.Cgrus"
1221:             .Width         = 42
1222:             .Movable       = .F.
1223:             .Resizable     = .F.
1224:         ENDWITH
1225:         loc_oPgGrupos.grd_4c_Grade.Column1.Header1.Caption = "Grupo"
1226:         WITH loc_oPgGrupos.grd_4c_Grade.Column2
1227:             .ColumnOrder   = 4
1228:             .ControlSource = "csGrade.Dgrus"
1229:             .Width         = 224
1230:             .Movable       = .F.
1231:             .Resizable     = .F.
1232:         ENDWITH
1233:         loc_oPgGrupos.grd_4c_Grade.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

*-- Linhas 1259 a 1314:
1259:         ENDWITH
1260:         loc_oPgGrupos.grd_4c_Grade.Column5.Header1.Caption = "Ordem"
1261:         loc_oPgGrupos.grd_4c_Grade.Column2.ReadOnly = .T.
1262:         BINDEVENT(loc_oPgGrupos.grd_4c_Grade.Column1.Text1, "When",      THIS, "GradeGrupoCol1When")
1263:         BINDEVENT(loc_oPgGrupos.grd_4c_Grade.Column1.Text1, "Valid",     THIS, "GradeGrupoCol1Valid")
1264:         BINDEVENT(loc_oPgGrupos.grd_4c_Grade.Column3.Text1, "When",      THIS, "GradeGrupoCol3When")
1265:         BINDEVENT(loc_oPgGrupos.grd_4c_Grade.Column3.Text1, "KeyPress", THIS, "GradeGrupoCol3LostFocus")
1266:         BINDEVENT(loc_oPgGrupos.grd_4c_Grade.Column4.Text1, "When",      THIS, "GradeGrupoCol4When")
1267:         BINDEVENT(loc_oPgGrupos.grd_4c_Grade.Column4.Text1, "Valid",     THIS, "GradeGrupoCol4Valid")
1268:     ENDPROC
1269: 
1270:     *==========================================================================
1271:     * ConfigurarPgPage2 - Configura grd_4c_Custo (Custos Fixo) do pgf_4c_Configuracao.Page2
1272:     * Original: SIGCDFTI.Pagina.Dados.Configuracao.Page2 - 4 colunas: Cpros/Dpros/Coefs/Seqs
1273:     *==========================================================================
1274:     PROTECTED PROCEDURE ConfigurarPgPage2()
1275:         LOCAL loc_oPgCusto
1276:         loc_oPgCusto = THIS.pgf_4c_Paginas.Page2.pgf_4c_Configuracao.Page2
1277: 
1278:         *-- grd_4c_Custo (Custo Fixo: Top=16, Left=278, W=478, H=371, RecordSource=csCusto)
1279:         loc_oPgCusto.AddObject("grd_4c_Custo", "Grid")
1280:         WITH loc_oPgCusto.grd_4c_Custo
1281:             .Top               = 16
1282:             .Left              = 278
1283:             .Width             = 478
1284:             .Height            = 371
1285:             .ColumnCount       = 4
1286:             .FontName          = "Tahoma"
1287:             .FontSize          = 8
1288:             .AllowHeaderSizing = .F.
1289:             .AllowRowSizing    = .F.
1290:             .DeleteMark        = .F.
1291:             .RecordMark        = .F.
1292:             .HeaderHeight      = 16
1293:             .RowHeight         = 16
1294:             .ScrollBars        = 2
1295:             .GridLineColor     = RGB(238, 238, 238)
1296:             .RecordSource      = "csCusto"
1297:             .Visible           = .T.
1298:         ENDWITH
1299:         WITH loc_oPgCusto.grd_4c_Custo.Column1
1300:             .ControlSource = "csCusto.Cpros"
1301:             .Width         = 108
1302:             .Movable       = .F.
1303:             .Resizable     = .F.
1304:         ENDWITH
1305:         loc_oPgCusto.grd_4c_Custo.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1306:         WITH loc_oPgCusto.grd_4c_Custo.Column2
1307:             .ControlSource = "csCusto.Dpros"
1308:             .Width         = 190
1309:             .Movable       = .F.
1310:             .Resizable     = .F.
1311:         ENDWITH
1312:         loc_oPgCusto.grd_4c_Custo.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1313:         loc_oPgCusto.grd_4c_Custo.Column2.ReadOnly = .T.
1314:         WITH loc_oPgCusto.grd_4c_Custo.Column3

*-- Linhas 1331 a 1780:
1331:         ENDWITH
1332:         loc_oPgCusto.grd_4c_Custo.Column4.Header1.Caption = "Seq" + CHR(252) + "encia"
1333:         loc_oPgCusto.grd_4c_Custo.Column4.Text1.InputMask = "99999"
1334:         BINDEVENT(loc_oPgCusto.grd_4c_Custo.Column1.Text1, "When",      THIS, "GradeCustoCol1When")
1335:         BINDEVENT(loc_oPgCusto.grd_4c_Custo.Column1.Text1, "Valid",     THIS, "GradeCustoCol1Valid")
1336:         BINDEVENT(loc_oPgCusto.grd_4c_Custo.Column3.Text1, "When",      THIS, "GradeCustoCol3When")
1337:         BINDEVENT(loc_oPgCusto.grd_4c_Custo.Column3.Text1, "KeyPress", THIS, "GradeCustoCol3LostFocus")
1338:         BINDEVENT(loc_oPgCusto.grd_4c_Custo.Column4.Text1, "When",      THIS, "GradeCustoCol4When")
1339:         BINDEVENT(loc_oPgCusto, "Activate", THIS, "ConfigPage2Activate")
1340:     ENDPROC
1341: 
1342:     *==========================================================================
1343:     * CarregarLista - Carrega dados no cursor da lista
1344:     * Grid e ControlSource: adicionados na Fase 4
1345:     *==========================================================================
1346:     PROCEDURE CarregarLista()
1347:         LOCAL loc_lResultado, loc_oGrid
1348:         loc_lResultado = .F.
1349: 
1350:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1351:             RETURN .T.
1352:         ENDIF
1353: 
1354:         TRY
1355:             IF !THIS.this_oBusinessObject.Buscar("")
1356:                 loc_lResultado = .F.
1357:             ELSE
1358:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
1359:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1360:                     loc_oGrid.ColumnCount = 5
1361:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
1362:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cods"
1363:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
1364:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.valors"
1365:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.moedas"
1366:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.acrescs"
1367:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1368:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1369:                     loc_oGrid.Column3.Header1.Caption = "Valor"
1370:                     loc_oGrid.Column4.Header1.Caption = "Moeda"
1371:                     loc_oGrid.Column5.Header1.Caption = "Acr" + CHR(233) + "scimo"
1372:                     loc_oGrid.Refresh()
1373:                 ENDIF
1374:                 loc_lResultado = .T.
1375:             ENDIF
1376:         CATCH TO loException
1377:             MsgErro("Erro em FormFti.CarregarLista:" + CHR(13) + loException.Message + ;
1378:                     CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
1379:             loc_lResultado = .F.
1380:         ENDTRY
1381: 
1382:         RETURN loc_lResultado
1383:     ENDPROC
1384: 
1385:     *==========================================================================
1386:     * AlternarPagina - Navega entre Page1 (1=Lista) e Page2 (2=Dados)
1387:     *==========================================================================
1388:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
1389:         LOCAL loc_lResultado
1390:         loc_lResultado = .F.
1391: 
1392:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
1393:             RETURN .F.
1394:         ENDIF
1395: 
1396:         TRY
1397:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1398:             IF par_nPagina = 1
1399:                 THIS.this_cModoAtual = "LISTA"
1400:                 THIS.CarregarLista()
1401:             ENDIF
1402:             loc_lResultado = .T.
1403:         CATCH TO loException
1404:             MsgErro("Erro em FormFti.AlternarPagina:" + CHR(13) + loException.Message, "Erro")
1405:         ENDTRY
1406: 
1407:         RETURN loc_lResultado
1408:     ENDPROC
1409: 
1410:     *==========================================================================
1411:     * BtnEncerrarClick - Fecha o formulario
1412:     *==========================================================================
1413:     PROCEDURE BtnEncerrarClick()
1414:         THIS.Release()
1415:     ENDPROC
1416: 
1417:     *==========================================================================
1418:     * BtnExpXMLClick - Exporta XML do feitio selecionado
1419:     *==========================================================================
1420:     PROCEDURE BtnExpXMLClick()
1421:         LOCAL loc_lResultado, loc_cCodigo
1422:         loc_lResultado = .F.
1423: 
1424:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1425:             MsgAviso("Selecione um feitio para exportar.", "Exportar XML")
1426:             RETURN .F.
1427:         ENDIF
1428: 
1429:         SELECT cursor_4c_Dados
1430:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
1431: 
1432:         IF EMPTY(loc_cCodigo)
1433:             MsgAviso("Selecione um feitio para exportar.", "Exportar XML")
1434:             RETURN .F.
1435:         ENDIF
1436: 
1437:         TRY
1438:             THIS.LockScreen = .T.
1439:             DO FORM SigOpXml WITH THIS, loc_cCodigo, "E", "FEITIO", 2
1440:             THIS.this_cUltCodigo = loc_cCodigo
1441:             THIS.AlternarPagina(1)
1442:             IF USED("cursor_4c_Dados")
1443:                 SELECT cursor_4c_Dados
1444:                 LOCATE FOR ALLTRIM(cods) == THIS.this_cUltCodigo
1445:             ENDIF
1446:             THIS.LockScreen = .F.
1447:             loc_lResultado = .T.
1448:         CATCH TO loException
1449:             THIS.LockScreen = .F.
1450:             MsgErro("Erro em FormFti.BtnExpXMLClick:" + CHR(13) + loException.Message, "Erro")
1451:         ENDTRY
1452: 
1453:         RETURN loc_lResultado
1454:     ENDPROC
1455: 
1456:     *==========================================================================
1457:     * BtnImpXMLClick - Importa XML de feitio
1458:     *==========================================================================
1459:     PROCEDURE BtnImpXMLClick()
1460:         LOCAL loc_lResultado, loc_cCodigo
1461:         loc_lResultado = .F.
1462: 
1463:         TRY
1464:             THIS.LockScreen = .T.
1465:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1466:                 SELECT cursor_4c_Dados
1467:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
1468:             ELSE
1469:                 loc_cCodigo = ""
1470:             ENDIF
1471: 
1472:             DO FORM SigOpXml WITH THIS, "", "I", "FEITIO", 2
1473:             THIS.this_cUltCodigo = loc_cCodigo
1474:             THIS.AlternarPagina(1)
1475:             IF USED("cursor_4c_Dados") AND !EMPTY(THIS.this_cUltCodigo)
1476:                 SELECT cursor_4c_Dados
1477:                 LOCATE FOR ALLTRIM(cods) == THIS.this_cUltCodigo
1478:             ENDIF
1479:             THIS.LockScreen = .F.
1480:             loc_lResultado = .T.
1481:         CATCH TO loException
1482:             THIS.LockScreen = .F.
1483:             MsgErro("Erro em FormFti.BtnImpXMLClick:" + CHR(13) + loException.Message, "Erro")
1484:         ENDTRY
1485: 
1486:         RETURN loc_lResultado
1487:     ENDPROC
1488: 
1489:     *==========================================================================
1490:     * BtnSalvarClick - Valida e salva registro + itens
1491:     *==========================================================================
1492:     PROCEDURE BtnSalvarClick()
1493:         LOCAL loc_lResultado, loc_oPg2, loc_cCodigo, loc_cDescricao
1494:         LOCAL loc_cCdMoeda, loc_nValor
1495:         loc_lResultado = .F.
1496: 
1497:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1498: 
1499:         *-- Validacoes obrigatorias fora do TRY (REGRA CRITICA: sem RETURN dentro TRY)
1500:         loc_cCodigo    = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
1501:         loc_cDescricao = ALLTRIM(loc_oPg2.txt_4c_Descricao.Value)
1502:         loc_cCdMoeda   = ALLTRIM(loc_oPg2.txt_4c_CdMoeda.Value)
1503:         loc_nValor     = loc_oPg2.txt_4c_Valor.Value
1504: 
1505:         IF EMPTY(loc_cCodigo)
1506:             MsgAviso("C" + CHR(243) + "digo inv" + CHR(225) + "lido!", "Valida" + CHR(231) + CHR(227) + "o")
1507:             loc_oPg2.txt_4c_Codigo.SetFocus
1508:             RETURN .F.
1509:         ENDIF
1510: 
1511:         IF EMPTY(loc_cDescricao)
1512:             MsgAviso("Descri" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida!", "Valida" + CHR(231) + CHR(227) + "o")
1513:             loc_oPg2.txt_4c_Descricao.SetFocus
1514:             RETURN .F.
1515:         ENDIF
1516: 
1517:         IF EMPTY(loc_cCdMoeda) AND loc_nValor <> 0
1518:             MsgAviso("Obrigat" + CHR(243) + "rio informar moeda!", "Valida" + CHR(231) + CHR(227) + "o")
1519:             loc_oPg2.txt_4c_CdMoeda.SetFocus
1520:             RETURN .F.
1521:         ENDIF
1522: 
1523:         IF THIS.this_cModoAtual = "INCLUIR"
1524:             IF THIS.this_oBusinessObject.VerificarCodigoExistente(loc_cCodigo)
1525:                 MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!", "Valida" + CHR(231) + CHR(227) + "o")
1526:                 loc_oPg2.txt_4c_Codigo.SetFocus
1527:                 RETURN .F.
1528:             ENDIF
1529:         ENDIF
1530: 
1531:         IF !THIS.this_oBusinessObject.ValidarDuplicidade()
1532:             RETURN .F.
1533:         ENDIF
1534: 
1535:         IF !THIS.this_oBusinessObject.ValidarFaixa()
1536:             RETURN .F.
1537:         ENDIF
1538: 
1539:         IF !THIS.this_oBusinessObject.ValidarConflitoCampos()
1540:             RETURN .F.
1541:         ENDIF
1542: 
1543:         TRY
1544:             THIS.FormParaBO()
1545: 
1546:             IF THIS.this_oBusinessObject.Salvar()
1547:                 IF THIS.this_oBusinessObject.SalvarItens(THIS.this_oBusinessObject.this_cCodigo)
1548:                     MsgInfo("Feitio salvo com sucesso!", "Salvo")
1549:                     THIS.AlternarPagina(1)
1550:                     loc_lResultado = .T.
1551:                 ELSE
1552:                     MsgErro("Erro ao salvar itens do feitio.", "Erro")
1553:                 ENDIF
1554:             ENDIF
1555:         CATCH TO loException
1556:             MsgErro("Erro em FormFti.BtnSalvarClick:" + CHR(13) + loException.Message + ;
1557:                     CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
1558:         ENDTRY
1559: 
1560:         RETURN loc_lResultado
1561:     ENDPROC
1562: 
1563:     *==========================================================================
1564:     * BtnCancelarClick - Cancela edicao e volta para lista
1565:     *==========================================================================
1566:     PROCEDURE BtnCancelarClick()
1567:         THIS.AlternarPagina(1)
1568:         THIS.this_cModoAtual = "LISTA"
1569:     ENDPROC
1570: 
1571:     *==========================================================================
1572:     * BtnExcluirLinhaClick - Exclui linha selecionada de csGrade ou csCusto
1573:     *==========================================================================
1574:     PROCEDURE BtnExcluirLinhaClick()
1575:         LOCAL loc_oPgConf, loc_cCursor, loc_nPos, loc_nTotal
1576:         LOCAL loc_lResultado
1577:         loc_lResultado = .F.
1578: 
1579:         loc_oPgConf = THIS.pgf_4c_Paginas.Page2.pgf_4c_Configuracao
1580:         loc_cCursor = IIF(loc_oPgConf.ActivePage = 1, "csGrade", "csCusto")
1581: 
1582:         IF !USED(loc_cCursor) OR EOF(loc_cCursor) OR BOF(loc_cCursor)
1583:             RETURN
1584:         ENDIF
1585: 
1586:         TRY
1587:             SELECT (loc_cCursor)
1588:             loc_nPos   = RECNO()
1589:             COUNT TO loc_nTotal
1590: 
1591:             IF loc_nTotal > 1
1592:                 IF MsgConfirma("Deseja excluir esta opera" + CHR(231) + CHR(227) + "o?", "Excluir Linha")
1593:                     SELECT (loc_cCursor)
1594:                     GO (loc_nPos)
1595:                     DELETE
1596:                     PACK
1597:                 ENDIF
1598:             ELSE
1599:                 MsgAviso("N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + "vel excluir o " + ;
1600:                          CHR(250) + "nico registro.", "Excluir Linha")
1601:             ENDIF
1602:         CATCH TO loException
1603:             MsgErro("Erro em FormFti.BtnExcluirLinhaClick:" + CHR(13) + loException.Message, "Erro")
1604:         ENDTRY
1605:     ENDPROC
1606: 
1607:     *==========================================================================
1608:     * FormParaBO - Transfere valores do Form para o BO
1609:     *==========================================================================
1610:     PROTECTED PROCEDURE FormParaBO()
1611:         LOCAL loc_oPg2
1612:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1613: 
1614:         THIS.this_oBusinessObject.this_cCodigo       = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
1615:         THIS.this_oBusinessObject.this_cDescricao    = ALLTRIM(loc_oPg2.txt_4c_Descricao.Value)
1616:         THIS.this_oBusinessObject.this_nValor        = loc_oPg2.txt_4c_Valor.Value
1617:         THIS.this_oBusinessObject.this_cMoeda        = ALLTRIM(loc_oPg2.txt_4c_CdMoeda.Value)
1618:         THIS.this_oBusinessObject.this_cDescMoeda    = ALLTRIM(loc_oPg2.txt_4c_DsMoeda.Value)
1619:         THIS.this_oBusinessObject.this_nAcrescimo    = loc_oPg2.txt_4c_Acrescimo.Value
1620:         THIS.this_oBusinessObject.this_nTipoFeitio   = loc_oPg2.opt_4c_TpFtio.Value
1621:         THIS.this_oBusinessObject.this_nFaixaInicial = loc_oPg2.txt_4c_FaixaI.Value
1622:         THIS.this_oBusinessObject.this_nFaixaFinal   = loc_oPg2.txt_4c_Faixaf.Value
1623:         THIS.this_oBusinessObject.this_nPerdas       = loc_oPg2.txt_4c_Perdas.Value
1624:         THIS.this_oBusinessObject.this_nDivMult      = loc_oPg2.opt_4c_Cfixo.Value
1625:         THIS.this_oBusinessObject.this_nTipo         = loc_oPg2.opt_4c_CusVenda.Value
1626:         THIS.this_oBusinessObject.this_nAplscus      = loc_oPg2.opt_4c_Fwoption1.Value
1627:         THIS.this_oBusinessObject.this_nEtiquetas    = loc_oPg2.opt_4c_Etiquetas.Value
1628:     ENDPROC
1629: 
1630:     *==========================================================================
1631:     * BOParaForm - Transfere valores do BO para o Form
1632:     *==========================================================================
1633:     PROTECTED PROCEDURE BOParaForm()
1634:         LOCAL loc_oPg2
1635:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1636: 
1637:         loc_oPg2.txt_4c_Codigo.Value    = THIS.this_oBusinessObject.this_cCodigo
1638:         loc_oPg2.txt_4c_Descricao.Value = THIS.this_oBusinessObject.this_cDescricao
1639:         loc_oPg2.txt_4c_Valor.Value     = THIS.this_oBusinessObject.this_nValor
1640:         loc_oPg2.txt_4c_CdMoeda.Value   = THIS.this_oBusinessObject.this_cMoeda
1641:         loc_oPg2.txt_4c_DsMoeda.Value   = THIS.this_oBusinessObject.this_cDescMoeda
1642:         loc_oPg2.txt_4c_Acrescimo.Value = THIS.this_oBusinessObject.this_nAcrescimo
1643:         loc_oPg2.opt_4c_TpFtio.Value    = THIS.this_oBusinessObject.this_nTipoFeitio
1644:         loc_oPg2.txt_4c_FaixaI.Value    = THIS.this_oBusinessObject.this_nFaixaInicial
1645:         loc_oPg2.txt_4c_Faixaf.Value    = THIS.this_oBusinessObject.this_nFaixaFinal
1646:         loc_oPg2.txt_4c_Perdas.Value    = THIS.this_oBusinessObject.this_nPerdas
1647:         loc_oPg2.opt_4c_Cfixo.Value     = THIS.this_oBusinessObject.this_nDivMult
1648:         loc_oPg2.opt_4c_CusVenda.Value  = THIS.this_oBusinessObject.this_nTipo
1649:         loc_oPg2.opt_4c_Fwoption1.Value = THIS.this_oBusinessObject.this_nAplscus
1650:         loc_oPg2.opt_4c_Etiquetas.Value = THIS.this_oBusinessObject.this_nEtiquetas
1651:     ENDPROC
1652: 
1653:     *==========================================================================
1654:     * LimparCampos - Limpa valores dos campos da Page2
1655:     *==========================================================================
1656:     PROTECTED PROCEDURE LimparCampos()
1657:         LOCAL loc_oPg2
1658:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1659: 
1660:         loc_oPg2.txt_4c_Codigo.Value    = ""
1661:         loc_oPg2.txt_4c_Descricao.Value = ""
1662:         loc_oPg2.txt_4c_Valor.Value     = 0
1663:         loc_oPg2.txt_4c_CdMoeda.Value   = ""
1664:         loc_oPg2.txt_4c_DsMoeda.Value   = ""
1665:         loc_oPg2.txt_4c_Acrescimo.Value = 0
1666:         loc_oPg2.opt_4c_TpFtio.Value    = 1
1667:         loc_oPg2.txt_4c_FaixaI.Value    = 0
1668:         loc_oPg2.txt_4c_Faixaf.Value    = 0
1669:         loc_oPg2.txt_4c_Perdas.Value    = 0
1670:         loc_oPg2.opt_4c_Cfixo.Value     = 1
1671:         loc_oPg2.opt_4c_CusVenda.Value  = 2
1672:         loc_oPg2.opt_4c_Fwoption1.Value = 2
1673:         loc_oPg2.opt_4c_Etiquetas.Value = 3
1674: 
1675:         IF USED("csGrade")
1676:             SELECT csGrade
1677:             ZAP
1678:         ENDIF
1679:         IF USED("csCusto")
1680:             SELECT csCusto
1681:             ZAP
1682:         ENDIF
1683:     ENDPROC
1684: 
1685:     *==========================================================================
1686:     * HabilitarCampos - Habilita ou desabilita campos editaveis
1687:     *==========================================================================
1688:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1689:         LOCAL loc_oPg2
1690:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1691: 
1692:         loc_oPg2.txt_4c_Codigo.Enabled    = (par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
1693:         loc_oPg2.txt_4c_Descricao.Enabled = par_lHabilitar
1694:         loc_oPg2.txt_4c_Valor.Enabled     = par_lHabilitar
1695:         loc_oPg2.txt_4c_CdMoeda.Enabled   = par_lHabilitar
1696:         loc_oPg2.txt_4c_DsMoeda.Enabled   = par_lHabilitar
1697:         loc_oPg2.txt_4c_Acrescimo.Enabled = par_lHabilitar
1698:         loc_oPg2.opt_4c_TpFtio.Enabled    = par_lHabilitar
1699:         loc_oPg2.txt_4c_FaixaI.Enabled    = par_lHabilitar
1700:         loc_oPg2.txt_4c_Faixaf.Enabled    = par_lHabilitar
1701:         loc_oPg2.txt_4c_Perdas.Enabled    = par_lHabilitar
1702:         loc_oPg2.opt_4c_Cfixo.Enabled     = par_lHabilitar
1703:         loc_oPg2.opt_4c_CusVenda.Enabled  = par_lHabilitar
1704:         loc_oPg2.opt_4c_Fwoption1.Enabled = par_lHabilitar
1705:         loc_oPg2.opt_4c_Etiquetas.Enabled = par_lHabilitar
1706: 
1707:         loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = par_lHabilitar
1708:         loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
1709:         loc_oPg2.cnt_4c_BotoesLinha.cmd_4c_ExcluirLinha.Enabled = par_lHabilitar
1710: 
1711:         IF PEMSTATUS(loc_oPg2.pgf_4c_Configuracao.Page1, "grd_4c_Grade", 5)
1712:             loc_oPg2.pgf_4c_Configuracao.Page1.grd_4c_Grade.ReadOnly = !par_lHabilitar
1713:         ENDIF
1714:         IF PEMSTATUS(loc_oPg2.pgf_4c_Configuracao.Page2, "grd_4c_Custo", 5)
1715:             loc_oPg2.pgf_4c_Configuracao.Page2.grd_4c_Custo.ReadOnly = !par_lHabilitar
1716:         ENDIF
1717:     ENDPROC
1718: 
1719:     *==========================================================================
1720:     * AjustarBotoesPorModo - Ajusta botoes CRUD conforme modo atual
1721:     *==========================================================================
1722:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1723:         LOCAL loc_oBotoes, loc_lEditando, loc_lVisualizando
1724:         loc_oBotoes      = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
1725:         loc_lEditando    = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1726:         loc_lVisualizando = (THIS.this_cModoAtual = "VISUALIZAR")
1727: 
1728:         IF PEMSTATUS(loc_oBotoes, "cmd_4c_Incluir", 5)
1729:             loc_oBotoes.cmd_4c_Incluir.Enabled    = !loc_lEditando AND !loc_lVisualizando
1730:             loc_oBotoes.cmd_4c_Alterar.Enabled    = !loc_lEditando AND !loc_lVisualizando
1731:             loc_oBotoes.cmd_4c_Excluir.Enabled    = !loc_lEditando AND !loc_lVisualizando
1732:             loc_oBotoes.cmd_4c_Visualizar.Enabled = !loc_lEditando AND !loc_lVisualizando
1733:             loc_oBotoes.cmd_4c_Buscar.Enabled     = !loc_lEditando AND !loc_lVisualizando
1734:         ENDIF
1735:     ENDPROC
1736: 
1737:     *==========================================================================
1738:     * CarregarItensNaGrade - Carrega SigPrFto nos cursores csGrade e csCusto
1739:     *==========================================================================
1740:     PROTECTED PROCEDURE CarregarItensNaGrade(par_cCodigo)
1741:         LOCAL loc_lResultado
1742:         loc_lResultado = .F.
1743: 
1744:         TRY
1745:             IF USED("csGrade")
1746:                 SELECT csGrade
1747:                 ZAP
1748:             ENDIF
1749:             IF USED("csCusto")
1750:                 SELECT csCusto
1751:                 ZAP
1752:             ENDIF
1753: 
1754:             IF THIS.this_oBusinessObject.CarregarItens(par_cCodigo) AND USED("cursor_4c_Itens")
1755:                 SELECT cursor_4c_Itens
1756:                 GO TOP
1757:                 SCAN
1758:                     IF !EMPTY(ALLTRIM(cursor_4c_Itens.cgrus))
1759:                         INSERT INTO csGrade (Cgrus, CPros, Dgrus, Coefs, Ordem) ;
1760:                             VALUES (ALLTRIM(cursor_4c_Itens.cgrus), ;
1761:                                     ALLTRIM(cursor_4c_Itens.cpros), ;
1762:                                     "", ;
1763:                                     cursor_4c_Itens.coefs, ;
1764:                                     cursor_4c_Itens.ordem)
1765:                         IF USED("CrSigCdGrp")
1766:                             SELECT CrSigCdGrp
1767:                             IF SEEK(ALLTRIM(cursor_4c_Itens.cgrus), "CrSigCdGrp", "Cgrus")
1768:                                 SELECT csGrade
1769:                                 GO BOTTOM
1770:                                 REPLACE Dgrus WITH ALLTRIM(CrSigCdGrp.Dgrus)
1771:                             ENDIF
1772:                         ENDIF
1773:                     ELSE
1774:                         INSERT INTO csCusto (Cpros, Dpros, Seqs, Coefs) ;
1775:                             VALUES (ALLTRIM(cursor_4c_Itens.cpros), ;
1776:                                     "", ;
1777:                                     cursor_4c_Itens.seqs, ;
1778:                                     cursor_4c_Itens.coefs)
1779:                         IF USED("CrSigCdPro")
1780:                             SELECT CrSigCdPro

*-- Linhas 1812 a 2465:
1812:     ENDPROC
1813: 
1814:     *==========================================================================
1815:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
1816:     *==========================================================================
1817:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1818:         LOCAL loc_nI, loc_oObjeto, loc_nP
1819: 
1820:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1821:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1822: 
1823:             IF VARTYPE(loc_oObjeto) = "O"
1824:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1825:                     loc_oObjeto.Visible = .T.
1826:                 ENDIF
1827: 
1828:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1829:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1830:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1831:                     ENDFOR
1832:                 ENDIF
1833: 
1834:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
1835:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1836:                 ENDIF
1837:             ENDIF
1838:         ENDFOR
1839:     ENDPROC
1840: 
1841:     *==========================================================================
1842:     * FormatarGridLista - Formata visual do grid da lista
1843:     *==========================================================================
1844:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1845:         WITH par_oGrid
1846:             .FontName = "Verdana"
1847:             .FontSize = 8
1848:         ENDWITH
1849:     ENDPROC
1850: 
1851:     *==========================================================================
1852:     * BtnIncluirClick - Abre Page2 para novo registro
1853:     *==========================================================================
1854:     PROCEDURE BtnIncluirClick()
1855:         THIS.this_cModoAtual = "INCLUIR"
1856:         THIS.this_oBusinessObject.NovoRegistro()
1857:         THIS.LimparCampos()
1858:         THIS.CriarCursoresGrade()
1859:         THIS.CarregarItensNaGrade("")
1860:         THIS.HabilitarCampos(.T.)
1861:         THIS.AjustarBotoesPorModo()
1862:         THIS.AlternarPagina(2)
1863:     ENDPROC
1864: 
1865:     *==========================================================================
1866:     * BtnVisualizarClick - Abre Page2 para visualizacao do registro selecionado
1867:     *==========================================================================
1868:     PROCEDURE BtnVisualizarClick()
1869:         LOCAL loc_cCodigo
1870:         loc_cCodigo = ""
1871: 
1872:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
1873:             MsgAviso("Selecione um registro.", "Visualizar")
1874:             RETURN
1875:         ENDIF
1876: 
1877:         SELECT cursor_4c_Dados
1878:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
1879: 
1880:         IF EMPTY(loc_cCodigo)
1881:             MsgAviso("Selecione um registro.", "Visualizar")
1882:             RETURN
1883:         ENDIF
1884: 
1885:         THIS.this_cUltCodigo = loc_cCodigo
1886:         THIS.this_cModoAtual = "VISUALIZAR"
1887:         THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1888:         THIS.BOParaForm()
1889:         THIS.CriarCursoresGrade()
1890:         THIS.CarregarItensNaGrade(loc_cCodigo)
1891:         THIS.HabilitarCampos(.F.)
1892:         THIS.AjustarBotoesPorModo()
1893:         THIS.AlternarPagina(2)
1894:     ENDPROC
1895: 
1896:     *==========================================================================
1897:     * BtnAlterarClick - Abre Page2 para edicao do registro selecionado
1898:     *==========================================================================
1899:     PROCEDURE BtnAlterarClick()
1900:         LOCAL loc_cCodigo
1901:         loc_cCodigo = ""
1902: 
1903:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
1904:             MsgAviso("Selecione um registro para alterar.", "Alterar")
1905:             RETURN
1906:         ENDIF
1907: 
1908:         SELECT cursor_4c_Dados
1909:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
1910: 
1911:         IF EMPTY(loc_cCodigo)
1912:             MsgAviso("Selecione um registro para alterar.", "Alterar")
1913:             RETURN
1914:         ENDIF
1915: 
1916:         THIS.this_cUltCodigo = loc_cCodigo
1917:         THIS.this_cModoAtual = "ALTERAR"
1918:         THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1919:         THIS.this_oBusinessObject.EditarRegistro()
1920:         THIS.BOParaForm()
1921:         THIS.CriarCursoresGrade()
1922:         THIS.CarregarItensNaGrade(loc_cCodigo)
1923:         THIS.HabilitarCampos(.T.)
1924:         THIS.AjustarBotoesPorModo()
1925:         THIS.AlternarPagina(2)
1926:     ENDPROC
1927: 
1928:     *==========================================================================
1929:     * BtnExcluirClick - Exclui registro selecionado apos confirmacao
1930:     *==========================================================================
1931:     PROCEDURE BtnExcluirClick()
1932:         LOCAL loc_cCodigo, loc_lResultado
1933:         loc_cCodigo    = ""
1934:         loc_lResultado = .F.
1935: 
1936:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
1937:             MsgAviso("Selecione um registro para excluir.", "Excluir")
1938:             RETURN
1939:         ENDIF
1940: 
1941:         SELECT cursor_4c_Dados
1942:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
1943: 
1944:         IF EMPTY(loc_cCodigo)
1945:             MsgAviso("Selecione um registro para excluir.", "Excluir")
1946:             RETURN
1947:         ENDIF
1948: 
1949:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do feitio '" + loc_cCodigo + "'?", "Excluir")
1950:             RETURN
1951:         ENDIF
1952: 
1953:         TRY
1954:             THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1955:             IF THIS.this_oBusinessObject.Excluir()
1956:                 THIS.this_cUltCodigo = ""
1957:                 THIS.CarregarLista()
1958:                 loc_lResultado = .T.
1959:             ENDIF
1960:         CATCH TO loException
1961:             MsgErro("Erro em FormFti.BtnExcluirClick:" + CHR(13) + loException.Message + ;
1962:                     CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
1963:         ENDTRY
1964:     ENDPROC
1965: 
1966:     *==========================================================================
1967:     * BtnBuscarClick - Filtra lista de feitios por codigo ou descricao
1968:     *==========================================================================
1969:     PROCEDURE BtnBuscarClick()
1970:         LOCAL loc_cFiltro, loc_cTexto, loc_oGrid
1971:         loc_cFiltro = ""
1972:         loc_cTexto  = INPUTBOX("Digite o c" + CHR(243) + "digo ou descri" + CHR(231) + CHR(227) + "o:", ;
1973:                                "Buscar Feitios", "")
1974: 
1975:         IF EMPTY(ALLTRIM(loc_cTexto))
1976:             THIS.CarregarLista()
1977:             RETURN
1978:         ENDIF
1979: 
1980:         loc_cFiltro = "cods LIKE " + EscaparSQL(ALLTRIM(loc_cTexto) + "%")
1981: 
1982:         TRY
1983:             IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
1984:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
1985:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1986:                     loc_oGrid.ColumnCount = 5
1987:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
1988:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cods"
1989:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
1990:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.valors"
1991:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.moedas"
1992:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.acrescs"
1993:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1994:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1995:                     loc_oGrid.Column3.Header1.Caption = "Valor"
1996:                     loc_oGrid.Column4.Header1.Caption = "Moeda"
1997:                     loc_oGrid.Column5.Header1.Caption = "Acr" + CHR(233) + "scimo"
1998:                     loc_oGrid.Refresh()
1999:                 ENDIF
2000:                 IF RECCOUNT("cursor_4c_Dados") = 0
2001:                     MsgAviso("Nenhum registro encontrado.", "Buscar")
2002:                 ENDIF
2003:             ENDIF
2004:         CATCH TO loException
2005:             MsgErro("Erro em FormFti.BtnBuscarClick:" + CHR(13) + loException.Message, "Erro")
2006:         ENDTRY
2007:     ENDPROC
2008: 
2009:     *==========================================================================
2010:     * Destroy - Limpeza ao fechar
2011:     *==========================================================================
2012:     PROCEDURE Destroy()
2013:         LOCAL loc_aCursores(4), loc_i
2014:         loc_aCursores(1) = "csGrade"
2015:         loc_aCursores(2) = "csCusto"
2016:         loc_aCursores(3) = "TmpBranco"
2017:         loc_aCursores(4) = "CsDuplica"
2018: 
2019:         FOR loc_i = 1 TO ALEN(loc_aCursores)
2020:             IF USED(loc_aCursores(loc_i))
2021:                 USE IN (loc_aCursores(loc_i))
2022:             ENDIF
2023:         ENDFOR
2024: 
2025:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2026:             THIS.this_oBusinessObject = .NULL.
2027:         ENDIF
2028: 
2029:         DODEFAULT()
2030:     ENDPROC
2031: 
2032:     *==========================================================================
2033:     * TpFtioChanged - InteractiveChange do opt_4c_TpFtio
2034:     * Value=3 (Sem Feitio): zera txt_4c_Valor e txt_4c_Acrescimo
2035:     *==========================================================================
2036:     PROCEDURE TpFtioChanged()
2037:         LOCAL loc_oPg2
2038:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2039: 
2040:         IF PEMSTATUS(loc_oPg2, "opt_4c_TpFtio", 5) AND loc_oPg2.opt_4c_TpFtio.Value = 3
2041:             IF PEMSTATUS(loc_oPg2, "txt_4c_Valor", 5)
2042:                 loc_oPg2.txt_4c_Valor.Value = 0
2043:             ENDIF
2044:             IF PEMSTATUS(loc_oPg2, "txt_4c_Acrescimo", 5)
2045:                 loc_oPg2.txt_4c_Acrescimo.Value = 0
2046:             ENDIF
2047:         ENDIF
2048:     ENDPROC
2049: 
2050:     *==========================================================================
2051:     * ValidarCdMoeda - LostFocus de txt_4c_CdMoeda
2052:     * Lookup em SigCdMoe por cmoes (codigo); preenche txt_4c_DsMoeda
2053:     *==========================================================================
2054:     PROCEDURE ValidarCdMoeda(par_nKeyCode, par_nShiftAltCtrl)
2055:         LOCAL loc_cCd, loc_lResultado, loc_oBusca
2056:         loc_lResultado = .F.
2057:         loc_cCd        = ""
2058: 
2059:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_CdMoeda", 5)
2060:             loc_cCd = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_CdMoeda.Value)
2061:         ENDIF
2062: 
2063:         IF EMPTY(loc_cCd)
2064:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_DsMoeda", 5)
2065:                 THIS.pgf_4c_Paginas.Page2.txt_4c_DsMoeda.Value = ""
2066:             ENDIF
2067:             RETURN
2068:         ENDIF
2069: 
2070:         TRY
2071:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2072:                 "SigCdMoe", "CrMoedas", "cmoes", loc_cCd, "Moedas")
2073: 
2074:             IF VARTYPE(loc_oBusca) = "O"
2075:                 IF !loc_oBusca.this_lAchouRegistro
2076:                     loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
2077:                     loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
2078:                     loc_oBusca.Show()
2079:                 ENDIF
2080: 
2081:                 IF loc_oBusca.this_lSelecionou AND USED("CrMoedas")
2082:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_CdMoeda", 5)
2083:                         THIS.pgf_4c_Paginas.Page2.txt_4c_CdMoeda.Value = ALLTRIM(CrMoedas.cmoes)
2084:                     ENDIF
2085:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_DsMoeda", 5)
2086:                         THIS.pgf_4c_Paginas.Page2.txt_4c_DsMoeda.Value = ALLTRIM(CrMoedas.dmoes)
2087:                     ENDIF
2088:                     loc_lResultado = .T.
2089:                 ENDIF
2090: 
2091:                 loc_oBusca.Release()
2092:             ENDIF
2093:         CATCH TO loException
2094:             MsgErro("Erro em FormFti.ValidarCdMoeda:" + CHR(13) + loException.Message, "Erro")
2095:         ENDTRY
2096: 
2097:         IF USED("CrMoedas")
2098:             USE IN CrMoedas
2099:         ENDIF
2100:     ENDPROC
2101: 
2102:     *==========================================================================
2103:     * ValidarDsMoeda - LostFocus de txt_4c_DsMoeda
2104:     * Lookup em SigCdMoe por dmoes (descricao); preenche txt_4c_CdMoeda
2105:     *==========================================================================
2106:     PROCEDURE ValidarDsMoeda(par_nKeyCode, par_nShiftAltCtrl)
2107:         LOCAL loc_cDs, loc_lResultado, loc_oBusca
2108:         loc_lResultado = .F.
2109:         loc_cDs        = ""
2110: 
2111:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_DsMoeda", 5)
2112:             loc_cDs = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_DsMoeda.Value)
2113:         ENDIF
2114: 
2115:         IF EMPTY(loc_cDs)
2116:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_CdMoeda", 5)
2117:                 THIS.pgf_4c_Paginas.Page2.txt_4c_CdMoeda.Value = ""
2118:             ENDIF
2119:             RETURN
2120:         ENDIF
2121: 
2122:         TRY
2123:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2124:                 "SigCdMoe", "CrMoedas", "dmoes", loc_cDs, "Moedas")
2125: 
2126:             IF VARTYPE(loc_oBusca) = "O"
2127:                 IF !loc_oBusca.this_lAchouRegistro
2128:                     loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
2129:                     loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
2130:                     loc_oBusca.Show()
2131:                 ENDIF
2132: 
2133:                 IF loc_oBusca.this_lSelecionou AND USED("CrMoedas")
2134:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_DsMoeda", 5)
2135:                         THIS.pgf_4c_Paginas.Page2.txt_4c_DsMoeda.Value = ALLTRIM(CrMoedas.dmoes)
2136:                     ENDIF
2137:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_CdMoeda", 5)
2138:                         THIS.pgf_4c_Paginas.Page2.txt_4c_CdMoeda.Value = ALLTRIM(CrMoedas.cmoes)
2139:                     ENDIF
2140:                     loc_lResultado = .T.
2141:                 ENDIF
2142: 
2143:                 loc_oBusca.Release()
2144:             ENDIF
2145:         CATCH TO loException
2146:             MsgErro("Erro em FormFti.ValidarDsMoeda:" + CHR(13) + loException.Message, "Erro")
2147:         ENDTRY
2148: 
2149:         IF USED("CrMoedas")
2150:             USE IN CrMoedas
2151:         ENDIF
2152:     ENDPROC
2153: 
2154:     *==========================================================================
2155:     * ConfigPage2Activate - Atualiza caption Column3 do grd_4c_Custo (Page2.Activate)
2156:     *==========================================================================
2157:     PROCEDURE ConfigPage2Activate()
2158:         LOCAL loc_oPg2, loc_cCaption
2159:         loc_cCaption = "Coeficiente"
2160:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2161: 
2162:         IF PEMSTATUS(loc_oPg2, "opt_4c_Cfixo", 5)
2163:             IF loc_oPg2.opt_4c_Cfixo.Value = 2
2164:                 loc_cCaption = "( % )"
2165:             ENDIF
2166:         ENDIF
2167: 
2168:         IF PEMSTATUS(loc_oPg2.pgf_4c_Configuracao.Page2, "grd_4c_Custo", 5)
2169:             loc_oPg2.pgf_4c_Configuracao.Page2.grd_4c_Custo.Column3.Header1.Caption = loc_cCaption
2170:             loc_oPg2.pgf_4c_Configuracao.Page2.grd_4c_Custo.Column3.Header1.Refresh()
2171:         ENDIF
2172:     ENDPROC
2173: 
2174:     *==========================================================================
2175:     * GradeGrupoCol1When - When do Col1 (Cgrus) do grd_4c_Grade: salva AntValue
2176:     *==========================================================================
2177:     PROCEDURE GradeGrupoCol1When()
2178:         IF USED("csGrade") AND !EOF("csGrade") AND !BOF("csGrade")
2179:             THIS.this_cAntValue = ALLTRIM(csGrade.Cgrus)
2180:         ENDIF
2181:         RETURN .T.
2182:     ENDPROC
2183: 
2184:     *==========================================================================
2185:     * GradeGrupoCol1Valid - Valid do Col1 (Cgrus): valida grupo, preenche Dgrus+Coefs
2186:     *==========================================================================
2187:     PROCEDURE GradeGrupoCol1Valid()
2188:         LOCAL loc_lResultado, loc_cCodigo, loc_cSelecionado, loc_oBusca
2189:         loc_lResultado = .T.
2190: 
2191:         IF !USED("csGrade") OR EOF("csGrade") OR BOF("csGrade")
2192:             RETURN loc_lResultado
2193:         ENDIF
2194: 
2195:         loc_cCodigo = ALLTRIM(csGrade.Cgrus)
2196: 
2197:         IF EMPTY(loc_cCodigo) OR loc_cCodigo = THIS.this_cAntValue
2198:             RETURN loc_lResultado
2199:         ENDIF
2200: 
2201:         TRY
2202:             IF SEEK(loc_cCodigo, "CrSigCdGrp", "Cgrus")
2203:                 SELECT csGrade
2204:                 REPLACE Dgrus WITH ALLTRIM(CrSigCdGrp.Dgrus), ;
2205:                         Coefs WITH CrSigCdGrp.Coefs
2206:             ELSE
2207:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2208:                     "SigCdGrp", "cursor_4c_BuscaGrp", "Cgrus", loc_cCodigo, ;
2209:                     "Grupos de Produto")
2210:                 IF VARTYPE(loc_oBusca) = "O"
2211:                     IF !loc_oBusca.this_lAchouRegistro
2212:                         loc_oBusca.mAddColuna("Cgrus", "", "C" + CHR(243) + "digo")
2213:                         loc_oBusca.mAddColuna("Dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
2214:                         loc_oBusca.Show()
2215:                     ENDIF
2216:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
2217:                         loc_cSelecionado = ALLTRIM(cursor_4c_BuscaGrp.Cgrus)
2218:                         SELECT csGrade
2219:                         REPLACE Cgrus WITH loc_cSelecionado
2220:                         IF SEEK(loc_cSelecionado, "CrSigCdGrp", "Cgrus")
2221:                             SELECT csGrade
2222:                             REPLACE Dgrus WITH ALLTRIM(CrSigCdGrp.Dgrus), ;
2223:                                     Coefs WITH CrSigCdGrp.Coefs
2224:                         ENDIF
2225:                     ELSE
2226:                         SELECT csGrade
2227:                         REPLACE Cgrus WITH "", Dgrus WITH ""
2228:                     ENDIF
2229:                     loc_oBusca.Release()
2230:                 ENDIF
2231:                 IF USED("cursor_4c_BuscaGrp")
2232:                     USE IN cursor_4c_BuscaGrp
2233:                 ENDIF
2234:             ENDIF
2235:         CATCH TO loException
2236:             MsgErro("Erro em GradeGrupoCol1Valid:" + CHR(13) + loException.Message, "Erro")
2237:             loc_lResultado = .F.
2238:         ENDTRY
2239: 
2240:         RETURN loc_lResultado
2241:     ENDPROC
2242: 
2243:     *==========================================================================
2244:     * GradeGrupoCol3When - When do Col3 (Coefs) do grd_4c_Grade
2245:     *==========================================================================
2246:     PROCEDURE GradeGrupoCol3When()
2247:         SET CONFIRM ON
2248:         RETURN (!EMPTY(csGrade.Cgrus) OR !EMPTY(csGrade.Ordem))
2249:     ENDPROC
2250: 
2251:     *==========================================================================
2252:     * GradeGrupoCol3LostFocus - LostFocus do Col3: auto-insere linha apos Enter
2253:     *==========================================================================
2254:     PROCEDURE GradeGrupoCol3LostFocus(par_nKeyCode, par_nShiftAltCtrl)
2255:         LOCAL loc_oPag
2256:         loc_oPag = THIS.pgf_4c_Paginas.Page2.pgf_4c_Configuracao.Page1.grd_4c_Grade
2257: 
2258:         TRY
2259:             SELECT * FROM csGrade WHERE (EMPTY(Cgrus) AND Ordem <> 0) INTO CURSOR TmpBranco
2260:             IF RECCOUNT("TmpBranco") < 1 AND INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2261:                 SET CONFIRM OFF
2262:                 IF LASTKEY() = 13
2263:                     SELECT csGrade
2264:                     INSERT INTO csGrade (Cgrus) VALUES ("")
2265:                     loc_oPag.Refresh()
2266:                     loc_oPag.Column1.SetFocus()
2267:                     KEYBOARD "{DnArrow}"
2268:                 ENDIF
2269:             ENDIF
2270:         CATCH TO loException
2271:             MsgErro("Erro em GradeGrupoCol3LostFocus:" + CHR(13) + loException.Message, "Erro")
2272:         ENDTRY
2273: 
2274:         IF USED("TmpBranco")
2275:             USE IN TmpBranco
2276:         ENDIF
2277:     ENDPROC
2278: 
2279:     *==========================================================================
2280:     * GradeGrupoCol4When - When do Col4 (CPros) do grd_4c_Grade: salva AntValue
2281:     *==========================================================================
2282:     PROCEDURE GradeGrupoCol4When()
2283:         IF USED("csGrade") AND !EOF("csGrade") AND !BOF("csGrade")
2284:             THIS.this_cAntValue = ALLTRIM(csGrade.CPros)
2285:         ENDIF
2286:         RETURN .T.
2287:     ENDPROC
2288: 
2289:     *==========================================================================
2290:     * GradeGrupoCol4Valid - Valid do Col4 (CPros): abre picker SigCdPro se nao encontrado
2291:     *==========================================================================
2292:     PROCEDURE GradeGrupoCol4Valid()
2293:         LOCAL loc_lResultado, loc_cCodigo, loc_oBusca
2294:         loc_lResultado = .T.
2295: 
2296:         IF !USED("csGrade") OR EOF("csGrade") OR BOF("csGrade")
2297:             RETURN loc_lResultado
2298:         ENDIF
2299: 
2300:         loc_cCodigo = ALLTRIM(csGrade.CPros)
2301: 
2302:         IF EMPTY(loc_cCodigo) OR loc_cCodigo = THIS.this_cAntValue
2303:             RETURN loc_lResultado
2304:         ENDIF
2305: 
2306:         TRY
2307:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2308:                 "SigCdPro", "crListaRemota", "CPros", loc_cCodigo, ;
2309:                 "Sele" + CHR(231) + CHR(227) + "o")
2310:             IF VARTYPE(loc_oBusca) = "O"
2311:                 IF !loc_oBusca.this_lAchouRegistro
2312:                     loc_oBusca.mAddColuna("CPros", "", "Produto")
2313:                     loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
2314:                     loc_oBusca.Show()
2315:                 ENDIF
2316:                 IF loc_oBusca.this_lSelecionou AND USED("crListaRemota")
2317:                     SELECT csGrade
2318:                     REPLACE CPros WITH ALLTRIM(crListaRemota.CPros)
2319:                 ELSE
2320:                     IF LASTKEY() = 27
2321:                         SELECT csGrade
2322:                         REPLACE CPros WITH ""
2323:                     ENDIF
2324:                 ENDIF
2325:                 loc_oBusca.Release()
2326:             ENDIF
2327:             IF USED("crListaRemota")
2328:                 USE IN crListaRemota
2329:             ENDIF
2330:         CATCH TO loException
2331:             MsgErro("Erro em GradeGrupoCol4Valid:" + CHR(13) + loException.Message, "Erro")
2332:             loc_lResultado = .F.
2333:         ENDTRY
2334: 
2335:         RETURN loc_lResultado
2336:     ENDPROC
2337: 
2338:     *==========================================================================
2339:     * GradeCustoCol1When - When do Col1 (Cpros) do grd_4c_Custo: salva AntValue
2340:     *==========================================================================
2341:     PROCEDURE GradeCustoCol1When()
2342:         IF USED("csCusto") AND !EOF("csCusto") AND !BOF("csCusto")
2343:             THIS.this_cAntValue = ALLTRIM(csCusto.Cpros)
2344:         ENDIF
2345:         RETURN .T.
2346:     ENDPROC
2347: 
2348:     *==========================================================================
2349:     * GradeCustoCol1Valid - Valid do Col1 (Cpros): valida produto, preenche Dpros+Coefs+Seqs
2350:     *==========================================================================
2351:     PROCEDURE GradeCustoCol1Valid()
2352:         LOCAL loc_lResultado, loc_cCodigo, loc_cSelecionado, loc_oBusca, loc_cFiltro
2353:         loc_lResultado = .T.
2354: 
2355:         IF !USED("csCusto") OR EOF("csCusto") OR BOF("csCusto")
2356:             RETURN loc_lResultado
2357:         ENDIF
2358: 
2359:         loc_cCodigo = ALLTRIM(csCusto.Cpros)
2360: 
2361:         IF EMPTY(loc_cCodigo) OR loc_cCodigo = THIS.this_cAntValue
2362:             RETURN loc_lResultado
2363:         ENDIF
2364: 
2365:         TRY
2366:             IF SEEK(loc_cCodigo, "CrSigCdPro", "Cpros")
2367:                 SELECT csCusto
2368:                 REPLACE Dpros WITH ALLTRIM(CrSigCdPro.Dpros), ;
2369:                         Coefs WITH CrSigCdPro.pVens, ;
2370:                         Seqs  WITH RECNO("csCusto")
2371:             ELSE
2372:                 loc_cFiltro = ""
2373:                 IF USED("TmpParac") AND RECCOUNT("TmpParac") > 0
2374:                     SELECT TmpParac
2375:                     GO TOP
2376:                     IF !EMPTY(ALLTRIM(TmpParac.CgruCfxs))
2377:                         loc_cFiltro = "Cgrus = " + EscaparSQL(ALLTRIM(TmpParac.CgruCfxs))
2378:                     ENDIF
2379:                 ENDIF
2380:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2381:                     "SigCdPro", "cursor_4c_BuscaPro", "Cpros", loc_cCodigo, ;
2382:                     "Custos Fixo", .F., .T., loc_cFiltro)
2383:                 IF VARTYPE(loc_oBusca) = "O"
2384:                     IF !loc_oBusca.this_lAchouRegistro
2385:                         loc_oBusca.mAddColuna("Cpros", "", "C" + CHR(243) + "digo")
2386:                         loc_oBusca.mAddColuna("Dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
2387:                         loc_oBusca.Show()
2388:                     ENDIF
2389:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPro")
2390:                         loc_cSelecionado = ALLTRIM(cursor_4c_BuscaPro.Cpros)
2391:                         SELECT csCusto
2392:                         REPLACE Cpros WITH loc_cSelecionado
2393:                         IF SEEK(loc_cSelecionado, "CrSigCdPro", "Cpros")
2394:                             SELECT csCusto
2395:                             REPLACE Dpros WITH ALLTRIM(CrSigCdPro.Dpros), ;
2396:                                     Coefs WITH CrSigCdPro.pVens, ;
2397:                                     Seqs  WITH RECNO("csCusto")
2398:                         ELSE
2399:                             SELECT csCusto
2400:                             REPLACE Dpros WITH ALLTRIM(cursor_4c_BuscaPro.Dpros), ;
2401:                                     Coefs WITH cursor_4c_BuscaPro.pVens, ;
2402:                                     Seqs  WITH RECNO("csCusto")
2403:                         ENDIF
2404:                     ELSE
2405:                         SELECT csCusto
2406:                         REPLACE Cpros WITH "", Dpros WITH ""
2407:                     ENDIF
2408:                     loc_oBusca.Release()
2409:                 ENDIF
2410:                 IF USED("cursor_4c_BuscaPro")
2411:                     USE IN cursor_4c_BuscaPro
2412:                 ENDIF
2413:             ENDIF
2414:         CATCH TO loException
2415:             MsgErro("Erro em GradeCustoCol1Valid:" + CHR(13) + loException.Message, "Erro")
2416:             loc_lResultado = .F.
2417:         ENDTRY
2418: 
2419:         RETURN loc_lResultado
2420:     ENDPROC
2421: 
2422:     *==========================================================================
2423:     * GradeCustoCol3When - When do Col3 (Coefs) do grd_4c_Custo
2424:     *==========================================================================
2425:     PROCEDURE GradeCustoCol3When()
2426:         RETURN (!EMPTY(csCusto.Cpros))
2427:     ENDPROC
2428: 
2429:     *==========================================================================
2430:     * GradeCustoCol3LostFocus - LostFocus do Col3: auto-insere linha apos Enter
2431:     *==========================================================================
2432:     PROCEDURE GradeCustoCol3LostFocus(par_nKeyCode, par_nShiftAltCtrl)
2433:         LOCAL loc_oPag
2434:         loc_oPag = THIS.pgf_4c_Paginas.Page2.pgf_4c_Configuracao.Page2.grd_4c_Custo
2435: 
2436:         TRY
2437:             SELECT * FROM csCusto WHERE EMPTY(Cpros) INTO CURSOR TmpBranco
2438:             IF RECCOUNT("TmpBranco") < 1 AND INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2439:                 SELECT csCusto
2440:                 INSERT INTO csCusto (Cpros) VALUES ("")
2441:                 GO BOTTOM IN csCusto
2442:             ENDIF
2443:             IF LASTKEY() = 13
2444:                 SELECT csCusto
2445:                 loc_oPag.Refresh()
2446:                 loc_oPag.Column1.SetFocus()
2447:                 KEYBOARD "{DnArrow}"
2448:             ENDIF
2449:         CATCH TO loException
2450:             MsgErro("Erro em GradeCustoCol3LostFocus:" + CHR(13) + loException.Message, "Erro")
2451:         ENDTRY
2452: 
2453:         IF USED("TmpBranco")
2454:             USE IN TmpBranco
2455:         ENDIF
2456:     ENDPROC
2457: 
2458:     *==========================================================================
2459:     * GradeCustoCol4When - When do Col4 (Seqs) do grd_4c_Custo
2460:     *==========================================================================
2461:     PROCEDURE GradeCustoCol4When()
2462:         RETURN (!EMPTY(csCusto.Cpros))
2463:     ENDPROC
2464: 
2465: ENDDEFINE


### BO (C:\4c\projeto\app\classes\FtiBO.prg):
*==============================================================================
* FtiBO.prg - Business Object para Cadastro de Feitios
* Tabela principal : SigPrFti (cods = PK)
* Tabela de itens  : SigPrFto (cidchaves = PK)
* Gerado           : Fase 1/8 - Propriedades e Init
*==============================================================================

DEFINE CLASS FtiBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades herdadas (nomes CORRETOS do BusinessBase)
    *--------------------------------------------------------------------------
    this_cTabela      = "SigPrFti"
    this_cCampoChave  = "cods"

    *--------------------------------------------------------------------------
    * Campos de SigPrFti
    *--------------------------------------------------------------------------
    this_cCodigo      = ""    && cods       char(2)  PK
    this_cDescricao   = ""    && descs      char(20)
    this_nValor       = 0     && valors     numeric(11,2)
    this_cMoeda       = ""    && moedas     char(3)
    this_nAcrescimo   = 0     && acrescs    numeric(11,6)
    this_nTipoFeitio  = 1     && tpftios    numeric(1,0)  1=Por Peso 2=Valor Adicional 3=Informativo
    this_nFaixaInicial = 0    && faixais    numeric(11,6)
    this_nFaixaFinal  = 0     && faixafs    numeric(11,6)
    this_nPerdas      = 0     && perdas     numeric(3,1)
    this_nLucros      = 0     && lucros     numeric(5,2)
    this_nDivMult     = 1     && divmults   numeric(1,0)  1=Multiplicador 2=Divisor
    this_nTipo        = 2     && tipos      numeric(1,0)  1=Custo 2=Venda
    this_nAplscus     = 2     && aplscus    numeric(1,0)  1=Sim 2=Nao
    this_nEtiquetas   = 3     && etiquetas  numeric(1,0)  1=Sim 2=Sim-AU 3=Nao
    this_cMcustos     = ""    && mcustos    char(3)
    this_nVcustos     = 0     && vcustos    numeric(11,2)
    this_cUsuarios    = ""    && usuars     char(10)
    this_dDataRs      = {}    && datars     datetime

    *--------------------------------------------------------------------------
    * Propriedades auxiliares de controle
    *--------------------------------------------------------------------------
    this_cDescMoeda   = ""    && descricao da moeda (SigCdMoe.dmoes) - nao salvo
    this_lNovoRegistro = .F.

    *==========================================================================
    * Init - Configura tabela e campo chave
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigPrFti"
        THIS.this_cCampoChave = "cods"
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDFUNC

    *==========================================================================
    * NovoRegistro - Prepara BO para INSERT
    *==========================================================================
    PROCEDURE NovoRegistro()
        DODEFAULT()
        THIS.this_cCodigo       = ""
        THIS.this_cDescricao    = ""
        THIS.this_nValor        = 0
        THIS.this_cMoeda        = ""
        THIS.this_cDescMoeda    = ""
        THIS.this_nAcrescimo    = 0
        THIS.this_nTipoFeitio   = 1
        THIS.this_nFaixaInicial = 0
        THIS.this_nFaixaFinal   = 0
        THIS.this_nPerdas       = 0
        THIS.this_nLucros       = 0
        THIS.this_nDivMult      = 1
        THIS.this_nTipo         = 2
        THIS.this_nAplscus      = 2
        THIS.this_nEtiquetas    = 3
        THIS.this_cMcustos      = ""
        THIS.this_nVcustos      = 0
        THIS.this_cUsuarios     = ""
        THIS.this_dDataRs       = {}
        THIS.this_lNovoRegistro = .T.
    ENDPROC

    *==========================================================================
    * EditarRegistro - Prepara BO para UPDATE
    *==========================================================================
    PROCEDURE EditarRegistro()
        DODEFAULT()
        THIS.this_lNovoRegistro = .F.
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades a partir de cursor
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo       = ALLTRIM(TratarNulo(cods,      "C"))
            THIS.this_cDescricao    = ALLTRIM(TratarNulo(descs,     "C"))
            THIS.this_nValor        = TratarNulo(valors,    "N")
            THIS.this_cMoeda        = ALLTRIM(TratarNulo(moedas,    "C"))
            THIS.this_nAcrescimo    = TratarNulo(acrescs,   "N")
            THIS.this_nTipoFeitio   = TratarNulo(tpftios,   "N")
            THIS.this_nFaixaInicial = TratarNulo(faixais,   "N")
            THIS.this_nFaixaFinal   = TratarNulo(faixafs,   "N")
            THIS.this_nPerdas       = TratarNulo(perdas,    "N")
            THIS.this_nLucros       = TratarNulo(lucros,    "N")
            THIS.this_nDivMult      = TratarNulo(divmults,  "N")
            THIS.this_nTipo         = TratarNulo(tipos,     "N")
            THIS.this_nAplscus      = TratarNulo(aplscus,   "N")
            THIS.this_nEtiquetas    = TratarNulo(etiquetas, "N")
            THIS.this_cMcustos      = ALLTRIM(TratarNulo(mcustos,   "C"))
            THIS.this_nVcustos      = TratarNulo(vcustos,   "N")
            THIS.this_cUsuarios     = ALLTRIM(TratarNulo(usuars,    "C"))
            THIS.this_dDataRs       = TratarNulo(datars,    "D")
            THIS.this_lNovoRegistro = .F.
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Buscar - Lista registros de SigPrFti (PUBLIC)
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT cods, descs, valors, moedas, acrescs, tpftios" + ;
                       " FROM SigPrFti" + ;
                       " ORDER BY cods"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = "SELECT cods, descs, valors, moedas, acrescs, tpftios" + ;
                           " FROM SigPrFti" + ;
                           " WHERE " + par_cFiltro + ;
                           " ORDER BY cods"
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados") > 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar feitios:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FtiBO.Buscar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pelo codigo (PUBLIC)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT cods, descs, valors, moedas, acrescs, tpftios," + ;
                       " faixais, faixafs, perdas, lucros, divmults, tipos," + ;
                       " aplscus, etiquetas, mcustos, vcustos, usuars, datars" + ;
                       " FROM SigPrFti" + ;
                       " WHERE cods = " + EscaparSQL(ALLTRIM(par_cCodigo))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega") > 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
            ELSE
                MsgErro("Erro ao carregar feitio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FtiBO.CarregarPorCodigo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Inserir - INSERT em SigPrFti (PROTECTED - chamado por BusinessBase.Salvar)
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigPrFti" + ;
                       " (cods, descs, valors, moedas, acrescs, tpftios," + ;
                       "  faixais, faixafs, perdas, lucros, divmults, tipos," + ;
                       "  aplscus, etiquetas, mcustos, vcustos, usuars, datars)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigo)                          + ", " + ;
                       EscaparSQL(THIS.this_cDescricao)                       + ", " + ;
                       FormatarNumeroSQL(THIS.this_nValor)                    + ", " + ;
                       EscaparSQL(THIS.this_cMoeda)                           + ", " + ;
                       FormatarNumeroSQL(THIS.this_nAcrescimo)                + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTipoFeitio)               + ", " + ;
                       FormatarNumeroSQL(THIS.this_nFaixaInicial)             + ", " + ;
                       FormatarNumeroSQL(THIS.this_nFaixaFinal)               + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPerdas)                   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLucros)                   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nDivMult)                  + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTipo)                     + ", " + ;
                       FormatarNumeroSQL(THIS.this_nAplscus)                  + ", " + ;
                       FormatarNumeroSQL(THIS.this_nEtiquetas)                + ", " + ;
                       EscaparSQL(THIS.this_cMcustos)                         + ", " + ;
                       FormatarNumeroSQL(THIS.this_nVcustos)                  + ", " + ;
                       EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado))               + ", " + ;
                       "GETDATE()" + ;
                       ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir feitio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FtiBO.Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE em SigPrFti (PROTECTED - chamado por BusinessBase.Salvar)
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigPrFti SET" + ;
                       "  descs    = " + EscaparSQL(THIS.this_cDescricao)          + ", " + ;
                       "  valors   = " + FormatarNumeroSQL(THIS.this_nValor)        + ", " + ;
                       "  moedas   = " + EscaparSQL(THIS.this_cMoeda)              + ", " + ;
                       "  acrescs  = " + FormatarNumeroSQL(THIS.this_nAcrescimo)    + ", " + ;
                       "  tpftios  = " + FormatarNumeroSQL(THIS.this_nTipoFeitio)   + ", " + ;
                       "  faixais  = " + FormatarNumeroSQL(THIS.this_nFaixaInicial) + ", " + ;
                       "  faixafs  = " + FormatarNumeroSQL(THIS.this_nFaixaFinal)   + ", " + ;
                       "  perdas   = " + FormatarNumeroSQL(THIS.this_nPerdas)       + ", " + ;
                       "  lucros   = " + FormatarNumeroSQL(THIS.this_nLucros)       + ", " + ;
                       "  divmults = " + FormatarNumeroSQL(THIS.this_nDivMult)      + ", " + ;
                       "  tipos    = " + FormatarNumeroSQL(THIS.this_nTipo)         + ", " + ;
                       "  aplscus  = " + FormatarNumeroSQL(THIS.this_nAplscus)      + ", " + ;
                       "  etiquetas= " + FormatarNumeroSQL(THIS.this_nEtiquetas)    + ", " + ;
                       "  mcustos  = " + EscaparSQL(THIS.this_cMcustos)            + ", " + ;
                       "  vcustos  = " + FormatarNumeroSQL(THIS.this_nVcustos)      + ", " + ;
                       "  usuars   = " + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado))  + ", " + ;
                       "  datars   = GETDATE()" + ;
                       " WHERE cods = " + EscaparSQL(THIS.this_cCodigo)

            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar feitio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FtiBO.Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - DELETE em SigPrFti + SigPrFto (PROTECTED)
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrFto WHERE cods = " + EscaparSQL(THIS.this_cCodigo)
            IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                MsgErro("Erro ao excluir itens do feitio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_cSQL = "DELETE FROM SigPrFti WHERE cods = " + EscaparSQL(THIS.this_cCodigo)
                IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao excluir feitio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FtiBO.ExecutarExclusao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarItens - Carrega itens de SigPrFto para o cursor de grade (PUBLIC)
    * Popula cursores csGrade (grupos) e csCusto (custos fixo)
    *==========================================================================
    PROCEDURE CarregarItens(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Itens")
                USE IN cursor_4c_Itens
            ENDIF

            loc_cSQL = "SELECT cgrus, cpros, coefs, cidchaves, sgrus, ordem, seqs" + ;
                       " FROM SigPrFto" + ;
                       " WHERE cods = " + EscaparSQL(ALLTRIM(par_cCodigo)) + ;
                       " ORDER BY seqs"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Itens") > 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar itens do feitio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FtiBO.CarregarItens:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * SalvarItens - Persiste cursores csGrade e csCusto em SigPrFto (PUBLIC)
    * Deleta itens anteriores e reinsere (igual ao legado)
    *==========================================================================
    PROCEDURE SalvarItens(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.

        TRY
            LOCAL loc_lErro
            loc_lErro = .F.

            loc_cSQL = "DELETE FROM SigPrFto WHERE cods = " + EscaparSQL(ALLTRIM(par_cCodigo))
            IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                MsgErro("Erro ao limpar itens do feitio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lErro = .T.
            ENDIF

            IF USED("csGrade") AND !loc_lErro
                SELECT csGrade
                GO TOP
                SCAN
                    IF (!EMPTY(ALLTRIM(csGrade.Cgrus)) AND csGrade.Coefs <> 0) OR ;
                       (csGrade.Ordem <> 0 AND csGrade.Coefs <> 0)
                        loc_cSQL = "INSERT INTO SigPrFto" + ;
                                   " (cods, cgrus, cpros, coefs, cidchaves, ordem, seqs, calcfeitio, sgrus)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(ALLTRIM(par_cCodigo))      + ", " + ;
                                   EscaparSQL(ALLTRIM(csGrade.Cgrus))    + ", " + ;
                                   EscaparSQL(ALLTRIM(csGrade.CPros))    + ", " + ;
                                   FormatarNumeroSQL(csGrade.Coefs)      + ", " + ;
                                   EscaparSQL(fUniqueIds())              + ", " + ;
                                   FormatarNumeroSQL(csGrade.Ordem)      + ", " + ;
                                   "0"                                   + ", " + ;
                                   "0"                                   + ", " + ;
                                   "''" + ;
                                   ")"
                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                            MsgErro("Erro ao inserir grupo no feitio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            loc_lErro = .T.
                            EXIT
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF

            IF USED("csCusto") AND !loc_lErro
                SELECT csCusto
                GO TOP
                SCAN
                    IF !EMPTY(ALLTRIM(csCusto.Cpros)) AND csCusto.Coefs <> 0
                        loc_cSQL = "INSERT INTO SigPrFto" + ;
                                   " (cods, cgrus, cpros, coefs, cidchaves, seqs, calcfeitio, sgrus, ordem)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(ALLTRIM(par_cCodigo))      + ", " + ;
                                   "''"                                  + ", " + ;
                                   EscaparSQL(ALLTRIM(csCusto.Cpros))    + ", " + ;
                                   FormatarNumeroSQL(csCusto.Coefs)      + ", " + ;
                                   EscaparSQL(fUniqueIds())              + ", " + ;
                                   FormatarNumeroSQL(csCusto.Seqs)       + ", " + ;
                                   "0"                                   + ", " + ;
                                   "''"                                  + ", " + ;
                                   "0" + ;
                                   ")"
                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                            MsgErro("Erro ao inserir custo fixo no feitio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            loc_lErro = .T.
                            EXIT
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF

            IF !loc_lErro
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FtiBO.SalvarItens:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarParametros - Carrega cursores auxiliares necessarios ao form (PUBLIC)
    * CrSigCdMoe (moedas), CrSigCdGrp (grupos produto), CrSigCdPro (produtos)
    *==========================================================================
    PROCEDURE CarregarParametros()
        LOCAL loc_lResultado, loc_cSQL, loc_cGrupoCfxs
        loc_lResultado = .F.

        TRY
            IF USED("CrSigCdMoe")
                USE IN CrSigCdMoe
            ENDIF
            loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "CrSigCdMoe") < 1
                MsgErro("Erro ao carregar moedas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ENDIF
            SELECT CrSigCdMoe
            INDEX ON cmoes TAG CMoes

            IF USED("TmpParac")
                USE IN TmpParac
            ENDIF
            loc_cSQL = "SELECT CgruCfxs FROM SigCdPac"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpParac") < 1
                MsgErro("Erro ao carregar parametros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ENDIF
            IF RECCOUNT("TmpParac") > 0
                SELECT TmpParac
                GO TOP
                loc_cGrupoCfxs = ALLTRIM(TmpParac.CgruCfxs)
            ELSE
                loc_cGrupoCfxs = ""
            ENDIF

            IF USED("CrSigCdGrp")
                USE IN CrSigCdGrp
            ENDIF
            loc_cSQL = "SELECT Cgrus, Dgrus, Coefs FROM SigCdGrp"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "CrSigCdGrp") < 1
                MsgErro("Erro ao carregar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ENDIF
            SELECT CrSigCdGrp
            INDEX ON Cgrus TAG Cgrus

            IF USED("CrSigCdPro")
                USE IN CrSigCdPro
            ENDIF
            IF !EMPTY(loc_cGrupoCfxs)
                loc_cSQL = "SELECT Cpros, Dpros, pVens FROM SigCdPro" + ;
                           " WHERE Cgrus = " + EscaparSQL(loc_cGrupoCfxs)
            ELSE
                loc_cSQL = "SELECT Cpros, Dpros, pVens FROM SigCdPro"
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "CrSigCdPro") < 1
                MsgErro("Erro ao carregar produtos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ENDIF
            SELECT CrSigCdPro
            INDEX ON cpros TAG Cpros

            loc_lResultado = .T.
        CATCH TO loException
            MsgErro("Erro em FtiBO.CarregarParametros:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ValidarDuplicidade - Verifica duplicidade de grupos e custos na grade (PUBLIC)
    *==========================================================================
    PROCEDURE ValidarDuplicidade()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .T.

        TRY
            IF USED("CsDuplica")
                USE IN CsDuplica
            ENDIF

            SELECT Cgrus, CPros, SUM(1) AS Tot FROM csGrade ;
                WHERE Cgrus <> ' ' ;
                GROUP BY Cgrus, CPros ;
                INTO CURSOR CsDuplica ;
                HAVING SUM(1) > 1

            IF RECCOUNT("CsDuplica") > 0
                MsgAviso("Existem Grupos/Produtos configurados em duplicidade!", "Valida" + CHR(231) + CHR(227) + "o")
                USE IN CsDuplica
                loc_lResultado = .F.
            ENDIF
            IF USED("CsDuplica")
                USE IN CsDuplica
            ENDIF

            SELECT Cpros, SUM(1) AS Tot FROM csCusto ;
                WHERE Cpros <> ' ' ;
                GROUP BY Cpros ;
                INTO CURSOR CsDuplica ;
                HAVING SUM(1) > 1

            IF RECCOUNT("CsDuplica") > 0
                MsgAviso("Existem Custos Fixo configurados em duplicidade!", "Valida" + CHR(231) + CHR(227) + "o")
                USE IN CsDuplica
                loc_lResultado = .F.
            ENDIF
            IF USED("CsDuplica")
                USE IN CsDuplica
            ENDIF

            loc_lResultado = .T.
        CATCH TO loException
            MsgErro("Erro em FtiBO.ValidarDuplicidade:" + CHR(13) + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ValidarFaixa - Valida que o acrescimo esta dentro da faixa (PUBLIC)
    *==========================================================================
    PROCEDURE ValidarFaixa()
        IF THIS.this_nFaixaFinal > 0
            IF !BETWEEN(THIS.this_nAcrescimo, THIS.this_nFaixaInicial, THIS.this_nFaixaFinal)
                MsgAviso("O multiplicador tem que estar dentro da Faixa!", "Valida" + CHR(231) + CHR(227) + "o")
                RETURN .F.
            ENDIF
        ENDIF
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ValidarConflitoCampos - Valida que Multiplicador/Valor nao coexistem com grade (PUBLIC)
    *==========================================================================
    PROCEDURE ValidarConflitoCampos()
        LOCAL loc_lResultado
        loc_lResultado = .T.

        TRY
            IF THIS.this_nAcrescimo <> 0 OR THIS.this_nValor <> 0
                IF USED("ChkDados")
                    USE IN ChkDados
                ENDIF

                SELECT " " AS Agrupar, SUM(1) AS Tot FROM csGrade ;
                    WHERE Cgrus <> ' ' AND Coefs <> 0 ;
                    INTO CURSOR ChkDados GROUP BY 1

                SELECT ChkDados
                GO TOP
                IF Tot > 0
                    MsgAviso("O Campo Multiplicador Ou Valor n" + CHR(227) + "o podem ser informados" + ;
                             CHR(13) + "em conjunto com grade de custos", "Valida" + CHR(231) + CHR(227) + "o")
                    USE IN ChkDados
                    loc_lResultado = .F.
                ENDIF

                SELECT " " AS Agrupar, SUM(1) AS Tot FROM csCusto ;
                    WHERE Cpros <> ' ' ;
                    INTO CURSOR ChkDados GROUP BY 1

                SELECT ChkDados
                GO TOP
                IF Tot > 0
                    MsgAviso("O Campo Multiplicador Ou Valor n" + CHR(227) + "o podem ser informados" + ;
                             CHR(13) + "em conjunto com grade de custos", "Valida" + CHR(231) + CHR(227) + "o")
                    USE IN ChkDados
                    loc_lResultado = .F.
                ENDIF

                IF USED("ChkDados")
                    USE IN ChkDados
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FtiBO.ValidarConflitoCampos:" + CHR(13) + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * VerificarCodigoExistente - Verifica se codigo ja existe (para INSERT) (PUBLIC)
    *==========================================================================
    PROCEDURE VerificarCodigoExistente(par_cCodigo)
        LOCAL loc_lExiste, loc_cSQL
        loc_lExiste = .F.

        TRY
            IF USED("cursor_4c_Chk")
                USE IN cursor_4c_Chk
            ENDIF

            loc_cSQL = "SELECT cods FROM SigPrFti WHERE cods = " + EscaparSQL(ALLTRIM(par_cCodigo))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Chk") > 0
                loc_lExiste = (RECCOUNT("cursor_4c_Chk") > 0)
            ENDIF

            IF USED("cursor_4c_Chk")
                USE IN cursor_4c_Chk
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FtiBO.VerificarCodigoExistente:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *==========================================================================
    * Destroy
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_aCursores(9), loc_i
        loc_aCursores(1) = "cursor_4c_Dados"
        loc_aCursores(2) = "cursor_4c_Carrega"
        loc_aCursores(3) = "cursor_4c_Itens"
        loc_aCursores(4) = "cursor_4c_Chk"
        loc_aCursores(5) = "CrSigCdMoe"
        loc_aCursores(6) = "TmpParac"
        loc_aCursores(7) = "CrSigCdGrp"
        loc_aCursores(8) = "CrSigCdPro"
        loc_aCursores(9) = "ChkDados"

        FOR loc_i = 1 TO ALEN(loc_aCursores)
            IF USED(loc_aCursores(loc_i))
                USE IN (loc_aCursores(loc_i))
            ENDIF
        ENDFOR

        DODEFAULT()
    ENDPROC

ENDDEFINE

