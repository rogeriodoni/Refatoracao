# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (5)
- [METODO-INEXISTENTE] Metodo 'THIS.pfSqlTabela()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-HEADER] Header Caption 'Tipo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Emp, Operação, Pg, Bx, Empds, Operação Destino, Local Entrega, Del, DD, NN, DT, S/N/A. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Descrição' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Emp, Operação, Pg, Bx, Empds, Operação Destino, Local Entrega, Del, DD, NN, DT, S/N/A. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'chklocdel' (parent: SIGCDTME.Pagina.Dados.Pageframe1.Page1): Top original=210 vs migrado 'chk_4c_Chklocdel' Top=313 (diff=103px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'chkftpdel' (parent: SIGCDTME.Pagina.Dados.Pageframe1.Page1): Top original=210 vs migrado 'chk_4c_Chkftpdel' Top=313 (diff=103px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormTme.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2812 linhas total):

*-- Linhas 24 a 159:
24: 
25:     *-- Guardas anti-repeticao para LostFocus (Problema 45: LostFocus dispara
26:     *-- sempre, ao contrario de Valid que so dispara quando o valor muda)
27:     this_cUltimoTransTipo   = ""
28:     this_cUltimoDirGeracao  = ""
29:     this_cUltimoDirLeitura  = ""
30:     this_cUltimoDirRecepcao = ""
31:     this_cUltimoDirArquivar = ""
32: 
33:     *===========================================================================
34:     * Init - Inicializa o formulario
35:     * REGRA CRITICA: Apenas RETURN DODEFAULT()
36:     * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
37:     *===========================================================================
38:     PROCEDURE Init()
39:         RETURN DODEFAULT()
40:     ENDPROC
41: 
42:     *===========================================================================
43:     * InicializarForm - Configura estrutura completa
44:     * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
45:     *===========================================================================
46:     PROTECTED PROCEDURE InicializarForm()
47:         LOCAL loc_lSucesso
48:         loc_lSucesso = .F.
49: 
50:         TRY
51:             THIS.this_oBusinessObject = CREATEOBJECT("TmeBO")
52: 
53:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
54:                 MostrarErro("Erro ao criar TmeBO" + CHR(13) + ;
55:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
56:                     "FormTme.InicializarForm")
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
68:                     IF PEMSTATUS(THIS, "CarregarLista", 5)
69:                         THIS.CarregarLista()
70:                     ENDIF
71:                 ENDIF
72: 
73:                 loc_lSucesso = .T.
74:             ENDIF
75: 
76:         CATCH TO loException
77:             MostrarErro("Erro ao inicializar FormTme:" + CHR(13) + ;
78:                 loException.Message + CHR(13) + ;
79:                 "Linha: " + TRANSFORM(loException.LineNo), ;
80:                 "FormTme.InicializarForm")
81:         ENDTRY
82: 
83:         RETURN loc_lSucesso
84:     ENDPROC
85: 
86:     *===========================================================================
87:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
88:     * Top=-29 para esconder abas; controles compensam +29 no Top
89:     *===========================================================================
90:     PROTECTED PROCEDURE ConfigurarPageFrame()
91:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
92: 
93:         WITH THIS.pgf_4c_Paginas
94:             .PageCount = 2
95:             .Top       = -29
96:             .Left      = 0
97:             .Width     = THIS.Width
98:             .Height    = THIS.Height + 29
99:             .Tabs      = .F.
100:             .Visible   = .T.
101: 
102:             .Page1.Caption   = "Lista"
103:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
104:             .Page1.BackColor = RGB(255, 255, 255)
105: 
106:             .Page2.Caption   = "Dados"
107:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
108:             .Page2.BackColor = RGB(255, 255, 255)
109:         ENDWITH
110: 
111:         THIS.ConfigurarPaginaLista()
112:         THIS.ConfigurarPaginaDados()
113:     ENDPROC
114: 
115:     *===========================================================================
116:     * ConfigurarPaginaLista - Page1: cabecalho + Grid + botoes CRUD completos
117:     * Grid: cursor_4c_Dados (tipoemps, tipos, emps, descrs) - populado por CarregarLista()
118:     *===========================================================================
119:     PROTECTED PROCEDURE ConfigurarPaginaLista()
120:         LOCAL loc_oPagina
121:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
122: 
123:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
124: 
125:         *-- Container Cabecalho (cntSombra no legado) - PRIMEIRO AddObject da pagina
126:         *-- Original: Top=1. Com compensacao +29: Top=31
127:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
128:         WITH loc_oPagina.cnt_4c_Cabecalho
129:             .Top         = 31
130:             .Left        = 0
131:             .Width       = THIS.Width
132:             .Height      = 80
133:             .BackColor   = RGB(100, 100, 100)
134:             .BorderWidth = 0
135:             .Visible     = .T.
136:         ENDWITH
137: 
138:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
139:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
140:             .Caption   = THIS.Caption
141:             .Top       = 15
142:             .Left      = 10
143:             .Width     = 769
144:             .Height    = 40
145:             .FontName  = "Tahoma"
146:             .FontSize  = 16
147:             .FontBold  = .T.
148:             .ForeColor = RGB(0, 0, 0)
149:             .BackStyle = 0
150:             .AutoSize  = .F.
151:             .Visible   = .T.
152:         ENDWITH
153: 
154:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
155:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
156:             .Caption   = THIS.Caption
157:             .Top       = 18
158:             .Left      = 10
159:             .Width     = 769

