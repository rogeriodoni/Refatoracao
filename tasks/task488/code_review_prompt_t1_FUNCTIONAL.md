# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (22)
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BINDEVENT-PARAMS] Handler 'ValidarOpAnts' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarOpAnts(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarOpContas' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarOpContas(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarOpEntrada' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarOpEntrada(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarFpg' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarFpg(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarHispad' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarHispad(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarSituacao' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarSituacao(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarResponsavel' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarResponsavel(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarCentral' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarCentral(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarDescCentral' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarDescCentral(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarGrupoOrig' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarGrupoOrig(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarDescGrupoOrig' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarDescGrupoOrig(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarGrupoDest' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarGrupoDest(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarDescGrupoDest' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarDescGrupoDest(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarContaOrig' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarContaOrig(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarDescContaOrig' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarDescContaOrig(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarContaDest' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarContaDest(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarDescContaDest' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarDescContaDest(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarMoedas' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarMoedas(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarGrupoT' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarGrupoT(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarDescGrupoT' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarDescGrupoT(par_nKeyCode, par_nShiftAltCtrl)
- [GRID-SQLEXEC] SQLEXEC grava direto no cursor 'cursor_4c_Dados' que eh RecordSource de um Grid. Isso DESTROI as colunas do Grid! SOLUCAO: SQLEXEC em cursor temporario (ex: 'cursor_4c_DadosTemp'), depois ZAP + APPEND FROM DBF() no cursor original.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormOpt.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (4618 linhas total):

*-- Linhas 28 a 146:
28: 
29:     *==========================================================================
30:     * Init - REGRA CRITICA: Apenas RETURN DODEFAULT()
31:     * FormBase.Init() chama InicializarForm() automaticamente
32:     *==========================================================================
33:     PROCEDURE Init()
34:         RETURN DODEFAULT()
35:     ENDPROC
36: 
37:     *==========================================================================
38:     * InicializarForm - Cria BO, configura PageFrame e define modo inicial
39:     * Chamado automaticamente pelo FormBase.Init()
40:     *==========================================================================
41:     PROTECTED PROCEDURE InicializarForm()
42:         LOCAL loc_lSucesso
43:         loc_lSucesso = .F.
44: 
45:         TRY
46:             THIS.this_oBusinessObject = CREATEOBJECT("OptBO")
47: 
48:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
49:                 MostrarErro("Erro ao criar OptBO" + CHR(13) + ;
50:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
51:                     "FormOpt.InicializarForm")
52:             ELSE
53:                 THIS.ConfigurarPageFrame()
54: 
55:                 THIS.pgf_4c_Paginas.Visible    = .T.
56:                 THIS.pgf_4c_Paginas.ActivePage = 1
57:                 THIS.this_cModoAtual = "LISTA"
58: 
59:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
60:                     THIS.CarregarLista()
61:                 ENDIF
62: 
63:                 loc_lSucesso = .T.
64:             ENDIF
65:         CATCH TO loc_oErro
66:             MsgErro("Erro ao inicializar FormOpt:" + CHR(13) + ;
67:                 loc_oErro.Message + CHR(13) + ;
68:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
69:                 "FormOpt.InicializarForm")
70:         ENDTRY
71: 
72:         RETURN loc_lSucesso
73:     ENDPROC
74: 
75:     *==========================================================================
76:     * ConfigurarPageFrame - PageFrame com 2 paginas (Lista e Dados)
77:     * Top=-29 oculta as abas; controles compensam +29 no Top
78:     *==========================================================================
79:     PROTECTED PROCEDURE ConfigurarPageFrame()
80:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
81: 
82:         WITH THIS.pgf_4c_Paginas
83:             .PageCount       = 2
84:             .Top             = -29
85:             .Left            = 0
86:             .Width           = THIS.Width
87:             .Height          = THIS.Height + 29
88:             .Tabs            = .F.
89:             .Visible         = .T.
90:             .Page1.Caption   = "Lista"
91:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
92:             .Page1.BackColor = RGB(255, 255, 255)
93:             .Page2.Caption   = "Dados"
94:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
95:             .Page2.BackColor = RGB(255, 255, 255)
96:         ENDWITH
97: 
98:         THIS.ConfigurarPaginaLista()
99:         THIS.ConfigurarPaginaDados()
100:     ENDPROC
101: 
102:     *==========================================================================
103:     * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD e grid
104:     * Colunas do grid: Operacaos/Tipos/OpAnts/GrupoOs conforme legado Init
105:     *==========================================================================
106:     PROTECTED PROCEDURE ConfigurarPaginaLista()
107:         LOCAL loc_oPagina, loc_oGrid
108:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
109: 
110:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
111: 
112:         *-- Container Cabecalho (cntSombra no legado: top=2+29=31)
113:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
114:         WITH loc_oPagina.cnt_4c_Cabecalho
115:             .Top         = 31
116:             .Left        = 0
117:             .Width       = THIS.Width
118:             .Height      = 80
119:             .BackColor   = RGB(100, 100, 100)
120:             .BorderWidth = 0
121:             .Visible     = .T.
122:         ENDWITH
123: 
124:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
125:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
126:             .Caption   = "Movimenta" + CHR(231) + CHR(245) + "es de Cheques"
127:             .Top       = 15
128:             .Left      = 10
129:             .Width     = THIS.Width - 20
130:             .Height    = 40
131:             .FontName  = "Tahoma"
132:             .FontSize  = 16
133:             .FontBold  = .T.
134:             .ForeColor = RGB(0, 0, 0)
135:             .BackStyle = 0
136:             .AutoSize  = .F.
137:             .Visible   = .T.
138:         ENDWITH
139: 
140:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
141:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
142:             .Caption   = "Movimenta" + CHR(231) + CHR(245) + "es de Cheques"
143:             .Top       = 18
144:             .Left      = 10
145:             .Width     = THIS.Width - 20
146:             .Height    = 46

*-- Linhas 188 a 368:
188:             .AutoSize        = .F.
189:             .Visible         = .T.
190:         ENDWITH
191:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
192: 
193:         *-- Botao Visualizar
194:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
195:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
196:             .Caption         = "Visualizar"
197:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
198:             .PicturePosition = 13
199:             .Top             = 5
200:             .Left            = 80
201:             .Width           = 75
202:             .Height          = 75
203:             .BackColor       = RGB(255, 255, 255)
204:             .ForeColor       = RGB(90, 90, 90)
205:             .FontName        = "Comic Sans MS"
206:             .FontSize        = 8
207:             .FontBold        = .T.
208:             .FontItalic      = .T.
209:             .Themes          = .F.
210:             .SpecialEffect   = 0
211:             .MousePointer    = 15
212:             .WordWrap        = .T.
213:             .AutoSize        = .F.
214:             .Visible         = .T.
215:         ENDWITH
216:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
217: 
218:         *-- Botao Alterar
219:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
220:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
221:             .Caption         = "Alterar"
222:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
223:             .PicturePosition = 13
224:             .Top             = 5
225:             .Left            = 155
226:             .Width           = 75
227:             .Height          = 75
228:             .BackColor       = RGB(255, 255, 255)
229:             .ForeColor       = RGB(90, 90, 90)
230:             .FontName        = "Comic Sans MS"
231:             .FontSize        = 8
232:             .FontBold        = .T.
233:             .FontItalic      = .T.
234:             .Themes          = .F.
235:             .SpecialEffect   = 0
236:             .MousePointer    = 15
237:             .WordWrap        = .T.
238:             .AutoSize        = .F.
239:             .Visible         = .T.
240:         ENDWITH
241:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
242: 
243:         *-- Botao Excluir
244:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
245:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
246:             .Caption         = "Excluir"
247:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
248:             .PicturePosition = 13
249:             .Top             = 5
250:             .Left            = 230
251:             .Width           = 75
252:             .Height          = 75
253:             .BackColor       = RGB(255, 255, 255)
254:             .ForeColor       = RGB(90, 90, 90)
255:             .FontName        = "Comic Sans MS"
256:             .FontSize        = 8
257:             .FontBold        = .T.
258:             .FontItalic      = .T.
259:             .Themes          = .F.
260:             .SpecialEffect   = 0
261:             .MousePointer    = 15
262:             .WordWrap        = .T.
263:             .AutoSize        = .F.
264:             .Visible         = .T.
265:         ENDWITH
266:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
267: 
268:         *-- Botao Buscar
269:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
270:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
271:             .Caption         = "Buscar"
272:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
273:             .PicturePosition = 13
274:             .Top             = 5
275:             .Left            = 305
276:             .Width           = 75
277:             .Height          = 75
278:             .BackColor       = RGB(255, 255, 255)
279:             .ForeColor       = RGB(90, 90, 90)
280:             .FontName        = "Comic Sans MS"
281:             .FontSize        = 8
282:             .FontBold        = .T.
283:             .FontItalic      = .T.
284:             .Themes          = .F.
285:             .SpecialEffect   = 0
286:             .MousePointer    = 15
287:             .WordWrap        = .T.
288:             .AutoSize        = .F.
289:             .Visible         = .T.
290:         ENDWITH
291:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
292: 
293:         *-- Container Saida (padrao canonico: Left=917, Width=90, cmd Width=75)
294:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
295:         WITH loc_oPagina.cnt_4c_Saida
296:             .Top         = 29
297:             .Left        = 917
298:             .Width       = 90
299:             .Height      = 85
300:             .BackStyle   = 0
301:             .BorderWidth = 0
302:             .Visible     = .T.
303:         ENDWITH
304: 
305:         *-- Botao Encerrar
306:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
307:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
308:             .Caption         = "Encerrar"
309:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
310:             .PicturePosition = 13
311:             .Top             = 5
312:             .Left            = 5
313:             .Width           = 75
314:             .Height          = 75
315:             .BackColor       = RGB(255, 255, 255)
316:             .ForeColor       = RGB(90, 90, 90)
317:             .FontName        = "Comic Sans MS"
318:             .FontSize        = 8
319:             .FontBold        = .T.
320:             .FontItalic      = .T.
321:             .Themes          = .F.
322:             .SpecialEffect   = 0
323:             .MousePointer    = 15
324:             .WordWrap        = .T.
325:             .AutoSize        = .F.
326:             .Visible         = .T.
327:         ENDWITH
328:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
329: 
330:         *-- Grid da lista (colunas do legado: Movimento/Tipo/Mv.Anterior/Grupo-Ori)
331:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
332:         loc_oGrid = loc_oPagina.grd_4c_Lista
333: 
334:         loc_oGrid.RecordSource = ""
335:         loc_oGrid.ColumnCount  = 4
336: 
337:         WITH loc_oGrid
338:             .Top                = 117
339:             .Left               = 4
340:             .Width              = 992
341:             .Height             = 450
342:             .FontName           = "Verdana"
343:             .FontSize           = 8
344:             .ForeColor          = RGB(90, 90, 90)
345:             .BackColor          = RGB(255, 255, 255)
346:             .GridLineColor      = RGB(238, 238, 238)
347:             .HighlightBackColor = RGB(255, 255, 255)
348:             .HighlightForeColor = RGB(15, 41, 104)
349:             .HighlightStyle     = 2
350:             .DeleteMark         = .F.
351:             .RecordMark         = .F.
352:             .RowHeight          = 16
353:             .ScrollBars         = 2
354:             .GridLines          = 3
355:             .ReadOnly           = .T.
356:             .Visible            = .T.
357:         ENDWITH
358: 
359:         WITH loc_oGrid.Column1
360:             .Header1.Caption = "Movimento"
361:             .Width           = 140
362:             .ReadOnly        = .T.
363:         ENDWITH
364: 
365:         WITH loc_oGrid.Column2
366:             .Header1.Caption = "Tipo"
367:             .Width           = 60
368:             .ReadOnly        = .T.

*-- Linhas 380 a 495:
380:             .ReadOnly        = .T.
381:         ENDWITH
382: 
383:         THIS.TornarControlesVisiveis(loc_oPagina)
384:     ENDPROC
385: 
386:     *==========================================================================
387:     * ConfigurarPaginaDados - Page2: todos os campos SIGCDOPT
388:     * Fase 5/8: BotoesAcao + campos top<=248 (ate Line2) + BINDEVENTs
389:     * Todos os Tops recebem +29 (compensacao PageFrame.Top=-29)
390:     *==========================================================================
391:     PROTECTED PROCEDURE ConfigurarPaginaDados()
392:         LOCAL loc_oPagina
393:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
394: 
395:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
396: 
397:         *-- Container BotoesAcao (Grupo_Salva: top=4+29=33, left=842)
398:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
399:         WITH loc_oPagina.cnt_4c_BotoesAcao
400:             .Top         = 33
401:             .Left        = 842
402:             .Width       = 160
403:             .Height      = 85
404:             .BackStyle   = 0
405:             .BorderWidth = 0
406:             .Visible     = .T.
407:         ENDWITH
408: 
409:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
410:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
411:             .Caption         = "Confirmar"
412:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
413:             .PicturePosition = 13
414:             .Top             = 5
415:             .Left            = 5
416:             .Width           = 75
417:             .Height          = 75
418:             .BackColor       = RGB(255, 255, 255)
419:             .ForeColor       = RGB(90, 90, 90)
420:             .FontName        = "Comic Sans MS"
421:             .FontSize        = 8
422:             .FontBold        = .T.
423:             .FontItalic      = .T.
424:             .Themes          = .F.
425:             .SpecialEffect   = 0
426:             .MousePointer    = 15
427:             .WordWrap        = .T.
428:             .AutoSize        = .F.
429:             .Visible         = .T.
430:         ENDWITH
431:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
432: 
433:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
434:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
435:             .Caption         = "Encerrar"
436:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
437:             .PicturePosition = 13
438:             .Top             = 5
439:             .Left            = 80
440:             .Width           = 75
441:             .Height          = 75
442:             .BackColor       = RGB(255, 255, 255)
443:             .ForeColor       = RGB(90, 90, 90)
444:             .FontName        = "Comic Sans MS"
445:             .FontSize        = 8
446:             .FontBold        = .T.
447:             .FontItalic      = .T.
448:             .Themes          = .F.
449:             .SpecialEffect   = 0
450:             .MousePointer    = 15
451:             .WordWrap        = .T.
452:             .AutoSize        = .F.
453:             .Visible         = .T.
454:         ENDWITH
455:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
456: 
457:         *-- CheckBox: Inativa (fwcheckbox1 - top=15+29=44, left=299)
458:         loc_oPagina.AddObject("chk_4c_Fwcheckbox1", "CheckBox")
459:         WITH loc_oPagina.chk_4c_Fwcheckbox1
460:             .Caption   = "Inativa"
461:             .Top       = 44
462:             .Left      = 299
463:             .Width     = 60
464:             .Height    = 20
465:             .Value     = 0
466:             .FontName  = "Tahoma"
467:             .FontSize  = 8
468:             .ForeColor = RGB(90, 90, 90)
469:             .BackStyle = 0
470:             .Visible   = .T.
471:         ENDWITH
472: 
473:         *-- Linha 1: Codigo / Descricao / Tipo (top original=12-16; comp.=41-45)
474:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
475:         WITH loc_oPagina.lbl_4c_Label1
476:             .Caption   = "C" + CHR(243) + "digo :"
477:             .Top       = 45
478:             .Left      = 100
479:             .Width     = 43
480:             .Height    = 17
481:             .FontName  = "Tahoma"
482:             .FontSize  = 8
483:             .ForeColor = RGB(90, 90, 90)
484:             .BackStyle = 0
485:             .Visible   = .T.
486:         ENDWITH
487: 
488:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
489:         WITH loc_oPagina.txt_4c_Codigo
490:             .Value     = ""
491:             .Top       = 41
492:             .Left      = 146
493:             .Width     = 150
494:             .Height    = 23
495:             .MaxLength = 15

*-- Linhas 593 a 664:
593:             .FontSize  = 8
594:             .Visible   = .T.
595:         ENDWITH
596:         BINDEVENT(loc_oPagina.txt_4c_OpAnts, "KeyPress", THIS, "ValidarOpAnts")
597: 
598:         loc_oPagina.AddObject("lbl_4c_Label35", "Label")
599:         WITH loc_oPagina.lbl_4c_Label35
600:             .Caption   = "Movimento de T" + CHR(237) + "tulos :"
601:             .Top       = 70
602:             .Left      = 340
603:             .Width     = 110
604:             .Height    = 15
605:             .FontName  = "Tahoma"
606:             .FontSize  = 8
607:             .ForeColor = RGB(90, 90, 90)
608:             .BackStyle = 0
609:             .Visible   = .T.
610:         ENDWITH
611: 
612:         loc_oPagina.AddObject("txt_4c_OpContas", "TextBox")
613:         WITH loc_oPagina.txt_4c_OpContas
614:             .Value     = ""
615:             .Top       = 66
616:             .Left      = 454
617:             .Width     = 150
618:             .Height    = 23
619:             .MaxLength = 15
620:             .FontName  = "Tahoma"
621:             .FontSize  = 8
622:             .Visible   = .T.
623:         ENDWITH
624:         BINDEVENT(loc_oPagina.txt_4c_OpContas, "KeyPress", THIS, "ValidarOpContas")
625: 
626:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
627:         WITH loc_oPagina.lbl_4c_Label5
628:             .Caption   = "Ordem :"
629:             .Top       = 70
630:             .Left      = 667
631:             .Width     = 41
632:             .Height    = 17
633:             .FontName  = "Tahoma"
634:             .FontSize  = 8
635:             .ForeColor = RGB(90, 90, 90)
636:             .BackStyle = 0
637:             .Visible   = .T.
638:         ENDWITH
639: 
640:         loc_oPagina.AddObject("txt_4c_Ordem", "TextBox")
641:         WITH loc_oPagina.txt_4c_Ordem
642:             .Value     = 0
643:             .Top       = 66
644:             .Left      = 712
645:             .Width     = 50
646:             .Height    = 23
647:             .FontName  = "Tahoma"
648:             .FontSize  = 8
649:             .Visible   = .T.
650:         ENDWITH
651: 
652:         *-- Linha 3: Mov.Entrada / Mov.Automatico / Opc_TipoData (top orig=62-66; comp.=91-95)
653:         loc_oPagina.AddObject("lbl_4c_Label67", "Label")
654:         WITH loc_oPagina.lbl_4c_Label67
655:             .Caption   = "Movimento de Entrada :"
656:             .Top       = 95
657:             .Left      = 25
658:             .Width     = 117
659:             .Height    = 15
660:             .FontName  = "Tahoma"
661:             .FontSize  = 8
662:             .ForeColor = RGB(90, 90, 90)
663:             .BackStyle = 0
664:             .Visible   = .T.

*-- Linhas 676 a 750:
676:             .FontSize  = 8
677:             .Visible   = .T.
678:         ENDWITH
679:         BINDEVENT(loc_oPagina.txt_4c_OpEntrada, "KeyPress", THIS, "ValidarOpEntrada")
680: 
681:         loc_oPagina.AddObject("lbl_4c_Label6", "Label")
682:         WITH loc_oPagina.lbl_4c_Label6
683:             .Caption   = "Movimento Autom" + CHR(225) + "tico :"
684:             .Top       = 95
685:             .Left      = 332
686:             .Width     = 120
687:             .Height    = 17
688:             .FontName  = "Tahoma"
689:             .FontSize  = 8
690:             .ForeColor = RGB(90, 90, 90)
691:             .BackStyle = 0
692:             .Visible   = .T.
693:         ENDWITH
694: 
695:         loc_oPagina.AddObject("txt_4c_OpAut", "TextBox")
696:         WITH loc_oPagina.txt_4c_OpAut
697:             .Value     = ""
698:             .Top       = 91
699:             .Left      = 454
700:             .Width     = 18
701:             .Height    = 23
702:             .MaxLength = 1
703:             .FontName  = "Tahoma"
704:             .FontSize  = 8
705:             .Visible   = .T.
706:         ENDWITH
707:         BINDEVENT(loc_oPagina.txt_4c_OpAut, "InteractiveChange", THIS, "AtualizarEstadoTipoData")
708: 
709:         *-- OptionGroup: Opc_TipoData (4 botoes; top=62+29=91, left=471, w=340)
710:         loc_oPagina.AddObject("obj_4c_Opc_TipoData", "OptionGroup")
711:         WITH loc_oPagina.obj_4c_Opc_TipoData
712:             .ButtonCount = 4
713:             .Top         = 91
714:             .Left        = 471
715:             .Width       = 340
716:             .Height      = 22
717:             .BackStyle   = 0
718:             .BorderStyle = 0
719:             .Enabled     = .F.
720:             .Visible     = .T.
721:         ENDWITH
722:         WITH loc_oPagina.obj_4c_Opc_TipoData.Buttons(1)
723:             .Caption   = "Emiss" + CHR(227) + "o"
724:             .BackStyle = 0
725:             .Left      = 3
726:             .Top       = 2
727:             .Width     = 70
728:             .AutoSize  = .T.
729:             .FontName  = "Tahoma"
730:             .FontSize  = 8
731:             .ForeColor = RGB(90, 90, 90)
732:             .Themes    = .F.
733:         ENDWITH
734:         WITH loc_oPagina.obj_4c_Opc_TipoData.Buttons(2)
735:             .Caption   = "Vencimento"
736:             .BackStyle = 0
737:             .Left      = 80
738:             .Top       = 2
739:             .Width     = 75
740:             .AutoSize  = .T.
741:             .FontName  = "Tahoma"
742:             .FontSize  = 8
743:             .ForeColor = RGB(90, 90, 90)
744:             .Themes    = .F.
745:         ENDWITH
746:         WITH loc_oPagina.obj_4c_Opc_TipoData.Buttons(3)
747:             .Caption   = "Transa" + CHR(231) + CHR(227) + "o"
748:             .BackStyle = 0
749:             .Left      = 162
750:             .Top       = 2

*-- Linhas 795 a 868:
795:             .FontSize  = 8
796:             .Visible   = .T.
797:         ENDWITH
798:         BINDEVENT(loc_oPagina.txt_4c_Fpg, "KeyPress", THIS, "ValidarFpg")
799: 
800:         loc_oPagina.AddObject("lbl_4c_Label28", "Label")
801:         WITH loc_oPagina.lbl_4c_Label28
802:             .Caption   = "Hist" + CHR(243) + "rico Padr" + CHR(227) + "o :"
803:             .Top       = 120
804:             .Left      = 363
805:             .Width     = 85
806:             .Height    = 17
807:             .FontName  = "Tahoma"
808:             .FontSize  = 8
809:             .ForeColor = RGB(90, 90, 90)
810:             .BackStyle = 0
811:             .Visible   = .T.
812:         ENDWITH
813: 
814:         loc_oPagina.AddObject("txt_4c_Hists", "TextBox")
815:         WITH loc_oPagina.txt_4c_Hists
816:             .Value     = ""
817:             .Top       = 116
818:             .Left      = 454
819:             .Width     = 220
820:             .Height    = 23
821:             .MaxLength = 100
822:             .FontName  = "Tahoma"
823:             .FontSize  = 8
824:             .Visible   = .T.
825:         ENDWITH
826: 
827:         *-- OptionGroup: OpTpHists (2 botoes; top=86+29=115, left=670, w=145)
828:         loc_oPagina.AddObject("obj_4c_OpTpHists", "OptionGroup")
829:         WITH loc_oPagina.obj_4c_OpTpHists
830:             .ButtonCount = 2
831:             .Top         = 115
832:             .Left        = 670
833:             .Width       = 145
834:             .Height      = 25
835:             .BackStyle   = 0
836:             .BorderStyle = 0
837:             .Visible     = .T.
838:         ENDWITH
839:         WITH loc_oPagina.obj_4c_OpTpHists.Buttons(1)
840:             .Caption   = "Padr" + CHR(227) + "o"
841:             .BackStyle = 0
842:             .Left      = 5
843:             .Top       = 3
844:             .Width     = 60
845:             .AutoSize  = .T.
846:             .FontName  = "Tahoma"
847:             .FontSize  = 8
848:             .ForeColor = RGB(90, 90, 90)
849:             .Themes    = .F.
850:         ENDWITH
851:         WITH loc_oPagina.obj_4c_OpTpHists.Buttons(2)
852:             .Caption   = "Livre"
853:             .BackStyle = 0
854:             .Left      = 72
855:             .Top       = 3
856:             .Width     = 50
857:             .AutoSize  = .T.
858:             .FontName  = "Tahoma"
859:             .FontSize  = 8
860:             .ForeColor = RGB(90, 90, 90)
861:             .Themes    = .F.
862:         ENDWITH
863: 
864:         *-- Linha 5: Grupo Emissor / Tipo Emissor (top orig=112-116; comp.=141-145)
865:         loc_oPagina.AddObject("lbl_4c_Label49", "Label")
866:         WITH loc_oPagina.lbl_4c_Label49
867:             .Caption   = "Grupo Emissor Default :"
868:             .Top       = 145

*-- Linhas 888 a 948:
888:             .FontSize  = 8
889:             .Visible   = .T.
890:         ENDWITH
891:         BINDEVENT(loc_oPagina.txt_4c_Hispad, "KeyPress", THIS, "ValidarHispad")
892: 
893:         loc_oPagina.AddObject("lbl_4c_Label61", "Label")
894:         WITH loc_oPagina.lbl_4c_Label61
895:             .Caption   = "Tipo do Emissor :"
896:             .Top       = 145
897:             .Left      = 367
898:             .Width     = 83
899:             .Height    = 15
900:             .FontName  = "Tahoma"
901:             .FontSize  = 8
902:             .ForeColor = RGB(90, 90, 90)
903:             .BackStyle = 0
904:             .Visible   = .T.
905:         ENDWITH
906: 
907:         *-- OptionGroup: Opc_tpemissor (2 botoes; top=112+29=141, left=447, w=151)
908:         loc_oPagina.AddObject("obj_4c_Opc_tpemissor", "OptionGroup")
909:         WITH loc_oPagina.obj_4c_Opc_tpemissor
910:             .ButtonCount = 2
911:             .Top         = 141
912:             .Left        = 447
913:             .Width       = 151
914:             .Height      = 25
915:             .BackStyle   = 0
916:             .BorderStyle = 0
917:             .Visible     = .T.
918:         ENDWITH
919:         WITH loc_oPagina.obj_4c_Opc_tpemissor.Buttons(1)
920:             .Caption   = "Normal"
921:             .BackStyle = 0
922:             .Left      = 5
923:             .Top       = 3
924:             .Width     = 60
925:             .AutoSize  = .T.
926:             .FontName  = "Tahoma"
927:             .FontSize  = 8
928:             .ForeColor = RGB(90, 90, 90)
929:             .Themes    = .F.
930:         ENDWITH
931:         WITH loc_oPagina.obj_4c_Opc_tpemissor.Buttons(2)
932:             .Caption   = "Terceiro"
933:             .BackStyle = 0
934:             .Left      = 72
935:             .Top       = 3
936:             .Width     = 65
937:             .AutoSize  = .T.
938:             .FontName  = "Tahoma"
939:             .FontSize  = 8
940:             .ForeColor = RGB(90, 90, 90)
941:             .Themes    = .F.
942:         ENDWITH
943: 
944:         *-- Linha 6: Situacao / Responsavel / Central de Credito (top orig=137-141; comp.=166-170)
945:         loc_oPagina.AddObject("lbl_4c_Label60", "Label")
946:         WITH loc_oPagina.lbl_4c_Label60
947:             .Caption   = "Situa" + CHR(231) + CHR(227) + "o do Cliente :"
948:             .Top       = 170

*-- Linhas 968 a 1099:
968:             .FontSize  = 8
969:             .Visible   = .T.
970:         ENDWITH
971:         BINDEVENT(loc_oPagina.txt_4c_Situa, "KeyPress", THIS, "ValidarSituacao")
972: 
973:         loc_oPagina.AddObject("lbl_4c_Label47", "Label")
974:         WITH loc_oPagina.lbl_4c_Label47
975:             .Caption   = "Respons" + CHR(225) + "vel :"
976:             .Top       = 170
977:             .Left      = 380
978:             .Width     = 70
979:             .Height    = 17
980:             .FontName  = "Tahoma"
981:             .FontSize  = 8
982:             .ForeColor = RGB(90, 90, 90)
983:             .BackStyle = 0
984:             .Visible   = .T.
985:         ENDWITH
986: 
987:         loc_oPagina.AddObject("txt_4c_Respons", "TextBox")
988:         WITH loc_oPagina.txt_4c_Respons
989:             .Value     = ""
990:             .Top       = 166
991:             .Left      = 454
992:             .Width     = 80
993:             .Height    = 23
994:             .MaxLength = 10
995:             .FontName  = "Tahoma"
996:             .FontSize  = 8
997:             .Visible   = .T.
998:         ENDWITH
999:         BINDEVENT(loc_oPagina.txt_4c_Respons, "KeyPress", THIS, "ValidarResponsavel")
1000: 
1001:         loc_oPagina.AddObject("lbl_4c_Label21", "Label")
1002:         WITH loc_oPagina.lbl_4c_Label21
1003:             .Caption   = "Central de Cr" + CHR(233) + "dito :"
1004:             .Top       = 170
1005:             .Left      = 611
1006:             .Width     = 97
1007:             .Height    = 15
1008:             .FontName  = "Tahoma"
1009:             .FontSize  = 8
1010:             .ForeColor = RGB(90, 90, 90)
1011:             .BackStyle = 0
1012:             .Visible   = .T.
1013:         ENDWITH
1014: 
1015:         loc_oPagina.AddObject("txt_4c_Central", "TextBox")
1016:         WITH loc_oPagina.txt_4c_Central
1017:             .Value     = ""
1018:             .Top       = 166
1019:             .Left      = 712
1020:             .Width     = 24
1021:             .Height    = 23
1022:             .MaxLength = 15
1023:             .FontName  = "Tahoma"
1024:             .FontSize  = 8
1025:             .Visible   = .T.
1026:         ENDWITH
1027:         BINDEVENT(loc_oPagina.txt_4c_Central, "KeyPress", THIS, "ValidarCentral")
1028: 
1029:         loc_oPagina.AddObject("txt_4c_DCentral", "TextBox")
1030:         WITH loc_oPagina.txt_4c_DCentral
1031:             .Value     = ""
1032:             .Top       = 166
1033:             .Left      = 738
1034:             .Width     = 194
1035:             .Height    = 23
1036:             .MaxLength = 60
1037:             .FontName  = "Tahoma"
1038:             .FontSize  = 8
1039:             .Visible   = .T.
1040:         ENDWITH
1041:         BINDEVENT(loc_oPagina.txt_4c_DCentral, "KeyPress", THIS, "ValidarDescCentral")
1042: 
1043:         *-- Linha separadora Line1 (original top=166; comp.=195)
1044:         loc_oPagina.AddObject("lin_4c_Line1", "Shape")
1045:         WITH loc_oPagina.lin_4c_Line1
1046:             .Top         = 195
1047:             .Left        = 7
1048:             .Width       = 984
1049:             .Height      = 2
1050:             .BackColor   = RGB(180, 180, 180)
1051:             .BackStyle   = 1
1052:             .BorderStyle = 0
1053:             .Curvature   = 0
1054:             .Visible     = .T.
1055:         ENDWITH
1056: 
1057:         *-- Secao Origem/Destino (original top=168-173; comp.=197-202)
1058:         *-- OptionGroup: op_origem (2 botoes; top=168+29=197, left=140, w=95)
1059:         loc_oPagina.AddObject("obj_4c_Op_origem", "OptionGroup")
1060:         WITH loc_oPagina.obj_4c_Op_origem
1061:             .ButtonCount = 2
1062:             .Top         = 197
1063:             .Left        = 140
1064:             .Width       = 95
1065:             .Height      = 25
1066:             .BackStyle   = 0
1067:             .BorderStyle = 0
1068:             .Visible     = .T.
1069:         ENDWITH
1070:         WITH loc_oPagina.obj_4c_Op_origem.Buttons(1)
1071:             .Caption   = "CR"
1072:             .BackStyle = 0
1073:             .Left      = 5
1074:             .Top       = 3
1075:             .Width     = 35
1076:             .AutoSize  = .T.
1077:             .FontName  = "Tahoma"
1078:             .FontSize  = 8
1079:             .ForeColor = RGB(90, 90, 90)
1080:             .Themes    = .F.
1081:         ENDWITH
1082:         WITH loc_oPagina.obj_4c_Op_origem.Buttons(2)
1083:             .Caption   = "DB"
1084:             .BackStyle = 0
1085:             .Left      = 48
1086:             .Top       = 3
1087:             .Width     = 35
1088:             .AutoSize  = .T.
1089:             .FontName  = "Tahoma"
1090:             .FontSize  = 8
1091:             .ForeColor = RGB(90, 90, 90)
1092:             .Themes    = .F.
1093:         ENDWITH
1094: 
1095:         loc_oPagina.AddObject("lbl_4c_Label43", "Label")
1096:         WITH loc_oPagina.lbl_4c_Label43
1097:             .Caption   = "Origem :"
1098:             .Top       = 202
1099:             .Left      = 99

*-- Linhas 1106 a 1150:
1106:             .Visible   = .T.
1107:         ENDWITH
1108: 
1109:         *-- OptionGroup: op_destino (3 botoes; top=168+29=197, left=619, w=169)
1110:         loc_oPagina.AddObject("obj_4c_Op_destino", "OptionGroup")
1111:         WITH loc_oPagina.obj_4c_Op_destino
1112:             .ButtonCount = 3
1113:             .Top         = 197
1114:             .Left        = 619
1115:             .Width       = 169
1116:             .Height      = 27
1117:             .BackStyle   = 0
1118:             .BorderStyle = 0
1119:             .Visible     = .T.
1120:         ENDWITH
1121:         WITH loc_oPagina.obj_4c_Op_destino.Buttons(1)
1122:             .Caption   = "Nenhum"
1123:             .BackStyle = 0
1124:             .Left      = 5
1125:             .Top       = 3
1126:             .Width     = 55
1127:             .AutoSize  = .T.
1128:             .FontName  = "Tahoma"
1129:             .FontSize  = 8
1130:             .ForeColor = RGB(90, 90, 90)
1131:             .Themes    = .F.
1132:         ENDWITH
1133:         WITH loc_oPagina.obj_4c_Op_destino.Buttons(2)
1134:             .Caption   = "CR"
1135:             .BackStyle = 0
1136:             .Left      = 68
1137:             .Top       = 3
1138:             .Width     = 35
1139:             .AutoSize  = .T.
1140:             .FontName  = "Tahoma"
1141:             .FontSize  = 8
1142:             .ForeColor = RGB(90, 90, 90)
1143:             .Themes    = .F.
1144:         ENDWITH
1145:         WITH loc_oPagina.obj_4c_Op_destino.Buttons(3)
1146:             .Caption   = "DB"
1147:             .BackStyle = 0
1148:             .Left      = 110
1149:             .Top       = 3
1150:             .Width     = 35

*-- Linhas 1196 a 1382:
1196:             .FontSize  = 8
1197:             .Visible   = .T.
1198:         ENDWITH
1199:         BINDEVENT(loc_oPagina.txt_4c_GrupoOs, "KeyPress", THIS, "ValidarGrupoOrig")
1200: 
1201:         loc_oPagina.AddObject("txt_4c_DGrupoOs", "TextBox")
1202:         WITH loc_oPagina.txt_4c_DGrupoOs
1203:             .Value     = ""
1204:             .Top       = 221
1205:             .Left      = 227
1206:             .Width     = 290
1207:             .Height    = 23
1208:             .MaxLength = 60
1209:             .FontName  = "Tahoma"
1210:             .FontSize  = 8
1211:             .Visible   = .T.
1212:         ENDWITH
1213:         BINDEVENT(loc_oPagina.txt_4c_DGrupoOs, "KeyPress", THIS, "ValidarDescGrupoOrig")
1214: 
1215:         *-- Grupo/Destino (top orig=193-197; comp.=222-226)
1216:         loc_oPagina.AddObject("lbl_4c_Label9", "Label")
1217:         WITH loc_oPagina.lbl_4c_Label9
1218:             .Caption   = "Grupo/Destino :"
1219:             .Top       = 226
1220:             .Left      = 541
1221:             .Width     = 78
1222:             .Height    = 17
1223:             .FontName  = "Tahoma"
1224:             .FontSize  = 8
1225:             .ForeColor = RGB(90, 90, 90)
1226:             .BackStyle = 0
1227:             .Visible   = .T.
1228:         ENDWITH
1229: 
1230:         loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
1231:         WITH loc_oPagina.txt_4c_Grupo
1232:             .Value     = ""
1233:             .Top       = 222
1234:             .Left      = 621
1235:             .Width     = 79
1236:             .Height    = 23
1237:             .MaxLength = 10
1238:             .FontName  = "Tahoma"
1239:             .FontSize  = 8
1240:             .Visible   = .T.
1241:         ENDWITH
1242:         BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress", THIS, "ValidarGrupoDest")
1243: 
1244:         loc_oPagina.AddObject("txt_4c__ds_grupo", "TextBox")
1245:         WITH loc_oPagina.txt_4c__ds_grupo
1246:             .Value     = ""
1247:             .Top       = 222
1248:             .Left      = 701
1249:             .Width     = 290
1250:             .Height    = 23
1251:             .MaxLength = 60
1252:             .FontName  = "Tahoma"
1253:             .FontSize  = 8
1254:             .Visible   = .T.
1255:         ENDWITH
1256:         BINDEVENT(loc_oPagina.txt_4c__ds_grupo, "KeyPress", THIS, "ValidarDescGrupoDest")
1257: 
1258:         *-- ContaOs/DContaOs - Origem (top orig=217-220; comp.=246-249)
1259:         loc_oPagina.AddObject("lbl_4c_Label42", "Label")
1260:         WITH loc_oPagina.lbl_4c_Label42
1261:             .Caption   = "Conta/Origem :"
1262:             .Top       = 249
1263:             .Left      = 66
1264:             .Width     = 72
1265:             .Height    = 17
1266:             .FontName  = "Tahoma"
1267:             .FontSize  = 8
1268:             .ForeColor = RGB(90, 90, 90)
1269:             .BackStyle = 0
1270:             .Visible   = .T.
1271:         ENDWITH
1272: 
1273:         loc_oPagina.AddObject("txt_4c_ContaOs", "TextBox")
1274:         WITH loc_oPagina.txt_4c_ContaOs
1275:             .Value     = ""
1276:             .Top       = 246
1277:             .Left      = 146
1278:             .Width     = 79
1279:             .Height    = 23
1280:             .MaxLength = 15
1281:             .FontName  = "Tahoma"
1282:             .FontSize  = 8
1283:             .Visible   = .T.
1284:         ENDWITH
1285:         BINDEVENT(loc_oPagina.txt_4c_ContaOs, "KeyPress", THIS, "ValidarContaOrig")
1286: 
1287:         loc_oPagina.AddObject("txt_4c_DContaOs", "TextBox")
1288:         WITH loc_oPagina.txt_4c_DContaOs
1289:             .Value     = ""
1290:             .Top       = 246
1291:             .Left      = 227
1292:             .Width     = 290
1293:             .Height    = 23
1294:             .MaxLength = 60
1295:             .FontName  = "Tahoma"
1296:             .FontSize  = 8
1297:             .Visible   = .T.
1298:         ENDWITH
1299:         BINDEVENT(loc_oPagina.txt_4c_DContaOs, "KeyPress", THIS, "ValidarDescContaOrig")
1300: 
1301:         *-- Conta/Destino (top orig=218-222; comp.=247-251)
1302:         loc_oPagina.AddObject("lbl_4c_Label10", "Label")
1303:         WITH loc_oPagina.lbl_4c_Label10
1304:             .Caption   = "Conta/Destino :"
1305:             .Top       = 251
1306:             .Left      = 541
1307:             .Width     = 78
1308:             .Height    = 17
1309:             .FontName  = "Tahoma"
1310:             .FontSize  = 8
1311:             .ForeColor = RGB(90, 90, 90)
1312:             .BackStyle = 0
1313:             .Visible   = .T.
1314:         ENDWITH
1315: 
1316:         loc_oPagina.AddObject("txt_4c_Conta", "TextBox")
1317:         WITH loc_oPagina.txt_4c_Conta
1318:             .Value     = ""
1319:             .Top       = 247
1320:             .Left      = 621
1321:             .Width     = 79
1322:             .Height    = 23
1323:             .MaxLength = 15
1324:             .FontName  = "Tahoma"
1325:             .FontSize  = 8
1326:             .Visible   = .T.
1327:         ENDWITH
1328:         BINDEVENT(loc_oPagina.txt_4c_Conta, "KeyPress", THIS, "ValidarContaDest")
1329: 
1330:         loc_oPagina.AddObject("txt_4c_DConta", "TextBox")
1331:         WITH loc_oPagina.txt_4c_DConta
1332:             .Value     = ""
1333:             .Top       = 247
1334:             .Left      = 701
1335:             .Width     = 290
1336:             .Height    = 23
1337:             .MaxLength = 60
1338:             .FontName  = "Tahoma"
1339:             .FontSize  = 8
1340:             .Visible   = .T.
1341:         ENDWITH
1342:         BINDEVENT(loc_oPagina.txt_4c_DConta, "KeyPress", THIS, "ValidarDescContaDest")
1343: 
1344:         *-- Linha separadora Line2 (original top=248; comp.=277)
1345:         loc_oPagina.AddObject("lin_4c_Line2", "Shape")
1346:         WITH loc_oPagina.lin_4c_Line2
1347:             .Top         = 277
1348:             .Left        = 7
1349:             .Width       = 984
1350:             .Height      = 2
1351:             .BackColor   = RGB(180, 180, 180)
1352:             .BackStyle   = 1
1353:             .BorderStyle = 0
1354:             .Curvature   = 0
1355:             .Visible     = .T.
1356:         ENDWITH
1357: 
1358:         *-- ===================================================================
1359:         *-- SECAO 2: Controles abaixo da linha divisoria (original top > 248)
1360:         *-- Todos os tops: legado + 29
1361:         *-- ===================================================================
1362: 
1363:         *-- Coluna esquerda (left~194): flags S/N financeiros
1364:         loc_oPagina.AddObject("lbl_4c_LblValPend", "Label")
1365:         WITH loc_oPagina.lbl_4c_LblValPend
1366:             .Caption   = "Valor Pendente (Emissor) :"
1367:             .Top       = 288
1368:             .Left      = 63
1369:             .Width     = 129
1370:             .Height    = 15
1371:             .FontName  = "Tahoma"
1372:             .FontSize  = 8
1373:             .ForeColor = RGB(90, 90, 90)
1374:             .BackStyle = 0
1375:             .Visible   = .T.
1376:         ENDWITH
1377: 
1378:         loc_oPagina.AddObject("txt_4c_ValPend", "TextBox")
1379:         WITH loc_oPagina.txt_4c_ValPend
1380:             .Value     = ""
1381:             .Top       = 284
1382:             .Left      = 194

*-- Linhas 1689 a 1931:
1689:             .Visible   = .T.
1690:         ENDWITH
1691: 
1692:         *-- OptionGroups coluna esquerda-baixo (left=190)
1693:         loc_oPagina.AddObject("lbl_4c_LblLeProts", "Label")
1694:         WITH loc_oPagina.lbl_4c_LblLeProts
1695:             .Caption   = "Leitura Cheque pelo Protocolo :"
1696:             .Top       = 488
1697:             .Left      = 39
1698:             .Width     = 153
1699:             .Height    = 15
1700:             .FontName  = "Tahoma"
1701:             .FontSize  = 8
1702:             .ForeColor = RGB(90, 90, 90)
1703:             .BackStyle = 0
1704:             .Visible   = .T.
1705:         ENDWITH
1706: 
1707:         loc_oPagina.AddObject("obj_4c_Opt_LeProts", "OptionGroup")
1708:         WITH loc_oPagina.obj_4c_Opt_LeProts
1709:             .ButtonCount = 2
1710:             .Top         = 484
1711:             .Left        = 190
1712:             .Width       = 127
1713:             .Height      = 25
1714:             .BackStyle   = 0
1715:             .BorderStyle = 0
1716:             .Visible     = .T.
1717:         ENDWITH
1718:         WITH loc_oPagina.obj_4c_Opt_LeProts.Buttons(1)
1719:             .Caption   = "Sim"
1720:             .Top       = 5
1721:             .Left      = 5
1722:             .AutoSize  = .T.
1723:             .BackStyle = 0
1724:             .FontName  = "Tahoma"
1725:             .FontSize  = 8
1726:             .ForeColor = RGB(90, 90, 90)
1727:         ENDWITH
1728:         WITH loc_oPagina.obj_4c_Opt_LeProts.Buttons(2)
1729:             .Caption   = "N" + CHR(227) + "o"
1730:             .Top       = 5
1731:             .Left      = 85
1732:             .AutoSize  = .T.
1733:             .BackStyle = 0
1734:             .FontName  = "Tahoma"
1735:             .FontSize  = 8
1736:             .ForeColor = RGB(90, 90, 90)
1737:         ENDWITH
1738: 
1739:         loc_oPagina.AddObject("lbl_4c_LblTpLeit", "Label")
1740:         WITH loc_oPagina.lbl_4c_LblTpLeit
1741:             .Caption   = "Tipo de Leitura de Cheque :"
1742:             .Top       = 514
1743:             .Left      = 57
1744:             .Width     = 135
1745:             .Height    = 15
1746:             .FontName  = "Tahoma"
1747:             .FontSize  = 8
1748:             .ForeColor = RGB(90, 90, 90)
1749:             .BackStyle = 0
1750:             .Visible   = .T.
1751:         ENDWITH
1752: 
1753:         loc_oPagina.AddObject("obj_4c_OptTpLeit", "OptionGroup")
1754:         WITH loc_oPagina.obj_4c_OptTpLeit
1755:             .ButtonCount = 2
1756:             .Top         = 510
1757:             .Left        = 190
1758:             .Width       = 136
1759:             .Height      = 25
1760:             .BackStyle   = 0
1761:             .BorderStyle = 0
1762:             .Visible     = .T.
1763:         ENDWITH
1764:         WITH loc_oPagina.obj_4c_OptTpLeit.Buttons(1)
1765:             .Caption   = "Digita" + CHR(231) + CHR(227) + "o"
1766:             .Top       = 5
1767:             .Left      = 5
1768:             .AutoSize  = .T.
1769:             .BackStyle = 0
1770:             .FontName  = "Tahoma"
1771:             .FontSize  = 8
1772:             .ForeColor = RGB(90, 90, 90)
1773:         ENDWITH
1774:         WITH loc_oPagina.obj_4c_OptTpLeit.Buttons(2)
1775:             .Caption   = "CMC7"
1776:             .Top       = 5
1777:             .Left      = 85
1778:             .AutoSize  = .T.
1779:             .BackStyle = 0
1780:             .FontName  = "Tahoma"
1781:             .FontSize  = 8
1782:             .ForeColor = RGB(90, 90, 90)
1783:         ENDWITH
1784: 
1785:         loc_oPagina.AddObject("lbl_4c_LblGerarq", "Label")
1786:         WITH loc_oPagina.lbl_4c_LblGerarq
1787:             .Caption   = "Gera n" + CHR(186) + " Arquivo :"
1788:             .Top       = 539
1789:             .Left      = 106
1790:             .Width     = 86
1791:             .Height    = 15
1792:             .FontName  = "Tahoma"
1793:             .FontSize  = 8
1794:             .ForeColor = RGB(90, 90, 90)
1795:             .BackStyle = 0
1796:             .Visible   = .T.
1797:         ENDWITH
1798: 
1799:         loc_oPagina.AddObject("obj_4c_Opc_Gerarq", "OptionGroup")
1800:         WITH loc_oPagina.obj_4c_Opc_Gerarq
1801:             .ButtonCount = 2
1802:             .Top         = 535
1803:             .Left        = 190
1804:             .Width       = 127
1805:             .Height      = 25
1806:             .BackStyle   = 0
1807:             .BorderStyle = 0
1808:             .Visible     = .T.
1809:         ENDWITH
1810:         WITH loc_oPagina.obj_4c_Opc_Gerarq.Buttons(1)
1811:             .Caption   = "Sim"
1812:             .Top       = 5
1813:             .Left      = 5
1814:             .AutoSize  = .T.
1815:             .BackStyle = 0
1816:             .FontName  = "Tahoma"
1817:             .FontSize  = 8
1818:             .ForeColor = RGB(90, 90, 90)
1819:         ENDWITH
1820:         WITH loc_oPagina.obj_4c_Opc_Gerarq.Buttons(2)
1821:             .Caption   = "N" + CHR(227) + "o"
1822:             .Top       = 5
1823:             .Left      = 85
1824:             .AutoSize  = .T.
1825:             .BackStyle = 0
1826:             .FontName  = "Tahoma"
1827:             .FontSize  = 8
1828:             .ForeColor = RGB(90, 90, 90)
1829:         ENDWITH
1830: 
1831:         loc_oPagina.AddObject("lbl_4c_LblAnaSit", "Label")
1832:         WITH loc_oPagina.lbl_4c_LblAnaSit
1833:             .Caption   = "Cons. Global de Situa" + CHR(231) + CHR(227) + "o :"
1834:             .Top       = 565
1835:             .Left      = 64
1836:             .Width     = 128
1837:             .Height    = 15
1838:             .FontName  = "Tahoma"
1839:             .FontSize  = 8
1840:             .ForeColor = RGB(90, 90, 90)
1841:             .BackStyle = 0
1842:             .Visible   = .T.
1843:         ENDWITH
1844: 
1845:         loc_oPagina.AddObject("obj_4c_Opc_gensit", "OptionGroup")
1846:         WITH loc_oPagina.obj_4c_Opc_gensit
1847:             .ButtonCount = 2
1848:             .Top         = 561
1849:             .Left        = 190
1850:             .Width       = 127
1851:             .Height      = 25
1852:             .BackStyle   = 0
1853:             .BorderStyle = 0
1854:             .Visible     = .T.
1855:         ENDWITH
1856:         WITH loc_oPagina.obj_4c_Opc_gensit.Buttons(1)
1857:             .Caption   = "Sim"
1858:             .Top       = 5
1859:             .Left      = 5
1860:             .AutoSize  = .T.
1861:             .BackStyle = 0
1862:             .FontName  = "Tahoma"
1863:             .FontSize  = 8
1864:             .ForeColor = RGB(90, 90, 90)
1865:         ENDWITH
1866:         WITH loc_oPagina.obj_4c_Opc_gensit.Buttons(2)
1867:             .Caption   = "N" + CHR(227) + "o"
1868:             .Top       = 5
1869:             .Left      = 85
1870:             .AutoSize  = .T.
1871:             .BackStyle = 0
1872:             .FontName  = "Tahoma"
1873:             .FontSize  = 8
1874:             .ForeColor = RGB(90, 90, 90)
1875:         ENDWITH
1876: 
1877:         loc_oPagina.AddObject("lbl_4c_LblAltDados", "Label")
1878:         WITH loc_oPagina.lbl_4c_LblAltDados
1879:             .Caption   = "Altera Dados :"
1880:             .Top       = 590
1881:             .Left      = 121
1882:             .Width     = 71
1883:             .Height    = 15
1884:             .FontName  = "Tahoma"
1885:             .FontSize  = 8
1886:             .ForeColor = RGB(90, 90, 90)
1887:             .BackStyle = 0
1888:             .Visible   = .T.
1889:         ENDWITH
1890: 
1891:         loc_oPagina.AddObject("obj_4c_AltDados", "OptionGroup")
1892:         WITH loc_oPagina.obj_4c_AltDados
1893:             .ButtonCount = 2
1894:             .Top         = 586
1895:             .Left        = 190
1896:             .Width       = 127
1897:             .Height      = 25
1898:             .BackStyle   = 0
1899:             .BorderStyle = 0
1900:             .Visible     = .T.
1901:         ENDWITH
1902:         WITH loc_oPagina.obj_4c_AltDados.Buttons(1)
1903:             .Caption   = "Sim"
1904:             .Top       = 5
1905:             .Left      = 5
1906:             .AutoSize  = .T.
1907:             .BackStyle = 0
1908:             .FontName  = "Tahoma"
1909:             .FontSize  = 8
1910:             .ForeColor = RGB(90, 90, 90)
1911:         ENDWITH
1912:         WITH loc_oPagina.obj_4c_AltDados.Buttons(2)
1913:             .Caption   = "N" + CHR(227) + "o"
1914:             .Top       = 5
1915:             .Left      = 85
1916:             .AutoSize  = .T.
1917:             .BackStyle = 0
1918:             .FontName  = "Tahoma"
1919:             .FontSize  = 8
1920:             .ForeColor = RGB(90, 90, 90)
1921:         ENDWITH
1922: 
1923:         *-- Coluna central (left~512): flags S/N emissao
1924:         loc_oPagina.AddObject("lbl_4c_LblEmiInd", "Label")
1925:         WITH loc_oPagina.lbl_4c_LblEmiInd
1926:             .Caption   = "Emissor Individual :"
1927:             .Top       = 288
1928:             .Left      = 415
1929:             .Width     = 93
1930:             .Height    = 15
1931:             .FontName  = "Tahoma"

*-- Linhas 2290 a 2487:
2290:             .Visible   = .T.
2291:         ENDWITH
2292: 
2293:         *-- OptionGroups coluna central-baixo (left=506)
2294:         loc_oPagina.AddObject("lbl_4c_LblProrroga", "Label")
2295:         WITH loc_oPagina.lbl_4c_LblProrroga
2296:             .Caption   = "Prorrogar Tipo (CR) :"
2297:             .Top       = 514
2298:             .Left      = 406
2299:             .Width     = 103
2300:             .Height    = 15
2301:             .FontName  = "Tahoma"
2302:             .FontSize  = 8
2303:             .ForeColor = RGB(90, 90, 90)
2304:             .BackStyle = 0
2305:             .Visible   = .T.
2306:         ENDWITH
2307: 
2308:         loc_oPagina.AddObject("obj_4c_Prorroga", "OptionGroup")
2309:         WITH loc_oPagina.obj_4c_Prorroga
2310:             .ButtonCount = 2
2311:             .Top         = 510
2312:             .Left        = 506
2313:             .Width       = 127
2314:             .Height      = 25
2315:             .BackStyle   = 0
2316:             .BorderStyle = 0
2317:             .Visible     = .T.
2318:         ENDWITH
2319:         WITH loc_oPagina.obj_4c_Prorroga.Buttons(1)
2320:             .Caption   = "Sim"
2321:             .Top       = 5
2322:             .Left      = 5
2323:             .AutoSize  = .T.
2324:             .BackStyle = 0
2325:             .FontName  = "Tahoma"
2326:             .FontSize  = 8
2327:             .ForeColor = RGB(90, 90, 90)
2328:         ENDWITH
2329:         WITH loc_oPagina.obj_4c_Prorroga.Buttons(2)
2330:             .Caption   = "N" + CHR(227) + "o"
2331:             .Top       = 5
2332:             .Left      = 85
2333:             .AutoSize  = .T.
2334:             .BackStyle = 0
2335:             .FontName  = "Tahoma"
2336:             .FontSize  = 8
2337:             .ForeColor = RGB(90, 90, 90)
2338:         ENDWITH
2339: 
2340:         loc_oPagina.AddObject("lbl_4c_LblCarteira", "Label")
2341:         WITH loc_oPagina.lbl_4c_LblCarteira
2342:             .Caption   = "Permitir Carteira Tipo (CR) :"
2343:             .Top       = 539
2344:             .Left      = 374
2345:             .Width     = 135
2346:             .Height    = 15
2347:             .FontName  = "Tahoma"
2348:             .FontSize  = 8
2349:             .ForeColor = RGB(90, 90, 90)
2350:             .BackStyle = 0
2351:             .Visible   = .T.
2352:         ENDWITH
2353: 
2354:         loc_oPagina.AddObject("obj_4c_Carteira", "OptionGroup")
2355:         WITH loc_oPagina.obj_4c_Carteira
2356:             .ButtonCount = 2
2357:             .Top         = 535
2358:             .Left        = 506
2359:             .Width       = 127
2360:             .Height      = 25
2361:             .BackStyle   = 0
2362:             .BorderStyle = 0
2363:             .Visible     = .T.
2364:         ENDWITH
2365:         WITH loc_oPagina.obj_4c_Carteira.Buttons(1)
2366:             .Caption   = "Sim"
2367:             .Top       = 5
2368:             .Left      = 5
2369:             .AutoSize  = .T.
2370:             .BackStyle = 0
2371:             .FontName  = "Tahoma"
2372:             .FontSize  = 8
2373:             .ForeColor = RGB(90, 90, 90)
2374:         ENDWITH
2375:         WITH loc_oPagina.obj_4c_Carteira.Buttons(2)
2376:             .Caption   = "N" + CHR(227) + "o"
2377:             .Top       = 5
2378:             .Left      = 85
2379:             .AutoSize  = .T.
2380:             .BackStyle = 0
2381:             .FontName  = "Tahoma"
2382:             .FontSize  = 8
2383:             .ForeColor = RGB(90, 90, 90)
2384:         ENDWITH
2385: 
2386:         loc_oPagina.AddObject("lbl_4c_LblVencUtil", "Label")
2387:         WITH loc_oPagina.lbl_4c_LblVencUtil
2388:             .Caption   = "Vencimento dia " + CHR(250) + "til :"
2389:             .Top       = 561
2390:             .Left      = 411
2391:             .Width     = 98
2392:             .Height    = 15
2393:             .FontName  = "Tahoma"
2394:             .FontSize  = 8
2395:             .ForeColor = RGB(90, 90, 90)
2396:             .BackStyle = 0
2397:             .Visible   = .T.
2398:         ENDWITH
2399: 
2400:         loc_oPagina.AddObject("obj_4c_VencUtil", "OptionGroup")
2401:         WITH loc_oPagina.obj_4c_VencUtil
2402:             .ButtonCount = 2
2403:             .Top         = 557
2404:             .Left        = 506
2405:             .Width       = 127
2406:             .Height      = 25
2407:             .BackStyle   = 0
2408:             .BorderStyle = 0
2409:             .Visible     = .T.
2410:         ENDWITH
2411:         WITH loc_oPagina.obj_4c_VencUtil.Buttons(1)
2412:             .Caption   = "Sim"
2413:             .Top       = 5
2414:             .Left      = 5
2415:             .AutoSize  = .T.
2416:             .BackStyle = 0
2417:             .FontName  = "Tahoma"
2418:             .FontSize  = 8
2419:             .ForeColor = RGB(90, 90, 90)
2420:         ENDWITH
2421:         WITH loc_oPagina.obj_4c_VencUtil.Buttons(2)
2422:             .Caption   = "N" + CHR(227) + "o"
2423:             .Top       = 5
2424:             .Left      = 85
2425:             .AutoSize  = .T.
2426:             .BackStyle = 0
2427:             .FontName  = "Tahoma"
2428:             .FontSize  = 8
2429:             .ForeColor = RGB(90, 90, 90)
2430:         ENDWITH
2431: 
2432:         *-- Area direita (left=764): Data emissao, Pend.Fin., Comissao, Moeda
2433:         loc_oPagina.AddObject("lbl_4c_LblDtEmiss", "Label")
2434:         WITH loc_oPagina.lbl_4c_LblDtEmiss
2435:             .Caption   = "Data de Emiss" + CHR(227) + "o Padr" + CHR(227) + "o :"
2436:             .Top       = 286
2437:             .Left      = 641
2438:             .Width     = 125
2439:             .Height    = 15
2440:             .FontName  = "Tahoma"
2441:             .FontSize  = 8
2442:             .ForeColor = RGB(90, 90, 90)
2443:             .BackStyle = 0
2444:             .Visible   = .T.
2445:         ENDWITH
2446: 
2447:         loc_oPagina.AddObject("obj_4c_Opt_DtEmiss", "OptionGroup")
2448:         WITH loc_oPagina.obj_4c_Opt_DtEmiss
2449:             .ButtonCount = 3
2450:             .Top         = 281
2451:             .Left        = 764
2452:             .Width       = 124
2453:             .Height      = 66
2454:             .BackStyle   = 0
2455:             .BorderStyle = 0
2456:             .Visible     = .T.
2457:         ENDWITH
2458:         WITH loc_oPagina.obj_4c_Opt_DtEmiss.Buttons(1)
2459:             .Caption   = "Data de Entrada"
2460:             .Top       = 5
2461:             .Left      = 5
2462:             .AutoSize  = .T.
2463:             .BackStyle = 0
2464:             .FontName  = "Tahoma"
2465:             .FontSize  = 8
2466:             .ForeColor = RGB(90, 90, 90)
2467:         ENDWITH
2468:         WITH loc_oPagina.obj_4c_Opt_DtEmiss.Buttons(2)
2469:             .Caption   = "Data de Vencimento"
2470:             .Top       = 25
2471:             .Left      = 5
2472:             .AutoSize  = .T.
2473:             .BackStyle = 0
2474:             .FontName  = "Tahoma"
2475:             .FontSize  = 8
2476:             .ForeColor = RGB(90, 90, 90)
2477:         ENDWITH
2478:         WITH loc_oPagina.obj_4c_Opt_DtEmiss.Buttons(3)
2479:             .Caption   = "Nenhum"
2480:             .Top       = 44
2481:             .Left      = 5
2482:             .AutoSize  = .F.
2483:             .Width     = 66
2484:             .Height    = 17
2485:             .BackStyle = 0
2486:             .FontName  = "Tahoma"
2487:             .FontSize  = 8

*-- Linhas 2502 a 2545:
2502:             .Visible   = .T.
2503:         ENDWITH
2504: 
2505:         loc_oPagina.AddObject("obj_4c_Opc_penfin", "OptionGroup")
2506:         WITH loc_oPagina.obj_4c_Opc_penfin
2507:             .ButtonCount = 3
2508:             .Top         = 348
2509:             .Left        = 764
2510:             .Width       = 218
2511:             .Height      = 25
2512:             .BackStyle   = 0
2513:             .BorderStyle = 0
2514:             .Visible     = .T.
2515:         ENDWITH
2516:         WITH loc_oPagina.obj_4c_Opc_penfin.Buttons(1)
2517:             .Caption   = "Incluir"
2518:             .Top       = 5
2519:             .Left      = 5
2520:             .AutoSize  = .T.
2521:             .BackStyle = 0
2522:             .FontName  = "Tahoma"
2523:             .FontSize  = 8
2524:             .ForeColor = RGB(90, 90, 90)
2525:         ENDWITH
2526:         WITH loc_oPagina.obj_4c_Opc_penfin.Buttons(2)
2527:             .Caption   = "Excluir"
2528:             .Top       = 5
2529:             .Left      = 74
2530:             .AutoSize  = .T.
2531:             .BackStyle = 0
2532:             .FontName  = "Tahoma"
2533:             .FontSize  = 8
2534:             .ForeColor = RGB(90, 90, 90)
2535:         ENDWITH
2536:         WITH loc_oPagina.obj_4c_Opc_penfin.Buttons(3)
2537:             .Caption   = "Nenhuma"
2538:             .Top       = 5
2539:             .Left      = 150
2540:             .AutoSize  = .T.
2541:             .BackStyle = 0
2542:             .FontName  = "Tahoma"
2543:             .FontSize  = 8
2544:             .ForeColor = RGB(90, 90, 90)
2545:         ENDWITH

*-- Linhas 2558 a 2601:
2558:             .Visible   = .T.
2559:         ENDWITH
2560: 
2561:         loc_oPagina.AddObject("obj_4c_OpComiss", "OptionGroup")
2562:         WITH loc_oPagina.obj_4c_OpComiss
2563:             .ButtonCount = 3
2564:             .Top         = 373
2565:             .Left        = 764
2566:             .Width       = 219
2567:             .Height      = 25
2568:             .BackStyle   = 0
2569:             .BorderStyle = 0
2570:             .Visible     = .T.
2571:         ENDWITH
2572:         WITH loc_oPagina.obj_4c_OpComiss.Buttons(1)
2573:             .Caption   = "Nenhum"
2574:             .Top       = 5
2575:             .Left      = 5
2576:             .AutoSize  = .T.
2577:             .BackStyle = 0
2578:             .FontName  = "Tahoma"
2579:             .FontSize  = 8
2580:             .ForeColor = RGB(90, 90, 90)
2581:         ENDWITH
2582:         WITH loc_oPagina.obj_4c_OpComiss.Buttons(2)
2583:             .Caption   = "Desconta"
2584:             .Top       = 5
2585:             .Left      = 74
2586:             .AutoSize  = .T.
2587:             .BackStyle = 0
2588:             .FontName  = "Tahoma"
2589:             .FontSize  = 8
2590:             .ForeColor = RGB(90, 90, 90)
2591:         ENDWITH
2592:         WITH loc_oPagina.obj_4c_OpComiss.Buttons(3)
2593:             .Caption   = "Recupera"
2594:             .Top       = 5
2595:             .Left      = 148
2596:             .AutoSize  = .T.
2597:             .BackStyle = 0
2598:             .FontName  = "Tahoma"
2599:             .FontSize  = 8
2600:             .ForeColor = RGB(90, 90, 90)
2601:         ENDWITH

*-- Linhas 2712 a 3069:
2712:             .Enabled     = .F.
2713:             .Visible     = .T.
2714:         ENDWITH
2715:         BINDEVENT(loc_oPagina.cmd_4c_BtnCarta, "Click", THIS, "BtnCartaClick")
2716: 
2717:         *-- BINDEVENTs para controles da secao 2
2718:         BINDEVENT(loc_oPagina.txt_4c_EmiCarta, "InteractiveChange", THIS, "AtualizarEstadoCarta")
2719:         BINDEVENT(loc_oPagina.txt_4c_Moeda,    "KeyPress",         THIS, "ValidarMoedas")
2720:         BINDEVENT(loc_oPagina.txt_4c_GrupoT,   "KeyPress",         THIS, "ValidarGrupoT")
2721:         BINDEVENT(loc_oPagina.txt_4c_DGrupoT,  "KeyPress",         THIS, "ValidarDescGrupoT")
2722: 
2723:         *-- Linha separadora Line3 (fundo direito)
2724:         loc_oPagina.AddObject("lin_4c_Line3", "Shape")
2725:         WITH loc_oPagina.lin_4c_Line3
2726:             .Top         = 594
2727:             .Left        = 527
2728:             .Width       = 466
2729:             .Height      = 2
2730:             .BackColor   = RGB(90, 90, 90)
2731:             .BackStyle   = 1
2732:             .BorderStyle = 0
2733:             .Curvature   = 0
2734:             .Visible     = .T.
2735:         ENDWITH
2736: 
2737:         THIS.TornarControlesVisiveis(loc_oPagina)
2738:     ENDPROC
2739: 
2740:     *==========================================================================
2741:     * CarregarLista - Carrega dados no grid da Page1
2742:     * SELECT conforme colunas do legado: Operacaos, Tipos, OpAnts, GrupoOs
2743:     *==========================================================================
2744:     PROCEDURE CarregarLista()
2745:         LOCAL loc_lResultado, loc_oGrid
2746:         loc_lResultado = .F.
2747: 
2748:         TRY
2749:             IF THIS.this_oBusinessObject.Buscar("")
2750:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
2751: 
2752:                 loc_oGrid.ColumnCount = 4
2753:                 loc_oGrid.RecordSource          = "cursor_4c_Dados"
2754:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Operacaos"
2755:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Tipos"
2756:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.OpAnts"
2757:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.GrupoOs"
2758: 
2759:                 *-- Reconfigurar cabecalhos apos RecordSource (VFP reseta Headers)
2760:                 loc_oGrid.Column1.Header1.Caption = "Movimento"
2761:                 loc_oGrid.Column2.Header1.Caption = "Tipo"
2762:                 loc_oGrid.Column3.Header1.Caption = "Mv. Anterior"
2763:                 loc_oGrid.Column4.Header1.Caption = "Grupo/Ori"
2764: 
2765:                 loc_oGrid.Column1.Width = 140
2766:                 loc_oGrid.Column2.Width = 60
2767:                 loc_oGrid.Column3.Width = 140
2768:                 loc_oGrid.Column4.Width = 80
2769: 
2770:                 THIS.FormatarGridLista(loc_oGrid)
2771:                 loc_lResultado = .T.
2772:             ENDIF
2773:         CATCH TO loc_oErro
2774:             MsgErro("Erro ao carregar lista:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
2775:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
2776:                 "FormOpt.CarregarLista")
2777:         ENDTRY
2778: 
2779:         RETURN loc_lResultado
2780:     ENDPROC
2781: 
2782:     *==========================================================================
2783:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
2784:     * Ao voltar para Page1 recarrega o grid automaticamente
2785:     *==========================================================================
2786:     PROCEDURE AlternarPagina(par_nPagina)
2787:         LOCAL loc_lResultado
2788:         loc_lResultado = .F.
2789: 
2790:         TRY
2791:             IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
2792:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
2793: 
2794:                 IF par_nPagina = 1
2795:                     THIS.CarregarLista()
2796:                 ENDIF
2797: 
2798:                 loc_lResultado = .T.
2799:             ENDIF
2800:         CATCH TO loc_oErro
2801:             MsgErro("Erro em AlternarPagina:" + CHR(13) + loc_oErro.Message, ;
2802:                 "FormOpt.AlternarPagina")
2803:         ENDTRY
2804: 
2805:         RETURN loc_lResultado
2806:     ENDPROC
2807: 
2808:     *==========================================================================
2809:     * BtnIncluirClick - Abre Page2 para inclusao de novo registro
2810:     *==========================================================================
2811:     PROCEDURE BtnIncluirClick()
2812:         LOCAL loc_lResultado
2813:         loc_lResultado = .F.
2814: 
2815:         TRY
2816:             THIS.this_oBusinessObject.NovoRegistro()
2817:             THIS.LimparCampos()
2818:             THIS.this_cModoAtual = "INCLUIR"
2819:             THIS.HabilitarCampos(.T.)
2820:             THIS.pgf_4c_Paginas.ActivePage = 2
2821:             loc_lResultado = .T.
2822:         CATCH TO loc_oErro
2823:             MsgErro("Erro ao incluir:" + CHR(13) + loc_oErro.Message, ;
2824:                 "FormOpt.BtnIncluirClick")
2825:         ENDTRY
2826: 
2827:         RETURN loc_lResultado
2828:     ENDPROC
2829: 
2830:     *==========================================================================
2831:     * BtnVisualizarClick - Abre Page2 em modo somente leitura
2832:     *==========================================================================
2833:     PROCEDURE BtnVisualizarClick()
2834:         LOCAL loc_lResultado, loc_cCodigo
2835:         loc_lResultado = .F.
2836: 
2837:         TRY
2838:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
2839:                 MsgAviso("Selecione um registro para visualizar.", "")
2840:             ELSE
2841:                 SELECT cursor_4c_Dados
2842:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.Operacaos)
2843: 
2844:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
2845:                     THIS.this_cModoAtual = "VISUALIZAR"
2846:                     THIS.BOParaForm()
2847:                     THIS.HabilitarCampos(.F.)
2848:                     THIS.pgf_4c_Paginas.ActivePage = 2
2849:                     loc_lResultado = .T.
2850:                 ELSE
2851:                     MsgErro("Erro ao carregar registro para visualizar.", ;
2852:                         "FormOpt.BtnVisualizarClick")
2853:                 ENDIF
2854:             ENDIF
2855:         CATCH TO loc_oErro
2856:             MsgErro("Erro ao visualizar:" + CHR(13) + loc_oErro.Message, ;
2857:                 "FormOpt.BtnVisualizarClick")
2858:         ENDTRY
2859: 
2860:         RETURN loc_lResultado
2861:     ENDPROC
2862: 
2863:     *==========================================================================
2864:     * BtnAlterarClick - Abre Page2 para alteracao do registro selecionado
2865:     *==========================================================================
2866:     PROCEDURE BtnAlterarClick()
2867:         LOCAL loc_lResultado, loc_cCodigo
2868:         loc_lResultado = .F.
2869: 
2870:         TRY
2871:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
2872:                 MsgAviso("Selecione um registro para alterar.", "")
2873:             ELSE
2874:                 SELECT cursor_4c_Dados
2875:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.Operacaos)
2876: 
2877:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
2878:                     THIS.this_oBusinessObject.EditarRegistro()
2879:                     THIS.this_cModoAtual = "ALTERAR"
2880:                     THIS.BOParaForm()
2881:                     THIS.HabilitarCampos(.T.)
2882:                     THIS.pgf_4c_Paginas.ActivePage = 2
2883:                     loc_lResultado = .T.
2884:                 ELSE
2885:                     MsgErro("Erro ao carregar registro para alterar.", ;
2886:                         "FormOpt.BtnAlterarClick")
2887:                 ENDIF
2888:             ENDIF
2889:         CATCH TO loc_oErro
2890:             MsgErro("Erro ao alterar:" + CHR(13) + loc_oErro.Message, ;
2891:                 "FormOpt.BtnAlterarClick")
2892:         ENDTRY
2893: 
2894:         RETURN loc_lResultado
2895:     ENDPROC
2896: 
2897:     *==========================================================================
2898:     * BtnExcluirClick - Confirma e executa exclusao do registro selecionado
2899:     *==========================================================================
2900:     PROCEDURE BtnExcluirClick()
2901:         LOCAL loc_lResultado, loc_cCodigo, loc_lConfirmou
2902:         loc_lResultado = .F.
2903: 
2904:         TRY
2905:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
2906:                 MsgAviso("Selecione um registro para excluir.", "")
2907:             ELSE
2908:                 SELECT cursor_4c_Dados
2909:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.Operacaos)
2910: 
2911:                 loc_lConfirmou = MsgConfirma("Confirma a exclus" + CHR(227) + ;
2912:                     "o do registro '" + loc_cCodigo + "'?", ;
2913:                     "Confirmar Exclus" + CHR(227) + CHR(227) + "o")
2914: 
2915:                 IF loc_lConfirmou
2916:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
2917:                         IF THIS.this_oBusinessObject.Excluir()
2918:                             MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", ;
2919:                                 "Sucesso")
2920:                             THIS.CarregarLista()
2921:                         ELSE
2922:                             MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
2923:                                 "vel excluir o registro.", "FormOpt.BtnExcluirClick")
2924:                         ENDIF
2925:                     ENDIF
2926:                 ENDIF
2927: 
2928:                 loc_lResultado = .T.
2929:             ENDIF
2930:         CATCH TO loc_oErro
2931:             MsgErro("Erro ao excluir:" + CHR(13) + loc_oErro.Message, ;
2932:                 "FormOpt.BtnExcluirClick")
2933:         ENDTRY
2934: 
2935:         RETURN loc_lResultado
2936:     ENDPROC
2937: 
2938:     *==========================================================================
2939:     * BtnBuscarClick - Abre FormBuscaAuxiliar e posiciona no registro encontrado
2940:     *==========================================================================
2941:     PROCEDURE BtnBuscarClick()
2942:         LOCAL loc_lResultado, loc_oBusca, loc_cCodigo
2943:         loc_lResultado = .F.
2944: 
2945:         TRY
2946:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2947:                 "SigCdOpt", "cursor_4c_BuscaOpt", "Operacaos", "", ;
2948:                 "Buscar Movimenta" + CHR(231) + CHR(227) + "o")
2949: 
2950:             IF VARTYPE(loc_oBusca) = "O"
2951:                 loc_oBusca.mAddColuna("Operacaos", "", "Movimento")
2952:                 loc_oBusca.mAddColuna("Tipos", "", "Tipo")
2953:                 loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
2954:                 loc_oBusca.Show()
2955: 
2956:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpt")
2957:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaOpt.Operacaos)
2958:                     IF USED("cursor_4c_Dados")
2959:                         SELECT cursor_4c_Dados
2960:                         LOCATE FOR ALLTRIM(Operacaos) == loc_cCodigo
2961:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
2962:                     ENDIF
2963:                 ENDIF
2964: 
2965:                 loc_oBusca.Release()
2966:             ENDIF
2967: 
2968:             IF USED("cursor_4c_BuscaOpt")
2969:                 USE IN cursor_4c_BuscaOpt
2970:             ENDIF
2971: 
2972:             loc_lResultado = .T.
2973:         CATCH TO loc_oErro
2974:             MsgErro("Erro ao buscar:" + CHR(13) + loc_oErro.Message, ;
2975:                 "FormOpt.BtnBuscarClick")
2976: 
2977:             IF USED("cursor_4c_BuscaOpt")
2978:                 USE IN cursor_4c_BuscaOpt
2979:             ENDIF
2980:         ENDTRY
2981: 
2982:         RETURN loc_lResultado
2983:     ENDPROC
2984: 
2985:     *==========================================================================
2986:     * BtnEncerrarClick - Fecha o formulario
2987:     *==========================================================================
2988:     PROCEDURE BtnEncerrarClick()
2989:         THIS.Release()
2990:     ENDPROC
2991: 
2992:     *==========================================================================
2993:     * BtnSalvarClick - Salva o registro via BO (Page2 - Confirmar)
2994:     *==========================================================================
2995:     PROCEDURE BtnSalvarClick()
2996:         LOCAL loc_lResultado
2997:         loc_lResultado = .F.
2998: 
2999:         TRY
3000:             THIS.FormParaBO()
3001: 
3002:             IF THIS.this_oBusinessObject.Salvar()
3003:                 MsgInfo("Registro salvo com sucesso!", "Sucesso")
3004:                 THIS.this_cModoAtual = "LISTA"
3005:                 THIS.AlternarPagina(1)
3006:                 loc_lResultado = .T.
3007:             ELSE
3008:                 MsgErro("Erro ao salvar o registro.", "FormOpt.BtnSalvarClick")
3009:             ENDIF
3010:         CATCH TO loc_oErro
3011:             MsgErro("Erro ao salvar:" + CHR(13) + loc_oErro.Message, ;
3012:                 "FormOpt.BtnSalvarClick")
3013:         ENDTRY
3014: 
3015:         RETURN loc_lResultado
3016:     ENDPROC
3017: 
3018:     *==========================================================================
3019:     * BtnCancelarClick - Cancela edicao e retorna para lista
3020:     *==========================================================================
3021:     PROCEDURE BtnCancelarClick()
3022:         THIS.this_cModoAtual = "LISTA"
3023:         THIS.AlternarPagina(1)
3024:     ENDPROC
3025: 
3026:     *==========================================================================
3027:     * LimparCampos - Limpa os campos da Page2 (Fase 5)
3028:     *==========================================================================
3029:     PROTECTED PROCEDURE LimparCampos()
3030:         LOCAL loc_oPg2
3031:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
3032: 
3033:         IF VARTYPE(loc_oPg2) != "O"
3034:             RETURN
3035:         ENDIF
3036: 
3037:         IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 4)
3038:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
3039:         ENDIF
3040:         IF PEMSTATUS(loc_oPg2, "chk_4c_Fwcheckbox1", 4)
3041:             loc_oPg2.chk_4c_Fwcheckbox1.Value = 0
3042:         ENDIF
3043:         IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 4)
3044:             loc_oPg2.txt_4c_Codigo.Value = ""
3045:         ENDIF
3046:         IF PEMSTATUS(loc_oPg2, "txt_4c_Descr", 4)
3047:             loc_oPg2.txt_4c_Descr.Value = ""
3048:         ENDIF
3049:         IF PEMSTATUS(loc_oPg2, "txt_4c_Tipo", 4)
3050:             loc_oPg2.txt_4c_Tipo.Value = ""
3051:         ENDIF
3052:         IF PEMSTATUS(loc_oPg2, "txt_4c_OpAnts", 4)
3053:             loc_oPg2.txt_4c_OpAnts.Value = ""
3054:         ENDIF
3055:         IF PEMSTATUS(loc_oPg2, "txt_4c_OpContas", 4)
3056:             loc_oPg2.txt_4c_OpContas.Value = ""
3057:         ENDIF
3058:         IF PEMSTATUS(loc_oPg2, "txt_4c_Ordem", 4)
3059:             loc_oPg2.txt_4c_Ordem.Value = 0
3060:         ENDIF
3061:         IF PEMSTATUS(loc_oPg2, "txt_4c_OpEntrada", 4)
3062:             loc_oPg2.txt_4c_OpEntrada.Value = ""
3063:         ENDIF
3064:         IF PEMSTATUS(loc_oPg2, "txt_4c_OpAut", 4)
3065:             loc_oPg2.txt_4c_OpAut.Value = ""
3066:         ENDIF
3067:         IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_TipoData", 4)
3068:             loc_oPg2.obj_4c_Opc_TipoData.Value   = 1
3069:             loc_oPg2.obj_4c_Opc_TipoData.Enabled = .F.

*-- Linhas 3232 a 3275:
3232:     * par_lHabilitar: .T. = INCLUIR/ALTERAR, .F. = VISUALIZAR
3233:     * txt_4c_Codigo: ReadOnly em modo ALTERAR (legado: Get_codigo.When)
3234:     *==========================================================================
3235:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
3236:         LOCAL loc_oPg2
3237:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
3238: 
3239:         IF VARTYPE(loc_oPg2) != "O"
3240:             RETURN
3241:         ENDIF
3242: 
3243:         IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 4)
3244:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
3245:         ENDIF
3246:         IF PEMSTATUS(loc_oPg2, "chk_4c_Fwcheckbox1", 4)
3247:             loc_oPg2.chk_4c_Fwcheckbox1.Enabled = par_lHabilitar
3248:         ENDIF
3249:         IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 4)
3250:             loc_oPg2.txt_4c_Codigo.Enabled  = par_lHabilitar
3251:             loc_oPg2.txt_4c_Codigo.ReadOnly = (THIS.this_cModoAtual = "ALTERAR")
3252:         ENDIF
3253:         IF PEMSTATUS(loc_oPg2, "txt_4c_Descr", 4)
3254:             loc_oPg2.txt_4c_Descr.Enabled = par_lHabilitar
3255:         ENDIF
3256:         IF PEMSTATUS(loc_oPg2, "txt_4c_Tipo", 4)
3257:             loc_oPg2.txt_4c_Tipo.Enabled = par_lHabilitar
3258:         ENDIF
3259:         IF PEMSTATUS(loc_oPg2, "txt_4c_OpAnts", 4)
3260:             loc_oPg2.txt_4c_OpAnts.Enabled = par_lHabilitar
3261:         ENDIF
3262:         IF PEMSTATUS(loc_oPg2, "txt_4c_OpContas", 4)
3263:             loc_oPg2.txt_4c_OpContas.Enabled = par_lHabilitar
3264:         ENDIF
3265:         IF PEMSTATUS(loc_oPg2, "txt_4c_Ordem", 4)
3266:             loc_oPg2.txt_4c_Ordem.Enabled = par_lHabilitar
3267:         ENDIF
3268:         IF PEMSTATUS(loc_oPg2, "txt_4c_OpEntrada", 4)
3269:             loc_oPg2.txt_4c_OpEntrada.Enabled = par_lHabilitar
3270:         ENDIF
3271:         IF PEMSTATUS(loc_oPg2, "txt_4c_OpAut", 4)
3272:             loc_oPg2.txt_4c_OpAut.Enabled = par_lHabilitar
3273:         ENDIF
3274:         IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_TipoData", 4) AND ;
3275:                 PEMSTATUS(loc_oPg2, "txt_4c_OpAut", 4)

