# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [GRID-HEADER] Header Caption 'Data' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Empresa, Movimentação, Numero, Grupo, Conta, Código, Descrição, Cor, Tam, Estoque, Saldo, Distribuido, Local, Emp O, Emp D, Grupo Orig, Conta Orig, Grupo Dest, Conta Dest, Item, Uni, Quantidade, Unitário, Total. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigmvdis.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (3822 linhas total):

*-- Linhas 24 a 149:
24:     *===========================================================================
25:     * Init - Inicializa o formulario
26:     * REGRA CRITICA: Apenas RETURN DODEFAULT()
27:     * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
28:     *===========================================================================
29:     PROCEDURE Init()
30:         RETURN DODEFAULT()
31:     ENDPROC
32: 
33:     *===========================================================================
34:     * InicializarForm - Configura estrutura completa
35:     * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
36:     *===========================================================================
37:     PROTECTED PROCEDURE InicializarForm()
38:         LOCAL loc_lSucesso
39:         loc_lSucesso = .F.
40: 
41:         TRY
42:             THIS.this_oBusinessObject = CREATEOBJECT("sigmvdisBO")
43: 
44:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
45:                 MostrarErro("Erro ao criar sigmvdisBO" + CHR(13) + ;
46:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
47:                     "Formsigmvdis.InicializarForm")
48:             ELSE
49:                 THIS.ConfigurarPageFrame()
50:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
51:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
52:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
53:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
54: 
55:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
56:                     THIS.CarregarLista()
57:                 ENDIF
58: 
59:                 THIS.pgf_4c_Paginas.Visible = .T.
60:                 THIS.pgf_4c_Paginas.ActivePage = 1
61:                 THIS.this_cModoAtual = "LISTA"
62: 
63:                 loc_lSucesso = .T.
64:             ENDIF
65: 
66:         CATCH TO loException
67:             MostrarErro("Erro ao inicializar Formsigmvdis:" + CHR(13) + ;
68:                 loException.Message + CHR(13) + ;
69:                 "Linha: " + TRANSFORM(loException.LineNo), ;
70:                 "Formsigmvdis.InicializarForm")
71:         ENDTRY
72: 
73:         RETURN loc_lSucesso
74:     ENDPROC
75: 
76:     *===========================================================================
77:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
78:     * Top=-29 para esconder abas; controles compensam +29 no Top
79:     *===========================================================================
80:     PROTECTED PROCEDURE ConfigurarPageFrame()
81:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
82: 
83:         WITH THIS.pgf_4c_Paginas
84:             .PageCount = 2
85:             .Top       = -29
86:             .Left      = 0
87:             .Width     = THIS.Width
88:             .Height    = THIS.Height + 29
89:             .Tabs      = .F.
90:             .Visible   = .T.
91: 
92:             .Page1.Caption   = "Lista"
93:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
94:             .Page1.BackColor = RGB(255, 255, 255)
95: 
96:             .Page2.Caption   = "Dados"
97:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
98:             .Page2.BackColor = RGB(255, 255, 255)
99:         ENDWITH
100: 
101:         THIS.ConfigurarPaginaLista()
102:         THIS.ConfigurarPaginaDados()
103:     ENDPROC
104: 
105:     *===========================================================================
106:     * ConfigurarPaginaLista - Configura Page1 (estrutura base)
107:     * Grid e botoes CRUD sao adicionados na Fase 4
108:     *===========================================================================
109:     PROTECTED PROCEDURE ConfigurarPaginaLista()
110:         LOCAL loc_oPagina, loc_oBotoes, loc_oSaida, loc_oGrid
111:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
112: 
113:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
114: 
115:         *-- Container Cabecalho (cntSombra no legado) - PRIMEIRO AddObject da pagina
116:         *-- Original: Top=1. Com compensacao +29: Top=31
117:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
118:         WITH loc_oPagina.cnt_4c_Cabecalho
119:             .Top         = 31
120:             .Left        = 0
121:             .Width       = THIS.Width
122:             .Height      = 80
123:             .BackColor   = RGB(100, 100, 100)
124:             .BorderWidth = 0
125:             .Visible     = .T.
126:         ENDWITH
127: 
128:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
129:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
130:             .Caption   = THIS.Caption
131:             .Top       = 15
132:             .Left      = 10
133:             .Width     = 769
134:             .Height    = 40
135:             .FontName  = "Tahoma"
136:             .FontSize  = 16
137:             .FontBold  = .T.
138:             .ForeColor = RGB(0, 0, 0)
139:             .BackStyle = 0
140:             .AutoSize  = .F.
141:             .Visible   = .T.
142:         ENDWITH
143: 
144:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
145:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
146:             .Caption   = THIS.Caption
147:             .Top       = 18
148:             .Left      = 10
149:             .Width     = 769

