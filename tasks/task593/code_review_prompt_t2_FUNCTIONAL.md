# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (7)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [GRID-HEADER] Header Caption 'Descrição' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Produto, Qtde. Máx., Tam, Cor, Departamento, Emp, Qtde. Máxima, Tamanho. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Fornecedor' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Produto, Qtde. Máx., Tam, Cor, Departamento, Emp, Qtde. Máxima, Tamanho. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Referência' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Produto, Qtde. Máx., Tam, Cor, Departamento, Emp, Qtde. Máxima, Tamanho. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Sub Grp' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Produto, Qtde. Máx., Tam, Cor, Departamento, Emp, Qtde. Máxima, Tamanho. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'Opc_situacao' (parent: SIGPRCOM.Pagina.Dados): Top original=100 vs migrado 'obj_4c_Opc_situacao' Top=140 (diff=40px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'btnExcluir' (parent: SIGPRCOM.Pagina.Dados): Top original=385 vs migrado 'cmd_4c_BtnExcluir' Top=425 (diff=40px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigprcom.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1953 linhas total):

*-- Linhas 26 a 168:
26:     this_nTipoEstos           = 0
27:     this_lTemCor              = .F.
28:     this_lTemTam              = .F.
29:     this_cUltimoProdutoValid  = ""
30:     this_cUltimoDescProdValid = ""
31: 
32:     *===========================================================================
33:     * Init - Inicializa o formulario
34:     * REGRA CRITICA: Apenas RETURN DODEFAULT()
35:     * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
36:     *===========================================================================
37:     PROCEDURE Init()
38:         RETURN DODEFAULT()
39:     ENDPROC
40: 
41:     *===========================================================================
42:     * InicializarForm - Configura estrutura completa
43:     * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
44:     *===========================================================================
45:     PROTECTED PROCEDURE InicializarForm()
46:         LOCAL loc_lSucesso
47:         loc_lSucesso = .F.
48: 
49:         TRY
50:             THIS.this_oBusinessObject = CREATEOBJECT("sigprcomBO")
51: 
52:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
53:                 MostrarErro("Erro ao criar sigprcomBO" + CHR(13) + ;
54:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
55:                     "Formsigprcom.InicializarForm")
56:             ELSE
57:                 THIS.ConfigurarPageFrame()
58:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
59:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
60:                 THIS.pgf_4c_Paginas.Visible = .T.
61:                 THIS.pgf_4c_Paginas.ActivePage = 1
62:                 THIS.this_cModoAtual = "LISTA"
63: 
64:                 *-- Legado: o Init monta CrProdutos e liga na Grade da Lista, ou
65:                 *-- seja a tela ABRE com a lista preenchida. CarregarLista ja tem
66:                 *-- a guarda de gb_4c_ValidandoUI (sem conexao SQL).
67:                 THIS.CarregarLista()
68:                 THIS.AjustarBotoesPorModo()
69: 
70:                 loc_lSucesso = .T.
71:             ENDIF
72: 
73:         CATCH TO loException
74:             MostrarErro("Erro ao inicializar Formsigprcom:" + CHR(13) + ;
75:                 loException.Message + CHR(13) + ;
76:                 "Linha: " + TRANSFORM(loException.LineNo), ;
77:                 "Formsigprcom.InicializarForm")
78:         ENDTRY
79: 
80:         RETURN loc_lSucesso
81:     ENDPROC
82: 
83:     *===========================================================================
84:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
85:     * Top=-29 para esconder abas; controles compensam +29 no Top
86:     *===========================================================================
87:     PROTECTED PROCEDURE ConfigurarPageFrame()
88:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
89: 
90:         WITH THIS.pgf_4c_Paginas
91:             .PageCount = 2
92:             .Top       = -29
93:             .Left      = 0
94:             .Width     = THIS.Width
95:             .Height    = THIS.Height + 29
96:             .Tabs      = .F.
97:             .Visible   = .T.
98: 
99:             .Page1.Caption   = "Lista"
100:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
101:             .Page1.BackColor = RGB(255, 255, 255)
102: 
103:             .Page2.Caption   = "Dados"
104:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
105:             .Page2.BackColor = RGB(255, 255, 255)
106:         ENDWITH
107: 
108:         THIS.ConfigurarPaginaLista()
109:         THIS.ConfigurarPaginaDados()
110:     ENDPROC
111: 
112:     *===========================================================================
113:     * ConfigurarPaginaLista - Page1 (Lista): estrutura base
114:     * Fase 3: containers vazios (cabecalho + botoes)
115:     * Fase 4: Grid e botoes CRUD serao adicionados dentro destes containers
116:     *===========================================================================
117:     PROTECTED PROCEDURE ConfigurarPaginaLista()
118:         LOCAL loc_oPagina, loc_oCnt, loc_oGrid
119:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
120: 
121:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
122: 
123:         *-- Container Cabecalho (cntSombra no legado)
124:         *-- Original: Top=1. Com compensacao +29: Top=31
125:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
126:         WITH loc_oPagina.cnt_4c_Cabecalho
127:             .Top         = 31
128:             .Left        = 0
129:             .Width       = THIS.Width
130:             .Height      = 80
131:             .BackColor   = RGB(100, 100, 100)
132:             .BorderWidth = 0
133:             .Visible     = .T.
134:         ENDWITH
135: 
136:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
137:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
138:             .Caption   = THIS.Caption
139:             .Top       = 15
140:             .Left      = 10
141:             .Width     = 769
142:             .Height    = 40
143:             .FontName  = "Tahoma"
144:             .FontSize  = 16
145:             .FontBold  = .T.
146:             .ForeColor = RGB(0, 0, 0)
147:             .BackStyle = 0
148:             .AutoSize  = .F.
149:             .Visible   = .T.
150:         ENDWITH
151: 
152:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
153:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
154:             .Caption   = THIS.Caption
155:             .Top       = 18
156:             .Left      = 10
157:             .Width     = 769
158:             .Height    = 46
159:             .FontName  = "Tahoma"
160:             .FontSize  = 16
161:             .FontBold  = .T.
162:             .ForeColor = RGB(255, 255, 255)
163:             .BackStyle = 0
164:             .AutoSize  = .F.
165:             .Visible   = .T.
166:         ENDWITH
167: 
168:         *-- Container Botoes CRUD (Grupo_Op no legado)