*-- Linhas 3440 a 3507:
3440:     *==========================================================================
3441:     * AjustarBotoesPorModo - Ajusta botoes por modo atual
3442:     *==========================================================================
3443:     PROCEDURE AjustarBotoesPorModo()
3444:         LOCAL loc_oPg2
3445:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
3446: 
3447:         IF VARTYPE(loc_oPg2) != "O"
3448:             RETURN
3449:         ENDIF
3450: 
3451:         IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 4)
3452:             WITH loc_oPg2.cnt_4c_BotoesAcao
3453:                 .cmd_4c_Confirmar.Enabled = (THIS.this_cModoAtual = "INCLUIR" OR ;
3454:                     THIS.this_cModoAtual = "ALTERAR")
3455:                 .cmd_4c_Cancelar.Enabled  = .T.
3456:                 .Visible     = .T.
3457:             ENDWITH
3458:         ENDIF
3459:     ENDPROC
3460: 
3461:     *==========================================================================
3462:     * FormParaBO - Transfere valores do Form para o BO
3463:     * Campos obrigatorios: Codigo (PK), Descricao, Tipo
3464:     * OptionGroups: .Value direto (1..N) = valor numerico no banco
3465:     * Checkbox Inativa: .Value=.T. -> 1 / .F. -> 0
3466:     *==========================================================================
3467:     PROTECTED PROCEDURE FormParaBO()
3468:         LOCAL loc_oPg2
3469:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
3470: 
3471:         IF VARTYPE(loc_oPg2) != "O"
3472:             RETURN
3473:         ENDIF
3474: 
3475:         WITH THIS.this_oBusinessObject
3476:             IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 4)
3477:                 .this_cOperacaos  = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
3478:             ENDIF
3479:             IF PEMSTATUS(loc_oPg2, "txt_4c_Descr", 4)
3480:                 .this_cDescrs     = ALLTRIM(loc_oPg2.txt_4c_Descr.Value)
3481:             ENDIF
3482:             IF PEMSTATUS(loc_oPg2, "txt_4c_Tipo", 4)
3483:                 .this_cTipos      = UPPER(ALLTRIM(loc_oPg2.txt_4c_Tipo.Value))
3484:             ENDIF
3485:             IF PEMSTATUS(loc_oPg2, "txt_4c_OpAnts", 4)
3486:                 .this_cOpAnts     = ALLTRIM(loc_oPg2.txt_4c_OpAnts.Value)
3487:             ENDIF
3488:             IF PEMSTATUS(loc_oPg2, "txt_4c_OpContas", 4)
3489:                 .this_cDopcs      = ALLTRIM(loc_oPg2.txt_4c_OpContas.Value)
3490:             ENDIF
3491:             IF PEMSTATUS(loc_oPg2, "txt_4c_Ordem", 4)
3492:                 .this_nOrdens     = loc_oPg2.txt_4c_Ordem.Value
3493:             ENDIF
3494:             IF PEMSTATUS(loc_oPg2, "txt_4c_OpEntrada", 4)
3495:                 .this_cOpEntradas = ALLTRIM(loc_oPg2.txt_4c_OpEntrada.Value)
3496:             ENDIF
3497:             IF PEMSTATUS(loc_oPg2, "txt_4c_OpAut", 4)
3498:                 .this_cOpAuts     = UPPER(ALLTRIM(loc_oPg2.txt_4c_OpAut.Value))
3499:             ENDIF
3500:             IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_TipoData", 4)
3501:                 .this_nTpDatas    = loc_oPg2.obj_4c_Opc_TipoData.Value
3502:             ENDIF
3503:             IF PEMSTATUS(loc_oPg2, "txt_4c_Fpg", 4)
3504:                 .this_cFPags      = ALLTRIM(loc_oPg2.txt_4c_Fpg.Value)
3505:             ENDIF
3506:             IF PEMSTATUS(loc_oPg2, "txt_4c_Hists", 4)
3507:                 .this_cHists      = ALLTRIM(loc_oPg2.txt_4c_Hists.Value)

