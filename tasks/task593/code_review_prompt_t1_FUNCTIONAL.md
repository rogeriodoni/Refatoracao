# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (14)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [BINDEVENT-PARAMS] Handler 'ProdutoLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ProdutoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'DescricaoProdutoLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE DescricaoProdutoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'GradeItensEmpresaLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE GradeItensEmpresaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'GradeItensTamanhoLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE GradeItensTamanhoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'GradeItensCorLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE GradeItensCorLostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'GradeItensDepartamentoLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE GradeItensDepartamentoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Lista' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigprcom.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1951 linhas total):

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
834:             CREATE CURSOR cursor_4c_Lista ;
835:                 (cpros C(14), dpros C(40), ifors C(10), reffs C(20), sgrus C(6))
836:             RETURN .T.
837:         ENDIF
838: 
839:         TRY
840:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
841: 
842:             IF THIS.this_oBusinessObject.Buscar("")
843:                 loc_oGrid.ColumnCount            = 5
844:                 loc_oGrid.RecordSource            = "cursor_4c_Lista"
845:                 loc_oGrid.Column1.ControlSource   = "cursor_4c_Lista.cpros"
846:                 loc_oGrid.Column2.ControlSource   = "cursor_4c_Lista.dpros"
847:                 loc_oGrid.Column3.ControlSource   = "cursor_4c_Lista.ifors"
848:                 loc_oGrid.Column4.ControlSource   = "cursor_4c_Lista.reffs"
849:                 loc_oGrid.Column5.ControlSource   = "cursor_4c_Lista.sgrus"
850: 
851:                 *-- Reconfigurar cabecalhos APOS RecordSource (obrigatorio)
852:                 loc_oGrid.Column1.Header1.Caption = "Produto"
853:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
854:                 loc_oGrid.Column3.Header1.Caption = "Fornecedor"
855:                 loc_oGrid.Column4.Header1.Caption = "Refer" + CHR(234) + "ncia"
856:                 loc_oGrid.Column5.Header1.Caption = "Sub Grp"
857: 
858:                 loc_oGrid.Column1.Width = 108
859:                 loc_oGrid.Column2.Width = 285
860:                 loc_oGrid.Column3.Width = 75
861:                 loc_oGrid.Column4.Width = 150
862:                 loc_oGrid.Column5.Width = 45
863: 
864:                 THIS.FormatarGridLista(loc_oGrid)
865:                 loc_oGrid.Refresh()
866:                 loc_lResultado = .T.

