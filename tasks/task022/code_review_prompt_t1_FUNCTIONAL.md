# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (8)
- [BINDEVENT-PARAMS] Handler 'ValidarGrupoAcess' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarGrupoAcess(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarUsuarioAcess' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarUsuarioAcess(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarGrContab' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarGrContab(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarDGrContab' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarDGrContab(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarGrConta' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarGrConta(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarDGrConta' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarDGrConta(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarCdConta' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarCdConta(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarDConta' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarDConta(par_nKeyCode, par_nShiftAltCtrl)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormSIGACGCT.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1877 linhas total):

*-- Linhas 33 a 153:
33:     *==========================================================================
34:     * Init
35:     *==========================================================================
36:     PROCEDURE Init()
37:         RETURN DODEFAULT()
38:     ENDPROC
39: 
40:     *==========================================================================
41:     * InicializarForm - Configuracao inicial do formulario
42:     *==========================================================================
43:     PROTECTED PROCEDURE InicializarForm()
44:         LOCAL loc_lSucesso
45:         loc_lSucesso = .F.
46: 
47:         TRY
48:             THIS.Caption = "Acesso  Lan" + CHR(231) + "amentos"
49: 
50:             THIS.this_oBusinessObject = CREATEOBJECT("SIGACGCTBO")
51: 
52:             IF VARTYPE(THIS.this_oBusinessObject) # "O"
53:                 MostrarErro("Erro ao criar Business Object SIGACGCTBO", "Erro Cr" + CHR(237) + "tico")
54:             ELSE
55:                 THIS.ConfigurarPageFrame()
56:                 THIS.ConfigurarPaginaLista()
57:                 THIS.ConfigurarPaginaDados()
58: 
59:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
60: 
61:                 IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
62:                     IF !THIS.CarregarLista()
63:                         *-- Falha ao carregar nao impede abertura
64:                     ENDIF
65:                 ENDIF
66: 
67:                 THIS.pgf_4c_Paginas.Visible  = .T.
68:                 THIS.pgf_4c_Paginas.ActivePage = 1
69:                 THIS.this_cModoAtual = "LISTA"
70:                 loc_lSucesso = .T.
71:             ENDIF
72: 
73:         CATCH TO loException
74:             THIS.this_cMensagemErro = "Linha: " + TRANSFORM(loException.LineNo) + " - " + loException.Message
75:             MostrarErro("Erro ao inicializar FormSIGACGCT:" + CHR(13) + THIS.this_cMensagemErro, "Erro")
76:             loc_lSucesso = .F.
77:         ENDTRY
78: 
79:         RETURN loc_lSucesso
80:     ENDPROC
81: 
82:     *==========================================================================
83:     * ConfigurarPageFrame - Configura PageFrame principal
84:     * PageFrame.Top = -29 (oculta abas), compensar +29 nos containers
85:     *==========================================================================
86:     PROTECTED PROCEDURE ConfigurarPageFrame()
87:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
88: 
89:         WITH THIS.pgf_4c_Paginas
90:             .Top       = -29
91:             .Left      = 0
92:             .Width     = 1003
93:             .Height    = 629
94:             .PageCount = 2
95:             .Tabs      = .F.
96:             .Visible   = .T.
97: 
98:             .Page1.Caption   = "Lista"
99:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
100:             .Page1.BackColor = RGB(255, 255, 255)
101: 
102:             .Page2.Caption   = "Dados"
103:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
104:             .Page2.BackColor = RGB(255, 255, 255)
105:         ENDWITH
106:     ENDPROC
107: 
108:     *==========================================================================
109:     * ConfigurarPaginaLista - Configura Page1 (Lista)
110:     * Compensacao PageFrame.Top=-29: todos os controles Top += 29
111:     * cntSombra.Top=2 -> 31 | Grupo_Op.Top=0 -> 29 | Grupo_Saida can?nico
112:     *==========================================================================
113:     PROTECTED PROCEDURE ConfigurarPaginaLista()
114:         LOCAL loc_oPagina
115:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
116: 
117:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
118:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
119: 
120:         *-- Container de cabecalho (cntSombra: Top=2 -> 31)
121:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
122:         WITH loc_oPagina.cnt_4c_Cabecalho
123:             .Top         = 31
124:             .Left        = 0
125:             .Width       = 1003
126:             .Height      = 80
127:             .BackStyle   = 0
128:             .BorderWidth = 0
129:             .Visible     = .T.
130:         ENDWITH
131: 
132:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
133:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
134:             .Caption   = "Acesso  Lan" + CHR(231) + "amentos"
135:             .Top       = 20
136:             .Left      = 20
137:             .Width     = 400
138:             .Height    = 30
139:             .FontName  = "Tahoma"
140:             .FontSize  = 14
141:             .FontBold  = .T.
142:             .BackStyle = 0
143:             .ForeColor = RGB(90, 90, 90)
144:             .Visible   = .T.
145:         ENDWITH
146: 
147:         *-- Container de botoes CRUD (Grupo_Op: Left=544, Top=0 -> 29)
148:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
149:         WITH loc_oPagina.cnt_4c_Botoes
150:             .Top         = 29
151:             .Left        =  542
152:             .Width       = 390
153:             .Height      = 85

*-- Linhas 177 a 444:
177:             .WordWrap        = .T.
178:             .Visible         = .T.
179:         ENDWITH
180:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
181: 
182:         *-- Botao Visualizar (Left=80)
183:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
184:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
185:             .Caption         = "Visualizar"
186:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
187:             .PicturePosition = 13
188:             .Top             = 5
189:             .Left            = 80
190:             .Width           = 75
191:             .Height          = 75
192:             .FontName        = "Comic Sans MS"
193:             .FontSize        = 8
194:             .FontBold        = .T.
195:             .FontItalic      = .T.
196:             .Themes          = .F.
197:             .SpecialEffect   = 0
198:             .BackColor       = RGB(255, 255, 255)
199:             .ForeColor       = RGB(90, 90, 90)
200:             .WordWrap        = .T.
201:             .Visible         = .T.
202:         ENDWITH
203:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
204: 
205:         *-- Botao Alterar (Left=155)
206:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
207:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
208:             .Caption         = "Alterar"
209:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
210:             .PicturePosition = 13
211:             .Top             = 5
212:             .Left            = 155
213:             .Width           = 75
214:             .Height          = 75
215:             .FontName        = "Comic Sans MS"
216:             .FontSize        = 8
217:             .FontBold        = .T.
218:             .FontItalic      = .T.
219:             .Themes          = .F.
220:             .SpecialEffect   = 0
221:             .BackColor       = RGB(255, 255, 255)
222:             .ForeColor       = RGB(90, 90, 90)
223:             .WordWrap        = .T.
224:             .Visible         = .T.
225:         ENDWITH
226:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
227: 
228:         *-- Botao Excluir (Left=230)
229:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
230:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
231:             .Caption         = "Excluir"
232:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
233:             .PicturePosition = 13
234:             .Top             = 5
235:             .Left            = 230
236:             .Width           = 75
237:             .Height          = 75
238:             .FontName        = "Comic Sans MS"
239:             .FontSize        = 8
240:             .FontBold        = .T.
241:             .FontItalic      = .T.
242:             .Themes          = .F.
243:             .SpecialEffect   = 0
244:             .BackColor       = RGB(255, 255, 255)
245:             .ForeColor       = RGB(90, 90, 90)
246:             .WordWrap        = .T.
247:             .Visible         = .T.
248:         ENDWITH
249:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
250: 
251:         *-- Botao Buscar (Left=305)
252:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
253:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
254:             .Caption         = "Buscar"
255:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
256:             .PicturePosition = 13
257:             .Top             = 5
258:             .Left            = 305
259:             .Width           = 75
260:             .Height          = 75
261:             .FontName        = "Comic Sans MS"
262:             .FontSize        = 8
263:             .FontBold        = .T.
264:             .FontItalic      = .T.
265:             .Themes          = .F.
266:             .SpecialEffect   = 0
267:             .BackColor       = RGB(255, 255, 255)
268:             .ForeColor       = RGB(90, 90, 90)
269:             .WordWrap        = .T.
270:             .Visible         = .T.
271:         ENDWITH
272:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
273: 
274:         *-- Container canonico de saida (Grupo_Saida: Left=917, Top=0 -> 29)
275:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
276:         WITH loc_oPagina.cnt_4c_Saida
277:             .Top         = 29
278:             .Left        = 917
279:             .Width       = 90
280:             .Height      = 85
281:             .BackStyle   = 0
282:             .BorderWidth = 0
283:             .Visible     = .T.
284:         ENDWITH
285: 
286:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
287:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
288:             .Caption         = "Encerrar"
289:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
290:             .PicturePosition = 13
291:             .Width           = 75
292:             .Height          = 75
293:             .Left            = 5
294:             .Top             = 5
295:             .FontName        = "Comic Sans MS"
296:             .FontSize        = 8
297:             .FontBold        = .T.
298:             .FontItalic      = .T.
299:             .Themes          = .F.
300:             .SpecialEffect   = 0
301:             .BackColor       = RGB(255, 255, 255)
302:             .ForeColor       = RGB(90, 90, 90)
303:             .Visible         = .T.
304:         ENDWITH
305:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
306: 
307:         *-- Grid de lista (Grade: Top=117, Left=26, Width=890, Height=455)
308:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
309:         WITH loc_oPagina.grd_4c_Lista
310:             .Top                = 117
311:             .Left               = 26
312:             .Width              = 890
313:             .Height             = 455
314:             .ColumnCount        = 5
315:             .FontName           = "Verdana"
316:             .FontSize           = 8
317:             .ForeColor          = RGB(90, 90, 90)
318:             .BackColor          = RGB(255, 255, 255)
319:             .GridLineColor      = RGB(238, 238, 238)
320:             .GridLines          = 3
321:             .HighlightBackColor = RGB(255, 255, 255)
322:             .HighlightForeColor = RGB(15, 41, 104)
323:             .HighlightStyle     = 2
324:             .DeleteMark         = .F.
325:             .RecordMark         = .F.
326:             .RowHeight          = 16
327:             .ScrollBars         = 2
328:             .ReadOnly           = .T.
329:             .Visible            = .T.
330:         ENDWITH
331: 
332:         THIS.TornarControlesVisiveis(loc_oPagina)
333:     ENDPROC
334: 
335:     *==========================================================================
336:     * ConfigurarPaginaDados - Configura Page2 (Dados)
337:     * Compensacao PageFrame.Top=-29: todos os controles Top += 29
338:     * Fase 5/8: Botoes + Secao Usuario + Secao Grupo Contabil
339:     *==========================================================================
340:     PROTECTED PROCEDURE ConfigurarPaginaDados()
341:         LOCAL loc_oPagina
342:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
343: 
344:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
345:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
346: 
347:         *-- Container de botoes de acao (Grupo_Salva: Left=842, Top=4 -> 33)
348:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
349:         WITH loc_oPagina.cnt_4c_BotoesAcao
350:             .Top         = 33
351:             .Left        = 842
352:             .Width       = 160
353:             .Height      = 85
354:             .BackStyle   = 0
355:             .BorderWidth = 0
356:             .Visible     = .T.
357:         ENDWITH
358: 
359:         *-- Botao Confirmar (Salvar)
360:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
361:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
362:             .Caption         = "Confirmar"
363:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
364:             .PicturePosition = 13
365:             .Top             = 5
366:             .Left            = 5
367:             .Width           = 75
368:             .Height          = 75
369:             .FontName        = "Comic Sans MS"
370:             .FontSize        = 8
371:             .FontBold        = .T.
372:             .FontItalic      = .T.
373:             .Themes          = .F.
374:             .SpecialEffect   = 0
375:             .BackColor       = RGB(255, 255, 255)
376:             .ForeColor       = RGB(90, 90, 90)
377:             .WordWrap        = .T.
378:             .Enabled         = .F.
379:             .Visible         = .T.
380:         ENDWITH
381:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
382: 
383:         *-- Botao Cancelar
384:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
385:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
386:             .Caption         = "Encerrar"
387:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
388:             .PicturePosition = 13
389:             .Top             = 5
390:             .Left            = 80
391:             .Width           = 75
392:             .Height          = 75
393:             .FontName        = "Comic Sans MS"
394:             .FontSize        = 8
395:             .FontBold        = .T.
396:             .FontItalic      = .T.
397:             .Themes          = .F.
398:             .SpecialEffect   = 0
399:             .BackColor       = RGB(255, 255, 255)
400:             .ForeColor       = RGB(90, 90, 90)
401:             .WordWrap        = .T.
402:             .Visible         = .T.
403:         ENDWITH
404:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
405: 
406:         *======================================================================
407:         * SECAO USUARIO
408:         * Say2("Usuario"): top=105+29=134 | Shape1: top=122+29=151
409:         * Get_Grupo: top=126+29=155 | Get_Usuario: top=150+29=179
410:         *======================================================================
411: 
412:         *-- Shape1 - separador horizontal da secao Usuario (top=122+29=151)
413:         loc_oPagina.AddObject("shp_4c_Shape1", "Shape")
414:         WITH loc_oPagina.shp_4c_Shape1
415:             .Top         = 151
416:             .Left        = 159
417:             .Width       = 151
418:             .Height      = 2
419:             .BackColor   = RGB(90, 90, 90)
420:             .BorderColor = RGB(90, 90, 90)
421:             .Visible     = .T.
422:         ENDWITH
423: 
424:         *-- Label "Usuario" - titulo da secao (Say2: top=105+29=134)
425:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
426:         WITH loc_oPagina.lbl_4c_Label2
427:             .Caption   = "Usu" + CHR(225) + "rio"
428:             .Top       = 134
429:             .Left      = 166
430:             .AutoSize  = .T.
431:             .FontName  = "Tahoma"
432:             .FontSize  = 8
433:             .FontBold  = .T.
434:             .BackStyle = 0
435:             .ForeColor = RGB(90, 90, 90)
436:             .Visible   = .T.
437:         ENDWITH
438: 
439:         *-- Label "Grupo :" para campo txt_4c_Grupo (Say1: top=129+29=158)
440:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
441:         WITH loc_oPagina.lbl_4c_Label1
442:             .Caption   = "Grupo : "
443:             .Top       = 158
444:             .Left      = 175

*-- Linhas 465 a 539:
465:             .Enabled   = .F.
466:             .Visible   = .T.
467:         ENDWITH
468:         BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress", THIS, "ValidarGrupoAcess")
469: 
470:         *-- Label "Nome :" para campo txt_4c_Usuario (Say3: top=154+29=183)
471:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
472:         WITH loc_oPagina.lbl_4c_Label3
473:             .Caption   = "Nome : "
474:             .Top       = 183
475:             .Left      = 177
476:             .AutoSize  = .T.
477:             .FontName  = "Tahoma"
478:             .FontSize  = 8
479:             .BackStyle = 0
480:             .ForeColor = RGB(90, 90, 90)
481:             .Visible   = .T.
482:         ENDWITH
483: 
484:         *-- TextBox Get_Usuario (txt_4c_Usuario: top=150+29=179, left=223, width=80)
485:         loc_oPagina.AddObject("txt_4c_Usuario", "TextBox")
486:         WITH loc_oPagina.txt_4c_Usuario
487:             .Value     = ""
488:             .Top       = 179
489:             .Left      = 223
490:             .Width     = 80
491:             .Height    = 23
492:             .FontName  = "Tahoma"
493:             .FontSize  = 8
494:             .ForeColor = RGB(90, 90, 90)
495:             .BackColor = RGB(255, 255, 255)
496:             .Enabled   = .F.
497:             .Visible   = .T.
498:         ENDWITH
499:         BINDEVENT(loc_oPagina.txt_4c_Usuario, "KeyPress", THIS, "ValidarUsuarioAcess")
500: 
501:         *======================================================================
502:         * SECAO GRUPO CONTABIL
503:         * Say7("Grupo Contabil"): top=195+29=224 | Shape3: top=212+29=241
504:         * Get_GrContab: top=216+29=245 | Get_DGrContab: top=216+29=245
505:         *======================================================================
506: 
507:         *-- Shape3 - separador horizontal da secao Grupo Contabil (top=212+29=241)
508:         loc_oPagina.AddObject("shp_4c_Shape3", "Shape")
509:         WITH loc_oPagina.shp_4c_Shape3
510:             .Top         = 241
511:             .Left        = 161
512:             .Width       = 301
513:             .Height      = 2
514:             .BackColor   = RGB(90, 90, 90)
515:             .BorderColor = RGB(90, 90, 90)
516:             .Visible     = .T.
517:         ENDWITH
518: 
519:         *-- Label "Grupo Contabil" - titulo da secao (Say7: top=195+29=224)
520:         loc_oPagina.AddObject("lbl_4c_Label7", "Label")
521:         WITH loc_oPagina.lbl_4c_Label7
522:             .Caption   = "Grupo Cont" + CHR(225) + "bil"
523:             .Top       = 224
524:             .Left      = 166
525:             .AutoSize  = .T.
526:             .FontName  = "Tahoma"
527:             .FontSize  = 8
528:             .FontBold  = .T.
529:             .BackStyle = 0
530:             .ForeColor = RGB(90, 90, 90)
531:             .Visible   = .T.
532:         ENDWITH
533: 
534:         *-- Label "Grupo :" para campo txt_4c_GrContab (Say8: top=219+29=248)
535:         loc_oPagina.AddObject("lbl_4c_Label8", "Label")
536:         WITH loc_oPagina.lbl_4c_Label8
537:             .Caption   = "Grupo : "
538:             .Top       = 248
539:             .Left      = 175

*-- Linhas 560 a 620:
560:             .Enabled   = .F.
561:             .Visible   = .T.
562:         ENDWITH
563:         BINDEVENT(loc_oPagina.txt_4c_GrContab, "KeyPress", THIS, "ValidarGrContab")
564: 
565:         *-- TextBox Get_DGrContab - descricao (txt_4c_DGrContab: top=216+29=245, left=303, width=150)
566:         loc_oPagina.AddObject("txt_4c_DGrContab", "TextBox")
567:         WITH loc_oPagina.txt_4c_DGrContab
568:             .Value     = ""
569:             .Top       = 245
570:             .Left      = 303
571:             .Width     = 150
572:             .Height    = 23
573:             .FontName  = "Tahoma"
574:             .FontSize  = 8
575:             .ForeColor = RGB(90, 90, 90)
576:             .BackColor = RGB(255, 255, 255)
577:             .Enabled   = .F.
578:             .Visible   = .T.
579:         ENDWITH
580:         BINDEVENT(loc_oPagina.txt_4c_DGrContab, "KeyPress", THIS, "ValidarDGrContab")
581: 
582:         *======================================================================
583:         * SECAO CONTA CORRENTE
584:         * Say6("Conta Corrente"): top=265+29=294 | Shape2: top=282+29=311
585:         * Say4 "Grupo :": top=290+29=319 | Say5 "Conta :": top=311+29=340
586:         * Get_GrConta: top=288+29=317 | Get_DGrConta: top=288+29=317
587:         * Get_CdConta: top=312+29=341 | Get_DCONTA: top=312+29=341
588:         *======================================================================
589: 
590:         *-- Shape2 - separador horizontal da secao Conta Corrente (top=282+29=311)
591:         loc_oPagina.AddObject("shp_4c_Shape2", "Shape")
592:         WITH loc_oPagina.shp_4c_Shape2
593:             .Top         = 311
594:             .Left        = 159
595:             .Width       = 513
596:             .Height      = 2
597:             .BackColor   = RGB(90, 90, 90)
598:             .BorderColor = RGB(90, 90, 90)
599:             .Visible     = .T.
600:         ENDWITH
601: 
602:         *-- Label "Conta Corrente" - titulo da secao (Say6: top=265+29=294)
603:         loc_oPagina.AddObject("lbl_4c_Label6", "Label")
604:         WITH loc_oPagina.lbl_4c_Label6
605:             .Caption   = "Conta Corrente"
606:             .Top       = 294
607:             .Left      = 166
608:             .AutoSize  = .T.
609:             .FontName  = "Tahoma"
610:             .FontSize  = 8
611:             .FontBold  = .T.
612:             .BackStyle = 0
613:             .ForeColor = RGB(90, 90, 90)
614:             .Visible   = .T.
615:         ENDWITH
616: 
617:         *-- Label "Grupo :" para campo txt_4c_GrConta (Say4: top=290+29=319)
618:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
619:         WITH loc_oPagina.lbl_4c_Label4
620:             .Caption   = "Grupo : "

*-- Linhas 643 a 759:
643:             .Enabled   = .F.
644:             .Visible   = .T.
645:         ENDWITH
646:         BINDEVENT(loc_oPagina.txt_4c_GrConta, "KeyPress", THIS, "ValidarGrConta")
647: 
648:         *-- TextBox Get_DGrConta - descricao (txt_4c_DGrConta: top=288+29=317, left=303, width=150)
649:         loc_oPagina.AddObject("txt_4c_DGrConta", "TextBox")
650:         WITH loc_oPagina.txt_4c_DGrConta
651:             .Value     = ""
652:             .Top       = 317
653:             .Left      = 303
654:             .Width     = 150
655:             .Height    = 23
656:             .FontName  = "Tahoma"
657:             .FontSize  = 8
658:             .ForeColor = RGB(90, 90, 90)
659:             .BackColor = RGB(255, 255, 255)
660:             .Enabled   = .F.
661:             .Visible   = .T.
662:         ENDWITH
663:         BINDEVENT(loc_oPagina.txt_4c_DGrConta, "KeyPress", THIS, "ValidarDGrConta")
664: 
665:         *-- Label "Conta :" para campo txt_4c_CdConta (Say5: top=311+29=340)
666:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
667:         WITH loc_oPagina.lbl_4c_Label5
668:             .Caption   = "Conta : "
669:             .Top       = 340
670:             .Left      = 176
671:             .AutoSize  = .T.
672:             .FontName  = "Tahoma"
673:             .FontSize  = 8
674:             .BackStyle = 0
675:             .ForeColor = RGB(90, 90, 90)
676:             .Visible   = .T.
677:         ENDWITH
678: 
679:         *-- TextBox Get_CdConta - codigo da conta (txt_4c_CdConta: top=312+29=341, left=223, width=79)
680:         loc_oPagina.AddObject("txt_4c_CdConta", "TextBox")
681:         WITH loc_oPagina.txt_4c_CdConta
682:             .Value     = ""
683:             .Top       = 341
684:             .Left      = 223
685:             .Width     = 79
686:             .Height    = 23
687:             .FontName  = "Tahoma"
688:             .FontSize  = 8
689:             .ForeColor = RGB(90, 90, 90)
690:             .BackColor = RGB(255, 255, 255)
691:             .Enabled   = .F.
692:             .Visible   = .T.
693:         ENDWITH
694:         BINDEVENT(loc_oPagina.txt_4c_CdConta, "KeyPress", THIS, "ValidarCdConta")
695: 
696:         *-- TextBox Get_DCONTA - descricao da conta (txt_4c_DCONTA: top=312+29=341, left=303, width=360)
697:         loc_oPagina.AddObject("txt_4c_DCONTA", "TextBox")
698:         WITH loc_oPagina.txt_4c_DCONTA
699:             .Value     = ""
700:             .Top       = 341
701:             .Left      = 303
702:             .Width     = 360
703:             .Height    = 23
704:             .FontName  = "Tahoma"
705:             .FontSize  = 8
706:             .ForeColor = RGB(90, 90, 90)
707:             .BackColor = RGB(255, 255, 255)
708:             .Enabled   = .F.
709:             .Visible   = .T.
710:         ENDWITH
711:         BINDEVENT(loc_oPagina.txt_4c_DCONTA, "KeyPress", THIS, "ValidarDConta")
712: 
713:         THIS.TornarControlesVisiveis(loc_oPagina)
714:     ENDPROC
715: 
716:     *==========================================================================
717:     * CarregarLista - Carrega dados no grid da lista
718:     *==========================================================================
719:     PROCEDURE CarregarLista()
720:         LOCAL loc_lResultado, loc_oGrid
721:         loc_lResultado = .F.
722: 
723:         TRY
724:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
725:                 loc_lResultado = .T.
726:             ELSE
727:                 IF THIS.this_oBusinessObject.Buscar("")
728:                     IF USED("cursor_4c_Dados")
729:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
730: 
731:                         loc_oGrid.ColumnCount = 5
732:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
733: 
734:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.gracess"
735:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.usuacess"
736:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.grcontbs"
737:                         loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.grcontas"
738:                         loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.cdcontas"
739: 
740:                         loc_oGrid.Column1.Header1.Caption = "Grupo Acesso"
741:                         loc_oGrid.Column2.Header1.Caption = "Usu" + CHR(225) + "rio Acesso"
742:                         loc_oGrid.Column3.Header1.Caption = "Gr. Cont" + CHR(225) + "bil"
743:                         loc_oGrid.Column4.Header1.Caption = "Gr. Conta"
744:                         loc_oGrid.Column5.Header1.Caption = "Conta"
745: 
746:                         loc_oGrid.Column1.Width = 100
747:                         loc_oGrid.Column2.Width = 140
748:                         loc_oGrid.Column3.Width = 120
749:                         loc_oGrid.Column4.Width = 100
750:                         loc_oGrid.Column5.Width = 200
751: 
752:                         THIS.FormatarGridLista(loc_oGrid)
753:                     ENDIF
754:                     loc_lResultado = .T.
755:                 ENDIF
756:             ENDIF
757:         CATCH TO loc_oErro
758:             MsgErro("Erro em CarregarLista: " + loc_oErro.Message, "Erro")
759:             loc_lResultado = .F.

*-- Linhas 765 a 1132:
765:     *==========================================================================
766:     * BtnEncerrarClick - Fecha o formulario
767:     *==========================================================================
768:     PROCEDURE BtnEncerrarClick()
769:         THIS.Release()
770:     ENDPROC
771: 
772:     *==========================================================================
773:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
774:     *==========================================================================
775:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
776:         LOCAL loc_lResultado
777:         loc_lResultado = .F.
778: 
779:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
780:             RETURN .F.
781:         ENDIF
782: 
783:         THIS.pgf_4c_Paginas.ActivePage = par_nPagina
784: 
785:         IF par_nPagina = 1
786:             THIS.CarregarLista()
787:         ENDIF
788: 
789:         loc_lResultado = .T.
790:         RETURN loc_lResultado
791:     ENDPROC
792: 
793:     *==========================================================================
794:     * BtnIncluirClick - Incluir novo registro
795:     *==========================================================================
796:     PROCEDURE BtnIncluirClick()
797:         THIS.this_oBusinessObject.NovoRegistro()
798:         THIS.LimparCampos()
799:         THIS.this_cModoAtual = "INCLUIR"
800:         THIS.HabilitarCampos(.T.)
801:         THIS.AjustarBotoesPorModo()
802:         THIS.AlternarPagina(2)
803:     ENDPROC
804: 
805:     *==========================================================================
806:     * BtnAlterarClick - Alterar registro selecionado
807:     *==========================================================================
808:     PROCEDURE BtnAlterarClick()
809:         LOCAL loc_cId
810:         loc_cId = ""
811: 
812:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
813:             SELECT cursor_4c_Dados
814:             loc_cId = ALLTRIM(NVL(cursor_4c_Dados.cIdChaves, ""))
815:         ENDIF
816: 
817:         IF EMPTY(loc_cId)
818:             MsgAviso("Selecione um registro para alterar.", "Aviso")
819:             RETURN
820:         ENDIF
821: 
822:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cId)
823:             THIS.this_oBusinessObject.CarregarDescricoes()
824:             THIS.this_oBusinessObject.EditarRegistro()
825:             THIS.BOParaForm()
826:             THIS.this_cModoAtual = "ALTERAR"
827:             THIS.HabilitarCampos(.T.)
828:             THIS.AjustarBotoesPorModo()
829:             THIS.AlternarPagina(2)
830:         ELSE
831:             MsgErro("Erro ao carregar o registro selecionado.", "Erro")
832:         ENDIF
833:     ENDPROC
834: 
835:     *==========================================================================
836:     * BtnVisualizarClick - Visualizar registro selecionado (somente leitura)
837:     *==========================================================================
838:     PROCEDURE BtnVisualizarClick()
839:         LOCAL loc_cId
840:         loc_cId = ""
841: 
842:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
843:             SELECT cursor_4c_Dados
844:             loc_cId = ALLTRIM(NVL(cursor_4c_Dados.cIdChaves, ""))
845:         ENDIF
846: 
847:         IF EMPTY(loc_cId)
848:             MsgAviso("Selecione um registro para visualizar.", "Aviso")
849:             RETURN
850:         ENDIF
851: 
852:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cId)
853:             THIS.this_oBusinessObject.CarregarDescricoes()
854:             THIS.BOParaForm()
855:             THIS.this_cModoAtual = "VISUALIZAR"
856:             THIS.HabilitarCampos(.F.)
857:             THIS.AjustarBotoesPorModo()
858:             THIS.AlternarPagina(2)
859:         ELSE
860:             MsgErro("Erro ao carregar o registro selecionado.", "Erro")
861:         ENDIF
862:     ENDPROC
863: 
864:     *==========================================================================
865:     * BtnExcluirClick - Excluir registro selecionado
866:     *==========================================================================
867:     PROCEDURE BtnExcluirClick()
868:         LOCAL loc_cId, loc_lConfirmado
869:         loc_cId        = ""
870:         loc_lConfirmado = .F.
871: 
872:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
873:             SELECT cursor_4c_Dados
874:             loc_cId = ALLTRIM(NVL(cursor_4c_Dados.cIdChaves, ""))
875:         ENDIF
876: 
877:         IF EMPTY(loc_cId)
878:             MsgAviso("Selecione um registro para excluir.", "Aviso")
879:             RETURN
880:         ENDIF
881: 
882:         loc_lConfirmado = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro?", ;
883:             "Confirmar Exclus" + CHR(227) + "o")
884: 
885:         IF loc_lConfirmado
886:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cId)
887:                 IF THIS.this_oBusinessObject.Excluir()
888:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso")
889:                     THIS.CarregarLista()
890:                 ELSE
891:                     MsgErro("Erro ao excluir o registro.", "Erro")
892:                 ENDIF
893:             ELSE
894:                 MsgErro("Erro ao localizar o registro para exclus" + CHR(227) + "o.", "Erro")
895:             ENDIF
896:         ENDIF
897:     ENDPROC
898: 
899:     *==========================================================================
900:     * BtnBuscarClick - Buscar/filtrar registros
901:     *==========================================================================
902:     PROCEDURE BtnBuscarClick()
903:         LOCAL loc_cFiltro, loc_oGrid
904:         loc_cFiltro = ALLTRIM(INPUTBOX("Filtrar por Grupo ou Usu" + CHR(225) + "rio:", "Buscar"))
905: 
906:         TRY
907:             IF THIS.this_oBusinessObject.Buscar(loc_cFiltro) AND USED("cursor_4c_Dados")
908:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
909: 
910:                 loc_oGrid.ColumnCount = 5
911:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
912: 
913:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.gracess"
914:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.usuacess"
915:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.grcontbs"
916:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.grcontas"
917:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.cdcontas"
918: 
919:                 loc_oGrid.Column1.Header1.Caption = "Grupo Acesso"
920:                 loc_oGrid.Column2.Header1.Caption = "Usu" + CHR(225) + "rio Acesso"
921:                 loc_oGrid.Column3.Header1.Caption = "Gr. Cont" + CHR(225) + "bil"
922:                 loc_oGrid.Column4.Header1.Caption = "Gr. Conta"
923:                 loc_oGrid.Column5.Header1.Caption = "Conta"
924: 
925:                 THIS.FormatarGridLista(loc_oGrid)
926:             ENDIF
927:         CATCH TO loc_oErro
928:             MsgErro("Erro em BtnBuscarClick: " + loc_oErro.Message, "Erro")
929:         ENDTRY
930:     ENDPROC
931: 
932:     *==========================================================================
933:     * BtnSalvarClick - Salvar registro (Confirmar na Page2)
934:     *==========================================================================
935:     PROCEDURE BtnSalvarClick()
936:         LOCAL loc_oPagina, loc_cGrupo, loc_cUsuario, loc_cGrContab, loc_cGrConta, loc_cCdConta
937:         loc_oPagina   = THIS.pgf_4c_Paginas.Page2
938:         loc_cGrupo    = ""
939:         loc_cUsuario  = ""
940:         loc_cGrContab = ""
941:         loc_cGrConta  = ""
942:         loc_cCdConta  = ""
943: 
944:         IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
945:             loc_cGrupo = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
946:         ENDIF
947:         IF PEMSTATUS(loc_oPagina, "txt_4c_Usuario", 5)
948:             loc_cUsuario = ALLTRIM(loc_oPagina.txt_4c_Usuario.Value)
949:         ENDIF
950:         IF PEMSTATUS(loc_oPagina, "txt_4c_GrContab", 5)
951:             loc_cGrContab = ALLTRIM(loc_oPagina.txt_4c_GrContab.Value)
952:         ENDIF
953:         IF PEMSTATUS(loc_oPagina, "txt_4c_GrConta", 5)
954:             loc_cGrConta = ALLTRIM(loc_oPagina.txt_4c_GrConta.Value)
955:         ENDIF
956:         IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
957:             loc_cCdConta = ALLTRIM(loc_oPagina.txt_4c_CdConta.Value)
958:         ENDIF
959: 
960:         IF INLIST(THIS.this_cModoAtual, "INCLUIR")
961:             IF EMPTY(loc_cGrupo) AND EMPTY(loc_cUsuario)
962:                 MsgAviso("Usu" + CHR(225) + "rio/Grupo Inv" + CHR(225) + "lido !!!", ;
963:                     "Aten" + CHR(231) + CHR(227) + "o")
964:                 IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
965:                     loc_oPagina.txt_4c_Grupo.SetFocus()
966:                 ENDIF
967:                 RETURN
968:             ENDIF
969:         ENDIF
970: 
971:         IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
972:             IF EMPTY(loc_cGrContab)
973:                 MsgAviso("Grupo Cont" + CHR(225) + "bil Inv" + CHR(225) + "lido !!", ;
974:                     "Aten" + CHR(231) + CHR(227) + "o")
975:                 IF PEMSTATUS(loc_oPagina, "txt_4c_GrContab", 5)
976:                     loc_oPagina.txt_4c_GrContab.SetFocus()
977:                 ENDIF
978:                 RETURN
979:             ENDIF
980: 
981:             IF EMPTY(loc_cGrConta)
982:                 MsgAviso("Grupo Conta Corrente Inv" + CHR(225) + "lido !!", ;
983:                     "Aten" + CHR(231) + CHR(227) + "o")
984:                 IF PEMSTATUS(loc_oPagina, "txt_4c_GrConta", 5)
985:                     loc_oPagina.txt_4c_GrConta.SetFocus()
986:                 ENDIF
987:                 RETURN
988:             ENDIF
989: 
990:             IF EMPTY(loc_cCdConta)
991:                 MsgAviso("Conta Corrente Inv" + CHR(225) + "lida !!", ;
992:                     "Aten" + CHR(231) + CHR(227) + "o")
993:                 IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
994:                     loc_oPagina.txt_4c_CdConta.SetFocus()
995:                 ENDIF
996:                 RETURN
997:             ENDIF
998:         ENDIF
999: 
1000:         THIS.FormParaBO()
1001: 
1002:         *-- Verificar duplicidade antes de salvar (equivalente ao CursorQuery original)
1003:         IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1004:             IF THIS.this_oBusinessObject.VerificarDuplicidade()
1005:                 MsgAviso("Acesso j" + CHR(225) + " cadastrado !!", ;
1006:                     "Aten" + CHR(231) + CHR(227) + "o")
1007:                 IF PEMSTATUS(loc_oPagina, "txt_4c_GrContab", 5)
1008:                     loc_oPagina.txt_4c_GrContab.SetFocus()
1009:                 ENDIF
1010:                 RETURN
1011:             ENDIF
1012:         ENDIF
1013: 
1014:         IF THIS.this_oBusinessObject.Salvar()
1015:             MsgInfo("Registro salvo com sucesso!", "Sucesso")
1016:             THIS.this_cModoAtual = "LISTA"
1017:             THIS.AlternarPagina(1)
1018:         ENDIF
1019:     ENDPROC
1020: 
1021:     *==========================================================================
1022:     * BtnCancelarClick - Cancelar e voltar para lista
1023:     *==========================================================================
1024:     PROCEDURE BtnCancelarClick()
1025:         THIS.this_cModoAtual = "LISTA"
1026:         THIS.AlternarPagina(1)
1027:     ENDPROC
1028: 
1029:     *==========================================================================
1030:     * FormParaBO - Transfere dados do formulario para o Business Object
1031:     *==========================================================================
1032:     PROTECTED PROCEDURE FormParaBO()
1033:         LOCAL loc_oPagina
1034:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1035: 
1036:         IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
1037:             THIS.this_oBusinessObject.this_cGrAcess = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
1038:         ENDIF
1039:         IF PEMSTATUS(loc_oPagina, "txt_4c_Usuario", 5)
1040:             THIS.this_oBusinessObject.this_cUsuAcess = ALLTRIM(loc_oPagina.txt_4c_Usuario.Value)
1041:         ENDIF
1042:         IF PEMSTATUS(loc_oPagina, "txt_4c_GrContab", 5)
1043:             THIS.this_oBusinessObject.this_cGrContbs = ALLTRIM(loc_oPagina.txt_4c_GrContab.Value)
1044:         ENDIF
1045:         IF PEMSTATUS(loc_oPagina, "txt_4c_GrConta", 5)
1046:             THIS.this_oBusinessObject.this_cGrContas = ALLTRIM(loc_oPagina.txt_4c_GrConta.Value)
1047:         ENDIF
1048:         IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
1049:             THIS.this_oBusinessObject.this_cCdContas = ALLTRIM(loc_oPagina.txt_4c_CdConta.Value)
1050:         ENDIF
1051:     ENDPROC
1052: 
1053:     *==========================================================================
1054:     * BOParaForm - Transfere dados do Business Object para o formulario
1055:     *==========================================================================
1056:     PROTECTED PROCEDURE BOParaForm()
1057:         LOCAL loc_oPagina
1058:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1059: 
1060:         IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
1061:             loc_oPagina.txt_4c_Grupo.Value = ALLTRIM(THIS.this_oBusinessObject.this_cGrAcess)
1062:         ENDIF
1063:         IF PEMSTATUS(loc_oPagina, "txt_4c_Usuario", 5)
1064:             loc_oPagina.txt_4c_Usuario.Value = ALLTRIM(THIS.this_oBusinessObject.this_cUsuAcess)
1065:         ENDIF
1066:         IF PEMSTATUS(loc_oPagina, "txt_4c_GrContab", 5)
1067:             loc_oPagina.txt_4c_GrContab.Value = ALLTRIM(THIS.this_oBusinessObject.this_cGrContbs)
1068:         ENDIF
1069:         IF PEMSTATUS(loc_oPagina, "txt_4c_DGrContab", 5)
1070:             loc_oPagina.txt_4c_DGrContab.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDGrContb)
1071:         ENDIF
1072:         IF PEMSTATUS(loc_oPagina, "txt_4c_GrConta", 5)
1073:             loc_oPagina.txt_4c_GrConta.Value = ALLTRIM(THIS.this_oBusinessObject.this_cGrContas)
1074:         ENDIF
1075:         IF PEMSTATUS(loc_oPagina, "txt_4c_DGrConta", 5)
1076:             loc_oPagina.txt_4c_DGrConta.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDGrConta)
1077:         ENDIF
1078:         IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
1079:             loc_oPagina.txt_4c_CdConta.Value = ALLTRIM(THIS.this_oBusinessObject.this_cCdContas)
1080:         ENDIF
1081:         IF PEMSTATUS(loc_oPagina, "txt_4c_DCONTA", 5)
1082:             loc_oPagina.txt_4c_DCONTA.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDConta)
1083:         ENDIF
1084:     ENDPROC
1085: 
1086:     *==========================================================================
1087:     * HabilitarCampos - Habilita ou desabilita campos do formulario
1088:     * Grupo e Usuario sao mutuamente exclusivos (When original)
1089:     * DGrContab so editavel quando GrContab vazio (When original)
1090:     * DGrConta  so editavel quando GrConta vazio  (When original)
1091:     *==========================================================================
1092:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1093:         LOCAL loc_oPagina, loc_cGrupo, loc_cUsuario, loc_cGrContab, loc_cGrConta
1094:         loc_oPagina   = THIS.pgf_4c_Paginas.Page2
1095:         loc_cGrupo    = ""
1096:         loc_cUsuario  = ""
1097:         loc_cGrContab = ""
1098:         loc_cGrConta  = ""
1099: 
1100:         IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
1101:             loc_cGrupo = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
1102:         ENDIF
1103:         IF PEMSTATUS(loc_oPagina, "txt_4c_Usuario", 5)
1104:             loc_cUsuario = ALLTRIM(loc_oPagina.txt_4c_Usuario.Value)
1105:         ENDIF
1106:         IF PEMSTATUS(loc_oPagina, "txt_4c_GrContab", 5)
1107:             loc_cGrContab = ALLTRIM(loc_oPagina.txt_4c_GrContab.Value)
1108:         ENDIF
1109:         IF PEMSTATUS(loc_oPagina, "txt_4c_GrConta", 5)
1110:             loc_cGrConta = ALLTRIM(loc_oPagina.txt_4c_GrConta.Value)
1111:         ENDIF
1112: 
1113:         *-- Grupo e Usuario: mutuamente exclusivos
1114:         IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
1115:             loc_oPagina.txt_4c_Grupo.Enabled = par_lHabilitar AND EMPTY(loc_cUsuario)
1116:         ENDIF
1117:         IF PEMSTATUS(loc_oPagina, "txt_4c_Usuario", 5)
1118:             loc_oPagina.txt_4c_Usuario.Enabled = par_lHabilitar AND EMPTY(loc_cGrupo)
1119:         ENDIF
1120: 
1121:         *-- GrContab: sempre editavel quando habilitado
1122:         IF PEMSTATUS(loc_oPagina, "txt_4c_GrContab", 5)
1123:             loc_oPagina.txt_4c_GrContab.Enabled = par_lHabilitar
1124:         ENDIF
1125:         *-- DGrContab: so editavel quando GrContab vazio (busca pela descricao)
1126:         IF PEMSTATUS(loc_oPagina, "txt_4c_DGrContab", 5)
1127:             loc_oPagina.txt_4c_DGrContab.Enabled = par_lHabilitar AND EMPTY(loc_cGrContab)
1128:         ENDIF
1129: 
1130:         *-- GrConta: sempre editavel quando habilitado
1131:         IF PEMSTATUS(loc_oPagina, "txt_4c_GrConta", 5)
1132:             loc_oPagina.txt_4c_GrConta.Enabled = par_lHabilitar