*-- Linhas 3646 a 3691:
3646:     * BOParaForm - Transfere valores do BO para o Form
3647:     * Chamado em Alterar e Visualizar apos CarregarPorCodigo()
3648:     * Campos descricao (DCentral, DGrupoOs, ds_grupo, DContaOs, DConta)
3649:     *   serao preenchidos pelos BINDEVENTs de LostFocus quando aplicavel
3650:     *==========================================================================
3651:     PROTECTED PROCEDURE BOParaForm()
3652:         LOCAL loc_oPg2
3653:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
3654: 
3655:         IF VARTYPE(loc_oPg2) != "O"
3656:             RETURN
3657:         ENDIF
3658: 
3659:         WITH THIS.this_oBusinessObject
3660:             IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 4)
3661:                 loc_oPg2.txt_4c_Codigo.Value    = ALLTRIM(.this_cOperacaos)
3662:             ENDIF
3663:             IF PEMSTATUS(loc_oPg2, "txt_4c_Descr", 4)
3664:                 loc_oPg2.txt_4c_Descr.Value     = ALLTRIM(.this_cDescrs)
3665:             ENDIF
3666:             IF PEMSTATUS(loc_oPg2, "txt_4c_Tipo", 4)
3667:                 loc_oPg2.txt_4c_Tipo.Value      = ALLTRIM(.this_cTipos)
3668:             ENDIF
3669:             IF PEMSTATUS(loc_oPg2, "txt_4c_OpAnts", 4)
3670:                 loc_oPg2.txt_4c_OpAnts.Value    = ALLTRIM(.this_cOpAnts)
3671:             ENDIF
3672:             IF PEMSTATUS(loc_oPg2, "txt_4c_OpContas", 4)
3673:                 loc_oPg2.txt_4c_OpContas.Value  = ALLTRIM(.this_cDopcs)
3674:             ENDIF
3675:             IF PEMSTATUS(loc_oPg2, "txt_4c_Ordem", 4)
3676:                 loc_oPg2.txt_4c_Ordem.Value     = .this_nOrdens
3677:             ENDIF
3678:             IF PEMSTATUS(loc_oPg2, "txt_4c_OpEntrada", 4)
3679:                 loc_oPg2.txt_4c_OpEntrada.Value = ALLTRIM(.this_cOpEntradas)
3680:             ENDIF
3681:             IF PEMSTATUS(loc_oPg2, "txt_4c_OpAut", 4)
3682:                 loc_oPg2.txt_4c_OpAut.Value     = ALLTRIM(.this_cOpAuts)
3683:             ENDIF
3684:             IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_TipoData", 4)
3685:                 loc_oPg2.obj_4c_Opc_TipoData.Value = IIF(.this_nTpDatas >= 1 AND ;
3686:                     .this_nTpDatas <= 4, .this_nTpDatas, 1)
3687:             ENDIF
3688:             IF PEMSTATUS(loc_oPg2, "txt_4c_Fpg", 4)
3689:                 loc_oPg2.txt_4c_Fpg.Value       = ALLTRIM(.this_cFPags)
3690:             ENDIF
3691:             IF PEMSTATUS(loc_oPg2, "txt_4c_Hists", 4)