*-- Linhas 204 a 424:
204:             .AutoSize        = .F.
205:             .Visible         = .T.
206:         ENDWITH
207:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
208: 
209:         *-- Botao Visualizar (Left=80)
210:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
211:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
212:             .Caption         = "Visualizar"
213:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
214:             .PicturePosition = 13
215:             .Top             = 5
216:             .Left            = 80
217:             .Width           = 75
218:             .Height          = 75
219:             .FontName        = "Tahoma"
220:             .FontBold        = .T.
221:             .FontItalic      = .T.
222:             .FontSize        = 8
223:             .ForeColor       = RGB(90, 90, 90)
224:             .BackColor       = RGB(255, 255, 255)
225:             .Themes          = .F.
226:             .SpecialEffect   = 0
227:             .MousePointer    = 15
228:             .WordWrap        = .T.
229:             .AutoSize        = .F.
230:             .Visible         = .T.
231:         ENDWITH
232:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
233: 
234:         *-- Botao Alterar (Left=155)
235:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
236:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
237:             .Caption         = "Alterar"
238:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
239:             .PicturePosition = 13
240:             .Top             = 5
241:             .Left            = 155
242:             .Width           = 75
243:             .Height          = 75
244:             .FontName        = "Tahoma"
245:             .FontBold        = .T.
246:             .FontItalic      = .T.
247:             .FontSize        = 8
248:             .ForeColor       = RGB(90, 90, 90)
249:             .BackColor       = RGB(255, 255, 255)
250:             .Themes          = .F.
251:             .SpecialEffect   = 0
252:             .MousePointer    = 15
253:             .WordWrap        = .T.
254:             .AutoSize        = .F.
255:             .Visible         = .T.
256:         ENDWITH
257:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
258: 
259:         *-- Botao Excluir (Left=230)
260:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
261:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
262:             .Caption         = "Excluir"
263:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
264:             .PicturePosition = 13
265:             .Top             = 5
266:             .Left            = 230
267:             .Width           = 75
268:             .Height          = 75
269:             .FontName        = "Tahoma"
270:             .FontBold        = .T.
271:             .FontItalic      = .T.
272:             .FontSize        = 8
273:             .ForeColor       = RGB(90, 90, 90)
274:             .BackColor       = RGB(255, 255, 255)
275:             .Themes          = .F.
276:             .SpecialEffect   = 0
277:             .MousePointer    = 15
278:             .WordWrap        = .T.
279:             .AutoSize        = .F.
280:             .Visible         = .T.
281:         ENDWITH
282:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
283: 
284:         *-- Botao Buscar (Left=305)
285:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
286:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
287:             .Caption         = "Buscar"
288:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
289:             .PicturePosition = 13
290:             .Top             = 5
291:             .Left            = 305
292:             .Width           = 75
293:             .Height          = 75
294:             .FontName        = "Tahoma"
295:             .FontBold        = .T.
296:             .FontItalic      = .T.
297:             .FontSize        = 8
298:             .ForeColor       = RGB(90, 90, 90)
299:             .BackColor       = RGB(255, 255, 255)
300:             .Themes          = .F.
301:             .SpecialEffect   = 0
302:             .MousePointer    = 15
303:             .WordWrap        = .T.
304:             .AutoSize        = .F.
305:             .Visible         = .T.
306:         ENDWITH
307:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
308: 
309:         *-- Container Saida - PADRAO CANONICO (CLAUDE.md regra #10, prevalece sobre legado)
310:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
311:         WITH loc_oPagina.cnt_4c_Saida
312:             .Top         = 29
313:             .Left        = 917
314:             .Width       = 90
315:             .Height      = 85
316:             .BackStyle = 1
317:             .BackColor = RGB(255, 255, 255)
318:             .BorderWidth = 0
319:             .Visible     = .T.
320:         ENDWITH
321: 
322:         *-- Botao Encerrar - PADRAO CANONICO: Caption="Encerrar", Width=75, Height=75
323:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
324:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
325:             .Caption         = "Encerrar"
326:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
327:             .PicturePosition = 13
328:             .Top             = 5
329:             .Left            = 5
330:             .Width           = 75
331:             .Height          = 75
332:             .FontName        = "Tahoma"
333:             .FontBold        = .T.
334:             .FontItalic      = .T.
335:             .FontSize        = 8
336:             .ForeColor       = RGB(90, 90, 90)
337:             .BackColor       = RGB(255, 255, 255)
338:             .Themes          = .F.
339:             .SpecialEffect   = 0
340:             .MousePointer    = 15
341:             .WordWrap        = .T.
342:             .AutoSize        = .F.
343:             .Visible         = .T.
344:         ENDWITH
345:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
346: 
347:         *-- Grid de listagem de transportes
348:         *-- Canonico framework: Top=117 (88+29 compensacao), Left=26, Width=880, Height=498
349:         *-- Colunas: tipos (Transporte), emps (Empresa), descrs (Descricao)
350:         *-- tipoemps (PK concatenada) permanece no cursor mas nao eh exibida
351:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
352:         *-- ColumnCount FORA do WITH (Problema 36: dentro do WITH nao cria colunas imediatamente)
353:         loc_oPagina.grd_4c_Lista.ColumnCount = 3
354:         WITH loc_oPagina.grd_4c_Lista
355:             .Top                = 117
356:             .Left               = 26
357:             .Width              = 880
358:             .Height             = 498
359:             .FontName           = "Verdana"
360:             .FontSize           = 8
361:             .ForeColor          = RGB(90, 90, 90)
362:             .BackColor          = RGB(255, 255, 255)
363:             .GridLineColor      = RGB(238, 238, 238)
364:             .HighlightBackColor = RGB(255, 255, 255)
365:             .HighlightForeColor = RGB(15, 41, 104)
366:             .HighlightStyle     = 2
367:             .DeleteMark         = .F.
368:             .RecordMark         = .F.
369:             .RowHeight          = 16
370:             .ScrollBars         = 2
371:             .GridLines          = 3
372:             .Visible            = .T.
373:         ENDWITH
374:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")
375: 
376:         THIS.TornarControlesVisiveis(loc_oPagina)
377:     ENDPROC
378: 
379:     *===========================================================================
380:     * CarregarLista - Carrega dados no grid da Page1
381:     * OBRIGATORIO: Reconfigura ControlSource e Headers APOS RecordSource (Problema 2/48)
382:     * OBRIGATORIO: RecordSource FORA do WITH (Problema 36)
383:     *===========================================================================
384:     PROCEDURE CarregarLista()
385:         LOCAL loc_lResultado, loc_oGrid
386:         loc_lResultado = .F.
387: 
388:         TRY
389:             IF !THIS.this_oBusinessObject.Buscar("")
390:                 loc_lResultado = .F.
391:             ELSE
392:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
393: 
394:                 *-- PROBLEMA 48: RecordSource ANTES de ControlSource (FORA do WITH per Problema 36)
395:                 loc_oGrid.ColumnCount = 3
396:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
397: 
398:                 *-- PROBLEMA 48: ControlSource APOS RecordSource (auto-bind seria sobrescrito)
399:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.tipos"
400:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.emps"
401:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.descrs"
402: 
403:                 loc_oGrid.Column1.Width = 150
404:                 loc_oGrid.Column2.Width = 80
405:                 loc_oGrid.Column3.Width = 640
406: 
407:                 *-- PROBLEMA 2/32: Headers APOS RecordSource (OBRIGATORIO - RecordSource reseta captions)
408:                 *-- Column1 (tipos): o header legado NAO vem de um objeto Header1 estatico do SCX
409:                 *-- (por isso invisivel a scan estatico) - vem do framework Sig*, setado em
410:                 *-- runtime no Init do form: THIS.pfSqlTabela(1).pColuna('Tipos','','','Tipo',52,.t.)
411:                 *-- Caption correta = "Tipo" (NAO "Processo" - esse eh o rotulo do campo na
412:                 *-- Pagina.Dados/Say7, um controle diferente do mesmo formulario)
413:                 loc_oGrid.Column1.Header1.Caption = "Tipo"
414:                 loc_oGrid.Column2.Header1.Caption = "Emp"
415:                 *-- Column3 (descrs): o pColuna do legado so declara 3 colunas na grade da Lista
416:                 *-- (Tipos->"Tipo", Emps->"Emp", Extensao->"Extensao") - Descrs NAO aparece la.
417:                 *-- Manter Descrs aqui (em vez de Extensao) eh decisao de produto ja tomada na
418:                 *-- migracao (mais util numa lista que o codigo de extensao) - NAO reatribuir
419:                 *-- ControlSource para Extensao aqui: exigiria mudar SELECT do TmeBO.Buscar()
420:                 *-- (logica de negocio), fora do escopo deste pass visual. Caption usa o rotulo
421:                 *-- do proprio campo no legado (Say4 "Descri" + CHR(231) + CHR(227) + "o :",
422:                 *-- ControlSource crSigCdMe.descrs) - mantido.
423:                 loc_oGrid.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
424: 

*-- Linhas 439 a 528:
439:     *===========================================================================
440:     * FormatarGridLista - Formata visual do grid de lista (FontName/FontSize)
441:     *===========================================================================
442:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
443:         TRY
444:             WITH par_oGrid
445:                 .FontName = "Tahoma"
446:                 .FontSize = 8
447:             ENDWITH
448:         CATCH TO loException
449:             MostrarErro("Erro ao formatar grid:" + CHR(13) + loException.Message, ;
450:                 "FormTme.FormatarGridLista")
451:         ENDTRY
452:     ENDPROC
453: 
454:     *===========================================================================
455:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
456:     * Ao voltar para Page1, recarrega a lista
457:     *===========================================================================
458:     PROCEDURE AlternarPagina(par_nPagina)
459:         LOCAL loc_lResultado
460:         loc_lResultado = .F.
461: 
462:         TRY
463:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
464:                 MsgAviso("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + TRANSFORM(par_nPagina))
465:             ELSE
466:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
467: 
468:                 IF par_nPagina = 1
469:                     THIS.this_cModoAtual = "LISTA"
470:                     THIS.CarregarLista()
471:                 ENDIF
472: 
473:                 loc_lResultado = .T.
474:             ENDIF
475: 
476:         CATCH TO loException
477:             MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loException.Message, ;
478:                 "FormTme.AlternarPagina")
479:         ENDTRY
480: 
481:         RETURN loc_lResultado
482:     ENDPROC
483: 
484:     *===========================================================================
485:     * ConfigurarPaginaDados - Page2: cabecalho + container de acao (vazio)
486:     * Campos e botoes Confirmar/Cancelar serao adicionados em fases futuras
487:     *===========================================================================
488:     PROTECTED PROCEDURE ConfigurarPaginaDados()
489:         LOCAL loc_oPagina
490:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
491: 
492:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
493: 
494:         *-- Cabecalho cinza (identico ao da pagina Lista) - PRIMEIRO AddObject da pagina
495:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
496:         WITH loc_oPagina.cnt_4c_Cabecalho
497:             .Top           = 29
498:             .Left          = 0
499:             .Width         = THIS.Width
500:             .Height        = 80
501:             .BackColor     = RGB(100, 100, 100)
502:             .BorderWidth   = 0
503:             .SpecialEffect = 0
504:             .Visible       = .T.
505: 
506:             .AddObject("lbl_4c_Sombra", "Label")
507:             WITH .lbl_4c_Sombra
508:                 .Caption   = THIS.Caption
509:                 .Top       = 15
510:                 .Left      = 10
511:                 .Width     = THIS.Width
512:                 .Height    = 40
513:                 .FontName  = "Tahoma"
514:                 .FontSize  = 16
515:                 .FontBold  = .T.
516:                 .ForeColor = RGB(0, 0, 0)
517:                 .BackStyle = 0
518:                 .AutoSize  = .F.
519:                 .Visible   = .T.
520:             ENDWITH
521: 
522:             .AddObject("lbl_4c_Titulo", "Label")
523:             WITH .lbl_4c_Titulo
524:                 .Caption   = THIS.Caption
525:                 .Top       = 18
526:                 .Left      = 10
527:                 .Width     = THIS.Width
528:                 .Height    = 46

*-- Linhas 573 a 641:
573:             .AutoSize        = .F.
574:             .Visible         = .T.
575:         ENDWITH
576:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
577: 
578:         *-- Botao Cancelar (Left=80)
579:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
580:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
581:             .Caption         = "Encerrar"
582:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
583:             .PicturePosition = 13
584:             .Top             = 5
585:             .Left            = 80
586:             .Width           = 75
587:             .Height          = 75
588:             .FontName        = "Tahoma"
589:             .FontBold        = .T.
590:             .FontItalic      = .T.
591:             .FontSize        = 8
592:             .ForeColor       = RGB(90, 90, 90)
593:             .BackColor       = RGB(255, 255, 255)
594:             .Themes          = .F.
595:             .SpecialEffect   = 0
596:             .MousePointer    = 15
597:             .WordWrap        = .T.
598:             .AutoSize        = .F.
599:             .Visible         = .T.
600:         ENDWITH
601:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
602: 
603:         *-- FASE 5/8 - Campos Principais Parte 1 (Secao "Configuracao do
604:         *-- Transporte" do legado: Pageframe1.Page1, Top original 12..149).
605:         *-- FASE 6/8 - Campos Restantes Parte 2 (Secao "Configuracao da area
606:         *-- do FTP" do legado: Pageframe1.Page1, Top original 185..306).
607:         *-- Traducao de coordenadas: Top_novo = Top_original + 103
608:         *-- (compensa cabecalho canonico Top=29/Height=80 -> minimo 109).
609:         THIS.AdicionarCamposIdentificacao(loc_oPagina)
610:         THIS.AdicionarCamposTransporte(loc_oPagina)
611:         THIS.AdicionarCamposFtp(loc_oPagina)
612: 
613:         *-- FASE 9 - PageFrame interno (legado Pageframe1.Page2.Configuracao, 3
614:         *-- sub-paginas: Titulos/Pag/Rec/Lote Chq, Operacoes de Estoque e
615:         *-- Configuracao). Posicionado abaixo da secao FTP, que termina em
616:         *-- Top=411 (shp_4c_DivisorFtpFim). Page2 = legado Configuracao.Page1
617:         *-- "Operacoes de Estoque" (grid de 11 colunas) - conteudo desta fase.
618:         loc_oPagina.AddObject("pgf_4c_DadosInternos", "PageFrame")
619:         WITH loc_oPagina.pgf_4c_DadosInternos
620:             .PageCount = 3
621:             .Top       = 420
622:             .Left      = 6
623:             .Width     = 689
624:             .Height    = 291
625:             .Visible   = .T.
626: 
627:             .Page1.Caption   = "Titulos/Pag/Rec/Lote Chq"
628:             .Page1.FontName  = "Tahoma"
629:             .Page1.FontSize  = 8
630:             .Page1.BackColor = RGB(255, 255, 255)
631:             .Page1.ForeColor = RGB(90, 90, 90)
632: 
633:             .Page2.Caption   = "Opera" + CHR(231) + CHR(245) + "es de Estoque"
634:             .Page2.FontName  = "Tahoma"
635:             .Page2.FontSize  = 8
636:             .Page2.BackColor = RGB(255, 255, 255)
637:             .Page2.ForeColor = RGB(90, 90, 90)
638: 
639:             .Page3.Caption   = "Configura" + CHR(231) + CHR(227) + "o"
640:             .Page3.FontName  = "Tahoma"
641:             .Page3.FontSize  = 8

*-- Linhas 653 a 704:
653:         THIS.ConfigurarPgPage1()
654:         THIS.ConfigurarPgPage2()
655: 
656:         THIS.TornarControlesVisiveis(loc_oPagina)
657:     ENDPROC
658: 
659:     *===========================================================================
660:     * AdicionarCamposIdentificacao - Linha de identificacao (fora da caixa
661:     * "Configuracao do Transporte"): Processo/Tipos, Empresa, Descricao,
662:     * Tipo de Extensao do Arquivo. Legado: Top 12/16.
663:     *===========================================================================
664:     PROTECTED PROCEDURE AdicionarCamposIdentificacao(par_oPagina)
665:         *-- Processo (Tipos) - chave do transporte
666:         par_oPagina.AddObject("lbl_4c_Processo", "Label")
667:         WITH par_oPagina.lbl_4c_Processo
668:             .Caption   = "Processo :"
669:             .Top       = 119
670:             .Left      = 18
671:             .Width     = 62
672:             .Height    = 15
673:             .FontName  = "Tahoma"
674:             .FontSize  = 8
675:             .ForeColor = RGB(90, 90, 90)
676:             .BackStyle = 0
677:             .AutoSize  = .F.
678:             .Visible   = .T.
679:         ENDWITH
680: 
681:         par_oPagina.AddObject("txt_4c_Tipos", "TextBox")
682:         WITH par_oPagina.txt_4c_Tipos
683:             .Top       = 115
684:             .Left      = 85
685:             .Width     = 52
686:             .Height    = 23
687:             .FontName  = "Tahoma"
688:             .FontSize  = 8
689:             .ForeColor = RGB(0, 0, 0)
690:             .BackColor = RGB(255, 255, 255)
691:             .Value     = ""
692:             .Visible   = .T.
693:         ENDWITH
694: 
695:         *-- Empresa (Emps) - fAcessoEmpresa() NAO foi portada, campo simples
696:         par_oPagina.AddObject("lbl_4c_Empresa", "Label")
697:         WITH par_oPagina.lbl_4c_Empresa
698:             .Caption   = "Empresa :"
699:             .Top       = 119
700:             .Left      = 142
701:             .Width     = 60
702:             .Height    = 15
703:             .FontName  = "Tahoma"
704:             .FontSize  = 8

*-- Linhas 790 a 833:
790:     * geracao, No.Transporte Ok, diretorio de leitura, Nao Checar Sequencia,
791:     * diretorio de recepcao, diretorio para arquivar.
792:     *===========================================================================
793:     PROTECTED PROCEDURE AdicionarCamposTransporte(par_oPagina)
794:         *-- Divisor + titulo da secao (Shape3 + Say15 do legado)
795:         par_oPagina.AddObject("shp_4c_DivisorTransporte", "Shape")
796:         WITH par_oPagina.shp_4c_DivisorTransporte
797:             .Top     = 147
798:             .Left    = 6
799:             .Width   = 690
800:             .Height  = 2
801:             .Visible = .T.
802:         ENDWITH
803: 
804:         par_oPagina.AddObject("lbl_4c_SecaoTransporte", "Label")
805:         WITH par_oPagina.lbl_4c_SecaoTransporte
806:             .Caption   = " Configura" + CHR(231) + CHR(227) + "o do Transporte"
807:             .Top       = 150
808:             .Left      = 6
809:             .Width     = 250
810:             .Height    = 18
811:             .FontName  = "Tahoma"
812:             .FontSize  = 8
813:             .FontBold  = .T.
814:             .ForeColor = RGB(90, 90, 90)
815:             .BackStyle = 0
816:             .AutoSize  = .F.
817:             .Visible   = .T.
818:         ENDWITH
819: 
820:         *-- Transporte (Dados) - lookup SigPrTrn.Codigos (F4/LostFocus)
821:         par_oPagina.AddObject("lbl_4c_TransporteDados", "Label")
822:         WITH par_oPagina.lbl_4c_TransporteDados
823:             .Caption   = "Transporte (Dados) :"
824:             .Top       = 157
825:             .Left      = 506
826:             .Width     = 120
827:             .Height    = 15
828:             .FontName  = "Tahoma"
829:             .FontSize  = 8
830:             .ForeColor = RGB(90, 90, 90)
831:             .BackStyle = 0
832:             .AutoSize  = .F.
833:             .Visible   = .T.

*-- Linhas 846 a 921:
846:             .Value     = ""
847:             .Visible   = .T.
848:         ENDWITH
849:         BINDEVENT(par_oPagina.txt_4c_TransTipo, "KeyPress", THIS, "TeclaTransTipo")
850:         BINDEVENT(par_oPagina.txt_4c_TransTipo, "KeyPress", THIS, "ValidarTransTipo")
851: 
852:         *-- Transporte - diretorio de geracao/gravacao (drivets)
853:         par_oPagina.AddObject("lbl_4c_Transporte", "Label")
854:         WITH par_oPagina.lbl_4c_Transporte
855:             .Caption   = "Transporte :"
856:             .Top       = 183
857:             .Left      = 15
858:             .Width     = 62
859:             .Height    = 15
860:             .FontName  = "Tahoma"
861:             .FontSize  = 8
862:             .ForeColor = RGB(90, 90, 90)
863:             .BackStyle = 0
864:             .AutoSize  = .F.
865:             .Visible   = .T.
866:         ENDWITH
867: 
868:         par_oPagina.AddObject("txt_4c_DirGeracao", "TextBox")
869:         WITH par_oPagina.txt_4c_DirGeracao
870:             .Top       = 180
871:             .Left      = 79
872:             .Width     = 430
873:             .Height    = 23
874:             .FontName  = "Tahoma"
875:             .FontSize  = 8
876:             .ForeColor = RGB(0, 0, 0)
877:             .BackColor = RGB(255, 255, 255)
878:             .Value     = ""
879:             .Visible   = .T.
880:         ENDWITH
881:         BINDEVENT(par_oPagina.txt_4c_DirGeracao, "KeyPress", THIS, "ValidarDirGeracao")
882: 
883:         *-- No. Transporte Ok (clrarqs) - numerico
884:         par_oPagina.AddObject("lbl_4c_NoTransporteOk", "Label")
885:         WITH par_oPagina.lbl_4c_NoTransporteOk
886:             .Caption   = "No. Transporte Ok :"
887:             .Top       = 184
888:             .Left      = 555
889:             .Width     = 120
890:             .Height    = 15
891:             .FontName  = "Tahoma"
892:             .FontSize  = 8
893:             .ForeColor = RGB(90, 90, 90)
894:             .BackStyle = 0
895:             .AutoSize  = .F.
896:             .Visible   = .T.
897:         ENDWITH
898: 
899:         par_oPagina.AddObject("txt_4c_ClrArqOks", "TextBox")
900:         WITH par_oPagina.txt_4c_ClrArqOks
901:             .Top       = 180
902:             .Left      = 650
903:             .Width     = 31
904:             .Height    = 23
905:             .FontName  = "Tahoma"
906:             .FontSize  = 8
907:             .ForeColor = RGB(0, 0, 0)
908:             .BackColor = RGB(255, 255, 255)
909:             .InputMask = "999"
910:             .Value     = ""
911:             .Visible   = .T.
912:         ENDWITH
913: 
914:         *-- Leitura - diretorio de leitura do zip (drivels)
915:         par_oPagina.AddObject("lbl_4c_Leitura", "Label")
916:         WITH par_oPagina.lbl_4c_Leitura
917:             .Caption   = "Leitura :"
918:             .Top       = 205
919:             .Left      = 35
920:             .Width     = 42
921:             .Height    = 15

*-- Linhas 940 a 1061:
940:             .Value     = ""
941:             .Visible   = .T.
942:         ENDWITH
943:         BINDEVENT(par_oPagina.txt_4c_DirLeitura, "KeyPress", THIS, "ValidarDirLeitura")
944: 
945:         *-- Nao Checar Sequencia (nchkseqs)
946:         par_oPagina.AddObject("chk_4c_Seqnum", "CheckBox")
947:         WITH par_oPagina.chk_4c_Seqnum
948:             .Caption   = "N" + CHR(227) + "o Checar Sequ" + CHR(234) + "ncia "
949:             .Top       = 207
950:             .Left      = 531
951:             .Width     = 129
952:             .Height    = 15
953:             .FontName  = "Tahoma"
954:             .FontSize  = 8
955:             .ForeColor = RGB(90, 90, 90)
956:             .BackStyle = 0
957:             .Value     = 0
958:             .Visible   = .T.
959:         ENDWITH
960: 
961:         *-- Recepcao - diretorio de recepcao do transporte (drivers)
962:         par_oPagina.AddObject("lbl_4c_Recepcao", "Label")
963:         WITH par_oPagina.lbl_4c_Recepcao
964:             .Caption   = "Recep" + CHR(231) + CHR(227) + "o :"
965:             .Top       = 228
966:             .Left      = 21
967:             .Width     = 56
968:             .Height    = 15
969:             .FontName  = "Tahoma"
970:             .FontSize  = 8
971:             .ForeColor = RGB(90, 90, 90)
972:             .BackStyle = 0
973:             .AutoSize  = .F.
974:             .Visible   = .T.
975:         ENDWITH
976: 
977:         par_oPagina.AddObject("txt_4c_DirRecepcao", "TextBox")
978:         WITH par_oPagina.txt_4c_DirRecepcao
979:             .Top       = 225
980:             .Left      = 79
981:             .Width     = 430
982:             .Height    = 23
983:             .FontName  = "Tahoma"
984:             .FontSize  = 8
985:             .ForeColor = RGB(0, 0, 0)
986:             .BackColor = RGB(255, 255, 255)
987:             .Value     = ""
988:             .Visible   = .T.
989:         ENDWITH
990:         BINDEVENT(par_oPagina.txt_4c_DirRecepcao, "KeyPress", THIS, "ValidarDirRecepcao")
991: 
992:         *-- Arquivar - diretorio para arquivar arquivo recebido (paths, opcional)
993:         par_oPagina.AddObject("lbl_4c_Arquivar", "Label")
994:         WITH par_oPagina.lbl_4c_Arquivar
995:             .Caption   = "Arquivar :"
996:             .Top       = 252
997:             .Left      = 27
998:             .Width     = 50
999:             .Height    = 15
1000:             .FontName  = "Tahoma"
1001:             .FontSize  = 8
1002:             .ForeColor = RGB(90, 90, 90)
1003:             .BackStyle = 0
1004:             .AutoSize  = .F.
1005:             .Visible   = .T.
1006:         ENDWITH
1007: 
1008:         par_oPagina.AddObject("txt_4c_DirArquivar", "TextBox")
1009:         WITH par_oPagina.txt_4c_DirArquivar
1010:             .Top       = 249
1011:             .Left      = 79
1012:             .Width     = 430
1013:             .Height    = 23
1014:             .FontName  = "Tahoma"
1015:             .FontSize  = 8
1016:             .ForeColor = RGB(0, 0, 0)
1017:             .BackColor = RGB(255, 255, 255)
1018:             .Value     = ""
1019:             .Visible   = .T.
1020:         ENDWITH
1021:         BINDEVENT(par_oPagina.txt_4c_DirArquivar, "KeyPress", THIS, "ValidarDirArquivar")
1022: 
1023:         *-- Caixa decorativa em torno de "Prox.Transp." e "Prox.Recebe" (Shape2 do legado)
1024:         par_oPagina.AddObject("shp_4c_CaixaProximos", "Shape")
1025:         WITH par_oPagina.shp_4c_CaixaProximos
1026:             .Top     = 230
1027:             .Left    = 516
1028:             .Width   = 172
1029:             .Height  = 48
1030:             .Visible = .T.
1031:         ENDWITH
1032: 
1033:         *-- Proximo Numero de Transporte (sem ControlSource no legado - campo
1034:         *-- desvinculado, nao gravado na tabela)
1035:         par_oPagina.AddObject("lbl_4c_ProxTransp", "Label")
1036:         WITH par_oPagina.lbl_4c_ProxTransp
1037:             .Caption   = "Pr" + CHR(243) + "x.Transp."
1038:             .Top       = 235
1039:             .Left      = 523
1040:             .Width     = 90
1041:             .Height    = 15
1042:             .FontName  = "Tahoma"
1043:             .FontSize  = 8
1044:             .ForeColor = RGB(90, 90, 90)
1045:             .BackStyle = 0
1046:             .AutoSize  = .F.
1047:             .Visible   = .T.
1048:         ENDWITH
1049: 
1050:         par_oPagina.AddObject("txt_4c_ProxTransp", "TextBox")
1051:         WITH par_oPagina.txt_4c_ProxTransp
1052:             .Top       = 250
1053:             .Left      = 529
1054:             .Width     = 58
1055:             .Height    = 23
1056:             .FontName  = "Tahoma"
1057:             .FontSize  = 8
1058:             .ForeColor = RGB(0, 0, 0)
1059:             .BackColor = RGB(255, 255, 255)
1060:             .InputMask = "999999"
1061:             .Value     = ""

*-- Linhas 1111 a 1154:
1111:     * endereco FTP, usuario, senha (+ redigita confirmacao), pasta de envio,
1112:     * pasta de recepcao.
1113:     *===========================================================================
1114:     PROTECTED PROCEDURE AdicionarCamposFtp(par_oPagina)
1115:         *-- Titulo da secao (Say12 do legado)
1116:         par_oPagina.AddObject("lbl_4c_SecaoFtp", "Label")
1117:         WITH par_oPagina.lbl_4c_SecaoFtp
1118:             .Caption   = " Configura" + CHR(231) + CHR(227) + "o da " + CHR(225) + "rea do FTP "
1119:             .Top       = 288
1120:             .Left      = 5
1121:             .Width     = 194
1122:             .Height    = 18
1123:             .FontName  = "Tahoma"
1124:             .FontSize  = 8
1125:             .FontBold  = .T.
1126:             .ForeColor = RGB(90, 90, 90)
1127:             .BackStyle = 0
1128:             .AutoSize  = .F.
1129:             .Visible   = .T.
1130:         ENDWITH
1131: 
1132:         *-- Tipo de Conexao (tpconexao) - D=Dial-Up / B=Banda Larga
1133:         par_oPagina.AddObject("lbl_4c_TipoConexao", "Label")
1134:         WITH par_oPagina.lbl_4c_TipoConexao
1135:             .Caption   = "Tipo de Conex" + CHR(227) + "o :"
1136:             .Top       = 314
1137:             .Left      = 27
1138:             .Width     = 90
1139:             .Height    = 15
1140:             .FontName  = "Tahoma"
1141:             .FontSize  = 8
1142:             .ForeColor = RGB(90, 90, 90)
1143:             .BackStyle = 0
1144:             .AutoSize  = .F.
1145:             .Visible   = .T.
1146:         ENDWITH
1147: 
1148:         par_oPagina.AddObject("txt_4c_Tpconexao", "TextBox")
1149:         WITH par_oPagina.txt_4c_Tpconexao
1150:             .Top       = 310
1151:             .Left      = 122
1152:             .Width     = 28
1153:             .Height    = 23
1154:             .FontName  = "Tahoma"

*-- Linhas 1319 a 1362:
1319:             .Value        = ""
1320:             .Visible      = .T.
1321:         ENDWITH
1322:         BINDEVENT(par_oPagina.txt_4c_Ftpsenha, "KeyPress", THIS, "ValidarFtpSenha")
1323: 
1324:         par_oPagina.AddObject("lbl_4c_Senha", "Label")
1325:         WITH par_oPagina.lbl_4c_Senha
1326:             .Caption   = "Senha :"
1327:             .Top       = 359
1328:             .Left      = 483
1329:             .Width     = 39
1330:             .Height    = 15
1331:             .FontName  = "Tahoma"
1332:             .FontSize  = 8
1333:             .ForeColor = RGB(90, 90, 90)
1334:             .BackStyle = 0
1335:             .AutoSize  = .F.
1336:             .Visible   = .T.
1337:         ENDWITH
1338: 
1339:         *-- Pasta p/Recepcao (dirftpls)
1340:         par_oPagina.AddObject("txt_4c_Dirftpls", "TextBox")
1341:         WITH par_oPagina.txt_4c_Dirftpls
1342:             .Top       = 379
1343:             .Left      = 122
1344:             .Width     = 330
1345:             .Height    = 23
1346:             .FontName  = "Tahoma"
1347:             .FontSize  = 8
1348:             .ForeColor = RGB(0, 0, 0)
1349:             .BackColor = RGB(255, 255, 255)
1350:             .Value     = ""
1351:             .Visible   = .T.
1352:         ENDWITH
1353: 
1354:         par_oPagina.AddObject("lbl_4c_PastaRecepcao", "Label")
1355:         WITH par_oPagina.lbl_4c_PastaRecepcao
1356:             .Caption   = "Pasta p/Recep" + CHR(231) + CHR(227) + "o :"
1357:             .Top       = 381
1358:             .Left      = 21
1359:             .Width     = 96
1360:             .Height    = 15
1361:             .FontName  = "Tahoma"
1362:             .FontSize  = 8

*-- Linhas 1382 a 1461:
1382:             .Value        = ""
1383:             .Visible      = .T.
1384:         ENDWITH
1385:         BINDEVENT(par_oPagina.txt_4c_Senha2, "KeyPress", THIS, "ValidarSenha2")
1386: 
1387:         par_oPagina.AddObject("lbl_4c_Redigita", "Label")
1388:         WITH par_oPagina.lbl_4c_Redigita
1389:             .Caption   = "Redigita :"
1390:             .Top       = 382
1391:             .Left      = 474
1392:             .Width     = 48
1393:             .Height    = 15
1394:             .FontName  = "Tahoma"
1395:             .FontSize  = 8
1396:             .ForeColor = RGB(90, 90, 90)
1397:             .BackStyle = 0
1398:             .AutoSize  = .F.
1399:             .Visible   = .T.
1400:         ENDWITH
1401: 
1402:         *-- Divisor de fechamento da caixa "Configuracao da area do FTP" (Shape4 do legado)
1403:         par_oPagina.AddObject("shp_4c_DivisorFtpFim", "Shape")
1404:         WITH par_oPagina.shp_4c_DivisorFtpFim
1405:             .Top     = 409
1406:             .Left    = 4
1407:             .Width   = 690
1408:             .Height  = 2
1409:             .Visible = .T.
1410:         ENDWITH
1411:     ENDPROC
1412: 
1413:     *===========================================================================
1414:     * ConfigurarPgPage1 - pgf_4c_DadosInternos.Page2 (legado Pageframe1.Page2.
1415:     * Configuracao.Page1 "Operacoes de Estoque"): grid grd_4c_Grade (11
1416:     * colunas, cursor_4c_Grade = csGrade legado) + 14 labels de legenda S/N/T
1417:     * abaixo da grade. fAcessoEmpresa()/fAcessoMovmto()/fAcessoContas() NAO
1418:     * foram portadas (memoria do projeto) - colunas Emp/Empds/Operacao
1419:     * Destino/Local Entrega ficam como campos simples, sem lookup.
1420:     *===========================================================================
1421:     PROTECTED PROCEDURE ConfigurarPgPage1()
1422:         LOCAL loc_oPgN, loc_nCol
1423: 
1424:         IF !USED("cursor_4c_Grade")
1425:             SET NULL ON
1426:             CREATE CURSOR cursor_4c_Grade (tipoemps C(9), emps C(3), dopes C(20), ;
1427:                 cidchaves C(20), chkpagos C(1), chksubns C(1), empds C(3), ;
1428:                 dopeds C(20), contaes C(10), apagas C(1), ndias N(2), ;
1429:                 numeras C(1), dttrans C(1))
1430:             SET NULL OFF
1431:         ENDIF
1432: 
1433:         loc_oPgN = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page2
1434: 
1435:         *-- Grid de operacoes (csGrade no legado)
1436:         loc_oPgN.AddObject("grd_4c_Grade", "Grid")
1437:         loc_oPgN.grd_4c_Grade.ColumnCount  = 11
1438:         loc_oPgN.grd_4c_Grade.RecordSource = "cursor_4c_Grade"
1439:         WITH loc_oPgN.grd_4c_Grade
1440:             .Top               = 1
1441:             .Left              = 55
1442:             .Width             = 595
1443:             .Height            = 241
1444:             .FontName          = "Tahoma"
1445:             .FontSize          = 8
1446:             .AllowHeaderSizing = .F.
1447:             .AllowRowSizing    = .F.
1448:             .DeleteMark        = .F.
1449:             .RecordMark        = .F.
1450:             .HeaderHeight      = 16
1451:             .RowHeight         = 16
1452:             .ScrollBars        = 2
1453:             .GridLineColor     = RGB(238, 238, 238)
1454:             .Visible           = .T.
1455: 
1456:             .Column1.ControlSource = "cursor_4c_Grade.emps"
1457:             .Column1.Width         = 34
1458:             .Column1.Movable       = .F.
1459:             .Column1.Resizable     = .F.
1460: 
1461:             .Column2.ControlSource = "cursor_4c_Grade.dopes"

*-- Linhas 1550 a 1599:
1550: 
1551:         *-- Validacoes (LostFocus - fAcessoEmpresa/fAcessoMovmto/fAcessoContas
1552:         *-- NAO foram portadas: colunas 1/5/6/7 ficam sem lookup, campo simples)
1553:         BINDEVENT(loc_oPgN.grd_4c_Grade.Column2.Text1,  "KeyPress", THIS, "ValidarGradeOperacao")
1554:         BINDEVENT(loc_oPgN.grd_4c_Grade.Column3.Text1,  "KeyPress", THIS, "ValidarGradeSNT3")
1555:         BINDEVENT(loc_oPgN.grd_4c_Grade.Column4.Text1,  "KeyPress", THIS, "ValidarGradeSNT4")
1556:         BINDEVENT(loc_oPgN.grd_4c_Grade.Column7.Text1,  "KeyPress", THIS, "ValidarGradeLocalEntrega")
1557:         BINDEVENT(loc_oPgN.grd_4c_Grade.Column8.Text1,  "KeyPress", THIS, "ValidarGradeApagas")
1558:         BINDEVENT(loc_oPgN.grd_4c_Grade.Column10.Text1, "KeyPress", THIS, "ValidarGradeNumeras")
1559:         BINDEVENT(loc_oPgN.grd_4c_Grade.Column11.Text1, "KeyPress", THIS, "ValidarGradeDtTrans")
1560: 
1561:         *-- Legenda [S]im/[N]ao/[T]odos - Pg/Bx (Label1..Label10 do legado)
1562:         loc_oPgN.AddObject("lbl_4c_LegendaPg", "Label")
1563:         WITH loc_oPgN.lbl_4c_LegendaPg
1564:             .Caption   = "[    ]im / [    ]ao / [    ]odos"
1565:             .Top       = 247
1566:             .Left      = 69
1567:             .Width     = 137
1568:             .Height    = 13
1569:             .FontName  = "Tahoma"
1570:             .FontSize  = 7
1571:             .FontBold  = .T.
1572:             .ForeColor = RGB(90, 90, 90)
1573:             .BackStyle = 0
1574:             .AutoSize  = .T.
1575:             .Visible   = .T.
1576:         ENDWITH
1577: 
1578:         loc_oPgN.AddObject("lbl_4c_LegendaBx", "Label")
1579:         WITH loc_oPgN.lbl_4c_LegendaBx
1580:             .Caption   = "[    ]im / [    ]ao / [    ]odos"
1581:             .Top       = 247
1582:             .Left      = 318
1583:             .Width     = 137
1584:             .Height    = 13
1585:             .FontName  = "Tahoma"
1586:             .FontSize  = 7
1587:             .FontBold  = .T.
1588:             .ForeColor = RGB(90, 90, 90)
1589:             .BackStyle = 0
1590:             .AutoSize  = .T.
1591:             .Visible   = .T.
1592:         ENDWITH
1593: 
1594:         loc_oPgN.AddObject("lbl_4c_RotuloPg", "Label")
1595:         WITH loc_oPgN.lbl_4c_RotuloPg
1596:             .Caption   = "Pg(Pago) : "
1597:             .Top       = 247
1598:             .Left      = 12
1599:             .Width     = 59

*-- Linhas 1784 a 1958:
1784:             .Visible   = .T.
1785:         ENDWITH
1786: 
1787:         THIS.TornarControlesVisiveis(loc_oPgN)
1788:     ENDPROC
1789: 
1790:     *===========================================================================
1791:     * ValidarGradeOperacao - LostFocus da coluna "Opera" + CHR(231)+CHR(227) +
1792:     * "o" (Dopes) do grid de opera" + CHR(231) + CHR(245) + "es. Reproduz o
1793:     * aviso do Valid legado: PAGAMENTO/RECEBIMENTO devem ser informados na
1794:     * aba "Titulos/Pag/Rec/Lote Chq", nao aqui. fAcessoMovmto() NAO foi
1795:     * portada - sem lookup, apenas o aviso.
1796:     * PUBLIC: BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3)
1797:     *===========================================================================
1798:     PROCEDURE ValidarGradeOperacao(par_nKeyCode, par_nShiftAltCtrl)
1799:         LOCAL loc_oGrid, loc_cValor
1800:         loc_oGrid  = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page2.grd_4c_Grade
1801:         loc_cValor = ALLTRIM(UPPER(loc_oGrid.Column2.Text1.Value))
1802: 
1803:         IF INLIST(loc_cValor, "PAGAMENTO", "RECEBIMENTO")
1804:             MsgAviso('Favor informar as opera' + CHR(231) + CHR(245) + 'es de PAGAMENTO/RECEBIMENTO na Aba "Titulos/Pag/Rec/Lote Chq"', ;
1805:                 "Aten" + CHR(231) + CHR(227) + "o")
1806:             loc_oGrid.Column2.Text1.Value = ""
1807:         ENDIF
1808:     ENDPROC
1809: 
1810:     *===========================================================================
1811:     * ValidarGradeSNT3/ValidarGradeSNT4 - LostFocus das colunas "Pg"/"Bx"
1812:     * (S/N/T) do grid de opera" + CHR(231) + CHR(245) + "es
1813:     * PUBLIC: BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3)
1814:     *===========================================================================
1815:     PROCEDURE ValidarGradeSNT3(par_nKeyCode, par_nShiftAltCtrl)
1816:         LOCAL loc_oText
1817:         loc_oText = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page2.grd_4c_Grade.Column3.Text1
1818:         IF !EMPTY(loc_oText.Value) AND !INLIST(UPPER(loc_oText.Value), "S", "N", "T")
1819:             MsgAviso("Informe [S]im / [N]ao / [T]odos")
1820:         ENDIF
1821:     ENDPROC
1822: 
1823:     PROCEDURE ValidarGradeSNT4(par_nKeyCode, par_nShiftAltCtrl)
1824:         LOCAL loc_oText
1825:         loc_oText = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page2.grd_4c_Grade.Column4.Text1
1826:         IF !EMPTY(loc_oText.Value) AND !INLIST(UPPER(loc_oText.Value), "S", "N", "T")
1827:             MsgAviso("Informe [S]im / [N]ao / [T]odos")
1828:         ENDIF
1829:     ENDPROC
1830: 
1831:     *===========================================================================
1832:     * ValidarGradeLocalEntrega - LostFocus da coluna "Local Entrega" (ContaEs).
1833:     * fAcessoContas() NAO foi portada (memoria do projeto: lookup UX proibido
1834:     * quando a funcao nao existe de fato) - campo simples. Reproduz apenas o
1835:     * retorno de foco do legado para a coluna 1.
1836:     * PUBLIC: BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3)
1837:     *===========================================================================
1838:     PROCEDURE ValidarGradeLocalEntrega(par_nKeyCode, par_nShiftAltCtrl)
1839:         THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page2.grd_4c_Grade.Column1.SetFocus()
1840:     ENDPROC
1841: 
1842:     *===========================================================================
1843:     * ValidarGradeApagas - LostFocus da coluna "Del" (S/N). Se [S], confirma a
1844:     * delecao dos dados apos a geracao do transporte; se recusado, limpa o
1845:     * valor (adaptacao do Valid legado - Return .f. mantinha o foco na
1846:     * celula, o que nao se aplica a um handler de LostFocus).
1847:     * PUBLIC: BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3)
1848:     *===========================================================================
1849:     PROCEDURE ValidarGradeApagas(par_nKeyCode, par_nShiftAltCtrl)
1850:         LOCAL loc_oText
1851:         loc_oText = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page2.grd_4c_Grade.Column8.Text1
1852: 
1853:         IF !EMPTY(loc_oText.Value) AND !INLIST(UPPER(loc_oText.Value), "S", "N")
1854:             MsgAviso("Informe [S]im / [N]ao / [ ]")
1855:         ELSE
1856:             IF UPPER(loc_oText.Value) == "S"
1857:                 IF !MsgConfirma("Confirma Dele" + CHR(231) + CHR(227) + "o dos Dados ap" + CHR(243) + "s a gera" + CHR(231) + CHR(227) + "o do Transporte?")
1858:                     loc_oText.Value = ""
1859:                 ENDIF
1860:             ENDIF
1861:         ENDIF
1862:     ENDPROC
1863: 
1864:     *===========================================================================
1865:     * ValidarGradeNumeras - LostFocus da coluna "NN" (troca numeracao, S/N).
1866:     * Se [S], confirma a troca de numeracao na recepcao dos dados; se
1867:     * recusado, limpa o valor (mesma adaptacao de ValidarGradeApagas).
1868:     * PUBLIC: BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3)
1869:     *===========================================================================
1870:     PROCEDURE ValidarGradeNumeras(par_nKeyCode, par_nShiftAltCtrl)
1871:         LOCAL loc_oText
1872:         loc_oText = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page2.grd_4c_Grade.Column10.Text1
1873: 
1874:         IF !EMPTY(loc_oText.Value) AND !INLIST(UPPER(loc_oText.Value), "S", "N")
1875:             MsgAviso("Informe [S]im / [N]ao / [ ]")
1876:         ELSE
1877:             IF UPPER(loc_oText.Value) == "S"
1878:                 IF !MsgConfirma("Confirma Troca da Numera" + CHR(231) + CHR(227) + "o desta Opera" + CHR(231) + CHR(227) + "o Na Recep" + CHR(231) + CHR(227) + "o dos Dados ?")
1879:                     loc_oText.Value = ""
1880:                 ENDIF
1881:             ENDIF
1882:         ENDIF
1883:     ENDPROC
1884: 
1885:     *===========================================================================
1886:     * ValidarGradeDtTrans - LostFocus da coluna "DT" (S/N). Se [S], confirma o
1887:     * envio da movimentacao com a data de transporte ja preenchida na
1888:     * recepcao dos dados; se recusado, limpa o valor (mesma adaptacao de
1889:     * ValidarGradeApagas).
1890:     * PUBLIC: BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3)
1891:     *===========================================================================
1892:     PROCEDURE ValidarGradeDtTrans(par_nKeyCode, par_nShiftAltCtrl)
1893:         LOCAL loc_oText
1894:         loc_oText = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page2.grd_4c_Grade.Column11.Text1
1895: 
1896:         IF !EMPTY(loc_oText.Value) AND !INLIST(UPPER(loc_oText.Value), "S", "N")
1897:             MsgAviso("Informe [S]im / [N]ao / [ ]")
1898:         ELSE
1899:             IF UPPER(loc_oText.Value) == "S"
1900:                 IF !MsgConfirma("Confirma Enviar a Movimenta" + CHR(231) + CHR(227) + "o com a Data de Transporte j" + CHR(225) + " Preenchida na Opera" + CHR(231) + CHR(227) + "o Na Recep" + CHR(231) + CHR(227) + "o dos Dados ?")
1901:                     loc_oText.Value = ""
1902:                 ENDIF
1903:             ENDIF
1904:         ENDIF
1905:     ENDPROC
1906: 
1907:     *===========================================================================
1908:     * ConfigurarPgPage2 - pgf_4c_DadosInternos.Page1 (legado Pageframe1.Page2.
1909:     * Configuracao.Page2 "Titulos/Pag/Rec/Lote Chq"): grid grd_4c_Titulos (3
1910:     * colunas, cursor_4c_Titulos = CsTitulo legado - mesmo cursor que
1911:     * TmeBO.this_cCursorTitulos/BuscarTitulos ja usam) + 4 labels de legenda
1912:     * S/N/A abaixo da grade. Coluna 1 (Emp): fAcessoEmpresa() NAO foi portada
1913:     * (memoria do projeto) - fica como campo simples, sem lookup. Coluna 2
1914:     * (Opera" + CHR(231) + CHR(227) + "o): fwBuscaSel legado -> equivalente
1915:     * moderno FormBuscaAuxiliar (Modo 2, cursor local cursor_4c_Operacoes
1916:     * montado por TmeBO.BuscarOperacoesDisponiveis).
1917:     *===========================================================================
1918:     PROTECTED PROCEDURE ConfigurarPgPage2()
1919:         LOCAL loc_oPgN, loc_nCol
1920: 
1921:         IF !USED("cursor_4c_Titulos")
1922:             SET NULL ON
1923:             CREATE CURSOR cursor_4c_Titulos (tipoemps C(9), emps C(3), dopes C(20), ;
1924:                 cidchaves C(20), cnotas C(1), empds C(3))
1925:             SET NULL OFF
1926:         ENDIF
1927: 
1928:         loc_oPgN = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
1929: 
1930:         *-- Grid de titulos/pagamentos/recebimentos/lote de cheque (CsTitulo no legado)
1931:         loc_oPgN.AddObject("grd_4c_Titulos", "Grid")
1932:         loc_oPgN.grd_4c_Titulos.ColumnCount  = 3
1933:         loc_oPgN.grd_4c_Titulos.RecordSource = "cursor_4c_Titulos"
1934:         WITH loc_oPgN.grd_4c_Titulos
1935:             .Top               = 1
1936:             .Left              = 222
1937:             .Width             = 260
1938:             .Height            = 242
1939:             .FontName          = "Tahoma"
1940:             .FontSize          = 8
1941:             .AllowHeaderSizing = .F.
1942:             .AllowRowSizing    = .F.
1943:             .DeleteMark        = .F.
1944:             .RecordMark        = .F.
1945:             .HeaderHeight      = 16
1946:             .RowHeight         = 16
1947:             .ScrollBars        = 2
1948:             .GridLineColor     = RGB(238, 238, 238)
1949:             .Visible           = .T.
1950: 
1951:             .Column1.ControlSource = "cursor_4c_Titulos.emps"
1952:             .Column1.Width         = 40
1953:             .Column1.Movable       = .F.
1954:             .Column1.Resizable     = .F.
1955: 
1956:             .Column2.ControlSource = "cursor_4c_Titulos.dopes"
1957:             .Column2.Width         = 150
1958:             .Column2.Movable       = .F.