*-- Linhas 1147 a 1591:
1147:     *==========================================================================
1148:     * LimparCampos - Limpa valores dos campos do formulario
1149:     *==========================================================================
1150:     PROTECTED PROCEDURE LimparCampos()
1151:         LOCAL loc_oPagina
1152:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1153: 
1154:         IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
1155:             loc_oPagina.txt_4c_Grupo.Value = ""
1156:         ENDIF
1157:         IF PEMSTATUS(loc_oPagina, "txt_4c_Usuario", 5)
1158:             loc_oPagina.txt_4c_Usuario.Value = ""
1159:         ENDIF
1160:         IF PEMSTATUS(loc_oPagina, "txt_4c_GrContab", 5)
1161:             loc_oPagina.txt_4c_GrContab.Value = ""
1162:         ENDIF
1163:         IF PEMSTATUS(loc_oPagina, "txt_4c_DGrContab", 5)
1164:             loc_oPagina.txt_4c_DGrContab.Value = ""
1165:         ENDIF
1166:         IF PEMSTATUS(loc_oPagina, "txt_4c_GrConta", 5)
1167:             loc_oPagina.txt_4c_GrConta.Value = ""
1168:         ENDIF
1169:         IF PEMSTATUS(loc_oPagina, "txt_4c_DGrConta", 5)
1170:             loc_oPagina.txt_4c_DGrConta.Value = ""
1171:         ENDIF
1172:         IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
1173:             loc_oPagina.txt_4c_CdConta.Value = ""
1174:         ENDIF
1175:         IF PEMSTATUS(loc_oPagina, "txt_4c_DCONTA", 5)
1176:             loc_oPagina.txt_4c_DCONTA.Value = ""
1177:         ENDIF
1178:     ENDPROC
1179: 
1180:     *==========================================================================
1181:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme o modo atual
1182:     *==========================================================================
1183:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1184:         LOCAL loc_oPg2, loc_lEditando
1185:         loc_oPg2      = THIS.pgf_4c_Paginas.Page2
1186:         loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1187: 
1188:         IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
1189:             IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1190:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando
1191:             ENDIF
1192:             IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
1193:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
1194:             ENDIF
1195:         ENDIF
1196:     ENDPROC
1197: 
1198:     *==========================================================================
1199:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
1200:     *==========================================================================
1201:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1202:         LOCAL loc_nI, loc_oObjeto, loc_nP
1203: 
1204:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1205:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1206: 
1207:             IF VARTYPE(loc_oObjeto) = "O"
1208:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1209:                     loc_oObjeto.Visible = .T.
1210:                 ENDIF
1211: 
1212:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1213:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1214:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1215:                     ENDFOR
1216:                 ENDIF
1217: 
1218:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1219:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1220:                 ENDIF
1221:             ENDIF
1222:         ENDFOR
1223:     ENDPROC
1224: 
1225:     *==========================================================================
1226:     * FormatarGridLista - Formata visual do grid da lista
1227:     *==========================================================================
1228:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1229:         WITH par_oGrid
1230:             .FontName = "Tahoma"
1231:             .FontSize = 8
1232:         ENDWITH
1233:     ENDPROC
1234: 
1235:     *==========================================================================
1236:     * ValidarGrupoAcess - Lookup de Grupo de Acesso (Get_Grupo / SigCdAcG)
1237:     * Mutualmente exclusivo com txt_4c_Usuario
1238:     *==========================================================================
1239:     PROCEDURE ValidarGrupoAcess()
1240:         LOCAL loc_oPagina, loc_cGrupo, loc_oBusca
1241:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1242: 
1243:         IF !PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
1244:             RETURN
1245:         ENDIF
1246:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1247:             RETURN
1248:         ENDIF
1249: 
1250:         loc_cGrupo = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
1251: 
1252:         IF EMPTY(loc_cGrupo)
1253:             *-- Grupo limpo: habilitar Usuario novamente
1254:             IF PEMSTATUS(loc_oPagina, "txt_4c_Usuario", 5)
1255:                 loc_oPagina.txt_4c_Usuario.Enabled = .T.
1256:             ENDIF
1257:             RETURN
1258:         ENDIF
1259: 
1260:         TRY
1261:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1262:                 "SigCdAcG", "cursor_4c_BuscaGrAcess", "Grupos", loc_cGrupo, ;
1263:                 "Grupo de Acesso")
1264: 
1265:             IF VARTYPE(loc_oBusca) = "O"
1266:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1267:                     IF USED("cursor_4c_BuscaGrAcess")
1268:                         SELECT cursor_4c_BuscaGrAcess
1269:                         loc_oPagina.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGrAcess.Grupos)
1270:                     ENDIF
1271:                 ELSE
1272:                     IF !loc_oBusca.this_lAchouRegistro
1273:                     loc_oBusca.mAddColuna("Grupos", "", "Grupo")
1274:                     loc_oBusca.Show()
1275:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrAcess")
1276:                         SELECT cursor_4c_BuscaGrAcess
1277:                         loc_oPagina.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGrAcess.Grupos)
1278:                     ENDIF
1279:                 ELSE
1280:                     loc_oPagina.txt_4c_Grupo.Value = ""
1281:                     ENDIF
1282:                 ENDIF
1283:                 loc_oBusca.Release()
1284:             ENDIF
1285: 
1286:             IF USED("cursor_4c_BuscaGrAcess")
1287:                 USE IN cursor_4c_BuscaGrAcess
1288:             ENDIF
1289: 
1290:             *-- Se Grupo preenchido: desabilitar Usuario (exclusao mutua)
1291:             IF PEMSTATUS(loc_oPagina, "txt_4c_Usuario", 5)
1292:                 loc_oPagina.txt_4c_Usuario.Enabled = ;
1293:                     EMPTY(ALLTRIM(loc_oPagina.txt_4c_Grupo.Value))
1294:             ENDIF
1295: 
1296:         CATCH TO loc_oErro
1297:             MsgErro("Erro ao validar Grupo de Acesso: " + loc_oErro.Message, "Erro")
1298:         ENDTRY
1299:     ENDPROC
1300: 
1301:     *==========================================================================
1302:     * ValidarUsuarioAcess - Lookup de Usuario (Get_Usuario / SigCdUsu)
1303:     * Mutualmente exclusivo com txt_4c_Grupo
1304:     * Filtro: Not cAtivos='N' (apenas usuarios ativos)
1305:     *==========================================================================
1306:     PROCEDURE ValidarUsuarioAcess()
1307:         LOCAL loc_oPagina, loc_cUsuario, loc_oBusca
1308:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1309: 
1310:         IF !PEMSTATUS(loc_oPagina, "txt_4c_Usuario", 5)
1311:             RETURN
1312:         ENDIF
1313:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1314:             RETURN
1315:         ENDIF
1316: 
1317:         loc_cUsuario = ALLTRIM(loc_oPagina.txt_4c_Usuario.Value)
1318: 
1319:         IF EMPTY(loc_cUsuario)
1320:             *-- Usuario limpo: habilitar Grupo novamente
1321:             IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
1322:                 loc_oPagina.txt_4c_Grupo.Enabled = .T.
1323:             ENDIF
1324:             RETURN
1325:         ENDIF
1326: 
1327:         TRY
1328:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1329:                 "SigCdUsu", "cursor_4c_BuscaUsuario", "Usuarios", loc_cUsuario, ;
1330:                 "Usu" + CHR(225) + "rios")
1331: 
1332:             IF VARTYPE(loc_oBusca) = "O"
1333:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1334:                     IF USED("cursor_4c_BuscaUsuario")
1335:                         SELECT cursor_4c_BuscaUsuario
1336:                         loc_oPagina.txt_4c_Usuario.Value = ALLTRIM(cursor_4c_BuscaUsuario.Usuarios)
1337:                     ENDIF
1338:                 ELSE
1339:                     IF !loc_oBusca.this_lAchouRegistro
1340:                     loc_oBusca.mAddColuna("Usuarios", "", "C" + CHR(243) + "digo")
1341:                     loc_oBusca.mAddColuna("CCargs",   "", "Cargo")
1342:                     loc_oBusca.Show()
1343:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUsuario")
1344:                         SELECT cursor_4c_BuscaUsuario
1345:                         loc_oPagina.txt_4c_Usuario.Value = ALLTRIM(cursor_4c_BuscaUsuario.Usuarios)
1346:                     ENDIF
1347:                 ELSE
1348:                     loc_oPagina.txt_4c_Usuario.Value = ""
1349:                     ENDIF
1350:                 ENDIF
1351:                 loc_oBusca.Release()
1352:             ENDIF
1353: 
1354:             IF USED("cursor_4c_BuscaUsuario")
1355:                 USE IN cursor_4c_BuscaUsuario
1356:             ENDIF
1357: 
1358:             *-- Se Usuario preenchido: desabilitar Grupo (exclusao mutua)
1359:             IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
1360:                 loc_oPagina.txt_4c_Grupo.Enabled = ;
1361:                     EMPTY(ALLTRIM(loc_oPagina.txt_4c_Usuario.Value))
1362:             ENDIF
1363: 
1364:         CATCH TO loc_oErro
1365:             MsgErro("Erro ao validar Usu" + CHR(225) + "rio: " + loc_oErro.Message, "Erro")
1366:         ENDTRY
1367:     ENDPROC
1368: 
1369:     *==========================================================================
1370:     * ValidarGrContab - Lookup Grupo Contabil pelo codigo (Get_GrContab / SigCdGcr)
1371:     * Ao confirmar, preenche tambem txt_4c_DGrContab com Descrs
1372:     *==========================================================================
1373:     PROCEDURE ValidarGrContab()
1374:         LOCAL loc_oPagina, loc_cCodigo, loc_oBusca
1375:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1376: 
1377:         IF !PEMSTATUS(loc_oPagina, "txt_4c_GrContab", 5)
1378:             RETURN
1379:         ENDIF
1380:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1381:             RETURN
1382:         ENDIF
1383: 
1384:         loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_GrContab.Value)
1385: 
1386:         IF EMPTY(loc_cCodigo)
1387:             *-- Codigo limpo: habilitar DGrContab para busca pela descricao
1388:             IF PEMSTATUS(loc_oPagina, "txt_4c_DGrContab", 5)
1389:                 loc_oPagina.txt_4c_DGrContab.Value   = ""
1390:                 loc_oPagina.txt_4c_DGrContab.Enabled = .T.
1391:             ENDIF
1392:             RETURN
1393:         ENDIF
1394: 
1395:         TRY
1396:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1397:                 "SigCdGcr", "cursor_4c_BuscaGrContab", "Codigos", loc_cCodigo, ;
1398:                 "Grupo Cont" + CHR(225) + "bil")
1399: 
1400:             IF VARTYPE(loc_oBusca) = "O"
1401:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1402:                     IF USED("cursor_4c_BuscaGrContab")
1403:                         SELECT cursor_4c_BuscaGrContab
1404:                         loc_oPagina.txt_4c_GrContab.Value = ALLTRIM(cursor_4c_BuscaGrContab.Codigos)
1405:                         IF PEMSTATUS(loc_oPagina, "txt_4c_DGrContab", 5)
1406:                             loc_oPagina.txt_4c_DGrContab.Value = ALLTRIM(cursor_4c_BuscaGrContab.Descrs)
1407:                         ENDIF
1408:                     ENDIF
1409:                 ELSE
1410:                     IF !loc_oBusca.this_lAchouRegistro
1411:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1412:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1413:                     loc_oBusca.Show()
1414:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrContab")
1415:                         SELECT cursor_4c_BuscaGrContab
1416:                         loc_oPagina.txt_4c_GrContab.Value = ALLTRIM(cursor_4c_BuscaGrContab.Codigos)
1417:                         IF PEMSTATUS(loc_oPagina, "txt_4c_DGrContab", 5)
1418:                             loc_oPagina.txt_4c_DGrContab.Value = ALLTRIM(cursor_4c_BuscaGrContab.Descrs)
1419:                         ENDIF
1420:                     ENDIF
1421:                 ELSE
1422:                     loc_oPagina.txt_4c_GrContab.Value = ""
1423:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DGrContab", 5)
1424:                         loc_oPagina.txt_4c_DGrContab.Value = ""
1425:                     ENDIF
1426:                     ENDIF
1427:                 ENDIF
1428:                 loc_oBusca.Release()
1429:             ENDIF
1430: 
1431:             IF USED("cursor_4c_BuscaGrContab")
1432:                 USE IN cursor_4c_BuscaGrContab
1433:             ENDIF
1434: 
1435:             *-- DGrContab: so editavel quando GrContab vazio
1436:             IF PEMSTATUS(loc_oPagina, "txt_4c_DGrContab", 5)
1437:                 loc_oPagina.txt_4c_DGrContab.Enabled = ;
1438:                     EMPTY(ALLTRIM(loc_oPagina.txt_4c_GrContab.Value))
1439:             ENDIF
1440: 
1441:         CATCH TO loc_oErro
1442:             MsgErro("Erro ao validar Grupo Cont" + CHR(225) + "bil: " + loc_oErro.Message, "Erro")
1443:         ENDTRY
1444:     ENDPROC
1445: 
1446:     *==========================================================================
1447:     * ValidarDGrContab - Lookup Grupo Contabil pela descricao (Get_DGrContab / SigCdGcr)
1448:     * Ao confirmar, preenche tambem txt_4c_GrContab com Codigos
1449:     *==========================================================================
1450:     PROCEDURE ValidarDGrContab()
1451:         LOCAL loc_oPagina, loc_cDescr, loc_oBusca
1452:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1453: 
1454:         IF !PEMSTATUS(loc_oPagina, "txt_4c_DGrContab", 5)
1455:             RETURN
1456:         ENDIF
1457:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1458:             RETURN
1459:         ENDIF
1460: 
1461:         loc_cDescr = ALLTRIM(loc_oPagina.txt_4c_DGrContab.Value)
1462: 
1463:         IF EMPTY(loc_cDescr)
1464:             IF PEMSTATUS(loc_oPagina, "txt_4c_GrContab", 5)
1465:                 loc_oPagina.txt_4c_GrContab.Value = ""
1466:             ENDIF
1467:             RETURN
1468:         ENDIF
1469: 
1470:         TRY
1471:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1472:                 "SigCdGcr", "cursor_4c_BuscaGrContab", "Descrs", loc_cDescr, ;
1473:                 "Grupo Cont" + CHR(225) + "bil")
1474: 
1475:             IF VARTYPE(loc_oBusca) = "O"
1476:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1477:                     IF USED("cursor_4c_BuscaGrContab")
1478:                         SELECT cursor_4c_BuscaGrContab
1479:                         loc_oPagina.txt_4c_DGrContab.Value = ALLTRIM(cursor_4c_BuscaGrContab.Descrs)
1480:                         IF PEMSTATUS(loc_oPagina, "txt_4c_GrContab", 5)
1481:                             loc_oPagina.txt_4c_GrContab.Value = ALLTRIM(cursor_4c_BuscaGrContab.Codigos)
1482:                         ENDIF
1483:                     ENDIF
1484:                 ELSE
1485:                     IF !loc_oBusca.this_lAchouRegistro
1486:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1487:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1488:                     loc_oBusca.Show()
1489:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrContab")
1490:                         SELECT cursor_4c_BuscaGrContab
1491:                         loc_oPagina.txt_4c_DGrContab.Value = ALLTRIM(cursor_4c_BuscaGrContab.Descrs)
1492:                         IF PEMSTATUS(loc_oPagina, "txt_4c_GrContab", 5)
1493:                             loc_oPagina.txt_4c_GrContab.Value = ALLTRIM(cursor_4c_BuscaGrContab.Codigos)
1494:                         ENDIF
1495:                     ENDIF
1496:                 ELSE
1497:                     loc_oPagina.txt_4c_DGrContab.Value = ""
1498:                     IF PEMSTATUS(loc_oPagina, "txt_4c_GrContab", 5)
1499:                         loc_oPagina.txt_4c_GrContab.Value = ""
1500:                     ENDIF
1501:                     ENDIF
1502:                 ENDIF
1503:                 loc_oBusca.Release()
1504:             ENDIF
1505: 
1506:             IF USED("cursor_4c_BuscaGrContab")
1507:                 USE IN cursor_4c_BuscaGrContab
1508:             ENDIF
1509: 
1510:         CATCH TO loc_oErro
1511:             MsgErro("Erro ao validar descri" + CHR(231) + CHR(227) + "o Grupo Cont" + CHR(225) + ;
1512:                 "bil: " + loc_oErro.Message, "Erro")
1513:         ENDTRY
1514:     ENDPROC
1515: 
1516:     *==========================================================================
1517:     * ValidarGrConta - Lookup Grupo Conta Corrente pelo codigo (Get_GrConta / SigCdGcr)
1518:     * Ao confirmar, preenche tambem txt_4c_DGrConta com Descrs
1519:     * Habilita/desabilita DGrConta conforme mutuidade com GrConta
1520:     *==========================================================================
1521:     PROCEDURE ValidarGrConta()
1522:         LOCAL loc_oPagina, loc_cCodigo, loc_oBusca
1523:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1524: 
1525:         IF !PEMSTATUS(loc_oPagina, "txt_4c_GrConta", 5)
1526:             RETURN
1527:         ENDIF
1528:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1529:             RETURN
1530:         ENDIF
1531: 
1532:         loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_GrConta.Value)
1533: 
1534:         IF EMPTY(loc_cCodigo)
1535:             *-- Codigo limpo: habilitar DGrConta para busca pela descricao
1536:             IF PEMSTATUS(loc_oPagina, "txt_4c_DGrConta", 5)
1537:                 loc_oPagina.txt_4c_DGrConta.Value   = ""
1538:                 loc_oPagina.txt_4c_DGrConta.Enabled = .T.
1539:             ENDIF
1540:             *-- Limpar CdConta e DCONTA pois dependem do grupo
1541:             IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
1542:                 loc_oPagina.txt_4c_CdConta.Value = ""
1543:             ENDIF
1544:             IF PEMSTATUS(loc_oPagina, "txt_4c_DCONTA", 5)
1545:                 loc_oPagina.txt_4c_DCONTA.Value = ""
1546:             ENDIF
1547:             RETURN
1548:         ENDIF
1549: 
1550:         TRY
1551:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1552:                 "SigCdGcr", "cursor_4c_BuscaGrConta", "Codigos", loc_cCodigo, ;
1553:                 "Grupo Conta Corrente")
1554: 
1555:             IF VARTYPE(loc_oBusca) = "O"
1556:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1557:                     IF USED("cursor_4c_BuscaGrConta")
1558:                         SELECT cursor_4c_BuscaGrConta
1559:                         loc_oPagina.txt_4c_GrConta.Value = ALLTRIM(cursor_4c_BuscaGrConta.Codigos)
1560:                         IF PEMSTATUS(loc_oPagina, "txt_4c_DGrConta", 5)
1561:                             loc_oPagina.txt_4c_DGrConta.Value = ALLTRIM(cursor_4c_BuscaGrConta.Descrs)
1562:                         ENDIF
1563:                     ENDIF
1564:                 ELSE
1565:                     IF !loc_oBusca.this_lAchouRegistro
1566:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1567:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1568:                     loc_oBusca.Show()
1569:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrConta")
1570:                         SELECT cursor_4c_BuscaGrConta
1571:                         loc_oPagina.txt_4c_GrConta.Value = ALLTRIM(cursor_4c_BuscaGrConta.Codigos)
1572:                         IF PEMSTATUS(loc_oPagina, "txt_4c_DGrConta", 5)
1573:                             loc_oPagina.txt_4c_DGrConta.Value = ALLTRIM(cursor_4c_BuscaGrConta.Descrs)
1574:                         ENDIF
1575:                     ENDIF
1576:                 ELSE
1577:                     loc_oPagina.txt_4c_GrConta.Value = ""
1578:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DGrConta", 5)
1579:                         loc_oPagina.txt_4c_DGrConta.Value = ""
1580:                     ENDIF
1581:                     ENDIF
1582:                 ENDIF
1583:                 loc_oBusca.Release()
1584:             ENDIF
1585: 
1586:             IF USED("cursor_4c_BuscaGrConta")
1587:                 USE IN cursor_4c_BuscaGrConta
1588:             ENDIF
1589: 
1590:             *-- DGrConta: so editavel quando GrConta vazio
1591:             IF PEMSTATUS(loc_oPagina, "txt_4c_DGrConta", 5)

