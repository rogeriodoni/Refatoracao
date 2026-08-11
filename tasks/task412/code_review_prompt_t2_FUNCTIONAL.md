# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormFAPF.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (808 linhas total):

*-- Linhas 25 a 114:
25:     this_oBusinessObject = .NULL.
26: 
27:     *==========================================================================
28:     PROCEDURE Init()
29:     *==========================================================================
30:         RETURN DODEFAULT()
31:     ENDPROC
32: 
33:     *==========================================================================
34:     * InicializarForm - Chamado por FormBase.Init via DODEFAULT
35:     *==========================================================================
36:     PROTECTED PROCEDURE InicializarForm()
37:         LOCAL loc_lSucesso, loc_oErro
38:         loc_lSucesso = .F.
39: 
40:         TRY
41:             THIS.this_oBusinessObject = CREATEOBJECT("FAPFBO")
42: 
43:             IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
44:                 IF gnConnHandle <= 0
45:                     MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
46:                             "o Com o Servidor de Banco de Dados...", ;
47:                             "Conex" + CHR(227) + "o")
48:                     loc_lSucesso = .F.
49:                 ENDIF
50:             ENDIF
51: 
52:             THIS.ConfigurarPageFrame()
53:             THIS.ConfigurarPaginaLista()
54:             THIS.TornarControlesVisiveis()
55:             THIS.ConfigurarBINDEVENTs()
56:             THIS.CarregarLista()
57:             loc_lSucesso = .T.
58: 
59:         CATCH TO loc_oErro
60:             MsgErro(loc_oErro.Message + CHR(13) + ;
61:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
62:                 "Procedure: " + loc_oErro.Procedure, ;
63:                 "Erro InicializarForm")
64:         ENDTRY
65: 
66:         RETURN loc_lSucesso
67:     ENDPROC
68: 
69:     *==========================================================================
70:     * ConfigurarPageFrame - Constroi o cabecalho cinza superior do form
71:     * Forms OPERACIONAIS nao usam PageFrame CRUD - o cabecalho e um container
72:     * direto no form, equivalente ao cntSombra do framework legado
73:     *==========================================================================
74:     PROTECTED PROCEDURE ConfigurarPageFrame()
75:         LOCAL loc_oErro
76: 
77:         TRY
78:             THIS.AddObject("cnt_4c_Sombra", "Container")
79:             WITH THIS.cnt_4c_Sombra
80:                 .Top         = 0
81:                 .Left        = 0
82:                 .Width       = THIS.Width
83:                 .Height      = 80
84:                 .BackColor   = RGB(100, 100, 100)
85:                 .BackStyle   = 1
86:                 .BorderWidth = 0
87: 
88:                 .AddObject("lbl_4c_LblSombra", "Label")
89:                 WITH .lbl_4c_LblSombra
90:                     .Top       = 18
91:                     .Left      = 10
92:                     .Width     = THIS.Width
93:                     .Height    = 40
94:                     .FontBold  = .T.
95:                     .FontName  = "Tahoma"
96:                     .FontSize  = 16
97:                     .AutoSize  = .F.
98:                     .BackStyle = 0
99:                     .WordWrap  = .T.
100:                     .Alignment = 0
101:                     .ForeColor = RGB(0, 0, 0)
102:                     .Caption   = "FAPF"
103:                 ENDWITH
104: 
105:                 .AddObject("lbl_4c_LblTitulo", "Label")
106:                 WITH .lbl_4c_LblTitulo
107:                     .Top       = 17
108:                     .Left      = 10
109:                     .Width     = THIS.Width
110:                     .Height    = 46
111:                     .FontBold  = .T.
112:                     .FontName  = "Tahoma"
113:                     .FontSize  = 16
114:                     .AutoSize  = .F.

