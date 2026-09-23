# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [BINDEVENT-PARAMS] Handler 'UsuariosLookupLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE UsuariosLookupLostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'EmpresaLookupLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE EmpresaLookupLostFocus(par_nKeyCode, par_nShiftAltCtrl)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormUep.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1216 linhas total):

*-- Linhas 6 a 177:
6: * FASE 4/8 - Grid e Botoes CRUD (Page1):
7: *   Page1 completa: cnt_4c_Cabecalho, cnt_4c_Botoes (Incluir/Visualizar/
8: *   Alterar/Excluir/Buscar), cnt_4c_Saida (Encerrar) e grd_4c_Lista.
9: *   CarregarLista()/AlternarPagina()/TornarControlesVisiveis()/
10: *   FormatarGridLista() e os handlers Btn*Click de Page1 implementados.
11: *
12: * FASE 5/8 - Campos Principais Page2 (COMPLETO - form so tem 2 campos):
13: *   txt_4c_Usuarios (getUsuarios) + txt_4c_Empresa (GetEmpresa) com labels
14: *   lbl_4c_Label1/lbl_4c_Label2, Top compensado +29 (PageFrame.Top=-29).
15: *
16: * FASE 6/8 - Lookups e Data Binding (COMPLETO):
17: *   AbrirLookupUsuario/AbrirLookupEmpresa (fwBuscaExt/fAcessoEmpresa NAO
18: *   portada - substituida por FormBuscaAuxiliar em SigCdEmp), Validar*/
19: *   *LookupKeyPress/DblClick/LostFocus, FormParaBO/BOParaForm,
20: *   LimparCampos/HabilitarCampos/AjustarBotoesPorModo, botoes Confirmar/
21: *   Cancelar de cnt_4c_BotoesAcao.
22: *
23: * FASE 7/8 - Eventos Principais dos Botoes CRUD (COMPLETO):
24: *   BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick
25: *   implementados com logica completa (NovoRegistro/EditarRegistro/
26: *   CarregarPorCodigo/Excluir), lendo o registro selecionado em
27: *   cursor_4c_Dados e transcrevendo as validacoes do legado.
28: *
29: * FASE 8/8 - Finalizacao: BtnBuscarClick/BtnSalvarClick/BtnCancelarClick/
30: *   BtnEncerrarClick e Destroy() ja implementados nesta versao.
31: *==============================================================================
32: 
33: DEFINE CLASS FormUep AS FormBase
34: 
35:     *-- Propriedades visuais (PILAR 1 - UX FIDELITY: Height/Width/Caption EXATOS do original)
36:     Height      = 600
37:     Width       = 1000
38:     Caption     = "Cadastro de Usu" + CHR(225) + "rios Fixos Por Empresa"
39:     AutoCenter  = .T.
40:     ShowWindow  = 1
41:     WindowType  = 1
42:     ControlBox  = .F.
43:     TitleBar    = 0
44:     Themes      = .F.
45:     BorderStyle = 2
46: 
47:     *-- Propriedades de estado
48:     this_oBusinessObject = .NULL.
49:     this_cModoAtual       = "LISTA"
50: 
51:     *-- Guarda ultimo valor validado (evita reabrir lookup em CADA LostFocus sem mudanca - Problema 45)
52:     this_cUltimoUsuarioValidado = ""
53:     this_cUltimaEmpresaValidada = ""
54: 
55:     *===========================================================================
56:     * Init - Inicializa o formulario
57:     * REGRA CRITICA: Apenas RETURN DODEFAULT()
58:     * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
59:     *===========================================================================
60:     PROCEDURE Init()
61:         RETURN DODEFAULT()
62:     ENDPROC
63: 
64:     *===========================================================================
65:     * InicializarForm - Configura estrutura completa
66:     * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
67:     *===========================================================================
68:     PROTECTED PROCEDURE InicializarForm()
69:         LOCAL loc_lSucesso
70:         loc_lSucesso = .F.
71: 
72:         TRY
73:             THIS.this_oBusinessObject = CREATEOBJECT("UepBO")
74: 
75:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
76:                 MostrarErro("Erro ao criar UepBO" + CHR(13) + ;
77:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
78:                     "FormUep.InicializarForm")
79:             ELSE
80:                 THIS.ConfigurarPageFrame()
81:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
82:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
83:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
84:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
85:                 THIS.pgf_4c_Paginas.Visible = .T.
86:                 THIS.pgf_4c_Paginas.ActivePage = 1
87:                 THIS.this_cModoAtual = "LISTA"
88: 
89:                 loc_lSucesso = .T.
90:             ENDIF
91: 
92:         CATCH TO loException
93:             MostrarErro("Erro ao inicializar FormUep:" + CHR(13) + ;
94:                 loException.Message + CHR(13) + ;
95:                 "Linha: " + TRANSFORM(loException.LineNo), ;
96:                 "FormUep.InicializarForm")
97:         ENDTRY
98: 
99:         RETURN loc_lSucesso
100:     ENDPROC
101: 
102:     *===========================================================================
103:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
104:     * Top=-29 para esconder abas; controles compensam +29 no Top
105:     *===========================================================================
106:     PROTECTED PROCEDURE ConfigurarPageFrame()
107:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
108: 
109:         WITH THIS.pgf_4c_Paginas
110:             .PageCount = 2
111:             .Top       = -29
112:             .Left      = 0
113:             .Width     = THIS.Width
114:             .Height    = THIS.Height + 29
115:             .Tabs      = .F.
116:             .Visible   = .T.
117: 
118:             .Page1.Caption   = "Lista"
119:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
120:             .Page1.BackColor = RGB(255, 255, 255)
121: 
122:             .Page2.Caption   = "Dados"
123:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
124:             .Page2.BackColor = RGB(255, 255, 255)
125:         ENDWITH
126: 
127:         THIS.ConfigurarPaginaLista()
128:         THIS.ConfigurarPaginaDados()
129:     ENDPROC
130: 
131:     *===========================================================================
132:     * ConfigurarPaginaLista - Estrutura base de Page1 (Lista)
133:     * Cabecalho (regra #11, PRIMEIRO AddObject da pagina) + cnt_4c_Botoes
134:     * VAZIO nesta fase (5 botoes CRUD + cnt_4c_Saida + grd_4c_Lista entram
135:     * na Fase 4, quando CarregarLista()/AlternarPagina() tambem sao criados)
136:     *===========================================================================
137:     PROTECTED PROCEDURE ConfigurarPaginaLista()
138:         LOCAL loc_oPagina
139:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
140: 
141:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
142: 
143:         *-- Container Cabecalho (cntSombra no legado) - PRIMEIRO AddObject da pagina
144:         *-- Original: Top=2 (default da classe). Com compensacao +29: Top=31
145:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
146:         WITH loc_oPagina.cnt_4c_Cabecalho
147:             .Top         = 31
148:             .Left        = 0
149:             .Width       = THIS.Width
150:             .Height      = 80
151:             .BackColor   = RGB(100, 100, 100)
152:             .BorderWidth = 0
153:             .Visible     = .T.
154: 
155:             .AddObject("lbl_4c_Sombra", "Label")
156:             WITH .lbl_4c_Sombra
157:                 .Caption   = THIS.Caption
158:                 .Top       = 15
159:                 .Left      = 10
160:                 .Width     = THIS.Width
161:                 .Height    = 40
162:                 .FontName  = "Tahoma"
163:                 .FontSize  = 16
164:                 .FontBold  = .T.
165:                 .ForeColor = RGB(0, 0, 0)
166:                 .BackStyle = 0
167:                 .AutoSize  = .F.
168:                 .Visible   = .T.
169:             ENDWITH
170: 
171:             .AddObject("lbl_4c_Titulo", "Label")
172:             WITH .lbl_4c_Titulo
173:                 .Caption   = THIS.Caption
174:                 .Top       = 18
175:                 .Left      = 10
176:                 .Width     = THIS.Width
177:                 .Height    = 46

*-- Linhas 221 a 440:
221:             .AutoSize        = .F.
222:             .Visible         = .T.
223:         ENDWITH
224:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
225: 
226:         *-- Botao Visualizar (Left=80)
227:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
228:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
229:             .Caption         = "Visualizar"
230:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
231:             .PicturePosition = 13
232:             .Top             = 5
233:             .Left            = 80
234:             .Width           = 75
235:             .Height          = 75
236:             .FontName        = "Tahoma"
237:             .FontBold        = .T.
238:             .FontItalic      = .T.
239:             .FontSize        = 8
240:             .ForeColor       = RGB(90, 90, 90)
241:             .BackColor       = RGB(255, 255, 255)
242:             .Themes          = .F.
243:             .SpecialEffect   = 0
244:             .MousePointer    = 15
245:             .WordWrap        = .T.
246:             .AutoSize        = .F.
247:             .Visible         = .T.
248:         ENDWITH
249:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
250: 
251:         *-- Botao Alterar (Left=155)
252:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
253:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
254:             .Caption         = "Alterar"
255:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
256:             .PicturePosition = 13
257:             .Top             = 5
258:             .Left            = 155
259:             .Width           = 75
260:             .Height          = 75
261:             .FontName        = "Tahoma"
262:             .FontBold        = .T.
263:             .FontItalic      = .T.
264:             .FontSize        = 8
265:             .ForeColor       = RGB(90, 90, 90)
266:             .BackColor       = RGB(255, 255, 255)
267:             .Themes          = .F.
268:             .SpecialEffect   = 0
269:             .MousePointer    = 15
270:             .WordWrap        = .T.
271:             .AutoSize        = .F.
272:             .Visible         = .T.
273:         ENDWITH
274:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
275: 
276:         *-- Botao Excluir (Left=230)
277:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
278:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
279:             .Caption         = "Excluir"
280:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
281:             .PicturePosition = 13
282:             .Top             = 5
283:             .Left            = 230
284:             .Width           = 75
285:             .Height          = 75
286:             .FontName        = "Tahoma"
287:             .FontBold        = .T.
288:             .FontItalic      = .T.
289:             .FontSize        = 8
290:             .ForeColor       = RGB(90, 90, 90)
291:             .BackColor       = RGB(255, 255, 255)
292:             .Themes          = .F.
293:             .SpecialEffect   = 0
294:             .MousePointer    = 15
295:             .WordWrap        = .T.
296:             .AutoSize        = .F.
297:             .Visible         = .T.
298:         ENDWITH
299:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
300: 
301:         *-- Botao Buscar (Left=305)
302:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
303:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
304:             .Caption         = "Buscar"
305:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
306:             .PicturePosition = 13
307:             .Top             = 5
308:             .Left            = 305
309:             .Width           = 75
310:             .Height          = 75
311:             .FontName        = "Tahoma"
312:             .FontBold        = .T.
313:             .FontItalic      = .T.
314:             .FontSize        = 8
315:             .ForeColor       = RGB(90, 90, 90)
316:             .BackColor       = RGB(255, 255, 255)
317:             .Themes          = .F.
318:             .SpecialEffect   = 0
319:             .MousePointer    = 15
320:             .WordWrap        = .T.
321:             .AutoSize        = .F.
322:             .Visible         = .T.
323:         ENDWITH
324:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
325: 
326:         *-- Container Saida - PADRAO CANONICO (prevalece sobre PILAR 1, CLAUDE.md regra #10)
327:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
328:         WITH loc_oPagina.cnt_4c_Saida
329:             .Top         = 29
330:             .Left        = 917
331:             .Width       = 90
332:             .Height      = 85
333:             .BackStyle   = 0
334:             .BorderWidth = 0
335:             .Visible     = .T.
336:         ENDWITH
337: 
338:         *-- Botao Encerrar - PADRAO CANONICO: Caption="Encerrar", Width=75, Height=75
339:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
340:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
341:             .Caption         = "Encerrar"
342:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
343:             .PicturePosition = 13
344:             .Top             = 5
345:             .Left            = 5
346:             .Width           = 75
347:             .Height          = 75
348:             .FontName        = "Tahoma"
349:             .FontBold        = .T.
350:             .FontItalic      = .T.
351:             .FontSize        = 8
352:             .ForeColor       = RGB(90, 90, 90)
353:             .BackColor       = RGB(255, 255, 255)
354:             .Themes          = .F.
355:             .SpecialEffect   = 0
356:             .MousePointer    = 15
357:             .WordWrap        = .T.
358:             .AutoSize        = .F.
359:             .Visible         = .T.
360:         ENDWITH
361:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
362: 
363:         *-- Grid de listagem (Usuarios/Emps)
364:         *-- Canonico framework: Top=117 (88+29 compensacao), Left=26, Width=880, Height=498
365:         *-- Width=880: nao sobrepoe cnt_4c_Saida (Left=917), margem de 11px
366:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
367:         *-- ColumnCount FORA do WITH (Problema 36: dentro do WITH nao cria colunas imediatamente)
368:         loc_oPagina.grd_4c_Lista.ColumnCount = 2
369:         WITH loc_oPagina.grd_4c_Lista
370:             .Top                = 117
371:             .Left               = 26
372:             .Width              = 880
373:             .Height             = 498
374:             .FontName           = "Verdana"
375:             .FontSize           = 8
376:             .ForeColor          = RGB(90, 90, 90)
377:             .BackColor          = RGB(255, 255, 255)
378:             .GridLineColor      = RGB(238, 238, 238)
379:             .HighlightBackColor = RGB(255, 255, 255)
380:             .HighlightForeColor = RGB(15, 41, 104)
381:             .HighlightStyle     = 2
382:             .DeleteMark         = .F.
383:             .RecordMark         = .F.
384:             .RowHeight          = 16
385:             .ScrollBars         = 2
386:             .GridLines          = 3
387:             .Visible            = .T.
388:         ENDWITH
389:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")
390: 
391:         THIS.TornarControlesVisiveis(loc_oPagina)
392:     ENDPROC
393: 
394:     *===========================================================================
395:     * ConfigurarPaginaDados - Estrutura base de Page2 (Dados)
396:     * Cabecalho (identico ao da Lista, regra #11) + campos txt_4c_Usuarios/
397:     * txt_4c_Empresa (Fase 5/8). cnt_4c_BotoesAcao ainda SEM botoes
398:     * Confirmar/Cancelar - entram na Fase 6, junto com lookups e validacoes.
399:     *===========================================================================
400:     PROTECTED PROCEDURE ConfigurarPaginaDados()
401:         LOCAL loc_oPagina
402:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
403: 
404:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
405: 
406:         *-- Cabecalho cinza (identico ao da pagina Lista) - Erro152 / CLAUDE.md #11
407:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
408:         WITH loc_oPagina.cnt_4c_Cabecalho
409:             .Top         = 29
410:             .Left        = 0
411:             .Width       = THIS.Width
412:             .Height      = 80
413:             .BackColor   = RGB(100, 100, 100)
414:             .BorderWidth = 0
415:             .Visible     = .T.
416: 
417:             .AddObject("lbl_4c_Sombra", "Label")
418:             WITH .lbl_4c_Sombra
419:                 .Caption   = THIS.Caption
420:                 .Top       = 15
421:                 .Left      = 10
422:                 .Width     = THIS.Width
423:                 .Height    = 40
424:                 .FontName  = "Tahoma"
425:                 .FontSize  = 16
426:                 .FontBold  = .T.
427:                 .ForeColor = RGB(0, 0, 0)
428:                 .BackStyle = 0
429:                 .AutoSize  = .F.
430:                 .Visible   = .T.
431:             ENDWITH
432: 
433:             .AddObject("lbl_4c_Titulo", "Label")
434:             WITH .lbl_4c_Titulo
435:                 .Caption   = THIS.Caption
436:                 .Top       = 18
437:                 .Left      = 10
438:                 .Width     = THIS.Width
439:                 .Height    = 46
440:                 .FontName  = "Tahoma"

*-- Linhas 484 a 1216:
484:             .AutoSize        = .F.
485:             .Visible         = .T.
486:         ENDWITH
487:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
488: 
489:         *-- Botao Cancelar (Left=80)
490:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
491:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
492:             .Caption         = "Encerrar"
493:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
494:             .PicturePosition = 13
495:             .Top             = 5
496:             .Left            = 80
497:             .Width           = 75
498:             .Height          = 75
499:             .FontName        = "Tahoma"
500:             .FontBold        = .T.
501:             .FontItalic      = .T.
502:             .FontSize        = 8
503:             .ForeColor       = RGB(90, 90, 90)
504:             .BackColor       = RGB(255, 255, 255)
505:             .Themes          = .F.
506:             .SpecialEffect   = 0
507:             .MousePointer    = 15
508:             .WordWrap        = .T.
509:             .AutoSize        = .F.
510:             .Visible         = .T.
511:         ENDWITH
512:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
513: 
514:         *-- FASE 5/8: Campos principais da Page2 (compensacao PageFrame +29 no Top)
515:         *-- Say1 "Usuarios :" (Left=393,Top=141) + getUsuarios (Left=443,Top=136,Width=81,Height=24)
516:         *-- Labels criadas ANTES dos TextBox (z-order - CLAUDE.md regra #23): texto por cima,
517:         *-- caixa transparente do label fica coberta sem bloquear o clique no campo.
518:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
519:         WITH loc_oPagina.lbl_4c_Label1
520:             .Caption   = "Usu" + CHR(225) + "rios :"
521:             .Top       = 141 + 29
522:             .Left      = 393
523:             .Width     = 45
524:             .Height    = 17
525:             .Alignment = 0
526:             .FontName  = "Tahoma"
527:             .FontSize  = 8
528:             .FontBold  = .F.
529:             .ForeColor = RGB(90, 90, 90)
530:             .BackStyle = 0
531:             .AutoSize  = .F.
532:             .Visible   = .T.
533:         ENDWITH
534: 
535:         loc_oPagina.AddObject("txt_4c_Usuarios", "TextBox")
536:         WITH loc_oPagina.txt_4c_Usuarios
537:             .Top           = 136 + 29
538:             .Left          = 443
539:             .Width         = 81
540:             .Height        = 24
541:             .MaxLength     = 10
542:             .SpecialEffect = 1
543:             .BorderColor   = RGB(100, 100, 100)
544:             .FontName      = "Tahoma"
545:             .FontSize      = 8
546:             .Value         = ""
547:             .Visible       = .T.
548:         ENDWITH
549:         *-- Lookup Usuarios (legado: Valid com fwBuscaExt em SigCdUsu, filtro NOT cAtivos='N')
550:         BINDEVENT(loc_oPagina.txt_4c_Usuarios, "KeyPress",  THIS, "UsuariosLookupKeyPress")
551:         BINDEVENT(loc_oPagina.txt_4c_Usuarios, "DblClick",  THIS, "UsuariosLookupDblClick")
552:         BINDEVENT(loc_oPagina.txt_4c_Usuarios, "KeyPress", THIS, "UsuariosLookupLostFocus")
553: 
554:         *-- Say2 "Empresa :" (Left=393,Top=167) + GetEmpresa (Left=443,Top=163,Width=35,Height=23)
555:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
556:         WITH loc_oPagina.lbl_4c_Label2
557:             .Caption   = "Empresa :"
558:             .Top       = 167 + 29
559:             .Left      = 393
560:             .Width     = 45
561:             .Height    = 17
562:             .Alignment = 0
563:             .FontName  = "Tahoma"
564:             .FontSize  = 8
565:             .FontBold  = .F.
566:             .ForeColor = RGB(90, 90, 90)
567:             .BackStyle = 0
568:             .AutoSize  = .F.
569:             .Visible   = .T.
570:         ENDWITH
571: 
572:         loc_oPagina.AddObject("txt_4c_Empresa", "TextBox")
573:         WITH loc_oPagina.txt_4c_Empresa
574:             .Top           = 163 + 29
575:             .Left          = 443
576:             .Width         = 35
577:             .Height        = 23
578:             .MaxLength     = 3
579:             .Format        = "!"
580:             .SpecialEffect = 1
581:             .Themes        = .F.
582:             .FontName      = "Verdana"
583:             .FontSize      = 8
584:             .ToolTipText   = "Filtro de Empresa"
585:             .Value         = ""
586:             .Visible       = .T.
587:         ENDWITH
588:         *-- Lookup/validacao Empresa (legado: Valid com fAcessoEmpresa - NAO portada,
589:         *-- substituida por FormBuscaAuxiliar em SigCdEmp - memoria feedback_facessoempresa_nao_portada)
590:         BINDEVENT(loc_oPagina.txt_4c_Empresa, "KeyPress",  THIS, "EmpresaLookupKeyPress")
591:         BINDEVENT(loc_oPagina.txt_4c_Empresa, "DblClick",  THIS, "EmpresaLookupDblClick")
592:         BINDEVENT(loc_oPagina.txt_4c_Empresa, "KeyPress", THIS, "EmpresaLookupLostFocus")
593: 
594:         THIS.TornarControlesVisiveis(loc_oPagina)
595:     ENDPROC
596: 
597:     *===========================================================================
598:     * CarregarLista - Carrega dados no grid da Page1
599:     * OBRIGATORIO: Reconfigura ControlSource e Headers APOS RecordSource (Problema 2/48)
600:     * OBRIGATORIO: GO TOP + Refresh apos popular cursor (CLAUDE.md regra #21a)
601:     *===========================================================================
602:     PROCEDURE CarregarLista()
603:         LOCAL loc_lResultado, loc_oGrid
604:         loc_lResultado = .F.
605: 
606:         TRY
607:             IF !THIS.this_oBusinessObject.Buscar("")
608:                 loc_lResultado = .F.
609:             ELSE
610:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
611: 
612:                 *-- RecordSource FORA do WITH (Problema 36), ANTES de ControlSource
613:                 loc_oGrid.ColumnCount = 2
614:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
615: 
616:                 *-- ControlSource APOS RecordSource (auto-bind seria sobrescrito - Problema 48)
617:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Usuarios"
618:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Emps"
619: 
620:                 loc_oGrid.Column1.Width = 600
621:                 loc_oGrid.Column2.Width = 280
622: 
623:                 *-- Headers APOS RecordSource (OBRIGATORIO - RecordSource reseta captions)
624:                 loc_oGrid.Column1.Header1.Caption = "Usu" + CHR(225) + "rio"
625:                 loc_oGrid.Column2.Header1.Caption = "Empresa"
626: 
627:                 IF USED("cursor_4c_Dados")
628:                     GO TOP IN cursor_4c_Dados
629:                 ENDIF
630: 
631:                 THIS.FormatarGridLista(loc_oGrid)
632:                 loc_oGrid.Refresh()
633:                 loc_lResultado = .T.
634:             ENDIF
635: 
636:         CATCH TO loException
637:             MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message + CHR(13) + ;
638:                 "Linha: " + TRANSFORM(loException.LineNo), ;
639:                 "FormUep.CarregarLista")
640:             loc_lResultado = .F.
641:         ENDTRY
642: 
643:         RETURN loc_lResultado
644:     ENDPROC
645: 
646:     *===========================================================================
647:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
648:     * Ao voltar para Page1, recarrega a lista
649:     *===========================================================================
650:     PROCEDURE AlternarPagina(par_nPagina)
651:         LOCAL loc_lResultado
652:         loc_lResultado = .F.
653: 
654:         TRY
655:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
656:                 MsgAviso("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + TRANSFORM(par_nPagina))
657:             ELSE
658:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
659: 
660:                 IF par_nPagina = 1
661:                     THIS.this_cModoAtual = "LISTA"
662:                     THIS.CarregarLista()
663:                 ENDIF
664: 
665:                 loc_lResultado = .T.
666:             ENDIF
667: 
668:         CATCH TO loException
669:             MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loException.Message, ;
670:                 "FormUep.AlternarPagina")
671:         ENDTRY
672: 
673:         RETURN loc_lResultado
674:     ENDPROC
675: 
676:     *===========================================================================
677:     * FormatarGridLista - Formata visual do grid de lista (FontName/FontSize)
678:     *===========================================================================
679:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
680:         TRY
681:             WITH par_oGrid
682:                 .FontName = "Verdana"
683:                 .FontSize = 8
684:             ENDWITH
685:         CATCH TO loException
686:             MostrarErro("Erro ao formatar grid:" + CHR(13) + loException.Message, ;
687:                 "FormUep.FormatarGridLista")
688:         ENDTRY
689:     ENDPROC
690: 
691:     *===========================================================================
692:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
693:     * REGRA: Chamar SEMPRE com parametro: THIS.TornarControlesVisiveis(loc_oPagina)
694:     *===========================================================================
695:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
696:         LOCAL loc_nI, loc_oObjeto, loc_nP
697: 
698:         FOR loc_nI = 1 TO par_oContainer.ControlCount
699:             loc_oObjeto = par_oContainer.Controls(loc_nI)
700: 
701:             IF VARTYPE(loc_oObjeto) = "O"
702:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
703:                     loc_oObjeto.Visible = .T.
704:                 ENDIF
705: 
706:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
707:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
708:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
709:                     ENDFOR
710:                 ENDIF
711: 
712:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
713:                     THIS.TornarControlesVisiveis(loc_oObjeto)
714:                 ENDIF
715:             ENDIF
716:         ENDFOR
717:     ENDPROC
718: 
719:     *===========================================================================
720:     * LimparCampos - Limpa valores dos campos de Page2
721:     *===========================================================================
722:     PROCEDURE LimparCampos()
723:         LOCAL loc_oPagina
724:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
725: 
726:         loc_oPagina.txt_4c_Usuarios.Value = ""
727:         loc_oPagina.txt_4c_Empresa.Value  = ""
728: 
729:         THIS.this_cUltimoUsuarioValidado = ""
730:         THIS.this_cUltimaEmpresaValidada = ""
731:     ENDPROC
732: 
733:     *===========================================================================
734:     * HabilitarCampos - Habilita/desabilita campos conforme modo atual
735:     * REGRA DE NEGOCIO TRANSCRITA DO LEGADO (When de cada campo):
736:     *   getUsuarios.When = InList(pcEscolha,'INSERIR','PROCURAR') -> so editavel em INCLUIR
737:     *     (Usuarios funciona como chave de negocio: uma vez gravado, nao pode mudar)
738:     *   GetEmpresa.When  = InList(pcEscolha,'INSERIR','ALTERAR')  -> editavel em INCLUIR e ALTERAR
739:     *===========================================================================
740:     PROCEDURE HabilitarCampos(par_lHabilitar)
741:         LOCAL loc_oPagina
742:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
743: 
744:         loc_oPagina.txt_4c_Usuarios.Enabled = par_lHabilitar AND (THIS.this_cModoAtual == "INCLUIR")
745: 
746:         loc_oPagina.txt_4c_Empresa.Enabled = par_lHabilitar AND ;
747:             INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
748:     ENDPROC
749: 
750:     *===========================================================================
751:     * AjustarBotoesPorModo - Ajusta Confirmar/Cancelar conforme modo atual
752:     * Modo VISUALIZAR: Confirmar desabilitado, Cancelar habilitado (padrao consulta)
753:     *===========================================================================
754:     PROCEDURE AjustarBotoesPorModo()
755:         LOCAL loc_oBotoes
756:         loc_oBotoes = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
757: 
758:         DO CASE
759:             CASE THIS.this_cModoAtual == "VISUALIZAR"
760:                 loc_oBotoes.cmd_4c_Confirmar.Enabled = .F.
761:                 loc_oBotoes.cmd_4c_Cancelar.Enabled  = .T.
762:             OTHERWISE
763:                 loc_oBotoes.cmd_4c_Confirmar.Enabled = .T.
764:                 loc_oBotoes.cmd_4c_Cancelar.Enabled  = .T.
765:         ENDCASE
766:     ENDPROC
767: 
768:     *===========================================================================
769:     * FormParaBO - Transfere valores do Form para o Business Object
770:     *===========================================================================
771:     PROCEDURE FormParaBO()
772:         LOCAL loc_oPagina
773:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
774: 
775:         THIS.this_oBusinessObject.this_cUsuarios = ALLTRIM(loc_oPagina.txt_4c_Usuarios.Value)
776:         THIS.this_oBusinessObject.this_cEmps     = ALLTRIM(loc_oPagina.txt_4c_Empresa.Value)
777:     ENDPROC
778: 
779:     *===========================================================================
780:     * BOParaForm - Transfere valores do Business Object para o Form
781:     *===========================================================================
782:     PROCEDURE BOParaForm()
783:         LOCAL loc_oPagina
784:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
785: 
786:         loc_oPagina.txt_4c_Usuarios.Value = THIS.this_oBusinessObject.this_cUsuarios
787:         loc_oPagina.txt_4c_Empresa.Value  = THIS.this_oBusinessObject.this_cEmps
788: 
789:         THIS.this_cUltimoUsuarioValidado = ALLTRIM(THIS.this_oBusinessObject.this_cUsuarios)
790:         THIS.this_cUltimaEmpresaValidada = ALLTRIM(THIS.this_oBusinessObject.this_cEmps)
791:     ENDPROC
792: 
793:     *===========================================================================
794:     * AbrirLookupUsuario - Lookup do campo Usuarios (legado: fwBuscaExt em SigCdUsu)
795:     * Filtro NOT cAtivos='N' (legado): mostra apenas usuarios ativos
796:     * Busca exata primeiro (mode par_lBuscaExata=.F. permite fallback parcial na
797:     * classe FormBuscaAuxiliar); se nao achou registro exato, abre grid p/ selecao
798:     *===========================================================================
799:     PROCEDURE AbrirLookupUsuario(par_cValor)
800:         LOCAL loc_oBusca, loc_oPagina, loc_cUsuario
801:         loc_oPagina  = THIS.pgf_4c_Paginas.Page2
802:         loc_cUsuario = ""
803: 
804:         TRY
805:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
806:                 "SigCdUsu", "cursor_4c_BuscaUsuario", "Usuarios", par_cValor, ;
807:                 "Sele" + CHR(231) + CHR(227) + "o", .F., .F., "NOT cAtivos='N'")
808: 
809:             IF VARTYPE(loc_oBusca) = "O"
810:                 IF !loc_oBusca.this_lAchouRegistro
811:                     loc_oBusca.mAddColuna("Usuarios", "", "C" + CHR(243) + "digo")
812:                     loc_oBusca.mAddColuna("NComps",   "", "Nome")
813:                     loc_oBusca.Show()
814:                 ENDIF
815: 
816:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUsuario")
817:                     SELECT cursor_4c_BuscaUsuario
818:                     loc_cUsuario = ALLTRIM(cursor_4c_BuscaUsuario.Usuarios)
819:                 ENDIF
820: 
821:                 loc_oBusca.Release()
822:             ENDIF
823: 
824:             IF USED("cursor_4c_BuscaUsuario")
825:                 USE IN cursor_4c_BuscaUsuario
826:             ENDIF
827: 
828:             loc_oPagina.txt_4c_Usuarios.Value = loc_cUsuario
829:             THIS.this_cUltimoUsuarioValidado  = loc_cUsuario
830: 
831:         CATCH TO loException
832:             MostrarErro("Erro ao buscar usu" + CHR(225) + "rio:" + CHR(13) + loException.Message, ;
833:                 "FormUep.AbrirLookupUsuario")
834:             IF USED("cursor_4c_BuscaUsuario")
835:                 USE IN cursor_4c_BuscaUsuario
836:             ENDIF
837:         ENDTRY
838:     ENDPROC
839: 
840:     *===========================================================================
841:     * ValidarUsuarios - Handler de LostFocus do txt_4c_Usuarios (equivale ao Valid legado)
842:     * Guarda ultimo valor validado para nao reabrir o lookup em CADA perda de foco
843:     * sem mudanca de valor (Problema 45)
844:     *===========================================================================
845:     PROCEDURE ValidarUsuarios()
846:         LOCAL loc_cValor
847:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Usuarios.Value)
848: 
849:         IF loc_cValor == THIS.this_cUltimoUsuarioValidado
850:             RETURN
851:         ENDIF
852:         THIS.this_cUltimoUsuarioValidado = loc_cValor
853: 
854:         IF !EMPTY(loc_cValor)
855:             THIS.AbrirLookupUsuario(loc_cValor)
856:         ENDIF
857:     ENDPROC
858: 
859:     *===========================================================================
860:     * UsuariosLookupKeyPress/DblClick/LostFocus - Handlers PUBLIC de BINDEVENT
861:     * (regra #3/CLAUDE.md: BINDEVENT exige metodo PUBLIC + parametros declarados)
862:     *===========================================================================
863:     PROCEDURE UsuariosLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
864:         IF par_nKeyCode = 28
865:             THIS.AbrirLookupUsuario(ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Usuarios.Value))
866:         ENDIF
867:     ENDPROC
868: 
869:     PROCEDURE UsuariosLookupDblClick()
870:         THIS.AbrirLookupUsuario(ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Usuarios.Value))
871:     ENDPROC
872: 
873:     PROCEDURE UsuariosLookupLostFocus(par_nKeyCode, par_nShiftAltCtrl)
874:         THIS.ValidarUsuarios()
875:     ENDPROC
876: 
877:     *===========================================================================
878:     * AbrirLookupEmpresa - Substitui fAcessoEmpresa() (NAO portada - memoria
879:     * feedback_facessoempresa_nao_portada). Modo CODIGO (chave Cemps) em SigCdEmp.
880:     *===========================================================================
881:     PROCEDURE AbrirLookupEmpresa(par_cValor)
882:         LOCAL loc_oBusca, loc_oPagina, loc_cEmpresa
883:         loc_oPagina  = THIS.pgf_4c_Paginas.Page2
884:         loc_cEmpresa = ""
885: 
886:         TRY
887:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
888:                 "SigCdEmp", "cursor_4c_BuscaEmpresa", "Cemps", par_cValor, ;
889:                 "Sele" + CHR(231) + CHR(227) + "o de Empresa")
890: 
891:             IF VARTYPE(loc_oBusca) = "O"
892:                 IF !loc_oBusca.this_lAchouRegistro
893:                     loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
894:                     loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
895:                     loc_oBusca.Show()
896:                 ENDIF
897: 
898:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpresa")
899:                     SELECT cursor_4c_BuscaEmpresa
900:                     loc_cEmpresa = ALLTRIM(cursor_4c_BuscaEmpresa.Cemps)
901:                 ENDIF
902: 
903:                 loc_oBusca.Release()
904:             ENDIF
905: 
906:             IF USED("cursor_4c_BuscaEmpresa")
907:                 USE IN cursor_4c_BuscaEmpresa
908:             ENDIF
909: 
910:             IF EMPTY(loc_cEmpresa)
911:                 MsgAviso("Empresa Inv" + CHR(225) + "lida!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
912:             ENDIF
913: 
914:             loc_oPagina.txt_4c_Empresa.Value = loc_cEmpresa
915:             THIS.this_cUltimaEmpresaValidada = loc_cEmpresa
916: 
917:         CATCH TO loException
918:             MostrarErro("Erro ao validar empresa:" + CHR(13) + loException.Message, ;
919:                 "FormUep.AbrirLookupEmpresa")
920:             IF USED("cursor_4c_BuscaEmpresa")
921:                 USE IN cursor_4c_BuscaEmpresa
922:             ENDIF
923:         ENDTRY
924:     ENDPROC
925: 
926:     *===========================================================================
927:     * ValidarEmpresa - Handler de LostFocus do txt_4c_Empresa (equivale ao Valid legado)
928:     * Legado: campo obrigatorio (MessageBox 'Preenchimento Obrigatorio' se vazio)
929:     *===========================================================================
930:     PROCEDURE ValidarEmpresa()
931:         LOCAL loc_cValor
932:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Empresa.Value)
933: 
934:         IF EMPTY(loc_cValor)
935:             RETURN
936:         ENDIF
937: 
938:         IF loc_cValor == THIS.this_cUltimaEmpresaValidada
939:             RETURN
940:         ENDIF
941:         THIS.this_cUltimaEmpresaValidada = loc_cValor
942: 
943:         THIS.AbrirLookupEmpresa(loc_cValor)
944:     ENDPROC
945: 
946:     *===========================================================================
947:     * EmpresaLookupKeyPress/DblClick/LostFocus - Handlers PUBLIC de BINDEVENT
948:     *===========================================================================
949:     PROCEDURE EmpresaLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
950:         IF par_nKeyCode = 28
951:             THIS.AbrirLookupEmpresa(ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Empresa.Value))
952:         ENDIF
953:     ENDPROC
954: 
955:     PROCEDURE EmpresaLookupDblClick()
956:         THIS.AbrirLookupEmpresa(ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Empresa.Value))
957:     ENDPROC
958: 
959:     PROCEDURE EmpresaLookupLostFocus(par_nKeyCode, par_nShiftAltCtrl)
960:         THIS.ValidarEmpresa()
961:     ENDPROC
962: 
963:     *===========================================================================
964:     * BtnIncluirClick - Abre Page2 para incluir novo registro
965:     * PUBLIC: BINDEVENT requer metodo publico (regra #3/CLAUDE.md)
966:     *===========================================================================
967:     PROCEDURE BtnIncluirClick()
968:         THIS.this_oBusinessObject.NovoRegistro()
969:         THIS.LimparCampos()
970:         THIS.this_cModoAtual = "INCLUIR"
971:         THIS.HabilitarCampos(.T.)
972:         THIS.AjustarBotoesPorModo()
973:         THIS.AlternarPagina(2)
974:         THIS.pgf_4c_Paginas.Page2.txt_4c_Usuarios.SetFocus()
975:     ENDPROC
976: 
977:     *===========================================================================
978:     * BtnVisualizarClick - Abre Page2 em modo somente leitura
979:     * PUBLIC: BINDEVENT requer metodo publico
980:     *===========================================================================
981:     PROCEDURE BtnVisualizarClick()
982:         LOCAL loc_cCodigo
983:         loc_cCodigo = ""
984: 
985:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
986:             SELECT cursor_4c_Dados
987:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cIdChaves)
988:         ENDIF
989: 
990:         IF EMPTY(loc_cCodigo)
991:             MsgAviso("Selecione um registro para visualizar.")
992:         ELSE
993:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
994:                 THIS.this_cModoAtual = "VISUALIZAR"
995:                 THIS.BOParaForm()
996:                 THIS.HabilitarCampos(.F.)
997:                 THIS.AjustarBotoesPorModo()
998:                 THIS.AlternarPagina(2)
999:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus()
1000:             ENDIF
1001:         ENDIF
1002:     ENDPROC
1003: 
1004:     *===========================================================================
1005:     * BtnAlterarClick - Abre Page2 para alterar registro selecionado
1006:     * PUBLIC: BINDEVENT requer metodo publico
1007:     *===========================================================================
1008:     PROCEDURE BtnAlterarClick()
1009:         LOCAL loc_cCodigo
1010:         loc_cCodigo = ""
1011: 
1012:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1013:             SELECT cursor_4c_Dados
1014:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cIdChaves)
1015:         ENDIF
1016: 
1017:         IF EMPTY(loc_cCodigo)
1018:             MsgAviso("Selecione um registro para alterar.")
1019:         ELSE
1020:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1021:                 THIS.this_oBusinessObject.EditarRegistro()
1022:                 THIS.this_cModoAtual = "ALTERAR"
1023:                 THIS.BOParaForm()
1024:                 THIS.HabilitarCampos(.T.)
1025:                 THIS.AjustarBotoesPorModo()
1026:                 THIS.AlternarPagina(2)
1027:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Empresa.SetFocus()
1028:             ENDIF
1029:         ENDIF
1030:     ENDPROC
1031: 
1032:     *===========================================================================
1033:     * BtnExcluirClick - Exclui registro selecionado com confirmacao
1034:     * PUBLIC: BINDEVENT requer metodo publico
1035:     *===========================================================================
1036:     PROCEDURE BtnExcluirClick()
1037:         LOCAL loc_cCodigo, loc_cUsuario
1038:         loc_cCodigo  = ""
1039:         loc_cUsuario = ""
1040: 
1041:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1042:             SELECT cursor_4c_Dados
1043:             loc_cCodigo  = ALLTRIM(cursor_4c_Dados.cIdChaves)
1044:             loc_cUsuario = ALLTRIM(cursor_4c_Dados.Usuarios)
1045:         ENDIF
1046: 
1047:         IF EMPTY(loc_cCodigo)
1048:             MsgAviso("Selecione um registro para excluir.")
1049:         ELSE
1050:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1051:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do usu" + CHR(225) + "rio [" + ;
1052:                         loc_cUsuario + "]?", "Confirmar Exclus" + CHR(227) + "o")
1053:                     IF THIS.this_oBusinessObject.Excluir()
1054:                         MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
1055:                         THIS.CarregarLista()
1056:                     ENDIF
1057:                 ENDIF
1058:             ENDIF
1059:         ENDIF
1060:     ENDPROC
1061: 
1062:     *===========================================================================
1063:     * BtnBuscarClick - Abre picker para localizar registro na lista
1064:     * Apos selecao, posiciona o cursor no registro encontrado
1065:     * PUBLIC: BINDEVENT requer metodo publico
1066:     *===========================================================================
1067:     PROCEDURE BtnBuscarClick()
1068:         LOCAL loc_oBusca, loc_cUsuario
1069:         loc_cUsuario = ""
1070: 
1071:         TRY
1072:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1073:                 "SigCdUep", "cursor_4c_BuscaUep", "Usuarios", "", ;
1074:                 "Buscar Usu" + CHR(225) + "rio Fixo")
1075: 
1076:             IF VARTYPE(loc_oBusca) = "O"
1077:                 loc_oBusca.mAddColuna("Usuarios", "", "Usu" + CHR(225) + "rio")
1078:                 loc_oBusca.mAddColuna("Emps",     "", "Empresa")
1079:                 loc_oBusca.Show()
1080: 
1081:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUep")
1082:                     SELECT cursor_4c_BuscaUep
1083:                     loc_cUsuario = ALLTRIM(cursor_4c_BuscaUep.Usuarios)
1084:                 ENDIF
1085: 
1086:                 loc_oBusca.Release()
1087:             ENDIF
1088: 
1089:             IF USED("cursor_4c_BuscaUep")
1090:                 USE IN cursor_4c_BuscaUep
1091:             ENDIF
1092: 
1093:             IF !EMPTY(loc_cUsuario) AND USED("cursor_4c_Dados")
1094:                 SELECT cursor_4c_Dados
1095:                 LOCATE FOR ALLTRIM(Usuarios) == loc_cUsuario
1096:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
1097:             ENDIF
1098: 
1099:         CATCH TO loException
1100:             MostrarErro("Erro na busca:" + CHR(13) + loException.Message, "FormUep.BtnBuscarClick")
1101:             IF USED("cursor_4c_BuscaUep")
1102:                 USE IN cursor_4c_BuscaUep
1103:             ENDIF
1104:         ENDTRY
1105:     ENDPROC
1106: 
1107:     *===========================================================================
1108:     * BtnSalvarClick - Confirma inclusao/alteracao (Grupo_Salva.Salva no legado)
1109:     * PUBLIC: BINDEVENT requer metodo publico
1110:     *
1111:     * Transcricao literal do legado (CLAUDE.md regra #17 - nao reescrever):
1112:     *   - INCLUIR/ALTERAR: Usuarios e Empresa obrigatorios
1113:     *   - Apenas em INCLUIR: verifica duplicidade de Usuarios em SigCdUep
1114:     *     ANTES de gravar (Select Usuarios From SigCdUep Where Usuarios =
1115:     *     Padr(valor,3) - o PADR(,3) e literal do fonte original)
1116:     *===========================================================================
1117:     PROCEDURE BtnSalvarClick()
1118:         LOCAL loc_oPagina, loc_cUsuarios, loc_cEmpresa, loc_cSQL, loc_nResultado, loc_lProsseguir
1119:         loc_oPagina      = THIS.pgf_4c_Paginas.Page2
1120:         loc_cUsuarios    = ALLTRIM(loc_oPagina.txt_4c_Usuarios.Value)
1121:         loc_cEmpresa     = ALLTRIM(loc_oPagina.txt_4c_Empresa.Value)
1122:         loc_lProsseguir  = .T.
1123: 
1124:         IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1125:             IF EMPTY(loc_cUsuarios)
1126:                 MsgAviso("Usu" + CHR(225) + "rio Inv" + CHR(225) + "lido!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
1127:                 loc_oPagina.txt_4c_Usuarios.SetFocus()
1128:                 loc_lProsseguir = .F.
1129:             ENDIF
1130: 
1131:             IF loc_lProsseguir AND EMPTY(loc_cEmpresa)
1132:                 MsgAviso("Empresa Inv" + CHR(225) + "lida!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
1133:                 loc_oPagina.txt_4c_Empresa.SetFocus()
1134:                 loc_lProsseguir = .F.
1135:             ENDIF
1136: 
1137:             IF loc_lProsseguir AND THIS.this_cModoAtual == "INCLUIR"
1138:                 TRY
1139:                     IF USED("cursor_4c_VerificaUep")
1140:                         USE IN cursor_4c_VerificaUep
1141:                     ENDIF
1142: 
1143:                     loc_cSQL = "SELECT Usuarios FROM SigCdUep WHERE Usuarios = " + ;
1144:                         EscaparSQL(PADR(loc_cUsuarios, 3))
1145: 
1146:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerificaUep")
1147: 
1148:                     IF loc_nResultado < 0
1149:                         MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o")
1150:                         loc_lProsseguir = .F.
1151:                     ELSE
1152:                         IF USED("cursor_4c_VerificaUep")
1153:                             GO TOP IN cursor_4c_VerificaUep
1154:                             IF !EOF("cursor_4c_VerificaUep")
1155:                                 MsgAviso("Usu" + CHR(225) + "rio J" + CHR(225) + " Cadastrado!!!", ;
1156:                                     "Aten" + CHR(231) + CHR(227) + "o!!!")
1157:                                 loc_oPagina.txt_4c_Usuarios.SetFocus()
1158:                                 loc_lProsseguir = .F.
1159:                             ENDIF
1160:                         ENDIF
1161:                     ENDIF
1162: 
1163:                     IF USED("cursor_4c_VerificaUep")
1164:                         USE IN cursor_4c_VerificaUep
1165:                     ENDIF
1166: 
1167:                 CATCH TO loException
1168:                     MostrarErro("Erro ao verificar duplicidade:" + CHR(13) + loException.Message, ;
1169:                         "FormUep.BtnSalvarClick")
1170:                     loc_lProsseguir = .F.
1171:                 ENDTRY
1172:             ENDIF
1173:         ENDIF
1174: 
1175:         IF loc_lProsseguir
1176:             THIS.FormParaBO()
1177: 
1178:             IF THIS.this_oBusinessObject.Salvar()
1179:                 MsgInfo("Registro salvo com sucesso!")
1180:                 THIS.AlternarPagina(1)
1181:             ENDIF
1182:         ENDIF
1183:     ENDPROC
1184: 
1185:     *===========================================================================
1186:     * BtnCancelarClick - Descarta alteracoes e volta para a lista
1187:     * PUBLIC: BINDEVENT requer metodo publico
1188:     *===========================================================================
1189:     PROCEDURE BtnCancelarClick()
1190:         THIS.AlternarPagina(1)
1191:     ENDPROC
1192: 
1193:     *===========================================================================
1194:     * BtnEncerrarClick - Fecha o formulario
1195:     * PUBLIC: BINDEVENT requer metodo publico
1196:     *===========================================================================
1197:     PROCEDURE BtnEncerrarClick()
1198:         THIS.Release()
1199:     ENDPROC
1200: 
1201:     *===========================================================================
1202:     * Destroy - Libera recursos do formulario
1203:     *===========================================================================
1204:     PROCEDURE Destroy()
1205:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1206:             THIS.this_oBusinessObject = .NULL.
1207:         ENDIF
1208: 
1209:         IF USED("cursor_4c_Dados")
1210:             USE IN cursor_4c_Dados
1211:         ENDIF
1212: 
1213:         DODEFAULT()
1214:     ENDPROC
1215: 
1216: ENDDEFINE


### BO (C:\4c\projeto\app\classes\UepBO.prg):
*====================================================================
* UepBO.prg
*
* Business Object para Cadastro de Usuarios Fixos Por Empresa
* Tabela: SigCdUep
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS UepBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdUep)
    this_cIdChaves = ""    && cidchaves char(20) - PK (Fortyus)
    this_cUsuarios = ""    && usuarios  char(10) - Codigo do Usuario (FK SigCdUsu.Usuarios)
    this_cEmps     = ""    && emps      char(3)  - Filtro de Empresa

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdUep"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "UepBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cIdChaves)
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
                THIS.this_cIdChaves = TratarNulo(cIdChaves, "C")
                THIS.this_cUsuarios = TratarNulo(Usuarios,  "C")
                THIS.this_cEmps     = TratarNulo(Emps,      "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "UepBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigCdUep
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cIdChaves)
                THIS.this_cIdChaves = fUniqueIds()
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdUep (cIdChaves, Usuarios, Emps)
                VALUES (
                    <<EscaparSQL(THIS.this_cIdChaves)>>,
                    <<EscaparSQL(THIS.this_cUsuarios)>>,
                    <<EscaparSQL(THIS.this_cEmps)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir usu" + CHR(225) + "rio fixo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "UepBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdUep
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdUep
                SET Usuarios = <<EscaparSQL(THIS.this_cUsuarios)>>,
                    Emps     = <<EscaparSQL(THIS.this_cEmps)>>
                WHERE cIdChaves = <<EscaparSQL(THIS.this_cIdChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar usu" + CHR(225) + "rio fixo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "UepBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdUep
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdUep WHERE cIdChaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir usu" + CHR(225) + "rio fixo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "UepBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com cIdChaves, Usuarios, Emps
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (cIdChaves C(20), Usuarios C(10), Emps C(3))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT cIdChaves, Usuarios, Emps FROM SigCdUep"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY Usuarios"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar usu" + CHR(225) + "rios fixos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "UepBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (cIdChaves)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cIdChaves, Usuarios, Emps" + ;
                " FROM SigCdUep WHERE cIdChaves = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Usu" + CHR(225) + "rio fixo n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar usu" + CHR(225) + "rio fixo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "UepBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

