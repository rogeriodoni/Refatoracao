# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (10)
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [CARGA-DADOS] OptionGroup 'opt_4c_Situacao' NAO tem BINDEVENT para InteractiveChange. Se este OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter InteractiveChange que recarrega a grade.
- [METODO-INEXISTENTE] Metodo 'THIS.ValidarCampos()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-HEADER] Header Caption 'Sub-grupo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Produto, Descrição, Grupo, Subgrp., Ref. Fornecedor, Usuário, I, Empresa, Quantidade, Material, Un, Valor, Qtde., Total, Moe, Observação, E, Consumo, Ord, Moeda, Tam, Grp, Período, Valor Custo GR, Ordem, Fase, Utilização, Uni. Produtiva, Matriz, Local, Qtde, Componente, Uni, Ord., Cat., Agrupamento, Tempo %, Item, Qtd, Etiq, Arquivos Para Designer, Data de Início, Data de Conclusão, Tarefa, Serviços, Código, . Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Grp. Venda' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Produto, Descrição, Grupo, Subgrp., Ref. Fornecedor, Usuário, I, Empresa, Quantidade, Material, Un, Valor, Qtde., Total, Moe, Observação, E, Consumo, Ord, Moeda, Tam, Grp, Período, Valor Custo GR, Ordem, Fase, Utilização, Uni. Produtiva, Matriz, Local, Qtde, Componente, Uni, Ord., Cat., Agrupamento, Tempo %, Item, Qtd, Etiq, Arquivos Para Designer, Data de Início, Data de Conclusão, Tarefa, Serviços, Código, . Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Sit.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Produto, Descrição, Grupo, Subgrp., Ref. Fornecedor, Usuário, I, Empresa, Quantidade, Material, Un, Valor, Qtde., Total, Moe, Observação, E, Consumo, Ord, Moeda, Tam, Grp, Período, Valor Custo GR, Ordem, Fase, Utilização, Uni. Produtiva, Matriz, Local, Qtde, Componente, Uni, Ord., Cat., Agrupamento, Tempo %, Item, Qtd, Etiq, Arquivos Para Designer, Data de Início, Data de Conclusão, Tarefa, Serviços, Código, . Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'Botoes' (parent: SIGCDPRO.Pagina.Lista): Top original=85 vs migrado 'cnt_4c_BotoesAcao' Top=33 (diff=52px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Botoes' (parent: SIGCDPRO.Pagina.Lista): Left original=9 vs migrado 'cnt_4c_BotoesAcao' Left=842 (diff=833px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2445 linhas total):

*-- Linhas 30 a 159:
30:     *===========================================================================
31:     * Init - Inicializa o formulario
32:     * REGRA CRITICA: Apenas RETURN DODEFAULT()
33:     * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
34:     *===========================================================================
35:     PROCEDURE Init()
36:         RETURN DODEFAULT()
37:     ENDPROC
38: 
39:     *===========================================================================
40:     * InicializarForm - Configura estrutura completa
41:     * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
42:     *===========================================================================
43:     PROTECTED PROCEDURE InicializarForm()
44:         LOCAL loc_lSucesso, loException
45:         loc_lSucesso = .F.
46: 
47:         TRY
48:             THIS.this_oBusinessObject = CREATEOBJECT("ProdutoBO")
49: 
50:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
51:                 MostrarErro("Erro ao criar ProdutoBO" + CHR(13) + ;
52:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
53:                     "FormProduto.InicializarForm")
54:             ELSE
55:                 THIS.ConfigurarPageFrame()
56: 
57:                 *-- Propagar Caption para labels do cabecalho (Problema 44)
58:                 IF TYPE("THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra") = "O"
59:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
60:                 ENDIF
61:                 IF TYPE("THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo") = "O"
62:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
63:                 ENDIF
64: 
65:                 THIS.pgf_4c_Paginas.Visible = .T.
66:                 THIS.pgf_4c_Paginas.ActivePage = 1
67:                 THIS.this_cModoAtual = "LISTA"
68: 
69:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
70:                     THIS.CarregarLista()
71:                 ENDIF
72: 
73:                 loc_lSucesso = .T.
74:             ENDIF
75: 
76:         CATCH TO loException
77:             MostrarErro("Erro ao inicializar FormProduto:" + CHR(13) + ;
78:                 loException.Message + CHR(13) + ;
79:                 "Linha: " + TRANSFORM(loException.LineNo), ;
80:                 "FormProduto.InicializarForm")
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
116:     * ConfigurarPaginaLista - Configura Page1 completa: cabecalho + botoes + grid
117:     * FASE 4: Grid e botoes CRUD adicionados ao esqueleto da Fase 3
118:     *===========================================================================
119:     PROTECTED PROCEDURE ConfigurarPaginaLista()
120:         LOCAL loc_oPagina
121:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
122: 
123:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
124: 
125:         *-- Container Cabecalho (cntSombra no legado)
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