*-- Linhas 200 a 412:
200:             .WordWrap        = .T.
201:             .AutoSize        = .F.
202:         ENDWITH
203:         BINDEVENT(loc_oCnt.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
204: 
205:         loc_oCnt.AddObject("cmd_4c_Visualizar", "CommandButton")
206:         WITH loc_oCnt.cmd_4c_Visualizar
207:             .Caption         = "Visualizar"
208:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
209:             .PicturePosition = 13
210:             .Top             = 5
211:             .Left            = 80
212:             .Width           = 75
213:             .Height          = 75
214:             .FontName        = "Comic Sans MS"
215:             .FontSize        = 8
216:             .FontBold        = .T.
217:             .FontItalic      = .T.
218:             .ForeColor       = RGB(90, 90, 90)
219:             .BackColor       = RGB(255, 255, 255)
220:             .Themes          = .F.
221:             .SpecialEffect   = 0
222:             .MousePointer    = 15
223:             .WordWrap        = .T.
224:             .AutoSize        = .F.
225:         ENDWITH
226:         BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
227: 
228:         loc_oCnt.AddObject("cmd_4c_Alterar", "CommandButton")
229:         WITH loc_oCnt.cmd_4c_Alterar
230:             .Caption         = "Alterar"
231:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
232:             .PicturePosition = 13
233:             .Top             = 5
234:             .Left            = 155
235:             .Width           = 75
236:             .Height          = 75
237:             .FontName        = "Comic Sans MS"
238:             .FontSize        = 8
239:             .FontBold        = .T.
240:             .FontItalic      = .T.
241:             .ForeColor       = RGB(90, 90, 90)
242:             .BackColor       = RGB(255, 255, 255)
243:             .Themes          = .F.
244:             .SpecialEffect   = 0
245:             .MousePointer    = 15
246:             .WordWrap        = .T.
247:             .AutoSize        = .F.
248:         ENDWITH
249:         BINDEVENT(loc_oCnt.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
250: 
251:         loc_oCnt.AddObject("cmd_4c_Excluir", "CommandButton")
252:         WITH loc_oCnt.cmd_4c_Excluir
253:             .Caption         = "Excluir"
254:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
255:             .PicturePosition = 13
256:             .Top             = 5
257:             .Left            = 230
258:             .Width           = 75
259:             .Height          = 75
260:             .FontName        = "Comic Sans MS"
261:             .FontSize        = 8
262:             .FontBold        = .T.
263:             .FontItalic      = .T.
264:             .ForeColor       = RGB(90, 90, 90)
265:             .BackColor       = RGB(255, 255, 255)
266:             .Themes          = .F.
267:             .SpecialEffect   = 0
268:             .MousePointer    = 15
269:             .WordWrap        = .T.
270:             .AutoSize        = .F.
271:         ENDWITH
272:         BINDEVENT(loc_oCnt.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
273: 
274:         loc_oCnt.AddObject("cmd_4c_Buscar", "CommandButton")
275:         WITH loc_oCnt.cmd_4c_Buscar
276:             .Caption         = "Buscar"
277:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
278:             .PicturePosition = 13
279:             .Top             = 5
280:             .Left            = 305
281:             .Width           = 75
282:             .Height          = 75
283:             .FontName        = "Comic Sans MS"
284:             .FontSize        = 8
285:             .FontBold        = .T.
286:             .FontItalic      = .T.
287:             .ForeColor       = RGB(90, 90, 90)
288:             .BackColor       = RGB(255, 255, 255)
289:             .Themes          = .F.
290:             .SpecialEffect   = 0
291:             .MousePointer    = 15
292:             .WordWrap        = .T.
293:             .AutoSize        = .F.
294:         ENDWITH
295:         BINDEVENT(loc_oCnt.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
296: 
297:         *-- Container Saida (canonico: Left=917, Width=90) - flutuante/transparente
298:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
299:         WITH loc_oPagina.cnt_4c_Saida
300:             .Top         = 29
301:             .Left        = 917
302:             .Width       = 90
303:             .Height      = 85
304:             .BackStyle   = 0
305:             .BorderWidth = 0
306:             .Visible     = .T.
307:         ENDWITH
308:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
309:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
310:             .Caption         = "Encerrar"
311:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
312:             .PicturePosition = 13
313:             .Top             = 5
314:             .Left            = 5
315:             .Width           = 75
316:             .Height          = 75
317:             .FontName        = "Comic Sans MS"
318:             .FontSize        = 8
319:             .FontBold        = .T.
320:             .FontItalic      = .T.
321:             .ForeColor       = RGB(90, 90, 90)
322:             .BackColor       = RGB(255, 255, 255)
323:             .Themes          = .F.
324:             .SpecialEffect   = 0
325:             .MousePointer    = 15
326:             .WordWrap        = .T.
327:             .AutoSize        = .F.
328:         ENDWITH
329:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
330: 
331:         *-- Grid de Lista (Grade no legado) - lista de Produtos com registro em SigCdMax
332:         *-- Legado: AddCursor('SigCdMax','cpros','CrProdutos',...) + pColuna(cpros/dpros/ifors/reffs/sgrus)
333:         *-- Top compensado: 102+29=131
334:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
335:         loc_oGrid = loc_oPagina.grd_4c_Lista
336:         loc_oGrid.Top                = 131
337:         loc_oGrid.Left               = 14
338:         loc_oGrid.Width              = 971
339:         loc_oGrid.Height             = 553
340:         loc_oGrid.ColumnCount        = 5
341:         loc_oGrid.FontName           = "Tahoma"
342:         loc_oGrid.FontSize           = 8
343:         loc_oGrid.ForeColor          = RGB(90, 90, 90)
344:         loc_oGrid.BackColor          = RGB(255, 255, 255)
345:         loc_oGrid.GridLineColor      = RGB(238, 238, 238)
346:         loc_oGrid.HighlightBackColor = RGB(255, 255, 255)
347:         loc_oGrid.HighlightForeColor = RGB(15, 41, 104)
348:         loc_oGrid.HighlightStyle     = 2
349:         loc_oGrid.DeleteMark         = .F.
350:         loc_oGrid.RecordMark         = .F.
351:         loc_oGrid.RowHeight          = 16
352:         loc_oGrid.ScrollBars         = 2
353:         loc_oGrid.GridLines          = 3
354:         loc_oGrid.ReadOnly           = .T.
355:         WITH loc_oGrid
356:             .Column1.Width = 108
357:             .Column2.Width = 285
358:             .Column3.Width = 75
359:             .Column4.Width = 150
360:             .Column5.Width = 45
361:         ENDWITH
362: 
363:         THIS.TornarControlesVisiveis(loc_oPagina)
364:     ENDPROC
365: 
366:     *===========================================================================
367:     * ConfigurarPaginaDados - Page2 (Dados): estrutura base
368:     * Fase 3: containers vazios (cabecalho + botoes de acao)
369:     * Fases 5-6: campos de dados serao adicionados (get_produto, getDpro, getCgru,
370:     * getDgru, getIfor, getDfor, getRefs, Opc_situacao, gradei, btnExcluir)
371:     *===========================================================================
372:     PROTECTED PROCEDURE ConfigurarPaginaDados()
373:         LOCAL loc_oPagina, loc_oGridItens, loc_oCntAcao
374:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
375: 
376:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
377: 
378:         *-- Cabecalho cinza (identico ao da pagina Lista) - CLAUDE.md regra #11
379:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
380:         WITH loc_oPagina.cnt_4c_Cabecalho
381:             .Top           = 29
382:             .Left          = 0
383:             .Width         = THIS.Width
384:             .Height        = 80
385:             .BackColor     = RGB(100, 100, 100)
386:             .BorderWidth   = 0
387:             .SpecialEffect = 0
388:             .Visible       = .T.
389: 
390:             .AddObject("lbl_4c_Sombra", "Label")
391:             WITH .lbl_4c_Sombra
392:                 .Caption   = THIS.Caption
393:                 .Top       = 15
394:                 .Left      = 10
395:                 .Width     = THIS.Width
396:                 .Height    = 40
397:                 .FontName  = "Tahoma"
398:                 .FontSize  = 16
399:                 .FontBold  = .T.
400:                 .ForeColor = RGB(0, 0, 0)
401:                 .BackStyle = 0
402:                 .AutoSize  = .F.
403:                 .Visible   = .T.
404:             ENDWITH
405: 
406:             .AddObject("lbl_4c_Titulo", "Label")
407:             WITH .lbl_4c_Titulo
408:                 .Caption   = THIS.Caption
409:                 .Top       = 18
410:                 .Left      = 10
411:                 .Width     = THIS.Width
412:                 .Height    = 46

*-- Linhas 434 a 454:
434:             .Visible     = .T.
435:         ENDWITH
436: 
437:         *-- Campos principais (FASE 5 - Parte 1): Produto / Grupo / Situacao
438:         *-- Legado (SIGPRCOM.SCX): tops crus 75-105, compensados +29 (PageFrame.Top=-29)
439:         *-- + 11px de re-layout (regra CLAUDE.md #11) para nao colidir com cnt_4c_Cabecalho
440:         *-- (Top=29, Height=80, ocupa ate 109) -> shift total de 40
441: 
442:         *-- Say1 "Produto :"
443:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
444:         WITH loc_oPagina.lbl_4c_Label1
445:             .Caption   = "Produto :"
446:             .Top       = 119
447:             .Left      = 260
448:             .Width     = 47
449:             .Height    = 15
450:             .Alignment = 0
451:             .BackStyle = 0
452:             .AutoSize  = .F.
453:             .FontName  = "Tahoma"
454:             .FontSize  = 8

*-- Linhas 540 a 642:
540:             .Visible     = .T.
541:         ENDWITH
542: 
543:         *-- Say19 "Situacao : " (espaco antes do OptionGroup eh de apenas 50px - label estreita)
544:         loc_oPagina.AddObject("lbl_4c_Label19", "Label")
545:         WITH loc_oPagina.lbl_4c_Label19
546:             .Caption   = "Situa" + CHR(231) + CHR(227) + "o : "
547:             .Top       = 145
548:             .Left      = 505
549:             .Width     = 50
550:             .Height    = 15
551:             .Alignment = 0
552:             .BackStyle = 0
553:             .AutoSize  = .F.
554:             .FontName  = "Tahoma"
555:             .FontSize  = 8
556:             .ForeColor = RGB(90, 90, 90)
557:             .Visible   = .T.
558:         ENDWITH
559: 
560:         *-- Opc_situacao - OptionGroup (SigCdPro.situas numeric(1,0): 1=Ativo, 2=Inativo)
561:         loc_oPagina.AddObject("obj_4c_Opc_situacao", "OptionGroup")
562:         WITH loc_oPagina.obj_4c_Opc_situacao
563:             .Top         = 140
564:             .Left        = 555
565:             .Width       = 127
566:             .Height      = 25
567:             .ButtonCount = 2
568:             .BackStyle   = 0
569:             .BorderStyle = 0
570:             .Value       = 1
571:             .Visible     = .T.
572:         ENDWITH
573:         WITH loc_oPagina.obj_4c_Opc_situacao.Buttons(1)
574:             .Caption   = "Ativo"
575:             .BackStyle = 0
576:             .Left      = 2
577:             .Top       = 2
578:             .Width     = 55
579:             .AutoSize  = .T.
580:             .FontName  = "Tahoma"
581:             .FontSize  = 8
582:             .ForeColor = RGB(90, 90, 90)
583:             .Themes    = .F.
584:         ENDWITH
585:         WITH loc_oPagina.obj_4c_Opc_situacao.Buttons(2)
586:             .Caption   = "Inativo"
587:             .BackStyle = 0
588:             .Left      = 59
589:             .Top       = 2
590:             .Width     = 58
591:             .AutoSize  = .T.
592:             .FontName  = "Tahoma"
593:             .FontSize  = 8
594:             .ForeColor = RGB(90, 90, 90)
595:             .Themes    = .F.
596:         ENDWITH
597: 
598:         *-- BINDEVENT lookup Produto (codigo <-> descricao) - legado: get_produto.Valid / getDpro.Valid
599:         BINDEVENT(loc_oPagina.txt_4c__Produto, "KeyPress", THIS, "ProdutoLostFocus")
600:         BINDEVENT(loc_oPagina.txt_4c__Produto, "DblClick", THIS, "ProdutoDblClick")
601:         BINDEVENT(loc_oPagina.txt_4c_Dpro, "KeyPress", THIS, "DescricaoProdutoLostFocus")
602:         BINDEVENT(loc_oPagina.txt_4c_Dpro, "DblClick", THIS, "DescricaoProdutoDblClick")
603: 
604:         *-- Say11 "Fornecedor :"
605:         loc_oPagina.AddObject("lbl_4c_Label11", "Label")
606:         WITH loc_oPagina.lbl_4c_Label11
607:             .Caption   = "Fornecedor :"
608:             .Top       = 170
609:             .Left      = 243
610:             .Width     = 64
611:             .Height    = 15
612:             .Alignment = 0
613:             .BackStyle = 0
614:             .AutoSize  = .F.
615:             .FontName  = "Tahoma"
616:             .FontSize  = 8
617:             .ForeColor = RGB(90, 90, 90)
618:             .Visible   = .T.
619:         ENDWITH
620: 
621:         *-- getIfor - Codigo do Fornecedor (SigCdCli.iclis char(10)) - preenchido automaticamente
622:         *-- pelo Produto selecionado (legado: Enabled=.F., plprocurar=.T. - so digitavel em modo PROCURAR)
623:         loc_oPagina.AddObject("txt_4c_Ifor", "TextBox")
624:         WITH loc_oPagina.txt_4c_Ifor
625:             .Top         = 167
626:             .Left        = 309
627:             .Width       = 80
628:             .Height      = 23
629:             .MaxLength   = 10
630:             .Value       = ""
631:             .ReadOnly    = .T.
632:             .FontName    = "Tahoma"
633:             .FontSize    = 8
634:             .ForeColor   = RGB(0, 0, 0)
635:             .BackColor   = RGB(255, 255, 220)
636:             .Visible     = .T.
637:         ENDWITH
638: 
639:         *-- getDfor - Descricao/Razao do Fornecedor (SigCdCli.rclis) - sempre readonly (legado: When retorna .F.)
640:         loc_oPagina.AddObject("txt_4c_Dfor", "TextBox")
641:         WITH loc_oPagina.txt_4c_Dfor
642:             .Top         = 167

*-- Linhas 687 a 748:
687:             .BackColor   = RGB(255, 255, 220)
688:             .Visible     = .T.
689:         ENDWITH
690: 
691:         *-- btnExcluir - Exclui (da lista local) todos os itens da Empresa da linha corrente
692:         loc_oPagina.AddObject("cmd_4c_BtnExcluir", "CommandButton")
693:         WITH loc_oPagina.cmd_4c_BtnExcluir
694:             .Top             = 425
695:             .Left            = 700
696:             .Width           = 40
697:             .Height          = 40
698:             .Caption         = ""
699:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
700:             .ToolTipText     = "Exclui os itens da Empresa selecionada"
701:             .FontName        = "Verdana"
702:             .FontSize        = 8
703:             .ForeColor       = RGB(36, 84, 155)
704:             .BackColor       = RGB(255, 255, 255)
705:             .Themes          = .F.
706:             .Visible         = .T.
707:         ENDWITH
708:         BINDEVENT(loc_oPagina.cmd_4c_BtnExcluir, "Click", THIS, "BtnExcluirItemClick")
709: 
710:         *-- Cursor placeholder da grade de itens (deve existir ANTES do Grid.Init - regra #41)
711:         *-- cidchaves NAO tem coluna na grade: carrega a PK da linha JA gravada em
712:         *-- SigCdMax, para o Confirmar saber se cada linha eh INSERT (chave vazia)
713:         *-- ou UPDATE (chave preenchida). Sem isso, ALTERAR reinseria tudo.
714:         IF USED("cursor_4c_Itens")
715:             USE IN cursor_4c_Itens
716:         ENDIF
717:         SET NULL ON
718:         CREATE CURSOR cursor_4c_Itens ;
719:             (cidchaves C(20), cpros C(14), emps C(3), qmaxs N(7,2), codtams C(4), codcores C(4), deptos C(10))
720:         SET NULL OFF
721: 
722:         *-- gradei - Grade de Itens (Empresa/Qtde.Maxima/Tamanho/Cor/Departamento) do Produto selecionado
723:         loc_oPagina.AddObject("grd_4c_Itens", "Grid")
724:         loc_oGridItens                    = loc_oPagina.grd_4c_Itens
725:         loc_oGridItens.Top                = 221
726:         loc_oGridItens.Left               = 309
727:         loc_oGridItens.Width              = 387
728:         loc_oGridItens.Height             = 472
729:         loc_oGridItens.ColumnCount = 5
730:         loc_oGridItens.RecordSource       = "cursor_4c_Itens"
731:         loc_oGridItens.ColumnCount        = 5
732:         loc_oGridItens.Column1.ControlSource = "cursor_4c_Itens.emps"
733:         loc_oGridItens.Column2.ControlSource = "cursor_4c_Itens.qmaxs"
734:         loc_oGridItens.Column3.ControlSource = "cursor_4c_Itens.codtams"
735:         loc_oGridItens.Column4.ControlSource = "cursor_4c_Itens.codcores"
736:         loc_oGridItens.Column5.ControlSource = "cursor_4c_Itens.deptos"
737:         loc_oGridItens.Column1.Width       = 50
738:         loc_oGridItens.Column2.Width       = 100
739:         loc_oGridItens.Column3.Width       = 90
740:         loc_oGridItens.Column4.Width       = 90
741:         loc_oGridItens.Column5.Width       = 57
742:         loc_oGridItens.Column1.Header1.Caption = "Emp"
743:         loc_oGridItens.Column2.Header1.Caption = "Qtde. M" + CHR(225) + "xima"
744:         loc_oGridItens.Column3.Header1.Caption = "Tamanho"
745:         loc_oGridItens.Column4.Header1.Caption = "Cor"
746:         loc_oGridItens.Column5.Header1.Caption = "Departamento"
747:         loc_oGridItens.Column1.Text1.MaxLength = 3
748:         loc_oGridItens.Column1.Text1.Format    = "!"

*-- Linhas 761 a 866:
761:         loc_oGridItens.DeleteMark          = .F.
762:         loc_oGridItens.ScrollBars          = 2
763:         loc_oGridItens.GridLines           = 3
764:         BINDEVENT(loc_oGridItens, "AfterRowColChange", THIS, "GradeItensAfterRowColChange")
765:         BINDEVENT(loc_oGridItens.Column1.Text1, "KeyPress", THIS, "GradeItensEmpresaLostFocus")
766:         BINDEVENT(loc_oGridItens.Column3.Text1, "KeyPress", THIS, "GradeItensTamanhoLostFocus")
767:         BINDEVENT(loc_oGridItens.Column4.Text1, "KeyPress", THIS, "GradeItensCorLostFocus")
768:         BINDEVENT(loc_oGridItens.Column5.Text1, "KeyPress", THIS, "GradeItensDepartamentoLostFocus")
769: 
770:         *-- Container BotoesAcao (Grupo_Salva no legado) - Confirmar/Cancelar
771:         loc_oCntAcao = loc_oPagina.cnt_4c_BotoesAcao
772:         loc_oCntAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
773:         WITH loc_oCntAcao.cmd_4c_Confirmar
774:             .Caption         = "Confirmar"
775:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
776:             .PicturePosition = 13
777:             .Top             = 5
778:             .Left            = 5
779:             .Width           = 75
780:             .Height          = 75
781:             .FontName        = "Comic Sans MS"
782:             .FontSize        = 8
783:             .FontBold        = .T.
784:             .FontItalic      = .T.
785:             .ForeColor       = RGB(90, 90, 90)
786:             .BackColor       = RGB(255, 255, 255)
787:             .Themes          = .F.
788:             .SpecialEffect   = 0
789:             .MousePointer    = 15
790:             .WordWrap        = .T.
791:             .AutoSize        = .F.
792:         ENDWITH
793:         BINDEVENT(loc_oCntAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
794: 
795:         loc_oCntAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
796:         WITH loc_oCntAcao.cmd_4c_Cancelar
797:             .Caption         = "Encerrar"
798:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
799:             .PicturePosition = 13
800:             .Top             = 5
801:             .Left            = 80
802:             .Width           = 75
803:             .Height          = 75
804:             .FontName        = "Comic Sans MS"
805:             .FontSize        = 8
806:             .FontBold        = .T.
807:             .FontItalic      = .T.
808:             .ForeColor       = RGB(90, 90, 90)
809:             .BackColor       = RGB(255, 255, 255)
810:             .Themes          = .F.
811:             .SpecialEffect   = 0
812:             .MousePointer    = 15
813:             .WordWrap        = .T.
814:             .AutoSize        = .F.
815:         ENDWITH
816:         BINDEVENT(loc_oCntAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
817: 
818:         THIS.TornarControlesVisiveis(loc_oPagina)
819:     ENDPROC
820: 
821:     *===========================================================================
822:     * CarregarLista - Carrega na grade os Produtos com registro em SigCdMax
823:     * Legado: AddCursor('SigCdMax','cpros','CrProdutos',...) + pColuna
824:     *   (cpros=Produto, dpros=Descricao, ifors=Fornecedor, reffs=Referencia, sgrus=Sub Grp)
825:     *===========================================================================
826:     PROCEDURE CarregarLista()
827:         LOCAL loc_lResultado, loc_oGrid
828:         loc_lResultado = .F.
829: 
830:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
831:             IF USED("cursor_4c_Lista")
832:                 USE IN cursor_4c_Lista
833:             ENDIF
834:             SET NULL ON
835:             CREATE CURSOR cursor_4c_Lista ;
836:                 (cpros C(14), dpros C(40), ifors C(10), reffs C(20), sgrus C(6))
837:             SET NULL OFF
838:             RETURN .T.
839:         ENDIF
840: 
841:         TRY
842:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
843: 
844:             IF THIS.this_oBusinessObject.Buscar("")
845:                 loc_oGrid.ColumnCount            = 5
846:                 loc_oGrid.RecordSource            = "cursor_4c_Lista"
847:                 loc_oGrid.Column1.ControlSource   = "cursor_4c_Lista.cpros"
848:                 loc_oGrid.Column2.ControlSource   = "cursor_4c_Lista.dpros"
849:                 loc_oGrid.Column3.ControlSource   = "cursor_4c_Lista.ifors"
850:                 loc_oGrid.Column4.ControlSource   = "cursor_4c_Lista.reffs"
851:                 loc_oGrid.Column5.ControlSource   = "cursor_4c_Lista.sgrus"
852: 
853:                 *-- Reconfigurar cabecalhos APOS RecordSource (obrigatorio)
854:                 loc_oGrid.Column1.Header1.Caption = "Produto"
855:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
856:                 loc_oGrid.Column3.Header1.Caption = "Fornecedor"
857:                 loc_oGrid.Column4.Header1.Caption = "Refer" + CHR(234) + "ncia"
858:                 loc_oGrid.Column5.Header1.Caption = "Sub Grp"
859: 
860:                 loc_oGrid.Column1.Width = 108
861:                 loc_oGrid.Column2.Width = 285
862:                 loc_oGrid.Column3.Width = 75
863:                 loc_oGrid.Column4.Width = 150
864:                 loc_oGrid.Column5.Width = 45
865: 
866:                 THIS.FormatarGridLista(loc_oGrid)

*-- Linhas 877 a 1953:
877:     *===========================================================================
878:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
879:     *===========================================================================
880:     PROCEDURE AlternarPagina(par_nPagina)
881:         LOCAL loc_lResultado
882:         loc_lResultado = .F.
883: 
884:         TRY
885:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
886:                 MsgErro("Parametro inv" + CHR(225) + "lido em AlternarPagina: " + TRANSFORM(par_nPagina), "Erro")
887:             ELSE
888:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
889:                 IF par_nPagina = 1
890:                     THIS.this_cModoAtual = "LISTA"
891:                     THIS.CarregarLista()
892:                 ENDIF
893:                 *-- Quem DESABILITA botao tem de REABILITAR no funil de volta:
894:                 *-- Confirmar/Cancelar chamam AlternarPagina(1), e eh aqui - com o
895:                 *-- modo JA normalizado para "LISTA" acima - que os botoes CRUD
896:                 *-- voltam a ficar clicaveis (CLAUDE.md regra #40)
897:                 THIS.AjustarBotoesPorModo()
898:                 loc_lResultado = .T.
899:             ENDIF
900:         CATCH TO loc_oErro
901:             MsgErro(loc_oErro.Message, "AlternarPagina")
902:         ENDTRY
903: 
904:         RETURN loc_lResultado
905:     ENDPROC
906: 
907:     *===========================================================================
908:     * BtnIncluirClick - Prepara a Page2 para cadastrar um NOVO Produto no
909:     * Estoque Maximo (o codigo eh escolhido pelo usuario via lookup de Produto)
910:     * Legado: Grupo_Op.Click(1) + DoDefault() (framework) limpa a ficha e navega
911:     *===========================================================================
912:     PROCEDURE BtnIncluirClick()
913:         THIS.this_oBusinessObject.NovoRegistro()
914:         THIS.LimparDadosProduto()
915:         THIS.this_cModoAtual = "INCLUIR"
916: 
917:         THIS.pgf_4c_Paginas.Page2.txt_4c__Produto.ReadOnly = .F.
918:         THIS.pgf_4c_Paginas.Page2.txt_4c_Dpro.ReadOnly     = .F.
919:         THIS.HabilitarCampos(.T.)
920: 
921:         THIS.AlternarPagina(2)
922:         THIS.pgf_4c_Paginas.Page2.txt_4c__Produto.SetFocus()
923:     ENDPROC
924: 
925:     *===========================================================================
926:     * BtnAlterarClick - Carrega o Produto selecionado na Lista (Page1) com os
927:     * itens JA GRAVADOS em SigCdMax para edicao na grade (Page2)
928:     *===========================================================================
929:     PROCEDURE BtnAlterarClick()
930:         LOCAL loc_cCodigo
931:         loc_cCodigo = ""
932: 
933:         IF !USED("cursor_4c_Lista") OR EOF("cursor_4c_Lista")
934:             MsgAviso("Selecione um Produto na lista !!!")
935:             RETURN
936:         ENDIF
937: 
938:         loc_cCodigo = ALLTRIM(cursor_4c_Lista.cpros)
939: 
940:         THIS.this_oBusinessObject.NovoRegistro()
941:         THIS.LimparDadosProduto()
942:         THIS.this_cModoAtual = "ALTERAR"
943: 
944:         IF THIS.CarregarItensExistentesProduto(loc_cCodigo)
945:             THIS.pgf_4c_Paginas.Page2.txt_4c__Produto.ReadOnly = .T.
946:             THIS.pgf_4c_Paginas.Page2.txt_4c_Dpro.ReadOnly     = .T.
947:             THIS.HabilitarCampos(.T.)
948:             THIS.AlternarPagina(2)
949:         ELSE
950:             THIS.this_cModoAtual = "LISTA"
951:         ENDIF
952:     ENDPROC
953: 
954:     *===========================================================================
955:     * BtnVisualizarClick - Mesma carga do Alterar, porem SOMENTE LEITURA
956:     *===========================================================================
957:     PROCEDURE BtnVisualizarClick()
958:         LOCAL loc_cCodigo
959:         loc_cCodigo = ""
960: 
961:         IF !USED("cursor_4c_Lista") OR EOF("cursor_4c_Lista")
962:             MsgAviso("Selecione um Produto na lista !!!")
963:             RETURN
964:         ENDIF
965: 
966:         loc_cCodigo = ALLTRIM(cursor_4c_Lista.cpros)
967: 
968:         THIS.this_oBusinessObject.NovoRegistro()
969:         THIS.LimparDadosProduto()
970:         THIS.this_cModoAtual = "VISUALIZAR"
971: 
972:         IF THIS.CarregarItensExistentesProduto(loc_cCodigo)
973:             THIS.pgf_4c_Paginas.Page2.txt_4c__Produto.ReadOnly = .T.
974:             THIS.pgf_4c_Paginas.Page2.txt_4c_Dpro.ReadOnly     = .T.
975:             THIS.HabilitarCampos(.F.)
976:             THIS.AlternarPagina(2)
977:         ELSE
978:             THIS.this_cModoAtual = "LISTA"
979:         ENDIF
980:     ENDPROC
981: 
982:     *===========================================================================
983:     * BtnExcluirClick - Exclui de SigCdMax TODOS os registros do Produto
984:     * selecionado na Lista (Page1). Legado: btnExcluir(Grupo_Op, Opcao=Excluir)
985:     *===========================================================================
986:     PROCEDURE BtnExcluirClick()
987:         LOCAL loc_cCodigo, loc_cDescricao, loc_cSQL, loc_nResultado, loc_lConfirmou
988: 
989:         IF !USED("cursor_4c_Lista") OR EOF("cursor_4c_Lista")
990:             MsgAviso("Selecione um Produto na lista !!!")
991:             RETURN
992:         ENDIF
993: 
994:         loc_cCodigo    = ALLTRIM(cursor_4c_Lista.cpros)
995:         loc_cDescricao = ALLTRIM(TratarNulo(cursor_4c_Lista.dpros, ""))
996: 
997:         loc_lConfirmou = MsgConfirma("Confirma a exclus" + CHR(227) + "o do Estoque M" + CHR(225) + "ximo do Produto " + ;
998:             loc_cCodigo + " - " + loc_cDescricao + " ?", "Confirmar Exclus" + CHR(227) + "o")
999: 
1000:         IF loc_lConfirmou
1001:             TRY
1002:                 loc_cSQL = "DELETE FROM SigCdMax WHERE cpros = " + EscaparSQL(loc_cCodigo)
1003:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
1004: 
1005:                 IF loc_nResultado >= 0
1006:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Confirmar")
1007:                     THIS.CarregarLista()
1008:                 ELSE
1009:                     MsgErro("Erro ao excluir:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1010:                 ENDIF
1011:             CATCH TO loc_oErro
1012:                 MsgErro(loc_oErro.Message, "BtnExcluirClick")
1013:             ENDTRY
1014:         ENDIF
1015:     ENDPROC
1016: 
1017:     *===========================================================================
1018:     * BtnBuscarClick - Coloca o form em modo BUSCAR (busca por exemplo).
1019:     * Legado: msv_procurar - NAO abre picker; limpa a ficha, habilita SO os
1020:     * campos plprocurar (Produto/Descricao/Fornecedor/Referencia), navega
1021:     * para a Pagina de Dados e quem executa a consulta eh o Confirmar.
1022:     *===========================================================================
1023:     PROCEDURE BtnBuscarClick()
1024:         LOCAL loc_oPagina
1025:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1026: 
1027:         THIS.LimparDadosProduto()
1028:         THIS.this_cModoAtual = "BUSCAR"
1029: 
1030:         loc_oPagina.txt_4c__Produto.ReadOnly = .F.
1031:         loc_oPagina.txt_4c_Dpro.ReadOnly     = .F.
1032:         loc_oPagina.txt_4c_Ifor.ReadOnly     = .F.
1033:         loc_oPagina.txt_4c_Refs.ReadOnly     = .F.
1034: 
1035:         *-- NAO usar HabilitarCampos(.F.) aqui: ele tambem desabilita o
1036:         *-- Confirmar, que EH o botao que dispara a busca (ExecutarBusca)
1037:         loc_oPagina.grd_4c_Itens.ReadOnly      = .T.
1038:         loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
1039: 
1040:         THIS.AlternarPagina(2)
1041:         loc_oPagina.txt_4c__Produto.SetFocus()
1042:     ENDPROC
1043: 
1044:     *===========================================================================
1045:     * ExecutarBusca - Busca por exemplo em SigCdPro (Produto/Descricao/
1046:     * Fornecedor/Referencia, nesta ordem) e carrega os itens existentes do
1047:     * Produto encontrado. Legado: msv_procurar (Do Case cpros/dpros/ifors/reffs)
1048:     *===========================================================================
1049:     PROCEDURE ExecutarBusca()
1050:         LOCAL loc_oPagina, loc_cCodigo, loc_cDescricao, loc_cFornecedor, loc_cReferencia
1051:         LOCAL loc_cSQL, loc_nResultado, loc_cCodigoEncontrado
1052:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1053: 
1054:         loc_cCodigo           = ALLTRIM(loc_oPagina.txt_4c__Produto.Value)
1055:         loc_cDescricao        = ALLTRIM(loc_oPagina.txt_4c_Dpro.Value)
1056:         loc_cFornecedor       = ALLTRIM(loc_oPagina.txt_4c_Ifor.Value)
1057:         loc_cReferencia       = ALLTRIM(loc_oPagina.txt_4c_Refs.Value)
1058:         loc_cCodigoEncontrado = ""
1059: 
1060:         TRY
1061:             DO CASE
1062:                 CASE !EMPTY(loc_cCodigo)
1063:                     loc_cSQL = "SELECT cpros FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCodigo)
1064:                 CASE !EMPTY(loc_cDescricao)
1065:                     loc_cSQL = "SELECT cpros FROM SigCdPro WHERE dpros = " + EscaparSQL(loc_cDescricao)
1066:                 CASE !EMPTY(loc_cFornecedor)
1067:                     loc_cSQL = "SELECT cpros FROM SigCdPro WHERE ifors = " + EscaparSQL(loc_cFornecedor)
1068:                 CASE !EMPTY(loc_cReferencia)
1069:                     loc_cSQL = "SELECT cpros FROM SigCdPro WHERE reffs = " + EscaparSQL(loc_cReferencia)
1070:                 OTHERWISE
1071:                     loc_cSQL = ""
1072:             ENDCASE
1073: 
1074:             IF EMPTY(loc_cSQL)
1075:                 MsgAviso("Informe ao menos um crit" + CHR(233) + "rio de busca !!!")
1076:             ELSE
1077:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaExemplo")
1078:                 IF loc_nResultado > 0 AND USED("cursor_4c_BuscaExemplo") AND !EOF("cursor_4c_BuscaExemplo")
1079:                     loc_cCodigoEncontrado = ALLTRIM(cursor_4c_BuscaExemplo.cpros)
1080:                 ELSE
1081:                     MsgAviso("Produto n" + CHR(227) + "o encontrado !!!")
1082:                 ENDIF
1083:             ENDIF
1084:         CATCH TO loc_oErro
1085:             MsgErro(loc_oErro.Message, "ExecutarBusca")
1086:         ENDTRY
1087: 
1088:         IF USED("cursor_4c_BuscaExemplo")
1089:             USE IN cursor_4c_BuscaExemplo
1090:         ENDIF
1091: 
1092:         IF !EMPTY(loc_cCodigoEncontrado)
1093:             IF THIS.CarregarItensExistentesProduto(loc_cCodigoEncontrado)
1094:                 THIS.this_cModoAtual = "ALTERAR"
1095:                 loc_oPagina.txt_4c__Produto.ReadOnly = .T.
1096:                 loc_oPagina.txt_4c_Dpro.ReadOnly     = .T.
1097:                 loc_oPagina.txt_4c_Ifor.ReadOnly     = .T.
1098:                 loc_oPagina.txt_4c_Refs.ReadOnly     = .T.
1099:                 THIS.HabilitarCampos(.T.)
1100:             ENDIF
1101:         ENDIF
1102:     ENDPROC
1103: 
1104:     *===========================================================================
1105:     * BtnEncerrarClick - Fecha o formulario
1106:     *===========================================================================
1107:     PROCEDURE BtnEncerrarClick()
1108:         THIS.Release()
1109:     ENDPROC
1110: 
1111:     *===========================================================================
1112:     * HabilitarCampos - Habilita/desabilita a grade de itens e os botoes de
1113:     * gravacao/remocao de linha da Page2, conforme o modo (INCLUIR/ALTERAR x
1114:     * VISUALIZAR). O codigo/descricao do Produto sao travados por fora
1115:     * (BtnIncluirClick libera, BtnAlterarClick/BtnVisualizarClick travam)
1116:     *===========================================================================
1117:     PROCEDURE HabilitarCampos(par_lHabilitar)
1118:         LOCAL loc_oPagina
1119:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1120: 
1121:         loc_oPagina.grd_4c_Itens.ReadOnly     = !par_lHabilitar
1122:         loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
1123:     ENDPROC
1124: 
1125:     *===========================================================================
1126:     * AjustarBotoesPorModo - Ajusta os botoes CRUD da Pagina Lista conforme o
1127:     * modo corrente. Legado: Grupo_Op.Enabled / Inserir|Consultar|Alterar|
1128:     * Excluir|Procurar.Enabled (btnCopiar.Click e cntCopia.cmdSair.Click
1129:     * desligam e religam o grupo inteiro).
1130:     *
1131:     * NAO mexe em cmd_4c_Confirmar: ele eh governado por HabilitarCampos(),
1132:     * que precisa deixa-lo LIGADO no modo BUSCAR (eh o Confirmar que dispara
1133:     * a busca por exemplo) e DESLIGADO no modo VISUALIZAR.
1134:     *===========================================================================
1135:     PROCEDURE AjustarBotoesPorModo()
1136:         LOCAL loc_oCnt, loc_lNaLista
1137:         loc_lNaLista = (THIS.this_cModoAtual == "LISTA")
1138:         loc_oCnt     = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
1139: 
1140:         loc_oCnt.cmd_4c_Incluir.Enabled    = loc_lNaLista
1141:         loc_oCnt.cmd_4c_Visualizar.Enabled = loc_lNaLista
1142:         loc_oCnt.cmd_4c_Alterar.Enabled    = loc_lNaLista
1143:         loc_oCnt.cmd_4c_Excluir.Enabled    = loc_lNaLista
1144:         loc_oCnt.cmd_4c_Buscar.Enabled     = loc_lNaLista
1145:         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Enabled = loc_lNaLista
1146: 
1147:         *-- Cancelar so faz sentido quando existe edicao/busca em andamento
1148:         THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = !loc_lNaLista
1149:     ENDPROC
1150: 
1151:     *===========================================================================
1152:     * FormParaBO - Transfere a LINHA CORRENTE da grade de itens (mais o Produto
1153:     * do cabecalho da Pagina Dados) para as propriedades do Business Object.
1154:     *
1155:     * Em SigCdMax cada registro eh UMA linha da grade (Produto + Empresa +
1156:     * Tamanho + Cor + Departamento + Qtde. Maxima), por isso o mapeamento le o
1157:     * registro corrente de cursor_4c_Itens - o Confirmar chama este metodo uma
1158:     * vez por linha, dentro do SCAN que posiciona o cursor.
1159:     *===========================================================================
1160:     PROTECTED PROCEDURE FormParaBO()
1161:         LOCAL loc_cProduto, loc_oBO
1162: 
1163:         IF !USED("cursor_4c_Itens") OR VARTYPE(THIS.this_oBusinessObject) != "O"
1164:             RETURN .F.
1165:         ENDIF
1166: 
1167:         loc_oBO     = THIS.this_oBusinessObject
1168:         loc_cProduto = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c__Produto.Value)
1169: 
1170:         SELECT cursor_4c_Itens
1171: 
1172:         *-- cidchaves vazio = linha nova (o Inserir do BO gera a PK com fUniqueIds)
1173:         loc_oBO.this_cCidChaves = ALLTRIM(NVL(cursor_4c_Itens.cidchaves, ""))
1174: 
1175:         *-- A linha pode ter sido criada em branco por AdicionarNovaLinhaItem
1176:         *-- antes do Produto estar escolhido: o cabecalho eh a fonte de verdade
1177:         loc_oBO.this_cCPros     = IIF(EMPTY(loc_cProduto), ;
1178:                                       ALLTRIM(NVL(cursor_4c_Itens.cpros, "")), loc_cProduto)
1179:         loc_oBO.this_cEmps      = ALLTRIM(NVL(cursor_4c_Itens.emps, ""))
1180:         loc_oBO.this_cCodTams   = ALLTRIM(NVL(cursor_4c_Itens.codtams, ""))
1181:         loc_oBO.this_cCodCores  = ALLTRIM(NVL(cursor_4c_Itens.codcores, ""))
1182:         loc_oBO.this_cDeptos    = ALLTRIM(NVL(cursor_4c_Itens.deptos, ""))
1183:         loc_oBO.this_nQMaxs     = NVL(cursor_4c_Itens.qmaxs, 0)
1184: 
1185:         *-- ordems eh char(1) NOT NULL sem campo na tela (o legado grava o
1186:         *-- registro em branco do cursor); manter "1" para nao violar o NOT NULL
1187:         loc_oBO.this_cOrdems    = "1"
1188: 
1189:         RETURN .T.
1190:     ENDPROC
1191: 
1192:     *===========================================================================
1193:     * BOParaForm - Transfere as propriedades do Business Object de volta para a
1194:     * LINHA CORRENTE da grade de itens e para o Produto do cabecalho.
1195:     *
1196:     * Chamado depois de cada gravacao: eh assim que a PK gerada pelo Inserir
1197:     * (fUniqueIds) volta para a linha - sem isso, um segundo Confirmar sobre a
1198:     * mesma grade trataria as linhas ja gravadas como novas e duplicaria tudo.
1199:     *===========================================================================
1200:     PROTECTED PROCEDURE BOParaForm()
1201:         LOCAL loc_oPagina, loc_oBO
1202: 
1203:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1204:             RETURN .F.
1205:         ENDIF
1206: 
1207:         loc_oBO     = THIS.this_oBusinessObject
1208:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1209: 
1210:         IF EMPTY(ALLTRIM(loc_oPagina.txt_4c__Produto.Value)) AND !EMPTY(loc_oBO.this_cCPros)
1211:             loc_oPagina.txt_4c__Produto.Value = ALLTRIM(loc_oBO.this_cCPros)
1212:         ENDIF
1213: 
1214:         IF USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens")
1215:             SELECT cursor_4c_Itens
1216:             REPLACE cidchaves WITH loc_oBO.this_cCidChaves, ;
1217:                     cpros     WITH loc_oBO.this_cCPros, ;
1218:                     emps      WITH loc_oBO.this_cEmps, ;
1219:                     codtams   WITH loc_oBO.this_cCodTams, ;
1220:                     codcores  WITH loc_oBO.this_cCodCores, ;
1221:                     deptos    WITH loc_oBO.this_cDeptos, ;
1222:                     qmaxs     WITH loc_oBO.this_nQMaxs ;
1223:                 IN cursor_4c_Itens
1224:         ENDIF
1225: 
1226:         RETURN .T.
1227:     ENDPROC
1228: 
1229:     *===========================================================================
1230:     * LimparCampos - Hook do FormBase: limpa a ficha do Produto e a grade de
1231:     * itens e abandona a edicao em andamento no Business Object.
1232:     *===========================================================================
1233:     PROTECTED PROCEDURE LimparCampos()
1234:         THIS.LimparDadosProduto()
1235: 
1236:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1237:             THIS.this_oBusinessObject.CancelarEdicao()
1238:         ENDIF
1239: 
1240:         RETURN .T.
1241:     ENDPROC
1242: 
1243:     *===========================================================================
1244:     * CarregarItensExistentesProduto - Carrega cabecalho do Produto (mesma
1245:     * consulta de CarregarProdutoSelecionado) e os itens JA GRAVADOS em
1246:     * SigCdMax, para os fluxos ALTERAR/VISUALIZAR (NAO bloqueia por
1247:     * ExistemItensParaProduto - ao contrario do fluxo INCLUIR, aqui os itens
1248:     * EXISTENTES sao o que se quer carregar)
1249:     *===========================================================================
1250:     PROCEDURE CarregarItensExistentesProduto(par_cCodigo)
1251:         LOCAL loc_oPagina, loc_cSQL, loc_nResultado, loc_lSucesso
1252:         loc_oPagina  = THIS.pgf_4c_Paginas.Page2
1253:         loc_lSucesso = .F.
1254: 
1255:         TRY
1256:             loc_cSQL = "SELECT a.cpros, a.dpros, a.cgrus, a.ifors, a.reffs, a.situas," + ;
1257:                 " c.rclis, g.dgrus, g.tipoestos, g.cores, g.tams" + ;
1258:                 " FROM SigCdPro a" + ;
1259:                 " LEFT JOIN SigCdGrp g ON g.cgrus = a.cgrus" + ;
1260:                 " LEFT JOIN SigCdCli c ON c.iclis = a.ifors" + ;
1261:                 " WHERE a.cpros = " + EscaparSQL(par_cCodigo)
1262: 
1263:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdutoInfo")
1264: 
1265:             IF loc_nResultado < 1 OR !USED("cursor_4c_ProdutoInfo") OR EOF("cursor_4c_ProdutoInfo")
1266:                 MsgErro("Produto n" + CHR(227) + "o encontrado.", "Erro")
1267:             ELSE
1268:                 SELECT cursor_4c_ProdutoInfo
1269: 
1270:                 loc_oPagina.txt_4c__Produto.Value     = TratarNulo(cpros, "")
1271:                 loc_oPagina.txt_4c_Dpro.Value          = TratarNulo(dpros, "")
1272:                 loc_oPagina.txt_4c_Cgru.Value          = TratarNulo(cgrus, "")
1273:                 loc_oPagina.txt_4c_Dgru.Value          = TratarNulo(dgrus, "")
1274:                 loc_oPagina.txt_4c_Ifor.Value           = TratarNulo(ifors, "")
1275:                 loc_oPagina.txt_4c_Dfor.Value           = TratarNulo(rclis, "")
1276:                 loc_oPagina.txt_4c_Refs.Value           = TratarNulo(reffs, "")
1277:                 loc_oPagina.obj_4c_Opc_situacao.Value  = IIF(NVL(situas, 1) = 2, 2, 1)
1278: 
1279:                 THIS.this_nTipoEstos = TratarNulo(tipoestos, 0)
1280:                 THIS.this_lTemCor    = INLIST(THIS.this_nTipoEstos, 2, 4) OR TratarNulo(cores, 0) = 1
1281:                 THIS.this_lTemTam    = INLIST(THIS.this_nTipoEstos, 3, 4) OR TratarNulo(tams, 0) = 1
1282: 
1283:                 IF THIS.CarregarItensGravados(par_cCodigo)
1284:                     loc_oPagina.grd_4c_Itens.Column3.Enabled = THIS.this_lTemTam
1285:                     loc_oPagina.grd_4c_Itens.Column4.Enabled = THIS.this_lTemCor
1286:                     loc_oPagina.grd_4c_Itens.Refresh()
1287:                     loc_oPagina.cmd_4c_BtnExcluir.Visible = .T.
1288:                     loc_lSucesso = .T.
1289:                 ENDIF
1290:             ENDIF
1291:         CATCH TO loc_oErro
1292:             MsgErro(loc_oErro.Message, "CarregarItensExistentesProduto")
1293:         ENDTRY
1294: 
1295:         IF USED("cursor_4c_ProdutoInfo")
1296:             USE IN cursor_4c_ProdutoInfo
1297:         ENDIF
1298: 
1299:         RETURN loc_lSucesso
1300:     ENDPROC
1301: 
1302:     *===========================================================================
1303:     * CarregarItensGravados - Popula cursor_4c_Itens com os registros JA
1304:     * gravados em SigCdMax para o Produto informado. Usa cursor TEMPORARIO +
1305:     * ZAP/APPEND para preservar as colunas do Grid (regra CLAUDE.md #34)
1306:     *===========================================================================
1307:     PROCEDURE CarregarItensGravados(par_cCodigo)
1308:         LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
1309:         loc_lSucesso = .F.
1310: 
1311:         TRY
1312:             loc_cSQL = "SELECT cidchaves, cpros, emps, qmaxs, codtams, codcores, deptos" + ;
1313:                 " FROM SigCdMax WHERE cpros = " + EscaparSQL(par_cCodigo) + ;
1314:                 " ORDER BY emps, codtams, codcores"
1315: 
1316:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItensTemp")
1317: 
1318:             IF loc_nResultado >= 0 AND USED("cursor_4c_Itens")
1319:                 SELECT cursor_4c_Itens
1320:                 ZAP
1321: 
1322:                 IF USED("cursor_4c_ItensTemp")
1323:                     SELECT cursor_4c_ItensTemp
1324:                     SCAN
1325:                         INSERT INTO cursor_4c_Itens (cidchaves, cpros, emps, qmaxs, codtams, codcores, deptos) ;
1326:                             VALUES (cursor_4c_ItensTemp.cidchaves, cursor_4c_ItensTemp.cpros, ;
1327:                                     cursor_4c_ItensTemp.emps, cursor_4c_ItensTemp.qmaxs, ;
1328:                                     cursor_4c_ItensTemp.codtams, cursor_4c_ItensTemp.codcores, ;
1329:                                     cursor_4c_ItensTemp.deptos)
1330:                     ENDSCAN
1331:                 ENDIF
1332: 
1333:                 SELECT cursor_4c_Itens
1334:                 IF RECCOUNT("cursor_4c_Itens") = 0
1335:                     INSERT INTO cursor_4c_Itens (cpros) VALUES (par_cCodigo)
1336:                 ENDIF
1337:                 GO TOP IN cursor_4c_Itens
1338:                 loc_lSucesso = .T.
1339:             ENDIF
1340:         CATCH TO loc_oErro
1341:             MsgErro(loc_oErro.Message, "CarregarItensGravados")
1342:         ENDTRY
1343: 
1344:         IF USED("cursor_4c_ItensTemp")
1345:             USE IN cursor_4c_ItensTemp
1346:         ENDIF
1347: 
1348:         RETURN loc_lSucesso
1349:     ENDPROC
1350: 
1351:     *===========================================================================
1352:     * Lookup Produto (codigo) - legado: get_produto.Valid (fwbuscaext SigCdPro/cpros)
1353:     * BINDEVENT em LostFocus (Valid nao dispara de forma confiavel via BINDEVENT)
1354:     *===========================================================================
1355:     PROCEDURE ProdutoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1356:         THIS.AbrirLookupProduto()
1357:     ENDPROC
1358: 
1359:     PROCEDURE ProdutoDblClick()
1360:         THIS.AbrirLookupProduto()
1361:     ENDPROC
1362: 
1363:     PROCEDURE AbrirLookupProduto()
1364:         LOCAL loc_oPagina, loc_cValor, loc_oBusca, loc_cCodigo
1365:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1366: 
1367:         *-- Legado: get_produto.Valid so dispara o lookup quando pcEscolha = 'INSERIR'
1368:         IF THIS.this_cModoAtual != "INCLUIR"
1369:             RETURN
1370:         ENDIF
1371: 
1372:         loc_cValor  = ALLTRIM(loc_oPagina.txt_4c__Produto.Value)
1373: 
1374:         IF loc_cValor == THIS.this_cUltimoProdutoValid
1375:             RETURN
1376:         ENDIF
1377:         THIS.this_cUltimoProdutoValid = loc_cValor
1378: 
1379:         IF EMPTY(loc_cValor)
1380:             THIS.LimparDadosProduto()
1381:             RETURN
1382:         ENDIF
1383: 
1384:         loc_cCodigo = ""
1385:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1386:             "SigCdPro", "cursor_4c_BuscaProduto", "cpros", loc_cValor, "Produtos")
1387: 
1388:         IF VARTYPE(loc_oBusca) = "O"
1389:             IF !loc_oBusca.this_lAchouRegistro
1390:                 loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
1391:                 loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
1392:                 loc_oBusca.Show()
1393:             ENDIF
1394:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProduto")
1395:                 loc_cCodigo = ALLTRIM(cursor_4c_BuscaProduto.cpros)
1396:             ENDIF
1397:             loc_oBusca.Release()
1398:         ENDIF
1399:         IF USED("cursor_4c_BuscaProduto")
1400:             USE IN cursor_4c_BuscaProduto
1401:         ENDIF
1402: 
1403:         IF EMPTY(loc_cCodigo)
1404:             THIS.LimparDadosProduto()
1405:         ELSE
1406:             THIS.this_cUltimoProdutoValid = loc_cCodigo
1407:             THIS.CarregarProdutoSelecionado(loc_cCodigo)
1408:         ENDIF
1409:     ENDPROC
1410: 
1411:     *===========================================================================
1412:     * Lookup Produto (descricao) - legado: getDpro.Valid (fwbuscaext SigCdPro/dpros)
1413:     *===========================================================================
1414:     PROCEDURE DescricaoProdutoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1415:         THIS.AbrirLookupProdutoPorDescricao()
1416:     ENDPROC
1417: 
1418:     PROCEDURE DescricaoProdutoDblClick()
1419:         THIS.AbrirLookupProdutoPorDescricao()
1420:     ENDPROC
1421: 
1422:     PROCEDURE AbrirLookupProdutoPorDescricao()
1423:         LOCAL loc_oPagina, loc_cValor, loc_oBusca, loc_cCodigo
1424:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1425: 
1426:         *-- Legado: getDpro.Valid so dispara o lookup quando pcEscolha = 'INSERIR'
1427:         IF THIS.this_cModoAtual != "INCLUIR"
1428:             RETURN
1429:         ENDIF
1430: 
1431:         loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_Dpro.Value)
1432: 
1433:         IF loc_cValor == THIS.this_cUltimoDescProdValid
1434:             RETURN
1435:         ENDIF
1436:         THIS.this_cUltimoDescProdValid = loc_cValor
1437: 
1438:         IF EMPTY(loc_cValor)
1439:             RETURN
1440:         ENDIF
1441: 
1442:         loc_cCodigo = ""
1443:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1444:             "SigCdPro", "cursor_4c_BuscaProduto", "dpros", loc_cValor, "Produtos")
1445: 
1446:         IF VARTYPE(loc_oBusca) = "O"
1447:             IF !loc_oBusca.this_lAchouRegistro
1448:                 loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
1449:                 loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
1450:                 loc_oBusca.Show()
1451:             ENDIF
1452:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProduto")
1453:                 loc_cCodigo = ALLTRIM(cursor_4c_BuscaProduto.cpros)
1454:             ENDIF
1455:             loc_oBusca.Release()
1456:         ENDIF
1457:         IF USED("cursor_4c_BuscaProduto")
1458:             USE IN cursor_4c_BuscaProduto
1459:         ENDIF
1460: 
1461:         IF !EMPTY(loc_cCodigo)
1462:             THIS.this_cUltimoProdutoValid = loc_cCodigo
1463:             THIS.CarregarProdutoSelecionado(loc_cCodigo)
1464:         ENDIF
1465:     ENDPROC
1466: 
1467:     *===========================================================================
1468:     * CarregarProdutoSelecionado - Carrega dados do Produto (join Grupo/Fornecedor),
1469:     * valida situacao/duplicidade e prepara a grade de itens para inclusao
1470:     * Legado: get_produto.Valid + ThisForm.AcertaGrade() + ThisForm.MRefreshGet()
1471:     *===========================================================================
1472:     PROCEDURE CarregarProdutoSelecionado(par_cCodigo)
1473:         LOCAL loc_oPagina, loc_cSQL, loc_nResultado, loc_lInativo
1474: 
1475:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1476: 
1477:         TRY
1478:             loc_cSQL = "SELECT a.cpros, a.dpros, a.cgrus, a.ifors, a.reffs, a.situas," + ;
1479:                 " c.rclis, g.dgrus, g.tipoestos, g.cores, g.tams" + ;
1480:                 " FROM SigCdPro a" + ;
1481:                 " LEFT JOIN SigCdGrp g ON g.cgrus = a.cgrus" + ;
1482:                 " LEFT JOIN SigCdCli c ON c.iclis = a.ifors" + ;
1483:                 " WHERE a.cpros = " + EscaparSQL(par_cCodigo)
1484: 
1485:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdutoInfo")
1486: 
1487:             IF loc_nResultado < 1 OR !USED("cursor_4c_ProdutoInfo") OR EOF("cursor_4c_ProdutoInfo")
1488:                 MsgErro("Favor reinicializar o processo.", "Falha na Conex" + CHR(227) + "o")
1489:                 THIS.LimparDadosProduto()
1490:             ELSE
1491:                 SELECT cursor_4c_ProdutoInfo
1492: 
1493:                 *-- Verifica se produto esta inativo (bloqueia se parametro gesind=1)
1494:                 loc_lInativo = .F.
1495:                 IF NVL(situas, 0) = 2
1496:                     IF THIS.ParametroGestaoIndireta()
1497:                         loc_lInativo = .T.
1498:                     ENDIF
1499:                 ENDIF
1500: 
1501:                 IF loc_lInativo
1502:                     MsgAviso("Produto Inativo !!!")
1503:                     THIS.LimparDadosProduto()
1504:                 ELSE
1505:                     IF THIS.this_oBusinessObject.ExistemItensParaProduto(par_cCodigo)
1506:                         MsgAviso("Produto j" + CHR(225) + " cadastrado !!!")
1507:                         THIS.LimparDadosProduto()
1508:                     ELSE
1509:                         loc_oPagina.txt_4c__Produto.Value = TratarNulo(cpros, "")
1510:                         loc_oPagina.txt_4c_Dpro.Value      = TratarNulo(dpros, "")
1511:                         loc_oPagina.txt_4c_Cgru.Value      = TratarNulo(cgrus, "")
1512:                         loc_oPagina.txt_4c_Dgru.Value      = TratarNulo(dgrus, "")
1513:                         loc_oPagina.txt_4c_Ifor.Value       = TratarNulo(ifors, "")
1514:                         loc_oPagina.txt_4c_Dfor.Value       = TratarNulo(rclis, "")
1515:                         loc_oPagina.txt_4c_Refs.Value       = TratarNulo(reffs, "")
1516:                         loc_oPagina.obj_4c_Opc_situacao.Value = IIF(NVL(situas, 1) = 2, 2, 1)
1517: 
1518:                         THIS.this_nTipoEstos = TratarNulo(tipoestos, 0)
1519:                         THIS.this_lTemCor    = INLIST(THIS.this_nTipoEstos, 2, 4) OR TratarNulo(cores, 0) = 1
1520:                         THIS.this_lTemTam    = INLIST(THIS.this_nTipoEstos, 3, 4) OR TratarNulo(tams, 0) = 1
1521: 
1522:                         *-- Prepara a grade com UMA linha em branco para o usuario preencher
1523:                         IF USED("cursor_4c_Itens")
1524:                             ZAP IN cursor_4c_Itens
1525:                             INSERT INTO cursor_4c_Itens (cpros) VALUES (par_cCodigo)
1526:                         ENDIF
1527: 
1528:                         loc_oPagina.grd_4c_Itens.Column3.Enabled = THIS.this_lTemTam
1529:                         loc_oPagina.grd_4c_Itens.Column4.Enabled = THIS.this_lTemCor
1530:                         loc_oPagina.grd_4c_Itens.Refresh()
1531: 
1532:                         loc_oPagina.cmd_4c_BtnExcluir.Visible = .T.
1533:                         THIS.this_cModoAtual = "INCLUIR"
1534:                     ENDIF
1535:                 ENDIF
1536:             ENDIF
1537:         CATCH TO loc_oErro
1538:             MsgErro(loc_oErro.Message, "CarregarProdutoSelecionado")
1539:             THIS.LimparDadosProduto()
1540:         ENDTRY
1541: 
1542:         IF USED("cursor_4c_ProdutoInfo")
1543:             USE IN cursor_4c_ProdutoInfo
1544:         ENDIF
1545:     ENDPROC
1546: 
1547:     *===========================================================================
1548:     * ParametroGestaoIndireta - Le SigCdPam.gesind (parametro de gestao indireta)
1549:     *===========================================================================
1550:     PROCEDURE ParametroGestaoIndireta()
1551:         LOCAL loc_lResultado
1552:         loc_lResultado = .F.
1553: 
1554:         TRY
1555:             IF SQLEXEC(gnConnHandle, "SELECT gesind FROM SigCdPam", "cursor_4c_Param") > 0
1556:                 IF USED("cursor_4c_Param") AND !EOF("cursor_4c_Param")
1557:                     loc_lResultado = (TratarNulo(cursor_4c_Param.gesind, 0) = 1)
1558:                 ENDIF
1559:             ENDIF
1560:         CATCH TO loc_oErro
1561:             loc_lResultado = .F.
1562:         ENDTRY
1563: 
1564:         IF USED("cursor_4c_Param")
1565:             USE IN cursor_4c_Param
1566:         ENDIF
1567: 
1568:         RETURN loc_lResultado
1569:     ENDPROC
1570: 
1571:     *===========================================================================
1572:     * LimparDadosProduto - Limpa cabecalho do Produto e a grade de itens
1573:     *===========================================================================
1574:     PROCEDURE LimparDadosProduto()
1575:         LOCAL loc_oPagina
1576:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1577: 
1578:         loc_oPagina.txt_4c__Produto.Value      = ""
1579:         loc_oPagina.txt_4c_Dpro.Value          = ""
1580:         loc_oPagina.txt_4c_Cgru.Value          = ""
1581:         loc_oPagina.txt_4c_Dgru.Value          = ""
1582:         loc_oPagina.txt_4c_Ifor.Value          = ""
1583:         loc_oPagina.txt_4c_Dfor.Value          = ""
1584:         loc_oPagina.txt_4c_Refs.Value          = ""
1585:         loc_oPagina.obj_4c_Opc_situacao.Value  = 1
1586:         loc_oPagina.cmd_4c_BtnExcluir.Visible  = .F.
1587: 
1588:         *-- Ifor/Refs so ficam editaveis durante o modo BUSCAR (BtnBuscarClick
1589:         *-- reabre depois desta chamada) - fora dele, permanecem travados
1590:         loc_oPagina.txt_4c_Ifor.ReadOnly       = .T.
1591:         loc_oPagina.txt_4c_Refs.ReadOnly       = .T.
1592: 
1593:         THIS.this_nTipoEstos = 0
1594:         THIS.this_lTemCor    = .F.
1595:         THIS.this_lTemTam    = .F.
1596:         THIS.this_cUltimoProdutoValid  = ""
1597:         THIS.this_cUltimoDescProdValid = ""
1598: 
1599:         IF USED("cursor_4c_Itens")
1600:             ZAP IN cursor_4c_Itens
1601:         ENDIF
1602:         loc_oPagina.grd_4c_Itens.Refresh()
1603:     ENDPROC
1604: 
1605:     *===========================================================================
1606:     * GradeItensAfterRowColChange - Habilita Tamanho/Cor conforme o Grupo do Produto
1607:     * Legado: gradei.AfterRowColChange
1608:     *===========================================================================
1609:     PROCEDURE GradeItensAfterRowColChange(par_nColIndex)
1610:         LOCAL loc_oGrid
1611:         loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Itens
1612: 
1613:         loc_oGrid.Column3.Enabled = THIS.this_lTemTam
1614:         loc_oGrid.Column4.Enabled = THIS.this_lTemCor
1615:         loc_oGrid.Refresh()
1616:     ENDPROC
1617: 
1618:     *===========================================================================
1619:     * GradeItensEmpresaLostFocus - Valida acesso a Empresa digitada na grade
1620:     * Legado: gradei.Column1.text1.Valid (fAcessoEmpresa)
1621:     *===========================================================================
1622:     PROCEDURE GradeItensEmpresaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1623:         LOCAL loc_oText, loc_cValor
1624:         loc_oText  = THIS.pgf_4c_Paginas.Page2.grd_4c_Itens.Column1.Text1
1625:         loc_cValor = ALLTRIM(loc_oText.Value)
1626: 
1627:         IF !EMPTY(loc_cValor)
1628:             IF !VerificarAcessoEmpresa(gc_4c_UsuarioLogado, loc_cValor)
1629:                 MsgAviso("Empresa sem acesso ou inv" + CHR(225) + "lida !!!")
1630:                 loc_oText.Value = ""
1631:             ENDIF
1632:         ENDIF
1633:     ENDPROC
1634: 
1635:     *===========================================================================
1636:     * GradeItensTamanhoLostFocus - Lookup de Tamanho (SigCdTam) na grade
1637:     * Legado: gradei.Column3.Text1.Valid (fwbuscaext)
1638:     *===========================================================================
1639:     PROCEDURE GradeItensTamanhoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1640:         LOCAL loc_oText, loc_cValor, loc_oBusca, loc_cCodigo
1641:         loc_oText  = THIS.pgf_4c_Paginas.Page2.grd_4c_Itens.Column3.Text1
1642:         loc_cValor = ALLTRIM(loc_oText.Value)
1643: 
1644:         IF !EMPTY(loc_cValor)
1645:             loc_cCodigo = ""
1646:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1647:                 "SigCdTam", "cursor_4c_BuscaTamanho", "cods", loc_cValor, "Tamanhos")
1648:             IF VARTYPE(loc_oBusca) = "O"
1649:                 IF !loc_oBusca.this_lAchouRegistro
1650:                     loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "d")
1651:                     loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1652:                     loc_oBusca.Show()
1653:                 ENDIF
1654:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTamanho")
1655:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaTamanho.cods)
1656:                 ENDIF
1657:                 loc_oBusca.Release()
1658:             ENDIF
1659:             IF USED("cursor_4c_BuscaTamanho")
1660:                 USE IN cursor_4c_BuscaTamanho
1661:             ENDIF
1662:             loc_oText.Value = loc_cCodigo
1663:         ENDIF
1664: 
1665:         IF THIS.this_nTipoEstos = 3 AND EMPTY(ALLTRIM(loc_oText.Value))
1666:             MsgAviso("Obrigat" + CHR(243) + "rio informar Tamanho !!!")
1667:         ENDIF
1668:     ENDPROC
1669: 
1670:     *===========================================================================
1671:     * GradeItensCorLostFocus - Lookup de Cor (SigCdCor) na grade
1672:     * Legado: gradei.Column4.Text1.Valid (fwbuscaext)
1673:     *===========================================================================
1674:     PROCEDURE GradeItensCorLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1675:         LOCAL loc_oText, loc_cValor, loc_oBusca, loc_cCodigo
1676:         loc_oText  = THIS.pgf_4c_Paginas.Page2.grd_4c_Itens.Column4.Text1
1677:         loc_cValor = ALLTRIM(loc_oText.Value)
1678: 
1679:         IF !EMPTY(loc_cValor)
1680:             loc_cCodigo = ""
1681:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1682:                 "SigCdCor", "cursor_4c_BuscaCor", "cods", loc_cValor, "Cores")
1683:             IF VARTYPE(loc_oBusca) = "O"
1684:                 IF !loc_oBusca.this_lAchouRegistro
1685:                     loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "d")
1686:                     loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1687:                     loc_oBusca.Show()
1688:                 ENDIF
1689:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCor")
1690:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaCor.cods)
1691:                 ENDIF
1692:                 loc_oBusca.Release()
1693:             ENDIF
1694:             IF USED("cursor_4c_BuscaCor")
1695:                 USE IN cursor_4c_BuscaCor
1696:             ENDIF
1697:             loc_oText.Value = loc_cCodigo
1698:         ENDIF
1699: 
1700:         IF THIS.this_nTipoEstos = 2 AND EMPTY(ALLTRIM(loc_oText.Value))
1701:             MsgAviso("Obrigat" + CHR(243) + "rio informar C" + CHR(243) + "digo da Cor !!!")
1702:         ENDIF
1703:     ENDPROC
1704: 
1705:     *===========================================================================
1706:     * GradeItensDepartamentoLostFocus - Lookup de Departamento (SigCdDpt) na grade
1707:     * Legado: gradei.Column5.Text1.Valid (fwbuscaext) + mNovaLinha (nova linha em branco)
1708:     *===========================================================================
1709:     PROCEDURE GradeItensDepartamentoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1710:         LOCAL loc_oText, loc_cValor, loc_oBusca, loc_cCodigo
1711:         loc_oText  = THIS.pgf_4c_Paginas.Page2.grd_4c_Itens.Column5.Text1
1712:         loc_cValor = ALLTRIM(loc_oText.Value)
1713: 
1714:         IF !EMPTY(loc_cValor)
1715:             loc_cCodigo = ""
1716:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1717:                 "SigCdDpt", "cursor_4c_BuscaDepto", "codigos", loc_cValor, "Departamentos")
1718:             IF VARTYPE(loc_oBusca) = "O"
1719:                 IF !loc_oBusca.this_lAchouRegistro
1720:                     loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
1721:                     loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
1722:                     loc_oBusca.Show()
1723:                 ENDIF
1724:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDepto")
1725:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaDepto.codigos)
1726:                 ENDIF
1727:                 loc_oBusca.Release()
1728:             ENDIF
1729:             IF USED("cursor_4c_BuscaDepto")
1730:                 USE IN cursor_4c_BuscaDepto
1731:             ENDIF
1732:             loc_oText.Value = loc_cCodigo
1733:         ENDIF
1734: 
1735:         THIS.AdicionarNovaLinhaItem()
1736:     ENDPROC
1737: 
1738:     *===========================================================================
1739:     * AdicionarNovaLinhaItem - Acrescenta uma linha em branco na grade de itens
1740:     * Legado: mNovaLinha
1741:     *===========================================================================
1742:     PROCEDURE AdicionarNovaLinhaItem()
1743:         LOCAL loc_oGrid, loc_cProduto
1744: 
1745:         IF !USED("cursor_4c_Itens")
1746:             RETURN
1747:         ENDIF
1748: 
1749:         loc_oGrid   = THIS.pgf_4c_Paginas.Page2.grd_4c_Itens
1750:         loc_cProduto = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c__Produto.Value)
1751: 
1752:         SELECT cursor_4c_Itens
1753:         LOCATE FOR EMPTY(emps)
1754:         IF !FOUND()
1755:             INSERT INTO cursor_4c_Itens (cpros) VALUES (loc_cProduto)
1756:         ENDIF
1757: 
1758:         loc_oGrid.Refresh()
1759:     ENDPROC
1760: 
1761:     *===========================================================================
1762:     * BtnExcluirItemClick - Remove da grade local os itens da Empresa corrente
1763:     * Legado: btnExcluir.Click
1764:     *===========================================================================
1765:     PROCEDURE BtnExcluirItemClick()
1766:         LOCAL loc_cEmps, loc_cProduto, loc_oGrid
1767: 
1768:         IF !USED("cursor_4c_Itens")
1769:             RETURN
1770:         ENDIF
1771: 
1772:         loc_oGrid    = THIS.pgf_4c_Paginas.Page2.grd_4c_Itens
1773:         loc_cProduto = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c__Produto.Value)
1774:         loc_cEmps    = ""
1775: 
1776:         SELECT cursor_4c_Itens
1777:         IF !EOF() AND !EMPTY(emps)
1778:             loc_cEmps = emps
1779:         ENDIF
1780: 
1781:         IF !EMPTY(loc_cEmps)
1782:             DELETE FROM cursor_4c_Itens WHERE emps == loc_cEmps
1783:             SELECT cursor_4c_Itens
1784:             PACK
1785:         ENDIF
1786: 
1787:         SELECT cursor_4c_Itens
1788:         LOCATE
1789:         IF EOF()
1790:             INSERT INTO cursor_4c_Itens (cpros) VALUES (loc_cProduto)
1791:         ENDIF
1792: 
1793:         loc_oGrid.Refresh()
1794:     ENDPROC
1795: 
1796:     *===========================================================================
1797:     * BtnConfirmarClick - Grava na tabela SigCdMax cada linha valida da grade
1798:     * Legado: btnConfirma equivalente (TableUpdate do cursor CrSigCdMax)
1799:     *===========================================================================
1800:     PROCEDURE BtnConfirmarClick()
1801:         LOCAL loc_lSucesso, loc_nLinhasGravadas, loc_cProduto, loc_cChavesMantidas
1802:         LOCAL loc_lLinhaNova, loc_lEraAlteracao
1803: 
1804:         *-- Em modo BUSCAR, Confirmar executa a busca por exemplo (legado: msv_procurar)
1805:         IF THIS.this_cModoAtual == "BUSCAR"
1806:             THIS.ExecutarBusca()
1807:             RETURN
1808:         ENDIF
1809: 
1810:         *-- VISUALIZAR nao grava (HabilitarCampos(.F.) ja desliga o botao; esta
1811:         *-- guarda cobre a chamada por teclado/atalho)
1812:         IF THIS.this_cModoAtual == "VISUALIZAR" OR !USED("cursor_4c_Itens")
1813:             RETURN
1814:         ENDIF
1815: 
1816:         loc_cProduto = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c__Produto.Value)
1817: 
1818:         *-- Legado: cmdConfirma recusa Produto vazio no INSERIR e devolve o foco
1819:         IF EMPTY(loc_cProduto)
1820:             MsgAviso("Produto inv" + CHR(225) + "lido !!!")
1821:             THIS.pgf_4c_Paginas.Page2.txt_4c__Produto.SetFocus()
1822:             RETURN
1823:         ENDIF
1824: 
1825:         loc_lSucesso        = .T.
1826:         loc_nLinhasGravadas = 0
1827:         loc_cChavesMantidas = ""
1828:         loc_lEraAlteracao   = (THIS.this_cModoAtual == "ALTERAR")
1829: 
1830:         SELECT cursor_4c_Itens
1831:         SCAN FOR !EMPTY(emps)
1832:             IF THIS.this_lTemTam AND EMPTY(codtams)
1833:                 MsgAviso("Obrigat" + CHR(243) + "rio informar Tamanho !!!")
1834:                 loc_lSucesso = .F.
1835:                 EXIT
1836:             ENDIF
1837:             IF THIS.this_lTemCor AND EMPTY(codcores)
1838:                 MsgAviso("Obrigat" + CHR(243) + "rio informar C" + CHR(243) + "digo da Cor !!!")
1839:                 loc_lSucesso = .F.
1840:                 EXIT
1841:             ENDIF
1842: 
1843:             *-- Linha SEM cidchaves eh nova (INSERT); com chave, eh uma linha ja
1844:             *-- gravada em SigCdMax e o que se quer eh UPDATE. Sem esta distincao
1845:             *-- o ALTERAR reinseria todas as linhas do Produto.
1846:             loc_lLinhaNova = EMPTY(NVL(cursor_4c_Itens.cidchaves, ""))
1847: 
1848:             IF loc_lLinhaNova
1849:                 THIS.this_oBusinessObject.NovoRegistro()
1850:             ELSE
1851:                 *-- CancelarEdicao zera this_lNovoRegistro (que BtnAlterarClick
1852:                 *-- deixou ligado); sem isso EditarRegistro recusa e o Salvar
1853:                 *-- cairia no Inserir, duplicando o registro
1854:                 THIS.this_oBusinessObject.CancelarEdicao()
1855:                 THIS.this_oBusinessObject.EditarRegistro()
1856:             ENDIF
1857: 
1858:             *-- FormParaBO depois de NovoRegistro/EditarRegistro: NovoRegistro
1859:             *-- chama LimparDados e apagaria o que fosse mapeado antes
1860:             THIS.FormParaBO()
1861: 
1862:             IF !THIS.this_oBusinessObject.Salvar()
1863:                 loc_lSucesso = .F.
1864:                 EXIT
1865:             ENDIF
1866: 
1867:             *-- Devolve para a linha a PK gerada no Inserir (e os valores como
1868:             *-- ficaram gravados), para um 2o Confirmar nao reinserir a linha
1869:             THIS.BOParaForm()
1870: 
1871:             loc_cChavesMantidas = loc_cChavesMantidas + ;
1872:                 IIF(EMPTY(loc_cChavesMantidas), "", ",") + ;
1873:                 ALLTRIM(THIS.this_oBusinessObject.this_cCidChaves)
1874:             loc_nLinhasGravadas = loc_nLinhasGravadas + 1
1875:         ENDSCAN
1876: 
1877:         *-- Linhas que o usuario removeu da grade com btnExcluir precisam sair do
1878:         *-- banco: no legado o cursor era uma view atualizavel e o Delete local
1879:         *-- ia junto no Update/Commit; aqui a grade eh um cursor local.
1880:         IF loc_lSucesso AND loc_lEraAlteracao
1881:             loc_lSucesso = THIS.this_oBusinessObject.ExcluirItensRemovidos(loc_cProduto, loc_cChavesMantidas)
1882:         ENDIF
1883: 
1884:         IF loc_lSucesso
1885:             IF loc_nLinhasGravadas = 0 AND !loc_lEraAlteracao
1886:                 MsgAviso("Nenhum item informado para grava" + CHR(231) + CHR(227) + "o.")
1887:             ELSE
1888:                 MsgInfo("Registro salvo com sucesso!", "Confirmar")
1889:                 THIS.LimparCampos()
1890:                 THIS.AlternarPagina(1)
1891:             ENDIF
1892:         ENDIF
1893:     ENDPROC
1894: 
1895:     *===========================================================================
1896:     * BtnCancelarClick - Cancela a inclusao e retorna para a Lista
1897:     *===========================================================================
1898:     PROCEDURE BtnCancelarClick()
1899:         *-- LimparCampos (e nao LimparDadosProduto) para tambem abandonar a
1900:         *-- edicao no BO: sem isso o BO fica com this_lEmEdicao ligado depois de
1901:         *-- um Incluir cancelado e o Fechar passa a perguntar por alteracoes
1902:         *-- que nao existem mais
1903:         THIS.LimparCampos()
1904:         THIS.AlternarPagina(1)
1905:     ENDPROC
1906: 
1907:     *===========================================================================
1908:     * FormatarGridLista - Formata visual do grid da lista
1909:     *===========================================================================
1910:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1911:         WITH par_oGrid
1912:             .FontName = "Tahoma"
1913:             .FontSize = 8
1914:         ENDWITH
1915:     ENDPROC
1916: 
1917:     *===========================================================================
1918:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
1919:     * REGRA: Deve iterar Pages E Controls para PageFrames
1920:     *===========================================================================
1921:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1922:         LOCAL loc_nI, loc_oObjeto, loc_nP
1923: 
1924:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1925:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1926: 
1927:             IF VARTYPE(loc_oObjeto) = "O"
1928:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1929:                     loc_oObjeto.Visible = .T.
1930:                 ENDIF
1931: 
1932:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1933:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1934:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1935:                     ENDFOR
1936:                 ENDIF
1937: 
1938:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1939:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1940:                 ENDIF
1941:             ENDIF
1942:         ENDFOR
1943:     ENDPROC
1944: 
1945:     *===========================================================================
1946:     * Destroy - Libera recursos ao fechar o formulario
1947:     *===========================================================================
1948:     PROCEDURE Destroy()
1949:         THIS.this_oBusinessObject = .NULL.
1950:         RETURN DODEFAULT()
1951:     ENDPROC
1952: 
1953: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigprcomBO.prg):
*====================================================================
* sigprcomBO.prg
*
* Business Object para Estoque Maximo por Produto/Empresa/Tamanho/Cor
* Tabela: SigCdMax
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS sigprcomBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdMax)
    this_cCidChaves = ""    && cidchaves char(20) - PK
    this_cCPros     = ""    && cpros char(14)
    this_cEmps      = ""    && emps char(3)
    this_cCodTams   = ""    && codtams char(4)
    this_cCodCores  = ""    && codcores char(4)
    this_cDeptos    = ""    && deptos char(10)
    this_cOrdems    = ""    && ordems char(1)
    this_nQMaxs     = 0     && qmaxs numeric(7,2)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdMax"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "sigprcomBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *====================================================================
    * LimparDados - Reseta as propriedades da entidade
    * CRITICO: sem este override, this_cCidChaves sobrevive entre chamadas
    * de NovoRegistro() e o Inserir() reaproveita a MESMA chave gerada na
    * linha anterior (EMPTY() so gera nova se estiver vazia) - a 2a linha
    * de uma grade com N linhas estoura violacao de PK unica em silencio
    * (o loop do form para no primeiro Salvar() que falhar).
    *====================================================================
    PROTECTED PROCEDURE LimparDados()
        DODEFAULT()
        THIS.this_cCidChaves = ""
        THIS.this_cCPros     = ""
        THIS.this_cEmps      = ""
        THIS.this_cCodTams   = ""
        THIS.this_cCodCores  = ""
        THIS.this_cDeptos    = ""
        THIS.this_cOrdems    = ""
        THIS.this_nQMaxs     = 0
    ENDPROC

    *====================================================================
    * Buscar - Lista, na Pagina Lista, os Produtos com registro em SigCdMax
    * Legado: lcQProds (Init) -> AddCursor('SigCdMax','cpros','CrProdutos',...)
    * Cursor de saida: cursor_4c_Lista (cpros/dpros/ifors/reffs/sgrus)
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Lista")
                USE IN cursor_4c_Lista
            ENDIF

            loc_cSQL = "SELECT a.cpros, b.dpros, b.ifors, b.reffs, b.sgrus" + ;
                " FROM SigCdMax a" + ;
                " INNER JOIN SigCdPro b ON b.cpros = a.cpros" + ;
                " GROUP BY a.cpros, b.dpros, b.ifors, b.reffs, b.sgrus" + ;
                " ORDER BY a.cpros"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Lista")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar Estoque M" + CHR(225) + "ximo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "sigprcomBO.Buscar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            *-- TratarNulo(valor, PADRAO): o 2o argumento eh o VALOR de retorno
            *-- quando a coluna vem NULL - NAO um codigo de tipo. Passar "C"/"N"
            *-- gravaria a letra na property (e a STRING "N" em this_nQMaxs, que
            *-- depois estoura no FormatarNumeroSQL do Inserir/Atualizar).
            THIS.this_cCidChaves = TratarNulo(cidchaves, "")
            THIS.this_cCPros     = TratarNulo(cpros, "")
            THIS.this_cEmps      = TratarNulo(emps, "")
            THIS.this_cCodTams   = TratarNulo(codtams, "")
            THIS.this_cCodCores  = TratarNulo(codcores, "")
            THIS.this_cDeptos    = TratarNulo(deptos, "")
            THIS.this_cOrdems    = TratarNulo(ordems, "")
            THIS.this_nQMaxs     = TratarNulo(qmaxs, 0)
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - INSERT na tabela SigCdMax
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)
            ENDIF

            loc_cSQL = "INSERT INTO SigCdMax" + ;
                       " (cidchaves, cpros, emps, codtams, codcores, deptos, ordems, qmaxs)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + "," + ;
                       EscaparSQL(THIS.this_cCPros) + "," + ;
                       EscaparSQL(THIS.this_cEmps) + "," + ;
                       EscaparSQL(THIS.this_cCodTams) + "," + ;
                       EscaparSQL(THIS.this_cCodCores) + "," + ;
                       EscaparSQL(THIS.this_cDeptos) + "," + ;
                       EscaparSQL(THIS.this_cOrdems) + "," + ;
                       FormatarNumeroSQL(THIS.this_nQMaxs, 2) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir estoque m" + CHR(225) + "ximo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao inserir estoque m" + CHR(225) + "ximo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - UPDATE na tabela SigCdMax
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdMax SET" + ;
                       " cpros = "    + EscaparSQL(THIS.this_cCPros) + "," + ;
                       " emps = "     + EscaparSQL(THIS.this_cEmps) + "," + ;
                       " codtams = "  + EscaparSQL(THIS.this_cCodTams) + "," + ;
                       " codcores = " + EscaparSQL(THIS.this_cCodCores) + "," + ;
                       " deptos = "   + EscaparSQL(THIS.this_cDeptos) + "," + ;
                       " ordems = "   + EscaparSQL(THIS.this_cOrdems) + "," + ;
                       " qmaxs = "    + FormatarNumeroSQL(THIS.this_nQMaxs, 2) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar estoque m" + CHR(225) + "ximo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao atualizar estoque m" + CHR(225) + "ximo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExistemItensParaProduto - Verifica se o Produto ja possui registros
    * gravados em SigCdMax (legado: ThisForm.AcertaGrade requery + !Eof())
    *====================================================================
    FUNCTION ExistemItensParaProduto(par_cCodigo)
        LOCAL loc_lExiste, loc_nResultado
        loc_lExiste = .F.

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT cidchaves FROM SigCdMax WHERE cpros = " + EscaparSQL(par_cCodigo), ;
                "cursor_4c_VerificaMax")
            IF loc_nResultado > 0
                loc_lExiste = (RECCOUNT("cursor_4c_VerificaMax") > 0)
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "sigprcomBO.ExistemItensParaProduto")
        ENDTRY

        IF USED("cursor_4c_VerificaMax")
            USE IN cursor_4c_VerificaMax
        ENDIF

        RETURN loc_lExiste
    ENDFUNC

    *====================================================================
    * ExcluirItensRemovidos - Apaga de SigCdMax as linhas do Produto que
    * NAO estao mais na grade (o usuario removeu com btnExcluir no modo
    * ALTERAR). No legado o cursor CrSigCdMax eh uma view atualizavel e o
    * Delete local + Update/Commit levava a remocao ao banco; aqui a grade
    * eh um cursor local, entao a remocao tem de ser dita ao SQL Server.
    *
    * par_cProduto        - cpros do Produto em edicao
    * par_cChavesMantidas - cidchaves que PERMANECEM, separadas por virgula
    *                       (vazio = nenhuma linha gravada permaneceu)
    *====================================================================
    FUNCTION ExcluirItensRemovidos(par_cProduto, par_cChavesMantidas)
        LOCAL loc_cSQL, loc_cLista, loc_nResultado, loc_lSucesso, loc_nI, loc_nQtde
        LOCAL ARRAY loc_aChaves[1]
        loc_lSucesso = .F.
        loc_cLista   = ""

        TRY
            IF VARTYPE(par_cChavesMantidas) = "C" AND !EMPTY(par_cChavesMantidas)
                loc_nQtde = ALINES(loc_aChaves, par_cChavesMantidas, 1, ",")
                FOR loc_nI = 1 TO loc_nQtde
                    IF !EMPTY(loc_aChaves[loc_nI])
                        loc_cLista = loc_cLista + IIF(EMPTY(loc_cLista), "", ",") + ;
                            EscaparSQL(ALLTRIM(loc_aChaves[loc_nI]))
                    ENDIF
                ENDFOR
            ENDIF

            loc_cSQL = "DELETE FROM SigCdMax WHERE cpros = " + EscaparSQL(par_cProduto)
            IF !EMPTY(loc_cLista)
                loc_cSQL = loc_cSQL + " AND cidchaves NOT IN (" + loc_cLista + ")"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao remover itens do estoque m" + CHR(225) + "ximo:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "sigprcomBO.ExcluirItensRemovidos")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