*-- Linhas 125 a 336:
125:         CATCH TO loc_oErro
126:             MsgErro(loc_oErro.Message + CHR(13) + ;
127:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
128:                 "Procedure: " + loc_oErro.Procedure, ;
129:                 "Erro ConfigurarPageFrame")
130:         ENDTRY
131:     ENDPROC
132: 
133:     *==========================================================================
134:     * ConfigurarPaginaLista - Constroi os controles principais do form OPERACIONAL
135:     * Para forms OPERACIONAIS, este metodo unifica a configuracao dos elementos
136:     * da area de conteudo (botoes de acao e campos de entrada)
137:     *==========================================================================
138:     PROTECTED PROCEDURE ConfigurarPaginaLista()
139:         LOCAL loc_oErro
140: 
141:         TRY
142:             THIS.ConfigurarBotoesAcao()
143:             THIS.ConfigurarBotoesCRUD()
144:             THIS.ConfigurarGrade()
145:             THIS.ConfigurarPaginaDados()
146:         CATCH TO loc_oErro
147:             MsgErro(loc_oErro.Message + CHR(13) + ;
148:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
149:                 "Procedure: " + loc_oErro.Procedure, ;
150:                 "Erro ConfigurarPaginaLista")
151:         ENDTRY
152:     ENDPROC
153: 
154:     *==========================================================================
155:     * ConfigurarBotoesAcao - Cria o container canonico de saida (Encerrar)
156:     * Padrao canonico: cnt_4c_Saida.Left=917 (adaptado para Width=718: Left=638)
157:     * cmd_4c_Encerrar: Left=5, Top=5, Width=75, Height=75, Caption="Encerrar"
158:     *==========================================================================
159:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
160:         LOCAL loc_oErro
161: 
162:         TRY
163:             THIS.AddObject("cnt_4c_Saida", "Container")
164:             WITH THIS.cnt_4c_Saida
165:                 .Top         = 5
166:                 .Left        = 917
167:                 .Width       = 90
168:                 .Height      = 85
169:                 .BackStyle   = 0
170:                 .BorderWidth = 0
171: 
172:                 .AddObject("cmd_4c_Encerrar", "CommandButton")
173:                 WITH .cmd_4c_Encerrar
174:                     .Top             = 5
175:                     .Left            = 917
176:                     .Width           = 90
177:                     .Height          = 75
178:                     .Caption         = "Encerrar"
179:                     .FontBold        = .T.
180:                     .FontItalic      = .T.
181:                     .FontName        = "Tahoma"
182:                     .FontSize        = 8
183:                     .WordWrap        = .T.
184:                     .ForeColor       = RGB(90, 90, 90)
185:                     .BackColor       = RGB(255, 255, 255)
186:                     .SpecialEffect   = 0
187:                     .MousePointer    = 15
188:                     .PicturePosition = 13
189:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
190:                 ENDWITH
191:             ENDWITH
192: 
193:         CATCH TO loc_oErro
194:             MsgErro(loc_oErro.Message + CHR(13) + ;
195:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
196:                 "Procedure: " + loc_oErro.Procedure, ;
197:                 "Erro ConfigurarBotoesAcao")
198:         ENDTRY
199:     ENDPROC
200: 
201:     *==========================================================================
202:     * TornarControlesVisiveis - Torna visiveis os controles de nivel raiz do form
203:     * cnt_4c_Sombra ja tem Visible=.T. definido em ConfigurarPageFrame
204:     *==========================================================================
205:     PROTECTED PROCEDURE TornarControlesVisiveis()
206:         LOCAL loc_oErro
207: 
208:         TRY
209:             THIS.TornarVisivelRecursivo(THIS)
210: 
211:         CATCH TO loc_oErro
212:             MsgErro(loc_oErro.Message + CHR(13) + ;
213:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
214:                 "Procedure: " + loc_oErro.Procedure, ;
215:                 "Erro TornarControlesVisiveis")
216:         ENDTRY
217:     ENDPROC
218: 
219:     *==========================================================================
220:     * TornarVisivelRecursivo - Percorre container recursivamente tornando visiveis
221:     *==========================================================================
222:     PROTECTED PROCEDURE TornarVisivelRecursivo(par_oContainer)
223:         LOCAL loc_i, loc_oCtrl
224:         FOR loc_i = 1 TO par_oContainer.ControlCount
225:             loc_oCtrl = par_oContainer.Controls(loc_i)
226:             IF VARTYPE(loc_oCtrl) = "O"
227:                 *-- Pular containers com visibilidade controlada explicitamente; recursar filhos apenas
228:                 IF INLIST(UPPER(loc_oCtrl.Name), "CNT_4C_PAINELDADOS", "CNT_4C_SOMBRA")
229:                     IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND ;
230:                        loc_oCtrl.ControlCount > 0
231:                         THIS.TornarVisivelRecursivo(loc_oCtrl)
232:                     ENDIF
233:                     LOOP
234:                 ENDIF
235:                 IF PEMSTATUS(loc_oCtrl, "Visible", 5)
236:                     loc_oCtrl.Visible = .T.
237:                 ENDIF
238:                 IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND ;
239:                    loc_oCtrl.ControlCount > 0
240:                     THIS.TornarVisivelRecursivo(loc_oCtrl)
241:                 ENDIF
242:             ENDIF
243:         ENDFOR
244:     ENDPROC
245: 
246:     *==========================================================================
247:     * ConfigurarBINDEVENTs - Vincula o evento do botao Encerrar
248:     * Eventos dos campos de entrada serao vinculados nas fases de conteudo
249:     *==========================================================================
250:     PROTECTED PROCEDURE ConfigurarBINDEVENTs()
251:         LOCAL loc_oErro
252: 
253:         TRY
254:             BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
255:             BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
256:             BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
257:             BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
258:             BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
259:             BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
260:             BINDEVENT(THIS.cnt_4c_PainelDados.cnt_4c_BotoesDados.cmd_4c_Confirmar, ;
261:                       "Click", THIS, "BtnConfirmarClick")
262:             BINDEVENT(THIS.cnt_4c_PainelDados.cnt_4c_BotoesDados.cmd_4c_Cancelar, ;
263:                       "Click", THIS, "BtnCancelarClick")
264: 
265:         CATCH TO loc_oErro
266:             MsgErro(loc_oErro.Message + CHR(13) + ;
267:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
268:                 "Procedure: " + loc_oErro.Procedure, ;
269:                 "Erro ConfigurarBINDEVENTs")
270:         ENDTRY
271:     ENDPROC
272: 
273:     *==========================================================================
274:     * BtnEncerrarClick - Encerra o formulario
275:     *==========================================================================
276:     PROCEDURE BtnEncerrarClick()
277:         THIS.Release()
278:     ENDPROC
279: 
280:     *==========================================================================
281:     PROCEDURE Destroy()
282:     *==========================================================================
283:         IF USED("cursor_4c_Dados")
284:             USE IN cursor_4c_Dados
285:         ENDIF
286:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
287:             THIS.this_oBusinessObject = .NULL.
288:         ENDIF
289:         DODEFAULT()
290:     ENDPROC
291: 
292:     *==========================================================================
293:     * ConfigurarBotoesCRUD - Cria container com os 5 botoes de operacao CRUD
294:     * Posicionado no cabecalho, a esquerda do cnt_4c_Saida
295:     *==========================================================================
296:     PROTECTED PROCEDURE ConfigurarBotoesCRUD()
297:         LOCAL loc_oErro
298: 
299:         TRY
300:             THIS.AddObject("cnt_4c_Botoes", "Container")
301:             WITH THIS.cnt_4c_Botoes
302:                 .Top         = 5
303:                 .Left        = THIS.Width - 85 - 390 - 5
304:                 .Width       = 390
305:                 .Height      = 85
306:                 .BackStyle   = 0
307:                 .BorderWidth = 0
308:                 .AddObject("cmd_4c_Incluir",    "CommandButton")
309:                 .AddObject("cmd_4c_Visualizar", "CommandButton")
310:                 .AddObject("cmd_4c_Alterar",    "CommandButton")
311:                 .AddObject("cmd_4c_Excluir",    "CommandButton")
312:                 .AddObject("cmd_4c_Buscar",     "CommandButton")
313:                 .Visible     = .T.
314:             ENDWITH
315: 
316:             WITH THIS.cnt_4c_Botoes.cmd_4c_Incluir
317:                 .Top             = 5
318:                 .Left            = 5
319:                 .Width           = 75
320:                 .Height          = 75
321:                 .Caption         = "Incluir"
322:                 .FontBold        = .T.
323:                 .FontItalic      = .T.
324:                 .FontName        = "Tahoma"
325:                 .FontSize        = 8
326:                 .WordWrap        = .T.
327:                 .ForeColor       = RGB(90, 90, 90)
328:                 .BackColor       = RGB(255, 255, 255)
329:                 .SpecialEffect   = 0
330:                 .Themes          = .F.
331:                 .MousePointer    = 15
332:                 .PicturePosition = 13
333:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
334:             ENDWITH
335: 
336:             WITH THIS.cnt_4c_Botoes.cmd_4c_Visualizar