*-- Linhas 1602 a 1877:
1602:     * ValidarDGrConta - Lookup Grupo Conta Corrente pela descricao (Get_DGrConta / SigCdGcr)
1603:     * Ao confirmar, preenche tambem txt_4c_GrConta com Codigos
1604:     *==========================================================================
1605:     PROCEDURE ValidarDGrConta()
1606:         LOCAL loc_oPagina, loc_cDescr, loc_oBusca
1607:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1608: 
1609:         IF !PEMSTATUS(loc_oPagina, "txt_4c_DGrConta", 5)
1610:             RETURN
1611:         ENDIF
1612:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1613:             RETURN
1614:         ENDIF
1615: 
1616:         loc_cDescr = ALLTRIM(loc_oPagina.txt_4c_DGrConta.Value)
1617: 
1618:         IF EMPTY(loc_cDescr)
1619:             IF PEMSTATUS(loc_oPagina, "txt_4c_GrConta", 5)
1620:                 loc_oPagina.txt_4c_GrConta.Value = ""
1621:             ENDIF
1622:             *-- Limpar CdConta e DCONTA pois dependem do grupo
1623:             IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
1624:                 loc_oPagina.txt_4c_CdConta.Value = ""
1625:             ENDIF
1626:             IF PEMSTATUS(loc_oPagina, "txt_4c_DCONTA", 5)
1627:                 loc_oPagina.txt_4c_DCONTA.Value = ""
1628:             ENDIF
1629:             RETURN
1630:         ENDIF
1631: 
1632:         TRY
1633:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1634:                 "SigCdGcr", "cursor_4c_BuscaGrConta", "Descrs", loc_cDescr, ;
1635:                 "Grupo Conta Corrente")
1636: 
1637:             IF VARTYPE(loc_oBusca) = "O"
1638:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1639:                     IF USED("cursor_4c_BuscaGrConta")
1640:                         SELECT cursor_4c_BuscaGrConta
1641:                         loc_oPagina.txt_4c_DGrConta.Value = ALLTRIM(cursor_4c_BuscaGrConta.Descrs)
1642:                         IF PEMSTATUS(loc_oPagina, "txt_4c_GrConta", 5)
1643:                             loc_oPagina.txt_4c_GrConta.Value = ALLTRIM(cursor_4c_BuscaGrConta.Codigos)
1644:                         ENDIF
1645:                     ENDIF
1646:                 ELSE
1647:                     IF !loc_oBusca.this_lAchouRegistro
1648:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1649:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1650:                     loc_oBusca.Show()
1651:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrConta")
1652:                         SELECT cursor_4c_BuscaGrConta
1653:                         loc_oPagina.txt_4c_DGrConta.Value = ALLTRIM(cursor_4c_BuscaGrConta.Descrs)
1654:                         IF PEMSTATUS(loc_oPagina, "txt_4c_GrConta", 5)
1655:                             loc_oPagina.txt_4c_GrConta.Value = ALLTRIM(cursor_4c_BuscaGrConta.Codigos)
1656:                         ENDIF
1657:                     ENDIF
1658:                 ELSE
1659:                     loc_oPagina.txt_4c_DGrConta.Value = ""
1660:                     IF PEMSTATUS(loc_oPagina, "txt_4c_GrConta", 5)
1661:                         loc_oPagina.txt_4c_GrConta.Value = ""
1662:                     ENDIF
1663:                     ENDIF
1664:                 ENDIF
1665:                 loc_oBusca.Release()
1666:             ENDIF
1667: 
1668:             IF USED("cursor_4c_BuscaGrConta")
1669:                 USE IN cursor_4c_BuscaGrConta
1670:             ENDIF
1671: 
1672:         CATCH TO loc_oErro
1673:             MsgErro("Erro ao validar descri" + CHR(231) + CHR(227) + "o Grupo Conta Corrente: " + ;
1674:                 loc_oErro.Message, "Erro")
1675:         ENDTRY
1676:     ENDPROC
1677: 
1678:     *==========================================================================
1679:     * ValidarCdConta - Lookup Conta Corrente pelo codigo (Get_CdConta / SigCdCli)
1680:     * Usa GrConta como filtro de grupo (equivalente a fAcessoContas modo 'C')
1681:     * Ao confirmar, preenche txt_4c_DCONTA com RClis
1682:     *==========================================================================
1683:     PROCEDURE ValidarCdConta()
1684:         LOCAL loc_oPagina, loc_cCodigo, loc_cGrupo, loc_oBusca, loc_cFiltro
1685:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1686: 
1687:         IF !PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
1688:             RETURN
1689:         ENDIF
1690:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1691:             RETURN
1692:         ENDIF
1693: 
1694:         loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_CdConta.Value)
1695:         loc_cGrupo  = ""
1696: 
1697:         IF PEMSTATUS(loc_oPagina, "txt_4c_GrConta", 5)
1698:             loc_cGrupo = ALLTRIM(loc_oPagina.txt_4c_GrConta.Value)
1699:         ENDIF
1700: 
1701:         IF EMPTY(loc_cCodigo)
1702:             IF PEMSTATUS(loc_oPagina, "txt_4c_DCONTA", 5)
1703:                 loc_oPagina.txt_4c_DCONTA.Value   = ""
1704:                 loc_oPagina.txt_4c_DCONTA.Enabled = .T.
1705:             ENDIF
1706:             RETURN
1707:         ENDIF
1708: 
1709:         TRY
1710:             IF !EMPTY(loc_cGrupo)
1711:                 loc_cFiltro = "Grupos = " + EscaparSQL(loc_cGrupo)
1712:             ELSE
1713:                 loc_cFiltro = ""
1714:             ENDIF
1715: 
1716:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1717:                 "SigCdCli", "cursor_4c_BuscaConta", "IClis", loc_cCodigo, ;
1718:                 "Conta Corrente", .T., .T., loc_cFiltro)
1719: 
1720:             IF VARTYPE(loc_oBusca) = "O"
1721:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1722:                     IF USED("cursor_4c_BuscaConta")
1723:                         SELECT cursor_4c_BuscaConta
1724:                         loc_oPagina.txt_4c_CdConta.Value = ALLTRIM(cursor_4c_BuscaConta.IClis)
1725:                         IF PEMSTATUS(loc_oPagina, "txt_4c_DCONTA", 5)
1726:                             loc_oPagina.txt_4c_DCONTA.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
1727:                         ENDIF
1728:                     ENDIF
1729:                 ELSE
1730:                     IF !loc_oBusca.this_lAchouRegistro
1731:                     loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
1732:                     loc_oBusca.mAddColuna("RClis", "", "Nome")
1733:                     loc_oBusca.Show()
1734:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
1735:                         SELECT cursor_4c_BuscaConta
1736:                         loc_oPagina.txt_4c_CdConta.Value = ALLTRIM(cursor_4c_BuscaConta.IClis)
1737:                         IF PEMSTATUS(loc_oPagina, "txt_4c_DCONTA", 5)
1738:                             loc_oPagina.txt_4c_DCONTA.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
1739:                         ENDIF
1740:                     ELSE
1741:                         MsgAviso("Acesso Negado...", "Aviso")
1742:                         loc_oPagina.txt_4c_CdConta.Value = ""
1743:                         IF PEMSTATUS(loc_oPagina, "txt_4c_DCONTA", 5)
1744:                             loc_oPagina.txt_4c_DCONTA.Value = ""
1745:                         ENDIF
1746:                     ENDIF
1747:                 ELSE
1748:                     MsgAviso("Acesso Negado...", "Aviso")
1749:                     loc_oPagina.txt_4c_CdConta.Value = ""
1750:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DCONTA", 5)
1751:                         loc_oPagina.txt_4c_DCONTA.Value = ""
1752:                     ENDIF
1753:                     ENDIF
1754:                 ENDIF
1755:                 loc_oBusca.Release()
1756:             ENDIF
1757: 
1758:             IF USED("cursor_4c_BuscaConta")
1759:                 USE IN cursor_4c_BuscaConta
1760:             ENDIF
1761: 
1762:             *-- DCONTA: so editavel quando CdConta vazio
1763:             IF PEMSTATUS(loc_oPagina, "txt_4c_DCONTA", 5)
1764:                 loc_oPagina.txt_4c_DCONTA.Enabled = ;
1765:                     EMPTY(ALLTRIM(loc_oPagina.txt_4c_CdConta.Value))
1766:             ENDIF
1767: 
1768:         CATCH TO loc_oErro
1769:             MsgErro("Erro ao validar Conta Corrente: " + loc_oErro.Message, "Erro")
1770:         ENDTRY
1771:     ENDPROC
1772: 
1773:     *==========================================================================
1774:     * ValidarDConta - Lookup Conta Corrente pela descricao (Get_DCONTA / SigCdCli)
1775:     * Usa GrConta como filtro de grupo (equivalente a fAcessoContas modo 'D')
1776:     * Ao confirmar, preenche txt_4c_CdConta com IClis
1777:     *==========================================================================
1778:     PROCEDURE ValidarDConta()
1779:         LOCAL loc_oPagina, loc_cDescr, loc_cGrupo, loc_oBusca, loc_cFiltro
1780:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1781: 
1782:         IF !PEMSTATUS(loc_oPagina, "txt_4c_DCONTA", 5)
1783:             RETURN
1784:         ENDIF
1785:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1786:             RETURN
1787:         ENDIF
1788: 
1789:         loc_cDescr = ALLTRIM(loc_oPagina.txt_4c_DCONTA.Value)
1790:         loc_cGrupo = ""
1791: 
1792:         IF PEMSTATUS(loc_oPagina, "txt_4c_GrConta", 5)
1793:             loc_cGrupo = ALLTRIM(loc_oPagina.txt_4c_GrConta.Value)
1794:         ENDIF
1795: 
1796:         IF EMPTY(loc_cDescr)
1797:             IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
1798:                 loc_oPagina.txt_4c_CdConta.Value = ""
1799:             ENDIF
1800:             RETURN
1801:         ENDIF
1802: 
1803:         TRY
1804:             IF !EMPTY(loc_cGrupo)
1805:                 loc_cFiltro = "Grupos = " + EscaparSQL(loc_cGrupo)
1806:             ELSE
1807:                 loc_cFiltro = ""
1808:             ENDIF
1809: 
1810:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1811:                 "SigCdCli", "cursor_4c_BuscaConta", "RClis", loc_cDescr, ;
1812:                 "Conta Corrente", .T., .T., loc_cFiltro)
1813: 
1814:             IF VARTYPE(loc_oBusca) = "O"
1815:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1816:                     IF USED("cursor_4c_BuscaConta")
1817:                         SELECT cursor_4c_BuscaConta
1818:                         loc_oPagina.txt_4c_DCONTA.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
1819:                         IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
1820:                             loc_oPagina.txt_4c_CdConta.Value = ALLTRIM(cursor_4c_BuscaConta.IClis)
1821:                         ENDIF
1822:                     ENDIF
1823:                 ELSE
1824:                     IF !loc_oBusca.this_lAchouRegistro
1825:                     loc_oBusca.mAddColuna("RClis", "", "Nome")
1826:                     loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
1827:                     loc_oBusca.Show()
1828:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
1829:                         SELECT cursor_4c_BuscaConta
1830:                         loc_oPagina.txt_4c_DCONTA.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
1831:                         IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
1832:                             loc_oPagina.txt_4c_CdConta.Value = ALLTRIM(cursor_4c_BuscaConta.IClis)
1833:                         ENDIF
1834:                     ELSE
1835:                         MsgAviso("Acesso Negado...", "Aviso")
1836:                         loc_oPagina.txt_4c_DCONTA.Value = ""
1837:                         IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
1838:                             loc_oPagina.txt_4c_CdConta.Value = ""
1839:                         ENDIF
1840:                     ENDIF
1841:                 ELSE
1842:                     MsgAviso("Acesso Negado...", "Aviso")
1843:                     loc_oPagina.txt_4c_DCONTA.Value = ""
1844:                     IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
1845:                         loc_oPagina.txt_4c_CdConta.Value = ""
1846:                     ENDIF
1847:                     ENDIF
1848:                 ENDIF
1849:                 loc_oBusca.Release()
1850:             ENDIF
1851: 
1852:             IF USED("cursor_4c_BuscaConta")
1853:                 USE IN cursor_4c_BuscaConta
1854:             ENDIF
1855: 
1856:         CATCH TO loc_oErro
1857:             MsgErro("Erro ao validar descri" + CHR(231) + CHR(227) + "o Conta Corrente: " + ;
1858:                 loc_oErro.Message, "Erro")
1859:         ENDTRY
1860:     ENDPROC
1861: 
1862:     *==========================================================================
1863:     * Destroy
1864:     *==========================================================================
1865:     PROCEDURE Destroy()
1866:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1867:             THIS.this_oBusinessObject = .NULL.
1868:         ENDIF
1869: 
1870:         IF USED("cursor_4c_Dados")
1871:             USE IN cursor_4c_Dados
1872:         ENDIF
1873: 
1874:         DODEFAULT()
1875:     ENDPROC
1876: 
1877: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGACGCTBO.prg):
*==============================================================================
* SIGACGCTBO.prg - Business Object: Acesso Lancamentos
* Tabela: SigSyAgc
* PK: cIdChaves (gerada por fUniqueIds)
*==============================================================================