*-- Linhas 203 a 548:
203:             .AutoSize        = .F.
204:             .Visible         = .T.
205:         ENDWITH
206:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
207: 
208:         *-- Botao Visualizar (Consultar no legado)
209:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
210:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
211:             .Caption         = "Visualizar"
212:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
213:             .PicturePosition = 13
214:             .Top             = 5
215:             .Left            = 80
216:             .Width           = 75
217:             .Height          = 75
218:             .FontName        = "Tahoma"
219:             .FontBold        = .T.
220:             .FontItalic      = .T.
221:             .FontSize        = 8
222:             .ForeColor       = RGB(90, 90, 90)
223:             .BackColor       = RGB(255, 255, 255)
224:             .Themes          = .F.
225:             .SpecialEffect   = 0
226:             .MousePointer    = 15
227:             .WordWrap        = .T.
228:             .AutoSize        = .F.
229:             .Visible         = .T.
230:         ENDWITH
231:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
232: 
233:         *-- Botao Alterar
234:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
235:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
236:             .Caption         = "Alterar"
237:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
238:             .PicturePosition = 13
239:             .Top             = 5
240:             .Left            = 155
241:             .Width           = 75
242:             .Height          = 75
243:             .FontName        = "Tahoma"
244:             .FontBold        = .T.
245:             .FontItalic      = .T.
246:             .FontSize        = 8
247:             .ForeColor       = RGB(90, 90, 90)
248:             .BackColor       = RGB(255, 255, 255)
249:             .Themes          = .F.
250:             .SpecialEffect   = 0
251:             .MousePointer    = 15
252:             .WordWrap        = .T.
253:             .AutoSize        = .F.
254:             .Visible         = .T.
255:         ENDWITH
256:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
257: 
258:         *-- Botao Excluir
259:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
260:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
261:             .Caption         = "Excluir"
262:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
263:             .PicturePosition = 13
264:             .Top             = 5
265:             .Left            = 230
266:             .Width           = 75
267:             .Height          = 75
268:             .FontName        = "Tahoma"
269:             .FontBold        = .T.
270:             .FontItalic      = .T.
271:             .FontSize        = 8
272:             .ForeColor       = RGB(90, 90, 90)
273:             .BackColor       = RGB(255, 255, 255)
274:             .Themes          = .F.
275:             .SpecialEffect   = 0
276:             .MousePointer    = 15
277:             .WordWrap        = .T.
278:             .AutoSize        = .F.
279:             .Visible         = .T.
280:         ENDWITH
281:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
282: 
283:         *-- Botao Buscar (Procurar no legado)
284:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
285:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
286:             .Caption         = "Buscar"
287:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
288:             .PicturePosition = 13
289:             .Top             = 5
290:             .Left            = 305
291:             .Width           = 75
292:             .Height          = 75
293:             .FontName        = "Tahoma"
294:             .FontBold        = .T.
295:             .FontItalic      = .T.
296:             .FontSize        = 8
297:             .ForeColor       = RGB(90, 90, 90)
298:             .BackColor       = RGB(255, 255, 255)
299:             .Themes          = .F.
300:             .SpecialEffect   = 0
301:             .MousePointer    = 15
302:             .WordWrap        = .T.
303:             .AutoSize        = .F.
304:             .Visible         = .T.
305:         ENDWITH
306:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
307: 
308:         *-- Container Saida - PADRAO CANONICO (CLAUDE.md regra #10)
309:         *-- Legado: Grupo_Saida.Left=927, Top=-1. Canonico: Left=917, Top=29, Width=90
310:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
311:         WITH loc_oPagina.cnt_4c_Saida
312:             .Top         = 29
313:             .Left        = 917
314:             .Width       = 90
315:             .Height      = 85
316:             .BackStyle   = 0
317:             .BorderWidth = 0
318:             .Visible     = .T.
319:         ENDWITH
320: 
321:         *-- Botao Encerrar - PADRAO CANONICO
322:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
323:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
324:             .Caption         = "Encerrar"
325:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
326:             .PicturePosition = 13
327:             .Top             = 5
328:             .Left            = 5
329:             .Width           = 75
330:             .Height          = 75
331:             .FontName        = "Tahoma"
332:             .FontBold        = .T.
333:             .FontItalic      = .T.
334:             .FontSize        = 8
335:             .ForeColor       = RGB(90, 90, 90)
336:             .BackColor       = RGB(255, 255, 255)
337:             .Themes          = .F.
338:             .SpecialEffect   = 0
339:             .MousePointer    = 15
340:             .WordWrap        = .T.
341:             .AutoSize        = .F.
342:             .Visible         = .T.
343:         ENDWITH
344:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
345: 
346:         *-- Grid de listagem de produtos
347:         *-- Original: Grade.Top=173, Left=11, Width=972, Height=422, ColumnCount=7
348:         *-- Top nao precisa de compensacao pois grade esta dentro da page (coordenadas relativas)
349:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
350:         *-- ColumnCount FORA do WITH (auto-bind VFP9)
351:         loc_oPagina.grd_4c_Lista.ColumnCount = 7
352:         WITH loc_oPagina.grd_4c_Lista
353:             .Top                = 117
354:             .Left               = 11
355:             .Width              = 972
356:             .Height             = 422
357:             .FontName           = "Tahoma"
358:             .FontSize           = 8
359:             .ForeColor          = RGB(90, 90, 90)
360:             .BackColor          = RGB(255, 255, 255)
361:             .GridLineColor      = RGB(238, 238, 238)
362:             .HighlightBackColor = RGB(255, 255, 255)
363:             .HighlightForeColor = RGB(15, 41, 104)
364:             .HighlightStyle     = 2
365:             .DeleteMark         = .F.
366:             .RecordMark         = .F.
367:             .RowHeight          = 18
368:             .ScrollBars         = 3
369:             .GridLines          = 3
370:             .AllowHeaderSizing  = .F.
371:             .AllowRowSizing     = .F.
372:             .Visible            = .T.
373:         ENDWITH
374:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")
375: 
376:         THIS.TornarControlesVisiveis(loc_oPagina)
377:     ENDPROC
378: 
379:     *===========================================================================
380:     * ConfigurarPaginaDados - Configura Page2: BotoesAcao + pgf_4c_Dados (8 abas)
381:     * FASE 5: Implementacao completa com todos os campos de SigCdPro
382:     *===========================================================================
383:     PROTECTED PROCEDURE ConfigurarPaginaDados()
384:         LOCAL loc_oPagina
385:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
386: 
387:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
388: 
389:         *-- Container BotoesAcao (canonico: Left=842, Top=33, Width=160, Height=85)
390:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
391:         WITH loc_oPagina.cnt_4c_BotoesAcao
392:             .Top         = 33
393:             .Left        = 842
394:             .Width       = 160
395:             .Height      = 85
396:             .BackStyle = 1
397:             .BackColor = RGB(255, 255, 255)
398:             .BorderWidth = 0
399:             .Visible     = .T.
400:         ENDWITH
401: 
402:         *-- Botao Salvar
403:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Salvar", "CommandButton")
404:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar
405:             .Caption         = "Salvar"
406:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
407:             .PicturePosition = 13
408:             .Top             = 5
409:             .Left            = 5
410:             .Width           = 70
411:             .Height          = 75
412:             .FontName        = "Tahoma"
413:             .FontBold        = .T.
414:             .FontItalic      = .T.
415:             .FontSize        = 8
416:             .ForeColor       = RGB(90, 90, 90)
417:             .BackColor       = RGB(255, 255, 255)
418:             .Themes          = .F.
419:             .SpecialEffect   = 0
420:             .MousePointer    = 15
421:             .WordWrap        = .T.
422:             .AutoSize        = .F.
423:             .Visible         = .T.
424:         ENDWITH
425:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")
426: 
427:         *-- Botao Cancelar
428:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
429:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
430:             .Caption         = "Encerrar"
431:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
432:             .PicturePosition = 13
433:             .Top             = 5
434:             .Left            = 80
435:             .Width           = 75
436:             .Height          = 75
437:             .FontName        = "Tahoma"
438:             .FontBold        = .T.
439:             .FontItalic      = .T.
440:             .FontSize        = 8
441:             .ForeColor       = RGB(90, 90, 90)
442:             .BackColor       = RGB(255, 255, 255)
443:             .Themes          = .F.
444:             .SpecialEffect   = 0
445:             .MousePointer    = 15
446:             .WordWrap        = .T.
447:             .AutoSize        = .F.
448:             .Visible         = .T.
449:         ENDWITH
450:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
451: 
452:         *-- pgf_4c_Dados: PageFrame interno com 8 abas (original: pgframeDados)
453:         *-- Original: Top=-58(abas ocultas), Width=1009, Height=656
454:         *-- Novo: abas visiveis abaixo dos BotoesAcao
455:         loc_oPagina.AddObject("pgf_4c_Dados", "PageFrame")
456:         loc_oPagina.pgf_4c_Dados.PageCount = 8
457:         WITH loc_oPagina.pgf_4c_Dados
458:             .Top     = 120
459:             .Left    = 0
460:             .Width   = THIS.Width
461:             .Height  = 500
462:             .Tabs    = .T.
463:             .Visible = .T.
464: 
465:             .Page1.Caption = "Dados Principais"
466:             .Page2.Caption = "Custos"
467:             .Page3.Caption = "Dados Fiscais"
468:             .Page4.Caption = "Processos"
469:             .Page5.Caption = "Consumo"
470:             .Page6.Caption = "Composi" + CHR(231) + CHR(227) + "o"
471:             .Page7.Caption = "Designer"
472:             .Page8.Caption = "Servi" + CHR(231) + "os"
473:         ENDWITH
474: 
475:         *-- Tab 1: Dados Principais (campos principais de SigCdPro)
476:         THIS.ConfigurarPgDados(loc_oPagina.pgf_4c_Dados.Page1)
477: 
478:         *-- Tabs 2-8: label descritivo de cada aba
479:         THIS.ConfigurarPgDadosInfo(loc_oPagina.pgf_4c_Dados.Page2, ;
480:             "Custos / Composi" + CHR(231) + CHR(227) + "o de Pre" + CHR(231) + "os")
481:         THIS.ConfigurarPgDadosInfo(loc_oPagina.pgf_4c_Dados.Page3, ;
482:             "Dados Fiscais (NCM, ICMS, IPI, CFOP)")
483:         THIS.ConfigurarPgDadosInfo(loc_oPagina.pgf_4c_Dados.Page4, ;
484:             "Processos de Produ" + CHR(231) + CHR(227) + "o")
485:         THIS.ConfigurarPgDadosInfo(loc_oPagina.pgf_4c_Dados.Page5, ;
486:             "Consumo por Processo")
487:         THIS.ConfigurarPgDadosInfo(loc_oPagina.pgf_4c_Dados.Page6, ;
488:             "Composi" + CHR(231) + CHR(227) + "o (Subprodutos)")
489:         THIS.ConfigurarPgDadosInfo(loc_oPagina.pgf_4c_Dados.Page7, ;
490:             "Informa" + CHR(231) + CHR(245) + "es de Design")
491:         THIS.ConfigurarPgDadosInfo(loc_oPagina.pgf_4c_Dados.Page8, ;
492:             "Servi" + CHR(231) + "os Associados")
493: 
494:         THIS.TornarControlesVisiveis(loc_oPagina)
495:     ENDPROC
496: 
497:     *===========================================================================
498:     * ConfigurarPgDados - Configura Tab1 "Dados Principais" do pgf_4c_Dados
499:     * Controles mapeados de SIGCDPRO.Pagina.Dados.pgframeDados.pgDados
500:     * Coordenadas originais preservadas (relativas ao page content)
501:     *===========================================================================
502:     PROTECTED PROCEDURE ConfigurarPgDados(par_oPg)
503:         LOCAL loc_oPg
504:         loc_oPg = par_oPg
505:         loc_oPg.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
506: 
507:         *-- Situacao (opc_situacao: Top=114, Left=758, situas=numeric)
508:         loc_oPg.AddObject("opt_4c_Situacao", "OptionGroup")
509:         WITH loc_oPg.opt_4c_Situacao
510:             .ButtonCount = 2
511:             .Value       = 1
512:             .Top         = 114
513:             .Left        = 758
514:             .Width       = 156
515:             .Height      = 25
516:             .BackStyle   = 0
517:             .BorderStyle = 0
518:             .Visible     = .T.
519:             .Option1.Caption   = "Ativo"
520:             .Option1.FontName  = "Tahoma"
521:             .Option1.FontSize  = 8
522:             .Option1.BackStyle = 0
523:             .Option1.ForeColor = RGB(90, 90, 90)
524:             .Option1.Top       = 5
525:             .Option1.Left      = 5
526:             .Option1.Height    = 15
527:             .Option1.AutoSize  = .T.
528:             .Option2.Caption   = "Inativo"
529:             .Option2.FontName  = "Tahoma"
530:             .Option2.FontSize  = 8
531:             .Option2.BackStyle = 0
532:             .Option2.ForeColor = RGB(90, 90, 90)
533:             .Option2.Top       = 5
534:             .Option2.Left      = 80
535:             .Option2.Height    = 15
536:             .Option2.AutoSize  = .T.
537:         ENDWITH
538: 
539:         *-- Data da Situacao (getDtSituas: Top=115, Left=918, readonly)
540:         loc_oPg.AddObject("txt_4c_DtSituas", "TextBox")
541:         WITH loc_oPg.txt_4c_DtSituas
542:             .Top           = 115
543:             .Left          = 918
544:             .Width         = 80
545:             .Height        = 23
546:             .FontName      = "Tahoma"
547:             .FontSize      = 8
548:             .SpecialEffect = 1

*-- Linhas 657 a 793:
657:             .MaxLength     = 3
658:             .Visible       = .T.
659:         ENDWITH
660:         BINDEVENT(loc_oPg.txt_4c_Cgrus, "KeyDown", THIS, "TxtCgrusKeyDown")
661:         BINDEVENT(loc_oPg.txt_4c_Cgrus, "KeyPress", THIS, "ValidarCgrus")
662: 
663:         *-- Descricao do Grupo (getDgru: Top=186, Left=134, Width=171, readonly)
664:         loc_oPg.AddObject("txt_4c_Dgrus", "TextBox")
665:         WITH loc_oPg.txt_4c_Dgrus
666:             .Top           = 186
667:             .Left          = 134
668:             .Width         = 171
669:             .Height        = 22
670:             .FontName      = "Tahoma"
671:             .FontSize      = 8
672:             .SpecialEffect = 1
673:             .ReadOnly      = .T.
674:             .BackColor     = RGB(240, 240, 240)
675:             .Visible       = .T.
676:         ENDWITH
677: 
678:         *-- Label "Subgrupo:"
679:         loc_oPg.AddObject("lbl_4c_LbSGrus", "Label")
680:         WITH loc_oPg.lbl_4c_LbSGrus
681:             .Caption   = "Subgrupo :"
682:             .Top       = 213
683:             .Left      = 45
684:             .Width     = 55
685:             .Height    = 15
686:             .FontName  = "Tahoma"
687:             .FontSize  = 8
688:             .ForeColor = RGB(90, 90, 90)
689:             .BackStyle = 0
690:             .AutoSize  = .T.
691:             .Visible   = .T.
692:         ENDWITH
693: 
694:         *-- Codigo do Sub-grupo (GetCSGru: Top=209, Left=102, Width=52, MaxLength=6)
695:         loc_oPg.AddObject("txt_4c_SGrus", "TextBox")
696:         WITH loc_oPg.txt_4c_SGrus
697:             .Top           = 209
698:             .Left          = 102
699:             .Width         = 52
700:             .Height        = 22
701:             .FontName      = "Tahoma"
702:             .FontSize      = 8
703:             .SpecialEffect = 1
704:             .MaxLength     = 6
705:             .Visible       = .T.
706:         ENDWITH
707:         BINDEVENT(loc_oPg.txt_4c_SGrus, "KeyPress", THIS, "ValidarSGrus")
708: 
709:         *-- Descricao do Sub-grupo (GetDsGru: Top=209, Left=155, Width=150, readonly)
710:         loc_oPg.AddObject("txt_4c_DsGrus", "TextBox")
711:         WITH loc_oPg.txt_4c_DsGrus
712:             .Top           = 209
713:             .Left          = 155
714:             .Width         = 150
715:             .Height        = 22
716:             .FontName      = "Tahoma"
717:             .FontSize      = 8
718:             .SpecialEffect = 1
719:             .ReadOnly      = .T.
720:             .BackColor     = RGB(240, 240, 240)
721:             .Visible       = .T.
722:         ENDWITH
723: 
724:         *-- Label "Linha:"
725:         loc_oPg.AddObject("lbl_4c_LbLinhas", "Label")
726:         WITH loc_oPg.lbl_4c_LbLinhas
727:             .Caption   = "Linha :"
728:             .Top       = 236
729:             .Left      = 66
730:             .Width     = 34
731:             .Height    = 15
732:             .FontName  = "Tahoma"
733:             .FontSize  = 8
734:             .ForeColor = RGB(90, 90, 90)
735:             .BackStyle = 0
736:             .AutoSize  = .T.
737:             .Visible   = .T.
738:         ENDWITH
739: 
740:         *-- Codigo da Linha (GetLin: Top=232, Left=102, Width=80)
741:         loc_oPg.AddObject("txt_4c_Linhas", "TextBox")
742:         WITH loc_oPg.txt_4c_Linhas
743:             .Top           = 232
744:             .Left          = 102
745:             .Width         = 80
746:             .Height        = 22
747:             .FontName      = "Tahoma"
748:             .FontSize      = 8
749:             .SpecialEffect = 1
750:             .MaxLength     = 10
751:             .Visible       = .T.
752:         ENDWITH
753:         BINDEVENT(loc_oPg.txt_4c_Linhas, "KeyPress", THIS, "ValidarLinhas")
754: 
755:         *-- Descricao da Linha (GetDLin: Top=232, Left=183, Width=196, readonly)
756:         loc_oPg.AddObject("txt_4c_DLinhas", "TextBox")
757:         WITH loc_oPg.txt_4c_DLinhas
758:             .Top           = 232
759:             .Left          = 183
760:             .Width         = 196
761:             .Height        = 22
762:             .FontName      = "Tahoma"
763:             .FontSize      = 8
764:             .SpecialEffect = 1
765:             .ReadOnly      = .T.
766:             .BackColor     = RGB(240, 240, 240)
767:             .Visible       = .T.
768:         ENDWITH
769: 
770:         *-- Label "Obs Pessoal:" (right column)
771:         loc_oPg.AddObject("lbl_4c_LbObspes", "Label")
772:         WITH loc_oPg.lbl_4c_LbObspes
773:             .Caption   = "Obs Pessoal :"
774:             .Top       = 239
775:             .Left      = 563
776:             .Width     = 67
777:             .Height    = 15
778:             .FontName  = "Tahoma"
779:             .FontSize  = 8
780:             .ForeColor = RGB(90, 90, 90)
781:             .BackStyle = 0
782:             .AutoSize  = .T.
783:             .Visible   = .T.
784:         ENDWITH
785: 
786:         *-- Obs Pessoal (getObs1: Top=235, Left=633, Width=159, MaxLength=30)
787:         loc_oPg.AddObject("txt_4c_Obspes", "TextBox")
788:         WITH loc_oPg.txt_4c_Obspes
789:             .Top           = 235
790:             .Left          = 633
791:             .Width         = 159
792:             .Height        = 23
793:             .FontName      = "Tahoma"

*-- Linhas 856 a 1023:
856:             .MaxLength     = 10
857:             .Visible       = .T.
858:         ENDWITH
859:         BINDEVENT(loc_oPg.txt_4c_Colecoes, "KeyPress", THIS, "ValidarColecoes")
860: 
861:         *-- Descricao Colecao (GetDCol: Top=255, Left=183, Width=318, readonly)
862:         loc_oPg.AddObject("txt_4c_DColecoes", "TextBox")
863:         WITH loc_oPg.txt_4c_DColecoes
864:             .Top           = 255
865:             .Left          = 183
866:             .Width         = 318
867:             .Height        = 22
868:             .FontName      = "Tahoma"
869:             .FontSize      = 8
870:             .SpecialEffect = 1
871:             .ReadOnly      = .T.
872:             .BackColor     = RGB(240, 240, 240)
873:             .Visible       = .T.
874:         ENDWITH
875: 
876:         *-- Label "Fornecedor:"
877:         loc_oPg.AddObject("lbl_4c_LbIfors", "Label")
878:         WITH loc_oPg.lbl_4c_LbIfors
879:             .Caption   = "Fornecedor :"
880:             .Top       = 305
881:             .Left      = 36
882:             .Width     = 64
883:             .Height    = 15
884:             .FontName  = "Tahoma"
885:             .FontSize  = 8
886:             .ForeColor = RGB(90, 90, 90)
887:             .BackStyle = 0
888:             .AutoSize  = .T.
889:             .Visible   = .T.
890:         ENDWITH
891: 
892:         *-- Codigo Fornecedor (getIfor: Top=301, Left=102, Width=80, MaxLength=10)
893:         loc_oPg.AddObject("txt_4c_Ifors", "TextBox")
894:         WITH loc_oPg.txt_4c_Ifors
895:             .Top           = 301
896:             .Left          = 102
897:             .Width         = 80
898:             .Height        = 22
899:             .FontName      = "Tahoma"
900:             .FontSize      = 8
901:             .SpecialEffect = 1
902:             .MaxLength     = 10
903:             .Visible       = .T.
904:         ENDWITH
905:         BINDEVENT(loc_oPg.txt_4c_Ifors, "KeyDown", THIS, "TxtIforsKeyDown")
906:         BINDEVENT(loc_oPg.txt_4c_Ifors, "KeyPress", THIS, "ValidarIfors")
907: 
908:         *-- Descricao Fornecedor (getDfor: Top=301, Left=183, Width=318, readonly)
909:         loc_oPg.AddObject("txt_4c_Dfors", "TextBox")
910:         WITH loc_oPg.txt_4c_Dfors
911:             .Top           = 301
912:             .Left          = 183
913:             .Width         = 318
914:             .Height        = 22
915:             .FontName      = "Tahoma"
916:             .FontSize      = 8
917:             .SpecialEffect = 1
918:             .ReadOnly      = .T.
919:             .BackColor     = RGB(240, 240, 240)
920:             .Visible       = .T.
921:         ENDWITH
922: 
923:         *-- Label "Cor:"
924:         loc_oPg.AddObject("lbl_4c_LbCodCors", "Label")
925:         WITH loc_oPg.lbl_4c_LbCodCors
926:             .Caption   = "Cor :"
927:             .Top       = 328
928:             .Left      = 361
929:             .Width     = 25
930:             .Height    = 15
931:             .FontName  = "Tahoma"
932:             .FontSize  = 8
933:             .ForeColor = RGB(90, 90, 90)
934:             .BackStyle = 0
935:             .AutoSize  = .T.
936:             .Visible   = .T.
937:         ENDWITH
938: 
939:         *-- Codigo Cor (getCor: Top=324, Left=390, Width=38)
940:         loc_oPg.AddObject("txt_4c_CodCors", "TextBox")
941:         WITH loc_oPg.txt_4c_CodCors
942:             .Top           = 324
943:             .Left          = 390
944:             .Width         = 38
945:             .Height        = 22
946:             .FontName      = "Tahoma"
947:             .FontSize      = 8
948:             .SpecialEffect = 1
949:             .MaxLength     = 4
950:             .Visible       = .T.
951:         ENDWITH
952:         BINDEVENT(loc_oPg.txt_4c_CodCors, "KeyPress", THIS, "ValidarCodCors")
953: 
954:         *-- Label "Tam:"
955:         loc_oPg.AddObject("lbl_4c_LbCodTams", "Label")
956:         WITH loc_oPg.lbl_4c_LbCodTams
957:             .Caption   = "Tam:"
958:             .Top       = 328
959:             .Left      = 431
960:             .Width     = 30
961:             .Height    = 15
962:             .FontName  = "Tahoma"
963:             .FontSize  = 8
964:             .ForeColor = RGB(90, 90, 90)
965:             .BackStyle = 0
966:             .AutoSize  = .T.
967:             .Visible   = .T.
968:         ENDWITH
969: 
970:         *-- Codigo Tamanho (getTam: Top=324, Left=463, Width=38)
971:         loc_oPg.AddObject("txt_4c_CodTams", "TextBox")
972:         WITH loc_oPg.txt_4c_CodTams
973:             .Top           = 324
974:             .Left          = 463
975:             .Width         = 38
976:             .Height        = 22
977:             .FontName      = "Tahoma"
978:             .FontSize      = 8
979:             .SpecialEffect = 1
980:             .MaxLength     = 4
981:             .Visible       = .T.
982:         ENDWITH
983:         BINDEVENT(loc_oPg.txt_4c_CodTams, "KeyPress", THIS, "ValidarCodTams")
984: 
985:         *-- Label "Ref. Fornecedor:"
986:         loc_oPg.AddObject("lbl_4c_LbReffs", "Label")
987:         WITH loc_oPg.lbl_4c_LbReffs
988:             .Caption   = "Ref. Fornecedor :"
989:             .Top       = 327
990:             .Left      = 12
991:             .Width     = 88
992:             .Height    = 15
993:             .FontName  = "Tahoma"
994:             .FontSize  = 8
995:             .ForeColor = RGB(90, 90, 90)
996:             .BackStyle = 0
997:             .AutoSize  = .T.
998:             .Visible   = .T.
999:         ENDWITH
1000: 
1001:         *-- Ref. Fornecedor (getRefs: Top=324, Left=102, Width=221, MaxLength=40)
1002:         loc_oPg.AddObject("txt_4c_Reffs", "TextBox")
1003:         WITH loc_oPg.txt_4c_Reffs
1004:             .Top           = 324
1005:             .Left          = 102
1006:             .Width         = 221
1007:             .Height        = 22
1008:             .FontName      = "Tahoma"
1009:             .FontSize      = 8
1010:             .SpecialEffect = 1
1011:             .MaxLength     = 40
1012:             .Visible       = .T.
1013:         ENDWITH
1014: 
1015:         *-- Label "Valor de Custo:"
1016:         loc_oPg.AddObject("lbl_4c_LbCustofs", "Label")
1017:         WITH loc_oPg.lbl_4c_LbCustofs
1018:             .Caption   = "Valor de Custo :"
1019:             .Top       = 311
1020:             .Left      = 551
1021:             .Width     = 79
1022:             .Height    = 15
1023:             .FontName  = "Tahoma"

*-- Linhas 1184 a 1273:
1184:             .ToolTipText   = "Acabamento"
1185:             .Visible       = .T.
1186:         ENDWITH
1187:         BINDEVENT(loc_oPg.txt_4c_CodAcbs, "KeyPress", THIS, "ValidarCodAcbs")
1188: 
1189:         *-- Descricao do Acabamento (get_Dacb: Top=370, Left=134, Width=150, readonly)
1190:         loc_oPg.AddObject("txt_4c_DAcbs", "TextBox")
1191:         WITH loc_oPg.txt_4c_DAcbs
1192:             .Top           = 370
1193:             .Left          = 134
1194:             .Width         = 150
1195:             .Height        = 22
1196:             .FontName      = "Tahoma"
1197:             .FontSize      = 8
1198:             .SpecialEffect = 1
1199:             .ReadOnly      = .T.
1200:             .BackColor     = RGB(240, 240, 240)
1201:             .Visible       = .T.
1202:         ENDWITH
1203: 
1204:         *-- Label "Unidades (1):"
1205:         loc_oPg.AddObject("lbl_4c_LbCunis", "Label")
1206:         WITH loc_oPg.lbl_4c_LbCunis
1207:             .Caption   = "Unidades (1) :"
1208:             .Top       = 420
1209:             .Left      = 30
1210:             .Width     = 70
1211:             .Height    = 15
1212:             .FontName  = "Tahoma"
1213:             .FontSize  = 8
1214:             .ForeColor = RGB(90, 90, 90)
1215:             .BackStyle = 0
1216:             .AutoSize  = .T.
1217:             .Visible   = .T.
1218:         ENDWITH
1219: 
1220:         *-- Unidade de Medida (Get_Cuni: Top=416, Left=102, Width=31, MaxLength=3)
1221:         loc_oPg.AddObject("txt_4c_Cunis", "TextBox")
1222:         WITH loc_oPg.txt_4c_Cunis
1223:             .Top           = 416
1224:             .Left          = 102
1225:             .Width         = 31
1226:             .Height        = 22
1227:             .FontName      = "Tahoma"
1228:             .FontSize      = 8
1229:             .SpecialEffect = 1
1230:             .MaxLength     = 3
1231:             .Visible       = .T.
1232:         ENDWITH
1233:         BINDEVENT(loc_oPg.txt_4c_Cunis, "KeyPress", THIS, "ValidarCunis")
1234: 
1235:         *-- Descricao da Unidade (Get_Duni: Top=416, Left=134, Width=150, readonly)
1236:         loc_oPg.AddObject("txt_4c_Dunis", "TextBox")
1237:         WITH loc_oPg.txt_4c_Dunis
1238:             .Top           = 416
1239:             .Left          = 134
1240:             .Width         = 150
1241:             .Height        = 22
1242:             .FontName      = "Tahoma"
1243:             .FontSize      = 8
1244:             .SpecialEffect = 1
1245:             .ReadOnly      = .T.
1246:             .BackColor     = RGB(240, 240, 240)
1247:             .Visible       = .T.
1248:         ENDWITH
1249: 
1250:         *-- Label "Data / Usuario"
1251:         loc_oPg.AddObject("lbl_4c_LbDtIncs", "Label")
1252:         WITH loc_oPg.lbl_4c_LbDtIncs
1253:             .Caption   = "Data / Usu" + CHR(225) + "rio"
1254:             .Top       = 420
1255:             .Left      = 827
1256:             .Width     = 84
1257:             .Height    = 15
1258:             .FontName  = "Tahoma"
1259:             .FontBold  = .T.
1260:             .FontSize  = 8
1261:             .ForeColor = RGB(90, 90, 90)
1262:             .BackStyle = 0
1263:             .AutoSize  = .T.
1264:             .Visible   = .T.
1265:         ENDWITH
1266: 
1267:         *-- Data de Inclusao (Get_DtIncs: Top=569->adaptar, Left=827, Width=79, readonly)
1268:         loc_oPg.AddObject("txt_4c_DtIncs", "TextBox")
1269:         WITH loc_oPg.txt_4c_DtIncs
1270:             .Value         = {}
1271:             .Top           = 437
1272:             .Left          = 827
1273:             .Width         = 79

*-- Linhas 1302 a 1395:
1302:     *===========================================================================
1303:     * ConfigurarPgDadosInfo - Configura label descritivo em aba do pgf_4c_Dados
1304:     *===========================================================================
1305:     PROTECTED PROCEDURE ConfigurarPgDadosInfo(par_oPg, par_cConteudo)
1306:         par_oPg.AddObject("lbl_4c_StubInfo", "Label")
1307:         WITH par_oPg.lbl_4c_StubInfo
1308:             .Caption   = par_cConteudo
1309:             .Top       = 50
1310:             .Left      = 30
1311:             .Width     = 600
1312:             .Height    = 30
1313:             .FontName  = "Tahoma"
1314:             .FontSize  = 10
1315:             .FontBold  = .F.
1316:             .ForeColor = RGB(120, 120, 120)
1317:             .BackStyle = 0
1318:             .AutoSize  = .T.
1319:             .Visible   = .T.
1320:         ENDWITH
1321:     ENDPROC
1322: 
1323:     *===========================================================================
1324:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
1325:     * REGRA: Chamar SEMPRE com parametro: THIS.TornarControlesVisiveis(loc_oPagina)
1326:     *===========================================================================
1327:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1328:         LOCAL loc_nI, loc_oObjeto, loc_nP
1329: 
1330:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1331:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1332: 
1333:             IF VARTYPE(loc_oObjeto) = "O"
1334:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1335:                     loc_oObjeto.Visible = .T.
1336:                 ENDIF
1337: 
1338:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1339:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1340:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1341:                     ENDFOR
1342:                 ENDIF
1343: 
1344:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1345:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1346:                 ENDIF
1347:             ENDIF
1348:         ENDFOR
1349:     ENDPROC
1350: 
1351:     *===========================================================================
1352:     * CarregarLista - Carrega dados no grid da Page1
1353:     * CRITICO: Definir ControlSources APOS RecordSource (auto-bind)
1354:     *===========================================================================
1355:     PROCEDURE CarregarLista()
1356:         LOCAL loc_lResultado, loc_oGrid
1357:         loc_lResultado = .F.
1358: 
1359:         TRY
1360:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1361:                 loc_lResultado = .T.
1362:             ENDIF
1363: 
1364:             IF !THIS.this_oBusinessObject.Buscar("")
1365:                 loc_lResultado = .F.
1366:             ELSE
1367:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1368: 
1369:                 *-- RecordSource e ColumnCount FORA do WITH (auto-bind VFP9)
1370:                 loc_oGrid.ColumnCount  = 7
1371:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
1372: 
1373:                 *-- ControlSources APOS RecordSource (OBRIGATORIO - auto-bind sobrescreve)
1374:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cpros"
1375:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.dpros"
1376:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.cgrus"
1377:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.sgrus"
1378:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.reffs"
1379:                 loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.colecoes"
1380:                 loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.situas"
1381: 
1382:                 *-- Widths (originais: 110, 408, 40, 70, 150, 100, 16)
1383:                 loc_oGrid.Column1.Width = 110
1384:                 loc_oGrid.Column2.Width = 408
1385:                 loc_oGrid.Column3.Width = 40
1386:                 loc_oGrid.Column4.Width = 70
1387:                 loc_oGrid.Column5.Width = 150
1388:                 loc_oGrid.Column6.Width = 100
1389:                 loc_oGrid.Column7.Width = 40
1390: 
1391:                 *-- Headers APOS RecordSource (RecordSource reseta captions)
1392:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1393:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1394:                 loc_oGrid.Column3.Header1.Caption = "Grupo"
1395:                 loc_oGrid.Column4.Header1.Caption = "Sub-grupo"

*-- Linhas 1432 a 1822:
1432:     *===========================================================================
1433:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
1434:     *===========================================================================
1435:     PROCEDURE AlternarPagina(par_nPagina)
1436:         LOCAL loc_lResultado
1437:         loc_lResultado = .F.
1438: 
1439:         TRY
1440:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
1441:                 MsgAviso("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + TRANSFORM(par_nPagina))
1442:             ELSE
1443:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1444: 
1445:                 IF par_nPagina = 1
1446:                     THIS.this_cModoAtual = "LISTA"
1447:                     THIS.CarregarLista()
1448:                 ENDIF
1449: 
1450:                 loc_lResultado = .T.
1451:             ENDIF
1452: 
1453:         CATCH TO loException
1454:             MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loException.Message, ;
1455:                 "FormProduto.AlternarPagina")
1456:         ENDTRY
1457: 
1458:         RETURN loc_lResultado
1459:     ENDPROC
1460: 
1461:     *===========================================================================
1462:     * FormatarGridLista - Formata visual do grid de lista
1463:     *===========================================================================
1464:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1465:         TRY
1466:             WITH par_oGrid
1467:                 .FontName = "Tahoma"
1468:                 .FontSize = 8
1469:             ENDWITH
1470:         CATCH TO loException
1471:             MostrarErro("Erro ao formatar grid:" + CHR(13) + loException.Message, ;
1472:                 "FormProduto.FormatarGridLista")
1473:         ENDTRY
1474:     ENDPROC
1475: 
1476:     *===========================================================================
1477:     * BtnIncluirClick - Abre Page2 para incluir novo produto
1478:     * PUBLIC: BINDEVENT requer metodo publico
1479:     *===========================================================================
1480:     PROCEDURE BtnIncluirClick()
1481:         THIS.this_oBusinessObject.NovoRegistro()
1482:         THIS.LimparCampos()
1483:         THIS.this_cModoAtual = "INCLUIR"
1484:         THIS.HabilitarCampos(.T.)
1485:         THIS.AjustarBotoesPorModo()
1486:         THIS.AlternarPagina(2)
1487:     ENDPROC
1488: 
1489:     *===========================================================================
1490:     * BtnVisualizarClick - Abre Page2 em modo somente leitura
1491:     * PUBLIC: BINDEVENT requer metodo publico
1492:     *===========================================================================
1493:     PROCEDURE BtnVisualizarClick()
1494:         LOCAL loc_cCodigo
1495:         loc_cCodigo = ""
1496: 
1497:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1498:             SELECT cursor_4c_Dados
1499:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
1500:         ENDIF
1501: 
1502:         IF EMPTY(loc_cCodigo)
1503:             MsgAviso("Selecione um produto para visualizar.")
1504:         ELSE
1505:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1506:                 THIS.this_cModoAtual = "VISUALIZAR"
1507:                 THIS.BOParaForm()
1508:                 THIS.HabilitarCampos(.F.)
1509:                 THIS.AjustarBotoesPorModo()
1510:                 THIS.AlternarPagina(2)
1511:             ENDIF
1512:         ENDIF
1513:     ENDPROC
1514: 
1515:     *===========================================================================
1516:     * BtnAlterarClick - Abre Page2 para alterar produto selecionado
1517:     * PUBLIC: BINDEVENT requer metodo publico
1518:     *===========================================================================
1519:     PROCEDURE BtnAlterarClick()
1520:         LOCAL loc_cCodigo
1521:         loc_cCodigo = ""
1522: 
1523:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1524:             SELECT cursor_4c_Dados
1525:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
1526:         ENDIF
1527: 
1528:         IF EMPTY(loc_cCodigo)
1529:             MsgAviso("Selecione um produto para alterar.")
1530:         ELSE
1531:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1532:                 THIS.this_oBusinessObject.EditarRegistro()
1533:                 THIS.this_cModoAtual = "ALTERAR"
1534:                 THIS.BOParaForm()
1535:                 THIS.HabilitarCampos(.T.)
1536:                 THIS.AjustarBotoesPorModo()
1537:                 THIS.AlternarPagina(2)
1538:             ENDIF
1539:         ENDIF
1540:     ENDPROC
1541: 
1542:     *===========================================================================
1543:     * BtnExcluirClick - Exclui produto selecionado com confirmacao
1544:     * PUBLIC: BINDEVENT requer metodo publico
1545:     *===========================================================================
1546:     PROCEDURE BtnExcluirClick()
1547:         LOCAL loc_cCodigo, loc_cDescricao
1548:         loc_cCodigo    = ""
1549:         loc_cDescricao = ""
1550: 
1551:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1552:             SELECT cursor_4c_Dados
1553:             loc_cCodigo    = ALLTRIM(cursor_4c_Dados.cpros)
1554:             loc_cDescricao = ALLTRIM(cursor_4c_Dados.dpros)
1555:         ENDIF
1556: 
1557:         IF EMPTY(loc_cCodigo)
1558:             MsgAviso("Selecione um produto para excluir.")
1559:         ELSE
1560:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1561:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do produto [" + ;
1562:                     loc_cCodigo + "] - " + loc_cDescricao + "?", ;
1563:                     "Confirmar Exclus" + CHR(227) + "o")
1564:                     IF THIS.this_oBusinessObject.Excluir()
1565:                         MsgInfo("Produto exclu" + CHR(237) + "do com sucesso!")
1566:                         THIS.CarregarLista()
1567:                     ENDIF
1568:                 ENDIF
1569:             ENDIF
1570:         ENDIF
1571:     ENDPROC
1572: 
1573:     *===========================================================================
1574:     * BtnBuscarClick - Busca produto pelo codigo ou descricao
1575:     * PUBLIC: BINDEVENT requer metodo publico
1576:     *===========================================================================
1577:     PROCEDURE BtnBuscarClick()
1578:         LOCAL loc_oBusca, loc_cCodigo, loc_nRet, loException
1579:         loc_cCodigo = ""
1580: 
1581:         TRY
1582:             loc_nRet = SQLEXEC(gnConnHandle, ;
1583:                 "SELECT cpros, dpros FROM SigCdPro ORDER BY cpros", ;
1584:                 "cursor_4c_BuscaProduto")
1585: 
1586:             IF loc_nRet > 0 AND USED("cursor_4c_BuscaProduto")
1587:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1588:                 IF VARTYPE(loc_oBusca) = "O"
1589:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaProduto", "cpros", "dpros", ;
1590:                         "Buscar Produto")
1591:                     loc_oBusca.Mostrar()
1592:                     IF !EMPTY(loc_oBusca.cCodigoSelecionado)
1593:                         loc_cCodigo = ALLTRIM(loc_oBusca.cCodigoSelecionado)
1594:                     ENDIF
1595:                     loc_oBusca = .NULL.
1596:                 ENDIF
1597:             ENDIF
1598: 
1599:             IF USED("cursor_4c_BuscaProduto")
1600:                 USE IN cursor_4c_BuscaProduto
1601:             ENDIF
1602: 
1603:             IF !EMPTY(loc_cCodigo) AND USED("cursor_4c_Dados")
1604:                 SELECT cursor_4c_Dados
1605:                 LOCATE FOR ALLTRIM(cpros) == loc_cCodigo
1606:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
1607:             ENDIF
1608: 
1609:         CATCH TO loException
1610:             IF USED("cursor_4c_BuscaProduto")
1611:                 USE IN cursor_4c_BuscaProduto
1612:             ENDIF
1613:             MostrarErro("Erro na busca:" + CHR(13) + loException.Message, ;
1614:                 "FormProduto.BtnBuscarClick")
1615:         ENDTRY
1616:     ENDPROC
1617: 
1618:     *===========================================================================
1619:     * BtnEncerrarClick - Fecha o formulario
1620:     * PUBLIC: BINDEVENT requer metodo publico
1621:     *===========================================================================
1622:     PROCEDURE BtnEncerrarClick()
1623:         THIS.Release()
1624:     ENDPROC
1625: 
1626:     *===========================================================================
1627:     * LimparCampos - Limpa todos os campos de entrada do pgDados.Page1
1628:     *===========================================================================
1629:     PROTECTED PROCEDURE LimparCampos()
1630:         LOCAL loc_oPg, loException
1631:         TRY
1632:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1633:             WITH loc_oPg
1634:                 .txt_4c_Cpros.Value     = ""
1635:                 .txt_4c_Dpros.Value     = ""
1636:                 .txt_4c_Cbars.Value     = 0
1637:                 .opt_4c_Situacao.Value  = 1
1638:                 .txt_4c_DtSituas.Value  = {}
1639:                 .txt_4c_Cgrus.Value     = ""
1640:                 .txt_4c_Dgrus.Value     = ""
1641:                 .txt_4c_SGrus.Value     = ""
1642:                 .txt_4c_DsGrus.Value    = ""
1643:                 .txt_4c_Linhas.Value    = ""
1644:                 .txt_4c_DLinhas.Value   = ""
1645:                 .txt_4c_Obspes.Value    = ""
1646:                 .txt_4c_Obspeds.Value   = ""
1647:                 .txt_4c_Colecoes.Value  = ""
1648:                 .txt_4c_DColecoes.Value = ""
1649:                 .txt_4c_Ifors.Value     = ""
1650:                 .txt_4c_Dfors.Value     = ""
1651:                 .txt_4c_Reffs.Value     = ""
1652:                 .txt_4c_CodCors.Value   = ""
1653:                 .txt_4c_CodTams.Value   = ""
1654:                 .txt_4c_Custofs.Value   = 0
1655:                 .txt_4c_MoeCusfs.Value  = ""
1656:                 .txt_4c_Pvens.Value     = 0
1657:                 .txt_4c_Moevs.Value     = ""
1658:                 .txt_4c_Fvendas.Value   = 0
1659:                 .txt_4c_Moepvs.Value    = ""
1660:                 .txt_4c_CodAcbs.Value   = ""
1661:                 .txt_4c_DAcbs.Value     = ""
1662:                 .txt_4c_Cunis.Value     = ""
1663:                 .txt_4c_Dunis.Value     = ""
1664:                 .txt_4c_DtIncs.Value    = {}
1665:                 .txt_4c_DtAlts.Value    = {}
1666:             ENDWITH
1667:         CATCH TO loException
1668:             MostrarErro("Erro ao limpar campos:" + CHR(13) + loException.Message, ;
1669:                 "FormProduto.LimparCampos")
1670:         ENDTRY
1671:     ENDPROC
1672: 
1673:     *===========================================================================
1674:     * HabilitarCampos - Habilita/desabilita campos de entrada por modo
1675:     * par_lHabilitar=.T. em INCLUIR/ALTERAR, .F. em VISUALIZAR
1676:     *===========================================================================
1677:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1678:         LOCAL loc_oPg, loc_lModoIncluir, loException
1679:         TRY
1680:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1681:             loc_lModoIncluir = (THIS.this_cModoAtual == "INCLUIR")
1682: 
1683:             WITH loc_oPg
1684:                 *-- Codigo do produto: somente editavel em INCLUIR (PK nao pode mudar em ALTERAR)
1685:                 .txt_4c_Cpros.Enabled    = par_lHabilitar AND loc_lModoIncluir
1686:                 *-- Demais campos de entrada
1687:                 .txt_4c_Dpros.Enabled    = par_lHabilitar
1688:                 .txt_4c_Cbars.Enabled    = par_lHabilitar
1689:                 .opt_4c_Situacao.Enabled = par_lHabilitar
1690:                 .txt_4c_Cgrus.Enabled    = par_lHabilitar
1691:                 .txt_4c_SGrus.Enabled    = par_lHabilitar
1692:                 .txt_4c_Linhas.Enabled   = par_lHabilitar
1693:                 .txt_4c_Obspes.Enabled   = par_lHabilitar
1694:                 .txt_4c_Obspeds.Enabled  = par_lHabilitar
1695:                 .txt_4c_Colecoes.Enabled = par_lHabilitar
1696:                 .txt_4c_Ifors.Enabled    = par_lHabilitar
1697:                 .txt_4c_Reffs.Enabled    = par_lHabilitar
1698:                 .txt_4c_CodCors.Enabled  = par_lHabilitar
1699:                 .txt_4c_CodTams.Enabled  = par_lHabilitar
1700:                 .txt_4c_CodAcbs.Enabled  = par_lHabilitar
1701:                 .txt_4c_Cunis.Enabled    = par_lHabilitar
1702:             ENDWITH
1703: 
1704:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "cnt_4c_BotoesAcao", 5)
1705:                 WITH THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
1706:                     .cmd_4c_Salvar.Enabled = par_lHabilitar
1707:                     .Visible     = .T.
1708:                 ENDWITH
1709:             ENDIF
1710: 
1711:         CATCH TO loException
1712:             MostrarErro("Erro ao habilitar campos:" + CHR(13) + loException.Message, ;
1713:                 "FormProduto.HabilitarCampos")
1714:         ENDTRY
1715:     ENDPROC
1716: 
1717:     *===========================================================================
1718:     * AjustarBotoesPorModo - Ajusta botoes por modo atual
1719:     *===========================================================================
1720:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1721:         LOCAL loc_lEhLista
1722:         loc_lEhLista = (THIS.this_cModoAtual == "LISTA")
1723: 
1724:         TRY
1725:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_Botoes", 5)
1726:                 WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
1727:                     IF PEMSTATUS(.cmd_4c_Incluir, "Enabled", 5)
1728:                         .cmd_4c_Incluir.Enabled   = loc_lEhLista
1729:                         .cmd_4c_Alterar.Enabled   = loc_lEhLista
1730:                         .cmd_4c_Excluir.Enabled   = loc_lEhLista
1731:                         .cmd_4c_Visualizar.Enabled = loc_lEhLista
1732:                         .cmd_4c_Buscar.Enabled    = loc_lEhLista
1733:                     ENDIF
1734:                     .Visible     = .T.
1735:                 ENDWITH
1736:             ENDIF
1737:         CATCH TO loException
1738:             MostrarErro("Erro ao ajustar bot" + CHR(245) + "es:" + CHR(13) + loException.Message, ;
1739:                 "FormProduto.AjustarBotoesPorModo")
1740:         ENDTRY
1741:     ENDPROC
1742: 
1743:     *===========================================================================
1744:     * FormParaBO - Transfere valores do pgDados.Page1 para o BO
1745:     *===========================================================================
1746:     PROTECTED PROCEDURE FormParaBO()
1747:         LOCAL loc_oPg, loc_oBO, loException
1748:         TRY
1749:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1750:             loc_oBO = THIS.this_oBusinessObject
1751: 
1752:             loc_oBO.this_cCpros    = ALLTRIM(loc_oPg.txt_4c_Cpros.Value)
1753:             loc_oBO.this_cDpros    = ALLTRIM(loc_oPg.txt_4c_Dpros.Value)
1754:             loc_oBO.this_nCbars    = loc_oPg.txt_4c_Cbars.Value
1755:             loc_oBO.this_nSituas   = loc_oPg.opt_4c_Situacao.Value
1756:             loc_oBO.this_cCgrus    = ALLTRIM(loc_oPg.txt_4c_Cgrus.Value)
1757:             loc_oBO.this_cSgrus    = ALLTRIM(loc_oPg.txt_4c_SGrus.Value)
1758:             loc_oBO.this_cLinhas   = ALLTRIM(loc_oPg.txt_4c_Linhas.Value)
1759:             loc_oBO.this_cObspes   = ALLTRIM(loc_oPg.txt_4c_Obspes.Value)
1760:             loc_oBO.this_cObspeds  = ALLTRIM(loc_oPg.txt_4c_Obspeds.Value)
1761:             loc_oBO.this_cColecoes = ALLTRIM(loc_oPg.txt_4c_Colecoes.Value)
1762:             loc_oBO.this_cIfors    = ALLTRIM(loc_oPg.txt_4c_Ifors.Value)
1763:             loc_oBO.this_cReffs    = ALLTRIM(loc_oPg.txt_4c_Reffs.Value)
1764:             loc_oBO.this_cCodcors  = ALLTRIM(loc_oPg.txt_4c_CodCors.Value)
1765:             loc_oBO.this_cCodtams  = ALLTRIM(loc_oPg.txt_4c_CodTams.Value)
1766:             loc_oBO.this_nCustofs  = loc_oPg.txt_4c_Custofs.Value
1767:             loc_oBO.this_nPvens    = loc_oPg.txt_4c_Pvens.Value
1768:             loc_oBO.this_nFvendas  = loc_oPg.txt_4c_Fvendas.Value
1769:             loc_oBO.this_cCodacbs  = ALLTRIM(loc_oPg.txt_4c_CodAcbs.Value)
1770:             loc_oBO.this_cCunis    = ALLTRIM(loc_oPg.txt_4c_Cunis.Value)
1771: 
1772:         CATCH TO loException
1773:             MostrarErro("Erro ao transferir form->BO:" + CHR(13) + loException.Message + ;
1774:                 CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), ;
1775:                 "FormProduto.FormParaBO")
1776:         ENDTRY
1777:     ENDPROC
1778: 
1779:     *===========================================================================
1780:     * BOParaForm - Transfere propriedades do BO para os campos do pgDados.Page1
1781:     *===========================================================================
1782:     PROTECTED PROCEDURE BOParaForm()
1783:         LOCAL loc_oPg, loc_oBO, loException
1784:         TRY
1785:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1786:             loc_oBO = THIS.this_oBusinessObject
1787: 
1788:             loc_oPg.txt_4c_Cpros.Value     = ALLTRIM(loc_oBO.this_cCpros)
1789:             loc_oPg.txt_4c_Dpros.Value     = ALLTRIM(loc_oBO.this_cDpros)
1790:             loc_oPg.txt_4c_Cbars.Value     = loc_oBO.this_nCbars
1791:             loc_oPg.opt_4c_Situacao.Value  = IIF(loc_oBO.this_nSituas = 1, 1, 2)
1792:             loc_oPg.txt_4c_DtSituas.Value  = IIF(EMPTY(loc_oBO.this_dDtsituas), {}, ;
1793:                 TTOD(loc_oBO.this_dDtsituas))
1794:             loc_oPg.txt_4c_Cgrus.Value     = ALLTRIM(loc_oBO.this_cCgrus)
1795:             loc_oPg.txt_4c_Dgrus.Value     = ""
1796:             loc_oPg.txt_4c_SGrus.Value     = ALLTRIM(loc_oBO.this_cSgrus)
1797:             loc_oPg.txt_4c_DsGrus.Value    = ""
1798:             loc_oPg.txt_4c_Linhas.Value    = ALLTRIM(loc_oBO.this_cLinhas)
1799:             loc_oPg.txt_4c_DLinhas.Value   = ""
1800:             loc_oPg.txt_4c_Obspes.Value    = ALLTRIM(loc_oBO.this_cObspes)
1801:             loc_oPg.txt_4c_Obspeds.Value   = ALLTRIM(loc_oBO.this_cObspeds)
1802:             loc_oPg.txt_4c_Colecoes.Value  = ALLTRIM(loc_oBO.this_cColecoes)
1803:             loc_oPg.txt_4c_DColecoes.Value = ""
1804:             loc_oPg.txt_4c_Ifors.Value     = ALLTRIM(loc_oBO.this_cIfors)
1805:             loc_oPg.txt_4c_Dfors.Value     = ""
1806:             loc_oPg.txt_4c_Reffs.Value     = ALLTRIM(loc_oBO.this_cReffs)
1807:             loc_oPg.txt_4c_CodCors.Value   = ALLTRIM(loc_oBO.this_cCodcors)
1808:             loc_oPg.txt_4c_CodTams.Value   = ALLTRIM(loc_oBO.this_cCodtams)
1809:             loc_oPg.txt_4c_Custofs.Value   = loc_oBO.this_nCustofs
1810:             loc_oPg.txt_4c_MoeCusfs.Value  = ALLTRIM(loc_oBO.this_cMoecusfs)
1811:             loc_oPg.txt_4c_Pvens.Value     = loc_oBO.this_nPvens
1812:             loc_oPg.txt_4c_Moevs.Value     = ALLTRIM(loc_oBO.this_cMoevs)
1813:             loc_oPg.txt_4c_Fvendas.Value   = loc_oBO.this_nFvendas
1814:             loc_oPg.txt_4c_Moepvs.Value    = ALLTRIM(loc_oBO.this_cMoepvs)
1815:             loc_oPg.txt_4c_CodAcbs.Value   = ALLTRIM(loc_oBO.this_cCodacbs)
1816:             loc_oPg.txt_4c_DAcbs.Value     = ""
1817:             loc_oPg.txt_4c_Cunis.Value     = ALLTRIM(loc_oBO.this_cCunis)
1818:             loc_oPg.txt_4c_Dunis.Value     = ""
1819:             loc_oPg.txt_4c_DtIncs.Value    = IIF(EMPTY(loc_oBO.this_dDtincs), {}, ;
1820:                 TTOD(loc_oBO.this_dDtincs))
1821:             loc_oPg.txt_4c_DtAlts.Value    = IIF(EMPTY(loc_oBO.this_dDtalts), {}, ;
1822:                 TTOD(loc_oBO.this_dDtalts))