*-- Linhas 1988 a 2032:
1988: 
1989:         *-- Validacoes (LostFocus - fAcessoEmpresa NAO foi portada: coluna 1
1990:         *-- fica sem lookup, campo simples)
1991:         BINDEVENT(loc_oPgN.grd_4c_Titulos.Column2.Text1, "KeyPress", THIS, "ValidarGradeTituloOperacao")
1992:         BINDEVENT(loc_oPgN.grd_4c_Titulos.Column3.Text1, "KeyPress", THIS, "ValidarGradeTituloSNA")
1993: 
1994:         *-- Legenda [S]im/[N]ao/[A]mbos (Label1/5/7/9 do legado)
1995:         loc_oPgN.AddObject("lbl_4c_LegendaSNA", "Label")
1996:         WITH loc_oPgN.lbl_4c_LegendaSNA
1997:             .Caption   = "[ S ]im / [ N ]ao / [ A ]mbos"
1998:             .Top       = 248
1999:             .Left      = 270
2000:             .Width     = 155
2001:             .Height    = 15
2002:             .FontName  = "Tahoma"
2003:             .FontSize  = 8
2004:             .FontBold  = .T.
2005:             .ForeColor = RGB(90, 90, 90)
2006:             .BackStyle = 0
2007:             .AutoSize  = .T.
2008:             .Visible   = .T.
2009:         ENDWITH
2010: 
2011:         loc_oPgN.AddObject("lbl_4c_SnaS", "Label")
2012:         WITH loc_oPgN.lbl_4c_SnaS
2013:             .Caption   = "S"
2014:             .Top       = 247
2015:             .Left      = 278
2016:             .Width     = 10
2017:             .Height    = 16
2018:             .FontName  = "Tahoma"
2019:             .FontSize  = 8
2020:             .FontBold  = .T.
2021:             .ForeColor = RGB(90, 90, 90)
2022:             .BackStyle = 0
2023:             .AutoSize  = .T.
2024:             .Visible   = .T.
2025:         ENDWITH
2026: 
2027:         loc_oPgN.AddObject("lbl_4c_SnaN", "Label")
2028:         WITH loc_oPgN.lbl_4c_SnaN
2029:             .Caption   = "N"
2030:             .Top       = 247
2031:             .Left      = 326
2032:             .Width     = 10