*-- Linhas 419 a 740:
419:         CATCH TO loc_oErro
420:             MsgErro(loc_oErro.Message + CHR(13) + ;
421:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
422:                 "Procedure: " + loc_oErro.Procedure, ;
423:                 "Erro ConfigurarBotoesCRUD")
424:         ENDTRY
425:     ENDPROC
426: 
427:     *==========================================================================
428:     * ConfigurarGrade - Cria o grid de exibicao de registros com cursor vazio
429:     *==========================================================================
430:     PROTECTED PROCEDURE ConfigurarGrade()
431:         LOCAL loc_oErro
432: 
433:         TRY
434:             SET NULL ON
435:             CREATE CURSOR cursor_4c_Dados (Codigo C(20) NULL, Descricao C(60) NULL)
436:             SET NULL OFF
437: 
438:             THIS.AddObject("grd_4c_Lista", "Grid")
439:             WITH THIS.grd_4c_Lista
440:                 .Top                = 95
441:                 .Left               = 5
442:                 .Width              = THIS.Width - 10
443:                 .Height             = THIS.Height - 100
444:                 .FontName           = "Verdana"
445:                 .FontSize           = 8
446:                 .ForeColor          = RGB(90, 90, 90)
447:                 .BackColor          = RGB(255, 255, 255)
448:                 .GridLineColor      = RGB(238, 238, 238)
449:                 .HighlightBackColor = RGB(255, 255, 255)
450:                 .HighlightForeColor = RGB(15, 41, 104)
451:                 .HighlightStyle     = 2
452:                 .DeleteMark         = .F.
453:                 .RecordMark         = .F.
454:                 .ScrollBars         = 2
455:                 .RowHeight          = 16
456:             ENDWITH
457:             THIS.grd_4c_Lista.ColumnCount              = 2
458:             THIS.grd_4c_Lista.RecordSource              = "cursor_4c_Dados"
459:             THIS.grd_4c_Lista.Column1.ControlSource     = "cursor_4c_Dados.Codigo"
460:             THIS.grd_4c_Lista.Column1.Width              = 150
461:             THIS.grd_4c_Lista.Column1.Header1.Caption   = "C" + CHR(243) + "digo"
462:             THIS.grd_4c_Lista.Column2.ControlSource     = "cursor_4c_Dados.Descricao"
463:             THIS.grd_4c_Lista.Column2.Width              = THIS.Width - 10 - 150 - 5
464:             THIS.grd_4c_Lista.Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
465: 
466:         CATCH TO loc_oErro
467:             MsgErro(loc_oErro.Message + CHR(13) + ;
468:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
469:                 "Procedure: " + loc_oErro.Procedure, ;
470:                 "Erro ConfigurarGrade")
471:         ENDTRY
472:     ENDPROC
473: 
474:     *==========================================================================
475:     * CarregarLista - Carrega/recarrega dados no grid principal
476:     * Form operacional sem tabela propria - cursor permanece vazio por padrao
477:     *==========================================================================
478:     PROCEDURE CarregarLista()
479:         LOCAL loc_oErro
480: 
481:         TRY
482:             IF USED("cursor_4c_Dados")
483:                 SELECT cursor_4c_Dados
484:                 ZAP
485:             ELSE
486:                 SET NULL ON
487:                 CREATE CURSOR cursor_4c_Dados (Codigo C(20) NULL, Descricao C(60) NULL)
488:                 SET NULL OFF
489:             ENDIF
490: 
491:             IF VARTYPE(THIS.grd_4c_Lista) = "O"
492:                 THIS.grd_4c_Lista.ColumnCount                 = 2
493:                 THIS.grd_4c_Lista.RecordSource                = "cursor_4c_Dados"
494:                 THIS.grd_4c_Lista.Column1.ControlSource       = "cursor_4c_Dados.Codigo"
495:                 THIS.grd_4c_Lista.Column2.ControlSource       = "cursor_4c_Dados.Descricao"
496:                 THIS.grd_4c_Lista.Column1.Header1.Caption     = "C" + CHR(243) + "digo"
497:                 THIS.grd_4c_Lista.Column2.Header1.Caption     = ;
498:                     "Descri" + CHR(231) + CHR(227) + "o"
499:             ENDIF
500: 
501:             THIS.AlternarPagina(1)
502: 
503:         CATCH TO loc_oErro
504:             MsgErro(loc_oErro.Message + CHR(13) + ;
505:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
506:                 "Procedure: " + loc_oErro.Procedure, ;
507:                 "Erro CarregarLista")
508:         ENDTRY
509:     ENDPROC
510: 
511:     *==========================================================================
512:     * AlternarPagina - Alterna entre modo Lista (1) e modo Dados (2)
513:     * Ajusta estado dos botoes CRUD conforme modo corrente
514:     *==========================================================================
515:     PROCEDURE AlternarPagina(par_nPagina)
516:         LOCAL loc_lTemRegistro
517: 
518:         IF VARTYPE(THIS.cnt_4c_Botoes) != "O"
519:             RETURN
520:         ENDIF
521: 
522:         loc_lTemRegistro = USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
523: 
524:         IF par_nPagina = 1
525:             *-- Modo Lista: exibe grid, oculta painel de dados
526:             IF VARTYPE(THIS.grd_4c_Lista) = "O"
527:                 THIS.grd_4c_Lista.Visible = .T.
528:             ENDIF
529:             IF VARTYPE(THIS.cnt_4c_PainelDados) = "O"
530:                 THIS.cnt_4c_PainelDados.Visible = .F.
531:             ENDIF
532:             THIS.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = .T.
533:             THIS.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
534:             THIS.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lTemRegistro
535:             THIS.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lTemRegistro
536:             THIS.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = .T.
537:         ELSE
538:             *-- Modo Dados: oculta grid, exibe painel de dados
539:             IF VARTYPE(THIS.grd_4c_Lista) = "O"
540:                 THIS.grd_4c_Lista.Visible = .F.
541:             ENDIF
542:             IF VARTYPE(THIS.cnt_4c_PainelDados) = "O"
543:                 THIS.cnt_4c_PainelDados.Visible = .T.
544:             ENDIF
545:             THIS.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = .F.
546:             THIS.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = .F.
547:             THIS.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = .F.
548:             THIS.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = .F.
549:             THIS.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = .F.
550:         ENDIF
551:     ENDPROC
552: 
553:     *==========================================================================
554:     * BtnIncluirClick - Inicia inclusao de novo registro
555:     *==========================================================================
556:     PROCEDURE BtnIncluirClick()
557:         THIS.this_oBusinessObject.NovoRegistro()
558:         THIS.BOParaForm()
559:         THIS.HabilitarCampos(.T.)
560:         THIS.AlternarPagina(2)
561:     ENDPROC
562: 
563:     *==========================================================================
564:     * BtnVisualizarClick - Exibe registro selecionado para visualizacao
565:     *==========================================================================
566:     PROCEDURE BtnVisualizarClick()
567:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
568:             MsgAviso("Selecione um registro para visualizar.", "Visualizar")
569:             RETURN
570:         ENDIF
571:         THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Dados")
572:         THIS.BOParaForm()
573:         THIS.HabilitarCampos(.F.)
574:         THIS.AlternarPagina(2)
575:     ENDPROC
576: 
577:     *==========================================================================
578:     * BtnAlterarClick - Inicia alteracao do registro selecionado
579:     *==========================================================================
580:     PROCEDURE BtnAlterarClick()
581:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
582:             MsgAviso("Selecione um registro para alterar.", "Alterar")
583:             RETURN
584:         ENDIF
585:         THIS.this_oBusinessObject.EditarRegistro()
586:         THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Dados")
587:         THIS.BOParaForm()
588:         THIS.HabilitarCampos(.T.)
589:         THIS.AlternarPagina(2)
590:     ENDPROC
591: 
592:     *==========================================================================
593:     * BtnExcluirClick - Exclui o registro selecionado
594:     *==========================================================================
595:     PROCEDURE BtnExcluirClick()
596:         LOCAL loc_lResultado
597: 
598:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
599:             MsgAviso("Selecione um registro para excluir.", "Excluir")
600:             RETURN
601:         ENDIF
602: 
603:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro selecionado?", ;
604:                 "Excluir")
605:             RETURN
606:         ENDIF
607: 
608:         loc_lResultado = THIS.this_oBusinessObject.Excluir()
609: 
610:         IF loc_lResultado
611:             MsgInfo("Registro exclu" + CHR(237) + "do com sucesso.", "Excluir")
612:             THIS.CarregarLista()
613:         ELSE
614:             IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
615:                 MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Excluir")
616:             ELSE
617:                 MsgErro("Erro ao excluir o registro.", "Excluir")
618:             ENDIF
619:         ENDIF
620:     ENDPROC
621: 
622:     *==========================================================================
623:     * BtnBuscarClick - Recarrega a lista de registros
624:     *==========================================================================
625:     PROCEDURE BtnBuscarClick()
626:         THIS.CarregarLista()
627:     ENDPROC
628: 
629:     *==========================================================================
630:     * BtnConfirmarClick - Salva o registro em edicao/inclusao
631:     *==========================================================================
632:     PROCEDURE BtnConfirmarClick()
633:         LOCAL loc_lResultado
634: 
635:         THIS.FormParaBO()
636:         loc_lResultado = THIS.this_oBusinessObject.Salvar()
637: 
638:         IF loc_lResultado
639:             MsgInfo("Registro salvo com sucesso.", "Confirmar")
640:             THIS.CarregarLista()
641:         ELSE
642:             IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
643:                 MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Confirmar")
644:             ELSE
645:                 MsgErro("Erro ao salvar o registro.", "Confirmar")
646:             ENDIF
647:         ENDIF
648:     ENDPROC
649: 
650:     *==========================================================================
651:     * BtnSalvarClick - Alias para BtnConfirmarClick (compatibilidade)
652:     *==========================================================================
653:     PROCEDURE BtnSalvarClick()
654:         THIS.BtnConfirmarClick()
655:     ENDPROC
656: 
657:     *==========================================================================
658:     * BtnCancelarClick - Cancela edicao e volta para a lista
659:     *==========================================================================
660:     PROCEDURE BtnCancelarClick()
661:         IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
662:            THIS.this_oBusinessObject.this_lEmEdicao
663:             THIS.this_oBusinessObject.Cancelar()
664:         ENDIF
665:         THIS.CarregarLista()
666:     ENDPROC
667: 
668:     *==========================================================================
669:     * FormParaBO - Transfere valores dos campos para o Business Object
670:     * Form sem campos - nenhum mapeamento necessario
671:     *==========================================================================
672:     PROCEDURE FormParaBO()
673:         RETURN .T.
674:     ENDPROC
675: 
676:     *==========================================================================
677:     * BOParaForm - Transfere valores do Business Object para os campos
678:     * Form sem campos - nenhum mapeamento necessario
679:     *==========================================================================
680:     PROCEDURE BOParaForm()
681:         RETURN .T.
682:     ENDPROC
683: 
684:     *==========================================================================
685:     * HabilitarCampos - Habilita ou desabilita campos de entrada
686:     * par_lHabilitar: .T. = editavel, .F. = somente leitura (modo visualizar)
687:     * Form sem campos - controla apenas botao Confirmar
688:     *==========================================================================
689:     PROCEDURE HabilitarCampos(par_lHabilitar)
690:         IF VARTYPE(THIS.cnt_4c_PainelDados) = "O"
691:             THIS.cnt_4c_PainelDados.cnt_4c_BotoesDados.cmd_4c_Confirmar.Enabled = ;
692:                 par_lHabilitar
693:         ENDIF
694:     ENDPROC
695: 
696:     *==========================================================================
697:     * ConfigurarPaginaDados - Cria o painel de dados (Page2 do form OPERACIONAL)
698:     * Form sem campos proprios: apenas container com botoes Confirmar/Cancelar
699:     *==========================================================================
700:     PROTECTED PROCEDURE ConfigurarPaginaDados()
701:         LOCAL loc_oErro
702: 
703:         TRY
704:             THIS.AddObject("cnt_4c_PainelDados", "Container")
705:             WITH THIS.cnt_4c_PainelDados
706:                 .Top         = 95
707:                 .Left        = 0
708:                 .Width       = THIS.Width
709:                 .Height      = THIS.Height - 95
710:                 .BackStyle   = 1
711:                 .BackColor   = RGB(255, 255, 255)
712:                 .BorderWidth = 0
713: 
714:                 .AddObject("cnt_4c_BotoesDados", "Container")
715:                 .Visible     = .T.
716:             ENDWITH
717: 
718:             WITH THIS.cnt_4c_PainelDados.cnt_4c_BotoesDados
719:                 .Top         = THIS.Height - 185
720:                 .Left        = THIS.Width - 170
721:                 .Width       = 165
722:                 .Height      = 85
723:                 .BackStyle   = 0
724:                 .BorderWidth = 0
725: 
726:                 .AddObject("cmd_4c_Confirmar", "CommandButton")
727:                 .AddObject("cmd_4c_Cancelar",  "CommandButton")
728:                 .Visible     = .T.
729:             ENDWITH
730: 
731:             WITH THIS.cnt_4c_PainelDados.cnt_4c_BotoesDados.cmd_4c_Confirmar
732:                 .Top             = 5
733:                 .Left            = 5
734:                 .Width           = 75
735:                 .Height          = 75
736:                 .Caption         = "Confirmar"
737:                 .FontBold        = .T.
738:                 .FontItalic      = .T.
739:                 .FontName        = "Tahoma"
740:                 .FontSize        = 8