*-- Linhas 1833 a 1928:
1833: 
1834:     *===========================================================================
1835:     * BtnSalvarClick - Confirma e salva o produto
1836:     * PUBLIC: BINDEVENT requer metodo publico
1837:     *===========================================================================
1838:     PROCEDURE BtnSalvarClick()
1839:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1840:             RETURN
1841:         ENDIF
1842: 
1843:         IF !THIS.ValidarCampos()
1844:             RETURN
1845:         ENDIF
1846: 
1847:         THIS.FormParaBO()
1848: 
1849:         IF THIS.this_oBusinessObject.Salvar()
1850:             MsgInfo("Produto salvo com sucesso!")
1851:             THIS.AlternarPagina(1)
1852:         ENDIF
1853:     ENDPROC
1854: 
1855:     *===========================================================================
1856:     * BtnCancelarClick - Cancela e volta para lista
1857:     * PUBLIC: BINDEVENT requer metodo publico
1858:     *===========================================================================
1859:     PROCEDURE BtnCancelarClick()
1860:         THIS.AlternarPagina(1)
1861:         THIS.this_cModoAtual = "LISTA"
1862:         THIS.CarregarLista()
1863:     ENDPROC
1864: 
1865:     *===========================================================================
1866:     * Destroy - Libera recursos ao fechar o formulario
1867:     *===========================================================================
1868:     PROCEDURE Destroy()
1869:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1870:             THIS.this_oBusinessObject = .NULL.
1871:         ENDIF
1872: 
1873:         IF USED("cursor_4c_Dados")
1874:             USE IN cursor_4c_Dados
1875:         ENDIF
1876: 
1877:         IF USED("cursor_4c_BuscaProduto")
1878:             USE IN cursor_4c_BuscaProduto
1879:         ENDIF
1880: 
1881:         DODEFAULT()
1882:     ENDPROC
1883: 
1884:     *===========================================================================
1885:     * CarregarDescricoes - Popula campos de descricao lookup (silencioso, sem dialog)
1886:     * Chamado de BOParaForm para carregar descricoes ao exibir registro existente
1887:     *===========================================================================
1888:     PROTECTED PROCEDURE CarregarDescricoes()
1889:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
1890:         TRY
1891:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1892: 
1893:             *-- Grupo (SigCdGrp: cgrus/dgrus)
1894:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cgrus.Value)
1895:             IF !EMPTY(loc_cCod)
1896:                 loc_nRet = SQLEXEC(gnConnHandle, ;
1897:                     "SELECT dgrus FROM SigCdGrp WHERE cgrus = " + EscaparSQL(loc_cCod), ;
1898:                     "cursor_4c_LkpDesc")
1899:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpDesc") AND !EOF("cursor_4c_LkpDesc")
1900:                     loc_oPg.txt_4c_Dgrus.Value = ALLTRIM(cursor_4c_LkpDesc.dgrus)
1901:                 ENDIF
1902:                 IF USED("cursor_4c_LkpDesc")
1903:                     USE IN cursor_4c_LkpDesc
1904:                 ENDIF
1905:             ENDIF
1906: 
1907:             *-- Linha (SigCdLin: linhas/descs)
1908:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Linhas.Value)
1909:             IF !EMPTY(loc_cCod)
1910:                 loc_nRet = SQLEXEC(gnConnHandle, ;
1911:                     "SELECT descs FROM SigCdLin WHERE linhas = " + EscaparSQL(loc_cCod), ;
1912:                     "cursor_4c_LkpDesc")
1913:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpDesc") AND !EOF("cursor_4c_LkpDesc")
1914:                     loc_oPg.txt_4c_DLinhas.Value = ALLTRIM(cursor_4c_LkpDesc.descs)
1915:                 ENDIF
1916:                 IF USED("cursor_4c_LkpDesc")
1917:                     USE IN cursor_4c_LkpDesc
1918:                 ENDIF
1919:             ENDIF
1920: 
1921:             *-- Colecao/Grupo de Venda (SigCdCol: colecoes/descs)
1922:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Colecoes.Value)
1923:             IF !EMPTY(loc_cCod)
1924:                 loc_nRet = SQLEXEC(gnConnHandle, ;
1925:                     "SELECT descs FROM SigCdCol WHERE colecoes = " + EscaparSQL(loc_cCod), ;
1926:                     "cursor_4c_LkpDesc")
1927:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpDesc") AND !EOF("cursor_4c_LkpDesc")
1928:                     loc_oPg.txt_4c_DColecoes.Value = ALLTRIM(cursor_4c_LkpDesc.descs)