*-- Linhas 3857 a 4550:
3857:     *==========================================================================
3858:     * FormatarGridLista - Formata visual do grid da lista
3859:     *==========================================================================
3860:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
3861:         IF VARTYPE(par_oGrid) != "O"
3862:             RETURN
3863:         ENDIF
3864: 
3865:         WITH par_oGrid
3866:             .FontName = "Verdana"
3867:             .FontSize = 8
3868:         ENDWITH
3869:     ENDPROC
3870: 
3871:     *==========================================================================
3872:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
3873:     * Necessario pois AddObject() cria controles com Visible=.F. por padrao
3874:     *==========================================================================
3875:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
3876:         LOCAL loc_nI, loc_oObjeto, loc_nP
3877: 
3878:         IF VARTYPE(par_oContainer) != "O"
3879:             RETURN
3880:         ENDIF
3881: 
3882:         FOR loc_nI = 1 TO par_oContainer.ControlCount
3883:             loc_oObjeto = par_oContainer.Controls(loc_nI)
3884: 
3885:             IF VARTYPE(loc_oObjeto) = "O"
3886:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
3887:                     loc_oObjeto.Visible = .T.
3888:                 ENDIF
3889: 
3890:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
3891:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
3892:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
3893:                     ENDFOR
3894:                 ENDIF
3895: 
3896:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
3897:                     THIS.TornarControlesVisiveis(loc_oObjeto)
3898:                 ENDIF
3899:             ENDIF
3900:         ENDFOR
3901:     ENDPROC
3902: 
3903:     *==========================================================================
3904:     * Destroy - Libera recursos ao fechar o formulario
3905:     *==========================================================================
3906:     PROCEDURE Destroy()
3907:         IF USED("cursor_4c_Dados")
3908:             USE IN cursor_4c_Dados
3909:         ENDIF
3910: 
3911:         IF USED("cursor_4c_BuscaOpt")
3912:             USE IN cursor_4c_BuscaOpt
3913:         ENDIF
3914: 
3915:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
3916:             THIS.this_oBusinessObject = .NULL.
3917:         ENDIF
3918: 
3919:         DODEFAULT()
3920:     ENDPROC
3921: 
3922:     *==========================================================================
3923:     * AtualizarEstadoTipoData - InteractiveChange de txt_4c_OpAut
3924:     * Habilita Opc_TipoData somente quando OpAut = "S"
3925:     *==========================================================================
3926:     PROCEDURE AtualizarEstadoTipoData()
3927:         LOCAL loc_oPg2
3928:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
3929: 
3930:         IF VARTYPE(loc_oPg2) != "O"
3931:             RETURN
3932:         ENDIF
3933: 
3934:         IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_TipoData", 4) AND ;
3935:                 PEMSTATUS(loc_oPg2, "txt_4c_OpAut", 4)
3936:             loc_oPg2.obj_4c_Opc_TipoData.Enabled = ;
3937:                 (UPPER(ALLTRIM(loc_oPg2.txt_4c_OpAut.Value)) = "S")
3938:         ENDIF
3939:     ENDPROC
3940: 
3941:     *==========================================================================
3942:     * ValidarOpAnts - LostFocus: Movimento Anterior (lookup SigCdOpt)
3943:     *==========================================================================
3944:     PROCEDURE ValidarOpAnts(par_nKeyCode, par_nShiftAltCtrl)
3945:         LOCAL loc_oPg2, loc_cVal
3946:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
3947: 
3948:         IF VARTYPE(loc_oPg2) != "O" OR !PEMSTATUS(loc_oPg2, "txt_4c_OpAnts", 4)
3949:             RETURN
3950:         ENDIF
3951: 
3952:         loc_cVal = ALLTRIM(loc_oPg2.txt_4c_OpAnts.Value)
3953: 
3954:         IF !EMPTY(loc_cVal)
3955:             THIS.AbrirLookupCanonico("SigCdOpt", "Operacaos", "Descrs", ;
3956:                 "Movimento Anterior", loc_cVal, ;
3957:                 loc_oPg2.txt_4c_OpAnts, .NULL., "")
3958:         ENDIF
3959:     ENDPROC
3960: 
3961:     *==========================================================================
3962:     * ValidarOpContas - LostFocus: Movimento de Titulos (lookup SIGOPOPE)
3963:     *==========================================================================
3964:     PROCEDURE ValidarOpContas(par_nKeyCode, par_nShiftAltCtrl)
3965:         LOCAL loc_oPg2, loc_cVal
3966:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
3967: 
3968:         IF VARTYPE(loc_oPg2) != "O" OR !PEMSTATUS(loc_oPg2, "txt_4c_OpContas", 4)
3969:             RETURN
3970:         ENDIF
3971: 
3972:         loc_cVal = ALLTRIM(loc_oPg2.txt_4c_OpContas.Value)
3973: 
3974:         IF !EMPTY(loc_cVal)
3975:             THIS.AbrirLookupCanonico("SIGOPOPE", "Dopes", "Dopes", ;
3976:                 "Oper. de T" + CHR(237) + "tulos", loc_cVal, ;
3977:                 loc_oPg2.txt_4c_OpContas, .NULL., "Congvs = 1")
3978:         ENDIF
3979:     ENDPROC
3980: 
3981:     *==========================================================================
3982:     * ValidarOpEntrada - LostFocus: Movimento de Entrada (lookup SigCdOpt)
3983:     * Exclui o proprio registro corrente do lookup
3984:     *==========================================================================
3985:     PROCEDURE ValidarOpEntrada(par_nKeyCode, par_nShiftAltCtrl)
3986:         LOCAL loc_oPg2, loc_cVal, loc_cFiltro
3987:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
3988: 
3989:         IF VARTYPE(loc_oPg2) != "O" OR !PEMSTATUS(loc_oPg2, "txt_4c_OpEntrada", 4)
3990:             RETURN
3991:         ENDIF
3992: 
3993:         loc_cVal    = ALLTRIM(loc_oPg2.txt_4c_OpEntrada.Value)
3994:         loc_cFiltro = ""
3995: 
3996:         IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 4) AND ;
3997:                 !EMPTY(ALLTRIM(loc_oPg2.txt_4c_Codigo.Value))
3998:             loc_cFiltro = "Operacaos <> '" + ;
3999:                 STRTRAN(ALLTRIM(loc_oPg2.txt_4c_Codigo.Value), "'", "''") + "'"
4000:         ENDIF
4001: 
4002:         IF !EMPTY(loc_cVal)
4003:             THIS.AbrirLookupCanonico("SigCdOpt", "Operacaos", "Descrs", ;
4004:                 "Oper. de Entrada", loc_cVal, ;
4005:                 loc_oPg2.txt_4c_OpEntrada, .NULL., loc_cFiltro)
4006:         ENDIF
4007:     ENDPROC
4008: 
4009:     *==========================================================================
4010:     * ValidarFpg - LostFocus: Condicao de Pagamento (lookup SigOpFp)
4011:     *==========================================================================
4012:     PROCEDURE ValidarFpg(par_nKeyCode, par_nShiftAltCtrl)
4013:         LOCAL loc_oPg2, loc_cVal
4014:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
4015: 
4016:         IF VARTYPE(loc_oPg2) != "O" OR !PEMSTATUS(loc_oPg2, "txt_4c_Fpg", 4)
4017:             RETURN
4018:         ENDIF
4019: 
4020:         loc_cVal = ALLTRIM(loc_oPg2.txt_4c_Fpg.Value)
4021: 
4022:         IF !EMPTY(loc_cVal)
4023:             THIS.AbrirLookupCanonico("SigOpFp", "fpags", "fpags", ;
4024:                 "Condi" + CHR(231) + CHR(227) + "o Pagto", loc_cVal, ;
4025:                 loc_oPg2.txt_4c_Fpg, .NULL., "Infos = 'C' AND EmiChqs <> 1")
4026:         ENDIF
4027:     ENDPROC
4028: 
4029:     *==========================================================================
4030:     * ValidarSituacao - LostFocus: Situacao do Cliente (lookup SigCdCst)
4031:     *==========================================================================
4032:     PROCEDURE ValidarSituacao(par_nKeyCode, par_nShiftAltCtrl)
4033:         LOCAL loc_oPg2, loc_cVal
4034:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
4035: 
4036:         IF VARTYPE(loc_oPg2) != "O" OR !PEMSTATUS(loc_oPg2, "txt_4c_Situa", 4)
4037:             RETURN
4038:         ENDIF
4039: 
4040:         loc_cVal = ALLTRIM(loc_oPg2.txt_4c_Situa.Value)
4041: 
4042:         IF !EMPTY(loc_cVal)
4043:             THIS.AbrirLookupCanonico("SigCdCst", "codigos", "descrs", ;
4044:                 "Situa" + CHR(231) + CHR(245) + "es", loc_cVal, ;
4045:                 loc_oPg2.txt_4c_Situa, .NULL., "Priors BETWEEN 1 AND 998")
4046:         ENDIF
4047:     ENDPROC
4048: 
4049:     *==========================================================================
4050:     * ValidarHispad - LostFocus: Grupo Emissor Default (fAcessoContab)
4051:     *==========================================================================
4052:     PROCEDURE ValidarHispad(par_nKeyCode, par_nShiftAltCtrl)
4053:         LOCAL loc_oPg2, loc_cVal, loc_lResultado
4054:         loc_lResultado = .F.
4055:         loc_oPg2       = THIS.pgf_4c_Paginas.Page2
4056: 
4057:         IF VARTYPE(loc_oPg2) != "O" OR !PEMSTATUS(loc_oPg2, "txt_4c_Hispad", 4)
4058:             RETURN
4059:         ENDIF
4060: 
4061:         loc_cVal = ALLTRIM(loc_oPg2.txt_4c_Hispad.Value)
4062: 
4063:         TRY
4064:             IF !EMPTY(loc_cVal)
4065:                 fAcessoContab(Usuar, "C", loc_cVal, loc_oPg2.txt_4c_Hispad)
4066:             ENDIF
4067:             loc_lResultado = .T.
4068:         CATCH TO loc_oErro
4069:             MsgErro("Erro ao validar Grupo Emissor:" + CHR(13) + ;
4070:                 loc_oErro.Message, "FormOpt.ValidarHispad")
4071:         ENDTRY
4072: 
4073:         RETURN loc_lResultado
4074:     ENDPROC
4075: 
4076:     *==========================================================================
4077:     * ValidarResponsavel - LostFocus: Responsavel (fAcessoContab)
4078:     *==========================================================================
4079:     PROCEDURE ValidarResponsavel(par_nKeyCode, par_nShiftAltCtrl)
4080:         LOCAL loc_oPg2, loc_cVal, loc_lResultado
4081:         loc_lResultado = .F.
4082:         loc_oPg2       = THIS.pgf_4c_Paginas.Page2
4083: 
4084:         IF VARTYPE(loc_oPg2) != "O" OR !PEMSTATUS(loc_oPg2, "txt_4c_Respons", 4)
4085:             RETURN
4086:         ENDIF
4087: 
4088:         loc_cVal = ALLTRIM(loc_oPg2.txt_4c_Respons.Value)
4089: 
4090:         TRY
4091:             IF !EMPTY(loc_cVal)
4092:                 fAcessoContab(Usuar, "C", loc_cVal, loc_oPg2.txt_4c_Respons)
4093:             ENDIF
4094:             loc_lResultado = .T.
4095:         CATCH TO loc_oErro
4096:             MsgErro("Erro ao validar Respons" + CHR(225) + "vel:" + CHR(13) + ;
4097:                 loc_oErro.Message, "FormOpt.ValidarResponsavel")
4098:         ENDTRY
4099: 
4100:         RETURN loc_lResultado
4101:     ENDPROC
4102: 
4103:     *==========================================================================
4104:     * ValidarCentral - LostFocus: Central de Credito por codigo (lookup SIGCCCCO)
4105:     *==========================================================================
4106:     PROCEDURE ValidarCentral(par_nKeyCode, par_nShiftAltCtrl)
4107:         LOCAL loc_oPg2, loc_cVal
4108:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
4109: 
4110:         IF VARTYPE(loc_oPg2) != "O" OR !PEMSTATUS(loc_oPg2, "txt_4c_Central", 4)
4111:             RETURN
4112:         ENDIF
4113: 
4114:         loc_cVal = ALLTRIM(loc_oPg2.txt_4c_Central.Value)
4115: 
4116:         IF !EMPTY(loc_cVal)
4117:             THIS.AbrirLookupCanonico("SIGCCCCO", "Cods", "Descs", ;
4118:                 "Central de Cr" + CHR(233) + "dito", loc_cVal, ;
4119:                 loc_oPg2.txt_4c_Central, loc_oPg2.txt_4c_DCentral, "")
4120:         ENDIF
4121:     ENDPROC
4122: 
4123:     *==========================================================================
4124:     * ValidarDescCentral - LostFocus: Central de Credito por descricao
4125:     *==========================================================================
4126:     PROCEDURE ValidarDescCentral(par_nKeyCode, par_nShiftAltCtrl)
4127:         LOCAL loc_oPg2, loc_cDesc
4128:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
4129: 
4130:         IF VARTYPE(loc_oPg2) != "O" OR !PEMSTATUS(loc_oPg2, "txt_4c_DCentral", 4)
4131:             RETURN
4132:         ENDIF
4133: 
4134:         loc_cDesc = ALLTRIM(loc_oPg2.txt_4c_DCentral.Value)
4135: 
4136:         IF !EMPTY(loc_cDesc)
4137:             THIS.AbrirLookupCanonico("SIGCCCCO", "Descs", "Cods", ;
4138:                 "Central de Cr" + CHR(233) + "dito", loc_cDesc, ;
4139:                 loc_oPg2.txt_4c_DCentral, loc_oPg2.txt_4c_Central, "")
4140:         ENDIF
4141:     ENDPROC
4142: 
4143:     *==========================================================================
4144:     * ValidarGrupoOrig - LostFocus: Grupo de Origem por codigo (fAcessoContab)
4145:     *==========================================================================
4146:     PROCEDURE ValidarGrupoOrig(par_nKeyCode, par_nShiftAltCtrl)
4147:         LOCAL loc_oPg2, loc_cVal, loc_lResultado
4148:         loc_lResultado = .F.
4149:         loc_oPg2       = THIS.pgf_4c_Paginas.Page2
4150: 
4151:         IF VARTYPE(loc_oPg2) != "O" OR !PEMSTATUS(loc_oPg2, "txt_4c_GrupoOs", 4)
4152:             RETURN
4153:         ENDIF
4154: 
4155:         loc_cVal = ALLTRIM(loc_oPg2.txt_4c_GrupoOs.Value)
4156: 
4157:         TRY
4158:             IF !EMPTY(loc_cVal)
4159:                 fAcessoContab(Usuar, "C", loc_cVal, ;
4160:                     loc_oPg2.txt_4c_GrupoOs, loc_oPg2.txt_4c_DGrupoOs)
4161:             ENDIF
4162:             loc_lResultado = .T.
4163:         CATCH TO loc_oErro
4164:             MsgErro("Erro ao validar Grupo/Origem:" + CHR(13) + ;
4165:                 loc_oErro.Message, "FormOpt.ValidarGrupoOrig")
4166:         ENDTRY
4167: 
4168:         RETURN loc_lResultado
4169:     ENDPROC
4170: 
4171:     *==========================================================================
4172:     * ValidarDescGrupoOrig - LostFocus: Grupo de Origem por descricao (fAcessoContab 'D')
4173:     *==========================================================================
4174:     PROCEDURE ValidarDescGrupoOrig(par_nKeyCode, par_nShiftAltCtrl)
4175:         LOCAL loc_oPg2, loc_cDesc, loc_lResultado
4176:         loc_lResultado = .F.
4177:         loc_oPg2       = THIS.pgf_4c_Paginas.Page2
4178: 
4179:         IF VARTYPE(loc_oPg2) != "O" OR !PEMSTATUS(loc_oPg2, "txt_4c_DGrupoOs", 4)
4180:             RETURN
4181:         ENDIF
4182: 
4183:         loc_cDesc = ALLTRIM(loc_oPg2.txt_4c_DGrupoOs.Value)
4184: 
4185:         TRY
4186:             IF !EMPTY(loc_cDesc)
4187:                 fAcessoContab(Usuar, "D", loc_cDesc, ;
4188:                     loc_oPg2.txt_4c_GrupoOs, loc_oPg2.txt_4c_DGrupoOs)
4189:             ENDIF
4190:             loc_lResultado = .T.
4191:         CATCH TO loc_oErro
4192:             MsgErro("Erro ao validar desc. Grupo/Origem:" + CHR(13) + ;
4193:                 loc_oErro.Message, "FormOpt.ValidarDescGrupoOrig")
4194:         ENDTRY
4195: 
4196:         RETURN loc_lResultado
4197:     ENDPROC
4198: 
4199:     *==========================================================================
4200:     * ValidarGrupoDest - LostFocus: Grupo de Destino por codigo (fAcessoContab)
4201:     *==========================================================================
4202:     PROCEDURE ValidarGrupoDest(par_nKeyCode, par_nShiftAltCtrl)
4203:         LOCAL loc_oPg2, loc_cVal, loc_lResultado
4204:         loc_lResultado = .F.
4205:         loc_oPg2       = THIS.pgf_4c_Paginas.Page2
4206: 
4207:         IF VARTYPE(loc_oPg2) != "O" OR !PEMSTATUS(loc_oPg2, "txt_4c_Grupo", 4)
4208:             RETURN
4209:         ENDIF
4210: 
4211:         loc_cVal = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)
4212: 
4213:         TRY
4214:             IF !EMPTY(loc_cVal)
4215:                 fAcessoContab(Usuar, "C", loc_cVal, ;
4216:                     loc_oPg2.txt_4c_Grupo, loc_oPg2.txt_4c__ds_grupo)
4217:             ENDIF
4218:             loc_lResultado = .T.
4219:         CATCH TO loc_oErro
4220:             MsgErro("Erro ao validar Grupo/Destino:" + CHR(13) + ;
4221:                 loc_oErro.Message, "FormOpt.ValidarGrupoDest")
4222:         ENDTRY
4223: 
4224:         RETURN loc_lResultado
4225:     ENDPROC
4226: 
4227:     *==========================================================================
4228:     * ValidarDescGrupoDest - LostFocus: Grupo de Destino por descricao (fAcessoContab 'D')
4229:     *==========================================================================
4230:     PROCEDURE ValidarDescGrupoDest(par_nKeyCode, par_nShiftAltCtrl)
4231:         LOCAL loc_oPg2, loc_cDesc, loc_lResultado
4232:         loc_lResultado = .F.
4233:         loc_oPg2       = THIS.pgf_4c_Paginas.Page2
4234: 
4235:         IF VARTYPE(loc_oPg2) != "O" OR !PEMSTATUS(loc_oPg2, "txt_4c__ds_grupo", 4)
4236:             RETURN
4237:         ENDIF
4238: 
4239:         loc_cDesc = ALLTRIM(loc_oPg2.txt_4c__ds_grupo.Value)
4240: 
4241:         TRY
4242:             IF !EMPTY(loc_cDesc)
4243:                 fAcessoContab(Usuar, "D", loc_cDesc, ;
4244:                     loc_oPg2.txt_4c_Grupo, loc_oPg2.txt_4c__ds_grupo)
4245:             ENDIF
4246:             loc_lResultado = .T.
4247:         CATCH TO loc_oErro
4248:             MsgErro("Erro ao validar desc. Grupo/Destino:" + CHR(13) + ;
4249:                 loc_oErro.Message, "FormOpt.ValidarDescGrupoDest")
4250:         ENDTRY
4251: 
4252:         RETURN loc_lResultado
4253:     ENDPROC
4254: 
4255:     *==========================================================================
4256:     * ValidarContaOrig - LostFocus: Conta de Origem por codigo (fAcessoContas)
4257:     *==========================================================================
4258:     PROCEDURE ValidarContaOrig(par_nKeyCode, par_nShiftAltCtrl)
4259:         LOCAL loc_oPg2, loc_cVal, loc_cGrupoOs, loc_lResultado
4260:         loc_lResultado = .F.
4261:         loc_oPg2       = THIS.pgf_4c_Paginas.Page2
4262: 
4263:         IF VARTYPE(loc_oPg2) != "O" OR !PEMSTATUS(loc_oPg2, "txt_4c_ContaOs", 4)
4264:             RETURN
4265:         ENDIF
4266: 
4267:         loc_cVal     = ALLTRIM(loc_oPg2.txt_4c_ContaOs.Value)
4268:         loc_cGrupoOs = ""
4269:         IF PEMSTATUS(loc_oPg2, "txt_4c_GrupoOs", 4)
4270:             loc_cGrupoOs = ALLTRIM(loc_oPg2.txt_4c_GrupoOs.Value)
4271:         ENDIF
4272: 
4273:         TRY
4274:             IF !EMPTY(loc_cVal)
4275:                 fAcessoContas(Usuar, loc_cGrupoOs, "C", loc_cVal, ;
4276:                     loc_oPg2.txt_4c_ContaOs, loc_oPg2.txt_4c_DContaOs)
4277:             ENDIF
4278:             loc_lResultado = .T.
4279:         CATCH TO loc_oErro
4280:             MsgErro("Erro ao validar Conta/Origem:" + CHR(13) + ;
4281:                 loc_oErro.Message, "FormOpt.ValidarContaOrig")
4282:         ENDTRY
4283: 
4284:         RETURN loc_lResultado
4285:     ENDPROC
4286: 
4287:     *==========================================================================
4288:     * ValidarDescContaOrig - LostFocus: Conta de Origem por descricao (fAcessoContas 'D')
4289:     *==========================================================================
4290:     PROCEDURE ValidarDescContaOrig(par_nKeyCode, par_nShiftAltCtrl)
4291:         LOCAL loc_oPg2, loc_cDesc, loc_cGrupoOs, loc_lResultado
4292:         loc_lResultado = .F.
4293:         loc_oPg2       = THIS.pgf_4c_Paginas.Page2
4294: 
4295:         IF VARTYPE(loc_oPg2) != "O" OR !PEMSTATUS(loc_oPg2, "txt_4c_DContaOs", 4)
4296:             RETURN
4297:         ENDIF
4298: 
4299:         loc_cDesc    = ALLTRIM(loc_oPg2.txt_4c_DContaOs.Value)
4300:         loc_cGrupoOs = ""
4301:         IF PEMSTATUS(loc_oPg2, "txt_4c_GrupoOs", 4)
4302:             loc_cGrupoOs = ALLTRIM(loc_oPg2.txt_4c_GrupoOs.Value)
4303:         ENDIF
4304: 
4305:         TRY
4306:             IF !EMPTY(loc_cDesc)
4307:                 fAcessoContas(Usuar, loc_cGrupoOs, "D", loc_cDesc, ;
4308:                     loc_oPg2.txt_4c_ContaOs, loc_oPg2.txt_4c_DContaOs)
4309:             ENDIF
4310:             loc_lResultado = .T.
4311:         CATCH TO loc_oErro
4312:             MsgErro("Erro ao validar desc. Conta/Origem:" + CHR(13) + ;
4313:                 loc_oErro.Message, "FormOpt.ValidarDescContaOrig")
4314:         ENDTRY
4315: 
4316:         RETURN loc_lResultado
4317:     ENDPROC
4318: 
4319:     *==========================================================================
4320:     * ValidarContaDest - LostFocus: Conta de Destino por codigo (fAcessoContas)
4321:     *==========================================================================
4322:     PROCEDURE ValidarContaDest(par_nKeyCode, par_nShiftAltCtrl)
4323:         LOCAL loc_oPg2, loc_cVal, loc_cGrupo, loc_lResultado
4324:         loc_lResultado = .F.
4325:         loc_oPg2       = THIS.pgf_4c_Paginas.Page2
4326: 
4327:         IF VARTYPE(loc_oPg2) != "O" OR !PEMSTATUS(loc_oPg2, "txt_4c_Conta", 4)
4328:             RETURN
4329:         ENDIF
4330: 
4331:         loc_cVal   = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)
4332:         loc_cGrupo = ""
4333:         IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo", 4)
4334:             loc_cGrupo = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)
4335:         ENDIF
4336: 
4337:         TRY
4338:             IF !EMPTY(loc_cVal)
4339:                 fAcessoContas(Usuar, loc_cGrupo, "C", loc_cVal, ;
4340:                     loc_oPg2.txt_4c_Conta, loc_oPg2.txt_4c_DConta)
4341:             ENDIF
4342:             loc_lResultado = .T.
4343:         CATCH TO loc_oErro
4344:             MsgErro("Erro ao validar Conta/Destino:" + CHR(13) + ;
4345:                 loc_oErro.Message, "FormOpt.ValidarContaDest")
4346:         ENDTRY
4347: 
4348:         RETURN loc_lResultado
4349:     ENDPROC
4350: 
4351:     *==========================================================================
4352:     * ValidarDescContaDest - LostFocus: Conta de Destino por descricao (fAcessoContas 'D')
4353:     *==========================================================================
4354:     PROCEDURE ValidarDescContaDest(par_nKeyCode, par_nShiftAltCtrl)
4355:         LOCAL loc_oPg2, loc_cDesc, loc_cGrupo, loc_lResultado
4356:         loc_lResultado = .F.
4357:         loc_oPg2       = THIS.pgf_4c_Paginas.Page2
4358: 
4359:         IF VARTYPE(loc_oPg2) != "O" OR !PEMSTATUS(loc_oPg2, "txt_4c_DConta", 4)
4360:             RETURN
4361:         ENDIF
4362: 
4363:         loc_cDesc  = ALLTRIM(loc_oPg2.txt_4c_DConta.Value)
4364:         loc_cGrupo = ""
4365:         IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo", 4)
4366:             loc_cGrupo = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)
4367:         ENDIF
4368: 
4369:         TRY
4370:             IF !EMPTY(loc_cDesc)
4371:                 fAcessoContas(Usuar, loc_cGrupo, "D", loc_cDesc, ;
4372:                     loc_oPg2.txt_4c_Conta, loc_oPg2.txt_4c_DConta)
4373:             ENDIF
4374:             loc_lResultado = .T.
4375:         CATCH TO loc_oErro
4376:             MsgErro("Erro ao validar desc. Conta/Destino:" + CHR(13) + ;
4377:                 loc_oErro.Message, "FormOpt.ValidarDescContaDest")
4378:         ENDTRY
4379: 
4380:         RETURN loc_lResultado
4381:     ENDPROC
4382: 
4383:     *==========================================================================
4384:     * ValidarGrupoT - LostFocus: Grupo Terceiro por codigo (fAcessoContab)
4385:     *==========================================================================
4386:     PROCEDURE ValidarGrupoT(par_nKeyCode, par_nShiftAltCtrl)
4387:         LOCAL loc_oPg2, loc_cVal, loc_lResultado
4388:         loc_lResultado = .F.
4389:         loc_oPg2       = THIS.pgf_4c_Paginas.Page2
4390: 
4391:         IF VARTYPE(loc_oPg2) != "O" OR !PEMSTATUS(loc_oPg2, "txt_4c_GrupoT", 4)
4392:             RETURN
4393:         ENDIF
4394: 
4395:         loc_cVal = ALLTRIM(loc_oPg2.txt_4c_GrupoT.Value)
4396: 
4397:         TRY
4398:             IF !EMPTY(loc_cVal)
4399:                 fAcessoContab(Usuar, "C", loc_cVal, ;
4400:                     loc_oPg2.txt_4c_GrupoT, loc_oPg2.txt_4c_DGrupoT)
4401:             ELSE
4402:                 IF PEMSTATUS(loc_oPg2, "txt_4c_DGrupoT", 4)
4403:                     loc_oPg2.txt_4c_DGrupoT.Value = ""
4404:                 ENDIF
4405:             ENDIF
4406:             loc_lResultado = .T.
4407:         CATCH TO loc_oErro
4408:             MsgErro("Erro ao validar Grupo Terceiro:" + CHR(13) + ;
4409:                 loc_oErro.Message, "FormOpt.ValidarGrupoT")
4410:         ENDTRY
4411: 
4412:         RETURN loc_lResultado
4413:     ENDPROC
4414: 
4415:     *==========================================================================
4416:     * ValidarDescGrupoT - LostFocus: Grupo Terceiro por descricao (fAcessoContab 'D')
4417:     *==========================================================================
4418:     PROCEDURE ValidarDescGrupoT(par_nKeyCode, par_nShiftAltCtrl)
4419:         LOCAL loc_oPg2, loc_cDesc, loc_lResultado
4420:         loc_lResultado = .F.
4421:         loc_oPg2       = THIS.pgf_4c_Paginas.Page2
4422: 
4423:         IF VARTYPE(loc_oPg2) != "O" OR !PEMSTATUS(loc_oPg2, "txt_4c_DGrupoT", 4)
4424:             RETURN
4425:         ENDIF
4426: 
4427:         loc_cDesc = ALLTRIM(loc_oPg2.txt_4c_DGrupoT.Value)
4428: 
4429:         TRY
4430:             IF !EMPTY(loc_cDesc)
4431:                 fAcessoContab(Usuar, "D", loc_cDesc, ;
4432:                     loc_oPg2.txt_4c_GrupoT, loc_oPg2.txt_4c_DGrupoT)
4433:             ELSE
4434:                 IF PEMSTATUS(loc_oPg2, "txt_4c_GrupoT", 4)
4435:                     loc_oPg2.txt_4c_GrupoT.Value = ""
4436:                 ENDIF
4437:             ENDIF
4438:             loc_lResultado = .T.
4439:         CATCH TO loc_oErro
4440:             MsgErro("Erro ao validar desc. Grupo Terceiro:" + CHR(13) + ;
4441:                 loc_oErro.Message, "FormOpt.ValidarDescGrupoT")
4442:         ENDTRY
4443: 
4444:         RETURN loc_lResultado
4445:     ENDPROC
4446: 
4447:     *==========================================================================
4448:     * ValidarMoedas - LostFocus: Moeda (lookup SigCdMoe)
4449:     *==========================================================================
4450:     PROCEDURE ValidarMoedas(par_nKeyCode, par_nShiftAltCtrl)
4451:         LOCAL loc_oPg2, loc_cVal
4452:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
4453: 
4454:         IF VARTYPE(loc_oPg2) != "O" OR !PEMSTATUS(loc_oPg2, "txt_4c_Moeda", 4)
4455:             RETURN
4456:         ENDIF
4457: 
4458:         loc_cVal = ALLTRIM(loc_oPg2.txt_4c_Moeda.Value)
4459: 
4460:         IF !EMPTY(loc_cVal)
4461:             THIS.AbrirLookupCanonico("SigCdMoe", "CMoes", "DMoes", ;
4462:                 "Moeda", loc_cVal, ;
4463:                 loc_oPg2.txt_4c_Moeda, .NULL., "")
4464:         ENDIF
4465:     ENDPROC
4466: 
4467:     *==========================================================================
4468:     * AtualizarEstadoCarta - InteractiveChange de txt_4c_EmiCarta
4469:     * Habilita cmd_4c_BtnCarta somente quando EmiCarta = "S"
4470:     *==========================================================================
4471:     PROCEDURE AtualizarEstadoCarta()
4472:         LOCAL loc_oPg2
4473:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
4474: 
4475:         IF VARTYPE(loc_oPg2) != "O"
4476:             RETURN
4477:         ENDIF
4478: 
4479:         IF PEMSTATUS(loc_oPg2, "cmd_4c_BtnCarta", 4) AND ;
4480:                 PEMSTATUS(loc_oPg2, "txt_4c_EmiCarta", 4)
4481:             loc_oPg2.cmd_4c_BtnCarta.Enabled = ;
4482:                 (UPPER(ALLTRIM(loc_oPg2.txt_4c_EmiCarta.Value)) = "S")
4483:         ENDIF
4484:     ENDPROC
4485: 
4486:     *==========================================================================
4487:     * BtnCartaClick - Abre formulario SigOpCoc (configuracao de carta)
4488:     *==========================================================================
4489:     PROCEDURE BtnCartaClick()
4490:         LOCAL loc_lResultado
4491:         loc_lResultado = .F.
4492: 
4493:         TRY
4494:             MsgAviso("Funcionalidade SigOpCoc n" + CHR(227) + "o migrada ainda.", ;
4495:                 "FormOpt")
4496:             loc_lResultado = .T.
4497:         CATCH TO loc_oErro
4498:             MsgErro("Erro ao abrir carta:" + CHR(13) + loc_oErro.Message, ;
4499:                 "FormOpt.BtnCartaClick")
4500:         ENDTRY
4501: 
4502:         RETURN loc_lResultado
4503:     ENDPROC
4504: 
4505:     *==========================================================================
4506:     * AbrirLookupCanonico - Helper para lookup via FormBuscaAuxiliar (Pattern A)
4507:     * SQL no caller -> CREATEOBJECT sem params -> DefinirCursor -> Mostrar
4508:     * -> ler .cCodigoSelecionado/.cDescricaoSelecionada (nao cursor)
4509:     *==========================================================================
4510:     PROTECTED PROCEDURE AbrirLookupCanonico(par_cTabela, par_cCampoCod, par_cCampoDesc, ;
4511:             par_cTitulo, par_cValor, par_oCtrlCod, par_oCtrlDesc, par_cFiltro)
4512:         LOCAL loc_oBusca, loc_cCursorBusca, loc_lResultado, loc_cSQL, loc_nResult, loc_cWhere
4513:         loc_lResultado   = .F.
4514:         loc_cCursorBusca = "cursor_4c_LkpCanon"
4515: 
4516:         TRY
4517:             loc_cWhere = ""
4518:             IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
4519:                 loc_cWhere = " AND (" + par_cFiltro + ")"
4520:             ENDIF
4521: 
4522:             *-- Passo 1: busca exata via SQL no caller (DataSession=2)
4523:             loc_cSQL = "SELECT " + par_cCampoCod
4524:             IF !EMPTY(par_cCampoDesc) AND par_cCampoDesc != par_cCampoCod
4525:                 loc_cSQL = loc_cSQL + ", " + par_cCampoDesc
4526:             ENDIF
4527:             loc_cSQL = loc_cSQL + " FROM " + par_cTabela + ;
4528:                 " WHERE CAST(" + par_cCampoCod + " AS VARCHAR(50)) = " + ;
4529:                 EscaparSQL(UPPER(ALLTRIM(par_cValor))) + loc_cWhere
4530: 
4531:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorBusca)
4532: 
4533:             IF loc_nResult > 0 AND USED(loc_cCursorBusca) AND RECCOUNT(loc_cCursorBusca) = 1
4534:                 *-- Exato encontrado: popula controles diretamente
4535:                 SELECT (loc_cCursorBusca)
4536:                 IF VARTYPE(par_oCtrlCod) = "O"
4537:                     par_oCtrlCod.Value = ALLTRIM(&par_cCampoCod)
4538:                 ENDIF
4539:                 IF VARTYPE(par_oCtrlDesc) = "O" AND !EMPTY(par_cCampoDesc) ;
4540:                         AND par_cCampoDesc != par_cCampoCod
4541:                     par_oCtrlDesc.Value = ALLTRIM(&par_cCampoDesc)
4542:                 ENDIF
4543:                 loc_lResultado = .T.
4544:             ELSE
4545:                 *-- Nao encontrou exato: busca parcial para picker
4546:                 IF USED(loc_cCursorBusca)
4547:                     USE IN (loc_cCursorBusca)
4548:                 ENDIF
4549: 
4550:                 loc_cSQL = "SELECT " + par_cCampoCod