*-- Linhas 771 a 808:
771:         CATCH TO loc_oErro
772:             MsgErro(loc_oErro.Message + CHR(13) + ;
773:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
774:                 "Procedure: " + loc_oErro.Procedure, ;
775:                 "Erro ConfigurarPaginaDados")
776:         ENDTRY
777:     ENDPROC
778: 
779:     *==========================================================================
780:     * LimparCampos - Limpa campos de entrada e redefine estado do cursor
781:     * Form sem campos proprios: zera cursor de dados e ajusta botoes
782:     *==========================================================================
783:     PROCEDURE LimparCampos()
784:         IF USED("cursor_4c_Dados")
785:             SELECT cursor_4c_Dados
786:             ZAP
787:         ENDIF
788:         THIS.AjustarBotoesPorModo()
789:     ENDPROC
790: 
791:     *==========================================================================
792:     * AjustarBotoesPorModo - Ajusta estado dos botoes CRUD conforme dados
793:     * Habilitado/Desabilitado conforme existencia de registros no cursor
794:     *==========================================================================
795:     PROCEDURE AjustarBotoesPorModo()
796:         LOCAL loc_lTemRegistro
797:         IF VARTYPE(THIS.cnt_4c_Botoes) != "O"
798:             RETURN
799:         ENDIF
800:         loc_lTemRegistro = USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
801:         THIS.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = .T.
802:         THIS.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
803:         THIS.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lTemRegistro
804:         THIS.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lTemRegistro
805:         THIS.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = .T.
806:     ENDPROC
807: 
808: ENDDEFINE