*-- Linhas 875 a 1951:
875:     *===========================================================================
876:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
877:     *===========================================================================
878:     PROCEDURE AlternarPagina(par_nPagina)
879:         LOCAL loc_lResultado
880:         loc_lResultado = .F.
881: 
882:         TRY
883:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
884:                 MsgErro("Parametro inv" + CHR(225) + "lido em AlternarPagina: " + TRANSFORM(par_nPagina), "Erro")
885:             ELSE
886:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
887:                 IF par_nPagina = 1
888:                     THIS.this_cModoAtual = "LISTA"
889:                     THIS.CarregarLista()
890:                 ENDIF
891:                 *-- Quem DESABILITA botao tem de REABILITAR no funil de volta:
892:                 *-- Confirmar/Cancelar chamam AlternarPagina(1), e eh aqui - com o
893:                 *-- modo JA normalizado para "LISTA" acima - que os botoes CRUD
894:                 *-- voltam a ficar clicaveis (CLAUDE.md regra #40)
895:                 THIS.AjustarBotoesPorModo()
896:                 loc_lResultado = .T.
897:             ENDIF
898:         CATCH TO loc_oErro
899:             MsgErro(loc_oErro.Message, "AlternarPagina")
900:         ENDTRY
901: 
902:         RETURN loc_lResultado
903:     ENDPROC
904: 
905:     *===========================================================================
906:     * BtnIncluirClick - Prepara a Page2 para cadastrar um NOVO Produto no
907:     * Estoque Maximo (o codigo eh escolhido pelo usuario via lookup de Produto)
908:     * Legado: Grupo_Op.Click(1) + DoDefault() (framework) limpa a ficha e navega
909:     *===========================================================================
910:     PROCEDURE BtnIncluirClick()
911:         THIS.this_oBusinessObject.NovoRegistro()
912:         THIS.LimparDadosProduto()
913:         THIS.this_cModoAtual = "INCLUIR"
914: 
915:         THIS.pgf_4c_Paginas.Page2.txt_4c__Produto.ReadOnly = .F.
916:         THIS.pgf_4c_Paginas.Page2.txt_4c_Dpro.ReadOnly     = .F.
917:         THIS.HabilitarCampos(.T.)
918: 
919:         THIS.AlternarPagina(2)
920:         THIS.pgf_4c_Paginas.Page2.txt_4c__Produto.SetFocus()
921:     ENDPROC
922: 
923:     *===========================================================================
924:     * BtnAlterarClick - Carrega o Produto selecionado na Lista (Page1) com os
925:     * itens JA GRAVADOS em SigCdMax para edicao na grade (Page2)
926:     *===========================================================================
927:     PROCEDURE BtnAlterarClick()
928:         LOCAL loc_cCodigo
929:         loc_cCodigo = ""
930: 
931:         IF !USED("cursor_4c_Lista") OR EOF("cursor_4c_Lista")
932:             MsgAviso("Selecione um Produto na lista !!!")
933:             RETURN
934:         ENDIF
935: 
936:         loc_cCodigo = ALLTRIM(cursor_4c_Lista.cpros)
937: 
938:         THIS.this_oBusinessObject.NovoRegistro()
939:         THIS.LimparDadosProduto()
940:         THIS.this_cModoAtual = "ALTERAR"
941: 
942:         IF THIS.CarregarItensExistentesProduto(loc_cCodigo)
943:             THIS.pgf_4c_Paginas.Page2.txt_4c__Produto.ReadOnly = .T.
944:             THIS.pgf_4c_Paginas.Page2.txt_4c_Dpro.ReadOnly     = .T.
945:             THIS.HabilitarCampos(.T.)
946:             THIS.AlternarPagina(2)
947:         ELSE
948:             THIS.this_cModoAtual = "LISTA"
949:         ENDIF
950:     ENDPROC
951: 
952:     *===========================================================================
953:     * BtnVisualizarClick - Mesma carga do Alterar, porem SOMENTE LEITURA
954:     *===========================================================================
955:     PROCEDURE BtnVisualizarClick()
956:         LOCAL loc_cCodigo
957:         loc_cCodigo = ""
958: 
959:         IF !USED("cursor_4c_Lista") OR EOF("cursor_4c_Lista")
960:             MsgAviso("Selecione um Produto na lista !!!")
961:             RETURN
962:         ENDIF
963: 
964:         loc_cCodigo = ALLTRIM(cursor_4c_Lista.cpros)
965: 
966:         THIS.this_oBusinessObject.NovoRegistro()
967:         THIS.LimparDadosProduto()
968:         THIS.this_cModoAtual = "VISUALIZAR"
969: 
970:         IF THIS.CarregarItensExistentesProduto(loc_cCodigo)
971:             THIS.pgf_4c_Paginas.Page2.txt_4c__Produto.ReadOnly = .T.
972:             THIS.pgf_4c_Paginas.Page2.txt_4c_Dpro.ReadOnly     = .T.
973:             THIS.HabilitarCampos(.F.)
974:             THIS.AlternarPagina(2)
975:         ELSE
976:             THIS.this_cModoAtual = "LISTA"
977:         ENDIF
978:     ENDPROC
979: 
980:     *===========================================================================
981:     * BtnExcluirClick - Exclui de SigCdMax TODOS os registros do Produto
982:     * selecionado na Lista (Page1). Legado: btnExcluir(Grupo_Op, Opcao=Excluir)
983:     *===========================================================================
984:     PROCEDURE BtnExcluirClick()
985:         LOCAL loc_cCodigo, loc_cDescricao, loc_cSQL, loc_nResultado, loc_lConfirmou
986: 
987:         IF !USED("cursor_4c_Lista") OR EOF("cursor_4c_Lista")
988:             MsgAviso("Selecione um Produto na lista !!!")
989:             RETURN
990:         ENDIF
991: 
992:         loc_cCodigo    = ALLTRIM(cursor_4c_Lista.cpros)
993:         loc_cDescricao = ALLTRIM(TratarNulo(cursor_4c_Lista.dpros, ""))
994: 
995:         loc_lConfirmou = MsgConfirma("Confirma a exclus" + CHR(227) + "o do Estoque M" + CHR(225) + "ximo do Produto " + ;
996:             loc_cCodigo + " - " + loc_cDescricao + " ?", "Confirmar Exclus" + CHR(227) + "o")
997: 
998:         IF loc_lConfirmou
999:             TRY
1000:                 loc_cSQL = "DELETE FROM SigCdMax WHERE cpros = " + EscaparSQL(loc_cCodigo)
1001:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
1002: 
1003:                 IF loc_nResultado >= 0
1004:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Confirmar")
1005:                     THIS.CarregarLista()
1006:                 ELSE
1007:                     MsgErro("Erro ao excluir:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1008:                 ENDIF
1009:             CATCH TO loc_oErro
1010:                 MsgErro(loc_oErro.Message, "BtnExcluirClick")
1011:             ENDTRY
1012:         ENDIF
1013:     ENDPROC
1014: 
1015:     *===========================================================================
1016:     * BtnBuscarClick - Coloca o form em modo BUSCAR (busca por exemplo).
1017:     * Legado: msv_procurar - NAO abre picker; limpa a ficha, habilita SO os
1018:     * campos plprocurar (Produto/Descricao/Fornecedor/Referencia), navega
1019:     * para a Pagina de Dados e quem executa a consulta eh o Confirmar.
1020:     *===========================================================================
1021:     PROCEDURE BtnBuscarClick()
1022:         LOCAL loc_oPagina
1023:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1024: 
1025:         THIS.LimparDadosProduto()
1026:         THIS.this_cModoAtual = "BUSCAR"
1027: 
1028:         loc_oPagina.txt_4c__Produto.ReadOnly = .F.
1029:         loc_oPagina.txt_4c_Dpro.ReadOnly     = .F.
1030:         loc_oPagina.txt_4c_Ifor.ReadOnly     = .F.
1031:         loc_oPagina.txt_4c_Refs.ReadOnly     = .F.
1032: 
1033:         *-- NAO usar HabilitarCampos(.F.) aqui: ele tambem desabilita o
1034:         *-- Confirmar, que EH o botao que dispara a busca (ExecutarBusca)
1035:         loc_oPagina.grd_4c_Itens.ReadOnly      = .T.
1036:         loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
1037: 
1038:         THIS.AlternarPagina(2)
1039:         loc_oPagina.txt_4c__Produto.SetFocus()
1040:     ENDPROC
1041: 
1042:     *===========================================================================
1043:     * ExecutarBusca - Busca por exemplo em SigCdPro (Produto/Descricao/
1044:     * Fornecedor/Referencia, nesta ordem) e carrega os itens existentes do
1045:     * Produto encontrado. Legado: msv_procurar (Do Case cpros/dpros/ifors/reffs)
1046:     *===========================================================================
1047:     PROCEDURE ExecutarBusca()
1048:         LOCAL loc_oPagina, loc_cCodigo, loc_cDescricao, loc_cFornecedor, loc_cReferencia
1049:         LOCAL loc_cSQL, loc_nResultado, loc_cCodigoEncontrado
1050:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1051: 
1052:         loc_cCodigo           = ALLTRIM(loc_oPagina.txt_4c__Produto.Value)
1053:         loc_cDescricao        = ALLTRIM(loc_oPagina.txt_4c_Dpro.Value)
1054:         loc_cFornecedor       = ALLTRIM(loc_oPagina.txt_4c_Ifor.Value)
1055:         loc_cReferencia       = ALLTRIM(loc_oPagina.txt_4c_Refs.Value)
1056:         loc_cCodigoEncontrado = ""
1057: 
1058:         TRY
1059:             DO CASE
1060:                 CASE !EMPTY(loc_cCodigo)
1061:                     loc_cSQL = "SELECT cpros FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCodigo)
1062:                 CASE !EMPTY(loc_cDescricao)
1063:                     loc_cSQL = "SELECT cpros FROM SigCdPro WHERE dpros = " + EscaparSQL(loc_cDescricao)
1064:                 CASE !EMPTY(loc_cFornecedor)
1065:                     loc_cSQL = "SELECT cpros FROM SigCdPro WHERE ifors = " + EscaparSQL(loc_cFornecedor)
1066:                 CASE !EMPTY(loc_cReferencia)
1067:                     loc_cSQL = "SELECT cpros FROM SigCdPro WHERE reffs = " + EscaparSQL(loc_cReferencia)
1068:                 OTHERWISE
1069:                     loc_cSQL = ""
1070:             ENDCASE
1071: 
1072:             IF EMPTY(loc_cSQL)
1073:                 MsgAviso("Informe ao menos um crit" + CHR(233) + "rio de busca !!!")
1074:             ELSE
1075:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaExemplo")
1076:                 IF loc_nResultado > 0 AND USED("cursor_4c_BuscaExemplo") AND !EOF("cursor_4c_BuscaExemplo")
1077:                     loc_cCodigoEncontrado = ALLTRIM(cursor_4c_BuscaExemplo.cpros)
1078:                 ELSE
1079:                     MsgAviso("Produto n" + CHR(227) + "o encontrado !!!")
1080:                 ENDIF
1081:             ENDIF
1082:         CATCH TO loc_oErro
1083:             MsgErro(loc_oErro.Message, "ExecutarBusca")
1084:         ENDTRY
1085: 
1086:         IF USED("cursor_4c_BuscaExemplo")
1087:             USE IN cursor_4c_BuscaExemplo
1088:         ENDIF
1089: 
1090:         IF !EMPTY(loc_cCodigoEncontrado)
1091:             IF THIS.CarregarItensExistentesProduto(loc_cCodigoEncontrado)
1092:                 THIS.this_cModoAtual = "ALTERAR"
1093:                 loc_oPagina.txt_4c__Produto.ReadOnly = .T.
1094:                 loc_oPagina.txt_4c_Dpro.ReadOnly     = .T.
1095:                 loc_oPagina.txt_4c_Ifor.ReadOnly     = .T.
1096:                 loc_oPagina.txt_4c_Refs.ReadOnly     = .T.
1097:                 THIS.HabilitarCampos(.T.)
1098:             ENDIF
1099:         ENDIF
1100:     ENDPROC
1101: 
1102:     *===========================================================================
1103:     * BtnEncerrarClick - Fecha o formulario
1104:     *===========================================================================
1105:     PROCEDURE BtnEncerrarClick()
1106:         THIS.Release()
1107:     ENDPROC
1108: 
1109:     *===========================================================================
1110:     * HabilitarCampos - Habilita/desabilita a grade de itens e os botoes de
1111:     * gravacao/remocao de linha da Page2, conforme o modo (INCLUIR/ALTERAR x
1112:     * VISUALIZAR). O codigo/descricao do Produto sao travados por fora
1113:     * (BtnIncluirClick libera, BtnAlterarClick/BtnVisualizarClick travam)
1114:     *===========================================================================
1115:     PROCEDURE HabilitarCampos(par_lHabilitar)
1116:         LOCAL loc_oPagina
1117:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1118: 
1119:         loc_oPagina.grd_4c_Itens.ReadOnly     = !par_lHabilitar
1120:         loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
1121:     ENDPROC
1122: 
1123:     *===========================================================================
1124:     * AjustarBotoesPorModo - Ajusta os botoes CRUD da Pagina Lista conforme o
1125:     * modo corrente. Legado: Grupo_Op.Enabled / Inserir|Consultar|Alterar|
1126:     * Excluir|Procurar.Enabled (btnCopiar.Click e cntCopia.cmdSair.Click
1127:     * desligam e religam o grupo inteiro).
1128:     *
1129:     * NAO mexe em cmd_4c_Confirmar: ele eh governado por HabilitarCampos(),
1130:     * que precisa deixa-lo LIGADO no modo BUSCAR (eh o Confirmar que dispara
1131:     * a busca por exemplo) e DESLIGADO no modo VISUALIZAR.
1132:     *===========================================================================
1133:     PROCEDURE AjustarBotoesPorModo()
1134:         LOCAL loc_oCnt, loc_lNaLista
1135:         loc_lNaLista = (THIS.this_cModoAtual == "LISTA")
1136:         loc_oCnt     = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
1137: 
1138:         loc_oCnt.cmd_4c_Incluir.Enabled    = loc_lNaLista
1139:         loc_oCnt.cmd_4c_Visualizar.Enabled = loc_lNaLista
1140:         loc_oCnt.cmd_4c_Alterar.Enabled    = loc_lNaLista
1141:         loc_oCnt.cmd_4c_Excluir.Enabled    = loc_lNaLista
1142:         loc_oCnt.cmd_4c_Buscar.Enabled     = loc_lNaLista
1143:         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Enabled = loc_lNaLista
1144: 
1145:         *-- Cancelar so faz sentido quando existe edicao/busca em andamento
1146:         THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = !loc_lNaLista
1147:     ENDPROC
1148: 
1149:     *===========================================================================
1150:     * FormParaBO - Transfere a LINHA CORRENTE da grade de itens (mais o Produto
1151:     * do cabecalho da Pagina Dados) para as propriedades do Business Object.
1152:     *
1153:     * Em SigCdMax cada registro eh UMA linha da grade (Produto + Empresa +
1154:     * Tamanho + Cor + Departamento + Qtde. Maxima), por isso o mapeamento le o
1155:     * registro corrente de cursor_4c_Itens - o Confirmar chama este metodo uma
1156:     * vez por linha, dentro do SCAN que posiciona o cursor.
1157:     *===========================================================================
1158:     PROTECTED PROCEDURE FormParaBO()
1159:         LOCAL loc_cProduto, loc_oBO
1160: 
1161:         IF !USED("cursor_4c_Itens") OR VARTYPE(THIS.this_oBusinessObject) != "O"
1162:             RETURN .F.
1163:         ENDIF
1164: 
1165:         loc_oBO     = THIS.this_oBusinessObject
1166:         loc_cProduto = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c__Produto.Value)
1167: 
1168:         SELECT cursor_4c_Itens
1169: 
1170:         *-- cidchaves vazio = linha nova (o Inserir do BO gera a PK com fUniqueIds)
1171:         loc_oBO.this_cCidChaves = ALLTRIM(NVL(cursor_4c_Itens.cidchaves, ""))
1172: 
1173:         *-- A linha pode ter sido criada em branco por AdicionarNovaLinhaItem
1174:         *-- antes do Produto estar escolhido: o cabecalho eh a fonte de verdade
1175:         loc_oBO.this_cCPros     = IIF(EMPTY(loc_cProduto), ;
1176:                                       ALLTRIM(NVL(cursor_4c_Itens.cpros, "")), loc_cProduto)
1177:         loc_oBO.this_cEmps      = ALLTRIM(NVL(cursor_4c_Itens.emps, ""))
1178:         loc_oBO.this_cCodTams   = ALLTRIM(NVL(cursor_4c_Itens.codtams, ""))
1179:         loc_oBO.this_cCodCores  = ALLTRIM(NVL(cursor_4c_Itens.codcores, ""))
1180:         loc_oBO.this_cDeptos    = ALLTRIM(NVL(cursor_4c_Itens.deptos, ""))
1181:         loc_oBO.this_nQMaxs     = NVL(cursor_4c_Itens.qmaxs, 0)
1182: 
1183:         *-- ordems eh char(1) NOT NULL sem campo na tela (o legado grava o
1184:         *-- registro em branco do cursor); manter "1" para nao violar o NOT NULL
1185:         loc_oBO.this_cOrdems    = "1"
1186: 
1187:         RETURN .T.
1188:     ENDPROC
1189: 
1190:     *===========================================================================
1191:     * BOParaForm - Transfere as propriedades do Business Object de volta para a
1192:     * LINHA CORRENTE da grade de itens e para o Produto do cabecalho.
1193:     *
1194:     * Chamado depois de cada gravacao: eh assim que a PK gerada pelo Inserir
1195:     * (fUniqueIds) volta para a linha - sem isso, um segundo Confirmar sobre a
1196:     * mesma grade trataria as linhas ja gravadas como novas e duplicaria tudo.
1197:     *===========================================================================
1198:     PROTECTED PROCEDURE BOParaForm()
1199:         LOCAL loc_oPagina, loc_oBO
1200: 
1201:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1202:             RETURN .F.
1203:         ENDIF
1204: 
1205:         loc_oBO     = THIS.this_oBusinessObject
1206:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1207: 
1208:         IF EMPTY(ALLTRIM(loc_oPagina.txt_4c__Produto.Value)) AND !EMPTY(loc_oBO.this_cCPros)
1209:             loc_oPagina.txt_4c__Produto.Value = ALLTRIM(loc_oBO.this_cCPros)
1210:         ENDIF
1211: 
1212:         IF USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens")
1213:             SELECT cursor_4c_Itens
1214:             REPLACE cidchaves WITH loc_oBO.this_cCidChaves, ;
1215:                     cpros     WITH loc_oBO.this_cCPros, ;
1216:                     emps      WITH loc_oBO.this_cEmps, ;
1217:                     codtams   WITH loc_oBO.this_cCodTams, ;
1218:                     codcores  WITH loc_oBO.this_cCodCores, ;
1219:                     deptos    WITH loc_oBO.this_cDeptos, ;
1220:                     qmaxs     WITH loc_oBO.this_nQMaxs ;
1221:                 IN cursor_4c_Itens
1222:         ENDIF
1223: 
1224:         RETURN .T.
1225:     ENDPROC
1226: 
1227:     *===========================================================================
1228:     * LimparCampos - Hook do FormBase: limpa a ficha do Produto e a grade de
1229:     * itens e abandona a edicao em andamento no Business Object.
1230:     *===========================================================================
1231:     PROTECTED PROCEDURE LimparCampos()
1232:         THIS.LimparDadosProduto()
1233: 
1234:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1235:             THIS.this_oBusinessObject.CancelarEdicao()
1236:         ENDIF
1237: 
1238:         RETURN .T.
1239:     ENDPROC
1240: 
1241:     *===========================================================================
1242:     * CarregarItensExistentesProduto - Carrega cabecalho do Produto (mesma
1243:     * consulta de CarregarProdutoSelecionado) e os itens JA GRAVADOS em
1244:     * SigCdMax, para os fluxos ALTERAR/VISUALIZAR (NAO bloqueia por
1245:     * ExistemItensParaProduto - ao contrario do fluxo INCLUIR, aqui os itens
1246:     * EXISTENTES sao o que se quer carregar)
1247:     *===========================================================================
1248:     PROCEDURE CarregarItensExistentesProduto(par_cCodigo)
1249:         LOCAL loc_oPagina, loc_cSQL, loc_nResultado, loc_lSucesso
1250:         loc_oPagina  = THIS.pgf_4c_Paginas.Page2
1251:         loc_lSucesso = .F.
1252: 
1253:         TRY
1254:             loc_cSQL = "SELECT a.cpros, a.dpros, a.cgrus, a.ifors, a.reffs, a.situas," + ;
1255:                 " c.rclis, g.dgrus, g.tipoestos, g.cores, g.tams" + ;
1256:                 " FROM SigCdPro a" + ;
1257:                 " LEFT JOIN SigCdGrp g ON g.cgrus = a.cgrus" + ;
1258:                 " LEFT JOIN SigCdCli c ON c.iclis = a.ifors" + ;
1259:                 " WHERE a.cpros = " + EscaparSQL(par_cCodigo)
1260: 
1261:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdutoInfo")
1262: 
1263:             IF loc_nResultado < 1 OR !USED("cursor_4c_ProdutoInfo") OR EOF("cursor_4c_ProdutoInfo")
1264:                 MsgErro("Produto n" + CHR(227) + "o encontrado.", "Erro")
1265:             ELSE
1266:                 SELECT cursor_4c_ProdutoInfo
1267: 
1268:                 loc_oPagina.txt_4c__Produto.Value     = TratarNulo(cpros, "")
1269:                 loc_oPagina.txt_4c_Dpro.Value          = TratarNulo(dpros, "")
1270:                 loc_oPagina.txt_4c_Cgru.Value          = TratarNulo(cgrus, "")
1271:                 loc_oPagina.txt_4c_Dgru.Value          = TratarNulo(dgrus, "")
1272:                 loc_oPagina.txt_4c_Ifor.Value           = TratarNulo(ifors, "")
1273:                 loc_oPagina.txt_4c_Dfor.Value           = TratarNulo(rclis, "")
1274:                 loc_oPagina.txt_4c_Refs.Value           = TratarNulo(reffs, "")
1275:                 loc_oPagina.obj_4c_Opc_situacao.Value  = IIF(NVL(situas, 1) = 2, 2, 1)
1276: 
1277:                 THIS.this_nTipoEstos = TratarNulo(tipoestos, 0)
1278:                 THIS.this_lTemCor    = INLIST(THIS.this_nTipoEstos, 2, 4) OR TratarNulo(cores, 0) = 1
1279:                 THIS.this_lTemTam    = INLIST(THIS.this_nTipoEstos, 3, 4) OR TratarNulo(tams, 0) = 1
1280: 
1281:                 IF THIS.CarregarItensGravados(par_cCodigo)
1282:                     loc_oPagina.grd_4c_Itens.Column3.Enabled = THIS.this_lTemTam
1283:                     loc_oPagina.grd_4c_Itens.Column4.Enabled = THIS.this_lTemCor
1284:                     loc_oPagina.grd_4c_Itens.Refresh()
1285:                     loc_oPagina.cmd_4c_BtnExcluir.Visible = .T.
1286:                     loc_lSucesso = .T.
1287:                 ENDIF
1288:             ENDIF
1289:         CATCH TO loc_oErro
1290:             MsgErro(loc_oErro.Message, "CarregarItensExistentesProduto")
1291:         ENDTRY
1292: 
1293:         IF USED("cursor_4c_ProdutoInfo")
1294:             USE IN cursor_4c_ProdutoInfo
1295:         ENDIF
1296: 
1297:         RETURN loc_lSucesso
1298:     ENDPROC
1299: 
1300:     *===========================================================================
1301:     * CarregarItensGravados - Popula cursor_4c_Itens com os registros JA
1302:     * gravados em SigCdMax para o Produto informado. Usa cursor TEMPORARIO +
1303:     * ZAP/APPEND para preservar as colunas do Grid (regra CLAUDE.md #34)
1304:     *===========================================================================
1305:     PROCEDURE CarregarItensGravados(par_cCodigo)
1306:         LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
1307:         loc_lSucesso = .F.
1308: 
1309:         TRY
1310:             loc_cSQL = "SELECT cidchaves, cpros, emps, qmaxs, codtams, codcores, deptos" + ;
1311:                 " FROM SigCdMax WHERE cpros = " + EscaparSQL(par_cCodigo) + ;
1312:                 " ORDER BY emps, codtams, codcores"
1313: 
1314:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItensTemp")
1315: 
1316:             IF loc_nResultado >= 0 AND USED("cursor_4c_Itens")
1317:                 SELECT cursor_4c_Itens
1318:                 ZAP
1319: 
1320:                 IF USED("cursor_4c_ItensTemp")
1321:                     SELECT cursor_4c_ItensTemp
1322:                     SCAN
1323:                         INSERT INTO cursor_4c_Itens (cidchaves, cpros, emps, qmaxs, codtams, codcores, deptos) ;
1324:                             VALUES (cursor_4c_ItensTemp.cidchaves, cursor_4c_ItensTemp.cpros, ;
1325:                                     cursor_4c_ItensTemp.emps, cursor_4c_ItensTemp.qmaxs, ;
1326:                                     cursor_4c_ItensTemp.codtams, cursor_4c_ItensTemp.codcores, ;
1327:                                     cursor_4c_ItensTemp.deptos)
1328:                     ENDSCAN
1329:                 ENDIF
1330: 
1331:                 SELECT cursor_4c_Itens
1332:                 IF RECCOUNT("cursor_4c_Itens") = 0
1333:                     INSERT INTO cursor_4c_Itens (cpros) VALUES (par_cCodigo)
1334:                 ENDIF
1335:                 GO TOP IN cursor_4c_Itens
1336:                 loc_lSucesso = .T.
1337:             ENDIF
1338:         CATCH TO loc_oErro
1339:             MsgErro(loc_oErro.Message, "CarregarItensGravados")
1340:         ENDTRY
1341: 
1342:         IF USED("cursor_4c_ItensTemp")
1343:             USE IN cursor_4c_ItensTemp
1344:         ENDIF
1345: 
1346:         RETURN loc_lSucesso
1347:     ENDPROC
1348: 
1349:     *===========================================================================
1350:     * Lookup Produto (codigo) - legado: get_produto.Valid (fwbuscaext SigCdPro/cpros)
1351:     * BINDEVENT em LostFocus (Valid nao dispara de forma confiavel via BINDEVENT)
1352:     *===========================================================================
1353:     PROCEDURE ProdutoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1354:         THIS.AbrirLookupProduto()
1355:     ENDPROC
1356: 
1357:     PROCEDURE ProdutoDblClick()
1358:         THIS.AbrirLookupProduto()
1359:     ENDPROC
1360: 
1361:     PROCEDURE AbrirLookupProduto()
1362:         LOCAL loc_oPagina, loc_cValor, loc_oBusca, loc_cCodigo
1363:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1364: 
1365:         *-- Legado: get_produto.Valid so dispara o lookup quando pcEscolha = 'INSERIR'
1366:         IF THIS.this_cModoAtual != "INCLUIR"
1367:             RETURN
1368:         ENDIF
1369: 
1370:         loc_cValor  = ALLTRIM(loc_oPagina.txt_4c__Produto.Value)
1371: 
1372:         IF loc_cValor == THIS.this_cUltimoProdutoValid
1373:             RETURN
1374:         ENDIF
1375:         THIS.this_cUltimoProdutoValid = loc_cValor
1376: 
1377:         IF EMPTY(loc_cValor)
1378:             THIS.LimparDadosProduto()
1379:             RETURN
1380:         ENDIF
1381: 
1382:         loc_cCodigo = ""
1383:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1384:             "SigCdPro", "cursor_4c_BuscaProduto", "cpros", loc_cValor, "Produtos")
1385: 
1386:         IF VARTYPE(loc_oBusca) = "O"
1387:             IF !loc_oBusca.this_lAchouRegistro
1388:                 loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
1389:                 loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
1390:                 loc_oBusca.Show()
1391:             ENDIF
1392:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProduto")
1393:                 loc_cCodigo = ALLTRIM(cursor_4c_BuscaProduto.cpros)
1394:             ENDIF
1395:             loc_oBusca.Release()
1396:         ENDIF
1397:         IF USED("cursor_4c_BuscaProduto")
1398:             USE IN cursor_4c_BuscaProduto
1399:         ENDIF
1400: 
1401:         IF EMPTY(loc_cCodigo)
1402:             THIS.LimparDadosProduto()
1403:         ELSE
1404:             THIS.this_cUltimoProdutoValid = loc_cCodigo
1405:             THIS.CarregarProdutoSelecionado(loc_cCodigo)
1406:         ENDIF
1407:     ENDPROC
1408: 
1409:     *===========================================================================
1410:     * Lookup Produto (descricao) - legado: getDpro.Valid (fwbuscaext SigCdPro/dpros)
1411:     *===========================================================================
1412:     PROCEDURE DescricaoProdutoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1413:         THIS.AbrirLookupProdutoPorDescricao()
1414:     ENDPROC
1415: 
1416:     PROCEDURE DescricaoProdutoDblClick()
1417:         THIS.AbrirLookupProdutoPorDescricao()
1418:     ENDPROC
1419: 
1420:     PROCEDURE AbrirLookupProdutoPorDescricao()
1421:         LOCAL loc_oPagina, loc_cValor, loc_oBusca, loc_cCodigo
1422:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1423: 
1424:         *-- Legado: getDpro.Valid so dispara o lookup quando pcEscolha = 'INSERIR'
1425:         IF THIS.this_cModoAtual != "INCLUIR"
1426:             RETURN
1427:         ENDIF
1428: 
1429:         loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_Dpro.Value)
1430: 
1431:         IF loc_cValor == THIS.this_cUltimoDescProdValid
1432:             RETURN
1433:         ENDIF
1434:         THIS.this_cUltimoDescProdValid = loc_cValor
1435: 
1436:         IF EMPTY(loc_cValor)
1437:             RETURN
1438:         ENDIF
1439: 
1440:         loc_cCodigo = ""
1441:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1442:             "SigCdPro", "cursor_4c_BuscaProduto", "dpros", loc_cValor, "Produtos")
1443: 
1444:         IF VARTYPE(loc_oBusca) = "O"
1445:             IF !loc_oBusca.this_lAchouRegistro
1446:                 loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
1447:                 loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
1448:                 loc_oBusca.Show()
1449:             ENDIF
1450:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProduto")
1451:                 loc_cCodigo = ALLTRIM(cursor_4c_BuscaProduto.cpros)
1452:             ENDIF
1453:             loc_oBusca.Release()
1454:         ENDIF
1455:         IF USED("cursor_4c_BuscaProduto")
1456:             USE IN cursor_4c_BuscaProduto
1457:         ENDIF
1458: 
1459:         IF !EMPTY(loc_cCodigo)
1460:             THIS.this_cUltimoProdutoValid = loc_cCodigo
1461:             THIS.CarregarProdutoSelecionado(loc_cCodigo)
1462:         ENDIF
1463:     ENDPROC
1464: 
1465:     *===========================================================================
1466:     * CarregarProdutoSelecionado - Carrega dados do Produto (join Grupo/Fornecedor),
1467:     * valida situacao/duplicidade e prepara a grade de itens para inclusao
1468:     * Legado: get_produto.Valid + ThisForm.AcertaGrade() + ThisForm.MRefreshGet()
1469:     *===========================================================================
1470:     PROCEDURE CarregarProdutoSelecionado(par_cCodigo)
1471:         LOCAL loc_oPagina, loc_cSQL, loc_nResultado, loc_lInativo
1472: 
1473:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1474: 
1475:         TRY
1476:             loc_cSQL = "SELECT a.cpros, a.dpros, a.cgrus, a.ifors, a.reffs, a.situas," + ;
1477:                 " c.rclis, g.dgrus, g.tipoestos, g.cores, g.tams" + ;
1478:                 " FROM SigCdPro a" + ;
1479:                 " LEFT JOIN SigCdGrp g ON g.cgrus = a.cgrus" + ;
1480:                 " LEFT JOIN SigCdCli c ON c.iclis = a.ifors" + ;
1481:                 " WHERE a.cpros = " + EscaparSQL(par_cCodigo)
1482: 
1483:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdutoInfo")
1484: 
1485:             IF loc_nResultado < 1 OR !USED("cursor_4c_ProdutoInfo") OR EOF("cursor_4c_ProdutoInfo")
1486:                 MsgErro("Favor reinicializar o processo.", "Falha na Conex" + CHR(227) + "o")
1487:                 THIS.LimparDadosProduto()
1488:             ELSE
1489:                 SELECT cursor_4c_ProdutoInfo
1490: 
1491:                 *-- Verifica se produto esta inativo (bloqueia se parametro gesind=1)
1492:                 loc_lInativo = .F.
1493:                 IF NVL(situas, 0) = 2
1494:                     IF THIS.ParametroGestaoIndireta()
1495:                         loc_lInativo = .T.
1496:                     ENDIF
1497:                 ENDIF
1498: 
1499:                 IF loc_lInativo
1500:                     MsgAviso("Produto Inativo !!!")
1501:                     THIS.LimparDadosProduto()
1502:                 ELSE
1503:                     IF THIS.this_oBusinessObject.ExistemItensParaProduto(par_cCodigo)
1504:                         MsgAviso("Produto j" + CHR(225) + " cadastrado !!!")
1505:                         THIS.LimparDadosProduto()
1506:                     ELSE
1507:                         loc_oPagina.txt_4c__Produto.Value = TratarNulo(cpros, "")
1508:                         loc_oPagina.txt_4c_Dpro.Value      = TratarNulo(dpros, "")
1509:                         loc_oPagina.txt_4c_Cgru.Value      = TratarNulo(cgrus, "")
1510:                         loc_oPagina.txt_4c_Dgru.Value      = TratarNulo(dgrus, "")
1511:                         loc_oPagina.txt_4c_Ifor.Value       = TratarNulo(ifors, "")
1512:                         loc_oPagina.txt_4c_Dfor.Value       = TratarNulo(rclis, "")
1513:                         loc_oPagina.txt_4c_Refs.Value       = TratarNulo(reffs, "")
1514:                         loc_oPagina.obj_4c_Opc_situacao.Value = IIF(NVL(situas, 1) = 2, 2, 1)
1515: 
1516:                         THIS.this_nTipoEstos = TratarNulo(tipoestos, 0)
1517:                         THIS.this_lTemCor    = INLIST(THIS.this_nTipoEstos, 2, 4) OR TratarNulo(cores, 0) = 1
1518:                         THIS.this_lTemTam    = INLIST(THIS.this_nTipoEstos, 3, 4) OR TratarNulo(tams, 0) = 1
1519: 
1520:                         *-- Prepara a grade com UMA linha em branco para o usuario preencher
1521:                         IF USED("cursor_4c_Itens")
1522:                             ZAP IN cursor_4c_Itens
1523:                             INSERT INTO cursor_4c_Itens (cpros) VALUES (par_cCodigo)
1524:                         ENDIF
1525: 
1526:                         loc_oPagina.grd_4c_Itens.Column3.Enabled = THIS.this_lTemTam
1527:                         loc_oPagina.grd_4c_Itens.Column4.Enabled = THIS.this_lTemCor
1528:                         loc_oPagina.grd_4c_Itens.Refresh()
1529: 
1530:                         loc_oPagina.cmd_4c_BtnExcluir.Visible = .T.
1531:                         THIS.this_cModoAtual = "INCLUIR"
1532:                     ENDIF
1533:                 ENDIF
1534:             ENDIF
1535:         CATCH TO loc_oErro
1536:             MsgErro(loc_oErro.Message, "CarregarProdutoSelecionado")
1537:             THIS.LimparDadosProduto()
1538:         ENDTRY
1539: 
1540:         IF USED("cursor_4c_ProdutoInfo")
1541:             USE IN cursor_4c_ProdutoInfo
1542:         ENDIF
1543:     ENDPROC
1544: 
1545:     *===========================================================================
1546:     * ParametroGestaoIndireta - Le SigCdPam.gesind (parametro de gestao indireta)
1547:     *===========================================================================
1548:     PROCEDURE ParametroGestaoIndireta()
1549:         LOCAL loc_lResultado
1550:         loc_lResultado = .F.
1551: 
1552:         TRY
1553:             IF SQLEXEC(gnConnHandle, "SELECT gesind FROM SigCdPam", "cursor_4c_Param") > 0
1554:                 IF USED("cursor_4c_Param") AND !EOF("cursor_4c_Param")
1555:                     loc_lResultado = (TratarNulo(cursor_4c_Param.gesind, 0) = 1)
1556:                 ENDIF
1557:             ENDIF
1558:         CATCH TO loc_oErro
1559:             loc_lResultado = .F.
1560:         ENDTRY
1561: 
1562:         IF USED("cursor_4c_Param")
1563:             USE IN cursor_4c_Param
1564:         ENDIF
1565: 
1566:         RETURN loc_lResultado
1567:     ENDPROC
1568: 
1569:     *===========================================================================
1570:     * LimparDadosProduto - Limpa cabecalho do Produto e a grade de itens
1571:     *===========================================================================
1572:     PROCEDURE LimparDadosProduto()
1573:         LOCAL loc_oPagina
1574:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1575: 
1576:         loc_oPagina.txt_4c__Produto.Value      = ""
1577:         loc_oPagina.txt_4c_Dpro.Value          = ""
1578:         loc_oPagina.txt_4c_Cgru.Value          = ""
1579:         loc_oPagina.txt_4c_Dgru.Value          = ""
1580:         loc_oPagina.txt_4c_Ifor.Value          = ""
1581:         loc_oPagina.txt_4c_Dfor.Value          = ""
1582:         loc_oPagina.txt_4c_Refs.Value          = ""
1583:         loc_oPagina.obj_4c_Opc_situacao.Value  = 1
1584:         loc_oPagina.cmd_4c_BtnExcluir.Visible  = .F.
1585: 
1586:         *-- Ifor/Refs so ficam editaveis durante o modo BUSCAR (BtnBuscarClick
1587:         *-- reabre depois desta chamada) - fora dele, permanecem travados
1588:         loc_oPagina.txt_4c_Ifor.ReadOnly       = .T.
1589:         loc_oPagina.txt_4c_Refs.ReadOnly       = .T.
1590: 
1591:         THIS.this_nTipoEstos = 0
1592:         THIS.this_lTemCor    = .F.
1593:         THIS.this_lTemTam    = .F.
1594:         THIS.this_cUltimoProdutoValid  = ""
1595:         THIS.this_cUltimoDescProdValid = ""
1596: 
1597:         IF USED("cursor_4c_Itens")
1598:             ZAP IN cursor_4c_Itens
1599:         ENDIF
1600:         loc_oPagina.grd_4c_Itens.Refresh()
1601:     ENDPROC
1602: 
1603:     *===========================================================================
1604:     * GradeItensAfterRowColChange - Habilita Tamanho/Cor conforme o Grupo do Produto
1605:     * Legado: gradei.AfterRowColChange
1606:     *===========================================================================
1607:     PROCEDURE GradeItensAfterRowColChange(par_nColIndex)
1608:         LOCAL loc_oGrid
1609:         loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Itens
1610: 
1611:         loc_oGrid.Column3.Enabled = THIS.this_lTemTam
1612:         loc_oGrid.Column4.Enabled = THIS.this_lTemCor
1613:         loc_oGrid.Refresh()
1614:     ENDPROC
1615: 
1616:     *===========================================================================
1617:     * GradeItensEmpresaLostFocus - Valida acesso a Empresa digitada na grade
1618:     * Legado: gradei.Column1.text1.Valid (fAcessoEmpresa)
1619:     *===========================================================================
1620:     PROCEDURE GradeItensEmpresaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1621:         LOCAL loc_oText, loc_cValor
1622:         loc_oText  = THIS.pgf_4c_Paginas.Page2.grd_4c_Itens.Column1.Text1
1623:         loc_cValor = ALLTRIM(loc_oText.Value)
1624: 
1625:         IF !EMPTY(loc_cValor)
1626:             IF !VerificarAcessoEmpresa(gc_4c_UsuarioLogado, loc_cValor)
1627:                 MsgAviso("Empresa sem acesso ou inv" + CHR(225) + "lida !!!")
1628:                 loc_oText.Value = ""
1629:             ENDIF
1630:         ENDIF
1631:     ENDPROC
1632: 
1633:     *===========================================================================
1634:     * GradeItensTamanhoLostFocus - Lookup de Tamanho (SigCdTam) na grade
1635:     * Legado: gradei.Column3.Text1.Valid (fwbuscaext)
1636:     *===========================================================================
1637:     PROCEDURE GradeItensTamanhoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1638:         LOCAL loc_oText, loc_cValor, loc_oBusca, loc_cCodigo
1639:         loc_oText  = THIS.pgf_4c_Paginas.Page2.grd_4c_Itens.Column3.Text1
1640:         loc_cValor = ALLTRIM(loc_oText.Value)
1641: 
1642:         IF !EMPTY(loc_cValor)
1643:             loc_cCodigo = ""
1644:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1645:                 "SigCdTam", "cursor_4c_BuscaTamanho", "cods", loc_cValor, "Tamanhos")
1646:             IF VARTYPE(loc_oBusca) = "O"
1647:                 IF !loc_oBusca.this_lAchouRegistro
1648:                     loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "d")
1649:                     loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1650:                     loc_oBusca.Show()
1651:                 ENDIF
1652:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTamanho")
1653:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaTamanho.cods)
1654:                 ENDIF
1655:                 loc_oBusca.Release()
1656:             ENDIF
1657:             IF USED("cursor_4c_BuscaTamanho")
1658:                 USE IN cursor_4c_BuscaTamanho
1659:             ENDIF
1660:             loc_oText.Value = loc_cCodigo
1661:         ENDIF
1662: 
1663:         IF THIS.this_nTipoEstos = 3 AND EMPTY(ALLTRIM(loc_oText.Value))
1664:             MsgAviso("Obrigat" + CHR(243) + "rio informar Tamanho !!!")
1665:         ENDIF
1666:     ENDPROC
1667: 
1668:     *===========================================================================
1669:     * GradeItensCorLostFocus - Lookup de Cor (SigCdCor) na grade
1670:     * Legado: gradei.Column4.Text1.Valid (fwbuscaext)
1671:     *===========================================================================
1672:     PROCEDURE GradeItensCorLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1673:         LOCAL loc_oText, loc_cValor, loc_oBusca, loc_cCodigo
1674:         loc_oText  = THIS.pgf_4c_Paginas.Page2.grd_4c_Itens.Column4.Text1
1675:         loc_cValor = ALLTRIM(loc_oText.Value)
1676: 
1677:         IF !EMPTY(loc_cValor)
1678:             loc_cCodigo = ""
1679:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1680:                 "SigCdCor", "cursor_4c_BuscaCor", "cods", loc_cValor, "Cores")
1681:             IF VARTYPE(loc_oBusca) = "O"
1682:                 IF !loc_oBusca.this_lAchouRegistro
1683:                     loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "d")
1684:                     loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1685:                     loc_oBusca.Show()
1686:                 ENDIF
1687:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCor")
1688:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaCor.cods)
1689:                 ENDIF
1690:                 loc_oBusca.Release()
1691:             ENDIF
1692:             IF USED("cursor_4c_BuscaCor")
1693:                 USE IN cursor_4c_BuscaCor
1694:             ENDIF
1695:             loc_oText.Value = loc_cCodigo
1696:         ENDIF
1697: 
1698:         IF THIS.this_nTipoEstos = 2 AND EMPTY(ALLTRIM(loc_oText.Value))
1699:             MsgAviso("Obrigat" + CHR(243) + "rio informar C" + CHR(243) + "digo da Cor !!!")
1700:         ENDIF
1701:     ENDPROC
1702: 
1703:     *===========================================================================
1704:     * GradeItensDepartamentoLostFocus - Lookup de Departamento (SigCdDpt) na grade
1705:     * Legado: gradei.Column5.Text1.Valid (fwbuscaext) + mNovaLinha (nova linha em branco)
1706:     *===========================================================================
1707:     PROCEDURE GradeItensDepartamentoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1708:         LOCAL loc_oText, loc_cValor, loc_oBusca, loc_cCodigo
1709:         loc_oText  = THIS.pgf_4c_Paginas.Page2.grd_4c_Itens.Column5.Text1
1710:         loc_cValor = ALLTRIM(loc_oText.Value)
1711: 
1712:         IF !EMPTY(loc_cValor)
1713:             loc_cCodigo = ""
1714:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1715:                 "SigCdDpt", "cursor_4c_BuscaDepto", "codigos", loc_cValor, "Departamentos")
1716:             IF VARTYPE(loc_oBusca) = "O"
1717:                 IF !loc_oBusca.this_lAchouRegistro
1718:                     loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
1719:                     loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
1720:                     loc_oBusca.Show()
1721:                 ENDIF
1722:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDepto")
1723:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaDepto.codigos)
1724:                 ENDIF
1725:                 loc_oBusca.Release()
1726:             ENDIF
1727:             IF USED("cursor_4c_BuscaDepto")
1728:                 USE IN cursor_4c_BuscaDepto
1729:             ENDIF
1730:             loc_oText.Value = loc_cCodigo
1731:         ENDIF
1732: 
1733:         THIS.AdicionarNovaLinhaItem()
1734:     ENDPROC
1735: 
1736:     *===========================================================================
1737:     * AdicionarNovaLinhaItem - Acrescenta uma linha em branco na grade de itens
1738:     * Legado: mNovaLinha
1739:     *===========================================================================
1740:     PROCEDURE AdicionarNovaLinhaItem()
1741:         LOCAL loc_oGrid, loc_cProduto
1742: 
1743:         IF !USED("cursor_4c_Itens")
1744:             RETURN
1745:         ENDIF
1746: 
1747:         loc_oGrid   = THIS.pgf_4c_Paginas.Page2.grd_4c_Itens
1748:         loc_cProduto = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c__Produto.Value)
1749: 
1750:         SELECT cursor_4c_Itens
1751:         LOCATE FOR EMPTY(emps)
1752:         IF !FOUND()
1753:             INSERT INTO cursor_4c_Itens (cpros) VALUES (loc_cProduto)
1754:         ENDIF
1755: 
1756:         loc_oGrid.Refresh()
1757:     ENDPROC
1758: 
1759:     *===========================================================================
1760:     * BtnExcluirItemClick - Remove da grade local os itens da Empresa corrente
1761:     * Legado: btnExcluir.Click
1762:     *===========================================================================
1763:     PROCEDURE BtnExcluirItemClick()
1764:         LOCAL loc_cEmps, loc_cProduto, loc_oGrid
1765: 
1766:         IF !USED("cursor_4c_Itens")
1767:             RETURN
1768:         ENDIF
1769: 
1770:         loc_oGrid    = THIS.pgf_4c_Paginas.Page2.grd_4c_Itens
1771:         loc_cProduto = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c__Produto.Value)
1772:         loc_cEmps    = ""
1773: 
1774:         SELECT cursor_4c_Itens
1775:         IF !EOF() AND !EMPTY(emps)
1776:             loc_cEmps = emps
1777:         ENDIF
1778: 
1779:         IF !EMPTY(loc_cEmps)
1780:             DELETE FROM cursor_4c_Itens WHERE emps == loc_cEmps
1781:             SELECT cursor_4c_Itens
1782:             PACK
1783:         ENDIF
1784: 
1785:         SELECT cursor_4c_Itens
1786:         LOCATE
1787:         IF EOF()
1788:             INSERT INTO cursor_4c_Itens (cpros) VALUES (loc_cProduto)
1789:         ENDIF
1790: 
1791:         loc_oGrid.Refresh()
1792:     ENDPROC
1793: 
1794:     *===========================================================================
1795:     * BtnConfirmarClick - Grava na tabela SigCdMax cada linha valida da grade
1796:     * Legado: btnConfirma equivalente (TableUpdate do cursor CrSigCdMax)
1797:     *===========================================================================
1798:     PROCEDURE BtnConfirmarClick()
1799:         LOCAL loc_lSucesso, loc_nLinhasGravadas, loc_cProduto, loc_cChavesMantidas
1800:         LOCAL loc_lLinhaNova, loc_lEraAlteracao
1801: 
1802:         *-- Em modo BUSCAR, Confirmar executa a busca por exemplo (legado: msv_procurar)
1803:         IF THIS.this_cModoAtual == "BUSCAR"
1804:             THIS.ExecutarBusca()
1805:             RETURN
1806:         ENDIF
1807: 
1808:         *-- VISUALIZAR nao grava (HabilitarCampos(.F.) ja desliga o botao; esta
1809:         *-- guarda cobre a chamada por teclado/atalho)
1810:         IF THIS.this_cModoAtual == "VISUALIZAR" OR !USED("cursor_4c_Itens")
1811:             RETURN
1812:         ENDIF
1813: 
1814:         loc_cProduto = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c__Produto.Value)
1815: 
1816:         *-- Legado: cmdConfirma recusa Produto vazio no INSERIR e devolve o foco
1817:         IF EMPTY(loc_cProduto)
1818:             MsgAviso("Produto inv" + CHR(225) + "lido !!!")
1819:             THIS.pgf_4c_Paginas.Page2.txt_4c__Produto.SetFocus()
1820:             RETURN
1821:         ENDIF
1822: 
1823:         loc_lSucesso        = .T.
1824:         loc_nLinhasGravadas = 0
1825:         loc_cChavesMantidas = ""
1826:         loc_lEraAlteracao   = (THIS.this_cModoAtual == "ALTERAR")
1827: 
1828:         SELECT cursor_4c_Itens
1829:         SCAN FOR !EMPTY(emps)
1830:             IF THIS.this_lTemTam AND EMPTY(codtams)
1831:                 MsgAviso("Obrigat" + CHR(243) + "rio informar Tamanho !!!")
1832:                 loc_lSucesso = .F.
1833:                 EXIT
1834:             ENDIF
1835:             IF THIS.this_lTemCor AND EMPTY(codcores)
1836:                 MsgAviso("Obrigat" + CHR(243) + "rio informar C" + CHR(243) + "digo da Cor !!!")
1837:                 loc_lSucesso = .F.
1838:                 EXIT
1839:             ENDIF
1840: 
1841:             *-- Linha SEM cidchaves eh nova (INSERT); com chave, eh uma linha ja
1842:             *-- gravada em SigCdMax e o que se quer eh UPDATE. Sem esta distincao
1843:             *-- o ALTERAR reinseria todas as linhas do Produto.
1844:             loc_lLinhaNova = EMPTY(NVL(cursor_4c_Itens.cidchaves, ""))
1845: 
1846:             IF loc_lLinhaNova
1847:                 THIS.this_oBusinessObject.NovoRegistro()
1848:             ELSE
1849:                 *-- CancelarEdicao zera this_lNovoRegistro (que BtnAlterarClick
1850:                 *-- deixou ligado); sem isso EditarRegistro recusa e o Salvar
1851:                 *-- cairia no Inserir, duplicando o registro
1852:                 THIS.this_oBusinessObject.CancelarEdicao()
1853:                 THIS.this_oBusinessObject.EditarRegistro()
1854:             ENDIF
1855: 
1856:             *-- FormParaBO depois de NovoRegistro/EditarRegistro: NovoRegistro
1857:             *-- chama LimparDados e apagaria o que fosse mapeado antes
1858:             THIS.FormParaBO()
1859: 
1860:             IF !THIS.this_oBusinessObject.Salvar()
1861:                 loc_lSucesso = .F.
1862:                 EXIT
1863:             ENDIF
1864: 
1865:             *-- Devolve para a linha a PK gerada no Inserir (e os valores como
1866:             *-- ficaram gravados), para um 2o Confirmar nao reinserir a linha
1867:             THIS.BOParaForm()
1868: 
1869:             loc_cChavesMantidas = loc_cChavesMantidas + ;
1870:                 IIF(EMPTY(loc_cChavesMantidas), "", ",") + ;
1871:                 ALLTRIM(THIS.this_oBusinessObject.this_cCidChaves)
1872:             loc_nLinhasGravadas = loc_nLinhasGravadas + 1
1873:         ENDSCAN
1874: 
1875:         *-- Linhas que o usuario removeu da grade com btnExcluir precisam sair do
1876:         *-- banco: no legado o cursor era uma view atualizavel e o Delete local
1877:         *-- ia junto no Update/Commit; aqui a grade eh um cursor local.
1878:         IF loc_lSucesso AND loc_lEraAlteracao
1879:             loc_lSucesso = THIS.this_oBusinessObject.ExcluirItensRemovidos(loc_cProduto, loc_cChavesMantidas)
1880:         ENDIF
1881: 
1882:         IF loc_lSucesso
1883:             IF loc_nLinhasGravadas = 0 AND !loc_lEraAlteracao
1884:                 MsgAviso("Nenhum item informado para grava" + CHR(231) + CHR(227) + "o.")
1885:             ELSE
1886:                 MsgInfo("Registro salvo com sucesso!", "Confirmar")
1887:                 THIS.LimparCampos()
1888:                 THIS.AlternarPagina(1)
1889:             ENDIF
1890:         ENDIF
1891:     ENDPROC
1892: 
1893:     *===========================================================================
1894:     * BtnCancelarClick - Cancela a inclusao e retorna para a Lista
1895:     *===========================================================================
1896:     PROCEDURE BtnCancelarClick()
1897:         *-- LimparCampos (e nao LimparDadosProduto) para tambem abandonar a
1898:         *-- edicao no BO: sem isso o BO fica com this_lEmEdicao ligado depois de
1899:         *-- um Incluir cancelado e o Fechar passa a perguntar por alteracoes
1900:         *-- que nao existem mais
1901:         THIS.LimparCampos()
1902:         THIS.AlternarPagina(1)
1903:     ENDPROC
1904: 
1905:     *===========================================================================
1906:     * FormatarGridLista - Formata visual do grid da lista
1907:     *===========================================================================
1908:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1909:         WITH par_oGrid
1910:             .FontName = "Tahoma"
1911:             .FontSize = 8
1912:         ENDWITH
1913:     ENDPROC
1914: 
1915:     *===========================================================================
1916:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
1917:     * REGRA: Deve iterar Pages E Controls para PageFrames
1918:     *===========================================================================
1919:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1920:         LOCAL loc_nI, loc_oObjeto, loc_nP
1921: 
1922:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1923:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1924: 
1925:             IF VARTYPE(loc_oObjeto) = "O"
1926:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1927:                     loc_oObjeto.Visible = .T.
1928:                 ENDIF
1929: 
1930:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1931:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1932:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1933:                     ENDFOR
1934:                 ENDIF
1935: 
1936:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1937:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1938:                 ENDIF
1939:             ENDIF
1940:         ENDFOR
1941:     ENDPROC
1942: 
1943:     *===========================================================================
1944:     * Destroy - Libera recursos ao fechar o formulario
1945:     *===========================================================================
1946:     PROCEDURE Destroy()
1947:         THIS.this_oBusinessObject = .NULL.
1948:         RETURN DODEFAULT()
1949:     ENDPROC
1950: 
1951: ENDDEFINE


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