*-- Linhas 1993 a 2445:
1993:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1994: 
1995:             IF EMPTY(ALLTRIM(loc_oPg.txt_4c_Cpros.Value))
1996:                 MsgAviso("C" + CHR(243) + "digo do produto " + CHR(233) + " obrigat" + CHR(243) + "rio!")
1997:                 loc_oPg.txt_4c_Cpros.SetFocus()
1998:             ELSE
1999:                 IF EMPTY(ALLTRIM(loc_oPg.txt_4c_Dpros.Value))
2000:                 MsgAviso("Descri" + CHR(231) + CHR(227) + "o " + CHR(233) + " obrigat" + CHR(243) + "ria!")
2001:                 loc_oPg.txt_4c_Dpros.SetFocus()
2002:             ELSE
2003:                 loc_lValido = .T.
2004:                 ENDIF
2005:             ENDIF
2006:         CATCH TO loException
2007:             MostrarErro("Erro ao validar campos:" + CHR(13) + loException.Message, ;
2008:                 "FormProduto.ValidarCampos")
2009:         ENDTRY
2010:         RETURN loc_lValido
2011:     ENDFUNC
2012: 
2013:     *===========================================================================
2014:     * TxtCgrusKeyDown - F4 abre busca de grupo
2015:     * PUBLIC: BINDEVENT requer metodo publico; KeyDown exige os 2 parametros
2016:     *===========================================================================
2017:     PROCEDURE TxtCgrusKeyDown(par_nKeyCode, par_nShiftAltCtrl)
2018:         IF par_nKeyCode = 115
2019:             THIS.AbrirBuscaGrupo()
2020:         ENDIF
2021:     ENDPROC
2022: 
2023:     *===========================================================================
2024:     * TxtIforsKeyDown - F4 abre busca de fornecedor
2025:     * PUBLIC: BINDEVENT requer metodo publico; KeyDown exige os 2 parametros
2026:     *===========================================================================
2027:     PROCEDURE TxtIforsKeyDown(par_nKeyCode, par_nShiftAltCtrl)
2028:         IF par_nKeyCode = 115
2029:             THIS.AbrirBuscaFornecedor()
2030:         ENDIF
2031:     ENDPROC
2032: 
2033:     *===========================================================================
2034:     * ValidarCgrus - LostFocus: valida cgrus e popula dgrus (SigCdGrp)
2035:     * PUBLIC: BINDEVENT requer metodo publico
2036:     *===========================================================================
2037:     PROCEDURE ValidarCgrus(par_nKeyCode, par_nShiftAltCtrl)
2038:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
2039:         TRY
2040:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2041:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cgrus.Value)
2042: 
2043:             IF EMPTY(loc_cCod)
2044:                 loc_oPg.txt_4c_Dgrus.Value = ""
2045:             ELSE
2046:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2047:                     "SELECT dgrus FROM SigCdGrp WHERE cgrus = " + EscaparSQL(loc_cCod), ;
2048:                     "cursor_4c_LkpCgrus")
2049: 
2050:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpCgrus") AND !EOF("cursor_4c_LkpCgrus")
2051:                     loc_oPg.txt_4c_Dgrus.Value = ALLTRIM(cursor_4c_LkpCgrus.dgrus)
2052:                     USE IN cursor_4c_LkpCgrus
2053:                 ELSE
2054:                     IF USED("cursor_4c_LkpCgrus")
2055:                         USE IN cursor_4c_LkpCgrus
2056:                     ENDIF
2057:                     loc_oPg.txt_4c_Cgrus.Value = ""
2058:                     loc_oPg.txt_4c_Dgrus.Value = ""
2059:                     THIS.AbrirBuscaGrupo()
2060:                 ENDIF
2061:             ENDIF
2062: 
2063:         CATCH TO loException
2064:             IF USED("cursor_4c_LkpCgrus")
2065:                 USE IN cursor_4c_LkpCgrus
2066:             ENDIF
2067:             MostrarErro("Erro ao validar grupo:" + CHR(13) + loException.Message, ;
2068:                 "FormProduto.ValidarCgrus")
2069:         ENDTRY
2070:     ENDPROC
2071: 
2072:     *===========================================================================
2073:     * ValidarSGrus - LostFocus: sgrus sem tabela de descricao, apenas aceita valor
2074:     * PUBLIC: BINDEVENT requer metodo publico
2075:     *===========================================================================
2076:     PROCEDURE ValidarSGrus(par_nKeyCode, par_nShiftAltCtrl)
2077:         LOCAL loc_oPg
2078:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2079:         loc_oPg.txt_4c_DsGrus.Value = ""
2080:     ENDPROC
2081: 
2082:     *===========================================================================
2083:     * ValidarLinhas - LostFocus: valida linhas e popula DLinhas (SigCdLin)
2084:     * PUBLIC: BINDEVENT requer metodo publico
2085:     *===========================================================================
2086:     PROCEDURE ValidarLinhas(par_nKeyCode, par_nShiftAltCtrl)
2087:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
2088:         TRY
2089:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2090:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Linhas.Value)
2091: 
2092:             IF EMPTY(loc_cCod)
2093:                 loc_oPg.txt_4c_DLinhas.Value = ""
2094:             ELSE
2095:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2096:                     "SELECT descs FROM SigCdLin WHERE linhas = " + EscaparSQL(loc_cCod), ;
2097:                     "cursor_4c_LkpLinha")
2098: 
2099:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpLinha") AND !EOF("cursor_4c_LkpLinha")
2100:                     loc_oPg.txt_4c_DLinhas.Value = ALLTRIM(cursor_4c_LkpLinha.descs)
2101:                     USE IN cursor_4c_LkpLinha
2102:                 ELSE
2103:                     IF USED("cursor_4c_LkpLinha")
2104:                         USE IN cursor_4c_LkpLinha
2105:                     ENDIF
2106:                     loc_oPg.txt_4c_Linhas.Value  = ""
2107:                     loc_oPg.txt_4c_DLinhas.Value = ""
2108:                     MsgAviso("Linha n" + CHR(227) + "o encontrada.")
2109:                 ENDIF
2110:             ENDIF
2111: 
2112:         CATCH TO loException
2113:             IF USED("cursor_4c_LkpLinha")
2114:                 USE IN cursor_4c_LkpLinha
2115:             ENDIF
2116:             MostrarErro("Erro ao validar linha:" + CHR(13) + loException.Message, ;
2117:                 "FormProduto.ValidarLinhas")
2118:         ENDTRY
2119:     ENDPROC
2120: 
2121:     *===========================================================================
2122:     * ValidarColecoes - LostFocus: valida colecao e popula DColecoes (SigCdCol)
2123:     * PUBLIC: BINDEVENT requer metodo publico
2124:     *===========================================================================
2125:     PROCEDURE ValidarColecoes(par_nKeyCode, par_nShiftAltCtrl)
2126:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
2127:         TRY
2128:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2129:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Colecoes.Value)
2130: 
2131:             IF EMPTY(loc_cCod)
2132:                 loc_oPg.txt_4c_DColecoes.Value = ""
2133:             ELSE
2134:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2135:                     "SELECT descs FROM SigCdCol WHERE colecoes = " + EscaparSQL(loc_cCod), ;
2136:                     "cursor_4c_LkpColecao")
2137: 
2138:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpColecao") AND !EOF("cursor_4c_LkpColecao")
2139:                     loc_oPg.txt_4c_DColecoes.Value = ALLTRIM(cursor_4c_LkpColecao.descs)
2140:                     USE IN cursor_4c_LkpColecao
2141:                 ELSE
2142:                     IF USED("cursor_4c_LkpColecao")
2143:                         USE IN cursor_4c_LkpColecao
2144:                     ENDIF
2145:                     loc_oPg.txt_4c_Colecoes.Value  = ""
2146:                     loc_oPg.txt_4c_DColecoes.Value = ""
2147:                     MsgAviso("Grupo de venda n" + CHR(227) + "o encontrado.")
2148:                 ENDIF
2149:             ENDIF
2150: 
2151:         CATCH TO loException
2152:             IF USED("cursor_4c_LkpColecao")
2153:                 USE IN cursor_4c_LkpColecao
2154:             ENDIF
2155:             MostrarErro("Erro ao validar cole" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
2156:                 loException.Message, "FormProduto.ValidarColecoes")
2157:         ENDTRY
2158:     ENDPROC
2159: 
2160:     *===========================================================================
2161:     * ValidarIfors - LostFocus: valida fornecedor e popula Dfors (SigCdFor)
2162:     * PUBLIC: BINDEVENT requer metodo publico
2163:     *===========================================================================
2164:     PROCEDURE ValidarIfors(par_nKeyCode, par_nShiftAltCtrl)
2165:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
2166:         TRY
2167:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2168:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Ifors.Value)
2169: 
2170:             IF EMPTY(loc_cCod)
2171:                 loc_oPg.txt_4c_Dfors.Value = ""
2172:             ELSE
2173:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2174:                     "SELECT dfors FROM SigCdFor WHERE ifors = " + EscaparSQL(loc_cCod), ;
2175:                     "cursor_4c_LkpForn")
2176: 
2177:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpForn") AND !EOF("cursor_4c_LkpForn")
2178:                     loc_oPg.txt_4c_Dfors.Value = ALLTRIM(cursor_4c_LkpForn.dfors)
2179:                     USE IN cursor_4c_LkpForn
2180:                 ELSE
2181:                     IF USED("cursor_4c_LkpForn")
2182:                         USE IN cursor_4c_LkpForn
2183:                     ENDIF
2184:                     loc_oPg.txt_4c_Ifors.Value = ""
2185:                     loc_oPg.txt_4c_Dfors.Value = ""
2186:                     THIS.AbrirBuscaFornecedor()
2187:                 ENDIF
2188:             ENDIF
2189: 
2190:         CATCH TO loException
2191:             IF USED("cursor_4c_LkpForn")
2192:                 USE IN cursor_4c_LkpForn
2193:             ENDIF
2194:             MostrarErro("Erro ao validar fornecedor:" + CHR(13) + loException.Message, ;
2195:                 "FormProduto.ValidarIfors")
2196:         ENDTRY
2197:     ENDPROC
2198: 
2199:     *===========================================================================
2200:     * ValidarCodCors - LostFocus: valida codigo de cor (SigCdCor)
2201:     * PUBLIC: BINDEVENT requer metodo publico
2202:     *===========================================================================
2203:     PROCEDURE ValidarCodCors(par_nKeyCode, par_nShiftAltCtrl)
2204:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
2205:         TRY
2206:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2207:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodCors.Value)
2208: 
2209:             IF !EMPTY(loc_cCod)
2210:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2211:                     "SELECT cods FROM SigCdCor WHERE cods = " + EscaparSQL(loc_cCod), ;
2212:                     "cursor_4c_LkpCor")
2213: 
2214:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpCor") AND !EOF("cursor_4c_LkpCor")
2215:                     USE IN cursor_4c_LkpCor
2216:                 ELSE
2217:                     IF USED("cursor_4c_LkpCor")
2218:                         USE IN cursor_4c_LkpCor
2219:                     ENDIF
2220:                     loc_oPg.txt_4c_CodCors.Value = ""
2221:                     MsgAviso("Cor n" + CHR(227) + "o encontrada.")
2222:                 ENDIF
2223:             ENDIF
2224: 
2225:         CATCH TO loException
2226:             IF USED("cursor_4c_LkpCor")
2227:                 USE IN cursor_4c_LkpCor
2228:             ENDIF
2229:             MostrarErro("Erro ao validar cor:" + CHR(13) + loException.Message, ;
2230:                 "FormProduto.ValidarCodCors")
2231:         ENDTRY
2232:     ENDPROC
2233: 
2234:     *===========================================================================
2235:     * ValidarCodTams - LostFocus: valida codigo de tamanho (SigCdTam)
2236:     * PUBLIC: BINDEVENT requer metodo publico
2237:     *===========================================================================
2238:     PROCEDURE ValidarCodTams(par_nKeyCode, par_nShiftAltCtrl)
2239:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
2240:         TRY
2241:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2242:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodTams.Value)
2243: 
2244:             IF !EMPTY(loc_cCod)
2245:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2246:                     "SELECT cods FROM SigCdTam WHERE cods = " + EscaparSQL(loc_cCod), ;
2247:                     "cursor_4c_LkpTam")
2248: 
2249:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpTam") AND !EOF("cursor_4c_LkpTam")
2250:                     USE IN cursor_4c_LkpTam
2251:                 ELSE
2252:                     IF USED("cursor_4c_LkpTam")
2253:                         USE IN cursor_4c_LkpTam
2254:                     ENDIF
2255:                     loc_oPg.txt_4c_CodTams.Value = ""
2256:                     MsgAviso("Tamanho n" + CHR(227) + "o encontrado.")
2257:                 ENDIF
2258:             ENDIF
2259: 
2260:         CATCH TO loException
2261:             IF USED("cursor_4c_LkpTam")
2262:                 USE IN cursor_4c_LkpTam
2263:             ENDIF
2264:             MostrarErro("Erro ao validar tamanho:" + CHR(13) + loException.Message, ;
2265:                 "FormProduto.ValidarCodTams")
2266:         ENDTRY
2267:     ENDPROC
2268: 
2269:     *===========================================================================
2270:     * ValidarCodAcbs - LostFocus: valida acabamento e popula DAcbs (SigCdAca)
2271:     * PUBLIC: BINDEVENT requer metodo publico
2272:     *===========================================================================
2273:     PROCEDURE ValidarCodAcbs(par_nKeyCode, par_nShiftAltCtrl)
2274:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
2275:         TRY
2276:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2277:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodAcbs.Value)
2278: 
2279:             IF EMPTY(loc_cCod)
2280:                 loc_oPg.txt_4c_DAcbs.Value = ""
2281:             ELSE
2282:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2283:                     "SELECT descrs FROM SigCdAca WHERE cods = " + EscaparSQL(loc_cCod), ;
2284:                     "cursor_4c_LkpAcab")
2285: 
2286:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpAcab") AND !EOF("cursor_4c_LkpAcab")
2287:                     loc_oPg.txt_4c_DAcbs.Value = ALLTRIM(cursor_4c_LkpAcab.descrs)
2288:                     USE IN cursor_4c_LkpAcab
2289:                 ELSE
2290:                     IF USED("cursor_4c_LkpAcab")
2291:                         USE IN cursor_4c_LkpAcab
2292:                     ENDIF
2293:                     loc_oPg.txt_4c_CodAcbs.Value = ""
2294:                     loc_oPg.txt_4c_DAcbs.Value   = ""
2295:                     MsgAviso("Acabamento n" + CHR(227) + "o encontrado.")
2296:                 ENDIF
2297:             ENDIF
2298: 
2299:         CATCH TO loException
2300:             IF USED("cursor_4c_LkpAcab")
2301:                 USE IN cursor_4c_LkpAcab
2302:             ENDIF
2303:             MostrarErro("Erro ao validar acabamento:" + CHR(13) + loException.Message, ;
2304:                 "FormProduto.ValidarCodAcbs")
2305:         ENDTRY
2306:     ENDPROC
2307: 
2308:     *===========================================================================
2309:     * ValidarCunis - LostFocus: valida unidade e popula Dunis (SigCdUni)
2310:     * PUBLIC: BINDEVENT requer metodo publico
2311:     *===========================================================================
2312:     PROCEDURE ValidarCunis(par_nKeyCode, par_nShiftAltCtrl)
2313:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
2314:         TRY
2315:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2316:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cunis.Value)
2317: 
2318:             IF EMPTY(loc_cCod)
2319:                 loc_oPg.txt_4c_Dunis.Value = ""
2320:             ELSE
2321:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2322:                     "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(loc_cCod), ;
2323:                     "cursor_4c_LkpUni")
2324: 
2325:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpUni") AND !EOF("cursor_4c_LkpUni")
2326:                     loc_oPg.txt_4c_Dunis.Value = ALLTRIM(cursor_4c_LkpUni.dunis)
2327:                     USE IN cursor_4c_LkpUni
2328:                 ELSE
2329:                     IF USED("cursor_4c_LkpUni")
2330:                         USE IN cursor_4c_LkpUni
2331:                     ENDIF
2332:                     loc_oPg.txt_4c_Cunis.Value = ""
2333:                     loc_oPg.txt_4c_Dunis.Value = ""
2334:                     MsgAviso("Unidade n" + CHR(227) + "o encontrada.")
2335:                 ENDIF
2336:             ENDIF
2337: 
2338:         CATCH TO loException
2339:             IF USED("cursor_4c_LkpUni")
2340:                 USE IN cursor_4c_LkpUni
2341:             ENDIF
2342:             MostrarErro("Erro ao validar unidade:" + CHR(13) + loException.Message, ;
2343:                 "FormProduto.ValidarCunis")
2344:         ENDTRY
2345:     ENDPROC
2346: 
2347:     *===========================================================================
2348:     * AbrirBuscaGrupo - Abre FormBuscaAuxiliar para selecionar grupo (SigCdGrp)
2349:     * Pattern A canonico: SQL no caller, DefinirCursor, Mostrar
2350:     *===========================================================================
2351:     PROCEDURE AbrirBuscaGrupo()
2352:         LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
2353:         TRY
2354:             loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2355:             loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Cgrus.Value)
2356: 
2357:             loc_nRet = SQLEXEC(gnConnHandle, ;
2358:                 "SELECT cgrus, dgrus FROM SigCdGrp WHERE cgrus LIKE '" + ;
2359:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY cgrus", ;
2360:                 "cursor_4c_GrpBusca")
2361: 
2362:             IF loc_nRet <= 0 OR !USED("cursor_4c_GrpBusca") OR EOF("cursor_4c_GrpBusca")
2363:                 IF USED("cursor_4c_GrpBusca")
2364:                     USE IN cursor_4c_GrpBusca
2365:                 ENDIF
2366:                 SQLEXEC(gnConnHandle, "SELECT cgrus, dgrus FROM SigCdGrp ORDER BY cgrus", ;
2367:                     "cursor_4c_GrpBusca")
2368:             ENDIF
2369: 
2370:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2371:             IF VARTYPE(loc_oBusca) = "O"
2372:                 loc_oBusca.DefinirCursor("cursor_4c_GrpBusca", "cgrus", "dgrus", ;
2373:                     "Buscar Grupo de Produto")
2374:                 loc_oBusca.Mostrar()
2375: 
2376:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
2377:                     loc_oPg.txt_4c_Cgrus.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
2378:                     loc_oPg.txt_4c_Dgrus.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
2379:                 ENDIF
2380:                 loc_oBusca = .NULL.
2381:             ENDIF
2382: 
2383:             IF USED("cursor_4c_GrpBusca")
2384:                 USE IN cursor_4c_GrpBusca
2385:             ENDIF
2386: 
2387:         CATCH TO loException
2388:             IF USED("cursor_4c_GrpBusca")
2389:                 USE IN cursor_4c_GrpBusca
2390:             ENDIF
2391:             MostrarErro("Erro ao buscar grupo:" + CHR(13) + loException.Message, ;
2392:                 "FormProduto.AbrirBuscaGrupo")
2393:         ENDTRY
2394:     ENDPROC
2395: 
2396:     *===========================================================================
2397:     * AbrirBuscaFornecedor - Abre FormBuscaAuxiliar para selecionar fornecedor
2398:     * Pattern A canonico: SQL no caller, DefinirCursor, Mostrar
2399:     *===========================================================================
2400:     PROCEDURE AbrirBuscaFornecedor()
2401:         LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
2402:         TRY
2403:             loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2404:             loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Ifors.Value)
2405: 
2406:             loc_nRet = SQLEXEC(gnConnHandle, ;
2407:                 "SELECT ifors, dfors FROM SigCdFor WHERE ifors LIKE '" + ;
2408:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY dfors", ;
2409:                 "cursor_4c_FornBusca")
2410: 
2411:             IF loc_nRet <= 0 OR !USED("cursor_4c_FornBusca") OR EOF("cursor_4c_FornBusca")
2412:                 IF USED("cursor_4c_FornBusca")
2413:                     USE IN cursor_4c_FornBusca
2414:                 ENDIF
2415:                 SQLEXEC(gnConnHandle, "SELECT ifors, dfors FROM SigCdFor ORDER BY dfors", ;
2416:                     "cursor_4c_FornBusca")
2417:             ENDIF
2418: 
2419:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2420:             IF VARTYPE(loc_oBusca) = "O"
2421:                 loc_oBusca.DefinirCursor("cursor_4c_FornBusca", "ifors", "dfors", ;
2422:                     "Buscar Fornecedor")
2423:                 loc_oBusca.Mostrar()
2424: 
2425:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
2426:                     loc_oPg.txt_4c_Ifors.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
2427:                     loc_oPg.txt_4c_Dfors.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
2428:                 ENDIF
2429:                 loc_oBusca = .NULL.
2430:             ENDIF
2431: 
2432:             IF USED("cursor_4c_FornBusca")
2433:                 USE IN cursor_4c_FornBusca
2434:             ENDIF
2435: 
2436:         CATCH TO loException
2437:             IF USED("cursor_4c_FornBusca")
2438:                 USE IN cursor_4c_FornBusca
2439:             ENDIF
2440:             MostrarErro("Erro ao buscar fornecedor:" + CHR(13) + loException.Message, ;
2441:                 "FormProduto.AbrirBuscaFornecedor")
2442:         ENDTRY
2443:     ENDPROC
2444: 
2445: ENDDEFINE