*-- Linhas 4578 a 4618:
4578:                 IF loc_nResult > 0 AND USED(loc_cCursorBusca) AND ;
4579:                         RECCOUNT(loc_cCursorBusca) > 0
4580:                     *-- Abre picker sem params (Pattern A canonico)
4581:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4582:                     IF VARTYPE(loc_oBusca) = "O"
4583:                         loc_oBusca.DefinirCursor(loc_cCursorBusca, par_cCampoCod, ;
4584:                             IIF(!EMPTY(par_cCampoDesc), par_cCampoDesc, par_cCampoCod), ;
4585:                             par_cTitulo)
4586:                         loc_oBusca.Mostrar()
4587:                         IF !EMPTY(loc_oBusca.cCodigoSelecionado)
4588:                             IF VARTYPE(par_oCtrlCod) = "O"
4589:                                 par_oCtrlCod.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
4590:                             ENDIF
4591:                             IF VARTYPE(par_oCtrlDesc) = "O" AND !EMPTY(par_cCampoDesc) ;
4592:                                     AND par_cCampoDesc != par_cCampoCod
4593:                                 par_oCtrlDesc.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
4594:                             ENDIF
4595:                             loc_lResultado = .T.
4596:                         ENDIF
4597:                         loc_oBusca.Release()
4598:                         loc_oBusca = .NULL.
4599:                     ENDIF
4600:                 ELSE
4601:                     MsgAviso("Nenhum registro encontrado em " + par_cTabela + ".", par_cTitulo)
4602:                 ENDIF
4603:             ENDIF
4604: 
4605:         CATCH TO loc_oErro
4606:             MsgErro("Erro no lookup " + par_cTitulo + ":" + CHR(13) + ;
4607:                 loc_oErro.Message + CHR(13) + ;
4608:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "AbrirLookupCanonico")
4609:         ENDTRY
4610: 
4611:         IF USED(loc_cCursorBusca)
4612:             USE IN (loc_cCursorBusca)
4613:         ENDIF
4614: 
4615:         RETURN loc_lResultado
4616:     ENDPROC
4617: 
4618: ENDDEFINE