*-- Linhas 2056 a 2812:
2056:             .Visible   = .T.
2057:         ENDWITH
2058: 
2059:         THIS.TornarControlesVisiveis(loc_oPgN)
2060:     ENDPROC
2061: 
2062:     *===========================================================================
2063:     * ValidarGradeTituloOperacao - LostFocus da coluna "Opera" + CHR(231) +
2064:     * CHR(227) + "o" (Dopes) do grid de t" + CHR(237) + "tulos. Reproduz o
2065:     * Valid legado: se o valor nao existir em SigOpOpe nem for uma das
2066:     * operacoes especiais fixas (PAGAMENTO/RECEBIMENTO/LOTE DE CHEQUE), abre
2067:     * FormBuscaAuxiliar (equivalente ao fwBuscaSel legado sobre CrSigOpOpe)
2068:     * para selecao; ao selecionar, marca cnotas = "A" (Replace ... With 'A'
2069:     * in CsTitulo do legado).
2070:     * PUBLIC: BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3)
2071:     *===========================================================================
2072:     PROCEDURE ValidarGradeTituloOperacao(par_nKeyCode, par_nShiftAltCtrl)
2073:         LOCAL loc_oGrid, loc_cValor, loc_oBusca
2074: 
2075:         loc_oGrid  = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1.grd_4c_Titulos
2076:         loc_cValor = ALLTRIM(UPPER(loc_oGrid.Column2.Text1.Value))
2077: 
2078:         IF EMPTY(loc_cValor)
2079:             RETURN
2080:         ENDIF
2081: 
2082:         IF !THIS.this_oBusinessObject.BuscarOperacoesDisponiveis()
2083:             RETURN
2084:         ENDIF
2085: 
2086:         IF USED("cursor_4c_Operacoes")
2087:             IF !SEEK(loc_cValor, "cursor_4c_Operacoes", "dopes")
2088:                 TRY
2089:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2090:                     IF VARTYPE(loc_oBusca) = "O"
2091:                         loc_oBusca.this_cCursorDestino = "cursor_4c_Operacoes"
2092:                         loc_oBusca.this_cTitulo        = "Opera" + CHR(231) + CHR(245) + "es de T" + CHR(237) + "tulos"
2093:                         loc_oBusca.mAddColuna("dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
2094:                         loc_oBusca.Show()
2095: 
2096:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Operacoes")
2097:                             loc_oGrid.Column2.Text1.Value = ALLTRIM(cursor_4c_Operacoes.dopes)
2098:                             IF USED("cursor_4c_Titulos")
2099:                                 REPLACE cnotas WITH "A" IN cursor_4c_Titulos
2100:                             ENDIF
2101:                         ENDIF
2102:                         loc_oBusca.Release()
2103:                     ENDIF
2104:                 CATCH TO loException
2105:                     MsgErro(loException.Message, "FormTme.ValidarGradeTituloOperacao")
2106:                 ENDTRY
2107:             ENDIF
2108:             USE IN cursor_4c_Operacoes
2109:         ENDIF
2110:     ENDPROC
2111: 
2112:     *===========================================================================
2113:     * ValidarGradeTituloSNA - LostFocus da coluna "S/N/A" do grid de titulos
2114:     * PUBLIC: BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3)
2115:     *===========================================================================
2116:     PROCEDURE ValidarGradeTituloSNA(par_nKeyCode, par_nShiftAltCtrl)
2117:         LOCAL loc_oText
2118:         loc_oText = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1.grd_4c_Titulos.Column3.Text1
2119: 
2120:         IF !EMPTY(loc_oText.Value) AND !INLIST(UPPER(loc_oText.Value), "S", "N", "A")
2121:             MsgAviso("Informe [S]sim / [N]ao / [A]mbos")
2122:         ENDIF
2123:     ENDPROC
2124: 
2125:     *===========================================================================
2126:     * TeclaTransTipo - KeyPress (F4) para txt_4c_TransTipo
2127:     * PUBLIC + LPARAMETERS obrigatorios (BINDEVENT so funciona com metodo
2128:     * PUBLIC; KeyPress sempre passa 2 parametros - CLAUDE.md regras #2/#38)
2129:     *===========================================================================
2130:     PROCEDURE TeclaTransTipo(par_nKeyCode, par_nShiftAltCtrl)
2131:         IF par_nKeyCode = 63
2132:             THIS.AbrirBuscaTransTipo(ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_TransTipo.Value))
2133:         ENDIF
2134:     ENDPROC
2135: 
2136:     *===========================================================================
2137:     * ValidarTransTipo - LostFocus para txt_4c_TransTipo (mesma logica do
2138:     * Valid legado: se preenchido, busca/valida em SigPrTrn). Guard evita
2139:     * reabrir o lookup quando o valor nao mudou desde a ultima validacao.
2140:     *===========================================================================
2141:     PROCEDURE ValidarTransTipo(par_nKeyCode, par_nShiftAltCtrl)
2142:         LOCAL loc_cValor
2143:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_TransTipo.Value)
2144: 
2145:         IF loc_cValor == THIS.this_cUltimoTransTipo
2146:             RETURN
2147:         ENDIF
2148:         THIS.this_cUltimoTransTipo = loc_cValor
2149: 
2150:         IF !EMPTY(loc_cValor)
2151:             THIS.AbrirBuscaTransTipo(loc_cValor)
2152:         ENDIF
2153:     ENDPROC
2154: 
2155:     *===========================================================================
2156:     * AbrirBuscaTransTipo - FormBuscaAuxiliar sobre SigPrTrn (Codigos/Descrs)
2157:     *===========================================================================
2158:     PROCEDURE AbrirBuscaTransTipo(par_cValor)
2159:         LOCAL loc_oBusca, loc_oPg2
2160: 
2161:         TRY
2162:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2163: 
2164:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2165:                 "SigPrTrn", "cursor_4c_BuscaTransTipo", "Codigos", par_cValor, ;
2166:                 "Tipo de Transporte")
2167: 
2168:             IF VARTYPE(loc_oBusca) = "O"
2169:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2170:                     IF USED("cursor_4c_BuscaTransTipo")
2171:                         loc_oPg2.txt_4c_TransTipo.Value = ALLTRIM(cursor_4c_BuscaTransTipo.Codigos)
2172:                     ENDIF
2173:                 ELSE
2174:                     IF !loc_oBusca.this_lAchouRegistro
2175:                         loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
2176:                         loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
2177:                         loc_oBusca.Show()
2178:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTransTipo")
2179:                             loc_oPg2.txt_4c_TransTipo.Value = ALLTRIM(cursor_4c_BuscaTransTipo.Codigos)
2180:                         ELSE
2181:                             loc_oPg2.txt_4c_TransTipo.Value = ""
2182:                         ENDIF
2183:                     ENDIF
2184:                 ENDIF
2185:                 THIS.this_cUltimoTransTipo = ALLTRIM(loc_oPg2.txt_4c_TransTipo.Value)
2186:                 loc_oBusca.Release()
2187:             ENDIF
2188: 
2189:         CATCH TO loException
2190:             MsgErro(loException.Message, "FormTme.AbrirBuscaTransTipo")
2191:         ENDTRY
2192: 
2193:         IF USED("cursor_4c_BuscaTransTipo")
2194:             USE IN cursor_4c_BuscaTransTipo
2195:         ENDIF
2196:     ENDPROC
2197: 
2198:     *===========================================================================
2199:     * ValidarDirGeracao/ValidarDirLeitura/ValidarDirRecepcao/ValidarDirArquivar
2200:     * LostFocus - reproduz o Valid legado: se o diretorio nao existe, oferece
2201:     * GETDIR() para selecao; se confirmado invalido, avisa e limpa o campo.
2202:     * Se existe, normaliza (UPPER + barra final). Guard evita repetir o
2203:     * GETDIR quando o valor nao mudou desde a ultima validacao (Problema 45).
2204:     * Arquivar aceita vazio (campo opcional no legado).
2205:     *===========================================================================
2206:     PROCEDURE ValidarDirGeracao(par_nKeyCode, par_nShiftAltCtrl)
2207:         LOCAL loc_cValor
2208:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_DirGeracao.Value)
2209: 
2210:         IF loc_cValor == THIS.this_cUltimoDirGeracao
2211:             RETURN
2212:         ENDIF
2213: 
2214:         IF !DIRECTORY(loc_cValor)
2215:             loc_cValor = GETDIR(loc_cValor, "Diret" + CHR(243) + "rio Grava" + CHR(231) + CHR(227) + "o do Transporte")
2216:             IF !DIRECTORY(loc_cValor)
2217:                 MsgAviso("Diret" + CHR(243) + "rio N" + CHR(227) + "o Localizado!!!")
2218:                 loc_cValor = ""
2219:             ENDIF
2220:         ELSE
2221:             loc_cValor = ALLTRIM(UPPER(loc_cValor)) + IIF(RIGHT(ALLTRIM(loc_cValor), 1) != "\", "\", "")
2222:         ENDIF
2223: 
2224:         THIS.this_cUltimoDirGeracao = loc_cValor
2225:         THIS.pgf_4c_Paginas.Page2.txt_4c_DirGeracao.Value = loc_cValor
2226:         THIS.pgf_4c_Paginas.Page2.txt_4c_DirGeracao.Refresh()
2227:     ENDPROC
2228: 
2229:     PROCEDURE ValidarDirLeitura(par_nKeyCode, par_nShiftAltCtrl)
2230:         LOCAL loc_cValor
2231:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_DirLeitura.Value)
2232: 
2233:         IF loc_cValor == THIS.this_cUltimoDirLeitura
2234:             RETURN
2235:         ENDIF
2236: 
2237:         IF !DIRECTORY(loc_cValor)
2238:             loc_cValor = GETDIR(loc_cValor, "Diret" + CHR(243) + "rio Leitura do Zip")
2239:             IF !DIRECTORY(loc_cValor)
2240:                 MsgAviso("Diret" + CHR(243) + "rio N" + CHR(227) + "o Localizado!!!")
2241:                 loc_cValor = ""
2242:             ENDIF
2243:         ELSE
2244:             loc_cValor = ALLTRIM(UPPER(loc_cValor)) + IIF(RIGHT(ALLTRIM(loc_cValor), 1) != "\", "\", "")
2245:         ENDIF
2246: 
2247:         THIS.this_cUltimoDirLeitura = loc_cValor
2248:         THIS.pgf_4c_Paginas.Page2.txt_4c_DirLeitura.Value = loc_cValor
2249:         THIS.pgf_4c_Paginas.Page2.txt_4c_DirLeitura.Refresh()
2250:     ENDPROC
2251: 
2252:     PROCEDURE ValidarDirRecepcao(par_nKeyCode, par_nShiftAltCtrl)
2253:         LOCAL loc_cValor
2254:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_DirRecepcao.Value)
2255: 
2256:         IF loc_cValor == THIS.this_cUltimoDirRecepcao
2257:             RETURN
2258:         ENDIF
2259: 
2260:         IF !DIRECTORY(loc_cValor)
2261:             loc_cValor = GETDIR(loc_cValor, "Diret" + CHR(243) + "rio Recep" + CHR(231) + CHR(227) + "o do Transporte")
2262:             IF !DIRECTORY(loc_cValor)
2263:                 MsgAviso("Diret" + CHR(243) + "rio N" + CHR(227) + "o Localizado!!!")
2264:                 loc_cValor = ""
2265:             ENDIF
2266:         ELSE
2267:             loc_cValor = ALLTRIM(UPPER(loc_cValor)) + IIF(RIGHT(ALLTRIM(loc_cValor), 1) != "\", "\", "")
2268:         ENDIF
2269: 
2270:         THIS.this_cUltimoDirRecepcao = loc_cValor
2271:         THIS.pgf_4c_Paginas.Page2.txt_4c_DirRecepcao.Value = loc_cValor
2272:         THIS.pgf_4c_Paginas.Page2.txt_4c_DirRecepcao.Refresh()
2273:     ENDPROC
2274: 
2275:     PROCEDURE ValidarDirArquivar(par_nKeyCode, par_nShiftAltCtrl)
2276:         LOCAL loc_cValor
2277:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_DirArquivar.Value)
2278: 
2279:         IF loc_cValor == THIS.this_cUltimoDirArquivar
2280:             RETURN
2281:         ENDIF
2282: 
2283:         IF !EMPTY(loc_cValor)
2284:             IF !DIRECTORY(loc_cValor)
2285:                 loc_cValor = GETDIR(loc_cValor, "Diret" + CHR(243) + "rio para Arquivar o arquivo recebido")
2286:                 IF !DIRECTORY(loc_cValor)
2287:                     MsgAviso("Diret" + CHR(243) + "rio N" + CHR(227) + "o Localizado!!!")
2288:                     loc_cValor = ""
2289:                 ENDIF
2290:             ELSE
2291:                 loc_cValor = ALLTRIM(UPPER(loc_cValor)) + IIF(RIGHT(ALLTRIM(loc_cValor), 1) != "\", "\", "")
2292:             ENDIF
2293:         ENDIF
2294: 
2295:         THIS.this_cUltimoDirArquivar = loc_cValor
2296:         THIS.pgf_4c_Paginas.Page2.txt_4c_DirArquivar.Value = loc_cValor
2297:         THIS.pgf_4c_Paginas.Page2.txt_4c_DirArquivar.Refresh()
2298:     ENDPROC
2299: 
2300:     *===========================================================================
2301:     * ValidarFtpSenha - LostFocus para txt_4c_Ftpsenha. Reproduz o Valid
2302:     * legado: codifica o valor digitado usando fDecriptografar() (funcao do
2303:     * Framework legado que, apesar do nome, CODIFICA o valor para gravacao -
2304:     * ver comentario em pafBO.prg linha ~902).
2305:     *===========================================================================
2306:     PROCEDURE ValidarFtpSenha(par_nKeyCode, par_nShiftAltCtrl)
2307:         LOCAL loc_oPg2, loc_cValor
2308: 
2309:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2310:         loc_cValor = ALLTRIM(loc_oPg2.txt_4c_Ftpsenha.Value)
2311: 
2312:         IF !EMPTY(loc_cValor)
2313:             loc_oPg2.txt_4c_Ftpsenha.Value = fDecriptografar(loc_cValor)
2314:         ENDIF
2315:     ENDPROC
2316: 
2317:     *===========================================================================
2318:     * ValidarSenha2 - LostFocus para txt_4c_Senha2 (campo "Redigita"). Reproduz
2319:     * o Valid legado: compara a senha ja codificada de txt_4c_Ftpsenha com a
2320:     * codificacao do valor redigitado. Se nao conferir, pergunta se o usuario
2321:     * deseja continuar com a senha em branco:
2322:     *   - Confirmou (Sim): limpa AMBOS os campos (senha + redigita)
2323:     *   - Recusou (Nao): limpa apenas o campo de redigita
2324:     *===========================================================================
2325:     PROCEDURE ValidarSenha2(par_nKeyCode, par_nShiftAltCtrl)
2326:         LOCAL loc_oPg2, loc_cSenhaCodificada, loc_cRedigitaCodificada
2327: 
2328:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2329: 
2330:         IF !EMPTY(ALLTRIM(loc_oPg2.txt_4c_Ftpsenha.Value))
2331:             loc_cSenhaCodificada    = ALLTRIM(loc_oPg2.txt_4c_Ftpsenha.Value)
2332:             loc_cRedigitaCodificada = fDecriptografar(ALLTRIM(loc_oPg2.txt_4c_Senha2.Value))
2333: 
2334:             IF loc_cSenhaCodificada != loc_cRedigitaCodificada
2335:                 IF MsgConfirma("A Senha N" + CHR(227) + "o Confere!!! Deseja Continuar Com a Senha em Branco ?", ;
2336:                         "Erro na Confirma" + CHR(231) + CHR(227) + "o da Senha...")
2337:                     *-- Confirmou: limpa senha + redigita
2338:                     loc_oPg2.txt_4c_Ftpsenha.Value = ""
2339:                     loc_oPg2.txt_4c_Senha2.Value    = ""
2340:                 ELSE
2341:                     *-- Recusou: limpa apenas a redigita
2342:                     loc_oPg2.txt_4c_Senha2.Value = ""
2343:                 ENDIF
2344:             ENDIF
2345:         ENDIF
2346:     ENDPROC
2347: 
2348:     *===========================================================================
2349:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
2350:     * REGRA: Chamar SEMPRE com parametro: THIS.TornarControlesVisiveis(loc_oPagina)
2351:     *===========================================================================
2352:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2353:         LOCAL loc_nI, loc_oObjeto, loc_nP
2354: 
2355:         FOR loc_nI = 1 TO par_oContainer.ControlCount
2356:             loc_oObjeto = par_oContainer.Controls(loc_nI)
2357: 
2358:             IF VARTYPE(loc_oObjeto) = "O"
2359:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
2360:                     loc_oObjeto.Visible = .T.
2361:                 ENDIF
2362: 
2363:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
2364:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
2365:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
2366:                     ENDFOR
2367:                 ENDIF
2368: 
2369:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
2370:                     THIS.TornarControlesVisiveis(loc_oObjeto)
2371:                 ENDIF
2372:             ENDIF
2373:         ENDFOR
2374:     ENDPROC
2375: 
2376:     *===========================================================================
2377:     * BOParaForm - Transfere dados do BusinessObject para os controles da Page2
2378:     * Campos txt_4c_ProxTransp/txt_4c_ProxRecebe/txt_4c_Senha2 sao desvinculados
2379:     * (sem coluna na tabela) - sempre limpos ao carregar um registro.
2380:     *===========================================================================
2381:     PROTECTED PROCEDURE BOParaForm()
2382:         LOCAL loc_oPg2
2383:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2384: 
2385:         TRY
2386:             loc_oPg2.txt_4c_Tipos.Value       = THIS.this_oBusinessObject.this_cTipos
2387:             loc_oPg2.txt_4c_Emps.Value        = THIS.this_oBusinessObject.this_cEmps
2388:             loc_oPg2.txt_4c_Descrs.Value      = THIS.this_oBusinessObject.this_cDescricao
2389:             loc_oPg2.txt_4c_Extensao.Value    = THIS.this_oBusinessObject.this_cExtensao
2390:             loc_oPg2.txt_4c_TransTipo.Value   = THIS.this_oBusinessObject.this_cTipoTransporte
2391:             loc_oPg2.txt_4c_DirGeracao.Value  = THIS.this_oBusinessObject.this_cDirGeracao
2392:             loc_oPg2.txt_4c_ClrArqOks.Value   = TRANSFORM(THIS.this_oBusinessObject.this_nTransporteOk)
2393:             loc_oPg2.txt_4c_DirLeitura.Value  = THIS.this_oBusinessObject.this_cDirLeitura
2394:             loc_oPg2.chk_4c_Seqnum.Value      = THIS.this_oBusinessObject.this_lNaoChecarSequencia
2395:             loc_oPg2.txt_4c_DirRecepcao.Value = THIS.this_oBusinessObject.this_cDirRecepcao
2396:             loc_oPg2.txt_4c_DirArquivar.Value = THIS.this_oBusinessObject.this_cDirArquivar
2397:             loc_oPg2.txt_4c_Tpconexao.Value   = THIS.this_oBusinessObject.this_cTipoConexao
2398:             loc_oPg2.chk_4c_Chklocdel.Value   = THIS.this_oBusinessObject.this_lLimpaDirEnvio
2399:             loc_oPg2.chk_4c_Chkftpdel.Value   = THIS.this_oBusinessObject.this_lLimpaDirFtp
2400:             loc_oPg2.txt_4c_Ftpend.Value      = THIS.this_oBusinessObject.this_cFtpEndereco
2401:             loc_oPg2.txt_4c_Ftpusuario.Value  = THIS.this_oBusinessObject.this_cFtpUsuario
2402:             loc_oPg2.txt_4c_Dirftpts.Value    = THIS.this_oBusinessObject.this_cDirFtpEnvio
2403:             loc_oPg2.txt_4c_Ftpsenha.Value    = THIS.this_oBusinessObject.this_cFtpSenha
2404:             loc_oPg2.txt_4c_Dirftpls.Value    = THIS.this_oBusinessObject.this_cDirFtpRecepcao
2405: 
2406:             *-- Campos desvinculados (nao gravados na tabela)
2407:             loc_oPg2.txt_4c_ProxTransp.Value = ""
2408:             loc_oPg2.txt_4c_ProxRecebe.Value = ""
2409:             loc_oPg2.txt_4c_Senha2.Value     = ""
2410: 
2411:             *-- Sincroniza guardas anti-repeticao (Problema 45) com o valor carregado
2412:             THIS.this_cUltimoTransTipo   = ALLTRIM(loc_oPg2.txt_4c_TransTipo.Value)
2413:             THIS.this_cUltimoDirGeracao  = ALLTRIM(loc_oPg2.txt_4c_DirGeracao.Value)
2414:             THIS.this_cUltimoDirLeitura  = ALLTRIM(loc_oPg2.txt_4c_DirLeitura.Value)
2415:             THIS.this_cUltimoDirRecepcao = ALLTRIM(loc_oPg2.txt_4c_DirRecepcao.Value)
2416:             THIS.this_cUltimoDirArquivar = ALLTRIM(loc_oPg2.txt_4c_DirArquivar.Value)
2417:         CATCH TO loException
2418:             MostrarErro("Erro ao carregar dados no formul" + CHR(225) + "rio:" + CHR(13) + ;
2419:                 loException.Message + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), ;
2420:                 "FormTme.BOParaForm")
2421:         ENDTRY
2422:     ENDPROC
2423: 
2424:     *===========================================================================
2425:     * LimparCampos - Limpa todos os controles da Page2 (usado em Incluir)
2426:     *===========================================================================
2427:     PROTECTED PROCEDURE LimparCampos()
2428:         LOCAL loc_oPg2
2429:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2430: 
2431:         TRY
2432:             loc_oPg2.txt_4c_Tipos.Value       = ""
2433:             loc_oPg2.txt_4c_Emps.Value        = ""
2434:             loc_oPg2.txt_4c_Descrs.Value      = ""
2435:             loc_oPg2.txt_4c_Extensao.Value    = ""
2436:             loc_oPg2.txt_4c_TransTipo.Value   = ""
2437:             loc_oPg2.txt_4c_DirGeracao.Value  = ""
2438:             loc_oPg2.txt_4c_ClrArqOks.Value   = ""
2439:             loc_oPg2.txt_4c_DirLeitura.Value  = ""
2440:             loc_oPg2.chk_4c_Seqnum.Value      = 0
2441:             loc_oPg2.txt_4c_DirRecepcao.Value = ""
2442:             loc_oPg2.txt_4c_DirArquivar.Value = ""
2443:             loc_oPg2.txt_4c_ProxTransp.Value  = ""
2444:             loc_oPg2.txt_4c_ProxRecebe.Value  = ""
2445:             loc_oPg2.txt_4c_Tpconexao.Value   = ""
2446:             loc_oPg2.chk_4c_Chklocdel.Value   = 0
2447:             loc_oPg2.chk_4c_Chkftpdel.Value   = 0
2448:             loc_oPg2.txt_4c_Ftpend.Value      = ""
2449:             loc_oPg2.txt_4c_Ftpusuario.Value  = ""
2450:             loc_oPg2.txt_4c_Dirftpts.Value    = ""
2451:             loc_oPg2.txt_4c_Ftpsenha.Value    = ""
2452:             loc_oPg2.txt_4c_Dirftpls.Value    = ""
2453:             loc_oPg2.txt_4c_Senha2.Value      = ""
2454: 
2455:             *-- Reseta guardas anti-repeticao (Problema 45)
2456:             THIS.this_cUltimoTransTipo   = ""
2457:             THIS.this_cUltimoDirGeracao  = ""
2458:             THIS.this_cUltimoDirLeitura  = ""
2459:             THIS.this_cUltimoDirRecepcao = ""
2460:             THIS.this_cUltimoDirArquivar = ""
2461:         CATCH TO loException
2462:             MostrarErro("Erro ao limpar campos:" + CHR(13) + loException.Message, ;
2463:                 "FormTme.LimparCampos")
2464:         ENDTRY
2465:     ENDPROC
2466: 
2467:     *===========================================================================
2468:     * HabilitarCampos - Habilita/desabilita os controles da Page2
2469:     * Tipos/Emps (chave) so ficam editaveis em modo INCLUIR
2470:     *===========================================================================
2471:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
2472:         LOCAL loc_oPg2, loc_lChaveHabilitar
2473:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2474: 
2475:         TRY
2476:             *-- Chave (Tipos+Emps): editavel apenas em INCLUIR
2477:             loc_lChaveHabilitar = (THIS.this_cModoAtual = "INCLUIR")
2478:             loc_oPg2.txt_4c_Tipos.Enabled = loc_lChaveHabilitar
2479:             loc_oPg2.txt_4c_Emps.Enabled  = loc_lChaveHabilitar
2480: 
2481:             *-- Demais campos
2482:             loc_oPg2.txt_4c_Descrs.Enabled      = par_lHabilitar
2483:             loc_oPg2.txt_4c_Extensao.Enabled    = par_lHabilitar
2484:             loc_oPg2.txt_4c_TransTipo.Enabled   = par_lHabilitar
2485:             loc_oPg2.txt_4c_DirGeracao.Enabled  = par_lHabilitar
2486:             loc_oPg2.txt_4c_ClrArqOks.Enabled   = par_lHabilitar
2487:             loc_oPg2.txt_4c_DirLeitura.Enabled  = par_lHabilitar
2488:             loc_oPg2.chk_4c_Seqnum.Enabled      = par_lHabilitar
2489:             loc_oPg2.txt_4c_DirRecepcao.Enabled = par_lHabilitar
2490:             loc_oPg2.txt_4c_DirArquivar.Enabled = par_lHabilitar
2491:             loc_oPg2.txt_4c_ProxTransp.Enabled  = par_lHabilitar
2492:             loc_oPg2.txt_4c_ProxRecebe.Enabled  = par_lHabilitar
2493:             loc_oPg2.txt_4c_Tpconexao.Enabled   = par_lHabilitar
2494:             loc_oPg2.chk_4c_Chklocdel.Enabled   = par_lHabilitar
2495:             loc_oPg2.chk_4c_Chkftpdel.Enabled   = par_lHabilitar
2496:             loc_oPg2.txt_4c_Ftpend.Enabled      = par_lHabilitar
2497:             loc_oPg2.txt_4c_Ftpusuario.Enabled  = par_lHabilitar
2498:             loc_oPg2.txt_4c_Dirftpts.Enabled    = par_lHabilitar
2499:             loc_oPg2.txt_4c_Ftpsenha.Enabled    = par_lHabilitar
2500:             loc_oPg2.txt_4c_Dirftpls.Enabled    = par_lHabilitar
2501:             loc_oPg2.txt_4c_Senha2.Enabled      = par_lHabilitar
2502:         CATCH TO loException
2503:             MostrarErro("Erro ao habilitar campos:" + CHR(13) + loException.Message, ;
2504:                 "FormTme.HabilitarCampos")
2505:         ENDTRY
2506:     ENDPROC
2507: 
2508:     *===========================================================================
2509:     * AjustarBotoesPorModo - Ajusta Confirmar/Cancelar conforme this_cModoAtual
2510:     * PUBLIC: chamado por TesteAutomatico.prg diretamente de fora da classe
2511:     * (CLAUDE.md regra #3 - BINDEVENT/chamada externa exige metodo PUBLIC)
2512:     *===========================================================================
2513:     PROCEDURE AjustarBotoesPorModo()
2514:         LOCAL loc_oBotoesAcao
2515:         loc_oBotoesAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
2516: 
2517:         TRY
2518:             loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2519:             loc_oBotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
2520:         CATCH TO loException
2521:             MostrarErro("Erro ao ajustar bot" + CHR(245) + "es:" + CHR(13) + loException.Message, ;
2522:                 "FormTme.AjustarBotoesPorModo")
2523:         ENDTRY
2524:     ENDPROC
2525: 
2526:     *===========================================================================
2527:     * BtnIncluirClick - Prepara Page2 para inclusao de novo transporte
2528:     * PUBLIC: BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3)
2529:     *===========================================================================
2530:     PROCEDURE BtnIncluirClick()
2531:         LOCAL loc_lResultado
2532:         loc_lResultado = .F.
2533: 
2534:         TRY
2535:             THIS.this_oBusinessObject.NovoRegistro()
2536:             THIS.LimparCampos()
2537:             THIS.this_cModoAtual = "INCLUIR"
2538:             THIS.HabilitarCampos(.T.)
2539:             THIS.AjustarBotoesPorModo()
2540:             THIS.AlternarPagina(2)
2541:             loc_lResultado = .T.
2542:         CATCH TO loException
2543:             MostrarErro("Erro ao incluir transporte:" + CHR(13) + loException.Message + CHR(13) + ;
2544:                 "Linha: " + TRANSFORM(loException.LineNo), ;
2545:                 "FormTme.BtnIncluirClick")
2546:         ENDTRY
2547: 
2548:         RETURN loc_lResultado
2549:     ENDPROC
2550: 
2551:     *===========================================================================
2552:     * BtnVisualizarClick - Abre o transporte selecionado em modo somente leitura
2553:     * PUBLIC: BINDEVENT (Click do botao + DblClick do grid) exige metodo PUBLIC
2554:     *===========================================================================
2555:     PROCEDURE BtnVisualizarClick()
2556:         LOCAL loc_cTipoEmps, loc_lResultado
2557:         loc_lResultado = .F.
2558: 
2559:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
2560:             MsgAviso("Nenhum registro selecionado.", "Visualizar")
2561:         ELSE
2562:             SELECT cursor_4c_Dados
2563:             loc_cTipoEmps = ALLTRIM(cursor_4c_Dados.tipoemps)
2564: 
2565:             TRY
2566:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cTipoEmps)
2567:                     THIS.BOParaForm()
2568:                     THIS.this_cModoAtual = "VISUALIZAR"
2569:                     THIS.HabilitarCampos(.F.)
2570:                     THIS.AjustarBotoesPorModo()
2571:                     THIS.AlternarPagina(2)
2572:                     loc_lResultado = .T.
2573:                 ELSE
2574:                     MsgAviso("Registro n" + CHR(227) + "o encontrado!", "Visualizar")
2575:                 ENDIF
2576:             CATCH TO loException
2577:                 MostrarErro("Erro ao visualizar transporte:" + CHR(13) + loException.Message + CHR(13) + ;
2578:                     "Linha: " + TRANSFORM(loException.LineNo), ;
2579:                     "FormTme.BtnVisualizarClick")
2580:             ENDTRY
2581:         ENDIF
2582: 
2583:         RETURN loc_lResultado
2584:     ENDPROC
2585: 
2586:     *===========================================================================
2587:     * BtnAlterarClick - Abre o transporte selecionado para edicao
2588:     * PUBLIC: BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3)
2589:     *===========================================================================
2590:     PROCEDURE BtnAlterarClick()
2591:         LOCAL loc_cTipoEmps, loc_lResultado
2592:         loc_lResultado = .F.
2593: 
2594:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
2595:             MsgAviso("Nenhum registro selecionado.", "Alterar")
2596:         ELSE
2597:             SELECT cursor_4c_Dados
2598:             loc_cTipoEmps = ALLTRIM(cursor_4c_Dados.tipoemps)
2599: 
2600:             TRY
2601:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cTipoEmps)
2602:                     THIS.this_oBusinessObject.EditarRegistro()
2603:                     THIS.BOParaForm()
2604:                     THIS.this_cModoAtual = "ALTERAR"
2605:                     THIS.HabilitarCampos(.T.)
2606:                     THIS.AjustarBotoesPorModo()
2607:                     THIS.AlternarPagina(2)
2608:                     loc_lResultado = .T.
2609:                 ELSE
2610:                     MsgAviso("Registro n" + CHR(227) + "o encontrado!", "Alterar")
2611:                 ENDIF
2612:             CATCH TO loException
2613:                 MostrarErro("Erro ao alterar transporte:" + CHR(13) + loException.Message + CHR(13) + ;
2614:                     "Linha: " + TRANSFORM(loException.LineNo), ;
2615:                     "FormTme.BtnAlterarClick")
2616:             ENDTRY
2617:         ENDIF
2618: 
2619:         RETURN loc_lResultado
2620:     ENDPROC
2621: 
2622:     *===========================================================================
2623:     * BtnExcluirClick - Exclui o transporte selecionado apos confirmacao
2624:     * (TmeBO.ExecutarExclusao ja remove SigCdMei/SigCdMet antes de SigCdMe)
2625:     * PUBLIC: BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3)
2626:     *===========================================================================
2627:     PROCEDURE BtnExcluirClick()
2628:         LOCAL loc_cTipoEmps, loc_lResultado
2629:         loc_lResultado = .F.
2630: 
2631:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
2632:             MsgAviso("Nenhum registro selecionado.", "Excluir")
2633:         ELSE
2634:             SELECT cursor_4c_Dados
2635:             loc_cTipoEmps = ALLTRIM(cursor_4c_Dados.tipoemps)
2636: 
2637:             IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cTipoEmps)
2638:                 MsgAviso("Registro n" + CHR(227) + "o encontrado!", "Excluir")
2639:             ELSE
2640:                 IF MsgConfirmaExclusao()
2641:                     TRY
2642:                         IF THIS.this_oBusinessObject.Excluir()
2643:                             MsgExcluidoSucesso()
2644:                             THIS.CarregarLista()
2645:                             loc_lResultado = .T.
2646:                         ENDIF
2647:                     CATCH TO loException
2648:                         MostrarErro("Erro ao excluir transporte:" + CHR(13) + loException.Message + CHR(13) + ;
2649:                             "Linha: " + TRANSFORM(loException.LineNo), ;
2650:                             "FormTme.BtnExcluirClick")
2651:                     ENDTRY
2652:                 ENDIF
2653:             ENDIF
2654:         ENDIF
2655: 
2656:         RETURN loc_lResultado
2657:     ENDPROC
2658: 
2659:     *===========================================================================
2660:     * BtnBuscarClick - Localiza um transporte na lista via FormBuscaAuxiliar
2661:     * (SigCdMe, chave "tipos") e posiciona o grid no registro selecionado
2662:     * PUBLIC: BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3)
2663:     *===========================================================================
2664:     PROCEDURE BtnBuscarClick()
2665:         LOCAL loc_oBusca, loc_cTipoEmps
2666:         loc_cTipoEmps = ""
2667: 
2668:         TRY
2669:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2670:                 "SigCdMe", "cursor_4c_BuscaTme", "tipos", "", ;
2671:                 "Buscar Transporte")
2672: 
2673:             IF VARTYPE(loc_oBusca) = "O"
2674:                 loc_oBusca.mAddColuna("tipos",  "", "Transporte")
2675:                 loc_oBusca.mAddColuna("emps",   "", "Emp")
2676:                 loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
2677:                 loc_oBusca.Show()
2678: 
2679:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTme")
2680:                     SELECT cursor_4c_BuscaTme
2681:                     loc_cTipoEmps = ALLTRIM(cursor_4c_BuscaTme.tipoemps)
2682:                 ENDIF
2683: 
2684:                 loc_oBusca.Release()
2685:             ENDIF
2686: 
2687:             IF USED("cursor_4c_BuscaTme")
2688:                 USE IN cursor_4c_BuscaTme
2689:             ENDIF
2690: 
2691:             IF !EMPTY(loc_cTipoEmps) AND USED("cursor_4c_Dados")
2692:                 SELECT cursor_4c_Dados
2693:                 LOCATE FOR ALLTRIM(tipoemps) == loc_cTipoEmps
2694:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
2695:             ENDIF
2696: 
2697:         CATCH TO loException
2698:             MostrarErro("Erro na busca:" + CHR(13) + loException.Message, "FormTme.BtnBuscarClick")
2699:             IF USED("cursor_4c_BuscaTme")
2700:                 USE IN cursor_4c_BuscaTme
2701:             ENDIF
2702:         ENDTRY
2703:     ENDPROC
2704: 
2705:     *===========================================================================
2706:     * BtnEncerrarClick - Fecha o formulario
2707:     * PADRAO CANONICO CLAUDE.md #10: NAO chamar Release() apos - FormBase cuida
2708:     * PUBLIC: BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3)
2709:     *===========================================================================
2710:     PROCEDURE BtnEncerrarClick()
2711:         THIS.Release()
2712:     ENDPROC
2713: 
2714:     *===========================================================================
2715:     * FormParaBO - Transfere dados da Page2 para o BusinessObject antes de
2716:     * salvar. this_cTipoEmps (PK) eh calculado dentro de TmeBO.ValidarDados()
2717:     * a partir de this_cTipos + this_cEmps - nao precisa ser setado aqui.
2718:     *===========================================================================
2719:     PROTECTED PROCEDURE FormParaBO()
2720:         LOCAL loc_oPg2
2721:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2722: 
2723:         THIS.this_oBusinessObject.this_cTipos              = UPPER(ALLTRIM(loc_oPg2.txt_4c_Tipos.Value))
2724:         THIS.this_oBusinessObject.this_cEmps               = UPPER(ALLTRIM(loc_oPg2.txt_4c_Emps.Value))
2725:         THIS.this_oBusinessObject.this_cDescricao          = ALLTRIM(loc_oPg2.txt_4c_Descrs.Value)
2726:         THIS.this_oBusinessObject.this_cExtensao           = UPPER(ALLTRIM(loc_oPg2.txt_4c_Extensao.Value))
2727:         THIS.this_oBusinessObject.this_cTipoTransporte     = UPPER(ALLTRIM(loc_oPg2.txt_4c_TransTipo.Value))
2728:         THIS.this_oBusinessObject.this_cDirGeracao         = ALLTRIM(loc_oPg2.txt_4c_DirGeracao.Value)
2729:         THIS.this_oBusinessObject.this_nTransporteOk       = loc_oPg2.txt_4c_ClrArqOks.Value
2730:         THIS.this_oBusinessObject.this_cDirLeitura         = ALLTRIM(loc_oPg2.txt_4c_DirLeitura.Value)
2731:         THIS.this_oBusinessObject.this_lNaoChecarSequencia = loc_oPg2.chk_4c_Seqnum.Value
2732:         THIS.this_oBusinessObject.this_cDirRecepcao        = ALLTRIM(loc_oPg2.txt_4c_DirRecepcao.Value)
2733:         THIS.this_oBusinessObject.this_cDirArquivar        = ALLTRIM(loc_oPg2.txt_4c_DirArquivar.Value)
2734:         THIS.this_oBusinessObject.this_cTipoConexao        = UPPER(ALLTRIM(loc_oPg2.txt_4c_Tpconexao.Value))
2735:         THIS.this_oBusinessObject.this_lLimpaDirEnvio      = loc_oPg2.chk_4c_Chklocdel.Value
2736:         THIS.this_oBusinessObject.this_lLimpaDirFtp        = loc_oPg2.chk_4c_Chkftpdel.Value
2737:         THIS.this_oBusinessObject.this_cFtpEndereco        = ALLTRIM(loc_oPg2.txt_4c_Ftpend.Value)
2738:         THIS.this_oBusinessObject.this_cFtpUsuario         = ALLTRIM(loc_oPg2.txt_4c_Ftpusuario.Value)
2739:         THIS.this_oBusinessObject.this_cDirFtpEnvio        = ALLTRIM(loc_oPg2.txt_4c_Dirftpts.Value)
2740:         THIS.this_oBusinessObject.this_cFtpSenha           = ALLTRIM(loc_oPg2.txt_4c_Ftpsenha.Value)
2741:         THIS.this_oBusinessObject.this_cDirFtpRecepcao     = ALLTRIM(loc_oPg2.txt_4c_Dirftpls.Value)
2742:     ENDPROC
2743: 
2744:     *===========================================================================
2745:     * BtnSalvarClick - Salva o transporte (INCLUIR/ALTERAR) via TmeBO.Salvar()
2746:     * Validacoes de campo obrigatorio ficam em TmeBO.ValidarDados() (Codigo do
2747:     * Transporte / Empresa - espelha o Valid legado do CmdBotoes.Click).
2748:     * PUBLIC: BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3)
2749:     *===========================================================================
2750:     PROCEDURE BtnSalvarClick()
2751:         LOCAL loc_lResultado
2752:         loc_lResultado = .F.
2753: 
2754:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2755:             RETURN loc_lResultado
2756:         ENDIF
2757: 
2758:         TRY
2759:             THIS.FormParaBO()
2760: 
2761:             IF THIS.this_oBusinessObject.Salvar()
2762:                 MsgSucesso("Transporte salvo com sucesso!")
2763:                 THIS.AlternarPagina(1)
2764:                 loc_lResultado = .T.
2765:             ENDIF
2766:         CATCH TO loException
2767:             MostrarErro("Erro ao salvar transporte:" + CHR(13) + loException.Message + CHR(13) + ;
2768:                 "Linha: " + TRANSFORM(loException.LineNo), ;
2769:                 "FormTme.BtnSalvarClick")
2770:         ENDTRY
2771: 
2772:         RETURN loc_lResultado
2773:     ENDPROC
2774: 
2775:     *===========================================================================
2776:     * BtnCancelarClick - Cancela a edicao e volta para a lista (recarregada)
2777:     * PUBLIC: BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3)
2778:     *===========================================================================
2779:     PROCEDURE BtnCancelarClick()
2780:         THIS.AlternarPagina(1)
2781:         THIS.this_cModoAtual = "LISTA"
2782:         THIS.CarregarLista()
2783:     ENDPROC
2784: 
2785:     *===========================================================================
2786:     * Destroy - Libera recursos ao fechar o formulario
2787:     *===========================================================================
2788:     PROCEDURE Destroy()
2789:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2790:             THIS.this_oBusinessObject = .NULL.
2791:         ENDIF
2792: 
2793:         IF USED("cursor_4c_Dados")
2794:             USE IN cursor_4c_Dados
2795:         ENDIF
2796: 
2797:         IF USED("cursor_4c_Itens")
2798:             USE IN cursor_4c_Itens
2799:         ENDIF
2800: 
2801:         IF USED("cursor_4c_Titulos")
2802:             USE IN cursor_4c_Titulos
2803:         ENDIF
2804: 
2805:         IF USED("cursor_4c_Grade")
2806:             USE IN cursor_4c_Grade
2807:         ENDIF
2808: 
2809:         DODEFAULT()
2810:     ENDPROC
2811: 
2812: ENDDEFINE