*-- Linhas 194 a 406:
194:             .AutoSize        = .F.
195:             .Visible         = .T.
196:         ENDWITH
197:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
198: 
199:         *-- Botao Visualizar
200:         loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
201:         WITH loc_oBotoes.cmd_4c_Visualizar
202:             .Caption         = "Visualizar"
203:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
204:             .PicturePosition = 13
205:             .Top             = 5
206:             .Left            = 80
207:             .Width           = 75
208:             .Height          = 75
209:             .BackColor       = RGB(255, 255, 255)
210:             .ForeColor       = RGB(90, 90, 90)
211:             .FontName        = "Tahoma"
212:             .FontSize        = 8
213:             .FontBold        = .T.
214:             .FontItalic      = .T.
215:             .Themes          = .F.
216:             .SpecialEffect   = 0
217:             .MousePointer    = 15
218:             .WordWrap        = .T.
219:             .AutoSize        = .F.
220:             .Visible         = .T.
221:         ENDWITH
222:         BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
223: 
224:         *-- Botao Alterar
225:         loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
226:         WITH loc_oBotoes.cmd_4c_Alterar
227:             .Caption         = "Alterar"
228:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
229:             .PicturePosition = 13
230:             .Top             = 5
231:             .Left            = 155
232:             .Width           = 75
233:             .Height          = 75
234:             .BackColor       = RGB(255, 255, 255)
235:             .ForeColor       = RGB(90, 90, 90)
236:             .FontName        = "Tahoma"
237:             .FontSize        = 8
238:             .FontBold        = .T.
239:             .FontItalic      = .T.
240:             .Themes          = .F.
241:             .SpecialEffect   = 0
242:             .MousePointer    = 15
243:             .WordWrap        = .T.
244:             .AutoSize        = .F.
245:             .Visible         = .T.
246:         ENDWITH
247:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
248: 
249:         *-- Botao Excluir
250:         loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
251:         WITH loc_oBotoes.cmd_4c_Excluir
252:             .Caption         = "Excluir"
253:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
254:             .PicturePosition = 13
255:             .Top             = 5
256:             .Left            = 230
257:             .Width           = 75
258:             .Height          = 75
259:             .BackColor       = RGB(255, 255, 255)
260:             .ForeColor       = RGB(90, 90, 90)
261:             .FontName        = "Tahoma"
262:             .FontSize        = 8
263:             .FontBold        = .T.
264:             .FontItalic      = .T.
265:             .Themes          = .F.
266:             .SpecialEffect   = 0
267:             .MousePointer    = 15
268:             .WordWrap        = .T.
269:             .AutoSize        = .F.
270:             .Visible         = .T.
271:         ENDWITH
272:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
273: 
274:         *-- Botao Buscar
275:         loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
276:         WITH loc_oBotoes.cmd_4c_Buscar
277:             .Caption         = "Buscar"
278:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
279:             .PicturePosition = 13
280:             .Top             = 5
281:             .Left            = 305
282:             .Width           = 75
283:             .Height          = 75
284:             .BackColor       = RGB(255, 255, 255)
285:             .ForeColor       = RGB(90, 90, 90)
286:             .FontName        = "Tahoma"
287:             .FontSize        = 8
288:             .FontBold        = .T.
289:             .FontItalic      = .T.
290:             .Themes          = .F.
291:             .SpecialEffect   = 0
292:             .MousePointer    = 15
293:             .WordWrap        = .T.
294:             .AutoSize        = .F.
295:             .Visible         = .T.
296:         ENDWITH
297:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
298: 
299:         *-- Container Encerrar (canonico: Left=917, Width=90 - regra #10 CLAUDE.md)
300:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
301:         loc_oSaida = loc_oPagina.cnt_4c_Saida
302:         WITH loc_oSaida
303:             .Top         = 29
304:             .Left        = 917
305:             .Width       = 90
306:             .Height      = 85
307:             .BackStyle   = 0
308:             .BorderWidth = 0
309:             .Visible     = .T.
310:         ENDWITH
311: 
312:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
313:         WITH loc_oSaida.cmd_4c_Encerrar
314:             .Caption         = "Encerrar"
315:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
316:             .PicturePosition = 13
317:             .Top             = 5
318:             .Left            = 5
319:             .Width           = 75
320:             .Height          = 75
321:             .BackColor       = RGB(255, 255, 255)
322:             .ForeColor       = RGB(90, 90, 90)
323:             .FontName        = "Tahoma"
324:             .FontSize        = 8
325:             .FontBold        = .T.
326:             .FontItalic      = .T.
327:             .Themes          = .F.
328:             .SpecialEffect   = 0
329:             .MousePointer    = 15
330:             .WordWrap        = .T.
331:             .AutoSize        = .F.
332:             .Visible         = .T.
333:         ENDWITH
334:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
335: 
336:         *-- Grid de lotes de distribuicao (Top = 88 + 29 = 117, compensacao PageFrame.Top=-29)
337:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
338:         loc_oGrid = loc_oPagina.grd_4c_Lista
339:         loc_oGrid.RecordSource = ""
340:         loc_oGrid.ColumnCount  = 2
341:         WITH loc_oGrid
342:             .Top                = 117
343:             .Left               = 26
344:             .Width              = 880
345:             .Height             = 498
346:             .DeleteMark         = .F.
347:             .RecordMark         = .F.
348:             .GridLines          = 3
349:             .GridLineColor      = RGB(238, 238, 238)
350:             .HighlightStyle     = 2
351:             .HighlightBackColor = RGB(255, 255, 255)
352:             .HighlightForeColor = RGB(15, 41, 104)
353:             .RowHeight          = 16
354:             .ScrollBars         = 2
355:             .ReadOnly           = .T.
356:             .Visible            = .T.
357:         ENDWITH
358: 
359:         THIS.TornarControlesVisiveis(loc_oPagina)
360:     ENDPROC
361: 
362:     *===========================================================================
363:     * ConfigurarPaginaDados - Configura Page2 (estrutura base)
364:     * Campos e demais abas (Pageframe1 legado) sao adicionados nas proximas fases
365:     *===========================================================================
366:     PROTECTED PROCEDURE ConfigurarPaginaDados()
367:         LOCAL loc_oPagina
368:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
369: 
370:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
371: 
372:         *-- Cabecalho cinza (identico ao da pagina Lista) - regra #11 CLAUDE.md
373:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
374:         WITH loc_oPagina.cnt_4c_Cabecalho
375:             .Top           = 29
376:             .Left          = 0
377:             .Width         = THIS.Width
378:             .Height        = 80
379:             .BackColor     = RGB(100, 100, 100)
380:             .BorderWidth   = 0
381:             .SpecialEffect = 0
382:             .Visible       = .T.
383: 
384:             .AddObject("lbl_4c_Sombra", "Label")
385:             WITH .lbl_4c_Sombra
386:                 .Caption   = THIS.Caption
387:                 .Top       = 15
388:                 .Left      = 10
389:                 .Width     = THIS.Width
390:                 .Height    = 40
391:                 .FontName  = "Tahoma"
392:                 .FontSize  = 16
393:                 .FontBold  = .T.
394:                 .ForeColor = RGB(0, 0, 0)
395:                 .BackStyle = 0
396:                 .AutoSize  = .F.
397:                 .Visible   = .T.
398:             ENDWITH
399: 
400:             .AddObject("lbl_4c_Titulo", "Label")
401:             WITH .lbl_4c_Titulo
402:                 .Caption   = THIS.Caption
403:                 .Top       = 18
404:                 .Left      = 10
405:                 .Width     = THIS.Width
406:                 .Height    = 46

*-- Linhas 451 a 519:
451:             .AutoSize        = .F.
452:             .Visible         = .T.
453:         ENDWITH
454:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
455: 
456:         *-- Botao Cancelar (Left=80)
457:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
458:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
459:             .Caption         = "Encerrar"
460:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
461:             .PicturePosition = 13
462:             .Top             = 5
463:             .Left            = 80
464:             .Width           = 75
465:             .Height          = 75
466:             .FontName        = "Tahoma"
467:             .FontBold        = .T.
468:             .FontItalic      = .T.
469:             .FontSize        = 8
470:             .ForeColor       = RGB(90, 90, 90)
471:             .BackColor       = RGB(255, 255, 255)
472:             .Themes          = .F.
473:             .SpecialEffect   = 0
474:             .MousePointer    = 15
475:             .WordWrap        = .T.
476:             .AutoSize        = .F.
477:             .Visible         = .T.
478:         ENDWITH
479:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
480: 
481:         *-- Campos de dados (Top >= 109: 29 compensacao PageFrame + 80 altura cabecalho)
482:         *-- FASE 5/8: primeiros 6 de 12 campos (codigos, datas, cpros, codcors, codtams, empds)
483: 
484:         *-- Codigo do lote (codigos char(10))
485:         loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
486:         WITH loc_oPagina.lbl_4c_Codigo
487:             .Caption   = "C" + CHR(243) + "digo :"
488:             .Top       = 125
489:             .Left      = 30
490:             .Width     = 60
491:             .Height    = 17
492:             .FontName  = "Tahoma"
493:             .FontSize  = 8
494:             .ForeColor = RGB(90, 90, 90)
495:             .BackStyle = 0
496:             .Alignment = 0
497:             .Visible   = .T.
498:         ENDWITH
499: 
500:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
501:         WITH loc_oPagina.txt_4c_Codigo
502:             .Top       = 122
503:             .Left      = 95
504:             .Width     = 100
505:             .Height    = 21
506:             .MaxLength = 10
507:             .FontName  = "Tahoma"
508:             .FontSize  = 8
509:             .ForeColor = RGB(0, 0, 0)
510:             .Value     = ""
511:             .Visible   = .T.
512:         ENDWITH
513: 
514:         *-- Data da distribuicao (datas datetime)
515:         loc_oPagina.AddObject("lbl_4c_Data", "Label")
516:         WITH loc_oPagina.lbl_4c_Data
517:             .Caption   = "Data :"
518:             .Top       = 125
519:             .Left      = 210

*-- Linhas 839 a 922:
839:             .Visible   = .T.
840:         ENDWITH
841: 
842:         *-- BINDEVENTs de lookup (F4/F5 via KeyPress + DblClick + validacao via LostFocus)
843:         BINDEVENT(loc_oPagina.txt_4c_CodProduto, "DblClick", THIS, "AbrirBuscaCodProduto")
844:         BINDEVENT(loc_oPagina.txt_4c_CodProduto, "KeyPress", THIS, "TeclaLookupCodProduto")
845:         BINDEVENT(loc_oPagina.txt_4c_CodProduto, "KeyPress", THIS, "ValidarCodProduto")
846: 
847:         BINDEVENT(loc_oPagina.txt_4c_CodCor, "DblClick", THIS, "AbrirBuscaCodCor")
848:         BINDEVENT(loc_oPagina.txt_4c_CodCor, "KeyPress", THIS, "TeclaLookupCodCor")
849:         BINDEVENT(loc_oPagina.txt_4c_CodCor, "KeyPress", THIS, "ValidarCodCor")
850: 
851:         BINDEVENT(loc_oPagina.txt_4c_CodTamanho, "DblClick", THIS, "AbrirBuscaCodTamanho")
852:         BINDEVENT(loc_oPagina.txt_4c_CodTamanho, "KeyPress", THIS, "TeclaLookupCodTamanho")
853:         BINDEVENT(loc_oPagina.txt_4c_CodTamanho, "KeyPress", THIS, "ValidarCodTamanho")
854: 
855:         BINDEVENT(loc_oPagina.txt_4c_EmpDestino, "DblClick", THIS, "AbrirBuscaEmpDestino")
856:         BINDEVENT(loc_oPagina.txt_4c_EmpDestino, "KeyPress", THIS, "TeclaLookupEmpDestino")
857:         BINDEVENT(loc_oPagina.txt_4c_EmpDestino, "KeyPress", THIS, "ValidarEmpDestino")
858: 
859:         BINDEVENT(loc_oPagina.txt_4c_Local, "DblClick", THIS, "AbrirBuscaLocal")
860:         BINDEVENT(loc_oPagina.txt_4c_Local, "KeyPress", THIS, "TeclaLookupLocal")
861:         BINDEVENT(loc_oPagina.txt_4c_Local, "KeyPress", THIS, "ValidarLocal")
862: 
863:         THIS.ConfigurarPgPage1()
864:         THIS.ConfigurarPgPage2()
865:         THIS.ConfigurarPgPage3()
866: 
867:         THIS.TornarControlesVisiveis(loc_oPagina)
868:     ENDPROC
869: 
870:     *===========================================================================
871:     * ConfigurarPgPage1 - Sub-pagina "Filtrar" do PageFrame interno
872:     * (Pageframe1.Page1 do legado): grade de estoques/movimentacoes
873:     * disponiveis para distribuir (marcacao via checkbox) e botao Processar.
874:     * Mapeamento: SIGMVDIS.Pagina.Dados.Pageframe1.Page1 -> pgf_4c_DadosInternos.Page2
875:     * (Page1 do PageFrame interno fica reservada, seguindo o padrao ja usado
876:     * em outros forms wrapper - ver feedback_gate_fase*/regra #11 CLAUDE.md).
877:     * O PageFrame interno precisa de mais espaco vertical do que a secao de
878:     * campos "resumo do lote" acima permite; por isso ele fica posicionado
879:     * logo abaixo do cabecalho (Top=115) e cobre visualmente aquela secao
880:     * quando exibido - as duas nao coexistem na mesma area.
881:     *===========================================================================
882:     PROTECTED PROCEDURE ConfigurarPgPage1()
883:         LOCAL loc_oPgDados, loc_oPgN, loc_oGrid, loc_oGrupo
884: 
885:         loc_oPgDados = THIS.pgf_4c_Paginas.Page2
886: 
887:         *-- Cria o PageFrame interno (Pageframe1 do legado) se ainda nao existir
888:         IF !PEMSTATUS(loc_oPgDados, "pgf_4c_DadosInternos", 5)
889:             loc_oPgDados.AddObject("pgf_4c_DadosInternos", "PageFrame")
890:             WITH loc_oPgDados.pgf_4c_DadosInternos
891:                 .PageCount = 4
892:                 .Top       = 115
893:                 .Left      = 0
894:                 .Width     = THIS.Width
895:                 .Height    = 460
896:                 .Tabs      = .T.
897:                 .Visible   = .T.
898:                 .Page1.Caption = "Reservada"
899:                 .Page2.Caption = "Filtrar"
900:                 .Page3.Caption = "Distribui" + CHR(231) + CHR(227) + "o"
901:                 .Page4.Caption = "Movimenta" + CHR(231) + CHR(245) + "es"
902:             ENDWITH
903:         ENDIF
904: 
905:         loc_oPgN = loc_oPgDados.pgf_4c_DadosInternos.Page2
906: 
907:         *-- Label "Movimentacoes para distribuir" (Say5 no legado)
908:         loc_oPgN.AddObject("lbl_4c_MovsDistribuir", "Label")
909:         WITH loc_oPgN.lbl_4c_MovsDistribuir
910:             .Caption   = "Movimenta" + CHR(231) + CHR(245) + "es para distribuir"
911:             .Top       = 189
912:             .Left      = 356
913:             .Width     = 300
914:             .Height    = 17
915:             .FontName  = "Verdana"
916:             .FontSize  = 8
917:             .FontBold  = .T.
918:             .ForeColor = RGB(36, 84, 155)
919:             .BackStyle = 0
920:             .Alignment = 0
921:             .Visible   = .T.
922:         ENDWITH

*-- Linhas 942 a 985:
942:             .AutoSize        = .F.
943:             .Visible         = .T.
944:         ENDWITH
945:         BINDEVENT(loc_oPgN.cmd_4c_Processar, "Click", THIS, "BtnProcessarDistribuicaoClick")
946: 
947:         *-- CommandGroup Marcar/Desmarcar Todas (cmdMarcaDesmarca no legado)
948:         loc_oPgN.AddObject("cmg_4c_MarcaDesmarca", "CommandGroup")
949:         loc_oGrupo = loc_oPgN.cmg_4c_MarcaDesmarca
950:         WITH loc_oGrupo
951:             .ButtonCount = 2
952:             .Top         = 227
953:             .Left        = 731
954:             .Width       = 87
955:             .Height      = 205
956:             .BackStyle   = 0
957:             .BorderStyle = 0
958:             .Value       = 0
959:             .Visible     = .T.
960:         ENDWITH
961: 
962:         WITH loc_oGrupo.Buttons(1)
963:             .Caption         = "Marcar Todas"
964:             .Picture         = gc_4c_CaminhoIcones + "geral_selecionar_60.jpg"
965:             .PicturePosition = 7
966:             .Top             = 5
967:             .Left            = 5
968:             .Width           = 80
969:             .Height          = 100
970:             .FontName        = "Verdana"
971:             .FontSize        = 8
972:             .ForeColor       = RGB(36, 84, 155)
973:             .BackColor       = RGB(255, 255, 255)
974:             .Themes          = .F.
975:             .SpecialEffect   = 0
976:             .MousePointer    = 15
977:             .WordWrap        = .T.
978:             .ToolTipText     = "Marcar Todas as Opera" + CHR(231) + CHR(245) + "es"
979:         ENDWITH
980: 
981:         WITH loc_oGrupo.Buttons(2)
982:             .Caption         = "Desmarcar Todas"
983:             .Picture         = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
984:             .PicturePosition = 7
985:             .Top             = 105

*-- Linhas 996 a 1086:
996:             .WordWrap        = .T.
997:             .ToolTipText     = "Desmarcar Todas as Opera" + CHR(231) + CHR(245) + "es"
998:         ENDWITH
999:         BINDEVENT(loc_oGrupo.Buttons(1), "Click", THIS, "BtnMarcarTodasClick")
1000:         BINDEVENT(loc_oGrupo.Buttons(2), "Click", THIS, "BtnDesmarcarTodasClick")
1001: 
1002:         *-- Grid de estoques/movimentacoes (grdEstoque no legado)
1003:         loc_oPgN.AddObject("grd_4c_Estoque", "Grid")
1004:         loc_oGrid = loc_oPgN.grd_4c_Estoque
1005:         loc_oGrid.RecordSource = ""
1006:         loc_oGrid.ColumnCount  = 6
1007:         WITH loc_oGrid
1008:             .Top               = 205
1009:             .Left              = 179
1010:             .Width             = 554
1011:             .Height            = 244
1012:             .FontSize          = 8
1013:             .AllowHeaderSizing = .F.
1014:             .AllowRowSizing    = .F.
1015:             .DeleteMark        = .F.
1016:             .RecordMark        = .F.
1017:             .RowHeight         = 16
1018:             .ScrollBars        = 2
1019:             .GridLineColor     = RGB(128, 128, 128)
1020:             .Visible           = .T.
1021:         ENDWITH
1022: 
1023:         *-- Coluna 1: Checkbox de marcacao (nMarca) - regra #18 CLAUDE.md
1024:         WITH loc_oGrid.Column1
1025:             .Width           = 17
1026:             .Header1.Caption = ""
1027:         ENDWITH
1028:         loc_oGrid.Column1.AddObject("chk_4c_Marca", "CheckBox")
1029:         WITH loc_oGrid.Column1.chk_4c_Marca
1030:             .Top       = 9
1031:             .Left      = 2
1032:             .Width     = 22
1033:             .Height    = 17
1034:             .FontName  = "Arial"
1035:             .FontSize  = 8
1036:             .Alignment = 0
1037:             .Caption   = ""
1038:             .Visible   = .T.
1039:             .ReadOnly  = .F.
1040:         ENDWITH
1041:         loc_oGrid.Column1.CurrentControl = "chk_4c_Marca"
1042:         loc_oGrid.Column1.Sparse         = .F.
1043:         loc_oGrid.Column1.ReadOnly       = .F.
1044:         BINDEVENT(loc_oGrid.Column1.chk_4c_Marca, "MouseDown", THIS, "ToggleMarcaEstoqueMouseDown")
1045:         BINDEVENT(loc_oGrid.Column1.chk_4c_Marca, "KeyPress", THIS, "ToggleMarcaEstoqueKeyPress")
1046:         BINDEVENT(loc_oGrid.Column1.chk_4c_Marca, "Click", THIS, "SuprimirClickPadraoMarca")
1047: 
1048:         *-- Coluna 2: Empresa
1049:         WITH loc_oGrid.Column2
1050:             .Width             = 70
1051:             .Header1.Caption   = "Empresa"
1052:             .Header1.Alignment = 2
1053:         ENDWITH
1054: 
1055:         *-- Coluna 3: Movimentacao (Dopes)
1056:         WITH loc_oGrid.Column3
1057:             .Width             = 200
1058:             .Header1.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
1059:             .Header1.Alignment = 2
1060:         ENDWITH
1061: 
1062:         *-- Coluna 4: Numero
1063:         WITH loc_oGrid.Column4
1064:             .Width             = 80
1065:             .Header1.Caption   = "Numero"
1066:             .Header1.Alignment = 2
1067:         ENDWITH
1068: 
1069:         *-- Coluna 5: Grupo (somente leitura no legado)
1070:         WITH loc_oGrid.Column5
1071:             .Width             = 80
1072:             .Movable           = .F.
1073:             .Resizable         = .F.
1074:             .ReadOnly          = .T.
1075:             .Header1.Caption   = "Grupo"
1076:             .Header1.Alignment = 2
1077:         ENDWITH
1078: 
1079:         *-- Coluna 6: Conta (somente leitura no legado)
1080:         WITH loc_oGrid.Column6
1081:             .Width             = 80
1082:             .Movable           = .F.
1083:             .Resizable         = .F.
1084:             .ReadOnly          = .T.
1085:             .Header1.Caption   = "Conta"
1086:             .Header1.Alignment = 2

*-- Linhas 1099 a 1142:
1099:     * populados nesta fase (grade de disponiveis/estoques - fase futura); os
1100:     * metodos abaixo sao guardados por USED() e ficam inertes até a populacao.
1101:     *===========================================================================
1102:     PROTECTED PROCEDURE ConfigurarPgPage2()
1103:         LOCAL loc_oPgDados, loc_oPgN, loc_oGrid
1104: 
1105:         loc_oPgDados = THIS.pgf_4c_Paginas.Page2
1106: 
1107:         *-- Cria o PageFrame interno (Pageframe1 do legado) se ainda nao existir
1108:         IF !PEMSTATUS(loc_oPgDados, "pgf_4c_DadosInternos", 5)
1109:             loc_oPgDados.AddObject("pgf_4c_DadosInternos", "PageFrame")
1110:             WITH loc_oPgDados.pgf_4c_DadosInternos
1111:                 .PageCount = 4
1112:                 .Top       = 115
1113:                 .Left      = 0
1114:                 .Width     = THIS.Width
1115:                 .Height    = 460
1116:                 .Tabs      = .T.
1117:                 .Visible   = .T.
1118:                 .Page1.Caption = "Reservada"
1119:                 .Page2.Caption = "Filtrar"
1120:                 .Page3.Caption = "Distribui" + CHR(231) + CHR(227) + "o"
1121:                 .Page4.Caption = "Movimenta" + CHR(231) + CHR(245) + "es"
1122:             ENDWITH
1123:         ENDIF
1124: 
1125:         loc_oPgN = loc_oPgDados.pgf_4c_DadosInternos.Page3
1126: 
1127:         *-- Moldura decorativa ao redor da foto do produto (Shape5 no legado)
1128:         loc_oPgN.AddObject("shp_4c_Foto", "Shape")
1129:         WITH loc_oPgN.shp_4c_Foto
1130:             .Top           = 5
1131:             .Left          = 4
1132:             .Width         = 163
1133:             .Height        = 93
1134:             .BackStyle     = 0
1135:             .BorderStyle   = 1
1136:             .BorderWidth   = 2
1137:             .SpecialEffect = 0
1138:             .BorderColor   = RGB(36, 84, 155)
1139:             .Visible       = .T.
1140:         ENDWITH
1141: 
1142:         *-- Foto do produto (FigJpg no legado)

*-- Linhas 1149 a 1192:
1149:             .Stretch = 1
1150:             .Visible = .T.
1151:         ENDWITH
1152:         BINDEVENT(loc_oPgN.img_4c_Foto, "DblClick", THIS, "ImgFotoDblClick")
1153: 
1154:         *-- Grid de estoque disponivel para distribuicao (grdDisponivel no legado)
1155:         loc_oPgN.AddObject("grd_4c_Disponivel", "Grid")
1156:         loc_oGrid = loc_oPgN.grd_4c_Disponivel
1157:         loc_oGrid.RecordSource = ""
1158:         loc_oGrid.ColumnCount  = 7
1159:         WITH loc_oGrid
1160:             .Top                = 141
1161:             .Left               = 1
1162:             .Width              = 663
1163:             .Height             = 327
1164:             .FontName           = "Courier New"
1165:             .FontSize           = 8
1166:             .ReadOnly           = .T.
1167:             .RecordMark         = .F.
1168:             .RowHeight          = 17
1169:             .BackColor          = RGB(237, 242, 243)
1170:             .GridLineColor      = RGB(136, 189, 188)
1171:             .HighlightForeColor = RGB(15, 41, 104)
1172:             .HighlightStyle     = 2
1173:             .Visible            = .T.
1174:         ENDWITH
1175: 
1176:         WITH loc_oGrid.Column1
1177:             .FontBold          = .T.
1178:             .FontUnderline     = .T.
1179:             .Width             = 105
1180:             .Movable           = .F.
1181:             .Resizable         = .F.
1182:             .ReadOnly          = .T.
1183:             .ForeColor         = RGB(0, 0, 255)
1184:             .BackColor         = RGB(237, 242, 243)
1185:             .Header1.Caption   = "C" + CHR(243) + "digo"
1186:             .Header1.Alignment = 2
1187:         ENDWITH
1188: 
1189:         WITH loc_oGrid.Column2
1190:             .Width             = 250
1191:             .Movable           = .F.
1192:             .Resizable         = .F.

*-- Linhas 1260 a 1303:
1260:             .Header1.Alignment = 2
1261:         ENDWITH
1262: 
1263:         BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GrdDisponivelAfterRowColChange")
1264: 
1265:         *-- Grid de distribuicao por empresa (grdDistribui no legado)
1266:         loc_oPgN.AddObject("grd_4c_Distribui", "Grid")
1267:         loc_oGrid = loc_oPgN.grd_4c_Distribui
1268:         loc_oGrid.RecordSource = ""
1269:         loc_oGrid.ColumnCount  = 4
1270:         WITH loc_oGrid
1271:             .Top                = 141
1272:             .Left               = 664
1273:             .Width              = 334
1274:             .Height             = 327
1275:             .FontName           = "Courier New"
1276:             .FontSize           = 8
1277:             .RecordMark         = .F.
1278:             .RowHeight          = 17
1279:             .BackColor          = RGB(237, 242, 243)
1280:             .GridLineColor      = RGB(136, 189, 188)
1281:             .HighlightBackColor = RGB(168, 177, 202)
1282:             .HighlightForeColor = RGB(15, 41, 104)
1283:             .HighlightStyle     = 2
1284:             .Visible            = .T.
1285:         ENDWITH
1286: 
1287:         WITH loc_oGrid.Column1
1288:             .Alignment         = 2
1289:             .Enabled           = .F.
1290:             .Width             = 70
1291:             .Movable           = .F.
1292:             .Resizable         = .F.
1293:             .ReadOnly          = .T.
1294:             .ForeColor         = RGB(0, 0, 0)
1295:             .BackColor         = RGB(237, 242, 243)
1296:             .Header1.Caption   = "Empresa"
1297:             .Header1.Alignment = 2
1298:         ENDWITH
1299: 
1300:         WITH loc_oGrid.Column2
1301:             .FontBold          = .T.
1302:             .Alignment         = 1
1303:             .Enabled           = .F.

*-- Linhas 1321 a 1525:
1321:             .Header1.Caption   = "Distribuido"
1322:             .Header1.Alignment = 2
1323:         ENDWITH
1324:         BINDEVENT(loc_oGrid.Column3.Text1, "KeyPress", THIS, "DistribuidoLostFocus")
1325: 
1326:         WITH loc_oGrid.Column4
1327:             .Width             = 80
1328:             .Movable           = .F.
1329:             .Resizable         = .F.
1330:             .ReadOnly          = .F.
1331:             .ForeColor         = RGB(0, 0, 0)
1332:             .BackColor         = RGB(237, 242, 243)
1333:             .Header1.Caption   = "Local"
1334:             .Header1.Alignment = 2
1335:         ENDWITH
1336:         BINDEVENT(loc_oGrid.Column4.Text1, "DblClick",  THIS, "AbrirBuscaLocalDistribui")
1337:         BINDEVENT(loc_oGrid.Column4.Text1, "KeyPress",  THIS, "TeclaLookupLocalDistribui")
1338:         BINDEVENT(loc_oGrid.Column4.Text1, "KeyPress", THIS, "ValidarLocalDistribui")
1339: 
1340:         *-- Filtro por Grupo (get_cgrupo/get_dgrupo no legado)
1341:         loc_oPgN.AddObject("lbl_4c_FiltroGrupo", "Label")
1342:         WITH loc_oPgN.lbl_4c_FiltroGrupo
1343:             .Caption   = "Grupo :"
1344:             .Top       = 59
1345:             .Left      = 174
1346:             .Width     = 46
1347:             .Height    = 15
1348:             .FontName  = "Verdana"
1349:             .FontSize  = 8
1350:             .ForeColor = RGB(36, 84, 155)
1351:             .BackStyle = 0
1352:             .Alignment = 0
1353:             .Visible   = .T.
1354:         ENDWITH
1355: 
1356:         loc_oPgN.AddObject("txt_4c_FiltroCodGrupo", "TextBox")
1357:         WITH loc_oPgN.txt_4c_FiltroCodGrupo
1358:             .Top       = 74
1359:             .Left      = 175
1360:             .Width     = 35
1361:             .Height    = 23
1362:             .MaxLength = 3
1363:             .FontName  = "Courier New"
1364:             .FontSize  = 8
1365:             .ForeColor = RGB(0, 0, 0)
1366:             .Value     = ""
1367:             .Visible   = .T.
1368:         ENDWITH
1369: 
1370:         loc_oPgN.AddObject("txt_4c_FiltroDescGrupo", "TextBox")
1371:         WITH loc_oPgN.txt_4c_FiltroDescGrupo
1372:             .Top       = 74
1373:             .Left      = 211
1374:             .Width     = 208
1375:             .Height    = 23
1376:             .MaxLength = 20
1377:             .FontName  = "Courier New"
1378:             .FontSize  = 8
1379:             .ForeColor = RGB(0, 0, 0)
1380:             .Value     = ""
1381:             .Visible   = .T.
1382:         ENDWITH
1383: 
1384:         BINDEVENT(loc_oPgN.txt_4c_FiltroCodGrupo, "DblClick",  THIS, "AbrirBuscaFiltroGrupo")
1385:         BINDEVENT(loc_oPgN.txt_4c_FiltroCodGrupo, "KeyPress",  THIS, "TeclaLookupFiltroGrupo")
1386:         BINDEVENT(loc_oPgN.txt_4c_FiltroCodGrupo, "KeyPress", THIS, "ValidarFiltroCodGrupo")
1387:         BINDEVENT(loc_oPgN.txt_4c_FiltroDescGrupo, "KeyPress", THIS, "ValidarFiltroDescGrupo")
1388: 
1389:         *-- Filtro por Subgrupo (get_csgrupo/get_dsgrupo no legado)
1390:         loc_oPgN.AddObject("lbl_4c_FiltroSubgrupo", "Label")
1391:         WITH loc_oPgN.lbl_4c_FiltroSubgrupo
1392:             .Caption   = "Subgrupo :"
1393:             .Top       = 100
1394:             .Left      = 174
1395:             .Width     = 66
1396:             .Height    = 15
1397:             .FontName  = "Verdana"
1398:             .FontSize  = 8
1399:             .ForeColor = RGB(36, 84, 155)
1400:             .BackStyle = 0
1401:             .Alignment = 0
1402:             .Visible   = .T.
1403:         ENDWITH
1404: 
1405:         loc_oPgN.AddObject("txt_4c_FiltroCodSubgrupo", "TextBox")
1406:         WITH loc_oPgN.txt_4c_FiltroCodSubgrupo
1407:             .Top       = 115
1408:             .Left      = 175
1409:             .Width     = 52
1410:             .Height    = 23
1411:             .MaxLength = 6
1412:             .FontName  = "Courier New"
1413:             .FontSize  = 8
1414:             .ForeColor = RGB(0, 0, 0)
1415:             .Value     = ""
1416:             .Visible   = .T.
1417:         ENDWITH
1418: 
1419:         loc_oPgN.AddObject("txt_4c_FiltroDescSubgrupo", "TextBox")
1420:         WITH loc_oPgN.txt_4c_FiltroDescSubgrupo
1421:             .Top       = 115
1422:             .Left      = 228
1423:             .Width     = 236
1424:             .Height    = 23
1425:             .MaxLength = 20
1426:             .FontName  = "Courier New"
1427:             .FontSize  = 8
1428:             .ForeColor = RGB(0, 0, 0)
1429:             .Value     = ""
1430:             .Visible   = .T.
1431:         ENDWITH
1432: 
1433:         BINDEVENT(loc_oPgN.txt_4c_FiltroCodSubgrupo, "DblClick",  THIS, "AbrirBuscaFiltroSubgrupo")
1434:         BINDEVENT(loc_oPgN.txt_4c_FiltroCodSubgrupo, "KeyPress",  THIS, "TeclaLookupFiltroSubgrupo")
1435:         BINDEVENT(loc_oPgN.txt_4c_FiltroCodSubgrupo, "KeyPress", THIS, "ValidarFiltroCodSubgrupo")
1436:         BINDEVENT(loc_oPgN.txt_4c_FiltroDescSubgrupo, "KeyPress", THIS, "ValidarFiltroDescSubgrupo")
1437: 
1438:         *-- Botao Filtrar (fwbtng "Filtrar" no legado)
1439:         loc_oPgN.AddObject("cmd_4c_Filtrar", "CommandButton")
1440:         WITH loc_oPgN.cmd_4c_Filtrar
1441:             .Caption         = ""
1442:             .Picture         = gc_4c_CaminhoIcones + "geral_circulo_16.jpg"
1443:             .PicturePosition = 13
1444:             .Top             = 73
1445:             .Left            = 424
1446:             .Width           = 40
1447:             .Height          = 40
1448:             .ToolTipText     = "Filtrar"
1449:             .Themes          = .F.
1450:             .SpecialEffect   = 0
1451:             .MousePointer    = 15
1452:             .Visible         = .T.
1453:         ENDWITH
1454:         BINDEVENT(loc_oPgN.cmd_4c_Filtrar, "Click", THIS, "BtnFiltrarDisponivelClick")
1455: 
1456:         *-- Procurar produto na grade de disponiveis (lbl_produto/get_produto_inicial no legado)
1457:         loc_oPgN.AddObject("lbl_4c_Procurar", "Label")
1458:         WITH loc_oPgN.lbl_4c_Procurar
1459:             .Caption   = "Procurar"
1460:             .Top       = 100
1461:             .Left      = 4
1462:             .Width     = 51
1463:             .Height    = 15
1464:             .FontName  = "Verdana"
1465:             .FontSize  = 8
1466:             .ForeColor = RGB(36, 84, 155)
1467:             .BackStyle = 0
1468:             .Alignment = 0
1469:             .Visible   = .T.
1470:         ENDWITH
1471: 
1472:         loc_oPgN.AddObject("txt_4c_ProdutoInicial", "TextBox")
1473:         WITH loc_oPgN.txt_4c_ProdutoInicial
1474:             .Top       = 116
1475:             .Left      = 2
1476:             .Width     = 108
1477:             .Height    = 22
1478:             .MaxLength = 14
1479:             .FontName  = "Verdana"
1480:             .FontSize  = 8
1481:             .ForeColor = RGB(0, 0, 0)
1482:             .Value     = ""
1483:             .Visible   = .T.
1484:         ENDWITH
1485:         BINDEVENT(loc_oPgN.txt_4c_ProdutoInicial, "KeyPress", THIS, "ValidarProdutoInicial")
1486: 
1487:         *-- Detalhe do produto em foco na grade de disponiveis (somente leitura,
1488:         *-- preenchido em GrdDisponivelAfterRowColChange - espelha AfterRowColChange
1489:         *-- do legado). ForeColor corrigido de RGB(231,254,253) "quase-branco" para
1490:         *-- RGB(36,84,155), igual aos labels irmaos Say9/Say11 (regra #12 CLAUDE.md).
1491: 
1492:         *-- Movimentacao de origem (Emps/Dopes/Numes)
1493:         loc_oPgN.AddObject("lbl_4c_DetMovimentacao", "Label")
1494:         WITH loc_oPgN.lbl_4c_DetMovimentacao
1495:             .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
1496:             .Top       = 472
1497:             .Left      = 20
1498:             .Width     = 93
1499:             .Height    = 15
1500:             .FontName  = "Verdana"
1501:             .FontSize  = 8
1502:             .ForeColor = RGB(36, 84, 155)
1503:             .BackStyle = 0
1504:             .Alignment = 0
1505:             .Visible   = .T.
1506:         ENDWITH
1507: 
1508:         loc_oPgN.AddObject("txt_4c_DetEmp", "TextBox")
1509:         WITH loc_oPgN.txt_4c_DetEmp
1510:             .Top       = 469
1511:             .Left      = 116
1512:             .Width     = 65
1513:             .Height    = 21
1514:             .Alignment = 3
1515:             .ReadOnly  = .T.
1516:             .FontName  = "Verdana"
1517:             .FontSize  = 8
1518:             .ForeColor = RGB(0, 0, 0)
1519:             .Value     = ""
1520:             .Visible   = .T.
1521:         ENDWITH
1522: 
1523:         loc_oPgN.AddObject("txt_4c_DetDopes", "TextBox")
1524:         WITH loc_oPgN.txt_4c_DetDopes
1525:             .Top       = 469

*-- Linhas 1958 a 2001:
1958:     * futura), seguindo o mesmo padrao adotado em ConfigurarPgPage2 para
1959:     * cursor_4c_Disponivel/cursor_4c_Distribui.
1960:     *===========================================================================
1961:     PROTECTED PROCEDURE ConfigurarPgPage3()
1962:         LOCAL loc_oPgDados, loc_oPgN, loc_oPgOps, loc_oGrid, loc_oGrupo, loc_oCnt
1963: 
1964:         loc_oPgDados = THIS.pgf_4c_Paginas.Page2
1965: 
1966:         *-- Cria o PageFrame interno (Pageframe1 do legado) se ainda nao existir
1967:         IF !PEMSTATUS(loc_oPgDados, "pgf_4c_DadosInternos", 5)
1968:             loc_oPgDados.AddObject("pgf_4c_DadosInternos", "PageFrame")
1969:             WITH loc_oPgDados.pgf_4c_DadosInternos
1970:                 .PageCount = 4
1971:                 .Top       = 115
1972:                 .Left      = 0
1973:                 .Width     = THIS.Width
1974:                 .Height    = 460
1975:                 .Tabs      = .T.
1976:                 .Visible   = .T.
1977:                 .Page1.Caption = "Reservada"
1978:                 .Page2.Caption = "Filtrar"
1979:                 .Page3.Caption = "Distribui" + CHR(231) + CHR(227) + "o"
1980:                 .Page4.Caption = "Movimenta" + CHR(231) + CHR(245) + "es"
1981:             ENDWITH
1982:         ENDIF
1983: 
1984:         loc_oPgN = loc_oPgDados.pgf_4c_DadosInternos.Page4
1985: 
1986:         *-- PageFrame interno de Movimentacoes/Itens (pgOperacoes no legado)
1987:         loc_oPgN.AddObject("pgf_4c_Operacoes", "PageFrame")
1988:         loc_oPgOps = loc_oPgN.pgf_4c_Operacoes
1989:         WITH loc_oPgOps
1990:             .PageCount = 2
1991:             .Top        = 191
1992:             .Left       = 1
1993:             .Width      = 997
1994:             .Height     = 377
1995:             .Tabs       = .T.
1996:             .Visible    = .T.
1997:             .Page1.Caption = "Movimenta" + CHR(231) + CHR(245) + "es"
1998:             .Page2.Caption = "Itens"
1999:         ENDWITH
2000: 
2001:         *-- Grid de movimentacoes de origem (grdCabOperas no legado)

*-- Linhas 2255 a 2334:
2255: 
2256:         *-- Ativa a pagina "Itens" ordenando/filtrando pelo cabecalho em foco
2257:         *-- (pgItens.Activate no legado)
2258:         BINDEVENT(loc_oPgOps.Page2, "Activate", THIS, "AtivarPgItensOperacoes")
2259: 
2260:         *-- CommandGroup com o botao de finalizacao (cmdProcessar/btnProcessar
2261:         *-- no legado)
2262:         loc_oPgN.AddObject("cmg_4c_ProcessarOperacoes", "CommandGroup")
2263:         loc_oGrupo = loc_oPgN.cmg_4c_ProcessarOperacoes
2264:         WITH loc_oGrupo
2265:             .ButtonCount = 1
2266:             .Top         = 11
2267:             .Left        = 733
2268:             .Width       = 80
2269:             .Height      = 100
2270:             .BackStyle   = 0
2271:             .BorderStyle = 0
2272:             .Value       = 0
2273:             .Visible     = .T.
2274:         ENDWITH
2275: 
2276:         WITH loc_oGrupo.Buttons(1)
2277:             .Caption         = "Processar Distribui" + CHR(231) + CHR(227) + "o"
2278:             .Picture         = gc_4c_CaminhoIcones + "geral_datas_60.jpg"
2279:             .PicturePosition = 7
2280:             .Top             = 0
2281:             .Left            = 0
2282:             .Width           = 80
2283:             .Height          = 100
2284:             .FontName        = "Verdana"
2285:             .FontSize        = 8
2286:             .ForeColor       = RGB(36, 84, 155)
2287:             .BackColor       = RGB(255, 255, 255)
2288:             .Themes          = .F.
2289:             .SpecialEffect   = 0
2290:             .MousePointer    = 15
2291:             .WordWrap        = .T.
2292:             .ToolTipText     = "Gerar Opera" + CHR(231) + CHR(245) + "es dos Pedidos"
2293:         ENDWITH
2294:         BINDEVENT(loc_oGrupo.Buttons(1), "Click", THIS, "BtnProcessarOperacoesClick")
2295: 
2296:         *-- Container com a observacao do lote (cntOperacao no legado)
2297:         loc_oPgN.AddObject("cnt_4c_Operacao", "Container")
2298:         loc_oCnt = loc_oPgN.cnt_4c_Operacao
2299:         WITH loc_oCnt
2300:             .Top         = 13
2301:             .Left        = 3
2302:             .Width       = 564
2303:             .Height      = 165
2304:             .BackStyle   = 0
2305:             .BorderWidth = 0
2306:             .SpecialEffect = 0
2307:             .Visible     = .T.
2308:         ENDWITH
2309: 
2310:         loc_oCnt.AddObject("lbl_4c_Obs", "Label")
2311:         WITH loc_oCnt.lbl_4c_Obs
2312:             .Caption   = "Obs. :"
2313:             .Top       = 10
2314:             .Left      = 12
2315:             .Width     = 40
2316:             .Height    = 17
2317:             .FontName  = "Verdana"
2318:             .FontSize  = 8
2319:             .FontBold  = .T.
2320:             .ForeColor = RGB(36, 84, 155)
2321:             .BackStyle = 0
2322:             .Alignment = 0
2323:             .Visible   = .T.
2324:         ENDWITH
2325: 
2326:         loc_oCnt.AddObject("txt_4c_CodObs", "TextBox")
2327:         WITH loc_oCnt.txt_4c_CodObs
2328:             .Top               = 10
2329:             .Left              = 52
2330:             .Width             = 27
2331:             .Height            = 20
2332:             .Margin            = 2
2333:             .MaxLength         = 3
2334:             .Alignment         = 3

*-- Linhas 2364 a 2991:
2364:     * Cobre TODOS os campos editaveis do BO (16 propriedades - PK/auditoria
2365:     * ficam de fora, pois sao geradas/preenchidas internamente pelo BO).
2366:     *===========================================================================
2367:     PROCEDURE FormParaBO()
2368:         LOCAL loc_oPg2
2369:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2370: 
2371:         THIS.this_oBusinessObject.this_cCodigo        = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
2372:         THIS.this_oBusinessObject.this_dData          = loc_oPg2.txt_4c_Data.Value
2373:         THIS.this_oBusinessObject.this_cCodProduto    = ALLTRIM(loc_oPg2.txt_4c_CodProduto.Value)
2374:         THIS.this_oBusinessObject.this_cCodCor        = ALLTRIM(loc_oPg2.txt_4c_CodCor.Value)
2375:         THIS.this_oBusinessObject.this_cCodTamanho    = ALLTRIM(loc_oPg2.txt_4c_CodTamanho.Value)
2376:         THIS.this_oBusinessObject.this_cEmpDestino    = ALLTRIM(loc_oPg2.txt_4c_EmpDestino.Value)
2377:         THIS.this_oBusinessObject.this_cLocal         = ALLTRIM(loc_oPg2.txt_4c_Local.Value)
2378:         THIS.this_oBusinessObject.this_cEmpDopNum     = ALLTRIM(loc_oPg2.txt_4c_EmpDopNum.Value)
2379:         THIS.this_oBusinessObject.this_cOriDopNum     = ALLTRIM(loc_oPg2.txt_4c_OriDopNum.Value)
2380:         THIS.this_oBusinessObject.this_cEmpGrupoEstab = ALLTRIM(loc_oPg2.txt_4c_EmpGrupoEstab.Value)
2381:         THIS.this_oBusinessObject.this_nQtdOrigem     = loc_oPg2.txt_4c_QtdOrigem.Value
2382:         THIS.this_oBusinessObject.this_nQtd           = loc_oPg2.txt_4c_Qtd.Value
2383:     ENDPROC
2384: 
2385:     *===========================================================================
2386:     * BOParaForm - Transfere valores do Business Object para a Page2 (Form)
2387:     * Cobre TODOS os campos editaveis do BO.
2388:     *===========================================================================
2389:     PROCEDURE BOParaForm()
2390:         LOCAL loc_oPg2
2391:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2392: 
2393:         loc_oPg2.txt_4c_Codigo.Value        = THIS.this_oBusinessObject.this_cCodigo
2394:         loc_oPg2.txt_4c_Data.Value          = ConverterParaData(THIS.this_oBusinessObject.this_dData)
2395:         loc_oPg2.txt_4c_CodProduto.Value    = THIS.this_oBusinessObject.this_cCodProduto
2396:         loc_oPg2.txt_4c_CodCor.Value        = THIS.this_oBusinessObject.this_cCodCor
2397:         loc_oPg2.txt_4c_CodTamanho.Value    = THIS.this_oBusinessObject.this_cCodTamanho
2398:         loc_oPg2.txt_4c_EmpDestino.Value    = THIS.this_oBusinessObject.this_cEmpDestino
2399:         loc_oPg2.txt_4c_Local.Value         = THIS.this_oBusinessObject.this_cLocal
2400:         loc_oPg2.txt_4c_EmpDopNum.Value     = THIS.this_oBusinessObject.this_cEmpDopNum
2401:         loc_oPg2.txt_4c_OriDopNum.Value     = THIS.this_oBusinessObject.this_cOriDopNum
2402:         loc_oPg2.txt_4c_EmpGrupoEstab.Value = THIS.this_oBusinessObject.this_cEmpGrupoEstab
2403:         loc_oPg2.txt_4c_QtdOrigem.Value     = THIS.this_oBusinessObject.this_nQtdOrigem
2404:         loc_oPg2.txt_4c_Qtd.Value           = THIS.this_oBusinessObject.this_nQtd
2405:     ENDPROC
2406: 
2407:     *===========================================================================
2408:     * LimparCampos - Limpa os valores dos campos da Page2
2409:     * Cobre TODOS os campos editaveis do BO.
2410:     *===========================================================================
2411:     PROCEDURE LimparCampos()
2412:         LOCAL loc_oPg2
2413:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2414: 
2415:         loc_oPg2.txt_4c_Codigo.Value        = ""
2416:         loc_oPg2.txt_4c_Data.Value          = {}
2417:         loc_oPg2.txt_4c_CodProduto.Value    = ""
2418:         loc_oPg2.txt_4c_CodCor.Value        = ""
2419:         loc_oPg2.txt_4c_CodTamanho.Value    = ""
2420:         loc_oPg2.txt_4c_EmpDestino.Value    = ""
2421:         loc_oPg2.txt_4c_Local.Value         = ""
2422:         loc_oPg2.txt_4c_EmpDopNum.Value     = ""
2423:         loc_oPg2.txt_4c_OriDopNum.Value     = ""
2424:         loc_oPg2.txt_4c_EmpGrupoEstab.Value = ""
2425:         loc_oPg2.txt_4c_QtdOrigem.Value     = 0
2426:         loc_oPg2.txt_4c_Qtd.Value           = 0
2427:     ENDPROC
2428: 
2429:     *===========================================================================
2430:     * CarregarLista - Carrega lotes de distribuicao (Codigos/Datas) no Grid
2431:     * Espelha o legado: Select Distinct Codigos, Datas from SigPrDis
2432:     *===========================================================================
2433:     PROCEDURE CarregarLista()
2434:         LOCAL loc_lResultado, loc_oGrid
2435:         loc_lResultado = .F.
2436: 
2437:         TRY
2438:             IF THIS.this_oBusinessObject.Buscar("")
2439:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
2440: 
2441:                 *-- RecordSource ANTES de ControlSource (auto-bind seria sobrescrito - Problema 48)
2442:                 loc_oGrid.ColumnCount   = 2
2443:                 loc_oGrid.RecordSource  = "cursor_4c_Dados"
2444: 
2445:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
2446:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.datas"
2447: 
2448:                 loc_oGrid.Column1.Width    = 150
2449:                 loc_oGrid.Column2.Width    = 725
2450: 
2451:                 loc_oGrid.Column1.ReadOnly = .T.
2452:                 loc_oGrid.Column2.ReadOnly = .T.
2453: 
2454:                 *-- Headers APOS RecordSource (OBRIGATORIO - RecordSource reseta captions)
2455:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
2456:                 loc_oGrid.Column2.Header1.Caption = "Data"
2457: 
2458:                 THIS.FormatarGridLista(loc_oGrid)
2459:                 loc_lResultado = .T.
2460:             ENDIF
2461:         CATCH TO loc_oErro
2462:             MsgErro(loc_oErro.Message, "Formsigmvdis.CarregarLista")
2463:         ENDTRY
2464: 
2465:         RETURN loc_lResultado
2466:     ENDPROC
2467: 
2468:     *===========================================================================
2469:     * AlternarPagina - Alterna entre Lista (1) e Dados (2)
2470:     *===========================================================================
2471:     PROCEDURE AlternarPagina(par_nPagina)
2472:         LOCAL loc_lResultado
2473:         loc_lResultado = .F.
2474: 
2475:         TRY
2476:             IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
2477:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
2478:                 IF par_nPagina = 1
2479:                     THIS.CarregarLista()
2480:                 ENDIF
2481:                 loc_lResultado = .T.
2482:             ENDIF
2483:         CATCH TO loc_oErro
2484:             MsgErro(loc_oErro.Message, "Formsigmvdis.AlternarPagina")
2485:         ENDTRY
2486: 
2487:         RETURN loc_lResultado
2488:     ENDPROC
2489: 
2490:     *===========================================================================
2491:     * FormatarGridLista - Formata visual do grid da lista
2492:     *===========================================================================
2493:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
2494:         WITH par_oGrid
2495:             .FontName = "Verdana"
2496:             .FontSize = 8
2497:         ENDWITH
2498:     ENDPROC
2499: 
2500:     *===========================================================================
2501:     * HabilitarCampos - Habilita/desabilita os controles editaveis da Page2
2502:     * Generico: percorre a pagina e ajusta .Enabled de campos de entrada
2503:     *===========================================================================
2504:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
2505:         LOCAL loc_oPg2, loc_nI, loc_oCtrl
2506:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2507: 
2508:         FOR loc_nI = 1 TO loc_oPg2.ControlCount
2509:             loc_oCtrl = loc_oPg2.Controls(loc_nI)
2510:             IF VARTYPE(loc_oCtrl) = "O" AND INLIST(UPPER(loc_oCtrl.BaseClass), "TEXTBOX", "EDITBOX", "COMBOBOX", "CHECKBOX", "OPTIONGROUP")
2511:                 IF PEMSTATUS(loc_oCtrl, "Enabled", 5)
2512:                     loc_oCtrl.Enabled = par_lHabilitar
2513:                 ENDIF
2514:             ENDIF
2515:         ENDFOR
2516: 
2517:         loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
2518:     ENDPROC
2519: 
2520:     *===========================================================================
2521:     * AjustarBotoesPorModo - Ajusta caption/estado dos botoes de acao da Page2
2522:     * (cnt_4c_BotoesAcao) conforme this_cModoAtual (INCLUIR/ALTERAR/VISUALIZAR).
2523:     * Chamado junto com HabilitarCampos() apos this_cModoAtual ser definido.
2524:     * Confirmar fica desabilitado em VISUALIZAR (regra #20 CLAUDE.md: modo
2525:     * somente-leitura nunca deixa o botao de gravar acionavel); Cancelar vira
2526:     * "Voltar" nesse modo, pois nao ha alteracao a descartar.
2527:     *===========================================================================
2528:     PROCEDURE AjustarBotoesPorModo()
2529:         LOCAL loc_oBotoes
2530:         loc_oBotoes = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
2531: 
2532:         DO CASE
2533:             CASE THIS.this_cModoAtual = "VISUALIZAR"
2534:                 loc_oBotoes.cmd_4c_Confirmar.Enabled = .F.
2535:                 loc_oBotoes.cmd_4c_Cancelar.Caption  = "Voltar"
2536: 
2537:             CASE INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2538:                 loc_oBotoes.cmd_4c_Confirmar.Enabled = .T.
2539:                 loc_oBotoes.cmd_4c_Cancelar.Caption  = "Cancelar"
2540: 
2541:             OTHERWISE
2542:                 loc_oBotoes.cmd_4c_Confirmar.Enabled = .T.
2543:                 loc_oBotoes.cmd_4c_Cancelar.Caption  = "Cancelar"
2544:         ENDCASE
2545:     ENDPROC
2546: 
2547:     *===========================================================================
2548:     * LOOKUPS (F4/F5 + DblClick + validacao em LostFocus)
2549:     * Padrao: docs/lookup_implementation.md - 3 metodos por campo
2550:     *===========================================================================
2551: 
2552:     *-- Produto (cpros) -> SigCdPro (cpros/dpros)
2553:     PROCEDURE TeclaLookupCodProduto(par_nKeyCode, par_nShiftAltCtrl)
2554:         IF INLIST(par_nKeyCode, 115, 116)
2555:             THIS.AbrirBuscaCodProduto()
2556:         ENDIF
2557:     ENDPROC
2558: 
2559:     PROCEDURE AbrirBuscaCodProduto()
2560:         LOCAL loc_oPg2, loc_cValorAtual, loc_oBusca
2561:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2562:         loc_cValorAtual = ALLTRIM(loc_oPg2.txt_4c_CodProduto.Value)
2563: 
2564:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2565:             "SigCdPro", "cursor_4c_BuscaProduto", "cpros", loc_cValorAtual, ;
2566:             "Buscar Produto")
2567: 
2568:         IF VARTYPE(loc_oBusca) = "O"
2569:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2570:                 IF USED("cursor_4c_BuscaProduto")
2571:                     loc_oPg2.txt_4c_CodProduto.Value = ALLTRIM(cursor_4c_BuscaProduto.cpros)
2572:                 ENDIF
2573:             ELSE
2574:                 IF loc_oBusca.this_lAchouRegistro OR EMPTY(loc_cValorAtual)
2575:                     loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
2576:                     loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
2577:                     loc_oBusca.Show()
2578:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProduto")
2579:                         loc_oPg2.txt_4c_CodProduto.Value = ALLTRIM(cursor_4c_BuscaProduto.cpros)
2580:                     ENDIF
2581:                 ENDIF
2582:             ENDIF
2583:             loc_oBusca.Release()
2584:         ENDIF
2585: 
2586:         IF USED("cursor_4c_BuscaProduto")
2587:             USE IN cursor_4c_BuscaProduto
2588:         ENDIF
2589:     ENDPROC
2590: 
2591:     PROCEDURE ValidarCodProduto(par_nKeyCode, par_nShiftAltCtrl)
2592:         LOCAL loc_oPg2, loc_cValor, loc_cSQL, loc_nResultado
2593:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2594:         loc_cValor = UPPER(ALLTRIM(loc_oPg2.txt_4c_CodProduto.Value))
2595: 
2596:         IF EMPTY(loc_cValor)
2597:             RETURN
2598:         ENDIF
2599: 
2600:         loc_cSQL = "SELECT cpros, dpros FROM SigCdPro WHERE CAST(cpros AS VARCHAR(20)) = " + EscaparSQL(loc_cValor)
2601:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaProduto")
2602: 
2603:         IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ValidaProduto") = 1
2604:             loc_oPg2.txt_4c_CodProduto.Value = ALLTRIM(cursor_4c_ValidaProduto.cpros)
2605:             IF USED("cursor_4c_ValidaProduto")
2606:                 USE IN cursor_4c_ValidaProduto
2607:             ENDIF
2608:         ELSE
2609:             IF USED("cursor_4c_ValidaProduto")
2610:                 USE IN cursor_4c_ValidaProduto
2611:             ENDIF
2612:             *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
2613:             THIS.AbrirBuscaCodProduto()
2614:         ENDIF
2615:     ENDPROC
2616: 
2617:     *-- Cor (codcors) -> SigCdCor (cods/descs)
2618:     PROCEDURE TeclaLookupCodCor(par_nKeyCode, par_nShiftAltCtrl)
2619:         IF INLIST(par_nKeyCode, 115, 116)
2620:             THIS.AbrirBuscaCodCor()
2621:         ENDIF
2622:     ENDPROC
2623: 
2624:     PROCEDURE AbrirBuscaCodCor()
2625:         LOCAL loc_oPg2, loc_cValorAtual, loc_oBusca
2626:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2627:         loc_cValorAtual = ALLTRIM(loc_oPg2.txt_4c_CodCor.Value)
2628: 
2629:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2630:             "SigCdCor", "cursor_4c_BuscaCor", "cods", loc_cValorAtual, ;
2631:             "Buscar Cor")
2632: 
2633:         IF VARTYPE(loc_oBusca) = "O"
2634:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2635:                 IF USED("cursor_4c_BuscaCor")
2636:                     loc_oPg2.txt_4c_CodCor.Value = ALLTRIM(cursor_4c_BuscaCor.cods)
2637:                 ENDIF
2638:             ELSE
2639:                 IF loc_oBusca.this_lAchouRegistro OR EMPTY(loc_cValorAtual)
2640:                     loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "digo")
2641:                     loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
2642:                     loc_oBusca.Show()
2643:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCor")
2644:                         loc_oPg2.txt_4c_CodCor.Value = ALLTRIM(cursor_4c_BuscaCor.cods)
2645:                     ENDIF
2646:                 ENDIF
2647:             ENDIF
2648:             loc_oBusca.Release()
2649:         ENDIF
2650: 
2651:         IF USED("cursor_4c_BuscaCor")
2652:             USE IN cursor_4c_BuscaCor
2653:         ENDIF
2654:     ENDPROC
2655: 
2656:     PROCEDURE ValidarCodCor(par_nKeyCode, par_nShiftAltCtrl)
2657:         LOCAL loc_oPg2, loc_cValor, loc_cSQL, loc_nResultado
2658:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2659:         loc_cValor = UPPER(ALLTRIM(loc_oPg2.txt_4c_CodCor.Value))
2660: 
2661:         IF EMPTY(loc_cValor)
2662:             RETURN
2663:         ENDIF
2664: 
2665:         loc_cSQL = "SELECT cods, descs FROM SigCdCor WHERE CAST(cods AS VARCHAR(20)) = " + EscaparSQL(loc_cValor)
2666:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaCor")
2667: 
2668:         IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ValidaCor") = 1
2669:             loc_oPg2.txt_4c_CodCor.Value = ALLTRIM(cursor_4c_ValidaCor.cods)
2670:             IF USED("cursor_4c_ValidaCor")
2671:                 USE IN cursor_4c_ValidaCor
2672:             ENDIF
2673:         ELSE
2674:             IF USED("cursor_4c_ValidaCor")
2675:                 USE IN cursor_4c_ValidaCor
2676:             ENDIF
2677:             *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
2678:             THIS.AbrirBuscaCodCor()
2679:         ENDIF
2680:     ENDPROC
2681: 
2682:     *-- Tamanho (codtams) -> SigCdTam (cods/descs)
2683:     PROCEDURE TeclaLookupCodTamanho(par_nKeyCode, par_nShiftAltCtrl)
2684:         IF INLIST(par_nKeyCode, 115, 116)
2685:             THIS.AbrirBuscaCodTamanho()
2686:         ENDIF
2687:     ENDPROC
2688: 
2689:     PROCEDURE AbrirBuscaCodTamanho()
2690:         LOCAL loc_oPg2, loc_cValorAtual, loc_oBusca
2691:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2692:         loc_cValorAtual = ALLTRIM(loc_oPg2.txt_4c_CodTamanho.Value)
2693: 
2694:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2695:             "SigCdTam", "cursor_4c_BuscaTamanho", "cods", loc_cValorAtual, ;
2696:             "Buscar Tamanho")
2697: 
2698:         IF VARTYPE(loc_oBusca) = "O"
2699:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2700:                 IF USED("cursor_4c_BuscaTamanho")
2701:                     loc_oPg2.txt_4c_CodTamanho.Value = ALLTRIM(cursor_4c_BuscaTamanho.cods)
2702:                 ENDIF
2703:             ELSE
2704:                 IF loc_oBusca.this_lAchouRegistro OR EMPTY(loc_cValorAtual)
2705:                     loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "digo")
2706:                     loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
2707:                     loc_oBusca.Show()
2708:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTamanho")
2709:                         loc_oPg2.txt_4c_CodTamanho.Value = ALLTRIM(cursor_4c_BuscaTamanho.cods)
2710:                     ENDIF
2711:                 ENDIF
2712:             ENDIF
2713:             loc_oBusca.Release()
2714:         ENDIF
2715: 
2716:         IF USED("cursor_4c_BuscaTamanho")
2717:             USE IN cursor_4c_BuscaTamanho
2718:         ENDIF
2719:     ENDPROC
2720: 
2721:     PROCEDURE ValidarCodTamanho(par_nKeyCode, par_nShiftAltCtrl)
2722:         LOCAL loc_oPg2, loc_cValor, loc_cSQL, loc_nResultado
2723:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2724:         loc_cValor = UPPER(ALLTRIM(loc_oPg2.txt_4c_CodTamanho.Value))
2725: 
2726:         IF EMPTY(loc_cValor)
2727:             RETURN
2728:         ENDIF
2729: 
2730:         loc_cSQL = "SELECT cods, descs FROM SigCdTam WHERE CAST(cods AS VARCHAR(20)) = " + EscaparSQL(loc_cValor)
2731:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaTamanho")
2732: 
2733:         IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ValidaTamanho") = 1
2734:             loc_oPg2.txt_4c_CodTamanho.Value = ALLTRIM(cursor_4c_ValidaTamanho.cods)
2735:             IF USED("cursor_4c_ValidaTamanho")
2736:                 USE IN cursor_4c_ValidaTamanho
2737:             ENDIF
2738:         ELSE
2739:             IF USED("cursor_4c_ValidaTamanho")
2740:                 USE IN cursor_4c_ValidaTamanho
2741:             ENDIF
2742:             *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
2743:             THIS.AbrirBuscaCodTamanho()
2744:         ENDIF
2745:     ENDPROC
2746: 
2747:     *-- Empresa de destino (empds) -> SigCdEmp (cemps/razas)
2748:     PROCEDURE TeclaLookupEmpDestino(par_nKeyCode, par_nShiftAltCtrl)
2749:         IF INLIST(par_nKeyCode, 115, 116)
2750:             THIS.AbrirBuscaEmpDestino()
2751:         ENDIF
2752:     ENDPROC
2753: 
2754:     PROCEDURE AbrirBuscaEmpDestino()
2755:         LOCAL loc_oPg2, loc_cValorAtual, loc_oBusca
2756:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2757:         loc_cValorAtual = ALLTRIM(loc_oPg2.txt_4c_EmpDestino.Value)
2758: 
2759:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2760:             "SigCdEmp", "cursor_4c_BuscaEmpresa", "cemps", loc_cValorAtual, ;
2761:             "Buscar Empresa")
2762: 
2763:         IF VARTYPE(loc_oBusca) = "O"
2764:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2765:                 IF USED("cursor_4c_BuscaEmpresa")
2766:                     loc_oPg2.txt_4c_EmpDestino.Value = ALLTRIM(cursor_4c_BuscaEmpresa.cemps)
2767:                 ENDIF
2768:             ELSE
2769:                 IF loc_oBusca.this_lAchouRegistro OR EMPTY(loc_cValorAtual)
2770:                     loc_oBusca.mAddColuna("cemps", "", "C" + CHR(243) + "digo")
2771:                     loc_oBusca.mAddColuna("razas", "", "Raz" + CHR(227) + "o Social")
2772:                     loc_oBusca.Show()
2773:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpresa")
2774:                         loc_oPg2.txt_4c_EmpDestino.Value = ALLTRIM(cursor_4c_BuscaEmpresa.cemps)
2775:                     ENDIF
2776:                 ENDIF
2777:             ENDIF
2778:             loc_oBusca.Release()
2779:         ENDIF
2780: 
2781:         IF USED("cursor_4c_BuscaEmpresa")
2782:             USE IN cursor_4c_BuscaEmpresa
2783:         ENDIF
2784:     ENDPROC
2785: 
2786:     PROCEDURE ValidarEmpDestino(par_nKeyCode, par_nShiftAltCtrl)
2787:         LOCAL loc_oPg2, loc_cValor, loc_cSQL, loc_nResultado
2788:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2789:         loc_cValor = UPPER(ALLTRIM(loc_oPg2.txt_4c_EmpDestino.Value))
2790: 
2791:         IF EMPTY(loc_cValor)
2792:             RETURN
2793:         ENDIF
2794: 
2795:         loc_cSQL = "SELECT cemps, razas FROM SigCdEmp WHERE CAST(cemps AS VARCHAR(20)) = " + EscaparSQL(loc_cValor)
2796:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaEmpresa")
2797: 
2798:         IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ValidaEmpresa") = 1
2799:             loc_oPg2.txt_4c_EmpDestino.Value = ALLTRIM(cursor_4c_ValidaEmpresa.cemps)
2800:             IF USED("cursor_4c_ValidaEmpresa")
2801:                 USE IN cursor_4c_ValidaEmpresa
2802:             ENDIF
2803:         ELSE
2804:             IF USED("cursor_4c_ValidaEmpresa")
2805:                 USE IN cursor_4c_ValidaEmpresa
2806:             ENDIF
2807:             *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
2808:             THIS.AbrirBuscaEmpDestino()
2809:         ENDIF
2810:     ENDPROC
2811: 
2812:     *-- Local de estoque (locals) -> SigPrLcl (codigos/descricaos)
2813:     PROCEDURE TeclaLookupLocal(par_nKeyCode, par_nShiftAltCtrl)
2814:         IF INLIST(par_nKeyCode, 115, 116)
2815:             THIS.AbrirBuscaLocal()
2816:         ENDIF
2817:     ENDPROC
2818: 
2819:     PROCEDURE AbrirBuscaLocal()
2820:         LOCAL loc_oPg2, loc_cValorAtual, loc_oBusca
2821:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2822:         loc_cValorAtual = ALLTRIM(loc_oPg2.txt_4c_Local.Value)
2823: 
2824:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2825:             "SigPrLcl", "cursor_4c_BuscaLocal", "codigos", loc_cValorAtual, ;
2826:             "Buscar Localiza" + CHR(231) + CHR(227) + "o")
2827: 
2828:         IF VARTYPE(loc_oBusca) = "O"
2829:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2830:                 IF USED("cursor_4c_BuscaLocal")
2831:                     loc_oPg2.txt_4c_Local.Value = ALLTRIM(cursor_4c_BuscaLocal.codigos)
2832:                 ENDIF
2833:             ELSE
2834:                 IF loc_oBusca.this_lAchouRegistro OR EMPTY(loc_cValorAtual)
2835:                     loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
2836:                     loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
2837:                     loc_oBusca.Show()
2838:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLocal")
2839:                         loc_oPg2.txt_4c_Local.Value = ALLTRIM(cursor_4c_BuscaLocal.codigos)
2840:                     ENDIF
2841:                 ENDIF
2842:             ENDIF
2843:             loc_oBusca.Release()
2844:         ENDIF
2845: 
2846:         IF USED("cursor_4c_BuscaLocal")
2847:             USE IN cursor_4c_BuscaLocal
2848:         ENDIF
2849:     ENDPROC
2850: 
2851:     PROCEDURE ValidarLocal(par_nKeyCode, par_nShiftAltCtrl)
2852:         LOCAL loc_oPg2, loc_cValor, loc_cSQL, loc_nResultado
2853:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2854:         loc_cValor = UPPER(ALLTRIM(loc_oPg2.txt_4c_Local.Value))
2855: 
2856:         IF EMPTY(loc_cValor)
2857:             RETURN
2858:         ENDIF
2859: 
2860:         loc_cSQL = "SELECT codigos, descricaos FROM SigPrLcl WHERE CAST(codigos AS VARCHAR(20)) = " + EscaparSQL(loc_cValor)
2861:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaLocal")
2862: 
2863:         IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ValidaLocal") = 1
2864:             loc_oPg2.txt_4c_Local.Value = ALLTRIM(cursor_4c_ValidaLocal.codigos)
2865:             IF USED("cursor_4c_ValidaLocal")
2866:                 USE IN cursor_4c_ValidaLocal
2867:             ENDIF
2868:         ELSE
2869:             IF USED("cursor_4c_ValidaLocal")
2870:                 USE IN cursor_4c_ValidaLocal
2871:             ENDIF
2872:             *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
2873:             THIS.AbrirBuscaLocal()
2874:         ENDIF
2875:     ENDPROC
2876: 
2877:     *===========================================================================
2878:     * PGDADOSINTERNOS.PAGE2 (Filtrar) - handlers da grade de estoques
2879:     * Espelham SIGMVDIS.Pagina.Dados.Pageframe1.Page1 do legado.
2880:     * PUBLIC: exigido por BINDEVENT (regra #3 CLAUDE.md).
2881:     *===========================================================================
2882: 
2883:     *-- Marca/Desmarca Todas (cmdMarcaDesmarca.btnMarcar/btnDesmarcar no legado)
2884:     *-- Legado: Update crSigMvDis Set nMarca = 1/0
2885:     PROCEDURE BtnMarcarTodasClick()
2886:         IF USED("cursor_4c_Estoque")
2887:             SELECT cursor_4c_Estoque
2888:             REPLACE ALL nMarca WITH 1
2889:             THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page2.grd_4c_Estoque.Refresh()
2890:         ENDIF
2891:     ENDPROC
2892: 
2893:     PROCEDURE BtnDesmarcarTodasClick()
2894:         IF USED("cursor_4c_Estoque")
2895:             SELECT cursor_4c_Estoque
2896:             REPLACE ALL nMarca WITH 0
2897:             THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page2.grd_4c_Estoque.Refresh()
2898:         ENDIF
2899:     ENDPROC
2900: 
2901:     *-- Checkbox da Coluna1 (nMarca): alterna no MouseDown/KeyPress, igual ao
2902:     *-- legado (Click/MouseUp so fazem NoDefault - regra #18 CLAUDE.md)
2903:     PROCEDURE ToggleMarcaEstoqueMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
2904:         IF USED("cursor_4c_Estoque")
2905:             REPLACE nMarca WITH IIF(cursor_4c_Estoque.nMarca = 0, 1, 0) IN cursor_4c_Estoque
2906:             THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page2.grd_4c_Estoque.Refresh()
2907:         ENDIF
2908:     ENDPROC
2909: 
2910:     PROCEDURE ToggleMarcaEstoqueKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2911:         IF INLIST(par_nKeyCode, 13, 32) AND USED("cursor_4c_Estoque")
2912:             REPLACE nMarca WITH IIF(cursor_4c_Estoque.nMarca = 0, 1, 0) IN cursor_4c_Estoque
2913:             THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page2.grd_4c_Estoque.Refresh()
2914:         ENDIF
2915:     ENDPROC
2916: 
2917:     PROCEDURE SuprimirClickPadraoMarca()
2918:         NODEFAULT
2919:     ENDPROC
2920: 
2921:     *-- Processar (fwbtng "processar" no legado): conta selecionados e avanca
2922:     *-- para a sub-pagina de Distribuicao (Page3 - implementada em fase futura)
2923:     PROCEDURE BtnProcessarDistribuicaoClick()
2924:         LOCAL loc_nSelecionados
2925:         loc_nSelecionados = 0
2926: 
2927:         IF USED("cursor_4c_Estoque")
2928:             SELECT cursor_4c_Estoque
2929:             COUNT FOR nMarca = 1 TO loc_nSelecionados
2930:         ENDIF
2931: 
2932:         IF loc_nSelecionados = 0
2933:             MsgAviso("Nenhum estoque foi selecionado.", "Aviso")
2934:         ELSE
2935:             THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.ActivePage = 3
2936:         ENDIF
2937:     ENDPROC
2938: 
2939:     *===========================================================================
2940:     * PGDADOSINTERNOS.PAGE3 (Distribuicao) - handlers
2941:     * Espelham SIGMVDIS.Pagina.Dados.Pageframe1.Page2 do legado.
2942:     * cursor_4c_Disponivel/cursor_4c_Distribui ainda nao sao populados nesta
2943:     * fase (fase futura) - todo handler que os referencia esta guardado por
2944:     * USED() e fica inerte enquanto os cursores nao existem.
2945:     * PUBLIC: exigido por BINDEVENT (regra #3 CLAUDE.md).
2946:     *===========================================================================
2947: 
2948:     *-- AfterRowColChange do grd_4c_Disponivel: mostra detalhe do produto em
2949:     *-- foco (Grupo/Subgrupo/Linha/Fornecedor/Modelo/Grupo Venda/Preco/Peso/Foto)
2950:     *-- Espelha o legado (AfterRowColChange de grdDisponivel).
2951:     PROCEDURE GrdDisponivelAfterRowColChange(par_nColIndex)
2952:         LOCAL loc_oPgN, loc_cCpros, loc_cSQL, loc_nResultado
2953:         LOCAL loc_cMoeDetqs, loc_cMoeVenda, loc_nCotAlvo, loc_nCotVenda
2954:         LOCAL loc_cFigJpgs, loc_cArqTemp, loc_cFoto, loc_cOriDopNums
2955: 
2956:         IF !USED("cursor_4c_Disponivel") OR RECCOUNT("cursor_4c_Disponivel") = 0
2957:             RETURN
2958:         ENDIF
2959: 
2960:         loc_cCpros = ALLTRIM(NVL(cursor_4c_Disponivel.Cpros, ""))
2961:         IF EMPTY(loc_cCpros)
2962:             RETURN
2963:         ENDIF
2964: 
2965:         loc_oPgN = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page3
2966: 
2967:         loc_cSQL = "SELECT a.cpros, a.ifors, a.reffs, a.cgrus, a.sgrus, a.pesoms," + ;
2968:             " a.colecoes, a.linhas, a.CodFinP, a.pvens, a.moevs, a.FigJpgs," + ;
2969:             " g.dgrus, c.rclis, b.descs AS desccol, l.descs AS desclin" + ;
2970:             " FROM SigCdPro a" + ;
2971:             " LEFT JOIN SigCdGrp g ON a.cgrus = g.cgrus" + ;
2972:             " LEFT JOIN SigCdCli c ON a.ifors = c.iclis" + ;
2973:             " LEFT JOIN SigCdCol b ON a.colecoes = b.colecoes" + ;
2974:             " LEFT JOIN SigCdLin l ON a.linhas = l.linhas" + ;
2975:             " WHERE a.cpros = " + EscaparSQL(loc_cCpros)
2976: 
2977:         IF USED("cursor_4c_DetalheProduto")
2978:             USE IN cursor_4c_DetalheProduto
2979:         ENDIF
2980:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DetalheProduto")
2981: 
2982:         IF loc_nResultado < 0 OR !USED("cursor_4c_DetalheProduto") OR RECCOUNT("cursor_4c_DetalheProduto") = 0
2983:             RETURN
2984:         ENDIF
2985: 
2986:         SELECT cursor_4c_DetalheProduto
2987:         GO TOP
2988: 
2989:         loc_oPgN.txt_4c_DetCodFornecedor.Value  = ALLTRIM(NVL(cursor_4c_DetalheProduto.ifors, ""))
2990:         loc_oPgN.txt_4c_DetDescFornecedor.Value = ALLTRIM(NVL(cursor_4c_DetalheProduto.rclis, ""))
2991:         loc_oPgN.txt_4c_DetRefFornecedor.Value  = ALLTRIM(NVL(cursor_4c_DetalheProduto.reffs, ""))

*-- Linhas 3105 a 3148:
3105:     *-- Duplo clique na foto: abre zoom (Do Form SigOpZom no legado). Sem o
3106:     *-- form legado no acervo, cai para o visualizador padrao do Windows
3107:     *-- (regra #27 CLAUDE.md - nunca chamar form nao portado sem guard).
3108:     PROCEDURE ImgFotoDblClick()
3109:         LOCAL loc_cCpros, loc_cSQL, loc_nResultado, loc_cFigJpgs
3110:         LOCAL loc_cArqTemp, loc_cFoto, loc_cCaption
3111: 
3112:         IF !USED("cursor_4c_Disponivel") OR RECCOUNT("cursor_4c_Disponivel") = 0
3113:             RETURN
3114:         ENDIF
3115: 
3116:         loc_cCpros = ALLTRIM(NVL(cursor_4c_Disponivel.Cpros, ""))
3117:         IF EMPTY(loc_cCpros)
3118:             RETURN
3119:         ENDIF
3120: 
3121:         loc_cSQL = "SELECT cpros, dpros, FigJpgs FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCpros)
3122:         IF USED("cursor_4c_ZoomProduto")
3123:             USE IN cursor_4c_ZoomProduto
3124:         ENDIF
3125:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ZoomProduto")
3126: 
3127:         IF loc_nResultado < 0 OR !USED("cursor_4c_ZoomProduto") OR RECCOUNT("cursor_4c_ZoomProduto") = 0
3128:             RETURN
3129:         ENDIF
3130: 
3131:         SELECT cursor_4c_ZoomProduto
3132:         GO TOP
3133:         loc_cFigJpgs = NVL(cursor_4c_ZoomProduto.FigJpgs, "")
3134:         loc_cCaption = "Produto : " + loc_cCpros + " - " + ALLTRIM(NVL(cursor_4c_ZoomProduto.dpros, ""))
3135:         IF USED("cursor_4c_ZoomProduto")
3136:             USE IN cursor_4c_ZoomProduto
3137:         ENDIF
3138: 
3139:         IF EMPTY(loc_cFigJpgs) OR ISNULL(loc_cFigJpgs)
3140:             RETURN
3141:         ENDIF
3142: 
3143:         loc_cArqTemp = SYS(2023) + "\" + SYS(2015) + ".jpg"
3144:         loc_cFoto = STRCONV(;
3145:             STRTRAN(STRTRAN(STRTRAN(loc_cFigJpgs, ;
3146:                 "data:image/png;base64,", ""), ;
3147:                 "data:image/jpeg;base64,", ""), ;
3148:                 "data:image/jpg;base64,", ""), 14)

*-- Linhas 3165 a 3822:
3165:     *-- Filtrar (fwbtng "Filtrar" no legado): filtra grd_4c_Disponivel por
3166:     *-- Grupo/Subgrupo digitados. Legado usa Index+Set Key; aqui usamos
3167:     *-- SET FILTER TO, mais seguro sobre cursor vindo de SQLEXEC.
3168:     PROCEDURE BtnFiltrarDisponivelClick()
3169:         LOCAL loc_oPgN, loc_cCodGrupo, loc_cCodSubgrupo, loc_cFiltro
3170: 
3171:         IF !USED("cursor_4c_Disponivel")
3172:             RETURN
3173:         ENDIF
3174: 
3175:         loc_oPgN         = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page3
3176:         loc_cCodGrupo    = ALLTRIM(loc_oPgN.txt_4c_FiltroCodGrupo.Value)
3177:         loc_cCodSubgrupo = ALLTRIM(loc_oPgN.txt_4c_FiltroCodSubgrupo.Value)
3178: 
3179:         SELECT cursor_4c_Disponivel
3180: 
3181:         DO CASE
3182:             CASE EMPTY(loc_cCodGrupo) AND EMPTY(loc_cCodSubgrupo)
3183:                 loc_cFiltro = ""
3184:             CASE !EMPTY(loc_cCodGrupo) AND EMPTY(loc_cCodSubgrupo)
3185:                 loc_cFiltro = "ALLTRIM(Cgrus) = " + EscaparSQL(loc_cCodGrupo)
3186:             CASE EMPTY(loc_cCodGrupo) AND !EMPTY(loc_cCodSubgrupo)
3187:                 loc_cFiltro = "ALLTRIM(Sgrus) = " + EscaparSQL(loc_cCodSubgrupo)
3188:             OTHERWISE
3189:                 loc_cFiltro = "ALLTRIM(Cgrus) = " + EscaparSQL(loc_cCodGrupo) + ;
3190:                     " AND ALLTRIM(Sgrus) = " + EscaparSQL(loc_cCodSubgrupo)
3191:         ENDCASE
3192: 
3193:         SET FILTER TO &loc_cFiltro.
3194:         GO TOP
3195:         loc_oPgN.grd_4c_Disponivel.Refresh()
3196:     ENDPROC
3197: 
3198:     *-- Procurar produto na grade de disponiveis (get_produto_inicial no legado)
3199:     PROCEDURE ValidarProdutoInicial(par_nKeyCode, par_nShiftAltCtrl)
3200:         LOCAL loc_oPgN, loc_cValor, loc_nRegAtual
3201: 
3202:         loc_oPgN  = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page3
3203:         loc_cValor = ALLTRIM(loc_oPgN.txt_4c_ProdutoInicial.Value)
3204: 
3205:         IF EMPTY(loc_cValor) OR !USED("cursor_4c_Disponivel")
3206:             RETURN
3207:         ENDIF
3208: 
3209:         SELECT cursor_4c_Disponivel
3210:         loc_nRegAtual = RECNO()
3211:         GO TOP
3212:         LOCATE FOR ALLTRIM(Cpros) = loc_cValor
3213:         IF EOF()
3214:             GO loc_nRegAtual
3215:         ENDIF
3216:         loc_oPgN.grd_4c_Disponivel.Refresh()
3217:     ENDPROC
3218: 
3219:     *-- Filtro Grupo (get_cgrupo/get_dgrupo no legado) -> SigCdGrp (cgrus/dgrus)
3220:     PROCEDURE TeclaLookupFiltroGrupo(par_nKeyCode, par_nShiftAltCtrl)
3221:         IF INLIST(par_nKeyCode, 115, 116)
3222:             THIS.AbrirBuscaFiltroGrupo()
3223:         ENDIF
3224:     ENDPROC
3225: 
3226:     PROCEDURE AbrirBuscaFiltroGrupo()
3227:         LOCAL loc_oPgN, loc_cValorAtual, loc_oBusca
3228:         loc_oPgN = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page3
3229:         loc_cValorAtual = ALLTRIM(loc_oPgN.txt_4c_FiltroCodGrupo.Value)
3230: 
3231:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3232:             "SigCdGrp", "cursor_4c_BuscaFiltroGrupo", "cgrus", loc_cValorAtual, "Grupos")
3233: 
3234:         IF VARTYPE(loc_oBusca) = "O"
3235:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
3236:                 IF USED("cursor_4c_BuscaFiltroGrupo")
3237:                     loc_oPgN.txt_4c_FiltroCodGrupo.Value  = ALLTRIM(cursor_4c_BuscaFiltroGrupo.cgrus)
3238:                     loc_oPgN.txt_4c_FiltroDescGrupo.Value = ALLTRIM(cursor_4c_BuscaFiltroGrupo.dgrus)
3239:                 ENDIF
3240:             ELSE
3241:                 IF loc_oBusca.this_lAchouRegistro OR EMPTY(loc_cValorAtual)
3242:                     loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
3243:                     loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
3244:                     loc_oBusca.Show()
3245:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFiltroGrupo")
3246:                         loc_oPgN.txt_4c_FiltroCodGrupo.Value  = ALLTRIM(cursor_4c_BuscaFiltroGrupo.cgrus)
3247:                         loc_oPgN.txt_4c_FiltroDescGrupo.Value = ALLTRIM(cursor_4c_BuscaFiltroGrupo.dgrus)
3248:                     ENDIF
3249:                 ENDIF
3250:             ENDIF
3251:             loc_oBusca.Release()
3252:         ENDIF
3253: 
3254:         IF USED("cursor_4c_BuscaFiltroGrupo")
3255:             USE IN cursor_4c_BuscaFiltroGrupo
3256:         ENDIF
3257:     ENDPROC
3258: 
3259:     PROCEDURE ValidarFiltroCodGrupo(par_nKeyCode, par_nShiftAltCtrl)
3260:         LOCAL loc_oPgN, loc_cValor, loc_nResultado
3261:         loc_oPgN  = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page3
3262:         loc_cValor = UPPER(ALLTRIM(loc_oPgN.txt_4c_FiltroCodGrupo.Value))
3263: 
3264:         IF EMPTY(loc_cValor)
3265:             loc_oPgN.txt_4c_FiltroDescGrupo.Value = ""
3266:             RETURN
3267:         ENDIF
3268: 
3269:         loc_nResultado = SQLEXEC(gnConnHandle, "SELECT cgrus, dgrus FROM SigCdGrp WHERE " + ;
3270:             "CAST(cgrus AS VARCHAR(20)) = " + EscaparSQL(loc_cValor), "cursor_4c_ValidaFiltroGrupo")
3271: 
3272:         IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ValidaFiltroGrupo") = 1
3273:             loc_oPgN.txt_4c_FiltroCodGrupo.Value  = ALLTRIM(cursor_4c_ValidaFiltroGrupo.cgrus)
3274:             loc_oPgN.txt_4c_FiltroDescGrupo.Value = ALLTRIM(cursor_4c_ValidaFiltroGrupo.dgrus)
3275:             IF USED("cursor_4c_ValidaFiltroGrupo")
3276:                 USE IN cursor_4c_ValidaFiltroGrupo
3277:             ENDIF
3278:         ELSE
3279:             IF USED("cursor_4c_ValidaFiltroGrupo")
3280:                 USE IN cursor_4c_ValidaFiltroGrupo
3281:             ENDIF
3282:             loc_oPgN.txt_4c_FiltroDescGrupo.Value = ""
3283:             THIS.AbrirBuscaFiltroGrupo()
3284:         ENDIF
3285:     ENDPROC
3286: 
3287:     PROCEDURE ValidarFiltroDescGrupo(par_nKeyCode, par_nShiftAltCtrl)
3288:         LOCAL loc_oPgN, loc_cValor, loc_nResultado
3289:         loc_oPgN  = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page3
3290:         loc_cValor = UPPER(ALLTRIM(loc_oPgN.txt_4c_FiltroDescGrupo.Value))
3291: 
3292:         IF EMPTY(loc_cValor)
3293:             loc_oPgN.txt_4c_FiltroCodGrupo.Value = ""
3294:             RETURN
3295:         ENDIF
3296: 
3297:         loc_nResultado = SQLEXEC(gnConnHandle, "SELECT cgrus, dgrus FROM SigCdGrp WHERE " + ;
3298:             "CAST(dgrus AS VARCHAR(60)) = " + EscaparSQL(loc_cValor), "cursor_4c_ValidaFiltroGrupo")
3299: 
3300:         IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ValidaFiltroGrupo") = 1
3301:             loc_oPgN.txt_4c_FiltroCodGrupo.Value  = ALLTRIM(cursor_4c_ValidaFiltroGrupo.cgrus)
3302:             loc_oPgN.txt_4c_FiltroDescGrupo.Value = ALLTRIM(cursor_4c_ValidaFiltroGrupo.dgrus)
3303:             IF USED("cursor_4c_ValidaFiltroGrupo")
3304:                 USE IN cursor_4c_ValidaFiltroGrupo
3305:             ENDIF
3306:         ELSE
3307:             IF USED("cursor_4c_ValidaFiltroGrupo")
3308:                 USE IN cursor_4c_ValidaFiltroGrupo
3309:             ENDIF
3310:             loc_oPgN.txt_4c_FiltroCodGrupo.Value = ""
3311:             THIS.AbrirBuscaFiltroGrupo()
3312:         ENDIF
3313:     ENDPROC
3314: 
3315:     *-- Filtro Subgrupo (get_csgrupo/get_dsgrupo no legado) -> SigCdPsg (codigos/descricaos)
3316:     PROCEDURE TeclaLookupFiltroSubgrupo(par_nKeyCode, par_nShiftAltCtrl)
3317:         IF INLIST(par_nKeyCode, 115, 116)
3318:             THIS.AbrirBuscaFiltroSubgrupo()
3319:         ENDIF
3320:     ENDPROC
3321: 
3322:     PROCEDURE AbrirBuscaFiltroSubgrupo()
3323:         LOCAL loc_oPgN, loc_cValorAtual, loc_oBusca
3324:         loc_oPgN = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page3
3325:         loc_cValorAtual = ALLTRIM(loc_oPgN.txt_4c_FiltroCodSubgrupo.Value)
3326: 
3327:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3328:             "SigCdPsg", "cursor_4c_BuscaFiltroSubgrupo", "codigos", loc_cValorAtual, "Sub-Grupos")
3329: 
3330:         IF VARTYPE(loc_oBusca) = "O"
3331:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
3332:                 IF USED("cursor_4c_BuscaFiltroSubgrupo")
3333:                     loc_oPgN.txt_4c_FiltroCodSubgrupo.Value  = ALLTRIM(cursor_4c_BuscaFiltroSubgrupo.codigos)
3334:                     loc_oPgN.txt_4c_FiltroDescSubgrupo.Value = ALLTRIM(cursor_4c_BuscaFiltroSubgrupo.descricaos)
3335:                 ENDIF
3336:             ELSE
3337:                 IF loc_oBusca.this_lAchouRegistro OR EMPTY(loc_cValorAtual)
3338:                     loc_oBusca.mAddColuna("codigos", "", "Sub-Grupo")
3339:                     loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
3340:                     loc_oBusca.mAddColuna("cgrus", "", "Grupo")
3341:                     loc_oBusca.Show()
3342:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFiltroSubgrupo")
3343:                         loc_oPgN.txt_4c_FiltroCodSubgrupo.Value  = ALLTRIM(cursor_4c_BuscaFiltroSubgrupo.codigos)
3344:                         loc_oPgN.txt_4c_FiltroDescSubgrupo.Value = ALLTRIM(cursor_4c_BuscaFiltroSubgrupo.descricaos)
3345:                     ENDIF
3346:                 ENDIF
3347:             ENDIF
3348:             loc_oBusca.Release()
3349:         ENDIF
3350: 
3351:         IF USED("cursor_4c_BuscaFiltroSubgrupo")
3352:             USE IN cursor_4c_BuscaFiltroSubgrupo
3353:         ENDIF
3354:     ENDPROC
3355: 
3356:     PROCEDURE ValidarFiltroCodSubgrupo(par_nKeyCode, par_nShiftAltCtrl)
3357:         LOCAL loc_oPgN, loc_cValor, loc_nResultado
3358:         loc_oPgN  = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page3
3359:         loc_cValor = UPPER(ALLTRIM(loc_oPgN.txt_4c_FiltroCodSubgrupo.Value))
3360: 
3361:         IF EMPTY(loc_cValor)
3362:             loc_oPgN.txt_4c_FiltroDescSubgrupo.Value = ""
3363:             RETURN
3364:         ENDIF
3365: 
3366:         loc_nResultado = SQLEXEC(gnConnHandle, "SELECT codigos, descricaos FROM SigCdPsg WHERE " + ;
3367:             "CAST(codigos AS VARCHAR(20)) = " + EscaparSQL(loc_cValor), "cursor_4c_ValidaFiltroSubgrupo")
3368: 
3369:         IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ValidaFiltroSubgrupo") = 1
3370:             loc_oPgN.txt_4c_FiltroCodSubgrupo.Value  = ALLTRIM(cursor_4c_ValidaFiltroSubgrupo.codigos)
3371:             loc_oPgN.txt_4c_FiltroDescSubgrupo.Value = ALLTRIM(cursor_4c_ValidaFiltroSubgrupo.descricaos)
3372:             IF USED("cursor_4c_ValidaFiltroSubgrupo")
3373:                 USE IN cursor_4c_ValidaFiltroSubgrupo
3374:             ENDIF
3375:         ELSE
3376:             IF USED("cursor_4c_ValidaFiltroSubgrupo")
3377:                 USE IN cursor_4c_ValidaFiltroSubgrupo
3378:             ENDIF
3379:             loc_oPgN.txt_4c_FiltroDescSubgrupo.Value = ""
3380:             THIS.AbrirBuscaFiltroSubgrupo()
3381:         ENDIF
3382:     ENDPROC
3383: 
3384:     PROCEDURE ValidarFiltroDescSubgrupo(par_nKeyCode, par_nShiftAltCtrl)
3385:         LOCAL loc_oPgN, loc_cValor, loc_nResultado
3386:         loc_oPgN  = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page3
3387:         loc_cValor = UPPER(ALLTRIM(loc_oPgN.txt_4c_FiltroDescSubgrupo.Value))
3388: 
3389:         IF EMPTY(loc_cValor)
3390:             loc_oPgN.txt_4c_FiltroCodSubgrupo.Value = ""
3391:             RETURN
3392:         ENDIF
3393: 
3394:         loc_nResultado = SQLEXEC(gnConnHandle, "SELECT codigos, descricaos FROM SigCdPsg WHERE " + ;
3395:             "CAST(descricaos AS VARCHAR(60)) = " + EscaparSQL(loc_cValor), "cursor_4c_ValidaFiltroSubgrupo")
3396: 
3397:         IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ValidaFiltroSubgrupo") = 1
3398:             loc_oPgN.txt_4c_FiltroCodSubgrupo.Value  = ALLTRIM(cursor_4c_ValidaFiltroSubgrupo.codigos)
3399:             loc_oPgN.txt_4c_FiltroDescSubgrupo.Value = ALLTRIM(cursor_4c_ValidaFiltroSubgrupo.descricaos)
3400:             IF USED("cursor_4c_ValidaFiltroSubgrupo")
3401:                 USE IN cursor_4c_ValidaFiltroSubgrupo
3402:             ENDIF
3403:         ELSE
3404:             IF USED("cursor_4c_ValidaFiltroSubgrupo")
3405:                 USE IN cursor_4c_ValidaFiltroSubgrupo
3406:             ENDIF
3407:             loc_oPgN.txt_4c_FiltroCodSubgrupo.Value = ""
3408:             THIS.AbrirBuscaFiltroSubgrupo()
3409:         ENDIF
3410:     ENDPROC
3411: 
3412:     *-- Coluna "Distribuido" do grd_4c_Distribui: recalcula saldo entre
3413:     *-- cursor_4c_Disponivel/cursor_4c_Distribui (Calcula_Saldo no legado).
3414:     PROCEDURE DistribuidoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3415:         THIS.RecalcularSaldoDistribuicao()
3416:     ENDPROC
3417: 
3418:     PROCEDURE RecalcularSaldoDistribuicao()
3419:         LOCAL loc_oPgN, loc_cCpros, loc_cCodCor, loc_cCodTam, loc_nTotalDistr
3420: 
3421:         IF !USED("cursor_4c_Distribui") OR !USED("cursor_4c_Disponivel")
3422:             RETURN
3423:         ENDIF
3424: 
3425:         loc_oPgN = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page3
3426: 
3427:         SELECT cursor_4c_Distribui
3428:         IF NVL(QtdDistr, 0) <= 0
3429:             REPLACE QtdDistr WITH 0
3430:         ENDIF
3431: 
3432:         loc_cCpros  = ALLTRIM(NVL(cursor_4c_Disponivel.Cpros, ""))
3433:         loc_cCodCor = ALLTRIM(NVL(cursor_4c_Disponivel.CodCors, ""))
3434:         loc_cCodTam = ALLTRIM(NVL(cursor_4c_Disponivel.CodTams, ""))
3435: 
3436:         SELECT cursor_4c_Distribui
3437:         SUM QtdDistr TO loc_nTotalDistr FOR ALLTRIM(NVL(Cpros, "")) = loc_cCpros ;
3438:             AND ALLTRIM(NVL(CodCors, "")) = loc_cCodCor AND ALLTRIM(NVL(CodTams, "")) = loc_cCodTam
3439: 
3440:         IF NVL(cursor_4c_Disponivel.Sqtds, 0) - loc_nTotalDistr < 0
3441:             MsgAviso("Saldo insuficiente para movimentar.", "Aviso")
3442:         ENDIF
3443: 
3444:         SELECT cursor_4c_Disponivel
3445:         REPLACE QtdSaida WITH loc_nTotalDistr, QtdSaldo WITH NVL(Sqtds, 0) - loc_nTotalDistr
3446: 
3447:         loc_oPgN.grd_4c_Disponivel.Refresh()
3448:         loc_oPgN.grd_4c_Distribui.Refresh()
3449:     ENDPROC
3450: 
3451:     *-- Coluna "Local" do grd_4c_Distribui -> SigPrLcl (codigos/descricaos)
3452:     PROCEDURE TeclaLookupLocalDistribui(par_nKeyCode, par_nShiftAltCtrl)
3453:         IF INLIST(par_nKeyCode, 115, 116)
3454:             THIS.AbrirBuscaLocalDistribui()
3455:         ENDIF
3456:     ENDPROC
3457: 
3458:     PROCEDURE AbrirBuscaLocalDistribui()
3459:         LOCAL loc_oGrid, loc_cValorAtual, loc_oBusca
3460:         loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page3.grd_4c_Distribui
3461:         loc_cValorAtual = ALLTRIM(loc_oGrid.Column4.Text1.Value)
3462: 
3463:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3464:             "SigPrLcl", "cursor_4c_BuscaLocalDistribui", "codigos", loc_cValorAtual, ;
3465:             "Buscar Localiza" + CHR(231) + CHR(227) + "o")
3466: 
3467:         IF VARTYPE(loc_oBusca) = "O"
3468:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
3469:                 IF USED("cursor_4c_BuscaLocalDistribui")
3470:                     loc_oGrid.Column4.Text1.Value = ALLTRIM(cursor_4c_BuscaLocalDistribui.codigos)
3471:                 ENDIF
3472:             ELSE
3473:                 IF loc_oBusca.this_lAchouRegistro OR EMPTY(loc_cValorAtual)
3474:                     loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
3475:                     loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
3476:                     loc_oBusca.Show()
3477:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLocalDistribui")
3478:                         loc_oGrid.Column4.Text1.Value = ALLTRIM(cursor_4c_BuscaLocalDistribui.codigos)
3479:                     ENDIF
3480:                 ENDIF
3481:             ENDIF
3482:             loc_oBusca.Release()
3483:         ENDIF
3484: 
3485:         IF USED("cursor_4c_BuscaLocalDistribui")
3486:             USE IN cursor_4c_BuscaLocalDistribui
3487:         ENDIF
3488:     ENDPROC
3489: 
3490:     PROCEDURE ValidarLocalDistribui(par_nKeyCode, par_nShiftAltCtrl)
3491:         LOCAL loc_oGrid, loc_cValor, loc_nResultado
3492:         loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page3.grd_4c_Distribui
3493:         loc_cValor = UPPER(ALLTRIM(loc_oGrid.Column4.Text1.Value))
3494: 
3495:         IF EMPTY(loc_cValor)
3496:             RETURN
3497:         ENDIF
3498: 
3499:         loc_nResultado = SQLEXEC(gnConnHandle, "SELECT codigos, descricaos FROM SigPrLcl WHERE " + ;
3500:             "CAST(codigos AS VARCHAR(20)) = " + EscaparSQL(loc_cValor), "cursor_4c_ValidaLocalDistribui")
3501: 
3502:         IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ValidaLocalDistribui") = 1
3503:             loc_oGrid.Column4.Text1.Value = ALLTRIM(cursor_4c_ValidaLocalDistribui.codigos)
3504:             IF USED("cursor_4c_ValidaLocalDistribui")
3505:                 USE IN cursor_4c_ValidaLocalDistribui
3506:             ENDIF
3507:         ELSE
3508:             IF USED("cursor_4c_ValidaLocalDistribui")
3509:                 USE IN cursor_4c_ValidaLocalDistribui
3510:             ENDIF
3511:             *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
3512:             THIS.AbrirBuscaLocalDistribui()
3513:         ENDIF
3514:     ENDPROC
3515: 
3516:     *===========================================================================
3517:     * PGDADOSINTERNOS.PAGE4 (Movimentacoes) - handlers
3518:     * Espelham SIGMVDIS.Pagina.Dados.Pageframe1.Page3 do legado.
3519:     * cursor_4c_CabOpera/cursor_4c_ItnOpera ainda nao sao populados nesta fase
3520:     * (fase futura) - todo handler que os referencia esta guardado por USED()
3521:     * e fica inerte enquanto os cursores nao existem.
3522:     * PUBLIC: exigido por BINDEVENT (regra #3 CLAUDE.md).
3523:     *===========================================================================
3524: 
3525:     *-- Ativa a pagina "Itens" do pgf_4c_Operacoes: ordena/filtra
3526:     *-- cursor_4c_ItnOpera pelo cabecalho em foco (pgItens.Activate no legado)
3527:     PROCEDURE AtivarPgItensOperacoes()
3528:         LOCAL loc_oGrid
3529: 
3530:         IF !USED("cursor_4c_ItnOpera") OR !USED("cursor_4c_CabOpera")
3531:             RETURN
3532:         ENDIF
3533: 
3534:         SELECT cursor_4c_ItnOpera
3535:         SET ORDER TO Ordem
3536:         SET KEY TO cursor_4c_CabOpera.Dopes + STR(cursor_4c_CabOpera.Numes, 6) IN cursor_4c_ItnOpera
3537:         GO TOP IN cursor_4c_ItnOpera
3538: 
3539:         loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page4.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas
3540:         loc_oGrid.Refresh()
3541:         loc_oGrid.Column1.SetFocus()
3542:     ENDPROC
3543: 
3544:     *-- Processar Distribuicao (cmdProcessar.btnProcessar no legado): mesmas
3545:     *-- duas guard clauses do legado, transcritas literalmente (regra #21
3546:     *-- CLAUDE.md - a condicao ao redor da validacao e regra). A geracao das
3547:     *-- movimentacoes (crSigMvCab/crSigMvItn/crSigMvHst/crSigOpEtq/SigPrDis,
3548:     *-- etiquetas e commit no SQL Server - cerca de 400 linhas no legado) fica
3549:     *-- para fase futura, junto com a populacao de
3550:     *-- cursor_4c_Disponivel/cursor_4c_Distribui (ver ConfigurarPgPage2).
3551:     PROCEDURE BtnProcessarOperacoesClick()
3552:         LOCAL loc_nTotalDistribuido, loc_nSaldoNegativo
3553: 
3554:         IF !USED("cursor_4c_Distribui") OR !USED("cursor_4c_Disponivel")
3555:             RETURN
3556:         ENDIF
3557: 
3558:         loc_nTotalDistribuido = 0
3559:         SELECT cursor_4c_Distribui
3560:         COUNT FOR QtdDistr > 0 TO loc_nTotalDistribuido
3561:         IF loc_nTotalDistribuido = 0
3562:             MsgAviso("Nenhum produto foi informado para distribuir.", "Aviso")
3563:             RETURN
3564:         ENDIF
3565: 
3566:         loc_nSaldoNegativo = 0
3567:         SELECT cursor_4c_Disponivel
3568:         GO TOP
3569:         COUNT FOR QtdSaldo < 0 TO loc_nSaldoNegativo
3570:         IF loc_nSaldoNegativo > 0
3571:             MsgAviso("Existe produtos distribu" + CHR(237) + "dos que est" + CHR(227) + "o ficando com saldo negativo." + CHR(13) + ;
3572:                 "Favor checar antes de processar.", "Aviso")
3573:             RETURN
3574:         ENDIF
3575:     ENDPROC
3576: 
3577:     *===========================================================================
3578:     * BtnIncluirClick - Inicia um novo lote de distribuicao
3579:     *===========================================================================
3580:     PROCEDURE BtnIncluirClick()
3581:         TRY
3582:             THIS.this_oBusinessObject.NovoRegistro()
3583:             THIS.this_cModoAtual = "INCLUIR"
3584:             THIS.LimparCampos()
3585:             THIS.HabilitarCampos(.T.)
3586:             THIS.AjustarBotoesPorModo()
3587:             THIS.BOParaForm()
3588:             THIS.AlternarPagina(2)
3589:         CATCH TO loc_oErro
3590:             MsgErro(loc_oErro.Message, "Formsigmvdis.BtnIncluirClick")
3591:         ENDTRY
3592:     ENDPROC
3593: 
3594:     *===========================================================================
3595:     * BtnVisualizarClick - Carrega o lote selecionado em modo somente leitura
3596:     *===========================================================================
3597:     PROCEDURE BtnVisualizarClick()
3598:         LOCAL loc_cCodigo
3599:         TRY
3600:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
3601:                 MsgAviso("Selecione um lote de distribui" + CHR(231) + CHR(227) + "o na lista.", "Aten" + CHR(231) + CHR(227) + "o")
3602:             ELSE
3603:                 SELECT cursor_4c_Dados
3604:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
3605: 
3606:                 IF THIS.this_oBusinessObject.BuscarItensPorLote(loc_cCodigo)
3607:                     THIS.this_oBusinessObject.this_cCodigo = loc_cCodigo
3608:                     THIS.this_cModoAtual = "VISUALIZAR"
3609:                     THIS.BOParaForm()
3610:                     THIS.HabilitarCampos(.F.)
3611:                     THIS.AjustarBotoesPorModo()
3612:                     THIS.AlternarPagina(2)
3613:                 ENDIF
3614:             ENDIF
3615:         CATCH TO loc_oErro
3616:             MsgErro(loc_oErro.Message, "Formsigmvdis.BtnVisualizarClick")
3617:         ENDTRY
3618:     ENDPROC
3619: 
3620:     *===========================================================================
3621:     * BtnAlterarClick - Carrega o lote selecionado para edicao
3622:     *===========================================================================
3623:     PROCEDURE BtnAlterarClick()
3624:         LOCAL loc_cCodigo
3625:         TRY
3626:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
3627:                 MsgAviso("Selecione um lote de distribui" + CHR(231) + CHR(227) + "o na lista.", "Aten" + CHR(231) + CHR(227) + "o")
3628:             ELSE
3629:                 SELECT cursor_4c_Dados
3630:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
3631: 
3632:                 IF THIS.this_oBusinessObject.BuscarItensPorLote(loc_cCodigo)
3633:                     THIS.this_oBusinessObject.this_cCodigo = loc_cCodigo
3634:                     THIS.this_oBusinessObject.EditarRegistro()
3635:                     THIS.this_cModoAtual = "ALTERAR"
3636:                     THIS.BOParaForm()
3637:                     THIS.HabilitarCampos(.T.)
3638:                     THIS.AjustarBotoesPorModo()
3639:                     THIS.AlternarPagina(2)
3640:                 ENDIF
3641:             ENDIF
3642:         CATCH TO loc_oErro
3643:             MsgErro(loc_oErro.Message, "Formsigmvdis.BtnAlterarClick")
3644:         ENDTRY
3645:     ENDPROC
3646: 
3647:     *===========================================================================
3648:     * BtnExcluirClick - Exclui TODOS os itens do lote selecionado
3649:     * Espelha o legado: Delete From SigPrDis Where Codigos = ?_Codigo
3650:     *===========================================================================
3651:     PROCEDURE BtnExcluirClick()
3652:         LOCAL loc_cCodigo
3653:         TRY
3654:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
3655:                 MsgAviso("Selecione um lote de distribui" + CHR(231) + CHR(227) + "o na lista.", "Aten" + CHR(231) + CHR(227) + "o")
3656:             ELSE
3657:                 SELECT cursor_4c_Dados
3658:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
3659: 
3660:                 IF MsgConfirma("Confirma exclus" + CHR(227) + "o do lote " + loc_cCodigo + "?", ;
3661:                         "Confirmar Exclus" + CHR(227) + "o")
3662:                     IF THIS.this_oBusinessObject.ExcluirPorCodigo(loc_cCodigo)
3663:                         MsgInfo("Lote exclu" + CHR(237) + "do com sucesso!", "Sucesso")
3664:                         THIS.CarregarLista()
3665:                     ENDIF
3666:                 ENDIF
3667:             ENDIF
3668:         CATCH TO loc_oErro
3669:             MsgErro(loc_oErro.Message, "Formsigmvdis.BtnExcluirClick")
3670:         ENDTRY
3671:     ENDPROC
3672: 
3673:     *===========================================================================
3674:     * BtnBuscarClick - Abre FormBuscaAuxiliar para localizar lote de distribuicao
3675:     *===========================================================================
3676:     PROCEDURE BtnBuscarClick()
3677:         LOCAL loc_oBusca, loc_cCodigo, loc_oGrid
3678:         TRY
3679:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3680:                 "SigPrDis", "cursor_4c_BuscaLote", "codigos", "", ;
3681:                 "Buscar Lote de Distribui" + CHR(231) + CHR(227) + "o")
3682: 
3683:             IF VARTYPE(loc_oBusca) = "O"
3684:                 loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
3685:                 loc_oBusca.mAddColuna("datas", "", "Data")
3686:                 loc_oBusca.Show()
3687: 
3688:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLote")
3689:                     SELECT cursor_4c_BuscaLote
3690:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaLote.codigos)
3691:                     loc_oGrid   = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
3692:                     IF USED("cursor_4c_Dados")
3693:                         SELECT cursor_4c_Dados
3694:                         LOCATE FOR ALLTRIM(codigos) = loc_cCodigo
3695:                         loc_oGrid.Refresh()
3696:                     ENDIF
3697:                 ENDIF
3698: 
3699:                 loc_oBusca.Release()
3700:             ENDIF
3701: 
3702:             IF USED("cursor_4c_BuscaLote")
3703:                 USE IN cursor_4c_BuscaLote
3704:             ENDIF
3705:         CATCH TO loc_oErro
3706:             IF VARTYPE(loc_oBusca) = "O"
3707:                 loc_oBusca.Release()
3708:             ENDIF
3709:             IF USED("cursor_4c_BuscaLote")
3710:                 USE IN cursor_4c_BuscaLote
3711:             ENDIF
3712:             MsgErro(loc_oErro.Message, "Formsigmvdis.BtnBuscarClick")
3713:         ENDTRY
3714:     ENDPROC
3715: 
3716:     *===========================================================================
3717:     * BtnEncerrarClick - Fecha o formulario
3718:     *===========================================================================
3719:     PROCEDURE BtnEncerrarClick()
3720:         THIS.Release()
3721:     ENDPROC
3722: 
3723:     *===========================================================================
3724:     * BtnSalvarClick - Transfere Form->BO e grava (Inserir/Atualizar conforme
3725:     * this_lNovoRegistro, controlado pelo BusinessBase). PUBLIC: BINDEVENT.
3726:     * Regra #20 CLAUDE.md: falha de gravacao nunca eh muda - BusinessBase ja
3727:     * chama ExibirFalha() em todo caminho que retorna .F.; o form so cobre o
3728:     * caso raro de this_lErroExibido nao ter sido setado.
3729:     *===========================================================================
3730:     PROCEDURE BtnSalvarClick()
3731:         THIS.FormParaBO()
3732: 
3733:         IF THIS.this_oBusinessObject.Salvar()
3734:             MsgInfo("Registro salvo com sucesso!", "Confirmar")
3735:             THIS.AlternarPagina(1)
3736:         ELSE
3737:             IF !THIS.this_oBusinessObject.this_lErroExibido
3738:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o registro.", "Confirmar")
3739:             ENDIF
3740:         ENDIF
3741:     ENDPROC
3742: 
3743:     *===========================================================================
3744:     * BtnCancelarClick - Descarta alteracoes e volta para a lista
3745:     * PUBLIC: BINDEVENT requer metodo publico
3746:     *===========================================================================
3747:     PROCEDURE BtnCancelarClick()
3748:         THIS.AlternarPagina(1)
3749:     ENDPROC
3750: 
3751:     *===========================================================================
3752:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
3753:     * REGRA: Deve iterar Pages E Controls para PageFrames
3754:     *===========================================================================
3755:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
3756:         LOCAL loc_nI, loc_oObjeto, loc_nP
3757: 
3758:         FOR loc_nI = 1 TO par_oContainer.ControlCount
3759:             loc_oObjeto = par_oContainer.Controls(loc_nI)
3760: 
3761:             IF VARTYPE(loc_oObjeto) = "O"
3762:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
3763:                     loc_oObjeto.Visible = .T.
3764:                 ENDIF
3765: 
3766:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
3767:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
3768:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
3769:                     ENDFOR
3770:                 ENDIF
3771: 
3772:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
3773:                     THIS.TornarControlesVisiveis(loc_oObjeto)
3774:                 ENDIF
3775:             ENDIF
3776:         ENDFOR
3777:     ENDPROC
3778: 
3779:     *===========================================================================
3780:     * Destroy - Libera recursos ao fechar o formulario
3781:     *===========================================================================
3782:     PROCEDURE Destroy()
3783:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
3784:             THIS.this_oBusinessObject = .NULL.
3785:         ENDIF
3786: 
3787:         IF USED("cursor_4c_Dados")
3788:             USE IN cursor_4c_Dados
3789:         ENDIF
3790: 
3791:         IF USED("cursor_4c_Carrega")
3792:             USE IN cursor_4c_Carrega
3793:         ENDIF
3794: 
3795:         IF USED("cursor_4c_ItensLote")
3796:             USE IN cursor_4c_ItensLote
3797:         ENDIF
3798: 
3799:         IF USED("cursor_4c_Estoque")
3800:             USE IN cursor_4c_Estoque
3801:         ENDIF
3802: 
3803:         IF USED("cursor_4c_Disponivel")
3804:             USE IN cursor_4c_Disponivel
3805:         ENDIF
3806: 
3807:         IF USED("cursor_4c_Distribui")
3808:             USE IN cursor_4c_Distribui
3809:         ENDIF
3810: 
3811:         IF USED("cursor_4c_CabOpera")
3812:             USE IN cursor_4c_CabOpera
3813:         ENDIF
3814: 
3815:         IF USED("cursor_4c_ItnOpera")
3816:             USE IN cursor_4c_ItnOpera
3817:         ENDIF
3818: 
3819:         DODEFAULT()
3820:     ENDPROC
3821: 
3822: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigmvdisBO.prg):
*====================================================================
* sigmvdisBO.prg
*
* Business Object para Distribuicao por Movimentacao de Produtos
* Tabela: SigPrDis
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS sigmvdisBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigPrDis)
    this_cCidChave         = ""    && cidchaves     char(20)  - PK (Fortyus)
    this_cCodigo           = ""    && codigos       char(10)  - Codigo do lote de distribuicao
    this_cCodProduto       = ""    && cpros         char(14)  - Codigo do produto
    this_cCodCor           = ""    && codcors       char(4)   - Codigo da cor
    this_cCodTamanho       = ""    && codtams       char(4)   - Codigo do tamanho
    this_dData             = {}    && datas         datetime  - Data da distribuicao
    this_dDataAlteracao    = {}    && dtalts        datetime  - Data da ultima alteracao
    this_cEmpDopNum        = ""    && empdopnums    char(29)  - Empresa+Documento+Numero de origem
    this_cOriDopNum        = ""    && oridopnums    char(29)  - Empresa+Documento+Numero original
    this_cEmpDestino       = ""    && empds         char(3)   - Empresa de destino
    this_cEmpGrupoEstab    = ""    && empgruests    char(23)  - Empresa+Grupo+Estabelecimento
    this_cLocal            = ""    && locals        char(10)  - Local de estoque
    this_nQtdOrigem        = 0     && qtdos         numeric(10,2) - Quantidade de origem
    this_nQtd              = 0     && qtds          numeric(10,2) - Quantidade distribuida
    this_cUsuario          = ""    && usuars        char(10)  - Usuario de inclusao
    this_cUsuarioAlteracao = ""    && usualts       char(10)  - Usuario de alteracao

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrDis"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "sigmvdisBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChave)
    ENDPROC

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
                THIS.this_cCidChave         = TratarNulo(cidchaves,  "C")
                THIS.this_cCodigo           = TratarNulo(codigos,    "C")
                THIS.this_cCodProduto       = TratarNulo(cpros,      "C")
                THIS.this_cCodCor           = TratarNulo(codcors,    "C")
                THIS.this_cCodTamanho       = TratarNulo(codtams,    "C")
                THIS.this_dData             = TratarNulo(datas,      "D")
                THIS.this_dDataAlteracao    = TratarNulo(dtalts,     "D")
                THIS.this_cEmpDopNum        = TratarNulo(empdopnums, "C")
                THIS.this_cOriDopNum        = TratarNulo(oridopnums, "C")
                THIS.this_cEmpDestino       = TratarNulo(empds,      "C")
                THIS.this_cEmpGrupoEstab    = TratarNulo(empgruests, "C")
                THIS.this_cLocal            = TratarNulo(locals,     "C")
                THIS.this_nQtdOrigem        = TratarNulo(qtdos,      "N")
                THIS.this_nQtd              = TratarNulo(qtds,       "N")
                THIS.this_cUsuario          = TratarNulo(usuars,     "C")
                THIS.this_cUsuarioAlteracao = TratarNulo(usualts,    "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "sigmvdisBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cCodigo)
            MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cCodProduto)
            MsgAviso("Produto n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cEmpDestino)
            MsgAviso("Empresa de destino n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_nQtd <= 0
            MsgAviso("Quantidade distribu" + CHR(237) + "da deve ser maior que zero!")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigPrDis
    * PK Fortyus (cidchaves): gerada via fUniqueIds() - NUNCA string vazia
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cCidChave
        loc_lSucesso = .F.

        TRY
            loc_cCidChave = IIF(EMPTY(THIS.this_cCidChave), fUniqueIds(), THIS.this_cCidChave)

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigPrDis
                    (cidchaves, codigos, cpros, codcors, codtams,
                     datas, dtalts, empdopnums, oridopnums, empds,
                     empgruests, locals, qtdos, qtds, usuars, usualts)
                VALUES (
                    <<EscaparSQL(loc_cCidChave)>>,
                    <<EscaparSQL(THIS.this_cCodigo)>>,
                    <<EscaparSQL(THIS.this_cCodProduto)>>,
                    <<EscaparSQL(THIS.this_cCodCor)>>,
                    <<EscaparSQL(THIS.this_cCodTamanho)>>,
                    <<FormatarDataSQL(THIS.this_dData)>>,
                    <<FormatarDataSQL(THIS.this_dDataAlteracao)>>,
                    <<EscaparSQL(THIS.this_cEmpDopNum)>>,
                    <<EscaparSQL(THIS.this_cOriDopNum)>>,
                    <<EscaparSQL(THIS.this_cEmpDestino)>>,
                    <<EscaparSQL(THIS.this_cEmpGrupoEstab)>>,
                    <<EscaparSQL(THIS.this_cLocal)>>,
                    <<FormatarNumeroSQL(THIS.this_nQtdOrigem, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nQtd, 2)>>,
                    <<EscaparSQL(gc_4c_UsuarioLogado)>>,
                    <<EscaparSQL(gc_4c_UsuarioLogado)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.this_cCidChave = loc_cCidChave
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir distribui" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "sigmvdisBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigPrDis
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigPrDis
                SET codigos    = <<EscaparSQL(THIS.this_cCodigo)>>,
                    cpros      = <<EscaparSQL(THIS.this_cCodProduto)>>,
                    codcors    = <<EscaparSQL(THIS.this_cCodCor)>>,
                    codtams    = <<EscaparSQL(THIS.this_cCodTamanho)>>,
                    datas      = <<FormatarDataSQL(THIS.this_dData)>>,
                    dtalts     = <<GETDATE()>>,
                    empdopnums = <<EscaparSQL(THIS.this_cEmpDopNum)>>,
                    oridopnums = <<EscaparSQL(THIS.this_cOriDopNum)>>,
                    empds      = <<EscaparSQL(THIS.this_cEmpDestino)>>,
                    empgruests = <<EscaparSQL(THIS.this_cEmpGrupoEstab)>>,
                    locals     = <<EscaparSQL(THIS.this_cLocal)>>,
                    qtdos      = <<FormatarNumeroSQL(THIS.this_nQtdOrigem, 2)>>,
                    qtds       = <<FormatarNumeroSQL(THIS.this_nQtd, 2)>>,
                    usualts    = <<EscaparSQL(gc_4c_UsuarioLogado)>>
                WHERE cidchaves = <<EscaparSQL(THIS.this_cCidChave)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar distribui" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "sigmvdisBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigPrDis
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrDis WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChave)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir distribui" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "sigmvdisBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExcluirPorCodigo - Exclui TODOS os registros de um lote (codigos)
    * Espelha o legado: Delete From SigPrDis Where Codigos = ?_Codigo
    *====================================================================
    PROCEDURE ExcluirPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrDis WHERE codigos = " + EscaparSQL(par_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir lote de distribui" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir lote:" + CHR(13) + loException.Message, "sigmvdisBO.ExcluirPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca lotes de distribuicao (lista distinta de Codigos/Datas)
    * Espelha o legado: Select Distinct Codigos, Datas from SigPrDis
    * Retorna cursor_4c_Dados com codigos, datas
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (codigos C(10), datas T)
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT DISTINCT codigos, datas FROM SigPrDis"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY datas DESC, codigos"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar distribui" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "sigmvdisBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (cidchaves)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, codigos, cpros, codcors, codtams," + ;
                " datas, dtalts, empdopnums, oridopnums, empds," + ;
                " empgruests, locals, qtdos, qtds, usuars, usualts" + ;
                " FROM SigPrDis WHERE cidchaves = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Registro de distribui" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar distribui" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "sigmvdisBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * BuscarItensPorLote - Carrega TODOS os itens de um lote (codigos)
    * Espelha o legado: Select * from SigPrDis where Codigos = ?_Codigo
    * Retorna cursor_4c_ItensLote
    *====================================================================
    PROCEDURE BuscarItensPorLote(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, codigos, cpros, codcors, codtams," + ;
                " datas, dtalts, empdopnums, oridopnums, empds," + ;
                " empgruests, locals, qtdos, qtds, usuars, usualts" + ;
                " FROM SigPrDis WHERE codigos = " + EscaparSQL(par_cCodigo)

            IF USED("cursor_4c_ItensLote")
                USE IN cursor_4c_ItensLote
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItensLote")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar itens do lote:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar itens:" + CHR(13) + loException.Message, "sigmvdisBO.BuscarItensPorLote")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