### BO (C:\4c\projeto\app\classes\OptBO.prg):
*==============================================================================
* OptBO.prg - Business Object para Cadastro de Movimentacoes de Cheques
* Tabela: SigCdOpt | PK: operacaos
* Gerado: Fase 1/8 - Propriedades e Init
*==============================================================================

DEFINE CLASS OptBO AS BusinessBase

    *-- Identidade da entidade
    this_cTabela      = "SigCdOpt"
    this_cCampoChave  = "operacaos"

    *--------------------------------------------------------------------------
    * Propriedades - SigCdOpt (todas as colunas da tabela)
    *--------------------------------------------------------------------------
    *-- Identificacao / chave primaria
    this_cOperacaos   = ""    && operacaos  char(15)     - Codigo / chave primaria
    this_cDescrs      = ""    && descrs     char(20)     - Descricao
    this_cTipos       = ""    && tipos      char(2)      - Tipo (CR/DB/TR)

    *-- Operacoes relacionadas
    this_cOpAnts      = ""    && opants     char(15)     - Movimento anterior
    this_cOpEntradas  = ""    && opentradas char(15)     - Movimento de entrada
    this_cDopcs       = ""    && dopcs      char(20)     - Movimento de titulos (SIGOPOPE.Dopes)
    this_cDevolvidos  = ""    && devolvidos char(1)      - Operacao de devolvido (S/N)

    *-- Ordem e configuracao basica
    this_nOrdens      = 0     && ordens     numeric(1,0) - Ordem
    this_cOpAuts      = ""    && opauts     char(1)      - Movimento automatico (S/N)
    this_nTpDatas     = 0     && tpdatas    numeric(1,0) - Tipo de data contabil
    this_nDtContab    = 0     && dtcontab   numeric(1,0) - Data contabil option
    this_nDestinos    = 0     && destinos   numeric(1,0) - Destino option
    this_nOrigems     = 0     && origems    numeric(1,0) - Origem option

    *-- Grupo e Conta de Destino (contabilidade)
    this_cGruDeps     = ""    && grudeps    char(10)     - Grupo destino
    this_cConDeps     = ""    && condeps    char(10)     - Conta destino

    *-- Grupo e Conta de Origem (contabilidade - OS)
    this_cGrupoOs     = ""    && grupoos    char(10)     - Grupo origem
    this_cContaOs     = ""    && contaos    char(10)     - Conta origem

    *-- Grupo Terceiro (contabilidade)
    this_cGrupoT      = ""    && grupot     char(10)     - Grupo terceiro

    *-- Central de Credito
    this_cCCentrals   = ""    && ccentrals  char(2)      - Central de credito

    *-- Historico
    this_cHists       = ""    && hists      char(30)     - Historico padrao
    this_nTpHists     = 0     && tphists    numeric(1,0) - Tipo historico
    this_cHistClis    = ""    && histclis   char(1)      - Lanca historico cliente (S/N)

    *-- Responsavel e Emissor
    this_cRespons     = ""    && respons    char(10)     - Responsavel (conta contabil)
    this_cGruEmis     = ""    && gruemis    char(10)     - Grupo emissor default
    this_cEmpInds     = ""    && empinds    char(1)      - Empresa individual (S/N)
    this_cEmiInds     = ""    && emiinds    char(1)      - Emissor individual (S/N)
    this_cCademis     = ""    && cademis    char(1)      - Cadastra emissor (S/N)
    this_nTpEmiss     = 0     && tpemiss    numeric(1,0) - Tipo emissor option

    *-- Forma de Pagamento e Parcelas
    this_cFPags       = ""    && fpags      char(12)     - Condicao de pagamento
    this_cParcelas    = ""    && parcelas   char(1)      - Parcelas (S/N)

    *-- Pendencias e Valores
    this_cValPends    = ""    && valpends   char(1)      - Valor pendente emissor (S/N)
    this_cValPend2s   = ""    && valpend2s  char(1)      - Valor pendente deposito (S/N)
    this_cBxPends     = ""    && bxpends    char(1)      - Baixa pendencias (S/N)
    this_cVVectos     = ""    && vvectos    char(1)      - Verifica vencimento (S/N)
    this_cFazContas   = ""    && fazcontas  char(1)      - Lanca conta corrente (S/N)

    *-- Situacao e Observacao
    this_cSituas      = ""    && situas     char(3)      - Situacao do cliente
    this_cObs         = ""    && obs        char(1)      - Observacao (S/N/C)

    *-- Carta e Protocolo
    this_cEmiCarts    = ""    && emicarts   char(1)      - Emite carta (S/N)
    this_cEmiProts    = ""    && emiprots   char(1)      - Emite protocolo (S/N)
    this_cAlineas     = ""    && alineas    char(1)      - Tem alinea (S/N)

    *-- Leitura e Geracao
    this_nTpLeituras  = 0     && tpleituras numeric(1,0) - Tipo leitura de cheque
    this_nLeProts     = 0     && leprots    numeric(1,0) - Leitura protocolo option
    this_nGeranarqs   = 0     && geranarqs  numeric(1,0) - Gera numero arquivo option
    this_cGerCnabs    = ""    && gercnabs   char(1)      - Gera CNAB (S/N)
    this_cValidaChqs  = ""    && validachqs char(1)      - Valida cheques (S/N)

    *-- Data de Emissao
    this_nNdtEmiss    = 0     && ndtemiss   numeric(1,0) - Data emissao padrao option

    *-- Descontos e Comissao
    this_nDescontos   = 0     && descontos  numeric(4,2) - Percentual comissao
    this_nComiss      = 0     && comiss     numeric(1,0) - Calculo de comissao option
    this_nIndProds    = 0     && indprods   numeric(4,2) - Indicador de producao

    *-- Pendencias Financeiras e Situacao Global
    this_nPeFins      = 0     && pefins     numeric(1,0) - Pendencias financeiras option
    this_nAnaSits     = 0     && anasits    numeric(1,0) - Cons. global situacao option

    *-- Carteira e Prorrogacao
    this_nCartDbs     = 0     && cartdbs    numeric(1,0) - Carteira tipo (CR) option
    this_nProrrogas   = 0     && prorrogas  numeric(1,0) - Prorrogar tipo (CR) option
    this_cLimpCarts   = ""    && limpcarts  char(1)      - Limpa carteira (S/N)

    *-- Consolidacao e Alteracao
    this_cConsolidas  = ""    && consolidas char(1)      - Consolida lancamentos (S/N)
    this_nAltDados    = 0     && altdados   numeric(1,0) - Altera dados option

    *-- Vencimento e Moeda
    this_cCongvs      = ""    && congvs     char(1)      - Vencimento dia util (S/N)
    this_nVencUtil    = 0     && vencutil   numeric(1,0) - Vencimento dia util option
    this_cMoedas      = ""    && moedas     char(3)      - Moeda

    *-- Inativa
    this_nInativas    = 0     && inativas   numeric(1,0) - Inativa (0=Ativo, 1=Inativo)

    *-- Juros
    this_nChkJuros    = 0     && chkjuros   numeric(1,0) - Cobra juros option
    this_nPerJuros    = 0     && perjuros   numeric(4,2) - Percentual de juros
    this_nChkSmtJuro  = 0     && chksmtjuro numeric(1,0) - Somatorio de juros option

    *-- Configuracoes avancadas
    this_nImpChDev    = 0     && impchdev   numeric(1,0) - Imprime cheque devolvido option
    this_nLancCobr    = 0     && lanccobr   numeric(1,0) - Lanca cobranca option
    this_nAltConfSit  = 0     && altconfsit numeric(1,0) - Altera confirmacao situacao option
    this_cAltSituas   = ""    && altsituas  char(3)      - Altera situacao para
    this_nChkPortChq  = 0     && chkPortChq numeric(1,0) - Portador cheque option

    *-- Flags de fixacao de grupos/contas
    this_lFixGOrigs   = .F.   && fixgorigs  bit          - Fixa grupo origem
    this_lFixCOrigs   = .F.   && fixcorigs  bit          - Fixa conta origem
    this_lFixGDests   = .F.   && fixgdests  bit          - Fixa grupo destino
    this_lFixCDests   = .F.   && fixcdests  bit          - Fixa conta destino

    *-- Flags gerais
    this_lFlags       = .F.   && flags      bit          - Flag geral
    this_lLComis      = .F.   && lcomis     bit          - Lanca comissao flag

    *-- Cabecalho e Rodape (text/memo)
    this_cCabs        = ""    && cabs       text         - Cabecalho
    this_cRods        = ""    && rods       text         - Rodape

    *==========================================================================
    * Init - Configura tabela e campo chave
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdOpt"
        THIS.this_cCampoChave = "operacaos"
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cOperacaos)
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades a partir de cursor
    * REGRA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cOperacaos   = TratarNulo(Operacaos,  "C")
                THIS.this_cDescrs      = TratarNulo(Descrs,     "C")
                THIS.this_cTipos       = TratarNulo(Tipos,      "C")
                THIS.this_cOpAnts      = TratarNulo(OpAnts,     "C")
                THIS.this_cOpEntradas  = TratarNulo(OpEntradas, "C")
                THIS.this_cDopcs       = TratarNulo(Dopcs,      "C")
                THIS.this_cDevolvidos  = TratarNulo(Devolvidos, "C")
                THIS.this_nOrdens      = TratarNulo(Ordens,     "N")
                THIS.this_cOpAuts      = TratarNulo(OpAuts,     "C")
                THIS.this_nTpDatas     = TratarNulo(TpDatas,    "N")
                THIS.this_nDtContab    = TratarNulo(DtContab,   "N")
                THIS.this_nDestinos    = TratarNulo(Destinos,   "N")
                THIS.this_nOrigems     = TratarNulo(Origems,    "N")
                THIS.this_cGruDeps     = TratarNulo(GruDeps,    "C")
                THIS.this_cConDeps     = TratarNulo(ConDeps,    "C")
                THIS.this_cGrupoOs     = TratarNulo(GrupoOs,    "C")
                THIS.this_cContaOs     = TratarNulo(ContaOs,    "C")
                THIS.this_cGrupoT      = TratarNulo(GrupoT,     "C")
                THIS.this_cCCentrals   = TratarNulo(CCentrals,  "C")
                THIS.this_cHists       = TratarNulo(Hists,      "C")
                THIS.this_nTpHists     = TratarNulo(TpHists,    "N")
                THIS.this_cHistClis    = TratarNulo(HistClis,   "C")
                THIS.this_cRespons     = TratarNulo(Respons,    "C")
                THIS.this_cGruEmis     = TratarNulo(GruEmis,    "C")
                THIS.this_cEmpInds     = TratarNulo(EmpInds,    "C")
                THIS.this_cEmiInds     = TratarNulo(EmiInds,    "C")
                THIS.this_cCademis     = TratarNulo(Cademis,    "C")
                THIS.this_nTpEmiss     = TratarNulo(TpEmiss,    "N")
                THIS.this_cFPags       = TratarNulo(FPags,      "C")
                THIS.this_cParcelas    = TratarNulo(Parcelas,   "C")
                THIS.this_cValPends    = TratarNulo(ValPends,   "C")
                THIS.this_cValPend2s   = TratarNulo(ValPend2s,  "C")
                THIS.this_cBxPends     = TratarNulo(BxPends,    "C")
                THIS.this_cVVectos     = TratarNulo(VVectos,    "C")
                THIS.this_cFazContas   = TratarNulo(FazContas,  "C")
                THIS.this_cSituas      = TratarNulo(Situas,     "C")
                THIS.this_cObs         = TratarNulo(Obs,        "C")
                THIS.this_cEmiCarts    = TratarNulo(EmiCarts,   "C")
                THIS.this_cEmiProts    = TratarNulo(EmiProts,   "C")
                THIS.this_cAlineas     = TratarNulo(Alineas,    "C")
                THIS.this_nTpLeituras  = TratarNulo(TpLeituras, "N")
                THIS.this_nLeProts     = TratarNulo(LeProts,    "N")
                THIS.this_nGeranarqs   = TratarNulo(Geranarqs,  "N")
                THIS.this_cGerCnabs    = TratarNulo(GerCnabs,   "C")
                THIS.this_cValidaChqs  = TratarNulo(ValidaChqs, "C")
                THIS.this_nNdtEmiss    = TratarNulo(NdtEmiss,   "N")
                THIS.this_nDescontos   = TratarNulo(Descontos,  "N")
                THIS.this_nComiss      = TratarNulo(Comiss,     "N")
                THIS.this_nIndProds    = TratarNulo(IndProds,   "N")
                THIS.this_nPeFins      = TratarNulo(PeFins,     "N")
                THIS.this_nAnaSits     = TratarNulo(AnaSits,    "N")
                THIS.this_nCartDbs     = TratarNulo(CartDbs,    "N")
                THIS.this_nProrrogas   = TratarNulo(Prorrogas,  "N")
                THIS.this_cLimpCarts   = TratarNulo(LimpCarts,  "C")
                THIS.this_cConsolidas  = TratarNulo(Consolidas, "C")
                THIS.this_nAltDados    = TratarNulo(AltDados,   "N")
                THIS.this_cCongvs      = TratarNulo(Congvs,     "C")
                THIS.this_nVencUtil    = TratarNulo(VencUtil,   "N")
                THIS.this_cMoedas      = TratarNulo(Moedas,     "C")
                THIS.this_nInativas    = TratarNulo(Inativas,   "N")
                THIS.this_nChkJuros    = TratarNulo(ChkJuros,   "N")
                THIS.this_nPerJuros    = TratarNulo(PerJuros,   "N")
                THIS.this_nChkSmtJuro  = TratarNulo(ChkSmtJuro, "N")
                THIS.this_nImpChDev    = TratarNulo(ImpChDev,   "N")
                THIS.this_nLancCobr    = TratarNulo(LancCobr,   "N")
                THIS.this_nAltConfSit  = TratarNulo(AltConfSit, "N")
                THIS.this_cAltSituas   = TratarNulo(AltSituas,  "C")
                THIS.this_nChkPortChq  = TratarNulo(ChkPortChq, "N")
                IF VARTYPE(FixGOrigs) = "L"
                    THIS.this_lFixGOrigs = FixGOrigs
                ELSE
                    THIS.this_lFixGOrigs = (NVL(FixGOrigs, 0) = 1)
                ENDIF
                IF VARTYPE(FixCOrigs) = "L"
                    THIS.this_lFixCOrigs = FixCOrigs
                ELSE
                    THIS.this_lFixCOrigs = (NVL(FixCOrigs, 0) = 1)
                ENDIF
                IF VARTYPE(FixGDests) = "L"
                    THIS.this_lFixGDests = FixGDests
                ELSE
                    THIS.this_lFixGDests = (NVL(FixGDests, 0) = 1)
                ENDIF
                IF VARTYPE(FixCDests) = "L"
                    THIS.this_lFixCDests = FixCDests
                ELSE
                    THIS.this_lFixCDests = (NVL(FixCDests, 0) = 1)
                ENDIF
                IF VARTYPE(Flags) = "L"
                    THIS.this_lFlags = Flags
                ELSE
                    THIS.this_lFlags = (NVL(Flags, 0) = 1)
                ENDIF
                IF VARTYPE(LComis) = "L"
                    THIS.this_lLComis = LComis
                ELSE
                    THIS.this_lLComis = (NVL(LComis, 0) = 1)
                ENDIF
                IF TYPE("Cabs") != "U"
                    THIS.this_cCabs    = TratarNulo(Cabs, "C")
                ENDIF
                IF TYPE("Rods") != "U"
                    THIS.this_cRods    = TratarNulo(Rods, "C")
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar cursor:" + CHR(13) + loException.Message + ;
                " (Linha: " + TRANSFORM(loException.LineNo) + ")", "OptBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDados - Valida campos obrigatorios antes de salvar
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cOperacaos))
            MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cDescrs))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND !INLIST(UPPER(ALLTRIM(THIS.this_cTipos)), "CR", "DB", "TR")
            MsgAviso("Tipo inv" + CHR(225) + "lido! Use CR, DB ou TR.")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarCodigoExistente(THIS.this_cOperacaos)
                MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND ALLTRIM(THIS.this_cParcelas) = "S"
            IF UPPER(ALLTRIM(THIS.this_cTipos)) # "CR"
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o com Parcelas permite apenas CR.")
                loc_lValido = .F.
            ENDIF
            IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cOpEntradas))
                MsgAviso("Obrigat" + CHR(243) + "rio informar Opera" + CHR(231) + CHR(227) + "o de Entrada de Cheques.")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND INLIST(THIS.this_nComiss, 2, 3) AND THIS.this_nDescontos = 0
            MsgAviso("Percentual de Desconto/Recupera" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lido!")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * VerificarCodigoExistente - Verifica se operacaos ja existe no banco
    *==========================================================================
    PROCEDURE VerificarCodigoExistente(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdOpt" + ;
                " WHERE Operacaos = " + EscaparSQL(ALLTRIM(par_cCodigo))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkOpt")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkOpt")
                SELECT cursor_4c_ChkOpt
                loc_lExiste = (NVL(cursor_4c_ChkOpt.qtd, 0) > 0)
                USE IN cursor_4c_ChkOpt
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "OptBO.VerificarCodigoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *==========================================================================
    * Inserir - INSERT INTO SigCdOpt
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdOpt (" + ;
                "Operacaos, Descrs, Tipos, OpAnts, OpEntradas, Dopcs, Devolvidos," + ;
                " Ordens, OpAuts, TpDatas, DtContab, Destinos, Origems," + ;
                " GruDeps, ConDeps, GrupoOs, ContaOs, GrupoT, CCentrals," + ;
                " Hists, TpHists, HistClis, Respons, GruEmis, EmpInds, EmiInds," + ;
                " Cademis, TpEmiss, FPags, Parcelas," + ;
                " ValPends, ValPend2s, BxPends, VVectos, FazContas," + ;
                " Situas, Obs, EmiCarts, EmiProts, Alineas," + ;
                " TpLeituras, LeProts, Geranarqs, GerCnabs, ValidaChqs, NdtEmiss," + ;
                " Descontos, Comiss, IndProds, PeFins, AnaSits," + ;
                " CartDbs, Prorrogas, LimpCarts, Consolidas, AltDados," + ;
                " Congvs, VencUtil, Moedas, Inativas," + ;
                " ChkJuros, PerJuros, ChkSmtJuro, ImpChDev, LancCobr," + ;
                " AltConfSit, AltSituas, ChkPortChq," + ;
                " FixGOrigs, FixCOrigs, FixGDests, FixCDests, Flags, LComis," + ;
                " Cabs, Rods)" + ;
                " VALUES (" + ;
                EscaparSQL(ALLTRIM(THIS.this_cOperacaos)) + "," + ;
                EscaparSQL(THIS.this_cDescrs)             + "," + ;
                EscaparSQL(THIS.this_cTipos)              + "," + ;
                EscaparSQL(THIS.this_cOpAnts)             + "," + ;
                EscaparSQL(THIS.this_cOpEntradas)         + "," + ;
                EscaparSQL(THIS.this_cDopcs)              + "," + ;
                EscaparSQL(THIS.this_cDevolvidos)         + "," + ;
                FormatarNumeroSQL(THIS.this_nOrdens, 0)   + "," + ;
                EscaparSQL(THIS.this_cOpAuts)             + "," + ;
                FormatarNumeroSQL(THIS.this_nTpDatas, 0)  + "," + ;
                FormatarNumeroSQL(THIS.this_nDtContab, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nDestinos, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nOrigems, 0)  + "," + ;
                EscaparSQL(THIS.this_cGruDeps)            + "," + ;
                EscaparSQL(THIS.this_cConDeps)            + "," + ;
                EscaparSQL(THIS.this_cGrupoOs)            + "," + ;
                EscaparSQL(THIS.this_cContaOs)            + "," + ;
                EscaparSQL(THIS.this_cGrupoT)             + "," + ;
                EscaparSQL(THIS.this_cCCentrals)          + "," + ;
                EscaparSQL(THIS.this_cHists)              + "," + ;
                FormatarNumeroSQL(THIS.this_nTpHists, 0)  + "," + ;
                EscaparSQL(THIS.this_cHistClis)           + "," + ;
                EscaparSQL(THIS.this_cRespons)            + "," + ;
                EscaparSQL(THIS.this_cGruEmis)            + "," + ;
                EscaparSQL(THIS.this_cEmpInds)            + "," + ;
                EscaparSQL(THIS.this_cEmiInds)            + "," + ;
                EscaparSQL(THIS.this_cCademis)            + "," + ;
                FormatarNumeroSQL(THIS.this_nTpEmiss, 0)  + "," + ;
                EscaparSQL(THIS.this_cFPags)              + "," + ;
                EscaparSQL(THIS.this_cParcelas)           + "," + ;
                EscaparSQL(THIS.this_cValPends)           + "," + ;
                EscaparSQL(THIS.this_cValPend2s)          + "," + ;
                EscaparSQL(THIS.this_cBxPends)            + "," + ;
                EscaparSQL(THIS.this_cVVectos)            + "," + ;
                EscaparSQL(THIS.this_cFazContas)          + "," + ;
                EscaparSQL(THIS.this_cSituas)             + "," + ;
                EscaparSQL(THIS.this_cObs)                + "," + ;
                EscaparSQL(THIS.this_cEmiCarts)           + "," + ;
                EscaparSQL(THIS.this_cEmiProts)           + "," + ;
                EscaparSQL(THIS.this_cAlineas)            + "," + ;
                FormatarNumeroSQL(THIS.this_nTpLeituras, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nLeProts, 0)    + "," + ;
                FormatarNumeroSQL(THIS.this_nGeranarqs, 0)  + "," + ;
                EscaparSQL(THIS.this_cGerCnabs)           + "," + ;
                EscaparSQL(THIS.this_cValidaChqs)         + "," + ;
                FormatarNumeroSQL(THIS.this_nNdtEmiss, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nDescontos, 2) + "," + ;
                FormatarNumeroSQL(THIS.this_nComiss, 0)   + "," + ;
                FormatarNumeroSQL(THIS.this_nIndProds, 2) + "," + ;
                FormatarNumeroSQL(THIS.this_nPeFins, 0)   + "," + ;
                FormatarNumeroSQL(THIS.this_nAnaSits, 0)  + "," + ;
                FormatarNumeroSQL(THIS.this_nCartDbs, 0)  + "," + ;
                FormatarNumeroSQL(THIS.this_nProrrogas, 0) + "," + ;
                EscaparSQL(THIS.this_cLimpCarts)          + "," + ;
                EscaparSQL(THIS.this_cConsolidas)         + "," + ;
                FormatarNumeroSQL(THIS.this_nAltDados, 0) + "," + ;
                EscaparSQL(THIS.this_cCongvs)             + "," + ;
                FormatarNumeroSQL(THIS.this_nVencUtil, 0) + "," + ;
                EscaparSQL(THIS.this_cMoedas)             + "," + ;
                FormatarNumeroSQL(THIS.this_nInativas, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nChkJuros, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nPerJuros, 2) + "," + ;
                FormatarNumeroSQL(THIS.this_nChkSmtJuro, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nImpChDev, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nLancCobr, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nAltConfSit, 0) + "," + ;
                EscaparSQL(THIS.this_cAltSituas)          + "," + ;
                FormatarNumeroSQL(THIS.this_nChkPortChq, 0) + "," + ;
                FormatarNumeroSQL(IIF(THIS.this_lFixGOrigs, 1, 0), 0) + "," + ;
                FormatarNumeroSQL(IIF(THIS.this_lFixCOrigs, 1, 0), 0) + "," + ;
                FormatarNumeroSQL(IIF(THIS.this_lFixGDests, 1, 0), 0) + "," + ;
                FormatarNumeroSQL(IIF(THIS.this_lFixCDests, 1, 0), 0) + "," + ;
                FormatarNumeroSQL(IIF(THIS.this_lFlags,     1, 0), 0) + "," + ;
                FormatarNumeroSQL(IIF(THIS.this_lLComis,    1, 0), 0) + "," + ;
                EscaparSQL(THIS.this_cCabs)               + "," + ;
                EscaparSQL(THIS.this_cRods)               + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message + ;
                " (Linha: " + TRANSFORM(loException.LineNo) + ")", "OptBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE SigCdOpt
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdOpt SET" + ;
                " Descrs      = " + EscaparSQL(THIS.this_cDescrs)              + "," + ;
                " Tipos       = " + EscaparSQL(THIS.this_cTipos)               + "," + ;
                " OpAnts      = " + EscaparSQL(THIS.this_cOpAnts)              + "," + ;
                " OpEntradas  = " + EscaparSQL(THIS.this_cOpEntradas)          + "," + ;
                " Dopcs       = " + EscaparSQL(THIS.this_cDopcs)               + "," + ;
                " Devolvidos  = " + EscaparSQL(THIS.this_cDevolvidos)          + "," + ;
                " Ordens      = " + FormatarNumeroSQL(THIS.this_nOrdens, 0)    + "," + ;
                " OpAuts      = " + EscaparSQL(THIS.this_cOpAuts)              + "," + ;
                " TpDatas     = " + FormatarNumeroSQL(THIS.this_nTpDatas, 0)   + "," + ;
                " DtContab    = " + FormatarNumeroSQL(THIS.this_nDtContab, 0)  + "," + ;
                " Destinos    = " + FormatarNumeroSQL(THIS.this_nDestinos, 0)  + "," + ;
                " Origems     = " + FormatarNumeroSQL(THIS.this_nOrigems, 0)   + "," + ;
                " GruDeps     = " + EscaparSQL(THIS.this_cGruDeps)             + "," + ;
                " ConDeps     = " + EscaparSQL(THIS.this_cConDeps)             + "," + ;
                " GrupoOs     = " + EscaparSQL(THIS.this_cGrupoOs)             + "," + ;
                " ContaOs     = " + EscaparSQL(THIS.this_cContaOs)             + "," + ;
                " GrupoT      = " + EscaparSQL(THIS.this_cGrupoT)              + "," + ;
                " CCentrals   = " + EscaparSQL(THIS.this_cCCentrals)           + "," + ;
                " Hists       = " + EscaparSQL(THIS.this_cHists)               + "," + ;
                " TpHists     = " + FormatarNumeroSQL(THIS.this_nTpHists, 0)   + "," + ;
                " HistClis    = " + EscaparSQL(THIS.this_cHistClis)            + "," + ;
                " Respons     = " + EscaparSQL(THIS.this_cRespons)             + "," + ;
                " GruEmis     = " + EscaparSQL(THIS.this_cGruEmis)             + "," + ;
                " EmpInds     = " + EscaparSQL(THIS.this_cEmpInds)             + "," + ;
                " EmiInds     = " + EscaparSQL(THIS.this_cEmiInds)             + "," + ;
                " Cademis     = " + EscaparSQL(THIS.this_cCademis)             + "," + ;
                " TpEmiss     = " + FormatarNumeroSQL(THIS.this_nTpEmiss, 0)   + "," + ;
                " FPags       = " + EscaparSQL(THIS.this_cFPags)               + "," + ;
                " Parcelas    = " + EscaparSQL(THIS.this_cParcelas)            + "," + ;
                " ValPends    = " + EscaparSQL(THIS.this_cValPends)            + "," + ;
                " ValPend2s   = " + EscaparSQL(THIS.this_cValPend2s)           + "," + ;
                " BxPends     = " + EscaparSQL(THIS.this_cBxPends)             + "," + ;
                " VVectos     = " + EscaparSQL(THIS.this_cVVectos)             + "," + ;
                " FazContas   = " + EscaparSQL(THIS.this_cFazContas)           + "," + ;
                " Situas      = " + EscaparSQL(THIS.this_cSituas)              + "," + ;
                " Obs         = " + EscaparSQL(THIS.this_cObs)                 + "," + ;
                " EmiCarts    = " + EscaparSQL(THIS.this_cEmiCarts)            + "," + ;
                " EmiProts    = " + EscaparSQL(THIS.this_cEmiProts)            + "," + ;
                " Alineas     = " + EscaparSQL(THIS.this_cAlineas)             + "," + ;
                " TpLeituras  = " + FormatarNumeroSQL(THIS.this_nTpLeituras, 0) + "," + ;
                " LeProts     = " + FormatarNumeroSQL(THIS.this_nLeProts, 0)   + "," + ;
                " Geranarqs   = " + FormatarNumeroSQL(THIS.this_nGeranarqs, 0) + "," + ;
                " GerCnabs    = " + EscaparSQL(THIS.this_cGerCnabs)            + "," + ;
                " ValidaChqs  = " + EscaparSQL(THIS.this_cValidaChqs)          + "," + ;
                " NdtEmiss    = " + FormatarNumeroSQL(THIS.this_nNdtEmiss, 0)  + "," + ;
                " Descontos   = " + FormatarNumeroSQL(THIS.this_nDescontos, 2) + "," + ;
                " Comiss      = " + FormatarNumeroSQL(THIS.this_nComiss, 0)    + "," + ;
                " IndProds    = " + FormatarNumeroSQL(THIS.this_nIndProds, 2)  + "," + ;
                " PeFins      = " + FormatarNumeroSQL(THIS.this_nPeFins, 0)    + "," + ;
                " AnaSits     = " + FormatarNumeroSQL(THIS.this_nAnaSits, 0)   + "," + ;
                " CartDbs     = " + FormatarNumeroSQL(THIS.this_nCartDbs, 0)   + "," + ;
                " Prorrogas   = " + FormatarNumeroSQL(THIS.this_nProrrogas, 0) + "," + ;
                " LimpCarts   = " + EscaparSQL(THIS.this_cLimpCarts)           + "," + ;
                " Consolidas  = " + EscaparSQL(THIS.this_cConsolidas)          + "," + ;
                " AltDados    = " + FormatarNumeroSQL(THIS.this_nAltDados, 0)  + "," + ;
                " Congvs      = " + EscaparSQL(THIS.this_cCongvs)              + "," + ;
                " VencUtil    = " + FormatarNumeroSQL(THIS.this_nVencUtil, 0)  + "," + ;
                " Moedas      = " + EscaparSQL(THIS.this_cMoedas)              + "," + ;
                " Inativas    = " + FormatarNumeroSQL(THIS.this_nInativas, 0)  + "," + ;
                " ChkJuros    = " + FormatarNumeroSQL(THIS.this_nChkJuros, 0)  + "," + ;
                " PerJuros    = " + FormatarNumeroSQL(THIS.this_nPerJuros, 2)  + "," + ;
                " ChkSmtJuro  = " + FormatarNumeroSQL(THIS.this_nChkSmtJuro, 0) + "," + ;
                " ImpChDev    = " + FormatarNumeroSQL(THIS.this_nImpChDev, 0)  + "," + ;
                " LancCobr    = " + FormatarNumeroSQL(THIS.this_nLancCobr, 0)  + "," + ;
                " AltConfSit  = " + FormatarNumeroSQL(THIS.this_nAltConfSit, 0) + "," + ;
                " AltSituas   = " + EscaparSQL(THIS.this_cAltSituas)           + "," + ;
                " ChkPortChq  = " + FormatarNumeroSQL(THIS.this_nChkPortChq, 0) + "," + ;
                " FixGOrigs   = " + FormatarNumeroSQL(IIF(THIS.this_lFixGOrigs, 1, 0), 0) + "," + ;
                " FixCOrigs   = " + FormatarNumeroSQL(IIF(THIS.this_lFixCOrigs, 1, 0), 0) + "," + ;
                " FixGDests   = " + FormatarNumeroSQL(IIF(THIS.this_lFixGDests, 1, 0), 0) + "," + ;
                " FixCDests   = " + FormatarNumeroSQL(IIF(THIS.this_lFixCDests, 1, 0), 0) + "," + ;
                " Flags       = " + FormatarNumeroSQL(IIF(THIS.this_lFlags,     1, 0), 0) + "," + ;
                " LComis      = " + FormatarNumeroSQL(IIF(THIS.this_lLComis,    1, 0), 0) + "," + ;
                " Cabs        = " + EscaparSQL(THIS.this_cCabs)                + "," + ;
                " Rods        = " + EscaparSQL(THIS.this_cRods)                + ;
                " WHERE Operacaos = " + EscaparSQL(ALLTRIM(THIS.this_cOperacaos))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message + ;
                " (Linha: " + TRANSFORM(loException.LineNo) + ")", "OptBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - DELETE FROM SigCdOpt (verifica uso em lancamentos)
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nUso
        loc_lSucesso = .F.
        loc_nUso     = 0

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SIGCQDEV" + ;
                " WHERE Operacaos = " + EscaparSQL(ALLTRIM(THIS.this_cOperacaos))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkUso")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkUso")
                SELECT cursor_4c_ChkUso
                loc_nUso = NVL(cursor_4c_ChkUso.qtd, 0)
                USE IN cursor_4c_ChkUso
            ENDIF

            IF loc_nUso > 0
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o utilizada em lan" + CHR(231) + "amentos e n" + CHR(227) + "o pode ser exclu" + CHR(237) + "da!")
            ELSE
                loc_cSQL = "DELETE FROM SigCdOpt" + ;
                    " WHERE Operacaos = " + EscaparSQL(ALLTRIM(THIS.this_cOperacaos))
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao excluir:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message + ;
                " (Linha: " + TRANSFORM(loException.LineNo) + ")", "OptBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - Lista movimentacoes de cheques para o grid
    * par_cFiltro: "" = todos | expressao SQL WHERE adicional
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (Operacaos C(15), Tipos C(2), ;
                        OpAnts C(15), GrupoOs C(10), ContaOs C(10), ;
                        GruDeps C(10), ConDeps C(10), ValPends C(1))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cWhere = ""
                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                    loc_cWhere = " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = "SELECT a.Operacaos, a.Tipos, a.OpAnts," + ;
                    " a.GrupoOs, a.ContaOs, a.GruDeps, a.ConDeps, a.ValPends" + ;
                    " FROM SigCdOpt a" + ;
                    loc_cWhere + ;
                    " ORDER BY a.Operacaos"

                IF USED("cursor_4c_Dados")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT cursor_4c_Dados
                        ZAP
                        SET NULL ON
                        IF RECCOUNT("cursor_4c_DadosTmp") > 0
                            APPEND FROM DBF("cursor_4c_DadosTmp")
                        ENDIF
                        SET NULL OFF
                        IF USED("cursor_4c_DadosTmp")
                            USE IN cursor_4c_DadosTmp
                        ENDIF
                        GO TOP IN cursor_4c_Dados
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar:" + CHR(13) + CapturarErroSQL(), "OptBO.Buscar")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        GO TOP IN cursor_4c_Dados
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar:" + CHR(13) + CapturarErroSQL(), "OptBO.Buscar")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message + ;
                " (Linha: " + TRANSFORM(loException.LineNo) + ")", "OptBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro completo por PK
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT * FROM SigCdOpt" + ;
                " WHERE Operacaos = " + EscaparSQL(ALLTRIM(par_cCodigo))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND USED("cursor_4c_Carrega")
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Registro n" + CHR(227) + "o encontrado!")
                ENDIF
                USE IN cursor_4c_Carrega
            ELSE
                MostrarErro("Erro ao carregar registro:" + CHR(13) + CapturarErroSQL(), "OptBO.CarregarPorCodigo")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message + ;
                " (Linha: " + TRANSFORM(loException.LineNo) + ")", "OptBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarDescGrupoContab - Retorna descricao de grupo contabil (SigCdGcr)
    *==========================================================================
    PROCEDURE BuscarDescGrupoContab(par_cCodigo)
        LOCAL loc_cDesc, loc_nResult
        loc_cDesc = ""

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(ALLTRIM(par_cCodigo)), ;
                "cursor_4c_DescGrpCtb")
            IF loc_nResult > 0 AND USED("cursor_4c_DescGrpCtb") AND RECCOUNT("cursor_4c_DescGrpCtb") > 0
                SELECT cursor_4c_DescGrpCtb
                loc_cDesc = ALLTRIM(NVL(cursor_4c_DescGrpCtb.Descrs, ""))
            ENDIF
        CATCH TO loException
            MostrarErro(loException.Message, "OptBO.BuscarDescGrupoContab")
        ENDTRY

        IF USED("cursor_4c_DescGrpCtb")
            USE IN cursor_4c_DescGrpCtb
        ENDIF

        RETURN loc_cDesc
    ENDPROC

    *==========================================================================
    * BuscarDescContaContab - Retorna descricao de conta contabil
    *==========================================================================
    PROCEDURE BuscarDescContaContab(par_cGrupo, par_cConta)
        LOCAL loc_cDesc, loc_nResult
        loc_cDesc = ""

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(ALLTRIM(par_cConta)), ;
                "cursor_4c_DescCtaCli")
            IF loc_nResult > 0 AND USED("cursor_4c_DescCtaCli") AND RECCOUNT("cursor_4c_DescCtaCli") > 0
                SELECT cursor_4c_DescCtaCli
                loc_cDesc = ALLTRIM(NVL(cursor_4c_DescCtaCli.Rclis, ""))
            ENDIF
        CATCH TO loException
            MostrarErro(loException.Message, "OptBO.BuscarDescContaContab")
        ENDTRY

        IF USED("cursor_4c_DescCtaCli")
            USE IN cursor_4c_DescCtaCli
        ENDIF

        RETURN loc_cDesc
    ENDPROC

    *==========================================================================
    * BuscarDescCentral - Retorna descricao da central de credito (SIGCCCCO)
    *==========================================================================
    PROCEDURE BuscarDescCentral(par_cCodigo)
        LOCAL loc_cDesc, loc_nResult
        loc_cDesc = ""

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Descs FROM SIGCCCCO WHERE Cods = " + EscaparSQL(ALLTRIM(par_cCodigo)), ;
                "cursor_4c_DescCentral")
            IF loc_nResult > 0 AND USED("cursor_4c_DescCentral") AND RECCOUNT("cursor_4c_DescCentral") > 0
                SELECT cursor_4c_DescCentral
                loc_cDesc = ALLTRIM(NVL(cursor_4c_DescCentral.Descs, ""))
            ENDIF
        CATCH TO loException
            MostrarErro(loException.Message, "OptBO.BuscarDescCentral")
        ENDTRY

        IF USED("cursor_4c_DescCentral")
            USE IN cursor_4c_DescCentral
        ENDIF

        RETURN loc_cDesc
    ENDPROC

    *==========================================================================
    * BuscarDescSituacao - Retorna descricao de situacao do cliente (SigCdCst)
    *==========================================================================
    PROCEDURE BuscarDescSituacao(par_cCodigo)
        LOCAL loc_cDesc, loc_nResult
        loc_cDesc = ""

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Descrs FROM SigCdCst WHERE Codigos = " + EscaparSQL(ALLTRIM(par_cCodigo)) + ;
                " AND Priors BETWEEN 1 AND 998", ;
                "cursor_4c_DescSit")
            IF loc_nResult > 0 AND USED("cursor_4c_DescSit") AND RECCOUNT("cursor_4c_DescSit") > 0
                SELECT cursor_4c_DescSit
                loc_cDesc = ALLTRIM(NVL(cursor_4c_DescSit.Descrs, ""))
            ENDIF
        CATCH TO loException
            MostrarErro(loException.Message, "OptBO.BuscarDescSituacao")
        ENDTRY

        IF USED("cursor_4c_DescSit")
            USE IN cursor_4c_DescSit
        ENDIF

        RETURN loc_cDesc
    ENDPROC

    *==========================================================================
    * BuscarDescMoeda - Retorna descricao de moeda (SigCdMoe)
    *==========================================================================
    PROCEDURE BuscarDescMoeda(par_cCodigo)
        LOCAL loc_cDesc, loc_nResult
        loc_cDesc = ""

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT DMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(ALLTRIM(par_cCodigo)), ;
                "cursor_4c_DescMoe")
            IF loc_nResult > 0 AND USED("cursor_4c_DescMoe") AND RECCOUNT("cursor_4c_DescMoe") > 0
                SELECT cursor_4c_DescMoe
                loc_cDesc = ALLTRIM(NVL(cursor_4c_DescMoe.DMoes, ""))
            ENDIF
        CATCH TO loException
            MostrarErro(loException.Message, "OptBO.BuscarDescMoeda")
        ENDTRY

        IF USED("cursor_4c_DescMoe")
            USE IN cursor_4c_DescMoe
        ENDIF

        RETURN loc_cDesc
    ENDPROC

    *==========================================================================
    * BuscarOpContas - Busca operacoes de titulo (SIGOPOPE) para lookup Mov.Titulos
    *==========================================================================
    PROCEDURE BuscarOpContas(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Dopes, Descrs FROM SIGOPOPE WHERE Congvs = 1" + ;
                " ORDER BY Dopes"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaOpContas")
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException.Message, "OptBO.BuscarOpContas")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarCondicaoPagamento - Busca condicoes de pagamento (SigOpFp)
    *==========================================================================
    PROCEDURE BuscarCondicaoPagamento(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT FPags, Descrs FROM SigOpFp" + ;
                " WHERE Infos = 'C' AND EmiChqs <> 1" + ;
                " ORDER BY FPags"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaFpg")
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException.Message, "OptBO.BuscarCondicaoPagamento")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