### BO (C:\4c\projeto\app\classes\TmeBO.prg):
*====================================================================
* TmeBO.prg
*
* Business Object para Cadastro de Transporte de Movimentacao de
* Estoque (Configuracao de Transporte/FTP entre empresas)
* Tabela principal: SigCdMe (PK: tipoemps = Tipos + Emps)
* Tabelas de detalhe (grids da Page2.Configuracao):
*   - SigCdMeI (Page1 do PageFrame de Configuracao - Operacoes/Itens)
*   - SigCdMeT (Page2 do PageFrame de Configuracao - Titulos)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS TmeBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdMe)
    this_cTipoEmps            = ""    && tipoemps    char(9)  - PK (concatenacao Tipos+Emps)
    this_cTipos               = ""    && tipos       char(6)  - codigo do Processo/Transporte
    this_cEmps                = ""    && emps        char(3)  - codigo da Empresa
    this_cDescricao           = ""    && descrs      char(20) - descricao do transporte
    this_cExtensao            = ""    && extensao    char(3)  - tipo de extensao do arquivo
    this_cDirGeracao          = ""    && drivets     char(60) - diretorio de geracao/gravacao do transporte
    this_cDirLeitura          = ""    && drivels     char(60) - diretorio de leitura do zip
    this_cDirRecepcao         = ""    && drivers     char(60) - diretorio de recepcao do transporte
    this_cDirArquivar         = ""    && paths       char(60) - diretorio para arquivar o arquivo recebido
    this_cTipoConexao         = ""    && tpconexao   char(1)  - D=Dial-Up / B=Banda Larga
    this_cFtpEndereco         = ""    && ftpend      char(50) - endereco do FTP
    this_cFtpUsuario          = ""    && ftpusuario  char(50) - usuario do FTP
    this_cFtpSenha            = ""    && ftpsenha    char(20) - senha do FTP (criptografada)
    this_cDirFtpEnvio         = ""    && dirftpts    char(60) - pasta para envio (FTP)
    this_cDirFtpRecepcao      = ""    && dirftpls    char(60) - pasta para recepcao (FTP)
    this_lNaoChecarSequencia  = .F.   && nchkseqs    bit      - nao checar sequencia
    this_nTransporteOk        = 0     && clrarqs     numeric(3,0) - numero do transporte OK / limpar arqs OK
    this_cTipoTransporte      = ""    && transtipo   char(6)  - tipo transporte (lookup SigPrTrn.Codigos)
    this_lLimpaDirEnvio       = .F.   && locdel      bit      - limpa diretorio de envio
    this_lLimpaDirFtp         = .F.   && ftpdel      bit      - limpa diretorio do FTP
    this_cEmpDs               = ""    && empds       char(3)  - empresa de destino

    *-- Cursores dos grids de detalhe (Page2.Configuracao.Page1/Page2)
    this_cCursorItens         = "cursor_4c_Itens"     && grid de Operacoes/Itens (tabela SigCdMeI)
    this_cCursorTitulos       = "cursor_4c_Titulos"   && grid de Titulos (tabela SigCdMeT)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdMe"
            THIS.this_cCampoChave = "tipoemps"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "TmeBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cTipoEmps)
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
                THIS.this_cTipoEmps           = TratarNulo(tipoemps,   "C")
                THIS.this_cTipos              = TratarNulo(tipos,      "C")
                THIS.this_cEmps               = TratarNulo(emps,       "C")
                THIS.this_cDescricao          = TratarNulo(descrs,     "C")
                THIS.this_cExtensao           = TratarNulo(extensao,   "C")
                THIS.this_cDirGeracao         = TratarNulo(drivets,    "C")
                THIS.this_cDirLeitura         = TratarNulo(drivels,    "C")
                THIS.this_cDirRecepcao        = TratarNulo(drivers,    "C")
                THIS.this_cDirArquivar        = TratarNulo(paths,      "C")
                THIS.this_cTipoConexao        = TratarNulo(tpconexao,  "C")
                THIS.this_cFtpEndereco        = TratarNulo(ftpend,     "C")
                THIS.this_cFtpUsuario         = TratarNulo(ftpusuario, "C")
                THIS.this_cFtpSenha           = TratarNulo(ftpsenha,   "C")
                THIS.this_cDirFtpEnvio        = TratarNulo(dirftpts,   "C")
                THIS.this_cDirFtpRecepcao     = TratarNulo(dirftpls,   "C")
                THIS.this_lNaoChecarSequencia = ConverterParaLogico(nchkseqs)
                THIS.this_nTransporteOk       = TratarNulo(clrarqs,    "N")
                THIS.this_cTipoTransporte     = TratarNulo(transtipo,  "C")
                THIS.this_lLimpaDirEnvio      = ConverterParaLogico(locdel)
                THIS.this_lLimpaDirFtp        = ConverterParaLogico(ftpdel)
                THIS.this_cEmpDs              = TratarNulo(empds,      "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "TmeBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cTipos)
            MsgAviso("C" + CHR(243) + "digo do Transporte Tem Que Ser Preenchido!!!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cEmps)
            MsgAviso("C" + CHR(243) + "digo da Empresa Tem Que Ser Preenchido!!!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido
            THIS.this_cTipoEmps = PADR(THIS.this_cTipos, 6) + PADR(THIS.this_cEmps, 3)
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarChaveExistente(THIS.this_cTipoEmps)
                MsgAviso("Transporte j" + CHR(225) + " Cadastrado!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * VerificarChaveExistente - Verifica se tipoemps ja existe no banco
    *====================================================================
    PROCEDURE VerificarChaveExistente(par_cChave)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdMe" + ;
                " WHERE tipoemps = " + EscaparSQL(par_cChave)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkChave")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkChave")
                SELECT cursor_4c_ChkChave
                loc_lExiste = (cursor_4c_ChkChave.qtd > 0)
                USE IN cursor_4c_ChkChave
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar transporte:" + CHR(13) + loException.Message, "TmeBO.VerificarChaveExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigCdMe
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdMe (tipoemps, tipos, emps, descrs, extensao,
                    drivets, drivels, drivers, paths, tpconexao,
                    ftpend, ftpusuario, ftpsenha, dirftpts, dirftpls,
                    nchkseqs, clrarqs, transtipo, locdel, ftpdel, empds)
                VALUES (
                    <<EscaparSQL(THIS.this_cTipoEmps)>>,
                    <<EscaparSQL(THIS.this_cTipos)>>,
                    <<EscaparSQL(THIS.this_cEmps)>>,
                    <<EscaparSQL(THIS.this_cDescricao)>>,
                    <<EscaparSQL(THIS.this_cExtensao)>>,
                    <<EscaparSQL(THIS.this_cDirGeracao)>>,
                    <<EscaparSQL(THIS.this_cDirLeitura)>>,
                    <<EscaparSQL(THIS.this_cDirRecepcao)>>,
                    <<EscaparSQL(THIS.this_cDirArquivar)>>,
                    <<EscaparSQL(THIS.this_cTipoConexao)>>,
                    <<EscaparSQL(THIS.this_cFtpEndereco)>>,
                    <<EscaparSQL(THIS.this_cFtpUsuario)>>,
                    <<EscaparSQL(THIS.this_cFtpSenha)>>,
                    <<EscaparSQL(THIS.this_cDirFtpEnvio)>>,
                    <<EscaparSQL(THIS.this_cDirFtpRecepcao)>>,
                    <<FormatarNumeroSQL(IIF(THIS.this_lNaoChecarSequencia, 1, 0), 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nTransporteOk, 0)>>,
                    <<EscaparSQL(THIS.this_cTipoTransporte)>>,
                    <<FormatarNumeroSQL(IIF(THIS.this_lLimpaDirEnvio, 1, 0), 0)>>,
                    <<FormatarNumeroSQL(IIF(THIS.this_lLimpaDirFtp, 1, 0), 0)>>,
                    <<EscaparSQL(THIS.this_cEmpDs)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "TmeBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdMe
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdMe
                SET descrs     = <<EscaparSQL(THIS.this_cDescricao)>>,
                    extensao   = <<EscaparSQL(THIS.this_cExtensao)>>,
                    drivets    = <<EscaparSQL(THIS.this_cDirGeracao)>>,
                    drivels    = <<EscaparSQL(THIS.this_cDirLeitura)>>,
                    drivers    = <<EscaparSQL(THIS.this_cDirRecepcao)>>,
                    paths      = <<EscaparSQL(THIS.this_cDirArquivar)>>,
                    tpconexao  = <<EscaparSQL(THIS.this_cTipoConexao)>>,
                    ftpend     = <<EscaparSQL(THIS.this_cFtpEndereco)>>,
                    ftpusuario = <<EscaparSQL(THIS.this_cFtpUsuario)>>,
                    ftpsenha   = <<EscaparSQL(THIS.this_cFtpSenha)>>,
                    dirftpts   = <<EscaparSQL(THIS.this_cDirFtpEnvio)>>,
                    dirftpls   = <<EscaparSQL(THIS.this_cDirFtpRecepcao)>>,
                    nchkseqs   = <<FormatarNumeroSQL(IIF(THIS.this_lNaoChecarSequencia, 1, 0), 0)>>,
                    clrarqs    = <<FormatarNumeroSQL(THIS.this_nTransporteOk, 0)>>,
                    transtipo  = <<EscaparSQL(THIS.this_cTipoTransporte)>>,
                    locdel     = <<FormatarNumeroSQL(IIF(THIS.this_lLimpaDirEnvio, 1, 0), 0)>>,
                    ftpdel     = <<FormatarNumeroSQL(IIF(THIS.this_lLimpaDirFtp, 1, 0), 0)>>,
                    empds      = <<EscaparSQL(THIS.this_cEmpDs)>>
                WHERE tipoemps = <<EscaparSQL(THIS.this_cTipoEmps)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "TmeBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdMe e seus detalhes
    * (SigCdMeI = Operacoes/Itens, SigCdMeT = Titulos)
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdMei WHERE tipoemps = " + EscaparSQL(THIS.this_cTipoEmps)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                MostrarErro("Erro ao excluir itens do transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ELSE
                loc_cSQL = "DELETE FROM SigCdMet WHERE tipoemps = " + EscaparSQL(THIS.this_cTipoEmps)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado < 0
                    MostrarErro("Erro ao excluir t" + CHR(237) + "tulos do transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    loc_lSucesso = .F.
                ELSE
                    loc_cSQL = "DELETE FROM SigCdMe WHERE tipoemps = " + EscaparSQL(THIS.this_cTipoEmps)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResultado >= 0
                        THIS.RegistrarAuditoria("DELETE")
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao excluir transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        loc_lSucesso = .F.
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "TmeBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com tipoemps, tipos, emps, descrs
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (tipoemps C(9), tipos C(6), emps C(3), descrs C(20))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT tipoemps, tipos, emps, descrs FROM SigCdMe"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY tipos, emps"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar transportes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "TmeBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (tipoemps)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cChave)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT tipoemps, tipos, emps, descrs, extensao,
                    drivets, drivels, drivers, paths, tpconexao,
                    ftpend, ftpusuario, ftpsenha, dirftpts, dirftpls,
                    nchkseqs, clrarqs, transtipo, locdel, ftpdel, empds
                FROM SigCdMe
                WHERE tipoemps = <<EscaparSQL(par_cChave)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Transporte n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "TmeBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * BuscarItens - Carrega grid de Operacoes/Itens (SigCdMeI) do transporte
    * Legado: csGrade (TipoEmps, Emps, Dopes, cIdChaves, ChkPagos, ChkSubns,
    *         EmpDs, DopeDs, ContaEs, Apagas, nDias, Numeras, DtTrans)
    *====================================================================
    PROCEDURE BuscarItens(par_cTipoEmps)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorItens)
                USE IN (THIS.this_cCursorItens)
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT tipoemps, emps, dopes, cidchaves, chkpagos, chksubns,
                    empds, dopeds, contaes, apagas, ndias, numeras, dttrans
                FROM SigCdMei
                WHERE tipoemps = <<EscaparSQL(par_cTipoEmps)>>
                ORDER BY dopes
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, (THIS.this_cCursorItens))

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar itens do transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar itens:" + CHR(13) + loException.Message, "TmeBO.BuscarItens")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * BuscarTitulos - Carrega grid de Titulos (SigCdMeT) do transporte
    * Legado: CsTitulo (TipoEmps, Emps, Dopes, cIdChaves, cNotas)
    *====================================================================
    PROCEDURE BuscarTitulos(par_cTipoEmps)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorTitulos)
                USE IN (THIS.this_cCursorTitulos)
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT tipoemps, emps, dopes, cidchaves, cnotas, empds
                FROM SigCdMet
                WHERE tipoemps = <<EscaparSQL(par_cTipoEmps)>>
                ORDER BY dopes
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, (THIS.this_cCursorTitulos))

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar t" + CHR(237) + "tulos do transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar t" + CHR(237) + "tulos:" + CHR(13) + loException.Message, "TmeBO.BuscarTitulos")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * BuscarOperacoesDisponiveis - Lista de operacoes para o lookup da
    * coluna "Operacao" do grid de Titulos (Pagina Titulos/Pag/Rec/Lote
    * Chq). Legado: CrSigOpOpe (Init) = SELECT Dopes FROM SigOpOpe + 3
    * operacoes especiais fixas que nao existem na tabela (PAGAMENTO,
    * RECEBIMENTO, LOTE DE CHEQUE) - tratadas apenas nesta pagina.
    * Retorna cursor_4c_Operacoes (dopes), indexado por dopes.
    *====================================================================
    PROCEDURE BuscarOperacoesDisponiveis()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Operacoes")
                USE IN cursor_4c_Operacoes
            ENDIF

            loc_cSQL = "SELECT dopes FROM SigOpOpe"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacoes")

            IF loc_nResultado >= 0
                SELECT cursor_4c_Operacoes
                INSERT INTO cursor_4c_Operacoes (dopes) VALUES ("PAGAMENTO")
                INSERT INTO cursor_4c_Operacoes (dopes) VALUES ("RECEBIMENTO")
                INSERT INTO cursor_4c_Operacoes (dopes) VALUES ("LOTE DE CHEQUE")
                SELECT cursor_4c_Operacoes
                INDEX ON dopes TAG dopes
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es dispon" + CHR(237) + "veis:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + loException.Message, "TmeBO.BuscarOperacoesDisponiveis")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