### BO (C:\4c\projeto\app\classes\FAPFBO.prg):
*====================================================================
* FAPFBO.prg
*
* Business Object para FAPF
* Form OPERACIONAL - formulario sem tabela propria no banco
*====================================================================

DEFINE CLASS FAPFBO AS BusinessBase

	*-- Identificacao da entidade (sem tabela propria - form operacional)
	this_cTabela      = ""
	this_cCampoChave  = ""

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()

		THIS.this_cTabela     = ""
		THIS.this_cCampoChave = ""

		RETURN .T.
	ENDPROC

	*====================================================================
	* ValidarDados - Valida dados antes de salvar
	* Form operacional sem campos - sempre valido
	*====================================================================
	PROTECTED PROCEDURE ValidarDados()
		RETURN .T.
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Carrega dados do cursor para propriedades
	* Sem campos mapeados neste form operacional
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lResultado, loc_oErro
		loc_lResultado = .F.

		TRY
			IF !USED(par_cAliasCursor)
				loc_lResultado = .F.
			ENDIF

			SELECT (par_cAliasCursor)
			loc_lResultado = .T.

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, ;
				"Erro em CarregarDoCursor")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* Inserir - Insere novo registro
	* Form operacional sem tabela - sem persistencia SQL
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_lResultado, loc_oErro
		loc_lResultado = .F.

		TRY
			*-- Form operacional sem tabela propria
			*-- Registra auditoria da operacao (padrao arquitetural)
			THIS.RegistrarAuditoria("INSERT")
			loc_lResultado = .T.

		CATCH TO loc_oErro
			THIS.this_cMensagemErro = "Erro ao inserir: " + loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* Atualizar - Atualiza registro existente
	* Form operacional sem tabela - sem persistencia SQL
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_lResultado, loc_oErro
		loc_lResultado = .F.

		TRY
			*-- Form operacional sem tabela propria
			*-- Registra auditoria da operacao (padrao arquitetural)
			THIS.RegistrarAuditoria("UPDATE")
			loc_lResultado = .T.

		CATCH TO loc_oErro
			THIS.this_cMensagemErro = "Erro ao atualizar: " + loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ExecutarExclusao - Executa exclusao de registro
	* Form operacional sem tabela - sem persistencia SQL
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_lResultado, loc_oErro
		loc_lResultado = .F.

		TRY
			*-- Form operacional sem tabela propria
			THIS.RegistrarAuditoria("DELETE")
			loc_lResultado = .T.

		CATCH TO loc_oErro
			THIS.this_cMensagemErro = "Erro ao excluir: " + loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	* Sem chave primaria neste form operacional
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ""
	ENDPROC

ENDDEFINE