DEFINE CLASS SIGACGCTBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades visuais (nao persistidas - configuradas no Init)
    *--------------------------------------------------------------------------
    this_cTabela     = "SigSyAgc"
    this_cCampoChave = "cIdChaves"

    *--------------------------------------------------------------------------
    * Campos da tabela SigSyAgc
    *--------------------------------------------------------------------------
    this_cIdChaves = ""    && PK (gerada por fUniqueIds)
    this_cGrAcess  = ""    && Grupo Acesso (FK -> SigCdAcG.Grupos)
    this_cUsuAcess = ""    && Usuario Acesso (FK -> SigCdUsu.Usuarios)
    this_cGrContbs = ""    && Grupo Contabil (FK -> SigCdGcr.Codigos)
    this_cGrContas = ""    && Grupo Conta Corrente (FK -> SigCdGcr.Codigos)
    this_cCdContas = ""    && Codigo Conta Corrente (FK -> SigCdCli.Iclis)

    *--------------------------------------------------------------------------
    * Campos de exibicao (nao persistidos na tabela - preenchidos via lookup)
    *--------------------------------------------------------------------------
    this_cDGrContb   = ""  && Descricao Grupo Contabil (SigCdGcr.Descrs)
    this_cDGrConta   = ""  && Descricao Grupo Conta Corrente (SigCdGcr.Descrs)
    this_cDConta     = ""  && Descricao Conta Corrente (SigCdCli.RClis)

    *==========================================================================
    * Init
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigSyAgc"
        THIS.this_cCampoChave = "cIdChaves"
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Para auditoria (override do BusinessBase)
    *==========================================================================
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cIdChaves
    ENDPROC

    *==========================================================================
    * Buscar - Lista registros da tabela para o grid
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT cIdChaves, gracess, usuacess, grcontbs," + ;
                       " grcontas, cdcontas" + ;
                       " FROM SigSyAgc" + ;
                       " ORDER BY gracess, usuacess"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = "SELECT cIdChaves, gracess, usuacess, grcontbs," + ;
                           " grcontas, cdcontas" + ;
                           " FROM SigSyAgc" + ;
                           " WHERE gracess LIKE " + EscaparSQL("%" + par_cFiltro + "%") + ;
                           " OR usuacess LIKE " + EscaparSQL("%" + par_cFiltro + "%") + ;
                           " ORDER BY gracess, usuacess"
            ENDIF

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar acessos: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Buscar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pelo PK (cIdChaves)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT cIdChaves, gracess, usuacess, grcontbs," + ;
                       " grcontas, cdcontas" + ;
                       " FROM SigSyAgc" + ;
                       " WHERE cIdChaves = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorCodigo: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Popula propriedades a partir de um cursor
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cIdChaves = TratarNulo(cIdChaves, "C")
            THIS.this_cGrAcess  = TratarNulo(gracess,   "C")
            THIS.this_cUsuAcess = TratarNulo(usuacess,  "C")
            THIS.this_cGrContbs = TratarNulo(grcontbs,  "C")
            THIS.this_cGrContas = TratarNulo(grcontas,  "C")
            THIS.this_cCdContas = TratarNulo(cdcontas,  "C")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDescricoes - Busca descricoes dos campos de lookup
    *==========================================================================
    PROCEDURE CarregarDescricoes()
        LOCAL loc_lResultado, loc_nRes
        loc_lResultado = .T.

        TRY
            IF USED("cursor_4c_Desc")
                USE IN cursor_4c_Desc
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cGrContbs))
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT Descrs FROM SigCdGcr WHERE Codigos = " + ;
                    EscaparSQL(ALLTRIM(THIS.this_cGrContbs)), "cursor_4c_Desc")
                IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_Desc") > 0
                    SELECT cursor_4c_Desc
                    THIS.this_cDGrContb = TratarNulo(Descrs, "C")
                ELSE
                    THIS.this_cDGrContb = ""
                ENDIF
                IF USED("cursor_4c_Desc")
                    USE IN cursor_4c_Desc
                ENDIF
            ELSE
                THIS.this_cDGrContb = ""
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cGrContas))
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT Descrs FROM SigCdGcr WHERE Codigos = " + ;
                    EscaparSQL(ALLTRIM(THIS.this_cGrContas)), "cursor_4c_Desc")
                IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_Desc") > 0
                    SELECT cursor_4c_Desc
                    THIS.this_cDGrConta = TratarNulo(Descrs, "C")
                ELSE
                    THIS.this_cDGrConta = ""
                ENDIF
                IF USED("cursor_4c_Desc")
                    USE IN cursor_4c_Desc
                ENDIF
            ELSE
                THIS.this_cDGrConta = ""
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cGrContas)) AND !EMPTY(ALLTRIM(THIS.this_cCdContas))
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT RClis FROM SigCdCli" + ;
                    " WHERE Grupos = " + EscaparSQL(ALLTRIM(THIS.this_cGrContas)) + ;
                    " AND IClis = " + EscaparSQL(ALLTRIM(THIS.this_cCdContas)), ;
                    "cursor_4c_Desc")
                IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_Desc") > 0
                    SELECT cursor_4c_Desc
                    THIS.this_cDConta = TratarNulo(RClis, "C")
                ELSE
                    THIS.this_cDConta = ""
                ENDIF
                IF USED("cursor_4c_Desc")
                    USE IN cursor_4c_Desc
                ENDIF
            ELSE
                THIS.this_cDConta = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarDescricoes: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Inserir - INSERT na tabela SigSyAgc (PROTECTED - chamado pelo Salvar)
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_cPK
        loc_lResultado = .F.

        TRY
            loc_cPK = fUniqueIds()
            THIS.this_cIdChaves = loc_cPK

            loc_cSQL = "INSERT INTO SigSyAgc" + ;
                       " (cIdChaves, gracess, usuacess, grcontbs, grcontas, cdcontas)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cIdChaves) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cGrAcess))  + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cUsuAcess)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cGrContbs)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cGrContas)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCdContas)) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir acesso: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Inserir: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE na tabela SigSyAgc (PROTECTED - chamado pelo Salvar)
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigSyAgc SET" + ;
                       " gracess  = " + EscaparSQL(ALLTRIM(THIS.this_cGrAcess))  + "," + ;
                       " usuacess = " + EscaparSQL(ALLTRIM(THIS.this_cUsuAcess)) + "," + ;
                       " grcontbs = " + EscaparSQL(ALLTRIM(THIS.this_cGrContbs)) + "," + ;
                       " grcontas = " + EscaparSQL(ALLTRIM(THIS.this_cGrContas)) + "," + ;
                       " cdcontas = " + EscaparSQL(ALLTRIM(THIS.this_cCdContas)) + ;
                       " WHERE cIdChaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar acesso: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Atualizar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - DELETE na tabela SigSyAgc (PROTECTED - chamado por Excluir)
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigSyAgc" + ;
                       " WHERE cIdChaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir acesso: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ExecutarExclusao: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * VerificarDuplicidade - Verifica se ja existe registro com a mesma chave composta
    *==========================================================================
    PROCEDURE VerificarDuplicidade()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_lDuplicado
        loc_lResultado = .F.
        loc_lDuplicado = .F.

        TRY
            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF

            loc_cSQL = "SELECT cIdChaves FROM SigSyAgc" + ;
                       " WHERE GrAcess  = " + EscaparSQL(ALLTRIM(THIS.this_cGrAcess))  + ;
                       " AND   UsuAcess = " + EscaparSQL(ALLTRIM(THIS.this_cUsuAcess)) + ;
                       " AND   GrContbs = " + EscaparSQL(ALLTRIM(THIS.this_cGrContbs)) + ;
                       " AND   GrContas = " + EscaparSQL(ALLTRIM(THIS.this_cGrContas)) + ;
                       " AND   CdContas = " + EscaparSQL(ALLTRIM(THIS.this_cCdContas))

            IF !THIS.this_lNovoRegistro
                loc_cSQL = loc_cSQL + ;
                    " AND cIdChaves <> " + EscaparSQL(THIS.this_cIdChaves)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dup")

            IF loc_nResultado >= 0
                loc_lDuplicado = (RECCOUNT("cursor_4c_Dup") > 0)
            ENDIF

            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF

            loc_lResultado = loc_lDuplicado
        CATCH TO loc_oErro
            MsgErro("Erro em VerificarDuplicidade: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

